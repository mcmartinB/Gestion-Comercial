{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LiqProdAjustesFD;

interface




uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TFDLiqProdAjustes = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lblFechaIni: TLabel;
    BCBDesde: TBCalendarButton;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LProducto: TLabel;
    BGBProducto: TBGridButton;
    Label7: TLabel;
    MEDesde: TBEdit;
    STProducto: TStaticText;
    STEmpresa: TStaticText;
    EEmpresa: TBEdit;
    EProducto: TBEdit;
    lblMsg: TLabel;
    lblCentro: TLabel;
    edtCentro: TBEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    lblSemana: TLabel;
    edtSemanas: TBEdit;
    edtFin: TBEdit;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure EProductoChange(Sender: TObject);
    procedure edtSemanasChange(Sender: TObject);
    procedure MEDesdeChange(Sender: TObject);
    procedure edtCentroChange(Sender: TObject);

  private
    sEmpresa, sCentro, sProducto: string;
    dDesde, dHasta: TDatetime;

    function ParametrosOK: Boolean;
    procedure AjustarPerido;

  public
    { Public declarations }

  end;

implementation

uses CVariables, CAuxiliarDB, UDMBaseDatos, CGestionPrincipal, bSQLUtils, bTextUtils,
  UDMAuxDB, bMath, DateUtils, bDialogs,  LiqProdVendidoDM,
  LiqProdVendidoBDDatosDM, bTimeUtils, LiqProdVendidoReportsFD, LiqProdVendidoTransitosDM,
  UDMConfig;


{$R *.DFM}

procedure TFDLiqProdAjustes.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure SetFocusNil(var AFocus: TWinControl; AControl: TWinControl);
begin
  if AFocus = nil then AFocus := AControl;
end;

function TFDLiqProdAjustes.ParametrosOK: Boolean;
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
    bTextUtils.AddLine(sAux, 'El código de empresa es de obligada inserción.');
    SetFocusNil(ControlError, EEmpresa);
  end;
  if txtCentro.Caption = '' then
  begin
    bTextUtils.AddLine(sAux, 'El código del centro es de obligada inserción.');
    SetFocusNil(ControlError, edtCentro);
  end;
  if STProducto.Caption = '' then
  begin
    AddLine(sAux, 'El código de producto es de obligada inserción.');
    SetFocusNil(ControlError, EProducto);
  end;

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
    sProducto:= Trim( EProducto.Text);


    result:= True;
  end;
end;


procedure TFDLiqProdAjustes.BBAceptarClick(Sender: TObject);

begin
  if not CerrarForm(true) then
    Exit;

  if ParametrosOK then
  begin
    AjustarPerido;
  end;
end;


procedure TFDLiqProdAjustes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  FreeAndNil( DMLiqProdVendido );
  FreeAndNil( DMLiqProdVendidoBDDatos );
  Action := caFree;
end;

procedure TFDLiqProdAjustes.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;

  EEmpresa.Text := '050';
  EProducto.Text := '';
  MEDesde.Text := DateToStr(Date);
  CalendarioFlotante.Date := Date;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;


  if DMconfig.eslosllanos then
  begin
    EEmpresa.Text := '050';
    edtCentro.Text := '1';
    EProducto.Text := '';
  end
  else
  if DMconfig.eslasmoradas then
  begin
    EEmpresa.Text := '050';
    edtCentro.Text := '6';
    EProducto.Text := '';
  end
  else
  begin
    EEmpresa.Text := '050';
    edtCentro.Text := '';
    EProducto.Text := '';
  end;
  MEDesde.Text:= FormatDateTime('dd/mm/yyyy', LunesAnterior( Now - 7 ) );
  //MEDesde.Text := '27/06/2016';

  Top := 1;

  DMLiqProdVendido:= TDMLiqProdVendido.Create( Self );
  DMLiqProdVendidoBDDatos:= TDMLiqProdVendidoBDDatos.Create( Self );

  lblMsg.Caption:= '';
  lblMsg.Visible:= True;

  edtSemanas.Text:= '1';
end;

procedure TFDLiqProdAjustes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDLiqProdAjustes.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCalendar: DespliegaCalendario(BCBDesde);
  end;
end;

procedure TFDLiqProdAjustes.PonNombre(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  EProductoChange( EProducto );
  edtCentroChange( edtCentro );
end;

procedure TFDLiqProdAjustes.EProductoChange(Sender: TObject);
begin
  if EProducto.Text = '' then
    STProducto.Caption := 'TODOS LOS PRODUCTOS'
  else
    STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
end;

procedure TFDLiqProdAjustes.edtCentroChange(Sender: TObject);
begin
  if edtCentro.Text = '' then
    txtCentro.Caption := 'TODOS LOS CENTROS'
  else
    txtCentro.Caption:= desCentro(Eempresa.Text, edtCentro.Text);
end;

procedure TFDLiqProdAjustes.AjustarPerido;
var
  sMsg: string;
  bVerFacturado: boolean;
begin
  sMsg:= '';
  bVerFacturado:= False;
  DMLiqProdVendido.AjustarPerido( sEmpresa, sCentro, sProducto, dDesde, dHasta, lblMsg );
  DMLiqProdVendido.ImprimirResumenJuntos( sEmpresa, sCentro, sProducto, dDesde, dHasta, bVerFacturado );
  lblMsg.Caption:= '';
end;

procedure TFDLiqProdAjustes.edtSemanasChange(Sender: TObject);
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

procedure TFDLiqProdAjustes.MEDesdeChange(Sender: TObject);
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

end.
