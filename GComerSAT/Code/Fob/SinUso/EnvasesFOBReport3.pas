unit EnvasesFOBReport3;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQREnvasesFOBReport3 = class(TQuickRep)
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    QRGroup2: TQRGroup;
    QRBand2: TQRBand;
    BandaDetalle: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    QRBand3: TQRBand;
    PsQRLabel3: TQRLabel;
    PsQRExpr7: TQRExpr;
    PsQRLabel5: TQRLabel;
    ChildBand1: TQRChildBand;
    PsQRLabel8: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    QRBand4: TQRBand;
    PsQRLabel12: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    PsQRLabel15: TQRLabel;
    PsQRLabel16: TQRLabel;
    PsQRLabel17: TQRLabel;
    PsQRLabel18: TQRLabel;
    PsQRLabel19: TQRLabel;
    PsQRLabel20: TQRLabel;
    PsQRLabel21: TQRLabel;
    PsQRLabel22: TQRLabel;
    PsQRLabel23: TQRLabel;
    PsQRLabel24: TQRLabel;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    PageFooterBand1: TQRBand;
    lblGastos: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    PsQRSysData2: TQRSysData;
    LPeriodo: TQRLabel;
    PsQRLabel25: TQRLabel;
    LCategoria: TQRLabel;
    qrlLProducto: TQRLabel;
    qrlOrigen: TQRLabel;
    qrlDestino: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BandaDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel1Print(sender: TObject; var Value: string);
    procedure PsQRLabel2Print(sender: TObject; var Value: string);
    procedure PsQRLabel3Print(sender: TObject; var Value: string);
    procedure PsQRLabel7Print(sender: TObject; var Value: string);
    procedure PsQRLabel6Print(sender: TObject; var Value: string);
    procedure PsQRLabel8Print(sender: TObject; var Value: string);
    procedure PsQRLabel17Print(sender: TObject; var Value: string);
    procedure PsQRLabel21Print(sender: TObject; var Value: string);
    procedure PsQRLabel9Print(sender: TObject; var Value: string);
    procedure PsQRLabel18Print(sender: TObject; var Value: string);
    procedure PsQRLabel22Print(sender: TObject; var Value: string);
    procedure PsQRLabel11Print(sender: TObject; var Value: string);
    procedure PsQRLabel19Print(sender: TObject; var Value: string);
    procedure PsQRLabel23Print(sender: TObject; var Value: string);
    procedure PsQRLabel10Print(sender: TObject; var Value: string);
    procedure PsQRLabel20Print(sender: TObject; var Value: string);
    procedure PsQRLabel24Print(sender: TObject; var Value: string);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    kilos_cliente, kilos_envase, kilos_total: Real;
    importe_cliente, importe_envase, importe_total: Real;
    gastos_cliente, gastos_envase, gastos_total: Real;
    neto_cliente, neto_envase, neto_total: Real;

  public
    sEmpresa: string;
    bGasto, bEnvase, bSecciones: boolean;

  end;


implementation

{$R *.DFM}

uses EnvasesFOBData, bMath, UDMAuxDB, Dialogs;


procedure TQREnvasesFOBReport3.PsQRLabel7Print(sender: TObject;
  var Value: string);
begin
  //Value := desEnvase(sEmpresa, DataSet.fieldByName('envase').AsString);
end;

procedure TQREnvasesFOBReport3.PsQRLabel6Print(sender: TObject;
  var Value: string);
begin
  Value := desCliente(sEmpresa, DataSet.fieldByName('cliente').AsString);
end;

procedure TQREnvasesFOBReport3.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  DataSet.First;

  BandaDetalle.Height := 0;

  kilos_total := 0;
  importe_total := 0;
  gastos_total := 0;
  neto_total := 0;
end;

procedure TQREnvasesFOBReport3.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  kilos_envase := 0;
  importe_envase := 0;
  gastos_envase := 0;
  neto_envase := 0;
end;

procedure TQREnvasesFOBReport3.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  kilos_cliente := 0;
  importe_cliente := 0;
  gastos_cliente := 0;
  neto_cliente := 0;
  PrintBand := False;
end;

procedure TQREnvasesFOBReport3.BandaDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  kilos, importe, gastos: Real;
begin
  kilos := DataSet.FieldByName('kilos_producto').AsFloat;
  kilos_cliente := kilos_cliente + kilos;

  importe := bRoundTo(DataSet.FieldByName('neto').AsFloat *
    DataSet.FieldByName('cambio').AsFloat, -2);
  importe_cliente := importe_cliente + importe;

  gastos := bRoundTo(((DataSet.FieldByName('gasto_comun').AsFloat +
    DataSet.FieldByName('gasto_transito').AsFloat) *
    DataSet.FieldByName('cambio').AsFloat ) + DataSet.FieldByName('coste_envase').AsFloat, -2);
  gastos_cliente := gastos_cliente + gastos;

  neto_cliente := neto_cliente + (importe - gastos);
end;

procedure TQREnvasesFOBReport3.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  kilos_envase := kilos_envase + kilos_cliente;
  importe_envase := importe_envase + importe_cliente;
  gastos_envase := gastos_envase + gastos_cliente;
  neto_envase := neto_envase + neto_cliente;
end;

procedure TQREnvasesFOBReport3.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  kilos_total := kilos_total + kilos_envase;
  importe_total := importe_total + importe_envase;
  gastos_total := gastos_total + gastos_envase;
  neto_total := neto_total + neto_envase;
end;

procedure TQREnvasesFOBReport3.PsQRLabel1Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_cliente);
end;

procedure TQREnvasesFOBReport3.PsQRLabel2Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_envase);
end;

procedure TQREnvasesFOBReport3.PsQRLabel3Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_total);
end;

procedure TQREnvasesFOBReport3.PsQRLabel8Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', importe_cliente);
end;

procedure TQREnvasesFOBReport3.PsQRLabel17Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', importe_envase);
end;

procedure TQREnvasesFOBReport3.PsQRLabel21Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', importe_total);
end;

procedure TQREnvasesFOBReport3.PsQRLabel9Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', gastos_cliente);
end;

procedure TQREnvasesFOBReport3.PsQRLabel18Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', gastos_envase);
end;

procedure TQREnvasesFOBReport3.PsQRLabel22Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', gastos_total);
end;

procedure TQREnvasesFOBReport3.PsQRLabel11Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', neto_cliente);
end;

procedure TQREnvasesFOBReport3.PsQRLabel19Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', neto_envase);
end;

procedure TQREnvasesFOBReport3.PsQRLabel23Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', neto_total);
end;

procedure TQREnvasesFOBReport3.PsQRLabel10Print(sender: TObject;
  var Value: string);
begin
  if kilos_cliente > 0 then
    Value := FormatFloat('#,##0.000', (importe_cliente - gastos_cliente) / kilos_cliente)
  else
    Value := 'ERROR';
end;

procedure TQREnvasesFOBReport3.PsQRLabel20Print(sender: TObject;
  var Value: string);
begin
  if kilos_envase > 0 then
    Value := FormatFloat('#,##0.000', (importe_envase - gastos_envase) / kilos_envase)
  else
    Value := 'ERROR';
end;

procedure TQREnvasesFOBReport3.PsQRLabel24Print(sender: TObject;
  var Value: string);
begin
  if kilos_total > 0 then
    Value := FormatFloat('#,##0.000', (importe_total - gastos_total) / kilos_total)
  else
    Value := 'ERROR';
end;

procedure TQREnvasesFOBReport3.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  bFlag: boolean;
begin
  PrintBand:= bGasto or bSecciones or bEnvase;
  lblGastos.Caption:= 'NOTA: Los gastos incluyen -> ';
  bFlag:= false;
  if bGasto then
  begin
    lblGastos.Caption:= lblGastos.Caption + 'gastos de albarán';
    bFlag:= True;
  end;
  if bEnvase then
  begin
    if bFlag then
    begin
      lblGastos.Caption:= lblGastos.Caption + ' + ';
    end;
    lblGastos.Caption:= lblGastos.Caption + 'costes del envase';
    bFlag:= True;
  end;
  if bSecciones then
  begin
    if bFlag then
    begin
      lblGastos.Caption:= lblGastos.Caption + ' + ';
    end;
    lblGastos.Caption:= lblGastos.Caption + 'coste de envasado';
  end;
end;

end.
