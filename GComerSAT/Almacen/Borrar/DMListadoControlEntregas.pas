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
    procedure ConfigurarListado( const ACentro, AProducto: String;
                                 const AFechaCarga: integer; const  ACentroOrigen, AMatricula: Boolean );
    function  ObtenerListado( const AEmpresa, ACentro, AProducto: String;
                              const AFechaIni, AFechaFin: TDateTime ): boolean;
  end;

implementation

uses UDMBaseDatos, Dialogs;

{$R *.dfm}

procedure TDMListadoControlEntregasForm.ConfigurarListado( const ACentro, AProducto: String;
                              const AFechaCarga: integer; const ACentroOrigen, AMatricula: Boolean );
begin
  with QListado do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        fecha_carga_ec fechaCarga, ');
    SQL.Add('        albaran_ec SemanaOrden, ');
    SQL.Add('        adjudicacion_ec facturaConduce, ');
    SQL.Add('        proveedor_ec codProveedor, ');
    SQL.Add('        almacen_ec codAlmacen, ');
    SQL.Add('        (select nombre_pa from frf_proveedores_almacen where empresa_pa = :empresa and proveedor_pa = proveedor_ec and almacen_pa = almacen_ec) nomAlmacen, ');
    SQL.Add('        transporte_ec codTransporte, ');
    SQL.Add('        (select descripcion_t from frf_transportistas where empresa_t = :empresa and transporte_t = transporte_ec) nomTransporte, ');
    if AMatricula then
      SQL.Add('        vehiculo_ec datosVar, ')
    else
      SQL.Add('        termografo_ec datosVar, ');
    SQL.Add('        vehiculo_ec matricula, termografo_ec termografo, aduana_ec puerto, ');
    SQL.Add('        centro_llegada_ec centroLLegada, fecha_llegada_ec fechaLlegada, ');
    SQL.Add('        sum( cajas_el) cajas, ');
    SQL.Add('        sum( kilos_el) kilos ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l ');
    SQL.Add(' where empresa_ec = :empresa ');

    if ACentroOrigen then
    begin
      if ACentro <> '' then
        SQL.Add(' and centro_origen_ec = :centro ');
    end
    else
    begin
      if ACentro <> '' then
        SQL.Add(' and centro_llegada_ec = :centro ');
    end;

    case AFechaCarga of
      0: SQL.Add(' and fecha_origen_ec between :fechaini and :fechafin ');
      1: SQL.Add(' and fecha_llegada_ec between :fechaini and :fechafin ');
      2: SQL.Add(' and fecha_carga_ec between :fechaini and :fechafin ');
    end;

    SQL.Add(' and codigo_el = codigo_ec ');
    if AProducto <> '' then
      SQL.Add(' and producto_el = :producto ');
    SQL.Add(' group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14 ');
    SQL.Add(' order by 1,2 ');
  end;
end;

function TDMListadoControlEntregasForm.ObtenerListado( const AEmpresa, ACentro, AProducto: String;
                              const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  with QListado do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('fechaini').AsDate:= AFechaIni;
    ParamByName('fechaFin').AsDate:= AFechaFin;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;

    Open;
    result:= not IsEmpty;
  end;
end;

end.
