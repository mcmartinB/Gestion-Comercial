unit CFLDepositoAduanasDOC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils, DBCtrls, BDEdit;

type
  TFLDepositoAduanasDOC = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label1: TLabel;
    eEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    BCBDesde: TBCalendarButton;
    eFechaDesde: TBEdit;
    Desde: TLabel;
    Label14: TLabel;
    eFechaHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lblNombre1: TLabel;
    eCentro: TBEdit;
    BGBCentro: TBGridButton;
    stCentro: TStaticText;
    chkPesoNeto: TCheckBox;
    lblCarpeta: TLabel;
    edtCarpeta: TBEdit;
    chkSinFacturaEstadistico: TCheckBox;
    lblpuerto_salida: TLabel;
    edtpuerto_salida: TBDEdit;
    btnpuerto_salida: TBGridButton;
    txtpuerto_salida: TStaticText;
    lbl1: TLabel;
    cbbDestino: TComboBox;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtpuerto_salidaChange(Sender: TObject);
    procedure btnpuerto_salidaClick(Sender: TObject);

  private
    iCarpeta: integer;
    sEmpresa, sCentro, sPuertoSalida: string;
    dFechaDesde, dFechaHasta: TDateTime;

    function  LeerParametros: Boolean;
  public

  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview,
   CAuxiliarDB, UDMBaseDatos, bDialogs, bMath, bTimeUtils,
   CDLDepositoAduanasDOC, CRLDepositoAduanasDOC;

{$R *.DFM}

//                       ****  BOTONES  ****

function  TFLDepositoAduanasDOC.LeerParametros: Boolean;
begin
  result:= False;
  if stEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
    Exit;
  end;
  sEmpresa := Trim(eEmpresa.Text);

  if stCentro.Caption = '' then
  begin
    ShowMessage('Falta el código del centro o es incorrecto.');
    Exit;
  end;
  sCentro := eCentro.Text;

  if txtpuerto_salida.Caption = '' then
  begin
    ShowMessage('El código del puerto es incorrecto.');
    Exit;
  end;
  sPuertoSalida := Trim( edtpuerto_salida.Text );

  if not TryStrToDate( eFechaDesde.Text, dFechaDesde ) then
  begin
    ShowMessage('Fecha de inicio incorrecta');
    Exit;
  end;
  if not TryStrToDate( eFechaHasta.Text, dFechaHasta ) then
  begin
    ShowMessage('Fecha de fin incorrecta');
    Exit;
  end;
  if dFechaDesde > dFechaHasta then
  begin
    if dFechaDesde < StrToDate('1/7/2001') then
    begin
      ShowMessage('La fecha de fin debe ser mayor que ''1/7/2001''. ');
      Exit;
    end
    else
    begin
      ShowMessage('La fecha de fin debe ser meyor que la de inicio. ');
      Exit;
    end;
  end;

  iCarpeta:= StrToIntDef( edtCarpeta.Text, -1 );

  result:= True;
end;

procedure TFLDepositoAduanasDOC.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if LeerParametros then
  begin
    //Recoger datos
    case DLDepositoAduanasDOC.AbrirQuery( sEmpresa, sCentro, sPuertoSalida, dFechaDesde, dFechaHasta, iCarpeta,
                                          (cbbDestino.ItemIndex=0),chkSinFacturaEstadistico.Checked, not chkPesoNeto.Checked  ) of
      -1: begin
           ShowMessage('Sin datos para los parametros seleccionados.' );
           DLDepositoAduanasDOC.CerrarQuery;
          end;
       0: begin
           //No hace nada
           DLDepositoAduanasDOC.CerrarQuery;
          end;
       1: try
           Previsualizar( self, sEmpresa, sCentro, sPuertoSalida, dFechaDesde, dFechaHasta );
          finally
            DLDepositoAduanasDOC.CerrarQuery;
          end;
       2: try
           CrearBaseDatos( self, sEmpresa, sCentro, sPuertoSalida, dFechaDesde, dFechaHasta );
          finally
            DLDepositoAduanasDOC.CerrarQuery;
          end;
    end;
  end;
end;

procedure TFLDepositoAduanasDOC.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLDepositoAduanasDOC.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CalendarioFlotante.Date := Date;
    gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  edtpuerto_salida.Tag := kAduana;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;


  eEmpresa.Text := '050';
  eCentro.Text := '6';
  edtpuerto_salida.Text:= '';
  edtpuerto_salida.Change;
  eFechaDesde.Text := DateTostr( Date - 7);
  eFechaHasta.Text := DateTostr( Date - 1);
  (*
  eFechaDesde.Text := DateTostr(LunesAnterior(Date) - 7);
  eFechaHasta.Text := DateTostr(LunesAnterior(Date) - 1);
  *)


  PonNombre( eEmpresa );

  DLDepositoAduanasDOC:= TDLDepositoAduanasDOC.Create( self );
end;

procedure TFLDepositoAduanasDOC.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TFLDepositoAduanasDOC.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLDepositoAduanasDOC.FormClose(Sender: TObject;
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

  FreeAndNil( DLDepositoAduanasDOC );
  Action := caFree;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLDepositoAduanasDOC.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(BGBCentro, [eEmpresa.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLDepositoAduanasDOC.PonNombre(Sender: TObject);
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
      STEmpresa.Caption := desEmpresa(eEmpresa.Text);
      PonNombre( eCentro );
    end;
    kCentro:
    begin
      stCentro.Caption := desCentro(eEmpresa.Text, eCentro.Text);
    end;
  end;
end;

procedure TFLDepositoAduanasDOC.edtpuerto_salidaChange(Sender: TObject);
begin
  if Trim( edtpuerto_salida.Text ) = '' then
    txtpuerto_salida.Caption := 'TODOS LOS PUERTOS'
  else
    txtpuerto_salida.Caption := desAduana(edtpuerto_salida.Text);
end;

procedure TFLDepositoAduanasDOC.btnpuerto_salidaClick(Sender: TObject);
begin
  DespliegaRejilla( btnpuerto_salida, [] );
end;

end.
