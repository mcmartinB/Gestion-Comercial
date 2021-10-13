unit LProductividadProductosQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, db;

type
  TQLProductividadProductosQR = class(TQuickRep)
    bndCabecera: TQRBand;
    PsQRSysData1: TQRSysData;
    PsQRSysData2: TQRSysData;
    lblPeriodo: TQRLabel;
    DetailBand1: TQRBand;
    PsQRExpr5: TQRExpr;
    QRGroup1: TQRGroup;
    QRGroup2: TQRGroup;
    ChildBand1: TQRChildBand;
    lblPeriodoAux: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    lblAcumuladoAux: TQRLabel;
    PsQRShape3: TQRShape;
    PsQRShape4: TQRShape;
    PsQRSuperficie: TQRExpr;
    PsQRPlantas: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr8: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr9: TQRExpr;
    PsQRExpr10: TQRExpr;
    QRBand1: TQRBand;
    PsQRLabel3: TQRLabel;
    PsQRExpr20: TQRExpr;
    PsQRExpr19: TQRExpr;
    PsQRExpr21: TQRExpr;
    PsQRExpr23: TQRExpr;
    PsQRExpr22: TQRExpr;
    PsQRExpr24: TQRExpr;
    PsQRShape2: TQRShape;
    QRBand2: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRSumPlantas: TQRExpr;
    PsQRSumSuperficie: TQRExpr;
    QRLabel1: TQRLabel;
    PsQRSysData3: TQRSysData;
    procedure PsQRExpr5Print(sender: TObject; var Value: string);
    procedure bndCabeceraBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure PsQRLabel3Print(sender: TObject; var Value: string);
    procedure PsQRExpr10Print(sender: TObject; var Value: string);
    procedure PsQRExpr8Print(sender: TObject; var Value: string);
    procedure PsQRExpr24Print(sender: TObject; var Value: string);
    procedure PsQRExpr22Print(sender: TObject; var Value: string);
    procedure PsQRSumSuperficiePrint(sender: TObject; var Value: string);
    procedure PsQRSumPlantasPrint(sender: TObject; var Value: string);
    procedure QRLabel1Print(sender: TObject; var Value: String);
  private
    paintLeyend: Boolean;
    bSuperficie, bPlantas: boolean;
  public
    //inicio,fin,ejercicio: TDate;
    compressReport: Boolean;
  end;

implementation

uses LProductividadProductos, UDMAuxDB;

{$R *.DFM}

function Rellena(ACadena: string; ALong: integer; AChar: char = '0';
  ALeftToRight: Boolean = true): string;
begin
  if ALeftToRight then
    result := StringOfChar(AChar, ALong - length(ACadena)) + ACadena
  else
    result := ACadena + StringOfChar(AChar, ALong - length(ACadena));
end;

procedure TQLProductividadProductosQR.PsQRExpr5Print(sender: TObject;
  var Value: string);
begin
  Value := Rellena(DataSet.FieldByName('cosechero_tp').AsString, 3) +
    Rellena(Value, 2) + '  ' +
    DataSet.FieldByName('ano_semana_tp').AsString + ' ' +
    DataSet.FieldByName('descripcion_tp').AsString;
end;

procedure TQLProductividadProductosQR.bndCabeceraBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  paintLeyend := True;
end;

procedure TQLProductividadProductosQR.ChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := paintLeyend;
end;

procedure TQLProductividadProductosQR.ChildBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  paintLeyend := False;
end;

procedure TQLProductividadProductosQR.PsQRLabel3Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTALES ' +
    UpperCase(desProvincia(DataSet.FieldByName('provincia_tp').AsString));
end;

procedure TQLProductividadProductosQR.PsQRExpr10Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('Plantas_tp').AsInteger = 0 then
    Value := '0';
end;

procedure TQLProductividadProductosQR.PsQRExpr8Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('Superficie_tp').AsFloat = 0 then
    Value := '0';
end;

procedure TQLProductividadProductosQR.PsQRExpr24Print(sender: TObject;
  var Value: string);
begin
  if not bPlantas then
    Value := '0';
end;

procedure TQLProductividadProductosQR.PsQRExpr22Print(sender: TObject;
  var Value: string);
begin
  if not bSuperficie then
    Value := '0';
end;

procedure TQLProductividadProductosQR.PsQRSumSuperficiePrint(
  sender: TObject; var Value: string);
begin
  bSuperficie := StrToFloat(StringReplace(Value, '.', '', [rfReplaceAll, rfIgnoreCase])) <> 0;
end;

procedure TQLProductividadProductosQR.PsQRSumPlantasPrint(sender: TObject;
  var Value: string);
begin
  bPlantas := StrToFloat(StringReplace(Value, '.', '', [rfReplaceAll, rfIgnoreCase])) <> 0;
end;

procedure TQLProductividadProductosQR.QRLabel1Print(sender: TObject;
  var Value: String);
begin
  Value := desProducto(dataset.fieldbyname('empresa_tp').AsString,
    dataset.fieldbyname('producto_tp').AsString)
    + ' - ' + desProvincia(dataset.fieldbyname('provincia_tp').AsString);
end;

end.
