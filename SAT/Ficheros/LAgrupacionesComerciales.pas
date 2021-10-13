unit LAgrupacionesComerciales;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLAgrupacionesComerciales = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLCodigo: TQRLabel;
    qreagrupacion_ac: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLMonedasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  QLAgrupacionesComerciales: TQLAgrupacionesComerciales;

implementation

uses CVariables;

{$R *.DFM}

procedure TQLAgrupacionesComerciales.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQLAgrupacionesComerciales.QRLMonedasBeforePrint(Sender: TCustomQuickRep;
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
