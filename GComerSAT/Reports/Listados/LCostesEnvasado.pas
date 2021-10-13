unit LCostesEnvasado;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, DB, DBTables;

type
  TQRLCostesEnvasado = class(TQuickRep)
    QRBand3: TQRBand;
    LDescripcion: TQRLabel;
    QRBand2: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    fecha: TQRSysData;
    QCostesEnvasado: TQuery;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    BandaCorte: TQRGroup;
    QRLabel2: TQRLabel;
    QRGroup1: TQRGroup;
    productor_ce: TQRDBText;
    nombre_c: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText3: TQRDBText;
    QRGroup2: TQRGroup;
    tipo_entrada_epc: TQRDBText;
    descripcion_et: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLMarcasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: string);
    procedure QRDBText2Print(sender: TObject; var Value: string);
    procedure QRDBText5Print(sender: TObject; var Value: string);
  private

  public

  end;

var
  QRLCostesEnvasado: TQRLCostesEnvasado;

implementation

uses CVariables, UDMAuxDB;

{$R *.DFM}

procedure TQRLCostesEnvasado.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLCostesEnvasado.QRLMarcasBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  i: integer;
begin
  BandaCorte.Height := 0;
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TQRDBText then
    begin
      TQRDBText(Components[i]).DataSet := DataSet;
    end;
  end;
end;

procedure TQRLCostesEnvasado.QRDBText1Print(sender: TObject;
  var Value: string);
begin
  Value := desEmpresa(value);
end;

procedure TQRLCostesEnvasado.QRDBText2Print(sender: TObject;
  var Value: string);
begin
  Value := desCentro(DataSet.fieldbyname('empresa_epc').AsString, value);
end;

procedure TQRLCostesEnvasado.QRDBText5Print(sender: TObject;
  var Value: string);
begin
  Value := '- ' + Value + ' -';
end;

end.
