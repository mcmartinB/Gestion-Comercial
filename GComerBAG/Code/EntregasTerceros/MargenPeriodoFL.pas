unit MargenPeriodoFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls,
  BCalendarButton, BSpeedButton, BGridButton, Grids, DBGrids, BGrid,
  ComCtrls, BCalendario;

type
  TFLMargenPeriodo = class(TForm)
    btnCerrar: TBitBtn;
    btnAceptar: TBitBtn;
    lblNombre1: TLabel;
    eEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    lEmpresa: TStaticText;
    Desde: TLabel;
    eFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lblNombre2: TLabel;
    eFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    lblNombre3: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    lProducto: TStaticText;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    chkPaletsEntrada: TCheckBox;
    chkPaletsSalida: TCheckBox;
    chkPrecioUnidad: TCheckBox;
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
    procedure PonNombreCliente(Sender: TObject);
    procedure cbbRFCentralChange(Sender: TObject);
  private
    { Private declarations }

    sEmpresa, sProducto, sCliente: string;
    dFechaIni, dFechaFin: TDateTime;

    procedure ValidarCampos;
    procedure VerMargenPeriodo;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     UDMBaseDatos, UDMConfig, MargenBeneficiosDL,
     bTimeUtils, CAuxiliarDB, MargenBeneficiosCentralDL;

procedure TFLMargenPeriodo.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eProducto.Tag := kProducto;
  edtCliente.Tag := kCliente;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;

  eFechaDesde.Text := DateToStr( LunesAnterior( date ) - 7 );
  eFechaHasta.Text := DateToStr( LunesAnterior( date ) - 1 );

  eEmpresa.Text:= gsDefEmpresa;

  CalendarioFlotante.Date := Date - 1;
  PonNombreEmpresa( eEmpresa );
end;

procedure TFLMargenPeriodo.FormClose(Sender: TObject;
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

procedure TFLMargenPeriodo.ValidarCampos;
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

  if not TryStrToDate( eFechaDesde.Text, dFechaIni ) then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create( 'La fecha de inicio es incorrecta.');
  end;

  if not TryStrToDate( eFechaHasta.Text, dFechaFin ) then
  begin
    eFechaHasta.SetFocus;
    raise Exception.Create( 'La fecha de fin es incorrecta.');
  end;

  if dFechaFin < dFechaIni then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create( 'Rango de fechas incorrecto.');
  end;
end;


procedure TFLMargenPeriodo.btnAceptarClick(Sender: TObject);
begin
  if ( eEmpresa.Text = 'F18' ) and ( cbbRFCentral.ItemIndex = 0 ) then
  begin
    if MessageDlg( '¿ Seguro que usar los datos de RF del almacén para la planta F18 (P4H) ?', mtWarning, mbOKCancel, 0 ) <> mrOk then
      Exit;
  end;
  VerMargenPeriodo;
end;

procedure TFLMargenPeriodo.VerMargenPeriodo;
begin
  ValidarCampos;
  if cbbRFCentral.ItemIndex = 1 then
  begin
    if not MargenBeneficiosCentralDL.MargenPeriodo( self, chkPaletsEntrada.Checked, chkPaletsSalida.Checked, sEmpresa, sCliente, sProducto, dFechaIni, dFechaFin, chkPrecioUnidad.Checked ) then
    begin
      ShowMessage('No hay datos para los parametros introducidos.');
    end;
  end
  else
  begin
    if not MargenBeneficiosDL.MargenPeriodo( self, chkPaletsEntrada.Checked, chkPaletsSalida.Checked, sEmpresa, sCliente, sProducto, dFechaIni, dFechaFin, chkPrecioUnidad.Checked ) then
    begin
      ShowMessage('No hay datos para los parametros introducidos.');
    end;
  end;
end;

procedure TFLMargenPeriodo.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLMargenPeriodo.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnAceptar.Click;
  end;
end;

procedure TFLMargenPeriodo.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLMargenPeriodo.botonClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente,[eEmpresa.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLMargenPeriodo.PonNombreEmpresa(Sender: TObject);
begin
  lEmpresa.Caption := desEmpresa(eEmpresa.Text );
  PonNombreProducto( eProducto );
  PonNombreCliente( edtCliente );
  cbbRFCentralChange( cbbRFCentral );
end;

procedure TFLMargenPeriodo.PonNombreProducto(Sender: TObject);
begin
  if eProducto.Text = '' then
  begin
    lProducto.Caption := 'TODOS LOS PRODUCTOS';
    chkPaletsEntrada.Enabled:= False;
    chkPaletsEntrada.Checked:= False;
    chkPaletsSalida.Enabled:= False;
    chkPaletsSalida.Checked:= False;
  end
  else
  begin
    lProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text );
    chkPaletsEntrada.Enabled:= True;
    chkPaletsSalida.Enabled:= True;
  end;
end;

procedure TFLMargenPeriodo.PonNombreCliente(Sender: TObject);
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

procedure TFLMargenPeriodo.cbbRFCentralChange(Sender: TObject);
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
  PonNombreCliente( edtCliente );
end;

end.


