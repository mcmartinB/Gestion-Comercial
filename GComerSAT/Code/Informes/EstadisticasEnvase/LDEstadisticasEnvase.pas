unit LDEstadisticasEnvase;

interface

uses
  Forms, SysUtils, Classes, DB, DBTables;

type
  TDLEstadisticasEnvase = class(TDataModule)
    QListado: TQuery;
    QListadoempresa: TStringField;
    QListadocentro: TStringField;
    QListadocliente: TStringField;
    QListadofecha: TDateField;
    QListadoalbaran: TIntegerField;
    QListadoproducto: TStringField;
    QListadoenvase: TStringField;
    QListadomoneda: TStringField;
    QListadokilos: TFloatField;
    QListadocajas: TFloatField;
    QListadoimporte: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
    function ObtenerDatos( const AEmpresa, ACentro, ACliente, AProducto: string;
                           const AFechaIni, AFechaFin: TDateTime ): boolean;
    procedure CerrarQuery;
  end;

  function InicializarModulo: TDLEstadisticasEnvase;
  procedure FinalizarModulo;

implementation

{$R *.dfm}

var
  DLEstadisticasEnvase: TDLEstadisticasEnvase;
  i: integer = 0;

function InicializarModulo: TDLEstadisticasEnvase;
begin
  Inc( i );
  if i = 1 then
    DLEstadisticasEnvase:= TDLEstadisticasEnvase.Create( Application );
  result:= DLEstadisticasEnvase
end;

procedure FinalizarModulo;
begin
  Dec( i );
  if i = 0 then
    FreeAndNil( DLEstadisticasEnvase );
end;


function TDLEstadisticasEnvase.ObtenerDatos( const AEmpresa, ACentro, ACliente, AProducto: string;
                                    const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  with QListado do
  begin
    SQL.Clear;
    SQL.Add('select empresa_sc empresa, centro_salida_sc centro, cliente_fac_sc cliente, ');
    SQL.Add('       fecha_sc fecha, n_albaran_sc albaran, producto_sl producto, envase_sl envase, ');
    SQL.Add('       moneda_sc moneda, sum(kilos_sl) kilos, sum(cajas_sl) cajas, ');
    SQL.Add('       sum(importe_neto_sl) importe ');
    SQL.Add('from frf_salidas_c, frf_salidas_l ');
    SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('and fecha_sc between :fechaini and :fechafin ');
    SQL.Add('and nvl(n_factura_sc,0) = 0 ');
    SQL.Add('and cliente_fac_sc not in (''RET'',''REA'',''0BO'',''EG'') ');
    SQL.Add('-- ');
    if ACentro <> '' then
      SQL.Add('and centro_salida_sc = :centro ');
    if ACliente <> '' then
      SQL.Add('and cliente_fac_sc = :cliente ');
    SQL.Add('-- ');
    SQL.Add('and empresa_sl = :empresa ');
    if ACentro <> '' then
      SQL.Add('and centro_salida_sl = :centro ')
    else
      SQL.Add('and centro_salida_sl = centro_salida_sc ');
    SQL.Add('and n_albaran_sl = n_albaran_sc ');
    SQL.Add('and fecha_sl = fecha_sc ');
    SQL.Add('-- ');
    if AProducto <> '' then
      SQL.Add('and producto_sl = :producto ');
    SQL.Add('-- ');
    SQL.Add('group by empresa_sc, centro_salida_sc, cliente_fac_sc, fecha_sc, n_albaran_sc, ');
    SQL.Add('       producto_sl, envase_sl, moneda_sc ');
    SQL.Add('order by empresa_sc, centro_salida_sc, cliente_fac_sc, fecha_sc, n_albaran_sc, ');
    SQL.Add('       producto_sl, envase_sl ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TDLEstadisticasEnvase.CerrarQuery;
begin
  QListado.Close;
end;

end.
