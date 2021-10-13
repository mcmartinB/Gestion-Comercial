unit UFManRemesas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  dxBar, cxClasses, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Menus, StdCtrls, cxButtons,
  SimpleSearch, cxTextEdit, cxLabel, ExtCtrls, DB, cxDBEdit, dxBevel,
  dxBarBuiltInMenu, cxPC, cxGroupBox, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  cxCurrencyEdit, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, BonnyClientDataSet,
  BonnyQuery, cxMaskEdit, cxDropDownEdit, cxCalendar, cxMemo, cxCheckBox,
  Grids, DBGrids, ActnList, BusquedaExperta, Rejilla, DPreview,

  dxSkinsCore, dxSkinBlue, dxSkinFoggy,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, dxSkinMoneyTwins, dxSkinBlueprint,
  dxSkinBlack, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TFManRemesas = class(TForm)
    bmx1: TdxBarManager;
    bmx1Bar1: TdxBar;
    dxLocalizar: TdxBarLargeButton;
    dxAlta: TdxBarLargeButton;
    dsQRemesaCab: TDataSource;
    gbCabecera: TcxGroupBox;
    cxLabel10: TcxLabel;
    txDesEmpresa: TcxTextEdit;
    cxLabel11: TcxLabel;
    edtEmpresaRem: TcxDBTextEdit;
    edtNumeroRem: TcxDBTextEdit;
    cxLabel12: TcxLabel;
    cxLabel13: TcxLabel;
    edtClienteRem: TcxDBTextEdit;
    txDesCliente: TcxTextEdit;
    cxLabel14: TcxLabel;
    txDesBanco: TcxTextEdit;
    gbDetalle: TcxGroupBox;
    cxTabControl1: TcxTabControl;
    btnAltaLinea: TcxButton;
    btnBajaLinea: TcxButton;
    btnAceptarLinea: TcxButton;
    btnCancelarLinea: TcxButton;
    pnlAltaLineas: TPanel;
    cxlb9: TcxLabel;
    edtCodigoFac: TcxDBTextEdit;
    dsQRemesaFac: TDataSource;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    tvRemesaFac: TcxGridDBTableView;
    lvRemesaFac: TcxGridLevel;
    cxDetalle: TcxGrid;
    tvCodFactura: TcxGridDBColumn;
    tvCobradoRem: TcxGridDBColumn;
    dxSalir: TdxBarLargeButton;
    deFechaVtoRem: TcxDBDateEdit;
    cxLabel4: TcxLabel;
    deFechaDesRem: TcxDBDateEdit;
    cxLabel15: TcxLabel;
    edtMonedaRem: TcxDBTextEdit;
    txDesMoneda: TcxTextEdit;
    cxLabel16: TcxLabel;
    cxLabel17: TcxLabel;
    cxLabel18: TcxLabel;
    cxLabel19: TcxLabel;
    ceImporteRem: TcxDBCurrencyEdit;
    ceBrutoRem: TcxDBCurrencyEdit;
    ceGastosRem: TcxDBCurrencyEdit;
    ceLiquidoRem: TcxDBCurrencyEdit;
    cxLabel5: TcxLabel;
    txCambio: TcxTextEdit;
    mmxNotas: TcxDBMemo;
    cxLabel6: TcxLabel;
    txImpFacturas: TcxTextEdit;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    txNumFacturas: TcxTextEdit;
    cxDiferencia: TcxLabel;
    dxRemesar: TdxBarLargeButton;
    dxContabilizar: TdxBarLargeButton;
    dxBaja: TdxBarLargeButton;
    dxModificar: TdxBarLargeButton;
    btnSelFactura: TcxButton;
    tvFechaFactura: TcxGridDBColumn;
    tvImporteTotal: TcxGridDBColumn;
    tvTotalCobrado: TcxGridDBColumn;
    tvTipoFactura: TcxGridDBColumn;
    ceImporteCobro: TcxDBCurrencyEdit;
    ceImporteFactura: TcxDBCurrencyEdit;
    edtFechaFactura: TcxDBTextEdit;
    cbRemContabilizada: TcxDBCheckBox;
    tvMonedaFactura: TcxGridDBColumn;
    dxManFactura: TdxBarLargeButton;
    ActionList: TActionList;
    actCancelar: TAction;
    actAceptar: TAction;
    actLocalizar: TAction;
    BERemesas: TBusquedaExperta;
    ReRemesas: TRejilla;
    ssCliente: TSimpleSearch;
    ssBanco: TSimpleSearch;
    ssMoneda: TSimpleSearch;
    edtBancoRem: TcxDBTextEdit;
    dxPrimero: TdxBarLargeButton;
    dxAnterior: TdxBarLargeButton;
    dxSiguiente: TdxBarLargeButton;
    dxUltimo: TdxBarLargeButton;
    cxTabControl2: TcxTabControl;
    btnAceptar: TcxButton;
    btnCancelar: TcxButton;
    lb3: TcxLabel;
    ssEmpresa: TSimpleSearch;
    lb1: TcxLabel;
    txNumeroFac: TcxTextEdit;
    dxImprimir: TdxBarLargeButton;
    tvCodCliente: TcxGridDBColumn;
    cxlbl1: TcxLabel;
    ceCodCliente: TcxDBTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dxAltaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);
    procedure dsQRemesaCabStateChange(Sender: TObject);
    procedure ceImporteRemPropertiesChange(Sender: TObject);
    procedure ceBrutoRemPropertiesChange(Sender: TObject);
    procedure ceGastosRemPropertiesChange(Sender: TObject);
    procedure ceGastosRemExit(Sender: TObject);
    procedure ceBrutoRemExit(Sender: TObject);
    procedure ceImporteRemExit(Sender: TObject);
//    procedure dxCancelarClick(Sender: TObject);
//    procedure dxAceptarClick(Sender: TObject);
    procedure edtEmpresaRemExit(Sender: TObject);
    procedure btnAltaLineaClick(Sender: TObject);
    procedure edtCodigoFacPropertiesChange(Sender: TObject);
    procedure pnlAltaLineasEnter(Sender: TObject);
    procedure pnlAltaLineasExit(Sender: TObject);
    procedure dsQRemesaFacStateChange(Sender: TObject);
    procedure btnAceptarLineaClick(Sender: TObject);
    procedure dxSalirClick(Sender: TObject);
    procedure btnCancelarLineaClick(Sender: TObject);
    procedure btnBajaLineaClick(Sender: TObject);
    procedure dxRemesarClick(Sender: TObject);
    procedure dxLocalizarClick(Sender: TObject);
    procedure dxContabilizarClick(Sender: TObject);
    procedure btnSelFacturaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvRemesaFacDblClick(Sender: TObject);
    procedure dxModificarClick(Sender: TObject);
    procedure dxBajaClick(Sender: TObject);
    procedure edtCodigoFacExit(Sender: TObject);
    procedure dxManFacturaClick(Sender: TObject);
    procedure ssEmpresaAntesEjecutar(Sender: TObject);
    procedure ceImporteCobroExit(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actAceptarExecute(Sender: TObject);
    procedure actLocalizarExecute(Sender: TObject);
    procedure ssBancoAntesEjecutar(Sender: TObject);
    procedure edtClienteRemExit(Sender: TObject);
    procedure btnBajaClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    //procedure btModificarClick(Sender: TObject);
    procedure dxSiguienteClick(Sender: TObject);
    procedure dxUltimoClick(Sender: TObject);
    procedure dxAnteriorClick(Sender: TObject);
    procedure dxPrimeroClick(Sender: TObject);
    procedure dsQRemesaCabDataChange(Sender: TObject; Field: TField);
    procedure txNumeroFacExit(Sender: TObject);
    procedure dxImprimirClick(Sender: TObject);
    procedure deFechaVtoRemPropertiesChange(Sender: TObject);

  private
    bAlta, bCancelar, bAltaLinea, bModLinea, bPrimeraLin,
    bRemesar, bErrorLin, bModCabecera, bModificacion: Boolean;
    QRemesaCab, QRemesaFac: TBonnyClientDataSet;
    QImpRemesa: TBonnyQuery;
    iFacturas, iNumRemesa: integer;
    cImpFacturas, cImporteOld, rImpPendiente: currency;
    QDatos, QDatosImp, QContRemesa, QDelFacturas, QFactura, QGrupo,
    QEmpresaRem, QDesCliente, QImpCobrado, QImpCobrado2, QDatosCliente, QFacturas : TBonnyQuery;
    dFechaVtoRem, dFechaDesRem: TDateTime;
    //ClaveEmpresa, ClaveRemesa: String;
    sFacturas: String;

    procedure CreaQRemesaCab;
    procedure CreaQRemesaCabAlta;
    function EjecutaQRemesaCab: boolean;
    function EjecutaQRemesaCabAlta: boolean;
    procedure CreaQRemesaFac;
    function EjecutaQRemesaFac: boolean;
    procedure CreaCamposFac(Datos: TDataSet);
    procedure CreaQImpRemesa;
    function EjecutaQImpRemesa:boolean;
    procedure CreaQDatos;
    procedure CreaQDatosImp;
    procedure CreaQContRemesa;
    procedure CreaQDelFacturas;
    procedure CreaQFactura;
    procedure CreaQGrupo;
    procedure CreaQEmpresaRem;
    procedure CreaQDesCliente;
    //procedure CreaQCodCliente;
    procedure CreaQImpCobrado;
    procedure CreaQImpCobrado2;
    procedure CreaQDatosCliente;
    procedure CreaQFacturas;
    function EjecutaQFacturas: boolean;
    procedure CalcCamposFac(Datos: TDataSet);
    procedure ActivarCabecera(AActivar: boolean);
    procedure ActivarEdicion(AActivar: boolean);
    procedure PutCambioImporte;
    procedure AltaCabecera;
    procedure AltaDetalle;
    procedure CancelarCabecera;
    function DatosCabCorrectos: boolean;
    function DatosLinCorrectos: Boolean;
    function PonRemesa(AEmpresa: String): String;
    procedure CancelarLinea;
    procedure SumarFactura;
    procedure RestarFactura;
    procedure BorrarLinea;
    procedure CalcDiferencia;
    function ActualizarDatos: boolean;
//    procedure MostrarConsulta;
    function MostrarConsulta(StringSQL: string): boolean;
    function YaExisteFactura(CodFactura: String; Indice: integer): boolean;
    procedure RellenarDatosIni;
    procedure CerrarTablas;
    procedure BorrarFacturas;
    procedure IncrementaRemesa;
    procedure ActualizarRemesaCab;
    procedure ActualizarRemesaFac;
    function EsFactura: boolean;
    procedure SeleccionarFacturas;
    function GetListaFacturas: String;
    procedure DesactivarCampos;
    procedure ActivarCampos;
    function ImporteCorrecto: boolean;
    function GetGrupoEmpresa: String;
    function GetEmpresa: String;
    function DesClienteGrupo(AEmpresa, ACliente:String): String;
    //procedure GetCodCliente;
    procedure GetImpPendiente;
    procedure GetImpPendiente2;
    procedure ObtenerDatosClientes(AEmpresa, ACliente: String);
    procedure MostrarRemesas(SQL: String);
    procedure BtnNavegador;
    //function GetMaxFechaFactura: TDateTime;
    procedure Previsualizar;
    procedure ContabilizarRem;
    procedure DescontabilizarRem;
    function MostrarCliente(ACodigoFactura: String): String;

  public
  end;

var
  FManRemesas: TFManRemesas;

implementation

{$R *.dfm}

uses UDFactura, CVariables, CGestionPrincipal, UDMAuxDB, UDMCambioMoneda,
     UDMBaseDatos, CAuxiliarDB, UFConsultaExpertaRem, bDialogs,
     UFBusFacturas, Principal, UFManFacturas, CGlobal, CFactura, URRemesa;

procedure TFManRemesas.CreaQRemesaCab;
begin
  QRemesaCab:=TBonnyClientDataSet.Create(self);
  dsQRemesaCab.Dataset:=QRemesaCab;
  with QRemesaCab do
  begin
    SQL.Add(' select * from tremesas_cab       ');
//    SQL.Add('  where empresa_remesa_rc = :empresa ');
//    SQL.Add('    and n_remesa_rc = :remesa ');

//    ParamByName('empresa').DataType := ftString;
//    ParamByName('remesa').DataType := ftString;
  end;
end;

procedure TFManRemesas.CreaQRemesaCabAlta;
begin
  QRemesaCab:=TBonnyClientDataSet.Create(self);
  dsQRemesaCab.Dataset:=QRemesaCab;
  with QRemesaCab do
  begin
    SQL.Add(' select * from tremesas_cab       ');
    SQL.Add('  where empresa_remesa_rc = :empresa ');
    SQL.Add('    and n_remesa_rc = :remesa ');

    ParamByName('empresa').DataType := ftString;
    ParamByName('remesa').DataType := ftString;
  end;
end;

function TFManRemesas.EjecutaQRemesaCab: Boolean;
begin

  with QRemesaCab do
  begin
    if Active then
      Close;

    Open;
    Result:= not IsEmpty;
  end;
end;

function TFManRemesas.EjecutaQRemesaCabAlta: Boolean;
begin

  with QRemesaCab do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := '0';
    ParamByName('remesa').AsString := '0';

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TFManRemesas.CreaQRemesaFac;
begin
  QRemesaFac:=TBonnyClientDataSet.Create(self);
  dsQRemesaFac.Dataset:=QRemesaFac;
  with QRemesaFac do
  begin
    (*
    SQL.Add(' select tremesas_fac.*, cod_cliente_fc ');
    SQL.Add(' from tremesas_fac ');
    SQL.Add('      left join tfacturas_cab on cod_factura_rf = cod_factura_fc ');
    SQL.Add(' where empresa_remesa_rf = :empresa ');
    SQL.Add('   and n_remesa_rf = :remesa ');
    *)
    SQL.Add(' select * ');
    SQL.Add(' from tremesas_fac ');
    SQL.Add(' where empresa_remesa_rf = :empresa ');
    SQL.Add('   and n_remesa_rf = :remesa ');
    ParamByName('empresa').DataType := ftString;
    ParamByName('remesa').DataType := ftInteger;

    CreaCamposFac(QRemesaFac);
    OnCalcFields := CalcCamposFac;
  end;
end;

function TFManRemesas.EjecutaQRemesaFac: Boolean;
begin
  with QRemesaFac do
  begin
    if Active then
      Close;
    ParamByName('empresa').AsString := QRemesaCab.FieldByName('empresa_remesa_rc').AsString;
    ParamByName('remesa').AsInteger := QRemesaCab.FieldByName('n_remesa_rc').AsInteger;

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TFManRemesas.CreaCamposFac(Datos: TDataSet);
var I: integer;
begin
  Datos.FieldDefs.Update;
  for I :=0 to Datos.FieldDefs.Count-1 do Datos.FieldDefs[I].CreateField(Datos);

  with TStringField.Create(Datos)do
  begin
    Calculated:= true;
    FieldName := 'clienteFactura';
    DataSet := Datos;
  end;

  with TStringField.Create(Datos)do
  begin
    Calculated:= true;
    FieldName := 'numeroFactura';
    DataSet := Datos;
  end;

  with TDateField.Create(Datos) do
    begin
    Calculated:= true;
    FieldName:= 'fechaFactura';
    DataSet:= Datos;
   end;

  with TCurrencyField.Create(Datos) do
    begin
    Calculated:= true;
    FieldName:= 'importeTotal';
    DataSet:= Datos;
    DisplayFormat:= ',0.00';
    EditFormat   := '#.00';
   end;

  with TCurrencyField.Create(Datos) do
    begin
    Calculated:= true;
    FieldName:= 'totalCobrado';
    DataSet:= Datos;
    DisplayFormat:= ',0.00';
    EditFormat   := '#.00';
   end;

  with TStringField.Create(Datos) do
    begin
    Calculated:= true;
    FieldName:= 'tipoFactura';
    DataSet:= Datos;
    size := 100;
    end;

  with TStringField.Create(Datos) do
    begin
    Calculated:= true;
    FieldName:= 'monedaFactura';
    DataSet:= Datos;
    size := 100;
    end;
end;

procedure TFManRemesas.CreaQImpRemesa;
begin
  QImpRemesa := TBonnyQuery.Create(Self);
  with QImpRemesa do
  begin
    SQL.Add(' select tremesas_cab.*, tremesas_fac.*, ');
    SQL.Add('        nombre_c desCliente, descripcion_b desBanco, descripcion_m desMoneda, ');
    SQL.Add('        fecha_factura_fc fecFactura, n_factura_fc numFactura, importe_total_fc impFactura ');
    SQL.Add(' from tremesas_cab, tremesas_fac, frf_clientes, frf_bancos, frf_monedas, ');
    SQL.Add('        outer(tfacturas_cab) ');
    SQL.Add(' where empresa_remesa_rf = empresa_remesa_rc ');
    SQL.Add('    and n_remesa_rf = n_remesa_rc ');

    SQL.Add('    and cliente_c = cod_cliente_rc ');
{
    SQL.Add('    and empresa_b = (select nvl(MIN(planta_epl),empresa_remesa_rc) from tempresas, tempresa_plantas ');
    SQL.Add('             		     where empresa_emp = empresa_epl ');
		SQL.Add('                        and empresa_emp = empresa_remesa_rc ');
		SQL.Add('                        and contabilizar_emp = 1 )     ');
 }
    SQL.Add('    and banco_b = cod_banco_rc ');

    SQL.Add('    and moneda_m = moneda_cobro_rc ');

    SQL.Add('    and cod_factura_fc = cod_factura_rf ');

    SQL.Add('    and empresa_remesa_rc = :grupoempresa ');
    SQL.Add('    and n_remesa_rc = :numeroremesa ');
    SQL.Add(' order by cod_factura_rf ');

    Prepare;
  end;
end;

function TFManRemesas.EjecutaQImpRemesa: boolean;
begin
  with QImpRemesa do
  begin
    if Active then
      Close;

    ParamByName('grupoempresa').AsString := QRemesaCab.FieldByName('empresa_remesa_rc').AsString;
    ParamByName('numeroremesa').AsInteger := QRemesaCab.FieldByName('n_remesa_rc').AsInteger;

    Open;
    Result := not IsEmpty;
  end;
end;

procedure TFManRemesas.CreaQDatos;
begin
  QDatos := TBonnyQuery.Create(Self);
  with QDatos do
  begin
    SQL.Add(' select tipo_factura_fc, moneda_fc, anulacion_fc, n_factura_fc, fecha_factura_fc, importe_total_fc, cod_cliente_fc ');
    SQL.Add('   from tfacturas_cab ');
    SQL.Add('  where cod_factura_fc = :codfactura ');

    Prepare;
  end;
end;

procedure TFManRemesas.CreaQDatosImp;
begin
  QDatosImp := TBonnyQuery.Create(Self);
  with QDatosImp do
  begin
    SQL.Add(' select nvl(sum(importe_cobrado_rf), 0) importe ');
    SQL.Add('  from tremesas_fac ');
    SQL.Add(' where empresa_remesa_rf = :empresa ');
    SQL.Add('  and cod_factura_rf = :codfactura ');

    Prepare;
  end;
end;

procedure TFManRemesas.CreaQContRemesa;
begin
      //REFERENCIA REMESA
  QContRemesa := TBonnyQuery.Create(Self);
  with QContRemesa do
  begin
    SQL.Add(' select ref_cobros_e from frf_empresas ');
    SQL.Add('  where empresa_e = :empresa ');

    Prepare;
  end;
end;

procedure TFManRemesas.CreaQDelFacturas;
begin
  QDelFacturas := TBonnyquery.Create(Self);
  with QDelFacturas do
  begin
    SQL.Add(' delete from tremesas_fac ');
    SQL.Add('  where empresa_remesa_rf = :empresa ');
    SQL.Add('    and n_remesa_rf = :remesa ');

    Prepare;
  end;
end;

procedure TFManRemesas.CreaQFactura;
begin
  QFactura := TBonnyQuery.Create(Self);
  with QFactura do
  begin
    SQL.Add(' select cod_empresa_fac_fc, cod_cliente_fc ');
    SQL.Add('   from tfacturas_cab ');
    SQL.Add('  where cod_factura_fc = :codfactura ');

    Prepare;
  end;
end;

procedure TFManRemesas.CreaQGrupo;
begin
  QGrupo := TBonnyQuery.Create(Self);
  with QGrupo do
  begin
    SQL.Add(' select * from tempresa_plantas ');
    SQL.Add('  where empresa_epl = :grupoempresa ');
    SQL.Add('     and planta_epl = :empresa ');

    Prepare;
  end;
end;

procedure TFManRemesas.CreaQEmpresaRem;
begin
  QEmpresaRem := TBonnyQuery.Create(Self);
  with QEmpresaRem do
  begin
    SQL.Add(' select empresa_e ');
    SQL.Add(' from frf_empresas ');
    SQL.Add(' where empresa_e = (select MIN(planta_epl) from tempresas, tempresa_plantas ');
    SQL.Add(' 		    where empresa_emp = empresa_epl ');
    SQL.Add(' 		      and empresa_emp = :grupoempresa ');
    SQL.Add(' 		      and contabilizar_emp = 1) ');

    Prepare;
  end;
end;

procedure TFManRemesas.CreaQDesCliente;
begin
  QDesCliente := TBonnyQuery.Create(Self);
  with QDesCliente do
  begin
    SQL.Add(' select nombre_c ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where cliente_c = :cliente ');

    Prepare;
  end;
end;

(*
procedure TFManRemesas.CreaQCodCliente;
begin
  QCodCliente := TBonnyQuery.Create(Self);
  with QCodCliente do
  begin
    SQL.Add(' select cod_cliente_fc ');
    SQL.Add(' from tfacturas_cab   ');
    SQL.Add(' where cod_factura_fc = :codfactura ');
    Prepare;
  end;
end;
*)

procedure TFManRemesas.CreaQImpCobrado;
begin
  QImpCobrado := TBonnyQuery.Create(Self);
  with QImpCobrado do
  begin
    SQL.Add(' select count(*) cantidad, sum(importe_cobrado_rf) importe_cobrado ');
    SQL.Add(' from tremesas_fac ');
    SQL.Add(' where cod_factura_rf = :codfactura ');
    SQL.Add('   and es_fac_comercial_rf = 1 ');
    Prepare;
  end;
end;

procedure TFManRemesas.CreaQImpCobrado2;
begin
  QImpCobrado2 := TBonnyQuery.Create(Self);
  with QImpCobrado2 do
  begin
    SQL.Add(' select count(*) cantidad, sum(importe_cobrado_rf) importe_cobrado ');
    SQL.Add('   from tremesas_fac            ');
    SQL.Add('  where empresa_remesa_rf = :empresa ');
    SQL.Add('    and cod_factura_rf = :codfactura ');
    SQL.Add('    and n_remesa_rf <> :remesa ');
    SQL.Add('    and es_fac_comercial_rf = 1 ');

    Prepare;
  end;
end;

procedure TFManRemesas.CreaQDatosCliente;
begin
  QDatosCliente := TBonnyQuery.Create(Self);
  with QDatosCliente do
  begin
    SQL.Add(' select banco_ct banco_c, moneda_c ');
    SQL.Add(' from frf_clientes, frf_clientes_tes ');
    SQL.Add(' where cliente_c = :cliente ');
    SQL.Add('   and cliente_ct = cliente_c ');
    SQL.Add('   and empresa_ct = (select min(planta_epl) from tempresas, tempresa_plantas ');
    SQL.Add('      			     where empresa_emp = empresa_epl                              ');
    SQL.Add('       			       and empresa_emp = :grupoempresa                          ');
    SQL.Add('       			       and contabilizar_emp = 1)                                ');

    Prepare;
  end;
end;

procedure TFManRemesas.CreaQFacturas;
begin
  QFacturas := TBonnyQuery.Create(Self);
  with QFacturas do
  begin
    SQL.Add(' select n_factura_fc, cod_factura_fc                                            ');
    SQL.Add('   from tfacturas_cab                                                           ');
    SQL.Add(' where n_factura_fc = :numerofactura                                            ');
    SQL.Add('   and fecha_factura_fc between :fechadesde and :fechahasta                     ');
    SQL.Add('   and cod_empresa_fac_fc = (select planta_epl from tempresas, tempresa_plantas ');
    SQL.Add('    			     where empresa_emp = empresa_epl                                   ');
    SQL.Add('     			       and empresa_emp = :grupoempresa                               ');
    SQL.Add('     			       and contabilizar_emp = 1                                      ');
    SQL.Add('  			       and planta_epl = cod_empresa_fac_fc)                              ');

    Prepare;
  end;
end;

function TFManRemesas.EjecutaQFacturas: boolean;
var sLista: String;
begin
  TryStrToDate( deFechaVtoRem.Text, dFechaVtoRem );
  sLista := GetListaFacturas;
  with QFacturas do
  begin
    if Active then
      Close;

    SQL.Clear;

    SQL.Add(' select cod_empresa_fac_fc, cod_factura_fc, n_factura_fc, fecha_factura_fc, ');
    SQL.Add('        anulacion_fc, tipo_factura_fc, importe_total_fc ');
    SQL.Add('   from tfacturas_cab ');
    SQL.Add('  where cod_empresa_fac_fc in ');
    SQL.Add('     		(select planta_epl from tempresas, tempresa_plantas ');
    SQL.Add('  		      where empresa_emp = empresa_epl ');
    SQL.Add('  		        and empresa_emp = :grupoempresa ');
    SQL.Add('  		        and contabilizar_emp = 1) ');
    SQL.Add('   and moneda_fc  = :moneda ');
    SQL.Add('   and fecha_factura_fc between :fechadesde and :fechahasta ');
{
    SQL.Add('      and( abs( ( importe_total_fc - ( select SUM(importe_cobrado_rf) ');
    SQL.Add(' 	                       from tremesas_fac, tremesas_cab ');
    SQL.Add('                        	where empresa_remesa_rf = empresa_remesa_rc ');
    SQL.Add(' 	                        and n_remesa_rf = n_remesa_rc ');
    SQL.Add('                                 and cod_factura_rf = cod_factura_fc) ) ) > 0.009 ');
    SQL.Add('        or ');
    SQL.Add(' 	(not exists (select * from tremesas_fac ');
    SQL.Add('  		      where cod_factura_rf = cod_factura_fc)) ) ');
 }
    SQL.Add('  and  (abs (importe_total_fc - nvl((select SUM(importe_cobrado_rf) from tremesas_fac where cod_factura_rf = cod_factura_fc), 0)) > 0.009) ');
//    SQL.Add('         or ');
//    SQL.Add('        (cod_factura_fc not in (select cod_factura_rf from tremesas_fac)) ) ');

    if sLista <> '' then
      SQL.Add('   and cod_factura_fc not in ( '+ sLista + ' ) ');
    if txNumeroFac.Text <> '' then
      SQL.Add('   and n_factura_fc = :numeroFactura ')
    else
      SQL.Add('   and cod_cliente_fc = :cliente ');

    ParamByName('grupoempresa').AsString := QRemesaCab.FieldByName('empresa_remesa_rc').AsString;
    ParamByName('moneda').AsString := QRemesaCab.FieldByName('moneda_cobro_rc').AsString;
    ParamByName('fechadesde').AsDateTime := dFechaVtoRem - 365;
    ParamByName('fechahasta').AsDateTime := dFechaVtoRem + 180;
    if txNumeroFac.Text <> '' then
      ParamByName('numerofactura').AsString := txNumeroFac.Text
    else
      ParamByName('cliente').AsString := QRemesaCab.FieldByName('cod_cliente_rc').AsString;

    //SQL.savetofile('c:\pepe.sql');
    Open;
    Last;
    First;
    Result := not IsEmpty;
  end;
end;

procedure TFManRemesas.CalcCamposFac(Datos: TDataSet);
var ctotalCobrado: currency;
    sNumeroFactura, sFechaFactura, sMonedaFactura, stipoFactura, sImporteTotal, sClienteFactura: String;
begin
  with QDatos do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QRemesaFac.FieldByName('cod_factura_rf').AsString;
    Open;
    if IsEmpty then
    begin
      sNumeroFactura := '';
      sFechaFactura := '';
      sImporteTotal := '';
      stipoFactura := '';
      sMonedaFactura := '';
      sClienteFactura := '';
    end
    else
    begin
      sClienteFactura := FieldByName('cod_cliente_fc').AsString;;
      sNumeroFactura := FieldByName('n_factura_fc').AsString;
      sFechaFactura := FieldByName('fecha_factura_fc').AsString;
      sMonedaFactura := FieldByName('moneda_fc').AsString;
      sImporteTotal := FieldByName('importe_total_fc').AsString;
      if FieldByName('anulacion_fc').AsInteger = 1 then
        sTipoFactura := 'ANULACION'
      else if FieldByName('tipo_factura_fc').AsString = '381' then
        sTipoFactura := 'ABONO'
      else if FieldByName('tipo_factura_fc').AsString = '380' then
        sTipoFactura := 'FACTURA'
      else
        sTipoFactura := 'SIN DEFINIR';
    end;
  end;

  Datos.FieldByName('clienteFactura').AsString:= sClienteFactura;
  Datos.FieldByName('numeroFactura').AsString:= sNumeroFactura;
  Datos.FieldByName('fechaFactura').AsString:= sFechaFactura;
  Datos.FieldByName('monedaFactura').AsString:= sMonedaFactura;
  Datos.FieldByName('importeTotal').AsString:= sImporteTotal;
  Datos.FieldByName('tipoFactura').AsString := sTipoFactura;

  with QDatosImp do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := QRemesaFac.FieldByName('empresa_remesa_rf').AsString;
    ParamByName('codfactura').AsString := QRemesaFac.FieldByName('cod_factura_rf').AsString;

    Open;

    ctotalCobrado := FieldByName('importe').AsFloat;// + QRemesaFac.FieldByName('importe_cobrado_rf').AsFloat;
  end;

  Datos.FieldByName('totalCobrado').AsFloat := ctotalCobrado;

end;

procedure TFManRemesas.ActivarCabecera(AActivar: boolean);
begin
  gbCabecera.Enabled := AActivar;
  dxLocalizar.Enabled := not AActivar;
  dxAlta.Enabled := not AActivar and gbEscritura;
  dxSalir.Enabled := not AActivar;
end;

procedure TFManRemesas.ActivarEdicion(AActivar: boolean);
begin
  dxBaja.Enabled := AActivar and not bAlta and (QRemesaCab.FieldByName('contabilizado_rc').AsInteger <> 1) and not (dxRemesar.Enabled) and gbEscritura;
  dxModificar.Enabled := AActivar and not bAlta and (QRemesaCab.FieldByName('contabilizado_rc').AsInteger <> 1) and gbEscritura;
  dxContabilizar.Enabled := AActivar and not bAlta and not (dxRemesar.Enabled) and gbEnlaceContable;      
  dxManFactura.Enabled := AActivar and not bAlta and not (dxRemesar.Enabled);
  dxImprimir.Enabled := AActivar and not bAlta and not (dxRemesar.Enabled);
  dxSalir.Enabled := AActivar;
  gbDetalle.Enabled := true;    //siempre activo para poder utilizar el scroll
  pnlAltaLineas.Enabled := (bAltaLinea) or(bModLinea) or (AActivar and (QRemesaCab.FieldByName('contabilizado_rc').AsInteger <> 1));
  cxTabControl1.Enabled := (bAltaLinea) or(bModLinea) or (AActivar and (QRemesaCab.FieldByName('contabilizado_rc').AsInteger <> 1));
end;

procedure TFManRemesas.PutCambioImporte;
var rBrutoRem, rImporteRem, rFactor, rDiferencia: currency;
begin
  if QRemesaCab.FieldByName('bruto_euros_rc').AsString = '' then
    QRemesaCab.FieldByName('bruto_euros_rc').AsFloat := 0;
  rBrutoRem := QRemesaCab.FieldByName('bruto_euros_rc').AsFloat;
  if QRemesaCab.FieldByName('importe_cobro_rc').AsString = '' then
    QRemesaCab.FieldByName('importe_cobro_rc').AsFloat := 0;
  rImporteRem := QRemesaCab.FieldByName('importe_cobro_rc').AsFloat;

  if rImporteRem <> 0 then
    rFactor := rBrutoRem  / rImporteRem
  else
    rFactor := 0;

  txCambio.Text:= FormatFloat( '#0.000', rFactor );

  QRemesaCab.FieldByName('liquido_euros_rc').AsFloat := QRemesaCab.FieldByName('bruto_euros_rc').AsFloat -
                                                        QRemesaCab.FieldByName('gastos_euros_rc').AsFloat;

  if not bAlta then
  begin
    rDiferencia := ceImporteRem.Value - StrToFloat(txImpFacturas.Text);
    cxDiferencia.Caption := FormatFloat('#,##0.00', rDiferencia);
//    cxDiferencia.Caption := FloatToStr(rDiferencia);
  end;

end;

procedure TFManRemesas.AltaCabecera;
begin
  QRemesaCab.Append;

  QRemesaCab.FieldByName('empresa_remesa_rc').AsString := GetGrupoEmpresa;
  QRemesaCab.FieldByName('fecha_vencimiento_rc').AsDateTime := Date;
  QRemesaCab.FieldByName('fecha_descuento_rc').AsDateTime := Date;
  QRemesaCab.FieldByName('importe_cobro_rc').AsFloat := 0;
  QRemesaCab.FieldByName('bruto_euros_rc').AsFloat := 0;
  QRemesaCab.FieldByName('gastos_euros_rc').AsFloat := 0;
  QRemesaCab.FieldByName('liquido_euros_rc').AsFloat := 0;
  QRemesaCab.FieldByName('contabilizado_rc').AsInteger := 0;
  QRemesaCab.FieldByName('fecha_conta_rc').AsString := '';
end;

procedure TFManRemesas.AltaDetalle;
begin
  QRemesaFac.Append;

  QRemesaFac.FieldByName('empresa_remesa_rf').AsString := QRemesaCab.FieldByName('empresa_remesa_rc').AsString;
  QRemesaFac.FieldByName('n_remesa_rf').AsInteger := QRemesaCab.FieldByName('n_remesa_rc').AsInteger;

end;
procedure TFManRemesas.CancelarCabecera;
begin
  if QRemesaCab.State in dsEditmodes then
    case MessageDlg('¿Desea guardar la cabecera de la Remesa?', mtInformation, [mbNo,mbYes,mbCancel ],0) of
      mryes:
      begin
        btnAceptarClick(Self);
        Exit;
      end;
      mrNo:
      begin
        if bAlta then
        begin
          dxRemesar.Enabled := false;
          bCancelar := true;
          bModCabecera := false;
          ActivarEdicion(False);
          ActivarCabecera(False);
          BtnNavegador;
          RellenarDatosIni;
        end
        else
        begin
          dxRemesar.Enabled := bRemesar and gbEscritura;
          bCancelar := true;
          bModCabecera := false;
          ActivarCampos;
          ActivarEdicion(True);
          BtnNavegador;
          gbCabecera.Enabled := false;
        end;
        QRemesaCab.Cancel;
        exit;
      end;
  end;
end;

function TFManRemesas.DatosCabCorrectos: Boolean;
//var dFechaMax: TDateTime;
begin
  mmxNotas.SetFocus;

  Result := false;
    //Empresa
  if txDesEmpresa.Text = '' then
  begin
    ShowMessage( 'El código de la empresa para la remesa es incorrecto.');
    edtEmpresaRem.SetFocus;
    exit;
  end;
    //Cliente
  if txDesCliente.Text = '' then
  begin
    ShowMessage( 'El código de cliente para la remesa es incorrecto.');
    edtClienteRem.SetFocus;
    exit;
  end;
    //Banco
  if txDesBanco.Text = '' then
  begin
    ShowMessage( 'El código de banco para la remesa es incorrecto.');
    edtBancoRem.SetFocus;
    exit;
  end;
    //Moneda
  if txDesMoneda.Text = '' then
  begin
    ShowMessage( 'El código de moneda para la remesa es incorrecto.');
    edtMonedaRem.SetFocus;
    exit;
  end;
    //Fecha Vencimiento
  if not TryStrToDate( deFechaVtoRem.Text, dFechaVtoRem ) then
  begin
    ShowMessage( 'La fecha de Remesa es incorrecta.');
    deFechaVtoRem.SetFocus;
    exit;
  end;
    //Fecha Descuento
  if not TryStrToDate( deFechaDesRem.Text, dFechaDesRem ) then
  begin
    ShowMessage( 'La fecha de Descuento para la remesa es incorrecta.');
    deFechaDesRem.SetFocus;
    exit;
  end;
  (*
  if dFechaVtoRem > dFechaDesRem then
  begin
    ShowMessage('La fecha de Descuento debe ser igual o superior a la fecha de Vencimiento.');
    deFechaDesRem.SetFocus;
    Exit;
  end;

  //Fecha Vencimiento debe ser >= fecha factura de lineas Remesa
  dFechaMax := GetMaxFechaFactura;
  if dFechaVtoRem < dFechaMax then
  begin
    ShowMessage('La fecha (' + DateToStr(dFechaMax) +
                ') de una de las facturas insertadas en la Remesa, no puede ser mayor que la fecha de Vencimiento.');
    deFechaVtoRem.SetFocus;
    exit;
  end;

  //Fecha Descuento debe ser >= fecha factura de lineas Remesa
  dFechaMax := GetMaxFechaFactura;
  if dFechaDesRem < dFechaMax then
  begin
    ShowMessage('La fecha (' + DateToStr(dFechaMax) +
                ') de una de las facturas insertadas en la Remesa, no puede ser mayor que la fecha de Descuento.');
    deFechaDesRem.SetFocus;
    exit;
  end;
  *)
  (*
    //Control Importe
  if (QRemesaCab.FieldByName('importe_cobro_rc').AsFloat = 0) or
     (QRemesaCab.FieldByName('bruto_euros_rc').AsFloat = 0) then
  begin
    ShowMessage( 'El importe Total de la Remesa no puede ser cero.');
    ceImporteRem.SetFocus;
    exit;
  end;
  *)
  //El cambio de moneda debe estar grabado
  if not ChangeExist( edtMonedaRem.Text, deFechaVtoRem.Text ) then
  begin
    ceBrutoRem.Text:= '0';
    ShowMessage('Falta grabar el cambio de "' + edtMonedaRem.Text + '" ' +
                           'del dia "' + deFechaVtoRem.Text + '".');
    deFechaVtoRem.SetFocus;
    exit;
  end;

  result := true;
end;

function TFManRemesas.DatosLinCorrectos: Boolean;
var sCliente: string;
begin
  Result := false;
  bErrorLin:= true;

  sCliente := MostrarCliente(QRemesaFac.FieldByName('cod_factura_rf').AsString);
  if edtClienteRem.Text <> sCliente then
  begin
    ShowMessage(' ATENCION! El cliente no es el mismo que el de la cabecera de la remesa.');
    edtCodigoFac.SetFocus;
    Result := true;             // Muestra el mensaje, pero deja continuar
    exit;
  end;

  if edtCodigoFac.Text = ''   then
  begin
    ShowMessage(' Falta introducir Código de Factura.');
    edtCodigoFac.SetFocus;
    exit;
  end;

  (*
  if txNumeroFac.Text = '' then
  begin
    ShowMessage(' Falta introducir Numero de Factura.');
    txNumeroFac.SetFocus;
    exit;
  end;
  *)

  if (ceImporteCobro.Text = '') or (ceImporteCobro.Value = 0) then
  begin
    if ceImporteCobro.Value = 0 then
    begin
      if MessageDlg('ATENCION el importe a cobrar es cero, ¿esta seguro que desea continuar?', mtWarning, [mbYes, mbNo], 0	) = mrNo  then
      begin
         ceImporteCobro.SetFocus;
         Exit;
      end;
    end
    else
    begin
      ShowMessage(' ERROR al introducir el importe a cobrar.');
      ceImporteCobro.SetFocus;
      exit;
    end;
  end;


  if EsFactura then
  begin
    (*
    if txNumeroFac.Text = '' then
    begin
      ShowMessage(' Falta introducir Numero de Factura.');
      txNumeroFac.SetFocus;
      exit;
    end;
    *)

    (*
    if ((ceImporteFactura.Value > 0) and (ceImporteCobro.Value < 0 )) or
       ((ceImporteFactura.Value < 0) and (ceImporteCobro.Value > 0 )) then
    begin
      if ceImporteFactura.Value > 0 then
        ShowMessage(' ERROR. El importe a Cobrar debe ser positivo.');
      if ceImporteFactura.Value < 0 then
        ShowMessage(' ERROR. El importe a Cobrar debe ser negativo.');

      ceImporteCobro.SetFocus;
      exit;
    end;

    rImpCobrado := ceImporteCobro.Value;
    if ABS(rImpCobrado) > ABS(rImpPendiente) then
    begin
      ShowMessage(' ERROR el importe cobrado no puede ser mayor que el importe pendiente de la factura. ');
      QRemesaFac.FieldByName('importe_cobrado_rf').AsFloat := rImpPendiente;
      ceImporteCobro.SetFocus;
      exit;
    end;
    *)
  end;

  if YaExisteFactura(edtCodigoFac.Text, tvRemesaFac.DataController.FocusedRecordIndex) then
  begin
    ShowMessage( 'La Factura ' + edtCodigoFac.Text + ' ya está introducido en esta remesa.');
    edtCodigoFac.SetFocus;
    exit;
  end;

    //Moneda Factura
    //Si no existe fecha, significa que es una factura de proveedor
  if edtFechaFactura.Text <> '' then
  begin
{
    if QRemesaFac.FieldByName('fechaFactura').AsDateTime > deFechaVtoRem.Date then
    begin
      ShowMessage('La fecha de la factura / abono es superior a la de la remesa.');
      txNumeroFac.SetFocus;
      exit;
    end;
}
    if QRemesaFac.FieldByName('monedaFactura').AsString <> edtMonedaRem.Text then
    begin
      ShowMessage(' La moneda de la factura (' + QRemesaFac.FieldByName('monedaFactura').AsString +
                  ')  es distinta de la remesa (' + edtMonedaRem.Text + ')');
      txNumeroFac.SetFocus;
      exit;
    end;
  end;

  Result := True;
end;

function TFManRemesas.PonRemesa(AEmpresa: String): string;
var Aux: Integer;
begin
    //REFERENCIA REMESA
  with QContRemesa do
  begin
    ParamByName('empresa').AsString := edtEmpresaRem.Text;
    Open;
    if isEmpty then
    begin
      PonRemesa := '-1';
      Exit;
    end;

    Aux := FieldByName('ref_cobros_e').AsInteger;
    PonRemesa := IntToStr(Aux + 1);
  end;
end;

procedure TFmanRemesas.CancelarLinea;
begin
  if QRemesaFac.State in dsEditModes then
  begin
    case MessageDlg('¿Desea guardar la linea de la Remesa?', mtInformation, [mbNo,mbYes,mbCancel ],0) of
      mryes:
      begin
        btnAceptarLineaClick(self);
        Exit;
      end;
      mrno:
      begin
        if bAltaLinea then
          QRemesaFac.Delete(False);
        QRemesaFac.Cancel;
        dxRemesar.Enabled := bRemesar and gbEscritura;
        ActivarEdicion(True);
        bAltaLinea := false;
        bModLinea := false;
        pnlAltaLineas.Visible := false;
        BtnNavegador;
      end;
    end;
  end;
end;

procedure TFManRemesas.SumarFactura;
begin
  if bAltaLinea then
  begin
    Inc( iFacturas );
    cImpFacturas := cImpFacturas + ceImporteCobro.Value;
  end
  else
  begin
    cImpFacturas := cImpFacturas - cImporteOld;
    cImpFacturas := cImpFacturas + ceImporteCobro.Value;
  end;

  txNumFacturas.Text := IntToStr(iFacturas);
  txImpFacturas.Text := FormatFloat( '#0.00', cImpFacturas );
  CalcDiferencia;
end;

procedure TFManRemesas.RestarFactura;
begin
  Dec( iFacturas );
  cImpFacturas := cImpFacturas - QRemesaFac.FieldByName('importe_cobrado_rf').AsFloat;
  txNumFacturas.Text := IntToStr(iFacturas);
  txImpFacturas.Text := FormatFloat( '#0.00', cImpFacturas );
  CalcDiferencia;
end;

procedure TFManRemesas.BorrarLinea;
begin
  QRemesaFac.Delete(False);
end;

procedure TFManRemesas.CalcDiferencia;
var cDif: currency;
begin
  cDif := cImpFacturas - QRemesaCab.FieldByName('importe_cobro_rc').AsFloat;
  (*
  if edtMonedaRem.Text <> 'EUR' then
    cDif := cImpFacturas - QRemesaCab.FieldByName('importe_cobro_rc').AsFloat
  else
    cDif := cImpFacturas - QRemesaCab.FieldByName('bruto_euros_rc').AsFloat;
  *)
  cxDiferencia.Caption := FormatFloat( '#,##0.00', cDif );

  if cDif < 0 then
  begin
    txImpFacturas.Style.Color := clHotLight;
    txImpFacturas.Style.Font.Color := clWindow;
    cxDiferencia.Style.Font.Color := clHotLight;
  end
  else if cDif > 0 then
  begin
    txImpFacturas.Style.Color := clRed;
    txImpFacturas.Style.Font.Color := clWindow;
    cxDiferencia.Style.Font.Color := clRed;
  end
  else
  begin
    cxDiferencia.Caption := '';
    txImpFacturas.Style.Color := clBtnFace;
    txImpFacturas.Style.Font.Color := clWindowText;
    cxDiferencia.Style.Font.Color := clBtnFace;
  end;

end;

function TFManRemesas.ActualizarDatos: boolean;
begin
  result := false;
  try
    AbrirTransaccion(DMBaseDatos.DBBaseDatos);

    if bAlta then
    begin
      IncrementaRemesa;
      if IntToStr(iNumRemesa) <> edtNumeroRem.Text then
      begin
        ActualizarRemesaCab;
        ActualizarRemesaFac;
      end;
      QRemesaCab.ApplyUpdates(0);
      QRemesaFac.ApplyUpdates(0);
    end
    else
    begin
      QRemesaCab.ApplyUpdates(0);
      QRemesaFac.ApplyUpdates(0);
    end;
    AceptarTransaccion(DMBaseDatos.DBBaseDatos);
    result := true;

  except
      on E:Exception do
      begin
          QRemesaCab.Cancel;
          QRemesaFac.Cancel;
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      end;
  end;
end;

function TFManRemesas.MostrarCliente(ACodigoFactura: String): String;
begin
  with DFactura.QAux do
  begin

    SQL.Clear;
    SQL.Add(' select cod_cliente_fc from tfacturas_cab ');
    SQL.Add('  where cod_factura_fc = :codigofactura ');

    ParamByName('codigofactura').AsString:= ACodigoFactura;
    Open;
    if not IsEmpty then
      Result := FieldByName('cod_cliente_fc').AsString
    else
      Result := '';
  end;

end;

function TFManRemesas.MostrarConsulta(StringSQL: string): boolean;
begin

  with QRemesaCab do
  begin
    SQL.Clear;

    SQL.Add(' select DISTINCT tremesas_cab.* ');
    SQL.Add(StringSQL);
    SQL.Add(' order by empresa_remesa_rc, n_remesa_rc ');
  end;

  Result := EjecutaQRemesaCab;
  EjecutaQRemesaFac;
end;

function TFManRemesas.YaExisteFactura(CodFactura: String; Indice: integer): boolean;
var i:integer;
begin
  result := false;
  for i:= 0 to tvRemesaFac.Datacontroller.RecordCount-1 do
    if i <> Indice then
    begin
      if tvRemesaFac.DataController.GetValue(i, tvCodFactura.Index) = CodFactura then
      begin
        Result := True;
        exit;
      end;
    end;
end;

procedure TFManRemesas.RellenarDatosIni;
begin
  CerrarTablas;

  iFacturas := 0;
  cImpFacturas := 0;
  txNumFacturas.Text := '';
  txImpFacturas.Text := '';
  cxDiferencia.Caption := '';
  txImpFacturas.Style.Color := clBtnFace;
  txImpFacturas.Style.Font.Color := clWindowText;
  cxDiferencia.Style.Font.Color := clBtnFace;

  bPrimeraLin := true;
  bAlta := false;
  bCancelar := false;
  bRemesar := false;
  bErrorLin := false;
  bModCabecera := false;
  bModificacion := false;
end;

procedure TFManRemesas.CerrarTablas;
begin
  CloseQuerys([QRemesaCab, QRemesaFac, QDatos, QDatosImp, QContRemesa,
                 QDelFacturas, QFactura, QGrupo, QDesCliente, QImpCobrado, QImpCobrado2, QDatosCliente,
                 QFacturas]);
end;

procedure TFManRemesas.BorrarFacturas;
begin
  with QDelFacturas do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := QRemesaCab.fieldbyname('empresa_remesa_rc').AsString;
    ParamByName('remesa').AsInteger := QRemesaCab.fieldbyname('n_remesa_rc').AsInteger;

    ExecSQL;
  end;
end;

procedure TFManRemesas.IncrementaRemesa;
var QIncRemesa: TBonnyQuery;
begin
    //REFERENCIA REMESA
  QIncRemesa := TBonnyQuery.Create(Self);
  with QIncRemesa do
  try
    try
      SQL.Add(' select ref_cobros_e from frf_empresas ');
      SQL.Add('  where empresa_e = :empresa ');
      ParamByName('empresa').AsString := edtEmpresaRem.Text;
      Open;
    except
      raise Exception.Create('Error al intentar conseguir el numero de referencia.');
    end;
    if isEmpty then
    begin
      raise Exception.Create('Error al intentar conseguir el numero de referencia.');
    end;

    iNumRemesa := FieldByName('ref_cobros_e').AsInteger + 1;

    SQL.Clear;
    try
      SQL.Add(' update frf_empresas set ref_cobros_e=:nuevo  ' +
        ' where empresa_e=:empresa ');
      ParamByName('empresa').AsString := edtEmpresaRem.Text;
      ParamByName('nuevo').AsString := IntToStr(iNumRemesa);
      ExecSql;
    except
      raise Exception.Create('Error al intentar conseguir el numero de referencia.');
    end;

    if RowsAffected <> 1 then
    begin
      raise Exception.Create('Error al intentar conseguir el numero de referencia.');
    end;
  finally
    Free;
  end;
end;

procedure TFManRemesas.ActualizarRemesaCab;
begin
  if not (QRemesaCab.State in dsEditModes) then
    QRemesaCab.Edit;
  QRemesaCab.FieldByName('n_remesa_rc').AsInteger := iNumRemesa;
  QRemesaCab.Post(False);
end;

procedure TFManRemesas.ActualizarRemesaFac;
begin
  QRemesaFac.First;
  while not QRemesaFac.Eof do
  begin
    if not (QRemesaFac.State in dsEditModes) then
      QRemesaFac.Edit;
    QRemesaFac.FieldByName('n_remesa_rf').AsInteger := iNumRemesa;
    QRemesaFac.Post(False);

    QRemesaFac.Next;
  end;
end;

function TFManRemesas.EsFactura: boolean;
begin
  Result := true;

  with QFactura do
  begin
    if Active then
      Close;

    ParamByName('codfactura').asString := edtCodigoFac.Text;
    Open;

    if (FieldByName('cod_cliente_fc').AsString <> edtClienteRem.Text) or
       (isEmpty) then
        result := false
    else
    begin
      with QGrupo do
      begin
        if Active then
          Close;

        ParamByName('grupoempresa').AsString := edtEmpresaRem.Text;
        ParamByName('empresa').AsString := QFactura.FieldByName('cod_empresa_fac_fc').AsString;
        Open;
        if isEmpty then
            result := false;
      end;
    end;
  end;
end;

procedure TFManRemesas.SeleccionarFacturas;
var iPrimeraFac: integer;
begin
  sFacturas := '';
  iPrimeraFac := 0;
  QRemesaFac.First;
  while not QRemesaFac.Eof do
  begin
    if QRemesaFac.FieldByName('es_fac_comercial_rf').AsInteger = 1 then
    begin
      if iPrimeraFac <> 0 then
        sFacturas := sFacturas + ',';
      if iPrimeraFac = 0 then
        iPrimeraFac := iPrimeraFac + 1;

      sFacturas := sFacturas + QuotedStr(QRemesaFac.FieldByName('cod_factura_rf').AsString);
    end;

    QRemesaFac.Next;
  end;
end;

function TFManRemesas.GetListaFacturas: String;
var sFacturas: String;
begin
  QRemesaFac.First;
  while not QRemesaFac.Eof do
  begin
    if QRemesaFac.FieldByName('cod_factura_rf').AsString <> '' then
    begin
      if QRemesaFac.RecNo <> 1 then
        sFacturas := sFacturas + ',';
      sFacturas := sFacturas + QuotedStr(QRemesaFac.FieldbyName('cod_factura_rf').AsString);
    end;

    QRemesaFac.Next;
  end;
  Result := sFacturas;
end;

procedure TFManRemesas.DesactivarCampos;
var bExiste: boolean;
begin
//  bExiste := EjecutaQRemesaFac;
  bExiste := not(QRemesaFac.RecordCount = 0);
  edtEmpresaRem.Properties.ReadOnly := bExiste;
  ssEmpresa.Enabled := not bExiste;
  edtClienteRem.Properties.ReadOnly := bExiste;
  ssCliente.Enabled := not bExiste;
  edtMonedaRem.Properties.ReadOnly := bExiste;
  ssMoneda.Enabled := not bExiste;
end;

procedure TFManRemesas.ActivarCampos;
begin
  edtEmpresaRem.Properties.ReadOnly := false;
  ssEmpresa.Enabled := true;
  edtClienteRem.Properties.ReadOnly := false;
  ssCliente.Enabled := true;
  edtMonedaRem.Properties.ReadOnly := false;
  ssMoneda.Enabled := true;
end;

function TFManRemesas.ImporteCorrecto: boolean;
var cImpCabecera, cImpFacturas: currency;
begin
  if edtMonedaRem.Text <> 'EUR' then
    cImpCabecera := ceImporteRem.Value
  else
    cImpCabecera := ceBrutoRem.Value;

  cImpFacturas := StrToFloat(txImpFacturas.Text);

  Result := cImpCabecera = cImpFacturas;
end;

function TFManRemesas.GetGrupoEmpresa: String;
begin
  if CGlobal.gProgramVersion = CGlobal.pvSAT then
    Result := 'SAT'
  else
    Result := 'BAG';
end;

function TFManRemesas.GetEmpresa: string;
begin
  with QEmpresaRem do
  begin
    if Active then
      Close;

    ParamByName('grupoempresa').AsString := edtEmpresaRem.Text;
    Open;

    Result := fieldbyname('empresa_e').AsString;
  end;
end;

function TFManRemesas.DesClienteGrupo(AEmpresa, ACliente: string): String;
begin
  with QDesCliente do
  begin
    if Active then
      Close;

    ParamByName('cliente').AsString := ACliente;
    Open;

    Result := FieldbyName('nombre_c').AsString;
  end;
end;

(*
procedure TFManRemesas.GetCodCliente;
begin
        with QCodCliente do
        begin
          if Active then
            Close;
          //ParamByName('empresa').AsString := QRemesaFac.FieldByName('empresa_remesa_rf').AsString;
          ParamByName('codfactura').AsString := edtCodigoFac.Text;
          Open;
          cxlblCliente.Caption:= FieldByName('cod_cliente_fc').AsString;
          Close;
        end;
end;
*)

procedure TFManRemesas.GetImpPendiente;
begin
  if edtcodigoFac.Text <> '' then
    begin
      if QRemesaFac.State in dsEditModes then
      begin
        CalcCamposFac( dsQRemesaFac.DataSet );
        // Buscar Importe Cobrado por factura
        with QImpCobrado do
        begin
          if Active then
            Close;

          //ParamByName('empresa').AsString := QRemesaFac.FieldByName('empresa_remesa_rf').AsString;
          ParamByName('codfactura').AsString := edtCodigoFac.Text;
          Open;

          if FieldByName('cantidad').AsInteger <> 0  then
            rImpPendiente := ceImporteFactura.Value  - FieldByName('importe_cobrado').AsFloat
          else
            rImpPendiente := ceImporteFactura.Value;

          QRemesaFac.FieldByName('importe_cobrado_rf').AsString := FormatFloat( '#0.00', rImpPendiente);
        end;
        //GetCodCliente;
      end;
    end;
end;

procedure TFManRemesas.GetImpPendiente2;
begin
  // Buscar Importe Cobrado por factura
  with QImpCobrado2 do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := QRemesaFac.FieldByName('empresa_remesa_rf').AsString;
    ParamByName('codfactura').AsString := edtCodigoFac.Text;
    ParamByName('remesa').AsInteger := QRemesaFac.FieldByName('n_remesa_rf').AsInteger;
    Open;

    rImpPendiente := ceImporteFactura.Value - QImpCobrado2.fieldbyname('importe_cobrado').AsFloat;
  end;
end;

procedure TFManRemesas.ObtenerDatosClientes(AEmpresa, ACliente: String);
begin
  with QDatosCliente do
  begin
    if Active then
      Close;

    ParamByName('grupoempresa').AsString := AEmpresa;
    ParamByName('cliente').AsString := ACliente;
    Open;

    if not (QRemesaCab.State in dsEditModes)then
      QRemesaCab.Edit;
    QRemesaCab.Fieldbyname('cod_banco_rc').AsString := FieldbyName('banco_c').AsString;
    QRemesaCab.Fieldbyname('moneda_cobro_rc').AsString := FieldbyName('moneda_c').AsString;
  end;
end;

procedure TFManRemesas.MostrarRemesas(SQL: String);
begin
// Abrir Consulta
  if not MostrarConsulta(SQL) then
  begin
    Advertir('ATENCION! No existe remesas con el criterio seleccionado.');
    RellenarDatosIni;
    ActivarEdicion(False);
    exit;
  end;
{
  iFacturas := QRemesaFac.RecordCount;
  QRemesaFac.First;
  while not QRemesaFac.Eof do
  begin
    cImpFacturas := cImpFacturas + QRemesaFac.FieldByName('importe_cobrado_rf').AsFloat;
    QRemesaFac.Next;
  end;
  txNumFacturas.Text := IntToStr(iFacturas);
  txImpFacturas.Text := FormatFloat( '#0.00', cImpFacturas );
  CalcDiferencia;
}
  ActivarCabecera(True);
  ActivarEdicion(True);
  BtnNavegador;
  gbCabecera.Enabled := false;

end;

procedure TFManRemesas.BtnNavegador;
begin
  if (bAlta) or (bModCabecera) or (bAltaLinea) or (bModLinea) then
  begin
    dxPrimero.Enabled := false;
    dxAnterior.Enabled := false;
    dxSiguiente.Enabled := false;
    dxUltimo.Enabled := false;
  end
  else
  begin
    dxPrimero.Enabled := not (QRemesaCab.BOF) and (QRemesaCab.RecNo <> 1) and (QRemesaCab.Active);
    dxAnterior.Enabled := not (QRemesaCab.BOF) and (QRemesaCab.RecNo <> 1) and (QRemesaCab.Active);
    dxSiguiente.Enabled := not (QRemesaCab.EOF) and (QRemesaCab.RecNo <> QRemesaCab.RecordCount) and (QRemesaCab.Active);
    dxUltimo.Enabled := not (QRemesaCab.EOF) and (QRemesaCab.RecNo <> QRemesaCab.RecordCount) and (QRemesaCab.Active);
  end;
end;

(*
function TFManRemesas.GetMaxFechaFactura: TDateTime;
var dFecha: TDateTime;
begin
  dFecha := QRemesaCab.FieldByName('fecha_vencimiento_rc').AsDateTime;
  if QRemesaFac.Active then
  begin
    if QRemesaFac.RecordCount <> 0 then
    begin
      QRemesaFac.First;
      while not QRemesaFac.Eof do
      begin
        if QRemesaFac.FieldByName('fechaFactura').AsDateTime > dFecha then
          dFecha := QRemesaFac.FieldByName('fechaFactura').AsDateTime;

        QRemesaFac.Next;
      end;
    end
  end;
  Result := dFecha;
end;
*)

procedure TFManRemesas.Previsualizar;
begin
  if not EjecutaQImpRemesa then
    exit;
  try
       //Crear informe
    RRemesa := TRRemesa.Create(Application);
    RRemesa.DataSet := QImpRemesa;
    with RRemesa do
    begin
      qrNumRemesa.DataSet := QImpRemesa;
      qrFechaVto.DataSet := QImpRemesa;
      qrFechaDto.DataSet := QImpRemesa;
      qrCodCliente.DataSet := QImpRemesa;
      qrDesCliente.DataSet := QImpRemesa;
      qrCodBanco.DataSet := QImpRemesa;
      qrDesBanco.DataSet := QImpRemesa;
      qrDesMoneda.DataSet := QImpRemesa;
      qrCodFactura.DataSet := QImpRemesa;
      qrFecFactura.DataSet := QImpRemesa;
      qrNumFactura.DataSet := QImpRemesa;
      qrImpCobrado.DataSet := QImpRemesa;
      qrTotalRemesa.DataSet := QImpRemesa;
      qrTotalRemesaEur.DataSet := QImpRemesa;
      qrTotalGastosEur.DataSet := QImpRemesa;
      qrTotalLiquidoEur.DataSet := QImpRemesa;
    end;
    Preview(RRemesa);
    RRemesa := nil;
  finally
    if RRemesa <> nil then
      FreeAndNil(RRemesa);
  end;
end;

procedure TFManRemesas.FormCreate(Sender: TObject);
begin
     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfOther then
  begin
    FormType := tfOther;
    BHFormulario;
  end;

  CreaQRemesaCab;
  CreaQRemesaFac;
  CreaQImpRemesa;
  CreaQDatos;
  CreaQDatosImp;
  CreaQContRemesa;
  CreaQDelFacturas;
  CreaQFactura;
  CreaQGrupo;
  CreaQEmpresaRem;
  CreaQDesCliente;
  //CreaQCodCliente;
  CreaQImpCobrado;
  CreaQImpCobrado2;
  CreaQDatosCliente;
  CreaQFacturas;

end;

procedure TFManRemesas.FormShow(Sender: TObject);
begin
  gbCabecera.Enabled := False;
  btnAceptar.Enabled := false;
  btnCancelar.Enabled := false;
  dxAlta.Enabled := gbEscritura;
  dxRemesar.Enabled := false;
  dxBaja.Enabled := false;
  dxModificar.Enabled := false;
  dxContabilizar.Enabled := false;
  dxManFactura.Enabled := false;
  dxImprimir.Enabled := false;
  gbDetalle.Enabled := False;
  pnlAltaLineas.Visible := False;
  btnAceptarLinea.Enabled := false;
  btnCancelarLinea.Enabled := false;
  btnAltaLinea.Enabled := false;
  btnBajaLinea.Enabled := false;
  btnNavegador;
  bPrimeraLin := true;
  bRemesar := false;
  bErrorLin := false;
end;

procedure TFManRemesas.dxAltaClick(Sender: TObject);
begin
  bAlta := True;
  iFacturas := 0;
  cImpFacturas := 0;
  ActivarCabecera(True);
  ActivarEdicion(False);
  BtnNavegador;
  CreaQRemesaCabAlta;
  EjecutaQRemesaCabAlta;
  AltaCabecera;

  gbCabecera.Enabled := true;
  edtEmpresaRem.SetFocus;
end;

procedure TFManRemesas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
    begin
      if not mmxNotas.Focused then
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    end;
    $26: //vk_up
    begin
      if not mmxNotas.Focused then
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
    end;
    vk_F1:
    begin
      if btnAceptar.Enabled then btnAceptarClick(Self)
      else if btnAceptarLinea.Enabled then btnAceptarLineaClick(Self);
    end;
    vk_F2:
    begin
      if pnlAltaLineas.Visible then
        btnSelFacturaClick(Self);
    end;
    VK_ADD:
    begin
      if dxAlta.Enabled then dxAltaClick(Self)
      else if (gbDetalle.Enabled) and (btnAltaLinea.Enabled) and (not cbRemContabilizada.Checked) then btnAltaLineaClick(Self);
    end;
    VK_SUBTRACT:
    begin
      if dxBaja.Enabled then dxBajaClick(Self)
      else if (gbDetalle.Enabled) and (btnBajaLinea.Enabled) and (not cbRemContabilizada.Checked) then btnBajaLineaClick(Self);
    end;
    vk_ESCAPE:
    begin
      if btnCancelar.Enabled then btnCancelarClick(Self)
      else if btnCancelarLinea.Enabled then btnCancelarLineaClick(Self);
    end;
    //Localizar
    76, 108:
    begin
      if dxLocalizar.Enabled then dxLocalizarClick(Self);
    end;
    //Imprimir
    73,105:
    begin
      if dxImprimir.Enabled then dxImprimirClick(Self);
    end;
    VK_HOME:
    begin
      if dxPrimero.Enabled then  dxPrimeroClick(Self);
    end;
    VK_END:
    begin
      if dxUltimo.Enabled then dxUltimoClick(Self);
    end;
    VK_LEFT:
    begin
      if dxAnterior.Enabled then dxAnteriorClick(Self);
    end;
    VK_RIGHT:
    begin
      if dxSiguiente.Enabled then dxSiguienteClick(Self);
    end;
  end;
end;

procedure TFManRemesas.PonNombre(Sender: TObject);
begin
  txDesEmpresa.Text := destEmpresa(edtEmpresaRem.Text);
  if ( txDesEmpresa.Text = '' ) and ( edtEmpresaRem.Text <> '' ) then
  begin
    txDesEmpresa.Text := desEmpresa(edtEmpresaRem.Text);
  end;
  txDesCliente.Text := desClienteGrupo(edtEmpresaRem.Text, edtClienteRem.Text);
  if ( txDesCliente.Text = '' ) and ( edtClienteRem.Text <> '' ) then
  begin
    txDesCliente.Text := desCliente(edtClienteRem.Text);
  end;
  txDesBanco.Text := desBanco(edtBancoRem.Text);
  txDesMoneda.Text := desMoneda(edtMonedaRem.Text);
end;

procedure TFManRemesas.dsQRemesaCabStateChange(Sender: TObject);
begin
  btnAceptar.Enabled := (QRemesaCab.State in dsEditModes);
  btnCancelar.Enabled := (QRemesaCab.State in dsEditModes);
end;

procedure TFManRemesas.ceImporteRemPropertiesChange(Sender: TObject);
var iAux: Double;
    dAux: TDateTime;
begin
  if QRemesaCab.State in dsEditModes then
  begin
    if edtMonedaRem.Text = 'EUR' then
    begin
      QRemesaCab.FieldByName('bruto_euros_rc').AsFloat := QRemesaCab.FieldByName('importe_cobro_rc').AsFloat;
    end
    else
    begin
      if TryStrToFloat( QRemesaCab.FieldByName('importe_cobro_rc').AsString, iAux ) then
      begin
        if TryStrToDate( QRemesaCab.FieldByName('fecha_vencimiento_rc').AsString, dAux ) then
          iAux:= ChangeToEuro( QRemesaCab.FieldByName('moneda_cobro_rc').AsString,
                               QRemesaCab.FieldByName('fecha_vencimiento_rc').AsString, iAux, 2)
        else
          iAux:= 0;
      end
      else
      begin
        iAux:= 0;
      end;
      QRemesaCab.FieldByName('bruto_euros_rc').AsString:= FormatFloat( '#0.00', iAux );
    end;
    PutCambioImporte;
    CalcDiferencia;
  end;
end;

procedure TFManRemesas.ceBrutoRemPropertiesChange(Sender: TObject);
begin
  if QRemesaCab.State in dsEditModes then
  begin
    if edtMonedaRem.Text = 'EUR' then
      QRemesaCab.FieldByName('importe_cobro_rc').AsFloat := QRemesaCab.FieldByName('bruto_euros_rc').asFloat;
    PutCambioImporte;
    CalcDiferencia;
  end;
end;

procedure TFManRemesas.ceGastosRemPropertiesChange(Sender: TObject);
begin
  if QRemesaCab.State in dsEditModes then
    PutCambioImporte;
end;

procedure TFManRemesas.ceGastosRemExit(Sender: TObject);
begin
  if bCancelar then exit;
  if QRemesaCab.FieldByName('gastos_euros_rc').AsString = '' then
    QRemesaCab.FieldByName('gastos_euros_rc').AsFloat := 0;
end;

procedure TFManRemesas.ceBrutoRemExit(Sender: TObject);
begin
  ceBrutoRemPropertiesChange( ceBrutoRem );
  if bCancelar then exit;
  if QRemesaCab.FieldByName('bruto_euros_rc').AsString = '' then
//  if ceBrutoRem.Text = '' then
    ceImporteRemPropertiesChange(Self);
end;

procedure TFManRemesas.ceImporteRemExit(Sender: TObject);
begin
  ceImporteRemPropertiesChange( ceImporteRem );
  if bCancelar then exit;

  if ( QRemesaCab.FieldByName('importe_cobro_rc').AsString = '' )  then
//  if ceImporteRem.Text = '' then
    ceBrutoRemPropertiesChange(Self);
end;
{
procedure TFManRemesas.dxCancelarClick(Sender: TObject);
begin
  bCancelar := true;
  CancelarCabecera;
end;
}
{
procedure TFManRemesas.dxAceptarClick(Sender: TObject);
begin
  if not DatosCabCorrectos then exit;

  QRemesaCab.Post(False);
  EjecutaQRemesaFac;


  dxRemesar.Enabled := true;
  ActivarCampos;
  ActivarEdicion(True);
  gbCabecera.Enabled := false;
  cxDetalle.SetFocus;
  if bPrimeraLin and bAlta then
    btnAltaLineaClick(Self);

end;
}
procedure TFManRemesas.edtEmpresaRemExit(Sender: TObject);
begin
  if bCancelar then exit;

  if bAlta then
    QRemesaCab.fieldbyname('n_remesa_rc').AsString := PonRemesa(QRemesaCab.FieldbyName('empresa_remesa_rc').AsString);
end;

procedure TFManRemesas.btnAltaLineaClick(Sender: TObject);
begin
  bPrimeraLin := false;
  bAltaLinea := true;
  txNumeroFac.Text := '';
  AltaDetalle;

  pnlAltaLineas.Visible := True;
  txNumeroFac.SetFocus;
end;

procedure TFManRemesas.edtCodigoFacPropertiesChange(Sender: TObject);
begin
  if ( QRemesaFac.State = dsEdit ) or ( QRemesaFac.State = dsInsert ) then
  begin
    //cxlblCliente.Caption:= '';
    if Length(edtCodigoFac.Text) <> 15 then
    begin
      (*
      PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      //CalcCamposFac( QRemesaFac );
      //GetImpPendiente;
      *)
    end
    else
    begin
      //cxlblCliente.Caption:= '';
      edtFechaFactura.Text:= '';
      ceImporteFactura.Text:= '';
      ceImporteCobro.Text:= '';
      ceCodCliente.Text:= '';
      QRemesaFac.FieldByName('clienteFactura').AsString:= '';
      QRemesaFac.FieldByName('numeroFactura').AsString:= '';
      QRemesaFac.FieldByName('fechaFactura').AsString:= '';
      QRemesaFac.FieldByName('monedaFactura').AsString:= '';
      QRemesaFac.FieldByName('importeTotal').AsString:= '';
      QRemesaFac.FieldByName('tipoFactura').AsString := '';
      QRemesaFac.FieldByName('totalCobrado').AsFloat := 0;
    end;
  end;
end;

procedure TFManRemesas.pnlAltaLineasEnter(Sender: TObject);
begin
  cxDetalle.Enabled := false;
  if not bErrorLin then
    bRemesar := dxRemesar.Enabled;
  dxRemesar.Enabled := false;
  ActivarEdicion(False);
  BtnNavegador;
end;

procedure TFManRemesas.pnlAltaLineasExit(Sender: TObject);
begin
  cxDetalle.Enabled := True;
end;

procedure TFManRemesas.dsQRemesaFacStateChange(Sender: TObject);
begin
  btnAceptarLinea.Enabled := (QRemesaFac.State in dsEditModes);
  btnCancelarLinea.Enabled := (QRemesaFac.State in dsEditModes);
  btnAltaLinea.Enabled := not (QRemesaFac.State in dsEditModes) and gbEscritura;
  btnBajaLinea.Enabled := not (QRemesaFac.State in dsEditModes) and gbEscritura;
end;

procedure TFManRemesas.btnAceptarLineaClick(Sender: TObject);
begin
  if edtCodigoFac.Text = '' then
    exit;

  ceImporteCobroExit(Self);
  if not DatosLinCorrectos then Exit;

  ActivarEdicion(True);

  SumarFactura;
  if edtFechaFactura.Text <> '' then
    QRemesaFac.FieldByName('es_fac_comercial_rf').AsInteger := 1
  else
    QRemesaFac.FieldByName('es_fac_comercial_rf').AsInteger := 0;

  QRemesaFac.Post(False);

  bModificacion := true;
  bAltaLinea := false;
  bModLinea := false;
  bErrorLin := false;
  pnlAltaLineas.Visible := false;
  dxRemesar.Enabled := true and gbEscritura;
  dxContabilizar.Enabled := false;
  dxManFactura.Enabled := false;
  dxImprimir.Enabled := false;
  BtnNavegador;
end;

procedure TFManRemesas.dxSalirClick(Sender: TObject);
begin
  if QRemesaCab.Active then
  begin
    if dxRemesar.Enabled then
    begin
      case MessageDlg(' No se actualizarán los datos de la remesa.' + #13 + #10 +
                      ' ¿Desea salir del mantenimiento?', mtInformation, [mbNo,mbYes],0) of
      mryes:
      begin
        dxRemesar.Enabled := false;
        ActivarEdicion(False);
        ActivarCabecera(False);
        RellenarDatosIni;
        BtnNavegador;
        Exit;
      end;
      mrno:
        exit;
      end;
    end
    else
    begin
      ActivarEdicion(False);
      ActivarCabecera(False);
      tvRemesaFac.DataController.Filter.Root.Clear;
      RellenarDatosIni;
      BtnNavegador;
      Exit;
    end;
  end
  else
    Close;
end;

procedure TFManRemesas.btnCancelarLineaClick(Sender: TObject);
begin
  CancelarLinea;
end;

procedure TFManRemesas.btnBajaLineaClick(Sender: TObject);
begin
  case MessageDlg('¿Desea eliminar la linea de la Remesa?', mtInformation, [mbNo,mbYes],0) of
    mryes:
    begin
      RestarFactura;
      BorrarLinea;
      dxRemesar.Enabled := true and gbEscritura;
      ActivarEdicion(True);
      bModificacion := true;
      BtnNavegador;
      Exit;
    end;
    mrno:
      exit;
  end;
end;

procedure TFManRemesas.dxRemesarClick(Sender: TObject);
begin
  bModificacion := false;
  if ActualizarDatos then
  begin
    showmessage(' Remesa grabada correctamente. ');
    bAlta := false;
    bCancelar := false;
    dxRemesar.Enabled := false;
    ActivarEdicion(True);
    BtnNavegador;
  end;
end;

procedure TFManRemesas.dxLocalizarClick(Sender: TObject);
var Ano, Mes, Dia: Word;
    i: integer;
    StringSQL: string;
begin
  RellenarDatosIni;

  DecodeDate(Now, Ano, Mes, Dia);
  BERemesas.setValor('fecha_vencimiento_rc', '>=' + DateToStr(EncodeDate(Ano, 1, 1)));
  if BERemesas.execute = mrOk then
  begin
    i := 1;
    while i < BERemesas.SQL.Count do
    begin
      StringSQL := StringSQL + BERemesas.SQL[i] + ' ';
      inc(i);
    end;
    MostrarRemesas(StringSQL);
  end;

  // Para mostrar en una rejilla y seleccionar un registro (Mantenimiento Normal)
{
  if BERemesas.execute = mrOk then
  begin
    ReRemesas.SQL := BERemesas.SQL;
    // Pasar a la rejilla el SQL
    if ReRemesas.Execute = mrOk then
    begin
      // Coger el valor de la clave primaria
      ClaveEmpresa := ReRemesas.Dataset.Fieldbyname('empresa_remesa_rc').AsString;
      ClaveRemesa  := ReRemesas.Dataset.Fieldbyname('n_remesa_rc').AsString;
      MostrarConsulta;
    end;
  end;
}

end;

procedure TFManRemesas.dxContabilizarClick(Sender: TObject);
//var sAux: String;
begin

  if QRemesaCab.FieldByName('contabilizado_rc').AsInteger = 0 then
    ContabilizarRem
  else
    DescontabilizarRem;
end;

procedure TFManRemesas.ContabilizarRem;
var sAux: String;
begin

  if not ImporteCorrecto then
  begin
//    ShowMessage('ATENCION! No se puede contabilizar la Remesa. ' + #13 + #10 +
//                'El Importe Total de las facturas no coincide con el de la cabecera de la remesa.');
      ShowMessage('ATENCION! El Importe Total de las facturas no coincide con el de la cabecera de la remesa.');
//    exit;
  end;

  sAux := 'Se va a contabilizar la Remesa. ¿Continuar con el proceso?';

  case MessageDlg(sAux, mtInformation, [mbCancel,mbOk],0) of
  mrOk:
  begin
    if not (QRemesaCab.State in dsEditModes) then
      QRemesaCab.Edit;

    QRemesaCab.FieldByName('contabilizado_rc').AsInteger := 1;
    QRemesaCab.FieldByName('fecha_conta_rc').AsDateTime := Now;
    QRemesaCab.Post;
    ShowMessage(' Remesa Contabilizada a fecha ' + deFechaVtoRem.Text);
    ActivarEdicion(False);
    BtnNavegador;
    dxSalir.Enabled := true;
    dxManFactura.Enabled := true;
    dxContabilizar.Enabled := true and gbEnlaceContable;
    dxImprimir.Enabled := true;
  end;
  mrCancel:
  begin
    Exit;
  end;
  end;
end;

procedure TFManRemesas.DescontabilizarRem;
var sAux: String;
begin

  sAux := 'Se va a descontabilizar la Remesa. ¿Continuar con el proceso?';

  case MessageDlg(sAux, mtInformation, [mbCancel,mbOk],0) of
  mrOk:
  begin
    if not (QRemesaCab.State in dsEditModes) then
      QRemesaCab.Edit;

    QRemesaCab.FieldByName('contabilizado_rc').AsInteger := 0;
    QRemesaCab.Post;
    ShowMessage(' Remesa Descontabilizada');
    ActivarEdicion(true);
    BtnNavegador;
    {
    dxSalir.Enabled := true;
    dxManFactura.Enabled := true;
    dxContabilizar.Enabled := true;
    dxImprimir.Enabled := true;
    }
  end;
  mrCancel:
  begin
    Exit;
  end;
  end;
end;

procedure TFManRemesas.btnSelFacturaClick(Sender: TObject);
var sFacturaAnt: String;
begin
  sFacturaAnt := edtCodigoFac.Text;

  FBusFacturas:= TFBusFacturas.Create( Self );
  try
    FBusFacturas.sGrupoEmpresa := edtEmpresaRem.Text;
    FBusFacturas.sCliente := edtClienteRem.Text;
    FBusFacturas.sMoneda := edtMonedaRem.Text;
    FBusFacturas.dFechaVencimiento := deFechaVtoRem.Date;
    FBusFacturas.sLista := GetListaFacturas;
    FBusFacturas.sNumeroFac := txNumeroFac.Text;

    FBusFacturas.Showmodal;
  finally
    if not (QRemesaFac.State in dsEditModes) then
      QRemesaFac.Edit;
    if FBusFacturas.ModalResult = mrOK then
    begin
      QRemesaFac.FieldByName('cod_factura_rf').AsString := FBusFacturas.sFactura;
      txNumeroFac.Text := FBusFacturas.sNumeroFac;
      //ceImporteCobro.SetFocus;
      end
    else
    begin
      QRemesaFac.FieldByName('cod_factura_rf').AsString := sFacturaAnt;
      //txNumeroFac.SetFocus;
    end;


  FreeAndNil(FBusFacturas);
  end;
  edtCodigoFac.SetFocus;
end;

procedure TFManRemesas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  BEMensajes('');
  Action := caFree;
end;

procedure TFManRemesas.tvRemesaFacDblClick(Sender: TObject);
begin
  if (QRemesaCab.FieldByName('contabilizado_rc').AsInteger = 1) or
     (bModCabecera) or not gbEscritura then
    exit;
  pnlAltaLineas.Visible := true;
  bModLinea := true;

  QRemesaFac.Edit;
  cImporteOld := QRemesaFac.FieldByName('importe_cobrado_rf').AsFloat;
  txNumeroFac.Text := QRemesaFac.FieldByName('numeroFactura').AsString;
  GetImpPendiente2;
  ceImporteCobro.SetFocus;
  BtnNavegador;
  bRemesar := true;

  //GetCodCliente;
end;

procedure TFManRemesas.dxModificarClick(Sender: TObject);
begin
  bCancelar := false;
  bModCabecera := true;
  ActivarCabecera(True);
  bRemesar := dxRemesar.Enabled;
  dxRemesar.Enabled := false;
  ActivarEdicion(False);
  BtnNavegador;
  gbCabecera.Enabled := true;

  if not(QRemesaCab.State in dsEditModes) then
    QRemesaCab.Edit;
  if not bAlta then
    DesactivarCampos;

  edtBancoRem.SetFocus;
end;

procedure TFManRemesas.dxBajaClick(Sender: TObject);
var sMSg: string;
begin
  if cbRemContabilizada.Checked then
  begin
    ShowMessage('No se puede borrar una remesa que ya ha sido contabilizada.');
    Exit;
  end;

  sMsg:= '¿Desea borrar la remesa seleccionada?';

  if MessageDlg( sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
    begin
      Exit;
    end;

    try
      BorrarFacturas;
      QRemesaCab.Delete(False);

      QRemesaFac.ApplyUpdates(0);
      QRemesaCab.ApplyUpdates(0);

    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
    end;
    AceptarTransaccion(DMBaseDatos.DBBaseDatos);
    if QRemesaCab.RecordCount = 0 then
      dxSalirClick(Self);
  end;
end;

procedure TFManRemesas.edtCodigoFacExit(Sender: TObject);
begin
  GetImpPendiente;
end;

procedure TFManRemesas.dxManFacturaClick(Sender: TObject);
begin
  SeleccionarFacturas;
  FManFacturas := TFManFacturas.Create(Self);
  FManFacturas.MostrarFacturasExt(sFacturas);
end;

procedure TFManRemesas.ssEmpresaAntesEjecutar(Sender: TObject);
begin
  ssEmpresa.SQLAdi := ' contabilizar_emp = 1';
end;

procedure TFManRemesas.ceImporteCobroExit(Sender: TObject);
begin
{
  rImpPendiente := QRemesaFac.FieldByName('importeTotal').AsFloat -
                   QRemesaFac.FieldByName('totalCobrado').AsFloat -
                   QRemesaFac.FieldByName('importe_cobrado_rf').AsFloat;
}
end;

procedure TFManRemesas.actCancelarExecute(Sender: TObject);
begin
  if dxSalir.Enabled then
    dxSalir.Click
  else if btnCancelar.Enabled then
    btnCancelar.Click
  else if btnCancelarLinea.Enabled then
    btnCancelarLinea.Click;
end;

procedure TFManRemesas.actAceptarExecute(Sender: TObject);
begin
  if btnAceptar.Enabled then
    btnAceptar.Click
  else if btnAceptarLinea.Enabled then
    btnAceptarLinea.Click;
end;

procedure TFManRemesas.actLocalizarExecute(Sender: TObject);
begin
  if dxLocalizar.Enabled then
    dxLocalizar.Click;
end;

procedure TFManRemesas.ssBancoAntesEjecutar(Sender: TObject);
var sEmpresa: String;
begin
{
  sEmpresa := GetEmpresa;
  ssBanco.SQLAdi := ' empresa_b = ' + QuotedStr(sEmpresa);
}
end;

procedure TFManRemesas.edtClienteRemExit(Sender: TObject);
begin
  if bCancelar then exit;

  ObtenerDatosClientes(edtEmpresaRem.Text, edtClienteRem.Text);
end;

procedure TFManRemesas.btnBajaClick(Sender: TObject);
var sMSg: string;
begin
  if cbRemContabilizada.Checked then
  begin
    ShowMessage('No se puede borrar una remesa que ya ha sido contabilizada.');
    Exit;
  end;

  sMsg:= '¿Desea borrar la remesa seleccionada?';

  if MessageDlg( sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
    begin
      Exit;
    end;

    try
      BorrarFacturas;
      QRemesaCab.Delete(False);

      QRemesaFac.ApplyUpdates(0);
      QRemesaCab.ApplyUpdates(0);

    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
    end;
    AceptarTransaccion(DMBaseDatos.DBBaseDatos);
  end;
  dxSalirClick(Self);
end;

procedure TFManRemesas.btnAceptarClick(Sender: TObject);
begin
  if not DatosCabCorrectos then exit;

  QRemesaCab.Post(False);
  if not bModCabecera then
    EjecutaQRemesaFac;


  bCancelar := false;
  bModificacion := true;
  dxRemesar.Enabled := true and gbEscritura;
  dxPrimero.Enabled := true;
  dxAnterior.Enabled := true;
  dxSiguiente.Enabled := true;
  dxUltimo.Enabled := true;
  ActivarCampos;
  ActivarEdicion(True);
  gbCabecera.Enabled := false;
  cxDetalle.SetFocus;
  bModCabecera := false;
  BtnNavegador;
  if bPrimeraLin and bAlta then
    btnAltaLineaClick(Self);
end;

procedure TFManRemesas.btnCancelarClick(Sender: TObject);
begin
  CancelarCabecera;
end;
{
procedure TFManRemesas.btModificarClick(Sender: TObject);
begin
  ActivarCabecera(True);
  BtnNavegador;
  bRemesar := dxRemesar.Enabled;
  dxRemesar.Enabled := false;
  ActivarEdicion(False);
  gbCabecera.Enabled := true;

  if not(QRemesaCab.State in dsEditModes) then
    QRemesaCab.Edit;
  if not bAlta then
    DesactivarCampos;
  edtBancoRem.SetFocus;
end;
}
procedure TFManRemesas.dxSiguienteClick(Sender: TObject);
begin
    if bModificacion then
  begin
    ShowMEssage(' ATENCION! Si no valida la Remesa, perderá los cambios.');
    exit;
  end;
  QRemesaCab.Next;
end;

procedure TFManRemesas.dxUltimoClick(Sender: TObject);
begin
    if bModificacion then
  begin
    ShowMEssage(' ATENCION! Si no valida la Remesa, perderá los cambios.');
    exit;
  end;
  QRemesaCab.Last;
end;

procedure TFManRemesas.dxAnteriorClick(Sender: TObject);
begin
  if bModificacion then
  begin
    ShowMEssage(' ATENCION! Si no valida la Remesa, perderá los cambios.');
    exit;
  end;
  QRemesaCab.Prior;
end;

procedure TFManRemesas.dxPrimeroClick(Sender: TObject);
begin
  if bModificacion then
  begin
    ShowMEssage(' ATENCION! Si no valida la Remesa, perderá los cambios.');
    exit;
  end;
  QRemesaCab.First;
end;

procedure TFManRemesas.dsQRemesaCabDataChange(Sender: TObject;
  Field: TField);
begin
  BtnNavegador;
  if not bModCabecera then
    ActivarEdicion(True);
  if (not bAlta) and (not bModificacion) then
  begin
    if EjecutaQRemesaFac then QRemesaFac.First;

    iFacturas := QRemesaFac.RecordCount;
    cImpFacturas := 0;
    QRemesaFac.First;
    while not QRemesaFac.Eof do
    begin
      cImpFacturas := cImpFacturas + QRemesaFac.FieldByName('importe_cobrado_rf').AsFloat;
      QRemesaFac.Next;
    end;
    txNumFacturas.Text := IntToStr(iFacturas);
    txImpFacturas.Text := FormatFloat( '#0.00', cImpFacturas );
    CalcDiferencia;
  end;
end;

procedure TFManRemesas.txNumeroFacExit(Sender: TObject);
begin
  if (not bAltaLinea) and (not bModLinea) then exit;
  if txNumeroFac.Text <> '' then
  begin
    EjecutaQFacturas;
    if QFacturas.RecordCount = 0 then
    begin
      if not (QRemesaFac.State in dsEditModes) then
        QRemesaFac.Edit;
      ShowMessage(' ATENCION! No existen facturas en gestión comercial con el criterio seleccionado.');
      exit;
    end
    else if QFacturas.RecordCount = 1 then
    begin
      if not (QRemesaFac.State in dsEditModes) then
        QRemesaFac.Edit;
      QRemesaFac.FieldByName('cod_factura_rf').AsString := QFacturas.FieldbyName('cod_factura_fc').AsString;
      edtCodigoFac.SetFocus;
    end
    else
    begin
      btnSelFacturaClick(Self);
    end;
  end
  else
  begin
      if not (QRemesaFac.State in dsEditModes) then
        QRemesaFac.Edit;
      QRemesaFac.FieldByName('cod_factura_rf').AsString := '';
      edtFechaFactura.Text := '';
      //cxlblCliente.Caption:= '';
      ceImporteFactura.Text := '';
      QRemesaFac.FieldByName('importe_cobrado_rf').AsString := '';
      ceCodCliente.Text := '';
      QRemesaFac.FieldByName('clientefactura').AsString := '';
  end;
end;

procedure TFManRemesas.dxImprimirClick(Sender: TObject);
begin
  Previsualizar;
end;

procedure TFManRemesas.deFechaVtoRemPropertiesChange(Sender: TObject);
begin
  deFechaDesRem.Text:= deFechaVtoRem.Text;
end;

end.
