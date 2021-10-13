unit ListEntregasSinAsociarFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit;

type
  TFLListEntregasSinAsociar = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    lblEmpresa: TnbLabel;
    etqEmpresa: TnbStaticText;
    lblFechaDesde: TnbLabel;
    edtFechaDesde: TBEdit;
    lblFechaHasta: TnbLabel;
    edtFechaHasta: TBEdit;
    lblProveedor: TnbLabel;
    etqProveedor: TnbStaticText;
    lblProducto: TnbLabel;
    etqProducto: TnbStaticText;
    Label2: TLabel;
    Label3: TLabel;
    edtProveedor: TBEdit;
    edtProducto: TBEdit;
    nbLabel1: TnbLabel;
    edtAlmacen: TBEdit;
    etqAlmacen: TnbStaticText;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtProveedorChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure edtAlmacenChange(Sender: TObject);
  private
    { Private declarations }
    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     ListEntregasSinAsociarQL, ListEntregasSinAsociarDL, DB;

procedure TFLListEntregasSinAsociar.FormCreate(Sender: TObject);
var
  fecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := gsDefEmpresa;
  fecha:= LunesAnterior( Date );
  edtFechaDesde.Text := DateToStr(fecha - 7);
  edtFechaHasta.Text := DateToStr(fecha - 1);

  ListEntregasSinAsociarQL.LoadReport( Self );
end;

procedure TFLListEntregasSinAsociar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;

  ListEntregasSinAsociarQL.UnloadReport;
end;

procedure TFLListEntregasSinAsociar.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLListEntregasSinAsociar.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFLListEntregasSinAsociar.ValidarEntrada: Boolean;
var
  desde, hasta: TDate;
begin
  result := false;
  //El codigo de empresa es obligatorio
  if Trim( edtEmpresa.Text ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('El código de empresa es obligatorio.');
    Exit;
  end;

  if Trim( edtAlmacen.Text ) <> '' then
  begin
    if Trim( edtProveedor.Text ) = '' then
    begin
      edtProveedor.SetFocus;
      ShowMessage('Si el almacén no esta vacio el proveedor tiene que tener valor.');
      Exit;
    end;
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

procedure TFLListEntregasSinAsociar.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLListEntregasSinAsociar.btnAceptarClick(Sender: TObject);
var
  Parametros: RListEntregasSinAsociar;
begin
  if ValidarEntrada then
  begin
    Parametros.sEmpresa:= edtEmpresa.Text;
    Parametros.sProveedor:= edtProveedor.Text;
    Parametros.sProducto:= edtProducto.Text;
    Parametros.dFechaDesde:= StrToDate( edtFechaDesde.Text );
    Parametros.dFechaHasta:= StrToDate( edtFechaHasta.Text );
    ListEntregasSinAsociarQL.ExecuteReport( Self, Parametros );
  end;
end;

procedure TFLListEntregasSinAsociar.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
end;

procedure TFLListEntregasSinAsociar.edtProveedorChange(Sender: TObject);
begin
  etqProveedor.Caption := desProveedor( edtEmpresa.Text, edtProveedor.Text );
end;

procedure TFLListEntregasSinAsociar.edtProductoChange(Sender: TObject);
begin
  etqproducto.Caption := desProducto( edtEmpresa.Text, edtProducto.Text );
end;

procedure TFLListEntregasSinAsociar.edtAlmacenChange(Sender: TObject);
begin
  etqAlmacen.Caption := desProveedorAlmacen( edtEmpresa.Text, edtProveedor.Text, edtAlmacen.Text );
end;

end.
