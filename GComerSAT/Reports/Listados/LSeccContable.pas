unit LSeccContable;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls;
type
  TQRLSeccContable = class(TQuickRep)
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    empresa_sc: TQRDBText;
    centro_sc: TQRDBText;
    descripcion_sc: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    producto_sc: TQRDBText;
    PsQRLabel1: TQRLabel;
    sec_contable_sc: TQRDBText;
    procedure QRLSeccContableBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  QRLSeccContable: TQRLSeccContable;

implementation

{$R *.DFM}

procedure TQRLSeccContable.QRLSeccContableBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
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
