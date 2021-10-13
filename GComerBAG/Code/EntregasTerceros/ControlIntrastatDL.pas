unit ControlIntrastatDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLControlIntrastat = class(TDataModule)
    QControlIntrastat: TQuery;

  private
    { Private declarations }

  public
    { Public declarations }
    procedure DatosEntrega( const AEmpresa, AProducto, AProveedor: string;
                            const AAsimilada, AComunitaria, AImportacion, ANacional, AISP, ASinAsignar : Boolean;
                            const AFactura, AFlete, ATerrestre : Boolean);
  end;

function ObtenerDatos( const AOwner: TComponent; const AEmpresa, AProducto, AProveedor: string;
                       const AFechaIni, AFechaFin: TDateTime;
                       const AAsimilada, AComunitaria, AImportacion, ANacional, AISP, ASinAsignar : Boolean;
                       const AFactura, AFlete, ATerrestre : Boolean): Boolean;
procedure CerrarTablas;

var
  DLControlIntrastat: TDLControlIntrastat;

implementation

{$R *.dfm}

uses variants, bMath;

function ObtenerDatos( const AOwner: TComponent; const AEmpresa, AProducto, AProveedor: string;
                       const AFechaIni, AFechaFin: TDateTime;
                       const AAsimilada, AComunitaria, AImportacion, ANacional, AISP, ASinAsignar : Boolean;
                       const AFactura, AFlete, ATerrestre : Boolean): Boolean;
begin
  DLControlIntrastat:= TDLControlIntrastat.Create( AOwner );
  with DLControlIntrastat do
  begin
    DatosEntrega( AEmpresa, AProducto, AProveedor, AAsimilada, AComunitaria, AImportacion, ANacional, AISP, ASinAsignar, AFactura, AFlete, ATerrestre );

    QControlIntrastat.ParamByName('fechaini').AsDateTime:= AFechaIni;
    QControlIntrastat.ParamByName('fechaFin').AsDateTime:= AFechaFin;

    if AEmpresa <> '' then
      QControlIntrastat.ParamByName('empresa').AsString:= AEmpresa;

    if AProducto <> '' then
      QControlIntrastat.ParamByName('producto').AsString:= AProducto;

    if AProveedor <> '' then
      QControlIntrastat.ParamByName('proveedor').AsString:= AProveedor;

    QControlIntrastat.Open;
    result:= not QControlIntrastat.IsEmpty;
  end;
end;

procedure CerrarTablas;
begin
  DLControlIntrastat.QControlIntrastat.Close;
  FreeAndNil( DLControlIntrastat );
end;


procedure TDLControlIntrastat.DatosEntrega( const AEmpresa, AProducto, AProveedor: string;
                                const AAsimilada, AComunitaria, AImportacion, ANacional, AISP, ASinAsignar : Boolean;
                                const AFactura, AFlete, ATerrestre : Boolean);
var
  sAux: string;
begin
  with QControlIntrastat do
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
    if AProveedor <> '' then
      SQL.Add(' and proveedor_ec = :proveedor ');

    if AAsimilada then
      sAux:= ' intrastat_ec = ''A'' ';
    if AComunitaria then
    begin
      if sAux <> '' then
        sAux:= sAux + ' or intrastat_ec = ''C'' '
      else
        sAux:= ' intrastat_ec = ''C'' ';
    end;
    if AImportacion then
    begin
      if sAux <> '' then
        sAux:= sAux + ' or intrastat_ec = ''I'' '
      else
        sAux:= ' intrastat_ec = ''I'' ';
    end;
    if ANacional then
    begin
      if sAux <> '' then
        sAux:= sAux + ' or intrastat_ec = ''N'' '
      else
        sAux:= ' intrastat_ec = ''N'' ';
    end;
    if AISP then
    begin
      if sAux <> '' then
        sAux:= sAux + ' or intrastat_ec = ''S'' '
      else
        sAux:= ' intrastat_ec = ''S'' ';
    end;
    if ASinAsignar then
    begin
      if sAux <> '' then
        sAux:= sAux + ' or intrastat_ec is NULL '
      else
        sAux:= ' intrastat_ec is NULL ';
    end;
    if sAux <> '' then
    begin
       SQL.Add(' and (' + sAux + ') ');
    end;

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

