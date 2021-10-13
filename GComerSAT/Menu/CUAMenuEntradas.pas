unit CUAMenuEntradas;

interface

uses
  MEntradasFrutaEx, CUAMenuUtils, CDAMenuUtils, Forms, Dialogs, AprovechaResumen;

var
  formEntradasFrutaEx: TFMEntradasFrutaEx;

procedure EjecutarMenuEntradas( const AForm: TForm; const AOpcion: string );

implementation

uses
  UDMConfig, LInformeEntradas, LEntregasCosechero, LFResumenTransporte,
  LEntregas, LProductividadProductos, MEscandallo,
  AprovechaVerifica, MResumenEntradasOPP, UEntradaDatos,
  DetalleEntradasFL, AprovechaDiario;

procedure EjecutarMenuEntradas( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );

  if ( AOpcion = 'mnuEntEntradas' ) or ( AOpcion = 'btnEntradas' ) then
    formEntradasFrutaEx := TFMEntradasFrutaEx.Create(Application)
  else
  if AOpcion = 'mnuEntLstEntradasCosecheros' then
    CrearVentana( AForm, TFLInformeEntradas )
  else
  if AOpcion = 'mnuEntResEntradasCosecheros' then
  begin
      CrearVentana( AForm, TFLEntregasCosechero);
  end
  else
  if AOpcion = 'mnuEntResEntradasTransportistas' then
    CrearVentana( AForm, TFLResumenTransporte )
  else
  if AOpcion = 'mnuEntEntradasRecoleccion' then
  begin
    CrearVentana( AForm, TFLEntregas);
  end
  else
  if AOpcion = 'mnuEntResProductividad' then
      CrearVentana( AForm, TFLProductividadProductos)
  else
  if AOpcion = 'mnuEntTransferirSGP' then
    TFEntradaDatos.Create( AForm).ShowModal
  else
  if AOpcion = 'mnuEntEscandallos' then
    CrearVentana( AForm, TFMEscandallo)
  else
  if AOpcion = 'mnuEntListEscandallos' then
  begin
    CrearVentana( AForm, TFAprovechaDiario);
  end
  else
  if AOpcion = 'mnuEntVerificarEscandallos' then
    CrearVentana( AForm, TFAprovechaVerifica)
  else
  if AOpcion = 'mnuEntDetalleEntradas' then
    CrearVentana( AForm, TFLDetalleEntradas );

end;

end.
