unit PedidosClienteDM;

interface

uses
  forms, SysUtils, Classes, DB, DBTables;

type
  TDMPedidosCliente = class(TDataModule)
    QMaestro: TQuery;
    DSEnlace: TDataSource;
    TDetalle: TTable;
    QNumeroPedido: TQuery;
    QNumeroLinea: TQuery;
    QUnidad: TQuery;
    QSuministro: TQuery;
    QListado: TQuery;
    QNotas: TQuery;
    DSNotas: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function  NuevaPedido( const AEmpresa, ACentro: string ): integer;
    function  NuevaLinea( const AEmpresa, ACentro: string; const APedido: integer ): integer;
    function  Unidad( const AEmpresa, AProducto, AEnvase, ACliente: string ): string;
    function  DirSumValida( const AEmpresa, ACliente, ADirSum: string ): boolean;
    procedure QueryListado( const AEmpresa, ACentro, ACliente, AProducto, APedido:string;
                            const AFechaIni, AFechaFin: TDateTime );
  end;

procedure CrearModuloDeDatos;
procedure DestruirModuloDeDatos;

var
  DMPedidosCliente: TDMPedidosCliente;

implementation

{$R *.dfm}
var
  iConexiones: Integer;

procedure CrearModuloDeDatos;
begin
  if iConexiones = 0 then
  begin
    DMPedidosCliente:= TDMPedidosCliente.Create( application );
  end;
  Inc( iConexiones );
end;

procedure DestruirModuloDeDatos;
begin
  Dec( iConexiones );
  if iConexiones = 0 then
  begin
    FreeAndNil( DMPedidosCliente );
  end;
end;

function TDMPedidosCliente.NuevaPedido( const AEmpresa, ACentro: string ): integer;
begin
  result:= 0;
  QNumeroPedido.ParamByName('empresa').AsString:= AEmpresa;
  QNumeroPedido.ParamByName('centro').AsString:= ACentro;
  QNumeroPedido.Open;
  Result:= QNumeroPedido.Fields[0].AsInteger + 1;
  QNumeroPedido.Close;
end;

function TDMPedidosCliente.NuevaLinea( const AEmpresa, ACentro: string;
                                const APedido: integer ): integer;
begin
  result:= 0;
  QNumeroLinea.ParamByName('empresa').AsString:= AEmpresa;
  QNumeroLinea.ParamByName('centro').AsString:= ACentro;
  QNumeroLinea.ParamByName('pedido').AsInteger:= APedido;
  QNumeroLinea.Open;
  Result:= QNumeroLinea.Fields[0].AsInteger + 1;
  QNumeroLinea.Close;
end;

function TDMPedidosCliente.Unidad( const AEmpresa, AProducto, AEnvase, ACliente: string ): string;
begin
  result:= 'K';
  QUnidad.ParamByName('empresa').AsString:= AEmpresa;
  QUnidad.ParamByName('producto').AsString:= AProducto;
  QUnidad.ParamByName('envase').AsString:= AEnvase;
  QUnidad.ParamByName('cliente').AsString:= ACliente;
  QUnidad.Open;
  Result:= QUnidad.Fields[0].AsString;
  QUnidad.Close;
end;

function TDMPedidosCliente.DirSumValida( const AEmpresa, ACliente, ADirSum: string ): boolean;
begin
  result:= false;
  if ( ACliente = ADirSum ) and ( ACliente <> '' ) then
  begin
    result:= true;
  end
  else
  begin
    QSuministro.ParamByName('empresa').AsString:= AEmpresa;
    QSuministro.ParamByName('cliente').AsString:= ACliente;
    QSuministro.ParamByName('dirsum').AsString:= ADirSum;
    QSuministro.Open;
    Result:= not QSuministro.IsEmpty;
    QSuministro.Close;
  end;
end;

procedure TDMPedidosCliente.QueryListado( const AEmpresa, ACentro, ACliente, AProducto, APedido:string;
                                   const AFechaIni, AFechaFin: TDateTime  );
begin
  QListado.SQL.Clear;
  QListado.SQL.Add(' select ');
  QListado.SQL.Add('        empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedido_pdc, cliente_pdc,  ');
  QListado.SQL.Add('        dir_suministro_pdc, anulado_pdc, motivo_anulacion_pdc,  ');
  QListado.SQL.Add('        producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, color_pdd, unidad_pdd, ');
  QListado.SQL.Add('        sum(unidades_pdd) unidades_pdd ');

  QListado.SQL.Add(' from frf_pedido_cab cab, frf_pedido_det det ');

  QListado.SQL.Add(' where empresa_pdc = empresa_pdd ');
  QListado.SQL.Add(' and centro_pdc = centro_pdd ');
  QListado.SQL.Add(' and pedido_pdc = pedido_pdd ');
  QListado.SQL.Add(' and empresa_pdc = :empresa ');
  QListado.SQL.Add(' and centro_pdc = :centro ');
  QListado.SQL.Add(' and fecha_pdc between :inicio and :fin ');
  if ACliente <> '' then
    QListado.SQL.Add(' and cliente_pdc = :cliente ');
  if APedido <> '' then
    QListado.SQL.Add(' and ref_pedido_pdc = :pedido ');
  if AProducto <> '' then
    QListado.SQL.Add(' and producto_pdd = :producto ');

  QListado.SQL.Add(' group by empresa_pdc, centro_pdc, cliente_pdc, dir_suministro_pdc,');
    QListado.SQL.Add('      fecha_pdc, pedido_pdc, ref_pedido_pdc,  anulado_pdc, motivo_anulacion_pdc,');
  QListado.SQL.Add('        producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, color_pdd, unidad_pdd ');

  QListado.SQL.Add(' order by empresa_pdc, centro_pdc, cliente_pdc, dir_suministro_pdc, fecha_pdc, ref_pedido_pdc,  ');
  QListado.SQL.Add('        producto_pdd, unidad_pdd, envase_pdd, categoria_pdd, calibre_pdd, color_pdd ');

  QListado.ParamByName('empresa').AsString:= AEmpresa;
  QListado.ParamByName('centro').AsString:= ACentro;
  QListado.ParamByName('inicio').AsDateTime:= AFechaIni;
  QListado.ParamByName('fin').AsDateTime:= AFechaFin;
  if ACliente <> '' then
    QListado.ParamByName('cliente').AsString:= ACliente;
  if APedido <> '' then
    QListado.ParamByName('pedido').AsString:= APedido;
  if AProducto <> '' then
    QListado.ParamByName('producto').AsString:= AProducto;
end;

procedure TDMPedidosCliente.DataModuleCreate(Sender: TObject);
begin
  QNumeroPedido.SQL.Clear;
  QNumeroPedido.SQL.Add(' select max(nvl(pedido_pdc,0)) ');
  QNumeroPedido.SQL.Add(' from frf_pedido_cab ');
  QNumeroPedido.SQL.Add(' where empresa_pdc = :empresa ');
  QNumeroPedido.SQL.Add(' and centro_pdc = :centro ');
  QNumeroPedido.Prepare;

  QNumeroLinea.SQL.Clear;
  QNumeroLinea.SQL.Add(' select max(nvl(linea_pdd,0)) ');
  QNumeroLinea.SQL.Add(' from frf_pedido_det ');
  QNumeroLinea.SQL.Add(' where empresa_pdd = :empresa ');
  QNumeroLinea.SQL.Add(' and centro_pdd = :centro ');
  QNumeroLinea.SQL.Add(' and pedido_pdd = :pedido ');
  QNumeroLinea.Prepare;

  QUnidad.SQL.Clear;
  QUnidad.SQL.Add(' select unidad_fac_ce ');
  QUnidad.SQL.Add(' from frf_clientes_env ');
  QUnidad.SQL.Add(' where empresa_ce = :empresa ');
  QUnidad.SQL.Add(' and producto_base_ce = ');
  QUnidad.SQL.Add(' ( ');
  QUnidad.SQL.Add(' select producto_base_p ');
  QUnidad.SQL.Add(' from frf_productos ');
  QUnidad.SQL.Add(' where empresa_p = :empresa ');
  QUnidad.SQL.Add(' and producto_p = :producto ');
  QUnidad.SQL.Add(' ) ');
  QUnidad.SQL.Add(' and envase_ce = :envase ');
  QUnidad.SQL.Add(' and cliente_ce = :cliente ');
  QUnidad.Prepare;

  QSuministro.SQL.Clear;
  QSuministro.SQL.Add(' select dir_sum_ds ');
  QSuministro.SQL.Add(' from frf_dir_sum ');
  QSuministro.SQL.Add(' where empresa_ds = :empresa ');
  QSuministro.SQL.Add(' and cliente_ds = :cliente ');
  QSuministro.SQL.Add(' and dir_sum_ds = :dirsum ');
  QSuministro.Prepare;

  QNotas.SQL.Clear;
  QNotas.SQL.Add(' select observaciones_pdc ');
  QNotas.SQL.Add(' from frf_pedido_cab  ');
  QNotas.SQL.Add(' where empresa_pdc = :empresa_pdc ');
  QNotas.SQL.Add(' and centro_pdc = :centro_pdc ');
  QNotas.SQL.Add(' and pedido_pdc = :pedido_pdc ');
  QNotas.Prepare;
end;

procedure TDMPedidosCliente.DataModuleDestroy(Sender: TObject);
begin
  if QNumeroPedido.Prepared then
    QNumeroPedido.UnPrepare;

  if QNumeroLinea.Prepared  then
    QNumeroLinea.UnPrepare;

  if QUnidad.Prepared  then
    QUnidad.UnPrepare;

  if QSuministro.Prepared  then
    QSuministro.UnPrepare;
end;

initialization
  iConexiones:= 0;

end.
