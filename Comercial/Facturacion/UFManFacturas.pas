unit UFManFacturas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs, cxPC, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, DB, cxDBData,
  cxTextEdit, cxCalendar, cxCurrencyEdit, ActnList, cxClasses,
  dxDockControl, cxGridCustomPopupMenu, cxGridPopupMenu, dxBar, cxDBEdit,
  cxCheckBox, cxMemo, dxStatusBar, cxMaskEdit, cxDropDownEdit, ExtCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxLabel, cxGroupBox, dxDockPanel, BonnyClientDataSet, BonnyQuery,
  BusquedaExperta, DBTables,

  dxSkinsCore, dxSkinBlue, dxSkinFoggy,  dxSkinscxPCPainter, dxSkinsdxStatusBarPainter,
  dxSkinsdxBarPainter, dxSkinsdxDockControlPainter, dxSkinMoneyTwins,
  dxRibbon, dxSkinBlack, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxCalc;

type
  TFManFacturas = class(TForm)
    bmxBarManager: TdxBarManager;
    bmPrincipal: TdxBar;
    dxImprimir: TdxBarLargeButton;
    dxSalir: TdxBarLargeButton;
    dxLocalizar: TdxBarLargeButton;
    dxPrimero: TdxBarLargeButton;
    dxAnterior: TdxBarLargeButton;
    dxSiguiente: TdxBarLargeButton;
    dxUltimo: TdxBarLargeButton;
    gpmRelFacturas: TcxGridPopupMenu;
    dsMain: TdxDockSite;
    dpRelacionFacturas: TdxDockPanel;
    dpManFacturas: TdxDockPanel;
    ds2: TdxLayoutDockSite;
    ds3: TdxLayoutDockSite;
    cxFacturas: TcxGrid;
    tvRelFacturas: TcxGridDBTableView;
    tvCabCodEmpresa: TcxGridDBColumn;
    tvCabNumFactura: TcxGridDBColumn;
    tvCabFecFactura: TcxGridDBColumn;
    tvCabCodCliente: TcxGridDBColumn;
    tvCabDesCliente: TcxGridDBColumn;
    tvCabDesTipoImpuesto: TcxGridDBColumn;
    tvCabMoneda: TcxGridDBColumn;
    tvCabImporteNeto: TcxGridDBColumn;
    tvCabImporteImpuesto: TcxGridDBColumn;
    tvCabImporteTotal: TcxGridDBColumn;
    lvRelFacturas: TcxGridLevel;
    cxPageControl: TcxPageControl;
    tsDetalleLineas: TcxTabSheet;
    pnlDetLineas: TPanel;
    cxLabel11: TcxLabel;
    edtLinCodEmpresaAlb: TcxDBTextEdit;
    cxLabel12: TcxLabel;
    edtLinCentroAlb: TcxDBTextEdit;
    cxLabel13: TcxLabel;
    edtLinNumeroAlb: TcxDBTextEdit;
    cxLabel14: TcxLabel;
    cxLabel15: TcxLabel;
    edtLinCodClienteAlb: TcxDBTextEdit;
    cxLabel16: TcxLabel;
    edtLinCodSuministroAlb: TcxDBTextEdit;
    cxLabel17: TcxLabel;
    edtLinPedidoAlb: TcxDBTextEdit;
    tsDetalleGastos: TcxTabSheet;
    cxGastos: TcxGrid;
    tvDetalleGastos: TcxGridDBTableView;
    tvGasTipoGasto: TcxGridDBColumn;
    tvGasDesGasto: TcxGridDBColumn;
    tvGasImporteNeto: TcxGridDBColumn;
    tvGasPorImpuesto: TcxGridDBColumn;
    tvGasImporteIva: TcxGridDBColumn;
    tvGasImporteTotal: TcxGridDBColumn;
    lvDetalleGastos: TcxGridLevel;
    pnlDetGastos: TPanel;
    cxLabel7: TcxLabel;
    edtGasCodEmpresaAlb: TcxDBTextEdit;
    cxLabel8: TcxLabel;
    edtGasCentroAlb: TcxDBTextEdit;
    cxLabel9: TcxLabel;
    edtGasNumeroAlb: TcxDBTextEdit;
    cxLabel10: TcxLabel;
    edtGasFechaAlb: TcxDBDateEdit;
    edtLinFechaAlb: TcxDBDateEdit;
    dxDockingManager1: TdxDockingManager;
    dxAlta: TdxBarLargeButton;
    dxBaja: TdxBarLargeButton;
    st1: TdxStatusBar;
    tsNotasFactura: TcxTabSheet;
    mmxNotas: TcxDBMemo;
    tvDetalleLineas: TcxGridDBTableView;
    lvDetalleLineas: TcxGridLevel;
    cxLineas: TcxGrid;
    tvProducto: TcxGridDBColumn;
    tvDesProducto: TcxGridDBColumn;
    tvDesEnvase: TcxGridDBColumn;
    tvUnidades: TcxGridDBColumn;
    tvCajas: TcxGridDBColumn;
    tvKilos: TcxGridDBColumn;
    tvUnidadesFac: TcxGridDBColumn;
    tvPrecio: TcxGridDBColumn;
    tvImporte: TcxGridDBColumn;
    tvDescuentos: TcxGridDBColumn;
    tvImporteNeto: TcxGridDBColumn;
    tvPorImpuesto: TcxGridDBColumn;
    tvImpImpuesto: TcxGridDBColumn;
    tvImporteTotal: TcxGridDBColumn;
    dxMod: TdxBarLargeButton;
    dsQCabFactura: TDataSource;
    dsQDetFactura: TDataSource;
    dsQGasFactura: TDataSource;
    dsQBasFactura: TDataSource;
    gbCabecera: TcxGroupBox;
    cxLabel5: TcxLabel;
    edtMoneda: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    edtCodClienteFac: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    edtTipoImpuesto: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    cxlb10: TcxLabel;
    edtPrevisionCobro: TcxDBTextEdit;
    cbFactContabilizada: TcxDBCheckBox;
    cxAnula: TcxLabel;
    cxEmpresa: TcxLabel;
    edtCodEmpresaFac: TcxDBTextEdit;
    txDesEmpresaFac: TcxTextEdit;
    cxLabel1: TcxLabel;
    edtFactura: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    edtFechaFactura: TcxDBTextEdit;
    txDesClienteFac: TcxTextEdit;
    txDesTipoImpuesto: TcxTextEdit;
    txDesMoneda: TcxTextEdit;
    pnl1: TPanel;
    cxLabel18: TcxLabel;
    edCodFactura: TcxDBTextEdit;
    tsCabeceraFactura: TcxTabSheet;
    gbImportes: TcxGroupBox;
    cxLabel19: TcxLabel;
    cxLabel20: TcxLabel;
    cxLabel22: TcxLabel;
    cxSuper: TcxLabel;
    ceNeto1: TcxCurrencyEdit;
    ceImpuesto1: TcxCurrencyEdit;
    ceTotal1: TcxCurrencyEdit;
    cxReducido: TcxLabel;
    ceNeto2: TcxCurrencyEdit;
    ceImpuesto2: TcxCurrencyEdit;
    ceTotal2: TcxCurrencyEdit;
    cxGeneral: TcxLabel;
    ceNeto3: TcxCurrencyEdit;
    ceImpuesto3: TcxCurrencyEdit;
    ceTotal3: TcxCurrencyEdit;
    cxExento: TcxLabel;
    ceNeto4: TcxCurrencyEdit;
    ceImpuesto4: TcxCurrencyEdit;
    ceTotal4: TcxCurrencyEdit;
    shp1: TShape;
    cxLabel26: TcxLabel;
    ceNetoT: TcxCurrencyEdit;
    ceImpuestoT: TcxCurrencyEdit;
    ceTotalT: TcxCurrencyEdit;
    cxLabel21: TcxLabel;
    ceNetoEuros: TcxCurrencyEdit;
    ceImpuestoEuros: TcxCurrencyEdit;
    ceTotalEuros: TcxCurrencyEdit;
    ceDescuento: TcxCurrencyEdit;
    gbRemesas: TcxGroupBox;
    tvRemesas: TcxGridDBTableView;
    lvRemesas: TcxGridLevel;
    cxGrid: TcxGrid;
    dsQRemesas: TDataSource;
    tvNumRemesa: TcxGridDBColumn;
    tvFechaRemesa: TcxGridDBColumn;
    tvImporteCob: TcxGridDBColumn;
    tvBancoRemesa: TcxGridDBColumn;
    cxLabel25: TcxLabel;
    cxLabel27: TcxLabel;
    ceCobradoRem: TcxCurrencyEdit;
    cxLabel28: TcxLabel;
    cxLabel29: TcxLabel;
    cePdteRem: TcxCurrencyEdit;
    txLinDesEmpresaAlb: TcxTextEdit;
    txLinDesClienteAlb: TcxTextEdit;
    txLinDesCentroAlb: TcxTextEdit;
    txLinDesSuministroAlb: TcxTextEdit;
    txGasDesEmpresaAlb: TcxTextEdit;
    txGasDesCentroAlb: TcxTextEdit;
    tvDesEmpFactura: TcxGridDBColumn;
    tvCabDesTipoFac: TcxGridDBColumn;
    tvCabDesAutomatica: TcxGridDBColumn;
    cxLabel23: TcxLabel;
    cxImporteNeto: TcxDBCurrencyEdit;
    cxImporteImpuesto: TcxDBCurrencyEdit;
    cxImporteTotal: TcxDBCurrencyEdit;
    cxLabel30: TcxLabel;
    cxLabel31: TcxLabel;
    cxLabel32: TcxLabel;
    cxLabel33: TcxLabel;
    cxRecargo: TcxLabel;
    ActionList: TActionList;
    actCancelar: TAction;
    actLocalizar: TAction;
    actAlta: TAction;
    BEFacturas: TBusquedaExperta;
    tvCabTipoFac: TcxGridDBColumn;
    tvCabAutomatica: TcxGridDBColumn;
    cxlbl1: TcxLabel;
    cxdbtxtdtprevision_cobro_fc: TcxDBTextEdit;
    dxbrbtnImprimeAlbaran: TdxBarButton;
    dxbrsbtm1: TdxBarSubItem;
    mnuPrevisualizarAlbaranes: TdxBarButton;
    mnuImprimirAlbaranes: TdxBarButton;
    btnFacturaDeposito: TdxBarButton;
    cxLabel24: TcxLabel;
    edtLinFecPedido: TcxDBDateEdit;
    cxLabel34: TcxLabel;
    edtCodSerieFac: TcxDBTextEdit;
    tvCabSerEmpresa: TcxGridDBColumn;
    cbNumRegistroAcuerdo: TcxDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxImprimirClick(Sender: TObject);
    procedure dxSalirClick(Sender: TObject);

    procedure Previsualizar( const ABruto: boolean );
    //procedure Previsualizar_( const ABruto: boolean );
    procedure RellenaMemFacturas;
    function AsuntoFactura: string;
    function NumeroCopias: Integer;
    procedure FormShow(Sender: TObject);
    procedure dxLocalizarClick(Sender: TObject);
    procedure dxPrimeroClick(Sender: TObject);
    procedure dxAnteriorClick(Sender: TObject);
    procedure dxSiguienteClick(Sender: TObject);
    procedure dxUltimoClick(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    function MostrarConsulta(StringSQL: string): boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxAltaClick(Sender: TObject);
    procedure dxBajaClick(Sender: TObject);
    procedure tvRelFacturasDblClick(Sender: TObject);
    procedure dxModClick(Sender: TObject);
    procedure dsMainShowControl(Sender: TdxDockSite;
      AControl: TdxCustomDockControl);
    procedure dsMainHideControl(Sender: TdxDockSite;
      AControl: TdxCustomDockControl);
    procedure dsQCabFacturaDataChange(Sender: TObject; Field: TField);
    procedure dsQGasFacturaDataChange(Sender: TObject; Field: TField);
    procedure dsQDetFacturaDataChange(Sender: TObject; Field: TField);
    procedure actCancelarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure actLocalizarExecute(Sender: TObject);
    procedure actAltaExecute(Sender: TObject);
    procedure mnuPrevisualizarAlbaranesClick(Sender: TObject);
    procedure mnuImprimirAlbaranesClick(Sender: TObject);
    procedure mnuFacturasDeposito(Sender: TObject);

  private
    QCabFactura, QDetFactura, QGasFactura, QBasFactura, QRemesas: TBonnyClientDataSet;
    QImpuestos, QAnula, QRemesada: TBonnyQuery;
    iIniFactura, iUltFactura: integer;
    dUltFecha: TDateTime;

    procedure ActivarBtnConsulta(AActivar: boolean);
    procedure CerrarTablas;
    procedure ActivarFiltro;
    procedure DesactivarFiltro;
    procedure BorrarSalida;
    procedure BorrarGasFactura;
    procedure BorrarDetFactura;
    procedure BorrarBasFactura;
    procedure BorrarCabFactura;
    procedure MostrarMantenimientoAlta(AClave: string; Aalta: boolean);
    procedure BtnNavegador;
    procedure CreaQueryCab;
    procedure CreaQueryDet;
    procedure CreaQueryGas;
    procedure CreaQueryBas;
    procedure CreaQueryRemesas;
    procedure CreaQImpuestos;
    procedure CreaQAnula;
    procedure CreaQRemesada;
    function EjecutaQueryCab: boolean;
    function EjecutaQueryDet: boolean;
    function EjecutaQueryGas: boolean;
    function EjecutaQueryBas: boolean;
    function EjecutaQueryRemesas: boolean;
    procedure MostrarNotasFactura;
    function ObtenerAnulacion: String;
    procedure MostrarFacturas(SQL: String);
    procedure MostrarCabecera;
    procedure InicializarTotales;
    procedure IniTotales;
    procedure ActualizarContador;
    function EsRemesada: boolean;
    procedure UltimaFacturaGen(const AEmpresa: String; const AFechaFac: TDateTime; const ANumeroFac: integer;
                               const iIniFactura: integer; var iUltFactura: Integer; var iUltFecha: TDateTime);
    procedure RellenarDatosIni;
    procedure CamposCalculados;

  public
    procedure MostrarFacturasExt(AFacturas: String);

  end;
const
  kFactura = '380';
  kAbono   = '381';

var
  FManFacturas: TFManFacturas;

implementation

uses Principal, CVariables, CGestionPrincipal, URFactura, //URFactura_,
     DConfigMail, DPreview, UDMConfig, CFactura,
     UDMAuxDB, CAuxiliarDB, UFConsultaExperta, UDFactura, UDMBaseDatos, UFAltaFacturas, DError,
     bDialogs, UFNotasFactura, DateUtils, AlbaranesAsociadosFacDM, bMath;

{$R *.dfm}

procedure TFManFacturas.FormCreate(Sender: TObject);
begin
     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfOther then
  begin
    FormType := tfOther;
    BHFormulario;
  end;

     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  edtCodEmpresaFac.Tag := kEmpresa;
  edtCodClienteFac.Tag := kCliente;
  edtTipoImpuesto.Tag := kImpuesto;
  edtMoneda.Tag := kMoneda;
  edtLinCodEmpresaAlb.Tag := kEmpresa;
  edtLinCentroAlb.Tag := kCentro;
  edtLinCodClienteAlb.Tag := kCliente;
  edtLinCodSuministroAlb.Tag := kSuministro;
  edtGasCodEmpresaAlb.Tag := kEmpresa;
  edtGasCentroAlb.Tag := kCentro;

      //Creamos consulta
  CreaQueryCab;
  CreaQueryDet;
  CreaQueryGas;
  CreaQueryBas;
  CreaQueryRemesas;
  CreaQImpuestos;
  CreaQAnula;
  CreaQRemesada;
end;

procedure TFManFacturas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //Codigo de desactivacion
  CerrarTablas;

  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

     //Limpiar;

  BEMensajes('');
  Action := caFree;
end;

procedure TFManFacturas.dxImprimirClick(Sender: TObject);
begin
  Previsualizar( False );
  WindowState := wsMaximized;
  CamposCalculados;
end;

procedure TFManFacturas.dxSalirClick(Sender: TObject);
begin
  if QCabFactura.Active then
  begin
    RellenarDatosIni;
    ActivarBtnConsulta(True);
    BtnNavegador;
    tvRelFacturas.DataController.Filter.Root.Clear;
  end
  else
    Close;
end;

procedure TFManFacturas.Previsualizar( const ABruto: boolean );
var marcador: TBookmark;
begin
        // Cargamos tablas temporales con datos factura
  marcador := dsQCabFactura.DataSet.GetBookmark;
  ActivarFiltro;
  RellenaMemFacturas;

  try
    DConfigMail.sAsunto:= AsuntoFactura;
    DConfigMail.sEmpresaConfig:= edtCodEmpresaFac.Text;
    DConfigMail.sClienteConfig:= edtCodClienteFac.Text;
    DConfigMail.sSuministroConfig:= edtLinCodSuministroAlb.Text;

       //Crear informe
    RFactura := TRFactura.Create(Application);

    RFactura.Configurar(edtCodEmpresaFac.Text, edtCodClienteFac.Text);
    RFactura.printOriginal := true;
    RFactura.printEmpresa := False;
    RFactura.definitivo := True;
    RFactura.bBruto := ABruto;

    DPreview.bCanSend := (DMConfig.EsLaFont);
    RFactura.bCopia := True; //cbxSoloVer.Checked or chkCostePlataforma.Checked;
    if RFactura.printOriginal then
      RFactura.Tag:= 1
    else
    if RFactura.printEmpresa then
      RFactura.Tag:= 2
    else
      RFactura.Tag:= 3;
    Preview(RFactura, NumeroCopias, False, True);
    RFactura := nil;
  finally
    if RFactura <> nil then
      FreeAndNil(RFactura);
  end;

  DesactivarFiltro;
  dsQCabFactura.DataSet.GotoBookmark(marcador);
  dsQCabFactura.DataSet.FreeBookmark(marcador);
  LimpiarTemporales;
end;

(*
procedure TFManFacturas.Previsualizar_( const ABruto: boolean );
var marcador: TBookmark;
begin
        // Cargamos tablas temporales con datos factura
  marcador := dsQCabFactura.DataSet.GetBookmark;
  ActivarFiltro;
  RellenaMemFacturas;

  try
    DConfigMail.sAsunto:= AsuntoFactura;
    DConfigMail.sEmpresaConfig:= edtCodEmpresaFac.Text;
    DConfigMail.sClienteConfig:= edtCodClienteFac.Text;
    DConfigMail.sSuministroConfig:= edtLinCodSuministroAlb.Text;

       //Crear informe
    RFactura_ := TRFactura_.Create(Application);

    RFactura_.Configurar(edtCodEmpresaFac.Text, edtCodClienteFac.Text);
    RFactura_.printOriginal := true;
    RFactura_.printEmpresa := False;
    RFactura_.definitivo := True;
    RFactura_.bBruto := ABruto;

    DPreview.bCanSend := (DMConfig.EsLaFont);
    RFactura_.bCopia := True; //cbxSoloVer.Checked or chkCostePlataforma.Checked;
    if RFactura_.printOriginal then
      RFactura_.Tag:= 1
    else
    if RFactura_.printEmpresa then
      RFactura_.Tag:= 2
    else
      RFactura_.Tag:= 3;
    Preview(RFactura_, NumeroCopias, False, True);
    RFactura_ := nil;
  finally
    if RFactura_ <> nil then
      FreeAndNil(RFactura_);
  end;

  DesactivarFiltro;
  dsQCabFactura.DataSet.GotoBookmark(marcador);
  dsQCabFactura.DataSet.FreeBookmark(marcador);
  LimpiarTemporales;
end;
*)

procedure TFManFacturas.RellenaMemFacturas;
begin

  DFactura.mtFacturas_Bas.LoadFromDataSet(QBasFactura, []);
  DFactura.mtFacturas_Gas.LoadFromDataSet(QGasFactura, []);
  DFactura.mtFacturas_Gas.SortOn('cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg', []);
  DFactura.mtFacturas_Det.LoadFromDataSet(QDetFactura, []);
  DFactura.mtFacturas_Det.SortOn('cod_factura_fd;fecha_albaran_fd;pedido_fd;n_albaran_fd;cod_dir_sum_fd;cod_producto_fd;cod_envase_fd', []);
  DFactura.mtFacturas_Cab.LoadFromDataSet(QCabFactura, []);
  DFactura.mtFacturas_Cab.SortOn('cod_factura_fc', []);

end;

function TFManFacturas.AsuntoFactura: string;
var sIniFactura, sFinFactura, sIniCliente, sFinCliente: string;
begin
    DFactura.mtFacturas_Cab.First;
    sIniFactura := DFactura.mtFacturas_Cab.fieldbyname('n_factura_fc').AsString;
    DFactura.mtFacturas_Cab.Last;
    sFinFactura := DFactura.mtFacturas_Cab.fieldbyname('n_factura_fc').AsString;

    sIniCliente := DFactura.mtFacturas_Cab.fieldbyname('cod_cliente_fc').AsString;
    sFinCliente := DFactura.mtFacturas_Cab.fieldbyname('cod_cliente_fc').AsString;

    if sIniFactura <> sFinFactura then
    begin
      result:= 'Envío facturas ' + sIniFactura + '-' + sFinFactura;
      if sIniCliente <> sFinCliente then
      begin
        result:= result + ' [' + sIniCliente + '-' + sFinCliente + ']';
      end
      else
      begin
        result:= result + ' [' + desCliente( sIniCliente ) + ']';
      end;
    end
    else
    begin
      result:= 'Envío factura ' + sIniFactura + ' [' + desCliente( sIniCliente ) + ']';
    end;
end;

function TFManFacturas.NumeroCopias: Integer;
var aux: Integer;
begin
  with DFactura.QAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add(' SELECT MAX(n_copias_fac_c) ');
    SQL.Add('   FROM frf_clientes ');
    SQL.Add('  WHERE cliente_c = :cliente ');

    ParamByName('cliente').AsString := edtCodClienteFac.Text;

    try
      AbrirConsulta(DFactura.QAux);
    except
             //
    end;
    aux := Fields[0].AsInteger;
    if (aux > 1) and not RFactura.PrintOriginal then Dec(aux);
    if (aux > 1) and not RFactura.printEmpresa then Dec(aux);
    NumeroCopias := aux;
  end;
end;


procedure TFManFacturas.FormShow(Sender: TObject);
begin
  cxPageControl.ActivePage := tsCabeceraFactura;
  ActivarBtnConsulta(true);
  cxAnula.Visible := false;
  BtnNavegador;
end;

procedure TFManFacturas.dxLocalizarClick(Sender: TObject);
var StringSQL: string;
    i: integer;
    Ano, Mes, Dia: Word;
begin
  //DecodeDate(Now, Ano, Mes, Dia);
  //BEFActuras.setValor('cod_empresa_fac_fc', '=' + gsDefEmpresa);
  //BEFActuras.setValor('fecha_factura_fc', '>=' + DateToStr(EncodeDate(Ano, 1, 1)));
  BEFActuras.setValor('fecha_factura_fc', '>=' + DateToStr(IncYear( Now, -1 )));


  if BEFacturas.execute = mrOk then
  begin
    i := 1;
    while i < BEFacturas.SQL.Count do
    begin
      StringSQL := StringSQL + BEFacturas.SQL[i] + ' ';
      inc(i);
    end;
    MostrarFacturas(StringSQL);
  end
end;

procedure TFManFacturas.CerrarTablas;
begin
  CloseQuerys([QCabFactura, QDetFactura, QGasFactura, QBasFactura, QImpuestos, QAnula, QRemesas, QRemesada]);
end;

procedure TFManFacturas.dxPrimeroClick(Sender: TObject);
begin
  QCabFactura.First;
  CamposCalculados;
end;

procedure TFManFacturas.dxAnteriorClick(Sender: TObject);
begin
  QCabFactura.Prior;
end;

procedure TFManFacturas.dxSiguienteClick(Sender: TObject);
begin
  QCabFactura.Next;
end;

procedure TFManFacturas.dxUltimoClick(Sender: TObject);
begin
  QCabFactura.Last;
  CamposCalculados;
end;

procedure TFManFacturas.PonNombre(Sender: TObject);
begin
  case TComponent(Sender).Tag of
    kEmpresa:
    begin
      if TComponent(Sender).Name = edtCodEmpresaFac.Name then
      begin
        txDesEmpresaFac.Text := desPlanta(QCabFactura.FieldByName('cod_empresa_fac_fc').AsString);
        txDesClienteFac.Text := desCliente(QCabFactura.FieldByName('cod_cliente_fc').AsString);
      end
      else
      if TComponent(Sender).Name = edtLinCodEmpresaAlb.Name then
      begin
        txLinDesEmpresaAlb.Text := desPlanta(QDetFactura.Fieldbyname('cod_empresa_albaran_fd').AsString);
        txLinDesClienteAlb.Text := desCliente(QDetFactura.Fieldbyname('cod_cliente_albaran_fd').AsString);
        txLinDesCentroAlb.Text := desCentro(QDetFactura.Fieldbyname('cod_empresa_albaran_fd').AsString,
                                            QDetFactura.FieldByName('cod_centro_albaran_fd').AsString);
        txLinDesSuministroAlb.Text := desSuministro(QDetFactura.Fieldbyname('cod_empresa_albaran_fd').AsString,
                                                    QDetFactura.Fieldbyname('cod_cliente_albaran_fd').AsString,
                                                    QDetFactura.FieldByName('cod_dir_sum_fd').AsString);
      end
      else
      if TComponent(Sender).Name = edtGasCodEmpresaAlb.Name then
      begin
        txGasDesEmpresaAlb.Text := desPlanta(QGasFactura.FieldByName('cod_empresa_albaran_fg').AsString);
        txGasDesCentroAlb.Text := desCentro(QGasFactura.FieldByName('cod_empresa_albaran_fg').AsString,
                                            QGasFactura.FieldByName('cod_centro_albaran_fg').AsString);
      end
    end;
    kCentro:
    begin
      if TComponent(Sender).Name = edtLinCentroAlb.Name then
        txLinDesCentroAlb.Text := desCentro(QDetFactura.FieldByName('cod_empresa_albaran_fd').AsString,
                                            QDetFactura.FieldByName('cod_centro_albaran_fd').AsString)
      else
      if TComponent(Sender).Name = edtGasCentroAlb.Name then
        txGasDesCentroAlb.Text := desCentro(QGasFactura.FieldByName('cod_empresa_albaran_fg').AsString,
                                            QGasFactura.FieldByName('cod_centro_albaran_fg').AsString)
    end;
    kMoneda: txDesMoneda.Text := desMoneda(QCabFactura.FieldByName('moneda_fc').AsString);
    kImpuesto: txDesTipoImpuesto.Text := DesImpuesto(QCabFactura.FieldByName('tipo_impuesto_fc').AsString);
    kCliente:
    begin
      if TComponent(Sender).Name = edtCodClienteFac.Name then
        txDesClienteFac.Text := desCliente(QCabFactura.FieldByName('cod_cliente_fc').AsString)
      else
      if TComponent(Sender).Name = edtLinCodClienteAlb.Name then
      begin
        txLinDesClienteAlb.Text := desCliente(QDetFactura.FieldByName('cod_cliente_albaran_fd').AsString);
        txLinDesCentroAlb.Text := desCentro(QDetFactura.FieldByName('cod_empresa_albaran_fd').AsString,
                                            QDetFactura.FieldByName('cod_centro_albaran_fd').AsString);
      end;
    end;
    kSuministro:
      txLinDesSuministroAlb.Text := desSuministro(QDetFactura.FieldByName('cod_empresa_albaran_fd').AsString,
                                                  QDetFactura.Fieldbyname('cod_cliente_albaran_fd').AsString,
                                                  QDetFactura.Fieldbyname('cod_dir_sum_fd').AsString);
  end;
end;

function TFManFacturas.MostrarConsulta(StringSQL: string): boolean;
begin
{ TODO : Para que no de fallo, cambiar }
//  DFactura.QCabFactura.SQL.Add( StringSQL );
  with QCabFactura do
  begin
    SQL.Clear;

    SQL.Add(' select DISTINCT cod_factura_fc, cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, ');
    SQL.Add('        impuesto_fc, tipo_factura_fc, automatica_fc, anulacion_fc, cod_factura_anula_fc, ');
    SQL.Add('        cod_cliente_fc, des_cliente_fc, cta_cliente_fc, nif_fc, ');
    SQL.Add('        tipo_via_fc, domicilio_fc, poblacion_fc, cod_postal_fc, ');
    SQL.Add('        provincia_fc, cod_pais_fc, des_pais_fc, notas_fc, incoterm_fc, plaza_incoterm_fc, ');
    SQL.Add('        forma_pago_fc, des_forma_pago_fc, ');
    SQL.Add('        tipo_impuesto_fc, des_tipo_impuesto_fc, moneda_fc,');
    SQL.Add('        importe_linea_fc, round(importe_descuento_fc,2) importe_descuento_fc, round(importe_neto_fc,2) importe_neto_fc, importe_impuesto_fc, round(importe_total_fc,2) importe_total_fc, ');
    SQL.Add('        round(importe_neto_euros_fc,2) importe_neto_euros_fc, importe_impuesto_euros_fc, round(importe_total_euros_fc,2) importe_total_euros_fc, prevision_cobro_fc, prevision_tesoreria_fc, contabilizado_fc, ');
    SQL.Add('        es_reg_acuerdo_fc ');
//    SQL.Add('        nombre_pln desEmpresa, ');
//    SQL.Add('        case tipo_factura_fc when "380" then "FACTURA" ');
//    SQL.Add('             else "ABONO" end tipoFactura,');
//    SQL.Add('        case automatica_fc when 1 then "AUTOMATICA" ');
//    SQL.Add('             else "MANUAL" end desAutomatica ');
    SQL.Add(StringSQL);
    SQL.Add(' order by cod_empresa_fac_fc, cod_serie_fac_fc, des_tipo_impuesto_fc desc, fecha_factura_fc, n_factura_fc ');

  end;

 try
   Result := EjecutaQueryCab;
   EjecutaQueryDet;
   EjecutaQueryGas;
  except
      result := false;
  end
end;

procedure TFManFacturas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  // Ctrl P  imprime
  if ((Key = 73) or (Key = 105)) and dxImprimir.Enabled then
    dxImprimirClick(Self);


  if (Key = 36) and (dxPrimero.Enabled) then

    dxPrimeroClick(Self);


  if (Key = 35) and (dxUltimo.Enabled) then

    dxUltimoClick(Self);


  if (Key = 37) and (dxAnterior.Enabled) then

    dxAnteriorClick(Self);


  if (Key = 39) and (dxSiguiente.Enabled) then

    dxSiguienteClick(Self);

end;


procedure TFManFacturas.ActivarFiltro;
begin
  QGasFactura.Filter := 'cod_factura_fg = ' + QuotedStr(QCabFactura.fieldbyname('cod_factura_fc').AsString);
  QGasFactura.Filtered := true;

  QDetFactura.Filter := 'cod_factura_fd = ' + QuotedStr(QCabFactura.fieldbyname('cod_factura_fc').AsString);
  QDetFactura.Filtered := true;

  QBasFactura.Filter := 'cod_factura_fb = ' + QuotedStr(QCabFactura.fieldbyname('cod_factura_fc').AsString);
  QBasFactura.Filtered := true;

  QCabFactura.Filter := 'cod_factura_fc = ' + QuotedStr(QCabFactura.fieldbyname('cod_factura_fc').AsString);
  QCabFactura.Filtered := true;
end;

procedure TFManFacturas.DesactivarFiltro;
begin
  QBasFactura.Filtered := false;
  QGasFactura.Filtered := false;
  QDetFactura.Filtered := false;
  QCabFactura.Filtered := false;
end;

procedure TFManFacturas.dxAltaClick(Sender: TObject);
begin
  MostrarMantenimientoAlta('CLAVE_FACTURA', true);
end;

procedure TFManFacturas.MostrarFacturas(SQL: String);
begin
  // Abrir Consulta
  if not MostrarConsulta(SQL) then
  begin
    Advertir('ATENCION! No existe facturas con el criterio seleccionado.');
    RellenarDatosIni;
    dsMain.ShowingControl := nil;
    exit;
  end;

  CamposCalculados;
  ActivarBtnConsulta(False);
  if QCabFactura.RecordCount = 1 then
    dsMain.ShowingControl := nil
  else
  begin
    dsMain.ShowingControl := dpRelacionFacturas;
    cxFacturas.SetFocus;
  end;
end;

procedure TFManFacturas.InicializarTotales;
begin
{
  for i:=1 to 4 do
  begin
    TcxCurrencyEdit(concat('ceNeto',IntToStr(i))).Value := 0;
    TcxCurrencyEdit(concat('ceImpuesto',IntToStr(i))).Value := 0;
    TcxCurrencyEdit(concat('ceTotal',IntToStr(i))).Value := 0;
  end;
}
  ceNeto1.Value := 0;
  ceNeto2.Value := 0;
  ceNeto3.Value := 0;
  ceNeto4.Value := 0;
  ceImpuesto1.Value := 0;
  ceImpuesto2.Value := 0;
  ceImpuesto3.Value := 0;
  ceImpuesto4.Value := 0;
  ceTotal1.Value := 0;
  ceTotal2.Value := 0;
  ceTotal3.Value := 0;
  ceTotal4.Value := 0;

  ceDescuento.Value := 0;
  ceNetoT.Value := 0;
  ceImpuestoT.Value := 0;
  ceTotalT.Value := 0;
  ceNetoEuros.Value := 0;
  ceImpuestoEuros.Value := 0;
  ceTotalEuros.Value := 0;

  ceCobradoRem.Value := 0;
  cePdteRem.Value := 0;
end;

procedure TFManFacturas.IniTotales;
begin
  ceNeto1.Text := '';
  ceNeto2.Text := '';
  ceNeto3.Text := '';
  ceNeto4.Text := '';
  ceImpuesto1.Text := '';
  ceImpuesto2.Text := '';
  ceImpuesto3.Text := '';
  ceImpuesto4.Text := '';
  ceTotal1.Text := '';
  ceTotal2.Text := '';
  ceTotal3.Text := '';
  ceTotal4.Text := '';

  ceDescuento.Text := '';
  ceNetoT.Text := '';
  ceImpuestoT.Text := '';
  ceTotalT.Text := '';
  ceNetoEuros.Text := '';
  ceImpuestoEuros.Text := '';
  ceTotalEuros.Text := '';

  ceCobradoRem.Text := '';
  cePdteRem.Text := '';
end;

procedure TFManFacturas.MostrarCabecera;
var cSuper, cReducido, cGeneral, cCobrado,
    cRecSuper, cRecReducido, cRecGeneral: Real;
    rNeto, rImpuesto, rTotal: Real;
begin

  InicializarTotales;

    //Totales Factura
  with QImpuestos do
  begin
    if Active then
      Close;

    ParamByName('codigo').AsString := Concat(QCabFactura.FieldByName('impuesto_fc').AsString, 'R');
    ParamByName('fechafactura').AsDateTime := QCabFactura.FieldByName('fecha_factura_fc').AsDateTime;
    Open;

    cSuper := FieldByName('super_il').AsFloat;
    cReducido := FieldByName('reducido_il').AsFloat;
    cGeneral := FieldByName('general_il').AsFloat;
    cRecSuper := FieldByName('recargo_super_il').AsFloat;
    cRecReducido := FieldByName('recargo_reducido_il').AsFloat;
    cRecGeneral := FieldByName('recargo_general_il').AsFloat;
  end;

  if ClienteConRecargo( QCabFactura.FieldByName('cod_empresa_fac_fc').AsString,
                        QCabFactura.FieldByName('cod_cliente_fc').AsString,
                        QCabFactura.FieldByName('fecha_factura_fc').AsDateTime ) then
  begin
    cSuper := cSuper + cRecSuper;
    cReducido := cReducido + cRecReducido;
    cGeneral := cGeneral + cRecGeneral;
    cxRecargo.Visible := True;
  end
  else
    cxRecargo.Visible := False;

  cxSuper.Caption := FloatToStr(cSuper) + ' %';
  cxReducido.Caption := FloatToStr(cReducido) + ' %';
  cxGeneral.Caption := FloatToStr(cGeneral) + ' %';

  rNeto := 0;
  rImpuesto := 0;
  rTotal := 0;
  QBasFactura.First;
  while not QBasFactura.Eof do
  begin
    if (QCabFactura.FieldByName('tipo_impuesto_fc').AsString <> 'IR') and
       (QCabFactura.FieldByName('tipo_impuesto_fc').AsString <> 'GR') then
    begin
       ceNeto4.Value := broundTo(QBasFactura.FieldByName('importe_neto_fb').AsFloat, 2);
       ceImpuesto4.Value := QBasFactura.FieldByName('importe_impuesto_fb').AsFloat;
       ceTotal4.Value := broundTo(QBasFactura.FieldByName('importe_total_fb').AsFloat, 2);
    end
    else
    begin
      if QBasFactura.FieldByName('porcentaje_impuesto_fb').AsFloat = cSuper then
      begin
         ceNeto1.Value := broundTo(QBasFactura.FieldByName('importe_neto_fb').AsFloat, 2);
         ceImpuesto1.Value := QBasFactura.FieldByName('importe_impuesto_fb').AsFloat;
         ceTotal1.Value := broundTo(QBasFactura.FieldByName('importe_total_fb').AsFloat, 2);
      end;
      if QBasFactura.FieldByName('porcentaje_impuesto_fb').AsFloat = cReducido then
      begin
         ceNeto2.Value := broundTo(QBasFactura.FieldByName('importe_neto_fb').AsFloat, 2);
         ceImpuesto2.Value := QBasFactura.FieldByName('importe_impuesto_fb').AsFloat;
         ceTotal2.Value := broundTo(QBasFactura.FieldByName('importe_total_fb').AsFloat, 2);
      end;
      if QBasFactura.FieldByName('porcentaje_impuesto_fb').AsFloat = cGeneral then
      begin
         ceNeto3.Value := broundTo(QBasFactura.FieldByName('importe_neto_fb').AsFloat, 2);
         ceImpuesto3.Value := QBasFactura.FieldByName('importe_impuesto_fb').AsFloat;
         ceTotal3.Value := broundTo(QBasFactura.FieldByName('importe_total_fb').AsFloat, 2);
      end;
    end;

   rNeto := rNeto + QBasFactura.FieldByName('importe_neto_fb').AsFloat;
   rImpuesto := rImpuesto + QBasFactura.FieldByName('importe_impuesto_fb').AsFloat;
   rTotal := rTotal + QBasFactura.FieldByName('importe_total_fb').AsFloat;

    QBasFactura.Next;
  end;

  ceDescuento.Value := QCabFactura.FieldByName('importe_descuento_fc').AsFloat;

  ceNetoT.Value := bRoundTo(rNeto, 2);
  ceImpuestoT.Value := rImpuesto;
  ceTotalT.Value := bRoundTo(rTotal, 2);

  if QCabFactura.FieldByName('moneda_fc').AsString = 'EUR' THEN
  begin
    cxLabel21.Visible := false;
    ceNetoEuros.Visible := false;
    ceImpuestoEuros.Visible := false;
    ceTotalEuros.Visible := false;
  end
  else
  begin
    cxLabel21.Visible := true;
    ceNetoEuros.Visible := true;
    ceImpuestoEuros.Visible := true;
    ceTotalEuros.Visible := true;

    ceNetoEuros.Value := QCabFactura.FieldByName('importe_neto_euros_fc').AsFloat;
    ceImpuestoEuros.Value := QCabFactura.FieldByName('importe_impuesto_euros_fc').AsFloat;
    ceTotalEuros.Value := QCabFactura.FieldByName('importe_total_euros_fc').AsFloat;
  end;


  //Total Remesa
  cCobrado := 0;
  QRemesas.First;
  while not QRemesas.Eof do
  begin
    cCobrado := cCobrado + QRemesas.FieldByName('importe_cobrado_rf').AsFloat;

    QRemesas.Next;
  end;
  ceCobradoRem.Value := cCobrado;
  cePdteRem.Value := QCabFactura.FieldbyName('importe_total_fc').AsFloat - ceCobradoRem.Value;
end;

procedure TFManFacturas.MostrarFacturasExt(AFacturas: string);
var StringSQL : String;
begin
  StringSQL := ' from ' + BEFacturas.Tablas;
  //if BEFacturas.SQLAdi <> '' then
  //  StringSQL := StringSQL + ' where ' + BEFacturas.SQLAdi;
  if pos( 'WHERE', UpperCase(StringSQL) ) = 0 then
    StringSQL := StringSQL + ' where 1 = 1 ';
  StringSQL := StringSQL + ' and cod_factura_fc in ( ' + AFacturas +  ' ) ';

  MostrarFacturas(StringSQL);
end;

procedure TFManFacturas.dxBajaClick(Sender: TObject);
var sMsg: string;
begin
  if cbFactContabilizada.Checked then
  begin
    ShowMessage('Factura Contabilizada, no se puede borrar.');
    Exit;
  end;

  if EsRemesada then
  begin
    ShowMessage('Factura Remesada, no se puede borrar.');
    Exit;
  end;

  if QCabFactura.FieldByName('anulacion_fc').AsInteger = 1 then
  begin
    ShowMessage('Factura Anulada, no se puede borrar.');
    Exit;
  end;

  if QCabFactura.FieldByName('tipo_factura_fc').AsString = kFactura then
    sMsg:= '¿Desea borrar la factura seleccionada?'
  else
    sMsg:= '¿Desea borrar el abono seleccionado?';

  if MessageDlg( sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
    begin
      Exit;
    end;

    try
      BorrarSalida;
      BorrarGasFactura;
      BorrarDetFactura;
      BorrarBasFactura;
      BorrarCabFactura;
      ActualizarContador;   //Si es la ultima factura grabada, se actualiza contador frf_facturas_serie

      QGasFactura.ApplyUpdates(0);
      QDetFactura.ApplyUpdates(0);
      QCabFactura.ApplyUpdates(0);

    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
    end;
    AceptarTransaccion(DMBaseDatos.DBBaseDatos);
  end;
  QCabFactura.Refresh;
  QDetFactura.Refresh;
  QBasFactura.Refresh;
  QGasFactura.Refresh;
  if QCabFactura.RecordCount = 0 then
    dxSalirClick(Self);
end;

procedure TFManFacturas.BorrarSalida;
var QAlbaran: TBonnyQuery;
begin
  QAlbaran := TBonnyquery.Create(Self);
  with QAlbaran do
  try
    SQL.Add(' UPDATE frf_salidas_c set ');
    SQL.Add(' (empresa_fac_sc, serie_fac_sc, n_factura_sc,fecha_factura_sc)=(NULL,NULL,NULL,NULL) ');
    SQL.Add(' WHERE empresa_fac_sc = :MIEMP ');
    SQL.Add('   AND n_factura_sc = :MIFAC ');
    SQL.Add('   AND fecha_factura_sc = :MIFEC ');
    SQL.Add('   AND serie_fac_sc = :MISER ');

    ParamByName('MIEMP').AsString := edtCodEmpresaFac.Text;
    ParamByName('MIFAC').AsString := edtFactura.Text;
    ParamByName('MIFEC').AsString := edtFechaFactura.Text;
    ParamByName('MISER').AsString := edtCodSerieFac.Text;

    ExecSQL;

  finally
    free;
  end;
end;

procedure TFManFacturas.BorrarGasFactura;
var QDelGastos: TBonnyQuery;
begin
  QDelGastos := TBonnyquery.Create(Self);
  with QDelGastos do
  try
    SQL.Add(' delete from tfacturas_gas ');
    SQL.Add('  where cod_factura_fg = :MICOD ');
    ParamByName('MICOD').AsString := QCabFactura.fieldbyname('cod_factura_fc').AsString;

    ExecSQL;

  finally
    free;
  end;
end;

procedure TFManFacturas.BorrarDetFactura;
var QDelDetalle: TBonnyQuery;
begin
  QDelDetalle := TBonnyquery.Create(Self);
  with QDelDetalle do
  try
    SQL.Add(' delete from tfacturas_det ');
    SQL.Add('  where cod_factura_fd = :MICOD ');
    ParamByName('MICOD').AsString := QCabFactura.fieldbyname('cod_factura_fc').AsString;

    ExecSQL;

  finally
    free;
  end;
end;

procedure TFManFacturas.BorrarBasFactura;
var QBasGastos: TBonnyQuery;
begin
  QBasGastos := TBonnyquery.Create(Self);
  with QBasGastos do
  try
    SQL.Add(' delete from tfacturas_bas ');
    SQL.Add('  where cod_factura_fb = :MICOD ');
    ParamByName('MICOD').AsString := QCabFactura.fieldbyname('cod_factura_fc').AsString;

    ExecSQL;

  finally
    free;
  end;
end;

procedure TFManFacturas.BorrarCabFactura;
var QDelCabecera: TBonnyQuery;
begin
  QDelCabecera := TBonnyquery.Create(Self);
  with QDelCabecera do
  try
    SQL.Add(' delete from tfacturas_cab ');
    SQL.Add('  where cod_factura_fc = :MICOD ');
    ParamByName('MICOD').AsString := QCabFactura.fieldbyname('cod_factura_fc').AsString;

    ExecSQL;

  finally
    free;
  end;
end;

procedure TFManFacturas.tvRelFacturasDblClick(Sender: TObject);
begin
  dsMain.ShowingControl := nil;
end;

procedure TFManFacturas.dxModClick(Sender: TObject);
begin
  if QCabFactura.FieldByName('contabilizado_fc') .AsInteger = 1 then
  begin
    ShowMessage('Factura Contabilizada, no se puede modificar.');
    Exit;
  end;
  if EsRemesada then
  begin
    ShowMessage('Factura Remesada, no se puede modificar.');
    Exit;
  end;
  if QCabFactura.Fieldbyname('automatica_fc').AsInteger = 0 then
    MostrarMantenimientoAlta(QCabFactura.FieldByName('cod_factura_fc').AsString, False)
  else
    MostrarNotasFactura;
end;

procedure TFManFacturas.MostrarMantenimientoAlta(AClave: string; AAlta: boolean);
var StringSQL : String;
begin
  FAltaFacturas:= TFAltaFacturas.Create( self );
  try
    FAltaFacturas.sClave := AClave;
    FAltaFacturas.bAlta := AAlta;
    FAltaFacturas.ShowModal;
  finally
    if FAltaFacturas.ModalResult = mrOk then
    begin
      if AAlta then
      begin
        StringSQL := ' from ' + BEFacturas.Tablas;
        //if BEFacturas.SQLAdi <> '' then
        //  StringSQL := StringSQL + ' where ' + BEFacturas.SQLAdi;
        if pos( 'WHERE', UpperCase(StringSQL) ) = 0 then
          StringSQL := StringSQL + ' where 1 = 1 ';
        StringSQL := StringSQL + ' and cod_factura_fc = ' + QuotedStr(FAltaFacturas.sClave);
        MostrarFacturas(StringSQL);
      end
      else
      begin
        QCabFactura.Refresh;
        QDetFactura.Refresh;
        QGasFactura.Refresh;
        QBasFactura.Refresh;
      end;
    end;
    FreeAndNil(FAltaFacturas );
  end;
end;

procedure TFManFacturas.ActivarBtnConsulta(AActivar: boolean);
begin
  dxLocalizar.Enabled := AActivar;
  dxAlta.Enabled := AActivar and gbEscritura;
//  dxPrimero.Enabled := not AActivar;
//  dxAnterior.Enabled := not AActivar;
//  dxSiguiente.Enabled := not AActivar;
//  dxUltimo.Enabled := not AActivar;
  dxImprimir.Enabled := not AActivar;
  dxBaja.Enabled := not AActivar and gbEscritura;
  dxMod.Enabled := not AActivar and gbEscritura;
  dxSalir.Enabled := true;
  cxPageControl.Enabled := not AActivar;
  dsMain.Enabled := not AActivar;

  gbCabecera.Enabled := false;
  pnlDetLineas.Enabled := false;
  pnlDetGastos.Enabled := false;

end;

procedure TFManFacturas.dsMainShowControl(Sender: TdxDockSite;
  AControl: TdxCustomDockControl);
begin
  dxImprimir.Enabled := false;
  dxBaja.Enabled := false;
  dxMod.Enabled := false;
  dxSalir.Enabled := false; 
end;

procedure TFManFacturas.dsMainHideControl(Sender: TdxDockSite;
  AControl: TdxCustomDockControl);
begin
  ActivarBtnConsulta(False);
end;

procedure TFManFacturas.dsQCabFacturaDataChange(Sender: TObject;
  Field: TField);
begin
  if QCabFactura.Active then
    tsNotasFactura.TabVisible := QCabFactura.fieldbyname('notas_fc').AsString <> ''
  else
    tsNotasFactura.TabVisible := true;
  if QCabFactura.FieldByName('tipo_factura_fc').AsString = kFactura then
    cxLabel6.Caption := 'FACTURA'
  else
    cxLabel6.Caption := 'ABONO';
  if Trim(QCabFactura.FieldByName('cod_factura_anula_fc').AsString) = '' then
    cxAnula.Visible := false
  else
  begin
    cxAnula.Visible := true;
    cxAnula.Caption := ObtenerAnulacion;
  end;
  //cxPageControl.ActivePage := tsCabeceraFactura;
  BtnNavegador;
  if EjecutaQueryDet then QDetFactura.First;
  if EjecutaQueryGas then QGasFactura.First;
  if EjecutaQueryBas then QBasFactura.First;
  if EjecutaQueryRemesas then QRemesas.First;

  MostrarCabecera;
end;

procedure TFManFacturas.dsQGasFacturaDataChange(Sender: TObject;
  Field: TField);
begin
  if QGasFactura.Active then
    tsDetalleGastos.TabVisible := QGasFactura.RecordCount > 0
  else
    tsDetalleGastos.TabVisible := true;
end;

procedure TFManFacturas.dsQDetFacturaDataChange(Sender: TObject;
  Field: TField);
begin
//  cxPageControl.ActivePage := tsDetalleLineas;
end;

procedure TFManFacturas.BtnNavegador;
begin
  dxPrimero.Enabled := not (QCabFactura.BOF) and (QCabFactura.RecNo <> 1) and (QCabFactura.Active);
  dxAnterior.Enabled := not (QCabFactura.BOF) and (QCabFactura.RecNo <> 1) and (QCabFactura.Active);
  dxSiguiente.Enabled := not (QCabFactura.EOF) and (QCabFactura.RecNo <> QCabFactura.RecordCount) and (QCabFactura.Active);
  dxUltimo.Enabled := not (QCabFactura.EOF) and (QCabFactura.RecNo <> QCabFactura.RecordCount) and (QCabFactura.Active);
end;

procedure TFManFacturas.CreaQueryCab;
begin
  QCabFactura := TBonnyClientDataSet.Create(Self);
  dsQCabFactura.DataSet := QCabFactura;
  with QCabFactura do
  begin
    SQL.Add(' select cod_factura_fc, cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, ');
    SQL.Add('        impuesto_fc, tipo_factura_fc, automatica_fc, anulacion_fc, cod_factura_anula_fc, ');
    SQL.Add('        cod_cliente_fc, des_cliente_fc, cta_cliente_fc, nif_fc, ');
    SQL.Add('        tipo_via_fc, domicilio_fc, poblacion_fc, cod_postal_fc, ');
    SQL.Add('        provincia_fc, cod_pais_fc, des_pais_fc, notas_fc, incoterm_fc, plaza_incoterm_fc, ');
    SQL.Add('        forma_pago_fc, des_forma_pago_fc[1,255] des_forma_pago_fc, ');
    SQL.Add('        tipo_impuesto_fc, des_tipo_impuesto_fc, moneda_fc,');
    SQL.Add('        importe_linea_fc, importe_descuento_fc, importe_neto_fc, importe_impuesto_fc, importe_total_fc, ');
    SQL.Add('        importe_neto_euros_fc, importe_impuesto_euros_fc, importe_total_euros_fc, prevision_cobro_fc, prevision_tesoreria_fc, contabilizado_fc ');
//    SQL.Add('        nombre_pln desEmpresa, ');
//    SQL.Add('        case tipo_factura_fc when "380" then "FACTURA" ');
//    SQL.Add('             else "ABONO" end tipoFactura,');
//    SQL.Add('        case automatica_fc when 1 then "AUTOMATICA" ');
//    SQL.Add('             else "MANUAL" end desAutomatica ');
    SQL.Add('  from tfacturas_cab, tplantas ');
    SQL.Add(' where cod_empresa_fac_fc = planta_pln ');
//    CrearCampos;
  end;
end;

procedure TFManFacturas.CreaQueryDet;
begin
  QDetFactura := TBonnyClientDataSet.Create(Self);
  dsQDetFactura.DataSet := QDetFactura;
//  QDetFactura.IndexFieldNames := 'cod_factura_fd;num_linea_fd';
//  QDetFactura.MasterSource := dsQCabFactura;
//  QDetFactura.MasterFields := 'cod_factura_fc';
  with QDetFactura do
  begin
//    SQL.Add(' select * from tfacturas_det ');
    SQL.Add(' select cod_factura_fd, num_linea_fd, cod_empresa_albaran_fd, cod_centro_albaran_fd, n_albaran_fd, fecha_albaran_fd, ');
    SQL.Add('        cod_cliente_albaran_fd, cod_dir_sum_fd, pedido_fd, fecha_pedido_fd, matricula_fd, emp_procedencia_fd, centro_origen_fd, ');
    SQL.Add('        cod_factura_origen_fd, cod_producto_fd, des_producto_fd, cod_envase_fd, cod_envaseold_fd, des_envase_fd, categoria_fd, ');
    SQL.Add('        calibre_fd, marca_fd, nom_marca_fd, cajas_fd, unidades_caja_fd, unidades_fd, kilos_fd, kilos_posei_fd, unidad_facturacion_fd, precio_fd, ');
    SQL.Add('        importe_linea_fd, cod_representante_fd, porcentaje_comision_fd, porcentaje_descuento_fd, euroskg_fd, importe_comision_fd, ');
    SQL.Add('        round(importe_descuento_fd, 2) importe_descuento_fd, round(importe_euroskg_fd, 2) importe_euroskg_fd, round(importe_total_descuento_fd, 2) importe_total_descuento_fd, ');
    SQL.Add('        round(importe_neto_fd, 2) importe_neto_fd, tasa_impuesto_fd, porcentaje_impuesto_fd, importe_impuesto_fd, round(importe_total_fd, 2) importe_total_fd, ');
    SQL.Add('        cod_comercial_fd ');
    SQL.Add(' from tfacturas_det ');
    SQL.Add('  where cod_factura_fd = :MICOD ');
    SQL.Add(' order by num_linea_fd ');
  end;
end;

function TFManFacturas.EjecutaQueryCab: boolean;
begin
  with QCabFactura do
  begin
    if Active then
      Close;
    Open;
    Result := not IsEmpty;
  end;

end;

function TFManFacturas.EjecutaQueryDet: boolean;
begin
  with QDetFactura do
  begin
    if Active then
      Close;

    ParamByName('MICOD').AsString := QCabFactura.fieldbyname('cod_factura_fc').AsString;
    Open;
    Result := not IsEmpty;
  end;
end;

procedure TFManFacturas.CreaQueryGas;
begin
  QGasFactura := TBonnyClientDataSet.Create(Self);
  dsQGasFactura.DataSet := QGasFactura;
  with QGasFactura do
  begin
    SQL.Add(' select * from tfacturas_gas ');
    SQL.Add('  where cod_factura_fg = :MICOD ');
  end;
end;

procedure TFManFacturas.CreaQueryBas;
begin
  QBasFactura := TBonnyClientDataSet.Create(Self);
  dsQBasFactura.DataSet := QBasFactura;
  with QBasFactura do
  begin
    SQL.Add(' select cod_factura_fb, tasa_impuesto_fb, porcentaje_impuesto_fb, cajas_fb, ');
    SQL.Add('        unidades_fb, kilos_fb, round(importe_neto_fb, 2) importe_neto_fb, ');
    SQL.Add('        round(importe_impuesto_fb, 2) importe_impuesto_fb, round(importe_total_fb, 2) importe_total_fb ');
    SQL.Add('   from tfacturas_bas ');
    SQL.Add('  where cod_factura_fb = :MICOD ');
  end;
end;

procedure TFManFacturas.CreaQueryRemesas;
begin
  QRemesas := TBonnyClientDataSet.Create(Self);
  dsQRemesas.DataSet := QRemesas;
  with QRemesas do
  begin
    SQL.Add(' select n_remesa_rc, fecha_vencimiento_rc, descripcion_b, importe_cobrado_rf ');
    SQL.Add('   from tremesas_cab, tremesas_fac, frf_bancos ');
    SQL.Add('  where cod_factura_rf = :codfactura ');
    SQL.Add('    and empresa_remesa_rf = empresa_remesa_rc ');
    SQL.Add('    and n_remesa_rf = n_remesa_rc ');
//    SQL.Add('    and fecha_remesa_rf = fecha_remesa_rc ');
    SQL.Add('    and banco_b = cod_banco_rc ');
  end;
end;

procedure TFManFacturas.CreaQImpuestos;
begin
  QImpuestos := TBonnyQuery.Create(Self);
  with QImpuestos do
  begin
    SQL.Add(' select super_il, reducido_il, general_il, ');
    SQL.Add('        recargo_super_il, recargo_reducido_il, recargo_general_il ');
    SQL.Add('   from frf_impuestos_l ');
    SQL.Add('  where codigo_il = :codigo ');
    SQL.Add('   and :fechafactura between fecha_ini_il and nvl( fecha_fin_il, today ) ');

    Prepare;
  end;
end;

procedure TFManFacturas.CreaQAnula;
begin
  QAnula := TBonnyQuery.Create(Self);
  with QAnula do
  begin
    SQL.Add(' select cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, tipo_factura_fc ');
    SQL.Add('   from tfacturas_cab ');
    SQL.Add('  where cod_factura_fc = :codfactura ');

    Prepare;
  end;
end;

procedure TFManFacturas.CreaQRemesada;
begin
  QRemesada := TBonnyQuery.Create(Self);
  with QRemesada do
  begin
    SQL.Add(' select * from tremesas_fac ');
    SQL.Add('  where empresa_remesa_rf = :empresa ');
    SQL.Add('    and cod_factura_rf = :codfactura ');

    Prepare;
  end;
end;

function TFManFacturas.EjecutaQueryGas: boolean;
begin
  with QGasFactura do
  begin
    if Active then
      Close;

    ParamByName('MICOD').AsString := QCabFactura.fieldbyname('cod_factura_fc').AsString;
    Open;
    Result := not IsEmpty;
  end;
end;

function TFManFacturas.EjecutaQueryBas: boolean;
begin
  with QBasFactura do
  begin
    if Active then
      Close;

    ParamByName('MICOD').AsString := QCabFactura.fieldbyname('cod_factura_fc').AsString;
    Open;
    Result := not IsEmpty;
  end;
end;

function TFManFacturas.EjecutaQueryRemesas: boolean;
begin
  with QRemesas do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QCabFactura.fieldbyname('cod_factura_fc').AsString;
    Open;
    Result := not IsEmpty;
  end;
end;

procedure TFManFacturas.MostrarNotasFactura;
begin
  FNotasFactura:= TFNotasFactura.Create( self );
  try
    FNotasFactura.mmxNotas.Text := QCabFactura.FieldByName('notas_fc').AsString;
    FNotasFactura.ShowModal;
  finally
    if FNotasFactura.ModalResult = mrOk then
    begin
      dsMain.ShowingControl := nil;
      if not (QCabFactura.State in dsEditModes) then QCabFactura.Edit;
      QCabFactura.FieldByName('notas_fc').AsString := FNotasFactura.mmxNotas.Text;
      QCabFactura.Post;
      CamposCalculados;
      FreeAndNil(FNotasFactura);
    end;
  end;
end;

function TFManFacturas.ObtenerAnulacion: string;
begin
  with QAnula do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QCabFactura.FieldByName('cod_factura_anula_fc').AsString;
    Open;

    if QCabFactura.FieldByName('anulacion_fc').AsInteger = 1 then
    begin
      if QCabFactura.FieldByName('tipo_factura_fc').AsString = '380' then
        Result := 'ANULADA  POR ( ' + FieldByName('cod_empresa_fac_fc').AsString + ' - ' +
                       FieldByName('cod_serie_fac_fc').AsString + ' - ' +
                       FieldByName('n_factura_fc').AsString + ' - ' +
                       FieldByName('fecha_factura_fc').AsString + ' )'
      else
        Result := 'ANULA  A ( ' + FieldByName('cod_empresa_fac_fc').AsString + ' - ' +
                       FieldByName('cod_serie_fac_fc').AsString + ' - ' +
                       FieldByName('n_factura_fc').AsString + ' - ' +
                       FieldByName('fecha_factura_fc').AsString + ' )';
    end
    else
    begin
      Result := 'ASOCIADA  A ( ' + FieldByName('cod_empresa_fac_fc').AsString + ' - ' +
                       FieldByName('cod_serie_fac_fc').AsString + ' - ' +
                       FieldByName('n_factura_fc').AsString + ' - ' +
                       FieldByName('fecha_factura_fc').AsString + ' )';
    end;
  end;
end;

procedure TFManFacturas.ActualizarContador;
var QContador, QActContador: TBonnyQuery;
    icontador : integer;
    sSerie: String;
begin
  iContador := 0;
  QContador := TBonnyQuery.Create(Self);
  try
    with QContador do
    try
      SQL.Add(' select cod_serie_fs serie, fac_iva_fs, abn_iva_fs, fac_igic_fs, abn_igic_fs ');
      SQL.Add('     from frf_facturas_serie ');
      SQL.Add('         join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ');
      SQL.Add('               where cod_empresa_es = :empresa ');
      SQL.Add('               and anyo_fs = :anyo ');
      SQL.Add('               and cod_serie_fs = :serie ');

      ParamByName('empresa').AsString := QCabFactura.FieldByName('cod_empresa_fac_fc').AsString;
      ParamByName('anyo').AsInteger := YearOf(QCabFactura.FieldByName('fecha_factura_fc').AsDateTime);
      ParamByName('serie').AsString := QCabFactura.FieldByName('cod_serie_fac_fc').AsString;
      Open;

      sSerie := FieldByName('serie').AsString;

      if QCabFactura.FieldByName('tipo_factura_fc').AsString = '380' then
      begin
        if QCabFactura.FieldByName('impuesto_fc').AsString = 'I' then
        begin
          iContador := FieldByName('fac_iva_fs').AsInteger;
          iIniFactura := 0;
        end
        else if QCabFactura.FieldByName('impuesto_fc').AsString = 'G' then
        begin
          iContador := FieldByName('fac_igic_fs').AsInteger;
          iIniFactura := 200000;
        end;
      end
      else
      begin
        if QCabFactura.FieldByName('impuesto_fc').AsString = 'I' then
        begin
          iContador := FieldByName('abn_iva_fs').AsInteger;
          iIniFactura := 300000;
        end
        else if QCabFactura.FieldByName('impuesto_fc').AsString = 'G' then
        begin
          iContador := FieldByName('abn_igic_fs').AsInteger;
          iIniFactura := 400000;
        end;
      end;
      Close;
    finally
      Free;
    end;


      //Si es la ultima factura generada
    if iContador = QCabFactura.FieldByName('n_factura_fc').AsInteger then
    begin
      UltimaFacturaGen(QCabFactura.FieldByName('cod_empresa_fac_fc').AsString,
                       QCabFactura.FieldByName('fecha_factura_fc').AsDateTime,
                       QCabFactura.FieldByName('n_factura_fc').AsInteger,
                       iIniFactura,
                       iUltFactura,
                       dUltFecha);

      QActContador := TBonnyQuery.Create(Self);
      with QActContador do
      try
        SQL.Add(' update frf_facturas_serie set ');
        if QCabFactura.FieldByName('tipo_factura_fc').AsString = '380' then
        begin
          if QCabFactura.FieldByName('impuesto_fc').AsString = 'I' then
            SQL.Add(' fac_iva_fs = :factura, fecha_fac_iva_fs = :fecha ')
          else if QCabFactura.FieldByName('impuesto_fc').AsString = 'G' then
            SQL.Add(' fac_igic_fs = :factura, fecha_fac_igic_fs = :fecha ');
        end
        else
        begin
          if QCabFactura.FieldByName('impuesto_fc').AsString = 'I' then
            SQL.Add(' abn_iva_fs = :factura, fecha_abn_iva_fs = :fecha ')
          else if QCabFactura.FieldByName('impuesto_fc').AsString = 'G' then
            SQL.Add(' abn_igic_fs = :factura, fecha_abn_igic_fs = :fecha ');
        end;

        SQL.Add(' where cod_serie_fs = :serie ');
        SQL.Add('   and anyo_fs = :anyo ');

        ParamByName('serie').AsString := sSerie;
        ParamByName('anyo').AsInteger := YearOf(QCabFactura.FieldByName('fecha_factura_fc').AsDateTime);
        ParambyName('factura').AsInteger := iUltFactura;
        ParamByName('fecha').AsDateTime := dUltFecha;
        ExecSQL;

       finally
         Free;
       end;
    end;

  except
    raise Exception.Create('Error al obtener/actualizar contador de Facturas.');
  end;
end;

function TFManFacturas.EsRemesada: boolean;
begin
  with QRemesada do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := QCabFactura.Fieldbyname('cod_empresa_fac_fc').AsString;
    ParamByName('codfactura').AsString := QCabFactura.Fieldbyname('cod_factura_fc').AsString;
    Open;

    result := not IsEmpty;
  end;
end;

procedure TFManFacturas.UltimaFacturaGen(const AEmpresa: String; const AFechaFac: TDateTime; const ANumeroFac: integer;
                                         const iIniFactura: Integer;
                                           var iUltFactura: Integer; var iUltFecha: TDateTime);
var QFactura: TBonnyQuery;
begin
  QFactura := TBonnyQuery.Create(Self);
  with QFactura do
  try
    SQL.Add(' select f1.n_factura_fc factura, f1.fecha_factura_fc fecha');
    SQL.Add('   from tfacturas_cab f1 ');
    SQL.Add('  where f1.cod_empresa_fac_fc = :empresa ');
    SQL.Add('    and f1.cod_serie_fac_fc = :serie ');
    SQL.Add('    and f1.fecha_factura_fc between :fechaini and :fechafin  ');
    SQL.Add('    and f1.n_factura_fc > :inifac ');
    SQL.Add('    and f1.n_factura_fc < :ultfac ');
    SQL.Add('    and f1.n_factura_fc = (select  MAX(f2.n_factura_fc) from tfacturas_cab f2 ');
    SQL.Add(' 		                      	where f2.cod_empresa_fac_fc = f1.cod_empresa_fac_fc ');
    SQL.Add('                               and f2.cod_serie_fac_fc = f1.cod_serie_fac_fc ');
    SQL.Add(' 		                      	  and f2.fecha_factura_fc between :fechaini and :fechafin ');
    SQL.Add('  			                        and f2.n_factura_fc > :inifac ');
    SQL.Add(' 		                      	  and f2.n_factura_fc < :ultfac )');

    ParambyName('empresa').AsString := QCabFactura.FieldByName('cod_empresa_fac_fc').AsString;
    ParambyName('serie').AsString := QCabFactura.FieldByName('cod_serie_fac_fc').AsString;
    ParambyName('fechaini').AsDateTime := EncodeDate(YearOf(QCabFactura.FieldByName('fecha_factura_fc').AsDatetime), 1, 1);
    ParamByName('fechafin').AsDateTime := EncodeDate(YearOf(QCabFactura.FieldByName('fecha_factura_fc').AsDatetime),12, 31);

    ParamByName('inifac').AsInteger := iIniFactura;
    ParamByName('ultfac').AsInteger := ANumeroFac;

    Open;

    if not Isempty then
    begin
      iUltFactura := FieldByName('factura').AsInteger;
      dUltFecha := FieldByName('fecha').AsDateTime;
    end
    else
    begin
      iUltFactura := iIniFactura;
      dUltFecha := EncodeDate(YearOf(AFechaFac), 1, 1);
    end;


  finally
    Free;
  end;
end;

procedure TFManFacturas.RellenarDatosIni;
begin
  CerrarTablas;
  IniTotales;

  cxLabel6.Caption := 'FACTURA';
  cxAnula.Visible := false;
end;
procedure TFManFacturas.actCancelarExecute(Sender: TObject);
begin
  dxSalir.Click;
end;

procedure TFManFacturas.CamposCalculados;
var i:integer;
    sDescripcion: String;
begin
  tvRelFacturas.BeginUpdate;
  for i := 0 to tvRelFacturas.DataController.RecordCount - 1 do
  begin
    //Descripcion Empresa
    if i = 0 then
       sDescripcion := desPlanta(tvRelFacturas.DataController.Values[i,tvCabCodEmpresa.index])
    else
    begin
      if tvRelFacturas.DataController.Values[i-1,tvCabCodEmpresa.index] <>
         tvRelFacturas.DataController.Values[i,tvCabCodEmpresa.index] then
            sDescripcion := desPlanta(tvRelFacturas.DataController.Values[i,tvCabCodEmpresa.index])
      else
            sDescripcion := tvRelFacturas.DataController.Values[i-1,tvDesEmpFactura.index];
      end;
    tvRelFacturas.DataController.SetValue(i, tvDesEmpFactura.Index, sDescripcion);

    //Descripcion Tipo Factura
    if tvRelFacturas.DataController.Values[i,tvCabTipoFac.index]  = '380' then
      tvRelFacturas.DataController.SetValue(i, tvCabDesTipoFac.Index, 'FACTURA')
    else
      tvRelFacturas.DataController.SetValue(i, tvCabDesTipoFac.Index, 'ABONO');

    //Descripcion Automatica
    if tvRelFacturas.DataController.Values[i,tvCabAutomatica.index]  = 1 then
      tvRelFacturas.DataController.SetValue(i, tvCabDesAutomatica.Index, 'AUTOMATICA')
    else
      tvRelFacturas.DataController.SetValue(i, tvCabDesAutomatica.Index, 'MANUAL');

  end;
  tvRelFacturas.EndUpdate;
end;

procedure TFManFacturas.AAceptarExecute(Sender: TObject);
begin
  dxLocalizar.Click;
end;

procedure TFManFacturas.actLocalizarExecute(Sender: TObject);
begin
  if dxLocalizar.Enabled then
    dxLocalizar.Click;
end;

procedure TFManFacturas.actAltaExecute(Sender: TObject);
begin
  if dxAlta.Enabled then
    dxAlta.Click;
end;

procedure TFManFacturas.mnuPrevisualizarAlbaranesClick(Sender: TObject);
begin
  if ( not dsQCabFactura.DataSet.Active ) or dsQCabFactura.DataSet.IsEmpty then
  begin
    ShowMessage('Por favor seleccione primero una factura.');
  end
  else
  begin
    AlbaranesAsociadosFacDM.ImprimirAlbaranesAsociados( dsQCabFactura.DataSet.FieldByName('cod_factura_fc').AsString );
    (*
         dsQCabFactura.DataSet.FieldByName('cod_empresa_fac_fc').AsString,
         dsQCabFactura.DataSet.FieldByName('fecha_factura_fc').AsDateTime,
         dsQCabFactura.DataSet.FieldByName('n_factura_fc').AsInteger );
    *)
    WindowState := wsMaximized;
    CamposCalculados;
  end;
end;

procedure TFManFacturas.mnuImprimirAlbaranesClick(Sender: TObject);
begin
  if ( not dsQCabFactura.DataSet.Active ) or dsQCabFactura.DataSet.IsEmpty then
  begin
    ShowMessage('Por favor seleccione primero una factura.');
  end
  else
  begin
    AlbaranesAsociadosFacDM.ImprimirAlbaranesAsociados( dsQCabFactura.DataSet.FieldByName('cod_factura_fc').AsString, False );
    (*
         dsQCabFactura.DataSet.FieldByName('cod_empresa_fac_fc').AsString,
         dsQCabFactura.DataSet.FieldByName('fecha_factura_fc').AsDateTime,
         dsQCabFactura.DataSet.FieldByName('n_factura_fc').AsInteger );
    *)
    WindowState := wsMaximized;
    CamposCalculados;
  end;
end;

procedure TFManFacturas.mnuFacturasDeposito(Sender: TObject);
begin
  if ( not dsQCabFactura.DataSet.Active ) or dsQCabFactura.DataSet.IsEmpty then
  begin
    ShowMessage('Por favor seleccione primero una factura.');
  end
  else
  begin
    Previsualizar( True );
    WindowState := wsMaximized;
    CamposCalculados;
  end;
end;

end.
