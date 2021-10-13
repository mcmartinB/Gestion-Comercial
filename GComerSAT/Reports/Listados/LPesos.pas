unit LPesos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLPesos = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    fecha: TQRSysData;
    detalle: TQRBand;
    producto_p: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    LEmpresa: TQRLabel;
    empresa_p: TQRDBText;
    LCentro: TQRLabel;
    centro_p: TQRDBText;
    LProducto: TQRLabel;
    LPeso_caja_p: TQRLabel;
    LPeso_palet_p: TQRLabel;
    pieGrupo: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    qre1: TQRDBText;
    qre2: TQRDBText;
    QRLabel2: TQRLabel;
    qrlcajas: TQRLabel;
    qrepeso_palet_p: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLPesosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

var
  QRLPesos: TQRLPesos;

implementation

{$R *.DFM}

uses CVAriables;

procedure TQRLPesos.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLPesos.QRLPesosBeforePrint(Sender: TCustomQuickRep;
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
