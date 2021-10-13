unit UFServicio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ExtCtrls, DB, DBTables;

type
  TFServicioConta = class(TService)
    Temporizador: TTimer;
    procedure ServiceExecute(Sender: TService);
    procedure TemporizadorTimer(Sender: TObject);
  private


  public
    function GetServiceController: TServiceController; override;

  end;

var
  FServicioConta: TFServicioConta;

implementation

uses UDMServicio;

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  FServicioConta.Controller(CtrlCode);
end;

function TFServicioConta.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TFServicioConta.ServiceExecute(Sender: TService);
begin
  DMServicio.EjecutarConta;
  Temporizador.Enabled := true;
  while not Terminated do
    ServiceThread.ProcessRequests(True);
  Temporizador.Enabled := false;
end;

procedure TFServicioConta.TemporizadorTimer(Sender: TObject);
begin
  DMServicio.EjecutarConta;
end;


end.
