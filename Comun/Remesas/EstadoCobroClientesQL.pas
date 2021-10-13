unit EstadoCobroClientesQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB;

type
  TQLEstadoCobroClientes = class(TQuickRep)
    DataSource1: TDataSource;
    qrbndDetailBand1: TQRBand;
    qrdbtxtcta_cliente_fc: TQRDBText;
    qrdbtxtfecha_factura_fc: TQRDBText;
    qrdbtxtcod_factura_fc: TQRDBText;
    qrdbtxtimporte: TQRDBText;
    qrdbtxtpendiente: TQRDBText;
    qrdbtxtpendiente1: TQRDBText;
    qrgrpMoneda: TQRGroup;
    qrbndPieCliente: TQRBand;
    qrxpr2: TQRExpr;
    qrxpr5: TQRExpr;
    qrdbtxtmoneda_fc: TQRDBText;
    qrdbtxtfecha_factura_fc1: TQRDBText;
    qrdbtxtcta_cliente_fc2: TQRDBText;
    qrbndColumnHeaderBand1: TQRBand;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrgrpCliente: TQRGroup;
    qrdbtxtcta_cliente_fc1: TQRDBText;
    qrdbtxtcta_cliente_fc4: TQRDBText;
    qrdbtxtmoneda_fc1: TQRDBText;
    qrbndPieMoneda: TQRBand;
    qrxpr1: TQRExpr;
    qrxpr8: TQRExpr;
    qrdbtxtmoneda_fc2: TQRDBText;
    qrchldbndChildBand1: TQRChildBand;
    qrshpSep1: TQRShape;
    qrdbtxtcod_cliente_fc: TQRDBText;
    qrdbtxtcod_cliente_fc1: TQRDBText;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    procedure qrbndDetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrpMonedaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtcta_cliente_fc4Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtcta_cliente_fcPrint(sender: TObject;
      var Value: String);
    procedure qrchldbndChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtcta_cliente_fc2Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtcod_cliente_fc1Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtcod_cliente_fcPrint(sender: TObject;
      var Value: String);
    procedure qrbndPieClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl7Print(sender: TObject; var Value: String);
  private

  public
    bVerFacturas: boolean;
  end;

  procedure SaldoClientes( bAVerFacturas: boolean );



implementation

uses EstadoCobroClienteDM, DPreview, UDMAUxDb;

{$R *.DFM}

procedure SaldoClientes( bAVerFacturas: Boolean );
var
  QLEstadoCobroClientes: TQLEstadoCobroClientes;
begin
  QLEstadoCobroClientes:= TQLEstadoCobroClientes.Create( nil );
  try
    QLEstadoCobroClientes.bVerFacturas:= bAVerFacturas;
    DPreview.Preview( QLEstadoCobroClientes );
  except
    FreeAndNil( QLEstadoCobroClientes );
  end;
end;

procedure TQLEstadoCobroClientes.qrbndDetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if bVerFacturas then
    qrbndDetailBand1.Height := 17
  else
    qrbndDetailBand1.Height := 0;
end;

procedure TQLEstadoCobroClientes.qrgrpMonedaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if bVerFacturas then
    qrgrpCliente.Height := 17
  else
    qrgrpCliente.Height := 0;
end;

procedure TQLEstadoCobroClientes.qrdbtxtcta_cliente_fc4Print(
  sender: TObject; var Value: String);
begin
  Value:= DesCliente( value );
end;

procedure TQLEstadoCobroClientes.qrdbtxtcta_cliente_fcPrint(
  sender: TObject; var Value: String);
begin
  Value:= '';
end;

procedure TQLEstadoCobroClientes.qrchldbndChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bVerFacturas;
end;

procedure TQLEstadoCobroClientes.qrdbtxtcta_cliente_fc2Print(
  sender: TObject; var Value: String);
begin
  if bVerFacturas then
    Value:= 'TOTAL ' + Value;
end;

procedure TQLEstadoCobroClientes.qrdbtxtcod_cliente_fc1Print(
  sender: TObject; var Value: String);
begin
  if bVerFacturas then
    Value:= ''
  else
    Value:= DesCliente( value );
end;

procedure TQLEstadoCobroClientes.qrdbtxtcod_cliente_fcPrint(
  sender: TObject; var Value: String);
begin
  if bVerFacturas then
    Value:= '';
end;

procedure TQLEstadoCobroClientes.qrbndPieClienteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrshpSep1.enabled:= bVerFacturas;
end;

procedure TQLEstadoCobroClientes.qrlbl7Print(sender: TObject;
  var Value: String);
begin
  if not bVerFacturas then
    Value:= '';
end;

end.
