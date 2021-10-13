unit ControlEnvioAlbaranesFR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids,
  BSpeedButton, BCalendarButton, ComCtrls, BCalendario, ActnList,
  BGridButton, BGrid;

type
  TFRControlEnvioAlbaranes = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    nbLabel1: TnbLabel;
    des_empresa: TnbStaticText;
    CalendarioFlotante: TBCalendario;
    edtFechaIni: TBEdit;
    btnFechaIni: TBCalendarButton;
    edtFechaFin: TBEdit;
    btnFechaFin: TBCalendarButton;
    lblCodigo1: TnbLabel;
    lblCodigo2: TnbLabel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    rejillaFlotante: TBGrid;
    btnEmpresa: TBGridButton;
    rbEntradas: TRadioButton;
    rbTransitos: TRadioButton;
    rbVentas: TRadioButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
  private
    { Private declarations }
    { Private declarations }
    sEmpresa: string;
    dFechaIni, dFechaFin: TDateTime;
    iTipo: Integer;

    function ValidarParametros: Boolean;
    function RangoFechas( var VMsg: string ): Boolean;
    function Tipo( var VMsg: string ): Boolean;
    procedure PrevisualizarListado;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CAuxiliarDB, UDMAuxDB, Principal, CGestionPrincipal, CVariables, CGlobal,
     bTimeUtils, UDMBaseDatos, ControlEnvioAlbaranesQR;

procedure TFRControlEnvioAlbaranes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFRControlEnvioAlbaranes.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag:= kEmpresa;
  //edtEmpresa.Text := gsDefEmpresa;
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    edtEmpresa.Text := 'BAG';
  end
  else
  begin
    edtEmpresa.Text := 'SAT';
  end;
  edtFechaIni.Tag := kCalendar;
  edtFechaFin.Tag := kCalendar;
  edtFechaIni.Text := DateTostr(Date-30);
  edtFechaFin.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;
  gCF := calendarioFlotante;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
end;

procedure TFRControlEnvioAlbaranes.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFRControlEnvioAlbaranes.btnAceptarClick(Sender: TObject);
begin
  if ValidarParametros then
    PrevisualizarListado;
end;

function TFRControlEnvioAlbaranes.Tipo( var VMsg: string ): Boolean;
begin
  VMsg:= '';
  Result:= True;
  if rbEntradas.Checked then
  begin
    iTipo:= 0;
  end
  else
  if rbTransitos.Checked then
  begin
    iTipo:= 1;
  end
  else
  if rbVentas.Checked then
  begin
    iTipo:= 2;
  end
  else
  begin
    VMsg:= 'Tipo de control a visualizar no valido.';
    Result:= False;
  end;
end;

function TFRControlEnvioAlbaranes.RangoFechas( var VMsg: string ): Boolean;
begin
  VMsg:= '';
  Result:= False;
  if not TryStrToDate( edtFechaIni.Text, dFechaini ) then
  begin
    VMsg:= 'Fecha de inicio incorrecto.'
  end
  else
  if not TryStrToDate( edtFechaFin.Text, dFechafin ) then
  begin
    VMsg:= 'Fecha de fin incorrecto.'
  end
  else
  if dFechaini > dFechaFin then
  begin
    VMsg:= 'Rango de fechas incorrecto.'  end
  else
  begin
    Result:= True;
  end;
end;

function TFRControlEnvioAlbaranes.ValidarParametros: Boolean;
var
  sMsg: string;
begin
  Result:= False;
  if des_empresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
  end
  else
  if not RangoFechas( sMsg ) then
  begin
    ShowMessage( sMsg );
  end
  else
  if not Tipo ( sMsg ) then
  begin
    ShowMessage( sMsg );
  end
  else
  begin
    sEmpresa:= Trim( edtEmpresa.Text );
    Result:= True;
  end;
end;

procedure TFRControlEnvioAlbaranes.PrevisualizarListado;
begin
  ControlEnvioAlbaranesQR.PreviewReporte( sEmpresa, dFechaIni, dFechaFin, iTipo );
end;

procedure TFRControlEnvioAlbaranes.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_escape:
      begin
        btnCancelar.Click;
      end;
    vk_f1:
      begin
        btnAceptar.Click;
      end;
  end;
end;

procedure TFRControlEnvioAlbaranes.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFRControlEnvioAlbaranes.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCalendar:
      begin
        if edtFechaIni.Focused then
          DespliegaCalendario(btnFechaIni)
        else
          DespliegaCalendario(btnFechaFin);
      end;
  end;
end;

procedure TFRControlEnvioAlbaranes.edtEmpresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(edtEmpresa.Text);
end;

end.
