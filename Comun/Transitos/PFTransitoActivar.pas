unit PFTransitoActivar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables, ExtCtrls;

type
  TFPTransitoActivar = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    lblRefTransito: TLabel;
    eRefTransito: TBEdit;
    lblEmpresa: TLabel;
    eEmpresa: TBEdit;
    stEmpresa: TStaticText;
    stCentroOrigen: TStaticText;
    edtCentroOrigen: TBEdit;
    lblCentroDestino: TLabel;
    lblFechaTransito: TLabel;
    eFechaTransito: TBEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtEntrada: TBEdit;
    btnEntrada: TBCalendarButton;
    lblEntrada: TLabel;
    edtHora: TBEdit;
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
    sEmpresa, sOrigen, sTransito, sHora: string;
    dFechaSalida, dFechaEntrada: TDateTime;
  end;

  procedure Activar( const AEmpresa, ACentro, AReferencia, AFechaSalida, AFechaEntrada, AHoraEntrada: string);

implementation


uses UDMAuxDB, Principal, CVariables, DPreview, CReportes,
     CAuxiliarDB, UDMBaseDatos, PDTransitoActivar, MTransitosSimple;

{$R *.DFM}


procedure Activar( const AEmpresa, ACentro, AReferencia, AFechaSalida, AFechaEntrada, AHoraEntrada: string);
var
  FPTransitoActivar: TFPTransitoActivar;
begin
  Application.CreateForm( TFPTransitoActivar, FPTransitoActivar );
  try
    FPTransitoActivar.eEmpresa.Text:= AEmpresa;
    FPTransitoActivar.edtCentroOrigen.Text:= ACentro;
    FPTransitoActivar.eRefTransito.Text:= AReferencia;
    FPTransitoActivar.eFechaTransito.Text:= AFechaSalida;
    FPTransitoActivar.edtEntrada.Text:= AFechaEntrada;
    FPTransitoActivar.edtHora.Text:= AHoraEntrada;
    FPTransitoActivar.ShowModal;
  finally
    FreeAndNil(FPTransitoActivar);
  end;
end;

//                         ****  BOTONES  ****

procedure TFPTransitoActivar.BBAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if not CamposVacios then
  begin
    if not PDTransitoActivar.Proceso ( sEmpresa, sOrigen, sTransito, dFechaSalida, dFechaEntrada, sHora, sMsg ) then
        ShowMessage( sMsg );
    Close;
  end;
end;

procedure TFPTransitoActivar.BBCancelarClick(Sender: TObject);
begin
  Close;
end;

//                          **** FORMULARIO ****
procedure TFPTransitoActivar.FormCreate(Sender: TObject);
begin
  eEmpresa.Tag := kEmpresa;
  edtCentroOrigen.Tag := kCentro;
  eFechaTransito.Tag := kCalendar;
  edtEntrada.Tag := kCalendar;

{
  eEmpresa.Text := gsDefEmpresa;
  PonNombre( eEmpresa );
  if gsDefCentro = '6' then
  begin
    edtCentroOrigen.Text := '1';
    PonNombre( edtCentroOrigen );
  end
  else
  begin
    edtCentroOrigen.Text := '6';
    PonNombre( edtCentroOrigen );
  end;
}
  eEmpresa.Text := '';
  edtCentroOrigen.Text := '';
  eRefTransito.Text := '';
  eFechaTransito.Text := DateTostr(Date);

  CalendarioFlotante.Date := Date;

  gRF := nil;
  gCF := calendarioFlotante;

  PDTransitoActivar.InicializarModulo;
end;

procedure TFPTransitoActivar.FormActivate(Sender: TObject);
begin
  ActiveControl := edtEntrada;
end;

procedure TFPTransitoActivar.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFPTransitoActivar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;

  PDTransitoActivar.FinalizarModulo;
  Action := caFree;
end;


//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFPTransitoActivar.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCalendar: DespliegaCalendario(btnEntrada);
  end;
end;

procedure TFPTransitoActivar.PonNombre(Sender: TObject);
begin
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kCentro: stCentroorigen.Caption:= desCentro(Eempresa.Text, edtCentroOrigen.Text);
  end;
end;

function TFPTransitoActivar.CamposVacios: boolean;
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

  if stCentroOrigen.Caption = '' then
  begin
    ShowError('Falta código de centro o código incorrecto..');
    edtCentroOrigen.SetFocus;
    Exit;
  end;
  sOrigen:= Trim(edtCentroOrigen.Text);

  if eRefTransito.Text = '' then
  begin
    ShowError('Falta la referencia del tránsito.');
    eRefTransito.SetFocus;
    Exit;
  end;
  sTransito:= Trim(eRefTransito.Text);

  if not TryStrToDate( eFechaTransito.Text, dFechaSalida ) then
  begin
    ShowError('Falta fecha de salida o fecha incorrecta.');
    eFechaTransito.SetFocus;
    Exit;
  end;
  if not TryStrToDate( edtEntrada.Text, dFechaEntrada ) then
  begin
    ShowError('Falta fecha de entrada o fecha incorrecta.');
    edtEntrada.SetFocus;
    Exit;
  end;
  if dFechaEntrada < dFechaSalida then
  begin
    ShowError('La fecha salida no puede se mayor que la fecha de entrada.');
    edtEntrada.SetFocus;
    Exit;
  end;
  if ( dFechaEntrada - dFechaSalida ) > 30 then
  begin
    ShowError('La fecha entrada no puede ser mayor a 30 dias desde la fecha de salida del tránsito.');
    edtEntrada.SetFocus;
    Exit;
  end;

  if ( Length( edtHora.Text ) < 5 ) or  ( Copy( edtHora.Text, 3, 1 ) <> ':' ) then
  begin
    ShowError('Falta la hora o el formato no es correcto (hh:mm).');
    edtHora.SetFocus;
    Exit;
  end;
  sHora:= edtHora.Text;

  Result := False;
end;

//******************************  Parte privada  *******************************

end.

