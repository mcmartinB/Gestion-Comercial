{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LiquidacionEscandallosFD;

interface




uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TFDLiquidacionEscandallos = class(TForm)
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
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
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
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label4: TLabel;
    ECosteProduccion: TBEdit;
    ECosteAdministrativo: TBEdit;
    Label3: TLabel;
    ECosteComercial: TBEdit;
    Label6: TLabel;
    ECosechero: TBEdit;
    Label7: TLabel;
    cbxAbonos: TCheckBox;
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

  public
    { Public declarations }
  private
    sEmpresa, sCentro, sProducto, sCosechero: string;
    dIni, dFin: TDateTime;
    rCosteComercial, rCosteProduccion, rCosteAdministracion: Real;
    bAbonos, bDefinitiva: Boolean;

    procedure Previsualizar;
    procedure EstadoFormSegunProducto(const AProducto: string);
    function ParametrosOK: Boolean;

  public
  end;

implementation

uses
  UnitCodeLiquidacion, LiquidacionEscandallosDM, LiquidacionEscandallosAuxDM,
  CVariables, CAuxiliarDB, UDMBaseDatos, CGestionPrincipal, bSQLUtils,
  UDMAuxDB, bMath, DateUtils, bDialogs, ULiquidacionEscandallo, TablaTmpFob;


{$R *.DFM}

procedure TFDLiquidacionEscandallos.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;


function EstaGastoTransitoAsignado(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_c, frf_transitos_l ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc between :fechaini and :fechafin ');
    SQL.Add(' and status_gastos_tc = ''N'' ');
    SQL.Add(' and empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :centro ');
    SQL.Add(' and fecha_tl = fecha_tc ');
    SQL.Add(' and referencia_tl = referencia_tc ');
    SQL.Add(' and producto_tl = :producto ');
    ParamByname('empresa').AsString := AEmpresa;
    ParamByname('centro').AsString := ACentro;
    ParamByname('producto').AsString := AProducto;
    ParamByname('fechaini').AsDate := AFechaIni;
    ParamByname('fechafin').AsDate := AFechaFin;
    Open;
    result:= IsEmpty;
    Close;
  end;
end;

function TFDLiquidacionEscandallos.ParametrosOK: Boolean;
var
  aux, sAux: string;
  fechasCorrectas: boolean;
  ControlError: TWinControl;
begin
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

  sEmpresa:= EEmpresa.Text;
  sCentro:= ECentro.Text;
  sProducto:= EProducto.Text;
  sCosechero:= ECosechero.Text;

  fechasCorrectas := true;
  if not TryStrToDate( MEDesde.Text, dIni ) then
  begin
    AddLine(aux, 'La fecha de inicio es de obligada inserción y debe ser lunes.');
    SetFocusNil(ControlError, MEDesde);
    fechasCorrectas := false;
  end
  else
  begin
    //Debe ser lunes
    if DayOfTheWeek(dIni) <> 1 then
    begin
      AddLine(aux, 'El dia de inicio debe ser lunes.');
      SetFocusNil(ControlError, MEDesde);
      fechasCorrectas := false;
    end;
  end;
  if not TryStrToDate( MEHasta.Text, dFin ) then
  begin
    AddLine(aux, 'La fecha de fin es de obligada inserción y debe ser domingo.');
    SetFocusNil(ControlError, MEHasta);
    fechasCorrectas := false;
  end
  else
  begin
    //Debe ser domingo
    if DayOfTheWeek( dFin) <> 7 then
    begin
      AddLine(aux, 'El dia de fin debe ser domingo.');
      SetFocusNil(ControlError, MEHasta);
      fechasCorrectas := false;
    end;
  end;
  //Rango correcto
  if fechasCorrectas  then
  begin
    if (dFin < dIni) then
    begin
      AddLine(aux, 'La fecha de inicio debe ser menor que la de fin.');
      SetFocusNil(ControlError, MEDesde);
    end;
  end;

  if Trim(Aux) <> '' then
  begin
    ShowError(Aux);
    ActiveControl := ControlError;
    Exit;
  end;

  rCosteComercial:= StrToFloatDef( ECosteComercial.Text, 0 );
  rCosteProduccion:= StrToFloatDef( ECosteProduccion.Text, 0 );
  rCosteAdministracion:= StrToFloatDef( ECosteAdministrativo.Text, 0 );

  bAbonos:= cbxAbonos.Checked;
  bDefinitiva:= cbxLiquidaDefinitiva.Checked;
end;

procedure TFDLiquidacionEscandallos.BBAceptarClick(Sender: TObject);
var
  sAux: string;
begin
  if not CerrarForm(true) then
    Exit;

  if ParametrosOK then
  begin

  end;
  //Que todos los costes de envasado esten grabados
  //MAS TRABAJO COMUN ????

  {
  try
    if not (EstaGastoEnvasadoGrabado(EEmpresa.Text, ECentro.Text, EProducto.Text,
      StrToDate(MEDesde.Text), StrToDate(MEHasta.Text), sAux) or
      Preguntar('Falta grabar el coste de algun envase para el mes en curso. ¿Seguro que desea continuar?' + #13 + #10 +
                '(Si continua se utilizara el coste del envase de meses anteriores.)' )) then (*+ #13 + #10 +
                'Centro/Envase/mes:  (' + sAux + ')' )) then  *)
    begin
      Exit;
    end;
  except
    on e: exception do
    begin
      ShowMessage(e.Message);
      Exit;
    end;
  end;
  }

  //Que los gastos de los tansitos esten grabados
  if not EstaGastoTransitoAsignado(EEmpresa.Text, ECentro.Text, EProducto.Text, StrToDate(MEDesde.Text), StrToDate(MEHasta.Text)) then
  begin
    if cbxLiquidaDefinitiva.Checked then
    begin
      ShowMessage('No se puede sacar la liquidación definitiva si no estan asignados los gastos de los tránsitos.');
    end
    else
    begin
      if Preguntar('Faltan por asignar los gastos de los transitos. ¿Seguro que desea continuar?' ) then
        Previsualizar;
    end;
  end
  else
  begin
    Previsualizar;
  end;
end;


procedure TFDLiquidacionEscandallos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  TablaTmpFob.BorrarDatosActuales( gsCodigo );

  Action := caFree;
end;

procedure TFDLiquidacionEscandallos.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  EEmpresa.Text := gsDefEmpresa;
  ECentro.Text := gsDefCentro;
  EProducto.Text := gsDefProducto;
  MEDesde.Text := DateToStr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  Top := 1;
  EstadoFormSegunProducto(EProducto.Text);
end;

procedure TFDLiquidacionEscandallos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDLiquidacionEscandallos.ADesplegarRejillaExecute(Sender: TObject);
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

procedure TFDLiquidacionEscandallos.PonNombre(Sender: TObject);
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
      end;
    kProducto: STProducto.Caption := desProducto(Eempresa.Text, Eproducto.Text);
    kCentro: STCentro.Caption := desCentro(Eempresa.Text, Ecentro.Text);
  end;
end;

procedure TFDLiquidacionEscandallos.Previsualizar;
begin
  ULiquidacionEscandallo.LiquidacionPorEscandallo(EEmpresa.Text, ECentro.Text, EProducto.Text, ECosechero.Text,
            MEDesde.Text, MEHasta.Text, ECosteComercial.Text, ECosteProduccion.Text,
            ECosteAdministrativo.Text, cbxAbonos.Checked, cbxLiquidaDefinitiva.Checked );
end;

procedure TFDLiquidacionEscandallos.EProductoChange(Sender: TObject);
begin
  PonNombre(Sender);
  EstadoFormSegunProducto(TEdit(Sender).Text);
end;


procedure TFDLiquidacionEscandallos.EstadoFormSegunProducto(const AProducto: string);
begin
(*
  //Temporal
  if AProducto = '' then
  begin
    ECosechero.Text:= '';
    ECosechero.Enabled:= False;
    cbxAjustarFob.Checked:= false;
    cbxAjustarFob.Enabled:= false;
    Caption:= '    LIQUIDACIÓN A COSECHEROS ';
  end
  else
  if AProducto = 'E' then
  begin
    //Tenerife
    ECosechero.Text:= '';
    ECosechero.Enabled:= False;
    cbxAjustarFob.Checked:= false;
    cbxAjustarFob.Enabled:= false;
    Caption:= '    LIQUIDACIÓN A COSECHEROS (TENERIFE)';
  end
  else
  if ( AProducto = 'T' ) or ( AProducto = 'Q' ) then
  begin
    //Escandallo
    ECosechero.Text:= '';
    ECosechero.Enabled:= true;
    cbxAjustarFob.Checked:= true;
    cbxAjustarFob.Enabled:= true;
    Caption:= '    LIQUIDACIÓN A COSECHEROS (ESCANDALLO)';
  end
  else
  begin
    //Salidas
    ECosechero.Text:= '';
    ECosechero.Enabled:= true;
    cbxAjustarFob.Checked:= true;
    cbxAjustarFob.Enabled:= true;
    Caption:= '    LIQUIDACIÓN A COSECHEROS (SALIDAS)';
  end;
*)
end;

end.
