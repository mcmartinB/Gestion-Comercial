unit LiquidaResumenClientesQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, grimgctrl, DB;

type
  TQLLiquidaResumenClientes = class(TQuickRep)
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
    qrgrpCabStatus: TQRGroup;
    qrdbtxtliq_importe_beneficio: TQRDBText;
    qrdbtxtliq_importe_financiero: TQRDBText;
    qrdbtxtliq_importe_liquidar: TQRDBText;
    qrlbl16: TQRLabel;
    qrbndPieStatus: TQRBand;
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
    grCentroCabCalidad: TQRGroup;
    qrbndPieCliente: TQRBand;
    qrdbtxtres_status: TQRDBText;
    qrdbtxt1: TQRDBText;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrxpr29: TQRExpr;
    qrxpr30: TQRExpr;
    qrxpr31: TQRExpr;
    qrxpr32: TQRExpr;
    qrxpr33: TQRExpr;
    qrxpr34: TQRExpr;
    qrxpr35: TQRExpr;
    qrxpr36: TQRExpr;
    qrxpr37: TQRExpr;
    qrxpr38: TQRExpr;
    qrxpr39: TQRExpr;
    qrpdfshp1: TQRPDFShape;
    qrdbtxtres_importe_neto: TQRDBText;
    qrlbl17: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrxpr40: TQRExpr;
    qrxpr41: TQRExpr;
    qrxpr42: TQRExpr;
    q1: TQRLabel;
    QRDBText1: TQRDBText;
    QRExpr1: TQRExpr;
    q2: TQRLabel;
    q3: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRDBText2: TQRDBText;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRDBText3: TQRDBText;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    q4: TQRLabel;
    q5: TQRLabel;
    q6: TQRLabel;
    q7: TQRLabel;
    q10: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    QRExpr16: TQRExpr;
    QRExpr17: TQRExpr;
    QRExpr18: TQRExpr;
    QRExpr19: TQRExpr;
    QRExpr20: TQRExpr;
    QRExpr21: TQRExpr;
    QRExpr22: TQRExpr;
    QRExpr23: TQRExpr;
    QRExpr25: TQRExpr;
    q8: TQRLabel;
    qrdbtxtliq_importe_flete: TQRDBText;
    QRExpr24: TQRExpr;
    QRExpr26: TQRExpr;
    QRExpr27: TQRExpr;
    grCentroCabCliente: TQRGroup;
    QRDBText9: TQRDBText;
    qrbndPieCalidad: TQRBand;
    QRExpr28: TQRExpr;
    QRExpr29: TQRExpr;
    QRExpr30: TQRExpr;
    QRExpr31: TQRExpr;
    QRExpr32: TQRExpr;
    QRExpr33: TQRExpr;
    QRExpr34: TQRExpr;
    QRExpr35: TQRExpr;
    QRExpr36: TQRExpr;
    QRExpr37: TQRExpr;
    QRExpr38: TQRExpr;
    QRExpr39: TQRExpr;
    QRExpr40: TQRExpr;
    QRPDFShape1: TQRPDFShape;
    QRExpr41: TQRExpr;
    QRExpr42: TQRExpr;
    QRExpr43: TQRExpr;
    QRExpr44: TQRExpr;
    QRExpr45: TQRExpr;
    QRExpr46: TQRExpr;
    QRExpr47: TQRExpr;
    QRExpr48: TQRExpr;
    QRExpr49: TQRExpr;
    QRExpr50: TQRExpr;
    q9: TQRLabel;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRExpr51: TQRExpr;
    q11: TQRLabel;
    QRExpr52: TQRExpr;
    QRExpr53: TQRExpr;
    QRExpr54: TQRExpr;
    grpagefooter: TQRBand;
    q12: TQRLabel;
    qTotalDestrioTfe: TQRLabel;
    qTotalDestrioTfeImporte: TQRLabel;
    q18: TQRLabel;
    qTotalPeso: TQRLabel;
    qTotalImporte: TQRLabel;
    procedure qrdbtxtliq_categoria1Print(sender: TObject;
      var Value: String);
    procedure qrdbtxt3Print(sender: TObject; var Value: String);
    procedure qrdbtxtpal_statusPrint(sender: TObject; var Value: String);
    procedure qrgrpCabStatusBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure t(sender: TObject; var Value: String);
    procedure qrdbtxtres_statusPrint(sender: TObject; var Value: string);
    procedure q9Print(sender: TObject; var Value: string);
    procedure grCentroCabCalidadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieCalidadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure BandaDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieStatusBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndcChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
     bProvLiq: boolean;
     sProducto: String;
     procedure VerPrecios( const APrecios: boolean );

  public

  end;
  var rTotalDestrioTfe, rTotalDestrioTfeImporte, rTotalPeso, rTotalCompra: Real;

  var   QLLiquidaResumenClientes: TQLLiquidaResumenClientes;
  procedure PrevisualizarResumenClientes( const AOwner:TComponent; const AEmpresa, AProducto: string; const APrecios, AProvLiq: boolean;
                                          ATotalDestrioTfe, ATotalDestrioTfeImporte, ATotalPeso, ATotalCompra:Real );


implementation

{$R *.DFM}

uses LiquidaEntregaDL, UDMAuxDB,  DPreview, CReportes;


procedure PrevisualizarResumenClientes( Const AOwner: TComponent; const AEmpresa, AProducto: string; const APrecios, AProvLiq: boolean;
                                        ATotalDestrioTfe, ATotalDestrioTfeImporte, ATotalPeso, ATotalCompra:Real  );
var
  sAux: string;
begin
  QLLiquidaResumenClientes := TQLLiquidaResumenClientes.Create(AOwner);
  QLLiquidaResumenClientes.bProvLiq := AProvLiq;
  PonLogoGrupoBonnysa(QLLiquidaResumenClientes, AEmpresa);
  QLLiquidaResumenClientes.VerPrecios( APrecios );
  sAux:= QLLiquidaResumenClientes.DataSet.FieldByName('res_anyo_semana').AsString;
  QLLiquidaResumenClientes.sProducto := AProducto;
  QLLiquidaResumenClientes.qrlblTitulo.Caption:= 'RESUMEN POR CLIENTE ' + AEmpresa  + ' - SEMANA ' + sAux + ' ' + AProducto + ' - ' + desProducto('', AProducto);
  QLLiquidaResumenClientes.ReportTitle:= 'RESUMEN_POR_CLIENTE_' + AEmpresa  + '_SEMANA_' + sAux + '_' + AProducto;
  rTotalDestrioTfe := ATotalDestrioTfe;
  rTotalDestrioTfeImporte := ATotalDestrioTfeImporte;
  rTotalPeso := ATotalPeso;
  rTotalCompra := ATotalCompra;

  Preview(QLLiquidaResumenClientes);
end;

procedure TQLLiquidaResumenClientes.VerPrecios( const APrecios: boolean );
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
    qrdbtxtliq_importe_flete.DataField:= 'res_importe_flete';
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
    qrdbtxtliq_importe_flete.DataField:= 'res_precio_flete';
  end;
end;

procedure TQLLiquidaResumenClientes.qrdbtxtliq_categoria1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value;
end;

procedure TQLLiquidaResumenClientes.qrbndPieCalidadBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin

  if DataSet.FieldbyName('res_status').AsString <> '2.-DIRECTA' then
//    PrintBand := false
      Sender.Height:= 1
  else
      Sender.Height:= 20;
//    PrintBand := True;

  QRExpr45.Enabled := bProvLiq;
  QRExpr46.Enabled := bProvLiq;
  QRExpr47.Enabled := bProvLiq;
  QRExpr48.Enabled := bProvLiq;
  QRExpr49.Enabled := bProvLiq;

end;

procedure TQLLiquidaResumenClientes.qrbndPieClienteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRExpr10.Enabled := bProvLiq;
  QRExpr13.Enabled := bProvLiq;
  QRExpr16.Enabled := bProvLiq;
  QRExpr17.Enabled := bProvLiq;
  QRExpr18.Enabled := bProvLiq;
end;

procedure TQLLiquidaResumenClientes.qrbndPieStatusBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRExpr11.Enabled := bProvLiq;
  QRExpr14.Enabled := bProvLiq;
  QRExpr19.Enabled := bProvLiq;
  QRExpr21.Enabled := bProvLiq;
  QRExpr23.Enabled := bProvLiq;
end;

procedure TQLLiquidaResumenClientes.qrdbtxt3Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + Value;
end;

procedure TQLLiquidaResumenClientes.BandaDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRDBText4.Enabled := bProvLiq;
  QRDBText5.Enabled := bProvLiq;
  QRDBText6.Enabled := bProvLiq;
  QRDBText7.Enabled := bProvLiq;
  QRDBText8.Enabled := bProvLiq;
end;

procedure TQLLiquidaResumenClientes.bndcChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRExpr12.Enabled := bProvLiq;
  QRExpr15.Enabled := bProvLiq;
  QRExpr20.Enabled := bProvLiq;
  QRExpr22.Enabled := bProvLiq;
  QRExpr25.Enabled := bProvLiq;

  qTotalDestrioTfe.Caption := FormatFloat('###,###,###,##0;-###,###,###,##0;0', rTotalDestrioTfe);
  qTotalPeso.Caption := FormatFloat('###,###,###,##0;-###,###,###,##0;0', rTotalPeso + rTotalDestrioTfe);
  qTotalDestrioTfeImporte.Caption := FormatFloat('###,###,###,##0;-###,###,###,##0;0', rTotalDestrioTfeImporte);
  qTotalImporte.Caption := FormatFloat('###,###,###,##0;-###,###,###,##0;0', rTotalCompra + rTotalDestrioTfeImporte);

end;


procedure TQLLiquidaResumenClientes.grCentroCabCalidadBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin

  if DataSet.FieldbyName('res_status').AsString <> '2.-DIRECTA' then
//    PrintBand := false
    Sender.Height:= 1
  else
//    PrintBand := True;
    Sender.Height:=20;

end;

procedure TQLLiquidaResumenClientes.q9Print(sender: TObject; var Value: string);
begin
  if DataSet.FieldByName('res_calidad').AsString = 'M' then
    Value:= 'TOTAL MADURO'
  else if DataSet.FieldByName('res_calidad').AsString = 'V' then
    Value:= 'TOTAL VERDE';
end;

procedure TQLLiquidaResumenClientes.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  q4.Enabled := bProvLiq;
  q5.Enabled := bProvLiq;
  q6.Enabled := bProvLiq;
  q7.Enabled := bProvLiq;
  q10.Enabled := bProvLiq;
end;

procedure TQLLiquidaResumenClientes.qrdbtxtpal_statusPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + DesCategoria( 'F17', sProducto, Value );
end;

procedure TQLLiquidaResumenClientes.qrdbtxtres_statusPrint(sender: TObject;
  var Value: string);
begin
  if Value = 'M' then
    Value := 'MADURO'
  else if Value = 'V' then
    Value := 'VERDE';
end;

procedure TQLLiquidaResumenClientes.qrgrpCabStatusBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
//  Sender.Height:= 0;
end;

procedure TQLLiquidaResumenClientes.t(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desClienteBag( Value );
end;

end.

