unit CUAMenuFacturacion;

interface

uses
  CUAMenuUtils, CDAMenuUtils, Forms, Dialogs;

procedure EjecutarMenuFacturacion( const AForm: TForm; const AOpcion: string );

implementation

uses
  UFProformaFac, UFProcFacturacion, UFManFacturas, UFRepFacturacion, UFRepFacturacionCont,
  UFFacturarEdi, UFContFacturas, UFMarcaContable, UFAnuFacturas, UFManRemesas,
  ListadoFacturasFD,
  LFFacturasCliente, LFFactSuministro, LFAlbaranesSinFacturar,
  ListProductoSinFacturarFL, CFLFacturasPendientes, LResumenRemesas,
  LRemesasBanco, RiesgoClienteFL, ExtractoCobroFL,
  AbonoDetallesFL, DiasCobroFL, FacturasParaAnticipar,
  AgingFL, LFNotificacionCredito, AlbaranesFacturadosEn,
  DAlbaranesFactura, VentasPeriodoFD, EstadoCobroClientesFL,
  FacturasSinContabilizarFD, UFImprimirFactura;
  //BACKUP
  //LFFacResumenCliente,

  //dbgrid solo las saliads

procedure EjecutarMenuFacturacion( const AForm: TForm; const AOpcion: string );
begin
  CDAMenuUtils.MenuLog( AOpcion );
  (*
  if AOpcion = 'mnuFacRepeticionFacturas' then
    FLRepticionFacturas := TFLRepticionFacturas.Create( AForm )
  else
*)
  if AOpcion = 'mnuManFacturas' then
//    FManFacturas := TFManFacturas.Create( AForm )
    CrearVentana( AForm, TFManFacturas )
  else
  if AOpcion = 'mnuProcFacturacion' then
    UFProcFacturacion.FProcFacturacion := TFProcFacturacion.Create( AForm )
  else
  if AOpcion = 'mnuProformaFac' then
    FProformaFac := TFProformaFac.Create( AForm )
  else
  if AOpcion = 'mnuRepFacturacion' then
    FRepFacturacion := TFRepFacturacion.Create(AForm)
  else
  if AOpcion = 'mnuRepFacturacionCont' then
    FRepFacturacionCont := TFRepFacturacionCont.Create(AForm)
  else
  if AOpcion = 'mnuFacturarEdi' then
    FFacturarEdi := TFFacturarEdi.Create(AForm)
  else
  if AOpcion = 'mnuContFacturas' then
    FContFacturas := TFContFacturas.Create(AForm)
  else
  if AOpcion = 'mnuMarcaContable' then
    FMarcaContable := TFMarcaContable.Create(AForm)
  else
  if AOpcion = 'mnuAnuFacturas' then
    FAnuFacturas := TFAnuFacturas.Create(AForm)
  else
  if AOpcion = 'mnuManRemesas' then
    FManRemesas := TFManRemesas.Create(AForm)
  else
  if AOpcion = 'mnuFacLisFacturas' then
    CrearVentana( AForm, TFDListadoFacturas )
  else
  if AOpcion = 'mnuFacLisAbonosDetalle' then
    CrearVentana( AForm, TFLAbonoDetalles )
  else
  if AOpcion = 'mnuFacFacturasCliente' then
    CrearVentana( AForm, TFLFacturasCliente )
  else
  if AOpcion = 'mnuFacFacturasSuministro' then
    CrearVentana( AForm, TFLFactSuministro )
  else
  if AOpcion = 'mnuFacAlbaranesSinFacturar' then
    CrearVentana( AForm, TFLAlbaranesSinFacturar )
  else
  if AOpcion = 'mnuFacProductoSinFacturar' then
    CrearVentana( AForm, TFLListProductoSinFacturar )
  else
  if AOpcion = 'mnuFacFacturasSinCobrar' then
    CrearVentana( AForm, TDFLFacturasPendientes )
  else
  if AOpcion = 'mnuFacListadoRemesas' then
    CrearVentana( AForm, TFLResumenRemesas )
  else
  if AOpcion = 'mnuFacListadoResemasBanco' then
    CrearVentana( AForm, TFLRemesasBanco )
  else
  if AOpcion = 'mnuFacRiesgoCliente' then
    CrearVentana( AForm, TFLRiesgoCliente )
  else
  if AOpcion = 'mnuFacEstadoCobroCliente' then
    CrearVentana( AForm, TFLExtractoCobro )
  else
  if AOpcion = 'mnuFacAging' then
    CrearVentana( AForm, TFLAging )
  else
  if AOpcion = 'mnuFacListadoRemesasGiro' then
    ShowMessage('En desarrollo')
  else
  if AOpcion = 'mnuFacNotificacionCredito' then
    CrearVentana( AForm, TFLNotificacionCredito )
  else
  if AOpcion = 'mnuFacAlbaranesFacturadosEn' then
    CrearVentana( AForm, TFAlbaranesFacturadosEn )
  else
  if AOpcion = 'mnuFacParaAnticipar' then
    CrearVentana( AForm, TFFacturasParaAnticipar )
  else
  if AOpcion = 'mnuFacAlbaranesFactura' then
    CrearVentana( AForm, TFDAlbaranesFactura )
  else
  if AOpcion = 'mnuFacDiasMediosPagoClientes' then
    CrearVentana( AForm, TFLDiasCobro )
  else
  if AOpcion = 'mnuFacListadoVentasPeriodo' then
    CrearVentana( AForm, TFDVentasPeriodo )
  else
  if AOpcion = 'mnuFacSaldoPendienteCobro' then
    CrearVentana( AForm, TFLEstadoCobroClientes )
  else
  if AOpcion = 'mnuFacSinContablizarX3' then
    CrearVentana( AForm, TFDFacturasSinContabilizar )
  else
  if AOpcion = 'mnuImprimirFactura' then
    CrearVentana( AForm, TFImprimirFactura );

end;

end.
