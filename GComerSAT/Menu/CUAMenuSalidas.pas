unit CUAMenuSalidas;

interface

uses CUAMenuUtils, CDAMenuUtils, Forms, Dialogs;

procedure EjecutarMenuSalidas( const AForm: TForm; const AOpcion: string );

implementation

uses
  UDMConfig, MSalidas, DEnvioAlbSal, LFAlbaranesEnviados, LFSalidasCliente,
  ResumenSalidasProductoFL, LFSalidasCatCal, LSalidasResumenForm, LFExpediciones,
  LFSalidasEnvases2, LFSalidasEnvases, LMercadonaVentasSemanal,
  LFVentas, LFVentasNetoSem,
  LFVentasPorCliente,  LEntradasFederacion, LAsignacionFederaciones,
  MFederacionSalidas, LResumenFederaciones, LIntrastat, ListControlIntrasatFL, DAsigDua,
  ListadoSalidasPaletsForm, 
  VentasSuministroFL, SalidasSuministroFL, DatosExcelFOB,
  UFMServicioVenta, UFDAsignarGastosServicioVenta,
  CFLVentasFobCliente, MAjustesEnvComerciales, MInventarioEnvComerciales,
  MEntradasEnvComerciales, MTransitosEnvComerciales, LFMovimientosEnvComerciales,
  LFFacturaLogifruit, UFLTablaSalidas, FacturasGastosSalidasFL,
  LVentasLineaProductoCliente,LSalidasResumenDinamico, UFSalidasLPR, ArticuloDesgloseSal;

procedure EjecutarMenuSalidas( const AForm: TForm; const AOpcion: string );
var
  aux: integer;
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if ( AOpcion = 'mnuSalSalidas' ) or ( AOpcion = 'btnSalidas' ) then
  begin
    FMSalidas := TFMSalidas.create(AForm);
  end else
  if AOpcion = 'mnuDesgloseSalidas' then     CrearVentana ( AForm, TFArticuloDesgloseSal );
  if AOpcion = 'mnuSalTablaSalidas' then CrearVentana( AForm, TFLTablaSalidas ) else
  if AOpcion = 'mnuSalEnvioAlbaranes' then  FDEnvioAlbSal := TFDEnvioAlbSal.create(AForm) else
  if AOpcion = 'mnuSalLisAlbaranesEnviados' then CrearVentana( AForm, TFLAlbaranesEnviados ) else
  if AOpcion = 'mnuSalLisSalidasClientes' then CrearVentana( AForm, TFLSalidasCliente ) else
  if AOpcion = 'mnuSalLisSalidasProductos' then FLResumenSalidasProducto := TFLResumenSalidasProducto.Create(AForm) else
  if AOpcion = 'mnuSalLisSalidasCategoria' then CrearVentana( AForm, TFLSalidasCatCal ) else
  if AOpcion = 'mnuSalLisSalidasPalet' then CrearVentana( AForm, TFListadoSalidasPaletsForm ) else
  if AOpcion = 'mnuSalResumenAlmacen' then FLSalidasResumen := TFLSalidasResumen.Create(AForm) else

  if AOpcion = 'mnuSalGrabarGastosTransportes' then CrearVentana( AForm, TFMServicioVenta ) else
  if AOpcion = 'mnuSalAsignarGastosTransportes' then CrearVentana( AForm, TFDAsignarGastosServicioVenta ) else

  if AOpcion = 'mnuSalResSalidasEnvase' then CrearVentana( AForm, TFLSalidasEnvases2 ) else

  if AOpcion = 'mnuSalInventarioEnvComer' then CrearVentana( AForm, TFMInventarioEnvComerciales ) else
  if AOpcion = 'mnuSalAjustesInventarioEnvComer' then CrearVentana( AForm, TFMAjustesEnvComerciales ) else
  if AOpcion = 'mnuSalEntradasEnvComer' then CrearVentana( AForm, TFMEntradasEnvComerciales ) else
  if AOpcion = 'mnuSalTransitosEnvComer' then CrearVentana( AForm, TFMTransitosEnvComerciales ) else
  if AOpcion = 'mnuSalListadoEnvasesComerciales' then CrearVentana( AForm, TFLSalidasEnvases ) else
  if AOpcion = 'mnuSalMovimientosEnvasesComerciales' then CrearVentana( AForm, TFLMovimientosEnvComerciales ) else
  //SIN USO
  if AOpcion = 'mnuSalFacturaLogifruit' then CrearVentana( AForm, TFLFacturaLogifruit ) else
  //CASI SIN USO DIRECCION
  if AOpcion = 'mnuSalVentasSemMercadona' then CrearVentana( AForm, TFLMercadonaVentasSemanal ) else
  //CASI SIN USO DIRECCION
  if AOpcion = 'mnuSalVentasSuministro' then CrearVentana( AForm, TFLVentasSuministro ) else
  //CASI SIN USO DIRECCION
  if AOpcion = 'mnuSalVentasBruto' then FLVentas := TFLVentas.Create(Application) else
  if AOpcion = 'mnuSalVentasSemanal' then CrearVentana( AForm, TFLVentasSem ) else

  if ( AOpcion = 'mnuSalListadoFOBSalidas' ) then CrearVentana( AForm, TFDatosExcelFOB ) else
  //DIRECCION
  if ( AOpcion = 'mnuSalFOBCliente' ) then FLventasporcliente := TFLventasporcliente.Create(Application) else
  //DIRECCION
  if ( AOpcion = 'mnuSalFOBClientes' ) then CrearVentana( AForm, TFLVentasFobCliente ) else

  //por aqui voy

  if AOpcion = 'mnuSalSemanalExpediciones' then CrearVentana( AForm, TFLExpediciones ) else
  (*0*)if AOpcion = 'mnuSalPorcentajesFederacion' then CrearVentana( AForm, TFLLEntradasFederacion ) else
  if AOpcion = 'mnuSalAsignarFederacion' then CrearVentana( AForm, TFLLAsignacionFederaciones ) else
  (*0*)if AOpcion = 'mnuSalModificacionFederacion' then CrearVentana( AForm, TFMFederacionSalidas ) else
  if AOpcion = 'mnuSalLisSalidasFederacion' then CrearVentana( AForm, TFLResumenFederaciones ) else

  if AOpcion = 'mnuSalInformeIntrastat' then CrearVentana( AForm, TFLIntrastat ) else
  if AOpcion = 'mnuSalControlIntrastat' then CrearVentana( AForm, TFLListControlIntrasat ) else

  (*0*)if AOpcion = 'mnuSalAsignarDUA' then CrearVentana( AForm, TFDAsigDua ) else
  (*0*)if AOpcion = 'mnuSalListadoMercadona' then CrearVentana( AForm, TFLSalidasSuministro )else
  if AOpcion = 'mnuSalListadoFacturasdeGastosVentas1' then CrearVentana( AForm, TFLFacturasGastosSalidas )else
  if AOpcion = 'mnuSalResumenFOB' then CrearVentana( AForm, TFLVentasLineaProductoCliente )else
  if AOpcion = 'mnuSalResumenSalidasDinamico' then CrearVentana( AForm, TFLSalidasResumenDinamico );
  if AOpcion = 'mnuSalSalidasLPR' then CrearVentana( AForm, TFSalidasLPR );

end;

end.
