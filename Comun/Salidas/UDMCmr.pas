unit UDMCmr;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  RCabCMR = record
    Remitente: TStringList;
    Carga: TStringList;
    Consignatario: TStringList;
    Entrega: TStringList;
  end;

  TDMCmr = class(TDataModule)
    QDetallesCMR: TQuery;
    QPesoEnvase: TQuery;
    QPesoPalet: TQuery;
    qryNota: TQuery;
    qryTransito: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure definirDetallesCMRInyeccion;
    procedure PutObservaciones;

    function  GetPesoEnvases(const ACajas, AEnvase: string; const AFecha: TDateTime ): Extended;
    function  GetPesoPalets(const APalets, APalet: string): Extended;

    procedure RemitenteTransito;
    procedure ConsignatarioTransito;
    procedure CargaTransito;
    procedure EntregaTransito;

    procedure PreCMRInyeccion;
  public
    { Public declarations }
    sEmpresa, sCentro, sCliente, sSuministro, sTransporte, sNota: string;
    dFecha: TDateTime;
    iAlbaran: integer;
    bHigiene: boolean;
    CabCMR: RCabCMR;

    function  esTomate(const empresa, producto: string; var descripcion, desIngles: string): Boolean;


    procedure PreCMRVenta;
    procedure PreCMRTransito;
  end;

  procedure ExecVentaCMR( const sAEmpresa, sACentro, sACliente, sASumnistro, sATransporte, sANota: string;
                   const dAFecha: TDateTime; const iAAlbaran: integer;
                   const bAHigiene: boolean );


  procedure ExecTransitoCMR(const AEmpresa, ACentro, AReferencia, AFecha, ADestino, ALugarDestino, ATransportista: string;
                       const ADataSource: TDataSource);
var
  DMCmr: TDMCmr;

implementation

{$R *.dfm}

uses
  Forms, DClienteCMR, LCMRInyeccion, LCMREdeka, UDMBaseDatos, DError,
  UDMAuxDB, bMath, UDMTransitos, bTextUtils;

procedure TDMCmr.DataModuleCreate(Sender: TObject);
begin
  with QDetallesCMR do
  begin
    SQL.Clear;
    SQl.Add(' SELECT marca_sl, producto_sl, descripcion_m, envase_comercial_e, envase_sl, categoria_sl, tipo_palets_sl, ' +
      '        SUM(n_palets_sl) palets, SUM(cajas_sl) cajas, SUM(kilos_reales_sl) pesoNetoProducto ' +
      ' FROM frf_salidas_l, OUTER frf_envases, OUTER frf_marcas ' +
      ' WHERE  (envase_sl = envase_e) ' +
      '   AND  (marca_sl = codigo_m) ' +
      '   AND  ( (empresa_sl =:emp) ' +
      '   AND  (centro_salida_sl = :cen) ' +
      '   AND  (n_albaran_sl = :alb) ' +
      '   AND  (fecha_sl =:fec) ) ' +
      ' GROUP BY marca_sl, descripcion_m, envase_comercial_e, producto_sl,envase_sl, categoria_sl, tipo_palets_sl ' +
      ' ORDER BY descripcion_m, envase_comercial_e, producto_sl, envase_sl ');
  end;
end;

procedure ExecVentaCMR( const sAEmpresa, sACentro, sACliente, sASumnistro, sATransporte, sANota: string;
                   const dAFecha: TDateTime; const iAAlbaran: integer;
                   const bAHigiene: boolean );
begin
  Application.CreateForm( TDMCmr, DMCmr);
  try
    DMCmr.sEmpresa:= sAEmpresa;
    DMCmr.sCentro:= sACentro;
    DMCmr.sCliente:= sACliente;
    DMCmr.sSuministro:= sASumnistro;
    DMCmr.sTransporte:= sATransporte;
    DMCmr.dFecha:= dAFecha;
    DMCmr.iAlbaran:= iAAlbaran;
    DMCmr.bHigiene:= bAHigiene;
    DMCmr.sNota:= sANota;

    DMCMR.PreCMRVenta;
  finally
    FreeAndNil( DMCmr );
  end;
end;

procedure TDMCmr.PreCMRVenta;
begin
    CabCMR.Remitente := TStringList.Create;
    CabCMR.Carga := TStringList.Create;
    CabCMR.Consignatario := TStringList.Create;
    CabCMR.Entrega := TStringList.Create;

    ClienteCMRExec(sEmpresa, sCentro, sCliente, sSuministro, CabCMR);

    if ( sCliente = 'ED' ) or ( sCliente = 'DIF' ) then
    begin
      LCMREdeka.PreCMREdeka( sEmpresa, sCentro, sCliente, iAlbaran, dFecha, CabCMR );
    end
    else
    begin
      PreCMRInyeccion;
    end;
end;

procedure TDMCmr.PreCMRInyeccion;
begin
  with DMBaseDatos.QListado do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('SELECT empresa_sc,centro_salida_sc,n_albaran_sc, fecha_sc,vehiculo_sc, cliente_sal_sc ');
    SQL.Add('FROM frf_salidas_c ');
    SQL.Add('Where   (empresa_sc = ' + QuotedStr(sEmpresa) + ') ' +
      '  And   (centro_salida_sc = ' + QuotedStr(sCentro) + ') ' +
      '  And   (n_albaran_sc = ' + IntToStr( iAlbaran ) + ') ' +
      '  And   (fecha_sc = :fecha ) ');
    ParamByName('fecha').asdatetime := dFecha;
    Open;
// Definici?n de la direcci?n de Suministro de la Carta de Transporte...( C.M.R.)
    try
      QRLCMRInyeccion := TQRLCMRInyeccion.Create(Application);

      QRLCMRInyeccion.qrmRemitente.Lines.Clear;
      QRLCMRInyeccion.qrmRemitente.Lines.AddStrings(CabCMR.Remitente);
      QRLCMRInyeccion.byRemitente(sCliente);

      QRLCMRInyeccion.qrmConsignatario.Lines.Clear;
      QRLCMRInyeccion.qrmConsignatario.Lines.AddStrings(CabCMR.Consignatario);

      QRLCMRInyeccion.qrmCarga.Lines.Clear;
      QRLCMRInyeccion.qrmCarga.Lines.AddStrings( CabCMR.Carga );

      QRLCMRInyeccion.qrmEntrega.Lines.Clear;
      QRLCMRInyeccion.qrmEntrega.Lines.AddStrings( CabCMR.Entrega );


      if ( iAlbaran = 240452 ) and ( FormatDateTime( 'dd/mm/yyyy', dFecha ) = '27/04/2012' ) then
        QRLCMRInyeccion.LMatricula.Caption := 'BY TRUCK R6459BCD/BY SEA'
      else
        QRLCMRInyeccion.LMatricula.Caption := FieldByName('vehiculo_sc').AsString;

      LCMRInyeccion.DatosTransportista( QRLCMRInyeccion, sEmpresa, sTransporte );

      PutObservaciones;
      definirDetallesCMRInyeccion;

      QRLCMRInyeccion.ImprimirCMR( 'A' + intToStr( iAlbaran ), 4, True, True, True );
    finally
      QRLCMRInyeccion.Free;
      Close;
    end;
  end;
  CabCMR.Remitente.Free;
  CabCMR.Carga.Free;
  CabCMR.Consignatario.Free;
  CabCMR.Entrega.Free;
end;

procedure TDMCmr.PutObservaciones;
var
  sCodAlbaran: string;
begin
    if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( sCliente <> 'ECI' ) then
    begin
      sCodAlbaran := sEmpresa + sCentro + Rellena( intToStr( iAlbaran ), 5, '0', taLeftJustify ) + Coletilla( sEmpresa );
    end
    else
    begin
      sCodAlbaran := intToStr( iAlbaran );
    end;

      QRLCMRInyeccion.cmrObservaciones.Lines.Clear;
      if ( sCliente = 'FL' ) then
        QRLCMRInyeccion.cmrObservaciones.Lines.Add('DELIVERY NOTE N?: ' + sCodAlbaran)
      else
        QRLCMRInyeccion.cmrObservaciones.Lines.Add('N? ALBAR?N: ' + sCodAlbaran );

      if bHigiene then
      begin
        if ( sCliente = 'FL' )  then
          QRLCMRInyeccion.cmrObservaciones.Lines.Add('HYGIENIC CONDITIONS: OK')
        else
          QRLCMRInyeccion.cmrObservaciones.Lines.Add('CONDICIONES HIGIENICAS: OK');
      end
      else
      begin
        if ( sCliente = 'FL' )  then
          QRLCMRInyeccion.cmrObservaciones.Lines.Add('HYGIENIC CONDITIONS: BAD')
        else
          QRLCMRInyeccion.cmrObservaciones.Lines.Add('CONDICIONES HIGIENICAS: MALAS');
      end;
      QRLCMRInyeccion.cmrObservaciones.Lines.Add( sNota );
end;

procedure TDMCmr.definirDetallesCMRInyeccion;
var
  pesoproducto: extended;
  ipesoBruto, icajas: integer;
  marca, producto, envase, env_comer, sEnvaseAux: string;
  i: integer;
  descripcion, desIngles, sAux: string;
begin
  marca := '';
  producto := '';
  envase := '';
  env_comer := '';
  ipesobruto := 0;
  icajas := 0;

   //Dejo en blanco los campos del Report
  QRLCMRInyeccion.marcas.Lines.Clear;
  QRLCMRInyeccion.cajas.Lines.Clear;
  QRLCMRInyeccion.agrupacion.Lines.Clear;
  QRLCMRInyeccion.producto.Lines.Clear;
  QRLCMRInyeccion.qrmPesoBruto.Lines.Clear;

  if ( sCliente = 'FL' )  then
  begin
    QRLCMRInyeccion.producto.Enabled:= False;
  end;

  with QDetallesCMR do
  begin
    try
      Close;
      ParamByName('emp').AsString := sEmpresa;
      ParamByName('cen').AsString := sCentro;
      ParamByName('alb').AsString := intToStr( iAlbaran );
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
    QRLCMRInyeccion.producto.lines.Clear;
    if esTomate(sEmpresa, FieldByName('producto_sl').AsString, descripcion, desIngles ) then
    begin
      if ( sCliente = 'FL' )   then
        sAux:= 'TOMATO (' + FieldByName('producto_sl').AsString + ') SPAIN '
      else
        sAux:= 'TOMATE (' + FieldByName('producto_sl').AsString + ') ESPA?A ';
    end
    else
    begin
      if ( sCliente = 'FL' )  then
        sAux:= desIngles + ' (' + FieldByName('producto_sl').AsString + ') SPAIN '
      else
        sAux:= descripcion + ' (' + FieldByName('producto_sl').AsString + ') ESPA?A ';
    end;
    if ( sCliente = 'FL' )  then
      sAux:= desEnvaseCliente( sEmpresa, FieldByName('producto_sl').AsString,
        FieldByName('envase_sl').AsString , sCliente ) + ' ' + sAux;

    if ( sCliente <> 'FL' ) then
    begin
      if (FieldByName('envase_comercial_e').AsString = 'S') then
        QRLCMRInyeccion.agrupacion.Lines.Add('CART?N')
      else QRLCMRInyeccion.agrupacion.Lines.Add('PT.RECICLABLE');
        QRLCMRInyeccion.producto.Lines.Add( sAux );
    end
    else
    begin
      QRLCMRInyeccion.agrupacion.Lines.Add( sAux );
    end;

    marca := FieldByName('marca_sl').AsString;
    env_comer := FieldByName('envase_comercial_e').AsString;
    producto := FieldByName('producto_sl').AsString;
    envase:=  '';
    sEnvaseAux:= '';
    if ( sCliente = 'FL' )  then
        envase:=  FieldByName('envase_sl').AsString;
     ///////////////////////////////////////////////////////////////////////////
    for i := 1 to RecordCount do
    begin
      if ( sCliente = 'FL' )  then
        sEnvaseAux:= FieldByName('envase_sl').AsString;
      if (marca <> FieldByName('marca_sl').AsString) or
         (producto <> FieldByName('producto_sl').AsString) or
         (env_comer <> FieldByName('envase_comercial_e').AsString) or
         (envase <> sEnvaseAux ) then
      begin
            //guardar los campos por los que se agrupa
        marca := FieldByName('marca_sl').AsString;
        env_comer := FieldByName('envase_comercial_e').AsString;
        producto := FieldByName('producto_sl').AsString;
        if ( sCliente = 'FL' )  then
          envase:=  FieldByName('envase_sl').AsString;

            //Pasar los valores al Report
        QRLCMRInyeccion.marcas.Lines.Add(FieldByName('descripcion_m').AsString + ' CAT. ' + FieldByName('categoria_sl').AsString);
        QRLCMRInyeccion.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', icajas));

        sAux:= '';
        if esTomate(sEmpresa, FieldByName('producto_sl').AsString, descripcion, desIngles ) then
        begin

          if ( sCliente = 'FL' )  then
            sAux:= 'TOMATO (' + FieldByName('producto_sl').AsString + ') SPAIN '
          else
            sAux:= 'TOMATE (' + FieldByName('producto_sl').AsString + ') ESPA?A ';
        end
        else
        begin
         if ( sCliente = 'FL' )  then
           sAux:= desIngles + ' (' + FieldByName('producto_sl').AsString + ') SPAIN '
         else
           sAux:= descripcion + ' (' + FieldByName('producto_sl').AsString + ') ESPA?A ';
        end;
        if ( sCliente = 'FL' )  then
          sAux:= desEnvaseCliente( sEmpresa, FieldByName('producto_sl').AsString,
            FieldByName('envase_sl').AsString , sCliente ) + ' ' + sAux;
        if ( sCliente <> 'FL' )  then
        begin
          if (FieldByName('envase_comercial_e').AsString = 'S') then
            QRLCMRInyeccion.agrupacion.Lines.Add('CART?N')
          else QRLCMRInyeccion.agrupacion.Lines.Add('PT.RECICLABLE');
          QRLCMRInyeccion.producto.Lines.Add( sAux );
        end
        else
        begin
          QRLCMRInyeccion.agrupacion.Lines.Add( sAux );
        end;


        QRLCMRInyeccion.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', ipesoBruto));
        iCajas := 0;
        iPesoBruto := 0;
      end;
      if (FieldByName('pesoNetoProducto').AsString <> '') then
        pesoProducto := FieldByName('pesoNetoProducto').AsFloat
      else pesoProducto := 0;
      ipesoBruto := ipesobruto +
                   Trunc( bRoundTo( pesoProducto +
                   GetPesoEnvases( FieldByName('cajas').AsString, FieldByName('envase_sl').AsString, dFecha ) +
                   GetPesoPalets( FieldByName('palets').AsString, FieldByName('tipo_palets_sl').AsString ), 0 ) );
      icajas := icajas + FieldByName('cajas').AsInteger;
      Next;
    end;
    QRLCMRInyeccion.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', ipesoBruto));
    QRLCMRInyeccion.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', icajas));
    QDetallesCMR.Close;
  end;
end;

function TDMCmr.esTomate(const empresa, producto: string;
  var descripcion, desIngles: string): Boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select estomate_p, descripcion_p, descripcion2_p '+
      ' from frf_productos ' +
      ' where producto_p=' + QuotedStr(producto);
    try
      try
        Open;
        if IsEmpty then
        begin
          esTomate := true;
          descripcion := '';
        end
        else
        begin
          esTomate := fields[0].AsString <> 'N';
          descripcion := fields[1].AsString;
          desIngles := fields[2].AsString;
        end
      except
        esTomate := true;
        descripcion := '';
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function TDMCmr.GetPesoEnvases(const ACajas, AEnvase: string; const AFecha: TDateTime ): Extended;
var
  peso, unidades, pesounidad, pesoenvase: Extended;
begin
  if ( sEmpresa = '080' ) and ( AEnvase = '885' ) and ( AFecha <= strToDate('13/3/2017') ) then
  begin
    result:= StrToIntDef( ACajas, 0 ) *  0.71;
    Exit;
  end;
  if ( sEmpresa = '080' ) and ( AEnvase = '886' ) and ( AFecha <= strToDate('9/4/2017') ) then
  begin
    result:= StrToIntDef( ACajas, 0 ) *  0.65;
    Exit;
  end;

  if Trim(QPesoEnvase.SQL.Text) = '' then
    with QPesoEnvase do
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
        '   AND  (envase_e = envase_sl) ' +
        '   AND  (empresa_uc = :emp) ' +
        '   AND  (codigo_uc = tipo_unidad_e)');
    end;
  peso := 0;
  QPesoEnvase.ParamByName('emp').AsString := sEmpresa;
  QPesoEnvase.ParamByName('cen').AsString := sCentro;
  QPesoEnvase.ParamByName('alb').AsString := IntToStr( iAlbaran );
  QPesoEnvase.ParamByName('fec').AsDatetime := dfecha;
  QPesoEnvase.ParamByName('envase').AsString := AEnvase;
  if not QPesoEnvase.Active then
    QPesoEnvase.Open;

  QPesoEnvase.First;
  if (QPesoEnvase.FieldByName('unidades_caja_sl').AsString = '') then
    unidades := 0
  else unidades := QPesoEnvase.FieldByName('unidades_caja_sl').AsFloat;

  if (QPesoEnvase.FieldByName('peso_envase_uc').AsString = '') then
    pesounidad := 0
  else pesounidad := QPesoEnvase.FieldByName('peso_envase_uc').AsFloat;

  if (QPesoEnvase.FieldByName('peso_envase_e').AsString <> '') then
    pesoenvase := QPesoEnvase.FieldByName('peso_envase_e').AsFloat
  else pesoenvase := 0;

//  if (unidades > 1) and (pesounidad > 0) then
//    peso := peso + unidades * pesounidad + pesoenvase
//  else peso := peso + pesoenvase;
  peso := peso + pesoenvase;

  result := StrToIntDef( ACajas, 0 )*  peso;
  QPesoEnvase.Close;
end;

function TDMCmr.GetPesoPalets(const APalets, APalet: string): Extended;
begin
  result:= StrToIntDef( APalets, 0 );
  QPesoPalet.Close;
  with QPesoPalet.SQL do
  begin
    Clear;
    Add(' SELECT kilos_tp ');
    Add(' FROM frf_tipo_palets ');
    Add(' WHERE  codigo_tp = :palet ');
  end;
  QPesoPalet.ParamByName('palet').AsString := APalet;
  QPesoPalet.Open;
  if QPesoPalet.IsEmpty then
    result:= 0
  else
    result:= result * QPesoPalet.FieldByName('kilos_tp').AsFloat;
  QPesoPalet.Close;
end;



//*******************************************************************************
// CMR Transitos
//*******************************************************************************


procedure ExecTransitoCMR(const AEmpresa, ACentro, AReferencia, AFecha, ADestino, ALugarDestino, ATransportista: string;
                       const ADataSource: TDataSource);
begin
  Application.CreateForm( TDMCmr, DMCmr);
  try
    DMCmr.sEmpresa:= AEmpresa;
    DMCmr.sCentro:= ACentro;
    DMCmr.dFecha:= StrToDate( AFecha );
    DMCmr.iAlbaran:= StrToInt( AReferencia );


    DMCmr.sCliente:= ADestino;
    DMCmr.sSuministro:= ALugarDestino;
    DMCmr.sTransporte:= ATransportista;

    DMCmr.bHigiene:= True;
    DMCmr.sNota:= '';

    DMCmr.PreCMRTransito;
  finally
    FreeAndNil( DMCmr );
  end;
end;


procedure TDMCmr.PreCMRTransito;
begin
  try
    CreateDMTransitos( nil );

    with qryTransito do
    begin
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT empresa_tc,centro_tc,referencia_tc,' +
                     'fecha_tc,vehiculo_tc,centro_destino_tc,puerto_tc ');
      SQL.Add('FROM frf_transitos_c  ');
      SQL.Add('WHERE (empresa_tc     = ' + QuotedStr(sEmpresa) + ') ' +
                'And   (centro_tc = ' + QuotedStr(sCentro) + ') ' +
                'And   (referencia_tc = ' + IntToStr( iAlbaran ) + ') ' +
                'And   (fecha_tc = :fecha ) ');
      ParamByName('fecha').asdatetime := dFecha;
      Open;

      try
        QRLCMR := TQRLCMRInyeccion.Create(nil);

        RemitenteTransito;
        CargaTransito;
        ConsignatarioTransito;
        EntregaTransito;
        //DireccionSuministroCMR( AEmpresa, ADestino );


        QRLCMR.LMatricula.Caption := FieldByName('vehiculo_tc').AsString;
        LCMRInyeccion.DatosTransportista( QRLCMR, sEmpresa, sTransporte );


        qryNota.SQL.Clear;
        qryNota.SQL.Add(' SELECT nota_tc, higiene_tc ');
        qryNota.SQL.Add(' FROM frf_transitos_c ');
        qryNota.SQL.Add(' WHERE   (empresa_tc = ' + QuotedStr(sEmpresa) + ') ' );
        qryNota.SQL.Add('    AND  (centro_tc = ' + QuotedStr(sCentro) + ') ' );
        qryNota.SQL.Add('    AND  (referencia_tc = ' + IntToStr( iAlbaran ) + ') ' );
        qryNota.SQL.Add('    AND  (fecha_tc = :fecha ) ');
        qryNota.ParamByName('fecha').asdatetime := dFecha;
        qryNota.Open;

        QRLCMR.cmrObservaciones.Lines.Clear;
        QRLCMR.cmrObservaciones.Lines.Add('N? REFERENCIA: ' + IntToStr( iAlbaran ) );
        if qryNota.FieldByName('higiene_tc').Asinteger = 1  then
        begin
          QRLCMR.cmrObservaciones.Lines.Add('CONDICIONES HIGIENICAS: OK');
        end
        else
        begin
          QRLCMR.cmrObservaciones.Lines.Add('CONDICIONES HIGIENICAS: INCORRECTAS');
        end;
        QRLCMR.cmrObservaciones.Lines.Add( qryNota.FieldByName('nota_tc').AsString );

        QRLCMR.definirDetallesCMR(sEmpresa, sCentro, intToStr( iAlbaran ), FormatDateTime( 'dd/mm/yyyyy', dFecha ) );

        QRLCMR.fecha_sc.DataField := 'fecha_tc';
        QRLCMR.fecha_sc2.DataField := 'fecha_tc';

        QRLCMR.ImprimirCMR( 'T' + intToStr( iAlbaran ), 4, True, True, True );
      finally
        QRLCMR.Free;
        if qryNota.Active then
        begin
          qryNota.Cancel;
          qryNota.Close;
        end;
        Close;
      end;
    end;
  finally
    DestroyDMTransitos;
  end;
end;


procedure TDMCmr.RemitenteTransito;
begin
  //if ( sEmpresa = '050' ) then
  begin
    if ( sCentro = '6' ) then
    begin
      QRLCMR.qrmRemitente.Lines.Clear;
      QRLCMR.qrmRemitente.Lines.Add(' S.A.T. N? 9359 BONNYSA ');
      QRLCMR.qrmRemitente.Lines.Add(' CIF: F03842671 ');
      QRLCMR.qrmRemitente.Lines.Add(' Edificio las Moradas');
      QRLCMR.qrmRemitente.Lines.Add(' Autopista Sur Km. 58,5');
      QRLCMR.qrmRemitente.Lines.Add(' 38617 Granadilla de Abona (S.C. de Tenerife)');
    end
    else
    if ( sCentro = '2' ) then
    begin
      QRLCMR.qrmRemitente.Lines.Clear;
      QRLCMR.qrmRemitente.Lines.Add(' Pol. La Atalaya');
      QRLCMR.qrmRemitente.Lines.Add(' 04600 HUERCAL-OVERA');
      QRLCMR.qrmRemitente.Lines.Add(' ALMERIA');
    end;
  end;
end;


procedure TDMCmr.CargaTransito;
begin
  //if ( sEmpresa = '050' ) then
  begin
    if ( sCentro = '6' ) then
    begin
      QRLCMR.qrmCarga.Lines.Text := 'S/C Tenerife (Espa?a)';
      QRLCMR.LOrigen2.Caption := 'S/C Tenerife';
    end
    else
    if ( sCentro = '2' ) then
    begin
      QRLCMR.qrmCarga.Lines.Text := ' HUERCAL-OVERA';
      QRLCMR.LOrigen2.Caption := ' HUERCAL-OVERA';
    end;
  end;
end;


procedure TDMCmr.ConsignatarioTransito;
begin
  QRLCMR.qrmConsignatario.Lines.Clear;
  QRLCMR.qrmConsignatario.Lines.Add(' S.A.T. N? 9359 BONNYSA');
  QRLCMR.qrmConsignatario.Lines.Add(' Pol. Ind. Los Llanos, S/N');
  QRLCMR.qrmConsignatario.Lines.Add(' 03110 Mutxamel (Alicante)');
end;

procedure TDMCmr.EntregaTransito;
begin
  if dFecha <= StrToDate('6/6/2014') then
    QRLCMR.qrmEntrega.Lines.Text:= 'DDA N? AUT. ESIC03001001'
  else
    QRLCMR.qrmEntrega.Lines.Text:= sSuministro ; //'DAP  ' + desAduana( FieldByname('puerto_tc').AsString );
end;

(*
procedure TQRLCMRInyeccion.DireccionSuministroCMR( const AEmpresa, ACentro: string );
begin
  if ( AEmpresa = '050' ) and ( ACentro = '1' ) then
    Exit;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select descripcion_c, direccion_c, poblacion_c, cod_postal_c, descripcion_p ');
    SQL.Add('from frf_centros, frf_paises  ');
    SQL.Add('where empresa_c = :empresa ');
    SQL.Add('and centro_c = :centro ');
    SQL.Add('and pais_p = pais_c');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    Open;
    if ACentro = '6' then
    begin
      qrmCliente.Lines.Add('S.A.T. N? 9359 BONNYSA ');
    end
    else
    begin
      qrmCliente.Lines.Add( FieldByName('descripcion_c').AsString);
    end;
    qrmCliente.Lines.Add( FieldByName('direccion_c').AsString);
    qrmCliente.Lines.Add( '(' + FieldByName('poblacion_c').AsString + ') ' +
                             FieldByName('cod_postal_c').AsString );
    if ACentro = '6' then
    begin
      qrmCliente.Lines.Add('SANTA CRUZ DE TENERIFE ');
    end;
    qrmCliente.Lines.Add( FieldByName('descripcion_p').AsString);



    QRLCMR.dirSuministro.Lines.Text:= FieldByName('descripcion_p').AsString;
  end;

end;
*)

end.
