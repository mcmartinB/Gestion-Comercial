unit LSalidasCatCal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLSalidasCatCal = class(TQuickRep)
    QListado: TQuery;
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    QRGroup1: TQRGroup;
    PsQRDBText1: TQRDBText;
    PsQRDBText7: TQRDBText;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    SummaryBand1: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    qlCentroOrigen: TQRLabel;
    lblProductos: TQRLabel;
    lblRango: TQRLabel;
    qlCentroSalida: TQRLabel;
    qrxpr1: TQRExpr;
    qrdbtxtCajas: TQRDBText;
    qrxpr2: TQRExpr;
    qrdbtxtcliente: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl2: TQRLabel;
    qrlblPsQRLabel2: TQRLabel;
    qrlblPsQRLabel3: TQRLabel;
    qrlblPsQRLabel4: TQRLabel;
    qrlblPsQRLabel6: TQRLabel;
    qrlbl1: TQRLabel;
    qrlblPsQRLabel7: TQRLabel;
    qrshp1: TQRShape;
    qrbndPieCliente: TQRBand;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    QRLabel1: TQRLabel;
    qrshp2: TQRShape;
    procedure QRLSalidasCatCalBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure PsQRDBText7Print(sender: TObject; var Value: string);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtclientePrint(sender: TObject; var Value: String);
    procedure QRLabel1Print(sender: TObject; var Value: String);
    procedure qrlblPsQRLabel4Print(sender: TObject; var Value: String);
    procedure qrlblPsQRLabel6Print(sender: TObject; var Value: String);
  private
    pro_aux: string;

  public
    sEmpresa: string;
    bCategoria, bCalibre: Boolean;
  end;

var
  QRLSalidasCatCal: TQRLSalidasCatCal;

implementation

{$R *.DFM}

uses
  UDMAuxDB;

procedure TQRLSalidasCatCal.QRLSalidasCatCalBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  pro_aux := '';
end;

procedure TQRLSalidasCatCal.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  pro_aux := '';
end;

procedure TQRLSalidasCatCal.PsQRDBText7Print(sender: TObject;
  var Value: string);
begin
  if value = pro_aux then
    value := ''
  else
    pro_aux := value;
end;

procedure TQRLSalidasCatCal.qrdbtxtclientePrint(sender: TObject;
  var Value: String);
begin
  Value:= DesCliente(Value);
end;

procedure TQRLSalidasCatCal.QRLabel1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL '+ DataSet.FieldByName('cliente').AsString;
end;

procedure TQRLSalidasCatCal.qrlblPsQRLabel4Print(sender: TObject;
  var Value: String);
begin
  if not bCategoria then
    Value:= '';
end;

procedure TQRLSalidasCatCal.qrlblPsQRLabel6Print(sender: TObject;
  var Value: String);
begin
  if not bCalibre then
    Value:= '';
end;

end.
