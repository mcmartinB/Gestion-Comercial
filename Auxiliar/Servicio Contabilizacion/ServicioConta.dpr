program ServicioConta;

uses
  SvcMgr,
  UFServicio in 'UFServicio.pas' {FServicioConta: TService},
  CContabilizacion in '..\..\Comercial\Facturacion\CContabilizacion.pas',
  UDMServicio in 'UDMServicio.pas' {DMServicio: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFServicioConta, FServicioConta);
  Application.CreateForm(TDMServicio, DMServicio);
  Application.Run;
end.
