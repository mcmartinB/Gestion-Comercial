unit MPesos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbtables
  , DError;

type
  TFMPesos = class(TMaestro)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    PMaestro: TPanel;
    LEmpresa_p: TLabel;
    BGBEmpresa_p: TBGridButton;
    BGBCentro_p: TBGridButton;
    LCentro_p: TLabel;
    LProducto_p: TLabel;
    BGBProducto_p: TBGridButton;
    RejillaFlotante: TBGrid;
    empresa_p: TBDEdit;
    centro_p: TBDEdit;
    producto_p: TBDEdit;
    STEmpresa_p: TStaticText;
    STCentro_p: TStaticText;
    STProducto_p: TStaticText;
    GroupBox1: TGroupBox;
    LPeso_palet_p: TLabel;
    peso_palet_p: TBDEdit;
    LPeso_caja_p: TLabel;
    peso_caja_p: TBDEdit;
    Label1: TLabel;
    cajas_palet_p: TBDEdit;
    QPesos: TQuery;
    lblFormato: TLabel;
    formato_p: TBDEdit;
    descripcion_p: TBDEdit;
    lblLogifruit: TLabel;
    logifruit_p: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
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

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure AntesDeLocalizar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, LPesos, DPreview, bSQLUtils;

{$R *.DFM}

procedure TFMPesos.AbrirTablas;
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
         //Mensaje de error
    on E: EDBEngineError do
    begin
      ShowError(e);
      raise Exception.Create('No puedo abrir la tabla maestro.');
    end;
  end;

     //Estado inicial
  Registro := 1;
  Registros := DataSetMaestro.RecordCount;
  RegistrosInsertados := 0;
end;

procedure TFMPesos.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMPesos.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;

     //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := nil;

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
 {+}DataSetMaestro := QPesos;

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_pesos pesos';
 {+}where := ' WHERE pesos.empresa_p=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_p, centro_p, producto_p ';

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

     //Abrir tablas/Querys
  try
    AbrirTablas;
    Visualizar;
  except
    Close;
    Exit;
  end;
     //Desplegar(Self,439);
  if PanelMaestro.Visible = false then
    PanelMaestro.Visible := true;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_p.Tag := kEmpresa;
  centro_p.Tag := kCentro;
  producto_p.Tag := kProducto;


     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeLocalizar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_p;
  {+}FocoModificar := peso_palet_p;
  {+}FocoLocalizar := empresa_p;
end;

{+ CUIDADIN }


procedure TFMPesos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;

//Desahabilitamos controles de Base de datos
     //mientras estamos desactivados
  DataSetMaestro.DisableControls;

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

procedure TFMPesos.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMPesos.Filtro;
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
            where := where + ' pesos.' + name + ' LIKE ' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' pesos.' + name + ' =' + SQLDate(Text)
            else
              where := where + ' pesos.' + name + ' =' + SQLNumeric(Text);
          flag := True;
        end;
      end;
    end;
  end;

  if logifruit_p.State = cbUnchecked then
  begin
    if flag then where := where + ' and ';
    where := where + ' pesos.logifruit_p = 0 ';
    flag := True;
  end
  else
  if logifruit_p.State = cbChecked then
  begin
    if flag then where := where + ' and ';
    where := where + ' pesos.logifruit_p <> 0 ';
    flag := True;
  end;

  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMPesos.AnyadirRegistro;
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
            where := where + 'pesos.' + name + ' =' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' pesos.' + name + ' =' + SQLDate(Text)
            else
              where := where + ' pesos.' + name + ' =' + Text;
          flag := True;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;

{+}//Sustituir por funcion generica

procedure TFMPesos.ValidarEntradaMaestro;
var i: Integer;
begin
    //Que no hayan campos vacios
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

procedure TFMPesos.Previsualizar;
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
      SQL.add(' SELECT pesos.*,  prod.descripcion_p descripcion_prod, emp.nombre_e, cent.descripcion_c ' +
        ' FROM frf_pesos pesos, frf_productos prod, frf_empresas emp,frf_centros cent ');
      if where <> '' then
        SQL.add(where + ' and ')
      else
        SQL.add(' where ');
      SQL.add(' (pesos.producto_p=prod.producto_p) ' +
        ' and (pesos.empresa_p=cent.empresa_c) ' +
        ' and (pesos.centro_p=cent.centro_c) ' +
        ' and (pesos.empresa_p=emp.empresa_e )');
      SQL.add(' ORDER BY pesos.empresa_p, pesos.centro_p, pesos.producto_p, pesos.formato_p ');
      try
        Open;
        RecordCount;
      except
        MessageDlg('Error al generar el listado.', mtError, [mbNo], 0);
        Exit;
      end;
    end;
    QRLPesos := TQRLPesos.Create(Application);
    PonLogoGrupoBonnysa(QRLPesos);
    QRLPesos.DataSet := DMBaseDatos.QListado;
    Preview(QRLPesos);
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

procedure TFMPesos.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_p);
    kProducto: DespliegaRejilla(BGBProducto_p, [empresa_p.Text]);
    kCentro: DespliegaRejilla(BGBCentro_p, [empresa_p.Text]);
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
procedure TFMPesos.AntesDeLocalizar;
begin
  logifruit_p.AllowGrayed:= True;
end;

//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMPesos.AntesDeInsertar;
begin
  logifruit_p.Checked:= False;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMPesos.AntesDeModificar;
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

procedure TFMPesos.AntesDeVisualizar;
var i: Integer;
begin
  logifruit_p.AllowGrayed:= False;

    //Resaturamos estado controles
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;
  STCentro_p.Caption := desCentro(empresa_p.Text, centro_p.Text);
  STProducto_p.Caption := desProducto(empresa_p.Text, producto_p.Text);
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMPesos.PonNombre(Sender: TObject);
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
        STCentro_p.Caption := desCentro(empresa_p.Text, centro_p.Text);
      end;
    kCentro: STCentro_p.Caption := desCentro(empresa_p.Text, centro_p.Text);
    kProducto: STProducto_p.Caption := desProducto(empresa_p.Text, producto_p.Text);
  end;
end;

procedure TFMPesos.RequiredTime(Sender: TObject;
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
