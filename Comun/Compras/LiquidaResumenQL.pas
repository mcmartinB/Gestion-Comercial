unit LiquidaResumenQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, grimgctrl, DB, kbmMemTable;

type
  TQLLiquidaResumen = class(TQuickRep)
    QRBand5: TQRBand;
    qrlblTitulo: TQRLabel;
    QRBand4: TQRBand;
    qrlbl2: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl18: TQRLabel;
    BandaDetalle: TQRBand;
    qrdbtxtpal_categoria: TQRDBText;
    qrdbtxtpal_status: TQRDBText;
    qrdbtxtpal_cajas_confeccionados: TQRDBText;
    qrdbtxtpal_kilos_confeccionados: TQRDBText;
    qrdbtxtpal_importe_neto: TQRDBText;
    qrdbtxtpal_importe_compra: TQRDBText;
    qrdbtxtpal_importe_descuento: TQRDBText;
    qrdbtxtpal_importe_gastos: TQRDBText;
    qrdbtxtpal_importe_material: TQRDBText;
    qrdbtxtpal_importe_general: TQRDBText;
    SummaryBand1: TQRBand;
    qrlbl10: TQRLabel;
    qrlbl15: TQRLabel;
    qrgrpCategoria: TQRGroup;
    qrdbtxtliq_categoria1: TQRDBText;
    qrdbtxtliq_importe_beneficio: TQRDBText;
    qrdbtxtliq_importe_financiero: TQRDBText;
    qrdbtxtliq_importe_liquidar: TQRDBText;
    qrlbl16: TQRLabel;
    qrbndPieCategoria: TQRBand;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrdbtxt3: TQRDBText;
    qrxpr20: TQRExpr;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrdbtxtres_kilos_teoricos: TQRDBText;
    qrdbtxtres_kilos_teoricos1: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl13: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrxpr25: TQRExpr;
    qrxpr26: TQRExpr;
    qrpdfshp1: TQRPDFShape;
    qrbnd1: TQRBand;
    q1: TQRLabel;
    ChildBand1: TQRChildBand;
    QRExpr2: TQRExpr;
    QRExpr5: TQRExpr;
    q4: TQRLabel;
    q5: TQRLabel;
    q6: TQRLabel;
    q7: TQRLabel;
    q8: TQRLabel;
    QRPDFShape1: TQRPDFShape;
    QRExpr9: TQRExpr;
    q2: TQRLabel;
    q3: TQRLabel;
    q9: TQRLabel;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    q10: TQRLabel;
    qrdbtxtpal_importe_flete: TQRDBText;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    q12: TQRLabel;
    qTotalDestrioTfe: TQRLabel;
    q11: TQRLabel;
    qTotalPeso: TQRLabel;
    qKilosCanarias: TQRLabel;
    qKilosTotal: TQRLabel;
    qImporteCanarias: TQRLabel;
    qImporteTotal: TQRLabel;
    qImporteMargen: TQRLabel;
    qMargen: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr3: TQRExpr;
    procedure qrdbtxtliq_categoria1Print(sender: TObject;
      var Value: String);
    procedure qrdbtxt3Print(sender: TObject; var Value: String);
    procedure qrdbtxtpal_statusPrint(sender: TObject; var Value: String);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
     sProducto: String;
     procedure VerPrecios( const APrecios: boolean );
  public
    
  end;
  var rTotalDestrioTfe, rTotalDestrioTfeImporte, rTotalPeso, rKilosCanarias, rKilosCompra, rImporteCanarias, rImporteCompra, rImporteLiquidar: Real;
  var   QLLiquidaResumen: TQLLiquidaResumen;
  procedure PrevisualizarResumen( const AEmpresa, AProducto: string; const APrecios: boolean; ATotalDestrioTfe, ATotalDestrioTfeImporte,
                                  ATotalPeso, AKilosCanarias, AKilosCompra, AImporteCanarias, AImporteCompra, AImporteLiquidar: Real );

implementation

{$R *.DFM}

uses LiquidaEntregaDL, UDMAuxDB,  DPreview, CReportes;

var
  DLLiquidaEntrega: TDLLiquidaEntrega;

procedure PrevisualizarResumen( const AEmpresa, AProducto: string; const APrecios: boolean; ATotalDestrioTfe, ATotalDestrioTfeImporte,
                                ATotalPeso, AKilosCanarias, AKilosCompra, AImporteCanarias, AImporteCompra, AImporteLiquidar: Real );
var
  sAux: string;
begin
  QLLiquidaResumen := TQLLiquidaResumen.Create(Application);
  PonLogoGrupoBonnysa(QLLiquidaResumen, AEmpresa);
  QLLiquidaResumen.VerPrecios( APrecios );
  sAux:= QLLiquidaResumen.DataSet.FieldByName('res_anyo_semana').AsString;
  QLLiquidaResumen.sProducto := AProducto;

  QLLiquidaResumen.qrlblTitulo.Caption:= 'INFORME LIQUIDACION TOTAL ' + AEmpresa  + ' - SEMANA ' + sAux + ' ' + AProducto + ' - ' + desProducto('', AProducto);
  QLLiquidaResumen.ReportTitle:= 'INFORME_LIQUIDACION_TOTAL_' + AEmpresa  + '_SEMANA_' + sAux + '_' + AProducto;

  rTotalDestrioTfe := ATotalDestrioTfe;
  rTotalDestrioTfeImporte := ATotalDestrioTfeImporte;
  rTotalPeso := ATotalPeso;
  rKilosCanarias := AKilosCanarias;
  rKilosCompra := AKilosCompra;
  rImporteCanarias := AImporteCanarias;
  rImporteCompra := AImporteCompra;
  rImporteLiquidar := AImporteLiquidar;

  Preview(QLLiquidaResumen);
end;

procedure TQLLiquidaResumen.VerPrecios( const APrecios: boolean );
begin
  if not APrecios then
  begin
    qrdbtxtpal_importe_neto.DataField:= 'res_importe_neto';
    qrdbtxtpal_importe_descuento.DataField:= 'res_importe_descuento';
    qrdbtxtpal_importe_gastos.DataField:= 'res_importe_gastos';
    qrdbtxtpal_importe_compra.DataField:= 'res_importe_compra';
    qrdbtxtpal_importe_material.DataField:= 'res_importe_envasado';
    qrdbtxtpal_importe_general.DataField:= 'res_importe_liquidar';
    qrdbtxtliq_importe_beneficio.DataField:= 'res_importe_beneficio';
    qrdbtxtliq_importe_financiero.DataField:= 'res_importe_financiero';
    qrdbtxtpal_importe_flete.DataField:= 'res_importe_flete';
    QRDBText1.DataField := 'res_importe_indirecto_almacen';
  end
  else
  begin
    qrdbtxtpal_importe_neto.DataField:= 'res_precio_neto';
    qrdbtxtpal_importe_descuento.DataField:= 'res_precio_descuento';
    qrdbtxtpal_importe_gastos.DataField:= 'res_precio_gastos';
    qrdbtxtpal_importe_compra.DataField:= 'res_precio_compra';
    qrdbtxtpal_importe_material.DataField:= 'res_precio_envasado';
    qrdbtxtpal_importe_general.DataField:= 'res_precio_liquidar';
    qrdbtxtliq_importe_beneficio.DataField:= 'res_precio_beneficio';
    qrdbtxtliq_importe_financiero.DataField:= 'res_precio_financiero';
    qrdbtxtpal_importe_flete.DataField:= 'res_precio_flete';
    QRDBText1.DataField := 'res_precio_indirecto_almacen';
  end;
end;

procedure TQLLiquidaResumen.qrdbtxtliq_categoria1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + desCategoria( 'F17', sProducto, Value );
end;

procedure TQLLiquidaResumen.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qTotalDestrioTfe.Caption := FormatFloat('###,###,###,##0;-###,###,###,##0;0', rTotalDestrioTfe);
  qTotalPeso.Caption := FormatFloat('###,###,###,##0;-###,###,###,##0;0', rTotalPeso + rTotalDestrioTfe);
  qKilosCanarias.Caption :=  FormatFloat('###,###,###,##0;-###,###,###,##0;0', rKilosCanarias + rTotalDestrioTfe);
  qKilosTotal.Caption :=  FormatFloat('###,###,###,##0;-###,###,###,##0;0', rKilosCanarias + rTotalDestrioTfe + rKilosCompra);
  qImporteCanarias.Caption := FormatFloat('###,###,###,##0;-###,###,###,##0;0', rImporteCanarias + rTotalDestrioTfeImporte);
  qImporteTotal.Caption :=  FormatFloat('###,###,###,##0;-###,###,###,##0;0', rImporteCanarias + rTotalDestrioTfeImporte + rImporteCompra);
  qImporteMargen.Caption := FormatFloat('###,###,###,##0;-###,###,###,##0;0', rImporteLiquidar - (rImporteCanarias + rTotalDestrioTfeImporte + rImporteCompra));
  if (rTotalPeso + rTotalDestrioTfe) = 0 then
    qMargen.Caption := FormatFloat('###,###,###,##0.000;-###,###,###,##0.000;0.000', 0)
  else
    qMargen.Caption :=  FormatFloat('###,###,###,##0.000;-###,###,###,##0.000;0.000', (rImporteLiquidar - (rImporteCanarias + rTotalDestrioTfeImporte + rImporteCompra)) / (rTotalPeso + rTotalDestrioTfe));
end;

procedure TQLLiquidaResumen.qrdbtxt3Print(sender: TObject;
  var Value: String);
begin
  Value:= 'PROMEDIOS CAT. ' + desCategoria( 'F17', sProducto, Value );
end;

procedure TQLLiquidaResumen.qrdbtxtpal_statusPrint(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 4, Length(Value) - 3 );
end;

end.

