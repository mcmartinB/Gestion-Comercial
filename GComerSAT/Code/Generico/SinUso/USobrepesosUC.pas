{*
  Codigo comun para el tratamiento de los sobrepesos de las cajas
  INICIO: 17/3/2005
  El tomate no se puede partir, las cajas de 500 gramos no tienen normalmente
  500 gramos justo, por lo general hay mas tomate, esa cantidad de mas es lo
  que llamamos sobrepeso.

  @author Departamento de Informática Horvesa
  @version V.0.1
}
unit USobrepesosUC;

interface

procedure KgsSobrepeso(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
  var ASobrePesoC1, ASobrePesoC2, ASobrePesoC3: Real);

procedure AjustarCantidadesMerma(var AMerma, ASobrePesoC1, ASobrePesoC2, ASobrePesoC3: real);

implementation

uses bMath, SysUtils,
  UDMBaseDatos, bSQLUtils, DB ;

procedure LimpiaTablaSobrepesos;
begin
  with DMBaseDatos.QAux do
  begin
    SQl.Clear;
    SQL.Add('delete from tmp_sobrepesos');
    ExecSQL;
  end;
end;

function BuscaSobrepeso(const AEmpresa, AAnyo, AMes, AProductoBase, AEnvase: string): Real;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    (*SQL.Add('select first 1 peso_es, anyo_es, mes_es from frf_env_sobrepeso');*)
    SQL.Add('select peso_es, anyo_es, mes_es from frf_env_sobrepeso');
    SQL.Add('where empresa_es ' + SQLEqualS(AEmpresa));
    SQL.Add('  and producto_base_es ' + SQLEqualN(AProductoBase));
    SQL.Add('  and envase_es ' + SQLEqualS(AEnvase));
    SQL.Add('order by anyo_es desc, mes_es desc');
    Open;
    if IsEmpty then
    begin
      result := 0;
    end
    else
    begin
      result := Fields[0].AsFloat;
    end;
    Close;
  end;
end;

procedure InsertaSobrepeso(const AEmpresa, Anyo, AMes, AProductoBase, AEnvase: string);
var
  peso: real;
begin
  peso := BuscaSobrepeso(AEmpresa, Anyo, AMes, AProductoBase, AEnvase);
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * from tmp_sobrepesos ');
    SQL.Add('where t_empresa_s = ' + SQLString(AEmpresa) );
    SQL.Add('  and t_producto_base_s = ' + SQLNumeric(AProductoBase) );
    SQL.Add('  and t_envase_s = ' + SQLString(AEnvase) );
    Open;

    if IsEmpty then
    begin
      Close;
      SQL.Clear;
      SQL.Add('insert into tmp_sobrepesos values (');
      SQL.Add(SQLString(AEmpresa) + ',');
      SQL.Add(SQLNumeric(AProductoBase) + ',');
      SQL.Add(SQLString(AEnvase) + ',');
      SQL.Add(SQLNumeric(peso));
      SQL.Add(')');
      ExecSQL;
    end
    else
    begin
      Close;
    end;
  end;
end;

function RellenaTablaSobrepesos(const AEmpresa, ACentro, AProducto,
  AFechaIni, AFechaFin: string): integer;
var
  cont: integer;
  Year, Month, Day: Word;
  sYear, sMonth: string;
begin
  LimpiaTablaSobrepesos;
  DecodeDate(StrToDate(AFechaIni), Year, Month, Day);
  sYear := IntToStr(Year);
  sMonth := IntToStr(Month);
  cont := 0;
  with DMBaseDatos.QTemp do
  begin
    //Salidas
    SQL.Clear;
    SQL.Add(' select distinct producto_base_p, envase_sl ');
    SQL.Add(' from   frf_salidas_l, frf_productos ');
    SQL.Add(' where empresa_sl ' + SQLEqualS(AEmpresa));
    SQL.Add(' and centro_origen_sl ' + SQLEqualS(ACentro));
    SQL.Add(' and fecha_sl ' + SQLRangeD(AFechaIni, AFechaFin) + ' ');
    SQL.Add(' and producto_sl ' + SQLEqualS(AProducto));
    SQL.Add(' and empresa_p ' + SQLEqualS(AEmpresa));
    SQL.Add(' and producto_p ' + SQLEqualS(AProducto));
    Open;
    while not EOF do
    begin
      InsertaSobrepeso(AEmpresa, sYear, sMonth, Fields[0].AsString, Fields[1].AsString);
      Inc(cont);
      Next;
    end;
    Close;

    //Transitos
    SQL.Clear;
    SQL.Add(' select distinct producto_base_p, envase_tl ');
    SQL.Add(' from   frf_transitos_l, frf_productos ');
    SQL.Add(' where empresa_tl ' + SQLEqualS(AEmpresa));
    SQL.Add(' and centro_tl ' + SQLEqualS(ACentro));
    SQL.Add(' and fecha_tl ' + SQLRangeD(AFechaIni, AFechaFin) + ' ');
    SQL.Add(' and producto_tl ' + SQLEqualS(AProducto));
    SQL.Add(' and empresa_p ' + SQLEqualS(AEmpresa));
    SQL.Add(' and producto_p ' + SQLEqualS(AProducto));
    Open;
    while not EOF do
    begin
      InsertaSobrepeso(AEmpresa, sYear, sMonth,
        Fields[0].AsString, Fields[1].AsString);
      Inc(cont);
      Next;
    end;
    Close;
  end;
  result := cont;
end;

procedure KgsSobrepeso(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
  var ASobrePesoC1, ASobrePesoC2, ASobrePesoC3: Real);
begin
  if RellenaTablaSobrepesos(AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin) > 0 then
  begin
    with DMBaseDatos.QAux do
    begin
      //SALIDAS DIRECTAS
      SQL.Clear;
      SQL.Add(' select round( sum( ');
      SQL.Add('             case when categoria_sl ' + SQLEqualS('1') + ' ');
      SQL.Add('                  then cajas_sl * t_peso_s ');
      SQL.Add('                  else 0 ');
      SQL.Add('             end) / 1000 ,2 ');
      SQL.Add('        ) sobre_c1, ');
      SQL.Add('        round( sum( ');
      SQL.Add('             case when categoria_sl ' + SQLEqualS('2') + ' ');
      SQL.Add('                  then cajas_sl * t_peso_s ');
      SQL.Add('                  else 0 ');
      SQL.Add('             end) / 1000 ,2 ');
      SQL.Add('        ) sobre_c2, ');
      SQL.Add('        round( sum( ');
      SQL.Add('             case when categoria_sl ' + SQLEqualS('3') + ' ');
      SQL.Add('                  then cajas_sl * t_peso_s ');
      SQL.Add('                  else 0 ');
      SQL.Add('             end) / 1000 ,2 ');
      SQL.Add('        ) sobre_c3 ');
      SQL.Add(' from   frf_salidas_c, frf_salidas_l, frf_productos, tmp_sobrepesos ');
      SQL.Add(' ');

      SQL.Add(' where empresa_sc ' + SQLEqualS(AEmpresa) + ' ');
      if not ((ACentro = '6') and (AProducto = 'E')) then
      begin
        SQL.Add(' and centro_salida_sc ' + SQLEqualS(ACentro));
      end;
      SQL.Add(' and fecha_sc ' + SQLRangeD(AFechaIni, AFechaFin) + ' ');

      SQL.Add(' and empresa_sl ' + SQLEqualS(AEmpresa) + ' ');
      SQL.Add(' and centro_salida_sl = centro_salida_sc ');
      SQL.Add(' and fecha_sl = fecha_sc ');
      SQL.Add(' and n_albaran_sl = n_albaran_sc ');

      SQL.Add(' and centro_origen_sl ' + SQLEqualS(ACentro));
      SQL.Add(' and producto_sl ' + SQLEqualS(AProducto));
      SQL.Add(' and categoria_sl in (' + SQLString('1') + ','
        + SQLString('2') + ','
        + SQLString('3') + ') ');
      SQL.Add(' and ( nvl(es_transito_sc,0) =  0 ) ' );
      SQL.Add(' and TRIM(NVL(ref_transitos_sl,' + QuotedStr('') + ')) = ' + QuotedStr(''));
      SQL.Add(' ');
      SQL.Add(' and empresa_p ' + SQLEqualS(AEmpresa) + ' ');
      SQL.Add(' and producto_p = producto_sl ');
      SQL.Add(' ');
      SQL.Add(' and t_empresa_s ' + SQLEqualS(AEmpresa) + ' ');
      SQL.Add(' and t_envase_s = envase_sl ');
      SQL.Add(' and t_producto_base_s = producto_base_p ');
      Open;
      if IsEmpty then
      begin
        ASobrePesoC1 := 0;
        ASobrePesoC2 := 0;
        ASobrePesoC3 := 0;
      end
      else
      begin
        ASobrePesoC1 := Fields[0].AsFloat;
        ASobrePesoC2 := Fields[1].AsFloat;
        ASobrePesoC3 := Fields[2].AsFloat;
      end;
      Close;

      //TRANSITOS
      SQL.Clear;
      SQL.Add(' select round( sum( ');
      SQL.Add('             case when categoria_tl ' + SQLEqualS('1') + ' ');
      SQL.Add('                  then cajas_tl * t_peso_s ');
      SQL.Add('                  else 0 ');
      SQL.Add('             end) / 1000 ,2 ');
      SQL.Add('        ) sobre_c1, ');
      SQL.Add('        round( sum( ');
      SQL.Add('             case when categoria_tl ' + SQLEqualS('2') + ' ');
      SQL.Add('                  then cajas_tl * t_peso_s ');
      SQL.Add('                  else 0 ');
      SQL.Add('             end) / 1000 ,2 ');
      SQL.Add('        ) sobre_c2, ');
      SQL.Add('        round( sum( ');
      SQL.Add('             case when categoria_tl ' + SQLEqualS('3') + ' ');
      SQL.Add('                  then cajas_tl * t_peso_s ');
      SQL.Add('                  else 0 ');
      SQL.Add('             end) / 1000 ,2 ');
      SQL.Add('        ) sobre_c3 ');
      SQL.Add(' from   frf_transitos_l, frf_productos, tmp_sobrepesos ');
      SQL.Add(' ');
      SQL.Add(' where empresa_tl ' + SQLEqualS(AEmpresa) + ' ');
      SQL.Add(' and centro_tl ' + SQLEqualS(ACentro));
      SQL.Add(' and producto_tl ' + SQLEqualS(AProducto));
      SQL.Add(' and fecha_tl ' + SQLRangeD(AFechaIni, AFechaFin) + ' ');
      SQL.Add(' and categoria_tl in (''1'',''2'',''3'') ');
      SQL.Add(' ');
      SQL.Add(' and empresa_p ' + SQLEqualS(AEmpresa) + ' ');
      SQL.Add(' and producto_p = producto_tl ');
      SQL.Add(' ');
      SQL.Add(' and t_empresa_s ' + SQLEqualS(AEmpresa) + ' ');
      SQL.Add(' and t_envase_s = envase_tl ');
      SQL.Add(' and t_producto_base_s = producto_base_p ');
      Open;
      if not IsEmpty then
      begin
        ASobrePesoC1 := ASobrePesoC1 + Fields[0].AsFloat;
        ASobrePesoC2 := ASobrePesoC2 + Fields[1].AsFloat;
        ASobrePesoC3 := ASobrePesoC3 + Fields[2].AsFloat;
      end;
      Close;
    end;
  end
  else
  begin
    ASobrePesoC1 := 0;
    ASobrePesoC2 := 0;
    ASobrePesoC3 := 0;
  end;
end;

procedure AjustarCantidadesMerma(var AMerma, ASobrePesoC1, ASobrePesoC2, ASobrePesoC3: real);
var
  merma, sobrepeso: real;
begin
  merma := AMerma;
  sobrepeso := ASobrePesoC1 + ASobrePesoC2 + ASobrePesoC3;
  AMerma := AMerma - (sobrepeso);
  if AMerma < 0 then
  begin
    AMerma := 0;
    ASobrePesoC1 := bRoundTo(((ASobrePesoC1) / sobrepeso) * merma, -2);
    ASobrePesoC2 := bRoundTo(((ASobrePesoC2) / sobrepeso) * merma, -2);
    ASobrePesoC3 := bRoundTo(((ASobrePesoC3) / sobrepeso) * merma, -2);
    sobrepeso := ASobrePesoC1 + ASobrePesoC2 + ASobrePesoC3;
    ASobrePesoC1 := ASobrePesoC1 + (merma - (sobrepeso));
  end;
end;

end.
