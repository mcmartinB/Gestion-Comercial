unit LCampos;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls,
  Quickrpt, QRCtrls;

type
  TQRLCampos = class(TQuickRep)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    nif_c: TQRDBText;
    domicilio_c: TQRDBText;
    QRSysData1: TQRSysData;
    QRBand4: TQRBand;
    QRSysData2: TQRSysData;
    QRSysData3: TQRSysData;
    QRGroup1: TQRGroup;
    cosechero_c: TQRDBText;
    ChildBand1: TQRChildBand;
    LCampo: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape1: TQRShape;
    procedure QRLCamposBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  QRLCampos: TQRLCampos;

implementation

{$R *.DFM}

procedure TQRLCampos.QRLCamposBeforePrint(Sender: TCustomQuickRep;
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
