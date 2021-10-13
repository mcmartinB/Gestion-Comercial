program ServicioSincroWeb;

uses
  SvcMgr,
  SysUtils,
  UFServicioSincroWeb in 'UFServicioSincroWeb.pas' {FSincroWeb: TService},
  ConexionAWSAurora in '..\ConexionAWSAurora.pas',
  ConexionAWSAuroraConstantes in '..\ConexionAWSAuroraConstantes.pas',
  ConexionInformix in '..\ConexionInformix.pas',
  ConexionInformixConstantes in '..\ConexionInformixConstantes.pas',
  Sincronizacion in '..\Sincronizacion.pas',
  SincronizacionBonny in '..\SincronizacionBonny.pas',
  unitDebugService in 'unitDebugService.pas',
  UDMSincroWeb in 'UDMSincroWeb.pas' {FDMSincroWeb: TDataModule};

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //

  if (paramCount > 0) and (UpperCase(ParamStr(1)) = '-DEBUG') then
  begin
      FreeAndNil(Application);
      Application := TDebugServiceApplication.Create(nil);
  end;

  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TFSincroWeb, FSincroWeb);
  Application.CreateForm(TFDMSincroWeb, FDMSincroWeb);
  Application.Run;
end.
