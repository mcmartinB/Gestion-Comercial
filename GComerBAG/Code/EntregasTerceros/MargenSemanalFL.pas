unit MargenSemanalFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls,
  BCalendarButton, BSpeedButton, BGridButton, Grids, DBGrids, BGrid,
  ComCtrls, BCalendario;

type
  TFLMargenSemanal = class(TForm)
    btnCerrar: TBitBtn;
    btnAceptar: TBitBtn;
    lblNombre1: TLabel;
    eEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    lEmpresa: TStaticText;
    Desde: TLabel;
    eLunes: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lblNombre2: TLabel;
    eSemanas: TBEdit;
    lblNombre3: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    lProducto: TStaticText;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    chkExpandir: TCheckBox;
    chkCompra: TCheckBox;
    chkTransporte: TCheckBox;
    chkMaterial: TCheckBox;
    chkPersonal: TCheckBox;
    chkGeneral: TCheckBox;
    chkFinanciero: TCheckBox;
    chkTransito: TCheckBox;
    cbbRFCentral: TComboBox;
    lblCliente: TLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    txtCliente: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure botonClick(Sender: TObject);
    procedure PonNombreEmpresa(Sender: TObject);
    procedure PonNombreProducto(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure cbbRFCentralChange(Sender: TObject);
  private
    { Private declarations }

    sEmpresa, sCliente, sProducto: string;
    dFechaIni: TDateTime;
    iSemanas: integer;

    procedure ValidarCampos;
    procedure VerMargenSemanal;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB, MargenBCodeComunDL,
     UDMBaseDatos, UDMConfig, MargenBeneficiosDL, MargenBeneficiosCentralDL,
     bTimeUtils, CAuxiliarDB, DateUtils;

var
  CostesAplicar: RCostesAplicar;

procedure TFLMargenSemanal.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  edtCliente.Tag := kCliente;
  eProducto.Tag := kProducto;
  eLunes.Tag := kCalendar;

  eLunes.Text := DateToStr( LunesAnterior( date ) - 7 );
  eSemanas.Text := '1';

  eEmpresa.Text:= gsDefEmpresa;

  CalendarioFlotante.Date := Date - 1;
  PonNombreEmpresa( eEmpresa );
end;

procedure TFLMargenSemanal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;

  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLMargenSemanal.ValidarCampos;
begin
  //Comprobamos que los campos esten todos con datos
  if lEmpresa.caption = '' then
  begin
    EEmpresa.SetFocus;
    raise Exception.Create( 'Falta el código de la empresa o es incorrecto.');
  end;
  sEmpresa:= eEmpresa.Text;

  if txtCliente.Caption = '' then
  begin
    edtCliente.SetFocus;
    raise Exception.Create( 'El código del cliente es incorrecto.');
  end;
  sCliente:= edtCliente.Text;

  if lProducto.Caption = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create( 'El código del producto es incorrecto.');
  end;
  sProducto:= eProducto.Text;

  if not TryStrToDate( eLunes.Text, dFechaIni ) then
  begin
    eLunes.SetFocus;
    raise Exception.Create( 'La fecha de inicio es incorrecta.');
  end;
  If DayOfTheWeek( dFechaIni ) <> 1 then
  begin
    eLunes.SetFocus;
    raise Exception.Create( 'La fecha de inicio debe ser lunes.');
  end;
  iSemanas:= StrToIntDef( eSemanas.Text, 1);

  CostesAplicar.bCompra:= chkCompra.Checked;
  CostesAplicar.bTransporte:= chkTransporte.Checked;
  CostesAplicar.bTransito:= chkTransito.Checked;
  CostesAplicar.bMaterial:= chkMaterial.Checked;
  CostesAplicar.bPersonal:= chkPersonal.Checked;
  CostesAplicar.bGeneral:= chkGeneral.Checked;
  CostesAplicar.bFinanciero:= chkFinanciero.Checked;
  CostesAplicar.bEstadistico:= False;
end;


procedure TFLMargenSemanal.btnAceptarClick(Sender: TObject);
begin
  VerMargenSemanal;
end;

procedure TFLMargenSemanal.VerMargenSemanal;
begin
  ValidarCampos;
  if cbbRFCentral.ItemIndex = 1 then
  begin
    if not MargenBeneficiosCentralDL.MargenSemanal( self, False, False, sEmpresa, sCliente, sProducto, dFechaIni, dFechaIni + ( iSemanas * 7) - 1, chkExpandir.Checked, CostesAplicar ) then
    begin
      ShowMessage('No hay datos para los parametros introducidos.');
    end;
  end
  else
  begin
    if not MargenBeneficiosDL.MargenSemanal( self, False, False, sEmpresa, sCliente, sProducto, dFechaIni, dFechaIni + ( iSemanas * 7) - 1, chkExpandir.Checked, CostesAplicar ) then
    begin
      ShowMessage('No hay datos para los parametros introducidos.');
    end;
  end;
end;

procedure TFLMargenSemanal.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLMargenSemanal.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnAceptar.Click;
  end;
end;

procedure TFLMargenSemanal.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_f2:
      begin
        Key := 0;
        botonClick( Sender );
      end;
  end;
end;

procedure TFLMargenSemanal.botonClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCliente:  DespliegaRejilla(btnCliente,[eEmpresa.Text]);
    kCalendar: DespliegaCalendario(btnFechaDesde)
  end;
end;

procedure TFLMargenSemanal.PonNombreEmpresa(Sender: TObject);
begin
  lEmpresa.Caption := desEmpresa(eEmpresa.Text );
  cbbRFCentralChange( cbbRFCentral );
  PonNombreProducto( eProducto );
  edtClienteChange( edtCliente );
end;

procedure TFLMargenSemanal.PonNombreProducto(Sender: TObject);
begin
  if eProducto.Text = '' then
  begin
    lProducto.Caption := 'TODOS LOS PRODUCTOS';
  end
  else
  begin
    lProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text );
  end;
end;

procedure TFLMargenSemanal.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text = '' then
  begin
    txtCliente.Caption := 'TODOS LOS CLIENTES';
  end
  else
  begin
    txtCliente.Caption := desCliente( edtCliente.Text );
  end;
end;

procedure TFLMargenSemanal.cbbRFCentralChange(Sender: TObject);
begin
  if  cbbRFCentral.ItemIndex = 0  then
  begin
    edtCliente.Enabled:= true;
  end
  else
  begin
    edtCliente.Text:= '';
    edtCliente.Enabled:= False;
  end;
  edtClienteChange( edtCliente );
end;

end.

