unit UFMEntregasProveedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid,
  BDEdit, BEdit, dbTables, DError, BCalendarButton, ComCtrls, BCalendario,
  nbLabels;

type
  TFMEntregasProveedor = class(TMaestroDetalle)
    DSMaestro: TDataSource;
    PMaestro: TPanel;
    RejillaFlotante: TBGrid;
    Calendario: TBCalendario;
    observaciones_ec: TDBMemo;
    DSDetalleTotales: TDataSource;
    nbLabel24: TnbLabel;
    codigo_ec: TBDEdit;
    lObservacion: TnbLabel;
    termografo_ec: TBDEdit;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel5: TnbLabel;
    nbLabel19: TnbLabel;
    lblProveedor: TnbStaticText;
    lblEmpresa: TnbStaticText;
    btnFecha_llegada: TBCalendarButton;
    btnEmpresa_ec: TBGridButton;
    btnProveedor_ec: TBGridButton;
    nbLabel4: TnbLabel;
    nbLabel30: TnbLabel;
    btnCentroDestino: TBGridButton;
    lblCentroDestino: TnbStaticText;
    nbLabel31: TnbLabel;
    nbLabel32: TnbLabel;
    nbLabel33: TnbLabel;
    btnTransporte: TBGridButton;
    lblTransporte: TnbStaticText;
    empresa_ec: TBDEdit;
    proveedor_ec: TBDEdit;
    vehiculo_ec: TBDEdit;
    fecha_carga_ec: TBDEdit;
    albaran_ec: TBDEdit;
    centro_llegada_ec: TBDEdit;
    barco_ec: TBDEdit;
    aduana_ec: TBDEdit;
    transporte_ec: TBDEdit;
    btnAduana: TBGridButton;
    lblAduana: TnbStaticText;
    nbLabel3: TnbLabel;
    nbLabel20: TnbLabel;
    fecha_llegada_ec: TBDEdit;
    nbLabel21: TnbLabel;
    adjudicacion_ec: TBDEdit;
    nbLabel23: TnbLabel;
    nbLabel12: TnbLabel;
    peso_entrada_ec: TBDEdit;
    nbLabel6: TnbLabel;
    peso_salida_ec: TBDEdit;
    peso_carga_ec: TLabel;
    lblNombre1: TLabel;
    DBText1: TDBText;
    lblNombre2: TLabel;
    DBText2: TDBText;
    lblNombre3: TLabel;
    DBText3: TDBText;
    lblNombre4: TLabel;
    DBText4: TDBText;
    Bevel1: TBevel;
    nbLabel18: TnbLabel;
    portes_pagados_ec: TDBCheckBox;
    DSDetalle1: TDataSource;
    fecha_origen_ec: TBDEdit;
    nbLabel36: TnbLabel;
    DSCompras: TDataSource;
    mercado_local_ec: TDBCheckBox;
    PDetalle: TPanel;
    PDetalle1: TPanel;
    nbLabel10: TnbLabel;
    nbLabelCajas: TnbLabel;
    nbLabelKilos: TnbLabel;
    nbLabel8: TnbLabel;
    lblVariedad: TLabel;
    btnProductoProveedor: TBGridButton;
    nbLabel9: TnbLabel;
    nbLabel14: TnbLabel;
    btnCategoria: TBGridButton;
    btnCalibre: TBGridButton;
    lblUnidadPrecio: TnbLabel;
    nbLabel15: TnbLabel;
    lblPesoBruto: TLabel;
    lblAprovecha: TnbLabel;
    lblPorcenAprovecha: TLabel;
    nbLabel11: TnbLabel;
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
    aprovechados_el: TBDEdit;
    peso_el: TBDEdit;
    RVisualizacion1: TDBGrid;
    compra_ec: TDBCheckBox;
    DSGastosEntregas: TDataSource;
    lblTipo: TnbLabel;
    intrastat_ec: TBDEdit;
    cbbIntrastat: TComboBox;
    status_ec: TBDEdit;
    cbbstatus_ec: TComboBox;
    pnlAlmacen: TPanel;
    btnPesos: TButton;
    pnlCentral: TPanel;
    pnlDerecho: TPanel;
    pnlIzquierdo: TPanel;
    pgcInferior: TPageControl;
    tsFacturas: TTabSheet;
    dbgrejilla: TDBGrid;
    btnFacturas: TButton;
    btnFinalizar: TButton;
    btnEnvio: TButton;
    lblPesoDestrio: TnbLabel;
    peso_destrio_ec: TBDEdit;
    lblSemana: TLabel;
    lblProducto_: TnbLabel;
    producto_ec: TBDEdit;
    btnProducto: TBGridButton;
    stProducto: TnbStaticText;
    edtFechaHasta: TBEdit;
    lblFechaHasta: TnbLabel;
    btnFechaHasta: TBCalendarButton;
    btnFechaCarga: TBCalendarButton;
    btnFechaGrabacion: TBCalendarButton;
    fecha_llegada_definitiva_ec: TDBCheckBox;
    btnEntegaDirecta: TButton;
    dbtxtn_factura_fpl: TDBText;
    DSFacturaPlatano: TDataSource;
    dbtxtempresa_fpl: TDBText;
    lblFacturaPlatano: TLabel;
    nbLabel25: TnbLabel;
    almacen_el: TBDEdit;
    btnAlmacen: TBGridButton;
    lblAlmacen: TnbStaticText;
    lblAnyoSemana: TnbLabel;
    anyo_semana_ec: TBDEdit;
    lblFechaCorte: TnbLabel;
    fecha_corte_ec: TBDEdit;
    btnFechaCorte: TBCalendarButton;
    lblZona: TnbLabel;
    zona_produccion_ec: TBDEdit;
    cbbzona_produccion_ec: TComboBox;
    lblPesoCaja: TLabel;
    bvl1: TBevel;
    lbl1: TLabel;
    dlbl1: TDBText;
    lblImporte: TLabel;
    dsTotalCompra: TDataSource;
    lbl2: TLabel;
    lblDiff: TLabel;
    btnCambiarPlanta: TButton;
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
    procedure almacen_elChange(Sender: TObject);
    procedure btnTransporteClick(Sender: TObject);
    procedure centro_llegada_ecChange(Sender: TObject);
    procedure transporte_ecChange(Sender: TObject);
    procedure btnCentroDestinoClick(Sender: TObject);
    procedure btnAlmacenClick(Sender: TObject);
    procedure empresa_ecRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure btnAduanaClick(Sender: TObject);
    procedure aduana_ecChange(Sender: TObject);
    procedure variedad_elChange(Sender: TObject);
    procedure btnProductoProveedorClick(Sender: TObject);
    procedure btnProductoClick(Sender: TObject);
    procedure btnCategoriaClick(Sender: TObject);
    procedure btnCalibreClick(Sender: TObject);
    procedure RVisualizacion1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnFacturasClick(Sender: TObject);
    procedure cbxUnidad_precio_elChange(Sender: TObject);
    procedure unidad_precio_elChange(Sender: TObject);
    procedure palets_elChange(Sender: TObject);
    procedure cajas_elChange(Sender: TObject);
    procedure kilos_elChange(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure PutPesoCarga(Sender: TObject);
    procedure aprovechados_elChange(Sender: TObject);
    procedure intrastat_ecChange(Sender: TObject);
    procedure cbbIntrastatChange(Sender: TObject);
    procedure status_ecChange(Sender: TObject);
    procedure cbbstatus_ecChange(Sender: TObject);
    procedure btnPesosClick(Sender: TObject);
    procedure btnEnvioClick(Sender: TObject);
    procedure fecha_origen_ecChange(Sender: TObject);
    procedure producto_ecChange(Sender: TObject);
    procedure btnFechaHastaClick(Sender: TObject);
    procedure btnFechaGrabacionClick(Sender: TObject);
    procedure btnFechaCargaClick(Sender: TObject);
    procedure calibre_elChange(Sender: TObject);
    procedure btnEntegaDirectaClick(Sender: TObject);
    procedure cbbzona_produccion_ecChange(Sender: TObject);
    procedure zona_produccion_ecChange(Sender: TObject);
    procedure DSDetalleTotalesDataChange(Sender: TObject; Field: TField);
    procedure dsTotalCompraDataChange(Sender: TObject; Field: TField);
    procedure btnCambiarPlantaClick(Sender: TObject);
    procedure RVisualizacion1DblClick(Sender: TObject);
  private
    { Private declarations }
    Lista, ListaDetalle: TList;
    Objeto: TObject;

    sAlmacen, sCategoria, sCalibre: string;
    iUnidadPrecio, iCajasPaleta, iUnidadesCaja: integer;
    rPesoPaleta, rPesoCaja: Real;
    sAlbaranAux: string;

    rPrecioLinea: Real;
    iUnidadLinea: Integer;

    procedure ValorarPor;

    procedure ValidarEntradaMaestro;
    procedure ValidarAnyoSemana;
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
    procedure GetUnidadesCoco;

    procedure PutKilosCaja;
    procedure DiferenciasLineaCompra;

    procedure BuscarEntrega( const ACodigo: string );


  public
    { Public declarations }
    procedure Borrar; override;

    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    //Listado
    procedure Previsualizar; override;
    procedure PrevisualizarResto;
    procedure PrevisualizarMaset;

    procedure QEntregasAfterPost(DataSet: TDataSet);

    procedure Altas; Override;
  end;



implementation

//uses  bMath, UQREntregasMaset, CFPCamionEntrega, UFMEntregasCompra;

uses CVariables, CGestionPrincipal, UDMBaseDatos, CAuxiliarDB, bMath, bTimeUtils,
  Principal, UDMAuxDB, Variants, bSQLUtils, bTextUtils, Dpreview,
  UQREntregas, UMDEntregas, UQREntregasMaset, CReportes, CMaestro, UDMConfig,
  UFProductosProveedor, UFTransportistas, UFMEntregasGastos, UFProveedores,
  EntregasCB, CDBEntregas, CFPCamionEntrega, UFMComparaEntregaVsRF,
  DateUtils, AdvertenciaFD, CambiarCodigoEntregaFD, PutPrecioLineaEntregaFD;

{$R *.DFM}


procedure TFMEntregasProveedor.AbrirTablas;
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
  Registro := 1;
  Registros := 0;
  RegistrosInsertados := 0;
end;

procedure TFMEntregasProveedor.CerrarTablas;
begin
  CloseAuxQuerys;
end;

procedure TFMEntregasProveedor.FormCreate(Sender: TObject);
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
  DSDetalleTotales.DataSet:= MDEntregas.QTotalLineas;
  dsTotalCompra.DataSet:= MDEntregas.QTotalFacturaCompra;

  DataSetMaestro := MDEntregas.QEntregasC;
  DataSourceDetalle := DSDetalle1;

  (*TODO*)
  Select := 'select * From frf_entregas_c';
  where := ' Where empresa_ec = ''###''';
  Order := ' Order by fecha_llegada_ec desc, fecha_origen_ec desc, codigo_ec DESC';

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
  FocoDetalle := almacen_el;
  Calendario.Date := date;

  (*TODO*)
  //Constantes para las rejillas de l combo
  empresa_ec.Tag:= kEmpresa;
  centro_llegada_ec.Tag:= kCentro;
  proveedor_ec.Tag:= kProveedor;
  almacen_el.Tag:= kProveedorAlmacen;
  fecha_llegada_ec.Tag:= kCalendar;
  fecha_carga_ec.Tag:= kCalendar;
  fecha_origen_ec.Tag:= kCalendar;
  edtFechaHasta.Tag:= kCalendar;
  transporte_ec.Tag:= kTransportista;
  aduana_ec.Tag:= kAduana;
  producto_ec.Tag:= kProducto;
  categoria_el.Tag:= kCategoria;
  calibre_el.Tag:= kCalibre;

  empresa_ec.Change;
  proveedor_ec.Change;

  lblSemana.Caption:= '';

  (*Configuracion segun version*)
  pnlAlmacen.Visible:= not DMConfig.EsLaFont;
  pnlCentral.Visible:= DMConfig.EsLaFont;

  FocoDetalle := almacen_el;

end;

procedure TFMEntregasProveedor.PreparaAlta;
begin
  codigo_ec.Enabled:= False;

  if pnlAlmacen.Visible then
  begin
    pnlAlmacen.Enabled:= False;
    btnPesos.Enabled:= False;
    btnFinalizar.Enabled:= False;
  end;

  if pnlCentral.Visible then
  begin
    pnlCentral.Enabled:= False;
    btnFacturas.Enabled:= False;
    btnEnvio.Enabled:= False;
    btnEntegaDirecta.Enabled:= False;
    btnCambiarPlanta.Enabled:= False;
  end;
end;

procedure TFMEntregasProveedor.AntesDeVisualizar;
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

  if pnlAlmacen.Visible then
  begin
    pnlAlmacen.Enabled:= True;
    btnPesos.Enabled:= (DMConfig.EsMaset or DMConfig.EsFrutibon);
    btnFinalizar.Enabled:= True;
  end;

  if pnlCentral.Visible then
  begin
    pnlCentral.Enabled:= True;
    btnFacturas.Enabled:= True;
    btnEnvio.Enabled:= True;
    btnEntegaDirecta.Enabled:= True;
    btnCambiarPlanta.Enabled:= True;
  end;

  status_ec.Enabled:= False;
  cbbstatus_ec.Enabled:= False;

  lblFechaHasta.Visible:= False;
  edtFechaHasta.Visible:= False;
  btnFechaHasta.Visible:= False;
end;

procedure TFMEntregasProveedor.Altas;
begin
  if not DMConfig.EsLaFontEx then
  begin
    ShowMessage('Las compras deben de grabarse en la central.' + #13 + #10 +
                  '' + #13 + #10 +
                  '* OPERACIÓN' + #13 + #10 +
                  '****************************************' + #13 + #10 +
                  ' 1º el personal de compras graba la compra en la central' + #13 + #10 +
                  ' 2º los administrativos del almacén reciben la compra de la central' + #13 + #10 +
                  ' 3º una vez descargada, los administrativos del almacén envían la compra central para actualizar datos' + #13 + #10 +
                  ' -> las facturas/gastos de la compra se graban en la central' + #13 + #10 );
    Exit;
  end;
  inherited;
(*
  if not DMConfig.EsLaFont then
  begin
    ShowMessage('Las compras deben de grabarse en la central.' + #13 + #10 +
                  '' + #13 + #10 +
                  '* OPERACIÓN' + #13 + #10 +
                  '****************************************' + #13 + #10 +
                  ' 1º el personal de compras grabara la compra en la central (si no puede, avisar a informática).' + #13 + #10 +
                  ' 2º el personal de compras avisara al los administrativos del almacén que tienen entregas por recibir.' + #13 + #10 +
                  ' 3º los administrativos del almacén bajaran la entrega de la central (opción de recibir en Comercial).' + #13 + #10 +
                  ' 4º una vez descargada, los administrativos del almacén reenviarán la compra a la central (opción de envío en Comercial).' + #13 + #10 +
                  ' -> las facturas/gastos de la compra se graban en la central' + #13 + #10 +
                  '' + #13 + #10 );

    Exit;
  end;
*)
end;

procedure TFMEntregasProveedor.AntesDeInsertar;
begin
  codigo_ec.Enabled:= False;

  //Fecha de grabacion
  DSMaestro.DataSet.FieldByName('fecha_origen_ec').AsDateTime:= Date;
  DSMaestro.DataSet.FieldByName('fecha_carga_ec').AsDateTime:= Date;

  empresa_ec.Text:= gsDefEmpresa;
  centro_llegada_ec.Text:= gsDefCentro;
  fecha_llegada_ec.Text:= DateToStr( date );
  fecha_carga_ec.Text:= DateToStr( date );

  anyo_semana_ec.Text:= AnyoSemana( Date );

  aduana_ec.Text:= '0';

  fecha_llegada_definitiva_ec.Checked:= False;
  fecha_llegada_definitiva_ec.AllowGrayed:= False;

  portes_pagados_ec.Checked:= False;
  portes_pagados_ec.AllowGrayed:= False;

  mercado_local_ec.Checked:= False;
  mercado_local_ec.AllowGrayed:= False;

  //compra_ec.Checked:= False;
  compra_ec.AllowGrayed:= False;

  if pnlAlmacen.Visible then
  begin
    pnlAlmacen.Enabled:= False;
    btnPesos.Enabled:= False;
    btnFinalizar.Enabled:= False;
  end;

  if pnlCentral.Visible then
  begin
    pnlCentral.Enabled:= False;
    btnFacturas.Enabled:= False;
    btnEnvio.Enabled:= false;
    btnEntegaDirecta.Enabled:= False;
    btnCambiarPlanta.Enabled:= False;
  end;

  peso_entrada_ec.Text:= '0';
  peso_salida_ec.Text:= '0';

  sAlbaranAux:= '';

end;

procedure TFMEntregasProveedor.AntesDeModificar;
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

  sAlbaranAux:= empresa_ec.Text + proveedor_ec.Text + fecha_carga_ec.Text + albaran_ec.Text;

  fecha_llegada_definitiva_ec.AllowGrayed:= False;  
  portes_pagados_ec.AllowGrayed:= False;
  mercado_local_ec.AllowGrayed:= False;
  compra_ec.AllowGrayed:= False;

  if pnlAlmacen.Visible then
  begin
    pnlAlmacen.Enabled:= False;
    btnPesos.Enabled:= False;
    btnFinalizar.Enabled:= False;
  end;

  if pnlCentral.Visible then
  begin
    pnlCentral.Enabled:= False;
    btnFacturas.Enabled:= False;
    btnEnvio.Enabled:= False;
    btnEntegaDirecta.Enabled:= False;
    btnCambiarPlanta.Enabled:= False;
  end;

end;

procedure TFMEntregasProveedor.AntesDeLocalizar;
begin
  status_ec.Enabled:= True;
  cbbstatus_ec.Enabled:= True;

  fecha_llegada_definitiva_ec.AllowGrayed:= True;
  portes_pagados_ec.AllowGrayed:= True;
  mercado_local_ec.AllowGrayed:= True;
  compra_ec.AllowGrayed:= True;

  lblFechaHasta.Visible:= True;
  edtFechaHasta.Visible:= True;
  btnFechaHasta.Visible:= True;
  edtFechaHasta.Text:= '';

  if pnlAlmacen.Visible then
  begin
    pnlAlmacen.Enabled:= False;
    btnPesos.Enabled:= False;
    btnFinalizar.Enabled:= False;
  end;

  if pnlCentral.Visible then
  begin
    pnlCentral.Enabled:= False;
    btnFacturas.Enabled:= False;
    btnEnvio.Enabled:= False;
    btnEntegaDirecta.Enabled:= False;
    btnCambiarPlanta.Enabled:= False;
  end;
end;

procedure TFMEntregasProveedor.FormActivate(Sender: TObject);
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

procedure TFMEntregasProveedor.FormClose(Sender: TObject; var Action: TCloseAction);
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

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

{+ CUIDADIN }

procedure TFMEntregasProveedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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
    Ord('G'):
      if ssAlt in Shift  then
        MantenimientoGastos;
    vk_f2:
    begin
      if empresa_ec.Focused then btnEmpresa_ec.Click
      else if proveedor_ec.Focused then btnProveedor_ec.Click
      else if almacen_el.Focused then btnAlmacen.Click
      else if centro_llegada_ec.Focused then btnCentroDestino.Click
      else if fecha_llegada_ec.Focused then btnFecha_llegada.Click
      else if fecha_carga_ec.Focused then btnFechaCarga.Click
      else if fecha_origen_ec.Focused then btnFechaGrabacion.Click
      else if edtFechaHasta.Focused then btnFechaHasta.Click
      else if transporte_ec.Focused then btnTransporte.Click
      else if aduana_ec.Focused then btnAduana.Click
      else if producto_ec.Focused then btnProducto.Click
      else if categoria_el.Focused then btnCategoria.Click
      else if calibre_el.Focused then btnCalibre.Click
      else if variedad_el.Focused then btnProductoProveedor.Click;
    end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

procedure TFMEntregasProveedor.Filtro;
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
        if ( Trim(Text) <> '' ) and ( name <> 'fecha_llegada_ec' ) and ( name <> 'edtFechaHasta' ) then
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
            begin
              where := where + ' ' + name + ' =' + SQLDate(Text)
            end
            else
              where := where + ' ' + name + ' =' + Text;
          flag := True;
        end;
      end;
    end;
  end;

  if fecha_llegada_ec.Text <> '' then
  begin
    if flag then where := where + ' and ';
    if edtFechaHasta.Text <> '' then
    begin
      where := where + ' fecha_llegada_ec between ' + SQLDate(fecha_llegada_ec.Text) + ' and ' + SQLDate(edtFechaHasta.Text);
    end
    else
    begin
      where := where + ' fecha_llegada_ec = ' + SQLDate(fecha_llegada_ec.Text);
    end;
    flag:= TRue;
  end;

  if ( fecha_llegada_definitiva_ec.State = cbUnchecked ) or
     ( fecha_llegada_definitiva_ec.State = cbChecked ) then
  begin
    if flag then where := where + ' and ';
    if fecha_llegada_definitiva_ec.State = cbUnchecked then
    begin
      where := where + ' fecha_llegada_definitiva_ec = 0 ';
    end
    else
    if fecha_llegada_definitiva_ec.State = cbChecked then
    begin
      where := where + ' fecha_llegada_definitiva_ec <> 0 ';
    end;
    flag:= TRue;
  end;

  if ( portes_pagados_ec.State = cbUnchecked ) or
     ( portes_pagados_ec.State = cbChecked ) then
  begin
    if flag then where := where + ' and ';
    if portes_pagados_ec.State = cbUnchecked then
    begin
      where := where + ' portes_pagados_ec = 0 ';
    end
    else
    if portes_pagados_ec.State = cbChecked then
    begin
      where := where + ' portes_pagados_ec <> 0 ';
    end;
    flag:= TRue;
  end;

  if ( mercado_local_ec.State = cbUnchecked ) or
     ( mercado_local_ec.State = cbChecked ) then
  begin
    if flag then where := where + ' and ';
    if mercado_local_ec.State = cbUnchecked then
    begin
      where := where + ' mercado_local_ec = 0 ';
    end
    else
    if mercado_local_ec.State = cbChecked then
    begin
      where := where + ' mercado_local_ec <> 0 ';
    end;
    flag:= TRue;
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

procedure TFMEntregasProveedor.AnyadirRegistro;
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

procedure TFMEntregasProveedor.QEntregasAfterPost(DataSet: TDataSet);
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
end;

procedure TFMEntregasProveedor.ValidarEntradaMaestro;
var
  i: Integer;
  dFecha: TdateTime;
  bFlag: boolean;
  sAux: string;
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

  if stProducto.Caption = '' then
  begin
    if not EsProductoAlta( producto_ec.Text) then
      raise Exception.Create(' ATENCIÓN: Error al grabar la linea, el producto está dado de BAJA. ')
    else
      raise Exception.Create('El código de producto no es correcto.');
  end;

  //El albaran del proveedor es obligatorio
  if Trim( albaran_ec.Text ) = '' then
    raise Exception.Create('Faltan el albarán del proveedor.');

  //Fecha de llegada
  if not TryStrToDate( fecha_llegada_ec.Text, dFecha ) then
    raise Exception.Create('Faltan fecha de llegada o es incorrecta.');

  //PONER CODIGO
  if DSMaestro.DataSet.State = dsInsert then
  begin
    DSMaestro.DataSet.FieldByName('codigo_ec').AsString:= GetCodigoEntrega( empresa_ec.Text, centro_llegada_ec.Text, fecha_llegada_ec.Text );
    DSMaestro.DataSet.FieldByName('centro_origen_ec').AsString:= centro_llegada_ec.Text;
  end;

  //Comprobar que el codigo de albaran es unico
  //Comprobar que el codigo de albaran es unico
  if sAlbaranAux <> empresa_ec.Text + proveedor_ec.Text + fecha_carga_ec.Text + albaran_ec.Text then
  if CDBEntregas.ExisteAlbaranProveedor( empresa_ec.Text, proveedor_ec.Text, fecha_carga_ec.Text, albaran_ec.Text ) then
  begin
    raise Exception.Create('Albarán de proveedor duplicado.');
  end;

  //Tipo de compra
  if not ( ( intrastat_ec.Text = 'A' ) or ( intrastat_ec.Text = 'C' )  or
           ( intrastat_ec.Text = 'I' )  or ( intrastat_ec.Text = 'N'  ) or
           ( intrastat_ec.Text = 'S'  ) )then
  begin
    intrastat_ec.SetFocus;
    raise Exception.Create('Falta el tipo de compra o es incorrecta.');
  end
  else
  begin
    sAux:= IntrastatProveedor( empresa_ec.Text, proveedor_ec.Text );
    if ( sAux <> intrastat_ec.Text ) and ( sAux <> '' ) then
    begin
      if sAux = 'N' then sAux:= 'NACIONAL'
      else if sAux = 'C' then sAux:= 'COMUNITARIO'
      else if sAux = 'I' then sAux:= 'IMPORTACIÓN';
      if MessageDlg( 'El proveedor esta marcado como "' + sAux +  '" y esta seleccionado "' + cbbIntrastat.Text +'".' + #13 + #10 +
                     '¿Seguro que desea continuar?' , mtWarning, [mbYes, mbNo], 0  ) = mrNo then
      begin
        raise Exception.Create('Operación abortada por el usuario.');
      end;
    end;
  end;

  ValidarAnyoSemana;

  if status_ec.Text = '' then
    DSMaestro.DataSet.FieldByName('status_ec').Asinteger:= 0;

  if mercado_local_ec.State = cbChecked then
  begin
    DSMaestro.DataSet.FieldByName('mercado_local_ec').Asinteger:= 1;
  end
  else
  begin
    DSMaestro.DataSet.FieldByName('mercado_local_ec').Asinteger:= 0;
  end;

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
    compra_ec.SetFocus;
    raise Exception.Create('Debe seleccionar si la entrega es una compra a tercero o una entrega de proveedor a liquidar.');
  end;
  if portes_pagados_ec.Checked then
  begin
    DSMaestro.DataSet.FieldByName('portes_pagados_ec').Asinteger:= 1;
  end
  else
  begin
    DSMaestro.DataSet.FieldByName('portes_pagados_ec').Asinteger:= 0;
  end;
  if fecha_llegada_definitiva_ec.Checked then
  begin
    DSMaestro.DataSet.FieldByName('fecha_llegada_definitiva_ec').Asinteger:= 1;
  end
  else
  begin
    DSMaestro.DataSet.FieldByName('fecha_llegada_definitiva_ec').Asinteger:= 0;
  end;

  if producto_ec.Text = 'PLA' then
  begin
    //Fecha de corte y zona de produccion
    bFlag:= False;
    if not TryStrToDate( fecha_corte_ec.Text, dFEcha ) then
    begin
      bFlag:= True;
      //intrastat_ec.SetFocus;
      //raise Exception.Create('Falta la fecha de corte del platano o es incorrecta.');
    end;
    if not ( ( zona_produccion_ec.Text = 'TN' ) or  ( zona_produccion_ec.Text = 'TS' ) or ( zona_produccion_ec.Text = 'GC' ) or ( zona_produccion_ec.Text = 'LP' ) ) then
    begin
      bFlag:= True;
      //zona_produccion_ec.SetFocus;
      //raise Exception.Create('Falta la zona de producción del platano o es incorrecta.');
    end;
    if bFlag then
    begin
      if MessageDlg( 'Falta la fecha de corte y/o la zona de producción del plátano.' + #13 + #10 +
                     '¿Seguro que quiere salir sin grabrar estos valores?' , mtWarning, [mbYes, mbNo], 0  ) = mrNo then
      begin
        raise Exception.Create('Operación abortada por el usuario.');
      end;
    end;
  end;
end;

function GetMaxWeek( const AYear: integer ): integer;
var
  dDate: TDate;
begin
  dDate:= EncodeDate(AYear,12,31) ;
  while WeekOf( dDate ) = 1 do
     dDate:= dDate- 1;
  Result:= WeekOf( dDate );
end;


procedure TFMEntregasProveedor.ValidarAnyoSemana;
var
  bFlag: Boolean;
  iYear, iWeek, iAux, iCorte: Integer;
begin
  (*OBLIGATORIO PARA EL PLATANO*)
  bFlag:= ( producto_ec.Text = 'PLA' ) and ( Copy(empresa_ec.Text,1,1) = 'F' );
  (*O SI TIENE VALOR*)
  bFlag:= bFlag or ( ( Length( anyo_semana_ec.Text ) > 0 ) and ( Length( anyo_semana_ec.Text ) <> 6 ) );
  if bFlag then
  begin
    if Length( anyo_semana_ec.Text ) <> 6 then
    begin
      raise Exception.Create('El Año/Semana Fruta es obligatorio para el platano y su formato debe ser "AAAASS" donde "AAAA" es el año y "SS" la semana.' + #13 + #10 +
                           'Debe de tener 6 digitos.' );
    end;

    if TryStrToInt( anyo_semana_ec.Text, iAux ) then
    begin
      //Comprobar año
      iYear:= iAux div 100;
      iCorte:= YearOf( StrToDate( fecha_origen_ec.Text ) );
      if ( iYear < iCorte - 1 ) or ( iYear > iCorte + 1 ) then
      begin
        raise Exception.Create('El fomato para el Año/Semana Fruta debe ser "AAAASS" donde "AAAA" es el año y "SS" la semana.' + #13 + #10 +
                           'Año ' + IntToStr( iYear) + ' no valido. El año debe de estar entre el ' + IntToStr( iCorte - 1 )+ ' y el ' + IntToStr( iCorte + 1 )+ '.' );
      end;
      iCorte:= GetMaxWeek( iYear );
      iWeek:= iAux mod 100;
      if ( iWeek < 1 ) or ( iWeek > iCorte ) then
      begin
        raise Exception.Create('El fomato para el Año/Semana Fruta debe ser "AAAASS" donde "AAAA" es el año y "SS" la semana.' + #13 + #10 +
                             'Semana ' + IntToStr( iWeek) + ' incorrecta. Para el año '+ IntToStr( iYear ) + ' debe de estar entre la 01 y la ' + IntToStr( iCorte )+ '.' );
      end;
    end
    else
    begin
      raise Exception.Create('El fomato para el Año/Semana Fruta debe ser "AAAASS" donde "AAAA" es el año y "SS" la semana.' + #13 + #10 +
                             'Todos los caracteres deben ser numéricos.' );
    end;
  end;
end;

procedure TFMEntregasProveedor.ValidarEntradaDetalle;
var
  rCajas, rKilos, rKilosCaja: Real;
begin
    //Linea
    DSDetalle1.DataSet.FieldByName('codigo_el').AsString:= DSMaestro.DataSet.FieldByName('codigo_ec').AsString;
    DSDetalle1.DataSet.FieldByName('empresa_el').AsString:= DSMaestro.DataSet.FieldByName('empresa_ec').AsString;
    DSDetalle1.DataSet.FieldByName('proveedor_el').AsString:= DSMaestro.DataSet.FieldByName('proveedor_ec').AsString;
    DSDetalle1.DataSet.FieldByName('producto_el').AsString:= DSMaestro.DataSet.FieldByName('producto_ec').AsString;

    if DSDetalle1.DataSet.FieldByName('precio_el').AsString = '' then
      DSDetalle1.DataSet.FieldByName('precio_el').AsFloat:= 0;

    if DSDetalle1.DataSet.State = dsEdit then
    begin
      if sAlmacen <> almacen_el.Text then
      if Trim(almacen_el.Text) = '' then
      begin
        ShowMEssage('Al almacén/finca del proveedor es de obligada inserción.');
        Abort;
      end;
      if sCategoria <> categoria_el.Text then
      if Trim(categoria_el.Text) = '' then
      begin
        ShowMEssage('La categoria es de obligada inserción.');
        Abort;
      end;
      if sCalibre <> calibre_el.Text then
      if Trim(calibre_el.Text) = '' then
      begin
        ShowMEssage('El calibre es de obligada inserción.');
        Abort;
      end;
    end;


    rCajas:= StrToFloatDef( cajas_el.Text, 0 );
    if rCajas = 0 then
    begin
      ShowMEssage('Falta el número de cajas.');
      Abort;
    end;
    rKilos:= StrToFloatDef( kilos_el.Text, 0 );
    if rKilos = 0 then
    begin
      ShowMEssage('Falta el número de kilos.');
      Abort;
    end;
    rKilosCaja:= rKilos / rCajas;
    if rKilosCaja < 5 then
    begin
      if AdvertenciaFD.VerAdvertencia( self, 'El peso medio de la caja es inferior a 5 kgs (' +  FormatFloat('#.00', rKilosCaja ) + ' kgs/caja.), ¿seguro que es correcto?.' ) = mrOk then
      begin
        Abort;
      end;
    end
    else
    if rKilosCaja > 30 then
    begin
      if AdvertenciaFD.VerAdvertencia( self, 'El peso medio de la caja es superior a 30 kgs (' +  FormatFloat('#.00', rKilosCaja ) + ' kgs/caja.), ¿seguro que es correcto?.' ) = mrOk then
      begin
        Abort;
      end;
    end;



    (*
    if producto_ec.Text = 'PLA' then
    begin
      if ( categoria_el.Text <> '1' ) and ( categoria_el.Text <> '2' )and ( categoria_el.Text <> '10' ) and
         ( categoria_el.Text <> 'EX' ) and ( categoria_el.Text <> 'SE' ) then
      begin
        ShowMEssage('La categoria para el plátano solo puede ser 2 (segunda), 1 (primera), EX (extra), SE ( superextra) o 10 (platano 10).');
        Abort;
      end;
    end;
    *)
end;

function TFMEntregasProveedor.RegistroActual: String;
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

procedure TFMEntregasProveedor.Previsualizar;
begin
  //De momento solo se grabarn los aprovechamientos en Maset de Seva
  if ( empresa_ec.Text = '037' ) OR
     ( empresa_ec.Text = 'F17' ) OR
     ( empresa_ec.Text = 'F23' ) OR
     ( empresa_ec.Text = 'F24' ) then
  begin
    PrevisualizarMaset;
  end
  else
  begin
    PrevisualizarResto;
  end;
end;

procedure TFMEntregasProveedor.PrevisualizarResto;
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


      if not ( DMConfig.EsLaFont ) then
      begin
        MDEntregas.QueryPacking( False );
        MDEntregas.TListPackingList.Open;
        MDEntregas.TListFechasPacking.Open;
        MDEntregas.TListStatusPacking.Open;
        MDEntregas.TListCalibrePacking.Open;
        MDEntregas.qryCategoriaPacking.Open;
      end;


      MDEntregas.TListGastosEntregas.Open;

      PonLogoGrupoBonnysa( QREntregas, empresa_ec.Text );
      //QREntregas.PonBarCode( codigo_ec.Text );
      Preview(QREntregas);
    finally
      if not ( DMConfig.EsLaFont) then
      begin
        MDEntregas.qryCategoriaPacking.Close;
        MDEntregas.TListCalibrePacking.Close;
        MDEntregas.TListStatusPacking.Close;
        MDEntregas.TListFechasPacking.Close;
        MDEntregas.TListPackingList.Close;
      end;
      MDEntregas.TListGastosEntregas.Close;

      MDEntregas.TListEntregasL.Close;
      MDEntregas.QListEntregasC.Close;
    end;
  except
    FreeAndNil(QREntregas);
    raise;
  end;
end;

procedure TFMEntregasProveedor.PrevisualizarMaset;
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


      if not ( DMConfig.EsLaFont ) then
      begin
        MDEntregas.QueryPacking( False );
        MDEntregas.TListPackingList.Open;
        MDEntregas.TListFechasPacking.Open;
        MDEntregas.TListStatusPacking.Open;
        MDEntregas.TListCalibrePacking.Open;
        MDEntregas.qryCategoriaPacking.Open;
      end;


      MDEntregas.TListGastosEntregas.Open;

      PonLogoGrupoBonnysa( QREntregasMaset, empresa_ec.Text );
      //QREntregasMaset.PonBarCode( codigo_ec.Text );
      Preview(QREntregasMaset);
    finally
      if not ( DMConfig.EsLaFont ) then
      begin
        MDEntregas.TListFechasPacking.Close;
        MDEntregas.TListPackingList.Close;
        MDEntregas.TListStatusPacking.Close;
        MDEntregas.TListCalibrePacking.Close;
        MDEntregas.qryCategoriaPacking.Close;
      end;
      MDEntregas.TListGastosEntregas.Close;

      MDEntregas.TListEntregasL.Close;
      MDEntregas.QListEntregasC.Close;
    end;
  except
    FreeAndNil(QREntregasMaset);
    raise;
  end;
end;


procedure TFMEntregasProveedor.VerDetalle;
begin
  PanelDetalle.visible := False;

  PMaestro.Height:= 364;
  observaciones_ec.Visible:= True;
  lObservacion.Visible:= True;

  if pnlAlmacen.Visible then
  begin
    pnlAlmacen.Enabled:= True;
    btnPesos.Enabled:= (DMConfig.EsMaset or DMConfig.EsFrutibon);
    btnFinalizar.Enabled:= True;
  end;

  if pnlCentral.Visible then
  begin
    pnlCentral.Enabled:= True;
    btnFacturas.Enabled:= True;
    btnEnvio.Enabled:= True;
    btnEntegaDirecta.Enabled:= True;
    btnCambiarPlanta.Enabled:= True;
  end;
end;

procedure TFMEntregasProveedor.EditarDetalle;
begin
  DataSourceDetalle := DSDetalle1;
  PanelDetalle := PDetalle1;
  RejillaVisualizacion := RVisualizacion1;

  PanelDetalle.visible := True;

  observaciones_ec.Visible:= False;
  lObservacion.Visible:= False;
  PMaestro.Height:= 285;

  sAlmacen:= almacen_el.Text;
  sCategoria:= categoria_el.Text;
  sCalibre:= calibre_el.Text;

  if pnlAlmacen.Visible then
  begin
    pnlAlmacen.Enabled:= False;
    btnPesos.Enabled:= False;
    btnFinalizar.Enabled:= False;
  end;

  if pnlCentral.Visible then
  begin
    pnlCentral.Enabled:= False;
    btnFacturas.Enabled:= False;
    btnEnvio.Enabled:= False;
    btnEntegaDirecta.Enabled:= True;
    btnCambiarPlanta.Enabled:= True;
  end;


  if EstadoDetalle = tedAlta then
  begin
    iUnidadPrecio:= -1;
  end
  else
  begin
    iUnidadPrecio:= -2;
  end;

  variedad_elChange( variedad_el );
  PesoBruto;
  almacen_elChange( almacen_el );
end;


procedure TFMEntregasProveedor.Borrar;
begin
  if application.MessageBox('Esta usted seguro de querer borrar la cabecera con todas sus lineas?',
    '  ATENCIÓN !', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDCANCEL then
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


procedure TFMEntregasProveedor.empresa_ecChange(Sender: TObject);
begin
  lblEmpresa.Caption := desEmpresa(empresa_ec.Text);
  lblCentroDestino.Caption := desCentro(empresa_ec.Text, centro_llegada_ec.Text);
  lblProveedor.Caption := desProveedor(empresa_ec.Text, proveedor_ec.Text);
  lblTransporte.Caption := desTransporte(empresa_ec.Text, transporte_ec.Text);
  stProducto.Caption:= desProducto( empresa_ec.Text, producto_ec.Text);
end;

procedure TFMEntregasProveedor.centro_llegada_ecChange(Sender: TObject);
begin
  lblCentroDestino.Caption := desCentro(empresa_ec.Text, centro_llegada_ec.Text);
end;

procedure TFMEntregasProveedor.proveedor_ecChange(Sender: TObject);
begin
  lblProveedor.Caption := desProveedor(empresa_ec.Text, proveedor_ec.Text);
  if ( lblProveedor.Caption <> '' ) and
     ( ( ( Estado = teAlta ) and  ( DSMaestro.State = dsInsert ) ) or
       ( ( Estado = teModificar ) and ( DSMaestro.State = dsEdit ) ) ) then
  begin
    if intrastat_ec.Text = '' then
    begin
      intrastat_ec.Text:= IntrastatProveedor( empresa_ec.Text, proveedor_ec.Text );
    end;
  end;
end;

procedure TFMEntregasProveedor.almacen_elChange(Sender: TObject);
begin
  lblAlmacen.Caption := desProveedorAlmacen(empresa_ec.Text, proveedor_ec.Text, almacen_el.Text);
end;

procedure TFMEntregasProveedor.transporte_ecChange(Sender: TObject);
begin
  lblTransporte.Caption := desTransporte(empresa_ec.Text, transporte_ec.Text);
end;

procedure TFMEntregasProveedor.btnFecha_llegadaClick(Sender: TObject);
begin
  if fecha_llegada_ec.Focused then
    DespliegaCalendario( btnFecha_llegada );
end;

procedure TFMEntregasProveedor.btnFechaHastaClick(Sender: TObject);
begin
  if edtFechaHasta.Focused then
    DespliegaCalendario( btnFechaHasta );
end;

procedure TFMEntregasProveedor.btnFechaGrabacionClick(Sender: TObject);
begin
  if fecha_origen_ec.Focused then
    DespliegaCalendario( btnFechaGrabacion );
end;

procedure TFMEntregasProveedor.btnFechaCargaClick(Sender: TObject);
begin
  if fecha_carga_ec.Focused then
    DespliegaCalendario( btnFechaCarga );
end;

procedure TFMEntregasProveedor.btnEmpresa_ecClick(Sender: TObject);
begin
  if empresa_ec.Focused then
    DespliegaRejilla( btnEmpresa_ec );
end;

procedure TFMEntregasProveedor.btnCentroDestinoClick(Sender: TObject);
begin
  if centro_llegada_ec.Focused then
    DespliegaRejilla( btnCentroDestino, [empresa_ec.Text] );
end;

procedure TFMEntregasProveedor.btnProveedor_ecClick(Sender: TObject);
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
procedure TFMEntregasProveedor.btnAlmacenClick(Sender: TObject);
begin
  if almacen_el.Focused then
    DespliegaRejilla( btnAlmacen, [proveedor_ec.Text] );
end;

procedure TFMEntregasProveedor.btnTransporteClick(Sender: TObject);
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

procedure TFMEntregasProveedor.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  ShowMessage('H' + UMDEntregas.MDEntregas.QTotalLineas.FieldByName('palets').AsString);
end;

procedure TFMEntregasProveedor.ValorarPor;
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
    ParamByName('producto').AsString:= proveedor_ec.Text;
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
      //Para la piña y el coco
      GetUnidadesCoco;
    end;
    Close;
  end;
end;

procedure TFMEntregasProveedor.calibre_elChange(Sender: TObject);
begin
  GetUnidadesCoco;
  cajas_elChange( cajas_el  );
end;

procedure TFMEntregasProveedor.GetUnidadesCoco;
var
  sAux: string;
begin
  if ( DSMaestro.DataSet.FieldByName('producto_ec').AsString = 'C' ) or
     ( DSMaestro.DataSet.FieldByName('producto_ec').AsString = 'A' ) then
  begin
    sAux:= calibre_el.Text;
    if sAux <> '' then
    begin
      iUnidadesCaja:= StrToIntDef( sAux, -1 );
      if iUnidadesCaja = -1  then
      begin
        iUnidadesCaja:= StrToIntDef( Copy( sAux, 2, Length( sAux ) -1 ), 0 );
      end;
    end
    else
    begin
      iUnidadesCaja:= 0;
    end;
  end;
end;

procedure TFMEntregasProveedor.empresa_ecRequiredTime(Sender: TObject;
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

procedure TFMEntregasProveedor.btnAduanaClick(Sender: TObject);
begin
  if aduana_ec.Focused then
    DespliegaRejilla( btnAduana, [] );
end;

procedure TFMEntregasProveedor.aduana_ecChange(Sender: TObject);
begin
  lblAduana.Caption := desAduana(aduana_ec.Text);
end;

procedure TFMEntregasProveedor.variedad_elChange(Sender: TObject);
begin
  if not lblVariedad.visible then
    Exit;

  lblVariedad.Caption:= DesVariedad( empresa_ec.Text, proveedor_ec.Text,
                                     producto_ec.Text, variedad_el.Text );
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

procedure TFMEntregasProveedor.btnProductoProveedorClick(Sender: TObject);
var
  sResult: string;
begin
  if variedad_el.Focused then
  if SeleccionaProductoProvedor( self, variedad_el, empresa_ec.Text, proveedor_ec.Text, producto_ec.Text, sResult ) then
  begin
    variedad_el.Text:= sResult;
  end;
end;

procedure TFMEntregasProveedor.btnProductoClick(Sender: TObject);
begin
  if producto_ec.Focused then
    DespliegaRejilla( btnProducto, [empresa_ec.text], TRUE );    //ultimo parametro, FALSE - TODOS, TRUE - solo articulos de alta
end;

procedure TFMEntregasProveedor.btnCategoriaClick(Sender: TObject);
begin
  if categoria_el.Focused then
    DespliegaRejilla( btnCategoria, [empresa_ec.text, producto_ec.Text] );
end;

procedure TFMEntregasProveedor.btnCalibreClick(Sender: TObject);
begin
  if calibre_el.Focused then
    DespliegaRejilla( btnCalibre, [empresa_ec.text, producto_ec.Text] );
end;

procedure TFMEntregasProveedor.RVisualizacion1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  sAux: string;
begin
  if DataCol = 0 then
  begin
    sAux:= DSDetalle1.DataSet.FieldByName('almacen_el').AsString + ' -  ' +
           desProveedorAlmacen( empresa_ec.Text, proveedor_ec.Text,
                        DSDetalle1.DataSet.FieldByName('almacen_el').AsString );
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
  if DataCol = 4 then
  begin
    sAux:= DSDetalle1.DataSet.FieldByName('variedad_el').AsString + ' -  ' +
           DesVariedad( empresa_ec.Text, proveedor_ec.Text,
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
  if DataCol = 10 then
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

function TFMEntregasProveedor.MantenimientoGastos: boolean;
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

procedure TFMEntregasProveedor.btnFacturasClick(Sender: TObject);
begin
  if not DMConfig.EsLaFont then
  begin
    ShowMessage('Las facturas de las compras deben de grabarse en la central.');
    Exit;
  end;

  (*
  if not DMConfig.EsLaFont then
  begin
    ShowMessage('Las facturas de las compras deben de grabarse en la central.');
    Exit;
  end;
  *)


  if not MantenimientoGastos then
    ShowMessage('Debe tener una entrega seleccionada y en modo de visualización.')
  else
    codigo_ec.Change;
  dsTotalCompra.DataSet.Close;
  dsTotalCompra.DataSet.Open;
  dsGastosEntregas.DataSet.Close;
  dsGastosEntregas.DataSet.Open;
end;

procedure TFMEntregasProveedor.cbxUnidad_precio_elChange(Sender: TObject);
begin
  if ( DSDetalle1.DataSet.State = dsInsert ) or ( DSDetalle1.DataSet.State = dsEdit ) then
  begin
    DSDetalle1.DataSet.FieldByName('unidad_precio_el').AsInteger:= cbxUnidad_precio_el.ItemIndex;
  end;
end;

procedure TFMEntregasProveedor.unidad_precio_elChange(Sender: TObject);
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

procedure TFMEntregasProveedor.palets_elChange(Sender: TObject);
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

procedure TFMEntregasProveedor.cajas_elChange(Sender: TObject);
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

  PutKilosCaja;
end;

procedure TFMEntregasProveedor.PutKilosCaja;
var
  rCajas, rKilos: Real;
begin
  rCajas:= StrToFloatDef( cajas_el.Text, 0 );
  if rCajas = 0 then
  begin
    lblPesoCaja.Caption:= 'Falta cajas.';
  end
  else
  begin
    rKilos:= StrToFloatDef( kilos_el.Text, 0 );
    if rKilos = 0 then
    begin
      lblPesoCaja.Caption:= 'Falta kilos.';
    end
    else
    begin
      lblPesoCaja.Caption:= FormatFloat('#.00', rKilos / rCajas ) + ' kgs/caja.';
    end;
  end;
end;

procedure TFMEntregasProveedor.PesoBruto;
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

procedure TFMEntregasProveedor.btnFinalizarClick(Sender: TObject);
begin
  //Comparar que no hay dif con la RF
  if ( Estado = teConjuntoResultado ) and not DSMaestro.DataSet.IsEmpty then
  begin
    if DSMaestro.DataSet.fieldByname('status_ec').AsInteger = 1 then
    begin
      //if not UFMComparaEntregaVsRF.ExistenDifEntregaVsRF( self, DSMaestro.DataSet.fieldByname('entrega_ec').AsString ) then
      begin
        DSMaestro.DataSet.Edit;
        DSMaestro.DataSet.FieldByName('status_ec').AsInteger:= 2;
        DSMaestro.DataSet.FieldByName('fecha_llegada_definitiva_ec').AsInteger:= 1;
        DSMaestro.DataSet.Post;
        //btnPesos.Enabled:= false;
      end;
    end
    else
    if DSMaestro.DataSet.fieldByname('status_ec').AsInteger = 2 then
    begin
      //if not UFMComparaEntregaVsRF.ExistenDifEntregaVsRF( self, DSMaestro.DataSet.fieldByname('entrega_ec').AsString ) then
      begin
        DSMaestro.DataSet.Edit;
        DSMaestro.DataSet.FieldByName('status_ec').AsInteger:= 1;
        DSMaestro.DataSet.Post;
        //btnPesos.Enabled:= false;
      end;
    end
    else
    begin
      ShowMessage('Acción no valida sobre la entrega selccionada.');
      //btnPesos.Enabled:= false;
    end;
  end
  else
  begin
    ShowMessage('Por favor, seleccione un entrega.');
    //btnPesos.Enabled:= false;
  end;
end;

procedure TFMEntregasProveedor.btnPesosClick(Sender: TObject);
var
  Bookmark: TBookmark;
begin
  if ( Estado = teConjuntoResultado ) and not DSMaestro.DataSet.IsEmpty then
  begin
    if CFPCamionEntrega.ExecuteDescargarEntrega( self, empresa_ec.Text, codigo_ec.Text, albaran_ec.Text,
          fecha_llegada_ec.Text, vehiculo_ec.Text, transporte_ec.Text, peso_entrada_ec.Text, peso_salida_ec.Text  ) then
    begin
      with DSMaestro do
      begin
        //DataSet.DisableControls;
        Bookmark:= DataSet.GetBookmark;
        DataSet.Close;
        DataSet.Open;
        DataSet.GotoBookmark( Bookmark );
        DataSet.FreeBookmark( Bookmark );
        //DataSet.EnableControls;
      end;
    end;
  end
  else
  begin
    ShowMessage('Seleccione primero una entrega.');
  end;
end;

procedure TFMEntregasProveedor.PutPesoCarga(Sender: TObject);
begin
  peso_carga_ec.Caption:= FormatFloat( '#,##0.00', StrToFloatDef( peso_entrada_ec.Text, 0) -
                                                   StrToFloatDef( peso_salida_ec.Text, 0) );
end;


procedure TFMEntregasProveedor.kilos_elChange(Sender: TObject);
begin
  if ( DSDetalle1.DataSet.State = dsInsert ) or ( DSDetalle1.DataSet.State = dsEdit )  then
  begin
    PesoBruto;
  end;
  aprovechados_el.Change;
  PutKilosCaja;
end;

procedure TFMEntregasProveedor.aprovechados_elChange(Sender: TObject);
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

procedure TFMEntregasProveedor.intrastat_ecChange(Sender: TObject);
begin
  if intrastat_ec.Text = 'A' then
  begin
    cbbIntrastat.ItemIndex:= 0;
  end
  else
  if intrastat_ec.Text = 'C' then
  begin
    cbbIntrastat.ItemIndex:= 1;
  end
  else
  if intrastat_ec.Text = 'I' then
  begin
    cbbIntrastat.ItemIndex:= 2;
  end
  else
  if intrastat_ec.Text = 'N' then
  begin
    cbbIntrastat.ItemIndex:= 3;
  end
  else
  if intrastat_ec.Text = 'S' then
  begin
    cbbIntrastat.ItemIndex:= 4;
  end
  else
  begin
    cbbIntrastat.ItemIndex:= -1;
  end;
end;

procedure TFMEntregasProveedor.cbbIntrastatChange(Sender: TObject);
begin
  if DSMaestro.DataSet.State in [DSInsert, dsEdit ] then
  begin
    if cbbIntrastat.ItemIndex = 0 then
    begin
      Intrastat_ec.Text:= 'A'
    end
    else
    if cbbIntrastat.ItemIndex = 1 then
    begin
      Intrastat_ec.Text:= 'C'
    end
    else
    if cbbIntrastat.ItemIndex = 2 then
    begin
      Intrastat_ec.Text:= 'I'
    end
    else
    if cbbIntrastat.ItemIndex = 3 then
    begin
      Intrastat_ec.Text:= 'N'
    end
    else
    if cbbIntrastat.ItemIndex = 4 then
    begin
      Intrastat_ec.Text:= 'S'
    end
    else
    begin
      Intrastat_ec.Text:= ''
    end;
  end;
end;

procedure TFMEntregasProveedor.zona_produccion_ecChange(Sender: TObject);
begin
  //TN:TENERIFE NORTE, TS:TENERIFE SUR, GC:GRAN CANARIA, LP:LA PALMA
  if zona_produccion_ec.Text = 'TN' then
  begin
    cbbzona_produccion_ec.ItemIndex:= 0;
  end
  else
  if zona_produccion_ec.Text = 'TS' then
  begin
    cbbzona_produccion_ec.ItemIndex:= 1;
  end
  else
  if zona_produccion_ec.Text = 'GC' then
  begin
    cbbzona_produccion_ec.ItemIndex:= 2;
  end
  else
  if zona_produccion_ec.Text = 'LP' then
  begin
    cbbzona_produccion_ec.ItemIndex:= 3;
  end
  else
  begin
    cbbzona_produccion_ec.ItemIndex:= -1;
  end;
end;

procedure TFMEntregasProveedor.cbbzona_produccion_ecChange(
  Sender: TObject);
begin
  if DSMaestro.DataSet.State in [DSInsert, dsEdit ] then
  begin
    //TF:TENERIFE NORTE, TS:TENERIFE SUR, GC:GRAN CANARIA, LP:LA PALMA
    if cbbzona_produccion_ec.ItemIndex = 0 then
    begin
      zona_produccion_ec.Text:= 'TN'
    end
    else
    if cbbzona_produccion_ec.ItemIndex = 1 then
    begin
      zona_produccion_ec.Text:= 'TS'
    end
    else
    if cbbzona_produccion_ec.ItemIndex = 2 then
    begin
      zona_produccion_ec.Text:= 'GC'
    end
    else
    if cbbzona_produccion_ec.ItemIndex = 3 then
    begin
      zona_produccion_ec.Text:= 'LP'
    end
    else
    begin
      zona_produccion_ec.Text:= ''
    end;
  end;
end;

procedure TFMEntregasProveedor.status_ecChange(Sender: TObject);
begin
  cbbstatus_ec.ItemIndex := StrToIntDef( status_ec.Text, -1 );
end;

procedure TFMEntregasProveedor.cbbstatus_ecChange(Sender: TObject);
begin
  if DSMaestro.DataSet.State in [DSInsert, dsEdit ] then
  begin
    if cbbstatus_ec.ItemIndex >= 0 then
      status_ec.Text:= IntToStr( cbbstatus_ec.ItemIndex )
    else
      status_ec.Text:= '';
  end;
end;

procedure TFMEntregasProveedor.btnEnvioClick(Sender: TObject);
begin
  if ( Estado = teConjuntoResultado ) and not DSMaestro.DataSet.IsEmpty then
  begin
    if DSMaestro.DataSet.FieldByName('status_ec').AsInteger = 1 then
    begin
      DSMaestro.DataSet.Edit;
      DSMaestro.DataSet.FieldByName('status_ec').AsInteger:= 0;
      DSMaestro.DataSet.Post;
      ShowMessage('Cambiado status a pendiente de envio, si es necesario avise al almacén destino para comunicar cambios');
    end
    else
    if DSMaestro.DataSet.FieldByName('status_ec').AsInteger = 0 then
    begin
      DSMaestro.DataSet.Edit;
      DSMaestro.DataSet.FieldByName('status_ec').AsInteger:= 1;
      DSMaestro.DataSet.Post;
      ShowMessage('Cambiado status a entrega enviada, ya no aparece como pendiente en ningun centro');
    end
    else
    begin
      ShowMessage('ERROR: Acción no valida sobre la entrega seleccionada.');
    end;
  end
  else
  begin
    ShowMessage('Debe tener una entrega seleccionada y en modo de visualización.');
  end;
end;

procedure TFMEntregasProveedor.btnEntegaDirectaClick(Sender: TObject);
begin
  if ( Estado = teConjuntoResultado ) and not DSMaestro.DataSet.IsEmpty then
  begin
    if DSMaestro.DataSet.FieldByName('status_ec').AsInteger = 3 then
    begin
      DSMaestro.DataSet.Edit;
      DSMaestro.DataSet.FieldByName('status_ec').AsInteger:= 0;
      DSMaestro.DataSet.Post;
      ShowMessage('Cambiado status a pendiente de envio, si es necesario avise al almacén destino para comunicar cambios');
    end
    else
    if DSMaestro.DataSet.FieldByName('status_ec').AsInteger = 0 then
    begin
      DSMaestro.DataSet.Edit;
      DSMaestro.DataSet.FieldByName('status_ec').AsInteger:= 3;
      DSMaestro.DataSet.Post;
      ShowMessage('Cambiado status a entrega directa, ya no aparece como pendiente en ningun centro');
    end
    else
    begin
      ShowMessage('ERROR: Acción no valida sobre la entrega seleccionada.');
    end;
  end
  else
  begin
    ShowMessage('Debe tener una entrega seleccionada y en modo de visualización.');
  end;
end;

procedure TFMEntregasProveedor.fecha_origen_ecChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if TryStrTodate( fecha_origen_ec.Text, dFecha ) then
    lblSemana.Caption:= 'Sem: ' + AnyoSemana( dFecha )
  else
    lblSemana.Caption:= '';
end;

procedure TFMEntregasProveedor.producto_ecChange(Sender: TObject);
begin
  stProducto.Caption:= desProductoAlta( producto_ec.Text);
end;

procedure TFMEntregasProveedor.DSDetalleTotalesDataChange(Sender: TObject;
  Field: TField);
begin
  DiferenciasLineaCompra;
end;

procedure TFMEntregasProveedor.DiferenciasLineaCompra;
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

procedure TFMEntregasProveedor.dsTotalCompraDataChange(Sender: TObject;
  Field: TField);
begin
  DiferenciasLineaCompra;
end;

procedure TFMEntregasProveedor.btnCambiarPlantaClick(Sender: TObject);
var
  sNewCode: string;
begin
  if ( Estado = teConjuntoResultado ) and not DSMaestro.DataSet.IsEmpty then
  begin
    if DSMaestro.DataSet.FieldByName('status_ec').AsInteger <> 0  then
    begin
      //Ha sido enviada, cambie primero el estado
      //ShowMessage('Esta entrega ya ha sido enviada al almacén, cambie su estado ');
      ShowMessage('Cambie el estado de esta entrega a INICIAL para poder cambiar la planta y si es necesario avise al almacén para que la borre.');
    end
    else
    if ( DSMaestro.DataSet.FieldByName('status_ec').AsInteger = 0 ) or ( DSMaestro.DataSet.FieldByName('status_ec').AsInteger = 3 ) then
    begin
      //Avisar que el codigo de la entrega cambiara
      if CambiarCodigoEntregaFD.CambiarCodigoEntrega( Self, codigo_ec.Text, sNewCode ) then
         BuscarEntrega( sNewCode );
    end;
  end
  else
  begin
    ShowMessage('Debe tener una entrega seleccionada y en modo de visualización.');
  end;
end;

procedure TFMEntregasProveedor.BuscarEntrega( const ACodigo: string );
begin
  Select := 'select * from frf_entregas_c';
  where := ' Where codigo_ec = ' + QuotedStr( ACodigo );
  Order := ' Order by fecha_llegada_ec desc, fecha_origen_ec desc, codigo_ec DESC';

  DSMaestro.DataSet.Close;
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
  Registro := 1;
  Registros := 1;
  RegistrosInsertados := 0;

  Visualizar;
end;

(*
procedure TFMEntregasProveedor.RVisualizacion1DblClick(Sender: TObject);
var
  FocoDetalleAux: TWinControl;
begin
  FocoDetalleAux:= FocoDetalle;
  FocoDetalle:= precio_el;
  DetalleModificar;
  FocoDetalle:= FocoDetalleAux;
*)
procedure TFMEntregasProveedor.RVisualizacion1DblClick(Sender: TObject);
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
         DesVariedad( empresa_ec.Text, proveedor_ec.Text, producto_ec.Text, variedad_el.Text ),
         categoria_el.Text + ' [' + desCategoria( empresa_ec.Text, producto_ec.Text, categoria_el.Text ) + ']',
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

