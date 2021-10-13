unit ComprobacionRetiradaFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, BSpeedButton, BGridButton,
  Grids, DBGrids, BGrid, ActnList;

type
  TFLComprobacionRetirada = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    edtFechaDesde: TBEdit;
    edtFechaHasta: TBEdit;
    lblEmpresa: TnbLabel;
    etqEmpresa: TnbStaticText;
    lblFechaHasta: TnbLabel;
    lblCliente: TnbLabel;
    edtCliente: TBEdit;
    etqCliente: TnbStaticText;
    cbbProcedencia: TComboBox;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    edtCentroOrigen: TBEdit;
    etqCentroOrigen: TnbStaticText;
    nbLabel3: TnbLabel;
    edtCentroSalida: TBEdit;
    etqCentroSalida: TnbStaticText;
    nbLabel4: TnbLabel;
    edtCategoria: TBEdit;
    lblNombre1: TLabel;
    cbbAbonos: TComboBox;
    lblCodigo1: TnbLabel;
    lblCodigo2: TnbLabel;
    cbbTipo: TComboBox;
    cbbTipoFecha: TComboBox;
    chkAgruparPorCliente: TCheckBox;
    lblCodigo3: TnbLabel;
    nbLabel5: TnbLabel;
    chkVerDetalle: TCheckBox;
    lblProducto: TnbLabel;
    edtProducto: TBEdit;
    desProducto: TnbStaticText;
    RejillaFlotante: TBGrid;
    btnProducto: TBGridButton;
    ListaAcciones: TActionList;
    ADesplegarRejilla: TAction;
    edtAgrupacion: TBEdit;
    BGBAgrupacion: TBGridButton;
    nbLabel6: TnbLabel;
    STAgrupacion: TnbStaticText;
    Label4: TLabel;
    BGBSerie: TBGridButton;
    edtSerie: TBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtCentroOrigenChange(Sender: TObject);
    procedure edtCentroSalidaChange(Sender: TObject);
    procedure cbbProcedenciaChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure btnProductoClick(Sender: TObject);
    procedure edtAgrupacionChange(Sender: TObject);
    procedure ADesplegarRejillaExecute(Sender: TObject);
  private
    { Private declarations }
    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  ComprobacionRetiradaQL, FacturacionCB, DB, UDMBaseDatos, CAuxiliarDB, CFactura;

procedure TFLComprobacionRetirada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;

  ComprobacionRetiradaQL.UnloadReport;
end;

procedure TFLComprobacionRetirada.FormCreate(Sender: TObject);
var
  fecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  edtSerie.Tag:= kSerie;
  edtProducto.Tag:= kProducto;
  edtAgrupacion.Tag := kAgrupacion;

  edtEmpresa.Text := '050';
  edtCliente.Text := '';
  edtProducto.Text := '';
  edtAgrupacion.Text := '';
  edtagrupacionChange(edtagrupacion);
  fecha:= LunesAnterior( Date );
  edtFechaDesde.Text := DateToStr(fecha - 7);
  edtFechaHasta.Text := DateToStr(fecha - 1);

  ComprobacionRetiradaQL.LoadReport( Self );
end;

procedure TFLComprobacionRetirada.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLComprobacionRetirada.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLComprobacionRetirada.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  edtClienteChange(edtCliente);
  edtCentroSalidaChange(edtCentroSalida);
  edtCentroOrigenChange(edtCentroOrigen);
  edtProductoChange(edtProducto);
end;

procedure TFLComprobacionRetirada.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text = '' then
    etqCliente.Caption := 'Vacío todos los clientes'
  else
    etqCliente.Caption := desCliente( edtCliente.Text );
end;

procedure TFLComprobacionRetirada.edtCentroSalidaChange(Sender: TObject);
begin
  if edtCentroSalida.Text = '' then
    etqCentroSalida.Caption := 'Vacío todos los centros de salida'
  else
    etqCentroSalida.Caption := desCentro( edtEmpresa.Text, edtCentroSalida.Text );
end;

procedure TFLComprobacionRetirada.edtAgrupacionChange(Sender: TObject);
begin
  if Trim( edtAgrupacion.Text ) = '' then
    STAgrupacion.Caption := 'TODAS LAS AGRUPACIONES'
  else
    STAgrupacion.Caption := desAgrupacion(edtAgrupacion.Text);
end;

procedure TFLComprobacionRetirada.edtCentroOrigenChange(Sender: TObject);
begin
  if edtCentroOrigen.Text = '' then
    etqCentroOrigen.Caption := 'Vacío todos los centros de origen'
  else
    etqCentroOrigen.Caption := desCentro( edtEmpresa.Text, edtCentroOrigen.Text );
end;

procedure TFLComprobacionRetirada.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFLComprobacionRetirada.ValidarEntrada: Boolean;
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

  if edtSerie.Text <> '' then
  begin
    if not ExisteSerieG( edtSerie.Text ) then
    begin
      edtSerie.SetFocus;
      ShowMessage('La serie indicada es incorrecta.');
      Exit;
    end;
  end;


  if Trim( etqCliente.Caption ) = '' then
  begin
    edtCliente.SetFocus;
    ShowMessage('El código del cliente es incorrecto.');
    Exit;
  end;

  if Trim( etqCentroOrigen.Caption ) = '' then
  begin
    edtCentroOrigen.SetFocus;
    ShowMessage('El código del centro es incorrecto.');
    Exit;
  end;

  if Trim( etqCentroSalida.Caption ) = '' then
  begin
    edtCentroSalida.SetFocus;
    ShowMessage('El código del centro es incorrecto.');
    Exit;
  end;

  if Trim( desProducto.Caption ) = '' then
  begin
    edtProducto.SetFocus;
    ShowMessage('El código del producto es incorrecto.');
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

  //abonos solo si fruta propia
  if ( cbbProcedencia.ItemIndex = 2 ) and ( cbbAbonos.ItemIndex = 2 ) then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('Los abonos solo se pueden sacar para la fruta propia.');
    Exit;
  end;

  //Grupo Berenjena y piemento solo 080
  if ( ( cbbTipo.ItemIndex = 2 ) or  ( cbbTipo.ItemIndex = 3 ) ) and ( edtEmpresa.Text <> '080' ) then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('Los tipos de fruta de Berenjenas y Pimientos solo se pueden seleccionar con la empresa ''080''.');
    Exit;
  end;

  if Trim( STAgrupacion.Caption ) = '' then
  begin
    edtAgrupacion.SetFocus;
    ShowMessage('El código de agrupación es incorrecto');
    Exit;
  end;

  result := true;
end;

procedure TFLComprobacionRetirada.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kSerie: DespliegaRejilla(BGBSerie);
    kAgrupacion: DespliegaRejilla(BGBAgrupacion);
  end;
end;

procedure TFLComprobacionRetirada.btnAceptarClick(Sender: TObject);
var
  Parametros: RClienteQL;
begin
  if ValidarEntrada then
  begin
    Parametros.sEmpresa:= edtEmpresa.Text;
    Parametros.sSerie:= edtSerie.Text;
    Parametros.sCliente:= edtCliente.Text;
    Parametros.bAgruparCliente:= chkAgruparPorCliente.Checked;
    Parametros.bVerDetalle:= chkVerDetalle.Checked;
    Parametros.sCentroOrigen:= edtCentroOrigen.Text;
    Parametros.sCentroSalida:= edtCentroSalida.Text;
    Parametros.sCategoria:= edtCategoria.Text;
    Parametros.bFechaFactura:= cbbTipoFecha.ItemIndex = 1;
    Parametros.dFechaDesde:= StrToDate( edtFechaDesde.Text );
    Parametros.dFechaHasta:= StrToDate( edtFechaHasta.Text );
    Parametros.iProcedencia:= cbbProcedencia.ItemIndex;
    Parametros.iTipo:= cbbTipo.ItemIndex;
    Parametros.sProducto:= edtProducto.Text;
    Parametros.iAbonos:= cbbAbonos.ItemIndex;
    Parametros.sAgrupacion:= edtAgrupacion.Text;

    ComprobacionRetiradaQL.ExecuteReport( Self, Parametros );
  end;
end;

procedure TFLComprobacionRetirada.cbbProcedenciaChange(Sender: TObject);
begin
  if cbbProcedencia.ItemIndex = 2 then
  begin
    cbbAbonos.Enabled:= False;
  end
  else
  begin
    cbbAbonos.Enabled:= True;
  end;
end;

procedure TFLComprobacionRetirada.edtProductoChange(Sender: TObject);
begin
  if edtProducto.Text = '' then
  begin
    desProducto.Caption:=  'TODOS LOS PRODUCTOS.';
  end
  else
  begin
    desProducto.Caption:=  UDMAuxDB.desProducto( edtEmpresa.Text, edtProducto.Text );
  end;
end;

procedure TFLComprobacionRetirada.btnProductoClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kProducto: DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
  end;
end;

end.
