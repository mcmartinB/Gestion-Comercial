unit LCostesIndirectos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, DB, DBTables;

type
  TQRLCostesIndirectos = class(TQuickRep)
    QRBand3: TQRBand;
    LCodigo: TQRLabel;
    QRBand2: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    fecha: TQRSysData;
    QCostesEnvasado: TQuery;
    QRGroup2: TQRGroup;
    empresa_ci: TQRDBText;
    centro_origen_ci: TQRDBText;
    administracion_ci: TQRDBText;
    QRLabel3: TQRLabel;
    produccion_ci: TQRDBText;
    comercial_ci: TQRDBText;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    fecha_ini_ci: TQRDBText;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel6: TQRLabel;
    procedure QRLMarcasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure centro_origen_ciPrint(sender: TObject; var Value: String);
    procedure QRLabel4Print(sender: TObject; var Value: String);
    procedure QRLabel5Print(sender: TObject; var Value: String);
    procedure QRLabel1Print(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLCostesIndirectos: TQRLCostesIndirectos;

implementation

uses CVariables, UDMAuxDB, CGlobal;

{$R *.DFM}

procedure TQRLCostesIndirectos.QRLMarcasBeforePrint(Sender: TCustomQuickRep;
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

  if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    ReportTitle:= 'Costes Extructura';
  end
  else
  begin
    ReportTitle:= 'Costes Indirectos';
  end;

end;

procedure TQRLCostesIndirectos.centro_origen_ciPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desCentro( dataset.FieldByName('empresa_ci').AsString, Value );
end;

procedure TQRLCostesIndirectos.QRLabel4Print(sender: TObject;
  var Value: String);
begin
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    Value:= 'Estructura';
  end
  else
  begin
    Value:= 'Comercial';
  end;
end;

procedure TQRLCostesIndirectos.QRLabel5Print(sender: TObject;
  var Value: String);
begin
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    Value:= '';
  end;
end;

procedure TQRLCostesIndirectos.QRLabel1Print(sender: TObject;
  var Value: String);
begin
if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    Value:= 'COSTES ESTRUCTURA';
  end
  else
  begin
    Value:= 'COSTES INDIRECTOS';
  end;
end;

end.
