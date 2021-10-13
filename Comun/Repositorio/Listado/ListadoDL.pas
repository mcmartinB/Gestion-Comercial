(* CAMBIAR
   ListadoDL, DLListado, QListado
   RParametrosListado
*)

unit ListadoDL;

interface

uses
  SysUtils, Classes, DBTables, DB, EntregasCB;

const
  kDepurarQuery = False;

type
  RParametrosListado = record
    sEmpresa: String;
    dFechaDesde: TDateTime;
    dFechaHasta: TDateTime;
  end;

  TDLListado = class(TDataModule)
    QListado: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ObtenerDatos( AParametros: RParametrosListado );
  end;


procedure LoadModule( APadre: TComponent );
procedure UnloadModule;
function  OpenData( APadre: TComponent; AParametros: RParametrosListado ): integer;

implementation

uses Math;

{$R *.dfm}

var
  DLListado: TDLListado;
  iContadorUso: integer = 0;

procedure LoadModule( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      DLListado:= TDLListado.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
end;

procedure UnloadModule;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if DLListado <> nil then
      begin
        FreeAndNil( DLListado );
      end;
    end;
  end;
end;

function OpenData( APadre: TComponent; AParametros: RParametrosListado ): integer;
begin
  LoadModule( APadre );
  DLListado.ObtenerDatos( AParametros );
  result:= DLListado.QListado.RecordCount;
  UnLoadModule;
end;

function GetTextoSQL( AParametros: RParametrosListado ): String;
var
  sCadena: TStringList;
begin
  sCadena:= TStringList.Create;
  sCadena.Add( ' SELECT * ' );
  sCadena.Add( ' FROM frf_bancos ' );
  sCadena.Add( ' Where empresa = ' + QuotedStr( AParametros.sEmpresa ) );
  sCadena.Add( ' and fecha between :fechaini and :fechafin ' );
  sCadena.Add( ' ORDER BY  ' );
  try
    if kDepurarQuery then
      sCadena.SaveToFile( 'c:\temp\QListado.sql' );
  except
    //NO hacemos nada, en caso de error seguramente sera por que no existe la ruta
  end;
  result:= sCadena.Text;
  FreeAndNil( sCadena );
end;

procedure TDLListado.ObtenerDatos( AParametros: RParametrosListado );
begin
  QListado.Close;
  QListado.SQL.Clear;
  QListado.SQL.Text:= GetTextoSQL( AParametros );
  QListado.ParamByName('fechaini').AsDate:= AParametros.dFechaDesde;
  QListado.ParamByName('fechafin').AsDate:= AParametros.dFechaHasta;
  QListado.Open;
end;

end.
