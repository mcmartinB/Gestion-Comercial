unit CUAMenuAlmacen;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms;

procedure EjecutarMenuAlmacen( const AForm: TForm; const AOpcion: string );

implementation

uses
  CosteEnvasado,
  VerificarCosteEnvasado, CostesDeEnvasadoMensual,
  PrecioDiarioEnvases, CosteKgEnvasadoMensual,
  TablaAnualCosteKgEnvasado, LiquidaValorarPaletsFL,
  LiquidaInformeFL, LiquidaVerdeInformeFL, LiquidaPlatanoInformeFL,
  VerificarKilosEntregadosFL, EnvasesSinCosteEnvasado, MargenCargaRFAlmacenFL,
  ResumenConsumosFL, MCostesIndirectos, LiquidaValorarCargaDirectaFL,
  ParteProduccionFL, PrecioLiquidacion, PrecioVenta, ExistenciasLameFD;

procedure EjecutarMenuAlmacen( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuAlmCostesEnvase' then
    CrearVentana( AForm, TFCosteEnvasado)
  else
  if AOpcion = 'mnuAlmVerificarCosteEnvases' then
    CrearVentana( AForm, TFVerificarCosteEnvasado)
  else
  if AOpcion = 'mnuAlmEnvasesSinCoste' then
    CrearVentana( AForm, TFEnvasesSinCosteEnvasado)
  else
  if AOpcion = 'mnuAlm CosteEnvases' then
    CrearVentana( AForm, TFVerificarCosteEnvasado)
  else
  if AOpcion = 'mnuAlmLstCosteEnvase' then
    CrearVentana( AForm, TFCostesDeEnvasadoMensual)
  else
  if AOpcion = 'mnuAlmPrecioLiquidacion' then
    CrearVentana( AForm, TFPrecioLiquidacion)
  else
  if AOpcion = 'mnuAlmPreciosDiariosrEnvases' then
    CrearVentana( AForm, TFPrecioDiarioEnvases)
  else
  if AOpcion = 'mnuAlmCostesEstadisticosdeEnvasadoKg' then
    CrearVentana( AForm, TFCosteKgEnvasadoMensual)
  else
  if AOpcion = 'mnuAlmTablaAnualCosteKgEnvasado' then
    CrearVentana( AForm, TFTablaAnualCosteKgEnvasado)
  else
  if AOpcion = 'mnuAlmValorarPaletsEntrega' then
    CrearVentana( AForm, TFLLiquidaValorarPalets)
  else
  if AOpcion = 'mnuAlmLiquidarEntregas' then
    CrearVentana( AForm, TFLLiquidaInforme)
  else
  if AOpcion = 'mnuAlmLiquidarVerde' then
    CrearVentana( AForm, TFLLiquidaVerdeInforme)
  else
  if AOpcion = 'mnuAlmLiquidarPlatano' then
    CrearVentana( AForm, TFLLiquidaPlatanoInforme)
  else
  if AOpcion = 'mnuAlmKilosLiquidacionPlatanos' then
    CrearVentana( AForm, TFLVerificarKilosEntregados)
  else
  if AOpcion = 'mnuAlmValorarFrutaProveedor' then
    CrearVentana( AForm, TFLMargenCargaRFAlmacen)
  else
  if AOpcion = 'mnuAlmResumenConsumoEntrega' then
    CrearVentana( AForm, TFLResumenConsumos)
  else
  if AOpcion = 'mnuAlmCostesIndirectos' then
    CrearVentana( AForm, TFMCostesIndirectos)
  else
  if AOpcion = 'mnuAlmValorarCargaDirecta' then
    CrearVentana( AForm, TFLLiquidaValoraCargaDirecta)
  else
  if AOpcion = 'mnuAlmParteProduccion' then
    CrearVentana( AForm, TFLParteProduccion )
  else
  if AOpcion = 'mnuAlmPrecioVentaCliente' then
    CrearVentana ( AForm, TFPrecioVenta )
  else
  if AOpcion = 'mnuExistenciasPuntoLame' then
    CrearVentana( AForm, TFDExistenciasLame );

end;

end.
