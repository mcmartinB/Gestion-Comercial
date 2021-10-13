unit CDLDepositoAduanasXLS;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLDepositoAduanasXLS = class(TDataModule)
    QTransitos: TQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime ): boolean;
    procedure CerrarQuery;
  end;

var
  DLDepositoAduanasXLS: TDLDepositoAduanasXLS;

implementation

{$R *.dfm}

uses
  UDMAuxDB;

function TDLDepositoAduanasXLS.AbrirQuery( const AEmpresa, ACentro: string;
                                       const AFechainicio, AFechafin: TDateTime ): boolean;
begin
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('         carpeta_deposito_tc, ');
    SQL.Add('         empresa_tc, centro_tc, referencia_tc, fecha_tc, ');
    SQL.Add('         transporte_tc, ( select descripcion_t from frf_transportistas where empresa_t = empresa_tc and  transporte_t = transporte_tc ) des_transporte_tc, ');
    SQL.Add('         vehiculo_tc, buque_tc, puerto_tc, ');
    SQL.Add('         ( select descripcion_a from frf_aduanas where puerto_tc = codigo_a ) des_puerto_tc,  ');

    SQL.Add('          case when  cliente_dal is null then ');
    SQL.Add('                  ( select descripcion_p from frf_centros, frf_paises where empresa_c = empresa_tc and centro_c = centro_destino_dal  and pais_p = pais_c )  ');
    SQL.Add('               else ');
    SQL.Add('                  ( select descripcion_p from frf_clientes, frf_paises where empresa_c = empresa_tc and cliente_c = cliente_dal  and pais_p = pais_c )  ');
    SQL.Add('         end pais_tc, ');

    SQL.Add('         dvd_dac, fecha_entrada_dda_dac, embarque_dac, dua_exporta_dac,  ');

    SQL.Add('         ( select sum( palets_tl ) from frf_transitos_l ');
    SQL.Add('           where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('             and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) palets_tc, ');
    SQL.Add('         ( select sum( cajas_tl ) from frf_transitos_l ');
    SQL.Add('           where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('             and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) cajas_tc, ');
    SQL.Add('         ( select sum( kilos_tl ) from frf_transitos_l ');
    SQL.Add('           where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('             and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) kilos_tc, ');

    SQL.Add('         ( select sum( nvl(palets_tl,0) * ( select nvl(kilos_tp,0) from frf_tipo_palets where codigo_tp = tipo_palet_tl ) ) from frf_transitos_l ');
    SQL.Add('           where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('             and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) + ');
    SQL.Add('         ( select sum( nvl(cajas_tl,0) * ( select nvl(peso_envase_e,0) from frf_envases where empresa_e = empresa_tl and envase_e = envase_tl ');
    SQL.Add('                                            and producto_base_e = ( select producto_base_p from frf_productos ');
    SQL.Add('                                                                    where empresa_p = empresa_tl and producto_p = producto_tl ) ) ) from frf_transitos_l ');
    SQL.Add('           where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('             and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) + ');
    SQL.Add('         ( select sum( kilos_tl ) from frf_transitos_l ');
    SQL.Add('           where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('             and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) bruto_tc, ');

    SQL.Add('         flete_dac, rappel_dac, manipulacion_dac,mercancia_dac, combustible_dac, seguridad_dac, frigorifico_dac, factura_dac, ');

    SQL.Add('         case when  cliente_dal is null then ');
    SQL.Add('                  centro_destino_dal ');
    SQL.Add('               else ');
    SQL.Add('                  cliente_dal ');
    SQL.Add('         end cliente_dal, ');
    SQL.Add('         dir_sum_dal, fecha_dal, kilos_dal, dua_consumo_dal, ');

    SQL.Add('         centro_salida_das, n_albaran_das, fecha_das, vehiculo_das, operador_transporte_das, transporte_das, ');
    SQL.Add('         n_cmr_das, n_pedido_das, kilos_das, ');

    SQL.Add('          case when nvl(n_factura_das,'''') <> ''''  ');
    SQL.Add('               then frigorifico_das  ');
    SQL.Add('               else kilos_das * ( select nvl(fob_plataforma_p,0)  ');
    SQL.Add('                        from frf_salidas_c, frf_clientes, frf_paises ');
    SQL.Add('                        where empresa_sc = empresa_das and centro_salida_sc = centro_salida_das ');
    SQL.Add('                        and fecha_sc = fecha_das  and n_albaran_sc = n_albaran_das ');
    SQL.Add('                        and n_factura_sc is not null and porte_bonny_sc = 0  ');
    SQL.Add('                        and empresa_c = empresa_sc and cliente_c = cliente_sal_sc  ');
    SQL.Add('                        and pais_p = pais_c  ) ');
    SQL.Add('          end frigorifico_das, ');

    SQL.Add('          case when nvl(n_factura_das,'''') <> ''''  ');
    SQL.Add('               then n_factura_das  ');
    SQL.Add('               else case when ( select nvl(fob_plataforma_p,0)  ');
    SQL.Add('                                from frf_salidas_c, frf_clientes, frf_paises ');
    SQL.Add('                                where empresa_sc = empresa_das and centro_salida_sc = centro_salida_das ');
    SQL.Add('                                and fecha_sc = fecha_das  and n_albaran_sc = n_albaran_das ');
    SQL.Add('                                and n_factura_sc is not null and porte_bonny_sc = 0  ');
    SQL.Add('                                and empresa_c = empresa_sc and cliente_c = cliente_sal_sc  ');
    SQL.Add('                                and pais_p = pais_c  )  <> 0 ');
    SQL.Add('                         then ''ESTADISTICO'' ');
    SQL.Add('                         else '''' ');
    SQL.Add('                    end ');
    SQL.Add('          end n_factura_das ');

    SQL.Add(' from frf_transitos_c, frf_depositos_aduana_c, frf_depositos_aduana_l, frf_depositos_aduana_sal ');
    SQL.Add(' where empresa_tc= :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc between :fechaini and :fechafin ');
    SQL.Add(' and empresa_dac = empresa_tc ');
    SQL.Add(' and centro_dac = centro_tc ');
    SQL.Add(' and referencia_dac = referencia_tc ');
    SQL.Add(' and fecha_dac = fecha_tc ');
    SQL.Add(' and codigo_dal = codigo_dac ');
    SQL.Add(' and codigo_das = codigo_dal ');
    SQL.Add(' and linea_das = linea_dal ');

    SQL.Add(' order by carpeta_deposito_tc ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDLDepositoAduanasXLS.CerrarQuery;
begin
  QTransitos.Close;
end;

end.


