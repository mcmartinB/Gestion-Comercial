unit LResumenRemesas;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Buttons, Db, DbTables, ActnList,
  ComCtrls, BGridButton, BEdit, DError, Dialogs, BSpeedButton,
  BCalendarButton, BCalendario, nbLabels;

type
  TFLResumenRemesas = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    eEmpresa: TBEdit;
    eBanco: TBEdit;
    eDFecha: TBEdit;
    eHFecha: TBEdit;
    lblEmpresa: TnbLabel;
    stEmpresa: TnbStaticText;
    lblBanco: TnbLabel;
    stBanco: TnbStaticText;
    lblFechaDesde: TnbLabel;
    lblFechaHasta: TnbLabel;
    Label1: TLabel;
    nbLabel1: TnbLabel;
    eCliente: TBEdit;
    stCliente: TnbStaticText;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);
    procedure eBancoChange(Sender: TObject);
    procedure BCancelarExecute(Sender: TObject);
    procedure eClienteChange(Sender: TObject);

  private

  end;

implementation

uses UDMAuxDB, CVariables, Principal, CGestionPrincipal, UDMBaseDatos,
  CAuxiliarDB, DPreview, CReportes, LResumenRemesasReport, UDMConfig, CGlobal;

{$R *.DFM}

procedure TFLResumenRemesas.BBAceptarClick(Sender: TObject);
var
  ini, fin: TDateTime;
begin
  if not CerrarForm(true) then Exit;

     //Comprobar si los campos se han rellenado
  if stEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto.');
    EEmpresa.SetFocus;
    Exit;
  end;

  try
    ini := StrToDate(eDFecha.Text)
  except
    ShowError('Es necesario que rellene todos los campos de edición.');
    eDFecha.SetFocus;
    Exit;
  end;

  try
    fin := StrToDate(eHFecha.Text)
  except
    ShowError('Es necesario que rellene todos los campos de edición.');
    eHFecha.SetFocus;
    exit;
  end;

  if ini > fin then
  begin
    ShowError('Rango de fechas incorrecto');
    eDFecha.SetFocus;
    Exit;
  end;

  if stBanco.Caption = '' then
  begin
    ShowError('Código de banco incorrecto');
    eBanco.SetFocus;
    Exit;
  end;

  if stCliente.Caption = '' then
  begin
    ShowError('Código de cliente incorrecto');
    eCliente.SetFocus;
    Exit;
  end;

  QRResumenRemesasPrint(eEmpresa.Text, eBanco.Text, eCliente.Text, eDFecha.Text, eHFecha.Text);
end;


procedure TFLResumenRemesas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gRF := nil;

  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLResumenRemesas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;


  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    eEmpresa.Text := 'BAG'
  else
    eEmpresa.Text := 'SAT';
  //eEmpresa.Text := gsDefEmpresa;
  eDFecha.Text := DateToStr(Date - 6);
  eHFecha.Text := DateToStr(Date);
end;

procedure TFLResumenRemesas.PonNombre(Sender: TObject);
begin
  stEmpresa.Caption := desEmpresa(Eempresa.Text);
  eClienteChange( eCliente );
  eBancoChange( eBanco );
end;

procedure TFLResumenRemesas.eBancoChange(Sender: TObject);
begin
  if eBanco.Text = '' then
    stBanco.Caption := 'TODOS LOS BANCOS'
  else
    stBanco.Caption := desBanco( eBanco.Text);
end;

procedure TFLResumenRemesas.eClienteChange(Sender: TObject);
begin
  if eCliente.Text = '' then
    stCliente.Caption := 'TODOS LOS CLIENTES'
  else
  begin
    if eEmpresa.Text = 'BAG' then
      stCliente.Caption := desClienteBAG( eCliente.Text)
    else
      stCliente.Caption := desCliente(eCliente.Text);
  end;
end;

procedure TFLResumenRemesas.FormKeyDown(Sender: TObject;
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

procedure TFLResumenRemesas.BCancelarExecute(Sender: TObject);
begin
  Close;
end;

end.
