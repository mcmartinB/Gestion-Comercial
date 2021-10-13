unit UFProductosProveedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls;

type
  TFProductosProveedor = class(TForm)
    DBGrid: TDBGrid;
    Query: TQuery;
    DataSource: TDataSource;
    edtFiltro: TEdit;
    btnFiltrar: TSpeedButton;
    Label1: TLabel;
    bntNuevo: TSpeedButton;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Queryproveedor: TStringField;
    Queryproducto: TStringField;
    Queryvariedad: TIntegerField;
    Querydescripcion: TStringField;
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFiltrarClick(Sender: TObject);
    procedure edtFiltroKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bntNuevoClick(Sender: TObject);
  private
    { Private declarations }

    procedure FiltrarProductoProveedor;
  public
    { Public declarations }
    bFlag: boolean;
    sEmpresa, sProveedor, sProducto: string;
  end;

  (*
  procedure InicializaModulo( const ABaseDatos: string );
  procedure FinalizaModulo;
  *)

  function SeleccionaProductoProvedor( const AForm: TForm; const AControl: TControl;
    const AEmpresa, AProveedor, AProducto: string; var AResultado: string ): Boolean;

implementation

{$R *.dfm}

var
  FProductosProveedor: TFProductosProveedor;

(*
procedure InicializaModulo( const ABaseDatos: string );
begin
  FProductosProveedor:= TFProductosProveedor.Create( Application );
  FProductosProveedor.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( FProductosProveedor );
end;
*)

function SeleccionaProductoProvedor( const AForm: TForm; const AControl: TControl;
    const AEmpresa, AProveedor, AProducto: string; var AResultado: string ): Boolean;
begin
  FProductosProveedor:= TFProductosProveedor.Create( AForm );

  FProductosProveedor.Left:= AControl.ClientOrigin.X;
  FProductosProveedor.Top:= AControl.ClientOrigin.Y + AControl.Height;

  FProductosProveedor.sEmpresa:= AEmpresa;
  FProductosProveedor.sProveedor:= AProveedor;
  FProductosProveedor.sProducto:= AProducto;
  FProductosProveedor.FiltrarProductoProveedor;

  try
    FProductosProveedor.ShowModal;
    result:= FProductosProveedor.bFlag;
    if result then
      AResultado:= FProductosProveedor.Query.Fields[2].AsString;
  finally
    FreeAndNil( FProductosProveedor );
  end;
end;


procedure TFProductosProveedor.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TFProductosProveedor.FormShow(Sender: TObject);
begin
  bFlag:= False;
end;

procedure TFProductosProveedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFProductosProveedor.FiltrarProductoProveedor;
var
  bFlag: boolean;
begin
  with FProductosProveedor.Query do
  begin
    DisableControls;
    Close;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT proveedor_pp Proveedor, producto_pp Producto, variedad_pp Variedad, descripcion_pp Descripcion ' +
          ' FROM frf_productos_proveedor ');

    bFlag:= False;
    if Trim(sProveedor) <> '' then
    begin
      if bFlag then
      begin
        SQL.Add('  AND proveedor_pp = :proveedor ');
      end
      else
      begin
        SQL.Add('WHERE proveedor_pp = :proveedor ');
      end;
      bFlag:= True;
    end;
    if Trim(sProducto) <> '' then
    begin
      if bFlag then
      begin
        SQL.Add('  AND producto_pp = :producto ');
      end
      else
      begin
        SQL.Add('WHERE producto_pp = :producto ');
      end;
      bFlag:= True;
    end;
    if edtFiltro.Text <> '' then
    begin
      if bFlag then
      begin
        SQL.Add('  AND descripcion_pp LIKE ''%' + edtFiltro.Text + '%'' ');
      end
      else
      begin
        SQL.Add('WHERE descripcion_pp LIKE ''%' + edtFiltro.Text + '%'' ');
      end;
    end;
    SQL.Add('ORDER BY 1, 2, 3 ');

   if Trim(sProveedor) <> '' then
      ParamByName('proveedor').AsString:= sProveedor;
   if Trim(sProducto) <> '' then
      ParamByName('producto').AsString:= sProducto;

    try
      Open;
    finally
      EnableControls;
    end;
  end;
end;

procedure TFProductosProveedor.FormKeyUp(Sender: TObject; var Key: Word;
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
    ord('+'):
      begin
        bntNuevo.Click;
      end;
  end;
end;

procedure TFProductosProveedor.btnFiltrarClick(Sender: TObject);
begin
  FiltrarProductoProveedor;
end;

procedure TFProductosProveedor.edtFiltroKeyUp(Sender: TObject; var Key: Word;
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

procedure TFProductosProveedor.bntNuevoClick(Sender: TObject);
begin
  ShowMessage('Insertar un nuevo producto, en construcción.');
end;

end.
