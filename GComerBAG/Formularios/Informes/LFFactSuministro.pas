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
    edtDesde: TBEdit;
    BCBFecha: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    edtHasta: TBEdit;
    btnHasta: TBCalendarButton;
    lblHasta: TLabel;
    lbl1: TLabel;
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
  QLFactSuministro, CGestionPrincipal, DPreview, DError, UDMConfig;

{$R *.DFM}

procedure TFLFactSuministro.BCancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLFactSuministro.BAceptarExecute(Sender: TObject);
var
  dini, dFin: TDateTime;
begin
  if not CerrarForm(true) then Exit;

     //Comprobar que todos los campos tienen valor
  if (trim(empresa.Text) = '') or
    (trim(cliente.Text) = '') or
    (trim(edtDesde.Text) = '') then
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
    if trim(edtDesde.Text) = '' then
    begin
      edtDesde.SetFocus;
      Exit;
    end;
  end;

  if not TryStrToDate( edtDesde.Text, dini ) then
  begin
    ShowMessage('Fecha inicio incorrecta.');
    edtDesde.SetFocus;
    Exit;
  end;
  if edtHasta.Text = '' then
  begin
    dFin:= dini;
  end
  else
  if not TryStrToDate( edtHasta.Text, dFin ) then
  begin
    ShowMessage('Fecha hasta incorrecta.');
    edtHasta.SetFocus;
    Exit;
  end;
  if  dFin < dini then
  begin
    ShowMessage('Rango de fechas incorrecto.');
    edtDesde.SetFocus;
    Exit;
  end;


     //CREAR LISTADO
  QFactSuministro := TQFactSuministro.Create(Self);

     //MOSTRAR DATOS
     //QFactSuministro.Configurar(empresa.Text);

  QFactSuministro.Query.ParamByName('empresa').AsString := empresa.Text;
  QFactSuministro.Query.ParamByName('cliente').AsString := cliente.Text;
  QFactSuministro.Query.ParamByName('fechaDesde').AsDateTime := dini;
  QFactSuministro.Query.ParamByName('fechaHasta').AsDateTime := dFin;

  QFactSuministro.lblCliente.Caption := cliente.Text + ' ' + STCliente.Caption;
  if dini =  dFin then
    QFactSuministro.lblFecha.Caption := 'Fecha Factura: ' + edtDesde.Text
  else
    QFactSuministro.lblFecha.Caption := 'Fecha Factura Desde ' + edtDesde.Text + ' al ' + edtHasta.Text;

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
  edtDesde.Tag := kCalendar;
  edtHasta.Tag := kCalendar;
  Empresa.Text := gsDefEmpresa;
  Cliente.Text := gsDefCliente;
  edtDesde.Text := FormatDateTime('dd/mm/yyyy', Date);
  edtHasta.Text := '';

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  Empresa.ReadOnly:= not DMConfig.EsLaFont;
  if Empresa.Enabled then
    Empresa.Text:= gsDefEmpresa;
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
