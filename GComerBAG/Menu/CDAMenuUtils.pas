unit CDAMenuUtils;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDAMenuUtils = class(TDataModule)
    QMenuLog: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure MenuLog( const AMenu: string );

implementation

{$R *.dfm}

uses
  UDMConfig, CVariables;

var
  DAMenuUtils: TDAMenuUtils;

procedure MenuLog( const AMenu: string );
begin
  if Uppercase( Copy( gsCodigo, 1, 4 ) ) <> 'INFO' then
  begin
    if DAMenuUtils = nil then
    begin
      DAMenuUtils:= TDAMenuUtils.Create( nil );
    end;
    with DAMenuUtils.QMenuLog do
    begin
      ParamByName('menu').AsString:= AMenu;
      ParamByName('usuario').AsString:= gsCodigo;
      ParamByName('instalacion').AsInteger:= DMConfig.iInstalacion;
      ParamByName('fecha').AsDate:= Now;
      ParamByName('hora').AsString:= FormatDateTime('hh:mm:ss', Now);
      try
        ExecSQL;
      except
        //No hacemos nada
      end;
    end;
  end;
end;

procedure TDAMenuUtils.DataModuleCreate(Sender: TObject);
begin
  with QMenuLog do
  begin
    SQL.Clear;
    SQL.Add('insert into mnu_menu_log values ( :menu, :usuario, :instalacion, :fecha, :hora ) ');
    Prepare;
  end;
end;

procedure TDAMenuUtils.DataModuleDestroy(Sender: TObject);
begin
  if QMenuLog.Prepared then
    QMenuLog.UnPrepare;
end;

initialization
  DAMenuUtils:= nil;

finalization
  if DAMenuUtils <> nil then
    FreeAndNil( DAMenuUtils );

end.
