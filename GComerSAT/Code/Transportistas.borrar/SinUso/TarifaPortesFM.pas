unit TarifaPortesFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BGrid,
  BSpeedButton, Grids, DBGrids, BGridButton, BDEdit, BCalendarButton, ComCtrls,
  BCalendario, BEdit, dbTables, DError;

type
  TFMTarifaPortes = class(TMaestro)
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
    total_csp: TBDEdit;
    stTransporte: TStaticText;
    stCliente: TStaticText;
    stSuministro: TStaticText;
    BGBTransporte: TBGridButton;
    BGBCliente: TBGridButton;
    BGBSuministro: TBGridButton;
    parcial_csp: TBDEdit;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure transporte_cspChange(Sender: TObject);
    procedure cliente_cspChange(Sender: TObject);
    procedure dir_sum_cspChange(Sender: TObject);
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
     TarifaPortesQM, TarifaPortesDM, bSQLUtils, CReportes;

{$R *.DFM}

procedure TFMTarifaPortes.AbrirTablas;
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

procedure TFMTarifaPortes.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMTarifaPortes.FormCreate(Sender: TObject);
begin
  DMTarifaPortes:= TDMTarifaPortes.Create( Self );

     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := DMTarifaPortes.QMaestro;
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
  transporte_csp.Tag:= kTransportista;
  cliente_csp.Tag := kCliente;
  dir_sum_csp.Tag := kSuministro;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
     //Focos
  {+}FocoAltas := empresa_csp;
  {+}FocoModificar := total_csp;
  {+}FocoLocalizar := empresa_csp;

end;

{+ CUIDADIN }

procedure TFMTarifaPortes.FormActivate(Sender: TObject);
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


procedure TFMTarifaPortes.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;

procedure TFMTarifaPortes.FormClose(Sender: TObject; var Action: TCloseAction);
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
  FreeAndNil( DMTarifaPortes );
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMTarifaPortes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMTarifaPortes.Filtro;
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

procedure TFMTarifaPortes.AnyadirRegistro;
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

procedure TFMTarifaPortes.ValidarEntradaMaestro;
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
    DMTarifaPortes.QDirSum.ParamByName('empresa').AsString:= empresa_csp.Text;
    DMTarifaPortes.QDirSum.ParamByName('cliente').AsString:= cliente_csp.Text;
    DMTarifaPortes.QDirSum.ParamByName('dir_sum').AsString:= dir_sum_csp.Text;
    DMTarifaPortes.QDirSum.Open;
    if DMTarifaPortes.QDirSum.IsEmpty then
    begin
      DMTarifaPortes.QDirSum.Close;
      raise Exception.Create('Dirección de Suministro Incorrecta.');
    end;
    DMTarifaPortes.QDirSum.Close;
  end;
end;


procedure TFMTarifaPortes.Previsualizar;
begin
  DMTarifaPortes.QListado.SQL.Clear;
  DMTarifaPortes.QListado.SQL.Add( ' Select empresa_csp, transporte_csp, cliente_csp, dir_sum_csp, total_csp, parcial_csp ');
  DMTarifaPortes.QListado.SQL.Add( ' From frf_cost_portes ');
  DMTarifaPortes.QListado.SQL.Add( where );
  DMTarifaPortes.QListado.SQL.Add( ' order by empresa_csp, transporte_csp, cliente_csp, dir_sum_csp ');
  DMTarifaPortes.QListado.Open;

  QMTarifaPortes := TQMTarifaPortes.Create(Application);
  PonLogoGrupoBonnysa(QMTarifaPortes);
  Preview(QMTarifaPortes);

  DMTarifaPortes.QListado.Open;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMTarifaPortes.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_csp);
    kTransportista: DespliegaRejilla( BGBTransporte, [empresa_csp.text] );
    kCliente: DespliegaRejilla( BGBCliente, [empresa_csp.text] );
    kSuministro: DespliegaRejilla( BGBSuministro, [empresa_csp.text,cliente_csp.text] );
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMTarifaPortes.AntesDeModificar;
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

procedure TFMTarifaPortes.AntesDeVisualizar;
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

procedure TFMTarifaPortes.RequiredTime(Sender: TObject;
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

procedure TFMTarifaPortes.PonNombre(Sender: TObject);
begin
  STEmpresa_csp.Caption := desEmpresa(empresa_csp.Text);
  stTransporte.Caption:= desTransporte( empresa_csp.Text, transporte_csp.Text );
  stCliente.Caption:= desCliente( empresa_csp.Text, cliente_csp.Text );
  stSuministro.Caption:= desSuministro( empresa_csp.Text, cliente_csp.Text, dir_sum_csp.Text );
  if stSuministro.Caption = '' then
    stSuministro.Caption:= desCliente( empresa_csp.Text, cliente_csp.Text );
end;

procedure TFMTarifaPortes.transporte_cspChange(Sender: TObject);
begin
  stTransporte.Caption:= desTransporte( empresa_csp.Text, transporte_csp.Text );
end;

procedure TFMTarifaPortes.cliente_cspChange(Sender: TObject);
begin
  stCliente.Caption:= desCliente( empresa_csp.Text, cliente_csp.Text );
end;

procedure TFMTarifaPortes.dir_sum_cspChange(Sender: TObject);
begin
  stSuministro.Caption:= desSuministro( empresa_csp.Text, cliente_csp.Text, dir_sum_csp.Text );
  if stSuministro.Caption = '' then
    stSuministro.Caption:= desCliente( empresa_csp.Text, cliente_csp.Text );
end;

end.
