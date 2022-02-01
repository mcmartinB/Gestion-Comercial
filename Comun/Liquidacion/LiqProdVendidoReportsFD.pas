{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LiqProdVendidoReportsFD;

interface




uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TFDLiqProdVendidoReports = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    SpeedButton2: TSpeedButton;
    lblFechaIni: TLabel;
    BCBDesde: TBCalendarButton;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LProducto: TLabel;
    BGBProducto: TBGridButton;
    MEDesde: TBEdit;
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
    edtSemanas: TBEdit;
    edtFin: TBEdit;
    rgTipoListado: TRadioGroup;
    rbSemanas: TRadioButton;
    rbPeriodo: TRadioButton;
    lblFEchaDesde: TLabel;
    edtFechaIni: TBEdit;
    btnFechaIni: TBCalendarButton;
    lblFechaDesde2: TLabel;
    edtFechaFin: TBEdit;
    btnFEchaFin: TBCalendarButton;
    procedure BBCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure btnPruebaClick(Sender: TObject);
    procedure edtSemanasChange(Sender: TObject);
    procedure MEDesdeChange(Sender: TObject);
    procedure rbPeriodoClick(Sender: TObject);

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
  UDMAuxDB, bMath, DateUtils, bDialogs, LiqProdVendidoDM, bTimeUtils;


{$R *.DFM}

procedure TFDLiqProdVendidoReports.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure SetFocusNil(var AFocus: TWinControl; AControl: TWinControl);
begin
  if AFocus = nil then AFocus := AControl;
end;

function TFDLiqProdVendidoReports.ParametrosOK: Boolean;
var
  sAux: string;
  ControlError: TWinControl;
  iSemanas: Integer;
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

  if rbSemanas.Checked then
  begin
    if not TryStrToDate( MEDesde.Text, dDesde )  then
    begin
      AddLine(sAux, 'La fecha de inicio es de obligada inserción.');
      SetFocusNil(ControlError, MEDesde);
    end;
    //if rbSemana.Checked then
    iSemanas:= StrToIntDef( edtSemanas.Text, 1 );
    begin
      if DayOfTheWeek( dDesde ) <> 1  then
      begin
        AddLine(sAux, 'La fecha de inicio debe ser lunes.');
        SetFocusNil(ControlError, MEDesde);
      end;
      dHasta:= dDesde + ( ( iSemanas * 7 ) - 1 );
    end;
  end
  else
  begin
    if not TryStrToDate( edtFechaIni.Text, dDesde )  then
    begin
      AddLine(sAux, 'La fecha de inicio es de obligada inserción.');
      SetFocusNil(ControlError, edtFechaIni);
    end;
    if not TryStrToDate( edtFechaFin.Text, dHasta )  then
    begin
      AddLine(sAux, 'La fecha de fin es de obligada inserción.');
      SetFocusNil(ControlError, edtFechaFin);
    end;
    if dDesde > dHasta then
    begin
      AddLine(sAux, 'La fecha de inicio no puede ser mayor que la de fin.');
      SetFocusNil(ControlError, edtFechaFin);
    end;
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
    sCentro:= Trim( edtCentro.Text);

//    eproducto.Text:= 'TOM';
    sProducto:= Trim( EProducto.Text);

    result:= True;
  end;
end;


procedure TFDLiqProdVendidoReports.btnPruebaClick(Sender: TObject);
var
  bVerFacturado: boolean;
begin
  bVerFacturado:= True;
  if not CerrarForm(true) then
    Exit;
  if ParametrosOK then
  begin
//    if chkSepararCosecheros.Checked then
//    begin
//      case rgTipoListado.ItemIndex of
//        0: DMLiqProdVendido.ImprimirResumenSeparados( sEmpresa, sCentro, sProducto, dDesde, dHasta, bVerFacturado );
//        1: DMLiqProdVendido.ImprimirCosSeparados( sEmpresa, sCentro, sProducto, dDesde, dHasta );
//        2: DMLiqProdVendido.ImprimirPlaSeparados( sEmpresa, sCentro, sProducto, dDesde, dHasta );
//      end;
//    end
//    else
//    begin
    case rgTipoListado.ItemIndex of
        0: DMLiqProdVendido.ImprimirResumenJuntos ( sEmpresa, sCentro, sProducto, dDesde, dHasta , bVerFacturado);
        1: DMLiqProdVendido.ImprimirCosJuntos( sEmpresa, sCentro, sProducto, dDesde, dHasta );
        2: DMLiqProdVendido.ImprimirPlaJuntos( sEmpresa, sCentro, sProducto, dDesde, dHasta );
//      end;
    end;
  end;
end;



procedure TFDLiqProdVendidoReports.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  FreeAndNil( DMLiqProdVendido );
  Action := caFree;
end;

procedure TFDLiqProdVendidoReports.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  edtFechaIni.Tag := kCalendar;
  edtFechaFin.Tag := kCalendar;

  EEmpresa.Text := '050';
  edtCentro.Text := '1';
  EProducto.Text := 'TOM';

  CalendarioFlotante.Date := Date;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;


  MEDesde.Text:= FormatDateTime('dd/mm/yyyy', LunesAnterior( Now - 7 ) );
  edtFechaIni.Text:= MEDesde.Text;
  edtFechaFin.Text:= FormatDateTime('dd/mm/yyyy', LunesAnterior( Now - 7 ) + 6 );;
  edtSemanas.Text:= '1';

  DMLiqProdVendido:= TDMLiqProdVendido.Create( Self );
end;

procedure TFDLiqProdVendidoReports.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDLiqProdVendidoReports.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCalendar:
    begin
      if MEDesde.Focused then
        DespliegaCalendario(BCBDesde)
      else
      if edtFechaIni.focused then
        DespliegaCalendario(btnFechaIni)
      else
      if edtFechaFin.focused then
        DespliegaCalendario(btnFEchaFin);
    end;
  end;
end;

procedure TFDLiqProdVendidoReports.PonNombre(Sender: TObject);
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


procedure TFDLiqProdVendidoReports.PonDesProducto;
begin
  if EProducto.Text = '' then
    STProducto.Caption := 'TODOS LOS PRODUCTOS.'
  else
    STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
end;

procedure TFDLiqProdVendidoReports.PonDesCentro;
begin
  if edtCentro.Text = '' then
    txtCentro.Caption := 'TODOS LOS CENTROS.'
  else
    txtCentro.Caption:= desCentro(Eempresa.Text, edtCentro.Text);
end;

procedure TFDLiqProdVendidoReports.edtSemanasChange(Sender: TObject);
var
  iSemanas: Integer;
  dAux: TDateTime;
begin
  iSemanas:= StrToIntDef( edtSemanas.Text, 1 );
  if TryStrToDate( MEDesde.Text, dAux ) then
  begin
    dAux:= dAux + ( ( 7 * iSemanas ) - 1 );
    edtFin.Text:= FormatDateTime('dd/mm/yyyy', dAux );
  end
  else
  begin
    edtFin.Text:= '';
  end;
end;

procedure TFDLiqProdVendidoReports.MEDesdeChange(Sender: TObject);
var
  dAux: TDateTime;
begin
  edtSemanasChange( edtSemanas );
  if TryStrToDate( MEDesde.Text, dAux ) then
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

procedure TFDLiqProdVendidoReports.rbPeriodoClick(Sender: TObject);
begin
  MEDesde.Enabled:= rbSemanas.Checked;
  BCBDesde.Enabled:= rbSemanas.Checked;
  edtSemanas.Enabled:= rbSemanas.Checked;
  edtFechaIni.Enabled:= rbPeriodo.Checked;
  btnFechaIni.Enabled:= rbPeriodo.Checked;
  edtFechaFin.Enabled:= rbPeriodo.Checked;
  btnFEchaFin.Enabled:= rbPeriodo.Checked;
end;

end.

