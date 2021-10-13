unit UFClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons;

type
  TFClientes = class(TForm)
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
    procedure edtFiltroChange(Sender: TObject);
  private
    { Private declarations }

    procedure FiltrarClientes;
  public
    { Public declarations }
    bFlag: boolean;
    sEmpresa: string;
  end;

  procedure InicializaModulo( const ABaseDatos: string );
  procedure FinalizaModulo;


  function SeleccionaClientes( const AForm: TForm; const AControl: TControl; const AEmpresa: string; var AResultado: string ): Boolean;

implementation

{$R *.dfm}

var
  FClientes: TFClientes;

procedure InicializaModulo( const ABaseDatos: string );
begin
  FClientes:= TFClientes.Create( Application );
  FClientes.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( FClientes );
end;

function SeleccionaClientes( const AForm: TForm; const AControl: TControl;
                           const AEmpresa: string; var AResultado: string ): Boolean;
begin
  FClientes:= TFClientes.Create( AForm );

  FClientes.Left:= AControl.ClientOrigin.X;
  FClientes.Top:= AControl.ClientOrigin.Y + AControl.Height;

  FClientes.sEmpresa:= AEmpresa;
  FClientes.FiltrarClientes;

  try
    FClientes.ShowModal;
    result:= FClientes.bFlag;
    if result then
      AResultado:= FClientes.Query.Fields[0].AsString;
  finally
    FreeAndNil( FClientes );
  end;
end;


procedure TFClientes.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TFClientes.FormShow(Sender: TObject);
begin
  bFlag:= False;
end;

procedure TFClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFClientes.FiltrarClientes;
begin
  with FClientes.Query do
  begin
    DisableControls;
    Close;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT cliente_c Cliente, nombre_c Nombre' +
          ' FROM frf_Clientes ');
    if edtFiltro.Text <> '' then
    begin
      SQL.Add('Where nombre_c LIKE ''%' + edtFiltro.Text + '%'' ');
    end;

    SQL.Add('ORDER BY cliente_c ');
    try
      Open;
      Filtered:= False;
      Filter:= '';
      if not IsEmpty then
      begin
        edtFiltro.Text:= '';
      end;
    finally
      EnableControls;
    end;
  end;
end;

procedure TFClientes.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TFClientes.btnFiltrarClick(Sender: TObject);
begin
  FiltrarClientes;
end;

procedure TFClientes.edtFiltroKeyUp(Sender: TObject; var Key: Word;
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

procedure TFClientes.edtFiltroChange(Sender: TObject);
var
  sText: string;
begin
  sText:= Trim( edtFiltro.Text );
  if sText <> '' then
  begin
    Query.Filtered:= True;
    Query.Filter:= 'nombre = '+ QuotedStr(edtFiltro.Text + '*' );
  end
  else
  begin
    Query.Filtered:= False;
  end;
end;

end.
