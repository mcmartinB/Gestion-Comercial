(*AQUI*)
unit ULiquidaCosecheroPeriodoCosteEnv;

interface

type
  RCosteEnvasado = record
    CostePrimera: Real;
    CosteSegunda: Real;
    CosteTercera: Real;
    CosteResto: Real;
  end;

function GetCosteMensualEnvasado(const AEmpresa, ACentro, AProductor, AProducto: String;
                                 const ALunes: TDateTime): RCosteEnvasado;

procedure CrearTablaTemporal;
procedure CerrarTablaTemporal;

implementation

uses UDMAuxDB, UDMBaseDatos, DBTables, SysUtils, DB, Dialogs, bTimeUtils,
     bMath, CVariables, kbmMemTable, Variants;

var
  mtCosteSecciones: TkbmMemTable;

function GetAnyoMes(const AEmpresa, ACentro: string;
  var AProductor: string; const AProducto: string;
  const ATipo: Integer; AAnyoMes: string = ''): string;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select distinct anyo_mes_epc ');
    SQL.Add(' from frf_env_pcostes ');
    SQL.Add(' where empresa_epc = :empresa ');
    SQL.Add(' and centro_epc = :centro ');
    if AAnyoMes <> '' then
      SQL.Add(' and anyo_mes_epc <= :anyo_mes ');
    SQL.Add(' and productor_epc = :productor ');
    SQL.Add(' and producto_epc = :producto ');
    SQL.Add(' and tipo_entrada_epc = :tipo ');
    SQL.Add(' order by anyo_mes_epc desc ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    if AAnyoMes <> '' then
      ParamByName('anyo_mes').AsString := AAnyoMes;
    try
      ParamByName('productor').AsInteger := StrToInt(AProductor);
    except
      ParamByName('productor').AsInteger := 0;
    end;
    ParamByName('producto').AsString := AProducto;
    (*TODO*)
    if ( AAnyoMes <> '' ) and ( AAnyoMes <= '201003' ) then
    begin
      ParamByName('tipo').AsInteger := ATipo;
    end
    else
    begin
      if ATipo < 3 then
        ParamByName('tipo').AsInteger := ATipo
      else
        ParamByName('tipo').AsInteger := 0;
    end;

    try
      Open;
      if IsEmpty and (ParamByName('productor').AsInteger <> 0) then
      begin
        Close;
        ParamByName('productor').AsInteger := 0;
        Open;
      end;
      AProductor := ParamByName('productor').AsString;
      result := Fields[0].AsString;
    finally
      Close;
    end;
  end;
end;

function GetAplicacion(const ATipo: string; var ACentroTransito: string): string;
begin
(*
  if ATipo = 'S01' then result:= '1111'
  else if ATipo = 'S02' then result:= '1111'
  else if ATipo = 'S03' then result:= '1111'
  else if ATipo = 'S04' then result:= '1100'
  else if ATipo = 'S05' then result:= '1111'
  else if ATipo = 'S06' then result:= '1100'
  else if ATipo = 'S07' then result:= '1100'
  else if ATipo = 'S08' then result:= '1100'
  else if ATipo = 'S09' then result:= '0010'
  else if ATipo = 'S10' then result:= '0001'
  else if ATipo = 'S20' then result:= '1100'
  else if ATipo = 'S21' then result:= '1100'
*)
  result := '0000';
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select aplic_primera_etc, aplic_segunda_etc ');
    SQL.Add('        ,aplic_tercera_etc, aplic_destrio_etc  ');
    SQL.Add('        ,centro_paso_etc ' );
    SQL.Add(' from frf_env_tcostes ');
    SQL.Add(' where env_tcoste_etc = :tipo ');

    ParamByName('tipo').AsString := ATipo;

    try
      Open;
      if fields[0].AsInteger <> 0 then result[1] := '1';
      if fields[1].AsInteger <> 0 then result[2] := '1';
      if fields[2].AsInteger <> 0 then result[3] := '1';
      if fields[3].AsInteger <> 0 then result[4] := '1';
      ACentroTransito:= fields[4].AsString;
    finally
      Close;
    end;
  end;
end;

function GetAnyoMesCosteMensual(const AEmpresa, ACentro, AAnyoMes, ATipo: string): string;
begin
  result := '';
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select MAX (anyo_mes_emc ) ');
    SQL.Add(' from frf_env_mcostes ');
    SQL.Add(' where  empresa_emc = :empresa ');
    SQL.Add(' and centro_emc = :centro ');
    SQL.Add(' and anyo_mes_emc <= :anyo_mes ');
    SQL.Add(' and env_tcoste_emc = :tipo ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('anyo_mes').AsString := AAnyoMes;
    ParamByName('tipo').AsString := ATipo;

    try
      Open;
      result := fields[0].Asstring;
    finally
      Close;
    end;
  end;
end;

function GetCosteEnvase(const AEmpresa, ACentro, AAnyoMes, ATipo: string ): real;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select NVL(coste_kg_emc, 0) ');
    SQL.Add(' from frf_env_mcostes ');
    SQL.Add(' where  empresa_emc = :empresa ');
    SQL.Add(' and centro_emc = :centro ');
    SQL.Add(' and anyo_mes_emc = :anyo_mes ');
    SQL.Add(' and env_tcoste_emc = :tipo ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('anyo_mes').AsString := AAnyoMes;
    ParamByName('tipo').AsString := ATipo;

    try
      Open;
      result := fields[0].AsFloat;
    finally
      Close;
    end;
  end;
end;

(*
function CosteSeleccionado( const AEmpresa, ACentro, AAnyoMes: string ): real;
begin
  result:= GetCosteEnvase( AEmpresa, ACentro, AAnyoMes, 'S08' );
  result:= result + GetCosteEnvase( AEmpresa, ACentro, AAnyoMes, 'S20' );
end;
*)

function CosteManipulacionTransito( const AEmpesa, ACentro, ACentroTransito, AProducto: string;
                                    const ALunes: TDateTime; const ACoste: real; const AApli: String ): real;
var
  rKilos, rImporte: Real;
begin
  with DMBaseDatos.QAux do
  begin
    //KILOS TRANSITO
    SQL.Clear;
    SQL.Add( 'select sum( case when categoria_tl = ''1'' then kilos_tl else 0 end)  kilos_primera, ');
    SQL.Add( '       sum( case when categoria_tl = ''2'' then kilos_tl else 0 end)  kilos_segunda, ');
    SQL.Add( '       sum( case when categoria_tl = ''3'' then kilos_tl else 0 end)  kilos_tercera, ');
    SQL.Add( '       sum( case when categoria_tl not in ( ''1'', ''2'', ''3'' ) then kilos_tl else 0 end)  kilos_otros ');
    //SQL.Add( 'select sum(kilos_tl) kilos ');
    SQL.Add( 'from frf_transitos_l ');
    SQL.Add( 'where empresa_tl = :empresa ');
    SQL.Add( 'and centro_origen_tl = :origen ');
    SQL.Add( 'and centro_destino_tl = :destino ');
    SQL.Add( 'and fecha_tl between :lunes and :domingo ');
    SQL.Add( 'and producto_tl = :producto ');
    ParamByName('empresa').AsString:= AEmpesa;
    ParamByName('origen').AsString:= ACentro;
    ParamByName('destino').AsString:= ACentroTransito;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('lunes').AsDate:= ALunes;
    ParamByName('domingo').AsDate:= ALunes + 6;
    Open;
    rKilos:= 0;
    if not isempty then
    begin
      if copy(AApli, 1, 1) = '1' then
       rKilos:= rKilos + Fields[0].AsFloat;
      if copy(AApli, 2, 1) = '1' then
        rKilos:= rKilos + Fields[1].AsFloat;
      if copy(AApli, 3, 1) = '1' then
        rKilos:= rKilos + Fields[2].AsFloat;
      if copy(AApli, 4, 1) = '1' then
        rKilos:= rKilos + Fields[3].AsFloat;
    end;
    rImporte:= ACoste * rKilos;
    Close;

    //KILOS TOTAL (TRANSITOS + SALIDAS)
    if rImporte <> 0 then
    begin
      SQL.Clear;
      SQL.Add( 'select sum( case when tcategoria_sr = ''1'' then tkilos_linea_sr else 0 end)  kilos_primera, ');
      SQL.Add( '       sum( case when tcategoria_sr = ''2'' then tkilos_linea_sr else 0 end)  kilos_segunda, ');
      SQL.Add( '       sum( case when tcategoria_sr = ''3'' then tkilos_linea_sr else 0 end)  kilos_tercera, ');
      SQL.Add( '       sum( case when tcategoria_sr not in ( ''1'', ''2'', ''3'' ) then tkilos_linea_sr else 0 end)  kilos_otro ');
      //SQL.Add( 'select sum( tkilos_linea_sr )  kilos ');
      SQL.Add( 'from tmp_sal_resumen ');
      SQL.Add( 'where tusuario_sr = :usuario ');
      SQL.Add( 'and tempresa_sr = :empresa ');

      //Hasta el '29/9/2008' se estaba haciendo mal, tcentro_sr es el centro de salida, el centro de origen es el
      //mismo para todos los registros de la tabla.
      if ALunes < StrToDate( '29/9/2008') then
        SQL.Add( 'and tcentro_sr = :origen ');

      SQL.Add( 'and tproducto_sr = :producto ');
      SQL.Add( 'and tfecha_salida_sr between :lunes and :domingo ');
      ParamByName('usuario').AsString:= gsCodigo;
      ParamByName('empresa').AsString:= AEmpesa;

      if ALunes < StrToDate( '29/9/2008') then
        ParamByName('origen').AsString:= ACentro;

      ParamByName('producto').AsString:= AProducto;
      ParamByName('lunes').AsDate:= ALunes;
      ParamByName('domingo').AsDate:= ALunes + 6;
      Open;
      rKilos:= 0;
      if copy(AApli, 1, 1) = '1' then rKilos:= rKilos + Fields[0].AsFloat;
      if copy(AApli, 2, 1) = '1' then rKilos:= rKilos + Fields[1].AsFloat;
      if copy(AApli, 3, 1) = '1' then rKilos:= rKilos + Fields[2].AsFloat;
      if copy(AApli, 4, 1) = '1' then rKilos:= rKilos + Fields[3].AsFloat;
      if rKilos <> 0 then
        result:= bRoundTo( rImporte / rKilos, -5 )
      else
        result:= 0;
      Close;
    end
    else
    begin
      result:= 0;
    end;
  end;
end;


procedure CrearTablaTemporal;
begin
  if mtCosteSecciones = nil then
  begin
    mtCosteSecciones:= TkbmMemTable.Create( nil );
    with mtCosteSecciones do
    begin
      FieldDefs.Clear;

      FieldDefs.Add('empresa', ftString, 3, False);
      FieldDefs.Add('centro', ftString, 1, False);
      FieldDefs.Add('cosechero', ftString, 3, False);
      FieldDefs.Add('producto', ftString, 3, False);
      FieldDefs.Add('lunes', ftDateTime, 0, False);
      FieldDefs.Add('primera', ftFloat, 0, False);
      FieldDefs.Add('segunda', ftFloat, 0, False);
      FieldDefs.Add('tercera', ftFloat, 0, False);
      FieldDefs.Add('resto', ftFloat, 0, False);

      IndexFieldNames:= 'empresa;centro;cosechero;producto;lunes';
      CreateTable;
      Open;
    end;
  end;
end;

procedure CerrarTablaTemporal;
begin
  mtCosteSecciones.Close;
end;

function GrabadoCosteSeccion( const AEmpresa, ACentro, AProductor, AProducto: String;
                              const ALunes: TDateTime; var VCostes: RCosteEnvasado ): boolean;
begin
  result:= False;
  if mtCosteSecciones.Active then
  begin
    with mtCosteSecciones do
    begin
      if Locate('empresa;centro;cosechero;producto;lunes',
                VarArrayOf([AEmpresa, ACentro, AProductor, AProducto, ALunes]), [] ) then
      begin
        result:= true;
        VCostes.CostePrimera:= mtCosteSecciones.FieldByName('primera').AsFloat;
        VCostes.CosteSegunda:= mtCosteSecciones.FieldByName('segunda').AsFloat;
        VCostes.CosteTercera:= mtCosteSecciones.FieldByName('tercera').AsFloat;
        VCostes.CosteResto:= mtCosteSecciones.FieldByName('resto').AsFloat;
      end;
    end;
  end;
end;

procedure GrabarCosteSeccion( const AEmpresa, ACentro, AProductor, AProducto: String;
                              const ALunes: TDateTime; const ACostes: RCosteEnvasado );
begin
  if not mtCosteSecciones.Active then
    mtCosteSecciones.Open;
  mtCosteSecciones.Insert;
  mtCosteSecciones.FieldByName('empresa').AsString:= AEmpresa;
  mtCosteSecciones.FieldByName('centro').AsString:= ACentro;
  mtCosteSecciones.FieldByName('cosechero').AsString:= AProductor;
  mtCosteSecciones.FieldByName('producto').AsString:= AProducto;
  mtCosteSecciones.FieldByName('lunes').AsDateTime:= ALunes;
  mtCosteSecciones.FieldByName('primera').AsFloat:= ACostes.CostePrimera;
  mtCosteSecciones.FieldByName('segunda').AsFloat:= ACostes.CosteSegunda;
  mtCosteSecciones.FieldByName('tercera').AsFloat:= ACostes.CosteTercera;
  mtCosteSecciones.FieldByName('resto').AsFloat:= ACostes.CosteResto;
  try
    mtCosteSecciones.Post;
  except
    mtCosteSecciones.Cancel;
  end;
end;

function GetCosteMensualEnvasadoAux(const AEmpresa, ACentro, AProductor, AProducto: String; const ALunes: TDateTime;
                                    const ATipo: Integer; AAnyoMesProveedor, sAnyoMes: string): RCosteEnvasado;
var
  rCoste: real;
  sApli: string;
  sCentroTransito: string;
  sAuxAnyoMes: string;
begin
  result.CostePrimera := 0;
  result.CosteSegunda := 0;
  result.CosteTercera := 0;
  result.CosteResto := 0;

  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add(' select env_tcoste_epc ');
    SQL.Add(' from frf_env_pcostes ');
    SQL.Add(' where empresa_epc = :empresa ');
    SQL.Add(' and centro_epc = :centro ');
    if sAnyoMes <> '' then
      SQL.Add(' and anyo_mes_epc = :anyo_mes ');
    SQL.Add(' and productor_epc = :productor ');
    SQL.Add(' and producto_epc = :producto ');
    SQL.Add(' and tipo_entrada_epc = :tipo ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('anyo_mes').AsString := AAnyoMesProveedor;
    ParamByName('productor').AsInteger := StrToInt(AProductor);
    ParamByName('producto').AsString := AProducto;
    if ( sAnyoMes <> '' ) and ( sAnyoMes <= '201003' ) then
    begin
      ParamByName('tipo').AsInteger := ATipo;
    end
    else
    begin
      if ATipo < 3 then
        ParamByName('tipo').AsInteger := ATipo
      else
        ParamByName('tipo').AsInteger := 0;
    end;

    try
      Open;

      while not EOF do
      begin
        sAuxAnyoMes := GetAnyoMesCosteMensual(AEmpresa, ACentro, sAnyoMes, Fields[0].AsString);
        rCoste := GetCosteEnvase(AEmpresa, ACentro, sAuxAnyoMes, Fields[0].AsString );
        sApli := GetAplicacion(Fields[0].AsString, SCentroTransito);
        if sCentroTransito <> '' then
        begin
          rCoste:= CosteManipulacionTransito( AEmpresa, ACentro, sCentroTransito, AProducto, ALunes, rCoste, sApli );
        end;
        if copy(sApli, 1, 1) = '1' then
          result.CostePrimera := result.CostePrimera + ( rCoste * DMBaseDatos.QTemp.FieldByName('kilos_1').AsFloat );
        if copy(sApli, 2, 1) = '1' then
          result.CosteSegunda := result.CosteSegunda + ( rCoste * DMBaseDatos.QTemp.FieldByName('kilos_2').AsFloat );
        if copy(sApli, 3, 1) = '1' then
          result.CosteTercera := result.CosteTercera + ( rCoste * DMBaseDatos.QTemp.FieldByName('kilos_3').AsFloat );
        if copy(sApli, 4, 1) = '1' then
          result.CosteResto := result.CosteResto + ( rCoste * DMBaseDatos.QTemp.FieldByName('kilos_d').AsFloat );
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

function GetCosteMensualEnvasado(const AEmpresa, ACentro, AProductor, AProducto: String;
                                 const ALunes: TDateTime): RCosteEnvasado;
var
  sAnyoMesProveedor, sProveedorAux: string;
  sAnyoMes: String;
  rCostes: RCosteEnvasado;
  r1, r2, r3, rD: Real;
begin
  CrearTablaTemporal;

  result.CostePrimera := 0;
  result.CosteSegunda := 0;
  result.CosteTercera := 0;
  result.CosteResto := 0;

  r1:= 0;
  r2:= 0;
  r3:= 0;
  rD:= 0;

  if not GrabadoCosteSeccion( AEmpresa, ACentro, AProductor, AProducto, ALunes, result ) then
  begin
    sAnyoMes:= AnyoMes( ALunes );

    with DMBaseDatos.QTemp do
    begin
      SQL.Clear;
      SQL.Add(' select ');
      SQL.Add('      tipo_entrada_e, ');
      SQL.Add('      round(sum( aporcen_primera_e * total_kgs_e2l ) / 100 , 2 ) kilos_1, ');
      SQL.Add('      round(sum( aporcen_segunda_e * total_kgs_e2l ) / 100 , 2 ) kilos_2, ');
      SQL.Add('      round(sum( aporcen_tercera_e * total_kgs_e2l ) / 100 , 2 ) kilos_3, ');
      SQL.Add('      round(sum( aporcen_destrio_e * total_kgs_e2l ) / 100 , 2 ) kilos_d ');

      SQL.Add(' from frf_entradas2_l, frf_escandallo ');
      SQL.Add(' where empresa_e2l = :empresa ');
      SQL.Add('   and centro_e2l = :centro ');
      SQL.Add('   and producto_e2l = :producto ');
      SQL.Add('   and fecha_e2l between :fechaini and :fechafin ');
      SQL.Add('   and cosechero_e2l = :productor');

      SQL.Add('   and empresa_e = :empresa ');
      SQL.Add('   and centro_e = :centro ');
      SQL.Add('   and producto_e = :producto ');
      SQL.Add('   and fecha_e = fecha_e2l ');
      SQL.Add('   and numero_entrada_e = numero_entrada_e2l ');
      SQL.Add('   and cosechero_e = :productor ');
      SQL.Add('   and plantacion_e = plantacion_e2l ');
      SQL.Add('   and anyo_semana_e = ano_sem_planta_e2l ');
      SQL.Add(' group by tipo_entrada_e ');
      SQL.Add(' order by tipo_entrada_e ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('productor').AsInteger := StrToInt(AProductor);
      ParamByName('producto').AsString := AProducto;
      ParamByName('fechaini').AsDateTime := ALunes;
      ParamByName('fechafin').AsDateTime := ALunes + 6;

      Open;
      while not Eof do
      begin
        sProveedorAux := AProductor;
        sAnyoMesProveedor := GetAnyoMes(AEmpresa, ACentro, sProveedorAux, AProducto, FieldByName('tipo_entrada_e').AsInteger, sAnyoMes);
        if sAnyoMesProveedor <> '' then
        begin
          rCostes:= GetCosteMensualEnvasadoAux( AEmpresa, ACentro, sProveedorAux, AProducto, ALunes,
                                                FieldByName('tipo_entrada_e').AsInteger, sAnyoMesProveedor, sAnyoMes );
          result.CostePrimera := result.CostePrimera + rCostes.CostePrimera;
          result.CosteSegunda := result.CosteSegunda + rCostes.CosteSegunda;
          result.CosteTercera := result.CosteTercera + rCostes.CosteTercera;
          result.CosteResto := result.CosteResto + rCostes.CosteResto;
          r1:= r1 + FieldByName('kilos_1').AsFloat;
          r2:= r2 + FieldByName('kilos_2').AsFloat;
          r3:= r3 + FieldByName('kilos_3').AsFloat;
          rD:= rD + FieldByName('kilos_d').AsFloat;
        end;
        Next;
      end;
      Close;
    end;
    if r1 > 0 then
      result.CostePrimera := result.CostePrimera / r1;
    if r2 > 0 then
      result.CosteSegunda := result.CosteSegunda / r2;
    if r3 > 0 then
      result.CosteTercera := result.CosteTercera / r3;
    if rD > 0 then
      result.CosteResto := result.CosteResto / rD;
    GrabarCosteSeccion( AEmpresa, ACentro, AProductor, AProducto, ALunes, result );
  end;
end;

initialization
  mtCosteSecciones:= nil;

finalization
  if  mtCosteSecciones <> nil  then
  begin
    mtCosteSecciones.Free;
    mtCosteSecciones:= nil;
  end;
end.

