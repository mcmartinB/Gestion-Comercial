unit CUAMenuMaquila;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms;

procedure EjecutarMenuFicheros( const AForm: TForm; const AOpcion: string );

implementation

uses
  UDMConfig, CVariables, UAsignacionFrutaFM, UInstruccionCargaFM;

procedure EjecutarMenuFicheros( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuMaqAsigancion' then
    CrearVentana( AForm, TFMAsignacionFruta )
  else
  if AOpcion = 'mnuMaqInstruccionCarga' then
    CrearVentana( AForm, TFMInstruccionCarga );
end;

end.
