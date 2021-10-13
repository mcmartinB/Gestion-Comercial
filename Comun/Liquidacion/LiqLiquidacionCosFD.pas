{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LiqLiquidacionCosFD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TFDLiqLiquidacionCos = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    SpeedButton2: TSpeedButton;
    lblFechaIni: TLabel;
    btnMes: TBCalendarButton;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LProducto: TLabel;
    BGBProducto: TBGridButton;
    edtFechaIni: TBEdit;
    STProducto: TStaticText;
    STEmpresa: TStaticText;
    EEmpresa: TBEdit;
    EProducto: TBEdit;
    btnPrueba: TSpeedButton;
    lblCentro: TLabel;
    edtCentro: TBEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    lblSemana: TLabel;
    edtMeses: TBEdit;
    edtFechaFin: TBEdit;
    rgTipoListado: TRadioGroup;
    btn1: TSpeedButton;
    procedure BBCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure btnPruebaClick(Sender: TObject);
    procedure edtMesesChange(Sender: TObject);
    procedure edtFechaIniChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);

  private
    sEmpresa, sCentro, sProducto: string;
    dDesde, dHasta: TDatetime;

    function ParametrosOK: Boolean;
    procedure PonDesProducto;
    procedure PonDesCentro;

  public
    { Public declarations }

  end;

implementation

uses CVariables, CAuxiliarDB, UDMBaseDatos, CGestionPrincipal, bSQLUtils, bTextUtils,
  UDMAuxDB, bMath, DateUtils, bDialogs, LiqLiquidacionCosDM, bTimeUtils;


{$R *.DFM}

procedure TFDLiqLiquidacionCos.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure SetFocusNil(var AFocus: TWinControl; AControl: TWinControl);
begin
  if AFocus = nil then AFocus := AControl;
end;

function TFDLiqLiquidacionCos.ParametrosOK: Boolean;
var
  sAux: string;
  ControlError: TWinControl;
  iMeses: Integer;
  iYear, iMonth, iDay: word;
begin
  sAux := '';
  ControlError := nil;
  //Comprobar si los campos se han rellenado correctamente
  if STEmpresa.Caption = '' then
  begin
    bTextUtils.AddLine(sAux, 'Falta el código de empresa o es icorrecto.');
    SetFocusNil(ControlError, EEmpresa);
  end;
  if txtCentro.Caption = '' then
  begin
    bTextUtils.AddLine(sAux, 'Falta el código del centro o es incorrecto.');
    SetFocusNil(ControlError, edtCentro);
  end;
  if STProducto.Caption = '' then
  begin
    AddLine(sAux, 'Falta el código del producto o es incorrecto.');
    SetFocusNil(ControlError, EProducto);
  end;

  if not TryStrToDate( edtFechaIni.Text, dDesde )  then
  begin
   AddLine(sAux, 'La fecha de inicio es de obligada inserción.');
    SetFocusNil(ControlError, edtFechaIni);
  end;
  iMeses:= StrToIntDef( edtMeses.Text, 1 );
  DecodeDate( dDesde, iYear, iMonth, iDay );
  if iDay <> 1 then
  begin
    AddLine(sAux, 'La fecha de inicio debe ser el dia uno del mes.');
    SetFocusNil(ControlError, edtFechaIni);
  end;
  dHasta:= IncMonth( dDesde, iMeses ) - 1;

  if Trim(sAux) <> '' then
  begin
    ShowError(sAux);
    ActiveControl := ControlError;
    result:= False;
  end
  else
  begin
    sEmpresa:= Trim( EEmpresa.Text );
    sCentro:= Trim( edtCentro.Text );
    sProducto:=Trim( EProducto.Text );
    result:= True;
  end;
end;


procedure TFDLiqLiquidacionCos.btnPruebaClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;
  if ParametrosOK then
  begin
    DMLiqLiquidacionCos.InformeLiquidacionResumen( sEmpresa, sCentro, sProducto, dDesde, dHasta );
    (*
    case rgTipoListado.ItemIndex of
      0: DMLiqLiquidacionCos.InformeLiquidacionResumen( sEmpresa, sCentro, sProducto, dDesde, dHasta );
      1: DMLiqLiquidacionCos.InformeLiquidacionCategoria( sEmpresa, sCentro, sProducto, dDesde, dHasta );
    end;
    *)
  end;
end;



procedure TFDLiqLiquidacionCos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  FreeAndNil( DMLiqLiquidacionCos );
  Action := caFree;
end;

procedure TFDLiqLiquidacionCos.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  edtFechaIni.Tag := kCalendar;
  edtFechaFin.Tag := kCalendar;

  EEmpresa.Text := '050';
  edtCentro.Text := '1';
  EProducto.Text := 'TOM';

  CalendarioFlotante.Date := Date;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;


  edtFechaIni.Text:= FormatDateTime('dd/mm/yyyy', Now  );
  edtMeses.Text:= '1';
  DMLiqLiquidacionCos:= TDMLiqLiquidacionCos.Create( Self );
end;

procedure TFDLiqLiquidacionCos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDLiqLiquidacionCos.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCalendar:
    begin
      if edtfechaini.Focused then
        DespliegaCalendario(btnMes);
    end;
  end;
end;

procedure TFDLiqLiquidacionCos.PonNombre(Sender: TObject);
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
        PonDesProducto;
        PonDesCentro;
      end;
    kProducto: PonDesProducto;
    kCentro: PonDesCentro;
  end;
end;


procedure TFDLiqLiquidacionCos.PonDesProducto;
begin
  if EProducto.Text = '' then
    STProducto.Caption := 'TODOS LOS PRODUCTOS.'
  else
    STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
end;

procedure TFDLiqLiquidacionCos.PonDesCentro;
begin
  if edtCentro.Text = '' then
    txtCentro.Caption := 'TODOS LOS CENTROS.'
  else
    txtCentro.Caption:= desCentro(Eempresa.Text, edtCentro.Text);
end;

procedure TFDLiqLiquidacionCos.edtMesesChange(Sender: TObject);
var
  iSemanas: Integer;
  dAux: TDateTime;
begin
  iSemanas:= StrToIntDef( edtMeses.Text, 1 );
  if TryStrToDate( edtfechaini.Text, dAux ) then
  begin
    dAux:= IncMonth( dAux, iSemanas ) - 1;
    edtfechafin.Text:= FormatDateTime('dd/mm/yyyy', dAux );
  end
  else
  begin
    edtfechafin.Text:= '';
  end;
end;

procedure TFDLiqLiquidacionCos.edtFechaIniChange(Sender: TObject);
var
  dAux: TDateTime;
begin
  edtMesesChange( edtMeses );
  if TryStrToDate( edtFechaIni.Text, dAux ) then
  begin
    case DayOfTheWeek( dAux ) of
      1: lblFechaIni.Caption:= ' Fecha Ini. (Lun)';
      2: lblFechaIni.Caption:= ' Fecha Ini. (Mar)';
      3: lblFechaIni.Caption:= ' Fecha Ini. (Mie)';
      4: lblFechaIni.Caption:= ' Fecha Ini. (Jue)';
      5: lblFechaIni.Caption:= ' Fecha Ini. (Vie)';
      6: lblFechaIni.Caption:= ' Fecha Ini. (Sab)';
      7: lblFechaIni.Caption:= ' Fecha Ini. (Dom)';
    end;
  end
  else
  begin
    lblFechaIni.Caption:= ' Fecha Ini.';
  end;
end;

procedure TFDLiqLiquidacionCos.btn1Click(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;
  if ParametrosOK then
  begin
    DMLiqLiquidacionCos.InformeLiquidacionPosei( sEmpresa, sCentro, sProducto, dDesde, dHasta );
  end;
end;

end.


