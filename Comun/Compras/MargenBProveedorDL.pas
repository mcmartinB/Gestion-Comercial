unit MargenBProveedorDL;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables, MargenBCodeComunDL;

type
  TTipoProveedor = (tvVolcados, tvCargados, tvVentas, tvTransitos, tvStock, tvAll );
  TTipoCarga = (tcVenta, tcTransito, tcVolcado, tcError );

type
  TDLMargenBProveedor = class(TDataModule)
    qryEnvaseVariedad: TQuery;
    kmtEnvasesVariedad: TkbmMemTable;
    qryDatosRF: TQuery;
    qryEntrega: TQuery;
    qryImporteEntrega: TQuery;
    kmtEntregas: TkbmMemTable;
    qryPaletsProveedor: TQuery;
    kmtLineasProveedor: TkbmMemTable;
    dsProveedor: TDataSource;
    kmtPaletsProveedor: TkbmMemTable;
    qrySalidas: TQuery;
    qryTransitos: TQuery;
    kmtOrdenCarga: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sgEmpresa, sgCliente, sgProducto: string;
    dgFechaIni, dgFechaFin: TDateTime;
    tpgTtipo: TTipoProveedor;
    CostesAplicar: RCostesAplicar;

    procedure LoadParametros( const AEmpresa, AProducto, ACliente: string ;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ACostesAplicar: RCostesAplicar;
                              const ATipo: TTipoProveedor );

    procedure CrearTablas;
    function  QuerysProveedor: Boolean;
    procedure PaletsProveedorCargados;
    procedure PaletsProveedorVolcados;

    procedure CerrarQuerys;
    procedure MakeMasterDetailProveedor;

    procedure AddLineaProveedor;
    procedure DatosEnvaseVolcados( const AEmpresa, AProveedor, AProducto, ACalibre: string; const AVariedad: Integer;
                                                   var VUnidades: integer );
    procedure DatosEnvaseCargados( const AEmpresa, AProveedor, AProducto, ACalibre: string; const AVariedad: Integer;
                                                   var VUnidades: integer );
    procedure DatosOrdenCarga( const AEmpresa, ACentro: string; const AOrden: Integer; var VCliente: string; var VAlbaran: Integer; var  VTipo: TTipoCarga );
    function  EsOrdenCargaVenta( const AEmpresa, ACentro: string; const AOrden: Integer; var VCliente: string;  var VAlbaran: integer ): boolean;
    function  EsOrdenCargaTransito( const AEmpresa, ACentro: string; const AOrden: Integer; var VCliente: string;  var VAlbaran: integer ): boolean;
    procedure DatosEntrega( const AEntrega: string; var VCajasRF: Integer; var VKilosRF: Real;
                            var VCajasEntrega: integer; var VKilosEntrega, VImporteEntrega: real );

  public
    { Public declarations }
    procedure PaletsProveedor( const AEmpresa, AProducto, ACliente: string ;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ACostesAplicar: RCostesAplicar;
                              const ATipo: TTipoProveedor );

  end;

  procedure ViewPaletsProveedor( const AEmpresa, AProducto, ACliente: string ;
                                const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar;
                                const ATipo: TTipoProveedor );

  procedure IniciarPaletsProveedor;
  procedure ProcesoProveedor( const AEmpresa, AProducto, ACliente: string ;
                          const AFechaIni, AFechaFin: TDateTime;
                          const ACostesAplicar: RCostesAplicar;
                          const ATipo: TTipoProveedor );
  procedure CerrarPaletsProveedor;

var
  DLMargenBProveedor: TDLMargenBProveedor;

implementation

{$R *.dfm}

uses
  MargenBVolcadosQL, MargenBCargadosQL, Forms, Variants, bMath, UDMConfig;

var
  bModuloIni: boolean = false;

procedure IniciarPaletsProveedor;
begin
  if not bModuloIni then
  begin
    Application.CreateForm( TDLMargenBProveedor, DLMargenBProveedor );
    bModuloIni:= True;
  end;
end;


procedure ProcesoProveedor( const AEmpresa, AProducto, ACliente: string ;
                          const AFechaIni, AFechaFin: TDateTime;
                          const ACostesAplicar: RCostesAplicar;
                          const ATipo: TTipoProveedor );
begin
  DLMargenBProveedor.qryImporteEntrega.Close;
  DLMargenBProveedor.qryEntrega.Close;
  DLMargenBProveedor.qryDatosRF.Close;
  DLMargenBProveedor.qryEnvaseVariedad.Close;
  DLMargenBProveedor.qryPaletsProveedor.Close;

  DLMargenBProveedor.kmtLineasProveedor.Close;
  DLMargenBProveedor.kmtLineasProveedor.Open;
  DLMargenBProveedor.kmtPaletsProveedor.Close;
  DLMargenBProveedor.kmtPaletsProveedor.Open;
  DLMargenBProveedor.kmtEnvasesVariedad.Close;
  DLMargenBProveedor.kmtEnvasesVariedad.Open;
  DLMargenBProveedor.kmtEntregas.Close;
  DLMargenBProveedor.kmtEntregas.Open;

  DLMargenBProveedor.PaletsProveedor( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, ATipo );
end;

procedure CerrarPaletsProveedor;
begin
  bModuloIni:= False;
  DLMargenBProveedor.CerrarQuerys;
  FreeAndNil( DLMargenBProveedor );
end;


procedure ViewPaletsProveedor( const AEmpresa, AProducto, ACliente: string ;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ACostesAplicar: RCostesAplicar;
                              const ATipo: TTipoProveedor );
begin
  Application.CreateForm( TDLMargenBProveedor, DLMargenBProveedor );
  try
    DLMargenBProveedor.PaletsProveedor( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, ATipo );
    DLMargenBProveedor.MakeMasterDetailProveedor;
    if ( ATipo = tvCargados ) or ( ATipo = tvVentas ) or ( ATipo = tvTransitos ) then
      MargenBCargadosQL.VerMargenBCargados( AEmpresa, AProducto, AFechaIni, AFechaFin  )
    else
      MargenBVolcadosQL.VerMargenBVolcados( AEmpresa, AProducto, AFechaIni, AFechaFin  );
    DLMargenBProveedor.CerrarQuerys;
  finally
    FreeAndNil( DLMargenBProveedor );
  end;
end;

procedure TDLMargenBProveedor.DataModuleCreate(Sender: TObject);
begin
  //es la font
  if UDMConfig.DMConfig.iInstalacion = 10 then
  begin
    qryPaletsProveedor.DatabaseName:= 'DBRF';
    qryDatosRF.DatabaseName:= 'DBRF';
  end
  else
  begin
    qryPaletsProveedor.DatabaseName:= 'BDProyecto';
    qryDatosRF.DatabaseName:= 'BDProyecto';
  end;
  CrearTablas;
end;

procedure TDLMargenBProveedor.MakeMasterDetailProveedor;
begin
  kmtLineasProveedor.First;
  kmtPaletsProveedor.First;
  kmtPaletsProveedor.MasterSource:= dsProveedor;
  kmtPaletsProveedor.MasterFields:= 'periodo;producto';
  kmtPaletsProveedor.IndexFieldNames:= 'periodo;producto';
end;

function TDLMargenBProveedor.QuerysProveedor: Boolean;
begin
  with qryPaletsProveedor do
  begin
    SQL.Clear;
    SQL.Add(' select producto, fecha_status, date(fecha_status) fecha, empresa, centro, entrega, cliente, ');
    SQL.Add('        sscc, proveedor, variedad, categoria, calibre, cajas, peso, peso_bruto, status, orden_carga ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where empresa = :empresa ');

    if tpgTtipo = tvVolcados then
    begin
      SQL.Add(' and ( status = ''V'' or status = ''R'' or status = ''D'' ) '); //Volcado-Regularizado-Destrio
      SQL.Add(' and date(fecha_status) between :fechaini and :fechafin ');
    end
    else
    if ( tpgTtipo = tvCargados ) or ( tpgTtipo = tvVentas ) or ( tpgTtipo = tvTransitos ) then
    begin
      SQL.Add(' and status = ''C''  '); //Cargados
      SQL.Add(' and date(fecha_status) between :fechaini and :fechafin ');
    end
    else
    if tpgTtipo = tvStock then
    begin
      SQL.Add(' and ( ( status = ''S'' and date(fecha_alta) <= :fecha ) or ');
      SQL.Add('       ( status <> ''S'' and date(fecha_alta) <= :fecha and date(fecha_status) > :fecha ) ) ');
      SQL.Add(' and status <> ''B'' ');
    end
    else
    if tpgTtipo = tvAll then
    begin
      SQL.Add(' and date(fecha_status) between :fechaini and :fechafin ');
      SQL.Add(' and status <> ''B'' ');
    end;

    if sgProducto <> '' then
    begin
      SQL.Add(' and producto = :producto ');
    end;
    if sgCliente <> '' then
    begin
      SQL.Add(' and cliente = :cliente ');
    end;

    SQL.Add(' order by empresa, proveedor, producto, variedad, entrega ');
  end;

  qryPaletsProveedor.ParamByName('empresa').AsString:= sgEmpresa;
  if tpgTtipo = tvStock then
  begin
    qryPaletsProveedor.ParamByName('fecha').AsDateTime:= dgFechaIni;
  end
  else
  begin
    qryPaletsProveedor.ParamByName('fechaini').AsDateTime:= dgFechaIni;
    qryPaletsProveedor.ParamByName('fechaFin').AsDateTime:= dgFechaFin;
  end;
  if sgProducto <> '' then
  begin
    qryPaletsProveedor.ParamByName('producto').AsString:= sgProducto;
  end;
  if sgCliente <> '' then
  begin
    qryPaletsProveedor.ParamByName('cliente').AsString:= sgCliente;
  end;
  qryPaletsProveedor.Open;
  Result:= not qryPaletsProveedor.IsEmpty;
end;

procedure TDLMargenBProveedor.CrearTablas;
begin
  kmtLineasProveedor.FieldDefs.Clear;
  kmtLineasProveedor.FieldDefs.Add('empresa', ftString, 3, False);
  kmtLineasProveedor.FieldDefs.Add('periodo', ftString, 15, False);
  kmtLineasProveedor.FieldDefs.Add('producto', ftString, 3, False);
  kmtLineasProveedor.FieldDefs.Add('cliente', ftString, 3, False);

  kmtLineasProveedor.FieldDefs.Add('cajas', ftInteger, 0, False);
  kmtLineasProveedor.FieldDefs.Add('unidades', ftInteger, 0, False);
  kmtLineasProveedor.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtLineasProveedor.FieldDefs.Add('importe', ftFloat, 0, False);
  kmtLineasProveedor.FieldDefs.Add('precio', ftFloat, 0, False);
  kmtLineasProveedor.CreateTable;
  kmtLineasProveedor.Open;

  kmtPaletsProveedor.FieldDefs.Clear;
  kmtPaletsProveedor.FieldDefs.Add('empresa', ftString, 3, False);
  kmtPaletsProveedor.FieldDefs.Add('periodo', ftString, 15, False);
  kmtPaletsProveedor.FieldDefs.Add('producto', ftString, 3, False);
  kmtPaletsProveedor.FieldDefs.Add('cliente', ftString, 3, False);
  kmtPaletsProveedor.FieldDefs.Add('status', ftString, 1, False);
  kmtPaletsProveedor.FieldDefs.Add('fecha_status', ftDate, 0, False);
  kmtPaletsProveedor.FieldDefs.Add('sscc', ftString, 20, False);

  kmtPaletsProveedor.FieldDefs.Add('centro', ftString, 3, False);
  kmtPaletsProveedor.FieldDefs.Add('entrega', ftString, 12, False);
  kmtPaletsProveedor.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtPaletsProveedor.FieldDefs.Add('variedad', ftInteger, 0, False);
  kmtPaletsProveedor.FieldDefs.Add('envase', ftString, 9,  False);
  kmtPaletsProveedor.FieldDefs.Add('orden_carga', ftInteger, 0, False);

  kmtPaletsProveedor.FieldDefs.Add('albaran', ftInteger, 0, False);
  kmtPaletsProveedor.FieldDefs.Add('transito', ftInteger, 0, False);

  kmtPaletsProveedor.FieldDefs.Add('categoria', ftString, 3, False);
  kmtPaletsProveedor.FieldDefs.Add('calibre', ftString, 6, False);
  kmtPaletsProveedor.FieldDefs.Add('cajas', ftInteger, 0, False);
  kmtPaletsProveedor.FieldDefs.Add('unidades', ftInteger, 0, False);
  kmtPaletsProveedor.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtPaletsProveedor.FieldDefs.Add('precio', ftFloat, 0, False);
  kmtPaletsProveedor.FieldDefs.Add('importe', ftFloat, 0, False);
  kmtPaletsProveedor.FieldDefs.Add('peso_bruto', ftFloat, 0, False);

  kmtPaletsProveedor.CreateTable;
  kmtPaletsProveedor.Open;

  with qryEnvaseVariedad do
  begin
    Sql.Clear;
    Sql.Add(' select codigo_ean_pp, unidades_caja_pp, env.envase_e, ');
    Sql.Add('        env.unidades_e, env.unidades_variable_e, ');
    Sql.Add('        env.peso_neto_e, env.peso_variable_e ');
    Sql.Add(' from frf_productos_proveedor pp ');
    Sql.Add('      left join frf_ean13 e13 on e13.codigo_e = codigo_ean_pp ');
    Sql.Add('      left join frf_envases env on e13.envase_e = env.envase_e ');
    Sql.Add(' where proveedor_pp = :proveedor and producto_pp = :producto and variedad_pp = :variedad ');
    //Prepare;
  end;

  kmtEnvasesVariedad.FieldDefs.Clear;
  kmtEnvasesVariedad.FieldDefs.Add('empresa', ftString, 3, False);
  kmtEnvasesVariedad.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtEnvasesVariedad.FieldDefs.Add('producto', ftString, 3, False);
  kmtEnvasesVariedad.FieldDefs.Add('variedad', ftInteger, 0, False);

  kmtEnvasesVariedad.FieldDefs.Add('ean13', ftString, 13, False);
  kmtEnvasesVariedad.FieldDefs.Add('envase', ftString, 9,  False);
  kmtEnvasesVariedad.FieldDefs.Add('unidades', ftInteger, 0, False);
  kmtEnvasesVariedad.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtEnvasesVariedad.CreateTable;
  kmtEnvasesVariedad.Open;

  with qryDatosRF do
  begin
    SQL.Clear;
    SQL.Add(' select sum( cajas ) cajas, sum( peso ) peso ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :entrega ');
    SQL.Add(' and status <> ''B'' ');
  end;

  with qryEntrega do
  begin
    SQL.Clear;
    SQL.Add(' select sum(cajas_el) cajas, sum(kilos_el) peso_teorico, sum(peso_el) peso ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el = :entrega ');
  end;

  with qryImporteEntrega do
  begin
    SQL.Clear;
//    SQL.Add('  select sum( case when tipo_ge in (''010'',''020'',''030'') then importe_ge else 0 end ) importe_compra, ');
//    SQL.Add('         sum( case when tipo_ge in (''040'',''050'',''060'',''120'') then importe_ge else 0 end ) importe_transporte, ');
//    SQL.Add('         sum( case when tipo_ge in (''070'',''080'') then importe_ge else 0 end ) importe_transito, ');
//    SQL.Add('         sum( case when tipo_ge in (''090'',''100'',''110'') then importe_ge else 0 end ) importe_estadistico, ');
    SQL.Add('  select sum( case when tipo_ge in (''054'',''055'',''056'') then importe_ge else 0 end ) importe_compra, ');
    SQL.Add('         sum( case when tipo_ge in (''012'',''057'',''058'',''016'') then importe_ge else 0 end ) importe_transporte, ');
    SQL.Add('         sum( case when tipo_ge in (''014'',''015'') then importe_ge else 0 end ) importe_transito, ');
    SQL.Add('         sum( case when tipo_ge in (''059'',''060'') then importe_ge else 0 end ) importe_estadistico, ');               //en la unificacion de tipo gasto el 110 de BAG no existe.
    SQL.Add('         sum( importe_ge) importe ');
    SQL.Add('  from frf_gastos_entregas ');
    SQL.Add('  where codigo_ge = :entrega ');
  end;

  kmtEntregas.FieldDefs.Clear;
  kmtEntregas.FieldDefs.Add('entrega', ftString, 12, False);
  kmtEntregas.FieldDefs.Add('cajas_rf', ftInteger, 0, False);
  kmtEntregas.FieldDefs.Add('peso_rf', ftFloat, 0, False);
  kmtEntregas.FieldDefs.Add('cajas', ftInteger, 0, False);
  kmtEntregas.FieldDefs.Add('peso_teorico', ftFloat, 0, False);
  kmtEntregas.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtEntregas.FieldDefs.Add('importe_total', ftFloat, 0, False);
  kmtEntregas.FieldDefs.Add('importe_compra', ftFloat, 0, False);
  kmtEntregas.FieldDefs.Add('importe_transporte', ftFloat, 0, False);
  kmtEntregas.FieldDefs.Add('importe_transito', ftFloat, 0, False);
  kmtEntregas.FieldDefs.Add('importe_estadistico', ftFloat, 0, False);
  kmtEntregas.FieldDefs.Add('importe_resto', ftFloat, 0, False);
  kmtEntregas.CreateTable;
  kmtEntregas.Open;

  with qrySalidas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sc empresa, centro_Salida_Sc centro, fecha_sc fecha, n_albaran_Sc albaran, cliente_sal_sc  cliente ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_Salida_Sc = :centro ');
    SQL.Add(' and n_orden_sc = :orden ');
  end;

  with qryTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_tc empresa, centro_tc centro, fecha_tc fecha, referencia_tc albaran, centro_destino_tc  destino ');
    SQL.Add(' from frf_transitos_c ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and n_orden_tc = :orden ');
  end;

  kmtOrdenCarga.FieldDefs.Clear;
  kmtOrdenCarga.FieldDefs.Add('empresa', ftString, 3, False);
  kmtOrdenCarga.FieldDefs.Add('centro', ftString, 3, False);
  kmtOrdenCarga.FieldDefs.Add('orden', ftString, 12, False);
  kmtOrdenCarga.FieldDefs.Add('tipo', ftInteger, 0, False); //-1 error, 1 Alabaran 2 Transito
  kmtOrdenCarga.FieldDefs.Add('albaran', ftInteger, 0, False);
  kmtOrdenCarga.FieldDefs.Add('cliente', ftString, 0, False);
  kmtOrdenCarga.CreateTable;
  kmtOrdenCarga.Open;
end;

procedure TDLMargenBProveedor.CerrarQuerys;
begin
  kmtLineasProveedor.Close;
  kmtPaletsProveedor.Close;
  kmtEnvasesVariedad.Close;
  kmtEntregas.Close;
  kmtOrdenCarga.Close;

  qryImporteEntrega.Close;
  qryEntrega.Close;
  qryDatosRF.Close;
  qrySalidas.Close;
  qryTransitos.Close;
  qryEnvaseVariedad.Close;
  qryPaletsProveedor.Close;
end;


procedure TDLMargenBProveedor.DatosEnvaseVolcados( const AEmpresa, AProveedor, AProducto, ACalibre: string; const AVariedad: Integer;
                                                   var VUnidades: integer );
begin
  //Cocos y piñas, el calibre es el numero de unidades
  if ( AProducto = 'PIN' ) or ( AProducto = 'COC' ) then
  begin
    if not TryStrToInt( ACalibre, VUnidades ) then
    begin
      if not TryStrToInt( Copy( ACalibre, 2, Length( ACalibre ) ), VUnidades ) then
      begin
        VUnidades:= 0;
      end
    end;
  end;
  (*
  if VUnidades = -1 then
  begin
    //Sql.Add(' unidades_caja_pp, env.unidades_variable_e, env.peso_variable_e ');
    if kmtEnvasesVariedad.locate('empresa;proveedor;producto;variedad',
                                 VarArrayOf([AEmpresa, AProveedor, AProducto, AVariedad]),[]) then
    begin
      VUnidades:= kmtEnvasesVariedad.FieldByName('unidades').AsInteger;
    end
    else
    begin
      qryEnvaseVariedad.ParamByName('empresa').AsString:= AEmpresa;
      qryEnvaseVariedad.ParamByName('proveedor').AsString:= AProveedor;
      qryEnvaseVariedad.ParamByName('producto').AsString:= AProducto;
      qryEnvaseVariedad.ParamByName('variedad').AsInteger:= AVariedad;
      qryEnvaseVariedad.Open;
      if not qryEnvaseVariedad.isEmpty then
      begin
        kmtEnvasesVariedad.Insert;
        kmtEnvasesVariedad.FieldByName('empresa').AsString:= AEmpresa;
        kmtEnvasesVariedad.FieldByName('proveedor').AsString:= AProveedor;
        kmtEnvasesVariedad.FieldByName('producto').AsString:= AProducto;
        kmtEnvasesVariedad.FieldByName('variedad').AsInteger:= AVariedad;

        kmtEnvasesVariedad.FieldByName('ean13').AsString:= qryEnvaseVariedad.FieldByName('codigo_ean_pp').AsString;
        kmtEnvasesVariedad.FieldByName('envase').AsString:= qryEnvaseVariedad.FieldByName('envase_e').AsString;
        kmtEnvasesVariedad.FieldByName('unidades').AsInteger:= qryEnvaseVariedad.FieldByName('unidades_e').AsInteger;
        kmtEnvasesVariedad.FieldByName('peso').AsFloat:= qryEnvaseVariedad.FieldByName('peso_neto_e').AsFloat;
        kmtEnvasesVariedad.Post;
        VUnidades:= qryEnvaseVariedad.FieldByName('unidades_e').AsInteger;
      end
      else
      begin
        VUnidades:= 0;
      end;
      qryEnvaseVariedad.Close;
    end;
  end;
  *)
end;

function TDLMargenBProveedor.EsOrdenCargaVenta( const AEmpresa, ACentro: string; const AOrden: Integer; var VCliente: string;  var VAlbaran: integer ): boolean;
begin
  qrySalidas.ParamByName('empresa').AsString:= AEmpresa;
  qrySalidas.ParamByName('centro').AsString:= ACentro;
  qrySalidas.ParamByName('orden').AsString:= IntToStr( AOrden );
  qrySalidas.Open;

  if not qrySalidas.IsEmpty then
  begin
    result:= True;
    VCliente:= qrySalidas.FieldByName('cliente').AsString;
    VAlbaran:= qrySalidas.FieldByName('albaran').AsInteger;
  end
  else
  begin
    result:= False;
  end;
  qrySalidas.Close;
end;

function TDLMargenBProveedor.EsOrdenCargaTransito( const AEmpresa, ACentro: string; const AOrden: Integer; var VCliente: string;  var VAlbaran: integer ): boolean;
begin
  qryTransitos.ParamByName('empresa').AsString:= AEmpresa;
  qryTransitos.ParamByName('centro').AsString:= ACentro;
  qryTransitos.ParamByName('orden').AsString:= IntToStr( AOrden );
  qryTransitos.Open;
  if not qryTransitos.IsEmpty then
  begin
    result:= True;
    VCliente:= qryTransitos.FieldByName('destino').AsString;
    VAlbaran:= qryTransitos.FieldByName('albaran').AsInteger;
  end
  else
  begin
    result:= False;
  end;
  qryTransitos.Close;
end;

function TipoCargaToInt( const ATipo: TTipoCarga ): Integer;
begin
  if ATipo = tcVenta then
  begin
    Result:= 1;
  end
  else
  if ATipo = tcTransito then
  begin
    Result:= 2;
  end
  else
  if ATipo = tcVolcado then
  begin
    Result:= 3;
  end
  else
  //if ATipo = tcError then
  begin
    Result:= 0;
  end;
end;

function IntToTipoCarga( const ATipo: Integer ): TTipoCarga;
begin
  if ATipo = 1 then
  begin
    Result:= tcVenta;
  end
  else
  if ATipo = 2 then
  begin
    Result:= tcTransito;
  end
  else
  if ATipo = 3 then
  begin
    Result:= tcVolcado;
  end
  else
  //if ATipo = 0 then
  begin
    Result:= tcError;
  end;
end;

procedure TDLMargenBProveedor.DatosOrdenCarga( const AEmpresa, ACentro: string; const AOrden: Integer; var VCliente: string;  var VAlbaran: Integer; var  VTipo: TTipoCarga );
begin
  if kmtOrdenCarga.locate('empresa;centro;orden',VarArrayOf([AEmpresa,ACentro,AOrden]),[]) then
  begin
    VCliente:= kmtOrdenCarga.FieldByName('cliente').AsString;
    VAlbaran:= kmtOrdenCarga.FieldByName('albaran').AsInteger;
    VTipo:= IntToTipoCarga( kmtOrdenCarga.FieldByName('tipo').AsInteger );
  end
  else
  begin
    if EsOrdenCargaVenta( AEmpresa, ACentro, AOrden, VCliente, VAlbaran ) then
    begin
      VTipo:= tcVenta;
    end
    else
    begin
      if EsOrdenCargaTransito( AEmpresa, ACentro, AOrden, VCliente, VAlbaran ) then
      begin
        VTipo:= tcTransito;
      end
      else
      begin
        VTipo:= tcError;
        VCliente:= '';
        VAlbaran:= 0;
      end;
    end;

    kmtOrdenCarga.Insert;
    kmtOrdenCarga.FieldByName('empresa').AsString:= AEmpresa;
    kmtOrdenCarga.FieldByName('centro').AsString:= ACentro;
    kmtOrdenCarga.FieldByName('orden').AsInteger:= AOrden;
    kmtOrdenCarga.FieldByName('cliente').AsString:= VCliente;
    kmtOrdenCarga.FieldByName('albaran').AsInteger:= VAlbaran;
    kmtOrdenCarga.FieldByName('tipo').AsInteger:= TipoCargaToInt( VTipo );
    kmtOrdenCarga.Post;
  end;
end;

procedure TDLMargenBProveedor.DatosEnvaseCargados( const AEmpresa, AProveedor, AProducto, ACalibre: string; const AVariedad: Integer;
                                                   var VUnidades: integer );
begin
  //Cocos y piñas, el calibre es el numero de unidades
  if ( AProducto = 'PIN' ) or ( AProducto = 'COC' ) then
  begin
    if not TryStrToInt( ACalibre, VUnidades ) then
    begin
      if not TryStrToInt( Copy( ACalibre, 2, Length( ACalibre ) ), VUnidades ) then
      begin
        VUnidades:= -1;
      end
    end;
  end
  else
  begin
    VUnidades:= -1;
  end;

  if VUnidades = -1 then
  begin
    //Sql.Add(' unidades_caja_pp, env.unidades_variable_e, env.peso_variable_e ');
    if kmtEnvasesVariedad.locate('empresa;proveedor;producto;variedad',
                                 VarArrayOf([AEmpresa, AProveedor, AProducto, AVariedad]),[]) then
    begin
      VUnidades:= kmtEnvasesVariedad.FieldByName('unidades').AsInteger;
    end
    else
    begin
      qryEnvaseVariedad.ParamByName('empresa').AsString:= AEmpresa;
      qryEnvaseVariedad.ParamByName('proveedor').AsString:= AProveedor;
      qryEnvaseVariedad.ParamByName('producto').AsString:= AProducto;
      qryEnvaseVariedad.ParamByName('variedad').AsInteger:= AVariedad;
      qryEnvaseVariedad.Open;
      if not qryEnvaseVariedad.isEmpty then
      begin
        kmtEnvasesVariedad.Insert;
        kmtEnvasesVariedad.FieldByName('empresa').AsString:= AEmpresa;
        kmtEnvasesVariedad.FieldByName('proveedor').AsString:= AProveedor;
        kmtEnvasesVariedad.FieldByName('producto').AsString:= AProducto;
        kmtEnvasesVariedad.FieldByName('variedad').AsInteger:= AVariedad;

        kmtEnvasesVariedad.FieldByName('ean13').AsString:= qryEnvaseVariedad.FieldByName('codigo_ean_pp').AsString;
        kmtEnvasesVariedad.FieldByName('envase').AsString:= qryEnvaseVariedad.FieldByName('envase_e').AsString;
        kmtEnvasesVariedad.FieldByName('unidades').AsInteger:= qryEnvaseVariedad.FieldByName('unidades_e').AsInteger;
        kmtEnvasesVariedad.FieldByName('peso').AsFloat:= qryEnvaseVariedad.FieldByName('peso_neto_e').AsFloat;
        kmtEnvasesVariedad.Post;
        VUnidades:= qryEnvaseVariedad.FieldByName('unidades_e').AsInteger;
      end
      else
      begin
        VUnidades:= 0;
      end;
      qryEnvaseVariedad.Close;
    end;
  end;
end;

procedure TDLMargenBProveedor.DatosEntrega( const AEntrega: string; var VCajasRF: Integer; var VKilosRF: Real;
                            var VCajasEntrega: integer; var VKilosEntrega, VImporteEntrega: real );
begin
  if kmtEntregas.locate('entrega',VarArrayOf([AEntrega]),[]) then
  begin
    VCajasRF:= kmtEntregas.FieldByName('cajas_rf').AsInteger;
    VKilosRF:= kmtEntregas.FieldByName('peso_rf').AsFloat;
    VCajasEntrega:= kmtEntregas.FieldByName('cajas').AsInteger;
    VKilosEntrega:= kmtEntregas.FieldByName('peso_teorico').AsFloat;
    VImporteEntrega:= kmtEntregas.FieldByName('importe_total').AsFloat;
  end
  else
  begin
    kmtEntregas.Insert;
    kmtEntregas.FieldByName('entrega').AsString:= AEntrega;

    qryDatosRF.ParamByName('entrega').AsString:= AEntrega;
    qryDatosRF.Open;
    if not qryDatosRF.isEmpty then
    begin
      kmtEntregas.FieldByName('cajas_rf').AsInteger:= qryDatosRF.FieldByName('cajas').AsInteger;
      kmtEntregas.FieldByName('peso_rf').AsFloat:= qryDatosRF.FieldByName('peso').AsFloat;
    end
    else
    begin
      kmtEntregas.FieldByName('cajas_rf').AsInteger:= 0;
      kmtEntregas.FieldByName('peso_rf').AsFloat:= 0;
    end;
    qryDatosRF.Close;
    VCajasRF:= kmtEntregas.FieldByName('cajas_rf').AsInteger;
    VKilosRF:= kmtEntregas.FieldByName('peso_rf').AsFloat;

    qryEntrega.ParamByName('entrega').AsString:= AEntrega;
    qryEntrega.Open;
    if not qryEntrega.isEmpty then
    begin
      kmtEntregas.FieldByName('cajas').AsInteger:= qryEntrega.FieldByName('cajas').AsInteger;
      kmtEntregas.FieldByName('peso_teorico').AsFloat:= qryEntrega.FieldByName('peso_teorico').AsFloat;
      kmtEntregas.FieldByName('peso').AsFloat:= qryEntrega.FieldByName('peso').AsFloat;
    end
    else
    begin
      kmtEntregas.FieldByName('cajas').AsInteger:= 0;
      kmtEntregas.FieldByName('peso_teorico').AsFloat:= 0;
      kmtEntregas.FieldByName('peso').AsFloat:= 0;
    end;
    qryEntrega.Close;

    VCajasEntrega:= kmtEntregas.FieldByName('cajas').AsInteger;
    VKilosEntrega:= kmtEntregas.FieldByName('peso_teorico').AsFloat;

    qryImporteEntrega.ParamByName('entrega').AsString:= AEntrega;
    qryImporteEntrega.Open;
    if not qryImporteEntrega.isEmpty then
    begin
      kmtEntregas.FieldByName('importe_compra').AsFloat:= qryImporteEntrega.FieldByName('importe_compra').AsFloat;
      kmtEntregas.FieldByName('importe_transporte').AsFloat:= qryImporteEntrega.FieldByName('importe_transporte').AsFloat;
      kmtEntregas.FieldByName('importe_transito').AsFloat:= qryImporteEntrega.FieldByName('importe_transito').AsFloat;
      kmtEntregas.FieldByName('importe_estadistico').AsFloat:= qryImporteEntrega.FieldByName('importe_estadistico').AsFloat;
      kmtEntregas.FieldByName('importe_total').AsFloat:= qryImporteEntrega.FieldByName('importe').AsFloat -
                                                         qryImporteEntrega.FieldByName('importe_estadistico').AsFloat;

      kmtEntregas.FieldByName('importe_resto').AsFloat:= qryImporteEntrega.FieldByName('importe').AsFloat -
        ( qryImporteEntrega.FieldByName('importe_compra').AsInteger + qryImporteEntrega.FieldByName('importe_transporte').AsFloat +
          qryImporteEntrega.FieldByName('importe_transito').AsInteger + qryImporteEntrega.FieldByName('importe_estadistico').AsFloat );
    end
    else
    begin
      kmtEntregas.FieldByName('importe_compra').AsFloat:=  0;
      kmtEntregas.FieldByName('importe_transporte').AsFloat:=  0;
      kmtEntregas.FieldByName('importe_transito').AsFloat:=  0;
      kmtEntregas.FieldByName('importe_estadistico').AsFloat:=  0;
      kmtEntregas.FieldByName('importe_total').AsFloat:= 0;
      kmtEntregas.FieldByName('importe_resto').AsFloat:= 0;
    end;
    qryImporteEntrega.Close;

    VImporteEntrega:= kmtEntregas.FieldByName('importe_total').AsFloat;

    kmtEntregas.Post;
  end;
end;

procedure TDLMargenBProveedor.LoadParametros( const AEmpresa, AProducto, ACliente: string ;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ACostesAplicar: RCostesAplicar;
                              const ATipo: TTipoProveedor );
begin
  CostesAplicar:=  ACostesAplicar;
  sgEmpresa:= AEmpresa;
  sgProducto:= AProducto;
  sgCliente:= ACliente;
  dgFechaIni:= AFechaIni;
  dgFechaFin:= AFechaFin;
  tpgTtipo:= ATipo;
end;

procedure TDLMargenBProveedor.PaletsProveedor( const AEmpresa, AProducto, ACliente: string;
                                              const AFechaIni, AFechaFin: TDateTime;
                                              const ACostesAplicar: RCostesAplicar;
                                              const ATipo: TTipoProveedor );
begin

  LoadParametros( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, ATipo );
  if QuerysProveedor then
  begin
    if ( tpgTtipo = tvCargados ) or ( tpgTtipo = tvVentas ) or ( tpgTtipo = tvTransitos ) then
    begin
      PaletsProveedorCargados;
    end
    else
    begin
      PaletsProveedorVolcados;
    end;
  end;

  kmtPaletsProveedor.SortFields:= 'periodo;producto;fecha_status;entrega;sscc';
  kmtPaletsProveedor.Sort([]);

  kmtLineasProveedor.SortFields:= 'periodo;producto';
  kmtLineasProveedor.Sort([]);
end;

procedure TDLMargenBProveedor.PaletsProveedorCargados;
var
  iUnidades: Integer;
  rCajasEntrega, rCajasRf: Integer;
  rKilosEntrega, rKilosRf, rImporteEntrega: Real;
  sCliente: string;
  iAlbaran: Integer;
  iTipo: TTipoCarga;
begin
  while not qryPaletsProveedor.Eof do
  begin
    DatosOrdenCarga( qryPaletsProveedor.FieldByName('empresa').AsString,  qryPaletsProveedor.FieldByName('centro').AsString,
                     qryPaletsProveedor.FieldByName('orden_carga').AsInteger, sCliente, iAlbaran, iTipo );

    if ( ( tpgTtipo = tvVentas ) and ( iTipo = tcVenta ) ) or
       ( ( tpgTtipo = tvTransitos ) and ( iTipo = tcTransito ) ) or
       ( ( tpgTtipo = tvCargados ) )then
    begin
     DatosEnvaseCargados( qryPaletsProveedor.FieldByName('empresa').AsString,  qryPaletsProveedor.FieldByName('proveedor').AsString,
                         qryPaletsProveedor.FieldByName('producto').AsString, qryPaletsProveedor.FieldByName('calibre').AsString,
                         qryPaletsProveedor.FieldByName('variedad').AsInteger, iUnidades );

      DatosEntrega( qryPaletsProveedor.FieldByName('entrega').AsString, rCajasRf, rKilosRf, rCajasEntrega, rKilosEntrega, rImporteEntrega );

      kmtPaletsProveedor.Insert;
      kmtPaletsProveedor.FieldByName('periodo').AsString:= 'PERIODO';
      kmtPaletsProveedor.FieldByName('producto').AsString:= qryPaletsProveedor.FieldByName('producto').AsString;

      kmtPaletsProveedor.FieldByName('fecha_status').AsDateTime:= qryPaletsProveedor.FieldByName('fecha').AsDateTime;

      kmtPaletsProveedor.FieldByName('empresa').AsString:= qryPaletsProveedor.FieldByName('empresa').AsString;
      kmtPaletsProveedor.FieldByName('centro').AsString:= qryPaletsProveedor.FieldByName('centro').AsString;
    kmtPaletsProveedor.FieldByName('entrega').AsString:= qryPaletsProveedor.FieldByName('entrega').AsString;
    kmtPaletsProveedor.FieldByName('sscc').AsString:= qryPaletsProveedor.FieldByName('sscc').AsString;
    kmtPaletsProveedor.FieldByName('proveedor').AsString:= qryPaletsProveedor.FieldByName('proveedor').AsString;
    kmtPaletsProveedor.FieldByName('variedad').AsInteger:= qryPaletsProveedor.FieldByName('variedad').AsInteger;
    kmtPaletsProveedor.FieldByName('calibre').AsString:= qryPaletsProveedor.FieldByName('calibre').AsString;
    kmtPaletsProveedor.FieldByName('categoria').AsString:= qryPaletsProveedor.FieldByName('categoria').AsString;
    kmtPaletsProveedor.FieldByName('status').AsString:= qryPaletsProveedor.FieldByName('status').AsString;

    kmtPaletsProveedor.FieldByName('orden_carga').AsInteger:= qryPaletsProveedor.FieldByName('orden_carga').AsInteger;
    kmtPaletsProveedor.FieldByName('cliente').AsString:= sCliente;
    kmtPaletsProveedor.FieldByName('albaran').AsInteger:= iAlbaran;
    kmtPaletsProveedor.FieldByName('transito').AsInteger:= TipoCargaToInt( iTipo );

    kmtPaletsProveedor.FieldByName('cajas').AsInteger:= qryPaletsProveedor.FieldByName('cajas').AsInteger;
    kmtPaletsProveedor.FieldByName('unidades').AsInteger:= iUnidades * qryPaletsProveedor.FieldByName('cajas').AsInteger;
    kmtPaletsProveedor.FieldByName('peso').AsFloat:= qryPaletsProveedor.FieldByName('peso').AsFloat;
    kmtPaletsProveedor.FieldByName('peso_bruto').AsFloat:= qryPaletsProveedor.FieldByName('peso_bruto').AsFloat;

    if  rKilosRf > 0 then
      kmtPaletsProveedor.FieldByName('precio').AsFloat:= bRoundTo( rImporteEntrega / rKilosRf, 3 )
    else
      kmtPaletsProveedor.FieldByName('precio').AsFloat:= 0;
    kmtPaletsProveedor.FieldByName('importe').AsFloat:= bRoundTo( kmtPaletsProveedor.FieldByName('precio').AsFloat *
                                                                 kmtPaletsProveedor.FieldByName('peso').AsFloat, 2 ) ;

    AddLineaProveedor;
    kmtPaletsProveedor.Post;



    end;
    qryPaletsProveedor.Next;
  end;
end;

procedure TDLMargenBProveedor.PaletsProveedorVolcados;
var
  iUnidades: Integer;
  rCajasEntrega, rCajasRf: Integer;
  rKilosEntrega, rKilosRf, rImporteEntrega: Real;
  sCliente: string;
  iAlbaran: Integer;
  iTipo: TTipoCarga;
begin
  while not qryPaletsProveedor.Eof do
  begin
    sCliente:= qryPaletsProveedor.FieldByName('cliente').AsString;
    iAlbaran:= 0;
    iTipo:= tcVolcado;

    DatosEnvaseVolcados( qryPaletsProveedor.FieldByName('empresa').AsString,  qryPaletsProveedor.FieldByName('proveedor').AsString,
                         qryPaletsProveedor.FieldByName('producto').AsString, qryPaletsProveedor.FieldByName('calibre').AsString,
                         qryPaletsProveedor.FieldByName('variedad').AsInteger, iUnidades );

    DatosEntrega( qryPaletsProveedor.FieldByName('entrega').AsString, rCajasRf, rKilosRf, rCajasEntrega, rKilosEntrega, rImporteEntrega );

    kmtPaletsProveedor.Insert;
    kmtPaletsProveedor.FieldByName('periodo').AsString:= 'PERIODO';
    kmtPaletsProveedor.FieldByName('producto').AsString:= qryPaletsProveedor.FieldByName('producto').AsString;

    kmtPaletsProveedor.FieldByName('fecha_status').AsDateTime:= qryPaletsProveedor.FieldByName('fecha').AsDateTime;

    kmtPaletsProveedor.FieldByName('empresa').AsString:= qryPaletsProveedor.FieldByName('empresa').AsString;
    kmtPaletsProveedor.FieldByName('centro').AsString:= qryPaletsProveedor.FieldByName('centro').AsString;
    kmtPaletsProveedor.FieldByName('entrega').AsString:= qryPaletsProveedor.FieldByName('entrega').AsString;
    kmtPaletsProveedor.FieldByName('sscc').AsString:= qryPaletsProveedor.FieldByName('sscc').AsString;
    kmtPaletsProveedor.FieldByName('proveedor').AsString:= qryPaletsProveedor.FieldByName('proveedor').AsString;
    kmtPaletsProveedor.FieldByName('variedad').AsInteger:= qryPaletsProveedor.FieldByName('variedad').AsInteger;
    kmtPaletsProveedor.FieldByName('calibre').AsString:= qryPaletsProveedor.FieldByName('calibre').AsString;
    kmtPaletsProveedor.FieldByName('categoria').AsString:= qryPaletsProveedor.FieldByName('categoria').AsString;
    kmtPaletsProveedor.FieldByName('status').AsString:= qryPaletsProveedor.FieldByName('status').AsString;

    kmtPaletsProveedor.FieldByName('orden_carga').AsInteger:= qryPaletsProveedor.FieldByName('orden_carga').AsInteger;
    kmtPaletsProveedor.FieldByName('cliente').AsString:= sCliente;
    kmtPaletsProveedor.FieldByName('albaran').AsInteger:= iAlbaran;
    kmtPaletsProveedor.FieldByName('transito').AsInteger:= TipoCargaToInt( iTipo );

    kmtPaletsProveedor.FieldByName('cajas').AsInteger:= qryPaletsProveedor.FieldByName('cajas').AsInteger;
    kmtPaletsProveedor.FieldByName('unidades').AsInteger:= iUnidades * qryPaletsProveedor.FieldByName('cajas').AsInteger;
    kmtPaletsProveedor.FieldByName('peso').AsFloat:= qryPaletsProveedor.FieldByName('peso').AsFloat;
    kmtPaletsProveedor.FieldByName('peso_bruto').AsFloat:= qryPaletsProveedor.FieldByName('peso_bruto').AsFloat;

    if  rKilosRf > 0 then
      kmtPaletsProveedor.FieldByName('precio').AsFloat:= bRoundTo( rImporteEntrega / rKilosRf, 3 )
    else
      kmtPaletsProveedor.FieldByName('precio').AsFloat:= 0;
    kmtPaletsProveedor.FieldByName('importe').AsFloat:= bRoundTo( kmtPaletsProveedor.FieldByName('precio').AsFloat *
                                                                 kmtPaletsProveedor.FieldByName('peso').AsFloat, 2 ) ;

    AddLineaProveedor;
    kmtPaletsProveedor.Post;

    qryPaletsProveedor.Next;
  end;
end;

procedure TDLMargenBProveedor.AddLineaProveedor;
begin
  if kmtLineasProveedor.Locate( 'periodo;producto', VarArrayOf(['PERIODO',kmtPaletsProveedor.FieldByName('producto').AsString,0]),[]) then
  begin
    kmtLineasProveedor.Edit;
    kmtLineasProveedor.FieldByName('peso').AsFloat:= kmtLineasProveedor.FieldByName('peso').AsFloat +
                                                    kmtPaletsProveedor.FieldByName('peso').AsFloat;
    kmtLineasProveedor.FieldByName('importe').AsFloat:= kmtLineasProveedor.FieldByName('importe').AsFloat +
                                                       kmtPaletsProveedor.FieldByName('importe').AsFloat;
    if kmtLineasProveedor.FieldByName('peso').AsFloat > 0 then
    begin
      kmtLineasProveedor.FieldByName('precio').AsFloat:= bRoundTo( kmtLineasProveedor.FieldByName('importe').AsFloat /
                                                                  kmtLineasProveedor.FieldByName('peso').AsFloat, 3);
    end
    else
    begin
      kmtLineasProveedor.FieldByName('precio').AsFloat:= 0;
    end;
    kmtLineasProveedor.FieldByName('cajas').AsInteger:= kmtLineasProveedor.FieldByName('cajas').AsInteger +
                                                       kmtPaletsProveedor.FieldByName('cajas').AsInteger;
    kmtLineasProveedor.FieldByName('unidades').AsInteger:= kmtLineasProveedor.FieldByName('unidades').AsInteger +
                                                          kmtPaletsProveedor.FieldByName('unidades').AsInteger;
    kmtLineasProveedor.Post;
  end
  else
  begin
    kmtLineasProveedor.Insert;
    kmtLineasProveedor.FieldByName('empresa').AsString:= sgEmpresa;
    kmtLineasProveedor.FieldByName('periodo').AsString:= 'PERIODO';
    kmtLineasProveedor.FieldByName('producto').AsString:= kmtPaletsProveedor.FieldByName('producto').AsString;
    kmtLineasProveedor.FieldByName('cliente').AsString:= '';
    kmtLineasProveedor.FieldByName('peso').AsFloat:= kmtPaletsProveedor.FieldByName('peso').AsFloat;
    kmtLineasProveedor.FieldByName('importe').AsFloat:= kmtPaletsProveedor.FieldByName('importe').AsFloat;
    if kmtLineasProveedor.FieldByName('peso').AsFloat > 0 then
    begin
      kmtLineasProveedor.FieldByName('precio').AsFloat:= bRoundTo( kmtLineasProveedor.FieldByName('importe').AsFloat /
                                                                  kmtLineasProveedor.FieldByName('peso').AsFloat, 3);
    end
    else
    begin
      kmtLineasProveedor.FieldByName('precio').AsFloat:= 0;
    end;
    kmtLineasProveedor.FieldByName('cajas').AsInteger:= kmtPaletsProveedor.FieldByName('cajas').AsInteger;
    kmtLineasProveedor.FieldByName('unidades').AsInteger:= kmtPaletsProveedor.FieldByName('unidades').AsInteger;
    kmtLineasProveedor.Post;
  end;
end;

(*
function  GetKiloCajaTeorico( const AEntrega, AEmpresa, AProveedor, AProducto, AVariedad, ACategoria, ACalibre: string;
                                   var AEncontrado: boolean ): Real;
function TDLMargenBBeneficios.GetKiloCajaTeorico( const AEntrega, AEmpresa, AProveedor, AProducto, AVariedad, ACategoria, ACalibre: string;
                                               var AEncontrado: boolean ): Real;
var
  bParcial: Boolean;
begin
  AEncontrado:= False;
  with qryKilosTeoricosCaja do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('proveedor').AsString:= AProveedor;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('variedad').AsString:= AVariedad;
    Open;
    result:= KilosCajas;
    bParcial:= FieldByName('categoria').AsString = ACategoria;
    while ( not Eof ) and ( not AEncontrado ) do
    begin
      if ( FieldByName('categoria').AsString = ACategoria  ) and
         ( FieldByName('calibre').AsString = ACalibre ) then
      begin
         AEncontrado:= True;
         result:= KilosCajas;
      end
      else
      begin
        if not bParcial then
        begin
          if ( FieldByName('categoria').AsString = ACategoria  ) then
          begin
            bParcial:= True;
            result:= KilosCajas;
          end;
        end;
      end;
      Next;
    end;
    Close;
  end;
end;


  with qryKilosTeoricosCaja do
  begin
    SQL.Clear;
    SQL.Add(' select categoria_el categoria, calibre_el calibre, sum(kilos_el) kilos, sum( cajas_el ) cajas ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el = :entrega ');
    SQL.Add(' and empresa_el = :empresa ');
    SQL.Add(' and  proveedor_el = :proveedor ');
    SQL.Add(' and  producto_el = :producto ');
    SQL.Add(' and  variedad_el = :variedad ');
    SQL.Add(' group by 1,2 ');
    SQL.Add(' order by 1,2 ');
  end;

    function  KilosCajas: real;
function TDLMargenBBeneficios.KilosCajas: real;
begin
  if qryKilosTeoricosCaja.FieldByName('cajas').AsFloat <> 0 then
    result:= bRoundTo( qryKilosTeoricosCaja.FieldByName('kilos').AsFloat / qryKilosTeoricosCaja.FieldByName('cajas').AsFloat, 3 )
  else
    result:= 0;
end;
*)

(*

procedure TDLMargenBBeneficios.PrecioEntrega( const AEntrega: string; var VPrevision: Boolean; var VPrecioCompra, VPrecioTransporte, VPrecioTransito, VPrecioEstadistico: real );
var
  iCajas: integer;
  rCompra, rTransporte, rTransito, rEstadistico: Real;
begin
  if mtEntregas.Locate('entrega', VarArrayOf([AEntrega]),[] ) then
  begin
    VPrecioCompra:= mtEntregas.FieldByname('precio_compra').AsFloat;
    VPrecioTransporte:= mtEntregas.FieldByname('precio_transporte').AsFloat;
    VPrecioTransito:= mtEntregas.FieldByname('precio_transito').AsFloat;
    VPrecioEstadistico:= mtEntregas.FieldByname('precio_estadistico').AsFloat;
    VPrecioEstadistico:= mtEntregas.FieldByname('precio_estadistico').AsFloat;
    VPrevision:= mtEntregas.FieldByname('prevision').Asinteger = 1;
  end
  else
  begin
    VPrevision:= False;
    with QCajasRF do
    begin
      ParamByName('entrega').AsString:= AEntrega;
      Open;
      iCajas:= FieldByname('cajas').AsInteger;
      Close;
    end;
    with QImportes do
    begin
      ParamByName('entrega').AsString:= AEntrega;
      Open;

      rCompra:= FieldByName('importe_compra').AsFloat;
      rTransporte:= FieldByName('importe_transporte').AsFloat;
      rTransito:= FieldByName('importe_transito').AsFloat;
      rEstadistico:= FieldByName('importe_estadistico').AsFloat;

      Close;

      if ( rCompra = 0 ) or  ( rTransporte = 0 ) then
      begin
        QCostePrevisto.ParamByName('entrega').AsString:= AEntrega;
        QCostePrevisto.Open;
        try
          if rCompra = 0 then
          begin
            QCostePrevisto.First;
            while not QCostePrevisto.Eof do
            begin
              if ( QCostePrevisto.FieldByName('categoria_el').AsString = 'I' ) or
                 ( QCostePrevisto.FieldByName('categoria_el').AsString = '1' ) then
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_primera_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 )
              else
              if ( QCostePrevisto.FieldByName('categoria_el').AsString = 'EX' ) then
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_extra_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 )
              else
              if ( QCostePrevisto.FieldByName('categoria_el').AsString = 'SE' ) then
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_super_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 )
              else
              if ( QCostePrevisto.FieldByName('categoria_el').AsString = '10' ) then
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_platano10_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 )
              else
              if ( QCostePrevisto.FieldByName('categoria_el').AsString = 'ST' ) then
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_platanost_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 )
              else
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_resto_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 );
              QCostePrevisto.Next;
            end;
            VPrevision:= rCompra <> 0;
          end;
          if rTransporte = 0 then
          begin
            QCostePrevisto.First;
            while not QCostePrevisto.Eof do
            begin
              rTransporte:= rTransporte + bRoundTo( QCostePrevisto.FieldByName('coste_transporte_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 );
              QCostePrevisto.Next;
            end;
            VPrevision:= VPrevision or ( rTransporte <> 0 );
          end;
        finally
          QCostePrevisto.Close;
        end;
      end;

      if iCajas > 0 then
      begin
        VPrecioCompra:= bRoundTo( rCompra / iCajas, 3 );
        VPrecioTransporte:= bRoundTo( rTransporte / iCajas, 3 );
        VPrecioTransito:= bRoundTo( rTransito / iCajas, 3 );
        VPrecioEstadistico:= bRoundTo( rEstadistico / iCajas, 3 );
      end
      else
      begin
        VPrecioCompra:= 0;
        VPrecioTransporte:= 0;
        VPrecioTransito:= 0;
        VPrecioEstadistico:= 0;
      end;

      mtEntregas.Insert;
      mtEntregas.FieldByname('entrega').AsString:= AEntrega;
      mtEntregas.FieldByname('cajas').AsInteger:= iCajas;
      if VPrevision then
        mtEntregas.FieldByname('prevision').AsInteger:= 1
      else
        mtEntregas.FieldByname('prevision').AsInteger:= 0;
      mtEntregas.FieldByname('importe_compra').AsFloat:= rCompra;
      mtEntregas.FieldByname('precio_compra').AsFloat:= VPrecioCompra;
      mtEntregas.FieldByname('importe_transporte').AsFloat:= rTransporte;
      mtEntregas.FieldByname('precio_transporte').AsFloat:= VPrecioTransporte;
      mtEntregas.FieldByname('importe_transito').AsFloat:= rTransito;
      mtEntregas.FieldByname('precio_transito').AsFloat:= VPrecioTransito;
      mtEntregas.FieldByname('importe_estadistico').AsFloat:= rEstadistico;
      mtEntregas.FieldByname('precio_estadistico').AsFloat:= VPrecioEstadistico;
      mtEntregas.Post;

    end;
  end;
end;

procedure TDLMargenBBeneficios.ActualizarPrecios( const AEmpresa, AProducto, AProveedor: String; const APrecioFruta, APrecioTransporte: real;
                                                 const APrevision: boolean );
var
  rPrecio: Real;
begin
  rPrecio:= APrecioFruta + APrecioTransporte;
  if mtPrecios.Locate('producto_precio;proveedor_precio;empresa_precio', VarArrayOf([AProducto,AProveedor,AEmpresa]),[] ) then
  begin
    if APrevision then
    begin
      if rPrecio > mtPrecios.FieldByname('precio_maximo_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_maximo_previsto').AsFloat:= rPrecio;
        mtPrecios.Post;
      end
      else
      if rPrecio < mtPrecios.FieldByname('precio_minimo_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_minimo_previsto').AsFloat:= rPrecio;
        mtPrecios.Post;
      end;

      if APrecioFruta > mtPrecios.FieldByname('precio_fruta_max_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_fruta_max_previsto').AsFloat:= APrecioFruta;
        mtPrecios.Post;
      end
      else
      if APrecioFruta < mtPrecios.FieldByname('precio_fruta_min_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_fruta_min_previsto').AsFloat:= APrecioFruta;
        mtPrecios.Post;
      end;

      if APrecioTransporte > mtPrecios.FieldByname('precio_transporte_max_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_transporte_max_previsto').AsFloat:= APrecioTransporte;
        mtPrecios.Post;
      end
      else
      if APrecioTransporte < mtPrecios.FieldByname('precio_transporte_min_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_transporte_min_previsto').AsFloat:= APrecioTransporte;
        mtPrecios.Post;
      end;
    end
    else
    begin
      if rPrecio > mtPrecios.FieldByname('precio_maximo').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_maximo').AsFloat:= rPrecio;
        mtPrecios.Post;
      end
      else
      if rPrecio < mtPrecios.FieldByname('precio_minimo').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_minimo').AsFloat:= rPrecio;
        mtPrecios.Post;
      end;

      if APrecioFruta > mtPrecios.FieldByname('precio_fruta_max').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_fruta_max').AsFloat:= APrecioFruta;
        mtPrecios.Post;
      end
      else
      if APrecioFruta < mtPrecios.FieldByname('precio_fruta_min').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_fruta_min').AsFloat:= APrecioFruta;
        mtPrecios.Post;
      end;

      if APrecioTransporte > mtPrecios.FieldByname('precio_transporte_max').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_transporte_max').AsFloat:= APrecioTransporte;
        mtPrecios.Post;
      end
      else
      if APrecioTransporte < mtPrecios.FieldByname('precio_transporte_min').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_transporte_min').AsFloat:= APrecioTransporte;
        mtPrecios.Post;
      end;
    end;
  end
  else
  begin
    mtPrecios.Insert;
    mtPrecios.FieldByname('empresa_precio').AsString:= AEmpresa;
    mtPrecios.FieldByname('producto_precio').AsString:= AProducto;
    mtPrecios.FieldByname('proveedor_precio').AsString:= AProveedor;

    if APrevision then
    begin
      mtPrecios.FieldByname('precio_maximo').AsFloat:= 0;
      mtPrecios.FieldByname('precio_minimo').AsFloat:= 0;
      mtPrecios.FieldByname('precio_maximo_previsto').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_minimo_previsto').AsFloat:= rPrecio;


      mtPrecios.FieldByname('precio_fruta_max').AsFloat:= 0;
      mtPrecios.FieldByname('precio_fruta_min').AsFloat:= 0;
      mtPrecios.FieldByname('precio_fruta_max_previsto').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_fruta_min_previsto').AsFloat:= rPrecio;

      mtPrecios.FieldByname('precio_transporte_max').AsFloat:= 0;
      mtPrecios.FieldByname('precio_transporte_min').AsFloat:= 0;
      mtPrecios.FieldByname('precio_transporte_max_previsto').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_transporte_min_previsto').AsFloat:= rPrecio;
    end
    else
    begin
      mtPrecios.FieldByname('precio_maximo').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_minimo').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_maximo_previsto').AsFloat:= 0;
      mtPrecios.FieldByname('precio_minimo_previsto').AsFloat:= 0;

      mtPrecios.FieldByname('precio_fruta_max').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_fruta_min').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_fruta_max_previsto').AsFloat:= 0;
      mtPrecios.FieldByname('precio_fruta_min_previsto').AsFloat:= 0;

      mtPrecios.FieldByname('precio_transporte_max').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_transporte_min').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_transporte_max_previsto').AsFloat:= 0;
      mtPrecios.FieldByname('precio_transporte_min_previsto').AsFloat:= 0;
    end;
    mtPrecios.Post;
  end;
end;
*)

end.
