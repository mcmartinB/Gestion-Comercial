unit LFNotificacionCredito;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt;

type
  TFLNotificacionCredito = class(TForm)
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
    STEmpresa: TStaticText;
    lblCliente: TLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    lblFechaDesde: TLabel;
    edtFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lblFechaHasta: TLabel;
    edtFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    stCliente: TLabel;
    cbbSeguro: TComboBox;
    lblSeguro: TLabel;
    lblPais: TLabel;
    edtPais: TBEdit;
    btnPais: TBGridButton;
    lblDesPais: TLabel;
    lblTipoCliente: TLabel;
    edtTipoCliente: TBEdit;
    btnTipoCliente: TBGridButton;
    txtTipoCliente: TStaticText;
    chkTipoCliente: TCheckBox;
    procedure BBCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
    procedure edtPaisChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtTipoClienteChange(Sender: TObject);
  private
    {private declarations}
    sEmpresa, sCliente, sPais, sTipoCliente: string;
    dFechaIni, dFechaFin: TDateTime;
    iSeguro: integer;
    bExcluirTipoCliente: Boolean;

    function CamposVacios: boolean;
    procedure Listado;

  public
    { Public declarations }
  end;

var
  FLNotificacionCredito: TFLNotificacionCredito;

implementation

uses CVariables, UDMAuxDB, Principal, CAuxiliarDB, UDMMaster,
     LNotificacionCredito, UDMBaseDatos, CGlobal;

{$R *.DFM}

procedure TFLNotificacionCredito.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLNotificacionCredito.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFLNotificacionCredito.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    edtEmpresa.Text := 'BAG'
  else
    edtEmpresa.Text := 'SAT';
  STEmpresa.Caption := desEmpresa(edtempresa.Text);

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
  edtTipoCliente.Tag := kTipoCliente;
  edtTipoCliente.Text:= 'IP';

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

end;

procedure TFLNotificacionCredito.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLNotificacionCredito.ADesplegarRejillaExecute(Sender: TObject);
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
    kTipoCliente:
    begin
      DespliegaRejilla(btnTipoCliente);
    end;
  end;
end;

procedure TFLNotificacionCredito.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(edtempresa.Text);
  end;
end;

function TFLNotificacionCredito.CamposVacios: boolean;
begin
  Result := True;
  if stEmpresa.Caption = '' then
  begin
    ShowError('Falta el codigo de la empresa o es incorrecto.');
    edtEmpresa.SetFocus;
    Exit;
  end;
  sEmpresa:= Trim( edtEmpresa.Text );

  if stCliente.Caption = '' then
  begin
    ShowError('El codigo del cliente es incorrecto.');
    edtEmpresa.SetFocus;
    Exit;
  end;
  sCliente:= Trim( edtCliente.Text );

  if stCliente.Caption = '' then
  begin
    ShowError('El codigo del país es incorrecto.');
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

  //Comprobar que el tipo cliente si tiene valor sea valido
  if (trim(edtTipoCliente.Text) <> '') then
  begin
    if txtTipoCliente.Caption = '' then
    begin
      ShowError('El código del tipo cliente no es correcto.');
      edtTipoCliente.Focused;
      Exit;
    end;
  end;
  sTipoCliente:= edtTipoCliente.Text;
  bExcluirTipoCliente:= chkTipoCliente.Checked;

  // 0-> indiferente 1-> con seguro 2-> Sin seguro
  iSeguro:= cbbSeguro.ItemIndex;

  Result := False;
end;

procedure TFLNotificacionCredito.BAceptarExecute(Sender: TObject);
begin
  if not CamposVacios then
    Listado
end;

procedure TFLNotificacionCredito.Listado;
begin
  if not VisualizarInforme( sEmpresa, sCliente, sPais, sTipoCliente, bExcluirTipoCliente, dFechaIni, dFechaFin, iSeguro ) then
  begin
    ShowMessage('Sin datos para los parametros pasados.');
  end;
end;



procedure TFLNotificacionCredito.edtPaisChange(Sender: TObject);
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

procedure TFLNotificacionCredito.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text <> '' then
  begin
    edtPais.Text:= '';
    stCliente.Caption:= desCliente( edtCliente.Text );
  end
  else
  begin
    stCliente.Caption:= '(Vacio = Todos los clientes)';
  end;
end;

procedure TFLNotificacionCredito.edtTipoClienteChange(Sender: TObject);
begin
  IF edtTipoCliente.Text = '' then
  begin
    txtTipoCliente.Caption := 'TODOS LOS TIPOS';
  end
  else
  begin
    txtTipoCliente.Caption := desTipoCliente(edtTipoCliente.Text );
  end;
end;

end.
