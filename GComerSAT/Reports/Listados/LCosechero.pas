unit LCosechero;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, CVariables;

type
  TQRLCosecheros = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand3: TQRBand;
    empresa_c: TQRDBText;
    nombre_c: TQRDBText;
    nif_c: TQRDBText;
    tipo_via_c: TQRDBText;
    domicilio_c: TQRDBText;
    poblacion_c: TQRDBText;
    cod_postal_c: TQRDBText;
    cosechero_c: TQRDBText;
    cta_contable_c: TQRDBText;
    cta_gastos_c: TQRDBText;
    QRSysData1: TQRSysData;
    QRBand4: TQRBand;
    QRSysData2: TQRSysData;
    QRBand5: TQRBand;
    QRShape2: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    ld: TQRLabel;
    Lp: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    lblFederacion: TQRLabel;
    federacion_c: TQRDBText;
    procedure QRSysData2Print(sender: TObject; var Value: string);
    procedure QRLCosecherosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure federacion_cPrint(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLCosecheros: TQRLCosecheros;

implementation

{$R *.DFM}

uses UDMAuxDB;

procedure TQRLCosecheros.QRSysData2Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLCosecheros.QRLCosecherosBeforePrint(Sender: TCustomQuickRep;
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

procedure TQRLCosecheros.federacion_cPrint(sender: TObject;
  var Value: String);
begin
  Value:= DesFederacion( Value );
end;

end.
