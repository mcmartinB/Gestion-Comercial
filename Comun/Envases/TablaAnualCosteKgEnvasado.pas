unit TablaAnualCosteKgEnvasado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids, nbEdits,
  nbCombos, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlue, dxSkinBlueprint, dxSkinFoggy,
  dxSkinMoneyTwins, Menus, cxButtons, SimpleSearch, cxTextEdit, dxSkinBlack,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TFTablaAnualCosteKgEnvasado = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    empresa: TBEdit;
    nbLabel1: TnbLabel;
    des_empresa: TnbStaticText;
    nbLabel4: TnbLabel;
    des_centro: TnbStaticText;
    nbLabel2: TnbLabel;
    fechaHasta: TnbDBCalendarCombo;
    nbLabel5: TnbLabel;
    producto: TBEdit;
    des_producto: TnbStaticText;
    centro: TBEdit;
    lblEnvase: TnbLabel;
    stEnvase: TnbStaticText;
    cbbTipo: TComboBox;
    lblCodigo1: TnbLabel;
    lblCliente: TnbLabel;
    edtCliente: TBEdit;
    stCliente: TnbStaticText;
    chkPromedios: TCheckBox;
    edtEnvase: TcxTextEdit;
    ssEnvase: TSimpleSearch;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure centroChange(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure edtEnvaseChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtEnvaseExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  TablaAnualCosteKgEnvasadoReport, UDMBaseDatos, bSQLUtils, bTextUtils;

procedure TFTablaAnualCosteKgEnvasado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFTablaAnualCosteKgEnvasado.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFTablaAnualCosteKgEnvasado.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
  productoChange(producto);
  centroChange(centro);
  edtEnvaseChange(edtEnvase);
  edtclienteChange(edtCliente);
end;

procedure TFTablaAnualCosteKgEnvasado.FormKeyDown(Sender: TObject; var Key: Word;
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


procedure TFTablaAnualCosteKgEnvasado.FormCreate(Sender: TObject);
var
  year, month, day: word;
begin
  FormType := tfOther;
  BHFormulario;

  {des_empresa.Caption:= desEmpresa( empresa.Text );
  des_centro.Caption:= desCentro( empresa.Text, centro.Text );
  des_producto.Caption:= desProducto( empresa.Text, producto.Text );}


  centro.Text := '';
  producto.Text := '';
  edtEnvase.Text:= '';
  edtCliente.Text:= '';
  empresa.Text := gsDefEmpresa;
  empresaChange(empresa);

  DecodeDate(Date, year, month, day);
  if month = 1 then
  begin
    year := year - 1;
    month := 12;
  end
  else
  begin
    Dec(month);
  end;
  fechaHasta.AsDate := Date;
end;

procedure TFTablaAnualCosteKgEnvasado.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFTablaAnualCosteKgEnvasado.centroChange(Sender: TObject);
begin
  if centro.Text = '' then
    des_centro.Caption := 'TODOS LOS CENTROS'
  else
    des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFTablaAnualCosteKgEnvasado.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text = '' then
    stCliente.Caption := 'TODOS LOS CLIENTES'
  else
    stCliente.Caption := desCliente(edtCliente.Text);
end;

procedure TFTablaAnualCosteKgEnvasado.edtEnvaseChange(Sender: TObject);
begin
  if edtEnvase.Text = '' then
    stEnvase.Caption := 'TODOS LOS ARTICULOS'
  else
    stEnvase.Caption := desEnvase(empresa.Text, edtEnvase.Text);
end;

procedure TFTablaAnualCosteKgEnvasado.edtEnvaseExit(Sender: TObject);
begin
  if EsNumerico(edtEnvase.Text) and (Length(edtEnvase.Text) <= 5) then
    if (edtEnvase.Text <> '' ) and (Length(edtEnvase.Text) < 9) then
      edtEnvase.Text := 'COM-' + Rellena( edtEnvase.Text, 5, '0');
end;

procedure TFTablaAnualCosteKgEnvasado.btnAceptarClick(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if des_empresa.Caption = '' then
  begin
    empresa.SetFocus;
    ShowMessage('Falta código de la empresa o es incorrecto');
  end
  else
  if des_centro.Caption = '' then
  begin
    centro.SetFocus;
    ShowMessage('El código del centro es incorrecto');
  end
  else
  if des_producto.Caption = '' then
  begin
    producto.SetFocus;
    ShowMessage('El código del producto es incorrecto');
  end
  else
  if stCliente.Caption = '' then
  begin
    edtCliente.SetFocus;
    ShowMessage('El código del cliente es incorrecto');
  end
  else
  if stEnvase.Caption = '' then
  begin
    edtEnvase.SetFocus;
    ShowMessage('El código del artículo es incorrecto');
  end
  else
  if not TryStrToDate( fechaHasta.Text, dFecha ) then
  begin
    fechaHasta.SetFocus;
    ShowMessage('Falta fecha hasta o es incorrecta');
  end
  else
  begin
    QRTablaAnualCosteKgEnvasadoPrint(Empresa.Text, Centro.Text, Producto.Text, edtEnvase.Text, edtCliente.Text, fechaHasta.AsDate, cbbTipo.ItemIndex, chkPromedios.Checked )
  end;
end;

procedure TFTablaAnualCosteKgEnvasado.productoChange(Sender: TObject);
begin
  if producto.Text = '' then
    des_producto.Caption := 'VACIO TODOS LOS PRODUCTOS'
  else
    des_producto.Caption := desproducto(empresa.Text, producto.Text);
end;

procedure TFTablaAnualCosteKgEnvasado.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if Producto.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' + Producto.Text;
end;

end.
