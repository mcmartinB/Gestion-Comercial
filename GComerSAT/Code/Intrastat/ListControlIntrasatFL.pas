unit ListControlIntrasatFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, nbCombos, nbEdits, CGlobal;

type
  TFLListControlIntrasat = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    lblEmpresa: TnbLabel;
    etqEmpresa: TnbStaticText;
    cbxTipo: TComboBox;
    edtPais: TBEdit;
    etqPais: TnbStaticText;
    cbbEmpresa: TComboBox;
    Label2: TLabel;
    producto: TnbDBSQLCombo;
    STProducto: TStaticText;
    lblFechaDesde: TnbLabel;
    lblFechaHasta: TnbLabel;
    edtFechaDesde: TBEdit;
    edtFechaHasta: TBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure cbxTipoChange(Sender: TObject);
    procedure edtPaisChange(Sender: TObject);
    procedure cbbEmpresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    function productoGetSQL: string;
  private
    { Private declarations }
    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     ListControlIntrasatQL, ListControlIntrasatDL, DB;

procedure TFLListControlIntrasat.FormCreate(Sender: TObject);
var
  fecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  if gProgramVersion = pvSAT then
  begin
    edtEmpresa.Text := '050';
    cbbempresa.ItemIndex := 0;
  end
  else
  begin
    edtEmpresa.Text := 'F17';
    cbbempresa.ItemIndex := 1;
  end;

  producto.Text := '';
  productoChange(Sender);
  fecha:= LunesAnterior( Date );
  edtFechaDesde.Text := DateToStr(fecha - 7);
  edtFechaHasta.Text := DateToStr(fecha - 1);

  ListControlIntrasatQL.LoadReport( Self );
end;

procedure TFLListControlIntrasat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;

  ListControlIntrasatQL.UnloadReport;
end;

procedure TFLListControlIntrasat.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLListControlIntrasat.productoChange(Sender: TObject);
begin
  if producto.Text = '' then
  begin
    STProducto.Caption := 'TODOS LOS PRODUCTOS.';
  end
  else
  begin
    STProducto.Caption := desProducto('050', producto.Text);
  end;
end;

function TFLListControlIntrasat.productoGetSQL: string;
begin
  result := 'select producto_p, descripcion_p from frf_productos order by producto_p ';
end;

procedure TFLListControlIntrasat.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    vk_escape:
      begin
        btnCancelar.Click;
      end;
    vk_f1:
      begin
        btnAceptar.Click;
      end;
  end;
end;

function TFLListControlIntrasat.ValidarEntrada: Boolean;
var
  desde, hasta: TDate;
begin
  result := false;
  //El codigo de empresa es obligatorio
  if cbbEmpresa.ItemIndex = 1 then
  begin
    if Trim( edtEmpresa.Text ) = '' then
    begin
      edtEmpresa.SetFocus;
      ShowMessage('Falta el código de empresa es incorrecto.');
      Exit;
    end;
  end;

  if STProducto.Caption = '' then
  begin
    ShowMessage('El código del producto es incorrecto');
    producto.SetFocus;
    Exit;
  end;


  //Comprobar que las fechas sean correctas
  try
    desde := StrToDate(edtFechaDesde.Text);
  except
    edtFechaDesde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  try
    hasta := StrToDate(edtFechaHasta.Text);
  except
    edtFechaHasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;

  //Comprobar que el rango sea correcto
  if desde > hasta then
  begin
    edtFechaDesde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;
  result := true;
end;

procedure TFLListControlIntrasat.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLListControlIntrasat.btnAceptarClick(Sender: TObject);
var
  Parametros: RParametrosListControlIntrasat;
begin
  if ValidarEntrada then
  begin
    Parametros.bGrupoEmp:= cbbEmpresa.ItemIndex;
    if Parametros.bGrupoEmp = 0 then
      Parametros.sEmpresa:= '050'
    else if Parametros.bGrupoEmp = 1 then
      Parametros.sEmpresa:= 'F17'
    else
      Parametros.sEmpresa:= edtEmpresa.Text;
    Parametros.dFechaDesde:= StrToDate( edtFechaDesde.Text );
    Parametros.dFechaHasta:= StrToDate( edtFechaHasta.Text );
    Parametros.iTipo:= cbxTipo.ItemIndex;
    Parametros.sPais:= edtPais.Text;
    Parametros.sProducto := producto.Text;
    ListControlIntrasatQL.ExecuteReport( Self, Parametros );
  end;
end;

procedure TFLListControlIntrasat.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
end;

procedure TFLListControlIntrasat.cbxTipoChange(Sender: TObject);
begin
  if cbxTipo.ItemIndex = 3 then
  begin
    edtPais.Enabled:= True;
  end
  else
  begin
    edtPais.Enabled:= False;
    edtPais.Text:= '';
  end;
end;

procedure TFLListControlIntrasat.edtPaisChange(Sender: TObject);
begin
  etqPais.Caption:= desPais( edtPais.Text );
end;

procedure TFLListControlIntrasat.cbbEmpresaChange(Sender: TObject);
begin
  edtEmpresa.Enabled:= cbbEmpresa.ItemIndex = 2;
end;

end.
