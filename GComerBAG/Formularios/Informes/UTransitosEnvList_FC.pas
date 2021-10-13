unit UTransitosEnvList_FC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, StrUtils, DBCtrls;

type
  TTransitosEnvList_FC = class(TForm)
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
    lblProducto: TLabel;
    eProducto: TBEdit;
    BGBProducto: TBGridButton;
    stProducto: TStaticText;
    BCBDesde: TBCalendarButton;
    eFechaDesde: TBEdit;
    Desde: TLabel;
    Label14: TLabel;
    eFechaHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lblEspere1: TLabel;
    lblNombre1: TLabel;
    eCentro: TBEdit;
    BGBCentro: TBGridButton;
    stCentro: TStaticText;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure eFechaDesdeExit(Sender: TObject);

  private
    sEmpresa, sCentro, sProducto: string;
    dFechaDesde, dFechaHasta: TDateTime;

    function  LeerParametros: Boolean;
  public

  end;

var
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview,
   CAuxiliarDB, UDMBaseDatos, bDialogs, bMath, bTimeUtils,
   UTransitosEnvList_MD, UTransitosEnvList_QR;

{$R *.DFM}

//                       ****  BOTONES  ****

function  TTransitosEnvList_FC.LeerParametros: Boolean;
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

  if not TryStrToDate( eFechaDesde.Text, dFechaDesde ) then
  begin
    ShowMessage('Fecha de inicio incorrecta');
    Exit;
  end;
  (*PARCHE-20060524*)(*MODIF-20060524*)(*PACO*)(*ERNESTO*)
  (*Ignorar transitos de antes del *)
  if dFechaDesde < StrToDate('1/7/2001') then
  begin
    dFechaDesde:= StrToDate('1/7/2001');
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

  if stProducto.Caption = '' then
  begin
    ShowMessage('El código del producto es incorrrecto.');
    Exit;
  end;
  sproducto := eProducto.Text;

  result:= True;
end;

procedure TTransitosEnvList_FC.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if LeerParametros then
  begin
    lblEspere1.Visible := true;
    Application.ProcessMessages;

    //Recoger datos
    MDTransitosEnvList.CargaQuery( sEmpresa, sCentro, sProducto, dFechaDesde, dFechaHasta );
    MDTransitosEnvList.CreaListado;

    lblEspere1.Visible := false;
    Application.ProcessMessages;

    //Previsualizar informe
    Previsualizar( sEmpresa, sCentro, sProducto, dFechaDesde, dFechaHasta );
  end;
end;

procedure TTransitosEnvList_FC.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TTransitosEnvList_FC.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  CalendarioFlotante.Date := Date;
    gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eProducto.Tag := kProducto;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;


  eEmpresa.Text := gsDefEmpresa;
  eFechaDesde.Text := DateTostr(LunesAnterior(Date) - 7);
  eFechaHasta.Text := DateTostr(LunesAnterior(Date) - 1);
  eCentro.Text := '6';
  eProducto.Text:= '';

  PonNombre( eEmpresa );

  MDTransitosEnvList:= TTransitosEnvList_MD.Create( self );
end;

procedure TTransitosEnvList_FC.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TTransitosEnvList_FC.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TTransitosEnvList_FC.FormClose(Sender: TObject;
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

  FreeAndNil( MDTransitosEnvList );
  Action := caFree;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TTransitosEnvList_FC.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(BGBCentro, [eEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [eEmpresa.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TTransitosEnvList_FC.PonNombre(Sender: TObject);
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
      PonNombre( eProducto );
    end;
    kCentro:
    begin
      stCentro.Caption := desCentro(eEmpresa.Text, eCentro.Text);
    end;
    kProducto:
    begin
      if eProducto.Text = '' then
      begin
        STProducto.Caption := 'TODOS LOS PRODUCTOS.';
      end
      else
      begin
        STProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text);
      end;
    end;
  end;
end;

procedure TTransitosEnvList_FC.eFechaDesdeExit(Sender: TObject);
var
  dFecha: TDate;
begin
  dFecha:= StrToDateDef( eFechaDesde.Text, Date );
  if dFecha < StrToDate( '1/7/2001') then
    eFechaDesde.Text:= '01/07/2001';
end;

end.
