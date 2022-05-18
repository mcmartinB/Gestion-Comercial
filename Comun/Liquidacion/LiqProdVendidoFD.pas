{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LiqProdVendidoFD;

interface




uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TFDLiqProdVendido = class(TForm)
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
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    lbl1: TLabel;
    MEDesde: TBEdit;
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
    lblCentro: TLabel;
    edtCentro: TBEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    lblSemana: TLabel;
    edtSemanas: TBEdit;
    edtFin: TBEdit;
    btnALiqudar: TSpeedButton;
    chkUsarPresupuesto: TCheckBox;
    cbxLiquidaDefinitiva: TCheckBox;
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
    procedure edtSemanasChange(Sender: TObject);
    procedure MEDesdeChange(Sender: TObject);
    procedure btnALiqudarClick(Sender: TObject);
    procedure edtCentroChange(Sender: TObject);

  private
    sEmpresa, sCentro, sProducto: string;
    dDesde, dHasta: TDatetime;
    rComercial, rProduccion, rAdministrativo: Real;
    bPresupuesto, bDefinitiva: Boolean;

    function ParametrosOK: Boolean;
    procedure LiquidarPerido;

  public
    { Public declarations }

  end;

implementation

uses CVariables, CAuxiliarDB, UDMBaseDatos, CGestionPrincipal, bSQLUtils, bTextUtils,
  UDMAuxDB, bMath, DateUtils, bDialogs, LiqProdVendidoControlDM, LiqProdVendidoDM,
  LiqProdVendidoBDDatosDM, bTimeUtils, LiqProdVendidoReportsFD, LiqProdVendidoTransitosDM,
  UDMConfig, LiqProdErroresUnit;


{$R *.DFM}

procedure TFDLiqProdVendido.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure SetFocusNil(var AFocus: TWinControl; AControl: TWinControl);
begin
  if AFocus = nil then AFocus := AControl;
end;

function TFDLiqProdVendido.ParametrosOK: Boolean;
var
  sAux: string;
  ControlError: TWinControl;
  //bFechasCorrectas: Boolean;
  //iYear, iMonth, iDay: Word;
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
  (*
  else
  begin
    DecodeDate( dDesde, iYear, iMonth, iDay );
    if iDay <> 1 then
    begin
      AddLine(sAux, 'La fecha de inicio debe ser el primer dia del mes.');
      SetFocusNil(ControlError, MEDesde);
      bFechasCorrectas := false;
    end;
    dHasta:= dDesde + DaysInAMonth( iYear, iMonth ) -1;
  end;
  *)

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


    rComercial:= StrToFloatDef( ECosteComercial.Text, 0);
    rProduccion:= StrToFloatDef( ECosteProduccion.Text, 0);
    rAdministrativo:= StrToFloatDef( ECosteAdministrativo.Text, 0);

    bDefinitiva:= cbxLiquidaDefinitiva.Checked;
    bPresupuesto:= chkUsarPresupuesto.Checked;

    result:= True;
  end;
end;


procedure TFDLiqProdVendido.BBAceptarClick(Sender: TObject);

begin
  if not CerrarForm(true) then
    Exit;

  if ParametrosOK then
  begin
    LiquidarPerido;
  end;
end;


procedure TFDLiqProdVendido.btnPruebaClick(Sender: TObject);
//var
  //FDLiqProdVendidoReports: TFDLiqProdVendidoReports;
begin
  if not CerrarForm(true) then
    Exit;
  if ( DMLiqProdVendidoTransitos <> nil ) and ( ParametrosOK )  then
  begin
    DMLiqProdVendidoTransitos.AjustarTransitos( sEmpresa, sProducto, dDesde, dHasta );
    ShowMessage('Proceso finalizado.')
  end;
  (*
  if ParametrosOK then
  begin
    Application.CreateForm( TFDLiqProdVendidoReports, FDLiqProdVendidoReports);
    try
      FDLiqProdVendidoReports.EEmpresa.Text:= EEmpresa.Text;
      FDLiqProdVendidoReports.EProducto.Text:= EProducto.Text;
      FDLiqProdVendidoReports.edtCentro.Text:= edtCentro.Text;
      FDLiqProdVendidoReports.edtFechaIni.Text:= MEDesde.Text;
      FDLiqProdVendidoReports.edtFechaFin.Text:= edtFin.Text;
    finally
      FreeAndNil(FDLiqProdVendidoReports);
    end;
  end;
  *)
end;



procedure TFDLiqProdVendido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  FreeAndNil( DMLiqProdVendidoControl );
  FreeAndNil( DMLiqProdVendido );
  FreeAndNil( DMLiqProdVendidoBDDatos );
  Action := caFree;
end;

procedure TFDLiqProdVendido.FormCreate(Sender: TObject);
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

  (*ANTERIOR
  ECosteComercial.Text:= '0,013';
  ECosteProduccion.Text:= '0,008';
  ECosteAdministrativo.Text:= '0,027';
  * ANTERIOR a 01/07/2018
  ECosteComercial.Text:= '0,014';
  ECosteProduccion.Text:= '0,010';
  ECosteAdministrativo.Text:= '0,050';
  * ANTERIOR A 01/01/2022
  ECosteComercial.Text:= '0,008';
  ECosteProduccion.Text:= '0,025';
  ECosteAdministrativo.Text:= '0,067';
  *)

  ECosteComercial.Text:= '0,008';
  ECosteProduccion.Text:= '0,039';
  ECosteAdministrativo.Text:= '0,111';

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
  DMLiqProdVendidoControl:= TDMLiqProdVendidoControl.Create( Self );
  DMLiqProdVendidoBDDatos:= TDMLiqProdVendidoBDDatos.Create( Self );

  lblMsg.Caption:= '';
  lblMsg.Visible:= True;

  edtSemanas.Text:= '1';
end;

procedure TFDLiqProdVendido.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDLiqProdVendido.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [EEmpresa.Text]);
    kCalendar: DespliegaCalendario(BCBDesde);
  end;
end;

procedure TFDLiqProdVendido.PonNombre(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  EProductoChange( EProducto );
  edtCentroChange( edtCentro );
end;

procedure TFDLiqProdVendido.EProductoChange(Sender: TObject);
begin
  if EProducto.Text = '' then
    STProducto.Caption := 'TODOS LOS PRODUCTOS'
  else
    STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
end;

procedure TFDLiqProdVendido.edtCentroChange(Sender: TObject);
begin
  if edtCentro.Text = '' then
    txtCentro.Caption := 'TODOS LOS CENTROS'
  else
    txtCentro.Caption:= desCentro(Eempresa.Text, edtCentro.Text);
end;

procedure TFDLiqProdVendido.LiquidarPerido;
var
  sMsg: string;
  dIni, dFin: TDatetime;
  iMinutos, iSegundos: integer;
  bVerFacturado: boolean;
begin
  bVerFacturado:= True;

  sMsg:= '';
  if DMLiqProdVendidoControl.VerificarPeriodo( sEmpresa, sCentro, sProducto, dDesde, dHasta,
                                   rComercial, rProduccion, rAdministrativo, bDefinitiva, sMsg ) then
  begin
    dIni:= now;
    DMLiqProdVendido.LiquidarPerido( sEmpresa, sCentro, sProducto, dDesde, dHasta,
                                   rComercial, rProduccion, rAdministrativo, bPresupuesto, bDefinitiva, lblMsg );
    dFin:= now;

    iMinutos:= MinutesBetween(dFin, dIni);
    iSegundos:= SecondsBetween(dFin, dIni) mod 60;

    ShowMessage( 'INICIO-> ' + FormatDateTime('hh:nn:ss', dIni ) + ' - FIN->: ' + FormatDateTime('hh:nn:ss', dFin ) + ' -> TIEMPO-> ' + IntToStr( iMinutos ) + ':' + IntToStr( iSegundos )  );
    LiqProdErroresUnit.ImprimirErrores( sEmpresa, sCentro, sProducto, dDesde, dHasta );
    DMLiqProdVendido.ImprimirResumenJuntos( sEmpresa, sCentro, sProducto, dDesde, dHasta, bVerFacturado );
  end
  else
  begin
    ShowError( sMsg );
  end;

  lblMsg.Caption:= '';
end;

procedure TFDLiqProdVendido.edtSemanasChange(Sender: TObject);
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

procedure TFDLiqProdVendido.MEDesdeChange(Sender: TObject);
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

procedure TFDLiqProdVendido.btnALiqudarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;
  if ParametrosOK then
  begin
    DMLiqProdVendido.ImprimirALiquidar( sEmpresa, sCentro, sProducto, dDesde, dHasta );
  end;
end;

end.
