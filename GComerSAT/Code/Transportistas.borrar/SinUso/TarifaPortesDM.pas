unit TarifaPortesDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMTarifaPortes = class(TDataModule)
    QMaestro: TQuery;
    QListado: TQuery;
    QMaestroempresa_csp: TStringField;
    QMaestrotransporte_csp: TSmallintField;
    QMaestrocliente_csp: TStringField;
    QMaestrodir_sum_csp: TStringField;
    QDirSum: TQuery;
    QMaestrototal_csp: TFloatField;
    QMaestroparcial_csp: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create( AOwner: TComponent );Override;
    Destructor  Destroy;Override;
  end;

var
  DMTarifaPortes: TDMTarifaPortes;

implementation

{$R *.dfm}

constructor TDMTarifaPortes.Create( AOwner: TComponent );
begin
  inherited;
  QDirSum.SQL.Add('SELECT empresa_ds');
  QDirSum.SQL.Add('FROM frf_dir_sum ');
  QDirSum.SQL.Add('WHERE empresa_ds = :empresa');
  QDirSum.SQL.Add(' AND cliente_ds = :cliente');
  QDirSum.SQL.Add(' AND dir_sum_ds = :dir_sum');
  QDirSum.Prepare;
end;

Destructor TDMTarifaPortes.Destroy;
begin
  QDirSum.UnPrepare;
  inherited;
end;

end.
