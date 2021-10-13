unit DMListadoControlEntregas;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMListadoControlEntregasForm = class(TDataModule)
    QListado: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConfigurarListado( const AEmpresa, ACentro, AProducto, AProveedor, AAlmacen: String;
                                 const AAgrupar: integer;
                                 const AFechaCarga, AEstadoFecha, ATipoEntrega: integer;
                                 const AMatricula: Boolean );
    function  ObtenerListado( const AEmpresa, ACentro, AProducto, AProveedor, AAlmacen: String;
                              const AFechaIni, AFechaFin: TDateTime ): boolean;
  end;

implementation

uses UDMBaseDatos, Dialogs;

{$R *.dfm}

procedure TDMListadoControlEntregasForm.ConfigurarListado( const AEmpresa, ACentro, AProducto, AProveedor, AAlmacen: String; const AAgrupar: integer;
                              const AFechaCarga, AEstadoFecha, ATipoEntrega: integer; const AMatricula: Boolean );
begin
  with QListado do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        fecha_carga_ec fechaCarga, codigo_ec entrega, anyo_semana_ec SemanaOrden,');
    SQL.Add('        adjudicacion_ec facturaConduce, proveedor_ec codProveedor,');
    SQL.Add('        (select nombre_p from frf_proveedores where empresa_p = empresa_ec and proveedor_p = proveedor_ec ) nomProveedor, ');
    SQL.Add('        almacen_el codAlmacen, ');
    SQL.Add('        (select nombre_pa from frf_proveedores_almacen where empresa_pa = empresa_ec and proveedor_pa = proveedor_ec and almacen_pa = almacen_el) nomAlmacen, ');
    SQL.Add('        transporte_ec codTransporte, ');
    SQL.Add('        (select descripcion_t from frf_transportistas where empresa_t = empresa_ec and transporte_t = transporte_ec) nomTransporte, ');
    SQL.Add('        vehiculo_ec matricula, termografo_ec termografo, aduana_ec puerto, ');
    SQL.Add('        ( select descripcion_a from frf_aduanas where codigo_a = aduana_ec ) des_puerto, ');
    SQL.Add('        centro_llegada_ec centroLLegada, fecha_llegada_ec fechaLlegada, ');
    SQL.Add('        producto_el producto, ( select descripcion_p from frf_productos where empresa_p = empresa_ec and producto_p = producto_el ) des_producto, empresa_ec,');
    SQL.Add('        sum( palets_el) palets, ');
    SQL.Add('        sum( cajas_el) cajas, ');
    SQL.Add('        sum( kilos_el) kilos ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l ');

    SQL.Add(' where codigo_el = codigo_ec ');

    if AEmpresa <> '' then
     SQL.Add(' and empresa_ec = :empresa ');

    if ACentro <> '' then
      SQL.Add(' and centro_llegada_ec = :centro ');

    if AProveedor <> '' then
      SQL.Add(' and proveedor_ec = :proveedor ');

    if AAlmacen <> '' then
      SQL.Add(' and almacen_el = :almacen ');

    case AFechaCarga of
      0: SQL.Add(' and fecha_origen_ec between :fechaini and :fechafin ');
      1: SQL.Add(' and fecha_llegada_ec between :fechaini and :fechafin ');
      2: SQL.Add(' and fecha_carga_ec between :fechaini and :fechafin ');
    end;

    case AEstadoFecha of
      0: SQL.Add(' and fecha_llegada_definitiva_ec = 1 ');
      1: SQL.Add(' and fecha_llegada_definitiva_ec = 0 ');
    end;

    case ATipoEntrega of
      0: SQL.Add(' and status_ec <> 3 ');
      1: SQL.Add(' and status_ec = 3 ');
    end;

    if AProducto <> '' then
      SQL.Add(' and producto_el = :producto ');
    SQL.Add(' group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19 ');
    if AAgrupar = 1 then
      SQL.Add(' order by codProveedor, codAlmacen, 1,2 ')
    else
    if AAgrupar = 2 then
      SQL.Add(' order by producto, 1,2 ')
    else
      SQL.Add(' order by 1,2 ');
  end;
end;

function TDMListadoControlEntregasForm.ObtenerListado( const AEmpresa, ACentro, AProducto, AProveedor, AAlmacen: String;
                              const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  with QListado do
  begin
    ParamByName('fechaini').AsDate:= AFechaIni;
    ParamByName('fechaFin').AsDate:= AFechaFin;
    if AEmpresa <> '' then
      ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AAlmacen <> '' then
      ParamByName('almacen').AsString:= AAlmacen;
    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;

    Open;
    result:= not IsEmpty;
  end;
end;

end.
