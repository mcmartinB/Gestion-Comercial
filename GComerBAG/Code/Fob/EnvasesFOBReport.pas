unit EnvasesFOBReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQREnvasesFOBReport = class(TQuickRep)
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    QRGroup2: TQRGroup;
    QRBand2: TQRBand;
    BandaDetalle: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    QRBand3: TQRBand;
    PsQRLabel3: TQRLabel;
    PsQRExpr1: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    ChildBand1: TQRChildBand;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    lblGastosCliente: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    QRBand4: TQRBand;
    PsQRLabel12: TQRLabel;
    PsQRLabel13: TQRLabel;
    lblGastosEtiqueta: TQRLabel;
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
    PageFooterBand1: TQRBand;
    lblGastos: TQRLabel;
    PsQRSysData2: TQRSysData;
    PsQRSysData3: TQRSysData;
    LCentro: TQRLabel;
    LProducto: TQRLabel;
    LPeriodo: TQRLabel;
    lblTitulo: TQRLabel;
    LCategoria: TQRLabel;
    lblKilosDetalle: TQRLabel;
    lblImporteDetalle: TQRLabel;
    lblGastosDetalle: TQRLabel;
    lblNetoDetalle: TQRLabel;
    lblPrecioDetalle: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel1: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRLabel2: TQRLabel;
    QRExpr5: TQRExpr;
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
    procedure lblGastosClientePrint(sender: TObject; var Value: string);
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
    procedure QRLabel2Print(sender: TObject; var Value: String);
    procedure QRExpr4Print(sender: TObject; var Value: String);
    procedure QRExpr5Print(sender: TObject; var Value: String);
  private
    kilos_cliente, kilos_envase, kilos_total: Real;
    importe_cliente, importe_envase, importe_total: Real;
    gastos_cliente, gastos_envase, gastos_total: Real;
    neto_cliente, neto_envase, neto_total: Real;
    bNuevoEnvase: boolean;
    bNuevoCliente: boolean;

  public
    sEmpresa, sProducto: string;
    bGasto, bEnvase, bSecciones: boolean;
    bImprimirDetalle: boolean;
    bImprimirCalibre: boolean;
  end;


implementation

{$R *.DFM}

uses EnvasesFOBData, bMath, UDMAuxDB;


procedure TQREnvasesFOBReport.PsQRLabel7Print(sender: TObject;
  var Value: string);
begin
  Value := desEnvaseP(sEmpresa, DataSet.fieldByName('envase').AsString, sProducto );
end;

procedure TQREnvasesFOBReport.PsQRLabel6Print(sender: TObject;
  var Value: string);
begin
  Value := desCliente(DataSet.fieldByName('cliente').AsString);
end;

procedure TQREnvasesFOBReport.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  if bImprimirDetalle then
    BandaDetalle.Height := 19
  else
    BandaDetalle.Height := 0;

  kilos_total := 0;
  importe_total := 0;
  gastos_total := 0;
  neto_total := 0;

  bNuevoEnvase:= True;
  bNuevoCliente:= True;
end;

procedure TQREnvasesFOBReport.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bNuevoEnvase = True then
  begin
    kilos_envase := 0;
    importe_envase := 0;
    gastos_envase := 0;
    neto_envase := 0;
    bNuevoEnvase:= False;
  end;
end;

procedure TQREnvasesFOBReport.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bNuevoCliente = True then
  begin
    kilos_cliente := 0;
    importe_cliente := 0;
    gastos_cliente := 0;
    neto_cliente := 0;
    PrintBand := bImprimirDetalle;
    bNuevoCliente:= False;
  end;
end;

procedure TQREnvasesFOBReport.BandaDetalleBeforePrint(
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

  lblKilosDetalle.Caption:= FormatFloat( '#,##0.00', kilos );
  lblImporteDetalle.Caption:= FormatFloat( '#,##0.000', importe );
  lblGastosDetalle.Caption:= FormatFloat( '#,##0.000', gastos );
  lblNetoDetalle.Caption:= FormatFloat( '#,##0.000', importe - gastos );
  if kilos <> 0  then
    lblPrecioDetalle.Caption:= FormatFloat( '#,##0.000', ( importe - gastos ) / kilos )
  else
    lblPrecioDetalle.Caption:= '';
end;

procedure TQREnvasesFOBReport.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  kilos_envase := kilos_envase + kilos_cliente;
  importe_envase := importe_envase + importe_cliente;
  gastos_envase := gastos_envase + gastos_cliente;
  neto_envase := neto_envase + neto_cliente;

  QRBand2.Frame.DrawTop:= bImprimirDetalle;

  bNuevoCliente:= True;
end;

procedure TQREnvasesFOBReport.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  kilos_total := kilos_total + kilos_envase;
  importe_total := importe_total + importe_envase;
  gastos_total := gastos_total + gastos_envase;
  neto_total := neto_total + neto_envase;

  bNuevoEnvase:= True;
end;

procedure TQREnvasesFOBReport.PsQRLabel1Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_cliente);
end;

procedure TQREnvasesFOBReport.PsQRLabel2Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_envase);
end;

procedure TQREnvasesFOBReport.PsQRLabel3Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_total);
end;

procedure TQREnvasesFOBReport.PsQRLabel8Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', importe_cliente);
end;

procedure TQREnvasesFOBReport.PsQRLabel17Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', importe_envase);
end;

procedure TQREnvasesFOBReport.PsQRLabel21Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', importe_total);
end;

procedure TQREnvasesFOBReport.lblGastosClientePrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', gastos_cliente);
end;

procedure TQREnvasesFOBReport.PsQRLabel18Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', gastos_envase);
end;

procedure TQREnvasesFOBReport.PsQRLabel22Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', gastos_total);
end;

procedure TQREnvasesFOBReport.PsQRLabel11Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', neto_cliente);
end;

procedure TQREnvasesFOBReport.PsQRLabel19Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', neto_envase);
end;

procedure TQREnvasesFOBReport.PsQRLabel23Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', neto_total);
end;

procedure TQREnvasesFOBReport.PsQRLabel10Print(sender: TObject;
  var Value: string);
begin
  if kilos_cliente <> 0  then
    Value := FormatFloat('#,##0.000', (importe_cliente - gastos_cliente) / kilos_cliente)
  else
    value:= '';
end;

procedure TQREnvasesFOBReport.PsQRLabel20Print(sender: TObject;
  var Value: string);
begin
  if kilos_envase <> 0  then
    Value := FormatFloat('#,##0.000', (importe_envase - gastos_envase) / kilos_envase)
  else
    value:= '';
end;

procedure TQREnvasesFOBReport.PsQRLabel24Print(sender: TObject;
  var Value: string);
begin
  if kilos_total <> 0  then
    Value := FormatFloat('#,##0.000', (importe_total - gastos_total) / kilos_total)
  else
    value:= '';
end;

procedure TQREnvasesFOBReport.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  bFlag: boolean;
begin
  PrintBand:= bGasto or bSecciones or bEnvase;
  lblGastos.Caption:= 'NOTA: Los gastos incluyen -> ';
  bFlag:= False;
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
    lblGastos.Caption:= lblGastos.Caption + 'costes del artículo ';
    bFlag:= True;
  end;
  if bSecciones then
  begin
    if bFlag then
    begin
      lblGastos.Caption:= lblGastos.Caption + ' + ';
    end;
    lblGastos.Caption:= lblGastos.Caption + 'coste secciones almacén';
  end;
end;

procedure TQREnvasesFOBReport.QRLabel2Print(sender: TObject;
  var Value: String);
begin
  if not bImprimirCalibre then
    Value:= '';
end;

procedure TQREnvasesFOBReport.QRExpr4Print(sender: TObject;
  var Value: String);
begin
  if not bImprimirCalibre then
    Value:= '';
end;

procedure TQREnvasesFOBReport.QRExpr5Print(sender: TObject;
  var Value: String);
begin
  if not bImprimirCalibre or bImprimirDetalle then
    Value:= '';
end;

end.
