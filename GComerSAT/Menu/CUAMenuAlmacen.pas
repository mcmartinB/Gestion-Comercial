unit CUAMenuAlmacen;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms;

procedure EjecutarMenuAlmacen( const AForm: TForm; const AOpcion: string );

implementation

uses
  Inventario, ConfeccionadoPorEnvases, SobrepesoEnvasado, VerificarSobrepesoEnvasado,
  CosteEnvasado, VerificarCosteEnvasado, CostesDeEnvasadoMensual,  MCostesIndirectos,
  PrecioDiarioEnvases, UFLConfecPorAgrupacion,  CFLSobrepesosActuales, CosteKgEnvasadoMensual,
  TablaAnualCosteKgEnvasado,   ResumenInventarios, SobrepesosPeriodoFD, ParteProduccionFL,
  AprovechaEntradasFD, LiqProdAjustesFD, PrecioVenta, ExistenciasLameFD;

procedure EjecutarMenuAlmacen( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuAlmInventario' then
    CrearVentana( AForm, TFInventario)
  else
  if AOpcion = 'mnuAlmInventario' then
    CrearVentana( AForm, TFConfeccionadoPorEnvases)
  else
  if AOpcion = 'mnuAlmConfeccionadoEnvases' then
    CrearVentana( AForm, TFConfeccionadoPorEnvases)
  else
  if AOpcion = 'mnuAlmConfeccionadoAgrupacion' then
    CrearVentana( AForm, TFLConfecPorAgrupacion)
  else
  if AOpcion = 'mnuAlmSobrepesoEnvase' then
    CrearVentana( AForm, TFSobrepesoEnvasado)
  else
  if AOpcion = 'mnuAlmVerificarGrabacionEnvasado' then
    CrearVentana( AForm, TFVerificarSobrepesoEnvasado)
  else
  if AOpcion = 'mnuAlmSopresesosActuales' then
    CrearVentana( AForm, TFLSobrepesosActuales)
  else
  if AOpcion = 'mnuAlmCostesEnvase' then
    CrearVentana( AForm, TFCosteEnvasado)
  else
  if AOpcion = 'mnuAlmVerificarCosteEnvases' then
    CrearVentana( AForm, TFVerificarCosteEnvasado)
  else
  if AOpcion = 'mnuAlmLstCosteEnvase' then
    CrearVentana( AForm, TFCostesDeEnvasadoMensual)
  else
  if AOpcion = 'mnuAlmLstCosteEnvaseKg' then
    CrearVentana( AForm, TFCosteKgEnvasadoMensual)
  else
  if AOpcion = 'mnuAlmTablaCostesEnvasado' then
    //SIN USO
    CrearVentana( AForm, TFTablaAnualCosteKgEnvasado)
  else
  if AOpcion = 'mnuAlmCostesIndirectos' then
    CrearVentana( AForm, TFMCostesIndirectos)
  else
  if AOpcion = 'mnuAlmPreciosDiariosrEnvases' then
    CrearVentana( AForm, TFPrecioDiarioEnvases)
  else
  if AOpcion = 'mnuAlmResumenInventario' then
    CrearVentana( AForm, TFResumenInventarios )
  else
  if AOpcion = 'mnuAlmSobrepesosPeriodo' then
    CrearVentana( AForm, TFDSobrepesosPeriodo )
  else
  if AOpcion = 'mnuParteProduccion' then
    CrearVentana( AForm, TFLParteProduccion )
  else
  if AOpcion = 'mnuLiqAprovechaEntradas' then
    CrearVentana( AForm, TFDAprovechaEntradas )
  else
  if AOpcion = 'mnuLiqAjusteEntradas' then
    CrearVentana( AForm, TFDLiqProdAjustes )
  else
  if AOpcion = 'mnuAlmPrecioVentaCliente' then
    CrearVentana( AForm, TFPrecioVenta )
  else
  if AOpcion = 'mnuExistenciasPuntoLame' then
    CrearVentana( AForm, TFDExistenciasLame );

end;

end.
