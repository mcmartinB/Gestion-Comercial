unit MClientes_edi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  Derror;

type
  TFMClientes_Edi = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Lcomision: TLabel;
    dir_sum_ce: TBDEdit;
    LEmpresa_p: TLabel;
    empresa_ce: TBDEdit;
    Label13: TLabel;
    cliente_ce: TBDEdit;
    LAno_semana_p: TLabel;
    Label1: TLabel;
    codigo_edi_ce: TBDEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    aquiensefactura_ce: TBDEdit;
    quienpide_ce: TBDEdit;
    quienrecibe_ce: TBDEdit;
    quienpaga_ce: TBDEdit;
    STEmpresa_ce: TStaticText;
    STCliente_ce: TStaticText;
    STDir_sum_ce: TStaticText;
    BGBEmpresa_ce: TBGridButton;
    BGBCliente_ce: TBGridButton;
    BGBDir_sum_ce: TBGridButton;
    RejillaFlotante: TBGrid;
    QClientes_Edi: TQuery;

    //Eventos formulario
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);

    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);

    //Eventos Codigos
    procedure SalidaCodigos(Sender: TObject);
    procedure SoloNumeros(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    FRegistroaABorrarEmpresaId: String;
    FRegistroaABorrarClienteId: String;
    FRegistroaABorrarDireccionSumId: String;

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
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

var
  tecla: integer;

implementation

uses bDialogs, UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, LClientes_Edi, DPreview, bSQLUtils,
  SincronizacionBonny;

{$R *.DFM}

procedure TFMClientes_Edi.AbrirTablas;
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

procedure TFMClientes_Edi.CerrarTablas;
begin
     // Cerrar tabla
  if DataSetMaestro.Active then DataSetMaestro.Close;
     //or DMBaseDatos.DBBaseDatos.CloseDataSets;

end;

procedure TFMClientes_Edi.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarClienteEdi(FRegistroaABorrarEmpresaId, FRegistroaABorrarClienteId, FRegistroaABorrarDireccionSumId);
  SincroBonnyAurora.Sincronizar;
  FRegistroaABorrarEmpresaId := '';
  FRegistroaABorrarClienteId := '';
  FRegistroaABorrarDireccionSumId := '';
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMClientes_Edi.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QClientes_Edi;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_clientes_edi ';
 {+}where := ' WHERE empresa_ce="###" AND cliente_ce="###" AND dir_sum_ce="###"';
 {+}Order := ' ORDER BY empresa_ce, cliente_ce, dir_sum_ce ';
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

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_ce.Tag := kEmpresa;
  cliente_ce.Tag := kCliente;
  dir_sum_ce.Tag := kSuministro;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

    // Sinconizacion Web - borrado
  OnBeforeMasterDelete := AlBorrar;
  OnAfterMasterDeleted := DespuesDeBorrar;
     //Focos
  {+}FocoAltas := empresa_ce;
  {+}FocoModificar := codigo_edi_ce;
  {+}FocoLocalizar := empresa_ce;

end;

{+ CUIDADIN }

procedure TFMClientes_Edi.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_SHOWNORMAL);
  if not DataSetMaestro.Active then Exit;
     //Formulario activo
  M := self;
  MD := nil;
     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMClientes_Edi.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMClientes_Edi.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMClientes_Edi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*DEJAR SI EXISTE REJILLA }
    //Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
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

{+}//Sustituir por funcion generica

procedure TFMClientes_Edi.Filtro;
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
            where := where + ' ' + Name + ' LIKE ' + SQLFilter(Text)
          else
            where := where + ' ' + name + ' =' + '"' + Text + '"';
          flag := True;
        end;
      end;
    end;
  end;
  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMClientes_Edi.AnyadirRegistro;
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
          where := where + ' ' + name + ' =' + '"' + Text + '"';
          flag := True;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMClientes_Edi.ValidarEntradaMaestro;
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
    //******************************
    //Restricciones particulares
    //******************************
end;

procedure TFMClientes_Edi.Previsualizar;
begin
  QRLClientes_Edi := TQRLClientes_Edi.Create(Application);
  PonLogoGrupoBonnysa(QRLClientes_Edi);
  QRLClientes_Edi.DataSet := QClientes_Edi;
  Preview(QRLClientes_Edi);
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar la rejilla flotante (formulario)
//   - Borrar Lista de acciones  (formulario)
//   - Borrar las funciones de esta seccion (codigo)
//*****************************************************************************
//****************************************************************************

procedure TFMClientes_Edi.ARejillaFlotanteExecute(Sender: TObject);
begin
//      {*CAMBIAR}
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_ce);
    kCliente: DespliegaRejilla(BGBCliente_ce);
    kSuministro: DespliegaRejilla(BGBDir_sum_ce);
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMClientes_Edi.AlBorrar;
begin
    FRegistroaABorrarEmpresaId := DSMaestro.DataSet.FieldByName('empresa_ce').asString;
    FRegistroaABorrarClienteId := DSMaestro.DataSet.FieldByName('cliente_ce').asString;
    FRegistroaABorrarDireccionSumId := DSMaestro.DataSet.FieldByName('dir_sum_ce').asString;
end;

procedure TFMClientes_Edi.AntesDeModificar;
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

procedure TFMClientes_Edi.AntesDeVisualizar;
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
    //Tal vez haya que llamar aqui a las funciones que ponen el nombre
  STCliente_ce.Caption := desCliente(cliente_ce.Text);
end;

procedure TFMClientes_Edi.SoloNumeros(Sender: TObject;
  var Key: Char);
begin
     //Acepta sólo caracteres numericos
  if not
    (
    ((key >= '0') and (key <= '9')) or
    (key = #8) or //BackSpace
    (key = #46) or //Delete
    (key = #32) //Espace
    )
    then key := #0;
end;

procedure TFMClientes_Edi.SalidaCodigos(Sender: TObject);
begin
        //Si se produce el evento porque se ha pulsado "ESC"
        //se habrá cancelado la operacion y no estara en ninguno de
        //los dos estado siguientes.
  if (DSMaestro.State <> dsInsert) and (DSMAestro.State <> dsEdit) then
    Exit;
          //si el evento se ha producido sin pulsar ESC se controla que
          //los valores introducidos sean correctos.
  if Estado in [teAlta, teModificar] then
    if Length(TBEdit(Sender).Text) < TBEdit(Sender).MaxLength then
    begin
      Self.ActiveControl := TBEdit(Sender);
      if TBEdit(Sender).Text <> '' then
        Advertir('Debe introducir un código de 13 caracteres');
    end;
end;

procedure TFMClientes_Edi.SincronizarWeb;
var
  empresaId: String;
  clienteId: String;
  direccionSumId: String;
begin
  empresaId := DSMaestro.DataSet.FieldByName('empresa_ce').asString;
  clienteId := DSMaestro.DataSet.FieldByName('cliente_ce').asString;
  direccionSumId := DSMaestro.DataSet.FieldByName('dir_sum_ce').asString;

  SincroBonnyAurora.SincronizarClienteEdi(empresaId, clienteId, direccionSumId);
  SincroBonnyAurora.Sincronizar;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMClientes_Edi.PonNombre(Sender: TObject);
begin
{*    }
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
     //*********************************
     //FUNCIONES DEFINIDAS EN CAuxiliarDB
     //DEJAR LAS NECESARIAS, AÑADIR LAS QUE FALTEN
     //*********************************
  case TComponent(Sender).Tag of
    kCliente:
    begin
      STCliente_ce.Caption := desCliente(cliente_ce.Text);
      STDir_sum_ce.Caption := desSuministro(empresa_ce.Text, cliente_ce.Text, dir_sum_ce.Text);
    end;
    kEmpresa:
    begin
      STEmpresa_ce.Caption := desEmpresa(empresa_ce.Text);
      STCliente_ce.Caption := desCliente(cliente_ce.Text);
      STDir_sum_ce.Caption := desSuministro(empresa_ce.Text, cliente_ce.Text, dir_sum_ce.Text);
    end;
    kSuministro:
      STDir_sum_ce.Caption := desSuministro(empresa_ce.Text, cliente_ce.Text, dir_sum_ce.Text);
  end;

end;
//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMClientes_Edi.RequiredTime(Sender: TObject;
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

procedure TFMClientes_Edi.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewHeight < 35 then
  begin
    ShowWindow(Application.Handle, SW_SHOWMINNOACTIVE);
    Resize := False;
  end;
end;

//*****************************************
//PRUEBAS
//*****************************************

end.
