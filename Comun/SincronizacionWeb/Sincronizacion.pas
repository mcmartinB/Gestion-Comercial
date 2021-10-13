unit Sincronizacion;

interface

uses
  // Librerias Delphi
  Forms,
  Classes,
  DB,
  DBTables,
  SyncObjs,
  Contnrs,
  SQLExpr,
  DBClient,
  SimpleDS,
  SysUtils,
  Windows,

  // Librerias propias
  ConexionInformix,
  ConexionAWSAurora,
  ConexionAWSAuroraConstantes;

type
  TItemSincronizable = class;
  TSincronizadorThread = class;

  TProgressUpdate = procedure(Sender: TObject; Index: Integer; Total: Integer) of object;
  TWorkDone = procedure(Sender: TObject) of object;

  TSincronizacion = class
    private
      FBDOrigen: TDatabase;
      FBDDestino: TConexionAWSAurora;
      FQInsertPendiente: TQuery;
      FQSelectPendiente: TQuery;
      FQDeletePendiente: TQuery;

      FSincronizadorThread: TSincronizadorThread;

      FMutex: TMutex;
      FListaItems: TObjectList;
      FMaquina: String;
      FUsuario: String;

    protected
      FOnProgressUpdate: TProgressUpdate;
      FOnWorkDone: TWorkDone;

      function GetQueryOrigen: TQuery;
      function GetSimpleDatasetDestino: TSimpleDataset;

      procedure CrearItemsDesdePendiente(ADataset: TDataset); virtual; abstract;
      procedure BorrarItemPendiente(id: Integer); overload;
      procedure BorrarItemPEndiente(const tabla: String; const CamposClave: String; const ValoresClave: String); overload;
      // Manejador de los eventos del hilo sincronizador
      procedure ProgressUpdate(Sender: TObject; Index: Integer; Total: Integer);
      procedure WorkDone(Sender: TObject);

    public
      constructor Create(ASourceDb: TDatabase; ADestinationDb: TConexionAWSAurora);
      destructor Destroy; override;

      function GetBDOrigen: TDatabase;
      function GetBDDestino: TConexionAWSAurora;

      procedure Sincronizar;
      function GetCurrentTimestamp: TDateTime;

      procedure ConectarBDOrigen;
      procedure DesconectarBDOrigen;
      procedure ConectarBDDestino;
      procedure DesconectarBDDestino;

      procedure Encolar(AItemSincronizable: TItemSincronizable); overload;
      function Desencolar: TItemSincronizable;
      procedure Encolar(AItemSincronizable: TItemSincronizable; Posicion: Integer); overload;

      function ItemsEnCola: Integer;
      procedure GuardarPendiente(AItemSincronizable: TItemSincronizable);
      procedure CargarPendientes;
      procedure Fin;

      property Usuario: String read FUsuario write FUsuario;
      property Maquina: String read FMaquina write FMaquina;

      property OnProgressUpdate: TProgressUpdate read FOnProgressUpdate write FOnProgressUpdate;
      property OnWorkDone: TWorkDone read FOnWorkDone write FOnWorkDone;
  end;

  TItemSincronizable = class
    private
      FItemSincronizableId: Integer;

      FTablaOrigen: String;
      FTablaDestino: String;

      FCamposClave: TStringList;
      FValoresClave: TStringList;
      FCadenaCampoClave: String;
    procedure SetCadenaCamposClave(const Value: String);

    protected
      FQOrigen: TQuery;
      FQDestino: TSimpleDataset;

      FFormatSettings: TFormatSettings;

      procedure CopyRecord(Source: TDataSet; Destination: TDataset);
      procedure Ini;
      procedure AsignarParametros; virtual;

    public
      constructor Create(AItemSincronizableId: Integer);
      destructor Destroy; override;

      procedure Sincronizar(ABDOrigen: TConexionInformix; ABDDestino: TSQLConnection);

      property ItemSincronizableId: Integer read FItemSincronizableId;
      property TablaOrigen: String read FTablaOrigen write FTablaOrigen;
      property TablaDestino: String read FTablaDestino write FTablaDestino;
      property CadenaCamposClave: String read FCadenaCampoClave write SetCadenaCamposClave;
      property CamposClave: TStringList read FCamposClave;
      property ValoresClave: TStringList read FValoresClave;
  end;

  TSincronizadorThread = class(TThread)
    private
      FSession: TSession;
      FBDOrigen: TConexionInformix;
      FBDDestino: TConexionAWSAurora;

      FQInsertPendiente: TQuery;

      FSincronizacion: TSincronizacion;

      FOnProgressUpdate: TProgressUpdate;
      FOnWorkDone: TWorkDone;

      procedure GuardarPendiente(AItemSincronizable: TItemSincronizable);

    protected
      procedure Execute; override;

    public
      constructor Create(ASincronizacion: TSincronizacion; ABDOrigen: TDatabase);
      destructor Destroy; override;

      property OnProgressUpdate: TProgressUpdate read FOnProgressUpdate write FOnProgressUpdate;
      property OnWorkDone: TWorkDone read FOnWorkDone write FOnWorkDone;
  end;

implementation

{ TSincronizacion }

procedure TSincronizacion.Encolar(AItemSincronizable: TItemSincronizable);
begin
  try
    FMutex.Acquire;
    FListaItems.Add(AItemSincronizable);
  finally
    FMutex.Release;
  end;
end;

procedure TSincronizacion.Fin;
begin
  FSincronizadorThread.Terminate;
  FSincronizadorThread.Resume;
  FSincronizadorThread.WaitFor;
  DesconectarBDOrigen;
  DesconectarBDDestino;
end;

function TSincronizacion.GetBDDestino: TConexionAWSAurora;
begin
  Result := Self.FBDDestino;
end;

function TSincronizacion.GetBDOrigen: TDatabase;
begin
  Result := Self.FBDOrigen;
end;

function TSincronizacion.GetCurrentTimestamp: TDateTime;
begin
  Result := FBDDestino.GetCurrentTimestamp;
end;

function TSincronizacion.GetQueryOrigen: TQuery;
begin
  Result := TQuery.Create(nil);
  Result.DatabaseName := FBDOrigen.DatabaseName;
  //Result.SQLConnection := FBDOrigen;
end;


function TSincronizacion.GetSimpleDatasetDestino: TSimpleDataset;
begin
  Result := FBDDestino.NewSimpleDataset;
end;

function TSincronizacion.ItemsEnCola: Integer;
begin
  try
    FMutex.Acquire;
    Result := FListaItems.Count;
  finally
    FMutex.Release;
  end;
end;

procedure TSincronizacion.ProgressUpdate(Sender: TObject; Index, Total: Integer);
begin
  if Assigned(FOnProgressUpdate) then
    FOnProgressUpdate(Self, Index, Total);
end;

procedure TSincronizacion.Sincronizar;
begin
  CargarPendientes;
  FSincronizadorThread.Resume;
end;


procedure TSincronizacion.WorkDone(Sender: TObject);
begin
  if Assigned(FOnWorkDone) then
    FOnWorkDone(Self);
end;

procedure TSincronizacion.GuardarPendiente(AItemSincronizable: TItemSincronizable);
begin
  with FQInsertPendiente do
  begin
    ParamByName('equipo').asString := FMaquina;
    ParamByName('usuario').asString := FUsuario;

    ParamByName('tabla').asString := IntToStr(Ord(AItemSincronizable.ItemSincronizableId));
    ParamByName('campos_clave').asString := AItemSincronizable.CamposClave.CommaText;
    ParamByName('valores_clave').asString := AItemSincronizable.ValoresClave.CommaText;
    ExecSQL;
  end;
end;

procedure TSincronizacion.BorrarItemPendiente(id: Integer);
begin
  FQDeletePendiente.ParamByName('id').asInteger := id;
  FQDeletePendiente.ExecSQL;
end;

procedure TSincronizacion.BorrarItemPendiente(const tabla, CamposClave, ValoresClave: String);
begin

end;

procedure TSincronizacion.CargarPendientes;
begin
  with FQSelectPendiente do
  begin
    if Active then Close;
      Open;
    CrearItemsDesdePendiente(FQSelectPendiente);
    Close;
  end;
end;

procedure TSincronizacion.ConectarBDDestino;
begin
  FBDDestino.Connected := True;
end;

procedure TSincronizacion.ConectarBDOrigen;
begin
  FBDOrigen.Connected := True;
//  FBDOrigen.Execute('SET ISOLATION TO DIRTY READ');
end;


constructor TSincronizacion.Create(ASourceDb: TDatabase; ADestinationDb: TConexionAWSAurora);
begin
  FBDOrigen := ASourceDb;
  FBDDestino := ADestinationDb;

  FMutex := TMutex.Create;
  FListaItems := TObjectList.Create(False);

  FSincronizadorThread := TSincronizadorThread.Create(Self, FBDOrigen);
  FSincronizadorThread.OnProgressUpdate := ProgressUpdate;
  FSincronizadorThread.OnWorkDone := WorkDone;


  //FQInsertPendiente := GetQueryOrigen;
  FQInsertPendiente := TQuery.Create(nil);
  FQInsertPendiente.Databasename := FBDOrigen.DatabaseName;
  FQInsertPendiente.SQL.Add('insert into frf_sincroweb (equipo, usuario, tabla, campos_clave, valores_clave) ');
  FQInsertPendiente.SQL.Add(' values (:equipo, :usuario, :tabla, :campos_clave, :valores_clave) ');

  //FQSelectPendiente := GetQueryOrigen;
  FQSelectPendiente := TQuery.Create(nil);
  FQSelectPendiente.Databasename := FBDOrigen.DatabaseName;
  FQSelectPendiente.SQL.Add('select * from frf_sincroweb order by id');

  //FQDeletePendiente := GetQueryOrigen;
  FQDeletePendiente := TQuery.Create(nil);
  FQDeletePendiente.Databasename := FBDOrigen.DatabaseName;
  FQDeletePendiente.SQL.Add('delete from frf_sincroweb where id = :id');
end;

procedure TSincronizacion.DesconectarBDDestino;
begin
  FBDDestino.Connected := False;
end;

procedure TSincronizacion.DesconectarBDOrigen;
begin
  FBDOrigen.Connected := False;
end;

function TSincronizacion.Desencolar: TItemSincronizable;
begin
  try
    FMutex.Acquire;
    Result := TItemSincronizable(FListaItems.First);
    FListaItems.Delete(0);
  finally
    FMutex.Release;
  end;

end;

destructor TSincronizacion.Destroy;
begin
  FQInsertPendiente.Free;
  FQSelectPendiente.Free;
  FQDeletePendiente.Free;

  FListaItems.Free;
  FMutex.Free;
  FSincronizadorThread.Free;
end;

procedure TSincronizacion.Encolar(AItemSincronizable: TItemSincronizable; Posicion: Integer);
begin
  try
    FMutex.Acquire;
    FListaItems.Insert(Posicion, AItemSincronizable);
  finally
    FMutex.Release;
  end;
end;

{ TItemSincronizable }

procedure TItemSincronizable.AsignarParametros;
var
  i: integer;
begin
  for i := 0 to FCamposClave.Count - 1 do
  begin
    FQOrigen.ParamByName(FCamposClave.Strings[i]).AsString := FValoresClave.Strings[i];
    FQDestino.Dataset.Params.ParamByName(FCamposClave.Strings[i]).AsString := FValoresClave.Strings[i];
  end;
end;

procedure TItemSincronizable.CopyRecord(Source, Destination: TDataset);
var
  Ind:longint;
  SField, DField: TField;
begin
  for Ind:=0 to Source.FieldCount - 1 do
   begin
     SField := Source.Fields[ Ind ];
     DField := Destination.FindField( SField.FieldName );

     if (DField <> nil) and (DField.FieldKind = fkData) and
        not DField.ReadOnly then
        if (SField.DataType = ftString) or
           (SField.DataType <> DField.DataType) then
           DField.AsString := Trim(SField.AsString)
        else
           DField.Assign( SField )
   end;
end;

constructor TItemSincronizable.Create(AItemSincronizableId: Integer);
begin
  GetLocaleFormatSettings(GetThreadLocale, FFormatSettings);
  FFormatSettings.DateSeparator := #45;
  FFormatSettings.ShortDateFormat := 'yyyy-mm-dd';
  FFormatSettings.TimeSeparator := ':';
  FFormatSettings.LongTimeFormat := 'hh:nn';

  FItemSincronizableId := AItemSincronizableId;

  FQDestino := TSimpleDataset.Create(nil);
  FCamposClave := TStringList.Create;
  FValoresClave := TStringList.Create;
end;

destructor TItemSincronizable.Destroy;
begin
  FQOrigen.Free;
  FQDestino.Free;
  FCamposClave.Free;
  FValoresClave.Free;
end;

procedure TItemSincronizable.Ini;
var
  strWhere: String;
  i: Integer;
begin
  if FCamposClave.Count = 0 then
    raise Exception.CreateFmt('La lista de campos clave está vacía', [])

  else if FCamposClave.Count = 1 then
  begin
    strWhere := Format('%s=:%s', [ FCamposClave.Strings[0], FCamposClave.Strings[0] ]);
  end
  else
  begin
    strWhere := Format('%s=:%s', [ FCamposClave.Strings[0], FCamposClave.Strings[0] ]);
    for i := 1 to FCamposClave.Count - 1 do
      strWhere := Format('%s and %s=:%s', [ strWhere, FCamposClave.Strings[i], FCamposClave.Strings[i] ]);
  end;

  FQOrigen.SQL.Clear;
  FQOrigen.SQL.Add(Format('select * from %s where %s', [ FTablaOrigen, strWhere ]));
  //FQOrigen.CommandText := Format('select * from %s where %s', [ FTablaOrigen, strWhere ]);
  FQDestino.DataSet.CommandText := Format('select * from %s where %s', [ FTablaDestino, strWhere ]);

  FQOrigen.Params.Clear;
  for i := 0 to FCamposClave.Count - 1 do
    FQOrigen.Params.CreateParam(ftString, FCamposClave.Strings[i], ptInput);

  for i := 0 to FCamposClave.Count - 1 do
    FValoresClave.Add('');
end;

procedure TItemSincronizable.SetCadenaCamposClave(const Value: String);
var
  i: integer;
begin
  FCamposClave.CommaText := Value;
  FValoresClave.Clear;
  for i := 0 to FCamposClave.Count - 1 do
    FValoresClave.Add('');
end;

procedure TItemSincronizable.Sincronizar(ABDOrigen: TConexionInformix; ABDDestino: TSQLConnection);
var
  timestamp: TDateTime;
begin
  try
    try
      timestamp := Now;

      FQOrigen := ABDOrigen.NewQuery(nil);
      FQDestino.Connection := ABDDestino;

      Ini;
      AsignarParametros;

      FQOrigen.Open;
      FQDestino.Open;

      // Delete
      if FQOrigen.isEmpty then
      begin
        if not FQDestino.IsEmpty then
          FQDestino.Delete;
      end
      // Insert
      else if FQDestino.isEmpty then
      begin
        FQDestino.Append;
        CopyRecord(FQOrigen, FQDestino);
        FQDestino.Fields.FieldByName('id').asInteger := 0;
        FQDestino.Fields.FieldByName('created_at').asDateTime := timestamp;
        FQDestino.Fields.FieldByName('updated_at').asDateTime := timestamp;
      end
      // Update
      else
      begin
        FQDestino.Edit;
        CopyRecord(FQOrigen, FQDestino);
        FQDestino.Fields.FieldByName('updated_at').asDateTime := timestamp;
        FQDestino.Post;
      end;

      FQDestino.ApplyUpdates(-1);
    except
      on E: Exception do
      begin
        raise
        //FSincronizacion.GuardarPendiente(self);
      end;
    end;
  finally
    FQOrigen.Close;
    FQDestino.Close;
  end;
end;

{ TSincronizadorThread }

constructor TSincronizadorThread.Create(ASincronizacion: TSincronizacion; ABDOrigen: TDatabase);
begin
  inherited Create(True);
  FSincronizacion := ASincronizacion;

  FSession := TSession.Create(nil);
  FSession.Sessionname := 'SincroWebSession';
  FBDOrigen := TConexionInformix.Create(nil, ABDOrigen, FSession);

  FBDDestino := FSincronizacion.GetBDDestino.Clonar;

  FQInsertPendiente := FBDOrigen.NewQuery(nil);
  FQInsertPendiente.SQL.Add('insert into frf_sincroweb (equipo, usuario, tabla, campos_clave, valores_clave) ');
  FQInsertPendiente.SQL.Add(' values (:equipo, :usuario, :tabla, :campos_clave, :valores_clave) ');
end;

destructor TSincronizadorThread.Destroy;
begin
  FQInsertPendiente.Free;
  FBDDestino.Free;
  FBDOrigen.Free;
  FSession.Free;

  inherited;
end;

procedure TSincronizadorThread.Execute;
var
  item: TItemSincronizable;
  conectadoADestino: Boolean;
  procesados, total: Integer;
begin
  while not Terminated do
  begin
    // Si no puede conectar a la BD Origen, volver a dormir
    try
      FBDOrigen.Connected := True;
      //FBDOrigen.Execute('SET ISOLATION TO DIRTY READ');
    except
      Suspend;
    end;

    // Si no puede conectar a la BD Destino, guardar en BD Origen los items
    try
      FBDDestino.Connected := True;
      conectadoADestino := True;
    except
      conectadoADestino := False;
    end;

    procesados := 0;
    total := FSincronizacion.ItemsEnCola;
    while not Terminated and (FSincronizacion.ItemsEnCola > 0) do
    begin

      item := FSincronizacion.Desencolar;
      try
        try
          if conectadoADestino then
          begin
            item.Sincronizar(TConexionInformix(FBDOrigen), FBDDestino);
            Inc(procesados);
            if Assigned(FOnProgressUpdate) then
              FOnProgressUpdate(Self, procesados, total);
          end
          else
            GuardarPendiente(item);

        except
          // Si no se puede sincronizar ni guardar en la BD Origen, volver a encolar.
          GuardarPendiente(item);
        end;
      finally
        item.Free;
      end;
    end;
    FBDOrigen.Connected := False;
    FBDDestino.Connected := False;
    if Assigned(FOnWorkDone) then
      FOnWorkDone(Self);
    Suspend;
  end;
end;


procedure TSincronizadorThread.GuardarPendiente(AItemSincronizable: TItemSincronizable);
begin
  with FQInsertPendiente do
  begin
    ParamByName('equipo').asString := FSincronizacion.Maquina;
    ParamByName('usuario').asString := FSincronizacion.Usuario;

    ParamByName('tabla').asString := IntToStr(Ord(AItemSincronizable.ItemSincronizableId));
    ParamByName('campos_clave').asString := AItemSincronizable.CamposClave.CommaText;
    ParamByName('valores_clave').asString := AItemSincronizable.ValoresClave.CommaText;
    ExecSQL;
  end;
end;

end.
