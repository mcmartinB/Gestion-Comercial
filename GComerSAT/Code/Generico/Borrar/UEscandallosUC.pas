{*
  Codigo comun para el tratamiento del escandallo/aprovechamiento
  INICIO: 14/3/2005

  @author Departamento de Informática Horvesa
  @version V.0.1
}
unit UEscandallosUC;

interface

function MensajeDeError: string;

//FUNCIONES SOBRE EL ESCANDALLO EN GENERAL
function EstaEscandalloGrabado(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime; var AFaltan: integer): boolean;

//FUNCIONES SOBRE EL AJUSTE DE LA MERMA
function EstaMermaGrabada(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime): boolean;
procedure AjustarMerma(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime;
  const AMerma, ASobrePesoC1, ASobrePesoC2, ASobrePesoC3: Real);
procedure AjustarMermaEx(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime;
  const AKMerma, AKSobrePesoC1, AKSobrePesoC2, AKSobrePesoC3: Real);

//FUNCIONES SOBRE LOS APROVECHAMIENTOS EN GENERAL
procedure InicializarAprovechamientos(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime);

implementation

uses DB, DBTables, bMath, bSQLUtils, CGestionPrincipal, CVariables;

var
  MiQuery, QAplica: TQuery;
  sMsgError: string;


procedure CrearQuerys;
begin
  if MiQuery = nil then
  begin
    MiQuery := TQuery.Create(nil);
    MiQuery.DatabaseName := 'BDProyecto';
    QAplica := TQuery.Create(nil);
    QAPlica.DatabaseName := 'BDProyecto';
  end;
end;

{*-----------------------------------------------------------------------------
  Devuelve el ultimo mensaje de error.
------------------------------------------------------------------------------}
function MensajeDeError: string;
begin
  result := sMsgError;
end;

{*-----------------------------------------------------------------------------
  Comprueba que el escandallo este grabado para una semana.
  @param AEmpresa Código de la empresa
  @param ACentro Código del centro
  @param AProducto Código del producto
  @param ALunes Fecha inicial de la semana
  @param AFaltan Número de entradas sin escandallo asociado
  @return True si el escandallo esta grabado
------------------------------------------------------------------------------}
function EstaEscandalloGrabado(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime; var AFaltan: integer): boolean;
begin
  CrearQuerys;

  BEMensajes('Comprobando si el escandallo esta grabado ...');

  MiQuery.SQL.Clear;
  MiQuery.SQL.Add(' Select count(*) ');
  MiQuery.SQL.Add(' From frf_entradas2_l ');
  MiQuery.SQL.Add(' Where not exists ');
  MiQuery.SQL.Add('  (Select * from frf_escandallo ');
  MiQuery.SQL.Add('   where empresa_e = :empresa ');
  MiQuery.SQL.Add('   and centro_e = :centro ');
  MiQuery.SQL.Add('   and producto_e = :producto ');
  MiQuery.SQL.Add('   and fecha_e between :fecha_ini and :fecha_fin ');
  MiQuery.SQL.Add('   and fecha_e = fecha_e2l ');
  MiQuery.SQL.Add('   and numero_entrada_e = numero_entrada_e2l ');
  MiQuery.SQL.Add('   and cosechero_e = cosechero_e2l ');
  MiQuery.SQL.Add('   and plantacion_e = plantacion_e2l) ');
  MiQuery.SQL.Add(' and empresa_e2l = :empresa ');
  MiQuery.SQL.Add(' and centro_e2l = :centro ');
  MiQuery.SQL.Add(' and fecha_e2l between :fecha_ini and :fecha_fin ');
  MiQuery.SQL.Add(' and producto_e2l = :producto ');

  MiQuery.ParamByName('empresa').AsString := AEmpresa;
  MiQuery.ParamByName('centro').AsString := ACentro;
  MiQuery.ParamByName('producto').AsString := AProducto;
  MiQuery.ParamByName('fecha_ini').AsDate := ALunes;
  MiQuery.ParamByName('fecha_fin').AsDate := ALunes + 6; //Domingo

  MiQuery.Open;
  AFaltan := MiQuery.Fields[0].AsInteger;
  MiQuery.Close;
  result := AFaltan = 0;

  BEMensajes('');
end;


function EstaMermaGrabada(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime): boolean;
begin
  CrearQuerys;

  BEMensajes('Comprobando si la merma ha sido calculada ...');

  MiQuery.SQL.Clear;
  MiQuery.SQL.Add(' select * ');
  MiQuery.SQL.Add(' from frf_escandallo ');
  MiQuery.SQL.Add(' where empresa_e = :empresa ');
  MiQuery.SQL.Add(' and centro_e = :centro ');
  MiQuery.SQL.Add(' and fecha_e between :fecha_ini and :fecha_fin ');
  MiQuery.SQL.Add(' and producto_e = :producto ');
  MiQuery.SQL.Add(' and (aporcen_primera_e + aporcen_segunda_e + aporcen_tercera_e + aporcen_destrio_e + aporcen_merma_e) <> 0 ');
  MiQuery.ParamByName('empresa').AsString := AEmpresa;
  MiQuery.ParamByName('centro').AsString := ACentro;
  MiQuery.ParamByName('producto').AsString := AProducto;
  MiQuery.ParamByName('fecha_ini').AsDate := ALunes;
  MiQuery.ParamByName('fecha_fin').AsDate := ALunes + 6; //Domingo
  MiQuery.Open;
  result := not MiQuery.IsEmpty;
  MiQuery.Close;

  BEMensajes('');
end;

procedure AjustarMerma(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime;
  const AMerma, ASobrePesoC1, ASobrePesoC2, ASobrePesoC3: Real);
var
  flag: boolean;
  c1, c2, c3, des: Real;
  factor: Real;
begin
  CrearQuerys;

  with MiQuery do
  begin
    flag := RequestLive;
    RequestLive := true;
    SQl.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_escandallo ');
    SQL.Add('where empresa_e = :empresa ');
    SQL.Add(' and centro_e = :centro ');
    SQL.Add(' and producto_e = :producto ');
    SQL.Add(' and fecha_e between :fechaini and :fechaini + 6 ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fechaini').AsDate := ALunes;
    Open;
    First;
    while not EOF do
    begin
      if fieldbyname('porcen_primera_e').AsFloat +
        fieldbyname('porcen_segunda_e').AsFloat +
        fieldbyname('porcen_tercera_e').AsFloat +
        fieldbyname('porcen_destrio_e').AsFloat > 0 then
      begin
        Edit;

        factor := (100 - AMerma) / 100;
        c1 := bRoundTo(MiQuery.fieldbyname('porcen_primera_e').AsFloat * factor, -5) - ASobrePesoC1;
        if c1 < 0 then
          c1:= 0;
        c2 := bRoundTo(MiQuery.fieldbyname('porcen_segunda_e').AsFloat * factor, -5) - ASobrePesoC2;
        if c2 < 0 then
          c2:= 0;
        c3 := bRoundTo(MiQuery.fieldbyname('porcen_tercera_e').AsFloat * factor, -5) - ASobrePesoC3;
        if c3 < 0 then
          c3:= 0;
        des := bRoundTo(MiQuery.fieldbyname('porcen_destrio_e').AsFloat * factor, -5);

        MiQuery.fieldbyname('aporcen_primera_e').AsFloat := c1;
        MiQuery.fieldbyname('aporcen_segunda_e').AsFloat := c2;
        MiQuery.fieldbyname('aporcen_tercera_e').AsFloat := c3;
        MiQuery.fieldbyname('aporcen_destrio_e').AsFloat := des;
        MiQuery.fieldbyname('aporcen_merma_e').AsFloat := 100 - ( c1 + c2 + c3 + des );

        Post;
      end;
      Next;
    end;
    Close;
    RequestLive := flag;
  end;
end;

procedure AjustarMermaEx(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime;
  const AKMerma, AKSobrePesoC1, AKSobrePesoC2, AKSobrePesoC3: Real);
var
  rAux, rPMerma, rPSobrePesoc1, rPSobrePesoC2, rPSobrePesoC3: Real;
  c1, c2, c3, des: Real;
  factor: Real;
begin
  CrearQuerys;

  //Recalcular porcentajes sin tener en cuenta los kilos seleccionados
  with MiQuery do
  begin
    SQl.Clear;
    SQL.Add(
        ' select sum(total_kgs_e2l) kilos' + #13 + #10 +
        '  from frf_entradas2_l, frf_escandallo, frf_entradas_tipo ' + #13 + #10 +
        '  where empresa_e2l = :empresa ' + #13 + #10 +
        '    and centro_e2l = :centro ' + #13 + #10 +
        '    and producto_e2l = :producto ' + #13 + #10 +
        '    and fecha_e2l between :fechaini and :fechafin ' + #13 + #10 +

        '    and empresa_e = :empresa ' + #13 + #10 +
        '    and centro_e = :centro ' + #13 + #10 +
        '    and numero_entrada_e = numero_entrada_e2l ' + #13 + #10 +
        '    and fecha_e = fecha_e2l ' + #13 + #10 +
        '    and producto_e = :producto ' + #13 + #10 +
        '    and cosechero_e = cosechero_e2l ' + #13 + #10 +
        '    and plantacion_e = plantacion_e2l ' + #13 + #10 +
        '    and anyo_semana_e = ano_sem_planta_e2l ' + #13 + #10 +

        '    and empresa_et = :empresa ' + #13 + #10 +
        '    and tipo_et = tipo_entrada_e ' + #13 + #10 +
        '    and merma_et = 1 ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fechaini').AsDate := ALunes;
    ParamByName('fechafin').AsDate := ALunes + 6;
    Open;
    rAux:= FieldByName('kilos').AsFloat;
    if rAux <  AKMerma + AKSobrePesoC1 + AKSobrePesoC2 + AKSobrePesoC3 then
    begin
      rAux:=  AKMerma + AKSobrePesoC1 + AKSobrePesoC2 + AKSobrePesoC3
    end;
    if rAux <> 0 then
    begin
      rPMerma:= bRoundTo((100*AKMerma)/rAux, -5 );
      rPSobrePesoC1:= bRoundTo((100*AKSobrePesoC1)/rAux, -5 );
      rPSobrePesoC2:= bRoundTo((100*AKSobrePesoC2)/rAux, -5 );
      rPSobrePesoC3:= bRoundTo((100*AKSobrePesoC3)/rAux, -5 );
    end
    else
    begin
      rPMerma:= 0;
      rPSobrePesoC1:= 0;
      rPSobrePesoC2:= 0;
      rPSobrePesoC3:= 0;
    end;
    Close;
  end;

  with QAplica do
  begin
    SQL.Clear;
    SQL.Add(' update frf_escandallo ');
    SQL.add(' set  aporcen_primera_e = :pc1, ');
    SQL.add('        aporcen_segunda_e = :pc2, ');
    SQL.add('        aporcen_tercera_e = :pc3, ');
    SQL.add('        aporcen_destrio_e = :pcd, ');
    SQL.add('        aporcen_merma_e = :pcm ');
    SQL.Add(' where empresa_e = :empresa_e ');
    SQL.Add('   and centro_e = :centro_e ');
    SQL.Add('   and numero_entrada_e = :numero_entrada_e ');
    SQL.Add('   and fecha_e = :fecha_e ');
    SQL.Add('   and producto_e = :producto_e ');
    SQL.Add('   and cosechero_e = :cosechero_e ');
    SQL.Add('   and plantacion_e = :plantacion_e ');
    SQL.Add('   and anyo_semana_e = :anyo_semana_e ');
    Prepare;
  end;

  with MiQuery do
  begin
    SQl.Clear;
    SQL.Add(' select merma_et, frf_escandallo.*  ');
    SQL.Add(' from frf_entradas2_l, frf_escandallo, frf_entradas_tipo  ');
    SQL.Add(' where empresa_e2l = :empresa  ');
    SQL.Add('   and centro_e2l = :centro  ');
    SQL.Add('   and producto_e2l = :producto  ');
    SQL.Add('   and fecha_e2l between :fechaini and :fechafin  ');

    SQL.Add('   and empresa_e = :empresa  ');
    SQL.Add('   and centro_e = :centro  ');
    SQL.Add('   and producto_e = :producto  ');
    SQL.Add('   and fecha_e = fecha_e2l  ');
    SQL.Add('   and numero_entrada_e = numero_entrada_e2l  ');
    SQL.Add('   and cosechero_e = cosechero_e2l  ');
    SQL.Add('   and plantacion_e = plantacion_e2l  ');
    SQL.Add('   and anyo_semana_e = ano_sem_planta_e2l ');

    SQL.Add('   and empresa_et = :empresa  ');
    SQL.Add('   and tipo_et = tipo_entrada_e  ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fechaini').AsDate := ALunes;
    ParamByName('fechafin').AsDate := ALunes + 6;
    Open;
    First;
    while not EOF do
    begin
      if fieldbyname('porcen_primera_e').AsFloat +
        fieldbyname('porcen_segunda_e').AsFloat +
        fieldbyname('porcen_tercera_e').AsFloat +
        fieldbyname('porcen_destrio_e').AsFloat > 0 then
      begin

        if fieldbyname('merma_et').AsInteger = 1 then
        begin
          factor := (100 - rPMerma) / 100;
          c1 := bRoundTo(fieldbyname('porcen_primera_e').AsFloat * factor, -5) - rPSobrePesoC1;
          if c1 < 0 then
            c1:= 0;
          c2 := bRoundTo(fieldbyname('porcen_segunda_e').AsFloat * factor, -5) - rPSobrePesoC2;
          if c2 < 0 then
            c2:= 0;
          c3 := bRoundTo(fieldbyname('porcen_tercera_e').AsFloat * factor, -5) - rPSobrePesoC3;
          if c3 < 0 then
            c3:= 0;
          des := bRoundTo(fieldbyname('porcen_destrio_e').AsFloat * factor, -5);
          if des < 0 then
            des:= 0;

          QAplica.ParamByName('pc1').AsFloat := c1;
          QAplica.ParamByName('pc2').AsFloat := c2;
          QAplica.ParamByName('pc3').AsFloat := c3;
          QAplica.ParamByName('pcd').AsFloat := des;
          QAplica.ParamByName('pcm').AsFloat := 100 - ( c1 + c2 + c3 + des );
        end
        else
        begin
          QAplica.ParamByName('pc1').AsFloat := fieldbyname('porcen_primera_e').AsFloat;
          QAplica.ParamByName('pc2').AsFloat := fieldbyname('porcen_segunda_e').AsFloat;
          QAplica.ParamByName('pc3').AsFloat := fieldbyname('porcen_tercera_e').AsFloat;
          QAplica.ParamByName('pcd').AsFloat := fieldbyname('porcen_destrio_e').AsFloat;
          QAplica.ParamByName('pcm').AsFloat := 0;
        end;

        QAplica.ParamByName('empresa_e').AsString:= FieldByName('empresa_e').AsString;
        QAplica.ParamByName('centro_e').AsString:= FieldByName('centro_e').AsString;
        QAplica.ParamByName('numero_entrada_e').AsString:= FieldByName('numero_entrada_e').AsString;
        QAplica.ParamByName('fecha_e').AsString:= FieldByName('fecha_e').AsString;
        QAplica.ParamByName('producto_e').AsString:= FieldByName('producto_e').AsString;
        QAplica.ParamByName('cosechero_e').AsString:= FieldByName('cosechero_e').AsString;
        QAplica.ParamByName('plantacion_e').AsString:= FieldByName('plantacion_e').AsString;
        QAplica.ParamByName('anyo_semana_e').AsString:= FieldByName('anyo_semana_e').AsString;

        QAplica.ExecSQL;

      end;
      Next;
    end;
    Close;
  end;

  QAplica.UnPrepare;
end;

procedure InicializarAprovechamientos(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime);
begin
  CrearQuerys;

  BEMensajes('Inicializando los aprovechamientos ...');

  with MiQuery do
  begin
    SQL.Clear;
    SQL.Add(' update frf_escandallo ');
    SQL.Add(' set aporcen_primera_e = 0, ');
    SQL.Add('     aporcen_segunda_e = 0, ');
    SQL.Add('     aporcen_tercera_e = 0, ');
    SQL.Add('     aporcen_destrio_e = 0, ');
    SQL.Add('     aporcen_merma_e = 0 ');
    SQL.Add(' where empresa_e = :empresa ');
    SQL.Add(' and centro_e = :centro ');
    SQL.Add(' and fecha_e between :fecha_ini and :fecha_fin ');
    SQL.Add(' and producto_e = :producto ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fecha_ini').AsDate := ALunes;
    ParamByName('fecha_fin').AsDate := ALunes + 6;
    ExecSQL;
  end;

  BEMensajes('');
end;

initialization
  MiQuery := nil;
  QAplica := nil;

finalization
  if MiQuery <> nil then
  begin
    MiQuery.Free;
    MiQuery := nil;
    QAplica.Free;
    QAplica := nil;
  end;

end.
