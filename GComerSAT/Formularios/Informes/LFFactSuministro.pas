unit LFFactSuministro;

interface

uses
  Forms, SysUtils, Classes, ActnList, ComCtrls, BCalendario, Grids,
  DBGrids, BGrid, StdCtrls, BEdit, BCalendarButton, BSpeedButton, Dialogs,
  BGridButton, Controls, Buttons, ExtCtrls, Windows, Messages, DBTables;

type
  TFLFactSuministro = class(TForm)
    Panel1: TPanel;
    GBEmpresa: TGroupBox;
    Label3: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    STEmpresa: TStaticText;
    STCliente: TStaticText;
    BGBEmpresa: TBGridButton;
    BGBCliente: TBGridButton;
    RejillaDespegable: TAction;
    RejillaFlotante: TBGrid;
    empresa: TBEdit;
    cliente: TBEdit;
    fecha: TBEdit;
    BCBFecha: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    procedure BCancelarExecute(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RejillaDespegableExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);

  end;

implementation

uses UDMAuxDB, UDMBaseDatos, CVariables, Principal, CAuxiliarDB, CReportes,
  QLFactSuministro, CGestionPrincipal, DPreview, DError;

{$R *.DFM}

procedure TFLFactSuministro.BCancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLFactSuministro.BAceptarExecute(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

     //Comprobar que todos los campos tienen valor
  if (trim(empresa.Text) = '') or
    (trim(cliente.Text) = '') or
    (trim(fecha.Text) = '') then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    if trim(empresa.Text) = '' then
    begin
      empresa.SetFocus;
      Exit;
    end;
    if trim(cliente.Text) = '' then
    begin
      cliente.SetFocus;
      Exit;
    end;
    if trim(fecha.Text) = '' then
    begin
      fecha.SetFocus;
      Exit;
    end;
  end;


     //CREAR LISTADO
  QFactSuministro := TQFactSuministro.Create(Self);

     //MOSTRAR DATOS
  QFactSuministro.Query.ParamByName('empresa').AsString := empresa.Text;
  QFactSuministro.Query.ParamByName('cliente').AsString := cliente.Text;
  QFactSuministro.Query.ParamByName('fechaFact').AsDateTime := StrToDate(fecha.Text);

  QFactSuministro.lblCliente.Caption := cliente.Text + ' ' + STCliente.Caption;
  QFactSuministro.lblFecha.Caption := 'Fecha Factura: ' + fecha.Text;

  QFactSuministro.Query.Open;

  if QFactSuministro.Query.IsEmpty then
  begin
    ShowMessage(' No existen datos para los valores introducidos ... ');
    QFactSuministro.Free;
    Application.ProcessMessages;
  end
  else
  begin
    PonLogoGrupoBonnysa( QFactSuministro, empresa.text );
    Preview(QFactSuministro, 1, False, False);
  end;
end;

procedure TFLFactSuministro.FormCreate(Sender: TObject);
begin
  Top := 1;
  FormType := tfOther;
  BHFormulario;
  CalendarioFlotante.Date := Date;

  Empresa.Tag := kEmpresa;
  cliente.Tag := kCliente;
  Fecha.Tag := kCalendar;
  Empresa.Text := '';
  Cliente.Text := '';
  fecha.Text := '';

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

end;

procedure TFLFactSuministro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  gRF := nil;
  gCF := nil;
  Action := caFree;
end;

procedure TFLFactSuministro.RejillaDespegableExecute(
  Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente: DespliegaRejilla(BGBCliente, [empresa.Text]);
    kCalendar: DespliegaCalendario(BCBFecha);
  end;
end;

procedure TFLFactSuministro.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        STEmpresa.Caption := desEmpresa(empresa.Text);
        STCliente.Caption := desCliente(cliente.Text);
      end;
    kCliente: STCliente.Caption := desCliente(cliente.Text);
  end;
end;

procedure TFLFactSuministro.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

end.
