unit AprovechaData;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMAprovecha = class(TDataModule)
    QAprovechaDiario: TQuery;
    QVerificaGrabados: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMAprovecha: TDMAprovecha;

implementation

{$R *.dfm}

procedure TDMAprovecha.DataModuleCreate(Sender: TObject);
begin
  QVerificaGrabados.SQL.Clear;

  QVerificaGrabados.SQL.Add(' Select fecha_e2l, numero_entrada_e2l, cosechero_e2l, plantacion_e2l ');
  QVerificaGrabados.SQL.Add(' From frf_entradas2_l ');
  QVerificaGrabados.SQL.Add(' Where not exists ');
  QVerificaGrabados.SQL.Add('  (Select * from frf_escandallo ');
  QVerificaGrabados.SQL.Add('   where empresa_e2l = :empresa ');
  QVerificaGrabados.SQL.Add('   and centro_e2l = :centro ');
  QVerificaGrabados.SQL.Add('   and fecha_e2l = fecha_e ');
  QVerificaGrabados.SQL.Add('   and numero_entrada_e2l = numero_entrada_e ');
  QVerificaGrabados.SQL.Add('   and cosechero_e2l = cosechero_e ');
  QVerificaGrabados.SQL.Add('   and plantacion_e2l = plantacion_e) ');
  QVerificaGrabados.SQL.Add(' and empresa_e2l = :empresa ');
  QVerificaGrabados.SQL.Add(' and centro_e2l = :centro ');
  QVerificaGrabados.SQL.Add(' and fecha_e2l between :fecha_ini and :fecha_fin ');
  QVerificaGrabados.SQL.Add(' and producto_e2l = :producto ');
  QVerificaGrabados.SQL.Add(' order by fecha_e2l, cosechero_e2l, plantacion_e2l, numero_entrada_e2l) ');
end;

procedure TDMAprovecha.DataModuleDestroy(Sender: TObject);
begin
  QVerificaGrabados.Close;
end;

end.
