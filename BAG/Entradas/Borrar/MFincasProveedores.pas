unit MFincasProveedores;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError, ComCtrls;

type
  TFMFincasProveedores = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    Label10: TLabel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    finca_pf: TBDEdit;
    descripcion_pf: TBDEdit;
    qryFincas: TQuery;
    qrySectores: TQuery;
    DSDetalle: TDataSource;
    Label13: TLabel;
    empresa_pf: TBDEdit;
    stEmpresa: TStaticText;
    PageControl: TPageControl;
    tsSectores: TTabSheet;
    PSectores: TPanel;
    Label1: TLabel;
    sector_ps: TBDEdit;
    descripcion_ps: TBDEdit;
    RSectores: TDBGrid;
    btnEmpresa: TBGridButton;
    RejillaFlotante: TBGrid;
    lblOpp: TLabel;
    btnProveedor: TBGridButton;
    proveedor_pf: TBDEdit;
    txtOpp: TStaticText;
    lblCosechero: TLabel;
    almacen_pf: TBDEdit;
    btnProveedorAlmacen: TBGridButton;
    txtCosecheros: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure qryFincasAfterOpen(DataSet: TDataSet);
    procedure qryFincasBeforeClose(DataSet: TDataSet);
    procedure qrySectoresNewRecord(DataSet: TDataSet);
    procedure empresa_pfChange(Sender: TObject);
    procedure proveedor_pfChange(Sender: TObject);
    procedure almacen_pfChange(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes, ListaDetalle: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AntesDeBorrarMaestro;
    procedure ValidarEntradaDetalle;
    procedure AntesDeBorrarDetalle;
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

    procedure VerDetalle;
    procedure EditarDetalle;

    //Listado
    procedure Previsualizar; override;

    procedure Altas; Override;
    procedure DetalleAltas; Override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, DPreview, UDMAuxDB, bSQLUtils,
  CMaestro, LFincasProveedor,UDMConfig;

{$R *.DFM}

procedure TFMFincasProveedores.AbrirTablas;
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

procedure TFMFincasProveedores.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMFincasProveedores.FormCreate(Sender: TObject);
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

  PageControl.ActivePage:= tsSectores;
  RejillaVisualizacion := RSectores;
  PanelDetalle := PSectores;

  //Panel
  PanelMaestro := PMaestro;

  //Fuente de datos
  DataSetMaestro:=qryFincas;
  DataSourceDetalle := DSDetalle;

  Select := ' SELECT * FROM frf_proveedores_fincas ';
  where := ' WHERE empresa_pf=' + QuotedStr('###');
  Order := ' ORDER BY proveedor_pf, almacen_pf, finca_pf ';
     //Para reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Abrir tablas/Querys

  with qrySectores.SQL do
  begin
    Clear;
    Add('select * from frf_proveedores_sectores ');
    Add('where empresa_ps = :empresa_pf ');
    Add('  and proveedor_ps = :proveedor_pf ');
    Add('  and almacen_ps = :almacen_pf ');
    Add('  and finca_ps = :finca_pf ');
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
  OnBeforeMasterDelete := AntesDeBorrarMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnBeforeDetailDelete := AntesDeBorrarDetalle;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
  OnBrowse:= AntesDeLocalizar;

  //Preparar panel de detalle
  OnViewDetail:=VerDetalle;
  OnEditDetail:=EditarDetalle;

     //Focos
  {+}FocoAltas := empresa_pf;
  {+}FocoModificar := descripcion_pf;
  {+}FocoLocalizar := empresa_pf;

  empresa_pf.Tag:= kEmpresa;
  proveedor_pf.Tag:= kProveedor;
  almacen_pf.Tag:= kProveedorAlmacen;
end;

procedure TFMFincasProveedores.FormActivate(Sender: TObject);
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

procedure TFMFincasProveedores.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF :=nil;
end;


procedure TFMFincasProveedores.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMFincasProveedores.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMFincasProveedores.Altas;
begin
  if not DMConfig.EsLaFont then
  begin
    //ShowMessage('Antes de dar de alta una nueva finca, recuerde darla de alta antes en la central.');
  end;
  inherited;
end;

procedure TFMFincasProveedores.DetalleAltas;
begin
  if not DMConfig.EsLaFont then
  begin
    //ShowMessage('Antes de dar de alta un nuevo sector de finca, recuerde darlo de alta antes en la central.');
  end;
  inherited;
end;

{+}//Sustituir por funcion generica

procedure TFMFincasProveedores.Filtro;
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

procedure TFMFincasProveedores.AnyadirRegistro;
var
  Flag: Boolean;
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

procedure TFMFincasProveedores.ValidarEntradaMaestro;
var
  i: Integer;
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

procedure TFMFincasProveedores.ValidarEntradaDetalle;
begin
  //
end;

procedure TFMFincasProveedores.AntesDeBorrarMaestro;
begin
  if ( not qrySectores.IsEmpty )  then
  begin
    raise Exception.Create('No se puede borrar la finca, primero borre los sectores.');
  end;
end;

procedure TFMFincasProveedores.AntesDeBorrarDetalle;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * From frf_recepcion_pinyas_l ');
    SQL.Add(' where empresa_rpl = :empresa ');
    SQL.Add(' and proveedor_rpl = :proveedor ');
    SQL.Add(' and almacen_rpl = :almacen ');
    SQL.Add(' and finca_rpl = :finca ');
    SQL.Add(' and sector_rpl = :sector ');

    ParamByName('empresa').AsString:= empresa_pf.Text;
    ParamByName('proveedor').AsString:= proveedor_pf.Text;
    ParamByName('almacen').AsString:= almacen_pf.Text;
    ParamByName('finca').AsString:= finca_pf.Text;
    ParamByName('sector').AsString:= sector_ps.Text;
    Open;
    if not IsEmpty then
    begin
      Close;
      raise Exception.Create('No se puede borrar el sector, ya esta utilizado en las recepciones de piña.');
    end;
    Close;
  end;
end;

procedure TFMFincasProveedores.Previsualizar;
var
  QRLFincasProveedor: TQRLFincasProveedor;
begin
  (*TODO*)
  ShowMessage('En desarrollo');
  Exit;
    QRLFincasProveedor := TQRLFincasProveedor.Create(Application);
    try
      QRLFincasProveedor.MontarListado( Where );
      PonLogoGrupoBonnysa(QRLFincasProveedor);
      Preview(QRLFincasProveedor);
    except
      FreeAndNil(QRLFincasProveedor);
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

procedure TFMFincasProveedores.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProveedor: DespliegaRejilla(btnProveedor, [empresa_pf.Text] );
    kProveedorAlmacen: DespliegaRejilla(btnProveedorAlmacen, [empresa_pf.Text, proveedor_pf.Text ]);
  end;
end;

procedure TFMFincasProveedores.AntesDeInsertar;
begin
  (*
  if not DMConfig.EsLaFont then
  begin
    ShowMessage('Antes de dar de alta un nuevo proveedor, recuerde darlo de alta antes en la central.');
  end;
  *)
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMFincasProveedores.AntesDeModificar;
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

procedure TFMFincasProveedores.AntesDeVisualizar;
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

procedure TFMFincasProveedores.AntesDeLocalizar;
begin
  //
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMFincasProveedores.RequiredTime(Sender: TObject; var isTime: Boolean);
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

procedure TFMFincasProveedores.qryFincasAfterOpen(DataSet: TDataSet);
begin
  qrySectores.Open;
end;

procedure TFMFincasProveedores.qryFincasBeforeClose(DataSet: TDataSet);
begin
  qrySectores.Close;
end;

procedure TFMFincasProveedores.VerDetalle;
begin
  PanelDetalle.Enabled:= false;
  PanelDetalle.Visible:= false;
  tsSectores.TabVisible:= True;
end;

procedure TFMFincasProveedores.EditarDetalle;
begin
  PanelDetalle.Enabled:= TRUE;
  PanelDetalle.Visible:= True;

  FocoDetalle:=sector_ps;
end;

procedure TFMFincasProveedores.qrySectoresNewRecord(DataSet: TDataSet);
begin
  qrySectores.FieldByName('empresa_ps').AsString := qryFincas.FieldByName('empresa_pf').AsString;
  qrySectores.FieldByName('proveedor_ps').AsString := qryFincas.FieldByName('proveedor_pf').AsString;
  qrySectores.FieldByName('almacen_ps').AsInteger := qryFincas.FieldByName('almacen_pf').AsInteger;
  qrySectores.FieldByName('finca_ps').AsInteger := qryFincas.FieldByName('finca_pf').AsInteger;
end;


procedure TFMFincasProveedores.empresa_pfChange(Sender: TObject);
begin
  stEmpresa.Caption:= desEmpresa( empresa_pf.Text );
  proveedor_pf.Change;
end;

procedure TFMFincasProveedores.proveedor_pfChange(Sender: TObject);
begin
  txtOpp.Caption:= desProveedor( empresa_pf.Text, proveedor_pf.Text );
  almacen_pf.Change;
end;

procedure TFMFincasProveedores.almacen_pfChange(Sender: TObject);
begin
  txtCosecheros.Caption:= desProveedorAlmacen( empresa_pf.Text, proveedor_pf.Text, almacen_pf.Text );
end;

end.


