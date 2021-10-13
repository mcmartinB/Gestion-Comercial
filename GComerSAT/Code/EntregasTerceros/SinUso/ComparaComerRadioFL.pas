unit ComparaComerRadioFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls,
  BCalendarButton, BSpeedButton, BGridButton, Grids, DBGrids, BGrid,
  ComCtrls, BCalendario;

type
  TFLComparaComerRadio = class(TForm)
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
    lblNombre4: TLabel;
    eCentro: TBEdit;
    btnCentro: TBGridButton;
    lCentro: TStaticText;
    lblNombre5: TLabel;
    cbxDif: TComboBox;
    cbxProducto: TCheckBox;
    lblEntrega: TLabel;
    eEntrega: TBEdit;
    lblNombre6: TLabel;
    cbxStock: TComboBox;
    cbxDesglosarCalibre: TCheckBox;
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
    procedure PonNombreCentro(Sender: TObject);
  private
    { Private declarations }

    sEntrega, sEmpresa, sCentro, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;

    procedure ValidarCampos;
    procedure VerDiferenciasComer_RadioF;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     UDMBaseDatos, UDMConfig, ComparaComerRadioQL,
     bTimeUtils, CAuxiliarDB;

procedure TFLComparaComerRadio.FormCreate(Sender: TObject);
var
  dAux: TDate;
begin
  FormType:=tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eProducto.Tag := kProducto;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;

  dAux:= LunesAnterior( Date );
  eFechaDesde.Text := DateToStr(dAux - 7);
  eFechaHasta.Text := DateToStr(dAux - 1);
  eEmpresa.Text:= gsDefEmpresa;
  eCentro.Text:= gsDefCentro;
  eProducto.Text:= '';

  CalendarioFlotante.Date := Date - 1;
  PonNombreEmpresa( eEmpresa );
end;

procedure TFLComparaComerRadio.FormClose(Sender: TObject;
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

procedure TFLComparaComerRadio.ValidarCampos;
begin
  sEntrega:= Trim(eEntrega.Text);
  if sEntrega <> '' then
  begin
    if Length( sEntrega ) <> 12 then
    begin
      eEntrega.SetFocus;
      raise Exception.Create( 'El código de la entrega es incorrecto, faltan dígitos.');
    end;
    if lProducto.Caption = '' then
    begin
      eProducto.SetFocus;
      raise Exception.Create( 'El código del producto es incorrecto.');
    end;
    sProducto:= eProducto.Text;
    Exit;
  end;

  //Comprobamos que los campos esten todos con datos
  if lEmpresa.caption = '' then
  begin
    EEmpresa.SetFocus;
    raise Exception.Create( 'Falta el código de la empresa o es incorrecto.');
  end;
  sEmpresa:= eEmpresa.Text;

  if lCentro.caption = '' then
  begin
    eCentro.SetFocus;
    raise Exception.Create( 'Falta el código del centro o es incorrecto.');
  end;
  sCentro:= eCentro.Text;

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


procedure TFLComparaComerRadio.btnAceptarClick(Sender: TObject);
begin
  VerDiferenciasComer_RadioF;
end;

procedure TFLComparaComerRadio.VerDiferenciasComer_RadioF;
begin
  ValidarCampos;

  if not ComparaComerRadioQL.VerComparaComerRadio( self, sEntrega, sEmpresa, sCentro,
           sProducto, dFechaIni, dFechaFin, cbxDif.ItemIndex, cbxStock.ItemIndex,
           cbxProducto.Checked, cbxDesglosarCalibre.Checked ) then
  begin
    ShowMessage('No hay diferencias entre los datos de Comercial y Radiofrecuencia para los parametros introducidos.');
  end;
end;


procedure TFLComparaComerRadio.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLComparaComerRadio.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnAceptar.Click;
  end;
end;

procedure TFLComparaComerRadio.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLComparaComerRadio.botonClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro,[eEmpresa.Text]);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLComparaComerRadio.PonNombreEmpresa(Sender: TObject);
begin
  lEmpresa.Caption := desEmpresa(eEmpresa.Text);
  PonNombreProducto( eProducto );
  PonNombreCentro( eCentro );
end;

procedure TFLComparaComerRadio.PonNombreProducto(Sender: TObject);
begin
  if eProducto.Text = '' then
    lProducto.Caption := 'TODOS LOS PRODUCTOS'
  else
    lProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text );
end;

procedure TFLComparaComerRadio.PonNombreCentro(Sender: TObject);
begin
  lCentro.Caption := desCentro(eEmpresa.Text, eCentro.Text );
end;

end.
