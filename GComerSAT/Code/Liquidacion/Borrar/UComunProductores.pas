(*
  2005.04.19 PACO dijo que los abonos en su totalidad se restarian a la primera
             en la liquidacion
*)
unit UComunProductores;

interface

uses windows, forms, classes, controls, SysUtils, DateUtils, QLLiquidacionProvedores, Dialogs,
  UCosteEnvasadoComunEx, UReenvasado;

(*ATENCION, 2005.04.22 Paco Vidal
  En caso de ser negativa la segunda pasa a valer 0.03 euros
*)
  const kPrecioSegunda = 0.03;

var
  PorcenArray: array of real;


//PRECIO FOB
//******************************************************************************
//procedure CalcularFOB(const AEmpresa, ACentro, AProducto, AFechaInicio: string);
procedure NuevoCalcularFOB(const AUsuario, AEmpresa, ACentro, AProducto, AProductor, AFechaInicio, AFechaFin: string;
  const AAbonos, AAjustesTerceros: Boolean);
procedure RepercutirFobNegativo;

//COSTE DE ENVASADO
//******************************************************************************
procedure CosteEnvasado(const AUsuario, AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate);

//KILOS COSECHADOS Y APROVECHADOS
//******************************************************************************
function BucleKGSAprovechaEx(const AEmpresa, ACentro, AProducto, ACosechero: string;
  const AFechaIni, AFechaFin: TDate): boolean;
function KGSAprovechaEx(const AEmpresa, ACentro, AProducto, ACosechero: string;
  const AFechaIni: TDate): boolean;
function KGSAprovecha(const AEmpresa, ACentro, AProducto, ACosechero,
  AFechaIni, AFechaFin: string;
  const AOriginal: Boolean = True): boolean;

//******************************************************************************
procedure CalcularFechaInicio(const AEmpresa, ACentro, AProducto, ACosechero,
  AFechaIni, AFechaFin: string; var ANuevaIni, ANuevaFin: string );
function EstaAjustado( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string; var AFechaCorte: string ): boolean;


procedure AjusteFobNuevaLiquidacionTerceros(const AEmpresa, ACentro, AProducto, ADesde, AHasta, AProductor: string);
procedure FinalFobNuevaLiquidacionTerceros(const AEmpresa, ACentro, AProducto, ADesde, AHasta, AProductor: string);
type
  TRAprovechamientos = record
    primera, segunda, tercera, destrio: integer;
    aprimera, asegunda, atercera, adestrio: integer;
  end;

function AplicarAjusteFob(const AEmpresa, ACosechero: string): Boolean;
procedure ListaAjusteCosFob(const AEmpresa, ACosechero, AProducto,
  AFechaInicio, AFechaFin: string;
  var AListaHay, AListaFaltan: TStringList);
function AjusteCosFOBFaltantes(const AEmpresa, AProductor, AProducto: string;
  var AFaltan: TStringList): boolean;


implementation

uses UDMBaseDatos, UDMAuxDB, CGestionPrincipal, bSQLUtils, bMath, bTimeUtils,
  DBTables, DB, TablaTmpFob, Cvariables, AprovechaAjuste, Debug;

var
  bAjustarFobCalidad: boolean = true;

procedure GetAjusteCosFobSemanaEx( const AEmpresa, ACosechero, AProducto, AAnyoSemana: string;
                                   var APrimera, ASegunda, ATercera: Real );
begin
  try
    APrimera:= GetAjusteLiq( AEmpresa, StrToInt( ACosechero ), AProducto, StrToInt( AAnyoSemana ), '1' );
  except
    APrimera:= 1;
  end;

  ASegunda:= 1;
  ATercera:= 1;

(*
  if ( AAnyoSemana = '200542' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) and ( ACosechero = '64' )then
  begin
    APrimera:= 1.138;
  end
  else
  if ( AAnyoSemana = '200543' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) and ( ACosechero = '64' ) then
  begin
    APrimera:= 1.208;
  end
  else
  if ( AAnyoSemana = '200544' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) and ( ACosechero = '64' ) then
  begin
    APrimera:= 1.292;
  end
  else
  if ( AAnyoSemana = '200545' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) then
  begin
    if ( ACosechero = '64' ) then
      APrimera:= 1.252
    else
      APrimera:= 0.999;
  end
  else
  if ( AAnyoSemana = '200546' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) then
  begin
    if ( ACosechero > '63' ) then
      APrimera:= 1.163
    else
      APrimera:= 0.999;
  end
  else
  if ( AAnyoSemana = '200547' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) then
  begin
    if ( ACosechero > '63' ) then
      APrimera:= 1.233
    else
      APrimera:= 0.995;
  end
  else
  if ( AAnyoSemana = '200548' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) then
  begin
    if ( ACosechero > '63' ) then
      APrimera:= 1.211
    else
      APrimera:= 0.955;
  end;
*)
end;

procedure AjustarCosFobSemanaEx(const ACosechero, AAnyoSemana: string;
  const APrimera, ASegunda, ATercera: Real);
begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('update tmp_fob ');
      SQL.Add('set fob = fob * :ajuste ');
      SQL.Add('where anyosemana = :anyosemana ');
      SQL.Add('  and categoria = :categoria ');
      ParamByName('anyosemana').AsString := AAnyoSemana;
      ParamByName('ajuste').AsFloat := APrimera;
      ParamByName('categoria').AsString := '1';
      ExecSQL;

      ParamByName('ajuste').AsFloat := ASegunda;
      ParamByName('categoria').AsString := '2';
      ExecSQL;

      ParamByName('ajuste').AsFloat := ATercera;
      ParamByName('categoria').AsString := '3';
      ExecSQL;

      SQL.Clear;
      SQL.Add('update tmp_fob ');
      SQL.Add('set fob_real = fob - coste_envasado ');
      SQL.Add('where anyosemana = :anyosemana ');
      ParamByName('anyosemana').AsString := AAnyoSemana;
      ExecSQL;
    end;
end;


procedure AnyadirAbono(const AUsuario, AEmpresa, ACentro, AProducto, AProductor, AAnyoSemana: string;
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
      if AProductor <> '' then
        SQL.Add('and cosechero_e = :cosechero ');
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
      if AProductor <> '' then
        ParamByName('cosechero').AsString := AProductor;
      Open;
      if Fields[0].AsFloat = 0 then
        rCosteKilo := 0
      else
        rCosteKilo := Trunc((AValue / Fields[0].AsFloat) * 1000) / 1000;
      Close;

      if rCosteKilo <> 0 then
      begin
        SQL.Clear;
        SQL.Add('update tmp_fob_aux ');
        SQL.Add('set fob = fob + :value ');
        //SQL.Add('where categoria in (''1'',''2'') ');
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
      SQL.add('and fecha_fal between :desde and :hasta ');
      SQL.add('and producto_fal = :producto ');
      SQL.add('and cosechero_fal is null ');
      SQL.add('and empresa_f = :empresa ');
      SQL.add('and n_factura_f = factura_fal ');
      SQL.add('and fecha_factura_f = fecha_fal ');
      SQL.add('group by 1 ');
      SQL.add('order by 1 ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('desde').AsString := AFechaInicio;
      ParamByName('hasta').AsString := AFechaFin;
      ParamByName('producto').AsString := AProducto;
      Open;

      while not EOF do
      begin
      //Para cada semana con abonos
        AnyadirAbono(AUsuario, AEmpresa, ACentro, AProducto, '', Fields[0].AsString, Fields[1].AsFloat);
        Next;
      end;
      Close;

    //Sacar abonos del cosechero
      SQL.Clear;
      SQL.add('select YearAndWeek( fecha_fal ) anyosemana, ');
      SQL.add('       sum( EUROS( moneda_f, fecha_fal, importe_fal ) ) importe ');
      SQL.add('from frf_fac_abonos_l, frf_facturas ');
      SQL.add('where empresa_fal = :empresa ');
      SQL.add('and fecha_fal between :desde and :hasta ');
      SQL.add('and producto_fal = :producto ');
      SQL.add('and cosechero_fal = :productor ');
      SQL.add('and empresa_f = :empresa ');
      SQL.add('and n_factura_f = factura_fal ');
      SQL.add('and fecha_factura_f = fecha_fal ');
      SQL.add('group by 1 ');
      SQL.add('order by 1 ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('desde').AsString := AFechaInicio;
      ParamByName('hasta').AsString := AFechaFin;
      ParamByName('producto').AsString := AProducto;
      ParamByName('productor').AsString := AProductor;
      Open;

      while not EOF do
      begin
      //Para cada semana con abonos
        AnyadirAbono(AUsuario, AEmpresa, ACentro, AProducto, AProductor, Fields[0].AsString, Fields[1].AsFloat);
        Next;
      end;
      Close;
    end;
  finally
    FreeAndNil(QAnyadirAbonos);
  end;
end;

//******************************************************************************
//******************************************************************************
// INICIO CALCULO DEL PRECIO FOB                                               *
//******************************************************************************
//******************************************************************************

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

function GetAjusteCosFobDefault(const AEmpresa, ACosechero: string): Real;
begin
  result := 10;
  (*
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add( 'select NVL( ajuste_c, 0 ) ');
    SQL.Add( 'from frf_cosecheros ');
    SQL.Add( 'where empresa_c = :empresa ');
    SQL.Add( '  and cosechero_c = :cosechero ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cosechero').AsString:= ACosechero;
    Open;
    result:= Fields[0].AsFloat;
    Close;
  end;
  *)
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

procedure PutAjusteCosFobSemana(const AEmpresa, ACosechero, AProducto, AAnyoSemana: string;
  const AValor: Real);
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('insert into frf_cos_ajuste_fob values ');
    SQL.Add('( :empresa, :cosechero, :anyosemana, :producto, :valor, :valor1, :valor2, :valorR ) ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cosechero').AsString := ACosechero;
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ParamByName('producto').AsString := AProducto;
    ParamByName('valor').AsFloat := AValor;
    ParamByName('valor1').AsFloat := AValor;
    ParamByName('valor2').AsFloat := AValor;
    ParamByName('valorR').AsFloat := AValor;
    ExecSQL;
  end;
end;

function PedirValor(const AEmpresa, AProductor, AProducto, ASemana: string;
  var AValor: real): boolean;
var
  sValor, sAux: string;
  bFlag: boolean;
begin
  result := false;
  sValor := FloatToStr(GetAjusteCosFobDefault(AEmpresa, AProductor));
  bFlag := true;
  while bFlag do
  begin
    if InputQuery('SEMANA ' + ASemana, 'Introduce valor ', sValor) then
    begin
      try
        sAux := StringReplace(sValor, '.', ',', []);
        AValor := StrToFloat(sAux);
        result := true;
        bFlag := False;
      except
        ShowMessage(sValor + ' Valor no valido');
      end;
    end
    else
    begin
      bFlag := False;
    end;
  end;
end;

function AjusteCosFOBFaltantes(const AEmpresa, AProductor, AProducto: string;
  var AFaltan: TStringList): boolean;
var
  iCont: Integer;
  rValor: Real;
begin
  result := False;
  if Application.MessageBox(PCHAR('Falta grabar el ajuste FOB del cosechero para las semanas:' + #13 + #10 + AFaltan.Text + '¿Desea grabarlos?'),
    'AJUSTE FOB COSECHERO', MB_OKCANCEL) = IDCANCEL then
    Exit;
  iCont := 0;
  while iCont < AFaltan.Count do
  begin
    if PedirValor(AEmpresa, AProductor, AProducto, AFaltan[iCont], rValor) then
    begin
      PutAjusteCosFobSemana(AEmpresa, AProductor, AProducto, AFaltan[iCont], rValor);
      AFaltan[iCont] := AFaltan[iCont] + '= ' + FloatToStr(bRoundTo(rValor, -2));
    end
    else
    begin
      Exit;
    end;
    iCont := iCont + 1;
  end;
  result := True;
end;

procedure ListaAjusteCosFob(const AEmpresa, ACosechero, AProducto,
  AFechaInicio, AFechaFin: string;
  var AListaHay, AListaFaltan: TStringList);
var
  dFecha: TDate;
begin
  AListaFaltan.Clear;
  AListaHay.Clear;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select ajuste_primera_caf, ajuste_segunda_caf, ajuste_resto_caf');
    SQL.Add('from frf_cos_ajuste_fob ');
    SQL.Add('where empresa_caf = :empresa ');
    SQL.Add('  and cosechero_caf = :cosechero ');
    SQL.Add('  and anyosemana_caf = :anyosemana ');
    SQL.Add('  and producto_caf = :producto ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cosechero').AsString := ACosechero;
    ParamByName('producto').AsString := AProducto;

    dFecha := StrToDate(AFechaInicio);
    while dFecha < StrToDate(AFechaFin) do
    begin
      ParamByName('anyosemana').AsString := AnyoSemana(dFecha);
      Open;
      if IsEmpty then
      begin
        AListaFaltan.Add(ParamByName('anyosemana').AsString);
        //AListaFaltan:= AListaFaltan + ParamByName('anyosemana').AsString  + #13 + #10 ;
      end
      else
      begin
        AListaHay.Add(ParamByName('anyosemana').AsString + ' Primera = ' + FieldByName('ajuste_primera_caf').AsString + '%'
                                                         + ' Segunda = ' + FieldByName('ajuste_segunda_caf').AsString + '%'
                                                         + ' Resto = ' + FieldByName('ajuste_resto_caf').AsString + '%');
        //AListaHay:= AListaHay + ParamByName('anyosemana').AsString + '= ' +
        //                        Fields[0].AsString + #13 + #10 ;
      end;
      Close;
      dFecha := dFecha + 7;
    end;
  end;
end;

(* BANCAJA*)
procedure AjustarCosFobSemana(const ACosechero, AAnyoSemana: string;
                              var APrimera, ASegunda, AResto: Real);
begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('update tmp_fob ');
      SQL.Add('set fob = fob * ( ( 100 - :ajuste ) / 100 ) ');
      //SQL.Add( 'where cosechero = :cosechero ');
      //SQL.Add( '  and anyosemana = :anyosemana ');
      SQL.Add('where anyosemana = :anyosemana ');
      SQL.Add('  and categoria = ''1'' ');
      ParamByName('ajuste').AsFloat := APrimera;
      //ParamByName('cosechero').AsString:= ACosechero;
      ParamByName('anyosemana').AsString := AAnyoSemana;
      ExecSQL;

      SQL.Clear;
      SQL.Add('update tmp_fob ');
      SQL.Add('set fob = fob * ( ( 100 - :ajuste ) / 100 ) ');
      //SQL.Add( 'where cosechero = :cosechero ');
      //SQL.Add( '  and anyosemana = :anyosemana ');
      SQL.Add('where anyosemana = :anyosemana ');
      SQL.Add('  and categoria = ''2'' ');
      ParamByName('ajuste').AsFloat := ASegunda;
      //ParamByName('cosechero').AsString:= ACosechero;
      ParamByName('anyosemana').AsString := AAnyoSemana;
      ExecSQL;

      SQL.Clear;
      SQL.Add('update tmp_fob ');
      SQL.Add('set fob = fob * ( ( 100 - :ajuste ) / 100 ) ');
      //SQL.Add( 'where cosechero = :cosechero ');
      //SQL.Add( '  and anyosemana = :anyosemana ');
      SQL.Add('where anyosemana = :anyosemana ');
      SQL.Add('  and categoria not in(''1'', ''2'') ');
      ParamByName('ajuste').AsFloat := AResto;
      //ParamByName('cosechero').AsString:= ACosechero;
      ParamByName('anyosemana').AsString := AAnyoSemana;
      ExecSQL;

      SQL.Clear;
      SQL.Add('update tmp_fob ');
      SQL.Add('set fob_real = fob - coste_envasado ');
      //SQL.Add( 'where cosechero = :cosechero ');
      //SQL.Add( '  and anyosemana = :anyosemana ');
      SQL.Add('where anyosemana = :anyosemana ');
      //ParamByName('cosechero').AsString:= ACosechero;
      ParamByName('anyosemana').AsString := AAnyoSemana;
      ExecSQL;
    end;
end;

procedure AjusteCosFob(const AEmpresa, AProducto: string);
var
  rAjustePrimera, rAjusteSegunda, rAjusteTercera: Real;
  rPrimera, rSegunda, rTercera: real;
begin
  with DMBaseDatos.QListado do
  begin
    Close;

    SQL.clear;
    SQl.Add(' select unique cosechero, anyosemana ');
    SQl.Add(' from tmp_categorias ');
    SQl.Add(' order by cosechero, anyosemana ');
    open;

    //NO TODOS LOS COSECHEROS NOS ENVIAN LA FRUTA CON LA MISMA CALIDAD
    if bAjustarFobCalidad then
    begin
      First;
      while not eof do
      begin
        GetAjusteCosFobSemanaEx(AEmpresa, Fields[0].asstring, AProducto, Fields[1].asstring, rPrimera, rSegunda, rTercera );
        AjustarCosFobSemanaEx(Fields[0].asstring, Fields[1].asstring, rPrimera, rSegunda, rTercera );
        next;
      end;
    end;

    if AplicarAjusteFob(AEmpresa, Fields[0].asstring) then
    begin
      First;
      while not eof do
      begin
        GetAjusteCosFobSemana(AEmpresa, Fields[0].asstring, AProducto, Fields[1].asstring,
                              rAjustePrimera, rAjusteSegunda, rAjusteTercera );
        AjustarCosFobSemana( Fields[0].asstring, Fields[1].asstring,
                             rAjustePrimera, rAjusteSegunda, rAjusteTercera);
        next;
      end;
    end;
    Close;
  end;
end;

procedure AjusteCosecheroFob(const AEmpresa: string);
var
  rAjusteCosechero: real;
  sCosechero: string;
begin
  with DMAuxDB.QGeneral do
  begin
    SQL.Clear;
    SQL.Add(' select cosechero from tmp_categorias ');
    Open;
    sCosechero := Fields[0].AsString;
    Close;
  end;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select ajuste_c ');
    SQL.Add(' from frf_cosecheros ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add('   and cosechero_c = :cosechero ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cosechero').AsString := sCosechero;
    Open;
    rAjusteCosechero := fields[0].AsFloat;
    Close;

    SQL.Clear;
    SQL.Add('update tmp_fob ');
    SQL.Add('set fob = fob * ( ( 100 - :ajuste ) / 100 ) ');
    ParamByName('ajuste').AsFloat := rAjusteCosechero;
    ExecSQL;

    SQL.Clear;
    SQL.Add('update tmp_fob ');
    SQL.Add('set fob_real = fob - coste_envasado ');
    ExecSQL;
  end;
end;

procedure CosteReenvasado(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDate;
  const AAnyoSemana: string);
var
  rCoste: Real;
begin
  with UDMAuxDB.DMAuxDB.QAux do
  begin
    rCoste := bRoundTo((UReenvasado.PorcienReenvasado(AEmpresa, ACentro, AProducto, ALunes) *
      UReenvasado.CosteReenvasadoKilo(AEmpresa, ACentro, AProducto, ALunes)) / 100, -4);
    DMAuxDB.QAux.SQL.Clear;
    DMAuxDB.QAux.SQL.Add(' update tmp_fob ');
    DMAuxDB.QAux.SQL.Add(' set coste_envasado = coste_envasado + :coste, ');
    DMAuxDB.QAux.SQL.Add('     fob_real = fob_real - :coste ');
    DMAuxDB.QAux.SQL.Add(' where anyosemana = :anyosemana ');
    DMAuxDB.QAux.ParamByName('coste').AsFloat := rCoste;
    DMAuxDB.QAux.ParamByName('anyosemana').AsString := AAnyoSemana;
    DMAuxDB.QAux.ExecSQL;
  end;
end;

procedure CostesDeEnvasado(const AEmpresa, ACentro, AProducto, AFechaInicio: string);
var
  sCosechero, sAnyoSemana: string;
  rCoste: RCosteEnvasado;
  dFecha: TDate;
  //rValue: Real;
begin
  with DMAuxDB.QGeneral do
  begin
    //Cosechero sobre el que aplicamos la liquidacion
    SQL.Clear;
    SQL.Add(' select cosechero from tmp_categorias ');
    Open;
    sCosechero := Fields[0].AsString;
    Close;

    //Semanas que estamos liquidando
    SQL.clear;
    SQl.Add(' select unique anyosemana from tmp_categorias order by anyosemana');
    open;

    First;
    while not EOF do
    begin
      sAnyoSemana := Fields[0].asstring;
      dFecha := LunesAnyoSemana(sAnyoSemana);

      //COSTES COMUNES A TODOS LOS PRODUCTOS
      //TODO Optimizar, es el mismo durante todo el mes
      rCoste := GetCosteMensualEnvasado(AEmpresa, ACentro, sCosechero, AProducto, dFecha );

      //COSTES DE REENVASADO PRODUCTO TENERIFE
(*
      if ( ACentro = '6' ) and ( AProducto = 'E' ) then
      begin
        CosteReenvasado( AEmpresa, ACentro, AProducto, dFecha, sAnyoSemana );
      end;
*)



(*
      DMAuxDB.QAux.SQL.Clear;
      DMAuxDB.QAux.SQl.add(' select unique kilos, aprovechados from tmp_categorias '+
                ' where cosechero=:cosechero and anyosemana = :anyosemana ');
      DMAuxDB.QAux.ParamByName('cosechero').AsString:= sCosechero;
      DMAuxDB.QAux.ParamByName('anyosemana').AsString:= sAnyoSemana;
      DMAuxDB.QAux.Open;

      rValue:= bRoundTo( rCoste.CosteEntregados + ( ( rCoste.CosteAprovechados *
                                            DMAuxDB.QAux.FieldByName('kilos').AsFloat ) /
                                            DMAuxDB.QAux.FieldByName('aprovechados').AsFloat ), -5 );
*)
      DMAuxDB.QAux.Close;

      if rCoste.CostePrimera <> 0 then
      begin
        DMAuxDB.QAux.SQL.Clear;
        DMAuxDB.QAux.SQL.Add(' update tmp_fob ');
        DMAuxDB.QAux.SQL.Add(' set coste_envasado = coste_envasado + :coste, ');
        //DMAuxDB.QAux.SQL.Add(' set coste_envasado = :coste, ');
        DMAuxDB.QAux.SQL.Add('     fob_real = fob_real - :coste ');
        DMAuxDB.QAux.SQL.Add(' where anyosemana = :anyosemana ');
        DMAuxDB.QAux.SQL.Add('   and categoria = ''1'' ');
        DMAuxDB.QAux.ParamByName('coste').AsFloat := rCoste.CostePrimera;
        DMAuxDB.QAux.ParamByName('anyosemana').AsString := sAnyoSemana;
        DMAuxDB.QAux.ExecSQL;
      end;
      if rCoste.CosteSegunda <> 0 then
      begin
        DMAuxDB.QAux.SQL.Clear;
        DMAuxDB.QAux.SQL.Add(' update tmp_fob ');
        DMAuxDB.QAux.SQL.Add(' set coste_envasado = coste_envasado + :coste, ');
        //DMAuxDB.QAux.SQL.Add(' set coste_envasado = :coste, ');
        DMAuxDB.QAux.SQL.Add('     fob_real = fob_real - :coste ');
        DMAuxDB.QAux.SQL.Add(' where anyosemana = :anyosemana ');
        DMAuxDB.QAux.SQL.Add('   and categoria = ''2'' ');
        DMAuxDB.QAux.ParamByName('coste').AsFloat := rCoste.CosteSegunda;
        DMAuxDB.QAux.ParamByName('anyosemana').AsString := sAnyoSemana;
        DMAuxDB.QAux.ExecSQL;
      end;
      if rCoste.CosteTercera <> 0 then
      begin
        DMAuxDB.QAux.SQL.Clear;
        DMAuxDB.QAux.SQL.Add(' update tmp_fob ');
        DMAuxDB.QAux.SQL.Add(' set coste_envasado = coste_envasado + :coste, ');
        //DMAuxDB.QAux.SQL.Add(' set coste_envasado = :coste, ');
        DMAuxDB.QAux.SQL.Add('     fob_real = fob_real - :coste ');
        DMAuxDB.QAux.SQL.Add(' where anyosemana = :anyosemana ');
        DMAuxDB.QAux.SQL.Add('   and categoria = ''3'' ');
        DMAuxDB.QAux.ParamByName('coste').AsFloat := rCoste.CosteTercera;
        DMAuxDB.QAux.ParamByName('anyosemana').AsString := sAnyoSemana;
        DMAuxDB.QAux.ExecSQL;
      end;
      if rCoste.CosteResto <> 0 then
      begin
        DMAuxDB.QAux.SQL.Clear;
        DMAuxDB.QAux.SQL.Add(' update tmp_fob ');
        DMAuxDB.QAux.SQL.Add(' set coste_envasado = coste_envasado + :coste, ');
        //DMAuxDB.QAux.SQL.Add(' set coste_envasado = :coste, ');
        DMAuxDB.QAux.SQL.Add('     fob_real = fob_real - :coste ');
        DMAuxDB.QAux.SQL.Add(' where anyosemana = :anyosemana ');
        DMAuxDB.QAux.SQL.Add('   and categoria = ''4'' ');
        DMAuxDB.QAux.ParamByName('coste').AsFloat := bRoundTo( ( PorcentajesDestrioPeninsula( AEmpresa, ACentro, AProducto,
          DateToStr( dFecha), DateToStr( dFecha + 6) ) / 100 ) * rCoste.CosteResto, -3 );
        DMAuxDB.QAux.ParamByName('anyosemana').AsString := sAnyoSemana;
        DMAuxDB.QAux.ExecSQL;
      end;

  (*
      DMAuxDB.QAux.SQL.Clear;
      DMAuxDB.QAux.SQL.Add(' update tmp_fob ');
      DMAuxDB.QAux.SQL.Add(' set fob_real = fob_real - :coste ');
      DMAuxDB.QAux.SQL.Add(' where anyosemana = :anyosemana ');
      DMAuxDB.QAux.ParamByName('coste').AsFloat:= rValue;
      DMAuxDB.QAux.ParamByName('anyosemana').AsString:= sAnyoSemana;
      DMAuxDB.QAux.ExecSQL;
  *)
      Next;
    end;
    Close;
  end;

end;

procedure ModificarFob(const anyosemana: string; const kilos, dif: Real);
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' update tmp_fob ');
    SQL.Add(' set fob_real = fob_real - :importe ');
    SQL.Add(' where anyosemana = ' + QuotedStr(anyosemana));
    SQL.Add('   and categoria = ''1'' ');
    ParamByName('importe').AsFloat := bRoundTo((dif) / (kilos), -3);
    ExecSQL;

    (*ATENCION, 2005.04.22 Paco Vidal
      En caso de ser negativa la segunda pasa a valer 0.03 euros
    *)
    SQL.Clear;
    SQL.Add(' update tmp_fob ');
    SQL.Add(' set fob_real = :importe ');
    SQL.Add(' where anyosemana = ' + QuotedStr(anyosemana));
    SQL.Add('   and categoria = ''2'' ');
    ParamByName('importe').AsFloat := kPrecioSegunda;
    ExecSQL;

    SQL.Clear;
    SQL.Add(' update tmp_fob ');
    SQL.Add(' set fob = fob_real + coste_envasado ');
    SQL.Add(' where anyosemana = ' + QuotedStr(anyosemana));
    SQL.Add('   and categoria IN (''1'',''2'') ');

    ExecSQL;
  end;
end;

procedure RepercutirFobNegativo;
var
  rKgsPrimera, rDif: Real;
  bFlag: boolean;
  anyosemana: string;
begin
  //SÓLO FUNCIONA SI TENEMOS SÓLO UN COSECHERO EN TMP_CATEGORIAS
  //Para todos los anyosemana de tmp_categorias
  with DMBaseDatos do
  begin
    QGeneral.SQL.Clear;
    QGeneral.SQL.Add('select distinct anyosemana from tmp_categorias ');
    QGeneral.Open;
    while not QGeneral.Eof do
    begin
      anyosemana := QGeneral.fieldByName('anyosemana').AsString;

      //Cruzamos tmp_categorias con tmp_fob para sacar datos
      QTemp.SQL.Clear;
      QTemp.SQL.Add(' select f.categoria, f.fob, f.fob_real, c.kilos_cat ');
      QTemp.SQL.Add(' from tmp_categorias c, tmp_fob f');
      QTemp.SQL.Add(' where c.anyosemana = ' + QuotedStr(anyosemana));
      QTemp.SQL.Add('   and f.anyosemana = ' + QuotedStr(anyosemana));
      QTemp.SQL.Add('   and c.categoria = f.categoria ');
      QTemp.Open;

      rKgsPrimera := 0;
      bFlag := false;
      rDif := 0;
      QTemp.First;
      while not QTemp.Eof do
      begin
        if QTemp.FieldByName('categoria').AsString = '1' then
        begin
          rKgsPrimera := QTemp.FieldByName('kilos_cat').AsFloat;
        end;
        if QTemp.FieldByName('categoria').AsString = '2' then
        begin
          if QTemp.FieldByName('fob_real').AsFloat < kPrecioSegunda then
          begin
            (*ATENCION, 2005.04.22 Paco Vidal
              En caso de ser negativa la segunda pasa a valer 0.03 euros
              2006.05.09 Teresa
              La Segunda tiene un precio minimo
            *)
            rDif := (QTemp.FieldByName('kilos_cat').AsFloat * kPrecioSegunda )
              - (QTemp.FieldByName('kilos_cat').AsFloat * QTemp.FieldByName('fob_real').AsFloat);
            bFlag:= true;
          end;
        end;
        QTemp.Next;
      end;
      QTemp.Close;

      //Realizamos cambios
      if bFlag and ( rKgsPrimera > 0 ) then
        ModificarFob(anyosemana, rKgsPrimera, rDif );

      QGeneral.Next;
    end;
    QGeneral.Close;
  end;
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

procedure SemanaFOB(const AEmpresa, ACentro, AProducto: string;
  inicio, fin: TDate; anyosemana: string;
  primera: Boolean);
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
    SQl.add(' select distinct  c.centro_salida_sc centro_m, c.fecha_sc fecha_m, ' +
      '        c.n_albaran_sc albaran_m ' +
      ' from frf_salidas_c c,frf_salidas_l l ' +
      ' where c.empresa_sc=:empresa  ' +
      ' and c.fecha_sc between :inicio and :fin ' +
      ' and c.empresa_sc=l.empresa_sl  ' +
      ' and c.centro_salida_sc=l.centro_salida_sl ' +
      ' and c.fecha_sc=l.fecha_sl ' +
      ' and c.n_albaran_sc=l.n_albaran_sl ' +

            //SÓLO EXIGIMOS QUE ESTE FACTURADA LA PRIMERA Y LA SEGUNDA - SOCIOS
            //' and ( ( c.n_factura_sc is not null and l.categoria_l in (''1'',''2'') ) or ( l.categoria_l not in (''1'',''2'') ) )'+

      ' and l.centro_origen_sl=:centro ' +
      ' and l.producto_sl=:producto ' +
      ' and l.precio_sl<>0 ' +
      ' and l.precio_sl is not null ' +
      ' group by c.centro_salida_sc, c.fecha_sc, c.n_albaran_sc ' +
      ' order by c.centro_salida_sc, c.fecha_sc, c.n_albaran_sc ' +
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
      ' order by m.centro_m,m.fecha_m, m.albaran_m ' +
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
      ' order by centro_m,fecha_m,albaran_m ' +
      ' into temp tmp_gastos_unidad ');
    ParamByName('empresa').AsString := AEmpresa;
    ExecSql;
    SQL.Clear;
    SQl.add(' select g.centro,g.fecha,g.albaran,' +
      '        g.unidad,g.importe gasto, ' +
      '        s.kilos,s.palets,s.importe,s.cajas ' +
      ' from tmp_gastos_unidad g,tmp_salidas_d s' +
      ' where g.centro=s.centro and g.albaran=s.albaran and g.fecha=s.fecha ' +
      ' order by g.centro,g.fecha,g.albaran ' +
      ' into temp tmp_salidas_gastos ');
    ExecSql;

    //Lineas salidas con precio del centro y producto que interesa
    SQl.clear;
    SQl.add(' select centro_salida_sl centro, fecha_sl fecha, ' +
      '        n_albaran_sl albaran, ' +
      '        case when categoria_sl not in (''1'',''2'',''3'',''B'') then ''4'' else categoria_sl end categoria, ' +
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
            {FACTURADA' and n_factura_sc is not null '+}//VALORADA
            //SÓLO EXIGIMOS QUE ESTE FACTURADA LA PRIMERA Y LA SEGUNDA - SOCIOS
            //' and ( ( c.n_factura_sc is not null and l.categoria_l in (''1'',''2'') ) or ( l.categoria_l not in (''1'',''2'') ) )'+
      ' group by 1,2,3,4 ' +
      ' order by 1,2,3,4 ' +
      ' into temp tmp_salidas ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := inicio;
    ParamByName('fin').AsDateTime := fin;
    ExecSql;

    //Producto cartesiano salidas-gastos por kilos
    SQl.clear;
    SQl.add(' select s.centro, s.fecha, s.albaran, s.categoria,  ' +
      '        s.kilos,s.cajas, s.palets, s.importe, ' +
      '        NVL(ROUND((s.kilos*g.gasto)/g.kilos,2),0) gasto ' +
      ' from  tmp_salidas s, OUTER tmp_salidas_gastos g ' +
      ' where s.centro=g.centro ' +
      '   and s.fecha=g.fecha ' +
      '   and s.albaran=g.albaran ' +
      '   and g.unidad="KILOS" ' +
      ' order by s.centro, s.fecha, s.albaran, s.categoria ' +
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
      ' order by 1,2,3,4 ' +
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
      ' order by s.centro, s.fecha, s.albaran, s.categoria ' +
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
      ' order by s.centro, s.fecha, s.albaran, s.categoria ' +
      ' into temp tmp_sal_import ');
    ExecSQL;

    SQL.clear;
    SQL.Add(' update tmp_sal_import set importe=importe-gasto ' +
      ' where gasto is not null ');
    ExecSQL;

    //Asociamos a la moneda y numero de factura
    SQL.Clear;
    SQL.Add(' select categoria, ' +
      '    SUM(liqImporteEuros(importe,moneda_sc,n_factura_sc,fecha_factura_sc,empresa_sc)) importe, ' +
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
      SQL.Add(' select ' + anyosemana + ' anyosemana,categoria, ' +
        ' ROUND(SUM(importe)/SUM(kilos),3) as fob ' +
        ' from tmp_fob_sem ' +
        ' group by categoria into temp tmp_fob_aux');
      ExecSQl;
    end
    else
    begin
      SQL.Clear;
      SQL.Add(' insert into tmp_fob_aux ' +
        ' select ' + anyosemana + ' anyosemana,categoria, ' +
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
        rAcumGastos := rAcumGastos + GastosTransitos(AEmpresa, FieldByName('centro').AsString,
          FieldByName('albaran').AsString, FieldByName('fecha').AsString);
        rAcumKilos := rAcumKilos + FieldByName('kilos').AsInteger;
        Next;
      end;
    finally
      Close;
    end;
  end;

  ActualizarPrecioFOB(sAnyoSemana, -1 * bRoundTo(rAcumGastos / rAcumKilos, -4));
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

procedure NuevoCalcularFOB(const AUsuario, AEmpresa, ACentro, AProducto, AProductor, AFechaInicio, AFechaFin: string;
  const AAbonos, AAjustesTerceros: Boolean);
begin
  TablaTmpFob.Inicializar;
  TablaTmpFob.Configurar(true, false, true, true);
  TablaTmpFob.Ejecutar(AUsuario, AEmpresa, ACentro, AProducto, AFechaInicio, AFechaFin);
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
    SQL.Add(' select unique anyosemana from tmp_categorias ');
    open;
    while not EOF do
    begin
      FaltaCatFOB(Fields[0].asstring, '1');
      FaltaCatFOB(Fields[0].asstring, '2');
      FaltaCatFOB(Fields[0].asstring, '3');
      FaltaCatFOB(Fields[0].asstring, '4');
      Next;
    end;
    Close;
  end;

  (*MODIF Liquidacion 3-1-2007*)
  //if not ((AProducto = 'E') and (ACentro = '6')) then
  if boolEnvases then
  begin
    //if not (ACentro = '6') then
      CosteEnvasado(gsCodigo, AEmpresa, ACentro, AProducto, StrToDate(AFechaInicio), StrToDate(AFechaFin));
  end;
  with DMBaseDatos.QAux do
  begin
    //Añadir abonos
    if AAbonos then
      AnyadirAbonos(AUsuario, AEmpresa, ACentro, AProducto, AProductor, AFechaInicio, AFechaFin);

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

  //AJUSTES FOB
  if boolSecciones then
  begin
    UCosteEnvasadoComunEx.CrearTablaTemporal;
    CostesDeEnvasado(AEmpresa, ACentro, AProducto, AFechaInicio);
    UCosteEnvasadoComunEx.CerrarTablaTemporal;
  end;
  //AjusteCosecheroFob( AEmpresa );
  if AAjustesTerceros then
    AjusteCosFob(AEmpresa, AProducto);

end;


//******************************************************************************
//******************************************************************************
// FIN CALCULO DEL PRECIO FOB                                                  *
//******************************************************************************
//******************************************************************************



//******************************************************************************
//******************************************************************************
// INICIO CALCULO DEL COSTE ENVASADO                                           *
//******************************************************************************
//******************************************************************************

procedure InsertarCosteEnvasado(const AAnyosemana, ACategoria: string;
  const AValor: real);
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' insert into tmp_coste_envasado values ');
    SQL.Add(' ( :anyosemana, :Categoria, :Valor ) ');
    ParamByName('anyosemana').AsString := AAnyosemana;
    ParamByName('Categoria').AsString := ACategoria;
    ParamByName('Valor').AsFloat := AValor;
    ExecQuery(DMAuxDB.QAux);
  end;
end;

function CosteEnvase(const AAnyo, AMes, AEmpresa, ACentro, AEnvase, AProducto: string): Real;
begin
  result := 0;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select anyo_ec, mes_ec, ( material_ec + coste_ec ) coste_ec from frf_env_costes ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_ec = :centro ');
    SQL.Add(' and envase_ec = :envase ');
    SQL.Add(' and ( anyo_ec < :anyo or ( anyo_ec = :anyo and mes_ec <= :mes ) )');
    SQL.Add(' and producto_base_ec = ');
    SQL.Add(' ( select producto_base_p from frf_productos ');
    SQL.Add('   where empresa_p = :empresa and producto_p = :producto ) ');
    SQL.Add(' order by anyo_ec desc, mes_ec desc ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('envase').AsString := AEnvase;
    ParamByName('anyo').AsInteger := StrToInt(AAnyo);
    ParamByName('mes').AsInteger := StrToInt(AMes);
    ParamByName('producto').AsString := AProducto;
    ParamByName('centro').AsString := ACentro;

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
      SQL.Add(' order by anyo_ec desc, mes_ec desc, coste_ec desc');
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
    SQL.Add('        ' + QuotedStr( ACentroOrigen ) + ' centro, ');
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

//******************************************************************************
//******************************************************************************
// FIN CALCULO DEL COSTE ENVASADO                                              *
//******************************************************************************
//******************************************************************************






//******************************************************************************
//******************************************************************************
// INICIO CALCULO KILOS COSECHADOS Y APROVECHADOS                              *
//******************************************************************************
//******************************************************************************
(*TODO*)
(*Paco quiere qu elos kilos cosechados sean los coschados directamente, sin cruzar con los escandallos*)

function BucleKGSAprovechaEx(const AEmpresa, ACentro, AProducto, ACosechero: string;
  const AFechaIni, AFechaFin: TDate): boolean;
var
  dFecha: TDate;
  bAux: boolean;
begin
  result := false;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQl.add(' delete from tmp_categorias where 1 = 1 ');
    ExecSQL;
  end;

  dFecha := AFechaIni;
  while dFecha < AFechaFin do
  begin
    bAux := KGSAprovechaEx(AEmpresa, ACentro, AProducto, ACosechero, dFecha);
    result := result or bAux;
    dFecha := dFecha + 7;
  end;
end;

function KGSAprovechaEx(const AEmpresa, ACentro, AProducto, ACosechero: string;
  const AFechaIni: TDate): boolean;
var
  kilos_in_producto, kilos_in_cosechero: Real;
  {kilos_out_producto,}kilos_out_c1, kilos_out_c2, kilos_out_c3, kilos_out_d: Real;
  kilos_inicial, kilos_final: real;
  kilos_procesados: real;
  porcen_primera, porcen_segunda, porcen_tercera, porcen_destrio, porcen_total: real;
  kilos_total_cosechero, kilos_c1_cosechero, kilos_c2_cosechero, kilos_c3_cosechero, kilos_d_cosechero: real;
  dFechaFin: TDate;
begin
  dFechaFin := AFechaIni + 6;
  //Kilos entraron
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select sum( total_kgs_e2l ) kilos_in_producto, ');
    SQL.Add('       sum( case when cosechero_e2l = :cosechero then total_kgs_e2l else 0 end ) kilos_in_cosechero ');
    SQL.Add('from frf_entradas2_l where empresa_e2l = :empresa ');
    SQL.Add('and centro_e2l = :centro and producto_e2l = :producto ');
    SQL.Add('and fecha_e2l between :fechaini and :fechafin ');
    ParamByName('cosechero').AsInteger := StrToInt(ACosechero);
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fechaini').AsDate := AFechaIni;
    ParamByName('fechafin').AsDate := dFechaFin;
    Open;
    kilos_in_producto := FieldByName('kilos_in_producto').AsFloat;
    kilos_in_cosechero := FieldByName('kilos_in_cosechero').AsFloat;
    Close;
  end;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('  select sum( case when categoria_sl = ' + QuotedStr('1') + ' then kilos_sl else 0 end ) kilos_out_c1, ');
    SQL.Add('         sum( case when categoria_sl = ' + QuotedStr('2') + ' then kilos_sl else 0 end ) kilos_out_c2, ');
    SQL.Add('         sum( case when categoria_sl = ' + QuotedStr('3') + ' then kilos_sl else 0 end ) kilos_out_c3, ');
    SQL.Add('         sum( case when categoria_sl not in (''1'',''2'',''3'',''B'') then kilos_sl else 0 end ) kilos_out_d, ');
    SQL.Add('         sum( kilos_sl ) kilos_out_producto ');
    SQL.Add('  from frf_salidas_l ');
    SQL.Add('  where empresa_sl = :empresa ');
    SQL.Add('  --centro origen ');
    SQL.Add('  and centro_salida_sl = :centro ');
    SQL.Add('  and producto_sl = :producto ');
    SQL.Add('  and fecha_sl between :fechaini and :fechafin ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fechaini').AsDate := AFechaIni;
    ParamByName('fechafin').AsDate := dFechaFin;
    Open;
    //kilos_out_producto:= FieldByName('kilos_out_producto').AsFloat;
    kilos_out_c1 := FieldByName('kilos_out_c1').AsFloat;
    kilos_out_c2 := FieldByName('kilos_out_c2').AsFloat;
    kilos_out_c3 := FieldByName('kilos_out_c3').AsFloat;
    kilos_out_d := FieldByName('kilos_out_d').AsFloat;
    Close;
  end;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('    select sum( NVL(kilos_cec_ic,0) + NVL(kilos_cim_c1_ic,0) + NVL(kilos_cim_c2_ic,0) + NVL(kilos_cia_c1_ic,0) + ');
    SQL.Add('            NVL(kilos_cia_c2_ic,0) + NVL(kilos_zd_c3_ic,0) + NVL(kilos_zd_d_ic,0) )kilos_inventario,   ');
    SQL.Add('            NVL(kilos_ajuste_c1_ic,0) + NVL(kilos_ajuste_c2_ic,0) + NVL(kilos_ajuste_c3_ic,0) + NVL(kilos_ajuste_cd_ic,0) )kilos_ajuste   ');
    SQL.Add('  from frf_inventarios_c ');
    SQL.Add('  where empresa_ic = :empresa ');
    SQL.Add('  and centro_ic = :centro ');
    SQL.Add('  and producto_ic = :producto ');
    SQL.Add('  and fecha_ic = :fecha ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fecha').AsDate := AFechaIni - 1;
    Open;
    kilos_inicial := FieldByName('kilos_inventario').AsFloat;
    Close;
    ParamByName('fecha').AsDate := dFechaFin;
    Open;
    kilos_final := FieldByName('kilos_inventario').AsFloat + FieldByName('kilos_ajuste').AsFloat;
    Close;
  end;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('    select sum( NVL(kilos_ce_c1_il,0) ) kilos_c1,');
    SQL.Add('           sum( NVL(kilos_ce_c2_il,0) ) kilos_c2 ');
    SQL.Add('    from frf_inventarios_l ');
    SQL.Add('    where empresa_il = :empresa ');
    SQL.Add('      and centro_il = :centro ');
    SQL.Add('      and producto_il = :producto ');
    SQL.Add('      and fecha_il = :fecha ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fecha').AsDate := AFechaIni - 1;
    Open;
    kilos_out_c1 := kilos_out_c1 - FieldByName('kilos_c1').AsFloat;
    kilos_out_c2 := kilos_out_c2 - FieldByName('kilos_c2').AsFloat;
    //kilos_out_producto:= kilos_out_producto - ( FieldByName('kilos_c1').AsFloat + FieldByName('kilos_c2').AsFloat );
    Close;
    ParamByName('fecha').AsDate := dFechaFin;
    Open;
    kilos_out_c1 := kilos_out_c1 + FieldByName('kilos_c1').AsFloat;
    kilos_out_c2 := kilos_out_c2 + FieldByName('kilos_c2').AsFloat;
    //kilos_out_producto:= kilos_out_producto + ( FieldByName('kilos_c1').AsFloat + FieldByName('kilos_c2').AsFloat);
    Close;
  end;


  kilos_procesados := (kilos_inicial - kilos_final) + kilos_in_producto;
  porcen_primera := bRoundTo(kilos_out_c1 * 100 / kilos_procesados, -2);
  porcen_segunda := bRoundTo(kilos_out_c2 * 100 / kilos_procesados, -2);
  porcen_tercera := bRoundTo(kilos_out_c3 * 100 / kilos_procesados, -2);
  porcen_destrio := bRoundTo(kilos_out_d * 100 / kilos_procesados, -2);
  //porcen_total:= bRoundTo( ( ( kilos_out_c1 + kilos_out_c1 + kilos_out_c1 + kilos_out_c1 ) / kilos_procesados ) * 100, -2 );
  porcen_total := porcen_primera + porcen_segunda + porcen_tercera + porcen_destrio;

  kilos_c1_cosechero := bRoundTo(kilos_in_cosechero * (kilos_out_c1 / kilos_procesados), -2);
  kilos_c2_cosechero := bRoundTo(kilos_in_cosechero * (kilos_out_c2 / kilos_procesados), -2);
  kilos_c3_cosechero := bRoundTo(kilos_in_cosechero * (kilos_out_c3 / kilos_procesados), -2);
  kilos_d_cosechero := bRoundTo(kilos_in_cosechero * (kilos_out_d / kilos_procesados), -2);
  kilos_total_cosechero := kilos_c1_cosechero + kilos_c2_cosechero + kilos_c3_cosechero + kilos_d_cosechero;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' insert into tmp_categorias values (');
    SQL.Add(' :cosechero, :anyosemana, :kilos, :aprovecha, ');
    SQL.Add(' :aprovechados, :categoria, :porcentaje, :kilos_cat, 0, 0 )');
    ParamByName('cosechero').AsString := ACosechero;
    ParamByName('anyosemana').AsString := AnyoSemana(AFechaIni);
    ParamByName('kilos').AsFloat := kilos_in_cosechero;
    ParamByName('aprovechados').AsFloat := kilos_total_cosechero;
    ParamByName('aprovecha').AsFloat := porcen_total;
    if kilos_c1_cosechero <> 0 then
    begin
      ParamByName('categoria').AsString := '1';
      ParamByName('porcentaje').AsFloat := porcen_primera;
      ParamByName('kilos_cat').AsFloat := kilos_c1_cosechero;
      ExecSQL;
    end;
    if kilos_c2_cosechero <> 0 then
    begin
      ParamByName('categoria').AsString := '2';
      ParamByName('porcentaje').AsFloat := porcen_segunda;
      ParamByName('kilos_cat').AsFloat := kilos_c2_cosechero;
      ExecSQL;
    end;
    if kilos_c3_cosechero <> 0 then
    begin
      ParamByName('categoria').AsString := '3';
      ParamByName('porcentaje').AsFloat := porcen_tercera;
      ParamByName('kilos_cat').AsFloat := kilos_c3_cosechero;
      ExecSQL;
    end;
    if kilos_d_cosechero <> 0 then
    begin
      ParamByName('categoria').AsString := '4';
      ParamByName('porcentaje').AsFloat := porcen_destrio;
      ParamByName('kilos_cat').AsFloat := kilos_d_cosechero;
      ExecSQL;
    end;
  end;

  result := (kilos_c1_cosechero + kilos_c2_cosechero + kilos_c3_cosechero + kilos_d_cosechero) <> 0;
end;

function KGSAprovechaSemana(const AEmpresa, ACentro, AProducto, ACosechero,
  AFechaIni: string;
  const AOriginal: Boolean = True): boolean;
var
  sAnyoSemana, sFechaFin: string;
begin
  sFechaFin := DateToStr(StrToDate(AFechaIni) + 6);
  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;

    SQl.add(' select cosechero_e2l cosechero, SUM(total_kgs_e2l) kilos ');
    SQl.add(' from frf_entradas2_l ');

    SQl.add(' where empresa_e2l= :empresa ');
    SQl.add(' and centro_e2l= :centro ');
    SQl.add(' and producto_e2l= :producto ');
    SQl.add(' and fecha_e2l between :inicio and :fin ');
    if trim(ACosechero) <> '' then
      SQL.add(' and cosechero_e2l = :cosechero ');
    SQl.add(' group by 1 ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := StrTOdate(AFechaIni);
    ParamByName('fin').AsDateTime := StrTOdate(sFechaFin);
    if trim(ACosechero) <> '' then
      ParamByName('cosechero').AsString := ACosechero;

    OpenQuery(DMBaseDatos.QGeneral);

    //NO HAY ENTRADAS DE ESE COSECHERO EN ESTA SEMANA
    if IsEmpty then
    begin
      result := true;
      Close;
      Exit;
    end;
    Close;

    SQL.Clear;
    if AOriginal then
    begin
      SQl.add(' select cosechero_e2l cosechero,  YEARANDWEEK(fecha_e2l) anyosemana, ');
      SQl.add('        Round(sum(total_kgs_e2l/100*aporcen_primera_e),0) primera, ');
      SQl.add('        Round(sum(total_kgs_e2l/100*aporcen_segunda_e),0) segunda, ');
      SQl.add('        Round(sum(total_kgs_e2l/100*aporcen_tercera_e),0) tercera, ');
      SQl.add('        Round(sum(total_kgs_e2l/100*aporcen_destrio_e),0) destrio, ');
    end
    else
    begin
      SQl.add(' select cosechero_e2l cosechero,  YEARANDWEEK(fecha_e2l) anyosemana, ');
      SQl.add('        Round(sum(total_kgs_e2l/100 * porcen_primera_e),0) primera, ');
      SQl.add('        Round(sum(total_kgs_e2l/100 * porcen_segunda_e),0) segunda, ');
      SQl.add('        Round(sum(total_kgs_e2l/100 * porcen_tercera_e),0) tercera, ');
      SQl.add('        Round(sum(total_kgs_e2l/100 * porcen_destrio_e),0) destrio, ');
    end;

    SQl.add('        SUM(total_kgs_e2l) kilos ');

    SQl.add(' from frf_entradas2_l, frf_escandallo ');

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

    SQl.add(' group by 1,2 ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := StrTOdate(AFechaIni);
    ParamByName('fin').AsDateTime := StrTOdate(sFechaFin);
    if trim(ACosechero) <> '' then
      ParamByName('cosechero').AsString := ACosechero;

    OpenQuery(DMBaseDatos.QGeneral);

    //EL ESCANDALLO NO HA SIDO GRABADO O NO A SIDO AJUSTADO
    if IsEmpty then
    begin
      result := False;
      Close;
      Exit;
    end;

    DMAuxDB.QAux.SQL.Clear;
    DMAuxDB.QAux.SQL.Add(' insert into tmp_categorias values (');
    DMAuxDB.QAux.SQL.Add(' :cosechero, :anyosemana, :kilos, :aprovecha, ');
    DMAuxDB.QAux.SQL.Add(' :aprovechados, :categoria, :porcentaje, :kilos_cat, 0, 0 )');
    DMAuxDB.QAux.Prepare;

    sAnyoSemana := FieldByName('anyosemana').Value;
    DMAuxDB.QAux.ParamByName('anyosemana').Value := sAnyoSemana;
    while not eof do
    begin
      DMAuxDB.QAux.ParamByName('cosechero').Value := FieldByName('cosechero').Value;
      DMAuxDB.QAux.ParamByName('kilos').Value := FieldByName('kilos').Value;

      DMAuxDB.QAux.ParamByName('aprovecha').AsFloat :=
        bRoundTo(((FieldByName('primera').AsFloat + FieldByName('segunda').AsFloat +
        FieldByName('tercera').AsFloat + FieldByName('destrio').AsFloat) * 100) / FieldByName('kilos').AsFloat, -2);
      DMAuxDB.QAux.ParamByName('aprovechados').Value :=
        FieldByName('primera').AsFloat + FieldByName('segunda').AsFloat +
        FieldByName('tercera').AsFloat + FieldByName('destrio').AsFloat;

      //Primera
      DMAuxDB.QAux.ParamByName('categoria').AsString := '1';
      DMAuxDB.QAux.ParamByName('porcentaje').Value :=
        bRoundTo((FieldByName('primera').AsFloat * 100) / FieldByName('kilos').AsFloat, -2);
      DMAuxDB.QAux.ParamByName('kilos_cat').AsFloat := FieldByName('primera').AsFloat;
      DMAuxDB.QAux.ExecSQL;
      //Segunda
      DMAuxDB.QAux.ParamByName('categoria').AsString := '2';
      DMAuxDB.QAux.ParamByName('porcentaje').Value :=
        bRoundTo((FieldByName('segunda').AsFloat * 100) / FieldByName('kilos').AsFloat, -2);
      DMAuxDB.QAux.ParamByName('kilos_cat').AsFloat := FieldByName('segunda').AsFloat;
      DMAuxDB.QAux.ExecSQL;
      //Tercera
      DMAuxDB.QAux.ParamByName('categoria').AsString := '3';
      DMAuxDB.QAux.ParamByName('porcentaje').Value :=
        bRoundTo((FieldByName('tercera').AsFloat * 100) / FieldByName('kilos').AsFloat, -2);
      DMAuxDB.QAux.ParamByName('kilos_cat').AsFloat := FieldByName('tercera').AsFloat;
      DMAuxDB.QAux.ExecSQL;
      //Destrio
      DMAuxDB.QAux.ParamByName('categoria').AsString := '4';
      DMAuxDB.QAux.ParamByName('porcentaje').Value :=
        bRoundTo((FieldByName('destrio').AsFloat * 100) / FieldByName('kilos').AsFloat, -2);
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
    SQl.add(' select * from tmp_categorias where anyosemana = :anyosemana ');
    ParamByName('anyosemana').Value := sAnyoSemana;
    Open;
    result := not IsEmpty;
    Close;

  end;
end;

function KGSAprovecha(const AEmpresa, ACentro, AProducto, ACosechero,
  AFechaIni, AFechaFin: string;
  const AOriginal: Boolean = True): boolean;
var
  dFecha: Tdate;
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
  end;
  dFecha := StrToDate(AFechaIni);
  result := TRue;
  while (dFecha < StrToDate(AFechaFin)) and result do
  begin
    result := KGSAprovechaSemana(AEmpresa, ACentro, AProducto, ACosechero, DateToStr(dFecha), AOriginal);
    dFecha := dFecha + 7;
  end;

  BEMensajes('');
end;


//******************************************************************************
//******************************************************************************
// FIN CALCULO KILOS COSECHADOS Y APROVECHADOS                                 *
//******************************************************************************
//******************************************************************************

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
      ' from frf_entradas2_l ' +
      ' where empresa_e2l=:empresa ' +
      ' and centro_e2l=:centro ' +
      ' and producto_e2l=:producto ' +
      ' and fecha_e2l between :inicio and :fin ');

    if Trim(ACosechero) <> '' then
    begin
      SQl.add(' and cosechero_e2l= :cosechero ');
      ParamByName('cosechero').AsString := ACosechero;
    end;

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

function Aprovechamiento(const AEmpresa, ACentro, AProducto, AProductor: string;
  const ADesde, AHasta: TDateTime): TRAprovechamientos;
begin
  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;

    SQl.add(' select  ');
    SQl.add('        Round(sum(total_kgs_e2l/100 * NVL( porcen_primera_e, 0 ) ),2) primera, ');
    SQl.add('        Round(sum(total_kgs_e2l/100 * NVL( porcen_segunda_e, 0 ) ),2) segunda, ');
    SQl.add('        Round(sum(total_kgs_e2l/100 * NVL( porcen_tercera_e, 0 ) ),2) tercera, ');
    SQl.add('        Round(sum(total_kgs_e2l/100 * NVL( porcen_destrio_e, 0 ) ),2) destrio, ');

    SQl.add('        Round(sum(total_kgs_e2l/100 * NVL( aporcen_primera_e, 0 ) ),2) aprimera, ');
    SQl.add('        Round(sum(total_kgs_e2l/100 * NVL( aporcen_segunda_e, 0 ) ),2) asegunda, ');
    SQl.add('        Round(sum(total_kgs_e2l/100 * NVL( aporcen_tercera_e, 0 ) ),2) atercera, ');
    SQl.add('        Round(sum(total_kgs_e2l/100 * NVL( aporcen_destrio_e, 0 ) ),2) adestrio ');

    SQl.add(' from frf_entradas2_l, frf_escandallo ');

    SQl.add(' where empresa_e2l= :empresa ');
    SQl.add(' and centro_e2l= :centro ');
    SQl.add(' and producto_e2l= :producto ');
    SQl.add(' and fecha_e2l between :inicio and :fin ');
    SQL.add(' and cosechero_e2l = :cosechero ');

    SQl.add(' and empresa_e = :empresa ');
    SQl.add(' and centro_e = :centro ');
    SQl.add(' and producto_e = :producto ');
    SQl.add(' and numero_entrada_e = numero_entrada_e2l ');
    SQl.add(' and fecha_e = fecha_e2l ');
    SQl.add(' and cosechero_e = cosechero_e2l ');
    SQl.add(' and plantacion_e = plantacion_e2l ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := ADesde;
    ParamByName('fin').AsDateTime := AHasta;
    ParamByName('cosechero').AsString := AProductor;

    OpenQuery(DMBaseDatos.QGeneral);

    (*CAMBIOLIQ*)
    (*
    if ( AEmpresa = '050' ) and  ( ACentro = '6' ) and ( AProducto = 'E' ) then
    begin
      result.primera := Fields[4].AsInteger;
      result.segunda := Fields[5].AsInteger;
      result.tercera := Fields[6].AsInteger;
      result.destrio := Fields[7].AsInteger;
    end
    else
    *)
    begin
      result.primera := Fields[0].AsInteger;
      result.segunda := Fields[1].AsInteger;
      result.tercera := Fields[2].AsInteger;
      result.destrio := Fields[3].AsInteger;
    end;

    result.aprimera := Fields[4].AsInteger;
    result.asegunda := Fields[5].AsInteger;
    result.atercera := Fields[6].AsInteger;
    result.adestrio := Fields[7].AsInteger;

    Close;
  end;
end;

procedure FobNuevaLiquidacionTerceros(const AAnyoSemana: string; const AAprovechados: TRAprovechamientos);
var
  importeRepercutir: Real;
begin
  with DMBaseDatos.QGeneral do
  begin
    //CATEGORIAS 3 y DESTRIO VALOR A REPERCUTIR
    importeRepercutir := 0;
    SQL.Clear;

    SQL.Add('select fob_real from tmp_fob ');
    SQL.Add('where anyosemana = :anyosemana ');
    SQL.Add('  and categoria = :categoria ');
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ParamByName('categoria').AsString := '4';
    Open;
    importeRepercutir := importeRepercutir + (AAprovechados.asegunda * Fields[0].AsFloat);
    Close;

    SQL.Clear;
    SQL.Add('update tmp_fob ');
    SQL.Add('set fob_real = TRUNC( ( ( fob_real * :inicial ) + :dif ) / :final, 3 )');
    SQL.Add('where anyosemana = :anyosemana ');
    SQL.Add('  and categoria = :categoria ');

    ParamByName('inicial').AsFloat := AAprovechados.aprimera;
    ParamByName('final').AsFloat := AAprovechados.primera;
    if ParamByName('final').AsInteger = 0 then
    begin
      ParamByName('inicial').AsInteger := 0;
      ParamByName('final').AsInteger := 1;
    end;
    ParamByName('dif').AsFloat := 0;
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ParamByName('categoria').AsString := '1';
    ExecSQL;

    ParamByName('inicial').AsFloat := AAprovechados.asegunda;
    ParamByName('final').AsFloat := AAprovechados.segunda;
    if ParamByName('final').AsInteger = 0 then
    begin
      ParamByName('inicial').AsInteger := 0;
      ParamByName('final').AsInteger := 1;
    end;
    ParamByName('dif').AsFloat := 0;
    ParamByName('categoria').AsString := '2';
    ExecSQL;

    ParamByName('inicial').AsFloat := AAprovechados.atercera;
    ParamByName('final').AsFloat := AAprovechados.tercera;
    if ParamByName('final').AsInteger = 0 then
    begin
      ParamByName('inicial').AsInteger := 0;
      ParamByName('final').AsInteger := 1;
    end;
    ParamByName('dif').AsFloat := importeRepercutir;
    ParamByName('categoria').AsString := '3';
    ExecSQL;

    //ACTUALIZAR FOB
    SQL.Clear;
    SQL.Add('update tmp_fob ');
    SQL.Add('set fob = fob_real + coste_envasado ');
    SQL.Add('where anyosemana = :anyosemana ');
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ExecSQL;
  end;
end;

procedure AjusteFobNuevaLiquidacionTerceros(const AEmpresa, ACentro, AProducto, ADesde, AHasta, AProductor: string);
var
  dIni, dFin: TDatetime;
  RAprovecha: TRAprovechamientos;
begin
  dIni := StrToDate(ADesde);
  dFin := StrToDate(AHasta);
  while dIni < dFin do
  begin
    RAprovecha := Aprovechamiento(AEmpresa, ACentro, AProducto, AProductor, dIni, dIni + 6);
    FobNuevaLiquidacionTerceros(AnyoSemana(dIni), RAprovecha);
    dIni := dIni + 7;
  end;
end;

procedure FobNuevaLiquidacionTercerosFinal(const AAnyoSemana: string; const AAprovechados: TRAprovechamientos);
var
  importeRepercutir, primera, segunda: Real;
  aprovechados: real;
begin
  with DMBaseDatos.QGeneral do
  begin
    //CATEGORIAS 3 y DESTRIO VALOR A REPERCUTIR
    importeRepercutir := 0;
    SQL.Clear;
    SQL.Add('select fob_real from tmp_fob ');
    SQL.Add('where anyosemana = :anyosemana ');
    SQL.Add('  and categoria = :categoria ');
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ParamByName('categoria').AsString := '3';
    Open;
    importeRepercutir := importeRepercutir + (AAprovechados.aTercera * Fields[0].AsFloat);
    Close;

    ParamByName('categoria').AsString := '4';
    Open;
    importeRepercutir := importeRepercutir + (AAprovechados.aDestrio * Fields[0].AsFloat);
    Close;

    primera := (importeRepercutir * AAprovechados.primera) / (AAprovechados.primera + AAprovechados.segunda);
    segunda := (importeRepercutir * AAprovechados.segunda) / (AAprovechados.primera + AAprovechados.segunda);
    primera := primera + (importeRepercutir - (segunda + primera));


    //ELIMINAMOS CATEGORIA 3 y DESTRIO
    SQL.Clear;
    SQL.Add(' DELETE FROM tmp_fob ');
    SQL.Add(' where anyosemana = ' + QuotedStr(AAnyoSemana));
    SQL.Add('   and ( ( categoria = ''3'' ) or ( categoria = ''4'' ) )');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' DELETE FROM tmp_categorias ');
    SQL.Add(' where anyosemana = ' + QuotedStr(AAnyoSemana));
    SQL.Add('   and ( ( categoria = ''3'' ) or ( categoria = ''4'' ) )');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' select sum(ROUND(kilos_cat)) FROM tmp_categorias ');
    SQL.Add(' where anyosemana = ' + QuotedStr(AAnyoSemana));
    Open;
    aprovechados := Fields[0].AsFloat;
    Close;

    SQL.Clear;
    SQL.Add('update tmp_categorias ');
    SQL.Add('set aprovecha = ROUND( ( :aprovechados * 100 ) / kilos, 2 ), ');
    //SQL.Add( '    porcentaje = ROUND( ( kilos_cat * 100 ) / :aprovechados, 2 ),');
    SQL.Add('    aprovechados = :aprovechados ');
    SQL.Add('where anyosemana = :anyosemana ');
    ParamByName('aprovechados').AsFloat := aprovechados;
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ExecSQL;

    //NUEVOS VALORES FOB_REAL PARA LAS CATEGORIAS 1 y 2
    SQL.Clear;
    SQL.Add('update tmp_fob ');
    SQL.Add('set fob_real = TRUNC( ( ( fob_real * :inicial ) + :dif ) / :final, 3 )');
    SQL.Add('where anyosemana = :anyosemana ');
    SQL.Add('  and categoria = :categoria ');

    ParamByName('inicial').AsFloat := AAprovechados.aprimera;
    ParamByName('final').AsFloat := AAprovechados.primera;
    if ParamByName('final').AsInteger = 0 then
    begin
      ParamByName('inicial').AsInteger := 0;
      ParamByName('final').AsInteger := 1;
    end;
    ParamByName('dif').AsFloat := primera;
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ParamByName('categoria').AsString := '1';
    ExecSQL;

    ParamByName('inicial').AsFloat := AAprovechados.asegunda;
    ParamByName('final').AsFloat := AAprovechados.segunda;
    if ParamByName('final').AsInteger = 0 then
    begin
      ParamByName('inicial').AsInteger := 0;
      ParamByName('final').AsInteger := 1;
    end;
    ParamByName('dif').AsFloat := segunda;
    ParamByName('categoria').AsString := '2';
    ExecSQL;

    //ACTUALIZAR FOB
    SQL.Clear;
    SQL.Add('update tmp_fob ');
    SQL.Add('set fob = fob_real + coste_envasado ');
    SQL.Add('where anyosemana = :anyosemana ');
    ParamByName('anyosemana').AsString := AAnyoSemana;
    ExecSQL;
  end;
end;

procedure FinalFobNuevaLiquidacionTerceros(const AEmpresa, ACentro, AProducto, ADesde, AHasta, AProductor: string);
var
  dIni, dFin: TDatetime;
  RAprovecha: TRAprovechamientos;
begin
  dIni := StrToDate(ADesde);
  dFin := StrToDate(AHasta);
  while dIni < dFin do
  begin
    RAprovecha := Aprovechamiento(AEmpresa, ACentro, AProducto, AProductor, dIni, dIni + 6);
    if (RAprovecha.primera + RAprovecha.segunda) <> 0 then
      FobNuevaLiquidacionTercerosFinal(AnyoSemana(dIni), RAprovecha);
    dIni := dIni + 7;
  end;
end;

end.


