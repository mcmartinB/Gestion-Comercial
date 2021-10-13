unit QLRemesasBancoDetalle;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, UDMBaseDatos, Qrctrls;
type
  TQRLRemesasBancoDetalle = class(TQuickRep)
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    DetailBand1: TQRBand;
    fecha_r: TQRDBText;
    referencia_r: TQRDBText;
    moneda_cobro_r: TQRDBText;
    importe_cobro_r: TQRDBText;
    bruto_euros_r: TQRDBText;
    gastos_euros_r: TQRDBText;
    liquido_euros_r: TQRDBText;
    cambio_r: TQRDBText;
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    banco_r: TQRDBText;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRLabel7: TQRLabel;
    descripcion_b: TQRDBText;
    lPeriodo: TQRLabel;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRShape1: TQRShape;
    PsQRShape3: TQRShape;
    PsQRShape2: TQRShape;
    QRSysData2: TQRSysData;
    sCambioMedio: TQRExpr;
    rCambioMedio: TQRShape;
    procedure QRLRemesasBancoDetalleBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure TitleBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRGroup1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    saltar: boolean;
  public

  end;

var
  QRLRemesasBancoDetalle: TQRLRemesasBancoDetalle;
  soloUnaMoneda: boolean;

implementation

{$R *.DFM}

procedure TQRLRemesasBancoDetalle.QRLRemesasBancoDetalleBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  if soloUnaMoneda then
  begin
    sCambioMedio.Enabled := true;
    rCambioMedio.Enabled := true;
  end
  else
  begin
    sCambioMedio.Enabled := false;
    rCambioMedio.Enabled := false;
  end;
end;

procedure TQRLRemesasBancoDetalle.TitleBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  saltar := false;
end;

procedure TQRLRemesasBancoDetalle.QRGroup1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  saltar := True;
end;

procedure TQRLRemesasBancoDetalle.QRGroup1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Saltar then ForceNewPage;
end;

initialization
  soloUnaMoneda := false;

end.
