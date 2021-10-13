unit LDGastosEntregas;

interface

uses
  Forms, SysUtils, Classes, DB, DBTables;

type
  TDLGastosEntregas = class(TDataModule)
    QListado: TQuery;
    QDetalleGasto: TQuery;
    DataSource: TDataSource;
    QDetalleLinea: TQuery;
    procedure QListadoAfterOpen(DataSet: TDataSet);
    procedure QListadoBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    bVerDetalle: boolean;
  public
    { Public declarations }
    function ObtenerDatosCompletos( const AEmpresa, ACentro, AProveedor, AProducto, AEntrega, AGasto: string;
                           const AFechaIni, AFechaFin: TDateTime;
                           const APendientePago, ASinGasto: Boolean; const AEnvio: Integer;
                           const ATipoCodigo, ATipoFecha, ATipoCentro: integer ): boolean;
    function ObtenerDatosConduce( const AEmpresa, ACentro, AProveedor, AProducto, AEntrega, AGasto: string;
                           const AFechaIni, AFechaFin: TDateTime;
                           const APendientePago: Boolean; const AEnvio: Integer;
                           const ATipoCodigo, ATipoFecha, ATipoCentro: integer ): boolean;
    procedure CerrarQuery;
  end;

var
  DLGastosEntregas: TDLGastosEntregas;

implementation

{$R *.dfm}

function TDLGastosEntregas.ObtenerDatosCompletos( const AEmpresa, ACentro, AProveedor, AProducto, AEntrega, AGasto: string;
                                         const AFechaIni, AFechaFin: TDateTime;
                                         const APendientePago, ASinGasto: Boolean;  const AEnvio: Integer;
                                         const ATipoCodigo, ATipoFecha, ATipoCentro: integer ): boolean;
begin
  bVerDetalle:= True;

  with QDetalleLinea do
  begin
    SQL.Clear;
    SQL.Add('select producto_el, sum(kilos_el) kilos_el, round(sum(kilos_el*precio_kg_el),2) importe_el ');
    SQL.Add('from frf_entregas_l ');
    SQL.Add('where codigo_el = :codigo_ec ');
    if AProducto <> '' then
      SQL.Add('and producto_el = :producto ');
    SQL.Add('group by producto_el');
    SQL.Add('order by producto_el');
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
  end;

  with QDetalleGasto do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :codigo_ec ');
    if AGasto <> '' then
      SQL.Add('and tipo_ge = :gasto ');
    if AProducto <> '' then
      SQL.Add('  and ( nvl(producto_ge, '''' ) =  '''' or producto_ge = :producto ) ');
    if APendientePago then
      SQL.Add('  and nvl(pagado_ge,0) = 0 ');
    case AEnvio of
      1: SQL.Add('  and  envio_ge = 0 ');
      2: SQL.Add('  and envio_ge <> 0 ');
    end;
    SQL.Add(' order by tipo_ge, producto_ge ');

    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AGasto <> '' then
      ParamByName('gasto').AsString:= AGasto;
  end;

  with QListado do
  begin
    SQL.Clear;
    if ATipoFecha = 0 then
      SQL.Add('select empresa_ec, proveedor_ec, fecha_origen_ec fecha, codigo_ec, adjudicacion_ec ')
    else
      SQL.Add('select empresa_ec, proveedor_ec, fecha_llegada_ec fecha, codigo_ec, adjudicacion_ec ');
    SQL.Add('from frf_entregas_c ');

    if AEntrega <> '' then
    begin
      if ATipoCodigo = 0 then
        SQL.Add('where codigo_ec = :entrega ')
      else
        SQL.Add('where adjudicacion_ec = :entrega ');
    end
    else
    begin
      if ATipoFecha = 0 then
        SQL.Add('where fecha_origen_ec between :fechaini and :fechafin ')
      else
        SQL.Add('where fecha_llegada_ec between :fechaini and :fechafin ');
    end;
    if AEmpresa <> '' then
      SQL.Add('and empresa_ec = :empresa ');

    if ACentro <> '' then
    begin
      if ATipoCentro = 0 then
         SQL.Add('and centro_origen_ec = :centro ')
      else
        SQL.Add('and centro_llegada_ec = :centro ');
    end;
    if AProveedor <> '' then
      SQL.Add('and TRIM(proveedor_ec) = :proveedor ');
    if AProducto <> '' then
    begin
      SQL.Add('and exists ');
      SQL.Add('(');
      SQL.Add('  select * ');
      SQL.Add('  from frf_entregas_l ');
      SQL.Add('  where codigo_el = codigo_ec ');
      SQL.Add('  and producto_el = :producto ');
      SQL.Add(')');
    end;

    if not ASinGasto then
    begin
      SQL.Add('and exists ');
      SQL.Add('(');
      SQL.Add('  select * ');
      SQL.Add('  from frf_gastos_entregas ');
      SQL.Add('  where codigo_ge = codigo_ec ');
      if AGasto <> '' then
        SQL.Add('and tipo_ge = :gasto ');
      if APendientePago then
        SQL.Add('  and nvl(pagado_ge,0) = 0 ');
      case AEnvio of
        1: SQL.Add('  and  envio_ge = 0 ');
        2: SQL.Add('  and envio_ge <> 0 ');
      end;
      SQL.Add(')');
    end;

    if ATipoFecha = 0 then
      SQL.Add('group by codigo_ec, empresa_ec, proveedor_ec, fecha_origen_ec, adjudicacion_ec ')
    else
      SQL.Add('group by codigo_ec, empresa_ec, proveedor_ec, fecha_llegada_ec, adjudicacion_ec ');
    SQL.Add('order by empresa_ec, proveedor_ec, codigo_ec');

    if AEntrega <> '' then
    begin
      ParamByName('entrega').AsString:= AEntrega;
    end
    else
    begin
      ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
    end;
    if AEmpresa <> '' then
    begin
      ParamByName('empresa').AsString:= AEmpresa;
    end;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if ( not ASinGasto ) and ( AGasto <> '' ) then
      ParamByName('gasto').AsString:= AGasto;

    Open;
    Result:= not IsEmpty;
  end;
end;

function TDLGastosEntregas.ObtenerDatosConduce( const AEmpresa, ACentro, AProveedor, AProducto, AEntrega, AGasto: string;
                                         const AFechaIni, AFechaFin: TDateTime;
                                         const APendientePago: Boolean; const AEnvio: Integer;
                                         const ATipoCodigo, ATipoFecha, ATipoCentro: integer ): boolean;
begin
  bVerDetalle:= False;

  with QListado do
  begin
    SQL.Clear;

    SQL.Add('select empresa_ec empresa, adjudicacion_ec conduce, tipo_ge tipo, descripcion_tg descripcion, sum(importe_ge) importe ');
    SQL.Add('from frf_entregas_c, frf_gastos_entregas, frf_tipo_gastos ');
    SQL.Add('where codigo_ec = codigo_ge ');
    SQL.Add('  and tipo_ge = tipo_tg ');

    if AEntrega <> '' then
    begin
      if ATipoCodigo = 0 then
        SQL.Add('and codigo_ec = :entrega ')
      else
        SQL.Add('and adjudicacion_ec = :entrega ');
    end
    else
    begin
      if ATipoFecha = 0 then
        SQL.Add('and fecha_origen_ec between :fechaini and :fechafin ')
      else
        SQL.Add('and fecha_llegada_ec between :fechaini and :fechafin ');
    end;
    if AEmpresa <> '' then
      SQL.Add('and empresa_ec = :empresa ');
    if ACentro <> '' then
    begin
      if ATipoCentro = 0 then
        SQL.Add('and centro_origen_ec = :centro ')
      else
        SQL.Add('and centro_llegada_ec = :centro ');
    end;
    if AProveedor <> '' then
    begin
        SQL.Add('and TRIM(proveedor_ec) = :proveedor ');
    end;
    if AProducto <> '' then
    begin
      SQL.Add('  and producto_el = :producto ');
    end;

    if AGasto <> '' then
    begin
      SQL.Add('  and tipo_ge = :gasto ');
    end;
    if APendientePago then
    begin
      SQL.Add('  and nvl(pagado_ge,0) = 0 ');
    end;
    case AEnvio of
      1: SQL.Add('  and envio_ge = 0 ');
      2: SQL.Add('  and envio_ge <> 0 ');
    end;

      SQL.Add(' group by empresa_ec, adjudicacion_ec, tipo_ge, descripcion_tg ');
      SQL.Add(' order by empresa, conduce, tipo ');

    if AEntrega <> '' then
    begin
      ParamByName('entrega').AsString:= AEntrega;
    end
    else
    begin
      ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
    end;
    if AEmpresa <> '' then
      ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AGasto <> '' then
      ParamByName('gasto').AsString:= AGasto;

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TDLGastosEntregas.CerrarQuery;
begin
  QListado.Close;
end;

procedure TDLGastosEntregas.QListadoAfterOpen(DataSet: TDataSet);
begin
  if bVerDetalle then
  begin
    QDetalleLinea.Open;
    QDetalleGasto.Open;
  end;
end;

procedure TDLGastosEntregas.QListadoBeforeClose(DataSet: TDataSet);
begin
  if bVerDetalle then
  begin
    QDetalleLinea.Close;
    QDetalleGasto.Close;
  end;
end;

end.
