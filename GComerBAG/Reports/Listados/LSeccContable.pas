unit LSeccContable;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls;
type
  TQRLSeccContable = class(TQuickRep)
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    empresa_sc: TQRDBText;
    descripcion_sc: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    sec_contable_sc: TQRDBText;
    qrlbl1: TQRLabel;
    qrgrp1: TQRGroup;
    qrdbtxtempresa_sc: TQRDBText;
    qrbnd1: TQRBand;
    bndsdDetalle: TQRSubDetail;
    qrdbtxtcentro_esc: TQRDBText;
    qrdbtxtenvase_e: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrdbtxtlinea_producto_e: TQRDBText;
    qrdbtxtdescripcion_e: TQRDBText;
    qrdbtxtfecha_baja_e: TQRDBText;
    procedure qrdbtxtempresa_scPrint(sender: TObject; var Value: String);
    procedure bndsdDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl2Print(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLSeccContable: TQRLSeccContable;

implementation

{$R *.DFM}

uses
  UDMAuxDB, MSeccContables;

procedure TQRLSeccContable.qrdbtxtempresa_scPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + DesEmpresa( Value );
end;

//, , , , , 

procedure TQRLSeccContable.bndsdDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bndsdDetalle.DataSet.Active;
end;

procedure TQRLSeccContable.qrlbl2Print(sender: TObject; var Value: String);
begin
  if not bndsdDetalle.DataSet.Active then
  begin
    Value:= '';
  end;
end;

end.
