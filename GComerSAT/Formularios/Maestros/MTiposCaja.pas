unit MTiposCaja;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, BCalendarButton,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  ComCtrls, BCalendario, BEdit, dbTables, DError;

type
  TFMTiposCaja = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LDescripcion_m: TLabel;
    descripcion_tc: TBDEdit;
    QTiposCajas: TQuery;
    dbgAgrupaciones: TDBGrid;
    lblCodigo: TLabel;
    codigo_tc: TBDEdit;
    lblPeso: TLabel;
    peso_tc: TBDEdit;
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
  CAuxiliarDB, Principal, LTiposCaja, DPreview, bSQLUtils;

{$R *.DFM}

procedure TFMTiposCaja.AbrirTablas;
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

procedure TFMTiposCaja.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;
//************************** CREAMOS EL FORMULARIO ************************

procedure TFMTiposCaja.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QTiposCajas;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' select * from frf_tipos_caja ';
 {+}where := ' WHERE codigo_tc =' + QuotedStr('#');
 {+}Order := ' ORDER BY codigo_tc ';
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
  {+}FocoAltas := codigo_tc;
  {+}FocoModificar := descripcion_tc;
  {+}FocoLocalizar := codigo_tc;


end;

{+ CUIDADIN }

procedure TFMTiposCaja.FormActivate(Sender: TObject);
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


procedure TFMTiposCaja.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMTiposCaja.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMTiposCaja.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMTiposCaja.Filtro;
begin
  where := '';
  if Trim(codigo_tc.text) <> '' then
  begin
    where := ' WHERE codigo_tc  LIKE ' + QuotedStr( codigo_tc.Text );
  end;
  if Trim(descripcion_tc.text) <> '' then
  begin
    if where = '' then
      where := ' WHERE descripcion_tc  LIKE ' + QuotedStr( descripcion_tc.Text  )
    else
      where := where + ' and descripcion_tc  LIKE ' + QuotedStr( descripcion_tc.Text  );
  end;
(*
  if Trim(cantidad_tc.text) <> '' then
  begin
    if where = '' then
      where := ' WHERE cantidad_tc =   ' + cantidad_tc.Text
    else
      where := where + ' and cantidad_tc =   ' + cantidad_tc.Text;
  end;
  if Trim(precio_tc.text) <> '' then
  begin
    if where = '' then
      where := ' WHERE precio_tc =   ' + StringReplace( precio_tc.Text, ',', '.', [] )
    else
      where := where + ' and precio_tc =   ' + StringReplace( precio_tc.Text, ',', '.', [] );
  end;
*)
end;

{+}//sustituir por funcion generica

procedure TFMTiposCaja.AnyadirRegistro;
begin
  if where <> ''then
    where := where + ' OR ( codigo_tc = ' + QuotedStr( codigo_tc.Text ) + ') '
  else
    where := ' WHERE ( codigo_tc = ' + QuotedStr( codigo_tc.Text )+ ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMTiposCaja.ValidarEntradaMaestro;
begin
  if codigo_tc.Text = '' then
  begin
    ShowMessage('Falta el código');
    Abort;
  end;
  if descripcion_tc.Text = '' then
  begin
    ShowMessage('Falta la descripción');
    Abort;
  end;
end;

procedure TFMTiposCaja.Previsualizar;
begin
  QLTiposCaja := TQLTiposCaja.Create(Application);
  PonLogoGrupoBonnysa(QLTiposCaja);
  DMBaseDatos.QListado.SQL.Clear;
  DMBaseDatos.QListado.SQL.Add(Select);
  DMBaseDatos.QListado.SQL.Add(where);
  DMBaseDatos.QListado.SQL.Add(order);
  DMBaseDatos.QListado.Open;
  try
    Preview(QLTiposCaja);
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

procedure TFMTiposCaja.ARejillaFlotanteExecute(Sender: TObject);
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

procedure TFMTiposCaja.AntesDeModificar;
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

procedure TFMTiposCaja.AntesDeVisualizar;
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

procedure TFMTiposCaja.RequiredTime(Sender: TObject;
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
