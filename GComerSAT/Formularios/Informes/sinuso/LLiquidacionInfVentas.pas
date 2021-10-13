{NOTAS: Los gastos de transitos sólo se restan para el centro 6 producto E}
unit LLiquidacionInfVentas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList, ComCtrls,
  BEdit, Grids, DBGrids, BGrid, BSpeedButton, BGridButton, BCalendarButton,
  BCalendario, DError, dbtables, QuickRpt;

type
  TFLLiquidacionInfVentas = class(TForm)
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
    Label6: TLabel;
    EProductor: TBEdit;
    BGBProductor: TBGridButton;
    STProductor: TStaticText;
    cbAprovechamiento: TComboBox;
    Label9: TLabel;
    cbxAbonos: TCheckBox;
    cbxAjustes: TCheckBox;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGBProductorClick(Sender: TObject);
    procedure MEDesdeChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EProductoChange(Sender: TObject);

  public
    { Public declarations }
  private

    procedure Previsualizar;
    procedure PreparaLiquidacion;
    procedure BorrarDatosTablasTemporles;

  public
  end;

implementation

uses CVariables, CAuxiliarDB, UDMBaseDatos, CGestionPrincipal, bSQLUtils,
  QLLiquidacionInfVentas, UDMAuxDB, DPreview, CReportes, bMath, bDialogs,
  DateUtils, bTimeUtils, UComunProductores, TablaTmpFob;


{$R *.DFM}

procedure TFLLiquidacionInfVentas.BBCancelarClick(Sender: TObject);
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

function EstaGastoEnvasadoGrabado(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDateTime): boolean;
(*var
  sEnvase: string;
*)
begin
  result := true;
  if (ACentro = '6') and (AProducto = 'E') then
    Exit;
  with DMAuxDB.QAux do
  begin
(*    SQL.Clear;
    SQL.Add('  select distinct producto_base_p, envase_sl ');
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
    SQL.Add('          and centro_ec  =  :centro ');
    SQL.Add('          and producto_base_ec = producto_base_p ');
    SQL.Add('          and envase_ec = envase_sl ');
    SQL.Add(' ) ');
    SQL.Add('  order by 1,2 ');
    ParamByname('empresa').AsString:= AEmpresa;
    ParamByname('centro').AsString:= ACentro;
    ParamByname('producto').AsString:= AProducto;
    ParamByname('fechaini').AsDate:= AFechaIni;
    ParamByname('fechafin').AsDate:= AFechaFin;

    if OpenQuery( DMAuxDB.QAux ) then
    begin
      sEnvase:= '';
      if  not isEmpty then
        sEnvase:= Fields[1].AsString;
      Close;
      if sEnvase <> '' then
        raise Exception.Create('No existe ningún precio para el envase "' + sEnvase + '"');
    end;
*)
    SQL.Clear;
    SQL.Add('  select distinct MONTH(fecha_sl) mes, producto_base_p, envase_sl ');
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
    SQL.Add('          and centro_ec  =  :centro ');
    SQL.Add('          and producto_base_ec = producto_base_p ');
    SQL.Add('          and envase_ec = envase_sl ');
    SQL.Add(' ) ');
    SQL.Add('  order by 1,2,3 ');
    ParamByname('empresa').AsString := AEmpresa;
    ParamByname('centro').AsString := ACentro;
    ParamByname('producto').AsString := AProducto;
    ParamByname('fechaini').AsDate := AFechaIni;
    ParamByname('fechafin').AsDate := AFechaFin;

    if OpenQuery(DMAuxDB.QAux) then
    begin
      result := isEmpty;
      Close;
    end
    else
    begin
      result := false;
    end;
  end;
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

procedure TFLLiquidacionInfVentas.BBAceptarClick(Sender: TObject);
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
  if EProductor.Text = '' then
  begin
    AddLine(aux, 'El código del productor es de obligada inserción.');
    SetFocusNil(ControlError, EProductor);
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

  //Que los gastos de los tansitos esten grabados
  if not EstaGastoTransitoAsignado(EEmpresa.Text, ECentro.Text, EProducto.Text, StrToDate(MEDesde.Text),
                                  StrToDate(MEHasta.Text)) then
  begin
    if not Preguntar('Faltan por asignar los gastos de los transitos. ¿Seguro que desea continuar?' ) then
      Exit;
  end;


  //Que todos los costes de envasado esten grabados
  try
    if EstaGastoEnvasadoGrabado(EEmpresa.Text, ECentro.Text, EProducto.Text,
      StrToDate(MEDesde.Text), StrToDate(MEHasta.Text)) then
    begin
      try
        BorrarDatosTablasTemporles;
        Previsualizar;
      finally
        BorrarTemporal('tmp_fob');
      end;
    end
    else
    begin
      if Preguntar('Falta grabar envases. ¿Desea continuar?') then
      begin
        try
          BorrarDatosTablasTemporles;
          Previsualizar;
        finally
          BorrarTemporal('tmp_fob');
        end;
      end;
    end;
  except
    on e: exception do
    begin
      ShowMessage(e.Message);
      Exit;
    end;
  end;

end;


procedure TFLLiquidacionInfVentas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;

  FormType := tfDirector;
  BHFormulario;

  TablaTmpFob.BorrarDatosActuales( gsCodigo );

  Action := caFree;
end;

procedure TFLLiquidacionInfVentas.BorrarDatosTablasTemporles;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('delete from tmp_coste_envasado where 1 = 1');
    ExecSQL;
    SQL.Clear;
    SQL.Add('delete from tmp_categorias where 1 = 1');
    ExecSQL;
    SQL.Clear;
    SQL.Add('delete from tmp_resum_liqui where 1 = 1');
    ExecSQL;
  end;
end;

procedure TFLLiquidacionInfVentas.FormDestroy(Sender: TObject);
begin
  BorrarTemporal('tmp_coste_envasado');
  BorrarTemporal('tmp_categorias');
  BorrarTemporal('tmp_resum_liqui');
end;

procedure TFLLiquidacionInfVentas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  CalendarioFlotante.Date := Date;
  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;
  EProducto.Tag := kProducto;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  EProductor.Tag := kProductor;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

     //EEmpresa.Text:='050';
     //ECentro.Text:='1';
     //EProducto.Text:='T';
     //EProductor.Text:= '64';
  EEmpresa.Text := '';
  ECentro.Text := '';
  EProducto.Text := '';
  EProductor.Text := '';

     //auxDate:= Date - 7;
     //while DayOfTheWeek( auxDate ) <> 1 do
     //  auxDate:= auxDate - 1;
     //MEDesde.Text:= DateToStr( auxDate );
     //MEHasta.Text:= DateToStr( auxDate + 6 );
  MEDesde.Text := '';
  MEHasta.Text := '';

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_resum_liqui (cod SMALLINT,nom CHAR(30), ' +
      ' kcos INTEGER, kapr INTEGER, kapr1 INTEGER, kapr2 INTEGER,' +
      ' brutofob DECIMAL(10,2),genv DECIMAL(10,2),netofob DECIMAL(10,2), ' +
      ' ggenv DECIMAL(10,2), ' +
      ' gcom DECIMAL(10,2),gadm DECIMAL(10,2),neto DECIMAL(10,2) )');
    ExecSql;

    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_coste_envasado ( ');
    SQL.Add('    anyosemana char(6), ');
    SQL.Add('    categoria char(2), ');
    SQL.Add('    coste_envasado decimal(4,3) ');
    SQL.Add(' )');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_categorias ( ');
    SQL.Add('    cosechero integer, ');
    SQL.Add('    anyosemana char(6), ');
    SQL.Add('    kilos decimal(12,2), ');
    SQL.Add('    aprovecha decimal(6,3), ');
    SQL.Add('    aprovechados decimal(12,2), ');
    SQL.Add('    categoria char(2), ');
    SQL.Add('    porcentaje decimal(6,3), ');
    SQL.Add('    kilos_cat decimal(12,2), ');
    SQL.Add('    vendidos_cat decimal(12,2), ');
    SQL.Add('    transitos_cat decimal(12,2) ');
    SQL.Add(' )');
    ExecSQL;
  end;
end;

procedure TFLLiquidacionInfVentas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLLiquidacionInfVentas.ADesplegarRejillaExecute(Sender: TObject);
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
    kProductor: DespliegaRejilla(BGBProductor, [EEmpresa.Text])
  end;
end;

procedure TFLLiquidacionInfVentas.PonNombre(Sender: TObject);
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
    kProductor: STProductor.Caption := desCosechero(Eempresa.Text, EProductor.Text);
  end;
end;

procedure TFLLiquidacionInfVentas.Previsualizar;
var
  fechaInicio, fechafin, fechacorte: string;
  sHay, sFalta: TStringList;
  bFlag: boolean;
begin
  try
    CalcularFechaInicio(EEmpresa.Text, ECentro.Text, EProducto.Text, EProductor.Text, MEDesde.Text, MEHasta.Text, fechaInicio, fechafin);
    if fechaInicio = 'ERROR' then begin
      MessageDlg('' + #13 + #10 + 'Problemas al calcular la liquidación.' + #13 + #10 + 'Por favor, pongase en contacto con     ' + #13 + #10 + 'el departamento de informatica.', mtError, [mbOK], 0);
      Exit;
    end
    else
      if fechaInicio = '' then begin
        MessageDlg('' + #13 + #10 + 'No existen entradas para el rango de fechas seleccionado.    ', mtWarning, [mbOK], 0);
        Exit;
      end;

    //Esta el escandallo ajustado
    if not EstaAjustado( EEmpresa.Text, ECentro.Text, EProducto.Text, fechainicio, fechafin, fechaCorte ) then
    begin
      MessageDlg('' + #13 + #10 + 'Falta ajustar los escandallos desde el ' + QuotedStr( fechaCorte ) +  ', semana ' +
        QuotedStr( AnyoSemana(  StrToDate(fechacorte) ) ) + '.  ', mtWarning, [mbOK], 0);
      Exit;
    end;

    if cbxAjustes.Checked then
    if AplicarAjusteFob(EEmpresa.Text, EProductor.Text) then
    begin
      sHay := TStringList.Create;
      sFalta := TStringList.Create;
      try
        ListaAjusteCosFob(EEmpresa.Text, EProductor.Text, EProducto.Text, fechaInicio,
          MEHasta.Text, sHay, sFalta);
        if sFalta.Text <> '' then
        begin
          if not AjusteCosFOBFaltantes(EEmpresa.Text, EProductor.Text, EProducto.Text, sFalta) then
            Exit;
        end;
        sHay.AddStrings(sFalta);
        sHay.Sort;
        if Application.MessageBox(PCHAR(#13 + #10 + 'Se aplicaran los siguientes ajustes:' + #13 + #10 + sHay.Text + '¿Desea continuar?'),
          'AJUSTE FOB COSECHERO', MB_OKCANCEL) = IDCANCEL then
          Exit;
      finally
        FreeAndNil(sHay);
        FreeAndNil(sFalta);
      end;
    end;

    if cbAprovechamiento.ItemIndex = 1 then
    begin
      (*CAMBIOLIQ*)
      bFlag:= false;
      //bFlag:= ( EEmpresa.Text = '050' ) and  ( ECentro.Text = '6' ) and ( EProducto.Text = 'E' );
      if not KGSAprovecha(EEmpresa.Text, ECentro.Text, EProducto.Text, EProductor.Text,
        fechaInicio, MEHasta.Text, bFlag) then
      begin
        MessageDlg('' + #13 + #10 + 'No esta grabado o ajustado el escandallo para el rango de fechas seleccionado.    ', mtWarning, [mbOK], 0);
        FreeAndNil(QRLLiquidacionInfVentas);
        Exit;
      end;
    end
    else
      if cbAprovechamiento.ItemIndex = 0 then
      begin
        if not BucleKGSAprovechaEx(EEmpresa.Text, ECentro.Text, EProducto.Text, EProductor.Text, StrToDate(fechaInicio), StrToDate(MEHasta.Text)) then
        begin
          MessageDlg('' + #13 + #10 + 'No hay salidas para el rango de datos seleccionado.    ', mtWarning, [mbOK], 0);
          FreeAndNil(QRLLiquidacionInfVentas);
          Exit;
        end;
      end;

(*
    if not ( ( EProducto.Text = 'E' ) and ( ECentro.Text = '6' ) ) then
      CosteEnvasado( EEmpresa.Text, ECentro.Text, EProducto.Text, StrToDate( fechaInicio ) , StrToDate( MEHasta.Text ) );
*)
    try
      NuevoCalcularFOB(gsCodigo, EEmpresa.Text, ECentro.Text, EProducto.Text, EProductor.Text, fechaInicio, MEHasta.Text, cbxAbonos.Checked, cbxAjustes.Checked );
      //CalcularFOB( EEmpresa.Text, ECentro.Text, EProducto.Text, fechaInicio );
      (*NUEVALIQUIDACIONTERCEROS*)
      FinalFobNuevaLiquidacionTerceros(EEmpresa.Text, ECentro.Text, EProducto.Text, fechaInicio, MEHasta.Text, EProductor.Text);
      RepercutirFobNegativo;
    finally
      BorrarTemporal('tmp_fob_aux');
    end;
  except
    on E: Exception do
    begin
      BEMensajes('');
      ShowError(e.Message);
      Exit;
    end;
  end;

  try
    PreparaLiquidacion;

    if cbxAjustes.Checked then
    begin
      QRLLiquidacionInfVentas.lblSinAjuste.Caption:= '' ;
    end
    else
    begin
      QRLLiquidacionInfVentas.lblSinAjuste.Caption:= '(Sin Ajuste)' ;
    end;
    QRLLiquidacionInfVentas.DatosSimulacion(EEmpresa.Text, ECentro.Text, EProducto.Text,
      EProductor.Text, StrToDate(MEDesde.Text), StrToDate(MEHasta.Text));
    Preview(QRLLiquidacionInfVentas);
  finally
  end;
end;


procedure TFLLiquidacionInfVentas.PreparaLiquidacion;
begin
  with DMAUxDB.QAux do
  begin
    SQL.Clear;
    SQl.Add(' delete from tmp_resum_liqui');
    ExecSQL;
  end;

  QRLLiquidacionInfVentas := TQRLLiquidacionInfVentas.Create(Application);
  PonLogoGrupoBonnysa(QRLLiquidacionInfVentas, EEmpresa.Text);
  with QRLLiquidacionInfVentas.QCosecheros do
  begin
    Cancel;
    Close;
    SQL.Clear;
    SQl.add(' select unique cosechero,nombre_c' +
      ' from tmp_categorias,frf_cosecheros ' +
      ' where empresa_c=:empresa ' +
      '   and cosechero_c=cosechero' +
      ' order by cosechero ');
    ParamByName('empresa').AsString := EEmpresa.Text;
    Open;
  end;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQl.Add(' insert into tmp_resum_liqui (cod,nom) ' +
      ' select unique cosechero,nombre_c' +
      ' from tmp_categorias,frf_cosecheros ' +
      ' where empresa_c=:empresa ' +
      '   and cosechero_c=cosechero');
    ParamByName('empresa').AsString := EEmpresa.Text;
    ExecSQL;
  end;

  with QRLLiquidacionInfVentas.QKGSCosechados do
  begin
    Cancel;
    Close;
    SQL.Clear;
    SQl.add(' select anyosemana semana, kilos, aprovecha, aprovechados, ' +
      '        categoria, porcentaje, kilos_cat, vendidos_cat, transitos_cat ' +
      ' from tmp_categorias ' +
      ' where cosechero=:cosechero ' +
      ' and kilos_cat <> 0 ' +
      ' order by anyosemana,categoria ');
    Open;
  end;

  with QRLLiquidacionInfVentas.QFOB do
  begin
    Cancel;
    Close;
    SQL.Clear;
    SQl.add(' select fob,coste_envasado,fob_real ' +
      ' from tmp_fob ' +
      ' where anyosemana=:semana ' +
      '   and categoria=:categoria ');
    Open;
  end;

  with QRLLiquidacionInfVentas do
  begin
    empresa := EEmpresa.Text;
    //Centro
    codCentro.Caption := ECentro.Text;
    NomCentro.Caption := STCentro.Caption;
    //Producto
    codProducto.Caption := EProducto.Text;
    nomProducto.Caption := STProducto.Caption;
    //Periodo
    periodo.Caption := 'Desde ' + MEDesde.Text + ' hasta ' + MEHasta.Text;
  end;
end;


procedure TFLLiquidacionInfVentas.FormActivate(Sender: TObject);
begin
  Top := 1;
end;

procedure TFLLiquidacionInfVentas.BGBProductorClick(Sender: TObject);
begin
  DMBaseDatos.QDespegables.Cancel;
  DMBaseDatos.QDespegables.Close;

  RejillaFlotante.ColumnResult := 1;
  RejillaFlotante.ColumnFind := 2;
  DMBaseDatos.QDespegables.SQL.Clear;
  DMBaseDatos.QDespegables.SQL.Add(' SELECT empresa_c, cosechero_c, nombre_c ' +
    ' FROM frf_cosecheros Frf_cosecheros ');
  if (Trim(EEmpresa.Text) <> '') then
    DMBaseDatos.QDespegables.SQL.Add(' WHERE empresa_c= ' + QuotedStr(EEmpresa.Text));
  DMBaseDatos.QDespegables.SQL.Add(' AND pertenece_grupo_c = ' + QuotedStr('N'));
  DMBaseDatos.QDespegables.SQL.Add(' ORDER BY empresa_c, nombre_c ');

     //Abre consulta
  try
    DMBaseDatos.QDespegables.Open;
  except
    ShowError('Error al mostrar los datos.');
    Exit;
  end;

     //Tiene valores
  if DMBaseDatos.QDespegables.IsEmpty then
  begin
    ShowError('Consulta sin datos.');
    Exit;
  end;

  RejillaFlotante.BControl := EProductor;
  BGBProductor.GridShow;
end;

procedure TFLLiquidacionInfVentas.MEDesdeChange(Sender: TObject);
begin
  try
    MEHasta.Text := DateToStr(StrToDate(MEDesde.Text) + 6);
  except
  end;
end;

procedure TFLLiquidacionInfVentas.EProductoChange(Sender: TObject);
begin
  PonNombre(sender);
end;

end.
