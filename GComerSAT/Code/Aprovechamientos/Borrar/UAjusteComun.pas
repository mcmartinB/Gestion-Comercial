unit UAjusteComun;

interface


  //Salidas directas
  function  GetPorcentajesSalida(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
              var p1, p2, p3, pd: real; const pm: real;
              const AKSelecC1, AKSelecC2, AKSelecC3: real ): string;


  function KilosCamaraExpedicionCat1(const AEmpresa, ACentro, AProducto,
      AFecha: string): Real;
  function KilosCamaraExpedicionCat2(const AEmpresa, ACentro, AProducto,
      AFecha: string): Real;

  function KilosCamaraCalibradosCat1(const AEmpresa, ACentro, AProducto,
      AFecha: string ): Real;
  function KilosCamaraCalibradosCat2(const AEmpresa, ACentro, AProducto,
      AFecha: string): Real;
  function KilosCamaraCalibradosCat3(const AEmpresa, ACentro, AProducto,
      AFecha: string): Real;
  function KilosCamaraCalibradosCatDes(const AEmpresa, ACentro, AProducto,
      AFecha: string): Real;

  function KilosAjustesCat1( const AEmpresa, ACentro, AProducto, AFecha: string): Real;
  function KilosAjustesCat2( const AEmpresa, ACentro, AProducto, AFecha: string): Real;
  function KilosAjustesCat3( const AEmpresa, ACentro, AProducto, AFecha: string): Real;
  function KilosAjustesCatDes( const AEmpresa, ACentro, AProducto, AFecha: string): Real;

  function GetPorcen(const AValue, ATotal: Real): Real;
  procedure Ajustar(var rC1, rC2, rC3, rCd, rCm: real; const rTotal: real = 100 );

implementation

uses SysUtils, bMath, Dialogs, UDMBaseDatos, bSQLUtils, CVariables;

function GetPorcen(const AValue, ATotal: Real): Real;
begin
  if ATotal = 0 then
  begin
    result := 0;
  end
  else
  begin
    result := bRoundTo(((AValue / ATotal) * 100), -5);
  end;
end;

procedure Ajustar(var rC1, rC2, rC3, rCd, rCm: real; const rTotal: real = 100 );
var
  rAcum, rMax, rResto: real;
begin
  rAcum := rC1 + rC2 + rC3 + rCd;
  if rAcum = 0 then
    Exit;
  rMax:= rTotal - rCm;
  rC1 := bRoundTo((rC1 * rMax) / rAcum, -5);
  rC2 := bRoundTo((rC2 * rMax) / rAcum, -5);
  rC3 := bRoundTo((rC3 * rMax) / rAcum, -5);
  rCd := bRoundTo((rCd * rMax) / rAcum, -5);
  rAcum := rC1 + rC2 + rC3 + rCd + rCm;

  if rAcum <> rTotal then
  begin
    rResto:= (rTotal - rAcum);
    if rResto <> 0 then
    begin
      rCd:= rCd + rResto;
      if rCd < 0 then
      begin
        rResto:= rCd;
        rCd:= 0;
      end
      else
      begin
        rResto:= 0;
      end;
      if rResto < 0 then
      begin
        rC3:= rC3 + rResto;
        if rC3 < 0 then
        begin
          rResto:= rC3;
          rC3:= 0;
        end
        else
        begin
          rResto:= 0;
        end;
        if rResto < 0 then
        begin
          rC2:= rC2 + rResto;
          if rC2 < 0 then
          begin
            rResto:= rC2;
            rC2:= 0;
          end
          else
          begin
            rResto:= 0;
          end;
          if rResto < 0 then
          begin
            rC1:= rC1 + rResto;
            if rC1 < 0 then
            begin
              rResto:= rC1;
              rC1:= 0;
            end
            else
            begin
              rResto:= 0;
            end;
            if rResto < 0 then
            begin
              rCm:= rCm + rResto;
              if rCm < 0 then
              begin
                rCm:= 0;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  rCm:= bRoundTo( rTotal - ( rC1 + rC2 + rC3 + rCd ), -5 );
end;

function GetPorcentajesSalida(
  const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
  var p1, p2, p3, pd: real; const pm: real;
  const AKSelecC1, AKSelecC2, AKSelecC3: real ): string;
var
  auxDate: string;
var
  k1, k2, k3, kd: real;
  k1a, k2a, k3a, kda: real;
  total: real;
  factor: real;
  rAux1, rAux2: Real;
begin
  with dmBaseDatos.QGeneral do
  begin
    SQL.Clear;
    //SALIDAS DIRECTAS
    SQL.Add(' select ');
    SQL.Add('     sum( case when categoria_sl = ''1'' then kilos_sl else 0 end ) kilos_cat_1, ');
    SQL.Add('     sum( case when categoria_sl = ''2'' then kilos_sl else 0 end ) kilos_cat_2, ');
    SQL.Add('     sum( case when categoria_sl = ''3'' then kilos_sl else 0 end ) kilos_cat_3, ');
    SQL.Add('     sum( case when categoria_sl in ( ''2B'',''3B'' ) then kilos_sl else 0 end ) kilos_cat_d, ');
    SQL.Add('     sum( kilos_sl ) kilos_total ');

    SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and fecha_sc between :fechaini and :fechafin ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');

    SQL.Add(' and producto_sl = :producto ');
    SQL.Add(' and nvl(es_transito_sc,0) = 0 ');
    SQL.Add(' and ref_transitos_sl is null  ');
    SQL.Add(' and categoria_sl <> ''B''  ');

    ParamByName('fechaini').AsString := AFechaIni;
    ParamByName('fechafin').AsString := AFechaFin;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;

    k1 := Fields[0].AsFloat;
    k2 := Fields[1].AsFloat;
    k3 := Fields[2].AsFloat;
    kd := Fields[3].AsFloat;
    total := Fields[4].AsFloat;
    Close;

    SQL.Clear;
    //TRANSITOS DIRECTOS
    SQL.Add(' select empresa_tl, centro_tl, referencia_tl, fecha_tl, ');
    SQL.Add('     sum( case when categoria_tl = ''1'' then kilos_tl else 0 end ) kilos_cat_1, ');
    SQL.Add('     sum( case when categoria_tl = ''2'' then kilos_tl else 0 end ) kilos_cat_2, ');
    SQL.Add('     sum( case when categoria_tl = ''3'' then kilos_tl else 0 end ) kilos_cat_3, ');
    SQL.Add('     sum( case when categoria_tl in ( ''2B'',''3B'' ) then kilos_tl else 0 end ) kilos_cat_d, ');
    SQL.Add('     sum( kilos_tl ) kilos_total ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' WHERE empresa_tl ' + SQLEqualS(AEmpresa));
    SQL.Add('   AND centro_origen_tl ' + SQLEqualS(ACentro));
    SQL.Add('   AND fecha_tl ' + SQLRangeD(AFechaIni, AFechaFin));
    SQL.Add('   AND producto_tl ' + SQLEqualS(AProducto));
    SQL.Add(' group by empresa_tl, centro_tl, referencia_tl, fecha_tl ');
    SQL.Add(' order by empresa_tl, centro_tl, referencia_tl, fecha_tl ');
    Open;

    if not IsEmpty then
    begin
      dmBaseDatos.QAux.SQL.Clear;
      dmBaseDatos.QAux.SQL.Add(' select ');
      dmBaseDatos.QAux.SQL.Add(' sum( case when categoria_sl = ''1'' then kilos_sl else 0 end ) kilos_cat_1, ');
      dmBaseDatos.QAux.SQL.Add(' sum( case when categoria_sl = ''2'' then kilos_sl else 0 end ) kilos_cat_2, ');
      dmBaseDatos.QAux.SQL.Add(' sum( case when categoria_sl = ''3'' then kilos_sl else 0 end ) kilos_cat_3, ');
      dmBaseDatos.QAux.SQL.Add(' sum( case when categoria_sl in ( ''2B'',''3B'' ) then kilos_sl else 0 end ) kilos_cat_d, ');
      dmBaseDatos.QAux.SQL.Add(' sum( kilos_sl ) kilos_total ');
      dmBaseDatos.QAux.SQL.Add(' from frf_salidas_l ');
      dmBaseDatos.QAux.SQL.Add(' WHERE empresa_sl ' + SQLEqualS(AEmpresa));
      dmBaseDatos.QAux.SQL.Add(' AND centro_origen_sl ' + SQLEqualS(ACentro));
      dmBaseDatos.QAux.SQL.Add(' AND fecha_sl between :fechaini and :fechafin ');
      dmBaseDatos.QAux.SQL.Add(' AND producto_sl ' + SQLEqualS(AProducto));
      dmBaseDatos.QAux.SQL.Add(' AND ref_transitos_sl = :transito ');
      while not Eof do
      begin
        dmBaseDatos.QAux.ParamByName('fechaini').AsDate:= FieldByName('fecha_tl').AsDateTime;
        dmBaseDatos.QAux.ParamByName('fechafin').AsDate:= FieldByName('fecha_tl').AsDateTime  + 90;
        dmBaseDatos.QAux.ParamByName('transito').AsInteger:= FieldByName('referencia_tl').AsInteger;
        dmBaseDatos.QAux.Open;

        if FieldByName('kilos_total').AsFloat = dmBaseDatos.QAux.FieldByName('kilos_total').AsFloat then
        begin
          k1 := k1 + dmBaseDatos.QAux.FieldByName('kilos_cat_1').AsFloat;
          k2 := k2 + dmBaseDatos.QAux.FieldByName('kilos_cat_2').AsFloat;
          k3 := k3 + dmBaseDatos.QAux.FieldByName('kilos_cat_3').AsFloat;
          kd := kd + dmBaseDatos.QAux.FieldByName('kilos_cat_d').AsFloat;
          total := total + dmBaseDatos.QAux.FieldByName('kilos_total').AsFloat;
        end
        else
        begin
          k1 := k1 + FieldByName('kilos_cat_1').AsFloat;
          k2 := k2 + FieldByName('kilos_cat_2').AsFloat;
          k3 := k3 + FieldByName('kilos_cat_3').AsFloat;
          kd := kd + FieldByName('kilos_cat_d').AsFloat;
          total := total + FieldByName('kilos_total').AsFloat;
        end;
        dmBaseDatos.QAux.Close;
        Next;
      end;
    end;
    Close;

(*
    SQL.Add(' select ');
    SQL.Add('     sum( case when categoria_tl = ''1'' then kilos_tl else 0 end ) kilos_cat_1, ');
    SQL.Add('     sum( case when categoria_tl = ''2'' then kilos_tl else 0 end ) kilos_cat_2, ');
    SQL.Add('     sum( case when categoria_tl = ''3'' then kilos_tl else 0 end ) kilos_cat_3, ');
    SQL.Add('     sum( case when categoria_tl in ( ''2B'',''3B'' ) then kilos_tl else 0 end ) kilos_cat_d, ');
    SQL.Add('     sum( kilos_tl ) kilos_total ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' WHERE empresa_tl ' + SQLEqualS(AEmpresa));
    SQL.Add('   AND centro_origen_tl ' + SQLEqualS(ACentro));
    SQL.Add('   AND fecha_tl ' + SQLRangeD(AFechaIni, AFechaFin));
    SQL.Add('   AND producto_tl ' + SQLEqualS(AProducto));
    Open;
    k1 := k1 + Fields[0].AsFloat;
    k2 := k2 + Fields[1].AsFloat;
    k3 := k3 + Fields[2].AsFloat;
    kd := kd + Fields[3].AsFloat;
    total := total + Fields[4].AsFloat;
    Close;
*)

    //KgsSalida( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, k1, k2, k3, kd, total );

    if Total = 0 then
    begin
      raise Exception.Create('No hay salidas grabadas para los parametros pasados.');
    end;

    if bRoundTo(k1 + k2 + k3 + kd, -2) <> bRoundTo(total, -2) then
    begin
      raise Exception.Create('No puede haber salidas con categorias distintas de "1","2","3","2B","3B". ');
    end;

    auxDate := DateToStr(StrToDate(AFechaIni) - 1);

    (*
    rAux1:= KilosCamaraExpedicionCat1(AEmpresa, ACentro, AProducto, AFechaFin);
    rAux2:= KilosCamaraExpedicionCat1(AEmpresa, ACentro, AProducto, auxDate);
    k1 :=  k1 + rAux1 - rAux2;

    rAux1:= KilosCamaraExpedicionCat2(AEmpresa, ACentro, AProducto, AFechaFin);
    rAux2:= KilosCamaraExpedicionCat2(AEmpresa, ACentro, AProducto, auxDate);
    k2 := k2 + rAux1 - rAux2;
    *)

    rAux1:= KilosCamaraCalibradosCat1(AEmpresa, ACentro, AProducto, AFechaFin )  +  KilosAjustesCat1(AEmpresa, ACentro, AProducto, AFechaFin ) ;
    rAux2:= KilosCamaraCalibradosCat1(AEmpresa, ACentro, AProducto, auxDate );
    k1a :=  k1 + rAux1 - rAux2;
    if k1a < 0 then
      k1a:= 0;

    rAux1:= KilosCamaraCalibradosCat2(AEmpresa, ACentro, AProducto, AFechaFin)  +  KilosAjustesCat2(AEmpresa, ACentro, AProducto, AFechaFin ) ;
    rAux2:= KilosCamaraCalibradosCat2(AEmpresa, ACentro, AProducto, auxDate);
    k2a := k2 + rAux1 - rAux2;
    if k2a < 0 then
      k2a:= 0;

    rAux1:= KilosCamaraCalibradosCat3(AEmpresa, ACentro, AProducto, AFechaFin) +  KilosAjustesCat3(AEmpresa, ACentro, AProducto, AFechaFin ) ;
    rAux2:= KilosCamaraCalibradosCat3(AEmpresa, ACentro, AProducto, auxDate);
    k3a := k3 + rAux1 - rAux2;
    if k3a < 0 then
      k3a:= 0;

    rAux1:= KilosCamaraCalibradosCatDes(AEmpresa, ACentro, AProducto, AFechaFin) +  KilosAjustesCatDes(AEmpresa, ACentro, AProducto, AFechaFin ) ;
    rAux2:= KilosCamaraCalibradosCatDes(AEmpresa, ACentro, AProducto, auxDate);
    kda := kd + rAux1 - rAux2;
    if kda < 0 then
      kda:= 0;

    if ( k1a >= 0 ) and ( k2a >= 0 ) and ( k3a >= 0 ) and ( kda >= 0 ) then
    begin
      k1:= k1a;
      k2:= k2a;
      k3:= k3a;
      kd:= kda;
    end;

    if not gbAjustarSeleccionado then
    begin
      k1 := k1 - AKSelecC1;
      k2 := k2 - AKSelecC2;
      k3 := k3 - AKSelecC3;
    end;
    if k1 <0 then
    begin
      k1:= 0;
    end;
    if k2 <0 then
    begin
      k2:= 0;
    end;
    if k3 <0 then
    begin
      k3:= 0;
    end;

    total := bRoundTo( k1 + k2 + k3 + kd, -2 );

    //informe.Add('KGS SALIDA');
    //informe.Add(FloatToStr(k1)+ ' ' + FloatToStr(k2)+ ' ' + FloatToStr(k3)+ ' ' + FloatToStr(kd)+ ' ' );

    factor := bRoundTo( (100 - pm) / 100, -5 );
    p1 := bRoundTo( GetPorcen(k1, total), -5 );
    p2 := bRoundTo( GetPorcen(k2, total), -5 );
    p3 := bRoundTo( GetPorcen(k3, total), -5 );
    pd := bRoundTo( GetPorcen(kd, total), -5 );


    result:= FormatFloat('00.00000', p1) + '  ' +
      FormatFloat('00.00000', p2) + '  ' +
      FormatFloat('00.00000', p3) + '  ' +
      FormatFloat('00.00000', pd) + '  ' +
      '            % SALIDA';

    p1 := bRoundTo( p1 * factor, -5 );
    p2 := bRoundTo( p2 * factor, -5 );
    p3 := bRoundTo( p3 * factor, -5 );
    pd := bRoundTo( pd * factor, -5 );

    factor := pm;
    Ajustar(p1, p2, p3, pd, factor, 100);

    result:= result + #13 + #10;
    result:= result + #13 + #10;
    result:= result + FormatFloat('00.00000', p1) + '  ' +
      FormatFloat('00.00000', p2) + '  ' +
      FormatFloat('00.00000', p3) + '  ' +
      FormatFloat('00.00000', pd) + '  ' +
      FormatFloat('00.00000', pm) + '  ' +
      '  % SALIDA AJUSTADA';

  end;
end;

function KilosCamaraExpedicionCat1(const AEmpresa, ACentro, AProducto,
  AFecha: string): Real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select sum( kilos_ce_c1_il ) ');
    SQL.Add(' from frf_inventarios_l ');
    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha  ');
    ParamByName('fecha').AsString := AFecha;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('No hay inventario grabado el "' + AFecha +
        '" para el producto "' + AProducto + '".');
    end;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KilosCamaraExpedicionCat2(const AEmpresa, ACentro, AProducto,
  AFecha: string): Real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select sum( kilos_ce_c2_il ) ');
    SQL.Add(' from frf_inventarios_l ');
    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha  ');
    ParamByName('fecha').AsString := AFecha;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('No hay inventario grabado el "' + AFecha +
        '" para el producto "' + AProducto + '".');
    end;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KilosCamaraCalibradosCat1(const AEmpresa, ACentro, AProducto, AFecha: string ): Real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select kilos_cim_c1_ic + kilos_cia_c1_ic + ');
    SQL.Add('            (select sum( kilos_ce_c1_il ) ');
    SQL.Add('            from frf_inventarios_l ');
    SQL.Add('            where empresa_il = :empresa ');
    SQL.Add('            and centro_il = :centro ');
    SQL.Add('            and producto_il = :producto ');
    SQL.Add('            and fecha_il = :fecha ) ');
    SQL.Add(' from frf_inventarios_c ');
    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add('   and centro_ic = :centro ');
    SQL.Add('   and producto_ic = :producto ');
    SQL.Add('   and fecha_ic = :fecha ');
    ParamByName('fecha').AsString := AFecha;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('No hay inventario grabado el "' + AFecha +
        '" para el producto "' + AProducto + '".');
    end;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KilosCamaraCalibradosCat2(const AEmpresa, ACentro, AProducto,
  AFecha: string): Real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select kilos_cim_c2_ic + kilos_cia_c2_ic + ');
    SQL.Add('            (select sum( kilos_ce_c2_il ) ');
    SQL.Add('            from frf_inventarios_l ');
    SQL.Add('            where empresa_il = :empresa ');
    SQL.Add('            and centro_il = :centro ');
    SQL.Add('            and producto_il = :producto ');
    SQL.Add('            and fecha_il = :fecha ) ');
    SQL.Add(' from frf_inventarios_c ');
    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add('   and centro_ic = :centro ');
    SQL.Add('   and producto_ic = :producto ');
    SQL.Add('   and fecha_ic = :fecha ');
    ParamByName('fecha').AsString := AFecha;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('No hay inventario grabado el "' + AFecha +
        '" para el producto "' + AProducto + '".');
    end;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KilosCamaraCalibradosCat3(const AEmpresa, ACentro, AProducto,
  AFecha: string): Real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select kilos_zd_c3_ic ');
    SQL.Add(' from frf_inventarios_c ');
    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add(' and centro_ic = :centro ');
    SQL.Add(' and producto_ic = :producto ');
    SQL.Add(' and fecha_ic = :fecha ');
    ParamByName('fecha').AsString := AFecha;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('No hay inventario grabado el "' + AFecha +
        '" para el producto "' + AProducto + '".');
    end;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KilosCamaraCalibradosCatDes(const AEmpresa, ACentro, AProducto,
  AFecha: string): Real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select kilos_zd_d_ic ');
    SQL.Add(' from frf_inventarios_c ');
    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add(' and centro_ic = :centro ');
    SQL.Add(' and producto_ic = :producto ');
    SQL.Add(' and fecha_ic = :fecha ');
    ParamByName('fecha').AsString := AFecha;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('No hay inventario grabado el "' + AFecha +
        '" para el producto "' + AProducto + '".');
    end;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KilosAjustesCat1( const AEmpresa, ACentro, AProducto, AFecha: string): Real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select kilos_ajuste_c1_ic ');
    SQL.Add(' from frf_inventarios_c ');
    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add(' and centro_ic = :centro ');
    SQL.Add(' and producto_ic = :producto ');
    SQL.Add(' and fecha_ic = :fecha ');
    ParamByName('fecha').AsString := AFecha;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('No hay inventario grabado el "' + AFecha +
        '" para el producto "' + AProducto + '".');
    end;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KilosAjustesCat2( const AEmpresa, ACentro, AProducto, AFecha: string): Real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select kilos_ajuste_c2_ic ');
    SQL.Add(' from frf_inventarios_c ');
    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add(' and centro_ic = :centro ');
    SQL.Add(' and producto_ic = :producto ');
    SQL.Add(' and fecha_ic = :fecha ');
    ParamByName('fecha').AsString := AFecha;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('No hay inventario grabado el "' + AFecha +
        '" para el producto "' + AProducto + '".');
    end;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KilosAjustesCat3( const AEmpresa, ACentro, AProducto, AFecha: string): Real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select kilos_ajuste_c3_ic ');
    SQL.Add(' from frf_inventarios_c ');
    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add(' and centro_ic = :centro ');
    SQL.Add(' and producto_ic = :producto ');
    SQL.Add(' and fecha_ic = :fecha ');
    ParamByName('fecha').AsString := AFecha;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('No hay inventario grabado el "' + AFecha +
        '" para el producto "' + AProducto + '".');
    end;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

function KilosAjustesCatDes( const AEmpresa, ACentro, AProducto, AFecha: string): Real;
begin
  with dmBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select kilos_ajuste_cd_ic ');
    SQL.Add(' from frf_inventarios_c ');
    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add(' and centro_ic = :centro ');
    SQL.Add(' and producto_ic = :producto ');
    SQL.Add(' and fecha_ic = :fecha ');
    ParamByName('fecha').AsString := AFecha;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    Open;
    if IsEmpty then
    begin
      Close;
      raise Exception.Create('No hay inventario grabado el "' + AFecha +
        '" para el producto "' + AProducto + '".');
    end;
    result := Fields[0].AsFloat;
    Close;
  end;
end;

end.
