unit LLiquidacionSinValorar;

interface




uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TFLLiquidacionSinValorar = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    BGBCentro: TBGridButton;
    LCentro: TLabel;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LProducto: TLabel;
    BGBProducto: TBGridButton;
    lblNombre1: TLabel;
    lblNombre2: TLabel;
    GroupBox1: TGroupBox;
    lblNombre3: TLabel;
    lblNombre4: TLabel;
    BCBDesde: TBCalendarButton;
    BCBHasta: TBCalendarButton;
    MEDesde: TBEdit;
    MEHasta: TBEdit;
    STCentro: TStaticText;
    STProducto: TStaticText;
    STEmpresa: TStaticText;
    EEmpresa: TBEdit;
    ECentro: TBEdit;
    EProducto: TBEdit;
    ECosechero: TBEdit;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);

  public
    { Public declarations }
  private

    procedure LiquidacionEscandalloSinValorar;

  public
  end;

implementation

uses CVariables, CAuxiliarDB, UDMBaseDatos, CGestionPrincipal, bSQLUtils,
  UDMAuxDB, bMath, DateUtils, bDialogs, ULiquidacionSinValorar;


{$R *.DFM}

procedure TFLLiquidacionSinValorar.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
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

procedure TFLLiquidacionSinValorar.BBAceptarClick(Sender: TObject);
var
  aux: string;
  fechasCorrectas: boolean;
  ControlError: TWinControl;
begin
  if not CerrarForm(true) then Exit;

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

  fechasCorrectas := true;
  if MEDesde.Text = '' then
  begin
    AddLine(aux, 'La fecha de inicio es de obligada inserción y debe ser lunes.');
    SetFocusNil(ControlError, MEDesde);
    fechasCorrectas := false;
  end
  else
  begin
    try
      //Debe ser lunes
      if DayOfWeek(StrTodate(MEDesde.text)) <> 2 then
      begin
        AddLine(aux, 'El dia de inicio debe ser lunes.');
        SetFocusNil(ControlError, MEDesde);
        fechasCorrectas := false;
      end;
    except
      AddLine(aux, 'Fecha de inicio incorrecta.');
      SetFocusNil(ControlError, MEDesde);
    end;
  end;
  if MEHasta.Text = '' then
  begin
    AddLine(aux, 'La fecha de fin es de obligada inserción y debe ser domingo.');
    SetFocusNil(ControlError, MEHasta);
    fechasCorrectas := false;
  end
  else
  begin
    try
      //Debe ser domingo
      if DayOfWeek(StrTodate(MEHasta.text)) <> 1 then
      begin
        AddLine(aux, 'El dia de fin debe ser domingo.');
        SetFocusNil(ControlError, MEHasta);
        fechasCorrectas := false;
      end;
    except
      AddLine(aux, 'Fecha de fin incorrecta.');
      SetFocusNil(ControlError, MEDesde);
    end;
  end;
     //Rango correcto
  if fechasCorrectas and (StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text)) then
  begin
    AddLine(aux, 'La fecha de inicio debe ser menor que la de fin.');
    SetFocusNil(ControlError, MEDesde);
  end;

  if Trim(Aux) <> '' then
  begin
    ShowError(Aux);
    ActiveControl := ControlError;
    Exit;
  end;


  LiquidacionEscandalloSinValorar;
end;


procedure TFLLiquidacionSinValorar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  Action := caFree;
end;

procedure TFLLiquidacionSinValorar.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  MEDesde.Text := DateToStr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;
  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  EEmpresa.Text := gsDefEmpresa;
  ECentro.Text := gsDefCentro;
  EProducto.Text := gsDefProducto;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  Top := 1;
end;

procedure TFLLiquidacionSinValorar.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLLiquidacionSinValorar.ADesplegarRejillaExecute(Sender: TObject);
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

procedure TFLLiquidacionSinValorar.PonNombre(Sender: TObject);
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

procedure TFLLiquidacionSinValorar.LiquidacionEscandalloSinValorar;
begin
  ULiquidacionSinValorar.CrearTablasTemporales;
  try
    ULiquidacionSinValorar.LiquidacionPorEscandallo(EEmpresa.Text, ECentro.Text,
            EProducto.Text, ECosechero.Text, MEDesde.Text, MEHasta.Text );
  finally
    ULiquidacionSinValorar.DestruirTablasTemporales;
  end;
end;

end.
