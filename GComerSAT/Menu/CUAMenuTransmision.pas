unit CUAMenuTransmision;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms, Dialogs;

procedure EjecutarMenuTransmision( const AForm: TForm; const AOpcion: string );

implementation

uses
  SincroDiarioFP, SincroVarUNT, SincroTodoDiarioFP, SincroMensualFP,
  CFPEnviarGastosEntregas;

procedure EjecutarMenuTransmision( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuDatDiarioTodo' then
  begin
    CUAMenuUtils.CrearVentana( AForm, TFPSincroTodoDiario )
  end
  else
  if AOpcion = 'mnuDatDiarioEntradas' then
    SincroDiarioFP.CrearVentana( AForm,  kSincroEntradas )
  else
  if ( AOpcion = 'mnuDatDiarioEscandallos' ) or ( AOpcion = 'mnuDatSemanalEscandallo' )then
    SincroDiarioFP.CrearVentana( AForm,  kSincroEscandallos )
  else
  if AOpcion = 'mnuDatDiarioInventarios' then
    SincroDiarioFP.CrearVentana( AForm,  kSincroInventarios )
  else
  if AOpcion = 'mnuDatDiarioSalidas' then
    SincroDiarioFP.CrearVentana( AForm,  kSincroSalidas )
  else
  if AOpcion = 'mnuDatDiarioTransitos' then
    SincroDiarioFP.CrearVentana( AForm,  kSincroTransitos )
  else
  if AOpcion = 'mnuDatDiarioDesgloseSal' then
    SincroDiarioFP.CrearVentana( AForm,  kSincroDesgloseSal )
  else
  if AOpcion = 'mnuDatMensualCosteEnvase' then
    SincroMensualFP.CrearVentana( AForm, kSincroCosteEnvase )
  else
  if AOpcion = 'mnuDatMensualSobrepesos' then
    SincroMensualFP.CrearVentana( AForm, kSincroSobrepesos )
  else
  if AOpcion = 'mnuDatOtrosPedidos' then
    SincroDiarioFP.CrearVentana( AForm, kSincroPedidos )
  else
  if AOpcion = 'mnuDatOtrosEntregas' then
    SincroDiarioFP.CrearVentana( AForm,  kSincroEntregas )
  else
  if AOpcion = 'mnuDatOtrosEntregasGastos' then
    CUAMenuUtils.CrearVentana( AForm, TFPEnviarGastosEntregas );
end;

end.
