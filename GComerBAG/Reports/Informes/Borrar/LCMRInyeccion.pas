unit LCMRInyeccion;

interface

uses Forms, Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, jpeg;
type
  TQRLCMRInyeccion = class(TQuickRep)
    detalles: TQRBand;
    qrmRemitente: TQRMemo;
    dirSuministro: TQRMemo;
    qrmObservaciones: TQRMemo;
    marcas: TQRMemo;
    qrmCajas: TQRMemo;
    agrupacion: TQRMemo;
    qrmPesoBruto: TQRMemo;
    qrmNaturaleza: TQRMemo;
    LMatricula: TQRLabel;
    QDetallesCMR: TQuery;
    QPesoEnvase: TQuery;
    qrlLugarOrigen2: TQRLabel;
    QRImage: TQRImage;
    lblNumeroPagina: TQRLabel;
    lblDescripcionHoja: TQRLabel;
    lblCodigoCmr: TQRLabel;
    QRMTransportista: TQRMemo;
    QRMClausulas: TQRMemo;
    qNota: TQuery;
    QPesoPalet: TQuery;
    QRImgFirma: TQRImage;
    qrmLugarEntrega: TQRMemo;
    qrmLugarOrigen: TQRMemo;
    qrlblFecha: TQRLabel;
    qrlblFecha2: TQRLabel;
    qrmTransporte2: TQRMemo;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);

  private
     procedure DireccionCentroCMR( const AEmpresa, ACentro: string;
                 var ADireccion: TStringList; var APais, APoblacion: string );

  public
    sFirma: string;

    procedure ImprimirCMR( const ACodigoCMR: string; const ACopias: integer;
                           const ARemitente, ADestino, ATransportista: boolean);

    procedure definirDetallesCMR(const AEmpresa, ACentro, AReferencia,
      AFecha: string);
    function esTomate(const AEmpresa, AProducto: string;
      var ADescripcion: string): Boolean;

    function GetPesoEnvase(const AEmpresa, ACentro, AReferencia, AFecha, AEnvase: string): Extended;
    function GetPesoPalet(const APalet: string): Extended;

    constructor Create( AOwner: TComponent ); Override;

  end;

var
  QRLCMR: TQRLCMRInyeccion;
  QRLCMRInyeccion: TQRLCMRInyeccion;

procedure PreCMRTran(const AEmpresa, APlantaOrigen, ACentroOrigen, AReferencia, AFecha,
                           APlantaDestino, ACentroDestino, ATransportista: string;
                           const ADataSource: TDataSource);
procedure DatosTransportista( var AReport: TQRLCMRInyeccion; const AEmpresa, ATransportista:string );

implementation

uses UDMBaseDatos, SysUtils, CVariables, UDMAuxDB, DError, DPreview, UDMConfig, Dialogs,
     DatosCMRDD, bMath;

{$R *.DFM}

procedure PreCMRTran(const AEmpresa, APlantaOrigen, ACentroOrigen, AReferencia, AFecha,
                           APlantaDestino, ACentroDestino, ATransportista: string;
                           const ADataSource: TDataSource);
var
  aux: TStringList;
  sPais, sPoblacion: string;
begin
     // Previsualización del segundo Informe para Salidas...
  with DMBaseDatos.QListado do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('SELECT empresa_tc,centro_tc,referencia_tc,' +
      'fecha_tc,vehiculo_tc,centro_destino_tc ');
    SQL.Add('FROM frf_transitos_c  ');
    SQL.Add('WHERE (empresa_tc     = ' + QuotedStr(AEmpresa) + ') ' +
      'And   (centro_tc = ' + QuotedStr(ACentroOrigen) + ') ' +
      'And   (referencia_tc = ' + AReferencia + ') ' +
      'And   (fecha_tc = :fecha ) ');
    ParamByName('fecha').asdatetime := StrToDate(AFecha);
    Open;

    try
      QRLCMR := TQRLCMRInyeccion.Create(nil);

      QRLCMR.qrlblFecha.Caption:= FieldByName('fecha_tc').AsString;
      QRLCMR.qrlblFecha2.Caption:= FieldByName('fecha_tc').AsString;
      // Definición de la dirección de Suministro de la Carta de Transporte...( C.M.R.)
      aux := TStringList.Create;
      try
        QRLCMR.DireccionCentroCMR( APlantaOrigen, ACentroOrigen, aux, sPais, sPoblacion );
        QRLCMR.qrmLugarOrigen.Lines.Text:= sPoblacion;
        QRLCMR.qrlLugarOrigen2.Caption:= sPoblacion;
        QRLCMR.qrmRemitente.Lines.Clear;
        QRLCMR.qrmRemitente.Lines.AddStrings( aux );

        aux.Clear;
        QRLCMR.DireccionCentroCMR( APlantaDestino, ACentroDestino, aux, sPais, sPoblacion );
        QRLCMR.qrmLugarEntrega.Lines.Text:= sPais;
        QRLCMR.dirSuministro.Lines.Clear;
        QRLCMR.dirSuministro.Lines.AddStrings( aux );
      finally
        FreeAndNil( aux );
      end;
      QRLCMR.LMatricula.Caption := FieldByName('vehiculo_tc').AsString;
      LCMRInyeccion.DatosTransportista( QRLCMR, AEmpresa, ATransportista );


      QRLCMR.qNota.DataSource := ADataSource;
      QRLCMR.qNota.SQL.Clear;
      QRLCMR.qNota.SQL.Add(' SELECT nota_tc ');
      QRLCMR.qNota.SQL.Add(' FROM frf_transitos_c ');
      QRLCMR.qNota.SQL.Add(' WHERE   (empresa_tc = :empresa_tc) ');
      QRLCMR.qNota.SQL.Add('    AND  (centro_tc = :centro_tc) ');
      QRLCMR.qNota.SQL.Add('    AND  (referencia_tc = :referencia_tc) ');
      QRLCMR.qNota.SQL.Add('    AND  (fecha_tc = :fecha_tc) ');
      QRLCMR.qNota.Open;

      QRLCMR.qrmObservaciones.Lines.Clear;
      QRLCMR.qrmObservaciones.Lines.Add('Nº REFERENCIA: ' + AReferencia);
      if not QRLCMR.qNota.IsEmpty then
      begin
        aux := TStringList.Create;
        aux.Text := QRLCMR.qNota.FieldByName('nota_tc').AsString;
        QRLCMR.qrmObservaciones.Lines.AddStrings(aux);
        aux.Free;
      end;

      QRLCMR.definirDetallesCMR(AEmpresa, ACentroOrigen, AReferencia, AFecha);

      //QRLCMR.fecha_sc.DataField := 'fecha_tc';
      //QRLCMR.fecha_sc2.DataField := 'fecha_tc';

      QRLCMR.ImprimirCMR( 'T' + AReferencia, 4, True, True, True );
    finally
      QRLCMR.Free;
      if QRLCMR.qNota.Active then
      begin
        QRLCMR.qNota.Cancel;
        QRLCMR.qNota.Close;
      end;
      Close;
    end;
  end;
end;

constructor TQRLCMRInyeccion.Create( AOwner: TComponent );
begin
  inherited;
  QRImage.Picture.LoadFromFile(gsDirActual + '\recursos\cmr.jpg');
  QRImage.Refresh;
  Application.ProcessMessages;
end;

procedure TQRLCMRInyeccion.definirDetallesCMR(const AEmpresa, ACentro, AReferencia,
  AFecha: string);
var
  pesoproducto: extended;
  ipesoBruto,  icajas: Integer;
  marca, producto, envase, env_comer: string;
  i: integer;
  descripcion: string;
begin
  marca := '';
  producto := '';
  envase := '';
  env_comer := '';
  ipesobruto := 0;
  icajas := 0;

   //Dejo en blanco los campos del Report
  QRLCMR.marcas.Lines.Clear;
  QRLCMR.qrmCajas.Lines.Clear;
  QRLCMR.agrupacion.Lines.Clear;
  QRLCMR.qrmNaturaleza.Lines.Clear;
  QRLCMR.qrmPesoBruto.Lines.Clear;

  with QDetallesCMR do
  begin
    SQL.Clear;
    SQL.Add(' SELECT marca_tl, producto_tl, descripcion_m, envase_comercial_e, envase_tl, tipo_palet_tl, ');
    SQL.Add('        SUM(palets_tl) palets, SUM(cajas_tl) cajas, SUM(kilos_tl) pesoNetoProducto ');
    SQL.Add(' FROM Frf_transitos_l, OUTER Frf_envases, OUTER Frf_marcas ');
    SQL.Add(' WHERE   (envase_tl = envase_e and empresa_e = :emp and ');
    SQL.Add('          producto_base_e = ( select producto_base_p from frf_productos ');
    SQL.Add('                              where empresa_p = :emp and producto_p = producto_tl ) ) ');
    SQL.Add('    AND  (marca_tl = codigo_m) ');
    SQL.Add('    AND  ( (empresa_tl =:emp) ');
    SQL.Add('    AND  (centro_tl = :cen) ');
    SQL.Add('    AND  (referencia_tl = :alb) ');
    SQL.Add('    AND  (fecha_tl =:fec) ) ');
    SQL.Add(' GROUP BY marca_tl, descripcion_m, envase_comercial_e, producto_tl,envase_tl, tipo_palet_tl ');
    SQL.Add(' ORDER BY descripcion_m, envase_comercial_e, producto_tl ');
    try
      Close;
      ParamByName('emp').AsString := AEmpresa;
      ParamByName('cen').AsString := ACentro;
      ParamByName('alb').AsString := AReferencia;
      ParamByName('fec').AsDatetime := StrToDate(AFecha);
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
    QRLCMR.marcas.Lines.Add(FieldByName('descripcion_m').AsString);
     //QRLCMR.cajas.Lines.Add(FormatFloat('###,##0;-###,##0',FieldByName('cajas').AsFloat));
    if (FieldByName('envase_comercial_e').AsString = 'S') then
      QRLCMR.agrupacion.Lines.Add('CARTÓN')
    else QRLCMR.agrupacion.Lines.Add('PT.RECICLABLE');

    if esTomate(AEmpresa, FieldByName('producto_tl').AsString, descripcion) then
    begin
      QRLCMR.qrmNaturaleza.Lines.Add('TOMATE (' + FieldByName('producto_tl').AsString + ')');
    end
    else
    begin
      QRLCMR.qrmNaturaleza.Lines.Add(descripcion + ' (' + FieldByName('producto_tl').AsString + ')');
    end;

    marca := FieldByName('marca_tl').AsString;
    env_comer := FieldByName('envase_comercial_e').AsString;
    producto := FieldByName('producto_tl').AsString;
     ///////////////////////////////////////////////////////////////////////////
    for i := 1 to RecordCount do
    begin
      if (marca <> FieldByName('marca_tl').AsString) or
        (producto <> FieldByName('producto_tl').AsString) or
        (env_comer <> FieldByName('envase_comercial_e').AsString) then
      begin
            //guardar los campos por los que se agrupa
        marca := FieldByName('marca_tl').AsString;
        env_comer := FieldByName('envase_comercial_e').AsString;
        producto := FieldByName('producto_tl').AsString;

            //Pasar los valores al Report
        QRLCMR.marcas.Lines.Add(FieldByName('descripcion_m').AsString);
        QRLCMR.qrmCajas.Lines.Add(FormatFloat('###,##0;-###,##0', icajas));
        if (FieldByName('envase_comercial_e').AsString = 'S') then
          QRLCMR.agrupacion.Lines.Add('CARTÓN')
        else QRLCMR.agrupacion.Lines.Add('PT.RECICLABLE');

        if esTomate(AEmpresa, FieldByName('producto_tl').AsString, descripcion) then
        begin
          QRLCMR.qrmNaturaleza.Lines.Add('TOMATE (' + FieldByName('producto_tl').AsString + ')');
        end
        else
        begin
          QRLCMR.qrmNaturaleza.Lines.Add(descripcion + ' (' + FieldByName('producto_tl').AsString + ')');
        end;


        QRLCMR.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', ipesoBruto));
        iCajas := 0;
        iPesoBruto := 0;
      end;
      if (FieldByName('pesoNetoProducto').AsString <> '') then
        pesoProducto := FieldByName('pesoNetoProducto').AsFloat
      else pesoProducto := 0;

      ipesoBruto := ipesobruto + Trunc( broundto( pesoProducto +
                  ( FieldByName('cajas').AsFloat *  GetPesoEnvase(AEmpresa, ACentro, AReferencia, AFecha, FieldByName('envase_tl').AsString) ), 2) );
      if ( FieldByName('palets').AsFloat <> 0 ) and  ( FieldByName('tipo_palet_tl').AsString <> '' ) then
      begin
        ipesoBruto := ipesobruto + Trunc( broundto( ( FieldByName('palets').AsFloat *  GetPesoPalet( FieldByName('tipo_palet_tl').AsString) ),0) );
      end;

      icajas := icajas + FieldByName('cajas').AsInteger;
      Next;
    end;
    QRLCMR.qrmPesoBruto.Lines.Add(FormatFloat('###,###,##0;-###,###,##0;0', ipesoBruto));
    QRLCMR.qrmCajas.Lines.Add(FormatFloat('###,##0;-###,##0', icajas));
    QDetallesCMR.Close;
  end;
end;

function TQRLCMRInyeccion.esTomate(const AEmpresa, AProducto: string;
  var ADescripcion: string): Boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select estomate_p, descripcion_p from frf_productos ' +
      ' where empresa_p=' + QuotedStr(AEmpresa) +
      ' and producto_p=' + QuotedStr(AProducto);
    try
      try
        Open;
        if IsEmpty then
        begin
          esTomate := true;
          ADescripcion := '';
        end
        else
        begin
          esTomate := fields[0].AsString <> 'N';
          ADescripcion := fields[1].AsString;
        end
      except
        esTomate := true;
        ADescripcion := '';
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function TQRLCMRInyeccion.GetPesoPalet(const APalet: string): Extended;
var
  sAux: String;
begin
  with QPesoPalet do
  begin
    SQL.Clear;
    SQL.Add(' select kilos_tp, descripcion_tp from frf_tipo_palets where codigo_tp = :palet ');
    ParamByName('palet').AsString := APalet;
    Open;
    if FieldByName('kilos_tp').AsFloat = 0 then
    begin
      sAux:= 'Falta grabar el peso del palet ' + APalet + ' - ' + FieldByName('descripcion_tp').AsString;
      Close;
      raise Exception.Create( sAux );
    end;
    result:= FieldByName('kilos_tp').AsFloat;
    Close;
  end;
end;


function TQRLCMRInyeccion.GetPesoEnvase(const AEmpresa, ACentro, AReferencia,
  AFecha, AEnvase: string): Extended;
var peso, unidades, pesounidad, pesoenvase: Extended;
begin

  with QPesoEnvase.SQL do
  begin
    Clear;
    Add(' SELECT DISTINCT empresa_tl, centro_tl, ');
    Add(' referencia_tl, fecha_tl, kilos_tl, ');
    Add(' unidades_e,  '); //peso_envase_und_e,
    Add(' peso_envase_e, peso_envase_uc ');
    Add(' FROM frf_transitos_l, frf_envases, OUTER frf_und_consumo ');
    Add(' WHERE   (envase_tl = envase_e and empresa_e = :emp and ');
    Add('          producto_base_e = ( select producto_base_p from frf_productos ');
    Add('                              where empresa_p = :emp and producto_p = producto_tl ) ) ');
    Add('    AND  (empresa_uc = empresa_e)');
    Add('    AND  (codigo_uc = tipo_unidad_e) ');
    Add('    AND  ( (empresa_tl =:emp) ');
    Add('    AND  (centro_tl =:cen) ');
    Add('    AND  (referencia_tl =:alb) ');
    Add('    AND  (fecha_tl = :fec) ');
    Add('    AND  (envase_tl= :envase)) ');
  end;

  peso := 0;
  QPesoEnvase.ParamByName('emp').AsString := AEmpresa;
  QPesoEnvase.ParamByName('cen').AsString := ACentro;
  QPesoEnvase.ParamByName('alb').AsString := AReferencia;
  QPesoEnvase.ParamByName('fec').AsDatetime := StrToDate(AFecha);
  QPesoEnvase.ParamByName('envase').AsString := AEnvase;
  if not QPesoEnvase.Active then
    QPesoEnvase.Open;

  QPesoEnvase.First;
  if (QPesoEnvase.FieldByName('unidades_e').AsString = '') then
    unidades := 0
  else unidades := QPesoEnvase.FieldByName('unidades_e').AsFloat;

  if (QPesoEnvase.FieldByName('peso_envase_uc').AsString = '') then
    pesounidad := 0
  else pesounidad := QPesoEnvase.FieldByName('peso_envase_uc').AsFloat;

  if (QPesoEnvase.FieldByName('peso_envase_e').AsString <> '') then
    pesoenvase := QPesoEnvase.FieldByName('peso_envase_e').AsFloat
  else pesoenvase := 0;

  if (unidades > 1) and (pesounidad > 0) then
    peso := peso + unidades * pesounidad + pesoenvase
  else peso := peso + pesoenvase;

  result := peso;
  QPesoEnvase.Close;
end;

procedure TQRLCMRInyeccion.ImprimirCMR( const ACodigoCMR: string; const ACopias: integer;
                               const ARemitente, ADestino, ATransportista: boolean);
var
  i, iCopias: integer;
begin
  i:= 0;

  lblCodigoCMR.Caption:= 'Nº: ' + ACodigoCMR;

  DPreview.Imprimir:= False;
  DPreview.Preview( self, ACopias );
  DPreview.Imprimir:= True;
  iCopias:= self.PrinterSettings.Copies;
  self.PrinterSettings.Copies:= 1;

  if not DPreview.PressBtnPrint then
    Exit;

  if ( iCopias > 0 ) and ARemitente then
  begin
    Inc( i );
    lblNumeroPagina.Caption:= '1';
    lblDescripcionHoja.Caption:= 'Ejemplar para el remitente - Exemplaire de l''expéditeur - Copy for sender';
    Print;
  end;

  if ( iCopias > 1 ) and ADestino then
  begin
    Inc( i );
    lblNumeroPagina.Caption:= '2';
    lblDescripcionHoja.Caption:= 'Ejemplar para el consignatario - Exemplaire du destinataire - Copy for consignee';
    Print;
  end;

  if ( iCopias > 2 ) and ATransportista then
  begin
    Inc( i );
    lblNumeroPagina.Caption:= '3';
    lblDescripcionHoja.Caption:= 'Ejemplar para el porteador - Exemplaire du transporteur - Copy for carrier';
    Print;
  end;

  while i < iCopias do
  begin
    Inc( i );
    lblNumeroPagina.Caption:= IntToStr(i);
    lblDescripcionHoja.Caption:= '';
    Print;
  end;
end;

procedure TransportitaCasilla16( var AReport: TQRLCMRInyeccion; const AEmpresa, ATransportista:string );
begin
  AReport.QRMTransportista.Lines.Clear;
  AReport.QRMClausulas.Lines.Clear;

  if ( ATransportista <> '00' ) and ( ATransportista <> '0' ) then
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_transportistas where empresa_t = :empresa and transporte_t = :transporte ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('transporte').AsString:= ATransportista;
    try
      Open;
      if FieldByName('descripcion_t').AsString <> '' then
      begin
        if FieldByName('cif_t').AsString <> '' then
        begin
          AReport.QRMTransportista.Lines.Add( FieldByName('descripcion_t').AsString +
                                              '   CIF: ' + FieldByName('cif_t').AsString );
        end
        else
        begin
          AReport.QRMTransportista.Lines.Add( FieldByName('descripcion_t').AsString );
        end;
      end
      else
      begin
        if FieldByName('cif_t').AsString <> '' then
          AReport.QRMTransportista.Lines.Add( 'CIF: ' + FieldByName('cif_t').AsString );
      end;
      if FieldByName('direccion2_t').AsString <> '' then
      begin
        AReport.QRMTransportista.Lines.Add( FieldByName('direccion1_t').AsString );
        AReport.QRMTransportista.Lines.Add( FieldByName('direccion2_t').AsString );
      end
      else
      begin
        if FieldByName('direccion1_t').AsString <> '' then
          AReport.QRMTransportista.Lines.Add( FieldByName('direccion1_t').AsString );
      end;
      if FieldByName('telefono_t').AsString <> '' then
      begin
        if FieldByName('fax_t').AsString <> '' then
        begin
          AReport.QRMTransportista.Lines.Add( 'TELEFONO: ' + FieldByName('telefono_t').AsString +
                                              '   FAX: ' + FieldByName('fax_t').AsString );
        end
        else
        begin
          AReport.QRMTransportista.Lines.Add( 'TELEFONO: ' + FieldByName('telefono_t').AsString );
        end;
      end
      else
      begin
        if FieldByName('fax_t').AsString <> '' then
          AReport.QRMTransportista.Lines.Add( 'FAX: ' + FieldByName('fax_t').AsString );
      end;
      if FieldByName('notas_t').AsString <> '' then
        AReport.QRMClausulas.Lines.Add( FieldByName('notas_t').AsString );
    finally
      Close;
    end;
  end;
end;

procedure TQRLCMRInyeccion.DireccionCentroCMR( const AEmpresa, ACentro: string;
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

    APoblacion:= FieldByName('poblacion_c').AsString;
    APais := FieldByName('descripcion_p').AsString;

    Close;
  end;
end;

procedure TQRLCMRInyeccion.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  //Carga firma si la tiene
  If FileExists( sFirma ) then
  begin
    QRImgFirma.Enabled:= True;
    QRImgFirma.Stretch:= True;
    QRImgFirma.Picture.LoadFromFile( sFirma );
  end;
end;

procedure TransportitaCasilla23( var AReport: TQRLCMRInyeccion; const AEmpresa, ATransportista:string );
begin
  AReport.qrmTransporte2.Lines.Clear;

  AReport.qrmTransporte2.Lines.Add( 'CARGADOR CONTRACTUAL:' );
  if ( ATransportista <> '00' ) and ( ATransportista <> '0' ) then
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_transportistas where empresa_t = :empresa and transporte_t = :transporte ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('transporte').AsString:= ATransportista;
    try
      Open;
      if FieldByName('descripcion_t').AsString <> '' then
      begin
        if Trim(FieldByName('cif_t').AsString) <> '' then
        begin
          AReport.qrmTransporte2.Lines.Add( FieldByName('descripcion_t').AsString +
                                              '   CIF: ' + FieldByName('cif_t').AsString );
        end
        else
        begin
          AReport.qrmTransporte2.Lines.Add( FieldByName('descripcion_t').AsString );
        end;
      end
      else
      begin
        if Trim(FieldByName('cif_t').AsString) <> '' then
          AReport.qrmTransporte2.Lines.Add( 'CIF: ' + FieldByName('cif_t').AsString );
      end;
      if FieldByName('direccion2_t').AsString <> '' then
      begin
        AReport.qrmTransporte2.Lines.Add( FieldByName('direccion1_t').AsString );
        AReport.qrmTransporte2.Lines.Add( FieldByName('direccion2_t').AsString );
      end
      else
      begin
        if FieldByName('direccion1_t').AsString <> '' then
          AReport.qrmTransporte2.Lines.Add( FieldByName('direccion1_t').AsString );
      end;
      if FieldByName('telefono_t').AsString <> '' then
      begin
        if FieldByName('fax_t').AsString <> '' then
        begin
          AReport.qrmTransporte2.Lines.Add( 'TELEFONO: ' + FieldByName('telefono_t').AsString +
                                              '   FAX: ' + FieldByName('fax_t').AsString );
        end
        else
        begin
          AReport.qrmTransporte2.Lines.Add( 'TELEFONO: ' + FieldByName('telefono_t').AsString );
        end;
      end
      else
      begin
        if FieldByName('fax_t').AsString <> '' then
          AReport.qrmTransporte2.Lines.Add( 'FAX: ' + FieldByName('fax_t').AsString );
      end;
    finally
      Close;
    end;
  end;
end;

procedure DatosTransportista( var AReport: TQRLCMRInyeccion; const AEmpresa, ATransportista:string );
begin
  if ( ( AEmpresa = '080' ) or  ( AEmpresa = '050' ) ) and ( ATransportista = '10' ) then
  begin
    //TransportitaCasilla16( AReport, AEmpresa, ATransportista );
    AReport.QRMTransportista.Lines.Clear;
    TransportitaCasilla23( AReport, AEmpresa, ATransportista );
  end
  else
  begin
    TransportitaCasilla16( AReport, AEmpresa, ATransportista );
    TransportitaCasilla23( AReport, AEmpresa, ATransportista );
  end;
end;

end.


