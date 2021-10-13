(*
  2005.04.19 PACO dijo que los abonos en su totalidad se restarian a la primera
             en la liquidacion
*)
unit ULiquidacionComun;

interface

uses
  Forms, Controls, SysUtils, DateUtils, bMath;

procedure CrearTablasTemporales;
procedure DestruirTablasTemporales;
procedure CalcularFechaInicio(const AEmpresa, ACentro, AProducto, ACosechero,
  AFechaIni, AFechaFin: string; var ANuevaIni, ANuevaFin: string );
procedure CosteEnvasado(const AUsuario, AEmpresa, ACentro, AProducto: string; const AFechaIni, AFechaFin: TDate);
procedure CalcularFOB(const AEmpresa, ACentro, AProducto, AFechaIni: string);
procedure PreparaLiquidacion(const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni,
  AFechaFin, ACosteComercial, ACosteProduccion, ACosteAdministrativo: string);

(*
function AplicarAjusteFob(const AEmpresa, ACosechero: string): Boolean;
procedure GetAjusteCosFobSemana( const AEmpresa, ACosechero, AProducto, AAnyoSemana: string;
                                var APrimera, ASegunda, AResto: Real );
function FaltanAjustesCosFob(const AEmpresa, AProducto: string;
  var AFaltan: string): boolean;
*)              

procedure NuevoCalcularFOB(const AUsuario, AEmpresa, ACentro, AProducto, AFechaInicio, AFechaFin: string;
  const AAbonos: Boolean);
function EstaAjustado( const AEmpresa, ACentro, AProducto: string;
                       const AFechaIni, AFechaFin: TDateTime; var AProductoCorte, AFechaCorte: string ): boolean;
function EstaEscandalloGrabado( const AEmpresa, ACentro, AProducto: string;
                                const AFechaIni, AFechaFin: TDateTime; var AFechaCorte: string ): boolean;

var
  bCosteEnvasado: boolean = True;

implementation

uses
  UDMAuxDB, UDMBaseDatos, bSQLUtils, CGestionPrincipal, RLiquidacionCosecheros,
  CReportes, bTimeUtils, TablaTmpFob, CVariables, DBTables, DB;

procedure AnyadirAbono(const AUsuario, AEmpresa, ACentro, AProducto, AAnyoSemana: string;
  const AValue: Real);
var
  rCosteKilo: Real;
  QAnyadirAbono: TQuery;
begin
  QAnyadirAbono := TQuery.Create(Application);
  QAnyadirAbono.DatabaseName := 'BDProyecto';

  try
    with QAnyadirAbono do
    begin
    //Seleccionar kilos
      //SQL.Add('select sum( round( ( ( aporcen_primera_e + aporcen_segunda_e )* total_kgs_e2l ) / 100, 2 ) ) kilos ');
      SQL.Add('select sum( round( ( aporcen_primera_e * total_kgs_e2l ) / 100, 2 ) ) kilos ');
      SQL.Add('from frf_escandallo, frf_entradas2_l ');
      SQL.Add('where empresa_e = :empresa ');
      SQL.Add('and centro_e = :centro ');
      SQL.Add('and fecha_e between :fechaini and :fechafin ');
      SQL.Add('and producto_e = :producto ');
      SQL.Add('and empresa_e2l = :empresa ');
      SQL.Add('and centro_e2l = :centro ');
      SQL.Add('and fecha_e2l = fecha_e ');
      SQL.Add('and numero_entrada_e2l = numero_entrada_e ');
      SQL.Add('and cosechero_e2l = cosechero_e ');
      SQL.Add('and plantacion_e2l = plantacion_e ');
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('producto').AsString := AProducto;
      ParamByName('fechaini').AsDate := LunesAnyoSemana(AAnyoSemana);
      ParamByName('fechaFin').AsDate := ParamByName('fechaini').AsDate + 6;
      Open;
      if Fields[0].AsFloat <> 0 then
      begin
        rCosteKilo := Trunc((AValue / Fields[0].AsFloat) * 1000) / 1000;
      end
      else
      begin
        rCosteKilo := 0;
      end;
      Close;

      if rCosteKilo <> 0 then
      begin
        SQL.Clear;
        SQL.Add('update tmp_fob_aux ');
        SQL.Add('set fob = fob + :value ');
        //SQL.Add('where categoria in( ''1'', ''2'' ) ');
        SQL.Add('where categoria = ''1'' ');
        SQL.Add('  and anyosemana = :anyosemana ');
        ParamByName('anyosemana').AsString := AAnyoSemana;
        ParamByName('value').AsFloat := rCosteKilo;
        ExecSQL;
      end;
    end;
  finally
    FreeAndNil(QAnyadirAbono);
  end;
end;

procedure AnyadirAbonos(const AUsuario, AEmpresa, ACentro, AProducto, AProductor, AFechaInicio, AFechaFin: string);
var
  QAnyadirAbonos: TQuery;
begin
  QAnyadirAbonos := TQuery.Create(Application);
  QAnyadirAbonos.DatabaseName := 'BDProyecto';

  try
    with QAnyadirAbonos do
    begin
    //Sacar abonos comunes
      SQL.add('select YearAndWeek( fecha_fal ) anyosemana, ');
      SQL.add('       sum( EUROS( moneda_f, fecha_fal, importe_fal ) ) importe ');
      SQL.add('from frf_fac_abonos_l, frf_facturas ');
      SQL.add('where empresa_fal = :empresa ');
      SQL.add('  and centro_salida_fal = :centro ');
      SQL.add('and fecha_fal between :desde and :hasta ');
      SQL.add('and producto_fal = :producto ');
      SQL.add('and cosechero_fal is null ');
      SQL.add('and empresa_f = :empresa ');
      SQL.add('and n_factura_f = factura_fal ');
      SQL.add('and fecha_factura_f = fecha_fal ');
      SQL.add('group by 1 ');
      SQL.add('order by 1 ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('desde').AsString := AFechaInicio;
      ParamByName('hasta').AsString := AFechaFin;
      ParamByName('producto').AsString := AProducto;
      Open;

      while not EOF do
      begin
      //Para cada semana con abonos
        AnyadirAbono(AUsuario, AEmpresa, ACentro, AProducto, Fields[0].AsString, Fields[1].AsFloat);
        Next;
      end;
      Close;

    end;
  finally
    FreeAndNil(QAnyadirAbonos);
  end;
end;

(*
function AplicarAjusteFob(const AEmpresa, ACosechero: string): Boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select NVL( ajustar_c, 0 ) ');
    SQL.Add('from frf_cosecheros ');
    SQL.Add('where empresa_c = :empresa ');
    SQL.Add('  and cosechero_c = :cosechero ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cosechero').AsString := ACosechero;
    Open;
    result := Fields[0].AsFloat <> 0;
    Close;
  end;
end;

function FaltanAjustesCosFob(const AEmpresa, AProducto: string;
  var AFaltan: string): boolean;
var
  sAux, sCos: string;
begin
  AFaltan := '';
  with DMBaseDatos do
  begin
    QAux.SQL.Clear;
    QAux.SQL.Add('select * ');
    QAux.SQL.Add('from frf_cos_ajuste_fob ');
    QAux.SQL.Add('where empresa_caf = :empresa ');
    QAux.SQL.Add('  and cosechero_caf = :cosechero ');
    QAux.SQL.Add('  and anyosemana_caf = :anyosemana ');
    QAux.SQL.Add('  and producto_caf = :producto ');
    QAux.ParamByName('empresa').AsString := AEmpresa;
    QAux.ParamByName('producto').AsString := AProducto;

    QTemp.SQL.Clear;
    QTemp.SQL.Add('select cosechero, anyosemana ');
    QTemp.SQL.Add('from tmp_categorias ');
    QTemp.SQL.Add('group by 1, 2 ');
    QTemp.SQL.Add('order by 1, 2 ');
    QTemp.Open;

    sCos := '';
    while not QTemp.Eof do
    begin
      if AplicarAjusteFob(AEmpresa, QTemp.FieldByName('cosechero').asstring) then
      begin
        QAux.ParamByName('cosechero').AsString := QTemp.FieldByName('cosechero').asstring;
        QAux.ParamByName('anyosemana').AsString := QTemp.FieldByName('anyosemana').asstring;
        QAux.Open;
        if QAux.IsEmpty then
        begin
          if Length(QTemp.FieldByName('cosechero').asstring) = 1 then
            sAux := '0' + QTemp.FieldByName('cosechero').asstring
          else
            sAux := QTemp.FieldByName('cosechero').asstring;
          if (sCos <> sAux) then
          begin
            if (sCos <> '') then
              AFaltan := AFaltan + #13 + #10;
            AFaltan := AFaltan + '# COSECHERO: ' + sAux + #13 + #10 + QTemp.FieldByName('anyosemana').asstring;
            sCos := sAux;
          end
          else
          begin
            AFaltan := AFaltan + ', ' + QTemp.FieldByName('anyosemana').asstring;
          end;
        end;
        QAux.Close;
      end;
      Qtemp.next;
    end;
    Qtemp.Close;
  end;
  result := AFaltan <> '';
end;

procedure GetAjusteCosFobSemana( const AEmpresa, ACosechero, AProducto, AAnyoSemana: string;
                                var APrimera, ASegunda, AResto: Real );
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select NVL( ajuste_primera_caf, 0 ) primera, NVL( ajuste_segunda_caf, 0 ) segunda, NVL( ajuste_resto_caf, 0 ) resto');
    SQL.Add('from frf_cos_ajuste_fob ');
    SQL.Add('where empresa_caf = :empresa ');
    SQL.Add('  and cosechero_caf = :cosechero ');
    SQL.Add('  and anyosemana_caf = :anyosemana ');
    SQL.Add('  and producto_caf = :producto ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cosechero').AsString := ACosechero;
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ParamByName('producto').AsString := AProducto;
    Open;
    APrimera := FieldByName('primera').AsFloat;
    ASegunda := FieldByName('segunda').AsFloat;
    AResto := FieldByName('resto').AsFloat;
    Close;
  end;
end;
*)

procedure DestruirTablasTemporales;
begin
  BorrarTemporal('tmp_coste_envasado');
  BorrarTemporal('tmp_categorias');
  BorrarTemporal('tmp_resum_liqui');
end;

procedure CrearTablasTemporales;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_resum_liqui ( ' +
            '  cod SMALLINT,nom CHAR(30), ' +
            '  kcos INTEGER, kapr INTEGER, kapr1 INTEGER, kapr2 INTEGER, kapr3 INTEGER, ' +
            '  brutofob DECIMAL(10,2),genv DECIMAL(10,2),netofob DECIMAL(10,2), ' +
            '  ggenv DECIMAL(10,2), gcom DECIMAL(10,2),gadm DECIMAL(10,2),' +
            '  neto DECIMAL(10,2) )');
    ExecSql;

    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_coste_envasado ( ');
    SQL.Add('    anyosemana char(6), ');
    SQL.Add('    categoria char(2), ');
    SQL.Add('    coste_envasado decimal(4,3) ');
    SQL.Add(' )');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_categorias ( ');
    SQL.Add('    cosechero integer, ');
    SQL.Add('    anyosemana char(6), ');
    SQL.Add('    kilos decimal(12,2), ');
    SQL.Add('    aprovecha decimal(6,3), ');
    SQL.Add('    aprovechados decimal(12,2), ');
    SQL.Add('    categoria char(2), ');
    SQL.Add('    porcentaje decimal(6,3), ');
    SQL.Add('    kilos_cat decimal(12,2) ');
    SQL.Add(' )');
    ExecSQL;
  end;
end;

function EstaAjustado( const AEmpresa, ACentro, AProducto: string;
                       const AFechaIni, AFechaFin: TDateTime; var AProductoCorte, AFechaCorte: string ): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_e, min(fecha_e) fecha from frf_escandallo ');
    SQL.Add(' where empresa_e = ' + QuotedStr( AEmpresa ) );
    SQL.Add('   and centro_e = ' + QuotedStr( ACentro ) );
    if AProducto <> '' then
      SQL.Add('   and producto_e = ' + QuotedStr( AProducto ) );
    SQL.Add('   and fecha_e between :fechaini and :fechafin ');
    SQL.Add('   and aporcen_primera_e + aporcen_segunda_e + aporcen_tercera_e + aporcen_destrio_e = 0 ' );
    SQL.Add(' group by 1 order by 2 asc ');
    ParamByName('fechaini').asDateTime:= AFechaIni;
    ParamByName('fechafin').asDateTime:= AFechaFin;
    Open;
    if IsEmpty then
    begin
      result:= true;
      Close;
    end
    else
    begin
      result:= false;
      AFechaCorte:= FieldByName('fecha').AsString;
      AProductoCorte:= FieldByName('producto_e').AsString;
      Close;
    end;
  end;
end;

function EstaEscandalloGrabado( const AEmpresa, ACentro, AProducto: string;
                                const AFechaIni, AFechaFin: TDateTime; var AFechaCorte: string ): boolean;
var
  //dFechaIni: TDateTime;
  iEntradas, iEscandallos: integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select count( * ) registros ');
    SQL.Add(' from frf_entradas2_l ');
    SQL.Add(' where empresa_e2l = ' + QuotedStr( AEmpresa ) );
    SQL.Add('   and centro_e2l = ' + QuotedStr( ACentro ) );
    if AProducto <> '' then
      SQL.Add('   and producto_e2l = ' + QuotedStr( AProducto ) )
    else
      SQL.Add('   and exists( select * from frf_productos where empresa_p = ' + QuotedStr( AEmpresa ) + ' and producto_p = producto_e2l and estomate_p = ''S'') ');
    SQL.Add('   and fecha_e2l between :fechaini and :fechafin ');
    SQL.Add('   and cosechero_e2l <> 0 ');
    ParamByName('fechaini').asDateTime:= AFechaIni;
    ParamByName('fechafin').asDateTime:= AFechaFin;
    Open;
    iEntradas:= FieldByName('registros').AsInteger;
    Close;

    if iEntradas = 0 then
    begin
      result:= False;
      AFechaCorte:= '';
      Exit;
    end;

    SQL.Clear;
    SQL.Add(' select count( * ) registros ');
    SQL.Add(' from frf_entradas2_l, frf_escandallo ');
    SQL.Add(' where empresa_e2l = ' + QuotedStr( AEmpresa ) );
    SQL.Add('   and centro_e2l = ' + QuotedStr( ACentro ) );

    if AProducto <> '' then
      SQL.Add('   and producto_e2l = ' + QuotedStr( AProducto ) )
    else
      SQL.Add('   and exists( select * from frf_productos where empresa_p = ' + QuotedStr( AEmpresa ) + ' and producto_p = producto_e2l and estomate_p = ''S'') ');

    SQL.Add('   and fecha_e2l between :fechaini and :fechafin ');
    SQL.Add('   and cosechero_e2l <> 0 ');
    SQL.Add('   and empresa_e = ' + QuotedStr( AEmpresa ) );
    SQL.Add('   and centro_e = ' + QuotedStr( ACentro ) );
    SQL.Add('   and numero_entrada_e = numero_entrada_e2l ');
    SQL.Add('   and fecha_e = fecha_e2l ');
    SQL.Add('   and producto_e = producto_e2l ');
    SQL.Add('   and cosechero_e = cosechero_e2l ');
    SQL.Add('   and plantacion_e = plantacion_e2l ');
    SQL.Add('   and anyo_semana_e = ano_sem_planta_e2l ');

    ParamByName('fechaini').asDateTime:= AFechaIni;
    ParamByName('fechafin').asDateTime:= AFechaFin;
    Open;
    iEscandallos:= FieldByName('registros').AsInteger;
    Close;
    result:= ( iEntradas = iEscandallos ) and ( iEntradas > 0 );

    if not result then
    begin
      SQL.Clear;
      SQL.Add(' select producto_e2l, min(fecha_e2l) fecha_e2l');
      SQL.Add(' from frf_entradas2_l ');
      SQL.Add(' where empresa_e2l = '+ QuotedStr( AEmpresa ) );
      SQL.Add('   and centro_e2l = ' + QuotedStr( ACentro ) );
      if AProducto <> '' then
        SQL.Add('   and producto_e2l = ' + QuotedStr( AProducto ) )
      else
        SQL.Add('   and exists( select * from frf_productos where empresa_p = ' + QuotedStr( AEmpresa ) + ' and producto_p = producto_e2l and estomate_p = ''S'') ');

      SQL.Add('   and fecha_e2l between :fechaini and :fechafin ');
      SQL.Add('   and cosechero_e2l <> 0 ');
      SQL.Add(' and not exists ');
      SQL.Add(' ( ');
      SQL.Add('   select * from frf_escandallo ');
      SQL.Add('   where empresa_e = empresa_e2l ');
      SQL.Add('   and centro_e = centro_e2l ');
      SQL.Add('   and numero_entrada_e = numero_entrada_e2l ');
      SQL.Add('   and fecha_e = fecha_e2l ');
      SQL.Add('   and producto_e = producto_e2l ');
      SQL.Add('   and cosechero_e = cosechero_e2l ');
      SQL.Add('   and plantacion_e = plantacion_e2l ');
      SQL.Add('   and anyo_semana_e = ano_sem_planta_e2l ');
      SQL.Add(' ) ');
      SQL.Add(' group by 1 ');
      SQL.Add(' order by 1 ');
      ParamByName('fechaini').asDateTime:= AFechaIni;
      ParamByName('fechafin').asDateTime:= AFechaFin;
      Open;

      AFechaCorte:= '';
      while not Eof do
      begin
        AFechaCorte:= AFechaCorte + #13 + #10 + 'Producto: ' + FieldByName('producto_e2l').AsString + ' Fecha: ' + FieldByName('fecha_e2l').AsString + ' Semana: ' + AnyoSemana(  FieldByName('fecha_e2l').AsDateTime );
        Next;
      end;
      Close;
    end;

  end;
end;

procedure CalcularFechaInicio(const AEmpresa, ACentro, AProducto, ACosechero,
  AFechaIni, AFechaFin: string; var ANuevaIni, ANuevaFin: string );
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    //***********************************************************************
    //Calcular salidas
    //***********************************************************************

    //Datos de salidas para el rango especificado
    SQL.Clear;
    SQl.add(' select MIN(fecha_e2l) fecha, MAX(fecha_e2l) fecha2' +
      ' from frf_entradas2_l, frf_cosecheros ' +
      ' where empresa_e2l=:empresa ' +
      ' and centro_e2l=:centro ' +
      ' and producto_e2l=:producto ' +
      ' and fecha_e2l between :inicio and :fin ');

    if trim(ACosechero) <> '' then
    begin
      SQl.add(' and cosechero_e2l= :cosechero ');
      ParamByName('cosechero').AsString := ACosechero;
    end
    else
      SQL.add(' and cosechero_e2l <> 0 ');

    SQl.add(' and empresa_e2l = empresa_c ');
    SQl.add(' and cosechero_e2l = cosechero_c ');
    SQl.add(' and pertenece_grupo_c = ''S'' ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := StrTOdate(AFechaIni);
    ParamByName('fin').AsDateTime := StrTOdate(AFechaFin);

    try
      Open;
    except
      ANuevaIni:= 'ERROR';
      ANuevaFin:= 'ERROR';
      Exit;
    end;

    if IsEmpty or ( FieldByName('fecha').AsString = '' ) then begin
      Close;
      ANuevaIni:= '';
      ANuevaFin:= '';
      Exit;
    end;

    //La fecha de inicio debe ser lunes
    ANuevaIni:= DateToStr( LunesAnterior( FieldByName('fecha').AsDateTime ) );

    //La fecha de fin debe ser domingo
    ANuevaFin:= DateToStr( DomingoSiguiente( FieldByName('fecha2').AsDateTime ) );

    Close;
  end
end;

procedure InsertarCosteEnvasado(const AAnyosemana, ACategoria: string;
  const AValor: real);
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' insert into tmp_coste_envasado values ');
    SQL.Add(' ( :anyosemana, :Categoria, :Valor ) ');
    ParamByName('anyosemana').AsString := AAnyosemana;
    if (ACategoria = '1') or (ACategoria = '2') or (ACategoria = '3') or (ACategoria = 'B') then
      ParamByName('Categoria').AsString := ACategoria
    else
      ParamByName('Categoria').AsString := '4';
    ParamByName('Valor').AsFloat := AValor;
    ExecQuery(DMAuxDB.QAux);
  end;
end;

(*3-1-2007*)
function CosteEnvase(const AAnyo, AMes, AEmpresa, ACentro, AEnvase, AProducto: string): Real;
begin
  Result:= 0;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select mes_ec, ( material_ec + coste_ec ) coste_ec from frf_env_costes ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_ec = :centro ');
    SQL.Add(' and envase_ec = :envase ');
    SQL.Add(' and anyo_ec = :anyo ');
    SQL.Add(' and mes_ec <= :mes ');
    SQL.Add(' and producto_base_ec = ');
    SQL.Add(' ( select producto_base_p from frf_productos ');
    SQL.Add('   where empresa_p = :empresa and producto_p = :producto ) ');
    SQL.Add(' order by mes_ec desc ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('envase').AsString := AEnvase;
    ParamByName('anyo').AsString := AAnyo;
    ParamByName('mes').AsString := AMes;
    ParamByName('producto').AsString := AProducto;
    Open;
    if not IsEmpty then
    begin
      result := FieldByName('coste_ec').AsFloat;
      Close;
    end
    else
    begin
      Close;
      SQL.Clear;
      SQL.Add(' select anyo_ec, mes_ec, ( material_ec + coste_ec ) coste_ec from frf_env_costes ');
      SQL.Add(' where empresa_ec = :empresa ');
      SQL.Add(' and envase_ec = :envase ');
      SQL.Add(' and ( anyo_ec < :anyo or ( anyo_ec = :anyo and mes_ec <= :mes ) )');
      SQL.Add(' and producto_base_ec = ');
      SQL.Add(' ( select producto_base_p from frf_productos ');
      SQL.Add('   where empresa_p = :empresa and producto_p = :producto ) ');
      SQL.Add(' order by anyo_ec, mes_ec desc, coste_ec desc');
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('envase').AsString := AEnvase;
      ParamByName('anyo').AsString := AAnyo;
      ParamByName('mes').AsString := AMes;
      ParamByName('producto').AsString := AProducto;

      Open;
      if not IsEmpty then
      begin
        result := FieldByName('coste_ec').AsFloat;
        Close;
      end;
    end;
  end;
end;

procedure CosteEnvasadoSemanal_(const AUsuario, AEmpresa, ACentroOrigen, AProducto, AAnyo, AMes, AAnyoSemana: string);
var
  categoria: string;
  kilos, importe, coste: real;
  //dFechaFin: TDate;
begin
  //dFechaFin:= AFechaIni + 6;
  BEMensajes('Calculando coste de envasado.');

  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;

    SQL.Add(' select case when tcategoria_sr not in (''1'',''2'',''3'') then ''4'' else tcategoria_sr end categoria, ');
    (*NUEVALIQUIDACION*)
    //SQL.Add('        ' + QuotedStr( ACentroOrigen ) + ' centro, ');
    SQL.Add('        tcentro_sr centro, ');
    (*
    if AAnyoSemana < '200849' then //< '29/9/2008'
    begin
      SQL.Add('        ' + QuotedStr( ACentroOrigen ) + ' centro, ');
    end
    else
    begin
      if ( AEmpresa = '050' ) and ( ACentroOrigen = '6' ) and ( AProducto = 'E' ) then
        SQL.Add('        tcentro_sr centro, ')
      else
        SQL.Add('        ' + QuotedStr( ACentroOrigen ) + ' centro, ');
    end;
    *)
    SQL.Add('        tenvase_sr envase, sum( tkilos_linea_sr ) kilos ');
    SQL.Add(' from tmp_sal_resumen');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tanyosemana_sr = :anyosemana ');
    SQL.Add(' group by 1,2,3 ');
    SQL.Add(' order by 1,2,3 ');
    ParamByName('usuario').AsString := AUsuario;
    ParamByName('anyosemana').AsString := AAnyoSemana;

    if bSQLUtils.OpenQuery(DMBaseDatos.QGeneral) then
    begin
      categoria := '';
      kilos := 0;
      importe := 0;
      while not Eof do
      begin
        if categoria = '' then
        begin
          //Inicializar variables
          kilos := 0;
          importe := 0;
          categoria := FieldByName('categoria').AsString;
          coste := CosteEnvase(Aanyo, Ames, AEmpresa, FieldByName('centro').AsString,
            FieldByName('envase').AsString, AProducto);
          if coste <> 0 then
          begin
            kilos := FieldByName('kilos').AsFloat;
            importe := FieldByName('kilos').AsFloat * coste;
          end;
        end
        else
          if categoria <> FieldByName('categoria').AsString then
          begin
          //Insertar datos
            if Kilos <> 0 then
              InsertarCosteEnvasado(AAnyoSemana, categoria, bRoundTo(Importe / Kilos, -4));
          //Inicializar variables
            kilos := 0;
            importe := 0;
            categoria := FieldByName('categoria').AsString;
            coste := CosteEnvase(AAnyo, AMes, AEmpresa, FieldByName('centro').AsString,
              FieldByName('envase').AsString, AProducto);
            if coste <> 0 then
            begin
              kilos := FieldByName('kilos').AsFloat;
              importe := FieldByName('kilos').AsFloat * coste;
            end;
          end
          else
          begin
            coste := CosteEnvase(Aanyo, Ames, AEmpresa, FieldByName('centro').AsString,
              FieldByName('envase').AsString, AProducto);
            if coste <> 0 then
            begin
              kilos := kilos + FieldByName('kilos').AsFloat;
              importe := importe + (FieldByName('kilos').AsFloat * coste);
            end;
          end;
        Next;
      end;
      if kilos <> 0 then
      begin
        //Insertar datos
        if Kilos <> 0 then
          InsertarCosteEnvasado(AAnyoSemana, categoria, bRoundTo(Importe / Kilos, -4));
      end;
    end;
  end;
  BEMensajes('');
end;



procedure CosteEnvasado(const AUsuario, AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate);
var
  dFechaGuia: TDate;
  anyo, mes, dia: Word;
begin
  dFechaGuia := AFechaIni;
  while dFechaGuia < AFechaFin do
  begin
    //if ( ACentro = '6' ) and ( dFechaGuia < StrToDate('1/6/2008') ) then
    //begin
      //
    //end
    //else
    begin
      DecodeDate(dFechaGuia, anyo, mes, dia);
      CosteEnvasadoSemanal_(AUsuario, AEmpresa, ACentro, AProducto, IntToStr(anyo), IntToStr(mes), ANyoSemana(dFechaGuia));
    end;
    dFechaGuia := dFechaGuia + 7;
  end;
end;


function GastosTransitos(const AEmpresa, ACentro, AAlbaran, AFecha: string): Real;
begin
  with DMBaseDatos.QAux do
  begin
    SQl.clear;
    SQl.add(' select sum(importe_g) ' +
      ' from frf_gastos, frf_tipo_gastos ' +
      ' where empresa_g = :empresa  ' +
      ' and fecha_g = :fecha ' +
      ' and centro_salida_g=:centro ' +
      ' and n_albaran_g=:albaran ' +
      ' and tipo_g = tipo_tg ' +
      (*#GASTO_TRANSITO#*)
      ' and gasto_transito_tg = 1 and gasto_transito_tg = 0 ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsString := AAlbaran;
    ParamByName('fecha').AsString := AFecha;

    try
      Open;
      result := Fields[0].AsFloat;
    finally
      Close;
    end;
  end;
end;

procedure ActualizarPrecioFOB(const AAnyoSemana: string; const AValue: Real);
begin
  with DMBaseDatos.QAux do
  begin
    SQl.clear;
    SQl.add(' update tmp_fob_aux  ' +
      ' set fob = fob + :value ' +
      ' where anyosemana= :anyosemana ');

    ParamByName('anyosemana').AsString := AAnyoSemana;
    ParamByName('value').AsFloat := AValue;

    try
      ExecSQL;
    except
    end;
  end;
end;

procedure QuitarGastosTransitosFOB(const AEmpresa, ACentro, AProducto: string;
  const inicio, fin: TDate);
var
  rAcumKilos, rAcumGastos: Real;
  rAcumKilosAux, rAcumGastosAux: Real;
  sAnyoSemana: string;
begin
  rAcumGastos := 0;
  rAcumKilos := 0;
  sAnyoSemana := AnyoSemana(inicio);

  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQl.clear;
    SQl.add(' select centro_salida_sl centro, fecha_sl fecha, ' +
      '        n_albaran_sl albaran, sum(kilos_sl) kilos' +
      ' from frf_salidas_l ' +
      ' where empresa_sl=:empresa  ' +
      ' and fecha_sl between :inicio and :fin ' +
      ' and centro_origen_sl=:centro ' +
      ' and producto_sl=:producto ' +
      ' group by centro_salida_sl, fecha_sl, n_albaran_sl ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := inicio;
    ParamByName('fin').AsDateTime := fin;

    try
      Open;
      while not EOF do
      begin
        rAcumGastosAux := GastosTransitos(AEmpresa, FieldByName('centro').AsString,
          FieldByName('albaran').AsString, FieldByName('fecha').AsString);
        rAcumKilosAux := FieldByName('kilos').AsInteger;

        rAcumGastos := rAcumGastos + rAcumGastosAux;
        rAcumKilos := rAcumKilos + rAcumKilosAux;
        Next;
      end;
    finally
      Close;
    end;
  end;

  ActualizarPrecioFOB(sAnyoSemana, -1 * bRoundTo(rAcumGastos / rAcumKilos, -4));
end;

procedure FaltaCatFOB(const AAnyoSemana, ACat: string);
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * from tmp_fob_aux ');
    SQL.Add('where anyosemana = :anyosemana ');
    SQL.Add('  and categoria = :categoria ');
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ParamByName('categoria').AsString := ACat;
    Open;
    if IsEmpty then
    begin
      Close;
      SQL.Clear;
      SQL.Add(' insert into tmp_fob_aux values');
      SQL.Add(' (:anyosemana,:categoria, 0) ');
      ParamByName('anyosemana').AsString := AAnyoSemana;
      ParamByName('categoria').AsString := ACat;
      ExecSQl;
    end;
    Close;
  end;
end;

procedure SemanaFOB(const AEmpresa, ACentro, AProducto: string;
  inicio, fin: TDate; anyosemana: string; primera: Boolean);
var
  tabla: string;
begin
  BEMensajes('Calculando FOB semana ' + Copy(anyosemana, 5, 2) + ' .');
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    //***********************************************************************
    //Gasto por kilos
    //***********************************************************************

    //Salidas que tienen lineas del centro deseado
    //y con producto deseado
    //y que tienen precio asignado
    //y que han sido facturadas
    SQl.clear;
    SQl.add(' select c.centro_salida_sc centro_m, c.fecha_sc fecha_m, ' +
      '        c.n_albaran_sc albaran_m ' +
      ' from frf_salidas_c c,frf_salidas_l l ' +

      ' where c.empresa_sc=:empresa  ' +
      ' and c.fecha_sc between :inicio and :fin ' +

      ' and c.empresa_sc=l.empresa_sl  ' +
      ' and c.centro_salida_sc=l.centro_salida_sl ' +
      ' and c.fecha_sc=l.fecha_sl ' +
      ' and c.n_albaran_sc=l.n_albaran_sl ' +

      //' and c.n_factura_sc is not null ' +
      
      ' and c.cliente_sal_sc not in ("0BO","RET","REA","EG") ' +
      ' and l.centro_origen_sl=:centro ' +
      ' and l.producto_sl=:producto ' +
      ' and l.precio_sl<>0 and l.precio_sl is not null ' +
      ' group by c.centro_salida_sc, c.fecha_sc, c.n_albaran_sc ' +
      ' into temp tmp_salidas_m ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := inicio;
    ParamByName('fin').AsDateTime := fin;
    ExecSql;

    //Totales de las salidas seleccionadas
    SQL.Clear;
    SQl.add(' select m.centro_m centro,m.fecha_m fecha, m.albaran_m albaran,' +
      '        SUM(l.kilos_sl) kilos, ' +
      '        SUM(l.cajas_sl) cajas, ' +
      '        SUM(l.n_palets_sl) palets, ' +
      '        SUM(NVL(liqImporteNeto(l.importe_neto_sl,l.empresa_sl,l.cliente_sl),0)) importe ' +
      ' from tmp_salidas_m m,frf_salidas_l l ' +
      ' where m.centro_m=l.centro_salida_sl ' +
      ' and m.fecha_m=l.fecha_sl  ' +
      ' and m.albaran_m=l.n_albaran_sl ' +
      ' and l.empresa_sl=:empresa ' +
      ' group by m.centro_m,m.fecha_m, m.albaran_m  ' +
      ' into temp tmp_salidas_d ');
    ParamByName('empresa').AsString := AEmpresa;
    ExecSql;

    //Gastos por unidad de facturacion de las salidas seleccionadas
    SQL.Clear;
    SQl.add(' select centro_m centro, fecha_m fecha, ' +
      '        albaran_m albaran ,unidad_dist_tg unidad, ' +
      '        SUM(NVL(importe_g,0)*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END) importe ' +
      ' from tmp_salidas_m,frf_gastos,frf_tipo_gastos ' +
      ' where empresa_g=:empresa and centro_m=centro_salida_g ' +
      ' and albaran_m=n_albaran_g and fecha_m=fecha_g ' +
            {No tenemos en cuenta los gastos de transitos, mas abajo ..}
      ' and tipo_g=tipo_tg ' +
      (*#GASTO_TRANSITO#*)
      //' and gasto_transito_tg = 0 ' +
      ' and (descontar_fob_tg="S" ' +
      '    OR  facturable_tg = ' + QuotedStr('S') + ') ' +
      ' group by centro_m,fecha_m,albaran_m,unidad_dist_tg ' +
      ' into temp tmp_gastos_unidad ');
    ParamByName('empresa').AsString := AEmpresa;
    ExecSql;
    SQL.Clear;
    SQl.add(' select g.centro,g.fecha,g.albaran,' +
      '        g.unidad,g.importe gasto, ' +
      '        s.kilos,s.palets,s.importe,s.cajas ' +
      ' from tmp_gastos_unidad g,tmp_salidas_d s' +
      ' where g.centro=s.centro and g.albaran=s.albaran and g.fecha=s.fecha ' +
      ' into temp tmp_salidas_gastos ');
    ExecSql;

    //Lineas salidas con precio del centro y producto que interesa
    SQl.clear;
    SQl.add(' select centro_salida_sl centro, fecha_sl fecha, ' +
      '        n_albaran_sl albaran,categoria_sl categoria, ' +
      '        SUM(kilos_sl) kilos, ' +
      '        SUM(cajas_sl) cajas, ' +
      '        SUM(n_palets_sl) palets, ' +
            {IMPORTE TOTAL'        SUM(importe_total_sl) importe '+}
            {IMPORTE NETO}'        SUM(NVL(liqImporteNeto(importe_neto_sl,empresa_sl,cliente_sl),0)) importe ' +
//Antes            {IMPORTE NETO}'        SUM(NVL(importe_neto_sl,0)) importe '+
      ' from  frf_salidas_l,frf_salidas_c  ' +
      ' where empresa_sl=:empresa  ' +
      ' and fecha_sl between :inicio and :fin ' +
      ' and centro_origen_sl=:centro ' +
      ' and producto_sl=:producto ' +
            {RETIRADA' and cliente_sl<>"RET" '+}
      ' and precio_sl<>0 and precio_sl is not null ' +
      ' and empresa_sc=empresa_sl  ' +
      ' and centro_salida_sc=centro_salida_sl ' +
      ' and fecha_sc=fecha_sl ' +
      ' and n_albaran_sc=n_albaran_sl ' +
      //      {FACTURADA}' and n_factura_sc is not null ' +
      ' group by centro_salida_sl, fecha_sl, n_albaran_sl, categoria_sl ' +
      ' into temp tmp_salidas ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := inicio;
    ParamByName('fin').AsDateTime := fin;
    ExecSql;

    //Si el producto es E y centro origen 6 restar los gastos de transitos
    (*
    if (ACentro='6') and (AProducto='E') then
    begin
      SQl.clear;
      SQl.add(' select centro_salida_sl centro, fecha_sl fecha, '+
            '        n_albaran_sl albaran, '+
            '        SUM(kilos_sl) kilos '+
            ' from  frf_salidas_l  '+
            ' where empresa_sl=:empresa  '+
            ' and fecha_sl between :inicio and :fin '+
            ' and centro_origen_sl=:centro '+
            ' and producto_sl=:producto '+
            {RETIRADA' and cliente_sl<>"RET" '+}
            ' group by centro_salida_sl, fecha_sl, n_albaran_sl '+
            ' into temp tmp_sal_tran ');
      ParamByName('empresa').AsString:=AEmpresa;
      ParamByName('centro').AsString:=ACentro;
      ParamByName('producto').AsString:=AProducto;
      ParamByName('inicio').AsDateTime:=inicio;
      ParamByName('fin').AsDateTime:=fin;
      ExecSql;

      SQL.Clear;
      SQL.Add(' select centro,fecha,albaran,kilos, '+
              '        NVL(importe_g,0)*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END gasto '+
              ' from tmp_sal_tran,frf_gastos, frf_tipo_gastos '+
              ' where empresa_g=:empresa '+
              '   and centro=centro_salida_g '+
              '   and fecha=fecha_g '+
              '   and albaran=n_albaran_g '+
              '   and gasto_transito_tg = 1 '+
              '   and tipo_g=tipo_tg '+
              '   and (descontar_fob_tg="S" '+
              '    OR  facturable_tg = '+QuotedStr('S')+') '+
              ' into temp tmp_gas_tran ');
      ParamByName('empresa').AsString:=AEmpresa;
      ExecSql;

      SQL.Clear;
      SQL.Add(' select s.centro,s.fecha,s.albaran,s.categoria, '+
              '        s.kilos,s.cajas,s.palets,s.importe, '+
              '        ROUND((s.kilos*g.gasto)/g.kilos,2) gasto'+
              ' from tmp_salidas s,OUTER tmp_gas_tran g '+
              ' where s.centro=g.centro '+
              '   and s.fecha=g.fecha '+
              '   and s.albaran=g.albaran '+
              ' into temp tmp_gastos_tran ');
      ExecSQL;

      SQL.clear;
      SQL.Add(' update tmp_gastos_tran set importe=importe-gasto '+
              ' where gasto is not null ');
      ExecSQL;

      tabla:='tmp_gastos_tran';
    end
    else
    *)
    begin
      tabla := 'tmp_salidas';
    end;


    //Producto cartesiano salidas-gastos por kilos
    SQl.clear;
    SQl.add(' select s.centro, s.fecha, s.albaran, s.categoria,  ' +
      '        s.kilos,s.cajas, s.palets, s.importe, ' +
      '        NVL(ROUND((s.kilos*g.gasto)/g.kilos,2),0) gasto ' +
      ' from  ' + tabla + ' s, OUTER tmp_salidas_gastos g ' +
      ' where s.centro=g.centro ' +
      '   and s.fecha=g.fecha ' +
      '   and s.albaran=g.albaran ' +
      '   and g.unidad="KILOS" ' +
      ' into temp tmp_sal_kilos ');
    ExecSQL;

    SQL.clear;
    SQL.Add(' delete from tmp_salidas_gastos where unidad="KILOS" ');
    ExecSQL;
    SQL.clear;
    SQL.Add(' update tmp_sal_kilos set importe=importe-gasto ' +
      ' where gasto is not null ');
    ExecSQL;

    //Producto cartesiano salidas-gastos por palets
    SQl.clear;
    SQl.add(' (select s.centro, s.fecha, s.albaran, s.categoria, s.cajas, s.importe, ' +
      '        s.kilos,ROUND((s.palets*g.gasto)/g.palets,2) gasto ' +
      ' from  tmp_sal_kilos s, OUTER tmp_salidas_gastos g ' +
      ' where s.centro=g.centro ' +
      '   and s.fecha=g.fecha ' +
      '   and s.albaran=g.albaran ' +
      '   and g.unidad="PALETS" ' +
      '   and s.palets>0 ' +
      ' UNION ' +
      ' select s.centro, s.fecha, s.albaran, s.categoria, s.cajas, s.importe, ' +
      '        s.kilos,ROUND((s.cajas*g.gasto)/g.cajas,2) gasto ' +
      ' from  tmp_sal_kilos s, OUTER tmp_salidas_gastos g ' +
      ' where s.centro=g.centro ' +
      '   and s.fecha=g.fecha ' +
      '   and s.albaran=g.albaran ' +
      '   and g.unidad="PALETS" ' +
      '   and (s.palets<=0  or s.palets is null)) ' +
      ' into temp tmp_sal_palets ');
    ExecSQL;

    SQL.clear;
    SQL.Add(' delete from tmp_salidas_gastos where unidad="PALETS" ');
    ExecSQL;
    SQL.clear;
    SQL.Add(' update tmp_sal_palets set importe=importe-gasto ' +
      ' where gasto is not null ');
    ExecSQL;

    //Producto cartesiano salidas-gastos por cajas
    SQl.clear;
    SQl.add(' select s.centro, s.fecha, s.albaran, s.categoria, s.importe, ' +
      '        s.kilos,ROUND((s.cajas*g.gasto)/g.cajas,2) gasto ' +
      ' from  tmp_sal_palets s, OUTER tmp_salidas_gastos g ' +
      ' where s.centro=g.centro ' +
      '   and s.fecha=g.fecha ' +
      '   and s.albaran=g.albaran ' +
      '   and g.unidad="CAJAS" ' +
      ' into temp tmp_sal_cajas ');
    ExecSQL;

    SQL.clear;
    SQL.Add(' delete from tmp_salidas_gastos where unidad="CAJAS" ');
    ExecSQL;
    SQL.clear;
    SQL.Add(' update tmp_sal_cajas set importe=importe-gasto ' +
      ' where gasto is not null ');
    ExecSQL;

    //Producto cartesiano salidas-gastos por importe
    SQl.clear;
    SQl.add(' select s.centro, s.fecha, s.albaran, s.categoria, s.importe, ' +
      '        s.kilos,ROUND((s.importe*g.gasto)/g.importe,2) gasto ' +
      ' from  tmp_sal_cajas s,OUTER tmp_salidas_gastos g ' +
      ' where s.centro=g.centro ' +
      '   and s.fecha=g.fecha ' +
      '   and s.albaran=g.albaran ' +
      '   and g.unidad="IMPORTE" ' +
      ' into temp tmp_sal_import ');
    ExecSQL;

    SQL.clear;
    SQL.Add(' update tmp_sal_import set importe=importe-gasto ' +
      ' where gasto is not null ');
    ExecSQL;

    //Asociamos a la moneda y numero de factura
    SQL.Clear;
    SQL.Add(' select categoria, ' +

      '    SUM(   case when ' +
      '        then liqImporteEuros(importe,moneda_sc,n_factura_sc,fecha_factura_sc,empresa_sc) ' +
      '        else euros(moneda_sc,fecha_factura_sc,importe) end ) importe,' +

      '    SUM(kilos) kilos ' +
      ' from  tmp_sal_import,frf_salidas_c ' +
      ' where empresa_sc=:empresa ' +
      '   and centro=centro_salida_sc ' +
      '   and fecha=fecha_sc ' +
      '   and albaran=n_albaran_sc ' +
      ' GROUP BY 1 ' +
      ' into temp tmp_fob_sem ');
    ParamByName('empresa').AsString := AEmpresa;
    ExecSQL;

    if primera then
    begin
      SQL.Clear;
      SQL.Add(' select ' + anyosemana + ' anyosemana, ' +
        '         case when categoria not in (''1'',''2'',''3'',''B'') then ''4'' else categoria end categoria, ' +
        ' ROUND(SUM(importe)/SUM(kilos),3) as fob ' +
        ' from tmp_fob_sem ' +
        ' group by categoria into temp tmp_fob_aux');
      ExecSQl;
    end
    else
    begin
      SQL.Clear;
      SQL.Add(' insert into tmp_fob_aux ' +
        ' select ' + anyosemana + ' anyosemana, ' +
        '         case when categoria not in (''1'',''2'',''3'',''B'') then ''4'' else categoria end categoria, ' +
        ' ROUND(SUM(importe)/SUM(kilos),3) as fob ' +
        ' from tmp_fob_sem group by categoria ');
      ExecSQl;
    end;

    BEMensajes('');
  end;
  //Para que no quede ninguna categoria sin valor
  FaltaCatFOB(anyoSemana, '1');
  FaltaCatFOB(anyoSemana, '2');
  FaltaCatFOB(anyoSemana, '3');
  FaltaCatFOB(anyoSemana, '4');
end;

procedure NuevoFOB(const AAnyoSemana, ACat: string;
  const AValue: Real);
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('update tmp_fob ');
    SQL.Add('set fob_real = :value, ');
    SQL.Add('    fob = :value + coste_envasado ');
    SQL.Add('where anyosemana = :anyosemana ');
    SQL.Add('  and categoria = :categoria ');
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ParamByName('categoria').AsString := ACat;
    ParamByName('value').AsFloat := AValue;
    ExecSQL;
  end;
end;

procedure CambiosPorCodigo(const AEmpresa, ACentro, AProducto: string);
begin
  if (AEmpresa = '050') and (ACentro = '6') and (AProducto = 'E') then
  begin
    NuevoFOB('200441', '2', 0.270);
    NuevoFOB('200442', '2', 0.271);
  end;
end;

procedure FOBaCero(const AAnyoSemana, ACat: string);
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('update tmp_fob_aux ');
    SQL.Add('set fob = 0 ');
    SQL.Add('where anyosemana = :anyosemana ');
    SQL.Add('  and categoria = :categoria ');
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ParamByName('categoria').AsString := ACat;
    ExecSQL;
  end;
end;

procedure LimpiarCategoriaDestrio;
begin
  //Primera semana
  with DMBaseDatos.QTemp do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.clear;
    SQl.Add(' select unique anyosemana from tmp_categorias order by anyosemana');
    open;

    First;
    while not eof do
    begin
      FOBaCero(Fields[0].AsString, '4');
      Next;
    end;
    Close;
  end;
end;

procedure NuevoCalcularFOB(const AUsuario, AEmpresa, ACentro, AProducto, AFechaInicio, AFechaFin: string;
  const AAbonos: Boolean);
(*var
  registros: integer;*)
begin
  TablaTmpFob.Inicializar;
  //Factuarado
  //TablaTmpFob.Configurar(true, true, true, true);
  //Valorado
  TablaTmpFob.Configurar(true, False, true, true);
  //registros:=
  TablaTmpFob.Ejecutar(AUsuario, AEmpresa, ACentro, AProducto, AFechaInicio, AFechaFin);
(*  case registros of
     0 :Informar('Sin datos');
     -1:Informar('Sin Inicializar');
     -2:Informar('Sin Configurar');
     -3:Informar('ERROR');
  end;
*)
  TablaTmpFob.Finalizar;

  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tcategoria_sr = ''4'' ');
    SQL.Add(' where tcategoria_sr = ''2B'' or tcategoria_sr = ''3B'' ');
    SQL.Add(' and tusuario_sr = :usuario ');
    ParamByName('usuario').AsString := gsCodigo;
    ExecSQL;

    SQL.Clear;
    SQL.Add(' select  tanyosemana_sr anyosemana, tcategoria_sr categoria, ');
    SQL.Add('       ROUND( ( SUM( ROUND( timporte_linea_sr * tcambio_sr, 2) )  - ');
    SQL.Add('       SUM( ROUND( tcambio_sr * ( tgasto_linea_sr + tgasto_tenerife_sr + tdescuento_linea_sr + tcomision_linea_sr ), 2) ) ) ');
    SQL.Add('       / SUM( tkilos_linea_sr ), 3 ) fob ');
    SQL.Add('from tmp_sal_resumen ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add('group by 1, 2 ');
    SQL.Add('having SUM( tkilos_linea_sr ) <> 0 ');
    SQL.Add('into temp tmp_fob_aux ');
    ParamByName('usuario').AsString := gsCodigo;
    ExecSQL;


    //Borramos botado
    SQL.Clear;
    SQL.Add(' delete from tmp_fob_aux ');
    SQL.Add(' where categoria = ''B'' ');
    ExecSQL;

    //El destrio se paga directamente al proveedor, no tenemos que volver a pagar nosotros
    SQL.Clear;
    SQL.Add(' update tmp_fob_aux ');
    SQL.Add(' set fob = 0 ');
    SQL.Add(' where categoria = ''4'' ');
    ExecSQL;
  end;

  with DMBaseDatos.QTemp do
  begin
    //INSERTAR FOB A CERO POR SI
    SQL.clear;
    SQL.Add(' select unique anyosemana, categoria from tmp_categorias ');
    open;
    while not EOF do
    begin
      FaltaCatFOB(Fields[0].asstring, Fields[1].asstring);
      Next;
    end;
    Close;
  end;

  (*MODIF Liquidacion 3-1-2007*)
  //if not ((AProducto = 'E') and (ACentro = '6')) then
  //if not (ACentro = '6') then
  if bCosteEnvasado then
    CosteEnvasado(gsCodigo, AEmpresa, ACentro, AProducto, StrToDate(AFechaInicio), StrToDate(AFechaFin));
  with DMBaseDatos.QAux do
  begin
    //Sólo el comun
    if AAbonos then
      AnyadirAbonos(AUsuario, AEmpresa, ACentro, AProducto, '', AFechaInicio, AFechaFin);
    //Unir precio FOB con gasto de envasado
    SQL.clear;
    SQL.Add(' select f.anyosemana, ' +
      '        f.categoria, ' +
      '        f.fob, ' +
      '        NVL( c.coste_envasado, 0 ) coste_envasado, ' +
      '        f.fob - NVL( c.coste_envasado, 0 ) fob_real ' +
      ' from tmp_fob_aux f, OUTER tmp_coste_envasado c' +
      ' where f.anyosemana=c.anyosemana ' +
      '   and f.categoria=c.categoria ' +
      ' into temp tmp_fob ');
    ExecSQL;
    SQL.Clear;
  end;


  with DMBaseDatos.QAux do
  begin
    if  ( ACentro = '6' ) and ( AProducto = 'E' ) then
    begin
      SQL.clear;
      SQL.Add(' update tmp_fob  ');
      SQL.Add(' set fob= 1.187,  ');
      SQL.Add('     coste_envasado= 0,  ');
      SQL.Add('     fob_real=0  ');
      SQL.Add(' where anyosemana = ''200742''  ');
      SQL.Add(' and categoria = ''1''  ');
      ExecSQL;

      SQL.clear;
      SQL.Add(' update tmp_fob  ');
      SQL.Add(' set fob= 0.875,  ');
      SQL.Add('     coste_envasado= 0,  ');
      SQL.Add('     fob_real=0  ');
      SQL.Add(' where anyosemana = ''200742''  ');
      SQL.Add(' and categoria = ''2''  ');
      ExecSQL;
    end;

    if  ( ACentro = '6' ) and ( AProducto = 'Q' ) then
    begin
      SQL.clear;
      SQL.Add(' update tmp_fob  ');
      SQL.Add(' set fob= 1.462,  ');
      SQL.Add('     coste_envasado= 0,  ');
      SQL.Add('     fob_real=0  ');
      SQL.Add(' where anyosemana = ''200746''  ');
      SQL.Add(' and categoria = ''1''  ');
      ExecSQL;

      SQL.clear;
      SQL.Add(' update tmp_fob  ');
      SQL.Add(' set fob= 1.36,  ');
      SQL.Add('     coste_envasado= 0.070,  ');
      SQL.Add('     fob_real= 1.29  ');
      SQL.Add(' where anyosemana = ''201025''  ');
      SQL.Add(' and categoria = ''1''  ');
      ExecSQL;
    end;

    if  ( ACentro = '6' ) and ( AProducto = 'C' ) then
    begin
      SQL.clear;
      SQL.Add(' update tmp_fob  ');
      SQL.Add(' set fob=  2.620, ');
      SQL.Add('     coste_envasado= 0.298,  ');
      SQL.Add('     fob_real=2.322  ');
      SQL.Add(' where anyosemana = ''200824''  ');
      SQL.Add(' and categoria = ''1''  ');
      SQL.clear;
      SQL.Add(' update tmp_fob  ');
      SQL.Add(' set fob=  2.380, ');
      SQL.Add('     coste_envasado= 0.260,  ');
      SQL.Add('     fob_real=2.12  ');
      SQL.Add(' where anyosemana = ''201019''  ');
      SQL.Add(' and categoria = ''1''  ');
      ExecSQL;
    end;

    if  ( ACentro = '6' ) and ( AProducto = 'F' ) then
    begin
      SQL.clear;
      SQL.Add(' update tmp_fob  ');
      SQL.Add(' set fob=  2.832, ');
      SQL.Add('     coste_envasado= 0.315,  ');
      SQL.Add('     fob_real=2.517  ');
      SQL.Add(' where anyosemana = ''200823''  ');
      SQL.Add(' and categoria = ''1''  ');
      ExecSQL;
    end;

    SQL.Clear;
  end;


  //AJUSTES FOB
  //CostesDeEnvasado( AEmpresa, ACentro, AProducto, AFechaInicio );
  //AjusteCosecheroFob( AEmpresa );
  //AjusteCosFob( AEmpresa, AProducto );
end;

procedure CalcularFOB(const AEmpresa, ACentro, AProducto, AFechaIni: string);
var
  fecha: TDate;
  primera: boolean;
   //aux: string;
begin
  //Primera semana
  with DMBaseDatos.QListado do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    //fecha:=StrTodate(AFechaIni);

    SQL.clear;
    SQl.Add(' select unique anyosemana from tmp_categorias order by anyosemana');
    open;

    First;
    primera := True;
    while not eof do
    begin
      try
        fecha := LunesAnyoSemana(Fields[0].AsString);
        SemanaFOB(AEmpresa, ACentro, AProducto, fecha, fecha + 6, Fields[0].AsString, primera);
        if (ACentro = '6') and (AProducto = 'E') then
          QuitarGastosTransitosFOB(AEmpresa, ACentro, AProducto, fecha, fecha + 6);
        //El destrio se paga directamente al proveedor, no tenemos que volver a pagar nosotros
        LimpiarCategoriaDestrio;
      finally
        BorrarTemporal('tmp_salidas_m ');
        BorrarTemporal('tmp_salidas_d ');
        BorrarTemporal('tmp_gastos_unidad ');
        BorrarTemporal('tmp_salidas_gastos ');
        BorrarTemporal('tmp_salidas ');
        if AProducto = 'E' then
        begin
          BorrarTemporal('tmp_sal_tran ');
          BorrarTemporal('tmp_gas_tran ');
          BorrarTemporal('tmp_gastos_tran ');
        end;
        BorrarTemporal('tmp_sal_kilos');
        BorrarTemporal('tmp_sal_palets');
        BorrarTemporal('tmp_sal_cajas');
        BorrarTemporal('tmp_sal_import');
        BorrarTemporal('tmp_fob_sem ');
      end;
      primera := false;
      next;
    end;
    Cancel;
    Close;

    //Borramos Botado
    SQL.clear;
    SQL.Add(' delete from tmp_fob_aux ');
    SQL.Add(' where categoria= ''B'' ');

    ExecSQL;

    //Unir precio FOB con gasto de envasado
    SQL.clear;
    SQL.Add(' select f.anyosemana, ' +
      '        f.categoria, ' +
      '        f.fob, ' +
      '        NVL( c.coste_envasado, 0 ) coste_envasado, ' +
      '        f.fob - NVL( c.coste_envasado, 0 ) fob_real ' +
      ' from tmp_fob_aux f, OUTER tmp_coste_envasado c' +
      ' where f.anyosemana=c.anyosemana ' +
      '   and f.categoria=c.categoria ' +
      ' into temp tmp_fob ');
    ExecSQL;
    SQL.Clear;
  end;
  //Cambios que meto porque quiero
  CambiosPorCodigo(AEmpresa, ACentro, AProducto);
  //El destrio no tiene precio
  //LimpiarCategoriaDestrio;
end;

procedure PreparaLiquidacion(const AEmpresa, ACentro, AProducto, ACosechero,
  AFechaIni, AFechaFin, ACosteComercial,
  ACosteProduccion, ACosteAdministrativo: string);
begin
  with DMAUxDB.QAux do
  begin
    SQL.Clear;
    SQl.Add(' delete from tmp_resum_liqui');
    ExecSQL;
  end;

  QRLiquidacionCosecheros := TQRLiquidacionCosecheros.Create(Application);

  PonLogoGrupoBonnysa(QRLiquidacionCosecheros, AEmpresa);
  with QRLiquidacionCosecheros.QCosecheros do
  begin
    Cancel;
    Close;
    SQL.Clear;
    SQl.add(' select unique cosechero,nombre_c' +
      ' from tmp_categorias,frf_cosecheros ' +
      ' where empresa_c=:empresa ');

    if trim(ACosechero) <> '' then
    begin
      SQL.Add(' and cosechero_c = ' + ACosechero);
    end;

    SQl.add('   and cosechero_c=cosechero' +
      ' order by cosechero ');
    ParamByName('empresa').AsString := AEmpresa;
    Open;
  end;

  with DMAUxDB.QAux do
  begin
    SQL.Clear;
    SQl.Add(' insert into tmp_resum_liqui (cod,nom) ' +
      ' select unique cosechero,nombre_c' +
      ' from tmp_categorias,frf_cosecheros ' +
      ' where empresa_c=:empresa ' +
      '   and cosechero_c=cosechero');
    if trim(ACosechero) <> '' then
    begin
      SQL.Add(' and cosechero_c = ' + ACosechero);
    end;
    ParamByName('empresa').AsString := AEmpresa;
    ExecSQL;
  end;

  with QRLiquidacionCosecheros.QKGSCosechados do
  begin
    Cancel;
    Close;
    SQL.Clear;
    SQl.add(' select anyosemana semana, kilos, aprovecha, aprovechados, ' +
      '        categoria, porcentaje, kilos_cat ' +
      ' from tmp_categorias ' +
      ' where cosechero=:cosechero ' +
      ' and kilos_cat <> 0 ' +
      ' order by anyosemana,categoria ');
    Open;
  end;

  with QRLiquidacionCosecheros.QFOB do
  begin
    Cancel;
    Close;
    SQL.Clear;
    SQl.add(' select fob,coste_envasado,fob_real ' +
      ' from tmp_fob ' +
      ' where anyosemana=:semana ' +
      '   and categoria=:categoria ');
    Open;
  end;

  with QRLiquidacionCosecheros do
  begin
    empresa := AEmpresa;
    //Centro
    codCentro.Caption := ACentro;
    NomCentro.Caption := DesCentro(AEmpresa, ACentro);
    //Producto
    codProducto.Caption := AProducto;
    nomProducto.Caption := DesProducto(AEmpresa, AProducto);
    //Periodo
    periodo.Caption := 'Desde ' + AfechaIni + ' hasta ' + AfechaFin;
    //Costes
    rComercial := StrToFloat(ACosteComercial);
    rAdministrativo := StrToFloat(ACosteAdministrativo);
    rProduccion := StrToFloat(ACosteProduccion);
  end;
end;

end.

