unit LiqProdErroresUnit;

interface

uses
  Classes, SysUtils, DBTables;

const

  kelNoCosteEnvasado = 1;
  kelNoCostePresupuesto = 2;

  aelErrores : array[kelNoCosteEnvasado..kelNoCostePresupuesto] of string =
    ('Falta grabar costes de envasado',
     'Falta grabar presupuesto costes de envasado');

var
  ArrayErrores: TStringList;
  qryErrores: TQuery;

procedure InicializaMotorErrores;
procedure FinalizaMotorErrores;
procedure InicializaErrores( const ACodigo: integer );
procedure PutError( const AError: integer; const AMsg: string );
function  HayErrores: integer;
function  GrabarErrores( const ACodigo: integer ): integer;
procedure BorrarErrores( const ACodigo: integer );
procedure ImprimirErrores(const AEmpresa, ACentro, AProducto: string; const ADesde, AHasta: TDateTime );

implementation

uses
  LiqProdErroresQR;

var
  iCodigo: integer= -1;


procedure InicializaMotorErrores;
begin
  ArrayErrores:=  TStringList.Create;
end;

procedure FinalizaMotorErrores;
begin
  FreeAndNil( ArrayErrores );
end;

procedure InicializaErrores( const ACodigo: integer );
begin
  iCodigo:= ACodigo;
  ArrayErrores.Clear;
end;

procedure PutError( const AError: integer; const AMsg: string );
var
  sAux: string;
begin
  sAux:= aelErrores[ AError ] +  ' -> ' + AMsg;
  if Pos( sAux, ArrayErrores.Text ) = 0 then
    ArrayErrores.Add( sAux );
end;

function  HayErrores: integer;
begin
  if ArrayErrores.Count > 0 then
    result:= 1
  else
    result:= 0;
end;

procedure BorrarErrores( const ACodigo: integer );
begin
  qryErrores:= TQuery.Create( nil );
  qryErrores.DatabaseName:= 'BDProyecto';
  qryErrores.sql.clear;
  qryErrores.sql.Add('delete from tliq_errores where codigo = :codigo');
  qryErrores.ParamByName('codigo').AsInteger:= ACodigo;
  try
    qryErrores.ExecSql;
  finally
    freeAndnil( qryErrores );
  end;
end;

function  GrabarErrores( const ACodigo: integer ): integer;
var
  iCount: integer;
begin
  if ArrayErrores.Count > 0 then
  begin
    result:= 1;
    qryErrores:= TQuery.Create( nil );
    qryErrores.RequestLive:= true;
    qryErrores.DatabaseName:= 'BDProyecto';
    qryErrores.sql.clear;
    //qryErrores.sql.Add('insert into tliq_errores (:codigo, :linea, :message ) ');
    qryErrores.sql.Add('select * from tliq_errores  ');
    qryErrores.Open;

    iCount:= 0;
    try
      while iCount < ArrayErrores.Count do
      begin
        qryErrores.Insert;
        //qryErrores.ParamByName('message').AsString:= ArrayErrores[iCount];
        qryErrores.FieldByName('error').AsString:= ArrayErrores[iCount];
        Inc( iCount );
        //qryErrores.ParamByName('codigo').AsInteger:= ACodigo;
        qryErrores.FieldByName('codigo').AsInteger:= ACodigo;
        //qryErrores.ParamByName('linea').AsInteger:= iCount;
        qryErrores.FieldByName('linea').AsInteger:= iCount;
        //qryErrores.ExecSql;
        qryErrores.Post;
      end;
    finally
      qryErrores.Close;
      freeAndnil( qryErrores );
    end;
  end
  else
  begin
    result:= 0;
  end;
end;

procedure  ImprimirErrores(const AEmpresa, ACentro, AProducto: string; const ADesde, AHasta: TDateTime );

var
  iCount: integer;
begin
    qryErrores:= TQuery.Create( nil );
    qryErrores.DatabaseName:= 'BDProyecto';
    qryErrores.sql.clear;
    qryErrores.sql.Add(' select   ');
    qryErrores.sql.Add('         tliq_semanas.codigo codigo, empresa, centro, producto, semana, fecha_ini, ');
    qryErrores.sql.Add('         linea, error ');
    qryErrores.sql.Add(' from tliq_semanas  ');
    qryErrores.sql.Add('       join tliq_errores on tliq_semanas.codigo = tliq_errores.codigo  ');
    qryErrores.sql.Add(' where empresa = :empresa  ');
    if ACentro <> '' then
      qryErrores.sql.Add('   and centro = :centro  ');
    qryErrores.sql.Add('   and fecha_ini between :fechaini and :fechafin  ');
    if AProducto <> '' then
      qryErrores.sql.Add('   and producto = :producto  ');
    qryErrores.sql.Add(' order by codigo, linea ');

    qryErrores.ParamByName('empresa').AsString:= AEmpresa;
    qryErrores.ParamByName('fechaini').AsDateTime:= ADesde;
    qryErrores.ParamByName('fechafin').AsDateTime:= AHasta;
    if ACentro <> '' then
      qryErrores.ParamByName('centro').AsString:= ACentro;
    if AProducto <> '' then
      qryErrores.ParamByName('producto').AsString:= AProducto;

    qryErrores.Open;

    try
      if not qryErrores.isempty then
      begin
        LiqProdErroresQR.Imprimir( ADesde, AHasta, qryErrores );
      end;
    finally
      qryErrores.Close;
      freeAndnil( qryErrores );
    end;
end;

end.
