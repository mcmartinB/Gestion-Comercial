{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LiqProdLiquidacionFD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TFDLiqProdLiquidacion = class(TForm)
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
    rbMeses: TRadioButton;
    rbSemanas: TRadioButton;
    Label1: TLabel;
    edtSemanaIni: TBEdit;
    btnSemana: TBCalendarButton;
    Label2: TLabel;
    edtSemanas: TBEdit;
    edtSemanaFin: TBEdit;
    rbRango: TRadioButton;
    lblRangoIni: TLabel;
    edtRangoIni: TBEdit;
    btnRangoIni: TBCalendarButton;
    Label4: TLabel;
    edtRangoFin: TBEdit;
    btnRangoFin: TBCalendarButton;
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
    procedure PeriodoClick(Sender: TObject);
    procedure edtSemanasChange(Sender: TObject);
    procedure edtSemanaIniChange(Sender: TObject);
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
  UDMAuxDB, bMath, DateUtils, bDialogs, LiqProdLiquidacionDM, bTimeUtils;


{$R *.DFM}

procedure TFDLiqProdLiquidacion.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure SetFocusNil(var AFocus: TWinControl; AControl: TWinControl);
begin
  if AFocus = nil then AFocus := AControl;
end;

function TFDLiqProdLiquidacion.ParametrosOK: Boolean;
var
  sAux: string;
  ControlError: TWinControl;
  iMeses, iSemanas: Integer;
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


  if rbMeses.Checked then
  begin
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
  end
  else
  if rbSemanas.Checked then
  begin
    if not TryStrToDate( edtSemanaIni.Text, dDesde )  then
    begin
      AddLine(sAux, 'La fecha de inicio es de obligada inserción.');
      SetFocusNil(ControlError, edtSemanaIni);
    end;
    //if rbSemana.Checked then
    iSemanas:= StrToIntDef( edtSemanas.Text, 1 );
    begin
      if DayOfTheWeek( dDesde ) <> 1  then
      begin
        AddLine(sAux, 'La fecha de inicio debe ser lunes.');
        SetFocusNil(ControlError, edtSemanaIni);
      end;
      dHasta:= dDesde + ( ( iSemanas * 7 ) - 1 );
    end;
  end
  else
  begin
    if not TryStrToDate( edtrangoIni.Text, dDesde )  then
    begin
      AddLine(sAux, 'La fecha de inicio es de obligada inserción.');
      SetFocusNil(ControlError, edtrangoIni);
    end;
    if not TryStrToDate( edtrangofin.Text, dHasta )  then
    begin
      AddLine(sAux, 'La fecha de fin es de obligada inserción.');
      SetFocusNil(ControlError, edtRangoFin);
    end;
    if dDesde > dHasta then
    begin
      AddLine(sAux, 'El rango de fechas es incorrecto.');
      SetFocusNil(ControlError, edtrangoIni);
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

    if ( eempresa.Text = '050' ) and ( eproducto.Text = 'TOM' ) then
    begin
      eproducto.Text:= 'TOM'
    end;
    sProducto:= Trim( EProducto.Text);

    result:= True;
  end;
end;


procedure TFDLiqProdLiquidacion.btnPruebaClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;
  if ParametrosOK then
  begin
    if rbMeses.checked then
    begin
      case rgTipoListado.ItemIndex of
        0: DMLiqProdLiquidacion.InformeLiquidacionResumen( sEmpresa, sCentro, sProducto, dDesde, dHasta );
        1: DMLiqProdLiquidacion.InformeLiquidacionCategoria( sEmpresa, sCentro, sProducto, dDesde, dHasta );
      end;
    end
    else
    begin
      DMLiqProdLiquidacion.InformeLiquidacionSemanas( sEmpresa, sCentro, sProducto, dDesde, dHasta );
    end;
  end;
end;



procedure TFDLiqProdLiquidacion.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  FreeAndNil( DMLiqProdLiquidacion );
  Action := caFree;
end;

procedure TFDLiqProdLiquidacion.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  edtFechaIni.Tag := kCalendar;
  edtFechaFin.Tag := kCalendar;
  edtSemanaIni.Tag := kCalendar;
  edtSemanaFin.Tag := kCalendar;

  EEmpresa.Text := '050';
  edtCentro.Text := '1';
  EProducto.Text := 'TOM';

  CalendarioFlotante.Date := Date;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;


  edtRangoIni.Text:= FormatDateTime('dd/mm/yyyy', Now  );
  edtRangoFin.Text:= FormatDateTime('dd/mm/yyyy', Now  );
  edtFechaIni.Text:= FormatDateTime('dd/mm/yyyy', Now  );
  edtMeses.Text:= '1';
  edtSemanaIni.Text:= FormatDateTime('dd/mm/yyyy', Now  );
  edtSemanas.Text:= '1';

  DMLiqProdLiquidacion:= TDMLiqProdLiquidacion.Create( Self );
end;

procedure TFDLiqProdLiquidacion.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDLiqProdLiquidacion.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCalendar:
    begin
      if edtfechaini.Focused then
        DespliegaCalendario(btnMes)
      else
      if edtsemanaini.Focused then
        DespliegaCalendario(btnSemana);
    end;
  end;
end;

procedure TFDLiqProdLiquidacion.PonNombre(Sender: TObject);
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


procedure TFDLiqProdLiquidacion.PonDesProducto;
begin
  if EProducto.Text = '' then
    STProducto.Caption := 'TODOS LOS PRODUCTOS.'
  else
    STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
end;

procedure TFDLiqProdLiquidacion.PonDesCentro;
begin
  if edtCentro.Text = '' then
    txtCentro.Caption := 'TODOS LOS CENTROS.'
  else
    txtCentro.Caption:= desCentro(Eempresa.Text, edtCentro.Text);
end;

procedure TFDLiqProdLiquidacion.edtMesesChange(Sender: TObject);
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

procedure TFDLiqProdLiquidacion.edtFechaIniChange(Sender: TObject);
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

procedure TFDLiqProdLiquidacion.edtSemanasChange(Sender: TObject);
var
  iSemanas: Integer;
  dAux: TDateTime;
begin
  iSemanas:= StrToIntDef( edtSemanas.Text, 1 );
  if TryStrToDate( edtSemanaIni.Text, dAux ) then
  begin
    dAux:= dAux + ( ( 7 * iSemanas ) - 1 );
    edtSemanaFin.Text:= FormatDateTime('dd/mm/yyyy', dAux );
  end
  else
  begin
    edtSemanaFin.Text:= '';
  end;
end;

procedure TFDLiqProdLiquidacion.edtSemanaIniChange(Sender: TObject);
begin
  edtSemanasChange(edtSemanas);
end;

procedure TFDLiqProdLiquidacion.PeriodoClick(Sender: TObject);
begin
  edtSemanaIni.Enabled:= rbSemanas.Checked;
  btnSemana.Enabled:= rbSemanas.Checked;
  //edtSemanaFin.Enabled:= rbSemanas.Checked;
  edtSemanas.Enabled:= rbSemanas.Checked;

  edtFechaIni.Enabled:= rbMeses.Checked;
  btnMes.Enabled:= rbMeses.Checked;
  //edtFechaFin.Enabled:= rbMeses.Checked;
  //edtMeses.Enabled:= rbMeses.Checked;
  rgTipoListado.Enabled:= rbMeses.Checked;

  edtrangoIni.Enabled:= rbrango.checked;
  edtrangoFin.Enabled:= rbrango.checked;
  btnrangoIni.Enabled:= rbrango.checked;
  btnrangoFin.Enabled:= rbrango.checked;
end;

procedure TFDLiqProdLiquidacion.btn1Click(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;
  if ParametrosOK then
  begin
    DMLiqProdLiquidacion.InformeLiquidacionPosei( sEmpresa, sCentro, sProducto, dDesde, dHasta );
  end;
end;

end.


