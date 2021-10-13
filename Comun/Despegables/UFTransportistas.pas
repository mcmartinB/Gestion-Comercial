unit UFTransportistas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons;

type
  TFTransportistas = class(TForm)
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

    procedure FiltrarTransportistas;
  public
    { Public declarations }
    bFlag: boolean;
    sEmpresa: string;
  end;

  procedure InicializaModulo( const ABaseDatos: string );
  procedure FinalizaModulo;


  function SeleccionaTransportista( const AForm: TForm; const AControl: TControl; const AEmpresa: string; var AResultado: string ): Boolean;

implementation

{$R *.dfm}

var
  FTransportista: TFTransportistas;

procedure InicializaModulo( const ABaseDatos: string );
begin
  FTransportista:= TFTransportistas.Create( Application );
  FTransportista.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( FTransportista );
end;

function SeleccionaTransportista( const AForm: TForm; const AControl: TControl;
                           const AEmpresa: string; var AResultado: string ): Boolean;
begin
  FTransportista:= TFTransportistas.Create( AForm );

  FTransportista.Left:= AControl.ClientOrigin.X;
  FTransportista.Top:= AControl.ClientOrigin.Y + AControl.Height;

  FTransportista.sEmpresa:= AEmpresa;
  FTransportista.FiltrarTransportistas;

  try
    FTransportista.ShowModal;
    result:= FTransportista.bFlag;
    if result then
      AResultado:= FTransportista.Query.Fields[0].AsString;
  finally
    FreeAndNil( FTransportista );
  end;
end;


procedure TFTransportistas.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TFTransportistas.FormShow(Sender: TObject);
begin
  bFlag:= False;
end;

procedure TFTransportistas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFTransportistas.FiltrarTransportistas;
begin
  with FTransportista.Query do
  begin
    DisableControls;
    Close;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT transporte_t Transporte, descripcion_t Nombre ' +
          ' FROM frf_transportistas ');
    if edtFiltro.Text <> '' then
    begin
      SQL.Add('Where descripcion_t LIKE ''%' + edtFiltro.Text + '%'' ');
    end;

    SQL.Add('ORDER BY transporte_t ');
    try
      Open;
    finally
      EnableControls;
    end;
  end;
end;

procedure TFTransportistas.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TFTransportistas.btnFiltrarClick(Sender: TObject);
begin
  FiltrarTransportistas;
end;

procedure TFTransportistas.edtFiltroKeyUp(Sender: TObject; var Key: Word;
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
