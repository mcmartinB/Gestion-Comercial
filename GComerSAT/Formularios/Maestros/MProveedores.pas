unit MProveedores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError, ComCtrls;

type
  TFMProveedores = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    Label2: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    proveedor_p: TBDEdit;
    telefono1_p: TBDEdit;
    nombre_p: TBDEdit;
    domicilio_p: TBDEdit;
    poblacion_p: TBDEdit;
    cod_postal_p: TBDEdit;
    STProvincia: TStaticText;
    QProveedores: TQuery;
    telefono2_p: TBDEdit;
    Label4: TLabel;
    fax_p: TBDEdit;
    Label11: TLabel;
    cta_contable_p: TBDEdit;
    Label6: TLabel;
    Label9: TLabel;
    pagina_web_p: TBDEdit;
    email_p: TBDEdit;
    Label12: TLabel;
    forma_pago_p: TBDEdit;
    BGBFormaPago: TBGridButton;
    mmoFormaPago: TMemo;
    QAlmacenes: TQuery;
    DSAlmacenes: TDataSource;
    Label13: TLabel;
    empresa_p: TBDEdit;
    stEmpresa: TStaticText;
    PageControl: TPageControl;
    tsAlmacenes: TTabSheet;
    tsProductos: TTabSheet;
    PAlmacenes: TPanel;
    Label1: TLabel;
    almacen_pa: TBDEdit;
    nombre_pa: TBDEdit;
    RAlmacenes: TDBGrid;
    RProductos: TDBGrid;
    QProductos: TQuery;
    DSProductos: TDataSource;
    PProductos: TPanel;
    Label3: TLabel;
    producto_pp: TBDEdit;
    descripcion_pp: TBDEdit;
    Label14: TLabel;
    variedad_pp: TBDEdit;
    Label15: TLabel;
    descripcion_breve_pp: TBDEdit;
    Label16: TLabel;
    Label17: TLabel;
    marca_pp: TBDEdit;
    Label18: TLabel;
    pais_origen_pp: TBDEdit;
    Label19: TLabel;
    presentacion_pp: TBDEdit;
    Label20: TLabel;
    peso_paleta_pp: TBDEdit;
    Label21: TLabel;
    peso_cajas_pp: TBDEdit;
    Label22: TLabel;
    cajas_paleta_pp: TBDEdit;
    Label23: TLabel;
    codigo_ean_pp: TBDEdit;
    BGBEmpresa: TBGridButton;
    stProducto: TStaticText;
    stPais: TStaticText;
    BGBProducto: TBGridButton;
    BGBPais: TBGridButton;
    RejillaFlotante: TBGrid;
    Label24: TLabel;
    pais_p: TBDEdit;
    BGBPais_p: TBGridButton;
    stPais_p: TStaticText;
    Label25: TLabel;
    unidades_caja_pp: TBDEdit;
    Label26: TLabel;
    unidad_precio_pp: TBDEdit;
    cbxUnidad_precio_pp: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure cod_postal_pChange(Sender: TObject);
    procedure forma_pago_pChange(Sender: TObject);
    procedure QProveedoresAfterOpen(DataSet: TDataSet);
    procedure QProveedoresBeforeClose(DataSet: TDataSet);
    procedure QAlmacenesNewRecord(DataSet: TDataSet);
    procedure PageControlChange(Sender: TObject);
    procedure QProductosNewRecord(DataSet: TDataSet);
    procedure empresa_pChange(Sender: TObject);
    procedure producto_ppChange(Sender: TObject);
    procedure pais_origen_ppChange(Sender: TObject);
    procedure pais_origen_ppEnter(Sender: TObject);
    procedure cbxUnidad_precio_ppChange(Sender: TObject);
    procedure unidad_precio_ppChange(Sender: TObject);
    procedure cbxUnidad_precio_ppEnter(Sender: TObject);
    procedure cbxUnidad_precio_ppExit(Sender: TObject);
    procedure pais_pChange(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes, ListaDetalle: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure ValidarEntradaDetalle;
    procedure AntesDeBorrarMaestro;
    procedure AntesDeBorrarDetalle;
    procedure AbrirTablas;
    procedure CerrarTablas;

    function NuevoCodigoVariedad( const AEmpresa: String): integer;

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
  CMaestro, LProveedoresEx, LDProveedores, UDMConfig;

{$R *.DFM}

procedure TFMProveedores.AbrirTablas;
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

procedure TFMProveedores.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMProveedores.FormCreate(Sender: TObject);
begin
  Top := 1;

  LineasObligadas:= true;
  ListadoObligado:= False;
  MultipleAltas:= false;

  //Variables globales
  M:=Self;
  MD:=Self;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF :=nil;

  PageControl.ActivePage:= tsAlmacenes;
  DataSourceDetalle:=DSAlmacenes;
  RejillaVisualizacion := RAlmacenes;
  PanelDetalle := PAlmacenes;

  //Panel
  PanelMaestro := PMaestro;

  //Fuente de datos
  DataSetMaestro:=QProveedores;

  Select := ' SELECT * FROM frf_proveedores ';
  where := ' WHERE proveedor_p=' + QuotedStr('###');
  Order := ' ORDER BY proveedor_p ';
     //Para reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Abrir tablas/Querys

  with QAlmacenes.SQL do
  begin
    Clear;
    Add('select * from frf_proveedores_almacen ');
    Add('where empresa_pa = :empresa_p ');
    Add('  and proveedor_pa = :proveedor_p ');
    Add('order by empresa_pa, proveedor_pa, almacen_pa ');
  end;

  with QProductos.SQL do
  begin
    Clear;
    Add('select * from frf_productos_proveedor ');
    Add('where empresa_pp = :empresa_p ');
    Add('  and proveedor_pp = :proveedor_p ');
    Add('order by empresa_pp, proveedor_pp, producto_pp, variedad_pp ');

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
  OnBeforeMasterDelete := AntesDeBorrarMaestro;
  OnBeforeDetailDelete := AntesDeBorrarDetalle;
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;

  //Preparar panel de detalle
  OnViewDetail:=VerDetalle;
  OnEditDetail:=EditarDetalle;

     //Focos
  {+}FocoAltas := empresa_p;
  {+}FocoModificar := nombre_p;
  {+}FocoLocalizar := empresa_p;

  empresa_p.Tag:= kEmpresa;
  forma_pago_p.Tag:= kFormaPago;
  producto_pp.Tag:= kProducto;
  pais_p.Tag:= kPais;
  pais_origen_pp.Tag:= kPais;
end;

procedure TFMProveedores.FormActivate(Sender: TObject);
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

procedure TFMProveedores.FormDeactivate(Sender: TObject);
begin
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF :=nil;
end;


procedure TFMProveedores.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMProveedores.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMProveedores.Filtro;
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

procedure TFMProveedores.AnyadirRegistro;
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

procedure TFMProveedores.ValidarEntradaMaestro;
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
  //La forma de pago debe de existir
  if ( mmoFormaPago.Text = '' ) then
  begin
    if forma_pago_p.Text <> '' then
    begin
      raise Exception.Create('La forma de pago del cliente es icorrecta.');
    end;
  end;

end;

procedure TFMProveedores.ValidarEntradaDetalle;
begin
  if ( QProductos.State = dsInsert ) or
     ( QProductos.State = dsEdit ) then
  begin
    if peso_paleta_pp.Text = '' then
      QProductos.FieldByName('peso_paleta_pp').AsInteger:=  0;
    if peso_cajas_pp.Text = '' then
      QProductos.FieldByName('peso_cajas_pp').AsInteger:=  0;
    if cajas_paleta_pp.Text = '' then
      QProductos.FieldByName('cajas_paleta_pp').AsInteger:=  0;
    if unidades_caja_pp.Text = '' then
      QProductos.FieldByName('unidades_caja_pp').AsInteger:=  0;
  end;
end;

procedure TFMProveedores.Previsualizar;
var
  QRLProveedoresEx: TQRLProveedoresEx;
  bAlmacenes, bProductos: boolean;
begin
  if LDProveedores.VisualizarDetalle( self, bAlmacenes, bProductos ) then
  begin
    QRLProveedoresEx := TQRLProveedoresEx.Create(Application);
    try
      QRLProveedoresEx.MontarListado( Where, bAlmacenes, bProductos );
      PonLogoGrupoBonnysa(QRLProveedoresEx);
      Preview(QRLProveedoresEx);
    except
      FreeAndNil(QRLProveedoresEx);
    end;
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

procedure TFMProveedores.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kFormaPago: DespliegaRejilla(BGBFormaPago);
    kProducto: DespliegaRejilla(BGBProducto, [empresa_p.Text]);
    kPais:
    if pais_p.Focused then
      DespliegaRejilla(BGBPais_p)
    else
    if pais_origen_pp.Focused then
    begin
      (*TODO*)
      if empresa_p.text = 'F17' then
        DespliegaRejilla(BGBPais, [empresa_p.text, producto_pp.Text ])
      else
        DespliegaRejilla(BGBPais);
    end;
  end;
end;

procedure TFMProveedores.AntesDeInsertar;
begin
  //Nada
  pais_p.Text:= 'ES';
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMProveedores.AntesDeModificar;
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

procedure TFMProveedores.AntesDeVisualizar;
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

procedure TFMProveedores.AntesDeBorrarMaestro;
begin
  if ( not QAlmacenes.IsEmpty ) or ( not QProductos.IsEmpty ) then
  begin
    raise Exception.Create('No se puede borrar la proveedor, primero borre el detalle.');
  end;
end;


procedure TFMProveedores.AntesDeBorrarDetalle;
begin
  if PageControl.ActivePage = tsProductos then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_entregas_l ');
    SQL.Add(' where empresa_el = :empresa ');
    SQL.Add(' and proveedor_el = :proveedor ');
    SQL.Add(' and producto_el = :producto ');
    SQL.Add(' and variedad_el = :variedad ');
    ParamByName('empresa').AsString:= empresa_p.Text;
    ParamByName('proveedor').AsString:= proveedor_p.Text;
    ParamByName('producto').AsString:= producto_pp.Text;
    ParamByName('variedad').AsString:= variedad_pp.Text;
    Open;
    if not IsEmpty then
    begin
      Close;
      raise Exception.Create('No se puede borrar la variedad, ya esta utilizada en las entregas del proveedor.');
    end;
    Close;

    SQL.Clear;
    SQL.Add(' select * from rf_palet_pb ');
    SQL.Add(' where empresa = :empresa ');
    SQL.Add(' and proveedor = :proveedor ');
    SQL.Add(' and producto = :producto ');
    SQL.Add(' and variedad = :variedad ');
    ParamByName('empresa').AsString:= empresa_p.Text;
    ParamByName('proveedor').AsString:= proveedor_p.Text;
    ParamByName('producto').AsString:= producto_pp.Text;
    ParamByName('variedad').AsString:= variedad_pp.Text;
    Open;
    if not IsEmpty then
    begin
      Close;
      raise Exception.Create('No se puede borrar la variedad, ya esta utilizada en la RF.');

    end;
    Close;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMProveedores.cod_postal_pChange(Sender: TObject);
begin
  if ( Length(Trim(pais_p.Text)) = 2 ) and ( Trim(pais_p.Text) = 'ES' ) then
    STprovincia.Caption := desProvincia(cod_postal_p.Text)
  else
    STprovincia.Caption := '';
end;

procedure TFMProveedores.RequiredTime(Sender: TObject; var isTime: Boolean);
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

procedure TFMProveedores.forma_pago_pChange(Sender: TObject);
begin
  mmoFormaPago.Lines.Clear;
  mmoFormaPago.Lines.Add(desFormaPagoEx(forma_pago_p.Text));
  mmoFormaPago.SelStart := 0;
  mmoFormaPago.SelLength := 0;
end;

procedure TFMProveedores.QProveedoresAfterOpen(DataSet: TDataSet);
begin
  QAlmacenes.Open;
  QProductos.Open;
end;

procedure TFMProveedores.QProveedoresBeforeClose(DataSet: TDataSet);
begin
  QAlmacenes.Close;
  QProductos.Close;
end;

procedure TFMProveedores.VerDetalle;
begin
  PanelDetalle.Enabled:= false;
  PanelDetalle.Visible:= false;
  PanelMaestro.Height:= 307;
  tsAlmacenes.TabVisible:= True;
  tsProductos.TabVisible:= True;
end;

procedure TFMProveedores.EditarDetalle;
begin
  PanelDetalle.Enabled:= TRUE;
  PanelDetalle.Visible:= True;
  PanelMaestro.Height:= 237;
  if PageControl.ActivePage = tsAlmacenes then
  begin
    FocoDetalle:=almacen_pa;
    tsProductos.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QAlmacenes.Close;
      QAlmacenes.Open;
    end;
  end
  else
  begin
    FocoDetalle:=variedad_pp;
    tsAlmacenes.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QProductos.Close;
      QProductos.Open;
    end;
  end;
end;

procedure TFMProveedores.QAlmacenesNewRecord(DataSet: TDataSet);
begin
  QAlmacenes.FieldByName('empresa_pa').AsString := QProveedores.FieldByName('empresa_p').AsString;
  QAlmacenes.FieldByName('proveedor_pa').AsString := QProveedores.FieldByName('proveedor_p').AsString;
end;

function TFMProveedores.NuevoCodigoVariedad( const AEmpresa: String): integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(variedad_pp) contador ');
    SQL.Add(' from frf_productos_proveedor ');
    SQL.Add(' where empresa_pp = :empresa ');
    ParamByName('empresa').AsString:= AEmpresa;
    try
      Open;
      result:= FieldByName('contador').AsInteger + 1;
    finally
      Close;
    end;
  end;
end;

procedure TFMProveedores.QProductosNewRecord(DataSet: TDataSet);
begin
  QProductos.FieldByName('empresa_pp').AsString := QProveedores.FieldByName('empresa_p').AsString;
  QProductos.FieldByName('proveedor_pp').AsString := QProveedores.FieldByName('proveedor_p').AsString;
  QProductos.FieldByName('variedad_pp').AsInteger := NuevoCodigoVariedad( QProveedores.FieldByName('empresa_p').AsString );
  QProductos.FieldByName('unidad_precio_pp').AsInteger := 0;
  cbxUnidad_precio_pp.ItemIndex:= 0;
end;

procedure TFMProveedores.PageControlChange(Sender: TObject);
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

procedure TFMProveedores.empresa_pChange(Sender: TObject);
begin
  stEmpresa.Caption:= desEmpresa( empresa_p.Text );
  cod_postal_pChange( cod_postal_p );
end;

procedure TFMProveedores.producto_ppChange(Sender: TObject);
begin
  stProducto.Caption:= desProducto( empresa_p.Text, producto_pp.Text );
end;

procedure TFMProveedores.pais_origen_ppChange(Sender: TObject);
begin
  stPais.Caption:= desPais( pais_origen_pp.Text );
end;

procedure TFMProveedores.pais_origen_ppEnter(Sender: TObject);
begin
  if ( pais_origen_pp.Text = '' ) and ( pais_p.Text <> '' ) then
    pais_origen_pp.Text:= pais_p.Text;
end;

procedure TFMProveedores.cbxUnidad_precio_ppChange(Sender: TObject);
begin
  if ( QProductos.State = dsInsert ) or ( QProductos.State = dsEdit ) then
  begin
    QProductos.FieldByName('unidad_precio_pp').AsInteger:= cbxUnidad_precio_pp.ItemIndex;
  end;
end;

procedure TFMProveedores.unidad_precio_ppChange(Sender: TObject);
begin
  if QProductos.State = dsBrowse then
  begin
    if not QProductos.IsEmpty then
    begin
      if ( QProductos.FieldByName('unidad_precio_pp').AsInteger < cbxUnidad_precio_pp.Items.Count ) then
        cbxUnidad_precio_pp.ItemIndex:= QProductos.FieldByName('unidad_precio_pp').AsInteger
      else
        cbxUnidad_precio_pp.ItemIndex:= 0;
    end
    else
    begin
      cbxUnidad_precio_pp.ItemIndex:= 0;
    end;
  end;
end;

procedure TFMProveedores.cbxUnidad_precio_ppEnter(Sender: TObject);
begin
  cbxUnidad_precio_pp.Color:= clMoneyGreen;
end;

procedure TFMProveedores.cbxUnidad_precio_ppExit(Sender: TObject);
begin
  cbxUnidad_precio_pp.Color:= clWindow;
end;

procedure TFMProveedores.pais_pChange(Sender: TObject);
begin
  stPais_p.Caption:= desPais( pais_p.Text );
end;

end.
