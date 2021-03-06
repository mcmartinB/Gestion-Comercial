unit Principal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  ExtCtrls, ToolWin, ComCtrls, ActnList, StdCtrls, Buttons;


type
  TFPrincipal = class(TForm)
    // =============================  VARIABLES  ==============================

    // -------------------------  CONTROL DE BARRAS  --------------------------
    CBControlBarras: TControlBar;

    // ---------------------------  BARRA MAESTRO  ----------------------------
    TBBarraMaestro: TToolBar;
    TBMaestroPrimero: TToolButton;
    TBMaestroAnterior: TToolButton;
    TBMaestroSiguiente: TToolButton;
    TBMaestroUltimo: TToolButton;
    TBMaestroSeparador1: TToolButton;
    TBMaestroLocalizar: TToolButton;
    TBMaestroModificar: TToolButton;
    TBMaestroBorrar: TToolButton;
    TBMaestroAltas: TToolButton;
    TBMaestroSeparador2: TToolButton;        
    TBMaestroAceptar: TToolButton;
    TBMaestroCancelar: TToolButton;
    TBMaestroSeparador3: TToolButton;

    // -----------------------  BARRA MAESTRO/DETALLE  ------------------------
    TBBarraMaestroDetalle: TToolBar;
    TBMaestroDetallePrimero: TToolButton;
    TBMaestroDetalleAnterior: TToolButton;
    TBMaestroDetalleSiguiente: TToolButton;
    TBMaestroDetalleUltimo: TToolButton;
    TBMaestroDetalleSeparador1: TToolButton;
    TBMaestroDetalleArriba: TToolButton;
    TBMaestroDetalleAbajo: TToolButton;
    TBMaestroDetalleSeparador2: TToolButton;
    TBMaestroDetalleLocalizarMaestro: TToolButton;
    TBMaestroDetalleModificarMaestro: TToolButton;
    TBMaestroDetalleBorrarMaestro: TToolButton;
    TBMaestroDetalleAltasMaestro: TToolButton;
    TBMaestroDetalleSeparador3: TToolButton;
    TBMaestroDetalleModificarDetalle: TToolButton;
    TBMaestroDetalleBorrarDetalle: TToolButton;
    TBMaestroDetalleAltasDetalle: TToolButton;
    TBMaestroDetalleSeparador4: TToolButton;
    TBMaestroDetalleAceptar: TToolButton;
    TBMaestroDetalleCancelar: TToolButton;
    TBMaestroDetalleSeparador5: TToolButton;
    MenuPrincipal: TMainMenu;
    TBMaestroSalir: TToolButton;
    TBMaestroDetalleSalir: TToolButton;
    AAcciones: TActionList;
    AMPrimero: TAction;
    AMSiguiente: TAction;
    AMAnterior: TAction;
    AMUltimo: TAction;
    ADAnterior: TAction;
    ADSiguiente: TAction;
    ADAltas: TAction;
    ADModificar: TAction;
    ADBorrar: TAction;
    AMAltas: TAction;
    AMBorrar: TAction;
    AMModificar: TAction;
    AMLocalizar: TAction;
    AMDCancelar: TAction;
    AMDAceptar: TAction;
    ACerrar: TAction;
    AIPrevisualizar: TAction;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    mnuFicheros: TMenuItem;
    mnuFchEmpresas: TMenuItem;
    AMDSalir: TAction;
    mnuFchTiposVia: TMenuItem;
    mnuFchProductos: TMenuItem;
    mnuFchTransportistasMante: TMenuItem;
    mnuAlmacen: TMenuItem;
    mnuSalidas: TMenuItem;
    mnuFacturacion: TMenuItem;
    Salir1: TMenuItem;
    mnuUtilidades: TMenuItem;
    mnuUtiCalculadora: TMenuItem;
    mnuFchBancos: TMenuItem;
    mnuFchCentros: TMenuItem;
    mnuFchClientes: TMenuItem;
    mnuFchEnvases: TMenuItem;
    mnuFchMarcas: TMenuItem;
    mnuFchMonedas: TMenuItem;
    mnuFchPaises: TMenuItem;
    mnuFchProvincias: TMenuItem;
    mnuFchRepresentantes: TMenuItem;
    mnuSalSalidas: TMenuItem;
    mnuUtiSelectImpresoras: TMenuItem;
    mnuUtiAdministracion: TMenuItem;
    mnuUtiAcercaDe: TMenuItem;
    Reloj: TTimer;
    mnuFchImpuestos: TMenuItem;
    mnuSalLisSalidasProductos: TMenuItem;
    mnuFacEstadoCobroCliente: TMenuItem;
    mnuFchTipoPalets: TMenuItem;
    mnuFchTipoGastos: TMenuItem;
    mnuSalVentasBruto: TMenuItem;
    mnuFchClientesEDI: TMenuItem;
    mnuTraTransitos: TMenuItem;
    mnuSalSepFOB: TMenuItem;
    mnuUtiCambioDivisas: TMenuItem;
    mnuSalSemanalExpediciones: TMenuItem;
    mnuFchSeccionesContables: TMenuItem;
    mnuSalCuentaVentasFacturadas: TMenuItem;
    mnuSalAsignarDUA: TMenuItem;
    mnuSalSepDUA: TMenuItem;
    mnuSalVentasPais: TMenuItem;
    mnuFacListadoResemasBanco: TMenuItem;
    mnuFacLisFacturas: TMenuItem;
    mnuSalFOBCliente: TMenuItem;
    mnuSalListadoEnvasesComerciales: TMenuItem;
    mnuSalCuentaVentasSinFacturar: TMenuItem;
    mnuSalResSalidasEnvase: TMenuItem;
    mnuSalSepSalidasPlus: TMenuItem;
    mnuSalLisSalidasClientes: TMenuItem;
    mnuTransitos: TMenuItem;
    mnuUtiConversionDivisa: TMenuItem;
    mnuUtiEuroConversor: TMenuItem;
    mnuFacFacturasCliente: TMenuItem;
    mnuSalVentasSemanal: TMenuItem;
    mnuSalVentasMensuales: TMenuItem;
    mnuFacFacturasSuministro: TMenuItem;
    mnuFchUnidadesConsumo: TMenuItem;
    mnuAlmSeccionesCosechero: TMenuItem;
    mnuAlmVerificarCosteEnvases: TMenuItem;
    mnuAlmLstCosteEnvase: TMenuItem;
    mnuFacListadoRemesas: TMenuItem;
    mnuSalFOBEnvases: TMenuItem;
    mnuSalVentasSemEnvases: TMenuItem;
    mnuSalVentasSemMercadona: TMenuItem;
    mnuFacAlbaranesSinFacturar: TMenuItem;
    mnuEntSepCompas: TMenuItem;
    mnuFchProveedores: TMenuItem;
    mnuEntEntregas: TMenuItem;
    mnuAlmTipoSecciones: TMenuItem;
    mnuAlmCostesEnvase: TMenuItem;
    mnuAlmSepCostesSecciones: TMenuItem;
    mnuAlmCosteSecciones: TMenuItem;
    mnuSalFacturasAlbaran: TMenuItem;
    mnuEntLstEntregas: TMenuItem;
    mnuFacSepRemesas: TMenuItem;
    mnuFacRiesgoCliente: TMenuItem;
    mnuEntSepFacturasCompras: TMenuItem;
    mnuFacProductoSinFacturar: TMenuItem;
    PEstado: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SBBarraEstado: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton7: TToolButton;
    ToolButton5: TToolButton;
    barAplicaciones: TToolBar;
    btnEntregas: TToolButton;
    btnSalidas: TToolButton;
    btnTransitos: TToolButton;
    ToolButton10: TToolButton;
    mnuPedSepPedidos: TMenuItem;
    mnuDatSalidas: TMenuItem;
    mnuDatTransitos: TMenuItem;
    mnuDatSepInicial: TMenuItem;
    mnuUtiSelectCuentaCorreo: TMenuItem;
    mnuUtiCompruebaGastos: TMenuItem;
    mnuSalComparativaVentas: TMenuItem;
    mnuTraLisEnvasesTransitos: TMenuItem;
    mnuSalFOBCalibres: TMenuItem;
    mnuEntResEntregas: TMenuItem;
    mnuSalServiciosTransporteImporte: TMenuItem;
    mnuFchAduanasPuertos: TMenuItem;
    mnuFchSep: TMenuItem;
    mnuPedidos: TMenuItem;
    mnuAlmSepCosteEnvase: TMenuItem;
    mnuUtiSepUtilidades: TMenuItem;
    mnuFacSepFacturas: TMenuItem;
    mnuFacSepFacturasPlus: TMenuItem;
    mnuTraSepTransistos: TMenuItem;
    mnuSalSepSalidas: TMenuItem;
    mnuFchEan13: TMenuItem;
    mnuFchFormatosPalet: TMenuItem;
    mnuComprasProveedor: TMenuItem;
    mnuEntLstGastosEntregas: TMenuItem;
    mnuEntLstControlEntregas: TMenuItem;
    mnuEntSepStockAlmacen: TMenuItem;
    mnuEntPendientesDescarga: TMenuItem;
    mnuEntStockActualProveedor: TMenuItem;
    mnuEntValorFrutaPlantaProveedor: TMenuItem;
    mnuEntPaletsProveedorVolcados: TMenuItem;
    mnuStockFrutaConfeccionadaFormatos: TMenuItem;
    mnuEntPaletsConfeccionados: TMenuItem;
    mnuDatosTransmision: TMenuItem;
    mnuTraSepRecepcionTransitos: TMenuItem;
    mnuTraRecepcionTransitos: TMenuItem;
    mnuDatSepVisible: TMenuItem;
    mnuDatCosteEnvase: TMenuItem;
    mnuFacLisAbonosDetalle: TMenuItem;
    mnuFacFacturasSinCobrar: TMenuItem;
    mnuSalLisSalidasPalet: TMenuItem;
    ACalculadora: TAction;
    AConversionDivisas: TAction;
    AEuroConversor: TAction;
    mnuEntResumenCosteProductoBonde: TMenuItem;
    mnuEntLstControlGastosEntregas: TMenuItem;
    mnuUtiAux: TMenuItem;
    mnuEntSepRecepcion: TMenuItem;
    mnuEntResPesosEntregas: TMenuItem;
    mnuDatPedidos: TMenuItem;
    mnuEntRecibirEntregas: TMenuItem;
    mnuEntSepLiquidacion: TMenuItem;
    mnuEntLiquidacionEntrega: TMenuItem;
    mnuEntDifKilosComerRF: TMenuItem;
    mnuSalPromedioVentasProduccion: TMenuItem;
    mnuSalSalidasFactura: TMenuItem;
    mnuEntLstFacturasProveedorNew: TMenuItem;
    mnuEntEntregasSinFacturar: TMenuItem;
    mnuEntSepComprasEntregas: TMenuItem;
    mnuEntResumenCosteProveedor: TMenuItem;
    mnuEntResumenCosteProducto: TMenuItem;
    mnuEntResumenCosteProveedorBonde: TMenuItem;
    mnuAlmFichaSecciones: TMenuItem;
    mnuTraServiciosTransportistas: TMenuItem;
    mnuEntServiciosTransportes: TMenuItem;
    mnuSalListadoMercadona: TMenuItem;
    mnuPedPedidosFormato: TMenuItem;
    mnuSalVentasSuministro: TMenuItem;
    mnuSalSepParaMercadona: TMenuItem;
    mnuStockFrutaConfeccionadaEnvases: TMenuItem;
    mnuEntDifFechasComerRF: TMenuItem;
    mnuSalLisSalidasCategoriaCalibre: TMenuItem;
    mnuEntBeneficioProducto: TMenuItem;
    mnuEntComprasProductoProveedor: TMenuItem;
    mnuEntControlIntrastat: TMenuItem;
    mnuEntIntrasat: TMenuItem;
    mnuEntSepIntrastat: TMenuItem;
    mnuAlmSepLiquidarPlatano: TMenuItem;
    mnuEntListadoDestrioFrutaRF: TMenuItem;
    mnuAlmSepPreciosDiarios: TMenuItem;
    mnuAlmPreciosDiariosrEnvases: TMenuItem;
    mnuEntMargenPeriodo: TMenuItem;
    mnuEntFacturasPlatano: TMenuItem;
    mnuFchAgrupacionesEnvase: TMenuItem;
    mnuFchAgrupacionesGasto: TMenuItem;
    mnuEntCuadreSemanalRFAlmacen: TMenuItem;
    mnuEntMargenSemanal: TMenuItem;
    mnuFchEnvasesComerciales: TMenuItem;
    EnvasesComercialesRetornables1: TMenuItem;
    mnuSalInventarioEnvComer: TMenuItem;
    mnuSalAjustesInventarioEnvComer: TMenuItem;
    mnuSalEntradasEnvComer: TMenuItem;
    mnuSalMovimientosEnvasesComerciales: TMenuItem;
    mnuSalTransitosEnvComer: TMenuItem;
    mnuSalFacturaLogifruit: TMenuItem;
    mnuSalSepEnvasesComerciales: TMenuItem;
    mnuEntValorarStockProveedor: TMenuItem;
    mnuEntValorarStockConfeccionado: TMenuItem;
    mnuFchFormasPago: TMenuItem;
    mnuEntPrevisionCostesProducto: TMenuItem;
    mnuFacAging: TMenuItem;
    mnuAlmCostesEstadisticosdeEnvasadoKg: TMenuItem;
    mnuAlmTablaAnualCosteKgEnvasado: TMenuItem;
    mnuSalServiciosTransporteTransporte: TMenuItem;
    mnuFchProveedoresFincas: TMenuItem;
    mnuTipoCostes: TMenuItem;
    mnuTablaDinamicaSalidas: TMenuItem;
    mnuSalFOBTabla: TMenuItem;
    mnuAlmValorarPaletsEntrega: TMenuItem;
    mnuAlmLiquidarEntregas: TMenuItem;
    mnuAlmLiquidarVerde: TMenuItem;
    mnuAlmLiquidarPlatano: TMenuItem;
    mnuFacNotificacionCredito: TMenuItem;
    mnuAlmKilosLiquidacionPlatanos: TMenuItem;
    mnuAlmEnvasesSinCoste: TMenuItem;
    mnuUtiPlantillas: TMenuItem;
    mnuUtiPlantillaReportes: TMenuItem;
    mnuSalLisSalidasSuper: TMenuItem;
    mnuSalEnvioAlbaranes: TMenuItem;
    mnuSalLisAlbaranesEnviados: TMenuItem;
    mnuAlmSepMargen: TMenuItem;
    mnuAlmValorarFrutaProveedor: TMenuItem;
    mnuTraLisFacGasTransitos: TMenuItem;
    mnuFacDiasMediosPagoClientes: TMenuItem;
    mnuAlmResumenConsumoEntrega: TMenuItem;
    mnuEntControlImportesFacturasLineas: TMenuItem;
    mnuDatControlEnviodeAlbaranes: TMenuItem;
    mnuProcFacturacion: TMenuItem;
    mnuManFacturas: TMenuItem;
    mnuFchListadoComisiones: TMenuItem;
    mnuRepFacturacion: TMenuItem;
    mnuFacturarEdi: TMenuItem;
    mnuContFacturas: TMenuItem;
    mnuMarcaContable: TMenuItem;
    mnuAnuFacturas: TMenuItem;
    mnuManRemesas: TMenuItem;
    mnuFchComerciales: TMenuItem;
    mnuSalResumendeSalidasporProducto: TMenuItem;
    mnuFacAlbaranesFacturadosEn: TMenuItem;
    mnuProformaFac: TMenuItem;
    mniEntMargenBeneficio: TMenuItem;
    mnnFchClientesListadoFormaPago: TMenuItem;
    mnuFacParaAnticipar: TMenuItem;
    mnuSalResumenFOB: TMenuItem;
    mnuAlmsepCostesIndirectos: TMenuItem;
    mnuAlmCostesIndirectos: TMenuItem;
    mnuFacAlbaranesFactura: TMenuItem;
    mnuAlmSepPartes: TMenuItem;
    mnuFacListadoVentasPeriodo: TMenuItem;
    mnuAlmValorarCargaDirecta: TMenuItem;
    mniCierre: TMenuItem;
    mniValorarStock: TMenuItem;
    mniComprasTransito: TMenuItem;
    mniGastosCompras: TMenuItem;
    mniGastosTransitos: TMenuItem;
    mniGastosSalidas: TMenuItem;
    mniVentasPendientesFacturar: TMenuItem;
    mnuAlmParteProduccion: TMenuItem;
    mnuSalResumenSalidasDinamico: TMenuItem;
    mnuFchTiposdeCaja: TMenuItem;
    mnuFacSaldoPendienteCobro: TMenuItem;
    mnuFacSinContablizarX3: TMenuItem;
    mnuAlmPrecioLiquidacion: TMenuItem;
    mnuSalSalidasLPR: TMenuItem;
    mnuImprimirFactura: TMenuItem;
    Gastos: TMenuItem;
    mnuSalGrabarGastosTransporte: TMenuItem;
    mnuSalAsignarGastosTransportes: TMenuItem;
    N1: TMenuItem;
    mnuSalFacGasVentas: TMenuItem;
    mnuSalFacControlGasVentas: TMenuItem;
    mnuAlmPrecioVentaCliente: TMenuItem;
    mnuDesgloseSalidas: TMenuItem;
    N2: TMenuItem;
    mnuDatDiarioDesgloseSal: TMenuItem;
    mnuPedConfirmaRecepcion: TMenuItem;
    mnuRepFacturacionCont: TMenuItem;
    N3: TMenuItem;
    mnuExistenciasPuntoLame: TMenuItem;
    mnuFchFlotaCamiones: TMenuItem;
    mnuSincronizacion: TMenuItem;
    Intrastat1: TMenuItem;
    mnuSalInformeIntrastat: TMenuItem;
    mnuSalControlIntrastat: TMenuItem;

    // ======================  FUNCIONES/PROCEDIMIENTOS  ======================

    // --------------------------------  FORM  --------------------------------
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADAltasExecute(Sender: TObject);
    procedure ADModificarExecute(Sender: TObject);
    procedure ADBorrarExecute(Sender: TObject);
    procedure ADAnteriorExecute(Sender: TObject);
    procedure ADSiguienteExecute(Sender: TObject);
    procedure AMAltasExecute(Sender: TObject);
    procedure AMBorrarExecute(Sender: TObject);
    procedure AMModificarExecute(Sender: TObject);
    procedure AMLocalizarExecute(Sender: TObject);
    procedure AMPrimeroExecute(Sender: TObject);
    procedure AMSiguienteExecute(Sender: TObject);
    procedure AMAnteriorExecute(Sender: TObject);
    procedure AMUltimoExecute(Sender: TObject);
    procedure AMDCancelarExecute(Sender: TObject);
    procedure AMDSalirExecute(Sender: TObject);
    procedure AMDAceptarExecute(Sender: TObject);
    procedure ACerrarExecute(Sender: TObject);
    procedure AIPrevisualizarExecute(Sender: TObject);

    procedure RelojTimer(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;

    // ----------------------  PROCEDIMIENTOS GENERALES  ----------------------
    //Habilitar barra de menu
    procedure HabilitarMenu(Habilitar: boolean);

    procedure ConfigurarMenuFicheros;
    procedure mnuFicherosClick(Sender: TObject);

    procedure ConfigurarMenuCompras;
    procedure mnuComprasClick(Sender: TObject);

    procedure ConfigurarMenuAlmacen;
    procedure mnuAlmacenClick(Sender: TObject);

    procedure ConfigurarMenuTransitos;
    procedure mnuTransitosClick(Sender: TObject);

    procedure ConfigurarMenuPedidos;
    procedure mnuPedidosClick(Sender: TObject);

    procedure ConfigurarMenuSalidas;
    procedure mnuSalidasClick(Sender: TObject);

    procedure ConfigurarMenuFacturacion;
    procedure mnuFacturacionClick(Sender: TObject);

    procedure ConfigurarMenuTransmision;
    procedure mnuTransmisionClick(Sender: TObject);

    procedure ConfigurarMenuUtilidades;
    procedure mnuUtilidadesClick(Sender: TObject);
    procedure ACalculadoraExecute(Sender: TObject);
    procedure AConversionDivisasExecute(Sender: TObject);
    procedure AEuroConversorExecute(Sender: TObject);
    procedure mnuManFacturasClick(Sender: TObject);
    function GetUsuarioContable: boolean;
    procedure mnuCierreClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    function FechaPanel: string;

  public

  end;


var
  FPrincipal: TFPrincipal;

implementation

uses
  UActualizar,
  UDMBaseDatos, UDMConfig, CVariables, CGestionPrincipal, CMaestro,
  CMaestroDetalle, bDialogs, bFileUtils, BEdit, DError, DPassword,

  CUAMenuFicheros, CUAMenuCompras, CUAMenuAlmacen,
  CUAMenuTransitos, CUAMenuPedidos, CUAMenuSalidas,
  CUAMenuFacturacion, CUAMenuTransmision, CUAMenuUtiles,

  bCalculadora, DNoEuro, DConversor, BonnyQuery,
  SincronizacionBonny;


{$R *.DFM}


//Prevenir la ejecucion de dos instancias de la aplicacion
procedure TFPrincipal.CreateParams(var Params: TCreateParams);
var
  sAux: string;
  x: Integer;
begin
  //Para eso usamos la descripcion de la BD a la que nos conectamos
  inherited CreateParams(Params);
  sAux:= 'GComerBAG' + arDataConexion[iBDDataConexion].sDescripcion;
  for x:=length( sAux ) downto 1 do
    Params.WinClassName[x-1]:= sAux[x];
end;

// ==================================  FORM  ==================================

// ---------------------------------  INICIO  ---------------------------------

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  DMConfig.Logon;
  Application.Title:= UpperCase( arDataConexion[ iBDDataConexion ].sDescripcion );

  //Teclas para las altas y bajas
  AMAltas.ShortCut := vk_add; //mas numerico
  AMBorrar.ShortCut := VK_SUBTRACT; //menos numerico
  ADAltas.ShortCut := ShortCut(VK_ADD, [ssAlt]); //mas numerico
  ADBorrar.ShortCut := ShortCut(VK_SUBTRACT, [ssAlt]); //menos numerico
  ADModificar.ShortCut := ShortCut(Word('M'), [ssAlt]); //M


  //Titulo del formulario
  Caption := UpperCase( 'GESTI?N COMERCIAL ' + arDataConexion[iBDDataConexion].sDescripcion + ' (' +  gsNombre + ')  ' +  gsAplicVersion);

  //Tama?o de la zona para barras
  CBControlBarras.Height := 26;

  //Tipo formulario
  FormType := tfDirector;
  //Barra de herramientas
  BHFormulario;

  //Barra estado
  Reloj.Enabled := true;
  Reloj.Interval := 60000; //1 minuto
  SBBarraEstado.Panels[0].Text := FechaPanel;

  //Inicializar Numeros aleatorios
  Randomize;
  //Borrar temporales de la sesion anterior del usuario actual
  if Trim(gsCodigo) <> '' then
    DeleteFiles(gsDirActual + '\temp\' + gsCodigo + '*.*');

  ConfigurarMenuFicheros;
  ConfigurarMenuCompras;
  ConfigurarMenuAlmacen;
  ConfigurarMenuTransitos;
  ConfigurarMenuPedidos;
  ConfigurarMenuSalidas;
  ConfigurarMenuAlmacen;
  ConfigurarMenuFacturacion;
  ConfigurarMenuTransmision;
  ConfigurarMenuUtilidades;

  UActualizar.Actualizar;
end;

procedure TFPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin

end;

// ----------------------------------  FIN  -----------------------------------

procedure TFPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //S?lo podemos salir si el formulario activo es el principal
  if FormType <> tfDirector then
  begin
    CanClose := False;
    Exit;
  end;

  //Si la Base de Datos esta cerrada salimos sin preguntar
  if not DMBaseDatos.DBBaseDatos.Connected then
  begin
    CanClose := True;
    Exit;
  end;

  // Aviso
  if UPPERCASE(gsCodigo) <> 'PRUEBA' then
  begin
    if Preguntar('? Desea salir del programa ?') then
      CanClose := True
    else
      CanClose := False;
  end
  else
  begin
    CanClose := True;
  end;

end;

procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DMConfig.Logoff;

  // Cierre de las Bases de Datos
  with DMBaseDatos.DBBaseDatos do
  begin
    Close;
    Params.Clear;
  end;

  SincroBonnyAurora.Fin;
  SincroBonnyAurora.Free;

  Action := caFree;
end;

// ================================  ACCIONES ===================================
// -----------------------------  DESPLAZAMIENTO  -----------------------------

procedure TFPrincipal.AMPrimeroExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
      Primero;
end;

procedure TFPrincipal.AMSiguienteExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
      Siguiente;
end;

procedure TFPrincipal.AMAnteriorExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
      Anterior;
end;

procedure TFPrincipal.AMUltimoExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
      Ultimo;
end;

procedure TFPrincipal.ADAnteriorExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestroDetalle) then
    with ActiveMDIChild as TMaestroDetalle do
      DetalleAnterior;

end;

procedure TFPrincipal.ADSiguienteExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestroDetalle) then
    with ActiveMDIChild as TMaestroDetalle do
      DetalleSiguiente;

end;

// ------------------------------  OPERACIONES  -------------------------------

procedure TFPrincipal.AMAltasExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
      Altas;
end;

procedure TFPrincipal.AMBorrarExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
      Borrar;
end;

procedure TFPrincipal.AMModificarExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
      Modificar;
end;

procedure TFPrincipal.AMLocalizarExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
      Localizar;
end;

procedure TFPrincipal.ADAltasExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestroDetalle) then
    with ActiveMDIChild as TMaestroDetalle do
      DetalleAltas;
end;

procedure TFPrincipal.ADModificarExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestroDetalle) then
    with ActiveMDIChild as TMaestroDetalle do
      DetalleModificar;
end;

procedure TFPrincipal.ADBorrarExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestroDetalle) then
    with ActiveMDIChild as TMaestroDetalle do
      DetalleBorrar;
end;

// --------------------------------  ACEPTAR  ---------------------------------

procedure TFPrincipal.AMDAceptarExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    {with ActiveMDIChild as TMaestro do}
    with TMaestro(ActiveMDIChild) do
    begin
      //Esta la rejilla desplegada
      if (gRF <> nil) then
      begin
        if esVisible( gRF ) then
          //No hacemos nada
          Exit;
      end;
      //Esta el calendario desplegada
      if (gCF <> nil)  then
      begin
        if (esVisible( gCF )) then
          //No hacemos nada
          Exit;
      end;
      Aceptar;
    end;
end;

// --------------------------------  CANCELAR  --------------------------------

procedure TFPrincipal.AMDCancelarExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
    begin
      //Esta la rejilla desplegada
      if (gRF <> nil) then
      begin
        if esVisible( gRF ) then
          //No hacemos nada
          Exit;
      end;
      //Esta el calendario desplegada
      if (gCF <> nil)  then
      begin
        if (esVisible( gCF )) then
          //No hacemos nada
          Exit;
      end;
      Cancelar;
    end;
end;

// ---------------------------------  SALIR  ----------------------------------

procedure TFPrincipal.AMDSalirExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
    begin
      Salir;
    end;
  (*if UPPERCASE( gsCodigo ) = 'PRUEBA' then
     close
  *)
end;

// ==============================  IMPRESION ===================================
// --------------------------     Vista Previa  ---------------------------

procedure TFPrincipal.AIPrevisualizarExecute(Sender: TObject);
begin
  if (ActiveMDIChild is TMaestro) then
    with ActiveMDIChild as TMaestro do
    begin
      Previsualizar;
    end;
end;

//******************* MENU SALIR *************************
//***************** SALIR DE LA APLICACION******************

procedure TFPrincipal.ACerrarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFPrincipal.RelojTimer(Sender: TObject);
begin
  SBBarraEstado.Panels[0].Text := FechaPanel;
end;

function TFPrincipal.FechaPanel: string;
var
  ano, mes, dia: Word;
  fecha, des: string;
begin
  DecodeDate(Date, ano, mes, dia);
  fecha := copy(timeTostr(time), 1, 5);
  if copy(fecha, 5, 1) = ':' then
    fecha := copy(fecha, 1, 4);
  case DayOfWeek(Date) of
    1: des := ' Domingo ';
    2: des := ' Lunes ';
    3: des := ' Martes ';
    4: des := ' Miercoles ';
    5: des := ' Jueves ';
    6: des := ' Viernes ';
    7: des := ' Sabado ';
  end;
  FechaPanel := des + IntToStr(dia) + '/' +
    IntToStr(mes) + '/' +
    IntToStr(ano) + ' ' +
    fecha;
end;

procedure TFPrincipal.HabilitarMenu(Habilitar: boolean);
var
  i: Integer;
begin
  if Menu = nil then
    Exit;
  for i := 0 to Menu.Items.Count - 1 do
  begin
    Menu.Items[i].Enabled := Habilitar;
  end;
  barAplicaciones.Visible:= Habilitar;
end;


//**********************************************************************************
//**********************************************************************************
//**********************************************************************************

function TFPrincipal.GetUsuarioContable: boolean;
var QUsuario : TBonnyQuery;
begin
  QUsuario := TBonnyQuery.Create(Self);
  with QUsuario do
  try
    SQL.Add('select * from cnf_usuarios ');
    SQL.Add(' where usuario_cu = :usuario ');
    SQL.Add('   and enlace_contable_cu = 1 ');
    ParamByName('usuario').AsString:= gsCodigo;

    Open;
    result := not IsEmpty;
  finally
    Free;
  end;
end;

procedure ConfigurarOpcion( AOpcion: TMenuItem; const AActiva: boolean = true;
                            const ACaption: string = ''; const AHint: string = '');
begin
  //AOpcion.Tag:= ATag;
  AOpcion.Enabled:= AActiva;
  AOpcion.Visible:= AActiva;
  AOpcion.Caption:= ACaption;
  AOpcion.Hint:= AHint;
end;

procedure TFPrincipal.ConfigurarMenuFicheros;
begin
  ConfigurarOpcion(  mnuFicheros, True, 'Fi&cheros', '');

  ConfigurarOpcion(  mnuFchsep, True, '-', 'Ficheros Maestros');
  ConfigurarOpcion(  mnuFchAduanasPuertos, True, 'Aduanas/Puertos', '');
  ConfigurarOpcion(  mnuFchAgrupacionesEnvase, True, 'Agrupaciones Art?culos', '');
  ConfigurarOpcion(  mnuFchAgrupacionesGasto, True, 'Agrupaciones Gasto', '');
  ConfigurarOpcion(  mnuFchBancos, DMConfig.EsLaFont, 'Bancos', '');
//  ConfigurarOpcion(  mnuFchBancosNew, DMConfig.EsLaFont, 'Bancos - En Desarrollo', '');
//  ConfigurarOpcion(  mnuFchBancosOld, DMConfig.EsLaFont, 'Bancos', '');

  ConfigurarOpcion(  mnuFchCentros, True, 'Centros', '');
  ConfigurarOpcion(  mnuFchClientes, True, 'Clientes', '');
  ConfigurarOpcion(  mnuFchListadoComisiones, True, 'Clientes - Listado Descuentos/Comisiones', '');
  ConfigurarOpcion(  mnnFchClientesListadoFormaPago, True, 'Clientes - Listado Forma de Pago', '');
  ConfigurarOpcion(  mnuFchEan13, True, 'C?digos EAN13 de Articulos', '');
  ConfigurarOpcion(  mnuFchClientesEDI, DMConfig.EsLaFont, 'C?digos EDI de Clientes', '');
//  ConfigurarOpcion(  mnuFchProductoEDI, DMConfig.EsLaFont, 'C?digos Facturaci?n EDI', '');
  ConfigurarOpcion(  mnuFchEmpresas, True, 'Empresas', '');

  ConfigurarOpcion(  mnuFchEnvases, True, 'Art?culos ', '');
  ConfigurarOpcion(  mnuFchEnvasesComerciales, True, 'Envases Comerciales/Retornables', '');

  ConfigurarOpcion(  mnuFchComerciales, True, 'Comerciales', '');
  ConfigurarOpcion(  mnuFchFormasPago, DMConfig.EsLaFont , 'Formas de Pago', '');
  ConfigurarOpcion(  mnuFchFlotaCamiones, True, 'Flota de Camiones', '');

  ConfigurarOpcion(  mnuFchFormatosPalet, True, 'Formatos Palet', '');
  ConfigurarOpcion(  mnuFchImpuestos, True, 'Impuestos', '');
  ConfigurarOpcion(  mnuFchMarcas, True, 'Marcas', '');
  ConfigurarOpcion(  mnuFchMonedas, True, 'Monedas', '');
  ConfigurarOpcion(  mnuFchPaises, True, 'Pa?ses', '');
  ConfigurarOpcion(  mnuFchProductos, True, 'Productos', '');
  ConfigurarOpcion(  mnuFchProveedores, True, 'Proveedores', '');
  ConfigurarOpcion(  mnuFchProveedoresFincas, DMConfig.EsTenerife, 'Proveedores - Fincas', '');
  ConfigurarOpcion(  mnuTipoCostes, DMConfig.EsLaFont, 'Tipo de Costes Proveedor', '');
  ConfigurarOpcion(  mnuFchProvincias, True, 'Provincias', '');
  ConfigurarOpcion(  mnuFchRepresentantes, DMConfig.EsLaFont, 'Representantes', '');
  ConfigurarOpcion(  mnuFchSeccionesContables, DMConfig.EsLaFont, 'Secciones Contables', '');
  ConfigurarOpcion(  mnuFchTiposdeCaja, True, 'Tipo de Cajas', '');
  ConfigurarOpcion(  mnuFchTipoGastos, True, 'Tipo de Gastos', '');
  ConfigurarOpcion(  mnuFchTipoPalets, True, 'Tipo de Palets', '');
  ConfigurarOpcion(  mnuFchTiposVia, True, 'Tipo de V?as', '');
  ConfigurarOpcion(  mnuFchTransportistasMante, True, 'Transportistas - Mantenimiento', '');
  ConfigurarOpcion(  mnuFchUnidadesConsumo, True, 'Unidades de Consumo', '');

end;

procedure TFPrincipal.mnuFicherosClick(Sender: TObject);
begin
  CUAMenuFicheros.EjecutarMenuFicheros( self, TMenuItem( Sender ).Name );
end;

procedure TFPrincipal.ConfigurarMenuCompras;
begin
  ConfigurarOpcion(  mnuComprasProveedor, True, '&Compras', '');

  ConfigurarOpcion(  mnuEntSepCompas, True, '-', 'Compras Proveedor');
  ConfigurarOpcion(  mnuEntFacturasPlatano, DMConfig.EsLaFont, 'Facturas Despacho Pl?tano Canario', '');

  ConfigurarOpcion(  mnuEntSepComprasEntregas, DMConfig.EsLaFont, '-', '');
  ConfigurarOpcion(  mnuEntEntregas, True, 'Entregas de Proveedor', '');
  ConfigurarOpcion(  mnuEntLstEntregas, True, 'Listado Entregas', '');
  ConfigurarOpcion(  mnuEntLstControlEntregas, True, 'Listado Control de Entregas', '');
  ConfigurarOpcion(  mnuEntResEntregas, True, 'Resumen Entregas', '');
  ConfigurarOpcion(  mnuEntResPesosEntregas, DMConfig.EsMaset, 'Resumen Pesos Entregas', '' );
  ConfigurarOpcion(  mnuEntLstGastosEntregas, True, 'Listado Gastos de Entregas', '');
  ConfigurarOpcion(  mnuEntLstControlGastosEntregas, True, 'Listado de Entregas sin Gastos ', '');
  ConfigurarOpcion(  mnuEntServiciosTransportes, True, 'Resumen Servicios por Transportista', '');

  ConfigurarOpcion(  mnuEntSepStockAlmacen,  not DMConfig.EsLaFont, '-', 'Confeccionado Almac?n');
  ConfigurarOpcion(  mnuEntPendientesDescarga, not DMConfig.EsLaFont, 'Entregas Pendientes de Descargar' );
  ConfigurarOpcion(  mnuEntStockActualProveedor,  not DMConfig.EsLaFont , 'Stock Fruta', '');
  (*TODO*)(*NO SE PUEDE VALORAR EN EL ALMACEN POR QUE NO HAY IMPORTES COMPRA GRABADOS*)
  //ConfigurarOpcion(  mnuEntValorFrutaPlantaProveedor, not DMConfig.EsLaFont, 'Valorar Fruta en Planta', '');
  ConfigurarOpcion(  mnuEntValorFrutaPlantaProveedor, False, 'Valorar Fruta en Planta', '');
  ConfigurarOpcion(  mnuEntPaletsProveedorVolcados,  not DMConfig.EsLaFont, 'Palets Volcados', '');
  ConfigurarOpcion(  mnuStockFrutaConfeccionadaFormatos,  not DMConfig.EsLaFont, 'Stock Fruta Confeccionada por Formatos', '');
  ConfigurarOpcion(  mnuStockFrutaConfeccionadaEnvases,  not DMConfig.EsLaFont, 'Stock Fruta Confeccionada por Art?culos', '');
  ConfigurarOpcion(  mnuEntPaletsConfeccionados,  not DMConfig.EsLaFont, 'Palets Confeccionados', '');
  ConfigurarOpcion(  mnuEntListadoDestrioFrutaRF,  not DMConfig.EsLaFont, 'Listado Destrio Fruta RF', '');

  ConfigurarOpcion(  mnuEntSepFacturasCompras, DMConfig.EsLaFont, '-', 'Facturas Compras Proveedor');
  ConfigurarOpcion(  mnuEntLstFacturasProveedorNew, DMConfig.EsLaFont, 'Listado Facturas Proveedor', '');
  ConfigurarOpcion(  mnuEntEntregasSinFacturar, DMConfig.EsLaFont, 'Entregas Pendientes de Facturar', '');
  ConfigurarOpcion(  mnuEntControlImportesFacturasLineas, DMConfig.EsLaFont, 'Control Importes Facturas / Lineas', '');
  //Mismo lisatdo, pero diferente posicion en el menu
  ConfigurarOpcion(  mnuEntResumenCosteProveedor, DMConfig.EsLaFont, 'Resumen Coste Entregas Por Proveedor', '');
  ConfigurarOpcion(  mnuEntResumenCosteProducto, DMConfig.EsLaFont, 'Resumen Coste Entregas Por Producto', '');
  ConfigurarOpcion(  mnuEntComprasProductoProveedor, DMConfig.EsLaFont, 'Resumen Compras Producto/Proveedor', '');
  ConfigurarOpcion(  mnuEntBeneficioProducto, DMConfig.EsLaFont, 'Beneficio Producto', '');
  ConfigurarOpcion(  mnuEntResumenCosteProveedorBonde, not DMConfig.EsLaFont, 'Resumen Coste Entregas Por Proveedor', '');
  ConfigurarOpcion(  mnuEntResumenCosteProductoBonde, not DMConfig.EsLaFont, 'Resumen Coste Entregas Por Producto', '');

  ConfigurarOpcion(  mnuEntSepIntrastat, DMConfig.EsLaFont, '-', 'Intrastat');
  ConfigurarOpcion(  mnuEntControlIntrastat, DMConfig.EsLaFont, 'Control Intrastat', '');
  ConfigurarOpcion(  mnuEntIntrasat, DMConfig.EsLaFont, 'Intrastat', '');

  ConfigurarOpcion(  mnuEntSepRecepcion, not DMConfig.EsLaFont, '-', 'Recibir Entregas' );
  ConfigurarOpcion(  mnuEntRecibirEntregas, not DMConfig.EsLaFont , 'Recibir Entregas Pendientes' );

  ConfigurarOpcion(  mnuEntSepLiquidacion, True, '-', 'Liquidaci?n' );
  ConfigurarOpcion(  mnuEntDifKilosComerRF, not DMConfig.EsLaFont, 'Diferencias Kilos/Cajas Comercial-Radiofrecuencia' );
  ConfigurarOpcion(  mnuEntDifFechasComerRF, not DMConfig.EsLaFont, 'Diferencias Fechas Comercial-Radiofrecuencia' );
  ConfigurarOpcion(  mnuEntLiquidacionEntrega, DMConfig.EsLaFont, 'Liquidaci?n Entrega' );
  ConfigurarOpcion(  mnuEntPrevisionCostesProducto, DMConfig.EsLaFont, 'Previsi?n Costes Producto' );

  if DMConfig.EsLaFont then
    ConfigurarOpcion(  mniEntMargenBeneficio, True , 'NEW - Margen Beneficio (EN DESARROLLO)', '')
  else
    ConfigurarOpcion(  mniEntMargenBeneficio, True , 'NEW - Parte confecci?n (EN DESARROLLO)', '');

  ConfigurarOpcion(  mnuEntMargenPeriodo, DMConfig.EsLaFont, 'OLD - Margen Beneficio Periodo' );
  ConfigurarOpcion(  mnuEntMargenSemanal, DMConfig.EsLaFont, 'OLD - Margen Beneficio Semanal' );
  ConfigurarOpcion(  mnuEntValorarStockProveedor, DMConfig.EsLaFont , 'Valorar Stock Proveedor', '');
  ConfigurarOpcion(  mnuEntValorarStockConfeccionado, DMConfig.EsLaFont , 'Valorar Stock Confeccionado', '');


  //not DMConfig.EsLaFont
  ConfigurarOpcion(  mnuEntCuadreSemanalRFAlmacen, True, 'Cuadre Semanal RF Almac?n' );
end;

procedure TFPrincipal.mnuComprasClick(Sender: TObject);
begin
  CUAMenuCompras.EjecutarMenuCompras( self, TMenuItem( Sender ).Name );
end;

procedure TFPrincipal.ConfigurarMenuAlmacen;
begin
  ConfigurarOpcion(  mnuAlmacen, True, '&Costes', '');

  ConfigurarOpcion(  mnuAlmSepCosteEnvase, True, '-', 'Costes del Art?culo');
  ConfigurarOpcion(  mnuAlmCostesEnvase, True, 'Costes por KG Art?culos (Mensual)', '');
  ConfigurarOpcion(  mnuAlmVerificarCosteEnvases, True, 'Verificar Grabaci?n Costes Art?culo', '');
  ConfigurarOpcion(  mnuAlmEnvasesSinCoste, True, 'Art?culos Sin Costes Grabados', '');
  ConfigurarOpcion(  mnuAlmLstCosteEnvase, True, 'Listado Costes Art?culo', '');
  ConfigurarOpcion(  mnuAlmCostesEstadisticosdeEnvasadoKg, True, 'Costes Estad?sticos de Envasado por Kg', '');
  ConfigurarOpcion(  mnuAlmTablaAnualCosteKgEnvasado, True, 'Tabla Anual Coste Kg Envasado', '');

  ConfigurarOpcion(  mnuAlmsepCostesIndirectos, DMConfig.EsLaFont, '-', 'Costes Estructura');
  ConfigurarOpcion(  mnuAlmCostesIndirectos, DMConfig.EsLaFont, 'Costes Estructura', '');

  ConfigurarOpcion(  mnuAlmSepCostesSecciones, False, '-', 'Costes por Seccion');
  ConfigurarOpcion(  mnuAlmTipoSecciones, False, 'Tipo de Secciones', '');
  ConfigurarOpcion(  mnuAlmSeccionesCosechero, False, 'Secciones por Cosechero/OPP', '');
  ConfigurarOpcion(  mnuAlmCosteSecciones, False, 'Coste por KG Seccion (Mensual)', '');
  ConfigurarOpcion(  mnuAlmFichaSecciones, False, 'Ficha Secciones Cosechero/OPP Activas', '');

  ConfigurarOpcion(  mnuAlmSepLiquidarPlatano, DMConfig.EsLaFont, '-', 'Verificar Partes');
  ConfigurarOpcion(  mnuAlmKilosLiquidacionPlatanos, DMConfig.EsLaFont, 'Verificar Cajas/Kilos Entregados', '');

  ConfigurarOpcion(  mnuAlmSepLiquidarPlatano, DMConfig.EsLaFont, '-', 'Liquidaci?n Pl?tano');
  ConfigurarOpcion(  mnuAlmValorarCargaDirecta, DMConfig.EsLaFont, 'Precios Venta Carga Directa', '');
  ConfigurarOpcion(  mnuAlmValorarPaletsEntrega, DMConfig.EsLaFont, 'Valorar Palets Entrega', '');
  ConfigurarOpcion(  mnuAlmLiquidarEntregas, DMConfig.EsLaFont, 'Liquidaci?n Entregas Con RF', '');
  ConfigurarOpcion(  mnuAlmLiquidarVerde, DMConfig.EsLaFont, 'Liquidaci?n Entregas Sin RF (F42)', '');
  ConfigurarOpcion(  mnuAlmLiquidarPlatano, DMConfig.EsLaFont, 'Liquidaci?n Platano', '');

  ConfigurarOpcion(  mnuAlmSepMargen, True, '-', 'Margen de Beneficios');
  ConfigurarOpcion(  mnuAlmResumenConsumoEntrega, DMConfig.EsLaFont, 'Resumen Consumo por Entrega', '');
  ConfigurarOpcion(  mnuAlmValorarFrutaProveedor, DMConfig.EsLaFont, 'Valorar Fruta Proveedor', '');
  ConfigurarOpcion(  mnuAlmParteProduccion, True, 'Parte de Producci?n', '');

  ConfigurarOpcion(  mnuAlmSepPreciosDiarios, DMConfig.EsLaFont, '-', 'Precios Diarios');
  ConfigurarOpcion(  mnuAlmPreciosDiariosrEnvases, false, 'Precios Diarios por Art?culo', '');
  ConfigurarOpcion(  mnuAlmPrecioVentaCliente, DMConfig.EsLaFont, 'Precio Venta por Cliente y Art?culo', '');

end;

procedure TFPrincipal.mnuAlmacenClick(Sender: TObject);
begin
  CUAMenuAlmacen.EjecutarMenuAlmacen( self, TMenuItem( Sender ).Name );
end;

procedure TFPrincipal.ConfigurarMenuTransitos;
begin
  ConfigurarOpcion(  mnuTransitos, True, '&Tr?nsitos', '');

  ConfigurarOpcion(  mnuTraSepTransistos, True, '-', 'Gesti?n de Tr?nsitos');
  ConfigurarOpcion(  mnuTraTransitos, True, 'Tr?nsitos', '');
  ConfigurarOpcion(  mnuTraLisEnvasesTransitos, True, 'Resumen de Art?culos de Tr?nsitos', '');
  ConfigurarOpcion(  mnuTraServiciosTransportistas, True, 'Resumen Servicios por Transportista', '');
  ConfigurarOpcion(  mnuTraLisFacGasTransitos, True, 'Listado Facturas Gastos Tr?nsitos', '');

  ConfigurarOpcion(  mnuTraSepRecepcionTransitos, not DMConfig.EsLaFont, '-', 'Recepci?n de Tr?nsitos');
  ConfigurarOpcion(  mnuTraRecepcionTransitos, not DMConfig.EsLaFont, 'Recepci?n de Tr?nsitos', '');
end;

procedure TFPrincipal.mnuTransitosClick(Sender: TObject);
begin
  CUAMenuTransitos.EjecutarMenuTransitos( self, TMenuItem( Sender ).Name );
end;

procedure TFPrincipal.ConfigurarMenuPedidos;
begin
  ConfigurarOpcion(  mnuPedidos, True, '&Pedidos', '');

//  ConfigurarOpcion(  mnuPedSepPedidos, True, '-', 'Pedidos del Cliente');
//  ConfigurarOpcion(  mnuPedPedidosEnvase, True, 'Mantenimiento Pedidos por Art?culos', '');
  ConfigurarOpcion(  mnuPedPedidosFormato, True, 'Proceso de Pedidos Aplicaci?n WEB', '');
{
  ConfigurarOpcion(  mnuPedSepPedidosAux,True, '-', '');
  ConfigurarOpcion(  mnuPedAlbaranAPedido, True, 'Crear Pedido Desde Albar?n', '');
  ConfigurarOpcion(  mnuPedLisPedidos, False, 'Listado de Pedidos', ''); (*TODO, no hay*)
  ConfigurarOpcion(  mnuPedResPedidos, True, 'Resumen de Pedidos', '');
  ConfigurarOpcion(  mnuPedPedidosSinSalidas, True, 'Ver Pedidos Sin Salidas Asignadas', '');
  ConfigurarOpcion(  mnuPedSalidasSinPedidos, True, 'Ver Salidas Sin Pedido Asociado', '');
  ConfigurarOpcion(  mnuPedResumenPedido, DMConfig.EsLaFont , 'Resumen Pedido/Servido', '');
  ConfigurarOpcion(  mnuPedDesglosePedido, DMConfig.EsLaFont , 'Desglose Pedido/Servido', '');
}
  ConfigurarOpcion(  mnuPedConfirmaRecepcion, DMConfig.EsLaFont, 'Confirmaci?n de Recepci?n de Mercanc?as En Mercadona', '');
{
  ConfigurarOpcion(  mnuPedRECADV, False, 'RECADV', '');

  ConfigurarOpcion(  mnuPedSepOrdenCarga, not DMConfig.EsLaFont, '-', 'Orden de Carga');
  ConfigurarOpcion(  mnuPedOrdenCarga, False, 'Orden de Carga (INFO)', '');
  ConfigurarOpcion(  mnuPedPackingOrdenCarga, not DMConfig.EsLaFont, 'Packing Orden de Carga', '');
}
end;

procedure TFPrincipal.mnuPedidosClick(Sender: TObject);
begin
  CUAMenuPedidos.EjecutarMenuPedidos( Self, TMenuItem( Sender ).Name );
end;

procedure TFPrincipal.ConfigurarMenuSalidas;
begin
  ConfigurarOpcion(  mnuSalidas, True, '&Salidas', '');

  ConfigurarOpcion(  mnuSalSepSalidas, True, '-', 'Gesti?n Salidas');
  ConfigurarOpcion(  mnuSalSalidas, True, 'Salidas', '');
  ConfigurarOpcion(  mnuTablaDinamicaSalidas, True, 'Tabla Din?mica Salidas', '');
  ConfigurarOpcion(  mnuSalResumenSalidasDinamico, True, 'Resumen Salidas Dinamico', '');
  ConfigurarOpcion(  mnuSalLisSalidasClientes, True, 'Salidas por Clientes', '');
  ConfigurarOpcion(  mnuSalLisSalidasSuper, True, 'Salidas por Supermercados', '');
  ConfigurarOpcion(  mnuSalLisSalidasProductos, True, 'Listado Salidas por Producto', '');
  ConfigurarOpcion(  mnuSalResumendeSalidasporProducto, True, 'Resumen Salidas por Producto', '');
  ConfigurarOpcion(  mnuSalLisSalidasCategoriaCalibre, True, 'Salidas por Categoria y Calibre', '');
  ConfigurarOpcion(  mnuSalLisSalidasPalet, True, 'Salidas por Palet', '');
  ConfigurarOpcion(  mnuSalEnvioAlbaranes, False, 'Env?o de Albaranes por Correo Electronico', '');
  ConfigurarOpcion(  mnuSalLisAlbaranesEnviados, True, 'Listado de Albaranes Enviados', '');
  ConfigurarOpcion(  mnuSalFacControlGasVentas, True, 'Control Gastos Ventas', '');
  ConfigurarOpcion(  mnuSalFacGasVentas, True, 'Listado Facturas de Gastos Ventas', '');

  ConfigurarOpcion(  mnuSalSemanalExpediciones, DMConfig.EsLaFont, 'Declaraci?n Semanal de Expediciones', '');

  ConfigurarOpcion(  mnuSalSepSalidasPlus, True, '-', '');
  ConfigurarOpcion(  mnuSalServiciosTransporteImporte, True, 'Servicios por Transportista - Importe Fruta', '');
                                                         (*TODO*)
  ConfigurarOpcion(  mnuSalServiciosTransporteTransporte, False, 'Servicios por Transportista - Coste Transporte', '');
  ConfigurarOpcion(  mnuSalResSalidasEnvase, True, 'Salidas por Art?culos', '');


  ConfigurarOpcion(  mnuSalInventarioEnvComer, True, 'Inventario Envases Comerciales', '');
  ConfigurarOpcion(  mnuSalAjustesInventarioEnvComer, True, 'Ajustes Inventario', '');
  ConfigurarOpcion(  mnuSalEntradasEnvComer, True, 'Entradas Envases Comerciales', '');
  ConfigurarOpcion(  mnuSalTransitosEnvComer, True, 'Tr?nsitos Envases Comerciales', '');
  ConfigurarOpcion(  mnuSalSepEnvasesComerciales, True, '-', '');
  ConfigurarOpcion(  mnuSalMovimientosEnvasesComerciales, True, 'Listado Movimientos Envases Comerciales', '');
  ConfigurarOpcion(  mnuSalListadoEnvasesComerciales, True, 'Salidas por Envases Comerciales/Retornables', '');
  ConfigurarOpcion(  mnuSalFacturaLogifruit, True, 'Factura Logifruit', '');


  ConfigurarOpcion(  mnuSalVentasSemEnvases, True, 'Ventas Semanal por Art?culos', '');
  ConfigurarOpcion(  mnuSalVentasSemMercadona, True, 'Resumen Ventas Mercadona', '');
  ConfigurarOpcion(  mnuSalVentasSuministro, True, 'Resumen Ventas Por Suministro', '');
  ConfigurarOpcion(  mnuSalVentasBruto, DMConfig.EsLaFont, 'Listado de Ventas Bruto', '');
  ConfigurarOpcion(  mnuSalVentasSemanal, DMConfig.EsLaFont, 'Listado de Ventas Semanal', '');
  ConfigurarOpcion(  mnuSalVentasPais, DMConfig.EsLaFont, 'Listado de Ventas por Pa?s', '');
  ConfigurarOpcion(  mnuSalVentasMensuales, DMConfig.EsLaFont, 'Informe de Importes de Ventas Mensuales', '');
  ConfigurarOpcion(  mnuSalComparativaVentas, DMConfig.EsLaFont, 'Comparativa Semanal de Ventas (Bruto)', '');
  ConfigurarOpcion(  mnuSalFacturasAlbaran, DMConfig.EsLaFont, 'Listado Facturas Albar?n', '');
  ConfigurarOpcion(  mnuSalSalidasFactura, DMConfig.EsLaFont , 'Listado Salidas por N?mero de Factura', '');
  ConfigurarOpcion(  mnuSalCuentaVentasSinFacturar, DMConfig.EsLaFont, 'Listado de Cuenta de Ventas - Sin Facturar', '');
  ConfigurarOpcion(  mnuSalCuentaVentasfacturadas, DMConfig.EsLaFont, 'Listado de Cuenta de Ventas - Facturadas', '');

  ConfigurarOpcion(  mnuSalSepFOB, DMConfig.EsLaFont, '-', 'Listados FOB');
  ConfigurarOpcion(  mnuSalFOBTabla, DMConfig.EsLaFont, 'Tabla Ventas FOB', '');
  ConfigurarOpcion(  mnuSalResumenFOB, DMConfig.EsLaFont, 'Resumen Salidas FOB', '');

  ConfigurarOpcion(  mnuSalFOBCliente, DMConfig.EsLaFont, 'Resumen Semanal de Ventas FOB por Cliente', '');
  ConfigurarOpcion(  mnuSalFOBEnvases, DMConfig.EsLaFont, 'Resumen Ventas FOB Campo', '');
  ConfigurarOpcion(  mnuSalFOBCalibres, DMConfig.EsLaFont, 'Resumen Ventas FOB por Calibre', '');
  ConfigurarOpcion(  mnuSalPromedioVentasProduccion, DMConfig.EsLaFont, 'Promedio Ventas Neto Producci?n', '');

  ConfigurarOpcion(  mnuSalInformeIntrastat, DMConfig.EsLaFont, 'Informe Intrastat', '');

  ConfigurarOpcion(  mnuSalSepDUA, DMConfig.EsLaFont , '-', 'D.U.A.');
  ConfigurarOpcion(  mnuSalAsignarDUA, DMConfig.EsLaFont , 'Asignar D.U.A.', '');

  ConfigurarOpcion(  mnuSalSepParaMercadona, DMConfig.EsLaFont, '-', 'Para Mercadona');
  ConfigurarOpcion(  mnuSalListadoMercadona, DMConfig.EsLaFont, 'Salidas por Centro Suministro', '');

end;

procedure TFPrincipal.mnuSalidasClick(Sender: TObject);
begin
  CUAMenuSalidas.EjecutarMenuSalidas( Self, TMenuItem( Sender ).Name );
end;

procedure TFPrincipal.ConfigurarMenuFacturacion;
var
  bPuedoFacturar: Boolean;
  bPuedoContabilizar: Boolean;
begin
  bPuedoContabilizar := GetUsuarioContable;
  bPuedoFacturar:= ( DMConfig.EsLaFont ) and
                   ( Uppercase( gsCodigo ) <> 'F17BAG' ) and
                   ( Uppercase( gsCodigo ) <> 'F18BAG' ) and
                   ( Uppercase( gsCodigo ) <> 'F23BAG' ) and
                   ( Uppercase( gsCodigo ) <> 'F24BAG' ) and
                   ( not gbAlmacen );
  ConfigurarOpcion(  mnuFacturacion, bPuedoFacturar, '&Facturaci?n', '');

  ConfigurarOpcion(  mnuFacSepFacturas, bPuedoFacturar, '-', 'Facturas y Abonos');

  ConfigurarOpcion(  mnuManFacturas, bPuedoFacturar, 'Mantenimiento de Facturas', '');
  ConfigurarOpcion(  mnuProformaFac, bPuedoFacturar, 'Factura Informativa/Proforma', '');
  ConfigurarOpcion(  mnuProcFacturacion, bPuedoFacturar, 'Facturaci?n Autom?tica', '');
  ConfigurarOpcion(  mnuRepFacturacion, bPuedoFacturar , 'Repetici?n Facturas', '');
  ConfigurarOpcion(  mnuFacturarEdi, bPuedoFacturar, 'Fichero Facturas/Abonos EDI', '');
  ConfigurarOpcion(  mnuContFacturas, bPuedoFacturar and bPuedoContabilizar and gbEscritura, 'Contabilizaci?n de Facturas', '');
  ConfigurarOpcion(  mnuMarcaContable, bPuedoFacturar and bPuedoContabilizar and gbEscritura, 'Marcar / Desmarcar Contabilizadas', '');
  ConfigurarOpcion(  mnuFacSinContablizarX3, bPuedoFacturar, 'Facturas Pendientes de Contablizar en X3 ', '');
  ConfigurarOpcion(  mnuAnuFacturas, bPuedoFacturar , 'Anulaci?n de Facturas', '');

  ConfigurarOpcion(  mnuFacSepFacturasPlus, bPuedoFacturar, '-', '');
  ConfigurarOpcion(  mnuFacListadoVentasPeriodo, bPuedoFacturar, 'Listado Ventas Periodo', '');
  ConfigurarOpcion(  mnuFacLisFacturas, bPuedoFacturar, 'Listado Facturas', '');
  ConfigurarOpcion(  mnuFacLisAbonosDetalle, bPuedoFacturar, 'Listado Detalle Abonos', '');
  ConfigurarOpcion(  mnuFacAlbaranesFactura, bPuedoFacturar, 'Albaranes Factura', '') ;
  ConfigurarOpcion(  mnuFacFacturasCliente, bPuedoFacturar, 'Facturas Por Cliente', '');
  ConfigurarOpcion(  mnuFacNotificacionCredito, bPuedoFacturar, 'Notificaci?n de Cr?dito', '');
  ConfigurarOpcion(  mnuFacFacturasSuministro, bPuedoFacturar, 'Facturacion por Centros de Suministro', '');
  ConfigurarOpcion(  mnuFacAlbaranesSinFacturar, bPuedoFacturar, 'Albaranes Pendientes de Facturar \ Valorar', '');
  ConfigurarOpcion(  mnuFacAlbaranesFacturadosEn, bPuedoFacturar, 'Albaranes Pendientes de Facturar a Fecha ', '');
  ConfigurarOpcion(  mnuFacProductoSinFacturar, bPuedoFacturar, 'Producto Pendiente de Facturar', '');
  ConfigurarOpcion(  mnuFacParaAnticipar, bPuedoFacturar, 'Facturas Para Anticipar', '');
  ConfigurarOpcion(  mnuFacFacturasSinCobrar, bPuedoFacturar, 'Facturas Pendientes de Cobrar', '');
  ConfigurarOpcion(  mnuFacAging, bPuedoFacturar, 'Aging', '');

  ConfigurarOpcion(  mnuFacSepRemesas, bPuedoFacturar, '-', 'Remesas de Cobro');
  ConfigurarOpcion(  mnuManRemesas, bPuedoFacturar , 'Grabacion de Remesa', '');  
  ConfigurarOpcion(  mnuFacListadoRemesas, bPuedoFacturar, 'Listado de Remesas', '');
  ConfigurarOpcion(  mnuFacListadoResemasBanco, bPuedoFacturar, 'Listado de Remesas de Cobro', '');
  ConfigurarOpcion(  mnuFacRiesgoCliente, bPuedoFacturar, 'Riesgo del Cliente', '');
  ConfigurarOpcion(  mnuFacEstadoCobroCliente, bPuedoFacturar, 'Estado de Cobro de Clientes', '');
  ConfigurarOpcion(  mnuFacDiasMediosPagoClientes, bPuedoFacturar, 'Dias Medios de Pago Clientes', '');
  ConfigurarOpcion(  mnuFacSaldoPendienteCobro, bPuedoFacturar, 'Saldo Cliente - Pendiente Cobro', '');

end;

procedure TFPrincipal.mnuFacturacionClick(Sender: TObject);
begin
  CUAMenuFacturacion.EjecutarMenuFacturacion( Self, TMenuItem( Sender ).Name );
end;


procedure TFPrincipal.ConfigurarMenuTransmision;
begin
  ConfigurarOpcion(  mnuDatosTransmision, not DMConfig.EsLaFont, 'Tra&nsmisi?n', '');

  ConfigurarOpcion(  mnuDatSepInicial, True, '-', 'Diario');
  ConfigurarOpcion(  mnuDatPedidos, True, 'Pedidos', '');
  ConfigurarOpcion(  mnuDatSalidas, True, 'Salidas', '');
  ConfigurarOpcion(  mnuDatTransitos, True, 'Tr?nsitos', '');
  ConfigurarOpcion(  mnuDatControlEnviodeAlbaranes, True, 'Control Envio de Albaranes', '');
                                                                  

  ConfigurarOpcion(  mnuDatSepVisible, True, '-', 'Mensual');
  ConfigurarOpcion(  mnuDatCosteEnvase, True, 'Coste Art?culos', '');
end;

procedure TFPrincipal.mnuTransmisionClick(Sender: TObject);
begin
  CUAMenuTransmision.EjecutarMenuTransmision( Self, TMenuItem( Sender ).Name );
end;

procedure TFPrincipal.ConfigurarMenuUtilidades;
begin
  ConfigurarOpcion(  mnuUtilidades, True, '&Utilidades', '');

  ConfigurarOpcion(  mnuUtiSepUtilidades, True, '-', 'Utilidades Varias');
  ConfigurarOpcion(  mnuUtiCalculadora, True, 'Calculadora', '');
  ConfigurarOpcion(  mnuUtiCambioDivisas, DMConfig.EsLaFont, 'Cambio Divisas', '');
  ConfigurarOpcion(  mnuUtiConversionDivisa, DMConfig.EsLaFont, 'Conversi?n Divisas', '');
  ConfigurarOpcion(  mnuUtiEuroConversor, DMConfig.EsLaFont, 'Euro Conversor', '');
  ConfigurarOpcion(  mnuUtiCompruebaGastos, DMConfig.EsLaFont, 'Comprobaci?n de Gastos', '');
  ConfigurarOpcion(  mnuUtiSelectImpresoras, True, 'Seleccion de Impresoras', '');
  ConfigurarOpcion(  mnuUtiSelectCuentaCorreo, DMConfig.EsLaFont, 'Selecci?n Cuenta de Correo', '');
  ConfigurarOpcion(  mnuUtiAdministracion, UpperCase( Copy( gsCodigo, 1, 4 ) ) = 'INFO', 'Administraci?n (INFO)', '');
  ConfigurarOpcion(  mnuUtiAcercaDe, True, 'Acerca de ...', '');
  ConfigurarOpcion(  mnuUtiAux, UpperCase( Copy( gsCodigo, 1, 4 ) ) = 'INFO', 'Programa Auxiliar (INFO) ...', '');

  ConfigurarOpcion(  mnuUtiPlantillas, UpperCase( Copy( gsCodigo, 1, 4 ) ) = 'INFO', 'Plantillas', '');
  ConfigurarOpcion(  mnuUtiPlantillaReportes, UpperCase( Copy( gsCodigo, 1, 4 ) ) = 'INFO', 'Reportes', '');


end;

procedure TFPrincipal.mnuUtilidadesClick(Sender: TObject);

begin
  CUAMenuUtiles.EjecutarMenuUtiles( Self, TMenuItem( Sender ).Name );
end;

procedure TFPrincipal.mnuCierreClick(Sender: TObject);
begin
  //Comprobar EXCEL
  if TMenuItem( Sender ).Name = 'mniValorarStock' then
  begin
    CUAMenucompras.EjecutarMenuCompras( self, 'mnuEntValorarStockProveedor' );
  end
  else
  if TMenuItem( Sender ).Name = 'mniComprasTransito' then
  begin
    //Fruta en transito - DOS LISTADOS
    //Coste de la fruta - otros gastos
    //Indiferente - Sin faCTURA
    CUAMenuCompras.EjecutarMenuCompras( self, 'mnuEntLstGastosEntregas' );
  end
  else
  if TMenuItem( Sender ).Name = 'mniGastosCompras' then
  begin
    //SIN FACTURA o FECHA SUPERIOR A, Dos listados
    //110 -> coste de la fruta
    //Resto de costes
    CUAMenuCompras.EjecutarMenuCompras( self, 'mnuEntLstFacturasProveedorNew' );
  end
  else
  if TMenuItem( Sender ).Name = 'mniGastosTransitos' then
  begin
    //SIN FACTURA
    CUAMenuTransitos.EjecutarMenuTransitos( self, 'mnuTraLisFacGasTransitos' );
  end
  else
  if TMenuItem( Sender ).Name = 'mniGastosSalidas' then
  begin
    //SIN FACTURA - TRANSPORTE
    CUAMenuSalidas.EjecutarMenuSalidas( self, 'mnuSalFacGasVentas' );
  end
  else
  if TMenuItem( Sender ).Name = 'mniVentasPendientesFacturar' then
  begin
    CUAMenuFacturacion.EjecutarMenuFacturacion( Self, 'mnuFacAlbaranesFacturadosEn' );
  end;
end;

procedure TFPrincipal.ACalculadoraExecute(Sender: TObject);
var
  valor: Double;
begin
  ACalculadora.Enabled := false;
  //Se pulso el boton OK
  if (CalculadoraExecute( Valor, Self.Left + 21 , Self.Top + ( Self.Height - 220)  )) then
    //Hay un formulario hijo activo
    if (ActiveMDIChild <> nil) then
      //Hay algun control activo
      if (ActiveMDIChild.ActiveControl <> nil) then
        //Es de texto
        if (ActiveMDIChild.ActiveControl is TBEdit) then
          //Es de Format numerico (Pendiente mejorar componentes)
          if (ActiveMDIChild.ActiveControl as TBEdit).InputType in [itInteger,
            itReal] then
          begin
            if (ActiveMDIChild.ActiveControl as TBEdit).InputType in [itInteger]
              then
              (ActiveMDIChild.ActiveControl as TBEdit).Text := FormatFloat('#0',
                Valor)
            else
              (ActiveMDIChild.ActiveControl as TBEdit).Text :=
                FloatToStr(Valor);
          end;
  ACalculadora.Enabled := true;
end;

procedure TFPrincipal.AConversionDivisasExecute(Sender: TObject);
begin
  with TFDNoEuro.Create(Application) do
  try
    ShowModal;
  finally
    Free;
  end
end;

procedure TFPrincipal.AEuroConversorExecute(Sender: TObject);
var
  aux: string;
begin
  aux := DConversor.Execute(self, Date, 'EUR', 'GBP');
  if ActiveMDIChild <> nil then
  begin
    if ActiveMDIChild.ActiveControl is TBEdit then
    begin
      if Trim(aux) <> '' then
        TBEdit(ActiveMDIChild.ActiveControl).Text := aux;
    end;
  end;
end;

procedure TFPrincipal.mnuManFacturasClick(Sender: TObject);
begin
  CUAMenuFacturacion.EjecutarMenuFacturacion( Self, TMenuItem( Sender ).Name );
end;

end.











