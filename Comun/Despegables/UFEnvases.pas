unit UFEnvases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons;

type
  TFEnvases = class(TForm)
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


  function SeleccionaEnvases( const AForm: TForm; const AControl: TControl; var AResultado: string ): Boolean;

implementation

{$R *.dfm}

var
  FEnvases: TFEnvases;

procedure InicializaModulo( const ABaseDatos: string );
begin
  FEnvases:= TFEnvases.Create( Application );
  FEnvases.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( FEnvases );
end;

function SeleccionaEnvases( const AForm: TForm; const AControl: TControl;
                           var AResultado: string ): Boolean;
begin
  FEnvases:= TFEnvases.Create( AForm );

  FEnvases.Left:= AControl.ClientOrigin.X;
  FEnvases.Top:= AControl.ClientOrigin.Y + AControl.Height;

  FEnvases.FiltrarClientes;

  try
    FEnvases.ShowModal;
    result:= FEnvases.bFlag;
    if result then
      AResultado:= FEnvases.Query.Fields[1].AsString;
  finally
    FreeAndNil( FEnvases );
  end;
end;


procedure TFEnvases.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TFEnvases.FormShow(Sender: TObject);
begin
  bFlag:= False;
end;

procedure TFEnvases.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFEnvases.FiltrarClientes;
begin
  with FEnvases.Query do
  begin
    DisableControls;
    Close;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT envase_e Envase, descripcion_e Nombre ' +
          ' FROM frf_envases ');
    if edtFiltro.Text <> '' then
    begin
      SQL.Add('Where descripcion_e LIKE ''%' + edtFiltro.Text + '%'' ');
    end;

    SQL.Add('ORDER BY envase_e ');
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

procedure TFEnvases.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TFEnvases.btnFiltrarClick(Sender: TObject);
begin
  FiltrarClientes;
end;

procedure TFEnvases.edtFiltroKeyUp(Sender: TObject; var Key: Word;
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

procedure TFEnvases.edtFiltroChange(Sender: TObject);
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
