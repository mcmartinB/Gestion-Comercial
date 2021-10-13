unit MListTransitos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, Buttons, nbLabels, ActnList;

type
  TFMListTransitos = class(TForm)
    empresaDesde: TnbDBSQLCombo;
    centroDesde: TnbDBSQLCombo;
    fechaDesde: TnbDBCalendarCombo;
    fechaHasta: TnbDBCalendarCombo;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    empresaHasta: TnbDBSQLCombo;
    centroHasta: TnbDBSQLCombo;
    cbxFecha: TComboBox;
    nbLabel3: TnbLabel;
    productoDesde: TnbDBSQLCombo;
    productoHasta: TnbDBSQLCombo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxFechaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function GetQuery: string;
  public
    { Public declarations }
  end;

  procedure ListadoDeTransitos;
  procedure ListadoControlDeTransitos;

implementation

uses bSQLUtils, LTransitos, LListTransitosControl;

var query, periodo: string;

{$R *.dfm}

procedure ListadoDeTransitos;
var
 FMListTransitos: TFMListTransitos;
begin
  query:= 'inicio';
  FMListTransitos:= TFMListTransitos.Create( Application );
  while query <> '' do
  begin
    FMListTransitos.ShowModal;
    if query <> '' then LTransitos.Listado( query, periodo );
  end;
end;

procedure ListadoControlDeTransitos;
var
 FMListTransitos: TFMListTransitos;
begin
  query:= 'inicio';
  FMListTransitos:= TFMListTransitos.Create( Application );
  while query <> '' do
  begin
    FMListTransitos.ShowModal;
    if query <> '' then
      LListTransitosControl.Listado( query, periodo );
  end;
end;

procedure TFMListTransitos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if query = '' then
    Action:= caFree
  else
    Action:= caHide;
end;

procedure TFMListTransitos.btnCancelClick(Sender: TObject);
begin
  query:= '';
  periodo:= '';
  Self.Close;
end;

procedure TFMListTransitos.btnOkClick(Sender: TObject);
begin
  query:= GetQuery;
  periodo:= 'Periodo: ' + fechaDesde.Text + ' - ' + fechaHasta.Text;
  Self.Close;
end;

procedure TFMListTransitos.FormCreate(Sender: TObject);
begin
  empresaDesde.Text:= '0';
  empresaHasta.Text:= 'ZZZ';
  centroDesde.Text:= '0';
  centroHasta.Text:= 'Z';
  productoDesde.Text:= '0';
  productoHasta.Text:= 'Z';
  fechaDesde.AsDate:= Date;
  fechaHasta.AsDate:= Date;
end;

function TFMListTransitos.GetQuery: string;
begin
  result:= ' where empresa_tc ' + SQLRangeS( empresaDesde.Text, empresaHasta.Text );
  result:= result + ' and centro_tc ' + SQLRangeS( centroDesde.Text, centroHasta.Text );
  result:= result + ' and producto_tl ' + SQLRangeS( productoDesde.Text, productoHasta.Text );
  if cbxFecha.ItemIndex = 0 then
    result:= result + ' and fecha_tc ' + SQLRangeS( fechaDesde.Text, fechaHasta.Text )
  else
    result:= result + ' and fecha_duaent_tc ' + SQLRangeS( fechaDesde.Text, fechaHasta.Text );
end;

procedure TFMListTransitos.cbxFechaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Return then
  begin
    Key := 0;
    PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
  end
  else
  if Key = vk_F2 then
  begin
    cbxFecha.DroppedDown:= not cbxFecha.DroppedDown;
  end;
end;

procedure TFMListTransitos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_F1 then
  begin
    btnOk.Click;
  end
  else
  if Key = vk_ESCAPE then
  begin
    btnCancel.Click;
  end;
end;

end.
