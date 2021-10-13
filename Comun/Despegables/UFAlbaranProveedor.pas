unit UFAlbaranProveedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons;

type
  TFAlbaranProveedor = class(TForm)
    DBGrid: TDBGrid;
    Query: TQuery;
    DataSource: TDataSource;
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    procedure FiltrarProveedores;
  public
    { Public declarations }
    bFlag: boolean;
    sEmpresa, sProveedor, sFecha: string;
  end;

  procedure InicializaModulo( const ABaseDatos: string );
  procedure FinalizaModulo;


  function SeleccionaAlbaranProveedor( const AForm: TForm; const AControl: TControl;
                                       const AEmpresa, AProveedor, AFecha: string;
                                       var AResultado: string ): Boolean;

implementation

{$R *.dfm}

var
  FAlbaranProveedor: TFAlbaranProveedor;

procedure InicializaModulo( const ABaseDatos: string );
begin
  FAlbaranProveedor:= TFAlbaranProveedor.Create( Application );
  FAlbaranProveedor.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( FAlbaranProveedor );
end;

function SeleccionaAlbaranProveedor( const AForm: TForm; const AControl: TControl;
                                     const AEmpresa, AProveedor, AFecha: string;
                                     var AResultado: string ): Boolean;
begin
  if AEmpresa <> '' then
  begin
    FAlbaranProveedor:= TFAlbaranProveedor.Create( AForm );

    FAlbaranProveedor.Left:= AControl.ClientOrigin.X;
    FAlbaranProveedor.Top:= AControl.ClientOrigin.Y + AControl.Height;

    FAlbaranProveedor.sEmpresa:= AEmpresa;
    FAlbaranProveedor.sProveedor:=  AProveedor;
    FAlbaranProveedor.sFecha:=  AFecha;

    FAlbaranProveedor.FiltrarProveedores;

    try
      FAlbaranProveedor.ShowModal;
      result:= FAlbaranProveedor.bFlag;
      if result then
        AResultado:= FAlbaranProveedor.Query.Fields[2].AsString;
    finally
      FreeAndNil( FAlbaranProveedor );
    end;
  end
  else
  begin
    raise Exception.Create('Falta el código de la empresa.');
  end;
end;


procedure TFAlbaranProveedor.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TFAlbaranProveedor.FormShow(Sender: TObject);
begin
  bFlag:= False;
end;

procedure TFAlbaranProveedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFAlbaranProveedor.FiltrarProveedores;
var
  dAux: TDateTime;
begin
  with FAlbaranProveedor.Query do
  begin
    DisableControls;
    Close;
    SQL.Clear;

    SQL.Add('SELECT empresa_ec empresa, proveedor_ec proveedor, albaran_ec albaran, fecha_carga_ec fecha_carga ');
    SQL.Add(' FROM  frf_entregas_c ');
    SQL.Add('WHERE empresa_ec = :empresa ');

    if Trim(sProveedor) <> '' then
    begin
      SQL.Add('and proveedor_ec =  :proveedor');
    end;
    if TryStrToDate(sFecha, dAux) then
    begin
      SQL.Add('and fecha_carga_ec between  :fechaini and :fechafin ');
    end;
    SQL.Add('ORDER BY proveedor_ec, fecha_carga_ec, albaran_ec  ');

    ParamByName('empresa').AsString:= sEmpresa;
    if Trim(sProveedor) <> '' then
    begin
      ParamByName('proveedor').AsString:= sProveedor;
    end;
    if TryStrToDate(sFecha, dAux) then
    begin
      ParamByName('fechaini').AsDateTime:= dAux-2;
      ParamByName('fechafin').AsDateTime:= dAux+2;
    end;

    try
      Open;
    finally
      EnableControls;
    end;
  end;
end;

procedure TFAlbaranProveedor.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_return:
      begin
        bFlag:= True;
        Close;
      end;
    vk_escape:
      begin
        Close;
      end;
  end;
end;

end.
