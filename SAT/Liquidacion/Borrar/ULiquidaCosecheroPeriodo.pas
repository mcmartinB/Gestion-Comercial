{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit ULiquidaCosecheroPeriodo;

interface

uses
  Windows, SysUtils, Classes, Forms, Dialogs;

procedure LiquidacionPorEscandallo(const AEmpresa, ACentro, AProducto,
  AFechaIni, AFechaFin, ACosteComercial,
  ACosteProduccion, ACosteAdministrativo: string;
  const ADefinitiva: boolean);

procedure Previsualizar(const AEmpresa, ACentro, AProducto, ACosechero,
  AFechaIni, AFechaFin, ACosteComercial,
  ACosteProduccion, ACosteAdministrativo: string;
  const  ADefinitiva: boolean);

function KGSAprovecha(const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin: string): boolean;

implementation

uses CVariables, UDMBaseDatos, CGestionPrincipal, bSQLUtils, DError,
  UDMAuxDB, DPreview, CReportes, bMath, RLiquidaCosecheroPeriodo,
  bTimeUtils, ULiquidaCosecheroPeriodoComun, RLiquidaCosecheroPeriodoResumen, ULiquidaCosecheroPeriodoCosteEnv;


procedure LiquidacionPorEscandallo(const AEmpresa, ACentro, AProducto,
  AFechaIni, AFechaFin, ACosteComercial,
  ACosteProduccion, ACosteAdministrativo: string;
  const ADefinitiva: boolean);
begin
  try
    ULiquidaCosecheroPeriodoComun.CrearTablasTemporales;
    Previsualizar(AEmpresa, ACentro, AProducto, '', AFechaIni, AFechaFin,
      ACosteComercial, ACosteProduccion, ACosteAdministrativo, ADefinitiva);
  finally
    BorrarTemporal('tmp_fob');
    ULiquidaCosecheroPeriodoComun.DestruirTablasTemporales;
  end;
end;

procedure MarcarComoDefinitiva( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, ACosechero,
                                      ACComercial, ACProduccion, ACAdministracion, AUsuario: string;
                                const  ADefiniva: boolean;
                                const AFechaLiquida: TDateTime );
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO frf_liquida_definitiva');
    SQL.Add('VALUES ( :empresa, :centro, :producto, :fecha_ini, :fecha_fin, ');
    SQL.Add('         :cosechero, :coste_comercial, :coste_producccion, :coste_administracion_ld, :abonos, ');
    SQL.Add('         :usuario, :fecha_liquida, :definitiva ) ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fecha_ini').AsString:= AFechaIni;
    ParamByName('fecha_fin').AsString:= AFechaFin;

    ParamByName('cosechero').AsString:= ACosechero;
    ParamByName('coste_comercial').AsFloat:= StrToFloatDef( ACComercial, 0 );
    ParamByName('coste_producccion').AsFloat:= StrToFloatDef( ACProduccion, 0 );
    ParamByName('coste_administracion_ld').AsFloat:= StrToFloatDef( ACAdministracion, 0 );
    ParamByName('abonos').AsInteger:= 1;

    ParamByName('usuario').AsString:= AUsuario;
    ParamByName('fecha_liquida').AsDateTime:= AFechaLiquida;
    if ADefiniva then
      ParamByName('definitiva').AsInteger:= 1
    else
      ParamByName('definitiva').AsInteger:= 0;

    ExecSQL;
  end;
end;

procedure Previsualizar
  (const AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin,
  ACosteComercial, ACosteProduccion, ACosteAdministrativo: string;
  const ADefinitiva: boolean);
var
  sAux, fechaInicio, fechafin, fechaCorte: string;
  sFaltan: string;
  bAux: Boolean;
begin
  try
    (*
    ULiquidaCosecheroPeriodoComun.CalcularFechaInicio(AEmpresa, ACentro, AProducto, ACosechero, AFechaIni, AFechaFin, fechainicio, fechafin);

    if fechaInicio = 'ERROR' then begin
      MessageDlg('' + #13 + #10 + 'Problemas al calcular la liquidación.' + #13 + #10 + 'Por favor, pongase en contacto con     ' + #13 + #10 + 'el departamento de informatica.', mtError, [mbOK], 0);
      Exit;
    end
    else
      if fechaInicio = '' then begin
        MessageDlg('' + #13 + #10 + 'No existen entradas para el rango de fechas seleccionado.    ', mtWarning, [mbOK], 0);
        Exit;
      end;
    *)
    //Esta el escandallo grabado y ajustado
    fechainicio:= AFechaIni;
    fechafin:= AFechaFin;
    if not EstaEscandalloGrabado( AEmpresa, ACentro, AProducto, StrToDate( fechainicio ), StrToDate( fechafin ), fechaCorte ) then
    begin
      MessageDlg('' + #13 + #10 + 'Falta grabar escandallos. ' + #13 + #10 + fechaCorte, mtWarning, [mbOK], 0);
      Exit;
    end;
    if not EstaAjustado( AEmpresa, ACentro, AProducto, StrToDate( fechainicio ), StrToDate( fechafin ), sAux, fechaCorte ) then
    begin
      MessageDlg('' + #13 + #10 + 'Falta ajustar los escandallos para ' + QuotedStr( sAux ) + ' desde el ' + QuotedStr( fechaCorte ) +  ', semana ' +
        QuotedStr( AnyoSemana(  StrToDate(fechacorte) ) ) + '.  ', mtWarning, [mbOK], 0);
      Exit;
    end;

    if not KGSAprovecha(AEmpresa, ACentro, AProducto, ACosechero, fechaInicio, AFechaFin) then
    begin
      MessageDlg('' + #13 + #10 + 'No esta grabado el escandallo para el rango de fechas seleccionado.    ', mtWarning, [mbOK], 0);
      FreeAndNil(QRLiquidaCosecheroPeriodo);
      Exit;
    end;

  (*
    if ULiquidacionComun.FaltanAjustesCosFob(AEmpresa, AProducto, sFaltan) then
    begin
      MessageDlg('' + #13 + #10 + 'Falta grabar ajustes FOB para algunos cosecheros.    ' + #13 + #10 + sFaltan, mtWarning, [mbOK], 0);
      Exit;
    end;
  *)

    //if not ( ( AProducto = 'E' ) and ( ACentro = '6' ) ) then
    //  ULiquidacionComun.CosteEnvasado( AEmpresa, ACentro, AProducto, fechaInicio, AFechaFin );
    try
      NuevoCalcularFOB(gsCodigo, AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, True );
      //CalcularFOB( AEmpresa, ACentro, AProducto, fechaInicio );
    finally
      BorrarTemporal('tmp_fob_aux');
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
    ULiquidaCosecheroPeriodoComun.PreparaLiquidacion(AEmpresa, ACentro, AProducto, ACosechero, AFechaIni,
      AFechaFin, ACosteComercial, ACosteProduccion, ACosteAdministrativo);
    QRLiquidaCosecheroPeriodo.UnSoloCosechero := Trim(ACosechero) <> '';
    ULiquidaCosecheroPeriodoCosteEnv.CrearTablaTemporal;
    Preview(QRLiquidaCosecheroPeriodo);
    ULiquidaCosecheroPeriodoCosteEnv.CerrarTablaTemporal;

    bAux:= ADefinitiva;
    if bAux then
    begin
      bAux:= Application.MessageBox('¿Seguro que quiere marcar la liquidación como definitiva?',
                             '¿LIQUIDACIÓN CORRECTA?', MB_YESNO	) = IDYES;
    end;
    MarcarComoDefinitiva( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, ACosechero,
                          ACosteComercial, ACosteProduccion, ACosteAdministrativo, gsCodigo,
                          bAux, Now );

    try
      QRLiquidaCosecheroPeriodoResumen:= TQRLiquidaCosecheroPeriodoResumen.Create( nil );
      PonLogoGrupoBonnysa(QRLiquidaCosecheroPeriodoResumen, AEmpresa );
      QRLiquidaCosecheroPeriodoResumen.lblCentro.Caption:= ACentro;
      QRLiquidaCosecheroPeriodoResumen.lblNomCentro.Caption:= DesCentro( AEmpresa, ACentro );
      QRLiquidaCosecheroPeriodoResumen.lblProducto.Caption:= AProducto;
      QRLiquidaCosecheroPeriodoResumen.lblNOmProducto.Caption:= DesProducto( AEmpresa, AProducto );
      QRLiquidaCosecheroPeriodoResumen.lblPeriodo.Caption:= 'Desde el ' + AFechaIni + ' al ' + AFechaFin;
      Preview(QRLiquidaCosecheroPeriodoResumen);
    except
      FreeAndNil( QRLiquidaCosecheroPeriodoResumen );
      Raise;
    end;
  except
    FreeAndNil( QRLiquidaCosecheroPeriodo );
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

    (*
       No mostrar el cosechero 0 si no se especifica directamente
    *)
    if trim(ACosechero) <> '' then
      SQL.add(' and cosechero_e2l = :cosechero ')
    else
      SQL.add(' and cosechero_e2l <> 0 ');

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

