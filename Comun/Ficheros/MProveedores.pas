unit MProveedores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BEdit, BDEdit,
  dbtables, DError, ComCtrls, nbEdits, nbCombos, nbLabels, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinBlue, dxSkinBlueprint, dxSkinFoggy, dxSkinMoneyTwins,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid;

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
    PageControl: TPageControl;
    tsAlmacenes: TTabSheet;
    tsProductos: TTabSheet;
    PAlmacenes: TPanel;
    Label1: TLabel;
    almacen_pa: TBDEdit;
    nombre_pa: TBDEdit;
    RAlmacenes: TDBGrid;
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
    QAlmacenesAux: TQuery;
    QProductosAux: TQuery;
    lblEmail: TLabel;
    pnlBoton: TPanel;
    lblFechaBaja: TLabel;
    fecha_baja_pp: TBDEdit;
    lblpais_pa: TLabel;
    pais_pa: TBDEdit;
    btnPais_pa: TBGridButton;
    txtPais_pa: TStaticText;
    lbl2: TLabel;
    propio_p: TDBCheckBox;
    QCostes: TQuery;
    dsCostes: TDataSource;
    QCostesproveedor_pc: TStringField;
    QCostestipo_coste_pc: TStringField;
    QCostesimporte_pc: TFloatField;
    QCostesfecha_ini_pc: TDateField;
    QCostesfecha_fin_pc: TDateField;
    QCostesdescripcion: TStringField;
    tsCostes: TTabSheet;
    rCostes: TDBGrid;
    PCostes: TPanel;
    lbl3: TLabel;
    BGBTipoCoste: TBGridButton;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    tipo_coste_pc: TBDEdit;
    stDesTipoCoste: TStaticText;
    fecha_fin_pc: TnbDBCalendarCombo;
    rbCostesTodos: TRadioButton;
    rbCostesActivos: TRadioButton;
    fecha_ini_pc: TnbDBCalendarCombo;
    importe_pc: TBDEdit;
    qCostesAux: TQuery;
    RProductos: TcxGrid;
    tvDetalleLineas: TcxGridDBTableView;
    tvProducto: TcxGridDBColumn;
    tvVariedad: TcxGridDBColumn;
    tvCodigo_ean: TcxGridDBColumn;
    tvDescripcion: TcxGridDBColumn;
    tvDescripcionBreve: TcxGridDBColumn;
    tvMarca: TcxGridDBColumn;
    tvPaisOrigen: TcxGridDBColumn;
    tvPresentacion: TcxGridDBColumn;
    tvPesoPaleta: TcxGridDBColumn;
    tvPesoCaja: TcxGridDBColumn;
    tvCajasPaleta: TcxGridDBColumn;
    tvFechaBaja: TcxGridDBColumn;
    lvDetalleLineas: TcxGridLevel;
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
    procedure producto_ppChange(Sender: TObject);
    procedure pais_origen_ppChange(Sender: TObject);
    procedure pais_origen_ppEnter(Sender: TObject);
    procedure cbxUnidad_precio_ppChange(Sender: TObject);
    procedure unidad_precio_ppChange(Sender: TObject);
    procedure cbxUnidad_precio_ppEnter(Sender: TObject);
    procedure cbxUnidad_precio_ppExit(Sender: TObject);
    procedure proveedor_pExit(Sender: TObject);
    procedure QProveedoresAfterPost(DataSet: TDataSet);
    procedure QAlmacenesAfterPost(DataSet: TDataSet);
    procedure QProductosAfterPost(DataSet: TDataSet);
    procedure pais_pChange(Sender: TObject);
    procedure pais_paChange(Sender: TObject);
    procedure QCostesNewRecord(DataSet: TDataSet);
    procedure tipo_coste_pcChange(Sender: TObject);
    procedure QCostesCalcFields(DataSet: TDataSet);
    procedure rbCostesActivosClick(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
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

    function NuevoCodigoVariedad( const AProveedor: String): integer;
    function ValidarValues: boolean;

    function  ActualizarFechaFinAlta ( const AProveedor, ATipoCoste: String; var VFechaFin: TDateTime ): boolean;

    procedure LoadCabecera;
    procedure LoadDetalle;

    function ObtenerCodigoProveedor: string;

    procedure GetProveedorBDRemota( const ABDRemota: string; const AAlta: Boolean );
    procedure BuscarProveedor( const AProveedor: string );
    procedure RefrescarProveedor;


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

    procedure MiAlta;
    procedure Altas; Override;
    procedure Modificar; override;
    procedure DetalleAltas; Override;
    procedure DetalleModificar; Override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, DPreview, UDMAuxDB, bSQLUtils,
  CMaestro, LDProveedores, LProveedoresEx, UDMConfig,
  SeleccionarClonarProveedorFD, AdvertenciaFD, ImportarProveedorFD;

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

  LineasObligadas:= False;
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
    Add('where proveedor_pa = :proveedor_p ');
  end;

  with QProductos.SQL do
  begin
    Clear;
    Add('select * from frf_productos_proveedor ');
    Add('where proveedor_pp = :proveedor_p ');
  end;

  with QCostes do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_proveedores_costes ');
    SQL.Add(' where proveedor_pc = :proveedor_p ');
    SQL.Add(' order by proveedor_pc, tipo_coste_pc, fecha_ini_pc ');

    Filtered:= True;
    filter:= 'fecha_fin_pc is null';

  end;

  (*BAG*)
  with QAlmacenesAux.SQL do
  begin
    Clear;
    Add('select * from frf_proveedores_almacen ');
  end;

  (*BAG*)
  with QProductosAux.SQL do
  begin
    Clear;
    Add('select * from frf_productos_proveedor ');
  end;

  (*BAG*)
  with QCostesAux.SQL do
  begin
    Clear;
    Add('select * from frf_proveedores_costes ');
    Add(' where proveedor_pc = :proveedor_pc ');
    Add('   and tipo_coste_pc = :coste_pc ');
    Add('  order by proveedor_pc, tipo_coste_pc, fecha_ini_pc ');
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
  {+}FocoAltas := nombre_p;
  {+}FocoModificar := nombre_p;
  {+}FocoLocalizar := proveedor_p;

  forma_pago_p.Tag:= kFormaPago;
  producto_pp.Tag:= kProducto;
  tipo_coste_pc.Tag:= kTipoCoste;
  pais_p.Tag:= kPais;
  pais_pa.Tag:= kPais;
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
  if RProductos.IsFocused then
    Exit;
  
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

procedure TFMProveedores.GetProveedorBDRemota(const ABDRemota: string; const AAlta: Boolean);
var
  sProveedor: string;
  iValue: Integer;
  bAlta: Boolean;
begin
  if AAlta then
    sProveedor:= ''
  else
    sProveedor:= proveedor_p.Text;
  bAlta:= AAlta;

  iValue:= ImportarProveedor( Self, ABDRemota, sProveedor );
  case iValue of
      -1: //Operacion cancelada
          begin end;
       1: begin
            if bAlta then
            begin
              BuscarProveedor( sProveedor );
              //ShowMessage('Alta de envase correcta.');
            end
            else
            begin
              RefrescarProveedor;
              //ShowMessage('Modificación de envase correcta.');
            end;
          end;
       else ShowMessage('Error ' + IntToStr( iValue ) + ' al importar el Proveedor.');
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

procedure TFMProveedores.LoadCabecera;
var
  sProveedor: string;
begin
{
  sProveedor:= '';
  if LoadProveedorFD.LoadProveedor( Self, sProveedor ) then
  begin
    DataSetMaestro.Close;
    where := ' WHERE proveedor_p=' + QuotedStr( sProveedor );
    AbrirTablas;
    Visualizar;
  end;
}
end;

procedure TFMProveedores.Altas;
begin
  if DMConfig.EsLaFontEx then
  begin
    MiAlta;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetProveedorBDRemota( 'BDCentral', True );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Proveedor') = mrIgnore then
        MiAlta;
    end;
  end;
end;

procedure TFMProveedores.MiAlta;
var
 sOldProveedor, sNewProveedor, sMsg: string;
begin
  sOldproveedor:= proveedor_p.Text;
  if SeleccionarClonarproveedorFD.SeleccionarClonarproveedor( sOldproveedor, sNewproveedor ) then
  begin
    if not SeleccionarClonarproveedorFD.Clonarproveedor( sOldproveedor, sNewproveedor, sMsg ) then
    begin
      ShowMessage( sMsg );
    end
    else
    begin
      inherited Localizar;
      proveedor_p.Text:= sNewproveedor;
      inherited AceptarLocalizar;
    end;
  end
  else
  begin
    inherited Altas;
  end;
end;

procedure TFMProveedores.Modificar;
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited Modificar;
  end
  else
  begin
    //inherited Modificar;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetProveedorBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Cualquier cambio que realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer modificaciones locales', 'Modificar Proveedores') = mrIgnore then
        inherited Modificar;
    end;
  end;
end;

procedure TFMProveedores.LoadDetalle;
var
  sProveedor, sAlmacen, sProducto, sVariedad: string;
begin
{
  sProveedor:= proveedor_p.Text;
  if PageControl.ActivePage = tsAlmacenes then
  begin
    sAlmacen:= '';
    LoadAlmacenProveedorlFD.LoadAlmacenProveedor( Self, sProveedor, sAlmacen );
  end
  else
  begin
    sProducto:= '';
    sVariedad:= '';
    LoadProductosProveedorlFD.LoadProductosProveedor( Self, sProveedor, sProducto, sVariedad );
  end;
  DataSourceDetalle.DataSet.Close;
  DataSourceDetalle.DataSet.Open;
  Visualizar;
}
end;

procedure TFMProveedores.DetalleAltas;
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited DetalleAltas;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetProveedorBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Proveedor') = mrIgnore then
        inherited DetalleAltas;
    end;
  end;
{
  tipo_coste_pc.Enabled := true;
  BGBTipoCoste.Enabled := true;
  fecha_ini_pc.Enabled := true;

  if not DMConfig.EsLaFontEx then
  begin
    ShowMessage('Antes de dar de alta un nuevo almacén/variedad de proveedor, recuerde darlo de alta antes en la central.');
  end;
  inherited;
}
end;

procedure TFMProveedores.DetalleModificar;
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited DetalleModificar;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetProveedorBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Proveedor') = mrIgnore then
        inherited DetalleModificar;
    end;
  end;
{
  begin
    inherited;
  end;
}
end;

procedure TFMProveedores.DSMaestroDataChange(Sender: TObject; Field: TField);
begin
  tsCostes.TabVisible := (propio_p.State = cbchecked );
end;

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
{
  if liquidar_p.State <> cbGrayed then
  begin
    if liquidar_p.State = cbUnchecked then
    begin
      if flag then where := where + ' AND ';
      where := where + ' liquidar_p = 0 ';
      flag := True;
    end
    else
    begin
      if flag then where := where + ' AND ';
      where := where + ' liquidar_p = 1 ';
      flag := True;
    end;
  end;
}
  if propio_p.State <> cbGrayed then
  begin
    if propio_p.State = cbUnchecked then
    begin
      if flag then where := where + ' AND ';
      where := where + ' propio_p = 0 ';
      flag := True;
    end
    else
    begin
      if flag then where := where + ' AND ';
      where := where + ' propio_p = 1 ';
      flag := True;
    end;
  end;

  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMProveedores.AnyadirRegistro;
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

procedure TFMProveedores.ValidarEntradaMaestro;
var
  i: Integer;
  sAux: string;
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


  (*BAG*)
  //Buscar si esta grabado
  if Estado = teAlta then
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_proveedores ');
      SQL.Add(' where proveedor_p = ' + Trim( proveedor_p.Text ) );
      Open;
      if not IsEmpty then
      begin
        sAux:= 'Proveedor duplicado. (' + Trim( proveedor_p.Text ) + '-' + Trim( nombre_p.Text )  + ').';
        Close;
        raise Exception.Create( sAux );
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_proveedores ');
      SQL.Add(' where proveedor_p = ' + Trim( proveedor_p.Text ) );
      Open;
      if not IsEmpty then
      begin
        if FieldByName('nombre_p').AsString <> nombre_p.Text then
        begin
          sAux:= 'Ya hay un proveedor con el mismo código y diferente descripción (' + FieldByName('nombre_p').AsString + ').';
          Close;
          raise Exception.Create( sAux );
        end;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_proveedores ');
      SQL.Add(' where nombre_p = ' + QuotedStr( Trim( nombre_p.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        if FieldByName('proveedor_p').AsString <> proveedor_p.Text then
        begin
          sAux:= 'Ya hay un proveedor con la misma descripción y diferente código (' + FieldByName('proveedor_p').AsString + ').';
          Close;
          raise Exception.Create( sAux );
        end;
      end;
      Close;
    end;
  end;

  //La forma de pago debe de existir
  if ( mmoFormaPago.Text = '' ) then
  begin
    if forma_pago_p.Text <> '' then
    begin
      raise Exception.Create('La forma de pago del proveedor es incorrecta.');
    end;
  end;

  if (Copy(cod_postal_p.Text,1,2) = '35') or (Copy(cod_postal_p.Text,1,2) = '38') then
    if not propio_p.Checked then
        ShowMessage('Si es un Proveedor de la empresa, se debe marcar el campo Proveedor Propio ');

end;

function TFMProveedores.ValidarValues: boolean;
var dFechaIni: TDateTime;
begin
  if tipo_coste_pc.Text = '' then
  begin
    raise Exception.Create('Falta introducir el tipo de coste.');
  end;

  if TryStrToDate( fecha_ini_pc.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_pc.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFMProveedores.ValidarEntradaDetalle;
var dFechaIni, dFechaFin: TDateTime;
begin
  if ( QProductos.State = dsInsert ) or ( QProductos.State = dsEdit ) then
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
  if (QCOstes.State = dsInsert ) or (QCostes.State = dsEdit) then
  begin
    if ValidarValues then
      if EstadoDetalle = tedAlta then
      begin
        TryStrToDate( fecha_ini_pc.Text, dFechaIni );
        dFechaFin:= dFechaIni;
        if ActualizarFechaFinAlta( QCostes.FieldByName('proveedor_pc').AsString,
                                   QCostes.FieldByName('tipo_coste_pc').AsString, dFechaFin ) then
        begin
          QCostes.FieldByName('fecha_fin_pc').AsDateTime:= dFechaFin;
        end;
      end;
  end;
end;

function TFMProveedores.ActualizarFechaFinAlta ( const AProveedor, ATipoCoste: String; var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QCostesAux.ParamByName('proveedor_pc').AsString := AProveedor;
  QCostesAux.ParamByName('coste_pc').AsString := ATipoCoste;
  QCostesAux.Open;
  try
    if not QCostesAux.IsEmpty then
    begin
      while ( QCostesAux.FieldByName('fecha_ini_pc').AsDateTime < VFechaFin ) and
            ( not QCostesAux.Eof ) do
      begin
        bAnt:= True;
        QCostesAux.Next;
      end;
      if QCostesAux.FieldByName('fecha_ini_pc').AsDateTime <> VFechaFin then
      begin
        if QCostesAux.Eof then
        begin
          //Estoy en
          QCostesAux.Edit;
          QCostesAux.FieldByName('fecha_fin_pc').AsDateTime:= VFechaFin - 1;
          QCostesAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QCostesAux.Prior;
            QCostesAux.Edit;
            QCostesAux.FieldByName('fecha_fin_pc').AsDateTime:= VFechaFin - 1;
            QCostesAux.Post;
            QCostesAux.Next;
          end;
          //Hay siguiente
          if not QCostesAux.Eof then
          begin
            VFechaFin:= QCostesAux.FieldByName('fecha_ini_pc').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QCostesAux.Close;
  end;
end;

procedure TFMProveedores.AntesDeBorrarMaestro;
begin
  if ( not QAlmacenes.IsEmpty ) or ( not QProductos.IsEmpty ) or ( not QCostes.IsEmpty) then
  begin
    raise Exception.Create('No se puede borrar el proveedor, primero borre el detalle.');
  end;
end;

procedure TFMProveedores.AntesDeBorrarDetalle;
var
  dIniAux, dFinAux: TDateTime;
begin
  if PageControl.ActivePage = tsProductos then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_entregas_l ');
    SQL.Add(' where proveedor_el = :proveedor ');
    SQL.Add(' and producto_el = :producto ');
    SQL.Add(' and variedad_el = :variedad ');
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
    SQL.Add(' where proveedor = :proveedor ');
    SQL.Add(' and producto = :producto ');
    SQL.Add(' and variedad = :variedad ');
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
  if PageControl.ActivePAge = tsCostes then
  begin
    if not QCostes.IsEmpty then
    begin
      with qCostesAux do
      begin
        if Active then
          Close;
        ParamByName('proveedor_pc').AsString := QCostes.FieldByName('proveedor_pc').AsString;
        ParamByName('coste_pc').AsString := QCostes.FieldByName('tipo_coste_pc').AsString;
        Open;
        if qCostesAux.RecordCount = 1 then
          Exit;
        First;
        while not eof do
        begin
          if not (QCostesAux.FieldByName('fecha_ini_pc').AsString = QCostes.FieldByName('fecha_ini_pc').AsString) then
            Next
          else
            Break;
        end;

        if QCostesAux.FieldByName('fecha_fin_pc').AsString = '' then
        begin
  //        QCostes.Delete;
          if not QCostesAux.IsEmpty then
          begin
            QCostesAux.Prior;
            QCostesAux.Edit;
            QCostesAux.FieldByName('fecha_fin_pc').AsString:= '';
            QCostesAux.Post;
          end;
        end
        else
        begin
  //        QRiesgo.Delete;
          dIniAux:=  QCostesAux.FieldByName('fecha_ini_pc').AsDateTime;
          dFinAux:= QCostesAux.FieldByName('fecha_fin_pc').AsDateTime;
          QCostesAux.Prior;
          if dIniAux <> QCostesAux.FieldByName('fecha_ini_pc').AsDateTime then
          begin
            QCostesAux.Edit;
            QCostesAux.FieldByName('fecha_fin_pc').AsDateTime:= dFinAux;
            QCostesAux.Post;
          end;
        end;
      end;
    end;
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

    //Formulario maximizado
    Self.WindowState := wsMaximized;
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
    kFormaPago: DespliegaRejilla(BGBFormaPago);
    kProducto: DespliegaRejilla(BGBProducto);
    ktipoCoste: DespliegaRejilla(BGBTipoCoste);
    kPais:
    if pais_p.Focused then
      DespliegaRejilla(BGBPais_p)
    else
    if pais_pa.Focused then
      DespliegaRejilla(btnPais_pa)
    else
    if pais_origen_pp.Focused then
    begin
      DespliegaRejilla(BGBPais);
    end;
  end;
end;

procedure TFMProveedores.BuscarProveedor(const AProveedor: string);
begin
 {+}Select := ' SELECT * FROM frf_proveedores ';
 {+}where := ' WHERE proveedor_p =' + AProveedor;
 {+}Order := ' ORDER BY proveedor_p ';

 QProveedores.Close;
 AbrirTablas;
 Visualizar;
end;

procedure TFMProveedores.AntesDeInsertar;
begin

  tipo_coste_pc.Enabled := true;
  fecha_ini_pc.Enabled := true;

  //Deshabilitamos el campo proveedor_p, se genera codigo automatico
  proveedor_p.Enabled := False;
  proveedor_p.Text := ObtenerCodigoProveedor;

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
//liquidar_p.AllowGrayed:= False;
  propio_p.AllowGrayed:= False;
end;

procedure TFMProveedores.AntesDeLocalizar;
begin
//liquidar_p.AllowGrayed:= True;
  propio_p.AllowGrayed:= True;
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

procedure TFMProveedores.RefrescarProveedor;
var
  myBookMark: TBookmark;
begin
  myBookMark:= QProveedores.GetBookmark;
  QProveedores.Close;
  QProveedores.Open;
  QProveedores.GotoBookmark(myBookMark);
  QProveedores.FreeBookmark(myBookMark);
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

procedure TFMProveedores.tipo_coste_pcChange(Sender: TObject);
begin
  stDesTipoCoste.Caption:= desTipoCoste( tipo_coste_pc.Text );
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
  QCostes.Open;
end;

procedure TFMProveedores.QProveedoresBeforeClose(DataSet: TDataSet);
begin
  QAlmacenes.Close;
  QProductos.Close;
  QCostes.Close;
end;

procedure TFMProveedores.rbCostesActivosClick(Sender: TObject);
begin
  if rbCostesTodos.Checked then
    QCostes.filter:= ''
  else
    QCostes.filter:= 'fecha_fin_pc is null';
end;

procedure TFMProveedores.VerDetalle;
begin
  PanelDetalle.Enabled:= false;
  PanelDetalle.Visible:= false;
  PanelMaestro.Height:= 307;
  tsAlmacenes.TabVisible:= True;
  tsProductos.TabVisible:= True;
  tsCostes.TabVisible:=(propio_p.State = cbChecked);
  if QCostes.Active then
  begin
    QCostes.Close;
    QCostes.Open;
  end;
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
    tsCostes.TabVisible:=False;
    if EstadoDetalle <> tedModificar then
    begin
      QAlmacenes.Close;
      QAlmacenes.Open;
    end;
  end
  else if PAgeControl.ActivePAge = tsProductos then
  begin
    FocoDetalle:=variedad_pp;
    tsAlmacenes.TabVisible:= False;
    tsCostes.TabVisible:=False;
    if EstadoDetalle <> tedModificar then
    begin
      QProductos.Close;
      QProductos.Open;
    end;
  end
  else
  begin
    FocoDetalle:=tipo_coste_pc;
    tsAlmacenes.TabVisible:= False;
    tsProductos.TabVisible:= False;
    if EstadoDetalle <> tedModificar then
    begin
      QCostes.Close;
      QCostes.Open;
    end;
  end;
end;

procedure TFMProveedores.QAlmacenesNewRecord(DataSet: TDataSet);
begin
  QAlmacenes.FieldByName('proveedor_pa').AsString := QProveedores.FieldByName('proveedor_p').AsString;
  QAlmacenes.FieldByName('pais_pa').AsString := QProveedores.FieldByName('pais_p').AsString;
end;

procedure TFMProveedores.QCostesCalcFields(DataSet: TDataSet);
begin
  QCostes.FieldByName('descripcion').AsString:= desTipoCoste(QCostes.FieldByName('tipo_coste_pc').AsString);
end;

procedure TFMProveedores.QCostesNewRecord(DataSet: TDataSet);
begin
  QCostes.FieldByName('proveedor_pc').AsString := QProveedores.FieldByName('proveedor_p').AsString;
  QCostes.FieldByName('fecha_ini_pc').AsDateTime := Date;
end;

function TFMProveedores.NuevoCodigoVariedad( const AProveedor: String): integer;
begin
  with DMAuxDB.QGeneral do
  begin
    SQL.Clear;
    SQL.Add(' select max(nvl(variedad_pp,1)) contador ');
    SQL.Add(' from frf_productos_proveedor ');
    SQL.Add(' where proveedor_pp = :proveedor ');
    ParamByName('proveedor').AsString:= AProveedor;
    try
      Open;
      result:= FieldByName('contador').AsInteger + 1;
    finally
      Close;
    end;
  end;
end;

function TFMProveedores.ObtenerCodigoProveedor: string;
var iProveedor: Integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(proveedor_p) proveedor from frf_proveedores ');

    Open;
    if IsEmpty then
      iProveedor := 1
    else
    begin
      iProveedor := fieldbyname('proveedor').AsInteger + 1;
    end;

    Result := IntToStr(iProveedor);

    Close;
  end;
end;

procedure TFMProveedores.QProductosNewRecord(DataSet: TDataSet);
begin
  QProductos.FieldByName('proveedor_pp').AsString := QProveedores.FieldByName('proveedor_p').AsString;
  QProductos.FieldByName('variedad_pp').AsInteger := NuevoCodigoVariedad( QProveedores.FieldByName('proveedor_p').AsString );
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
  else if PAgeControl.ActivePAge = tsProductos then
  begin
    DataSourceDetalle:=DSProductos;
    RejillaVisualizacion := TDBGrid(RProductos);
    PanelDetalle := PProductos;
  end
  else
  begin
    DataSourceDetalle:=dsCostes;
    RejillaVisualizacion := RCostes;
    PanelDetalle := PCostes;
  end;
  ListaDetalle.Clear;
  PanelDetalle.GetTabOrderList(ListaDetalle);
end;

procedure TFMProveedores.producto_ppChange(Sender: TObject);
begin
  stProducto.Caption:= desProducto( '', producto_pp.Text );
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

procedure TFMProveedores.proveedor_pExit(Sender: TObject);
begin
  (*BAG*)
  //Buscar si esta grabado y rellenar datos
  if ( Trim( proveedor_p.Text ) <> '' ) and ( Estado = teAlta ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_proveedores ');
    SQL.Add(' where proveedor_p = ' + Trim( proveedor_p.Text ) );
    //SQL.Add(' and nombre_p = 'MASET DE SEVA'

    Open;
    if not IsEmpty then
    begin
      if MessageDlg( 'Ya hay un proveedor con este código, ¿desea rellenar los campos de la ficha actual con sus datos?.' , mtWarning, [mbYes, mbNo], 0 ) = mrYes then
       begin
         nombre_p.Text:= FieldByName('nombre_p').AsString;
         domicilio_p.Text:= FieldByName('domicilio_p').AsString;
         if FieldByName('pais_p').AsString <> '' then
           pais_p.Text:= FieldByName('pais_p').AsString;
         cod_postal_p.Text:= FieldByName('cod_postal_p').AsString;
         poblacion_p.Text:= FieldByName('poblacion_p').AsString;
         telefono1_p.Text:= FieldByName('telefono1_p').AsString;
         telefono2_p.Text:= FieldByName('telefono2_p').AsString;
         fax_p.Text:= FieldByName('fax_p').AsString;
         pagina_web_p.Text:= FieldByName('pagina_web_p').AsString;
         email_p.Text:= FieldByName('email_p').AsString;
         cta_contable_p.Text:= FieldByName('cta_contable_p').AsString;
         if FieldByName('forma_pago_p').AsString <> '' then
           forma_pago_p.Text:= FieldByName('forma_pago_p').AsString;
       end;
    end;
    Close;
  end;
end;



procedure TFMProveedores.QProveedoresAfterPost(DataSet: TDataSet);
begin
  (*BAG*)
  if Estado = teAlta then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_proveedores ');
    SQL.Add(' where proveedor_p = ' + DataSet.FieldByName('proveedor_p').AsString );
    Open;

    if not IsEmpty then
    begin
      Close;
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_productos_proveedor ');
      SQL.Add(' where proveedor_pp = ' + DataSet.FieldByName('proveedor_p').AsString );
      Open;
      while not Eof do
      begin
        QProductos.Insert;
        QProductos.FieldByName('proveedor_pp').AsString:= FieldByName('proveedor_pp').AsString;
        QProductos.FieldByName('producto_pp').AsString:= FieldByName('producto_pp').AsString;
        QProductos.FieldByName('variedad_pp').AsString:= FieldByName('variedad_pp').AsString;
        QProductos.FieldByName('descripcion_pp').AsString:= FieldByName('descripcion_pp').AsString;

        QProductos.FieldByName('descripcion_breve_pp').AsString:= FieldByName('descripcion_breve_pp').AsString;
        if FieldByName('marca_pp').AsString <> '' then
          QProductos.FieldByName('marca_pp').AsString:= FieldByName('marca_pp').AsString;
        if FieldByName('pais_origen_pp').AsString <> '' then
          QProductos.FieldByName('pais_origen_pp').AsString:= FieldByName('pais_origen_pp').AsString;
        QProductos.FieldByName('presentacion_pp').AsString:= FieldByName('presentacion_pp').AsString;
        QProductos.FieldByName('codigo_ean_pp').AsString:= FieldByName('codigo_ean_pp').AsString;

        QProductos.FieldByName('peso_paleta_pp').AsFloat:= FieldByName('peso_paleta_pp').AsFloat;
        QProductos.FieldByName('peso_cajas_pp').AsFloat:= FieldByName('peso_cajas_pp').AsFloat;
        QProductos.FieldByName('unidades_caja_pp').AsFloat:= FieldByName('unidades_caja_pp').AsFloat;
        QProductos.FieldByName('cajas_paleta_pp').AsFloat:= FieldByName('cajas_paleta_pp').AsFloat;
        QProductos.FieldByName('unidad_precio_pp').AsString:= FieldByName('unidad_precio_pp').AsString;
        QProductos.Post;
        Next;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select *  ');
      SQL.Add(' from frf_proveedores_almacen  ');
      SQL.Add(' where proveedor_pa = ' + DataSet.FieldByName('proveedor_p').AsString );
      Open;
      while not Eof do
      begin
        QAlmacenes.Insert;
        QAlmacenes.FieldByName('proveedor_pa').AsString:= FieldByName('proveedor_pa').AsString;
        QAlmacenes.FieldByName('almacen_pa').AsString:= FieldByName('almacen_pa').AsString;
        QAlmacenes.FieldByName('nombre_pa').AsString:= FieldByName('nombre_pa').AsString;
        QAlmacenes.Post;
        Next;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select *  ');
      SQL.Add(' from frf_proveedores_costes  ');
      SQL.Add(' where proveedor_pc = ' + DataSet.FieldByName('proveedor_p').AsString );
      Open;
      while not Eof do
      begin
        QCostes.Insert;
        QCostes.FieldByName('proveedor_pc').AsString:= FieldByName('proveedor_pc').AsString;
        QCostes.FieldByName('tipo_coste_pc').AsString:= FieldByName('tipo_coste_pc').AsString;
        QCostes.FieldByName('fecha_ini_pc').AsDateTime:= FieldByName('fecha_ini_pc').AsDateTime;
        QCostes.FieldByName('fecha_fin_pc').AsDateTime:= FieldByName('fecha_fin_pc').AsDateTime;
        QCostes.FieldByName('importe_pc').AsFloat:= FieldByName('importe_pc').AsFloat;
        QCostes.Post;
        Next;
      end;
      Close;

    end;
  end;
end;

procedure TFMProveedores.QAlmacenesAfterPost(DataSet: TDataSet);
begin
  (*BAG*)
  if EstadoDetalle = tedAlta then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_proveedores ');
    SQL.Add(' where proveedor_p = ' + QuotedStr( DataSet.FieldByName('proveedor_pa').AsString ) );
    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('   select * ');
    SQL.Add('   from frf_proveedores_almacen ');
    SQL.Add('   where proveedor_pa = ' + QuotedStr( DataSet.FieldByName('proveedor_pa').AsString ) );
    SQL.Add('   and almacen_pa = ' + DataSet.FieldByName('almacen_pa').AsString );
    SQL.Add(' ) ');
    Open;

    if not IsEmpty then
    begin
      QAlmacenesAux.Open;
      while not Eof do
      begin
        QAlmacenesAux.Insert;
        QAlmacenesAux.FieldByName('proveedor_pa').AsString:= DataSet.FieldByName('proveedor_pa').AsString;
        QAlmacenesAux.FieldByName('almacen_pa').AsString:= DataSet.FieldByName('almacen_pa').AsString;
        QAlmacenesAux.FieldByName('nombre_pa').AsString:= DataSet.FieldByName('nombre_pa').AsString;
        QAlmacenesAux.Post;
        Next;
      end;
      QAlmacenesAux.Close;
      Close;
    end;
  end;
end;

procedure TFMProveedores.QProductosAfterPost(DataSet: TDataSet);
begin
  (*BAG*)
  if EstadoDetalle = tedAlta then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_proveedores ');
    SQL.Add(' where proveedor_p = ' + QuotedStr( DataSet.FieldByName('proveedor_pp').AsString ) );
    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('   select * ');
    SQL.Add('   from frf_productos_proveedor ');
    SQL.Add('   where proveedor_pp = ' + QuotedStr( DataSet.FieldByName('proveedor_pp').AsString ) );
    SQL.Add('   and producto_pp = ' + QuotedStr( DataSet.FieldByName('producto_pp').AsString ) );
    SQL.Add('   and variedad_pp = ' + DataSet.FieldByName('variedad_pp').AsString );
    SQL.Add(' ) ');
    Open;

    if not IsEmpty then
    begin
      QProductosAux.Open;
      while not Eof do
      begin
        QProductosAux.Insert;
        QProductosAux.FieldByName('proveedor_pp').AsString:=DataSet.FieldByName('proveedor_pp').AsString;
        QProductosAux.FieldByName('producto_pp').AsString:= DataSet.FieldByName('producto_pp').AsString;
        QProductosAux.FieldByName('variedad_pp').AsString:= DataSet.FieldByName('variedad_pp').AsString;
        QProductosAux.FieldByName('descripcion_pp').AsString:= DataSet.FieldByName('descripcion_pp').AsString;

        QProductosAux.FieldByName('descripcion_breve_pp').AsString:= DataSet.FieldByName('descripcion_breve_pp').AsString;
        if DataSet.FieldByName('marca_pp').AsString <> '' then
          QProductosAux.FieldByName('marca_pp').AsString:= DataSet.FieldByName('marca_pp').AsString;
        if DataSet.FieldByName('pais_origen_pp').AsString <> '' then
          QProductosAux.FieldByName('pais_origen_pp').AsString:= DataSet.FieldByName('pais_origen_pp').AsString;
        QProductosAux.FieldByName('presentacion_pp').AsString:= DataSet.FieldByName('presentacion_pp').AsString;
        QProductosAux.FieldByName('codigo_ean_pp').AsString:= DataSet.FieldByName('codigo_ean_pp').AsString;

        QProductosAux.FieldByName('peso_paleta_pp').AsFloat:= DataSet.FieldByName('peso_paleta_pp').AsFloat;
        QProductosAux.FieldByName('peso_cajas_pp').AsFloat:= DataSet.FieldByName('peso_cajas_pp').AsFloat;
        QProductosAux.FieldByName('unidades_caja_pp').AsFloat:= DataSet.FieldByName('unidades_caja_pp').AsFloat;
        QProductosAux.FieldByName('cajas_paleta_pp').AsFloat:= DataSet.FieldByName('cajas_paleta_pp').AsFloat;
        QProductosAux.FieldByName('unidad_precio_pp').AsString:= DataSet.FieldByName('unidad_precio_pp').AsString;
        try
          QProductosAux.Post;
        except
          QProductosAux.Cancel;
        end;
        Next;
      end;
      QProductosAux.Close;
      Close;
    end;
  end;
end;

procedure TFMProveedores.pais_pChange(Sender: TObject);
begin
  stPais_p.Caption:= desPais( pais_p.Text );
  cod_postal_pChange( cod_postal_p );
end;

procedure TFMProveedores.pais_paChange(Sender: TObject);
begin
  txtPais_pa.Caption:= desPais( pais_pa.Text );
end;

end.


