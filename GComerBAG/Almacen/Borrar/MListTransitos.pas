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
    nbLabel2: TnbLabel;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    cbxFecha: TComboBox;
    nbLabel3: TnbLabel;
    productoDesde: TnbDBSQLCombo;
    chkPaletsProveedor: TCheckBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lblTransito: TnbLabel;
    eTransito: TnbDBNumeric;
    lblEmpresa: TnbLabel;
    chkCodEntrega: TCheckBox;
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
    function GetQuery( var AQuery2: string ): string;
  public
    { Public declarations }
  end;

  procedure ListadoDeTransitos;
  procedure ListadoControlDeTransitos;

implementation

uses bSQLUtils, LTransitos, LListTransitosControl, CVariables, Principal,
     CGestionPrincipal, UDMConfig;

var query1, query2, periodo: string;

{$R *.dfm}

procedure ListadoDeTransitos;
var
 FMListTransitos: TFMListTransitos;
begin
  query1:= 'inicio';
  query2:= '';
  FMListTransitos:= TFMListTransitos.Create( Application );
  FMListTransitos.chkPaletsProveedor.Visible:= not DMConfig.EsLaFont;
  FMListTransitos.chkCodEntrega.Visible:= not DMConfig.EsLaFont;
  while query1 <> '' do
  begin
    FMListTransitos.FormStyle:= fsNormal;
    FMListTransitos.ShowModal;
    if query1 <> '' then LTransitos.Listado( query1, periodo, query2, FMListTransitos.chkCodEntrega.Checked,
                                                              FMListTransitos.chkPaletsProveedor.Checked );
  end;
end;

procedure ListadoControlDeTransitos;
var
 FMListTransitos: TFMListTransitos;
begin
  query1:= 'inicio';
  query2:= '';
  FMListTransitos:= TFMListTransitos.Create( Application );
  FMListTransitos.chkPaletsProveedor.Visible:= False;
  FMListTransitos.chkCodEntrega.Visible:= False;
  while query1 <> '' do
  begin
    FMListTransitos.FormStyle:= fsNormal;
    FMListTransitos.ShowModal;
    if query1 <> '' then
      LListTransitosControl.Listado( query1, periodo );
  end;
end;

procedure TFMListTransitos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if query1 = '' then
  begin
    gRF := nil;
    gCF := nil;

    //if FPrincipal.MDIChildCount = 1 then
    begin
      FormType := tfDirector;
      BHFormulario;
    end;
    Action:= caFree
  end
  else
  begin
    Action:= caHide;
  end;
end;

procedure TFMListTransitos.btnCancelClick(Sender: TObject);
begin
  query1:= '';
  periodo:= '';
  Self.Close;
end;

procedure TFMListTransitos.btnOkClick(Sender: TObject);
begin
  query1:= GetQuery( query2 );
  periodo:= 'Periodo: ' + fechaDesde.Text + ' - ' + fechaHasta.Text;
  Self.Close;
end;

procedure TFMListTransitos.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  empresaDesde.Text:= gsDefEmpresa;
  centroDesde.Text:= '';
  productoDesde.Text:= '';
  fechaDesde.AsDate:= Date;
  fechaHasta.AsDate:= Date;
end;

function TFMListTransitos.GetQuery( var AQuery2: string ): string;
begin
  result:= ' where empresa_tc = ' + QuotedStr( empresaDesde.Text );

  if  centroDesde.Text <> '' then
    result:= result + ' and centro_tc = ' + QuotedStr( centroDesde.Text );

  if  eTransito.Text <> '' then
    result:= result + ' and referencia_tc = ' + eTransito.Text;

  if cbxFecha.ItemIndex = 0 then
    result:= result + ' and fecha_tc ' + SQLRangeS( fechaDesde.Text, fechaHasta.Text )
  else
    result:= result + ' and fecha_entrada_tc ' + SQLRangeS( fechaDesde.Text, fechaHasta.Text );

  AQuery2:= result;

  if  productoDesde.Text <> '' then
    result:= result + ' and producto_tl = ' + QuotedStr( productoDesde.Text );
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
