unit FacturadoClienteBancoFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt;

type
  TFLFacturadoClienteBanco = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lblEmpresa: TLabel;
    btnEmpresa: TBGridButton;
    edtEmpresa: TBEdit;
    lblCliente: TLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    lblFechaDesde: TLabel;
    edtFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lblFechaHasta: TLabel;
    edtFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    lblDesCliente: TLabel;
    cbbSeguro: TComboBox;
    lblSeguro: TLabel;
    lblPais: TLabel;
    edtPais: TBEdit;
    btnPais: TBGridButton;
    lblDesPais: TLabel;
    lbldesEmpresa: TLabel;
    procedure BBCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
    procedure edtPaisChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
  private
    {private declarations}
    sEmpresa, sCliente, sPais: string;
    dFechaIni, dFechaFin: TDateTime;
    iSeguro: integer;

    function CamposVacios: boolean;
    procedure Listado;

  public
    { Public declarations }
  end;

var
  FLFacturadoClienteBanco: TFLFacturadoClienteBanco;

implementation

uses CVariables, UDMAuxDB, Principal, CAuxiliarDB,
     FacturadoClienteBancoQL, UDMBaseDatos;

{$R *.DFM}

procedure TFLFacturadoClienteBanco.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLFacturadoClienteBanco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLFacturadoClienteBanco.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := gsDefEmpresa;
  //lbldesEmpresa.Caption := desEmpresa(edtempresa.Text);

  edtCliente.Text := '';
  edtPais.Text := '';
  edtFechaDesde.Text := DateToStr(Date);
  edtFechaHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;

  edtEmpresa.Tag := kEmpresa;
  edtCliente.Tag := kCliente;
  edtPais.Tag := kPais;
  edtFechaDesde.Tag := kCalendar;
  edtFechaHasta.Tag := kCalendar;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

end;

procedure TFLFacturadoClienteBanco.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLFacturadoClienteBanco.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCliente: DespliegaRejilla(btnCliente, [edtEmpresa.Text]);
    kCalendar:
      begin
        if edtFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

function TFLFacturadoClienteBanco.CamposVacios: boolean;
begin
  Result := True;
  if lbldesEmpresa.Caption = '' then
  begin
    ShowError('El código de la empresa es incorrecto.');
    edtEmpresa.SetFocus;
    Exit;
  end;
  sEmpresa:= Trim( edtEmpresa.Text );

  if lblDesCliente.Caption = '' then
  begin
    ShowError('El código del cliente es incorrecto.');
    edtEmpresa.SetFocus;
    Exit;
  end;
  sCliente:= Trim( edtCliente.Text );

  if lblDesPais.Caption = '' then
  begin
    ShowError('El código del país es incorrecto.');
    edtEmpresa.SetFocus;
    Exit;
  end;
  sPais:= Trim( edtPais.Text );

  if not TryStrToDate( edtFechaDesde.Text, dFechaIni ) then
  begin
    ShowError('Falta la fecha de inicio o es incorrecta.');
    edtFechaDesde.SetFocus;
    Exit;
  end;

  if not TryStrToDate( edtFechaHasta.Text, dFechaFin ) then
  begin
    ShowError('Falta la fecha de fin o es incorrecta.');
    edtFechaHasta.SetFocus;
    Exit;
  end;

  if dFechaFin < dFechaIni then
  begin
    ShowError('Rango de fechas incorrecto.');
    edtFechaDesde.SetFocus;
    Exit;
  end;

  // 0-> indiferente 1-> con seguro 2-> Sin seguro
  iSeguro:= cbbSeguro.ItemIndex;

  Result := False;
end;

procedure TFLFacturadoClienteBanco.BAceptarExecute(Sender: TObject);
begin
  if not CamposVacios then
    Listado
end;

procedure TFLFacturadoClienteBanco.Listado;
begin
  if not VisualizarInforme( sEmpresa, sCliente, sPais, dFechaIni, dFechaFin, iSeguro ) then
  begin
    ShowMessage('Sin datos para los parametros pasados.');
  end;
end;



procedure TFLFacturadoClienteBanco.edtPaisChange(Sender: TObject);
begin
  if edtPais.Text <> '' then
  begin
    edtCliente.Text:= '';
    lblDesPais.Caption:= desPais( edtPais.Text );
  end
  else
  begin
    lblDesPais.Caption:= '(Vacio = Todos los paises)';
  end;
end;

procedure TFLFacturadoClienteBanco.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text <> '' then
  begin
    edtPais.Text:= '';
    lblDesCliente.Caption:= desCliente(edtCliente.Text );
  end
  else
  begin
    lblDesCliente.Caption:= '(Vacio = Todos los clientes)';
  end;
end;

procedure TFLFacturadoClienteBanco.edtEmpresaChange(Sender: TObject);
begin
  if edtEmpresa.Text <> '' then
  begin
    lbldesEmpresa.Caption:= desEmpresa(edtEmpresa.Text );
  end
  else
  begin
    lbldesEmpresa.Caption:= '(Vacio = Todas las empresas)';
  end;
end;

end.
