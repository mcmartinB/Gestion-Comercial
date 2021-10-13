unit ImportarProveedorMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMImportarProveedor = class(TDataModule)
    qryRemoto: TQuery;
    qryLocal: TQuery;
    qryAuxLocal: TQuery;
    qryDetLocal: TQuery;
    qryDetRemoto: TQuery;
  private
    { Private declarations }
    sMessage: string;
    sProveedor: string;

    procedure ConfigurarBD( const ABDRemota: string );
    procedure LoadQuerysProveedor;
    procedure LoadQuerysProveedorAlmacen;
    procedure LoadQuerysProveedorCostes;
    procedure LoadQuerysProductosProveedor;
    procedure MakeQuerysProveedor;
    function  OpenQuerys: Boolean;
    procedure CloseQuerys;

    procedure SincronizaProveedores;
    function SincronizaProveedor( var Vlog: string ): boolean;
    procedure SincronizarProveedoresAlmacen( var VLog: string );
    procedure SincronizaProveedoresAlmacen( var VLog: string );
    procedure SincronizarProveedoresCostes ( var VLog: string );
    procedure SincronizaProveedoresCostes( var VLog: string );
    procedure SincronizarProductosProveedor ( var VLog: string );
    procedure SincronizaProductosProveedor( var VLog: string );


    function  GetMessage: string;

  public
    { Public declarations }
    function SincronizarProveedores( const AProveedor: string ): Boolean;
  end;


  function SincronizarProveedor( const AOwner: TComponent; const ABDRemota, AProveedor: string; var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  Variants, USincronizarTablas, MostrarLogFD;

var
  DMImportarProveedor: TDMImportarProveedor;

function SincronizarProveedor( const AOwner: TComponent; const ABDRemota, AProveedor: string; var VMsg: string ): Boolean;
begin
  DMImportarProveedor:= TDMImportarProveedor.Create( AOwner );
  try
    DMImportarProveedor.ConfigurarBD( ABDRemota );
    Result:= DMImportarProveedor.SincronizarProveedores( AProveedor );
    VMsg:=  DMImportarProveedor.GetMessage;
  finally
    FreeAndNil( DMImportarProveedor );
  end;
end;

function  TDMImportarProveedor.GetMessage: string;
begin
  Result:= sMessage;
end;

procedure TDMImportarProveedor.ConfigurarBD( const ABDRemota: string );
begin
  qryRemoto.DatabaseName:= ABDRemota;
end;

function TDMImportarProveedor.SincronizarProveedores( const AProveedor: string ): Boolean;
begin
  sMessage:= '';
  sProveedor:= AProveedor;

  if OpenQuerys then
  begin
    SincronizaProveedores;
    Result:= True;
  end
  else
  begin
    sMessage:= 'No se ha encontrado el Proveedor ' + AProveedor  + ' en la base de datos origen.';
    result:= False;
  end;
  CloseQuerys;
end;

procedure TDMImportarProveedor.LoadQuerysProveedor;
begin
  with qryRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_proveedores');
    SQL.Add('where proveedor_p = :proveedor ');
  end;
end;


procedure TDMImportarProveedor.LoadQuerysProveedorAlmacen;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_proveedores_almacen');
    SQL.Add('where proveedor_pa = :proveedor ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add('and almacen_pa = :almacen ');
  end;
end;

procedure TDMImportarProveedor.LoadQuerysProveedorCostes;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_proveedores_costes');
    SQL.Add('where proveedor_pc = :proveedor ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add(' and tipo_coste_pc = :tipocoste ');
    SQL.Add(' and fecha_ini_pc = :fechaini   ');
  end;
end;

procedure TDMImportarProveedor.LoadQuerysProductosProveedor;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_productos_proveedor');
    SQL.Add('where proveedor_pp = :proveedor ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add('and producto_pp = :producto ');
    SQL.Add('and variedad_pp = :variedad ');
  end;
end;

procedure TDMImportarProveedor.MakeQuerysProveedor;
begin
  with qryLocal do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_proveedores ');
    SQL.Add('where 1 =  1 ');
    if qryRemoto.FieldByname('proveedor_p').Value <> Null then
      SQL.Add('and proveedor_p =  :proveedor ');

    if qryRemoto.FieldByname('proveedor_p').Value <> Null then
      ParamByName('proveedor').AsString:= qryRemoto.FieldByname('proveedor_p').AsString;;
  end;
end;



function TDMImportarProveedor.OpenQuerys: Boolean;
begin
  LoadQuerysProveedor;
  //Abrir origen
  qryRemoto.ParamByName('proveedor').AsString:= sProveedor;
  qryRemoto.Open;
  Result:= not qryRemoto.IsEmpty;
end;

procedure TDMImportarProveedor.CloseQuerys;
begin
  qryRemoto.Close;
  qryLocal.Close;
end;

procedure TDMImportarProveedor.SincronizaProveedores;
var
  iResult: Integer;
  sLog: string;
begin
  sLog:= 'RESULTADO SINCRONIZACION';
  sLog:= sLog + #13 + #10 + '------------------------';

  while not qryRemoto.Eof do
  begin
    SincronizaProveedor( sLog );
    qryRemoto.Next;
  end;
  MostrarLogFD.MostrarLog( Self, sLog );
end;

procedure TDMImportarProveedor.SincronizarProveedoresAlmacen(var VLog: string);
begin
  qryDetRemoto.ParamByName('proveedor').AsString:= sProveedor;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaProveedoresAlmacen( VLog );
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;


procedure TDMImportarProveedor.SincronizaProveedoresAlmacen(var VLog: string);
var
  sLog: string;
begin
  //Abrir destino solo si existe el Producto, si no dara error al grabar
  qryDetLocal.ParamByName('proveedor').AsString:= sProveedor;
  qryDetLocal.ParamByName('almacen').AsString:= qryDetRemoto.FieldByName('almacen_pa').AsString;
  qryDetLocal.Open;
  SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'PROVEEDORES ALMACEN' );
  VLog:= VLog + sLog;
  qryDetLocal.Close;
end;

procedure TDMImportarProveedor.SincronizarProveedoresCostes(var VLog: string);
begin
  qryDetRemoto.ParamByName('proveedor').AsString:= sProveedor;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaProveedoresCostes( VLog );
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;

procedure TDMImportarProveedor.SincronizaProveedoresCostes(var VLog: string);
var
  sLog: string;
begin
  //Abrir destino solo si existe el Producto, si no dara error al grabar
  qryDetLocal.ParamByName('proveedor').AsString:= sProveedor;
  qryDetLocal.ParamByName('tipocoste').AsString:= qryDetRemoto.FieldByName('tipo_coste_pc').AsString;
  qryDetLocal.ParamByName('fechaini').AsString:= qryDetRemoto.FieldByName('fecha_ini_pc').AsString;
  qryDetLocal.Open;
  SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'PROVEEDORES COSTES' );
  VLog:= VLog + sLog;
  qryDetLocal.Close;
end;

procedure TDMImportarProveedor.SincronizarProductosProveedor(var VLog: string);
begin
  qryDetRemoto.ParamByName('proveedor').AsString:= sProveedor;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaProductosProveedor( VLog );
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;


procedure TDMImportarProveedor.SincronizaProductosProveedor(var VLog: string);
var
  sLog: string;
begin
  //Abrir destino solo si existe el Producto, si no dara error al grabar
  qryDetLocal.ParamByName('proveedor').AsString:= sProveedor;
  qryDetLocal.ParamByName('producto').AsString:= qryDetRemoto.FieldByName('producto_pp').AsString;
  qryDetLocal.ParamByName('variedad').AsString:= qryDetRemoto.FieldByName('variedad_pp').AsString;
  qryDetLocal.Open;
  SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'PRODUCTOS PROVEEDOR' );
  VLog:= VLog + sLog;
  qryDetLocal.Close;
end;

function TDMImportarProveedor.SincronizaProveedor( var Vlog: string ): boolean;
var
  sLog: string;
begin
  //Abrir destino solo si existe el proveedor, si no dara error al grabar
  MakeQuerysProveedor;
  qryLocal.Open;
  //if SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Palet' ) > 0 then
  Result := SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Proveedor' ) > -1;
  if Result then
  begin
    LoadQuerysProveedorAlmacen;
    SincronizarProveedoresAlmacen( sLog );
    LoadQuerysProveedorCostes;
    SincronizarProveedoresCostes( sLog );
    LoadQuerysProductosProveedor;
    SincronizarProductosProveedor( sLog );
  end;

  VLog:= VLog + sLog;
  qryLocal.Close;
end;

end.


