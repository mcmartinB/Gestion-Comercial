unit LFGastosEntregas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables, ExtCtrls;

type
  TFLGastosEntregas = class(TForm)
    Panel: TPanel;
    ListaAcciones: TActionList;
    BAceptarEntrega: TAction;
    BCancelar: TAction;
    btnAceptarEntrega: TSpeedButton;
    btnCancelar: TSpeedButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    lblProveedor: TLabel;
    eProveedor: TBEdit;
    lblEmpresa: TLabel;
    eEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    stCentro: TStaticText;
    btnCentro: TBGridButton;
    eCentro: TBEdit;
    lblProducto: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    stProducto: TStaticText;
    eDesde: TBEdit;
    btnDesde: TBCalendarButton;
    lblHasta: TLabel;
    eHasta: TBEdit;
    btnHasta: TBCalendarButton;
    btnProveedor: TBGridButton;
    stProveedor: TStaticText;
    cbxPendientePago: TCheckBox;
    eEntrega: TBEdit;
    lblNombre1: TLabel;
    btnAceptarConduce: TSpeedButton;
    BAceptarConduce: TAction;
    cbxTipoFecha: TComboBox;
    cbxTipoCentro: TComboBox;
    cbxTipoCodigo: TComboBox;
    cbxEnvio: TComboBox;
    lblNombre2: TLabel;
    eGasto: TBEdit;
    btnGasto: TBGridButton;
    stGasto: TStaticText;
    chkSinGastos: TCheckBox;
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
    procedure eEntregaChange(Sender: TObject);
    procedure BAceptarConduceExecute(Sender: TObject);
  private
    {private declarations}
    procedure RejillaGastos;

  public
    { Public declarations }
    sEmpresa, sCentro, sProducto, sProveedor, sEntrega, sGasto: string;
    dIni, dFin: TDateTime;
  end;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, CReportes, UDMConfig,
     CAuxiliarDB, UDMBaseDatos, LQGastosEntregas, LQGastosConduce;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLGastosEntregas.BBAceptarClick(Sender: TObject);
begin
  if not CamposVacios then
  begin
    if not LQGastosEntregas.Imprimir ( sEmpresa, sCentro, sProveedor, sProducto, sEntrega, sGasto,
                                       dIni, dFin, cbxPendientePago.Checked, chkSinGastos.Checked, cbxEnvio.ItemIndex,
                                       cbxTipoCodigo.ItemIndex, cbxTipoFecha.ItemIndex, cbxTipoCentro.ItemIndex ) then
        ShowMessage('Sin datos.');
  end;
end;

procedure TFLGastosEntregas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

//                          **** FORMULARIO ****
procedure TFLGastosEntregas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eProducto.Tag := kProducto;
  eProveedor.Tag := kProveedor;
  eDesde.Tag := kCalendar;
  eHasta.Tag := kCalendar;
  eGasto.Tag:= kTipoGastos;

  eEmpresa.Text := gsDefEmpresa;
  eCentro.Text := '';
  PonNombre( eCentro );
  eProveedor.Text := '';
  PonNombre( eProveedor );
  eProducto.Text := '';
  PonNombre( eProducto );
  eGasto.Text := '';
  PonNombre( eGasto );
  eDesde.Text := DateTostr(Date-6);
  eHasta.Text := DateTostr(Date);

  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  CalendarioFlotante.Date := Date;

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;

  begin
    btnAceptarConduce.Visible:= False;
    BAceptarConduce.Enabled:= False;
    BAceptarEntrega.Caption:= 'Aceptar [F1]';
    chkSinGastos.Visible:= True;
  end;
end;

procedure TFLGastosEntregas.FormActivate(Sender: TObject);
begin
  Top := 1;
  if EEntrega.CanFocus then
    ActiveControl := EEntrega
  else
    ActiveControl := EEmpresa;
end;

procedure TFLGastosEntregas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLGastosEntregas.FormClose(Sender: TObject;
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

  Action := caFree;
end;


//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLGastosEntregas.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kProveedor: DespliegaRejilla(btnProveedor, [EEmpresa.Text]);
    kTipoGastos: RejillaGastos;
    kCalendar:
      begin
        if eDesde.Focused then
          DespliegaCalendario(btnDesde)
        else
          DespliegaCalendario(btnHasta);
      end;
  end;
end;

procedure TFLGastosEntregas.PonNombre(Sender: TObject);
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
    kProveedor:
    begin
      if Trim(eProveedor.Text ) = '' then
        stProveedor.Caption:= 'TODOS LOS PROVEEDORES'
      else
        stProveedor.Caption:= desProveedor( eEmpresa.Text, eProveedor.Text );
    end;
    kTipoGastos:
    begin
      if Trim(eGasto.Text ) = '' then
        stGasto.Caption:= 'TODOS LOS GASTOS'
      else
        stGasto.Caption:= desTipoGastos( eGasto.Text );
    end;
  end;
end;

function TFLGastosEntregas.CamposVacios: boolean;
begin
  Result := True;

  sEntrega:= Trim(eEntrega.Text);

  if sEntrega = '' then
  begin
    //Comprobamos que los campos esten todos con datos
    if stEmpresa.Caption = '' then
    begin
      ShowError('Falta código de empresa o código incorrecto.');
      EEmpresa.SetFocus;
      Exit;
    end;
    sEmpresa:= Trim(eEmpresa.Text);

    if stCentro.Caption = '' then
    begin
      ShowError('Código de centro incorrecto.');
      ECentro.SetFocus;
      Exit;
    end;
    sCentro:= Trim(eCentro.Text);

    if stProveedor.Caption = '' then
    begin
      ShowError('Código de provedor incorrecto.');
      eProveedor.SetFocus;
      Exit;
    end;
    sProveedor:= Trim(eProveedor.Text);

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
  end;

  if stProducto.Caption = '' then
  begin
    ShowError('Código de producto incorrecto.');
    EProducto.SetFocus;
    Exit;
  end;
  sProducto:= Trim(eProducto.Text);

  if stGasto.Caption = '' then
  begin
    ShowError('Código de tipo de gasto incorrecto.');
    eGasto.SetFocus;
    Exit;
  end;
  sGasto:= Trim(eGasto.Text);

  Result := False;
end;

//******************************  Parte privada  *******************************

procedure TFLGastosEntregas.eEntregaChange(Sender: TObject);
begin
  if Trim( eEntrega.Text ) <> '' then
  begin
    eEmpresa.Text:= '';
    eEmpresa.Enabled:= False;
    eDesde.Text:= '';
    eDesde.Enabled:= False;
    eHasta.Text:= '';
    eHasta.Enabled:= False;
    eCentro.Text:= '';
    eCentro.Enabled:= False;
    eProveedor.Text:= '';
    eProveedor.Enabled:= False;
  end
  else
  begin
    eEmpresa.Enabled:= True;
    eDesde.Enabled:= True;
    eHasta.Enabled:= True;
    eCentro.Enabled:= True;
    eProveedor.Enabled:= True;
  end;
end;

procedure TFLGastosEntregas.BAceptarConduceExecute(Sender: TObject);
begin
  if not CamposVacios then
  begin
    if not LQGastosConduce.Imprimir ( sEmpresa, sCentro, sProveedor, sProducto, sEntrega, sGasto,
                                       dIni, dFin, cbxPendientePago.Checked, cbxEnvio.ItemIndex,
                                       cbxTipoCodigo.ItemIndex, cbxTipoFecha.ItemIndex, cbxTipoCentro.ItemIndex ) then
        ShowMessage('Sin datos.');
  end;
end;

procedure TFLGastosEntregas.RejillaGastos;
begin
  if DMBaseDatos.QDespegables.Active then
    DMBaseDatos.QDespegables.Close;
  DMBaseDatos.QDespegables.SQL.Clear;

  RejillaFlotante.BControl := eGasto;
  DMBaseDatos.QDespegables.SQL.Add(' select tipo_tg, descripcion_tg ');
  DMBaseDatos.QDespegables.SQL.Add(' from frf_tipo_gastos ');
  DMBaseDatos.QDespegables.SQL.Add(' where gasto_transito_tg = 2 ');
  DMBaseDatos.QDespegables.SQL.Add(' order by tipo_tg, descripcion_tg ');

  DMBaseDatos.QDespegables.Open;
  btnGasto.GridShow;
end;

end.

