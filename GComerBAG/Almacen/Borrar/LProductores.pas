unit LProductores;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls; 

type
  TQRLProductores = class(TQuickRep)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBand4: TQRBand;
    QRSysData3: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    l1: TQRLabel;
    l2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand5: TQRBand;
    QRDBText8: TQRDBText;
    QRLabel1: TQRLabel;
    procedure QRSysData3Print(sender: TObject; var Value: String);
    procedure QRLPlantacionesBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  QRLProductores: TQRLProductores;

implementation

uses CVariables;

{$R *.DFM}

procedure TQRLProductores.QRSysData3Print(sender: TObject;
  var Value: String);
begin
  if Tag>0 then
     Value:=Value+' de '+IntToStr(Tag);
end;

procedure TQRLProductores.QRLPlantacionesBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  i: Integer;
begin
  for i:= 0 to ComponentCount-1 do
  begin
    if Components[i].ClassType = TQRDBText then
      TQRDBText(Components[i]).DataSet:= DataSet;
  end;
end;

end.
