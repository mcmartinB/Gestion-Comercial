{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LLiquidaFrutaEntrada;

interface




uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TFLLiquidaFrutaEntrada = class(TForm)
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
    STCentro: TStaticText;
    STProducto: TStaticText;
    STEmpresa: TStaticText;
    EEmpresa: TBEdit;
    ECentro: TBEdit;
    EProducto: TBEdit;
    cbxLiquidaDefinitiva: TCheckBox;
    Label1: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    ECosteComercial: TBEdit;
    ECosteProduccion: TBEdit;
    ECosteAdministrativo: TBEdit;
    lbl1: TLabel;
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
    function ParametrosOK: Boolean;
    procedure LiquidarPerido;

    procedure Previsualizar;

    procedure EstadoFormSegunProducto(const AProducto: string);

  public
  end;

implementation

uses CVariables, CAuxiliarDB, UDMBaseDatos, CGestionPrincipal, bSQLUtils,
  UDMAuxDB, bMath, DateUtils, bDialogs, ULiquidaCosecheroPeriodo, TablaTmpFob;


{$R *.DFM}

procedure TFLLiquidaFrutaEntrada.BBCancelarClick(Sender: TObject);
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


function HayEntradas(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDateTime): boolean;
begin
  //result := true;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from   frf_entradas_c ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_ec = :centro ');
    SQL.Add(' and producto_ec = :producto ');
    SQL.Add(' and fecha_ec between :fechaini and :fechafin ');
    ParamByname('empresa').AsString := AEmpresa;
    ParamByname('centro').AsString := ACentro;
    ParamByname('producto').AsString := AProducto;
    ParamByname('fechaini').AsDate := AFechaIni;
    ParamByname('fechafin').AsDate := AFechaFin;
    Open;
    Result:= not IsEmpty;
    Close;
  end;
end;

function EstaGastoEnvasadoGrabado(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDateTime; var AMsg: string): boolean;
var
  sEnvase: string;
  iDia, iMes, iAnyo: word;
begin
  AMsg:= '';
  //result := true;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('  select distinct centro_salida_sl, producto_base_p, envase_sl, min(fecha_sl) fecha');
    SQL.Add('  from   frf_salidas_l, frf_productos ');
    SQL.Add('  where empresa_sl  =  :empresa ');
    SQL.Add('  and centro_origen_sl  =  :centro ');
    SQL.Add('  and fecha_sl between :fechaini and :fechafin ');
    SQL.Add('  and producto_sl = :producto ');
    SQL.Add('  and empresa_p  =  :empresa ');
    SQL.Add('  and producto_p = producto_sl ');
    SQL.Add('  and not exists ');
    SQL.Add(' ( ');
    SQL.Add('          select ( material_ec + coste_ec ) coste_ec ');
    SQL.Add('          from frf_env_costes ');
    SQL.Add('          where empresa_ec  =  :empresa ');
    SQL.Add('          and centro_ec  =  centro_salida_sl ');
    SQL.Add('          and producto_base_ec = producto_base_p ');
    SQL.Add('          and envase_ec = envase_sl ');
    SQL.Add(' ) ');
    SQL.Add('  group by 1,2,3 ');
    SQL.Add('  order by 1,2,3 ');
    ParamByname('empresa').AsString := AEmpresa;
    ParamByname('centro').AsString := ACentro;
    ParamByname('producto').AsString := AProducto;
    ParamByname('fechaini').AsDate := AFechaIni;
    ParamByname('fechafin').AsDate := AFechaFin;

    if OpenQuery(DMAuxDB.QAux) then
    begin
      sEnvase := '';
      if not isEmpty then
      begin
        DecodeDate( Fields[3].AsDateTime, iDia, iMes, iAnyo );
        sEnvase := '''' + Fields[0].AsString + '/' + Fields[2].AsString + '/' + IntToStr(iMes) + '''';
        Next;
        while not Eof do
        begin
          DecodeDate( Fields[3].AsDateTime, iDia, iMes, iAnyo );
          sEnvase := sEnvase + ',''' + Fields[0].AsString + '/' + Fields[2].AsString + '/' + IntToStr(iMes) + '''';
          Next;
        end;
      end;
      Close;
      if sEnvase <> '' then
        raise Exception.Create('No existe ningún precio para el centro/envase/mes:  (' + sEnvase + ')');
    end;

    SQL.Clear;
    SQL.Add('  select distinct centro_salida_sl, producto_base_p, envase_sl, MONTH(fecha_sl) mes ');
    SQL.Add('  from   frf_salidas_l, frf_productos ');
    SQL.Add('  where empresa_sl  =  :empresa ');
    SQL.Add('  and centro_origen_sl  =  :centro ');
    SQL.Add('  and fecha_sl between :fechaini and :fechafin ');
    SQL.Add('  and producto_sl = :producto ');
    SQL.Add('  and empresa_p  =  :empresa ');
    SQL.Add('  and producto_p = producto_sl ');
    SQL.Add('  and not exists ');
    SQL.Add(' ( ');
    SQL.Add('          select ( material_ec + coste_ec ) coste_ec ');
    SQL.Add('          from frf_env_costes ');
    SQL.Add('          where anyo_ec  =  YEAR(fecha_sl) ');
    SQL.Add('          and mes_ec  =  MONTH(fecha_sl) ');
    SQL.Add('          and empresa_ec  =  :empresa ');
    SQL.Add('          and centro_ec  =  centro_salida_sl ');
    SQL.Add('          and producto_base_ec = producto_base_p ');
    SQL.Add('          and envase_ec = envase_sl ');
    SQL.Add(' ) ');
    SQL.Add('  order by 1,2,3,4 ');
    ParamByname('empresa').AsString := AEmpresa;
    ParamByname('centro').AsString := ACentro;
    ParamByname('producto').AsString := AProducto;
    ParamByname('fechaini').AsDate := AFechaIni;
    ParamByname('fechafin').AsDate := AFechaFin;

    if OpenQuery(DMAuxDB.QAux) then
    begin
      sEnvase := '';
      if not isEmpty then
      begin
        sEnvase := '''' + Fields[0].AsString + '/' + Fields[2].AsString + '/' + Fields[3].AsString + '''';
        Next;
        while not Eof do
        begin
          sEnvase := sEnvase + ',''' + Fields[0].AsString + '/' + Fields[2].AsString + '/' + Fields[3].AsString + '''';
          Next;
        end;
        result := false;
        AMsg:= sEnvase;
      end
      else
      begin
        result := True;
      end;
      Close;
    end
    else
    begin
      result := false;
    end;
  end;
end;

procedure TFLLiquidaFrutaEntrada.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ParametrosOK then
  begin
    LiquidarPerido;
  end;
end;

function TFLLiquidaFrutaEntrada.ParametrosOK: Boolean;
var
  sAux: string;
  ControlError: TWinControl;
  bFechasCorrectas: Boolean;
  dDesde, dHasta: TDateTime;
begin
  sAux := '';
  ControlError := nil;
  //Comprobar si los campos se han rellenado correctamente
  if STEmpresa.Caption = '' then
  begin
    AddLine(sAux, 'El código de empresa es de obligada inserción.');
    SetFocusNil(ControlError, EEmpresa);
  end;
  if STCentro.Caption = '' then
  begin
    AddLine(sAux, 'El código de centro es de obligada inserción.');
    SetFocusNil(ControlError, ECentro);
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
    (*
    if rbSinEscandallo.Checked then
      iTipoLiquida:= 0
    else
    if rbConEscandallo.Checked then
      iTipoLiquida:= 1
    else
      iTipoLiquida:= 2;


    sEmpresa:= Trim( EEmpresa.Text);
    sCentro:= Trim( ECentro.Text);
    sProducto:= Trim( EProducto.Text);
    sCosechero:= '';


    rComercial:= StrToFloatDef( ECosteComercial.Text, 0);
    rProduccion:= StrToFloatDef( ECosteProduccion.Text, 0);
    rAdministrativo:= StrToFloatDef( ECosteAdministrativo.Text, 0);

    bDefinitiva:= cbxLiquidaDefinitiva.Checked;
    *)

    result:= True;
  end;
end;

procedure TFLLiquidaFrutaEntrada.LiquidarPerido;
begin

end;

{
var
  aux, sAux: string;
  dIni, dFin: TDateTime;
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

  if not TryStrToDate( MEDesde.Text, dIni ) then
  begin
    AddLine(aux, 'La fecha de inicio es de obligada inserción.');
    SetFocusNil(ControlError, MEDesde);
  end;
  if not TryStrToDate( MEHasta.Text, dFin ) then
  begin
    AddLine(aux, 'La fecha de fin es de obligada inserción.');
    SetFocusNil(ControlError, MEHasta);
  end;
     //Rango correcto
  if dIni > dFin then
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

  if ECosteComercial.Text = '' then
  begin
    ECosteComercial.Text := '0';
  end;
  if ECosteAdministrativo.Text = '' then
  begin
    ECosteAdministrativo.Text := '0';
  end;
  if ECosteProduccion.Text = '' then
  begin
    ECosteProduccion.Text := '0';
  end;


  if not HayEntradas (EEmpresa.Text, ECentro.Text, EProducto.Text,
      StrToDate(MEDesde.Text), StrToDate(MEHasta.Text) ) then
  begin
    ShowMessage('No hay entradas para los parametros seleccionados.');
    Exit;
  end;


  //Que todos los costes de envasado esten grabados
  //MAS TRABAJO COMUN ????
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

  //Que los gastos de los transitos esten grabados
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
}


procedure TFLLiquidaFrutaEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  TablaTmpFob.BorrarDatosActuales( gsCodigo );

  Action := caFree;
end;

procedure TFLLiquidaFrutaEntrada.FormCreate(Sender: TObject);
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

procedure TFLLiquidaFrutaEntrada.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLLiquidaFrutaEntrada.ADesplegarRejillaExecute(Sender: TObject);
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

procedure TFLLiquidaFrutaEntrada.PonNombre(Sender: TObject);
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

procedure TFLLiquidaFrutaEntrada.Previsualizar;
begin
  ULiquidaCosecheroPeriodo.LiquidacionPorEscandallo(EEmpresa.Text, ECentro.Text, EProducto.Text,
            MEDesde.Text, MEHasta.Text, ECosteComercial.Text, ECosteProduccion.Text,
            ECosteAdministrativo.Text, cbxLiquidaDefinitiva.Checked );
end;

procedure TFLLiquidaFrutaEntrada.EProductoChange(Sender: TObject);
begin
  PonNombre(Sender);
  EstadoFormSegunProducto(TEdit(Sender).Text);
end;


procedure TFLLiquidaFrutaEntrada.EstadoFormSegunProducto(const AProducto: string);
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
