unit LFEstadisticasEnvase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables, ExtCtrls;

type
  TFLEstadisticasEnvase = class(TForm)
    Panel: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    lblCliente: TLabel;
    eCliente: TBEdit;
    lblEmpresa: TLabel;
    eEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    stCentro: TStaticText;
    btnCentro: TBGridButton;
    eCentro: TBEdit;
    lblCentro: TLabel;
    lblProducto: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    stProducto: TStaticText;
    lblDesde: TLabel;
    eDesde: TBEdit;
    btnDesde: TBCalendarButton;
    lblHasta: TLabel;
    eHasta: TBEdit;
    btnHasta: TBCalendarButton;
    btnCliente: TBGridButton;
    stCliente: TStaticText;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;
  private
    {private declarations}

  public
    { Public declarations }
    sEmpresa, sCentro, sProducto, sCliente: string;
    dIni, dFin: TDateTime;
  end;

var
  FLEstadisticasEnvase: TFLEstadisticasEnvase;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, CReportes,
     CAuxiliarDB, UDMBaseDatos, UDMCambioMoneda, LQEstadisticasEnvase;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLEstadisticasEnvase.BBAceptarClick(Sender: TObject);
begin
  if not CamposVacios then
  begin
    if not LQEstadisticasEnvase.Imprimir ( sEmpresa, sCentro, sCliente, sProducto, dIni, dFin ) then
        ShowMessage('Sin datos.');
  end;
end;

procedure TFLEstadisticasEnvase.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

//                          **** FORMULARIO ****
procedure TFLEstadisticasEnvase.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eProducto.Tag := kProducto;
  eCliente.Tag := kCliente;
  eDesde.Tag := kCalendar;
  eHasta.Tag := kCalendar;

  eEmpresa.Text := gsDefEmpresa;
  eCentro.Text := '';
  PonNombre( eCentro );
  eCliente.Text := '';
  PonNombre( eCliente );
  eProducto.Text := '';
  PonNombre( eProducto );
  eDesde.Text := DateTostr(Date-6);
  eHasta.Text := DateTostr(Date);

  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  CalendarioFlotante.Date := Date;

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;

  LQEstadisticasEnvase.InicializarReport;
end;

procedure TFLEstadisticasEnvase.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFLEstadisticasEnvase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

procedure TFLEstadisticasEnvase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');

  LQEstadisticasEnvase.FinalizarReport;
  Action := caFree;
end;


//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLEstadisticasEnvase.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente, [EEmpresa.Text]);
    kCalendar:
      begin
        if eDesde.Focused then
          DespliegaCalendario(btnDesde)
        else
          DespliegaCalendario(btnHasta);
      end;
  end;
end;

procedure TFLEstadisticasEnvase.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kProducto:
    begin
      if Trim(eProducto.Text) = '' then
        STProducto.Caption:= 'TODOS LOS PRODUCTOS'
      else
        STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
    end;
    kCentro:
    begin
      if Trim(eCentro.Text) = '' then
        stCentro.Caption:= 'TODOS LOS CENTROS'
      else
        stCentro.Caption:= desCentro(Eempresa.Text, Ecentro.Text);
    end;
    kCliente:
    begin
      if Trim(eCliente.Text ) = '' then
        stCliente.Caption:= 'TODOS LOS CLIENTES'
      else
        stCliente.Caption:= desCliente( eCliente.Text );
    end;
  end;
end;

function TFLEstadisticasEnvase.CamposVacios: boolean;
begin
  Result := True;
        //Comprobamos que los campos esten todos con datos
  if stEmpresa.Caption = '' then
  begin
    ShowError('Falta código de empresa o código incorrecto.');
    EEmpresa.SetFocus;
    Exit;
  end;
  sEmpresa:= Trim(eEmpresa.Text);

  if stProducto.Caption = '' then
  begin
    ShowError('Código de producto incorrecto.');
    EProducto.SetFocus;
    Exit;
  end;
  sProducto:= Trim(eProducto.Text);

  if stCentro.Caption = '' then
  begin
    ShowError('Código de centro incorrecto.');
    ECentro.SetFocus;
    Exit;
  end;
  sCentro:= Trim(eCentro.Text);

  if stCliente.Caption = '' then
  begin
    ShowError('Código de cliente incorrecto.');
    ECliente.SetFocus;
    Exit;
  end;
  sCliente:= Trim(eCliente.Text);

  if not TryStrToDate( EDesde.Text, dIni ) then
  begin
    ShowError('Falta fecha de inicio o fecha incorrecta.');
    EDesde.SetFocus;
    Exit;
  end;
  if not TryStrToDate( EHasta.Text, dFin ) then
  begin
    ShowError('Falta fecha de fin o fecha incorrecta.');
    EHasta.SetFocus;
    Exit;
  end;
  if dFin < dIni then
  begin
    ShowError('Rango de fechas incorrecto.');
    EDesde.SetFocus;
    Exit;
  end;

  Result := False;
end;

//******************************  Parte privada  *******************************

end.

