unit DestrioFrutaRFFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls,
  BCalendarButton, BSpeedButton, BGridButton, Grids, DBGrids, BGrid,
  ComCtrls, BCalendario;

type
  TFLDestrioFrutaRF = class(TForm)
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
    lblProveedor: TLabel;
    eProveedor: TBEdit;
    btnProveedor: TBGridButton;
    lProveedor: TStaticText;
    lblVariedad: TLabel;
    lblVariedad2: TLabel;
    btnVariedad: TBGridButton;
    eCalibre: TBEdit;
    eVariedad: TBEdit;
    lVariedad: TStaticText;
    lblEntrega: TLabel;
    eEntrega: TBEdit;
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
    procedure PonNombreProveedor(Sender: TObject);
    procedure eVariedadChange(Sender: TObject);
  private
    { Private declarations }

    sEmpresa, sProveedor, sProducto, sVariedad, sCalibre, sEntrega: string;
    dFechaIni, dFechaFin: TDateTime;

    procedure ValidarCampos;
    procedure VerDestrioFrutaRF;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     UDMBaseDatos, UDMConfig, DestrioFrutaRFQL,
     bTimeUtils, CAuxiliarDB, UFProductosProveedor;

procedure TFLDestrioFrutaRF.FormCreate(Sender: TObject);
var
  dAux: TDate;
  iDia, iMes, iAnyo: Word;
begin
  FormType:=tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eProveedor.Tag := kProveedor;
  eProducto.Tag := kProducto;
  eVariedad.Tag := kVariedad;
  ecalibre.Tag := kCalibre;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;


  DecodeDate( date, iAnyo, iMes, iDia );
  dAux:= EncodeDate( iAnyo, iMes, 1 );
  eFechaDesde.Text := DateToStr( dAux );
  dAux:= IncMonth( dAux, 1 );
  eFechaHasta.Text := DateToStr( dAux - 1 );

  eEmpresa.Text:= gsDefEmpresa;

  CalendarioFlotante.Date := Date - 1;
  PonNombreEmpresa( eEmpresa );
end;

procedure TFLDestrioFrutaRF.FormClose(Sender: TObject;
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

procedure TFLDestrioFrutaRF.ValidarCampos;
begin
  //Comprobamos que los campos esten todos con datos
  if lEmpresa.caption = '' then
  begin
    EEmpresa.SetFocus;
    raise Exception.Create( 'Falta el código de la empresa o es incorrecto.');
  end;
  sEmpresa:= eEmpresa.Text;

  if lProveedor.Caption = '' then
  begin
    eProveedor.SetFocus;
    raise Exception.Create( 'El código del proveedor es incorrecto.');
  end;
  sProveedor:= eProveedor.Text;

  if lProducto.Caption = '' then
  begin
    eProducto.SetFocus;
    raise Exception.Create( 'El código del producto es incorrecto.');
  end;
  sProducto:= eProducto.Text;

  if lVariedad.Caption = '' then
  begin
    eVariedad.SetFocus;
    raise Exception.Create( 'El código de la variedad es incorrecto.');
  end;
  sVariedad:= eVariedad.Text;

  sCalibre:= Trim( eCalibre.Text );
  sEntrega:= Trim( eEntrega.Text );

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


procedure TFLDestrioFrutaRF.btnAceptarClick(Sender: TObject);
begin
  VerDestrioFrutaRF;
end;

procedure TFLDestrioFrutaRF.VerDestrioFrutaRF;
begin
  ValidarCampos;
  if not DestrioFrutaRFQL.VerDestrioFrutaRF( self, sEmpresa, sProveedor, sProducto, sVariedad, sCalibre, sEntrega, dFechaIni, dFechaFin ) then
  begin
    ShowMessage('No hay datos para los parametros introducidos.');
  end;
end;

procedure TFLDestrioFrutaRF.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLDestrioFrutaRF.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnAceptar.Click;
  end;
end;

procedure TFLDestrioFrutaRF.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLDestrioFrutaRF.botonClick(Sender: TObject);
var
  sResult: string;
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kProveedor: DespliegaRejilla(btnProveedor,[eEmpresa.Text]);
    kVariedad:
    begin
      if eVariedad.Focused then
      if SeleccionaProductoProvedor( self, eVariedad, eEmpresa.Text, eProveedor.Text, eProducto.Text, sResult ) then
      begin
        eVariedad.Text:= sResult;
      end;
    end;
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLDestrioFrutaRF.PonNombreEmpresa(Sender: TObject);
begin
  lEmpresa.Caption := desEmpresa(eEmpresa.Text );
  PonNombreProducto( eProducto );
  PonNombreProveedor( eProveedor );
  eVariedadChange( eVariedad );
end;

procedure TFLDestrioFrutaRF.PonNombreProducto(Sender: TObject);
begin
  if eProducto.Text = '' then
    lProducto.Caption := 'TODOS LOS PRODUCTOS'
  else
    lProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text );
end;

procedure TFLDestrioFrutaRF.PonNombreProveedor(Sender: TObject);
begin
  if eProveedor.Text = '' then
    lProveedor.Caption := 'TODOS LOS PROVEEDORES'
  else
    lProveedor.Caption := desProveedor(eEmpresa.Text, eProveedor.Text );
end;

procedure TFLDestrioFrutaRF.eVariedadChange(Sender: TObject);
begin
  if eVariedad.Text = '' then
    lVariedad.Caption := 'TODOS LAS VARIEDADES'
  else
    lVariedad.Caption := desVariedad(eEmpresa.Text, eProveedor.Text, eProducto.Text, eVariedad.Text );
end;

end.

