{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LiquidaPeriodoFD;

interface




uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TFDLiquidaPeriodo = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    BCBHasta: TBCalendarButton;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LProducto: TLabel;
    BGBProducto: TBGridButton;
    Label7: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    lbl1: TLabel;
    cbxLiquidaDefinitiva: TCheckBox;
    MEDesde: TBEdit;
    MEHasta: TBEdit;
    STProducto: TStaticText;
    STEmpresa: TStaticText;
    EEmpresa: TBEdit;
    EProducto: TBEdit;
    ECosteComercial: TBEdit;
    ECosteAdministrativo: TBEdit;
    ECosteProduccion: TBEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lblMsg: TLabel;
    btnPrueba: TSpeedButton;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure EProductoChange(Sender: TObject);
    procedure btnPruebaClick(Sender: TObject);

  private
    sEmpresa, sProducto: string;
    dDesde, dHasta: TDatetime;
    rComercial, rProduccion, rAdministrativo: Real;
    bDefinitiva: Boolean;

    function ParametrosOK: Boolean;
    procedure LiquidarPerido;
    procedure CargarPerido;

  public
    { Public declarations }

  end;

implementation

uses CVariables, CAuxiliarDB, UDMBaseDatos, CGestionPrincipal, bSQLUtils, bTextUtils,
  UDMAuxDB, bMath, DateUtils, bDialogs, LiquidaPeriodoControlDM, LiquidaPeriodoDM,
  LiquidaPeriodoResumenQR, LiquidaPeriodoBDDatosDM;


{$R *.DFM}

procedure TFDLiquidaPeriodo.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure SetFocusNil(var AFocus: TWinControl; AControl: TWinControl);
begin
  if AFocus = nil then AFocus := AControl;
end;

function TFDLiquidaPeriodo.ParametrosOK: Boolean;
var
  sAux: string;
  ControlError: TWinControl;
  bFechasCorrectas: Boolean;
begin
  sAux := '';
  ControlError := nil;
  //Comprobar si los campos se han rellenado correctamente
  if STEmpresa.Caption = '' then
  begin
    bTextUtils.
    AddLine(sAux, 'El código de empresa es de obligada inserción.');
    SetFocusNil(ControlError, EEmpresa);
  end;
  if STProducto.Caption = '' then
  begin
    AddLine(sAux, 'El código de producto es de obligada inserción.');
    SetFocusNil(ControlError, EProducto);
  end;

  bFechasCorrectas := True;
  if not TryStrToDate( MEDesde.Text, dDesde )  then
  begin
    AddLine(sAux, 'La fecha de inicio es de obligada inserción.');
    SetFocusNil(ControlError, MEDesde);
    bFechasCorrectas := false;
  end;
  if not TryStrToDate( MEHasta.Text, dHasta )  then
  begin
    AddLine(sAux, 'La fecha de fin es de obligada inserción.');
    SetFocusNil(ControlError, MEDesde);
    bFechasCorrectas := false;
  end;
  if bFechasCorrectas and ( dDesde > dHasta ) then
  begin
    AddLine(sAux, 'El rando de fechas es incorrecto.');
    SetFocusNil(ControlError, MEDesde);
  end;

  if Trim(sAux) <> '' then
  begin
    ShowError(sAux);
    ActiveControl := ControlError;
    result:= False;
  end
  else
  begin
    sEmpresa:= Trim( EEmpresa.Text);
    sProducto:= Trim( EProducto.Text);


    rComercial:= StrToFloatDef( ECosteComercial.Text, 0);
    rProduccion:= StrToFloatDef( ECosteProduccion.Text, 0);
    rAdministrativo:= StrToFloatDef( ECosteAdministrativo.Text, 0);

    bDefinitiva:= cbxLiquidaDefinitiva.Checked;

    result:= True;
  end;
end;


procedure TFDLiquidaPeriodo.BBAceptarClick(Sender: TObject);

begin
  if not CerrarForm(true) then
    Exit;

  if ParametrosOK then
  begin
    LiquidarPerido;
  end;
end;


procedure TFDLiquidaPeriodo.btnPruebaClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ParametrosOK then
  begin
    CargarPerido;
  end;
end;



procedure TFDLiquidaPeriodo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  FreeAndNil( DMLiquidaPeriodoControl );
  FreeAndNil( DMLiquidaPeriodo );
  FreeAndNil( DMLiquidaPeriodoBDDatos );
  Action := caFree;
end;

procedure TFDLiquidaPeriodo.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  EEmpresa.Text := '080';
  EProducto.Text := '';
  MEDesde.Text := DateToStr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  (*ANTERIOR
  ECosteComercial.Text:= '0,013';
  ECosteProduccion.Text:= '0,008';
  ECosteAdministrativo.Text:= '0,027';
  *)
  ECosteComercial.Text:= '0,014';
  ECosteProduccion.Text:= '0,010';
  ECosteAdministrativo.Text:= '0,050';

  EEmpresa.Text := '050';
  EProducto.Text := 'C';
  MEDesde.Text := '27/06/2016';
  MEHasta.Text := '03/07/2016';

  Top := 1;

  DMLiquidaPeriodo:= TDMLiquidaPeriodo.Create( Self );
  DMLiquidaPeriodoControl:= TDMLiquidaPeriodoControl.Create( Self );
  DMLiquidaPeriodoBDDatos:= TDMLiquidaPeriodoBDDatos.Create( Self );

  lblMsg.Caption:= '';
  lblMsg.Visible:= True;
end;

procedure TFDLiquidaPeriodo.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDLiquidaPeriodo.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFDLiquidaPeriodo.PonNombre(Sender: TObject);
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
        STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
      end;
    kProducto: STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
  end;
end;

procedure TFDLiquidaPeriodo.LiquidarPerido;
var
  sMsg: string;
begin
  sMsg:= '';
  if DMLiquidaPeriodoControl.VerificarPeriodo( sEmpresa, sProducto, dDesde, dHasta,
                                   rComercial, rProduccion, rAdministrativo, bDefinitiva, sMsg ) then
  begin

    DMLiquidaPeriodo.LiquidarPerido( sEmpresa, sProducto, dDesde, dHasta,
                                   rComercial, rProduccion, rAdministrativo, bDefinitiva, lblMsg );
    //DMLiquidaPeriodoBDDatos.SalvaDatos;
    LiquidaPeriodoResumenQR.Imprimir;
  end
  else
  begin
    ShowError( sMsg );
  end;

  lblMsg.Caption:= '';
end;

procedure TFDLiquidaPeriodo.CargarPerido;
begin
  if DMLiquidaPeriodoBDDatos.CargaDatos( sEmpresa, sProducto, dDesde, dHasta ) then
    LiquidaPeriodoResumenQR.Imprimir
  else
    ShowMessage('Sin datos cargados');
end;

procedure TFDLiquidaPeriodo.EProductoChange(Sender: TObject);
begin
  PonNombre(Sender);
end;

end.
