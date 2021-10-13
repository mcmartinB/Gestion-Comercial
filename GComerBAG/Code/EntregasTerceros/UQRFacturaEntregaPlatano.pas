unit UQRFacturaEntregaPlatano;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRFacturaEntregaPlatano = class(TQuickRep)
    DetailBand1: TQRBand;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    n_factura_fpc: TQRDBText;
    fecha_fpc: TQRDBText;
    img1: TQRImage;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrs1: TQRShape;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl8: TQRLabel;
    qrl9: TQRLabel;
    qrl10: TQRLabel;
    qrl13: TQRLabel;
    qrl14: TQRLabel;
    qrl15: TQRLabel;
    qrl16: TQRLabel;
    qrl17: TQRLabel;
    qrl18: TQRLabel;
    qrl19: TQRLabel;
    qrl20: TQRLabel;
    qrs2: TQRShape;
    qrl22: TQRLabel;
    qrl23: TQRLabel;
    qrlbl1: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrlblqrl11: TQRLabel;
    qrlblqrl12: TQRLabel;
    qrlblFechaFactura: TQRLabel;
    qrlblqrl26: TQRLabel;
    qrlblqrl27: TQRLabel;
    qrlblqrl28: TQRLabel;
    qrlblqrl29: TQRLabel;
    qrmMatricula: TQRMemo;
    qrlNeto: TQRLabel;
    qrlIgic: TQRLabel;
    qrlTotal: TQRLabel;
    qrbndDetailBand2: TQRBand;
    qrmBuque: TQRMemo;
    qrmProducto: TQRMemo;
    qrmCategoria: TQRMemo;
    qrmCajas: TQRMemo;
    qrmPeso: TQRMemo;
    qrmUnidad: TQRMemo;
    qrmPrecio: TQRMemo;
    qrmImporte: TQRMemo;
    qrgrp1: TQRGroup;
    qrbndPie: TQRBand;
    qrlblcajas: TQRLabel;
    qrlblpeso: TQRLabel;
    qrlblimporte: TQRLabel;
    qrlblqrl24: TQRLabel;
    qtxtanyo_Semana_fpc: TQRDBText;
    qrlblqrl25: TQRLabel;
    qtxtreceptor_fpc: TQRDBText;
    procedure qrgrp1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;


implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRFacturaEntregaPlatano.qrgrp1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgrp1.Height:= 0;
end;

end.
