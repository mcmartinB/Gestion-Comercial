unit DVerLiquidacionFruta;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMVerLiquidacionFruta = class(TDataModule)
    qryListado: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CargaSQL( const AEmpresa, ACentro, AProducto, ACosechero: string;
                       const AFechaIni, AFechaFin: TDateTime; const AVerPlantaciones, AIncluirGastos, AIncluirAbonos: Boolean );
  public
    { Public declarations }
    function  DatosLiquidacionFruta( const AEmpresa, ACentro, AProducto, ACosechero: string;
                       const AFechaIni, AFechaFin: TDateTime; const AVerPlantaciones, AIncluirGastos, AIncluirAbonos: Boolean ): boolean;
    procedure CerrarTabla;
  end;

implementation

{$R *.dfm}

function Importe ( const AIncluirGastos, AIncluirAbonos: boolean ): string;
begin
  if AIncluirGastos then
  begin
    if AIncluirAbonos then
      Result:= '+ gasto_es - abono_es'
    else
      Result:= '+ gasto_es'
  end
  else
  begin
    if AIncluirAbonos then
      Result:= '-  abono_es'
    else
      Result:= '';
  end;
end;

procedure TDMVerLiquidacionFruta.CargaSQL(
                       const AEmpresa, ACentro, AProducto, ACosechero: string;
                       const AFechaIni, AFechaFin: TDateTime;
                       const AVerPlantaciones, AIncluirGastos, AIncluirAbonos: Boolean );
begin
  CerrarTabla;
  with qryListado do
  begin
    SQL.Clear;

    //if AVerPlantaciones then
    begin
      SQL.Add(' select empresa_e2l empresa, centro_e2l origen, producto_e2l producto, ');

      SQL.Add('        cosechero_e2l cosechero, ');

      if AVerPlantaciones then
        SQL.Add('        plantacion_e2l plantacion, ')
      else
        SQL.Add('        '''' plantacion, ');

      SQL.Add('        ano_sem_planta_e2l anyo_sem, ');

      SQL.Add('        ''-'' categoria, ');

      SQL.Add('        sum(total_kgs_e2l) kilos, ');

      SQL.Add('         round( sum( ( select sum( importe_es - (descuento_es ' + Importe( AIncluirGastos, AIncluirAbonos ) + '  ) ) /  sum( kilos_es ) ');
      SQL.Add('           from frf_entradas_sal ');
      SQL.Add('           where empresa_es = empresa_e2l ');
      SQL.Add('           and centro_entrada_es = centro_e2l ');
      SQL.Add('           and fecha_entrada_es = fecha_e2l ');
      SQL.Add('           and n_entrada_es = numero_entrada_e2l ) * total_kgs_e2l ) , 2 ) bruto, ');

      SQL.Add('         round( sum( ( select sum( envasado_es ) /  sum( kilos_es ) ');
      SQL.Add('           from frf_entradas_sal ');
      SQL.Add('           where empresa_es = empresa_e2l ');
      SQL.Add('           and centro_entrada_es = centro_e2l ');
      SQL.Add('           and fecha_entrada_es = fecha_e2l ');
      SQL.Add('           and n_entrada_es = numero_entrada_e2l ) * total_kgs_e2l ) , 2 ) envasado, ');

      SQL.Add('         round( sum( ( select sum( otros_es ) /  sum( kilos_es ) ');
      SQL.Add('           from frf_entradas_sal ');
      SQL.Add('           where empresa_es = empresa_e2l ');
      SQL.Add('           and centro_entrada_es = centro_e2l ');
      SQL.Add('           and fecha_entrada_es = fecha_e2l ');
      SQL.Add('           and n_entrada_es = numero_entrada_e2l ) * total_kgs_e2l ) , 2 ) gestion ');

      SQL.Add(' from frf_entradas2_l  ');
      SQL.Add(' where empresa_e2l = :empresa ');
      SQL.Add(' and centro_e2l = :centro ');
      SQL.Add(' and producto_e2l = :producto ');
      SQL.Add(' and fecha_e2l between :fechaini and :fechafin ');

      if ACosechero <> '' then
      begin
        SQL.Add('    and cosechero_e2l = :cosechero  ');
      end ;

      SQL.Add('  group by empresa, origen, producto, cosechero, plantacion, anyo_sem, categoria ');
      SQL.Add('  order by empresa, origen, producto, cosechero, plantacion, anyo_sem, categoria  ');
    end;
    (*
    else
    begin
      SQL.Add('        select empresa_es empresa, centro_entrada_Es origen, producto_es producto, ');
      SQL.Add('        ( select unique cosechero_e2l from frf_entradas2_l ');
      SQL.Add('           where empresa_e2l = empresa_es ');
      SQL.Add('             and centro_e2l = centro_entrada_es ');
      SQL.Add('             and fecha_e2l = fecha_entrada_es ');
      SQL.Add('             and numero_entrada_e2l = n_entrada_es ) cosechero, ');

      SQL.Add('        categoria_es categoria, ');
      SQL.Add('        sum(kilos_es) kilos, ');
      SQL.Add('        sum(importe_es -(descuento_es ' + Importe ( AIncluirGastos, AIncluirAbonos ) + ' )) bruto, ');
      SQL.Add('        sum(envasado_es) envasado, sum(otros_es) gestion ');
      SQL.Add(' from frf_entradas_sal ');
      SQL.Add(' where empresa_es = :empresa ');
      SQL.Add(' and centro_entrada_es = :centro ');
      SQL.Add(' and producto_es = :producto ');
      SQL.Add(' and fecha_entrada_es between :fechaini and :fechafin ');

      if ACosechero <> '' then
      begin
        SQL.Add(' and exists( ');
        SQL.Add('  select * from frf_entradas2_l ');
        SQL.Add('  where empresa_e2l = empresa_es ');
        SQL.Add('    and centro_e2l = centro_entrada_es ');
        SQL.Add('    and fecha_e2l = fecha_entrada_es ');
        SQL.Add('    and numero_entrada_e2l = n_entrada_es ');
       SQL.Add('    and cosechero_e2l = :cosechero ) ');
      end ;

      SQL.Add('  group by empresa_es, centro_entrada_Es, producto_es, cosechero, categoria_es ');
      SQL.Add('  order by empresa_es, centro_entrada_Es, producto_es, cosechero, categoria_es  ');

    end; *)
  end;
end;


function TDMVerLiquidacionFruta.DatosLiquidacionFruta(
                                const AEmpresa, ACentro, AProducto, ACosechero: string;
                                const AFechaIni, AFechaFin: TDateTime;
                                const AVerPlantaciones, AIncluirGastos, AIncluirAbonos: Boolean ): boolean;
begin
  CargaSQL( AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin, AVerPlantaciones, AIncluirGastos, AIncluirAbonos );
  qryListado.ParamByName('empresa').AsString:= AEmpresa;
  qryListado.ParamByName('centro').AsString:= ACentro;
  qryListado.ParamByName('producto').AsString:= AProducto;
  if ACosechero <> '' then
      qryListado.ParamByName('cosechero').AsString:= ACosechero;
  qryListado.ParamByName('fechaIni').AsDate:= AFechaIni;
  qryListado.ParamByName('fechaFin').AsDate:= AFechaFin;

  qryListado.Open;
  Result:= not qryListado.IsEmpty;
end;

procedure TDMVerLiquidacionFruta.CerrarTabla;
begin
  qryListado.Close;
end;

procedure TDMVerLiquidacionFruta.DataModuleDestroy(Sender: TObject);
begin
  CerrarTabla;
end;

end.
