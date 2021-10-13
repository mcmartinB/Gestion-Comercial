unit ListPackingOrdenDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLListPackingOrden = class(TDataModule)
    QListadoOrdenCarga: TQuery;

  private
    { Private declarations }
    procedure PreparaQuery( const AProducto, AEnvase, ACliente: string );
  public
    { Public declarations }
    procedure CerrarTabla;
    function DatosListado( const AEmpresa, AProducto, AEnvase, ACliente: string;
                           const AFechaIni, AFechaFin: TDateTime ): boolean;
  end;

implementation

{$R *.dfm}

uses variants;

procedure TDLListPackingOrden.PreparaQuery( const AProducto, AEnvase, ACliente: string );
begin
  with QListadoOrdenCarga do
  begin
    SQL.Clear;              
    SQL.Add(' select envase_pl envase, producto_pl, orden_occ orden, fecha_occ fecha, ean128_pl sscc, ');
    SQL.Add('        n_albaran_occ albaran, cliente_sal_occ cliente, sum(cajas_pl) Cajas, ');
    SQL.Add('        sum( case when nvl(peso_pl,0) <> 0 then nvl(peso_pl,0) ');
    if AEnvase <> '' then
      SQL.Add('        else cajas_pl * ( select peso_neto_e from frf_envases where producto_e = producto_pl and envase_e = :envase ) end ) kilos, ')
    else
      SQL.Add('        else cajas_pl * ( select peso_neto_e from frf_envases where producto_e = producto_pl and envase_e = envase_pl ) end ) kilos, ');
    SQL.Add('        transporte_occ transportista ');

    SQL.Add(' from frf_orden_carga_c, frf_packing_list ');

    SQL.Add(' where empresa_occ = :empresa ');
    SQL.Add('   and fecha_occ between :fechaini and :fechafin ');
    SQL.Add('   and orden_pl = orden_occ ');
    if AProducto <> '' then
      SQL.Add('   and producto_pl = :producto ');
    if AEnvase <> '' then
      SQL.Add('   and envase_pl = :envase ');
    if ACliente <> '' then
      SQL.Add('   and cliente_sal_occ = :cliente ');

    SQL.Add(' group by envase_pl, producto_pl, orden_occ, fecha_occ, ean128_pl, n_albaran_occ, cliente_sal_occ, transporte_occ ');

    SQL.Add(' order by envase_pl, orden_occ, fecha_occ, ean128_pl ');
  end;
end;

function TDLListPackingOrden.DatosListado( const AEmpresa, AProducto, AEnvase, ACliente: string; const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  PreparaQuery( AProducto, AEnvase, ACliente );
  with QListadoOrdenCarga do
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

procedure TDLListPackingOrden.CerrarTabla;
begin
  QListadoOrdenCarga.Close;
end;

end.
