unit WebClientesFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BGrid,
  BSpeedButton, Grids, DBGrids, BGridButton, BDEdit, BCalendarButton, ComCtrls,
  BCalendario, BEdit, dbTables, DError;

type
  TFMWebClientes = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LEmpresa_p: TLabel;
    cliente_wcl: TBDEdit;
    Label13: TLabel;
    idioma_wcl: TBDEdit;
    LAno_semana_p: TLabel;
    Label1: TLabel;
    usuario_wcl: TBDEdit;
    Password: TLabel;
    password_wcl: TBDEdit;
    Label3: TLabel;
    email_wcl: TBDEdit;
    nombre_cliente_wcl: TBDEdit;
    nombre_usuario_wcl: TBDEdit;
    Label2: TLabel;
    cbxIdiomas: TComboBox;
    btnSincronizar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure cbxIdiomasChange(Sender: TObject);
    procedure idioma_wclChange(Sender: TObject);
    procedure btnSincronizarClick(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;
    bLiberarDMWEB: Boolean;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeInsertar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, bSQLUtils,
     UDMAuxDB, CAuxiliarDB, Principal, DPreview, CReportes,
     WebClientesQM, WebDM, SincronizarClientesFD, UDMConfig;

{$R *.DFM}

procedure TFMWebClientes.AbrirTablas;
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

procedure TFMWebClientes.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMWebClientes.FormCreate(Sender: TObject);
begin
  if DMWEB = nil then
  begin
    DMWEB:= TDMWEB.Create( self );
    bLiberarDMWEB:= True;
  end
  else
  begin
    bLiberarDMWEB:= false;
  end;

     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := DMWeb.QMaestro;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_web_clientes ';
 {+}where := ' WHERE cliente_wcl=' + QuotedStr('###');
 {+}Order := ' ORDER BY cliente_wcl ';
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

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
  OnInsert:= AntesDEInsertar;
     //Focos
  {+}FocoAltas := cliente_wcl;
  {+}FocoModificar := nombre_cliente_wcl;
  {+}FocoLocalizar := cliente_wcl;

  cbxIdiomas.ItemIndex:= -1;
  btnSincronizar.Visible:= DMConfig.iNivelReclamaciones > 1;
end;

{+ CUIDADIN }

procedure TFMWebClientes.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Formulario activo
  M := self;
  MD := nil;
     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMWebClientes.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMWebClientes.FormClose(Sender: TObject; var Action: TCloseAction);
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

  if bLiberarDMWEB and ( DMWEB <> nil ) then
    FreeAndNil( DMWEB );  
end;

procedure TFMWebClientes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMWebClientes.Filtro;
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

procedure TFMWebClientes.AnyadirRegistro;
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

procedure TFMWebClientes.ValidarEntradaMaestro;
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


procedure TFMWebClientes.Previsualizar;
begin
  DMWeb.QListado.SQL.Clear;
  DMWeb.QListado.SQL.Add( ' Select * ');
  DMWeb.QListado.SQL.Add( ' From frf_web_clientes ');
  DMWeb.QListado.SQL.Add( where );
  DMWeb.QListado.SQL.Add( ' order by cliente_wcl ');
  DMWeb.QListado.Open;

  QMWebClientes := TQMWebClientes.Create(Application);
  PonLogoGrupoBonnysa(QMWebClientes);
  QMWebClientes.ReportTitle:= 'CLIENTES WEB';
  Preview(QMWebClientes);

  DMWeb.QListado.Close;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMWebClientes.AntesDeModificar;
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

procedure TFMWebClientes.AntesDeInsertar;
begin
  if Estado = teAlta then
  begin
    idioma_wcl.Text:= 'ES';
    cbxIdiomas.ItemIndex:= 0;
  end;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMWebClientes.AntesDeVisualizar;
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

procedure TFMWebClientes.RequiredTime(Sender: TObject;
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

procedure TFMWebClientes.cbxIdiomasChange(Sender: TObject);
begin
  if idioma_wcl.DataSource.State in [ dsInsert, dsEdit ] then
  begin
    case cbxIdiomas.ItemIndex of
      0: idioma_wcl.Text:= 'ES';
      1: idioma_wcl.Text:= 'EN';
      2: idioma_wcl.Text:= 'DE';
    end;
  end;
end;

procedure TFMWebClientes.idioma_wclChange(Sender: TObject);
begin
  if idioma_wcl.Text = 'es' then
    cbxIdiomas.ItemIndex:= 0
  else
  if idioma_wcl.Text = 'en' then
    cbxIdiomas.ItemIndex:= 1
  else
  if idioma_wcl.Text = 'de' then
    cbxIdiomas.ItemIndex:= 2
  else
  begin
    if ( idioma_wcl.DataSource.State in [ dsInsert, dsEdit ] ) and
       ( Estado <> teLocalizar ) then
    begin
      idioma_wcl.Text:= 'es';
      cbxIdiomas.ItemIndex:= 0;
    end
    else
    begin
      cbxIdiomas.ItemIndex:= -1;
    end;
  end;
end;

procedure TFMWebClientes.btnSincronizarClick(Sender: TObject);
var
  FDSincronizarClientes: TFDSincronizarClientes;
begin
  if not( Estado in [ teLocalizar, teAlta, teModificar ] ) then
  begin
    try
      FDSincronizarClientes:= TFDSincronizarClientes.Create( Application );
      FDSincronizarClientes.ShowModal;
    finally
      FreeAndNil( FDSincronizarClientes );
    end;
  end;
end;

end.
