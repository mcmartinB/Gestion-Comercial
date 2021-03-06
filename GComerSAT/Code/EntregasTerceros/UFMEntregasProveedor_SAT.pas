unit UFMEntregasProveedor_SAT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid,
  BDEdit, BEdit, dbTables, DError, BCalendarButton, ComCtrls, BCalendario,
  nbLabels, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlueprint, dxSkinFoggy, Menus,
  cxButtons, SimpleSearch, cxTextEdit, cxDBEdit, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFMEntregasProveedor_SAT = class(TMaestroDetalle)
    DSMaestro: TDataSource;
    PMaestro: TPanel;
    RejillaFlotante: TBGrid;
    Calendario: TBCalendario;
    observaciones_ec: TDBMemo;
    DSDetalleTotales: TDataSource;
    nbLabel24: TnbLabel;
    Bevel4: TBevel;
    codigo_ec: TBDEdit;
    lObservacion: TnbLabel;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel5: TnbLabel;
    nbLabel19: TnbLabel;
    lblProveedor: TnbStaticText;
    lblEmpresa: TnbStaticText;
    btnFecha_llegada: TBCalendarButton;
    btnEmpresa_ec: TBGridButton;
    btnProveedor_ec: TBGridButton;
    nbLabel25: TnbLabel;
    btnAlmacen: TBGridButton;
    lblAlmacen: TnbStaticText;
    nbLabel4: TnbLabel;
    nbLabel30: TnbLabel;
    btnCentroDestino: TBGridButton;
    lblCentroDestino: TnbStaticText;
    nbLabel31: TnbLabel;
    btnTransporte: TBGridButton;
    lblTransporte: TnbStaticText;
    empresa_ec: TBDEdit;
    proveedor_ec: TBDEdit;
    vehiculo_ec: TBDEdit;
    fecha_carga_ec: TBDEdit;
    almacen_ec: TBDEdit;
    albaran_ec: TBDEdit;
    centro_llegada_ec: TBDEdit;
    transporte_ec: TBDEdit;
    pMantenimientoGastos: TPanel;
    btnGastos: TButton;
    STTotalGastos: TLabel;
    nbLabel20: TnbLabel;
    fecha_llegada_ec: TBDEdit;
    btnFecha_Carga: TBCalendarButton;
    lblNombre1: TLabel;
    DBText1: TDBText;
    lblNombre2: TLabel;
    DBText2: TDBText;
    lblNombre3: TLabel;
    DBText3: TDBText;
    lblNombre4: TLabel;
    DBText4: TDBText;
    Bevel1: TBevel;
    PageControl: TPageControl;
    tsDetalle: TTabSheet;
    PRejilla: TPanel;
    SubPanel1: TPanel;
    RVisualizacion3: TDBGrid;
    tsEntradas: TTabSheet;
    PDetalle2: TPanel;
    nbLabel26: TnbLabel;
    nbLabel27: TnbLabel;
    nbLabel28: TnbLabel;
    nbLabel29: TnbLabel;
    nbLabel34: TnbLabel;
    nbLabel35: TnbLabel;
    lblCosechero: TnbStaticText;
    lblPlantacion: TnbStaticText;
    centro_er: TBDEdit;
    numero_entrada_er: TBDEdit;
    fecha_entrada_er: TBDEdit;
    cosechero_er: TBDEdit;
    plantacion_er: TBDEdit;
    producto_er: TBDEdit;
    Panel1: TPanel;
    RVisualizacion2: TDBGrid;
    PDetalle1: TPanel;
    nbLabel10: TnbLabel;
    nbLabelCajas: TnbLabel;
    nbLabelKilos: TnbLabel;
    nbLabel8: TnbLabel;
    lblVariedad: TLabel;
    nbLabel13: TnbLabel;
    btnProductoProveedor: TBGridButton;
    btnProducto: TBGridButton;
    nbLabel9: TnbLabel;
    nbLabel17: TnbLabel;
    btnCategoria: TBGridButton;
    btnCalibre: TBGridButton;
    lblUnidadPrecio: TnbLabel;
    nbLabel15: TnbLabel;
    lblPesoBruto: TLabel;
    producto_el: TBDEdit;
    cajas_el: TBDEdit;
    palets_el: TBDEdit;
    kilos_el: TBDEdit;
    variedad_el: TBDEdit;
    categoria_el: TBDEdit;
    calibre_el: TBDEdit;
    precio_el: TBDEdit;
    cbxUnidad_precio_el: TComboBox;
    unidad_precio_el: TBDEdit;
    unidades_el: TBDEdit;
    RVisualizacion1: TDBGrid;
    DSDetalle1: TDataSource;
    DSDetalle2: TDataSource;
    nbLabel22: TnbLabel;
    centro_origen_ec: TBDEdit;
    fecha_origen_ec: TBDEdit;
    nbLabel36: TnbLabel;
    lblAprovecha: TnbLabel;
    aprovechados_el: TBDEdit;
    lblPorcenAprovecha: TLabel;
    DSCompras: TDataSource;
    nbLabel11: TnbLabel;
    peso_el: TBDEdit;
    lblTomateVerde: TnbLabel;
    tomate_verde_ec: TBDEdit;
    lblDestrio: TnbLabel;
    lbl1: TLabel;
    destrio_ec: TLabel;
    calidad_nota_ec: TDBMemo;
    lbl3: TnbLabel;
    tsCalidad: TTabSheet;
    DSDetalle3: TDataSource;
    pnlDetalleCalidad: TPanel;
    lblCliente: TnbLabel;
    cliente_eca: TBDEdit;
    btnCliente: TBGridButton;
    stCliente: TnbStaticText;
    lblEnvase: TnbLabel;
    stenvase: TnbStaticText;
    lblFechaCalidad: TnbLabel;
    fecha_eca: TBDEdit;
    btnFechaCalidad: TBCalendarButton;
    lblPorcentaje: TnbLabel;
    porcentaje_eca: TBDEdit;
    lblPorcentaje2: TLabel;
    RVisualizacionCalidad: TDBGrid;
    lbl2: TLabel;
    btnBalance: TButton;
    lblProducto: TnbLabel;
    producto_eca: TBDEdit;
    btnProducto_eca: TBGridButton;
    stProducto: TnbStaticText;
    tsMaterial: TTabSheet;
    pnlDetalleMaterial: TPanel;
    nbLabel3: TnbLabel;
    btnOperador: TBGridButton;
    btnEnvaseOperador: TBGridButton;
    stEnvaseOperador: TnbStaticText;
    nbLabel12: TnbLabel;
    cod_operador_em: TBDEdit;
    cod_producto_em: TBDEdit;
    entrada_em: TBDEdit;
    RVisualizacionMaterial: TDBGrid;
    lblCodigo1: TnbLabel;
    salida_em: TBDEdit;
    dsMaterial: TDataSource;
    lblCodigoNotas: TnbLabel;
    notas_em: TBDEdit;
    dsTotalCompra: TDataSource;
    lblImporte: TLabel;
    bvl1: TBevel;
    Label1: TLabel;
    dlbl1: TDBText;
    Label2: TLabel;
    lblDiff: TLabel;
    DBText5: TDBText;
    compra_ec: TDBCheckBox;
    envase_eca: TcxDBTextEdit;
    ssEnvase: TSimpleSearch;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure empresa_ecChange(Sender: TObject);
    procedure proveedor_ecChange(Sender: TObject);
    procedure btnFecha_llegadaClick(Sender: TObject);
    procedure btnEmpresa_ecClick(Sender: TObject);
    procedure btnProveedor_ecClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure almacen_ecChange(Sender: TObject);
    procedure producto_elChange(Sender: TObject);
    procedure btnTransporteClick(Sender: TObject);
    procedure centro_llegada_ecChange(Sender: TObject);
    procedure transporte_ecChange(Sender: TObject);
    procedure btnCentroDestinoClick(Sender: TObject);
    procedure btnAlmacenClick(Sender: TObject);
    procedure empresa_ecRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure variedad_elChange(Sender: TObject);
    procedure btnProductoProveedorClick(Sender: TObject);
    procedure btnProductoClick(Sender: TObject);
    procedure btnCategoriaClick(Sender: TObject);
    procedure btnCalibreClick(Sender: TObject);
    procedure RVisualizacion1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnGastosClick(Sender: TObject);
    procedure producto_elEnter(Sender: TObject);
    procedure cbxUnidad_precio_elChange(Sender: TObject);
    procedure unidad_precio_elChange(Sender: TObject);
    procedure palets_elChange(Sender: TObject);
    procedure cajas_elChange(Sender: TObject);
    procedure kilos_elChange(Sender: TObject);
    procedure codigo_ecChange(Sender: TObject);
    procedure btnFecha_CargaClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure cosechero_erChange(Sender: TObject);
    procedure plantacion_erChange(Sender: TObject);
    procedure aprovechados_elChange(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure btnFechaCalidadClick(Sender: TObject);
    procedure cliente_ecaChange(Sender: TObject);
    procedure envase_ecaChange(Sender: TObject);
    procedure btnBalanceClick(Sender: TObject);
    procedure DSDetalle3StateChange(Sender: TObject);
    procedure producto_ecaChange(Sender: TObject);
    procedure btnProducto_ecaClick(Sender: TObject);
    procedure btnOperadorClick(Sender: TObject);
    procedure btnEnvaseOperadorClick(Sender: TObject);
    procedure cod_operador_producto_emChange(Sender: TObject);
    procedure DSDetalleTotalesDataChange(Sender: TObject; Field: TField);
    procedure dsTotalCompraDataChange(Sender: TObject; Field: TField);
    procedure RVisualizacion1DblClick(Sender: TObject);
    procedure envase_ecaExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
  private
    { Private declarations }
    Lista, ListaDetalle: TList;
    Objeto: TObject;

    sCategoria, sCalibre: string;
    iUnidadPrecio, iCajasPaleta, iUnidadesCaja: integer;
    rPesoPaleta, rPesoCaja: Real;
    sAlbaranAux: string;

    rPrecioLinea: Real;
    iUnidadLinea: Integer;


    procedure ValorarPor;

    procedure ValidarEntradaMaestro;
    procedure ValidarEntradaDetalle;
    procedure VerDetalle;
    procedure EditarDetalle;
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure AntesDeVisualizar;
    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeLocalizar;
    procedure PreparaAlta;


    function RegistroActual: String;

    function MantenimientoGastos: boolean;

    procedure PesoBruto;
    procedure PintaDestrioCalidad;
    procedure DiferenciasLineaCompra;
  public
    { Public declarations }
    procedure Borrar; override;

    procedure Altas; override;

    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    //Listado
    procedure Previsualizar; override;
    procedure PrevisualizarResto;
    procedure PrevisualizarMaset;

    procedure QEntregasAfterPost(DataSet: TDataSet);
  end;
        


implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CAuxiliarDB, bMath,
  Principal, UDMAuxDB, Variants, bSQLUtils, bTextUtils, Dpreview,
  UQREntregas, UMDEntregas, UQREntregasMaset, CReportes, CMaestro, UDMConfig,
  UFProductosProveedor, UFTransportistas, UFMEntregasGastos, UFProveedores, 
  EntregasCB, CDBEntregas, CFPCamionEntrega, {UFMEntregasCompra,} CQBalanceCompras,
  PutPrecioLineaEntregaFD;

{$R *.DFM}


procedure TFMEntregasProveedor_SAT.AbrirTablas;
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

  //if not DataSourceDetalle.DataSet.Active then
  //  DataSourceDetalle.DataSet.Open;
  //DSDetalle1.DataSet.Open;
  //DSDetalle2.DataSet.Open;
  //DSDetalle3.DataSet.Open;
  //DSDetalle4.DataSet.Open;

  //Estado inicial
  Registro := 1;
  Registros := 0;
  RegistrosInsertados := 0;
end;

procedure TFMEntregasProveedor_SAT.CerrarTablas;
begin
  CloseAuxQuerys;
  //bnCloseQuerys([DSDetalle1.DataSet, DSDetalle2.DataSet, DSDetalle3.DataSet,
  //               DSDetalle4.DataSet, DataSetMaestro]);
end;

procedure TFMEntregasProveedor_SAT.FormCreate(Sender: TObject);
begin
  rPrecioLinea:= 0;
  iUnidadLinea:= 0;

  LineasObligadas := false;
  ListadoObligado := false;
  MultipleAltas := false;

  //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  gCF := Calendario;

  //Panel
  PanelMaestro := PMaestro;
  PanelDetalle := PDetalle1;
  RejillaVisualizacion := RVisualizacion1;

  //Fuente de datos
  UMDEntregas.LoadModule( Self );
  CDBEntregas.InicializarModulo( self, DMBaseDatos.DBBaseDatos.DatabaseName );

  DSMaestro.DataSet:= MDEntregas.QEntregasC;
  DSDetalle1.DataSet:= MDEntregas.TEntregasL;
  DSDetalle2.DataSet:= MDEntregas.TEntregasRel;
  DSDetalle3.DataSet:= MDEntregas.QCalidad;
  dsMaterial.DataSet:= MDEntregas.QMaterial;
  DSDetalleTotales.DataSet:= MDEntregas.QTotalLineas;
  dsTotalCompra.DataSet:= MDEntregas.QTotalFacturaCompra;

  DataSetMaestro := MDEntregas.QEntregasC;
  DataSourceDetalle := DSDetalle1;

  (*TODO*)
  Select := 'select * From frf_entregas_c';
  where := ' Where empresa_ec = ''###''';
  if DMConfig.iInstalacion = 32 then
    Order := ' Order by fecha_llegada_ec desc, codigo_ec DESC'
  else
    Order := ' Order by codigo_ec DESC';

  //Abrir tablas/Querys
  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Close;
    end;
  end;

  //Lista de componentes
  Lista := TList.Create;
  PanelMaestro.GetTabOrderList(Lista);
  ListaDetalle := TList.Create;
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

  //Incrementar contador
  MDEntregas.QEntregasC.AfterPost:= QEntregasAfterPost;

  //Preparar panel de detalle
  OnViewDetail := VerDetalle;
  OnEditDetail := EditarDetalle;

  OnEdit:= PreparaAlta;
  OnView:= AntesDeVisualizar;
  OnInsert:= AntesDeInsertar;
  OnEdit:= AntesDeModificar;
  OnBrowse:= AntesDeLocalizar;

  (*TODO*)
  FocoAltas := empresa_ec;
  FocoModificar := centro_llegada_ec;
  FocoLocalizar := empresa_ec;
  FocoDetalle := producto_el;
  Calendario.Date := date;

  (*TODO*)
  //Constantes para las rejillas de l combo
  empresa_ec.Tag:= kEmpresa;
  centro_llegada_ec.Tag:= kCentro;
  proveedor_ec.Tag:= kProveedor;
  almacen_ec.Tag:= kProveedorAlmacen;
  fecha_llegada_ec.Tag:= kCalendar;
  transporte_ec.Tag:= kTransportista;
  producto_el.Tag:= kProducto;
  producto_eca.Tag:= kProducto;
  categoria_el.Tag:= kCategoria;
  calibre_el.Tag:= kCalibre;
  cliente_eca.Tag:= kCliente;
  envase_eca.Tag:= kEnvase;
  cod_operador_em.Tag:= kEnvComerOperador;
  cod_producto_em.Tag:= kEnvComerProducto;

  empresa_ec.Change;
  proveedor_ec.Change;


  (*Configuracion segun version*)
  pMantenimientoGastos.Visible:= DMConfig.EsLaFont;

  PageControl.ActivePage:= tsDetalle;
  tsEntradas.TabVisible:= True;
  SubPanel1.Visible:= True;
  RVisualizacion1.Columns[3].Width:= 198;

  //Columna de aprovechamiento de momento solo se graba en maset
  RVisualizacion1.Columns[7].Visible:= DMConfig.EsLaFont;
  lblAprovecha.Visible:= RVisualizacion1.Columns[7].Visible;
  lblPorcenAprovecha.Visible:= RVisualizacion1.Columns[7].Visible;
  aprovechados_el.Visible:= RVisualizacion1.Columns[7].Visible;
  PDetalle1.Height:= 96;

  FPrincipal.AMAltas.Enabled := false;
end;

procedure TFMEntregasProveedor_SAT.PreparaAlta;
begin
  codigo_ec.Enabled:= False;
  centro_origen_ec.Enabled:= False;
  fecha_origen_ec.Enabled:= False;

  if pMantenimientoGastos.Visible then
  begin
    pMantenimientoGastos.Enabled:= False;
    btnGastos.Enabled:= False;
    btnBalance.Enabled:= False;
  end;
end;

procedure TFMEntregasProveedor_SAT.PintaDestrioCalidad;
var
  rAux: Real;
begin
  rAux:=  MDEntregas.GetDestrioCalidad( codigo_ec.Text );
  if ( codigo_ec.Text <> '' ) then
  begin
    destrio_ec.Caption:= FormatFloat('0.00', rAux );
  end
  else
  begin
    destrio_ec.Caption:= '';
  end;
  if rAux < 0 then
  begin
    destrio_ec.Font.Color:= clRed;
  end
  else
  if rAux > 100 then
  begin
    destrio_ec.Font.Color:= clNavy;
  end
  else
  begin
    destrio_ec.Font.Color:= clBlack;
  end;
end;

procedure TFMEntregasProveedor_SAT.AntesDeVisualizar;
var
  i: Integer;
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
  if pMantenimientoGastos.Visible then
  begin
    pMantenimientoGastos.Enabled:= True;
    btnGastos.Enabled:= True;
    btnBalance.Enabled:= True;
  end;

  centro_origen_ec.Enabled:= True;
  fecha_origen_ec.Enabled:= True;

  PintaDestrioCalidad;
end;

procedure TFMEntregasProveedor_SAT.AntesDeInsertar;
begin
  codigo_ec.Enabled:= False;
  centro_origen_ec.Enabled:= False;
  fecha_origen_ec.Enabled:= False;

  //Fecha de grabacion
  DSMaestro.DataSet.FieldByName('fecha_origen_ec').AsDateTime:= Date;
  //Codigo centro instalacion programa, tabla "cnf_instalacion"
  if DMConfig.sCentroInstalacion <> '0' then
    DSMaestro.DataSet.FieldByName('centro_origen_ec').AsString:= DMConfig.sCentroInstalacion;

  empresa_ec.Text:= gsDefEmpresa;
  centro_llegada_ec.Text:= gsDefCentro;
  fecha_llegada_ec.Text:= DateToStr( date );
  fecha_carga_ec.Text:= DateToStr( date );

  if pMantenimientoGastos.Visible then
  begin
    pMantenimientoGastos.Enabled:= False;
    btnGastos.Enabled:= False;
    btnBalance.Enabled:= False;
  end;

  sAlbaranAux:= '';

  compra_ec.AllowGrayed:= False;
end;

procedure TFMEntregasProveedor_SAT.AntesDeModificar;
var
  i: integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;

  sAlbaranAux:= empresa_ec.Text + proveedor_ec.Text + almacen_ec.Text + fecha_carga_ec.Text + albaran_ec.Text;

  if pMantenimientoGastos.Visible then
  begin
    pMantenimientoGastos.Enabled:= False;
    btnGastos.Enabled:= False;
    btnBalance.Enabled:= False;
  end;

  compra_ec.AllowGrayed:= False;
end;

procedure TFMEntregasProveedor_SAT.AntesDeLocalizar;
begin
  if pMantenimientoGastos.Visible then
  begin
    pMantenimientoGastos.Enabled:= False;
    btnGastos.Enabled:= False;
    btnBalance.Enabled:= False;
  end;

  compra_ec.AllowGrayed:= True;
end;

procedure TFMEntregasProveedor_SAT.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;

     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  gCF := Calendario;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestroDetalle then
  begin
    FormType := tfMaestroDetalle;
    BHFormulario;
  end;
  BHGrupoDesplazamientoMaestro(PCMaestro);
  BHGrupoDesplazamientoDetalle(PCDetalle);


     //Maximizamos si no lo esta
  if Self.WindowState <> wsMaximized then
  begin
    Self.WindowState := wsMaximized;
  end;
end;

procedure TFMEntregasProveedor_SAT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;
  ListaDetalle.Free;

  //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

     // Cerrar tabla
  CerrarTablas;
  UMDEntregas.UnloadModule;
  CDBEntregas.FinalizarModulo;

     // Cambia acci?n por defecto para Form hijas en una aplicaci?n MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

{+ CUIDADIN }

procedure TFMEntregasProveedor_SAT.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edici?n
    //               y entre los Campos de B?squeda en la localizaci?n
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
    Ord('G'):
      if ssAlt in Shift  then
        MantenimientoGastos;
    vk_f2:
    begin
      if empresa_ec.Focused then btnEmpresa_ec.Click
      else if proveedor_ec.Focused then btnProveedor_ec.Click
      else if almacen_ec.Focused then btnAlmacen.Click
      else if centro_llegada_ec.Focused then btnCentroDestino.Click
      else if fecha_llegada_ec.Focused then btnFecha_llegada.Click
      else if fecha_carga_ec.Focused then btnFecha_carga.Click
      else if transporte_ec.Focused then btnTransporte.Click
      else if producto_el.Focused then btnProducto.Click
      else if categoria_el.Focused then btnCategoria.Click
      else if calibre_el.Focused then btnCalibre.Click
      else if variedad_el.Focused then btnProductoProveedor.Click
      else if cliente_eca.Focused then btnCliente.Click
      else if producto_eca.Focused then btnProducto_eca.Click;
    end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

procedure TFMEntregasProveedor_SAT.Filtro;
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
          begin
            if name = 'proveedor_ec' then
              where := where + ' proveedor_ec LIKE ''%' + Text + '%'' '
            else
              where := where + ' ' + name + ' LIKE ' + SQLFilter(Text);
          end
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

  if ( compra_ec.State = cbUnchecked ) or
     ( compra_ec.State = cbChecked ) then
  begin
    if flag then where := where + ' and ';
    if compra_ec.State = cbUnchecked then
    begin
      where := where + ' compra_ec = 0 ';
    end
    else
    if compra_ec.State = cbChecked then
    begin
      where := where + ' compra_ec <> 0 ';
    end;
    flag:= TRue;
  end;


  if flag then where := ' WHERE ' + where;
end;

procedure TFMEntregasProveedor_SAT.AnyadirRegistro;
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

procedure TFMEntregasProveedor_SAT.QEntregasAfterPost(DataSet: TDataSet);
begin
  if Estado = teAlta then
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('select * ');
      SQL.Add('from frf_empresas ');
      SQL.Add('where empresa_e = :empresa ');
      ParamByName('empresa').AsString:= empresa_ec.Text;
      RequestLive:= True;
      try
        Open;
        Edit;
        FieldByName('cont_entregas_e').AsInteger:=
          FieldByName('cont_entregas_e').AsInteger + 1;
        Post;
      finally
        Close;
        RequestLive:= False;
      end;
    end;
  end;
  MDEntregas.DestrioCalidad( DataSet.FieldByName('codigo_ec').AsString );
end;

procedure TFMEntregasProveedor_SAT.ValidarEntradaMaestro;
var
  i: Integer;
  dFecha: TdateTime;
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
            raise Exception.Create('Faltan datos de obligada inserci?n.');
        end;
      end;
    end;
  end;

  //Fecha de llegada
  if not TryStrToDate( fecha_llegada_ec.Text, dFecha ) then
    raise Exception.Create('Faltan fecha de llegada o es incorrecta.');

  //PONER CODIGO
  if DSMaestro.DataSet.State = dsInsert then
  begin
    DSMaestro.DataSet.FieldByName('codigo_ec').AsString:=
      GetCodigoEntrega( empresa_ec.Text, centro_llegada_ec.Text, fecha_origen_ec.Text );
    if DSMaestro.DataSet.FieldByName('centro_origen_ec').AsString = '' then
      DSMaestro.DataSet.FieldByName('centro_origen_ec').AsString:= centro_llegada_ec.Text;
  end;

  //Comprobar que el codigo de albaran es unico
  //Comprobar que el codigo de albaran es unico
  if sAlbaranAux <> empresa_ec.Text + proveedor_ec.Text + almacen_ec.Text + fecha_carga_ec.Text + albaran_ec.Text then
  if CDBEntregas.ExisteAlbaranProveedor( empresa_ec.Text, proveedor_ec.Text, fecha_carga_ec.Text, albaran_ec.Text ) then
  begin
    raise Exception.Create('Albar?n de proveedor duplicado.');
  end;

  DSMaestro.DataSet.FieldByName('aduana_ec').AsInteger:= 0;
  DSMaestro.DataSet.FieldByName('peso_entrada_ec').AsInteger:= 0;
  DSMaestro.DataSet.FieldByName('peso_salida_ec').AsInteger:= 0;
  DSMaestro.DataSet.FieldByName('envio_ec').AsInteger:= 0;
  DSMaestro.DataSet.FieldByName('mercado_local_ec').AsInteger:= 0;
  DSMaestro.DataSet.FieldByName('status_ec').AsInteger:= 0;
  DSMaestro.DataSet.FieldByName('portes_pagados_ec').AsInteger:= 0;
  if tomate_verde_ec.Text = '' then
    DSMaestro.DataSet.FieldByName('tomate_verde_ec').AsFloat:= 0;


  if compra_ec.State = cbChecked then
  begin
    DSMaestro.DataSet.FieldByName('compra_ec').Asinteger:= 1;
  end
  else
  if compra_ec.State = cbUnChecked then
  begin
    DSMaestro.DataSet.FieldByName('compra_ec').Asinteger:= 0;
  end
  else
  begin
    //compra_ec.SetFocus;
    //raise Exception.Create('Debe seleccionar si la entrega es una compra a tercero o una entrega de proveedor a liquidar.');
  end;
end;

procedure TFMEntregasProveedor_SAT.ValidarEntradaDetalle;
var
  dVenta: TDateTime;
  rAux: Double;
  sAux: string;
begin
  if PDetalle1.Visible then
  begin
    //Linea
    DSDetalle1.DataSet.FieldByName('codigo_el').AsString:= DSMaestro.DataSet.FieldByName('codigo_ec').AsString;
    DSDetalle1.DataSet.FieldByName('empresa_el').AsString:= DSMaestro.DataSet.FieldByName('empresa_ec').AsString;
    DSDetalle1.DataSet.FieldByName('proveedor_el').AsString:= DSMaestro.DataSet.FieldByName('proveedor_ec').AsString;

    if DSDetalle1.DataSet.FieldByName('precio_el').AsString = '' then
      DSDetalle1.DataSet.FieldByName('precio_el').AsFloat:= 0;

    if not EsProductoAlta(DSDetalle1.DataSet.FieldByName('producto_el').AsString)  then
    begin
      ShowMEssage(' ATENCI?N: Error al grabar la linea, el producto est? dado de BAJA..');
      Abort;
    end;

    if DSDetalle1.DataSet.State = dsEdit then
    begin
      if sCategoria <> categoria_el.Text then
      if Trim(categoria_el.Text) = '' then
      begin
        ShowMEssage('La categoria es de obligada inserci?n.');
        Abort;
      end;
      if sCalibre <> calibre_el.Text then
      if Trim(calibre_el.Text) = '' then
      begin
        ShowMEssage('El calibre es de obligada inserci?n.');
        Abort;
      end;
    end;
  end
  else
  if PDetalle2.Visible then
  begin
    //Entrada
    DSDetalle2.DataSet.FieldByName('codigo_er').AsString:= DSMaestro.DataSet.FieldByName('codigo_ec').AsString;
    DSDetalle2.DataSet.FieldByName('empresa_er').AsString:= DSMaestro.DataSet.FieldByName('empresa_ec').AsString;
  end
  else
  if pnlDetalleCalidad.Visible then
  begin
    //Entrada
    DSDetalle3.DataSet.FieldByName('codigo_eca').AsString:= DSMaestro.DataSet.FieldByName('codigo_ec').AsString;
    DSDetalle3.DataSet.FieldByName('empresa_eca').AsString:= DSMaestro.DataSet.FieldByName('empresa_ec').AsString;

    //Cliente
    if stCliente.Caption = '' then
    begin
      ShowMEssage('Cliente incorrecto.');
      Abort;
    end;

    //Envase
    if stEnvase.Caption = '' then
    begin
      ShowMEssage('Envase incorrecto.');
      Abort;
    end;

    //Envase
    if stProducto.Caption = '' then
    begin
      ShowMEssage('Producto incorrecto.');
      Abort;
    end;

    //Fecha venta superior a la de entrada
    if not TryStrToDateTime( fecha_eca.Text, dVenta ) then
    begin
      ShowMEssage('Fecha de venta incorrecta.');
      Abort;
    end;

    //Porcentaje
    if not TryStrToFloat( porcentaje_eca.Text, rAux ) then
    begin
      ShowMEssage('Porcentaje incorrecto.');
      Abort;
    end;

    //Existe producto-envase-cliente-fecha
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('select * from frf_salidas_c, frf_salidas_l ');
      SQL.Add(' where empresa_sl = :empresa ');
      SQL.Add('   and fecha_sl = :fecha ');
      SQL.Add('   and centro_salida_sl = :centro ');
      SQL.Add('   and cliente_sl = :cliente ');
      SQL.Add('   and envase_sl = :envase ');
      SQL.Add('   and producto_sl = :producto ');
      SQL.Add('   and empresa_sc = empresa_sl ');
      SQL.Add('   and centro_salida_sc = centro_salida_sl ');
      SQL.Add('   and n_albaran_sc = n_albaran_sl ');
      SQL.Add('   and fecha_sc = fecha_sl ');
      SQL.Add('   and es_transito_sc <> 2  ');          //Tipo Salida: Devolucion

      ParamByName('empresa').AsString:= empresa_ec.Text;
      ParamByName('centro').AsString:= centro_llegada_ec.Text;
      ParamByName('fecha').AsDateTime:= dVenta;
      ParamByName('cliente').AsString:= cliente_eca.Text;
      ParamByName('envase').AsString:= envase_eca.Text;
      ParamByName('producto').AsString:= producto_eca.Text;
      Open;
      if IsEmpty then
      begin
        Close;

        SQL.Clear;
        SQL.Add(' select fecha_sl ');
        SQL.Add(' from frf_salidas_c, frf_salidas_l ');
        SQL.Add(' where empresa_sl = :empresa ');
        SQL.Add(' and centro_salida_sl = :centro ');
        SQL.Add(' and fecha_sl between :fechaini and :fechafin ');
        SQL.Add(' and cliente_sl = :cliente ');
        SQL.Add(' and envase_sl = :envase ');
        SQL.Add(' and producto_sl = :producto ');
        SQL.Add(' and empresa_sc = empresa_sl ');
        SQL.Add(' and centro_salida_sc = centro_salida_sl ');
        SQL.Add(' and n_albaran_sc = n_albaran_sl ');
        SQL.Add(' and fecha_sc = fecha_sl ');
        SQL.Add(' and es_transito_sc <> 2  ');          //Tipo Salida: Devolucion

        SQL.Add(' group by 1 ');
        SQL.Add(' order by 1 ');
        ParamByName('empresa').AsString:= empresa_ec.Text;
        ParamByName('centro').AsString:= centro_llegada_ec.Text;
        ParamByName('fechaini').AsDateTime:= dVenta;
        ParamByName('fechafin').AsDateTime:= dVenta+6;
        ParamByName('cliente').AsString:= cliente_eca.Text;
        ParamByName('envase').AsString:= envase_eca.Text;
        ParamByName('producto').AsString:= producto_eca.Text;
        Open;
        if IsEmpty then
        begin
          sAux:= '* En una semana no hay ninguna salida del centro/producto/envase ' + centro_llegada_ec.Text + '/' +  producto_eca.Text + '/' + envase_eca.Text +
                 ' para el cliente ' + cliente_eca.Text + '.'+ #13 + #10;
        end
        else
        begin
          sAux:= '* Hay salidas para el centro/producto/envase ' + centro_llegada_ec.Text + '/' +  producto_eca.Text + '/' + envase_eca.Text +
                 ' los dias ' + QuotedStr( FieldByname('fecha_sl').AsString );
          Next;
          while not Eof do
          begin
            sAux:= sAux + ', ' + QuotedStr( FieldByname('fecha_sl').AsString );
            Next;
          end;
          sAux:= sAux + '.' + #13 + #10;
        end;
        Close;

        SQL.Clear;
        SQL.Add(' select producto_sl, envase_sl ');
        SQL.Add(' from frf_salidas_c, frf_salidas_l ');
        SQL.Add(' where empresa_sl = :empresa ');
        SQL.Add(' and centro_salida_sl = :centro ');
        SQL.Add(' and fecha_sl = :fecha ');
        SQL.Add(' and cliente_sl = :cliente ');
        SQL.Add(' and empresa_sc = empresa_sl ');
        SQL.Add(' and centro_salida_sc = centro_salida_sl ');
        SQL.Add(' and n_albaran_sc = n_albaran_sl ');
        SQL.Add(' and fecha_sc = fecha_sl ');
        SQL.Add(' and es_transito_sc <> 2  ');          //Tipo Salida: Devolucion

        SQL.Add(' group by 1,2 ');
        SQL.Add(' order by 1,2');
        ParamByName('empresa').AsString:= empresa_ec.Text;
        ParamByName('centro').AsString:= centro_llegada_ec.Text;
        ParamByName('fecha').AsDateTime:= dVenta;
        ParamByName('cliente').AsString:= cliente_eca.Text;
        Open;
        if IsEmpty then
        begin
          sAux:= sAux + '* No hay ninguna salida del centro ' + QuotedStr( centro_llegada_ec.Text ) + ' el dia ' + QuotedStr( fecha_eca.Text ) +
                 ' para el cliente ' + cliente_eca.Text + '.';
        end
        else
        begin
          sAux:= sAux + '* Para el centro ' + QuotedStr( centro_llegada_ec.Text ) + ' el dia ' + QuotedStr( fecha_eca.Text ) +
                 ' hay salidas con los art?culos/productos ' + QuotedStr( FieldByname('envase_sl').AsString + '/' + FieldByname('producto_sl').AsString  );
          Next;
          while not Eof do
          begin
            sAux:= sAux + ', ' + QuotedStr( FieldByname('envase_sl').AsString + '/' + FieldByname('producto_sl').AsString );
            Next;
          end;
          sAux:= sAux + '.';
        end;
        Close;

        raise Exception.Create('No existe salidas para el centro ' + QuotedStr( centro_llegada_ec.Text ) + ' del dia ' + QuotedStr(fecha_eca.Text) +
                    ' del art?culo/producto ' + envase_eca.Text + '/' + producto_eca.Text +
                    ' para el cliente ' + cliente_eca.Text + '.' + #13 + #10 + sAux);
        (*
        ShowMEssage('No existe salidas del dia ' + QuotedStr(fecha_eca.Text) +
                    ' del art?culo/producto ' + envase_eca.Text + '/' + producto_eca.Text +
                    ' para el cliente ' + cliente_eca.Text + '.' + #13 + #10 + sAux);
        Abort;
        *)
      end
      else
      begin
        Close;
      end;

    end;

  end
  else
  if pnlDetalleMaterial.Visible then
  begin
    //Entrada
    dsMaterial.DataSet.FieldByName('empresa_em').AsString:= DSMaestro.DataSet.FieldByName('empresa_ec').AsString;
    dsMaterial.DataSet.FieldByName('centro_em').AsString:= DSMaestro.DataSet.FieldByName('centro_llegada_ec').AsString;
    dsMaterial.DataSet.FieldByName('cod_proveedor_em').AsString:= DSMaestro.DataSet.FieldByName('proveedor_ec').AsString;
    dsMaterial.DataSet.FieldByName('fecha_em').AsString:= DSMaestro.DataSet.FieldByName('fecha_carga_ec').AsString;
    dsMaterial.DataSet.FieldByName('codigo_em').AsString:= DSMaestro.DataSet.FieldByName('albaran_ec').AsString;

    //Cliente
    if stEnvaseOperador.Caption = '' then
    begin
      ShowMEssage('Falta el c?digo del operador/envase o es incorrecto.');
      Abort;
    end;

    if Trim(entrada_em.Text) = '' then
    begin
      dsMaterial.DataSet.FieldByName('entrada_em').AsInteger:= 0;
    end;
    if Trim(salida_em.Text) = '' then
    begin
      dsMaterial.DataSet.FieldByName('salida_em').AsInteger:= 0;
    end;

  end;
end;

function TFMEntregasProveedor_SAT.RegistroActual: String;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  result:= ' where (';

  for i := 0 to Lista.Count - 1 do
  begin
    objeto := Lista.Items[i];
    if (objeto is TBDEdit) then
    begin
      with objeto as TBDEdit do
      begin
        if PrimaryKey and (Trim(Text) <> '') then
        begin
          if flag then result:= result+ ' and ';
          if InputType = itChar then
            result:= result+ ' ' + name + ' =' + SQLFilter(Text)
          else
            if InputType = itDate then
              result:= result+ ' ' + name + ' =' + SQLDate(Text)
            else
              result:= result+ ' ' + name + ' =' + Text;
          flag := True;
        end;
      end;
    end;
  end;
  result:= result+ ') ';
end;

procedure TFMEntregasProveedor_SAT.Previsualizar;
begin
  //De momento solo se grabarn los aprovechamientos en Maset de Seva
  if empresa_ec.Text = '037' then
  begin
    PrevisualizarMaset;
  end
  else
  begin
    PrevisualizarResto;
  end;
end;

procedure TFMEntregasProveedor_SAT.PrevisualizarResto;
var
  QREntregas: TQREntregas;
begin
  QREntregas := TQREntregas.Create(self);
  QREntregas.ReportTitle := self.Caption;
  MDEntregas.PutSQL( RegistroActual );
  try
    try
      MDEntregas.QListEntregasC.Open;
      MDEntregas.TListEntregasL.Open;
      MDEntregas.TListEntregasRel.Open;


        MDEntregas.QueryPacking( False );
        MDEntregas.TListPackingList.Open;
        MDEntregas.TListFechasPacking.Open;


      if DMConfig.EsLaFont then
        MDEntregas.TListGastosEntregas.Open;

      PonLogoGrupoBonnysa( QREntregas, empresa_ec.Text );
      //QREntregas.PonBarCode( codigo_ec.Text );
      Preview(QREntregas);
    finally
        MDEntregas.TListFechasPacking.Close;
        MDEntregas.TListPackingList.Close;
      if DMConfig.EsLaFont then
        MDEntregas.TListGastosEntregas.Close;

      MDEntregas.TListEntregasL.Close;
      MDEntregas.TListEntregasRel.Close;
      MDEntregas.QListEntregasC.Close;
    end;
  except
    FreeAndNil(QREntregas);
    raise;
  end;
end;

procedure TFMEntregasProveedor_SAT.PrevisualizarMaset;
var
  QREntregasMaset: TQREntregasMaset;
begin
  QREntregasMaset := TQREntregasMaset.Create(self);
  QREntregasMaset.ReportTitle := self.Caption;
  MDEntregas.PutSQL( RegistroActual );
  try
    try
      MDEntregas.QListEntregasC.Open;
      MDEntregas.TListEntregasL.Open;
      MDEntregas.TListEntregasRel.Open;


        MDEntregas.QueryPacking( False );
        MDEntregas.TListPackingList.Open;
        MDEntregas.TListFechasPacking.Open;
        MDEntregas.TListStatusPacking.Open;
        MDEntregas.TListCalibrePacking.Open;


      if DMConfig.EsLaFont then
        MDEntregas.TListGastosEntregas.Open;

      PonLogoGrupoBonnysa( QREntregasMaset, empresa_ec.Text );
      //QREntregasMaset.PonBarCode( codigo_ec.Text );
      Preview(QREntregasMaset);
    finally
        MDEntregas.TListFechasPacking.Close;
        MDEntregas.TListPackingList.Close;
        MDEntregas.TListStatusPacking.Close;
        MDEntregas.TListCalibrePacking.Close;
      if DMConfig.EsLaFont then
        MDEntregas.TListGastosEntregas.Close;

      MDEntregas.TListEntregasL.Close;
      MDEntregas.TListEntregasRel.Close;
      MDEntregas.QListEntregasC.Close;
    end;
  except
    FreeAndNil(QREntregasMaset);
    raise;
  end;
end;


procedure TFMEntregasProveedor_SAT.VerDetalle;
var
  i: integer;
begin
  for i := 0 to PageControl.PageCount - 1 do
  begin
    PageControl.Pages[i].TabVisible := True;
  end;

  //PanelDetalle.Height := 0;
  PanelDetalle.visible := False;

  PMaestro.Height:= 364;
  observaciones_ec.Visible:= True;
  lObservacion.Visible:= True;

  if pMantenimientoGastos.Visible then
  begin
    pMantenimientoGastos.Enabled:= True;
    btnGastos.Enabled:= True;
    btnBalance.Enabled:= True;
  end;

  DataSourceDetalle.DataSet.Close;
  DataSourceDetalle.DataSet.Open;

  if PageControl.ActivePage.Name = tsCalidad.Name then
  begin
    PintaDestrioCalidad;
  end;
end;

procedure TFMEntregasProveedor_SAT.EditarDetalle;
var
  i: integer;
begin
  for i := 0 to PageControl.PageCount - 1 do
  begin
    if PageControl.ActivePage <> PageControl.Pages[i] then
      PageControl.Pages[i].TabVisible := False;
  end;

  if PageControl.ActivePage.Name = tsDetalle.Name then
  begin
    DataSourceDetalle := DSDetalle1;
    PanelDetalle := PDetalle1;
    RejillaVisualizacion := RVisualizacion1;
    FocoDetalle := producto_el;
  end
  else
  if PageControl.ActivePage.Name = tsEntradas.Name then
  begin
    DataSourceDetalle := DSDetalle2;
    PanelDetalle := PDetalle2;
    RejillaVisualizacion := RVisualizacion2;
    FocoDetalle := centro_er;
  end
  else
  if PageControl.ActivePage.Name = tsCalidad.Name then
  begin
    DataSourceDetalle := DSDetalle3;
    PanelDetalle := pnlDetalleCalidad;
    RejillaVisualizacion := RVisualizacionCalidad;
    FocoDetalle := cliente_eca;
  end
  else
  if PageControl.ActivePage.Name = tsMaterial.Name then
  begin
    DataSourceDetalle := dsMaterial;
    PanelDetalle := pnlDetalleMaterial;
    RejillaVisualizacion := RVisualizacionMaterial;
    FocoDetalle := cod_operador_em;
  end;

  PanelDetalle.visible := True;

  observaciones_ec.Visible:= False;
  lObservacion.Visible:= False;
  PMaestro.Height:= 285;

  sCategoria:= categoria_el.Text;
  sCalibre:= calibre_el.Text;

  if pMantenimientoGastos.Visible then
  begin
    pMantenimientoGastos.Enabled:= False;
    btnGastos.Enabled:= False;
    btnBalance.Enabled:= False;
  end;

  iUnidadPrecio:= -2;

  if PDetalle2.Visible then
  begin
    iUnidadPrecio:= -2;
    lblCosechero.Caption := desCosechero(empresa_ec.Text, cosechero_er.Text);
    lblPlantacion.Caption := desPlantacionEx(empresa_ec.Text, producto_er.Text, plantacion_er.Text, cosechero_er.Text, fecha_carga_ec.Text);
  end;

  if PDetalle1.Visible then
  begin
    variedad_elChange( variedad_el );
  end;
end;

procedure TFMEntregasProveedor_SAT.Altas;
begin
  ShowMEssage(' ATENCI?N: La opcion de menu para dar de alta una entrega es Compras / Entregas de Proveedor.');
  Exit;
end;

procedure TFMEntregasProveedor_SAT.Borrar;
begin
  if application.MessageBox('Esta usted seguro de querer borrar la cabecera con todas sus lineas?',
    '  ATENCI?N !', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDCANCEL then
    Exit;

  //Que no tenga gastos asociados
  with DMAuxDB.QAux do
  begin
    SQL.Clear;

    SQL.Add(' select * ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :codigo ');
    ParamByname('codigo').AsString:=  MDEntregas.QEntregasC.FieldBYname('codigo_ec').AsString;
    try
      try
        Open;
        if not IsEmpty then
        begin
          ShowMessage('No se puede borrar la entrega por que tiene una gastos asociados. ');
          Exit;
        end;
      finally
        Close;
      end;
    except
      //Ignoramos error
    end;
  end;

  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    DMBaseDatos.DBBaseDatos.StartTransaction;
    try
      //Borrar lineas detalle
      MDEntregas.TEntregasL.DisableControls;
      MDEntregas.TEntregasL.First;
      while not MDEntregas.TEntregasL.Eof do
      begin
        MDEntregas.TEntregasL.Delete;
      end;

      //Borrar Albaranes de entrada asociados
      MDEntregas.TEntregasRel.DisableControls;
      MDEntregas.TEntregasRel.First;
      while not MDEntregas.TEntregasRel.Eof do
      begin
        MDEntregas.TEntregasRel.Delete;
      end;

      //Borrar cabecera
//      MDEntregas.QEntregasC.Delete;
      //Borrar Cabecera con un Exec por el error de capability support
      with DMAuxDB.QAux do
      begin
        SQL.Clear;
        SQL.Add(' delete frf_entregas_c ');
        SQL.Add(' WHERE  codigo_ec = :codigo ');
        ParamByName('codigo').AsString := MDEntregas.QEntregasC.FieldBYname('codigo_ec').AsString;

        ExecSQL;
      end;

      MDEntregas.TEntregasL.EnableControls;
      MDEntregas.TEntregasRel.EnableControls;

      //Aceptar la transaccion
      DMBaseDatos.DBBaseDatos.Commit;

      MDEntregas.QEntregasC.Close;
      MDEntregas.QEntregasC.Open;
      ShowMessage('Ficha Borrada.');

    except
      if DMBaseDatos.DBBaseDatos.InTransaction then
        DMBaseDatos.DBBaseDatos.Rollback;
      raise;
    end;
  end;
end;


procedure TFMEntregasProveedor_SAT.empresa_ecChange(Sender: TObject);
begin
  tsEntradas.TabVisible:= True;
  SubPanel1.Visible:= tsEntradas.TabVisible;
  if tsEntradas.TabVisible then
    RVisualizacion1.Columns[3].Width:= 198
  else
    RVisualizacion1.Columns[3].Width:= 350;

  lblEmpresa.Caption := desEmpresa(empresa_ec.Text);
  lblCentroDestino.Caption := desCentro(empresa_ec.Text, centro_llegada_ec.Text);
  lblProveedor.Caption := desProveedor(empresa_ec.Text, proveedor_ec.Text);
  lblAlmacen.Caption := desProveedorAlmacen(empresa_ec.Text, proveedor_ec.Text, almacen_ec.Text);
  lblTransporte.Caption := desTransporte(empresa_ec.Text, transporte_ec.Text);
end;

procedure TFMEntregasProveedor_SAT.centro_llegada_ecChange(Sender: TObject);
begin
  lblCentroDestino.Caption := desCentro(empresa_ec.Text, centro_llegada_ec.Text);
end;

procedure TFMEntregasProveedor_SAT.proveedor_ecChange(Sender: TObject);
begin
  lblProveedor.Caption := desProveedor(empresa_ec.Text, proveedor_ec.Text);
  lblAlmacen.Caption := desProveedorAlmacen(empresa_ec.Text, proveedor_ec.Text, almacen_ec.Text);
end;

procedure TFMEntregasProveedor_SAT.almacen_ecChange(Sender: TObject);
begin
  lblAlmacen.Caption := desProveedorAlmacen(empresa_ec.Text, proveedor_ec.Text, almacen_ec.Text);
end;

procedure TFMEntregasProveedor_SAT.transporte_ecChange(Sender: TObject);
begin
  lblTransporte.Caption := desTransporte(empresa_ec.Text, transporte_ec.Text);
end;

procedure TFMEntregasProveedor_SAT.btnFecha_llegadaClick(Sender: TObject);
begin
  if fecha_llegada_ec.Focused then
    DespliegaCalendario( btnFecha_llegada );
end;

procedure TFMEntregasProveedor_SAT.btnFecha_CargaClick(Sender: TObject);
begin
  if fecha_carga_ec.Focused then
    DespliegaCalendario( btnFecha_carga );
end;

procedure TFMEntregasProveedor_SAT.btnEmpresa_ecClick(Sender: TObject);
begin
  if empresa_ec.Focused then
    DespliegaRejilla( btnEmpresa_ec );
end;

procedure TFMEntregasProveedor_SAT.btnCentroDestinoClick(Sender: TObject);
begin
  if centro_llegada_ec.Focused then
    DespliegaRejilla( btnCentroDestino, [empresa_ec.Text] );
end;

procedure TFMEntregasProveedor_SAT.btnProveedor_ecClick(Sender: TObject);
var
  sResult: string;
begin
  if proveedor_ec.Focused then
  if SeleccionaProveedor( self, proveedor_ec, empresa_ec.Text, sResult ) then
  begin
    proveedor_ec.Text:= sResult;
  end;
  //DespliegaRejilla( btnProveedor_ec, [empresa_ec.Text] );
end;

procedure TFMEntregasProveedor_SAT.btnAlmacenClick(Sender: TObject);
begin
  if almacen_ec.Focused then
    DespliegaRejilla( btnAlmacen, [proveedor_ec.Text] );
end;

procedure TFMEntregasProveedor_SAT.btnTransporteClick(Sender: TObject);
var
  sResult: String;
begin
  if transporte_ec.Focused then
  if SeleccionaTransportista( self, transporte_ec, empresa_ec.Text, sResult ) then
  begin
    transporte_ec.Text:= sResult;
  end;
  //DespliegaRejilla( btnTransporte, [empresa_ec.text] );
end;

procedure TFMEntregasProveedor_SAT.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  ShowMessage('H' + UMDEntregas.MDEntregas.QTotalLineas.FieldByName('palets').AsString);
end;

procedure TFMEntregasProveedor_SAT.ValorarPor;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select peso_paleta_pp, peso_cajas_pp, cajas_paleta_pp, unidades_caja_pp, unidad_precio_pp ');
    SQL.Add(' from frf_productos_proveedor ');
    SQL.Add(' where proveedor_pp = :proveedor ');
    SQL.Add('   and producto_pp = :producto ');
    SQL.Add('   and variedad_pp = :variedad ');
    ParamByName('proveedor').AsString:= proveedor_ec.Text;
    ParamByName('producto').AsString:= producto_el.Text;
    ParamByName('variedad').AsString:= variedad_el.Text;
    Open;
    if IsEmpty then
    begin
      iUnidadPrecio:= 0;
      rPesoPaleta:= 0;
      rPesoCaja:= 0;
      iCajasPaleta:= 0;
      iUnidadesCaja:= 0;
    end
    else
    begin
      iUnidadPrecio:= FieldByName('unidad_precio_pp').AsInteger ;
      rPesoPaleta:= FieldByName('peso_paleta_pp').AsFloat ;
      rPesoCaja:= FieldByName('peso_cajas_pp').AsFloat ;
      iCajasPaleta:= FieldByName('cajas_paleta_pp').AsInteger ;
      iUnidadesCaja:= FieldByName('unidades_caja_pp').AsInteger ;
    end;
    Close;
  end;
end;

procedure TFMEntregasProveedor_SAT.producto_elChange(Sender: TObject);
begin
  if ( DSDetalle1.DataSet.State  = dsEdit ) or ( DSDetalle1.DataSet.State  = dsInsert ) then
  begin
    ValorarPor;
  end;
  variedad_elChange( variedad_el );
end;

procedure TFMEntregasProveedor_SAT.empresa_ecRequiredTime(Sender: TObject;
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

procedure TFMEntregasProveedor_SAT.variedad_elChange(Sender: TObject);
begin
  if lblVariedad.Visible then
  begin
    lblVariedad.Caption:= DesVariedad( empresa_ec.Text, proveedor_ec.Text,
                                     producto_el.Text, variedad_el.Text );
    if lblVariedad.Caption = '' then
    begin
      palets_el.Enabled:= false;
      cajas_el.Enabled:= false;
      kilos_el.Enabled:= false;
      unidades_el.Enabled:= false;
      precio_el.Enabled:= false;
      cbxUnidad_precio_el.Enabled:= false;
    end
    else
    begin
      palets_el.Enabled:= True;
      cajas_el.Enabled:= True;
      kilos_el.Enabled:= True;
      unidades_el.Enabled:= True;
      precio_el.Enabled:= True;
      cbxUnidad_precio_el.Enabled:= True;

      ValorarPor;
      if ( palets_el.Text = '' ) and ( cajas_el.Text = '' ) and ( kilos_el.Text = '' ) and ( unidades_el.Text = '' )then
      begin
        if iUnidadPrecio < cbxUnidad_precio_el.Items.Count then
          cbxUnidad_precio_el.ItemIndex:= iUnidadPrecio;
      end;
    end;
  end;
end;

procedure TFMEntregasProveedor_SAT.btnProductoProveedorClick(Sender: TObject);
var
  sResult: string;
begin
  if variedad_el.Focused then
  if SeleccionaProductoProvedor( self, variedad_el, empresa_ec.Text, proveedor_ec.Text, producto_el.Text, sResult ) then
  begin
    variedad_el.Text:= sResult;
  end;
end;

procedure TFMEntregasProveedor_SAT.btnProductoClick(Sender: TObject);
begin
  if producto_el.Focused then
    DespliegaRejilla( btnProducto, [empresa_ec.text], TRUE );
end;

procedure TFMEntregasProveedor_SAT.btnCategoriaClick(Sender: TObject);
begin
  if categoria_el.Focused then
    DespliegaRejilla( btnCategoria, [empresa_ec.text, producto_el.Text] );
end;

procedure TFMEntregasProveedor_SAT.btnCalibreClick(Sender: TObject);
begin
  if calibre_el.Focused then
    DespliegaRejilla( btnCalibre, [empresa_ec.text, producto_el.Text] );
end;

procedure TFMEntregasProveedor_SAT.RVisualizacion1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  sAux: string;
begin
  if DataCol = 3 then
  begin
    sAux:= DesVariedad( empresa_ec.Text, proveedor_ec.Text,
                        DSDetalle1.DataSet.FieldByName('producto_el').AsString,
                        DSDetalle1.DataSet.FieldByName('variedad_el').AsString );
    if ( gdSelected in State ) or ( gdFocused in State ) then
    begin
      if RVisualizacion1.Focused then
        RVisualizacion1.Canvas.Brush.Color := clMenuHighlight
      else
        RVisualizacion1.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      RVisualizacion1.Canvas.Brush.Color := clWhite;
    end;

    RVisualizacion1.Canvas.TextRect(Rect,Rect.Left, Rect.Top, sAux);

  end
  else
  if DataCol = 9 then
  begin
    if not DSDetalle1.DataSet.IsEmpty then
    begin
      case DSDetalle1.DataSet.FieldByName('unidad_precio_el').AsInteger of
        1: sAux:= 'CAJA';
        2: sAux:= 'UNIDAD';
        else
           sAux:= 'KILO';
      end;
    end
    else
    begin
      sAux:= '';
    end;
    if ( gdSelected in State ) or ( gdFocused in State ) then
    begin
      if RVisualizacion1.Focused then
        RVisualizacion1.Canvas.Brush.Color := clMenuHighlight
      else
        RVisualizacion1.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      RVisualizacion1.Canvas.Brush.Color := clWhite;
    end;

    RVisualizacion1.Canvas.TextRect(Rect,Rect.Left, Rect.Top, sAux);

  end
  else
  begin
    RVisualizacion1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFMEntregasProveedor_SAT.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if producto_eca.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(producto_eca.Text);
end;

function TFMEntregasProveedor_SAT.MantenimientoGastos: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and not DSMaestro.DataSet.IsEmpty then
  begin
    FMEntregasGastos := TFMEntregasGastos.Create(Self);
    try
      FMEntregasGastos.ShowModal;
      result:= True;
    finally
      FreeAndNil(FMEntregasGastos);
    end;
  end;
end;

procedure TFMEntregasProveedor_SAT.btnGastosClick(Sender: TObject);
begin
  if not MantenimientoGastos then
    ShowMessage('Debe tener una entrega seleccionada y en modo de visualizaci?n.')
  else
    codigo_ec.Change;
end;

procedure TFMEntregasProveedor_SAT.producto_elEnter(Sender: TObject);
begin
  if iUnidadPrecio = -2 then
  begin
    if EstadoDetalle = tedAlta then
    begin
      palets_el.Enabled:= false;
      cajas_el.Enabled:= false;
      kilos_el.Enabled:= false;
      unidades_el.Enabled:= false;
      precio_el.Enabled:= false;
      cbxUnidad_precio_el.Enabled:= false;
      iUnidadPrecio:= -1;
    end
    else
    begin
      palets_el.Enabled:= True;
      cajas_el.Enabled:= True;
      kilos_el.Enabled:= True;
      unidades_el.Enabled:= True;
      precio_el.Enabled:= True;
      cbxUnidad_precio_el.Enabled:= True;
      if unidad_precio_el.Text <> '' then
      begin
        iUnidadPrecio:= StrToInt( unidad_precio_el.Text );
        if iUnidadPrecio < cbxUnidad_precio_el.Items.Count then
          cbxUnidad_precio_el.ItemIndex:= iUnidadPrecio;
      end;
      ValorarPor;
    end;
    PesoBruto;
  end;
end;

procedure TFMEntregasProveedor_SAT.cbxUnidad_precio_elChange(Sender: TObject);
begin
  if ( DSDetalle1.DataSet.State = dsInsert ) or ( DSDetalle1.DataSet.State = dsEdit ) then
  begin
    DSDetalle1.DataSet.FieldByName('unidad_precio_el').AsInteger:= cbxUnidad_precio_el.ItemIndex;
  end;
end;

procedure TFMEntregasProveedor_SAT.unidad_precio_elChange(Sender: TObject);
begin
  if DSDetalle1.DataSet.State = dsBrowse then
  begin
    if not DSDetalle1.DataSet.IsEmpty then
    begin
      if ( DSDetalle1.DataSet.FieldByName('unidad_precio_el').AsInteger < cbxUnidad_precio_el.Items.Count ) then
        cbxUnidad_precio_el.ItemIndex:= DSDetalle1.DataSet.FieldByName('unidad_precio_el').AsInteger
      else
        cbxUnidad_precio_el.ItemIndex:= 0;
    end
    else
    begin
      cbxUnidad_precio_el.ItemIndex:= 0;
    end;
  end;
end;

procedure TFMEntregasProveedor_SAT.palets_elChange(Sender: TObject);
var
  iAux: integer;
begin
  if ( DSDetalle1.DataSet.State = dsInsert ) or ( DSDetalle1.DataSet.State = dsEdit )  then
  begin
    if iCajasPaleta > 0 then
    begin
      if Trim( palets_el.Text ) = '' then
        iAux:= 0
      else
        iAux:= StrToInt( palets_el.Text );
      iAux:= iAux * iCajasPaleta;
      if iAux > 0 then
        cajas_el.Text:= IntToStr( iAux )
      else
        cajas_el.Text:= '';
    end;
  end;
end;

procedure TFMEntregasProveedor_SAT.cajas_elChange(Sender: TObject);
var
  iAux: integer;
begin
  if ( DSDetalle1.DataSet.State = dsInsert ) or ( DSDetalle1.DataSet.State = dsEdit )  then
  begin
    if iUnidadesCaja > 0 then
    begin
      if Trim( cajas_el.Text ) = '' then
        iAux:= 0
      else
        iAux:= StrToInt( cajas_el.Text );
      iAux:= iAux * iUnidadesCaja;
      if iAux > 0 then
        unidades_el.Text:= IntToStr( iAux )
      else
        unidades_el.Text:= '';
    end;

    PesoBruto;
  end;
end;

procedure TFMEntregasProveedor_SAT.PesoBruto;
var
  iAux: integer;
  rAux: Real;
begin
    if rPesoCaja > 0 then
    begin
      if Trim( cajas_el.Text ) = '' then
        iAux:= 0
      else
        iAux:= StrToInt( cajas_el.Text );
      rAux:= iAux * rPesoCaja;
      if rPesoPaleta > 0 then
      begin
        if Trim( palets_el.Text ) = '' then
          iAux:= 0
        else
          iAux:= StrToInt( palets_el.Text );
        rAux:= rAux + ( iAux * rPesoPaleta );
      end;

      rAux:=  rAux + StrToFloatDef( kilos_el.Text, 0 );
      lblPesoBruto.Caption:= 'Peso Bruto ' +  FloatToStr( rAux ) + 'Kgs.';
    end;
end;

procedure TFMEntregasProveedor_SAT.codigo_ecChange(Sender: TObject);
begin
  if pMantenimientoGastos.Visible then
  begin
    if Trim( codigo_ec.Text ) <> '' then
    begin
      with DMAuxDB.QAux do
      begin
        SQL.Clear;
        SQL.Add(' select sum(importe_ge) importe, count(*) gastos ');
        SQL.Add(' from frf_gastos_entregas ');
        SQL.Add(' where codigo_ge = :codigo ');
        ParamByName('codigo').AsString:= codigo_ec.Text;
        try
          Open;
          STTotalGastos.Caption := FieldByName('importe').AsString + ' ? - ' +
                                   FieldByName('gastos').AsString + ' facturas.';
        finally
          Close;
        end;
      end;
    end
    else
    begin
      STTotalGastos.Caption := '';
    end;
  end;

  if ( Estado <> teLocalizar ) then
  begin
    PintaDestrioCalidad;
  end;
end;

procedure TFMEntregasProveedor_SAT.PageControlChange(Sender: TObject);
begin
  if PageControl.Pages[PageControl.TabIndex].Name = tsDetalle.Name then
  begin
    DataSourceDetalle := DSDetalle1;
    PanelDetalle := PDetalle1;
    RejillaVisualizacion := RVisualizacion1;
  end
  else
  if PageControl.Pages[PageControl.TabIndex].Name = tsEntradas.Name then
  begin
    DataSourceDetalle := DSDetalle2;
    PanelDetalle := PDetalle2;
    RejillaVisualizacion := RVisualizacion2;
  end
  else
  if PageControl.Pages[PageControl.TabIndex].Name = tsCalidad.Name then
  begin
    DataSourceDetalle := DSDetalle3;
    PanelDetalle := pnlDetalleCalidad;
    RejillaVisualizacion := RVisualizacionCalidad;
  end
  else
  if PageControl.Pages[PageControl.TabIndex].Name = tsMaterial.Name then
  begin
    DataSourceDetalle := dsMaterial;
    PanelDetalle := pnlDetalleMaterial;
    RejillaVisualizacion := RVisualizacionMaterial;
  end;
  ChangeMasterRecord;
end;

procedure TFMEntregasProveedor_SAT.cosechero_erChange(Sender: TObject);
begin
  if PDetalle2.Visible then
  begin
    lblCosechero.Caption := desCosechero(empresa_ec.Text, cosechero_er.Text);
    lblPlantacion.Caption := desPlantacionEx(empresa_ec.Text, producto_er.Text, plantacion_er.Text, cosechero_er.Text, fecha_carga_ec.Text);
  end;
end;

procedure TFMEntregasProveedor_SAT.plantacion_erChange(Sender: TObject);
begin
  if PDetalle2.Visible then
    lblPlantacion.Caption := desPlantacionEx(empresa_ec.Text, producto_er.Text, cosechero_er.Text, plantacion_er.Text, fecha_carga_ec.Text);
end;

procedure TFMEntregasProveedor_SAT.kilos_elChange(Sender: TObject);
begin
  if ( DSDetalle1.DataSet.State = dsInsert ) or ( DSDetalle1.DataSet.State = dsEdit )  then
  begin
    PesoBruto;
  end;
  aprovechados_el.Change;
end;

procedure TFMEntregasProveedor_SAT.aprovechados_elChange(Sender: TObject);
var
  rKilos, rAprovechados: Real;

begin
  if lblPorcenAprovecha.visible then
  begin
    if trim(aprovechados_el.Text) = '' then
    begin
      lblPorcenAprovecha.Caption:= '';
    end
    else
    begin
      rAprovechados:= StrToFloatDef( aprovechados_el.Text, 0 );
      rKilos:= StrToFloatDef( kilos_el.Text, 0 );
      if rKilos = 0 then
      begin
        lblPorcenAprovecha.Caption:= '';
      end
      else
      begin
        lblPorcenAprovecha.Caption:= FormatFloat( '0.00%', bRoundTo( ( rAprovechados * 100 ) / rKilos, -2 ) );
      end;
    end;
  end;
end;


procedure TFMEntregasProveedor_SAT.btnClienteClick(Sender: TObject);
begin
  if cliente_eca.Focused then
    DespliegaRejilla( btnCliente, [empresa_ec.text, cliente_eca.Text] );
end;

procedure TFMEntregasProveedor_SAT.btnProducto_ecaClick(Sender: TObject);
begin
  if producto_eca.Focused then
    DespliegaRejilla( btnProducto, [empresa_ec.text, producto_eca.Text] );
end;

procedure TFMEntregasProveedor_SAT.btnFechaCalidadClick(Sender: TObject);
begin
  if fecha_eca.Focused then
    DespliegaCalendario( btnFechaCalidad );
end;

procedure TFMEntregasProveedor_SAT.cliente_ecaChange(Sender: TObject);
begin
  stCliente.Caption:= desCliente( cliente_eca.Text );
end;

procedure TFMEntregasProveedor_SAT.envase_ecaChange(Sender: TObject);
begin
  stenvase.Caption:= desEnvase( empresa_ec.Text, envase_eca.Text );
end;

procedure TFMEntregasProveedor_SAT.envase_ecaExit(Sender: TObject);
begin
  if EsNumerico(envase_eca.Text) and (Length(envase_eca.Text) <= 5) then
    if (envase_eca.Text <> '' ) and (Length(envase_eca.Text) < 9) then
      envase_eca.Text := 'COM-' + Rellena( envase_eca.Text, 5, '0');
end;

procedure TFMEntregasProveedor_SAT.producto_ecaChange(Sender: TObject);
begin
  stProducto.Caption:= desProductoAlta( producto_eca.Text );
end;

procedure TFMEntregasProveedor_SAT.btnBalanceClick(Sender: TObject);
begin
  if Trim(codigo_ec.Text) <> '' then
    CQBalanceCompras.Previsualizar( self, empresa_ec.Text, centro_llegada_ec.Text, codigo_ec.Text )
  else
    ShowMessage('Es necesario seleccionar una entrega.');
end;

procedure TFMEntregasProveedor_SAT.DSDetalle3StateChange(Sender: TObject);
begin
  if TDataSource( Sender ).DataSet.State = dsInsert then
  begin
    TDataSource( Sender ).DataSet.FieldByName('cliente_eca').AsString:= gsDefCliente;
    TDataSource( Sender ).DataSet.FieldByName('fecha_eca').AsDateTime:= StrToDateTime( fecha_llegada_ec.Text );
    TDataSource( Sender ).DataSet.FieldByName('producto_eca').AsString:= MDEntregas.TEntregasL.FieldByName('producto_el').AsString;
    //cliente_eca.Text:= gsDefCliente;
    //fecha_eca.Text:= fecha_llegada_ec.Text;
  end;
end;

procedure TFMEntregasProveedor_SAT.btnOperadorClick(Sender: TObject);
begin
  if cod_operador_em.Focused then
    DespliegaRejilla( btnOperador, [] );
end;

procedure TFMEntregasProveedor_SAT.btnEnvaseOperadorClick(Sender: TObject);
begin
  if cod_producto_em.Focused then
    DespliegaRejilla( btnEnvaseOperador, [cod_operador_em.text] );
end;

procedure TFMEntregasProveedor_SAT.cod_operador_producto_emChange(Sender: TObject);
begin
  stEnvaseOperador.Caption:= desEnvComerProducto( cod_operador_em.Text, cod_producto_em.Text );
end;

procedure TFMEntregasProveedor_SAT.DiferenciasLineaCompra;
var
  rLinea, rCompra: Real;
begin
  if  DSDetalleTotales.DataSet.Active then
    rLinea:= DSDetalleTotales.DataSet.fieldByName('importe').AsFloat
  else
    rLinea:= 0;
  if  dsTotalCompra.DataSet.Active then
    rCompra:= dsTotalCompra.DataSet.fieldByName('importe').AsFloat
  else
    rCompra:= 0;

  rLinea:= bRoundTo( rLinea - rCompra, 2);
  if abs(rLinea) <= 0.01 then
  begin
    if rCompra = 0 then
    begin
      lblDiff.Caption:= 'FALTA';
      lblDiff.Font.Color:= clBlack;
      lblDiff.Font.Style:= lblDiff.Font.Style - [fsBold];
      lblDiff.Font.Style:= lblDiff.Font.Style + [fsItalic];
    end
    else
    begin
      lblDiff.Caption:= 'OK';
      lblDiff.Font.Color:= clBlack;
      lblDiff.Font.Style:= lblDiff.Font.Style - [fsBold];
      lblDiff.Font.Style:= lblDiff.Font.Style - [fsItalic];
    end;
  end
  else
  begin
    lblDiff.Caption:= FloatToStr( abs(rLinea) );

    if rLinea > 0  then
      lblDiff.Font.Color:= clRed
    else
      lblDiff.Font.Color:= clGreen;
    lblDiff.Font.Style:= lblDiff.Font.Style + [fsBold];
    lblDiff.Font.Style:= lblDiff.Font.Style - [fsItalic];
  end;

end;

procedure TFMEntregasProveedor_SAT.DSDetalleTotalesDataChange(Sender: TObject;
  Field: TField);
begin
  DiferenciasLineaCompra;
end;

procedure TFMEntregasProveedor_SAT.dsTotalCompraDataChange(Sender: TObject;
  Field: TField);
begin
  DiferenciasLineaCompra;
end;

procedure TFMEntregasProveedor_SAT.RVisualizacion1DblClick(Sender: TObject);
var
  rPrecio: Real;
  iUnidad: Integer;
  rAuxKilos, rAuxCajas, rAuxUnidades : Real;
  bNext, bFirts: boolean;
begin
  //Actulizar precios
  bNext:= True;
  bFirts:= True;

  while bNext and ( not MDEntregas.TEntregasL.Eof or bFirts )do
  begin
    bFirts:= False;
    if MDEntregas.TEntregasL.FieldByName('precio_el').AsFloat <> 0 then
    begin
      rPrecio:= MDEntregas.TEntregasL.FieldByName('precio_el').AsFloat;
      iUnidad:= MDEntregas.TEntregasL.FieldByName('unidad_precio_el').AsInteger;
    end
    else
    begin
      if MDEntregas.TEntregasL.FieldByName('unidad_precio_el').AsInteger = iUnidadLinea then
      begin
        rPrecio:= rPrecioLinea;
        iUnidad:= iUnidadLinea;
      end
      else
      begin
        rPrecio:= 0;
        iUnidad:= MDEntregas.TEntregasL.FieldByName('unidad_precio_el').AsInteger;
      end;
    end;

    if PutPrecioLineaEntregaFD.PutPrecioLineaEntregaExecute(
         DesVariedad( empresa_ec.Text, proveedor_ec.Text, producto_el.Text, variedad_el.Text ),
         categoria_el.Text + ' [' + desCategoria( empresa_ec.Text, producto_el.Text, categoria_el.Text ) + ']',
         calibre_el.Text,
         MDEntregas.TEntregasL.FieldByName('kilos_El').AsFloat,
         MDEntregas.TEntregasL.FieldByName('cajas_el').AsFloat,
         MDEntregas.TEntregasL.FieldByName('unidades_el').AsFloat,
         rPrecio, iUnidad, bNext ) then
    begin
      rPreciolinea:= rPrecio;
      iUnidadLinea:= iUnidad;

      rAuxKilos:= 0;
      rAuxCajas:= 0;
      rAuxUnidades:= 0;

      MDEntregas.TEntregasL.Edit;
      MDEntregas.TEntregasL.FieldByName('precio_el').AsFloat:= rPreciolinea;
      MDEntregas.TEntregasL.FieldByName('unidad_precio_el').AsFloat:= iUnidadLinea;
      case iUnidadLinea of
        0: //kilos
        begin
          rAuxKilos:= bRoundTo( MDEntregas.TEntregasL.FieldByName('kilos_El').AsFloat *  rPreciolinea, 2);
          if MDEntregas.TEntregasL.FieldByName('cajas_el').AsFloat <> 0 then
            rAuxCajas:= bRoundTo( rAuxKilos / MDEntregas.TEntregasL.FieldByName('cajas_el').AsFloat, 5)
          else
            rAuxCajas:=0;
          if MDEntregas.TEntregasL.FieldByName('unidades_el').AsFloat <> 0 then
            rAuxUnidades:= bRoundTo( rAuxKilos / MDEntregas.TEntregasL.FieldByName('unidades_el').AsFloat, 5)
          else
            rAuxUnidades:=0;
          rAuxKilos:= rPreciolinea;
        end;
        1: //cajas
        begin
          rAuxCajas:= bRoundTo( MDEntregas.TEntregasL.FieldByName('cajas_el').AsFloat *  rPreciolinea, 2);
          if MDEntregas.TEntregasL.FieldByName('kilos_El').AsFloat <> 0 then
            rAuxKilos:= bRoundTo( rAuxCajas / MDEntregas.TEntregasL.FieldByName('kilos_El').AsFloat, 5)
          else
            rAuxKilos:=0;

          if MDEntregas.TEntregasL.FieldByName('unidades_el').AsFloat <> 0 then
            rAuxUnidades:= bRoundTo( rAuxCajas / MDEntregas.TEntregasL.FieldByName('unidades_el').AsFloat, 5)
          else
            rAuxUnidades:=0;
          rAuxCajas:= rPreciolinea;
        end;
        2: //unidades
        begin
          rAuxUnidades:= bRoundTo( MDEntregas.TEntregasL.FieldByName('unidades_el').AsFloat *  rPreciolinea, 2);
          if MDEntregas.TEntregasL.FieldByName('kilos_El').AsFloat <> 0 then
            rAuxKilos:= bRoundTo( rAuxUnidades / MDEntregas.TEntregasL.FieldByName('kilos_El').AsFloat, 5)
          else
            rAuxKilos:=0;
          if MDEntregas.TEntregasL.FieldByName('cajas_el').AsFloat <> 0 then
            rAuxCajas:= bRoundTo( rAuxUnidades / MDEntregas.TEntregasL.FieldByName('cajas_el').AsFloat, 5)
          else
            rAuxCajas:=0;
          rAuxUnidades:= rPreciolinea;
        end;
      end;
      MDEntregas.TEntregasL.FieldByName('precio_kg_el').AsFloat:= rAuxKilos;
      MDEntregas.TEntregasL.Post;
    end
    else
    begin
      bNext:= False;
    end;
    if bNext then
      MDEntregas.TEntregasL.Next;
  end;
  MDEntregas.TEntregasL.Close;
  MDEntregas.TEntregasL.Open;
end;

end.

