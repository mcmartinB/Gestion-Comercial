
unit MSalidas;

interface      

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, ExtCtrls, Buttons, CMaestroDetalle, ActnList, Grids,
  DBGrids, BGrid, BDEdit, BSpeedButton, Menus, ComCtrls, DPreview,
  BCalendario, BEdit, BCalendarButton, BGridButton,
  CVariables, DError, QRPrntr, DBTables, DBCtrls, Mask;

type
  TSalidaRecord = record
    rEmpresa_sc: string;
    rCentro_salida_sc: string;
    rN_albaran_sc: integer;
    rFecha_sc: TDate;
    rHora_sc: string;
    rCliente_sal_sc: string;
    rDir_sum_sc: string;
    rCliente_fac_sc: string;
    rN_pedido_sc: string;
    rMoneda_sc: string;
    rOperadorTransporte_sc: integer;
    rTransporte_sc: integer;
    rVehiculo_sc: string;
  end;

  TFMSalidas = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LEmpresa_p: TLabel;
    centro_salida_sc: TBDEdit;
    Label1: TLabel;
    BGBEmpresa_sc: TBGridButton;
    empresa_sc: TBDEdit;
    STEmpresa_sc: TStaticText;
    Label5: TLabel;
    vehiculo_sc: TBDEdit;
    operador_transporte_sc: TBDEdit;
    LCliente: TLabel;
    DSDetalle: TDataSource;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    LAno_semana_p: TLabel;
    PDetalle: TPanel;
    RVisualizacion: TDBGrid;
    STOperador_transporte_sc: TStaticText;
    BGBoperador_transporte_sc: TBGridButton;
    BGBCentro_sc: TBGridButton;
    STCentro_salida_sc: TStaticText;
    Label9: TLabel;
    Label11: TLabel;
    n_albaran_sc: TBDEdit;
    fecha_sc: TBDEdit;
    hora_sc: TBDEdit;
    Label14: TLabel;
    cliente_sal_sc: TBDEdit;
    BGBCliente_sal_sc: TBGridButton;
    STCliente_sal_sc: TStaticText;
    Label19: TLabel;
    dir_sum_sc: TBDEdit;
    BGBDir_sum_sc: TBGridButton;
    STDir_sum_sc: TStaticText;
    cliente_fac_sc: TBDEdit;
    BGBCliente_fac_sc: TBGridButton;
    STCliente_fac_sc: TStaticText;
    Label20: TLabel;
    moneda_sc: TBDEdit;
    BGBMoneda_sc: TBGridButton;
    STMoneda_sc: TStaticText;
    LPedido: TLabel;
    n_pedido_sc: TBDEdit;
    BCBFecha_sc: TBCalendarButton;
    Label2: TLabel;
    STProducto_sl: TStaticText;
    BGBProducto_sl: TBGridButton;
    producto_sl: TBDEdit;
    Label6: TLabel;
    envase_sl: TBDEdit;
    BGBEnvase_sl: TBGridButton;
    STEnvase_sl: TStaticText;
    Label15: TLabel;
    marca_sl: TBDEdit;
    BGBMarca_sl: TBGridButton;
    STMarca_sl: TStaticText;
    Label16: TLabel;
    categoria_sl: TBDEdit;
    BGBCategoria_sl: TBGridButton;
    STCategoria_sl: TStaticText;
    Label17: TLabel;
    color_sl: TBDEdit;
    BGBColor_sl: TBGridButton;
    STcolor_sl: TStaticText;
    Label18: TLabel;
    cajas_sl: TBDEdit;
    Label21: TLabel;
    precio_sl: TBDEdit;
    Label30: TLabel;
    calibre_sl: TBDEdit;
    BGBCalibre_sl: TBGridButton;
    Label31: TLabel;
    kilos_sl: TBDEdit;
    Label32: TLabel;
    unidad_precio_sl: TBDEdit;
    Label33: TLabel;
    importe_neto_sl: TBDEdit;
    STUnidades: TStaticText;
    Lporc_iva_sl: TLabel;
    porc_iva_sl: TBDEdit;
    iva_sl: TBDEdit;
    Liva_sl: TLabel;
    LImporteTotal: TLabel;
    importe_total_sl: TBDEdit;
    Label24: TLabel;
    n_palets_sl: TBDEdit;
    Label26: TLabel;
    tipo_palets_sl: TBDEdit;
    PCabecera: TPanel;
    Label8: TLabel;
    STEmpresa: TStaticText;
    Label10: TLabel;
    STCentro: TStaticText;
    Label27: TLabel;
    STFecha: TStaticText;
    STAlbaran: TStaticText;
    Label28: TLabel;
    STCliente: TStaticText;
    Label29: TLabel;
    STSuministro: TStaticText;
    Label34: TLabel;
    tipo_iva_sl: TBDEdit;
    BGBtipo_palets_sl: TBGridButton;
    AModificarDetalle: TAction;
    ABorrarDetalle: TAction;
    AInsertarDetalle: TAction;
    AGastos: TAction;
    AMenuEmergente: TAction;
    PanelPrecio: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    precio: TBEdit;
    StaticText1: TStaticText;
    TextoPrecio: TStaticText;
    etiquetaUnidad: TStaticText;
    QSalidasC: TQuery;
    TSalidasL: TTable;
    SBGastos: TButton;
    lblFactura: TLabel;
    n_factura_sc: TBDEdit;
    fecha_factura_sc: TBDEdit;
    Label23: TLabel;
    porte_bonny_sc: TDBCheckBox;
    cbx_porte_bonny_sc: TComboBox;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    cbx_higiene_sc: TComboBox;
    n_orden_sc: TBDEdit;
    nota_sc: TDBMemo;
    higiene_sc: TDBCheckBox;
    SBFacturable: TButton;
    lblNotaFactura: TLabel;
    nota_factura_sc: TDBMemo;
    Bevel1: TBevel;
    stTipoPalets: TStaticText;
    Label38: TLabel;
    transporte_sc: TBDEdit;
    BGBtransporte_sc: TBGridButton;
    STTransporte_sc: TStaticText;
    lblNombre1: TLabel;
    lblNombre3: TLabel;
    reclamacion_sc: TDBCheckBox;
    cbx_reclamacion_sc: TComboBox;
    QAbonos: TQuery;
    lblAbonos: TLabel;
    DSAbonos: TDataSource;
    btnValorar: TButton;
    lbl1: TLabel;
    unidades_caja_sl: TBDEdit;
    lbl2: TLabel;
    facturable_sc: TDBCheckBox;
    btnValidar: TButton;
    edt_facturable_sc: TDBEdit;
    lblEntrega: TLabel;
    entrega_sl: TBDEdit;
    lblAnyoSem: TLabel;
    anyo_semana_entrega_sl: TBDEdit;
    btnDesadv: TButton;
    btnEntrega: TButton;
    lblComercial: TLabel;
    comercial_sl: TBDEdit;
    btnComercial: TBGridButton;
    txtDesComercial: TStaticText;
    btnVerAbonos: TButton;
    lbl3: TLabel;
    edtentrega_sl: TBDEdit;
    lblFechaDescarga: TLabel;
    fecha_descarga_sc: TBDEdit;
    btnFechaDescarga: TBCalendarButton;
    edtImporteFacturado: TEdit;
    btnVerImpFac: TButton;
    dbgAbonos: TDBGrid;
    edtFechaHasta: TBEdit;
    lblHasta: TLabel;
    lblNombre2: TLabel;
    es_transito_sc: TBDEdit;
    btnTipoSalida: TBGridButton;
    stxtTipoVenta: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure SalirEdit(Sender: TObject);
    procedure EntrarEdit(Sender: TObject);

    procedure PonNumeroAlbaran(Sender: TObject);
    procedure RellenaClienteFacturacion(Sender: TObject);
    procedure RellenaMoneda(Sender: TObject);
    procedure CalculaImporte(Sender: TObject);
    procedure cajas_slChange(Sender: TObject);
    procedure dir_sum_scChange(Sender: TObject);
    procedure dir_sum_scExit(Sender: TObject);
    procedure kilos_slChange(Sender: TObject);
    procedure importe_neto_slChange(Sender: TObject);
    procedure CambioDeEnvase(Sender: TObject);
    procedure CambioProducto(Sender: TObject);
    procedure AGastosExecute(Sender: TObject);
    procedure AMenuEmergenteExecute(Sender: TObject);
    procedure RVisualizacionDblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure precioEnter(Sender: TObject);
    procedure precioExit(Sender: TObject);
    procedure precioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure precioKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TSalidasLNewRecord(DataSet: TDataSet);
    procedure DSDetalleStateChange(Sender: TObject);
    procedure porte_bonny_scEnter(Sender: TObject);
    procedure porte_bonny_scExit(Sender: TObject);
    procedure QSalidasCNewRecord(DataSet: TDataSet);
    procedure SBFacturableClick(Sender: TObject);
    procedure tipo_palets_slChange(Sender: TObject);
    procedure QSalidasCAfterOpen(DataSet: TDataSet);
    procedure QSalidasCBeforeClose(DataSet: TDataSet);
    procedure btnValorarClick(Sender: TObject);
    procedure edt_facturable_scChange(Sender: TObject);
    procedure fecha_factura_scChange(Sender: TObject);
    procedure btnValidarClick(Sender: TObject);
    procedure entrega_slChange(Sender: TObject);
    procedure btnDesadvClick(Sender: TObject);
    procedure btnEntregaClick(Sender: TObject);
    procedure comercial_slChange(Sender: TObject);
    procedure btnVerAbonosClick(Sender: TObject);
    procedure QSalidasCAfterScroll(DataSet: TDataSet);
    procedure btnVerImpFacClick(Sender: TObject);
    procedure QSalidasCBeforeEdit(DataSet: TDataSet);
    procedure es_transito_scChange(Sender: TObject);

    private
    { Private declarations }
    bAbonos, bImpFac: Boolean;

    ListaComponentes: TList;
    ListaDetalle: TList;
    Objeto: TObject;

    SalidaRecord: TSalidaRecord;

    albaranObtenido: Integer;

    oldEnvase, oldMatricula: string; //Para controlar la insercion de envases dados de baja

    bPesoVariableLinea, bEnvaseVariableLinea, bFlagCambios: Boolean;
    rPesoCaja, rImpuestoLinea: real;
    sUnidadPrecioLinea: string;

    procedure RecalcularUnidades( const ASender: TObject; const AImporte: boolean = false );
    procedure EnvaseInicial;

    procedure VerDetalle;
    procedure EditarDetalle;
    procedure ValidarEntradaDetalle;
    procedure RellenaClaveDetalle;
    procedure ValidarEntradaMaestro;
    function Consulta(value: Integer; printError: Boolean): Boolean;
    function ConsultaCentro: string;
    function ConsultaProDucto: string;
    function ConsultaTransportista: string;
    function ConsultaCliente: string;
    function ConsultaSuministro: string;
    function ConsultaCalibre: string;
    function ConsultaCategoria: string;
    function ConsultaColor: string;
    procedure AbrirTablas;
    procedure CerrarTablas;
    function GetNumeroDeAlbaran(const empresa, centro: string; const AIncrementa: boolean;
               const albaran: integer = -1): Integer;
    procedure PonPanelDetalle;
    procedure PonPanelMaestro;
    procedure IncSalidaCliente(empresa, cliente: string);
    function ExisteDirSuministro: boolean;
    function NumeroCopias: Integer;

    procedure Rejilla(boton: TBGridButton);
    procedure CambiarRegistro;
    procedure PonTextoEstaticoDetalle;

    procedure GastosClick( const AFacturable: Boolean );
    procedure QSalidasCBeforePost(DataSet: TDataSet);
    procedure QSalidasCAfterEdit(DataSet: TDataSet);
    procedure QSalidasCAfterPost(DataSet: TDataSet);
    procedure ActualizarMatricula;

    procedure CargaRegistro;
    function  EstoyFacturada: boolean;
    function  EstoyContabilizada: boolean;

    function  PrevisualizarAlbaran( const AIdioma: Integer; const APedirFirma, AOriginal: boolean ): boolean;
    procedure PrevFacturaProforma;

    procedure PreguntarInforme;
    procedure PreguntarInformeEx;
    procedure SeleccionarInforme;
    procedure SeleccionarInformeEx;

    procedure PonFocoDetalle( const AEdit: TBEdit );

    procedure CambiarPrecio( const APrecio: real );
    procedure ValorarAlbaran;
    function  GetPrecioDiario( const AEmpresa, AEnvase, AProducto: string; const AFecha: TDateTime; var VUnidad: string ): real;
    procedure ActualizarPrecio( const APrecio, ANeto, ATipoIva, AIva: real; const ARowid: integer );

    function TieneDetalle: boolean;
    procedure Observaciones;

    function  ValidarAlbaran: boolean;
    function  DesValidarAlbaran: boolean;
    function  ValidarLineas: Boolean;

    procedure ActualizarUnidades( const AEmpresa, ACentro: string; const AFecha: TDate; const AAlbaran: Integer );
    function  UnidadesCorrectas( var AMsg: string ): Boolean;

    function ImporteFacturado: string;

  public
    { Public declarations }
    cabecera: TStringList;
    //SOBREESCRIBIR METODO
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure Borrar; override;
    procedure BorrarSalida;
{    procedure Aceptar;override;}
{    procedure AceptarAltaSalida;}
    procedure AntesDeInsertar;
    procedure AntesDeLocalizar;
    procedure AntesDeModificar;
      procedure ModificarNormal;
      procedure ModificarContabilizada;
    procedure AntesDeVisualizar;
    procedure AntesDeBorrarDetalle;
{    procedure ErrorAlInsertar;}

    procedure ComprobrarClavePrimaria;

    //Listado
    function  GetFirmaFileName: string;
    procedure Previsualizar; override;
    procedure PreviewCartaPorte( const APedirFirma: boolean );

    procedure RestaurarCabecera; override;
    procedure ReintentarAlta; override;

    function esClienteExtranjero(codEmp: string; codCliente: string): Boolean;
    function unidadFacturacion(const empresa, cliente,
      producto, envase: string): string;

    procedure AplicaFiltro(const AFiltro: string);


    procedure DesasignarAlbFac;
    procedure AsignarAlbFac;
  end;

var
  FMSalidas: TFMSalidas;

implementation

uses Variants, bDialogs, LFacturaProforma, UFTransportistas, bTimeUtils, CGestionPrincipal,
  UDMBaseDatos, StrUtils, CAuxiliarDB, UDMAuxDB, Principal, DFacturaProforma, MGastosSalida,
  CFactura, bSQLUtils, DInfSalidasSelect, DInfSalidasPreguntar, DAsignarAlbFac,
  UFClientes, UFSuministros, CartaPorteDL, DConfigMail, UDMConfig, bMath, bTextUtils,
  UDMCmr, GetFechaDiarioEnvases, UDQAlbaranSalida, UDQAlbaranSalidaWEB,
  SignatureForm, AdvertenciaFD, AlbaranEntreCentrosMercadonaDM, AlbaranSalidaEnvasesDM,
  CSistema, DesadvAhorramasDM, DesadvCorteInglesDM, UDMMaster, SeleccionarComercialFD,
  UQRAlbaranAlemaniaNoVar, VerOrdenFD;

{$R *.DFM}

var
  Impuesto: TImpuesto;

function bnStrToFloat(AValue: string): Real;
begin
  if Trim(AValue) = '' then
    result := 0
  else
    result := StrToFloat(AValue);
end;

function bnStrToInt(AValue: string): Integer;
begin
  if Trim(AValue) = '' then
    result := 0
  else
    result := StrToInt(AValue);
end;

procedure TFMSalidas.AbrirTablas;
begin
     // Abrir tablas/Querys
  QSalidasC.SQL.Clear;
  QSalidasC.SQL.Add(Select);
  QSalidasC.SQL.Add(Where);
  QSalidasC.SQL.Add(Order);
  QSalidasC.Open;

  TSalidasL.Open;

     //Estado inicial
  Registros := 0;
  Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMSalidas.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([TSalidasL, QSalidasC]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMSalidas.FormCreate(Sender: TObject);
begin
  bAbonos:= False;
  bImpFac:= False;

  if DMConfig.EsLaFont then
  begin
    lblNotaFactura.Visible:= True;
    nota_factura_sc.DataField:= 'nota_factura_sc';
    nota_factura_sc.Visible:= True;
    PMaestro.Height:= 345;

    dbgAbonos.Visible:= True;
    lblAbonos.Visible:= True;

    with QAbonos do
    begin
      SQL.Clear;
      (*
      SQl.Add(' select factura_fal, fecha_fal, producto_fal ');
      SQl.Add(' from frf_fac_abonos_l ');
      SQl.Add(' where empresa_fal = :empresa_sc ');
      SQl.Add('   and centro_salida_fal = :centro_salida_sc ');
      SQl.Add('   and fecha_albaran_fal = :fecha_sc ');
      SQl.Add('   and n_albaran_fal = :n_albaran_sc ');
      SQl.Add(' group by factura_fal, fecha_fal, producto_fal ');
      SQl.Add(' order by factura_fal, fecha_fal, producto_fal ');
      *)
      SQl.Add(' select n_factura_fc factura_fal,  fecha_factura_fc fecha_fal, ');
      SQl.Add('        case when not( automatica_fc = 0 and anulacion_fc = 0 ) then ''*'' ');
      SQl.Add('               else cod_producto_fd end  producto_fal, ');
      SQl.Add('        n_remesa_rf remesa, sum( importe_neto_fd ) importe ');
      SQl.Add('  from tfacturas_cab ');
      SQl.Add('       join tfacturas_det on cod_factura_fc = cod_factura_fd ');
      SQl.Add('       left join tremesas_fac on cod_factura_rf = cod_factura_fc ');
      SQl.Add(' where cod_empresa_albaran_fd = :empresa_sc ');
      SQl.Add(' and cod_centro_albaran_fd = :centro_salida_sc ');
      SQl.Add(' and n_albaran_fd = :n_albaran_sc ');
      SQl.Add(' and fecha_albaran_fd = :fecha_sc ');
      SQl.Add(' group by factura_fal, fecha_fal, producto_fal, n_remesa_rf ');
      SQl.Add(' order by fecha_fal, factura_fal desc, producto_fal ');
    end;
  end
  else
  begin
    lblNotaFactura.Visible:= False;
    nota_factura_sc.DataField:= '';
    nota_factura_sc.Visible:= False;
    PMaestro.Height:= 315;

    dbgAbonos.Visible:= False;
    lblAbonos.Visible:= False;
  end;

  LineasObligadas := true;
  ListadoObligado := true;
  // INICIO
  //Tamaño y posicion del formulario
 {+}Height := 25;
  Width := 200;

    //Titulo
  Self.Caption := 'SALIDAS DE FRUTA/CABECERA';

     //Variables globales
  M := Self;
  MD := Self;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PanelDetalle := PDetalle;
  RejillaVisualizacion := RVisualizacion;
  cabecera := TStringList.Create;

     //Fuente de datos
 {+}DataSetMaestro := QSalidasC;
  DataSourceDetalle := DSDetalle;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_salidas_c ';
  from := ' FROM frf_salidas_c ';
 {+}where := ' WHERE empresa_sc=' + QuotedStr('###');
  Order := ' ORDER BY fecha_sc DESC, empresa_sc, centro_salida_sc, n_albaran_sc, cliente_sal_sc ';

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
  ListaComponentes := TList.Create;
  PMaestro.GetTabOrderList(ListaComponentes);
  ListaDetalle := TList.Create;
  PDetalle.GetTabOrderList(ListaDetalle);

     //Panel principal el de cabecera
  PonPanelMaestro;
     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestroDetalle then
  begin
    FormType := CVariables.tfMaestroDetalle;
    BHFormulario;
  end;
     //Inicialmente grupo de desplazamiento deshabilitado
  Visualizar;

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_sc.Tag := kEmpresa;
  centro_salida_sc.Tag := kCentro;
  cliente_sal_sc.Tag := kCliente;
  cliente_fac_sc.Tag := kCliente;
  dir_sum_sc.Tag := kSuministro;
  transporte_sc.Tag := kTransportista;
  operador_transporte_sc.Tag := kTransportista;
  moneda_sc.Tag := kMoneda;
  es_transito_sc.Tag := kTipoSalida;

  producto_sl.Tag := kProducto;
  envase_sl.Tag := kEnvase;
  marca_sl.Tag := kMarca;
  calibre_sl.Tag := kCalibre;
  categoria_sl.Tag := kCategoria;
  color_sl.Tag := kColor;
  tipo_palets_sl.Tag := kTipoPalet;
  comercial_sl.Tag:= kComercial;

  fecha_sc.Tag := kCalendar;
  fecha_descarga_sc.Tag := kCalendar;


     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeLocalizar;
  OnView := AntesDeVisualizar;
  OnViewDetail := VerDetalle;
  OnEditDetail := EditarDetalle;
  OnChangeMasterRecord := CambiarRegistro;
  OnBeforeDetailDelete := AntesDeBorrarDetalle;
{     OnErrorInsert:=ErrorAlInsertar;}

     //Asociar eventos
  QSalidasC.AfterPost := QSalidasCAfterPost;
  QSalidasC.BeforePost := QSalidasCBeforePost;
  QSalidasC.AfterEdit := QSalidasCAfterEdit;

     //Focos
  {+}FocoAltas := empresa_sc;
  {+}FocoModificar := cliente_sal_sc;
  {+}FocoLocalizar := empresa_sc;
     //Inicializacion calendarios
  CalendarioFlotante.Date := Date;
     //Inicializacion variables globales


  bPesoVariableLinea:= True;
  bEnvaseVariableLinea:= True;
  bFlagCambios:= True;
  rPesoCaja:= 0;
  rImpuestoLinea:= 0;
  sUnidadPrecioLinea:= 'K';

  btnEntrega.Top:= btnDesadv.Top;
  btnEntrega.Left:= btnDesadv.Left;
  btnEntrega.Width:= 220;
  SBGastos.Visible := DMConfig.EsLaFont or ( cliente_sal_sc.Text = 'WEB' );
  btnDesadv.Visible:= not DMConfig.EsLaFont;
  btnEntrega.Visible:= DMConfig.EsLaFont and ( empresa_sc.Text = 'F42' );;

  btnVerImpFac.Visible:=  DMConfig.EsLaFont;
  btnVerAbonos.Visible:=  DMConfig.EsLaFont;
  edtImporteFacturado.Visible:=  DMConfig.EsLaFont;
  lblAbonos.Visible:=  DMConfig.EsLaFont;
  dbgAbonos.Visible:=  DMConfig.EsLaFont;
  facturable_sc.Visible:=  DMConfig.EsLaFont;
  lblFactura.Visible:=  DMConfig.EsLaFont;
  n_factura_sc.Visible:=  DMConfig.EsLaFont;
  fecha_factura_sc.Visible:=  DMConfig.EsLaFont;

  SBFacturable.Visible:= DMConfig.EsLaFont;
  btnValorar.Visible:= DMConfig.EsLaFont;
  btnValidar.Visible:= DMConfig.EsLaFont;

  edt_facturable_scChange(edt_facturable_sc);

  lblHasta.Visible:= False;
  edtFechaHasta.Visible:= False;
end;

procedure TFMSalidas.FormActivate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  //RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestroDetalle then
  begin
    FormType := CVariables.tfMaestroDetalle;
    BHFormulario;
  end;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(PCMaestro);
  BHGrupoDesplazamientoDetalle(PCDetalle);

     //Maximizamos si no lo esta
  if Self.WindowState <> wsMaximized then
    Self.WindowState := wsMaximized;
end;


procedure TFMSalidas.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
end;

procedure TFMSalidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaComponentes.Free;
  ListaDetalle.free;

  //Destruir lista de cadenas
  if cabecera <> nil then begin
    cabecera.Free;
    cabecera := nil;
  end;

  //Variables globales
  gRF := nil;
  gCF := nil;

  //Codigo de desactivacion
  CerrarTablas;

  //Restauramos barra de herramientas si es necesario
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  // Cambia acción por defecto para Form hijas en una aplicación MDI
  // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMSalidas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

{*}//Si  el calendario esta desplegado no hacemos nada
  if (CalendarioFlotante <> nil) then
    if (CalendarioFlotante.Visible) then
            //No hacemos nada
      Exit;

    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        if not ( nota_sc.Focused or nota_factura_sc.Focused ) then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
      end;
    vk_up:
      begin
        if not ( nota_sc.Focused or nota_factura_sc.Focused ) then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        end;
      end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

//...................... FILTRO LOCALIZACION .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBEdit y que se llamen igual que el campo al que representan
//en la base de datos
//....................................................................

procedure TFMSalidas.Filtro;
var
  Flag: Boolean;
  i: Integer;
  dFechaDesde, dFechaHasta: TdateTime;
begin
  where := '';
  Flag := false;
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if ( Name <> 'fecha_sc' ) and ( Name <> 'edtFechaHasta' ) then
        if ( Trim(Text) <> '' ) and Visible then
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

  if ( fecha_sc.Text <> '' ) or ( edtFechaHasta.Text <> '' ) then
  begin
    if ( fecha_sc.Text <> '' ) and ( edtFechaHasta.Text <> '' ) then
    begin
      dFechaDesde:= StrToDateTime( fecha_sc.Text );
      dFechaHasta:= StrToDateTime( edtFechaHasta.Text );
      if dFechaHasta < dFechaDesde then
        Raise Exception.Create('Rango de fechas incorrecto.');
      if flag then where := where + ' and ';
      if ( fecha_sc.Text <> '' )  then
        where := where + ' fecha_sc ' + ' between ' + SQLDate(fecha_sc.Text) + ' and ' + SQLDate(edtFechaHasta.Text);
      flag := True;
    end
    else
    begin
      if ( fecha_sc.Text <> '' )  then
      begin
        dFechaDesde:= StrToDateTime( fecha_sc.Text );
      end
      else
      begin
        dFechaHasta:= StrToDateTime( edtFechaHasta.Text );
      end;
      if flag then where := where + ' and ';
      if ( fecha_sc.Text <> '' )  then
      begin
        where := where + ' fecha_sc ' + ' =' + SQLDate(fecha_sc.Text);
      end
      else
      begin
        where := where + ' fecha_sc ' + ' =' + SQLDate(edtFechaHasta.Text);
      end;
      flag := True;
    end;
  end;

  case cbx_porte_bonny_sc.ItemIndex of
    1:
    begin
      if flag then where := where + ' and ';
      where := where + ' porte_bonny_sc <> 0 ';
      flag := True;
    end;
    2:
    begin
      if flag then where := where + ' and ';
      where := where + ' porte_bonny_sc = 0 ';
      flag := True;
    end;
  end;

  case cbx_higiene_sc.ItemIndex of
    1:
    begin
      if flag then where := where + ' and ';
      where := where + ' higiene_sc <> 0 ';
      flag := True;
    end;
    2:
    begin
      if flag then where := where + ' and ';
      where := where + ' higiene_sc = 0 ';
      flag := True;
    end;
  end;

  case cbx_reclamacion_sc.ItemIndex of
    1:
    begin
      if flag then where := where + ' and ';
      where := where + ' reclamacion_sc <> 0 ';
      flag := True;
    end;
    2:
    begin
      if flag then where := where + ' and ';
      where := where + ' reclamacion_sc = 0 ';
      flag := True;
    end;
  end;

  if facturable_sc.State = cbUnchecked then
  begin
    if flag then where := where + ' and ';
    where := where + ' facturable_sc = 0 ';
    flag := True;
  end
  else
  if facturable_sc.State = cbChecked then
  begin
    if flag then where := where + ' and ';
    where := where + ' facturable_sc <> 0 ';
    flag := True;
  end;  

  if flag then where := ' WHERE ' + where;
end;

//...................... REGISTROS INSERTADOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// PrimaryKey del componente.
//....................................................................

procedure TFMSalidas.AnyadirRegistro;
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

//...................... VALIDAR CAMPOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// Required del componente y en RequiredMsg el mensaje que quieres mostrar
//....................................................................
// La funcion generica que realiza es comprobar que los campos que tienen
// datos por obligacion los tengan, en caso de querer hacer algo mas hay
// que implenentarlo, como comprobar la existencia de un valor en la base
// de datos
//....................................................................

procedure TFMSalidas.ValidarEntradaMaestro;
var
  i: Integer;
  dAuxDate, dDescarga: TDateTime;
begin
    //REQUERIDOS
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
          TBEdit(Objeto).setfocus;
        end;

      end;
    end;
  end;

  //Comprobar que la fecha se correcta
  if not TryStrTodate( fecha_sc.Text, dAuxDate ) then
  begin
    if fecha_sc.CanFocus then
      fecha_sc.SetFocus;
    raise Exception.Create('Fecha incorrecta.');
  end;

  //fecha descarga
  if fecha_descarga_sc.Text <> '' then
  begin
    if TryStrTodate( fecha_descarga_sc.Text, dDescarga ) then
    begin
      if dDescarga < dAuxDate then
      begin
        if fecha_descarga_sc.CanFocus then
          fecha_descarga_sc.SetFocus;
        raise Exception.Create('Fecha de descarga debe de ser superior o igual a la de descarga.');
      end;
    end
    else
    begin
      if fecha_descarga_sc.CanFocus then
        fecha_descarga_sc.SetFocus;
      raise Exception.Create('Fecha descarga incorrecta.');;
    end;
  end;



    //Clave primaria si es una alta
  if DSMaestro.State <> dsEdit then
    ComprobrarClavePrimaria;

    //Restricciones ALTAS-MODIFICAR
    //Empresa
  if DSMaestro.State <> dsEdit then
    if Trim(STEmpresa_sc.Caption) = '' then
    begin
      cliente_sal_sc.SetFocus;
      raise Exception.Create('Código de Empresa incorrecto.');
    end;

    //Centro
  if DSMaestro.State <> dsEdit then
    if Trim(STCentro_salida_sc.Caption) = '' then
    begin
      cliente_sal_sc.SetFocus;
      raise Exception.Create('Código de Centro incorrecto.');
    end;

    //Cliente salida
  if (Trim(STcliente_sal_sc.Caption) = '') then
  begin
    cliente_sal_sc.SetFocus;
    raise Exception.Create('Cliente de salida incorrecto.');
  end;

  //DIRECCION SUMINISTRO
  if (Trim(STDir_sum_sc.Caption) = '') then
  begin
    dir_sum_sc.SetFocus;
    raise Exception.Create('Falta la direccion de suministro o es incorrecta.');
  end;
  if dir_sum_sc.Text <> cliente_sal_sc.Text then
  begin
    //COMPROBAR CLAVE AJENA
    if not ExisteDirSuministro then
    begin
      dir_sum_sc.setfocus;
      raise Exception.Create('Dirección de suministro incorrecta');
    end;
  end;
  //Cliente facturacion
  if (Trim(STcliente_fac_sc.Caption) = '') then
  begin
    cliente_fac_sc.SetFocus;
    raise Exception.Create('Falta cliente de facturación o es incorrecto.');
  end;
  //Moneda
  if (Trim(STMoneda_sc.Caption) = '') then
  begin
    moneda_sc.SetFocus;
    raise Exception.Create('Falta moneda o es  incorrecta.');
  end;
     //Transporte
  if (Trim(STOperador_transporte_sc.Caption) = '') and (Trim(STtransporte_sc.Caption) = '') then
  begin
    transporte_sc.SetFocus;
    raise Exception.Create('Transporte incorrecto.');
  end
  else
  if (Trim(STOperador_transporte_sc.Caption) = '') then
  begin
    operador_transporte_sc.Text:= transporte_sc.Text;
  end
  else
  if (Trim(STtransporte_sc.Caption) = '') then
  begin
    transporte_sc.Text:= operador_transporte_sc.Text;
  end;


  if es_transito_sc.Text = '' then
  begin
    es_transito_sc.setFocus;
    raise Exception.Create('Falta tipo de la salida.');
  end
  else
  begin
    if stxtTipoVenta.Caption = '' then
    begin
      es_transito_sc.setFocus;
      raise Exception.Create('El tipo de la salida es incorecto.');
    end;
  end;

    //Guardar cabecera
  if (Estado = teAlta) then
    CargaRegistro;
end;

procedure TFMSalidas.PrevFacturaProforma;
var
  iAux: integer;
begin
  QRLFacturaProforma := TQRLFacturaProforma.Create(self);
  try
    FDFacturaProforma:= TFDFacturaProforma.Create(Self);
  except
    FreeAndNil(QRLFacturaProforma);
    Exit;
  end;

  try
    with FDFacturaProforma do
    begin
      RellenaDatos(empresa_sc.Text, centro_salida_sc.Text, fecha_sc.Text,
        n_albaran_sc.Text, cliente_sal_sc.Text, dir_sum_sc.Text, False);
      ShowModal;
      iAux:= StrToInt(nCopias.Text);
      QRLFacturaProforma.ReportTitle:= sTitulo;
    end ;

    if iAux > 0 then
    begin
      QRLFacturaProforma.StringGrid:= FDFacturaProforma.StringGrid1;
      QRLFacturaProforma.printerSettings.Copies:= iAux;

      try
        Previsualiza(QRLFacturaProforma, iAux);
      finally
        FreeAndNil( QRLFacturaProforma );
      end;
    end
    else
    begin
      FreeAndNil(QRLFacturaProforma);
    end;
    FreeAndNil(FDFacturaProforma);
  except
    FreeAndNil(QRLFacturaProforma);
    FreeAndNil(FDFacturaProforma);
  end;
end;



function TFMSalidas.PrevisualizarAlbaran( const AIdioma: Integer; const APedirFirma, AOriginal: boolean ): boolean;
begin
  if AIdioma = 0 then
  begin
    if cliente_sal_sc.Text = 'WEB' then
    begin
       result:= UDQAlbaranSalidaWEB.PreAlbaran( Self, empresa_sc.text, centro_salida_sc.Text,
                   StrToInt( n_albaran_sc.Text), StrToDateTime( fecha_sc.Text ), APedirFirma, AOriginal );
    end
    else
    if empresa_sc.Text = '506'  then
    begin
       result:= AlbaranEntreCentrosMercadonaDM.PreAlbaran( Self, empresa_sc.text, centro_salida_sc.Text,
                   StrToInt( n_albaran_sc.Text), StrToDateTime( fecha_sc.Text ), APedirFirma, AOriginal );
       (*
       result:= AlbaranSalidaEnvasesDM.PreAlbaran( Self, empresa_sc.text, centro_salida_sc.Text,
                   StrToInt( n_albaran_sc.Text), StrToDateTime( fecha_sc.Text ), APedirFirma, AOriginal ) or Result;
       *)
    end
    else
    begin
       result:= UDQAlbaranSalida.PreAlbaran( Self, empresa_sc.text, centro_salida_sc.Text,
                 StrToInt( n_albaran_sc.Text), StrToDateTime( fecha_sc.Text ), APedirFirma, AOriginal );
    end
  end
  else
  if AIdioma = 1 then
  begin
    result:= UQRAlbaranAlemaniaNoVar.PreAlbaranAleman( empresa_sc.Text, centro_salida_sc.Text, cliente_sal_sc.Text, StrToInt( n_albaran_sc.text ),
                               StrToDate( fecha_sc.text ), APedirFirma, AOriginal );
  end
  else
  begin
    Result:= False;
  end;
end;

procedure AddMsg( var AMsg: string; const ACad: string );
begin
  if AMsg = '' then
    AMsg:=  ACad
  else
    AMsg:=  AMsg + #13 + #10 + ACad;
end;

function TFMSalidas.UnidadesCorrectas( var AMsg: string ): Boolean;
begin
  Result:= false;
  AMsg:= '';
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select producto_sl, envase_sl, unidades_caja_sl, unidades_variable_e, unidades_e,  kilos_sl, peso_variable_e, round( peso_neto_e * cajas_sl, 2) peso ');
    SQL.Add('from frf_salidas_l join frf_envases on empresa_e = empresa_sl  and envase_e = envase_sl ');
    SQL.Add('where empresa_sl = :empresa ');
    SQL.Add('and centro_salida_sl = :centro ');
    SQL.Add('and n_albaran_sl = :albaran ');
    SQL.Add('and fecha_sl = :fecha ');
    ParamByName('empresa').AsString:= empresa_sc.Text;
    ParamByName('centro').AsString:= centro_salida_sc.Text;
    ParamByName('fecha').AsString:= fecha_sc.Text;
    ParamByName('albaran').AsString:= n_albaran_sc.Text;
    Open;
    if not IsEmpty then
    begin
      while not Eof do
      begin
        //Kilos
        if FieldByName('peso_variable_e').AsInteger = 0 then
        begin
          if FieldByName('kilos_sl').AsInteger <> FieldByName('peso').AsInteger then
          begin
            AddMsg( AMsg, 'ERROR: No coincide los kilos para el envase ' + FieldByname('envase_sl').AsString +
                          ' Albaran: ' +  FieldByname('kilos_sl').AsString +  ' Esperado: ' +
                          FieldByname('peso').AsString );
          end;
        end;
        //Unidades
        if FieldByName('unidades_variable_e').AsInteger = 0 then
        begin
          if FieldByName('unidades_caja_sl').AsInteger <> FieldByName('unidades_e').AsInteger then
          begin
            AddMsg( AMsg, 'ERROR: No coincide las unidades por caja para el envase ' + FieldByname('envase_sl').AsString +
                          ' Albaran: ' +  FieldByname('unidades_caja_sl').AsString +  ' Esperado: ' +
                          FieldByname('unidades_e').AsString );
          end;
        end;
        Next;
      end;
      Result:= AMsg = '';
    end
    else
    begin
      AMsg:= 'ERROR: Albaran sin lineas.';
    end;
    Close;
  end;
end;

procedure TFMSalidas.SeleccionarInformeEx;
var
  iImpresora, iTipoAlbaran, iResult: integer;
  bPedirFirma, bOriginal: boolean;
begin
    bPedirFirma:= gbFirmar;
    iTipoAlbaran:= TipoAlbaran( empresa_sc.Text, cliente_sal_sc.Text );
    iResult:= Seleccionar( iImpresora, iTipoAlbaran, bPedirFirma, bOriginal );

    if ( iResult - 1000 ) >= 0 then
    begin
      iResult:= iResult - 1000;
      if not PrevisualizarAlbaran( iTipoAlbaran, bPedirFirma, bOriginal ) then
        iResult:= 0;
    end;

    if ( iResult - 100 ) >= 0 then
    begin
      iResult:= iResult - 100;
      PreviewCartaPorte( bPedirFirma );
    end;

    if ( iResult - 10 ) >= 0 then
    begin
      iResult:= iResult - 10;
      UDMCmr.ExecVentaCMR( empresa_sc.Text, centro_salida_sc.Text, cliente_sal_sc.Text, dir_sum_sc.Text, transporte_sc.Text, nota_sc.Text,
                      StrToDate( fecha_sc.Text ), StrToInt( n_albaran_sc.Text ), QSalidasC.FieldByName('higiene_sc').AsInteger = 1 );
    end;

    if ( iResult - 1 ) >= 0 then
    begin
      PrevFacturaProforma;
    end;
end;

procedure TFMSalidas.SeleccionarInforme;
var
  sMsg: string;
begin
  if UnidadesCorrectas( sMsg ) then
  begin
    SeleccionarInformeEx;
  end
  else
  begin
    if VerAdvertencia( Self, Trim( sMsg ) ) = mrIgnore then
    begin
      SeleccionarInformeEx;
    end;
  end;
end;


procedure TFMSalidas.PreguntarInformeEx;
var
  AImpresora, iTipoAlbaran: integer;
  bPedirFirma, bOriginal: boolean;
  sMsg: string;
begin
    if esClienteExtranjero(empresa_sc.Text, cliente_sal_sc.Text) or (Cliente_sal_sc.Text = 'DAI') then
    begin
      if DInfSalidasPreguntar.Preguntar( 0, AImpresora, bPedirFirma, bOriginal ) then
      begin
        iTipoAlbaran:= TipoAlbaran( empresa_sc.Text, cliente_sal_sc.Text );
        if iTipoAlbaran = 2 then
          iTipoAlbaran:= 1
        else
          iTipoAlbaran:= 0;
        PrevisualizarAlbaran( iTipoAlbaran, bPedirFirma, bOriginal );
      end;
      if DMConfig.EsUnAlmacen then
      begin
        if DInfSalidasPreguntar.Preguntar( 1, AImpresora, bPedirFirma, bOriginal ) then
        begin
          UDMCmr.ExecVentaCMR( empresa_sc.Text, centro_salida_sc.Text, cliente_sal_sc.Text, dir_sum_sc.Text, transporte_sc.Text, nota_sc.Text,
                        StrToDate( fecha_sc.Text ), StrToInt( n_albaran_sc.Text ), QSalidasC.FieldByName('higiene_sc').AsInteger = 1 );
        end;
        if DInfSalidasPreguntar.Preguntar( 2, AImpresora, bPedirFirma, bOriginal ) then
          PrevFacturaProforma;
      end;
    end
    else
    begin
      if DInfSalidasPreguntar.Preguntar( 0, AImpresora, bPedirFirma, bOriginal ) then
      begin
        iTipoAlbaran:= TipoAlbaran( empresa_sc.Text, cliente_sal_sc.Text );
        if iTipoAlbaran = 2 then
          iTipoAlbaran:= 1
        else
          iTipoAlbaran:= 0;
        PrevisualizarAlbaran( iTipoAlbaran, bPedirFirma, bOriginal );
      end;
      if DMConfig.EsUnAlmacen then
      begin
        //if Preguntar( 3, AImpresora ) then
        PreviewCartaPorte( bPedirFirma );
        if DInfSalidasPreguntar.Preguntar( 2, AImpresora, bPedirFirma, bOriginal ) then
          PrevFacturaProforma;
      end;
    end;
end;

procedure TFMSalidas.PreguntarInforme;
var
  sMsg: string;
begin
  if UnidadesCorrectas( sMsg ) then
  begin
    PreguntarInformeEx;
  end
  else
  begin
    if VerAdvertencia( Self, Trim( sMsg ) ) = mrIgnore then
    begin
      PreguntarInformeEx;
    end;
  end;
end;

procedure TFMSalidas.Previsualizar;
begin
  DConfigMail.sEmpresaConfig:= empresa_sc.Text;
  DConfigMail.sClienteConfig:= cliente_sal_sc.Text;
  DConfigMail.SSuministroConfig:= dir_sum_sc.Text;
  DConfigMail.sAlbaranConfig:= n_albaran_sc.Text;
  DConfigMail.sFechaConfig:= fecha_sc.Text;
  if n_pedido_sc.Text <> '' then
    DConfigMail.sAsunto:= 'Envio Albarán [' + cliente_sal_sc.Text + '-' + n_albaran_sc.Text + '] - Pedido: ' + n_pedido_sc.Text
  else
    DConfigMail.sAsunto:= 'Envio Albarán [' + cliente_sal_sc.Text + '-' + n_albaran_sc.Text + ']';

  if Estado <> teOperacionDetalle then
  begin
    //Dialogo que nos permite seleccionar el informe que deseamos
    SeleccionarInforme;
  end
  else
  begin
    //Serie de preguntas para imprimir los distintos informes
    PreguntarInforme;
  end;
end;

function  TFMSalidas.GetFirmaFileName: string;
var
  sFilename: string;
  iAnyo, iMes, iDia: word;
begin

  result:= '';
  if gsDirFirmasGlobal <> '' then
  begin
    if DirectoryExists( gsDirFirmasGlobal ) then
      result:=  gsDirFirmasGlobal;
  end;
  if result = '' then
  begin
    if gsDirFirmasLocal <> '' then
    begin
      if DirectoryExists( gsDirFirmasLocal ) then
        result:=  gsDirFirmasLocal;
    end;
  end;

  if result <> '' then
  begin
    DecodeDate( StrToDate( fecha_sc.Text ), iAnyo, iMes, iDia );
    sFilename:= intToStr( iAnyo ) + empresa_sc.Text + centro_salida_sc.Text + cliente_sal_sc.Text + '-' + n_albaran_sc.Text;
    result:= result + '\' + sFileName + '.jpg';
  end;
end;

procedure TFMSalidas.PreviewCartaPorte( const APedirFirma: boolean );
var
  SFileName, sMsg: string;
begin
  SFileName:= GetFirmaFileName;
  if APedirFirma then
  begin
    if sFileName = '' then
    begin
      ShowMessage('Falta inicializar la ruta para guardar las firmas.');
    end
    else
    begin
      if not FileExists( sFileName ) then
      if not SignatureForm.SignSave( self, sFilename, sMsg ) then
      begin
        ShowMessage( sMsg );
      end;
        //GetFirma( self, sFilename );//OLDTablet
    end;
  end;

  CartaPorteDL.Ejecutar( self, empresa_sc.Text, centro_salida_sc.Text,
                         StrToInt(n_albaran_sc.Text), StrToDate(fecha_sc.Text),
                         SFileName );
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMSalidas.ARejillaFlotanteExecute(Sender: TObject);
var
  sAux: string;
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  if ActiveControl <> nil then
  case ActiveControl.Tag of
    kEmpresa:
      begin
        DespliegaRejilla(BGBEmpresa_sc);
      end;
    kCentro:
      begin
        DespliegaRejilla(BGBcentro_sc, [empresa_sc.Text])
      end;
    kCliente:
      begin
        if cliente_sal_sc.Focused then
        begin
          //DespliegaRejilla(BGBcliente_sal_sc, [empresa_sc.Text])
          sAux:= cliente_sal_sc.Text;
          if SeleccionaClientes( self, cliente_sal_sc, empresa_sc.Text, sAux ) then
          begin
            cliente_sal_sc.Text:= sAux;
          end;
        end
        else
        begin
          //DespliegaRejilla(BGBcliente_fac_sc, [empresa_sc.Text]);
          sAux:= cliente_fac_sc.Text;
          if SeleccionaClientes( self, cliente_fac_sc, empresa_sc.Text, sAux ) then
          begin
            cliente_fac_sc.Text:= sAux;
          end;
        end;
      end;
    kSuministro:
      //DespliegaRejilla(BGBdir_sum_sc, [empresa_sc.Text, cliente_sal_sc.Text]);
      begin
        sAux:= dir_sum_sc.Text;
        if SeleccionaSuministros( self, dir_sum_sc, empresa_sc.Text, cliente_sal_sc.Text, sAux ) then
        begin
          dir_sum_sc.Text:= sAux;
        end;
      end;
    kMoneda: DespliegaRejilla(BGBmoneda_sc);
    kTransportista:
    if operador_transporte_sc.Focused then
    begin
      sAux:= operador_transporte_sc.Text;
      if SeleccionaTransportista( self, operador_transporte_sc, empresa_sc.Text, sAux ) then
      begin
        operador_transporte_sc.Text:= sAux;
      end;
    end
    else
    begin
      sAux:= transporte_sc.Text;
      if SeleccionaTransportista( self, transporte_sc, empresa_sc.Text, sAux ) then
      begin
        transporte_sc.Text:= sAux;
      end;
    end;
    kTipoSalida: DespliegaRejilla(btnTipoSalida);
    kProducto: Rejilla(BGBproducto_sl);
    kMarca: DespliegaRejilla(BGBmarca_sl);
    kEnvase: DespliegaRejilla(BGBenvase_sl, [empresa_sc.Text, producto_sl.Text, cliente_sal_sc.Text]);
    kColor: DespliegaRejilla(BGBcolor_sl, [empresa_sc.Text, producto_sl.Text]);
    kCategoria: DespliegaRejilla(BGBcategoria_sl, [empresa_sc.Text, producto_sl.Text]);
    kCalibre: DespliegaRejilla(BGBcalibre_sl, [empresa_sc.Text, producto_sl.Text]);
    ktipoPalet: DespliegaRejilla(BGBTipo_palets_sl);
    kCalendar:
      if fecha_sc.Focused then
         DespliegaCalendario(BCBfecha_sc)
      else
         DespliegaCalendario(btnFechaDescarga);
    kComercial:
    begin
      RejillaFlotante.DataSource := UDMMaster.DMMaster.dsDespegables;
      UDMMaster.DMMaster.DespliegaRejilla(btnComercial, ['']);
    end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************

//Evento que se produce cuando cambia el registro activo
//Tambien se genera cuando se muestra el primero
//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMSalidas.AntesDeInsertar;
begin
     //Rejilla en visualizacion
  VerDetalle;
     //Fecha y hora la del sistema
  fecha_sc.Text := DateToStr(Date);
  hora_sc.Text := HoraMinuto(Time);
  PonPanelMaestro;
end;

procedure TFMSalidas.AntesDeLocalizar;
begin
     //Rejilla en visualizacion
  VerDetalle;

  PonPanelMaestro;

  porte_bonny_sc.Visible:= False;
  cbx_porte_bonny_sc.ItemIndex:= 0;
  cbx_porte_bonny_sc.Visible:= True;

  higiene_sc.Visible:= False;
  cbx_higiene_sc.ItemIndex:= 0;
  cbx_higiene_sc.Visible:= True;

  reclamacion_sc.Visible:= False;
  cbx_reclamacion_sc.ItemIndex:= 0;
  cbx_reclamacion_sc.Visible:= True;


  //n_factura_sc.Enabled:= True;
  n_factura_sc.TabStop:= True;
  n_factura_sc.ReadOnly:= False;
  n_factura_sc.ColorEdit:= clMoneyGreen;
  n_factura_sc.ColorNormal:= clWhite;
  n_factura_sc.ColorDisable:= clSilver;

  //fecha_factura_sc.Enabled:= True;
  fecha_factura_sc.TabStop:= True;
  fecha_factura_sc.ReadOnly:= False;
  fecha_factura_sc.ColorEdit:= clMoneyGreen;
  fecha_factura_sc.ColorNormal:= clWhite;
  fecha_factura_sc.ColorDisable:= clSilver;

  facturable_sc.AllowGrayed:= True;
  facturable_sc.State:= cbGrayed;
  facturable_sc.Enabled:= True;

  lblHasta.Visible:= True;
  edtFechaHasta.Visible:= True;
  edtFechaHasta.Text:= '';
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMSalidas.ModificarContabilizada;
var
  i: Integer;
begin
  //Sólo para modificaciones normales
  if Estado = teModificar then
  begin
    for i := 0 to ListaComponentes.Count - 1 do
    begin
      Objeto := ListaComponentes.Items[i];
      if (Objeto is TwinControl) then
        TwinControl( Objeto ).Enabled:= False;
    end;
    transporte_sc.Enabled:= True;
    operador_transporte_sc.Enabled:= True;
    porte_bonny_sc.Enabled:= True;
    //n_cmr_sc.Enabled:= True;
    n_orden_sc.Enabled:= True;
    higiene_sc.Enabled:= True;
    reclamacion_sc.Enabled:= True;
    nota_sc.Enabled:= True;
    n_pedido_sc.Enabled:= True;
    vehiculo_sc.Enabled:= True;
    nota_factura_sc.Enabled:= True;
    nota_factura_sc.Color:= clWhite;
    //nota_factura_sc.Color:= clBtnFace;
  end;
  FocoModificar := n_pedido_sc;
  PonPanelMaestro;
end;

procedure TFMSalidas.ModificarNormal;
var
  i: Integer;
begin
  //Sólo para modificaciones normales
  if Estado = teModificar then
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
  FocoModificar := cliente_sal_sc;
  PonPanelMaestro;
end;

procedure TFMSalidas.AntesDeModificar;
begin
  (*TODO*)
  (*Solo el numero de pedido*)
  if estoyContabilizada then
  begin
    ShowMessage('Factura contabilizada, solo se permitiran modificar un número limitado de campos.');
    ModificarContabilizada;
  end
  else
  if estoyFacturada then
  begin
    ShowMessage('Albarán asociado a una factura, recuerde repetirla si modifica el albarán');
  end
  else
  begin
    ModificarNormal;
  end;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMSalidas.AntesDeVisualizar;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
          Enabled := true;
  end;
  porte_bonny_sc.Enabled:= True;
  SBGastos.Visible := DMConfig.EsLaFont or ( cliente_sal_sc.Text = 'WEB' );
  btnEntrega.Visible:= DMConfig.EsLaFont and ( empresa_sc.Text = 'F42' );;

  btnVerImpFac.Visible:=  DMConfig.EsLaFont;
  btnVerAbonos.Visible:=  DMConfig.EsLaFont;
  edtImporteFacturado.Visible:=  DMConfig.EsLaFont;
  lblAbonos.Visible:=  DMConfig.EsLaFont;
  dbgAbonos.Visible:=  DMConfig.EsLaFont;
  facturable_sc.Visible:=  DMConfig.EsLaFont;
  lblFactura.Visible:=  DMConfig.EsLaFont;
  n_factura_sc.Visible:=  DMConfig.EsLaFont;
  fecha_factura_sc.Visible:=  DMConfig.EsLaFont;    
  
  SBFacturable.Visible:= DMConfig.EsLaFont;
  btnValorar.Visible:= DMConfig.EsLaFont;
  btnValidar.Visible:= DMConfig.EsLaFont;

     //Borramos los nombres de la empresa, cosechero, ...
     //si el resultado de una busqueda fue vacio
     //habilitamos campos facturacion, para que tenga el mismo Color
     //que el resto
  PonPanelMaestro;
  STOperador_transporte_sc.Caption := desTransporte(empresa_sc.Text, operador_transporte_sc.Text);
  STTransporte_sc.Caption := desTransporte(empresa_sc.Text, transporte_sc.Text);
  STcliente_sal_sc.Caption := desCliente(empresa_sc.Text, cliente_sal_sc.Text);
  STcliente_fac_sc.Caption := desCliente(empresa_sc.Text, cliente_fac_sc.Text);
  STdir_sum_sc.Caption := desSuministroEx(empresa_sc.Text, cliente_sal_sc.Text, dir_sum_sc.Text);

  porte_bonny_sc.Visible:= True;
  cbx_porte_bonny_sc.Visible:= False;
  higiene_sc.Visible:= True;
  cbx_higiene_sc.Visible:= False;
  reclamacion_sc.Visible:= True;
  cbx_reclamacion_sc.Visible:= False;

  //n_factura_sc.Enabled:= False;
  n_factura_sc.TabStop:= False;
  n_factura_sc.ReadOnly:= True;
  n_factura_sc.ColorEdit:= clBtnFace;
  n_factura_sc.ColorNormal:= clBtnFace;
  n_factura_sc.ColorDisable:= clBtnFace;

  //fecha_factura_sc.Enabled:= False;
  fecha_factura_sc.TabStop:= False;
  fecha_factura_sc.ReadOnly:= True;
  fecha_factura_sc.ColorEdit:= clBtnFace;
  fecha_factura_sc.ColorNormal:= clBtnFace;
  fecha_factura_sc.ColorDisable:= clBtnFace;

  nota_factura_sc.Color:= clWhite;

  facturable_sc.Enabled:= False;

  lblHasta.Visible:= False;
  edtFechaHasta.Visible:= False;
end;

procedure TFMSalidas.VerDetalle;
var i: integer;
begin
  for i := 0 to ListaDetalle.Count - 1 do
  begin
    Objeto := ListaDetalle.Items[i];
    if (Objeto is TBDEdit) then
    begin
      with Objeto as TBDEdit do
      begin
        if Modificable = false then
          Enabled := true;
      end;
    end;
  end;
    //rejilla al tamaño maximo
  PonPanelMaestro;
    //RejillaVisualizacion.Height:=256;
end;

procedure TFMSalidas.PonFocoDetalle( const AEdit: TBEdit );
begin
  if AEdit.Visible and AEdit.Enabled then
  begin
    FocoDetalle:= AEdit;
  end
  else
  begin
    FocoDetalle:= producto_sl;
  end;
end;

procedure TFMSalidas.EditarDetalle;
var i: integer;
begin
  if estoyContabilizada then
  begin
    raise Exception.Create('No se puede modificar una salida asociada a una factura contabilizada.');
  end
  else
  if estoyFacturada then
  begin
    ShowMessage('Albarán asociado a una factura, recuerde repetirla si modifica el albarán');
  end;
  PonTextoEstaticoDetalle;

     //Guardamos valores modificables para saber si hay cambios
  if EstadoDetalle = tedModificar then
  begin
    for i := 0 to ListaDetalle.Count - 1 do
    begin
      Objeto := ListaDetalle.Items[i];
      if (Objeto is TBDEdit) then
      begin
        with Objeto as TBDEdit do
        begin
          if (Modificable = false) then
            Enabled := false;
        end;
      end;
    end;
    PonFocoDetalle( cajas_sl );
  end
  else
  begin
    if empresa_sc.Text = 'F42' then
      PonFocoDetalle( entrega_sl )
    else
      PonFocoDetalle( producto_sl );
  end;

  PonPanelDetalle;

  (*IVA*)
  Impuesto:= ImpuestosCliente(empresa_sc.Text, centro_salida_sc.Text, cliente_fac_sc.Text, dir_sum_sc.Text, StrToDateTimeDef( fecha_sc.Text, Now ) );
  //Calcular porcentaje de impuestos
  if impuesto.sCodigo = 'E' then
  begin
    LIva_sl.Caption := ' IMPUESTOS';
    LPorc_iva_sl.Caption := ' EXENTO';
  end
  else
  begin
    LIva_sl.Caption := '  ' + impuesto.sTipo;
    LPorc_iva_sl.Caption := ' %' + impuesto.sTipo;
  end;

  //foco y campos editables
  if DSDetalle.State = dsEdit then
    PonFocoDetalle( cajas_sl );


  EnvaseInicial;
end;


//...................... VALIDAR CAMPOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// Required del componente y en RequiredMsg el mensaje que quieres mostrar
//....................................................................
// La funcion generica que realiza es comprobar que los campos que tienen
// datos por obligacion los tengan, en caso de querer hacer algo mas hay
// que implenentarlo, como comprobar la existencia de un valor en la base
// de datos
//....................................................................

procedure TFMSalidas.ValidarEntradaDetalle;
var i: Integer;
begin
     //controlar que no hayan campos vacios y que se cumplan las restricciones que no
     //hemos implementado en la base de datos
  for i := 0 to ListaDetalle.Count - 1 do
  begin
    Objeto := ListaDetalle.Items[i];
    if (Objeto is TBDEdit) then
    begin
      with Objeto as TBDEdit do
      begin
        if Required and (Trim(Text) = '') then
        begin
          if Trim(RequiredMsg) <> '' then
            raise Exception.Create(RequiredMsg)
          else
            raise Exception.Create('Faltan datos de obligada inserción.');
          TBEdit(Objeto).setfocus;
        end;
      end;
    end;
  end;

  //Es correcto el envase
  with DMBaseDatos.QAux do
  begin
    Close;
    SQL.Clear;
    SQl.Add(' select * ');
    SQl.Add(' from frf_envases ');
    SQl.Add(' where empresa_e = :empresa ');
    SQl.Add(' and envase_e = :envase ');
    SQl.Add(' and producto_base_e = ');
    SQl.Add(' ( ');
    SQl.Add(' select producto_base_p ');
    SQl.Add(' from frf_productos ');
    SQl.Add(' where empresa_p = :empresa ');
    SQl.Add(' and producto_p = :producto ');
    SQl.Add(' ) ');
    ParamByName('empresa').AsString:= empresa_sc.Text;
    ParamByName('envase').AsString:= envase_sl.Text;
    ParamByName('producto').AsString:= producto_sl.Text;
    Open;
    if IsEmpty then
    begin
      Close;
      SQL.Clear;
      SQl.Add(' select * ');
      SQl.Add(' from frf_envases ');
      SQl.Add(' where empresa_e = :empresa ');
      SQl.Add(' and envase_e = :envase ');
      SQl.Add(' and producto_base_e is null ');
      ParamByName('empresa').AsString:= empresa_sc.Text;
      ParamByName('envase').AsString:= envase_sl.Text;
      Open;
      if IsEmpty then
      begin
        Close;
        raise Exception.Create('La combinación de envase y producto es incorrecta.');
      end;
    end;
    Close;
  end;

  //el envase no debe estar de baja
  if oldEnvase <> envase_sl.Text then
    with DMBaseDatos.QAux do
    begin
      Close;
      SQL.Clear;
      SQl.Add(' Select * from frf_envases ');
      SQl.Add(' where envase_e = ' + QuotedStr( envase_sl.Text ) );
      SQl.Add(' and empresa_e = ' + QuotedStr( empresa_sc.Text ) );
      SQl.Add(' and producto_base_e = ');
      SQl.Add(' ( ');
      SQl.Add('   select producto_base_p ');
      SQl.Add('   from frf_productos ');
      SQl.Add('   where empresa_p = :empresa ');
      SQl.Add('   and producto_p = :producto ');
      SQl.Add(' ) ');
      SQl.Add('   and fecha_baja_e is  null ');
      ParamByName('empresa').AsString:= empresa_sc.Text;
      ParamByName('producto').AsString:= producto_sl.Text;
      Open;
      if IsEmpty then
      begin
        Close;
        raise Exception.Create('No se pueden usar los envases que han sido dados de baja.');
      end;
      Close;
    end;

    //Precio a cero si no ponemos nada
  if Trim(precio_sl.Text) = '' then
  begin
    precio_sl.Text := '0';
    importe_neto_sl.text := '0';
    importe_total_sl.text := '0';
  end;
  if Trim(porc_iva_sl.Text) = '' then
  begin
    porc_iva_sl.Text:= '0';
    iva_sl.Text:= '0';
  end;


  //Platano verde, que exista la entrega y el año/semana
  if ( empresa_sc.Text = 'F42' ) and ( producto_sl.Text = 'P' ) then
  begin
    if anyo_semana_entrega_sl.Text = '' then
    begin
      PonFocoDetalle( entrega_sl );
      if MessageDlg('Falta o es incorrecta la entrega de la que proviene la fruta.' + #13 + #10 +
               '¿Seguro que desea continuar?', mtWarning, [mbNo, mbYes], 0) = mrNo then
        Abort;
    end;
  end;

  //Unidades variables distintas de cero
  if unidades_caja_sl.Enabled and ( StrToIntDef( unidades_caja_sl.Text, 0 ) = 0 ) then
  begin
    //Unidades variables, informar si la cantidad de cajas = 0
    if MessageDlg('El envase seleccionado es de unidades variable y la unidades por cajas son 0, ¿es correcto?.',
                  mtWarning,[mbYes, mbNo],0 ) = mrNO then
    begin
      if unidades_caja_sl.CanFocus then
        unidades_caja_sl.SetFocus;
      Abort;
    end;
  end;

  //Comercial
  if txtDesComercial.Caption = '' then
  begin
    raise Exception.Create('Falta el comercial asignado a la venta.');
  end;

  if STProducto_sl.Caption =  '' then
  begin
    raise Exception.Create('Falta el producto o es incorrecto.');
  end;
  if STEnvase_sl.Caption =  '' then
  begin
    raise Exception.Create('Falta el envase o es incorrecto.');
  end;
  if STMarca_sl.Caption =  '' then
  begin
    raise Exception.Create('Falta la marca o es incorrecta.');
  end;
  if STcolor_sl.Caption =  '' then
  begin
    raise Exception.Create('Falta el color o es incorrecto.');
  end;
  if STCategoria_sl.Caption =  '' then
  begin
    raise Exception.Create('Falta la categoria o es incorrecta.');
  end;
  if ( tipo_palets_sl.Text <> '')  and ( stTipoPalets.Caption =  '' ) then
  begin
    raise Exception.Create('El tipo de palet es incorrecto.');
  end;
  if ( StrToIntDef( n_palets_sl.Text, 0 ) <> 0 ) and  ( stTipoPalets.Caption =  '' ) then
  begin
    raise Exception.Create('Falta el tipo de palet o es incorrecto.');
  end;
  if not ExisteCalibre( empresa_sc.Text, producto_sl.Text, categoria_sl.Text) then
  begin
    raise Exception.Create('El calibre es incorrecto.');
  end;


  //Completamos la clave primaria
  RellenaClaveDetalle;

end;

procedure TFMSalidas.RellenaClaveDetalle;
begin
         //Sólo durante la insrcion de una nueva linea
  if (EstadoDetalle = tedAltaRegresoMaestro) or (EstadoDetalle = tedAlta) then
  begin

         //empresa
    if Trim(empresa_sc.Text) = '' then
      raise Exception.Create('Faltan datos de la cabecera.');
    TSalidasL.FieldByName('empresa_sl').AsString :=
      empresa_sc.Text;
          //centro
    if Trim(centro_salida_sc.Text) = '' then
      raise Exception.Create('Faltan datos de la cabecera.');
    TSalidasL.FieldByName('centro_salida_sl').AsString :=
      centro_salida_sc.Text;
          //numero de albaran
    if Trim(n_albaran_sc.Text) = '' then
      raise Exception.Create('Faltan datos de la cabecera.');
    TSalidasL.FieldByName('n_albaran_sl').AsString :=
      n_albaran_sc.Text;
          //fecha
    if Trim(fecha_sc.Text) = '' then
      raise Exception.Create('Faltan datos de la cabecera.');
    TSalidasL.FieldByName('fecha_sl').AsDateTime :=
      StrToDate(fecha_sc.Text);

    //centro origen
    TSalidasL.FieldByName('centro_origen_sl').AsString := centro_salida_sc.Text;

          //campo oculto y redundante, perdemos en tamaño pero
          //se cree que aumentara la velocidad
    TSalidasL.FieldByName('cliente_sl').AsString := Trim(cliente_sal_sc.Text);
    TSalidasL.FieldByName('federacion_sl').AsString := '';
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

//Realiza la consulta

function TFMSalidas.Consulta(value: Integer; printError: Boolean): Boolean;
begin
  Consulta := True;
  if (DMBaseDatos.QDespegables.Tag <> value) then
  begin
          //Consultas diferentes
    DMBaseDatos.QDespegables.Tag := value;
          //Cerramo la consulta
    DMBaseDatos.QDespegables.Cancel;
    DMBaseDatos.QDespegables.Close;
  end;

  if DMBaseDatos.QDespegables.Active then
  begin
        //Si la tabla esta abierta salimos
    Exit;
  end
  else
        //Sino construimos la consulta
    case value of
      kEmpresa:
        begin
          RejillaFlotante.ColumnResult := 0;
          RejillaFlotante.ColumnFind := 1;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT empresa_e, nombre_e ' +
            ' FROM frf_empresas ' +
            ' ORDER BY nombre_e ');
        end;
      kCentro:
        begin
                //Depende de empresa
          RejillaFlotante.ColumnResult := 1;
          RejillaFlotante.ColumnFind := 2;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(ConsultaCentro);
        end;
      kProducto:
        begin
                //Depende de empresa
          RejillaFlotante.ColumnResult := 1;
          RejillaFlotante.ColumnFind := 2;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(ConsultaProducto);
        end;
      kCliente:
        begin
          RejillaFlotante.ColumnResult := 1;
          RejillaFlotante.ColumnFind := 2;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(ConsultaCliente);
        end;
      kTransportista:
        begin
          RejillaFlotante.ColumnResult := 1;
          RejillaFlotante.ColumnFind := 2;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(ConsultaTransportista);
        end;
      kSuministro:
        begin
          RejillaFlotante.ColumnResult := 2;
          RejillaFlotante.ColumnFind := 3;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(ConsultaSuministro);
        end;
      kMoneda:
        begin
          RejillaFlotante.ColumnResult := 0;
          RejillaFlotante.ColumnFind := 1;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT moneda_m, descripcion_m ' +
            ' FROM frf_monedas ' +
            ' ORDER BY descripcion_m ');
        end;
      kEnvase:
        begin
          RejillaFlotante.ColumnResult := 0;
          RejillaFlotante.ColumnFind := 1;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT envase_e, descripcion_e ' +
            ' FROM frf_envases Frf_envases ' +
            ' ORDER BY descripcion_e ');
        end;
      kMarca:
        begin
          RejillaFlotante.ColumnResult := 0;
          RejillaFlotante.ColumnFind := 1;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(' SELECT DISTINCT codigo_m, descripcion_m ' +
            ' FROM frf_marcas Frf_marcas ' +
            ' ORDER BY descripcion_m ');
        end;
      kCalibre:
        begin
          RejillaFlotante.ColumnResult := 2;
          RejillaFlotante.ColumnFind := 2;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(ConsultaCalibre);
        end;
      kCategoria:
        begin
          RejillaFlotante.ColumnResult := 2;
          RejillaFlotante.ColumnFind := 3;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(ConsultaCategoria);
        end;
      kColor:
        begin
          RejillaFlotante.ColumnResult := 2;
          RejillaFlotante.ColumnFind := 3;
          DMBaseDatos.QDespegables.Sql.Clear;
          DMBaseDatos.QDespegables.Sql.Add(ConsultaColor);
        end;
      kTipoPalet:
        begin
          RejillaFlotante.ColumnResult := 0;
          RejillaFlotante.ColumnFind := 1;
          DMBaseDatos.QDespegables.SQL.Clear;
          DMBaseDatos.QDespegables.SQL.Add(' SELECT codigo_tp, descripcion_tp' +
            ' FROM frf_tipo_palets ' +
            ' ORDER BY codigo_tp');
        end;
    end;

     //Abre consulta
  try
    DMBaseDatos.QDespegables.Open;
  except
    ShowError('Error al abrir la consulta.');
  end;
     //Tiene valores
  if DMBaseDatos.QDespegables.IsEmpty then
  begin
    if printError then ShowError('No se han encontrado datos.');
    Consulta := False;
  end;
end;

procedure TFMSalidas.PonNombre(Sender: TObject);
begin
  gRF := RejillaFlotante;
  gCF := CalendarioFlotante;

  if esVisible( gRF ) or esVisible( gCF ) then Exit;

  if DSDetalle.State = dsInsert then
  begin
    case TComponent(Sender).Tag of
      kProducto: STProducto_sl.Caption := desProducto(empresa_sc.Text, producto_sl.Text);
      kMarca: STMarca_sl.Caption := desMarca(marca_sl.Text);
      kCategoria: STcategoria_sl.Caption := desCategoria(empresa_sc.Text, producto_sl.Text, categoria_sl.Text);
      kColor: STcolor_sl.Caption := desColor(empresa_sc.Text, producto_sl.Text, color_sl.Text);
    end;
  end
  else
  begin
    if Estado = teConjuntoResultado then
    begin
      STEmpresa_sc.Caption := desEmpresa(empresa_sc.Text);
      STCentro_salida_sc.Caption := desCentro(empresa_sc.Text, centro_salida_sc.Text);
      STOperador_transporte_sc.Caption := desTransporte(empresa_sc.Text, operador_transporte_sc.Text);
      STTransporte_sc.Caption := desTransporte(empresa_sc.Text, transporte_sc.Text);
      STcliente_sal_sc.Caption := desCliente(empresa_sc.Text, cliente_sal_sc.Text);
      STcliente_fac_sc.Caption := desCliente(empresa_sc.Text, cliente_fac_sc.Text);
      STMoneda_sc.Caption := desMoneda(moneda_sc.Text);

      SBGastos.Visible := DMConfig.EsLaFont or ( cliente_sal_sc.Text = 'WEB' );
      btnEntrega.Visible:= DMConfig.EsLaFont and ( empresa_sc.Text = 'F42' );;

      btnVerImpFac.Visible:=  DMConfig.EsLaFont;
      btnVerAbonos.Visible:=  DMConfig.EsLaFont;
      edtImporteFacturado.Visible:=  DMConfig.EsLaFont;
      lblAbonos.Visible:=  DMConfig.EsLaFont;
      dbgAbonos.Visible:=  DMConfig.EsLaFont;
      facturable_sc.Visible:=  DMConfig.EsLaFont;
      lblFactura.Visible:=  DMConfig.EsLaFont;
      n_factura_sc.Visible:=  DMConfig.EsLaFont;
      fecha_factura_sc.Visible:=  DMConfig.EsLaFont;
    end
    else
    begin
      case TComponent(Sender).Tag of
       kEmpresa:
          begin
            STEmpresa_sc.Caption := desEmpresa(empresa_sc.Text);
            STCentro_salida_sc.Caption := desCentro(empresa_sc.Text, centro_salida_sc.Text);
            STOperador_transporte_sc.Caption := desTransporte(empresa_sc.Text, operador_transporte_sc.Text);
            STTransporte_sc.Caption := desTransporte(empresa_sc.Text, transporte_sc.Text);
            STcliente_sal_sc.Caption := desCliente(empresa_sc.Text, cliente_sal_sc.Text);
            STcliente_fac_sc.Caption := desCliente(empresa_sc.Text, cliente_fac_sc.Text);
          end;
        kCentro:
          begin
            if Estado <> teOperacionDetalle then
            begin
              STCentro_salida_sc.Caption := desCentro(empresa_sc.Text, centro_salida_sc.Text)
            end;
          end;
        kTransportista:
          begin
           STOperador_transporte_sc.Caption := desTransporte(empresa_sc.Text, operador_transporte_sc.Text);
           STTransporte_sc.Caption := desTransporte(empresa_sc.Text, transporte_sc.Text);
          end;
        kcliente:
          begin
            if cliente_sal_sc.Focused then
            begin
              STcliente_sal_sc.Caption := desCliente(empresa_sc.Text, cliente_sal_sc.Text);
              if ( Estado = teAlta ) and ( STcliente_sal_sc.Caption <> '' ) then
              begin
                porte_bonny_sc.Checked:= PorteCliente( empresa_sc.Text, cliente_sal_sc.Text ) = 0;
                if porte_bonny_sc.Checked then
                  QSalidasC.FieldByName('porte_bonny_sc').AsInteger:= 1
                else
                  QSalidasC.FieldByName('porte_bonny_sc').AsInteger:= 0;
              end;
            end
            else
            begin
              STcliente_fac_sc.Caption := desCliente(empresa_sc.Text, cliente_fac_sc.Text);
              RellenaMoneda( cliente_fac_sc );
            end;
          end;
        kMoneda: STMoneda_sc.Caption := desMoneda(moneda_sc.Text);
        kProducto: STProducto_sl.Caption := desProducto(empresa_sc.Text, producto_sl.Text);
       end;
    end;
  end;
end;


procedure TFMSalidas.RequiredTime(Sender: TObject;
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

function TFMSalidas.ConsultaCentro: string;
begin
  if Trim(empresa_sc.Text) <> '' then
    ConsultaCentro := ' SELECT DISTINCT empresa_c, centro_c, descripcion_c ' +
      ' FROM frf_centros  ' +
      ' WHERE empresa_c= ' + QuotedStr(empresa_sc.Text) + ' ' +
      ' ORDER BY descripcion_c'
  else
    ConsultaCentro := ' SELECT DISTINCT empresa_c, centro_c, descripcion_c ' +
      ' FROM frf_centros  ' +
      ' ORDER BY descripcion_c';
end;

function TFMSalidas.ConsultaProducto: string;
begin
  if Trim(empresa_sc.Text) <> '' then
    ConsultaProducto := ' SELECT DISTINCT empresa_p, producto_p, descripcion_p ' +
      ' FROM frf_productos Frf_productos ' +
      ' WHERE empresa_p= ' + QuotedStr(empresa_sc.Text) + ' ' +
      ' ORDER BY descripcion_p '
  else
    ConsultaProducto := ' SELECT DISTINCT empresa_p, producto_p, descripcion_p ' +
      ' FROM frf_productos Frf_productos ' +
      ' ORDER BY descripcion_p ';
end;

function TFMSalidas.ConsultaCliente: string;
begin
  if Trim(empresa_sc.Text) <> '' then

  else
    ConsultaCliente := ' SELECT DISTINCT empresa_c, cliente_c, nombre_c ' +
      ' FROM frf_clientes ' +
      ' ORDER BY nombre_c ';
end;

function TFMSalidas.ConsultaSuministro: string;
var flag: boolean;
  aux: string;
begin
  Aux := ' SELECT DISTINCT empresa_ds,cliente_ds,dir_sum_ds, nombre_ds ' +
    ' FROM frf_dir_sum ';
  flag := false;

  if (Trim(empresa_sc.Text) <> '') then
  begin
    Aux := Aux + ' WHERE   (empresa_ds = ' + QuotedStr(empresa_sc.Text) + ') ';
    flag := true;
  end;

  if (Trim(cliente_sal_sc.Text) <> '') then
  begin
    if flag then Aux := Aux + ' AND   (cliente_ds = ' + QuotedStr(cliente_sal_sc.Text) + ') '
    else Aux := Aux + ' WHERE   (cliente_ds = ' + QuotedStr(cliente_sal_sc.Text) + ') ';
  end;

  ConsultaSuministro := Aux +
    ' ORDER BY nombre_ds ';
end;


function TFMSalidas.ConsultaTransportista: string;
begin
  if Trim(empresa_sc.Text) <> '' then
    ConsultaTransportista := ' SELECT empresa_t, transporte_t, descripcion_t ' +
      ' FROM frf_transportistas ' +
      ' WHERE empresa_t= ' + QuotedStr(empresa_sc.Text) + ' ' +
      ' ORDER BY descripcion_t '
  else
    ConsultaTransportista := ' SELECT empresa_t, transporte_t, descripcion_t ' +
      ' FROM frf_transportistas ' +
      ' ORDER BY descripcion_t ';
end;

function TFMSalidas.ConsultaCalibre: string;
var flag: boolean;
  aux: string;
begin
  Aux := ' SELECT DISTINCT empresa_c, producto_c, calibre_c ' +
    ' FROM frf_calibres ';
  flag := false;

  if (Trim(empresa_sc.Text) <> '') then
  begin
    Aux := Aux + ' WHERE   (empresa_c = ' + empresa_sc.Text + ') ';
    flag := true;
  end;

  if (Trim(producto_sl.Text) <> '') then
  begin
    if flag then Aux := Aux + ' AND  (producto_c = ' + QuotedStr(producto_sl.Text) + ') '
    else Aux := Aux + ' WHERE  (producto_c = ' + QuotedStr(producto_sl.Text) + ') ';
  end;

  ConsultaCalibre := Aux +
    ' ORDER BY calibre_c ';
end;

function TFMSalidas.ConsultaCategoria: string;
var flag: boolean;
  aux: string;
begin
  Aux := ' SELECT DISTINCT empresa_c, producto_c, categoria_c, descripcion_c ' +
    ' FROM frf_categorias ';
  flag := false;

  if (Trim(empresa_sc.Text) <> '') then
  begin
    Aux := Aux + ' WHERE   (empresa_c = ' + empresa_sc.Text + ') ';
    flag := true;
  end;

  if (Trim(producto_sl.Text) <> '') then
  begin
    if flag then Aux := Aux + ' AND  (producto_c = ' + QuotedStr(producto_sl.Text) + ') '
    else Aux := Aux + ' WHERE  (producto_c = ' + QuotedStr(producto_sl.Text) + ') ';
  end;

  ConsultaCategoria := Aux +
    ' ORDER BY descripcion_c ';
end;

function TFMSalidas.ConsultaColor: string;
var flag: boolean;
  aux: string;
begin
  Aux := ' SELECT DISTINCT empresa_c, producto_c, color_c, descripcion_c ' +
    ' FROM frf_colores ';
  flag := false;

  if (Trim(empresa_sc.Text) <> '') then
  begin
    Aux := Aux + ' WHERE   (empresa_c = ' + empresa_sc.Text + ') ';
    flag := true;
  end;

  if (Trim(producto_sl.Text) <> '') then
  begin
    if flag then Aux := Aux + ' AND  (producto_c = ' + quotedstr(producto_sl.Text) + ') '
    else Aux := Aux + ' WHERE  (producto_c = ' + quotedstr(producto_sl.Text) + ') ';
  end;

  ConsultaColor := Aux +
    ' ORDER BY descripcion_c ';
end;


procedure TFMSalidas.SalirEdit(Sender: TObject);
begin
  BEMensajes('');
end;

procedure TFMSalidas.EntrarEdit(Sender: TObject);
begin
  BEMensajes(TEdit(Sender).Hint);
end;


function TFMSalidas.GetNumeroDeAlbaran( const empresa, centro: string; const AIncrementa: boolean;
                      const albaran: Integer = -1): Integer;
begin
  if albaran <> -1 then begin
    if albaran <> albaranObtenido then begin
      result := albaran;
      Exit;
    end;
  end;

  //Sacamos contador
  with DMBaseDatos.QGeneral do
  begin
    Close;
    SQl.Clear;
    SQL.Add(' SELECT cont_albaranes_c FROM frf_centros ' +
      ' WHERE empresa_c=' + quotedstr(empresa_sc.Text) +
      ' AND centro_c=' + quotedstr(centro_salida_sc.Text));
    try
      Open;
    except
      ShowError('Error al intentar conseguir el contador de albaranes.');
      Abort;
    end;

    if IsEmpty then
    begin
      ShowError('Error al intentar conseguir el contador de albaranes.');
      Abort;
    end;
    result := Fields[0].AsInteger;

    Close;
    if AIncrementa then
    begin
      SQL.Clear;
      SQL.Add(' UPDATE frf_centros ' +
        ' SET cont_albaranes_c =' + IntToStr(result + 1) +
        ' WHERE empresa_c=' + quotedstr(empresa_sc.Text) +
        ' AND centro_c=' + quotedstr(centro_salida_sc.Text));
      try
        ExecSQL;
      except
        ShowError('Error al intentar actualizar el contador de albaranes.');
        Abort;
      end;
    end;
  end;
end;

procedure TFMSalidas.PonNumeroAlbaran(Sender: TObject);
begin
  if (Trim(empresa_sc.Text) <> '') and
    (Trim(centro_salida_sc.Text) <> '') and
    (Estado = teAlta) and
    (DSMaestro.State <> dsBrowse) then
  begin
    n_albaran_sc.Text := IntToStr(GetNumeroDeAlbaran(empresa_sc.Text, centro_salida_sc.Text, False ));
    albaranObtenido := bnStrToInt(n_albaran_sc.Text);
  end;
end;

procedure TFMSalidas.RellenaClienteFacturacion(Sender: TObject);
begin
     //Rellenamos cliente de facturacion
  if (Trim(cliente_sal_sc.Text) <> '') and
    (DSMaestro.State <> dsBrowse) and
    (Estado <> teLocalizar) then
  begin
       (* Se pelearon los colegillas
       if (cliente_sal_sc.Text='TS') or
          (cliente_sal_sc.Text='JS') or
          (cliente_sal_sc.Text='HS') or
          (cliente_sal_sc.Text='MR') then
          cliente_fac_sc.Text:='UK'
       else
       *)
    cliente_fac_sc.Text := cliente_sal_sc.Text;
  end;
end;

procedure TFMSalidas.RellenaMoneda(Sender: TObject);
begin
     //Rellenamos cliente de facturacion
  if (Length( Trim(cliente_fac_sc.Text) ) > 1) and
    (Length( Trim(empresa_sc.Text) ) = 3 ) and
    //(Trim(moneda_sc.Text) = '') and
    (estado <> teLocalizar) and
    (DSMaestro.State <> dsBrowse) then
  begin
    with DMBaseDatos.QGeneral do
    begin
      if Active then
      begin
        Cancel;
        Close;
      end;
      SQL.Clear;
      SQL.Add(' SELECT moneda_c FROM frf_clientes ' +
        ' WHERE empresa_c=' + quotedstr(empresa_sc.Text) +
        ' and cliente_c=' + quotedstr(cliente_fac_sc.Text));
      try
        Open;
      except
        Exit;
      end;

      if not IsEmpty then
      begin
        moneda_sc.Text := Fields[0].AsString;
      end;
    end;
  end;
end;

procedure TFMSalidas.PonPanelDetalle;
begin
    //Valores de la cabecera
  STAlbaran.Caption := n_albaran_sc.Text;
  STFecha.Caption := fecha_sc.Text;
  STEmpresa.Caption := STempresa_sc.Caption;
  STCentro.Caption := STcentro_salida_sc.Caption;
  STCliente.Caption := STcliente_sal_sc.Caption;
  STSuministro.Caption := STdir_sum_sc.Caption;

  //El numero de entrega solo se pide en el caso de ventas directas de fruta comprada/recibida
  //sin procesar
  entrega_sl.Enabled:= empresa_sc.Text = 'F42';
  anyo_semana_entrega_sl.Enabled:= False;

    //Mostrar panel cabecera
  PMaestro.Visible := false;
  PCabecera.Visible := true;
  PCabecera.Top := 0;
  PDetalle.Visible := True;
  PDetalle.Height := 183;


    //Titulo
  Self.Caption := 'SALIDAS DE FRUTA/LINEAS';

  //Ocultar boton
  sbGastos.Visible := false;
  btnEntrega.Visible:= False;
  SBFacturable.Visible:= False;
  btnValorar.Visible:= False;
  btnValidar.Visible:= False;

  btnVerImpFac.Visible:=  False;
  btnVerAbonos.Visible:=  False;
  edtImporteFacturado.Visible:=  False;
  lblAbonos.Visible:=  False;
  dbgAbonos.Visible:=  False;
  facturable_sc.Visible:=  False;
  lblFactura.Visible:=  False;
  n_factura_sc.Visible:=  False;
  fecha_factura_sc.Visible:=  False;
end;

procedure TFMSalidas.PonPanelMaestro;
begin
    //Mostrar panel maestro
  PMaestro.Visible := true;
  PCabecera.Visible := false;
  PDetalle.Visible := false;

    //Titulo
  Self.Caption := 'SALIDAS DE FRUTA/CABECERA';

  //Ver boton
  SBGastos.Visible := DMConfig.EsLaFont or ( cliente_sal_sc.Text = 'WEB' );
  btnEntrega.Visible:= DMConfig.EsLaFont and ( empresa_sc.Text = 'F42' );;
  SBFacturable.Visible:= DMConfig.EsLaFont;
  btnValorar.Visible:= DMConfig.EsLaFont;
  btnValidar.Visible:= DMConfig.EsLaFont;

  btnVerImpFac.Visible:=  DMConfig.EsLaFont;
  btnVerAbonos.Visible:=  DMConfig.EsLaFont;
  edtImporteFacturado.Visible:=  DMConfig.EsLaFont;
  lblAbonos.Visible:=  DMConfig.EsLaFont;
  dbgAbonos.Visible:=  DMConfig.EsLaFont;
  facturable_sc.Visible:=  DMConfig.EsLaFont;
  lblFactura.Visible:=  DMConfig.EsLaFont;
  n_factura_sc.Visible:=  DMConfig.EsLaFont;
  fecha_factura_sc.Visible:=  DMConfig.EsLaFont;  

end;




procedure TFMSalidas.CalculaImporte(Sender: TObject);
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;

  if bFlagCambios and  precio_sl.Focused then
    RecalcularUnidades( Sender );
end;

procedure TFMSalidas.IncSalidaCliente(empresa, cliente: string);
var
  aux: integer;
begin
  with DMAuxDB.QDescripciones do
  begin
    SQL.Text := ' select expediciones_c from frf_clientes ' +
      ' where empresa_c=' + QuotedStr(empresa) + ' ' +
      ' and cliente_c=' + QuotedStr(cliente);
    try
      try
        Open;
        if IsEmpty then aux := 0
        else aux := Fields[0].AsInteger;
      except
        Exit;
      end;
    finally
      Cancel;
      Close;
    end;

    SQL.Text := ' update frf_clientes set expediciones_c = ' + IntToStr(aux + 1) +
      ' where empresa_c=' + QuotedStr(empresa) + ' ' +
      ' and cliente_c=' + QuotedStr(cliente);
    ExecSQL; ;
  end;
end;

function TFMSalidas.ExisteDirSuministro: Boolean;
begin
  with DMAuxDB.QDescripciones do
  begin
    SQL.Text := ' select count(*) from frf_dir_sum ' +
      ' where empresa_ds=' + QuotedStr(empresa_sc.Text) +
      ' and cliente_ds=' + QuotedStr(cliente_sal_sc.Text) +
      ' and dir_sum_ds=' + QuotedStr(dir_sum_sc.Text);
    try
      try
        Open;
        ExisteDirSuministro := Fields[0].AsInteger <> 0;
      except
        ExisteDirSuministro := False;
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

procedure TFMSalidas.AntesDeBorrarDetalle;
begin
  if estoyContabilizada then
  begin
    raise Exception.Create('No se puede modificar una salida asociada a una factura contabilizada.');
  end
  else
  if estoyFacturada then
  begin
    ShowMessage('Albarán asociado a una factura, recuerde repetirla si modifica el albarán');
  end;
end;

function TFMSalidas.TieneDetalle: boolean;
begin
  Result:= False;

  if not DMConfig.EsLaFont then
    Exit;

  //Tiene entradas asigndas
  (*
  if not Result then
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select Trim( empresa_es || '' - '' || centro_salida_es  || '' - ('' || fecha_entrada_es  || '') - '' || n_entrada_es ) entrada ' );
    SQL.Add(' from frf_entradas_sal ');
    SQL.Add(' where empresa_es = :empresa ');
    SQL.Add(' and centro_salida_es = :centro ');
    SQL.Add(' and fecha_salida_es = :fecha ');
    SQL.Add(' and n_salida_es = :albaran');
    SQL.Add(' and transito_es = 0 ');
    ParamByName('empresa').AsString:= QSalidasC.fieldByName('empresa_sc').AsString;
    ParamByName('centro').AsString:= QSalidasC.fieldByName('centro_salida_sc').AsString;
    ParamByName('albaran').AsInteger:= QSalidasC.fieldByName('n_albaran_sc').AsInteger;
    ParamByName('fecha').AsDateTime:= QSalidasC.fieldByName('fecha_sc').AsDateTime;
    Open;
    if not IsEmpty then
    begin
      ShowError('No se puede borrar una salida con entradas asignadas -> ' + fieldByName('entrada').AsString );
      Result:= True;
    end;
    Close;
  end;
  *)

  //Tiene ABONOS
  if not Result then
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_fal, fecha_fal, factura_fal ');
    SQL.Add(' from frf_fac_abonos_l ');
    SQL.Add(' where empresa_fal = :empresa ');
    SQL.Add(' and n_albaran_fal = :centro ');
    SQL.Add(' and fecha_albaran_fal = :albaran ');
    SQL.Add(' and centro_Salida_fal = :fecha ');
    SQL.Add(' group by empresa_fal, fecha_fal, factura_fal ');
    SQL.Add(' order by empresa_fal, fecha_fal, factura_fal ');
    ParamByName('empresa').AsString:= QSalidasC.fieldByName('empresa_sc').AsString;
    ParamByName('centro').AsString:= QSalidasC.fieldByName('centro_salida_sc').AsString;
    ParamByName('albaran').AsInteger:= QSalidasC.fieldByName('n_albaran_sc').AsInteger;
    ParamByName('fecha').AsDateTime:= QSalidasC.fieldByName('fecha_sc').AsDateTime;
    Open;
    if not IsEmpty then
    begin
      ShowError('No se puede borrar una salida asociada con un abono -> ' + fieldByName('empresa_fal').AsString + '-' +
                                                                            fieldByName('fecha_fal').AsString + '-' +
                                                                            fieldByName('factura_fal').AsString  );
      Result:= True;
    end;
    Close;
  end;


  //Tiene deposito aduanas
  (*
  if not Result then
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_das  ');
    SQL.Add(' from frf_depositos_aduana_sal  ');
    SQL.Add(' where empresa_das = :empresa  ');
    SQL.Add(' and n_albaran_das = :albaran  ');
    SQL.Add(' and fecha_das = :fecha  ');
    SQL.Add(' and centro_Salida_das = :centro  ');
    ParamByName('empresa').AsString:= QSalidasC.fieldByName('empresa_sc').AsString;
    ParamByName('centro').AsString:= QSalidasC.fieldByName('centro_salida_sc').AsString;
    ParamByName('albaran').AsInteger:= QSalidasC.fieldByName('n_albaran_sc').AsInteger;
    ParamByName('fecha').AsDateTime:= QSalidasC.fieldByName('fecha_sc').AsDateTime;
    Open;
    if not IsEmpty then
    begin
      ShowError('No se puede borrar una salida asociada a un deposito de aduanas -> ' + fieldByName('codigo_das').AsString  );
      Result:= True;
    end;
    Close;
  end;
  *)
  //Tiene un servicio de transporte
  (*
  if not Result then
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ssv, servicio_ssv  ');
    SQL.Add(' from frf_salidas_servicios_venta  ');
    SQL.Add(' where empresa_ssv = :empresa  ');
    SQL.Add(' and n_albaran_ssv = :centro  ');
    SQL.Add(' and fecha_ssv = :albaran  ');
    SQL.Add(' and centro_Salida_ssv = :fecha  ');
    ParamByName('empresa').AsString:= QSalidasC.fieldByName('empresa_sc').AsString;
    ParamByName('centro').AsString:= QSalidasC.fieldByName('centro_salida_sc').AsString;
    ParamByName('albaran').AsInteger:= QSalidasC.fieldByName('n_albaran_sc').AsInteger;
    ParamByName('fecha').AsDateTime:= QSalidasC.fieldByName('fecha_sc').AsDateTime;
    Open;
    if not IsEmpty then
    begin
      ShowError('No se puede borrar una salida asociada a un servicio de transportista -> ' + fieldByName('empresa_ssv').AsString + '-' +
                                                                            fieldByName('servicio_ssv').AsString   );
      Result:= True;
    end;
    Close;
  end;
  *)
end;

procedure TFMSalidas.Borrar;
var botonPulsado: Word;
begin
  if estoyFacturada then
  begin
    raise Exception.Create('No se puede borrar una salida que tiene una factura asociada.');
  end;

  if not TieneDetalle then
  begin
   
     //Barra estado
    Estado := teBorrar;
    EstadoDetalle := tedOperacionMaestro;
    BEEstado;
    BHEstado;

       //preguntar si realmente queremos borrar
    botonPulsado := mrNo;
    //if application.MessageBox('Esta usted seguro de querer borrar la cabecera con todas sus lineas?',
    //  '  ATENCIÓN !', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then
    if VerAdvertencia( Self, #13 + #10 + ' ¿Esta usted seguro de querer borrar el albarán de venta completo con su detalle asociado?', '    BORRAR SALIDA',
                     'Quiero borrar el albarán completo', 'Borrar Albarán'  ) = mrIgnore then    
      botonPulsado := mrYes;

    if botonPulsado = mrYes then
      BorrarSalida;

     //Por ultimo visualizamos resultado
    Visualizar;
  end;
end;

procedure TFMSalidas.BorrarSalida;
begin
     //Abrir trnsaccion
  try
    AbrirTransaccion(DMBaseDatos.DBBaseDatos);
  except
    ShowError('En este momento no se puede llevar a cabo la operación seleccionada.' + #10 + #13 + 'Por favor vuelva a intentarlo mas tarde.');
    Exit;
  end;

  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    if DMConfig.EsLaFont then
    begin
      SQL.Clear;
      SQL.Add('DELETE FROM frf_gastos ');
      SQL.Add('WHERE empresa_g=' + quotedstr(empresa_sc.Text) +
        '  and centro_salida_g=' + quotedstr(centro_salida_sc.Text) +
        '  and n_albaran_g=' + n_albaran_sc.Text +
        '  and fecha_g=:fecha ');
      ParamByName('fecha').asdatetime := StrToDate(fecha_sc.Text);
      try
        EjecutarConsulta(DMBaseDatos.QGeneral);
      except
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        Exit;
      end;
    end;

    SQL.Clear;
    SQL.Add('DELETE FROM frf_salidas_l ');
    SQL.Add('WHERE empresa_sl=' + quotedstr(empresa_sc.Text) +
      '  and centro_salida_sl=' + quotedstr(centro_salida_sc.Text) +
      '  and n_albaran_sl=' + n_albaran_sc.Text +
      '  and fecha_sl=:fecha ');
    ParamByName('fecha').asdatetime := StrToDate(fecha_sc.Text);
    try
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      Exit;
    end;

  end;

    //Borramos maestro
  try
    QSalidasC.Delete;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      Exit;
    end;
  end;

  AceptarTransaccion(DMBaseDatos.DBBaseDatos);
  if Registro = Registros then Registro := Registro - 1;
  Registros := Registros - 1;


end;

procedure TFMSalidas.cajas_slChange(Sender: TObject);
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;

  if bFlagCambios and  ( cajas_sl.Focused or unidades_caja_sl.Focused )then
    RecalcularUnidades( Sender );
end;

function TFMSalidas.NumeroCopias: Integer;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('SELECT Frf_clientes.n_copias_alb_c ');
    SQL.Add('FROM frf_clientes Frf_clientes ');
    SQL.Add('WHERE  Frf_clientes.empresa_c=' + quotedstr(empresa_sc.Text));
    SQL.Add('AND  Frf_clientes.cliente_c=' + quotedstr(cliente_sal_sc.Text));
    try
      AbrirConsulta(DMBaseDatos.QGeneral);
    except
             //
    end;
    NumeroCopias := Fields[0].AsInteger;
  end;
end;

procedure TFMSalidas.Rejilla(boton: TBGridButton);
begin
  if (DMBaseDatos.QDespegables.Tag <> boton.Control.Tag) then
  begin
          //Consultas diferentes
    DMBaseDatos.QDespegables.Tag := boton.Control.Tag;
          //Cerramo la consulta
    DMBaseDatos.QDespegables.Cancel;
    DMBaseDatos.QDespegables.Close;
  end;

  if DMBaseDatos.QDespegables.Active then
  begin
        //Si la tabla esta abierta miramos a ver si estaba sin datos
    if not DMBaseDatos.QDespegables.IsEmpty then
      Exit;
    Exit;
  end;

  with DMBaseDatos.QDespegables do
  begin
    Cancel;
    Close;
    case ActiveControl.Tag of
      kCentro:
        begin
          SQL.Clear;
          SQL.Add('SELECT centro_c,descripcion_c FROM frf_centros');
          SQL.Add(' WHERE empresa_c = ' + quotedstr(empresa_sc.Text));
        end;
      kProducto:
        begin
          SQL.Clear;
          SQL.Add('SELECT producto_p,descripcion_p FROM frf_productos');
          SQL.Add(' WHERE empresa_p =' + quotedstr(empresa_sc.Text));
        end;
    end;

    try
      Open;
    except
      ShowError('Error al realizar la consulta asociada.');
      Exit;
    end;

       //Tiene valores
    if IsEmpty then
    begin
      ShowError('Consulta sin datos.');
      Exit;
    end;

       //Mostrar resultado
    TBGrid(boton.Grid).BControl := TBEdit(boton.Control);
    TBGrid(boton.Grid).ColumnResult := 0;
    TBGrid(boton.Grid).ColumnFind := 1;
    boton.GridShow;

  end;
end;


procedure TFMSalidas.ComprobrarClavePrimaria;
var anyo, mes, dia: word;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' SELECT count(*) FROM frf_salidas_c ');
    SQL.Add(' WHERE empresa_sc=' + quotedstr(empresa_sc.Text) + ' ');
    SQL.Add(' AND centro_salida_sc=' + quotedstr(centro_salida_sc.Text) + ' ');
    SQL.Add(' AND n_albaran_sc=' + n_albaran_sc.Text + ' ');
    decodedate(strtodate(fecha_sc.Text), anyo, mes, dia);
    SQL.Add(' AND YEAR(fecha_sc)=' + IntToStr(anyo));

    try
      Open;
    except
      n_albaran_sc.SetFocus;
      raise;
    end;

    if Fields[0].AsInteger > 0 then begin
      n_albaran_sc.SetFocus;
      raise Exception.Create('Número de albarán ya utilizado.');
    end;

    Cancel;
    Close;
  end;
end;

procedure TFMSalidas.CambiarRegistro;
begin
  STdir_sum_sc.Caption := desSuministroEx(empresa_sc.Text, cliente_sal_sc.Text, dir_sum_sc.Text);

  //Calculamos total gastos, para  saber si la salida tiene gastos
  //asignados sin tener que pulsar el boton (sólo central)
  if DMConfig.EsLaFont  or ( cliente_sal_sc.Text = 'WEB' ) then
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQl.Clear;
    SQL.Add('SELECT sum(Importe_g*CASE WHEN facturable_tg="S" THEN -1 ELSE 1 END) gastos ' +
    //Sql.Add(' select sum(importe_g) as gastos '+
      ' from frf_gastos, frf_tipo_gastos ' +
      ' where empresa_g=:empresa ' +
      ' and centro_salida_g=:centro ' +
      ' and n_albaran_g=:referencia ' +
      ' and fecha_g=:fecha ' +
      ' and tipo_tg = tipo_g');
    ParamByName('empresa').AsString := empresa_sc.Text;
    ParamByName('centro').AsString := centro_salida_sc.Text;
    ParamByName('referencia').Asinteger := bnStrToInt(n_albaran_sc.Text);
    ParamByName('fecha').AsDateTime := StrTodate(fecha_sc.Text);

    try
      Open;
    except
      if ( cliente_sal_sc.Text = 'WEB' ) and not DMConfig.EsLaFont then
        SBGastos.Caption := 'Transporte'
      else
        SBGastos.Caption := '&Gastos (-)';
      Exit;
    end;

    if isempty then
    begin
      if ( cliente_sal_sc.Text = 'WEB' ) and not DMConfig.EsLaFont then
        SBGastos.Caption := 'Transporte'
      else
        SBGastos.Caption := '&Gastos (0)';
      Exit;
    end;

    if ( cliente_sal_sc.Text = 'WEB' ) and not DMConfig.EsLaFont then
        SBGastos.Caption := 'Transporte'
    else
        SBGastos.Caption := '&Gastos (' + FieldByName('gastos').AsString + ')';
  end;
end;

procedure TFMSalidas.Observaciones;
begin
    if ( Trim(nota_sc.Text) = '' )  then
    begin
      if ( empresa_sc.Text = 'F18' ) then
      begin
        if ( cliente_sal_sc.Text = 'WEB' ) then
        begin
          if ( StrToDate(fecha_sc.Text) < StrToDate('1/2/2014') ) then
          begin
            nota_sc.Lines.Add('');
            nota_sc.Lines.Add('Bienvenido al Mundo Pícaro.');
            nota_sc.Lines.Add('Esperamos que disfrute de la nueva experiencia de "picar naturalmente".');
            nota_sc.Lines.Add('');
            nota_sc.Lines.Add('Si desea algunos consejos de uso, no dude en consultarnos, le daremos ideas muy originales.');
            nota_sc.Lines.Add('');
            nota_sc.Lines.Add('Pícaro by Bonnysa');
          end;
        end
        else
        begin
          if cliente_sal_sc.Text = 'SOC' then
          begin
            nota_sc.Lines.Add('TEMPERATURA ENTRE 1º y 6º C');
            nota_sc.Lines.Add('TEMPERATURA SALIDA PRODUCTO INFERIOR A +4º C');
          end
          else
          if cliente_sal_sc.Text = 'DIA' then
          begin
            nota_sc.Lines.Add('TEMPERATURA ENTRE 1º y 8º C');
          end
          else
          begin
            nota_sc.Lines.Add('TEMPERATURA ENTRE 1º y 4º C');
            nota_sc.Lines.Add('TEMPERATURA SALIDA PRODUCTO INFERIOR A +4º C');
          end;
        end;
      end
      else
      begin
        if ( empresa_sc.Text = 'F21' ) then
        begin
          if ( centro_salida_sc.Text = '4' ) and
             ( cliente_sal_sc.Text = 'MER' ) and
             ( dir_sum_sc.Text = '927' ) then
          begin
            nota_sc.Lines.Add('TEMPERATURA OPTIMA DE +2 A +4 GRADOS.');
            nota_sc.Lines.Add('FURGON PRE-ENFRIADO : SI');
          end
          else
          begin
            nota_sc.Lines.Add('TEMPERATURA OPTIMA DE +8 A +12 GRADOS.');
            nota_sc.Lines.Add('FURGON PRE-ENFRIADO : SI');
          end;
        end
        else
        if ( empresa_sc.Text = 'F17' ) and ( centro_salida_sc.Text = '2' ) then
        begin
          nota_sc.Lines.Add('TEMPERATURA ÓPTIMA 8 GRADOS.');
          nota_sc.Lines.Add('EQUIPO FRÍO EN FUNCIONAMIENTO: SI.');
        end
        else
        begin
          //if cliente_sal_sc.Text = 'MER' then
          begin
            nota_sc.Lines.Add('TEMPERATURA ÓPTIMA 12 GRADOS.');
            nota_sc.Lines.Add('EQUIPO FRÍO EN FUNCIONAMIENTO: SI.');
          end;
        end;
      end;
      if ( cliente_sal_sc.Text = 'MER' ) and ( dir_sum_sc.Text = '2MN' ) then
      begin
        nota_sc.Lines.Add(UpperCase('La mercancía transportada realiza tráfico marítimo entre islas'));
      end;
      nota_sc.Lines.Add('-" EL CONDUCTOR CONFIRMA QUE LA MERCANCÍA VA SUJETA POR BARRAS".');
    end;
end;

procedure TFMSalidas.dir_sum_scChange(Sender: TObject);
begin
     //CLAVE AJENA SUMINISTRO
  if (not (dir_sum_sc.Text = cliente_sal_sc.Text)) then
  begin
    if (Trim(dir_sum_sc.Text) = '') then
    begin
      STDir_sum_sc.Caption := '';
    end
    else
    begin
               //COMPROBAR CLAVE AJENA
      STDir_sum_sc.Caption := desSuministro(empresa_sc.text,
        cliente_sal_sc.Text,
        dir_sum_sc.Text);
    end;
  end
  else
  begin
    STDir_sum_sc.Caption := STcliente_sal_sc.Caption;
  end;

  if ( Estado = teAlta ) then
  begin
    if STDir_sum_sc.Caption <> '' then
    begin
      if nota_sc.Lines.Count = 2 then
        nota_sc.Lines.Clear;
      Observaciones;
    end;
  end;
end;

procedure TFMSalidas.dir_sum_scExit(Sender: TObject);
begin
  if RejillaFlotante.Visible then Exit;
  if Estado = teLocalizar then Exit;

  if (DSMaestro.State = dsInsert) or (DSMaestro.State = dsedit) then
  begin
    if Trim(dir_sum_sc.Text) = '' then
    begin
      if Trim(cliente_sal_sc.Text) <> '' then
      begin
        dir_sum_sc.Text := cliente_sal_sc.Text;
        STDir_sum_sc.Caption := STcliente_sal_sc.Caption;
      end;
    end
    else
    begin
               //COMPROBAR CLAVE AJENA
      if (dir_sum_sc.Text = cliente_sal_sc.Text) then
      begin
        STDir_sum_sc.Caption := STcliente_sal_sc.Caption;
      end
      else
      begin
        STDir_sum_sc.Caption := desSuministroEx(empresa_sc.Text, cliente_sal_sc.Text, dir_sum_sc.Text);
        if STDir_sum_sc.Caption = '' then
        begin
          dir_sum_sc.SetFocus;
         Advertir('Direccion de suministro incorrecta');
        end ;
      end;
    end;
  end;

  if Estado = teAlta then
  begin
    if STDir_sum_sc.Caption <> '' then
    begin
      if nota_sc.Lines.Count = 2 then
        nota_sc.Lines.Clear;
      Observaciones;
    end;
  end;
end;

procedure TFMSalidas.RestaurarCabecera;
begin
  QSalidasC.Insert;
  with cabecera do
  begin
    QSalidasC.FieldByName('empresa_sc').AsString := SalidaRecord.rEmpresa_sc;
    QSalidasC.FieldByName('centro_salida_sc').AsString := SalidaRecord.rCentro_salida_sc;
    QSalidasC.FieldByName('n_albaran_sc').AsInteger := SalidaRecord.rN_albaran_sc;
    QSalidasC.FieldByName('fecha_sc').AsDateTime := SalidaRecord.rFecha_sc;
    QSalidasC.FieldByName('hora_sc').AsString := SalidaRecord.rHora_sc;
    QSalidasC.FieldByName('cliente_sal_sc').AsString := SalidaRecord.rCliente_sal_sc;
    QSalidasC.FieldByName('dir_sum_sc').AsString := SalidaRecord.rDir_sum_sc;
    QSalidasC.FieldByName('cliente_fac_sc').AsString := SalidaRecord.rCliente_fac_sc;
    QSalidasC.FieldByName('moneda_sc').AsString := SalidaRecord.rMoneda_sc;
    QSalidasC.FieldByName('n_pedido_sc').AsString := SalidaRecord.rN_pedido_sc;
    QSalidasC.FieldByName('operador_transporte_sc').AsInteger := SalidaRecord.rOperadorTransporte_sc;    
    QSalidasC.FieldByName('transporte_sc').AsInteger := SalidaRecord.rTransporte_sc;
    QSalidasC.FieldByName('vehiculo_sc').AsString := SalidaRecord.rVehiculo_sc;
  end;
end;

procedure TFMSalidas.ReintentarAlta;
begin
     //Estado
  Estado := teAlta;
  EstadoDetalle := tedOperacionMaestro;
  BEEstado;
  BHEstado;
  PanelMaestro.Enabled := True;
  PanelDetalle.Enabled := False;

  if Assigned(FOnEdit) then FOnEdit;

     //Poner foco
  Self.ActiveControl := FocoModificar;
end;

procedure TFMSalidas.kilos_slChange(Sender: TObject);
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;

  if bFlagCambios and  kilos_sl.Focused then
    RecalcularUnidades( Sender );
end;

procedure TFMSalidas.PonTextoEstaticoDetalle;
begin
  STEnvase_sl.Caption := desEnvaseP(empresa_sc.Text, envase_sl.Text, producto_sl.Text);
  STProducto_sl.Caption := desProducto(empresa_sc.Text, producto_sl.Text);
  STMarca_sl.Caption := desMarca(marca_sl.Text);
  STcategoria_sl.Caption := desCategoria(empresa_sc.Text, producto_sl.Text, categoria_sl.Text);
  STcolor_sl.Caption := desColor(empresa_sc.Text, producto_sl.Text, color_sl.Text);

  if Trim(Moneda_sc.Text) <> '' then
    LImporteTotal.Caption := 'ImporteTotal-' + Moneda_sc.Text
  else
    LImporteTotal.Caption := 'ImporteTotal';

end;

function TFMSalidas.esClienteExtranjero(codEmp: string; codCliente: string): Boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select pais_c from frf_clientes ' +
      ' where empresa_c=' + QuotedStr(codEmp) + ' ' +
      ' and cliente_c=' + QuotedStr(codCliente);
    try
      try
        Open;
        if IsEmpty then esClienteExtranjero := false
        else esClienteExtranjero := (Fields[0].AsString <> 'ES') and (Fields[0].AsString <> '');
      except
        esClienteExtranjero := false;
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;


procedure TFMSalidas.importe_neto_slChange(Sender: TObject);
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;
  if bFlagCambios and  importe_neto_sl.Focused then
    RecalcularUnidades( Sender, True );
end;

procedure TFMSalidas.CambioDeEnvase(Sender: TObject);
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;

    //foco y campos editables
  STEnvase_sl.Caption := desEnvase(empresa_sc.Text, envase_sl.Text);

  if Length( envase_sl.Text ) >= 3 then
  begin
    //UNIDAD DE FACTURACION
    unidad_precio_sl.Text := unidadFacturacion(empresa_sc.text, cliente_sal_sc.text,
        producto_sl.Text, envase_sl.Text);
    sUnidadPrecioLinea:= Copy( unidad_precio_sl.Text, 1, 1 );

    tipo_iva_sl.Text:= Impuesto.sCodigo;
    case TipoIVAEnvaseProducto( empresa_sc.Text, envase_sl.Text, producto_sl.Text ) of
      1: //if impuesto.rReducido <> StrToFloatDef( porc_iva_sl.Text, -1 ) then
           rImpuestoLinea:= impuesto.rReducido;
      2: //if impuesto.rGeneral <> StrToFloatDef( porc_iva_sl.Text, -1 ) then
           rImpuestoLinea:= impuesto.rGeneral;
      else
        //if impuesto.rSuper <> StrToFloatDef( porc_iva_sl.Text, -1 ) then
          rImpuestoLinea:= impuesto.rSuper;
    end;

    bEnvaseVariableLinea:= EnvaseUnidadesVariable( empresa_sc.Text, envase_sl.Text, producto_sl.Text );
    unidades_caja_sl.Enabled:= bEnvaseVariableLinea;
    if not bEnvaseVariableLinea or ( unidades_caja_sl.Text = '' ) then
    begin
      unidades_caja_sl.Text:= IntToStr( UnidadesEnvase( empresa_sc.Text, envase_sl.Text, producto_sl.Text ) );
    end;

    bPesoVariableLinea:= EnvasePesoVariable( empresa_sc.Text, envase_sl.Text, producto_sl.Text );
    kilos_sl.Enabled:= bPesoVariableLinea;
    rPesoCaja:= KilosEnvase( empresa_sc.Text, envase_sl.Text, producto_sl.Text );

    if bFlagCambios then
      RecalcularUnidades( sender );
  end;
end;

(*IVA*)
procedure TFMSalidas.CambioProducto(Sender: TObject);
begin
  PonNombre(Sender);
  PonNombre( color_sl );
  PonNombre( categoria_sl );
  if Length( envase_sl.Text ) >= 3 then
    CambioDeEnvase( envase_SL );
end;

procedure TFMSalidas.GastosClick( const AFacturable: boolean );
//Var tip:String;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
// Elimina de la tabla Temporal...
    SQL.Clear;
    SQL.Add('DELETE FROM tmp_gastos ');
    SQL.Add('WHERE usuario_tg = ' + QuotedStr(gsCodigo) + ' ');

    ExecSQL;

    SQL.Clear;
    SQL.Add('INSERT INTO tmp_gastos (empresa_tg,centro_tg,albaran_tg,' +
      'fecha_tg,tipo_tg,importe_tg,usuario_tg,ref_fac_tg, fecha_fac_tg, producto_tg, solo_lectura_tg) ');
    SQL.Add('SELECT empresa_g,centro_salida_g,n_albaran_g,' +
      'fecha_g,tipo_g,' +
      'importe_g,' +
      QuotedStr(gsCodigo) + ' As usuario ');
    SQL.Add(' ,ref_fac_g, fecha_fac_g, producto_g, solo_lectura_g ');
    SQL.Add('FROM frf_gastos');
    SQL.Add('WHERE empresa_g=' + QuotedStr(empresa_sc.Text) + ' ' +
      'And centro_salida_g=' + QuotedStr(centro_salida_sc.Text) + ' ' +
      'And n_albaran_g=' + n_albaran_sc.Text + ' ' +
      'And fecha_g=:fecha ');
    ParamByName('fecha').asdatetime := StrToDate(fecha_sc.Text);
    ExecSQL;
  end;

  try
    FMGastosSalida := TFMGastosSalida.Create(Self);


    with FMGastosSalida.QGastosSalida do
    begin
          // Datos de gastos de la Salida que
      if Active then Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM tmp_gastos ');
      SQL.Add('WHERE empresa_tg =' + QuotedStr(empresa_sc.Text) + ' ' +
        'And centro_tg =' + QuotedStr(centro_salida_sc.Text) + ' ' +
        'And albaran_tg =' + n_albaran_sc.Text + ' ' +
        'And fecha_tg = :fecha ' +
        'And usuario_tg = ' + QuotedStr(gsCodigo) + ' ');
      SQL.Add('ORDER BY tipo_tg');
      ParamByName('fecha').asdatetime := StrToDate(fecha_sc.Text);
      Open;
      First;
      while not Eof do
      begin
        DMAuxDB.QDescripciones.SQL.Text := ' select descripcion_tg, facturable_tg from frf_tipo_gastos ' +
          ' where tipo_tg=' + QuotedStr(FieldByName('tipo_tg').AsString);
        try
          DMAuxDB.QDescripciones.Open;
          if not DMAuxDB.QDescripciones.IsEmpty then
          begin
            Edit;
            FieldByName('descriptipo_tg').AsString :=
              DMAuxDB.QDescripciones.FieldByName('descripcion_tg').AsString;
            FieldByName('facturable_tg').AsString :=
              DMAuxDB.QDescripciones.FieldByName('facturable_tg').AsString;
            Post;
          end;
        finally
          DMAuxDB.QDescripciones.Cancel;
          DMAuxDB.QDescripciones.Close;
        end;
        Next;
      end;
      Close;
      Open;
    end;


    FMGastosSalida.emp := empresa_sc.Text;
    FMGastosSalida.empNom := empresa_sc.Text + ' - ' + STEmpresa_sc.Caption;
    FMGastosSalida.cen := centro_salida_sc.Text;
    FMGastosSalida.cenNom := STCentro_salida_sc.Caption;
    FMGastosSalida.alb := n_albaran_sc.Text;
    FMGastosSalida.fec := fecha_sc.Text;
    FMGastosSalida.STEmpresa.Caption := FMGastosSalida.empNom;
    FMGastosSalida.STCentro.Caption := FMGastosSalida.cenNom;
    FMGastosSalida.STAlbaran.Caption := FMGastosSalida.alb;
    FMGastosSalida.STFecha.Caption := FMGastosSalida.fec;
    FMGastosSalida.descripcionCliente;
    FMGastosSalida.Botones;
    FMGastosSalida.bFacturable:= AFacturable;
    FMGastosSalida.ShowModal;
  finally
    FMGastosSalida.QGastosSalida.Close;
    FMGastosSalida.Free;
  end;
  CambiarRegistro;
end;

procedure TFMSalidas.AGastosExecute(Sender: TObject);
begin
  // Mantenimiento de Gastos por Salida...
  if (Estado = teConjuntoResultado) then
  begin
    if estoyContabilizada then
    begin
      ShowError('La salida ya esta asociada a una factura contabilizada. Recuerde que sólo debe modificar gastos no facturables.');
      GastosClick( False );
    end
    else
    if estoyFacturada then
    begin
      ShowMessage('Albarán asociado a una factura, recuerde repetirla si añade gastos facturables.');
      GastosClick( True );
    end
    else
    begin
      GastosClick( True );
    end;
  end;
end;

procedure TFMSalidas.DesasignarAlbFac;
//var
  //enclave: TBookMark;
  //cBack: TCursor;
begin
  if Application.MessageBox('¿Seguro que quiere romper el enlace entre el albarán actual y su factura asociada.?' + #13 + #10 +
                            'Recuerde repetir la factura para que el cambio se vea reflejado.',
                            'Desasociar factura.', MB_YESNO ) = IDNO then
    Exit;

  //cBack:= Screen.Cursor;
  //Screen.Cursor:= crHourGlass;
  //Application.ProcessMessages;

  //DSMaestro.DataSet.DisableControls;
  //enclave:= DSMaestro.DataSet.GetBookmark;
  DSMaestro.DataSet.Edit;
  DSMaestro.DataSet.FieldByName('n_factura_sc').Value:= NULL;
  DSMaestro.DataSet.FieldByName('fecha_factura_sc').Value:= NULL;
  DSMaestro.DataSet.Post;
  //DSMaestro.DataSet.Close;
  //DSMaestro.DataSet.Open;
  //DSMaestro.DataSet.GotoBookmark( enclave );

  //Screen.Cursor:= cBack;
  //Application.ProcessMessages;
  //DSMaestro.DataSet.EnableControls;
  //DSMaestro.DataSet.FreeBookmark( enclave );
end;

function ExisteFactura( const AEmpresa: string; const AFecha: TDateTime; const AFactura: integer ): boolean;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQl.Add('Select n_factura_f from frf_facturas ');
    SQl.Add(' where empresa_f = :empresa ');
    SQl.Add('   and n_factura_f = :factura ');
    SQl.Add('   and fecha_factura_f = :fecha ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('factura').AsInteger:= AFactura;
    ParamByName('fecha').AsDateTime:= AFecha;

    Open;
    result:= not IsEmpty;
    Close;
  end;
end;

procedure TFMSalidas.AsignarAlbFac;
var
  sEmpresa: string;
  dFecha: TDateTime;
  iFactura: Integer;
  //enclave: TBookMark;
  //cBack: TCursor;
begin
  sEmpresa:= empresa_sc.Text;
  dFecha:= Date;
  ifactura:= 0;
  if GetFacturaAsignar( sEmpresa, dFecha, iFactura) then
  begin
    if ExisteFactura( sEmpresa, dFecha, iFactura ) then
    begin
      //cBack:= Screen.Cursor;
      //Screen.Cursor:= crHourGlass;
      //Application.ProcessMessages;

      //DSMaestro.DataSet.DisableControls;
      //enclave:= DSMaestro.DataSet.GetBookmark;
      DSMaestro.DataSet.Edit;
      DSMaestro.DataSet.FieldByName('n_factura_sc').AsInteger:= iFactura;
      DSMaestro.DataSet.FieldByName('fecha_factura_sc').AsDateTime:= dFecha;
      DSMaestro.DataSet.Post;
      //DSMaestro.DataSet.Close;
      //DSMaestro.DataSet.Open;
      //DSMaestro.DataSet.GotoBookmark( enclave );

      //Screen.Cursor:= cBack;
      //Application.ProcessMessages;
      //DSMaestro.DataSet.EnableControls;
      //DSMaestro.DataSet.FreeBookmark( enclave );
    end
    else
    begin
      ShowMessage('No se puede asignar un albarán a una factura inexistente.');
    end;
  end;
end;

procedure TFMSalidas.SBFacturableClick(Sender: TObject);
begin
  if not DSMaestro.DataSet.IsEmpty then
  begin
    if EstoyContabilizada then
    begin
      ShowMessage('No se puede desasignar un albarán de una factura ya contabilizada.');
    end
    else
    begin
      if n_factura_sc.Text <> '' then
      begin
        DesasignarAlbFac;
      end
      else
      begin
        AsignarAlbFac;
      end;
    end;
  end;
end;

procedure TFMSalidas.AMenuEmergenteExecute(Sender: TObject);
begin
  MessageDlg(IntToStr(RVisualizacion.SelectedRows.Count), mtInformation, [], 0);
end;

procedure TFMSalidas.RVisualizacionDblClick(Sender: TObject);
var
  i: integer;
  unidad: string;
  sComer: string;
begin
  if estoyContabilizada then
  begin
    //raise Exception.Create('No se puede modificar una salida asociada a una factura contabilizada.');
    ShowMessage('No se puede modificar una salida asociada a una factura contabilizada.');
    sComer:= DSDetalle.DataSet.FieldByName('comercial_sl').AsString;
    if SeleccionarComercialFD.SeleccionarComercial( sComer ) = mrOk then
    begin
      DSDetalle.DataSet.Edit;
      DSDetalle.DataSet.FieldByName('comercial_sl').AsString:= sComer;
      DSDetalle.DataSet.Post;
    end;
    Exit;
  end
  else
  if estoyFacturada then
  begin
    ShowMessage('Albarán asociado a una factura, recuerde repetirla si modifica el albarán');
  end;

  if Estado <> teConjuntoResultado then exit;
  //Comprobar si hay mas de un registro seleccionado
  if RVisualizacion.SelectedRows.Count = 1 then
  begin
    TextoPrecio.Caption := '1 registro selccionado.';
    etiquetaUnidad.Caption :=
      RVisualizacion.DataSource.DataSet.FieldByName('unidad_precio_sl').AsString;
    PanelPrecio.Visible := true;
    PanelPrecio.Enabled := true;
    RVisualizacion.Enabled := false;
    Precio.SetFocus;
  end;
  if RVisualizacion.SelectedRows.Count > 1 then
  begin
    etiquetaUnidad.Caption :=
      RVisualizacion.DataSource.DataSet.FieldByName('unidad_precio_sl').AsString;
    with RVisualizacion.DataSource.DataSet do
    begin
      GotoBookmark(pointer(RVisualizacion.SelectedRows.Items[0]));
      unidad := FieldByName('unidad_precio_sl').AsString;
      for i := 1 to RVisualizacion.SelectedRows.Count - 1 do
      begin
        GotoBookmark(pointer(RVisualizacion.SelectedRows.Items[i]));
        if unidad <> FieldByName('unidad_precio_sl').AsString then
        begin
          ShowError('Las lineas seleccionadas deben tener la misma unidad de facturación.');
          Exit;
        end;
      end;
    end;
    TextoPrecio.Caption := IntToStr(RVisualizacion.SelectedRows.Count) +
      ' registros selccionados.';
    PanelPrecio.Visible := true;
    PanelPrecio.Enabled := true;
    RVisualizacion.Enabled := false;
    Precio.SetFocus;
  end;
end;

procedure TFMSalidas.SpeedButton1Click(Sender: TObject);
begin
  RVisualizacion.Enabled := true;
  PanelPrecio.Enabled := false;
  PanelPrecio.Visible := false;
end;

procedure TFMSalidas.SpeedButton2Click(Sender: TObject);
var
  i: integer;
begin
  RVisualizacion.DataSource.DataSet.DisableControls;
  try
    with RVisualizacion.DataSource.DataSet do
    begin
      if RVisualizacion.SelectedRows.Count > 1 then
      begin
        for i := 0 to RVisualizacion.SelectedRows.Count - 1 do
        begin
          GotoBookmark(pointer(RVisualizacion.SelectedRows.Items[i]));
          CambiarPrecio( StrToFloatDef( precio.Text, 0 ) );
        end;
      end
      else
      begin
        CambiarPrecio( StrToFloatDef( precio.Text, 0 ) );
      end;
      RVisualizacion.SelectedRows.Clear;
    end;
  finally
    RVisualizacion.DataSource.DataSet.EnableControls;
  end;
  RVisualizacion.Enabled := true;
  PanelPrecio.Enabled := false;
  PanelPrecio.Visible := false;
end;

procedure TFMSalidas.precioEnter(Sender: TObject);
begin
  Precio.Text := '';
  FMSalidas.KeyPreview := false;
  BHMaestroDetalleDeshabilitar(true);
  BHMaestroDeshabilitar(true);
  Fprincipal.AIPrevisualizar.Enabled := false;
end;

procedure TFMSalidas.precioExit(Sender: TObject);
begin
  FMSalidas.KeyPreview := true;
  BHEstado;
  BHGrupoDesplazamientoMaestro(self.PCMaestro);
  BHGrupoDesplazamientoDetalle(self.PCdetalle);
  {BHMaestroDetalleDeshabilitar(false);
  BHMaestroDeshabilitar(false);}
  Fprincipal.AIPrevisualizar.Enabled := true;
end;

procedure TFMSalidas.precioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_F1 then
  begin
    SpeedButton2.Click;
  end;
end;

procedure TFMSalidas.precioKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_ESCAPE then
  begin
    SpeedButton1.Click;
  end;
end;


///////////////////////////////////////////////////////////////////
//                                                               //
//   EVENTOS ASOCIADOS A LA QUERY                                //
//                                                               //
///////////////////////////////////////////////////////////////////

procedure TFMSalidas.QSalidasCBeforePost(DataSet: TDataSet);
var
  nAlbaran: Integer;
begin
  if DataSet.State = dsInsert then
  begin
     //Abrir transaccion
     {i:=0;
     while TQuery(DataSet).DataBase.InTransaction and (i<30) do
     begin
       sleep(1000);
       Inc(i);
     end;
     if TQuery(DataSet).DataBase.InTransaction then
     begin
       Abort;
     end;
     TQuery(DataSet).DataBase.StartTransaction;}

    nAlbaran := GetNumeroDeAlbaran(empresa_sc.Text, centro_salida_sc.Text, True, bnStrToInt(n_albaran_sc.Text));
    DataSet.FieldByName('n_albaran_sc').AsInteger := nAlbaran;
    DataSourceDetalle.DataSet.FieldByName('n_albaran_sl').AsInteger := nAlbaran;
    SalidaRecord.rN_albaran_sc := nALbaran;
    n_albaran_sc.Text := IntToStr(nAlbaran);
  end;
end;

(*IVA*)
procedure TFMSalidas.QSalidasCAfterPost(DataSet: TDataSet);
var
  Bookmark: TBookmark;
begin
  if Estado = teModificar then
  begin
    //Comprobar si hay cambio de iva
    Impuesto:= ImpuestosCliente(empresa_sc.Text, centro_salida_sc.Text, cliente_fac_sc.Text, dir_sum_sc.Text, StrToDateTimeDef( fecha_sc.Text, Now ));
    TSalidasL.DisableControls;
    Bookmark:= TSalidasL.GetBookmark;
    TSalidasL.First;
    while not TSalidasL.Eof do
    begin
      if ( TSalidasL.FieldByName('tipo_iva_sl').AsString <> Impuesto.sCodigo ) or
         ( QSalidasC.FieldByName('cliente_sal_sc').AsString <> TSalidasL.FieldByName('cliente_sl').AsString ) then
      begin
        TSalidasL.Edit;
        if ( TSalidasL.FieldByName('tipo_iva_sl').AsString <> Impuesto.sCodigo ) then
        begin
          TSalidasL.FieldByName('tipo_iva_sl').AsString:= Impuesto.sCodigo;
          case TipoIVAEnvaseProducto( TSalidasL.FieldByName('empresa_sl').AsString,
                                      TSalidasL.FieldByName('envase_sl').AsString,
                                      TSalidasL.FieldByName('producto_sl').AsString ) of
            0: TSalidasL.FieldByName('porc_iva_sl').AsFloat:= Impuesto.rSuper;
            1: TSalidasL.FieldByName('porc_iva_sl').AsFloat:= Impuesto.rReducido;
            2: TSalidasL.FieldByName('porc_iva_sl').AsFloat:= Impuesto.rGeneral;
          end;
          TSalidasL.FieldByName('iva_sl').AsFloat:= bRoundTo((TSalidasL.FieldByName('importe_neto_sl').AsFloat*TSalidasL.FieldByName('porc_iva_sl').AsFloat)/100, -2);
          TSalidasL.FieldByName('importe_total_sl').AsFloat:= TSalidasL.FieldByName('importe_neto_sl').AsFloat + TSalidasL.FieldByName('iva_sl').AsFloat;
        end;
        if ( QSalidasC.FieldByName('cliente_sal_sc').AsString <> TSalidasL.FieldByName('cliente_sl').AsString ) then
        begin
          TSalidasL.FieldByName('cliente_sl').AsString:= QSalidasC.FieldByName('cliente_sal_sc').AsString;
        end;
        TSalidasL.Post;
      end;
      TSalidasL.Next;
    end;
    TSalidasL.GotoBookmark( Bookmark );
    TSalidasL.FreeBookmark( Bookmark );
    TSalidasL.EnableControls;
  end
  else
  begin
    IncSalidaCliente(empresa_sc.Text, cliente_sal_sc.Text);
  end;

  ActualizarMatricula;
end;

procedure TFMSalidas.ActualizarMatricula;
begin
  if not DMConfig.EsLaFont then
  begin
    if ( oldMatricula <> QSalidasC.FieldByName('vehiculo_sc').AsString ) and
       ( oldmatricula <> 'IGNORAR' ) then
    begin
      DMAuxDB.QAux.SQL.Clear;
      DMAuxDB.QAux.SQL.Add('update frf_orden_carga_c ');
      DMAuxDB.QAux.SQL.Add('set vehiculo_occ = :matricula  ');
      DMAuxDB.QAux.SQL.Add('where empresa_occ = :empresa  ');
      DMAuxDB.QAux.SQL.Add('and centro_salida_occ = :centro ');
      DMAuxDB.QAux.SQL.Add('and fecha_occ = :fecha ');
      DMAuxDB.QAux.SQL.Add('and n_albaran_occ = :albaran ');

      DMAuxDB.QAux.ParamByName('matricula').AsString:= QSalidasC.FieldByName('vehiculo_sc').AsString;
      DMAuxDB.QAux.ParamByName('empresa').AsString:= QSalidasC.FieldByName('empresa_sc').AsString;
      DMAuxDB.QAux.ParamByName('centro').AsString:= QSalidasC.FieldByName('centro_salida_sc').AsString;
      DMAuxDB.QAux.ParamByName('albaran').AsInteger:= QSalidasC.FieldByName('n_albaran_sc').AsInteger;
      DMAuxDB.QAux.ParamByName('fecha').AsDateTime:= QSalidasC.FieldByName('fecha_sc').AsDateTime;

      DMAuxDB.QAux.ExecSQL;
    end;
  end;
end;

procedure TFMSalidas.QSalidasCAfterEdit(DataSet: TDataSet);
begin
  if not EstoyContabilizada then
    CargaRegistro;
end;

///////////////////////////////////////////////////////////////////
//                                                               //
///////////////////////////////////////////////////////////////////

procedure TFMSalidas.CargaRegistro;
begin
  with QSalidasC, SalidaRecord do
  begin
    rEmpresa_sc := FieldByName('empresa_sc').asString;
    rCentro_salida_sc := FieldByName('centro_salida_sc').AsString;
    rN_albaran_sc := FieldByName('n_albaran_sc').AsInteger;
    rFecha_sc := FieldByName('fecha_sc').AsDateTime;
    rHora_sc := FieldByName('hora_sc').AsString;
    rCliente_sal_sc := FieldByName('cliente_sal_sc').AsString;
    rDir_sum_sc := FieldByName('dir_sum_sc').AsString;
    rCliente_fac_sc := FieldByName('cliente_fac_sc').AsString;
    rN_pedido_sc := FieldByName('n_pedido_sc').AsString;
    rMoneda_sc := FieldByName('moneda_sc').AsString;
    rOperadorTransporte_sc := FieldByName('operador_transporte_sc').AsInteger;
    rTransporte_sc := FieldByName('transporte_sc').AsInteger;
    rVehiculo_sc := FieldByName('vehiculo_sc').AsString;
  end;
end;

function TFMSalidas.EstoyFacturada: boolean;
begin
  (*
  result:= False;
  Exit;
  *)
  result:= Trim(n_factura_sc.Text) <> '';
end;

function TFMSalidas.EstoyContabilizada: boolean;
begin
  (*
  Result:= False;
  Exit;
  (*)
  begin
    //Comprobar que no se haya facturado
    if Trim(n_factura_sc.Text) = '' then
    begin
      Result := false;
    end
    else
    begin
      Result := EstaContabilizada(empresa_sc.Text, n_factura_sc.Text, fecha_factura_sc.Text);
    end;
  end;
end;

function TFMSalidas.unidadFacturacion(const empresa, cliente,
  producto, envase: string): string;
var
  sProductoBase: string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select producto_base_p from frf_productos ' +
      ' where empresa_p=' + QuotedStr(empresa) +
      ' and producto_p=' + QuotedStr(producto);
    try
      Open;
      sProductoBase := fields[0].AsString;
    finally
      Close;
    end;
  end;

  result := 'KGS';
  if sProductoBase <> '' then
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select unidad_fac_ce from frf_clientes_env ' +
      ' where empresa_ce=' + QuotedStr(empresa) +
      ' and cliente_ce=' + QuotedStr(cliente) +
      ' and producto_base_ce=' + sProductoBase +
      ' and envase_ce=' + QuotedStr(envase);
    try
      try
        Open;
      except
        showMessage('Unidad de facturacion incorrecta: ' + empresa + '-' + cliente + '-' + producto + '-' + envase + '-' + sProductoBase );
      end;
      if not IsEmpty then
      begin
          if fields[0].AsString = 'U' then
          begin
            result := 'UND';
          end
          else
          if fields[0].AsString = 'C' then
          begin
            result := 'CAJ';
          end;
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

procedure TFMSalidas.TSalidasLNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('emp_procedencia_sl').AsString := empresa_sc.Text;
  //Comercial
  DataSet.FieldByName('comercial_sl').AsString := UDMMaster.DMMaster.GetCodeComercial( empresa_sc.Text, cliente_sal_sc.Text );
  //comercial_sl.Text:= DataSet.FieldByName('comercial_sl').AsString;
end;

procedure TFMSalidas.AplicaFiltro(const AFiltro: string);
begin
     //Cerramos detalle
  DataSourceDetalle.DataSet.Cancel;
  DataSourceDetalle.DataSet.Close;
     //Cerramos maestro
  DataSeTMaestro.Cancel;
  DataSeTMaestro.Close;

     //Aplicar Query
  DataSeTMaestro.SQL.Clear;
  DataSeTMaestro.SQL.Add(Select);
  DataSeTMaestro.SQL.Add(AFiltro);
  DataSeTMaestro.SQL.Add(Order);
  DataSeTMaestro.EnableControls;

     //activar Query
  try
    DataSeTMaestro.Open;
    DataSourceDetalle.DataSet.Open;
  except
    on e: EDBengineError do
    begin
      ShowError(e);
      Registros := 0;
      Registro := 0;
      Visualizar;
      Exit;
    end;
  end;

     //Numero de registros
  Registros := CantidadRegistros;
  Registro := 1;

     //Poner estado segun el resultado de la busqueda
  Visualizar;

     //Mensaje si no encontramos ningun registro
  if Registros = 0 then
    BEMensajes('No se han encontrado datos para los valores introducidos.');
end;

procedure TFMSalidas.DSDetalleStateChange(Sender: TObject);
begin
  if DSDetalle.State = dsEdit then
    oldEnvase := envase_sl.Text
  else
    oldEnvase := '';
end;

procedure TFMSalidas.porte_bonny_scEnter(Sender: TObject);
begin
  TDBCheckBox( Sender ).Color:= clMoneyGreen;
end;

procedure TFMSalidas.porte_bonny_scExit(Sender: TObject);
begin
  TDBCheckBox( Sender ).Color:= clBtnFace;
end;

procedure TFMSalidas.QSalidasCNewRecord(DataSet: TDataSet);
begin
  if (Estado <> teAlta) then
  begin
    QSalidasC.FieldByName('porte_bonny_sc').AsInteger:= 0;
    QSalidasC.FieldByName('higiene_sc').AsInteger:= 1;
    QSalidasC.FieldByName('reclamacion_sc').AsInteger:= 0;

    oldmatricula:= 'IGNORAR';
  end
  else
  begin
    QSalidasC.FieldByName('es_transito_sc').AsInteger:= 0;
  end;
end;

procedure TFMSalidas.QSalidasCBeforeEdit(DataSet: TDataSet);
begin
  oldMatricula:= QSalidasC.FieldByName('vehiculo_sc').AsString;
end;

procedure TFMSalidas.tipo_palets_slChange(Sender: TObject);
begin
  stTipoPalets.Caption:= desTipoPalet( tipo_palets_sl.Text );
end;

procedure TFMSalidas.CambiarPrecio( const APrecio: real );
var
  rAux: Real;
begin
  if APrecio = 0 then
  begin
    with DSDetalle.DataSet do
    begin
      Edit;
      FieldByName('precio_sl').AsFloat:= 0;
      FieldByName('importe_neto_sl').AsFloat:= 0;
      FieldByName('iva_sl').AsFloat:= 0;
      FieldByName('importe_total_sl').AsFloat:= 0;
      Post;
    end;
  end
  else
  begin
    with DSDetalle.DataSet do
    begin
      Edit;
      FieldByName('precio_sl').AsFloat:= APrecio;

      if FieldByName('unidad_precio_sl').AsString = 'UND' then
      begin
        rAux:= FieldByName('cajas_sl').AsInteger * FieldByName('unidades_caja_sl').AsInteger;
      end
      else
      if FieldByName('unidad_precio_sl').AsString = 'CAJ' then
      begin
        rAux:= FieldByName('cajas_sl').AsInteger;
      end
      else
      //if FieldByName('unidad_precio_sl').AsSting = 'KGS' then
      begin
        rAux:= FieldByName('kilos_sl').AsFloat;
      end;

      rAux:= bRoundTo( rAux * APrecio, -2 );
      FieldByName('importe_neto_sl').AsFloat:= rAux;
      rAux:= bRoundTo( ( FieldByName('importe_neto_sl').AsFloat * FieldByName('porc_iva_sl').AsFloat ) / 100, -2 );
      FieldByName('iva_sl').AsFloat:= rAux;
      rAux:= FieldByName('importe_neto_sl').AsFloat + FieldByName('iva_sl').AsFloat;
      FieldByName('importe_total_sl').AsFloat:= rAux;

      Post;
    end;
  end;
end;

procedure TFMSalidas.QSalidasCAfterOpen(DataSet: TDataSet);
begin
  if bAbonos then
  begin
    if DMConfig.EsLaFont then
      QAbonos.Open;
  end;
  btnDesadv.Enabled:= ( QSalidasC.FieldByName('cliente_sal_sc').AsString = 'ECI' ) or
                      ( QSalidasC.FieldByName('cliente_sal_sc').AsString = 'AMA' );
end;

procedure TFMSalidas.QSalidasCBeforeClose(DataSet: TDataSet);
begin
  if DMConfig.EsLaFont then
    QAbonos.Close;
end;

(*IVA*)
procedure TFMSalidas.btnValorarClick(Sender: TObject);
begin
  if (Estado = teConjuntoResultado) and ( not DSDetalle.DataSet.isEmpty ) then
  begin
    if estoyContabilizada then
    begin
      ShowError('La salida ya esta asociada a una factura contabilizada, no se pueden modificar los precios.');
    end
    else
    if estoyFacturada then
    begin
      ShowMessage('Albarán asociado a una factura, recuerde repetirla despues de modificar los precios.');
      ValorarAlbaran;
    end
    else
    begin
      ValorarAlbaran;
    end;
  end;
end;

function  TFMSalidas.GetPrecioDiario( const AEmpresa, AEnvase, AProducto: string; const AFecha: TDateTime; var VUnidad: string ): real;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select fecha_epd, precio_epd, und_factura_epd from frf_env_precio_diario ');
    SQL.Add(' where empresa_epd = :empresa ');
    SQL.Add('   and envase_epd = :envase ');
    SQL.Add('   and producto_base_epd = ( select producto_base_p ');
    SQL.Add('                             from frf_productos ');
    SQL.Add('                             where empresa_p = :empresa ');
    SQL.Add('                               and producto_p = :producto ) ');
    SQL.Add('   and fecha_epd = :fecha ');
    SQL.Add(' order by 1 desc ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('envase').AsString:= AEnvase;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
    if IsEmpty then
    begin
      result:= 0;
      VUnidad:= '';
    end
    else
    begin
      result:= FieldByName('precio_epd').AsFloat;
      VUnidad:= FieldByName('und_factura_epd').AsString;
    end;
    Close;
  end;
end;

procedure TFMSalidas.ActualizarPrecio( const APrecio, ANeto, ATipoIva, AIva: real; const ARowid: integer );
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' update frf_salidas_l ');
    SQL.Add(' set precio_sl = :precio, ');
    SQL.Add('     importe_neto_sl = :neto, ');
    SQL.Add('     porc_iva_sl = :tipoiva, ');
    SQL.Add('     iva_sl = :iva, ');
    SQL.Add('     importe_total_sl = :total ');
    SQL.Add(' where rowid = :rowid ');
    ParamByName('precio').AsFloat:= APrecio;
    ParamByName('neto').AsFloat:= ANeto;
    ParamByName('tipoiva').AsFloat:= ATipoIva;
    ParamByName('iva').AsFloat:= AIva;
    ParamByName('total').AsFloat:= ANeto + AIva;
    ParamByName('rowid').AsInteger:= ARowid;
    ExecSQL;
  end;
end;

procedure TFMSalidas.ValorarAlbaran;
var
  rPrecio, rNeto, rTipoIva, rIva: real;
  dFecha: TDateTime;
  bFlag: boolean;
  iCount, iTotal: integer;
  sAux, sUnidad: string;
  iUnidadesEnvase: Integer;
begin
  iCount:= 0;
  iTotal:= 0;
  bFlag:= false;
  while not bFlag do
  begin
    dFecha:= DSDetalle.DataSet.FieldByName('fecha_sl').AsDateTime;
    if GetFechaDiarioEnvases.Preguntar( 'PRECIOS DIARIOS POR ENVASES', 'Introduce fecha', dFecha ) then
    begin
      DSDetalle.DataSet.DisableControls;
      try
        with DMAuxDB.QGeneral do
        begin
          SQL.Clear;
          SQL.Add(' select rowid, * from frf_salidas_l');
          SQL.Add(' where empresa_sl = :empresa ');
          SQL.Add('   and centro_salida_sl = :centro ');
          SQL.Add('   and fecha_sl = :fecha ');
          SQL.Add('   and n_albaran_sl = :albaran ');
          SQL.Add(' order by 1 desc ');
          ParamByName('empresa').AsString:= DSDetalle.DataSet.FieldByName('empresa_sl').AsString;
          ParamByName('centro').AsString:= DSDetalle.DataSet.FieldByName('centro_salida_sl').AsString;
          ParamByName('fecha').AsDate:= DSDetalle.DataSet.FieldByName('fecha_sl').AsDateTime;
          ParamByName('albaran').AsInteger:= DSDetalle.DataSet.FieldByName('n_albaran_sl').AsInteger;
          Open;
        end;
        DSDetalle.DataSet.Close;

        sAux:= '';
        while not DMAuxDB.QGeneral.Eof do
        begin
          inc( iTotal );
          rPrecio:= GetPrecioDiario( DMAuxDB.QGeneral.FieldByName('empresa_sl').AsString,
                                     DMAuxDB.QGeneral.FieldByName('envase_sl').AsString,
                                     DMAuxDB.QGeneral.FieldByName('producto_sl').AsString, dFecha, sUnidad );
          //que coincidan el numero de unidades
          iUnidadesEnvase:= unidadesEnvaseEx( DMAuxDB.QGeneral.FieldByName('empresa_sl').AsString,
                                                    DMAuxDB.QGeneral.FieldByName('envase_sl').AsString,
                                                    DMAuxDB.QGeneral.FieldByName('producto_sl').AsString );
          if sUnidad = '' then
          begin
              sAux:= sAux + #13 + #10 + 'ERROR Falta grabar precios para -> ' + DMAuxDB.QGeneral.FieldByName('empresa_sl').AsString + '-' +
                                                                            DMAuxDB.QGeneral.FieldByName('envase_sl').AsString + '-' +
                                                                            DMAuxDB.QGeneral.FieldByName('producto_sl').AsString + '-' +
                                                                            DateToStr( dFecha );
          end
          else
          if Copy( DMAuxDB.QGeneral.FieldByName('unidad_precio_sl').AsString, 1, 1) <> sUnidad then
          begin
            sAux:= sAux + #13 + #10 + 'ERROR No coincide la unidad de facturacion ' + sUnidad + ' -> ' + DMAuxDB.QGeneral.FieldByName('empresa_sl').AsString + '-' +
                                                                            DMAuxDB.QGeneral.FieldByName('envase_sl').AsString + '-' +
                                                                            DMAuxDB.QGeneral.FieldByName('producto_sl').AsString + '-' +
                                                                            DMAuxDB.QGeneral.FieldByName('unidad_precio_sl').AsString;
          end
          else
          if ( sUnidad = 'U' ) and ( iUnidadesEnvase <> DMAuxDB.QGeneral.FieldByName('unidades_caja_sl').AsInteger ) then
          begin
            sAux:= sAux + #13 + #10 + 'ERROR No coincide las unidades por envase ' + DMAuxDB.QGeneral.FieldByName('unidades_caja_sl').AsString + ' -> ' +
                                                                              DMAuxDB.QGeneral.FieldByName('empresa_sl').AsString + '-' +
                                                                              DMAuxDB.QGeneral.FieldByName('envase_sl').AsString + '-' +
                                                                              DMAuxDB.QGeneral.FieldByName('producto_sl').AsString + '-' +
                                                                              IntToStr( iUnidadesEnvase );
          end
          else
          begin
            if rPrecio <> 0 then
            begin
              rPrecio:= bRoundTo( rPrecio, 3 );
              if sUnidad = 'U' then
              begin
                rNeto:= bRoundTo( rPrecio *  ( DMAuxDB.QGeneral.FieldByName('cajas_sl').AsFloat *
                                               UnidadesEnvase( DMAuxDB.QGeneral.FieldByName('empresa_sl').AsString,
                                                               DMAuxDB.QGeneral.FieldByName('envase_sl').AsString,
                                                               DMAuxDB.QGeneral.FieldByName('producto_sl').AsString) ) , 2 );
              end
              else
              if sUnidad = 'C' then
              begin
                rNeto:= bRoundTo( rPrecio * DMAuxDB.QGeneral.FieldByName('cajas_sl').AsFloat, 2 );

              end
              else
              begin
                rNeto:= bRoundTo( rPrecio * DMAuxDB.QGeneral.FieldByName('kilos_sl').AsFloat, 2 );
              end;
              if DMAuxDB.QGeneral.FieldByName('envase_sl').AsString = '371' then
              begin
                rTipoIva:= 8;
                rIva:= bRoundTo( ( rNeto * rTipoIva ) / 100, 2 );
              end
              else
              begin
                rTipoIva:= DMAuxDB.QGeneral.FieldByName('porc_iva_sl').AsFloat;
                rIva:= bRoundTo( ( rNeto * rTipoIva ) / 100, 2 );
              end;
              ActualizarPrecio( rPrecio, rNeto, rTipoIva, rIva, DMAuxDB.QGeneral.FieldByName('rowid').AsInteger );
              inc( iCount );
            end
            else
            begin
              sAux:= sAux + #13 + #10 + 'ERROR Falta grabar precios para -> ' + DMAuxDB.QGeneral.FieldByName('empresa_sl').AsString + '-' +
                                                                            DMAuxDB.QGeneral.FieldByName('centro_salida_sl').AsString + '-' +
                                                                          DMAuxDB.QGeneral.FieldByName('envase_sl').AsString + '-' +
                                                                          DMAuxDB.QGeneral.FieldByName('producto_sl').AsString + '-' +
                                                                          DateToStr( dFecha );
            end;
          end;
          DMAuxDB.QGeneral.Next;
        end;
      finally
        DMAuxDB.QGeneral.Close;
        DSDetalle.DataSet.Open;
        DSDetalle.DataSet.EnableControls;
      end;


      if sAux <> '' then
      begin
        sAux:= 'Proceso finalizado con errores.' + #13 + #10 + sAux + #13 + #10 + #13 + #10 +
               'Valoradas ' + IntToStr( iCount ) + ' lineas de ' + IntToStr( iTotal ) + '.';

      end
      else
      begin
        ValidarAlbaran;
        (*
        if ValidarAlbaran then
        begin
          sAux:= 'Proceso finalizado correctamente.' + #13 + #10 +
                 'Valoradas ' + IntToStr( iCount ) + ' lineas de ' + IntToStr( iTotal ) + '.';
        end
        else
        begin
          sAux:= 'Proceso finalizado sin validar factura.' + #13 + #10 + sAux + #13 + #10 + #13 + #10 +
               'Valoradas ' + IntToStr( iCount ) + ' lineas de ' + IntToStr( iTotal ) + '.';
        end;
        *)
      end;
      ShowMessage( sAux );
      bFlag:= True;

    end
    else
    begin
      bFlag:= True;
    end;
  end;
end;

procedure TFMSalidas.RecalcularUnidades( const ASender: TObject; const AImporte: boolean = false );
var
  iUnidadesCaja: integer;
  iUnidadesLinea, iCajasLinea: Integer;
  rKilosLinea, rPrecioLinea, rNetoLinea, rIvaLinea, rTotalLinea: Real;
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;
    
  bFlagCambios:= False;

  iUnidadesCaja:= StrToIntDef( unidades_caja_sl.Text, 1);
  iCajasLinea:= StrToIntDef( cajas_sl.Text, 0);
  iUnidadesLinea:= iCajasLinea * iUnidadesCaja;
  if bPesoVariableLinea then
  begin
    rKilosLinea:= StrToFloatDef( kilos_sl.Text, 0);
  end
  else
  begin
    rKilosLinea:= bRoundTo( rPesoCaja * iCajasLinea, 2 );
  end;

  if AImporte then
  begin
    rNetoLinea:= StrToFloatDef( importe_neto_sl.Text, 0);
    if rNetoLinea = 0 then
    begin
      rPrecioLinea:= 0;
    end
    else
    if sUnidadPrecioLinea = 'K' then
    begin
      rPrecioLinea:= bRoundTo( rNetoLinea / rKilosLinea, 3 );
    end
    else
    if sUnidadPrecioLinea = 'U' then
    begin
      rPrecioLinea:= bRoundTo( rNetoLinea / iUnidadesLinea, 3 );
    end
    else
    //if sUnidadPrecioLinea = 'C' then
    begin
      rPrecioLinea:= bRoundTo( rNetoLinea / iCajasLinea, 3 );
    end;
  end
  else
  begin
    rPrecioLinea:= StrToFloatDef( precio_sl.Text, 0);
    if sUnidadPrecioLinea = 'K' then
    begin
      rNetoLinea:= rPrecioLinea * rKilosLinea;
    end
    else
    if sUnidadPrecioLinea = 'U' then
    begin
      rNetoLinea:= rPrecioLinea * iUnidadesLinea;
    end
    else
    //if sUnidadPrecioLinea = 'C' then
    begin
      rNetoLinea:= rPrecioLinea * iCajasLinea;
    end;
  end;


  rIvaLinea:= bRoundTo( rNetoLinea * ( rImpuestoLinea / 100 ), 2 );
  rTotalLinea:= rNetoLinea + rIvaLinea;


  if TComponent( ASender ).Name <> 'cajas_sl' then
    cajas_sl.Text:= FormatFloat('#0',iCajasLinea );
  if TComponent( ASender ).Name <> 'unidades_caja_sl' then
    unidades_caja_sl.Text:= FormatFloat('#0',iUnidadesCaja );

  if TComponent( ASender ).Name <> 'STUnidades' then
    STUnidades.Caption := FormatFloat('#0', iUnidadesLinea );
  if TComponent( ASender ).Name <> 'kilos_sl' then
    kilos_sl.Text := FormatFloat('#0.00', rKilosLinea );
  if TComponent( ASender ).Name <> 'precio_sl' then
    precio_sl.Text := FormatFloat('#0.000', rPrecioLinea );
  if TComponent( ASender ).Name <> 'importe_neto_sl' then
    importe_neto_sl.Text := FormatFloat('#0.00', rNetoLinea );
  if TComponent( ASender ).Name <> 'porc_iva_sl' then
    porc_iva_sl.Text := FormatFloat('#0.00', rImpuestoLinea );
  if TComponent( ASender ).Name <> 'iva_sl' then
    iva_sl.Text := FormatFloat('#0.00', rIvaLinea );
  if TComponent( ASender ).Name <> 'importe_total_sl' then
    importe_total_sl.Text := FormatFloat('#0.00', rTotalLinea );


  bFlagCambios:= True;
end;

procedure TFMSalidas.EnvaseInicial;
var
  iUnidadesCaja: integer;
  iUnidadesLinea, iCajasLinea: Integer;
begin
  STEnvase_sl.Caption := desEnvase(empresa_sc.Text, envase_sl.Text);

  //unidad_precio_sl.Text := unidadFacturacion(empresa_sc.text, cliente_sal_sc.text,
  //   producto_sl.Text, envase_sl.Text);
  sUnidadPrecioLinea:= Copy( unidad_precio_sl.Text, 1, 1 );

  tipo_iva_sl.Text:= Impuesto.sCodigo;

  case TipoIVAEnvaseProducto( empresa_sc.Text, envase_sl.Text, producto_sl.Text ) of
    1: rImpuestoLinea:= impuesto.rReducido;
    2: rImpuestoLinea:= impuesto.rGeneral;
    else
      rImpuestoLinea:= impuesto.rSuper;
  end;

  bEnvaseVariableLinea:= EnvaseUnidadesVariable( empresa_sc.Text, envase_sl.Text, producto_sl.Text );
  unidades_caja_sl.Enabled:= bEnvaseVariableLinea;
  bPesoVariableLinea:= EnvasePesoVariable( empresa_sc.Text, envase_sl.Text, producto_sl.Text );
  kilos_sl.Enabled:= bPesoVariableLinea;
  rPesoCaja:= KilosEnvase( empresa_sc.Text, envase_sl.Text, producto_sl.Text );

  iUnidadesCaja:= StrToIntDef( unidades_caja_sl.Text, 1);
  iCajasLinea:= StrToIntDef( cajas_sl.Text, 0);
  iUnidadesLinea:= iCajasLinea * iUnidadesCaja;
  STUnidades.Caption := FormatFloat('#0', iUnidadesLinea );
end;

procedure TFMSalidas.edt_facturable_scChange(Sender: TObject);
begin
  if QSalidasC.FieldByName('facturable_sc').AsInteger = 1 then
  begin
    btnValidar.Caption:= 'Desmarcar facturable';
    SBFacturable.Enabled:= True;
  end
  else
  begin
    btnValidar.Caption:= 'Pasar a Facturable';
    SBFacturable.Enabled:= False;
  end;
end;

procedure TFMSalidas.fecha_factura_scChange(Sender: TObject);
begin
  if QSalidasC.FieldByName('fecha_factura_sc').AsString = '' then
  begin
    SBFacturable.Caption:= 'Ligar a Factura';
  end
  else
  begin
    SBFacturable.Caption:= 'Desligar de Factura';
  end;
end;

function TFMSalidas.DesValidarAlbaran: boolean;
begin
  //Desvalidar
  if EstoyFacturada then
  begin
    ShowMessage('No se puede desvalidar un albarán ya facturado.');
    Result:= False;
  end
  else
  begin
    QSalidasC.Edit;
    QSalidasC.FieldByName('facturable_sc').AsInteger:= 0;
    QSalidasC.Post;
    Result:= True;
  end;
end;

function TFMSalidas.ValidarLineas: Boolean;
var
  bRecargo: Boolean;
  rSuper, rReducido, rGeneral: Real;
  bActualizarUnidades: Boolean;

  sImpuesto: string;
  sSuministro, sImpuestoSuministro: string;
  sEnvase: string; iIvaEnvase: Integer;
  sEnvaseCliente, sUnidadFactura: string;
  sAlbaran, sErrores: string;
  iUnidadesEnvase: Integer;
begin
  bActualizarUnidades:= False;
  sErrores:= '';
  result:= True;
  //Comprobar que tenga si tiene recargo de equivalencia
  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;

    SQL.Add(' select empresa_sc, centro_salida_sc, cliente_sal_sc, dir_sum_sc,   ');
    SQL.Add('        fecha_sc, n_albaran_sc, producto_sl, envase_sl, unidades_caja_sl, ');
    SQL.Add('        unidad_precio_sl, tipo_iva_sl, porc_iva_sl, precio_sl, kilos_sl ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and fecha_sc = :fecha ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and empresa_sl = empresa_sc ');
    SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    SQL.Add(' order by  producto_sl, envase_sl ');
    ParamByName('empresa').AsString:= QSalidasC.fieldByName('empresa_sc').AsString;
    ParamByName('centro').AsString:= QSalidasC.fieldByName('centro_salida_sc').AsString;
    ParamByName('fecha').AsDateTime:= QSalidasC.fieldByName('fecha_sc').AsDateTime;
    ParamByName('albaran').AsInteger:= QSalidasC.fieldByName('n_albaran_sc').AsInteger;

    Open;
    try
      sImpuesto:= '';
      sSuministro:= '';
      sImpuestoSuministro:= 'IR';
      sEnvase:= '';
      iIvaEnvase:= 0; //Super
      sEnvaseCliente:= '';
      sUnidadFactura:= 'KGS';
      iUnidadesEnvase:= 0;

      bRecargo:= ClienteConRecargo( FieldByName('empresa_sc').AsString,FieldByName('cliente_sal_sc').AsString, Date );
      while not Eof do
      begin
        if sSuministro <> FieldByName('empresa_sc').AsString + FieldByName('centro_salida_sc').AsString +
                          FieldByName('cliente_sal_sc').AsString + FieldByName('dir_sum_sc').AsString then
        begin
          sSuministro:= FieldByName('empresa_sc').AsString + FieldByName('centro_salida_sc').AsString +
                        FieldByName('cliente_sal_sc').AsString + FieldByName('dir_sum_sc').AsString;
          sImpuestoSuministro:= ImpuestosEntre( FieldByName('empresa_sc').AsString, FieldByName('centro_salida_sc').AsString,
                        FieldByName('cliente_sal_sc').AsString, FieldByName('dir_sum_sc').AsString );
        end;
        if sEnvase <> FieldByName('empresa_sc').AsString + FieldByName('envase_sl').AsString +
                                          FieldByName('producto_sl').AsString then
        begin
          sEnvase:= FieldByName('empresa_sc').AsString + FieldByName('envase_sl').AsString +
                                          FieldByName('producto_sl').AsString;
          iIvaEnvase:= TipoIvaEnvaseProducto( FieldByName('empresa_sc').AsString,FieldByName('envase_sl').AsString,
                                          FieldByName('producto_sl').AsString );
          if not ExisteEnvase(FieldByName('empresa_sc').AsString, FieldByName('envase_sl').AsString, FieldByName('producto_sl').AsString ) then
          begin
            raise Exception.Create('ERROR ->  NO existe el envase ' + FieldByName('empresa_sc').AsString + ' - ' + FieldByName('envase_sl').AsString );
          end;
        end;
        if sEnvaseCliente <> FieldByName('empresa_sc').AsString + FieldByName('cliente_sal_sc').AsString +
                                         FieldByName('envase_sl').AsString + FieldByName('producto_sl').AsString then
        begin
          sEnvaseCliente:= FieldByName('empresa_sc').AsString + FieldByName('cliente_sal_sc').AsString +
                                         FieldByName('envase_sl').AsString + FieldByName('producto_sl').AsString ;
          sUnidadFactura:= unidadFacturacion( FieldByName('empresa_sc').AsString, FieldByName('cliente_sal_sc').AsString,
                                              FieldByName('producto_sl').AsString, FieldByName('envase_sl').AsString );
          iUnidadesEnvase:= unidadesEnvaseEx( FieldByName('empresa_sc').AsString,
                                               FieldByName('envase_sl').AsString, FieldByName('producto_sl').AsString );
        end;
        if sImpuesto <> sImpuestoSuministro  then
        begin
          sImpuesto:= sImpuestoSuministro;
          ImpuestosActuales( sImpuesto, rSuper, rReducido, rGeneral, bRecargo );
        end;

        sAlbaran:= FieldByName('empresa_sc').AsString + ' ' + FieldByName('centro_salida_sc').AsString + ' ' +
                   FieldByName('n_albaran_sc').AsString + ' ' +  FieldByName('fecha_sc').AsString;

        //Validar impuesto
        case  iIvaEnvase of
          0: if FieldByName('porc_iva_sl').AsFloat <> rSuper then
             begin
               Result:= False;
               sErrores:= sErrores + #13 + #10 +
                 '* Para el envase ' + FieldByName('envase_sl').AsString +
                 ' se esperaba un IVA de ' + FormatFloat( '#,##0.00', rSuper ) +
                 ' y se ha encontrado '  + FormatFloat( '#,##0.00', FieldByName('porc_iva_sl').AsFloat );
             end;
          1: if FieldByName('porc_iva_sl').AsFloat <> rReducido then
             begin
               Result:= False;
               sErrores:= sErrores + #13 + #10 +
                 '* Para el envase ' + FieldByName('envase_sl').AsString +
                 ' se esperaba un IVA de ' + FormatFloat( '#,##0.00', rReducido ) +
                 ' y se ha encontrado '  + FormatFloat( '#,##0.00', FieldByName('porc_iva_sl').AsFloat );
             end;
          2: if FieldByName('porc_iva_sl').AsFloat <> rGeneral then
             begin
               Result:= False;
               sErrores:= sErrores + #13 + #10 +
                 '* Para el envase ' + FieldByName('envase_sl').AsString +
                 ' se esperaba un IVA de ' + FormatFloat( '#,##0.00', rGeneral ) +
                 ' y se ha encontrado '  + FormatFloat( '#,##0.00', FieldByName('porc_iva_sl').AsFloat );
             end;
        end;

        //Validar unidad de facturacion
        if FieldByName('unidad_precio_sl').AsString <> sUnidadFactura then
        begin
          Result:= False;
          sErrores:= sErrores + #13 + #10 +
               '* Para el envase ' + FieldByName('envase_sl').AsString +
               ' se esperaba facturar por ' +  sUnidadFactura +
               ' y se ha encontrado '  + FieldByName('unidad_precio_sl').AsString ;
        end;



        //Validar unidades
        if iUnidadesEnvase <> - 1 then
        begin
          //Solo si no son variables, si son variables no se si pueden ser correctas
          if FieldByName('unidades_caja_sl').AsInteger <> iUnidadesEnvase then
          begin
            //Si no coinciden
            if sUnidadFactura = 'UND' then
            begin
              //Error si la unidad_precio_sl de facturacion EstoyFacturada por unidades
              Result:= False;
              sErrores:= sErrores + #13 + #10 +
                   '* Para el envase ' + FieldByName('envase_sl').AsString +
                   ' se esperaba ' +  IntToStr( iUnidadesEnvase ) +
                   ' unidades caja y se ha encontrado '  + FieldByName('unidades_caja_sl').AsString ;
            end
            else
            begin
              //si no facturamos poe unidades ponemos las de la central
              bActualizarUnidades:= True;
            end;
          end;
        end;

        if FieldByName('precio_sl').AsFloat = 0 then
        begin
          Result:= False;
          sErrores:= sErrores + #13 + #10 + '* Falta precio para el envase ' + FieldByName('envase_sl').AsString;
        end;

        if FieldByName('kilos_sl').AsFloat = 0 then
        begin
          Result:= False;
          sErrores:= sErrores + #13 + #10 + '* Falta precio para el envase ' + FieldByName('envase_sl').AsString;
          raise Exception.Create('ERROR ->  Hay una linea sin kilos ');
        end;

        Next;

      end;
    finally
      Close;
    end;
  end;
  if not Result then
  begin
    Result:= VerAdvertencia( Self, Trim( sErrores ) ) = mrIgnore;
  end;
  if bActualizarUnidades then
    ActualizarUnidades( QSalidasC.fieldByName('empresa_sc').AsString,
                        QSalidasC.fieldByName('centro_salida_sc').AsString,
                        QSalidasC.fieldByName('fecha_sc').AsDateTime,
                        QSalidasC.fieldByName('n_albaran_sc').AsInteger);
end;

procedure TFMSalidas.ActualizarUnidades( const AEmpresa, ACentro: string; const AFecha: TDate; const AAlbaran: Integer );
var
  iAux: Integer;
begin
  //Solo las que no se facturan por unidades
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;

    SQL.Add(' update frf_salidas_l ');

    SQL.Add(' set unidades_caja_sl = ');
    SQL.Add('        ( ');
    SQL.Add('          select unidades_e ');
    SQL.Add('          from frf_envases ');
    SQL.Add('          where empresa_e = empresa_sl ');
    SQL.Add('          and envase_e = envase_sl ');

    SQL.Add('          and producto_base_e = ( select producto_base_p from frf_productos ');
    SQL.Add('                                  where empresa_p = empresa_sl and producto_p = producto_sl ) ');
    SQL.Add('        ) ');

    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and n_albaran_sl = :albaran ');
    SQL.Add(' and fecha_sl = :fecha ');
    SQL.Add(' and unidad_precio_sl <> ''UND'' ');

    SQL.Add(' and  exists ');
    SQL.Add(' ( ');
    SQL.Add('   select * ');
    SQL.Add('   from frf_envases ');
    SQL.Add('   where empresa_e = empresa_sl ');
    SQL.Add('   and envase_e = envase_sl ');

    SQL.Add('   and producto_base_e = ( select producto_base_p from frf_productos ');
    SQL.Add('                           where empresa_p = empresa_sl and producto_p = producto_sl ) ');
    SQL.Add('   and nvl(unidades_variable_e,0) = 0 ');

    SQL.Add('   and unidades_e <> unidades_caja_sl ');
    SQL.Add('   and unidades_e is not null ');
    SQL.Add(' ) ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('albaran').AsInteger:= AAlbaran;
    ExecSQL;

    iAux:= RowsAffected;
    SQL.Clear;
    SQL.Add(' INSERT INTO ctr_unidades_envases ( ');
    SQL.Add('   user_cue,  ip_cue,  fecha_cue,  registros_cue,  empresa_cue,  centro_cue,  albaran_cue,  inicio_cue,  fin_cue ');
    SQL.Add(' ) ');
    SQL.Add(' VALUES ( ');
    SQL.Add('   :user,  :ip,  :fecha,  :registros,  :empresa,  :centro,  :albaran,  :inicio,  :fin ');
    SQL.Add(' ) ');
    ParamByname('user').AsString:= gsCodigo;
    ParamByname('ip').AsString:= gsDirIP;
    ParamByname('registros').AsInteger:= iAux;
    ParamByname('fecha').AsDatetime:= Now;
    ParamByname('empresa').AsString:= AEmpresa;
    ParamByname('centro').AsString:= ACentro;
    ParamByname('albaran').AsInteger:= AAlbaran;
    ParamByname('inicio').AsDatetime:= AFecha;
    ParamByname('fin').AsDatetime:= AFecha;
    ExecSQL;
  end;
end;

function TFMSalidas.ValidarAlbaran: boolean;
begin
  //Validar
  if ValidarLineas then
  begin
    QSalidasC.Edit;
    QSalidasC.FieldByName('facturable_sc').AsInteger:= 1;
    QSalidasC.Post;
    Result:= True;
  end
  else
  begin
    Result:= False;
  end;
end;

procedure TFMSalidas.btnValidarClick(Sender: TObject);
begin
  if QSalidasC.IsEmpty then
  begin
    ShowError('Seleccione primero un albarán.');
  end
  else
  begin
    if not ( ( QSalidasC.State = dsInsert ) or ( QSalidasC.State = dsEdit ) ) then
    begin
      if Copy( cliente_fac_sc.Text, 1, 1 ) = '0' then
      begin
        ShowMessage('Los clientes que empiezan por cero (0) no son facturables.');
      end
      else
      begin
        if QSalidasC.FieldByName('facturable_sc').AsInteger = 1 then
        begin
          DesValidarAlbaran;
        end
        else
        begin
         ValidarAlbaran;
        end;
      end;
    end;
  end;
end;

procedure TFMSalidas.entrega_slChange(Sender: TObject);
begin
  if ( DSDetalle.DataSet.State = dsEdit ) or ( DSDetalle.DataSet.State = dsInsert ) then
  begin
    if Length( entrega_sl.Text ) = 12 then
    begin
      //Busca año semana / producto
      with DMAuxDB.Qaux do
      begin
        SQL.Clear;
        SQL.Add('select anyo_semana_ec from frf_entregas_c where codigo_ec = :entrega ');
        ParamByName('entrega').AsString:= entrega_sl.Text;
        Open;
        anyo_semana_entrega_sl.Text:= FieldByName('anyo_semana_ec').AsString;
        Close;
      end;
    end
    else
    begin
      anyo_semana_entrega_sl.Text:= '';
    end;
  end;

  if entrega_sl.Text = '' then
    btnEntrega.Caption:= 'Insertar Entrega'
  else
    btnEntrega.Caption:= 'Cambiar Entrega ' + entrega_sl.Text;
end;

procedure TFMSalidas.btnDesadvClick(Sender: TObject);
var
  sMsg: string;
begin
  if (Estado = teConjuntoResultado) and ( not DSMaestro.DataSet.IsEmpty ) then
  begin
    if  ( DSMaestro.DataSet.fieldByname('cliente_sal_sc').AsString = 'ECI' ) or
        ( DSMaestro.DataSet.fieldByname('cliente_sal_sc').AsString = 'AMA' )then
    begin
      VerOrdenFD.MakeDsadv( DSMaestro.DataSet.fieldByname('empresa_sc').AsString,
                                    DSMaestro.DataSet.fieldByname('centro_salida_sc').AsString,
                                    DSMaestro.DataSet.fieldByname('n_albaran_sc').AsInteger,
                                    DSMaestro.DataSet.fieldByname('fecha_sc').AsDateTime  );
    end
    else
    begin
      ShowMessage('Cliente no valido.');
    end;
  end
  else
  begin
    ShowMessage('Seleccione primero un albarán.');
  end;
end;

procedure TFMSalidas.btnEntregaClick(Sender: TObject);
var
  sEntrega, sSemana: string;
begin
  //function InputBox(const ACaption, APrompt, ADefault: string): string;
  sEntrega:= entrega_sl.Text;
  sEntrega:= InputBox('CAMBIAR NÚMERO ENTREGA', 'Introduzca el código de la entrega:', sEntrega);
  if sEntrega <> entrega_sl.Text then
  begin
    if Trim( sEntrega ) = '' then
    begin
      DSDetalle.DataSet.Edit;
      DSDetalle.DataSet.FieldByName('entrega_sl').Value:= null;
      DSDetalle.DataSet.FieldByName('anyo_semana_entrega_sl').Value:= null;
      DSDetalle.DataSet.Post;
      ShowMessage('Proceso finalizado correctamente.');
    end
    else
    if Length(sEntrega) <> 12 then
    begin
      ShowMessage('ERROR: el codigo de la entrega debe de ser de 12 caracteres.');
    end
    else
    begin
      if Copy(sEntrega,1,3) <> 'F42' then
      begin
        ShowMessage('ERROR: Solo entregas de la planta F42.')
      end
      else
      //Busca año semana / producto
      with DMAuxDB.Qaux do
      begin
        SQL.Clear;
        SQL.Add('select anyo_semana_ec from frf_entregas_c where codigo_ec = :entrega ');
        ParamByName('entrega').AsString:= sEntrega;
        Open;
        sSemana:= FieldByName('anyo_semana_ec').AsString;
        Close;
        if sSemana = '' then
        begin
          ShowMessage('ERROR: NO se ha encontado el año/semana para la entrega introducida.');
        end
        else
        begin
          //Actualizar
          DSDetalle.DataSet.Edit;
          DSDetalle.DataSet.FieldByName('entrega_sl').AsString:= sEntrega;
          DSDetalle.DataSet.FieldByName('anyo_semana_entrega_sl').AsString:= sSemana;
          DSDetalle.DataSet.Post;
          ShowMessage('Proceso finalizado correctamente.')
        end;
      end;
    end;
  end
  else
  begin
    ShowMessage('Sin cambios.')
  end;
end;

procedure TFMSalidas.comercial_slChange(Sender: TObject);
begin
  txtDesComercial.Caption:= UDMMaster.DMMaster.desComercial( comercial_sl.Text );
end;

procedure TFMSalidas.btnVerAbonosClick(Sender: TObject);
begin
  if bAbonos then
  begin
    bAbonos:= False;
    QAbonos.Close;
    btnVerAbonos.Caption:= 'Ver Facturas';
  end
  else
  begin
    bAbonos:= True;
    if QSalidasC.Active then
      QAbonos.Open;
    btnVerAbonos.Caption:= 'Ocultar Facturas';
  end;
end;

function TFMSalidas.ImporteFacturado: string;
begin
  if QSalidasC.IsEmpty then
  begin
    Result:= '';
  end
  else
  begin
    with QSalidasC do
    begin
      Result:= FormatFloat( '#,##0.00', DMMaster.GetImpFacAlbaran( FieldByName('empresa_sc').AsString,
                                                                  FieldByName('centro_salida_sc').AsString,
                                                                  FieldByName('fecha_sc').AsDateTime,
                                                                  FieldByName('n_albaran_sc').AsInteger) );
    end;
  end;
end;

procedure TFMSalidas.QSalidasCAfterScroll(DataSet: TDataSet);
begin
  if ( QSalidasC.State = dsBrowse	) and bImpFac then
  begin
    edtImporteFacturado.Text:= ImporteFacturado;
  end
  else
  begin
    edtImporteFacturado.Text:= '';
  end;
  btnDesadv.Enabled:= ( QSalidasC.FieldByName('cliente_sal_sc').AsString = 'ECI' ) or
                      ( QSalidasC.FieldByName('cliente_sal_sc').AsString = 'AMA' );
end;

procedure TFMSalidas.btnVerImpFacClick(Sender: TObject);
begin
  if bImpFac then
  begin
    bImpFac:= False;
    QSalidasCAfterScroll(QSalidasC);
    btnVerImpFac.Caption:= 'Ver Importe Facturado';
  end
  else
  begin
    bImpFac:= True;
    QSalidasCAfterScroll(QSalidasC);
    btnVerImpFac.Caption:= 'Ocultar Imp. Facturado';
  end;
end;

procedure TFMSalidas.es_transito_scChange(Sender: TObject);
begin
  stxtTipoVenta.Caption := desTipoSalida( es_transito_sc.Text );
end;

end.



