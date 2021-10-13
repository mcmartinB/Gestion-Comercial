unit CuadreAlmacenSemanalFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls,
  BCalendarButton, BSpeedButton, BGridButton, Grids, DBGrids, BGrid,
  ComCtrls, BCalendario;

type
  TFLCuadreAlmacenSemanal = class(TForm)
    btnCerrar: TBitBtn;
    btnAceptar: TBitBtn;
    lblNombre1: TLabel;
    eEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    lEmpresa: TStaticText;
    Desde: TLabel;
    eLunes: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lblSemana: TLabel;
    lblNombre3: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    lProducto: TStaticText;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    chkPaletsEntrada: TCheckBox;
    chkPaletsSalida: TCheckBox;
    mmo1: TMemo;
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
    procedure eLunesChange(Sender: TObject);
  private
    { Private declarations }

    sEmpresa, sCliente, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;

    procedure ValidarCampos;
    procedure VerCuadreAlmacenSemanal;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     UDMBaseDatos, UDMConfig, MargenBeneficiosDL,
     bTimeUtils, CAuxiliarDB, DateUtils;

procedure TFLCuadreAlmacenSemanal.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eProducto.Tag := kProducto;
  eLunes.Tag := kCalendar;

  eLunes.Text := DateToStr( LunesAnterior( date ) - 7 );
  eEmpresa.Text:= gsDefEmpresa;

  CalendarioFlotante.Date := Date - 1;
  PonNombreEmpresa( eEmpresa );
end;

procedure TFLCuadreAlmacenSemanal.FormClose(Sender: TObject;
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

procedure TFLCuadreAlmacenSemanal.ValidarCampos;
begin
  //Comprobamos que los campos esten todos con datos
  if lEmpresa.caption = '' then
  begin
    EEmpresa.SetFocus;
    raise Exception.Create( 'Falta el código de la empresa o es incorrecto.');
  end;
  sEmpresa:= eEmpresa.Text;
  sCliente:= '';

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
  end
  else
  begin
    if DayOfTheWeek( dFechaIni ) <> 1 then
    begin
      eLunes.SetFocus;
      raise Exception.Create( 'La fecha de inicio debe ser un lunes.');
    end
  end;
  dFechaFin:= dFechaIni + 6;
end;


procedure TFLCuadreAlmacenSemanal.btnAceptarClick(Sender: TObject);
begin
  VerCuadreAlmacenSemanal;
end;

procedure TFLCuadreAlmacenSemanal.VerCuadreAlmacenSemanal;
begin
  ValidarCampos;
  if not MargenBeneficiosDL.CuadreAlmacenSemanal( self, chkPaletsEntrada.Checked, chkPaletsSalida.Checked, sEmpresa, sCliente, sProducto, dFechaIni, dFechaFin ) then
  begin
    ShowMessage('No hay datos para los parametros introducidos.');
  end;
end;

procedure TFLCuadreAlmacenSemanal.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLCuadreAlmacenSemanal.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnAceptar.Click;
  end;
end;

procedure TFLCuadreAlmacenSemanal.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLCuadreAlmacenSemanal.botonClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCalendar: DespliegaCalendario(btnFechaDesde);
  end;
end;

procedure TFLCuadreAlmacenSemanal.PonNombreEmpresa(Sender: TObject);
begin
  lEmpresa.Caption := desEmpresa(eEmpresa.Text );
  PonNombreProducto( eProducto );
end;

procedure TFLCuadreAlmacenSemanal.PonNombreProducto(Sender: TObject);
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

procedure TFLCuadreAlmacenSemanal.eLunesChange(Sender: TObject);
begin
  if TryStrToDate( eLunes.Text, dFechaIni ) then
  begin
    if DayOfTheWeek( dFechaIni ) = 1 then
    begin
      lblSemana.Caption:= 'Semana ' + IntToStr( WeekOfTheYear( dFechaIni ) );
    end
    else
    begin
      lblSemana.Caption:= '(La fecha debe ser un lunes)';
    end;
  end;
end;

end.

