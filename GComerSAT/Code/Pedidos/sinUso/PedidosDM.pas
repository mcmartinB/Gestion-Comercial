unit PedidosDM;

interface

uses
  forms, SysUtils, Classes, DB, DBTables;

type
  TDMPedidos = class(TDataModule)
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
    QTotalDetalle: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QMaestroAfterOpen(DataSet: TDataSet);
    procedure QMaestroBeforeClose(DataSet: TDataSet);
    procedure TDetalleAfterPost(DataSet: TDataSet);
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
  DMPedidos: TDMPedidos;

implementation

{$R *.dfm}
var
  iConexiones: Integer;

procedure CrearModuloDeDatos;
begin
  if iConexiones = 0 then
  begin
    DMPedidos:= TDMPedidos.Create( application );
  end;
  Inc( iConexiones );
end;

procedure DestruirModuloDeDatos;
begin
  Dec( iConexiones );
  if iConexiones = 0 then
  begin
    FreeAndNil( DMPedidos );
  end;
end;

function TDMPedidos.NuevaPedido( const AEmpresa, ACentro: string ): integer;
begin
  QNumeroPedido.ParamByName('empresa').AsString:= AEmpresa;
  QNumeroPedido.ParamByName('centro').AsString:= ACentro;
  QNumeroPedido.Open;
  Result:= QNumeroPedido.Fields[0].AsInteger + 1;
  QNumeroPedido.Close;
end;

function TDMPedidos.NuevaLinea( const AEmpresa, ACentro: string;
                                const APedido: integer ): integer;
begin
  QNumeroLinea.ParamByName('empresa').AsString:= AEmpresa;
  QNumeroLinea.ParamByName('centro').AsString:= ACentro;
  QNumeroLinea.ParamByName('pedido').AsInteger:= APedido;
  QNumeroLinea.Open;
  Result:= QNumeroLinea.Fields[0].AsInteger + 1;
  QNumeroLinea.Close;
end;

function TDMPedidos.Unidad( const AEmpresa, AProducto, AEnvase, ACliente: string ): string;
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

function TDMPedidos.DirSumValida( const AEmpresa, ACliente, ADirSum: string ): boolean;
begin
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

procedure TDMPedidos.QueryListado( const AEmpresa, ACentro, ACliente, AProducto, APedido:string;
                                   const AFechaIni, AFechaFin: TDateTime  );
begin
  QListado.SQL.Clear;

  QListado.SQL.Add(' select ');
  QListado.SQL.Add('        empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedido_pdc, cliente_pdc, ');
  QListado.SQL.Add('        dir_suministro_pdc, anulado_pdc, motivo_anulacion_pdc, ');
  QListado.SQL.Add('        producto_pdd,  envase_pdd, categoria_pdd, calibre_pdd, ');
  QListado.SQL.Add('        color_pdd,unidad_pdd, sum(unidades_pdd) unidades_pdd, ');

  QListado.SQL.Add('        ( select nvl(peso_neto_e,0) ');
  QListado.SQL.Add('        from frf_envases ');
  QListado.SQL.Add('        where empresa_e = empresa_pdc ');
  QListado.SQL.Add('        and envase_e = envase_pdd ');
  QListado.SQL.Add('        and producto_base_e = ( select producto_base_p ');
  QListado.SQL.Add('                               from frf_productos ');
  QListado.SQL.Add('                               where empresa_p = empresa_pdc ');
  QListado.SQL.Add('                                 and producto_p = producto_pdd ) ) peso_neto_e, ');
  QListado.SQL.Add('        ( select nvl(unidades_e,0) ');
  QListado.SQL.Add('        from frf_envases ');
  QListado.SQL.Add('        where empresa_e = empresa_pdc ');
  QListado.SQL.Add('        and envase_e = envase_pdd ');
  QListado.SQL.Add('        and producto_base_e = ( select producto_base_p ');
  QListado.SQL.Add('                               from frf_productos ');
  QListado.SQL.Add('                               where empresa_p = empresa_pdc ');
  QListado.SQL.Add('                                 and producto_p = producto_pdd ) ) unidades_e ');

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

  QListado.SQL.Add(' group by  empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedido_pdc, cliente_pdc, ');
  QListado.SQL.Add('           dir_suministro_pdc, anulado_pdc, motivo_anulacion_pdc, ');
  QListado.SQL.Add('           producto_pdd, envase_pdd, categoria_pdd, calibre_pdd, color_pdd,unidad_pdd ');

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

procedure TDMPedidos.DataModuleCreate(Sender: TObject);
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

  QTotalDetalle.SQL.Clear;
  QTotalDetalle.SQL.Add(' SELECT round( sum( case when unidad_pdd = ''C'' then unidades_pdd ');
  QTotalDetalle.SQL.Add('             when unidad_pdd = ''U'' then Round( unidades_pdd / ( select max(nvl(case when unidades_e = 0 then 1 else unidades_e end,1)) from frf_envases where empresa_e = empresa_pdd and envase_e = envase_pdd ) ) ');
  QTotalDetalle.SQL.Add('             when unidad_pdd = ''K'' then Round( unidades_pdd / ( select max(nvl(case when peso_neto_e = 0 then 1 else peso_neto_e end ,1)) from frf_envases where empresa_e = empresa_pdd and envase_e = envase_pdd ) ) ');
  QTotalDetalle.SQL.Add('        end ) ) cajas ');
  QTotalDetalle.SQL.Add(' from frf_pedido_det ');
  QTotalDetalle.SQL.Add(' where empresa_pdd = :empresa_pdc ');
  QTotalDetalle.SQL.Add(' and centro_pdd = :centro_pdc ');
  QTotalDetalle.SQL.Add(' and pedido_pdd = :pedido_pdc ');
  QTotalDetalle.Prepare;

end;

procedure TDMPedidos.DataModuleDestroy(Sender: TObject);
begin
  if QTotalDetalle.Prepared  then
    QTotalDetalle.UnPrepare;

  if QNumeroPedido.Prepared then
    QNumeroPedido.UnPrepare;

  if QNumeroLinea.Prepared  then
    QNumeroLinea.UnPrepare;

  if QUnidad.Prepared  then
    QUnidad.UnPrepare;

  if QSuministro.Prepared  then
    QSuministro.UnPrepare;
end;

procedure TDMPedidos.QMaestroAfterOpen(DataSet: TDataSet);
begin
  QTotalDetalle.Open;
end;

procedure TDMPedidos.QMaestroBeforeClose(DataSet: TDataSet);
begin
  QTotalDetalle.Close;
end;

procedure TDMPedidos.TDetalleAfterPost(DataSet: TDataSet);
begin
  if QTotalDetalle.Active then
  begin
    QTotalDetalle.Close;
    QTotalDetalle.Open;
  end;
end;

initialization
  iConexiones:= 0;

end.
