unit ConexionInformix;

interface

uses
  Classes,
  DBTables;

type
  TConexionInformix = class(TDatabase)

  private

  public
    constructor Create(AOwner: TComponent; ASession: TSession = nil); reintroduce; overload;
    constructor Create(AOwner: TComponent; ADatabase: TDatabase; ASession: TSession = nil); reintroduce; overload;
    destructor Destroy; override;

    function NewQuery(AOwner: TComponent): TQuery;

    function Clonar: TConexionInformix;

    procedure BeginWork;
    procedure Commit;
    procedure Rollback;
  end;

implementation

uses
  SysUtils,
  ConexionInformixConstantes;

var
  NumBaseDatos: Integer = 0;

{ TConexionInformix }

procedure TConexionInformix.BeginWork;
begin
  Execute('begin work');
end;

function TConexionInformix.Clonar: TConexionInformix;
begin
  Result := TConexionInformix.Create(nil);
  Result.Params.Assign(Self.Params);
end;

procedure TConexionInformix.Commit;
begin
  Execute('commit');
end;

constructor TConexionInformix.Create(AOwner: TComponent; ADatabase: TDatabase; ASession: TSession = nil);
begin
  inherited Create(AOwner);

  Inc(NumBaseDatos);
  DatabaseName := Format('SincroWeb%d', [ NumBaseDatos ]);
  DriverName := 'INFORMIX';
  LoginPrompt := False;

  Params.Add(Format('SERVER NAME=%s', [ ADatabase.Params.values['SERVER NAME']]));
  Params.Add(Format('DATABASE NAME=%s', [ ADatabase.Params.values['DATABASE NAME'] ]));
  Params.Add(Format('USER NAME=%s', [ ADatabase.Params.values['USER NAME'] ]));
  Params.Add(Format('PASSWORD=%s', [ ADatabase.Params.values['PASSWORD'] ]));
  Params.Add('OPEN MODE=READ/WRITE');
  Params.Add('SCHEMA CACHE SIZE=8');
  Params.Add('LANGDRIVER=DB850ES0');
  Params.Add('SQLQRYMODE=SERVER');
  Params.Add('SQLPASSTHRU MODE=SHARED AUTOCOMMIT');
  Params.Add('LOCK MODE=5');
  Params.Add('DATE MODE=0');
  Params.Add('DATE SEPARATOR=/');
  Params.Add('SCHEMA CACHE TIME=-1');
  Params.Add('MAX ROWS=-1');
  Params.Add('BATCH COUNT=200');
  Params.Add('ENABLE SCHEMA CACHE=FALSE');
  Params.Add('SCHEMA CACHE DIR=');
  Params.Add('ENABLE BCD=FALSE');
  Params.Add('LIST SYNONYMS=NONE');
  Params.Add('DBNLS=');
  Params.Add('COLLCHAR=');
  Params.Add('BLOBS TO CACHE=64');
  Params.Add('BLOB SIZE=32');

  if ASession <> nil then
    SessionName := ASession.SessionName;
end;

constructor TConexionInformix.Create(AOwner: TComponent; ASession: TSession = nil);
begin
  inherited Create(AOwner);

  Inc(NumBaseDatos);
  DatabaseName := Format('SincroWeb%d', [ NumBaseDatos ]);
  DriverName := 'INFORMIX';
  LoginPrompt := False;

  Params.Add(Format('SERVER NAME=%s', [ _INFORMIX_HOST_ ]));
  Params.Add(Format('DATABASE NAME=%s', [ _INFORMIX_DATABASE_ ]));
  Params.Add(Format('USER NAME=%s', [ _INFORMIX_USER_ ]));
  Params.Add(Format('PASSWORD=%s', [ _INFORMIX_PASSWORD_ ]));
  Params.Add('OPEN MODE=READ/WRITE');
  Params.Add('SCHEMA CACHE SIZE=8');
  Params.Add('LANGDRIVER=DB850ES0');
  Params.Add('SQLQRYMODE=SERVER');
  Params.Add('SQLPASSTHRU MODE=SHARED AUTOCOMMIT');
  Params.Add('LOCK MODE=5');
  Params.Add('DATE MODE=0');
  Params.Add('DATE SEPARATOR=/');
  Params.Add('SCHEMA CACHE TIME=-1');
  Params.Add('MAX ROWS=-1');
  Params.Add('BATCH COUNT=200');
  Params.Add('ENABLE SCHEMA CACHE=FALSE');
  Params.Add('SCHEMA CACHE DIR=');
  Params.Add('ENABLE BCD=FALSE');
  Params.Add('LIST SYNONYMS=NONE');
  Params.Add('DBNLS=');
  Params.Add('COLLCHAR=');
  Params.Add('BLOBS TO CACHE=64');
  Params.Add('BLOB SIZE=32');

  if ASession <> nil then
    SessionName := ASession.SessionName;
end;

destructor TConexionInformix.Destroy;
begin
  inherited;
end;

function TConexionInformix.NewQuery(AOwner: TComponent): TQuery;
begin
  Result := TQuery.Create(AOwner);
  Result.DatabaseName := Self.DatabaseName;
  Result.SessionName := Self.SessionName;
end;

procedure TConexionInformix.Rollback;
begin
  Execute('rollback');
end;

end.
