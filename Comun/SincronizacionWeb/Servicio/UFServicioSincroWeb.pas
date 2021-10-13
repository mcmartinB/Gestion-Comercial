unit UFServicioSincroWeb;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  SvcMgr;

type
  TFSincroWeb = class(TService)

    procedure ServiceExecute(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceAfterInstall(Sender: TService);
  private
    Fichero: TStringList;
    FProximaEjecucion: TDateTime; // Hora de la proxima ejecucion

    function CalcularProximaEjecucion(AFechaHora: TDateTime): TDateTime;

  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  FSincroWeb: TFSincroWeb;

implementation

uses
  Registry,
  DateUtils,
  Types,
  UDMSincroWeb;

{$R *.DFM}

type
  THoraSincro = record
    horas: word;
    minutos: word;
  end;

const
  NUM_PLANIFICACIONES = 2;

var
  Planificacion: array[0..NUM_PLANIFICACIONES-1] of THoraSincro = (
    (horas: 6; minutos: 0),
    (horas: 22; minutos: 0)
  );


procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  FSincroWeb.Controller(CtrlCode);
end;

function TFSincroWeb.CalcularProximaEjecucion(AFechaHora: TDateTime): TDateTime;
var
  yy, mm, dd, h, m, s, ms: word;
  i: integer;
  fechaHoraAux: TDateTime;
  encontradaHora: boolean;
begin
  Result := 0;
  DecodeDateTime(AFechaHora, yy, mm, dd, h, m, s, ms);

  // Si solo hay una hora en la lista de horas, coger la primera
  if NUM_PLANIFICACIONES = 1 then
  begin
    fechaHoraAux := EncodeDateTime(yy, mm, dd, Planificacion[0].horas, Planificacion[0].minutos, 0, 0);
    //if AFechaHora < fechaHoraAux then
    if CompareDateTime(AFechaHora, fechaHoraAux) = LessThanValue then
      Result := fechaHoraAux
    else
      Result := IncDay(fechaHoraAux);
  end
  else
  begin
    // Buscar la siguiente hora en la lista
    encontradaHora := false;
    for i := 0 to NUM_PLANIFICACIONES - 1 do
    begin
      fechaHoraAux := EncodeDateTime(yy, mm, dd, Planificacion[i].horas, Planificacion[i].minutos, 0, 0);
      //if AFechaHora <= fechaHoraAux then
      if CompareDateTime(AFechaHora, fechaHoraAux) = LessThanValue then

      begin
        Result := fechaHoraAux;
        encontradaHora := True;
        Break;
      end
      else
        Continue
    end;

    // Si no hay horas posteriores en la lista de horas, coger la primera.
    if not encontradaHora then
    begin
      fechaHoraAux := EncodeDateTime(yy, mm, dd, Planificacion[0].horas, Planificacion[0].minutos, 0, 0);
      Result := IncDay(fechaHoraAux);
    end;
  end;
end;

function TFSincroWeb.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TFSincroWeb.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('System\CurrentControlSet\Services\' + Name, True) then
      Reg.WriteString('Description', 'Sincronización web');
  finally
    Reg.Free;
  end;
end;

procedure TFSincroWeb.ServiceCreate(Sender: TObject);
begin
  Fichero := TStringList.Create;
end;

procedure TFSincroWeb.ServiceExecute(Sender: TService);
begin
  FProximaEjecucion := CalcularProximaEjecucion(Now);
  LogMessage(Format('Proxima ejecución: %s', [ DatetimeToStr(FProximaEjecucion) ]), EVENTLOG_INFORMATION_TYPE  );

  while not Terminated do
  begin
    try
      ServiceThread.ProcessRequests(False);
      Sleep(2000);

      if CompareDateTime(Now, FProximaEjecucion) = GreaterThanValue then
      begin
        FDMSincroWeb.Ejecutar;
        FProximaEjecucion := CalcularProximaEjecucion(Now);

        LogMessage(Format('Proxima ejecución: %s', [ DatetimeToStr(FProximaEjecucion) ]), EVENTLOG_INFORMATION_TYPE  );

      end
    except
      on E: Exception do
      begin
        LogMessage(Format('Error: %s', [ E.Message ]));
        FProximaEjecucion := CalcularProximaEjecucion(Now);
      end;
    end;

  end;
end;

end.
