unit LProductividadProductos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ActnList, ComCtrls, Db,
  CGestionPrincipal, BEdit, BCalendarButton, BSpeedButton, BGridButton,
  BCalendario, BGrid, DError, QuickRpt, Grids, DBGrids, DBTables;

type
  TFLProductividadProductos = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GBEmpresa: TGroupBox;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    EEmpresa: TBEdit;
    STEmpresa: TStaticText;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    ACancelar: TAction;
    Desde: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    MEHasta: TBEdit;
    Label14: TLabel;
    BCBHasta: TBCalendarButton;
    Query: TQuery;
    Label7: TLabel;
    lblFechaCampana: TLabel;
    edtFechaCampana: TBEdit;
    btnInicioCampana: TBCalendarButton;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);

  private
    { Public declarations }
    desgloseCosecheros: boolean;
    fechaDesde, fechaHasta, fechaCampana: TDate;

    function ValidarParametros: Boolean;
    procedure SeleccionarDatos;
    procedure SeleccionarPlantaciones;
    procedure GenerarListado;

    procedure CrearTablaTemporal;
    procedure DestruirTablaTemporal;
    procedure LimpiarTablaTemporal;
  end;

var
  Autorizado: boolean;

implementation

uses bDialogs, Principal, CVariables, CAuxiliarDB, UDMAuxDB, DPreview, CReportes,
  UDMBaseDatos, LProductividadProductosQR, bTimeUtils, bSQLUtils;

{$R *.DFM}

procedure TFLProductividadProductos.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if ValidarParametros then
  begin
    LimpiarTablaTemporal;
    SeleccionarDatos;
    if not Query.IsEmpty then
    begin
      GenerarListado;
    end
    else
    begin
      Advertir('No existen datos grabados para los parametros indicados.');
    end;
    Query.Close;
  end;
end;

procedure TFLProductividadProductos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;

  if Query.Active then Query.Close;
  //if Query2.Active then Query2.Close;

  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  Action := caFree;

  DestruirTablaTemporal;
end;

procedure TFLProductividadProductos.FormCreate(Sender: TObject);
var
  iDia, iMes, iAno: Word;
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.text:= gsDefEmpresa;
  MEDesde.Text := DateTostr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;
  DecodeDate( date, iAno, iMes, iDia );
  if iMes < 7 then
    Inc( iAno, -1 );
  edtFechaCampana.Text:= DateTostr(EncodeDate( iAno, 7, 1 ));


  EEmpresa.Tag := kEmpresa;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  edtFechaCampana.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  desgloseCosecheros := false;

  CrearTablaTemporal;
end;

procedure TFLProductividadProductos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLProductividadProductos.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
        if MEHasta.Focused then
          DespliegaCalendario(BCBHasta)
        else
          DespliegaCalendario(btnInicioCampana);
      end;
  end;
end;

procedure TFLProductividadProductos.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
  end;
end;

procedure TFLProductividadProductos.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFLProductividadProductos.ACancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLProductividadProductos.ValidarParametros: Boolean;
var
  msgError: string;
  focusFisrtError: TWinControl;
  numErrors: Integer;
begin
  msgError := '';
  focusFisrtError := nil;
  numErrors := 0;

  //Comprobamos que los campos esten todos con datos
  if Trim(EEmpresa.Text) = '' then
  begin
    focusFisrtError := EEmpresa;
    msgError := 'El código de la empresa es de obligada insercion.';
    Inc(numErrors);
  end;


  try
    fechaDesde := StrToDate(MEDesde.Text);
  except
    fechaDesde := 0;
    if focusFisrtError = nil then
      focusFisrtError := MEDesde;
    if msgError <> '' then
      msgError := msgError + #13 + #10;
    msgError := msgError + 'Falta o es incorrecta la fecha de inicio.';
    Inc(numErrors);
  end;

  try
    fechaHasta := StrToDate(MEHasta.Text);
  except
    fechaHasta := 0;
    if focusFisrtError = nil then
      focusFisrtError := MEHasta;
    if msgError <> '' then
      msgError := msgError + #13 + #10;
    msgError := msgError + 'Falta o es incorrecta la fecha de fin.';
    Inc(numErrors);
  end;

  if (fechaDesde <> 0) and (fechaHasta <> 0) then
    if fechaDesde > fechaHasta then
    begin
      if focusFisrtError = nil then
        focusFisrtError := MEDesde;
      if msgError <> '' then
        msgError := msgError + #13 + #10;
      msgError := msgError + 'Rango de fechas incorrecto.';
      Inc(numErrors);
    end;

  try
    fechaCampana := StrToDate(edtFechaCampana.Text);
  except
    fechaCampana := 0;
    if focusFisrtError = nil then
      focusFisrtError := edtFechaCampana;
    if msgError <> '' then
      msgError := msgError + #13 + #10;
    msgError := msgError + 'Falta o es incorrecta la fecha de inicio de ejercicio.';
    Inc(numErrors);
  end;

  if fechaCampana > fechaDesde then
  begin
    if focusFisrtError = nil then
      focusFisrtError := edtFechaCampana;
      if msgError <> '' then
        msgError := msgError + #13 + #10;
      msgError := msgError + 'La fecha de inicio de ejercicio no puede ser superior a la fecha inicial.';
      Inc(numErrors);
    end;

  if numErrors > 0 then
  begin
    if numErrors > 1 then
    begin
      msgError := 'Se han encontrado ' + IntToStr(numErrors) + ' errores:' +
        #13 + #10 + msgError;
    end;
    ShowError(msgError);
    ActiveControl := focusFisrtError;
  end;

  Result := numErrors = 0;
end;


procedure TFLProductividadProductos.SeleccionarDatos;
begin
  SeleccionarPlantaciones;
  //SACAR DATOS
  with Query do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' SELECT empresa_tp, tipo_producto_tp, producto_tp, provincia_tp, ');
    SQL.Add('        cosechero_tp, plantacion_tp, ano_semana_tp, ');
    SQL.Add('        descripcion_tp, superficie_tp, plantas_tp, ');

    //Seleccionar tambien los campos de la tabla frf_plantaciones :fecha_inicio_p, fecha_fin_p Robertos 23/4/2003
    SQL.Add('        fecha_inicio_tp, fecha_fin_tp, ');

    SQL.Add('        SUM(CASE WHEN (fecha_e2l >= :fechaDesde ');
    SQL.Add('                      AND (SubStr(sectores_e2l,1,1) <> '
      + QuotedStr('.') +
      '                           OR sectores_e2l IS NULL)) ');
    SQL.Add('                 THEN total_kgs_e2l ');
    SQL.Add('                 ELSE 0 END) kilosPeriodo, ');
    SQL.Add('        SUM(CASE WHEN (SubStr(sectores_e2l,1,1) <> ' + QuotedStr('.') +
      '                           OR sectores_e2l IS NULL) ');
    SQL.Add('                 THEN total_kgs_e2l ');
    SQL.Add('                 ELSE 0 END) kilosAcumulados, ');
    SQL.Add('        SUM(CASE WHEN (fecha_e2l >= :fechaDesde ');
    SQL.Add('                      AND SubStr(sectores_e2l,1,1) = ' + QuotedStr('.') + ')');
    SQL.Add('                 THEN total_kgs_e2l ');
    SQL.Add('                 ELSE 0 END) kilosPeriodo, ');
    SQL.Add('        SUM(CASE WHEN SubStr(sectores_e2l,1,1) = ' + QuotedStr('.'));
    SQL.Add('                 THEN total_kgs_e2l ');
    SQL.Add('                 ELSE 0 END) kilosPeriodo ');

    SQL.Add(' FROM  tmp_plantaciones, frf_entradas2_l ');

    SQL.Add(' WHERE empresa_e2l = :empresa ');
    SQL.Add('   AND empresa_tp = :empresa ');
    SQL.Add('   AND producto_tp = producto_e2l ');
    SQL.Add('   AND cosechero_tp = cosechero_e2l ');
    SQL.Add('   AND plantacion_tp = plantacion_e2l ');
    SQL.Add('   AND ano_semana_tp = ano_sem_planta_e2l ');
    SQL.Add('   AND fecha_e2l <= :fechaHasta ');
    //SQL.Add('   AND fecha_inicio_tp > ' + SQLDate('31/12/2001'));  (*PEPE*)

    SQL.Add(' GROUP BY empresa_tp, tipo_producto_tp, producto_tp, provincia_tp, ');
    SQL.Add('        cosechero_tp, plantacion_tp, ano_semana_tp, ');
    SQL.Add('        descripcion_tp, superficie_tp, plantas_tp ');

    //Seleccionar tambien los campos de la tabla frf_plantaciones :fecha_inicio_p, fecha_fin_p Robertos 23/4/2003
    SQL.Add('        ,fecha_inicio_tp, fecha_fin_tp ');

    SQL.Add(' order by empresa_tp, tipo_producto_tp, producto_tp, provincia_tp, ');

    //Seleccionar tambien los campos de la tabla frf_plantaciones :fecha_inicio_p, fecha_fin_p Robertos 23/4/2003
    //SQL.Add('        fecha_inicio_tp, fecha_fin_tp, ');
    SQL.Add('        cosechero_tp, plantacion_tp, ano_semana_tp ');

    ParamByName('empresa').AsString := EEmpresa.Text;
    ParamByName('fechaDesde').AsDateTime := fechaDesde;
    ParamByName('fechaHasta').AsDateTime := fechaHasta;


    Open;
  end;
end;

procedure TFLProductividadProductos.GenerarListado;
var
  listado: TQLProductividadProductosQR;
begin
  listado := TQLProductividadProductosQR.Create(Self);
  try
    listado.lblPeriodo.Caption := 'Periodo desde el ' +
      FormatDateTime('dd/mm/yy', fechaDesde) + ' al ' +
      FormatDateTime('dd/mm/yy', fechaHasta) + ' - ' +
      'Semana Nº: ' + IntToStr(Semana(fechaDesde));

    PonLogoGrupoBonnysa(Listado, EEmpresa.Text);
    Preview(listado);
  except
    listado.Free;
  end;
end;

procedure TFLProductividadProductos.CrearTablaTemporal;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_listado ( ');
    SQL.Add('        empresa_tl CHAR(3), ');
    SQL.Add('        producto_tl CHAR(3), ');
    SQL.Add('        tipo_producto_tl CHAR(1), ');
    SQL.Add('        provincia_tl CHAR(2), ');
    SQL.Add('        cosechero_tl INTEGER, ');
    SQL.Add('        plantacion_tl INTEGER, ');
    SQL.Add('        ano_semana_tl INTEGER, ');
    SQL.Add('        descripcion_tl CHAR(30), ');
    SQL.Add('        superficie_tl DECIMAl(5,2), ');
    SQL.Add('        plantas_tl DECIMAl(9,0), ');
    SQL.Add('        kilosPeriodo_tl DECIMAl(12,2), ');
    SQL.Add('        kilosAcumulados_tl DECIMAl(12,2), ');
    SQL.Add('        puntoPeriodo_tl DECIMAl(12,2), ');
    SQL.Add('        puntoAcumulados_tl DECIMAl(12,2)) ');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_plantaciones ( ');
    SQL.Add('        empresa_tp CHAR(3), ');
    SQL.Add('        producto_tp CHAR(3), ');
    SQL.Add('        tipo_producto_tp CHAR(1), ');
    SQL.Add('        provincia_tp CHAR(2), ');
    SQL.Add('        cosechero_tp INTEGER, ');
    SQL.Add('        plantacion_tp INTEGER, ');
    SQL.Add('        ano_semana_tp INTEGER, ');
    SQL.Add('        descripcion_tp CHAR(30), ');
    SQL.Add('        superficie_tp DECIMAl(5,2), ');
    //SQL.Add('        plantas_tp DECIMAl(9,0)) ');
    SQL.Add('        plantas_tp DECIMAl(9,0), ');


    SQL.Add('        fecha_inicio_tp DATE, ');
    SQL.Add('        fecha_fin_tp DATE)');
    ExecSQL;
  end;
end;

procedure TFLProductividadProductos.DestruirTablaTemporal;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' DROP TABLE tmp_listado ');
    ExecSQL;
    SQL.Clear;
    SQL.Add(' DROP TABLE tmp_plantaciones ');
    ExecSQL;
  end;
end;

procedure TFLProductividadProductos.LimpiarTablaTemporal;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' DELETE FROM tmp_listado WHERE 1 = 1 ');
    ExecSQL;
    SQL.Clear;
    SQL.Add(' DELETE FROM tmp_plantaciones WHERE 1 = 1 ');
    ExecSQL;
  end;
end;

procedure TFLProductividadProductos.SeleccionarPlantaciones;
var
  code: string;
begin
  with DMBaseDatos.QTemp do
  begin
      DMBaseDatos.QAux.SQL.Clear;
      //OBTENEMOS LAS PLANTACIONES QUE NO HAN CERRADO CAMPAÑA O EL CIERRE DE LA
      //CAMPAÑA FUE SUPERIOR A LA FECHA DE FIN DE EJERCICIO
      DMBaseDatos.QAux.SQL.Add(' INSERT INTO tmp_plantaciones ');
      DMBaseDatos.QAux.SQL.Add(' SELECT empresa_p, producto_p, ');
      DMBaseDatos.QAux.SQL.Add('        0, SubStr(cod_postal_c,1,2), ');
      DMBaseDatos.QAux.SQL.Add('        cosechero_p, plantacion_p, ano_semana_p, ');
      DMBaseDatos.QAux.SQL.Add('        descripcion_p,superficie_p, plantas_p ');

      //Seleccionar tambien los campos de la tabla frf_plantaciones :fecha_inicio_p, fecha_fin_p Robertos 23/4/2003
      DMBaseDatos.QAux.SQL.Add(' ,fecha_inicio_p, fecha_fin_p');

      DMBaseDatos.QAux.SQL.Add(' FROM  frf_plantaciones, frf_cosecheros');
      DMBaseDatos.QAux.SQL.Add(' WHERE empresa_p = :empresa ');

      DMBaseDatos.QAux.SQL.Add('   and ( fecha_fin_p  is null or fecha_fin_p >= :fechaDesde ) ');
      DMBaseDatos.QAux.SQL.Add('  and fecha_inicio_p <= :fechaHasta ');

      DMBaseDatos.QAux.SQL.Add('   and empresa_c = :empresa');
      DMBaseDatos.QAux.SQL.Add('   and cosechero_c = cosechero_p');

      DMBaseDatos.QAux.ParamByName('empresa').AsString := EEmpresa.Text;

      DMBaseDatos.QAux.ParamByName('fechaDesde').AsDateTime := fechaCampana;
      DMBaseDatos.QAux.ParamByName('fechaHasta').AsDateTime := fechaHasta;

      DMBaseDatos.QAux.ExecSQL;

    Close;
    SQL.Clear;
    //SÓLO NOS QUEDAMOS CON LA PLANTACION MAS RECIENTE
    SQL.Add(' SELECT producto_tp, cosechero_tp, plantacion_tp, ano_semana_tp');
    SQL.Add(' FROM  tmp_plantaciones ');
    SQL.Add(' order by producto_tp, cosechero_tp, plantacion_tp, ano_semana_tp desc');
    Open;

    code := '';
    while not EOF do
    begin
      if code = FieldByName('producto_tp').AsString +
        FieldByName('cosechero_tp').AsString +
        FieldByName('plantacion_tp').AsString then
      begin
        //BORRAR RESTO DE PLANTACIONES
        DMBaseDatos.QAux.SQL.Clear;
        DMBaseDatos.QAux.SQL.Add(' DELETE FROM tmp_plantaciones ');
        DMBaseDatos.QAux.SQL.Add(' WHERE producto_tp = :producto');
        DMBaseDatos.QAux.SQL.Add('   and cosechero_tp = :cosechero ');
        DMBaseDatos.QAux.SQL.Add('   and plantacion_tp = :plantacion ');
        DMBaseDatos.QAux.SQL.Add('   and ano_semana_tp = :anosemana ');

        DMBaseDatos.QAux.ParamByName('producto').AsString :=
          FieldByName('producto_tp').AsString;
        DMBaseDatos.QAux.ParamByName('cosechero').AsString :=
          FieldByName('cosechero_tp').AsString;
        DMBaseDatos.QAux.ParamByName('plantacion').AsString :=
          FieldByName('plantacion_tp').AsString;
        DMBaseDatos.QAux.ParamByName('anosemana').AsString :=
          FieldByName('ano_semana_tp').AsString;

        DMBaseDatos.QAux.ExecSQL;
      end
      else
      begin
        code := FieldByName('producto_tp').AsString +
          FieldByName('cosechero_tp').AsString +
          FieldByName('plantacion_tp').AsString;
      end;
      Next;
    end;
    Close;

    //SEPARAR POR GRUPO LOS PRODUCTOS
    //TIPO 1 --> TOMATE NORMAL
    //TIPO 2 --> TOMATE ESPECIALIDADES
    //TIPO 3 --> RESTO PRODUCTOS
    SQL.Clear;
    SQL.Add(' UPDATE tmp_plantaciones ');
    SQL.Add(' SET tipo_producto_tp = 2 ');
    SQL.Add(' WHERE producto_tp IN (select producto_p from frf_productos ');
    SQL.Add('                       WHERE esTomate_p = ' + QuotedStr('S') + ')');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' UPDATE tmp_plantaciones ');
    SQL.Add(' SET tipo_producto_tp = 3 ');
    SQL.Add(' WHERE producto_tp IN (select producto_p from frf_productos ');
    SQL.Add('                       WHERE esTomate_p = ' + QuotedStr('N') + ')');
    ExecSQL;

    SQL.Clear;
    SQL.Add(' UPDATE tmp_plantaciones ');
    SQL.Add(' SET tipo_producto_tp = 1 ');
    SQL.Add(' WHERE producto_tp IN (' + QuotedStr('TOM') + ',' +
      QuotedStr('TOM') + ') ');
    ExecSQL;
  end;
end;

end.
