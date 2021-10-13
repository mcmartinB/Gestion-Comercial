unit UFFormaPago;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, Buttons, DBCtrls;

type
  TFFormaPago = class(TForm)
    DBGrid: TDBGrid;
    Query: TQuery;
    DataSource: TDataSource;
    edtFiltro: TEdit;
    btnFiltrar: TSpeedButton;
    Label1: TLabel;
    qryFormaPago: TQuery;
    dlbldescripcion6_fp: TDBText;
    dlbldescripcion5_fp: TDBText;
    dlbldescripcion8_fp: TDBText;
    dlbldescripcion7_fp: TDBText;
    dlbldescripcion2_fp: TDBText;
    dlbldescripcion_fp: TDBText;
    dlbldescripcion4_fp: TDBText;
    dlbldescripcion3_fp: TDBText;
    dlbldescripcion9_fp: TDBText;
    dsFormaPago: TDataSource;
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFiltrarClick(Sender: TObject);
    procedure edtFiltroKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure QueryAfterOpen(DataSet: TDataSet);
    procedure QueryBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }

    procedure FiltrarFormaPago;
  public
    { Public declarations }
    bFlag: boolean;

  end;

  (*
  procedure InicializaModulo( const ABaseDatos: string );
  procedure FinalizaModulo;
  *)

  function SeleccionaFormaPago( const AForm: TForm; const AControl: TControl; var AResultado: string ): Boolean;

implementation

{$R *.dfm}

var
  FFormaPago: TFFormaPago;

(*
procedure InicializaModulo( const ABaseDatos: string );
begin
  FFormaPago:= TFFormaPago.Create( Application );
  FFormaPago.Query.DatabaseName:= ABaseDatos;
end;

procedure FinalizaModulo;
begin
  FreeAndNil( FFormaPago );
end;
*)

function SeleccionaFormaPago( const AForm: TForm; const AControl: TControl;
                                  var AResultado: string ): Boolean;
begin
  FFormaPago:= TFFormaPago.Create( AForm );

  FFormaPago.Left:= AControl.ClientOrigin.X;
  FFormaPago.Top:= AControl.ClientOrigin.Y + AControl.Height;

  FFormaPago.FiltrarFormaPago;
  try
    FFormaPago.ShowModal;
    result:= FFormaPago.bFlag;
    if result then
      AResultado:= FFormaPago.Query.Fields[0].AsString;
  finally
    FreeAndNil( FFormaPago );
  end;
end;


procedure TFFormaPago.DBGridDblClick(Sender: TObject);
begin
  bFlag:= True;
  Close;
end;

procedure TFFormaPago.FormShow(Sender: TObject);
begin
  bFlag:= False;
end;

procedure TFFormaPago.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFFormaPago.FiltrarFormaPago;
begin
  with FFormaPago.Query do
  begin
    DisableControls;
    Close;
    SQL.Clear;
    SQL.Add('select codigo_fp codigo, descripcion_fp descripcion from frf_forma_pago ');

    if edtFiltro.Text <> '' then
    begin
        SQL.Add('where( descripcion_fp like ''%' + edtFiltro.Text + '%'' ');
        SQL.Add('       or descripcion2_fp like ''%' + edtFiltro.Text + '%'' ');
        SQL.Add('       or descripcion3_fp like ''%' + edtFiltro.Text + '%'' ');
        SQL.Add('       or descripcion4_fp like ''%' + edtFiltro.Text + '%'' ');
        SQL.Add('       or descripcion5_fp like ''%' + edtFiltro.Text + '%'' ');
        SQL.Add('       or descripcion6_fp like ''%' + edtFiltro.Text + '%'' ');
        SQL.Add('       or descripcion7_fp like ''%' + edtFiltro.Text + '%'' ');
        SQL.Add('       or descripcion8_fp like ''%' + edtFiltro.Text + '%'' ');
        SQL.Add('       or descripcion8_fp like ''%' + edtFiltro.Text + '%'' ) ');
    end;

    SQL.Add('ORDER BY descripcion_fp ');
    try
      Open;
    finally
      EnableControls;
    end;
  end;
end;

procedure TFFormaPago.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TFFormaPago.btnFiltrarClick(Sender: TObject);
begin
  FiltrarFormaPago;
end;

procedure TFFormaPago.edtFiltroKeyUp(Sender: TObject; var Key: Word;
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

procedure TFFormaPago.FormCreate(Sender: TObject);
begin
  qryFormaPago.SQL.Clear;
  qryFormaPago.SQL.Add(' select * from frf_forma_pago where codigo_fp = :codigo ');
end;

procedure TFFormaPago.QueryAfterOpen(DataSet: TDataSet);
begin
  qryFormaPago.Open;
end;

procedure TFFormaPago.QueryBeforeClose(DataSet: TDataSet);
begin
  qryFormaPago.Close;
end;

end.
