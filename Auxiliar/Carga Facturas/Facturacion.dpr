program Facturacion;

uses
  Forms,
  UFFacturacion in 'UFFacturacion.pas' {FFacturacion},
  UDFactura in 'UDFactura.pas' {DFactura: TDataModule},
  CFactura in 'CFactura.pas';
              
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFFacturacion, FFacturacion);
  Application.Run;
end.
