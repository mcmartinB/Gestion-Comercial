unit CUAMenuPedidos;

interface

uses CUAMenuUtils, CDAMenuUtils, Forms, Dialogs, UDMConfig, CVariables;

procedure EjecutarMenuPedidos( const AForm: TForm; const AOpcion: string );

implementation

uses
  ConfirmaRecepcionFL, MAccesoWeb;

procedure EjecutarMenuPedidos( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );
  if AOpcion = 'mnuPedAccesoWeb' then
    CrearVentana( AForm, TFMAccesoWeb )
  else
  if AOpcion = 'mnuPedConfirmaRecepcion' then
    CrearVentana( AForm, TFLConfirmaRecepcion );
end;

end.
