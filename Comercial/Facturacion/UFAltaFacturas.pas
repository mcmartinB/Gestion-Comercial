unit UFAltaFacturas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit,
  Menus,   UDFactura, DError,
  dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, DB, cxDBData, cxTextEdit, cxCurrencyEdit,
  dxBar, cxClasses, cxMemo, cxPC, cxDropDownEdit,
  ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, dxStatusBar, cxCheckBox,
  cxGroupBox, cxRadioGroup, cxDBEdit, cxMaskEdit, cxCalendar, StdCtrls,
  cxButtons, SimpleSearch, cxLabel, BonnyClientDataSet, BonnyQuery,

  dxSkinsCore, dxSkinsdxStatusBarPainter, dxSkinscxPCPainter,
  dxSkinsdxBarPainter, dxSkinBlue,  dxSkinFoggy, dxSkinMoneyTwins,
  dxSkinBlueprint, dxSkinBlack, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue;


type

  TFAltaFacturas = class(TForm)
    gbCabecera: TcxGroupBox;
    lbEmpresa: TcxLabel;
    txDesEmpresa: TcxTextEdit;
    lbFechaFactura: TcxLabel;
    lbNumeroFactura: TcxLabel;
    lbCliente: TcxLabel;
    txDesCliente: TcxTextEdit;
    lb3: TcxLabel;
    txDesImpuesto: TcxTextEdit;
    lb4: TcxLabel;
    txDesMoneda: TcxTextEdit;
    bmxBarManager: TdxBarManager;
    bmPrincipal: TdxBar;
    btnAceptar: TdxBarButton;
    btnCancelar: TdxBarButton;
    stStatusBar: TdxStatusBar;
    dsCabFactura: TDataSource;
    dsDetFactura: TDataSource;
    lb10: TcxLabel;
    btnSalir: TdxBarButton;
    btnGrabarFactura: TdxBarButton;
    bbxAltaLinea: TdxBarButton;
    bbxCancelarLinea: TdxBarButton;
    bbxAceptarLinea: TdxBarButton;
    bbxBajaLinea: TdxBarButton;
    edtEmpresa: TcxDBTextEdit;
    gbDetalle: TcxGroupBox;
    cxPageControl: TcxPageControl;
    tsDetalleFactura: TcxTabSheet;
    cxDetalle: TcxGrid;
    tvLineasFactura: TcxGridDBTableView;
    tvEmpresaAlb: TcxGridDBColumn;
    tvCenSalida: TcxGridDBColumn;
    tvAlbaran: TcxGridDBColumn;
    tvFecAlbaran: TcxGridDBColumn;
    tvProducto: TcxGridDBColumn;
    tvEnvase: TcxGridDBColumn;
    tvCategoria: TcxGridDBColumn;
    tvUnidades: TcxGridDBColumn;
    tvCajas: TcxGridDBColumn;
    tvKilos: TcxGridDBColumn;
    tvPrecio: TcxGridDBColumn;
    tvUnidad: TcxGridDBColumn;
    tvImporte: TcxGridDBColumn;
    tvImporteDes: TcxGridDBColumn;
    tvImporteNeto: TcxGridDBColumn;
    tvImpuesto: TcxGridDBColumn;
    tvImporteImpuesto: TcxGridDBColumn;
    tvImporteTotal: TcxGridDBColumn;
    lvLineasFactura: TcxGridLevel;
    pnlAltaLineas: TPanel;
    lb1: TcxLabel;
    edtCenSalida: TcxDBTextEdit;
    txDesCentro: TcxTextEdit;
    lb2: TcxLabel;
    edtNumAlbaran: TcxDBTextEdit;
    lb5: TcxLabel;
    deFechaAlbaran: TcxDBDateEdit;
    lb6: TcxLabel;
    edtProducto: TcxDBTextEdit;
    txDesProducto: TcxTextEdit;
    lb7: TcxLabel;
    edtEnvase: TcxDBTextEdit;
    txDesEnvase: TcxTextEdit;
    lb8: TcxLabel;
    edtCategoria: TcxDBTextEdit;
    txDesCategoria: TcxTextEdit;
    lb9: TcxLabel;
    edtEmpAlbaran: TcxDBTextEdit;
    txDesEmpAlbaran: TcxTextEdit;
    cxGroupBox1: TcxGroupBox;
    lb11: TcxLabel;
    cbxTipoUnidad: TcxComboBox;
    lb12: TcxLabel;
    ceUnidades: TcxCurrencyEdit;
    lb13: TcxLabel;
    ceImporte: TcxCurrencyEdit;
    lb14: TcxLabel;
    cxTabControl1: TcxTabControl;
    btnAltaLinea: TcxButton;
    btnBajaLinea: TcxButton;
    btnAceptarLinea: TcxButton;
    btnCancelarLinea: TcxButton;
    tsTextoFactura: TcxTabSheet;
    edtCliente: TcxDBTextEdit;
    edtMoneda: TcxDBTextEdit;
    edtImpuesto: TcxDBTextEdit;
    deFechaFactura: TcxDBDateEdit;
    dePrevisionCobro: TcxDBDateEdit;
    edtNumeroFactura: TcxDBTextEdit;
    rgTipoFactura: TcxDBRadioGroup;
    gbPerdidas: TcxGroupBox;
    cbFacturasPerdidas: TcxCheckBox;
    lb15: TcxLabel;
    txFactura: TcxTextEdit;
    mmxNotas: TcxMemo;
    ssEmpresa: TSimpleSearch;
    ssCliente: TSimpleSearch;
    ssMoneda: TSimpleSearch;
    ssImpuesto: TSimpleSearch;
    ssEmpAlbaran: TSimpleSearch;
    ssCenSalida: TSimpleSearch;
    ssProducto: TSimpleSearch;
    ssEnvase: TSimpleSearch;
    ssCategoria: TSimpleSearch;
    cxlbl1: TcxLabel;
    dePrevisionTeso: TcxDBDateEdit;
    cxlbl2: TcxLabel;
    deFechaFacIni: TcxDBDateEdit;
    cxlbl3: TcxLabel;
    edtNumFacIni: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    edtSerie: TcxDBTextEdit;
    ssSerie: TSimpleSearch;
    cbNumRegistroAcuerdo: TcxDBCheckBox;
    cxLabel2: TcxLabel;
    ceKilos: TcxCurrencyEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    ceUndCaja: TcxCurrencyEdit;
    ceCajas: TcxCurrencyEdit;
    cxLabel5: TcxLabel;
    ceUndFac: TcxTextEdit;
    cePrecio: TcxCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtEmpAlbaranPropertiesChange(Sender: TObject);
    procedure edtCenSalidaPropertiesChange(Sender: TObject);
    procedure edtProductoPropertiesChange(Sender: TObject);
    procedure edtCategoriaPropertiesChange(Sender: TObject);
    procedure edtEnvasePropertiesChange(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure deFechaFacturaPropertiesChange(Sender: TObject);
    procedure dsDetFacturaStateChange(Sender: TObject);
    procedure cePrecioPropertiesChange(Sender: TObject);
    procedure cbxTipoUnidadPropertiesChange(Sender: TObject);
    procedure btnGrabarFacturaClick(Sender: TObject);
    procedure tvLineasFacturaDblClick(Sender: TObject);
    procedure btnAltaLineaClick(Sender: TObject);
    procedure btnBajaLineaClick(Sender: TObject);
    procedure btnAceptarLineaClick(Sender: TObject);
    procedure btnCancelarLineaClick(Sender: TObject);
    procedure edtEmpresaPropertiesChange(Sender: TObject);
    procedure dsDetFacturaDataChange(Sender: TObject; Field: TField);
    procedure dsCabFacturaStateChange(Sender: TObject);
    procedure edtClientePropertiesChange(Sender: TObject);
    procedure edtMonedaPropertiesChange(Sender: TObject);
    procedure edtImpuestoPropertiesChange(Sender: TObject);
    procedure rgTipoFacPropertiesChange(Sender: TObject);
    procedure cxPageControlEnter(Sender: TObject);
    procedure cbFacturasPerdidasClick(Sender: TObject);
    procedure pnlAltaLineasEnter(Sender: TObject);
    procedure pnlAltaLineasExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ssCenSalidaAntesEjecutar(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure ssCategoriaAntesEjecutar(Sender: TObject);
    procedure ssProductoAntesEjecutar(Sender: TObject);
    procedure edtEnvaseExit(Sender: TObject);
    procedure ssSerieAntesEjecutar(Sender: TObject);
    procedure ceCajasPropertiesChange(Sender: TObject);
    procedure ceKilosPropertiesChange(Sender: TObject);
    procedure ceUndCajaPropertiesChange(Sender: TObject);
    procedure ceUnidadesPropertiesChange(Sender: TObject);
    procedure ceUndFacPropertiesChange(Sender: TObject);
    procedure cePrecioChange(Sender: TObject);

  private
    QCabFactura, QDetFactura, QBasFactura: TBonnyClientDataSet;
    QDatosInco, QDatosAlb, QAlbaran, QLineasAlb, QCabeceraAlb: TBonnyQuery;
    sTipoFactura: string;

    bPrimeraLin, bFactPerdida: boolean;
    bFacturaModificada: boolean;
    bPesoVariableLinea, bEnvaseVariableLinea, bFlagCambios: Boolean;
    sUnidadPrecioLinea: string;
    rPesoCaja, rImpuestoLinea: real;


    function DatosCabCorrectos: boolean;
    function DatosLinCorrectos: boolean;
    function ComprobarConstraint: Boolean;
    procedure CancelarProceso;
    procedure CreaQueryCab;
    procedure CreaQueryDet;
    procedure CreaQueryBas;
    procedure CreaQDatosInco;
    procedure CreaQDatosAlb;
    procedure CreaQAlbaran;
    procedure CreaQLineasAlb;
    procedure CreaQCabeceraAlb;
    function EjecutaQueryCab: Boolean;
    function EjecutaQueryDet: Boolean;
    function EjecutaQueryBas: Boolean;
    procedure AltaCabFactura;
    procedure AltaDetFactura;
    procedure AltaBasFactura(ARImpBases: TRImpBases);
    function ExisteAlbaran: Boolean;
    function ExisteLinAlbaran: Boolean;
    function DistintaCabecera: Boolean;
    function DesUnidad(const AUnidad: Integer): String;
    procedure ConfigurarUnidades;
    procedure ActualizarDatos;
    procedure ActualizarFechaCobro( const AFactura: string );
    function GetClaveFactura: integer;
    procedure CalcularTotales;
    procedure MostrarImpuesto;
    procedure ActivarCabecera(AActivar: Boolean);
    procedure ActivarPanelCabecera(AActivar: Boolean);
    procedure BorrarLinea;
    procedure AsignarNumLinea;
    procedure ActualizarNotasFactura;
    procedure BorrarBases;
    procedure RellenarDatosIni;
    function CanFacturarFecha(AEmpresa, ADate, ASerie: string): Boolean;
    function UnidadFacturacion: String;
    procedure CambioEnvase;
    procedure RecalcularUnidades(const ASender: TObject; const AImporte: boolean = false);
    


  public
    sClave: string;
    bAlta: boolean;
  end;

var
  FAltaFacturas: TFAltaFacturas;

implementation

uses CVariables, CGestionPrincipal, UDMCambioMoneda, bMath,
  UDMBaseDatos, CAuxiliarDB, CFactura, UDMAuxDB, bTextUtils;

{$R *.dfm}

var
  Impuesto: TImpuestos;

procedure TFAltaFacturas.FormCreate(Sender: TObject);
begin
     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfOther then
  begin
    FormType := tfOther;
    BHFormulario;
  end;
  CreaQueryCab;
  CreaQueryDet;
  CreaQueryBas;
  CreaQDatosInco;
  CreaQDatosAlb;
  CreaQAlbaran;
  CreaQLineasAlb;
  CreaQCabeceraAlb;
end;

procedure TFAltaFacturas.FormShow(Sender: TObject);
begin
  RellenarDatosIni;

  EjecutaQueryCab;
  EjecutaQueryDet;

  if bAlta then
  begin
    //ActivarCabecera(true);
    ActivarPanelCabecera(True);

    QCabFactura.Append;
    QCabFactura.fieldbyname('cod_empresa_fac_fc').AsString := gsDefEmpresa;
    QCabFactura.fieldbyname('tipo_factura_fc').AsString := '380';
    QCabFactura.fieldbyname('fecha_factura_fc').AsDateTime := Date;
    QCabFactura.fieldbyname('cod_serie_fac_fc').AsString := gsDefEmpresa;
    QCabFactura.fieldbyname('es_reg_acuerdo_fc').AsInteger := 0;

    edtcliente.SetFocus;
  end
  else
  begin
    //ActivarCabecera(false);
    ActivarPanelCabecera(False);

    mmxNotas.Text := QCabFactura.FieldByName('notas_fc').AsString;

    cxDetalle.SetFocus;
  end;

  lbNumeroFactura.Visible := not bAlta;
  edtNumeroFactura.Visible := not bAlta;
  gbPerdidas.Visible := bAlta;

  rgTipoFactura.Properties.ReadOnly := not bAlta;

end;

procedure TFAltaFacturas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  case key of
    VK_F1:
    begin
      if btnAceptar.Enabled then btnAceptarClick(Self)
      else if btnAceptarLinea.Enabled then btnAceptarLineaClick(Self)
      else btnGrabarFacturaClick(Self);
    end;
    VK_ESCAPE:
    begin
      if btnCancelar.Enabled then btnCancelarClick(Self)
      else btnCancelarLineaClick(Self);
    end;
    VK_ADD:
    begin
      if btnAltaLinea.Enabled then btnAltaLineaClick(Self);
    end;
    VK_SUBTRACT:
    begin
      if btnBajaLinea.Enabled then btnBajaLineaClick(Self);
    end;
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
  end;


end;

procedure TFAltaFacturas.btnAceptarClick(Sender: TObject);
begin
  bFactPerdida:= cbFacturasPerdidas.Checked;
  if not DatosCabCorrectos then exit;

  if not CanFacturarFecha(edtEmpresa.Text, deFechaFactura.Text, edtSerie.Text) then
    Exit;

  //ActivarCabecera(False);
  ActivarPanelCabecera(False);

  QCabFactura.fieldbyname('cod_factura_fc').AsString := sClave;
  QCabFactura.Post(False);
  EjecutaQueryCab;
  EjecutaQueryDet;
  cxDetalle.SetFocus;
  if bPrimeraLin and bAlta then
    btnAltaLineaClick(Self);
end;

function TFAltaFacturas.DatosCabCorrectos: boolean;
var dFecha: TDateTime;
begin
  Result := false;
    //Empresa
  if txDesEmpresa.Text = '' then
  begin
    ShowMessage( 'El c�digo de la empresa a facturar es incorrecto.');
    edtEmpresa.SetFocus;
    exit;
  end;

  //comprobar que existe la serie
  if not ExisteSerie(edtEmpresa.Text, edtSerie.Text, deFechaFactura.Text) then
  begin
    ShowError('No existe la serie de facturaci�n indicada.');
    edtSerie.SetFocus;
    Exit;
  end;

    //Cliente
  if txDesCliente.Text = '' then
  begin
    ShowMessage( 'El c�digo del cliente a facturar es incorrecto.');
    edtcliente.SetFocus;
    exit;
  end;
    //Impuesto
  if txDesImpuesto.Text = '' then
  begin
    ShowMessage( 'El c�digo del impuesto a facturar es incorrecto.');
    edtimpuesto.SetFocus;
    exit;
  end;
    //Moneda
  if txDesMoneda.Text = '' then
  begin
    ShowMessage( 'El c�digo de la moneda a facturar es incorrecto.');
    edtmoneda.SetFocus;
    exit;
  end;
    // Fecha Cambio
  if TryStrToDate( deFechaFactura.Text, dFecha) then
  begin
    if not ChangeExist( edtmoneda.Text, deFechaFactura.Text ) then
    begin
      ShowMessage('El cambio del dia no esta grabado.');
      deFechaFactura.SetFocus;
      exit;
    end;
  end
  else
  begin
    ShowMessage('La fecha de factura es incorrecta');
    deFechaFactura.SetFocus;
    exit;
  end;

        // Comprobar contador facturas perdidas
  if (bFactPerdida) and (trim(txFactura.Text) = '') then
  begin
    ShowMessage('Al activar contador de Facturas Perdidas, se debe indicar un N�mero de Factura');
    txFactura.SetFocus;
    Exit;
  end;

  Result := true;
end;

procedure TFAltaFacturas.btnCancelarClick(Sender: TObject);
begin
  CancelarProceso;
end;

procedure TFAltaFacturas.CancelarProceso;
begin
  if QDetFactura.State in dsEditModes then
  begin
    case MessageDlg('�Desea guardar la linea de la Factura?', mtInformation, [mbNo,mbYes,mbCancel ],0) of
      mryes:
      begin
        btnAceptarLineaClick(self);
        Exit;
      end;
      mrno:
      begin
        QDetFactura.Cancel;
        pnlAltaLineas.Visible := false;                               
        if QDetFactura.RecordCount > 0 then
        begin
          //ActivarCabecera(False);
          ActivarPanelCabecera(False);
          cxPageControl.ActivePage := tsDetalleFactura;
          cxDetalle.SetFocus;
        end
        else
        begin
        //ActivarCabecera(True);
        ActivarPanelCabecera(True);
        QCabFactura.Edit;
        edtEmpresa.SetFocus;
        end;
        stStatusBar.SimplePanelStyle.Text := 'Cambios Ignorados en Linea de Factura';
      end;
      mrcancel:
      begin
        exit;
      end;
    end;
  end
  else if (QCabFactura.State in dsEditModes) and (btnAceptar.Enabled) then
  begin
    case MessageDlg('�Desea guardar la Cabecera de Factura?', mtInformation, [mbNo,mbYes,mbCancel ],0) of
      mryes:
      begin
        btnAceptarClick(self);
        Exit;
      end;
      mrno:
      begin
        btnSalirClick(Self);
      end;
      mrcancel:
      begin
        exit;
      end;
    end;
  end
  else btnSalirClick(Self);
end;

procedure TFAltaFacturas.CreaQueryCab;
begin
  QCabFactura:=TBonnyClientDataSet.Create(self);
  dsCabFactura.Dataset:=QCabFactura;
  with QCabFactura do
  begin
    SQL.Add(' select * from tfacturas_cab       ');
    SQL.Add('  where cod_factura_fc = :MICODFAC ');

    ParamByName('MICODFAC').DataType := ftString;
  end;
//  QCabFactura.Query.CrearCampos;
//  QCabFactura.Query.FieldByName('cod_factura_fc').ProviderFlags := QCabFactura.Query.FieldByName('cod_factura_fc').ProviderFlags + [pfInKey];
end;

function TFAltaFacturas.EjecutaQueryCab: Boolean;
begin
  with QCabFactura do
  begin
    ParamByName('MICODFAC').AsString := sClave;

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TFAltaFacturas.AltaCabFactura;
var RDatosClienteFac: TRDatosClienteFac;
    sIncoterm, sPlazaIncoterm: String;
begin
    //Obtener Datos Albaran
  with QDatosInco do
  begin
    if Active then
      Close;

    ParamByName('MIEMP').AsString := edtEmpAlbaran.Text;
    ParamByName('MICEN').AsString := edtCenSalida.Text;
    ParamByName('MIALB').AsString := edtNumAlbaran.Text;
    ParamByName('MIFEC').AsDateTime := deFechaAlbaran.Date;

    Open;

    sIncoterm := QDatosInco.fieldbyname('incoterm_sc').AsString;
    sPlazaIncoterm := QDatosInco.fieldbyname('plaza_incoterm_sc').AsString;
  end;

  with QCabFactura do
  begin
    RDatosClienteFac := GetDatosCliente(edtEmpresa.Text, edtcliente.Text, '');

    Edit;

    FieldByName('impuesto_fc').AsString := Copy(edtimpuesto.Text,1,1);
    FieldByName('automatica_fc').AsInteger := 0;                // Manual
    FieldByName('anulacion_fc').AsInteger := 0;                 // Valida
    FieldByName('des_cliente_fc').AsString := RDatosclienteFac.sDesCliente;
    FieldByName('cta_cliente_fc').AsString := RDatosclienteFac.sCtaCliente;
    FieldByName('nif_fc').AsString := RDatosclienteFac.sNIFCliente;
    FieldByName('tipo_via_fc').AsString := RDatosClienteFac.sTipoVia;
    FieldByName('domicilio_fc').AsString := RDatosClienteFac.sDomicilio;
    FieldByName('poblacion_fc').AsString := RDatosClienteFac.sPoblacion;
    FieldByName('cod_postal_fc').AsString := RDatosClienteFac.sCodPostal;
    if RDatosClienteFac.sCodPais = 'ES' then
      FieldByName('provincia_fc').AsString := RDatosClienteFac.sProvincia
    else
      FieldByName('provincia_fc').AsString := '';
    FieldByName('cod_pais_fc').AsString := RDatosClienteFac.sCodPais;
    FieldByName('des_pais_fc').AsString := RDatosClienteFac.sDesPais;
    FieldByName('notas_fc').AsString := mmxNotas.Text;
    FieldByName('incoterm_fc').AsString := sIncoterm;
    FieldByName('plaza_incoterm_fc').AsString := sPlazaIncoterm;
    FieldByName('forma_pago_fc').AsString := RDatosClienteFac.sFormaPago;
    FieldByName('des_forma_pago_fc').AsString := desFormaPagoEx(RDatosClienteFac.sFormaPago);
    FieldByName('des_tipo_impuesto_fc').AsString := DesImpuesto(edtimpuesto.Text);
    FieldByName('contabilizado_fc').AsInteger := 0;
    FieldByName('fecha_conta_fc').AsString := '';
    FieldByName('filename_conta_fc').AsString := '';

    Post(False);
  end;
end;

procedure TFAltaFacturas.AltaDetFactura;
var sCodCliente, sDirsum, sPedido, sFechaPedido, sVehiculo, sCalibre, sMarca, sRepresentante,
    sEmpProcedencia, sCentroOrigen, sCodComercial: string;
    iTasaImpuesto: Integer;
    rComision, rDescuento, rEurosKg, rImpComision, rImpDescuento1, rImpEurosKg, rImpuesto: real;
    sCodFactOrigen: string;
begin
  bPrimeraLin := false;

  with QDatosAlb do
  begin
    if Active then
      Close;

    ParamByName('MIEMP').AsString := edtEmpAlbaran.Text;
    ParamByName('MICEN').AsString := edtCenSalida.Text;
    ParamByName('MIALB').AsString := edtNumAlbaran.Text;
    ParamByName('MIFEC').AsDateTime := deFechaAlbaran.Date;
    ParamByName('MIPROD').AsString := edtProducto.Text;
    ParamByName('MIENV').AsString := edtEnvase.Text;
    ParamByName('MICAT').AsString := edtCategoria.Text;

    Open;

    sCodCliente := QDatosAlb.fieldbyname('cliente_sal_sc').AsString;
    sDirSum := QDatosAlb.fieldbyname('dir_sum_sc').AsString;
    sPedido := QDatosAlb.fieldbyname('n_pedido_sc').AsString;
    sFechaPedido := QDatosAlb.fieldbyname('fecha_pedido_sc').AsString;
    sVehiculo := QDatosAlb.fieldbyname('vehiculo_sc').AsString;
    sCalibre := QDatosAlb.fieldbyname('calibre_sl').AsString;
    sMarca := QDatosAlb.fieldbyname('marca_sl').AsString;
    sRepresentante := QDatosAlb.fieldbyname('representante_c').AsString;
    iTasaImpuesto := QDatosAlb.fieldbyname('tipo_iva_e').AsInteger;
    sEmpProcedencia := QDatosAlb.fieldbyname('emp_procedencia_sl').AsString;
    sCentroOrigen := QDatosAlb.fieldbyname('centro_origen_sl').AsString;
    sCodFactOrigen := QDatosAlb.Fieldbyname('cod_factura_fc').AsString;
    if ( sCodFactOrigen <> '' ) and ( sTipoFactura = '381'  ) then
      ActualizarFechaCobro( sCodFactOrigen );
    sCodComercial := QDatosAlb.FieldByName('comercial_sl').AsString;
  end;

  with QDetFactura do
  begin
    if not bAlta then
      fieldByname('cod_factura_fd').AsString := sClave;

    FieldByName('cod_cliente_albaran_fd').asString := sCodCliente;
    FieldByName('cod_dir_sum_fd').AsString := sDirsum;
    FieldByName('pedido_fd').AsString := sPedido;
    FieldByName('fecha_pedido_fd').AsString := sFechaPedido;
    FieldByName('matricula_fd').AsString := sVehiculo;
    FieldByName('emp_procedencia_fd').AsString := sEmpProcedencia;
    FieldByName('centro_origen_fd').AsString := sCentroOrigen;
    if sTipoFactura = '381' then
      FieldByName('cod_factura_origen_fd').AsString := sCodFactOrigen
    else
      FieldByName('cod_factura_origen_fd').AsString := '';
    FieldByName('des_producto_fd').AsString := txDesProducto.Text;
    FieldByName('cod_envase_fd').AsString := edtEnvase.Text;
    FieldByName('des_envase_fd').AsString := txDesEnvase.Text;
    FieldByName('calibre_fd').AsString := sCalibre;
    FieldByName('marca_fd').AsString := sMarca;
    FieldByName('nom_marca_fd').AsString := desMarca(sMarca);

    if cbxTipoUnidad.ItemIndex = 0 then
    begin
      FieldByName('unidades_fd').AsString := '';
      FieldByName('cajas_fd').AsString := '';
      FieldByName('kilos_fd').AsString := '';
      FieldByName('unidades_caja_fd').AsString := '';
    end
    else if cbxTipoUnidad.ItemIndex = 1 then
    begin
      FieldByName('unidades_fd').AsFloat := ceUnidades.value;
      FieldByName('cajas_fd').AsString := '';
      FieldByName('kilos_fd').AsString := '';
    end
    else if cbxTipoUnidad.ItemIndex = 2 then
    begin
      FieldByName('cajas_fd').AsFloat := ceCajas.value;
      FieldByName('unidades_fd').AsString := '';
      FieldByName('kilos_fd').AsString := '';
    end
    else if cbxTipoUnidad.ItemIndex = 3 then
    begin
      FieldByName('kilos_fd').AsFloat := ceKilos.Value;
      FieldByName('unidades_fd').AsString := '';
      FieldByName('cajas_fd').AsString := '';
    end
    else if cbxTipoUnidad.ItemIndex = 4 then
    begin
      FieldByName('kilos_fd').AsFloat := ceKilos.Value;
      FieldByName('unidades_fd').AsFloat := ceUnidades.Value;
      FieldByName('unidades_caja_fd').AsFloat := ceUndCaja.Value;
      FieldByName('cajas_fd').AsFloat := ceCajas.Value;
    end;

    FieldByName('kilos_posei_fd').AsFloat := 0;
//      FieldByName('unidades_caja_fd').AsInteger := 1;
//      FieldByName('unidades_fd').AsString := ceUnidades.Text;

//    FieldByName('unidad_facturacion_fd').AsString := DesUnidad(cbxTipoUnidad.ItemIndex);
    FieldByName('unidad_facturacion_fd').AsString := ceUndFac.Text;
    if cbxTipoUnidad.ItemIndex = 0 then
      FieldByName('precio_fd').AsString := ''
    else
      FieldByName('precio_fd').AsFloat := StrToFloat(cePrecio.Text);
    FieldByName('importe_linea_fd').AsFloat := ceImporte.Value;
    FieldByName('cod_representante_fd').AsString := sRepresentante;

    rComision := GetPorcentajeComision(FieldByName('cod_representante_fd').AsString,
                                       QCabFactura.fieldbyname('fecha_factura_fc').AsDateTime);
    rDescuento:= GetPorcentajeDescuento(FieldByName('cod_empresa_albaran_fd').AsString,
                                        FieldByName('cod_cliente_albaran_fd').asString,
                                        FieldByName('cod_centro_albaran_fd').asString,
                                        FieldByName('cod_producto_fd').AsString,
                                        QCabFactura.fieldbyname('fecha_factura_fc').AsDateTime);
    rEurosKg:= GetEurosKg(FieldByName('cod_empresa_albaran_fd').AsString,
                          FieldByName('cod_cliente_albaran_fd').asString,
                          FieldByName('cod_centro_albaran_fd').asString,
                          FieldByName('cod_producto_fd').AsString,
                          QCabFactura.fieldbyname('fecha_factura_fc').AsDateTime);
    rImpComision := bRoundTo(FieldByName('importe_linea_fd').AsFloat * rComision/100, 2);
    rImpDescuento1:= bRoundTo((FieldByName('importe_linea_fd').AsFloat - rImpComision) * rDescuento/100, 2);
    rImpEurosKg := bRoundTo(FieldByName('kilos_fd').AsFloat * rEurosKg, 2);

    FieldByName('porcentaje_comision_fd').AsFloat := rComision;
    FieldByName('porcentaje_descuento_fd').AsFloat := rDescuento;
    FieldByName('euroskg_fd').AsFloat := rEurosKg;
    FieldByName('importe_comision_fd').AsFloat := rImpComision;
    FieldByName('importe_descuento_fd').AsFloat := rImpDescuento1;
    FieldByName('importe_euroskg_fd').AsFloat := rImpEurosKg;
    FieldByName('importe_total_descuento_fd').AsFloat := FieldByName('importe_comision_fd').AsFloat +
                                                         FieldByName('importe_descuento_fd').AsFloat +
                                                         FieldByName('importe_euroskg_fd').AsFloat;
    FieldByName('importe_neto_fd').AsFloat := FieldByName('importe_linea_fd').AsFloat -
                                              FieldByName('importe_total_descuento_fd').AsFloat;
    FieldByName('tasa_impuesto_fd').AsInteger := iTasaImpuesto;
    MostrarImpuesto;
    case TipoIVAEnvase( FieldByName('cod_empresa_albaran_fd').AsString,
                                FieldByName('cod_envase_fd').AsString,
                                FieldByName('cod_producto_fd').AsString ) of
      1: rImpuesto:= impuesto.rReducido;
      2: rImpuesto:= impuesto.rGeneral;
      else
        rImpuesto:= impuesto.rSuper;
    end;
    FieldByName('porcentaje_impuesto_fd').AsFloat := rImpuesto;
    FieldByName('importe_impuesto_fd').AsFloat := bRoundTo(FieldByName('importe_neto_fd').AsFloat * rImpuesto/100, 2);
    FieldByName('importe_total_fd').AsFloat := FieldByName('importe_neto_fd').AsFloat +
                                               FieldByName('importe_impuesto_fd').AsFloat;
    FieldByName('cod_comercial_fd').AsString := sCodComercial;

    Post(False);
  end;

end;

procedure TFAltaFacturas.CreaQueryDet;
begin
  QDetFactura:=TBonnyClientDataSet.Create(self);
  dsDetFactura.Dataset:=QDetFactura;
  with QDetFactura do
  begin
    SQL.Add(' select * from tfacturas_det       ');
    SQL.Add('  where cod_factura_fd = :MICODFAC ');

    ParamByName('MICODFAC').DataType := ftString;
  end;
end;

procedure TFAltaFacturas.CreaQueryBas;
begin
  QBasFactura:=TBonnyClientDataSet.Create(self);
  with QBasFactura do
  begin
    SQL.Add(' select * from tfacturas_bas       ');
    SQL.Add('  where cod_factura_fb = :MICODFAC ');

    ParamByName('MICODFAC').DataType := ftString;
  end;
end;

procedure TFAltaFacturas.CreaQDatosInco;
begin
  QDatosInco := TBonnyQuery.Create(Self);
  with QDatosInco do
  begin
    SQL.Add(' select incoterm_sc, plaza_incoterm_sc ');
    SQL.Add('  from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :MIEMP ');
    SQL.Add('   and centro_salida_sc = :MICEN ');
    SQL.Add('   and n_albaran_sc = :MIALB ');
    SQL.Add('   and fecha_sc = :MIFEC ');

    Prepare;
  end;
end;

procedure TFAltaFacturas.CreaQDatosAlb;
begin
  QDatosAlb := TBonnyQuery.Create(Self);
  with QDatosAlb do
  begin
    SQL.Add(' select DISTINCT cliente_sal_sc, dir_sum_sc, n_pedido_sc, fecha_pedido_sc, vehiculo_sc, ');
    SQL.Add('        calibre_sl, marca_sl, representante_c, tipo_iva_e, ');
    SQL.Add('        emp_procedencia_sl, centro_origen_sl, ');
    SQL.Add('        cod_factura_fc, comercial_sl ');
    SQL.Add('   from frf_salidas_c, frf_salidas_l, frf_clientes, frf_productos, frf_envases, outer(tfacturas_cab) ');
    SQL.Add(' where empresa_sc = :MIEMP ');
    SQL.Add('   and centro_salida_sc = :MICEN ');
    SQL.Add('   and n_albaran_sc = :MIALB ');
    SQL.Add('   and fecha_sc = :MIFEC ');
    SQL.Add('  and producto_sl = :MIPROD ');
    SQL.Add('    and envase_sl = :MIENV ');
    SQL.Add('    and categoria_sl = :MICAT ');


    SQL.Add('   and empresa_sl = empresa_sc ');
    SQL.Add('   and centro_salida_sl = centro_salida_sc ');
    SQL.Add('   and n_albaran_sl = n_albaran_sc ');
    SQL.Add('   and fecha_sl = fecha_sc');

    SQL.Add('  and cliente_c = cliente_sal_sc ');

    SQL.Add('  and producto_p = producto_sl ');

    SQL.Add('  and envase_e = envase_sl ');
    SQL.Add('  and (producto_e = producto_p  OR producto_e IS NULL) ');

    SQL.Add('    and empresa_fac_sc = cod_empresa_fac_fc ');          //Factura origen para el abono
    SQL.Add('    and n_factura_sc = n_factura_fc ');
    SQL.Add('    and fecha_factura_sc = fecha_factura_fc ');
    SQL.Add('    and serie_fac_sc = cod_serie_fac_fc ');

    Prepare;
  end;
end;

procedure TFAltaFacturas.CreaQAlbaran;
begin
  QAlbaran := TBonnyQuery.Create(Self);
  with QAlbaran do
  begin
    SQL.Add('select * from frf_salidas_c');
    SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('  and centro_salida_sc = :centro ');
    SQL.Add('  and n_albaran_sc = :albaran ');
    SQL.Add('  and fecha_sc = :fecha ');

    Prepare;
  end;
end;

procedure TFAltaFacturas.CreaQLineasAlb;
begin
  QLineasAlb := TBonnyQuery.Create(Self);
  with QLineasAlb do
  begin
    SQL.Add('select * from frf_salidas_l');
    SQL.Add('where empresa_sl = :empresa ');
    SQL.Add('  and centro_salida_sl = :centro ');
    SQL.Add('  and n_albaran_sl = :albaran ');
    SQL.Add('  and fecha_sl = :fecha ');

    SQL.Add('  and producto_sl = :producto ');
    SQL.Add('  and envase_sl = :envase ');
    SQL.Add('  and categoria_sl = :categoria ');

    Prepare;
  end;
end;

procedure TFAltaFacturas.CreaQCabeceraAlb;
begin
  QCabeceraAlb := TBonnyQuery.Create(Self);
  with QCabeceraAlb do
  begin
    SQL.Add('select * from frf_salidas_c');
    SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('  and centro_salida_sc = :centro ');
    SQL.Add('  and n_albaran_sc = :albaran ');
    SQL.Add('  and fecha_sc = :fecha ');

    Prepare;
  end;
end;

function TFAltaFacturas.EjecutaQueryDet: Boolean;
begin
  with QDetFactura do
  begin
    ParamByName('MICODFAC').AsString := sClave;

    Open;
    Result:= not IsEmpty;
  end;
end;

function TFAltaFacturas.EjecutaQueryBas: Boolean;
begin
  with QBasFactura do
  begin
    ParamByName('MICODFAC').AsString := sClave;

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TFAltaFacturas.edtEmpAlbaranPropertiesChange(Sender: TObject);
begin
  txDesEmpalbaran.Text := desEmpresa(edtEmpAlbaran.Text);
  txDesCentro.Text := desCentro(edtEmpAlbaran.Text, edtCenSalida.Text);
end;

procedure TFAltaFacturas.edtCenSalidaPropertiesChange(Sender: TObject);
begin
  txDesCentro.Text := desCentro(edtEmpAlbaran.Text, edtCenSalida.Text);
end;

procedure TFAltaFacturas.edtProductoPropertiesChange(Sender: TObject);
begin
  txDesProducto.Text:= desProductoVenta(edtProducto.Text);
  txDesCategoria.Text:= desCategoria(edtEmpAlbaran.Text, edtProducto.Text, edtCategoria.Text);
end;

procedure TFAltaFacturas.edtCategoriaPropertiesChange(Sender: TObject);
begin
  txDesCategoria.Text:= desCategoria(edtEmpAlbaran.Text, edtProducto.Text, edtCategoria.Text);
end;

procedure TFAltaFacturas.edtEnvaseExit(Sender: TObject);
begin
  if EsNumerico(edtEnvase.Text) and (Length(edtEnvase.Text) <= 5) then
    if (edtEnvase.Text <> '' ) and (Length(edtEnvase.Text) < 9) then
      edtEnvase.Text := 'COM-' + Rellena( edtEnvase.Text, 5, '0');
  CambioEnvase;
end;

procedure TFAltaFacturas.CambioEnvase;
var
  iUnidadesCaja: integer;
  iUnidadesLinea, iCajasLinea: Integer;
begin

  ceUndFac.Text := UnidadFacturacion;
  sUnidadPrecioLinea := Copy(ceUndFac.Text, 1, 1);

  bEnvaseVariableLinea := EnvaseUnidadesVariable(edtEmpAlbaran.Text, edtEnvase.Text, edtProducto.Text);
  ceUndCaja.Enabled := bEnvaseVariableLinea;
  bPesoVariableLinea := EnvasePesoVariable(edtEmpAlbaran.Text, edtEnvase.Text, edtProducto.Text);
  ceKilos.Enabled := bPesoVariableLinea;
  rPesoCaja := KilosEnvase(edtEmpAlbaran.Text, edtEnvase.Text, edtProducto.Text);

  iUnidadesCaja := UnidadesEnvase(edtEmpAlbaran.Text, edtEnvase.Text, edtProducto.Text);
  iCajasLinea :=  StrToIntDef(ceCajas.Text, 0);
  iUnidadesLinea := iCajasLinea * iUnidadesCaja;

  ceUndCaja.Text := FormatFloat('#0', iUnidadesCaja);
  ceUnidades.Text := FormatFloat('#0', iUnidadesLinea);

  RecalcularUnidades(Self);

end;

procedure TFAltaFacturas.RecalcularUnidades(const ASender: TObject; const AImporte: boolean = false);
var
  iUnidadesCaja: integer;
  iUnidadesLinea, iCajasLinea: Integer;
  rKilosLinea, rPrecioLinea, rNetoLinea, rIvaLinea, rTotalLinea: Real;
begin
  //S�LO SE REALIZARA EL CODIGO SI LA TABLA ES EDITABLE
  if ((dsDetFactura.State <> dsEdit) and (dsDetFactura.State <> dsInsert)) then
    Exit;

  bFlagCambios := False;

  iUnidadesCaja := StrToIntDef(ceUndCaja.Text, 1);
  iCajasLinea := StrToIntDef(ceCajas.Text, 0);
  if cbxTipoUnidad.ItemIndex <> 1 then //(unidades)
    iUnidadesLinea := iCajasLinea * iUnidadesCaja
  else
    iUnidadesLinea := StrToIntDef(ceUnidades.Text, 0);
  if bPesoVariableLinea then
  begin     
    rKilosLinea := StrToFloatDef(ceKilos.Text, 0);
  end
  else
  begin
    rKilosLinea := bRoundTo(rPesoCaja * iCajasLinea, 2);
  end;

  if AImporte then
  begin
    rNetoLinea := StrToFloatDef(ceImporte.Text, 0);
    if rNetoLinea = 0 then
    begin
      rPrecioLinea := 0;
    end
    else if sUnidadPrecioLinea = 'K' then
    begin
      rPrecioLinea := bRoundTo(rNetoLinea / rKilosLinea, 3);
    end
    else if sUnidadPrecioLinea = 'U' then
    begin
      rPrecioLinea := bRoundTo(rNetoLinea / iUnidadesLinea, 3);
    end
    else
    //if sUnidadPrecioLinea = 'C' then
    begin
      rPrecioLinea := bRoundTo(rNetoLinea / iCajasLinea, 3);
    end;
  end
  else
  begin
    rPrecioLinea := StrToFloatDef(cePrecio.Text, 0);
    if sUnidadPrecioLinea = 'K' then
    begin
      rNetoLinea := rPrecioLinea * rKilosLinea;
    end
    else if sUnidadPrecioLinea = 'U' then
    begin
      rNetoLinea := rPrecioLinea * iUnidadesLinea;
    end
    else
    //if sUnidadPrecioLinea = 'C' then
    begin
      rNetoLinea := rPrecioLinea * iCajasLinea;
    end;
  end;

//  rIvaLinea := bRoundTo(rNetoLinea * (rImpuestoLinea / 100), 2);
//  rTotalLinea := rNetoLinea + rIvaLinea;
{
  ceCajas.Text := IntToStr(iCajasLinea);
  ceKilos.Text := FormatFloat('#0.00', rKilosLinea);
  cePrecio.Text := FormatFloat('#0.0000', rPrecioLinea);
  ceUnidades.Text := IntToStr(iUnidadesLinea);
  ceImporte.Text := FloatToStr(bRoundTo(rNetoLinea, 2));
}

  if TComponent(ASender).Name <> 'ceCajas' then
    ceCajas.Text := FormatFloat('#0', iCajasLinea);
//  if TComponent(ASender).Name <> 'ceUndCaja' then
//    ceUndCaja.Text := FormatFloat('#0', iUnidadesCaja);
  if TComponent(ASender).Name <> 'ceUnidades' then
    ceUnidades.Text := FormatFloat('#0', iUnidadesLinea);
  if TComponent(ASender).Name <> 'ceKilos' then
    ceKilos.Text := FormatFloat('#0.00', rKilosLinea);
  if TComponent(ASender).Name <> 'cePrecio' then
    cePrecio.Text := FormatFloat('#0.0000', rPrecioLinea);
  if TComponent(ASender).Name <> 'ceImporte' then
    ceImporte.Text := FormatFloat('#0.00', rNetoLinea);
{
  if TComponent(ASender).Name <> 'porc_iva_sl' then
    porc_iva_sl.Text := FormatFloat('#0.00', rImpuestoLinea);
  if TComponent(ASender).Name <> 'iva_sl' then
    iva_sl.Text := FormatFloat('#0.00', rIvaLinea);
  if TComponent(ASender).Name <> 'importe_total_sl' then
    importe_total_sl.Text := FormatFloat('#0.00', rTotalLinea);
}

  bFlagCambios := True;
end;


procedure TFAltaFacturas.edtEnvasePropertiesChange(Sender: TObject);
begin
  txDesEnvase.Text := DesEnvCli(edtEmpAlbaran.Text,
                                   edtProducto.Text,
                                   edtEnvase.Text,
                                   edtCliente.Text);     //cliente Facturacion, correcto para buscar Descripcion Envase
end;

procedure TFAltaFacturas.btnSalirClick(Sender: TObject);
var sAux: String;
begin
    if (QCabFactura.RecordCount > 0) then
    begin
    if bAlta then
      sAux := 'La Factura / Abono Manual no se generar� �Desea salir del mantenimiento?'
    else
      sAux := 'La Factura / Abono Manual no se modificar� �Desea salir del mantenimiento?';
    case MessageDlg(sAux, mtInformation, [mbNo,mbYes],0) of
      mryes:
      begin
        ModalResult:= mrCancel;
      end;
      mrno:
      begin
        if gbCabecera.Enabled then edtEmpresa.SetFocus
        else
        begin
          cxPageControl.ActivePage := tsDetalleFactura;
        end;
      end;
    end;
    end
    else
    begin
      ModalResult := mrCancel;
    end;
end;

procedure TFAltaFacturas.deFechaFacturaPropertiesChange(Sender: TObject);
var dFecha, dCobro, dTesoreria: TDateTime;
begin
  //Fecha prevista cobro
  if TryStrToDate( deFechaFactura.Text, dFecha ) and
     (txDesEmpresa.Text <> '') and
     (txDesCliente.Text <> '') and
     (deFechaFactura.Text <> '') then
  begin
    DFactura.PutFechaVencimiento( edtEmpresa.Text, edtcliente.Text, dFecha, dCobro, dTesoreria );
    edtNumFacIni.Text:= '';
    deFechaFacIni.Text:= DateToStr( dFecha  );
    if dePrevisionCobro.Text = ''  then
      dePrevisionCobro.Text:= DateToStr( dCobro  );
    if dePrevisionTeso.Text = ''  then
      dePrevisionTeso.Text:= DateToStr( dTesoreria  );
  end;
end;

procedure TFAltaFacturas.dsDetFacturaStateChange(Sender: TObject);
begin
  btnAceptarLinea.Enabled := (QDetFactura.State in dsEditModes);
  btnCancelarLinea.Enabled := (QDetFactura.State in dsEditModes);
  btnAltaLinea.Enabled := not (QDetFactura.State in dsEditModes);
  btnBajaLinea.Enabled := not (QDetFactura.State in dsEditModes);
  btnGrabarFactura.Enabled := not (QDetFactura.State in dsEditModes); // and QDetFactura.RecordCount > 0;
  btnSalir.Enabled := QDetFactura.RecordCount > 0;

  bFacturaModificada := bFacturaModificada or (dsDetFactura.State in dsEditModes);
end;

function TFAltaFacturas.DatosLinCorrectos: boolean;
var iEntero: integer;
    dFecha: TDateTime;
begin
  Result := false;

  //Empresa Cabecera <> Empresa Linea
  if (edtEmpAlbaran.Text <> edtEmpresa.Text) then
  begin
    ShowMessage(' ATENCION: Empresa del Albaran distinta de la cabecera de factura.');
    edtEmpAlbaran.SetFocus;
    exit;
  end;

  if (sTipoFactura = '380') and (ceImporte.Value < 0)  then
  begin
    ShowMessage(' FACTURA: El importe de la linea debe ser positivo.');
    ceImporte.SetFocus;
    exit;
  end;

  if (sTipoFactura = '381') and (ceImporte.Value > 0)  then
  begin
    ShowMessage(' ABONO: El importe de la linea debe ser negativo.');
    ceImporte.SetFocus;
    exit;
  end;

    //Empresa Albaran
  if txDesEmpAlbaran.Text = '' then
  begin
    ShowMessage( 'El c�digo de empresa albaran es incorrecto.');
    edtEmpAlbaran.SetFocus;
    exit;
  end;
    //Centro Salida
  if txDesCentro.Text = '' then
  begin
    ShowMessage( 'El centro de salida es incorrecto.');
    edtCenSalida.SetFocus;
    exit;
  end;
    //N�mero Albaran
  if not TryStrToInt( edtNumAlbaran.Text, iEntero ) then
  begin
    ShowMessage( 'El n�mero de albar�n es incorrecto.');
    edtNumAlbaran.SetFocus;
    exit;
  end;
    //Fecha Albaran
  if not TryStrToDate( deFechaAlbaran.Text, dFecha) then
  begin
    ShowMessage('La fecha de albar�n es incorrecta');
    deFechaAlbaran.SetFocus;
    exit;
  end;
    //Producto
  if txDesProducto.Text = '' then
  begin
    if not EsProductoVenta( edtProducto.Text) then
      ShowMessage(' ATENCI�N: Error al grabar la linea, el producto est� dado de BAJA. ')
    else if not EsProductoVenta(edtProducto.Text) then
      ShowMessage(' ATENCI�N: Error al grabar la linea, el producto NO est� marcado como Producto de Venta. ')
    else
      ShowMessage('Falta el producto o es incorrecto.');

//    ShowMessage('El producto del detalle es incorrecto.');
    edtProducto.SetFocus;
    exit;
  end;
    //Envase
  if txDesEnvase.Text = '' then
  begin
    ShowMessage('El art�culo del detalle es incorrecto.');
    edtEnvase.SetFocus;
    exit;
  end;
    //Categoria
  if txDesCategoria.Text = '' then
  begin
    ShowMessage('La categoria del detalle es incorrecta.');
    edtCategoria.SetFocus;
    exit;
  end;

  if cbxTipoUnidad.ItemIndex <> 0 then
  begin
    //UNIDADES
    if sUnidadPrecioLinea = 'U' then
    begin
      if bRoundTo((ceUnidades.Value * cePrecio.Value), 2) <> ceImporte.Value then
      begin
        ShowMessage('El importe de la linea es incorrecto.');
        ceImporte.SetFocus;
        exit;
      end;
    end;

    //CAJAS
    if sUnidadPrecioLinea = 'C' then
    begin
      if bRoundTo((ceCajas.Value * cePrecio.Value), 2) <> ceImporte.Value then
      begin
        ShowMessage('El importe de la linea es incorrecto.');
        ceImporte.SetFocus;
        exit;
      end;
    end;

    //KILOS
    if sUnidadPrecioLinea = 'K' then
    begin
      if bRoundTo((ceKilos.Value * cePrecio.Value), 2) <> ceImporte.Value then
      begin
        ShowMessage('El importe de la linea es incorrecto.');
        ceImporte.SetFocus;
        exit;
      end;
    end;
  end;
  if (sTipoFactura = '381') then
  begin
     if (ceCajas.Value > 0) or  (ceKilos.Value > 0) or (ceImporte.Value > 0) then
     begin
       ShowMessage(' ATENCION: Las cantidades deben ser negativas.');
       ceCajas.SetFocus;
       exit;
     end;
  end;
  if (sTipoFactura = '380') then
  begin
    if (ceCajas.Value < 0) or  (ceKilos.Value < 0) or (ceImporte.Value < 0) then
    begin
       ShowMessage(' ATENCION: Las cantidades deben ser positivas.');
       ceCajas.SetFocus;
       exit;
    end;
  end;

  Result := true;

end;

function TFAltaFacturas.ExisteAlbaran: Boolean;
begin
  with QAlbaran do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString:= edtEmpAlbaran.Text;
    ParamByName('centro').AsString:= edtCenSalida.Text;
    ParamByName('albaran').AsString:= edtNumAlbaran.Text;
    ParamByName('fecha').AsDateTime:= deFechaAlbaran.Date;
    Open;

    Result := not IsEmpty;

  end;

end;

function TFAltaFacturas.ExisteLinAlbaran: Boolean;
begin
  with QLineasAlb do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString:= edtEmpAlbaran.Text;
    ParamByName('centro').AsString:= edtCenSalida.Text;
    ParamByName('albaran').AsString:= edtNumAlbaran.Text;
    ParamByName('fecha').AsDateTime:= deFechaAlbaran.Date;

    ParamByName('producto').AsString:= edtProducto.Text;
    ParamByName('envase').AsString:= edtEnvase.Text;
    ParamByName('categoria').AsString:= edtCategoria.Text;

    Open;

    Result := not IsEmpty;
  end;
end;

procedure TFAltaFacturas.ceCajasPropertiesChange(Sender: TObject);
begin
  if cbxTipoUnidad.ItemIndex <> 0 then
    RecalcularUnidades(Sender);
end;

procedure TFAltaFacturas.ceKilosPropertiesChange(Sender: TObject);
begin
  if cbxTipoUnidad.ItemIndex <> 0 then
    RecalcularUnidades(Sender);
end;

procedure TFAltaFacturas.cePrecioChange(Sender: TObject);
begin
  if cbxTipoUnidad.ItemIndex <> 0 then
    RecalcularUnidades(Sender);
 //   ceImporte.Value := bRoundTo( cePrecio.Value * ceUnidades.Value, -2 );
end;

procedure TFAltaFacturas.cePrecioPropertiesChange(Sender: TObject);
begin
  if cePrecio.Value < 0 then
  begin
    ShowMessage('ATENCION! El precio no puede ser negativo.');
    cePrecio.SetFocus;
    Exit;
  end;
  if cbxTipoUnidad.ItemIndex <> 0 then
    RecalcularUnidades(Sender);
 //   ceImporte.Value := bRoundTo( cePrecio.Value * ceUnidades.Value, -2 );
end;

procedure TFAltaFacturas.ceUndCajaPropertiesChange(Sender: TObject);
begin
  if ceUndCaja.Value < 0 then
  begin
    ShowMessage('ATENCION! Las unidades por caja no pueden ser negativas.');
    ceUndCaja.SetFocus;
    Exit;
  end;
  if cbxTipoUnidad.ItemIndex <> 0 then
    RecalcularUnidades(Sender);
end;

procedure TFAltaFacturas.ceUndFacPropertiesChange(Sender: TObject);
begin
  if cbxTipoUnidad.ItemIndex <> 0 then
    RecalcularUnidades(Sender);
end;

procedure TFAltaFacturas.ceUnidadesPropertiesChange(Sender: TObject);
begin

  if cbxTipoUnidad.ItemIndex <> 0 then
    RecalcularUnidades(Sender);
end;

function TFAltaFacturas.ComprobarConstraint: Boolean;
begin
  Result := false;

  //Existe albaran
  if not  ExisteAlbaran then
  begin
    ShowMessage('Albar�n incorrecto (empresa albar�n - centro salida - n�mero albar�n - fecha albar�n ).');
    edtCenSalida.SetFocus;
    Exit;
  end;

  //Existe producto, origen, envase, categoria
  if not  ExisteLinAlbaran then
  begin
    ShowMessage('Producto, origen, envase y/o categoria inexistente para el albar�n seleccionado.');
    edtProducto.SetFocus;
    Exit;
  end;
  // Comprobar cliente y moneda en cabecera factura
  if DistintaCabecera then
  begin
    ShowMessage(' El Cliente y/o Moneda no coincide con el de la cabecera de Factura.');
    edtEmpAlbaran.SetFocus;
    Exit;
  end;
  //La fecha de la factura debe ser superior a la del albaran
  if deFechaFactura.Date < deFechaAlbaran.Date then
  begin
    ShowMessage('La fecha de la factura debe de ser mayor o igual a la del albar�n.');
    deFechaAlbaran.SetFocus;
    Exit;
  end;

  Result := true;
end;

function TFAltaFacturas.DesUnidad(const AUnidad: Integer): String;
begin
  case AUnidad of
    0: result:= 'IMP';
    1: result:= 'UND';
    2: result:= 'CAJ';
    3: result:= 'KGS';
    4: Result := UnidadFacturacion;
  end;
end;

function TFAltaFacturas.UnidadFacturacion: string;
var empresa, cliente, producto, envase: string;
begin

  if QDetFactura.FieldByName('unidad_facturacion_fd').AsString = '' then
  begin
    empresa := QCabFactura.fieldbyname('cod_empresa_fac_fc').AsString;
    cliente := QCabFactura.fieldbyname('cod_cliente_fc').AsString;
    producto := edtProducto.Text;
    envase := edtEnvase.Text;

    result := 'KGS';
    with DMAuxDB.QAux do
    begin
      SQL.Text := ' select unidad_fac_ce from frf_clientes_env ' + ' where empresa_ce=' + QuotedStr(empresa) + ' and cliente_ce=' + QuotedStr(cliente) + ' and producto_ce=' + QuotedStr(producto) + ' and envase_ce=' + QuotedStr(envase);
      try
        try
          Open;
        except
          showMessage('Unidad de facturacion incorrecta: ' + empresa + '-' + cliente + '-' + producto + '-' + envase);
        end;
        if not IsEmpty then
        begin
          if fields[0].AsString = 'U' then
          begin
            result := 'UND';
          end
          else if fields[0].AsString = 'C' then
          begin
            result := 'CAJ';
          end;
        end;
      finally
        Cancel;
        Close;
      end;
    end;
  end
  else
    result := QDetFactura.FieldByName('unidad_facturacion_fd').AsString;

end;

procedure TFAltaFacturas.cbxTipoUnidadPropertiesChange(Sender: TObject);
begin
  ConfigurarUnidades;
end;

procedure TFAltaFacturas.ConfigurarUnidades;
begin
  ceUnidades.Properties.ReadOnly := true;
  ceUnidades.Style.Color := ClBtnFace;

  if cbxTipoUnidad.ItemIndex = 0 then   //IMPORTE
  begin
    ceCajas.Enabled := false;
    ceUndCaja.Enabled := false;
    ceKilos.Enabled := False;
    ceUnidades.Enabled := false;
    ceUndFac.Enabled := false;
    cePrecio.Enabled := false;
    ceImporte.Enabled := true;
    ceImporte.Text := FloatToStr(QDetFactura.FieldByName('importe_linea_fd').AsFloat);
  end
  else
  if cbxTipoUnidad.ItemIndex = 1 then   //UNIDADES
  begin
    ceCajas.Enabled := false;
    bEnvaseVariableLinea := EnvaseUnidadesVariable(edtEmpAlbaran.Text, edtEnvase.Text, edtProducto.Text);
    ceUndCaja.Enabled := bEnvaseVariableLinea;
    bPesoVariableLinea := EnvasePesoVariable(edtEmpAlbaran.Text, edtEnvase.Text, edtProducto.Text);
    ceKilos.Enabled := bPesoVariableLinea;
    ceUnidades.Enabled := true;
    ceUnidades.Properties.ReadOnly := false;
    ceUnidades.Style.Color := ClWindow;
    ceUndFac.Enabled := false;
    cePrecio.Enabled := true;
    ceImporte.Enabled := false;
//    CambioEnvase;
    ceCajas.Enabled := false;
    ceKilos.Enabled := false;
    ceUnidades.Enabled := true;
    ceUnidades.Properties.ReadOnly := false;
    ceUnidades.Style.Color := ClWindow;
  end
  else
  begin
    ceCajas.Enabled := true;
    bEnvaseVariableLinea := EnvaseUnidadesVariable(edtEmpAlbaran.Text, edtEnvase.Text, edtProducto.Text);
    ceUndCaja.Enabled := bEnvaseVariableLinea;
    bPesoVariableLinea := EnvasePesoVariable(edtEmpAlbaran.Text, edtEnvase.Text, edtProducto.Text);
    ceKilos.Enabled := bPesoVariableLinea;
    ceUnidades.Enabled := false;
    ceUndFac.Enabled := false;
    cePrecio.Enabled := true;
    ceImporte.Enabled := false;
//    CambioEnvase;
  end;
  ceUndFac.Text := DesUnidad(cbxTipoUnidad.ItemIndex);
  sUnidadPrecioLinea := Copy(ceUndFac.Text, 1, 1);
  {
  case cbxTipoUnidad.ItemIndex of
      //Unidades
    1:
    begin
      ceUnidades.Properties.DecimalPlaces := 0;
      ceUnidades.Properties.DisplayFormat := ',0;-,0';
      lb12.Caption := 'Unidades';
      ceUnidades.Text := FloatToStr(QDetFactura.FieldByName('unidades_fd').AsFloat);
    end;
      //Cajas
    2:
    begin
      ceUnidades.Properties.DecimalPlaces := 0;
      ceUnidades.Properties.DisplayFormat := ',0;-,0';
      lb12.Caption := 'Cajas';
      ceUnidades.Text := FloatToStr(QDetFactura.FieldByName('cajas_fd').AsFloat);
    end;
      //Kilos
    3:
    begin
      ceUnidades.Properties.DecimalPlaces := 2;
      ceUnidades.Properties.DisplayFormat := ',0.00;-,0.00';
      lb12.Caption := 'Kilos';
      ceUnidades.Text := FloatToStr(QDetFactura.FieldByName('kilos_fd').AsFloat);
    end;
  end;
}
end;

procedure TFAltaFacturas.btnGrabarFacturaClick(Sender: TObject);
begin
 { TODO : Crear Factura Abono de distintas facturas origen y contabilizar }
  if mmxNotas.Text = '' then
  begin
    ShowMessage('Factura/Abono sin texto en el cuerpo de la factura.');
    cxPageControl.ActivePage := tsTextoFactura;
    mmxNotas.SetFocus;
    exit;
  end;
  AsignarNumLinea;
  ActualizarNotasFactura;
  CalcularTotales;
  ActualizarDatos;

  ModalResult := mrOk;
end;


procedure TFAltaFacturas.ActualizarFechaCobro( const AFactura: string );
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select min(fecha_factura_fc) fecha_factura, min(prevision_cobro_fc) fecha_cobro, min(prevision_tesoreria_fc) fecha_teso, count(*) registros  ');
    SQL.Add(' from tfacturas_det ');
    SQL.Add('      join tfacturas_cab on cod_factura_fd = cod_factura_fc ');
    SQL.Add(' where cod_factura_fd = :abono ');
    SQL.Add(' and prevision_cobro_fc is not null ');
    ParamByName('abono').AsString:= AFactura;
    Open;
    if FieldByName('registros').AsInteger > 0 then
    begin
      QCabFactura.Edit;
      QCabFactura.FieldByName('cod_factura_anula_fc').AsString:= AFactura;
      QCabFactura.FieldByName('fecha_fac_ini_fc').AsDateTime:= FieldByName('fecha_factura').AsDateTime;
      if FieldByName('fecha_cobro').AsDateTime < QCabFactura.FieldByName('prevision_cobro_fc').AsDateTime  then
      begin
        if FieldByName('fecha_cobro').AsDateTime < QCabFactura.FieldByName('fecha_factura_fc').AsDateTime then
        begin
          QCabFactura.FieldByName('prevision_cobro_fc').AsDateTime:= QCabFactura.FieldByName('fecha_factura_fc').AsDateTime;
        end
        else
        begin
          QCabFactura.FieldByName('prevision_cobro_fc').AsDateTime:= FieldByName('fecha_cobro').AsDateTime;
        end;
      end;

      if FieldByName('fecha_teso').AsDateTime < QCabFactura.FieldByName('prevision_tesoreria_fc').AsDateTime  then
      begin
        if FieldByName('fecha_teso').AsDateTime < QCabFactura.FieldByName('fecha_factura_fc').AsDateTime then
        begin
          QCabFactura.FieldByName('prevision_tesoreria_fc').AsDateTime:= QCabFactura.FieldByName('fecha_factura_fc').AsDateTime;
        end
        else
        begin
          QCabFactura.FieldByName('prevision_tesoreria_fc').AsDateTime:= FieldByName('fecha_teso').AsDateTime;
        end;
      end;
      QCabFactura.Post( False );
    end;
    Close;
  end;
end;


procedure TFAltaFacturas.ActivarPanelCabecera(AActivar: Boolean);
begin
  edtEmpresa.Enabled := AActivar;
  ssEMpresa.Enabled := AActivar;

  edtSerie.Enabled := AActivar;
  ssSerie.Enabled := AActivar;

  edtCliente.Enabled := AActivar;
  ssCliente.Enabled := AActivar;

  edtMoneda.Enabled := AActivar;
  ssMoneda.Enabled := AActivar;

  deFechaFactura.Enabled := AActivar;
  edtNumeroFactura.Enabled := AActivar;

  edtImpuesto.Enabled := AActivar;
  ssImpuesto.Enabled := AActivar;

  dePrevisionCobro.Enabled := AActivar;
  dePrevisionTeso.Enabled := AActivar;
  deFechaFacIni.Enabled := AActivar;
  edtNumFacIni.Enabled := AActivar;
  rgTipoFactura.Enabled := AActivar;
  gbPerdidas.Enabled := AActivar;
  cbNumRegistroAcuerdo.Enabled := True;

  btnGrabarFactura.Enabled := bFacturaModificada and (QDetFactura.RecordCount > 0);
end;

procedure TFAltaFacturas.ActualizarDatos;
var iNumFactura: Integer;
    sClaveFactura: string;
begin
  try
    AbrirTransaccion(DMBaseDatos.DBBaseDatos);
    if bAlta then
    begin
      if bFactPerdida then
        iNumFactura := StrToInt(txFactura.Text)
      else
        iNumFactura := GetClaveFactura;
      if iNumFactura = -1 then
      begin
        QCabFactura.Cancel;
        QDetFactura.Cancel;
        QBasFactura.Cancel;
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        exit;
      end;

      sClaveFactura := NewCodigoFactura(QCabFactura.FieldByName('cod_empresa_fac_fc').AsString,
                                    QCabFactura.FieldByName('tipo_factura_fc').AsString,
                                    QCabFactura.FieldByName('impuesto_fc').AsString,
                                    QCabFactura.FieldByName('cod_serie_fac_fc').AsString,
                                    QCabFactura.FieldByName('fecha_factura_fc').AsDateTime,
                                    iNumFactura);
      sClave := sClaveFactura;

        // Actualizamos Cabecera Factura
      if not (QCabFactura.State in dsEditModes) then QCabFactura.Edit;
      QCabFactura.FieldByName('n_factura_fc').AsInteger := iNumFactura;
      QCabFactura.FieldByName('cod_factura_fc').AsString := sClaveFactura;
      QCabFactura.Post(True);


        //Actualizamos Detalle Factura
      with QDetFactura do
      begin
        First;
        while not Eof do
        begin
          Edit;
          FieldByName('cod_factura_fd').AsString := sClaveFactura;
          Post(False);

          Next;
        end;
      end;
        //Actualizamos Base Factura
      with QBasFactura do
      begin
        First;
        while not Eof do
        begin
          Edit;
          FieldByName('cod_factura_fb').AsString := sClaveFactura;
          Post(False);

          Next;
        end;
      end;
    end;

    QCabFactura.ApplyUpdates(0);
    QDetFactura.ApplyUpdates(0);
    QBasFactura.ApplyUpdates(0);
    AceptarTransaccion(DMBaseDatos.DBBaseDatos);

  except
    on E:Exception do
    begin
//        CapturaErrores(E);
        QCabFactura.Cancel;
        QDetFactura.Cancel;
        QBasFactura.Cancel;
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
    end;
  end;

//  StringSQL := ' where cod_factura_fc = ' + QuotedStr(QCabFactura.fieldbyname('cod_factura_fc').AsString);

end;

function TFAltaFacturas.GetClaveFactura: integer;
var  iFactura: integer;
     sAux: String;
begin

  iFactura := GetNumeroFactura(QCabFactura.FieldByName('cod_empresa_fac_fc').AsString,
                               QCabFactura.FieldByName('tipo_factura_fc').AsString,
                               QCabFactura.FieldByName('impuesto_fc').AsString,
                               QCabFactura.FieldByName('cod_serie_fac_fc').AsString,
                               QCabFactura.FieldByName('fecha_factura_fc').AsDateTime, sAux);
  if iFactura = -1 then
  begin
    ShowMessage( sAux );
    edtNumeroFactura.Text := '';
  end
  else
  begin
    edtNumeroFactura.Text:= IntToStr( iFactura );
  end;

  Result := iFactura;

end;

procedure TFAltaFacturas.CalcularTotales;
var rLinea, rDescuento, rNeto, rImpuesto, rTotal, rNetoEuros, rImpuestoEuros, rTotalEuros: real;
    flag: boolean;
    i, iBases: integer;
    RImpBases: TRImpBases;
begin
  rLinea := 0;
  rDescuento := 0;
  rNeto := 0;
  rImpuesto := 0;
  rTotal := 0;
  rNetoEuros := 0;
  rImpuestoEuros := 0;
  rTotalEuros := 0;

  iBases := 0;

        //INICIALIZAMOS BASES DETALLE
  QDetFactura.First;
  while not QDetFactura.Eof do
  begin
    i:= 0;
    flag:= False;
    while ( i < iBases ) and ( not flag ) do
    begin
      if QDetFactura.FieldByName('porcentaje_impuesto_fd').AsFloat =  RImpBases.aRImportes[i].rPorcentajeImpuesto then
        flag:= True
      else
        inc(i);
    end;
    if not flag then
    begin
      SetLength( RImpBases.aRImportes, iBases + 1);
      RImpBases.aRImportes[iBases].rPorcentajeImpuesto:= QDetFactura.FieldByName('porcentaje_impuesto_fd').AsFloat;
      RImpBases.aRImportes[iBases].iTasaImpuesto:= QDetFactura.FieldByName('tasa_impuesto_fd').AsInteger;
      RImpBases.aRImportes[i].iCajas := 0;
      RImpBases.aRImportes[i].iUnidades := 0;
      RImpBases.aRImportes[i].rKilos := 0;
      RImpBases.aRImportes[i].rImporteNeto:= 0;
      RImpBases.aRImportes[i].rImporteImpuesto:= 0;
      RImpBases.aRImportes[i].rImporteTotal:= 0;
      iBases:= iBases + 1;
    end;

    QDetFactura.Next;
  end;

      //Detalle Linea
  QDetFactura.First;
  while not QDetFactura.Eof do
  begin
        // CALCULOS BASES
    i := 0;
    while i< iBases do
    begin
      if QDetFactura.FieldByName('porcentaje_impuesto_fd').AsFloat = RImpBases.aRImportes[i].rPorcentajeImpuesto then
      begin
        if not bAlta then
          RImpBases.aRImportes[i].sCodFactura := QDetFactura.Fieldbyname('cod_factura_fd').AsString;

        RImpBases.aRImportes[i].iCajas := RImpBases.aRImportes[i].iCajas +
                                          QDetFactura.FieldByName('cajas_fd').AsInteger;
        RImpBases.aRImportes[i].iUnidades := RImpBases.aRImportes[i].iUnidades +
                                             QDetFactura.FieldByName('unidades_fd').AsInteger;
        RImpBases.aRImportes[i].rKilos := RImpBases.aRImportes[i].rKilos +
                                          QDetFactura.FieldByName('kilos_fd').AsFloat;
        RImpBases.aRImportes[i].rImporteNeto := RImpBases.aRImportes[i].rImporteNeto +
                                                QDetFactura.FieldByName('importe_neto_fd').AsFloat;
        RImpBases.aRImportes[i].rImporteImpuesto := RImpBases.aRImportes[i].rImporteImpuesto +
                                                    QDetFactura.FieldByName('importe_impuesto_fd').AsFloat;
        RImpBases.aRImportes[i].rImporteTotal := RImpBases.aRImportes[i].rImporteTotal +
                                                 QDetFactura.FieldByName('importe_total_fd').AsFloat;
        Break;
      end;
      Inc(i)
    end;

    rLinea := rLinea + QDetFactura.fieldbyname('importe_linea_fd').AsFloat;
    rDescuento := rDescuento + QDetFactura.fieldbyname('importe_total_descuento_fd').AsFloat;
    rNeto := rNeto + QDetFactura.fieldbyname('importe_neto_fd').AsFloat;
    rImpuesto := rImpuesto + QDetFactura.fieldbyname('importe_impuesto_fd').AsFloat;
    rTotal := rTotal + QDetFactura.fieldbyname('importe_total_fd').AsFloat;

    QDetFactura.Next;
  end;

  if QCabFactura.FieldByName('moneda_fc').AsString = 'EUR' then
  begin
    rNetoEuros := rNeto;
    rImpuestoEuros := rImpuesto;
    rTotalEuros := rTotal;
  end
  else
    try
      rNetoEuros := ChangeToEuro( QCabFactura.FieldByName('moneda_fc').AsString,
                                  QCabFactura.FieldByName('fecha_factura_fc').AsString,
                                  rNeto);
      rImpuestoEuros := ChangeToEuro( QCabFactura.FieldByName('moneda_fc').AsString,
                                      QCabFactura.FieldByName('fecha_factura_fc').AsString,
                                      rImpuesto);
      rTotalEuros := ChangeToEuro( QCabFactura.FieldByName('moneda_fc').AsString,
                                   QCabFactura.FieldByName('fecha_factura_fc').AsString,
                                   rTotal);
    except
      ShowMessage('ERROR al calcular el cambio a Euros, comprobar que la moneda sea correcta.');
    end;

  AltaBasFactura(RImpBases);

  QCabFactura.Edit;
  QCabFactura.FieldByName('importe_linea_fc').AsFloat := rLinea;
  QCabFactura.FieldByName('importe_descuento_fc').AsFloat := rDescuento;
  QCabFactura.FieldByName('importe_neto_fc').AsFloat := rNeto;
  QCabFactura.FieldByName('importe_impuesto_fc').AsFloat := rImpuesto;
  QCabFactura.FieldByName('importe_total_fc').AsFloat := rTotal;
  QCabFactura.FieldByName('importe_neto_euros_fc').AsFloat := rNetoEuros;
  QCabFactura.FieldByName('importe_impuesto_euros_fc').AsFloat := rImpuestoEuros;
  QCabFactura.FieldByName('importe_total_euros_fc').AsFloat := rTotalEuros;
  QCabFactura.Post(False);

end;

procedure TFAltaFacturas.MostrarImpuesto;
begin
  Impuesto:= ImpuestosClientes(QDetFactura.fieldbyname('cod_empresa_albaran_fd').AsString,
                              QDetFactura.fieldbyname('cod_cliente_albaran_fd').AsString,
                              QCabFactura.fieldbyname('tipo_impuesto_fc').AsString,
                              QDetFactura.fieldbyname('fecha_albaran_fd').AsDateTime);
{
  //Calcular porcentaje de impuestos
  if impuesto.sCodigo = 'E' then
  begin
    tvLineasFactura. LIva_sl.Caption := ' IMPUESTOS';
    LPorc_iva_sl.Caption := ' EXENTO';
  end
  else
  begin
    LIva_sl.Caption := '  ' + impuesto.sTipo;
    LPorc_iva_sl.Caption := ' %' + impuesto.sTipo;
  end;
}
end;

procedure TFAltaFacturas.tvLineasFacturaDblClick(Sender: TObject);
begin
  pnlAltaLineas.Visible := true;

  if QDetFactura.FieldbyName('unidad_facturacion_fd').AsString = 'IMP' then
    cbxTipoUnidad.ItemIndex := 0
  else if QDetFactura.FieldbyName('unidad_facturacion_fd').AsString = 'UND' then
  begin
    if QDetFactura.fieldByName('cajas_fd').AsString = '' then    //UNIDADES
      cbxTipoUnidad.ItemIndex := 1
    else
      cbxTipoUnidad.ItemIndex := 4;
  end
  else if QDetFactura.FieldbyName('unidad_facturacion_fd').AsString = 'CAJ' then
  begin
    if QDetFactura.fieldByName('kilos_fd').AsString = '' then    //CAJAS
      cbxTipoUnidad.ItemIndex := 2
    else
      cbxTipoUnidad.ItemIndex := 4;
  end
  else if QDetFactura.FieldbyName('unidad_facturacion_fd').AsString = 'KGS' then
  begin
    if QDetFactura.fieldByName('cajas_fd').AsString = '' then    //KILOS
      cbxTipoUnidad.ItemIndex := 3
    else
      cbxTipoUnidad.ItemIndex := 4;
  end
  else
    cbxTipoUnidad.ItemIndex := 4;


{
  else if QDetFactura.FieldbyName('unidad_facturacion_fd').AsString = 'UND' then
    cbxTipoUnidad.ItemIndex := 1
  else if QDetFactura.FieldbyName('unidad_facturacion_fd').AsString = 'CAJ' then
    cbxTipoUnidad.ItemIndex := 2
  else
    cbxTipoUnidad.ItemIndex := 3;
}

  QDetFactura.Edit;
  ConfigurarUnidades;
  ceCajas.Text := FloatToStr(QDetFactura.FieldByName('cajas_fd').AsFloat);
  ceUndCaja.Text := FloatToStr(QDetFactura.FieldByName('unidades_caja_fd').AsFloat);
  ceUnidades.Text := FloatToStr(QDetFactura.FieldByName('unidades_fd').AsFloat);
  ceKilos.Text := FloatToStr(QDetFactura.FieldByName('kilos_fd').AsFloat);
  ceUndFac.Text := QDetFactura.FieldByName('unidad_facturacion_fd').AsString;
  cePrecio.Text := FloatToStr(QDetFactura.FieldByName('precio_fd').AsFloat);
  ceImporte.Text := FloatToStr(QDetFactura.FieldByName('importe_linea_fd').AsFloat);
  
  edtEmpAlbaran.SetFocus;
end;

procedure TFAltaFacturas.ActivarCabecera(AActivar: Boolean);
begin
//  gbCabecera.Enabled := AActivar;
  btnAceptar.Enabled := (QCabFactura.State in dsEditModes) and (AActivar);
  btnCancelar.Enabled := (QCabFactura.State in dsEditModes) and (AActivar);

  gbDetalle.Enabled := not AActivar;
  btnAceptarLinea.Enabled := (QDetFactura.State in dsEditModes) and not(AActivar);
  btnCancelarLinea.Enabled := (QDetFactura.State in dsEditModes) and not(AActivar);
  btnAltaLinea.Enabled := not (QDetFactura.State in dsEditModes) and not(AActivar);
  btnBajaLinea.Enabled := not (QDetFactura.State in dsEditModes) and not(AActivar);

  btnGrabarFactura.Enabled := not(QCabFactura.State in dsEditModes) and not (AActivar);
  btnSalir.Enabled := not (btnAceptar.Enabled) and not(pnlAltaLineas.Visible);

  cxPageControl.ActivePage := tsDetalleFactura;
end;

procedure TFAltaFacturas.btnAltaLineaClick(Sender: TObject);
begin
  QDetFactura.Append;

  QDetFactura.fieldbyname('cod_empresa_albaran_fd').AsString := edtEmpresa.Text;

  pnlAltaLineas.Visible := true;
  cbxTipoUnidad.ItemIndex := 4;
  ceUnidades.Text := '';
  cePrecio.Text := '';
  ceImporte.Text := '';
  ConfigurarUnidades;
  edtEmpAlbaran.SetFocus;
end;

procedure TFAltaFacturas.btnBajaLineaClick(Sender: TObject);
begin
  case MessageDlg('�Desea eliminar la linea de la Factura?', mtInformation, [mbNo,mbYes],0) of
    mryes:
    begin
      BorrarLinea;
      Exit;
    end;
    mrno:
      exit;
  end;
end;

procedure TFAltaFacturas.btnAceptarLineaClick(Sender: TObject);
begin
{ TODO : Ver que sucede si se hace un abono de un albaran que NO se ha facturado }
  cePrecioPropertiesChange(Self);
  if not DatosLinCorrectos then Exit;
  if not ComprobarConstraint then Exit;


  if bPrimeraLin then
    AltaCabFactura;
  AltaDetFactura;

  pnlAltaLineas.Visible := false;
end;

procedure TFAltaFacturas.btnCancelarLineaClick(Sender: TObject);
begin
  CancelarProceso;
end;

procedure TFAltaFacturas.edtEmpresaPropertiesChange(Sender: TObject);
var dFecha, dCobro, dTesoreria: TDateTime;
begin
  if (QCabFactura.State in dsEditModes) and (QCabFactura.fieldbyname('cod_serie_fac_fc').AsString = '') then
  begin
    edtSerie.Text := edtEmpresa.Text;
    QCabFactura.fieldbyname('cod_serie_fac_fc').AsString := edtEmpresa.Text;
  end;
  txDesEmpresa.Text := desEmpresa(edtEmpresa.Text);
  txDesCliente.Text := desCliente(edtCliente.Text);
  //Fecha prevista cobro
  if TryStrToDate( deFechaFactura.Text, dFecha ) and
     (txDesEmpresa.Text <> '') and
     (txDesCliente.Text <> '') and
     (deFechaFactura.Text <> '') then
  begin
    DFactura.PutFechaVencimiento( edtEmpresa.Text, edtcliente.Text, dFecha, dCobro, dTesoreria );
    edtNumFacIni.Text:= '';
    deFechaFacIni.Text:= DateToStr( dFecha  );
    if dePrevisionCobro.Text = ''  then
      dePrevisionCobro.Text:= DateToStr( dCobro );
    if dePrevisionTeso.Text = ''  then
      dePrevisionTeso.Text:= DateToStr( dTesoreria );
  end;
end;

function TFAltaFacturas.DistintaCabecera: Boolean;
begin
  with QCabeceraAlb do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString:= edtEmpAlbaran.Text;
    ParamByName('centro').AsString:= edtCenSalida.Text;
    ParamByName('albaran').AsString:= edtNumAlbaran.Text;
    ParamByName('fecha').AsDateTime:= deFechaAlbaran.Date;
    Open;

    Result := (QCabeceraAlb.FieldByName('cliente_fac_sc').AsString <> edtcliente.Text) or
              (QCabeceraAlb.FieldByName('moneda_sc').AsString <> edtmoneda.Text);
  end;
end;

procedure TFAltaFacturas.dsDetFacturaDataChange(Sender: TObject;
  Field: TField);
begin
  gbCabecera.Enabled := not (QDetFactura.State in dsEditModes);// and (QDetFactura.RecordCount = 0);
end;

procedure TFAltaFacturas.dsCabFacturaStateChange(Sender: TObject);
begin
  btnAceptar.Enabled := (QCabFactura.State in dsEditModes);
  btnCancelar.Enabled := (QCabFactura.State in dsEditModes);
  btnGrabarFactura.Enabled := not (QCabFactura.State in dsEditModes) and (dsDetFactura.Dataset.Active and (dsDetFactura.Dataset.RecordCount > 0));
  btnSalir.Enabled := not (QCabFactura.State in dsEditModes);

  bFacturaModificada := bFacturaModificada or (dsCabFactura.State in dsEditModes);
end;

procedure TFAltaFacturas.edtClientePropertiesChange(Sender: TObject);
var sIvaAux, sMonedaAux: string;
    dFecha, dCobro, dTeso: TDateTime;
begin
  txDesCliente.Text := desCliente(edtCliente.Text);
  if GetImpuestoMoneda( edtEmpresa.Text, edtCliente.Text, sIvaAux, sMonedaAux ) then
  begin
    if ( edtimpuesto.Text = sIvaAux ) and ( edtimpuesto.Text <> '' ) then
      edtimpuestoPropertiesChange( edtimpuesto );
    if (QCabFactura.state in dsEditModes)  then
    begin
      QCabFactura.FieldByName('tipo_impuesto_fc').AsString := sIvaAux;
      QCabFactura.FieldByName('moneda_fc').AsString := sMonedaAux;
    end;
  end;

  //Fecha prevista cobro
  if TryStrToDate( deFechaFactura.Text, dFecha ) and
     (txDesEmpresa.Text <> '') and
     (txDesCliente.Text <> '') and
     (deFechaFactura.Text <> '') then
  begin
    DFactura.PutFechaVencimiento( edtEmpresa.Text, edtCliente.Text, dFecha, dCobro, dTeso );
    edtNumFacINi.Text:= '';
    QCabFactura.FieldByName('fecha_fac_ini_fc').AsDateTime := dFecha;
    if dePrevisionCobro.Text = ''  then
      QCabFactura.FieldByName('prevision_cobro_fc').AsDateTime := dCobro;
    if dePrevisionTeso.Text = '' then
      QCabFactura.FieldByName('prevision_tesoreria_fc').AsDateTime := dTeso;
  end;
end;

procedure TFAltaFacturas.edtMonedaPropertiesChange(Sender: TObject);
begin
  txDesMoneda.Text := desMoneda(edtMoneda.Text);
end;

procedure TFAltaFacturas.edtImpuestoPropertiesChange(Sender: TObject);
begin
   txDesImpuesto.Text := DesImpuesto(edtImpuesto.Text);
{
  (*FACTA�OS*)
  if deFechaFactura.Text = '' then
      deFechaFactura.Text:= DateToStr( Date );

  if DFactura.GetPorcentajeIva( txEmpresa.Text, edtcliente.Text, edtimpuesto.Text, StrToDateDef( deFechaFactura.Text, Now ), rPorcentajeImpuesto ) then
  begin
    rImporteNetoAux:= StrToFloatDEf( eImporteNeto.Text, 0 );
    rImporteIvaAux:= bRoundTo( ( rImporteNetoAux * rPorcentajeImpuesto ) / 100, -2 );
    rImporteTotalAux:= rImporteNetoAux + rImporteIvaAux;
    if rPorcentajeImpuesto <> 0 then
      ePorcentajeImpuesto.Text:= FormatFloat( '#0.00', rPorcentajeImpuesto )
    else
      ePorcentajeImpuesto.Text:= '0';
    if rImporteIvaAux <> 0 then
      eImporteImpuesto.Text:= FormatFloat( '#0.00', rImporteIvaAux )
    else
      eImporteImpuesto.Text:= '0';
    if rImporteTotalAux <> 0 then
      eImporteTotal.Text:= FormatFloat( '#0.00', rImporteTotalAux )
    else
      eImporteTotal.Text:= '0';
  end;
}
end;

procedure TFAltaFacturas.BorrarLinea;
begin
  QDetFactura.Delete(False);
  bFacturaModificada := True;
  btnGrabarFactura.Enabled := bFacturaModificada and (QDetFactura.RecordCount > 0);

  if QDetFactura.RecordCount = 0 then
  begin
    //btnGrabarFactura.Enabled := false;
    //ActivarCabecera(True);
    ActivarPanelCabecera(True);
    QCabFactura.Edit;
    edtEmpresa.SetFocus;
  end;
end;

procedure TFAltaFacturas.rgTipoFacPropertiesChange(Sender: TObject);
begin
  if rgTipoFactura.ItemIndex <> -1 then
  begin
    if rgTipoFactura.Properties.Items[rgTipoFactura.ItemIndex].Value = '381' then
    begin
      lbFechaFactura.Caption := 'Fecha Abono';
      lbNumeroFactura.Caption:= 'Numero Abono';
      edtNumeroFactura.Style.Font.Color:= clRed;
    end
    else
    begin
      lbFechaFactura.Caption := 'Fecha Factura';
      lbNumeroFactura.Caption:= 'Numero Factura';
      edtNumeroFactura.Style.Font.Color:= clNavy;
    end;
  end;
  if deFechaFactura.Text = '' then
      deFechaFactura.Text:= DateToStr( Date );
end;

procedure TFAltaFacturas.cxPageControlEnter(Sender: TObject);
begin
  sTipoFactura := rgTipoFactura.Properties.Items[rgTipoFactura.ItemIndex].Value;
end;

procedure TFAltaFacturas.AsignarNumLinea;
var iNumLinea: integer;
begin
  QDetFactura.DisableControls;

  iNumLinea := 1;
  QDetFactura.First;
  while not QDetFactura.Eof do
  begin
    QDetFactura.Edit;
    QDetFactura.FieldByName('num_linea_fd').asInteger := iNumLinea;
    QDetFactura.Post(False);

    Inc(iNumLinea);
    QDetFactura.Next;
  end;

  QDetFactura.EnableControls;
end;

procedure TFAltaFacturas.AltaBasFactura(ARImpBases: TRImpBases);
var i, iTotal: integer;
begin

  EjecutaQueryBas;
  BorrarBases;
  i := 0;
  iTotal := Length(ARImpBases.aRImportes);
  while i < iTotal do
  begin
    QBasFactura.Append;

    if not bAlta then
      QBasFactura.FieldByName('cod_factura_fb').AsString := sClave;

    QBasFactura.FieldByName('tasa_impuesto_fb').AsInteger := ARImpBases.aRImportes[i].iTasaImpuesto;
    QBasFactura.FieldByName('porcentaje_impuesto_fb').AsFloat := ARImpBases.aRImportes[i].rPorcentajeImpuesto;
    QBasFactura.FieldByName('cajas_fb').AsInteger := ARImpBases.aRImportes[i].iCajas;
    QBasFactura.FieldByName('unidades_fb').AsInteger := ARImpBases.aRImportes[i].iUnidades;
    QBasFactura.FieldByName('kilos_fb').AsFloat := ARImpBases.aRImportes[i].rKilos;
    QBasFactura.FieldByName('importe_neto_fb').AsFloat := ARImpBases.aRImportes[i].rImporteNeto;
    QBasFactura.FieldByName('importe_impuesto_fb').AsFloat := ARImpBases.aRImportes[i].rImporteImpuesto;
    QBasFactura.FieldByName('importe_total_fb').AsFloat := ARImpBases.aRImportes[i].rImporteTotal;

    QBasFactura.Post(False);
    Inc(i);
  end;

end;

procedure TFAltaFacturas.cbFacturasPerdidasClick(Sender: TObject);
begin
  if cbFacturasPerdidas.Checked then
  begin
    txFactura.Enabled := True;
    txFactura.Style.LookAndFeel.NativeStyle := True;
    txFactura.Style.Color := clWindow;
    txFactura.SetFocus;
  end
  else
    begin
    txFactura.Enabled := False;
    txFactura.Text := '';
    txFactura.Style.LookAndFeel.NativeStyle := False;
    txFactura.Style.Color := clBtnFace;
    end;
end;

procedure TFAltaFacturas.pnlAltaLineasEnter(Sender: TObject);
begin
  tsTextoFactura.Enabled := false;
  cxDetalle.Enabled := false;
end;

procedure TFAltaFacturas.pnlAltaLineasExit(Sender: TObject);
begin
  tsTextoFactura.Enabled := True;
  cxDetalle.Enabled := True;
end;

procedure TFAltaFacturas.ActualizarNotasFactura;
begin
  if not(QCabFactura.State in DsEditModes) then QCabFactura.Edit;

  QCabFactura.FieldByName('notas_fc').AsString := mmxNotas.Text;
  QCabFactura.Post(False);
end;

procedure TFAltaFacturas.BorrarBases;
begin
  QBasFactura.First;
  while not QBasFactura.Eof do
  begin
    QBasFactura.Delete(False);
    QBasFactura.Next;
  end;
end;

procedure TFAltaFacturas.RellenarDatosIni;
begin
  bPrimeraLin := true;
  cbFacturasPerdidas.Checked := False;
  txFactura.Text := '';
  txFactura.Enabled := False;
  pnlAltaLineas.Visible := false;
  cxPageControl.ActivePage := tsDetalleFactura;
end;

function TFAltaFacturas.CanFacturarFecha(AEmpresa, ADate, ASerie: string): Boolean;
  var
  iYear, iMonth, iDay: Word;
  QContador: TBonnyQuery;
begin
  Result := true;
  DecodeDate( StrToDateDef(ADate, Date), iYear, iMonth, iDay );
  if bFactPerdida then
  begin
    if ExisteFacturaPerdida(AEmpresa, ASerie, StrToInt(txFactura.Text), ADate) then
    begin
      ShowError('El n�mero de factura / abono indicado en el contador de facturas perdidas ya existe.');
      Result := false;
      exit;
    end;
    if ErrorFacturaPerdida(AEmpresa, ASerie, StrToInt(txFactura.Text), ADate,
                           Copy(edtImpuesto.Text,1,1),
                           rgTipoFactura.Properties.Items[rgTipoFactura.ItemIndex].Value ) then
    begin
      ShowError('El n�mero de factura / abono indicado en el contador de facturas perdidas es incorrecto. ');
      Result := false;
      exit;
    end;
    if not ValidarFecFactPerdidas(AEmpresa, ASerie, StrToInt(txFactura.Text), ADate, Copy(edtImpuesto.Text,1,1),
                                  rgTipoFactura.Properties.Items[rgTipoFactura.ItemIndex].Value) then
    begin
      ShowError('La fecha "Fecha Factura" es incorrecta para el contador de facturas / abonos perdidos.');
      Result := false;
      exit;
    end;
  end
  else if Copy(edtImpuesto.Text,1,1) = 'I' then
  begin
    QContador := TBonnyQuery.Create(Self);
    with QContador do
    try
      SQL.Add(' SELECT fecha_fac_iva_fs, fecha_abn_iva_fs, serie_cerrada_fs ');
      SQL.Add('   FROM frf_facturas_serie ');
      SQL.Add('    join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ');
      SQL.Add('  WHERE cod_empresa_es = :empresa ');
      SQL.Add('    and anyo_es = :anyo ');
      SQL.Add('    and cod_serie_es = :serie ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('anyo').AsInteger := iYear;
      ParamByName('serie').AsString := ASerie;
      Open;

      if FieldByName('serie_cerrada_fs').AsInteger = 1 then
      begin
        ShowError('La serie de facturaci�n del a�o ' + IntToStr( iYear ) + ' ya esta cerrada.');
        Close;
        Result := false;
        Exit;
      end;

      if rgTipoFactura.Properties.Items[rgTipoFactura.ItemIndex].Value = '380' then
      begin
        if FieldByName('fecha_fac_iva_fs').AsDateTime > StrToDate(ADate) then
        begin
          ShowError('La fecha de facturaci�n es incorrecta para la serie de IVA.');
          Close;
          Result := false;
          Exit;
        end;
      end
      else
      begin
        if FieldByName('fecha_abn_iva_fs').AsDateTime > StrToDate(ADate) then
        begin
          ShowError('La fecha de abono es incorrecta para la serie de IVA.');
          Close;
          Result := false;
          Exit;
        end;
      end;
    finally
      Free;
    end
  end
  else if Copy(edtImpuesto.Text,1,1) = 'G' then
  begin
    QContador := TBonnyQuery.Create(Self);
    with QContador do
    try
      SQL.Add(' SELECT fecha_fac_igic_fs, fecha_abn_igic_fs, serie_cerrada_fs ');
      SQL.Add('   FROM frf_facturas_serie ');
      SQL.Add('    join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ');
      SQL.Add('  WHERE cod_empresa_es = :empresa ');
      SQL.Add('    and anyo_es = :anyo ');
      SQL.Add('    and cod_serie_es = :serie ');

      ParamByName('empresa').AsString := Aempresa;
      ParamByName('anyo').AsInteger := iYear;
      ParamByName('serie').AsString := ASerie;
      Open;

      if FieldByName('serie_cerrada_fs').AsInteger = 1 then
      begin
        ShowError('La serie de facturaci�n del a�o ' + IntToStr( iYear ) + ' ya esta cerrada.');
        Close;
        Result := false;
        Exit;
      end;

      if rgTipoFactura.Properties.Items[rgTipoFactura.ItemIndex].Value = '380' then
      begin
        if FieldByName('fecha_fac_igic_fs').AsDateTime > StrToDate(ADate) then
        begin
          ShowError('La fecha de facturaci�n es incorrecta para la serie de IGIC.');
          Close;
          Result := false;
          Exit;
        end;
      end
      else
      begin
        if FieldByName('fecha_abn_igic_fs').AsDateTime >
          StrToDate(ADate) then
        begin
          ShowError('La fecha de abono es incorrecta para la serie de IGIC.');
          Close;
          Result := false;
          Exit;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFAltaFacturas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseQuerys([QDatosInco, QDatosAlb, QAlbaran, QLineasAlb, QCabeceraAlb]);
end;

procedure TFAltaFacturas.ssCenSalidaAntesEjecutar(Sender: TObject);
begin
  ssCenSalida.SQLAdi := ' empresa_c = ' + QuotedStr(edtEmpAlbaran.Text);
end;

procedure TFAltaFacturas.ssEnvaseAntesEjecutar(Sender: TObject);
begin
  ssEnvase.SQLAdi := 'cliente_ce = ' + QuotedStr(edtCliente.Text) +
                   ' and producto_p = ' + QuotedStr(edtProducto.Text);
end;

procedure TFAltaFacturas.ssProductoAntesEjecutar(Sender: TObject);
begin
  ssProducto.SQLAdi := ' fecha_baja_p is null and tipo_venta_p = ''S'' ';
end;

procedure TFAltaFacturas.ssSerieAntesEjecutar(Sender: TObject);
begin
    ssSerie.SQLAdi := '';
    ssSerie.SQLAdi := ' anyo_es >= year(today) -1 ';
    if edtEmpresa.Text <> '' then
      ssSerie.SQLAdi := ssSerie.SQLAdi + ' and cod_empresa_es = ' +  QuotedStr(edtEmpresa.Text);
end;

procedure TFAltaFacturas.ssCategoriaAntesEjecutar(Sender: TObject);
begin
  ssCategoria.SQLAdi := ' producto_c = ' + QuotedStr(edtProducto.Text);
end;

end.
