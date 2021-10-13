unit ParteProduccionDL;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDLParteProduccion = class(TDataModule)
    kmtListado: TkbmMemTable;
    qryAux: TQuery;
    qryAlmacen: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sProducto, sCentro: string;
    dFechaIni, dFechaFin: TDateTime;
    iTipo: Integer;

    function  GetProducto( const AEmpresa: string; const AProductoBase: integer  ): string;
    procedure NewRegistro( const AProducto: string );
    procedure CalculoMerma;

    function  SQLStockProveedor( const AFecha: TDateTime ): boolean;
    procedure SaveStockProveedor( const AIni: boolean );
    procedure AddStockProveedor( const AIni: boolean );

    function  SQLStockConfeccionado( const AFecha: TDateTime ): boolean;
    procedure SaveStockConfeccionadoProd( const AIni: boolean );
    procedure SaveStockConfeccionadoBase( const AIni: boolean );
    procedure AddStockConfeccionado( const AIni: boolean );

    function  SQLEntradasProveedorRF: boolean;
    procedure SaveEntradasProveedorRF;
    procedure AddEntradasProveedorRF;

    function  SQLEntradasTransitosRF: boolean;
    procedure SaveEntradasTransitosRF;
    procedure AddEntradasTransitosRF;

    function  SQLAlbaranesSalida: boolean;
    procedure SaveAlbaranesSalida;
    procedure AddAlbaranesSalida;

    function  SQLSalidasTransitos: boolean;
    procedure SaveSalidasTransitos;
    procedure AddSalidasTransitos;

  public
    { Public declarations }

    function  OpenDataReporte(const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer ): Boolean;
  end;

  function  OpenDataReporte(const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer ): Boolean;
  procedure CloseDataReporte;



implementation

{$R *.dfm}

uses
  UDMAuxDB, bMath, DateUtils, Variants;

var
  DLParteProduccion: TDLParteProduccion;

function OpenDataReporte( const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer ): Boolean;
begin
  DLParteProduccion:= TDLParteProduccion.Create( nil );
  result:= DLParteProduccion.OpenDataReporte(ABaseDatos, AEmpresa, AProducto, ACentro, AFechaIni, AFechaFin, ATipo );
end;

procedure CloseDataReporte;
begin
  FreeAndNil( DLParteProduccion );
end;

procedure TDLParteProduccion.DataModuleCreate(Sender: TObject);
begin
  with kmtListado do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('empresa', ftString, 3, False);
    FieldDefs.Add('centro', ftString, 3, False);
    FieldDefs.Add('producto', ftString, 3, False);

    FieldDefs.Add('stock_ini_proveedor', ftFloat, 0, False);
    FieldDefs.Add('stock_ini_confecionado', ftFloat, 0, False);
    FieldDefs.Add('stock_fin_proveedor', ftFloat, 0, False);
    FieldDefs.Add('stock_fin_confecionado', ftFloat, 0, False);
    FieldDefs.Add('entradas_proveedor', ftFloat, 0, False);
    FieldDefs.Add('entradas_transitos', ftFloat, 0, False);
    FieldDefs.Add('salidas', ftFloat, 0, False);
    FieldDefs.Add('transitos', ftFloat, 0, False);


    FieldDefs.Add('stock_ini_1', ftFloat, 0, False);
    FieldDefs.Add('stock_ini_2', ftFloat, 0, False);
    FieldDefs.Add('stock_ini_3', ftFloat, 0, False);
    FieldDefs.Add('stock_ini_4', ftFloat, 0, False);
    FieldDefs.Add('stock_fin_1', ftFloat, 0, False);
    FieldDefs.Add('stock_fin_2', ftFloat, 0, False);
    FieldDefs.Add('stock_fin_3', ftFloat, 0, False);
    FieldDefs.Add('stock_fin_4', ftFloat, 0, False);

    FieldDefs.Add('entradas_proveedor_1', ftFloat, 0, False);
    FieldDefs.Add('entradas_proveedor_2', ftFloat, 0, False);
    FieldDefs.Add('entradas_proveedor_3', ftFloat, 0, False);
    FieldDefs.Add('entradas_proveedor_4', ftFloat, 0, False);
    FieldDefs.Add('entradas_transitos_1', ftFloat, 0, False);
    FieldDefs.Add('entradas_transitos_2', ftFloat, 0, False);
    FieldDefs.Add('entradas_transitos_3', ftFloat, 0, False);
    FieldDefs.Add('entradas_transitos_4', ftFloat, 0, False);

    FieldDefs.Add('salidas_1', ftFloat, 0, False);
    FieldDefs.Add('salidas_2', ftFloat, 0, False);
    FieldDefs.Add('salidas_3', ftFloat, 0, False);
    FieldDefs.Add('salidas_4', ftFloat, 0, False);
    FieldDefs.Add('transitos_1', ftFloat, 0, False);
    FieldDefs.Add('transitos_2', ftFloat, 0, False);
    FieldDefs.Add('transitos_3', ftFloat, 0, False);
    FieldDefs.Add('transitos_4', ftFloat, 0, False);

    FieldDefs.Add('entradas_categoria_1', ftFloat, 0, False);
    FieldDefs.Add('entradas_categoria_2', ftFloat, 0, False);
    FieldDefs.Add('entradas_categoria_3', ftFloat, 0, False);
    FieldDefs.Add('entradas_categoria_4', ftFloat, 0, False);
    FieldDefs.Add('salidas_categoria_1', ftFloat, 0, False);
    FieldDefs.Add('salidas_categoria_2', ftFloat, 0, False);
    FieldDefs.Add('salidas_categoria_3', ftFloat, 0, False);
    FieldDefs.Add('salidas_categoria_4', ftFloat, 0, False);


    FieldDefs.Add('entradas_fruta', ftFloat, 0, False);
    FieldDefs.Add('salidas_fruta', ftFloat, 0, False);
    FieldDefs.Add('merma', ftFloat, 0, False);
    FieldDefs.Add('porcen_merma', ftFloat, 0, False);

    IndexFieldNames:= 'empresa;centro;producto';
    CreateTable;
    Open;
  end;
end;

procedure TDLParteProduccion.DataModuleDestroy(Sender: TObject);
begin
  kmtListado.Close;
end;

function TDLParteProduccion.OpenDataReporte(const ABaseDatos, AEmpresa, AProducto, ACentro: string;
                                                  const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer ): Boolean;
var
  bStockInicial: boolean;
begin
  iTipo:= ATipo;
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  sCentro:= ACentro;
  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;

  qryAux.DatabaseName:= ABaseDatos;
  qryAlmacen.DatabaseName:= ABaseDatos;

  try
    bStockInicial:= True;
    if SQLStockProveedor( IncDay( AFechaIni, -1 ) ) then
      SaveStockProveedor( bStockInicial );
  finally
    qryAlmacen.Close;
  end;
  try
    bStockInicial:= false;
    if SQLStockProveedor( AFechaFin ) then
      SaveStockProveedor( bStockInicial );
  finally
    qryAlmacen.Close;
  end;
  try
    bStockInicial:= True;
    if SQLStockConfeccionado( IncDay( AFechaIni, -1 ) ) then
    begin
      if iTipo = 0 then
        SaveStockConfeccionadoBase( bStockInicial )
      else
        SaveStockConfeccionadoProd( bStockInicial );
    end;
  finally
    qryAlmacen.Close;
  end;
  try
    bStockInicial:= false;
    if SQLStockConfeccionado( AFechaFin ) then
    begin
      if iTipo = 0 then
        SaveStockConfeccionadoBase( bStockInicial )
      else
        SaveStockConfeccionadoProd( bStockInicial );
    end;
  finally
    qryAlmacen.Close;
  end;
  try
    if SQLEntradasProveedorRF then
      SaveEntradasProveedorRF;
  finally
    qryAlmacen.Close;
  end;
  try
    if SQLEntradasTransitosRF then
      SaveEntradasTransitosRF;
  finally
    qryAlmacen.Close;
  end;
  try
    if SQLAlbaranesSalida then
      SaveAlbaranesSalida;
  finally
    qryAlmacen.Close;
  end;
  try
    if SQLSalidasTransitos then
      SaveSalidasTransitos;
  finally
    qryAlmacen.Close;
  end;

  CalculoMerma;
  kmtListado.SortFields:= 'empresa;centro;producto';
  kmtListado.Sort([]);
  kmtListado.First;
  result:= not kmtListado.isempty;
end;

procedure TDLParteProduccion.NewRegistro( const AProducto: string );
begin
    kmtListado.Insert;
    kmtListado.FieldByName('empresa').AsString:= qryAlmacen.FieldByName('empresa').AsString;
    kmtListado.FieldByName('producto').AsString:= AProducto;
    kmtListado.FieldByName('centro').AsString:= qryAlmacen.FieldByName('centro').AsString;

    kmtListado.FieldByName('stock_ini_proveedor').AsFloat:= 0;
    kmtListado.FieldByName('stock_ini_confecionado').AsFloat:= 0;
    kmtListado.FieldByName('stock_fin_proveedor').AsFloat:= 0;
    kmtListado.FieldByName('stock_fin_confecionado').AsFloat:= 0;
    kmtListado.FieldByName('entradas_proveedor').AsFloat:= 0;
    kmtListado.FieldByName('entradas_transitos').AsFloat:= 0;
    kmtListado.FieldByName('salidas').AsFloat:= 0;
    kmtListado.FieldByName('transitos').AsFloat:= 0;
    kmtListado.FieldByName('merma').AsFloat:= 0;
    kmtListado.FieldByName('porcen_merma').AsFloat:= 0;


    kmtListado.FieldByName('entradas_transitos_1').AsFloat:= 0;
    kmtListado.FieldByName('entradas_transitos_2').AsFloat:= 0;
    kmtListado.FieldByName('entradas_transitos_3').AsFloat:= 0;
    kmtListado.FieldByName('entradas_transitos_4').AsFloat:= 0;

    kmtListado.FieldByName('salidas_1').AsFloat:= 0;
    kmtListado.FieldByName('salidas_2').AsFloat:= 0;
    kmtListado.FieldByName('salidas_3').AsFloat:= 0;
    kmtListado.FieldByName('salidas_4').AsFloat:= 0;

    kmtListado.FieldByName('transitos_1').AsFloat:= 0;
    kmtListado.FieldByName('transitos_2').AsFloat:= 0;
    kmtListado.FieldByName('transitos_3').AsFloat:= 0;
    kmtListado.FieldByName('transitos_4').AsFloat:= 0;


    kmtListado.Post;
end;


function TDLParteProduccion.SQLStockProveedor( const AFecha: TDateTime ): boolean;
begin
  qryAlmacen.SQL.clear;
  if iTipo = 0 then
  begin
    qryAlmacen.SQL.Add('select empresa, centro, producto,  ');
    qryAlmacen.SQL.Add('       sum(cajas) cajas, sum(peso) peso ');
    qryAlmacen.SQL.Add('from rf_palet_pb ');
    qryAlmacen.SQL.Add('where status <> ''B'' ');
    qryAlmacen.SQL.Add('and status <> ''T'' ');
    qryAlmacen.SQL.Add('and empresa = :empresa ');
    if sCentro <> '' then
      qryAlmacen.SQL.Add('and centro = :centro ');

    qryAlmacen.SQL.Add('and ( ');
    qryAlmacen.SQL.Add('      ( status = ''S'' and date(fecha_alta) <= :fecha ) ');
    qryAlmacen.SQL.Add('       or ( date(fecha_alta) <= :fecha and date(fecha_status) > :fecha ');
    qryAlmacen.SQL.Add('            and status in (''C'',''V'',''R'',''D'') ) ');
    qryAlmacen.SQL.Add('    ) ');

    if sProducto <> '' then
      qryAlmacen.SQL.Add('and producto = :producto ');

    qryAlmacen.SQL.Add('group by empresa, centro, producto  ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');
  end
  else
  begin
    //qryAlmacen.SQL.Add('select empresa_ic empresa, centro_ic centro, producto_ic producto, ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    qryAlmacen.SQL.Add('select empresa_ic empresa, centro_ic centro, ( case when producto_ic = ''TOM'' then ''TOM'' else producto_ic end ) producto, ');
    qryAlmacen.SQL.Add('       sum(kilos_cec_ic+kilos_cim_c1_ic+kilos_cim_c2_ic+kilos_cia_c1_ic+kilos_cia_c2_ic+kilos_zd_c3_ic+kilos_zd_d_ic ) peso ');
    qryAlmacen.SQL.Add('from frf_inventarios_c ');
    qryAlmacen.SQL.Add('where empresa_ic = :empresa ');
    if sCentro <> '' then
      qryAlmacen.SQL.Add('and centro_ic = :centro ');
    if sProducto <> '' then
      //qryAlmacen.SQL.Add('and producto_ic = :producto ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      qryAlmacen.SQL.Add('and ( case when producto_ic = ''TOM'' then ''TOM'' else producto_ic end ) = :producto ');
    qryAlmacen.SQL.Add('and fecha_ic = :fecha ');
    qryAlmacen.SQL.Add('group by empresa, centro, producto ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');
  end;

  qryAlmacen.ParamByName('empresa').AsString:= sEmpresa;
  if sProducto <> '' then
    qryAlmacen.ParamByName('producto').AsString:= sProducto;
  if sCentro <> '' then
    qryAlmacen.ParamByName('centro').AsString:= sCentro;
  qryAlmacen.ParamByName('fecha').AsDateTime:= AFecha;
  qryAlmacen.Open;

  result:= not qryAlmacen.isEmpty;
end;


procedure TDLParteProduccion.SaveStockProveedor( const AIni: boolean );
begin
  qryAlmacen.First;
  while not qryAlmacen.eof do
  begin
    if not kmtlistado.Locate('empresa;centro;producto',
                        varArrayOf([qryAlmacen.FieldByName('empresa').AsString,
                                    qryAlmacen.FieldByName('centro').AsString,
                                    qryAlmacen.FieldByName('producto').AsString]), [] ) then

    begin
      NewRegistro( qryAlmacen.FieldByName('producto').AsString );
    end;
    AddStockProveedor( AIni );
    qryAlmacen.Next;
  end;
end;

procedure TDLParteProduccion.AddStockProveedor( const AIni: boolean );
begin
    kmtListado.Edit;
    if  AIni then
      kmtListado.FieldByName('stock_ini_proveedor').AsFloat:= kmtListado.FieldByName('stock_ini_proveedor').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat
    else
      kmtListado.FieldByName('stock_fin_proveedor').AsFloat:= kmtListado.FieldByName('stock_fin_proveedor').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.Post;
end;

function TDLParteProduccion.SQLStockConfeccionado( const AFecha: TDateTime ): boolean;
begin
  qryAlmacen.SQL.clear;
  if iTipo = 0 then
  begin
    qryAlmacen.SQL.Add('select empresa_cab empresa, centro_cab centro, ');
    qryAlmacen.SQl.Add('       producto_e producto1, ');
    qryAlmacen.SQL.Add('       ( select max( productop_e ) ');
    qryAlmacen.SQL.Add('         from frf_ean13 e13 where e13.empresa_e = empresa_cab and e13.codigo_e = ean13_det ) producto2, ');
    qryAlmacen.SQL.Add('       sum(unidades_det) cajas, sum(case when peso_det = 0 then peso_neto_e * unidades_det else peso_det end) peso ');

    qryAlmacen.SQL.Add('from rf_palet_pc_cab ');
    qryAlmacen.SQL.Add('     join rf_palet_pc_det on ean128_cab = ean128_det ');
    qryAlmacen.SQL.Add('     left join frf_envases env on env.envase_e = envase_det ');
    //IGNORAMOS BORRADOS
    qryAlmacen.SQL.Add('where status_cab <> ''B'' ');
    //IGNORAMOS VOLCADOS -> GENERAN OTROS QUE ESTARAN ES STOCK ');
    qryAlmacen.SQL.Add('and status_cab <> ''V'' ');
    qryAlmacen.SQL.Add('and empresa_cab = :empresa ');

    if sCentro <> '' then
      qryAlmacen.SQL.Add('and centro_cab = :centro ');
//    if iProducto <> -1 then
//    begin
    qryAlmacen.SQL.Add('and ( producto_e = :producto or ');
    qryAlmacen.SQL.Add('     ( select max(productop_e) from frf_ean13 e13 where e13.empresa_e = empresa_cab and e13.codigo_e = ean13_det ) = :producto ) ');
//    end;
    qryAlmacen.SQL.Add('and ( ');
    qryAlmacen.SQL.Add('      ( status_cab = ''S'' and date(fecha_alta_cab) <= :fecha ) ');
    qryAlmacen.SQL.Add('      or ');
    qryAlmacen.SQL.Add('      ( status_cab <> ''S'' and date(fecha_alta_cab) <= :fecha and date(fecha_carga_cab) > :fecha ) ');
    qryAlmacen.SQL.Add('    ) ');

    qryAlmacen.SQL.Add('group by empresa, centro, producto1, producto2 ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto1, producto2 ');

    qryAlmacen.ParamByName('empresa').AsString:= sEmpresa;
    if sProducto <> '' then
      qryAlmacen.ParamByName('producto').AsString:= sProducto;
    if sCentro <> '' then
      qryAlmacen.ParamByName('centro').AsString:= sCentro;
    qryAlmacen.ParamByName('fecha').AsDateTime:= AFecha;
    qryAlmacen.Open;

  end
  else
  begin
    //qryAlmacen.SQL.Add('select empresa_il empresa, centro_il centro, producto_il producto, ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    qryAlmacen.SQL.Add('select empresa_il empresa, centro_il centro, ( case when producto_il = ''TOM'' then ''TOM'' else producto_il end ) producto, ');
    qryAlmacen.SQL.Add('       sum(cajas_ce_c1_il+cajas_ce_c2_il) cajas, sum(kilos_ce_c1_il+kilos_ce_c2_il) peso ');
    qryAlmacen.SQL.Add('from frf_inventarios_l ');
    qryAlmacen.SQL.Add('where empresa_il = :empresa ');
    if sCentro <> '' then
      qryAlmacen.SQL.Add('and centro_il = :centro ');
    if sProducto <> '' then
      //qryAlmacen.SQL.Add('and producto_il = :producto ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      qryAlmacen.SQL.Add('and ( case when producto_il = ''TOM'' then ''TOM'' else producto_il end ) = :producto ');
    qryAlmacen.SQL.Add('and fecha_il = :fecha ');
    qryAlmacen.SQL.Add('group by empresa, centro, producto ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');

    qryAlmacen.ParamByName('empresa').AsString:= sEmpresa;
    if sProducto <> '' then
      qryAlmacen.ParamByName('producto').AsString:= sProducto;
    if sCentro <> '' then
      qryAlmacen.ParamByName('centro').AsString:= sCentro;
    qryAlmacen.ParamByName('fecha').AsDateTime:= AFecha;
    qryAlmacen.Open;

  end;


  result:= not qryAlmacen.isEmpty;
end;

function TDLParteProduccion.GetProducto( const AEmpresa: string; const AProductoBase: integer  ): string;
begin
  qryAux.sql.Clear;
  qryAux.sql.Add(' select producto_pb from frf_productos_base ');
  qryAux.sql.Add(' where empresa_pb = :empresa and producto_base_pb = :producto ');
  qryAux.sql.Add(' order by 1 ');
  qryAux.ParamByName('empresa').AsString:= AEmpresa;
  qryAux.ParamByName('producto').AsInteger:= AProductoBase;
  qryAux.Open;
  result:=  qryAux.FieldByName('producto_pb').AsString;
  qryAux.Close;
end;

procedure TDLParteProduccion.SaveStockConfeccionadoProd( const AIni: boolean );
begin
  qryAlmacen.First;
  while not qryAlmacen.eof do
  begin
    if not kmtlistado.Locate('empresa;centro;producto',
                        varArrayOf([qryAlmacen.FieldByName('empresa').AsString,
                                    qryAlmacen.FieldByName('centro').AsString,
                                    qryAlmacen.FieldByName('producto').AsString]), [] ) then

    begin
      NewRegistro( qryAlmacen.FieldByName('producto').AsString );
    end;
    AddStockConfeccionado( AIni );
    qryAlmacen.Next;
  end;
end;


procedure TDLParteProduccion.SaveStockConfeccionadoBase( const AIni: boolean );
var
  sProd, sProdAux: string;
begin
  qryAlmacen.First;
  sProdAux:='';
  while not qryAlmacen.eof do
  begin
    if qryAlmacen.FieldByName('producto1').Asstring <> '' then
      sProd:= qryAlmacen.FieldByName('producto1').AsString
    else
      sProd:= qryAlmacen.FieldByName('producto2').AsString;
    if sProdAux <> sProd then
    begin
      sProdAux:= sProd;
    end;


    if not kmtlistado.Locate('empresa;centro;producto',
                        varArrayOf([qryAlmacen.FieldByName('empresa').AsString,
                                    qryAlmacen.FieldByName('centro').AsString,
                                    sProdAux]), [] ) then

    begin
      NewRegistro( sProdAux );
    end;
    AddStockConfeccionado( AIni );
    qryAlmacen.Next;
  end;
end;

procedure TDLParteProduccion.AddStockConfeccionado( const AIni: boolean );
begin
    kmtListado.Edit;
    if  AIni then
      kmtListado.FieldByName('stock_ini_confecionado').AsFloat:= kmtListado.FieldByName('stock_ini_confecionado').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat
    else
      kmtListado.FieldByName('stock_fin_confecionado').AsFloat:= kmtListado.FieldByName('stock_fin_confecionado').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.Post;
end;


function TDLParteProduccion.SQLEntradasProveedorRF: boolean;
begin
  qryAlmacen.SQL.clear;
  if iTipo = 0 then
  begin
    //qryAlmacen.SQL.Add('select empresa, centro, producto, date(fecha_alta) fecha_ini, date(fecha_status) fecha_estado, ');
    //qryAlmacen.SQL.Add('       status, proveedor, variedad, sum(cajas) cajas, sum(peso) peso ');
    qryAlmacen.SQL.Add('select empresa, centro, producto, categoria,  ');
    qryAlmacen.SQL.Add('       sum(cajas) cajas, sum(peso) peso ');
    qryAlmacen.SQL.Add('from rf_palet_pb ');
    qryAlmacen.SQL.Add('where empresa = :empresa ');
    qryAlmacen.SQL.Add('and empresa = substr(entrega,1,3) ');
    if sCentro <> '' then
     qryAlmacen.SQL.Add('and centro = :centro ');

    qryAlmacen.SQL.Add('and date(fecha_alta) between :fechaIni and :fechaFin ');
    qryAlmacen.SQL.Add('and status in (''C'',''V'',''R'',''D'',''S'') ');

    if sProducto <> '' then
      qryAlmacen.SQL.Add('and producto = :producto ');

    //qryAlmacen.SQL.Add('group by empresa, centro, producto, fecha_ini, fecha_estado, status, proveedor, variedad ');
    //qryAlmacen.SQL.Add('order by empresa, centro, producto, fecha_ini, fecha_estado, status, proveedor, variedad ');
    qryAlmacen.SQL.Add('group by empresa, centro, producto, categoria  ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');
  end
  else
  begin
    //qryAlmacen.SQL.Add('select empresa_e2l empresa, centro_e2l centro, producto_e2l producto, ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    qryAlmacen.SQL.Add('select empresa_e2l empresa, centro_e2l centro, ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ) producto, ');
    qryAlmacen.SQL.Add('       porcen_primera_e primera, porcen_segunda_e segunda, porcen_tercera_e tercera, porcen_destrio_e destrio, ');
    qryAlmacen.SQL.Add('       sum(total_cajas_e2l) cajas, sum(total_kgs_e2l) peso ');
    qryAlmacen.SQL.Add('from frf_entradas2_l ');
    qryAlmacen.SQL.Add('     left join frf_escandallo on empresa_e = empresa_e2l and centro_e = centro_e2l ');
    qryAlmacen.SQL.Add('                              and numero_entrada_e = numero_entrada_e2l and fecha_e = fecha_e2l ');
    //qryAlmacen.SQL.Add('                              and producto_e = producto_e2l  ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    qryAlmacen.SQL.Add('                              and ( case when producto_e = ''TOM'' then ''TOM'' else producto_e end ) = ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end )  ');
    qryAlmacen.SQL.Add('                              and cosechero_e = cosechero_e2l and plantacion_e = plantacion_e2l and  anyo_Semana_e =  ano_Sem_planta_e2l ');
    qryAlmacen.SQL.Add('where empresa_e2l = :empresa ');
    if sCentro <> '' then
     qryAlmacen.SQL.Add('and centro_e2l = :centro ');
    if sProducto <> '' then
      //qryAlmacen.SQL.Add('and producto_e2l = :producto ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      qryAlmacen.SQL.Add('and ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ) = :producto ');
    qryAlmacen.SQL.Add('and fecha_e2l between :fechaini and :fechafin ');
    qryAlmacen.SQL.Add('group by empresa, centro, producto, primera, segunda, tercera, destrio ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');
  end;

  qryAlmacen.ParamByName('empresa').AsString:= sEmpresa;
  if sProducto <> '' then
    qryAlmacen.ParamByName('producto').AsString:= sProducto;
  if sCentro <> '' then
    qryAlmacen.ParamByName('centro').AsString:= sCentro;
  qryAlmacen.ParamByName('fechaIni').AsDateTime:= dFechaIni;
  qryAlmacen.ParamByName('fechaFin').AsDateTime:= dFechaFin;
  qryAlmacen.Open;

  result:= not qryAlmacen.isEmpty;
end;


procedure TDLParteProduccion.SaveEntradasProveedorRF;
begin
  qryAlmacen.First;
  while not qryAlmacen.eof do
  begin
    if not kmtlistado.Locate('empresa;centro;producto',
                        varArrayOf([qryAlmacen.FieldByName('empresa').AsString,
                                    qryAlmacen.FieldByName('centro').AsString,
                                    qryAlmacen.FieldByName('producto').AsString]), [] ) then

    begin
      NewRegistro( qryAlmacen.FieldByName('producto').AsString );
    end;
    AddEntradasProveedorRF;
    qryAlmacen.Next;
  end;
end;

procedure TDLParteProduccion.AddEntradasProveedorRF;
var
  rAux, rAcum: real;
begin
  kmtListado.Edit;
  kmtListado.FieldByName('entradas_proveedor').AsFloat:= kmtListado.FieldByName('entradas_proveedor').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
  if iTipo = 0 then
  begin
    if qryAlmacen.FieldByName('categoria').Asstring = '1' then
    begin
      kmtListado.FieldByName('entradas_proveedor_1').AsFloat:= kmtListado.FieldByName('entradas_proveedor_1').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
      kmtListado.FieldByName('entradas_categoria_1').AsFloat:= kmtListado.FieldByName('entradas_categoria_1').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    end
    else
    if qryAlmacen.FieldByName('categoria').Asstring = '2' then
    begin
      kmtListado.FieldByName('entradas_proveedor_2').AsFloat:= kmtListado.FieldByName('entradas_proveedor_2').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
      kmtListado.FieldByName('entradas_categoria_2').AsFloat:= kmtListado.FieldByName('entradas_categoria_2').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    end
    else
    if qryAlmacen.FieldByName('categoria').Asstring = '3' then
    begin
      kmtListado.FieldByName('entradas_proveedor_3').AsFloat:= kmtListado.FieldByName('entradas_proveedor_3').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
      kmtListado.FieldByName('entradas_categoria_3').AsFloat:= kmtListado.FieldByName('entradas_categoria_3').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    end
    else
    begin
      kmtListado.FieldByName('entradas_proveedor_4').AsFloat:= kmtListado.FieldByName('entradas_proveedor_4').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
      kmtListado.FieldByName('entradas_categoria_4').AsFloat:= kmtListado.FieldByName('entradas_categoria_4').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    end;
  end
  else
  begin
    rAux:=  qryAlmacen.FieldByName('primera').AsFloat + qryAlmacen.FieldByName('segunda').AsFloat +
            qryAlmacen.FieldByName('tercera').AsFloat + qryAlmacen.FieldByName('destrio').AsFloat;
    if rAux = 0 then
    begin
      kmtListado.FieldByName('entradas_proveedor_1').AsFloat:= kmtListado.FieldByName('entradas_proveedor_1').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
      kmtListado.FieldByName('entradas_categoria_1').AsFloat:= kmtListado.FieldByName('entradas_categoria_1').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    end
    else
    begin
      rAux:= bRoundTo( ( qryAlmacen.FieldByName('peso').AsFloat * qryAlmacen.FieldByName('primera').AsFloat ) / 100, -2);
      rAcum:= rAux;
      kmtListado.FieldByName('entradas_proveedor_1').AsFloat:= kmtListado.FieldByName('entradas_proveedor_1').AsFloat + rAux;
      kmtListado.FieldByName('entradas_categoria_1').AsFloat:= kmtListado.FieldByName('entradas_categoria_1').AsFloat + rAux;
      rAux:= bRoundTo( ( qryAlmacen.FieldByName('peso').AsFloat * qryAlmacen.FieldByName('segunda').AsFloat ) / 100, -2);
      rAcum:= rAcum + rAux;
      kmtListado.FieldByName('entradas_proveedor_2').AsFloat:= kmtListado.FieldByName('entradas_proveedor_2').AsFloat + rAux;
      kmtListado.FieldByName('entradas_categoria_2').AsFloat:= kmtListado.FieldByName('entradas_categoria_2').AsFloat + rAux;
      rAux:= bRoundTo( ( qryAlmacen.FieldByName('peso').AsFloat * qryAlmacen.FieldByName('tercera').AsFloat ) / 100, -2);
      rAcum:= rAcum + rAux;
      kmtListado.FieldByName('entradas_proveedor_3').AsFloat:= kmtListado.FieldByName('entradas_proveedor_3').AsFloat + rAux;
      kmtListado.FieldByName('entradas_categoria_3').AsFloat:= kmtListado.FieldByName('entradas_categoria_3').AsFloat + rAux;
      rAux:= qryAlmacen.FieldByName('peso').AsFloat - rAcum;
      kmtListado.FieldByName('entradas_proveedor_4').AsFloat:= kmtListado.FieldByName('entradas_proveedor_4').AsFloat + rAux;
      kmtListado.FieldByName('entradas_categoria_4').AsFloat:= kmtListado.FieldByName('entradas_categoria_4').AsFloat + rAux;
    end;
  end;

  kmtListado.Post;
end;

function TDLParteProduccion.SQLEntradasTransitosRF: boolean;
begin
  qryAlmacen.SQL.clear;
  if iTipo = 0 then
  begin
    //qryAlmacen.SQL.Add('select empresa, centro, producto, date(fecha_alta) fecha_ini, date(fecha_status) fecha_estado, ');
    //qryAlmacen.SQL.Add('       status, proveedor, variedad, sum(cajas) cajas, sum(peso) peso ');
    qryAlmacen.SQL.Add('select empresa, centro, producto, categoria,  ');
    qryAlmacen.SQL.Add('       sum(cajas) cajas, sum(peso) peso ');
    qryAlmacen.SQL.Add('from rf_palet_pb ');
    qryAlmacen.SQL.Add('where empresa = :empresa ');
    qryAlmacen.SQL.Add('and empresa <> substr(entrega,1,3) ');
    if sCentro <> '' then
      qryAlmacen.SQL.Add('and centro = :centro ');

    qryAlmacen.SQL.Add('and date(fecha_alta) between :fechaIni and :fechaFin ');
    qryAlmacen.SQL.Add('and status in (''C'',''V'',''R'',''D'',''S'') ');

    if sProducto <> '' then
      qryAlmacen.SQL.Add('and producto = :producto ');

    //qryAlmacen.SQL.Add('group by empresa, centro, producto, fecha_ini, fecha_estado, status, proveedor, variedad ');
    //qryAlmacen.SQL.Add('order by empresa, centro, producto, fecha_ini, fecha_estado, status, proveedor, variedad ');
    qryAlmacen.SQL.Add('group by empresa, centro, producto, categoria  ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');
  end
  else
  begin
    //qryAlmacen.SQL.Add('select empresa_tl empresa, centro_destino_tl centro, producto_tl producto, categoria_tl categoria, ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    qryAlmacen.SQL.Add('select empresa_tl empresa, centro_destino_tl centro, ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) producto, categoria_tl categoria, ');
    qryAlmacen.SQL.Add('       sum(cajas_tl) cajas, sum(kilos_tl) peso ');
    qryAlmacen.SQL.Add('from frf_transitos_c ');
    qryAlmacen.SQL.Add('     join frf_transitos_l on empresa_tl = empresa_tc and centro_tl = centro_tc ');
    qryAlmacen.SQL.Add('                          and referencia_tl = referencia_tc and fecha_tc = fecha_tl ');
    qryAlmacen.SQL.Add('where empresa_tc = :empresa ');
    qryAlmacen.SQL.Add('and fecha_entrada_tc between :fechaini and :fechafin ');
    if sCentro <> '' then
    qryAlmacen.SQL.Add('and centro_destino_tc = :centro ');
    if sProducto <> '' then
      //qryAlmacen.SQL.Add('and producto_tl = :producto ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      qryAlmacen.SQL.Add('and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto ');

    qryAlmacen.SQL.Add('group by empresa, centro, producto, categoria ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');
  end;

  qryAlmacen.ParamByName('empresa').AsString:= sEmpresa;
  if sProducto <> '' then
    qryAlmacen.ParamByName('producto').AsString:= sProducto;
  if sCentro <> '' then
    qryAlmacen.ParamByName('centro').AsString:= sCentro;
  qryAlmacen.ParamByName('fechaIni').AsDateTime:= dFechaIni;
  qryAlmacen.ParamByName('fechaFin').AsDateTime:= dFechaFin;
  qryAlmacen.Open;

  result:= not qryAlmacen.isEmpty;
end;


procedure TDLParteProduccion.SaveEntradasTransitosRF;
begin
  qryAlmacen.First;
  while not qryAlmacen.eof do
  begin
    if not kmtlistado.Locate('empresa;centro;producto',
                        varArrayOf([qryAlmacen.FieldByName('empresa').AsString,
                                    qryAlmacen.FieldByName('centro').AsString,
                                    qryAlmacen.FieldByName('producto').AsString]), [] ) then

    begin
      NewRegistro( qryAlmacen.FieldByName('producto').AsString );
    end;
    AddEntradasTransitosRF;
    qryAlmacen.Next;
  end;
end;

procedure TDLParteProduccion.AddEntradasTransitosRF;
begin
  kmtListado.Edit;
  kmtListado.FieldByName('entradas_transitos').AsFloat:= kmtListado.FieldByName('entradas_transitos').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;

  if qryAlmacen.FieldByName('categoria').Asstring = '1' then
  begin
    kmtListado.FieldByName('entradas_transitos_1').AsFloat:= kmtListado.FieldByName('entradas_transitos_1').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('entradas_categoria_1').AsFloat:= kmtListado.FieldByName('entradas_categoria_1').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end
  else
  if qryAlmacen.FieldByName('categoria').Asstring = '2' then
  begin
    kmtListado.FieldByName('entradas_transitos_2').AsFloat:= kmtListado.FieldByName('entradas_transitos_2').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('entradas_categoria_2').AsFloat:= kmtListado.FieldByName('entradas_categoria_2').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end
  else
  if qryAlmacen.FieldByName('categoria').Asstring = '3' then
  begin
    kmtListado.FieldByName('entradas_transitos_3').AsFloat:= kmtListado.FieldByName('entradas_transitos_3').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('entradas_categoria_3').AsFloat:= kmtListado.FieldByName('entradas_categoria_3').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end
  else
  begin
    kmtListado.FieldByName('entradas_transitos_4').AsFloat:= kmtListado.FieldByName('entradas_transitos_4').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('entradas_categoria_4').AsFloat:= kmtListado.FieldByName('entradas_categoria_4').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end;

  kmtListado.Post;
end;

function  TDLParteProduccion.SQLAlbaranesSalida: boolean;
begin
  qryAlmacen.SQL.clear;
  //qryAlmacen.SQL.Add('select empresa_sl empresa, centro_salida_sl centro, producto_sl producto, categoria_sl categoria, ');
  //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
  qryAlmacen.SQL.Add('select empresa_sl empresa, centro_salida_sl centro, producto_sl producto, categoria_sl categoria, ');
  qryAlmacen.SQL.Add('       sum(cajas_sl) cajas, sum(kilos_sl) peso ');
  qryAlmacen.SQL.Add('from frf_salidas_l, frf_salidas_c ');
  qryAlmacen.SQL.Add('where empresa_sl = :empresa ');
  qryAlmacen.SQL.Add('and fecha_sl between :fechaIni and :fechaFin ');

  if sCentro <> '' then
    qryAlmacen.SQL.Add('and centro_salida_sl = :centro ');

  if sProducto <> '' then
    qryAlmacen.SQL.Add('and producto_sl = :producto ');

  qryAlmacen.SQL.Add('  and empresa_sc = empresa_sl   ');
  qryAlmacen.SQL.Add('  and centro_salida_sc = centro_salida_sl  ');
  qryAlmacen.SQL.Add('  and n_albaran_sc = n_albaran_sl          ');
  qryAlmacen.SQL.Add('  and fecha_sc = fecha_sl                  ');
  qryAlmacen.SQL.Add('  and es_transito_sc <> 2 ');
  qryAlmacen.SQL.Add('group by empresa, centro, producto, categoria ');

  qryAlmacen.SQL.Add(' union  ');

  qryAlmacen.SQL.Add(' select empresa_sl empresa, centro_salida_sl centro, producto_desglose_sl2 producto, categoria_sl categoria,  ');
  qryAlmacen.SQL.Add('        sum(cajas_sl), sum(kilos_desglose_sl2) peso                                                           ');
  qryAlmacen.SQL.Add(' from frf_salidas_l2, frf_salidas_l, frf_salidas_c                                                            ');
  qryAlmacen.SQL.Add(' where empresa_sl = :empresa                                                                                  ');
  qryAlmacen.SQL.Add('   and fecha_sl between :fechaIni and :fechaFin                                                               ');

  if sCentro <> '' then
    qryAlmacen.SQL.Add('and centro_salida_sl = :centro ');

  if sProducto <> '' then
    qryAlmacen.SQL.Add('and producto_desglose_sl2 = :producto ');

  qryAlmacen.SQL.Add('   and empresa_sc = empresa_sl                    ');
  qryAlmacen.SQL.Add('   and centro_salida_sc = centro_salida_sl        ');
  qryAlmacen.SQL.Add('   and n_albaran_sc = n_albaran_sl                ');
  qryAlmacen.SQL.Add('   and fecha_sc = fecha_sl                        ');
  qryAlmacen.SQL.Add('   and es_transito_sc <> 2                        ');
  qryAlmacen.SQL.Add('   and empresa_sl = empresa_sl2                   ');
  qryAlmacen.SQL.Add('   and centro_salida_sl = centro_salida_sl2       ');
  qryAlmacen.SQL.Add('   and fecha_sl = fecha_sl2                       ');
  qryAlmacen.SQL.Add('   and n_albaran_sl = n_albaran_sl2               ');
  qryAlmacen.SQL.Add('   and id_linea_albaran_sl = id_linea_albaran_sl2 ');
  qryAlmacen.SQL.Add('group by empresa, centro, producto, categoria ');

  qryAlmacen.SQL.Add('order by empresa, centro, producto ');

  qryAlmacen.ParamByName('empresa').AsString:= sEmpresa;
  if sProducto <> '' then
    qryAlmacen.ParamByName('producto').AsString:= sProducto;
  if sCentro <> '' then
    qryAlmacen.ParamByName('centro').AsString:= sCentro;
  qryAlmacen.ParamByName('fechaIni').AsDateTime:= dFechaIni;
  qryAlmacen.ParamByName('fechaFin').AsDateTime:= dFechaFin;
  qryAlmacen.Open;

  result:= not qryAlmacen.isEmpty;
end;

procedure TDLParteProduccion.SaveAlbaranesSalida;
begin
  qryAlmacen.First;
  while not qryAlmacen.eof do
  begin
    if not kmtlistado.Locate('empresa;centro;producto',
                        varArrayOf([qryAlmacen.FieldByName('empresa').AsString,
                                    qryAlmacen.FieldByName('centro').AsString,
                                    qryAlmacen.FieldByName('producto').AsString]), [] ) then

    begin
      NewRegistro( qryAlmacen.FieldByName('producto').AsString );
    end;
    AddAlbaranesSalida;
    qryAlmacen.Next;
  end;
end;

procedure TDLParteProduccion.AddAlbaranesSalida;
begin
  kmtListado.Edit;
  kmtListado.FieldByName('salidas').AsFloat:= kmtListado.FieldByName('salidas').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;
  if qryAlmacen.FieldByName('categoria').Asstring = '1' then
  begin
    kmtListado.FieldByName('salidas_1').AsFloat:= kmtListado.FieldByName('salidas_1').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('salidas_categoria_1').AsFloat:= kmtListado.FieldByName('salidas_categoria_1').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end
  else
  if qryAlmacen.FieldByName('categoria').Asstring = '2' then
  begin
    kmtListado.FieldByName('salidas_2').AsFloat:= kmtListado.FieldByName('salidas_2').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('salidas_categoria_2').AsFloat:= kmtListado.FieldByName('salidas_categoria_2').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end
  else
  if qryAlmacen.FieldByName('categoria').Asstring = '3' then
  begin
    kmtListado.FieldByName('salidas_3').AsFloat:= kmtListado.FieldByName('salidas_3').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('salidas_categoria_3').AsFloat:= kmtListado.FieldByName('salidas_categoria_3').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end
  else
  begin
    kmtListado.FieldByName('salidas_4').AsFloat:= kmtListado.FieldByName('salidas_4').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('salidas_categoria_4').AsFloat:= kmtListado.FieldByName('salidas_categoria_4').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end;
  kmtListado.Post;
end;

function  TDLParteProduccion.SQLSalidasTransitos: boolean;
begin
  qryAlmacen.SQL.clear;
  //qryAlmacen.SQL.Add('select empresa_tl empresa, centro_tl centro, producto_tl producto, categoria_tl categoria, ');
  //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
  qryAlmacen.SQL.Add('select empresa_tl empresa, centro_tl centro, ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) producto, categoria_tl categoria, ');
  qryAlmacen.SQL.Add('       sum(cajas_tl) cajas, sum(kilos_tl) peso ');
    qryAlmacen.SQL.Add('from frf_transitos_c ');
    qryAlmacen.SQL.Add('     join frf_transitos_l on empresa_tl = empresa_tc and centro_tl = centro_tc ');
    qryAlmacen.SQL.Add('                          and referencia_tl = referencia_tc and fecha_tc = fecha_tl ');
    qryAlmacen.SQL.Add('where empresa_tc = :empresa ');
    qryAlmacen.SQL.Add('and fecha_tc between :fechaini and :fechafin ');
    if sCentro <> '' then
      qryAlmacen.SQL.Add('and centro_tc = :centro ');
    if sProducto <> '' then
      //qryAlmacen.SQL.Add('and producto_tl = :producto ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      qryAlmacen.SQL.Add('and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto ');

    qryAlmacen.SQL.Add('group by empresa, centro, producto, categoria ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');

  qryAlmacen.ParamByName('empresa').AsString:= sEmpresa;
  if sProducto <> '' then
    qryAlmacen.ParamByName('producto').AsString:= sProducto;
  if sCentro <> '' then
    qryAlmacen.ParamByName('centro').AsString:= sCentro;
  qryAlmacen.ParamByName('fechaIni').AsDateTime:= dFechaIni;
  qryAlmacen.ParamByName('fechaFin').AsDateTime:= dFechaFin;
  qryAlmacen.Open;

  result:= not qryAlmacen.isEmpty;
end;

procedure TDLParteProduccion.SaveSalidasTransitos;
begin
  qryAlmacen.First;
  while not qryAlmacen.eof do
  begin
    if not kmtlistado.Locate('empresa;centro;producto',
                        varArrayOf([qryAlmacen.FieldByName('empresa').AsString,
                                    qryAlmacen.FieldByName('centro').AsString,
                                    qryAlmacen.FieldByName('producto').AsString]), [] ) then

    begin
      NewRegistro( qryAlmacen.FieldByName('producto').AsString );
    end;
    AddSalidasTransitos;
    qryAlmacen.Next;
  end;
end;

procedure TDLParteProduccion.AddSalidasTransitos;
begin
  kmtListado.Edit;
  kmtListado.FieldByName('transitos').AsFloat:= kmtListado.FieldByName('transitos').AsFloat +
                                                            qryAlmacen.FieldByName('peso').AsFloat;

  if qryAlmacen.FieldByName('categoria').Asstring = '1' then
  begin
    kmtListado.FieldByName('transitos_1').AsFloat:= kmtListado.FieldByName('transitos_1').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('salidas_categoria_1').AsFloat:= kmtListado.FieldByName('salidas_categoria_1').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end
  else
  if qryAlmacen.FieldByName('categoria').Asstring = '2' then
  begin
    kmtListado.FieldByName('transitos_2').AsFloat:= kmtListado.FieldByName('transitos_2').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('salidas_categoria_2').AsFloat:= kmtListado.FieldByName('salidas_categoria_2').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end
  else
  if qryAlmacen.FieldByName('categoria').Asstring = '3' then
  begin
    kmtListado.FieldByName('transitos_3').AsFloat:= kmtListado.FieldByName('transitos_3').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('salidas_categoria_3').AsFloat:= kmtListado.FieldByName('salidas_categoria_3').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end
  else
  begin
    kmtListado.FieldByName('transitos_4').AsFloat:= kmtListado.FieldByName('transitos_4').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
    kmtListado.FieldByName('salidas_categoria_4').AsFloat:= kmtListado.FieldByName('salidas_categoria_4').AsFloat +
                                                              qryAlmacen.FieldByName('peso').AsFloat;
  end;
  kmtListado.Post;
end;

procedure TDLParteProduccion.CalculoMerma;
var
  rIni, rFin, rProcesados, rMerma, rPorcen: real;
begin
  kmtListado.First;
  while not kmtListado.Eof do
  begin
    rIni:= kmtListado.FieldByName('stock_ini_proveedor').AsFloat+kmtListado.FieldByName('stock_ini_confecionado').AsFloat+
         kmtListado.FieldByName('entradas_proveedor').AsFloat+kmtListado.FieldByName('entradas_transitos').AsFloat;
    rFin:= kmtListado.FieldByName('stock_fin_proveedor').AsFloat+kmtListado.FieldByName('stock_fin_confecionado').AsFloat+
         kmtListado.FieldByName('salidas').AsFloat+kmtListado.FieldByName('transitos').AsFloat;
    rProcesados:= rIni - ( kmtListado.FieldByName('stock_fin_proveedor').AsFloat+kmtListado.FieldByName('stock_fin_confecionado').AsFloat );
    rMerma:= rIni - rFin;

    if rProcesados > 0 then
    begin
      rPorcen:= (rMerma/rProcesados) * 100;
    end
    else
    begin
      rPorcen:= 0;
    end;

    kmtListado.Edit;
    kmtListado.FieldByName('merma').AsFloat:= rMerma;
    kmtListado.FieldByName('porcen_merma').AsFloat:= rPorcen;
    kmtListado.FieldByName('entradas_fruta').AsFloat:= rIni;
    kmtListado.FieldByName('salidas_fruta').AsFloat:= rFin;

    kmtListado.Post;

    kmtListado.Next;
  end;
end;

end.
