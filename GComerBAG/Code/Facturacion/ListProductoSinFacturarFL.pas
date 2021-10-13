unit ListProductoSinFacturarFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit;

type
  TFLListProductoSinFacturar = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    lblEmpresa: TnbLabel;
    etqEmpresa: TnbStaticText;
    lblFechaDesde: TnbLabel;
    edtFechaHasta: TBEdit;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    etqProducto: TnbStaticText;
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
    procedure edtProductoChange(Sender: TObject);
  private
    { Private declarations }
    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     ListProductoSinFacturarQL, ListProductoSinFacturarDL, DB, UDMConfig;

procedure TFLListProductoSinFacturar.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := gsDefEmpresa;
  edtFechaHasta.Text := DateToStr( Date );

  ListProductoSinFacturarQL.LoadReport( Self );

  edtEmpresa.ReadOnly:= not DMConfig.EsLaFont;
  if edtEmpresa.Enabled then
    edtEmpresa.Text:= gsDefEmpresa;
end;

procedure TFLListProductoSinFacturar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;

  ListProductoSinFacturarQL.UnloadReport;
end;

procedure TFLListProductoSinFacturar.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLListProductoSinFacturar.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFLListProductoSinFacturar.ValidarEntrada: Boolean;
begin
  result := false;
  //El codigo de empresa es obligatorio
  if Trim( edtEmpresa.Text ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('El código de empresa es obligatorio.');
    Exit;
  end;


  //Comprobar que las fechas sean correctas
  try
    StrToDate(edtFechaHasta.Text);
  except
    edtFechaHasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;

  result := true;
end;

procedure TFLListProductoSinFacturar.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLListProductoSinFacturar.btnAceptarClick(Sender: TObject);
var
  Parametros: RParametrosListProductoSinFacturar;
begin
  if ValidarEntrada then
  begin
    Parametros.sEmpresa:= edtEmpresa.Text;
    Parametros.sProducto:= edtProducto.Text;
    Parametros.dFechaHasta:= StrToDate( edtFechaHasta.Text );
    ListProductoSinFacturarQL.ExecuteReport( Self, Parametros );
  end;
end;

procedure TFLListProductoSinFacturar.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
end;

procedure TFLListProductoSinFacturar.edtProductoChange(Sender: TObject);
begin
  etqProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
end;

end.
