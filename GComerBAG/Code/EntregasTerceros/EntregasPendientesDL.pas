unit EntregasPendientesDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLEntregasPendientes = class(TDataModule)
    QEntregasPendientes: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure DesPreparaQuery;
    procedure PreparaQueryEntregasPendientes( const AProducto, AFechaIni, AFechaFin: string;
                                              const AEstadoEntrega, AEstadoFecha: Integer );
  public
    { Public declarations }
    function  DatosQueryEntregasPendientes( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
                                            const AEstadoEntrega, AEstadoFecha: Integer ): boolean;
  end;

implementation

{$R *.dfm}

procedure TDLEntregasPendientes.DesPreparaQuery;
begin
  QEntregasPendientes.Close;
  if QEntregasPendientes.Prepared then
    QEntregasPendientes.UnPrepare;
end;

procedure TDLEntregasPendientes.PreparaQueryEntregasPendientes( const AProducto, AFechaIni, AFechaFin: string;
                                                                const AEstadoEntrega, AEstadoFecha: Integer  );
begin
  DesPreparaQuery;
  with QEntregasPendientes do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec entrega, fecha_llegada_ec fecha, proveedor_ec proveedor, almacen_el almacen, ');
    SQL.Add('        producto_el producto, variedad_el variedad, descripcion_breve_pp descripcion, ');
    SQL.Add('        vehiculo_ec matricula, pais_origen_pp pais, categoria_el categoria, calibre_el calibre,  ');
    SQL.Add('        sum(palets_el) palets, sum(kilos_el) peso, sum(cajas_el) cajas  ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l, frf_productos_proveedor  ');
    SQL.Add(' where empresa_ec = :empresa  ');
    SQL.Add(' and centro_llegada_ec = :centro  ');
    //0:CREADA
    //1:EN EL ALMACEN (recibir)
    //2:FINALIZAR DESCARGA
    //3:EN LA CENTRAL (enviar)
    case AEstadoEntrega of
      0: SQL.Add(' and nvl(status_ec,0) < 2  ');
      1: SQL.Add(' and nvl(status_ec,0) = 2  ');
    end;
    case AEstadoFecha of
      0: SQL.Add(' and nvl(fecha_llegada_definitiva_ec,0) = 1  ');
      1: SQL.Add(' and nvl(fecha_llegada_definitiva_ec,0) = 0  ');
    end;

    if AFechaIni <> '' then
      SQL.Add(' and fecha_llegada_ec >= :fechaini ');
    if AFechaFin <> '' then
      SQL.Add(' and fecha_llegada_ec <= :fechafin ');

    SQL.Add(' and codigo_el = codigo_ec  ');
    if AProducto <> '' then
      SQL.Add(' and producto_el = :producto  ');

    SQL.Add(' and proveedor_pp = proveedor_el ');
    SQL.Add(' and producto_pp = producto_el ');
    SQL.Add(' and variedad_pp = variedad_el ');

    SQL.Add(' group by codigo_ec, fecha_llegada_ec, proveedor_ec, almacen_el, producto_el, variedad_el, ');
    SQL.Add('          descripcion_breve_pp, vehiculo_ec, pais_origen_pp, categoria_el, calibre_el  ');
    SQL.Add(' order by producto_el, proveedor_ec, variedad_el, calibre_el, codigo_ec, fecha_llegada_ec  ');

    Prepare;
  end;
end;

procedure TDLEntregasPendientes.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuery;
end;

function TDLEntregasPendientes.DatosQueryEntregasPendientes( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
                                                             const AEstadoEntrega, AEstadoFecha: Integer ): boolean;
begin
  PreparaQueryEntregasPendientes( AProducto, AFechaIni, AFechaFin, AEstadoEntrega, AEstadoFecha );
  with QEntregasPendientes do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if AFechaIni <> '' then
      ParamByName('fechaini').AsDateTime:= StrToDate( AFechaIni );
    if AFechaFin <> '' then
      ParamByName('fechafin').AsDateTime:= StrToDate( AFechaFin );
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    Open;
    result:= not IsEmpty;
  end;
end;

end.
