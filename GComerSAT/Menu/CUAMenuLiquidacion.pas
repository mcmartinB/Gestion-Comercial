unit CUAMenuLiquidacion;

interface

uses CUAMenuUtils, CDAMenuUtils, Forms, Dialogs;

procedure EjecutarMenuLiquidacion( const AForm: TForm; const AOpcion: string );

implementation

uses
  LiqProdVendidoFD,
  LiqProdVendidoReportsFD, LiqProdLiquidacionFD, LiqLiquidacionCosFD;

procedure EjecutarMenuLiquidacion( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if AOpcion = 'mnuProcesoLiquidacion' then
    CrearVentana( AForm, TFDLiqProdVendido )
  else
  if AOpcion = 'mnuInformesLiquidacion' then
    CrearVentana( AForm, TFDLiqProdVendidoReports )
  else
  if AOpcion = 'mnuLiquidacionMensual' then
    CrearVentana( AForm, TFDLiqProdLiquidacion )
  else
  if AOpcion = 'mnuLiquidacionMensual2' then
    CrearVentana( AForm, TFDLiqLiquidacionCos );
end;

end.
