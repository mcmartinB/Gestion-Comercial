unit MargenCargaRFAlmacenDL;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;

const
  kiTodo: Integer = 0;
  kiStock: Integer = 1;
  kiCarga: Integer = 2;
  kiVolcado: Integer = 3;
  kiDestrio: Integer = 4;
  kiConsumido: Integer = 10;

  kiNoVerTransitos: Integer = 0;
  kiVerSoloTransitos: Integer = 1;
  kiVerTodo: Integer = 2;

type
  TDLMargenCargaRFAlmacen = class(TDataModule)
    qryEntregas: TQuery;
    dsEntregas: TDataSource;
    qryEntregasLin: TQuery;
    dsEntregasLin: TDataSource;
    qryPaletsPB: TQuery;
    dsPaletsPB: TDataSource;
    qryOrdenCarga: TQuery;
    qryEnvase: TQuery;
    kmtPalet: TkbmMemTable;
    kmtEntregasCab: TkbmMemTable;
    qryEntregasLineasLocal: TQuery;
    qryFechaSalida: TQuery;
    qryKilosTeoricosLinea: TQuery;
    qrySalidasLin: TQuery;
    kmtTransitos: TkbmMemTable;
    kmtPrecioFOB: TkbmMemTable;
    kmtKilosTeoricos: TkbmMemTable;
    qryKilosVariedadRF: TQuery;
    qryEntregasFacturasLocal: TQuery;
    kmtLineas: TkbmMemTable;
    qryEntregasRF: TQuery;
    kmtEntregasLin: TkbmMemTable;
    DSEntregasLocal: TDataSource;
    qryTotalesRF: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    bRF: Boolean; //Necesitamos la RF???
    //Parametros iniciales
    iTipo, iVerTransitos: Integer;
    sEmpresaIni, sPlanta, sProducto, sSemana, sEntrega: string;
    dFechaIni, dFechaFin: TDateTime;
    bFechaIni, bFechaFin: Boolean;
    rFinancieroCargados, rFinancieroVolcados: real;
    bVariedad, bCategoria, bCalibre: boolean;

    //Variables entregas
    rKilosTotalRF: real;
    iInCajas, iInUnidades: Integer;
    rInKilos, rInImporte: Real;
    bInImporte: Boolean;
    rInCompra, rInTransporte, rInArancel, rInTransito, rInEstadistico: Real;
    bInCompra, bInTransporte, bInArancel, bInTransito, bInEstadistico: Boolean;

    //Parametros venta
    spStatus: string;
    spEmpresa,  spCentro, spAlbaran, spFechaAlbaran, spEnvase, spCliente, spProducto, spCategoria: string;
    spDestino: string;

    //Variables globales
    rgPeso, rgNeto, rgDescuento, rgGastos, rgMaterial, rgPersonal, rgGeneral: Real;

    procedure InicializaVariables;

    function  LoadParamsByStatus( var VMsg: string; var ATipoPalet: integer  ): boolean;
    procedure LoadParamsDestrio;
    procedure LoadParamsVolcados;
    function  LoadParamsCargados( var ATransitos: boolean ): boolean;
    procedure CleanParams;

    function  GetEnvaseProveedor( const AEmpresa, AProveedor, AProducto, AVariedad: string ): string;
    function  GetRelacionKilosTeoricos( const AEntrega, AEmpresa, AProveedor, AProducto, ACategoria: string; const AVariedad: integer; var VRelacion, VKilosCaja: real ): Boolean;

    procedure PutSqlQuerys;
    procedure MakeTablasTemporales;
    procedure AbrirTablasTemporales;
    procedure CerrarTablasTemporales;

    procedure ValorarVerde;
    function  ValorarLineaVerde: boolean;
    function  ExisteLineaVerde: boolean;
    procedure NewLineaVerde;
    procedure EditLineaVerde;

    procedure CargarPalets;
    function  CargaPalet: boolean;
    function  PutDataEntrega( var VCajas, VUnidades, VKilos, VCompra, VTransporte, VTransito, VArancel, VEstadistico: Real; var VTieneImporte, VImporteLinea, VImporteCorrecto: boolean ): boolean;
    Function  FechaSalida: string;

    procedure DatosEntrega;


    //Crear lineas con los palets
    procedure MakeLineas;
    function  ExistLinea: boolean;
    procedure NewLinea;
    procedure EditLinea;
    procedure CalculoLinea;

    procedure ConectarRemoto( const APlanta: string; var AQuery: TQuery );
    procedure DesConectarRemoto;

    procedure DatosLiquidaVerde;
    procedure DatosMargenRF;


    //STOCK
    //procedure AltaStock;
    //procedure ValorarStock;

    function  SelectEntregasAlmacen: boolean;
    function  GetFiltroFechas: string;
    function  GetFiltroStatus: string;
    procedure MakeSQL;
    //function  SelectEntregasDirectas: boolean;

    procedure CloseEntregas;

    procedure PreviewPalets;

    procedure AltaCabEntrega;
    procedure AltaLinEntrega;
    procedure CalcularImportesPalets;
    function  GetKilosTotalRF: Real;
  public
    { Public declarations }

    procedure ValorarFrutaProveedorRFAlmacen( const ATipo, AVerTransitos: Integer; const AEmpresa, AProducto, ASemana, AEntrega: string;
                              const ATieneFechaIni, ATieneFechaFin: Boolean; const AFechaIni, AFechaFin: TDateTime;
                              const AFinacieroCargados, AFinacieroVolcados: Real; const AVariedad, ACategoria, ACalibre: boolean );
  end;


implementation

{$R *.dfm}

uses
  UDMBaseDatos, Variants, bMath, MargenCargaRFAlmacenPaletsQL, TablaTemporalFOBData;

var
  DMTablaTemporalFOB: TDMTablaTemporalFOB;
  //LiquidaIncidencias: TDLLiquidaIncidencias;

procedure TDLMargenCargaRFAlmacen.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(DMTablaTemporalFOB);
  //FreeAndNil(DLLiquidaIncidencias);
end;

procedure TDLMargenCargaRFAlmacen.InicializaVariables;
begin
  spStatus:= '';
  spEmpresa:= '';
  spCentro:= '';
  spAlbaran:= '';
  spFechaAlbaran:= '';
  spEnvase:= '';
  spCliente:= '';
  spProducto:= '';
  spCategoria:= '';

  rgPeso:= 0;
  rgNeto:= 0;
  rgDescuento:= 0;
  rgGastos:= 0;
  rgMaterial:= 0;
  rgPersonal:= 0;
  rgGeneral:= 0;
end;

procedure TDLMargenCargaRFAlmacen.ConectarRemoto( const APlanta: string; var AQuery: TQuery );
var
  bAux: boolean;
begin
  bAux:= AQuery.Active;
  if AQuery.Active then
    AQuery.Close;

  if APlanta = 'F17' then
  begin
   if not DMBaseDatos.dbF17.Connected then
     DMBaseDatos.dbF17.Connected:= True;
   AQuery.DatabaseName:= 'dbF17';
  end;
  if APlanta = 'F18' then
  begin
   if not DMBaseDatos.dbF18.Connected then
     DMBaseDatos.dbF18.Connected:= True;
   AQuery.DatabaseName:= 'dbF18';
  end;
  (*
  if APlanta = 'F21' then
  begin
   if not DMBaseDatos.dbF21.Connected then
     DMBaseDatos.dbF21.Connected:= True;
   AQuery.DatabaseName:= 'dbF21';
  end;
  *)
  if APlanta = 'F23' then
  begin
   if not DMBaseDatos.dbF23.Connected then
     DMBaseDatos.dbF23.Connected:= True;
   AQuery.DatabaseName:= 'dbF23';
  end;
  (*
  if APlanta = 'F24' then
  begin
   if not DMBaseDatos.dbF24.Connected then
     DMBaseDatos.dbF24.Connected:= True;
   AQuery.DatabaseName:= 'dbF24';
  end;
  *)

  if bAux then
    AQuery.Open;
end;

procedure TDLMargenCargaRFAlmacen.DesconectarRemoto;
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

procedure TDLMargenCargaRFAlmacen.DataModuleCreate(Sender: TObject);
begin
  DMTablaTemporalFOB := TDMTablaTemporalFOB.Create(self);
  //DLLiquidaIncidencias:= TDLLiquidaIncidencias.Create(self);

  //BASE DATOS CENTRAL -- ENTREGAS/COMPRAS
  (*
  with qryEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select anyo_semana_ec, empresa_ec, codigo_ec, producto_ec, ');
    SQL.Add(' proveedor_ec, (select nombre_p from frf_proveedores ');
    SQL.Add('                       where empresa_p = empresa_ec ');
    SQL.Add('                         and proveedor_p = proveedor_ec ) nom_proveedor, ');
    SQL.Add('        sum(palets_el) palets, sum(cajas_el) cajas, sum(kilos_el) kilos ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and producto_ec = :producto ');
    SQL.Add(' and anyo_semana_ec = :semana ');
    //PLATANIA
    //SQL.Add(' and proveedor_ec <> ''265'' ');
    SQL.Add(' and codigo_ec = codigo_el ');
    SQL.Add(' group by anyo_semana_ec, empresa_ec, codigo_ec, producto_ec, proveedor_ec, nom_proveedor ');
    SQL.Add(' order by anyo_semana_ec, empresa_ec, proveedor_ec ');
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
    SQL.Add('          where empresa_pp = empresa_El ');
    SQL.Add('          and proveedor_pp = proveedor_el ');
    SQL.Add('          and producto_pp = producto_el ');
    SQL.Add('          and variedad_pp = variedad_el ');
    SQL.Add('          and empresa_e = empresa_pp ');
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
    SQL.Add(' and producto_sl = ''P'' ');
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

  with qryKilosTeoricosLinea do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_el, sum(cajas_el) cajas, sum(kilos_el) kilos ');
    SQL.Add(' from frf_entregas_l ');
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
    SQL.Add(' where empresa_pp = :empresa ');
    SQL.Add(' and proveedor_pp = :proveedor ');
    SQL.Add(' and producto_pp = :producto ');
    SQL.Add(' and variedad_pp = :variedad ');
    SQL.Add(' and empresa_e = empresa_pp ');
    SQL.Add(' and codigo_e = codigo_ean_pp ');
  end;

  with qryFechaSalida do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 ');
    SQL.Add('        case when fecha_carga_cab is null ');
    SQL.Add('             then previsto_carga ');
    SQL.Add('             else date( fecha_carga_cab ) end fecha, ');
    SQL.Add('        ean128_cab sscc ');
    SQL.Add(' from rf_palet_pc_cab ');
    SQL.Add(' where cliente_cab = :cliente ');
    SQL.Add(' and fecha_alta_cab > :fecha ');
    SQL.Add(' and ( fecha_carga_cab is not null or previsto_carga is not null )');
    SQL.Add(' and ( status_cab = ''C'' or status_cab = ''S'' ) ');
    SQL.Add(' order by fecha asc ');
  end;
  *)
  bVariedad:= True;
  bCategoria:= True;
  bCalibre:= True;
  PutSqlQuerys;
  MakeTablasTemporales;

end;

procedure TDLMargenCargaRFAlmacen.PutSqlQuerys;
var
  sAux: string;
begin
  //Entregas con carga en las fechas indicadas, sacado de la RF
  (* --> MakeSQL;
  with qryEntregasRF do
  begin
    SQL.Clear;
    SQL.Add(' select entrega ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add('      join frf_orden_carga_c on orden_occ = orden_carga ');
    SQL.Add(' where empresa = :empresa and producto = :producto ');
    SQL.Add(' and status <> ''B'' and status = ''C'' ');
    SQL.Add(' and case when fecha_occ is null then date(fecha_status) ');
    SQL.Add('          else fecha_occ end between :fechaini and :fechafin ');
    SQL.Add(' group by entrega order by entrega ');
  end;
  *)
  //Palets que forman parte de las entregas seleccionadasç
  (* --> MakeSQL;
  with qryPaletsPB do
  begin
    SQL.Clear;
    //tipo_placero
    SQL.Add(' select empresa, centro, entrega, proveedor, proveedor_almacen, producto, variedad, categoria, calibre, status, calidad, ');
    SQL.Add('        date(fecha_alta) fecha_alta, date(fecha_status) fecha_status, cajas, peso, sscc, paletorigen, orden_carga, cliente ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add('      join frf_orden_carga_c on orden_occ = orden_carga ');
    SQL.Add(' where empresa = :empresa and producto = :producto ');
    SQL.Add(' and entrega = :entrega ');
    SQL.Add(' and status <> ''B'' and status = ''C'' ');
    SQL.Add(' and case when fecha_occ is null then date(fecha_status) ');
    SQL.Add('          else fecha_occ end between :fechaini and :fechafin ');
  end;
  *)

  //datos de a RF original de la entrega
  with qryTotalesRF do
  begin
    SQL.Clear;
    SQL.Add(' select sum( peso ) peso ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega =  :entrega ');
    SQL.Add(' and status <> ''B'' ');
    SQL.Add(' group by entrega ');
  end;

  //Datos entrega en la central

  if bVariedad then
  begin
    sAux:= ' variedad_el variedad,'
  end
  else
  begin
    sAux:= ' '''' variedad,';
  end;
  if bCategoria then
  begin
    sAux:= sAux + ' categoria_el categoria,'
  end
  else
  begin
    sAux:= sAux + ' '''' categoria,';
  end;
  if bCalibre then
  begin
    sAux:= sAux + ' calibre_el calibre, '
  end
  else
  begin
    sAux:= sAux + ' '''' calibre,';
  end;

  with qryEntregasLineasLocal do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_el empresa, codigo_el entrega, proveedor_el proveedor, almacen_el almacen, ');
    SQL.Add('        producto_el producto, ' + sAux  );
    SQL.Add('        sum(cajas_el) cajas, sum(unidades_el) unidades, sum(kilos_el) kilos, ');
    SQL.Add('          sum( case when unidad_precio_el = 0 then precio_el * kilos_el ');
    SQL.Add('                    when unidad_precio_el = 1 then precio_el * cajas_el ');
    SQL.Add('                    when unidad_precio_el = 2 then precio_el * unidades_el ');
    SQL.Add('               end ) importe ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el =  :entrega ');
    SQL.Add(' group by empresa, entrega, proveedor, almacen, producto, variedad, categoria, calibre ');
  end;

  with qryEntregasFacturasLocal do
  begin
    SQL.Clear;
    SQL.Add(' select agrupacion_tg tipo, unidad_dist_tg unidad,  sum(importe_ge) importe ');
    SQL.Add(' from frf_gastos_entregas join frf_tipo_gastos on tipo_ge = tipo_tg ');
    SQL.Add(' where codigo_ge = :entrega ');
    SQL.Add(' and gasto_transito_tg = 2 ');
    SQL.Add(' and agrupacion_tg <> ''ESTADISTIC'' ');
    SQL.Add(' group by tipo, unidad ');
  end;
end;

procedure TDLMargenCargaRFAlmacen.MakeTablasTemporales;
begin
//******************************************************************************************
  //PALETS
//******************************************************************************************
  kmtPalet.FieldDefs.Clear;
  kmtPalet.FieldDefs.Add('empresa', ftString, 3, False);
  kmtPalet.FieldDefs.Add('centro', ftString, 3, False);
  kmtPalet.FieldDefs.Add('entrega', ftString, 12, False);
  kmtPalet.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtPalet.FieldDefs.Add('almacen', ftString, 3, False);

  kmtPalet.FieldDefs.Add('fecha_alta', ftDate, 0, False);
  kmtPalet.FieldDefs.Add('sscc_final', ftString, 20, False);
  kmtPalet.FieldDefs.Add('sscc_origen', ftString, 20, False);
  kmtPalet.FieldDefs.Add('producto', ftString, 3, False);
  kmtPalet.FieldDefs.Add('variedad', ftInteger, 0, False);
  kmtPalet.FieldDefs.Add('categoria', ftString, 3, False);
  kmtPalet.FieldDefs.Add('calibre', ftString, 6, False);
  kmtPalet.FieldDefs.Add('status', ftString, 3, False);
  kmtPalet.FieldDefs.Add('calidad', ftString, 3, False);
  kmtPalet.FieldDefs.Add('fecha_status', ftDate, 0, False);

  kmtPalet.FieldDefs.Add('cajas', ftInteger, 0, False);
  kmtPalet.FieldDefs.Add('unidades', ftInteger, 0, False);
  kmtPalet.FieldDefs.Add('kilos_rf', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('kilos_teoricos', ftFloat, 0, False);

  kmtPalet.FieldDefs.Add('compra', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('transporte', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('transito', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('arancel', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('estadistico', ftFloat, 0, False);

  kmtPalet.FieldDefs.Add('tieneimporte', ftBoolean, 0, False);
  kmtPalet.FieldDefs.Add('importelinea', ftBoolean, 0, False);
  kmtPalet.FieldDefs.Add('importecorrecto', ftBoolean, 0, False);

  kmtPalet.FieldDefs.Add('orden', ftInteger, 0, False);
  kmtPalet.FieldDefs.Add('empresa_sal', ftString, 3, False);
  kmtPalet.FieldDefs.Add('centro_sal', ftString, 1, False);
  kmtPalet.FieldDefs.Add('albaran_sal', ftInteger, 0, False);
  kmtPalet.FieldDefs.Add('fecha_sal', ftDate, 0, False);
  kmtPalet.FieldDefs.Add('cliente_sal', ftString, 1, False);
  kmtPalet.FieldDefs.Add('centro_des', ftString, 1, False);
  kmtPalet.FieldDefs.Add('es_transito', ftInteger, 0, False);

  kmtPalet.IndexFieldNames:= 'empresa;proveedor;almacen;entrega;sscc_final';
  kmtPalet.CreateTable;

//******************************************************************************************
  //LINEAS
//******************************************************************************************
  kmtLineas.FieldDefs.Clear;
  kmtLineas.FieldDefs.Add('empresa', ftString, 3, False);
  kmtLineas.FieldDefs.Add('centro', ftString, 3, False);
  kmtLineas.FieldDefs.Add('entrega', ftString, 12, False);
  kmtLineas.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtLineas.FieldDefs.Add('almacen', ftString, 3, False);

  kmtLineas.FieldDefs.Add('producto', ftString, 3, False);
  kmtLineas.FieldDefs.Add('variedad', ftInteger, 0, False);
  kmtLineas.FieldDefs.Add('categoria', ftString, 3, False);
  kmtLineas.FieldDefs.Add('calibre', ftString, 6, False);
  kmtLineas.FieldDefs.Add('status', ftString, 3, False);
  kmtLineas.FieldDefs.Add('calidad', ftString, 3, False);
  kmtLineas.FieldDefs.Add('fecha_status', ftDate, 0, False);

  kmtLineas.FieldDefs.Add('cliente', ftString, 3, False);
  kmtLineas.FieldDefs.Add('orden', ftInteger, 0, False);
  kmtLineas.FieldDefs.Add('albaran', ftInteger, 0, False);
  kmtLineas.FieldDefs.Add('fecha_sal', ftDate, 0, False);
  kmtLineas.FieldDefs.Add('envase', ftString, 9,  False);

  kmtLineas.FieldDefs.Add('cajas', ftInteger, 0, False);
  kmtLineas.FieldDefs.Add('unidades', ftInteger, 0, False);
  kmtLineas.FieldDefs.Add('kilos_rf', ftFloat, 0, False);
  kmtLineas.FieldDefs.Add('kilos_teoricos', ftFloat, 0, False);

  kmtLineas.IndexFieldNames:= 'empresa;proveedor;almacen;entrega;status;producto;variedad;categoria;calibre';
  kmtLineas.CreateTable;


//******************************************************************************************
  //ENTREGAS
//******************************************************************************************
  //cabeceras
  kmtEntregasCab.FieldDefs.Clear;
  kmtEntregasCab.FieldDefs.Add('entrega', ftString, 12, False);
  kmtEntregasCab.FieldDefs.Add('producto', ftString, 3, False);
  kmtEntregasCab.FieldDefs.Add('proveedor', ftString, 3, False);

  kmtEntregasCab.FieldDefs.Add('cajas', ftFloat, 0, False);
  kmtEntregasCab.FieldDefs.Add('unidades', ftFloat, 0, False);
  kmtEntregasCab.FieldDefs.Add('kilos', ftFloat, 0, False);
  kmtEntregasCab.FieldDefs.Add('importe', ftFloat, 0, False);
  kmtEntregasCab.FieldDefs.Add('compra', ftFloat, 0, False);
  kmtEntregasCab.FieldDefs.Add('transporte', ftFloat, 0, False);
  kmtEntregasCab.FieldDefs.Add('transito', ftFloat, 0, False);
  kmtEntregasCab.FieldDefs.Add('arancel', ftFloat, 0, False);
  kmtEntregasCab.FieldDefs.Add('estadistico', ftFloat, 0, False);

  kmtEntregasCab.FieldDefs.Add('importe_correcto', ftBoolean, 0, False);
  kmtEntregasCab.FieldDefs.Add('tiene_importe', ftBoolean, 0, False);
  kmtEntregasCab.FieldDefs.Add('tiene_compra', ftBoolean, 0, False);
  kmtEntregasCab.FieldDefs.Add('tiene_transporte', ftBoolean, 0, False);
  kmtEntregasCab.FieldDefs.Add('tiene_transito', ftBoolean, 0, False);
  kmtEntregasCab.FieldDefs.Add('tiene_arancel', ftBoolean, 0, False);
  kmtEntregasCab.FieldDefs.Add('tiene_estadistico', ftBoolean, 0, False);

  kmtEntregasCab.FieldDefs.Add('kilos_transito', ftFloat, 0, False);
  kmtEntregasCab.FieldDefs.Add('importe_transito', ftFloat, 0, False);

  kmtEntregasCab.IndexFieldNames:= 'entrega';
  kmtEntregasCab.CreateTable;

  //lineas
  kmtEntregasLin.FieldDefs.Clear;
  kmtEntregasLin.FieldDefs.Add('entrega', ftString, 12, False);
  kmtEntregasLin.FieldDefs.Add('producto', ftString, 3, False);
  kmtEntregasLin.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtEntregasLin.FieldDefs.Add('almacen', ftString, 3, False);

  kmtEntregasLin.FieldDefs.Add('variedad', ftString, 3, False);
  kmtEntregasLin.FieldDefs.Add('categoria', ftString, 3, False);
  kmtEntregasLin.FieldDefs.Add('calibre', ftString, 6, False);

  kmtEntregasLin.FieldDefs.Add('cajas', ftFloat, 0, False);
  kmtEntregasLin.FieldDefs.Add('unidades', ftFloat, 0, False);
  kmtEntregasLin.FieldDefs.Add('kilos', ftFloat, 0, False);
  kmtEntregasLin.FieldDefs.Add('importe', ftFloat, 0, False);
  kmtEntregasLin.FieldDefs.Add('compra', ftFloat, 0, False);
  kmtEntregasLin.FieldDefs.Add('transporte', ftFloat, 0, False);
  kmtEntregasLin.FieldDefs.Add('transito', ftFloat, 0, False);
  kmtEntregasLin.FieldDefs.Add('arancel', ftFloat, 0, False);
  kmtEntregasLin.FieldDefs.Add('estadistico', ftFloat, 0, False);

  kmtEntregasLin.IndexFieldNames:= 'entrega;producto;categoria;calibre';
  kmtEntregasLin.CreateTable;

//  ***********************************************************************************
//  ***********************************************************************************
(*
  kmtPrecioFOB.FieldDefs.Clear;
  kmtPrecioFOB.FieldDefs.Add('empresa', ftString, 3, False);
  kmtPrecioFOB.FieldDefs.Add('centro', ftString, 1, False);
  kmtPrecioFOB.FieldDefs.Add('albaran', ftInteger, 0, False);
  kmtPrecioFOB.FieldDefs.Add('fecha', ftDate, 0, False);
  kmtPrecioFOB.FieldDefs.Add('cliente', ftString, 3, False);
  kmtPrecioFOB.FieldDefs.Add('envase', ftString, 9 False);
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

*)
end;

procedure TDLMargenCargaRFAlmacen.AbrirTablasTemporales;
begin
  kmtPalet.Open;
  kmtLineas.Open;
  kmtEntregasCab.Open;
  kmtEntregasLin.Open;
end;

procedure TDLMargenCargaRFAlmacen.CerrarTablasTemporales;
begin
  kmtPalet.Close;
  kmtLineas.Close;
  kmtEntregasCab.Close;
  kmtEntregasLin.Close;
end;

procedure TDLMargenCargaRFAlmacen.ValorarFrutaProveedorRFAlmacen( const ATipo, AVerTransitos: Integer; const AEmpresa, AProducto, ASemana, AEntrega: string;
                              const ATieneFechaIni, ATieneFechaFin: Boolean; const AFechaIni, AFechaFin: TDateTime;
                              const AFinacieroCargados, AFinacieroVolcados: Real; const AVariedad, ACategoria, ACalibre: boolean );
begin
  //DLLiquidaIncidencias.InicializarProblemas;

  //Carga parametros
  (*TODO*)
  bVariedad:= AVariedad;
  bCategoria:= ACategoria;
  bCalibre:= ACalibre;
  PutSqlQuerys;

  //Comprobar que son validos
  iTipo:= ATipo;
  iVerTransitos:= AVerTransitos;
  sEmpresaIni:= AEmpresa;
  sProducto:= AProducto;
  sSemana:= ASemana;
  sEntrega:= AEntrega;
  bFechaIni:= ATieneFechaIni;
  dFechaIni:= AFechaIni;
  bFechaFin:= ATieneFechaFin;
  dFechaFin:= AFechaFin;
  rFinancieroCargados:= AFinacieroCargados;
  rFinancieroVolcados:= AFinacieroVolcados;

  AbrirTablasTemporales;

  if ( sEmpresaIni = 'F17' ) or ( sEmpresaIni =  'BAG' ) then
  begin
    sPlanta:= 'F17';
    if SelectEntregasAlmacen then
      DatosMargenRF;
  end;
  CloseEntregas;
  (*
  if ( sEmpresaIni = 'F18' ) or ( sEmpresaIni =  'BAG' ) then
  begin
    sPlanta:= 'F18';
    if SelectEntregasAlmacen then
      DatosMargenRF;
  end;
  *)
  CloseEntregas;
  if ( sEmpresaIni = 'F23' ) or ( sEmpresaIni =  'BAG' ) then
  begin
    sPlanta:= 'F23';
    if SelectEntregasAlmacen then
      DatosMargenRF;
  end;
  CloseEntregas;
  (*
  if ( sEmpresaIni = 'F24' ) or ( sEmpresaIni =  'BAG' ) then
  begin
    sPlanta:= 'F24';
    if SelectEntregasAlmacen then
      DatosMargenRF;
  end;
  CloseEntregas;
  *)
  DesconectarRemoto;

  PreviewPalets;
  CerrarTablasTemporales;
  (*
  if ( sEmpresaIni = 'F42' ) or ( sEmpresaIni =  'BAG' ) then
  begin
    sPlanta:= 'F42';
    if SelectEntregasDirectas then
      DatosLiquidaVerde;
  end;
  CloseEntregas;
  *)

  //DLLiquidaIncidencias.VerProblemas( sEmpresaIni, sSemanaIni );
  (*
  if AClientes then
  begin
    kmtClientes.SortFields:='res_anyo_semana;res_status;res_cliente;res_categoria';
    kmtClientes.Sort([]);
    kmtClientes.First;
    PrevisualizarResumenClientes( 'BAG', APrecios );
  end;
  *)

  (*
  kmtResumen.SortFields:='res_anyo_semana;res_categoria;res_status';
  kmtResumen.Sort([]);
  kmtResumen.First;
  PrevisualizarResumen( 'BAG', APrecios );
  *)

end;

function TDLMargenCargaRFAlmacen.GetFiltroFechas: string;
var
  sRangoFechas: TStringList;
begin
  sRangoFechas:= TStringList.Create;

  if ( iTipo = kiStock )  then
  begin
    if ( bFechaIni and bFechaFin )  then
    begin
      sRangoFechas.Add(' and date(nvl(fecha_status,fecha_alta)) between :fechaini and :fechafin ');
    end
    else
    if bFechaIni then
    begin
      sRangoFechas.Add(' and date(nvl(fecha_status,fecha_alta)) >= :fechaini  ');
    end
    else
    if bFechaFin then
    begin
      sRangoFechas.Add(' and date(nvl(fecha_status,fecha_alta)) <= :fechafin ');
    end;
  end
  else
  begin
    if ( bFechaIni and bFechaFin ) then
    begin
      if ( iTipo = kiVolcado ) or ( iTipo = kiDestrio ) then
      begin
        sRangoFechas.Add(' and date(nvl(fecha_status,fecha_alta)) between :fechaini and :fechafin ');
      end
      else
      if ( iTipo = kiCarga ) then
      begin
        sRangoFechas.Add(' and case when fecha_occ is null then date(fecha_status) ');
        sRangoFechas.Add('          else fecha_occ end between :fechaini and :fechafin ');
      end
      else
      if ( iTipo = kiConsumido ) or ( iTipo = kiTodo ) then
      begin
        sRangoFechas.Add(' and case when status = ''C'' ');
        sRangoFechas.Add('          then case when fecha_occ is null then date(fecha_status) else fecha_occ end ');
        sRangoFechas.Add('          else date(nvl(fecha_status,fecha_alta)) end between :fechaini and :fechafin ');
      end;
    end
    else
    begin
      if ( sSemana <> '' ) or ( sEntrega <> '' ) then
      begin
        if bFechaIni then
        begin

          if ( iTipo = kiVolcado ) or ( iTipo = kiDestrio ) then
          begin
            sRangoFechas.Add(' and date(nvl(fecha_status,fecha_alta)) >= :fechaini ');
          end
          else
          if ( iTipo = kiCarga )  then
          begin
            sRangoFechas.Add(' and case when fecha_occ is null then date(fecha_status) ');
            sRangoFechas.Add('          else fecha_occ end between  >= :fechaini  ');
          end
          else
          if ( iTipo = kiConsumido ) or ( iTipo = kiTodo ) then
          begin
            sRangoFechas.Add(' and case when status = ''C'' ');
            sRangoFechas.Add('          then case when fecha_occ is null then date(fecha_status) else fecha_occ end ');
            sRangoFechas.Add('          else date(nvl(fecha_status,fecha_alta)) end  >= :fechaini  ');
          end;

        end
        else
        if bFechaFin then
        begin

          if ( iTipo = kiVolcado ) or ( iTipo = kiDestrio ) then
          begin
            sRangoFechas.Add(' and date(nvl(fecha_status,fecha_alta)) <= :fechafin ');
          end
          else
          if ( iTipo = kiCarga ) then
          begin
            sRangoFechas.Add(' and case when fecha_occ is null then date(fecha_status) ');
            sRangoFechas.Add('          else fecha_occ end between  <= :fechafin  ');
          end
          else
          if ( iTipo = kiConsumido ) or ( iTipo = kiTodo ) then
          begin
            sRangoFechas.Add(' and case when status = ''C'' ');
            sRangoFechas.Add('          then case when fecha_occ is null then date(fecha_status) else fecha_occ end ');
            sRangoFechas.Add('          else date(nvl(fecha_status,fecha_alta)) end  <= :fechafin  ');
          end;

        end;
      end
      else
      begin
        raise Exception.Create('Necesito la fecha de inicio y fin.');
      end;
    end;
  end;

  Result:= sRangoFechas.Text;
  FreeAndNil(sRangoFechas);
end;

function TDLMargenCargaRFAlmacen.GetFiltroStatus: string;
begin
  if ( iTipo = kiStock ) then
  begin
    Result:=  'and status = ''S''';
  end
  else
  if ( iTipo = kiCarga ) then
  begin
    Result:=  ' and status = ''C'' ';
  end
  else
  if ( iTipo = kiVolcado ) then
  begin
    Result:=  ' and status = ''V'' ';
  end
  else
  if ( iTipo = kiDestrio ) then
  begin
    Result:=  ' and status = ''D'' ';
  end
  else
  if ( iTipo = kiConsumido ) then
  begin
    Result:=  ' and ( status = ''C'' or status = ''V'' or status = ''D'' )';
  end
  else
  if ( iTipo = kiTodo ) then
  begin
    Result:=  ' and status <> ''B'' ';
  end;
end;

procedure TDLMargenCargaRFAlmacen.MakeSQL;
var
  sRangoFechas, sFiltroStatus: string;
begin
  sRangoFechas:= GetFiltroFechas;
  sFiltroStatus:= GetFiltroStatus;

  //Entregas con datos en las fechas indicadas, sacado de la RF
  with qryEntregasRF do
  begin
    SQL.Clear;
    SQL.Add(' select entrega ');
    SQL.Add(' from rf_palet_pb ');
    if ( iTipo = kiCarga ) or ( iTipo = kiConsumido ) or ( iTipo = kiTodo ) then
       SQL.Add('      left join frf_orden_carga_c on orden_occ = orden_carga ');
    if ( sSemana <> '' ) then
       SQL.Add('      join frf_entregas_c on codigo_ec = entrega ');
    SQL.Add(' where empresa = :empresa  ');
    SQL.Add(' and producto = :producto ');

    SQL.Add(sRangoFechas);
    SQL.Add( sFiltroStatus );
    if sEntrega <> '' then
      SQL.Add(' and entrega = :entrega ');
    if sSemana <> '' then
      SQL.Add(' and anyo_semana_ec = :semana ');

    if  ( iTipo = kiCarga ) or ( iTipo = kiConsumido ) or ( iTipo = kiTodo ) then
    begin
      if ( iVerTransitos = kiNoVerTransitos ) then
        SQL.Add(' and nvl(centro_destino_occ,'''') = '''' ')
      else
      if ( iVerTransitos = kiVerSoloTransitos ) then
        SQL.Add(' and nvl(centro_destino_occ,'''') <> '''' ');
    end;

    SQL.Add(' group by entrega order by entrega ');
  end;

  //Palets que forman parte de las entregas seleccionadasç
  with qryPaletsPB do
  begin
    SQL.Clear;
    SQL.Add(' select empresa, centro, entrega, proveedor, proveedor_almacen, producto, variedad, categoria, calibre, status, calidad, ');
    SQL.Add('        date(fecha_alta) fecha_alta, date(fecha_status) fecha_status, cajas, peso, sscc, paletorigen, orden_carga, cliente, ');
    SQL.Add('        orden_occ, empresa_occ, centro_salida_occ, fecha_occ, n_albaran_occ, cliente_sal_occ, ');
    SQL.Add('        centro_destino_occ, status_occ, traspasada_occ ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add('      left join frf_orden_carga_c on orden_occ = orden_carga ');
    SQL.Add(' where empresa = :empresa  ');
    SQL.Add(' and producto = :producto ');

    SQL.Add( sRangoFechas );
    SQL.Add( sFiltroStatus );
    SQL.Add(' and entrega = :entrega ');

    if  ( iTipo = kiCarga ) or ( iTipo = kiConsumido ) or ( iTipo = kiTodo ) then
    begin
      if ( iVerTransitos = kiNoVerTransitos ) then
        SQL.Add(' and nvl(centro_destino_occ,'''') = '''' ')
      else
      if ( iVerTransitos = kiVerSoloTransitos ) then
        SQL.Add(' and nvl(centro_destino_occ,'''') <> '''' ');
    end;
  end;

end;

function TDLMargenCargaRFAlmacen.SelectEntregasAlmacen: boolean;
begin
  bRF:= True;
  ConectarRemoto( sPlanta, qryEntregasRF );
  ConectarRemoto( sPlanta, qryPaletsPB );

  MakeSQL;

  qryEntregasRF.ParamByName('empresa').AsString:= sPlanta;
  qryEntregasRF.ParamByName('producto').AsString:= sProducto;

  if bFechaIni then
    qryEntregasRF.ParamByName('fechaini').AsDateTime:= dFechaIni;
  if bFechaFin then
    qryEntregasRF.ParamByName('fechafin').AsDateTime:= dFechaFin;
  if sSemana <> '' then
    qryEntregasRF.ParamByName('semana').AsString:= sSemana;
  if sEntrega <> '' then
    qryEntregasRF.ParamByName('entrega').AsString:= sEntrega;

  qryEntregasRF.Open;
  result:= not qryEntregasRf.IsEmpty;
  if Result then
  begin
    qryPaletsPB.ParamByName('empresa').AsString:= sPlanta;
    qryPaletsPB.ParamByName('producto').AsString:= sProducto;

    if bFechaIni then
      qryPaletsPB.ParamByName('fechaini').AsDateTime:= dFechaIni;
    if bFechaFin then
      qryPaletsPB.ParamByName('fechafin').AsDateTime:= dFechaFin;
    qryPaletsPB.Open;
  end;
end;


(*
function TDLMargenCargaRFAlmacen.SelectEntregasDirectas: boolean;
begin
  bRF:= False;
  //ConectarRemoto( AEmpresa ); //No es necesaria la RF ni datos del almacen
  //result:= PreparaTablaEntregas;
end;
*)

procedure TDLMargenCargaRFAlmacen.CloseEntregas;
begin
  qryEntregasRF.Close;
  qryPaletsPB.Close;
end;

procedure TDLMargenCargaRFAlmacen.ValorarVerde;
begin
  InicializaVariables;

  qryEntregas.First;
  while not qryEntregas.Eof do
  begin
    DatosEntrega;
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
  CalculoLinea;
end;

function  TDLMargenCargaRFAlmacen.ExisteLineaVerde: boolean;
begin
  Result:= False;
  (*
  result:= kmtLiquidacion.Locate( 'liq_empresa;liq_anyo_semana;liq_proveedor;liq_almacen;liq_categoria;liq_cliente_sal;liq_entrega;liq_status',
       VarArrayOf([qryEntregas.fieldByName('empresa_ec').AsString,
                   qryEntregas.fieldByName('anyo_semana_ec').AsString,
                   qryEntregas.fieldByName('proveedor_ec').AsString,
                   qryEntregasLin.fieldByName('almacen').AsString,
                   qryEntregasLin.fieldByName('categoria').AsString,
                   spCliente,
                   qryEntregas.fieldByName('codigo_ec').AsString,
                   'DIRECTA']),[]);
  *)
end;

procedure TDLMargenCargaRFAlmacen.NewLineaVerde;
//var
//  rAux: Real;
begin
  (*
  kmtLiquidacion.Insert;

  kmtLiquidacion.FieldByName('liq_empresa').AsString:= qryEntregas.FieldByName('empresa_ec').AsString;
  kmtLiquidacion.FieldByName('liq_anyo_semana').AsString:= qryEntregas.FieldByName('anyo_semana_ec').AsString;
  kmtLiquidacion.FieldByName('liq_proveedor').AsString:= qryEntregas.FieldByName('proveedor_ec').AsString;
  kmtLiquidacion.FieldByName('liq_almacen').AsString:= qryEntregasLin.FieldByName('almacen').AsString;
  kmtLiquidacion.FieldByName('liq_categoria').AsString:= qryEntregasLin.FieldByName('categoria').AsString;
  kmtLiquidacion.FieldByName('liq_cliente_sal').AsString:= spCliente;
  kmtLiquidacion.FieldByName('liq_entrega').AsString:= qryEntregas.FieldByName('codigo_ec').AsString;
  kmtLiquidacion.FieldByName('liq_status').AsString:= 'DIRECTA';

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

  kmtLiquidacion.FieldByName('liq_precio_financiero').AsFloat:= 0;
  kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rFinancieroCargados, 2);

  kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat:=
    kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat -
        (
          kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat
        );
  kmtLiquidacion.FieldByName('liq_precio_liquidar').AsFloat:= 0;//kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat / rgPeso;

  kmtLiquidacion.FieldByName('liq_entrega_palets').AsInteger:= qryEntregas.FieldByName('palets').AsInteger;
  kmtLiquidacion.FieldByName('liq_entrega_cajas').AsInteger:= qryEntregas.FieldByName('cajas').AsInteger;
  kmtLiquidacion.FieldByName('liq_entrega_kilos').AsFloat:= qryEntregas.FieldByName('kilos').AsFloat;

  kmtLiquidacion.Post;
  *)
end;

procedure TDLMargenCargaRFAlmacen.EditLineaVerde;
//var
  //rAux: Real;
begin
  (*
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

  kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat:= bRoundTo( qryEntregasLin.FieldByName('kilos').AsFloat * rFinancieroCargados, 2) +
    kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat;

  kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat:=
    kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat -
        (
          kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat
        );


  kmtLiquidacion.Post;
  *)
end;

//***********************************************************************************************************************
//***********************************************************************************************************************

function TDLMargenCargaRFAlmacen.GetEnvaseProveedor( const AEmpresa, AProveedor, AProducto, AVariedad: string ): string;
begin
  with qryEnvase do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('proveedor').AsString:= AProveedor;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('variedad').AsString:= AVariedad;
    Open;
    result:= FieldByName('envase_e').AsString;
    Close;
  end;
end;

function TDLMargenCargaRFAlmacen.GetRelacionKilosTeoricos( const AEntrega, AEmpresa, AProveedor, AProducto, ACategoria: string; const AVariedad: integer;
                                                     var VRelacion, VKilosCaja: real ): Boolean;
var
  rKilosTeoricos, rKilosRf, rAuxlinea, rAuxRF: Real;
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
      if qryKilosTeoricosLinea.FieldBYName('cajas').AsFloat <> 0 then
        VKilosCaja:= bRoundTo( qryKilosTeoricosLinea.FieldBYName('kilos').AsFloat / qryKilosTeoricosLinea.FieldBYName('cajas').AsFloat, 2)
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
        rKilosTeoricos:= qryKilosTeoricosLinea.FieldBYName('kilos').AsFloat;
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


function TDLMargenCargaRFAlmacen.LoadParamsCargados( var ATransitos: boolean ): boolean;
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

procedure TDLMargenCargaRFAlmacen.LoadParamsDestrio;
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

procedure TDLMargenCargaRFAlmacen.LoadParamsVolcados;
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

procedure TDLMargenCargaRFAlmacen.CleanParams;
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

function TDLMargenCargaRFAlmacen.LoadParamsByStatus( var VMsg: string; var ATipoPalet: integer  ): boolean;
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
      if ( Copy( spCliente, 1, 1) = '0' ) then
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

function TDLMargenCargaRFAlmacen.ValorarLineaVerde: boolean;
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
    (*
    DLLiquidaIncidencias.AddVerdeSinSalida( qryEntregasLin.fieldBYName('empresa').AsString,
       qryEntregas.fieldBYName('codigo_ec').AsString, qryEntregasLin.fieldBYName('proveedor').AsString,
       qryEntregasLin.fieldBYName('almacen').AsString, qryEntregasLin.fieldBYName('producto').AsString,
       qryEntregasLin.fieldBYName('categoria').AsString, qryEntregasLin.fieldBYName('variedad').AsString,
       qryEntregasLin.fieldBYName('envase').AsString, qryEntregasLin.fieldBYName('palets').AsFloat,
       qryEntregasLin.fieldBYName('cajas').AsFloat, qryEntregasLin.fieldBYName('kilos').AsFloat );
    *)
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
    //ImportesFOBLiqCarga;
    result:= True;
  end;
end;

Function TDLMargenCargaRFAlmacen.FechaSalida: string;
begin
  if not qryPaletsPB.IsEmpty then
  begin
    if qryPaletsPB.FieldByName('status').AsString = 'V' then
    begin
      with qryFechaSalida do
      begin
        ParamByName('cliente').AsString:= qryPaletsPB.fieldByName('cliente').AsString;
        ParamByName('fecha').AsString:= FormatDateTime( 'yyyy-mm-dd h:mm:ss', qryPaletsPB.fieldByName('fecha_status').AsDateTime);
        Open;

        if FieldByName('fecha').AsDateTime > qryPaletsPB.fieldByName('fecha_status').AsDateTime then
        begin
          Result:= FormatDateTime( 'dd/mm/yyyy',FieldByName('fecha').AsDateTime);
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


procedure TDLMargenCargaRFAlmacen.AltaCabEntrega;
begin
  kmtEntregasCab.Insert;
  kmtEntregasCab.FieldByName('entrega').AsString:= qryEntregasLineasLocal.FieldByName('entrega').AsString;
  kmtEntregasCab.FieldByName('producto').AsString:= qryEntregasLineasLocal.FieldByName('producto').AsString;
  kmtEntregasCab.FieldByName('proveedor').AsString:= qryEntregasLineasLocal.FieldByName('proveedor').AsString;

  kmtEntregasCab.FieldByName('cajas').AsInteger:= iInCajas;
  kmtEntregasCab.FieldByName('unidades').AsInteger:= iInUnidades;
  kmtEntregasCab.FieldByName('kilos').AsFloat:= rInKilos;
  kmtEntregasCab.FieldByName('importe').AsFloat:= rInImporte;

  kmtEntregasCab.FieldByName('compra').AsFloat:= rInCompra;
  kmtEntregasCab.FieldByName('transporte').AsFloat:= rInTransporte;
  kmtEntregasCab.FieldByName('transito').AsFloat:= rInTransito;
  kmtEntregasCab.FieldByName('arancel').AsFloat:= rInArancel;
  kmtEntregasCab.FieldByName('estadistico').AsFloat:= rInEstadistico;

  kmtEntregasCab.FieldByName('importe_correcto').AsBoolean:= ( Abs( rInCompra - rInImporte ) < 1 );
  kmtEntregasCab.FieldByName('tiene_importe').AsBoolean:= bInImporte;
  kmtEntregasCab.FieldByName('tiene_compra').AsBoolean:= bInCompra;
  kmtEntregasCab.FieldByName('tiene_transporte').AsBoolean:= bInTransporte;
  kmtEntregasCab.FieldByName('tiene_transito').AsBoolean:= bInTransito;
  kmtEntregasCab.FieldByName('tiene_arancel').AsBoolean:= bInArancel;
  kmtEntregasCab.FieldByName('tiene_estadistico').AsBoolean:= bInEstadistico;

  kmtEntregasCab.FieldByName('kilos_transito').AsFloat:= rInKilos;
  kmtEntregasCab.FieldByName('importe_transito').AsFloat:= rInTransito;

  kmtEntregasCab.Post;
end;

procedure TDLMargenCargaRFAlmacen.AltaLinEntrega;
begin
  kmtEntregasLin.Insert;
  kmtEntregasLin.FieldByName('entrega').AsString:= qryEntregasLineasLocal.FieldByName('entrega').AsString;
  kmtEntregasLin.FieldByName('producto').AsString:= qryEntregasLineasLocal.FieldByName('producto').AsString;
  kmtEntregasLin.FieldByName('proveedor').AsString:= qryEntregasLineasLocal.FieldByName('proveedor').AsString;
  kmtEntregasLin.FieldByName('almacen').AsString:= qryEntregasLineasLocal.FieldByName('almacen').AsString;

  kmtEntregasLin.FieldByName('variedad').AsString:= qryEntregasLineasLocal.FieldByName('variedad').AsString;
  kmtEntregasLin.FieldByName('categoria').AsString:= qryEntregasLineasLocal.FieldByName('categoria').AsString;
  kmtEntregasLin.FieldByName('calibre').AsString:= qryEntregasLineasLocal.FieldByName('calibre').AsString;

  kmtEntregasLin.FieldByName('cajas').AsInteger:= qryEntregasLineasLocal.FieldByName('cajas').AsInteger;
  kmtEntregasLin.FieldByName('unidades').AsInteger:= qryEntregasLineasLocal.FieldByName('unidades').AsInteger;
  kmtEntregasLin.FieldByName('kilos').AsFloat:= qryEntregasLineasLocal.FieldByName('kilos').AsFloat;
  kmtEntregasLin.FieldByName('importe').AsFloat:= qryEntregasLineasLocal.FieldByName('importe').AsFloat;
  if ( rInKilos <> 0 ) then
  begin
    if bInCompra then
      kmtEntregasLin.FieldByName('compra').AsFloat:= bRoundTo( ( rInCompra / rInKilos ) * qryEntregasLineasLocal.FieldByName('kilos').AsFloat, 2)
    else
      kmtEntregasLin.FieldByName('compra').AsFloat:= 0;
    if bInTransporte then
      kmtEntregasLin.FieldByName('transporte').AsFloat:= bRoundTo( ( rInTransporte / rInKilos ) * qryEntregasLineasLocal.FieldByName('kilos').AsFloat, 2)
    else
      kmtEntregasLin.FieldByName('transporte').AsFloat:= 0;
    if bInTransito then
      kmtEntregasLin.FieldByName('transito').AsFloat:= bRoundTo( ( rInTransito / rInKilos ) * qryEntregasLineasLocal.FieldByName('kilos').AsFloat, 2)
    else
      kmtEntregasLin.FieldByName('transito').AsFloat:= 0;
    if bInArancel then
      kmtEntregasLin.FieldByName('arancel').AsFloat:= bRoundTo( ( rInArancel / rInKilos ) * qryEntregasLineasLocal.FieldByName('kilos').AsFloat, 2)
    else
      kmtEntregasLin.FieldByName('arancel').AsFloat:= 0;
    if bInEstadistico then
      kmtEntregasLin.FieldByName('estadistico').AsFloat:= bRoundTo( ( rInEstadistico / rInKilos ) * qryEntregasLineasLocal.FieldByName('kilos').AsFloat, 2)
    else
      kmtEntregasLin.FieldByName('estadistico').AsFloat:= 0;
  end
  else
  begin
    kmtEntregasLin.FieldByName('compra').AsFloat:= 0;
    kmtEntregasLin.FieldByName('transporte').AsFloat:= 0;
    kmtEntregasLin.FieldByName('transito').AsFloat:= 0;
    kmtEntregasLin.FieldByName('arancel').AsFloat:= 0;
    kmtEntregasLin.FieldByName('estadistico').AsFloat:= 0;
  end;

  kmtEntregasLin.Post;
end;

procedure TDLMargenCargaRFAlmacen.DatosEntrega;
begin
  bInCompra:= False;
  bInTransporte:= False;
  bInArancel:= False;
  bInTransito:= False;
  bInEstadistico:= False;

  rInCompra:= 0;
  rInTransporte:= 0;
  rInArancel:= 0;
  rInTransito:= 0;
  rInEstadistico:= 0;

  qryEntregasFacturasLocal.Open;
  while not qryEntregasFacturasLocal.Eof do
  begin
    //Recorrer linaes y añadir importe segun distribicion
    //agrupacion_tg tipo, unidad_dist_tg unidad,  sum(importe_ge) importe
    if qryEntregasFacturasLocal.FieldByName('tipo').AsString = 'COMPRA' then
    begin
      rInCompra:= rInCompra + qryEntregasFacturasLocal.FieldByName('importe').AsFloat;
      bInCompra:= True;
    end;
    if qryEntregasFacturasLocal.FieldByName('tipo').AsString = 'TRANSPORTE' then
    begin
      rInTransporte:= rInTransporte + qryEntregasFacturasLocal.FieldByName('importe').AsFloat;
      bInTransporte:= True;
    end;
    if qryEntregasFacturasLocal.FieldByName('tipo').AsString = 'ARANCEL' then
    begin
      rInArancel:= rInArancel + qryEntregasFacturasLocal.FieldByName('importe').AsFloat;
      bInArancel:= True;
    end;
    if qryEntregasFacturasLocal.FieldByName('tipo').AsString = 'TRANSITO' then
    begin
      rInTransito:= rInTransito + qryEntregasFacturasLocal.FieldByName('importe').AsFloat;
      bInTransito:= True;
    end;
    if qryEntregasFacturasLocal.FieldByName('tipo').AsString = 'ESTADISTIC' then
    begin
      rInEstadistico:= rInEstadistico + qryEntregasFacturasLocal.FieldByName('importe').AsFloat;
      bInEstadistico:= True;
    end;
    qryEntregasFacturasLocal.Next;
  end;
  qryEntregasFacturasLocal.Close;

  rInKilos:= 0;
  iInCajas:= 0;
  iInUnidades:= 0;
  rInImporte:= 0;

  qryEntregasLineasLocal.Open;
  //TOTALES
  while not qryEntregasLineasLocal.Eof do
  begin
    rInKilos:= rInKilos + qryEntregasLineasLocal.FieldByName('kilos').AsFloat;
    iInCajas:= iInCajas + qryEntregasLineasLocal.FieldByName('cajas').AsInteger;
    iInUnidades:= iInUnidades + qryEntregasLineasLocal.FieldByName('unidades').AsInteger;
    rInImporte:= rInImporte + qryEntregasLineasLocal.FieldByName('importe').AsFloat;
    //Añadir linea
    qryEntregasLineasLocal.Next;
  end;
  bInImporte:= ( rInImporte <> 0 );
  AltaCabEntrega;

  //DETALLE
  qryEntregasLineasLocal.First;
  while not qryEntregasLineasLocal.Eof do
  begin
    //Añadir linea
    AltaLinEntrega;
    qryEntregasLineasLocal.Next;
  end;
  qryEntregasLineasLocal.Close;

  kmtEntregasCab.Locate('entrega',qryEntregasRF.FieldByname('entrega').AsString,[]);
  rKilosTotalRF:= GetKilosTotalRF;
  if rKilosTotalRF = 0 then
    rKilosTotalRF:= rInKilos;
end;

function TDLMargenCargaRFAlmacen.GetKilosTotalRF: Real;
var
  sOrigen: string;        //Base de datos remota
begin
  sOrigen:= Copy(qryEntregasRF.FieldByName('entrega').AsString,1,3);
  if sPlanta = sOrigen then
  begin
    qryTotalesRF.DatabaseName:= qryEntregasRF.DatabaseName;
    qryTotalesRF.ParamByName('entrega').AsString:= qryEntregasRF.FieldByName('entrega').AsString;
    qryTotalesRF.Open;
    Result:= qryTotalesRF.FieldByname('peso').AsFloat;
    qryTotalesRF.Close;
  end
  else
  begin
    if sOrigen = 'F17' then
    begin
      if not DMBaseDatos.dbF17.Connected then
        DMBaseDatos.dbF17.Connected:= True;
      qryTotalesRF.DatabaseName:= 'dbF17';
    end
    else
    if sOrigen = 'F18' then
    begin
      if not DMBaseDatos.dbF18.Connected then
        DMBaseDatos.dbF18.Connected:= True;
      qryTotalesRF.DatabaseName:= 'dbF18';
    end
    else
    (*
    if sOrigen = 'F21' then
    begin
      if not DMBaseDatos.dbF21.Connected then
        DMBaseDatos.dbF21.Connected:= True;
      qryTotalesRF.DatabaseName:= 'dbF21';
    end
    else
    *)
    if sOrigen = 'F23' then
    begin
      if not DMBaseDatos.dbF23.Connected then
        DMBaseDatos.dbF23.Connected:= True;
      qryTotalesRF.DatabaseName:= 'dbF23';
    end;

    qryTotalesRF.ParamByName('entrega').AsString:= qryEntregasRF.FieldByName('entrega').AsString;
    qryTotalesRF.Open;
    Result:= qryTotalesRF.FieldByname('peso').AsFloat;
    qryTotalesRF.Close;

    if sOrigen = 'F17' then
    begin
      DMBaseDatos.dbF17.Connected:= False;
    end
    else
    if sOrigen = 'F18' then
    begin
      DMBaseDatos.dbF18.Connected:= False;
    end
    else
    (*
    if sOrigen = 'F21' then
    begin
      DMBaseDatos.dbF21.Connected:= False;
    end
    else
    *)
    if sOrigen = 'F23' then
    begin
      DMBaseDatos.dbF23.Connected:= False;
    end;
  end;
end;

procedure TDLMargenCargaRFAlmacen.DatosLiquidaVerde;
begin
  ValorarVerde;

  (*
  kmtLiquidacion.Filter:= 'liq_empresa=' + QuotedStr( AEmpresa );
  kmtLiquidacion.Filtered:= True;
  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_categoria;liq_status';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenCategorias;
  kmtLiquidacion.Filtered:= False;
  *)

(*
  kmtLiquidacion.SortFields:='liq_anyo_semana;liq_categoria;liq_status';
  kmtLiquidacion.Sort([]);
  kmtLiquidacion.First;
  MakeResumenCategorias;
*)
end;

procedure TDLMargenCargaRFAlmacen.DatosMargenRF;
begin
  CargarPalets;

  kmtPalet.SortFields:='empresa;proveedor;almacen;entrega;status;producto;variedad;categoria;calibre';
  kmtPalet.Sort([]);
  kmtPalet.First;
  MakeLineas;
end;

procedure TDLMargenCargaRFAlmacen.CargarPalets;
begin
  //InicializaVariables;

  //if kmtTransitos.Active then
  //  kmtTransitos.Close;
  //kmtTransitos.Open;

  //kmtPalet.Filter:= '';
  //kmtPalet.Filtered:= True;
  //kmtKilosTeoricos.Close;
  //kmtKilosTeoricos.Open;

  qryEntregasRF.First;
  while not qryEntregasRF.Eof do
  begin
    DatosEntrega;
    qryPaletsPB.First;
    while not qryPaletsPB.Eof do
    begin
      //VALORAR PALETS
      CargaPalet;
      qryPaletsPB.Next;
    end;
    CalcularImportesPalets;
    qryEntregasRF.Next;
  end;


  //kmtPalet.Filtered:= False;
  //kmtPalet.Filter:= '';
  //ValorarTransitos;
  //kmtTransitos.Close;
end;

function TDLMargenCargaRFAlmacen.PutDataEntrega( var VCajas, VUnidades, VKilos, VCompra, VTransporte, VTransito, VArancel, VEstadistico: Real;
                                                     var VTieneImporte, VImporteLinea, VImporteCorrecto: boolean ): Boolean;
var
  sAux1, sAux2: string;
begin
  VCajas:= 0;
  VUnidades:= 0;
  VKilos:= 0;
  VCompra:= 0;
  VTransporte:= 0;
  VTransito:= 0;
  VArancel:= 0;
  VEstadistico:= 0;
  Result:= False;

  VTieneImporte:= kmtEntregasCab.FieldByName('tiene_importe').AsBoolean or kmtEntregasCab.FieldByName('tiene_compra').AsBoolean;
  VImporteCorrecto:= kmtEntregasCab.FieldByName('importe_correcto').AsBoolean;

  kmtEntregasLin.First;
  while ( not kmtEntregasLin.Eof ) and ( not Result ) do
  begin
    sAux1:= '';
    sAux2:= '';
    if bVariedad then
    begin
      sAux1:= sAux1 + kmtPalet.FieldByName('variedad').AsString;
      sAux2:= sAux2 + kmtEntregasLin.fieldByName('variedad').AsString;
    end;
    if bCategoria then
    begin
      sAux1:= sAux1 + kmtPalet.FieldByName('categoria').AsString;
      sAux2:= sAux2 + kmtEntregasLin.fieldByName('categoria').AsString;
    end;
    if bCalibre then
    begin
      sAux1:= sAux1 + kmtPalet.FieldByName('calibre').AsString;
      sAux2:= sAux2 + kmtEntregasLin.fieldByName('calibre').AsString;
    end;

    if ( kmtPalet.FieldByName('entrega').AsString = kmtEntregasLin.fieldByName('entrega').AsString ) and
       ( kmtPalet.FieldByName('proveedor').AsString = kmtEntregasLin.fieldByName('proveedor').AsString ) and
       ( kmtPalet.FieldByName('almacen').AsString = kmtEntregasLin.fieldByName('almacen').AsString ) and
       ( kmtPalet.FieldByName('producto').AsString = kmtEntregasLin.fieldByName('producto').AsString ) and
       ( sAux1 = sAux2 ) then
    begin
      Result:= True;
      if kmtEntregasLin.fieldByName('kilos').AsFloat <> 0 then
      begin
        if ( kmtEntregasCab.FieldByName('importe_correcto').AsBoolean and
             kmtEntregasCab.FieldByName('tiene_importe').AsBoolean ) then
        begin
          VCompra:= bRoundTo( kmtEntregasLin.fieldByName('importe').AsFloat / kmtEntregasLin.fieldByName('kilos').AsFloat, 5);
          VImporteLinea:= True;
        end
        else
        begin
          VCompra:= bRoundTo( kmtEntregasLin.fieldByName('compra').AsFloat / kmtEntregasLin.fieldByName('kilos').AsFloat, 5);
          VImporteLinea:= False;
        end;
        VTransporte:= bRoundTo( kmtEntregasLin.fieldByName('transporte').AsFloat / kmtEntregasLin.fieldByName('kilos').AsFloat, 5);
        VTransito:= bRoundTo( kmtEntregasLin.fieldByName('transito').AsFloat / kmtEntregasLin.fieldByName('kilos').AsFloat, 5);
        VArancel:= bRoundTo( kmtEntregasLin.fieldByName('arancel').AsFloat / kmtEntregasLin.fieldByName('kilos').AsFloat, 5);
        VEstadistico:= bRoundTo( kmtEntregasLin.fieldByName('estadistico').AsFloat / kmtEntregasLin.fieldByName('kilos').AsFloat, 5);

        VKilos:= kmtEntregasLin.fieldByName('kilos').AsFloat;
        VCajas:= kmtEntregasLin.fieldByName('cajas').AsFloat;
        VUnidades:= kmtEntregasLin.fieldByName('unidades').AsFloat;
      end;
    end;
    kmtEntregasLin.Next;
  end;
end;

function TDLMargenCargaRFAlmacen.CargaPalet: boolean;
var
  rCajas, rUnidades, rKilos, rCompra, rTransporte, rTransito, rArancel, rEstadistico, rAux: Real;
  bTieneImporte, bImporteLinea, bImporteCorrecto: Boolean;
begin
  Result:= True;
  
  //Evitar placeros B, clientes que empiezan por 0
  //que pasa con el destrio
  kmtPalet.Insert;
  kmtPalet.FieldByName('empresa').AsString:= qryPaletsPB.fieldByName('empresa').AsString;
  kmtPalet.FieldByName('centro').AsString:= qryPaletsPB.fieldByName('centro').AsString;
  kmtPalet.FieldByName('entrega').AsString:= qryPaletsPB.fieldByName('entrega').AsString;
  kmtPalet.FieldByName('proveedor').AsString:= qryPaletsPB.fieldByName('proveedor').AsString;
  kmtPalet.FieldByName('almacen').AsString:= qryPaletsPB.fieldByName('proveedor_almacen').AsString;

  kmtPalet.FieldByName('producto').AsString:= qryPaletsPB.fieldByName('producto').AsString;
  kmtPalet.FieldByName('variedad').AsInteger:= qryPaletsPB.fieldByName('variedad').AsInteger;
  kmtPalet.FieldByName('categoria').AsString:= qryPaletsPB.fieldByName('categoria').AsString;
  kmtPalet.FieldByName('calibre').AsString:= qryPaletsPB.fieldByName('calibre').AsString;

  kmtPalet.FieldByName('status').AsString:= qryPaletsPB.fieldByName('status').AsString;
  kmtPalet.FieldByName('calidad').AsString:= qryPaletsPB.fieldByName('calidad').AsString;
  kmtPalet.FieldByName('fecha_alta').AsDateTime:= qryPaletsPB.fieldByName('fecha_alta').AsDateTime;
  kmtPalet.FieldByName('fecha_status').AsDateTime:= qryPaletsPB.fieldByName('fecha_status').AsDateTime;

  kmtPalet.FieldByName('cajas').AsInteger:= qryPaletsPB.fieldByName('cajas').AsInteger;
  kmtPalet.FieldByName('unidades').AsInteger:= qryPaletsPB.fieldByName('cajas').AsInteger;
  kmtPalet.FieldByName('kilos_rf').AsFloat:= qryPaletsPB.fieldByName('peso').AsFloat;

  kmtPalet.FieldByName('sscc_final').AsString:= qryPaletsPB.fieldByName('sscc').AsString;
  kmtPalet.FieldByName('sscc_origen').AsString:= qryPaletsPB.fieldByName('paletorigen').AsString;

  if rKilosTotalRF <> 0 then
  begin
    if PutDataEntrega( rCajas, rUnidades, rKilos, rCompra, rTransporte, rTransito, rArancel, rEstadistico,
                       bTieneImporte, bImporteLinea, bImporteCorrecto ) then
    begin

      //Peso teorico
      if kmtPalet.FieldByName('kilos_rf').AsFloat <> 0 then
      begin
        rAux:= bRoundTo( ( rInKilos / rKilosTotalRF ) * kmtPalet.FieldByName('kilos_rf').AsFloat, 2 )
      end
      else
      begin
        //Si noy kilos RF, no hay teoricos, aunque tenga cajas
        //if rCajas <> 0 then
        //  rAux:= bRoundTo( ( qryPaletsPB.fieldByName('cajas').AsInteger  * rKilos ) / rCajas, 2)
        //else
          rAux:= 0;
      end;

      kmtPalet.FieldByName('kilos_teoricos').AsFloat:= rAux;
      kmtPalet.FieldByName('compra').AsFloat:= bRoundTo( rCompra * rAux, 2);
      kmtPalet.FieldByName('transporte').AsFloat:= bRoundTo( rTransporte * rAux, 2);
      kmtPalet.FieldByName('transito').AsFloat:= bRoundTo( rTransito * rAux, 2);
      kmtPalet.FieldByName('arancel').AsFloat:= bRoundTo( rArancel * rAux, 2);
      kmtPalet.FieldByName('estadistico').AsFloat:= bRoundTo( rEstadistico * rAux, 2);
      kmtPalet.FieldByName('tieneimporte').AsBoolean:= bTieneImporte;
      kmtPalet.FieldByName('importelinea').AsBoolean:= bImporteLinea;
      kmtPalet.FieldByName('importecorrecto').AsBoolean:= bImporteCorrecto;
    end
    else
    begin
      kmtPalet.FieldByName('kilos_teoricos').AsFloat:= 0;
      kmtPalet.FieldByName('compra').AsFloat:= 0;
      kmtPalet.FieldByName('transporte').AsFloat:= 0;
      kmtPalet.FieldByName('transito').AsFloat:= 0;
      kmtPalet.FieldByName('arancel').AsFloat:= 0;
      kmtPalet.FieldByName('estadistico').AsFloat:= 0;
      kmtPalet.FieldByName('tieneimporte').AsBoolean:= False;
      kmtPalet.FieldByName('importelinea').AsBoolean:= False;
      kmtPalet.FieldByName('importecorrecto').AsBoolean:= False;
    end;
  end
  else
  begin
      kmtPalet.FieldByName('kilos_teoricos').AsFloat:= 0;
      kmtPalet.FieldByName('compra').AsFloat:= 0;
      kmtPalet.FieldByName('transporte').AsFloat:= 0;
      kmtPalet.FieldByName('transito').AsFloat:= 0;
      kmtPalet.FieldByName('arancel').AsFloat:= 0;
      kmtPalet.FieldByName('estadistico').AsFloat:= 0;
      kmtPalet.FieldByName('tieneimporte').AsBoolean:= False;
      kmtPalet.FieldByName('importelinea').AsBoolean:= False;
      kmtPalet.FieldByName('importecorrecto').AsBoolean:= False;
  end;

  if not VarIsNull( qryPaletsPB.fieldByName('orden_occ').Value ) then
  begin
    kmtPalet.FieldByName('orden').AsInteger:= qryPaletsPB.fieldByName('orden_occ').AsInteger;
    kmtPalet.FieldByName('empresa_sal').AsString:= qryPaletsPB.fieldByName('empresa_occ').AsString;
    kmtPalet.FieldByName('centro_sal').AsString:= qryPaletsPB.fieldByName('centro_salida_occ').AsString;
    kmtPalet.FieldByName('albaran_sal').AsInteger:= qryPaletsPB.fieldByName('n_albaran_occ').AsInteger;
    kmtPalet.FieldByName('fecha_sal').AsDateTime:= qryPaletsPB.fieldByName('fecha_occ').AsDateTime;
    kmtPalet.FieldByName('cliente_sal').AsString:= qryPaletsPB.fieldByName('cliente_sal_occ').AsString;
    kmtPalet.FieldByName('centro_des').AsString:= qryPaletsPB.fieldByName('centro_destino_occ').AsString;
  end;

  if ( qryPaletsPB.fieldByName('empresa').AsString <> Copy( qryPaletsPB.fieldByName('entrega').AsString, 1, 3 ) ) then
  begin
    kmtPalet.FieldByName('es_transito').AsInteger:= 2; //Viene de un transito desde otro centro
  end
  else
  if not VarIsNull( qryPaletsPB.fieldByName('orden_occ').Value ) then
  begin
    if qryPaletsPB.fieldByName('traspasada_occ').AsInteger = 2 then
    begin
      kmtPalet.FieldByName('es_transito').AsInteger:= 1; //Palet enviado en transito a otro centro
      kmtPalet.FieldByName('status').AsString:= 'T';
    end
    else
    if qryPaletsPB.fieldByName('traspasada_occ').AsInteger = 1 then
    begin
      kmtPalet.FieldByName('es_transito').AsInteger:= 0; //Carga normal
    end
    else
    begin
      if qryPaletsPB.fieldByName('cliente_des').AsString <> '' then
      begin
        kmtPalet.FieldByName('es_transito').AsInteger:= 1; //Palet enviado en transito a otro centro
        kmtPalet.FieldByName('status').AsString:= 'T';
      end
      else
      begin
         kmtPalet.FieldByName('es_transito').AsInteger:= 0; //Carga normal
      end;
    end;
  end
  else
  begin
    kmtPalet.FieldByName('es_transito').AsInteger:= 0; //Carga normal
  end;



  kmtPalet.Post;
end;

procedure TDLMargenCargaRFAlmacen.CalcularImportesPalets;
begin
  kmtPalet.First;
  while not kmtPalet.Eof do
  begin
    kmtPalet.Edit;

    kmtPalet.Post;
    kmtPalet.Next;
  end;
end;

procedure TDLMargenCargaRFAlmacen.MakeLineas;
begin
  while not kmtPalet.Eof do
  begin
    if ExistLinea then
      EditLinea
    else
      NewLinea;
    kmtPalet.Next;
  end;
  CalculoLinea;
end;

function  TDLMargenCargaRFAlmacen.ExistLinea: boolean;
begin
  result:= kmtLineas.Locate( 'empresa;centro;proveedor;almacen;entrega;status;fecha_status;calidad;producto;variedad;categoria;calibre;cliente;orden;albaran;fecha_sal;envase',
       VarArrayOf([kmtPalet.fieldByName('empresa').AsString,
                   kmtPalet.fieldByName('centro').AsString,
                   kmtPalet.fieldByName('proveedor').AsString,
                   kmtPalet.fieldByName('almacen').AsString,
                   kmtPalet.fieldByName('entrega').AsString,
                   kmtPalet.fieldByName('status').AsString,
                   kmtPalet.fieldByName('fecha_status').AsString,
                   kmtPalet.fieldByName('calidad').AsString,
                   kmtPalet.fieldByName('producto').AsString,
                   kmtPalet.fieldByName('variedad').AsString,
                   kmtPalet.fieldByName('categoria').AsString,
                   kmtPalet.fieldByName('calibre').AsString,
                   kmtPalet.fieldByName('cliente_sal').Value,
                   kmtPalet.fieldByName('orden').Value,
                   kmtPalet.fieldByName('albaran_sal').Value,
                   kmtPalet.fieldByName('fecha_sal').Value,
                   ''

                   ]),[]);
end;

procedure TDLMargenCargaRFAlmacen.NewLinea;

begin
  kmtLineas.Insert;
  kmtLineas.fieldByName('empresa').AsString:= kmtPalet.fieldByName('empresa').AsString;
  kmtLineas.fieldByName('centro').AsString:= kmtPalet.fieldByName('centro').AsString;
  kmtLineas.fieldByName('proveedor').AsString:= kmtPalet.fieldByName('proveedor').AsString;
  //Asinteger falla en tenerife
  //valorar transitos
  kmtLineas.fieldByName('almacen').AsString:= kmtPalet.fieldByName('almacen').AsString;
  kmtLineas.fieldByName('entrega').AsString:= kmtPalet.fieldByName('entrega').AsString;
  kmtLineas.fieldByName('status').AsString:= kmtPalet.fieldByName('status').AsString;
  kmtLineas.fieldByName('fecha_status').AsString:= kmtPalet.fieldByName('fecha_status').AsString;
  kmtLineas.fieldByName('calidad').AsString:= kmtPalet.fieldByName('calidad').AsString;
  kmtLineas.fieldByName('producto').AsString:= kmtPalet.fieldByName('producto').AsString;
  kmtLineas.fieldByName('variedad').AsInteger:= kmtPalet.fieldByName('variedad').AsInteger;
  kmtLineas.fieldByName('categoria').AsString:= kmtPalet.fieldByName('categoria').AsString;
  kmtLineas.fieldByName('calibre').AsString:= kmtPalet.fieldByName('calibre').AsString;
  kmtLineas.fieldByName('cliente').AsString:= kmtPalet.fieldByName('cliente_sal').AsString;
  kmtLineas.fieldByName('orden').AsInteger:= kmtPalet.fieldByName('orden').AsInteger;
  kmtLineas.fieldByName('albaran').AsInteger:= kmtPalet.fieldByName('albaran_sal').AsInteger;
  kmtLineas.fieldByName('fecha_sal').AsString:= kmtPalet.fieldByName('fecha_sal').AsString;
  kmtLineas.fieldByName('envase').AsString:= '';//kmtPalet.fieldByName('envase').AsString;


  kmtLineas.fieldByName('cajas').AsInteger:= kmtPalet.fieldByName('cajas').AsInteger;
  kmtLineas.fieldByName('unidades').AsInteger:= kmtPalet.fieldByName('unidades').AsInteger;
  kmtLineas.fieldByName('kilos_rf').Asfloat:= kmtPalet.fieldByName('kilos_rf').Asfloat;
  kmtLineas.fieldByName('kilos_teoricos').Asfloat:= kmtPalet.fieldByName('kilos_teoricos').Asfloat;

  kmtLineas.Post;

end;

procedure TDLMargenCargaRFAlmacen.EditLinea;
begin
  kmtLineas.Edit;

  kmtLineas.fieldByName('cajas').AsInteger:= kmtLineas.fieldByName('cajas').AsInteger + kmtPalet.fieldByName('cajas').AsInteger;
  kmtLineas.fieldByName('unidades').AsInteger:= kmtLineas.fieldByName('unidades').AsInteger + kmtPalet.fieldByName('unidades').AsInteger;
  kmtLineas.fieldByName('kilos_rf').Asfloat:= kmtLineas.fieldByName('kilos_rf').Asfloat + kmtPalet.fieldByName('kilos_rf').Asfloat;
  kmtLineas.fieldByName('kilos_teoricos').Asfloat:= kmtLineas.fieldByName('kilos_teoricos').Asfloat + kmtPalet.fieldByName('kilos_teoricos').Asfloat;

  kmtLineas.Post;
end;

procedure TDLMargenCargaRFAlmacen.CalculoLinea;
//var
  //rKilos, rKilosLiq: Real;
begin
  (*
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
      kmtLiquidacion.FieldByName('liq_precio_financiero').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat / rKilos;

      kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_neto').AsFloat -
        (
          kmtLiquidacion.FieldByName('liq_importe_descuento').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_gastos').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_envasado').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_compra').AsFloat +
          kmtLiquidacion.FieldByName('liq_importe_financiero').AsFloat
        );
      kmtLiquidacion.FieldByName('liq_precio_liquidar').AsFloat:= kmtLiquidacion.FieldByName('liq_importe_liquidar').AsFloat / rKilos;

      kmtLiquidacion.Post;
    end;
    kmtLiquidacion.Next;
  end;
  *)
end;

procedure TDLMargenCargaRFAlmacen.PreviewPalets;
begin
  MargenCargaRFAlmacenPaletsQL.PrevisualizarPalets( sEmpresaIni );
end;

end.
