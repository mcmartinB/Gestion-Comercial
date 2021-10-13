unit AlbaranesFacturadosEnReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, grimgctrl;

type
  TQRAlbaranesFacturadosEn = class(TQuickRep)
    QRBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblFecha: TQRLabel;
    lblProducto: TQRLabel;
    qrbndDetalle: TQRBand;
    qrdbtxtexpedicion_c1: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtdes_envase: TQRDBText;
    qrdbtxtexpedicion_c2: TQRDBText;
    qrgrpNacional: TQRGroup;
    qrchldbndChildBand1: TQRChildBand;
    qrlbl2: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrdbtxtempresa: TQRDBText;
    qrdbtxtcentro: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    qrdbtxtempresa1: TQRDBText;
    qrdbtxtcliente: TQRDBText;
    qrlbl12: TQRLabel;
    qrdbtxtempresa2: TQRDBText;
    qrbndTotalCliente: TQRBand;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrdbtxtcliente1: TQRDBText;
    qrbnd1: TQRBand;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrlbl1: TQRLabel;
    qrshp1: TQRShape;
    qrgrpCliente: TQRGroup;
    qrbndTotalNacional: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    qrdbtxtnacional: TQRDBText;
    qrshp2: TQRShape;
    qrdbtxtnacional1: TQRDBText;
    qrcodigox3: TQRDBText;
    QRLabel1: TQRLabel;
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
    procedure qrdbtxtclientePrint(sender: TObject; var Value: String);
    procedure qrdbtxtfecha1Print(sender: TObject; var Value: String);
    procedure qrbndTotalClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbnd1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtnacionalPrint(sender: TObject; var Value: String);
    procedure qrdbtxtnacional1Print(sender: TObject; var Value: String);
    procedure qrbndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

procedure PrintAlbaranesFacturadosEn( const AOwner: TComponent;
                                 const AEmpresa, ACentro, AProducto: string;
                                 const AFechaIni, AFechaFin: TDateTime );

implementation

{$R *.DFM}

uses
  AlbaranesFacturadosEnData, DPreview, CReportes, UDMAuxDB, variants;

var
  QRAlbaranesFacturadosEn: TQRAlbaranesFacturadosEn;

procedure PrintAlbaranesFacturadosEn( const AOwner: TComponent;
                                 const AEmpresa, ACentro, AProducto: string;
                                 const AFechaIni, AFechaFin: TDateTime );
begin
  QRAlbaranesFacturadosEn:= TQRAlbaranesFacturadosEn.Create( AOwner );
  try
    PonLogoGrupoBonnysa(QRAlbaranesFacturadosEn, AEmpresa);
    if AProducto = '' then
      QRAlbaranesFacturadosEn.lblProducto.Caption:= 'TODOS LOS PRODUCTOS.'
    else
      QRAlbaranesFacturadosEn.lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto );
    QRAlbaranesFacturadosEn.lblFecha.Caption:= 'Fecha corte ' + DateToStr( AFechaFin ) ;
    Previsualiza( QRAlbaranesFacturadosEn );
  finally
    FreeAndNil( QRAlbaranesFacturadosEn );
  end;
end;

procedure TQRAlbaranesFacturadosEn.qrdbtxtproducto1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByName('empresa').AsString, value );
end;

procedure TQRAlbaranesFacturadosEn.qrdbtxtclientePrint(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( value );
end;

procedure TQRAlbaranesFacturadosEn.qrdbtxtfecha1Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('fecha_factura').Value = null then
    value:= ''
end;

procedure TQRAlbaranesFacturadosEn.qrbndDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) then
  begin
    qrCodigoX3.Enabled := true;

  end
  else
  begin
    qrCodigoX3.Enabled := false;
  end;

end;

procedure TQRAlbaranesFacturadosEn.qrbndTotalClienteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not Exporting;
end;

procedure TQRAlbaranesFacturadosEn.qrbnd1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not Exporting;
end;

procedure TQRAlbaranesFacturadosEn.qrdbtxtnacionalPrint(sender: TObject;
  var Value: String);
begin
  if Value = 'ES' then
  begin
    Value:= 'TOTAL NACIONAL';
  end
  else
  begin
    Value:= 'TOTAL EXPORTACIÓN';
  end;
end;

procedure TQRAlbaranesFacturadosEn.qrdbtxtnacional1Print(sender: TObject;
  var Value: String);
begin
  if Value = 'ES' then
  begin
    Value:= 'NACIONAL';
  end
  else
  begin
    Value:= 'EXPORTACIÓN';
  end;
end;

end.
