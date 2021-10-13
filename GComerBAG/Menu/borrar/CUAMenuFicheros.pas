unit CUAMenuFicheros;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms;

procedure EjecutarMenuFicheros( const AForm: TForm; const AOpcion: string );

implementation

uses
  UDMConfig, CVariables, MAduanas, MBancos, MCentros, MClientes, MEAN13Edi,
  MClientes_edi, MEmpresas, MEnvases, MFormasPago, MImpuestos,
  MMarcas, MMonedas, PaisesFM, MProductos,
  MProveedores, MProvincias, MRepresentantes, MSeccContables, MTipoGastos,
  MTipoPalets, MTipoVia, MTransportistas, MUniConsumo,
  FormatoPaletsFM, MClientesAlm, MCodigosEAN13, MAgrupacionesEnvase,
  MAgrupacionesGasto, MEnvasesComerciales, MLineasProductos,
  MFichFormasPago, MFichBancos, MFincasProveedores, LFDescuentosCliente,
  MComerciales, MProductos_, LFDatosCobroCliente;

procedure EjecutarMenuFicheros( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuFchAduanasPuertos' then
    CrearVentana( AForm, TFMAduanas )
  else
  if AOpcion = 'mnuFchAgrupacionesEnvase' then
    CrearVentana( AForm, TFMAgrupacionesEnvase )
  else
  if AOpcion = 'mnuFchAgrupacionesGasto' then
    CrearVentana( AForm, TFMAgrupacionesGasto )
  else
  if AOpcion = 'mnuFchBancosOld' then
    CrearVentana( AForm, TFMBancos )
  else
  if AOpcion = 'mnuFchBancosNew' then
    CrearVentana( AForm, TFMFichBancos )
  else
  if AOpcion = 'mnuFchCentros' then
    CrearVentana( AForm, TFMCentros )
  else
  if AOpcion = 'mnuFchClientes' then
  begin
    if DMConfig.EsLaFont then
      CrearVentana( AForm, TFMClientes )
    else
      CrearVentana( AForm, TFMClientesAlm);
  end
  else
  if AOpcion = 'mnuFchClientesLstDes' then
    CrearVentana( AForm, TFLDescuentosCliente )
  else
  if AOpcion = 'mnuFchEan13' then
    CrearVentana( AForm, TFCodigosMEAN13 )
  else
  if AOpcion = 'mnuFchClientesEDI' then
    CrearVentana( AForm, TFMClientes_edi )
  else
  if AOpcion = 'mnuFchProductoEDI' then
    CrearVentana( AForm, TFMEAN13Edi )
  else
  if AOpcion = 'mnuFchEmpresas' then
    CrearVentana( AForm, TFMEmpresas )
  else
  if AOpcion = 'mnuFchEnvases' then
    CrearVentana( AForm, TFMEnvases )
  else
  if AOpcion = 'mnuFchComerciales' then
    CrearVentana( AForm, TFMComerciales )
  else
  if AOpcion = 'mnuFchEnvasesComerciales' then
    CrearVentana( AForm, TFMEnvasesComerciales )
  else
  if AOpcion = 'mnuFchFormasPagoOld' then
    CrearVentana( AForm, TFMFormaPago )
  else
  if AOpcion = 'mnuFchFormasPagoNew' then
    CrearVentana( AForm, TFMFichFormasPago )
  else
  if AOpcion = 'mnuFchFormatosPalet' then
    CrearVentana( AForm, TFMFormatoPalets )
  else
  if AOpcion = 'mnuFchImpuestos' then
    CrearVentana( AForm, TFMImpuestos )
  else
  if AOpcion = 'mnuFchMarcas' then
    CrearVentana( AForm, TFMMarcas )
  else
  if AOpcion = 'mnuFchMonedas' then
    CrearVentana( AForm, TFMMonedas )
  else
  if AOpcion = 'mnuFchPaises' then
    CrearVentana( AForm, TFMPaises )
  else
  if AOpcion = 'mnuFchProductos' then
    CrearVentana( AForm, TFMProductos )
  else
  if AOpcion = 'mnuFchProductos_1' then
    CrearVentana( AForm, TFMProductos_ )
  else
  if AOpcion = 'mnuFchLineasProductos' then
    CrearVentana( AForm, TFMLineasProductos )
  else
  if AOpcion = 'mnuFchProveedores' then
    CrearVentana( AForm, TFMProveedores )
  else
  if AOpcion = 'mnuFchProveedoresFincas' then     
    CrearVentana( AForm, TFMFincasProveedores )
  else
  if AOpcion = 'mnuFchProvincias' then
    CrearVentana( AForm, TFMProvincias )
  else
  if AOpcion = 'mnuFchRepresentantes' then
    CrearVentana( AForm, TFMRepresentantes )
  else
  if AOpcion = 'mnuFchSeccionesContables' then
    CrearVentana( AForm, TFMSeccContables )
  else
  if AOpcion = 'mnuFchTipoGastos' then
    CrearVentana( AForm, TFMTipoGastos )
  else
  if AOpcion = 'mnuFchTipoPalets' then
    CrearVentana( AForm, TFMTipoPalets )
  else
  if AOpcion = 'mnuFchTiposVia' then
    CrearVentana( AForm, TFMTipoVia )
  else
  if AOpcion = 'mnuFchTransportistasMante' then
    CrearVentana( AForm, TFMTransportistas )
  else
  if AOpcion = 'mnuFchUnidadesConsumo' then
    CrearVentana( AForm, TFMUniConsumo )
  else
  if AOpcion = 'mnnFchClientesListadoFormaPago' then
    CrearVentana( AForm, TFLDatosCobroCliente );
end;

end.
