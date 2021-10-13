unit AlbaranEntreCentrosMercadonaDM;

interface

uses
  SysUtils, Classes, DB, DBTables, usalidaUtils;

type
  TDMAlbaranEntreCentrosMercadona = class(TDataModule)
    QAlbaranC: TQuery;
  private
    { Private declarations }
    sEmpresa, sCentro, sCliente: String;
    iALbaran: integer;
    dFecha: TDateTime;

    function  GetFirmaFileName: string;
    procedure PutObservaciones( var ATexto: TStringList );
    procedure PutPaletsMercadona(var APaletsMercadona: TStrings);
    procedure PutPalets(var APalets: TStrings);
    procedure PutLogifruit(var ALogifruit: TStrings);
    function  DNITransporte(const AEmpresa, ATransporte: string): string;
    function  Dir2Transporte(const AEmpresa, ATransporte: string): string;
    function  Dir1Transporte(const AEmpresa, ATransporte: string): string;
  public
    { Public declarations }
    function PreAlbaran( const AEmpresa, ACentro: String;
                         const AALbaran: integer;
                         const AFecha: TDateTime;
                         const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
  end;

function PreAlbaran( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True ): boolean;

implementation

{$R *.dfm}

uses
  AlbaranEntreCentrosMercadonaQR, UDMBaseDatos, CVAriables, Dialogs, UDMAuxDB, bTextUtils,
  UDMConfig, DPreview, SignatureForm, UCAlbaran;

var
  DMAlbaranEntreCentrosMercadona: TDMAlbaranEntreCentrosMercadona;
  QRAlbaranEntreCentrosMercadona: TQRAlbaranEntreCentrosMercadona;

function PreAlbaran( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
begin
  DMAlbaranEntreCentrosMercadona:= TDMAlbaranEntreCentrosMercadona.Create( AOwner );
  try
    result:= DMAlbaranEntreCentrosMercadona.PreAlbaran( AEmpresa, ACentro, AALbaran, AFecha, APedirFirma, AOriginal, GGN, APrevisualizar );
  finally
    FreeAndNil( DMAlbaranEntreCentrosMercadona );
  end;
end;

function TDMAlbaranEntreCentrosMercadona.PreAlbaran(
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
var
  aux: TStringList;
  sAux, sDir, sMsg: string;
  bEsEspanya: boolean;
  SFileName: string;
  iCopias: integer;
begin
  Result:= False;

  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iALbaran:= AALbaran;
  dFecha:= AFecha;

  with QAlbaranC do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_salidas_c');
    SQL.Add('where empresa_sc = :empresa');
    SQL.Add('and centro_salida_sc = :centro');
    SQL.Add('and fecha_sc = :fecha');
    SQL.Add('and n_albaran_sc = :albaran');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('albaran').AsInteger:= iALbaran;
    ParamByName('fecha').AsDateTime:= dFecha;
    Open;
  end;
  sCliente:= QAlbaranC.FieldByname('cliente_sal_sc').AsString;

  SFileName:= GetFirmaFileName;
  if APedirFirma then
  begin
    if sFileName = '' then
    begin
      ShowMessage('Falta inicializar la ruta para guardar las firmas.');
    end
    else
    begin
      if not SignatureForm.SignSave( self, sFilename, sMsg ) then
      begin
        ShowMessage( sMsg );
      end;
      //GetFirma( self, sFilename );//OLDTablet
    end;
  end;

  try
    QRAlbaranEntreCentrosMercadona:= TQRAlbaranEntreCentrosMercadona.Create( self );
    QRAlbaranEntreCentrosMercadona.rGGN := GGN;
    QRAlbaranEntreCentrosMercadona.sFirma:= sFilename;
    QRAlbaranEntreCentrosMercadona.empresa := sEmpresa;
    QRAlbaranEntreCentrosMercadona.cliente := sCliente;

    QRAlbaranEntreCentrosMercadona.GetCodigoProveedor(sEmpresa, sCliente);
    QRAlbaranEntreCentrosMercadona.GetResumen(sEmpresa, sCentro, iAlbaran, dFecha);
    aux := TStringList.Create;
    PutObservaciones( aux );
    QRAlbaranEntreCentrosMercadona.mmoObservaciones.Lines.Clear;
    if Trim(aux.text) <> '' then QRAlbaranEntreCentrosMercadona.mmoObservaciones.Lines.AddStrings(aux);

    aux.Clear;
    PutPalets(TStrings(aux));
    QRAlbaranEntreCentrosMercadona.MemoPalets.Lines.Clear;
    QRAlbaranEntreCentrosMercadona.MemoPalets.Lines.AddStrings(aux);

    aux.Clear;
    PutPaletsMercadona(TStrings(aux));
    QRAlbaranEntreCentrosMercadona.mmoPaletsMercadona.Lines.Clear;
    QRAlbaranEntreCentrosMercadona.mmoPaletsMercadona.Lines.AddStrings(aux);

    aux.Clear;
    PutLogifruit(TStrings(aux));
    QRAlbaranEntreCentrosMercadona.MemoCajas.Lines.Clear;
    QRAlbaranEntreCentrosMercadona.MemoCajas.Lines.AddStrings(aux);

    aux.Free;

        //Seleccion datos suministro/cliente
    if (Trim(QAlbaranC.FieldByname('dir_sum_sc').AsString) = Trim(sCliente)) or
      (Trim(QAlbaranC.FieldByname('dir_sum_sc').AsString) = '') then
    begin
      //No hay direccion de suministro
      with DMBaseDatos.QListado do
      begin
        if Active then
        begin
          Cancel;
          Close;
        end;
        with SQL do
        begin
          Clear;
          Add(' SELECT DISTINCT tipo_via_c, domicilio_c, poblacion_c, cod_postal_c, telefono_c,');
          Add('     pais_c, descripcion_p, tipo_albaran_c, moneda_c, nif_c');
          Add(' FROM frf_salidas_c , frf_clientes , frf_paises');
          Add(' WHERE  (empresa_sc = :empresa) ');
          Add(' AND  (cliente_sal_sc = :cliente) ');
          Add(' AND  (cliente_c = :cliente) ');
          Add(' AND  (pais_p = pais_c) '); //pais

        end;
        ParamByName('empresa').AsString := sEmpresa;
        ParamByName('cliente').AsString := sCliente;

        try
          Open;
        except
          MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
          raise;
        end;

                  //Rellenamos datos
        with QRAlbaranEntreCentrosMercadona do
        begin
          bValorar := FieldByName('tipo_albaran_c').AsInteger = 1;

          QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Clear;
          QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( desCliente( sCliente ) );
          bEsEspanya:= Trim(FieldByName('pais_c').AsString) = 'ES';
          moneda3.Caption:= FieldByName('moneda_c').AsString;
          qrlMonedaIva.Caption:= FieldByName('moneda_c').AsString;
          qrlMonedaTotal.Caption:= FieldByName('moneda_c').AsString;

          sAux:= Trim(FieldByName('nif_c').AsString);
          if sAux <> '' then
          begin
            if bEsEspanya then
              QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( 'CIF: ' + sAux )
            else
              QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( 'VAT: ' + sAux )
          end;
          sAux:= Trim( FieldByName('tipo_via_c').AsString  + ' ' +  FieldByName('domicilio_c').AsString );
          if sAux <> '' then
            QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( sAux );
          sAux:= Trim( FieldByName('poblacion_c').AsString );
          if sAux <> '' then
            QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( sAux );

          if bEsEspanya then
          begin
            sAux:= Trim( FieldByName('cod_postal_c').AsString + ' ' + desProvincia(FieldByName('cod_postal_c').AsString) );
            if sAux <> '' then
              QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( sAux );
          end
          else
          begin
            sAux:= Trim( FieldByName('cod_postal_c').AsString + ' ' + FieldByName('descripcion_p').AsString );
            if sAux <> '' then
              QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( sAux );
          end;
        end;
      end;
    end
    else
    begin
      //Hay direccion de suministro
      with DMBaseDatos.QListado do
      begin
        if Active then
        begin
          Cancel;
          Close;
        end;
        with SQL do
        begin
          Clear;
          Add(' SELECT DISTINCT tipo_via_ds, domicilio_ds, cod_postal_ds, poblacion_ds, telefono_ds,');
          Add('     provincia_ds,pais_ds, descripcion_p, tipo_albaran_c, moneda_c, nif_c ');
          Add(' FROM frf_salidas_c , frf_dir_sum  ,frf_clientes , frf_paises');
          Add(' WHERE  (empresa_sc = :empresa) ');
          Add(' AND  (cliente_sal_sc = :cliente) ');
          Add(' AND  (dir_sum_sc = :suministro)  ');
          Add(' AND  (cliente_c = :cliente) ');   //Cliente
          Add(' AND  (cliente_ds = :cliente) ');
          Add(' AND  (dir_sum_ds = :suministro) ');
          Add(' AND  (pais_p = pais_ds) '); //Pais
        end;
        ParamByName('empresa').AsString := sEmpresa;
        ParamByName('cliente').AsString := sCliente;
        ParamByName('suministro').AsString := QAlbaranC.FieldByname('dir_sum_sc').AsString;

        try
          Open;
        except
          MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
          raise;
        end;

                  //Rellenamos datos
        with QRAlbaranEntreCentrosMercadona do
        begin
          bValorar := FieldByName('tipo_albaran_c').AsInteger = 1;

          QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Clear;
          QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( desCliente( sCliente ) );

          bEsEspanya:= Trim(FieldByName('pais_ds').AsString) = 'ES';
          sAux:= Trim(FieldByName('nif_c').AsString);
          if sAux <> '' then
          begin
            if bEsEspanya then
              QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( 'CIF: ' + sAux )
            else
              QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( 'VAT: ' + sAux )
          end;

          QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( desSuministro( sEmpresa, sCliente, QAlbaranC.FieldByname('dir_sum_sc').AsString )  );

          sAux:= Trim( FieldByName('tipo_via_ds').AsString  + ' ' +  FieldByName('domicilio_ds').AsString );
          if sAux <> '' then
            QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( sAux );
          sAux:= Trim( FieldByName('poblacion_ds').AsString );
          if sAux <> '' then
            QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( sAux );

          if bEsEspanya then
          begin
            sAux:= desProvincia(FieldByName('cod_postal_ds').AsString);
            if sAux <> '' then
            begin
              sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + sAux );
              QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( sAux );
            end
            else
            begin
              sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + FieldByName('provincia_ds').AsString );
              if sAux <> '' then
                QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( sAux );
            end;
          end
          else
          begin
            sAux:= Trim( FieldByName('provincia_ds').AsString );
            if sAux <> '' then
            begin
              QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( Trim( FieldByName('cod_postal_ds').AsString + ' ' + sAux ) );
              sAux:= Trim( FieldByName('descripcion_p').AsString );
              if sAux <> '' then
                QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( sAux );
            end
            else
            begin
              sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + FieldByName('descripcion_p').AsString );
              if sAux <> '' then
                QRAlbaranEntreCentrosMercadona.qrmDireccion.Lines.Add( sAux );
            end;
          end;
        end;
      end;
    end;



    //Datos almacen
    (*ALBARAN*)
    if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( sCliente <> 'ECI' ) then
    //if ( Copy( sEmpresa, 1, 1) = 'F' ) then
    begin
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Caption := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Width:= 73;
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Left:= 4;
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran2.Caption := Coletilla( sEmpresa );
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran2.Enabled := True;
    end
    else
    //Bargosa
    if Trim( sEmpresa ) = '505' then
    begin
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Caption := 'BON.' + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Width:= 73;
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Left:= 4;
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran2.Caption := '';
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran2.Enabled := False;
    end
    else
    begin
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Caption := IntToStr( iAlbaran );
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Alignment := taCenter;
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Width:= 87;
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran.Left:= 4;
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran2.Caption := '';
      QRAlbaranEntreCentrosMercadona.qrlNAlbaran2.Enabled := False;
    end;

    QRAlbaranEntreCentrosMercadona.LFecha.Caption := DateTimeToStr( dFecha );
    QRAlbaranEntreCentrosMercadona.LHoraCarga.Caption := QAlbaranC.FieldByname('hora_sc').AsString;
    QRAlbaranEntreCentrosMercadona.LDescarga.Caption := QAlbaranC.FieldByname('fecha_descarga_sc').AsString;
    QRAlbaranEntreCentrosMercadona.LPedido.Caption := QAlbaranC.FieldByname('n_pedido_sc').AsString;
    QRAlbaranEntreCentrosMercadona.LVehiculo.Caption := QAlbaranC.FieldByname('vehiculo_sc').AsString;

    QRAlbaranEntreCentrosMercadona.LCentro.Caption := desCentro( sEmpresa, sCentro );
    if sCliente = 'MER' then
      QRAlbaranEntreCentrosMercadona.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + DNITransporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString)
    else
      QRAlbaranEntreCentrosMercadona.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    sDir := Dir2Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    if Trim( sDir ) <> '' then
      QRAlbaranEntreCentrosMercadona.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + ', ' + sDir
    else
      QRAlbaranEntreCentrosMercadona.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);

        //Buscar cuerpo del formulario
    with DMBaseDatos.QListado do
    begin
      if Active then
      begin
        Cancel;
        Close;
      end;
      with SQL do
      begin
        Clear;
        Add(' SELECT estomate_p,producto_p,descripcion_p,descripcion2_p, envase_sl,');
        Add('     envase_e, descripcion_m, color_sl, calibre_sl,  ');
        Add('    unidad_precio_sl,precio_sl,porc_iva_sl, ');

        Add('    SUM(kilos_sl) as kilos_sl, ');
        Add('    SUM(cajas_sl) as cajas_sl, ');
        Add('    SUM((cajas_sl*unidades_caja_sl)) as unidades, ');
        Add('    SUM(importe_neto_sl) as importe_neto_sl, ');
        Add('    SUM(iva_sl) as iva_sl, ');
        Add('    SUM(importe_total_sl) as importe_total_sl ');

                  //INICIO
                  //Si la empresa es Maset desglosar tambien por categoria
        if (Trim(sEmpresa) = '037') or
          (Trim(sEmpresa) = '062') then
        begin
          Add(',categoria_sl ');
        end;
                  //Si la empresa es Maset desglosar tambien por categoria
                  //FIN
        Add(' FROM frf_salidas_l , frf_productos , frf_envases , frf_marcas  ');
        Add(' WHERE   (empresa_sl = :empresa) ');
        Add('    AND  (centro_salida_sl = :centro) ');
        Add('    AND  (n_albaran_sl = :albaran) ');
        Add('    AND  (fecha_sl = :fecha) ');
        Add('    AND  (producto_p = producto_sl) ');
        Add('    AND  (envase_e = envase_sl  and producto_e = producto_p ) '); //ENVASE
        Add('    AND  (codigo_m = marca_sl) '); //MARCA
        Add(' GROUP BY estomate_p, producto_p, descripcion_p, descripcion2_p, ' +
          '          envase_sl, envase_e, descripcion_m, ' +
          '          color_sl, calibre_sl, unidad_precio_sl, precio_sl, porc_iva_sl ');
                  //INICIO
                  //Si la empresa es Maset desglosar tambien por categoria
        if (Trim(sEmpresa) = '037') or
          (Trim(sEmpresa) = '062') then
        begin
          Add(',categoria_sl ');
        end;
                  //Si la empresa es Maset desglosar tambien por categoria
                  //FIN
        Add(' ORDER BY estomate_p,producto_p, envase_e, color_sl, ');
        Add(' calibre_sl, precio_sl, unidad_precio_sl ');
      end;
      ParamByName('empresa').AsString := sEmpresa;
      ParamByName('centro').AsString := sCentro;
      ParamByName('albaran').AsInteger := iAlbaran;
      ParamByName('fecha').AsDateTime := dFecha;
      try
        Open;
      except
        DMBaseDatos.QListado.Cancel;
        DMBaseDatos.QListado.Close;
        MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
        raise;
      end;
    end;

    QRAlbaranEntreCentrosMercadona.Configurar(sEmpresa);

    DPreview.bCanSend := DMConfig.EsLaFont;
    QRAlbaranEntreCentrosMercadona.bEnEspanyol:= bEsEspanya;

    QRAlbaranEntreCentrosMercadona.bOriginal:= AOriginal;
    iCopias:= NumeroCopias( sEmpresa, sCliente);
    if not AOriginal then
      iCopias:= iCopias - 1;
    QRAlbaranEntreCentrosMercadona.ReportTitle:= sCliente + 'A' + IntToStr( iALbaran );

    if APrevisualizar then
    begin
      result:= DPreview.Preview(QRAlbaranEntreCentrosMercadona, iCopias, False, True, ForzarEnvioAlbaran( sEmpresa, sCliente, iALbaran, dFecha ) );
    end
    else
    begin
      try
        QRAlbaranEntreCentrosMercadona.Print;
        result:= True;
      finally
        FreeAndNil( QRAlbaranEntreCentrosMercadona );
      end;
    end;

    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;

  except
    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;
    QRAlbaranEntreCentrosMercadona.Free;
  end;
end;

function TDMAlbaranEntreCentrosMercadona.GetFirmaFileName: string;
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
    sFilename:= intToStr( iAnyo ) + sEmpresa + sCentro + sCliente + '-' + IntToStr( iAlbaran );
    result:= result + '\' + sFileName + '.jpg';
  end;
end;

procedure TDMAlbaranEntreCentrosMercadona.PutObservaciones( var ATexto: TStringList );
begin
  if QAlbaranC.FieldByname('n_cmr_sc').AsString <> '' then
  begin
    ATexto.Add('Nº CMR:' + QAlbaranC.FieldByname('n_cmr_sc').AsString);
  end;
  if QAlbaranC.FieldByname('n_orden_sc').AsString <> '' then
  begin
    ATexto.Add('Nº ORDEN CARGA:' + QAlbaranC.FieldByname('n_orden_sc').AsString);
  end;
  if QAlbaranC.FieldByname('higiene_sc').AsInteger = 1  then
  begin
    ATexto.Add('CONDICIONES HIGIENICAS: OK');
  end
  else
  begin
    ATexto.Add('CONDICIONES HIGIENICAS: INCORRECTAS');
  end;

  if Trim( QAlbaranC.FieldByname('nota_sc').AsString ) <> '' then
    ATexto.Add( Trim(QAlbaranC.FieldByname('nota_sc').AsString) );
end;

procedure TDMAlbaranEntreCentrosMercadona.PutPaletsMercadona(var APaletsMercadona: TStrings);
var
  iPalets, iCajas: Integer;
  rKilos: Real;
begin
  with DMBaseDatos.QTemp do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      Add(' select tipo_palets_sl, ');
      Add('        ( select descripcion_tp from frf_tipo_palets where codigo_tp = tipo_palets_sl ) des_tipo_palets_sl, ');
      Add('        producto_sl, ');
      Add('        ( select descripcion_p from frf_productos where producto_p = producto_sl ) des_producto_sl, ');
      Add('        envase_sl, ');
      Add('        ( select descripcion_e from frf_envases where producto_e = producto_sl ');
      Add('          and envase_e = envase_sl ) des_envase_sl, ');
      Add('        sum(n_palets_sl) palets, sum(cajas_sl) cajas_sl, sum(kilos_sl) kilos_sl ');
      Add(' from frf_salidas_l ');
      Add(' where empresa_sl = :empresa ');
      Add(' and centro_salida_sl = :centro ');
      Add(' and n_albaran_sl = :albaran ');
      Add(' and fecha_sl = :fecha ');
      Add(' group by 1,2,3,4,5,6 ');
      Add(' order by tipo_palets_sl, producto_sl, envase_sl ');

    end;
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    ParamByName('albaran').AsInteger := iALbaran;
    ParamByName('fecha').AsDateTime := dFecha;
    try
      iPalets := 0;
      iCajas := 0;
      rKilos := 0;

      Open;
      First;
      APaletsMercadona.Clear;
      APaletsMercadona.Add('TIPO PALETA                         ENVASE                         PALETS   CAJAS      KILOS');
      APaletsMercadona.Add('----------------------------------- ------------------------------ ------ ------- ----------');
      while not Eof do
      begin
        //'35 30 6 7 9'
        APaletsMercadona.Add(
          RellenaDer(FieldByName('des_tipo_palets_sl').AsString, 35) + ' ' +
          RellenaDer(FieldByName('des_envase_sl').AsString, 30) + ' ' +
          Rellena(FieldByName('palets').AsString, 6) + ' ' +
          Rellena(FieldByName('cajas_sl').AsString, 7) + ' ' +
          Rellena(FormatFloat('#0.00', FieldByName('kilos_sl').AsFloat ), 10) );
        iPalets := iPalets + FieldByName('palets').AsInteger;
        iCajas := iCajas + FieldByName('cajas_sl').AsInteger;
        rKilos := rKilos + FieldByName('kilos_sl').AsFloat;
        Next;
      end;
      APaletsMercadona.Add('----------------------------------- ------------------------------ ------ ------- ----------');
      APaletsMercadona.Add(
        Rellena(' ', 66) + ' ' +
        Rellena(IntToStr(iPalets), 6) + ' ' +
        Rellena(IntToStr(iCajas), 7) + ' ' +
        Rellena(FormatFloat('#0.00', rKilos), 10));

    finally
      Close;
    end;
  end;
end;

procedure TDMAlbaranEntreCentrosMercadona.PutPalets(var APalets: TStrings);
begin
  with DMBaseDatos.QTemp do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      Add(' SELECT descripcion_tp, SUM(n_palets_sl) as n_palets_sl ');
      Add(' FROM frf_salidas_l , frf_tipo_palets ');
      Add(' WHERE   (tipo_palets_sl = codigo_tp) ');
      Add('    AND  (empresa_sl = :empresa) ');
      Add('    AND  (centro_salida_sl = :centro) ');
      Add('    AND  (n_albaran_sl = :albaran) ');
      Add('    AND  (fecha_sl = :fecha) ');
      Add(' GROUP BY descripcion_tp  ');
      Add(' ORDER BY descripcion_tp ');
    end;
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    ParamByName('albaran').AsInteger := ialbaran;
    ParamByName('fecha').AsDateTime := dFecha;
    try
      Open;
      First;
      while not Eof do
      begin
        APalets.add(FieldByName('descripcion_tp').AsString + ' : ' +
          FieldByName('n_palets_sl').AsString);
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TDMAlbaranEntreCentrosMercadona.PutLogifruit(var ALogifruit: TStrings);
begin
  with DMBaseDatos.QTemp do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      Add(' select cod_producto_ecp codigo_caja_e, des_producto_ecp texto_caja_e, sum(cajas_sl) cajas_sl ');
      Add(' FROM frf_salidas_l, frf_envases, frf_env_comer_productos ');
      Add(' WHERE empresa_sl = :empresa ');
      Add('   AND centro_salida_sl = :centro ');
      Add('   AND n_albaran_sl = :albaran ');
      Add('   AND fecha_sl = :fecha ');
      Add('   and envase_e = envase_sl ');
      Add('   and producto_e = producto_sl');
      Add(' and env_comer_operador_e = cod_operador_ecp ');
      Add(' and env_comer_producto_e = cod_producto_ecp ');
      Add(' group by cod_producto_ecp, des_producto_ecp ');
      Add(' order by cod_producto_ecp ');

    end;
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    ParamByName('albaran').AsInteger := iAlbaran;
    ParamByName('fecha').AsDateTime := dFecha;
    try
      Open;
      First;
      while not Eof do
      begin
          ALogifruit.add(FieldByName('texto_caja_e').AsString + ' : ' + FieldByName('cajas_sl').AsString );
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

function TDMAlbaranEntreCentrosMercadona.DNITransporte(const AEmpresa, ATransporte: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select cif_t from frf_transportistas ');
    SQL.Add(' where transporte_t = ' + QuotedStr(ATransporte));
    Open;
    if not IsEmpty then
    begin
      result := ' C.I.F.: ' + Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;

function TDMAlbaranEntreCentrosMercadona.Dir2Transporte(const AEmpresa, ATransporte: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select direccion2_t from frf_transportistas ');
    SQL.Add(' where transporte_t = ' + QuotedStr(ATransporte));
    Open;
    if not IsEmpty then
    begin
      result := Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;

function TDMAlbaranEntreCentrosMercadona.Dir1Transporte(const AEmpresa, ATransporte: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select direccion1_t from frf_transportistas ');
    SQL.Add(' where transporte_t = ' + QuotedStr(ATransporte));
    Open;
    if not IsEmpty then
    begin
      result := Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;


end.
