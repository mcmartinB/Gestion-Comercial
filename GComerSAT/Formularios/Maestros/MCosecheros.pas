unit MCosecheros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError;

type
  TFMCosecheros = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    STNomEmpresa: TStaticText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    BGBEmpresa: TBGridButton;
    RejillaFlotante: TBGrid;
    empresa_c: TBDEdit;
    cosechero_c: TBDEdit;
    nombre_c: TBDEdit;
    nif_c: TBDEdit;
    domicilio_c: TBDEdit;
    tipo_via_c: TBDEdit;
    poblacion_c: TBDEdit;
    cod_postal_c: TBDEdit;
    BGBTipoVia: TBGridButton;
    STProvincia: TStaticText;
    QCosecheros: TQuery;
    pertenece_grupo_c: TDBCheckBox;
    ajustar_c: TDBCheckBox;
    Label4: TLabel;
    federacion_c: TBDEdit;
    BGBFederacion: TBGridButton;
    STFederacion: TStaticText;
    Label12: TLabel;
    cta_gastos_c: TBDEdit;
    Label11: TLabel;
    cta_contable_c: TBDEdit;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure empresa_cExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure cod_postal_cChange(Sender: TObject);
    procedure federacion_cChange(Sender: TObject);
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

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  LCosechero, CAuxiliarDB, Principal, DPreview, UDMAuxDB, bSQLUtils;

{$R *.DFM}

procedure TFMCosecheros.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DatasetMaestro.SQL.Add(Where);
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

procedure TFMCosecheros.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMCosecheros.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel
  PanelMaestro := PMaestro;

     //Fuente de datos
  DataSetMaestro := QCosecheros;
  Select := ' SELECT * FROM frf_cosecheros ';
  where := ' WHERE empresa_c=' + QuotedStr('###');
  Order := ' ORDER BY empresa_c, cosechero_c ';
     //Para reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Abrir tablas/Querys
  try
    AbrirTablas;
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
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

     //Focos
  {+}FocoAltas := empresa_c;
  {+}FocoModificar := nombre_c;
  {+}FocoLocalizar := empresa_c;

  empresa_c.Tag := kEmpresa;
  tipo_via_c.Tag := kTipoVia;
  federacion_c.Tag := kFederacion;
end;

procedure TFMCosecheros.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;
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

procedure TFMCosecheros.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
end;


procedure TFMCosecheros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;
     {MODIFICAR}
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
     // Cerrar tabla
  CerrarTablas;

     //Restauramos barra de herramientas
  if Fprincipal.MDIChildCount = 1 then
  begin
    if FormType <> tfDirector then
    begin
      FormType := tfDirector;
      BHFormulario;
    end;
  end;
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMCosecheros.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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

procedure TFMCosecheros.Filtro;
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

  if pertenece_grupo_c.State = cbChecked then
  begin
    if flag then where := where + ' and ';
    where := where + ' pertenece_grupo_c = ''S'' ';
    flag:= True;
  end;
  if pertenece_grupo_c.State = cbUnchecked then
  begin
    if flag then where := where + ' and ';
    where := where + ' pertenece_grupo_c = ''N'' ';
    flag:= True;
  end;

  if ajustar_c.State = cbChecked then
  begin
    if flag then where := where + ' and ';
    where := where + ' ajustar_c <> 0 ';
    flag:= True;
  end;
  if ajustar_c.State = cbUnchecked then
  begin
    if flag then where := where + ' and ';
    where := where + ' ajustar_c = 0 ';
    flag:= True;
  end;

  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMCosecheros.AnyadirRegistro;
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

procedure TFMCosecheros.ValidarEntradaMaestro;
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

procedure TFMCosecheros.Previsualizar;
var enclave: TBookMark;
begin
     //Crear el listado
  enclave := DataseTMaestro.GetBookmark;
  QRLCosecheros := TQRLCosecheros.Create(Application);
  PonLogoGrupoBonnysa(QRLCosecheros);
  QRLCosecheros.DataSet := QCosecheros;
  Preview(QRLCosecheros);
  DataseTMaestro.GotoBookmark(enclave);
  DataseTMaestro.FreeBookmark(enclave);
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMCosecheros.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kTipoVia: DespliegaRejilla(BGBTipoVia);
    kFederacion: DespliegaRejilla(BGBFederacion);
  end;
end;

procedure TFMCosecheros.AntesDeInsertar;
begin
  pertenece_grupo_c.Checked := true;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMCosecheros.AntesDeModificar;
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

procedure TFMCosecheros.AntesDeVisualizar;
var i: Integer;
begin
    //Restauramos estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMCosecheros.empresa_cExit(Sender: TObject);
begin
  STNomEmpresa.Caption := desEmpresa(empresa_c.Text);
end;

procedure TFMCosecheros.cod_postal_cChange(Sender: TObject);
begin
  STprovincia.Caption := desProvincia(cod_postal_c.Text);
end;

procedure TFMCosecheros.RequiredTime(Sender: TObject; var isTime: Boolean);
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

procedure TFMCosecheros.federacion_cChange(Sender: TObject);
begin
  STFederacion.Caption:= desFederacion( federacion_c.Text );
end;

end.

