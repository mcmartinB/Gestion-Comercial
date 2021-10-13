unit UReenvasado;

interface

var
  sReferencia: string;

function CosteReenvasadoKilo(const AEmpresa, ACentro, AProducto: string;
  const AFecha: TDateTime): Real;

function PorcienReenvasado(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime): Real;

function TransitosVendidos(const AEmpresa, ACentro, AProducto: string;
  const AInicio, AFin: TDateTime): Boolean;

function PorcentajeTransitoVendido(const AEmpresa, ACentro, AProducto: string;
  const AInicio, AFin: TDateTime): Real;

implementation

uses DBTables, DB, bMath;
     (*DEBUG*)//, Dialogs, SysUtils, classes;

var
  QTransitos, QTransito, QSalidas: TQuery;

function CosteReenvasadoKilo(const AEmpresa, ACentro, AProducto: string;
  const AFecha: TDateTime): Real;
begin
  result := 0;
end;

function KilosVendidos(const AEmpresa, ACentro, AProducto, AReferencia: string;
  const AFecha: TDateTime): Real;
begin
  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select envase_sl, sum( kilos_sl ) kilos_sl ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add('   and centro_origen_sl = :centro ');
    SQL.Add('   and producto_sl = :producto ');
    SQL.Add('   and ref_transitos_sl = :referencia ');
    SQL.Add('   and fecha_sl between :inicio and :fin ');
    SQL.Add(' group by envase_sl ');
    SQL.Add(' order by envase_sl ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('referencia').AsString := AReferencia;
    //SUPONEMOS
    // primero -> el la salida es posterior a la fecha del transito
    // segundo -> despues de un 100 dias no quedara nada del transito por vender
    ParamByName('inicio').AsDateTime := AFecha - 30;
    ParamByName('fin').AsDateTime := AFecha + 100;

    Open;

    result := 0;
    while not EOF do
    begin
      result := result + FieldByName('kilos_sl').AsFloat;
      Next;
    end;
  end;
end;

function KilosNuevoTransito(const AEmpresa, ACentro, AProducto, AReferencia: string;
  const AFecha: TDateTime): Real;
begin
  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select envase_tl envase, sum( kilos_tl ) kilos_tl ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_origen_tl = :centro ');
    SQL.Add(' and producto_tl = :producto ');
    SQL.Add(' and ref_origen_tl = :referencia ');
    SQL.Add(' and fecha_tl between :inicio and :fin ');
    SQL.Add(' group by envase_tl ');
    SQL.Add(' order by envase_tl ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('referencia').AsString := AReferencia;
    //SUPONEMOS
    // primero -> el la salida es posterior a la fecha del transito
    // segundo -> despues de un 100 dias no quedara nada del transito por vender
    ParamByName('inicio').AsDateTime := AFecha - 30;
    ParamByName('fin').AsDateTime := AFecha + 100;

    Open;

    result := 0;
    while not EOF do
    begin
      result := result + FieldByName('kilos_tl').AsFloat;
      Next;
    end;
  end;
end;

function LocalizarTransito(const AEmpresa, ACentro, AProducto, AReferencia: string;
  const AFecha: TDateTime): Real;
begin
  with QTransito do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_tl, centro_origen_tl, referencia_tl, fecha_tl, producto_tl, envase_tl, ');
    SQL.Add('        sum( kilos_tl ) kilos_tl ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add('   and centro_origen_tl = :centro ');
    SQL.Add('   and referencia_tl = :referencia ');
    SQL.Add('   and producto_tl = :producto ');
    SQL.Add('   and fecha_tl between :inicio and :fin ');
    SQL.Add(' group by empresa_tl, centro_origen_tl, referencia_tl, fecha_tl, producto_tl, envase_tl ');
    SQL.Add(' order by empresa_tl, centro_origen_tl, referencia_tl, fecha_tl, producto_tl, envase_tl ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('referencia').AsString := AReferencia;
    //SUPONEMOS
    // primero -> el transito fue antes que la salida
    // segundo -> no hara 100 de que el transito saliera
    ParamByName('inicio').AsDateTime := AFecha - 100;
    ParamByName('fin').AsDateTime := AFecha + 30;

    Open;

    result := 0;
    while not EOF do
    begin
      result := result + FieldByName('kilos_tl').AsFloat;
      Next;
    end;
  end;
end;

function GetEnvase: string;
var
  saux1, saux2: string;
begin
  saux1 := QTransito.fieldByName('envase_tl').AsString;
  saux2 := QSalidas.fieldByName('envase_sl').AsString;
  if saux1 < saux2 then
  begin
    result := saux1;
  end
  else
  begin
    result := saux2;
  end;
end;

procedure NextEnvase(const AEnvase: string);
var
  bFlag: boolean;
begin
  bFlag := QTransito.EOF;
  if (AEnvase = QTransito.fieldByName('envase_tl').AsString) or QSalidas.EOF then
    QTransito.Next;
  if (AEnvase = QSalidas.fieldByName('envase_sl').AsString) or bFlag then
    QSalidas.Next;
end;

function KilosReenvasados: Real;
var
  sEnvase: string;
  rAux: Real;
begin
  QTransito.First;
  QSalidas.First;
  result := 0;
  while not QSalidas.Eof do
  begin
    sEnvase := GetEnvase;
    if (QTransito.fieldByName('envase_tl').AsString > QSalidas.fieldByName('envase_sl').AsString) or
      QTransito.EOF then
    begin
      result := result + QSalidas.fieldByName('kilos_sl').AsFloat;
    end
    else
      if QTransito.fieldByName('envase_tl').AsString = QSalidas.fieldByName('envase_sl').AsString then
      begin
        rAux := QSalidas.fieldByName('kilos_sl').AsFloat - QTransito.fieldByName('kilos_tl').AsFloat;
        if rAux > 0 then
          result := result + rAux;
      end;

    NextEnvase(sEnvase);
  end;
end;

procedure ReenvasadoSemanal(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime;
  var AKilosTotales, AKilosReenvasados: Real);
var
  rKilosTransito, rKilosVendidos: Real;
  (*DEBUG*)//slAux: TstringList;
begin
  (*DEBUG*)//slAux:= TStringList.Create;
  AKilosTotales := 0;
  AKilosReenvasados := 0;

  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl empresa, centro_origen_sl centro_origen, ');
    SQL.Add('        producto_sl producto, ref_transitos_sl referencia, ');
    SQL.Add('        min( fecha_sl ) fecha ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add('   and centro_origen_sl = :centro ');
    SQL.Add('   and producto_sl = :producto ');
    SQL.Add('   and fecha_sl between :inicio and :fin ');
    SQL.Add('   and ref_transitos_sl is not null ');
    SQL.Add(' group by empresa_sl, centro_origen_sl, producto_sl, ref_transitos_sl ');
    SQL.Add(' order by empresa_sl, centro_origen_sl, producto_sl, ref_transitos_sl ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := ALunes;
    ParamByName('fin').AsDateTime := ALunes + 6;

    Open;
  end;

  while not QTransitos.EOF do
  begin
    with QTransitos do
    begin
      rKilosTransito := LocalizarTransito(FieldByName('empresa').AsString, FieldByName('centro_origen').AsString,
        FieldByName('producto').AsString, FieldByName('referencia').AsString,
        FieldByName('fecha').AsDateTime);
    end;
    with QTransito do
    begin
      FieldByName('fecha_tl').AsString;
      rKilosVendidos := KilosVendidos(FieldByName('empresa_tl').AsString,
        FieldByName('centro_origen_tl').AsString, FieldByName('producto_tl').AsString,
        FieldByName('referencia_tl').AsString, FieldByName('fecha_tl').AsDateTime);
    end;

    if rKilosTransito = rKilosVendidos then
    begin
      //Todos los kilos han sido vendidos
      //HEMOS DE COMPROBARLO PREVIAMENTE
      AKilosTotales := AKilosTotales + rKilosTransito;
      rKilosVendidos := KilosReenvasados;
      AKilosReenvasados := AKilosReenvasados + rKilosVendidos;
      (*DEBUG*)//slAux.Add( QTransito.FieldByName('referencia_tl').AsString + ';' + FloatToStr(rKilosTransito)  + ';' + FloatToStr(rKilosVendidos) );
    end;

    QTransito.Close;
    QSalidas.Close;

    QTransitos.Next;
  end;
  QTransitos.Close;
end;

function PorcienReenvasado(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime): Real;
var
  rTotales, rReenvasados: Real;
begin
  QTransitos := TQuery.Create(nil);
  QTransitos.DatabaseName := 'BDProyecto';

  QTransito := TQuery.Create(nil);
  QTransito.DatabaseName := 'BDProyecto';

  QSalidas := TQuery.Create(nil);
  QSalidas.DatabaseName := 'BDProyecto';

  //Para todos los transitos que tienen salidas en esa semana
  try
    ReenvasadoSemanal(AEmpresa, ACentro, AProducto, ALunes, rTotales, rReenvasados);
    result := 0;
    if rTotales > 0 then
      result := bRoundTo((rReenvasados * 100) / rTotales, -2);
  finally
    QTransitos.Free;
    QTransitos := nil;

    QTransito.Free;
    QTransito := nil;

    QSalidas.Free;
    QSalidas := nil;
  end;
end;

function TransitosVendidos(const AEmpresa, ACentro, AProducto: string;
  const AInicio, AFin: TDateTime): Boolean;
var
  rKilosTransito, rKilosVendidos: Real;
begin
  QTransitos := TQuery.Create(nil);
  QTransitos.DatabaseName := 'BDProyecto';

  QTransito := TQuery.Create(nil);
  QTransito.DatabaseName := 'BDProyecto';

  QSalidas := TQuery.Create(nil);
  QSalidas.DatabaseName := 'BDProyecto';

  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl empresa, centro_origen_sl centro_origen, ');
    SQL.Add('        producto_sl producto, ref_transitos_sl referencia, ');
    SQL.Add('        min( fecha_sl ) fecha ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add('   and centro_origen_sl = :centro ');
    SQL.Add('   and producto_sl = :producto ');
    SQL.Add('   and fecha_sl between :inicio and :fin ');
    SQL.Add('   and ref_transitos_sl is not null ');
    SQL.Add(' group by empresa_sl, centro_origen_sl, producto_sl, ref_transitos_sl ');
    SQL.Add(' order by empresa_sl, centro_origen_sl, producto_sl, ref_transitos_sl ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := AInicio;
    ParamByName('fin').AsDateTime := AFin;

    Open;
  end;

  result := true;
  while not QTransitos.EOF and result do
  begin
    with QTransitos do
    begin
      rKilosTransito := LocalizarTransito(FieldByName('empresa').AsString, FieldByName('centro_origen').AsString,
        FieldByName('producto').AsString, FieldByName('referencia').AsString,
        FieldByName('fecha').AsDateTime);
    end;
    with QTransito do
    begin
      rKilosVendidos := KilosVendidos(FieldByName('empresa_tl').AsString,
        FieldByName('centro_origen_tl').AsString, FieldByName('producto_tl').AsString,
        FieldByName('referencia_tl').AsString, FieldByName('fecha_tl').AsDateTime);
      rKilosVendidos := rKilosVendidos +
        KilosNuevoTransito(FieldByName('empresa_tl').AsString,
        FieldByName('centro_origen_tl').AsString, FieldByName('producto_tl').AsString,
        FieldByName('referencia_tl').AsString, FieldByName('fecha_tl').AsDateTime);
    end;

    result := Abs(( rKilosTransito - rKilosVendidos )) < 0.01;

    if not result then
    begin
      with QTransito do
        sReferencia := FieldByName('referencia_tl').AsString + ' del ' + FieldByName('fecha_tl').AsString;
    end;

    QTransito.Close;
    QSalidas.Close;

    QTransitos.Next;
  end;
  QTransitos.Close;

  QTransitos.Free;
  QTransitos := nil;

  QTransito.Free;
  QTransito := nil;

  QSalidas.Free;
  QSalidas := nil;
end;

function PorcentajeTransitoVendido(const AEmpresa, ACentro, AProducto: string;
  const AInicio, AFin: TDateTime): Real;
var
  rKilosTransito, rKilosVendidos: Real;
begin
  QTransitos := TQuery.Create(nil);
  QTransitos.DatabaseName := 'BDProyecto';

  QTransito := TQuery.Create(nil);
  QTransito.DatabaseName := 'BDProyecto';

  QSalidas := TQuery.Create(nil);
  QSalidas.DatabaseName := 'BDProyecto';

  with QTransitos do
  begin
  (*
    SQL.Clear;
    SQL.Add(' select empresa_sl empresa, centro_origen_sl centro_origen, ');
    SQL.Add('        producto_sl producto, ref_transitos_sl referencia, ');
    SQL.Add('        min( fecha_sl ) fecha ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add('   and centro_origen_sl = :centro ');
    SQL.Add('   and producto_sl = :producto ');
    SQL.Add('   and fecha_sl between :inicio and :fin ');
    SQL.Add('   and ref_transitos_sl is not null ');
    SQL.Add(' group by empresa_sl, centro_origen_sl, producto_sl, ref_transitos_sl ');
    SQL.Add(' order by empresa_sl, centro_origen_sl, producto_sl, ref_transitos_sl ');
   *)
    SQL.Clear;
    SQL.Add(' select empresa_tl empresa, centro_origen_tl centro_origen, ');
    SQL.Add('        producto_tl producto, referencia_tl referencia, ');
    SQL.Add('        min( fecha_tl ) fecha ');

    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_origen_tl = :centro ');
    SQL.Add(' and producto_tl = :producto ');
    SQL.Add(' and fecha_tl between :inicio and :fin ');
    SQL.Add(' group by empresa_tl, centro_origen_tl, producto_tl, referencia_tl ');
    SQL.Add(' order by empresa_tl, centro_origen_tl, producto_tl, referencia_tl ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('producto').AsString := AProducto;
    ParamByName('inicio').AsDateTime := AInicio;
    ParamByName('fin').AsDateTime := AFin;

    Open;
  end;

  rKilosVendidos:= 0;
  rKilosTransito := 0;
  while not QTransitos.EOF do
  begin
    with QTransitos do
    begin
      rKilosTransito := rKilosTransito + LocalizarTransito(FieldByName('empresa').AsString, FieldByName('centro_origen').AsString,
        FieldByName('producto').AsString, FieldByName('referencia').AsString,
        FieldByName('fecha').AsDateTime);
    end;
    if rKilosTransito <> 0 then
    begin
      with QTransito do
      begin
        rKilosVendidos := rKilosVendidos +
          KilosVendidos(FieldByName('empresa_tl').AsString,
          FieldByName('centro_origen_tl').AsString, FieldByName('producto_tl').AsString,
          FieldByName('referencia_tl').AsString, FieldByName('fecha_tl').AsDateTime);
        rKilosVendidos := rKilosVendidos +
          KilosNuevoTransito(FieldByName('empresa_tl').AsString,
          FieldByName('centro_origen_tl').AsString, FieldByName('producto_tl').AsString,
          FieldByName('referencia_tl').AsString, FieldByName('fecha_tl').AsDateTime);
      end;
    end;

    QTransito.Close;
    QSalidas.Close;

    QTransitos.Next;
  end;
  QTransitos.Close;
  if rKilosTransito <> 0 then
    result := bRoundTo(rKilosVendidos * 100 / rKilosTransito, -2)
  else
    result := -1;

  QTransitos.Free;
  QTransitos := nil;

  QTransito.Free;
  QTransito := nil;

  QSalidas.Free;
  QSalidas := nil;
end;


end.
