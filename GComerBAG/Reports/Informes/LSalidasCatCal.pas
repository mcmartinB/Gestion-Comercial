unit LSalidasCatCal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLSalidasCatCal = class(TQuickRep)
    QListado: TQuery;
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    QRGroup1: TQRGroup;
    PsQRDBText1: TQRDBText;
    PsQRDBText7: TQRDBText;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    PsQRLabel5: TQRLabel;
    SummaryBand1: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRShape1: TQRShape;
    PsQRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    lblCentros: TQRLabel;
    lblProductos: TQRLabel;
    lblRango: TQRLabel;
    ChildBand1: TQRChildBand;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRExpr1: TQRExpr;
    procedure PsQRDBText1Print(sender: TObject; var Value: string);
    procedure QRLSalidasCatCalBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure PsQRLabel5Print(sender: TObject; var Value: string);
    procedure PsQRDBText7Print(sender: TObject; var Value: string);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    cli_aux: string;
    pro_aux: string;

  public

  end;

var
  QRLSalidasCatCal: TQRLSalidasCatCal;

implementation

{$R *.DFM}

procedure TQRLSalidasCatCal.QRLSalidasCatCalBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  cli_aux := '';
  pro_aux := '';
end;

procedure TQRLSalidasCatCal.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  pro_aux := '';
end;

procedure TQRLSalidasCatCal.PsQRDBText1Print(sender: TObject;
  var Value: string);
begin
  cli_aux := value;
end;

procedure TQRLSalidasCatCal.PsQRLabel5Print(sender: TObject;
  var Value: string);
begin
  Value := cli_aux;
end;

procedure TQRLSalidasCatCal.PsQRDBText7Print(sender: TObject;
  var Value: string);
begin
  if value = pro_aux then
    value := ''
  else
    pro_aux := value;
end;

end.
