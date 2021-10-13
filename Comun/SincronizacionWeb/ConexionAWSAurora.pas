unit ConexionAWSAurora;

interface

uses
  Classes,
  SqlExpr,
  SimpleDS;

type
  TConexionAWSAurora = class(TSQLConnection)

  private
    FQTimeStamp: TSQLQuery;

  public
    constructor Create(AOwner: TComponent = nil); reintroduce;
    destructor Destroy; override;

    function NewSQLQuery(AOwner: TComponent = nil): TSQLQuery;
    function NewSimpleDataset(AOwner: TComponent = nil): TSimpleDataset;

    function Clonar: TConexionAWSAurora;

    function GetCurrentTimestamp: TDateTime;

    procedure BeginWork;
    procedure Commit;
    procedure Rollback;
  end;

implementation

uses
  SysUtils,
  ConexionAWSAuroraConstantes;

{ TConexionAWSAurora }

procedure TConexionAWSAurora.BeginWork;
begin
  ExecuteDirect('begin work');
end;

function TConexionAWSAurora.Clonar: TConexionAWSAurora;
begin
  Result := TConexionAWSAurora.Create(nil);
  Result.Params.Assign(Self.Params);
end;

procedure TConexionAWSAurora.Commit;
begin
  ExecuteDirect('commit');
end;

constructor TConexionAWSAurora.Create(AOwner: TComponent = nil);
begin
  inherited Create(AOwner);

  ConnectionName := 'AWSAurora';
  DriverName := 'MySQL';
  GetDriverFunc := 'getSQLDriverMYSQL';
  LibraryName := 'dbxmys.dll';
  LoginPrompt := False;
  Params.Add('DriverName=MySQL');
  Params.Add(Format('HostName=%s', [ _AURORA_HOST_ ]));
  Params.Add(Format('Database=%s', [ _AURORA_DATABASE_ ]));
  Params.Add(Format('User_Name=%s', [ _AURORA_USER_ ]));
  Params.Add(Format('Password=%s', [ _AURORA_PASSWORD_ ]));
  Params.Add('ServerCharSet=');
  Params.Add('BlobSize=-1');
  Params.Add('ErrorResourceFile=');
  Params.Add('LocaleCode=0000');
  Params.Add('Compressed=False');
  Params.Add('Encrypted=False');
  VendorLib := 'LIBMYSQL.dll';

  FQTimestamp := NewSQLQuery;
  FQTimestamp.SQL.Add('select current_timestamp() as marca_tiempo');

end;

destructor TConexionAWSAurora.Destroy;
begin
  FQTimestamp.Free;
  inherited;
end;

function TConexionAWSAurora.GetCurrentTimestamp: TDateTime;
begin
  try
    FQTimestamp.Open;
    Result := FQTimestamp.FieldByName('marca_tiempo').asDatetime;
  finally
    FQTimestamp.Close;
  end;
end;

function TConexionAWSAurora.NewSimpleDataset(AOwner: TComponent): TSimpleDataset;
begin
  Result := TSimpleDataset.Create(AOwner);
  Result.Connection := Self;
end;

function TConexionAWSAurora.NewSQLQuery(AOwner: TComponent = nil): TSQLQuery;
begin
  Result := TSQLQuery.Create(AOwner);
  Result.SQLConnection := Self;
end;

procedure TConexionAWSAurora.Rollback;
begin
  ExecuteDirect('rollback');
end;

end.
