unit RFOBSemanal;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRFOBSemanal = class(TQuickRep)
    QRGroup2: TQRGroup;
    QRBand2: TQRBand;
    BandaDetalle: TQRBand;
    PsQRLabel1: TQRLabel;
    QRBand3: TQRBand;
    PsQRLabel3: TQRLabel;
    PsQRExpr7: TQRExpr;
    PsQRLabel5: TQRLabel;
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
    PsQRLabel21: TQRLabel;
    PsQRLabel22: TQRLabel;
    PsQRLabel23: TQRLabel;
    PsQRLabel24: TQRLabel;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    LCentro: TQRLabel;
    LProducto: TQRLabel;
    LPeriodo: TQRLabel;
    PsQRLabel25: TQRLabel;
    LCategoria: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel7: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BandaDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel1Print(sender: TObject; var Value: string);
    procedure PsQRLabel3Print(sender: TObject; var Value: string);
    procedure PsQRLabel8Print(sender: TObject; var Value: string);
    procedure PsQRLabel21Print(sender: TObject; var Value: string);
    procedure PsQRLabel9Print(sender: TObject; var Value: string);
    procedure PsQRLabel22Print(sender: TObject; var Value: string);
    procedure PsQRLabel11Print(sender: TObject; var Value: string);
    procedure PsQRLabel23Print(sender: TObject; var Value: string);
    procedure PsQRLabel10Print(sender: TObject; var Value: string);
    procedure PsQRLabel24Print(sender: TObject; var Value: string);
    procedure QRLabel3Print(sender: TObject; var Value: String);
    procedure QRLabel5Print(sender: TObject; var Value: String);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel4Print(sender: TObject; var Value: String);
    procedure QRLabel7Print(sender: TObject; var Value: String);
  private
    kilos_semanal, kilos_total: Real;
    importe_semanal, importe_total: Real;
    gastos_semanal, gastos_total: Real;
    envasado_semanal, envasado_total: Real;
    seccion_semanal, seccion_total: Real;
    neto_semanal, neto_total: Real;

  public
    sEmpresa, sProducto: string;

  end;


implementation

{$R *.DFM}

uses EnvasesFOBData, bMath, UDMAuxDB, Dialogs;


procedure TQRFOBSemanal.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  DataSet.First;

  BandaDetalle.Height := 0;

  kilos_total := 0;
  importe_total := 0;
  gastos_total := 0;
  envasado_total := 0;
  seccion_total := 0;
  neto_total := 0;
end;

procedure TQRFOBSemanal.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  kilos_semanal := 0;
  importe_semanal := 0;
  gastos_semanal := 0;
  envasado_semanal := 0;
  seccion_semanal := 0;
  neto_semanal := 0;
  PrintBand := False;
end;

procedure TQRFOBSemanal.BandaDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  kilos, importe, gastos, envasado, seccion: Real;
begin
  kilos := DataSet.FieldByName('kilos_producto').AsFloat;
  kilos_semanal := kilos_semanal + kilos;

  importe := bRoundTo(DataSet.FieldByName('neto').AsFloat *
    DataSet.FieldByName('cambio').AsFloat, -2);
  importe_semanal := importe_semanal + importe;

  gastos := bRoundTo(((DataSet.FieldByName('gasto_comun').AsFloat +
    DataSet.FieldByName('gasto_transito').AsFloat) *
    DataSet.FieldByName('cambio').AsFloat ), -2);
  gastos_semanal := gastos_semanal + gastos;
  envasado:= bRoundTo(DataSet.FieldByName('coste_envasado').AsFloat,-2);
  seccion:= bRoundTo(DataSet.FieldByName('coste_seccion').AsFloat,-2);
  envasado_semanal := envasado_semanal + envasado;
  seccion_semanal := seccion_semanal + seccion;

  neto_semanal := neto_semanal + (importe - ( gastos + envasado + seccion ) );
end;

procedure TQRFOBSemanal.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  kilos_total := kilos_total + kilos_semanal;
  importe_total := importe_total + importe_semanal;
  gastos_total := gastos_total + gastos_semanal;
  envasado_total := envasado_total + envasado_semanal;
  seccion_total := seccion_total + seccion_semanal;
  neto_total := neto_total + neto_semanal;
end;

procedure TQRFOBSemanal.PsQRLabel1Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_semanal);
end;

procedure TQRFOBSemanal.PsQRLabel3Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_total);
end;

procedure TQRFOBSemanal.PsQRLabel8Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', importe_semanal);
end;

procedure TQRFOBSemanal.PsQRLabel21Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', importe_total);
end;

procedure TQRFOBSemanal.PsQRLabel9Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', gastos_semanal);
end;

procedure TQRFOBSemanal.QRLabel3Print(sender: TObject; var Value: String);
begin
  Value := FormatFloat('#,##0.00', seccion_semanal);
end;

procedure TQRFOBSemanal.QRLabel4Print(sender: TObject; var Value: String);
begin
  Value := FormatFloat('#,##0.00', envasado_semanal);
end;

procedure TQRFOBSemanal.PsQRLabel22Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', gastos_total);
end;

procedure TQRFOBSemanal.QRLabel5Print(sender: TObject; var Value: String);
begin
  Value := FormatFloat('#,##0.00', seccion_total);
end;

procedure TQRFOBSemanal.QRLabel7Print(sender: TObject; var Value: String);
begin
  Value := FormatFloat('#,##0.00', envasado_total);
end;

procedure TQRFOBSemanal.PsQRLabel11Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', neto_semanal);
end;

procedure TQRFOBSemanal.PsQRLabel23Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', neto_total);
end;

procedure TQRFOBSemanal.PsQRLabel10Print(sender: TObject;
  var Value: string);
begin
  if kilos_semanal <> 0 then
    Value := FormatFloat('#,##0.000', (importe_semanal - ( gastos_semanal + envasado_semanal + seccion_semanal ) ) / kilos_semanal)
  else
    Value := FormatFloat('#,##0.000', 0 );
end;

procedure TQRFOBSemanal.PsQRLabel24Print(sender: TObject;
  var Value: string);
begin
  if kilos_total <> 0 then
    Value := FormatFloat('#,##0.000', (importe_total - ( gastos_total + envasado_total + seccion_total ) ) / kilos_total)
  else
    Value := FormatFloat('#,##0.000', 0 );
end;

end.
