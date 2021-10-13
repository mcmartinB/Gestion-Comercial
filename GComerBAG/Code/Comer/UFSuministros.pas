unit UFSuministros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons;

type
  TFSuministros = class(TForm)
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

    procedure FiltrarSuministros;
  public
    { Public declarations }
    bFlag: boolean;
    sEmpresa: string;
    sCliente: string;
  end;

  procedure InicializaModulo( const ABaseDatos: string );
  procedure FinalizaModulo;


  function SeleccionaSuministros( const AForm: TForm; const AControl: TControl;
    const AEmpresa, ACliente: string; var AResultado: string ): Boolean;

implementation

{$R *.dfm}

var
  FSuministros: TFSuministros;

procedure InicializaModulo( const ABaseDatos: string );
begin
  FSuministros:= TFSuministros.Create( Application );
  FSuministros.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( FSuministros );
end;

function SeleccionaSuministros( const AForm: TForm; const AControl: TControl;
                           const AEmpresa, ACliente: string; var AResultado: string ): Boolean;
begin
  FSuministros:= TFSuministros.Create( AForm );

  FSuministros.Left:= AControl.ClientOrigin.X;
  FSuministros.Top:= AControl.ClientOrigin.Y + AControl.Height;

  FSuministros.sEmpresa:= AEmpresa;
  FSuministros.sCliente:= ACliente;
  FSuministros.FiltrarSuministros;

  try
    FSuministros.ShowModal;
    result:= FSuministros.bFlag;
    if result then
      AResultado:= FSuministros.Query.Fields[1].AsString;
  finally
    FreeAndNil( FSuministros );
  end;
end;


procedure TFSuministros.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TFSuministros.FormShow(Sender: TObject);
begin
  bFlag:= False;
end;

procedure TFSuministros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFSuministros.FiltrarSuministros;
var
  sWhere: string;
begin
  with FSuministros.Query do
  begin
    DisableControls;
    Close;
    SQL.Clear;


    SQL.Add('SELECT DISTINCT cliente_ds Cliente, dir_sum_ds Suministro, nombre_ds Nombre' +
          ' FROM frf_dir_sum ' +
          ' WHERE fecha_baja_ds is null ');
    sWhere:= '';
    if Trim(sCliente) <> '' then
    begin
      sWhere:= sWhere + ' AND cliente_ds = :cliente ';
    end;
    if edtFiltro.Text <> '' then
    begin
      if sWhere <> '' then
        sWhere:= sWhere + #13 + #10 + '  and nombre_ds LIKE ''%' + edtFiltro.Text + '%'' '
      else
        sWhere:= sWhere + 'and nombre_ds LIKE ''%' + edtFiltro.Text + '%'' ';
    end;
    SQL.Add( sWhere );
    SQL.Add('ORDER BY cliente_ds, dir_sum_ds ');

    if Trim(sCliente) <> '' then
    begin
      ParamByName('cliente').AsString:= sCliente;
    end;

    try
      Open;
    finally
      EnableControls;
    end;
  end;
end;

procedure TFSuministros.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TFSuministros.btnFiltrarClick(Sender: TObject);
begin
  FiltrarSuministros;
end;

procedure TFSuministros.edtFiltroKeyUp(Sender: TObject; var Key: Word;
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
