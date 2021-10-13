unit CUAMenuUtiles;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms, Dialogs;

procedure EjecutarMenuUtiles( const AForm: TForm; const AOpcion: string );

implementation

uses
  MCambioMonedas, LFComprobacionGastos, DSeleccionImpresoras, DCuentasCorreo,
  dlgAcercaDe, SuperUserUtilsFP, MSincronizacionWeb;

procedure EjecutarMenuUtiles( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

(*
  if AOpcion = 'mnuUtiCalculadora' then
    CrearVentana( AForm, TFM... )
  else
*)
  if AOpcion = 'mnuUtiCambioDivisas' then
      CrearVentana( AForm, TFMCambioMonedas)
  else
(*
  if AOpcion = 'mnuUtiConversionDivisa' then
    CrearVentana( AForm, TFM... )
  else
  if AOpcion = 'mnuUtiEuroConversor' then
    CrearVentana( AForm, TFM... )
  else
*)
  if AOpcion = 'mnuUtiCompruebaGastos' then
    CrearVentana( AForm, TFLComprobacionGastos)
  else
  if AOpcion = 'mnuUtiSelectImpresoras' then
      CrearVentana( AForm, TFDSeleccionImpresoras)
  else
  if AOpcion = 'mnuUtiSelectCuentaCorreo' then
    CrearVentana( AForm, TFDCuentasCorreo)
  else
  if AOpcion = 'mnuUtiAdministracion' then
    SuperUserUtilsFP.UtilidadesAdministrador( Application )
  else
  if AOpcion = 'mnuUtiAcercaDe' then
      TDAcercaDe.Create( AForm ).ShowModal
  else
  if AOpcion = 'mnuUtiAux' then
    ShowMessage('Sin implementar.')
      //TFActualizarEnvioEntregas.Create( Aform ).ShowModal;
      //TFLPreciosFOBVenta.Create( Aform ).ShowModal;
  (*
  else
  if AOpcion = 'mnuUtiPlantillaReportes' then
    CrearVentana( AForm, TFPlantillaReporte);
  *)
  else
  if AOpcion = 'mnuSincronizacion' then
    CrearVentana( AForm, TFMSincronizacionWeb)
end;


end.
