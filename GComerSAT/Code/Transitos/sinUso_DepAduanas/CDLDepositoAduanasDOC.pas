unit CDLDepositoAduanasDOC;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLDepositoAduanasDOC = class(TDataModule)
    QTransitos: TQuery;
    mtTransitos: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro, APuertoSalida: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const ACarpeta: integer;
                         const APuerto, ASinFacturaEstadistico, APesoBruto: boolean ): integer;
    procedure CerrarQuery;
    procedure OrdenarId;
    procedure OrdenarDestino;
  end;

var
  DLDepositoAduanasDOC: TDLDepositoAduanasDOC;

implementation

{$R *.dfm}

uses
  UDMAuxDB, bMath, CFDResultadoBDDeposito;

procedure TDLDepositoAduanasDOC.DataModuleCreate(Sender: TObject);
begin
    with mtTransitos do
    begin
      FieldDefs.Add('id', ftInteger, 0, False);
      FieldDefs.Add('carpeta', ftInteger, 0, False);
      FieldDefs.Add('naviera', ftString, 30, False);
      FieldDefs.Add('transporte', ftString, 30, False);
      FieldDefs.Add('matricula', ftString, 30, False);
      FieldDefs.Add('destino', ftString, 30, False);
      FieldDefs.Add('fecha_transito', ftDateTime, 0, False);
      FieldDefs.Add('conocimiento_embarque', ftString, 10, False);
      FieldDefs.Add('teus_40', ftInteger, 0, False);
      FieldDefs.Add('teus_20', ftInteger, 0, False);
      FieldDefs.Add('metros_lineales', ftFloat, 0, False);
      FieldDefs.Add('n_palets', ftInteger, 0, False);

      FieldDefs.Add('peso_neto', ftFloat, 0, False);
      FieldDefs.Add('peso_bruto', ftFloat, 0, False);
      FieldDefs.Add('flete', ftFloat, 0, False);
      FieldDefs.Add('dto_rappel', ftFloat, 0, False);
      FieldDefs.Add('coste_manipulacion_thc', ftFloat, 0, False);
      FieldDefs.Add('tasa_mercancia_t3', ftFloat, 0, False);
      FieldDefs.Add('rec_combustible_baf', ftFloat, 0, False);
      FieldDefs.Add('tasas_seguridad', ftFloat, 0, False);
      FieldDefs.Add('alquiler_frigorifico', ftFloat, 0, False);
      FieldDefs.Add('alquiler_frigorifico_dda_ue', ftFloat, 0, False);
      FieldDefs.Add('total', ftFloat, 0, False);

      CreateTable;
    end;
end;

function TDLDepositoAduanasDOC.AbrirQuery( const AEmpresa, ACentro, APuertoSalida: string;
                                           const AFechainicio, AFechafin: TDateTime;
                                           const ACarpeta: integer;
                                           const APuerto, ASinFacturaEstadistico, APesoBruto: boolean ): integer;
var
  id: integer;
begin
  result:= -1;
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('          cast( carpeta_deposito_tc as integer ) carpeta, ');
    SQL.Add('          naviera_tc naviera, transporte_tc transporte, vehiculo_tc matricula, ');

    if APuerto then
    begin
      SQL.Add('          ( select descripcion_a from frf_aduanas where puerto_tc = codigo_a ) destino, ');
    end
    else
    begin
      SQL.Add('          case when  cliente_dal is null then ');
      SQL.Add('                    case when ( select pais_c from frf_centros where empresa_c = empresa_tc and centro_c = centro_destino_dal ) = ''ES'' ');
      SQL.Add('                         then ( select descripcion_a from frf_aduanas where puerto_tc = codigo_a ) ');
      SQL.Add('                         else ( select descripcion_p from frf_centros, frf_paises where empresa_c = empresa_tc and centro_c = centro_destino_dal and pais_p = pais_c ) ');
      SQL.Add('                    end   ');
      SQL.Add('               else ');
      SQL.Add('                    case when ( select pais_c from frf_clientes where empresa_c = empresa_tc and cliente_c = cliente_dal ) = ''ES'' ');
      SQL.Add('                         then ( select descripcion_a from frf_aduanas where puerto_tc = codigo_a ) ');
      SQL.Add('                         else ( select descripcion_p from frf_clientes, frf_paises where empresa_c = empresa_tc and cliente_c = cliente_dal  and pais_p = pais_c ) ');
      SQL.Add('                    end   ');
      SQL.Add('         end destino, ');
    end;

    SQL.Add('          fecha_tc fecha_transito, ');
    SQL.Add('          embarque_dac conocimiento_embarque, ');
    SQL.Add('          teus40_dac teus_40, ');
    SQL.Add('          0 teus_20, ');
    SQL.Add('          metros_lineales_dac metros_lineales, ');

    SQL.Add('          ( select sum( palets_tl ) from frf_transitos_l ');
    SQL.Add('            where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('            and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) n_palets, ');

    if APesoBruto then
    begin
      SQL.Add('          ( select sum( nvl(palets_tl,0) * ( select nvl(kilos_tp,0) from frf_tipo_palets where codigo_tp = tipo_palet_tl ) ) from frf_transitos_l ');
      SQL.Add('            where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
      SQL.Add('            and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) + ');
      SQL.Add('          ( select sum( nvl(cajas_tl,0) * ( select nvl(peso_envase_e,0) from frf_envases where empresa_e = empresa_tl and envase_e = envase_tl ');
      SQL.Add('                                            and producto_base_e = ( select producto_base_p from frf_productos ');
      SQL.Add('                                                                    where empresa_p = empresa_tl and producto_p = producto_tl ) ) ) from frf_transitos_l ');
      SQL.Add('            where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
      SQL.Add('            and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) + ');
    end;
    SQL.Add('          ( select sum( kilos_tl ) from frf_transitos_l ');
    SQL.Add('            where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('            and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) peso_bruto, ');

    SQL.Add('          kilos_das, ');
    SQL.Add('          ( select sum( kilos_tl ) from frf_transitos_l ');
    SQL.Add('            where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('            and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) peso_neto, ');

    SQL.Add('          flete_dac flete, ');
    SQL.Add('          rappel_dac dto_rappel, ');
    SQL.Add('          manipulacion_dac coste_manipulacion_thc, ');
    SQL.Add('          mercancia_dac tasa_mercancia_t3, ');
    SQL.Add('          combustible_dac rec_combustible_baf, ');
    SQL.Add('          seguridad_dac tasas_seguridad, ');
    SQL.Add('          frigorifico_dac alquiler_frigorifico, ');

    SQL.Add('          case when nvl(n_factura_das,'''') <> ''''  ');
    SQL.Add('               then frigorifico_das  ');
    SQL.Add('               else kilos_das * ');
    SQL.Add('                               case when  es_transito_das = 0 ');
    SQL.Add('                                     then ( select nvl(fob_plataforma_p,0)  ');
    SQL.Add('                                            from frf_salidas_c, frf_clientes, frf_paises ');
    SQL.Add('                                            where empresa_sc = empresa_das and centro_salida_sc = centro_salida_das ');
    SQL.Add('                                            and fecha_sc = fecha_das  and n_albaran_sc = n_albaran_das ');
    if not ASinFacturaEstadistico then
      SQL.Add('                                            and n_factura_sc is not null and porte_bonny_sc = 0 ');
    SQL.Add('                                            and empresa_c = empresa_sc and cliente_c = cliente_sal_sc  ');
    SQL.Add('                                            and pais_p = pais_c  ) ');
    SQL.Add('                                     else ( select nvl(fob_plataforma_p,0)');
    SQL.Add('                                            from frf_transitos_c, frf_centros, frf_paises');
    SQL.Add('                                            where empresa_tc = empresa_das and centro_tc = centro_salida_das');
    SQL.Add('                                            and fecha_tc = fecha_das  and referencia_tc = n_albaran_das');
    if not ASinFacturaEstadistico then
      SQL.Add('                                            and porte_bonny_tc = 0 ');
    SQL.Add('                                            and empresa_c = empresa_tc and centro_c = centro_destino_tc');
    SQL.Add('                                            and pais_p = pais_c ) ');
    SQL.Add('                                end ');
    SQL.Add('          end  alquiler_frigorifico_dda_ue ');


    SQL.Add(' from frf_transitos_c, frf_depositos_aduana_c, frf_depositos_aduana_l, frf_depositos_aduana_sal ');
    SQL.Add(' where empresa_tc= :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc between :fechaini and :fechafin ');
    if ACarpeta <> -1 then
     SQL.Add(' and carpeta_deposito_tc = :carpeta ');
    SQL.Add(' and empresa_dac = empresa_tc ');
    SQL.Add(' and centro_dac = centro_tc ');
    SQL.Add(' and referencia_dac = referencia_tc ');
    SQL.Add(' and fecha_dac = fecha_tc ');
    if APuertoSalida <> '' then
      SQL.Add(' and puerto_salida_dac = :puerto_salida ');
    SQL.Add(' and codigo_dal = codigo_dac ');
    SQL.Add(' and codigo_das = codigo_dal ');
    SQL.Add(' and linea_das = linea_dal ');

    SQL.Add(' into temp table_aux ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if APuertoSalida <> '' then
      ParamByName('puerto_salida').AsString:= APuertoSalida;    
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    if ACarpeta <> -1 then
    begin
      ParamByName('carpeta').AsString:= IntToStr( ACarpeta );
    end;
    ExecSQL;

    //Deposito sin salidas
    SQL.Clear;
    SQL.Add('  insert into table_aux ');
    SQL.Add('  select ');
    SQL.Add('           cast( nvl(carpeta_deposito_tc,0) as integer ) carpeta, ');
    SQL.Add('           naviera_tc naviera, transporte_tc transporte, vehiculo_tc matricula, ');
    SQL.Add('           ( select descripcion_a from frf_aduanas where puerto_tc = codigo_a ) destino, ');
    SQL.Add('           fecha_tc fecha_transito, ');
    SQL.Add('           embarque_dac conocimiento_embarque, ');

    SQL.Add('           teus40_dac teus_40, ');
    SQL.Add('           0 teus_20, ');
    SQL.Add('           metros_lineales_dac metros_lineales, ');

    SQL.Add('           ( select sum( palets_tl ) from frf_transitos_l ');
    SQL.Add('                      where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('                        and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) n_palets, ');

    SQL.Add('                    ( select sum( nvl(palets_tl,0) * ( select nvl(kilos_tp,0) from frf_tipo_palets where codigo_tp = tipo_palet_tl ) ) from frf_transitos_l ');
    SQL.Add('                      where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('                        and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) + ');
    SQL.Add('                    ( select sum( nvl(cajas_tl,0) * ( select nvl(peso_envase_e,0) from frf_envases where empresa_e = empresa_tl and envase_e = envase_tl ');
    SQL.Add('                                                       and producto_base_e = ( select producto_base_p from frf_productos ');
    SQL.Add('                                                                               where empresa_p = empresa_tl and producto_p = producto_tl ) ) ) from frf_transitos_l ');
    SQL.Add('                      where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('                        and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) + ');
    SQL.Add('                    ( select sum( kilos_tl ) from frf_transitos_l ');
    SQL.Add('                      where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('                        and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) peso_bruto, ');

    SQL.Add('           ( select sum( kilos_tl ) from frf_transitos_l ');
    SQL.Add('             where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('             and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) kilos_das, ');

    SQL.Add('           ( select sum( kilos_tl ) from frf_transitos_l ');
    SQL.Add('             where empresa_tl = empresa_tc  and centro_tl = centro_tc ');
    SQL.Add('             and referencia_tl = referencia_tc  and fecha_tl = fecha_tc ) peso_neto, ');

    SQL.Add('           flete_dac flete, ');
    SQL.Add('           rappel_dac dto_rappel, ');
    SQL.Add('           manipulacion_dac coste_manipulacion_thc, ');
    SQL.Add('           mercancia_dac tasa_mercancia_t3, ');
    SQL.Add('           combustible_dac rec_combustible_baf, ');
    SQL.Add('           seguridad_dac tasas_seguridad, ');
    SQL.Add('           frigorifico_dac alquiler_frigorifico, ');

    SQL.Add('           0 alquiler_frigorifico_dda_ue ');

    SQL.Add('  from frf_transitos_c, frf_depositos_aduana_c ');
    SQL.Add('  where empresa_tc= :empresa ');
    SQL.Add('  and centro_tc = :centro');
    SQL.Add('  and fecha_tc between :fechaini and :fechafin ');
    if ACarpeta <> -1 then
      SQL.Add(' and carpeta_deposito_tc = :carpeta ');
    SQL.Add('  and empresa_dac = empresa_tc ');
    SQL.Add('  and centro_dac = centro_tc ');
    SQL.Add('  and referencia_dac = referencia_tc ');
    SQL.Add('  and fecha_dac = fecha_tc ');
    if APuertoSalida <> '' then
      SQL.Add(' and puerto_salida_dac = :puerto_salida ');
    SQL.Add('  and not exists ( select * from frf_depositos_aduana_l where codigo_dac = codigo_dal ) ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if APuertoSalida <> '' then
      ParamByName('puerto_salida').AsString:= APuertoSalida;    
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;
    if ACarpeta <> -1 then
    begin
      ParamByName('carpeta').AsString:= IntToStr( ACarpeta );
    end;
    ExecSQL;

    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('       carpeta, naviera, transporte, matricula, destino, fecha_transito, conocimiento_embarque, teus_40, teus_20, metros_lineales, ');
    SQL.Add('       n_palets, peso_bruto, peso_neto, sum( kilos_das ) peso, flete, dto_rappel, coste_manipulacion_thc, tasa_mercancia_t3, ');
    SQL.Add('       rec_combustible_baf, tasas_seguridad, alquiler_frigorifico, sum( alquiler_frigorifico_dda_ue ) alquiler_frigorifico_dda_ue ');
    SQL.Add(' from table_aux ');
    SQL.Add(' group by carpeta, naviera, transporte, matricula, destino, fecha_transito, conocimiento_embarque, teus_40, teus_20, metros_lineales, ');
    SQL.Add('       n_palets, peso_bruto, peso_neto, flete, dto_rappel, coste_manipulacion_thc, tasa_mercancia_t3, rec_combustible_baf, ');
    SQL.Add('       tasas_seguridad, alquiler_frigorifico ');
    SQL.Add(' order by carpeta, conocimiento_embarque, destino ');

    Open;

    if not IsEmpty then
    begin
      mtTransitos.Open;
      id:= 1;

      while not Eof do
      begin
        mtTransitos.Insert;
        mtTransitos.FieldByName('id').AsInteger:= id;
        mtTransitos.FieldByName('carpeta').AsInteger:= FieldByName('carpeta').AsInteger;
        mtTransitos.FieldByName('naviera').AsString:= FieldByName('naviera').AsString;
        mtTransitos.FieldByName('transporte').AsString:= desTransporte(AEmpresa, FieldByName('transporte').AsString);
        mtTransitos.FieldByName('matricula').AsString:= FieldByName('matricula').AsString;
        mtTransitos.FieldByName('destino').AsString:= FieldByName('destino').AsString;
        mtTransitos.FieldByName('fecha_transito').AsDateTime:= FieldByName('fecha_transito').AsDateTime;
        mtTransitos.FieldByName('conocimiento_embarque').AsString:= FieldByName('conocimiento_embarque').AsString;
        mtTransitos.FieldByName('teus_40').AsInteger:= FieldByName('teus_40').AsInteger;
        mtTransitos.FieldByName('teus_20').AsInteger:= FieldByName('teus_20').AsInteger;
        mtTransitos.FieldByName('metros_lineales').AsFloat:= FieldByName('metros_lineales').AsFloat;
        //mtTransitos.FieldByName('n_palets').AsInteger:= FieldByName('n_palets').AsInteger;
        mtTransitos.FieldByName('n_palets').AsInteger:= 0;

        mtTransitos.FieldByName('peso_neto').AsFloat:= bRoundTo( FieldByName('peso').AsFloat, 2 );
        mtTransitos.FieldByName('peso_bruto').AsFloat:= bRoundTo( ( FieldByName('peso_bruto').AsFloat *
                                                         FieldByName('peso').AsFloat ) /
                                                         FieldByName('peso_neto').AsFloat, 2);

        mtTransitos.FieldByName('flete').AsFloat:= bRoundTo( ( FieldByName('flete').AsFloat *
                                                         FieldByName('peso').AsFloat ) /
                                                         FieldByName('peso_neto').AsFloat, 2);
        mtTransitos.FieldByName('dto_rappel').AsFloat:= bRoundTo( ( FieldByName('dto_rappel').AsFloat *
                                                         FieldByName('peso').AsFloat ) /
                                                         FieldByName('peso_neto').AsFloat, 2);
        mtTransitos.FieldByName('coste_manipulacion_thc').AsFloat:= bRoundTo( ( FieldByName('coste_manipulacion_thc').AsFloat *
                                                         FieldByName('peso').AsFloat ) /
                                                         FieldByName('peso_neto').AsFloat, 2);
        mtTransitos.FieldByName('tasa_mercancia_t3').AsFloat:= bRoundTo( ( FieldByName('tasa_mercancia_t3').AsFloat *
                                                         FieldByName('peso').AsFloat ) /
                                                         FieldByName('peso_neto').AsFloat, 2);
        mtTransitos.FieldByName('rec_combustible_baf').AsFloat:= bRoundTo( ( FieldByName('rec_combustible_baf').AsFloat *
                                                         FieldByName('peso').AsFloat ) /
                                                         FieldByName('peso_neto').AsFloat, 2);
        mtTransitos.FieldByName('tasas_seguridad').AsFloat:= bRoundTo( ( FieldByName('tasas_seguridad').AsFloat *
                                                         FieldByName('peso').AsFloat ) /
                                                         FieldByName('peso_neto').AsFloat, 2);
        mtTransitos.FieldByName('alquiler_frigorifico').AsFloat:= bRoundTo( ( FieldByName('alquiler_frigorifico').AsFloat *
                                                         FieldByName('peso').AsFloat ) /
                                                         FieldByName('peso_neto').AsFloat, 2);
        mtTransitos.FieldByName('alquiler_frigorifico_dda_ue').AsFloat:= FieldByName('alquiler_frigorifico_dda_ue').AsFloat;

        mtTransitos.FieldByName('total').AsFloat:= mtTransitos.FieldByName('flete').AsFloat +
                                                 mtTransitos.FieldByName('dto_rappel').AsFloat +
                                                 mtTransitos.FieldByName('coste_manipulacion_thc').AsFloat +
                                                 mtTransitos.FieldByName('tasa_mercancia_t3').AsFloat +
                                                 mtTransitos.FieldByName('rec_combustible_baf').AsFloat +
                                                 mtTransitos.FieldByName('tasas_seguridad').AsFloat +
                                                 mtTransitos.FieldByName('alquiler_frigorifico').AsFloat +
                                                 mtTransitos.FieldByName('alquiler_frigorifico_dda_ue').AsFloat;

        mtTransitos.Post;
        inc(id);
        Next;
      end;

      result:= ComprobarTotalesExec( self, mtTransitos, AEmpresa, ACentro, APuertoSalida, AFechainicio, AFechafin, ACarpeta, -1, True, ASinFacturaEstadistico );
      mtTransitos.First;
    end;

    Close;
    SQL.Clear;
    SQL.Add(' drop table table_aux ');
    try
      ExecSQL;
    except
    end;
  end;
end;

procedure TDLDepositoAduanasDOC.CerrarQuery;
begin
  mtTransitos.Close;
end;

procedure TDLDepositoAduanasDOC.OrdenarId;
begin
  mtTransitos.SortFields:='Id';
  mtTransitos.Sort([]);
  mtTransitos.First;
end;

procedure TDLDepositoAduanasDOC.OrdenarDestino;
begin
  mtTransitos.SortFields:='Destino;Id';
  mtTransitos.Sort([]);
  mtTransitos.First;
end;

end.


