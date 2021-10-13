unit LCostesEnvasadoMensual;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, DB, DBTables;

type
  TQRLCostesEnvasadoMensual = class(TQuickRep)
    QRBand3: TQRBand;
    LCodigo: TQRLabel;
    QRBand2: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    fecha: TQRSysData;
    QCostesEnvasado: TQuery;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRGroup2: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText3: TQRDBText;
    qrgCentro: TQRGroup;
    qrlTipo: TQRLabel;
    qrlCoste: TQRLabel;
    qrecentro_emc: TQRDBText;
    qrl1: TQRLabel;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLMarcasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText8Print(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure qrecentro_emcPrint(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLCostesEnvasadoMensual: TQRLCostesEnvasadoMensual;

implementation

uses CVariables, UDMAuxDB;

{$R *.DFM}

procedure TQRLCostesEnvasadoMensual.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLCostesEnvasadoMensual.QRLMarcasBeforePrint(Sender: TCustomQuickRep;
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

procedure TQRLCostesEnvasadoMensual.QRDBText8Print(sender: TObject;
  var Value: String);
begin
  Value := '- ' + Value;
end;

procedure TQRLCostesEnvasadoMensual.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= value + ' ' + Desempresa( Value );
end;

procedure TQRLCostesEnvasadoMensual.qrecentro_emcPrint(sender: TObject;
  var Value: String);
begin
  Value:= value + ' ' + DesCentro( DataSet.fieldbyname('empresa_emc').AsString, Value );
end;

end.
