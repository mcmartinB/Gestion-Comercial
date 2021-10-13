unit UFProveedores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons;

type
  TFProveedores = class(TForm)
    DBGrid: TDBGrid;
    Query: TQuery;
    DataSource: TDataSource;
    edtFiltro: TEdit;
    btnFiltrar: TSpeedButton;
    Label1: TLabel;
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFiltrarClick(Sender: TObject);
    procedure edtFiltroKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    procedure FiltrarProveedores;
  public
    { Public declarations }
    bFlag: boolean;
  end;

  procedure InicializaModulo( const ABaseDatos: string );
  procedure FinalizaModulo;


  function SeleccionaProveedor( const AForm: TForm; const AControl: TControl; const AEmpresa: string; var AResultado: string ): Boolean;

implementation

{$R *.dfm}

var
  FProveedor: TFProveedores;

procedure InicializaModulo( const ABaseDatos: string );
begin
  FProveedor:= TFProveedores.Create( Application );              
  FProveedor.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( FProveedor );
end;

function SeleccionaProveedor( const AForm: TForm; const AControl: TControl;
                           const AEmpresa: string; var AResultado: string ): Boolean;
begin
  FProveedor:= TFProveedores.Create( AForm );

  FProveedor.Left:= AControl.ClientOrigin.X;
  FProveedor.Top:= AControl.ClientOrigin.Y + AControl.Height;

  FProveedor.FiltrarProveedores;

  try
    FProveedor.ShowModal;
    result:= FProveedor.bFlag;
    if result then
      AResultado:= FProveedor.Query.Fields[0].AsString;
  finally
    FreeAndNil( FProveedor );
  end;
end;


procedure TFProveedores.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TFProveedores.FormShow(Sender: TObject);
begin
  bFlag:= False;
end;

procedure TFProveedores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFProveedores.FiltrarProveedores;
begin
  with FProveedor.Query do
  begin
    DisableControls;
    Close;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT proveedor_p Proveedor, nombre_p Nombre ' +
            ' FROM frf_proveedores ');
    if edtFiltro.Text <> '' then
    begin
      SQL.Add('Where nombre_p LIKE ''%' + edtFiltro.Text + '%'' ');
    end;

    SQL.Add('ORDER BY proveedor_p ');
    try
      Open;
    finally
      EnableControls;
    end;
  end;
end;

procedure TFProveedores.FormKeyUp(Sender: TObject; var Key: Word;
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
    vk_f2:
      begin
        btnFiltrar.Click;
      end;
  end;
end;

procedure TFProveedores.btnFiltrarClick(Sender: TObject);
begin
  FiltrarProveedores;
end;

procedure TFProveedores.edtFiltroKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_up:
      begin
        Query.Prior;
      end;
    vk_down:
      begin
        Query.Next;
      end;
  end;
end;

end.
