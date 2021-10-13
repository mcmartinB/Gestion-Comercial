unit MSeccContables;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError;

type
  TFMSeccContables = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    Lcomision: TLabel;
    producto_sc: TBDEdit;
    LEmpresa_p: TLabel;
    Label13: TLabel;
    LAno_semana_p: TLabel;
    LCuenta: TLabel;
    sec_contable_sc: TBDEdit;
    RejillaFlotante: TBGrid;
    BGBCentro: TBGridButton;
    BGBProducto: TBGridButton;
    BGBEmpresa: TBGridButton;
    Label2: TLabel;
    descripcion_sc: TBDEdit;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    STProducto: TStaticText;
    centro_sc: TBDEdit;
    empresa_sc: TBDEdit;
    QSeccContables: TQuery;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
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

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, LSeccContable, DPreview, bSQLUtils;

{$R *.DFM}

procedure TFMSeccContables.AbrirTablas;
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

procedure TFMSeccContables.CerrarTablas;
begin
     // Cerrar tabla
  if DataSetMaestro.Active then DataSetMaestro.Close;

end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMSeccContables.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QSeccContables;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_secc_contables ';
 {+}where := ' WHERE empresa_sc="###"';
 {+}Order := ' ORDER BY empresa_sc, centro_sc, producto_sc, sec_contable_sc ';
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

  DMBaseDatos.QDespegables.Tag := kNull;
  empresa_sc.Tag := kEmpresa;
  centro_sc.Tag := kCentro;
  producto_sc.Tag := kProducto;
     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
     //OnInsert:=AntesDeInsertar;
  OnEdit := AntesDeModificar;
     //OnBrowse:=AntesDeInsertar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := empresa_sc;
  {+}FocoModificar := sec_contable_sc;
  {+}FocoLocalizar := empresa_sc;

end;

{+ CUIDADIN }

procedure TFMSeccContables.FormActivate(Sender: TObject);
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


procedure TFMSeccContables.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMSeccContables.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMSeccContables.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMSeccContables.Filtro;
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

procedure TFMSeccContables.AnyadirRegistro;
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

procedure TFMSeccContables.ValidarEntradaMaestro;
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

procedure TFMSeccContables.Previsualizar;
begin
  QRLSeccContable := TQRLSeccContable.Create(Application);
  PonLogoGrupoBonnysa(QRLSeccContable);
  QRLSeccContable.DataSet := QSeccContables;
  Preview(QRLSeccContable);
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

procedure TFMSeccContables.AntesDeModificar;
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

procedure TFMSeccContables.AntesDeVisualizar;
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

procedure TFMSeccContables.RequiredTime(Sender: TObject;
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

procedure TFMSeccContables.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  if NewHeight < 35 then
  begin
    ShowWindow(Application.Handle, SW_SHOWMINNOACTIVE);
    Resize := False;
  end;
end;

procedure TFMSeccContables.ARejillaFlotanteExecute(Sender: TObject);
begin
  if DMBaseDatos.QDespegables.Active then DMBaseDatos.QDespegables.Close;
  DMBaseDatos.QDespegables.SQL.Clear;
  case ActiveControl.Tag of
    kEmpresa:
      begin
        RejillaFlotante.BControl := empresa_sc;
        DMBaseDatos.QDespegables.SQL.Add('SELECT empresa_e,nombre_e FROM frf_empresas ');
        DMBaseDatos.QDespegables.SQL.Add('ORDER BY nombre_e');
        DMBaseDatos.QDespegables.Open;
        BGBEmpresa.GridShow;
      end;
    kCentro:
      begin
        RejillaFlotante.BControl := centro_sc;
        DMBaseDatos.QDespegables.SQL.Add('SELECT centro_c,descripcion_c FROM frf_centros ');
        DMBaseDatos.QDespegables.SQL.Add('WHERE empresa_c Like ' + QuotedStr(empresa_sc.Text) + ' ');
        DMBaseDatos.QDespegables.SQL.Add('ORDER BY centro_c');
        DMBaseDatos.QDespegables.Open;
        BGBCentro.GridShow;
      end;
    kProducto:
      begin
        RejillaFlotante.BControl := producto_sc;
        DMBaseDatos.QDespegables.SQL.Add('SELECT producto_p,descripcion_p FROM frf_productos ');
        DMBaseDatos.QDespegables.SQL.Add('ORDER BY producto_p');
        DMBaseDatos.QDespegables.Open;
        BGBCentro.GridShow;
      end;
  end;
end;

procedure TFMSeccContables.PonNombre(Sender: TObject);
begin

    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;

  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(empresa_sc.Text);
    kCentro: STCentro.Caption := desCentro(empresa_sc.Text, centro_sc.Text);
    kProducto: STProducto.Caption := desProducto(empresa_sc.Text, producto_sc.Text);
  end;
end;


end.
