unit CUAMenuPedidos;

interface

uses CUAMenuUtils, CDAMenuUtils, Forms, Dialogs, UDMConfig, CVariables;

procedure EjecutarMenuPedidos( const AForm: TForm; const AOpcion: string );

implementation

uses
  PedidosFM, PedidosSinAsignarFL, PedidosFL, PedidosEnvaseFL,
  PedidosSalidasFL, ConfirmaRecepcionFL, RecadvFL, PedidosResumenFL,
  FMPedidosFormato, ListPackingOrdenFL, AlbaranAPedidoFL, RecadvFM, MAccesoWeb;

procedure EjecutarMenuPedidos( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuPedPedidosFormato' then
      CrearVentana( AForm, TFMAccesoWeb )
  else
  if AOpcion = 'mnuPedPedidosEnvase' then
     CrearVentana( AForm, TFMPedidos)
  else
  if AOpcion = 'mnuPedAlbaranAPedido' then
    CrearVentana( AForm, TFLAlbaranAPedido )
  else
  if AOpcion = 'mnuPedResPedidos' then
    CrearVentana( AForm, TFLPedidosResumen )
  else
  if AOpcion = 'mnuPedPedidosSinSalidas' then
  begin
    PedidosSinAsignarFL.iTipo:= 0;
    CrearVentana( AForm, TFLPedidosSinAsignar );
  end
  else
  if AOpcion = 'mnuPedSalidasSinPedidos' then
  begin
    PedidosSinAsignarFL.iTipo:= 1;
    CrearVentana( AForm, TFLPedidosSinAsignar );
  end
  else
  if AOpcion = 'mnuPedResumenPedido' then
    CrearVentana( AForm, TFLPedidosEnvase )
  else
  if AOpcion = 'mnuPedDesglosePedido' then
    CrearVentana( AForm, TFLPedidosSalidas )
  else
  if AOpcion = 'mnuPedConfirmaRecepcion' then
    CrearVentana( AForm, TFLConfirmaRecepcion )
  else
  if AOpcion = 'mnuPedPackingOrdenCarga' then
    CrearVentana( AForm, TFLListPackingOrden )
  else
  if AOpcion = 'mnuPedRECADV' then
  begin
    //CrearVentana( AForm, TFLRecadv );
    CrearVentana( AForm, TFMRecadv );
  end;
end;

end.
