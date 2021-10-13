unit CDLFacturasDepositoAduanas;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLFacturasDepositoAduanas = class(TDataModule)
    QTransitos: TQuery;
    QTransitosExtend: TQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const ACarpeta: string ): boolean;
    procedure CerrarQuery;

    function AbrirQueryExtend( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const ACarpeta: string ): boolean;
    procedure CerrarQueryExtend;
  end;

var
  DLFacturasDepositoAduanas: TDLFacturasDepositoAduanas;

implementation

{$R *.dfm}

uses
  UDMAuxDB, bMath;

function TDLFacturasDepositoAduanas.AbrirQueryExtend( const AEmpresa, ACentro: string;
                                           const AFechainicio, AFechafin: TDateTime;
                                           const ACarpeta: string ): boolean;
var
  id: integer;
begin
  with QTransitosExtend do
  begin
    SQL.Clear;
    SQL.Add('  select ');
    SQL.Add('           cast( carpeta_deposito_tc as integer ) carpeta, empresa_tc, centro_tc, referencia_tc, fecha_tc, buque_tc, vehiculo_tc, factura_dac factura_transporte, ');

    SQL.Add('           case when cliente_dal is null then ');
    SQL.Add('             case when ( select pais_c from frf_centros where empresa_c = empresa_tc and centro_c = centro_destino_dal ) = ''ES'' ');
    SQL.Add('                   then ( select cast( descripcion_a as char(30) ) ');
    SQL.Add('                          from frf_aduanas ');
    SQL.Add('                          where puerto_tc = codigo_a ) ');
    SQL.Add('                   else ( select cast( descripcion_p as char(30) ) ');
    SQL.Add('                          from frf_centros, frf_paises ');
    SQL.Add('                          where empresa_c = empresa_tc and centro_c = centro_destino_dal  and pais_p = pais_c ) end ');
    SQL.Add('           else ');
    SQL.Add('             case when ( select pais_c from frf_clientes where empresa_c = empresa_tc and cliente_c = cliente_dal ) = ''ES'' ');
    SQL.Add('                   then ( select cast( descripcion_a as char(30) ) ');
    SQL.Add('                          from frf_aduanas ');
    SQL.Add('                          where puerto_tc = codigo_a ) ');
    SQL.Add('                   else ( select cast( descripcion_p as char(30) ) ');
    SQL.Add('                          from frf_clientes, frf_paises ');
    SQL.Add('                          where empresa_c = empresa_tc and cliente_c = cliente_dal  and pais_p = pais_c ) end ');
    SQL.Add('           end destino, ');

    SQL.Add('           case when cliente_dal is null then ');
    SQL.Add('                  centro_destino_dal ');
    SQL.Add('                else ');
    SQL.Add('                  cliente_dal ');
    SQL.Add('           end cliente_dal, ');

    SQL.Add('           n_cmr_das, n_factura_das factura_alquiler, ');

    SQL.Add('           case when cliente_dal is null then ');
    SQL.Add('                  1 ');
    SQL.Add('                else ');
    SQL.Add('                  nvl( ( select porte_bonny_sc ');
    SQL.Add('                    from frf_salidas_c ');
    SQL.Add('                    where empresa_sc = empresa_das ');
    SQL.Add('                    and centro_salida_sc = centro_salida_das ');
    SQL.Add('                    and n_albaran_sc = n_albaran_das ');
    SQL.Add('                    and fecha_sc = fecha_das ');
    SQL.Add('                  ), 1) ');
    SQL.Add('           end porte_pagado, ');


    SQL.Add('           ( select n_factura_sc ');
    SQL.Add('             from frf_salidas_c ');
    SQL.Add('             where empresa_sc = empresa_das ');
    SQL.Add('               and centro_salida_sc = centro_salida_das ');
    SQL.Add('               and n_albaran_sc = n_albaran_das ');
    SQL.Add('               and fecha_sc = fecha_das   ');
    SQL.Add('               and porte_bonny_sc = 0 ');
    SQL.Add('               and n_factura_sc is not null ');
    SQL.Add('           ) num_fact_comercial, ');
    SQL.Add('           ( select fecha_factura_sc ');
    SQL.Add('             from frf_salidas_c ');
    SQL.Add('             where empresa_sc = empresa_das ');
    SQL.Add('               and centro_salida_sc = centro_salida_das ');
    SQL.Add('               and n_albaran_sc = n_albaran_das ');
    SQL.Add('               and fecha_sc = fecha_das ');
    SQL.Add('               and porte_bonny_sc = 0 ');
    SQL.Add('               and n_factura_sc is not null ');
    SQL.Add('           ) fecha_fact_comercial, ');
    SQL.Add('           ( select nvl(fob_plataforma_p,0) ');
    SQL.Add('             from frf_salidas_c, frf_clientes, frf_paises ');
    SQL.Add('             where empresa_sc = empresa_das ');
    SQL.Add('               and centro_salida_sc = centro_salida_das ');
    SQL.Add('               and n_albaran_sc = n_albaran_das ');
    SQL.Add('               and fecha_sc = fecha_das ');
    SQL.Add('               and porte_bonny_sc = 0 ');
    SQL.Add('               and empresa_c = empresa_sc ');
    SQL.Add('               and cliente_c = cliente_sal_sc ');
    SQL.Add('               and pais_p = pais_c ');
    SQL.Add('           ) coste_kg_alquiler, ');
    SQL.Add('           centro_salida_das, n_albaran_das, fecha_das ');

    SQL.Add('  from frf_transitos_c, frf_depositos_aduana_c, frf_depositos_aduana_l, frf_depositos_aduana_sal ');
    SQL.Add('  where empresa_tc= :empresa ');
    SQL.Add('  and centro_tc = :centro ');
    SQL.Add('  and fecha_tc between :fechaini and :fechafin ');
    SQL.Add('  and empresa_dac = empresa_tc ');
    SQL.Add('  and centro_dac = centro_tc ');
    SQL.Add('  and referencia_dac = referencia_tc ');
    SQL.Add('  and fecha_dac = fecha_tc ');
    SQL.Add('  and codigo_dal = codigo_dac ');
    SQL.Add('  and codigo_das = codigo_dal ');
    SQL.Add('  and linea_das = linea_dal ');

    if ACarpeta <> '' then
      SQL.Add('  and carpeta_deposito_tc = :carpeta ');

    SQL.Add(' order by 1, fecha_tc, referencia_tc, destino, cliente_dal, n_factura_das ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    if ACarpeta <> '' then
      ParamByName('carpeta').AsString:= ACarpeta;

    Open;
    result:= not IsEmpty;
  end;
end;

function TDLFacturasDepositoAduanas.AbrirQuery( const AEmpresa, ACentro: string;
                                           const AFechainicio, AFechafin: TDateTime;
                                           const ACarpeta: string ): boolean;
var
  id: integer;
begin
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('          empresa_tc empresa, ');
    SQL.Add('          ( select n_factura_sc ');
    SQL.Add('            from frf_salidas_c ');
    SQL.Add('            where empresa_sc = empresa_das ');
    SQL.Add('              and centro_salida_sc = centro_salida_das ');
    SQL.Add('              and n_albaran_sc = n_albaran_das ');
    SQL.Add('              and fecha_sc = fecha_das ');
    SQL.Add('              and porte_bonny_sc = 0 ');
    SQL.Add('              and n_factura_sc is not null ');
    SQL.Add('          ) factura, ');
    SQL.Add('          ( select fecha_factura_sc ');
    SQL.Add('            from frf_salidas_c ');
    SQL.Add('            where empresa_sc = empresa_das ');
    SQL.Add('              and centro_salida_sc = centro_salida_das ');
    SQL.Add('              and n_albaran_sc = n_albaran_das ');
    SQL.Add('              and fecha_sc = fecha_das ');
    SQL.Add('              and porte_bonny_sc = 0 ');
    SQL.Add('              and n_factura_sc is not null ');
    SQL.Add('          ) fecha, ');
    SQL.Add('          cliente_dal cliente, ');
    SQL.Add('          carpeta_deposito_tc carpeta ');

    SQL.Add('  from frf_transitos_c, frf_depositos_aduana_c, frf_depositos_aduana_l, frf_depositos_aduana_sal ');
    SQL.Add('  where empresa_tc= :empresa ');
    SQL.Add('  and centro_tc = :centro ');
    SQL.Add('  and fecha_tc between :fechaini and :fechafin ');
    SQL.Add('  and empresa_dac = empresa_tc ');
    SQL.Add('  and centro_dac = centro_tc ');
    SQL.Add('  and referencia_dac = referencia_tc ');
    SQL.Add('  and fecha_dac = fecha_tc ');
    SQL.Add('  and codigo_dal = codigo_dac ');
    SQL.Add('  and codigo_das = codigo_dal ');
    SQL.Add('  and linea_das = linea_dal ');

    SQL.Add('  and ( select porte_bonny_sc ');
    SQL.Add('        from frf_salidas_c ');
    SQL.Add('        where empresa_sc = empresa_das ');
    SQL.Add('          and centro_salida_sc = centro_salida_das ');
    SQL.Add('          and n_albaran_sc = n_albaran_das ');
    SQL.Add('          and fecha_sc = fecha_das ');
    SQL.Add('       ) = 0 ');

    SQL.Add('  and ( select nvl(fob_plataforma_p,0) ');
    SQL.Add('        from frf_salidas_c, frf_clientes, frf_paises ');
    SQL.Add('        where empresa_sc = empresa_das ');
    SQL.Add('          and centro_salida_sc = centro_salida_das ');
    SQL.Add('          and n_albaran_sc = n_albaran_das ');
    SQL.Add('          and fecha_sc = fecha_das ');
    SQL.Add('          and porte_bonny_sc = 0 ');
    SQL.Add('          and n_factura_sc is not null ');
    SQL.Add('          and empresa_c = empresa_sc ');
    SQL.Add('          and cliente_c = cliente_sal_sc ');
    SQL.Add('          and pais_p = pais_c ');
    SQL.Add('      ) > 0  ');
    SQL.Add('  and nvl(n_factura_das,'''') = '''' ');

    if ACarpeta <> '' then
      SQL.Add('  and carpeta_deposito_tc = :carpeta ');

    SQL.Add(' group by 1,2,3,4,5 ');
    SQL.Add(' order by 1,3,2 ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    if ACarpeta <> '' then
      ParamByName('carpeta').AsString:= ACarpeta;

    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDLFacturasDepositoAduanas.CerrarQueryExtend;
begin
  QTransitosExtend.Close;
end;

procedure TDLFacturasDepositoAduanas.CerrarQuery;
begin
  QTransitos.Close;
end;

end.


