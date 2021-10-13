unit CUAMenuTransmision;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms, Dialogs, DBTables, UDMAuxDB;

procedure EjecutarMenuTransmision( const AForm: TForm; const AOpcion: string );

implementation

uses
  SincroDiarioFP, SincroVarUNT, SincroMensualFP, ControlEnvioAlbaranesFR;

procedure EjecutarMenuTransmision( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuDatSalidas' then
    SincroDiarioFP.CrearVentana( AForm,  kSSalidas )
  else
  if AOpcion = 'mnuDatTransitos' then
    SincroDiarioFP.CrearVentana( AForm,  kSTransitos )
  else
  if AOpcion = 'mnuDatPedidos' then
  begin
    SincroDiarioFP.CrearVentana( AForm, kSPedidos )
  end
  else
  if AOpcion = 'mnuDatCosteEnvase' then
    SincroMensualFP.CrearVentana( AForm, kSCostesEnvase )
  else
  if AOpcion = 'mnuDatControlEnviodeAlbaranes' then
    CUAMenuUtils.CrearVentana( AForm, TFRControlEnvioAlbaranes )
  else
  if AOpcion = 'mnuDatDiarioDesgloseSal' then
    SincroDiarioFP.CrearVentana( AForm,  kSincroDesgloseSal );

end;

end.
