unit CAuxiliarDB;

interface

uses db, dbtables, CVariables, Dialogs, SysUtils, UDMBaseDatos,
  BEdit, BCalendarButton, BGridButton, BCalendario, BGrid,
  Forms, DError, windows, classes;

var QUERY: string;

function EnvasePesoVariable(const empresa, envase, producto: string): Boolean;
function EnvaseObtenerSobrepeso(const empresa, envase : string; const anyo, mes : integer): real;
function EnvaseUnidadesVariable(const empresa, envase, producto: string): Boolean;
function KilosEnvase(const empresa, envase, producto: string): Real;
function UnidadesEnvase(const AEmpresa, AEnvase, AProducto: string ): Integer;
function unidadesEnvaseEx(const AEmpresa, AEnvase, AProducto: string): integer;
function unidadFacturacion(const empresa, cliente, producto, envase: string): string;


    // Manejador de errores del BDE
procedure AbrirConsulta(consulta: TDataSet);
procedure EjecutarConsulta(consulta: TQuery);
procedure GrabarDatos(datos: TDataSet);


    //TRANSACCIONES
function AbrirTransaccion(DB: TDataBase): Boolean;
procedure AceptarTransaccion(DB: TDataBase);
procedure CancelarTransaccion(DB: TDataBase);

function DameClave(cadena: string): string;

    //REJILLAS FLOTANTES
procedure DespliegaCalendario(boton: TBCalendarButton);
procedure DespliegaRejilla(boton: TBGridButton); Overload;
procedure DespliegaRejilla(boton: TBGridButton; params: array of string; VAlta: Boolean = FALSE; VVenta:Boolean = FALSE); Overload;
function ConsultaRejilla(boton: TBGridButton; params: array of string; VAlta: boolean; VVenta: boolean): Boolean;

implementation

uses UDMAuxDB, bSQLUtils, bMath, UDMCambioMoneda, UDMConfig;

procedure AbrirConsulta(consulta: TDataSet);
begin
  try
    consulta.Open;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      raise;
    end;
  end;
end;

procedure EjecutarConsulta(consulta: TQuery);
begin
  try
    consulta.ExecSQL;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      raise;
    end;
  end;
end;


procedure GrabarDatos(datos: TDataSet);
begin
  try
    datos.Post;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      raise;
    end;
  end;
end;


function AbrirTransaccion(DB: TDataBase): Boolean;
var
  T, Tiempo: Cardinal;
  cont: integer;
  flag: boolean;
begin
  cont := 0;
  flag := true;
  while flag do
  begin
        //Abrimos transaccion si podemos
    if DB.InTransaction then
    begin
           //Ya hay una transaccion abierta
      inc(cont);
      if cont = 3 then
      begin
        ShowError('En este momento no se puede llevar a cabo la operación seleccionada. ' + #10 + #13 + 'Por favor vuelva a intentarlo mas tarde..');
        AbrirTransaccion := false;
        Exit;
      end;
           //Esperar entre 1 y (1+cont) segundos
      T := GetTickCount;
      Tiempo := cont * 1000 + Random(1000);
      while GetTickCount - T < Tiempo do Application.ProcessMessages;
    end
    else
    begin
      DB.StartTransaction;
      flag := false;
    end;
  end;
  AbrirTransaccion := true;
end;

procedure AceptarTransaccion(DB: TDataBase);
begin
  if DB.InTransaction then
  begin
    DB.Commit;
  end;
end;

procedure CancelarTransaccion(DB: TDataBase);
{var
   I:Integer;}
begin
  if DB.InTransaction then
  begin
    DB.Rollback;
{          for I:=DB.DataSetCount-1 downto 0 do
          begin
               try
                  DB.DataSets[I].Refresh;
               except
                  Continue;
               end;
          end;
}
  end;
end;



function DameClave(cadena: string): string;
var
  inicio, final: Integer;
begin
  inicio := AnsiPos('(', cadena);
  final := AnsiPos(')', cadena);
  if (inicio = 0) or (final = 0) then
  begin
    DameClave := '';
    Exit;
  end;
  cadena := Copy(cadena, inicio + 1, final - inicio - 1);
  inicio := AnsiPos('_', cadena);
  if (inicio = 0) then
  begin
    DameClave := '';
    Exit;
  end;
  cadena := Copy(cadena, inicio + 1, Length(cadena) - 1);
  final := AnsiPos('_', cadena);
  if (final = 0) then
  begin
    DameClave := '';
    Exit;
  end;
  DameClave := Copy(cadena, 1, final - 1);
end;


//***********************************************************************
//***********************************************************************
//***********************************************************************
//***********************************************************************

// PON NOMBRE DE .......

//***********************************************************************
//***********************************************************************
//***********************************************************************
//***********************************************************************


(*
function SQLEnvaseText( const AEmpresa, AProducto, ACliente :string ): String;
var
  sProductoBase: string;
  sText: TStringList;
  iAux: Integer;
begin
  if Trim( AProducto ) <> '' then
  begin
    if TryStrToInt( AProducto, iAux ) then
    begin
      if DMConfig.EsValencia or DMConfig.EsTenerife then
      begin
        iAux:= -1;
      end;
    end
    else
    begin
      iAux:= -1;
    end;

    if iAux = -1 then
    begin
      with DMBaseDatos.QAux do
      begin
        SQL.Clear;
        SQl.Add(' select producto_base_p from frf_productos ');
        SQl.Add(' where producto_p = ' + QuotedStr( AProducto ) );
        if AEmpresa <> '' then
          SQl.Add(' and empresa_p = ' + QuotedStr( AEmpresa ) );
        Open;
        sProductoBase:= Fields[0].AsString;
        Close;
      end;
    end
    else
    begin
      sProductoBase:= AProducto;
    end;
  end
  else
  begin
    sProductoBase:= '';
  end;

  sText:= TStringList.Create;


  if ( Trim( ACliente ) = '' ) then
  begin
    iAux:= 0;
  end
  else
  begin
      with DMBaseDatos.QAux do
      begin
        SQL.Clear;
        SQL.Add(' select * from  frf_clientes_env, frf_envases ');
        SQL.Add(' where fecha_baja_e is null ');
        SQL.Add('   and cliente_ce = ' + QuotedStr( ACliente ));
        if Trim( AEmpresa ) <> '' then
        begin
          SQL.Add('   and empresa_e = ' + QuotedStr( AEmpresa ) );
          SQL.Add('   and empresa_ce = ' + QuotedStr( AEmpresa ) );
        end
        else
        begin
          SQL.Add('   and empresa_e = empresa_ce ');
        end;
        if Trim( sProductoBase ) <> '' then
        begin
          SQL.Add('   and producto_base_ce = ' + QuotedStr( sProductoBase ) );
          SQL.Add('   and ( ( producto_base_e = ' + QuotedStr( sProductoBase ) + ')' );
          SQL.Add('         or ( producto_base_e is NULL ) )');
        end
        else
        begin
          SQL.Add('   and producto_base_ce = producto_base_ce ');
        end;
        SQL.Add('   and envase_e = envase_ce ');
        Open;
        if IsEmpty then
          iAux:= 0
        else
          iAux:= 1;
        Close;
      end;
  end;

  if iAux = 0 then
  begin
    sText.Add(' SELECT DISTINCT  envase_e, descripcion_e ');
    sText.Add(' FROM frf_envases ');
    sText.Add(' WHERE fecha_baja_e is NULL ');
    if Trim( AEmpresa ) <> '' then
      sText.Add(' and empresa_e = ' + QuotedStr( AEmpresa ) );
    if Trim( sProductoBase ) <> '' then
    begin
      sText.Add('   and ( ( producto_base_e = ' + QuotedStr( sProductoBase ) + ')' );
      sText.Add('         or ( producto_base_e is NULL ) )');
    end;
    sText.Add(' group by envase_e, descripcion_e ');
    sText.Add(' ORDER BY envase_e ');
  end
  else
  begin
    sText.Add(' select envase_ce, descripcion_e ');
    sText.Add(' from  frf_clientes_env, frf_envases ');
    sText.Add(' where fecha_baja_e is null ');
    sText.Add('   and cliente_ce = ' + QuotedStr( ACliente ));
    if Trim( AEmpresa ) <> '' then
    begin
      sText.Add('   and empresa_e = ' + QuotedStr( AEmpresa ) );
      sText.Add('   and empresa_ce = ' + QuotedStr( AEmpresa ) );
    end
    else
    begin
      sText.Add('   and empresa_e = empresa_ce ');
    end;
    if Trim( sProductoBase ) <> '' then
    begin
      sText.Add('   and producto_base_ce = ' + QuotedStr( sProductoBase ) );
      sText.Add('   and ( ( producto_base_e = ' + QuotedStr( sProductoBase ) + ')' );
      sText.Add('         or ( producto_base_e is NULL ) )');
    end
    else
    begin
      sText.Add('   and producto_base_ce = producto_base_ce ');
    end;
    sText.Add('   and envase_e = envase_ce ');
    sText.Add('   group by envase_ce, descripcion_e ');
    sText.Add('   order by envase_ce ');
  end;

  result:= sText.Text;
  FreeAndNil( sText );
end;
*)

function SQLEnvaseProductoText( const AEmpresa, AProducto, ACliente :string ): String;
var
  sText: TStringList;
  bFlag: boolean;
begin

  sText:= TStringList.Create;

  if ( Trim( ACliente ) = '' ) then
  begin
    sText.Add(' SELECT DISTINCT  envase_e, descripcion_e ');
    sText.Add(' FROM frf_envases ');
    sText.Add(' WHERE fecha_baja_e is NULL ');
    if Trim( AProducto ) <> '' then
    begin
      sText.Add('   and ( ( producto_e = ' + QuotedStr( AProducto ) + ')' );
      sText.Add('         or ( producto_e is NULL ) )');
    end;
    sText.Add(' group by envase_e, descripcion_e ');
    sText.Add(' ORDER BY envase_e ');
  end
  else
  begin

    with DMBaseDatos.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from  frf_clientes_env, frf_envases ');
      SQL.Add(' where fecha_baja_e is null ');
      SQL.Add('   and cliente_ce = ' + QuotedStr( ACliente ));
      if Trim( AEmpresa ) <> '' then
      begin
          if AEmpresa = 'BAG' then
            sText.Add(' and substr(empresa_ce,1,1) = ''F'' ' )
          else
          if AEmpresa = 'SAT' then
             sText.Add(' and ( empresa_ce = ''080'' or empresa_ce = ''050'' ) ' )
          else
            SQL.Add('   and empresa_ce = ' + QuotedStr( AEmpresa ) );
      end;
      if Trim( AProducto ) <> '' then
      begin
        SQL.Add('   and producto_ce = ' + QuotedStr( AProducto ) );
        SQL.Add('   and ( ( producto_e = ' + QuotedStr( AProducto ) + ')' );
        SQL.Add('         or ( producto_e is NULL ) )');
      end
      else
      begin
        SQL.Add('   and producto_ce = producto_ce ');
      end;
      SQL.Add('   and envase_e = envase_ce ');

      Open;
      bFlag:= not isEmpty;
      Close;
    end;

    if bFlag then
    begin
      sText.Add(' select envase_ce, descripcion_e ');
      sText.Add(' from  frf_clientes_env, frf_envases ');
      sText.Add(' where fecha_baja_e is null ');
      sText.Add('   and cliente_ce = ' + QuotedStr( ACliente ));
      if Trim( AEmpresa ) <> '' then
      begin
        if AEmpresa = 'BAG' then
            sText.Add(' and substr(empresa_ce,1,1) = ''F'' ' )
          else
          if AEmpresa = 'SAT' then
             sText.Add(' and ( empresa_ce = ''080'' or empresa_ce = ''050'' ) ' )
          else
            sText.Add('   and empresa_ce = ' + QuotedStr( AEmpresa ) );
      end;
      if Trim( AProducto ) <> '' then
      begin
        sText.Add('   and producto_ce = ' + QuotedStr( AProducto ) );
        sText.Add('   and ( ( producto_e = ' + QuotedStr( AProducto ) + ')' );
        sText.Add('         or ( producto_e is NULL ) )');
      end
      else
      begin
        sText.Add('   and producto_ce = producto_ce ');
      end;
      sText.Add('   and envase_e = envase_ce ');
      sText.Add('   group by envase_ce, descripcion_e ');
      sText.Add('   order by envase_ce ');
    end
    else
    begin
      sText.Add(' SELECT DISTINCT  envase_e, descripcion_e ');
      sText.Add(' FROM frf_envases ');
      sText.Add(' WHERE fecha_baja_e is NULL ');
      if Trim( AProducto ) <> '' then
      begin
        sText.Add('   and ( ( producto_e = ' + QuotedStr( AProducto ) + ')' );
        sText.Add('         or ( producto_e is NULL ) )');
      end;
      sText.Add(' group by envase_e, descripcion_e ');
      sText.Add(' ORDER BY envase_e ');
    end;
  end;
  result:= sText.Text;
  FreeAndNil( sText );
end;

function SQLEnvaseProductoBaseText( const AEmpresa, AProducto, ACliente :string ): String;
var
  sText: TStringList;
begin

  sText:= TStringList.Create;

  if ( Trim( ACliente ) = '' ) or ( ( DMConfig.EsValencia or DMConfig.EsTenerife ) ) then
  begin
    sText.Add(' SELECT DISTINCT  envase_e, descripcion_e ');
    sText.Add(' FROM frf_envases ');
    sText.Add(' WHERE fecha_baja_e is NULL ');
    if Trim( AProducto ) <> '' then
    begin
      sText.Add('   and ( ( producto_e = ' + QuotedStr( AProducto ) + ')' );
      sText.Add('         or ( producto_e is NULL ) )');
    end;
    sText.Add(' group by envase_e, descripcion_e ');
    sText.Add(' ORDER BY envase_e ');
  end
  else
  begin
    sText.Add(' select envase_ce, descripcion_e ');
    sText.Add(' from  frf_clientes_env, frf_envases ');
    sText.Add(' where fecha_baja_e is null ');
    sText.Add('   and cliente_ce = ' + QuotedStr( ACliente ));
    if Trim( AEmpresa ) <> '' then
    begin
      if AEmpresa = 'BAG' then
            sText.Add(' and substr(empresa_ce,1,1) = ''F'' ' )
          else
          if AEmpresa = 'SAT' then
             sText.Add(' and ( empresa_ce = ''080'' or empresa_ce = ''050'' ) ' )
          else
            sText.Add('   and empresa_ce = ' + QuotedStr( AEmpresa ) );
    end;
    if Trim( AProducto ) <> '' then
    begin
      sText.Add('   and producto_ce = ' + QuotedStr( AProducto ) );
      sText.Add('   and ( ( producto_e = ' + QuotedStr( AProducto ) + ')' );
      sText.Add('         or ( producto_e is NULL ) )');
    end
    else
    begin
      sText.Add('   and producto_ce = producto_ce ');
    end;
    sText.Add('   and envase_e = envase_ce ');
    sText.Add('   group by envase_ce, descripcion_e ');
    sText.Add('   order by envase_ce ');
  end;

  result:= sText.Text;
  FreeAndNil( sText );
end;

//***********************************************************************
//***********************************************************************
//***********************************************************************
//***********************************************************************
// REJILLAS FLOTANTES
//***********************************************************************
//***********************************************************************
//***********************************************************************
//***********************************************************************

procedure DespliegaRejilla(boton: TBGridButton);
begin
  DespliegaRejilla(boton, ['']);
end;

procedure DespliegaRejilla(boton: TBGridButton; params: array of string; VAlta: boolean = FALSE; VVenta: boolean = FALSE);
begin
     //Realizamos consulta
  try
    if ConsultaRejilla(boton, params, VAlta, VVenta) then
    begin
             //Mostrar resultado
      TBGrid(boton.Grid).BControl := TBEdit(boton.Control);
      boton.GridShow;
    end;
  except
    on e: Exception do
    begin
      if e.Message = 'Empresa' then ShowError('Por favor, introduzca primero el código de la empresa.')
      else ShowError('Error al realizar la consulta asociada.');
    end;
  end;
end;

procedure DespliegaCalendario(boton: TBCalendarButton);
begin
  //Realizamos consulta
  try
      //Mostrar resultado
    TBCalendario(boton.Calendar).BControl := TBEdit(boton.Control);
    boton.CalendarShow;
  except
    ShowError('Error al mostrar el calendario.');
  end;
end;

function WhereSQL( fields, params: array of string ): string;
var
  i, j: Integer;
  sAux: string;
begin
  Result:= '';
  i:= Length( fields );
  j:= Length( params );

  //Nos quedamos el indice menor
  if i < j then
    j:= i;

  for i:=0 to j - 1 do
  begin
    if Trim(params[i]) <> '' then
    begin
      //String
      if fields[i][1]= 's' then
        sAux:= QuotedStr( params[i] )
      else
      //Date
      if fields[i][1]= 'd' then
        sAux:= QuotedStr( params[i] )
      //Numeric
      else
      if fields[i][1]= 'n' then
        sAux:= params[i];

      if Result = '' then
        Result:= 'where ' + Copy( fields[i], 2, Length( fields[i] ) -1 ) + ' = ' +  sAux
      else
        Result:= Result + #13 + #10 + '  and ' + Copy( fields[i], 2, Length( fields[i] ) -1 ) + ' = ' +  sAux
    end;
  end;
end;

function ConsultaRejilla(boton: TBGridButton; params: array of string; VAlta: boolean; VVenta: boolean): boolean;
var
  flag: boolean;
  sAux: String;
  iAux: Integer;
begin
  ConsultaRejilla := True;
     {if (DMBaseDatos.QDespegables.Tag<>boton.Control.Tag) then
     begin
          //Consultas diferentes
          DMBaseDatos.QDespegables.Tag:=boton.Control.Tag;}
          //Cerramo la consulta
  DMBaseDatos.QDespegables.Cancel;
  DMBaseDatos.QDespegables.Close;
{     end;

     if DMBaseDatos.QDespegables.Active then
     begin
        //Si la tabla esta abierta miramos a ver si estaba sin datos
        if not DMBaseDatos.QDespegables.IsEmpty then
           Exit;
        ConsultaRejilla:=False;
        Exit;
     end
     else}
        //Sino construimos la consulta
  case boton.Control.Tag of
    kEmpresa:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT empresa_e, nombre_e ' +
          ' FROM frf_empresas ' +
          ' ORDER BY nombre_e ');
      end;
    kSerie:
      begin
        boton.Grid.ColumnResult := 1;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT cod_empresa_es, cod_serie_es, anyo_es ' +
          ' FROM frf_empresas_serie ' +
          ' WHERE anyo_es >= year(today) - 1 ' +
          ' ORDER BY anyo_es desc, cod_empresa_es ');
      end;
    kCentro:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT centro_c, descripcion_c ' +
          ' FROM frf_centros ');
        if (Length(Params) = 1) and (Trim(Params[0]) <> '') then
        begin
          if params[0] = 'BAG' then
            DMBaseDatos.QDespegables.Sql.Add(' WHERE substr(empresa_c,1,1) = ''F'' ' )
          else
          if params[0] = 'SAT' then
             DMBaseDatos.QDespegables.Sql.Add(' WHERE ( empresa_c = ''080'' or empresa_c = ''050'' ) ' )
          else
            DMBaseDatos.QDespegables.Sql.Add(' WHERE empresa_c= ' + QuotedStr(params[0]));
        end;
        DMBaseDatos.QDespegables.Sql.Add(' GROUP BY centro_c, descripcion_c ORDER BY descripcion_c ');
      end;
    kProducto:
      begin
                //Depende de empresa
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT producto_p, descripcion_p ' +
          ' FROM frf_productos where 1=1');
        if VAlta then
          DMBaseDatos.QDespegables.Sql.Add(' and fecha_baja_p is null ');
        if VVenta then
          DMBaseDatos.QDespegables.Sql.Add(' and tipo_venta_p = ''S'' ');
        DMBaseDatos.QDespegables.Sql.Add(' GROUP BY producto_p, descripcion_p ORDER BY descripcion_p ');
      end;
    kCampo:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT campo_c' +
          ' FROM frf_campos ' +
          ' ORDER BY campo_c ');
      end;
    kTipoVia:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT via_v, descripcion_v ' +
          ' FROM frf_vias ' +
          ' ORDER BY descripcion_v ');
      end;
    kTipoSalida:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT codigo_ts, descripcion_ts ' +
          ' FROM frf_tipo_salida ' +
          ' ORDER BY codigo_ts ');
      end;
    kProvincia:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT codigo_p, nombre_p ' +
          ' FROM frf_provincias ' +
          ' ORDER BY codigo_p ');
      end;
    kRepresentante:
      begin
                //Depende de empresa
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT representante_r, descripcion_r ' +
          ' FROM frf_representantes  ');
        DMBaseDatos.QDespegables.Sql.Add(' GROUP BY representante_r, descripcion_r ORDER BY representante_r');
      end;
    kPais:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        if (Length(Params) = 2) and (Trim(Params[0]) <> '') and (Trim(Params[1]) <> '') then
        begin
          DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT pais_p, descripcion_p ');
          DMBaseDatos.QDespegables.Sql.Add(' FROM frf_paises_producto, frf_paises ');
          DMBaseDatos.QDespegables.Sql.Add(' where pais_psp = pais_p ');
          DMBaseDatos.QDespegables.Sql.Add(' and producto_psp = ' + QuotedStr( Params[1] ) );
          DMBaseDatos.QDespegables.Sql.Add(' GROUP BY pais_p, descripcion_p ORDER BY descripcion_p ');
        end
        else
        begin

          DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT pais_p, descripcion_p ' +
                                           ' FROM frf_paises ' +
                                           ' ORDER BY descripcion_p ');
        end;
      end;
    kMoneda:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT moneda_m, descripcion_m ' +
          ' FROM frf_monedas ' +
          ' ORDER BY descripcion_m ');
      end;
    kFormaPago:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' select DISTINCT codigo_fp,descripcion_fp ' +
          ' from frf_forma_pago ' +
          ' order by descripcion_fp');
      end;
    kFormatoEntrada:
      begin
        boton.Grid.ColumnResult := 3;
        boton.Grid.ColumnFind := 4;
        DMBaseDatos.QDespegables.SQL.Clear;

        DMBaseDatos.QDespegables.SQL.Add(' select DISTINCT empresa_p, centro_p, producto_p, formato_p, descripcion_p from frf_pesos  ');
        sAux:= '';
        sAux:= WhereAddStringEmpresa( sAux, 'empresa_p', params[0], true );
        sAux:= WhereAddString( sAux, 'centro_p', params[1], true );
        sAux:= WhereAddString( sAux, 'producto_p', params[2], true );
        DMBaseDatos.QDespegables.SQL.Add( sAux );
        DMBaseDatos.QDespegables.SQL.Add('  order by empresa_p, centro_p, producto_p, formato_p, descripcion_p ');
      end;
    kColor:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;

        sAux:= Params[1];

        DMBaseDatos.QDespegables.SQL.Clear;
        if (Length(Params) = 2) and
          (Trim(Params[0]) <> '') and
          (Trim(sAux) <> '') then
          DMBaseDatos.QDespegables.SQL.Add(' SELECT DISTINCT color_c, descripcion_c ' +
            ' FROM frf_colores ' +
            ' WHERE (producto_c = ' + QuotedStr(sAux) + ')' +
            ' ORDER BY color_c');
      end;
    kColorPBase:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;

        if TryStrToInt( Params[1], iAux ) then
        begin
          DMBaseDatos.QAux.SQL.Clear;
          DMBaseDatos.QAux.SQL.Add(' select max(producto_p) producto_p from frf_productos ' +
                    ' where producto_base_p=' + Params[1] );
          DMBaseDatos.QAux.Open;
          sAux:= DMBaseDatos.QAux.Fields[0].AsString;
          DMBaseDatos.QAux.Close;
        end
        else
        begin
          sAux:= Params[1];
        end;

        DMBaseDatos.QDespegables.SQL.Clear;
        if (Length(Params) = 2) and
          (Trim(Params[0]) <> '') and
          (Trim(sAux) <> '') then
          DMBaseDatos.QDespegables.SQL.Add(' SELECT DISTINCT color_c, descripcion_c ' +
            ' FROM frf_colores ' +
            ' WHERE (producto_c = ' + QuotedStr(sAux) + ')' +
            ' ORDER BY color_c');
      end;
    kMarca:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' SELECT DISTINCT codigo_m, descripcion_m ' +
          ' FROM frf_marcas ' +
          ' ORDER BY codigo_m');
      end;
    kTipoPalet:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' SELECT DISTINCT codigo_tp, descripcion_tp ' +
          ' FROM frf_tipo_palets ' +
          ' ORDER BY codigo_tp');
      end;
    ktipoCoste:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' SELECT DISTINCT codigo_tc, descripcion_tc ' +
          ' FROM frf_tipo_costes ' +
          ' ORDER BY codigo_tc');
      end;
    kFederacion:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' SELECT DISTINCT codigo_f, provincia_f ' +
          ' FROM frf_federaciones ' +
          ' ORDER BY codigo_f');
      end;
    kEnvase:
      begin
        //params[0] --> empresa
        //params[1] --> producto base
        //params[2] --> cliente
        //params[3] --> es producto base
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        case length( params ) of
        (*
          0: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseText( '', '', ''  ) );
          1: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseText( Params[0], '', '' ) );
          2: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseText( Params[0], Params[1], '' ) );
          3: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseText( Params[0], Params[1], Params[2] ) );
        *)
          0: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoText( '', '', ''  ) );
          1: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoText( Params[0], '', '' ) );
          2: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoText( Params[0], Params[1], '' ) );
          3: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoText( Params[0], Params[1], Params[2] ) );
        end;
      end;
    kEnvaseProducto:
      begin
        //params[0] --> empresa
        //params[1] --> producto base
        //params[2] --> cliente
        //params[3] --> es producto base
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        case length( params ) of
          0: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoText( '', '', ''  ) );
          1: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoText( Params[0], '', '' ) );
          2: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoText( Params[0], Params[1], '' ) );
          3: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoText( Params[0], Params[1], Params[2] ) );
        end;
      end;
    kEnvaseProductoBase:
      begin
        //params[0] --> empresa
        //params[1] --> producto base
        //params[2] --> cliente
        //params[3] --> es producto base
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        case length( params ) of
          0: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoBaseText( '', '', ''  ) );
          1: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoBaseText( Params[0], '', '' ) );
          2: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoBaseText( Params[0], Params[1], '' ) );
          3: DMBaseDatos.QDespegables.SQL.Add( SQLEnvaseProductoBaseText( Params[0], Params[1], Params[2] ) );
        end;
      end;
    kEnvComerOperador:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' select cod_operador_eco, des_operador_eco from frf_env_comer_operadores order by 2,1 ');
      end;
    kEnvComerAlmacen:
      begin
        boton.Grid.ColumnResult := 1;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' select cod_operador_eca, cod_almacen_eca, des_almacen_eca ' +
          ' from frf_env_comer_almacenes ');
        if (Length(Params) = 1) and
          (Trim(Params[0]) <> '') then
          DMBaseDatos.QDespegables.Sql.Add(' where cod_operador_eca = ' + QuotedStr(Params[0]));
        DMBaseDatos.QDespegables.Sql.Add(' order by 1,2 ');
      end;
    kEnvComerProducto:
      begin
        boton.Grid.ColumnResult := 1;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' select cod_operador_ecp, cod_producto_ecp, des_producto_ecp ' +
          ' from frf_env_comer_productos ');
        if (Length(Params) = 1) and
          (Trim(Params[0]) <> '') then
          DMBaseDatos.QDespegables.Sql.Add(' where cod_operador_ecp = ' + QuotedStr(Params[0]));
        DMBaseDatos.QDespegables.Sql.Add(' order by 1,2 ');
      end;
    kCategoria:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;

        sAux:= Params[1];
        DMBaseDatos.QDespegables.SQL.Clear;
        if (Length(Params) = 2) and
          (Trim(Params[0]) <> '') and
          (Trim(sAux) <> '') then
          DMBaseDatos.QDespegables.SQL.Add(' SELECT categoria_c, descripcion_c ' +
            '  FROM frf_categorias ' +
            ' WHERE producto_c = ' + QuotedStr(sAux) +
            ' ORDER BY categoria_c ');
      end;

    kCategoriaPBase:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;

        if TryStrToInt( Params[1], iAux ) then
        begin
          DMBaseDatos.QAux.SQL.Clear;
          DMBaseDatos.QAux.SQL.Add(' select max(producto_p) producto_p from frf_productos ' +
                    ' where producto_base_p=' + Params[1] );
          DMBaseDatos.QAux.Open;
          sAux:= DMBaseDatos.QAux.Fields[0].AsString;
          DMBaseDatos.QAux.Close;
        end
        else
        begin
          sAux:= Params[1];
        end;

        DMBaseDatos.QDespegables.SQL.Clear;
        if (Length(Params) = 2) and
          (Trim(Params[0]) <> '') and
          (Trim(sAux) <> '') then
          DMBaseDatos.QDespegables.SQL.Add(' SELECT DISTINCT categoria_c, descripcion_c ' +
            ' FROM frf_categorias ' +
            ' WHERE producto_c = ' + QuotedStr(sAux) +
            ' ORDER BY categoria_c ');
      end;
    kCalibre:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;

        sAux:= Params[1];

        DMBaseDatos.QDespegables.SQL.Clear;
        if (Length(Params) = 2) and
          (Trim(Params[0]) <> '') and
          (Trim(sAux) <> '') then
          DMBaseDatos.QDespegables.SQL.Add(' SELECT DISTINCT calibre_c ' +
            ' FROM frf_calibres ' +
            ' WHERE producto_c = ' + QuotedStr(sAux) +
            ' ORDER BY calibre_c');
      end;
    kCalibrePBase:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;

        if TryStrToInt( Params[1], iAux ) then
        begin
          DMBaseDatos.QAux.SQL.Clear;
          DMBaseDatos.QAux.SQL.Add(' select max(producto_p) producto_p from frf_productos ' +
                    ' where producto_base_p=' + Params[1] );
          DMBaseDatos.QAux.Open;
          sAux:= DMBaseDatos.QAux.Fields[0].AsString;
          DMBaseDatos.QAux.Close;
        end
        else
        begin
          sAux:= Params[1];
        end;

        DMBaseDatos.QDespegables.SQL.Clear;
        if (Length(Params) = 2) and
          (Trim(Params[0]) <> '') and
          (Trim(sAux) <> '') then
          DMBaseDatos.QDespegables.SQL.Add(' SELECT DISTINCT calibre_c ' +
            ' FROM frf_calibres ' +
            ' WHERE producto_c = ' + QuotedStr(sAux) +
            ' ORDER BY calibre_c');
      end;
    kCosechero:
      begin
        boton.Grid.ColumnResult := 1;
        boton.Grid.ColumnFind := 2;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' SELECT empresa_c, cosechero_c, nombre_c ' +
          ' FROM frf_cosecheros Frf_cosecheros ');
        if (Length(Params) = 1) and
          (Trim(Params[0]) <> '') then
        begin
          if params[0] = 'BAG' then
            DMBaseDatos.QDespegables.Sql.Add(' WHERE substr(empresa_c,1,1) = ''F'' ' )
          else
          if params[0] = 'SAT' then
             DMBaseDatos.QDespegables.Sql.Add(' WHERE ( empresa_c = ''080'' or empresa_c = ''050'' ) ' )
          else
            DMBaseDatos.QDespegables.SQL.Add(' WHERE empresa_c= ' + QuotedStr(Params[0]));
        end;
        DMBaseDatos.QDespegables.SQL.Add(' GROUP BY empresa_c, cosechero_c, nombre_c ORDER BY empresa_c, nombre_c ');
      end;
    kPlantacion:
      begin
        boton.Grid.ColumnResult := 3;
        boton.Grid.ColumnFind := 4;
        DMBaseDatos.QDespegables.SQL.Clear;

        DMBaseDatos.QDespegables.SQL.Add(' select empresa_p, producto_p, cosechero_p, plantacion_p, descripcion_p ');
        DMBaseDatos.QDespegables.SQL.Add(' from frf_plantaciones ');
        sAux:= ' where fecha_fin_p is null ';
        sAux:= WhereAddStringEmpresa( sAux, 'empresa_p', params[0], true );
        sAux:= WhereAddString( sAux, 'producto_p', params[1], true );
        sAux:= WhereAddString( sAux, 'cosechero_p', params[2], true );
        DMBaseDatos.QDespegables.SQL.Add( sAux );
        DMBaseDatos.QDespegables.SQL.Add( ' order by empresa_p, producto_p, cosechero_p, plantacion_p ' );
      end;
    kProductor:
      begin
        boton.Grid.ColumnResult := 1;
        boton.Grid.ColumnFind := 2;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' SELECT empresa_c, cosechero_c, nombre_c ' +
          ' FROM frf_cosecheros Frf_cosecheros ');
                //DMBaseDatos.QDespegables.SQL.Add(' where pertenece_grupo_c <> ''S'' ');
        if (Length(Params) = 1) and
          (Trim(Params[0]) <> '') then
          begin
            if params[0] = 'BAG' then
              DMBaseDatos.QDespegables.Sql.Add(' WHERE substr(empresa_c,1,1) = ''F'' ' )
            else
            if params[0] = 'SAT' then
              DMBaseDatos.QDespegables.Sql.Add(' WHERE ( empresa_c = ''080'' or empresa_c = ''050'' ) ' )
            else
              DMBaseDatos.QDespegables.SQL.Add(' where empresa_c= ' + QuotedStr(Params[0]));
          end;
        DMBaseDatos.QDespegables.SQL.Add(' GROUP BY empresa_c, cosechero_c, nombre_c ORDER BY empresa_c, nombre_c ');
      end;
    kProveedor:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 2;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' SELECT proveedor_p, nombre_p ' +
          ' FROM frf_proveedores ');
        DMBaseDatos.QDespegables.SQL.Add(' ORDER BY proveedor_p ');
      end;

    kProveedorAlmacen:
      begin
        boton.Grid.ColumnResult := 1;
        boton.Grid.ColumnFind := 2;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' SELECT proveedor_pa, almacen_pa, nombre_pa FROM frf_proveedores_almacen ');
        DMBaseDatos.QDespegables.SQL.Add( WhereSQL(['sproveedor_pa'],params) );
        (*
        if (Length(Params) = 2) then
        begin
          if (Trim(Params[0]) <> '') and (Trim(Params[1]) <> '') then
          begin
             DMBaseDatos.QDespegables.SQL.Add(' where = ' + QuotedStr(Params[0]));
             DMBaseDatos.QDespegables.SQL.Add(' and = ' + QuotedStr(Params[1]));
          end
          else
          if (Trim(Params[0]) <> '') then
          begin
             DMBaseDatos.QDespegables.SQL.Add(' where empresa_pa= ' + QuotedStr(Params[0]));
          end
          else
          if ( Trim(Params[1]) <> '') then
          begin
             DMBaseDatos.QDespegables.SQL.Add(' and proveedor_pa= ' + QuotedStr(Params[1]));
          end;
        end;
        *)
        DMBaseDatos.QDespegables.SQL.Add(' ORDER BY proveedor_pa, almacen_pa ');
      end;

    kTransportista:
      begin
        boton.Grid.ColumnResult := 1;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' SELECT transporte_t, descripcion_t ' +
          ' FROM frf_transportistas ');
        DMBaseDatos.QDespegables.SQL.Add(' GROUP BY transporte_t, descripcion_t ORDER BY descripcion_t ');
      end;
    kCamion:
      begin
        boton.Grid.ColumnResult := 1;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' SELECT camion_c, descripcion_c ' +
          ' FROM frf_camiones ');
        DMBaseDatos.QDespegables.SQL.Add(' GROUP BY camion_c, descripcion_c ORDER BY descripcion_c ');
      end;
    kEstructura:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT tipo_c, descripcion_c ' +
          ' FROM frf_campos  ' +
          ' WHERE campo_c = ' + QuotedStr('ESTRUCTURA') +
          ' ORDER BY descripcion_c ');
      end;
    kCultivo:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT tipo_c, descripcion_c ' +
          ' FROM frf_campos  ' +
          ' WHERE campo_c = ' + QuotedStr('CULTIVO') +
          ' ORDER BY descripcion_c ');
      end;
    kSustrato:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT tipo_c, descripcion_c ' +
          ' FROM frf_campos  ' +
          ' WHERE campo_c = ' + QuotedStr('SUSTRATO') +
          ' ORDER BY descripcion_c ');
      end;
    kVariedad:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT tipo_c, descripcion_c ' +
          ' FROM frf_campos  ' +
          ' WHERE campo_c = ' + QuotedStr('VARIEDAD') +
          ' ORDER BY descripcion_c ');
      end;
    kCliente:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT cliente_c, nombre_c ' +
          ' FROM frf_clientes ');
        DMBaseDatos.QDespegables.Sql.Add(' GROUP BY cliente_c, nombre_c ORDER BY cliente_c ');
      end;
    kTipoCliente:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' select codigo_ctp codigo, descripcion_ctp descripcion from frf_cliente_tipos ');
        DMBaseDatos.QDespegables.Sql.Add(' ORDER BY codigo_ctp ');
      end;
    kComercial:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' select codigo_c, descripcion_c from frf_comerciales order by  codigo_c ');
      end;

    kSuministro:
      begin
        boton.Grid.ColumnResult := 1;
        boton.Grid.ColumnFind := 3;
        DMBaseDatos.QDespegables.Sql.Clear;

        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT cliente_ds,dir_sum_ds, nombre_ds, poblacion_ds ' +
          ' FROM frf_dir_sum ');
        flag := false;

        DMBaseDatos.QDespegables.Sql.Add(' WHERE   (cliente_ds = ' + QuotedStr(Params[0]) + ')');
        DMBaseDatos.QDespegables.Sql.Add(' GROUP BY cliente_ds,dir_sum_ds, nombre_ds, poblacion_ds  ORDER BY nombre_ds ');
      end;
    kBanco:
      begin
        DMBaseDatos.QDespegables.Sql.Clear;
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT banco_b, descripcion_b' +
            ' FROM frf_bancos  ' +
            ' ORDER BY descripcion_b ')
      end;
    kImpuesto:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT codigo_i, descripcion_i ' +
          ' FROM frf_impuestos  ' +
          ' ORDER BY descripcion_i ');
      end;
    kProductoBase:
      begin
        boton.Grid.ColumnResult := 1;
        boton.Grid.ColumnFind := 2;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.Sql.Add(
          ' SELECT DISTINCT empresa_pb, producto_base_pb ,descripcion_pb ' +
          ' FROM frf_productos_base  ');
        if (Length(Params) = 1) and
          (Trim(Params[0]) <> '') then
        begin
            if params[0] = 'BAG' then
              DMBaseDatos.QDespegables.Sql.Add(' WHERE substr(empresa_pb,1,1) = ''F'' ' )
            else
            if params[0] = 'SAT' then
              DMBaseDatos.QDespegables.Sql.Add(' WHERE ( empresa_pb = ''080'' or empresa_pb = ''050'' ) ' )
            else
             DMBaseDatos.QDespegables.SQL.Add(' WHERE empresa_pb= ' + QuotedStr(Params[0]));
        end;
        DMBaseDatos.QDespegables.SQL.Add(' GROUP BY empresa_pb, producto_base_pb ,descripcion_pb ORDER BY descripcion_pb ');
      end;
    kTipoUnidad:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 0;
        DMBaseDatos.QDespegables.Sql.Clear;
        if (Length(Params) = 2) then
        begin
          if (Trim(Params[0]) <> '') then
          begin
            if (Trim(Params[1]) <> '') then
            begin
              DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT codigo_uc ,descripcion1_uc ' +
                ' FROM frf_und_consumo  ' +
                ' WHERE empresa_uc = ' + QuotedStr(Params[0]) +
                ' and producto_uc = ' + QuotedStr(Params[1]) +
                ' and fecha_baja_uc is null ' +
                ' ORDER BY codigo_uc, descripcion1_uc');
            end
            else
            begin
              DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT codigo_uc ,descripcion1_uc ' +
                ' FROM frf_und_consumo  ' +
                ' WHERE empresa_uc = ' + QuotedStr(Params[0]) +
                ' and fecha_baja_uc is null ' +
                ' ORDER BY codigo_uc, descripcion1_uc');
            end;
          end
          else
          begin
            DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT codigo_uc ,descripcion1_uc ' +
              ' FROM frf_und_consumo  ' +
              ' where fecha_baja_uc is null ' +
              ' ORDER BY codigo_uc, descripcion1_uc');
          end;
        end
        else
        if (Length(Params) = 1) and (Trim(Params[0]) <> '') then
        begin
          DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT codigo_uc ,descripcion1_uc ' +
            ' FROM frf_und_consumo  ' +
            ' WHERE empresa_uc = ' + QuotedStr(Params[0]) +
            ' and fecha_baja_uc is null ' +
            ' ORDER BY codigo_uc, descripcion1_uc');
        end
        else
        begin
          DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT codigo_uc ,descripcion1_uc ' +
            ' FROM frf_und_consumo  ' +
            ' where fecha_baja_uc is null ' +
            ' ORDER BY codigo_uc, descripcion1_uc');
        end;
      end;
    kCalibreBase:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 0;
        DMBaseDatos.QDespegables.Sql.Clear;
        if (Length(Params) = 2) and
          (Trim(Params[0]) <> '') and
          (Trim(Params[1]) <> '') then
          DMBaseDatos.QDespegables.Sql.Add(' SELECT calibre_c ' +
            ' FROM   frf_calibres, frf_productos ' +
            ' WHERE  producto_base_p = ' + params[1] +
            ' AND    producto_c = producto_p ');
      end;
    kSeccionContable:
      begin
        DMBaseDatos.QDespegables.Sql.Clear;
        if (Length(Params) = 1) and (Trim(Params[0]) <> '') then
        begin
          boton.Grid.ColumnResult := 1;
          boton.Grid.ColumnFind := 2;
          (*PARCHE 17-01-2007*)
          (*para visualizar las secciones contables ventas a terceros en despegable facturas/abonos manuales *)
          if Params[0] = '050' then
          begin
            DMBaseDatos.QDespegables.Sql.Add(' select ''050'', sec_contable_sc, max(descripcion_sc) ');
            DMBaseDatos.QDespegables.Sql.Add(' from frf_secc_contables ');
            DMBaseDatos.QDespegables.Sql.Add(' WHERE empresa_sc in (''050'',''501'') ');
            DMBaseDatos.QDespegables.Sql.Add(' group by 1,2 ');
            DMBaseDatos.QDespegables.Sql.Add(' order by 1,2 ');
          end
          else
          begin
            DMBaseDatos.QDespegables.Sql.Add(' select empresa_sc, sec_contable_sc, max(descripcion_sc) ');
            DMBaseDatos.QDespegables.Sql.Add(' from frf_secc_contables ');
            DMBaseDatos.QDespegables.Sql.Add(' WHERE empresa_sc=' + QuotedStr(Params[0]) );
            DMBaseDatos.QDespegables.Sql.Add(' group by 1,2 ');
            DMBaseDatos.QDespegables.Sql.Add(' order by 1,2 ');
          end;
        end
        else
        begin
          boton.Grid.ColumnResult := 1;
          boton.Grid.ColumnFind := 2;
          DMBaseDatos.QDespegables.Sql.Add(' select empresa_sc, sec_contable_sc, max(descripcion_sc) ');
          DMBaseDatos.QDespegables.Sql.Add(' from frf_secc_contables ');
          DMBaseDatos.QDespegables.Sql.Add(' group by 1,2 ');
          DMBaseDatos.QDespegables.Sql.Add(' order by 1,2 ');
        end;
      end;
    kAduana:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT codigo_a, descripcion_a ' +
          ' FROM frf_aduanas ORDER BY codigo_a ');
      end;
    kTipoCaja:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.Sql.Clear;
        DMBaseDatos.QDespegables.Sql.Add(' select codigo_tc, descripcion_tc from frf_tipos_caja order by 1 ');
      end;
    kEan13Unidad:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;

        sAux:= '';
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' select codigo_e, descripcion_e from frf_ean13 ');

        sAux:= ' where agrupacion_e = 1 ';
        if Params[0] <> '' then
        begin
          sAux:= sAux + '  and empresa_e = ' + QuotedStr( Params[0] ) + ' ';
        end;
        if Params[1] <> '' then
        begin
          sAux:= sAux + '  and envase_e = ' + QuotedStr( Params[1] ) + ' ';
        end;
        sAux:= sAux + ' and fecha_baja_e is null ';

        DMBaseDatos.QDespegables.SQL.Add( sAux );
        DMBaseDatos.QDespegables.SQL.Add(' order by descripcion_e ');

      end;
    kEan13Envase:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;

        sAux:= '';
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' select codigo_e, descripcion_e from frf_ean13 ');

        sAux:= ' where agrupacion_e = 2 ';
        if Params[0] <> '' then
        begin
          sAux:= sAux + '  and empresa_e = ' + QuotedStr( Params[0] ) + ' ';
        end;
        if Params[1] <> '' then
        begin
          sAux:= sAux + '  and envase_e = ' + QuotedStr( Params[1] ) + ' ';
        end;
        sAux:= sAux + ' and fecha_baja_e is null ';

        DMBaseDatos.QDespegables.SQL.Add( sAux );
        DMBaseDatos.QDespegables.SQL.Add(' order by descripcion_e ');

      end;
    kIncoterm:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' select codigo_i, UPPER(descripcion_i), UPPER(descripcion_es_i) ');
        DMBaseDatos.QDespegables.SQL.Add(' from frf_incoterms ');
        DMBaseDatos.QDespegables.SQL.Add(' order by 1 ');
      end;
    kAgrupacionEnvase:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 0;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' select agrupacion_ae ');
        DMBaseDatos.QDespegables.SQL.Add(' from frf_agrupaciones_envase ');
        DMBaseDatos.QDespegables.SQL.Add(' order by agrupacion_ae ');
      end;
    kAgrupacionComercial:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 0;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' select agrupacion_ac ');
        DMBaseDatos.QDespegables.SQL.Add(' from frf_agrupa_comerciales ');
        DMBaseDatos.QDespegables.SQL.Add(' order by agrupacion_ac ');
      end;
    kAgrupacionGasto:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 0;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' select agrupacion_ag ');
        DMBaseDatos.QDespegables.SQL.Add(' from frf_agrupaciones_gasto ');
        DMBaseDatos.QDespegables.SQL.Add(' order by agrupacion_ag ');
      end;
    kLineaProducto:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' select linea_producto_lp, descripcion_lp  ');
        DMBaseDatos.QDespegables.SQL.Add(' from frf_linea_productos ');
        DMBaseDatos.QDespegables.SQL.Add(' order by descripcion_lp ');
      end;
    kAgrupacion:
      begin
        boton.Grid.ColumnResult := 0;
        boton.Grid.ColumnFind := 1;
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(' select DISTINCT codigo_a, nombre_a  ');
        DMBaseDatos.QDespegables.SQL.Add(' from frf_agrupacion ');
        DMBaseDatos.QDespegables.SQL.Add(' order by 1 ');
      end;
    kOtros:
      begin
        DMBaseDatos.QDespegables.SQL.Clear;
        DMBaseDatos.QDespegables.SQL.Add(QUERY);
      end;
  end;

     //Abre consulta
  try
    DMBaseDatos.QDespegables.Open;
  except
    ShowError('Error al mostrar los datos.');
    ConsultaRejilla := false;
    Exit;
  end;
     //Tiene valores
  if DMBaseDatos.QDespegables.IsEmpty then
  begin
    ShowError('Consulta sin datos.');
    ConsultaRejilla := False;
  end;
end;

function KilosEnvase(const empresa, envase, producto: string): Real;
begin
  KilosEnvase := 0;
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select peso_neto_e from frf_envases ');
    SQL.Add(' where envase_e = :envase ');
    SQL.Add(' and producto_e = :producto ');
    ParamByName('envase').asstring := envase;
    ParamByName('producto').asstring := producto;
    Open;

    if isEmpty then Exit;
    KilosEnvase := Fields[0].asfloat;
    Close;
  end;
end;

function EnvasePesoVariable(const empresa, envase, producto: string): Boolean;
begin
  result:= True;
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select peso_neto_e, peso_variable_e ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where envase_e=:envase ');
    SQL.Add(' and producto_e=:producto');
    ParamByName('envase').asstring := envase;
    ParamByName('producto').asstring := producto;
    Open;

    if not isEmpty then
    begin
//      result:= ( FieldByName('peso_neto_e').AsFloat = 0 ) or (FieldByName('peso_variable_e').Asinteger <> 0 );
      result:= FieldByName('peso_variable_e').Asinteger = 1;
    end;
    Close;
  end;
end;

//funcion que comprueba si el envase filtrado por los parámetros tiene sobrepeso
//si tiene sobrepeso devuelve el valor y si no un -1
function EnvaseObtenerSobrepeso(const empresa, envase : string; const anyo, mes : integer): real;
var
  env_sobrepeso : real;
  qAux : TQuery;
begin
  env_sobrepeso := -1;
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    sql.Clear;
    sql.Add('select peso_es ');
    sql.Add('from frf_env_sobrepeso ');
    sql.Add('where empresa_es = :empresa ');
    sql.Add(' and anyo_es = :anyo ');
    sql.Add(' and mes_es = :mes ');
    sql.Add(' and envase_es = :envase ');
    ParamByName('empresa').AsString := empresa;
    ParamByName('anyo').AsInteger := anyo;
    ParamByName('mes').AsInteger := mes;
    ParamByName('envase').AsString := envase;
    Open;

    if not isEmpty then
      env_sobrepeso := FieldByName('peso_es').AsFloat;
  end;
  result := env_sobrepeso;
end;

function EnvaseUnidadesVariable(const empresa, envase, producto: string): Boolean;
begin
  result:= True;
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select unidades_e, unidades_variable_e ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where envase_e= :envase ');
    SQL.Add(' and producto_e=:producto');
    ParamByName('envase').asstring := envase;
    ParamByName('producto').asstring := producto;
    Open;

    if not isEmpty then
    begin
      result:= ( FieldByName('unidades_e').Asinteger = 0 ) or (FieldByName('unidades_variable_e').Asinteger <> 0 );
    end;
    Close;
  end;
end;

function UnidadesEnvase(const AEmpresa, AEnvase, AProducto: string ): Integer;
begin
  result := 1;
  with DMBaseDatos.QAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select unidades_e from frf_envases where envase_e=:envase ');
    SQL.Add('    and producto_e=:producto ');
    ParamByName('envase').asstring := AEnvase;
    ParamByName('producto').asstring := AProducto;

    Open;
    try
      if not isEmpty then
        if FieldByName('unidades_e').asInteger > 1 then
          result := FieldByName('unidades_e').asInteger;
    finally
      Close;
    end;
  end;
end;

//se diferencia de la otra por que dev -1 si unidades variables
function UnidadesEnvaseEx(const AEmpresa, AEnvase, AProducto: string ): Integer;
begin
  result := 0;
  with DMBaseDatos.QAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select unidades_e, unidades_variable_e from frf_envases where envase_e=:envase ');
    SQL.Add('    and producto_e=:producto');
    ParamByName('envase').asstring := AEnvase;
    ParamByName('producto').asstring := AProducto;

    Open;
    try
      if not isEmpty then
      begin
        if FieldByName('unidades_variable_e').asInteger <> 1 then
        begin
          result := FieldByName('unidades_e').asInteger;
        end
        else
        begin
          result := -1;
        end;
      end;
    finally
      Close;
    end;
  end;
end;

function unidadFacturacion(const empresa, cliente, producto, envase: string): string;
begin

  result := 'KGS';
  if producto <> '' then
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select unidad_fac_ce from frf_clientes_env ' +
      ' where empresa_ce=' + QuotedStr(empresa) +
      ' and cliente_ce=' + QuotedStr(cliente) +
      ' and producto_ce=' + QuotedStr(producto) +
      ' and envase_ce=' + QuotedStr(envase);
    try
      try
        Open;
      except
        showMessage('Unidad de facturacion incorrecta: ' + empresa + '-' + cliente + '-' + producto + '-' + envase );
      end;
      if not IsEmpty then
      begin
          if fields[0].AsString = 'U' then
          begin
            result := 'UND';
          end
          else
          if fields[0].AsString = 'C' then
          begin
            result := 'CAJ';
          end;
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

end.

