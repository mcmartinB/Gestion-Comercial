unit PedidosSinAsignarDL;

interface

uses
  forms, SysUtils, Classes, DB, DBTables;

type
  TDLPedidosSinAsignar = class(TDataModule)
    QPedidosSinAsignar: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure SQLPedidosSinAsignar( const ACliente, ASuministro: string );
    procedure SQLSalidasSinAsignar( const ACliente, ASuministro: string );
  public
    { Public declarations }
    procedure CargaQuery( const AEmpresa, ACentro, ACliente, ASuministro: string;
                          const AFechaIni, AFechaFin: TDateTime; const APedidos: Boolean );
  end;

procedure CrearModuloDeDatos;
procedure DestruirModuloDeDatos;

var
  DLPedidosSinAsignar: TDLPedidosSinAsignar;

implementation

{$R *.dfm}
var
  iConexiones: Integer;

procedure CrearModuloDeDatos;
begin
  if iConexiones = 0 then
  begin
    DLPedidosSinAsignar:= TDLPedidosSinAsignar.Create( application );
  end;
  Inc( iConexiones );
end;

procedure DestruirModuloDeDatos;
begin
  Dec( iConexiones );
  if iConexiones = 0 then
  begin
    FreeAndNil( DLPedidosSinAsignar );
  end;
end;

procedure TDLPedidosSinAsignar.SQLPedidosSinAsignar( const ACliente, ASuministro: string );
begin
  if QPedidosSinAsignar.Prepared then
    QPedidosSinAsignar.UnPrepare;

  QPedidosSinAsignar.SQL.Clear;
  QPedidosSinAsignar.SQL.Add(' select empresa_pdc empresa, centro_pdc centro, ');
  QPedidosSinAsignar.SQL.Add('        cliente_pdc cliente, dir_suministro_pdc suministro, ');
  QPedidosSinAsignar.SQL.Add('        ref_pedido_pdc referencia, fecha_pdc fecha, ');
  QPedidosSinAsignar.SQL.Add('        pedido_pdc pedido ');
  QPedidosSinAsignar.SQL.Add(' from frf_pedido_cab ');
  QPedidosSinAsignar.SQL.Add(' where empresa_pdc = :empresa ');
  QPedidosSinAsignar.SQL.Add(' and centro_pdc = :centro ');
  QPedidosSinAsignar.SQL.Add(' and fecha_pdc between :fechaini and :fechafin ');
  if ACliente <> '' then
    QPedidosSinAsignar.SQL.Add(' and cliente_pdc = :cliente ');
  if ASuministro <> '' then
    QPedidosSinAsignar.SQL.Add(' and dir_suministro_pdc = :suministro ');
  QPedidosSinAsignar.SQL.Add(' and anulado_pdc = 0 ');
  QPedidosSinAsignar.SQL.Add(' and not exists ');
  QPedidosSinAsignar.SQL.Add(' ( ');
  QPedidosSinAsignar.SQL.Add('   select * ');
  QPedidosSinAsignar.SQL.Add('   from frf_salidas_c ');
  QPedidosSinAsignar.SQL.Add('   where empresa_sc = :empresa ');
  QPedidosSinAsignar.SQL.Add('     and centro_salida_sc = :centro ');
  QPedidosSinAsignar.SQL.Add('     and n_pedido_sc = ref_pedido_pdc ');
  QPedidosSinAsignar.SQL.Add('     and fecha_sc between fecha_pdc - 60 and fecha_pdc + 60 ');
  if ACliente <> '' then
    QPedidosSinAsignar.SQL.Add('     and cliente_sal_sc = :cliente ')
  else
    QPedidosSinAsignar.SQL.Add('     and cliente_sal_sc = cliente_pdc ');
  if ASuministro <> '' then
    QPedidosSinAsignar.SQL.Add('     and dir_sum_sc = :suministro ')
  else
    QPedidosSinAsignar.SQL.Add('     and dir_sum_sc = dir_suministro_pdc ');
  QPedidosSinAsignar.SQL.Add(' ) ');
  QPedidosSinAsignar.SQL.Add(' order by empresa, centro, cliente, suministro, fecha, referencia');
  QPedidosSinAsignar.Prepare;
end;

procedure TDLPedidosSinAsignar.SQLSalidasSinAsignar( const ACliente, ASuministro: string );
begin
  if QPedidosSinAsignar.Prepared then
    QPedidosSinAsignar.UnPrepare;

  QPedidosSinAsignar.SQL.Clear;
  QPedidosSinAsignar.SQL.Add(' select empresa_sc empresa, centro_salida_sc centro, ');
  QPedidosSinAsignar.SQL.Add('        cliente_sal_sc cliente, dir_sum_sc suministro, ');
  QPedidosSinAsignar.SQL.Add('        n_albaran_sc referencia, fecha_sc fecha, ');
  QPedidosSinAsignar.SQL.Add('        n_pedido_sc pedido ');
  QPedidosSinAsignar.SQL.Add(' from frf_salidas_c ');
  QPedidosSinAsignar.SQL.Add(' where empresa_sc = :empresa ');
  QPedidosSinAsignar.SQL.Add('   and centro_salida_sc = :centro ');
  QPedidosSinAsignar.SQL.Add('   and fecha_sc between :fechaini and :fechafin ');
  if ACliente <> '' then
    QPedidosSinAsignar.SQL.Add('   and cliente_sal_sc = :cliente ');
  if ASuministro <> '' then
    QPedidosSinAsignar.SQL.Add('   and dir_sum_sc = :suministro ');
  QPedidosSinAsignar.SQL.Add(' and not exists ');
  QPedidosSinAsignar.SQL.Add(' ( ');
  QPedidosSinAsignar.SQL.Add('   select * ');
  QPedidosSinAsignar.SQL.Add('   from frf_pedido_cab ');
  QPedidosSinAsignar.SQL.Add('   where empresa_pdc = :empresa ');
  QPedidosSinAsignar.SQL.Add('     and centro_pdc = :centro ');
  QPedidosSinAsignar.SQL.Add('     and fecha_pdc between fecha_sc - 60 and fecha_sc + 60 ');
  QPedidosSinAsignar.SQL.Add('     and ref_pedido_pdc = n_pedido_sc ');
  if ACliente <> '' then
    QPedidosSinAsignar.SQL.Add('     and cliente_pdc = :cliente ')
  else
    QPedidosSinAsignar.SQL.Add('     and cliente_pdc = cliente_sal_sc ');
  if ASuministro <> '' then
    QPedidosSinAsignar.SQL.Add('     and dir_suministro_pdc = :suministro ')
  else
    QPedidosSinAsignar.SQL.Add('     and dir_suministro_pdc = dir_sum_sc  ');
  QPedidosSinAsignar.SQL.Add('     and anulado_pdc = 0 ');
  QPedidosSinAsignar.SQL.Add(' ) ');
  QPedidosSinAsignar.SQL.Add(' order by empresa, centro, cliente, suministro, fecha, referencia');
  QPedidosSinAsignar.Prepare;
end;

procedure TDLPedidosSinAsignar.CargaQuery( const AEmpresa, ACentro, ACliente, ASuministro: string;
                      const AFechaIni, AFechaFin: TDateTime; const APedidos: Boolean );
begin
  if APedidos then
    SQLPedidosSinAsignar( ACliente, ASuministro )
  else
    SQLSalidasSinAsignar( ACliente, ASuministro );
  with QPedidosSinAsignar do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    if ASuministro <> '' then
      ParamByName('suministro').AsString:= ASuministro;
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
  end;
end;

procedure TDLPedidosSinAsignar.DataModuleCreate(Sender: TObject);
begin
  SQLPedidosSinAsignar( '', '' );
end;

procedure TDLPedidosSinAsignar.DataModuleDestroy(Sender: TObject);
begin
  if QPedidosSinAsignar.Prepared then
    QPedidosSinAsignar.UnPrepare;
end;

initialization
  iConexiones:= 0;

end.
