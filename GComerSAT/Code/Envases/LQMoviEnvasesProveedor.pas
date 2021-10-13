unit LQMoviEnvasesProveedor;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQMoviEnvasesProveedor = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel3: TQRLabel;
    QRLabel3: TQRLabel;
    qrdbtxtfecha_eca: TQRDBText;
    qrdbtxtstock_eca: TQRDBText;
    qrdbtxtcod_producto_ece1: TQRDBText;
    qrdbtxtreferencia_ece: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrdbtxtcantidad_ece: TQRDBText;
    qrgrpEnvase: TQRGroup;
    qrgrEnvProveedor: TQRGroup;
    qrdbtxtoperador: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtcont_entradas_c: TQRDBText;
    qrdbtxt1: TQRDBText;
    qrdbtxtcod_producto_ece: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrdbtxt3: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrxprDiff: TQRExpr;
    qrbndPieProveedor: TQRBand;
    qrbndPieEnvase: TQRBand;
    qrlblStockEnvase: TQRLabel;
    qrlblStock: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrshp1: TQRShape;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure qrdbtxtcod_producto_ecePrint(sender: TObject; var Value: String);
    procedure qrdbtxtenvasePrint(sender: TObject; var Value: String);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrEnvProveedorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrpEnvaseBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure stockPrint(sender: TObject;
      var Value: String);
    procedure qrbndPieProveedorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl6Print(sender: TObject; var Value: String);
    procedure qrlblStockEnvasePrint(sender: TObject; var Value: String);
    procedure qrlbl8Print(sender: TObject; var Value: String);
  private
    rStockProveedor, rStockEnvase: Real;
  public
    sEmpresa: string;
  end;

var
  QMoviEnvasesProveedor: TQMoviEnvasesProveedor;

implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQMoviEnvasesProveedor.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQMoviEnvasesProveedor.qrdbtxtcod_producto_ecePrint(sender: TObject;
  var Value: String);
begin
  Value:= desEnvComerProducto( DataSet.FieldByname('operador').AsString, Value );
end;

procedure TQMoviEnvasesProveedor.qrdbtxtenvasePrint(sender: TObject;
  var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByname('empresa').AsString, Value );
end;

procedure TQMoviEnvasesProveedor.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  sAux: real;
begin
  if DataSet.FieldByName('stock').AsInteger <> 0 then
  begin
    rStockProveedor:= DataSet.FieldByName('stock').AsInteger;
  end
  else
  begin
    rStockProveedor:= rStockProveedor + ( DataSet.FieldByName('entrada').AsInteger -
                      DataSet.FieldByName('salida').AsInteger );
  end;
end;

procedure TQMoviEnvasesProveedor.qrgrEnvProveedorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  rStockProveedor:= 0;
end;

procedure TQMoviEnvasesProveedor.qrgrpEnvaseBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  rStockEnvase:= 0;
end;

procedure TQMoviEnvasesProveedor.stockPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat('#,##0', rStockProveedor );
end;

procedure TQMoviEnvasesProveedor.qrbndPieProveedorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Sender.Height:= 3;
  rStockEnvase:= rStockEnvase + rStockProveedor;
end;

procedure TQMoviEnvasesProveedor.qrlbl6Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total Envase' +  DataSet.FieldByName('operador').AsString + ' - ' +
                      DataSet.FieldByName('envase').AsString;
end;

procedure TQMoviEnvasesProveedor.qrlblStockEnvasePrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat('#,##0', rStockEnvase );
end;

procedure TQMoviEnvasesProveedor.qrlbl8Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat('#,##0', rStockProveedor );
end;

end.
