program PruebaConta;

uses
  Forms,
  FMain in 'FMain.pas' {MainF},
  CContabilizacion in '..\..\Comercial\Facturacion\CContabilizacion.pas',
  UDMServicio in 'UDMServicio.pas' {DMServicio: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainF, MainF);
  Application.CreateForm(TDMServicio, DMServicio);
  Application.Run;
end.
