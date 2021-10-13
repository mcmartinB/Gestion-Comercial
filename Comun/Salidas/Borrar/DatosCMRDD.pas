unit DatosCMRDD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDDDatosCMR = class(TDataModule)
    qryCabCMR: TQuery;
    qryAux: TQuery;
    QDetallesCMR: TQuery;
  private
    { Private declarations }
    sEmpresa, sCentro, sCliente, sDirSum, sNumAlbaran, sCodAlbaran: string;
    iAlbaran: integer;
    dFecha: TDateTime;
    bPedirFirma: Boolean;

    function  AddNota: string;
    procedure definirDetallesCMRInyeccion;
    function  GetFirmaCMR: string;
    function  GetPesoEnvases(const ACajas, AEnvase: string): Extended;
    function  GetPesoPalets(const APalets, APalet: string): Extended;

    procedure DireccionCentroCMR( const AEmpresa, ACentro: string;
                                  var ADireccion: TStringList; var APais, APoblacion: string );
  public
    { Public declarations }
    procedure LoadParams( const AEmpresa, ACentro: string; const AAlbaran: integer;
                               const AFecha: TDateTime; const APedirFirma: boolean );
    procedure PreCMRInyeccion;
  end;

  procedure PreCMRInyeccion( const AOwner: TComponent; const AEmpresa, ACentro: string; const AAlbaran: integer;
                             const AFecha: TDateTime; const APedirFirma: boolean );

implementation

uses
  DatosCMRFD, LCMRInyeccion, UDMAuxDB, CVariables, Dialogs, DError, bTextUtils, bMath;

{$R *.dfm}

var
  DDatosCMR: TDDDatosCMR;

procedure PreCMRInyeccion( const AOwner: TComponent; const AEmpresa, ACentro: string; const AAlbaran: integer;
                           const AFecha: TDateTime; const APedirFirma: boolean );
begin
  DDatosCMR:= TDDDatosCMR.Create( AOwner );
  try
    DDatosCMR.LoadParams( AEmpresa, ACentro, AAlbaran, AFecha, APedirFirma );
    DDatosCMR.PreCMRInyeccion;
  finally
    FreeAndNil( DDatosCMR );
  end;
end;

procedure TDDDatosCMR.LoadParams( const AEmpresa, ACentro: string; const AAlbaran: integer;
                               const AFecha: TDateTime; const APedirFirma: boolean );
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  //sCliente,
  //sDirSum:
  iAlbaran:= AAlbaran;
  sNumAlbaran:= IntToStr( iAlbaran );
  dFecha:= AFecha;
  bPedirFirma:= APedirFirma;
end;

procedure TDDDatosCMR.DireccionCentroCMR( const AEmpresa, ACentro: string;
                             var ADireccion: TStringList; var APais, APoblacion: string );
var
  sAux: string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select case when empresa_e[1,1] = ''F'' then ''BONNYSA AGROALIMENTARIA'' else nombre_e end nombre_e, nif_e, ');
    SQL.Add('       descripcion_c, direccion_c, poblacion_c, cod_postal_c, descripcion_p ');
    SQL.Add('from frf_empresas, frf_centros, frf_paises  ');
    SQL.Add('where empresa_e = :empresa ');
    SQL.Add('and empresa_c = :empresa ');
    SQL.Add('and centro_c = :centro ');
    SQL.Add('and pais_p = pais_c');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    Open;

    ADireccion.Add( FieldByName('nombre_e').AsString + '  -  CIF: ' + FieldByName('nif_e').AsString);
    ADireccion.Add( FieldByName('descripcion_c').AsString);
    ADireccion.Add( FieldByName('direccion_c').AsString);
    sAux:= desProvincia( FieldByName('cod_postal_c').AsString );
    if sAux <> '' then
      ADireccion.Add( FieldByName('cod_postal_c').AsString + ' ' + FieldByName('poblacion_c').AsString +  '(' +  sAux + ')' )
    else
      ADireccion.Add( FieldByName('cod_postal_c').AsString + ' ' + FieldByName('poblacion_c').AsString );
    ADireccion.Add( APais );

    APoblacion:= FieldByName('poblacion_c').AsString;
    APais := FieldByName('descripcion_p').AsString;

    Close;
  end;
end;

procedure TDDDatosCMR.PreCMRInyeccion;
var
  slRemitente, slOrigen, slConsignatario, slEntrega, slAux : TStringList;
   sTransportista, sNomCliente, sNomSuminstro: string;
   sPais, sPoblacion: string;
begin
  // Previsualización del segundo Informe para Salidas...
  with qryCabCMR do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('SELECT empresa_sc,centro_salida_sc,n_albaran_sc,' +
      ' fecha_sc,transporte_sc, vehiculo_sc, higiene_sc, cliente_c,nombre_c,tipo_via_c,domicilio_c,' +
      ' poblacion_c,cod_postal_c,pais_p, ' +
      ' case when nvl(original_name_p,'''') <> '''' then original_name_p else descripcion_p end descripcion_p, ' +
      ' dir_sum_ds, nombre_ds,tipo_via_ds,domicilio_ds,cod_postal_ds, provincia_ds, poblacion_ds, nif_c ');

    SQL.Add('FROM frf_salidas_c Frf_salidas_c, frf_clientes ' +
      'Frf_clientes, OUTER frf_dir_sum Frf_dir_sum, ' +
      'frf_paises Frf_paises ' +
      'WHERE (empresa_sc     = empresa_c) ' +
      'And   (cliente_sal_sc = cliente_c) ' +
      'And   (pais_c         = pais_p) ' +
      'And   (empresa_sc     = empresa_ds) ' +
      'And   (cliente_sal_sc = cliente_ds) ' +
      'And   (dir_sum_sc     = dir_sum_ds) ');
    SQL.Add('And   (empresa_sc = :empresa ) ' +
      'And   (centro_salida_sc = :centro ) ' +
      'And   (n_albaran_sc = :albaran ) ' +
      'And   (fecha_sc = :fecha ) ');

    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    ParamByName('albaran').AsInteger := iAlbaran;
    ParamByName('fecha').Asdatetime := dFecha;
    Open;

    sCliente:= fieldByName('cliente_c').AsString;
    if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( sCliente <> 'ECI' ) then
    begin
      sCodAlbaran := sEmpresa + sCentro + Rellena( sNumAlbaran, 5, '0', taLeftJustify ) + Coletilla( sEmpresa );
    end
    else
    begin
      sCodAlbaran := sNumAlbaran;
    end;
    sNomCliente:= fieldByName('nombre_c').AsString;
    sDirSum:= fieldByName('dir_sum_ds').AsString;
    if sDirSum = '' then
      sDirSum:= sCliente;
    sNomSuminstro:= fieldByName('nombre_ds').AsString;
    if sNomSuminstro = '' then
      sNomSuminstro:= sNomCliente;
    sTransportista:= fieldByName('transporte_sc').AsString;

    // Definición de la dirección de Suministro de la Carta de Transporte...( C.M.R.)
    try
      QRLCMRInyeccion := TQRLCMRInyeccion.Create( Self );

      QRLCMRInyeccion.qrlblFecha.Caption:= FieldByName('fecha_sc').AsString;
      QRLCMRInyeccion.qrlblFecha2.Caption:= FieldByName('fecha_sc').AsString;

      QRLCMRInyeccion.sFirma:= GetFirmaCMR(  );
      QRLCMRInyeccion.dirSuministro.Lines.Clear;

      if Trim(fieldByName('nif_c').AsString) <> '' then
      begin
        if fieldByName('pais_p').AsString = 'ES' then
          QRLCMRInyeccion.dirSuministro.Lines.Add( sNomCliente + ' (CIF: ' + fieldByName('nif_c').AsString + ')')
        else
          QRLCMRInyeccion.dirSuministro.Lines.Add( sNomCliente + ' (VAT: ' + fieldByName('nif_c').AsString + ')' );
      end
      else
      begin
        QRLCMRInyeccion.dirSuministro.Lines.Add( sNomCliente );
      end;


      if (((Trim(sDirSum) = Trim(sCliente)) or (Trim(sDirSum) = ''))) or
         ( ( Trim(sCliente) = 'GL') and ( ( Trim(sDirSum) = '010') or ( Trim(sDirSum) = '009') ) )then
      begin
        QRLCMRInyeccion.dirSuministro.Lines.Add(FieldByName('tipo_via_c').AsString + ' ' +
          FieldByName('domicilio_c').AsString);
        QRLCMRInyeccion.dirSuministro.Lines.Add(Trim(FieldByName('cod_postal_c').AsString + ' ' +
          FieldByName('poblacion_c').AsString));
        QRLCMRInyeccion.dirSuministro.Lines.Add( Trim( FieldByName('descripcion_p').AsString ) );

      end
      else
      begin
        QRLCMRInyeccion.dirSuministro.Lines.Add(fieldByName('nombre_ds').AsString);
        QRLCMRInyeccion.dirSuministro.Lines.Add(Trim(FieldByName('tipo_via_ds').AsString + ' ' +
          FieldByName('domicilio_ds').AsString));
        QRLCMRInyeccion.dirSuministro.Lines.Add(Trim(FieldByName('cod_postal_ds').AsString + ' ' +
          FieldByName('poblacion_ds').AsString));
      end;

      QRLCMRInyeccion.qrmRemitente.Lines.Clear;
      if ( Trim(sEmpresa) = 'F21' ) and ( Trim(sCentro) = '4' ) then
      begin
        QRLCMRInyeccion.qrmRemitente.Lines.Add('LILIANA PERESTRELO, LDA');
        QRLCMRInyeccion.qrmRemitente.Lines.Add('QUINTA DAS PICAS - RUA DA AGRELA');
        QRLCMRInyeccion.qrmRemitente.Lines.Add('4805-449 SAO SALVADOR DE BRITEIROS');
        QRLCMRInyeccion.qrmRemitente.Lines.Add('GUIMARAES - PORTUGAL');

        QRLCMRInyeccion.qrmLugarOrigen.Lines.Text:= 'GUIMARAES (PORTUGAL)';
        QRLCMRInyeccion.qrlLugarOrigen2.Caption:= 'GUIMARAES';
      end
      else
      begin
        (*
        QRLCMRInyeccion.qrmRemitente.Lines.Add('BONNYSA AGROALIMENTARIA');
        QRLCMRInyeccion.qrmRemitente.Lines.Add('PARTIDA BAYONA BAJA S/N');
        QRLCMRInyeccion.qrmRemitente.Lines.Add('03110 MUCHAMIEL ( ALICANTE)');

        QRLCMRInyeccion.qrmLugarOrigen.Lines.Text:= 'MUCHAMIEL';
        QRLCMRInyeccion.qrlLugarOrigen2.Caption:= 'MUCHAMIEL';
        *)

        slAux:= TStringList.Create;
        DireccionCentroCMR( sEmpresa, sCentro, slAux, sPais, sPoblacion );
        QRLCMRInyeccion.qrmRemitente.Lines.Clear;
        QRLCMRInyeccion.qrmRemitente.Lines.AddStrings( slAux );
        FreeAndNil( slAux );

      end;

      
      if ( ( Trim(sCliente) = 'GL') and ( ( Trim(sDirSum) = '010') or ( Trim(sDirSum) = '009') ) )then
      begin
        QRLCMRInyeccion.qrmLugarEntrega.Lines.Clear;
        QRLCMRInyeccion.qrmLugarEntrega.Lines.Add(Trim( fieldByName('nombre_ds').AsString ) );
        QRLCMRInyeccion.qrmLugarEntrega.Lines.Add(Trim(FieldByName('tipo_via_ds').AsString + ' ' +
          FieldByName('domicilio_ds').AsString) + ' '  + FieldByName('provincia_ds').AsString  );
        QRLCMRInyeccion.qrmLugarEntrega.Lines.Add(
          Trim(FieldByName('cod_postal_ds').AsString + ' ' +
               FieldByName('poblacion_ds').AsString));
      end
      else
      begin
        QRLCMRInyeccion.qrmLugarEntrega.Lines.Text := FieldByName('descripcion_p').AsString;
      end;

      slRemitente:= TStringList.Create;
      slOrigen:= TStringList.Create;
      slConsignatario:= TStringList.Create;
      slEntrega:= TStringList.Create;

      if sCliente = 'LEN' then
      begin
        slRemitente.Clear;
        slRemitente.Add('LENFRUITS,S.L. CIF:B98528789');
        slRemitente.Add('Gandia,Valencia ( España)');
        slRemitente.Add('By order «TAVITON COMMERCIAL LTD »');
        slRemitente.Add('Craigmuir  Chambers, Road Town, B.V.I.');
        slRemitente.Add('Contract Nr:1506/12 from 15.06.2012');

        slOrigen.Clear;
        slOrigen.Add('BONNYSA AGROALIMENTARIA');
        slOrigen.Add('ESPAÑA');

        slConsignatario.Clear;
        slConsignatario.Add('OOO “Fruktovy alians”');
        slConsignatario.Add('Of. 23, Build. 32, Ochakovskoe shosse');
        slConsignatario.Add('119530 Moscow , Russia');
        slConsignatario.Add('INN 7721672210');

        slEntrega.Clear;
        slEntrega.Add('Moscu,g.Moskovskiy,centralnaya expedicia promzony');
      end
      else
      begin
        slRemitente.AddStrings( QRLCMRInyeccion.qrmRemitente.lines );
        slOrigen.AddStrings( QRLCMRInyeccion.qrmLugarOrigen.lines );
        slConsignatario.AddStrings( QRLCMRInyeccion.dirSuministro.lines );
        slEntrega.AddStrings( QRLCMRInyeccion.qrmLugarEntrega.lines );
      end;

      try
        ClienteCMRExec( sEmpresa, sCliente, sDirSum,
                         slRemitente, slOrigen, slConsignatario, slEntrega );

        QRLCMRInyeccion.qrmRemitente.lines.Clear;
        QRLCMRInyeccion.qrmRemitente.lines.AddStrings( slRemitente );
        QRLCMRInyeccion.qrmLugarOrigen.lines.Clear;
        QRLCMRInyeccion.qrmLugarOrigen.lines.AddStrings( slOrigen );
        QRLCMRInyeccion.dirSuministro.lines.Clear;
        QRLCMRInyeccion.dirSuministro.lines.AddStrings( slConsignatario );
        QRLCMRInyeccion.qrmLugarEntrega.lines.Clear;
        QRLCMRInyeccion.qrmLugarEntrega.lines.AddStrings( slEntrega );
      except
        FreeAndNil( slRemitente );
        FreeAndNil( slOrigen );
        FreeAndNil( slConsignatario );
        FreeAndNil( slEntrega );
      end;


      QRLCMRInyeccion.LMatricula.Caption := FieldByName('vehiculo_sc').AsString;
      LCMRInyeccion.DatosTransportista( QRLCMRInyeccion, sEmpresa, sTransportista );

      QRLCMRInyeccion.qrmObservaciones.Lines.Clear;


      if ( sEmpresa = 'F21' ) and ( sCentro = '4' ) then
      begin
        QRLCMRInyeccion.qrmObservaciones.Lines.Add('Nº ALBARÁN: ' + sCodAlbaran + ' DE BONNYSA AGROALIMENTARIA, S.A.');
        QRLCMRInyeccion.qrmObservaciones.Lines.Add('LA FONT Nº1, 03550 SAN JUAN DE ALICANTE (ALICANTE)' );
        if FieldByName('higiene_sc').AsInteger <> 0 then
        begin
          QRLCMRInyeccion.qrmObservaciones.Lines.Add('CONDICIONES HIGIENICAS: OK');
        end
        else
        begin
          QRLCMRInyeccion.qrmObservaciones.Lines.Add('CONDICIONES HIGIENICAS: MALAS');
        end;

        QRLCMRInyeccion.qrmObservaciones.Lines.Add( AddNota );
      end
      else
      begin
        QRLCMRInyeccion.qrmObservaciones.Lines.Add('Nº ALBARÁN: ' + sCodAlbaran );
        if FieldByName('higiene_sc').AsInteger <> 0 then
        begin
          QRLCMRInyeccion.qrmObservaciones.Lines.Add('CONDICIONES HIGIENICAS: OK');
        end
        else
        begin
          QRLCMRInyeccion.qrmObservaciones.Lines.Add('CONDICIONES HIGIENICAS: MALAS');
        end;
        QRLCMRInyeccion.qrmObservaciones.Lines.Add( AddNota );
      end;

      definirDetallesCMRInyeccion;

      QRLCMRInyeccion.ImprimirCMR( 'A'+sNumAlbaran, 4, True, True, True );

    finally
      QRLCMRInyeccion.Free;
      Close;
    end;
  end;
end;

function TDDDatosCMR.AddNota: string;
begin
  with qryAux do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add(' select nota_sc from frf_salidas_c ');
    SQL.Add('where   (empresa_sc = :empresa ) ' +
      'And   (centro_salida_sc = :centro ) ' +
      'And   (n_albaran_sc = :albaran ) ' +
      'And   (fecha_sc = :fecha ) ');
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    ParamByName('albaran').AsInteger := iAlbaran;
    ParamByName('fecha').Asdatetime := dFecha;
    Open;
    result:= FieldByName('nota_sc').AsString;
    Close;
  end;
end;

function TDDDatosCMR.GetFirmaCMR: string;
var
  sFilename: string;
  iAnyo, iMes, iDia: word;
begin

  result:= '';
  if gsDirFirmasGlobal <> '' then
  begin
    if DirectoryExists( gsDirFirmasGlobal ) then
      result:=  gsDirFirmasGlobal;
  end;
  if result = '' then
  begin
    if gsDirFirmasLocal <> '' then
    begin
      if DirectoryExists( gsDirFirmasLocal ) then
        result:=  gsDirFirmasLocal;
    end;
  end;

  if result <> '' then
  begin
    DecodeDate( dFecha, iAnyo, iMes, iDia );
    sFilename:= intToStr( iAnyo ) + sEmpresa + sCentro + sCliente + '-' + IntToStr( iAlbaran ) ;
    result:= result + '\' + sFileName + '.jpg';
  end;

  if bPedirFirma then
  begin
    if result = '' then
    begin
      ShowMessage('Falta inicializar la ruta para guardar las firmas.');
    end
    else
    begin

      if not FileExists( result ) then

        //GetFirma( self, result );
    end;
  end;
end;

procedure TDDDatosCMR.definirDetallesCMRInyeccion;
var
  pesoproducto: Extended;
  ipesoBruto, icajas: Integer;
  marca, producto, envase, env_comer, sEnvaseAux: string;
  i: integer;
  sAux: string;
begin
  marca := '';
  producto := '';
  envase := '';
  env_comer := '';
  ipesobruto := 0;
  icajas := 0;

   //Dejo en blanco los campos del Report
  QRLCMRInyeccion.marcas.Lines.Clear;
  QRLCMRInyeccion.qrmCajas.Lines.Clear;
  QRLCMRInyeccion.agrupacion.Lines.Clear;
  QRLCMRInyeccion.qrmNaturaleza.Lines.Clear;
  QRLCMRInyeccion.qrmPesoBruto.Lines.Clear;

  with QDetallesCMR do
  begin
    try
      Close;

      SQL.Clear;
      SQl.Add(' SELECT marca_sl, producto_sl, ' +
        '              ( select descripcion_p from frf_productos where producto_sl = producto_p and empresa_p = :emp) descripcion_p, ' +
        '              descripcion_m, envase_comercial_e, envase_sl, categoria_sl, tipo_palets_sl, ' +
        '        SUM(n_palets_sl) palets, SUM(cajas_sl) cajas, SUM(kilos_sl) pesoNetoProducto ' +
        ' FROM frf_salidas_l, OUTER frf_envases, OUTER frf_marcas ' +
        ' WHERE  ( (empresa_sl =:emp) ' +
        '   AND  (centro_salida_sl = :cen) ' +
        '   AND  (n_albaran_sl = :alb) ' +
        '   AND  (fecha_sl =:fec) ) ' +
        '   AND  (envase_sl = envase_e and empresa_e = :emp and producto_base_e = ( select producto_base_p from frf_productos '+
        '                                                                        where empresa_p = :emp and producto_p = producto_sl ) ) ' +
        '   AND  (marca_sl = codigo_m) ' +
        ' GROUP BY marca_sl, producto_sl, descripcion_m, envase_comercial_e, envase_sl, categoria_sl, tipo_palets_sl ' +
        ' ORDER BY descripcion_m, envase_comercial_e, producto_sl, envase_sl ');

      ParamByName('emp').AsString := sEmpresa;
      ParamByName('cen').AsString := sCentro;
      ParamByName('alb').AsInteger := iAlbaran;
      ParamByName('fec').AsDatetime := dFecha;
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        Exit;
      end;
    end;
    First;
     //le paso los datos al report y me quedo con los datos que agrupan
    QRLCMRInyeccion.marcas.Lines.Add(FieldByName('descripcion_m').AsString + ' CAT. ' + FieldByName('categoria_sl').AsString);

    sAux:= '';

    //falta la descripcion del producto

    QRLCMRInyeccion.qrmNaturaleza.lines.Clear;
    if ( Trim(sEmpresa) = 'F21' ) and ( Trim(sCentro) = '4' ) then
      sAux:= FieldByName('descripcion_p').AsString + ' (' + FieldByName('producto_sl').AsString + ') PORTUGAL '
    else
      sAux:= FieldByName('descripcion_p').AsString + ' (' + FieldByName('producto_sl').AsString + ') ESPAÑA ';

    if (FieldByName('envase_comercial_e').AsString = 'S') then
      QRLCMRInyeccion.agrupacion.Lines.Add('CARTÓN')
    else QRLCMRInyeccion.agrupacion.Lines.Add('PT.RECICLABLE');

    QRLCMRInyeccion.qrmNaturaleza.Lines.Add( sAux );

    marca := FieldByName('marca_sl').AsString;
    env_comer := FieldByName('envase_comercial_e').AsString;
    producto := FieldByName('producto_sl').AsString;
    envase:=  '';
    sEnvaseAux:= '';

     ///////////////////////////////////////////////////////////////////////////
    for i := 1 to RecordCount do
    begin
      if (marca <> FieldByName('marca_sl').AsString) or
         (producto <> FieldByName('producto_sl').AsString) or
         (env_comer <> FieldByName('envase_comercial_e').AsString) or
         (envase <> sEnvaseAux ) then
      begin
            //guardar los campos por los que se agrupa
        marca := FieldByName('marca_sl').AsString;
        env_comer := FieldByName('envase_comercial_e').AsString;
        producto := FieldByName('producto_sl').AsString;

            //Pasar los valores al Report
        QRLCMRInyeccion.marcas.Lines.Add(FieldByName('descripcion_m').AsString + ' CAT. ' + FieldByName('categoria_sl').AsString);
        QRLCMRInyeccion.qrmCajas.Lines.Add(FormatFloat('###,##0;-###,##0', icajas));

        if ( Trim(sEmpresa) = 'F21' ) and ( Trim(sCentro) = '4' ) then
          sAux:= FieldByName('descripcion_p').AsString + ' (' + FieldByName('producto_sl').AsString + ') PORTUGAL '
        else
          sAux:= FieldByName('descripcion_p').AsString + ' (' + FieldByName('producto_sl').AsString + ') ESPAÑA ';

        if (FieldByName('envase_comercial_e').AsString = 'S') then
          QRLCMRInyeccion.agrupacion.Lines.Add('CARTÓN')
        else
          QRLCMRInyeccion.agrupacion.Lines.Add('PT.RECICLABLE');
        QRLCMRInyeccion.qrmNaturaleza.Lines.Add( sAux );


        QRLCMRInyeccion.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0.00;-###,###,##0.00;0.00', ipesoBruto));
        iCajas := 0;
        iPesoBruto := 0;
      end;
      if (FieldByName('pesoNetoProducto').AsString <> '') then
        pesoProducto := FieldByName('pesoNetoProducto').AsFloat
      else
        pesoProducto := 0;
      ipesoBruto := ipesobruto + Trunc( bRoundTo( pesoProducto +
                   GetPesoEnvases( FieldByName('cajas').AsString, FieldByName('envase_sl').AsString ) +
                   GetPesoPalets( FieldByName('palets').AsString, FieldByName('tipo_palets_sl').AsString ), 0) );
      icajas := icajas + FieldByName('cajas').AsInteger;
      Next;
    end;
    QRLCMRInyeccion.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0.00;-###,###,##0.00;0.00', ipesoBruto));
    QRLCMRInyeccion.qrmCajas.Lines.Add(FormatFloat('###,##0;-###,##0', icajas));
    QDetallesCMR.Close;
  end;
end;

function TDDDatosCMR.GetPesoPalets(const APalets, APalet: string): Extended;
begin
  result:= StrToIntDef( APalets, 0 );
  qryAux.Close;
  with qryAux.SQL do
  begin
    Clear;
    Add(' SELECT kilos_tp ');
    Add(' FROM frf_tipo_palets ');
    Add(' WHERE  codigo_tp = :palet ');
  end;
  qryAux.ParamByName('palet').AsString := APalet;
  qryAux.Open;
  if qryAux.IsEmpty then
    result:= 0
  else
    result:= result * qryAux.FieldByName('kilos_tp').AsFloat;
  qryAux.Close;
end;

function TDDDatosCMR.GetPesoEnvases(const ACajas, AEnvase: string): Extended;
var
  peso, unidades, pesounidad, pesoenvase: Extended;
begin
    with qryAux do
    begin
      SQL.Clear;
      SQl.Add(' SELECT DISTINCT empresa_sl, centro_salida_sl, n_albaran_sl,' +
        '        fecha_sl, kilos_sl, unidades_caja_sl, peso_envase_uc, peso_envase_e ' +
        ' FROM frf_salidas_l, frf_envases, OUTER frf_und_consumo ' +
        ' WHERE   (empresa_sl =:emp) ' +
        '   AND  (centro_salida_sl =:cen) ' +
        '   AND  (n_albaran_sl =:alb) ' +
        '   AND  (fecha_sl = :fec) ' +
        '   AND  (envase_sl= :envase) ' +
        '   AND  (empresa_e = :emp) ' +
        '   AND  (envase_e = envase_sl) ' +
        '   AND  (empresa_uc = :emp) ' +
        '   AND  (codigo_uc = tipo_unidad_e)');
    end;
  peso := 0;
  qryAux.ParamByName('emp').AsString := sEmpresa;
  qryAux.ParamByName('cen').AsString := sCentro;
  qryAux.ParamByName('alb').AsInteger := iAlbaran;
  qryAux.ParamByName('fec').AsDatetime := dFecha;
  qryAux.ParamByName('envase').AsString := AEnvase;

  qryAux.Open;

  if (qryAux.FieldByName('unidades_caja_sl').AsString = '') then
    unidades := 0
  else
    unidades := qryAux.FieldByName('unidades_caja_sl').AsFloat;

  if (qryAux.FieldByName('peso_envase_uc').AsString = '') then
    pesounidad := 0
  else
    pesounidad := qryAux.FieldByName('peso_envase_uc').AsFloat;

  if (qryAux.FieldByName('peso_envase_e').AsString <> '') then
    pesoenvase := qryAux.FieldByName('peso_envase_e').AsFloat
  else
    pesoenvase := 0;

  if (unidades > 1) and (pesounidad > 0) then
    peso := peso + ( unidades * pesounidad ) + pesoenvase
  else
    peso := peso + pesoenvase;

  result := StrToIntDef( ACajas, 0 )*  peso;
  qryAux.Close;
end;

end.
