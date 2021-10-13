unit CartaTransitoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, CartaTransitoDL;

type
  TQMCartaTransito = class(TQuickRep)
    DetailBand1: TQRBand;
    ChildBand1: TQRChildBand;
    ChildBand2: TQRChildBand;
    ChildBand3: TQRChildBand;
    ChildBand4: TQRChildBand;
    ChildBand5: TQRChildBand;
    ChildBand6: TQRChildBand;
    ChildBand7: TQRChildBand;
    ChildBand8: TQRChildBand;
    ChildBand9: TQRChildBand;
    ChildBand10: TQRChildBand;
    ChildBand11: TQRChildBand;
    ChildBand12: TQRChildBand;
    ChildBand13: TQRChildBand;
    ChildBand14: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    lblEmpresaCargadora: TQRLabel;
    lblEmpresaExpedidora: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    ChildBand15: TQRChildBand;
    ChildBand16: TQRChildBand;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape21: TQRShape;
    QRLabel12: TQRLabel;
    ChildBand18: TQRChildBand;
    ChildBand19: TQRChildBand;
    ChildBand20: TQRChildBand;
    QRLabel14: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel13: TQRLabel;
    QRShape11: TQRShape;
    QRShape20: TQRShape;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    empresa_e: TQRDBText;
    nif_e: TQRDBText;
    tipo_via_e: TQRDBText;
    poblacion_e: TQRDBText;
    cod_postal_e: TQRDBText;
    pais_e: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    qrdbtxtvehiculo_tc: TQRDBText;
    qrmProductos: TQRMemo;
    qrmEnvases: TQRMemo;
    qrmPesos: TQRMemo;
    qrmBultos: TQRMemo;
    qrmObservaciones: TQRMemo;
    QRImgFirma: TQRImage;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    empresa_e2: TQRDBText;
    nif_c: TQRDBText;
    qrecif_operador: TQRDBText;
    qrecif_transportista: TQRDBText;
    qrlbl1: TQRLabel;
    qrmPacto: TQRMemo;
    qrdbtxtnif_e: TQRDBText;
    qrdbtxt3: TQRDBText;
    qrdbtxt4: TQRDBText;
    qrdbtxt5: TQRDBText;
    qrlbl2: TQRLabel;
    qrdbtxt6: TQRDBText;
    qrdbtxt7: TQRDBText;
    qrdbtxt8: TQRDBText;
    qrlbl3: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrdbtxtdescripcion_c: TQRDBText;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure tipo_via_ePrint(sender: TObject; var Value: String);
    procedure cod_postal_ePrint(sender: TObject; var Value: String);
    procedure nif_ePrint(sender: TObject; var Value: String);
    procedure ChildBand18BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand10BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cod_postal_cPrint(sender: TObject; var Value: String);
    procedure qrecif_operadorPrint(sender: TObject; var Value: String);
    procedure pais_ePrint(sender: TObject; var Value: String);
    procedure ChildBand20BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    dmDatos: TDLCartaTransito;
  public
    sFirma: string;
    procedure CargaProductos;
  end;

  procedure Previsualizar( const AOwner: TComponent; const ADatos: TDLCartaTransito; const AFirma: String );

implementation

{$R *.DFM}

uses DPreview, UDMAuxDB, bMath;

procedure Previsualizar( const AOwner: TComponent; const ADatos: TDLCartaTransito; const AFirma: String );
var
  QMCartaTransito: TQMCartaTransito;
begin
  QMCartaTransito:= TQMCartaTransito.Create( AOwner );
  try
    QMCartaTransito.sFirma:= AFirma;
    QMCartaTransito.dmDatos:= ADatos;
    QMCartaTransito.CargaProductos;
    Previsualiza( QMCartaTransito );
  finally
    FreeAndNil( QMCartaTransito );
  end;
end;

procedure TQMCartaTransito.QRDBText1Print(sender: TObject; var Value: String);
begin
  Value:= desCentro( dmDatos.QAlbaranCab.FieldByName('empresa_tc').AsString, Value );
end;

procedure TQMCartaTransito.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value:= desCentro( dmDatos.QAlbaranCab.FieldByName('empresa_tc').AsString, Value );
end;

procedure TQMCartaTransito.nif_ePrint(sender: TObject; var Value: String);
begin
  Value := 'Nif: ' + Value;
end;

procedure TQMCartaTransito.tipo_via_ePrint(sender: TObject; var Value: String);
begin
  if Value <> '' then
    Value:= Value + ' ' + dmDatos.QEmpresa.FieldByName('domicilio_e').AsString
  else
    Value:= dmDatos.QEmpresa.FieldByName('domicilio_e').AsString;
end;

procedure TQMCartaTransito.cod_postal_ePrint(sender: TObject; var Value: String);
begin
  Value:= Value +  ' ' + desProvincia( Value );
end;

procedure TQMCartaTransito.CargaProductos;
var
  sAux: string;
  rTotal, rAux: Real;
  iTotal: Integer;
begin
  with dmDatos.QAlbaranLin do
  begin
    qrmProductos.Lines.Clear;
    qrmEnvases.Lines.Clear;
    qrmPesos.Lines.Clear;
    qrmBultos.Lines.Clear;
    rTotal:= 0;
    iTotal:= 0;
    while not EOF do
    begin
      sAux:= dmDatos.QAlbaranLin.FieldByName('producto').AsString;
      saux:= desProducto( dmDatos.QAlbaranCab.FieldByName('empresa_tc').AsString, sAux );
      qrmProductos.Lines.Add( sAux );

      sAux:= dmDatos.QAlbaranLin.FieldByName('envase').AsString;
      saux:= desEnvaseProducto( dmDatos.QAlbaranCab.FieldByName('empresa_tc').AsString, sAux,
                                dmDatos.QAlbaranLin.FieldByName('producto').AsString );
      qrmEnvases.Lines.Add( sAux );

      rAux:= bRoundTo( dmDatos.QAlbaranLin.FieldByName('bultos').AsInteger * dmDatos.QAlbaranLin.FieldByName('peso_envase').AsFloat, 2);
      rAux:= rAux + bRoundTo( dmDatos.QAlbaranLin.FieldByName('palets').AsInteger * dmDatos.QAlbaranLin.FieldByName('peso_palet').AsFloat, 2);
      rAux:= rAux + dmDatos.QAlbaranLin.FieldByName('kilos').AsFloat;
      rTotal:= rTotal + rAux;
      //sAux:= FormatFloat( '#,##0.00', dmDatos.QAlbaranLin.FieldByName('kilos').AsFloat );
      sAux:= FormatFloat( '#,##0.00', rAux );
      qrmPesos.Lines.Add( sAux );

      iTotal:= dmDatos.QAlbaranLin.FieldByName('bultos').AsInteger + iTotal;
      sAux:= FormatFloat( '#,##0', dmDatos.QAlbaranLin.FieldByName('bultos').AsInteger );
      qrmBultos.Lines.Add( sAux );
      Next;
    end;
    qrmEnvases.Lines.Add( '--------------------------------- ');
    qrmEnvases.Lines.Add( 'TOTALES .... : ');
    qrmPesos.Lines.Add( '-------------' );
    qrmPesos.Lines.Add( FormatFloat( '#,##0.00', rTotal ) );
    qrmBultos.Lines.Add( '-------------' );
    qrmBultos.Lines.Add( FormatFloat( '#,##0', iTotal ) );
  end;
end;

procedure TQMCartaTransito.ChildBand18BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrmObservaciones.Lines.Clear;
  qrmObservaciones.Lines.Add( dmDatos.QAlbaranCab.FieldByName('nota_tc').AsString );
end;

procedure TQMCartaTransito.ChildBand10BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //Carga firma si la tiene
  If FileExists( sFirma ) then
  begin
    QRImgFirma.Enabled:= True;
    QRImgFirma.Stretch:= True;
    QRImgFirma.Picture.LoadFromFile( sFirma );
  end;
end;

procedure TQMCartaTransito.cod_postal_cPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value +  ' ' + desProvincia( Value );
end;

procedure TQMCartaTransito.qrecif_operadorPrint(sender: TObject;
  var Value: String);
begin
  if value <> '' then
  begin
    Value:= 'Cif: ' + Value;
  end;
end;

procedure TQMCartaTransito.pais_ePrint(sender: TObject; var Value: String);
begin
  Value:= 'ESPAÑA';
end;

procedure TQMCartaTransito.ChildBand20BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrmPacto.Lines.Clear;
  qrmPacto.Lines.Add('Pacto de Sumisión: Para cualquier controversia que pudiera derivarse de la ejecución del presente Contrato las partes, con renuncia a su fuero ');
  qrmPacto.Lines.Add('propio, se somenten de forma expresa a la competencia de a Junta Arbitral de Transportes de Alicante, sea cual sea la cuantía de dicha controversia.');

end;

end.
