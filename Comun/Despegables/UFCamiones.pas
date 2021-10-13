unit UFCamiones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons;

type
  TFCamiones = class(TForm)
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

    procedure FiltrarCamiones;
  public
    { Public declarations }
    bFlag: boolean;
  end;

  procedure InicializaModulo( const ABaseDatos: string );
  procedure FinalizaModulo;


  function SeleccionaCamion( const AForm: TForm; const AControl: TControl; var AResultado: string ): Boolean;

implementation

{$R *.dfm}

var
  FCamion: TFCamiones;

procedure InicializaModulo( const ABaseDatos: string );
begin
  FCamion:= TFCamiones.Create( Application );
  FCamion.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( FCamion );
end;

function SeleccionaCamion( const AForm: TForm; const AControl: TControl; var AResultado: string ): Boolean;
begin
  FCamion:= TFCamiones.Create( AForm );

  FCamion.Left:= AControl.ClientOrigin.X;
  FCamion.Top:= AControl.ClientOrigin.Y + AControl.Height;

  FCamion.FiltrarCamiones;

  try
    FCamion.ShowModal;
    result:= FCamion.bFlag;
    if result then
      AResultado:= FCamion.Query.Fields[0].AsString;
  finally
    FreeAndNil( FCamion );
  end;
end;


procedure TFCamiones.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TFCamiones.FormShow(Sender: TObject);
begin
  bFlag:= False;
  edtFiltro.SetFocus;
end;

procedure TFCamiones.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFCamiones.FiltrarCamiones;
begin
  with FCamion.Query do
  begin
    DisableControls;
    Close;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT camion_c Transporte, descripcion_c Nombre ' +
          ' FROM frf_camiones where 1 = 1 ');
    if edtFiltro.Text <> '' then
    begin
      SQL.Add('and descripcion_c LIKE ''%' + edtFiltro.Text + '%'' ');
    end;

    SQL.Add('ORDER BY camion_c ');
    try
      Open;
    finally
      EnableControls;
    end;
  end;
end;

procedure TFCamiones.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TFCamiones.btnFiltrarClick(Sender: TObject);
begin
  FiltrarCamiones;
end;

procedure TFCamiones.edtFiltroKeyUp(Sender: TObject; var Key: Word;
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
