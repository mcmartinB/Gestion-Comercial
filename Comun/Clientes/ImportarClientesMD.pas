unit ImportarClientesMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMImportarClientes = class(TDataModule)
    qryCabRemoto: TQuery;
    qryCabLocal: TQuery;
    qryAuxLocal: TQuery;
    qryDetRemoto: TQuery;
    qryDetLocal: TQuery;
  private
    { Private declarations }
    sMessage: string;
    sEmpresa, sCliente: string;
    bPidoAlta, bEsAlta: Boolean;

    procedure ConfigurarBD( const ABDRemota: string );
    procedure LoadQuerysClientes;
    procedure LoadQuerysEnvases;
    procedure LoadQuerysSuministros;
    function  OpenQuerys: Boolean;
    procedure CloseQuerys;


(*
    procedure SincDependenciaAgrupaCostes( var VLog: string );
    procedure SincDependenciaAgrupaComer( var VLog: string );
    procedure SincDependenciaOperadores( var VLog: string );
    procedure SincDependenciaEnvRetornable( var VLog: string );
    procedure SincDependenciaTipoCaja( var VLog: string );
    procedure SincDependenciaLineaProducto( var VLog: string );
    procedure SincDependenciaUndConsumo( var VLog: string );
*)

    function  SincronizaCliente: Boolean;
    procedure SincronizarEnvases( var VLog: string );
    procedure SincronizaEnvases( var VLog: string );
    procedure SincronizarSuministros( var VLog: string );
    procedure SincronizaSuministros( var VLog: string );

    function  GetMessage: string;

  public
    { Public declarations }
    function SincronizarClientes( const ACliente: string; const AAlta: Boolean ): Boolean;
  end;


  function SincronizarCliente( const AOwner: TComponent; const ABDRemota, ACliente: string; const AAlta: Boolean; var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  Variants, USincronizarTablas, MostrarLogFD;

var
  DMImportarClientes: TDMImportarClientes;

function SincronizarCliente( const AOwner: TComponent; const ABDRemota, ACliente: string; const AAlta: Boolean; var VMsg: string ): Boolean;
begin
  DMImportarClientes:= TDMImportarClientes.Create( AOwner );
  try
    DMImportarClientes.ConfigurarBD( ABDRemota );
    Result:= DMImportarClientes.SincronizarClientes( ACliente, AALta );
    VMsg:=  DMImportarClientes.GetMessage;
  finally
    FreeAndNil( DMImportarClientes );
  end;
end;

function  TDMImportarClientes.GetMessage: string;
begin
  Result:= sMessage;
end;

procedure TDMImportarClientes.ConfigurarBD( const ABDRemota: string );
begin
  qryCabRemoto.DatabaseName:= ABDRemota;
  qryDetRemoto.DatabaseName:= ABDRemota;
end;

function TDMImportarClientes.SincronizarClientes( const ACliente: string; const AAlta: Boolean ): Boolean;
begin
  sMessage:= '';
  sCliente:= ACliente;
  bPidoAlta:= AALta;
  if OpenQuerys then
  begin
    Result:= SincronizaCliente;
  end
  else
  begin
    sMessage:= 'No se ha encontrado el cliente ' + ACliente  + ' en la base de datos origen.';
    result:= False;
  end;
  CloseQuerys;
end;


procedure TDMImportarClientes.LoadQuerysClientes;
begin
  with qryCabRemoto do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_clientes');
    SQL.Add('where cliente_c = :cliente ');
  end;
  with qryCabLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryCabRemoto.SQL );
  end;
end;

procedure TDMImportarClientes.LoadQuerysEnvases;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_clientes_env');
    SQL.Add('where empresa_ce = :empresa ');
    SQL.Add('and cliente_ce = :cliente ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add('and envase_ce = :envase ');
  end;
end;

procedure TDMImportarClientes.LoadQuerysSuministros;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_dir_sum');
    SQL.Add('where cliente_ds = :cliente ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
    SQL.Add('and dir_sum_ds = :suministro ');
  end;
end;


function TDMImportarClientes.OpenQuerys: Boolean;
begin
  LoadQuerysClientes;

  //Abrir origen
  qryCabRemoto.ParamByName('cliente').AsString:= sCliente;
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
    qryCabLocal.ParamByName('cliente').AsString:= sCliente;
    qryCabLocal.Open;
    bEsAlta:= qryCabLocal.IsEmpty;
  end;
end;

procedure TDMImportarClientes.CloseQuerys;
begin
  qryCabRemoto.Close;
  qryCabLocal.Close;
end;

function TDMImportarClientes.SincronizaCliente: Boolean;
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
    SincDependenciaAgrupaCostes( sLog );
    SincDependenciaAgrupaComer( sLog );
    SincDependenciaOperadores( sLog );
    SincDependenciaEnvRetornable( sLog );
    SincDependenciaTipoCaja( sLog );
    SincDependenciaLineaProducto( sLog );
    SincDependenciaUndConsumo( sLog );
    *)

    Result:= SincronizarRegistro( qryCabRemoto, qryCabLocal, sLog, 'CLIENTE' ) > -1;
    if Result then
    begin
      LoadQuerysEnvases;
      SincronizarEnvases( sLog );
      LoadQuerysSuministros;
      SincronizarSuministros( sLog );
    end;
    MostrarLogFD.MostrarLog( Self, sLog );
  end
  else
  begin
    Result:= False;
    if bPidoAlta then
    begin
      sMessage:= 'Se quiere dar de alta en envase, pero en el origen ya existe.';
    end
    else
    begin
      sMessage:= 'Se quiere modificar un envase, pero en el origen no existe.';
    end;
  end;
end;

procedure TDMImportarClientes.SincronizarEnvases( var VLog: string );
begin
  qryDetRemoto.ParamByName('empresa').AsString:= sEmpresa;
  qryDetRemoto.ParamByName('cliente').AsString:= sCliente;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaEnvases( VLog );
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;

procedure TDMImportarClientes.SincronizaEnvases( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el cliente, si no dara error al grabar
  qryDetLocal.ParamByName('empresa').AsString:= sEmpresa;
  qryDetLocal.ParamByName('cliente').AsString:= sCliente;
  qryDetLocal.ParamByName('envase').AsString:= qryDetRemoto.FieldByName('envase_ce').AsString;
  qryDetLocal.Open;
  SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'ARTÍCULO CLIENTE' );
  VLog:= VLog + sLog;
  qryDetLocal.Close;
end;

procedure TDMImportarClientes.SincronizarSuministros( var VLog: string );
begin
  qryDetRemoto.ParamByName('cliente').AsString:= sCliente;
  qryDetRemoto.Open;
  if not qryDetRemoto.IsEmpty then
  begin
    while not qryDetRemoto.Eof do
    begin
      SincronizaSuministros( VLog );
      qryDetRemoto.Next;
    end;
    qryDetRemoto.Close;
  end;
end;

procedure TDMImportarClientes.SincronizaSuministros( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el cliente, si no dara error al grabar
  qryDetLocal.ParamByName('cliente').AsString:= sCliente;
  qryDetLocal.ParamByName('suministro').AsString:= qryDetRemoto.FieldByName('dir_sum_ds').AsString;

  qryDetLocal.Open;
  SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'PLATAFORMAS' );
   VLog:= VLog + sLog;
  qryDetLocal.Close;
end;

//----------------------------------------------------------------------------
//DEPENDENCIAS
//----------------------------------------------------------------------------
(*
procedure TDMImportarClientes.SincDependenciaAgrupaCostes( var VLog: string );
var
  sLog: string;
begin
  //agrupacion_e
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_agrupaciones_envase');
    SQL.Add('where agrupacion_ae = :agrupacion_e ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
  end;

  qryDetLocal.ParamByName('agrupacion_e').AsString:= qryCabRemoto.FieldByName('agrupacion_e').AsString;
  qryDetLocal.Open;
  try
    if qryDetLocal.IsEmpty then
    begin
      qryDetRemoto.ParamByName('agrupacion_e').AsString:= qryCabRemoto.FieldByName('agrupacion_e').AsString;
      qryDetRemoto.Open;

      while not qryDetRemoto.IsEmpty do
      begin
        try
          SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'AGRUPACION COSTES' );
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

procedure TDMImportarClientes.SincDependenciaAgrupaComer( var VLog: string );
var
  sLog: string;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_agrupa_comerciales');
    SQL.Add('where agrupacion_ac = :agrupa_comercial_e ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
  end;

  qryDetLocal.ParamByName('agrupa_comercial_e').AsString:= qryCabRemoto.FieldByName('agrupa_comercial_e').AsString;
  qryDetLocal.Open;
  try
    if qryDetLocal.IsEmpty then
    begin
      qryDetRemoto.ParamByName('agrupa_comercial_e').AsString:= qryCabRemoto.FieldByName('agrupa_comercial_e').AsString;
      qryDetRemoto.Open;

      while not qryDetRemoto.IsEmpty do
      begin
        try
          SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'AGRUPACION COMERCIAL' );
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

procedure TDMImportarClientes.SincDependenciaOperadores( var VLog: string );
var
  sLog: string;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_env_comer_operadores');
    SQL.Add('where cod_operador_eco = :env_comer_operador_e ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
  end;

  qryDetLocal.ParamByName('env_comer_operador_e').AsString:= qryCabRemoto.FieldByName('env_comer_operador_e').AsString;
  qryDetLocal.Open;
  try
    if qryDetLocal.IsEmpty then
    begin
      qryDetRemoto.ParamByName('env_comer_operador_e').AsString:= qryCabRemoto.FieldByName('env_comer_operador_e').AsString;
      qryDetRemoto.Open;

      while not qryDetRemoto.IsEmpty do
      begin
        try
          SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'OPERADOR ENVASE RETORNABLE' );
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

procedure TDMImportarClientes.SincDependenciaEnvRetornable( var VLog: string );
var
  sLog: string;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_env_comer_productos');
    SQL.Add('where cod_operador_ecp = :env_comer_operador_e ');
    SQL.Add('and cod_producto_ecp = :env_comer_producto_e ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
  end;

  qryDetLocal.ParamByName('env_comer_operador_e').AsString:= qryCabRemoto.FieldByName('env_comer_operador_e').AsString;
  qryDetLocal.ParamByName('env_comer_producto_e').AsString:= qryCabRemoto.FieldByName('env_comer_producto_e').AsString;
  qryDetLocal.Open;
  try
    if qryDetLocal.IsEmpty then
    begin
      qryDetRemoto.ParamByName('env_comer_operador_e').AsString:= qryCabRemoto.FieldByName('env_comer_operador_e').AsString;
      qryDetRemoto.ParamByName('env_comer_producto_e').AsString:= qryCabRemoto.FieldByName('env_comer_producto_e').AsString;
      qryDetRemoto.Open;

      while not qryDetRemoto.IsEmpty do
      begin
        try
          SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'ENVASE RETORNABLE' );
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

procedure TDMImportarClientes.SincDependenciaTipoCaja( var VLog: string );
var
  sLog: string;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_tipos_caja');
    SQL.Add('where codigo_tc = :tipo_caja_e ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
  end;

  qryDetLocal.ParamByName('tipo_caja_e').AsString:= qryCabRemoto.FieldByName('tipo_caja_e').AsString;
  qryDetLocal.Open;
  try
    if qryDetLocal.IsEmpty then
    begin
      qryDetRemoto.ParamByName('tipo_caja_e').AsString:= qryCabRemoto.FieldByName('tipo_caja_e').AsString;
      qryDetRemoto.Open;

      while not qryDetRemoto.IsEmpty do
      begin
        try
          SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'TIPO CAJA' );
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

procedure TDMImportarClientes.SincDependenciaLineaProducto( var VLog: string );
var
  sLog: string;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_linea_productos');
    SQL.Add('where linea_producto_lp = :linea_producto_e ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
  end;

  qryDetLocal.ParamByName('linea_producto_e').AsString:= qryCabRemoto.FieldByName('linea_producto_e').AsString;
  qryDetLocal.Open;
  try
    if qryDetLocal.IsEmpty then
    begin
      qryDetRemoto.ParamByName('linea_producto_e').AsString:= qryCabRemoto.FieldByName('linea_producto_e').AsString;
      qryDetRemoto.Open;

      while not qryDetRemoto.IsEmpty do
      begin
        try
          SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'LINEA PRODUCTO' );
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

procedure TDMImportarClientes.SincDependenciaUndConsumo( var VLog: string );
var
  sLog: string;
begin
  with qryDetRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_und_consumo');
    SQL.Add('where empresa_uc = :empresa_e ');
    SQL.Add('and codigo_uc = :tipo_unidad_e ');
  end;
  with qryDetLocal do
  begin
    SQL.Clear;
    SQL.AddStrings( qryDetRemoto.SQL );
  end;

  qryDetLocal.ParamByName('empresa_e').AsString:= qryCabRemoto.FieldByName('empresa_e').AsString;
  qryDetLocal.ParamByName('tipo_unidad_e').AsString:= qryCabRemoto.FieldByName('tipo_unidad_e').AsString;
  qryDetLocal.Open;
  try
    if qryDetLocal.IsEmpty then
    begin
      qryDetRemoto.ParamByName('empresa_e').AsString:= qryCabRemoto.FieldByName('empresa_e').AsString;
      qryDetRemoto.ParamByName('tipo_unidad_e').AsString:= qryCabRemoto.FieldByName('tipo_unidad_e').AsString;
      qryDetRemoto.Open;

      while not qryDetRemoto.IsEmpty do
      begin
        try
          SincronizarRegistro( qryDetRemoto, qryDetLocal, sLog, 'UNIDAD CONSUMO' );
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
*)

end.


