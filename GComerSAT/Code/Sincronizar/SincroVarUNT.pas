unit SincroVarUNT;

interface

uses Classes, SysUtils, DB, ComCtrls, Forms, DBTables, bMath;

const
  kSincroTodo= 0;
  kSincroEntradas= 1;
  kSincroEscandallos= 2;
  kSincroSalidas= 3;
  kSincroTransitos= 4;
  kSincroInventarios= 5;
  //kSincroConfeccionado= 6;
  kSincroEntregas= 7;
  kSincroSobrepesos= 8;
  //kSincroCosteEnvasado= 9;
  kSincroCosteEnvase= 10;
  kSincroPedidos= 11;
  kSincroDesgloseSal=12;

type
  RSincroResumen = record
    titulo, usuario, hora: String;
    registros, pasados, erroneos, duplicados: integer;
    msgPasados, msgErrores, msgDuplicados: TStringList;
  end;

  RSincroTodoResumen = record
    titulo, usuario, hora: String;
    REntrada, REscandallo, RSalidas: RSincroResumen;
    RTransitos, RInventarios, RConfeccionado: RSincroResumen;
  end;

  procedure LiberarResumenSincronizar( var ASincroResumen: RSincroResumen );
  procedure LiberarTodoResumenSincronizar( var ASincroTodoResumen: RSincroTodoResumen );
  procedure InicializarResumenSincronizar( var ASincroResumen: RSincroResumen );
  procedure InicializarTodoResumenSincronizar( var ASincroTodoResumen: RSincroTodoResumen );
  procedure CopiarResumen( var ADestino: RSincroResumen; const AOrigen: RSincroResumen );

  procedure PasaRegistro( const AFuente, ADestino: TDataSet; const AIgnorarError: boolean = False );
  procedure PasaRegistroDes( const AFuenteDes, ADestinoDes, ADestino: TDataSet; const AIgnorarError: boolean = False );
  procedure PasaRSalida( const AFuente, ADestino, ACliente: TDataSet; const AIgnorarError: boolean = False );
  procedure PasarRegistros( const AFuente, ADestino, AFuenteDes, ADestinoDes: TDataSet; const AIgnorarError: boolean = False );
  function  DescripcionRegistro( const ADataSet: TDataSet; const ACampos: Integer): string;
  procedure DeleteDesgloseSal( const AFuente: TDataSet; const AIgnorarError: boolean = False );
  function ComprobarKilosLinea( const AFuente: TDataSet; const AIgnorarError: boolean = False ): boolean;
  function ComprobarLineaAlbaran( const AFuente: TDataSet; const AIgnorarError: boolean = False ): boolean;


  procedure AsignarBarraProgreso( ABarraProgeso: TProgressBar );
  procedure LiberarBarraProgreso;
  procedure InicializarBarraProgreso( const AConsulta: TDataSet );
  procedure IncBarraProgreso;

  procedure PonerPrecio (const ADestino: TDataSet; var APrecio: Currency; var AUnidadPre: String);

  var MyBarraProgeso: TProgressBar;

implementation

procedure AsignarBarraProgreso( ABarraProgeso: TProgressBar );
begin
  MyBarraProgeso:= ABarraProgeso;
end;

procedure LiberarBarraProgreso;
begin
  MyBarraProgeso:= NIL;
end;

procedure InicializarBarraProgreso( const AConsulta: TDataSet  );
begin
  if MyBarraProgeso <> nil then
  begin
    MyBarraProgeso.Min:= 0;
    MyBarraProgeso.Position:= 1;
    MyBarraProgeso.Step:= 1;

    try
      AConsulta.Open;
      try
        MyBarraProgeso.Max:= AConsulta.Fields[0].AsInteger + 1;
      finally
        AConsulta.Close;
      end;
    except
      MyBarraProgeso.Max:= 1;
    end;

    Application.ProcessMessages;
  end;
end;

procedure IncBarraProgreso;
begin
  if MyBarraProgeso <> nil then
  begin
    MyBarraProgeso.StepIt;
    Application.ProcessMessages;
  end;
end;

procedure InicializarResumenSincronizar( var ASincroResumen: RSincroResumen );
begin
  ASincroResumen.registros:= 0;
  ASincroResumen.pasados:= 0;
  ASincroResumen.erroneos:= 0;
  ASincroResumen.duplicados:= 0;
  ASincroResumen.msgPasados:= TStringList.Create;
  ASincroResumen.msgErrores:= TStringList.Create;
  ASincroResumen.msgDuplicados:= TStringList.Create;
end;

procedure InicializarTodoResumenSincronizar( var ASincroTodoResumen: RSincroTodoResumen );
begin
  InicializarResumenSincronizar( ASincroTodoResumen.REntrada );
  InicializarResumenSincronizar( ASincroTodoResumen.REscandallo );
  InicializarResumenSincronizar( ASincroTodoResumen.RSalidas );
  InicializarResumenSincronizar( ASincroTodoResumen.RTransitos );
  InicializarResumenSincronizar( ASincroTodoResumen.RInventarios );
  InicializarResumenSincronizar( ASincroTodoResumen.RConfeccionado );
end;

procedure LiberarResumenSincronizar( var ASincroResumen: RSincroResumen );
begin
  if ASincroResumen.msgPasados <> nil then
    FreeAndNil( ASincroResumen.msgPasados );
  if ASincroResumen.msgErrores <> nil then
    FreeAndNil( ASincroResumen.msgErrores );
  if ASincroResumen.msgDuplicados <> nil then
    FreeAndNil( ASincroResumen.msgDuplicados );
end;

procedure LiberarTodoResumenSincronizar( var ASincroTodoResumen: RSincroTodoResumen );
begin
  LiberarResumenSincronizar( ASincroTodoResumen.REntrada );
  LiberarResumenSincronizar( ASincroTodoResumen.REscandallo );
  LiberarResumenSincronizar( ASincroTodoResumen.RSalidas );
  LiberarResumenSincronizar( ASincroTodoResumen.RTransitos );
  LiberarResumenSincronizar( ASincroTodoResumen.RInventarios );
  LiberarResumenSincronizar( ASincroTodoResumen.RConfeccionado );
end;

procedure CopiarResumen( var ADestino: RSincroResumen; const AOrigen: RSincroResumen );
begin
  ADestino.registros:= AOrigen.registros;
  ADestino.pasados:= AOrigen.pasados;
  ADestino.erroneos:= AOrigen.erroneos;
  ADestino.duplicados:= AOrigen.duplicados;
  ADestino.msgPasados.AddStrings( AOrigen.msgPasados );
  ADestino.msgErrores.AddStrings( AOrigen.msgErrores );
  ADestino.msgDuplicados.AddStrings( AOrigen.msgDuplicados );
end;

procedure PasaRegistroDes( const AFuenteDes, ADestinoDes, ADestino: TDataSet; const AIgnorarError: Boolean = False);
var i: Integer;
  campo: TField;
begin
  ADestinoDes.Insert;
  i := 0;
  while i < ADestinoDes.Fields.Count do
  begin
    campo:= AFuenteDes.FindField(ADestinoDes.Fields[i].FieldName);
    if campo <> nil then
    begin
        ADestinoDes.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  try
  ADestinoDes.Post;
  except
    ADestinoDes.Cancel;
    if not AIgnorarError then
      Raise;
  end;
end;


procedure PasaRegistro( const AFuente, ADestino: TDataSet; const AIgnorarError: boolean = False );
var
  i: integer;
  //sAux: string;
  campo: TField;
  rPrecio, rAux: currency;
  sUnidadPre: String;
begin
  ADestino.Insert;
  i:= 0;
  while i < ADestino.Fields.Count do
  begin
    campo:= AFuente.FindField(ADestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      ADestino.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  try
    //Poner precio frf_precio_venta
    campo := ADestino.FindField('precio_sl');
    if campo <> nil then
    begin
      if ADestino.FindField('precio_sl').Value = 0 then
      begin
        PonerPrecio(AFuente, rPrecio, sUnidadPre);
        if rPrecio <> 0 then
        begin
          ADestino.FindField('precio_sl').Value := rPrecio;
          ADestino.FindField('unidad_precio_sl').Value := sUnidadPre;

          if ADestino.FindField('unidad_precio_sl').Value = 'UND' then
          begin
            rAux := ADestino.FindField('cajas_sl').AsInteger * ADestino.FindField('unidades_caja_sl').AsInteger;
          end
          else if ADestino.FindField('unidad_precio_sl').AsString = 'CAJ' then
          begin
            rAux := ADestino.FindField('cajas_sl').AsInteger;
          end
          else
          begin
            rAux := ADestino.FindField('kilos_sl').AsFloat;
          end;

          rAux := bRoundTo(rAux * rPrecio, -2);
          ADestino.FindField('importe_neto_sl').AsFloat := rAux;
          rAux := bRoundTo((ADestino.FindField('importe_neto_sl').AsFloat * ADestino.FindField('porc_iva_sl').AsFloat) / 100, -2);
          ADestino.FindField('iva_sl').AsFloat := rAux;
          rAux := ADestino.FindField('importe_neto_sl').AsFloat + ADestino.FindField('iva_sl').AsFloat;
          ADestino.FindField('importe_total_sl').AsFloat := rAux;
        end;
      end;
    end;
    ADestino.Post;
  except
    ADestino.Cancel;
    if not AIgnorarError then
      Raise;
  end;
end;

procedure DeleteDesgloseSal( const AFuente: TDataSet; const AIgnorarError: boolean = False );
var
  i: integer;
  campo: TField;
  QAux: TQuery;
begin
  QAux := TQuery.Create(Application);
  with QAux do
  begin
    DatabaseName := 'BDCentral';
    RequestLive := true;

    SQL.Clear;
    SQL.Add(' delete from frf_salidas_l2 ');
    SQL.Add('  where empresa_sl2 = :empresa ');
    SQL.Add('    and centro_salida_sl2 = :centro ');
    SQL.Add('    and n_albaran_sl2 = :albaran ');
    SQL.Add('    and fecha_sl2 = :fecha ');
    SQL.Add('    and id_linea_albaran_sl2 = :id_linea ');
    SQL.Add('    and producto_desglose_sl2 = :producto_des ');

    ParamByName('empresa').AsString := AFuente.FindField('empresa_sl2').AsString;
    ParamByName('centro').AsString := AFuente.FindField('centro_salida_sl2').AsString;
    ParamByName('albaran').AsString := AFuente.FindField('n_albaran_sl2').AsString;
    ParamByName('fecha').AsString := AFuente.FindField('fecha_sl2').AsString;
    ParamByName('id_linea').AsInteger := AFuente.FindField('id_linea_albaran_sl2').AsInteger;
    ParamByName('producto_des').AsString := AFuente.FindField('producto_desglose_sl2').AsString;

//    Open;
//    if not isEmpty then
    try
      ExecSQL;
      Close;

    except
    Cancel;
    if not AIgnorarError then
      Raise;
    end;
  end;
end;

function ComprobarKilosLinea ( const AFuente: TDataSet; const AIgnorarError: boolean = False ) :Boolean;
var QAux: TQuery;
    rKilosDestino, rKilosFuente: currency;
begin
  QAux := TQuery.Create(Application);
  with QAux do
  try
    DatabaseName := 'BDProyecto';

    SQL.Clear;
    SQL.Add(' select nvl(kilos_sl,0) kilos_sl from frf_salidas_l ');
    SQL.Add('  where empresa_sl = :empresa ');
    SQL.Add('    and centro_salida_sl = :centro ');
    SQL.Add('    and n_albaran_sl = :albaran ');
    SQL.Add('    and fecha_sl = :fecha ');
    SQL.Add('    and id_linea_albaran_sl = :id_linea ');

    ParamByName('empresa').AsString := AFuente.FindField('empresa_sl2').AsString;
    ParamByName('centro').AsString := AFuente.FindField('centro_salida_sl2').AsString;
    ParamByName('albaran').AsString := AFuente.FindField('n_albaran_sl2').AsString;
    ParamByName('fecha').AsString := AFuente.FindField('fecha_sl2').AsString;
    ParamByName('id_linea').AsInteger := AFuente.FindField('id_linea_albaran_sl2').AsInteger;

    Open;
    rKilosFuente :=  FieldByName('kilos_sl').AsFloat;

  finally
    Close;
  end;

  with QAux do
  try
    DatabaseName := 'BDCentral';

    SQL.Clear;
    SQL.Add(' select nvl(kilos_sl,0) kilos_sl from frf_salidas_l ');
    SQL.Add('  where empresa_sl = :empresa ');
    SQL.Add('    and centro_salida_sl = :centro ');
    SQL.Add('    and n_albaran_sl = :albaran ');
    SQL.Add('    and fecha_sl = :fecha ');
    SQL.Add('    and id_linea_albaran_sl = :id_linea ');

    ParamByName('empresa').AsString := AFuente.FindField('empresa_sl2').AsString;
    ParamByName('centro').AsString := AFuente.FindField('centro_salida_sl2').AsString;
    ParamByName('albaran').AsString := AFuente.FindField('n_albaran_sl2').AsString;
    ParamByName('fecha').AsString := AFuente.FindField('fecha_sl2').AsString;
    ParamByName('id_linea').AsInteger := AFuente.FindField('id_linea_albaran_sl2').AsInteger;

    Open;
    rKilosDestino :=  FieldByName('kilos_sl').AsFloat;

  finally
    Close;
  end;

  Result := rKilosFuente = rKilosDestino;

end;

function ComprobarLineaAlbaran ( const AFuente: TDataSet; const AIgnorarError: boolean = False ) :Boolean;
var QAux: TQuery;
begin
  QAux := TQuery.Create(Application);
  with QAux do
  try
    DatabaseName := 'BDCentral';

    SQL.Clear;
    SQL.Add(' select * from frf_salidas_l ');
    SQL.Add('  where empresa_sl = :empresa ');
    SQL.Add('    and centro_salida_sl = :centro ');
    SQL.Add('    and n_albaran_sl = :albaran ');
    SQL.Add('    and fecha_sl = :fecha ');
    SQL.Add('    and id_linea_albaran_sl = :id_linea ');

    ParamByName('empresa').AsString := AFuente.FindField('empresa_sl2').AsString;
    ParamByName('centro').AsString := AFuente.FindField('centro_salida_sl2').AsString;
    ParamByName('albaran').AsString := AFuente.FindField('n_albaran_sl2').AsString;
    ParamByName('fecha').AsString := AFuente.FindField('fecha_sl2').AsString;
    ParamByName('id_linea').AsInteger := AFuente.FindField('id_linea_albaran_sl2').AsInteger;

    Open;
    result := not IsEmpty;

  finally
    Close;
  end;
end;

procedure PonerPrecio ( const ADestino: TDataSet; var APrecio:Currency; var AUnidadPre: String);
var QAux: TQuery;
    sMoneda: String;
begin

  sMoneda := '';
  QAux := TQuery.Create(nil);
  with QAux do
  try
    if Active then
      Close;
    DataBaseName := 'BDProyecto';

    SQL.Clear;
    SQL.Add(' select moneda_sc from frf_salidas_c ');
    SQL.Add('  where empresa_sc = :empresa ');
    SQL.Add('    and centro_salida_sc = :centro ');
    SQL.Add('    and n_albaran_sc = :albaran ');
    SQL.Add('    and fecha_sc = :fecha ');

    ParamByName('empresa').AsString := ADestino.FindField('empresa_sl').Value;
    ParamByName('centro').AsString := ADestino.FindField('centro_salida_sl').Value;
    ParamByName('albaran').AsString := ADestino.FindField('n_albaran_sl').Value;
    ParamByName('fecha').AsString := ADestino.FindField('fecha_sl').Value;

    Open;
    if not IsEmpty then
      sMoneda := FieldByName('moneda_sc').AsString;

    if Active then
      Close;
    DataBaseName := 'BDCentral';

    SQL.Clear;
    SQL.Add(' select precio_pv, unidad_precio_pv  from frf_precio_venta ');
    SQL.Add('  where cliente_pv = :cliente ');
    SQL.Add('    and envase_pv = :envase ');
    SQL.Add('    and moneda_pv = :moneda ');
    SQL.Add('    and fecha_pv = :fecha ');

    ParamByName('cliente').AsString := ADestino.FindField('cliente_sl').Value;
    ParamByName('envase').AsString := ADestino.FindField('envase_sl').Value;
    ParamByName('fecha').AsString := ADestino.FindField('fecha_sl').Value ;
    ParamByName('moneda').AsString := sMoneda;

    Open;
    if IsEmpty then
    begin
      APrecio := 0;
      AUnidadPre := 'KGS';
    end
    else
    begin
      APrecio := FieldByName('precio_pv').AsFloat;
      AUnidadPre := FieldByName('unidad_precio_pv').AsString;
    end;
  finally
    Close;
  end;
end;


procedure PasaRSalida( const AFuente, ADestino, ACliente: TDataSet; const AIgnorarError: boolean = False );
var
  i: integer;
  //sAux: string;
  campo: TField;
  sEmpresa, sCliente: String;
  bPorte: boolean;
begin

  if AFuente.FieldByName('hora_sc').ASString = '' then
      raise Exception.Create('Falta grabar la hora de carga.');

  ADestino.Insert;
  i:= 0;
  bPorte:= false;
  while i < ADestino.Fields.Count do
  begin
    campo:= AFuente.FindField(ADestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      ADestino.Fields[i].Value:= campo.Value;
      if ADestino.Fields[i].FieldName = 'empresa_sc' then
        sEmpresa:= campo.AsString
      else
      if ADestino.Fields[i].FieldName = 'cliente_sal_sc' then
        sCliente:= campo.AsString
      else
      if ADestino.Fields[i].FieldName = 'porte_bonny_sc' then
        bPorte:= ( campo.AsInteger = 1 );
    end;
    inc( i );
  end;

  //incoterm central
  if bPorte then
  with TQuery( ACliente ) do
  begin
    ParamByName('cliente').AsString:= sCliente;
    Open;
    if FieldByName('incoterm_c').AsString <> '' then
    begin
      campo:= ADestino.FindField('incoterm_sc');
      if campo <> nil then
      begin
        campo.AsString:= FieldByName('incoterm_c').AsString;
        campo:= ADestino.FindField('plaza_incoterm_sc');
        if campo <> nil then
        begin
          campo.AsString:= FieldByName('plaza_incoterm_c').AsString;
        end;
      end;
    end;
    Close;
  end;


  try
    ADestino.Post;
  except
    ADestino.Cancel;
    if not AIgnorarError then
      Raise;
  end;
end;

procedure PasarRegistros( const AFuente, ADestino, AFuenteDes, ADestinoDes: TDataSet; const AIgnorarError: boolean = False );
begin
  if AFuente.Active then
  begin
    AFuente.First;
    while not AFuente.Eof do
    begin
      PasaRegistro( AFuente, ADestino, AIgnorarError );
      if AFuenteDes.Active then
      begin
        AFuenteDes.First;
        while not AFuenteDes.Eof do
        begin
          PasaRegistroDes( AFuenteDes, ADestinoDes, ADestino);
          AFuenteDes.Next;
        end;
      end;
      AFuente.Next;
    end;
  end;
end;

function DescripcionRegistro( const ADataSet: TDataSet; const ACampos: Integer): string;
var
  i: integer;
begin
  result:= ADataSet.Fields[0].FieldName + ':= ' + Copy( ADataSet.Fields[0].AsString, 1, 8 );
  i:= 1;
  while ( i < ACampos ) and ( i < ADataSet.Fields.Count ) do
  begin
    result:= result + '||' + ADataSet.Fields[i].FieldName + ':= ' + Copy( ADataSet.Fields[i].AsString, 1, 8 );
    Inc( i );
  end;
end;

end.
