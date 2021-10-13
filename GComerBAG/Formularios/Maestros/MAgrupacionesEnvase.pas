unit MAgrupacionesEnvase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, BCalendarButton,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  ComCtrls, BCalendario, BEdit, dbTables, DError;

type
  TFMAgrupacionesEnvase = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LDescripcion_m: TLabel;
    agrupacion_ae: TBDEdit;
    QAgrupaciones: TQuery;
    dbgAgrupaciones: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
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

    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, LAgrupacionesEnvase, DPreview, bSQLUtils;

{$R *.DFM}

procedure TFMAgrupacionesEnvase.AbrirTablas;
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

procedure TFMAgrupacionesEnvase.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;
//************************** CREAMOS EL FORMULARIO ************************

procedure TFMAgrupacionesEnvase.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QAgrupaciones;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' select * from frf_agrupaciones_envase ';
 {+}where := ' WHERE agrupacion_ae=' + QuotedStr('#');
 {+}Order := ' ORDER BY agrupacion_ae ';
     //Abrir tablas/Querys
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

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := agrupacion_ae;
  {+}FocoModificar := agrupacion_ae;
  {+}FocoLocalizar := agrupacion_ae;


end;

{+ CUIDADIN }

procedure TFMAgrupacionesEnvase.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Formulario activo
  M := self;
  MD := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMAgrupacionesEnvase.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMAgrupacionesEnvase.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMAgrupacionesEnvase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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

{+}//Sustituir por funcion generica

procedure TFMAgrupacionesEnvase.Filtro;
begin
  where := '';
  if Trim(agrupacion_ae.text) <> '' then
  begin
    where := ' WHERE agrupacion_ae =  LIKE ' + QuotedStr( agrupacion_ae.Text );
  end;
end;

{+}//sustituir por funcion generica

procedure TFMAgrupacionesEnvase.AnyadirRegistro;
begin
  if where <> ''then
    where := where + ' OR ( agrupacion_ae = ' + QuotedStr( agrupacion_ae.Text ) + ') '
  else
    where := ' WHERE ( agrupacion_ae = ' + QuotedStr( agrupacion_ae.Text )+ ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMAgrupacionesEnvase.ValidarEntradaMaestro;
begin
  if agrupacion_ae.Text = '' then
  begin
    ShowMessage('Falta la agrupación');
    Abort;
  end;
end;

procedure TFMAgrupacionesEnvase.Previsualizar;
var enclave: TBookMark;
begin
  enclave := DataSetMaestro.GetBookmark;
  QLAgrupacionesEnvase := TQLAgrupacionesEnvase.Create(Application);
  PonLogoGrupoBonnysa(QLAgrupacionesEnvase);
  QLAgrupacionesEnvase.DataSet := QAgrupaciones;
  Preview(QLAgrupacionesEnvase);
  DataSetMaestro.GotoBookmark(enclave);
  DataSetMaestro.FreeBookmark(enclave);
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMAgrupacionesEnvase.ARejillaFlotanteExecute(Sender: TObject);
begin

end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMAgrupacionesEnvase.AntesDeModificar;
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

procedure TFMAgrupacionesEnvase.AntesDeVisualizar;
var i: Integer;
begin
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

procedure TFMAgrupacionesEnvase.RequiredTime(Sender: TObject;
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

end.
