unit CDLPedirDuaConsumo;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLPedirDuaConsumo = class(TDataModule)
    QTransitos: TQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro, ATransito: string;
                         const AFechainicio, AFechafin: TDateTime ): boolean;
    procedure CerrarQuery;
  end;

var
  DLPedirDuaConsumo: TDLPedirDuaConsumo;

implementation

{$R *.dfm}

uses
  UDMAuxDB;

function TDLPedirDuaConsumo.AbrirQuery( const AEmpresa, ACentro, ATransito: string;
                                        const AFechainicio, AFechafin: TDateTime ): boolean;
begin
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_dac empresa, referencia_dac transito, dvd_dac dvd, fecha_entrada_dda_dac fecha_dda, dua_exporta_dac dua_exporta, ');
    SQL.Add('        fecha_dal fecha_consumo, ');
    SQL.Add('        cliente_dal cliente, nombre_c, domicilio_c, poblacion_c, cod_postal_c, pais_c, ');
    SQL.Add('        dir_sum_dal suministro, domicilio_ds, poblacion_ds, cod_postal_ds, provincia_ds, ');
    SQL.Add('        dua_consumo_dal dua_consumo, kilos_dal kilos_consumo, ');
    SQL.Add('        ( select sum(kilos_tl) from frf_transitos_l ');
    SQL.Add('          where empresa_tl = empresa_dac and centro_tl = centro_dac ');
    SQL.Add('          and fecha_tl = fecha_dac and referencia_tl = referencia_dac ) kilos_transito, ');
    SQL.Add('        ( select buque_tc from frf_transitos_c ');
    SQL.Add('          where empresa_tc = empresa_dac and centro_tc = centro_dac ');
    SQL.Add('          and fecha_tc = fecha_dac and referencia_tc = referencia_dac ) buque ');

    SQL.Add('   from frf_depositos_aduana_c, frf_depositos_aduana_l, frf_clientes, outer frf_dir_sum ');
    SQL.Add('   where empresa_dac = :empresa ');
    SQL.Add('   and centro_dac = :centro ');

    if ATransito <> '' then
      SQL.Add('   and referencia_dac = :transito ');

    SQL.Add('   and codigo_dal = codigo_dac ');
    SQL.Add('   and fecha_dal between :fechaini and :fechafin ');

    SQL.Add('   and empresa_c = empresa_dac ');
    SQL.Add('   and cliente_c = cliente_dal ');

    SQL.Add('   and empresa_ds = empresa_dac ');
    SQL.Add('   and cliente_ds = cliente_dal ');
    SQL.Add('   and dir_sum_ds = dir_sum_dal ');

    //Transitos
    SQL.Add('   union ');
    SQL.Add('       select empresa_dac empresa, referencia_dac transito, dvd_dac dvd, fecha_entrada_dda_dac fecha_dda, dua_exporta_dac dua_exporta, ');
    SQL.Add('           fecha_dal fecha_consumo, ');
    SQL.Add('           centro_destino_dal cliente, descripcion_c nombre_c, direccion_c domicilio_c, poblacion_c, cod_postal_c, pais_c, ');
    SQL.Add('           centro_destino_dal suministro, direccion_c domicilio_ds, poblacion_c poblacion_ds, cod_postal_c cod_postal_ds, '''' provincia_ds, ');
    SQL.Add('           dua_consumo_dal dua_consumo, kilos_dal kilos_consumo, ');
    SQL.Add('           ( select sum(kilos_tl) from frf_transitos_l ');
    SQL.Add('             where empresa_tl = empresa_dac and centro_tl = centro_dac ');
    SQL.Add('             and fecha_tl = fecha_dac and referencia_tl = referencia_dac ) kilos_transito, ');
    SQL.Add('           ( select buque_tc from frf_transitos_c ');
    SQL.Add('             where empresa_tc = empresa_dac and centro_tc = centro_dac ');
    SQL.Add('             and fecha_tc = fecha_dac and referencia_tc = referencia_dac ) buque ');

    SQL.Add('      from frf_depositos_aduana_c, frf_depositos_aduana_l, frf_centros ');
    SQL.Add('      where empresa_dac = :empresa ');
    SQL.Add('      and centro_dac = :centro ');

    if ATransito <> '' then
      SQL.Add('      and referencia_dac = :transito ');

    SQL.Add('      and codigo_dal = codigo_dac ');
    SQL.Add('      and fecha_dal between :fechaini and :fechafin ');

    SQL.Add('      and empresa_c = empresa_dac ');
    SQL.Add('      and centro_c = centro_destino_dal ');

    SQL.Add('   order by empresa, transito, fecha_consumo, cliente, suministro ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;
    if ATransito <> '' then
      ParamByName('transito').AsInteger:= StrToIntDef ( ATransito, 0);

    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDLPedirDuaConsumo.CerrarQuery;
begin
  QTransitos.Close;
end;

end.


