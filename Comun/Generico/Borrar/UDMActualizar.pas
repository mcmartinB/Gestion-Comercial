unit UDMActualizar;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMActualizar = class(TDataModule)
    QActualizaciones: TQuery;
    Query1: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Actualizar;
  end;

  procedure Actualizar;

implementation

{$R *.dfm}

var
  DMActualizar: TDMActualizar;

procedure Actualizar;
begin
  try
    DMActualizar:= TDMActualizar.Create( nil );
    DMActualizar.Actualizar;
  finally
    FreeAndNil( DMActualizar );
  end;
end;

procedure TDMActualizar.DataModuleCreate(Sender: TObject);
begin
  with QActualizaciones.SQL do
  begin
    Clear;
    Add('select * from cnf_actualizaciones');
  end;
  with QActualizaciones.SQL do
  begin
    Clear;
    Add('select * ');
    Add('from cnf_actualizados');
    Add('where actualizacion_cac = :actualizacion');
    Add('and maquina_cac = :maquina ');
  end;
end;

procedure TDMActualizar.Actualizar;
begin
  (*ACTUALIZAR*)
end;

end.
