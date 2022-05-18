unit LiqProdVendidoDM;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable, StdCtrls, bMath, Math, Dialogs;

type
  R_KilosEntradas = record
    rKilosPrimera, rKilosSegunda, rKilosTercera, rKilosDestrio, rKilosTotal: Real;
    rmKilosPrimera, rmKilosSegunda, rmKilosTercera, rmKilosDestrio, rmKilosTotal: Real; //Con merma
    rlKilosPrimera, rlKilosSegunda, rlKilosTercera, rlKilosDestrio, rlKilosTotal: Real; //A liquidar

    reKilosPrimera, reKilosSegunda, reKilosTercera, reKilosDestrio, reKilosTotal: Real;
    rtKilosPrimera, rtKilosSegunda, rtKilosTercera, rtKilosDestrio, rtKilosTotal: Real;
    rKilosSeleccionado, rKilosIndustria, rKilosCompras, rKilosAlmacen: Real;
  end;

  R_KilosSalidas = record
    rKilosPrimera, rKilosSegunda, rKilosTercera, rKilosDestrio, rKilosTotal: Real;
  end;

  TDMLiqProdVendido = class(TDataModule)
    kmtSemana: TkbmMemTable;
    dsSemana: TDataSource;
    kmtEntradas: TkbmMemTable;
    kmtSalidas: TkbmMemTable;
    qryNuevoCodigo: TQuery;
    kmtAjuste: TkbmMemTable;
    kmtInOut: TkbmMemTable;
    kmtLiquidaDet: TkbmMemTable;
    qryReportPlanta: TQuery;
    qryReportCos: TQuery;
    qryResumen: TQuery;
    qryALiquidar: TQuery;
    qryTransitoLlanos: TQuery;
    qryTransitoCentral: TQuery;
    qryTransitoMoradas: TQuery;
    dlgSaveFile: TSaveDialog;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    sWarnig, sError: string;

    { Private declarations }
    //Parametros de entrada
    sEmpresa, sCentro, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;
    rCosteComercial, rCosteProduccion, rCosteAdministrativo: Real;
    bDefinitiva: boolean;

    (*
    rfacturados1,rpendientes1,rimporte1,rgastos1: real;
    rfacturados2,rpendientes2,rimporte2,rgastos2: real;
    rfacturados3,rpendientes3,rimporte3,rgastos3: real;
    rfacturados4,rpendientes4,rimporte4,rgastos4: real;
    *)

    function AltaSemana( const AKey, ASemana: string ): integer;
    procedure ModificaSemana( const ACodigo: Integer; const AKilosInEntradas, AKilosInTransitos, AKilosIni, AKilosFin,
                                    AKilosOutSalidas, AKilosOutTransitos, AMerma, AObjetivo, ADisponibles: real );
    //procedure PutTotales1;
    //procedure PutTotales2;
    //procedure PutTotales3;
    //procedure PutTotales4;
    function  NuevoCodigo: integer;


    procedure LiquidarPeridoEx(
                                 const AEmpresa, ACentro, AProducto: string;
                                 const ADesde, AHasta: TDateTime; var VLabel: TLabel);
    procedure PreparaLiquidacion;
    procedure NuevaLineaLiquidacion( const ALinea: Integer );
    (*
    procedure PreparaLiquidacionCat( const ACat: string );
    procedure NuevaLinea;
    procedure AddLineaLiq( const ANuevaEntrada: Boolean );
    *)
    procedure EntradasSalidas;
    procedure AsignarEntradasSalidas;
    procedure AsignarKilosEntradasSalidas( const AKilos: Real );

    procedure ProductosALiquidar(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );

    procedure  SQLResumen(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
    procedure  SQLCosechero(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
    procedure  SQLPlantacion(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
    //procedure ImportesPlantacion;
    procedure  PonerFechaTransito;

    procedure CrearCsv( const ATabla: TkbmMemTable );

  public
    { Public declarations }
    bSoloAjuste: boolean;
    bUsarPresupuesto: boolean;

    procedure AbrirTablas;
    procedure AddWarning( const AMsg: string );
    procedure AddError( const AMsg: string );

    procedure LiquidarPerido(const AEmpresa, ACentro, AProducto: string;
                             const ADesde, AHasta: TDateTime;
                             const AComercial, AProduccion, AAdministrativo: Real;
                             const AUsarPresupuesto, ADefinitiva: boolean; var VLabel: TLabel);
    procedure AjustarPerido(const AEmpresa, ACentro, AProducto: string;
                             const ADesde, AHasta: TDateTime; var VLabel: TLabel);

    procedure ImprimirResumenSeparados(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime; const AVerFacturado: boolean );
    procedure ImprimirCosSeparados(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
    procedure ImprimirPlaSeparados(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
    procedure ImprimirResumenJuntos(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime; const AFacturado: boolean );
    procedure ImprimirCosJuntos(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
    procedure ImprimirPlaJuntos(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
    procedure ImprimirALiquidar(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
  end;



var
  DMLiqProdVendido: TDMLiqProdVendido;

implementation

{$R *.dfm}

uses
  DateUtils, bTimeUtils, LiqProdVendidoEntradasDM, Forms,
  LiqProdVendidoBDDatosDM, LiqProdVendidoSalidasDM, Variants,
  LiqProdVendidoPlanQR, LiqProdVendidoCosQR, LiqProdVendidoResumenQR,
  LiqProdALiquidarQR, LiqProdVendidoTransitosDM, LiqProdInfLiquidacionQR,
  LiqProdVendidoResumenDM, UDMConfig, LiqProdErroresUnit;

procedure TDMLiqProdVendido.AddWarning( const AMsg: string );
begin
  if sWarnig <> '' then
    sWarnig := sWarnig + #13 + #10 + AMsg
  else
    sWarnig := AMsg;
end;


procedure TDMLiqProdVendido.AddError( const AMsg: string );
begin
  if sError <> '' then
    sError := sError + #13 + #10 + AMsg
  else
    sError := AMsg;
end;

procedure TDMLiqProdVendido.DataModuleDestroy(Sender: TObject);
begin
  kmtEntradas.Close;
  kmtSalidas.Close;
  kmtInOut.Close;
  kmtSemana.Close;
  kmtLiquidaDet.Close;

  FreeAndNil( DMLiqProdVendidoEntradas );
  FreeAndNil( DMLiqProdVendidoSalidas );
  FreeAndNil( DMLiqProdVendidoTransitos );
  FreeAndNil( DMLiqProdVendidoResumen );

  LiqProdErroresUnit.FinalizaMotorErrores;
end;

procedure TDMLiqProdVendido.DataModuleCreate(Sender: TObject);
begin
  DMLiqProdVendidoEntradas:= TDMLiqProdVendidoEntradas.Create( self );
  DMLiqProdVendidoSalidas:= TDMLiqProdVendidoSalidas.Create( self );
  DMLiqProdVendidoTransitos:= TDMLiqProdVendidoTransitos.Create( self );
  DMLiqProdVendidoResumen:= TDMLiqProdVendidoResumen.Create( self );

  kmtSemana.FieldDefs.Clear;
  kmtSemana.FieldDefs.Add('codigo', ftInteger, 0, False);
  kmtSemana.FieldDefs.Add('hay_errores', ftInteger, 0, False);
  kmtSemana.FieldDefs.Add('keySem', ftString, 15, False);
  kmtSemana.FieldDefs.Add('empresa', ftString, 3, False);
  kmtSemana.FieldDefs.Add('centro', ftString, 3, False);
  kmtSemana.FieldDefs.Add('producto', ftString, 3, False);
  kmtSemana.FieldDefs.Add('semana', ftString, 6, False);
  kmtSemana.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  kmtSemana.FieldDefs.Add('fecha_fin', ftDate, 0, False);
  kmtSemana.FieldDefs.Add('fecha_calculo', ftDate, 0, False);
  kmtSemana.FieldDefs.Add('hora_calculo', ftString, 5, False);

  kmtSemana.FieldDefs.Add('precio_coste_comercial', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('precio_coste_produccion', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('precio_coste_administracion', ftFloat, 0, False);

  kmtSemana.FieldDefs.Add('kilos_iniciales', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('kilos_entrada_campo', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('kilos_entrada_transito', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('kilos_finales', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('kilos_salida_venta', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('kilos_salida_transito', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('kilos_merma', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('porcentaje_merma', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('kilos_objetivo', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('kilos_disponibles', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('porcentaje_disponibles', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('kilos_facturados', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('porcentaje_facturado', ftFloat, 0, False);

  kmtSemana.FieldDefs.Add('facturados1', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('pendientes1', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('porcentaje1', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('importe1', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('gastos1', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('liquido1', ftFloat, 0, False);

  kmtSemana.FieldDefs.Add('facturados2', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('pendientes2', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('porcentaje2', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('importe2', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('gastos2', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('liquido2', ftFloat, 0, False);

  kmtSemana.FieldDefs.Add('facturados3', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('pendientes3', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('porcentaje3', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('importe3', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('gastos3', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('liquido3', ftFloat, 0, False);

  kmtSemana.FieldDefs.Add('facturados4', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('pendientes4', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('porcentaje4', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('importe4', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('gastos4', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('liquido4', ftFloat, 0, False);


  kmtSemana.IndexFieldNames:= 'codigo';
  kmtSemana.CreateTable;

  kmtLiquidaDet.FieldDefs.Clear;
  kmtLiquidaDet.FieldDefs.Add('codigo_liq', ftInteger, 0, False);
  kmtLiquidaDet.FieldDefs.Add('linea_liq', ftInteger, 0, False);

  kmtLiquidaDet.FieldDefs.Add('empresa_ent', ftString, 3, False);
  kmtLiquidaDet.FieldDefs.Add('centro_ent', ftString, 3, False);
  kmtLiquidaDet.FieldDefs.Add('n_entrada', ftInteger, 0, False);
  kmtLiquidaDet.FieldDefs.Add('fecha_ent', ftDate, 0, False);
  kmtLiquidaDet.FieldDefs.Add('hora_ent', ftInteger, 0, False);

  kmtLiquidaDet.FieldDefs.Add('producto_ent', ftString, 3, False);
  kmtLiquidaDet.FieldDefs.Add('origen_ent', ftString, 1, False);
  kmtLiquidaDet.FieldDefs.Add('cosechero_ent', ftInteger, 0, False);
  kmtLiquidaDet.FieldDefs.Add('plantacion_ent', ftInteger, 0, False);
  kmtLiquidaDet.FieldDefs.Add('semana_planta_ent', ftString, 6, False);
  kmtLiquidaDet.FieldDefs.Add('centro_origen_ent', ftString, 3, False);
  kmtLiquidaDet.FieldDefs.Add('fecha_origen_ent', ftDate, 0, False);

  kmtLiquidaDet.FieldDefs.Add('tipo_ent', ftInteger, 0, False);
  kmtLiquidaDet.FieldDefs.Add('categoria_ent', ftString, 1, False);
  kmtLiquidaDet.FieldDefs.Add('kilos_ent', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('kilos_net', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('kilos_aux_ent', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('kilos_aux_net', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('kilos_aux_liq', ftFloat, 0, False);

  kmtLiquidaDet.FieldDefs.Add('origen_sal', ftString, 1, False);

  kmtLiquidaDet.FieldDefs.Add('empresa_tra', ftString, 3, False);
  kmtLiquidaDet.FieldDefs.Add('centro_tra', ftString, 3, False);
  kmtLiquidaDet.FieldDefs.Add('n_transito', ftInteger, 0, False);
  kmtLiquidaDet.FieldDefs.Add('fecha_tra', ftDate, 0, False);
  kmtLiquidaDet.FieldDefs.Add('hora_tra', ftInteger, 0, False);

  kmtLiquidaDet.FieldDefs.Add('empresa_sal', ftString, 3, False);
  kmtLiquidaDet.FieldDefs.Add('centro_sal', ftString, 3, False);
  kmtLiquidaDet.FieldDefs.Add('n_salida', ftInteger, 0, False);
  kmtLiquidaDet.FieldDefs.Add('fecha_sal', ftDate, 0, False);
  kmtLiquidaDet.FieldDefs.Add('hora_sal', ftInteger, 0, False);
  kmtLiquidaDet.FieldDefs.Add('facturado_sal', ftInteger, 0, False);

  kmtLiquidaDet.FieldDefs.Add('envase_sal', ftString, 9, False);

  kmtLiquidaDet.FieldDefs.Add('kilos_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('cajas_liq', ftInteger, 0, False);
  kmtLiquidaDet.FieldDefs.Add('importe_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('descuentos_fac_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('gastos_fac_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('descuentos_nofac_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('gastos_nofac_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('gastos_transito_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('costes_envasado_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('costes_sec_transito_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('costes_abonos_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('costes_financiero_liq', ftFloat, 0, False);
  kmtLiquidaDet.FieldDefs.Add('liquido_liq', ftFloat, 0, False);

  kmtLiquidaDet.MasterSource:= dsSemana;
  kmtLiquidaDet.MasterFields:= 'codigo';
  kmtLiquidaDet.DetailFields:= 'codigo_liq';

  kmtLiquidaDet.CreateTable;

  //Tablas de apoyo

  kmtEntradas.FieldDefs.Clear;
  kmtEntradas.FieldDefs.Add('codigo_ent', ftInteger, 0, False);
  kmtEntradas.FieldDefs.Add('linea_ent', ftInteger, 0, False);
  kmtEntradas.FieldDefs.Add('empresa_ent', ftString, 3, False);
  kmtEntradas.FieldDefs.Add('centro_ent', ftString, 3, False);
  kmtEntradas.FieldDefs.Add('origen_ent', ftString, 1, False); //E: entrada - T:Transito
  kmtEntradas.FieldDefs.Add('n_entrada', ftInteger, 0, False);
  kmtEntradas.FieldDefs.Add('fecha_ent', ftDate, 0, False);
  kmtEntradas.FieldDefs.Add('hora_ent', ftInteger, 0, False);
  kmtEntradas.FieldDefs.Add('producto_ent', ftString, 3, False);
  kmtEntradas.FieldDefs.Add('cosechero_ent', ftInteger, 0, False);
  kmtEntradas.FieldDefs.Add('plantacion_ent', ftInteger, 0, False);
  kmtEntradas.FieldDefs.Add('semana_planta_ent', ftString, 6, False);
  kmtEntradas.FieldDefs.Add('centro_origen_ent', ftString, 3, False);
  kmtEntradas.FieldDefs.Add('fecha_origen_ent', ftDate, 0, False);
  kmtEntradas.FieldDefs.Add('tipo_ent', ftInteger, 0, False); //0: normal 1:Seleccionado 2:Industria 3:Compras 4:Transito
  kmtEntradas.FieldDefs.Add('envase_ent', ftString, 9, False);
  kmtEntradas.FieldDefs.Add('categoria_ent', ftString, 1, False);
  kmtEntradas.FieldDefs.Add('kilos_ent', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_ent_net', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_ent_liq', ftFloat, 0, False);

  kmtEntradas.IndexFieldNames:= 'codigo_ent;linea_ent';
  kmtEntradas.MasterSource:= dsSemana;
  kmtEntradas.MasterFields:= 'codigo';
  kmtEntradas.DetailFields:= 'codigo_ent';
  kmtEntradas.CreateTable;

  kmtSalidas.FieldDefs.Clear;
  kmtSalidas.FieldDefs.Add('codigo_sal', ftInteger, 0, False);
  kmtSalidas.FieldDefs.Add('linea_sal', ftInteger, 0, False);
  kmtSalidas.FieldDefs.Add('empresa_sal', ftString, 3, False);
  kmtSalidas.FieldDefs.Add('centro_sal', ftString, 3, False);
  kmtSalidas.FieldDefs.Add('origen_sal', ftString, 1, False); //V: entrada - T:Transito - B:Botado/Retirada/Destruccion/Placero B
  kmtSalidas.FieldDefs.Add('n_salida', ftInteger, 0, False);
  kmtSalidas.FieldDefs.Add('fecha_sal', ftDate, 0, False);
  kmtSalidas.FieldDefs.Add('hora_sal', ftInteger, 0, False);
  kmtSalidas.FieldDefs.Add('facturado_sal', ftInteger, 0, False);
  kmtSalidas.FieldDefs.Add('producto_sal', ftString, 3, False);
  kmtSalidas.FieldDefs.Add('destino_sal', ftString, 3, False);  //cliente/centro
  kmtSalidas.FieldDefs.Add('envase_sal', ftString, 9, False);
  kmtSalidas.FieldDefs.Add('categoria_sal', ftString, 1, False);
  kmtSalidas.FieldDefs.Add('kilos_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('cajas_sal', ftInteger, 0, False);
  kmtSalidas.FieldDefs.Add('importe_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('descuentos_fac_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('gastos_fac_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('descuentos_nofac_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('gastos_nofac_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('gastos_transito_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('costes_envasado_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('costes_sec_transito_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('costes_abonos_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('costes_financiero_sal', ftFloat, 0, False);
  kmtSalidas.FieldDefs.Add('liquido_sal', ftFloat, 0, False);

  kmtSalidas.IndexFieldNames:= 'codigo_sal;linea_sal';
  kmtSalidas.MasterSource:= dsSemana;
  kmtSalidas.MasterFields:= 'codigo';
  kmtSalidas.DetailFields:= 'codigo_sal';
  kmtSalidas.CreateTable;

  kmtInOut.FieldDefs.Clear;
  kmtInOut.FieldDefs.Add('codigo', ftInteger, 0, False);
  kmtInOut.FieldDefs.Add('linea_ent', ftInteger, 0, False);
  kmtInOut.FieldDefs.Add('linea_sal', ftInteger, 0, False);
  kmtInOut.FieldDefs.Add('kilos', ftInteger, 0, False);
  kmtInOut.IndexFieldNames:= 'codigo;linea_ent';
  kmtInOut.MasterSource:= dsSemana;
  kmtInOut.MasterFields:= 'codigo';
  kmtInOut.DetailFields:= 'codigo';
  kmtInOut.CreateTable;

  kmtAjuste.FieldDefs.Clear;
  kmtAjuste.FieldDefs.Add('codigo_ent', ftInteger, 0, False);
  kmtAjuste.FieldDefs.Add('empresa_ent', ftString, 3, False);
  kmtAjuste.FieldDefs.Add('centro_ent', ftString, 3, False);
  kmtAjuste.FieldDefs.Add('n_entrada', ftInteger, 0, False);
  kmtAjuste.FieldDefs.Add('fecha_ent', ftDate, 0, False);
  kmtAjuste.FieldDefs.Add('cosechero_ent', ftInteger, 0, False);
  kmtAjuste.FieldDefs.Add('plantacion_ent', ftInteger, 0, False);
  kmtAjuste.FieldDefs.Add('semana_planta_ent', ftString, 6, False);
  kmtAjuste.FieldDefs.Add('kilos', ftFloat, 0, False);

  kmtAjuste.FieldDefs.Add('origen_ent', ftString, 1, False); //E: entrada - T:Transito
  kmtAjuste.FieldDefs.Add('hora_ent', ftInteger, 0, False);
  kmtAjuste.FieldDefs.Add('producto_ent', ftString, 3, False);
  kmtAjuste.FieldDefs.Add('centro_origen_ent', ftString, 3, False);
  kmtAjuste.FieldDefs.Add('fecha_origen_ent', ftDate, 0, False);
  kmtAjuste.FieldDefs.Add('tipo_ent', ftInteger, 0, False); //0: normal 1:Seleccionado 2:Industria 3:Compras 4:Transito
  kmtAjuste.FieldDefs.Add('envase_ent', ftString, 9, False);
  kmtAjuste.FieldDefs.Add('categoria_ent', ftString, 1, False);
  kmtAjuste.CreateTable;


  //Querys

  qryNuevoCodigo.SQL.Clear;
  qryNuevoCodigo.SQL.Add('select max(codigo) codigo from tliq_semanas ');

  LiqProdErroresUnit.InicializaMotorErrores;

end;


procedure TDMLiqProdVendido.ImprimirALiquidar(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  ProductosALiquidar( AEmpresa, ACentro, AProducto, ADesde, AHasta );
  qryALiquidar.Open;
  try
    if not qryALiquidar.IsEmpty then
    begin
      LiqProdALiquidarQR.Imprimir( ADesde, AHasta );
    end
    else
    begin
      ShowMessage('No hay entradas de frutas y/o hortalizas grabadas en el periodo seleccionado.');
    end;
  finally
    qryALiquidar.Close;
  end;
end;


procedure TDMLiqProdVendido.ProductosALiquidar(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  qryALiquidar.SQL.Clear;
  //qryALiquidar.SQL.Add(' select empresa_ec empresa, centro_ec centro, producto_ec producto ');
  //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
  qryALiquidar.SQL.Add(' select empresa_ec empresa, centro_ec centro, ( case when producto_ec = ''TOM'' then ''TOM'' else producto_ec end ) producto ');
  qryALiquidar.SQL.Add(' from frf_entradas_c ');
  qryALiquidar.SQL.Add('   join frf_entradas2_l on  empresa_ec = empresa_e2l ');
  qryALiquidar.SQL.Add('   		  and centro_ec = centro_e2l                   ');
  qryALiquidar.SQL.Add('   		  and numero_entrada_ec = numero_entrada_e2l   ');
  qryALiquidar.SQL.Add('        and fecha_ec = fecha_e2l                     ');
  qryALiquidar.SQL.Add('   		  and (cosechero_e2l <> 0 or plantacion_e2l <> 999) ');
  if AEmpresa = 'SAT' then
    qryALiquidar.SQL.Add(' where empresa_ec in ( ''050'',''080'' ) ')
  else
    qryALiquidar.SQL.Add(' where empresa_ec = :empresa ');
  qryALiquidar.SQL.Add(' and fecha_ec between :fechaini and :fechafin ');
  if ACentro <> '' then
    qryALiquidar.SQL.Add(' and centro_ec = :centro ');
  if AProducto <> '' then
    //qryALiquidar.SQL.Add(' and producto_ec = :producto ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    qryALiquidar.SQL.Add(' and ( case when producto_ec = ''TOM'' then ''TOM'' else producto_ec end ) = :producto ');
  qryALiquidar.SQL.Add(' group by empresa, centro, producto ');
  qryALiquidar.SQL.Add(' union ');
  //qryALiquidar.SQL.Add(' select empresa_tc empresa, centro_destino_tc centro, producto_tl producto ');
  //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
  qryALiquidar.SQL.Add(' select empresa_tc empresa, centro_destino_tc centro, ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) producto ');
  qryALiquidar.SQL.Add(' from frf_transitos_c ');
  qryALiquidar.SQL.Add('      join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl and ');
  qryALiquidar.SQL.Add('                           referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
  if AEmpresa = 'SAT' then
    qryALiquidar.SQL.Add(' where empresa_tc in ( ''050'',''080'' ) ')
  else
    qryALiquidar.SQL.Add(' where empresa_tc = :empresa ');
  qryALiquidar.SQL.Add(' and nvl(fecha_entrada_tc, fecha_tc) between :fechaini and :fechafin ');
  if ACentro <> '' then
    qryALiquidar.SQL.Add(' and centro_destino_tc = :centro ');
  if AProducto <> '' then
    //qryALiquidar.SQL.Add(' and producto_tl = :producto ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    qryALiquidar.SQL.Add(' and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto ');
  qryALiquidar.SQL.Add(' group by empresa, centro, producto ');

// Carmen
{
  qryALiquidar.SQL.Add('   union ');

  qryALiquidar.SQL.Add(' select  empresa_ic empresa, centro_ic centro, ( case when producto_ic = ''E'' then ''T'' else producto_ic end ) producto ');
  qryALiquidar.SQL.Add('  from frf_inventarios_c ');
  qryALiquidar.SQL.Add(' left join frf_inventarios_l on empresa_ic = empresa_il and centro_ic = centro_il and producto_ic = producto_il and fecha_ic = fecha_il ');
  qryALiquidar.SQL.Add(' where empresa_ic = :empresa ');
  if ACentro <> '' then
    qryALiquidar.SQL.Add(' and centro_ic = :centro ');
  if AProducto <> '' then
    qryALiquidar.SQL.Add(' and ( case when producto_ic = ''E'' then ''T'' else producto_ic end ) = :producto ');

    qryALiquidar.SQL.Add(' and fecha_ic = :fecha ');
    qryALiquidar.SQL.Add(' and (nvl(kilos_cec_ic,0) + ');
    qryALiquidar.SQL.Add('     nvl(kilos_cim_c1_ic,0) + nvl(kilos_cia_c1_ic,0) + ');
    qryALiquidar.SQL.Add('     nvl(kilos_cim_c2_ic,0) + nvl(kilos_cia_c2_ic,0) + ');
    qryALiquidar.SQL.Add('     nvl(kilos_zd_c3_ic,0) + ');
    qryALiquidar.SQL.Add('     nvl(kilos_zd_d_ic,0) + nvl(kilos_ce_c1_il,0) + nvl(kilos_ce_c2_il,0) ) <> 0 ');
}
 //
  qryALiquidar.SQL.Add(' order by empresa, centro, producto ');

  if AEmpresa <> 'SAT' then
    qryALiquidar.ParamByName('empresa').AssTRING:= AEmpresa;
  qryALiquidar.ParamByName('fechaini').AsDateTime := ADesde;
  qryALiquidar.ParamByName('fechafin').AsDateTime := AHasta;
//  qryALiquidar.ParamByName('fecha').AsDateTime:= ( ADesde - 1 );
  if ACentro <> '' then
    qryALiquidar.ParamByName('centro').AssTRING:= ACentro;
  if AProducto <> '' then
    qryALiquidar.ParamByName('producto').AssTRING:= AProducto;

end;

procedure TDMLiqProdVendido.AbrirTablas;
begin
  if kmtSemana.Active then
    kmtSemana.Close;
  if kmtInOut.Active then
    kmtInOut.Close;
  if kmtEntradas.Active then
    kmtEntradas.Close;
  if kmtSalidas.Active then
    kmtSalidas.Close;
  if kmtLiquidaDet.Active then
    kmtLiquidaDet.Close;

  kmtSemana.Open;
  kmtInOut.Open;
  kmtEntradas.Open;
  kmtSalidas.Open;
  kmtLiquidaDet.Open;

  (*
  rfacturados1:= 0;
  rpendientes1:= 0;
  rimporte1:= 0;
  rgastos1:= 0;
  rfacturados2:= 0;
  rpendientes2:= 0;
  rimporte2:= 0;
  rgastos2:= 0;
  rfacturados3:= 0;
  rpendientes3:= 0;
  rimporte3:= 0;
  rgastos3:= 0;
  rfacturados4:= 0;
  rpendientes4:= 0;
  rimporte4:= 0;
  rgastos4:= 0;
  *)
end;

procedure TDMLiqProdVendido.LiquidarPerido(
                             const AEmpresa, ACentro, AProducto: string;
                             const ADesde, AHasta: TDateTime;
                             const AComercial, AProduccion, AAdministrativo: Real;
                             const AUsarPresupuesto, ADefinitiva: boolean; var VLabel: TLabel);
var
  sKeyLiq: string;
begin
  sWarnig:= '';
  sError:= '';
  rCosteComercial:= AComercial;
  rCosteProduccion:= AProduccion;
  rCosteAdministrativo:= AAdministrativo;
  bDefinitiva:= ADefinitiva;
  bUsarPresupuesto:= AUsarPresupuesto;
  bSoloAjuste:= False;

  PonerFechaTransito;
  ProductosALiquidar( AEmpresa, ACentro, AProducto, ADesde, AHasta );
  qryALiquidar.Open;
  try
    if not qryALiquidar.IsEmpty then
    begin
      //sKeyLiq:= '';
      while not qryALiquidar.Eof do
      begin
        //if sKeyLiq <> ( qryALiquidar.FieldByName('empresa').AsString + qryALiquidar.FieldByName('centro').AsString + qryALiquidar.FieldByName('producto').AsString ) then
        //if not qryALiquidar.IsEmpty then
        if AEmpresa = 'SAT' then
          sKeyLiq:= ( 'SAT' + qryALiquidar.FieldByName('centro').AsString + qryALiquidar.FieldByName('producto').AsString )
        else
          sKeyLiq:= ( qryALiquidar.FieldByName('empresa').AsString + qryALiquidar.FieldByName('centro').AsString + qryALiquidar.FieldByName('producto').AsString );
          LiquidarPeridoEx( AEmpresa,
                            qryALiquidar.FieldByName('centro').AsString,
                            qryALiquidar.FieldByName('producto').AsString,
                            ADesde, AHasta, VLabel);
          qryALiquidar.Next;
      end;
    end;
  finally
    qryALiquidar.Close;
  end;
  //transitos
  DMLiqProdVendidoTransitos.AjustarTransitos( AEmpresa, AProducto, ADesde, AHasta );
  DMLiqProdVendidoResumen.CalculoPromedios( AEmpresa, ACentro, AProducto, ADesde, AHasta );
  //ImprimirResumen(AEmpresa, ACentro, AProducto, ADesde, AHasta );
end;


procedure TDMLiqProdVendido.AjustarPerido(
                             const AEmpresa, ACentro, AProducto: string;
                             const ADesde, AHasta: TDateTime; var VLabel: TLabel);
begin
  sWarnig:= '';
  sError:= '';
  bSoloAjuste:= True;

  if DMConfig.EslaFont then
    PonerFechaTransito;
  ProductosALiquidar( AEmpresa, ACentro, AProducto, ADesde, AHasta );
  qryALiquidar.Open;
  try
    if not qryALiquidar.IsEmpty then
    begin
      while not qryALiquidar.Eof do
      begin
        LiquidarPeridoEx( qryALiquidar.FieldByName('empresa').AsString,
                            qryALiquidar.FieldByName('centro').AsString,
                            qryALiquidar.FieldByName('producto').AsString,
                            ADesde, AHasta, VLabel);
        qryALiquidar.Next;
      end;
    end;
  finally
    qryALiquidar.Close;
  end;
end;

procedure TDMLiqProdVendido.LiquidarPeridoEx( const AEmpresa, ACentro, AProducto: string;
                                              const ADesde, AHasta: TDateTime; var VLabel: TLabel);
var
  rKilosSalidas: R_KilosSalidas;
  rKilosEntradas: R_KilosEntradas;
  rKilosOutSalidas, rKilosOutTransitos, rKilosIni, rKilosFin : Real;
  rObjetivo, rMermaAux: real;

  sMsg, sSemana, sKey: string;
  iCount, iCodigo: Integer;
  bTodasLasSemana: Boolean;
  rMerma: Real;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;

  sMsg:= '';
  dFechaIni:= ADesde;
  iCount:= 0;

  while dFechaIni < AHasta do
  begin
    AbrirTablas;

    Application.ProcessMessages;
    dFechaFin:= dFechaIni + 6;
    sSemana:= AnyoSemana( dFechaIni );

    if AEmpresa = 'SAT' then
      sKey:=   'SAT' + sCentro + sProducto + sSemana
    else
      sKey:=   sEmpresa + sCentro + sProducto + sSemana;

    Inc( iCount );
    if DMLiqProdVendido.bSoloAjuste then
      VLabel.caption:= 'Calculo ajuste (' + IntToStr( iCount ) + ') ' + sEmpresa + '/' + sCentro + '/' +  sProducto + '/' +  sSemana
    else
      VLabel.caption:= 'Calculo liquidacion (' + IntToStr( iCount ) + ') ' + sEmpresa + '/' + sCentro + '/' +  sProducto + '/' +  sSemana;
    Application.ProcessMessages;

    iCodigo:= AltaSemana( sKey, sSemana );
    InicializaErrores( iCodigo );

    //Kilos de prdoucto entregado
    rKilosEntradas:= DMLiqProdVendidoEntradas.EntradasSemana( iCodigo, sEmpresa, sCentro, sProducto, sSemana, dFechaIni, dFechaFin );

    //Si no hay kilos entegados no hay kilos a liquidar
    //Kilos en los inevnatrios inicial y final
//    DMLiqProdVendidoEntradas.InventariosSemana( rKilosIni, rKilosFin );

//    if ( rKilosEntradas.rKilosTotal + rKilosIni ) > 0 then
    if ( rKilosEntradas.rKilosTotal ) > 0 then
    begin

      //Si no hay kilos entegados no hay kilos a liquidar
      //Kilos en los inevnatrios inicial y final
      DMLiqProdVendidoEntradas.InventariosSemana( rKilosIni, rKilosFin );

      //Kilos salidos
      DMLiqProdVendidoSalidas.KilosSalidasSemana( sEmpresa, sCentro, sProducto, dFechaIni, dFechaFin, rKilosOutSalidas, rKilosOutTransitos  );

      //Con los kilos entrados, salidos e inventarios calculamos la merma.
      rMerma:=  broundto(( rKilosEntradas.rKilosTotal + rKilosIni ) - ( ( rKilosOutSalidas + rKilosOutTransitos ) + rKilosFin ), 2);
      if rMerma < 0 then
      begin
        rObjetivo:= rKilosEntradas.rKilosTotal;
        rMermaAux:= 0;
      end
      else
      begin
//        if rKilosEntradas.rKilosTotal > 0 then
//        begin
          rObjetivo:= rKilosEntradas.rKilosTotal-rMerma;
          rMermaAux:= rMerma;
//        end
//        else
//        begin
//          rObjetivo:= rKilosIni-rMerma;
//          rMermaAux:= rMerma;
//        end;
      end;

      //Aplicar porcentaje de merma por igual a todas las entradas
      rKilosEntradas:= DMLiqProdVendidoEntradas.AplicarMerma( rMermaAux );

      //Selecciono las salidas para cubrir las entradas memos merma por fecha de salidas
      //Primero descarto las mas recientes hasta limpiar el stock -> primero en salir
      //Despues voy selecionando salidas hasta cubir los  kilos entrados menos merma
      rKilosSalidas:= DMLiqProdVendidoSalidas.SalidasSemana( iCodigo, sEmpresa, sCentro, sProducto, dFechaIni, dFechaFin, rKilosIni, rObjetivo, True );

      //La salidas selecciondas tienen un porcentaje de 1,2,3 y resto, ajustamos porcentajes de las entradas para que coincidan con estos
      rKilosEntradas:= DMLiqProdVendidoEntradas.AjustarEntradas( rKilosSalidas );

      //vamos casando cada kilo de entrada ajustado con una salida, deben de coincidir por el paso anterior, siempre que tengamos fruta de sobra,
      //la que no podamos asiganar debe de estar es su propia categoria sin asignar -> las entradas mas recientes.
      EntradasSalidas;

      // Guardar csv con informacion de tablas temporales
//      CrearCsv(kmtEntradas);
//      CrearCsv(kmtSalidas);
//      CrearCsv(kmtInOut);

      PreparaLiquidacion;

      ModificaSemana( iCodigo, rKilosEntradas.reKilosTotal, rKilosEntradas.rtKilosTotal,
                      rKilosIni, rKilosFin, rKilosOutSalidas, rKilosOutTransitos,
                      rMerma, rObjetivo, rKilosSalidas.rKilosTotal );

      bTodasLasSemana:= False;
      DMLiqProdVendidoBDDatos.SalvaDatos( bTodasLasSemana );
    end
    else
    begin
      //ShowMessage('No hay entradas ni stock inicial.');
    end;
    dFechaIni:= dFechaIni + 7;
  end;
end;

function CsvField( AField: TField ): string;
begin
  if AField.DataType = ftString then
    result:= '"' + AField.AsString + '"'
  else
  if AField.DataType = ftInteger  then
    Result:= AField.AsString
  else
  if AField.DataType = ftFloat  then
    Result:= StringReplace( FormatFloat( '#.#', AField.AsFloat ), ',', '.', [] )
  else
  if ( AField.DataType = ftDate ) or ( AField.DataType = ftDateTime ) then
    Result:= '"' + FormatDateTime( 'dd/mm/yyyy', AField.AsDateTime ) + '"';
end;

procedure TDMLiqProdVendido.CrearCsv( const ATabla: TkbmMemTable );
var
  slCsvFile: TStringList;
  sAux: string;
  i: Integer;
begin
  if dlgSaveFile.Execute then
  begin
    slCsvFile:= TStringList.Create;
    ATabla.First;
    while not ATabla.Eof do
    begin
      i:= 0;
      sAux:= '';
      sAux:= CsvField( ATabla.Fields[i] );
      for i:= 1 to ATabla.FieldCount - 1 do
      begin
        sAux:= sAux + ';' + CsvField( ATabla.Fields[i] );
      end;
      slCsvFile.Add( sAux );
      ATabla.Next;
    end;
    try
      slCsvFile.SaveToFile( dlgSaveFile.FileName );
      ShowMessage('Proceso finalizado correctamente.');
    finally
      FreeAndNil( slCsvFile );
    end;
  end;
end;

function TDMLiqProdVendido.NuevoCodigo: integer;
begin
  qryNuevoCodigo.Open;
  if qryNuevoCodigo.IsEmpty then
     result:= 1
  else
    result:= qryNuevoCodigo.FieldByName('codigo').AsInteger + 1;
  qryNuevoCodigo.Close;
end;

function TDMLiqProdVendido.AltaSemana( const AKey, ASemana: string ): integer;
begin
    kmtSemana.Insert;
    result:= NuevoCodigo;
    kmtSemana.FieldByName('codigo').AsInteger:= result;
    kmtSemana.FieldByName('hay_errores').AsInteger:= 0;
    kmtSemana.FieldByName('keySem').AsString:= AKey;
    kmtSemana.FieldByName('empresa').AsString:= sEmpresa;
    kmtSemana.FieldByName('centro').AsString:= sCentro;
    kmtSemana.FieldByName('producto').AsString:= sProducto;
    kmtSemana.FieldByName('semana').AsString:= ASemana;
    kmtSemana.FieldByName('fecha_ini').AsDateTime:= dFechaIni;
    kmtSemana.FieldByName('fecha_fin').AsDateTime:= dFechaFin;
    kmtSemana.FieldByName('fecha_calculo').AsDateTime:= Now;
    kmtSemana.FieldByName('hora_calculo').AsString:= FormatDatetime( 'hh:nn', Now );

    kmtSemana.FieldByName('precio_coste_comercial').AsFloat:= rCosteComercial;
    kmtSemana.FieldByName('precio_coste_produccion').AsFloat:= rCosteProduccion;
    kmtSemana.FieldByName('precio_coste_administracion').AsFloat:= rCosteAdministrativo;

    kmtSemana.Post;
end;
procedure TDMLiqProdVendido.ModificaSemana( const ACodigo: Integer;
            const AKilosInEntradas, AKilosInTransitos, AKilosIni, AKilosFin,
                  AKilosOutSalidas, AKilosOutTransitos, AMerma, AObjetivo, ADisponibles: real );
begin
  if kmtSemana.Locate('codigo', ACodigo, []) then
  begin
    kmtSemana.Edit;

    kmtSemana.FieldByName('hay_errores').AsInteger:= HayErrores;

    kmtSemana.FieldByName('kilos_iniciales').AsFloat:= AKilosIni;
    kmtSemana.FieldByName('kilos_entrada_campo').AsFloat:= AKilosInEntradas;
    kmtSemana.FieldByName('kilos_entrada_transito').AsFloat:= AKilosInTransitos;
    kmtSemana.FieldByName('kilos_finales').AsFloat:= AKilosFin;
    kmtSemana.FieldByName('kilos_salida_venta').AsFloat:= AKilosOutSalidas;
    kmtSemana.FieldByName('kilos_salida_transito').AsFloat:= AKilosOutTransitos;
    kmtSemana.FieldByName('kilos_merma').AsFloat:= AMerma;
    kmtSemana.FieldByName('kilos_objetivo').AsFloat:= AObjetivo;
    kmtSemana.FieldByName('kilos_disponibles').AsFloat:= ADisponibles;


    if kmtSemana.FieldByName('kilos_objetivo').AsFloat > 0 then
    begin
      kmtSemana.FieldByName('porcentaje_disponibles').AsFloat:= RoundTo( kmtSemana.FieldByName('kilos_disponibles').AsFloat /
                                                                       kmtSemana.FieldByName('kilos_objetivo').AsFloat * 100, -6 );
    end
    else
    begin
      kmtSemana.FieldByName('porcentaje_disponibles').AsFloat:= 0;
    end;

    if ( ( kmtSemana.FieldByName('kilos_entrada_campo').AsInteger + kmtSemana.FieldByName('kilos_entrada_transito').AsInteger )  > 0 ) and
       ( abs( kmtSemana.FieldByName('kilos_merma').AsInteger ) > 0 )  then
    begin
      if ( ( kmtSemana.FieldByName('kilos_iniciales').AsFloat - kmtSemana.FieldByName('kilos_finales').AsFloat ) +
                   ( kmtSemana.FieldByName('kilos_entrada_campo').AsFloat + kmtSemana.FieldByName('kilos_entrada_transito').AsFloat ) ) <> 0 then
        kmtSemana.FieldByName('porcentaje_merma').AsFloat:=
          RoundTo( kmtSemana.FieldByName('kilos_merma').AsFloat /
                   ( ( kmtSemana.FieldByName('kilos_iniciales').AsFloat - kmtSemana.FieldByName('kilos_finales').AsFloat ) +
                     ( kmtSemana.FieldByName('kilos_entrada_campo').AsFloat + kmtSemana.FieldByName('kilos_entrada_transito').AsFloat ) ) * 100,
                   -6 )
      else
        kmtSemana.FieldByName('porcentaje_merma').AsFloat:=0;
    end
    else
    begin
      if abs( kmtSemana.FieldByName('kilos_merma').AsInteger ) > 0 then
        kmtSemana.FieldByName('porcentaje_merma').AsFloat:=  100
      else
        kmtSemana.FieldByName('porcentaje_merma').AsFloat:=  0;

    end;


    (*
    kmtSemana.FieldByName('kilos_facturados').AsFloat:= rfacturados1 + rfacturados2 + rfacturados3 + rfacturados4;
    if kmtSemana.FieldByName('kilos_disponibles').AsFloat > 0 then
    begin
      kmtSemana.FieldByName('porcentaje_facturado').AsFloat:= RoundTo( kmtSemana.FieldByName('kilos_facturados').AsFloat /
                                                                       kmtSemana.FieldByName('kilos_disponibles').AsFloat * 100, -6 );
    end
    else
    begin
      kmtSemana.FieldByName('porcentaje_facturado').AsFloat:= 0;
    end;
    PutTotales1;
    PutTotales2;
    PutTotales3;
    PutTotales4;
    *)


    kmtSemana.Post;
  end;
end;

(*
procedure TDMLiqProdVendido.PutTotales1;
begin
    kmtSemana.FieldByName('facturados1').AsFloat:= rfacturados1;
    kmtSemana.FieldByName('pendientes1').AsFloat:= rpendientes1;
    if ( rfacturados1 + rpendientes1 ) > 0 then
    begin
      kmtSemana.FieldByName('porcentaje1').AsFloat:= RoundTo( rfacturados1 / ( rfacturados1 + rpendientes1 ), -6);
      if rfacturados1 > 0 then
      begin
        kmtSemana.FieldByName('importe1').AsFloat:= RoundTo( rimporte1 / rfacturados1, -4);
        kmtSemana.FieldByName('gastos1').AsFloat:= RoundTo( rgastos1 / rfacturados1, -4 );
        kmtSemana.FieldByName('liquido1').AsFloat:= kmtSemana.FieldByName('importe1').AsFloat - kmtSemana.FieldByName('gastos1').AsFloat;
      end
      else
      begin
        kmtSemana.FieldByName('importe1').AsFloat:= 0;
        kmtSemana.FieldByName('gastos1').AsFloat:= 0;
        kmtSemana.FieldByName('liquido1').AsFloat:= 0;
      end;
    end
    else
    begin
      kmtSemana.FieldByName('porcentaje1').AsFloat:= 0;
      kmtSemana.FieldByName('importe1').AsFloat:= 0;
      kmtSemana.FieldByName('gastos1').AsFloat:= 0;
      kmtSemana.FieldByName('liquido1').AsFloat:= 0;
    end;
end;

procedure TDMLiqProdVendido.PutTotales2;
begin
    kmtSemana.FieldByName('facturados2').AsFloat:= rfacturados2;
    kmtSemana.FieldByName('pendientes2').AsFloat:= rpendientes2;
    if ( rfacturados2 + rpendientes2 ) > 0 then
    begin
      kmtSemana.FieldByName('porcentaje2').AsFloat:= RoundTo( rfacturados2 / ( rfacturados2 + rpendientes2 ), -6);
      if rfacturados2 > 0 then
      begin
        kmtSemana.FieldByName('importe2').AsFloat:= RoundTo( rimporte2 / rfacturados2, -4);
        kmtSemana.FieldByName('gastos2').AsFloat:= RoundTo( rgastos2 / rfacturados2, -4 );
        kmtSemana.FieldByName('liquido2').AsFloat:= kmtSemana.FieldByName('importe2').AsFloat - kmtSemana.FieldByName('gastos2').AsFloat;
      end
      else
      begin
        kmtSemana.FieldByName('importe2').AsFloat:= 0;
        kmtSemana.FieldByName('gastos2').AsFloat:= 0;
        kmtSemana.FieldByName('liquido2').AsFloat:= 0;
      end;
    end
    else
    begin
      kmtSemana.FieldByName('porcentaje2').AsFloat:= 0;
      kmtSemana.FieldByName('importe2').AsFloat:= 0;
      kmtSemana.FieldByName('gastos2').AsFloat:= 0;
      kmtSemana.FieldByName('liquido2').AsFloat:= 0;
    end;
end;

procedure TDMLiqProdVendido.PutTotales3;
begin
    kmtSemana.FieldByName('facturados3').AsFloat:= rfacturados3;
    kmtSemana.FieldByName('pendientes3').AsFloat:= rpendientes3;
    if ( rfacturados3 + rpendientes3 ) > 0 then
    begin
      kmtSemana.FieldByName('porcentaje3').AsFloat:= RoundTo( rfacturados3 / ( rfacturados3 - rpendientes3 ), -6);
      if rfacturados3 > 0 then
      begin
        kmtSemana.FieldByName('importe3').AsFloat:= RoundTo( rimporte3 / rfacturados3, -4);
        kmtSemana.FieldByName('gastos3').AsFloat:= RoundTo( rgastos3 / rfacturados3, -4 );
        kmtSemana.FieldByName('liquido3').AsFloat:= kmtSemana.FieldByName('importe3').AsFloat - kmtSemana.FieldByName('gastos3').AsFloat;
      end
      else
      begin
        kmtSemana.FieldByName('importe3').AsFloat:= 0;
        kmtSemana.FieldByName('gastos3').AsFloat:= 0;
        kmtSemana.FieldByName('liquido3').AsFloat:= 0;
      end;
    end
    else
    begin
      kmtSemana.FieldByName('porcentaje3').AsFloat:= 0;
      kmtSemana.FieldByName('importe3').AsFloat:= 0;
      kmtSemana.FieldByName('gastos3').AsFloat:= 0;
      kmtSemana.FieldByName('liquido3').AsFloat:= 0;
    end;
end;

procedure TDMLiqProdVendido.PutTotales4;
begin
    kmtSemana.FieldByName('facturados4').AsFloat:= rfacturados4;
    kmtSemana.FieldByName('pendientes4').AsFloat:= rpendientes4;
    if ( rfacturados4 + rpendientes4 ) > 0 then
    begin
      kmtSemana.FieldByName('porcentaje4').AsFloat:= RoundTo( rfacturados4 / ( rfacturados4 + rpendientes4 ), -6);
      if rfacturados4 > 0 then
      begin
        kmtSemana.FieldByName('importe4').AsFloat:= RoundTo( rimporte4 / rfacturados4, -4);
        kmtSemana.FieldByName('gastos4').AsFloat:= RoundTo( rgastos4 / rfacturados4, -4 );
        kmtSemana.FieldByName('liquido4').AsFloat:= kmtSemana.FieldByName('importe4').AsFloat - kmtSemana.FieldByName('gastos4').AsFloat;
      end
      else
      begin
        kmtSemana.FieldByName('importe4').AsFloat:= 0;
        kmtSemana.FieldByName('gastos4').AsFloat:= 0;
        kmtSemana.FieldByName('liquido4').AsFloat:= 0;
      end;
    end
    else
    begin
      kmtSemana.FieldByName('porcentaje4').AsFloat:= 0;
      kmtSemana.FieldByName('importe4').AsFloat:= 0;
      kmtSemana.FieldByName('gastos4').AsFloat:= 0;
      kmtSemana.FieldByName('liquido4').AsFloat:= 0;
    end;
end;
*)

procedure TDMLiqProdVendido.EntradasSalidas;
begin
  kmtEntradas.SortFields:= 'codigo_ent;linea_ent';
  kmtSalidas.SortFields:= 'codigo_sal;linea_sal';

  kmtEntradas.Filtered:= True;
  kmtSalidas.Filtered:= True;

  kmtEntradas.Filter:= 'Categoria_ent = ''1'' ';
  kmtSalidas.Filter:= 'Categoria_sal = ''1'' ';
  AsignarEntradasSalidas;

  kmtEntradas.Filter:= 'Categoria_ent = ''2'' ';
  kmtSalidas.Filter:= 'Categoria_sal = ''2'' ';
  AsignarEntradasSalidas;

  kmtEntradas.Filter:= 'Categoria_ent = ''3'' ';
  kmtSalidas.Filter:= 'Categoria_sal = ''3'' ';
  AsignarEntradasSalidas;

  kmtEntradas.Filter:= 'Categoria_ent = ''4'' ';
  kmtSalidas.Filter:= 'Categoria_sal = ''4'' ';
  AsignarEntradasSalidas;

  kmtEntradas.Filtered:= False;
  kmtSalidas.Filtered:= False;

end;

procedure TDMLiqProdVendido.AsignarEntradasSalidas;
var
  rSalida, rEntrada: Real;
begin
  kmtEntradas.Sort([]);
  kmtSalidas.Sort([]);
  kmtEntradas.First;
  kmtSalidas.First;

  rSalida:= 0;
  while  not kmtEntradas.eof do
  begin
    rEntrada:= kmtEntradas.fieldByName('kilos_ent_liq').AsFloat;
    while  not kmtSalidas.eof and ( rEntrada > 0 ) do
    begin
      if rSalida = 0 then
        rSalida:= kmtSalidas.fieldByName('kilos_sal').AsFloat;
      if  rSalida <= rEntrada then
      begin
         rEntrada:= rEntrada - rSalida;
         AsignarKilosEntradasSalidas( rSalida );
         rSalida:= 0;
         kmtSalidas.Next;
      end
      else
      begin
         rSalida:= rSalida - rEntrada;
         AsignarKilosEntradasSalidas( rEntrada );
         rEntrada:= 0;
      end;
    end ;
    kmtEntradas.Next;
  end;
end;

procedure TDMLiqProdVendido.AsignarKilosEntradasSalidas( const AKilos: Real );
begin
  kmtInOut.Insert;
  kmtInOut.FieldByName('codigo').AsInteger:= kmtEntradas.fieldByName('codigo_ent').AsInteger;
  kmtInOut.FieldByName('linea_ent').AsInteger:= kmtEntradas.fieldByName('linea_ent').AsInteger;
  kmtInOut.FieldByName('linea_sal').AsInteger:= kmtSalidas.fieldByName('linea_sal').AsInteger;
  kmtInOut.FieldByName('kilos').AsFloat:= AKilos;
  kmtInOut.Post;
end;


procedure TDMLiqProdVendido.PreparaLiquidacion;
var
  iLinea: Integer;
begin
  kmtInOut.SortFields:= 'codigo;linea_ent;linea_sal';
  kmtInOut.Sort([]);

  kmtInOut.Filter:= '';
  kmtInOut.Filtered:= True;
  kmtSalidas.Filter:= '';
  kmtSalidas.Filtered:= True;

  iLinea:= 0;
  kmtEntradas.First;
  while not kmtEntradas.Eof do
  begin
    kmtInOut.Filter:= 'codigo = ' + kmtEntradas.fieldByName('codigo_ent').AsString + ' and linea_ent = ' + kmtEntradas.fieldByName('linea_ent').AsString;
    kmtInOut.First;
    while not kmtInOut.Eof do
    begin
      kmtSalidas.Filter:= 'codigo_sal = ' + kmtEntradas.fieldByName('codigo_ent').AsString + ' and linea_sal = ' + kmtInOut.fieldByName('linea_sal').AsString;
      Inc( iLinea );
      NuevalIneaLiquidacion( iLinea ) ;
      kmtInOut.Next;
    end;
    kmtEntradas.Next;
  end;

  kmtSalidas.Filtered:= False;
  kmtSalidas.Filter:= '';
  kmtInOut.Filtered:= False;
  kmtInOut.Filter:= '';
end;

procedure TDMLiqProdVendido.NuevaLineaLiquidacion( const ALinea: Integer );
var
  rFactor: Real;
  rGastosAux: Real;
begin
    kmtLiquidaDet.insert;
    kmtLiquidaDet.FieldDefs.Clear;
    kmtLiquidaDet.FieldByName('codigo_liq').AsInteger:= kmtEntradas.fieldByName('codigo_ent').AsInteger;
    kmtLiquidaDet.FieldByName('linea_liq').AsInteger:= ALinea;
    kmtLiquidaDet.FieldByName('fecha_ent').ASdatetime:= kmtEntradas.fieldByName('fecha_ent').ASdatetime;
    kmtLiquidaDet.FieldByName('hora_ent').AsString:= kmtEntradas.fieldByName('hora_ent').AsString;
    kmtLiquidaDet.FieldByName('empresa_ent').AsString:= kmtEntradas.fieldByName('empresa_ent').AsString;
    kmtLiquidaDet.FieldByName('centro_ent').AsString:= kmtEntradas.fieldByName('centro_ent').AsString;
    kmtLiquidaDet.FieldByName('n_entrada').AsInteger:= kmtEntradas.fieldByName('n_entrada').AsInteger;
    kmtLiquidaDet.FieldByName('origen_ent').AsString:= kmtEntradas.fieldByName('origen_ent').AsString;
    kmtLiquidaDet.FieldByName('producto_ent').AsString:= kmtEntradas.fieldByName('producto_ent').AsString;
    kmtLiquidaDet.FieldByName('cosechero_ent').AsInteger:= kmtEntradas.fieldByName('cosechero_ent').AsInteger;
    kmtLiquidaDet.FieldByName('plantacion_ent').AsInteger:= kmtEntradas.fieldByName('plantacion_ent').AsInteger;
    kmtLiquidaDet.FieldByName('semana_planta_ent').AsString:= kmtEntradas.fieldByName('semana_planta_ent').AsString;
    kmtLiquidaDet.FieldByName('centro_origen_ent').AsString:= kmtEntradas.fieldByName('centro_origen_ent').AsString;
    kmtLiquidaDet.FieldByName('fecha_origen_ent').AsString:= kmtEntradas.fieldByName('fecha_origen_ent').AsString;
    kmtLiquidaDet.FieldByName('categoria_ent').AsString:= kmtEntradas.fieldByName('categoria_ent').AsString;
    kmtLiquidaDet.FieldByName('tipo_ent').AsInteger:= kmtEntradas.fieldByName('tipo_ent').AsInteger;
    kmtLiquidaDet.FieldByName('origen_sal').AsString:= kmtSalidas.fieldByName('origen_sal').AsString;
    if kmtSalidas.fieldByName('origen_sal').AsString = 'T' then
    begin
      kmtLiquidaDet.FieldByName('fecha_tra').ASdatetime:= kmtSalidas.fieldByName('fecha_sal').ASdatetime;
      kmtLiquidaDet.FieldByName('hora_tra').AsString:= kmtSalidas.fieldByName('hora_sal').AsString;
      kmtLiquidaDet.FieldByName('empresa_tra').AsString:= kmtSalidas.fieldByName('empresa_sal').AsString;
      kmtLiquidaDet.FieldByName('centro_tra').AsString:= kmtSalidas.fieldByName('centro_sal').AsString;
      kmtLiquidaDet.FieldByName('n_transito').AsInteger:= kmtSalidas.fieldByName('n_salida').AsInteger;
    end
    else
    begin
      kmtLiquidaDet.FieldByName('fecha_sal').ASdatetime:= kmtSalidas.fieldByName('fecha_sal').ASdatetime;
      kmtLiquidaDet.FieldByName('hora_sal').AsString:= kmtSalidas.fieldByName('hora_sal').AsString;
      kmtLiquidaDet.FieldByName('empresa_sal').AsString:= kmtSalidas.fieldByName('empresa_sal').AsString;
      kmtLiquidaDet.FieldByName('centro_sal').AsString:= kmtSalidas.fieldByName('centro_sal').AsString;
      kmtLiquidaDet.FieldByName('n_salida').AsInteger:= kmtSalidas.fieldByName('n_salida').AsInteger;
    end;
    kmtLiquidaDet.FieldByName('facturado_sal').AsInteger:= kmtSalidas.fieldByName('facturado_sal').AsInteger;

    kmtLiquidaDet.FieldByName('envase_sal').AsString:= kmtSalidas.fieldByName('envase_sal').AsString;

    kmtLiquidaDet.FieldByName('kilos_liq').AsInteger:= kmtInOut.fieldByName('kilos').AsInteger;
    if  kmtEntradas.fieldByName('kilos_ent_liq').AsInteger > 0 then
    begin
      rFactor:= kmtInOut.fieldByName('kilos').AsFloat / kmtEntradas.fieldByName('kilos_ent_liq').AsFloat;
    end
    else
    begin
      rFactor:= 1;
    end;
    kmtLiquidaDet.FieldByName('kilos_ent').AsFloat:= roundto( kmtEntradas.fieldByName('kilos_ent').AsFloat * rFactor, -2 );
    kmtLiquidaDet.FieldByName('kilos_net').AsFloat:= roundto( kmtEntradas.fieldByName('kilos_ent_net').AsFloat * rFactor, -2);

    kmtLiquidaDet.FieldByName('kilos_aux_ent').AsFloat:= kmtEntradas.fieldByName('kilos_ent').AsFloat;
    kmtLiquidaDet.FieldByName('kilos_aux_net').AsFloat:= kmtEntradas.fieldByName('kilos_ent_net').AsFloat;
    kmtLiquidaDet.FieldByName('kilos_aux_liq').AsFloat:= kmtEntradas.fieldByName('kilos_ent_liq').AsFloat;

    if  kmtSalidas.fieldByName('kilos_sal').AsFloat > 0 then
    begin
      rFactor:= kmtInOut.fieldByName('kilos').AsFloat / kmtSalidas.fieldByName('kilos_sal').AsFloat;
    end
    else
    begin
      rFactor:= 0;
    end;



    kmtLiquidaDet.FieldByName('cajas_liq').AsInteger:= Trunc( roundto( kmtSalidas.fieldByName('cajas_sal').AsFloat * rFactor, -2 ) );
    kmtLiquidaDet.FieldByName('importe_liq').AsFloat:= roundto( kmtSalidas.fieldByName('importe_sal').AsFloat * rFactor, - 2);
    kmtLiquidaDet.FieldByName('descuentos_fac_liq').AsFloat:= roundto( kmtSalidas.fieldByName('descuentos_fac_sal').AsFloat * rFactor, - 2);
    kmtLiquidaDet.FieldByName('gastos_fac_liq').AsFloat:= roundto( kmtSalidas.fieldByName('gastos_fac_sal').AsFloat * rFactor, - 2);
    kmtLiquidaDet.FieldByName('descuentos_nofac_liq').AsFloat:= roundto( kmtSalidas.fieldByName('descuentos_nofac_sal').AsFloat * rFactor, - 2);
    kmtLiquidaDet.FieldByName('gastos_nofac_liq').AsFloat:= roundto( kmtSalidas.fieldByName('gastos_nofac_sal').AsFloat * rFactor, - 2);
    kmtLiquidaDet.FieldByName('gastos_transito_liq').AsFloat:= roundto( kmtSalidas.fieldByName('gastos_transito_sal').AsFloat * rFactor, - 2);
    kmtLiquidaDet.FieldByName('costes_envasado_liq').AsFloat:= roundto( kmtSalidas.fieldByName('costes_envasado_sal').AsFloat * rFactor, - 2);
    kmtLiquidaDet.FieldByName('costes_sec_transito_liq').AsFloat:= roundto( kmtSalidas.fieldByName('costes_sec_transito_sal').AsFloat * rFactor, - 2);
    kmtLiquidaDet.FieldByName('costes_abonos_liq').AsFloat:= roundto( kmtSalidas.fieldByName('costes_abonos_sal').AsFloat * rFactor, - 2);
    kmtLiquidaDet.FieldByName('costes_financiero_liq').AsFloat:= roundto( kmtSalidas.fieldByName('costes_financiero_sal').AsFloat * rFactor, - 2);


    rGastosAux:= (  kmtLiquidaDet.FieldByName('descuentos_fac_liq').AsFloat + kmtLiquidaDet.FieldByName('gastos_fac_liq').AsFloat +
           kmtLiquidaDet.FieldByName('descuentos_nofac_liq').AsFloat + kmtLiquidaDet.FieldByName('gastos_nofac_liq').AsFloat +
           kmtLiquidaDet.FieldByName('gastos_transito_liq').AsFloat + kmtLiquidaDet.FieldByName('costes_envasado_liq').AsFloat +
           kmtLiquidaDet.FieldByName('costes_sec_transito_liq').AsFloat + kmtLiquidaDet.FieldByName('costes_abonos_liq').AsFloat +
           kmtLiquidaDet.FieldByName('costes_financiero_liq').AsFloat );

    kmtLiquidaDet.FieldByName('liquido_liq').AsFloat:= kmtLiquidaDet.FieldByName('importe_liq').AsFloat - rGastosAux;

    //Para el calculo de las medias por categoria
    (*
    if kmtLiquidaDet.FieldByName('categoria_ent').AsString = '1' then
    begin
      if kmtLiquidaDet.FieldByName('facturado_sal').AsInteger = 1 then
      begin
        rfacturados1:= rfacturados1 + kmtLiquidaDet.FieldByName('kilos_liq').AsInteger;
        rimporte1:= rimporte1 + kmtLiquidaDet.FieldByName('importe_liq').AsFloat;
        rgastos1:= rgastos1 + rGastosAux;
      end
      else
      begin
        rpendientes1:= rpendientes1 + kmtLiquidaDet.FieldByName('kilos_liq').AsInteger;
      end;
    end
    else
    if kmtLiquidaDet.FieldByName('categoria_ent').AsString = '2' then
    begin
      if kmtLiquidaDet.FieldByName('facturado_sal').AsInteger = 1 then
      begin
        rfacturados2:= rfacturados2 + kmtLiquidaDet.FieldByName('kilos_liq').AsInteger;
        rimporte2:= rimporte2 + kmtLiquidaDet.FieldByName('importe_liq').AsFloat;
        rgastos2:= rgastos2 + rGastosAux;
      end
      else
      begin
        rpendientes2:= rpendientes2 + kmtLiquidaDet.FieldByName('kilos_liq').AsInteger;
      end;
    end
    else
    if kmtLiquidaDet.FieldByName('categoria_ent').AsString = '3' then
    begin
      if kmtLiquidaDet.FieldByName('facturado_sal').AsInteger = 1 then
      begin
        rfacturados3:= rfacturados3 + kmtLiquidaDet.FieldByName('kilos_liq').AsInteger;
        rimporte3:= rimporte3 + kmtLiquidaDet.FieldByName('importe_liq').AsFloat;
        rgastos3:= rgastos3 + rGastosAux;
      end
      else
      begin
        rpendientes3:= rpendientes3 + kmtLiquidaDet.FieldByName('kilos_liq').AsInteger;
      end;
    end
    else
    begin
      if kmtLiquidaDet.FieldByName('facturado_sal').AsInteger = 1 then
      begin
        rfacturados4:= rfacturados4 + kmtLiquidaDet.FieldByName('kilos_liq').AsInteger;
        rimporte4:= rimporte4 + kmtLiquidaDet.FieldByName('importe_liq').AsFloat;
        rgastos4:= rgastos4 + rGastosAux;
      end
      else
      begin
        rpendientes4:= rpendientes4 + kmtLiquidaDet.FieldByName('kilos_liq').AsInteger;
      end;
    end;
    *)

    kmtLiquidaDet.Post;
end;


procedure  TDMLiqProdVendido.SQLPlantacion(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  qryReportPlanta.SQL.Clear;
  qryReportPlanta.SQL.Add(' select empresa_ent, producto_ent, centro_ent, centro_origen_ent, cosechero_ent, plantacion_ent, ');
  qryReportPlanta.SQL.Add('        semana_planta_ent, case when facturado_sal = 1 then 1 else 0 end facturado, categoria_ent, ');
  qryReportPlanta.SQL.Add('        sum(kilos_ent) kilos_ent, sum(kilos_net) kilos_net, sum(kilos_liq) kilos_liq, ');
  qryReportPlanta.SQL.Add('        sum(importe_liq) importe_liq, sum(descuentos_fac_liq) descuentos_fac_liq, ');
  qryReportPlanta.SQL.Add('        sum(gastos_fac_liq) gastos_fac_liq,  sum(descuentos_nofac_liq) descuentos_nofac_liq, ');
  qryReportPlanta.SQL.Add('        sum(gastos_nofac_liq) gastos_nofac_liq, sum(gastos_transito_liq) gastos_transito_liq, ');
  qryReportPlanta.SQL.Add('        sum(costes_Envasado_liq) costes_Envasado_liq, sum(costes_sec_transito_liq) costes_sec_transito_liq, ');
  qryReportPlanta.SQL.Add('        sum(costes_abonos_liq) costes_abonos_liq, sum(costes_financiero_liq) costes_financiero_liq, ');
  qryReportPlanta.SQL.Add('        sum(liquido_liq) liquido_liq ');
  qryReportPlanta.SQL.Add(' from tliq_liquida_det ');
  if AEmpresa = 'SAT' then
    qryReportPlanta.SQL.Add(' where empresa_ent = ''SAT'' ')
  else
    qryReportPlanta.SQL.Add(' where empresa_ent = :empresa ');
  qryReportPlanta.SQL.Add(' and fecha_ent between :fechaini and :fechafin ');
  if ACentro <> '' then
    qryReportPlanta.SQL.Add(' and centro_ent = :centro ');
  if AProducto <> '' then
    qryReportPlanta.SQL.Add(' and producto_ent = :producto ');
  qryReportPlanta.SQL.Add(' group by empresa_ent, centro_ent, producto_ent, centro_origen_ent, cosechero_ent, plantacion_ent, semana_planta_ent, ');
  qryReportPlanta.SQL.Add('          facturado,  categoria_ent ');
  qryReportPlanta.SQL.Add(' order by empresa_ent, centro_ent, producto_ent, centro_origen_ent, cosechero_ent, plantacion_ent, semana_planta_ent, ');
  qryReportPlanta.SQL.Add('                                       facturado desc, categoria_ent ');

  if AEmpresa <> 'SAT' then
    qryReportPlanta.ParamByName('empresa').AsString:= AEmpresa;
  qryReportPlanta.ParamByName('fechaini').AsDateTime:= ADesde;
  qryReportPlanta.ParamByName('fechafin').AsDateTime:= AHasta;
  if ACentro <> '' then
    qryReportPlanta.ParamByName('centro').AsString:= ACentro;
  if AProducto <> '' then
    qryReportPlanta.ParamByName('producto').AsString:= AProducto;
end;

procedure TDMLiqProdVendido.ImprimirPlaJuntos(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  SQLPlantacion(AEmpresa, ACentro, AProducto, ADesde, AHasta );
  qryReportPlanta.Open;
  try
    if not qryReportPlanta.IsEmpty then
      LiqProdVendidoPlanQR.Imprimir
    else
      ShowMessage('No hay productos a liquidar para los parametros seleccionados.');
  finally
    qryReportPlanta.Close;
  end;
end;

procedure TDMLiqProdVendido.ImprimirPlaSeparados(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  ProductosALiquidar(AEmpresa, ACentro, AProducto, ADesde, AHasta );
  qryALiquidar.Open;
  try
    if not qryALiquidar.IsEmpty then
    begin
      while not qryALiquidar.Eof do
      begin
        SQLPlantacion(qryALiquidar.FieldByName('empresa').AsString,
                   qryALiquidar.FieldByName('centro').AsString,
                   qryALiquidar.FieldByName('producto').AsString, ADesde, AHasta );
        qryReportPlanta.Open;
        try
          if not qryReportPlanta.IsEmpty then
            LiqProdVendidoPlanQR.Imprimir;
        finally
          qryReportPlanta.Close;
        end;
        qryALiquidar.Next;
      end;
    end
    else
    begin
      ShowMessage('No hay productos a liquidar para los parametros seleccionados.');
    end;
  finally
    qryALiquidar.Close;
  end;
end;

procedure  TDMLiqProdVendido.SQLCosechero(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  qryReportCos.SQL.Clear;
  qryReportCos.SQL.Add(' select empresa_ent, producto_ent, centro_ent, centro_origen_ent, cosechero_ent,  ');
  qryReportCos.SQL.Add('        case when facturado_sal = 1 then 1 else 0 end facturado, categoria_ent, ');
  qryReportCos.SQL.Add('        sum(kilos_ent) kilos_ent, sum(kilos_net) kilos_net, sum(kilos_liq) kilos_liq, ');
  qryReportCos.SQL.Add('        sum(importe_liq) importe_liq, sum(descuentos_fac_liq) descuentos_fac_liq, ');
  qryReportCos.SQL.Add('        sum(gastos_fac_liq) gastos_fac_liq,  sum(descuentos_nofac_liq) descuentos_nofac_liq, ');
  qryReportCos.SQL.Add('        sum(gastos_nofac_liq) gastos_nofac_liq, sum(gastos_transito_liq) gastos_transito_liq, ');
  qryReportCos.SQL.Add('        sum(costes_Envasado_liq) costes_Envasado_liq, sum(costes_sec_transito_liq) costes_sec_transito_liq, ');
  qryReportCos.SQL.Add('        sum(costes_abonos_liq) costes_abonos_liq, sum(costes_financiero_liq) costes_financiero_liq, ');
  qryReportCos.SQL.Add('        sum(liquido_liq) liquido_liq ');
  qryReportCos.SQL.Add(' from tliq_liquida_det ');
  if AEmpresa = 'SAT' then
    qryReportCos.SQL.Add(' where empresa_ent = ''SAT'' ')
  else
    qryReportCos.SQL.Add(' where empresa_ent = :empresa ');
  qryReportCos.SQL.Add(' and fecha_ent between :fechaini and :fechafin ');
  if ACentro <> '' then
    qryReportCos.SQL.Add(' and centro_ent = :centro ');
  if AProducto <> '' then
    qryReportCos.SQL.Add(' and producto_ent = :producto ');
  qryReportCos.SQL.Add(' group by empresa_ent, centro_ent, producto_ent, centro_origen_ent, cosechero_ent,  ');
  qryReportCos.SQL.Add('          facturado,  categoria_ent ');
  qryReportCos.SQL.Add(' order by empresa_ent, centro_ent, producto_ent, centro_origen_ent, cosechero_ent,  ');
  qryReportCos.SQL.Add('                                       facturado desc, categoria_ent ');

  if AEmpresa <> 'SAT' then
    qryReportCos.ParamByName('empresa').AsString:= AEmpresa;
  qryReportCos.ParamByName('fechaini').AsDateTime:= ADesde;
  qryReportCos.ParamByName('fechafin').AsDateTime:= AHasta;
  if ACentro <> '' then
    qryReportCos.ParamByName('centro').AsString:= ACentro;
  if AProducto <> '' then
    qryReportCos.ParamByName('producto').AsString:= AProducto;
end;


procedure TDMLiqProdVendido.ImprimirCosJuntos(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  SQLCosechero(AEmpresa, ACentro, AProducto, ADesde, AHasta );
  qryReportCos.Open;
  try
     if not qryReportCos.IsEmpty then
       LiqProdVendidoCosQR.Imprimir( ADesde, AHasta )
    else
      ShowMessage('No hay productos a liquidar para los parametros seleccionados.');
  finally
    qryReportCos.Close;
  end;
end;

procedure TDMLiqProdVendido.ImprimirCosSeparados(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  ProductosALiquidar(AEmpresa, ACentro, AProducto, ADesde, AHasta );
  qryALiquidar.Open;
  try
    if not qryALiquidar.IsEmpty then
    begin
      while not qryALiquidar.Eof do
      begin
        SQLCosechero(qryALiquidar.FieldByName('empresa').AsString,
                   qryALiquidar.FieldByName('centro').AsString,
                   qryALiquidar.FieldByName('producto').AsString, ADesde, AHasta );
        qryReportCos.Open;
        try
          if not qryReportCos.IsEmpty then
            LiqProdVendidoCosQR.Imprimir( ADesde, AHasta );
        finally
          qryReportCos.Close;
        end;
        qryALiquidar.Next;
      end;
    end
    else
    begin
      ShowMessage('No hay productos a liquidar para los parametros seleccionados.');
    end;
  finally
    qryALiquidar.Close;
  end;
end;

procedure  TDMLiqProdVendido.SQLResumen(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime );
begin
  qryResumen.SQL.Clear;
  qryResumen.SQL.Add(' select codigo,  keySem, empresa, centro, producto , semana, fecha_ini, fecha_fin, fecha_calculo, hora_calculo, ');
  qryResumen.SQL.Add('    kilos_iniciales, kilos_entrada_campo, kilos_entrada_transito, kilos_finales,  kilos_salida_venta,  kilos_salida_transito, ');
  qryResumen.SQL.Add('    kilos_merma, porcentaje_merma, kilos_objetivo, kilos_disponibles, porcentaje_disponibles, kilos_facturados, porcentaje_facturado  ');

  qryResumen.SQL.Add(' from tliq_semanas   ');
  if AEmpresa = 'SAT' then
    qryResumen.SQL.Add(' where empresa = ''SAT'' ')
  else
    qryResumen.SQL.Add(' where empresa = :empresa ');
  if ACentro <> '' then
    qryResumen.SQL.Add(' and centro = :centro ');
  qryResumen.SQL.Add(' and fecha_ini between :fechaini and :fechafin ');
  if AProducto <> '' then
    qryResumen.SQL.Add(' and producto = :producto ');
  qryResumen.SQL.Add(' order by empresa, centro, producto, fecha_ini ');

  if AEmpresa <> 'SAT' then
    qryResumen.ParamByName('empresa').AsString:= AEmpresa;
  qryResumen.ParamByName('fechaini').AsDateTime:= ADesde;
  qryResumen.ParamByName('fechafin').AsDateTime:= AHasta;
  if ACentro <> '' then
    qryResumen.ParamByName('centro').AsString:= ACentro;
  if AProducto <> '' then
    qryResumen.ParamByName('producto').AsString:= AProducto;
end;

procedure TDMLiqProdVendido.ImprimirResumenJuntos(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime; const AFacturado: boolean );
begin
  SQLResumen(AEmpresa, ACentro, AProducto, ADesde, AHasta );
  qryResumen.Open;
  try
    if not qryResumen.IsEmpty then
      LiqProdVendidoResumenQR.Imprimir( AEmpresa, ADesde, AHasta, AFacturado )
    else
      ShowMessage('No hay productos a liquidar para los parametros seleccionados.');
  finally
    qryResumen.Close;
  end;
end;

procedure TDMLiqProdVendido.ImprimirResumenSeparados(const AEmpresa, ACentro, AProducto: string;
                                     const ADesde, AHasta: TDateTime; const AVerFacturado: boolean );
begin
  ProductosALiquidar(AEmpresa, ACentro, AProducto, ADesde, AHasta );
  qryALiquidar.Open;
  try
    if not qryALiquidar.IsEmpty then
    begin
      while not qryALiquidar.Eof do
      begin
        SQLResumen(qryALiquidar.FieldByName('empresa').AsString,
                   qryALiquidar.FieldByName('centro').AsString,
                   qryALiquidar.FieldByName('producto').AsString, ADesde, AHasta );
        qryResumen.Open;
        try
          if not qryResumen.IsEmpty then
            LiqProdVendidoResumenQR.Imprimir( AEmpresa, ADesde, AHasta, AVerFacturado );
        finally
          qryResumen.Close;
        end;
        qryALiquidar.Next;
      end;
    end
    else
    begin
      ShowMessage('No hay productos a liquidar para los parametros seleccionados.');
    end;
  finally
    qryALiquidar.Close;
  end;
end;

procedure TDMLiqProdVendido.PonerFechaTransito;
var
  qryTransitoAlmacen: TQuery;
begin
  qryTransitoCentral.SQL.Clear;
  qryTransitoCentral.SQL.Add('select * ');
  qryTransitoCentral.SQL.Add('from frf_transitos_c ');
  qryTransitoCentral.SQL.Add('where ( fecha_tc >= ''1/1/2017'' and fecha_entrada_tc is null ) ');
  qryTransitoCentral.SQL.Add('   or ( fecha_tc >= ''1/1/2017'' and  fecha_tc >= :fecha ) ');
  qryTransitoCentral.ParamByName('fecha').AsDateTime:= IncDay( now, - 30);

  qryTransitoLlanos.SQL.Clear;
  qryTransitoLlanos.SQL.Add('select * ');
  qryTransitoLlanos.SQL.Add('from frf_transitos_c ');
  qryTransitoLlanos.SQL.Add('where empresa_tc = :empresa ');
  qryTransitoLlanos.SQL.Add('and centro_tc = :centro ');
  qryTransitoLlanos.SQL.Add('and fecha_tc = :fecha ');
  qryTransitoLlanos.SQL.Add('and referencia_tc = :referencia ');
  qryTransitoLlanos.SQL.Add('and fecha_entrada_tc is not null ');

  qryTransitoMoradas.SQL.Clear;
  qryTransitoMoradas.SQL.Add( qryTransitoLlanos.SQL.Text );

  qryTransitoCentral.Open;
  try
    while not qryTransitoCentral.Eof do
    begin
      if ( qryTransitoCentral.FieldByName('centro_destino_tc').asstring = '1' ) or
         ( qryTransitoCentral.FieldByName('centro_destino_tc').asstring = '6' ) then
      begin
        if qryTransitoCentral.FieldByName('centro_destino_tc').asstring = '1' then
        begin
          qryTransitoAlmacen:= qryTransitoLlanos;
        end
        else
        //if qryTransitoCentral.FieldByName('centro_destino_tc').asstring = '6' then
        begin
          qryTransitoAlmacen:= qryTransitoMoradas;
        end;

        qryTransitoAlmacen.ParamByName('empresa').AsString:= qryTransitoCentral.FieldByName('empresa_tc').asstring;
        qryTransitoAlmacen.ParamByName('centro').AsString:= qryTransitoCentral.FieldByName('centro_tc').asstring;
        qryTransitoAlmacen.ParamByName('fecha').AsdateTime:= qryTransitoCentral.FieldByName('fecha_tc').AsdateTime;
        qryTransitoAlmacen.ParamByName('referencia').AsInteger:= qryTransitoCentral.FieldByName('referencia_tc').AsInteger;
        qryTransitoAlmacen.Open;
        try
          if not qryTransitoAlmacen.IsEmpty then
          begin
            if qryTransitoCentral.FieldByName('fecha_entrada_tc').AsDateTime < qryTransitoAlmacen.FieldByName('fecha_entrada_tc').AsDateTime then
            begin
              qryTransitoCentral.Edit;
              qryTransitoCentral.FieldByName('fecha_entrada_tc').AsDateTime:= qryTransitoAlmacen.FieldByName('fecha_entrada_tc').AsDateTime;
              qryTransitoCentral.FieldByName('hora_entrada_tc').AsString:= qryTransitoAlmacen.FieldByName('hora_entrada_tc').AsString;
              qryTransitoCentral.FieldByName('hora_tc').AsString:= qryTransitoAlmacen.FieldByName('hora_tc').AsString;
              qryTransitoCentral.Post;
            end;
          end;
        finally
          qryTransitoAlmacen.Close;
        end;
      end
      else
      begin
        qryTransitoCentral.Edit;
        qryTransitoCentral.FieldByName('fecha_entrada_tc').AsDateTime:= qryTransitoCentral.FieldByName('fecha_tc').AsDateTime;
        qryTransitoCentral.FieldByName('hora_entrada_tc').AsString:= qryTransitoCentral.FieldByName('hora_tc').AsString;
        qryTransitoCentral.Post;
      end;
      qryTransitoCentral.Next;
    end;
  finally
    qryTransitoCentral.Close;
  end;
end;

end.
