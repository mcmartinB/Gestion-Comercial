unit LPlantaciones;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLPlantaciones = class(TQuickRep)
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRSysData3: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    l1: TQRLabel;
    l2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    QRBand5: TQRBand;
    PsQRSysData1: TQRSysData;
    PsQRSysData2: TQRSysData;
    procedure QRSysData3Print(sender: TObject; var Value: string);
    procedure QRLPlantacionesBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  QRLPlantaciones: TQRLPlantaciones;

implementation

uses CVariables;

{$R *.DFM}

procedure TQRLPlantaciones.QRSysData3Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLPlantaciones.QRLPlantacionesBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
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
