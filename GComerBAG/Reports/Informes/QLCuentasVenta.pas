unit QLCuentasVenta;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls,
  Messages, dialogs;
type
  TQRLCuentasVentas = class(TQuickRep)
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    LTitulo: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    albaran_tsc: TQRDBText;
    fecha_tsc: TQRDBText;
    QRSysData2: TQRSysData;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    bruto_tsc: TQRDBText;
    moneda_tsc: TQRDBText;
    totalBruto: TQRExpr;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    gastos: TQRDBText;
    PsQRExpr2: TQRExpr;
    PsQRExpr1: TQRExpr;
    PsQRExpr3: TQRExpr;
    totales: TQRLabel;
    kilos_tsc: TQRDBText;
    PsQRLabel4: TQRLabel;
    PsQRExpr4: TQRExpr;
    IdentificadorLabel: TQRLabel;
    fecha_factura: TQRLabel;
  private

  public

  end;

var
  QRLCuentasVentas: TQRLCuentasVentas;

implementation

uses LCuentasVenta;

{$R *.DFM}

end.
