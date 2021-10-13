unit LEmpresas;

interface

uses SysUtils, Classes, Controls, ExtCtrls, QuickRpt, Qrctrls;

type
  TQRLEmpresas = class(TQuickRep)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    empresa_e: TQRDBText;
    nombre_e: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    nif_e: TQRDBText;
    tipo_via_e: TQRDBText;
    domicilio_e: TQRDBText;
    numero_e: TQRDBText;
    poblacion_e: TQRDBText;
    provincia_e: TQRDBText;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    codigo_ean_e: TQRDBText;
    LCodEAN13: TQRLabel;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLEmpresasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure provincia_ePrint(sender: TObject; var Value: string);
  private

  public

  end;

var
  QRLEmpresas: TQRLEmpresas;

implementation

uses
  UDMAuxDB;

{$R *.DFM}

procedure TQRLEmpresas.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLEmpresas.QRLEmpresasBeforePrint(Sender: TCustomQuickRep;
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

procedure TQRLEmpresas.provincia_ePrint(sender: TObject;
  var Value: string);
begin
  Value := desProvincia(Value);
end;

end.
