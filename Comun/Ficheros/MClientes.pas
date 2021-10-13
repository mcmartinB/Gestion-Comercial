unit MClientes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  ComCtrls, BEdit, CVariables, derror, DBTables;

const
  kNavigation: Integer = 0;
  kEditCab: Integer = 1;
  kEditDet: Integer = 2;

type
  TFMClientes = class(TMaestroDetalle)
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    DSDetalle: TDataSource;
    RejillaFlotante: TBGrid;
    PDetalle2: TPanel;
    QDirClientes: TQuery;
    DSSuministros: TDataSource;
    DSDescuentos: TDataSource;
    PMaestro: TPanel;
    Pago: TPanel;
    Label2: TLabel;
    BGBtipo_via_c: TBGridButton;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    BGBpais_c: TBGridButton;
    Label10: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    BGBrepresentante_c: TBGridButton;
    Label5: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label28: TLabel;
    lblNotas: TLabel;
    tipo_via_c: TBDEdit;
    domicilio_c: TBDEdit;
    poblacion_c: TBDEdit;
    pais_c: TBDEdit;
    cod_postal_c: TBDEdit;
    STProvincia: TStaticText;
    STPais_c: TStaticText;
    telefono_c: TBDEdit;
    nif_c: TBDEdit;
    representante_c: TBDEdit;
    STRepresentante_c: TStaticText;
    resp_compras_c: TBDEdit;
    es_comunitario_c: TDBCheckBox;
    n_copias_alb_c: TBDEdit;
    email_alb_c: TBDEdit;
    telefono2_c: TBDEdit;
    fax_c: TBDEdit;
    notas_c: TDBMemo;
    pnlDerecho: TPanel;
    Label13: TLabel;
    BGBDirFactura: TBGridButton;
    Label19: TLabel;
    Label20: TLabel;
    BGBPaisFactura: TBGridButton;
    Label18: TLabel;
    Label24: TLabel;
    Label17: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    BGBincoterm_c: TBGridButton;
    lblNombre3: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    lblFEcha: TLabel;
    tipo_via_fac_c: TBDEdit;
    domicilio_fac_c: TBDEdit;
    cod_postal_fac_c: TBDEdit;
    STProvinciaFactura: TStaticText;
    pais_fac_c: TBDEdit;
    STPaisFactura: TStaticText;
    poblacion_fac_c: TBDEdit;
    email_fac_c: TBDEdit;
    n_copias_fac_c: TBDEdit;
    edi_c: TDBCheckBox;
    incoterm_c: TBDEdit;
    plaza_incoterm_c: TBDEdit;
    stIncoterm: TStaticText;
    cta_ingresos_pgc_c: TBDEdit;
    max_riesgo_c: TBDEdit;
    fecha_riesgo_c: TBDEdit;
    seguro_c: TDBCheckBox;
    pnlSuperior: TPanel;
    LEmpresa_p: TLabel;
    cliente_c: TBDEdit;
    nombre_c: TBDEdit;
    lblNombre2: TLabel;
    cta_cliente_c: TBDEdit;
    Label9: TLabel;
    moneda_c: TBDEdit;
    BGBmoneda_c: TBGridButton;
    STMoneda_c: TStaticText;
    pgcDetalle: TPageControl;
    tsSuministro: TTabSheet;
    tsDescuentos: TTabSheet;
    tsUnidades: TTabSheet;
    pnlCabDetalle: TPanel;
    LCliente: TLabel;
    stCodCliente: TStaticText;
    STCliente_: TStaticText;
    LDireccionD: TLabel;
    LNombreD: TLabel;
    LDomicilioD: TLabel;
    LCodPosD: TLabel;
    LPoblacionD: TLabel;
    LTelefonoD: TLabel;
    BGBtipo_via_ds: TBGridButton;
    Label22: TLabel;
    dir_sum_ds: TBDEdit;
    nombre_ds: TBDEdit;
    tipo_via_ds: TBDEdit;
    domicilio_ds: TBDEdit;
    cod_postal_ds: TBDEdit;
    poblacion_ds: TBDEdit;
    telefono_ds: TBDEdit;
    STProvinciaD: TStaticText;
    provincia_ds: TBDEdit;
    pais_ds: TBDEdit;
    STPaisD: TStaticText;
    btnDescuentos: TBitBtn;
    BtnUniFac: TBitBtn;
    tsFormaPago: TTabSheet;
    pnlFormaPago: TPanel;
    txtst2: TStaticText;
    txtst3: TStaticText;
    txtst4: TStaticText;
    txtst5: TStaticText;
    txtst6: TStaticText;
    txtst7: TStaticText;
    txtst8: TStaticText;
    txtst9: TStaticText;
    QAuxCli: TQuery;
    QUnidades: TQuery;
    strngfldQUnidadesempresa_ce: TStringField;
    strngfldQUnidadesenvase_ce: TStringField;
    strngfldQUnidadescliente_ce: TStringField;
    strngfldQUnidadesunidad_fac_ce: TStringField;
    strngfldQUnidadesdescripcion_ce: TStringField;
    QUnidadesn_palets_ce: TSmallintField;
    QUnidadeskgs_palet_ce: TSmallintField;
    DSUnidades: TDataSource;
    DBGrid: TDBGrid;
    DBGridPalets: TDBGrid;
    tsRecargo: TTabSheet;
    QRecargo: TQuery;
    DSRecargo: TDataSource;
    dbgRecargo: TDBGrid;
    btnRecargo: TBitBtn;
    lblCuentaAnalitica: TLabel;
    cta_ingresos_pga_c: TBDEdit;
    lblBanco: TLabel;
    LAno_semana_p: TLabel;
    banco_c: TBDEdit;
    forma_pago_c: TBDEdit;
    btnBanco: TBGridButton;
    BGBforma_pago_c: TBGridButton;
    txtBanco: TStaticText;
    txtst1: TStaticText;
    txtst11: TStaticText;
    lblNif: TLabel;
    nif_ds: TBDEdit;
    lblEmail: TLabel;
    Email_ds: TBDEdit;
    lblcip: TLabel;
    cip_c: TBDEdit;
    lblIvaWeb: TLabel;
    dbgrdComisiones: TDBGrid;
    intgrfldQUnidadescaducidad_cliente_ce: TIntegerField;
    intgrfldQUnidadesmin_vida_cliente_ce: TIntegerField;
    intgrfldQUnidadesmax_vida_cliente_ce: TIntegerField;
    strngfldQUnidadesdes_envase: TStringField;
    dbgrdCaducidad: TDBGrid;
    lbl6: TLabel;
    tipo_cliente_c: TBDEdit;
    btnTipoCliente: TBGridButton;
    stTipoCliente: TStaticText;
    grabrar_transporte_c: TDBCheckBox;
    tipo_albaran_c: TDBComboBox;
    des_tipo_albaran_c: TStaticText;
    lblTipoAlbaran: TLabel;
    btnProducto: TBitBtn;
    lbl5: TLabel;
    rbDescuentosTodos: TRadioButton;
    rbDescuentosActivos: TRadioButton;
    lbl7: TLabel;
    email_fac_ds: TBDEdit;
    lblTesoreria: TLabel;
    dias_tesoreria_c: TBDEdit;
    QClientes: TQuery;
    QDescuentos: TQuery;
    dbgFormaPago: TDBGrid;
    DSTesoreria: TDataSource;
    QTesoreria: TQuery;
    DSMaestro: TDataSource;
    btnFormasPago: TBitBtn;
    QTesoreriaempresa_ct: TStringField;
    QTesoreriacliente_ct: TStringField;
    QTesoreriabanco_ct: TStringField;
    QTesoreriaforma_pago_ct: TStringField;
    iQTesoreriadias_tesoreria_ct: TIntegerField;
    QTesoreriades_banco: TStringField;
    ts1: TTabSheet;
    dbgRiesgo: TDBGrid;
    btnRiesgo: TBitBtn;
    dsRiesgo: TDataSource;
    QRiesgo: TQuery;
    QRiesgoempresa_cr: TStringField;
    QRiesgocliente_cr: TStringField;
    QRiesgomax_riesgo_cr: TFloatField;
    QRiesgofecha_riesgo_cr: TDateField;
    QRiesgoseguro: TStringField;
    forma_pago_ct: TBDEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    QRiesgofecha_fin_cr: TDateField;
    rbRiesgosActivos: TRadioButton;
    rbRiesgosTodos: TRadioButton;
    QUnidadesproducto_ce: TStringField;
    periodo_factura_c: TDBComboBox;
    Label1: TLabel;
    tsGastos: TTabSheet;
    DBGrid1: TDBGrid;
    dsGastos: TDataSource;
    qGastos: TQuery;
    rbGastosActivos: TRadioButton;
    rbGastosTodos: TRadioButton;
    btnGastos: TBitBtn;
    lblNombre8: TLabel;
    fecha_baja_ds: TBDEdit;
    Panel1: TPanel;
    RVisualizacion: TDBGrid;
    rbSuministroActivos: TRadioButton;
    rbSuministroBaja: TRadioButton;
    rbSuministroTodos: TRadioButton;
    QSuministro: TQuery;
    QSuministrofecha_baja_ds: TDateField;
    QSuministroemail_fac_ds: TStringField;
    QSuministrodir_sum_ds: TStringField;
    QSuministronombre_ds: TStringField;
    QSuministronif_ds: TStringField;
    QSuministrotipo_via_ds: TStringField;
    QSuministrodomicilio_ds: TStringField;
    QSuministrocod_postal_ds: TStringField;
    QSuministroprovincia_ds: TStringField;
    QSuministropoblacion_ds: TStringField;
    QSuministropais_ds: TStringField;
    QSuministrotelefono_ds: TStringField;
    QSuministroemail_ds: TStringField;
    QSuministroprovincia_esp_ds: TStringField;
    QSuministrodes_pais_ds: TStringField;
    QSuministrocliente_ds: TStringField;
    Label11: TLabel;
    plataforma_ds: TBDEdit;
    QSuministroplataforma_ds: TStringField;
    lbl8: TLabel;
    eori_cliente_c: TBDEdit;
    albaran_factura_c: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure TSuministrosCalcFields(DataSet: TDataSet);
    procedure BtnUniFacClick(Sender: TObject);
    procedure QClientesAfterOpen(DataSet: TDataSet);
    procedure QClientesBeforeClose(DataSet: TDataSet);
    procedure btnDescuentosClick(Sender: TObject);
    procedure incoterm_cChange(Sender: TObject);
    procedure banco_cChange(Sender: TObject);
    procedure forma_pago_cChange(Sender: TObject);
    procedure moneda_cChange(Sender: TObject);
    procedure cliente_cChange(Sender: TObject);
    procedure QClientesAfterPost(DataSet: TDataSet);
    procedure pais_cChange(Sender: TObject);
    procedure cod_postal_cChange(Sender: TObject);
    procedure pais_fac_cChange(Sender: TObject);
    procedure cod_postal_fac_cChange(Sender: TObject);
    procedure representante_cChange(Sender: TObject);
    procedure btnRecargoClick(Sender: TObject);
    procedure pais_dsChange(Sender: TObject);
    procedure cod_postal_dsChange(Sender: TObject);
    procedure TSuministrosAfterEdit(DataSet: TDataSet);
    procedure dir_sum_dsChange(Sender: TObject);
    procedure QUnidadesCalcFields(DataSet: TDataSet);
    procedure tipo_cliente_cChange(Sender: TObject);
    procedure tipo_albaran_cChange(Sender: TObject);
    procedure QClientesAfterScroll(DataSet: TDataSet);
    procedure btnProductoClick(Sender: TObject);
    procedure rbVerDescuentosClick(Sender: TObject);
    procedure QTesoreriaCalcFields(DataSet: TDataSet);
    procedure btnFormasPagoClick(Sender: TObject);
    procedure btnRiesgoClick(Sender: TObject);
    procedure DSTesoreriaDataChange(Sender: TObject; Field: TField);
    procedure rbRiesgosActivosClick(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
    procedure rbVerGastosClick(Sender: TObject);
    procedure btnGastosClick(Sender: TObject);
    procedure rbVerDireccionActivos(Sender: TObject);
    procedure QSuministroCalcFields(DataSet: TDataSet);
    procedure albaran_factura_cChange(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes: TList;
    ListaDetalle: TList;
    Objeto: TObject;
    bAltaDetalles: boolean;

    FRegistroABorrarClienteId: String;
    FRegistroABorrarDireccionId: String;

    procedure VerDetalle;
    procedure EditarDetalle;
    procedure AntesDeBorrarDetalle;
    procedure AntesDeBorrarMaestro;
    procedure DespuesDeBorrarMaestro;
    procedure DespuesDeBorrarDetalle;
    procedure ValidarEntradaDetalle;
    procedure RellenaClaveDetalle;
    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;
    procedure PonPaneles( const ATipo: Integer );
    procedure CambioRegistro;

  protected
    procedure SincronizarWeb; override;
    procedure SincronizarDetalleWeb; override;

  public
    { Public declarations }

    //SOBREESCRIBIR METODO
    procedure Altas; override;
    procedure Filtro; override;
    procedure AnyadirRegistro; override;
    procedure DetalleAltas; override;

    procedure AntesDeInsertar;
    procedure AntesDeLocalizar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    procedure TSuministrosBeforePost(DataSet: TDataSet);
    procedure QSuministroBeforePost(DataSet: TDataSet);

    //Listado
    procedure Previsualizar; override;

    procedure Restaurar;
  private

  end;

implementation

uses ShellApi, CGestionPrincipal, UDMBaseDatos, DPreview, CAuxiliarDB, Principal,
     LClientes, UDMAuxDB, bSQLUtils, CReportes, Variants, CliEnvases,
     DescuentosClientesProductoFD,     UDMConfig, DescuentosClientesFD, TesoreriaClientesFD, RecargoClientesFD,
     UFFormaPago, UDMMaster, SeleccionarClonarSuministroFD, SeleccionarClonarClienteFD,
     SeleccionarProductoFD, RiesgoClientesFD, GastosClientesFD,
     SincronizacionBonny;

{$R *.DFM}

(*
dos altas cliente
alta detalle
cancelar
donde est la cab
*)

procedure TFMClientes.AbrirTablas;
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

  if not DataSourceDetalle.DataSet.Active then
    DataSourceDetalle.DataSet.Open;

     //Estado inicial
  Registros := DataSetMaestro.RecordCount;
  if Registros > 0 then
    Registro := 1
  else
    Registros := 0;
  RegistrosInsertados := 0;
end;

procedure TFMClientes.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery(QDirClientes);
  bnCloseQuerys([DataSourceDetalle.DataSet, DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMClientes.FormCreate(Sender: TObject);
begin
  bAltaDetalles:= True;
  PonPaneles( kNavigation );
  with QDescuentos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_dc empresa, fecha_ini_dc fecha_ini, fecha_fin_dc fecha_fin,');
    SQL.Add('        '''' centro, '''' cod_producto, '''' producto, ');
    SQL.Add('        facturable_dc porcen_facturable, no_fact_bruto_dc porcen_no_fact_bruto, no_fact_neto_dc porcen_no_fact_neto, ');
    SQL.Add('        eurkg_facturable_dc eurkg_facturable, eurkg_no_facturable_dc eurkg_no_facturable, ');
    SQL.Add('        eurpale_facturable_dc eurpale_facturable, eurpale_no_facturable_dc eurpale_no_facturable ');
    SQL.Add(' from frf_descuentos_cliente ');
    SQL.Add(' where cliente_dc = :cliente_c ');

    SQL.Add(' union ');

    SQL.Add(' select empresa_dp empresa, fecha_ini_dp fecha_ini, fecha_fin_dp fecha_fin,');
    SQL.Add('        '''' centro,  producto_dp cod_producto, producto_dp || '' - '' || descripcion_p producto, ');
    SQL.Add('        facturable_dp porcen_facturable, no_fact_bruto_dp porcen_no_fact_bruto, no_fact_neto_dp porcen_no_fact_neto, ');
    SQL.Add('        eurkg_facturable_dp eurkg_facturable, eurkg_no_facturable_dp eurkg_no_facturable, ');
    SQL.Add('        eurpale_facturable_dp eurpale_facturable, eurpale_no_facturable_dp eurpale_no_facturable ');
    SQL.Add(' from frf_descuentos_producto ');
    SQL.Add('      join frf_productos on producto_p = producto_dp ');
    SQL.Add(' where cliente_dp = :cliente_c ');

    SQL.Add(' union ');

    SQL.Add(' select empresa_dc empresa, fecha_ini_dc fecha_ini, fecha_fin_dc fecha_fin, ');
    SQL.Add('        centro_dc || '' - '' || descripcion_c centro, '''' cod_producto, ''TODOS LOS PRODUCTOS'' producto, ');
    SQL.Add('        facturable_dc porcen_facturable, no_fact_bruto_dc porcen_no_fact_bruto, no_fact_neto_dc porcen_no_fact_neto, ');
    SQL.Add('        eurkg_facturable_dc eurkg_facturable, eurkg_no_facturable_dc eurkg_no_facturable, ');
    SQL.Add('        eurpale_facturable_dc eurpale_facturable, eurpale_no_facturable_dc eurpale_no_facturable ');
    SQL.Add(' from frf_descuentos_centro ');
    SQL.Add('      join frf_centros on empresa_c = empresa_dc and centro_c = centro_dc ');
    SQL.Add(' where cliente_dc = :cliente_c ');
    //SQL.Add(' and fecha_fin_dc is null ');

    SQL.Add(' union ');

    SQL.Add(' select '''' empresa, fecha_ini_rc fecha_ini, fecha_ini_rc fecha_ini, ');
    SQL.Add('        '''' centro,  '''' cod_producto, representante_r || '' - '' || descripcion_r producto, ');
    SQL.Add('        comision_rc porcen_facturable, 0 porcen_no_fact_bruto, 0 porcen_no_fact_neto,');
    SQL.Add('        0 eurkg_facturable, 0 eurkg_no_facturable, ');
    SQL.Add('        0 eurpale_facturable, 0 eurpale_no_facturable ');
    SQL.Add(' from frf_representantes_comision ');
    SQL.Add('      join frf_representantes on representante_r = representante_rc ');
    SQL.Add(' where representante_rc = :representante_c ');
    //SQL.Add(' and fecha_fin_rc is null ');

    SQL.Add(' order by empresa, producto, fecha_ini desc ');


    if not Prepared then
      Prepare;
    Filtered:= True;
    filter:= 'fecha_fin is null';

  end;
  with QRecargo do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_irc empresa, case when recargo_irc = 0 then ''NO'' else ''SI'' end recargo, ');
    SQL.Add('        fecha_ini_irc inicio, fecha_fin_irc fin ');
    SQL.Add(' from frf_impuestos_recargo_cli ');
    SQL.Add(' where cliente_irc = :cliente_c ');
    SQL.Add(' order by inicio desc ');
    if not Prepared then
      Prepare;
 end;
  with QUnidades do
  begin
    SQL.Clear;
//    SQl.Add(' Select empresa_ce, producto_ce, envase_ce, cliente_ce, unidad_fac_ce, descripcion_ce, ');
//    SQL.Add('        n_palets_ce, kgs_palet_ce, caducidad_cliente_ce, min_vida_cliente_ce, max_vida_cliente_ce  ');
    SQL.Add(' select *  from  frf_clientes_env');
    SQl.Add(' where cliente_ce = :cliente_c ');
    SQL.Add(' order by empresa_ce, producto_ce, envase_ce ');

    if not Prepared then
      Prepare;
  end;

  with QTesoreria do
  begin
    SQL.Clear;
    SQl.Add('Select * from frf_clientes_tes');
    SQl.Add('where cliente_ct = :cliente_c ');
    SQL.Add(' order by empresa_ct ');

    if not Prepared then
      Prepare;
  end;

  with QRiesgo do
  begin
    SQL.Clear;
    SQl.Add('Select empresa_cr, cliente_cr, max_riesgo_cr, fecha_riesgo_cr, fecha_fin_cr, case when seguro_cr = 0 then ''NO'' else ''SI'' end seguro ');
    SQL.Add('  from frf_clientes_rie ');
    SQl.Add('where cliente_cr = :cliente_c ');
    SQL.Add(' order by empresa_cr ');

    if not Prepared then
      Prepare;

    Filtered:= True;
    filter:= 'fecha_fin_cr is null';

  end;

    with QGastos do
  begin
    SQL.Clear;
    SQl.Add('Select empresa_gc, cliente_gc, fecha_ini_gc, fecha_fin_gc, no_facturable_gc ');
    SQL.Add('  from frf_gastos_cliente ');
    SQl.Add('where cliente_gc = :cliente_c ');
    SQL.Add(' order by empresa_gc ');

    if not Prepared then
      Prepare;

    Filtered:= True;
    Filter:= 'fecha_fin_gc is null';

  end;

  with QSuministro do
  begin
    SQL.Clear;
//    SQl.Add('Select cliente_ds, dir_sum_ds, domicilio_ds, cod_postal_ds, poblacion_ds, telefono_ds, fecha_baja_ds ');
    SQl.Add('Select * ');
    SQL.Add('  from frf_dir_sum ');
    SQl.Add('where cliente_ds = :cliente_c ');
    SQL.Add(' order by dir_sum_ds ');

    if not Prepared then
      Prepare;

    Filtered:= True;
    filter:= 'fecha_baja_ds is null';
  end;


//  TSuministros.Filtered:= True;
//  TSuministros.filter:= 'fecha_baja_ds is null';

  LineasObligadas := True;
  ListadoObligado := false;

     // INICIO
  Height := 25;
  Width := 200;

     //Titulo
  Self.Caption := 'CLIENTES';

     //Variables globales
  M := Self;
  MD := Self;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PanelDetalle := pnlCabDetalle;
  RejillaVisualizacion := RVisualizacion;

     //Fuente de datos
 {+}DataSetMaestro := QClientes;
  DataSourceDetalle := DSDetalle;
  RVisualizacion.DataSource := DSDetalle;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_clientes ';
 {+}where := ' WHERE cliente_c=' + QuotedStr('###');
 {+}Order := ' ORDER BY cliente_c ';
     //Abrir tablas/Querys
  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      showError(e);
      Close;
      Exit;
    end;
  end;
     //Lista de componentes
  ListaComponentes := TList.Create;
  ListaDetalle := TList.Create;
  PMaestro.GetTabOrderList(ListaComponentes);
  pnlFormaPago.GetTabOrderList(ListaComponentes);
  pnlCabDetalle.GetTabOrderList(ListaDetalle);
  //PDetalle.GetTabOrderList(ListaDetalle);

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

  cod_postal_c.Tag := kProvincia;
  cod_postal_ds.Tag := kProvincia;
  pais_c.Tag := kPais;
  banco_c.Tag := kBanco;
  representante_c.Tag := kRepresentante;
  tipo_cliente_c.Tag := kTipoCliente;
  tipo_via_c.Tag := kTipoVia;
  tipo_via_ds.Tag := kTipoVia;
  moneda_c.Tag := kMoneda;

  cod_postal_fac_c.Tag := kProvincia;
  pais_fac_c.Tag := kPais;
  forma_pago_c.Tag := kFormaPago;
  tipo_via_fac_c.Tag := kTipoVia;
  incoterm_c.Tag := kIncoterm;
  pais_fac_c.Tag := kPais;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeLocalizar;
  OnView := AntesDeVisualizar;
  OnViewDetail := VerDetalle;
  OnEditDetail := EditarDetalle;
  OnChangeMasterRecord := CambioRegistro;

  OnBeforeMasterDelete := AntesDeBorrarMaestro;
  OnAfterMasterDeleted := DespuesDeBorrarMaestro;

  OnBeforeDetailDelete:= AntesDeBorrarDetalle;
  OnAfterDetailDeleted := DespuesDeBorrarDetalle;
//  DSDetalle.DataSet.BeforePost := TSuministrosBeforePost;
  DSDetalle.DataSet.BeforePost := QSuministroBeforePost;

     //Focos
  {+}FocoAltas := cliente_c;
  {+}FocoModificar := cliente_c;
  {+}FocoLocalizar := cliente_c;

  pgcDetalle.ActivePage:= tsSuministro;

end;

procedure TFMClientes.FormActivate(Sender: TObject);
begin
     //Si ho hemos conseguido abrir las tablas salimos

  if not DataSourceDetalle.DataSet.Active then
    Exit
  else
  begin
    Restaurar;
  end;

end;

procedure TFMClientes.Restaurar;
begin
     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  gCF := nil;


  PanelMaestro := PMaestro;
  PanelDetalle := pnlCabDetalle;
  RejillaVisualizacion := RVisualizacion;
     {+}FocoAltas := cliente_c;
     {+}FocoModificar := nombre_c;
     {+}FocoLocalizar := cliente_c;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestroDetalle then
  begin
    FormType := CVariables.tfMaestroDetalle;
    BHFormulario;
  end;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(PCMaestro);
  BHGrupoDesplazamientoDetalle(PCDetalle);

     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
     //Barra de estado y barra de herramientas
  BEEstado;
  BHEstado;

  self.WindowState := wsMaximized;
end;


procedure TFMClientes.SincronizarDetalleWeb;
begin
  SincroBonnyAurora.SincronizarDirSuministro(
    DSDetalle.DataSet.FieldByName('cliente_ds').asString,
    DSDetalle.DataSet.FieldByName('dir_sum_ds').asString);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMClientes.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarCliente(DSMaestro.Dataset.FieldByName('cliente_c').asString);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMClientes.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
     // Height:=21;
     // Width:=100;
end;

procedure TFMClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with QDescuentos do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QRecargo do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QUnidades do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QTesoreria do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QRiesgo do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QGastos do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  ListaComponentes.Free;
  ListaDetalle.Free;
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

procedure TFMClientes.FormKeyDown(Sender: TObject; var Key: Word;
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
        if not notas_c.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
      end;
    vk_up:
      begin
        if not notas_c.Focused then
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
procedure TFMClientes.albaran_factura_cChange(Sender: TObject);
begin

  if QClientes.State in [dsEdit, dsInsert] then
  begin
    if albaran_factura_c.ItemIndex = 0 then
      QClientes.Fieldbyname('albaran_factura_c').AsInteger := 0
    else
    begin
      if albaran_factura_c.ItemIndex = 1 then
       QClientes.Fieldbyname('albaran_factura_c').AsInteger := 1
      else
      begin
        if albaran_factura_c.ItemIndex = 2 then
          QClientes.Fieldbyname('albaran_factura_c').AsInteger := 2;
      end;
    end;
  end;
end;

procedure TFMClientes.Altas;
var
 sOldEmpresa, sOldCliente, sNewEmpresa, sNewCliente, sMsg: string;
begin
  sOldEmpresa:= gsdefempresa;
  sOldCliente:= cliente_c.Text;
  if SeleccionarClonarClienteFD.SeleccionarClonarCliente( sOldCliente, sNewCliente ) then
  begin
    if not SeleccionarClonarClienteFD.ClonarCliente( sOldCliente, sNewCliente, sMsg ) then
    begin
      ShowMessage( sMsg );
    end
    else
    begin
      inherited Localizar;
//      empresa_c.Text:=  sNewEmpresa;
      cliente_c.Text:= sNewCliente;
      inherited AceptarLocalizar;
    end;
  end
  else
  begin
    inherited Altas;
  end;
end;

procedure TFMClientes.Filtro;
var Flag: Boolean;
  i: Integer;
  sPeriodo: string;
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

  if albaran_factura_c.Text <> '' then
  begin
      if flag then
        where := where + ' and  albaran_factura_c = ' + albaran_factura_c.Text
      else
        where := ' albaran_factura_c = ' + albaran_factura_c.Text;
      flag:= True;
  end;

{
  if albaran_factura_c.State <> cbGrayed then
  begin
    if albaran_factura_c.State = cbUnchecked then
    begin
      if flag then
        where := where + ' and albaran_factura_c = 0 '
      else
        where := ' albaran_factura_c = 0 ';
      flag:= True;
    end
    else
    begin
      if flag then
        where := where + ' and albaran_factura_c = 1 '
      else
        where := ' albaran_factura_c = 1 ';
      flag:= True;
    end;
  end;
}
  if seguro_c.State <> cbGrayed then
  begin
    if seguro_c.State = cbUnchecked then
    begin
      if flag then
        where := where + ' and  seguro_c = 0 '
      else
        where := ' seguro_c = 0 ';
      flag:= True;
    end
    else
    begin
      if flag then
        where := where + ' and seguro_c = 1 '
      else
        where := ' seguro_c = 1 ';
      flag:= True;
    end;
  end;

    if grabrar_transporte_c.State <> cbGrayed then
  begin
    if grabrar_transporte_c.State = cbUnchecked then
    begin
      if flag then
        where := where + ' and  grabrar_transporte_c = 0 '
      else
        where := ' grabrar_transporte_c = 0 ';
      flag:= True;
    end
    else
    begin
      if flag then
        where := where + ' and grabrar_transporte_c = 1 '
      else
        where := ' grabrar_transporte_c = 1 ';
      flag:= True;
    end;
  end;

  if tipo_albaran_c.Text <> '' then
  begin
      if flag then
        where := where + ' and  tipo_albaran_c = ' + tipo_albaran_c.Text
      else
        where := ' tipo_albaran_c = ' + tipo_albaran_c.Text;
      flag:= True;
  end;

  if periodo_factura_c.Text <> '' then
  begin
      if periodo_factura_c.ItemIndex = 0 then
        sPeriodo := 'D'
      else if periodo_factura_c.ItemIndex = 1 then
        sPeriodo := 'S'
      else if periodo_factura_c.ItemIndex = 2 then
        sPeriodo := 'Q'
      else if periodo_factura_c.ItemIndex = 3 then
        sPeriodo := 'M';

      if flag then
        where := where + ' and  periodo_factura_c = ' + QuotedStr(sPeriodo)
      else
        where := ' periodo_factura_c = ' + QuotedStr(sPeriodo);
      flag:= True;
  end;

  if flag then
    where := ' WHERE ' + where;
end;

//...................... REGISTROS INSERTADOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// PrimaryKey del componente.
//....................................................................

procedure TFMClientes.AnyadirRegistro;
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

procedure TFMClientes.ValidarEntradaMaestro;
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
          TBEdit(Objeto).setfocus;
        end;

      end;
    end;
  end;

  //Buscar si esta grabado
  if Estado = teAlta then
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_clientes ');
      SQL.Add(' where cliente_c = ' + QuotedStr( Trim( cliente_c.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        sAux:= 'Cliente duplicado. (' + '-' + Trim( cliente_c.Text ) + '-' + Trim( nombre_c.Text )  + ').';
        Close;
        raise Exception.Create( sAux );
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_clientes ');

      SQL.Add(' where cliente_c = ' + QuotedStr( Trim( cliente_c.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        if FieldByName('nombre_c').AsString <> nombre_c.Text then
        begin
          sAux:= 'Ya hay un cliente con el mismo código y diferente descripción (' +
                    FieldByName('nombre_c').AsString + ').';
          Close;
          raise Exception.Create( sAux );
        end;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_clientes ');
{
      if Copy(empresa_c.Text,1,1)  = 'F' then
        SQL.Add(' where empresa_c matches ''F*'' ')
      else
      if ( empresa_c.Text  = '050' ) or ( empresa_c.Text  = '080' ) then
        SQL.Add(' where ( empresa_c = ''050'' or empresa_c = ''080'' ) ')
      else
        SQL.Add(' where empresa_c = ' + QuotedStr( Trim( empresa_c.Text ) ) );
}
      SQL.Add(' where nombre_c = ' + QuotedStr( Trim( nombre_c.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        if ( FieldByName('cliente_c').AsString <> cliente_c.Text ) then
        begin
          sAux:= 'Ya hay un cliente con la misma descripción y diferente código ('  +
                     FieldByName('cliente_c').AsString + '-' + Trim( nombre_c.Text ) + ').';
          Close;
          raise Exception.Create( sAux );
        end;
      end;
      Close;
    end;
  end;


  if Trim(incoterm_c.text) = '' then
  begin
    QClientes.FieldByname('incoterm_c').Value := NULL;
    QClientes.FieldByname('plaza_incoterm_c').Value := NULL;
  end;

    if DataSeTMaestro.FieldByName('es_comunitario_c').AsString = '' then
    begin
      raise Exception.Create('Falta marcar si el cliente es o no comunitario.');
    end
    else
    begin
      if pais_c.Text <> '' then
      with DMAuxDB.QAux do
      begin
        SQL.Clear;
        SQL.Add( ' select case when comunitario_p = 1 then ''S'' else ''N'' end comu_p ');
        SQL.Add( ' from frf_paises ');
        SQL.Add( ' where pais_p = :pais ');
        ParamByName('pais').ASString:= pais_c.Text;
        Open;
        if FieldByName('comu_p').AsString <> DataSeTMaestro.FieldByName('es_comunitario_c').AsString then
        begin
          Close;
          if DataSeTMaestro.FieldByName('es_comunitario_c').AsString = 'S' then
          begin
            if MessageDlg( 'Ha indicado que el cliente es comunitario cuando ' +
                           pais_c.Text + ' - ' + STPais_c.Caption + 'es extracomunitario.' + #13 + #10 +
                           '¿Seguro que desea continuar?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then

             Abort;
          end
          else
          begin
            if MessageDlg( 'Ha indicado que el cliente es extracomunitario cuando ' +
                           pais_c.Text + ' - ' + STPais_c.Caption + 'es comunitario.' + #13 + #10 +
                           '¿Seguro que desea continuar?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
             Abort;
          end;
        end
        else
        begin
          Close;
        end;
      end;
    end;

{
  //La forma de pago debe de existir
  if ( txtst1.Caption = '' ) then
  begin
    if forma_pago_c.Text <> '' then
    begin
      raise Exception.Create('La forma de pago del cliente es incorrecta.');
    end
    else
    begin
      if MessageDlg( 'Falta grabar la forma de pago del cliente y esta es necesaria para contabilizar las facturas. ' + #13 + #10 +
                     '¿Seguro que desea continuar?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
         Abort;
    end;
  end;
}
  if ( grabrar_transporte_c.State = cbGrayed ) then
  begin
    grabrar_transporte_c.SetFocus;
    raise Exception.Create('Falta seleccionar si hay que grabar las facturas de portes del cliente (si el porte lo paga Bonnysa).');
  end;
{
  if ( seguro_c.State = cbGrayed ) then
  begin
    seguro_c.SetFocus;
    raise Exception.Create('Falta seleccionar si el cliente tiene seguro.');
  end;

  if Trim( max_riesgo_c.Text ) = '' then
  begin
    max_riesgo_c.SetFocus;
    raise Exception.Create('Falta introducir el riesgo del cliente.');
  end;
  if Trim( fecha_riesgo_c.Text ) = '' then
  begin
    fecha_riesgo_c.SetFocus;
    raise Exception.Create('Falta introducir la fecha en la que se grabo el riesgo.');
  end;
}
  if Trim( stTipoCliente.caption ) = '' then
  begin
    tipo_cliente_c.SetFocus;
    raise Exception.Create('Falta el tipo de cliente o es incorrecto.');
  end;
end;



procedure TFMClientes.Previsualizar;
begin
  if DMBaseDatos.QGeneral.Active then DMBaseDatos.QGeneral.Close;
  DMBaseDatos.QGeneral.SQL.Clear;
  DMBaseDatos.QGeneral.SQL.Add('SELECT *');
  DMBaseDatos.QGeneral.SQL.Add(' FROM frf_clientes ');
  DMBaseDatos.QGeneral.SQL.Add(Where); //Recojo las condiciones que se han introducido en la busqueda
  DMBaseDatos.QGeneral.SQL.Add(' ORDER BY cliente_c');
  try
    ConsultaOpen(DMBaseDatos.QGeneral, False, false);
    ConsultaOpen(QDirClientes, False, false);
  except
    Exit;
  end;
  try
    QRLClientes := TQRLClientes.Create(Application);
    PonLogoGrupoBonnysa(QRLClientes);

    QRLClientes.DataSet := DMBaseDatos.QGeneral;
//    QRLClientes.empresa_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.nombre_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.cliente_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.tipo_via_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.domicilio_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.nif_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.cod_postal_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.telefono_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.telefono2_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.fax_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.poblacion_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.forma_pago_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.notas_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.es_comunitario_c.DataSet := DMBaseDatos.QGeneral;
    QRLClientes.email_alb_c.DataSet := DMBaseDatos.QGeneral;

    QRLClientes.DSDescripciones.DataSet := DMBaseDatos.QGeneral;
    DSSuministros.DataSet := DMBaseDatos.QGeneral;

    QRLClientes.QRSubDetail.DataSet := QDirClientes;
    QRLClientes.dir_sum_ds.DataSet := QDirClientes;
    QRLClientes.nombre_ds.DataSet := QDirClientes;
    QRLClientes.cod_postal_ds.DataSet := QDirClientes;
    QRLClientes.poblacion_ds.DataSet := QDirClientes;
    QRLClientes.tipo_via_ds.DataSet := QDirClientes;
    QRLClientes.domicilio_ds.DataSet := QDirClientes;
    QRLClientes.telefono_ds.DataSet := QDirClientes;
    QRLClientes.provincia_ds.DataSet := QDirClientes;
    QRLClientes.pais_ds.DataSet := QDirClientes;

    ConsultaOpen(QRLClientes.QDescripciones, false, false);
    Preview(QRLClientes);
  finally
    DMBaseDatos.QGeneral.Close;
    QDirClientes.Close;
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

procedure TFMClientes.ARejillaFlotanteExecute(Sender: TObject);
var
  sAux: string;
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kTipoVia:
      begin
        if ActiveControl = tipo_via_c then
          DespliegaRejilla(BGBtipo_via_c)
        else
          if ActiveControl = tipo_via_ds then
            DespliegaRejilla(BGBtipo_via_ds)
          else
            if ActiveControl = tipo_via_fac_c then
              DespliegaRejilla(BGBDirfactura);
      end;
    kPais:
      begin
        if ActiveControl = pais_c then
          DespliegaRejilla(BGBPais_c)
        else
          if ActiveControl = pais_fac_c then
            DespliegaRejilla(BGBPaisFactura);
      end;
    kRepresentante: DespliegaRejilla(BGBrepresentante_c, [gsDefEmpresa]);
    kTipoCliente:
    begin
      DespliegaRejilla(btnTipoCliente);
    end;
    kBanco:
      DespliegaRejilla(btnBanco, [gsDefEmpresa]);
    kFormaPago:
    begin
      if ( DMConfig.EsLaFont ) then
      begin
        sAux:= forma_pago_c.Text;
        if UFFormaPago.SeleccionaFormaPago( self, forma_pago_c,  sAux ) then
        begin
          forma_pago_c.Text:= sAux;
        end;
      end;
    end;

    kMoneda: DespliegaRejilla(BGBmoneda_c);
    kIncoterm: DespliegaRejilla(BGBincoterm_c);
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMClientes.AntesDeInsertar;
begin
     //Habilitamos campo edidion
  PonPaneles( kEditCab );

     //Rejilla en visualizacion
  VerDetalle;
     //Por defecto es comunitario
  //es_comunitario_c.Checked := true;
     //Por defecto no tiene numero edi
  edi_c.Checked := false;
     //Por defecto la moneda es el euro (codigo
  moneda_c.Text := 'EUR'; {Modificar si cambiamos el codigo}
     //Por defecto numero de copias es de tres
  n_copias_alb_c.Text := '3';
  n_copias_fac_c.Text := '3';

//  albaran_factura_c.Checked:= False;
  //seguro_c.Checked:= False;
  seguro_c.AllowGrayed:= False;
  grabrar_transporte_c.AllowGrayed:= False;
end;

procedure TFMClientes.AntesDeLocalizar;
begin
     //Habilitamos campo edidion
  PonPaneles( kEditCab );
     //Rejilla en visualizacion
  VerDetalle;
     //Deshabilitar es comunitario
  es_comunitario_c.Enabled := false;
  edi_c.Enabled := true;
  seguro_c.AllowGrayed:= True;
  grabrar_transporte_c.AllowGrayed:= True;
  albaran_factura_c.ItemIndex := -1;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMClientes.AntesDeModificar;
var i: Integer;
begin
  PonPaneles( kEditCab );

     //Habilitamos campo edidion
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
  seguro_c.AllowGrayed:= False;
  grabrar_transporte_c.AllowGrayed:= False;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMClientes.AntesDeVisualizar;
var i: Integer;
begin
     //Desabilitamos campo edidion
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
        begin
          Enabled := true;
        end;
  end;
     //Habilitar es comunitario
  es_comunitario_c.Enabled := True;
  edi_c.Enabled := true;
  STRepresentante_c.Caption := desRepresentante(representante_c.Text);
  STPais_c.Caption := desPais(pais_c.Text);
  STProvinciaFactura.Caption := desProvincia(cod_postal_fac_c.Text);

  PonPaneles( kNavigation );
end;

procedure TFMClientes.VerDetalle;
var i: integer;
begin
//    if PageControl.ActivePage=TSDEtalle then
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

  //Vidualizar maestro
  if Estado = teOperacionDetalle then
    PonPaneles( kNavigation )
  else
    PonPaneles( kEditCab );
end;

procedure TFMClientes.AntesDeBorrarDetalle;
begin
  if pgcDetalle.ActivePage <> tsSuministro then
  begin
    pgcDetalle.ActivePage:= tsSuministro;
    raise Exception.Create('Primero seleccione el suministro que desea borrar.');
  end
  else
  begin
    FRegistroABorrarClienteId := DSDetalle.DataSet.FieldByName('cliente_ds').asString;
    FRegistroABorrarDireccionId := DSDetalle.DataSet.FieldByName('dir_sum_ds').asString;
  end;
end;

procedure TFMClientes.AntesDeBorrarMaestro;
begin
  FRegistroABorrarClienteId := DSMaestro.Dataset.FieldByName('cliente_c').asString;
end;

procedure TFMClientes.EditarDetalle;
var i: integer;
begin
  pgcDetalle.ActivePage:= tsSuministro;

     //Deshabilitamos campo edidion
     //Deshabilitamos boton de unidades de facturacion
  if EstadoDetalle = tedModificar then
    for i := 0 to ListaDetalle.Count - 1 do
    begin
      Objeto := ListaDetalle.Items[i];
      if (Objeto is TBDEdit) then
      begin
        with Objeto as TBDEdit do
        begin
          if Modificable = false then
            Enabled := false;
        end;
      end;
      FocoDetalle := fecha_baja_ds;
    end
  else
    FocoDetalle := dir_sum_ds;

     //Visdualizar detalle
  PonPaneles( kEditDet );
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

procedure TFMClientes.ValidarEntradaDetalle;
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

    //Completamos la clave primaria
  RellenaClaveDetalle;
end;

procedure TFMClientes.RellenaClaveDetalle;
begin
     //cliente
  if Trim(cliente_c.Text) = '' then
    raise Exception.Create('Faltan datos de la cabecera.');
  DataSourceDetalle.DataSet.FieldByName('cliente_ds').AsString :=
    cliente_c.Text;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMClientes.RequiredTime(Sender: TObject;
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


procedure TFMClientes.PonPaneles( const ATipo: Integer );
begin
  if ( ATipo = kNavigation ) or ( ATipo = kEditCab ) then
  begin
    pnlCabDetalle.Visible := false;
    pnlCabDetalle.Height := 0;

    PMaestro.Height := 422;
    PMaestro.Visible := True;

    PDetalle2.Enabled:= True;
    tsSuministro.TabVisible:= True;
    tsDescuentos.TabVisible:= True;
    tsRecargo.TabVisible:= True;
    tsUnidades.TabVisible:= True;
    tsFormaPago.TabVisible:= True;
    //pgcDetalle.ActivePage:= tsSuministro;
    Self.Caption := 'CLIENTES';
  end
  (*
  else
  if ATipo = kEditCab then
  begin
    pnlCabDetalle.Visible := false;
    pnlCabDetalle.Height := 0;

    PMaestro.Height := 400;
    PMaestro.Visible := True;

    PDetalle2.Enabled:= True;
    tsSuministro.TabVisible:= False;
    tsDescuentos.TabVisible:= False;
    tsRecargo.TabVisible:= False;
    tsDomicializaciones.TabVisible:= False;
    tsUnidades.TabVisible:= False;
    tsFormaPago.TabVisible:= True;

    Self.Caption := 'CLIENTES';
  end
  *)
  else
  if ATipo = kEditDet then
  begin
    stCodCliente.Caption:= cliente_c.Text;
    STCliente_.Caption := nombre_c.Text;

    if ( (  pais_c.Text = 'ES' ) and ( pais_ds.Text = '' ) ) or ( pais_ds.Text = 'ES' )  then
    begin
      STProvinciaD.Enabled := true;
      STProvinciaD.Visible := true;
      provincia_ds.Enabled := false;
      provincia_ds.Visible := false;
    end
    else
    begin
      STProvinciaD.Enabled := False;
      STProvinciaD.Visible := False;
      provincia_ds.Enabled := true;
      provincia_ds.Visible := true;
    end;

    //Tamaños paneles
    PDetalle2.Enabled:= True;
    PMaestro.Visible := false;
    pnlCabDetalle.Visible := true;
    pnlCabDetalle.Height := 210;
    tsSuministro.TabVisible:= True;
    tsDescuentos.TabVisible:= False;
    tsRecargo.TabVisible:= False;
    tsUnidades.TabVisible:= False;
    tsFormaPago.TabVisible:= False;
    {PDetalle.Top:=0;}

    //Titulo
    Self.Caption := 'DIRECCIONES DE SUMINISTRO';
  end;
end;


//Evento que se produce cuando cambia el registro activo
//Tambien se genera cuando se muestra el primero

procedure TFMClientes.CambioRegistro;
begin
  STPais_c.Caption := desPais(pais_c.Text);
  if ((pais_c.Text <> 'ES') or (Trim(pais_fac_c.Text) = '')) then
    STprovincia.Caption := ''
  else STprovincia.Caption := desProvincia(cod_postal_c.Text);

  STPaisFactura.Caption := desPais(pais_fac_c.Text);
  if ((pais_fac_c.Text <> 'ES') or (Trim(pais_fac_c.Text) = '')) then
    STProvinciaFactura.Caption := ''
  else STProvinciaFactura.Caption := desProvincia(cod_postal_fac_c.Text);
end;

procedure TFMClientes.TSuministrosBeforePost(DataSet: TDataSet);
begin
  if Trim(pais_ds.Text) = '' then
  begin
    DataSet.FieldByName('pais_ds').AsString := pais_c.Text;
  end;
end;

procedure TFMClientes.TSuministrosCalcFields(DataSet: TDataSet);
begin
  if (DSMaestro.DataSet['pais_c'] <> NULL) and
    (DSMaestro.DataSet['pais_c'] = 'ES') and
    (DataSet['cod_postal_ds'] <> NULL) then
  begin
    DataSet['provincia_esp_ds'] := NomProvincia(copy(DataSet['cod_postal_ds'], 1, 2),
      DSMaestro.DataSet['pais_c']);
  end
  else
  begin
    DataSet['provincia_esp_ds'] := DataSet['provincia_ds'];
  end;
  DataSet['des_pais_ds']:=DesPais( DataSet['pais_ds'] );
end;

procedure TFMClientes.BtnUniFacClick(Sender: TObject);
begin
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    EnvaseClientePorCliente(gsDefEmpresa, cliente_c.Text );
    QUnidades.Close;
    QUnidades.Open;
  end
  else
  begin
    ShowMessage('Seleccione primero un cliente');
  end;
end;

procedure TFMClientes.QClientesAfterOpen(DataSet: TDataSet);
begin
  QDescuentos.Open;
  QRecargo.Open;
  QUnidades.Open;
  QTesoreria.Open;
  QRiesgo.Open;
  QGastos.Open;
end;

procedure TFMClientes.QClientesBeforeClose(DataSet: TDataSet);
begin
  QDescuentos.Close;
  QRecargo.Close;
  QUnidades.Close;
  QTesoreria.Close;
  QRiesgo.Close;
  QGastos.Close;
end;

procedure TFMClientes.QSuministroBeforePost(DataSet: TDataSet);
begin
  if Trim(pais_ds.Text) = '' then
  begin
    DataSet.FieldByName('pais_ds').AsString := pais_c.Text;
  end;
end;

procedure TFMClientes.QSuministroCalcFields(DataSet: TDataSet);
begin
  if (DSMaestro.DataSet['pais_c'] <> NULL) and
    (DSMaestro.DataSet['pais_c'] = 'ES') and
    (DataSet['cod_postal_ds'] <> NULL) then
  begin
    DataSet['provincia_esp_ds'] := NomProvincia(copy(DataSet['cod_postal_ds'], 1, 2),
      DSMaestro.DataSet['pais_c']);
  end
  else
  begin
    DataSet['provincia_esp_ds'] := DataSet['provincia_ds'];
  end;
//    DataSet['des_pais_ds']:=DesPais( DataSet['pais_ds'] );
end;

procedure TFMClientes.QTesoreriaCalcFields(DataSet: TDataSet);
begin
  QTesoreria.FieldByName('des_banco').AsString:= desBanco(QTesoreria.FieldByName('banco_ct').AsString);
end;

procedure TFMClientes.btnFormasPagoClick(Sender: TObject);
begin
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    TesoreriaClientesFD.ExecuteTesoreriaClientes( self, gsdefempresa, cliente_c.Text );
    QTesoreria.Close;
    QTesoreria.Open;
  end
  else
  begin
    ShowMessage('Seleccione primero un cliente');
  end;
end;

procedure TFMClientes.btnDescuentosClick(Sender: TObject);
begin
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    DescuentosClientesFD.ExecuteDescuentosClientes( self, QDescuentos.fieldbyname('empresa').AsString, cliente_c.Text );
    QDescuentos.Close;
    QDescuentos.Open;
  end
  else
  begin
    ShowMessage('Seleccione primero un cliente');
  end;
end;

procedure TFMClientes.btnProductoClick(Sender: TObject);
var
  sEmpresa, sProducto: string;
begin
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    sProducto:= QDescuentos.fieldByName('cod_producto').AsString;
    sEmpresa:= QDescuentos.fieldByName('empresa').AsString;
    if SeleccionarProductoFD.SeleccionarProducto( sEmpresa, sProducto ) then
    begin
      DescuentosClientesProductoFD.ExecuteDescuentosClientesProducto( self, sEmpresa, cliente_c.Text, sProducto );
      QDescuentos.Close;
      QDescuentos.Open;
    end;
  end
  else
  begin
    ShowMessage('Seleccione primero un cliente');
  end;
end;

procedure TFMClientes.btnRecargoClick(Sender: TObject);
begin
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    RecargoClientesFD.ExecuteRecargoClientes( self, gsdefempresa, cliente_c.Text );
    QRecargo.Close;
    QRecargo.Open;
  end
  else
  begin
    ShowMessage('Seleccione primero un cliente');
  end;
end;

procedure TFMClientes.btnRiesgoClick(Sender: TObject);
begin
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    RiesgoClientesFD.ExecuteRiesgoClientes( self, gsdefempresa, cliente_c.Text );
    QRiesgo.Close;
    QRiesgo.Open;
  end
  else
  begin
    ShowMessage('Seleccione primero un cliente');
  end;
end;

procedure TFMClientes.incoterm_cChange(Sender: TObject);
begin
  (*CMABIOS*)
  stIncoterm.Caption:= desIncoterm( incoterm_c.Text );
end;

procedure TFMClientes.banco_cChange(Sender: TObject);
begin
  txtBanco.Caption:= desBanco( banco_c.Text );
end;

procedure TFMClientes.btnGastosClick(Sender: TObject);
begin
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    GastosClientesFD.ExecuteDescuentosClientes( self, QGastos.fieldbyname('empresa_gc').AsString, cliente_c.Text );
    QGastos.Close;
    QGastos.Open;
  end
  else
  begin
    ShowMessage('Seleccione primero un cliente');
  end;
end;

procedure TFMClientes.forma_pago_cChange(Sender: TObject);
begin
  (*
  if ( Length( forma_pago_c.Text ) = 2 ) and
     ( txtBanco.Caption = '' ) then
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('select banco_fp');
      SQL.Add('from frf_forma_pago');
      SQL.Add('where empresa_fp = ' + QuotedStr( empresa_c.Text ) );
      SQL.Add('and codigo_fp = ' + QuotedStr( forma_pago_c.Text ) );
      Open;
      if not IsEmpty then
      begin
        banco_c.Text:= FieldByname('banco_fp').AsString;
      end;
      Close;
    end;
  end;
  *)
{
  with DMAuxDB.QDescripciones do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_forma_pago ');
    SQL.Add(' where codigo_fp = '  + QuotedStr( forma_pago_c.Text ) );
    Open;
    txtst1.Caption:= FieldByname('descripcion_fp').AsString;
    txtst11.Caption:= FieldByname('descripcion_fp').AsString;
    txtst2.Caption:= FieldByname('descripcion2_fp').AsString;
    txtst3.Caption:= FieldByname('descripcion3_fp').AsString;
    txtst4.Caption:= FieldByname('descripcion4_fp').AsString;
    txtst5.Caption:= FieldByname('descripcion5_fp').AsString;
    txtst6.Caption:= FieldByname('descripcion6_fp').AsString;
    txtst7.Caption:= FieldByname('descripcion7_fp').AsString;
    txtst8.Caption:= FieldByname('descripcion8_fp').AsString;
    txtst9.Caption:= FieldByname('descripcion9_fp').AsString;
    Close;
  end;
}
end;

procedure TFMClientes.moneda_cChange(Sender: TObject);
begin
  STMoneda_c.Caption := desMoneda(moneda_c.Text);
end;


function EmpresaGrupo(const AEmpresa: string ): Boolean;
begin
  Result:= ( Copy(Trim(AEmpresa),1,1) = 'F' ) or ( AEmpresa = '050' ) or ( AEmpresa  = '080' );
end;

procedure TFMClientes.cliente_cChange(Sender: TObject);
begin
  if cliente_c.Text = 'WEB' then
  begin
    lblIvaWeb.Caption:= 'Al cliente ONLINE siempre se le factura el IVA.';
  end
  else
  begin
    lblIvaWeb.Caption:= '';
  end;

  //Buscar si esta grabado y rellenar datos
  if ( Estado = teAlta ) and ( EmpresaGrupo( gsdefempresa ) ) and ( Length( Trim( cliente_c.Text ) ) > 1 ) and
     ( Trim( nombre_c.Text ) = '' )  then
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_clientes ');

    SQL.Add(' where cliente_c = ' + QuotedStr( Trim( cliente_c.Text ) ) );

    Open;
    if not IsEmpty then
    begin
       if MessageDlg( 'Ya hay un cliente con este código  (' + FieldByName('cliente_c').AsString +
                     '-' + FieldByName('nombre_c').AsString +
                     '), ¿desea rellenar los campos de la ficha actual con sus datos?.' , mtWarning, [mbYes, mbNo], 0 ) = mrYes then
       begin
         nombre_c.Text:= FieldByName('nombre_c').AsString;
         tipo_via_c.Text:= FieldByName('tipo_via_c').AsString;
         domicilio_c.Text:= FieldByName('domicilio_c').AsString;
         poblacion_c.Text:= FieldByName('poblacion_c').AsString;
         cod_postal_c.Text:= FieldByName('cod_postal_c').AsString;
         pais_c.Text:= FieldByName('pais_c').AsString;
         es_comunitario_c.Checked:= FieldByName('es_comunitario_c').AsString = 'S';
         nif_c.Text:= FieldByName('nif_c').AsString;
         telefono_c.Text:= FieldByName('telefono_c').AsString;
         telefono2_c.Text:= FieldByName('telefono2_c').AsString;
         fax_c.Text:= FieldByName('fax_c').AsString;
         resp_compras_c.Text:= FieldByName('resp_compras_c').AsString;
         representante_c.Text:= FieldByName('representante_c').AsString;
         n_copias_alb_c.Text:= FieldByName('n_copias_alb_c').AsString;
         tipo_via_fac_c.Text:= FieldByName('tipo_via_fac_c').AsString;
         domicilio_fac_c.Text:= FieldByName('domicilio_fac_c').AsString;
         poblacion_fac_c.Text:= FieldByName('poblacion_fac_c').AsString;
         cod_postal_fac_c.Text:= FieldByName('cod_postal_fac_c').AsString;
         pais_fac_c.Text:= FieldByName('pais_fac_c').AsString;
         n_copias_fac_c.Text:= FieldByName('n_copias_fac_c').AsString;
         forma_pago_c.Text:= FieldByName('forma_pago_c').AsString;
         moneda_c.Text:= FieldByName('moneda_c').AsString;
         edi_c.Checked:= FieldByName('edi_c').AsString = 'S';
         cta_cliente_c.Text:= FieldByName('cta_cliente_c').AsString;
         cta_ingresos_pgc_c.Text:= FieldByName('cta_ingresos_pgc_c').AsString;
         cta_ingresos_pga_c.Text:= FieldByName('cta_ingresos_pga_c').AsString;
         tipo_albaran_c.Text:= FieldByName('tipo_albaran_c').AsString;
         albaran_factura_c.Text:= FieldByName('albaran_factura_c').AsString;
         email_alb_c.Text:= FieldByName('email_alb_c').AsString;
         email_fac_c.Text:= FieldByName('email_fac_c').AsString;
         max_riesgo_c.Text:= FieldByName('max_riesgo_c').AsString;
         fecha_riesgo_c.Text:= FieldByName('fecha_riesgo_c').AsString;
         seguro_c.Checked:= FieldByName('seguro_c').AsString = '1';
         grabrar_transporte_c.Checked:= FieldByName('grabrar_transporte_c').AsString = '1';
         notas_c.Text:= FieldByName('notas_c').AsString;
         moneda_c.Text:= FieldByName('moneda_c').AsString;
         banco_c.Text:= FieldByName('banco_c').AsString;
         incoterm_c.Text:= FieldByName('incoterm_c').AsString;
         plaza_incoterm_c.Text:= FieldByName('plaza_incoterm_c').AsString;
         periodo_factura_c.Text:= FieldByName('periodo_factura_c').AsString;

         DSMaestro.dataset.fieldbyname('nombre_c').asstring:= FieldByName('nombre_c').AsString;
         DSMaestro.dataset.fieldbyname('tipo_via_c').asstring:= FieldByName('tipo_via_c').AsString;
         DSMaestro.dataset.fieldbyname('domicilio_c').asstring:= FieldByName('domicilio_c').AsString;
         DSMaestro.dataset.fieldbyname('poblacion_c').asstring:= FieldByName('poblacion_c').AsString;
         DSMaestro.dataset.fieldbyname('cod_postal_c').asstring:= FieldByName('cod_postal_c').AsString;
         DSMaestro.dataset.fieldbyname('pais_c').asstring:= FieldByName('pais_c').AsString;
         DSMaestro.dataset.fieldbyname('es_comunitario_c').asstring:= FieldByName('es_comunitario_c').AsString;
         DSMaestro.dataset.fieldbyname('nif_c').asstring:= FieldByName('nif_c').AsString;
         DSMaestro.dataset.fieldbyname('telefono_c').asstring:= FieldByName('telefono_c').AsString;
         DSMaestro.dataset.fieldbyname('telefono2_c').asstring:= FieldByName('telefono2_c').AsString;
         DSMaestro.dataset.fieldbyname('fax_c').asstring:= FieldByName('fax_c').AsString;
         DSMaestro.dataset.fieldbyname('resp_compras_c').asstring:= FieldByName('resp_compras_c').AsString;
         DSMaestro.dataset.fieldbyname('representante_c').asstring:= FieldByName('representante_c').AsString;
         DSMaestro.dataset.fieldbyname('n_copias_alb_c').asstring:= FieldByName('n_copias_alb_c').AsString;
         DSMaestro.dataset.fieldbyname('tipo_via_fac_c').asstring:= FieldByName('tipo_via_fac_c').AsString;
         DSMaestro.dataset.fieldbyname('domicilio_fac_c').asstring:= FieldByName('domicilio_fac_c').AsString;
         DSMaestro.dataset.fieldbyname('poblacion_fac_c').asstring:= FieldByName('poblacion_fac_c').AsString;
         DSMaestro.dataset.fieldbyname('cod_postal_fac_c').asstring:= FieldByName('cod_postal_fac_c').AsString;
         DSMaestro.dataset.fieldbyname('pais_fac_c').asstring:= FieldByName('pais_fac_c').AsString;
         DSMaestro.dataset.fieldbyname('n_copias_fac_c').asstring:= FieldByName('n_copias_fac_c').AsString;
         DSMaestro.dataset.fieldbyname('forma_pago_c').asstring:= FieldByName('forma_pago_c').AsString;
         DSMaestro.dataset.fieldbyname('moneda_c').asstring:= FieldByName('moneda_c').AsString;
         DSMaestro.dataset.fieldbyname('edi_c').asstring:= FieldByName('edi_c').AsString ;
         DSMaestro.dataset.fieldbyname('cta_cliente_c').asstring:= FieldByName('cta_cliente_c').AsString;
         DSMaestro.dataset.fieldbyname('cta_ingresos_pgc_c').asstring:= FieldByName('cta_ingresos_pgc_c').AsString;
         DSMaestro.dataset.fieldbyname('cta_ingresos_pga_c').asstring:= FieldByName('cta_ingresos_pga_c').AsString;
         DSMaestro.dataset.fieldbyname('tipo_albaran_c').asInteger:= FieldByName('tipo_albaran_c').asInteger ;
         DSMaestro.dataset.fieldbyname('albaran_factura_c').AsInteger:= FieldByName('albaran_factura_c').AsInteger;
         DSMaestro.dataset.fieldbyname('email_alb_c').asstring:= FieldByName('email_alb_c').AsString;
         DSMaestro.dataset.fieldbyname('email_fac_c').asstring:= FieldByName('email_fac_c').AsString;
         DSMaestro.dataset.fieldbyname('max_riesgo_c').asstring:= FieldByName('max_riesgo_c').AsString;
         DSMaestro.dataset.fieldbyname('fecha_riesgo_c').asstring:= FieldByName('fecha_riesgo_c').AsString;
         DSMaestro.dataset.fieldbyname('seguro_c').asstring:= FieldByName('seguro_c').AsString;
         DSMaestro.dataset.fieldbyname('grabrar_transporte_c').asstring:= FieldByName('grabrar_transporte_c').AsString;
         DSMaestro.dataset.fieldbyname('notas_c').asstring:= FieldByName('notas_c').AsString;
         DSMaestro.dataset.fieldbyname('moneda_c').asstring:= FieldByName('moneda_c').AsString;
         DSMaestro.dataset.fieldbyname('banco_c').asstring:= FieldByName('banco_c').AsString;
         DSMaestro.dataset.fieldbyname('incoterm_c').asstring:= FieldByName('incoterm_c').AsString;
         DSMaestro.dataset.fieldbyname('plaza_incoterm_c').asstring:= FieldByName('plaza_incoterm_c').AsString;
         DSMaestro.dataset.fieldbyname('periodo_factura_c').asstring:= FieldByName('periodo_factura_c').AsString;
       end;
    end;
    Close;
  end;
end;

procedure TFMClientes.QClientesAfterPost(DataSet: TDataSet);
var
  sEmpresa: string;
begin
  if Estado = teAlta then
//  if EmpresaGrupo( DataSet.FieldByName('empresa_c').AsString ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where cliente_c = ' + QuotedStr( DataSet.FieldByName('cliente_c').AsString ) );
    Open;

    if not IsEmpty then
    begin
      if MessageDlg( 'Ya hay un cliente con este código  '  + FieldByName('cliente_c').AsString +
                     '-' + FieldByName('nombre_c').AsString +
                     ', ¿desea rellenar las direcciones de suministro, envases y descuentos con sus datos?.' , mtWarning, [mbYes, mbNo], 0 ) = mrYes then
      begin
        bAltaDetalles:= False;
        sEmpresa:= gsdefempresa;

        //sumnistros
        Close;
        SQL.Clear;
        SQL.Add(' select * ');
        SQL.Add(' from frf_dir_sum ');
        SQL.Add(' where cliente_ds = ' + QuotedStr( DataSet.FieldByName('cliente_c').AsString ) );
        Open;
        if not IsEmpty then
        begin
          //suministros
          QAuxCli.sql.Clear;
          QAuxCli.sql.Add( 'select * from frf_dir_sum' );
          QAuxCli.Open;
          while not Eof do
          begin
            QAuxCli.Insert;
            QAuxCli.FieldByName('cliente_ds').AsString:= DataSet.FieldByName('cliente_c').AsString;
            QAuxCli.FieldByName('dir_sum_ds').AsString:= FieldByName('dir_sum_ds').AsString;
            QAuxCli.FieldByName('nombre_ds').AsString:= FieldByName('nombre_ds').AsString;
            QAuxCli.FieldByName('tipo_via_ds').AsString:= FieldByName('tipo_via_ds').AsString;
            QAuxCli.FieldByName('domicilio_ds').AsString:= FieldByName('domicilio_ds').AsString;
            QAuxCli.FieldByName('cod_postal_ds').AsString:= FieldByName('cod_postal_ds').AsString;
            QAuxCli.FieldByName('poblacion_ds').AsString:= FieldByName('poblacion_ds').AsString;
            QAuxCli.FieldByName('telefono_ds').AsString:= FieldByName('telefono_ds').AsString;
            QAuxCli.FieldByName('provincia_ds').AsString:= FieldByName('provincia_ds').AsString;
            QAuxCli.FieldByName('pais_ds').AsString:= FieldByName('pais_ds').AsString;
            try
              QAuxCli.Post;
            except
              //No hacemos nada
              QAuxCli.Cancel;
            end;
            Next;
          end;
          QAuxCli.Close;
        end;
        Close;

        //descuentos
        Close;
        SQL.Clear;
        SQL.Add(' select * ');
        SQL.Add(' from frf_descuentos_cliente ');
        SQL.Add(' where cliente_cd = ' + QuotedStr( DataSet.FieldByName('cliente_c').AsString ) );
        Open;
        if not IsEmpty then
        begin
          QAuxCli.sql.Clear;
          QAuxCli.sql.Add( 'select * from frf_descuentos_cliente' );
          QAuxCli.Open;
          while not Eof do
          begin
            QAuxCli.Insert;
            QAuxCli.FieldByName('cliente_dc').AsString:= DataSet.FieldByName('cliente_c').AsString;
            QAuxCli.FieldByName('no_fact_bruto_dc').AsFloat:= FieldByName('no_fact_bruto_dc').AsFloat;
            QAuxCli.FieldByName('no_fact_neto_dc').AsFloat:= FieldByName('no_fact_neto_dc').AsFloat;
            QAuxCli.FieldByName('facturable_dc').AsInteger:= FieldByName('facturable_dc').AsInteger;
            QAuxCli.FieldByName('eurkg_facturable_dc').AsFloat:= FieldByName('eurkg_facturable_dc').AsFloat;
            QAuxCli.FieldByName('eurkg_no_facturable_dc').AsInteger:= FieldByName('eurkg_no_facturable_dc').AsInteger;
            QAuxCli.FieldByName('eurpale_facturable_dc').AsFloat:= FieldByName('eurpale_facturable_dc').AsFloat;
            QAuxCli.FieldByName('eurpale_no_facturable_dc').AsInteger:= FieldByName('eurpale_no_facturable_dc').AsInteger;
            QAuxCli.FieldByName('fecha_ini_dc').AsDateTime:= FieldByName('fecha_ini_dc').AsDateTime;
            if FieldByName('fecha_fin_dc').Value <> null then
              QAuxCli.FieldByName('fecha_fin_dc').AsDateTime:= FieldByName('fecha_fin_dc').AsDateTime;
            try
              QAuxCli.Post;
            except
              //No hacemos nada
              QAuxCli.Cancel;
            end;
            Next;
          end;
          QAuxCli.Close;
        end;
        Close;

        //Envases
        Close;
        SQL.Clear;
//        SQL.Add(' Select empresa_ce, producto_ce, envase_ce, cliente_ce, unidad_fac_ce, descripcion_ce, ');
//        SQL.Add('        n_palets_ce, kgs_palet_ce, caducidad_cliente_ce, min_vida_cliente_ce, max_vida_cliente_ce ');
        SQL.Add(' select * from frf_clientes_env ');
        SQL.Add(' where empresa_ce = ' + QuotedStr( gsdefempresa  ) );
        SQL.Add(' and cliente_ce = ' + QuotedStr( DataSet.FieldByName('cliente_c').AsString ) );
        Open;
        if not IsEmpty then
        begin
          QAuxCli.sql.Clear;
//          QAuxCli.SQL.Add(' Select empresa_ce, producto_ce, envase_ce, cliente_ce, unidad_fac_ce, descripcion_ce, ');
//          QAuxCli.SQL.Add('        n_palets_ce, kgs_palet_ce, caducidad_cliente_ce, min_vida_cliente_ce, max_vida_cliente_ce ');
          QAuxCli.sql.Add('  select * from frf_clientes_env' );
          QAuxCli.Open;
          while not Eof do
          begin
            QAuxCli.Insert;
            QAuxCli.FieldByName('empresa_ce').AsString:= gsdefempresa;
            QAuxCli.FieldByName('cliente_ce').AsString:= DataSet.FieldByName('cliente_c').AsString;
            QAuxCli.FieldByName('envase_ce').AsString:= FieldByName('envase_ce').AsString;
            QAuxCli.FieldByName('producto_ce').AsString:= FieldByName('producto_ce').AsString;
            QAuxCli.FieldByName('unidad_fac_ce').AsString:= FieldByName('unidad_fac_ce').AsString;
            QAuxCli.FieldByName('descripcion_ce').AsString:= FieldByName('descripcion_ce').AsString;
            QAuxCli.FieldByName('n_palets_ce').AsInteger:= FieldByName('n_palets_ce').AsInteger;
            QAuxCli.FieldByName('kgs_palet_ce').AsFloat:= FieldByName('kgs_palet_ce').AsFloat;
            try
              QAuxCli.Post;
            except
              //No hacemos nada
              QAuxCli.Cancel;
            end;
            Next;
          end;
          QAuxCli.Close;
        end;
      end;
    end;
    Close;
  end;
end;

procedure TFMClientes.DespuesDeBorrarDetalle;
begin
  SincroBonnyAurora.SincronizarDirSuministro(FRegistroABorrarClienteId, FRegistroABorrarDireccionId);
  SincroBonnyAurora.Sincronizar;
  FRegistroABorrarClienteId := '';
  FRegistroABorrarDireccionId := '';
end;

procedure TFMClientes.DespuesDeBorrarMaestro;
begin
  SincroBonnyAurora.SincronizarCliente(FRegistroABorrarClienteId);
  SincroBonnyAurora.Sincronizar;
  FRegistroABorrarClienteId := '';
end;

procedure TFMClientes.DetalleAltas;
var
  sEmpresa, sCliente, sSuministro, sCodigo, Smsg: string;
begin
  if bAltaDetalles then
  begin
    if ( Estado = teAlta ) or ( Estado = teOperacionDetalle ) then
    begin
      inherited DetalleAltas;
    end
    else
    begin
      sEmpresa:= gsdefempresa;
      sCliente:= cliente_c.Text;
      sSuministro:= '';
      sCodigo:= '';
      if SeleccionarClonarSuministroFD.SeleccionarClonarSuministro(sEmpresa, sCliente, sSuministro, sCodigo )  then
      begin
        if SeleccionarClonarSuministroFD.ClonarSuministro( sEmpresa, sCliente, sSuministro, gsdefempresa, cliente_c.Text, sCodigo, Smsg ) then
        begin
          ShowMessage('Suministro clonado');
          DSDetalle.DataSet.Close;
          DSDetalle.DataSet.Open;
        end
        else
        begin
          ShowMessage('Problemas al clonar el suministro. '+ #13 + #10 + Smsg);
        end;
      end
      else
      begin
        inherited DetalleAltas;
      end;
    end;
  end
  else
    CancelarAltaDetalle;
  bAltaDetalles:= True;
end;


procedure TFMClientes.pais_cChange(Sender: TObject);
begin
  STPais_c.Caption := desPais(pais_c.Text);
  if (pais_c.Text = 'ES') then
    STprovincia.Caption := desProvincia(cod_postal_c.Text)
  else
    STprovincia.Caption := '';
end;

procedure TFMClientes.cod_postal_cChange(Sender: TObject);
begin
  if (pais_c.Text = 'ES') then
    STprovincia.Caption := desProvincia(cod_postal_c.Text)
  else
    STprovincia.Caption := '';
end;

procedure TFMClientes.pais_fac_cChange(Sender: TObject);
begin
  STPaisFactura.Caption := desPais(pais_fac_c.Text);
  if (pais_fac_c.Text = 'ES') then
    STProvinciaFactura.Caption := desProvincia(cod_postal_fac_c.Text)
  else
    STProvinciaFactura.Caption := '';
end;

procedure TFMClientes.cod_postal_fac_cChange(Sender: TObject);
begin
  if (pais_fac_c.Text = 'ES') then
    STProvinciaFactura.Caption := desProvincia(cod_postal_fac_c.Text)
  else
    STProvinciaFactura.Caption := '';
end;

procedure TFMClientes.representante_cChange(Sender: TObject);
begin
  STRepresentante_c.Caption := desRepresentante(representante_c.Text);
end;

procedure TFMClientes.tipo_cliente_cChange(Sender: TObject);
begin
  stTipoCliente.Caption := desTipoCliente(tipo_cliente_c.Text );
end;

procedure TFMClientes.pais_dsChange(Sender: TObject);
begin
  if QSuministro.State in [dsEdit, dsInsert] then
  begin
    STPaisD.Caption := desPais(pais_ds.Text);
    if ( (  pais_c.Text = 'ES' ) and ( pais_ds.Text = '' ) ) or ( pais_ds.Text = 'ES' )  then
    begin
      cod_postal_ds.Change;
      STProvinciaD.Enabled := true;
      STProvinciaD.Visible := true;
      provincia_ds.Enabled := false;
      provincia_ds.Visible := false;
    end
    else
    begin
      STProvinciaD.Enabled := False;
      STProvinciaD.Visible := False;
      provincia_ds.Enabled := true;
      provincia_ds.Visible := true;
    end;
  end;
end;

procedure TFMClientes.cod_postal_dsChange(Sender: TObject);
begin
  if QSuministro.State in [dsEdit, dsInsert] then
  begin
    if ( (  pais_c.Text = 'ES' ) and ( pais_ds.Text = '' ) ) or ( pais_ds.Text = 'ES' )  then
    begin
      STProvinciaD.Caption := desProvincia(cod_postal_ds.Text);
    end;
  end;
end;

procedure TFMClientes.TSuministrosAfterEdit(DataSet: TDataSet);
begin
    STPaisD.Caption := desPais(pais_ds.Text);
    if ( (  pais_c.Text = 'ES' ) and ( pais_ds.Text = '' ) ) or ( pais_ds.Text = 'ES' )  then
    begin
      cod_postal_ds.Change;
      STProvinciaD.Enabled := true;
      STProvinciaD.Visible := true;
      provincia_ds.Enabled := false;
      provincia_ds.Visible := false;
    end
    else
    begin
      STProvinciaD.Enabled := False;
      STProvinciaD.Visible := False;
      provincia_ds.Enabled := true;
      provincia_ds.Visible := true;
    end;
end;


(*
procedure TFMClientes.btnSalesForceClick(Sender: TObject);
var
  URL: string;
begin
  if Trim(salescode_c.Text) <> '' then
  begin
    URL:= 'https://eu2.salesforce.com/' + salescode_c.Text;
    ShellExecute(Handle,'open',PChar(URL),nil,nil,SW_NORMAL);
  end
  else
  begin
    ShowMessage('Falta el código SalesForce del cliente.');
  end;
end;
*)

procedure TFMClientes.dir_sum_dsChange(Sender: TObject);
begin
  if ( DSDetalle.DataSet.State = dsInsert ) or ( DSDetalle.DataSet.State = dsEdit ) then
  If ( dir_sum_ds.Text = cliente_c.Text ) and  ( nombre_ds.Text = '' )then
  begin
    nombre_ds.Text:= nombre_c.Text;
    nif_ds.Text:= nif_c.Text;
    tipo_via_ds.Text:= tipo_via_c.Text;
    domicilio_ds.Text:= domicilio_c.Text;
    cod_postal_ds.Text:= cod_postal_c.Text;
    if pais_c.Text = 'ES' then
      provincia_ds.Text:= desProvincia( cod_postal_c.Text );
    poblacion_ds.Text:= poblacion_c.Text;
    pais_ds.Text:= pais_c.Text;
    telefono_ds.Text:= telefono_c.Text;
    //Email_ds.Text:= email_alb_c.Text;

    DSDetalle.dataset.fieldbyname('nombre_ds').asstring:= nombre_c.Text;
    DSDetalle.dataset.fieldbyname('nif_ds').asstring:= nif_c.Text;
    DSDetalle.dataset.fieldbyname('tipo_via_ds').asstring:= tipo_via_c.Text;
    DSDetalle.dataset.fieldbyname('domicilio_ds').asstring:= domicilio_c.Text;
    DSDetalle.dataset.fieldbyname('cod_postal_ds').asstring:= cod_postal_c.Text;
    if pais_c.Text = 'ES' then
      DSDetalle.dataset.fieldbyname('provincia_ds').asstring:= desProvincia( cod_postal_ds.Text );
    DSDetalle.dataset.fieldbyname('poblacion_ds').asstring:= poblacion_c.Text;
    DSDetalle.dataset.fieldbyname('pais_ds').asstring:= pais_c.Text;
    DSDetalle.dataset.fieldbyname('telefono_ds').asstring:= telefono_c.Text;
    //DSDetalle.dataset.fieldbyname('Email_ds').asstring:= email_alb_c.Text;
  end;
end;

procedure TFMClientes.DSMaestroDataChange(Sender: TObject; Field: TField);
begin
 if QClientes.Fieldbyname('periodo_factura_c').AsString = 'D' then
  periodo_factura_c.ItemIndex := 0
 else
 if QClientes.Fieldbyname('periodo_factura_c').AsString = 'S' then
  periodo_factura_c.ItemIndex := 1
 else
 if QClientes.Fieldbyname('periodo_factura_c').AsString = 'Q' then
  periodo_factura_c.ItemIndex := 2
 else
 if QClientes.Fieldbyname('periodo_factura_c').AsString = 'M' then
  periodo_factura_c.ItemIndex := 3
 else
  periodo_factura_c.ItemIndex := 4;

 if QClientes.Fieldbyname('albaran_factura_c').AsInteger = 0 then
  albaran_factura_c.ItemIndex := 0
 else if QClientes.Fieldbyname('albaran_factura_c').AsInteger = 1 then
  albaran_factura_c.ItemIndex := 1
 else
  albaran_factura_c.ItemIndex := 2;

end;

procedure TFMClientes.DSTesoreriaDataChange(Sender: TObject; Field: TField);
begin
  if QTesoreria.FieldByName('forma_pago_ct').AsString = '' then
  begin
    txtst1.Caption:= '';
    txtst11.Caption:= '';
    txtst2.Caption:= '';
    txtst3.Caption:= '';
    txtst4.Caption:= '';
    txtst5.Caption:= '';
    txtst6.Caption:= '';
    txtst7.Caption:= '';
    txtst8.Caption:= '';
    txtst9.Caption:= '';
    exit;
  end;

  with DMAuxDB.QDescripciones do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_forma_pago ');
    SQL.Add(' where codigo_fp = ' + QTesoreria.FieldByName('forma_pago_ct').AsString);
    Open;
    txtst1.Caption:= FieldByname('descripcion_fp').AsString;
    txtst11.Caption:= FieldByname('descripcion_fp').AsString;
    txtst2.Caption:= FieldByname('descripcion2_fp').AsString;
    txtst3.Caption:= FieldByname('descripcion3_fp').AsString;
    txtst4.Caption:= FieldByname('descripcion4_fp').AsString;
    txtst5.Caption:= FieldByname('descripcion5_fp').AsString;
    txtst6.Caption:= FieldByname('descripcion6_fp').AsString;
    txtst7.Caption:= FieldByname('descripcion7_fp').AsString;
    txtst8.Caption:= FieldByname('descripcion8_fp').AsString;
    txtst9.Caption:= FieldByname('descripcion9_fp').AsString;
    Close;
  end;
end;

procedure TFMClientes.QUnidadesCalcFields(DataSet: TDataSet);
begin
  if Trim(QUnidades.FieldByName('descripcion_ce').AsString) <> '' then
    QUnidades.FieldByName('des_Envase').AsString:= QUnidades.FieldByName('descripcion_ce').AsString
  else
    QUnidades.FieldByName('des_Envase').AsString:= desEnvase( QUnidades.FieldByName('empresa_ce').AsString, QUnidades.FieldByName('envase_ce').AsString);
end;

procedure TFMClientes.tipo_albaran_cChange(Sender: TObject);
begin
  //Descripcion tipo de albaran
  if tipo_albaran_c.Text = '0' then
    des_tipo_albaran_c.Caption:= 'ALB. SIN VALORAR'
  else
  if tipo_albaran_c.Text = '1' then
    des_tipo_albaran_c.Caption:= 'ALBARAN VALORADO'
  else
  if tipo_albaran_c.Text = '2' then
    des_tipo_albaran_c.Caption:= 'ALBARAN EN ALEMAN'
  else
  if tipo_albaran_c.Text = '3' then
    des_tipo_albaran_c.Caption:= 'ALBARAN EN INGLES'
  else
    des_tipo_albaran_c.Caption:= '';
end;

procedure TFMClientes.QClientesAfterScroll(DataSet: TDataSet);
begin
  tipo_albaran_cChange(tipo_albaran_c);
end;

procedure TFMClientes.rbRiesgosActivosClick(Sender: TObject);
begin
  if rbRiesgosTodos.Checked then
    QRiesgo.filter:= ''
  else
    QRiesgo.filter:= 'fecha_fin_cr is null';
end;

procedure TFMClientes.rbVerDireccionActivos(Sender: TObject);
begin
  if rbSuministroTodos.Checked then
    QSuministro.filter:= ''
  else
  begin
    if rbSuministroActivos.Checked then
      QSuministro.filter:= 'fecha_baja_ds is null'
    else
      QSuministro.filter:= 'fecha_baja_ds is not null';
  end;
end;

procedure TFMClientes.rbVerDescuentosClick(Sender: TObject);
begin
  if rbDescuentosTodos.Checked then
    QDescuentos.filter:= ''
  else
    QDescuentos.filter:= 'fecha_fin is null';
end;


procedure TFMClientes.rbVerGastosClick(Sender: TObject);
begin
  if rbGastosTodos.Checked then
    QGastos.filter:= ''
  else
    QGastos.filter:= 'fecha_fin_gc is null';
end;

end.








