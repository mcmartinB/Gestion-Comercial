unit LiqProdVendidoControlDM;

interface

uses
  SysUtils, Classes;

type
  TDMLiqProdVendidoControl = class(TDataModule)
  private
    { Private declarations }

    iTipoLiquida: integer; // 0: salidas 1:escandallo 2:ajustes
    sEmpresa, sCentro, sProducto, sCosechero: string;
    dFechaIni, dFechaFin: TDateTime;
    rCosteComercial, rCosteProduccion, rCosteAdministrativo: Real;
    bDefinitiva: boolean;

  public
    { Public declarations }

    function VerificarPeriodo(const AEmpresa, ACentro, AProducto: string;
                             const ADesde, AHasta: TDateTime;
                             const AComercial, AProduccion, AAdministrativo: Real;
                             const ADefinitiva: boolean;
                             var AMsg: string ): Boolean;
  end;

var
  DMLiqProdVendidoControl: TDMLiqProdVendidoControl;

implementation

{$R *.dfm}

function TDMLiqProdVendidoControl.VerificarPeriodo(
                             const AEmpresa, ACentro, AProducto: string;
                             const ADesde, AHasta: TDateTime;
                             const AComercial, AProduccion, AAdministrativo: Real;
                             const ADefinitiva: boolean;
                             var AMsg: string ): Boolean;
begin
  //
  Result:= True;
end;

end.
