unit CUAMenuTransitos;

interface

uses CUAMenuUtils, CDAMenuUtils, Forms, Dialogs;

procedure EjecutarMenuTransitos( const AForm: TForm; const AOpcion: string );

implementation

uses
  UDMConfig, MTransitosSimple, UTransitosList_FC, DConTransitos,
  UTransitosEnvList_FC, DRecepcionTransitos, LServiciosTransporteTransitos,
  CFLFicherosAtlantis, CFLDepositosAduanas, CFLFacturasTransporteDepositos,
  FacturasGastosTransitosFL, UFCalculoPosei, UFInformePosei;

procedure EjecutarMenuTransitos( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if ( AOpcion = 'mnuTraTransitos' ) or ( AOpcion = 'btnTransitos' ) then
  begin
    CrearVentana( AForm, TFMTransitosSimple);
  end
  else
  if AOpcion = 'mnuTraLisTransitos' then
  begin
    CrearVentana( AForm, TTransitosList_FC);
  end
  else
  if AOpcion = 'mnuTraConsultaTransitos' then
    CrearVentana( AForm, TFConTransitos )
  else
  if AOpcion = 'mnuTraLisEnvasesTransitos' then
    CrearVentana( AForm, TTransitosEnvList_FC )
  else
  if AOpcion = 'mnuTraCalculoAyudaPOSEI' then
    CrearVentana( AForm, TFCalculoPosei )
  else
  if AOpcion = 'mnuTraInformeAyudaPOSEI' then
    CrearVentana( AForm, TFInformePosei )
  else
  if AOpcion = 'mnuTraRecepcionTransitos' then
    TFDRecepcionTransitos.Create( AForm ).ShowModal
  else
  if AOpcion = 'mnuTraServiciosTransportistas' then
    CrearVentana( AForm, TFLServiciosTransporteTransitos )
  else
  if AOpcion = 'mnuTraListadoDepositoAduanas' then
    CrearVentana( AForm, TFLDepositosAduanas )
  else
  if AOpcion = 'mnuTraLFacturasTransportesDeposito' then
    CrearVentana( AForm, TFLFacturasTransporteDepositos )
  else
  if AOpcion = 'mnuTraCrearFicherosAplicacionAtlantis' then
  begin
    CrearVentana( AForm, TFLFicherosAtlantis );
  end
  else
  if AOpcion = 'mnuTraListadoFacturasdeGastosTransitos' then
  begin
    CrearVentana( AForm, TFLFacturasGastosTransitos );
  end  ;
end;

end.
