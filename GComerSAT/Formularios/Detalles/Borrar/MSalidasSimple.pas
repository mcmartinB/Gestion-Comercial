unit MSalidasSimple;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, ExtCtrls, Buttons, CMaestroDetalle, ActnList, Grids,
  DBGrids, BGrid, BDEdit, BSpeedButton, Menus, ComCtrls, DPreview,
  BCalendario, BEdit, BCalendarButton, BGridButton,
  CVariables, DError, QRPrntr, DBTables, DBCtrls;

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

  TFMSalidasSimple = class(TMaestroDetalle)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    LEmpresa_p: TLabel;
    centro_salida_sc: TBDEdit;
    Label13: TLabel;
    Label1: TLabel;
    BGBEmpresa_sc: TBGridButton;
    empresa_sc: TBDEdit;
    STEmpresa_sc: TStaticText;
    Label5: TLabel;
    vehiculo_sc: TBDEdit;
    LCliente: TLabel;
    DSDetalle: TDataSource;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    Bevel1: TBevel;
    PDetalle: TPanel;
    RVisualizacion: TDBGrid;
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
    Label7: TLabel;
    centro_origen_sl: TBDEdit;
    BGBCentro_origen_sl: TBGridButton;
    STCentro_origen_sl: TStaticText;
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
    Label12: TLabel;
    ref_transitos_sl: TBDEdit;
    AModificarDetalle: TAction;
    ABorrarDetalle: TAction;
    AInsertarDetalle: TAction;
    AGastos: TAction;
    AMenuEmergente: TAction;
    QSalidasC: TQuery;
    TSalidasL: TTable;
    Label22: TLabel;
    emp_procedencia_sl: TBDEdit;
    lblPorte: TLabel;
    porte_bonny_sc: TDBCheckBox;
    cbx_porte_bonny_sc: TComboBox;
    Label4: TLabel;
    n_orden_sc: TBDEdit;
    Label35: TLabel;
    nota_sc: TDBMemo;
    Label25: TLabel;
    higiene_sc: TDBCheckBox;
    cbx_higiene_sc: TComboBox;
    Label36: TLabel;
    n_factura_sc: TBDEdit;
    fecha_factura_sc: TBDEdit;
    lblDesPorte: TLabel;
    pMantenimientoGastos: TPanel;
    Button1: TButton;
    stTipoPalets: TStaticText;
    lblNotaFactura: TLabel;
    nota_factura_sc: TDBMemo;
    transporte_sc: TBDEdit;
    BGBtransporte_sc: TBGridButton;
    STTransporte_sc: TStaticText;
    LAno_semana_p: TLabel;
    operador_transporte_sc: TBDEdit;
    BGBoperador_transporte_sc: TBGridButton;
    STOperador_transporte_sc: TStaticText;
    lblNombre1: TLabel;
    btnFactura: TButton;
    edtfecha_transito_sl: TBDEdit;
    edtcentro_transito_sl: TBDEdit;
    lbl1: TLabel;
    lblNombre3: TLabel;
    cbx_reclamacion_sc: TComboBox;
    reclamacion_sc: TDBCheckBox;
    lbl2: TLabel;
    unidades_caja_sl: TBDEdit;
    STUnidades: TStaticText;
    lbl3: TLabel;
    Label23: TLabel;
    incoterm_sc: TBDEdit;
    BGBincoterm_c: TBGridButton;
    stIncoterm: TStaticText;
    Label38: TLabel;
    plaza_incoterm_sc: TBDEdit;
    bvl1: TBevel;
    lblComercial: TLabel;
    comercial_sl: TBDEdit;
    btnComercial: TBGridButton;
    txtDesComercial: TStaticText;
    lbl6: TLabel;
    edtentrega_sl: TBDEdit;
    lblFechaDescarga: TLabel;
    fecha_descarga_sc: TBDEdit;
    btnFechaDescarga: TBCalendarButton;
    pmTransitos: TPopupMenu;
    mniAsignarTrnsito1: TMenuItem;
    lblHasta: TLabel;
    edtFechaHasta: TBEdit;
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
    procedure ref_transitos_slExit(Sender: TObject);
    procedure kilos_slChange(Sender: TObject);
    procedure ref_transitos_slEnter(Sender: TObject);
    procedure centro_origen_slExit(Sender: TObject);
    procedure importe_neto_slChange(Sender: TObject);
    procedure CambioDeEnvase(Sender: TObject);
    procedure CambioProducto(Sender: TObject);
    procedure AMenuEmergenteExecute(Sender: TObject);

    procedure TSalidasLNewRecord(DataSet: TDataSet);
    procedure DSDetalleStateChange(Sender: TObject);
    procedure porte_bonny_scEnter(Sender: TObject);
    procedure porte_bonny_scExit(Sender: TObject);
    procedure QSalidasCNewRecord(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure tipo_palets_slChange(Sender: TObject);
    procedure btnFacturaClick(Sender: TObject);
    procedure TSalidasLAfterDelete(DataSet: TDataSet);
    procedure TSalidasLAfterPost(DataSet: TDataSet);
    procedure unidades_caja_slChange(Sender: TObject);
    procedure incoterm_scChange(Sender: TObject);
    procedure porte_bonny_scClick(Sender: TObject);
    procedure comercial_slChange(Sender: TObject);
    procedure mniAsignarTrnsito1Click(Sender: TObject);
    procedure QSalidasCBeforeEdit(DataSet: TDataSet);
    procedure es_transito_scChange(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes: TList;
    ListaDetalle: TList;
    Objeto: TObject;

    SalidaRecord: TSalidaRecord;

    bPesoVariableLinea, bEnvaseVariableLinea, bFlagCambios: Boolean;
    rPesoCaja, rImpuestoLinea: real;
    sUnidadPrecioLinea: string;

    KilosTran: string;

    albaranObtenido: Integer;

    oldEnvase, oldMatricula: string; //Para controlar la insercion de envases dados de baja


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
    function GetNumeroDeAlbaran( const empresa, centro: string; const AIncrementa: boolean;
                      const albaran: Integer = -1): Integer;
    procedure PonPanelDetalle;
    procedure PonPanelMaestro;
    function ExisteDirSuministro: boolean;

    procedure Rejilla(boton: TBGridButton);
    procedure CambiarRegistro;
    procedure PonTextoEstaticoDetalle;
    procedure ValidarKilosTransitos;
    procedure TransitoCorrecto;


    procedure QSalidasCBeforePost(DataSet: TDataSet);
    procedure QSalidasCAfterEdit(DataSet: TDataSet);
    procedure QSalidasCAfterPost(DataSet: TDataSet);
    procedure QSalidasCPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);

    procedure CargaRegistro;

    procedure PrevFacturaProforma( const AFacDespacho: Boolean );
    procedure PreguntarInforme;
    procedure SeleccionarInforme;
    procedure PreguntarInformeEx;
    procedure SeleccionarInformeEx;
    function  UnidadesCorrectas( var AMsg: string ): Boolean;

    //procedure PutPalets(var APalets: TStrings);
    //procedure PutLogifruit(var ALogifruit: TStrings);
    //function  HayTomate: Boolean;
    //function  EsIndustria: Boolean;

    function  EstoyFacturada: boolean;
    function  EstoyContabilizada: boolean;
    procedure AntesDeBorrarDetalle;

    procedure MantenimientoGastosEx( const AFacturable: boolean );
    function MantenimientoGastos: boolean;

    procedure PonFocoDetalle( const AEdit: TBEdit );

    procedure DesasignarAlbFac;
    procedure AsignarAlbFac;

    procedure PonerIncotermPorDefecto;

    procedure ActualizarMatricula;
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
    procedure AntesDeVisualizar;
{    procedure ErrorAlInsertar;}

    procedure ComprobrarClavePrimaria;

    //Listado
    function  GetFirmaFileName: string;
    procedure Previsualizar; override;
    function  PrevisualizarAlbaran( const AIdioma: Integer; const APedirFirma, AOriginal: boolean ): boolean;
    //function  PreAlbaran( const APedirFirma, AOriginal: boolean ): boolean;
    procedure PreviewCartaPorte( const APedirFirma: boolean );

    procedure RestaurarCabecera; override;
    procedure ReintentarAlta; override;

    function esClienteExtranjero(codEmp: string; codCliente: string): Boolean;
    function unidadFacturacion(const empresa, cliente,
      producto, envase: string): string;

    procedure AplicaFiltro(const AFiltro: string);

    procedure PutObservaciones( var ATexto: TStringList );
  end;

var
  FMSalidasSimple: TFMSalidasSimple;
  sOrden: String = '';

implementation

uses bDialogs, LFacturaProforma, UFTransportistas, DInfSalidasPreguntar,
  bTimeUtils, CGestionPrincipal, UDMBaseDatos, StrUtils, CFactura,
  CAuxiliarDB, UDMAuxDB, Principal, DInfSalidasSelect,
  UDMCmr, DFacturaProforma, bSQLUtils,
  UFClientes, UFSuministros, CartaPorteDL, DConfigMail, UDMconfig, 
  MGastosSalida, bTextUtils, DAsignarAlbFac, Variants, bMath, 
  CDAsignarGastosServicioVenta, UDQAlbaranSalida, AdvertenciaFD, UDMMaster,
  UQRAlbaranAlemaniaNoVar, AsignarTransitoFD;
  //UQRAlbaranSat, 

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

procedure TFMSalidasSimple.AbrirTablas;
begin
     // Abrir tablas/Querys
  QSalidasC.SQL.Clear;
  QSalidasC.SQL.Add(Select);
  QSalidasC.SQL.Add(Where);
  QSalidasC.SQL.Add(Order);
  QSalidasC.Open;

  TSalidasL.Open;

  //Estado inicial
  if QSalidasC.IsEmpty then
  begin
    Registros := 0;
    Registro := 0;
    Estado:= teEspera;
  end
  else
  begin
    Registros := QSalidasC.RecordCount;
    Registro := 1;
    Estado:= teConjuntoResultado
  end;
 RegistrosInsertados := 0;
end;

procedure TFMSalidasSimple.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([TSalidasL, QSalidasC]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMSalidasSimple.FormCreate(Sender: TObject);
begin
  //Inicializacion variables globales
  rPesoCaja := 0;
  rImpuestoLinea:= 0;
  bFlagCambios:= True;


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
  if sOrden <> '' then
    where := ' WHERE n_orden_sc=' + sOrden
  else
    where := ' WHERE empresa_sc=' + QuotedStr('###');
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
  incoterm_sc.Tag := kIncoterm;
  es_transito_sc.Tag := kTipoSalida;

  emp_procedencia_sl.Tag := kEmpresa;
  centro_origen_sl.Tag := kCentro;
  producto_sl.Tag := kProducto;
  envase_sl.Tag := kEnvase;
  marca_sl.Tag := kMarca;
  calibre_sl.Tag := kCalibre;
  categoria_sl.Tag := kCategoria;
  color_sl.Tag := kColor;
  tipo_palets_sl.Tag := kTipoPalet;

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
{     OnBeforeDetailDelete := AntesDeBorrarDetalle;}
{     OnErrorInsert:=ErrorAlInsertar;}

     //Asociar eventos
  QSalidasC.AfterPost := QSalidasCAfterPost;
  QSalidasC.BeforePost := QSalidasCBeforePost;
  QSalidasC.OnPostError := QSalidasCPostError;
  QSalidasC.AfterEdit := QSalidasCAfterEdit;

     //Focos
  {+}FocoAltas := empresa_sc;
  {+}FocoModificar := cliente_sal_sc;
  {+}FocoLocalizar := empresa_sc;
     //Inicializacion calendarios
  CalendarioFlotante.Date := Date;


  //Observaciones factura solo en Bondelicious.
  begin
    lblNotaFactura.Visible:= False;
    nota_factura_sc.Visible:= False;
    PMaestro.Height:= 337;
  end;
  pMantenimientoGastos.Visible:= False;
  comercial_sl.Tag:= kComercial;

    lblHasta.Visible:= False;
  edtFechaHasta.Visible:= False;
end;

procedure TFMSalidasSimple.FormActivate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
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


procedure TFMSalidasSimple.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
end;

procedure TFMSalidasSimple.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMSalidasSimple.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not( nota_sc.Focused or nota_factura_sc.Focused ) then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
      end;
    vk_up:
      begin
        if not( nota_sc.Focused or nota_factura_sc.Focused ) then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        end;
      end;
    Ord('G'):
      if ssAlt in Shift  then
        MantenimientoGastos;
    Ord('F'):
      if ( ssAlt in Shift ) and pMantenimientoGastos.Visible then
        btnFactura.Click;
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

procedure TFMSalidasSimple.Filtro;
var Flag: Boolean;
  i: Integer;
  dFechaDesde, dFechaHasta: TDateTime;
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
              where := where + ' ' + name + ' =' + Text;
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

  if flag then where := ' WHERE ' + where;
end;

//...................... REGISTROS INSERTADOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// PrimaryKey del componente.
//....................................................................

procedure TFMSalidasSimple.AnyadirRegistro;
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

procedure TFMSalidasSimple.ValidarEntradaMaestro;
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
  (*
  if laFOnt then
  if ( Length( hora_sc.Text ) < 5 ) or  ( Copy( hora_sc.Text, 3, 1 ) <> ':' ) then
  begin
    raise Exception.Create('Falta la hora de carga o el formato no es correcto (hh:mm).');
  end;
  *)

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
  if (Trim(moneda_sc.Text) <> '') and (Trim(STMoneda_sc.Caption) = '') then
  begin
    moneda_sc.SetFocus;
    raise Exception.Create('Moneda incorrecta.');
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

  if porte_bonny_sc.State = cbGrayed then
  begin
    porte_bonny_sc.setFocus;
    raise Exception.Create('Falta seleccionar quien paga el porte.');
  end;

  if Trim(incoterm_sc.text) = '' then
  begin
    DSMaestro.DataSet.FieldByname('incoterm_sc').Value := NULL;
    DSMaestro.DataSet.FieldByname('plaza_incoterm_sc').Value := NULL;
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

procedure TFMSalidasSimple.PrevFacturaProforma( const AFacDespacho: Boolean );
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
        n_albaran_sc.Text, cliente_sal_sc.Text, dir_sum_sc.Text, AFacDespacho );
      ShowModal;
      iAux:= StrToInt(nCopias.Text);
      QRLFacturaProforma.ReportTitle:= sTitulo;
    end ;

    if iAux > 0 then
    begin
      QRLFacturaProforma.StringGrid:= FDFacturaProforma.StringGrid1;
      (*
      if giPtrPDF > -1 then
      begin
        QRLFacturaProforma.PrinterSettings.PrinterIndex := giPtrPDF;
        QRLFacturaProforma.ShowProgress := False;
        QRLFacturaProforma.printerSettings.Copies := 1;
        QRLFacturaProforma.Print;
      end ;
      *)
      QRLFacturaProforma.printerSettings.Copies:= iAux;

      QRLFacturaProforma.Configurar( empresa_sc.Text, PaisCliente( empresa_sc.Text, cliente_sal_sc.Text ) = 'ES' );
      Preview(QRLFacturaProforma,iAux);
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

procedure AddMsg( var AMsg: string; const ACad: string );
begin
  if AMsg = '' then
    AMsg:=  ACad
  else
    AMsg:=  AMsg + #13 + #10 + ACad;
end;

function TFMSalidasSimple.UnidadesCorrectas( var AMsg: string ): Boolean;
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

procedure TFMSalidasSimple.SeleccionarInforme;
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
      SeleccionarInformeEx
    end;
  end;
end;

procedure TFMSalidasSimple.PreguntarInforme;
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

procedure TFMSalidasSimple.PreguntarInformeEx;
var
  iTipoAlbaran: integer;
  bPedirFirma, bOriginal: boolean;
begin
  if esClienteExtranjero(empresa_sc.Text, cliente_sal_sc.Text) or (Cliente_sal_sc.Text = 'DAI') then
  begin
    if Preguntar( 0, bPedirFirma, bOriginal ) then
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
      if Preguntar( 1, bPedirFirma, bOriginal ) then
      begin
        UDMCmr.ExecVentaCMR( empresa_sc.Text, centro_salida_sc.Text, cliente_sal_sc.Text, dir_sum_sc.Text, transporte_sc.Text, nota_sc.Text,
                      StrToDate( fecha_sc.Text ), StrToInt( n_albaran_sc.Text ), QSalidasC.FieldByName('higiene_sc').AsInteger = 1 );
      end;
      if  Preguntar( 2, bPedirFirma, bOriginal ) then
        PrevFacturaProforma( False );
    end;
  end
  else
  begin
    if Preguntar( 0,  bPedirFirma, bOriginal ) then
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
      if Preguntar( 2, bPedirFirma, bOriginal ) then
        PrevFacturaProforma( False );
    end;
  end;
end;

procedure TFMSalidasSimple.SeleccionarInformeEx;
var
  {iImpresora,} iTipoAlbaran, iResult: integer;
  bPedirFirma, bOriginal: boolean;
  bFlag: boolean;
begin
  bPedirFirma:= gbFirmar;

  iTipoAlbaran:= TipoAlbaran( empresa_sc.Text, cliente_sal_sc.Text );
  iResult:= Seleccionar( iTipoAlbaran, bPedirFirma, bOriginal );

  bFlag:= True;
  if ( iResult - 1000 ) >= 0 then
  begin
    iResult:= iResult - 1000;
    //bFlag:=
    PrevisualizarAlbaran( iTipoAlbaran, bPedirFirma, bOriginal );
  end;

  if bFlag then
  begin
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
    (*
    if ( iResult - 1 ) >= 0 then
    begin
      PrevFacturaProforma;
    end;
    *)
    if ( iResult mod 10 ) = 1 then
    begin
      PrevFacturaProforma( false );
    end
    else
    if ( iResult mod 10 ) = 2 then
    begin
      PrevFacturaProforma( True );
    end;    
  end;
end;

function  TFMSalidasSimple.GetFirmaFileName: string;
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

procedure TFMSalidasSimple.PreviewCartaPorte( const APedirFirma: boolean );
var
  SFileName: string;
begin
  SFileName:= GetFirmaFileName;
  (*
  if APedirFirma then
  begin
    if sFileName = '' then
    begin
      ShowMessage('Falta inicializar la ruta para guardar las firmas.');
    end
    else
    begin
      if not FileExists( sFileName ) then
        GetFirma( self, sFilename );
    end;
  end;
  *)
  CartaPorteDL.Ejecutar( self, empresa_sc.Text, centro_salida_sc.Text,
                         StrToInt(n_albaran_sc.Text), StrToDate(fecha_sc.Text),
                         SFileName );
end;

(*
function TFMSalidasSimple.GetFirmaCMR( const APedirFirma: boolean ): string;
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

  if APedirFirma then
  begin
    if result = '' then
    begin
      ShowMessage('Falta inicializar la ruta para guardar las firmas.');
    end
    else
    begin
      if not FileExists( result ) then
        GetFirma( self, result );
    end;
  end;
end;
*)

procedure TFMSalidasSimple.Previsualizar;
begin
  if n_pedido_sc.Text <> '' then
    DConfigMail.sAsunto:= 'Envio Albarán [' + cliente_sal_sc.Text + '-' + n_albaran_sc.Text + '] - Pedido: ' + n_pedido_sc.Text
  else
    DConfigMail.sAsunto:= 'Envio Albarán [' + cliente_sal_sc.Text + '-' + n_albaran_sc.Text + ']';
  DConfigMail.sEmpresaConfig:= empresa_sc.Text;
  DConfigMail.sClienteConfig:= cliente_sal_sc.Text;
  DConfigMail.sSuministroConfig:= dir_sum_sc.Text;
  DConfigMail.sAlbaranConfig:= n_albaran_sc.Text;
  DConfigMail.sFechaConfig:= fecha_sc.Text;

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


function Dir1Transporte(const AEmpresa, ATransporte: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select direccion1_t from frf_transportistas ');
    SQL.Add(' where empresa_t ' + SQLEqualS(AEmpresa));
    SQL.Add('   and transporte_t ' + SQLEqualS(ATransporte));
    Open;
    if not IsEmpty then
    begin
      result := Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;

function Dir2Transporte(const AEmpresa, ATransporte: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select direccion2_t from frf_transportistas ');
    SQL.Add(' where empresa_t ' + SQLEqualS(AEmpresa));
    SQL.Add('   and transporte_t ' + SQLEqualS(ATransporte));
    Open;
    if not IsEmpty then
    begin
      result := Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;

function DNITransporte(const AEmpresa, ATransporte: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select cif_t from frf_transportistas ');
    SQL.Add(' where empresa_t ' + SQLEqualS(AEmpresa));
    SQL.Add('   and transporte_t ' + SQLEqualS(ATransporte));
    Open;
    if Trim( Fields[0].AsString ) <> '' then
    begin
      result := ' C.I.F.: ' + Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;

procedure TFMSalidasSimple.PutObservaciones( var ATexto: TStringList );
begin
  (*
  if n_cmr_sc.Text <> '' then
  begin
    ATexto.Add('Nº CMR:' + n_cmr_sc.Text);
  end;
  *)
  if n_orden_sc.Text <> '' then
  begin
    ATexto.Add('Nº ORDEN CARGA:' + n_orden_sc.Text);
  end;
  if higiene_sc.Checked  then
  begin
    ATexto.Add('CONDICIONES HIGIENICAS: OK');
  end
  else
  begin
    ATexto.Add('CONDICIONES HIGIENICAS: MALAS');
  end;

  if Trim( nota_sc.Text ) <> '' then
    ATexto.Add( Trim(nota_sc.Text) );
end;

function TFMSalidasSimple.PrevisualizarAlbaran( const AIdioma: Integer; const APedirFirma, AOriginal: boolean ): boolean;
begin
  if AIdioma = 0 then
  begin
    if ( cliente_sal_sc.Text = 'GOM' ) or ( cliente_sal_sc.Text = 'ERO' ) or
       ( cliente_sal_sc.Text = 'THA' ) or ( cliente_sal_sc.Text = 'M&W' ) or
       ( cliente_sal_sc.Text = 'APS' ) or ( cliente_sal_sc.Text = 'P' ) then
    begin
      result:= UDQAlbaranSalida.PreAlbaran( Self, empresa_sc.text, centro_salida_sc.Text,
                   StrToInt( n_albaran_sc.Text), StrToDateTime( fecha_sc.Text ), APedirFirma, AOriginal );
    end
    else
    begin
       result:= UDQAlbaranSalida.PreAlbaranSAT( Self, empresa_sc.text, centro_salida_sc.Text,
                   StrToInt( n_albaran_sc.Text), StrToDateTime( fecha_sc.Text ), APedirFirma, AOriginal );
       //result:= PreAlbaran( APedirFirma, AOriginal );
    end;
  end
  else
  if AIdioma = 1 then
  begin
    result:= UQRAlbaranAlemaniaNoVar.PreAlbaranAleman( empresa_sc.Text, centro_salida_sc.Text, cliente_sal_sc.Text, StrToInt( n_albaran_sc.text ),
                               StrToDate( fecha_sc.text ), APedirFirma, AOriginal );
  end
  else
  begin
    result:= False;
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

procedure TFMSalidasSimple.ARejillaFlotanteExecute(Sender: TObject);
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
    kTipoSalida: DespliegaRejilla(btnTipoSalida);
    kCentro:
      begin
        if centro_salida_sc.Focused then
        begin
          DespliegaRejilla(BGBcentro_sc, [empresa_sc.Text])
        end
        else
        begin
          if Trim(ref_transitos_sl.Text) = '' then
          begin
            DespliegaRejilla(BGBCentro_origen_sl, [empresa_sc.Text])
          end
          else
          begin
            Rejilla(BGBcentro_origen_sl);
          end;
        end;
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
    kIncoterm: DespliegaRejilla(BGBincoterm_c);
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
    kProducto:
    begin
      if Trim(ref_transitos_sl.Text) = '' then
      begin
        DespliegaRejilla(BGBproducto_sl, [empresa_sc.Text])
      end
      else
      begin
        Rejilla(BGBproducto_sl);
      end;
    end;
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

procedure TFMSalidasSimple.AntesDeInsertar;
begin
     //Rejilla en visualizacion
  VerDetalle;
     //Fecha y hora la del sistema
  fecha_sc.Text := DateToStr(Date);
  //if DMConfig.EsLaFont then
    hora_sc.Text := HoraMinuto(Time);
  PonPanelMaestro;

  pMantenimientoGastos.Visible:= False;

end;

procedure TFMSalidasSimple.AntesDeLocalizar;
begin
     //Rejilla en visualizacion
  VerDetalle;

  PonPanelMaestro;

  reclamacion_sc.Visible:= False;
  cbx_reclamacion_sc.ItemIndex:= 0;
  cbx_reclamacion_sc.Visible:= True;

  porte_bonny_sc.Visible:= False;
  lblDesPorte.Visible:= False;
  cbx_porte_bonny_sc.ItemIndex:= 0;
  cbx_porte_bonny_sc.Visible:= True;

  higiene_sc.Visible:= False;
  cbx_higiene_sc.ItemIndex:= 0;
  cbx_higiene_sc.Visible:= True;

  pMantenimientoGastos.Visible:= False;

  lblHasta.Visible:= True;
  edtFechaHasta.Visible:= True;
  edtFechaHasta.Text:= '';

end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMSalidasSimple.AntesDeModificar;
var
  i: Integer;
begin
  if estoyContabilizada then
  begin
    ShowMessage('No se puede modificar una salida asociada a una factura contabilizada.');
    raise Exception.Create('No se puede modificar una salida asociada a una factura contabilizada.');
  end
  else  
  if estoyFacturada then
  begin
    ShowMessage('Albarán asociado a una factura, recuerde repetirla si modifica el albarán');
  end
  else
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
  PonPanelMaestro;

  pMantenimientoGastos.Visible:= False;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMSalidasSimple.AntesDeVisualizar;
var i: Integer;
begin
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
          Enabled := true;
  end;

  PonPanelMaestro;
  STTransporte_sc.Caption := desTransporte(empresa_sc.Text, transporte_sc.Text);
  STOperador_transporte_sc.Caption := desTransporte(empresa_sc.Text, operador_transporte_sc.Text);
  STcliente_sal_sc.Caption := desCliente(empresa_sc.Text, cliente_sal_sc.Text);
  STcliente_fac_sc.Caption := desCliente(empresa_sc.Text, cliente_fac_sc.Text);
  STdir_sum_sc.Caption := desSuministroEx(empresa_sc.Text, cliente_sal_sc.Text, dir_sum_sc.Text);

  porte_bonny_sc.Visible:= True;
  lblDesPorte.Visible:= True;
  cbx_porte_bonny_sc.Visible:= False;
  higiene_sc.Visible:= True;
  cbx_higiene_sc.Visible:= False;

  reclamacion_sc.Visible:= True;
  cbx_reclamacion_sc.Visible:= False;  

  pMantenimientoGastos.Visible:= False;

  n_factura_sc.Enabled:= False;
  fecha_factura_sc.Enabled:= False;

  lblHasta.Visible:= False;
  edtFechaHasta.Visible:= False;  
end;

procedure TFMSalidasSimple.VerDetalle;
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

  pMantenimientoGastos.Visible:= False;
end;


procedure TFMSalidasSimple.PonFocoDetalle( const AEdit: TBEdit );
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

procedure TFMSalidasSimple.EditarDetalle;
var
  i: integer;
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
  end;

  //Si la salida proviene de un transito, guardaremos los kilos para comprobar
  //luego la suma total de todas las salidad que vengan de ese transito
  //if (ref_transitos_sl.Text <> '' then
  KilosTran := kilos_sl.Text;

  PonPanelDetalle;

  (*IVA*)
  Impuesto:= ImpuestosCliente(empresa_sc.Text, centro_salida_sc.Text, cliente_fac_sc.Text, dir_sum_sc.Text, StrToDateTimeDef( fecha_sc.Text, Now ));
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


  if EstadoDetalle = tedModificar then
  begin
    PonFocoDetalle( cajas_sl );
  end
  else
  begin
    PonFocoDetalle( ref_transitos_sl );
  end;

  pMantenimientoGastos.Visible:= False;
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

procedure TFMSalidasSimple.ValidarEntradaDetalle;
var i: Integer;
begin
  //Completamos la clave primaria
  RellenaClaveDetalle;

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
      SQl.Add('   and fecha_baja_e is  null ');
      Open;
      if IsEmpty then
      begin
        Close;
        raise Exception.Create('No se pueden usar los envases que han sido dados de baja.');
      end;
      Close;
    end;


   //*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
  if ( Trim(ref_transitos_sl.Text) <> '' ) or
     ( Trim(edtfecha_transito_sl.Text) <> '' ) or
     ( Trim(edtcentro_transito_sl.Text) <> '' ) then
  begin
    TransitoCorrecto;
    ValidarKilosTransitos;
  end;

  //29-12-2011 Garita La font
  if ( ( categoria_sl.Text = '1' ) and ( marca_sl.Text <> '01' ) ) or
     ( ( categoria_sl.Text <> '1' ) and ( marca_sl.Text = '01' ) ) or
     ( ( categoria_sl.Text = '2' ) and ( marca_sl.Text <> '00' ) ) or
     ( ( categoria_sl.Text <> '2' ) and ( marca_sl.Text = '00' ) ) then
  begin
      if application.MessageBox(PChar('Esta usted seguro de querer asignar a la categoria ' + categoria_sl.text + ' la marca '  + STMarca_sl.Caption + '?'),
              '  ATENCIÓN !', MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2) = IDNO then
        Abort;
  end;

  //Comercial
  if txtDesComercial.Caption = '' then
  begin
    raise Exception.Create('Falta el comercial asignado a la venta.');
  end;

  if STCentro_origen_sl.Caption =  '' then
  begin
    raise Exception.Create('Falta centro de origen o es incorrecto.');
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
  if not ExisteCalibre( empresa_sc.Text, producto_sl.Text, calibre_sl.Text) then
  begin
    raise Exception.Create('El calibre es incorrecto.');
  end;
  

  //if tipo_iva_sl
end;

procedure TFMSalidasSimple.RellenaClaveDetalle;
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

          //campo oculto y redundante, perdemos en tamaño pero
          //se cree que aumentara la velocidad
    TSalidasL.FieldByName('cliente_sl').AsString := Trim(cliente_sal_sc.Text);

  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

//Realiza la consulta

function TFMSalidasSimple.Consulta(value: Integer; printError: Boolean): Boolean;
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

procedure TFMSalidasSimple.PonNombre(Sender: TObject);
begin
  gRF := RejillaFlotante;
  gCF := CalendarioFlotante;

  if gRF.Visible or gCF.Visible then Exit;

  if ( DSDetalle.State = dsInsert ) or ( DSDetalle.State = dsEdit ) then
  begin
    case TComponent(Sender).Tag of
      kCentro:
        begin
          if Estado = teOperacionDetalle then
            STcentro_origen_sl.Caption := desCentro(empresa_sc.Text, centro_origen_sl.Text);
        end;
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
             STCentro_salida_sc.Caption := desCentro(empresa_sc.Text, centro_salida_sc.Text);
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
              (*
              if STcliente_sal_sc.Caption <> '' then
              if ( nota_sc.Text = '' ) and (Estado = teAlta) then
              begin
                 if ( empresa_sc.Text = '050' ) and ( cliente_sal_sc.Text = 'MER' ) then
                 begin
                   nota_sc.Lines.Add('TEMPERATURA OPTIMA DE +8 A +10 GRADOS.');
                   nota_sc.Lines.Add('EQUIPO FRÍO EN FUNCIONAMIENTO: SI.');
                 end;
              end;
              *)
            end
            else
            begin
              STcliente_fac_sc.Caption := desCliente(empresa_sc.Text, cliente_fac_sc.Text);
              RellenaMoneda( cliente_fac_sc );
            end;
          end;
        kMoneda: STMoneda_sc.Caption := desMoneda(moneda_sc.Text);
       end;
    end;
  end;
end;


procedure TFMSalidasSimple.RequiredTime(Sender: TObject;
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

function TFMSalidasSimple.ConsultaCentro: string;
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

function TFMSalidasSimple.ConsultaProducto: string;
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

function TFMSalidasSimple.ConsultaCliente: string;
begin
  if Trim(empresa_sc.Text) <> '' then

  else
    ConsultaCliente := ' SELECT DISTINCT empresa_c, cliente_c, nombre_c ' +
      ' FROM frf_clientes ' +
      ' ORDER BY nombre_c ';
end;

function TFMSalidasSimple.ConsultaSuministro: string;
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


function TFMSalidasSimple.ConsultaTransportista: string;
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

function TFMSalidasSimple.ConsultaCalibre: string;
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

function TFMSalidasSimple.ConsultaCategoria: string;
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

function TFMSalidasSimple.ConsultaColor: string;
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


procedure TFMSalidasSimple.SalirEdit(Sender: TObject);
begin
  BEMensajes('');
end;

procedure TFMSalidasSimple.EntrarEdit(Sender: TObject);
begin
  BEMensajes(TEdit(Sender).Hint);
end;


function TFMSalidasSimple.GetNumeroDeAlbaran( const empresa, centro: string; const AIncrementa: boolean;
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

procedure TFMSalidasSimple.PonNumeroAlbaran(Sender: TObject);
begin
  if (Trim(empresa_sc.Text) <> '') and
    (Trim(centro_salida_sc.Text) <> '') and
    (Estado = teAlta) and
    (DSMaestro.State <> dsBrowse) then
  begin
    n_albaran_sc.Text := IntToStr(GetNumeroDeAlbaran(empresa_sc.Text, centro_salida_sc.Text, False ) );
    albaranObtenido := bnStrToInt(n_albaran_sc.Text);
  end;
end;

procedure TFMSalidasSimple.RellenaClienteFacturacion(Sender: TObject);
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
    if DSMaestro.DataSet.CanModify then
      DSMaestro.DataSet.FieldByName('cliente_fac_sc').AsString:= cliente_sal_sc.Text;
    //cliente_fac_sc.Text := cliente_sal_sc.Text;

  end;
end;

procedure TFMSalidasSimple.RellenaMoneda(Sender: TObject);
begin
     //Rellenamos cliente de facturacion
  if (length( Trim(cliente_fac_sc.Text) ) > 1) and
    ( length( Trim(empresa_sc.Text)) = 3 ) and
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

procedure TFMSalidasSimple.PonPanelDetalle;
begin
    //Valores de la cabecera
  STAlbaran.Caption := n_albaran_sc.Text;
  STFecha.Caption := fecha_sc.Text;
  STEmpresa.Caption := STempresa_sc.Caption;
  STCentro.Caption := STcentro_salida_sc.Caption;
  STCliente.Caption := STcliente_sal_sc.Caption;
  STSuministro.Caption := STdir_sum_sc.Caption;

    //Mostrar panel cabecera
  PMaestro.Visible := false;
  PCabecera.Visible := true;
  PCabecera.Top := 0;
  PDetalle.Visible := True;
  PDetalle.Height := 183;


    //Titulo
  Self.Caption := 'SALIDAS DE FRUTA/LINEAS';
end;

procedure TFMSalidasSimple.PonPanelMaestro;
begin
    //Mostrar panel maestro
  PMaestro.Visible := true;
  PCabecera.Visible := false;
  PDetalle.Visible := false;

    //Titulo
  Self.Caption := 'SALIDAS DE FRUTA/CABECERA';
end;



procedure TFMSalidasSimple.CalculaImporte(Sender: TObject);
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;
  if bFlagCambios and  precio_sl.Focused then
    RecalcularUnidades( sender );
end;

function TFMSalidasSimple.ExisteDirSuministro: Boolean;
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

procedure TFMSalidasSimple.Borrar;
var botonPulsado: Word;
begin
  if estoyFacturada then
  begin
    raise Exception.Create('No se puede borrar una salida que tiene una factura asociada.');
  end;

  //Tiene entradas asigndas
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
      Close;
      Exit;
    end;
    Close;
  end;

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

procedure TFMSalidasSimple.BorrarSalida;
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

procedure TFMSalidasSimple.unidades_caja_slChange(Sender: TObject);
begin
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;
  if bFlagCambios and  unidades_caja_sl.Focused then
    RecalcularUnidades( sender );
end;

procedure TFMSalidasSimple.cajas_slChange(Sender: TObject);
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;
  if bFlagCambios and  cajas_sl.Focused then
    RecalcularUnidades( sender );
end;


//*************************** MARIO *****************************
//esta rejilla es para cuando se selecciona un transito que se saquen los productos
//disponibles de la tabla de transito no de la de producto.

procedure TFMSalidasSimple.Rejilla(boton: TBGridButton);
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
            SQL.Add('SELECT centro_tc,descripcion_c FROM frf_transitos_c,frf_centros');
            SQL.Add(' WHERE empresa_tc =' + empresa_sc.Text + '  AND referencia_tc= ' + ref_transitos_sl.Text);
            SQL.Add(' AND empresa_c = empresa_tc AND centro_tc=centro_c ');
            SQL.Add(' Group by centro_tc,descripcion_c order by centro_tc,descripcion_c ');
        end;
      kProducto:
        begin
            SQL.Clear;
            SQL.Add('SELECT producto_tl,descripcion_p FROM frf_transitos_l,frf_productos');
            SQL.Add(' WHERE empresa_tl =' + empresa_sc.Text + '  AND centro_tl= ' + centro_origen_sl.Text
              + ' AND referencia_tl= ' + ref_transitos_sl.Text);
            SQL.Add(' AND empresa_p = empresa_tl AND producto_p=producto_tl');
            SQL.Add(' Group by producto_tl,descripcion_p order by producto_tl,descripcion_p ' );
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

//Compruebo que existe la referencia de transito y  relleno el transito

procedure TFMSalidasSimple.ref_transitos_slExit(Sender: TObject);
begin
  if ((DSDetalle.State = dsInsert) or (DSDetalle.State = dsEdit)) and
    (Trim(edtfecha_transito_sl.Text) = '') and
    (Trim(ref_transitos_sl.Text) <> '') then
    with DMBaseDatos.QGeneral do
    begin
      Cancel;
      Close;
      with SQL do
      begin
        Clear;
        Add(' SELECT centro_tc, fecha_tc');
        Add(' FROM frf_transitos_c');
        Add(' WHERE referencia_tc = ' + ref_transitos_sl.Text);
        Add(' AND empresa_tc = ' + QuotedStr(empresa_sc.Text));
        Add(' AND fecha_tc between :fechaini and :fechafin ');
        ParamByName('fechaini').AsDate:= DSMaestro.DataSet.FieldByName('fecha_sc').AsDateTime  - 90;
        ParamByName('fechafin').AsDate:= DSMaestro.DataSet.FieldByName('fecha_sc').AsDateTime  + 90;
      end;
      try
        Open;
      except
        on E: EDBEngineError do
        begin
          ShowError(e);
          ref_transitos_sl.SetFocus;
          Exit;
        end;
      end;
       //Tiene Valores
      case RecordCount of
        0:
          begin
            ShowError('Referencia de tránsito no valida.');
            ref_transitos_sl.SetFocus;
            Exit;
          end;
        1:
          begin
           //Rellenar centro, pasar a producto
            centro_origen_sl.Text := FieldByName('centro_tc').AsString;
            edtcentro_transito_sl.Text := FieldByName('centro_tc').AsString;
            edtfecha_transito_sl.Text := FormatDateTime('dd/mm/yyyy', FieldByName('fecha_tc').AsDateTime);            
            centro_origen_slExit(centro_origen_sl);
          end;
      end;
    end;
end;

procedure TFMSalidasSimple.ComprobrarClavePrimaria;
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

procedure TFMSalidasSimple.CambiarRegistro;
begin
  STdir_sum_sc.Caption := desSuministroEx(empresa_sc.Text, cliente_sal_sc.Text, dir_sum_sc.Text);
end;

procedure TFMSalidasSimple.dir_sum_scChange(Sender: TObject);
begin
  STDir_sum_sc.Caption := desSuministro(empresa_sc.text,
        cliente_sal_sc.Text,
        dir_sum_sc.Text);
  (*
     //CLAVE AJENA SUMINISTRO
  if (not (dir_sum_sc.Text = cliente_sal_sc.Text)) then
  begin
    if (Trim(dir_sum_sc.Text) <> '') then
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
  *)
  if Estado = teAlta then
  begin
    if STDir_sum_sc.Caption <> '' then
    if ( nota_sc.Text = '' ) and (Estado = teAlta) then
    begin
      if ( empresa_sc.Text = '050' ) and ( cliente_sal_sc.Text = 'MER' ) then
      begin
        nota_sc.Lines.Add('TEMPERATURA OPTIMA DE +8 A +10 GRADOS.');
        nota_sc.Lines.Add('EQUIPO FRÍO EN FUNCIONAMIENTO: SI.');
        if ( dir_sum_sc.Text = '2MN' ) then
        begin
          nota_sc.Lines.Add(UpperCase('La mercancía transportada realiza tráfico marítimo entre islas'));
        end;
      end
      else
      if ( empresa_sc.Text = '050' ) and ( cliente_sal_sc.Text = 'VTO' ) then
      begin
        nota_sc.Lines.Add(UpperCase('Mercancia procedente de producción controlada y certificada bajo el estándar de calidad Globalgap.'));
      end;
      nota_sc.Lines.Add('-" EL CONDUCTOR CONFIRMA QUE LA MERCANCÍA VA SUJETA POR BARRAS".');
    end;
  end;
end;

procedure TFMSalidasSimple.dir_sum_scExit(Sender: TObject);
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
        end;
      end;
    end;
  end;
  if Estado = teAlta then
  begin
    if STDir_sum_sc.Caption <> '' then
    if ( nota_sc.Text = '' ) and (Estado = teAlta) then
    begin
      if ( empresa_sc.Text = '050' ) and ( cliente_sal_sc.Text = 'MER' ) then
      begin
        nota_sc.Lines.Add('TEMPERATURA OPTIMA DE +8 A +10 GRADOS.');
        nota_sc.Lines.Add('EQUIPO FRÍO EN FUNCIONAMIENTO: SI.');
        if ( dir_sum_sc.Text = '2MN' ) then
        begin
          nota_sc.Lines.Add(UpperCase('La mercancía transportada realiza tráfico marítimo entre islas'));
        end;
      end
      else
      if ( empresa_sc.Text = '050' ) and ( cliente_sal_sc.Text = 'VTO' ) then
      begin
        nota_sc.Lines.Add(UpperCase('Mercancia procedente de producción controlada y certificada bajo el estándar de calidad Globalgap.'));
      end;
      nota_sc.Lines.Add('-" EL CONDUCTOR CONFIRMA QUE LA MERCANCÍA VA SUJETA POR BARRAS".');
    end;
  end;
end;

procedure TFMSalidasSimple.RestaurarCabecera;
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
       {
       DSMaestro.DataSet.FieldByName('n_factura_sc').AsInteger:=SalidaRecord.rN_factura_sc;
       DSMaestro.DataSet.FieldByName('fecha_factura_sc').AsDateTime:=SalidaRecord.rFecha_factura_sc;
       }
  end;
end;

procedure TFMSalidasSimple.ReintentarAlta;
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

procedure TFMSalidasSimple.kilos_slChange(Sender: TObject);
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;
  if bFlagCambios and  kilos_sl.Focused then
    RecalcularUnidades( sender );
end;

procedure TFMSalidasSimple.PonTextoEstaticoDetalle;
begin
  STEnvase_sl.Caption := desEnvase(empresa_sc.Text, envase_sl.Text);
  STcentro_origen_sl.Caption := desCentro(empresa_sc.Text, centro_origen_sl.Text);
  STProducto_sl.Caption := desProducto(empresa_sc.Text, producto_sl.Text);
  STMarca_sl.Caption := desMarca(marca_sl.Text);
  STcategoria_sl.Caption := desCategoria(empresa_sc.Text, producto_sl.Text, categoria_sl.Text);
  STcolor_sl.Caption := desColor(empresa_sc.Text, producto_sl.Text, color_sl.Text);

  if Trim(Moneda_sc.Text) <> '' then
    LImporteTotal.Caption := 'ImporteTotal-' + Moneda_sc.Text
  else
    LImporteTotal.Caption := 'ImporteTotal';

end;

procedure TFMSalidasSimple.ValidarKilosTransitos;
var TotalKilos, SumVendidos, TotalVendidos, Resto: real;
  fechaTrans: TDate;
begin
     //resto:=0;
     //TotalKilos:=0;
  SumVendidos := 0;
  TotalVendidos := 0;
//En este apartado se comprueba que los kilos escogidos de un transito
    //son correcto y no se supera la cantidad tope que hay en las lineas de transitos
  if (Trim(ref_transitos_sl.Text) <> '') and
    (Trim(centro_origen_sl.Text) <> '') then
  begin
        //hallar fecha del transito
    with DMBaseDatos.QGeneral do
    begin
      Close;
      with SQL do
      begin
        Clear;
        Add(' SELECT MAX(fecha_tl) as fecha');
        Add(' FROM frf_transitos_l');
        Add(' WHERE referencia_tl = ' + ref_transitos_sl.Text);
            //Add(' AND centro_tl = '+QuotedStr(centro_origen_sl.Text));
        Add(' AND producto_tl = ' + QuotedStr(producto_sl.Text));
      end;
      try
        Open;
      except
        on E: EDBEngineError do
        begin
          ShowError(e);
          Cancelar;
          Visualizar;
        end;
      end;
      if not isEmpty then
        fechaTrans := FieldByName('fecha').AsFloat
      else
        raise Exception.Create('Tránsito inexistente.');
      Close;
    end;

        //hallar la suma total de kilos utilizados en las salidas provinientes de transitos
    with DMBaseDatos.QGeneral do
    begin
      Close;
      with SQL do
      begin
        Clear;
        Add('SELECT SUM(kilos_sl) as Vendidos');
        Add(' FROM frf_salidas_l');
        Add(' WHERE ref_transitos_sl = ' + ref_transitos_sl.Text);
        Add(' AND producto_sl = ' + QuotedStr(producto_sl.Text));
            //Add(' AND centro_origen_sl = '+QuotedStr(centro_origen_sl.Text));
        Add(' AND fecha_sl >= ' + SQLDate(fechaTrans));
      end;
      try
        Open;
      except
        on E: EDBEngineError do
        begin
          ShowError(e);
          Cancelar;
          Visualizar;
        end;
      end;
          //Suma de los kilos utilizados en las salidas que vienen de transitos
      if not isEmpty then
        SumVendidos := FieldByName('Vendidos').AsFloat;
      Close;
    end;

        //hallar la suma total de kilos utilizados en las transitos provinientes de transitos
    with DMBaseDatos.QGeneral do
    begin
      Close;
      with SQL do
      begin
        Clear;
        Add('SELECT SUM(kilos_tl) as Vendidos');
        Add(' FROM frf_transitos_l');
        Add(' WHERE ref_origen_tl  = ' + ref_transitos_sl.Text);
        Add(' AND producto_tl = ' + QuotedStr(producto_sl.Text));
        Add(' AND fecha_tl >= ' + SQLDate(fechaTrans));
      end;
      try
        Open;
      except
        on E: EDBEngineError do
        begin
          ShowError(e);
          Cancelar;
          Visualizar;
        end;
      end;
          //Suma de los kilos utilizados en las salidas que vienen de transitos
      if not isEmpty then
        SumVendidos := SumVendidos + FieldByName('Vendidos').AsFloat;
      Close;
    end;


    with DMBaseDatos.QGeneral do
    begin
      Close;
      with SQL do
      begin
        Clear;
        Add(' SELECT sum(kilos_tl) as KilosHay');
        Add(' FROM frf_transitos_l');
        Add(' WHERE referencia_tl = ' + ref_transitos_sl.Text);
            //Add(' AND centro_tl = '+QuotedStr(centro_origen_sl.Text));
        Add(' AND producto_tl = ' + QuotedStr(producto_sl.Text));
        Add(' AND fecha_tl = ' + SQLDate(fechaTrans));
      end;
      try
        Open;
      except
        on E: EDBEngineError do
        begin
          ShowError(e);
          Cancelar;
          Visualizar;
        end;
      end;
          //Suma de los kilos utilizados en las salidas que vienen de transitos
      if not isEmpty then
        TotalKilos := FieldByName('KilosHay').AsFloat
      else
        raise Exception.Create('Tránsito sin kilos.');
      Close;
    end;

        //Esto se hace si el EstadoDetalle es modificar
        //restar los kilos que habian para averiguar los kilos que quedan por seleccionar
    if EstadoDetalle = tedModificar then
    begin
           //Le resto los kilos que habian en la linea antes de modificarla
           //y le sumo los kilos que se han seleccionado ahora, para comprobar
           //si se sobrepasa el total de kilos seleccionables.
      TotalVendidos := SumVendidos + (bnStrToFloat(kilos_sl.Text) - bnStrToFloat(KilosTran));
    end;
    if EstadoDetalle in [tedAlta, tedAltaRegresoMaestro] then
    begin
      TotalVendidos := bnStrToFloat(kilos_sl.Text) + SumVendidos;
    end;
        //Compruebo que no se sobrepase el total de kilos de transitos
        //TotalVendido = la suma de los kilos ya grabados con la cantidad que intento introducir ahora
        //TotalKilos = proviene de la linea de transitos
        //SumVendidos = los kilos que ya estan grabados
        //Resto = si todavia quedan kilos por vender del transito digo cuantos son
        //      en el mensaje de error.
    if TotalKilos < TotalVendidos then
    begin
      Resto := TotalVendidos - TotalKilos;
      raise Exception.Create('Se ha excedido el número de kilos seleccionables.' +
        'Sobran ' + floatToStr(Resto) + ' kilogramos.');

    end;
  end;
end;

procedure TFMSalidasSimple.ref_transitos_slEnter(Sender: TObject);
begin
  if TSalidasL.State = dsEdit then
  begin
    try
      ValidarKilosTransitos;
    except
      on e: Exception do
      begin
        ShowError(e);
      end;
    end;
  end;
end;

procedure TFMSalidasSimple.centro_origen_slExit(Sender: TObject);
begin
  //Existe el centro para el transito
  if (DSDetalle.State = dsInsert) and
    (Trim(ref_transitos_sl.Text) <> '') and
    (Trim(centro_origen_sl.Text) <> '') then
    with DMBaseDatos.QGeneral do
    begin
      Cancel;
      Close;
      with SQL do
      begin
        Clear;
        Add(' SELECT UNIQUE producto_tl');
        Add(' FROM frf_transitos_l');
        Add(' WHERE referencia_tl = ' + ref_transitos_sl.Text);
        Add(' AND empresa_tl = ' + QuotedStr(empresa_sc.Text));
(*
          //Add(' AND centro_tl = '+QuotedStr(centro_origen_sl.Text));
          //La fecha del transito es anterior a la de la salida
          Add(' AND fecha_tl <= '+SQLDate(fecha_sc.Text));
          //Entre la fecha de la salida y el transito no han podido transcurrir mas de un mes,
          //pero para curarnos en salud ponemos dos
          Add(' AND '+SQLDate(fecha_sc.Text)+' - fecha_tl < 90');
*)
      end;
      try
        Open;
      except
        on E: EDBEngineError do
        begin
          ShowError(e);
          ref_transitos_sl.SetFocus;
          Exit;
        end;
      end;
       //Tiene Valores
      case RecordCount of
        0:
          begin
            ShowError('Centro no válido parar la reférencia de tránsito actual.');
            centro_origen_sl.SetFocus;
            Exit;
          end;
        1:
          begin
           //Rellenar centro, pasar a producto
            producto_sl.Text := FieldByName('producto_tl').AsString;
          end;
      end;
    end;
end;

procedure TFMSalidasSimple.TransitoCorrecto;
var
  dFecha: TDateTime;
begin
  if not TryStrToDate( edtfecha_transito_sl.Text, dFecha ) then
  begin
    raise Exception.Create('Falta la fecha del tránsito o es incorrecta.');
  end;
  if StrToDate( fecha_sc.Text ) < dFecha then
  begin
    raise Exception.Create('La fecha de la salida no puede ser inferior a la del tránsito.');
  end;
  with DMBaseDatos.QGeneral do
  begin
    Cancel;
    Close;
    with SQL do
    begin
      Clear;
      Add(' SELECT fecha_tl');
      Add(' FROM frf_transitos_l');
      Add(' WHERE empresa_tl = ' + QuotedStr(empresa_sc.Text));
      Add(' AND referencia_tl = ' + ref_transitos_sl.Text);
      Add(' AND fecha_tl = :fecha');
      Add(' AND centro_tl = ' + QuotedStr(edtcentro_transito_sl.Text));
      Add(' AND producto_tl = ' + QuotedStr(producto_sl.Text));
      ParamByName('fecha').AsDate:= StrToDate( edtfecha_transito_sl.Text );
    end;
    try
      Open;

    except
      Close;
      ref_transitos_sl.SetFocus;
      raise Exception.Create('Imposible comprobar validez del tránsito.');
    end;

       //Tiene Valores
    if isEmpty then
    begin
      Close;
      ref_transitos_sl.SetFocus;
      raise Exception.Create('Tránsito incorrecto.');
    end;
    Close;
  end;
end;


function TFMSalidasSimple.esClienteExtranjero(codEmp: string; codCliente: string): Boolean;
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


procedure TFMSalidasSimple.importe_neto_slChange(Sender: TObject);
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;
  if bFlagCambios and  importe_neto_sl.Focused then
    RecalcularUnidades( sender, True );
end;

procedure TFMSalidasSimple.RecalcularUnidades( const ASender: TObject; const AImporte: boolean = false );
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
    STUnidades.Caption := FormatFloat('#0.00', iUnidadesLinea );
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

procedure TFMSalidasSimple.EnvaseInicial;
var
  iUnidadesCaja: integer;
  iUnidadesLinea, iCajasLinea: Integer;
begin
  STEnvase_sl.Caption := desEnvase(empresa_sc.Text, envase_sl.Text);

  unidad_precio_sl.Text := unidadFacturacion(empresa_sc.text, cliente_sal_sc.text,
     producto_sl.Text, envase_sl.Text);
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
  STUnidades.Caption := FormatFloat('#0.00', iUnidadesLinea );
end;

procedure TFMSalidasSimple.CambioDeEnvase(Sender: TObject);
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
procedure TFMSalidasSimple.CambioProducto(Sender: TObject);
begin
  //SÓLO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((DSDetalle.State <> dsEdit) and (DSDetalle.State <> dsInsert)) then
    Exit;

  PonNombre(Sender);
  PonNombre( color_sl );
  PonNombre( categoria_sl );
  if Length( envase_sl.Text ) >= 3 then
    CambioDeEnvase( envase_SL );
end;

procedure TFMSalidasSimple.AMenuEmergenteExecute(Sender: TObject);
begin
  MessageDlg(IntToStr(RVisualizacion.SelectedRows.Count), mtInformation, [], 0);
end;


///////////////////////////////////////////////////////////////////
//                                                               //
//   EVENTOS ASOCIADOS A LA QUERY                                //
//                                                               //
///////////////////////////////////////////////////////////////////

procedure TFMSalidasSimple.QSalidasCBeforePost(DataSet: TDataSet);
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
procedure TFMSalidasSimple.QSalidasCAfterPost(DataSet: TDataSet);
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
  end;
  ActualizarMatricula;
end;

procedure TFMSalidasSimple.ActualizarMatricula;
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

procedure TFMSalidasSimple.QSalidasCPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  //Cancelar transaccion
  {if  TQuery(DataSet).DataBase.InTransaction then
      TQuery(DataSet).DataBase.Rollback;}
end;

procedure TFMSalidasSimple.QSalidasCAfterEdit(DataSet: TDataSet);
begin
  CargaRegistro;
end;

///////////////////////////////////////////////////////////////////
//                                                               //
///////////////////////////////////////////////////////////////////

procedure TFMSalidasSimple.CargaRegistro;
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
    rTransporte_sc := FieldByName('transporte_sc').AsInteger;
    rOperadorTransporte_sc := FieldByName('operador_transporte_sc').AsInteger;
    rVehiculo_sc := FieldByName('vehiculo_sc').AsString;
    {
    rN_factura_sc:=FieldByName('n_factura_sc').AsInteger;
    rFecha_factura_sc:=FieldByName('fecha_factura_sc').AsDateTime;
    rDua_sc:=FieldByName('dua_sc').AsString;
    rFecha_dua_sc:=FieldByName('fecha_dua_sc').AsDateTime;
    }
  end;
end;

function TFMSalidasSimple.unidadFacturacion(const empresa, cliente,
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
        showMessage(empresa + '-' + cliente + '-' + producto + '-' + envase + '-' + sProductoBase );
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


procedure TFMSalidasSimple.TSalidasLNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('emp_procedencia_sl').AsString := empresa_sc.Text;
  DataSet.FieldByName('comercial_sl').AsString := UDMMaster.DMMaster.GetCodeComercial( empresa_sc.Text, cliente_sal_sc.Text );
end;

procedure TFMSalidasSimple.AplicaFiltro(const AFiltro: string);
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

procedure TFMSalidasSimple.DSDetalleStateChange(Sender: TObject);
begin
  if DSDetalle.State = dsEdit then
    oldEnvase := envase_sl.Text
  else
    oldEnvase := '';
end;

procedure TFMSalidasSimple.porte_bonny_scEnter(Sender: TObject);
begin
  TDBCheckBox( Sender ).Color:= clMoneyGreen;
end;

procedure TFMSalidasSimple.porte_bonny_scExit(Sender: TObject);
begin
  TDBCheckBox( Sender ).Color:= clBtnFace;
end;

procedure TFMSalidasSimple.QSalidasCNewRecord(DataSet: TDataSet);
begin
  if (Estado <> teAlta) then
  begin
    //QSalidasC.FieldByName('porte_bonny_sc').AsInteger:= 0;
    QSalidasC.FieldByName('higiene_sc').AsInteger:= 1;
    QSalidasC.FieldByName('reclamacion_sc').AsInteger:= 0;
    oldMatricula:= '';
  end
  else
  begin
    QSalidasC.FieldByName('es_transito_sc').AsInteger:= 0;
  end;
end;

procedure TFMSalidasSimple.QSalidasCBeforeEdit(DataSet: TDataSet);
begin
  oldMatricula:= QSalidasC.FieldByName('vehiculo_sc').AsString
end;

function TFMSalidasSimple.EstoyFacturada: boolean;
begin
  result:= Trim(n_factura_sc.Text) <> '';
end;

function TFMSalidasSimple.EstoyContabilizada: boolean;
begin
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

procedure TFMSalidasSimple.AntesDeBorrarDetalle;
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

procedure TFMSalidasSimple.Button1Click(Sender: TObject);
begin
  if not MantenimientoGastos then
    ShowMessage('Debe tener una entrega seleccionada y en modo de visualización.');
end;

function TFMSalidasSimple.MantenimientoGastos: boolean;
begin
  result:= false;
  if ( Estado = teConjuntoResultado ) and not DSMaestro.DataSet.IsEmpty then
  begin
    // Mantenimiento de Gastos por Salida...
    if (Estado = teConjuntoResultado) then
    begin
      if estoyContabilizada then
      begin
        ShowError('La salida ya esta asociada a una factura contabilizada. Recuerde que sólo debe modificar gastos no facturables.');
        MantenimientoGastosEx( False );
        result:= True;
      end
      else
      if estoyFacturada then
      begin
        ShowMessage('Albarán asociado a una factura, recuerde repetirla si añade gastos facturables.');
        MantenimientoGastosEx( True );
        result:= True;
      end
      else
      begin
        MantenimientoGastosEx( True );
        result:= True;
      end;
    end;
  end;
end;

procedure TFMSalidasSimple.MantenimientoGastosEx( const AFacturable: boolean );
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
      'fecha_tg,tipo_tg,importe_tg,usuario_tg,ref_fac_tg,fecha_fac_tg, producto_tg, solo_lectura_tg ) ');
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


    FMGastosSalida.sEmpresa := empresa_sc.Text;
    FMGastosSalida.empNom := empresa_sc.Text + ' - ' + STEmpresa_sc.Caption;
    FMGastosSalida.sCentro := centro_salida_sc.Text;
    FMGastosSalida.cenNom := STCentro_salida_sc.Caption;
    FMGastosSalida.sAlbaran := n_albaran_sc.Text;
    FMGastosSalida.sFecha := fecha_sc.Text;
    FMGastosSalida.STEmpresa.Caption := FMGastosSalida.empNom;
    FMGastosSalida.STCentro.Caption := FMGastosSalida.cenNom;
    FMGastosSalida.STAlbaran.Caption := FMGastosSalida.sAlbaran;
    FMGastosSalida.STFecha.Caption := FMGastosSalida.sFecha;
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

procedure TFMSalidasSimple.tipo_palets_slChange(Sender: TObject);
begin
  stTipoPalets.Caption:= desTipoPalet( tipo_palets_sl.Text );
end;

procedure TFMSalidasSimple.btnFacturaClick(Sender: TObject);
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

procedure TFMSalidasSimple.DesasignarAlbFac;
begin
  if Application.MessageBox('¿Seguro que quiere romper el enlace entre el albarán actual y su factura asociada.?' + #13 + #10 +
                            'Recuerde repetir la factura para que el cambio se vea reflejado.',
                            'Desasociar factura.', MB_YESNO ) = IDNO then
    Exit;
  DSMaestro.DataSet.Edit;
  DSMaestro.DataSet.FieldByName('n_factura_sc').Value:= NULL;
  DSMaestro.DataSet.FieldByName('fecha_factura_sc').Value:= NULL;
  DSMaestro.DataSet.Post;
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

procedure TFMSalidasSimple.AsignarAlbFac;
var
  sEmpresa: string;
  dFecha: TDateTime;
  iFactura: Integer;
begin
  sEmpresa:= empresa_sc.Text;
  dFecha:= Date;
  ifactura:= 0;
  if GetFacturaAsignar( sEmpresa, dFecha, iFactura) then
  begin
    if ExisteFactura( sEmpresa, dFecha, iFactura ) then
    begin
      DSMaestro.DataSet.Edit;
      DSMaestro.DataSet.FieldByName('n_factura_sc').AsInteger:= iFactura;
      DSMaestro.DataSet.FieldByName('fecha_factura_sc').AsDateTime:= dFecha;
      DSMaestro.DataSet.Post;
    end
    else
    begin
      ShowMessage('No se puede asignar un albarán a una factura inexistente.');
    end;
  end;
end;

(*IVA*)
procedure TFMSalidasSimple.TSalidasLAfterDelete(DataSet: TDataSet);
begin
  CDAsignarGastosServicioVenta.ActualizarEstadoServicio_( QSalidasC.FieldBYName('empresa_sc').AsString,
                                                         QSalidasC.FieldBYName('centro_salida_sc').AsString,
                                                         QSalidasC.FieldBYName('n_albaran_sc').AsInteger,
                                                         QSalidasC.FieldBYName('fecha_sc').AsDateTime );
end;

procedure TFMSalidasSimple.TSalidasLAfterPost(DataSet: TDataSet);
begin
  CDAsignarGastosServicioVenta.ActualizarEstadoServicio_( QSalidasC.FieldBYName('empresa_sc').AsString,
                                                         QSalidasC.FieldBYName('centro_salida_sc').AsString,
                                                         QSalidasC.FieldBYName('n_albaran_sc').AsInteger,
                                                         QSalidasC.FieldBYName('fecha_sc').AsDateTime );
end;

procedure TFMSalidasSimple.incoterm_scChange(Sender: TObject);
begin
  stIncoterm.Caption:= desIncoterm( incoterm_sc.Text );
end;

procedure TFMSalidasSimple.porte_bonny_scClick(Sender: TObject);
begin
  //si el porte la pagamos nosotros ponemos el grabado por defecto
  if porte_bonny_sc.Checked and ( incoterm_sc.Text = '' ) then
  begin
    PonerIncotermPorDefecto;
  end;
end;

procedure TFMSalidasSimple.PonerIncotermPorDefecto;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select incoterm_c, plaza_incoterm_c ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add(' and cliente_c = :cliente ');
    ParamByName('empresa').AsString:= empresa_sc.Text;
    ParamByName('cliente').AsString:= cliente_sal_sc.Text;
    Open;
    if FieldByname('incoterm_c').AsString <> '' then
    begin
      incoterm_sc.Text:= FieldByname('incoterm_c').AsString;
      plaza_incoterm_sc.Text:= FieldByname('plaza_incoterm_c').AsString;
    end;
    Close;
  end;
end;

procedure TFMSalidasSimple.comercial_slChange(Sender: TObject);
begin
  txtDesComercial.Caption:= UDMMaster.DMMaster.desComercial( comercial_sl.Text );
end;

procedure TFMSalidasSimple.mniAsignarTrnsito1Click(Sender: TObject);
begin
  if QSalidasC.IsEmpty then
  begin
    ShowMessage('Seleccione primero una salida');
  end
  else
  begin
    if TSalidasL.FieldByName('ref_transitos_sl').AsString <> ''then
      ShowMessage('La salida ya esta asignada a un tránsito')
    else
      AsignarTransitoFD.AsignarTransito( TSalidasL );
  end;
end;

procedure TFMSalidasSimple.es_transito_scChange(Sender: TObject);
begin
   stxtTipoVenta.Caption := desTipoSalida( es_transito_sc.Text );
end;

end.
