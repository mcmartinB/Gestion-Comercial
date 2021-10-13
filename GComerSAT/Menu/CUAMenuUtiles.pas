unit CUAMenuUtiles;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms, Dialogs;

procedure EjecutarMenuUtiles( const AForm: TForm; const AOpcion: string );

implementation

uses
  MCambioMonedas, LFComprobacionGastos, DSeleccionImpresoras, DCuentasCorreo,
  dlgAcercaDe,  SuperUserUtilsFP, UFKilosComercializadosMes, MSincronizacionWeb;

procedure EjecutarMenuUtiles( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuUtiCambioDivisas' then
      CrearVentana( AForm, TFMCambioMonedas)
  else
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
  if AOpcion = 'mnuUtiKilosComercializadosMes' then
     UFKilosComercializadosMes.ShowKilosComercializadosMes( AForm  )
  else
  if AOpcion = 'mnuUtiAux' then
    ShowMessage('Sin implementar.')
  else
  if AOpcion = 'mnuSincronizacion' then
    CrearVentana( AForm, TFMSincronizacionWeb)
end;


end.
