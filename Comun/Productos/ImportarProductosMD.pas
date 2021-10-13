unit ImportarProductosMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMImportarProductos = class(TDataModule)
    qryCabRemoto: TQuery;
    qryCabLocal: TQuery;
    qryAuxLocal: TQuery;
    qryDetRemoto: TQuery;
    qryDetLocal: TQuery;
  private
    { Private declarations }
    sMessage: string;
    sEmpresa, sProducto: string;
    bPidoAlta, bEsAlta: Boolean;

    procedure ConfigurarBD( const ABDRemota: string );
    procedure LoadQuerysProductos;
    procedure LoadQuerysCategorias;
    procedure LoadQuerysCalibres;
    procedure LoadQuerysColores;
    procedure LoadQuerysPaises;
    procedure LoadQuerysVariedades;
    function  OpenQuerys: Boolean;
    procedure CloseQuerys;


    procedure SincDependenciaProductoBase( var VLog: string );
    function  SincronizaProducto: Boolean;
    procedure SincronizarCategorias( var VLog: string );
    procedure SincronizaCategorias( var VLog: string );
    procedure SincronizarCalibres( var VLog: string );
    procedure SincronizaCalibres( var VLog: string );
    procedure SincronizarColores( var VLog: string );
    procedure SincronizaColores( var VLog: string );
    procedure SincronizarPaises( var VLog: string );
    procedure SincronizaPaises( var VLog: string );
    procedure SincronizarVariedades( var VLog: string );
    procedure SincronizaVariedades( var VLog: string );

    function  GetMessage: string;

  public
    { Public declarations }
    function SincronizarProductos( const AEmpresa, AProducto: string; const AAlta: Boolean ): Boolean;
  end;


  function SincronizarProducto( const AOwner: TComponent; const ABDRemota, AEmpresa, AProducto: string; const AAlta: Boolean; var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  Variants, USincronizarTablas, MostrarLogFD;

var
  DMImportarProductos: TDMImportarProductos;

function SincronizarProducto( const AOwner: TComponent; const ABDRemota, AEmpresa, AProducto: string; const AAlta: Boolean; var VMsg: string ): Boolean;
begin
  DMImportarProductos:= TDMImportarProductos.Create( AOwner );
  try
    DMImportarProductos.ConfigurarBD( ABDRemota );
    Result:= DMImportarProductos.SincronizarProductos( AEmpresa, AProducto, AALta );
    VMsg:=  DMImportarProductos.GetMessage;
  finally
    FreeAndNil( DMImportarProductos );
  end;
end;

function  TDMImportarProductos.GetMessage: string;
begin
  Result:= sMessage;
end;

procedure TDMImportarProductos.ConfigurarBD( const ABDRemota: string );
begin
  qryCabRemoto.DatabaseName:= ABDRemota;
  qryDetRemoto.DatabaseName:= ABDRemota;
end;

function TDMImportarProductos.SincronizarProductos( const AEmpresa, AProducto: string; const AAlta: Boolean ): Boolean;
begin
  sMessage:= '';
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  bPidoAlta:= AALta;
  if OpenQuerys then
  begin
    Result:= SincronizaProducto;
  end
  else
  begin
    sMessage:= 'No se ha encontrado el Producto ' + AEmpresa + ' - ' + AProducto  + ' en la base de datos origen.';
    result:= False;
  end;
  CloseQuerys;
end;


procedure TDMImportarProductos.LoadQuerysProductos;
begin
  with qryCabRemoto do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_Productos');
    SQL.Add('where Producto_p = :Producto ');
  end;
  with qryCabLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryCabRemoto.SQL );
  end;
end;

procedure TDMImportarProductos.LoadQuerysCategorias;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_categorias');
    SQL.Add('where producto_c = :Producto ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add('and categoria_c = :categoria ');
  end;
end;

procedure TDMImportarProductos.LoadQuerysCalibres;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_calibres');
    SQL.Add('where Producto_c = :producto ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add('and calibre_c = :calibre ');
  end;
end;

procedure TDMImportarProductos.LoadQuerysColores;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_colores');
    SQL.Add('where Producto_c = :producto ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add('and color_c = :color ');
  end;
end;

procedure TDMImportarProductos.LoadQuerysPaises;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_paises_producto');
    SQL.Add('where Producto_psp = :producto ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add('and pais_psp = :pais ');
  end;
end;

procedure TDMImportarProductos.LoadQuerysVariedades;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_productos_variedad');
    SQL.Add('where Producto_pv = :producto ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add('and codigo_pv = :variedad ');
  end;
end;



function TDMImportarProductos.OpenQuerys: Boolean;
begin
  LoadQuerysProductos;

  //Abrir origen
  qryCabRemoto.ParamByName('Producto').AsString:= sProducto;
  qryCabRemoto.Open;
  if qryCabRemoto.IsEmpty then
  begin
    Result:= False;
  end
  else
  begin
    Result:= True;
  end;

  //Abrir destino
  if Result then
  begin
    qryCabLocal.ParamByName('Producto').AsString:= sProducto;
    qryCabLocal.Open;
    bEsAlta:= qryCabLocal.IsEmpty;
  end;
end;

procedure TDMImportarProductos.CloseQuerys;
begin
  qryCabRemoto.Close;
  qryCabLocal.Close;
end;

function TDMImportarProductos.SincronizaProducto: Boolean;
var
  iResult: Integer;
  sLog: string;
begin
  if bPidoAlta = bEsAlta then
  begin
    sLog:= 'RESULTADO SINCRONIZACION';
    sLog:= sLog + #13 + #10 + '------------------------';

    //DEPENDENCIAS
    (*

    SincDependenciaAgrupaComer( sLog );
    SincDependenciaOperadores( sLog );
    SincDependenciaEnvRetornable( sLog );
    SincDependenciaTipoCaja( sLog );
    SincDependenciaLineaProducto( sLog );
    SincDependenciaUndConsumo( sLog );
    *)

    SincDependenciaProductoBase( sLog );
    Result:= SincronizarRegistro( qryCabRemoto, qryCabLocal, sLog, 'Producto' ) > -1;
    if Result then
    begin
      LoadQuerysCategorias;
      SincronizarCategorias( sLog );
      LoadQuerysCalibres;
      SincronizarCalibres( sLog );
      LoadQuerysColores;
      SincronizarColores( sLog );
      LoadQuerysVariedades;
      SincronizarVariedades( sLog );
      LoadQuerysPaises;
      SincronizarPaises( sLog );
    end;
    MostrarLogFD.MostrarLog( Self, sLog );
  end
  else
  begin
    Result:= False;
    if bPidoAlta then
    begin
      sMessage:= 'Se quiere dar de alta un producto, pero en el origen ya existe.';
    end
    else
    begin
      sMessage:= 'Se quiere modificar un producto, pero en el origen no existe.';
    end;
  end;
end;


procedure TDMImportarProductos.SincDependenciaProductoBase( var VLog: string );
var
  sLog: string;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_productos_base');
    SQL.Add('where empresa_pb = :empresa ');
    SQL.Add('and Producto_base_pb = :Producto_base ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
  end;

  qryDetLocal.ParamByName('empresa').AsString:= '050';
  qryDetLocal.ParamByName('Producto_base').AsString:= qryCabRemoto.FieldByName('Producto_base_p').AsString;
  qryDetLocal.Open;
  try
    if qryDetLocal.IsEmpty then
    begin
      qryDetRemoto.ParamByName('empresa').AsString:= '050';
      qryDetRemoto.ParamByName('Producto_base').AsString:= qryCabRemoto.FieldByName('Producto_base_p').AsString;
      qryDetRemoto.Open;

      while not qryDetRemoto.IsEmpty do
      begin
        try
          SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'PRODUCTO BASE' );
            VLog:= VLog + sLog;
        finally
          qryDetRemoto.Close;
        end;
      end;
    end;
  finally
    qryDetLocal.Close;
  end;
end;

procedure TDMImportarProductos.SincronizarCategorias( var VLog: string );
begin
  qryDetRemoto.ParamByName('Producto').AsString:= sProducto;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaCategorias( VLog );
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;

procedure TDMImportarProductos.SincronizaCategorias( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el Producto, si no dara error al grabar
  qryDetLocal.ParamByName('Producto').AsString:= sProducto;
  qryDetLocal.ParamByName('categoria').AsString:= qryDetRemoto.FieldByName('categoria_c').AsString;
  qryDetLocal.Open;
  SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'CATEGORIAS' );
  VLog:= VLog + sLog;
  qryDetLocal.Close;
end;

procedure TDMImportarProductos.SincronizarCalibres( var VLog: string );
begin
  qryDetRemoto.ParamByName('Producto').AsString:= sProducto;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaCalibres( VLog );
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;

procedure TDMImportarProductos.SincronizaCalibres( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el Producto, si no dara error al grabar
  qryDetLocal.ParamByName('Producto').AsString:= sProducto;
  qryDetLocal.ParamByName('calibre').AsString:= qryDetRemoto.FieldByName('calibre_c').AsString;

  qryDetLocal.Open;
  SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'CALIBRES' );
   VLog:= VLog + sLog;
  qryDetLocal.Close;
end;

procedure TDMImportarProductos.SincronizarColores( var VLog: string );
begin
  qryDetRemoto.ParamByName('Producto').AsString:= sProducto;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaColores( VLog );
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;

procedure TDMImportarProductos.SincronizaColores( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el Producto, si no dara error al grabar
  qryDetLocal.ParamByName('Producto').AsString:= sProducto;
  qryDetLocal.ParamByName('color').AsString:= qryDetRemoto.FieldByName('color_c').AsString;

  qryDetLocal.Open;
  SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'COLORES' );
   VLog:= VLog + sLog;
  qryDetLocal.Close;
end;

procedure TDMImportarProductos.SincronizarPaises( var VLog: string );
begin
  qryDetRemoto.ParamByName('Producto').AsString:= sProducto;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaPaises( VLog );
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;

procedure TDMImportarProductos.SincronizaPaises( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el Producto, si no dara error al grabar
  qryDetLocal.ParamByName('Producto').AsString:= sProducto;
  qryDetLocal.ParamByName('pais').AsString:= qryDetRemoto.FieldByName('pais_psp').AsString;

  qryDetLocal.Open;
  SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'PAISES' );
   VLog:= VLog + sLog;
  qryDetLocal.Close;
end;

procedure TDMImportarProductos.SincronizarVariedades( var VLog: string );
begin
  qryDetRemoto.ParamByName('Producto').AsString:= sProducto;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaVariedades( VLog );
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;

procedure TDMImportarProductos.SincronizaVariedades( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el Producto, si no dara error al grabar
  qryDetLocal.ParamByName('Producto').AsString:= sProducto;
  qryDetLocal.ParamByName('variedad').AsString:= qryDetRemoto.FieldByName('codigo_pv').AsString;

  qryDetLocal.Open;
  SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'VARIEDADES' );
   VLog:= VLog + sLog;
  qryDetLocal.Close;
end;



end.
