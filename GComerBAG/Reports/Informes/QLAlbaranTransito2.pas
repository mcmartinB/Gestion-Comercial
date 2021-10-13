
unit QLAlbaranTransito2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, StdCtrls,
  ExtCtrls, Forms, Quickrpt, QRCtrls, dbtables, db, jpeg;

type
  TQRLAlbaranTransito2 = class(TQuickRep)
    bandaFinal: TQRBand;
    CabeceraAlbaran: TQRChildBand;
    BandaCentro: TQRChildBand;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    qfecha_tc: TQRDBText;
    qreferencia_tc: TQRDBText;
    PsQRLabel11: TQRLabel;
    PsQRLabel12: TQRLabel;
    qvehiculo_tc: TQRDBText;
    PsQRShape23: TQRShape;
    PsQRShape24: TQRShape;
    PsQRShape22: TQRShape;
    PsQRShape21: TQRShape;
    PsQRShape27: TQRShape;
    PsQRShape19: TQRShape;
    PsQRSysData1: TQRSysData;
    PsQRLabel2: TQRLabel;
    qtransporte_tc: TQRDBText;
    qcentro_tc: TQRDBText;
    LTrans: TQRLabel;
    PsQRShape2: TQRShape;
    qbuque_tc: TQRDBText;
    qdestino_tc: TQRDBText;
    PsQRShape7: TQRShape;
    PsQRLabel16: TQRLabel;
    PsQRShape8: TQRShape;
    PsQRShape1: TQRShape;
    PsQRShape9: TQRShape;
    PsQRShape11: TQRShape;
    PsQRShape12: TQRShape;
    PsQRShape13: TQRShape;
    qcentro_destino_tc: TQRDBText;
    PsQRShape14: TQRShape;
    PsQRShape15: TQRShape;
    PsQRShape18: TQRShape;
    BandaObservaciones: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRShape4: TQRShape;
    LCajas: TQRLabel;
    LKilos: TQRLabel;
    PsQRShape3: TQRShape;
    bndPalets: TQRChildBand;
    bandaDetalle: TQRBand;
    kilos_tl: TQRDBText;
    envase_tl: TQRDBText;
    descripcion_m: TQRDBText;
    color_tl: TQRDBText;
    calibre_tl: TQRDBText;
    descripcion_p: TQRDBText;
    lin1: TQRShape;
    lin2: TQRShape;
    lin3: TQRShape;
    lin4: TQRShape;
    lin5: TQRShape;
    lin6: TQRShape;
    cajas_tl: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel22: TQRLabel;
    PsQRLabel23: TQRLabel;
    PsQRLabel24: TQRLabel;
    PsQRLabel25: TQRLabel;
    PsQRLabel26: TQRLabel;
    PsQRLabel27: TQRLabel;
    PsQRLabel28: TQRLabel;
    PsQRShape29: TQRShape;
    PsQRShape30: TQRShape;
    PsQRShape31: TQRShape;
    PsQRShape32: TQRShape;
    PsQRShape33: TQRShape;
    PsQRShape34: TQRShape;
    ChildBand2: TQRChildBand;
    LObservaciones: TQRLabel;
    Observaciones: TQRMemo;
    qrmPalets: TQRMemo;
    qrlPalets: TQRLabel;
    BonnyBand: TQRBand;
    QRImageCab: TQRImage;
    PsEmpresa: TQRLabel;
    PsDireccion: TQRLabel;
    PsNif: TQRLabel;
    qrmCajas: TQRMemo;
    qrlCajas: TQRLabel;
    qreplanta_origen_tc: TQRDBText;
    qreplanta_destino_tc: TQRDBText;
    QListado: TQuery;
    QNota: TQuery;
    qrlbl1: TQRLabel;
    qrshp1: TQRShape;
    qrshp2: TQRShape;
    unidades_caja_tl: TQRDBText;
    procedure QRLAlbaranTransitoBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BandaObservacionesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRSubDetail1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bandaDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure envase_tlPrint(sender: TObject; var Value: String);
    procedure qreplanta_origen_tcPrint(sender: TObject; var Value: String);
    procedure qreplanta_destino_tcPrint(sender: TObject;
      var Value: String);
    procedure qcentro_tcPrint(sender: TObject; var Value: String);
    procedure qcentro_destino_tcPrint(sender: TObject; var Value: String);
//    procedure nota_tnPrint(sender: TObject; var Value: String);
  private
    totalCajas: Integer;
    totalKilos: Real;

    sEmpresa, sPlantaOrigen, sPlantaDestino: String;

    function  CargaPaletsYCajas( const AEmpresa, ACentro: string; const ATransito: integer;
                          const AFecha: TDateTime ): boolean;
  public
    subdetalles: integer;

    procedure Configurar(Empresa: string);

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

procedure ALbaran(const AEmpresa, ACentro, AReferencia, AFecha,
  ADestino, ATransporte, ACMR: string; const ADataSet: TDataSet);
var
  QRLAlbaranTransito2: TQRLAlbaranTransito2;

implementation

uses UDMAuxDB, CVariables, DError, UDMBaseDatos, DPreview, bTextUtils,
  UDMConfig;

{$R *.DFM}

constructor TQRLAlbaranTransito2.Create(AOwner: TComponent);
begin
  inherited;

  tag := 1;
end;

destructor TQRLAlbaranTransito2.Destroy;
begin
  QListado.close;
  QNota.Close;

  inherited;
end;

procedure TQRLAlbaranTransito2.Configurar(Empresa: string);
var
  bAux: Boolean;
  sAux: string;
  ssEmpresa: string;
begin
  if Copy( Empresa, 1, 1 ) = 'F' then
    ssEmpresa:= 'BAG'
  else
    ssEmpresa:= Empresa;
  bAux:= FileExists( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
  if bAux then
  begin
    QRImageCab.Top:= -18; //-20
    QRImageCab.Left:= -37; //-20
    QRImageCab.Width:= 763; //-30
    QRImageCab.Height:= 1102; //-20
    QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
    QRImageCab.Stretch:= True;
    QRImageCab.Enabled:= True;
  end
  else
  begin
    QRImageCab.Enabled:= False;
    ConsultaOpen(DMAuxDB.QAux,
      ' select nombre_e,nif_e,tipo_via_e,domicilio_e,cod_postal_e, ' +
      '        poblacion_e,nombre_p ' +
      ' from frf_empresas,frf_provincias ' +
      ' where empresa_e=' + QuotedStr(Trim(Empresa)) +
      '   and cod_postal_e[1,2]=codigo_p');

    with DMAuxDB.QAux do
    begin
      PsEmpresa.Caption := FieldByName('nombre_e').AsString;
      PsNif.Caption := 'NIF: ' + FieldByName('nif_e').AsString;

      sAux := '';
      if Trim(FieldByName('tipo_via_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('tipo_via_e').AsString) + '. ';
      if Trim(FieldByName('domicilio_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('domicilio_e').AsString) + '      ';
      if Trim(FieldByName('cod_postal_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('cod_postal_e').AsString) + '  ';
      if Trim(FieldByName('poblacion_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('poblacion_e').AsString) + '      ';
      if Trim(FieldByName('cod_postal_e').AsString) <> '' then
       sAux := sAux + '(' + Trim(FieldByName('nombre_p').AsString) + ')  ';

      PsDireccion.Caption := sAux;

      Close;
    end;
  end;

  PsDireccion.Enabled:= not bAux;
  PsEmpresa.Enabled:= not bAux;
  PsNif.Enabled:= not bAux;
end;
procedure TQRLAlbaranTransito2.QRLAlbaranTransitoBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  totalCajas := 0;
  totalKilos := 0;

  subdetalles := 0;
end;

function TQRLAlbaranTransito2.CargaPaletsYCajas( const AEmpresa, ACentro: string;
                                           const ATransito: integer;
                                           const AFecha: TDateTime ): boolean;
begin
  result:= True;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_palet_tl, descripcion_tp, sum( palets_tl ) palets ');
    SQL.Add(' from frf_transitos_l, frf_tipo_palets  ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :centro ');
    SQL.Add(' and referencia_tl = :referencia ');
    SQL.Add(' and fecha_tl = :fecha ');
    SQL.Add(' and codigo_tp = tipo_palet_tl ');
    SQL.Add(' group by tipo_palet_tl, descripcion_tp ');
    SQL.Add(' order by tipo_palet_tl ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('referencia').AsInteger:= ATransito;
    ParamByName('fecha').AsDateTime:= AFecha;
    Open;

    qrmPalets.Lines.Clear;
    while not Eof do
    begin
      qrmPalets.Lines.Add( FieldByName('descripcion_tp').AsString + ' : ' + FieldByName('palets').AsString );
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add(' select cod_producto_ecp codigo_caja_e, des_producto_ecp texto_caja_e, sum(cajas_tl) cajas ');
    SQL.Add(' from frf_transitos_l, frf_envases, frf_env_comer_productos ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :centro ');
    SQL.Add(' and referencia_tl = :referencia ');
    SQL.Add(' and fecha_tl = :fecha ');

    SQL.Add(' and envase_e = envase_tl ');
    SQL.Add(' and producto_e = producto_tl ');

    SQL.Add(' and env_comer_operador_e = cod_operador_ecp ');
    SQL.Add(' and env_comer_producto_e = cod_producto_ecp ');
    SQL.Add(' group by 1, 2 ');
    SQL.Add(' order by 2 ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('referencia').AsInteger:= ATransito;
    ParamByName('fecha').AsDateTime:= AFecha;
    Open;

    qrmCajas.Lines.Clear;
    while not Eof do
    begin
      qrmCajas.Lines.Add( FieldByName('texto_caja_e').AsString + ' : ' + FieldByName('cajas').AsString );
      Next;
    end;
    Close;
  end;
end;

procedure TQRLAlbaranTransito2.BandaObservacionesBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  LCajas.Caption := FormatFloat('#,##0', totalCajas);
  LKilos.Caption := FormatFloat('#,##0.00', totalKilos);

  qrlPalets.Enabled:= qrmPalets.Lines.Count > 0;
  qrlCajas.Enabled:= qrmCajas.Lines.Count > 0;
  bndPalets.Enabled:= qrlPalets.Enabled or qrlCajas.Enabled;
end;

procedure TQRLAlbaranTransito2.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := not QNota.IsEmpty;
end;

procedure TQRLAlbaranTransito2.QRSubDetail1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := subdetalles < 2;
end;

procedure TQRLAlbaranTransito2.QRSubDetail1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Inc(subdetalles);
end;

procedure TQRLAlbaranTransito2.bandaDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  totalCajas := totalCajas + QListado.FieldByName('cajas_tl').AsInteger;
  totalKilos := totalKilos + QListado.FieldByName('kilos_tl').AsFloat;
end;

procedure ALbaran(const AEmpresa, ACentro, AReferencia, AFecha,
  ADestino, ATransporte, ACMR: string; const ADataSet: TDataSet);
begin
  //Imprimir albaran
  try
    QRLAlbaranTransito2 := TQRLAlbaranTransito2.Create(Application);
    with QRLAlbaranTransito2 do
    begin
      //Maset-Bonnysa
      Configurar(AEmpresa);
      sEmpresa:= AEmpresa;
      sPlantaOrigen:= ADataSet.FieldByname('planta_origen_tc').AsString;
      sPlantaDestino:= ADataSet.FieldByname('planta_destino_tc').AsString;

      //Transporte
      LTrans.Caption := desTransporte(Aempresa, ATransporte);
      //Palets
      CargaPaletsYCajas( AEmpresa, ACentro, StrToIntDef(AReferencia, 0), StrToDateDef( AFecha, Date ) );

      //Datos
      QListado.SQL.Add(' select empresa_tl,centro_tl,referencia_tl,fecha_tl, ' +
        '        producto_tl,descripcion_p, ' +
        '        envase_tl,descripcion_e, ' +
        '        marca_tl,descripcion_m, ' +
        '        categoria_tl,color_tl,calibre_tl, unidades_caja_tl, ' +
        '        sum(cajas_tl) cajas_tl, sum(kilos_tl) kilos_tl ' +
        ' from frf_transitos_l,frf_productos,frf_envases,frf_marcas ' +
        ' where empresa_tl=:empresa ' +
        '  and centro_tl=:centro ' +
        '  and referencia_tl=:referencia ' +
        '  and fecha_tl=:fecha ' +
        '  and producto_tl=producto_p ' +
        '  and marca_tl=codigo_m ' +

        ' and envase_e = envase_tl ' +
        ' and producto_e = producto_tl ' +

        ' group by empresa_tl,centro_tl,referencia_tl,fecha_tl, ' +
        '        producto_tl,descripcion_p, ' +
        '        envase_tl,descripcion_e, ' +
        '        marca_tl,descripcion_m, ' +
        '        categoria_tl,color_tl,calibre_tl, unidades_caja_tl ');
      QListado.ParamByName('empresa').AsString := AEmpresa;
      QListado.ParamByName('centro').AsString := ACentro;
      QListado.ParamByName('referencia').AsString := AReferencia;
      QListado.ParamByName('fecha').AsdateTime := StrTodate(AFecha);
      try
        QListado.Open;
      except
        ShowError('Problemas al conseguir datos para imprimir el albarán.');
        Exit;
      end;

      QNota.SQL.Add(' SELECT nota_tc ' +
        ' FROM frf_transitos_c ' +
        ' WHERE   (empresa_tc = :empresa) ' +
        '   AND  (centro_tc = :centro) ' +
        '   AND  (referencia_tc = :referencia) ' +
        '   AND  (fecha_tc = :fecha) ');
      QNota.ParamByName('empresa').AsString := AEmpresa;
      QNota.ParamByName('centro').AsString := ACentro;
      QNota.ParamByName('referencia').AsString := AReferencia;
      QNota.ParamByName('fecha').AsdateTime := StrTodate(AFecha);
      try
        QNota.Open;
        Observaciones.Lines.Clear;
        if ACMR <> '' then
        begin
          Observaciones.Lines.Add( 'Número de CMR: ' + ACMR );
        end;
        Observaciones.Lines.Add( QNota.FieldByName('nota_tc').AsString );

      except
        ShowError('Problemas al conseguir datos para imprimir el albarán.');
        Exit;
      end;

      qreferencia_tc.DataSet := ADataSet;
      qcentro_tc.DataSet := ADataSet;
      qcentro_destino_tc.DataSet := ADataSet;
      qreplanta_origen_tc.DataSet := ADataSet;
      qreplanta_destino_tc.DataSet := ADataSet;
      qfecha_tc.DataSet := ADataSet;
      qtransporte_tc.DataSet := ADataSet;
      qbuque_tc.DataSet := ADataSet;
      qvehiculo_tc.DataSet := ADataSet;
      qdestino_tc.DataSet := ADataSet;

      //Imprimir

      DPreview.bCanSend := (DMConfig.EsLaFont);
      DPreview.Preview(QRLAlbaranTransito2, 1, False, True);
    end;
  except
    ShowError('Problemas al crear el albarán.');
  end;
end;

procedure TQRLAlbaranTransito2.envase_tlPrint(sender: TObject;
  var Value: String);
begin
  Value := desEnvaseP( sEmpresa, Value, QListado.fieldByName('producto_tl').AsString );
end;

procedure TQRLAlbaranTransito2.qreplanta_origen_tcPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' '  + desEmpresa( Value );
end;

procedure TQRLAlbaranTransito2.qreplanta_destino_tcPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' '  + desEmpresa( Value );
end;

procedure TQRLAlbaranTransito2.qcentro_tcPrint(sender: TObject;
  var Value: String);
begin
  Value := Value + ' '  + desCentro( sPlantaOrigen, Value );
end;

procedure TQRLAlbaranTransito2.qcentro_destino_tcPrint(sender: TObject;
  var Value: String);
begin
  Value := Value + ' '  + desCentro( sPlantaDestino, Value );
end;

end.
