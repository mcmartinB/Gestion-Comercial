unit UFMDestrioDiario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables,
  DError, DBCtrls;

type
  TFMDestrioDiario = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    empresa_de: TBDEdit;
    BGBEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    centro_de: TBDEdit;
    RejillaFlotante: TBGrid;
    QDestrioDiario: TQuery;
    BGBCentro: TBGridButton;
    stCentro: TStaticText;
    CalendarioFlotante: TBCalendario;
    LFecha: TLabel;
    fecha_de: TBDEdit;
    BCBFecha: TBCalendarButton;
    lblNombre1: TLabel;
    unidades_de: TBDEdit;
    lblNombre2: TLabel;
    producto_de: TBDEdit;
    BGBProducto: TBGridButton;
    stProducto: TStaticText;
    destrio_de: TBDEdit;
    unidad_de: TBDEdit;
    lblNombre3: TLabel;
    cbxUnidad: TComboBox;
    lblNombre6: TLabel;
    lblNombre7: TLabel;
    lblNombre8: TLabel;
    DBGMaestro: TDBGrid;
    QDestrioDiarioempresa_de: TStringField;
    QDestrioDiariocentro_de: TStringField;
    QDestrioDiarioproducto_de: TStringField;
    QDestrioDiariofecha_de: TDateField;
    QDestrioDiariounidad_de: TStringField;
    QDestrioDiariounidades_de: TFloatField;
    QDestrioDiariodestrio_de: TFloatField;
    QDestrioDiarioporcentaje_de: TFloatField;
    DBText1: TDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure centro_deChange(Sender: TObject);
    procedure empresa_deChange(Sender: TObject);
    procedure producto_deChange(Sender: TObject);
    procedure unidad_deChange(Sender: TObject);
    procedure cbxUnidadChange(Sender: TObject);
    procedure QDestrioDiarioCalcFields(DataSet: TDataSet);

  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeLocalizar;    
    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes, bMath,
  CAuxiliarDB, Principal, UQRDestrioDiario, DPreview, bSQLUtils, UDMConfig;

{$R *.DFM}

procedure TFMDestrioDiario.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  try
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DataSetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      raise Exception.Create('No puedo abrir la tabla de cabecera.');
    end;
  end;

     //Estado inicial
  Registro := 1;
  Registros := 0;
  //Registros := DataSetMaestro.RecordCount;
  RegistrosInsertados := 0;
end;

procedure TFMDestrioDiario.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(DataSetMaestro);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMDestrioDiario.FormCreate(Sender: TObject);
begin

  M := self;
  MD := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PanelMaestro.Visible := false; {Hasta que no tengamos los datos}

     //Fuente de datos maestro
 {+}DataSetMaestro := QDestrioDiario;

  //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_destrio_entregas ';
 {+}where := ' WHERE empresa_de=' + QUOTEDSTR('###');
 {+}Order := ' ORDER BY empresa_de, centro_de, fecha_de desc, producto_de ';


  //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

  //Asignamos constantes a los componentes que los tienen
  //para facilitar distingirlos
  empresa_de.Tag := kEmpresa;
  centro_de.Tag:= kCentro;
  producto_de.Tag:= kProducto;
  fecha_de.Tag:= kCalendar;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnBrowse := AntesDeLocalizar;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_de;
  {+}FocoModificar := unidades_de;
  {+}FocoLocalizar := empresa_de;

  //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gCF := CalendarioFlotante;
  CalendarioFlotante.Date:= Date;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
  end;
     //Desplegar(Self,439);
  if PanelMaestro.Visible = false then
    PanelMaestro.Visible := true;

end;

{+ CUIDADIN }


procedure TFMDestrioDiario.FormActivate(Sender: TObject);
begin
  Exit;

  DataSetMaestro.EnableControls;

  //if not DataSetMaestro.Active then Exit;
  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;

     //Formulario activo
  M := self;
  MD := nil;

     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);

     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gCF := CalendarioFlotante;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

     //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
  end;
     //Desplegar(Self,439);
  if PanelMaestro.Visible = false then
    PanelMaestro.Visible := true;
end;


procedure TFMDestrioDiario.FormDeactivate(Sender: TObject);
begin
  Exit;

  //Desahabilitamos controles de Base de datos
  //mientras estamos desactivados
  DataSetMaestro.DisableControls;

 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;

  //CerrarTablas;
end;

procedure TFMDestrioDiario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Liberamos recursos
  Lista.Free;

     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

     //Codigo de desactivacion
  CerrarTablas;

     //Formulario activo
  M := nil;
  MD := nil;
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMDestrioDiario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización

  case key of
    vk_up, vk_Return:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

{+}//Sustituir por funcion generica

procedure TFMDestrioDiario.Filtro;
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
end;

{+}//sustituir por funcion generica

procedure TFMDestrioDiario.AnyadirRegistro;
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

{+}//Sustituir por funcion generica

procedure TFMDestrioDiario.ValidarEntradaMaestro;
var
  dFecha: TDateTime;
begin
  if stEmpresa.Caption = '' then
  begin
    raise Exception.Create('Falta el código de la empresa o es incorrecto.');
  end;
  if stCentro.Caption = '' then
  begin
    raise Exception.Create('Falta el código del centro o es incorrecto.');
  end;
  if stProducto.Caption = '' then
  begin
    raise Exception.Create('Falta el código del producto o es incorrecto.');
  end;
  if not tryStrToDate( fecha_de.Text, dFecha ) then
  begin
    raise Exception.Create('Falta la fecha de la compra o es incorrecta.');
  end;
end;

procedure TFMDestrioDiario.Previsualizar;
var
  QRDestrioDiario: TQRDestrioDiario;
begin
  //Crear el listado
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add( ' SELECT *, case when unidades_de > 0 then round( ( destrio_de * 100 ) / unidades_de, 2) ');
  DMBaseDatos.QListado.SQL.Add( '           else 0 end porcentaje_de ');
  DMBaseDatos.QListado.SQL.Add( ' FROM frf_destrio_entregas ');
  DMBaseDatos.QListado.SQL.Add( WHERE );
  DMBaseDatos.QListado.SQL.Add( ' ORDER BY empresa_de, centro_de, producto_de, fecha_de desc ');

  try
    DMBaseDatos.QListado.Open;
    QRDestrioDiario:= TQRDestrioDiario.Create(Application);
    try
      PonLogoGrupoBonnysa(QRDestrioDiario);
      Preview(QRDestrioDiario);
    except
      FreeAndNil(QRDestrioDiario);
      Raise;
    end;
  finally
    DMBaseDatos.QListado.Close;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMDestrioDiario.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(BGBCentro, [empresa_de.Text]);
    kProducto: DespliegaRejilla(BGBProducto, [empresa_de.Text]);
    kCalendar: DespliegaCalendario(BCBFecha);
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************

//Evento que se produce cuando cambia el registro activo
//Tambien se genera cuando se muestra el primero
//Evento que se produce cuando pulsamos modificar
//Aprovechar para modificar estado controles

procedure TFMDestrioDiario.AntesDeLocalizar;
begin
  cbxUnidad.Itemindex:= -1;
end;

procedure TFMDestrioDiario.AntesDeInsertar;
begin
  empresa_de.Text:= gsDefEmpresa;
  centro_de.Text:= gsDefCentro;
  fecha_de.Text:= DateToStr( Date );
  unidad_de.Text:= 'K';
end;

procedure TFMDestrioDiario.AntesDeModificar;
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
//Aprovechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMDestrioDiario.AntesDeVisualizar;
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


procedure TFMDestrioDiario.RequiredTime(Sender: TObject;
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

procedure TFMDestrioDiario.empresa_deChange(Sender: TObject);
begin
  stEmpresa.Caption := desEmpresa(empresa_de.Text);
  stCentro.Caption:= desCentro( empresa_de.text, centro_de.text );
  stProducto.Caption:= desProducto( empresa_de.text, producto_de.text );
end;

procedure TFMDestrioDiario.centro_deChange(Sender: TObject);
begin
  stCentro.Caption:= desCentro( empresa_de.text, centro_de.text );
end;

procedure TFMDestrioDiario.producto_deChange(Sender: TObject);
begin
  stProducto.Caption:= desProducto( empresa_de.text, producto_de.text );
end;

procedure TFMDestrioDiario.unidad_deChange(Sender: TObject);
begin
  if unidad_de.Text = 'U' then
  begin
    cbxUnidad.ItemIndex:= 1;
  end
  else
  begin
    cbxUnidad.ItemIndex:= 0;
  end;
end;

procedure TFMDestrioDiario.cbxUnidadChange(Sender: TObject);
begin
  if QDestrioDiario.State in [dsInsert, dsEdit] then
  begin
    if cbxUnidad.ItemIndex = 0 then
    begin
      unidad_de.Text:= 'K';
    end
    else
    if cbxUnidad.ItemIndex = 1 then
    begin
      unidad_de.Text:= 'U';
    end;
  end;
end;

procedure TFMDestrioDiario.QDestrioDiarioCalcFields(DataSet: TDataSet);
begin
  if QDestrioDiariounidades_de.AsFloat <> 0 then
  begin
    QDestrioDiarioporcentaje_de.AsFloat:=
      bRoundTo( ( QDestrioDiariodestrio_de.AsFloat * 100 ) / QDestrioDiariounidades_de.AsFloat, -2 );
  end
  else
  begin
    QDestrioDiarioporcentaje_de.AsFloat:= 0;
  end;
end;

end.
