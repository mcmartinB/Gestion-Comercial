{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit ULiquidacionSinValorar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;


procedure CrearTablasTemporales;
procedure DestruirTablasTemporales;
procedure CalcularFechaInicio(const AEmpresa, ACentro, AProducto, ACosechero,AFechaIni, AFechaFin: string; var ANuevaIni, ANuevaFin: string );
procedure PreparaLiquidacion(const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin: string);
function  EstaAjustado( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string; var AFechaCorte: string ): boolean;
procedure LiquidacionPorEscandallo( const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin: string );
procedure Previsualizar( const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin: string );
function  KGSAprovecha( const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin: string ): boolean;

implementation

uses CVariables, CAuxiliarDB, UDMBaseDatos, CGestionPrincipal, bSQLUtils,
  RLiquidacionSinValorar, UDMAuxDB, DPreview, CReportes, bMath, bDialogs,
  bTimeUtils, DateUtils;


procedure DestruirTablasTemporales;
begin
  BorrarTemporal('tmp_categorias');
end;

procedure CrearTablasTemporales;
begin
  with DMAuxDB.QAux do
  begin
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

function EstaAjustado( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string; var AFechaCorte: string ): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select min(fecha_e) fecha from frf_escandallo ');
    SQL.Add(' where empresa_e = ' + QuotedStr( AEmpresa ) );
    SQL.Add('   and centro_e = ' + QuotedStr( ACentro ) );
    SQL.Add('   and producto_e = ' + QuotedStr( AProducto ) );
    SQL.Add('   and fecha_e between :fechaini and :fechafin ');
    SQL.Add('   and aporcen_primera_e + aporcen_segunda_e + aporcen_tercera_e + aporcen_destrio_e = 0 ' );
    ParamByName('fechaini').asDateTime:= StrToDate( AFechaIni );
    ParamByName('fechafin').asDateTime:= StrToDate( AFechaFin );
    Open;
    if IsEmpty or ( Fields[0].AsString = '' ) then
    begin
      result:= true;
      Close;
    end
    else
    begin
      result:= false;
      AFechaCorte:= Fields[0].AsString;
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

    if Trim(ACosechero) <> '' then
    begin
      SQl.add(' and cosechero_e2l= :cosechero ');
      ParamByName('cosechero').AsString := ACosechero;
    end;

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


procedure PreparaLiquidacion(const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin: string);
begin
  QRLiquidacionSinValorar := TQRLiquidacionSinValorar.Create( Application );
  PonLogoGrupoBonnysa( QRLiquidacionSinValorar, AEmpresa );

  with QRLiquidacionSinValorar.QCosecheros do
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

  with QRLiquidacionSinValorar.QCosecherosCount do
  begin
    Cancel;
    Close;
    SQL.Clear;
    SQl.add(' select count( distinct cosechero ) ' +
            ' from tmp_categorias ');
    Open;
  end;

  with QRLiquidacionSinValorar.QKGSCosechados do
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

  with QRLiquidacionSinValorar do
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
  end;
end;


procedure LiquidacionPorEscandallo(const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin : string );
begin
  try
    Previsualizar( AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin );
  finally
    BorrarTemporal('tmp_fob');
  end;
end;

procedure Previsualizar( const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin: string );
var
  fechaInicio, fechafin, fechaCorte: string;
begin
  try
    ULiquidacionSinValorar.CalcularFechaInicio(AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin, fechainicio, fechafin);

    if fechaInicio = 'ERROR' then begin
      MessageDlg('' + #13 + #10 + 'Problemas al calcular la liquidación.' + #13 + #10 + 'Por favor, pongase en contacto con     ' + #13 + #10 + 'el departamento de informatica.', mtError, [mbOK], 0);
      Exit;
    end
    else
      if fechaInicio = '' then begin
        MessageDlg('' + #13 + #10 + 'No existen entradas para el rango de fechas seleccionado.    ', mtWarning, [mbOK], 0);
        Exit;
      end;

    //Esta el escandallo ajustado
    if not EstaAjustado( AEmpresa, ACentro, AProducto, fechainicio, fechafin, fechaCorte ) then
    begin
      MessageDlg('' + #13 + #10 + 'Falta ajustar los escandallos desde el ' + QuotedStr( fechaCorte ) +  ', semana ' +
        QuotedStr( AnyoSemana(  StrToDate(fechacorte) ) ) + '.  ', mtWarning, [mbOK], 0);
      Exit;
    end;

    if not KGSAprovecha(AEmpresa, ACentro, AProducto, ACosechero, fechaInicio, AFechaFin) then
    begin
      MessageDlg('' + #13 + #10 + 'No esta grabado el escandallo para el rango de fechas seleccionado.    ', mtWarning, [mbOK], 0);
      FreeAndNil(QRLiquidacionSinValorar);
      Exit;
    end;

  except
    on E: Exception do
    begin
      BEMensajes('');
      ShowError(e.Message);
      Exit;
    end;
  end;

  try
    ULiquidacionSinValorar.PreparaLiquidacion(AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin);
    Preview(QRLiquidacionSinValorar);
  except
    FreeAndNil( QRLiquidacionSinValorar );
    Raise;
  end;
end;

function KGSAprovecha(const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin: string): boolean;
begin
  BEMensajes('Calculando aprovechamiento.');
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQl.add(' delete from tmp_categorias where 1 = 1 ');
    ExecSQL;

    SQL.Clear;

    SQl.add(' select cosechero_e2l cosechero,  YEARANDWEEK(fecha_e2l) anyosemana, ');
    SQl.add('        Round(sum(total_kgs_e2l/100*aporcen_primera_e),2) primera, ');
    SQl.add('        Round(sum(total_kgs_e2l/100*aporcen_segunda_e),2) segunda, ');
    SQl.add('        Round(sum(total_kgs_e2l/100*aporcen_tercera_e),2) tercera, ');
    SQl.add('        Round(sum(total_kgs_e2l/100*aporcen_destrio_e),2) destrio, ');

    SQl.add('        SUM(total_kgs_e2l) kilos ');

    SQl.add(' from frf_entradas2_l, frf_escandallo, frf_cosecheros ');

    SQl.add(' where empresa_e2l= :empresa ');
    SQl.add(' and centro_e2l= :centro ');
    SQl.add(' and producto_e2l= :producto ');
    SQl.add(' and fecha_e2l between :inicio and :fin ');
    if trim(ACosechero) <> '' then
      SQL.add(' and cosechero_e2l = :cosechero ');

    SQl.add(' and empresa_e = :empresa ');
    SQl.add(' and centro_e = :centro ');
    SQl.add(' and producto_e = :producto ');
    SQl.add(' and numero_entrada_e = numero_entrada_e2l ');
    SQl.add(' and fecha_e = fecha_e2l ');
    SQl.add(' and cosechero_e = cosechero_e2l ');
    SQl.add(' and plantacion_e = plantacion_e2l ');

    SQl.add(' and empresa_e2l = empresa_c ');
    SQl.add(' and cosechero_e2l = cosechero_c ');
    SQl.add(' and pertenece_grupo_c = ''S'' ');

    SQl.add(' group by 1,2 ');
    SQl.add(' order by 1,2 ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := StrTOdate(AFechaIni);
    ParamByName('fin').AsDateTime := StrTOdate(AfechaFin);
    if trim(ACosechero) <> '' then
      ParamByName('cosechero').AsString := ACosechero;

    OpenQuery(DMBaseDatos.QGeneral);

    if IsEmpty then
    begin
      result := False;
      Close;
      Exit;
    end;

    DMAuxDB.QAux.SQL.Clear;
    DMAuxDB.QAux.SQL.Add(' insert into tmp_categorias values (');
    DMAuxDB.QAux.SQL.Add(' :cosechero, :anyosemana, :kilos, :aprovecha, ');
    DMAuxDB.QAux.SQL.Add(' :aprovechados, :categoria, :porcentaje, :kilos_cat )');
    DMAuxDB.QAux.Prepare;
    while not eof do
    begin
      DMAuxDB.QAux.ParamByName('cosechero').Value := FieldByName('cosechero').Value;
      DMAuxDB.QAux.ParamByName('anyosemana').Value := FieldByName('anyosemana').Value;
      DMAuxDB.QAux.ParamByName('kilos').Value := FieldByName('kilos').Value;

      DMAuxDB.QAux.ParamByName('aprovecha').AsFloat :=
        bRoundTo(((FieldByName('primera').AsFloat + FieldByName('segunda').AsFloat +
        FieldByName('tercera').AsFloat + FieldByName('destrio').AsFloat) * 100) / FieldByName('kilos').AsFloat, -3);
      DMAuxDB.QAux.ParamByName('aprovechados').Value :=
        FieldByName('primera').AsFloat + FieldByName('segunda').AsFloat +
        FieldByName('tercera').AsFloat + FieldByName('destrio').AsFloat;

      //Primera
      DMAuxDB.QAux.ParamByName('categoria').AsString := '1';
      DMAuxDB.QAux.ParamByName('porcentaje').Value :=
        bRoundTo((FieldByName('primera').AsFloat * 100) / FieldByName('kilos').AsFloat, -3);
      DMAuxDB.QAux.ParamByName('kilos_cat').AsFloat := FieldByName('primera').AsFloat;
      DMAuxDB.QAux.ExecSQL;
      //Segunda
      DMAuxDB.QAux.ParamByName('categoria').AsString := '2';
      DMAuxDB.QAux.ParamByName('porcentaje').Value :=
        bRoundTo((FieldByName('segunda').AsFloat * 100) / FieldByName('kilos').AsFloat, -3);
      DMAuxDB.QAux.ParamByName('kilos_cat').AsFloat := FieldByName('segunda').AsFloat;
      DMAuxDB.QAux.ExecSQL;
      //Tercera
      DMAuxDB.QAux.ParamByName('categoria').AsString := '3';
      DMAuxDB.QAux.ParamByName('porcentaje').Value :=
        bRoundTo((FieldByName('tercera').AsFloat * 100) / FieldByName('kilos').AsFloat, -3);
      DMAuxDB.QAux.ParamByName('kilos_cat').AsFloat := FieldByName('tercera').AsFloat;
      DMAuxDB.QAux.ExecSQL;
      //Destrio
      DMAuxDB.QAux.ParamByName('categoria').AsString := '4';
      DMAuxDB.QAux.ParamByName('porcentaje').Value :=
        bRoundTo((FieldByName('destrio').AsFloat * 100) / FieldByName('kilos').AsFloat, -3);
      DMAuxDB.QAux.ParamByName('kilos_cat').AsFloat := FieldByName('destrio').AsFloat;
      DMAuxDB.QAux.ExecSQL;
      next;
    end;
    DMAuxDB.QAux.UnPrepare;
    Close;

    SQL.Clear;
    SQl.add(' delete from tmp_categorias where kilos_cat = 0 ');
    ExecSQL;

    SQL.Clear;
    SQl.add(' select * from tmp_categorias ');
    Open;
    result := not IsEmpty;
    Close;
  end;
  BEMensajes('');
end;

end.
