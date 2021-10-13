unit LCMRMatricial;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;
type
  TQRLCMRMatricial = class(TQuickRep)
    detalles: TQRBand;
    LRazon: TQRMemo;
    qrmCliente: TQRMemo;
    fecha_sc: TQRDBText;
    marcas: TQRMemo;
    cajas: TQRMemo;
    agrupacion: TQRMemo;
    volumen: TQRMemo;
    producto: TQRMemo;
    LMatricula: TQRLabel;
    qNota: TQuery;
    QDetallesCMR: TQuery;
    QPesoEnvase: TQuery;
    LOrigen2: TQRLabel;
    fecha_sc2: TQRDBText;
    cmrObservaciones: TQRMemo;
    QRImgFirma: TQRImage;
    QPesoPalet: TQuery;
    qrmSuministro: TQRMemo;
    qrmByBAI: TQRMemo;
    qrlblCasilla15: TQRLabel;
    qrmOrigen: TQRMemo;
    procedure detallesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
    procedure DireccionSuministroCMR( const AEmpresa, ACentro: string );
  public
    sFirma: string;

    procedure ImprimirCMR( const ACodigoCMR: string; const ACopias: integer;
                               const ARemitente, ADestino, ATransportista: boolean);

    procedure definirDetallesCMR(const AEmpresa, ACentro, AReferencia,
      AFecha: string);
    function esTomate(const AEmpresa, AProducto: string;
      var ADescripcion: string): Boolean;

    function GetPesoEnvase(const AEmpresa, ACentro, AReferencia,
      AFecha, AEnvase: string): Extended;
    function GetPesoPalet(const APalet: string): Extended;

    procedure ClienteRuso( const ACliente: string );
  end;

var
  QRLCMR: TQRLCMRMatricial;
  QRLCMRMatricial: TQRLCMRMatricial;

procedure PreCMRTran(const AEmpresa, ACentro, AReferencia, AFecha, ADestino: string;
  const ADataSource: TDataSource);

implementation

uses UDMBaseDatos, SysUtils, CVariables, UDMAuxDB, DError;

{$R *.DFM}

procedure PreCMRTran(const AEmpresa, ACentro, AReferencia, AFecha, ADestino: string;
  const ADataSource: TDataSource);
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
      'And   (centro_tc = ' + QuotedStr(ACentro) + ') ' +
      'And   (referencia_tc = ' + AReferencia + ') ' +
      'And   (fecha_tc = :fecha ) ');
    ParamByName('fecha').asdatetime := StrToDate(AFecha);
    Open;
// Definición de la dirección de Suministro de la Carta de Transporte...( C.M.R.)
    try
      QRLCMR := TQRLCMRMatricial.Create(nil);
      QRLCMR.qrmCliente.Lines.Clear;

      // Definición de la dirección de Suministro de la Carta de Transporte...( C.M.R.)
      QRLCMR.DireccionSuministroCMR( AEmpresa, ADestino );

      if ACentro = '2' then
      begin
        //se rellena el memo con el centro de origen
        QRLCMR.LRazon.Lines.Clear;
        QRLCMR.LRazon.Lines.Add(' Pol. La Atalaya');
        QRLCMR.LRazon.Lines.Add(' 04600 HUERCAL-OVERA');
        QRLCMR.LRazon.Lines.Add(' ALMERIA');

        QRLCMR.qrmOrigen.Lines.Text := ' HUERCAL-OVERA';
        QRLCMR.LOrigen2.Caption := ' HUERCAL-OVERA';
      end;

      QRLCMR.qNota.DataSource := ADataSource;
      QRLCMR.qNota.SQL.Clear;
      QRLCMR.qNota.SQL.Add(' SELECT nota_tc, higiene_tc ');
      QRLCMR.qNota.SQL.Add(' FROM frf_transitos_c ');
      QRLCMR.qNota.SQL.Add(' WHERE   (empresa_tc = :empresa_tc) ');
      QRLCMR.qNota.SQL.Add('    AND  (centro_tc = :centro_tc) ');
      QRLCMR.qNota.SQL.Add('    AND  (referencia_tc = :referencia_tc) ');
      QRLCMR.qNota.SQL.Add('    AND  (fecha_tc = :fecha_tc) ');
      QRLCMR.qNota.Open;

      QRLCMR.LMatricula.Caption := FieldByName('vehiculo_tc').AsString;

      QRLCMR.cmrObservaciones.Lines.Clear;
      QRLCMR.cmrObservaciones.Lines.Add('Nº REFERENCIA: ' + AReferencia);
      if QRLCMR.QNota.FieldByName('higiene_tc').Asinteger = 1  then
      begin
        QRLCMR.cmrObservaciones.Lines.Add('CONDICIONES HIGIENICAS: OK');
      end
      else
      begin
        QRLCMR.cmrObservaciones.Lines.Add('CONDICIONES HIGIENICAS: INCORRECTAS');
      end;
      QRLCMR.cmrObservaciones.Lines.Add( QRLCMR.qNota.FieldByName('nota_tc').AsString );

      QRLCMR.definirDetallesCMR(AEmpresa, ACentro, AReferencia, AFecha);

      QRLCMR.fecha_sc.DataField := 'fecha_tc';
      QRLCMR.fecha_sc2.DataField := 'fecha_tc';

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

procedure TQRLCMRMatricial.definirDetallesCMR(const AEmpresa, ACentro, AReferencia,
  AFecha: string);
var pesoBruto, pesoproducto, cajas: Extended;
  marca, producto, envase, env_comer: string;
  i: integer;
  descripcion: string;
begin
  marca := '';
  producto := '';
  envase := '';
  env_comer := '';
  pesobruto := 0;
  cajas := 0;

   //Dejo en blanco los campos del Report
  QRLCMR.marcas.Lines.Clear;
  QRLCMR.cajas.Lines.Clear;
  QRLCMR.agrupacion.Lines.Clear;
  QRLCMR.producto.Lines.Clear;
  QRLCMR.volumen.Lines.Clear;

  with QDetallesCMR do
  begin
    SQL.Clear;
    SQL.Add(' SELECT marca_tl, producto_tl, descripcion_m, envase_comercial_e, envase_tl, tipo_palet_tl, ');
    SQL.Add(' SUM(palets_tl) palets, SUM(cajas_tl) cajas, SUM(kilos_tl) pesoNetoProducto ');
    SQL.Add(' FROM Frf_transitos_l, OUTER Frf_envases, OUTER Frf_marcas ');
    SQL.Add(' WHERE  (envase_tl = envase_e and empresa_e = :emp ) ');
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
      QRLCMR.producto.Lines.Add('TOMATE (' + FieldByName('producto_tl').AsString + ')');
    end
    else
    begin
      QRLCMR.producto.Lines.Add(descripcion + ' (' + FieldByName('producto_tl').AsString + ')');
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
        QRLCMR.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', cajas));
        if (FieldByName('envase_comercial_e').AsString = 'S') then
          QRLCMR.agrupacion.Lines.Add('CARTÓN')
        else QRLCMR.agrupacion.Lines.Add('PT.RECICLABLE');

        if esTomate(AEmpresa, FieldByName('producto_tl').AsString, descripcion) then
        begin
          QRLCMR.producto.Lines.Add('TOMATE (' + FieldByName('producto_tl').AsString + ')');
        end
        else
        begin
          QRLCMR.producto.Lines.Add(descripcion + ' (' + FieldByName('producto_tl').AsString + ')');
        end;


        QRLCMR.volumen.Lines.Add(FormatFloat('###,###,##0.00;-###,###,##0.00;0.00', pesoBruto));
        Cajas := 0;
        PesoBruto := 0;
      end;
      if (FieldByName('pesoNetoProducto').AsString <> '') then
        pesoProducto := FieldByName('pesoNetoProducto').AsFloat
      else pesoProducto := 0;


      pesoBruto := pesobruto + pesoProducto +
                  ( FieldByName('cajas').AsFloat *  GetPesoEnvase(AEmpresa, ACentro, AReferencia, AFecha, FieldByName('envase_tl').AsString) );
      if ( FieldByName('palets').AsFloat <> 0 ) and  ( FieldByName('tipo_palet_tl').AsString <> '' ) then
      begin
        pesoBruto := pesobruto + ( FieldByName('palets').AsFloat *  GetPesoPalet( FieldByName('tipo_palet_tl').AsString) );
      end;


      cajas := cajas + FieldByName('cajas').AsFloat;
      Next;
    end;
    QRLCMR.volumen.Lines.Add(FormatFloat('###,###,##0.00;-###,###,##0.00;0.00', pesoBruto));
    QRLCMR.cajas.Lines.Add(FormatFloat('###,##0;-###,##0', cajas));
    QDetallesCMR.Close;
  end;
end;

function TQRLCMRMatricial.esTomate(const AEmpresa, AProducto: string;
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

function TQRLCMRMatricial.GetPesoPalet(const APalet: string): Extended;
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

function TQRLCMRMatricial.GetPesoEnvase(const AEmpresa, ACentro, AReferencia,
  AFecha, AEnvase: string): Extended;
var
  peso, unidades, pesounidad, pesoenvase: Extended;
begin

  with QPesoEnvase.SQL do
  begin
    Clear;
    Add(' SELECT DISTINCT empresa_tl, centro_tl, ');
    Add(' referencia_tl, fecha_tl, kilos_tl, ');
    Add(' unidades_e,  '); //peso_envase_und_e,
    Add(' peso_envase_e, peso_envase_uc ');
    //Add(' FROM Frf_transitos_l, OUTER Frf_envases ');
    Add(' FROM frf_transitos_l, frf_envases, OUTER frf_und_consumo ');
    Add(' WHERE   (envase_tl = envase_e and empresa_e = :emp ) ');
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

     //if (QCalculoPesoEnvase.FieldByName('peso_envase_und_e').AsString = '') Then
  if (QPesoEnvase.FieldByName('peso_envase_uc').AsString = '') then
    pesounidad := 0
     //Else pesounidad := QCalculoPesoEnvase.FieldByName('peso_envase_und_e').AsFloat;
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

procedure TQRLCMRMatricial.ImprimirCMR( const ACodigoCMR: string; const ACopias: integer;
                               const ARemitente, ADestino, ATransportista: boolean);
var
  i: integer;
begin
  i:= PrinterSettings.PrinterIndex;
  PrinterSettings.PrinterIndex := giPrintMatricial;
  Print;
  PrinterSettings.PrinterIndex:= i;
  (*
  i:= 0;

  if ARemitente then
  begin
    Inc( i );
    lblNumeroPagina.Caption:= '1';
    lblDescripcionHoja.Caption:= 'Ejemplar para el remitente - Exemplaire de l''expéditeur - Copy for sender';
    lblCodigoCMR.Caption:= 'Nº: ' + ACodigoCMR;
    Print;
  end;

  if ADestino then
  begin
    Inc( i );
    lblNumeroPagina.Caption:= '2';
    lblDescripcionHoja.Caption:= 'Ejemplar para el consignatario - Exemplaire du destinataire - Copy for consignee';
    Print;
  end;

  if ATransportista then
  begin
    Inc( i );
    lblNumeroPagina.Caption:= '3';
    lblDescripcionHoja.Caption:= 'Ejemplar para el porteador - Exemplaire du transporteur - Copy for carrier';
    Print;
  end;

  while i < ACopias do
  begin
    Inc( i );
    lblNumeroPagina.Caption:= IntToStr(i);
    lblDescripcionHoja.Caption:= '';
    Print;
  end;
  *)
end;

procedure TQRLCMRMatricial.DireccionSuministroCMR( const AEmpresa, ACentro: string );
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
      qrmCliente.Lines.Add('S.A.T. Nº 9359 BONNYSA ');
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
    qrmSuministro.Lines.Text:= FieldByName('descripcion_p').AsString;
  end;
end;

procedure TQRLCMRMatricial.detallesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //Carga firma si la tiene
  If FileExists( sFirma ) then
  begin
    QRImgFirma.Enabled:= True;
    QRImgFirma.Stretch:= True;
    QRImgFirma.Picture.LoadFromFile( sFirma );
  end
  else
  begin
    QRImgFirma.Enabled:= False;
  end;
end;

procedure TQRLCMRMatricial.ClienteRuso( const ACliente: string );
begin
  qrmByBAI.Lines.Clear;
  if ACliente = 'BAI' then
  begin
    qrmByBAI.Font.Size:= 8;
    qrmByBAI.Left:= 230;
    qrmByBAI.Enabled:= True;
    qrmByBAI.Lines.Add('by order:  ELGH K/S ');
    qrmByBAI.Lines.Add('  Lergravsvej 53 ');
    qrmByBAI.Lines.Add('  2300 Copenhagen S ');
    qrmByBAI.Lines.Add('  Denmark ');
    qrlblCasilla15.Enabled:= False;
  end
  else
  if ACliente = 'BEY' then
  begin
    qrmByBAI.Font.Size:= 8;
    qrmByBAI.Left:= 230;
    qrmByBAI.Enabled:= True;
    qrmByBAI.Lines.Clear;
    qrmByBAI.Lines.Add('by order of "FRUITCOM Inc."');
    qrmByBAI.Lines.Add('  Contract Nº FC-11/06.09 ');
    qrmByBAI.Lines.Add('  OT 01.07.2009 ');
    qrlblCasilla15.Enabled:= True;
  end
  else
  if ACliente = 'UKT' then
  begin
    qrmByBAI.Font.Size:= 6;
    qrmByBAI.Left:= 220;
    qrmByBAI.Enabled:= True;
    qrmByBAI.Lines.Clear;
    qrmByBAI.Lines.Add('By order "TAVITON COMMERCIAL LTD" ');
    qrmByBAI.Lines.Add('Craigmuir Chambers, Road Town, B.V.I. ');
    qrmByBAI.Lines.Add('Contrat Nr:1506/12 from 15.06.2012 ');
    qrlblCasilla15.Enabled:= True;
  end
  else
  begin
    qrmByBAI.Enabled:= False;
    qrlblCasilla15.Enabled:= False;
  end;
end;

end.

