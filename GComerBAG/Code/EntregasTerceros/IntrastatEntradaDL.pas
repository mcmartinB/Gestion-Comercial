unit IntrastatEntradaDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLIntrastatEntrada = class(TDataModule)
    QIntrastatEntrada: TQuery;

  private
    { Private declarations }

  public
    { Public declarations }
    procedure DatosEntrega( const AEmpresa, AProducto: string );
  end;

function ObtenerDatos( const AOwner: TComponent; const AEmpresa, AProducto: string;
                       const AFechaIni, AFechaFin: TDateTime ): Boolean;
procedure CerrarTablas;

var
  DLIntrastatEntrada: TDLIntrastatEntrada;

implementation

{$R *.dfm}

uses variants, bMath;

function ObtenerDatos( const AOwner: TComponent; const AEmpresa, AProducto: string;
                       const AFechaIni, AFechaFin: TDateTime ): Boolean;
begin
  DLIntrastatEntrada:= TDLIntrastatEntrada.Create( AOwner );
  with DLIntrastatEntrada do
  begin
    DatosEntrega( AEmpresa, AProducto );

    QIntrastatEntrada.ParamByName('fechaini').AsDateTime:= AFechaIni;
    QIntrastatEntrada.ParamByName('fechaFin').AsDateTime:= AFechaFin;

    if AEmpresa <> '' then
      QIntrastatEntrada.ParamByName('empresa').AsString:= AEmpresa;
    if AProducto <> '' then
      QIntrastatEntrada.ParamByName('producto').AsString:= AProducto;

    QIntrastatEntrada.Open;
    result:= not QIntrastatEntrada.IsEmpty;
  end;
end;

procedure CerrarTablas;
begin
  DLIntrastatEntrada.QIntrastatEntrada.Close;
  FreeAndNil( DLIntrastatEntrada );
end;

procedure TDLIntrastatEntrada.DatosEntrega( const AEmpresa, AProducto: string );
begin
  with QIntrastatEntrada do
  begin
    SQL.Clear;
    SQL.Add(' select intrastat_ec, codigo_ec, empresa_ec, proveedor_Ec, nvl(pais_pa,pais_p) pais, producto_el, variedad_el, pais_origen_pp, ');
    SQL.Add('        sum(kilos_el) kilos_variedad, ');
    SQL.Add('        ( select sum(kilos_el) from frf_entregas_l el where codigo_Ec = el.codigo_el and el.producto_el = e.producto_el ) kilos_producto, ');
    SQL.Add('        ( select sum(kilos_el) from frf_entregas_l el where codigo_Ec = el.codigo_el ) kilos_entrega, ');
//    SQL.Add('        ( select sum(importe_ge) from frf_gastos_entregas where codigo_Ec = codigo_ge and tipo_ge in (''010'',''020'',''030'') ) gastos_factura, ');
//    SQL.Add('        ( select sum(importe_ge) from frf_gastos_entregas where codigo_Ec = codigo_ge and tipo_ge in (''040'') ) gastos_transporte, ');
//    SQL.Add('        ( select sum(importe_ge) from frf_gastos_entregas where codigo_Ec = codigo_ge and tipo_ge in (''120'') ) gastos_terrestre ');
    SQL.Add('        ( select sum(importe_ge) from frf_gastos_entregas where codigo_Ec = codigo_ge and tipo_ge in (''054'',''055'',''056'') ) gastos_factura, ');
    SQL.Add('        ( select sum(importe_ge) from frf_gastos_entregas where codigo_Ec = codigo_ge and tipo_ge in (''012'') ) gastos_transporte, ');
    SQL.Add('        ( select sum(importe_ge) from frf_gastos_entregas where codigo_Ec = codigo_ge and tipo_ge in (''016'') ) gastos_terrestre ');

    SQL.Add(' from frf_entregas_c, frf_proveedores, frf_entregas_l e, frf_productos_proveedor, frf_proveedores_almacen ');
    SQL.Add(' where  fecha_llegada_ec between :fechaini and :fechafin ');
    if AEmpresa <> '' then
      SQL.Add(' and empresa_ec = :empresa ');
    SQL.Add(' and intrastat_ec = ''C'' ');
    SQL.Add(' and proveedor_ec = proveedor_p ');
    SQL.Add(' and codigo_ec = codigo_el ');
    if AProducto <> '' then
      SQL.Add(' and producto_el = :producto ');
    SQL.Add(' and proveedor_el = proveedor_pp ');
    SQL.Add(' and producto_el = producto_pp ');
    SQL.Add(' and variedad_el = variedad_pp ');

    SQL.Add(' and proveedor_pa = proveedor_el ');
    SQL.Add(' and almacen_pa = almacen_el ');
        
    SQL.Add(' group by intrastat_ec, codigo_ec, empresa_ec, proveedor_Ec, pais, producto_el, variedad_el, pais_origen_pp ');
    SQL.Add(' order by intrastat_ec, codigo_ec, empresa_ec, proveedor_Ec, pais, producto_el, variedad_el, pais_origen_pp ');
  end;
end;


end.
