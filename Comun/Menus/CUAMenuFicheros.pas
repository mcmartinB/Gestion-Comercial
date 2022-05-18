unit CUAMenuFicheros;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms;

procedure  EjecutarMenuFicheros( const AForm: TForm; const AOpcion: string );

implementation

uses
  Dialogs, CGlobal,  FormatoPaletsFM,
  UDMConfig, CVariables, MAduanas, MBancos, MCentros, MClientes, MEAN13_old, MEAN13Edi,
  MClientes_edi, MCosecheros, MEmpresas, MEnvases, MFederaciones, MFormasPago, MImpuestos,
  MMarcas, MMonedas, PaisesFM, MPesos, MPlantaciones, MProductos,
  MProveedores, MProvincias, MRepresentantes, MSeccContables, MTipoGastos,
  MTipoPalets, MTipoVia, MTransportistas, MUniConsumo,   MClientesAlm, MEan13,
  MAgrupacionesEnvase, LFDescuentosCliente, LFDatosCobroCliente, MTiposCaja,
  MEnvasesComerciales,  MAgrupacionesComerciales,  MClienteTipos, MComerciales, MCodigosEAN13,
  MAgrupacionesGasto, MLineasProductos, MTipoCostes, MAccesoWeb, MFlota;
                          
procedure EjecutarMenuFicheros( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuFchAduanasPuertos' then
    CrearVentana( AForm, TFMAduanas )
  else
  if AOpcion = 'mnuFchAgrupacionesEnvase' then
    CrearVentana( AForm, TFMAgrupacionesEnvase )
  else
  if AOpcion = 'mnuFchAgrupacionesComerciales' then
    CrearVentana( AForm, TFMAgrupacionesComerciales )
  else
  if AOpcion = 'mnuFchTiposdeCaja' then
    CrearVentana( AForm, TFMTiposCaja )
  else
  if AOpcion = 'mnuFchBancos' then
  begin
//    if DMConfig.EsLaFont then
//      CrearVentana( AForm, TFMAccesoWeb )
//    else
      CrearVentana( AForm, TFMBancos );
  end
  else
  if AOpcion = 'mnuFchCentros' then
    CrearVentana( AForm, TFMCentros )
  else
  if ( AOpcion = 'mnuFchClientes' ) then
  begin
    if DMConfig.EsLaFont then
      CrearVentana( AForm, TFMClientes )
    else
      CrearVentana( AForm, TFMClientesAlm);
  end
  else
  if ( AOpcion = 'mnuFchListadoComisiones' ) then
    CrearVentana( AForm, TFLDescuentosCliente )
  else
  if ( AOpcion = 'mnuFchListadoDatosCobroCliente' ) then
    CrearVentana( AForm, TFLDatosCobroCliente)
  else
  if AOpcion = 'mnuFchEan13' then
  begin
    if CGlobal.gProgramVersion = pvSAT then
      CrearVentana( AForm, TFMEan13_old )
    else
      CrearVentana( AForm, TFCodigosMEAN13 )
  end
  else
  if AOpcion = 'mnuFchClientesEDI' then
    CrearVentana( AForm, TFMClientes_edi )
//  else
//  if AOpcion = 'mnuFchProductoEDI' then
//    CrearVentana( AForm, TFMEAN13Edi )
  else
  if AOpcion = 'mnuFchComerciales' then
    CrearVentana( AForm, TFMComerciales )
  else
  if AOpcion = 'mnuFchCosecheros' then
    CrearVentana( AForm, TFMCosecheros )
  else
  if AOpcion = 'mnuFchEmpresas' then
    CrearVentana( AForm, TFMEmpresas )
  else
  if AOpcion = 'mnuFchEnvases' then
    CrearVentana( AForm, TFMEnvases )
  else
  if AOpcion = 'mnuFchEnvasesComerciales' then
    CrearVentana( AForm, TFMEnvasesComerciales )
  else
  if AOpcion = 'mnuFchFederaciones' then
    CrearVentana( AForm, TFMFederaciones )
  else
  if AOpcion = 'mnuFchFlotaCamiones' then
    CrearVentana( AForm, TFMFlota )
  else
  if AOpcion = 'mnuFchFormasPago' then
  begin
//    if DMConfig.EsLaFont then
//      CrearVentana( AForm, TFMAccesoWeb )
//    else
      CrearVentana( AForm, TFMFormaPago );
  end
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
  begin
//    if DMConfig.EsLaFont then
//      CrearVentana( AForm, TFMAccesoWeb )
//    else
      CrearVentana( AForm, TFMPaises );
  end
  else
  if AOpcion = 'mnuFchPesosCentro' then
    CrearVentana( AForm, TFMPesos )
  else
  if AOpcion = 'mnuFchPlantaciones' then
  begin
    CrearVentana( AForm, TFMPlantaciones);
  end
  else
  if AOpcion = 'mnuFchProductos' then
    CrearVentana( AForm, TFMProductos )
  else
  if AOpcion = 'mnuFchProveedores' then
    CrearVentana( AForm, TFMProveedores )
  else
  if AOpcion = 'mnuTipoCostes' then
    CrearVentana( AForm, TFMTipoCostes )
  else
  if AOpcion = 'mnuFchProvincias' then
  begin
//    if DMConfig.EsLaFont then
//      CrearVentana( AForm, TFMAccesoWeb )
//    else
      CrearVentana( AForm, TFMProvincias );
  end
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
  if ( AOpcion = 'mnuFchTipoCliente' ) then
    CrearVentana( AForm, TFMClienteTipos )
  else
  if AOpcion = 'mnuFchUnidadesConsumo' then
    CrearVentana( AForm, TFMUniConsumo )
  else
  if AOpcion = 'mnuFchAgrupacionesGasto' then
    CrearVentana( AForm, TFMAgrupacionesGasto )
  else
  if AOpcion = 'mnuFchFormatosPalet' then
    CrearVentana( AForm, TFMFormatoPalets );
end;

end.
