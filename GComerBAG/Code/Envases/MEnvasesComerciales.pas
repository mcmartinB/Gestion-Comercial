unit MEnvasesComerciales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError, ComCtrls;

type
  TFMEnvasesComerciales = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    QOperadores: TQuery;
    QAlmacenes: TQuery;
    dsAlmacenes: TDataSource;
    PageControl: TPageControl;
    tsAlmacenes: TTabSheet;
    tsEnvases: TTabSheet;
    PAlmacenes: TPanel;
    Label1: TLabel;
    cod_almacen_eca: TBDEdit;
    des_almacen_eca: TBDEdit;
    RAlmacenes: TDBGrid;
    RProductos: TDBGrid;
    QProductos: TQuery;
    DSProductos: TDataSource;
    PProductos: TPanel;
    RejillaFlotante: TBGrid;
    lblCodigo: TLabel;
    cod_operador_eco: TBDEdit;
    LDescripcion_m: TLabel;
    des_operador_eco: TBDEdit;
    lbl1: TLabel;
    cod_producto_ecp: TBDEdit;
    des_producto_ecp: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure QOperadoresAfterOpen(DataSet: TDataSet);
    procedure QOperadoresBeforeClose(DataSet: TDataSet);
    procedure QAlmacenesNewRecord(DataSet: TDataSet);
    procedure PageControlChange(Sender: TObject);
    procedure QProductosNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    ListaComponentes, ListaDetalle: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure ValidarEntradaDetalle;
    procedure AbrirTablas;
    procedure CerrarTablas;


  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    procedure VerDetalle;
    procedure EditarDetalle;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, DPreview, UDMAuxDB, bSQLUtils,
  CMaestro, LEnvasesComerciales, UDMConfig;

{$R *.DFM}

procedure TFMEnvasesComerciales.AbrirTablas;
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

procedure TFMEnvasesComerciales.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMEnvasesComerciales.FormCreate(Sender: TObject);
begin
  Top := 1;

  LineasObligadas:= False;
  ListadoObligado:= False;
  MultipleAltas:= false;

  //Variables globales
  M:=Self;
  MD:=Self;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF :=nil;

  PageControl.ActivePage:= tsEnvases;
  DataSourceDetalle:=DSProductos;
  RejillaVisualizacion := RProductos;
  PanelDetalle := PProductos;


  //Panel
  PanelMaestro := PMaestro;

  //Fuente de datos
  DataSetMaestro:=QOperadores;

  Select := ' SELECT * FROM frf_env_comer_operadores ';
  where := ' WHERE cod_operador_eco=' + QuotedStr('###');
  Order := ' ORDER BY cod_operador_eco ';
     //Para reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Abrir tablas/Querys

  with QAlmacenes.SQL do
  begin
    Clear;
    Add('select * from frf_env_comer_almacenes ');
    Add('where cod_operador_eca = :cod_operador_eco ');
  end;
  with QProductos.SQL do
  begin
    Clear;
    Add('select * from frf_env_comer_productos ');
    Add('where cod_operador_ecp = :cod_operador_eco ');

  end;

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
  ListaComponentes := TList.Create;
  PMaestro.GetTabOrderList(ListaComponentes);
  ListaDetalle := TList.Create;
  ListaDetalle.Clear;
  PanelDetalle.GetTabOrderList(ListaDetalle);

  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestro then
  begin
    FormType := tfMaestroDetalle;
    BHFormulario;
  end;
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

  //Preparar panel de detalle
  OnViewDetail:=VerDetalle;
  OnEditDetail:=EditarDetalle;

     //Focos
  {+}FocoAltas := cod_operador_eco;
  {+}FocoModificar := des_operador_eco;
  {+}FocoLocalizar := cod_operador_eco;

end;

procedure TFMEnvasesComerciales.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  gCF :=nil;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestroDetalle then
  begin
    FormType := tfMaestroDetalle;
    BHFormulario;
  end;
  BHGrupoDesplazamientoMaestro(PCMaestro);
  BHGrupoDesplazamientoDetalle(PCDetalle);
end;

procedure TFMEnvasesComerciales.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF :=nil;
end;


procedure TFMEnvasesComerciales.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaComponentes.Free;
  ListaDetalle.Free;
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

procedure TFMEnvasesComerciales.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMEnvasesComerciales.Filtro;
var Flag: Boolean;
  i: Integer;
begin
  where := ''; Flag := false;
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
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

procedure TFMEnvasesComerciales.AnyadirRegistro;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';

  for i := 0 to ListaComponentes.Count - 1 do
  begin
    objeto := ListaComponentes.Items[i];
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

procedure TFMEnvasesComerciales.ValidarEntradaMaestro;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
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

procedure TFMEnvasesComerciales.ValidarEntradaDetalle;
begin
  if ( QProductos.State = dsInsert ) or
     ( QProductos.State = dsEdit ) then
  begin
    //
  end;
end;

procedure TFMEnvasesComerciales.Previsualizar;
var
  LEnvasesComerciales: TQRLEnvasesComerciales;
  bAlmacenes, bProductos: boolean;
begin
  LEnvasesComerciales := TQRLEnvasesComerciales.Create(Application);
  try
    LEnvasesComerciales.MontarListado( where );
    PonLogoGrupoBonnysa(LEnvasesComerciales);
    Preview(LEnvasesComerciales);
  except
    FreeAndNil(LEnvasesComerciales);
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

procedure TFMEnvasesComerciales.ARejillaFlotanteExecute(Sender: TObject);
begin
(*
  case ActiveControl.Tag of

  end;
*)
end;

procedure TFMEnvasesComerciales.AntesDeInsertar;
begin
  //Nada
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMEnvasesComerciales.AntesDeModificar;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
end;


//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEnvasesComerciales.AntesDeVisualizar;
var i: Integer;
begin
    //Restauramos estado
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
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

procedure TFMEnvasesComerciales.RequiredTime(Sender: TObject; var isTime: Boolean);
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

procedure TFMEnvasesComerciales.QOperadoresAfterOpen(DataSet: TDataSet);
begin
  QAlmacenes.Open;
  QProductos.Open;
end;

procedure TFMEnvasesComerciales.QOperadoresBeforeClose(DataSet: TDataSet);
begin
  QAlmacenes.Close;
  QProductos.Close;
end;

procedure TFMEnvasesComerciales.VerDetalle;
begin
  PanelDetalle.Enabled:= false;
  PanelDetalle.Visible:= false;
  tsAlmacenes.Enabled:= True;
  tsEnvases.Enabled:= True;
end;

procedure TFMEnvasesComerciales.EditarDetalle;
begin
  PanelDetalle.Enabled:= TRUE;
  PanelDetalle.Visible:= True;
  if PageControl.ActivePage = tsAlmacenes then
  begin
    FocoDetalle:=cod_almacen_eca;
    tsEnvases.Enabled:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QAlmacenes.Close;
      QAlmacenes.Open;
    end;
  end
  else
  begin
    FocoDetalle:=cod_producto_ecp;
    tsAlmacenes.Enabled:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QProductos.Close;
      QProductos.Open;
    end;
  end;
end;

procedure TFMEnvasesComerciales.QAlmacenesNewRecord(DataSet: TDataSet);
begin
  QAlmacenes.FieldByName('cod_operador_eca').AsString := QOperadores.FieldByName('cod_operador_eco').AsString;
end;


procedure TFMEnvasesComerciales.QProductosNewRecord(DataSet: TDataSet);
begin
  QProductos.FieldByName('cod_operador_ecp').AsString := QOperadores.FieldByName('cod_operador_eco').AsString;
end;

procedure TFMEnvasesComerciales.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage = tsAlmacenes then
  begin
    DataSourceDetalle:=DSAlmacenes;
    RejillaVisualizacion := RAlmacenes;
    PanelDetalle := PAlmacenes;
  end
  else
  begin
    DataSourceDetalle:=DSProductos;
    RejillaVisualizacion := RProductos;
    PanelDetalle := PProductos;
  end;
  ListaDetalle.Clear;
  PanelDetalle.GetTabOrderList(ListaDetalle);
end;

end.
