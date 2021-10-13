unit AgingFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt;

type
  TFLAging = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    LEmpresa: TLabel;
    edtEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    qryDatos: TQuery;
    edtHasta: TBEdit;
    edtDesde: TBEdit;
    btnDesde: TBCalendarButton;
    btnHasta: TBCalendarButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    txtCliente: TStaticText;
    DiasCobroPagare: TLabel;
    edtDiasCobroPagare: TBEdit;
    lblDeficit: TLabel;
    edtDeficit: TBEdit;
    chkAbonos: TCheckBox;
    chkIva: TCheckBox;
    chkSoloRiesgo: TCheckBox;
    procedure BBCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
  private
      {private declarations}
    sEmpresa, sCliente: string;
    dIni, dFin: TDateTime;
    iDiasCobroPagare, iDeficit: Integer;
    bAbonos, bIva, bSoloRiesgo: Boolean;

    function  VerificarDatos: boolean;

  public
    { Public declarations }
  end;

var
  FLAging: TFLAging;

implementation

uses CVariables, UDMAuxDB, bTimeUtils, CReportes, Principal, CAuxiliarDB,
     AgingDL, UDMBaseDatos, UDMConfig, DateUtils, CGlobal;

{$R *.DFM}

procedure TFLAging.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLAging.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFLAging.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCliente.Tag   := kCliente;
  edtDesde.Tag   := kCalendar;
  edtHasta.Tag   := kCalendar;

  if gProgramVersion = pvBAG then
  begin
    edtEmpresa.Text := 'BAG';
  end
  else
  begin
    edtEmpresa.Text := 'SAT';
  end;
  edtCliente.Text := '';
  edtDesde.Text := DateToStr( IncYear( Date, -1 ) );
  edtHasta.Text := DateTostr( Date );
  CalendarioFlotante.Date := Date;
  //PonNombre( edtEmpresa );

  edtDiasCobroPagare.Text:= '0';
  edtDeficit.Text:= '10000';

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;
end;

procedure TFLAging.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLAging.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCliente: DespliegaRejilla(btnCliente, [edtEmpresa.Text]);
    kCalendar:
      begin
        if edtDesde.Focused then
          DespliegaCalendario(btnDesde)
        else
          DespliegaCalendario(btnHasta);
      end;
  end;
end;

procedure TFLAging.PonNombre(Sender: TObject);
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
        if edtEmpresa.Text = 'SAT' then
        begin
          txtEmpresa.Caption := 'SAT BONNYSA';
        end
        else
        begin
          txtEmpresa.Caption := desEmpresa(edtEmpresa.Text);
        end;
        PonNombre( edtCliente );
      end;
      kCliente:
      begin
        if Trim( edtCliente.Text ) <> '' then
        begin
          txtCliente.Caption := desCliente( edtCliente.Text );
        end
        else
        begin
          txtCliente.Caption := 'TODOS LOS CLIENTES';
        end;
      end;
    end;
end;

function TFLAging.VerificarDatos: boolean;
begin
        //Comprobar si los campos se han rellenado correctamente
  Result := False;
  if txtEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto.');
    edtEmpresa.SetFocus;
  end
  else
  if txtCliente.Caption = '' then
  begin
    ShowError('El código del cliente es incorrecto.');
    edtCliente.SetFocus;
  end
  else
  if not TryStrToDate( edtDesde.Text, dIni ) then
  begin
    ShowError('La fecha de inicio es incorrecta.');
    edtDesde.SetFocus;
  end
  else
  if not TryStrToDate( edtHasta.Text, dFin ) then
  begin
    ShowError('La fecha de fin es incorrecta.');
    edtHasta.SetFocus;
  end
  else
  if dFin < dIni then
  begin
    ShowError('El rango de fechas es incorrecto.');
    edtDesde.SetFocus;
  end
  else
  begin
    sEmpresa:= Trim( edtEmpresa.Text );
    sCliente:= Trim( edtCliente.Text );
    iDiasCobroPagare:= StrToIntDef( edtDiasCobroPagare.Text, 0 );
    iDeficit:= StrToIntDef( edtDeficit.Text, 10000 );
    bAbonos:= chkAbonos.Checked;
    bIva:= chkIva.Checked;
    bSoloRiesgo:= chkSoloRiesgo.Checked;
    Result := True;
  end;
end;

procedure TFLAging.BAceptarExecute(Sender: TObject);
var
  sMsg: string;
begin
  if VerificarDatos then
  begin
    //listado
    if not AgingDL.AgingExecute( Self, sEmpresa, sCliente, dIni, dFin, iDiasCobroPagare, iDeficit, bAbonos, bIva, bSoloRiesgo, sMsg ) then
    begin
      ShowMessage( sMsg );
    end;
  end;
end;

end.
