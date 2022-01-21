unit LiquidaEntregaDL;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables, QuickRpt, DateUtils;

type
  TDLLiquidaEntrega = class(TDataModule)
    qryEntregas: TQuery;
    dsEntregas: TDataSource;
    qryEntregasLin: TQuery;
    dsEntregasLin: TDataSource;
    qryPaletsPB: TQuery;
    dsPaletsPB: TDataSource;
    qryOrdenCarga: TQuery;
    qryEnvase: TQuery;
    kmtPalet: TkbmMemTable;
    kmtLiquidacion: TkbmMemTable;
    kmtGastosTransito: TkbmMemTable;
    qryGastosEntrega: TQuery;
    qryFechaSalida: TQuery;
    qryKilosTeoricosLinea: TQuery;
    kmtResumen: TkbmMemTable;
    qrySalidasLin: TQuery;
    kmtTransitos: TkbmMemTable;
    kmtPrecioFOB: TkbmMemTable;
    kmtKilosTeoricos: TkbmMemTable;
    qryKilosVariedadRF: TQuery;
    qryEntregasProveedor: TQuery;
    kmtClientes: TkbmMemTable;
    qryFechaAlbaranCliente: TQuery;
    qryEuroKilo: TQuery;
    kmtEuroKilo: TkbmMemTable;
    kmtCostesProv: TkbmMemTable;
    qryCostesProv: TQuery;
    qryKilosDestrioTfe: TQuery;
    kmtKilosDestrioTfe: TkbmMemTable;
    qryAux: TQuery;

    procedure DMOnCreate(Sender: TObject);
    procedure qryEntregasBeforeClose(DataSet: TDataSet);
    procedure qryEntregasAfterOpen(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sBD: string;        //Base de datos remota
    sEmpresaIni, sSemanaIni, sUnicoProv, sProducto: string;

    { Private declarations }
    bRF: Boolean; //Necesitamos la RF???
    //Params
    //bFaltanCostesEntrega, bFaltanCostesAlbaran, bFaltanCostesEnvasado: Boolean;
    rBenificio, rFinancieroVolcados, rFinancieroCargados, rFlete: real;
    rMinTteCliente, rMinTteCanario, rMinCosteEnvasado: Real;
    bExcluirIndirecto: boolean;

    spStatus: string;
    spEmpresa,  spCentro, spAlbaran, spFechaAlbaran, spEnvase, spCliente, spProducto, spCategoria, spProductoBase: string;
    spDestino: string;

    //Variables globales
    rgPeso, rgNeto, rgDescuento, rgGastos, rgMaterial, rgPersonal, rgGeneral: Real;
    rCosteEntrega: Real;

    procedure PreparaTablaEntregas( const AEmpresa, ASemana, AProveedor, AProductor, AProducto, AEntrega : string );

    procedure InicializaVariables;
    procedure InicializaMinimos( const AMinTteCliente, AMinTteCanario, AMinCosteEnvasado: Real );

    function  LoadParamsByStatus( var VMsg: string; var ATipoPalet: integer  ): boolean;
    procedure LoadParamsDestrio;
    procedure LoadParamsVolcados;
    function  LoadParamsCargados( var ATransitos: boolean ): boolean;
    procedure CleanParams;

    function  GetEnvaseProveedor( const AEmpresa, AProveedor, AProducto, AVariedad: string ): string;
    function  GetRelacionKilosTeoricos( const AEntrega, AEmpresa, AProveedor, AProducto, ACategoria: string; const AVariedad: integer; var VRelacion, VKilosCaja: real ): Boolean;

    procedure TablasTemporales;
    procedure AbrirTablasTemporales;
    procedure CerrarTablasTemporales;
    procedure LimpiarTablasTemporales;

    procedure ValorarVerde( const APrecios: boolean; const ABenificio, AFinacieroCargados, ACosteFlete: Real; const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: boolean );
    function  ValorarLineaVerde: boolean;
    function  ExisteLineaVerde: boolean;
    procedure NewLineaVerde;
    procedure EditLineaVerde;

    procedure ValorarPalets( const APrecios: boolean; const ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete: Real;const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: boolean );
    function  ValorarPalet: boolean;
    Function  FechaSalida: string;
    procedure NewPalet;

    procedure ImportesFOBDestrio;
    function  ImportesFOBLiqCarga: boolean;
    function  ImportesFOBLiqVolcado: boolean;
    function  ImportesFOBAux( const AFecha, ACliente, ACategoria, AEnvase: string ): boolean;
    function  ExisteImportesFOB: boolean;
    procedure PutImportesFOB;
    procedure NewImportesFOB;

    procedure CosteEntrega;


    procedure MakeInformeLiquidacion;
    function  ExistLineaLiquida( const ACliente, ATipoVenta: string ): boolean;
    procedure NewLineaLiquida( const ACliente, ATipoVenta: string );
    procedure EditLineaLiquida;
    procedure CalculoLiquida;

    procedure MakeResumenCategorias;
    function  ExistLineaResumen( const ATipoVenta: string ): boolean;
    procedure NewLineaResumen( const ATipoVenta: string );
    procedure EditLineaResumen;
    procedure CalculoResumen;

    procedure MakeResumenClientes;
    function  ExistLineaClientes( const ATipoVenta: string ): boolean;
    procedure NewLineaClientes( const ATipoVenta: string );
    procedure EditLineaClientes;
    procedure CalculoClientes;

    procedure ConectarRemoto( const AEmpresa: string);
    procedure DesConectarRemoto;

    procedure DatosLiquidaVerde( const AEmpresa: string; const APrecios, AProveedores: boolean; const ABenificio, AFinacieroCargados, ACosteFlete: Real;
                                 const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: boolean);
    procedure DatosLiquidaRF( const AEmpresa: string; const APrecios, AProveedores: boolean; const ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete: Real;
                              const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto:boolean );


    function HaySalidas( const AEmpresa, ACliente, AProducto: string; const AFecha: TDateTime; var  AFechaSalida: TDateTime ): boolean;
    //STOCK
    //procedure AltaStock;
    //procedure ValorarStock;

    //TRANSITOS
    procedure AltaTransito;
    procedure ValorarTransitos;
    procedure CalcularEuroKilo(const sEmpresa, sAnyoSem, sProveedor,sProductor, sProducto, sEntrega: string);
    procedure CalcularKilosDestrioTenerife(const sEmpresa, sAnyoSem, sProveedor, sProductor, sProducto, sEntrega: string; const ACosteFlete: Real);

    procedure GetCostesProveedor(const AProveedor, AAnoSemana:string);
    procedure GetCostesProveedorTotal(const AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega:string);

    procedure CR1AddReports(Sender: TObject);

    function TotalDestrioTfePeso: Real;
    function TotalDestrioTfeImporte: Real;
    function TotalPeso: Real;
    function KilosCanarias: Real;
    function KilosCompra: Real;
    function ImporteCanarias: Real;
    function ImporteCompra: Real;
    function ImporteLiquidar: Real;
    function ImporteTotalCompra: Real;

    procedure CrearDetalleCsv(const AEmpresa, AProducto, AAnyoSem: String);


  public
    { Public declarations }
    CompositeReport: TQRCompositeReport;

    function EsProveedorALiquidar(const AEmpresa, AProveedor:string): Boolean;

    procedure CloseEntregas;
    function  SelectEntregas( const AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega: string ): boolean;
    function  SelectEntregasVerde( const AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega: string ): boolean;

    procedure LiquidarEntregasExecute( const APrecios, APalets, AProveedores: boolean;
                                       const ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete: Real;
                                       const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: Boolean;
                                       const AMinTteCliente, AMinTteCanario, AMinCosteEnvasado: Real );
    procedure LiquidarEntregasVerdeExecute( const APrecios, AProveedores: boolean; const ABenificio, AFinacieroCargado, ACosteFlete: Real;
                               const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: Boolean;
                               const AMinTteCliente, AMinTteCanario, AMinCosteEnvasado: Real );
    procedure ValorarPaletsExecute( const APrecios: Boolean );

    procedure LiquidaEntregasPlatano( AOwner: TComponent; const AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega: string;
                                      const APrecios, AProveedores, AClientes, ADestrio, APlacero, ACargado, AVolcado, AbFinancieroCargados, AbFinancieroVolcados, AFlete, AbIndirecto: boolean;
                                      const ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete,
                                            AMinTteCliente, AMinTteCanario, AMinCosteEnvasado: Real );
  end;

implementation

{$R *.dfm}

uses
  UDMBaseDatos,TablaTemporalFOBData, Variants, bMath, LiquidaEntregaProveedoresQL,
  LiquidaValorarPaletsQL, LiquidaResumenQL, Dialogs, LiquidaIncidenciasDL,
  LiquidaEntregaClientesQL, LiquidaResumenClientesQL, UDMAuxDB, Printers;
var
  DMTablaTemporalFOB: TDMTablaTemporalFOB;
  DLLiquidaIncidencias: TDLLiquidaIncidencias;

procedure TDLLiquidaEntrega.DataModuleDestroy(Sender: TObject);
begin
  DesconectarRemoto;
  FreeAndNil(DMTablaTemporalFOB);
  FreeAndNil(DLLiquidaIncidencias);
end;

procedure TDLLiquidaEntrega.InicializaMinimos( const AMinTteCliente, AMinTteCanario, AMinCosteEnvasado: Real );
begin
  rMinTteCliente:= AMinTteCliente;
  rMinTteCanario:= AMinTteCanario;
  rMinCosteEnvasado:= AMinCosteEnvasado;
end;

procedure TDLLiquidaEntrega.InicializaVariables;
begin
  rBenificio:= 0;
  rFinancieroVolcados:= 0;
  rFinancieroCargados:= 0;
  rFlete:=0;

  spStatus:= '';
  spEmpresa:= '';
  spCentro:= '';
  spAlbaran:= '';
  spFechaAlbaran:= '';
  spEnvase:= '';
  spCliente:= '';
  spProducto:= '';
  spProductoBase:= '';
  spCategoria:= '';

  rgPeso:= 0;
  rgNeto:= 0;
  rgDescuento:= 0;
  rgGastos:= 0;
  rgMaterial:= 0;
  rgPersonal:= 0;
  rgGeneral:= 0;
  rCosteEntrega:= 0;

  //bFaltanCostesEntrega:= False;
  //bFaltanCostesAlbaran:= False;
  //bFaltanCostesEnvasado:= False;
end;


procedure TDLLiquidaEntrega.ConectarRemoto( const AEmpresa: string);
var
  bAux1, bAux2, bAux3, bAux4, bAux5: Boolean;
begin
  bAux1:= qryPaletsPB.Active;
  if qryPaletsPB.Active then
    qryPaletsPB.Close;

  bAux2:= qryOrdenCarga.Active;
  if qryOrdenCarga.Active then
    qryOrdenCarga.Close;

  bAux3:= qryEnvase.Active;
  if qryEnvase.Active then
    qryEnvase.Close;

  bAux4:= qryFechaSalida.Active;
  if qryFechaSalida.Active then
    qryFechaSalida.Close;

  bAux5:= qryKilosVariedadRF.Active;
  if qryKilosVariedadRF.Active then
    qryKilosVariedadRF.Close;

  //DesconectarRemoto;
  if AEmpresa = 'F17' then
  begin
   if not DMBaseDatos.dbF17.Connected then
     DMBaseDatos.dbF17.Connected:= True;
   sBD:= 'dbF17';
  end
  else
  begin
    if DMBaseDatos.dbF17.Connected then
      DMBaseDatos.dbF17.Connected:= False;
  end;

  if AEmpresa = 'F18' then
  begin
   if not DMBaseDatos.dbF18.Connected then
     DMBaseDatos.dbF18.Connected:= True;
   sBD:= 'dbF18';
  end
  else
  begin
    if DMBaseDatos.dbF18.Connected then
      DMBaseDatos.dbF18.Connected:= False;
  end;

  (*
  if AEmpresa = 'F21' then
  begin
   if not DMBaseDatos.dbF21.Connected then
     DMBaseDatos.dbF21.Connected:= True;
   sBD:= 'dbF21';
  end
  else
  begin
    if DMBaseDatos.dbF21.Connected then
      DMBaseDatos.dbF21.Connected:= False;
  end;
  *)

  if AEmpresa = 'F23' then
  begin
   if not DMBaseDatos.dbF23.Connected then
     DMBaseDatos.dbF23.Connected:= True;
   sBD:= 'dbF23';
  end
  else
  begin
    if DMBaseDatos.dbF23.Connected then
      DMBaseDatos.dbF23.Connected:= False;
  end;

  (*
  if AEmpresa = 'F24' then
  begin
   if not DMBaseDatos.dbF24.Connected then
     DMBaseDatos.dbF24.Connected:= True;
   sBD:= 'dbF24';
  end
  else
  begin
    if DMBaseDatos.dbF24.Connected then
      DMBaseDatos.dbF24.Connected:= False;
  end;
  *)

  qryPaletsPB.DatabaseName:= sBD;
  if bAux1 then
    qryPaletsPB.Open;

  qryOrdenCarga.DatabaseName:= sBD;
  if bAux2 then
    qryOrdenCarga.Open;

  qryEnvase.DatabaseName:= sBD;
  if bAux3 then
    qryOrdenCarga.Open;

  qryFechaSalida.DatabaseName:= sBD;
  if bAux4 then
    qryEnvase.Open;

  qryKilosVariedadRF.DatabaseName:= sBD;
  if bAux5 then
    qryKilosVariedadRF.Open;

end;

procedure TDLLiquidaEntrega.DesconectarRemoto;
begin
  if DMBaseDatos.dbF17.Connected then
    DMBaseDatos.dbF17.Connected:= False;
  if DMBaseDatos.dbF18.Connected then
    DMBaseDatos.dbF18.Connected:= False;
  (*
  if DMBaseDatos.dbF21.Connected then
    DMBaseDatos.dbF21.Connected:= False;
  *)
  if DMBaseDatos.dbF23.Connected then
    DMBaseDatos.dbF23.Connected:= False;
  (*
  if DMBaseDatos.dbF24.Connected then
    DMBaseDatos.dbF24.Connected:= False;
  *)
end;

procedure TDLLiquidaEntrega.DMOnCreate(Sender: TObject);
begin
  DMTablaTemporalFOB := TDMTablaTemporalFOB.Create(self);
  DLLiquidaIncidencias:= TDLLiquidaIncidencias.Create(self);


  InicializaVariables;

  //BASE DATOS CENTRAL -- ENTREGAS/COMPRAS
  with qryEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select anyo_semana_ec, empresa_ec, codigo_ec, producto_ec, ');
    SQL.Add(' proveedor_ec, nombre_p nom_proveedor, propio_p, ');
    SQL.Add('        sum(palets_el) palets, sum(cajas_el) cajas, sum(kilos_el) kilos ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l, frf_proveedores ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and producto_ec = :producto ');
    SQL.Add(' and anyo_semana_ec = :semana ');
    //PLATANIA
    //SQL.Add(' and proveedor_ec <> ''265'' ');
    SQL.Add(' and codigo_ec = codigo_el ');
    SQL.Add(' and proveedor_p = proveedor_ec ');
    SQL.Add(' group by anyo_semana_ec, empresa_ec, codigo_ec, producto_ec, proveedor_ec, nom_proveedor, propio_p ');
    SQL.Add(' order by anyo_semana_ec, empresa_ec, proveedor_ec ');
  end;

  with qryEntregasProveedor do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_el, producto_el, sum(kilos_el) kilos ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el = :entrega ');
    SQL.Add(' group by empresa_el, producto_el');
  end;

  with qryEntregasLin do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_el empresa, proveedor_el proveedor, almacen_el almacen, ');
    SQL.Add('        producto_el producto, ');
    SQL.Add('        categoria_el categoria, ');
    SQL.Add('        variedad_el variedad, ');
    SQL.Add('        ( select max(envase_e) ');
    SQL.Add('          from frf_productos_proveedor, frf_ean13 ');
    SQL.Add('          where proveedor_pp = proveedor_el ');
    SQL.Add('          and producto_pp = producto_el ');
    SQL.Add('          and variedad_pp = variedad_el ');
    SQL.Add('          and codigo_ean_pp = codigo_e ) envase, ');
    SQL.Add('         palets_el palets, cajas_el cajas, kilos_el kilos ');
    SQL.Add(' from  frf_entregas_l ');
    SQL.Add(' where codigo_el = :codigo_ec ');
    SQL.Add(' order by categoria_el, envase ');
  end;

  with qrySalidasLin do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl empresa, centro_salida_sl centro, n_albaran_sl albaran, cliente_sl cliente,');
    SQL.Add('        fecha_sl fecha, producto_sl producto, categoria_sl categoria, envase_sl envase, ');
    SQL.Add('        sum(cajas_sl) cajas, sum(kilos_sl) kilos ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where entrega_sl = :codigo_ec ');
//    SQL.Add(' and producto_sl = ''PLA'' ');
    SQL.Add('  and producto_sl = :producto_ec ');
    SQL.Add(' group by empresa, centro, albaran, fecha, cliente, producto, categoria, envase ');
    SQL.Add(' order by categoria, envase ');
  end;

  with qryGastosEntrega do
  begin
    SQL.Clear;
    SQL.Add(' select importe_ge, unidad_dist_tg, tipo_ge ');
    SQL.Add(' from frf_gastos_entregas, frf_tipo_gastos ');
    SQL.Add(' where codigo_ge = :codigo_ec ');
    SQL.Add(' and tipo_ge = tipo_tg ');
    SQL.Add(' and gasto_transito_tg = 2 ');
    SQL.Add(' and agrupacion_tg <> ''COMPRA'' ');
    SQL.Add(' and agrupacion_tg <> ''ESTADISTIC'' ');
  end;

  with qryEuroKilo do
  begin
    SQL.Clear;
    SQL.Add(' select categoria_el, sum(kilos_el) kilos, sum(kilos_el*(case when propio_p= 1 then precio_kg_pl else precio_el end)) importe, ');
    SQL.Add('                      sum(kilos_el*(case when propio_p= 1 then precio_kg_pl else precio_el end)) / sum(kilos_el ) precio    ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l, frf_proveedores, outer(frf_precio_liquidacion)                                        ');
//    SQL.Add(' where producto_el = ''PLA'' ');
    SQL.Add('   and producto_ec = :producto ');

    SQL.Add('   and codigo_ec = codigo_el ');

    SQL.Add('   and empresa_pl = empresa_ec  ');
    SQL.Add('   and proveedor_pl = proveedor_ec  ');
    SQL.Add('   and anyo_semana_pl = anyo_semana_ec  ');
    SQL.Add('   and producto_pl = producto_el  ');
    SQL.Add('   and categoria_pl = categoria_el  ');
    SQL.Add('   and variedad_pl = variedad_el   ');

    SQL.Add('   and proveedor_p = proveedor_ec  ');
    SQL.Add(' group by 1' );
  end;

  with qryKilosDestrioTfe do
  begin
    SQL.Clear;
    SQL.Add(' select * from rf_palet_pb_liquidacion ');
    SQL.Add('  where entrega = :entrega ');
  end;

  with qryCostesProv do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_proveedores_costes     ');
    SQL.Add('  where proveedor_pc = :proveedor         ');
    SQl.Add('    and :fecha between fecha_ini_pc and nvl(fecha_fin_pc, today) ');
  end;

  with qryKilosTeoricosLinea do
  begin
    SQL.Clear;
//    SQL.Add(' select empresa_el, sum(cajas_el) cajas, sum(kilos_el - nvl(peso, 0)) kilos ');
    SQL.Add(' select empresa_el, sum(cajas_el) cajas, sum(kilos_el) kilos ');
    SQl.Add('   from frf_entregas_l                                                      ');
//    SQL.Add('      left join rf_palet_pb_liquidacion on entrega = codigo_el      ');    // Restamos Destrio Tenerife
//    SQL.Add('                                       and proveedor = proveedor_el ');
//    SQL.Add('                                       and producto = producto_el   ');
//    SQL.Add('                                       and categoria = categoria_el ');
//    SQL.Add('                                       and variedad = variedad_el   ');
    SQL.Add(' where codigo_el = :entrega ');
    SQL.Add(' and  proveedor_el = :proveedor ');
    SQL.Add(' and  producto_el = :producto ');
    SQL.Add(' and  variedad_el = :variedad ');
    SQL.Add(' and  categoria_el = :categoria ');
    SQL.Add(' group by empresa_el ');
  end;

  //BASE DATOS ALMACEN -- TABLAS TEMPORALES

  with qryKilosVariedadRF do
  begin
    SQL.Clear;
    SQL.Add(' select empresa, status, calidad, trim(nvl(paletorigen,'''')) paletorigen, sum(cajas) cajas, sum(peso) kilos ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :entrega ');
    SQL.Add('  and  proveedor = :proveedor ');
    SQL.Add('  and  producto = :producto ');
    SQL.Add('  and  variedad = :variedad ');
    SQL.Add('  and  categoria = :categoria ');
    SQL.Add('  and  status <> ''B'' ');
    SQL.Add('  group by empresa, status, calidad, paletorigen ');
  end;


  with qryPaletsPB do
  begin
    SQL.Clear;
    //fecha_alta2, tipo_placero, pais,
    SQL.Add(' select empresa, centro, tipo_palet, sscc, fecha_alta, trim(nvl(paletorigen,'''')) paletorigen, proveedor, proveedor_almacen, producto, variedad, categoria, calibre, cajas, status, ');
    SQL.Add('        peso, peso_bruto,  calidad, productobase, fecha_status, orden_carga, cliente, transito ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    SQL.Add('   and status <> ''B'' ');
    SQL.Add(' order by categoria, paletorigen desc, sscc ');
  end;

  with qryOrdenCarga do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_occ, centro_salida_occ, n_albaran_occ, fecha_occ, cliente_sal_occ, planta_destino_occ, traspasada_occ ');
    SQL.Add(' from frf_orden_carga_c ');
    SQL.Add(' where orden_occ = :orden');
  end;

  with qryEnvase do
  begin
    SQL.Clear;
    SQL.Add(' select  envase_e ');
    SQL.Add(' from frf_productos_proveedor, frf_ean13 ');
    SQL.Add(' where proveedor_pp = :proveedor ');
    SQL.Add(' and producto_pp = :producto ');
    SQL.Add(' and variedad_pp = :variedad ');
    SQL.Add(' and codigo_e = codigo_ean_pp ');
  end;

  with qryFechaSalida do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 ');
    SQL.Add('        case when fecha_carga_cab is null then previsto_carga ');
    SQL.Add('             else date(fecha_carga_cab) end fecha,  ');
    SQL.Add('        ean128_cab sscc ');
    SQL.Add(' from rf_palet_pc_cab join rf_palet_pc_det on ean128_cab = ean128_det ');
    SQL.Add('                       join frf_envases on envase_det = envase_e ');
    SQL.Add('  where cliente_cab = :cliente ');
    SQL.Add('  and fecha_alta_cab >= :fecha ');
    SQL.Add('  and ( status_cab = ''C'' or status_cab = ''S'' ) ');
    SQL.Add('  and producto_e = :producto');
    SQL.Add('  order by fecha asc ');
  end;


  with qryFechaAlbaranCliente do
  begin
    Sql.Clear;
    Sql.Add(' SELECT min(fecha_sl) fecha, count(*) registros ');
    Sql.Add(' FROM frf_salidas_l ');
    Sql.Add(' where empresa_Sl = :empresa ');
    Sql.Add(' and fecha_sl between :fechaini and :fechafin ');
    Sql.Add(' and producto_sl = :producto ');
    Sql.Add(' and cliente_sl = :cliente ');
  end;

  TablasTemporales;

end;

procedure TDLLiquidaEntrega.TablasTemporales;
begin
  kmtPrecioFOB.FieldDefs.Clear;
  kmtPrecioFOB.FieldDefs.Add('empresa', ftString, 3, False);
  kmtPrecioFOB.FieldDefs.Add('centro', ftString, 1, False);
  kmtPrecioFOB.FieldDefs.Add('albaran', ftInteger, 0, False);
  kmtPrecioFOB.FieldDefs.Add('fecha', ftDate, 0, False);
  kmtPrecioFOB.FieldDefs.Add('cliente', ftString, 3, False);
  kmtPrecioFOB.FieldDefs.Add('envase', ftString, 9,  False);
  kmtPrecioFOB.FieldDefs.Add('categoria', ftString, 3, False);

  kmtPrecioFOB.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtPrecioFOB.FieldDefs.Add('neto', ftFloat, 0, False);
  kmtPrecioFOB.FieldDefs.Add('descuento', ftFloat, 0, False);
  kmtPrecioFOB.FieldDefs.Add('gastos', ftFloat, 0, False);
  kmtPrecioFOB.FieldDefs.Add('material', ftFloat, 0, False);
  kmtPrecioFOB.FieldDefs.Add('personal', ftFloat, 0, False);
  kmtPrecioFOB.FieldDefs.Add('general', ftFloat, 0, False);

  kmtPrecioFOB.CreateTable;

  kmtTransitos.FieldDefs.Clear;
  kmtTransitos.FieldDefs.Add('tra_planta', ftString, 3, False);
  kmtTransitos.FieldDefs.Add('tra_entrega', ftString, 12, False);
  kmtTransitos.IndexFieldNames:= 'res_anyo_semana;res_categoria;res_status';
  kmtTransitos.CreateTable;

  kmtResumen.FieldDefs.Clear;
  kmtResumen.FieldDefs.Add('res_anyo_semana', ftString, 6, False);
  kmtResumen.FieldDefs.Add('res_categoria', ftString, 3, False);
  kmtResumen.FieldDefs.Add('res_status', ftString, 20, False);
  kmtResumen.FieldDefs.Add('res_calidad', ftString, 1, False);


  kmtResumen.FieldDefs.Add('res_entrega_cajas', ftInteger, 0, False);
  kmtResumen.FieldDefs.Add('res_cajas_confeccionados', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_entrega_kilos', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_kilos_confeccionados', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_kilos_teoricos', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_kilos_liquidar', ftFloat, 0, False);

  kmtResumen.FieldDefs.Add('res_importe_neto', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_descuento', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_gastos', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_material', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_personal', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_general', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_envasado', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_compra', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_beneficio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_financiero', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_flete', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_liquidar', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_indirecto_almacen', ftFloat, 0, False);

  kmtResumen.FieldDefs.Add('res_precio_indirecto_almacen', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_neto', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_descuento', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_gastos', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_material', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_personal', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_general', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_envasado', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_compra', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_beneficio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_financiero', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_flete', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_precio_liquidar', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_kilos_canarias', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_kilos_no_canarias', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_canarias', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('res_importe_no_canarias', ftFloat, 0, False);

  kmtResumen.IndexFieldNames:= 'res_anyo_semana;res_categoria;res_status';
  kmtResumen.CreateTable;

  kmtClientes.FieldDefs.Clear;
  kmtClientes.FieldDefs.Add('res_anyo_semana', ftString, 6, False);
  kmtClientes.FieldDefs.Add('res_status', ftString, 20, False);
  kmtClientes.FieldDefs.Add('res_calidad', ftString, 1, False);
  kmtClientes.FieldDefs.Add('res_cliente', ftString, 20, False);
  kmtClientes.FieldDefs.Add('res_categoria', ftString, 3, False);

  kmtClientes.FieldDefs.Add('res_entrega_cajas', ftInteger, 0, False);
  kmtClientes.FieldDefs.Add('res_cajas_confeccionados', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_entrega_kilos', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_kilos_confeccionados', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_kilos_teoricos', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_kilos_liquidar', ftFloat, 0, False);

  kmtClientes.FieldDefs.Add('res_importe_neto', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_descuento', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_gastos', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_material', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_personal', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_general', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_envasado', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_compra', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_beneficio', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_financiero', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_flete', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_liquidar', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_importe_indirecto_almacen', ftFloat, 0, False);

  kmtClientes.FieldDefs.Add('res_precio_bruto', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_neto', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_descuento', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_gastos', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_material', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_personal', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_general', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_envasado', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_compra', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_beneficio', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_financiero', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_flete', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_liquidar', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_precio_indirecto_almacen', ftFloat, 0, False);

  kmtClientes.FieldDefs.Add('res_precio_kilo', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_total_compra', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_margen_kilo', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_margen_total', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_coste_prod', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_coste_env', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_coste_opp', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_coste_ayu', ftFloat, 0, False);
  kmtClientes.FieldDefs.Add('res_coste_margen', ftFloat, 0, False);


  kmtClientes.IndexFieldNames:= 'res_anyo_semana;res_categoria;res_status;res_calidad';
  kmtClientes.CreateTable;


  kmtLiquidacion.FieldDefs.Clear;
  kmtLiquidacion.FieldDefs.Add('liq_empresa', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('liq_anyo_semana', ftString, 6, False);
  kmtLiquidacion.FieldDefs.Add('liq_proveedor', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('liq_canarias',ftInteger, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_almacen', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('liq_categoria', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('liq_cliente_sal', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('liq_entrega', ftString, 12, False);
  kmtLiquidacion.FieldDefs.Add('liq_status', ftString, 10, False);
  kmtLiquidacion.FieldDefs.Add('liq_calidad', ftString, 1, False);

  kmtLiquidacion.FieldDefs.Add('liq_entrega_palets', ftInteger, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_entrega_cajas', ftInteger, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_entrega_kilos', ftFloat, 0, False);

  kmtLiquidacion.FieldDefs.Add('liq_palets_confeccionados', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_cajas_confeccionados', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_kilos_confeccionados', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_kilos_teoricos', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_kilos_liquidar', ftFloat, 0, False);

  kmtLiquidacion.FieldDefs.Add('liq_importe_neto', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_descuento', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_gastos', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_material', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_personal', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_general', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_envasado', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_compra', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_beneficio', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_financiero', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_flete', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_liquidar', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_importe_por_precio', ftFloat, 0, False);      //kmtEuroKilo
  kmtLiquidacion.FieldDefs.Add('liq_importe_indirecto_almacen', ftFloat, 0, False);


  kmtLiquidacion.FieldDefs.Add('liq_precio_bruto', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_neto', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_descuento', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_gastos', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_material', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_personal', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_general', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_envasado', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_compra', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_beneficio', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_financiero', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_flete', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_liquidar', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('liq_precio_indirecto_almacen', ftFloat, 0, False);

  kmtLiquidacion.IndexFieldNames:= 'liq_empresa;liq_anyo_semana;liq_proveedor;liq_canarias;liq_almacen;liq_categoria;liq_cliente_sal;liq_status;liq_entrega';
  kmtLiquidacion.CreateTable;

//  ***********************************************************************************
//  ***********************************************************************************

  kmtKilosTeoricos.FieldDefs.Clear;
  kmtKilosTeoricos.FieldDefs.Add('entrega', ftString, 12, False);
  kmtKilosTeoricos.FieldDefs.Add('empresa', ftString, 3, False);
  kmtKilosTeoricos.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtKilosTeoricos.FieldDefs.Add('producto', ftString, 3, False);
  kmtKilosTeoricos.FieldDefs.Add('variedad', ftInteger, 0, False);
  kmtKilosTeoricos.FieldDefs.Add('categoria', ftString, 3, False);
  kmtKilosTeoricos.FieldDefs.Add('kilos_linea', ftFloat, 0, False);
  kmtKilosTeoricos.FieldDefs.Add('kilos_rf', ftFloat, 0, False);
  kmtKilosTeoricos.FieldDefs.Add('relacion', ftFloat, 0, False);
  kmtKilosTeoricos.FieldDefs.Add('kilos_caja', ftFloat, 0, False);
  kmtKilosTeoricos.IndexFieldNames:= 'entrega;proveedor;producto;variedad;categoria';
  kmtKilosTeoricos.CreateTable;

  kmtPalet.FieldDefs.Clear;
  kmtPalet.FieldDefs.Add('pal_anyo_semana', ftString, 6, False);
  kmtPalet.FieldDefs.Add('pal_empresa', ftString, 3, False);
  kmtPalet.FieldDefs.Add('pal_proveedor', ftString, 3, False);
  kmtPalet.FieldDefs.Add('pal_canarias', ftInteger,0, False);
  kmtPalet.FieldDefs.Add('pal_almacen', ftString, 3, False);
  kmtPalet.FieldDefs.Add('pal_entrega', ftString, 12, False);
  kmtPalet.FieldDefs.Add('pal_sscc_final', ftString, 20, False);
  kmtPalet.FieldDefs.Add('pal_variedad', ftInteger, 0, False);
  kmtPalet.FieldDefs.Add('pal_categoria', ftString, 3, False);

  kmtPalet.FieldDefs.Add('pal_entrega_palets', ftInteger, 0, False);
  kmtPalet.FieldDefs.Add('pal_entrega_cajas', ftInteger, 0, False);
  kmtPalet.FieldDefs.Add('pal_entrega_kilos', ftFloat, 0, False);

  kmtPalet.FieldDefs.Add('pal_sscc_origen', ftString, 20, False);
  kmtPalet.FieldDefs.Add('pal_status', ftString, 1, False);
  kmtPalet.FieldDefs.Add('pal_calidad', ftString, 1, False);
  kmtPalet.FieldDefs.Add('pal_valorado', ftInteger, 0, False);
  kmtPalet.FieldDefs.Add('pal_palet', ftInteger, 0, False);

  kmtPalet.FieldDefs.Add('pal_cliente_sal', ftString, 3, False);
  kmtPalet.FieldDefs.Add('pal_envase_sal', ftString, 9,  False);
  kmtPalet.FieldDefs.Add('pal_categoria_sal', ftString, 3, False);
  kmtPalet.FieldDefs.Add('pal_fecha_sal', ftString, 10, False);
  kmtPalet.FieldDefs.Add('pal_albaran_sal', ftString, 6, False);

  kmtPalet.FieldDefs.Add('pal_cajas_confeccionados', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_kilos_confeccionados', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_kilos_teoricos', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_kilos_liquidar', ftFloat, 0, False);

  kmtPalet.FieldDefs.Add('pal_importe_neto', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_descuento', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_gastos', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_material', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_personal', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_general', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_envasado', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_compra', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_beneficio', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_financiero', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_flete', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_liquidar', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_ind_almacen', ftFloat, 0, False);

  kmtPalet.FieldDefs.Add('pal_precio_ind_almacen', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_neto', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_descuento', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_gastos', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_material', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_personal', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_general', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_envasado', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_compra', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_beneficio', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_financiero', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_flete', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_precio_liquidar', ftFloat, 0, False);

  kmtPalet.IndexFieldNames:= 'pal_anyo_semana;pal_empresa;pal_proveedor;pal_canarias;pal_almacen;pal_entrega;pal_sscc_final';
  kmtPalet.CreateTable;


  kmtGastosTransito.FieldDefs.Clear;
  kmtGastosTransito.FieldDefs.Add('entrega', ftString, 12, False);
  kmtGastosTransito.FieldDefs.Add('kilos', ftFloat, 0, False);
  kmtGastosTransito.FieldDefs.Add('importe', ftFloat, 0, False);
  kmtGastosTransito.FieldDefs.Add('coste_kilos', ftFloat, 0, False);
  kmtGastosTransito.FieldDefs.Add('transporte', ftInteger, 0, False);
  kmtGastosTransito.IndexFieldNames:= 'entrega';
  kmtGastosTransito.CreateTable;

  kmtEuroKilo.FieldDefs.Clear;
  kmtEuroKilo.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtEuroKilo.FieldDefs.Add('categoria', ftString, 3, False);
  kmtEuroKilo.FieldDefs.Add('variedad', ftInteger, 0, False);
  kmtEuroKilo.FieldDefs.Add('kilos', ftFloat, 0, False);
  kmtEuroKilo.FieldDefs.Add('precio', ftFloat, 0, False);
  kmtEuroKilo.FieldDefs.Add('importe', ftFloat, 0, False);
  kmtEuroKilo.IndexFieldNames:= 'proveedor;categoria;variedad';
  kmtEuroKilo.CreateTable;

  kmtCostesProv.FieldDefs.Clear;
  kmtCostesProv.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtCostesProv.FieldDefs.Add('costeProduccion', ftFloat, 0, False);
  kmtCostesProv.FieldDefs.Add('costeEnvasado', ftFloat, 0, False);
  kmtCostesProv.FieldDefs.Add('costeOPP', ftFloat, 0, False);
  kmtCostesProv.FieldDefs.Add('costeAyuda', ftFloat, 0, False);
  kmtCostesProv.FieldDefs.Add('costeIndirectoAlmacen', ftFloat, 0, False);
  kmtCostesProv.IndexFieldNames:='proveedor';
  kmtCostesProv.CreateTable;

  //Destrio Tenerife
  kmtKilosDestrioTfe.FieldDefs.Clear;
  kmtKilosDestrioTfe.FieldDefs.Add('entrega', ftString, 12, False);
  kmtKilosDestrioTfe.FieldDefs.Add('empresa', ftString, 3, False);
  kmtKilosDestrioTfe.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtKilosDestrioTfe.FieldDefs.Add('producto', ftString, 3, False);
  kmtKilosDestrioTfe.FieldDefs.Add('variedad', ftInteger, 0, False);
  kmtKilosDestrioTfe.FieldDefs.Add('categoria', ftString, 3, False);
  kmtKilosDestrioTfe.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtKilosDestrioTfe.FieldDefs.Add('importe', ftFloat, 0 , False);
  kmtKilosDestrioTfe.IndexFieldNames:= 'entrega;proveedor;producto;variedad;categoria';
  kmtKilosDestrioTfe.CreateTable;

end;

function TDLLiquidaEntrega.TotalDestrioTfePeso: Real;
var rPeso: Real;
begin
  rPeso := 0;
  kmtKilosDestrioTfe.First;
  while not kmtKilosDestrioTfe.eof do
  begin
    rPeso := rPeso + kmtKilosDestrioTfe.FieldByName('peso').AsFloat;

    kmtKilosDestrioTfe.Next;
  end;
  result := rPeso;
end;

function TDLLiquidaEntrega.TotalDestrioTfeImporte: Real;
var rImporte: Real;
begin
  rImporte := 0;
  kmtKilosDestrioTfe.First;
  while not kmtKilosDestrioTfe.eof do
  begin
    rImporte := rImporte + kmtKilosDestrioTfe.FieldByName('importe').AsFloat;

    kmtKilosDestrioTfe.Next;
  end;
  result := rImporte;
end;

function TDLLiquidaEntrega.TotalPeso: Real;
var rPeso: Real;
begin
  rPeso := 0;
  kmtLiquidacion.First;
  while not kmtLiquidacion.eof do
  begin
    rPeso := rPeso + kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat;

    kmtLiquidacion.Next;
  end;
  result := rPeso;
end;

function TDLLiquidaEntrega.KilosCanarias: Real;
var rKilosCanarias: Real;
begin
  rKilosCanarias := 0;
  kmtResumen.First;
  while not kmtResumen.eof do
  begin
    rKilosCanarias := rKilosCanarias + kmtResumen.FieldByName('res_kilos_canarias').AsFloat;

    kmtResumen.Next;
  end;
  result := rKilosCanarias;
end;

function TDLLiquidaEntrega.KilosCompra: Real;
var rKilosCompra: Real;
begin
  rKilosCompra := 0;
  kmtResumen.First;
  while not kmtResumen.eof do
  begin
    rKilosCompra := rKilosCompra + kmtResumen.FieldByName('res_kilos_no_canarias').AsFloat;

    kmtResumen.Next;
  end;
  result := rKilosCompra;
end;

function TDLLiquidaEntrega.ImporteCanarias: Real;
var rImporteCanarias: Real;
begin
  rImporteCanarias := 0;
  kmtResumen.First;
  while not kmtResumen.eof do
  begin
    rImporteCanarias := rImporteCanarias + kmtResumen.FieldByName('res_importe_canarias').AsFloat;

    kmtResumen.Next;
  end;
  result := rImporteCanarias;
end;

function TDLLiquidaEntrega.ImporteCompra: Real;
var rImporteCompra: Real;
begin
  rImporteCompra := 0;
  kmtResumen.First;
  while not kmtResumen.eof do
  begin
    rImporteCompra := rImporteCompra + kmtResumen.FieldByName('res_importe_no_canarias').AsFloat;

    kmtResumen.Next;
  end;
  result := rImporteCompra;
end;

function TDLLiquidaEntrega.ImporteLiquidar: Real;
var rImporteLiquidar: Real;
begin
  rImporteLiquidar := 0;
  kmtResumen.First;
  while not kmtResumen.eof do
  begin
    rImporteLiquidar := rImporteLiquidar + kmtResumen.FieldByName('res_importe_liquidar').AsFloat;

    kmtResumen.Next;
  end;
  result := rImporteLiquidar;
end;

function TDLLiquidaEntrega.ImporteTotalCompra: Real;
var rImporteTotalCompra: Real;
begin
  rImporteTotalCompra := 0;
  kmtClientes.First;
  while not kmtClientes.eof do
  begin
    rImporteTotalCompra := rImporteTotalCompra + kmtClientes.FieldByName('res_total_compra').AsFloat;

    kmtClientes.Next;
  end;
  result := rImporteTotalCompra;
end;

procedure TDLLiquidaEntrega.AbrirTablasTemporales;
begin
  kmtClientes.Open;
  kmtResumen.Open;
  kmtLiquidacion.Open;
  kmtPalet.Open;
  kmtGastosTransito.Open;
  kmtEuroKilo.Open;
  kmtCostesProv.Open;
  kmtPrecioFOB.Open;
  kmtKilosTeoricos.Open;
  kmtKilosDestrioTfe.Open;
end;

procedure TDLLiquidaEntrega.CerrarTablasTemporales;
begin
  kmtPalet.Close;
  kmtLiquidacion.Close;
  kmtGastosTransito.Close;
  kmtEuroKilo.Close;
  kmtCostesProv.Close;
  kmtResumen.Close;
  kmtClientes.Close;
  kmtPrecioFOB.Close;
  kmtKilosTeoricos.Close;
  kmtKilosDestrioTfe.Close;
end;

procedure TDLLiquidaEntrega.PreparaTablaEntregas( const AEmpresa, ASemana, AProveedor, AProductor, AProducto, AEntrega : string );
begin
  qryEntregas.Close;
  with qryEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select anyo_semana_ec, empresa_ec, codigo_ec, producto_ec, centro_llegada_ec,        ');
    SQL.Add(' proveedor_ec, nombre_p nom_proveedor, propio_p,                       ');
    SQL.Add('        sum(palets_el) palets, sum(cajas_el) cajas, sum(kilos_el) kilos  ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l, frf_proveedores ');

    if AEntrega <> '' then
    begin
      SQL.Add(' where codigo_ec = :entrega ');
      //PLATANIA
      //SQL.Add(' and proveedor_ec <> ''265'' ');
    end
    else
    begin
      if AEmpresa <> '' then
         SQL.Add(' where empresa_ec = :empresa ')
      else
        raise Exception.Create('Seleccione una empresa.');
      if ASemana <> '' then
        SQL.Add(' and anyo_semana_ec = :semana ')
      else
        raise Exception.Create('Seleccione un año/semana o entrega.');
      if AProveedor <> '' then
         SQL.Add(' and proveedor_ec = :proveedor ')
      else
        //PLATANIA
        //SQL.Add(' and proveedor_ec <> ''265'' ');
    end;

//    SQL.Add(' and producto_ec = ''PLA'' ');
    SQL.Add(' and producto_ec = :producto   ');
    SQL.Add(' and codigo_ec = codigo_el ');

    SQL.Add(' and proveedor_p = proveedor_ec ');

    if AProductor <> '' then
       SQL.Add(' and almacen_el = :productor ');

    SQL.Add(' group by anyo_semana_ec, empresa_ec, codigo_ec, producto_ec, centro_llegada_ec, proveedor_ec, nom_proveedor, propio_p ');
    SQL.Add(' order by anyo_semana_ec, empresa_ec, proveedor_ec ');

    if AEntrega <> '' then
    begin
      ParamByName('entrega').AsString:= AEntrega;
    end
    else
    begin
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('semana').AsInteger:= StrToInt( ASemana );
      if AProveedor <> '' then
        ParamByName('proveedor').AsString:= AProveedor;
    end;
    if AProductor <> '' then
      ParamByName('productor').AsString:= AProductor;

    ParamByName('producto').AsString := AProducto;
  end;

  with qryEntregasLin do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_el empresa, proveedor_el proveedor, almacen_el almacen, ');
    SQL.Add('        producto_el producto, ');
    SQL.Add('        categoria_el categoria, ');
    SQL.Add('        variedad_el variedad, ');
    SQL.Add('        ( select max(envase_e) ');
    SQL.Add('          from frf_productos_proveedor, frf_ean13 ');
    SQL.Add('          where proveedor_pp = proveedor_el ');
    SQL.Add('          and producto_pp = producto_el ');
    SQL.Add('          and variedad_pp = variedad_el ');
    SQL.Add('          and codigo_ean_pp = codigo_e ) envase, ');
    SQL.Add('         palets_el palets, cajas_el cajas, kilos_el kilos ');
    SQL.Add(' from  frf_entregas_l ');
    SQL.Add(' where codigo_el = :codigo_ec ');
    if AProductor <> '' then
       SQL.Add(' and almacen_el = :productor ');
    SQL.Add(' order by categoria_el, envase ');
    if AProductor <> '' then
      ParamByName('productor').AsString:= AProductor;
  end;

  with qryPaletsPB do
  begin
    SQL.Clear;
    //fecha_alta2, tipo_placero, pais,
    SQL.Add(' select empresa, centro, tipo_palet, sscc, fecha_alta, trim(nvl(paletorigen,'''')) paletorigen, proveedor, proveedor_almacen, producto, variedad, categoria, calibre, cajas, status, ');
    SQL.Add('        peso, peso_bruto,  calidad, productobase, fecha_status, orden_carga, cliente, transito ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    SQL.Add('   and status <> ''B'' ');
    if AProductor <> '' then
       SQL.Add(' and proveedor_almacen = :productor ');
    SQL.Add(' order by categoria, paletorigen desc, sscc ');
    if AProductor <> '' then
      ParamByName('productor').AsString:= AProductor;
  end;
end;

procedure TDLLiquidaEntrega.qryEntregasBeforeClose(DataSet: TDataSet);
begin
  qryGastosEntrega.Close;
  if bRF then
  begin
    qryPaletsPB.Close;
  end
  else
  begin
    qryEntregasLin.Close;
    qrySalidasLin.Close;
  end;
end;

procedure TDLLiquidaEntrega.qryEntregasAfterOpen(DataSet: TDataSet);
begin
  if bRF then
  begin
    qryPaletsPB.Open;
  end
  else
  begin
    qrySalidasLin.Open;
    qryEntregasLin.Open;
  end;
  qryGastosEntrega.Open;
end;

function TDLLiquidaEntrega.SelectEntregas( const AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega: string ): boolean;
begin
  bRF:= True;
  ConectarRemoto( AEmpresa );
  PreparaTablaEntregas( AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega );
  qryEntregas.Open;
  sEmpresaIni:= AEmpresa;
  sProducto:= AProducto;
  if qryEntregas.FieldByName('anyo_semana_ec').AsString = '' then
    sSemanaIni := AAnyoSem
  else
    sSemanaIni:= qryEntregas.FieldByName('anyo_semana_ec').AsString;
  result:= not qryEntregas.IsEmpty;
end;


function TDLLiquidaEntrega.SelectEntregasVerde( const AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega: string ): boolean;
begin
  bRF:= False;
  //ConectarRemoto( AEmpresa ); //No es necesaria la RF ni datos del almacen
  PreparaTablaEntregas( AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega );
  qryEntregas.Open;
  sEmpresaIni:= AEmpresa;
  sProducto:= AProducto;
  if qryEntregas.FieldByName('anyo_semana_ec').AsString = '' then
    sSemanaIni := AAnyoSem
  else
    sSemanaIni:= qryEntregas.FieldByName('anyo_semana_ec').AsString;
  result:= not qryEntregas.IsEmpty;
end;

procedure TDLLiquidaEntrega.CloseEntregas;
begin
  qryEntregas.Close;
end;

procedure TDLLiquidaEntrega.ValorarVerde( const APrecios: boolean; const ABenificio, AFinacieroCargados, ACosteFlete: Real;const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: boolean );
var bProveedorCompra: boolean;
    rFinCargados, rFinVolcados: real;
begin
  InicializaVariables;
  rBenificio:= ABenificio;
  rFinCargados:= AFinacieroCargados;
  rFinVolcados:= 0;
  rFlete:=ACosteFlete;

  qryEntregas.First;
  while not qryEntregas.Eof do
  begin
    //comprobar si es un Proveedor de compra (propio_p)
    bProveedorCompra := not EsProveedorALiquidar(qryEntregas.FieldByName('empresa_ec').AsString, qryEntregas.FieldByName('proveedor_ec').AsString);
    if (bProveedorCompra) and (AbFinancieroCargados) then
      rFinancieroCargados := 0
    else
      rFinancieroCargados := rFinCargados;

    rFinancieroVolcados := rFinVolcados;

    if (bProveedorCompra) or (AbIndirecto) then
      bExcluirIndirecto := true
    else
      bExcluirIndirecto := false;

    //buscamos costes proveedor
    kmtCostesProv.Locate('proveedor', VarArrayOf([qryEntregas.FieldByName('proveedor_ec').AsString]) , []);

    CosteEntrega;
    qryEntregasLin.First;
    while not qryEntregasLin.Eof do
    begin
      //VALORAR LINEAS
      ValorarLineaVerde;
      if ExisteLineaVerde then
        EditLineaVerde
      else
        NewLineaVerde;

      qryEntregasLin.Next;
    end;
    qryEntregas.Next;
  end;
  CalculoLiquida;
end;

function  TDLLiquidaEntrega.ExisteLineaVerde: boolean;
begin
  result:= kmtLiquidacion.Locate( 'liq_empresa;liq_anyo_semana;liq_proveedor;liq_almacen;liq_categoria;liq_cliente_sal;liq_entrega;liq_status',
       VarArrayOf([qryEntregas.fieldByName('empresa_ec').AsString,
                   qryEntregas.fieldByName('anyo_semana_ec').AsString,
                   qryEntregas.fieldByName('proveedor_ec').AsString,
                   qryEntregasLin.fieldByName('almacen').AsString,
                   qryEntregasLin.fieldByName('categoria').AsString,
                   spCliente,
                   qryEntregas.fieldByName('codigo_ec').AsString,
                   'DIRECTA']),[]);
end;

procedure TDLLiquidaEntrega.NewLineaVerde;
var
  rAux: Real;
  rPrecioCompra: Real;
begin
  kmtLiquidacion.Insert;

  kmtLiquidacion.FieldByName('liq_empresa').AsString:= qryEntregas.FieldByName('empresa_ec').AsString;
  kmtLiquidacion.FieldByName('liq_anyo_semana').AsString:= qryEntregas.FieldByName('anyo_semana_ec').AsString;
  kmtLiquidacion.FieldByName('liq_proveedor').AsString:= qryEntregas.FieldByName('proveedor_ec').AsString;
  kmtLiquidacion.FieldByName('liq_canarias').AsInteger:= qryEntregas.FieldByName('propio_p').AsInteger;
  kmtLiquidacion.FieldByName('liq_almacen').AsString:= qryEntregasLin.FieldByName('almacen').AsString;
  kmtLiquidacion.FieldByName('liq_categoria').AsString:= qryEntregasLin.FieldByName('categoria').AsString;
  kmtLiquidacion.FieldByName('liq_cliente_sal').AsString:= spCliente;
  kmtLiquidacion.FieldByName('liq_entrega').AsString:= qryEntregas.FieldByName('codigo_ec').AsString;
  kmtLiquidacion.FieldByName('liq_status').AsString:= 'DIRECTA';
  kmtLiquidacion.FieldByName('liq_calidad').AsString := 'V';

  kmtLiquidacion.FieldByName('liq_palets_confeccionados').AsInteger:= qryEntregasLin.FieldByName('palets').AsInteger;
  kmtLiquidacion.FieldByName('liq_cajas_confeccionados').AsFloat:= qryEntregasLin.FieldByName('cajas').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat:= qryEntregasLin.FieldByName('kilos').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat:= qryEntregasLin.FieldByName('kilos').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat:= qryEntregasLin.FieldByName('kilos').AsFloat;

  kmtLiquidacion.FieldByName('liq_precio_bruto').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_neto').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_descuento').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_gastos').AsFloat:= 0;

  kmtLiquidacion.FieldByName('liq_precio_material').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_personal').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_general').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_envasado').AsFloat:= 0;

  if rgPeso <> 0 then
    rAux:= bRoundTo( rgNeto / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2);
  if rgPeso <> 0 then
    rAux:= bRoundTo( rgDescuento / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2);
  if rgPeso <> 0 then
    rAux:= bRoundTo( rgGastos / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2);

  if rgPeso <> 0 then
    rAux:= bRoundTo( rgMaterial / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_material').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2);
  if rgPeso <> 0 then
    rAux:= bRoundTo( rgPersonal / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2);
  if rgPeso <> 0 then
    rAux:= bRoundTo( rgGeneral / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_general').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2);

  kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat:=
    kmtLiquidacion.FieldByName('liq_importe_material').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_general').AsFloat;


  kmtLiquidacion.FieldByName('liq_precio_compra').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rCosteEntrega, 2);

  kmtLiquidacion.FieldByName('liq_precio_beneficio').AsFloat:= 0;
//  kmtLiquidacion.FieldByName('liq_precio_financiero').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_financiero').AsFloat := rFinancieroCargados;
//  kmtLiquidacion.FieldByName('liq_precio_flete').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_flete').AsFloat:= rFlete;
  kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rBenificio, 2);
  kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rFinancieroCargados, 2);
  kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat:= bRoundTo(qryEntregasLin.FieldByName('kilos').AsFloat * rFlete, 2);
  if bExcluirIndirecto then
    kmtLiquidacion.FieldByName('liq_precio_indirecto_almacen').AsFloat := 0
  else
    kmtLiquidacion.FieldByName('liq_precio_indirecto_almacen').AsFloat := kmtCostesProv.FieldByName('costeIndirectoAlmacen').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat := bRoundTo(qryEntregasLin.FieldByName('kilos').AsFloat * kmtLiquidacion.FieldByName('liq_precio_indirecto_almacen').AsFloat, 2);


 if kmtEuroKilo.Locate('proveedor;categoria;variedad', VarArrayOf([qryEntregasLin.FieldByName('proveedor').AsString,
                                                                   qryEntregasLin.FieldByName('categoria').ASString,
                                                                   qryEntregasLin.FieldByName('variedad').AsInteger]) , []) then
   rPrecioCompra := kmtEuroKilo.FieldByName('precio').AsFloat - rFlete
 else
   rPrecioCompra := 0;

  kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat:= qryEntregasLin.FieldByName('kilos').AsFloat * rPrecioCompra;

  kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat:=
    kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat -
        (
          kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat + 
          kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat
        );
  kmtLiquidacion.FieldByName('liq_precio_liquidar').AsFloat:= 0;//kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat / rgPeso;

  kmtLiquidacion.FieldByName('liq_entrega_palets').AsInteger:= qryEntregas.FieldByName('palets').AsInteger;
  kmtLiquidacion.FieldByName('liq_entrega_cajas').AsInteger:= qryEntregas.FieldByName('cajas').AsInteger;
  kmtLiquidacion.FieldByName('liq_entrega_kilos').AsFloat:= qryEntregas.FieldByName('kilos').AsFloat;

  kmtLiquidacion.Post;
end;

procedure TDLLiquidaEntrega.EditLineaVerde;
var
  rAux, rPrecioCompra: Real;
begin
  kmtLiquidacion.Edit;

  kmtLiquidacion.FieldByName('liq_palets_confeccionados').AsInteger:= qryEntregasLin.FieldByName('palets').AsInteger +
    kmtLiquidacion.FieldByName('liq_palets_confeccionados').AsInteger;
  kmtLiquidacion.FieldByName('liq_cajas_confeccionados').AsFloat:= qryEntregasLin.FieldByName('cajas').AsFloat +
    kmtLiquidacion.FieldByName('liq_cajas_confeccionados').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat:= qryEntregasLin.FieldByName('kilos').AsFloat +
    kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat:= qryEntregasLin.FieldByName('kilos').AsFloat +
    kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat:= qryEntregasLin.FieldByName('kilos').AsFloat +
    kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat;

  //rgKilos

  if rgPeso <> 0 then
    rAux:= bRoundTo( rgNeto / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2) +
    kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat;
  if rgPeso <> 0 then
    rAux:= bRoundTo( rgDescuento / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2) +
    kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat;
  if rgPeso <> 0 then
    rAux:= bRoundTo( rgGastos / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2) +
    kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat;;

  if rgPeso <> 0 then
    rAux:= bRoundTo( rgMaterial / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_material').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2 ) +
    kmtLiquidacion.FieldByName('liq_importe_material').AsFloat;
  if rgPeso <> 0 then
    rAux:= bRoundTo( rgPersonal / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2) +
    kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat;
  if rgPeso <> 0 then
    rAux:= bRoundTo( rgGeneral / rgPeso, 5 )
  else rAux:= 0;
  kmtLiquidacion.FieldByName('liq_importe_general').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rAux, 2) +
    kmtLiquidacion.FieldByName('liq_importe_general').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat:=
    kmtLiquidacion.FieldByName('liq_importe_material').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_general').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rCosteEntrega, 2) +
    kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rBenificio, 2) +
    kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat;


  kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rFinancieroCargados, 2) +
    kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat:=  bRoundTo(qryEntregasLin.FieldByName('kilos').AsFloat * rFlete, 2) +
    kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat;

  if not bExcluirIndirecto then
    kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat := bRoundTo(qryEntregasLin.FieldByName('kilos').AsFloat * kmtCostesProv.FieldByName('costeIndirectoAlmacen').AsFloat, 2) +
      kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat;


  kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat:=
    kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat -
        (
          kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat + 
          kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').asFloat
        );


  if kmtEuroKilo.Locate('proveedor;categoria;variedad', VarArrayOf([qryEntregasLin.FieldByName('proveedor').AsString,
                                                                   qryEntregasLin.FieldByName('categoria').ASString,
                                                                   qryEntregasLin.FieldByName('variedad').AsInteger]) , []) then
   rPrecioCompra := kmtEuroKilo.FieldByName('precio').AsFloat - rFlete
  else
   rPrecioCompra := 0;

  kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat:= (qryEntregasLin.FieldByName('kilos').AsFloat * rPrecioCompra) +
      kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat;


  kmtLiquidacion.Post;
end;

function TDLLiquidaEntrega.EsProveedorALiquidar(const AEmpresa, AProveedor: string): Boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select propio_p from frf_proveedores ');
    SQL.Add('  where proveedor_p = :proveedor ');

    ParamByName('proveedor').AsString := AProveedor;
    Open;
    Result := (DMAuxDB.QAux.FieldByName('propio_p').AsInteger = 1);

    Close;
  end;
end;

procedure TDLLiquidaEntrega.ValorarPalets( const APrecios: boolean; const ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete: Real;const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: boolean);
var rFinCargados, rFinVolcados: real;
    bProveedorCompra: Boolean;
begin
  InicializaVariables;
  rBenificio:= ABenificio;
  rFinVolcados:= AFinacieroVolcados;
  rFinCargados:= AFinacieroCargados;
  rFlete:=ACosteFlete;

  if kmtTransitos.Active then
    kmtTransitos.Close;
  kmtTransitos.Open;

  //kmtPalet.Filter:= '';
  //kmtPalet.Filtered:= True;
  kmtKilosTeoricos.Close;
  kmtKilosTeoricos.Open;

  qryEntregas.First;
  while not qryEntregas.Eof do
  begin

      //comprobar si es un Proveedor de compra (propio_p)
    bProveedorCompra := not EsProveedorALiquidar(qryEntregas.FieldByName('empresa_ec').AsString, qryEntregas.FieldByName('proveedor_ec').AsString);
    if (bProveedorCompra) and (AbFinancieroCargados) then
      rFinancieroCargados := 0
    else
      rFinancieroCargados := rFinCargados;

    if (bProveedorCompra) and (AbFinancieroVolcados) then
      rFinancieroVolcados := 0
    else
      rFinancieroVolcados := rFinVolcados;

    if (bProveedorCompra) or (AbIndirecto) then
      bExcluirIndirecto := true
    else
      bExcluirIndirecto := false;

    //buscamos costes proveedor
    kmtCostesProv.Locate('proveedor', VarArrayOf([qryEntregas.FieldByName('proveedor_ec').AsString]) , []);

    CosteEntrega;
    qryPaletsPB.First;
    while not qryPaletsPB.Eof do
    begin
      //VALORAR PALETS
      ValorarPalet;
      qryPaletsPB.Next;
    end;


(*    kmtPalet.Filter:= 'pal_entrega=' + QuotedStr( qryEntregas.FieldByName('codigo_ec').AsString );
    kmtPalet.First;
    while not kmtPalet.Eof do
    begin
      //Kilos teoricos
      KilosTeoricosPalet;
      kmtPalet.Next;
    end;
*)

    qryEntregas.Next;
  end;

  //kmtPalet.Filtered:= False;
  //kmtPalet.Filter:= '';
  ValorarTransitos;
  kmtTransitos.Close;
end;


procedure TDLLiquidaEntrega.ValorarTransitos;
begin
  kmtTransitos.First;
  while not kmtTransitos.Eof do
  begin
    (*TODO*)
    //CosteTransito;

    //Seleccionar entrega
    qryEntregas.Locate( 'codigo_ec',kmtTransitos.FieldByName('tra_entrega').AsString,[]);
    CosteEntrega;
    //Base datos transito
    ConectarRemoto( kmtTransitos.FieldByName('tra_planta').AsString );
    //Palets transito

    qryPaletsPB.First;
    while not qryPaletsPB.Eof do
    begin
      //VALORAR PALETS
      ValorarPalet;
      qryPaletsPB.Next;
    end;

    kmtTransitos.Next;
  end;
end;


procedure TDLLiquidaEntrega.LiquidarEntregasVerdeExecute( const APrecios, AProveedores: boolean; const ABenificio, AFinacieroCargado, ACosteFlete: Real;
                              const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: boolean;
                              const AMinTteCliente, AMinTteCanario, AMinCosteEnvasado: Real );
begin
  DLLiquidaIncidencias.InicializarProblemas;
  AbrirTablasTemporales;
  InicializaMinimos( AMinTteCliente, AMinTteCanario, AMinCosteEnvasado );

  ValorarVerde( APrecios, ABenificio, AFinacieroCargado, ACosteFlete, AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto );
  DLLiquidaIncidencias.VerProblemas( sEmpresaIni, sSemanaIni, sProducto );

  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_categoria;liq_status';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenCategorias;

  (*
  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_status;liq_cliente_sal;liq_categoria';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenClientes;
  *)

  if AProveedores then
  begin
    kmtLiquidacion.SortFields:='liq_anyo_semana;liq_proveedor;liq_canarias;liq_almacen;liq_categoria;liq_cliente_sal;liq_status;liq_entrega';
    kmtLiquidacion.Sort([]);
    kmtLiquidacion.First;
    PrevisualizarLiquidacion( spEmpresa, sProducto, APrecios );
  end;

  kmtResumen.SortFields:='res_anyo_semana;res_categoria;res_status';
  kmtResumen.Sort([]);
  kmtResumen.First;
  PrevisualizarResumen( spEmpresa, sProducto, APrecios, 0, 0, 0, 0, 0, 0, 0, 0 );

  CerrarTablasTemporales;

end;


procedure TDLLiquidaEntrega.LiquidarEntregasExecute( const APrecios, APalets, AProveedores: boolean; const ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete: Real;
                                                     const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: Boolean;
                                                     const AMinTteCliente, AMinTteCanario, AMinCosteEnvasado: Real );
begin

  DLLiquidaIncidencias.InicializarProblemas;
  AbrirTablasTemporales;
  InicializaMinimos( AMinTteCliente, AMinTteCanario, AMinCosteEnvasado );

  ValorarPalets( APrecios, ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete, AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto );
  DLLiquidaIncidencias.VerProblemas( sEmpresaIni, sSemanaIni, sProducto );

  kmtPalet.SortFields:='pal_anyo_semana;pal_proveedor;pal_canarias;pal_almacen;pal_categoria;pal_cliente_sal;pal_status;pal_entrega;pal_precio_financiero';
  kmtPalet.Sort([]);
  kmtPalet.First;
  MakeInformeLiquidacion;

  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_categoria;liq_status;liq_calidad;liq_precio_financiero';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenCategorias;

  (*
  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_status;liq_cliente_sal;liq_categoria';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenClientes;
  *)

  if APalets then
  begin
    kmtPalet.SortFields:='pal_anyo_semana;pal_proveedor;pal_canarias;pal_almacen;pal_entrega;pal_categoria;pal_status;pal_cliente_sal;pal_fecha_sal;pal_sscc_final';
    kmtPalet.Sort([]);
    kmtPalet.First;
    PrevisualizarPalets( spEmpresa, APrecios );
  end;

  if AProveedores then
  begin
    kmtLiquidacion.SortFields:='liq_anyo_semana;liq_proveedor;liq_canarias;liq_almacen;liq_categoria;liq_cliente_sal;liq_status;liq_entrega';
    kmtLiquidacion.Sort([]);
    kmtLiquidacion.First;
    PrevisualizarLiquidacion( spEmpresa, sProducto, APrecios );
  end;

  kmtResumen.SortFields:='res_anyo_semana;res_categoria;res_status';
  kmtResumen.Sort([]);
  kmtResumen.First;
  PrevisualizarResumen( spEmpresa, sProducto, APrecios, 0, 0, 0, 0, 0, 0, 0, 0 );


  CerrarTablasTemporales;
end;

procedure TDLLiquidaEntrega.MakeInformeLiquidacion;
var
  sClienteVenta, sTipoVenta: string;
begin
  while not kmtPalet.Eof do
  begin
    if kmtPalet.FieldByName('pal_status').AsString = 'P' then
    begin
      sTipoVenta:= 'PLACERO';
      if kmtPalet.FieldByName('pal_cliente_sal').AsString = '' then
      begin
        sClienteVenta:= '###';
      end
      else
      begin
        sClienteVenta:= kmtPalet.FieldByName('pal_cliente_sal').AsString;
      end;
    end
    else
    if kmtPalet.FieldByName('pal_status').AsString = 'D' then
    begin
      sTipoVenta:= 'DESTRIO';
      sClienteVenta:= 'ZZZ';
    end
    else
    if kmtPalet.FieldByName('pal_status').AsString = 'C' then
    begin
      sTipoVenta:= 'DIRECTA';
      if kmtPalet.FieldByName('pal_cliente_sal').AsString = '' then
      begin
        sClienteVenta:= '###';
      end
      else
      begin
        sClienteVenta:= kmtPalet.FieldByName('pal_cliente_sal').AsString;
      end;
    end
    else
    begin
      sTipoVenta:= 'VOLCADO';
      if kmtPalet.FieldByName('pal_cliente_sal').AsString = '' then
      begin
        sClienteVenta:= '###';
      end
      else
      begin
        sClienteVenta:= kmtPalet.FieldByName('pal_cliente_sal').AsString;
      end;
    end;


    if ExistLineaLiquida( sClienteVenta, sTipoVenta ) then
      EditLineaLiquida
    else
      NewLineaLiquida( sClienteVenta, sTipoVenta );
    kmtPalet.Next;
  end;
  CalculoLiquida;
end;

function  TDLLiquidaEntrega.ExistLineaLiquida( const ACliente, ATipoVenta: string ): boolean;
begin
  result:= kmtLiquidacion.Locate( 'liq_empresa;liq_anyo_semana;liq_proveedor;liq_almacen;liq_categoria;liq_cliente_sal;liq_entrega;liq_status;liq_precio_financiero',
       VarArrayOf([kmtPalet.fieldByName('pal_empresa').AsString,
                   kmtPalet.fieldByName('pal_anyo_semana').AsString,
                   kmtPalet.fieldByName('pal_proveedor').AsString,
                   kmtPalet.fieldByName('pal_almacen').AsString,
                   kmtPalet.fieldByName('pal_categoria').AsString,
                   ACliente,
                   kmtPalet.fieldByName('pal_entrega').AsString,
                   ATipoVenta,
                   kmtPalet.FieldByName('pal_precio_financiero').AsString]),[]);
end;

procedure TDLLiquidaEntrega.NewLineaLiquida( const ACliente, ATipoVenta: string );
var rPrecioCompra: Real;
begin
  kmtLiquidacion.Insert;

  kmtLiquidacion.FieldByName('liq_empresa').AsString:= kmtPalet.FieldByName('pal_empresa').AsString;
  kmtLiquidacion.FieldByName('liq_anyo_semana').AsString:= kmtPalet.FieldByName('pal_anyo_semana').AsString;
  kmtLiquidacion.FieldByName('liq_proveedor').AsString:= kmtPalet.FieldByName('pal_proveedor').AsString;
  kmtLiquidacion.FieldByName('liq_canarias').AsInteger:= kmtPalet.FieldByName('pal_canarias').AsInteger;
  kmtLiquidacion.FieldByName('liq_almacen').AsString:= kmtPalet.FieldByName('pal_almacen').AsString;
  kmtLiquidacion.FieldByName('liq_categoria').AsString:= kmtPalet.FieldByName('pal_categoria').AsString;
  kmtLiquidacion.FieldByName('liq_cliente_sal').AsString:= ACliente;
  kmtLiquidacion.FieldByName('liq_entrega').AsString:= kmtPalet.FieldByName('pal_entrega').AsString;
  kmtLiquidacion.FieldByName('liq_status').AsString:= ATipoVenta;
  kmtLiquidacion.FieldByName('liq_calidad').AsString := kmtPalet.FieldbyName('pal_calidad').AsString;

  kmtLiquidacion.FieldByName('liq_palets_confeccionados').AsInteger:= kmtPalet.FieldByName('pal_palet').AsInteger;
  kmtLiquidacion.FieldByName('liq_cajas_confeccionados').AsFloat:= kmtPalet.FieldByName('pal_cajas_confeccionados').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat:= kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat:= kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat:= kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat;


  kmtLiquidacion.FieldByName('liq_precio_bruto').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_neto').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_descuento').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_gastos').AsFloat:= 0;

  kmtLiquidacion.FieldByName('liq_precio_material').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_personal').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_general').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_envasado').AsFloat:= 0;

  if kmtLiquidacion.FieldByName('liq_cliente_sal').AsString <> '' then
  begin
    kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat:= kmtPalet.FieldByName('pal_importe_neto').AsFloat;
    kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat:= kmtPalet.FieldByName('pal_importe_descuento').AsFloat;
    kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat:= kmtPalet.FieldByName('pal_importe_gastos').AsFloat;

    kmtLiquidacion.FieldByName('liq_importe_material').AsFloat:= kmtPalet.FieldByName('pal_importe_material').AsFloat;
    kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat:= kmtPalet.FieldByName('pal_importe_personal').AsFloat;
    kmtLiquidacion.FieldByName('liq_importe_general').AsFloat:= kmtPalet.FieldByName('pal_importe_general').AsFloat;
    kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat:= kmtPalet.FieldByName('pal_importe_envasado').AsFloat;
  end
  else
  begin
    kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat:= kmtPalet.FieldByName('pal_importe_neto').AsFloat;
    kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat:= kmtPalet.FieldByName('pal_importe_descuento').AsFloat;
    kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat:= kmtPalet.FieldByName('pal_importe_gastos').AsFloat;

    kmtLiquidacion.FieldByName('liq_importe_material').AsFloat:= kmtPalet.FieldByName('pal_importe_material').AsFloat;
    kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat:= kmtPalet.FieldByName('pal_importe_personal').AsFloat;
    kmtLiquidacion.FieldByName('liq_importe_general').AsFloat:= kmtPalet.FieldByName('pal_importe_general').AsFloat;
    kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat:= kmtPalet.FieldByName('pal_importe_envasado').AsFloat;
  end;


  kmtLiquidacion.FieldByName('liq_precio_compra').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat:= kmtPalet.FieldByName('pal_importe_compra').AsFloat;

  kmtLiquidacion.FieldByName('liq_precio_beneficio').AsFloat:= 0;
//  kmtLiquidacion.FieldByName('liq_precio_financiero').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_financiero').AsFloat:= kmtPalet.FieldByName('pal_precio_financiero').AsFloat;
//  kmtLiquidacion.FieldByName('liq_precio_flete').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_flete').AsFloat:= rFlete;
  kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat:= kmtPalet.FieldByName('pal_importe_beneficio').AsFloat;
  kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat:= kmtPalet.FieldByName('pal_importe_financiero').AsFloat;
  kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat:= kmtPalet.FieldByName('pal_importe_flete').AsFloat;
  kmtLiquidacion.FieldByName('liq_precio_indirecto_almacen').AsFloat := kmtPalet.FieldByName('pal_precio_ind_almacen').AsFloat;
  kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat := kmtPalet.FieldByName('pal_importe_ind_almacen').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_precio_liquidar').AsFloat:= 0;

  if kmtEuroKilo.Locate('proveedor;categoria;variedad', VarArrayOf([kmtPalet.FieldByName('pal_proveedor').AsString,
                                                                   kmtPalet.FieldByName('pal_categoria').ASString,
                                                                   kmtPalet.FieldByName('pal_variedad').AsInteger]) , []) then
   if aTipoVenta = 'DESTRIO' then
     rPrecioCompra := kmtEuroKilo.FieldByName('precio').AsFloat
   else
     rPrecioCompra := kmtEuroKilo.FieldByName('precio').AsFloat - rFlete
  else
   rPrecioCompra := 0;

  kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat:= kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat * rPrecioCompra;


  kmtLiquidacion.FieldByName('liq_entrega_palets').AsInteger:= kmtPalet.FieldByName('pal_entrega_palets').AsInteger;
  kmtLiquidacion.FieldByName('liq_entrega_cajas').AsInteger:= kmtPalet.FieldByName('pal_entrega_cajas').AsInteger;
  kmtLiquidacion.FieldByName('liq_entrega_kilos').AsFloat:= kmtPalet.FieldByName('pal_entrega_kilos').AsFloat;

  kmtLiquidacion.Post;

end;

procedure TDLLiquidaEntrega.EditLineaLiquida;
var rPrecioCompra:Real;
begin
  kmtLiquidacion.Edit;

  kmtLiquidacion.FieldByName('liq_palets_confeccionados').AsInteger:= kmtPalet.FieldByName('pal_palet').AsInteger +
    kmtLiquidacion.FieldByName('liq_palets_confeccionados').AsInteger;
  kmtLiquidacion.FieldByName('liq_cajas_confeccionados').AsFloat:= kmtPalet.FieldByName('pal_cajas_confeccionados').AsFloat +
    kmtLiquidacion.FieldByName('liq_cajas_confeccionados').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat:= kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat +
    kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat:= kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat +
    kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat;
  kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat:= kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat +
   kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat:= kmtPalet.FieldByName('pal_importe_neto').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat;
  kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat:= kmtPalet.FieldByName('pal_importe_descuento').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_material').AsFloat:= kmtPalet.FieldByName('pal_importe_material').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_material').AsFloat;
  kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat:= kmtPalet.FieldByName('pal_importe_personal').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat;
  kmtLiquidacion.FieldByName('liq_importe_general').AsFloat:= kmtPalet.FieldByName('pal_importe_general').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_general').AsFloat;
  kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat:= kmtPalet.FieldByName('pal_importe_envasado').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat:= kmtPalet.FieldByName('pal_importe_gastos').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat;
  kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat:= kmtPalet.FieldByName('pal_importe_compra').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat:= kmtPalet.FieldByName('pal_importe_beneficio').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat;
  kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat:= kmtPalet.FieldByName('pal_importe_financiero').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat:= kmtPalet.FieldByName('pal_importe_flete').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat:= kmtPalet.FieldByName('pal_importe_ind_almacen').AsFloat +
    kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat;

  if kmtEuroKilo.Locate('proveedor;categoria;variedad', VarArrayOf([kmtPalet.FieldByName('pal_proveedor').AsString,
                                                                   kmtPalet.FieldByName('pal_categoria').ASString,
                                                                   kmtPalet.FieldByName('pal_variedad').AsInteger]) , []) then
   if kmtLiquidacion.FieldByName('liq_status').AsString = 'DESTRIO' then
     rPrecioCompra := kmtEuroKilo.FieldByName('precio').AsFloat
   else
     rPrecioCompra := kmtEuroKilo.FieldByName('precio').AsFloat - rFlete
  else
   rPrecioCompra := 0;

  kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat:= (kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat * rPrecioCompra) +
    kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat;


  kmtLiquidacion.Post;
end;

procedure TDLLiquidaEntrega.CalculoLiquida;
var
  rKilos, rKilosLiq: Real;
begin
  kmtLiquidacion.First;
  while not kmtLiquidacion.Eof do
  begin
    //rKilos:= kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat;
    rKilos:= kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat;//son los que vamos a pagar
    rKilosLiq:= kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat;//son los de RF aprovechados
    if rKilos <> 0 then
    begin
      kmtLiquidacion.Edit;
      kmtLiquidacion.FieldByName('liq_precio_neto').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat / rKilos;
      if rKilosLiq <> 0 then
        kmtLiquidacion.FieldByName('liq_precio_bruto').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat / rKilosLiq
      else
        kmtLiquidacion.FieldByName('liq_precio_bruto').AsFloat:= 0;
      kmtLiquidacion.FieldByName('liq_precio_descuento').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat / rKilos;
      kmtLiquidacion.FieldByName('liq_precio_gastos').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat / rKilos;
      kmtLiquidacion.FieldByName('liq_precio_material').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_material').AsFloat / rKilos;
      kmtLiquidacion.FieldByName('liq_precio_personal').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat / rKilos;
      kmtLiquidacion.FieldByName('liq_precio_general').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_general').AsFloat / rKilos;
      kmtLiquidacion.FieldByName('liq_precio_envasado').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat / rKilos;
      kmtLiquidacion.FieldByName('liq_precio_compra').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat / rKilos;
      kmtLiquidacion.FieldByName('liq_precio_beneficio').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat / rKilos;
//      kmtLiquidacion.FieldByName('liq_precio_financiero').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat / rKilos;
//      kmtLiquidacion.FieldByName('liq_precio_flete').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat / rKilos;

      kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat -
        (
          kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat + 
          kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat
        );
      kmtLiquidacion.FieldByName('liq_precio_liquidar').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat / rKilos;

      kmtLiquidacion.Post;
    end;
    kmtLiquidacion.Next;
  end;
end;

//
//

procedure TDLLiquidaEntrega.MakeResumenCategorias;
var
  sTipoVenta: string;
begin
  while not kmtLiquidacion.Eof do
  begin
    if ( kmtLiquidacion.FieldByName('liq_status').AsString = 'DESTRIO' ) then
    begin
      sTipoVenta:= '4.-DESTRIO';
    end
    else
    if ( kmtLiquidacion.FieldByName('liq_status').AsString = 'PLACERO' ) then
    begin
      sTipoVenta:= '3.-PLACERO';
    end
    else
    if kmtLiquidacion.FieldByName('liq_status').AsString = 'DIRECTA' then
    begin
      sTipoVenta:= '2.-DIRECTA';
    end
    else
    begin
      sTipoVenta:= '1.-VOLCADO';
    end;

    if ExistLineaResumen( sTipoVenta ) then
      EditLineaResumen
    else
      NewLineaResumen( sTipoVenta );

    kmtLiquidacion.Next;
  end;
  CalculoResumen;
end;

function  TDLLiquidaEntrega.ExistLineaResumen( const ATipoVenta: string ): boolean;
begin
  result:= kmtResumen.Locate( 'res_anyo_semana;res_categoria;res_status;res_precio_financiero',
       VarArrayOf([ kmtLiquidacion.fieldByName('liq_anyo_semana').AsString,
                    kmtLiquidacion.fieldByName('liq_categoria').AsString,
                    ATipoVenta,
                    kmtLiquidacion.FieldByName('liq_precio_financiero').AsFloat
                    ]),[]);
end;

procedure TDLLiquidaEntrega.NewLineaResumen( const ATipoVenta: string );
var rPrecioCompra, rKilosDestrioTfe: Real;
begin
  kmtResumen.Insert;

  kmtResumen.FieldByName('res_anyo_semana').AsString:= kmtLiquidacion.FieldByName('liq_anyo_semana').AsString;
  kmtResumen.FieldByName('res_categoria').AsString:= kmtLiquidacion.FieldByName('liq_categoria').AsString;
  kmtResumen.FieldByName('res_status').AsString:= ATipoVenta;
  kmtResumen.FieldByName('res_calidad').AsString := kmtLiquidacion.FieldByName('liq_calidad').AsString;

  kmtResumen.FieldByName('res_entrega_cajas').AsInteger:= kmtLiquidacion.FieldByName('liq_entrega_cajas').AsInteger;
  kmtResumen.FieldByName('res_entrega_kilos').AsFloat:= kmtLiquidacion.FieldByName('liq_entrega_kilos').AsFloat;

  kmtResumen.FieldByName('res_cajas_confeccionados').AsFloat:= kmtLiquidacion.FieldByName('liq_cajas_confeccionados').AsFloat;
  kmtResumen.FieldByName('res_kilos_confeccionados').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat;
  kmtResumen.FieldByName('res_kilos_teoricos').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat;
  kmtResumen.FieldByName('res_kilos_liquidar').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat;

  kmtResumen.FieldByName('res_precio_neto').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_descuento').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_gastos').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_material').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_personal').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_general').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_envasado').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_compra').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_beneficio').AsFloat:= 0;
//  kmtResumen.FieldByName('res_precio_financiero').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_financiero').AsFloat := kmtLiquidacion.FieldByName('liq_precio_financiero').AsFloat;
//  kmtResumen.FieldByName('res_precio_flete').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_flete').AsFloat:= kmtLiquidacion.FieldByName('liq_precio_flete').AsFloat;
  kmtResumen.FieldByName('res_precio_liquidar').AsFloat:= 0;
  kmtResumen.FieldByName('res_precio_indirecto_almacen').AsFloat:= kmtLiquidacion.FieldByName('liq_precio_indirecto_almacen').AsFloat;

  kmtResumen.FieldByName('res_importe_neto').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat;
  kmtResumen.FieldByName('res_importe_descuento').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat;
  kmtResumen.FieldByName('res_importe_gastos').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat;

  kmtResumen.FieldByName('res_importe_material').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_material').AsFloat;
  kmtResumen.FieldByName('res_importe_personal').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat;
  kmtResumen.FieldByName('res_importe_general').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_general').AsFloat;
  kmtResumen.FieldByName('res_importe_envasado').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat;
  kmtResumen.FieldByName('res_importe_indirecto_almacen').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat;

  kmtResumen.FieldByName('res_importe_compra').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat;
  kmtResumen.FieldByName('res_importe_beneficio').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat;
  kmtResumen.FieldByName('res_importe_financiero').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat;
  kmtResumen.FieldByName('res_importe_flete').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat;

  kmtResumen.FieldByName('res_importe_liquidar').AsFloat:= 0;

  if kmtLiquidacion.FieldByName('liq_canarias').AsInteger = 1 then
  begin
    kmtResumen.FieldByName('res_kilos_canarias').AsFloat := kmtResumen.FieldByName('res_kilos_canarias').AsFloat +
                                                            kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat;
    kmtResumen.FieldByName('res_importe_canarias').AsFloat := kmtResumen.FieldByName('res_importe_canarias').AsFloat +
                                                              kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat;

  end
  else
  begin
    kmtResumen.FieldByName('res_kilos_no_canarias').AsFloat := kmtResumen.FieldByName('res_kilos_no_canarias').AsFloat +
                                                               kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat;
    kmtResumen.FieldByName('res_importe_no_canarias').AsFloat := kmtResumen.FieldByName('res_importe_no_canarias').AsFloat +
                                                                 kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat;


  end;
  kmtResumen.Post;

end;


procedure TDLLiquidaEntrega.EditLineaResumen;
var rPrecioCompra: Real;
begin
  kmtResumen.Edit;

  kmtResumen.FieldByName('res_cajas_confeccionados').AsFloat:= kmtLiquidacion.FieldByName('liq_cajas_confeccionados').AsFloat +
    kmtResumen.FieldByName('res_cajas_confeccionados').AsFloat;
  kmtResumen.FieldByName('res_kilos_confeccionados').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat +
    kmtResumen.FieldByName('res_kilos_confeccionados').AsFloat;
  kmtResumen.FieldByName('res_kilos_teoricos').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat +
    kmtResumen.FieldByName('res_kilos_teoricos').AsFloat;
  kmtResumen.FieldByName('res_kilos_liquidar').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat +
   kmtResumen.FieldByName('res_kilos_liquidar').AsFloat;

  kmtResumen.FieldByName('res_importe_neto').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat +
    kmtResumen.FieldByName('res_importe_neto').AsFloat;
  kmtResumen.FieldByName('res_importe_descuento').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat +
    kmtResumen.FieldByName('res_importe_descuento').AsFloat;

  kmtResumen.FieldByName('res_importe_material').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_material').AsFloat +
    kmtResumen.FieldByName('res_importe_material').AsFloat;
  kmtResumen.FieldByName('res_importe_personal').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat +
    kmtResumen.FieldByName('res_importe_personal').AsFloat;
  kmtResumen.FieldByName('res_importe_general').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_general').AsFloat +
    kmtResumen.FieldByName('res_importe_general').AsFloat;
  kmtResumen.FieldByName('res_importe_envasado').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat +
    kmtResumen.FieldByName('res_importe_envasado').AsFloat;

  kmtResumen.FieldByName('res_importe_gastos').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat +
    kmtResumen.FieldByName('res_importe_gastos').AsFloat;
  kmtResumen.FieldByName('res_importe_compra').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat +
    kmtResumen.FieldByName('res_importe_compra').AsFloat;

  kmtResumen.FieldByName('res_importe_beneficio').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat +
    kmtResumen.FieldByName('res_importe_beneficio').AsFloat;
  kmtResumen.FieldByName('res_importe_financiero').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat +
    kmtResumen.FieldByName('res_importe_financiero').AsFloat;
  kmtResumen.FieldByName('res_importe_flete').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat +
    kmtResumen.FieldByName('res_importe_flete').AsFloat;

  kmtResumen.FieldByName('res_importe_indirecto_almacen').asFloat := kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').asFloat +
    kmtResumen.FieldByName('res_importe_indirecto_almacen').asFloat;

// if kmtEuroKilo.Locate('categoria', VarArrayOf([kmtResumen.FieldByName('res_categoria').ASString]) , []) then
//   rPrecioCompra := kmtEuroKilo.FieldByName('precio').AsFloat
// else
//   rPrecioCompra := 0;

  if kmtLiquidacion.FieldByName('liq_canarias').AsInteger = 1 then
  begin
    kmtResumen.FieldByName('res_kilos_canarias').AsFloat := kmtResumen.FieldByName('res_kilos_canarias').AsFloat +
                                                            kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat;
    kmtResumen.FieldByName('res_importe_canarias').AsFloat := kmtResumen.FieldByName('res_importe_canarias').AsFloat +
                                                              kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat;

  end
  else
  begin
    kmtResumen.FieldByName('res_kilos_no_canarias').AsFloat := kmtResumen.FieldByName('res_kilos_no_canarias').AsFloat +
                                                            kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat;
    kmtResumen.FieldByName('res_importe_no_canarias').AsFloat := kmtResumen.FieldByName('res_importe_no_canarias').AsFloat +
                                                              kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat;

                                                            
  end;

  kmtResumen.Post;
end;

procedure TDLLiquidaEntrega.CalculoResumen;
var
  rKilos: Real;
begin
  kmtResumen.First;
  while not kmtResumen.Eof do
  begin
    rKilos:= kmtResumen.FieldByName('res_kilos_teoricos').AsFloat;//son los que vamos a pagar
    if rKilos <> 0 then
    begin
      kmtResumen.Edit;
      kmtResumen.FieldByName('res_precio_neto').AsFloat:= kmtResumen.FieldByName('res_importe_neto').AsFloat / rKilos;
      kmtResumen.FieldByName('res_precio_descuento').AsFloat:= kmtResumen.FieldByName('res_importe_descuento').AsFloat / rKilos;
      kmtResumen.FieldByName('res_precio_gastos').AsFloat:= kmtResumen.FieldByName('res_importe_gastos').AsFloat / rKilos;
      kmtResumen.FieldByName('res_precio_material').AsFloat:= kmtResumen.FieldByName('res_importe_material').AsFloat / rKilos;
      kmtResumen.FieldByName('res_precio_personal').AsFloat:= kmtResumen.FieldByName('res_importe_personal').AsFloat / rKilos;
      kmtResumen.FieldByName('res_precio_general').AsFloat:= kmtResumen.FieldByName('res_importe_general').AsFloat / rKilos;
      kmtResumen.FieldByName('res_precio_envasado').AsFloat:= kmtResumen.FieldByName('res_importe_envasado').AsFloat / rKilos;
      kmtResumen.FieldByName('res_precio_compra').AsFloat:= kmtResumen.FieldByName('res_importe_compra').AsFloat / rKilos;
      kmtResumen.FieldByName('res_precio_beneficio').AsFloat:= kmtResumen.FieldByName('res_importe_beneficio').AsFloat / rKilos;
      kmtResumen.FieldByName('res_precio_indirecto_almacen').asFloat := kmtResumen.FieldByName('res_importe_indirecto_almacen').asFloat / rKilos;
//      kmtResumen.FieldByName('res_precio_financiero').AsFloat:= kmtResumen.FieldByName('res_importe_financiero').AsFloat / rKilos;
//      kmtResumen.FieldByName('res_precio_flete').AsFloat:= kmtResumen.FieldByName('res_importe_flete').AsFloat / rKilos;

      kmtResumen.FieldByName('res_importe_liquidar').AsFloat:= kmtResumen.FieldByName('res_importe_neto').AsFloat -
        (
          kmtResumen.FieldByName('res_importe_descuento').AsFloat +
          kmtResumen.FieldByName('res_importe_gastos').AsFloat +
          kmtResumen.FieldByName('res_importe_envasado').AsFloat +
          kmtResumen.FieldByName('res_importe_compra').AsFloat +
          kmtResumen.FieldByName('res_importe_beneficio').AsFloat +
          kmtResumen.FieldByName('res_importe_financiero').AsFloat +
          kmtResumen.FieldByName('res_importe_flete').AsFloat +
          kmtResumen.FieldByName('res_importe_indirecto_almacen').asFloat
        );
      kmtResumen.FieldByName('res_precio_liquidar').AsFloat:= kmtResumen.FieldByName('res_importe_liquidar').AsFloat / rKilos;

      kmtResumen.Post;
    end;
    kmtResumen.Next;
  end;
end;



//***********************************************************************************************************************
//***********************************************************************************************************************



procedure TDLLiquidaEntrega.MakeResumenClientes;
var
  sTipoVenta: string;
begin
  while not kmtLiquidacion.Eof do
  begin
    if ( kmtLiquidacion.FieldByName('liq_status').AsString = 'DESTRIO' ) then
    begin
      sTipoVenta:= '4.-DESTRIO';
    end
    else
    if ( kmtLiquidacion.FieldByName('liq_status').AsString = 'PLACERO' ) then
    begin
      sTipoVenta:= '3.-PLACERO';
    end
    else
    if kmtLiquidacion.FieldByName('liq_status').AsString = 'DIRECTA' then
    begin
      sTipoVenta:= '2.-DIRECTA';
    end
    else
    begin
      sTipoVenta:= '1.-VOLCADO';
    end;

    if ExistLineaClientes( sTipoVenta ) then
      EditLineaClientes
    else
      NewLineaClientes( sTipoVenta );
    kmtLiquidacion.Next;
  end;
  CalculoClientes;
end;

function  TDLLiquidaEntrega.ExistLineaClientes( const ATipoVenta: string ): boolean;
begin
  result:= kmtClientes.Locate( 'res_anyo_semana;res_status;res_cliente;res_categoria',
       VarArrayOf([ kmtLiquidacion.fieldByName('liq_anyo_semana').AsString,
                    ATipoVenta,
                    kmtLiquidacion.fieldByName('liq_cliente_sal').AsString,
                    kmtLiquidacion.fieldByName('liq_categoria').AsString ]),[]);
end;

procedure TDLLiquidaEntrega.NewLineaClientes( const ATipoVenta: string );

begin
  kmtClientes.Insert;

  kmtClientes.FieldByName('res_anyo_semana').AsString:= kmtLiquidacion.FieldByName('liq_anyo_semana').AsString;
  kmtClientes.FieldByName('res_status').AsString:= ATipoVenta;
  kmtClientes.FieldByName('res_calidad').AsString:= kmtLiquidacion.FieldByName('liq_calidad').AsString;
  kmtClientes.FieldByName('res_cliente').AsString:= kmtLiquidacion.FieldByName('liq_cliente_sal').AsString;
  kmtClientes.FieldByName('res_categoria').AsString:= kmtLiquidacion.FieldByName('liq_categoria').AsString;


  kmtClientes.FieldByName('res_entrega_cajas').AsInteger:= kmtLiquidacion.FieldByName('liq_entrega_cajas').AsInteger;
  kmtClientes.FieldByName('res_entrega_kilos').AsFloat:= kmtLiquidacion.FieldByName('liq_entrega_kilos').AsFloat;

  kmtClientes.FieldByName('res_cajas_confeccionados').AsFloat:= kmtLiquidacion.FieldByName('liq_cajas_confeccionados').AsFloat;
  kmtClientes.FieldByName('res_kilos_confeccionados').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat;
  kmtClientes.FieldByName('res_kilos_teoricos').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat;
  kmtClientes.FieldByName('res_kilos_liquidar').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat;

  kmtClientes.FieldByName('res_precio_bruto').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_neto').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_descuento').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_gastos').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_material').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_personal').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_general').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_envasado').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_compra').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_beneficio').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_indirecto_almacen').AsFloat:= kmtLiquidacion.FieldByName('liq_precio_indirecto_almacen').AsFloat;
//  kmtClientes.FieldByName('res_precio_financiero').AsFloat:= 0;
  kmtClientes.FieldbyName('res_precio_financiero').AsFloat := kmtLiquidacion.FieldByName('liq_precio_financiero').AsFloat;
//  kmtClientes.FieldByName('res_precio_flete').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_flete').AsFloat:= kmtLiquidacion.FieldByName('liq_precio_flete').AsFloat;
  kmtClientes.FieldByName('res_precio_liquidar').AsFloat:= 0;
  kmtClientes.FieldByName('res_precio_kilo').AsFloat:= 0;
  kmtClientes.FieldByName('res_total_compra').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat;
  kmtClientes.FieldByName('res_margen_kilo').AsFloat:= 0;
  kmtClientes.FieldByName('res_margen_total').AsFloat:= 0;
  kmtClientes.FieldByName('res_coste_prod').AsFloat:= 0;
  kmtClientes.FieldByName('res_coste_env').AsFloat:= 0;
  kmtClientes.FieldByName('res_coste_opp').AsFloat:= 0;
  kmtClientes.FieldByName('res_coste_ayu').AsFloat:= 0;
  kmtClientes.FieldByName('res_coste_margen').AsFloat:= 0;

  kmtClientes.FieldByName('res_importe_neto').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat;
  kmtClientes.FieldByName('res_importe_descuento').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat;
  kmtClientes.FieldByName('res_importe_gastos').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat;

  kmtClientes.FieldByName('res_importe_material').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_material').AsFloat;
  kmtClientes.FieldByName('res_importe_personal').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat;
  kmtClientes.FieldByName('res_importe_general').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_general').AsFloat;
  kmtClientes.FieldByName('res_importe_envasado').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat;

  kmtClientes.FieldByName('res_importe_compra').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat;
  kmtClientes.FieldByName('res_importe_beneficio').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat;
  kmtClientes.FieldByName('res_importe_financiero').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat;
  kmtClientes.FieldByName('res_importe_flete').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat;
  kmtClientes.FieldByName('res_importe_indirecto_almacen').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat;

  kmtClientes.FieldByName('res_importe_liquidar').AsFloat:= 0;

  kmtClientes.Post;

end;

procedure TDLLiquidaEntrega.EditLineaClientes;
begin
  kmtClientes.Edit;

  kmtClientes.FieldByName('res_cajas_confeccionados').AsFloat:= kmtLiquidacion.FieldByName('liq_cajas_confeccionados').AsFloat +
    kmtClientes.FieldByName('res_cajas_confeccionados').AsFloat;
  kmtClientes.FieldByName('res_kilos_confeccionados').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_confeccionados').AsFloat +
    kmtClientes.FieldByName('res_kilos_confeccionados').AsFloat;
  kmtClientes.FieldByName('res_kilos_teoricos').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_teoricos').AsFloat +
    kmtClientes.FieldByName('res_kilos_teoricos').AsFloat;
  kmtClientes.FieldByName('res_kilos_liquidar').AsFloat:= kmtLiquidacion.FieldByName('liq_kilos_liquidar').AsFloat +
   kmtClientes.FieldByName('res_kilos_liquidar').AsFloat;

  kmtClientes.FieldByName('res_importe_neto').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat +
    kmtClientes.FieldByName('res_importe_neto').AsFloat;
  kmtClientes.FieldByName('res_importe_descuento').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat +
    kmtClientes.FieldByName('res_importe_descuento').AsFloat;

  kmtClientes.FieldByName('res_importe_material').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_material').AsFloat +
    kmtClientes.FieldByName('res_importe_material').AsFloat;
  kmtClientes.FieldByName('res_importe_personal').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_personal').AsFloat +
    kmtClientes.FieldByName('res_importe_personal').AsFloat;
  kmtClientes.FieldByName('res_importe_general').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_general').AsFloat +
    kmtClientes.FieldByName('res_importe_general').AsFloat;
  kmtClientes.FieldByName('res_importe_envasado').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat +
    kmtClientes.FieldByName('res_importe_envasado').AsFloat;

  kmtClientes.FieldByName('res_importe_gastos').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat +
    kmtClientes.FieldByName('res_importe_gastos').AsFloat;
  kmtClientes.FieldByName('res_importe_compra').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat +
    kmtClientes.FieldByName('res_importe_compra').AsFloat;

  kmtClientes.FieldByName('res_importe_beneficio').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_beneficio').AsFloat +
    kmtClientes.FieldByName('res_importe_beneficio').AsFloat;
  kmtClientes.FieldByName('res_importe_financiero').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat +
    kmtClientes.FieldByName('res_importe_financiero').AsFloat;
  kmtClientes.FieldByName('res_importe_flete').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_flete').AsFloat +
    kmtClientes.FieldByName('res_importe_flete').AsFloat;
  kmtClientes.FieldByName('res_total_compra').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_por_precio').AsFloat +
    kmtClientes.FieldByName('res_total_compra').AsFloat;
  kmtClientes.FieldByName('res_importe_indirecto_almacen').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_indirecto_almacen').AsFloat +
    kmtClientes.FieldByName('res_importe_indirecto_almacen').AsFloat;



  kmtClientes.Post;
end;

procedure TDLLiquidaEntrega.CalcularEuroKilo( const sEmpresa, sAnyoSem, sProveedor, sProductor, sProducto, sEntrega: string);
begin

  with qryEuroKilo do
  begin
    SQL.Clear;
    SQL.Add(' select proveedor_ec, categoria_el, variedad_el, sum(kilos_el) kilos,   ');
    SQL.Add(' sum(kilos_el*(case when propio_p= 1 then (select precio_kg_pl from frf_precio_liquidacion where empresa_pl = empresa_ec          ');
    SQL.Add('                                                                   												  and proveedor_pl = proveedor_ec      ');
    SQL.Add('                                                                   												  and anyo_semana_pl = anyo_semana_ec  ');
    SQL.Add('                                                                   												  and producto_pl = producto_el        ');
    SQL.Add('                                                                   												  and categoria_pl = categoria_el      ');
    SQL.Add('                                                                   												  and variedad_pl = variedad_el)       ');
    SQL.Add('              else precio_el end)) importe,                                                                                       ');
    SQL.Add(' sum(kilos_el*(case when propio_p= 1 then (select precio_kg_pl from frf_precio_liquidacion where empresa_pl = empresa_ec          ');
    SQL.Add('                                                                   												  and proveedor_pl = proveedor_ec      ');
    SQL.Add('                                                                   												  and anyo_semana_pl = anyo_semana_ec  ');
    SQL.Add('                                                                   												  and producto_pl = producto_el        ');
    SQL.Add('                                                                   												  and categoria_pl = categoria_el      ');
    SQL.Add('                                                                   												  and variedad_pl = variedad_el)       ');
    SQL.Add('              else precio_el end)) / sum(kilos_el ) precio                                                                        ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l, frf_proveedores                                      ');
//    SQL.Add(' where producto_el = ''PLA'' ');
    SQL.Add(' where 1 = 1 ');
    if sEmpresa <> '' then
      if sEmpresa = 'BAG' then
        SQL.Add(' and empresa_ec in (''F17'', ''F23'', ''F24'', ''F42'') ')
      else
        SQL.Add(' and empresa_ec = :empresa ');

    if sAnyoSem <> '' then
      SQL.Add(' and anyo_semana_ec = :anyo_semana ');

    if sProveedor <> '' then
      SQL.Add(' and proveedor_ec = :proveedor ');

    if sProductor <> '' then
      SQL.Add(' and almacen_el = :productor ');

    if sProducto <> '' then
      SQL.Add(' and producto_ec = :producto ');

    if sEntrega <> '' then
      SQL.Add(' and codigo_ec = :entrega ');

    SQL.Add('   and codigo_ec = codigo_el  ');

    SQL.Add('  and proveedor_p = proveedor_ec ');
    SQL.Add(' group by 1,2,3' );

    if sEmpresa <> '' then
      if sEmpresa <> 'BAG' then
        ParamByName('empresa').AsString := sEmpresa;
    if sAnyoSem <> '' then
      ParamByName('anyo_semana').AsString := sAnyoSem;
    if sProveedor <> '' then
      ParamByName('proveedor').AsString := sProveedor;
    if sProductor <> '' then
      ParamByName('productor').AsString := sProductor;
    if sProducto <> '' then
      ParamByName('producto').AsString := sProducto;
    if sEntrega <> '' then
      ParamByName('entrega').AsString := sEntrega;

    Open;
    while not Eof do
    begin
      kmtEuroKilo.Insert;

      kmtEuroKilo.FieldByName('proveedor').AsString := qryEuroKilo.FieldByName('proveedor_ec').AsString;
      kmtEuroKilo.FieldByName('categoria').AsString := qryEuroKilo.FieldByName('categoria_el').AsString;
      kmtEuroKilo.FieldByName('variedad').AsInteger := qryEuroKilo.FieldByName('variedad_el').AsInteger;
      kmtEuroKilo.FieldByName('kilos').AsFloat :=  qryEuroKilo.FieldByName('kilos').AsFloat;
      kmtEuroKilo.FieldByName('importe').AsFloat :=  qryEuroKilo.FieldByName('importe').AsFloat;
      kmtEuroKilo.FieldByName('precio').AsFloat :=  qryEuroKilo.FieldByName('precio').AsFloat;

      kmtEuroKilo.Post;

      Next;

    end;
  end;
end;

procedure TDLLiquidaEntrega.CalcularKilosDestrioTenerife(const sEmpresa, sAnyoSem, sProveedor, sProductor, sProducto, sEntrega: string; const ACosteFlete: Real);
var rPrecioCompra: Real;
begin
  with qryKilosDestrioTfe do
  begin
    SQL.Clear;
    SQL.Add(' select empresa, entrega, proveedor, producto, categoria, variedad, sum(peso) peso                                   ');
    SQL.Add('   from frf_entregas_c, frf_entregas_l l1 join rf_palet_pb_liquidacion on empresa = empresa_el and entrega = codigo_el  ');
    SQL.Add('                                                             and proveedor = proveedor_el and producto = producto_el ');
    SQL.Add('                                                             and categoria = categoria_el and variedad = variedad_el ');
//    SQL.Add(' where producto_el = ''PLA'' ');
    SQL.Add(' where 1=1 ');
    if sEmpresa <> '' then
      if sEmpresa = 'BAG' then
        SQL.Add(' and empresa_ec in (''F17'', ''F23'', ''F24'', ''F42'') ')
      else
        SQL.Add(' and empresa_ec = :empresa ');

    if sAnyoSem <> '' then
      SQL.Add(' and anyo_semana_ec = :anyo_semana ');

    if sProveedor <> '' then
      SQL.Add(' and proveedor_ec = :proveedor ');

    if sProductor <> '' then
      SQL.Add(' and almacen_el = :productor ');

    if sProducto <> '' then
      SQL.Add(' and producto_ec = :producto ');

    if sEntrega <> '' then
      SQL.Add(' and codigo_ec = :entrega ');

    SQL.Add('   and codigo_ec = codigo_el  ');

    SQL.Add('   and l1.rowid = (select min(l2.rowid) from frf_entregas_l l2  ');
		SQL.Add('                   where l2.codigo_el = l1.codigo_el            ');
    SQL.Add('                     and l2.empresa_el = l1.empresa_el          ');
    SQL.Add('                     and l2.proveedor_el = l1.proveedor_el      ');
    SQL.Add('                     and l2.producto_el = l1.producto_el        ');
    SQL.Add('                     and l2.categoria_el = l1.categoria_el      ');
    SQL.Add('                     and l2.variedad_el = l1.variedad_el)       ');

    SQL.Add(' group by 1,2,3,4,5,6' );

    if sEmpresa <> '' then
      if sEmpresa <> 'BAG' then
        ParamByName('empresa').AsString := sEmpresa;
    if sAnyoSem <> '' then
      ParamByName('anyo_semana').AsString := sAnyoSem;
    if sProveedor <> '' then
      ParamByName('proveedor').AsString := sProveedor;
    if sProductor <> '' then
      ParamByName('productor').AsString := sProductor;
    if sProducto <> '' then
      ParamByName('producto').AsString := sProducto;
    if sEntrega <> '' then
      ParamByName('entrega').AsString := sEntrega;

    Open;
    while not Eof do
    begin
      if kmtEuroKilo.Locate('proveedor;categoria;variedad', VarArrayOf([qryKilosDestrioTfe.FieldByName('proveedor').AsString,
                                                                        qryKilosDestrioTfe.FieldByName('categoria').ASString,
                                                                        qryKilosDestrioTfe.FieldByName('variedad').AsInteger]) , []) then
        rPrecioCompra := kmtEuroKilo.FieldByName('precio').AsFloat
      else
        rPrecioCompra := 0;

      kmtKilosDestrioTfe.Insert;

      kmtKilosDestrioTfe.FieldByName('entrega').AsString := qryKilosDestrioTfe.FieldByName('entrega').AsString;
      kmtKilosDestrioTfe.FieldByName('empresa').AsString := qryKilosDestrioTfe.FieldByName('empresa').AsString;
      kmtKilosDestrioTfe.FieldByName('proveedor').AsString := qryKilosDestrioTfe.FieldByName('proveedor').AsString;
      kmtKilosDestrioTfe.FieldByName('producto').AsString := qryKilosDestrioTfe.FieldByName('producto').AsString;
      kmtKilosDestrioTfe.FieldByName('categoria').AsString := qryKilosDestrioTfe.FieldByName('categoria').AsString;
      kmtKilosDestrioTfe.FieldByName('variedad').AsInteger := qryKilosDestrioTfe.FieldByName('variedad').AsInteger;
      kmtKilosDestrioTfe.FieldByName('peso').AsFloat :=  qryKilosDestrioTfe.FieldByName('peso').AsFloat;
      kmtKilosDestrioTfe.FieldByName('importe').AsFloat :=  qryKilosDestrioTfe.FieldByName('peso').AsFloat * rPrecioCompra;
      kmtKilosDestrioTfe.Post;

      Next;

    end;
  end;
end;

procedure TDLLiquidaEntrega.CalculoClientes;
var
  rKilos, rKilosLiq: Real;
begin
  kmtClientes.First;
  while not kmtClientes.Eof do
  begin
    rKilos:= kmtClientes.FieldByName('res_kilos_teoricos').AsFloat;//son los que vamos a pagar
    rKilosLiq:= kmtClientes.FieldByName('res_kilos_liquidar').AsFloat;//son los de RF aprovechados
    if rKilos <> 0 then
    begin
      kmtClientes.Edit;

      if rKilosLiq <> 0 then
        kmtClientes.FieldByName('res_precio_bruto').AsFloat:= kmtClientes.FieldByName('res_importe_neto').AsFloat / rKilosLiq
      else
        kmtClientes.FieldByName('res_precio_bruto').AsFloat:= 0;

      kmtClientes.FieldByName('res_precio_neto').AsFloat:= kmtClientes.FieldByName('res_importe_neto').AsFloat / rKilos;
      kmtClientes.FieldByName('res_precio_descuento').AsFloat:= kmtClientes.FieldByName('res_importe_descuento').AsFloat / rKilos;
      kmtClientes.FieldByName('res_precio_gastos').AsFloat:= kmtClientes.FieldByName('res_importe_gastos').AsFloat / rKilos;
      kmtClientes.FieldByName('res_precio_material').AsFloat:= kmtClientes.FieldByName('res_importe_material').AsFloat / rKilos;
      kmtClientes.FieldByName('res_precio_personal').AsFloat:= kmtClientes.FieldByName('res_importe_personal').AsFloat / rKilos;
      kmtClientes.FieldByName('res_precio_general').AsFloat:= kmtClientes.FieldByName('res_importe_general').AsFloat / rKilos;
      kmtClientes.FieldByName('res_precio_envasado').AsFloat:= kmtClientes.FieldByName('res_importe_envasado').AsFloat / rKilos;
      kmtClientes.FieldByName('res_precio_compra').AsFloat:= kmtClientes.FieldByName('res_importe_compra').AsFloat / rKilos;
      kmtClientes.FieldByName('res_precio_beneficio').AsFloat:= kmtClientes.FieldByName('res_importe_beneficio').AsFloat / rKilos;
//      if bExcluirIndirecto then
//        kmtClientes.FieldByName('res_precio_indirecto_almacen').AsFloat:= 0
//      else
//        kmtClientes.FieldByName('res_precio_indirecto_almacen').AsFloat:= kmtCostesProv.FieldByName('costeIndirectoAlmacen').AsFloat;
      kmtClientes.FieldByName('res_precio_indirecto_almacen').asFloat := kmtClientes.FieldByName('res_precio_indirecto_almacen').AsFloat;
      kmtClientes.FieldByName('res_importe_indirecto_almacen').asFloat := kmtClientes.FieldByName('res_precio_indirecto_almacen').AsFloat * rKilos;
//      kmtClientes.FieldByName('res_precio_financiero').AsFloat:= kmtClientes.FieldByName('res_importe_financiero').AsFloat / rKilos;
//      kmtClientes.FieldByName('res_precio_flete').AsFloat:= kmtClientes.FieldByName('res_importe_flete').AsFloat / rKilos;

      kmtClientes.FieldByName('res_importe_liquidar').AsFloat:= kmtClientes.FieldByName('res_importe_neto').AsFloat -
        (
          kmtClientes.FieldByName('res_importe_descuento').AsFloat +
          kmtClientes.FieldByName('res_importe_gastos').AsFloat +
          kmtClientes.FieldByName('res_importe_envasado').AsFloat +
          kmtClientes.FieldByName('res_importe_compra').AsFloat +
          kmtClientes.FieldByName('res_importe_beneficio').AsFloat +
          kmtClientes.FieldByName('res_importe_financiero').AsFloat +
          kmtClientes.FieldByName('res_importe_flete').AsFloat +
          kmtClientes.FieldByName('res_importe_indirecto_almacen').AsFloat
        );
      kmtClientes.FieldByName('res_precio_liquidar').AsFloat:= kmtClientes.FieldByName('res_importe_liquidar').AsFloat / rKilos;

{
      if kmtEuroKilo.Locate('categoria', VarArrayOf([kmtClientes.FieldByName('res_categoria').ASString]) , []) then
        kmtClientes.FieldByName('res_precio_kilo').AsFloat := kmtEuroKilo.FieldByName('precio').AsFloat
      else
        kmtClientes.FieldByName('res_precio_kilo').AsFloat := 0;

      kmtClientes.FieldByName('res_total_compra').AsFloat := rKilos *  kmtClientes.FieldByName('res_precio_kilo').AsFloat;
}
      kmtClientes.FieldByName('res_precio_kilo').AsFloat := kmtClientes.FieldByName('res_total_compra').AsFloat / rKilos;
      kmtClientes.FieldByName('res_margen_kilo').AsFloat := kmtClientes.FieldByName('res_precio_liquidar').AsFloat -
                                                            kmtClientes.FieldByName('res_precio_kilo').AsFloat;

      kmtClientes.FieldByName('res_margen_total').AsFloat := rKilos * kmtClientes.FieldByName('res_margen_kilo').AsFloat;

      kmtCostesProv.Locate('proveedor', VarArrayOf([sUnicoProv]) , []);
      kmtClientes.FieldByName('res_coste_prod').AsFloat := kmtCostesProv.FieldByName('costeProduccion').AsFloat;
      kmtClientes.FieldByName('res_coste_env').AsFloat := kmtCostesProv.FieldByName('costeEnvasado').AsFloat;
      kmtClientes.FieldByName('res_coste_opp').AsFloat := kmtCostesProv.FieldByName('costeOpp').AsFloat;
      kmtClientes.FieldByName('res_coste_ayu').AsFloat := kmtCostesProv.FieldByName('CosteAyuda').AsFloat;
      kmtClientes.FieldByName('res_coste_margen').AsFloat := kmtClientes.FieldByName('res_precio_kilo').AsFloat -
                                                             kmtClientes.FieldByName('res_coste_prod').AsFloat -
                                                             kmtClientes.FieldByName('res_coste_env').AsFloat -
                                                             kmtClientes.FieldByName('res_coste_opp').AsFloat +
                                                             kmtClientes.FieldByName('res_coste_ayu').AsFloat;

      kmtClientes.Post;
    end;
    kmtClientes.Next;
  end;
end;



//***********************************************************************************************************************
//***********************************************************************************************************************





procedure TDLLiquidaEntrega.ValorarPaletsExecute( const APrecios: Boolean );
begin
  DLLiquidaIncidencias.InicializarProblemas;
  AbrirTablasTemporales;
  InicializaMinimos( 0, 0, 0 );

  ValorarPalets( APrecios, 0, 0, 0, 0, False, False, False );
  DLLiquidaIncidencias.VerProblemas( sEmpresaIni, sSemanaIni, sProducto );

  kmtPalet.SortFields:='pal_anyo_semana;pal_proveedor;pal_canarias;pal_almacen;pal_entrega;pal_categoria;pal_cliente_sal';
  kmtPalet.Sort([]);
  kmtPalet.First;
  PrevisualizarPalets( spEmpresa, APrecios );


  CerrarTablasTemporales;
end;

function  TDLLiquidaEntrega.ImportesFOBAux( const AFecha, ACliente, ACategoria, AEnvase: string ): boolean;
var
  rAux: Real;
  VResultadosFob: TResultadosFob;
begin
  with DMTablaTemporalFOB do
  begin
    sAEmpresa:= spEmpresa;
    iAProductoPropio:=0 ;
    sACentroOrigen:= spCentro;
    sACentroSalida:= '';
    sACliente:= ACliente;
    iAClienteFac:= -1;     // 1 -> facturable 2 -> no facturable resto -> todos
    //sASuministro:= ASuministro;
    sAPais:= '';
    sAALbaran:= spAlbaran;
    bAAlb6Digitos:= False;    // true -> como minimo seis digitos (almacen) false -> todos
    iAAlbFacturado:= -1;   // 1 -> facturado  0 -> no facturado  resto -> todos
    bAManuales:= True;
    bASoloManuales:= False;
    sAFechaDesde:= AFecha;
    sAFEchaHasta:= AFecha;
    bAFechaSalida:= True;    // true -> rango fecha salidas false -> rango fecha facturas (solo facturados)
    sAProducto:= spProducto;
    iAEsHortaliza:= 0;       // 1 -> tomate 2 -> no tomate resto -> todos
    bANoP4H:= False;
    sAEnvase:= AEnvase;
    sACategoria:= ACategoria;
    sACalibre:= '';
    sATipoGasto:= '';
    bANoGasto:= false;        // true -> excluye el gasto                       false -> lo incluye

    bAGastosNoFac:= True;
    bAGastosFac:= True;
    (**) bAGastosTransitos:= True;
    bAComisiones:= True;
    bADescuentos:= True;
    bACosteEnvase:= True;
    bACosteSecciones:= True;
    bAPromedio:= True;
  end;
  Result:= DMTablaTemporalFOB.ImportesFOB( rgPeso, rgNeto, rgDescuento, rgGastos, rgMaterial, rgGeneral, VResultadosFob );
  rAux:= rgPeso * rMinTteCliente;
  if  rgGastos < rAux then
    rgGastos:= rAux;

   rAux:= rgPeso * rMinCosteEnvasado;
   if ( rgMaterial + rgPersonal +  rgGeneral ) < rAux then
   begin
     rgMaterial:= bRoundTo(rAux/3,2);
     rgPersonal:= bRoundTo(rAux/3,2);
     rgGeneral:= rAux - ( rgMaterial + rgPersonal );
   end;
end;

function TDLLiquidaEntrega.ImportesFOBLiqCarga: boolean;
var
  sAuxCliente, sCatAux, sEnvAux: string;
  bPlacero: boolean;
begin
  DLLiquidaIncidencias.AddNewDay( spEmpresa, spProducto, spFechaAlbaran );
  if ExisteImportesFOB then
  begin
    Result:= True;
    PutImportesFOB;
  end
  else
  begin
    if spAlbaran <> '' then
    begin
      sAuxCliente:= '';
    end
    else
    begin
      sAuxCliente:= spCliente;
    end;

    (*
    Result:= True;
    if not ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, spEnvase ) then
    begin
      //Relajar envase
      Result:= ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, '' );
    end;
    *)

    if qryPaletsPB.Active and ( qryPaletsPB.FindField('calidad') <> nil ) then
      bPlacero:= ( qryPaletsPB.FieldByName('calidad').AsString = 'P' )
    else
      bPlacero:= False;

    if ( Copy( spCliente, 1, 1) = '0' ) then
    begin
      Result:= False;
    end
    else
    if ( sPEmpresa <> 'F42' ) and  bPlacero then
    begin
      sCatAux:= spCategoria;
      sEnvAux:= spEnvase;
      spCategoria:= '3';
      spEnvase:= '';
      Result:= ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, spEnvase );
      (*TODO*)
      if not Result then
      begin
        spCategoria:= '2';
        spEnvase:= '';
        Result:= ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, spEnvase );
        if not Result then
        begin
          //10/2/2107 Amparo, un placero puede tener categoria 1ª
          spCategoria:= '1';
          spEnvase:= '';
          Result:= ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, spEnvase );
          if not Result then
          begin
            spCategoria:= '3B';
            spEnvase:= '';
            Result:= ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, spEnvase );
            if not Result then
            begin
              spCategoria:= sCatAux;
              spEnvase:= sEnvAux;
              Result:= ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, spEnvase );
            end;
          end;
        end;
      end;
    end
    else
    begin
      Result:= ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, spEnvase );
      //Hasta que Juan modifique la RF relajamos
      (*
      if spEmpresa = 'F24' then
      begin
        //Relajamos envase
        sAux:= spEnvase;
        spEnvase:= '';
        Result:= ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, spEnvase );
        if not Result then
        begin
          //Relajamos categoria
          spEnvase:= sAux;
          sAux:= spCategoria;
          spCategoria:= '';
          Result:= ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, spEnvase );
          spCategoria:= sAux;
          if not Result then
          begin
            //Relajamos categoria envase
            Result:= ImportesFOBAux( spFechaAlbaran, sAuxCliente, '', '' );
          end;
        end
        else
        begin
          spEnvase:= sAux;
        end;
      end;
      *)
    end;

    //ShowMessage( spFechaAlbaran + ' - ' + sAuxCliente + ' - ' +  spCategoria + ' - ' +  spEnvase );

    if not result then
    begin
      DLLiquidaIncidencias.AddNewSinFOB( spEmpresa, qryEntregas.fieldByName('codigo_ec').AsString, spProducto,
                                         qryPaletsPB.fieldByName('variedad').AsString, qryPaletsPB.fieldByName('categoria').AsString,
                                         sAuxCliente, spFechaAlbaran, spAlbaran, spEnvase, spCategoria, qryPaletsPB.FieldByName('orden_carga').AsInteger  );
    end;
    NewImportesFOB;
  end;
end;

function TDLLiquidaEntrega.ImportesFOBLiqVolcado: boolean;
var
  sAuxCliente, sAuxFecha: string;
  dFecha: TDateTime;
begin
  DLLiquidaIncidencias.AddNewDay( spEmpresa, spProducto, spFechaAlbaran );
  if ExisteImportesFOB then
  begin
    Result:= True;
    PutImportesFOB;
  end
  else
  begin
    if spAlbaran <> '' then
    begin
      sAuxCliente:= '';
    end
    else
    begin
      sAuxCliente:= spCliente;
    end;

    Result:= True;
    if not ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, spEnvase ) then
    begin
      //Relajar envase
      if not ImportesFOBAux( spFechaAlbaran, sAuxCliente, spCategoria, '' ) then
      begin
        //Relajar categoria
        if not ImportesFOBAux( spFechaAlbaran, sAuxCliente, '', '' ) then
        begin
          //Relajar fecha  si no hay albaran
          if spAlbaran = '' then
          begin
            if HaySalidas( spEmpresa, sAuxCliente, spProducto, StrToDate( spFechaAlbaran ), dFecha ) then
            begin
              sAuxFecha:= FormatDateTime( 'dd/mm/yyyy', dFecha );
              if not ImportesFOBAux( sAuxFecha, sAuxCliente, spCategoria, spEnvase ) then
              begin
                //Relajar envase
                if not ImportesFOBAux( sAuxFecha, sAuxCliente, spCategoria, '' ) then
                begin
                  Result:= ImportesFOBAux( sAuxFecha, sAuxCliente, '', '' );
                end
              end;
            end
            else
            begin
              result:= False;
            end;
          end;
        end;
      end;
    end;
    if not result then
    begin
      DLLiquidaIncidencias.AddNewSinFOB( spEmpresa, qryEntregas.fieldByName('codigo_ec').AsString, spProducto,
                                         qryPaletsPB.fieldByName('variedad').AsString, qryPaletsPB.fieldByName('categoria').AsString,
                                         sAuxCliente, spFechaAlbaran, spAlbaran, spEnvase, spCategoria, qryPaletsPB.FieldByName('orden_carga').AsInteger  );
    end;
    NewImportesFOB;
  end;
end;

function TDLLiquidaEntrega.HaySalidas( const AEmpresa, ACliente, AProducto: string; const AFecha: TDateTime; var  AFechaSalida: TDateTime ): boolean;
begin
  with qryFechaAlbaranCliente do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fechaini').AsDateTime:= AFecha;
    ParamByName('fechafin').AsDateTime:= AFecha + 3;
    try
      Open;
      result:= FieldByname('registros').AsInteger > 0;
      AFechaSalida:= FieldByname('fecha').AsDateTime;
      Close;
    except
      Close;
      AFechaSalida:= AFecha;
      result:= False;
    end;
  end;
end;

function TDLLiquidaEntrega.ExisteImportesFOB: boolean;
var
  iAlbaran: integer;
  dFecha: TDateTime;
begin
  Result:= False;
  iAlbaran:= StrToIntDef(spAlbaran,0);
  if tryStrToDate( spFechaAlbaran, dFecha ) then
    result:= kmtPrecioFOB.Locate( 'empresa;centro;albaran;fecha;cliente;envase;categoria',
         VarArrayOf([spEmpresa,spcentro,iAlbaran,dFecha,spCliente,spEnvase,spCategoria ]),[]);
  (*
  else
    ShowMessage(' Fecha Incorrecta: (' +    spFecha + ') ' +
                qryEntregas.FieldByname('codigo_ec').AsString + ' /SSCC-> ' +
                qryPaletsPB.FieldByname('sscc').AsString + ' /ALTA-> ' +
                qryPaletsPB.FieldByname('fecha_alta').AsString + ' /STATUS-> ' +
                qryPaletsPB.FieldByname('fecha_status').AsString );
  *)
end;

procedure TDLLiquidaEntrega.PutImportesFOB;
begin
  rgPeso:= kmtPrecioFOB.FieldByName('peso').AsFloat;
  rgNeto:= kmtPrecioFOB.FieldByName('neto').AsFloat;
  rgDescuento:= kmtPrecioFOB.FieldByName('descuento').AsFloat;
  rgGastos:= kmtPrecioFOB.FieldByName('gastos').AsFloat;
  rgMaterial:= kmtPrecioFOB.FieldByName('material').AsFloat;
  rgPersonal:= kmtPrecioFOB.FieldByName('personal').AsFloat;
  rgGeneral:= kmtPrecioFOB.FieldByName('general').AsFloat;
end;

procedure TDLLiquidaEntrega.ImportesFOBDestrio;
begin
  rgPeso:= 0;
  rgNeto:= 0;
  rgDescuento:= 0;
  rgGastos:= 0;
  rgMaterial:= 0;
  rgPersonal:= 0;
  rgGeneral:= 0;
end;

procedure TDLLiquidaEntrega.NewImportesFOB;
begin
  kmtPrecioFOB.Insert;

  kmtPrecioFOB.FieldByName('empresa').AsString:= spEmpresa;
  kmtPrecioFOB.FieldByName('centro').AsString:= spCentro;
  kmtPrecioFOB.FieldByName('albaran').AsInteger:= StrToIntDef(spAlbaran,0);
  kmtPrecioFOB.FieldByName('fecha').AsDateTime:= StrToDate( spFechaAlbaran );
  kmtPrecioFOB.FieldByName('cliente').AsString:= spCliente;
  kmtPrecioFOB.FieldByName('envase').AsString:= spEnvase;
  kmtPrecioFOB.FieldByName('categoria').AsString:= spCategoria;

  kmtPrecioFOB.FieldByName('peso').AsFloat:= rgPeso;
  kmtPrecioFOB.FieldByName('neto').AsFloat:= rgNeto;
  kmtPrecioFOB.FieldByName('descuento').AsFloat:= rgDescuento;
  kmtPrecioFOB.FieldByName('gastos').AsFloat:= rgGastos;
  kmtPrecioFOB.FieldByName('material').AsFloat:= rgMaterial;
  kmtPrecioFOB.FieldByName('personal').AsFloat:= rgPersonal;
  kmtPrecioFOB.FieldByName('general').AsFloat:= rgGeneral;

  kmtPrecioFOB.Post;
end;



procedure TDLLiquidaEntrega.GetCostesProveedor(const AProveedor, AAnoSemana: string);
begin
  with qryCostesProv do
  begin
    ParaMByName('proveedor').AsString := AProveedor;
    ParamByName('fecha').AsDateTime := EncodeDateWeek(StrToInt(Copy(AAnoSemana, 0, 4)), StrToInt(Copy(AAnoSemana,5,2)));
    Open;
    if not qryCostesProv.IsEmpty then
    begin
      kmtCostesProv.Insert;
      while not eof do
      begin
        kmtCostesProv.FieldByName('proveedor').AsString := FieldByName('proveedor_pc').AsString;
        if FieldByName('tipo_coste_pc').AsString = '01' then
          kmtCostesProv.FieldByName('costeProduccion').AsFloat := FieldByName('importe_pc').AsFloat;
        if FieldByName('tipo_coste_pc').AsString = '02' then
          kmtCostesProv.FieldByName('costeEnvasado').AsFloat := FieldByName('importe_pc').AsFloat;
        if FieldByName('tipo_coste_pc').AsString = '03' then
          kmtCostesProv.FieldByName('costeOPP').AsFloat := FieldByName('importe_pc').AsFloat;
        if FieldByName('tipo_coste_pc').AsString = '04' then
          kmtCostesProv.FieldByName('costeayuda').AsFloat := FieldByName('importe_pc').AsFloat;
        if FieldByName('tipo_coste_pc').AsString = '05' then
          kmtCostesProv.FieldByName('costeIndirectoAlmacen').AsFloat := FieldByName('importe_pc').AsFloat;

        Next;
      end;
      kmtCostesProv.Post;
    end;
    Close;
  end;
end;

procedure TDLLiquidaEntrega.GetCostesProveedorTotal(const AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega: string);
begin

  with qryAux do
  begin
    SQL.Clear;
    SQL.Add(' select distinct proveedor_ec proveedor_ec  ');
    SQL.Add('   from frf_entregas_c, frf_entregas_l   ');
    SQL.Add('  where 1= 1                             ');

    if AEntrega <> '' then
      SQL.Add(' and codigo_ec = :entrega              ');
    if AEmpresa <> '' then
    begin
      if AEmpresa = 'BAG' then
        SQL.Add(' and empresa_ec matches ''F*''       ')
      else
        SQL.Add(' and empresa_ec = :empresa           ');
    end;
    if AAnyoSem <> '' then
      SQL.Add(' and anyo_semana_ec = :semana          ');
    if AProveedor <> '' then
      SQL.Add(' and proveedor_ec = :proveedor         ');
    if AProductor <> '' then
      SQL.Add(' and almacen_el = :productor           ');

    SQL.Add(' and producto_ec = :producto             ');

    SQL.Add(' and codigo_ec = codigo_el               ');

    SQL.Add(' group by 1 ');
    SQL.Add(' order by 1 ');

    if AEntrega <> '' then
      ParamByName('entrega').AsString:= AEntrega;
    if AEmpresa <> '' then
      if AEmpresa <> 'BAG' then
        ParamByName('empresa').AsString:= AEmpresa;
    if AAnyoSem <> '' then
      ParamByName('semana').AsString:= AAnyoSem;
    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AProductor <> '' then
      ParamByName('productor').AsString:= AProductor;

    ParamByName('producto').AsString := AProducto;

    Open;
    while not eof do
    begin
      GetCostesProveedor( qryAux.fieldbyname('proveedor_ec').AsString, AAnyoSem);

      Next;
    end;

    Close;
  end;

end;

function TDLLiquidaEntrega.GetEnvaseProveedor( const AEmpresa, AProveedor, AProducto, AVariedad: string ): string;
begin
  with qryEnvase do
  begin
    ParamByName('proveedor').AsString:= AProveedor;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('variedad').AsString:= AVariedad;
    Open;
    result:= FieldByName('envase_e').AsString;
    Close;
  end;
end;

function TDLLiquidaEntrega.GetRelacionKilosTeoricos( const AEntrega, AEmpresa, AProveedor, AProducto, ACategoria: string; const AVariedad: integer;
                                                     var VRelacion, VKilosCaja: real ): Boolean;
var
  rKilosTeoricos, rKilosRf, rAuxlinea, rAuxRF, rKilosTenerife: Real;
begin
  if kmtKilosTeoricos.Locate('entrega;empresa;proveedor;producto;variedad;categoria',
       VarArrayOf([AEntrega, AEmpresa, AProveedor, AProducto, AVariedad, ACategoria]) , []) then
  begin
    VRelacion:= kmtKilosTeoricos.FieldByName('relacion').AsFloat;
    VKilosCaja:= kmtKilosTeoricos.FieldByName('kilos_caja').AsFloat;
    result:= True;;
  end
  else
  begin
    qryKilosTeoricosLinea.ParamByName('entrega').AsString:= AEntrega;
    qryKilosTeoricosLinea.ParamByName('proveedor').AsString:= AProveedor;
    qryKilosTeoricosLinea.ParamByName('producto').AsString:= AProducto;
    qryKilosTeoricosLinea.ParamByName('variedad').AsInteger:= AVariedad;
    qryKilosTeoricosLinea.ParamByName('categoria').AsString:= ACategoria;
    qryKilosTeoricosLinea.Open;

    result:= not qryKilosTeoricosLinea.IsEmpty;
    if Result then
    begin

      //BUSCAR KILOS DESTRIO TENERIFE kmtKilosDestrioTfe
     if kmtKilosDestrioTfe.Locate('entrega;empresa;proveedor;producto;variedad;categoria',
                           VarArrayOf([AEntrega, AEmpresa, AProveedor, AProducto, AVariedad, ACategoria]), []) then

       rKilosTenerife := kmtKilosDestrioTfe.FieldByName('peso').AsFloat;

      if qryKilosTeoricosLinea.FieldBYName('cajas').AsFloat <> 0 then
        VKilosCaja:= bRoundTo( (qryKilosTeoricosLinea.FieldBYName('kilos').AsFloat - rKilosTenerife) / qryKilosTeoricosLinea.FieldBYName('cajas').AsFloat, 2)
      else
        VKilosCaja:= 0;

      qryKilosVariedadRF.ParamByName('entrega').AsString:= AEntrega;
      qryKilosVariedadRF.ParamByName('proveedor').AsString:= AProveedor;
      qryKilosVariedadRF.ParamByName('producto').AsString:= AProducto;
      qryKilosVariedadRF.ParamByName('variedad').AsInteger:= AVariedad;
      qryKilosVariedadRF.ParamByName('categoria').AsString:= ACategoria;
      qryKilosVariedadRF.Open;

      if  qryKilosTeoricosLinea.FieldBYName('empresa_el').AsString =  qryKilosVariedadRF.FieldBYName('empresa').AsString then
      begin
        //NO es transito empresa entrega = empresa palet
        rKilosTeoricos:= qryKilosTeoricosLinea.FieldBYName('kilos').AsFloat - rKilosTenerife;
      end
      else
      begin
        //Para los transitos el peso teorico es el las cajas que se cargaron
        rKilosTeoricos:= 0;
         while not qryKilosVariedadRF.Eof do
         begin
           rKilosTeoricos:= rKilosTeoricos + ( qryKilosVariedadRF.FieldBYName('cajas').AsFloat * VKilosCaja );
           qryKilosVariedadRF.Next;
         end;
         qryKilosVariedadRF.First;
      end;
      rKilosRf:= 0;
      rAuxLinea:= 0;
      rAuxRf:= 0;
      while not qryKilosVariedadRF.Eof do
      begin
        rKilosRf:= rKilosRf + qryKilosVariedadRF.FieldBYName('kilos').AsFloat;
        if  ( qryKilosVariedadRF.FieldBYName('calidad').AsString = 'P' ) or
            ( qryKilosVariedadRF.FieldBYName('paletorigen').AsString <> '' ) then
        begin
          rAuxLinea:= rAuxLinea + qryKilosVariedadRF.FieldBYName('kilos').AsFloat;
          rAuxRF:= rAuxRF + qryKilosVariedadRF.FieldBYName('kilos').AsFloat;
        end
        else
        begin
          if qryKilosVariedadRF.FieldBYName('status').AsString = 'C' then
          begin
            rAuxLinea:= rAuxLinea + bRoundTo( qryKilosVariedadRF.FieldBYName('cajas').AsFloat * VKilosCaja, 2 );
            rAuxRF:= rAuxRF + qryKilosVariedadRF.FieldBYName('kilos').AsFloat;
          end
          else
          begin
            if ( qryKilosVariedadRF.FieldBYName('status').AsString <> 'V' ) and
               ( qryKilosVariedadRF.FieldBYName('status').AsString <> 'R' ) then
            begin
              rAuxLinea:= rAuxLinea + qryKilosVariedadRF.FieldBYName('kilos').AsFloat;
              rAuxRF:= rAuxRF + qryKilosVariedadRF.FieldBYName('kilos').AsFloat;
            end
          end;
        end;

        qryKilosVariedadRF.Next;
      end;
      qryKilosVariedadRF.Close;

      kmtKilosTeoricos.Insert;
      kmtKilosTeoricos.FieldByName('entrega').AsString:= AEntrega;
      kmtKilosTeoricos.FieldByName('empresa').AsString:= AEmpresa;
      kmtKilosTeoricos.FieldByName('proveedor').AsString:= AProveedor;
      kmtKilosTeoricos.FieldByName('producto').AsString:= AProducto;
      kmtKilosTeoricos.FieldByName('variedad').AsInteger:= AVariedad;
      kmtKilosTeoricos.FieldByName('categoria').AsString:= ACategoria;
      kmtKilosTeoricos.FieldByName('kilos_linea').AsFloat:= rKilosTeoricos - rAuxLinea;
      kmtKilosTeoricos.FieldByName('kilos_rf').AsFloat:= rKilosRf - rAuxRF;
      kmtKilosTeoricos.FieldByName('kilos_caja').AsFloat:= VKilosCaja;

      if kmtKilosTeoricos.FieldByName('kilos_rf').AsFloat <> 0 then
        VRelacion:= kmtKilosTeoricos.FieldByName('kilos_linea').AsFloat /
                    kmtKilosTeoricos.FieldByName('kilos_rf').AsFloat
      else
        VRelacion:= 1;

      kmtKilosTeoricos.FieldByName('relacion').AsFloat:= VRelacion;
      kmtKilosTeoricos.Post;
    end
    else
    begin
      VRelacion:= 1;
    end;
    qryKilosTeoricosLinea.Close;
  end;
end;


procedure TDLLiquidaEntrega.AltaTransito;
begin
  if  qryEntregas.fieldByName('empresa_ec').AsString <> spDestino then
  begin
    if not kmtTransitos.Locate( 'tra_planta;tra_entrega',VarArrayOf([spDestino, qryEntregas.fieldByName('codigo_ec').AsString]),[]) then
    begin
      kmtTransitos.Insert;
      kmtTransitos.FieldByName('tra_planta').AsString:= spDestino;
      kmtTransitos.FieldByName('tra_entrega').AsString:= qryEntregas.fieldByName('codigo_ec').AsString;
      kmtTransitos.Post;
    end;
  end;
end;


function TDLLiquidaEntrega.LoadParamsCargados( var ATransitos: boolean ): boolean;
begin
  ATransitos:= False;
  with qryOrdenCarga do
  begin
    ParamByName('orden').AsString:= qryPaletsPB.FieldByName('orden_carga').AsString;
    Open;
    result:= not IsEmpty;
    if Result then
    begin
      ATransitos:= FieldByName('traspasada_occ').AsInteger = 2;
      spEmpresa:= FieldByName('empresa_occ').AsString;
      spDestino:= FieldByName('planta_destino_occ').AsString;
      spCentro:= FieldByName('centro_salida_occ').AsString;
      spAlbaran:= FieldByName('n_albaran_occ').AsString;
      spProducto:= qryPaletsPB.FieldByName('producto').AsString;

      spFechaAlbaran:= FieldByName('fecha_occ').AsString;

      spEnvase:= GetEnvaseProveedor( qryEntregas.FieldByName('empresa_ec').AsString,
                                        qryPaletsPB.FieldByName('proveedor').AsString,
                                        qryPaletsPB.FieldByName('producto').AsString,
                                        qryPaletsPB.FieldByName('variedad').AsString );

      spCliente:= FieldByName('cliente_sal_occ').AsString;
      spCategoria:= qryPaletsPB.FieldByName('categoria').AsString;
    end;
    Close;
  end;
end;

procedure TDLLiquidaEntrega.LoadParamsDestrio;
begin
  //VOLCADOS
  spEmpresa:= qryPaletsPB.FieldByName('empresa').AsString;
  spCentro:= qryPaletsPB.FieldByName('centro').AsString;
  spProducto:= qryPaletsPB.FieldByName('producto').AsString;
  spCategoria:= '';
  spAlbaran:= '';
  spFechaAlbaran:= '';
  spEnvase:= '';
  spCliente:= '';
end;

procedure TDLLiquidaEntrega.LoadParamsVolcados;
begin
  //VOLCADOS
  //spEmpresa:= qryEntregas.FieldByName('empresa_ec').AsString;
  spEmpresa:= qryPaletsPB.FieldByName('empresa').AsString;
  //spCentro:= qryEntregas.FieldByName('centro_llegada_ec').AsString;
  spCentro:= qryPaletsPB.FieldByName('centro').AsString;
  spAlbaran:= '';
  spFechaAlbaran:= FechaSalida;//FormatDateTime( 'dd/mm/yyyy', qryPaletsPB.FieldByName('fecha_status').AsDateTime );

  spEnvase:= '';

  (*TODO*)//Cliente regularizado
  if spStatus= 'R' then
  begin
    spCliente:= 'MER';
    spStatus:= 'V';
  end
  else
  begin
    spCliente:= qryPaletsPB.FieldByName('cliente').AsString;
  end;

  spProducto:= qryPaletsPB.FieldByName('producto').AsString;
  spCategoria:= qryPaletsPB.FieldByName('categoria').AsString;
end;

procedure TDLLiquidaEntrega.CleanParams;
begin
  spEmpresa:= '';
  spCentro:= '';
  spAlbaran:= '';
  spFechaAlbaran:= '';
  spEnvase:= '';
  spCliente:= '';
  spProducto:= '';
  spCategoria:= '';
  spStatus:= '';
end;



//ATipoPalet
//-1 error
//0 stock
//1 volcado/cargado/destrio/placero
//2 transito

function TDLLiquidaEntrega.LoadParamsByStatus( var VMsg: string; var ATipoPalet: integer  ): boolean;
var
  bTransito: Boolean;
begin
  CleanParams;

  if not qryPaletsPB.IsEmpty then
  begin
    spStatus:= qryPaletsPB.FieldByName('status').AsString;

    if spStatus = 'S' then
    begin
      Result:= False;
      ATipoPalet:= 0;
      VMsg:= 'ERROR Palets en Stock';
    end
    else
    if ( spStatus= 'D' )  then
    begin
      Result:= True;
      LoadParamsDestrio;
      ATipoPalet:= 1;
    end
    else
    if ( spStatus= 'R' ) or ( spStatus= 'V' ) then
    begin
      Result:= True;
      LoadParamsVolcados;
      if ( ( Copy( spCliente, 1, 1) = '0' ) and (spCliente <> '0UP') )then
      begin
        ATipoPalet:= 1;  //Placeros B es destrio
        spStatus:= 'D';
      end
      else
      begin
        ATipoPalet:= 2; //Volcado para venta
      end;
    end
    else
    if ( spStatus = 'C' ) then
    begin
      result:= LoadParamsCargados( bTransito );
      if result then
      begin
        if bTransito then
        begin
          ATipoPalet:= 4 //Carga para Transito
        end
        else
        begin
          if ( Copy( spCliente, 1, 1) = '0' ) then
          begin
            ATipoPalet:= 1;  //Placeros B es destrio
            spStatus:= 'D';
          end
          else
          begin
            ATipoPalet:= 3; //Carga para Venta
          end;
        end;
      end
      else
      begin
        ATipoPalet:= -2; //Carga sin carga
      end;
    end
    else
    begin
      ATipoPalet:= -1;
      Result:= False;
    end;
  end
  else
  begin
    ATipoPalet:= -1;
    result:= False;
  end;
end;

function TDLLiquidaEntrega.ValorarPalet: boolean;
var
  sMsg: string;
  iTipoPalet: Integer;
begin
  sMsg:= '';
  LoadParamsByStatus( sMsg, iTipoPalet );
  case iTipoPalet of
    0: //stock
    begin
      //Ni lo valoro ni lo añado
      Result:= False;
      DLLiquidaIncidencias.AddPaletStock( spEmpresa, qryEntregas.FieldByname('codigo_ec').AsString,
                                          qryPaletsPB.fieldByName('sscc').AsString,
                                          qryPaletsPB.fieldByName('fecha_alta').AsString,
                                          qryPaletsPB.fieldByName('peso').AsFloat );
      //AltaStock;
      sMsg:= 'ERROR PALET EN STOCK';
    end;
    1: //destrio
    begin
      Result:= True;
      ImportesFOBDestrio;
      NewPalet;
    end;
    2: //volcado
    begin
      Result:= True;
      if not ImportesFOBLiqVolcado then
      begin
        //Sin precio
      end;
      NewPalet;
    end;
    3: //cargado
    begin
      Result:= True;
      if not ImportesFOBLiqCarga then
      begin
        //Sin precio
      end;
      NewPalet;
    end;
    4: //transito
    begin
      Result:= True;
      AltaTransito;
    end;
    -2: //Palet satus Cargado sin carga
    begin
      Result:= False;
      sMsg:= 'PALET SIN CARGA ASOCIADA';
    end;
    else
    begin
      Result:= False;
      sMsg:= 'STATUS DESCONOCIDO';
    end;
  end;
end;

function TDLLiquidaEntrega.ValorarLineaVerde: boolean;
var
  bFlag: boolean;
begin
  if qrySalidasLin.isEmpty then
  begin
    rgPeso:= 0;
    rgNeto:= 0;
    rgDescuento:= 0;
    rgGastos:= 0;
    rgMaterial:= 0;
    rgPersonal:= 0;
    rgGeneral:= 0;

    DLLiquidaIncidencias.AddVerdeSinSalida( qryEntregasLin.fieldBYName('empresa').AsString,
       qryEntregas.fieldBYName('codigo_ec').AsString, qryEntregasLin.fieldBYName('proveedor').AsString,
       qryEntregasLin.fieldBYName('almacen').AsString, qryEntregasLin.fieldBYName('producto').AsString,
       qryEntregasLin.fieldBYName('categoria').AsString, qryEntregasLin.fieldBYName('variedad').AsString,
       qryEntregasLin.fieldBYName('envase').AsString, qryEntregasLin.fieldBYName('palets').AsFloat,
       qryEntregasLin.fieldBYName('cajas').AsFloat, qryEntregasLin.fieldBYName('kilos').AsFloat );
    result:= False;
  end
  else
  begin
    bFlag:= False;
    //Busqueda estricta
    qrySalidasLin.First;
    while ( not qrySalidasLin.Eof ) and ( not bFlag ) do
    begin
      bFlag:= ( qrySalidasLin.FieldByName('producto').AsString = qryEntregasLin.FieldByName('producto').AsString ) and
             ( qrySalidasLin.FieldByName('categoria').AsString = qryEntregasLin.FieldByName('categoria').AsString ) and
             ( qrySalidasLin.FieldByName('envase').AsString = qryEntregasLin.FieldByName('envase').AsString );

      if not bFlag then
        qrySalidasLin.Next;
    end;

    if not bFlag then
    begin
      //Relajamos envases
      spEnvase:= '';

      qrySalidasLin.First;
      while ( not qrySalidasLin.Eof ) and ( not bFlag ) do
      begin
       bFlag:= ( qrySalidasLin.FieldByName('producto').AsString = qryEntregasLin.FieldByName('producto').AsString ) and
               ( qrySalidasLin.FieldByName('categoria').AsString = qryEntregasLin.FieldByName('categoria').AsString );

        if not bFlag then
          qrySalidasLin.Next;
      end;
      if bFlag then
      begin
        spCategoria:= qrySalidasLin.FieldByName('categoria').AsString;
      end
      else
      begin
        //Relajamos calidad
        spCategoria:= '';
      end;
    end
    else
    begin
      spEnvase:= qrySalidasLin.FieldByName('envase').AsString;
      spCategoria:= qrySalidasLin.FieldByName('categoria').AsString;
    end;
    spEmpresa:= qrySalidasLin.FieldByName('empresa').AsString;
    spCentro:= qrySalidasLin.FieldByName('centro').AsString;
    spAlbaran:= qrySalidasLin.FieldByName('albaran').AsString;
    spFechaAlbaran:= qrySalidasLin.FieldByName('fecha').AsString;
    spProducto:= qrySalidasLin.FieldByName('producto').AsString;

    sPCliente:= qrySalidasLin.FieldByName('cliente').AsString;
    ImportesFOBLiqCarga;
    result:= True;
  end;
end;

Function TDLLiquidaEntrega.FechaSalida: string;
begin
  if not qryPaletsPB.IsEmpty then
  begin
    if qryPaletsPB.FieldByName('status').AsString = 'V' then
    begin
      with qryFechaSalida do
      begin
        ParamByName('cliente').AsString:= qryPaletsPB.fieldByName('cliente').AsString;
        ParamByName('fecha').AsString:= FormatDateTime( 'yyyy-mm-dd h:mm:ss', qryPaletsPB.fieldByName('fecha_status').AsDateTime);
        ParamByName('producto').AsString:= spProducto;
        Open;
        if not IsEmpty then
        begin
          if FieldByName('fecha').AsDateTime > qryPaletsPB.fieldByName('fecha_status').AsDateTime then
            Result:= FormatDateTime( 'dd/mm/yyyy',FieldByName('fecha').AsDateTime)
          else
            Result:= FormatDateTime( 'dd/mm/yyyy',qryPaletsPB.fieldByName('fecha_status').AsDateTime);
        end
        else
        begin
          Result:= FormatDateTime( 'dd/mm/yyyy',qryPaletsPB.fieldByName('fecha_status').AsDateTime);
        end;
        Close;
      end;
    end
    else
    begin
      Result:= FormatDateTime( 'dd/mm/yyyy',qryPaletsPB.fieldByName('fecha_status').AsDateTime);
    end;
  end;
end;

procedure TDLLiquidaEntrega.NewPalet;
var
  rRelacion, rKilosCaja: Real;
  rKilosPalet, rAux, rKilosDestrioTfe: Real;
begin
  //tipo_palet, sscc, fecha_alta, paletorigen, fecha_alta2, proveedor, proveedor_almacen, producto, variedad, categoria, cajas, status, ');
  //peso, peso_bruto, tipo_placero, calidad, productobase, fecha_status, orden_carga, pais, cliente, transito

  (*
  si hay palet de origen, darlo de alta como modificado
  si ya existe el palet es que uno modificado
  si no es uno nuevo si es un resto
  si no es original sin tocar
  *)

  kmtPalet.Insert;
  kmtPalet.FieldByName('pal_anyo_semana').AsString:= qryEntregas.fieldByName('anyo_semana_ec').AsString;
  kmtPalet.FieldByName('pal_empresa').AsString:= qryEntregas.fieldByName('empresa_ec').AsString;
  kmtPalet.FieldByName('pal_proveedor').AsString:= qryEntregas.fieldByName('proveedor_ec').AsString;
  kmtPalet.FieldByName('pal_canarias').AsInteger:= qryEntregas.fieldByName('propio_p').AsInteger;
  kmtPalet.FieldByName('pal_almacen').AsString:= qryPaletsPB.fieldByName('proveedor_almacen').AsString;
  kmtPalet.FieldByName('pal_entrega').AsString:= qryEntregas.fieldByName('codigo_ec').AsString;
  kmtPalet.FieldByName('pal_sscc_final').AsString:= qryPaletsPB.fieldByName('sscc').AsString;
  kmtPalet.FieldByName('pal_sscc_origen').AsString:= qryPaletsPB.fieldByName('paletorigen').AsString;
  kmtPalet.FieldByName('pal_categoria').AsString:= qryPaletsPB.fieldByName('categoria').AsString;
  kmtPalet.FieldByName('pal_variedad').AsString:= qryPaletsPB.fieldByName('variedad').AsString;
  kmtPalet.FieldByName('pal_cliente_sal').AsString:= spCliente;
  kmtPalet.FieldByName('pal_categoria_sal').AsString:= spCategoria;
  kmtPalet.FieldByName('pal_envase_sal').AsString:= spEnvase;
  kmtPalet.FieldByName('pal_fecha_sal').AsString:= spFechaAlbaran;//FechaSalida;
  kmtPalet.FieldByName('pal_albaran_sal').AsString:= spAlbaran;

  kmtPalet.FieldByName('pal_valorado').AsInteger:= 0;

  kmtPalet.FieldByName('pal_cajas_confeccionados').AsFloat:= qryPaletsPB.fieldByName('cajas').AsFloat;
  kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat:= qryPaletsPB.fieldByName('peso').AsFloat;


  if not GetRelacionKilosTeoricos( qryEntregas.FieldByName('codigo_ec').AsString,
                            qryPaletsPB.FieldByName('empresa').AsString,
                            qryPaletsPB.FieldByName('proveedor').AsString,
                            qryPaletsPB.FieldByName('producto').AsString,
                            qryPaletsPB.fieldByName('categoria').AsString,
                            qryPaletsPB.FieldByName('variedad').AsInteger, rRelacion, rKilosCaja ) then
  begin
    DLLiquidaIncidencias.AddVariedadSinTeorico( qryEntregas.FieldByName('empresa_ec').AsString,
      qryEntregas.FieldByName('codigo_ec').AsString, qryPaletsPB.FieldByName('proveedor').AsString,
      qryPaletsPB.FieldByName('producto').AsString, qryPaletsPB.FieldByName('variedad').AsString,
                                                    qryPaletsPB.fieldByName('categoria').AsString,
                                                    rRelacion );
  end;

  //kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat:= kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat / 1.04;
  if spStatus = 'D' then
  begin
    kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat:= 0;
    kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat:= kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat;
  end
  else
  if spStatus = 'C' then
  begin
    if qryPaletsPB.FieldByName('paletorigen').AsString <> '' then
    begin
      rAux:= kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat;
      kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat:= kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat;
    end
    else
    begin
      kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat:= broundto( rKilosCaja * kmtPalet.FieldByName('pal_cajas_confeccionados').AsFloat,2);
      rAux:= kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat;
    end;
    if rAux > kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat then
      kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat:= kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat
    else
      kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat:= rAux;
  end
  else
  begin
    //comprobar que los teoricos son correcto
    if qryPaletsPB.FieldByName('paletorigen').AsString <> '' then
    begin
      rAux:= kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat;
      kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat:= kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat;
    end
    else
    begin
      rAux:= broundto(kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat / 1.04,2);
      kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat:= broundto( rRelacion * kmtPalet.FieldByName('pal_kilos_confeccionados').AsFloat,2);
    end;
    if rAux > kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat then
      kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat:= kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat
    else
      kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat:= rAux;
  end;


  //rgPeso, rgNeto, rgDescuento, rgGastos, rgMaterial, rgPersonal, rgGeneral: Real;
  rKilosPalet:= kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat;

  if rgPeso > 0 then
  begin
    rAux:= bRoundTo( rgNeto / rgPeso, 5 );
    kmtPalet.FieldByName('pal_precio_neto').AsFloat:= rAux;
    kmtPalet.FieldByName('pal_importe_neto').AsFloat:= bRoundTo( rKilosPalet * rAux, 2);

    rAux:= bRoundTo( rgDescuento / rgPeso, 5 );
    kmtPalet.FieldByName('pal_precio_descuento').AsFloat:= rAux;
    kmtPalet.FieldByName('pal_importe_descuento').AsFloat:= bRoundTo( rKilosPalet * rAux, 2);

    rAux:= bRoundTo( rgGastos / rgPeso, 5 );
    kmtPalet.FieldByName('pal_precio_gastos').AsFloat:= rAux;
    kmtPalet.FieldByName('pal_importe_gastos').AsFloat:= bRoundTo( rKilosPalet * rAux, 2);

    rAux:= bRoundTo( rgMaterial / rgPeso, 5 );
    kmtPalet.FieldByName('pal_precio_material').AsFloat:= rAux;
    kmtPalet.FieldByName('pal_importe_material').AsFloat:= bRoundTo( rKilosPalet * rAux, 2);

    rAux:= bRoundTo( rgPersonal / rgPeso, 5 );
    kmtPalet.FieldByName('pal_precio_personal').AsFloat:= rAux;
    kmtPalet.FieldByName('pal_importe_personal').AsFloat:= bRoundTo( rKilosPalet * rAux, 2);

    rAux:= bRoundTo( rgGeneral / rgPeso, 5 );
    kmtPalet.FieldByName('pal_precio_general').AsFloat:= rAux;
    kmtPalet.FieldByName('pal_importe_general').AsFloat:= bRoundTo( rKilosPalet * rAux, 2);

    kmtPalet.FieldByName('pal_importe_envasado').AsFloat:=
      kmtPalet.FieldByName('pal_importe_material').AsFloat+
      kmtPalet.FieldByName('pal_importe_personal').AsFloat+
      kmtPalet.FieldByName('pal_importe_general').AsFloat;

    kmtPalet.FieldByName('pal_precio_envasado').AsFloat:=
      kmtPalet.FieldByName('pal_precio_material').AsFloat+
      kmtPalet.FieldByName('pal_precio_personal').AsFloat+
      kmtPalet.FieldByName('pal_precio_general').AsFloat;

  end
  else
  begin
    kmtPalet.FieldByName('pal_importe_neto').AsFloat:= 0;
    kmtPalet.FieldByName('pal_importe_descuento').AsFloat:= 0;
    kmtPalet.FieldByName('pal_importe_gastos').AsFloat:= 0;
    kmtPalet.FieldByName('pal_importe_material').AsFloat:= 0;
    kmtPalet.FieldByName('pal_importe_personal').AsFloat:= 0;
    kmtPalet.FieldByName('pal_importe_general').AsFloat:= 0;
    kmtPalet.FieldByName('pal_importe_envasado').AsFloat:= 0;

    kmtPalet.FieldByName('pal_precio_neto').AsFloat:= 0;
    kmtPalet.FieldByName('pal_precio_descuento').AsFloat:= 0;
    kmtPalet.FieldByName('pal_precio_gastos').AsFloat:= 0;
    kmtPalet.FieldByName('pal_precio_material').AsFloat:= 0;
    kmtPalet.FieldByName('pal_precio_personal').AsFloat:= 0;
    kmtPalet.FieldByName('pal_precio_general').AsFloat:= 0;
    kmtPalet.FieldByName('pal_precio_envasado').AsFloat:= 0;
  end;

  if spStatus = 'V' then
  begin
    kmtPalet.FieldByName('pal_importe_financiero').AsFloat:=bRoundTo(  rKilosPalet * rFinancieroVolcados, 2 );
    kmtPalet.FieldByName('pal_precio_financiero').AsFloat:=rFinancieroVolcados;
  end
  else
  if spStatus = 'D' then
  begin
    (*
    kmtPalet.FieldByName('pal_importe_financiero').AsFloat:=bRoundTo(  qryPaletsPB.fieldByName('peso').AsFloat * rFinancieroVolcados, 2 );
    kmtPalet.FieldByName('pal_precio_financiero').AsFloat:=rFinancieroVolcados;
    *)
    kmtPalet.FieldByName('pal_importe_financiero').AsFloat:=0;
    kmtPalet.FieldByName('pal_precio_financiero').AsFloat:=0;
  end
  else
  if spStatus = 'C' then
  begin
    kmtPalet.FieldByName('pal_importe_financiero').AsFloat:=bRoundTo(  rKilosPalet * rFinancieroCargados, 2 );
    kmtPalet.FieldByName('pal_precio_financiero').AsFloat:=rFinancieroCargados;
  end
  else
  begin
    kmtPalet.FieldByName('pal_importe_financiero').AsFloat:= 0;
    kmtPalet.FieldByName('pal_precio_financiero').AsFloat:= 0;
  end;


  if (spStatus = 'V') then
  begin
    kmtPalet.FieldByName('pal_importe_flete').AsFloat := bRoundTo( kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat  * rFlete, 2);
    kmtPalet.FieldByName('pal_precio_flete').AsFloat :=rFlete;
  end
  else if (spStatus = 'D') then
  begin
    kmtPalet.FieldByName('pal_importe_flete').AsFloat := 0;
    kmtPalet.FieldByName('pal_precio_flete').AsFloat :=0;
  end
  else
  begin
    kmtPalet.FieldByName('pal_importe_flete').AsFloat := bRoundTo( rKilosPalet * rFlete, 2);
    kmtPalet.FieldByName('pal_precio_flete').AsFloat :=rFlete;
  end;

//  kmtPalet.FieldByName('pal_importe_flete').AsFloat :=bRoundTo( rKilosPalet * rFlete, 2 );
//  kmtPalet.FieldByName('pal_precio_flete').AsFloat :=rFlete;


  if ( qryPaletsPB.FieldByName('calidad').AsString = 'P' ) and ( spStatus <> 'D' )then
  begin
    spStatus:= 'P';
  end;
  kmtPalet.FieldByName('pal_status').AsString:= spStatus;
  //Platano Maduro o Verdad
  if (spStatus = 'C') and (qryPaletsPB.FieldByName('calidad').AsString <> 'P') then
  begin
    if qryPaletsPB.FieldByName('calidad').AsString = 'M' then
      kmtPalet.FieldByName('pal_calidad').AsString:= 'M'
    else
      kmtPalet.FieldByName('pal_calidad').AsString:= 'V';
  end;

  rKilosPalet:= kmtPalet.FieldByName('pal_kilos_teoricos').AsFloat;

  kmtPalet.FieldByName('pal_importe_compra').AsFloat:= bRoundTo( rKilosPalet * rCosteEntrega, 2);

  if spStatus = 'D' then
  begin
    kmtPalet.FieldByName('pal_importe_beneficio').AsFloat:= 0;
  end
  else
  begin
    kmtPalet.FieldByName('pal_importe_beneficio').AsFloat:= bRoundTo( rKilosPalet * rBenificio, 2);
  end;

  if kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat <> 0 then
  begin
    kmtPalet.FieldByName('pal_precio_compra').AsFloat:=
      bRoundTo( kmtPalet.FieldByName('pal_importe_compra').AsFloat / kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat, 5);
    kmtPalet.FieldByName('pal_precio_beneficio').AsFloat:=
      bRoundTo( kmtPalet.FieldByName('pal_importe_beneficio').AsFloat / kmtPalet.FieldByName('pal_kilos_liquidar').AsFloat, 5);
  end
  else
  begin
    kmtPalet.FieldByName('pal_precio_compra').AsFloat:= 0;
    kmtPalet.FieldByName('pal_precio_beneficio').AsFloat:= 0;
  end;
  //kmtPalet.FieldByName('pal_precio_beneficio').AsFloat:= rCosteEntrega;

  if bExcluirIndirecto then
    kmtPalet.FieldByName('pal_precio_ind_almacen').AsFloat := 0
  else
    kmtPalet.FieldByName('pal_precio_ind_almacen').AsFloat := kmtCostesProv.FieldByName('costeIndirectoAlmacen').AsFloat;
  kmtPalet.FieldByName('pal_importe_ind_almacen').AsFloat := bRoundTo(rKilosPalet * kmtPalet.FieldByName('pal_precio_ind_almacen').AsFloat, 2);

  kmtPalet.FieldByName('pal_importe_liquidar').AsFloat:=
    kmtPalet.FieldByName('pal_importe_neto').AsFloat -
    (
      kmtPalet.FieldByName('pal_importe_descuento').AsFloat +
      kmtPalet.FieldByName('pal_importe_gastos').AsFloat +
      kmtPalet.FieldByName('pal_importe_envasado').AsFloat +
      kmtPalet.FieldByName('pal_importe_compra').AsFloat +
      kmtPalet.FieldByName('pal_importe_beneficio').AsFloat +
      kmtPalet.FieldByName('pal_importe_financiero').AsFloat +
      kmtPalet.FieldByName('pal_importe_flete').AsFloat +
      kmtPalet.FieldByName('pal_importe_ind_almacen').AsFloat
    );

  kmtPalet.FieldByName('pal_precio_liquidar').AsFloat:=
    kmtPalet.FieldByName('pal_precio_neto').AsFloat -
    (
      kmtPalet.FieldByName('pal_precio_descuento').AsFloat +
      kmtPalet.FieldByName('pal_precio_gastos').AsFloat +
      kmtPalet.FieldByName('pal_precio_envasado').AsFloat +
      kmtPalet.FieldByName('pal_precio_compra').AsFloat +
      kmtPalet.FieldByName('pal_precio_beneficio').AsFloat +
      kmtPalet.FieldByName('pal_precio_financiero').AsFloat +
      kmtPalet.FieldByName('pal_precio_flete').AsFloat +
      kmtPalet.FieldByName('pal_precio_ind_almacen').AsFloat
    );

  if ( kmtPalet.FieldByName('pal_sscc_origen').AsString = '' ) or
     ( kmtPalet.FieldByName('pal_sscc_final').AsString = kmtPalet.FieldByName('pal_sscc_origen').AsString ) then
    kmtPalet.FieldByName('pal_palet').AsInteger:= 1
  else
    kmtPalet.FieldByName('pal_palet').AsInteger:= 0;
  kmtPalet.FieldByName('pal_entrega_palets').AsInteger:= qryEntregas.fieldByName('palets').AsInteger;
  kmtPalet.FieldByName('pal_entrega_cajas').AsInteger:= qryEntregas.fieldByName('cajas').AsInteger;
  kmtPalet.FieldByName('pal_entrega_kilos').AsFloat:= qryEntregas.fieldByName('kilos').AsInteger;

  kmtPalet.Post;
end;



procedure TDLLiquidaEntrega.CosteEntrega;
var
  rKilos, rImporte: Real;
  iTransporte: Integer;
begin
  iTransporte:= 0;
  //rKilos:= qryEntregas.FieldByName('kilos').AsFloat;

  qryEntregasProveedor.ParamByName('entrega').AsString:= qryEntregas.FieldByName('codigo_ec').AsString;
  qryEntregasProveedor.Open;
  rKilos:= qryEntregasProveedor.FieldByName('kilos').AsFloat;
  spEmpresa:= qryEntregasProveedor.FieldByName('empresa_el').AsString;
  spProducto:= qryEntregasProveedor.FieldByName('producto_el').AsString;
  spProductoBase:= GetProductoBase( spEmpresa, spProducto);
  qryEntregasProveedor.Close;

  rImporte:= 0;
  while not qryGastosEntrega.Eof do
  begin
    //unidad_dist_tg
    rImporte:= rImporte + qryGastosEntrega.FieldByName('importe_ge').AsFloat;
//    if qryGastosEntrega.FieldByName('tipo_ge').AsString = '040' then
    if qryGastosEntrega.FieldByName('tipo_ge').AsString = '012' then
    begin
      iTransporte:= 1;
    end;
    qryGastosEntrega.Next;
  end;

  if rKilos <> 0 then
  begin
    rCosteEntrega:= bRoundTo( rImporte / rKilos, 5 );
  end
  else
  begin
    rCosteEntrega:= 0;
  end;

  if rCosteEntrega < rMinTteCanario then
    rCosteEntrega:= rMinTteCanario;

  if kmtGastosTransito.Active then
  begin
    kmtGastosTransito.Insert;

    kmtGastosTransito.FieldByName('entrega').AsString:= qryEntregas.FieldByName('codigo_ec').AsString;
    kmtGastosTransito.FieldByName('kilos').AsFloat:= rKilos;
    kmtGastosTransito.FieldByName('importe').AsFloat:= rImporte;
    kmtGastosTransito.FieldByName('coste_kilos').AsFloat:= rCosteEntrega;
    kmtGastosTransito.FieldByName('transporte').AsInteger:= iTransporte;
    kmtGastosTransito.Post;

    //if iTransporte = 0 then
    // bFaltanCostesEntrega:= True;
  end;
end;

function StrFiltroStatus( const ADestrio, APlacero, ACargado, AVolcado: Boolean ): string;
begin
  Result:= '';
  if ADestrio then
  begin
    Result:= 'liq_status = ''DESTRIO'' ';
  end;
  if APlacero then
  begin
    if Result = '' then
      Result:= 'liq_status = ''PLACERO'' '
    else
      Result:= Result + ' or liq_status = ''PLACERO'' ';
  end;
  if ACargado then
  begin
    if Result = '' then
      Result:= 'liq_status = ''DIRECTA'' '
    else
      Result:= Result + ' or liq_status = ''DIRECTA'' ';
  end;
  if AVolcado then
  begin
    if Result = '' then
      Result:= 'liq_status = ''VOLCADO'' '
    else
      Result:= Result + ' or liq_status = ''VOLCADO'' ';
  end;
end;

procedure TDLLiquidaEntrega.LiquidaEntregasPlatano( AOwner: TComponent; const AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega: string;
                              const APrecios, AProveedores, AClientes, ADestrio, APlacero, ACargado, AVolcado, AbFinancieroCargados, AbFinancieroVolcados, AFlete, AbIndirecto: boolean;
                              const ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete, AMinTteCliente, AMinTteCanario, AMinCosteEnvasado: Real );
var
  sAux: string;
  bProvLiq: Boolean;
  rTotalDestrioTfe, rTotalDestrioTfeImporte, rTotalPeso, rKilosCanarias, rKilosCompra: Real;
begin
  DLLiquidaIncidencias.InicializarProblemas;
  AbrirTablasTemporales;
  InicializaMinimos( AMinTteCliente, AMinTteCanario, AMinCosteEnvasado );


  sUnicoProv := '';
  CalcularEuroKilo(AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega);
  CalcularKilosDestrioTenerife(AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega, ACosteFlete);
  if (AProveedor <> '') and (EsProveedorALiquidar('F17', AProveedor)) then
  begin
    sUnicoProv := AProveedor;
    GetCostesProveedor(AProveedor, AAnyoSem);
  end
  else
  begin
    //Cargar costes para todos nuestros proveedores (ej: 421)
    GetCostesProveedorTotal(AEmpresa, AAnyoSem, AProveedor, AProductor, AProducto, AEntrega);
  end;

  if  AEntrega <> '' then
  begin
    sAux:= Copy( AEntrega, 1, 3 );
  end
  else
  begin
    sAux:= AEmpresa;
  end;

  if ( sAux = 'F17' ) or ( sAux =  'BAG' ) then
  begin
    //F17
    if SelectEntregas( 'F17', AAnyoSem, AProveedor, AProductor, AProducto, AEntrega ) then
      DatosLiquidaRF( 'F17', APrecios, ( AProveedores or AClientes ), ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete, AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto );
    LimpiarTablasTemporales;
  end;
  (*
  if ( sAux = 'F23' ) or ( sAux =  'BAG' ) then
  begin
    //F23
    if SelectEntregas( 'F23', AAnyoSem, AProveedor, AProductor, AEntrega ) then
      DatosLiquidaRF( 'F23', APrecios, ( AProveedores or AClientes ), ABenificio, AFinacieroVolcados, AFinacieroCargados );
    LimpiarTablasTemporales;
  end;
  *)
  (*
  if ( sAux = 'F24' ) or ( sAux =  'BAG' ) then
  begin
    //F24
    if SelectEntregas( 'F24', AAnyoSem, AProveedor, AProductor, AEntrega ) then
      DatosLiquidaRF( 'F24', APrecios, ( AProveedores or AClientes ), ABenificio, AFinacieroVolcados, AFinacieroCargados );
    LimpiarTablasTemporales;
  end;
  *)
  if ( sAux = 'F42' ) or ( sAux =  'BAG' ) then
  begin
    //F42
    if SelectEntregasVerde( 'F42', AAnyoSem, AProveedor, AProductor, AProducto, AEntrega ) then
      DatosLiquidaVerde( 'F42', APrecios, ( AProveedores or AClientes ), ABenificio, AFinacieroCargados, ACosteFlete, AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto );
    LimpiarTablasTemporales;
  end;


  DLLiquidaIncidencias.VerProblemas( sEmpresaIni, sSemanaIni, AProducto );

  rTotalDestrioTfe :=  TotalDestrioTfePeso;
  rTotalDestrioTfeImporte := TotalDestrioTfeImporte;
  rTotalPeso := TotalPeso;
  rKilosCanarias := KilosCanarias;
  rKilosCompra := KilosCompra;
  rImporteCanarias := ImporteCanarias;
  rImporteCompra := ImporteCompra;
  rImporteLiquidar := ImporteLiquidar;
  rTotalCompra := ImporteTotalCompra;

  kmtLiquidacion.First;
  kmtLiquidacion.Filtered:= False;
  CrearDetalleCsv(AEmpresa, AProducto, AAnyoSem);

  if AProveedores then
  begin
    kmtLiquidacion.Filtered:= False;
    kmtLiquidacion.Filter:= StrFiltroStatus( ADestrio, APlacero, ACargado, AVolcado );
    if kmtLiquidacion.Filter <> '' then
      kmtLiquidacion.Filtered:= True;

    kmtLiquidacion.SortFields:='liq_anyo_semana;liq_proveedor;liq_canarias;liq_almacen;liq_categoria;liq_cliente_sal;liq_status;liq_entrega';
    kmtLiquidacion.Sort([]);
    kmtLiquidacion.First;
    PrevisualizarLiquidacion( 'BAG', AProducto, APrecios );
    kmtLiquidacion.Filtered:= False;
  end;
  if AClientes then
  begin
    kmtLiquidacion.SortFields:='liq_anyo_semana;liq_cliente_sal;liq_categoria;liq_proveedor;liq_canarias;liq_almacen;liq_status;liq_entrega;liq_precio_financiero';
    kmtLiquidacion.Sort([]);
    kmtLiquidacion.First;
    PrevisualizarClientes( 'BAG', AProducto, APrecios );

    kmtClientes.SortFields:='res_anyo_semana;res_status;res_calidad;res_cliente;res_categoria';
    kmtClientes.Sort([]);
    kmtClientes.First;
    if AProveedor <> '' then
      bProvLiq := EsProveedorALiquidar('F17', AProveedor)
    else
      bProvLiq := false;

     PrevisualizarResumenClientes( AOwner, 'BAG', AProducto, APrecios, bProvLiq, rTotalDestrioTfe, rTotalDestrioTfeImporte, rTotalPeso, rTotalCompra   );
  end;

  kmtResumen.SortFields:='res_anyo_semana;res_categoria;res_status';
  kmtResumen.Sort([]);
  kmtResumen.First;
  PrevisualizarResumen( 'BAG', AProducto, APrecios, rTotalDestrioTfe, rTotalDestrioTfeImporte, rTotalPeso, rKilosCanarias, rKilosCompra,
                        rImporteCanarias, rImporteCompra, rImporteLiquidar );

  CerrarTablasTemporales;
end;


procedure TDLLiquidaEntrega.CR1AddReports(Sender: TObject);
begin
  compositeReport.Reports.Add( LiquidaResumenClientesQL.QLLiquidaResumenClientes );
//  compositeReport.Reports.Add( LiquidaResumenClientesTfeQL.QLLiquidaResumenClientesTfe);
end;

procedure TDLLiquidaEntrega.CrearDetalleCsv(const AEmpresa, AProducto, AAnyoSem: string);
var
  Stream: TFileStream;
  i: Integer;
  OutLine: string;
  sTemp, sAux: string;
begin
  with TSaveDialog.Create(Self) do
    try
      Title := '  Guardar INFORME DETALLADO.';
      Filter := 'Documento EXCEL_CSV (*.csv)|*.csv|';
                //'Comma Separed File (*.csv)|*.csv';


      sAux:= 'INFORME_LIQUIDACION_DETALLADO_' + AEmpresa  + '_SEMANA_' + aAnyoSem + '_' + AProducto;
      sAux:= StringReplace(sAux, ' ', '_', [rfReplaceAll] );
      sAux:= StringReplace(sAux, 'ñ', 'n', [rfReplaceAll,rfIgnoreCase] );
      sAux:= StringReplace(sAux, 'á', 'a', [rfReplaceAll,rfIgnoreCase] );
      sAux:= StringReplace(sAux, 'é', 'e', [rfReplaceAll,rfIgnoreCase] );
      sAux:= StringReplace(sAux, 'í', 'i', [rfReplaceAll,rfIgnoreCase] );
      sAux:= StringReplace(sAux, 'ó', 'o', [rfReplaceAll,rfIgnoreCase] );
      sAux:= StringReplace(sAux, 'ú', 'u', [rfReplaceAll,rfIgnoreCase] );
      FileName:= sAux + '.csv';

      Execute;

      Stream := TFileStream.Create(FileName, fmCreate);

    try
      OutLine := 'DETALLE LIQUIDACION ' + aAnyoSem;
      SetLength(OutLine, Length(OutLine));
      Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
      Stream.Write(sLineBreak, Length(sLineBreak));

      //Detalle
      OutLine := 'EMPRESA;ANOSEMANA;PROVEEDOR;LIQ_CANARIAS;LIQ_ALMACEN;LIQ_CATEGORIA;LIQ_CLIENTE;LIQ_ENTREGA;LIQ_STATUS;LIQ_CALIDAD;PALETS;CAJAS;KILOS;PALET CONFECCIONADOS;' +
                 'CAJAS CONFECCIONADAS;KILOS CONFECCIONADOS;KILOS TEORICOS;KILOS LIQUIDAR;IMPORTE NETO;IMPORTE DESCUENTO;IMPORTE GASTOS;IMPORTE MATERIAL;IMPORTE PERSONAL;' +
                 'IMPORTE GENERAL;IMPORTE ENVASADO;IMPORTE COMPRA;IMPORTE BENEFICIO;IMPORTE FINANCIERO;IMPORTE FLETE;IMPORTE LIQUIDAR;IMPORTE POR PRECIO;PRECIO BRUTO;PRECIO NETO;'+
                 'PRECIO DESCUENTO;PRECIO GASTOS;PRECIO MATERIAL;PRECIO PERSONAL;PRECIO GENERAL;PRECIO ENVASADO;PRECIO COMPRA;PRECIO BENEFICIO;PRECIO FINANCIERO;PRECIO FLETE;PRECIO A LIQUIDAR';
      SetLength(OutLine, Length(OutLine));
      Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
      Stream.Write(sLineBreak, Length(sLineBreak));

      while not kmtLiquidacion.Eof do
      begin
        // You'll need to add your special handling here where OutLine is built
        OutLine := '';
        for i := 0 to kmtLiquidacion.FieldCount - 1 do
        begin
          sTemp := kmtLiquidacion.Fields[i].AsString;
  //        sTemp := StringReplace( sTemp, ',', '.', [rfReplaceAll]);
          // Special handling to sTemp here
          OutLine := OutLine + sTemp + ';';
        end;
        // Remove final unnecessary ','
        SetLength(OutLine, Length(OutLine));
        // Write line to file
        Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
        // Write line ending
        Stream.Write(sLineBreak, Length(sLineBreak));
        kmtLiquidacion.Next;
      end;

      //Destrio Tenerife
      kmtKilosDestrioTfe.First;
      if kmtKilosDestrioTfe.Recordcount > 1 then
      begin

        OutLine := '';
        SetLength(OutLine, Length(OutLine) - 1);
        Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
        Stream.Write(sLineBreak, Length(sLineBreak));

        OutLine := 'DESTRIO TENERIFE ' + aAnyoSem;
        SetLength(OutLine, Length(OutLine));
        Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
        Stream.Write(sLineBreak, Length(sLineBreak));

        OutLine := 'ENTREGA;EMPRESA;PROVEEDOR;PRODUCTO;CATEGORIA;VARIEDAD;PESO;IMPORTE';
        SetLength(OutLine, Length(OutLine));
        Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
        Stream.Write(sLineBreak, Length(sLineBreak));

        while not kmtKilosDestrioTfe.Eof do
        begin
          OutLine := '';
          for i := 0 to kmtKilosDestrioTfe.FieldCount - 1 do
          begin
            sTemp := kmtKilosDestrioTfe.Fields[i].AsString;
    //        sTemp := StringReplace( sTemp, ',', '.', [rfReplaceAll]);
            // Special handling to sTemp here
            OutLine := OutLine + sTemp + ';';
          end;
          // Remove final unnecessary ','
          SetLength(OutLine, Length(OutLine));
          // Write line to file
          Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
          // Write line ending
          Stream.Write(sLineBreak, Length(sLineBreak));
          kmtKilosDestrioTfe.Next;
        end;
      end;

    finally
      Stream.Free;  // Saves the file
    end;
    finally
      Free;
    end;
end;

procedure TDLLiquidaEntrega.DatosLiquidaVerde( const AEmpresa: string; const APrecios, AProveedores: boolean; const ABenificio, AFinacieroCargados, AcosteFlete: Real;
                                               const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: boolean );
begin
  ValorarVerde( APrecios, ABenificio, AFinacieroCargados, ACosteFlete, AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto );

  kmtLiquidacion.Filter:= 'liq_empresa=' + QuotedStr( AEmpresa );
  kmtLiquidacion.Filtered:= True;
  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_categoria;liq_status';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenCategorias;
  kmtLiquidacion.Filtered:= False;

  kmtLiquidacion.Filter:= 'liq_empresa=' + QuotedStr( AEmpresa );
  kmtLiquidacion.Filtered:= True;
  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_status;liq_cliente_sal;liq_categoria';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenClientes;
  kmtLiquidacion.Filtered:= False;

(*
  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_categoria;liq_status';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenCategorias;
*)
end;

procedure TDLLiquidaEntrega.DatosLiquidaRF( const AEmpresa: string; const APrecios, AProveedores: boolean; const ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete: Real;
                                            const AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto: boolean);
begin
  ValorarPalets( APrecios, ABenificio, AFinacieroVolcados, AFinacieroCargados, ACosteFlete, AbFinancieroCargados, AbFinancieroVolcados, AbIndirecto );

  kmtPalet.SortFields:='pal_anyo_semana;pal_proveedor;pal_canarias;pal_almacen;pal_categoria;pal_cliente_sal;pal_status;pal_entrega';
  kmtPalet.Sort([]);
  kmtPalet.First;
  MakeInformeLiquidacion;

  kmtLiquidacion.Filter:= 'liq_empresa=' + QuotedStr( AEmpresa );
  kmtLiquidacion.Filtered:= True;
  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_categoria;liq_status';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenCategorias;
  kmtLiquidacion.Filtered:= False;

  kmtLiquidacion.Filter:= 'liq_empresa=' + QuotedStr( AEmpresa );
  kmtLiquidacion.Filtered:= True;
  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_status;liq_cliente_sal;liq_categoria;liq_calidad';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenClientes;
  kmtLiquidacion.Filtered:= False;
end;

procedure TDLLiquidaEntrega.LimpiarTablasTemporales;
begin
  kmtPalet.Close;
  //kmtLiquidacion.Close;
  kmtGastosTransito.Close;
  //kmtEuroKilo.Close;
//  kmtCostesProv.Close;
  kmtPalet.Open;
  //kmtLiquidacion.Open;
  kmtGastosTransito.Open;
 // kmtEuroKilo.Open;
//  kmtCostesProv.Open;
end;

end.
