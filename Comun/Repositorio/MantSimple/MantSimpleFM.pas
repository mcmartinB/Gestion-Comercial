unit MantSimpleFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BGrid,
  BSpeedButton, Grids, DBGrids, BGridButton, BDEdit, BCalendarButton, ComCtrls,
  BCalendario, BEdit, dbTables, DError;

type
  TFMMantSimple = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    LEmpresa_p: TLabel;
    empresa_csp: TBDEdit;
    BGBEmpresa_csp: TBGridButton;
    STEmpresa_csp: TStaticText;
    Label13: TLabel;
    transporte_csp: TBDEdit;
    LAno_semana_p: TLabel;
    Label1: TLabel;
    cliente_csp: TBDEdit;
    Label2: TLabel;
    dir_sum_csp: TBDEdit;
    Label3: TLabel;
    importe_csp: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
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

uses CVariables, CGestionPrincipal, UDMBaseDatos,
     UDMAuxDB, CAuxiliarDB, Principal, DPreview,
     MantSimpleQM, MantSimpleDM, bSQLUtils, CReportes;

{$R *.DFM}

procedure TFMMantSimple.AbrirTablas;
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

procedure TFMMantSimple.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMMantSimple.FormCreate(Sender: TObject);
begin
  DMMantSimple:= TDMMantSimple.Create( Self );

     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := DMMantSimple.QMaestro;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_cost_portes ';
 {+}where := ' WHERE empresa_csp=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_csp, transporte_csp, cliente_csp, dir_sum_csp ';
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
  empresa_csp.Tag := kEmpresa;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := empresa_csp;
  {+}FocoModificar := importe_csp;
  {+}FocoLocalizar := empresa_csp;

end;

{+ CUIDADIN }

procedure TFMMantSimple.FormActivate(Sender: TObject);
begin
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


procedure TFMMantSimple.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMMantSimple.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil( DMMantSimple );
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

procedure TFMMantSimple.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMMantSimple.Filtro;
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
              where := where + ' ' + name + ' =' + Text;
          flag := True;
        end;
      end;
    end;
  end;
  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMMantSimple.AnyadirRegistro;
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

procedure TFMMantSimple.ValidarEntradaMaestro;
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
  //La direccionde suministro debe existir o ser igual que el cliente
  if cliente_csp.Text <> dir_sum_csp.Text then
  begin
    DMMantSimple.QDirSum.ParamByName('empresa').AsString:= empresa_csp.Text;
    DMMantSimple.QDirSum.ParamByName('cliente').AsString:= cliente_csp.Text;
    DMMantSimple.QDirSum.ParamByName('dir_sum').AsString:= dir_sum_csp.Text;
    DMMantSimple.QDirSum.Open;
    if DMMantSimple.QDirSum.IsEmpty then
    begin
      DMMantSimple.QDirSum.Close;
      raise Exception.Create('Dirección de Suministro Incorrecta.');
    end;
    DMMantSimple.QDirSum.Close;
  end;
end;


procedure TFMMantSimple.Previsualizar;
begin
  DMMantSimple.QListado.SQL.Clear;
  DMMantSimple.QListado.SQL.Add( ' Select empresa_csp, transporte_csp, cliente_csp, dir_sum_csp, importe_csp ');
  DMMantSimple.QListado.SQL.Add( ' From frf_cost_portes ');
  DMMantSimple.QListado.SQL.Add( where );
  DMMantSimple.QListado.SQL.Add( ' order by empresa_csp, transporte_csp, cliente_csp, dir_sum_csp ');
  DMMantSimple.QListado.Open;

  QMMantSimple := TQMMantSimple.Create(Application);
  PonLogo(QMMantSimple, '050');
  QMMantSimple.PrinterSettings.PrinterIndex := giPtrDefault;
  Preview(QMMantSimple);

  DMMantSimple.QListado.Open;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMMantSimple.ARejillaFlotanteExecute(Sender: TObject);
begin
  if empresa_csp.Focused then
    DespliegaRejilla(BGBEmpresa_csp);
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMMantSimple.AntesDeModificar;
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

procedure TFMMantSimple.AntesDeVisualizar;
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

procedure TFMMantSimple.PonNombre(Sender: TObject);
begin
  if ((gRF <> nil) and gRF.Visible) or
    ((gCF <> nil) and gCF.Visible) then
    Exit;
  STEmpresa_csp.Caption := desEmpresa(empresa_csp.Text);
end;

procedure TFMMantSimple.RequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
  isTime := false;
  if TBEdit(Sender).CanFocus then
  begin
    if (Estado = teLocalizar) then
      Exit;
    if (gRF <> nil) and (gRf.Visible = true) then
      Exit;
    if (gCF <> nil) and (gCf.Visible = true) then
      Exit;
    isTime := true;
  end;
end;

end.
