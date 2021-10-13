unit LLineasProductos;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls;
type
  TQRLLineasProductos = class(TQuickRep)
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel4: TQRLabel;
    descripcion_sc: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    sec_contable_sc: TQRDBText;
    qrlbl1: TQRLabel;
    qrgrp1: TQRGroup;
    qrbnd1: TQRBand;
    bndsdLineas: TQRSubDetail;
    qrdbtxt1: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrdbtxt3: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    procedure qrdbtxtempresa_scPrint(sender: TObject; var Value: String);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure bndsdLineasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

var
  QRLLineasProductos: TQRLLineasProductos;

implementation

{$R *.DFM}

uses
  UDMAuxDB, MLineasProductos;

procedure TQRLLineasProductos.qrdbtxtempresa_scPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + DesEmpresa( Value );
end;


procedure TQRLLineasProductos.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  if not QRLLineasProductos.DataSet.Active then
  begin
    Value:= '';
  end;
end;

procedure TQRLLineasProductos.bndsdLineasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= QRLLineasProductos.DataSet.Active;
end;

end.
