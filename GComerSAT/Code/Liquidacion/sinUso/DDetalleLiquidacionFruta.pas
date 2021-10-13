unit DDetalleLiquidacionFruta;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMDetalleLiquidacionFruta = class(TDataModule)
    qryListado: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CargaSQL( const AEmpresa, ACentro, AProducto, ACosechero: string;
                       const AFechaIni, AFechaFin: TDateTime );
  public
    { Public declarations }
    function  DatosLiquidacionFruta( const AEmpresa, ACentro, AProducto, ACosechero: string;
                       const AFechaIni, AFechaFin: TDateTime ): boolean;
    procedure CerrarTabla;
  end;

implementation

{$R *.dfm}

procedure TDMDetalleLiquidacionFruta.CargaSQL(
                       const AEmpresa, ACentro, AProducto, ACosechero: string;
                       const AFechaIni, AFechaFin: TDateTime );
begin
  CerrarTabla;
  with qryListado do
  begin

    SQL.Add(' select empresa_es empresa, centro_entrada_Es origen, producto_es producto, ');

    SQL.Add('        ( select distinct(cosechero_e2l) from frf_entradas2_l ');
    SQL.Add('           where empresa_e2l = empresa_es ');
    SQL.Add('             and centro_e2l = centro_entrada_es ');
    SQL.Add('             and fecha_e2l = fecha_entrada_es ');
    SQL.Add('             and numero_entrada_e2l = n_entrada_es ) cosechero, ');

    (*
    SQL.Add('        ( select plantacion_e2l from frf_entradas2_l ');
    SQL.Add('           where empresa_e2l = empresa_es ');
    SQL.Add('             and centro_e2l = centro_entrada_es ');
    SQL.Add('             and fecha_e2l = fecha_entrada_es ');
    SQL.Add('             and numero_entrada_e2l = n_entrada_es ) plantacion, ');

    SQL.Add('        ( select ano_sem_planta_e2l from frf_entradas2_l ');
    SQL.Add('           where empresa_e2l = empresa_es ');
    SQL.Add('             and centro_e2l = centro_entrada_es ');
    SQL.Add('             and fecha_e2l = fecha_entrada_es ');
    SQL.Add('             and numero_entrada_e2l = n_entrada_es ) anyo_sem, ');
    *)
    SQL.Add('             '''' plantacion, '''' anyo_sem,');

    SQL.Add('        n_entrada_es entrada, fecha_entrada_es fecha_entrada,categoria_es categoria, ');

    SQL.Add('        ( select case when fecha_liquidacion_ec is null then ''** FALTA **'' else  ');
    SQL.Add('                       case when liquidacion_definitiva_ec = 1 then ''DEFINITIVA'' else ''PROVISIONAL'' end end  ');
    SQL.Add('           from frf_entradas_c ');
    SQL.Add('           where empresa_ec = empresa_es ');
    SQL.Add('             and centro_ec = centro_entrada_es ');
    SQL.Add('             and fecha_ec = fecha_entrada_es ');
    SQL.Add('             and numero_entrada_ec = n_entrada_es ) tipo, ');

    SQL.Add('        sum(nvl(kilos_es,0)) kilos, ');
    SQL.Add('        sum(nvl(importe_es,0)) importe, ');
    SQL.Add('        sum(nvl(descuento_es,0)) descuento, ');
    SQL.Add('        sum(nvl(gasto_es,0)) gasto, ');
    SQL.Add('        sum(nvl(abono_es,0)) abono, ');
    SQL.Add('        sum(nvl(envasado_es,0)) envasado, ');
    SQL.Add('        sum(nvl(otros_es,0)) gestion ');
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
    end;

    SQL.Add('  group by empresa_es, centro_entrada_Es, producto_es, cosechero, plantacion, anyo_sem, fecha_entrada, entrada, categoria, tipo ');
    SQL.Add('  order by empresa_es, centro_entrada_Es, producto_es, cosechero, plantacion, anyo_sem, fecha_entrada, entrada, categoria, tipo  ');
  end;
end;


function TDMDetalleLiquidacionFruta.DatosLiquidacionFruta(
                                const AEmpresa, ACentro, AProducto, ACosechero: string;
                                const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  CargaSQL( AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin );
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

procedure TDMDetalleLiquidacionFruta.CerrarTabla;
begin
  qryListado.Close;
end;

procedure TDMDetalleLiquidacionFruta.DataModuleDestroy(Sender: TObject);
begin
  CerrarTabla;
end;

end.
