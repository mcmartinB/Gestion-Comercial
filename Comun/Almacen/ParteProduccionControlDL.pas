unit ParteProduccionControlDL;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDLParteProduccionControl = class(TDataModule)
    qryAlmacen: TQuery;
    qryAux: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sProducto, sCentro: string;
    dFechaIni, dFechaFin: TDateTime;
    iTipo: Integer;
    rMax: Real;

    function  GetProducto( const AEmpresa: string; const AProductoBase: integer  ): string;
    //procedure NewRegistro( const AProducto: string );
    //procedure SaveStockProveedor( const AIni: boolean );
    //procedure AddStockProveedor( const AIni: boolean );

    function  SQLStockProveedor( const AFecha: TDateTime ): boolean;
    function  SQLStockConfeccionado( const AFecha: TDateTime ): boolean;
    function  SQLEntradasProveedorRF: boolean;
    function  SQLEntradasTransitosRF: boolean;
    function  SQLAlbaranesSalida: boolean;
    function  SQLSalidasTransitos: boolean;

  public
    { Public declarations }

    function  OpenDataStockProv(const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFecha: TDateTime; const ATipo: Integer ): Boolean;
    function  OpenDataStockConf(const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFecha: TDateTime; const ATipo: Integer ): Boolean;
  end;

  function  OpenDataStockProv(const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFecha: TDateTime; const ATipo: Integer ): Boolean;
  function  OpenDataStockConf(const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFecha: TDateTime; const ATipo: Integer ): Boolean;
  procedure CloseDataReporte;



implementation

{$R *.dfm}

uses
  UDMAuxDB, bMath, DateUtils, Variants;

var
  DLParteProduccionControl: TDLParteProduccionControl;

function OpenDataStockProv( const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFecha: TDateTime; const ATipo: Integer ): Boolean;
begin
  DLParteProduccionControl:= TDLParteProduccionControl.Create( nil );
  result:= DLParteProduccionControl.OpenDataStockProv(ABaseDatos, AEmpresa, AProducto, ACentro, AFecha, ATipo );
end;

function OpenDataStockConf( const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFecha: TDateTime; const ATipo: Integer ): Boolean;
begin
  DLParteProduccionControl:= TDLParteProduccionControl.Create( nil );
  result:= DLParteProduccionControl.OpenDataStockConf(ABaseDatos, AEmpresa, AProducto, ACentro, AFecha, ATipo );
end;

procedure CloseDataReporte;
begin
  FreeAndNil( DLParteProduccionControl );
end;

procedure TDLParteProduccionControl.DataModuleCreate(Sender: TObject);
begin
  (*
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


    FieldDefs.Add('entradas_fruta', ftFloat, 0, False);
    FieldDefs.Add('salidas_fruta', ftFloat, 0, False);
    FieldDefs.Add('merma', ftFloat, 0, False);
    FieldDefs.Add('porcen_merma', ftFloat, 0, False);

    IndexFieldNames:= 'empresa;centro;producto';
    CreateTable;
    Open;
  end;
  *)
end;

procedure TDLParteProduccionControl.DataModuleDestroy(Sender: TObject);
begin
  qryAlmacen.Close;
  //kmtListado.Close;
end;

function TDLParteProduccionControl.OpenDataStockProv(const ABaseDatos, AEmpresa, AProducto, ACentro: string;
                                                  const AFecha: TDateTime; const ATipo: Integer ): Boolean;
var
  bStockInicial: boolean;
begin
  iTipo:= ATipo;
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  sCentro:= ACentro;
  dFechaIni:= AFecha;
  dFechaFin:= AFecha;

  qryAlmacen.DatabaseName:= ABaseDatos;
  qryAux.DatabaseName:= ABaseDatos;

  result:= SQLStockProveedor( AFecha );
end;

function TDLParteProduccionControl.OpenDataStockConf(const ABaseDatos, AEmpresa, AProducto, ACentro: string;
                                                  const AFecha: TDateTime; const ATipo: Integer ): Boolean;
var
  bStockInicial: boolean;
begin
  iTipo:= ATipo;
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  sCentro:= ACentro;
  dFechaIni:= AFecha;
  dFechaFin:= AFecha;

  qryAlmacen.DatabaseName:= ABaseDatos;
  qryAux.DatabaseName:= ABaseDatos;

  result:= SQLStockProveedor( AFecha );
end;

(*
procedure TDLParteProduccionControl.NewRegistro( const AProducto: string );
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
    kmtListado.Post;
end;

procedure TDLParteProduccionControl.SaveStockProveedor( const AIni: boolean );
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

procedure TDLParteProduccionControl.AddStockProveedor( const AIni: boolean );
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
*)

function TDLParteProduccionControl.SQLStockProveedor( const AFecha: TDateTime ): boolean;
begin
  qryAlmacen.SQL.clear;
  if iTipo = 0 then
  begin
    //qryAlmacen.SQL.Add('select empresa, centro, producto, date(fecha_alta) fecha_ini, date(fecha_status) fecha_estado,  ');
    //qryAlmacen.SQL.Add('       status, proveedor, variedad, sum(cajas) cajas, sum(peso) peso, sum(peso_bruto) bruto');
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

    //qryAlmacen.SQL.Add('group by empresa, centro, producto, fecha_ini, fecha_estado, status, proveedor, variedad ');
    //qryAlmacen.SQL.Add('order by empresa, centro, producto, fecha_ini, fecha_estado, status, proveedor, variedad');
    qryAlmacen.SQL.Add('group by empresa, centro, producto  ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');
  end
  else
  begin
    qryAlmacen.SQL.Add('select empresa_ic empresa, centro_ic centro, producto_ic producto, ');
    qryAlmacen.SQL.Add('       sum(kilos_cec_ic+kilos_cim_c1_ic+kilos_cim_c2_ic+kilos_cia_c1_ic+kilos_cia_c2_ic+kilos_zd_c3_ic+kilos_zd_d_ic ) peso ');
    qryAlmacen.SQL.Add('from frf_inventarios_c ');
    qryAlmacen.SQL.Add('where empresa_ic = :empresa ');
    if sCentro <> '' then
      qryAlmacen.SQL.Add('and centro_ic = :centro ');
    if sProducto <> '' then
      qryAlmacen.SQL.Add('and producto_ic = :producto ');
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


function TDLParteProduccionControl.SQLStockConfeccionado( const AFecha: TDateTime ): boolean;
var
  iProducto: integer;
begin
  qryAlmacen.SQL.clear;
  if iTipo = 0 then
  begin
    if sProducto <> '' then
    begin
      qryAlmacen.SQL.Add('select producto_base_p from frf_productos ');
      qryAlmacen.SQL.Add('where producto_p = :producto ');
      qryAlmacen.ParamByName('producto').AsString:= sProducto;
      qryAlmacen.Open;
      iProducto:= qryAlmacen.FieldByName('producto_base_p').AsInteger;
      qryAlmacen.Close;
    end
    else
    begin
      iProducto:= -1;
    end;
    qryAlmacen.SQL.clear;
    qryAlmacen.SQL.Add('select empresa_cab empresa, centro_cab centro, nvl(producto_e, '') producto1, ');
    qryAlmacen.SQL.Add('       ( select max( productop_e ) ');
    qryAlmacen.SQL.Add('         from frf_ean13 e13 where e13.empresa_e = empresa_cab and e13.codigo_e = ean13_det ) producto2, ');
    qryAlmacen.SQL.Add('       sum(unidades_det) cajas, sum(peso_det) peso ');

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
    if iProducto <> -1 then
    begin
      qryAlmacen.SQL.Add('and ( producto_e = :producto or ');
      qryAlmacen.SQL.Add('     ( select max(productop_e) from frf_ean13 e13 where e13.empresa_e = empresa_cab and e13.codigo_e = ean13_det ) = :producto ) ');
    end;
    qryAlmacen.SQL.Add('and ( ');
    qryAlmacen.SQL.Add('      ( status_cab = ''S'' and date(fecha_alta_cab) <= :fecha ) ');
    qryAlmacen.SQL.Add('      or ');
    qryAlmacen.SQL.Add('      ( status_cab <> ''S'' and date(fecha_alta_cab) <= :fecha and date(fecha_carga_cab) > :fecha ) ');
    qryAlmacen.SQL.Add('    ) ');

    qryAlmacen.SQL.Add('group by empresa, centro, producto1, producto2 ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto1, producto2 ');
  end
  else
  begin
    qryAlmacen.SQL.Add('select empresa_il empresa, centro_il centro, producto_il producto, ');
    qryAlmacen.SQL.Add('       sum(cajas_ce_c1_il+cajas_ce_c1_il) cajas, sum(kilos_ce_c1_il+kilos_ce_c1_il) peso ');
    qryAlmacen.SQL.Add('from frf_inventarios_l ');
    qryAlmacen.SQL.Add('where empresa_il = :empresa ');
    if sCentro <> '' then
      qryAlmacen.SQL.Add('and centro_il = :centro ');
    if sProducto <> '' then
      qryAlmacen.SQL.Add('and producto_il = :producto ');
    qryAlmacen.SQL.Add('and fecha_il = :fecha ');
    qryAlmacen.SQL.Add('group by empresa, centro, producto ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');
  end;

  qryAlmacen.ParamByName('empresa').AsString:= sEmpresa;
  if iProducto <> -1 then
    qryAlmacen.ParamByName('producto').AsInteger:= iProducto;
  if sCentro <> '' then
    qryAlmacen.ParamByName('centro').AsString:= sCentro;
  qryAlmacen.ParamByName('fecha').AsDateTime:= AFecha;
  qryAlmacen.Open;

  result:= not qryAlmacen.isEmpty;
end;

function TDLParteProduccionControl.GetProducto( const AEmpresa: string; const AProductoBase: integer  ): string;
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


function TDLParteProduccionControl.SQLEntradasProveedorRF: boolean;
begin
  qryAlmacen.SQL.clear;
  if iTipo = 0 then
  begin
    //qryAlmacen.SQL.Add('select empresa, centro, producto, date(fecha_alta) fecha_ini, date(fecha_status) fecha_estado, ');
    //qryAlmacen.SQL.Add('       status, proveedor, variedad, sum(cajas) cajas, sum(peso) peso ');
    qryAlmacen.SQL.Add('select empresa, centro, producto,  ');
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
    qryAlmacen.SQL.Add('group by empresa, centro, producto  ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');
  end
  else
  begin
    qryAlmacen.SQL.Add('select empresa_e2l empresa, centro_e2l centro, producto_e2l producto, ');
    qryAlmacen.SQL.Add('       sum(total_cajas_e2l) cajas, sum(total_kgs_e2l) peso ');
    qryAlmacen.SQL.Add('from frf_entradas2_l ');
    qryAlmacen.SQL.Add('where empresa_e2l = :empresa ');
    if sCentro <> '' then
     qryAlmacen.SQL.Add('and centro_e2l = :centro ');
    if sProducto <> '' then
      qryAlmacen.SQL.Add('and producto_e2l = :producto ');
    qryAlmacen.SQL.Add('and fecha_e2l between :fechaini and :fechafin ');
    qryAlmacen.SQL.Add('group by empresa, centro, producto ');
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


function TDLParteProduccionControl.SQLEntradasTransitosRF: boolean;
begin
  qryAlmacen.SQL.clear;
  if iTipo = 0 then
  begin
    //qryAlmacen.SQL.Add('select empresa, centro, producto, date(fecha_alta) fecha_ini, date(fecha_status) fecha_estado, ');
    //qryAlmacen.SQL.Add('       status, proveedor, variedad, sum(cajas) cajas, sum(peso) peso ');
    qryAlmacen.SQL.Add('select empresa, centro, producto,  ');
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
    qryAlmacen.SQL.Add('group by empresa, centro, producto  ');
    qryAlmacen.SQL.Add('order by empresa, centro, producto ');
  end
  else
  begin
    qryAlmacen.SQL.Add('select empresa_tl empresa, centro_destino_tl centro, producto_tl producto, ');
    qryAlmacen.SQL.Add('       sum(cajas_tl) cajas, sum(kilos_tl) peso ');
    qryAlmacen.SQL.Add('from frf_transitos_c ');
    qryAlmacen.SQL.Add('     join frf_transitos_l on empresa_tl = empresa_tc and centro_tl = centro_tc ');
    qryAlmacen.SQL.Add('                          and referencia_tl = referencia_tc and fecha_tc = fecha_tl ');
    qryAlmacen.SQL.Add('where empresa_tc = :empresa ');
    qryAlmacen.SQL.Add('and nvl(fecha_entrada_tc,fecha_tc) between :fechaini and :fechafin ');
    if sCentro <> '' then
    qryAlmacen.SQL.Add('and centro_destino_tc = :centro ');
    if sProducto <> '' then
    qryAlmacen.SQL.Add('and producto_tl = :producto ');

    qryAlmacen.SQL.Add('group by empresa, centro, producto ');
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


function  TDLParteProduccionControl.SQLAlbaranesSalida: boolean;
begin
  qryAlmacen.SQL.clear;
  qryAlmacen.SQL.Add('select empresa_sl empresa, centro_salida_sl centro, producto_sl producto,  ');
  qryAlmacen.SQL.Add('       sum(cajas_sl) cajas, sum(kilos_sl) peso ');
  qryAlmacen.SQL.Add('from frf_salidas_l ');
  qryAlmacen.SQL.Add('where empresa_sl = :empresa ');
  qryAlmacen.SQL.Add('and fecha_sl between :fechaIni and :fechaFin ');

  if sCentro <> '' then
    qryAlmacen.SQL.Add('and centro_salida_sl = :centro ');

  if sProducto <> '' then
    qryAlmacen.SQL.Add('and producto_sl = :producto ');

  qryAlmacen.SQL.Add('group by empresa, centro, producto ');
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

function  TDLParteProduccionControl.SQLSalidasTransitos: boolean;
begin
  qryAlmacen.SQL.clear;
  qryAlmacen.SQL.Add('select empresa_tl empresa, centro_tl centro, producto_tl producto, ');
  qryAlmacen.SQL.Add('       sum(cajas_tl) cajas, sum(kilos_tl) peso ');
  qryAlmacen.SQL.Add('from frf_transitos_l ');
  qryAlmacen.SQL.Add('where empresa_tl = :empresa ');
  qryAlmacen.SQL.Add('and fecha_tl between :fechaini and :fechafin ');

  if sCentro <> '' then
    qryAlmacen.SQL.Add('and centro_tl = :centro ');

  if sProducto <> '' then
    qryAlmacen.SQL.Add('and producto_tl = :producto ');

  qryAlmacen.SQL.Add('group by empresa, centro, producto ');
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

end.
