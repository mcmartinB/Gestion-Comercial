unit MMonedas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, BCalendarButton,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  ComCtrls, BCalendario, BEdit, dbTables, DError;

type
  TFMMonedas = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LDescripcion_m: TLabel;
    descripcion_m: TBDEdit;
    Label13: TLabel;
    moneda_m: TBDEdit;
    LMoneda_m: TLabel;
    QMonedas: TQuery;
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

    FRegistroABorrarMonedaId: String;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  protected
    procedure AlBorrar;
    procedure DespuesDeBorrar;

    procedure SincronizarWeb; override;

  public
    { Public declarations }
    procedure Filtro; override;
    function  GetFiltro( var AFiltro: string ): Boolean; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, LMonedas, DPreview, bSQLUtils, GetFiltroFM,
  SincronizacionBonny;

var
  FMGetFiltro: TFMGetFiltro;

{$R *.DFM}

procedure TFMMonedas.AbrirTablas;
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

procedure TFMMonedas.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;
procedure TFMMonedas.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarMoneda(FRegistroABorrarMonedaId);
  SincroBonnyAurora.Sincronizar;
  FRegistroABorrarMonedaId := '';
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMMonedas.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QMonedas;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_monedas ';
 {+}where := ' WHERE moneda_m=' + QuotedStr('###');
 {+}Order := ' ORDER BY moneda_m, descripcion_m ';
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

    // Sinconizacion Web - borrado
  OnBeforeMasterDelete := AlBorrar;
  OnAfterMasterDeleted := DespuesDeBorrar;

     //Focos
  {+}FocoAltas := moneda_m;
  {+}FocoModificar := descripcion_m;
  {+}FocoLocalizar := moneda_m;


  FMGetFiltro:= InicializarFiltro ( self );
  FMGetFiltro.Configurar('Filtrar Monedas', 0);
  FMGetFiltro.AddChar('moneda_m', 'Moneda', 3, False );
  FMGetFiltro.AddChar('descripcion_m', 'Nombre', 20, false );

  FMGetFiltro.AddInteger('integer', 'Entero', 6, false );
  FMGetFiltro.AddReal('real', 'Decimal', 6, 2, false );
  FMGetFiltro.AddChar('char', 'Caracter', 6, false );
  FMGetFiltro.AddDate('date', 'Fecha', false );
  FMGetFiltro.AddHour('hour', 'Hora', false );
  FMGetFiltro.AddBoolean('boolean', 'Booleano', False, False, 'S', 'N' );
  Filtrado:= False;

end;

{+ CUIDADIN }

procedure TFMMonedas.FormActivate(Sender: TObject);
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


procedure TFMMonedas.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMMonedas.FormClose(Sender: TObject; var Action: TCloseAction);
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
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMMonedas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMMonedas.Filtro;
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

function TFMMonedas.GetFiltro( var AFiltro: string ): boolean;
begin
   result:= FMGetFiltro.Filtro( AFiltro );
end;

{+}//sustituir por funcion generica

procedure TFMMonedas.AnyadirRegistro;
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

procedure TFMMonedas.ValidarEntradaMaestro;
var i: Integer;
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
end;

procedure TFMMonedas.Previsualizar;
var enclave: TBookMark;
begin
  enclave := DataSetMaestro.GetBookmark;
  QRLMonedas := TQRLMonedas.Create(Application);
  PonLogoGrupoBonnysa(QRLMonedas);
  QRLMonedas.DataSet := QMonedas;
  Preview(QRLMonedas);
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

procedure TFMMonedas.ARejillaFlotanteExecute(Sender: TObject);
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

procedure TFMMonedas.AlBorrar;
begin
  FRegistroABorrarMonedaId := DSMaestro.Dataset.FieldByName('moneda_m').asString;
end;

procedure TFMMonedas.AntesDeModificar;
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

procedure TFMMonedas.AntesDeVisualizar;
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

procedure TFMMonedas.RequiredTime(Sender: TObject;
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

procedure TFMMonedas.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarMoneda(DSMaestro.Dataset.FieldByName('moneda_m').asString);
  SincroBonnyAurora.Sincronizar;
end;

end.
