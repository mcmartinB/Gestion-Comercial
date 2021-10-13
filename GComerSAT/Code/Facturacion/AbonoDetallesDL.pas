unit AbonoDetallesDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLAbonoDetalles = class(TDataModule)
    QListadoAbonoDetalles: TQuery;

  private
    { Private declarations }
    procedure PreparaQuery( const AProducto, AEnvase, ACliente: string; const AAnulaciones: boolean );
  public
    { Public declarations }
    procedure CerrarTabla;
    function DatosListado( const AEmpresa, AProducto, AEnvase, ACliente: string;
                           const AFechaIni, AFechaFin: TDateTime;
                           const AAnulaciones: boolean ): boolean;
  end;

implementation

{$R *.dfm}

uses variants;

procedure TDLAbonoDetalles.PreparaQuery( const AProducto, AEnvase, ACliente: string; const AAnulaciones: boolean );
begin
  with QListadoAbonoDetalles do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_f, n_factura_f abono, fecha_factura_f fecha_abono, cliente_sal_f, ');
    SQL.Add('        case when n_albaran_fal is not null then ');
    SQL.Add('                 ( select n_factura_sc from frf_salidas_c where empresa_sc = :empresa and centro_salida_sc = centro_salida_fal and n_albaran_sc = n_albaran_fal and fecha_sc = fecha_albaran_fal ) ');
    SQL.Add('             else ');
    SQL.Add('                 ( select n_factura_fa from frf_facturas_abono where empresa_fa = :empresa and n_abono_fa = n_factura_f and fecha_abono_fa = fecha_factura_f ) end n_factura, ');
    SQL.Add('        case when n_albaran_fal is not null then ');
    SQL.Add('                 ( select fecha_factura_sc from frf_salidas_c where empresa_sc = :empresa and centro_salida_sc = centro_salida_fal and n_albaran_sc = n_albaran_fal and fecha_sc = fecha_albaran_fal ) ');
    SQL.Add('             else ');
    SQL.Add('                 ( select fecha_factura_fa from frf_facturas_abono where empresa_fa = :empresa and n_abono_fa = n_factura_f and fecha_abono_fa = fecha_factura_f ) end fecha_factura, ');
    SQL.Add('        centro_salida_fal, n_albaran_fal, fecha_albaran_fal, producto_fal, envase_fal, ');
    SQL.Add('        nvl(unidad_fal, ''IMP'') unidad_fal, nvl(unidades_fal,1) unidades_fal, precio_fal, ');
    SQL.Add('        case when n_albaran_fal is not null then ');
    SQL.Add('                  importe_fal ');
    SQL.Add('             else ');
    SQL.Add('                  importe_total_f end importe_total, ');
    SQL.Add('        moneda_f ');

    if not AAnulaciones then
      SQL.Add(' from frf_facturas, frf_fac_abonos_l ')
    else
      SQL.Add(' from frf_facturas, OUTER frf_fac_abonos_l ');

    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add(' and tipo_factura_f = ''381'' ');
    SQL.Add(' and fecha_factura_f between :fechaini and :fechafin ');
    if ACliente <> '' then
      SQL.Add(' and cliente_sal_f = :cliente ');
    SQL.Add(' and empresa_fal = :empresa ');
    SQL.Add(' and factura_fal = n_factura_f ');
    SQL.Add(' and fecha_fal = fecha_factura_f ');
    if AEnvase <> '' then
      SQL.Add(' and envase_fal = :envase ');
    if AProducto <> '' then
      SQL.Add(' and producto_fal = :producto ');
    if not AAnulaciones then
      SQL.Add(' and anulacion_f = 0 ');
    SQL.Add(' order by moneda_f, unidad_fal, 1,2,3 ');
  end;
end;

function TDLAbonoDetalles.DatosListado( const AEmpresa, AProducto, AEnvase, ACliente: string;
           const AFechaIni, AFechaFin: TDateTime; const AAnulaciones: boolean ): boolean;
begin
  PreparaQuery( AProducto, AEnvase, ACliente, AAnulaciones );
  with QListadoAbonoDetalles do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AEnvase <> '' then
      ParamByName('envase').AsString:= AEnvase;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDLAbonoDetalles.CerrarTabla;
begin
  QListadoAbonoDetalles.Close;
end;

end.
