unit LAsignacionFederaciones;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton,
  DBTables;

type
  TFLLAsignacionFederaciones = class(TForm)
    pSuperior: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    LEmpresa: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    Lunes: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    lblAnyoSemana: TLabel;
    Label1: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    stProducto: TStaticText;
    Label3: TLabel;
    eCentro: TBEdit;
    btnCentro: TBGridButton;
    stCentro: TStaticText;
    pInferior: TPanel;
    mmoDatos: TMemo;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure EEmpresaChange(Sender: TObject);
    procedure MEDesdeChange(Sender: TObject);
    procedure eProductoChange(Sender: TObject);
    procedure eCentroChange(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    iEstado: Integer;
    sEmpresa, sCentro, sProducto: string;
    dLunes: TDateTime;

    function  ValidarParametros: boolean;
    procedure PonEstado( const AEstado: integer );
  public
    { Public declarations }
  end;

implementation

uses UDMAuxDB, CVariables, Principal, CReportes, DLAsignacionFederaciones,
  CAuxiliarDB, DPreview, bTimeUtils, DateUtils,
  UDMBaseDatos;


{$R *.DFM}

procedure TFLLAsignacionFederaciones.BBCancelarClick(Sender: TObject);
begin
  if iEstado = 1 then
  begin
    if CerrarForm(false) then
      Close;
  end
  else
  begin
    PonEstado( 1 );
  end;
end;


function TFLLAsignacionFederaciones.ValidarParametros: boolean;
var
  dFechaIni: TDateTime;
begin
  result:= False;
  //Comprobar parametros de entrada
  if STEmpresa.Caption = '' then
  begin
    MessageDlg('Falta o código de empresa incorrecto', mtError, [mbOk], 0);
    EEmpresa.SetFocus;
    Exit;
  end;

  if STCentro.Caption = '' then
  begin
    MessageDlg('Falta o código de centro incorrecto', mtError, [mbOk], 0);
    ECentro.SetFocus;
    Exit;
  end;

  if not TryStrToDate( MEDesde.Text, dFechaIni ) then
  begin
    MessageDlg('Fecha de inicio incorrecta ...', mtError, [mbOk], 0);
    MEDesde.SetFocus;
    Exit;
  end;

  if STProducto.Caption = '' then
  begin
    MessageDlg('Código de producto incorrecto', mtError, [mbOk], 0);
    EProducto.SetFocus;
    Exit;
  end;

  sEmpresa:= eEmpresa.Text;
  sCentro:= eCentro.Text;
  sProducto:= eProducto.Text;
  dLunes:= LunesAnterior( dFechaIni );
  result:= True;
end;

procedure TFLLAsignacionFederaciones.BBAceptarClick(Sender: TObject);
var
  sTexto: string;
  bNacional: Boolean;
begin
  if not CerrarForm(true) then
    Exit;

  if iEstado = 1 then
  begin
    if ValidarParametros then
    begin
      if DMLAsignacionFederaciones.KilosSalidaPorAsignacion( sEmpresa, sCentro, sProducto, dLunes, dLunes + 6, sTexto  ) then
      begin
        PonEstado( 2 );
      end;
      mmoDatos.Clear;
      mmoDatos.Lines.Add( sTexto );
    end;
  end
  else
  begin
    mmoDatos.Clear;
    DMLAsignacionFederaciones.AsignarFederaciones( sTexto );
    mmoDatos.Lines.Add( sTexto );
    bNacional:= False;
    DMLAsignacionFederaciones.ListadoAsignacionFederaciones( sEmpresa, sCentro, sProducto, dLunes, dLunes + 6, bNacional  );
    bNacional:= True;
    DMLAsignacionFederaciones.ListadoAsignacionFederaciones( sEmpresa, sCentro, sProducto, dLunes, dLunes + 6, bNacional  );
    PonEstado( 1 );
  end;
end;

procedure TFLLAsignacionFederaciones.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  FreeAndNIl( DMLAsignacionFederaciones );
  Action := caFree;
end;

procedure TFLLAsignacionFederaciones.FormCreate(Sender: TObject);
var
  dFecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

  EEmpresa.Text := '050';
  eCentro.Text:= '1';
  //eProducto.Text:= 'T';

  dFecha:= LunesAnterior( Date ) - 7;
  CalendarioFlotante.Date := dFecha;
  MEDesde.Text:= DateToStr( dFEcha );

  DMLAsignacionFederaciones:= TDMLAsignacionFederaciones.Create( self );
end;

procedure TFLLAsignacionFederaciones.FormShow(Sender: TObject);
begin
  PonEstado( 1 );
end;

procedure TFLLAsignacionFederaciones.PonEstado( const AEstado: integer );
begin
  iEstado:= AEstado;
  if iEstado = 1 then
  begin
    btnAceptar.Caption:= 'Calcular';
    btnCancelar.Caption:= 'Cerrar';
    pSuperior.Enabled:= True;
    eCentro.Enabled:= True;
    eProducto.Enabled:= True;
    MEDesde.Enabled:= True;
    if eCentro.CanFocus then
      eCentro.SetFocus;
  end
  else
  begin
    btnAceptar.Caption:= 'Aplicar';
    btnCancelar.Caption:= 'Cancelar';
    pSuperior.Enabled:= False;
    eCentro.Enabled:= False;
    eProducto.Enabled:= False;
    MEDesde.Enabled:= False;
  end;
end;

procedure TFLLAsignacionFederaciones.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

procedure TFLLAsignacionFederaciones.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(btnCentro);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCalendar: DespliegaCalendario(BCBDesde)
  end;
end;

procedure TFLLAsignacionFederaciones.EEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  stCentro.Caption := desCentro(Eempresa.Text, eCentro.Text);
  stProducto.Caption := desProducto(Eempresa.Text, eProducto.Text);
end;

procedure TFLLAsignacionFederaciones.eCentroChange(Sender: TObject);
begin
  stCentro.Caption := desCentro(Eempresa.Text, eCentro.Text);
end;

procedure TFLLAsignacionFederaciones.eProductoChange(Sender: TObject);
begin
  stProducto.Caption := desProducto(Eempresa.Text, eProducto.Text);
end;

procedure TFLLAsignacionFederaciones.MEDesdeChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if TryStrToDate( MEDesde.text, dFEcha ) then
  begin
    dFecha:= LunesAnterior( dFecha );
    lblAnyoSemana.Caption:= AnyoSemana( StrToDateTime(MEDesde.text) ) + ' del ' +
                            DateToStr( dFecha ) + ' al ' + DateToStr( dFecha + 6 );;
  end
  else
  begin
    lblAnyoSemana.Caption:= '';
  end;
end;

end.
