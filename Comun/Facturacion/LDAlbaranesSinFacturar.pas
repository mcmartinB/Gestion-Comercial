unit LDAlbaranesSinFacturar;

interface

uses
  Forms, SysUtils, Classes, DB, DBTables;

type
  TDLAlbaranesSinFacturar = class(TDataModule)
    QListado: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function ObtenerDatos( const AEmpresa, ACentro, ACliente, APais: string;  const APaises: Integer;
                           const ATipoAlbaran: integer;
                           const AClienteFacturable, AExcluirMercadona, AMostrarCalibre: Boolean;
                           const AProducto: string; const AFechaIni, AFechaFin: TDateTime ): boolean;
    procedure CerrarQuery;
  end;

  function InicializarModulo: TDLAlbaranesSinFacturar;
  procedure FinalizarModulo;

implementation

{$R *.dfm}

uses UDMConfig;

var
  DLAlbaranesSinFacturar: TDLAlbaranesSinFacturar;
  i: integer = 0;

function InicializarModulo: TDLAlbaranesSinFacturar;
begin
  Inc( i );
  if i = 1 then
    DLAlbaranesSinFacturar:= TDLAlbaranesSinFacturar.Create( Application );
  result:= DLAlbaranesSinFacturar
end;

procedure FinalizarModulo;
begin
  Dec( i );
  if i = 0 then
    FreeAndNil( DLAlbaranesSinFacturar );
end;


function TDLAlbaranesSinFacturar.ObtenerDatos( const AEmpresa, ACentro, ACliente, APais: string; const APaises: Integer;
                                               const ATipoAlbaran: integer;
                                               const AClienteFacturable, AExcluirMercadona, AMostrarCalibre: Boolean;
                                               const AProducto: string;
                                               const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  with QListado do
  begin
    SQL.Clear;
    SQL.Add('select empresa_sc empresa, centro_salida_sc centro, cliente_fac_sc cliente, dir_sum_sc, ');
    SQL.Add('(select cta_cliente_c from frf_clientes where cliente_c = cliente_fac_sc) codigox3,  ');
    SQL.Add('       fecha_sc fecha, n_albaran_sc albaran, producto_sl producto, envase_sl envase, categoria_sl categoria, ');
    if AMostrarCalibre then
      SQL.Add('       calibre_sl calibre, ')
    else
      SQL.Add('       1 calibre, ');
    SQL.Add('       moneda_sc moneda, ');
    SQL.Add('       sum(cajas_sl) cajas, round(sum(importe_neto_sl)/case when sum(cajas_sl) = 0 then 1 else sum(cajas_sl) end, 2) precio_caja, ');
    SQL.Add('       sum(kilos_sl) kilos, round(sum(importe_neto_sl)/case when sum(kilos_sl) = 0 then 1 else sum(kilos_sl) end, 2) precio_kilo, ');
    SQL.Add('       sum(importe_neto_sl) importe ');
    SQL.Add('from frf_salidas_c, frf_salidas_l ');

    if AEmpresa = 'BAG' then
      SQL.Add('where empresa_sc[1,1] = ''F''              ')
    else
    if AEmpresa = 'SAT' then
      SQL.Add('where empresa_sc in ( ''050'',''080'' )    ')
    else
      SQL.Add('where empresa_sc = :empresa ');
//    SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('and fecha_sc between :fechaini and :fechafin ');
    SQL.Add('and nvl(n_factura_sc,0) = 0 ');

    if AClienteFacturable then
      SQL.Add('and cliente_fac_sc not in (''RET'',''REA'',''EG'', ''REP'', ''BAA'', ''GAN'')  and cliente_fac_sc[1,1] <> ''0'' ');

    if ATipoAlbaran = 1  then
    begin
      // Albaranes pendientes con IVA
      SQL.Add(' and porc_iva_sl <> 0 ');
    end;
    if ATipoAlbaran = 2  then
    begin
      // Albaranes pendientes sin IVA
      SQL.Add(' and porc_iva_sl = 0 ');
    end;

    if ATipoAlbaran = 3  then
    begin
      //Marcados como facturables
      SQL.Add('and facturable_sc = 1 ');
    end
    else
    if ATipoAlbaran = 4  then
    begin
      //Sin valorar
      SQL.Add('and importe_neto_sl = 0 ');
    end;

    if AExcluirMercadona then
      SQL.Add('and cliente_fac_sc <> ''MER'' ');

    SQL.Add('-- ');
    if ACentro <> '' then
      SQL.Add('and centro_salida_sc = :centro ');
    if ACliente <> '' then
      SQL.Add('and cliente_fac_sc = :cliente ');
    SQL.Add('-- ');
    SQL.Add('and empresa_sl = empresa_sc ');
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

    if APais <> '' then
    begin
      SQL.Add(' and ( select pais_c from frf_clientes where cliente_c = cliente_fac_sc ) = :pais ');
    end
    else
    begin
      if APaises = 1 then
      begin
        //Nacional
        SQL.Add(' and ( select pais_c from frf_clientes where cliente_c = cliente_fac_sc ) = ''ES'' ');
      end
      else
      if APaises = 2 then
      begin
        //Internacional
        SQL.Add(' and ( select pais_c from frf_clientes where cliente_c = cliente_fac_sc ) <> ''ES'' ');
      end;
    end;


    SQL.Add('group by empresa_sc, centro_salida_sc, cliente_fac_sc, dir_sum_sc, codigoX3, fecha_sc, n_albaran_sc, ');
    if AMostrarCalibre then
      SQL.Add('       producto_sl, envase_sl, categoria_sl, calibre_sl, moneda_sc ')
    else
      SQL.Add('       producto_sl, envase_sl, categoria_sl, moneda_sc ');

    SQL.Add('order by empresa_sc, centro_salida_sc, cliente_fac_sc, fecha_sc, n_albaran_sc, ');
    if AMostrarCalibre then
      SQL.Add('       producto_sl, envase_sl, categoria_sl, calibre_sl ')
    else
      SQL.Add('       producto_sl, envase_sl, categoria_sl ');

    if ( AEmpresa <> 'BAG' ) and ( AEmpresa <> 'SAT' ) then
      ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if APais <> '' then
      ParamByName('pais').AsString:= APAis;      

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TDLAlbaranesSinFacturar.CerrarQuery;
begin
  QListado.Close;
end;

end.
