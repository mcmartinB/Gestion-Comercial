{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LVerLiquidacionFruta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TVerLiquidacionFruta = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    LEmpresa: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    BGBCentro: TBGridButton;
    ECentro: TBEdit;
    LCentro: TLabel;
    LProducto: TLabel;
    EProducto: TBEdit;
    BGBProducto: TBGridButton;
    STProducto: TStaticText;
    ECosechero: TBEdit;
    Label6: TLabel;
    Label7: TLabel;
    chkPlantaciones: TCheckBox;
    chkGastos: TCheckBox;
    chkAbonos: TCheckBox;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure EProductoChange(Sender: TObject);

  public
    { Public declarations }
  private
     sEmpresa, sCentro, sCosechero, sProducto: string;
     dFechaIni, dFechaFin: TDateTime;
     function ValidarParametros: Boolean;

  public
  end;

implementation

uses CVariables, CAuxiliarDB, CGestionPrincipal, bSQLUtils,
  UDMAuxDB, bMath,  bDialogs, RVerLiquidacionFruta,
  RVerLiquidacionFrutaEx, UDMBaseDatos;


{$R *.DFM}

procedure TVerLiquidacionFruta.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

procedure AddLine(var AText: string; ALine: string);
begin
  if Trim(AText) <> '' then
  begin
    AText := AText + #13 + #10 + ALine;
  end
  else
  begin
    AText := ALine;
  end;
end;

procedure SetFocusNil(var AFocus: TWinControl; AControl: TWinControl);
begin
  if AFocus = nil then AFocus := AControl;
end;

function TVerLiquidacionFruta.ValidarParametros: Boolean;
var
  aux: string;
  ControlError: TWinControl;
begin
     //, sCentro, sCosechero, sProducto: string;
     //dFechaIni, dFechaFin: TDateTime;
  aux := '';
  ControlError := nil;

  //Comprobar si los campos se han rellenado correctamente
  if EEmpresa.Text = '' then
  begin
    AddLine(aux, 'El código de empresa es de obligada inserción.');
    SetFocusNil(ControlError, EEmpresa);
  end;
  if ECentro.Text = '' then
  begin
    AddLine(aux, 'El código de centro es de obligada inserción.');
    SetFocusNil(ControlError, ECentro);
  end;
  if EProducto.Text = '' then
  begin
    AddLine(aux, 'El código de producto es de obligada inserción.');
    SetFocusNil(ControlError, EProducto);
  end;

  if not TryStrToDate( MEDesde.Text, dFechaIni ) then
  begin
    AddLine(aux, 'Falta la fecha de inicio o es incorrecta.');
    SetFocusNil(ControlError, MEDesde);
  end;
  if not TryStrToDate( MEHasta.Text, dFechaFin ) then
  begin
    AddLine(aux, 'Falta la fecha de fin o es incorrecta.');
    SetFocusNil(ControlError, MEHasta);
  end;
  if dFechaFin < dFechaIni then
  begin
    AddLine(aux, 'Rango de fechas incorrecto.');
    SetFocusNil(ControlError, MEDesde);
  end;

  if Trim(Aux) <> '' then
  begin
    ShowError(Aux);
    ActiveControl := ControlError;
    Result:= False;
  end
  else
  begin
    sEmpresa:= EEmpresa.Text;
    sCentro:= ECentro.Text;
    sProducto:= EProducto.Text;
    sCosechero:= ECosechero.Text;
    Result:= True;
  end;

end;


procedure TVerLiquidacionFruta.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ValidarParametros then
  begin
    if chkPlantaciones.Checked then
    begin
      if not RVerLiquidacionFrutaEx.VerLiquidacionFruta( self, sEmpresa, sCentro, sProducto, sCosechero, dFechaIni, dFechaFin, chkPlantaciones.Checked, chkGastos.Checked, chkAbonos.Checked ) then
      begin
        ShowMessage('Sin datos');
      end;
    end
    else
    begin
      if not RVerLiquidacionFruta.VerLiquidacionFruta( self, sEmpresa, sCentro, sProducto, sCosechero, dFechaIni, dFechaFin, chkPlantaciones.Checked, chkGastos.Checked, chkAbonos.Checked ) then
      begin
        ShowMessage('Sin datos');
      end;
    end;
  end;

end;


procedure TVerLiquidacionFruta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  Action := caFree;
end;

procedure TVerLiquidacionFruta.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  EEmpresa.Text := '080';
  ECentro.Text := '6';
  EProducto.Text := 'I';
  MEDesde.Text := DateTostr(Date-7);
  MEHasta.Text := DateToStr(Date-1);

  CalendarioFlotante.Date := Date;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  Top := 1;
end;

procedure TVerLiquidacionFruta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TVerLiquidacionFruta.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(BGBCentro, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TVerLiquidacionFruta.PonNombre(Sender: TObject);
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
        STEmpresa.Caption := desEmpresa(Eempresa.Text);
        STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text);
        STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
      end;
    kProducto: STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
    kCentro: STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text);
  end;
end;

procedure TVerLiquidacionFruta.EProductoChange(Sender: TObject);
begin
  PonNombre(Sender);
end;

end.
