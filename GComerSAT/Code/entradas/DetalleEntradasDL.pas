unit DetalleEntradasDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLDetalleEntradas = class(TDataModule)
    QDetalleEntradas: TQuery;
    QResumenEntradas: TQuery;

  private
    { Private declarations }

  public
    { Public declarations }
    procedure DatosDetalleEntrega( const AEmpresa, ACentro, AProducto: string;
                           const AFechaIni, AFechaFin: TDateTime;
                           const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer );
    procedure DatosResumenEntrega( const AEmpresa, ACentro, AProducto: string;
                           const AFechaIni, AFechaFin: TDateTime;
                           const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer );
  end;

function ObtenerDatosDetalle( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string;
                       const AFechaIni, AFechaFin: TDateTime;
                       const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer ): Boolean;
function ObtenerDatosResumen( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string;
                       const AFechaIni, AFechaFin: TDateTime;
                       const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer ): Boolean;
procedure CerrarTablas;

var
  DLDetalleEntradas: TDLDetalleEntradas;

implementation

{$R *.dfm}

uses variants, bMath;

function ObtenerDatosDetalle( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string;
                       const AFechaIni, AFechaFin: TDateTime;
                       const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer ): Boolean;
begin
  DLDetalleEntradas:= TDLDetalleEntradas.Create( AOwner );
  with DLDetalleEntradas do
  begin
    DatosDetalleEntrega( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin,
                  ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre );

    QDetalleEntradas.ParamByName('empresa').AsString:= AEmpresa;
    QDetalleEntradas.ParamByName('centro').AsString:= ACentro;
    QDetalleEntradas.ParamByName('fechaini').AsDateTime:= AFechaIni;
    QDetalleEntradas.ParamByName('fechaFin').AsDateTime:= AFechaFin;

    if AProducto <> '' then
      QDetalleEntradas.ParamByName('producto').AsString:= AProducto;
    if ACosechero <> -1 then
      QDetalleEntradas.ParamByName('cosechero').AsInteger:= ACosechero;
    if APlantacion <> -1 then
      QDetalleEntradas.ParamByName('plantacion').AsInteger:= APlantacion;
    if AFormato <> -1 then
      QDetalleEntradas.ParamByName('formato').AsInteger:= ACosechero;
    if ACategoria <> 0 then
      QDetalleEntradas.ParamByName('categoria').AsInteger:= ACategoria;
    if ACalibre <> 0 then
      QDetalleEntradas.ParamByName('calibre').AsInteger:= ACalibre - 1;
    if ALogifruit <> 0 then
      QDetalleEntradas.ParamByName('logifruit').AsInteger:= ALogifruit - 1;

    QDetalleEntradas.Open;
    result:= not QDetalleEntradas.IsEmpty;
  end;
end;

function ObtenerDatosResumen( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string;
                       const AFechaIni, AFechaFin: TDateTime;
                       const ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre: integer ): Boolean;
begin
  DLDetalleEntradas:= TDLDetalleEntradas.Create( AOwner );
  with DLDetalleEntradas do
  begin
    DatosResumenEntrega( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin,
                  ACosechero, APlantacion, AFormato, ALogifruit, ACategoria, ACalibre );

    QResumenEntradas.ParamByName('empresa').AsString:= AEmpresa;
    QResumenEntradas.ParamByName('centro').AsString:= ACentro;
    QResumenEntradas.ParamByName('fechaini').AsDateTime:= AFechaIni;
    QResumenEntradas.ParamByName('fechaFin').AsDateTime:= AFechaFin;

    if AProducto <> '' then
      QResumenEntradas.ParamByName('producto').AsString:= AProducto;
    if ACosechero <> -1 then
      QResumenEntradas.ParamByName('cosechero').AsInteger:= ACosechero;
    if APlantacion <> -1 then
      QResumenEntradas.ParamByName('plantacion').AsInteger:= APlantacion;
    if AFormato <> -1 then
      QResumenEntradas.ParamByName('formato').AsInteger:= ACosechero;
    if ACategoria <> 0 then
      QResumenEntradas.ParamByName('categoria').AsInteger:= ACategoria;
    if ACalibre <> 0 then
      QResumenEntradas.ParamByName('calibre').AsInteger:= ACalibre - 1;
    if ALogifruit <> 0 then
      QResumenEntradas.ParamByName('logifruit').AsInteger:= ALogifruit - 1;

    QResumenEntradas.Open;
    result:= not QResumenEntradas.IsEmpty;
  end;
end;

procedure CerrarTablas;
begin
  DLDetalleEntradas.QResumenEntradas.Close;
  DLDetalleEntradas.QDetalleEntradas.Close;
  FreeAndNil( DLDetalleEntradas );
end;

procedure TDLDetalleEntradas.DatosDetalleEntrega( const AEmpresa, ACentro, AProducto: string;
                                           const AFechaIni, AFechaFin: TDateTime;
                                           const ACosechero, APlantacion, AFormato,
                                                 ALogifruit, ACategoria, ACalibre: integer );
begin
  with QDetalleEntradas do
  begin
    SQL.Clear;
    SQL.Add(' select *, ');

    SQL.Add('          case when peso <> 0 then peso ');
    SQL.Add('          else round( cajas * ( select case when sum(total_kgs_e2l) = 0 then 0 ');
    SQL.Add('                                          else sum(total_kgs_e2l) / sum(total_cajas_e2l) end kgs_caja ');
    SQL.Add('                                   from frf_entradas2_l ');
    SQL.Add('                                   where empresa_e2l = empresa and centro_e2l = centro ');
    SQL.Add('                                     and numero_entrada_e2l = albaran_entrada and fecha_e2l = date(fecha_alta) ');
    SQL.Add('                                     and cosechero_e2l = cosechero and plantacion_e2l = plantacion ), 2) end kilos ');

    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where empresa = :empresa ');
    SQL.Add(' and centro = :centro ');
    SQL.Add(' and date(fecha_alta) between :fechaini and :fechafin ');
    if AProducto <> '' then
      SQL.Add(' and producto = :producto ');
    if ACosechero <> -1 then
      SQL.Add(' and cosechero = :cosechero ');
    if APlantacion <> -1 then
      SQL.Add(' and plantacion = :plantacion ');
//    if AFormato <> -1 then
//      SQL.Add(' and formato_e1l = :formato ');
    if ACategoria <> 0 then
      SQL.Add(' and categoria = :categoria ');
    if ACalibre <> 0 then
      SQL.Add(' and calibre = :calibre ');
    if ALogifruit <> 0 then
    begin
      SQL.Add(' and :logifruit = ( select logifruit_p ');
      SQL.Add('           from frf_pesos ');
      SQL.Add('           where empresa_p = :empresa ');
      SQL.Add('           and centro_p = :centro ');
      if AProducto <> '' then
        SQL.Add('           and producto_p = :producto ) ')
      else
        SQL.Add('           and producto_p = producto ) ');
//      if AFormato <> -1 then
//        SQL.Add('           and formato_p = :formato ) ')
//      else
//        SQL.Add('           and formato_p = formato_e1l ) ');
    end;
    SQL.Add(' order by producto, cosechero, plantacion, date(fecha_alta), ');
    SQL.Add('          albaran_entrada,  sscc ');
  end;
end;

procedure TDLDetalleEntradas.DatosResumenEntrega( const AEmpresa, ACentro, AProducto: string;
                                           const AFechaIni, AFechaFin: TDateTime;
                                           const ACosechero, APlantacion, AFormato,
                                                 ALogifruit, ACategoria, ACalibre: integer );
begin
  with QResumenEntradas do
  begin
    (*
    SQL.Clear;
    SQL.Add(' select empresa_e1l, producto_e1l, cosechero_e1l, plantacion_e1l, ano_sem_planta_e1l, ');
    SQL.Add('        categoria_e1l, calibre_e1l, sum(total_cajas_e1l) total_cajas_e1l, ');

    SQL.Add('        sum( ');
    SQL.Add('                 case when kilos_e1l <> 0 then kilos_e1l ');
    SQL.Add('                    else round( total_cajas_e1l * ( select case when sum(total_kgs_e2l) = 0 then 0 ');
    SQL.Add('                                          else sum(total_kgs_e2l) / sum(total_cajas_e2l) end kgs_caja ');
    SQL.Add('                                   from frf_entradas2_l ');
    SQL.Add('                                   where empresa_e2l = empresa_e1l and centro_e2l = centro_e1l ');
    SQL.Add('                                     and numero_entrada_e2l = numero_entrada_e1l and fecha_e2l = fecha_e1l ');
    SQL.Add('                                     and cosechero_e2l = cosechero_e1l and plantacion_e2l = plantacion_e2l ), 2) end ) kilos ');

    SQL.Add(' from frf_entradas1_l ');
    SQL.Add(' where empresa_e1l = :empresa ');
    SQL.Add(' and centro_e1l = :centro ');
    SQL.Add(' and fecha_e1l between :fechaini and :fechafin ');
    if AProducto <> '' then
      SQL.Add(' and producto_e1l = :producto ');
    if ACosechero <> -1 then
      SQL.Add(' and cosechero_e1l = :cosechero ');
    if APlantacion <> -1 then
      SQL.Add(' and plantacion_e1l = :plantacion ');
    if AFormato <> -1 then
      SQL.Add(' and formato_e1l = :formato ');
    if ACategoria <> 0 then
      SQL.Add(' and categoria_e1l = :categoria ');
    if ACalibre <> 0 then
      SQL.Add(' and calibre_e1l = :calibre ');
    if ALogifruit <> 0 then
    begin
      SQL.Add(' and :logifruit = ( select logifruit_p ');
      SQL.Add('           from frf_pesos ');
      SQL.Add('           where empresa_p = :empresa ');
      SQL.Add('           and centro_p = :centro ');
      if AProducto <> '' then
        SQL.Add('           and producto_p = :producto ')
      else
        SQL.Add('           and producto_p = producto_e1l ');
      if AFormato <> -1 then
        SQL.Add('           and formato_p = :formato ) ')
      else
        SQL.Add('           and formato_p = formato_e1l ) ');
    end;
    SQL.Add(' group by empresa_e1l, producto_e1l, cosechero_e1l, plantacion_e1l, ');
    SQL.Add('          ano_sem_planta_e1l, categoria_e1l, calibre_e1l ');
    SQL.Add(' order by empresa_e1l, producto_e1l, cosechero_e1l, plantacion_e1l, ');
    SQL.Add('          ano_sem_planta_e1l, categoria_e1l, calibre_e1l ');
    *)


    SQL.Clear;
    SQL.Add(' select ent_lin.empresa_e2l, ent_lin.producto_e2l, ent_lin.cosechero_e2l, ent_lin.plantacion_e2l, ent_lin.ano_sem_planta_e2l, ');
    SQL.Add('         categoria, calibre, ');

    SQL.Add('         (select sum( total_cajas_e2l )  ');
    SQL.Add('         from frf_entradas2_l ent_aux ');
    SQL.Add('         where ent_aux.empresa_e2l = ent_lin.empresa_e2l ');
    SQL.Add('         and ent_aux.cosechero_e2l = ent_lin.cosechero_e2l ');
    SQL.Add('         and ent_aux.producto_e2l = ent_lin.producto_e2l ');
    SQL.Add('         and ent_aux.plantacion_e2l = ent_lin.plantacion_e2l ');
    SQL.Add('         and ent_aux.ano_sem_planta_e2l = ent_lin.ano_sem_planta_e2l ');
    SQL.Add('         and ent_aux.fecha_e2l between :fechaini and :fechafin ) cajas_e2l, ');

    SQL.Add('         (select sum( total_kgs_e2l ) ');
    SQL.Add('         from frf_entradas2_l ent_aux ');
    SQL.Add('         where ent_aux.empresa_e2l = ent_lin.empresa_e2l ');
    SQL.Add('         and ent_aux.cosechero_e2l = ent_lin.cosechero_e2l ');
    SQL.Add('         and ent_aux.producto_e2l = ent_lin.producto_e2l ');
    SQL.Add('         and ent_aux.plantacion_e2l = ent_lin.plantacion_e2l ');
    SQL.Add('         and ent_aux.ano_sem_planta_e2l = ent_lin.ano_sem_planta_e2l ');
    SQL.Add('         and ent_aux.fecha_e2l between :fechaini and :fechafin) kilos_e2l, ');

    SQL.Add('         sum(cajas) cajas, ');
    SQL.Add('         sum(  case when peso <> 0 then peso ');
    SQL.Add('                    else round( cajas * ( select case when sum(total_kgs_e2l) = 0 then 0 ');
    SQL.Add('                                                                else sum(total_kgs_e2l) / sum(total_cajas_e2l) end kgs_caja ');
    SQL.Add('                                                    from frf_entradas2_l ent_aux ');
    SQL.Add('                                                    where ent_aux.empresa_e2l = ent_pal.empresa ');
    SQL.Add('                                                    and ent_aux.centro_e2l = ent_pal.centro ');
    SQL.Add('                                                    and ent_aux.numero_entrada_e2l = ent_pal.albaran_entrada ');
    SQL.Add('                                                    and ent_aux.fecha_e2l = DATE(ent_pal.fecha_alta) ');
    SQL.Add('                                                    and ent_aux.cosechero_e2l = ent_pal.cosechero ');
    SQL.Add('                                                    and ent_aux.producto_e2l = ent_pal.producto ');
    SQL.Add('                                                    and ent_aux.plantacion_e2l = ent_pal.plantacion ');
    SQL.Add('                                                    and ent_aux.ano_sem_planta_e2l = ent_pal.anyo_semana ');
    SQL.Add('                                                    and ent_aux.fecha_e2l between :fechaini and :fechafin ), 2) end ) peso ');

    SQL.Add('  from frf_entradas2_l  ent_lin ');
    SQL.Add('       left join rf_palet_pb ent_pal ');
    SQL.Add('                 on ent_lin.empresa_e2l = ent_pal.empresa and ent_lin.centro_e2l = ent_pal.centro ');
    SQL.Add('                 and ent_lin.numero_entrada_e2l = ent_pal.albaran_entrada and ent_lin.fecha_e2l = DATE(ent_pal.fecha_alta) ');
    SQL.Add('                 and ent_lin.cosechero_e2l = ent_pal.cosechero and ent_lin.plantacion_e2l = ent_pal.plantacion ');
    SQL.Add('                 and ent_lin.ano_sem_planta_e2l = ent_pal.anyo_semana ');

    SQL.Add('  where ent_lin.empresa_e2l = :empresa ');
    SQL.Add('  and ent_lin.centro_e2l = :centro ');
    SQL.Add('  and ent_lin.fecha_e2l between :fechaini and :fechafin ');


    if AProducto <> '' then
      SQL.Add(' and ent_lin.producto_e2l = :producto ');
    if ACosechero <> -1 then
      SQL.Add(' and ent_lin.cosechero_e2l = :cosechero ');
    if APlantacion <> -1 then
      SQL.Add(' and ent_lin.plantacion_e2l = :plantacion ');
//    if AFormato <> -1 then
//      SQL.Add(' and ent_pal.formato_e1l = :formato ');
    if ACategoria <> 0 then
      SQL.Add(' and ent_pal.categoria = :categoria ');
    if ACalibre <> 0 then
      SQL.Add(' and ent_pal.calibre = :calibre ');
    if ALogifruit <> 0 then
    begin
      SQL.Add(' and :logifruit = ( select logifruit_p ');
      SQL.Add('           from frf_pesos ');
      SQL.Add('           where empresa_p = ent_lin.empresa_e2l ');
      SQL.Add('           and centro_p = ent_lin.centro_e2l ');
      SQL.Add('           and producto_p = ent_lin.producto_e2l ) ');
//    SQL.Add('           and formato_p = ent_pal.formato_e1l ) ');
    end;

    SQL.Add('  group by ent_lin.empresa_e2l, ent_lin.producto_e2l, ent_lin.cosechero_e2l, ent_lin.plantacion_e2l, ');
    SQL.Add('           ent_lin.ano_sem_planta_e2l, ent_pal.categoria, ent_pal.calibre, cajas_e2l ');
    SQL.Add('  order by ent_lin.empresa_e2l, ent_lin.producto_e2l, ent_lin.cosechero_e2l, ent_lin.plantacion_e2l, ');
    SQL.Add('           ent_lin.ano_sem_planta_e2l, ent_pal.categoria, ent_pal.calibre, cajas_e2l ');
  end;
end;


end.
