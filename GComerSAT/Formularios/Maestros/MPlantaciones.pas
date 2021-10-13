unit MPlantaciones;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, BGrid, BDEdit,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, ComCtrls, BCalendario,
  BCalendarButton, BEdit, DError, DBTables, ADODB;

type
  TFMPlantaciones = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    Bevel1: TBevel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    LEstructura_p: TLabel;
    estructura_p: TBDEdit;
    BGBEstructura_p: TBGridButton;
    BGBTipo_cultivo_p: TBGridButton;
    tipo_cultivo_p: TBDEdit;
    LTipo_cultivo_p: TLabel;
    LTipo_sustrato_p: TLabel;
    tipo_sustrato_p: TBDEdit;
    BGBTipo_sustrato_p: TBGridButton;
    BGBVariedad_p: TBGridButton;
    variedad_p: TBDEdit;
    LVariedad_p: TLabel;
    Bevel2: TBevel;
    STEstructura_p: TStaticText;
    STTipo_cultivo_p: TStaticText;
    STTipo_sustrato_p: TStaticText;
    STVariedad_p: TStaticText;
    LPlantacion_p: TLabel;
    plantacion_p: TBDEdit;
    descripcion_p: TBDEdit;
    LDescripcion_p: TLabel;
    LFecha_inicio_p: TLabel;
    fecha_inicio_p: TBDEdit;
    BCBFecha_inicio_p: TBCalendarButton;
    LEmpresa_p: TLabel;
    empresa_p: TBDEdit;
    BGBEmpresa_p: TBGridButton;
    BGBProducto_p: TBGridButton;
    producto_p: TBDEdit;
    LProducto_p: TLabel;
    LCosechero_p: TLabel;
    cosechero_p: TBDEdit;
    BGBCosechero_p: TBGridButton;
    STEmpresa_p: TStaticText;
    STProducto_p: TStaticText;
    STCosechero_p: TStaticText;
    Label13: TLabel;
    ano_semana_p: TBDEdit;
    LAno_semana_p: TLabel;
    Bevel3: TBevel;
    LSuperficie_p: TLabel;
    LPlantas_p: TLabel;
    plantas_p: TBDEdit;
    superficie_p: TBDEdit;
    ACampos: TAction;
    SBCampos: TSpeedButton;
    CalendarioFlotante: TBCalendario;
    BCBFecha_fin_p: TBCalendarButton;
    fecha_fin_p: TBDEdit;
    Label1: TLabel;
    QPlantaciones: TQuery;
    Label2: TLabel;
    agrupacion_p: TBDEdit;
    Button1: TButton;
    Label3: TLabel;
    STFederacion: TStaticText;
    federacion_p: TBDEdit;
    BGBFederacion: TBGridButton;
    pnlPasarSGP: TPanel;
    Label4: TLabel;
    fecha_ini_planta_p: TBDEdit;
    btnFechaIniPlanta: TBCalendarButton;
    pnlFito: TPanel;
    ds1: TDataSource;
    sec_contable_p: TBDEdit;
    lbl1: TLabel;
    btnSeccion: TBGridButton;
    txtSeccion: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure ACamposExecute(Sender: TObject);
    procedure SalirEdit(Sender: TObject);
    procedure EntrarEdit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure federacion_pChange(Sender: TObject);
    procedure pnlPasarSGPClick(Sender: TObject);
    procedure DSMaestroStateChange(Sender: TObject);
    procedure pnlFitoClick(Sender: TObject);
    procedure sec_contable_pChange(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    function  FederacionCosechero( const AEmpresa, ACosechero: string ): string;

  public
    { Public declarations }
    procedure Borrar; override;
    procedure BorrarPlantacion;
    procedure Filtro; override;
    function  GetFiltro( var AFiltro: string ): Boolean; override;
    
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;

    procedure MiAlta;
    procedure Altas; override;
    procedure Modificar; override;
    procedure Clonar;
    procedure BuscarPlantacion( const AEmpresa, AProducto, ACosechero, APlantacion, AAnySemana: string );
    procedure GetPlantacionBDRemota( const ABDRemota: string; const AAlta: Boolean );
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  LPlantaciones, CAuxiliarDB, Principal, MCampos,
  DPreview, UDMAuxDB, bSQLUtils, LAgrupaPrecalibrado, GetFiltroFM, UComerToSgpDM,
  UDMConfig, SeleccionarAltaClonarFD,  ImportarPlantacionesFD, AdvertenciaFD,
  ComerToFitosanitarios, CGlobal;

var
  FMGetFiltro: TFMGetFiltro;

{$R *.DFM}

procedure TFMPlantaciones.AbrirTablas;
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
  Registros := DataSetMaestro.RecordCount;
  if registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMPlantaciones.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMPlantaciones.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QPlantaciones;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_plantaciones ';
 {+}where := ' WHERE empresa_p=' + QuotedStr('###');
 {+}Order := ' ORDER BY ano_semana_p, empresa_p, producto_p, cosechero_p, plantacion_p ';
      //Abrir tablas/Querys
  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Close;
      Exit;
    end;
  end;

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
  empresa_p.Tag := kEmpresa;
  producto_p.Tag := kProducto;
  cosechero_p.Tag := kCosechero;
  tipo_sustrato_p.Tag := kSustrato;
  estructura_p.Tag := kEstructura;
  variedad_p.Tag := kVariedad;
  tipo_cultivo_p.Tag := kCultivo;
  federacion_p.Tag := kFederacion;
  fecha_ini_planta_p.tag := kCalendar;
  fecha_inicio_p.tag := kCalendar;
  fecha_fin_p.tag := kCalendar;
  sec_contable_p.Tag:= kSeccionContable;
     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeInsertar;
  OnView := AntesDeVisualizar;
     //Focos
 {+}FocoAltas := ano_semana_p;
 {+}FocoModificar := descripcion_p;
 {+}FocoLocalizar := ano_semana_p;
     //Inicializar variables
  CalendarioFlotante.Date := Date;

  FMGetFiltro:= InicializarFiltro ( self );
  FMGetFiltro.Configurar('Filtrar Plantaciones', 0);
  FMGetFiltro.AddChar('empresa_p', 'Empresa', 3, True );
  FMGetFiltro.AddChar('producto_p', 'Producto', 1, false );
  FMGetFiltro.AddInteger('cosechero_p', 'Cosechero', 3, False );
  FMGetFiltro.AddInteger('plantacion_p', 'Plantación', 3, False );
  FMGetFiltro.AddChar('ano_semana_p', 'Año/Semana', 9, false );
  FMGetFiltro.AddChar('descripcion_p', 'Descripción', 90, false );
  FMGetFiltro.AddDate('fecha_ini_planta_p', 'Inicio Plantación', false );
  FMGetFiltro.AddDate('fecha_inicio_p', 'Inicio Recolección', false );
  FMGetFiltro.AddDate('fecha_fin_p', 'Fin Recolección', false );
  FMGetFiltro.AddInteger('federacion_p', 'Federación', 1, false );
  FMGetFiltro.AddReal('superficie_p', 'Superficie', 6, 2, false );
  FMGetFiltro.AddInteger('plantas_p', 'Plantas', 7, false );
  FMGetFiltro.AddChar('estructura_p', 'Estructura', 2, false );
  FMGetFiltro.AddChar('tipo_cultivo_p', 'Tipo Cultivo', 2, false );
  FMGetFiltro.AddChar('tipo_sustrato_p', 'Tipo Sustrato', 2, false );
  FMGetFiltro.AddChar('variedad_p', 'Variedad', 2, false );

  Filtrado:= False;
  if CGlobal.gProgramVersion = CGlobal.pvSAT then
  begin
    pnlPasarSGP.Visible:= DMConfig.EsLosLLanos or DMConfig.EsLaFontEx;
    pnlFito.Visible:= DMConfig.EsLaFont;
  end
  else
  begin
    pnlPasarSGP.Visible:= False;
    pnlFito.Visible:= False;
  end;
end;

procedure TFMPlantaciones.FormActivate(Sender: TObject);
begin
  Top := 1;
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;

     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
     //Barra de estado y barra de herramientas
  BEEstado;
  BHEstado;
  Enabled := True;
end;


procedure TFMPlantaciones.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;
end;

procedure TFMPlantaciones.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinalizarFiltro( FMGetFiltro );

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
  gCF := nil;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMPlantaciones.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

{*}//Si  el calendario esta desplegado no hacemos nada
  if (CalendarioFlotante <> nil) then
    if (CalendarioFlotante.Visible) then
            //No hacemos nada
      Exit;

    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que concuerdan
//con los capos que hemos rellenado

procedure TFMPlantaciones.Filtro;
var Flag: Boolean;
  i: Integer;
begin
  where := ''; Flag := false;
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Trim(Text) <> '' then
        begin
          if flag then where := where + ' and ';
          if InputType = itChar then
            where := where + ' ' + name + ' LIKE ' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + SQLNumeric(Text);
          flag := True;
        end;
      end;
    end;
  end;
  if flag then where := ' WHERE ' + where;

  (*
  //Auditoria
  where:= ' where empresa_p = ''050'' ' +#13 + #10 +
          ' and ( cosechero_p = 51  ) ' +#13 + #10 +
          ' and ( fecha_fin_p > ''1/7/2007'' or fecha_fin_p is null ) ';
  (**)
end;

function TFMPlantaciones.GetFiltro( var AFiltro: string ): boolean;
begin
   result:= FMGetFiltro.Filtro( AFiltro );
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMPlantaciones.AnyadirRegistro;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';

  for i := 0 to Lista.Count - 1 do
  begin
    objeto := Lista.Items[i];
    if (objeto is TBDEdit) then
    begin
      with objeto as TBDEdit do
      begin
        if PrimaryKey and (Trim(Text) <> '') then
        begin
          if flag then where := where + ' and ';
          if InputType = itChar then
            where := where + ' ' + name + ' =' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + Text;
          flag := True;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;


//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required

procedure TFMPlantaciones.ValidarEntradaMaestro;
var
  aux: Integer;
begin
  //Comprobar Año/semana
  if (length(ano_semana_p.Text) < 6) then
  begin
    ano_semana_p.SetFocus;
    raise Exception.Create('El año y la semana de la plantacion debe ser de 6 dígitos.');
  end;
  //Comprobar que las dos ultimas cifras del año_semana esten entre 00-53
  aux := StrToInt(Copy(ano_semana_p.Text, 5, 2));
  if (aux < 0) and (aux > 53) then
  begin
    ano_semana_p.SetFocus;
    raise Exception.Create('Las dos últimas cifras del año y la semana de la plantacion deben estar entre 00 y 53 ambos incluidos.');
  end;

  if STEmpresa_p.Caption = '' then
  begin
    empresa_p.SetFocus;
    raise Exception.Create('Falta o código de empresa incorrecto.');
  end;
  if STProducto_p.Caption = '' then
  begin
    producto_p.SetFocus;
    raise Exception.Create('Falta o código de producto incorrecto.');
  end;
  if STCosechero_p.Caption = '' then
  begin
    cosechero_p.SetFocus;
    raise Exception.Create('Falta o código de cosechero incorrecto.');
  end;
  if plantacion_p.Text = '' then
  begin
    plantacion_p.SetFocus;
    raise Exception.Create('Falta el código de la plantación.');
  end;
  if agrupacion_p.Text = '' then
  begin
    agrupacion_p.Text:= '0';
  end;
  if descripcion_p.Text = '' then
  begin
    descripcion_p.SetFocus;
    raise Exception.Create('Falta la descripción de la plantación.');
  end;

  if fecha_ini_planta_p.Text = '' then
  begin
    fecha_ini_planta_p.SetFocus;
    raise Exception.Create('Falta la fecha de inicio de la plantación.');
  end;

  if fecha_inicio_p.Text = '' then
  begin
    fecha_inicio_p.SetFocus;
    raise Exception.Create('Falta la fecha de inicio de recolección de la plantación.');
  end;
  if STFederacion.Caption = '' then
  begin
    federacion_p.SetFocus;
    raise Exception.Create('Falta o código de federación incorrecto.');
  end;
  if superficie_p.Text = '' then
  begin
    superficie_p.Text:= '1';
  end;
  if plantas_p.Text = '' then
  begin
    plantas_p.Text:= '1';
  end;
  if STEstructura_p.Caption = '' then
  begin
    estructura_p.SetFocus;
    raise Exception.Create('Falta o código de estructura de la plantación incorrecto.');
  end;
  if STTipo_cultivo_p.Caption = '' then
  begin
    tipo_cultivo_p.SetFocus;
    raise Exception.Create('Falta o código del tipo de cultivo de la plantación incorrecto.');
  end;
  if STTipo_sustrato_p.Caption = '' then
  begin
    tipo_sustrato_p.SetFocus;
    raise Exception.Create('Falta o código del tipo de sustrato de la plantación incorrecto.');
  end;
  if STVariedad_p.Caption = '' then
  begin
    variedad_p.SetFocus;
    raise Exception.Create('Falta o código de la variedad de la plantación incorrecto.');
  end;
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMPlantaciones.Previsualizar;
begin
     //Crear el listado
  try
    with DMBaseDatos.QListado do
    begin
      if Active then
      begin
        Cancel;
        Close;
      end;
      SQL.Clear;
      SQL.Add(' SELECT *, ( select nombre_c from frf_cosecheros where (empresa_p = empresa_c) and (cosechero_p = cosechero_c) ) nombre_c' +
        ' FROM frf_plantaciones ');
(*
  where:= 'where empresa_p = ''050'' ' + #13 + #10 +
' and ( cosechero_p = 1 and producto_p in (''R'',''Q'',''T'') ' +  #13 + #10 +
'  and ( ( fecha_inicio_p between ''03/07/2006'' and ''01/07/2007'' ) ' +#13 + #10 +
'      or ( fecha_fin_p between ''03/07/2006'' and ''01/07/2007'' ) ) ' +#13 + #10 +
' ) ' +#13 + #10 +
' or ( cosechero_p = 100 and producto_p in (''E'',''Q'') ' +#13 + #10 +
'  and ( ( fecha_inicio_p between ''03/07/2006'' and ''01/07/2007'' ) ' +#13 + #10 +
'      or ( fecha_fin_p between ''03/07/2006'' and ''01/07/2007'' ) ) ' +#13 + #10 +
' ) ';
*)
(*
      where:= 'where empresa_p = ''050'' and cosechero_p = 2 ' + #13 + #10 +
              '  and fecha_inicio_p <= ''31/03/2011'' and ( fecha_fin_p >= ''01/04/2010'' or fecha_fin_p is NULL ) ';
*)
      SQL.Add(where );
      SQL.Add(order);
      try
        Open;
        RecordCount;
      except
        MessageDlg('Error al crear el listado.', mtError, [mbOK], 0);
        Exit;
      end;
    end;
    QRLPlantaciones := TQRLPlantaciones.Create(Application);
    PonLogoGrupoBonnysa(QRLPlantaciones);
    QRLPlantaciones.DataSet := DMBaseDatos.QListado;
    Preview(QRLPlantaciones);
  finally
    DMBaseDatos.QListado.Close;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar rejilla flotante (Formulario)
//   - Borrar Lista de acciones(Formulario)
//   - Borrar las funciones de esta seccion(Codigo)
//*****************************************************************************
//*****************************************************************************

procedure TFMPlantaciones.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_p);
    kProducto: DespliegaRejilla(BGBProducto_p, [empresa_p.Text]);
    kCosechero: DespliegaRejilla(BGBCosechero_p, [empresa_p.Text]);
    kEstructura: DespliegaRejilla(BGBEstructura_p);
    kCultivo: DespliegaRejilla(BGBTipo_cultivo_p);
    kSustrato: DespliegaRejilla(BGBTipo_sustrato_p);
    kVariedad: DespliegaRejilla(BGBVariedad_p);
    kFederacion: DespliegaRejilla(BGBFederacion);
    kSeccionContable: DespliegaRejilla(btnSeccion, [empresa_p.Text]);
    kCalendar:
      if Fecha_ini_planta_p.Focused then
        DespliegaCalendario(btnFechaIniPlanta)
      else
      if Fecha_inicio_p.Focused then
        DespliegaCalendario(BCBFecha_inicio_p)
      else
        DespliegaCalendario(BCBFecha_fin_p);
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMPlantaciones.AntesDeInsertar;
begin
    //Deshabilitamos boton
  SBCampos.Enabled := false;
  if Estado = teAlta then
    empresa_p.Text:= gsDefEmpresa;
end;
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMPlantaciones.AntesDeModificar;
var i: Integer;
begin
    //Deshabilitamos boton
  SBCampos.Enabled := false;
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

procedure TFMPlantaciones.AntesDeVisualizar;
var i: Integer;
begin
    //Habilitamos boton
  SBCampos.Enabled := true;

    //Resaturamos estado controles
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;
  STCosechero_p.Caption := desCosechero(empresa_p.Text, cosechero_p.Text);
  STProducto_p.Caption := desProducto(empresa_p.Text, producto_p.Text);
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

function TFMPlantaciones.FederacionCosechero( const AEmpresa, ACosechero: string ): string;
begin
  if Trim( ACosechero ) <> '' then
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('select federacion_c from frf_cosecheros ');
      SQL.Add('where empresa_c = :empresa ');
      SQL.Add('  and cosechero_c = :cosechero ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('cosechero').AsInteger:= StrToInt( ACosechero );
      try
        Open;
        result:= FieldByName('federacion_c').AsString;
      finally
        Close;
      end;
    end
  else
  begin
    result:= '';
  end;
end;

procedure TFMPlantaciones.PonNombre(Sender: TObject);
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
      STEmpresa_p.Caption := desEmpresa(empresa_p.Text);
      PonNombre( cosechero_p );
      PonNombre( producto_p );
      sec_contable_pChange( sec_contable_p );
    end;
    kCosechero:
    begin
      STCosechero_p.Caption := desCosechero(empresa_p.Text, cosechero_p.Text);
      if ( Estado = teAlta ) and ( STCosechero_p.Caption <> '' ) then
        federacion_p.Text:= FederacionCosechero( empresa_p.Text, cosechero_p.Text );
    end;
    kProducto: STProducto_p.Caption :=
      desProducto(empresa_p.Text, producto_p.Text);
    kEstructura: STEstructura_p.Caption := desCampo('ESTRUCTURA', estructura_p.Text);
    kSustrato: STTipo_sustrato_p.Caption := desCampo('SUSTRATO', tipo_sustrato_p.Text);
    kCultivo: STTipo_cultivo_p.Caption := desCampo('CULTIVO', tipo_cultivo_p.Text);
    kVariedad: STVariedad_p.Caption := desCampo('VARIEDAD', variedad_p.Text);
  end;
end;

//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMPlantaciones.RequiredTime(Sender: TObject;
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

//*****************************************************************
//MANTENIMIENTO DE CAMPOS
//*****************************************************************

procedure TFMPlantaciones.ACamposExecute(Sender: TObject);
begin
  TFMCampos.Create(Self);
  self.Enabled := false;
end;

procedure TFMPlantaciones.SalirEdit(Sender: TObject);
begin
  BEMensajes('');
end;

procedure TFMPlantaciones.EntrarEdit(Sender: TObject);
begin
  BEMensajes(TEdit(Sender).Hint);
end;


procedure TFMPlantaciones.BorrarPlantacion;
begin
  //Comprobar que no tenga datos
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select count(*) from frf_entradas2_l ');
    SQL.Add(' where empresa_e2l ' + SQLEqualS(empresa_p.Text));
    SQL.Add('   and producto_e2l ' + SQLEqualS(producto_p.Text));
    SQL.Add('   and cosechero_e2l ' + SQLEqualN(cosechero_p.Text));
    SQL.Add('   and plantacion_e2l ' + SQLEqualS(plantacion_p.Text));
    SQL.Add('   and ano_sem_planta_e2l ' + SQLEqualS(ano_semana_p.Text));

    try
      Open;
    except
      raise Exception.Create(' Error al comprobar la existencia de entradas.');
    end;
    if Fields[0].AsInteger <> 0 then
    begin
      raise Exception.Create(' No se puede borrar una plantación con entradas asociadas.');
    end;
    Close;
  end;

  QPlantaciones.Delete;
  if Registro = Registros then Registro := Registro - 1;
  Registros := Registros - 1;
end;

procedure TFMPlantaciones.Borrar;
var botonPulsado: Word;
begin
  //Barra estado
  botonPulsado := MessageDlg('¿Desea borrar la plantación seleccionada?',
    mtConfirmation, [mbYes, mbNo], 0);
  if botonPulsado = mrYes then
  try
    BorrarPlantacion;
  except
    on E: EDBEngineError do
    begin
      ShowError(e);
    end;
  end;

  //Por ultimo visualizamos resultado
  Visualizar;
end;

procedure TFMPlantaciones.Button1Click(Sender: TObject);
var
  qrpAgrupaPrecalibrado: TqrpAgrupaPrecalibrado;
  empresa, productos: string;
begin
  qrpAgrupaPrecalibrado := TqrpAgrupaPrecalibrado.Create(nil);
  try
    with qrpAgrupaPrecalibrado, DMBaseDatos do
    begin
      empresa := '050';
      InputQuery('LISTADO AGRUPACIÓN DE PRECALIBRADO.', 'Introduce código empresa', empresa);
      PonLogoGrupoBonnysa(qrpAgrupaPrecalibrado, empresa);

      productos := 'T,E,M,R,Q,C';
      InputQuery('LISTADO AGRUPACIÓN DE PRECALIBRADO.', 'Introduce lista productos. (vacio lista todos)', productos);

      QListado.Databasename := 'BDProyecto';
      QListado.SQL.Clear;
      QListado.SQL.Add(' select pl.empresa_p, pl.cosechero_p, co.nombre_c, ');
      QListado.SQL.Add('        pl.plantacion_p, pl.descripcion_p, ');
      QListado.SQL.Add('        pl.agrupacion_p, pl.producto_p, pr.descripcion_p, ');
      QListado.SQL.Add('        pl.variedad_p, ca.descripcion_c, pl.fecha_inicio_p, pl.fecha_ini_planta_p ');

      QListado.SQL.Add(' from frf_plantaciones pl, frf_cosecheros co, ');
      QListado.SQL.Add('      frf_productos pr, frf_campos ca ');

      QListado.SQL.Add(' where pl.empresa_p ' + SQLEQualS(empresa));
      if Trim(productos) <> '' then
      begin
        QListado.SQL.Add(' and pl.producto_p in (' +
          StringReplace(QuotedStr(productos), ',', QuotedStr(','), [rfReplaceAll, rfIgnoreCase]) + ')');
      end;
      QListado.SQL.Add(' and pl.fecha_fin_p is null ');
      QListado.SQL.Add(' and pl.fecha_inicio_p is not null ');

      QListado.SQL.Add(' and co.empresa_c ' + SQLEQualS(empresa));
      QListado.SQL.Add(' and co.cosechero_c = pl.cosechero_p ');

      QListado.SQL.Add(' and pr.producto_p = pl.producto_p ');

      QListado.SQL.Add(' and ca.campo_c ' + SQLEQualS('VARIEDAD'));
      QListado.SQL.Add(' and ca.tipo_c = pl.variedad_p ');

      QListado.SQL.Add(' order by pl.empresa_p, pl.cosechero_p, pl.agrupacion_p, ');
      QListado.SQL.Add('          pl.producto_p, pl.plantacion_p ');

      QListado.Open;

      Dpreview.Preview(qrpAgrupaPrecalibrado);
      QListado.Close;
    end;
  except
    freeandnil(qrpAgrupaPrecalibrado);
    raise;
  end;
end;

procedure TFMPlantaciones.federacion_pChange(Sender: TObject);
begin
  STFederacion.Caption:= desFederacion( federacion_p.Text );
end;

procedure TFMPlantaciones.pnlPasarSGPClick(Sender: TObject);
begin
  if not QPlantaciones.IsEmpty and (QPlantaciones.State = dsBrowse) then
  begin
    //Copiar envase en el SGP
    if UComerToSgpDM.PasarPlantacion( empresa_p.Text, producto_p.Text, cosechero_p.Text, plantacion_p.Text, ano_semana_p.Text ) then
    begin
      ShowMessage('Programa finalizado con éxito.');
    end
    else
    begin
      ShowMessage('Error al pasar al SGP la plantación seleccionada.');
    end;
  end;
end;

procedure TFMPlantaciones.DSMaestroStateChange(Sender: TObject);
begin
  if not QPlantaciones.IsEmpty and (QPlantaciones.State = dsBrowse) then
  begin
    pnlPasarSGP.Font.Color := clBlue;
    pnlFito.Font.Color := clBlue;
  end
  else
  begin
    pnlPasarSGP.Font.Color := clGray;
    pnlFito.Font.Color := clGray;
  end;
end;


procedure TFMPlantaciones.MiAlta;
var
  iTipo: Integer;
begin
  if QPlantaciones.IsEmpty then
  begin
    inherited Altas;
  end
  else
  begin
    if Estado <> teAlta then
    begin
      if SeleccionarAltaClonarFD.SeleccionarTipoAlta( Self, iTipo ) = mrOk then
      begin
        if iTipo = 0 then
        begin
          inherited Altas;
        end
        else
        begin
          Clonar;
        end;
      end;
    end
    else
    begin
      Clonar;
    end;
  end;
end;

procedure TFMPlantaciones.BuscarPlantacion( const AEmpresa, AProducto, ACosechero, APlantacion, AAnySemana: string );
begin
 {+}Select := ' select * from frf_plantaciones ';
 {+}where := ' WHERE empresa_p=' + QuotedStr(AEmpresa) +
             ' and producto_p=' + QuotedStr(AProducto) +
             ' and cosechero_p=' + QuotedStr(ACosechero) +
             ' and plantacion_p=' + QuotedStr(APlantacion) +
             ' and ano_semana_p=' + QuotedStr(AAnySemana);
 {+}Order := ' ORDER BY empresa_p, producto_p, cosechero_p, plantacion_p, ano_semana_p';

 QPlantaciones.Close;
 AbrirTablas;
 Visualizar;
end;

procedure TFMPlantaciones.GetPlantacionBDRemota( const ABDRemota: string; const AAlta: Boolean );
var
  sEmpresa, sProducto, sCosechero, sPlantacion, sAnySemana: string;
  iValue: Integer;
begin
  sEmpresa:= empresa_p.Text;
  if AAlta then
  begin
    sProducto:= '';
    sCosechero:= '';
    sPlantacion:= '';
    sAnySemana:= '';
  end
  else
  begin
    sProducto:= producto_p.Text;;
    sCosechero:= cosechero_p.Text;;
    sPlantacion:= plantacion_p.Text;;
    sAnySemana:= ano_semana_p.Text;;
  end;

  iValue:= ImportarPlantacion( Self, ABDRemota, sEmpresa, sProducto, sCosechero, sPlantacion, sAnySemana );
  case iValue of
      -1: //Operacion cancelada
          begin end;
       1: begin
            BuscarPlantacion( sEmpresa, sProducto, sCosechero, sPlantacion, sAnySemana );
          end;
       else ShowMessage('Error ' + IntToStr( iValue ) + ' al importar la plantación.');
  end;
end;

procedure TFMPlantaciones.Modificar;
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited Modificar;
  end
  else
  begin
    //inherited Modificar;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetPlantacionBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Cualquier cambio que realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer modificaciones locales', 'Modificar Envase') = mrIgnore then
        inherited Modificar;
    end;
  end;
end;

procedure TFMPlantaciones.Altas;
begin
  if DMConfig.EsLaFontEx then
  begin
    MiAlta;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetPlantacionBDRemota( 'BDCentral', True );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Envase') = mrIgnore then
        MiAlta;
    end;
  end;
end;

procedure TFMPlantaciones.Clonar;
var
  sempresa, sproducto, scosechero, sano_semana, splantacion, sdescripcion, sfecha_inicio, splantas, ssuperficie,
  sfecha_fin, sagrupacion, sfederacion, sestructura, stipo_cultivo, stipo_sustrato, svariedad, sfecha_ini_planta: string;
begin
  sempresa:= empresa_p.Text;
  sproducto:= producto_p.Text;
  scosechero:= cosechero_p.Text;
  sano_semana:= ano_semana_p.Text;
  splantacion:= plantacion_p.Text;
  sdescripcion:= descripcion_p.Text;

  sfecha_ini_planta:= fecha_ini_planta_p.Text;
  sfecha_inicio:= fecha_inicio_p.Text;
  splantas:= plantas_p.Text;
  ssuperficie:= superficie_p.Text;
  sfecha_fin:= fecha_fin_p.Text;
  sagrupacion:= agrupacion_p.Text;
  sfederacion:= federacion_p.Text;

  sestructura:= estructura_p.Text;
  stipo_cultivo:= tipo_cultivo_p.Text;
  stipo_sustrato:= tipo_sustrato_p.Text;
  svariedad:= variedad_p.Text;

  inherited Altas;

  empresa_p.Text:= sempresa;
  producto_p.Text:= sproducto;
  cosechero_p.Text:= scosechero;
  ano_semana_p.Text:= sano_semana;
  plantacion_p.Text:= splantacion;
  descripcion_p.Text:= sdescripcion;

  fecha_ini_planta_p.Text:= sfecha_ini_planta;
  fecha_inicio_p.Text:= sfecha_inicio;
  plantas_p.Text:= splantas;
  superficie_p.Text:= ssuperficie;
  fecha_fin_p.Text:= sfecha_fin;
  agrupacion_p.Text:= sagrupacion;
  federacion_p.Text:= sfederacion;

  estructura_p.Text:= sestructura;
  tipo_cultivo_p.Text:= stipo_cultivo;
  tipo_sustrato_p.Text:= stipo_sustrato;
  variedad_p.Text:= svariedad;
end;

procedure TFMPlantaciones.pnlFitoClick(Sender: TObject);
begin
  if not QPlantaciones.IsEmpty and (QPlantaciones.State = dsBrowse) then
  begin
    if fecha_ini_planta_p.Text = '' then
    begin
      ShowMessage('ATENCION: Falta la fecha de inicio de plantación.');
    end;
    //Copiar envase en el SGP
    if ComerToFitosanitarios.Sincronizar( empresa_p.Text, producto_p.Text, cosechero_p.Text, plantacion_p.Text, ano_semana_p.Text ) then
    begin
      ShowMessage('Programa finalizado con éxito.');
    end
    else
    begin
      ShowMessage('Error al pasar al programa de Fitosanitarios la plantación seleccionada.');
    end;
  end;
end;

procedure TFMPlantaciones.sec_contable_pChange(Sender: TObject);
begin
  txtSeccion.Caption:= desSeccionContable( empresa_p.Text, sec_contable_p.Text );
end;

end.
