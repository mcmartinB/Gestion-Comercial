
unit MCambioMonedas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError;

type
  TFMCambioMonedas = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Gfecha_ce: TBDEdit;
    LFecha: TLabel;
    moneda_ce: TBDEdit;
    LMoneda: TLabel;
    STMoneda: TStaticText;
    LCambio: TLabel;
    fecha_ce: TBDEdit;
    DSDetalle: TDataSource;
    gridDetalles: TDBGrid;
    DSMaestroModif: TDataSource;
    BCBFecha: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    BCBFechaHasta: TBCalendarButton;
    LDesde: TLabel;
    LHasta: TLabel;
    FechaHasta: TBEdit;
    cambio_ce: TBDEdit;
    PTipoListado: TPanel;
    SBCancelar: TSpeedButton;
    SBAceptar: TSpeedButton;
    RGTipo: TRadioGroup;
    TMoneda: TTable;
    QCambioMonedasG: TQuery;
    QCambioMonedasGfecha_cm: TDateField;
    QCambioMonedasDetalle: TQuery;
    DateField1: TDateField;
    StringField1: TStringField;
    FloatField1: TFloatField;
    StringField2: TStringField;
    QCambioMonedas: TQuery;
    QCambioMonedasfecha_cm: TDateField;
    QCambioMonedasmoneda_cm: TStringField;
    QCambioMonedascambio_cm: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure moneda_ceChange(Sender: TObject);
    procedure CambioRegistro;
    procedure gridDetallesDblClick(Sender: TObject);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure SBAceptarClick(Sender: TObject);
    procedure SBCancelarClick(Sender: TObject);

  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;
    function filtrarFecha(): string;
    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;
    procedure editableFormulario();
    procedure filtrarDetalles();
    procedure Prev();

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;
    procedure Localizar; override;
    procedure Modificar; override;
    procedure Borrar; override;
    procedure Altas; override;

    procedure Aceptar; override;
    procedure Cancelar; override;

        //Aceptar
    procedure AceptarAltaCM;
    procedure AceptarModificarCM;
    procedure AceptarLocalizarCM;
    //Cancelar

    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    procedure CancelarMLCM;
    procedure CancelarAltaCM;

    //Listado
    procedure Previsualizar; override;
  end;

var
  marcaModify: TBookmark;
  marcaCabecera: TBookmark;
  aceptarImprimir: Boolean;
  tipInf: Char;
implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos,
  CAuxiliarDB, Principal, LCambioDivisas, DPreview,
  UDMAuxDB, bSQLUtils, CReportes;

{$R *.DFM}

procedure TFMCambioMonedas.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DataSetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
  end;
     //Estado inicial
  Registros := 0;
  if registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMCambioMonedas.CerrarTablas;
begin
     // Cerrar tabla
  if DataSetMaestro.Active then DataSetMaestro.Close;

end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMCambioMonedas.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
  gCF := CalendarioFlotante;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QCambioMonedasG;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)

 {+}Select := ' SELECT fecha_ce' +
    ' FROM frf_cambios_euros' +
    ' GROUP BY fecha_ce ';
 {+}where := ' HAVING fecha_ce = ' + QuotedStr('01/01/1800') + ' ';
 {+}Order := ' ORDER BY fecha_ce ';
     //Abrir tablas/Querys

  QCambioMonedas.RequestLive := TRUE;
  QCambioMonedasG.RequestLive := FALSE;
  QCambioMonedasDetalle.RequestLive := FALSE;
  try
    AbrirTablas;
        //Habilitamos controles de Base de datos
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Close;
      Exit;
    end;
  end;
  filtrarDetalles;
     //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  Visualizar;

     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
//     empresa_t.Tag:=kEmpresa;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnChangeMasterRecord := CambioRegistro;
     // OnInsert:=AntesDeInsertar;
  OnEdit := AntesDeModificar;
     //OnBrowse:=AntesDeInsertar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := fecha_ce;
  {+}FocoModificar := cambio_ce;
  {+}FocoLocalizar := fecha_ce;

  editableFormulario;
end;

{+ CUIDADIN }

procedure TFMCambioMonedas.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_SHOWNORMAL);
  if not DataSetMaestro.Active then Exit;
     //Formulario activo
  M := self;
  MD := nil;
  gRF := nil;
  gCF := CalendarioFlotante;
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMCambioMonedas.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;
end;

procedure TFMCambioMonedas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;

     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
     //Codigo de desactivacion
  CerrarTablas;
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMCambioMonedas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return:
      begin
        if (Estado = teConjuntoResultado) and
          (gridDetalles.Focused) then
          FPrincipal.AMModificarExecute(Sender)
        else
        begin
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
          Key := 0;
        end;
      end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

{+}//Sustituir por funcion generica

procedure TFMCambioMonedas.Filtro;
var condi: string;
begin
  condi := filtrarFecha();
  if Trim(condi) <> '' then
    Where := ' HAVING ' + condi
  else Where := '';

   {+}Select := 'SELECT fecha_ce FROM frf_cambios_euros Frf_cambios_euros ' +
    'GROUP BY fecha_ce ';
   {+}Order := 'ORDER BY fecha_ce ';
end;

{+}//sustituir por funcion generica

procedure TFMCambioMonedas.AnyadirRegistro;
begin

  if Where <> '' then
    // Else Where := 'HAVING (';
  begin
    Where := Where + ' OR (' +
      'fecha_ce=' +
      SQLDate(fecha_ce.Text) +
      ') ';
  end;
end;

{+}//Sustituir por funcion generica

procedure TFMCambioMonedas.ValidarEntradaMaestro;
var
  i: Integer;
  rDif, rAux: real;
  sFecha: String;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Required and (Trim(Text) = '') then
        begin
          if Trim(RequiredMsg) <> '' then
            raise Exception.Create(RequiredMsg)
          else
            raise Exception.Create('Faltan datos de obligada inserción.');
        end;

      end;
    end;
  end;

  //Comprobar que la desviacion del cambio no sea excesiva  con respecto al anterior (0,2 max)
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select fecha_ce, cambio_ce ');
    SQL.Add(' FROM frf_cambios_euros ');
    SQL.Add(' where moneda_ce = :moneda ');
    SQL.Add('   and fecha_ce < :fechaini ');
    SQL.Add('   and fecha_ce > :fechafin ');
    SQL.Add(' order by fecha_ce desc ');

    ParamByName('moneda').AsString:= moneda_ce.Text;
    ParamByName('fechaini').AsDate:= DSDetalle.DataSet.FieldByName('fecha_ce').AsDateTime;
    ParamByName('fechafin').AsDate:= DSDetalle.DataSet.FieldByName('fecha_ce').AsDateTime - 30;

    Open;
    if not IsEmpty then
    begin
      rAux:= StrToFloatDef( cambio_ce.Text, 0 );
      rDif:= Abs( rAux - FieldByName('cambio_ce').AsFloat );
      if moneda_ce.Text = 'GBP' then
      begin
        if rDif > 0.05 then
        begin
          sFecha:= FieldByName('fecha_ce').AsString;
          Close;
          raise Exception.Create('Operación cancelada.' + #13 + #10 +
                                 'La diferencia entre el cambio que intenta grabar y     ' + #13 + #10 +
                                 'el ultimo grabado el   ' + sFecha + ' es de ' + FormatFloat( '#.00000', rDif ) + #13 + #10 +
                                 'y superior a la maxima permitida.');
        end
        else
        if rDif > 0.02 then
        begin
          if Application.MessageBox(Pchar( 'La diferencia entre el cambio que intenta grabar y     ' + #13 + #10 +
                                  ' el ultimo grabado el   ' + FieldByName('fecha_ce').AsString + ' es de ' +
                                  FormatFloat( '#.00000', rDif ) + '€    ' + #13 + #10 +
                                  '¿Esta seguro que el cambio para ' + moneda_ce.Text +
                                  ' de ' + cambio_ce.Text + '€ es correcto?     '),
                                  'DESVIACIÓN CAMBIO EXCESIVA.', MB_YESNO ) = IDNO then
          begin
            Close;
            Raise Exception.Create('Operación cancelada.');
          end;
        end;
      end
      else
      begin
        if rDif > 0.05 then
        begin
          if Application.MessageBox(Pchar( 'La diferencia entre el cambio que intenta grabar y     ' + #13 + #10 +
                                  ' el ultimo grabado el   ' + FieldByName('fecha_ce').AsString + ' es de ' +
                                  FormatFloat( '#.00000', rDif ) + '€    ' + #13 + #10 +
                                  '¿Esta seguro que el cambio para ' + moneda_ce.Text +
                                  ' de ' + cambio_ce.Text + '€ es correcto?     '),
                                  'DESVIACIÓN CAMBIO EXCESIVA.', MB_YESNO ) = IDNO then
          begin
            Close;
            Raise Exception.Create('Operación cancelada.');
          end;
        end;
      end;
    end;
    Close;
  end;
end;

procedure TFMCambioMonedas.Previsualizar;
begin
  FPrincipal.TBBarraMaestro.Enabled := FALSE;
  PTipoListado.Show;
  RGtipo.SetFocus;
  RGtipo.ItemIndex := 0;
  PMaestro.Enabled := False;
  gridDetalles.Enabled := False;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//****************************************************************************

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMCambioMonedas.AntesDeModificar;
var i: Integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMCambioMonedas.AntesDeVisualizar;
var i: Integer;
begin
    //Resaturar estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMCambioMonedas.RequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
  isTime := false;
  if TBEdit(Sender).CanFocus then
  begin
    if (Estado = teLocalizar) then
      Exit;
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
    isTime := true;
  end;
end;

procedure TFMCambioMonedas.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewHeight < 35 then
  begin
    ShowWindow(Application.Handle, SW_SHOWMINNOACTIVE);
    Resize := False;
  end;
end;

procedure TFMCambioMonedas.moneda_ceChange(Sender: TObject);
begin
     // Obtención de la descripción de la Moneda...
  if Trim(moneda_ce.Text) = '' then
    STMoneda.Caption := ' '
  else
  begin
    if not TMoneda.Active then TMoneda.Open;
    if TMoneda.FindKey([moneda_ce.Text]) then
      STMoneda.Caption := Trim(TMoneda.FieldByName('descripcion_m').AsString)
    else STMoneda.Caption := ' ';
    TMoneda.Close;
  end
end;

procedure TFMCambioMonedas.Localizar;
begin
  Estado := teLocalizar;
  editableFormulario;
  BEEstado;
  BHEstado;
  PanelMaestro.Enabled := True;
  DataSeTMaestro := QCambioMonedas;
  if not DataSetMaestro.Active then
    DataSeTMaestro.Open;
  DataSeTMaestro.Insert;
  filtrarDetalles;
     // if Assigned(FOnBrowse) then FOnBrowse;

  fecha_ce.Text := DateToStr(Date);
  fechaHasta.Text := DateToStr(Date);
  Self.ActiveControl := fechaHasta // FocoLocalizar;

end;

procedure TFMCambioMonedas.Modificar;
var moneda: string;
  fech: string;
  salir: Boolean;
begin
  raise Exception.Create('Las altas de los cambio se hacen desde X3.');

  Estado := teModificar;
  BEEstado;
  BHEstado;
  PanelMaestro.Enabled := True;

  marcaCabecera := DataSeTMaestro.GetBookmark;

  DataSeTMaestro := QCambioMonedas;
  if not DataSeTMaestro.Active then DataSeTMaestro.Open;
     // fech   := SQLDate (Gfecha_ce.Text);
  fech := Gfecha_ce.Text;
  moneda := gridDetalles.DataSource.DataSet.FieldByName('moneda_ce').AsString;

  marcaModify := gridDetalles.DataSource.DataSet.GetBookmark;
     // DataSeTMaestro.DataSource.DataSet.Locate ('fecha_ce;moneda_ce',
     //                                           VarArrayOf([fech ,  moneda ]),[]);
  DataSeTMaestro.First;
  salir := False;
  while not salir do
  begin
    if ((DataSeTMaestro.FieldByName('fecha_ce').AsString = fech) and
      (DataSeTMaestro.FieldByName('moneda_ce').AsString = moneda))
      then
      salir := TRUE
    else DataSeTMaestro.Next;
  end;

  DataSeTMaestro.Edit;
  if Assigned(FOnEdit) then FOnEdit;
  editableFormulario;
  Self.ActiveControl := FocoModificar;
end;

procedure TFMCambioMonedas.Borrar;
var fech: string;
  posi: Integer;
  botonPulsado: Word;
begin
  raise Exception.Create('Las altas de los cambio se hacen desde X3.');

     // Función
  botonPulsado := MessageDlg('¿Desea borrar los cambios de Moneda de la fecha seleccionada?',
    mtConfirmation, [mbYes, mbNo], 0);
  if botonPulsado = mrNo then
    Exit;

  fech := DataSeTMaestro.FieldByName('fecha_ce').AsString;
  if DataSeTMaestro.Eof then
    posi := 3
  else if DataSeTMaestro.Bof then posi := 1
  else
  begin
    DataSeTMaestro.Prior;
    posi := 2;
  end;
  DataSeTMaestro.Close;
  if DMBaseDatos.QGeneral.Active then DMBaseDatos.QGeneral.Close;
  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add('DELETE FROM frf_cambios_euros ');
    SQL.Add('WHERE fecha_ce=' + SQLDate(fech) + ' ');
    ExecSQL;
  end;
  DataSeTMaestro.Open;
  Registros := Registros - 1;
  registro := Registro - 1;
  case posi of
    1: DataSeTMaestro.First;
    2: begin
        DataSeTMaestro.Locate('fecha_ce', fech, []);
      end;
    3: DataSeTMaestro.Last;
  end;
  Visualizar;

  BEEstado;
  BHEstado;
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMCambioMonedas.Altas;
begin
  raise Exception.Create('Las altas de los cambio se hacen desde X3.');
     // Función
  Estado := teAlta;
  editableFormulario;
  BEEstado;
  BHEstado;
  PanelMaestro.Enabled := True;
  DataSeTMaestro := QCambioMonedas;
  if not DataSetMaestro.Active then DataSeTMaestro.Open;
  DataSeTMaestro.Insert;
  filtrarDetalles;
  if Assigned(FOnInsert) then FOnInsert;
  Self.ActiveControl := FocoAltas;
end;


procedure TFMCambioMonedas.Aceptar;
begin
     // Función
  case Estado of
    teAlta: AceptarAltaCM;
    teLocalizar: AceptarLocalizarCM;
    teModificar: AceptarModificarCM;
  end;
  BCBFecha.Visible := False;
  gridDetalles.Enabled := True;
end;

procedure TFMCambioMonedas.Cancelar;
begin
     // Función
  case Estado of
    teAlta: CancelarAltaCM;
    teLocalizar: CancelarMLCM;
    teModificar: CancelarMLCM;
  end;
  BEEstado;
  BHEstado;
  BHGrupoDesplazamientoMaestro(PCMaestro);
  Visualizar;

  BCBFecha.Visible := False;
  gridDetalles.Enabled := True;
end;

//Aceptar

procedure TFMCambioMonedas.AceptarAltaCM;
var fech: string;
  fec1: string;
  dFecha: TDateTime;
  iAux: integer;
begin
  //No puedo insertar con fecha superior a la de hoy
  dFecha:= Date;
  TryStrToDate( fecha_ce.Text, dFecha );
  if dFecha > Date then
  begin
    raise Exception.Create('No puedo insertar valores con fecha superior a la de hoy.');
  end;
  //Suponemos que no grabaremos nada con fecha inferior de una semana
  dFecha:= Date;
  TryStrToDate( fecha_ce.Text, dFecha );
  if dFecha < ( Date - 7 )then
  begin
    iAux:= Trunc( Date - dFecha );
    if Application.MessageBox( PChar( 'El cambio que va ha grabar es de hace ' +
                               IntToStr( iAux ) + ' dias.' + #13 + #10 +
                               '¿Seguro que quiere continuar?'),
                               'ADVERTENCIA FECHA CAMBIO.', MB_YESNO ) = IDNO then
    begin
      Abort;
    end;
  end;

  fech := SQLDate(fecha_ce.Text);
  fec1 := fecha_ce.Text;
  AnyadirRegistro;
  DataSeTMaestro.Cancel;
  DataSeTMaestro.Close;

  DataSeTMaestro := QCambioMonedasG;
  if DMBaseDatos.QGeneral.Active then DMBaseDatos.QGeneral.Close;
  DMBaseDatos.QGeneral.SQL.Clear;
  DMBaseDatos.QGeneral.SQL.Add('INSERT INTO frf_cambios_euros(fecha_ce,moneda_ce,cambio_ce) ');
  DMBaseDatos.QGeneral.SQL.Add('SELECT ' + fech + ' As Fecha,moneda_m,0 As Cambio FROM frf_monedas ');
  DMBaseDatos.QGeneral.SQL.Add('WHERE moneda_m NOT In (SELECT codigo_e FROM frf_euros) ' +
    'And moneda_m Not Like ' + QuotedStr('EUR'));

  ConsultaExec(DMBaseDatos.QGeneral, True, False);
  DMBaseDatos.QGeneral.Close;
  RegistrosInsertados := RegistrosInsertados + 1;


  DataSeTMaestro := QCambioMonedasG;
  DataSeTMaestro.SQL.Clear;
  DataSeTMaestro.SQL.Add(Select);
  DataSeTMaestro.SQL.Add(Where);
  DataSeTMaestro.SQL.Add(Order);

  try
    AbrirConsulta(DataSeTMaestro);
  except
    Exit;
  end;
  Registros := Registros + 1;
  DataSeTMaestro.Locate('fecha_ce', fec1, []);
  Registro := 1;
  Visualizar;

  BEEstado;
  BHEstado;

end;

procedure TFMCambioMonedas.AceptarModificarCM;
begin
     //Evento antes de modificar
  try
    if Assigned(FOnValidateMasterConstrains) then FOnValidateMasterConstrains;
  except
    on E: Exception do
    begin
      ShowError(E);
      Cancelar;
      Exit;
    end;
  end;

  try
    GrabarDatos(DataSeTMaestro);
  except
    Exit;
  end;

  DataSeTMaestro := QCambioMonedasG;
  Visualizar;

  editableFormulario;
  DataSeTMaestro.GotoBookmark(marcaCabecera);
  DataSeTMaestro.FreeBookmark(marcaCabecera);
  gridDetalles.DataSource.DataSet.GotoBookmark(marcaModify);
  gridDetalles.DataSource.DataSet.FreeBookmark(marcaModify);
  BEEstado;
  BHEstado;
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMCambioMonedas.AceptarLocalizarCM;
begin
  Filtro;
  DataSeTMaestro.Cancel;
  DataSeTMaestro.Close;
  DataSeTMaestro := QCambioMonedasG;
  DataSeTMaestro.SQL.Clear;
  DataSeTMaestro.SQL.Add(Select);
  DataSeTMaestro.SQL.Add(Where);
  DataSeTMaestro.SQL.Add(Order);

  try
    AbrirConsulta(DataSeTMaestro);
  except
    Exit;
  end;
  Registros := DataSeTMaestro.RecordCount;
  Registro := 1;
  Visualizar;

     //Mensaje si no encontramos ningun registro
  if Registros = 0 then
    BEMensajes('No se encontro ningun registro')
  else
    BERegistros;

  editableFormulario;
end;


procedure TFMCambioMonedas.editableFormulario();
begin
  gridDetalles.Enabled := True;
  fechaHasta.Visible := False;
  LDesde.Visible := False;
  LHasta.Visible := False;
  BCBFechaHasta.Visible := False;
  case Estado of
    teLocalizar:
      begin
        fechaHasta.Visible := True;
        LDesde.Visible := True;
        LHasta.Visible := True;
        BCBFechaHasta.Visible := True;
        BCBFecha.Enabled := true;
        BCBFecha.Visible := true;
        fecha_ce.Visible := True;
        fecha_ce.Enabled := True;
        Gfecha_ce.Visible := False;

        fecha_ce.Text := DateToStr(Date);
        fechaHasta.Text := DateToStr(Date);

        STMoneda.Caption := '';
        LMoneda.Visible := False;
        moneda_ce.Visible := False;
        STMoneda.Visible := False;
        LCambio.Visible := False;
        cambio_ce.Visible := False;
        cambio_ce.Enabled := False;
        gridDetalles.Enabled := False
      end;
    teEspera, teConjuntoResultado:
      begin
        BCBFecha.Enabled := true;
        BCBFecha.Visible := false;
        Gfecha_ce.Visible := True;
        fecha_ce.Visible := False;
        fecha_ce.Enabled := False;

        STMoneda.Caption := '';
        LMoneda.Visible := False;
        moneda_ce.Visible := False;
        STMoneda.Visible := False;
        LCambio.Visible := False;
        cambio_ce.Visible := False;
        cambio_ce.Enabled := False;
        gridDetalles.Enabled := True;
        if Self.Visible = True then
          if gridDetalles.CanFocus then
            gridDetalles.SetFocus;
      end;
    teModificar:
      begin
        Gfecha_ce.Visible := False;
        BCBFecha.Visible := False;
        fecha_ce.Visible := True;
        fecha_ce.Enabled := False;
                           // STMoneda.Caption  := '';
        LMoneda.Visible := True;
        moneda_ce.Visible := True;
        STMoneda.Visible := True;
        LCambio.Visible := True;
        cambio_ce.Visible := True;
        cambio_ce.Enabled := True;
        gridDetalles.Enabled := False;
      end;
    teAlta:
      begin
        BCBFecha.Enabled := true;
        BCBFecha.Visible := true;
        Gfecha_ce.Visible := False;
        fecha_ce.Visible := True;
        fecha_ce.Enabled := True;
        LMoneda.Visible := False;
        moneda_ce.Visible := False;
        STMoneda.Visible := False;
        LCambio.Visible := False;
        cambio_ce.Visible := False;
        cambio_ce.Enabled := False;
        gridDetalles.Enabled := False;
      end;
  end;
end;

procedure TFMCambioMonedas.CancelarAltaCM;
begin
  DataSeTMaestro.Cancel;
  DataSeTMaestro.Close;
  DataSetMaestro := QCambioMonedasG;
{
     DataSeTMaestro.Cancel;
     activarDesact (False);
     If RegistrosInsertados<>0 Then
     Begin
          DataSeTMaestro.Close;
          DataSetMaestro := QGastosCabecera;
          DataSeTMaestro.SQL.Clear;
          DataSeTMaestro.SQL.Add(Select);
          if Trim(where)<>'' then
             DataSeTMaestro.SQL.Add(where);
          DataSeTMaestro.SQL.Add(Order);
          DataSeTMaestro.RequestLive := False;
          try
              AbrirConsulta(DataSeTMaestro);
          except
             //Close;
             Registros:=0;
             Registro:=1;
             Visualizar;
             Exit;
          end;
          Registros:=DataSeTMaestro.RecordCount;
          Registro:=1;
     end;
     gridDetalles.Enabled := True;
     gridDetalles.Visible := True;
     Visualizar;
}
end;

procedure TFMCambioMonedas.CancelarMLCM;
begin
  DataSeTMaestro.Cancel;
  DataSetMaestro := QCambioMonedasG;
  if Estado = teModificar then
  begin
    DataSeTMaestro.GotoBookmark(marcaCabecera);
    DataSeTMaestro.FreeBookmark(marcaCabecera);
    gridDetalles.DataSource.DataSet.GotoBookmark(marcaModify);
    gridDetalles.DataSource.DataSet.FreeBookmark(marcaModify);
  end;
  Visualizar;
  editableFormulario;
end;

procedure TFMCambioMonedas.filtrarDetalles();
var condi: string;

begin
// FILTROS DE LOS REGISTROS DEL DETALLE...
  condi := DataSeTMaestro.FieldByName('fecha_ce').AsString;
  if Trim(condi) <> '' then
    condi := 'fecha_ce = ' + SQLDate(condi) + ' '
  else condi := 'fecha_ce = ' + QuotedStr('01/01/1800') + ' ';

  if QCambioMonedasDetalle.Active then
    QCambioMonedasDetalle.Close;
  if QCambioMonedas.Active then
    QCambioMonedas.Close;

  with QCambioMonedasDetalle do
  begin
    SQL.Clear;
    SQL.Add('SELECT fecha_ce, moneda_ce, cambio_ce, descripcion_m ' +
      'FROM frf_cambios_euros Frf_cambios_euros, frf_monedas Frf_monedas ');
    SQL.Add('WHERE (moneda_ce=moneda_m) ' +
      'And ' + condi);
    SQL.Add('ORDER BY fecha_ce, moneda_ce');
    Open;
    First;
  end;
// FILTROS DE LOS REGISTROS DEL DETALLE...
  with QCambioMonedas do
  begin
    SQL.Clear;
    SQL.Add('SELECT fecha_ce, moneda_ce, cambio_ce ' +
      'FROM frf_cambios_euros Frf_cambios_euros ');
    SQL.Add('WHERE ' + condi);
    SQL.Add('ORDER BY fecha_ce, moneda_ce');
    Open;
    First;
  end
end;

procedure TFMCambioMonedas.CambioRegistro;
begin
  filtrarDetalles;
end;


procedure TFMCambioMonedas.gridDetallesDblClick(Sender: TObject);
begin
  Modificar;
end;

procedure TFMCambioMonedas.ARejillaFlotanteExecute(Sender: TObject);
begin

  if ActiveControl.Name = 'fecha_ce' then
  begin
    if fecha_ce.Text <> '' then
      CalendarioFlotante.Date := StrToDate(fecha_ce.Text)
    else CalendarioFlotante.Date := Now;
    CalendarioFlotante.Bcontrol := fecha_ce;
    BCBFecha.CalendarShow;
  end
  else
  begin
    if FechaHasta.Text <> '' then
      CalendarioFlotante.Date := StrToDate(FechaHasta.Text)
    else CalendarioFlotante.Date := Now;
    CalendarioFlotante.Bcontrol := FechaHasta;
    BCBFechaHasta.CalendarShow;
  end;
end;

function TFMCambioMonedas.filtrarFecha(): string;
var fec1, fec2: string;
begin
  filtrarFecha := '';
  fec1 := Trim(fecha_ce.Text);
  if (fechaHasta.Visible = True) then fec2 := Trim(fechaHasta.Text);

  if ((fec1 <> '') and (fec2 <> '')) then
    filtrarFecha := '(fecha_ce BETWEEN ' + SQLDate(fec1) +
      ' And ' + SQLDate(fec2) + ') '
  else
  begin
    if ((fec1 <> '') and (fec2 = '')) then
      filtrarFecha := '(fecha_ce = ' + SQLDate(fec1) + ') '
    else if ((fec1 = '') and (fec2 <> '')) then
      filtrarFecha := '(fecha_ce = ' + SQLDate(fec2) + ') '

  end;

end;

procedure TFMCambioMonedas.SBAceptarClick(Sender: TObject);
begin
  aceptarImprimir := TRUE;

  case RGTipo.ItemIndex of
    0: tipInf := 'D';
    1: tipInf := 'E';
    2: tipInf := 'P';
  end;

  PTipoListado.Visible := FALSE;
  PMaestro.Enabled := TRUE;
  gridDetalles.Enabled := TRUE;
  Prev;
end;

procedure TFMCambioMonedas.SBCancelarClick(Sender: TObject);
begin
  FPrincipal.TBBarraMaestro.Enabled := TRUE;
  aceptarImprimir := FALSE;
  PMaestro.Enabled := TRUE;
  gridDetalles.Enabled := TRUE;
  PTipoListado.Visible := False;
end;

procedure TFMCambioMonedas.Prev();
var cadWhere: string;
begin
     // Previsualizar...
  FPrincipal.TBBarraMaestro.Enabled := TRUE;
  try
    if DMBaseDatos.QListado.Active then
      DMBaseDatos.QListado.Close;

    with DMBaseDatos.QListado.SQL do
    begin
      Clear;
      Add('SELECT fecha_ce ' +
        'FROM frf_cambios_euros Frf_cambios_euros ');
      if Trim(Where) <> '' then
      begin
        cadWhere := 'WHERE ' + Copy(Where, 9, length(Where));
        Add(cadWhere);
      end;
      Add('GROUP BY fecha_ce ');
      Add('ORDER BY fecha_ce');
    end;

    DMBaseDatos.QListado.Open;
    QRLCambioDivisas := TQRLCambioDivisas.Create(Application);
    QRLCambioDivisas.tipoList := tipInf;
    if tipInf = 'D' then
      QRLCambioDivisas.QRTitulo.Caption := 'CAMBIO DE MONEDAS (Importe en Divisas)'
    else
      if tipInf = 'E' then
        QRLCambioDivisas.QRTitulo.Caption := 'CAMBIO DE MONEDAS (Importe en Euros)'
      else
        if tipInf = 'P' then
          QRLCambioDivisas.QRTitulo.Caption := 'CAMBIO DE MONEDAS (Importe en Pesetas)';
    PonLogoGrupoBonnysa(QRLCambioDivisas);
    Preview(QRLCambioDivisas);
  finally
    DMBaseDatos.QListado.Close;
  end;
end;

end.
