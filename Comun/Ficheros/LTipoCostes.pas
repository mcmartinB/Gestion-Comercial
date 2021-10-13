unit LTipoCostes;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLTipoCostes = class(TQuickRep)
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRSysData2: TQRSysData;
    qrdbtxt2: TQRDBText;
    qrlbl2: TQRLabel;
    procedure QRLTipoPaletsBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  QRLTipoCostes: TQRLTipoCostes;

implementation

{$R *.DFM}

uses UDMAuxDB;

procedure TQRLTipoCostes.QRLTipoPaletsBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TQRDBText then
    begin
      TQRDBText(Components[i]).DataSet := DataSet;
    end;
  end;
end;

end.
