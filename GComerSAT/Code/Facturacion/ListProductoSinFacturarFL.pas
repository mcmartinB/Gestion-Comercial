unit ListProductoSinFacturarFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ComCtrls, BCalendario,
  Grids, DBGrids, BGrid, BCalendarButton, BSpeedButton, BGridButton;

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
    lblCliente: TnbLabel;
    edtCliente: TBEdit;
    stCliente: TnbStaticText;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    btnEmpresa: TBGridButton;
    btnCliente: TBGridButton;
    btnHasta: TBCalendarButton;
    btnProducto: TBGridButton;
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
    procedure edtClienteChange(Sender: TObject);
    procedure btnButtonClick(Sender: TObject);
  private
    { Private declarations }
    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     ListProductoSinFacturarQL, ListProductoSinFacturarDL, DB, UDMBaseDatos,
     CAuxiliarDB;

procedure TFLListProductoSinFacturar.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtProducto.Tag := kProducto;
  edtCliente.Tag := kCliente;
  edtFechaHasta.Tag := kCalendar;

  edtEmpresa.Text := gsDefEmpresa;
  edtFechaHasta.Text := DateToStr( Date );

  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  CalendarioFlotante.Date := Date;

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;

  ListProductoSinFacturarQL.LoadReport( Self );
end;

procedure TFLListProductoSinFacturar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  
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
    vk_F2:
      begin
        Key := 0;
        btnButtonClick( ActiveControl );
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

  if Trim( etqProducto.Caption ) = '' then
  begin
    edtProducto.SetFocus;
    ShowMessage('El código de producto es incorrecto.');
    Exit;
  end;
  if Trim( stCliente.Caption ) = '' then
  begin
    edtCliente.SetFocus;
    ShowMessage('El código de cliente es incorrecto.');
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
    Parametros.sEmpresa:= Trim( edtEmpresa.Text );
    Parametros.sProducto:= Trim( edtProducto.Text );
    Parametros.sCliente:= Trim( edtCliente.Text );
    Parametros.dFechaHasta:= StrToDate( edtFechaHasta.Text );
    ListProductoSinFacturarQL.ExecuteReport( Self, Parametros );
  end;
end;

procedure TFLListProductoSinFacturar.edtEmpresaChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  edtProductoChange( edtProducto );
  edtClienteChange( edtCliente );
end;

procedure TFLListProductoSinFacturar.edtProductoChange(Sender: TObject);
begin
      if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if edtProducto.Text <> '' then
    etqProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text )
  else
    etqProducto.Caption:= 'TODOS LOS PRODUCTOS';
end;

procedure TFLListProductoSinFacturar.edtClienteChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;

  if edtCliente.Text <> '' then
    stCliente.Caption:= desCliente( edtCliente.Text )
  else
    stCliente.Caption:= 'TODOS LOS CLIENTES';
end;

procedure TFLListProductoSinFacturar.btnButtonClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente, [edtEmpresa.Text]);
    kCalendar: DespliegaCalendario(btnHasta);
  end;
end;

end.
