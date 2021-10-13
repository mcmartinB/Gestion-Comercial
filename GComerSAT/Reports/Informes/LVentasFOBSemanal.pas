unit LVentasFOBSemanal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLVentasFOBSemanal = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    DBKilos: TQRDBText;
    DBImporte: TQRDBText;
    DBGastos: TQRDBText;
    LCentro: TQRLabel;
    LProducto: TQRLabel;
    LPeriodo: TQRLabel;
    PsQRLabel1: TQRLabel;
    LEuros: TQRLabel;
    QListado: TQuery;
    PsQRDBText2: TQRDBText;
    QRGroup1: TQRGroup;
    DBCliente: TQRDBText;
    QRBand1: TQRBand;
    PsQRShape12: TQRShape;
    PsQRShape13: TQRShape;
    PsQRShape14: TQRShape;
    PsQRShape15: TQRShape;
    PsQRLabel4: TQRLabel;
    ChildBand1: TQRChildBand;
    LCliente: TQRLabel;
    LKilos: TQRLabel;
    LVenta: TQRLabel;
    LGastos: TQRLabel;
    LNeto: TQRLabel;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    PsQRShape4: TQRShape;
    PsQRShape5: TQRShape;
    PsQRLabel2: TQRLabel;
    PsQRShape10: TQRShape;
    PsQRLabel3: TQRLabel;
    PsQRShape11: TQRShape;
    AGKilos: TQRExpr;
    AGImporte: TQRExpr;
    AGGasto: TQRExpr;
    AGNeto: TQRExpr;
    ATKilos: TQRExpr;
    ATImporte: TQRExpr;
    ATGasto: TQRExpr;
    ATNeto: TQRExpr;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    AG1Media: TQRExpr;
    AT1Media: TQRExpr;
    LCategoria: TQRLabel;
    PsQRSysData3: TQRSysData;
    PsQRShape6: TQRShape;
    PsQRLabel8: TQRLabel;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure DBClientePrint(sender: TObject; var Value: string);
    procedure AGImportePrint(sender: TObject; var Value: string);
    procedure AGGastoPrint(sender: TObject; var Value: string);
    procedure AGNetoPrint(sender: TObject; var Value: string);
    procedure ATImportePrint(sender: TObject; var Value: string);
    procedure ATNetoPrint(sender: TObject; var Value: string);
    procedure ATGastoPrint(sender: TObject; var Value: string);
    procedure QRLVentasFOBSemanalBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRGroup1AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure AG1MediaPrint(sender: TObject; var Value: string);
    procedure AT1MediaPrint(sender: TObject; var Value: string);
  private
  public
    empresa: string;
    sEmpresa: string;
    Clientes: Integer;
  end;

var
  QRLVentasFOBSemanal: TQRLVentasFOBSemanal;

implementation

uses UDMAuxDB, CAuxiliarDB, UDMCambioMoneda;

{$R *.DFM}

//**********************************  TITULO  **********************************

procedure TQRLVentasFOBSemanal.PsQRDBText2Print(sender: TObject;
  var Value: string);
var
  aux: string;
begin
  aux := QListado.FieldByName('semana_fm').AsString;
  if Length(aux) = 1 then aux := '0' + aux;
  Value := Value + ' ' + aux;
end;

procedure TQRLVentasFOBSemanal.DBClientePrint(sender: TObject;
  var Value: string);
var
  aux: string;
begin
  aux := desCliente(sEmpresa, value);
  Value := '[' + Value + '] ' + aux;
end;

procedure TQRLVentasFOBSemanal.AGImportePrint(sender: TObject;
  var Value: string);
var
  valor: Real;
begin
  Valor := StrToFloat(Value);
  Value := formatFloat('#,##0.00', Valor);
end;

procedure TQRLVentasFOBSemanal.AGGastoPrint(sender: TObject;
  var Value: string);
var
  valor: Real;
begin
  Valor := StrToFloat(Value);
  Value := formatFloat('#,##0.00', Valor);
end;

procedure TQRLVentasFOBSemanal.AGNetoPrint(sender: TObject;
  var Value: string);
var
  valor: Real;
begin
  Valor := StrToFloat(Value);
  Value := formatFloat('#,##0.00', Valor);
end;

procedure TQRLVentasFOBSemanal.ATImportePrint(sender: TObject;
  var Value: string);
var
  valor: Real;
begin
  Valor := StrToFloat(Value);
  Value := formatFloat('#,##0.00', Valor);
end;

procedure TQRLVentasFOBSemanal.ATNetoPrint(sender: TObject;
  var Value: string);
var
  valor: Real;
begin
  Valor := StrToFloat(Value);
  Value := formatFloat('#,##0.00', Valor);
end;

procedure TQRLVentasFOBSemanal.ATGastoPrint(sender: TObject;
  var Value: string);
var
  valor: Real;
begin
  Valor := StrToFloat(Value);
  Value := formatFloat('#,##0.00', Valor);
end;

procedure TQRLVentasFOBSemanal.QRLVentasFOBSemanalBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  Clientes := 0;
end;

procedure TQRLVentasFOBSemanal.QRGroup1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Clientes := Clientes + 1;
end;

procedure TQRLVentasFOBSemanal.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Clientes < 2 then PrintBand := false;
end;

procedure TQRLVentasFOBSemanal.AG1MediaPrint(sender: TObject;
  var Value: string);
var
  valor: Real;
begin
  Valor := StrToFloat(Value);
  Value := formatFloat('#,##0.000', Valor);
end;

procedure TQRLVentasFOBSemanal.AT1MediaPrint(sender: TObject;
  var Value: string);
var
  valor: Real;
begin
  Valor := StrToFloat(Value);
  Value := formatFloat('#,##0.000', Valor);
end;

end.
