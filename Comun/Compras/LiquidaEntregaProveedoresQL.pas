unit LiquidaEntregaProveedoresQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLLiquidaEntregaProveedores = class(TQuickRep)
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
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
    qrlbl3: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl18: TQRLabel;
    BandaDetalle: TQRBand;
    qrdbtxtpal_categoria: TQRDBText;
    qrdbtxtpal_cliente: TQRDBText;
    qrdbtxtpal_status: TQRDBText;
    qrdbtxtpal_proveedor: TQRDBText;
    qrdbtxtpal_cajas_confeccionados: TQRDBText;
    qrdbtxtpal_kilos_confeccionados: TQRDBText;
    qrdbtxtpal_importe_neto: TQRDBText;
    qrdbtxtpal_importe_compra: TQRDBText;
    qrdbtxtpal_importe_descuento: TQRDBText;
    qrdbtxtpal_importe_gastos: TQRDBText;
    qrdbtxtpal_importe_material: TQRDBText;
    qrdbtxtpal_importe_general: TQRDBText;
    qrdbtxtpal_entrega: TQRDBText;
    qrbndPieCliente: TQRBand;
    qrxpr8: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    SummaryBand1: TQRBand;
    qrlbl10: TQRLabel;
    qrlbl15: TQRLabel;
    qrgrpProveedor: TQRGroup;
    qrgrpCategoria: TQRGroup;
    qrdbtxt4: TQRDBText;
    qrgrpCliente_: TQRGroup;
    qrdbtxt6: TQRDBText;
    qrdbtxtliq_categoria: TQRDBText;
    qrdbtxtliq_categoria1: TQRDBText;
    qrdbtxtliq_cliente_sal: TQRDBText;
    qrdbtxtliq_importe_beneficio: TQRDBText;
    qrdbtxtliq_importe_financiero: TQRDBText;
    qrdbtxtliq_importe_liquidar: TQRDBText;
    qrlbl16: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrdbtxt3: TQRDBText;
    qrdbtxt5: TQRDBText;
    qrxpr20: TQRExpr;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrshpCliente: TQRShape;
    bndcChildBand1: TQRChildBand;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrbndPieCategoria: TQRBand;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrxpr25: TQRExpr;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrxpr29: TQRExpr;
    qrxpr30: TQRExpr;
    qrxpr31: TQRExpr;
    qrxpr32: TQRExpr;
    qrxpr33: TQRExpr;
    qrshpCategoria: TQRShape;
    qrdbtxtliq_categoria2: TQRDBText;
    bndcChildBand2: TQRChildBand;
    qrdbtxtliq_proveedor: TQRDBText;
    qrbndPieProveedor: TQRBand;
    qrshp1: TQRShape;
    qrxpr34: TQRExpr;
    qrxpr35: TQRExpr;
    qrxpr36: TQRExpr;
    qrxpr37: TQRExpr;
    qrxpr38: TQRExpr;
    qrxpr39: TQRExpr;
    qrxpr40: TQRExpr;
    qrxpr41: TQRExpr;
    qrxpr42: TQRExpr;
    qrxpr43: TQRExpr;
    qrxpr44: TQRExpr;
    qrdbtxtliq_proveedor1: TQRDBText;
    qrlbl1: TQRLabel;
    qrbnd1: TQRBand;
    qrsysdt1: TQRSysData;
    procedure qrdbtxtliq_proveedorPrint(sender: TObject; var Value: String);
    procedure qrdbtxtliq_categoria1Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtliq_cliente_salPrint(sender: TObject;
      var Value: String);
    procedure qrdbtxt5Print(sender: TObject; var Value: String);
    procedure qrdbtxt7Print(sender: TObject; var Value: String);
    procedure qrdbtxtliq_categoria2Print(sender: TObject;
      var Value: String);
    procedure qrgrpProveedorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtliq_proveedor1Print(sender: TObject;
      var Value: String);
  private
     sProducto: String;
     procedure VerPrecios( const APrecios: boolean );
  public

  end;

  procedure PrevisualizarLiquidacion( const AEmpresa, AProducto: string; const APrecios: boolean );

implementation

{$R *.DFM}

uses LiquidaEntregaDL, UDMAuxDB,  DPreview, CReportes;


procedure PrevisualizarLiquidacion( const AEmpresa, AProducto: string; const APrecios: boolean );
var
  QLLiquidaEntregaProveedores: TQLLiquidaEntregaProveedores;
  sAux: string;
begin
  QLLiquidaEntregaProveedores := TQLLiquidaEntregaProveedores.Create(Application);
  PonLogoGrupoBonnysa(QLLiquidaEntregaProveedores, AEmpresa);
  QLLiquidaEntregaProveedores.VerPrecios( APrecios );
  sAux:= QLLiquidaEntregaProveedores.DataSet.FieldByName('liq_anyo_semana').AsString;
  QLLiquidaEntregaProveedores.sProducto := AProducto;
  QLLiquidaEntregaProveedores.qrlblTitulo.Caption:= 'INFORME POR PRODUCTOR ' + AEmpresa  + ' - SEMANA ' + sAux + ' ' + AProducto + ' - ' + desProducto('', AProducto);
  QLLiquidaEntregaProveedores.ReportTitle:= 'INFORME_POR_PRODUCTOR_' + AEmpresa  + '_SEMANA_' + sAux + '_' + AProducto;
  Preview(QLLiquidaEntregaProveedores);
end;

procedure TQLLiquidaEntregaProveedores.VerPrecios( const APrecios: boolean );
begin
  if not APrecios then
  begin
    qrdbtxtpal_importe_neto.DataField:= 'liq_importe_neto';
    qrdbtxtpal_importe_descuento.DataField:= 'liq_importe_descuento';
    qrdbtxtpal_importe_gastos.DataField:= 'liq_importe_gastos';
    qrdbtxtpal_importe_compra.DataField:= 'liq_importe_compra';
    qrdbtxtpal_importe_material.DataField:= 'liq_importe_envasado';
    qrdbtxtpal_importe_general.DataField:= 'liq_importe_liquidar';
    qrdbtxtliq_importe_beneficio.DataField:= 'liq_importe_beneficio';
    qrdbtxtliq_importe_financiero.DataField:= 'liq_importe_financiero';
  end
  else
  begin
    qrdbtxtpal_importe_neto.DataField:= 'liq_precio_neto';
    qrdbtxtpal_importe_descuento.DataField:= 'liq_precio_descuento';
    qrdbtxtpal_importe_gastos.DataField:= 'liq_precio_gastos';
    qrdbtxtpal_importe_compra.DataField:= 'liq_precio_compra';
    qrdbtxtpal_importe_material.DataField:= 'liq_precio_envasado';
    qrdbtxtpal_importe_general.DataField:= 'liq_precio_liquidar';
    qrdbtxtliq_importe_beneficio.DataField:= 'liq_precio_beneficio';
    qrdbtxtliq_importe_financiero.DataField:= 'liq_precio_financiero';
  end;
end;

procedure TQLLiquidaEntregaProveedores.qrdbtxtliq_proveedorPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + '/' + DataSet.FieldByName('liq_almacen').AsString + ' - ' +
    desProveedorAlmacen( DataSet.FieldByName('liq_empresa').AsString, Value, DataSet.FieldByName('liq_almacen').AsString );
  //Value:= Value + ' - ' + desProveedor( DataSet.FieldByName('liq_empresa').AsString, Value );
end;

procedure TQLLiquidaEntregaProveedores.qrdbtxtliq_categoria1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + desCategoria( DataSet.FieldByName('liq_empresa').AsString, sProducto, Value );
end;

procedure TQLLiquidaEntregaProveedores.qrdbtxtliq_cliente_salPrint(sender: TObject;
  var Value: String);
begin
  if Value = '###' then
    Value:= 'SIN CLIENTE ASIGNADO'
  else
  if Value = 'ZZZ' then
    Value:= 'DESTRIO/PLACEROS'
  else
    Value:= Value + ' - ' + desCliente( Value );
end;

procedure TQLLiquidaEntregaProveedores.qrdbtxt5Print(sender: TObject;
  var Value: String);
var
  sAux: string;
begin
  sAux:= DataSet.FieldByName('liq_proveedor').AsString + '/' +
         DataSet.FieldByName('liq_almacen').AsString + '_' +
         DataSet.FieldByName('liq_categoria').AsString + ' ';

  if Value = '###' then
    Value:= sAux + 'SIN CLIENTE ASIGNADO'
  else
  if Value = '000' then
    Value:= sAux + 'DESTRIO/PLACEROS'
  else
    Value:= sAux + desCliente( Value );
end;

procedure TQLLiquidaEntregaProveedores.qrdbtxt7Print(sender: TObject;
  var Value: String);
begin
    Value:= 'PROMEDIOS CAT. ' + desCategoria( DataSet.FieldByName('liq_empresa').AsString, sProducto, Value );
end;

procedure TQLLiquidaEntregaProveedores.qrdbtxtliq_categoria2Print(sender: TObject;
  var Value: String);
begin
  Value:= DataSet.FieldByName('liq_proveedor').AsString + '/' + DataSet.FieldByName('liq_almacen').AsString +
    ' PROMEDIOS CAT. ' + desCategoria( DataSet.FieldByName('liq_empresa').AsString, sProducto, Value );
end;

procedure TQLLiquidaEntregaProveedores.qrgrpProveedorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrgrpProveedor.Height:= 0;
end;

procedure TQLLiquidaEntregaProveedores.qrdbtxtliq_proveedor1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL PROVEEDOR ' + Value + '/' + DataSet.FieldByName('liq_almacen').AsString;
  // + ' - ' + desProveedorAlmacen( DataSet.FieldByName('liq_empresa').AsString, Value, DataSet.FieldByName('liq_almacen').AsString );
  //Value:= Value + ' - ' + desProveedor( DataSet.FieldByName('liq_empresa').AsString, Value );
end;

end.

