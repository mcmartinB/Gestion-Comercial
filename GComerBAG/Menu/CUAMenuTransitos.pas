unit CUAMenuTransitos;

interface

uses CUAMenuUtils, CDAMenuUtils, Forms, Dialogs;

procedure EjecutarMenuTransitos( const AForm: TForm; const AOpcion: string );

implementation

uses
  UDMConfig, MTransitosSimple, UTransitosEnvList_FC,
  DRecepcionTransitos, FacturasGastosTransitosFL,
  LServiciosTransporteTransitos;

procedure EjecutarMenuTransitos( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if ( AOpcion = 'mnuTraTransitos' ) or ( AOpcion = 'btnTransitos' ) then
    CrearVentana( AForm, TFMTransitosSimple)
  else
  if AOpcion = 'mnuTraLisEnvasesTransitos' then
    CrearVentana( AForm, TTransitosEnvList_FC )
  else
  if AOpcion = 'mnuTraRecepcionTransitos' then
    TFDRecepcionTransitos.Create( AForm ).ShowModal
  else
  if AOpcion = 'mnuTraServiciosTransportistas' then
    CrearVentana( AForm, TFLServiciosTransporteTransitos)
  else
  if AOpcion = 'mnuTraLisFacGasTransitos' then
    CrearVentana( AForm, TFLFacturasGastosTransitos);
end;

end.
