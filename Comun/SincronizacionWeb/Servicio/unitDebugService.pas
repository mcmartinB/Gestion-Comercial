unit unitDebugService;

// Copyright (c) Colin Wilson 2002.  All rights reserved.

interface

uses Windows, Messages, Consts, Classes, SysUtils, Forms, SvcMgr;

type

TDebugServiceApplication = class (TServiceApplication)
private
  procedure OnExceptionHandler(Sender: TObject; E: Exception);
public
  procedure Run; override;
end;

TDebugServiceThread = class (TThread)
private
  fService : TService;
  procedure ProcessRequests(WaitForMessage: Boolean);
protected
  procedure Execute; override;
public
  constructor Create (AService : TService);
end;

implementation

{ TDebugServiceApplication }

procedure TDebugServiceApplication.OnExceptionHandler(Sender: TObject; E: 
Exception);
begin
  DoHandleException(E);
end;

procedure TDebugServiceApplication.Run;
var
  i : Integer;
  service : TService;
  thread : TThread;
begin
  Forms.Application.OnException := OnExceptionHandler;
  try
    for i := 0 to ComponentCount - 1 do
      if Components [i] is TService then
      begin
        service := TService (Components [i]);
        thread := TDebugServiceThread.Create(service);
        thread.Resume;
        service.Tag := Integer (thread);
      end;

    while not Forms.Application.Terminated do
      Forms.Application.HandleMessage;

    for i := 0 to ComponentCount - 1 do
      if Components [i] is TService then
      begin
        service := TService (Components [i]);
        thread := TThread (service.Tag);
        PostThreadMessage (thread.ThreadID, WM_QUIT, 0, 0);
        thread.WaitFor;
        FreeAndNil (thread)
      end;

  finally
  end;
end;

{ TDebugServiceThread }

constructor TDebugServiceThread.Create(AService: TService);
begin
  fService := AService;
  inherited Create (True);
end;

procedure TDebugServiceThread.Execute;
var
  msg: TMsg;
  Started: Boolean;
begin
  PeekMessage(msg, 0, WM_USER, WM_USER, PM_NOREMOVE); { Create message 
queue }
  try
    Started := True;
    if Assigned(FService.OnStart) then FService.OnStart(FService, Started);
    if not Started then Exit;
    try
      if Assigned(FService.OnExecute) then
        FService.OnExecute(FService)
      else
        ProcessRequests(True);
      ProcessRequests(False);
    except
      on E: Exception do
        FService.LogMessage(Format(SServiceFailed,[SExecute, E.Message]));
    end;
  except
    on E: Exception do
      FService.LogMessage(Format(SServiceFailed,[SStart, E.Message]));
  end;
end;

procedure TDebugServiceThread.ProcessRequests(WaitForMessage: Boolean);
var
  msg: TMsg;
  Rslt: Boolean;
begin
  while True do
  begin
    if Terminated and WaitForMessage then break;
    if WaitForMessage then
      Rslt := GetMessage(msg, 0, 0, 0)
    else
      Rslt := PeekMessage(msg, 0, 0, 0, PM_REMOVE);
    if not Rslt then break;
    DispatchMessage(msg);
  end;
end;

end.

