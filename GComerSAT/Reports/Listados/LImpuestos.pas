unit LImpuestos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLImpuestos = class(TQuickRep)
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData2: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrdbtxtporcentaje_i: TQRDBText;
    qrdbtxtsuper_il: TQRDBText;
    reducido_il: TQRDBText;
    qrdbtxtgeneral_il: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLImpuestosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  QRLImpuestos: TQRLImpuestos;

implementation

{$R *.DFM}

uses
  CVariables;

procedure TQRLImpuestos.QRSysData1Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLImpuestos.QRLImpuestosBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i].ClassType = TQRDBText then
      TQRDBText(Components[i]).DataSet := DataSet;
  end;
end;

end.
