unit SobrepesosPeriodoQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRSobrepesosPeriodo = class(TQuickRep)
    cabecera: TQRBand;
    detalle: TQRBand;
    pie: TQRBand;
    descripcion_p: TQRDBText;
    kilos: TQRDBText;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    total: TQRExpr;
    LTotal: TQRLabel;
    qrdbtxtcajas: TQRDBText;
    totalBultos: TQRExpr;
    qrlblPeriodo: TQRLabel;
    qrlblCentro: TQRLabel;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    qrdbtxtcajas1: TQRDBText;
    qrdbtxtkilos: TQRDBText;
    qrdbtxtdes_producto: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtdes_producto1: TQRDBText;
    qrbndColumnHeaderBand1: TQRBand;
    qrlbl3: TQRLabel;
    qrlblPsQRLabel1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlblLKilos: TQRLabel;
    qrlblLPais: TQRLabel;
    qrlbl1: TQRLabel;
    qrlblEmpresa: TQRLabel;
    qrxpr1: TQRExpr;
    qrlbl4: TQRLabel;
    qrgrp1: TQRGroup;
    qtxtproducto: TQRDBText;
    qtxttipo: TQRDBText;
    qrbndPie: TQRBand;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrshp1: TQRShape;
    qtxttipo1: TQRDBText;
    procedure qtxtproductoPrint(sender: TObject; var Value: String);
    procedure qrgrp1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qtxttipo1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcajas1Print(sender: TObject; var Value: string);
  private

  public
    provincia: string;
    fecha: string;
  end;

implementation

uses UDMAuxDB, bMath;

{$R *.DFM}

procedure TQRSobrepesosPeriodo.qtxtproductoPrint(sender: TObject;
  var Value: String);
begin
  if Value = 'S' then
    Value:= 'SALIDAS'
  else
    VALUE:= 'TRANSITOS';
end;

procedure TQRSobrepesosPeriodo.qrdbtxtcajas1Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('kilos').AsFloat = 0 then
    Value := '0'
  else
    Value := FloatToStr(bRoundTo(DataSet.FieldByName('sobrepeso').AsFloat / DataSet.FieldByName('kilos').AsFloat *100, 2));
end;

procedure TQRSobrepesosPeriodo.qrgrp1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRSobrepesosPeriodo.qtxttipo1Print(sender: TObject;
  var Value: String);
begin
  if Value = 'S' then
    Value:= 'TOTAL SALIDAS ..................'
  else
    VALUE:= 'TOTAL TRÁNSITOS ..............';
end;

end.
