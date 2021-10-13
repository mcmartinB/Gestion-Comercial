unit CDLSalidasDDASinFactura;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLSalidasDDASinFactura = class(TDataModule)
    QTransitos: TQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const AFacturaGrabada, APortePropio: integer;
                         const AFacturaComercial: boolean ): boolean;
    procedure CerrarQuery;
  end;

var
  DLSalidasDDASinFactura: TDLSalidasDDASinFactura;

implementation

{$R *.dfm}

uses
  UDMAuxDB;

function TDLSalidasDDASinFactura.AbrirQuery( const AEmpresa, ACentro: string;
                                             const AFechainicio, AFechafin: TDateTime;
                                             const AFacturaGrabada, APortePropio: integer;
                                             const AFacturaComercial: boolean ): boolean;
begin
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_dac, centro_dac, referencia_dac, fecha_dac, ');
    SQL.Add('        centro_salida_das, n_albaran_das, fecha_das, operador_transporte_das, ');
    SQL.Add('        transporte_das, vehiculo_das, n_cmr_das, n_pedido_das, kilos_das, frigorifico_das, n_factura_das, ');
    if AFacturaComercial then
    begin


      SQL.Add('          case when nvl(n_factura_das,'''') <> ''''  ');
      SQL.Add('               then 0  ');
      SQL.Add('               else kilos_das * case when  es_transito_das = 0 ');
      SQL.Add('                                     then ( select nvl(fob_plataforma_p,0)  ');
      SQL.Add('                                            from frf_salidas_c, frf_clientes, frf_paises ');
      SQL.Add('                                            where empresa_sc = empresa_das and centro_salida_sc = centro_salida_das ');
      SQL.Add('                                            and fecha_sc = fecha_das  and n_albaran_sc = n_albaran_das ');
      SQL.Add('                                            and empresa_c = empresa_sc and cliente_c = cliente_sal_sc  ');
      SQL.Add('                                            and pais_p = pais_c  ) ');
      SQL.Add('                                     else ( select nvl(fob_plataforma_p,0)');
      SQL.Add('                                            from frf_transitos_c, frf_centros, frf_paises');
      SQL.Add('                                            where empresa_tc = empresa_das and centro_tc = centro_salida_das');
      SQL.Add('                                            and fecha_tc = fecha_das  and referencia_tc = n_albaran_das');
      SQL.Add('                                            and empresa_c = empresa_tc and centro_c = centro_destino_tc');
      SQL.Add('                                            and pais_p = pais_c ) ');
      SQL.Add('                                end ');
      SQL.Add('          end importe_estadistico, ');



      SQL.Add('        case when nvl( n_factura_das, '''' ) = '''' ');
      SQL.Add('               then ( select Cast( n_factura_sc AS CHAR(10) ) from frf_salidas_c where empresa_sc = empresa_dac ');
      SQL.Add('                      and centro_salida_sc = centro_salida_das and fecha_sc = fecha_das  and n_albaran_sc = n_albaran_das and porte_bonny_sc = 0 ) ');
      SQL.Add('             else '''' ');
      SQL.Add('        end n_factura_estadistico ');
    end
    else
    begin
       SQL.Add('        0 importe_estadistico, '''' n_factura_estadistico ');
    end;

    SQL.Add(' from frf_depositos_aduana_c, frf_depositos_aduana_sal ');
    SQL.Add(' where empresa_dac = :empresa ');
    SQL.Add(' and centro_dac = :centro ');
    SQL.Add(' and fecha_dac between :fechaini and :fechafin ');

    SQL.Add(' and codigo_das = codigo_dac ');
    if AFacturaGrabada > 0 then
    begin
      if AFacturaGrabada = 1 then
        SQL.Add(' and nvl(n_factura_das,'''') <> '''' ')
      else
        SQL.Add(' and nvl(n_factura_das,'''') = '''' ');
    end;

    if APortePropio > 0 then
    begin
      SQL.Add(' and ( exists ');
      SQL.Add(' ( ');
      SQL.Add('   select * ');
      SQL.Add('   from frf_salidas_c ');
      SQL.Add('   where empresa_sc = empresa_das ');
      SQL.Add('   and centro_salida_sc = centro_salida_das ');
      SQL.Add('   and fecha_sc = fecha_das ');
      SQL.Add('   and n_albaran_sc = n_albaran_das ');
      if APortePropio = 1 then
        SQL.Add('   and porte_bonny_sc = 1 ')
      else
        SQL.Add('   and porte_bonny_sc = 0 ');
      SQL.Add(' ) ');

      SQL.Add(' or exists ');
      SQL.Add(' ( ');
      SQL.Add('   select * ');
      SQL.Add('   from frf_transitos_c ');
      SQL.Add('   where empresa_tc = empresa_das ');
      SQL.Add('   and centro_tc = centro_salida_das ');
      SQL.Add('   and fecha_tc = fecha_das ');
      SQL.Add('   and referencia_tc = n_albaran_das ');
      if APortePropio = 1 then
        SQL.Add('   and porte_bonny_tc = 1 ')
      else
        SQL.Add('   and porte_bonny_tc = 0 ');
      SQL.Add(' ) )');

      //Las lineas que no tienen transito o salidas en comercial (o se han modificado)
      //las consideramos como que las paga bonnysa
      if APortePropio = 1 then
      begin
        SQL.Add(' union ');
        SQL.Add(' select empresa_dac, centro_dac, referencia_dac, fecha_dac, ');
        SQL.Add('        centro_salida_das, n_albaran_das, fecha_das, operador_transporte_das, ');
        SQL.Add('        transporte_das, vehiculo_das, n_cmr_das, n_pedido_das, kilos_das, frigorifico_das, n_factura_das, ');
        if AFacturaComercial then
        begin
          SQL.Add('          case when nvl(n_factura_das,'''') <> ''''  ');
          SQL.Add('               then 0  ');
          SQL.Add('               else kilos_das * ( select nvl(fob_plataforma_p,0)  ');
          SQL.Add('                        from frf_salidas_c, frf_clientes, frf_paises ');
          SQL.Add('                        where empresa_sc = empresa_das and centro_salida_sc = centro_salida_das ');
          SQL.Add('                        and fecha_sc = fecha_das  and n_albaran_sc = n_albaran_das ');
          //SQL.Add('                        and n_factura_sc is not null and porte_bonny_sc = 0  ');
          SQL.Add('                        and empresa_c = empresa_sc and cliente_c = cliente_sal_sc  ');
          SQL.Add('                        and pais_p = pais_c  ) ');
          SQL.Add('          end importe_estadistico, ');

          SQL.Add('        case when nvl( n_factura_das, '''' ) = '''' ');
          SQL.Add('               then ( select Cast( n_factura_sc AS CHAR(10) ) from frf_salidas_c where empresa_sc = empresa_dac ');
          SQL.Add('                      and centro_salida_sc = centro_salida_das and fecha_sc = fecha_das  and n_albaran_sc = n_albaran_das and porte_bonny_sc = 0 ) ');
          SQL.Add('             else '''' ');
          SQL.Add('        end n_factura_estadistico ');
        end
        else
        begin
          SQL.Add('        0 importe_estadistico, '''' n_factura_estadistico ');
        end;

        SQL.Add(' from frf_depositos_aduana_c, frf_depositos_aduana_sal ');
        SQL.Add(' where empresa_dac = :empresa ');
        SQL.Add(' and centro_dac = :centro ');
        SQL.Add(' and fecha_dac between :fechaini and :fechafin ');

        SQL.Add(' and codigo_das = codigo_dac ');
        if AFacturaGrabada > 0 then
        begin
          if AFacturaGrabada = 1 then
            SQL.Add(' and nvl(n_factura_das,'''') <> '''' ')
          else
            SQL.Add(' and nvl(n_factura_das,'''') = '''' ');
        end;

        SQL.Add(' and not ( exists ');
        SQL.Add(' ( ');
        SQL.Add('   select * ');
        SQL.Add('   from frf_salidas_c ');
        SQL.Add('   where empresa_sc = empresa_das ');
        SQL.Add('   and centro_salida_sc = centro_salida_das ');
        SQL.Add('   and fecha_sc = fecha_das ');
        SQL.Add('   and n_albaran_sc = n_albaran_das ');
        SQL.Add(' ) ');

        SQL.Add(' or exists ');
        SQL.Add(' ( ');
        SQL.Add('   select * ');
        SQL.Add('   from frf_transitos_c ');
        SQL.Add('   where empresa_tc = empresa_das ');
        SQL.Add('   and centro_tc = centro_salida_das ');
        SQL.Add('   and fecha_tc = fecha_das ');
        SQL.Add('   and referencia_tc = n_albaran_das ');
        SQL.Add(' ) )');
      end;
    end;

    SQL.Add('order by empresa_dac, centro_dac, fecha_dac, referencia_dac, centro_salida_das, fecha_das, n_albaran_das ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDLSalidasDDASinFactura.CerrarQuery;
begin
  QTransitos.Close;
end;

end.


