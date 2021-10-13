unit LiquidaResumenFrutaEntradasSalidasQR;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, grimgctrl;
type
  TQRLiquidaResumenFrutaEntradasSalidas = class(TQuickRep)
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    qrdbtxtkilos_out: TQRDBText;
    qrdbtxtdescuento: TQRDBText;
    qrdbtxtimporteNeto: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlblPsQRLabel1: TQRLabel;
    qrlblPsQRLabel2: TQRLabel;
    qrlbl4: TQRLabel;
    qrlblPsQRLabel3: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrdbtxtgastos: TQRDBText;
    qrdbtxtcosteEnvase: TQRDBText;
    qrdbtxtprecioLiquidar: TQRDBText;
    qrdbtxtimporteLiquidar: TQRDBText;
    qrdbtxtcosteAdminstrativo: TQRDBText;
    qrdbtxtcosteProduccion: TQRDBText;
    qrdbtxtcosteComercial: TQRDBText;
    qrdbtxtkilos_in: TQRDBText;
    qrdbtxtpoblacion_b: TQRDBText;
    qrdbtxtkilos_out1: TQRDBText;
    qrdbtxtkilos_out2: TQRDBText;
    qrdbtxtkilos_out3: TQRDBText;
    qrbndTotales: TQRBand;
    qrpdfshp1: TQRPDFShape;
    qrxprKilosTotal: TQRExpr;
    qrxprImporteLiquidarTotal: TQRExpr;
    qrxprPrecioLiquidarTotal: TQRExpr;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl24: TQRLabel;
    qrlbl25: TQRLabel;
    qrlbl26: TQRLabel;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl19: TQRLabel;
    qrdbtxtprecioLiquidar1: TQRDBText;
    qrdbtxtprecioLiquidar2: TQRDBText;
    qrdbtxtcosteSecciones1: TQRDBText;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrlbl5: TQRLabel;
    qrlbl20: TQRLabel;
    qrdbtxtprecioLiquidar3: TQRDBText;
    qrxpr5: TQRExpr;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrlblPeriodo: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl31: TQRLabel;
    qrdbtxtkilos_out4: TQRDBText;
    qrxpr15: TQRExpr;
    qrdbtxtkilos_out5: TQRDBText;
    qrlbl32: TQRLabel;
    qrlbl33: TQRLabel;
    qrxpr16: TQRExpr;
    procedure qrdbtxtkilos_out1Print(sender: TObject; var Value: String);
    procedure qrdbtxtkilos_out2Print(sender: TObject; var Value: String);
    procedure qrdbtxtkilos_out3Print(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLiquidaResumenFrutaEntradasSalidas: TQRLiquidaResumenFrutaEntradasSalidas;

implementation

uses
  LiquidaFrutaEntradasSalidasDM, UDMAuxDB;

{$R *.DFM}

(*
  kmtResumen.FieldDefs.Add('lunes', ftString, 3, False);
  kmtResumen.FieldDefs.Add('domingo', ftString, 12, False);
  kmtResumen.FieldDefs.Add('importeFOB', ftFloat, 0, False);
*)


procedure TQRLiquidaResumenFrutaEntradasSalidas.qrdbtxtkilos_out1Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desEmpresa( Value );
end;

procedure TQRLiquidaResumenFrutaEntradasSalidas.qrdbtxtkilos_out2Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + descentro( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiquidaResumenFrutaEntradasSalidas.qrdbtxtkilos_out3Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

end.
