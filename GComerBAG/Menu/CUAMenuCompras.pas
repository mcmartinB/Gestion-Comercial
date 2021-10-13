unit CUAMenuCompras;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms;

procedure EjecutarMenuCompras( const AForm: TForm; const AOpcion: string );

implementation

uses
  Dialogs, UDMConfig, UFMEntregasProveedor, ListEntregasFL, ResumenEntregasFL,
  CosteFrutaProveedorFL, ComprobacionGastosEntregasFL,
  LFGastosEntregas, DListadoControlEntregas, EntregasPendientesFL,
  StockFrutaPlantaFL, ValorarFrutaPlantaFL, PaletsVolcadosEntregaFL,
  StockFrutaConfeccionadaFL, StockFrutaConfeccionadaMasetFL, PaletsConfeccionadosFL,
  ResumenEntregasMasetFL,  DRecibirEntregasCentral,  LiquidacionEntregaFL,
  ComparaKilosComerRadioFL, FacturasGastosEntregasFL, EntregasSinFacturarFL,
  CosteFrutaProductoFL, LServiciosTransporteEntregas, ComparaFechasComerRadioFL,
  BeneficioProductoFL, ComprasProductoProveedorFL, MargenPeriodoFL,
  IntrastatEntradaFL, ControlIntrastatFL, DestrioFrutaRFFL, MargenSemanalFL,
  UFMFacturasEntregasPlatano, CuadreAlmacenSemanalFL, ValorarStockProveedorFL,
  ValorarStockConfeccionadoFL, MPrevCostesProducto,
  ControlImportesLineasFR, MargenBPeriodoFL;


procedure EjecutarMenuCompras( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuEntFacturasPlatano' then
    CrearVentana( AForm, TFMFacturasEntregasPlatano)
  else
  if ( AOpcion = 'mnuEntEntregas' ) or ( AOpcion = 'btnEntregas' ) then
  begin
    CrearVentana( AForm, TFMEntregasProveedor);
  end
  else
  if AOpcion = 'mnuEntPendientesDescarga' then
    CrearVentana( AForm, TFLEntregasPendientes )
  else
  if AOpcion = 'mnuEntLstEntregas' then
    CrearVentana( AForm, TFLListEntregas)
  else
  if AOpcion = 'mnuEntLstControlEntregas' then
    CrearVentana( AForm, TFDListadoControlEntregas )
  else
  if AOpcion = 'mnuEntResEntregas' then
    CrearVentana( AForm, TFLResumenEntregas)
  else
  if AOpcion = 'mnuEntResPesosEntregas' then
    CrearVentana( AForm, TFLResumenEntregasMaset )
  else
  if AOpcion = 'mnuEntLstGastosEntregas' then
    CrearVentana( AForm, TFLGastosEntregas )
  else
  if AOpcion = 'mnuEntLstControlGastosEntregas' then
  begin
    CrearVentana( AForm, TFLComprobacionGastosEntregas);
  end
  else
  if ( AOpcion = 'mnuEntResumenCosteProductoBonde' ) or ( AOpcion = 'mnuEntResumenCosteProducto' ) then
     CrearVentana( AForm, TFLCosteFrutaProducto)
  else
  if ( AOpcion = 'mnuEntResumenCosteProveedorBonde' ) or ( AOpcion = 'mnuEntResumenCosteProveedor' ) then
     CrearVentana( AForm, TFLCosteFrutaProveedor)
  else
  if AOpcion = 'mnuEntComprasProductoProveedor'  then
  begin
     CrearVentana( AForm, TFLComprasProductoProveedor);
  end
  else
  if AOpcion = 'mnuEntBeneficioProducto'  then
  begin
     CrearVentana( AForm, TFLBeneficioProducto);
  end
  else
  if AOpcion = 'mnuEntStockActualProveedor' then
    CrearVentana( AForm, TFLStockFrutaPlanta )
  else
  if AOpcion = 'mnuEntValorarStockProveedor' then
    CrearVentana( AForm, TFLValorarStockProveedor )
  else
  if AOpcion = 'mnuEntValorarStockConfeccionado' then
    CrearVentana( AForm, TFLValorarStockConfeccionado )
  else
  if AOpcion = 'mnuEntValorFrutaPlantaProveedor' then
    CrearVentana( AForm, TFLValorarFrutaPlanta )
  else
  if AOpcion = 'mnuEntPaletsProveedorVolcados' then
    CrearVentana( AForm, TFLPaletsVolcadosEntrega )
  else
  if AOpcion = 'mnuStockFrutaConfeccionadaFormatos' then
  begin
    CrearVentana( AForm, TFLStockFrutaConfeccionadaMaset );
  end
  else
  if AOpcion = 'mnuStockFrutaConfeccionadaEnvases' then
  begin
    CrearVentana( AForm, TFLStockFrutaConfeccionada );
  end
  else
  if AOpcion = 'mnuEntPaletsConfeccionados' then
    CrearVentana( AForm, TFLPaletsConfeccionados )
  else
  if AOpcion = 'mnuEntLstFacturasProveedorNew' then
    CrearVentana( AForm, TFLFacturasGastosEntregas )
  else
  if AOpcion = 'mnuEntEntregasSinFacturar' then
    CrearVentana( AForm, TFLEntregasSinFacturar )
  else
  if AOpcion = 'mnuEntRecibirEntregas' then
    TFDRecibirEntregasCentral.Create( AForm ).ShowModal
  else
  if AOpcion = 'mnuEntLiquidacionEntrega' then
    CrearVentana( AForm, TFLLiquidacionEntrega )
  else
  if AOpcion = 'mnuEntDifKilosComerRF' then
    CrearVentana( AForm, TFLComparaKilosComerRadio )
  else
  if AOpcion = 'mnuEntDifFechasComerRF' then
    CrearVentana( AForm, TFLComparaFechasComerRadio )
  else
  if AOpcion = 'mnuEntServiciosTransportes' then
    CrearVentana( AForm, TFLServiciosTransporteEntregas )
  else
  if AOpcion = 'mnuEntControlIntrastat' then
    CrearVentana( AForm, TFLControlIntrastat )
  else
  if AOpcion = 'mnuEntIntrasat' then
   CrearVentana( AForm, TFLIntrastatEntrada )
  else
  if AOpcion = 'mnuEntListadoDestrioFrutaRF' then
   CrearVentana( AForm, TFLDestrioFrutaRF )
  else
  if AOpcion = 'mnuEntMargenPeriodo' then
   CrearVentana( AForm, TFLMargenPeriodo )
  else
  if AOpcion = 'mnuEntMargenSemanal' then
   CrearVentana( AForm, TFLMargenSemanal )
  else
  if AOpcion = 'mnuEntCuadreSemanalRFAlmacen' then
   CrearVentana( AForm, TFLCuadreAlmacenSemanal )
  else
  if AOpcion = 'mnuEntPrevisionCostesProducto' then
   CrearVentana( AForm, TFMPrevCostesProducto )
  else
  if AOpcion = 'mnuEntControlImportesFacturasLineas' then
    CrearVentana( AForm, TFRControlImportesLineas )
  else
  if AOpcion = 'mniEntMargenBeneficio' then
    CrearVentana( AForm, TFLMargenBPeriodo );

end;


end.

