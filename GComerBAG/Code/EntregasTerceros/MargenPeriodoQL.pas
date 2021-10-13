unit MargenPeriodoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLMargenPeriodo = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    lblProducto: TQRLabel;
    bnddPaletsConfeccionados: TQRSubDetail;
    qrefecha_alta: TQRDBText;
    qrefecha_carga: TQRDBText;
    qrecentro: TQRDBText;
    qreorden: TQRDBText;
    qreean128: TQRDBText;
    qreean13: TQRDBText;
    qreenvase: TQRDBText;
    qrecajas: TQRDBText;
    qrepeso: TQRDBText;
    qrepeso_teorico: TQRDBText;
    qrestatus: TQRDBText;
    bndDetalle: TQRBand;
    qrepeso_albaran1: TQRDBText;
    qrepeso_albaran2: TQRDBText;
    qrlBenef: TQRLabel;
    qrx1: TQRExpr;
    qrl5: TQRLabel;
    bndCabPaletsConfeccionados: TQRGroup;
    qregrupo: TQRDBText;
    bndCabPaletsProveedores: TQRGroup;
    qregrupo_in: TQRDBText;
    bnddPaletsProveedores: TQRSubDetail;
    qrefecha: TQRDBText;
    qrecentro1: TQRDBText;
    qreentrega: TQRDBText;
    qresscc: TQRDBText;
    qreproveedor: TQRDBText;
    qrevariedad: TQRDBText;
    qrecalibre: TQRDBText;
    qrecajas_in: TQRDBText;
    qrepeso_in: TQRDBText;
    qrepeso_bruto: TQRDBText;
    qrestatus_in: TQRDBText;
    qreprecio_in: TQRDBText;
    bndTituloConfeccionado: TQRBand;
    bndTituloProveedor: TQRBand;
    bndPieConfeccionados: TQRBand;
    bndPiePaletsProveedor: TQRBand;
    qrx2: TQRExpr;
    qrx3: TQRExpr;
    qrx4: TQRExpr;
    qrx6: TQRExpr;
    qrx7: TQRExpr;
    qrx9: TQRExpr;
    qreunidades: TQRDBText;
    qreunidades1: TQRDBText;
    bndcChildBand3: TQRChildBand;
    qrl8: TQRLabel;
    qrl9: TQRLabel;
    qrl10: TQRLabel;
    qrl11: TQRLabel;
    qrl12: TQRLabel;
    qrl14: TQRLabel;
    qrl15: TQRLabel;
    qrl16: TQRLabel;
    qrl17: TQRLabel;
    qrl18: TQRLabel;
    qrl20: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl21: TQRLabel;
    bndcChildBand4: TQRChildBand;
    qrl23: TQRLabel;
    qrl36: TQRLabel;
    qrl37: TQRLabel;
    qrl38: TQRLabel;
    qrl39: TQRLabel;
    qrl40: TQRLabel;
    qrl41: TQRLabel;
    qrl42: TQRLabel;
    qrl43: TQRLabel;
    qrl44: TQRLabel;
    qrl45: TQRLabel;
    qrlprecio_in: TQRLabel;
    qrl47: TQRLabel;
    qrx10: TQRExpr;
    qrx11: TQRExpr;
    qreproducto1: TQRDBText;
    bndcChildBand1: TQRChildBand;
    qrekilos_albaran: TQRDBText;
    qrepeso_albaran: TQRDBText;
    qrecajas_albaran: TQRDBText;
    qreunidades_albaran: TQRDBText;
    qrl1: TQRLabel;
    qrl48: TQRLabel;
    qrl22: TQRLabel;
    qrl24: TQRLabel;
    qrs3: TQRShape;
    qrl25: TQRLabel;
    qrl51: TQRLabel;
    qrePesoRFIn: TQRDBText;
    qreUnidadesRFIn: TQRDBText;
    qrlRFIn: TQRLabel;
    qrl3: TQRLabel;
    qrs1: TQRShape;
    qrs4: TQRShape;
    qrlMerma: TQRLabel;
    qrekilos_in_valor: TQRDBText;
    qrepeso_rfout_teorico: TQRDBText;
    qrl4: TQRLabel;
    qrecajas_confecionado_adelantado: TQRDBText;
    qrekilos_confecionado_adelantado: TQRDBText;
    qrepeso_confecionado_adelantado: TQRDBText;
    qreunidades_confecionado_adelantado: TQRDBText;
    qrl2: TQRLabel;
    qrl26: TQRLabel;
    qrl27: TQRLabel;
    qrl28: TQRLabel;
    qrx25: TQRExpr;
    qrx17: TQRExpr;
    qrx18: TQRExpr;
    qrx19: TQRExpr;
    qrx29: TQRExpr;
    qrx20: TQRExpr;
    qrx21: TQRExpr;
    qrx30: TQRExpr;
    qrl29: TQRLabel;
    qrepeso_volcado_anterior: TQRDBText;
    qreunidades_volcado_anterior: TQRDBText;
    qrl13: TQRLabel;
    qrl30: TQRLabel;
    qrs2: TQRShape;
    qrs5: TQRShape;
    qrl31: TQRLabel;
    qrekilos_volcado_anterior: TQRDBText;
    qrecajas_volcado_anterior: TQRDBText;
    qrl32: TQRLabel;
    qrecajas_volcado_adelantado: TQRDBText;
    qrekilos_volcado_adelantado: TQRDBText;
    qrepeso_volcado_adelantado: TQRDBText;
    qreunidades_volcado_adelantado: TQRDBText;
    qrl33: TQRLabel;
    qrl34: TQRLabel;
    qrl49: TQRLabel;
    qrl35: TQRLabel;
    qrx22: TQRExpr;
    qrx23: TQRExpr;
    qrx24: TQRExpr;
    qrx12: TQRExpr;
    qrx13: TQRExpr;
    qrx14: TQRExpr;
    qrx15: TQRExpr;
    qrx16: TQRExpr;
    qrl50: TQRLabel;
    qrl52: TQRLabel;
    qrx26: TQRExpr;
    qrx27: TQRExpr;
    qrx28: TQRExpr;
    bnddDetProveedor: TQRSubDetail;
    qreresumen_proveedor: TQRDBText;
    qreresumen_producto: TQRDBText;
    qreresumen_precio_maximo: TQRDBText;
    qreresumen_precio_minimo: TQRDBText;
    bndCabProveedor: TQRBand;
    bndPieProveedor: TQRBand;
    qrl53: TQRLabel;
    qrl54: TQRLabel;
    qrl55: TQRLabel;
    qrl56: TQRLabel;
    qreimporte_transito: TQRDBText;
    qrecoste_producto: TQRDBText;
    qrl19: TQRLabel;
    qrx5: TQRExpr;
    qrl46: TQRLabel;
    qrl57: TQRLabel;
    qrecoste_personal: TQRDBText;
    qrecoste_material: TQRDBText;
    qrl58: TQRLabel;
    qrx8: TQRExpr;
    qrl59: TQRLabel;
    qrl60: TQRLabel;
    qremargen_bruto: TQRDBText;
    qrecoste_general: TQRDBText;
    qrl61: TQRLabel;
    qrx31: TQRExpr;
    qrl62: TQRLabel;
    qrl63: TQRLabel;
    qrl64: TQRLabel;
    qremargen_operativo: TQRDBText;
    qrs6: TQRShape;
    qrs7: TQRShape;
    qrs8: TQRShape;
    qrxprecio_mercancia: TQRExpr;
    qrxprecio_transporte: TQRExpr;
    qrxprecio_transito: TQRExpr;
    qrxprecio_compra: TQRExpr;
    qrxprecio_personal: TQRExpr;
    qrxprecio_material: TQRExpr;
    qrxprecio_envasado: TQRExpr;
    qrxprecio_general: TQRExpr;
    qrxprecio_financiero: TQRExpr;
    qrx41: TQRExpr;
    qrx42: TQRExpr;
    qrx43: TQRExpr;
    qrxprecio_venta: TQRExpr;
    qrl65: TQRLabel;
    qrl66: TQRLabel;
    qrl67: TQRLabel;
    qrl68: TQRLabel;
    qrl69: TQRLabel;
    qrl70: TQRLabel;
    qrl71: TQRLabel;
    qrl72: TQRLabel;
    qrl73: TQRLabel;
    qrl74: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrdbtxtprecio_minimo_previsto: TQRDBText;
    qrdbtxtprecio_maximo_previsto: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrdbtxt3: TQRDBText;
    qrdbtxt4: TQRDBText;
    qrlbl7: TQRLabel;
    procedure qreProductoPrint(sender: TObject; var Value: String);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qregrupoPrint(sender: TObject; var Value: String);
    procedure qregrupo_inPrint(sender: TObject; var Value: String);
    procedure qreenvasePrint(sender: TObject; var Value: String);
    procedure qrevariedadPrint(sender: TObject; var Value: String);
    procedure qreproveedorPrint(sender: TObject; var Value: String);
    procedure bndCabPaletsConfeccionadosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndcChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrl19Print(sender: TObject; var Value: String);
    procedure bnddPaletsProveedoresBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreresumen_proveedorPrint(sender: TObject;
      var Value: String);
    procedure qreresumen_productoPrint(sender: TObject; var Value: String);
    procedure qrl5Print(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public
    bPaletsEntrada, bPaletsSalida: boolean;

    procedure PreparaListado( const AEmpresa, ACliente, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const APrecioUnidad: boolean );
  end;

procedure VerMargenPeriodo( const AOwner: TComponent;
                            const APaletsEntrada, APaletsSalida: boolean;
                            const AEmpresa, ACliente, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime;
                            const APrecioUnidad: boolean  );

implementation

{$R *.DFM}

uses
  CReportes, MargenBeneficiosDL, DPreview, UDMAuxDB, bMath;

var
  QLMargenPeriodo: TQLMargenPeriodo;


procedure VerMargenPeriodo( const AOwner: TComponent;
                            const APaletsEntrada, APaletsSalida: boolean;
                            const AEmpresa, ACliente, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime;
                            const APrecioUnidad: boolean  );
begin
  QLMargenPeriodo:= TQLMargenPeriodo.Create( AOwner );
  try
    QLMargenPeriodo.PreparaListado( AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, APrecioUnidad );
    QLMargenPeriodo.bPaletsEntrada:= APaletsEntrada;
    QLMargenPeriodo.bPaletsSalida:= APaletsSalida;
    QLMargenPeriodo.bndDetalle.ForceNewPage:= APaletsEntrada or APaletsSalida;
    Previsualiza( QLMargenPeriodo );
  finally
    FreeAndNil( QLMargenPeriodo );
  end;
end;

procedure TQLMargenPeriodo.PreparaListado( const AEmpresa, ACliente, AProducto: string;
                                           const AFechaIni, AFechaFin: TDateTime;
                                           const APrecioUnidad: boolean );
begin
  sEmpresa:= AEmpresa;

  PonLogoGrupoBonnysa( self, AEmpresa );

  if AProducto <> '' then
    lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto )
  else
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';

  if ACliente = 'MER' then
    qrl1.Caption:= 'MERCADONA'
  else
  if ACliente = 'SOC' then
    qrl1.Caption:= 'CARREFOUR'
  else
  if ACliente <> '' then
    qrl1.Caption:= ACliente + ' ' + desProducto( AEmpresa, AProducto )
  else
    qrl1.Caption:= 'TODOS LOS CLIENTES';    

  lblRango.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );

  if APrecioUnidad then
  begin
    qrxprecio_venta.Expression:= 'IF([unidades_albaran] > 0,[importe_venta]/[unidades_albaran],0)';
    qrxprecio_personal.Expression:= 'IF([unidades_albaran] > 0,[coste_personal]/[unidades_albaran],0)';
    qrxprecio_material.Expression:= 'IF([unidades_albaran] > 0,[coste_material]/[unidades_albaran],0)';
    qrxprecio_envasado.Expression:= 'IF([unidades_albaran] > 0,[coste_envasado]/[unidades_albaran],0)';
    qrxprecio_general.Expression:= 'IF([unidades_albaran] > 0,[coste_general]/[unidades_albaran],0)';
    qrxprecio_financiero.Expression:= 'IF([unidades_albaran] > 0,[coste_financiero]]/[unidades_albaran],0)';

    qrxprecio_mercancia.Expression:= 'IF([unidades_volcado_anterior]+[unidades_volcado] > 0,[importe_compra]/([unidades_volcado_anterior]+[unidades_volcado]),0)';
    qrxprecio_transporte.Expression:= 'IF([unidades_volcado_anterior]+[unidades_volcado] > 0,[importe_transporte]/([unidades_volcado_anterior]+[unidades_volcado]),0)';
    qrxprecio_transito.Expression:= 'IF([unidades_volcado_anterior]+[unidades_volcado] > 0,[importe_transito]/([unidades_volcado_anterior]+[unidades_volcado]),0)';
    qrxprecio_compra.Expression:= 'IF([unidades_volcado_anterior]+[unidades_volcado] > 0,[coste_producto]/([unidades_volcado_anterior]+[unidades_volcado]),0)';

    qrxprecio_venta.Mask:= '#,##0.000€/u';
    qrxprecio_personal.Mask:= '#,##0.000€/u';
    qrxprecio_material.Mask:= '#,##0.000€/u';
    qrxprecio_envasado.Mask:= '#,##0.000€/u';
    qrxprecio_general.Mask:= '#,##0.000€/u';
    qrxprecio_financiero.Mask:= '#,##0.000€/u';

    qrxprecio_mercancia.Mask:= '#,##0.000€/u';
    qrxprecio_transporte.Mask:= '#,##0.000€/u';
    qrxprecio_transito.Mask:= '#,##0.000€/u';
    qrxprecio_compra.Mask:= '#,##0.000€/u';
  end;
end;

procedure TQLMargenPeriodo.qreProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( sEmpresa, Value );
end;

procedure TQLMargenPeriodo.bndDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  bnddPaletsConfeccionados.DataSet.Filter:= 'producto_out = '  + QuotedStr( DataSet.FieldByName('producto').AsString );
  bnddPaletsProveedores.DataSet.Filter:= 'producto_in = '  + QuotedStr( DataSet.FieldByName('producto').AsString );
  bnddDetProveedor.DataSet.Filter:= 'producto_precio = '  + QuotedStr( DataSet.FieldByName('producto').AsString );
end;

procedure TQLMargenPeriodo.qregrupoPrint(sender: TObject;
  var Value: String);
begin
  if Value = '0' then
  begin
    Value:= 'Palets confecionados la semana anterior cargados la semana actual.';
  end
  else
  if Value = '1' then
  begin
    Value:= 'Palets confecionados la semana actual cargados la semana actual.';
  end
  else
  if Value = '2' then
  begin
    Value:= 'Palets confecionados la semana actual cargados la semana siguiente.';
  end;
end;

procedure TQLMargenPeriodo.qregrupo_inPrint(sender: TObject;
  var Value: String);
begin
  if Value = '0' then
  begin
    Value:= 'Palets volcados la semana anterior cargados la semana actual.';
  end
  else
  if Value = '1' then
  begin
    Value:= 'Palets volcados la semana actual cargados la semana actual.';
  end
  else
  if Value = '2' then
  begin
    Value:= 'Palets volcados la semana actual cargados la semana siguiente.';
  end;
end;

procedure TQLMargenPeriodo.qreenvasePrint(sender: TObject;
  var Value: String);
begin
    Value:= ' ' + Value + ' ' + desEnvaseProducto ( sEmpresa, Value, bnddPaletsConfeccionados.DataSet.FieldByName('producto_out').AsString );
end;

procedure TQLMargenPeriodo.qrevariedadPrint(sender: TObject;
  var Value: String);
begin
  Value:= ' ' + Value + ' ' + desVariedad( sEmpresa, bnddPaletsProveedores.DataSet.FieldByName('proveedor_in').AsString, bnddPaletsProveedores.DataSet.FieldByName('producto_in').AsString, Value );
end;

procedure TQLMargenPeriodo.qreproveedorPrint(sender: TObject;
  var Value: String);
begin
    Value:= Value + ' ' + desProveedor ( sEmpresa, Value );
end;

procedure TQLMargenPeriodo.bndCabPaletsConfeccionadosBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bPaletsSalida;
end;

procedure TQLMargenPeriodo.bndcChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not( bPaletsEntrada or bPaletsSalida );
end;

procedure TQLMargenPeriodo.qrl19Print(sender: TObject; var Value: String);
begin
  Value:= '';
end;

procedure TQLMargenPeriodo.bnddPaletsProveedoresBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bPaletsEntrada;
end;

procedure TQLMargenPeriodo.qreresumen_proveedorPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProveedor( sEmpresa, value );
end;

procedure TQLMargenPeriodo.qreresumen_productoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( sEmpresa, value );
end;

procedure TQLMargenPeriodo.qrl5Print(sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('importe_abonos').AsFloat <> 0 then
  begin
    if DataSet.FieldByName('importe_abonos').AsFloat > 0 then
      Value:=  'Ventas (+' + FormatFloat('#,##0.00', DataSet.FieldByName('importe_abonos').AsFloat)  + ')'
    else
      Value:=  'Ventas (' + FormatFloat('#,##0.00', DataSet.FieldByName('importe_abonos').AsFloat)  + ')';
  end
  else
  begin
    Value:=  'Ventas';
  end;
end;

end.
