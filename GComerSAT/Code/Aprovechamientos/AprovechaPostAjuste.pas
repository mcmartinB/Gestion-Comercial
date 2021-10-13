unit AprovechaPostAjuste;

interface

procedure PostAjuste(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin,
  ACosechero, APlantacion, ACategoria: string;
  const AValue: Real);

implementation

uses
  Forms, SysUtils, DB, DBTables;

var
  QAux, QList, QTotales: TQuery;

procedure CreaQuerys;
begin
  QAux := TQuery.Create(Application);
  QAux.DatabaseName := 'BDProyecto';
  QAux.UniDirectional := True;
  QList := TQuery.Create(Application);
  QList.DatabaseName := 'BDProyecto';
  QList.UniDirectional := True;

  QTotales := TQuery.Create(Application);
  QTotales.DatabaseName := 'BDProyecto';
  QTotales.RequestLive := false;
end;

procedure DestruirQuerys;
begin
  FreeAndNil(QAux);
  FreeAndNil(QList);
end;

procedure PorcentajesTotales(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, ACosechero, APlantacion: string;
  var Apc1, Apc2, Apc3, Apcd, Apcm: real);
begin
  with QTotales do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_e, centro_e, cosechero_e, plantacion_e, anyo_semana_e, producto_e,');
    SQL.Add('        SUM( ROUND( ( aporcen_primera_e * total_kgs_e2l ) / 100,  2 ) ),');
    SQL.Add('        SUM( ROUND( ( aporcen_segunda_e * total_kgs_e2l ) / 100,  2 ) ),');
    SQL.Add('        SUM( ROUND( ( aporcen_tercera_e * total_kgs_e2l ) / 100,  2 ) ),');
    SQL.Add('        SUM( ROUND( ( aporcen_destrio_e * total_kgs_e2l ) / 100,  2 ) ),');
    SQL.Add('        SUM( ROUND( ( aporcen_merma_e * total_kgs_e2l ) / 100, 2 ) ), ');
    SQL.Add('        aporcen_merma_e ');
    SQL.Add(' from frf_escandallo, frf_entradas2_l');
    SQL.Add(' where empresa_e = :empresa ');
    SQL.Add('   and centro_e = :centro');
    SQL.Add('   and fecha_e between :fechaini and :fechafin');
    SQL.Add('   and producto_e = :producto ');
    SQL.Add('   and cosechero_e = :cosechero ');
    SQL.Add('   and plantacion_e = :plantacion ');
    SQL.Add('   and empresa_e2l = :empresa ');
    SQL.Add('   and centro_e2l = :centro ');
    SQL.Add('   and fecha_e2l = fecha_e');
    SQL.Add('   and numero_entrada_e2l = numero_entrada_e');
    SQL.Add(' group by empresa_e, centro_e, cosechero_e, plantacion_e, anyo_semana_e, producto_e');
    SQL.Add(' order by empresa_e, centro_e, cosechero_e, plantacion_e, anyo_semana_e, producto_e');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fechaini').AsDate := StrToDate(AFechaIni);
    ParamByName('fechafin').AsDate := StrToDate(AFechaFin);
    ParamByName('cosechero').AsString := ACosechero;
    ParamByName('plantacion').AsString := APlantacion;

    Open;

    First;
    while not EOF do
    begin
      Next;
    end;
    Close;
  end;
end;

procedure PostAjuste(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin,
  ACosechero, APlantacion, ACategoria: string;
  const AValue: Real);
var
  pc1, pc2, pc3, pcd, pcm: Real;
begin
  CreaQuerys;
  try
    PorcentajesTotales(AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, ACosechero, ACentro,
      pc1, pc2, pc3, pcd, pcm);
  finally
    DestruirQuerys;
  end;
end;

end.
