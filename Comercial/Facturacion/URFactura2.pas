
unit URFactura2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, UDFactura, DB, kbmMemTable, BonnyQuery, uSalidaUtils;

type
  TRFactura2 = class(TQuickRep)
    BonnyBand: TQRBand;
    PiePagina: TQRBand;
    QRImageCab: TQRImage;
    PsEmpresa: TQRLabel;
    PsNif: TQRLabel;
    PsDireccion: TQRLabel;
    ChildBand3: TQRChildBand;
    CabeceraFactura2: TQRChildBand;
    HojaNum: TQRLabel;
    sigue: TQRLabel;
    psEtiqueta: TQRLabel;
    qrmResponsabilidadEnvase: TQRMemo;
    CabeceraFactura: TQRGroup;
    qrgCabAlbaran: TQRGroup;
    BandaLinea: TQRSubDetail;
    Pedido: TQRLabel;
    PrecioUnidad: TQRDBText;
    cajas: TQRLabel;
    Unidad: TQRDBText;
    precio_neto_tf: TQRDBText;
    lin5: TQRShape;
    lin6: TQRShape;
    lin7: TQRShape;
    lin8: TQRShape;
    Albaran: TQRDBText;
    Producto: TQRLabel;
    Envase: TQRLabel;
    qretipo_iva_tf: TQRDBText;
    qrsVat: TQRShape;
    BandaTotales: TQRBand;
    qrlDesIva: TQRLabel;
    qrlDesIvaAlemania: TQRLabel;
    rlin: TQRShape;
    plin: TQRLabel;
    QRMemoPago: TQRMemo;
    BandaErrorCopia: TQRChildBand;
    qrlErrofactura: TQRLabel;
    BandaNotas: TQRChildBand;
    qrlObservacionFactura: TQRLabel;
    BandaObservaciones: TQRChildBand;
    qrlAseguradora: TQRLabel;
    mmoClienteObv: TQRMemo;
    CabeceraGastos: TQRChildBand;
    PsQRLabel7: TQRLabel;
    PsQRShape10: TQRShape;
    PsQRShape13: TQRShape;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    PsQRLabel21: TQRLabel;
    PsQRLabel24: TQRLabel;
    Descriptiom: TQRLabel;
    CabeceraLinea: TQRChildBand;
    qrlAlbaran: TQRLabel;
    qrlProducto: TQRLabel;
    qrlCantidad: TQRLabel;
    qrlUnidad: TQRLabel;
    qrlPrecio: TQRLabel;
    qrlImporte: TQRLabel;
    l1: TQRShape;
    l5: TQRShape;
    l2: TQRShape;
    l3: TQRShape;
    l4: TQRShape;
    qrlAlbaran2: TQRLabel;
    qrlImporte2: TQRLabel;
    qrlProducto2: TQRLabel;
    qrlCantidad2: TQRLabel;
    qrlUnidad2: TQRLabel;
    qrlPrecio2: TQRLabel;
    qrlConcepto: TQRLabel;
    qrlConcepto2: TQRLabel;
    qrlPorIva: TQRLabel;
    qrlPorIva2: TQRLabel;
    qrsVatCab2: TQRShape;
    CabeceraTabla: TQRChildBand;
    PsQRShape29: TQRShape;
    PsQRShape33: TQRShape;
    PsQRShape34: TQRShape;
    PsQRShape35: TQRShape;
    PsQRShape36: TQRShape;
    PsQRLabel22: TQRLabel;
    PsQRLabel23: TQRLabel;
    PsQRLabel27: TQRLabel;
    PsQRLabel28: TQRLabel;
    PsQRLabel29: TQRLabel;
    qrlImp1: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRLabel15: TQRLabel;
    PsQRLabel17: TQRLabel;
    PsQRLabel18: TQRLabel;
    PsQRLabel19: TQRLabel;
    qrlImp2: TQRLabel;
    qrlIva1: TQRLabel;
    qrlVAT1: TQRLabel;
    qrsCabVat: TQRShape;
    bndEurosKg: TQRSubDetail;
    PsQRShape11: TQRShape;
    PsQRShape12: TQRShape;
    qrsVat2: TQRShape;
    QRChildBand1: TQRChildBand;
    PsQRShape8: TQRShape;
    qrlblBase: TQRLabel;
    qrlblIVA: TQRLabel;
    qrlblTotal: TQRLabel;
    qsBase1: TQRShape;
    qsIva1: TQRShape;
    qsTotal1: TQRShape;
    qsBase2: TQRShape;
    qsIva2: TQRShape;
    qsTotal2: TQRShape;
    qsBase0: TQRShape;
    qsIva0: TQRShape;
    qsTotal0: TQRShape;
    qrshpTotal1: TQRShape;
    qrshpTotal2: TQRShape;
    qrshpTotal3: TQRShape;
    qrlblTotalBase: TQRLabel;
    qrlblTotalIva: TQRLabel;
    qrlblTotalTotal: TQRLabel;
    qrlblTotalLabel: TQRLabel;
    qlLabel0: TQRLabel;
    qlBase0: TQRLabel;
    qlIva0: TQRLabel;
    qlTotal0: TQRLabel;
    qlLabel1: TQRLabel;
    qlBase1: TQRLabel;
    qlIva1: TQRLabel;
    qlTotal1: TQRLabel;
    qlLabel2: TQRLabel;
    qlBase2: TQRLabel;
    qlIva2: TQRLabel;
    qlTotal2: TQRLabel;
    qrlblLabel: TQRLabel;
    bndComision: TQRSubDetail;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    bndDescuento: TQRSubDetail;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape11: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    qrLabelTotEur: TQRLabel;
    qrshpTotalEur1: TQRShape;
    qrTotalBaseEur: TQRLabel;
    qrshpTotalEur2: TQRShape;
    qrTotalIvaEur: TQRLabel;
    qrshpTotalEur3: TQRShape;
    qrTotalEur: TQRLabel;
    imgQRImgLogo: TQRImage;
    qrmGarantia: TQRMemo;
    BandaGastos: TQRSubDetail;
    qs1: TQRShape;
    qs2: TQRShape;
    qs3: TQRShape;
    n_albaran_fg: TQRDBText;
    lbl2: TQRLabel;
    fecha_albaran_fg: TQRDBText;
    des_tipo_gasto_fg: TQRDBText;
    importe_neto_fg: TQRDBText;
    porcentaje_impuesto_fg: TQRDBText;
    bndDescuentoComision: TQRChildBand;
    lblDescuento: TQRLabel;
    lblDescuentoUK: TQRLabel;
    descuento_imp_base: TQRDBText;
    descuento_importe: TQRDBText;
    lblComision: TQRLabel;
    lblComisionUK: TQRLabel;
    comision_imp_base: TQRDBText;
    comision_importe: TQRDBText;
    lblEurosKg: TQRLabel;
    total_kilos: TQRDBText;
    euroskg_importe: TQRDBText;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    qrShape9: TQRShape;
    porcentaje: TQRDBText;
    bndPieAlbaran: TQRBand;
    qrsCostePlataforma1: TQRShape;
    qrsCostePlataforma2: TQRShape;
    qrsCostePlataforma3: TQRShape;
    qrsCostePlataforma4: TQRShape;
    qrlCostePlataforma: TQRLabel;
    qrlKilosPlataforma: TQRLabel;
    qrlUnidadPlataforma: TQRLabel;
    qrsCostePlataforma5: TQRShape;
    qrchldbndChildBand1: TQRChildBand;
    qrm1: TQRMemo;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    posei: TQRDBText;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape19: TQRShape;
    QRShape17: TQRShape;
    LabelFecha: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel8: TQRLabel;
    Date: TQRLabel;
    PsQRLabel25: TQRLabel;
    PsQRLabel37: TQRLabel;
    lblNumFactura: TQRLabel;
    QRLabel10: TQRLabel;
    PsQRShape1: TQRShape;
    qrsIncoterm2: TQRShape;
    qlDesPais: TQRDBText;
    qlCodPostal: TQRDBText;
    qlPoblacion: TQRDBText;
    qlDomicilio: TQRDBText;
    qlTipoVia: TQRDBText;
    qlDesCliente: TQRDBText;
    LabelNif: TQRLabel;
    qlProvincia: TQRDBText;
    qrlblClienteOnline2: TQRLabel;
    qrlIncotermLabel2: TQRLabel;
    qrlIncoterm2: TQRLabel;
    qrlEori2: TQRLabel;
    QRDirSum: TQRShape;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRDBText8: TQRDBText;
    PsQRShape21: TQRShape;
    qrsIncoterm1: TQRShape;
    qlDesPais2: TQRDBText;
    qlCodPostal2: TQRDBText;
    qlPoblacion2: TQRDBText;
    qlDomicilio2: TQRDBText;
    qlTipoVia2: TQRDBText;
    qlDesCliente2: TQRDBText;
    labelNif2: TQRLabel;
    qlProvincia2: TQRDBText;
    qrlblClienteOnline1: TQRLabel;
    qrlIncoterm1: TQRLabel;
    qrlIncotermLabel1: TQRLabel;
    qrlEori1: TQRLabel;
    QRDirSum2: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRShape10: TQRShape;
    QRShape20: TQRShape;
    LFecha2: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    lblNumFactura2: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    procedure BonnyBandBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabeceraFactura2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure CabeceraLineaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabeceraFactura2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabeceraFacturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabeceraFacturaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrgCabAlbaranBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaLineaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaLineaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure CabeceraGastosAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndDescuentoComisionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDescuentoComisionAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaTotalesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaTotalesAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaErrorCopiaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaNotasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaObservacionesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PiePaginaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepStartPage(Sender: TCustomQuickRep);
    procedure LabelFechaPrint(sender: TObject; var Value: String);
    procedure LFecha2Print(sender: TObject; var Value: String);
    procedure AlbaranPrint(sender: TObject; var Value: String);
    procedure PedidoPrint(sender: TObject; var Value: String);
    procedure ValoresTotales( const AIndice: Integer; AFlag: Boolean );
    procedure ValoresTotalesEur( const AIndice: Integer; AFlag: Boolean );
    procedure CabeceraTotales( const AIndice: Integer; AFlag: Boolean );
    procedure QuickRepAfterPrint(Sender: TObject);
    procedure bndComisionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDescuentoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndComisionAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndDescuentoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure HojaNumPrint(sender: TObject; var Value: String);
    procedure plinPrint(sender: TObject; var Value: String);
    procedure DescriptiomPrint(sender: TObject; var Value: String);
    procedure PsQRLabel33Print(sender: TObject; var Value: String);
    procedure PsQRLabel36Print(sender: TObject; var Value: String);
    procedure PsQRLabel34Print(sender: TObject; var Value: String);
    procedure PsQRLabel35Print(sender: TObject; var Value: String);
    procedure qrlAlbaran2Print(sender: TObject; var Value: String);
    procedure qrlProducto2Print(sender: TObject; var Value: String);
    procedure qrlCantidad2Print(sender: TObject; var Value: String);
    procedure qrlUnidad2Print(sender: TObject; var Value: String);
    procedure qrlPrecio2Print(sender: TObject; var Value: String);
    procedure qrlImporte2Print(sender: TObject; var Value: String);
    procedure bndEurosKgBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndEurosKgAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndPieAlbaranBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrchldbndChildBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure ProductoPrint(sender: TObject; var Value: string);
    procedure CabeceraGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);


  private
    bHayGranadaEco: Boolean;
    sEmpresa: String;
    AlbaranNum: Integer;
    AlbaranGasto: Integer;
    FacturaNum: Integer;
    FacturaCod: String;

    Detalles: Integer;
    DetallesGasto : Integer;
    DetallesComision: Integer;
    DetallesDescuento: Integer;
    DetallesEurosKg: Integer;

    bImpresoDescuento: boolean;
    bFlagIVA: Boolean;

    Hoja: Integer;
    NumeroHoja: Integer;
    Bandas: Integer;

    mtComisiones: TkbmMemTable;
    mtDescuentos: TkbmMemTable;
    mtEurosKg: TkbmMemTable;

    QGrupoSAT: TBonnyQuery;

    RImportesCabecera: TRImportesCabecera;
    FQueryCliente: TBonnyQuery;
    FQueryEmpresa: TBonnyQuery;



    function Unidades(cad: string): string;
    function CambioFacturacion: Boolean;
    procedure ConfigurarGastosYDescuentos;
    procedure ConfiguracionCuadroTotales;
    procedure PonProducto;
    procedure CuadroFormaPago;
    procedure ConfiguraIVA(const AFlag: Boolean);
    procedure AsignarTemporales;
    procedure DesactivarBases;
    procedure ActivarBases;
    procedure CreaQGrupoSAT;
    function  EsGrupoSAT: boolean;
    function  GetKilosNeto(const ACodFactura, AEmpresa, ASerie: string; const AFactura: integer; const Afecha: TDateTime ): Real;
    function AsuntoFactura: string;
    function UnicaDirSuministro: boolean;

  public
    bCopia, definitivo, printEmpresa, printOriginal, bProforma: Boolean;
    salto: Integer;
    bBruto: boolean;
    rGGN : TGGN;
    bEnEspanyol: Boolean;
    
    procedure Configurar(const AEmpresa, ACliente: string);
    procedure Prepara_Visualizacion;
    constructor Create(AOwner: TComponent); override;

  end;

var
  RFactura2: TRFactura2;

implementation

uses bMath, CFactura, UDMAuxDB, bSQLUtils, CVariables, bTextUtils, CGlobal, DConfigMail, DPreview,
  UDMConfig, UFConstantesFacturacion;

{$R *.DFM}

constructor TRFactura2.Create(AOwner: TComponent);
begin
  inherited;
  definitivo := False;
  bProforma:= False;
  printEmpresa := True;
  printOriginal := True;
  bCopia := false;

  CreaQGrupoSAT;
  FQueryCliente := TBonnyQuery.Create(Self);
  FQueryCliente.SQL.Add('select es_comunitario_c, tipo_albaran_c, eori_cliente_c from frf_clientes where cliente_c = :cliente_c');

  FQueryEmpresa := TBonnyQuery.Create(Self);
  FQueryEmpresa.SQL.Add('select num_exp_autorizado_e from frf_empresas where empresa_e = :empresa_e');
end;

procedure TRFactura2.BonnyBandBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Hoja = 1 then
  begin
    CabeceraFactura2.Enabled := false;
    CabeceraLinea.Enabled := false;
    ChildBand3.Enabled := false;
  end
  else
  begin
    CabeceraFactura2.Enabled := true;
    CabeceraLinea.Enabled := true;
    ChildBand3.Enabled := true;
  end;

  if DFactura.mtFacturas_Cab2.fieldbyname('cod_cliente_fc').AsString = 'WEB' then
  begin
    qrsIncoterm2.Enabled := true;
    qrlblClienteOnline2.Enabled := true;
    qrlIncotermLabel2.Enabled := false;
    qrlIncoterm2.Enabled := false;

    qrsIncoterm1.Enabled := qrsIncoterm2.Enabled;
    qrlblClienteOnline1.Enabled := qrlblClienteOnline2.Enabled;
    qrlIncotermLabel1.Enabled := qrlIncotermLabel2.Enabled;
    qrlIncoterm1.Enabled := qrlIncoterm2.Enabled;
    //Logo Bonnysa
    if DFactura.mtFacturas_Cab2.FieldByName('fecha_factura_fc').AsDateTime >= StrToDate('01/07/2020') then
    begin
      if FileExists( gsDirActual + '\recursos\LogoGrupoBonnysa.jpg') then
      begin
        imgQRImgLogo.Height := 60;
        imgQRImgLogo.Top := -13;
        imgQRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\LogoGrupoBonnysa.jpg');
      end
    end
    else
    begin
      imgQRImgLogo.Height := 95;
      imgQRImgLogo.Top := -21;

      if FileExists( gsDirActual + '\recursos\LogoBongranade.jpg') then
      begin
        imgQRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\LogoBongranade.jpg');
      end
      else
      if FileExists( gsDirActual + '\recursos\BongranadeSanflavino.jpg') then
      begin
        imgQRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\BongranadeSanflavino.jpg');
      end
      else
      if FileExists( gsDirActual + '\recursos\Sanflavino.jpg') then
      begin
        imgQRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\Sanflavino.jpg');
      end;
    end;
  end
  else
  begin
     qrlblClienteOnline2.Enabled := false;
     qrlblClienteOnline1.Enabled := false;
    //Condicion de pago
    if DFactura.mtFacturas_Cab2.FieldByName('incoterm_fc').AsString <> '' then
    begin
      qrlIncoterm1.Enabled := true;
      qrlIncoterm2.Enabled := qrlIncoterm1.Enabled;
      qrlIncoterm1.Caption:= DFactura.mtFacturas_Cab2.FieldByName('incoterm_fc').AsString + ' ' +
                             DFactura.mtFacturas_Cab2.FieldByName('plaza_incoterm_fc').AsString;
      qrlIncoterm2.Caption:= qrlIncoterm1.Caption;
      qrsIncoterm1.Enabled:= qrlIncoterm2.Caption <> '';
      qrsIncoterm2.Enabled:= qrsIncoterm1.Enabled;
      qrlIncotermLabel1.Enabled:= qrsIncoterm1.Enabled;
      qrlIncotermLabel2.Enabled:= qrsIncoterm1.Enabled;
    end
    else
    begin
      qrlIncoterm1.Enabled:= False;
      qrlIncoterm2.Enabled:= qrlIncoterm1.Enabled;
      qrsIncoterm1.Enabled:= qrlIncoterm1.Enabled;
      qrsIncoterm2.Enabled:= qrsIncoterm1.Enabled;
      qrlIncotermLabel1.Enabled:= qrsIncoterm1.Enabled;
      qrlIncotermLabel2.Enabled:= qrsIncoterm1.Enabled;
    end;
  end;
end;

procedure TRFactura2.CabeceraFactura2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Inc(NumeroHoja);
end;

procedure TRFactura2.CabeceraLineaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if detalles >= 0 then
  begin
    CabeceraLinea.Color := cl3DLight;
    qrlAlbaran.Enabled := true;
    qrlProducto.Enabled := true;
    qrlConcepto.Enabled := false;
    qrlCantidad.Enabled := true;
    qrlPrecio.Enabled := true;
    qrlImporte.Enabled := true;
    qrlImporte2.Enabled := true;
    qrlUnidad.Enabled := true;
    qrlAlbaran2.Enabled := true;
    qrlProducto2.Enabled := true;
    qrlConcepto2.Enabled := false;
    qrlCantidad2.Enabled := true;
    qrlPrecio2.Enabled := true;
//    qrlPorIva.Enabled := true;
//    qrlPorIva2.Enabled := true;
    qrlUnidad2.Enabled := true;
    qrsCabVat.Enabled:= True;
//    qrsVatCab2.Enabled:= True;

    l1.Enabled := true;
    l5.Enabled := true;
    l2.Enabled := true;
    l3.Enabled := true;
    l4.Enabled := true;
  end
  else
    if (detallesgasto >= 0) or (not bImpresoDescuento) then
    begin
      CabeceraLinea.Color := cl3DLight;
      qrlAlbaran.Enabled := true;
      qrlProducto.Enabled := false;
      qrlConcepto.Enabled := true;
      qrlCantidad.Enabled := false;
      qrlPrecio.Enabled := false;
      qrlImporte.Enabled := true;
      qrlImporte2.Enabled := true;
      qrlUnidad.Enabled := false;
      qrlAlbaran2.Enabled := true;
      qrlProducto2.Enabled := false;
      qrlConcepto2.Enabled := true;
      qrlCantidad2.Enabled := false;
      qrlPrecio2.Enabled := false;
//      qrlPorIva.Enabled := true;
//      qrlPorIva2.Enabled := true;
      qrsCabVat.Enabled:= True;
//      qrsVatCab2.Enabled:= True;
      qrlUnidad2.Enabled := false;
      l1.Enabled := true;
      l5.Enabled := false;
      l2.Enabled := false;
      l3.Enabled := False;
      l4.Enabled := true;
    end
    else
    begin
      CabeceraLinea.Color := clWhite;
      qrlAlbaran.Enabled := false;
      qrlProducto.Enabled := false;
      qrlConcepto.Enabled := false;
      qrlCantidad.Enabled := false;
      qrlPrecio.Enabled := false;
      qrlImporte.Enabled := False;
      qrlImporte2.Enabled := False;
      qrlUnidad.Enabled := false;
      qrlAlbaran2.Enabled := false;
      qrlProducto2.Enabled := false;
      qrlConcepto2.Enabled := false;
      qrlCantidad2.Enabled := false;
      qrlPrecio2.Enabled := false;
//      qrlPorIva.Enabled := False;
//      qrlPorIva2.Enabled := False;
      qrsCabVat.Enabled:= False;
//      qrsVatCab2.Enabled:= False;
      qrlUnidad2.Enabled := false;
      l1.Enabled := false;
      l5.Enabled := false;
      l2.Enabled := false;
      l3.Enabled := false;
      l4.Enabled := false;
    end;
end;

procedure TRFactura2.CabeceraFactura2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  eori: String;
begin
  Prepara_Visualizacion;

{
  if DataSet.FieldByName('cta_cliente_fc').AsString = 'MONOPRIX' then
  begin
    qrlblPlataforma2.enabled:= True;
    qrlblPlataforma2.Top:= 28;
    qrlblPlataforma2.Left:= 373;
    qrlblPlataforma2.Width:= 300;
    qrlblPlataforma2.Caption:= desSuministro(   BandaLinea.DataSet.FieldByName('cod_empresa_albaran_fd').asString,
                             BandaLinea.DataSet.FieldByName('cod_cliente_albaran_fd').asString,
                             BandaLinea.DataSet.FieldByName('cod_dir_sum_fd').asString );
    qlDesCliente2.Top:= 48;
    qlTipoVia2.Top:= 67;
    qlDomicilio2.Top:= 67;
    qlPoblacion2.Top:= 86;
    qlCodPostal2.Enabled:= False;
    qlCodPostal2.Enabled:= False;
    qlProvincia2.Enabled:= False;
  end
  else
  begin
    qrlblPlataforma2.Enabled:= False;
  end;
}
  qlProvincia2.Enabled := qlProvincia.Enabled;
  qlDomicilio2.Left := qlDomicilio.Left;
  labelNif2.Caption := LabelNif.Caption;

  if FQueryCliente.Active then
    FQueryCliente.Close;
  FQueryCliente.ParamByName('cliente_c').asString := DFactura.mtFacturas_Cab.FieldByName('cod_cliente_fc').asString;
  FQueryCliente.Open;
  eori := FQueryCliente.FieldByName('eori_cliente_c').asString;
  if eori <> '' then
    qrlEori1.Caption := Format('EORI: %s', [ eori ])
  else
    qrlEori1.Caption := '';
  if UnicaDirSuministro then
  begin
    QRDirSum.Enabled := true;
    QRLabel13.Enabled := true;
    QRDBText13.Enabled := true;
    QRDBText12.Enabled := true;
    QRDBText11.Enabled := true;
    QRDBText10.Enabled := true;
    QRDBText9.Enabled := true;
    QRDBText14.Enabled := true;
    QRDBText8.Enabled := true;

    QRDirSum2.Enabled := true;
    QRLabel23.Enabled := true;
    QRDBText6.Enabled := true;
    QRDBText5.Enabled := true;
    QRDBText4.Enabled := true;
    QRDBText3.Enabled := true;
    QRDBText2.Enabled := true;
    QRDBText7.Enabled := true;
    QRDBText1.Enabled := true;

  end
  else
  begin
    QRDirSum.Enabled := false;
    QRLabel13.Enabled := false;
    QRDBText13.Enabled := false;
    QRDBText12.Enabled := false;
    QRDBText11.Enabled := false;
    QRDBText10.Enabled := false;
    QRDBText9.Enabled := false;
    QRDBText14.Enabled := false;
    QRDBText8.Enabled := false;

    QRDirSum2.Enabled := false;
    QRLabel23.Enabled := false;
    QRDBText6.Enabled := false;
    QRDBText5.Enabled := false;
    QRDBText4.Enabled := false;
    QRDBText3.Enabled := false;
    QRDBText2.Enabled := false;
    QRDBText7.Enabled := false;
    QRDBText1.Enabled := false;

  end;
end;

function CompletaNif( const APais, ANif: string ): string;
begin
  if Pos( APais, ANif ) = 0 then
    Result:= APais + ANif
  else
    Result:= ANif;
end;


procedure TRFactura2.CabeceraFacturaBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i:Integer;
  eori: String;
begin

  Prepara_Visualizacion;

  DFactura.mtFacturas_Bas2.Filter := '';
  DFactura.mtFacturas_Bas2.Filtered := False;

  mtComisiones.Close;
  mtDescuentos.Close;
  mtEurosKg.Close;



     //Etiquetas de la cabecera, hasta la siguiente factura no cambia
     //el valor que tienen asignado
  if FacturaCod <> DFactura.mtFacturas_Cab2.FieldByName('cod_factura_fc').AsString then
  begin
    FacturaCod := DFactura.mtFacturas_Cab2.FieldByName('cod_factura_fc').AsString;

    RImportesCabecera:= DatosTotalDescuento2( DFactura.mtFacturas_Cab2.FieldByName('cod_factura_fc').AsString );

    DFactura.mtFacturas_Bas2.Filter := ' cod_factura_fb = ' + QuotedStr(DFactura.mtFacturas_Cab2.FieldByName('cod_factura_fc').AsString);
    DFactura.mtFacturas_Bas2.Filtered := True;

    bImpresoDescuento :=  (Length(RImportesCabecera.aRImportesComision) = 0 ) and
                          (Length(RImportesCabecera.aRImportesDescuento) = 0) and
                          (Length(RImportesCabecera.aRImportesEurosKg) = 0);

    DesactivarBases;
      ///Carga Importes Comisiones
    mtComisiones.Open;
    i:=0;
    while i<Length(RImportesCabecera.aRImportesComision) do
    begin
      mtComisiones.Append;
      mtComisiones.fieldbyname('porcentaje').AsFloat := RImportesCabecera.ARImportesComision[i].rPorcentaje;
      mtComisiones.fieldbyname('imp_base').AsFloat := RImportesCabecera.aRImportesComision[i].rImporteBase;
      mtComisiones.fieldbyname('imp_comision').AsFloat := RImportesCabecera.aRImportesComision[i].rTotalImporte;
      mtComisiones.Post;

      Inc(i);
    end;

      ///Carga Importes Descuentos
    mtDescuentos.Open;
    i:=0;
    while i<Length(RImportesCabecera.ARImportesDescuento) do
    begin
      mtDescuentos.Append;
      mtDescuentos.fieldbyname('porcentaje').AsFloat := RImportesCabecera.ARImportesDescuento[i].rPorcentaje;
      mtDescuentos.fieldbyname('imp_base').AsFloat := RImportesCabecera.ARImportesDescuento[i].rImporteBase;
      mtDescuentos.fieldbyname('imp_descuento').AsFloat := RImportesCabecera.ARImportesDescuento[i].rTotalImporte;
      mtDescuentos.Post;

      Inc(i);
    end;

    ///Carga Importes EurosKg
    mtEurosKg.Open;
    i:=0;
    while i<Length(RImportesCabecera.ARImportesEurosKg) do
    begin
      mtEurosKg.Append;
      mtEurosKg.fieldbyname('porcentaje').AsFloat := RImportesCabecera.aRImportesEurosKg[i].rPorcentaje;
      mtEurosKg.fieldbyname('total_kilos').AsFloat := RImportesCabecera.aRImportesEurosKg[i].rImporteBase;
      mtEurosKg.fieldbyname('importe_euroskg').AsFloat := RImportesCabecera.aRImportesEurosKg[i].rTotalImporte;
      mtEurosKg.Post;

      Inc(i);
    end;

    bFlagIVA:= (DFactura.mtFacturas_Bas2.RecordCount = 1) and
               (DFactura.mtFacturas_Bas2.FieldByName('porcentaje_impuesto_fb').AsFloat = 0);
    if bFlagIVA then
    begin
      qrlIva1.Enabled:= False;
      qrlVat1.Enabled:= False;
      qrlPorIva.Enabled:= False;
      qrlPorIva2.Enabled:= False;
      qrsVatCab2.Enabled := False;
      qretipo_iva_tf.Enabled:= False;
      qrsCabVat.Enabled:= false;
      precio_neto_tf.Width:=105;
      precio_neto_tf.Left:=605;
      qrsVat.Enabled:= False;
      qrsVat2.Enabled:= False;
      qrLabel1.Enabled := false;
      qrLabel2.Enabled := false;
      qrShape11.Enabled := false;
      qrsVat2.Enabled := false;
      qrShape3.Enabled := false;
      qrShape6.Enabled := false;
      porcentaje_impuesto_fg.enabled := false;
      qrShape9.Enabled := false;
      comision_importe.Width := 105;
      comision_importe.Left := 605;
      descuento_importe.Width := 105;
      descuento_importe.Left := 605;
      euroskg_importe.Width := 105;
      euroskg_importe.Left := 605;
      importe_neto_fg.Width := 105;
      importe_neto_fg.Left := 605;
    end
    else
    begin
      qrlIva1.Enabled:= True;
      qrlVat1.Enabled:= True;
      qrlPorIva.Enabled:= True;
      qrlPorIva2.Enabled:= True;
      qrsVatCab2.Enabled := True;
      qretipo_iva_tf.Enabled:= True;
      qrsCabVat.Enabled:= True;
      precio_neto_tf.Width:=83;
      precio_neto_tf.Left:=605;
      qrsVat.Enabled:= True;
      qrsVat2.Enabled:= True;
      qrLabel1.Enabled := True;
      qrLabel2.Enabled := True;
      qrShape11.Enabled := True;
      qrsVat2.Enabled := True;
      qrShape3.Enabled := True;
      qrShape6.Enabled := True;
      porcentaje_impuesto_fg.enabled := True;
      qrShape9.Enabled := True;
      comision_importe.Width := 83;
      comision_importe.Left := 605;
      descuento_importe.Width := 83;
      descuento_importe.Left := 605;
      euroskg_importe.Width := 83;
      euroskg_importe.Left := 605;
      importe_neto_fg.Width := 83;
      importe_neto_fg.Left := 605;
    end;

    Detalles := DFactura.mtFacturas_Det2.RecordCount;
    if Trim(qlProvincia.DataSet.FieldByName('provincia_fc').AsString) <> '' then
      qlProvincia.Enabled := true
    else
      qlProvincia.Enabled := false;

    if Trim(DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString) = 'ESPA�A' then
    begin
      LabelNif.Caption := 'C.I.F. : ' +
        self.DataSet.FieldByName('nif_fc').AsString;

    end
    else
    begin
      if DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').AsString = 'Q&P'then      //Peticion Carolina Madrona 20/01/2020
        LabelNif.Caption := 'V.A.T. : ' + self.DataSet.FieldByName('nif_fc').AsString
      else
        LabelNif.Caption := 'V.A.T. : ' + CompletaNif( self.DataSet.FieldByName('cod_pais_fc').AsString, self.DataSet.FieldByName('nif_fc').AsString );
    end;
  end;


{
  if DataSet.FieldByName('cta_cliente_fc').AsString = 'MONOPRIX' then
  begin
    qrlblPlataforma.enabled:= True;
    qrlblPlataforma.Top:= 28;
    qrlblPlataforma.Left:= 373;
    qrlblPlataforma.Width:= 300;
    qrlblPlataforma.Caption:= desSuministro(   BandaLinea.DataSet.FieldByName('cod_empresa_albaran_fd').asString,
                             BandaLinea.DataSet.FieldByName('cod_cliente_albaran_fd').asString,
                             BandaLinea.DataSet.FieldByName('cod_dir_sum_fd').asString );
    qlDesCliente.Top:= 48;
    qlTipoVia.Top:= 67;
    qlDomicilio.Top:= 67;
    qlPoblacion.Top:= 86;
    qlCodPostal.Enabled:= False;
    qlProvincia.Enabled:= False;
  end
  else
  begin
    qrlblPlataforma.Enabled:= False;
  end;
 }
  //Si no tiene tipo via desplazar domicilio a la izquierda.
  if (Trim(DFactura.mtFacturas_Cab2.FieldByName('tipo_via_fc').AsString) = '') then
  begin
    qlDomicilio.Left := qlTipoVia.Left;
    qlTipoVia.Enabled := false;
    qlTipoVia2.Enabled := false;
  end;

  if (bImpresoDescuento) and (Detalles = 0) then
    bndDescuento.PrintIfEmpty := false;

  BandaLinea.Frame.DrawBottom := false;

  if FQueryCliente.Active then
    FQueryCliente.Close;
  FQueryCliente.ParamByName('cliente_c').asString := DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').asString;
  FQueryCliente.Open;
  eori := FQueryCliente.FieldByName('eori_cliente_c').asString;
  if eori <> '' then
    qrlEori2.Caption := Format('EORI: %s', [ eori ])
  else
    qrlEori2.Caption := '';

  //A�adir columna Entrega Kg (Kilos Posei) a partir del 13/04/2021
  if (DFactura.mtFacturas_Cab2.fieldbyname('fecha_factura_fc').AsDatetime >= StrToDate('13/04/2021')) and
     ((DFactura.mtFacturas_Cab2.fieldbyname('automatica_fc').AsInteger = 1) and (DFactura.mtFacturas_Cab2.fieldbyname('anulacion_fc').AsInteger = 0)) then
  begin
    l5.Enabled := true;
    QRLabel3.Enabled := true;
    QRLabel6.Enabled := true;
    QRShape12.Enabled := true;
    QRLabel4.Enabled := true;
    QRLabel5.Enabled := true;
    QRShape14.Enabled := true;
    posei.Enabled := true;
  end
  else
  begin
    l5.Enabled := false;
    QRLabel3.Enabled := false;
    QRLabel6.Enabled := false;
    QRShape12.Enabled := false;
    QRLabel4.Enabled := false;
    QRLabel5.Enabled := false;
    QRShape14.Enabled := false;
    posei.Enabled := false;
  end;
  if UnicaDirSuministro then
  begin
    QRDirSum.Enabled := true;
    QRLabel13.Enabled := true;
    QRDBText13.Enabled := true;
    QRDBText12.Enabled := true;
    QRDBText11.Enabled := true;
    QRDBText10.Enabled := true;
    QRDBText9.Enabled := true;
    QRDBText14.Enabled := true;
    QRDBText8.Enabled := true;

    QRDirSum2.Enabled := true;
    QRLabel23.Enabled := true;
    QRDBText6.Enabled := true;
    QRDBText5.Enabled := true;
    QRDBText4.Enabled := true;
    QRDBText3.Enabled := true;
    QRDBText2.Enabled := true;
    QRDBText7.Enabled := true;
    QRDBText1.Enabled := true;

  end
  else
  begin
    QRDirSum.Enabled := false;
    QRLabel13.Enabled := false;
    QRDBText13.Enabled := false;
    QRDBText12.Enabled := false;
    QRDBText11.Enabled := false;
    QRDBText10.Enabled := false;
    QRDBText9.Enabled := false;
    QRDBText14.Enabled := false;
    QRDBText8.Enabled := false;

    QRDirSum2.Enabled := false;
    QRLabel23.Enabled := false;
    QRDBText6.Enabled := false;
    QRDBText5.Enabled := false;
    QRDBText4.Enabled := false;
    QRDBText3.Enabled := false;
    QRDBText2.Enabled := false;
    QRDBText7.Enabled := false;
    QRDBText1.Enabled := false;

  end;

end;

procedure TRFactura2.CabeceraFacturaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  sigue.Enabled := true and (DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString <> 'ALEMANIA');
  NumeroHoja := 1;
end;

procedure TRFactura2.qrchldbndChildBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  tipo_albaran: Integer;
  num_exportador: String;
begin
  if FQueryCliente.Active then
    FQueryCliente.Close;
  FQueryCliente.ParamByName('cliente_c').asString := DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').asString;
  FQueryCliente.Open;

  if FQueryEmpresa.Active then
    FQueryEmpresa.Close;
  FQueryEmpresa.ParamByName('empresa_e').asString := DFactura.mtFacturas_Cab2.FieldByName('cod_empresa_fac_fc').asString;
  FQueryEmpresa.Open;


  qrm1.Lines.Clear;
  PrintBand := FQueryCliente.FieldByName('es_comunitario_c').asString = 'N';

  if PrintBand then
  begin
   //Peticion de Amparo Segui. Para el cliente SIL y para facturas menores de 6000 euros, no es necesario que salga el num_exportador en la impresion de la factura. 22/06/2021
    if (DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').AsString = 'SIL') and
       (DFactura.mtFacturas_Cab2.FieldByName('importe_total_euros_fc').AsFloat < 6000) then
    begin
      qrm1.Lines.Add(Format(_EXPORTADOR_AUTORIZADO_EN_SIL_, []));
    end
    else
    begin
      num_exportador := FQueryEmpresa.FieldByName('num_exp_autorizado_e').asString;
      if DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').asString = 'ODD' then
          num_exportador := Copy(num_exportador, 1, 2) + '/' + Copy(num_exportador, 3, 4) + '/' + Copy(num_exportador, 7, 2) + '/' + Copy(num_exportador, 9, 4)
            + '/' + Copy(num_exportador, 13, 2);

      tipo_albaran := FQueryCliente.FieldByName('tipo_albaran_c').asInteger;
      case tipo_albaran of
        0, 1:  // Tipos albaran Valorado, No valorado
          qrm1.Lines.Add(Format(_EXPORTADOR_AUTORIZADO_ES_, [ num_exportador ]));

        2: // Tipo albaran aleman
          qrm1.Lines.Add(Format(_EXPORTADOR_AUTORIZADO_DE_, [ num_exportador ]));

        3: // Tipo albaran ingles
          qrm1.Lines.Add(Format(_EXPORTADOR_AUTORIZADO_EN_, [ num_exportador ]));
      end;
    end;
  end;
end;

procedure TRFactura2.qrgCabAlbaranBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgCabAlbaran.Height:= 0;
end;

procedure TRFactura2.BandaLineaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     //S�lo se imprime una vez el numero de albaran- pedido- centro y fecha
     //Deshabilitamos hasta que uno de ellos cambie
  if AlbaranNum = DFactura.mtFacturas_Det2.FieldByName('n_albaran_fd').AsInteger then
  begin
    if Albaran.Enabled = true then
    begin
      Albaran.Enabled := false;
      Pedido.Enabled := false;
    end;
    Albaran.Font.Style := Albaran.Font.Style - [fsBold];
    Producto.Font.Style := Albaran.Font.Style - [fsBold];

    BandaLinea.Height := 28;

    Albaran.Top := 0;
    Pedido.Top := 12;
    producto.Top := 0;
    envase.Top := 12;
    posei.Top := 0;
    cajas.Top := 0;
    unidad.Top := 0;
    PrecioUnidad.Top := 0;
    precio_neto_tf.Top := 0;
    qretipo_iva_tf.Top := 0;
    qrShape13.Height := 29;
    lin5.Height := 29;
    lin6.Height := 29;
    lin7.Height := 29;
    lin8.Height := 29;
    qrsVat.Height := 29;
  end
  else
  begin
    Albaran.Enabled := true;
    Pedido.Enabled := true;
    Albarannum := DFactura.mtFacturas_Det2.FieldByName('n_albaran_fd').AsInteger;

    Albaran.Font.Style := Albaran.Font.Style + [fsBold];
    producto.Font.Style := Albaran.Font.Style + [fsBold];

    BandaLinea.Height := 33;

    Albaran.Top := 6;
    Pedido.Top := 17;
    producto.Top := 6;
    envase.Top := 17;
    posei.Top := 6;
    cajas.Top := 6;
    unidad.Top := 6;
    PrecioUnidad.Top := 6;
    precio_neto_tf.Top := 6;
    qretipo_iva_tf.Top := 6;
    qrShape13.Height := 34;
    lin5.Height := 34;
    lin6.Height := 34;
    lin7.Height := 34;
    lin8.Height := 34;
    qrsVat.Height := 33;
  end;


     //******************************************************
     //Descripcion del producto
     //******************************************************
  PonProducto;

     //Segun la unidad de medida este valor seran Kgs, cajas o unidades
  cajas.Caption := Unidades(DFactura.mtFacturas_Det2.FieldByName('unidad_facturacion_fd').AsString);

     //Decrmentamos en uno los detalles que nos quedan por imprimir
  Inc(detalles, -1);

  if Detalles = 0 then
  begin
    //Ya no quedan detalles, es la hora de imprimir los descuentos
    Detalles := -1;
    ConfigurarGastosYDescuentos;
  end;

  //Format cantidades
  precio_neto_tf.Mask := '#,##0.00';

end;

procedure TRFactura2.BandaLineaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if CurrentY > 2645 then
  begin
    ForceNewPage;

       //Para volver a imprimir albaran- pedido- centro y fecha
       //en la primera Lines de la segunda hoja, aunque sea el mismo de la hoja
       //anterior
    if AlbaranNum = DFactura.mtFacturas_Det2.FieldByName('n_albaran_fd').AsInteger then
      AlbaranNum := 0;
  end;
end;

procedure TRFactura2.CabeceraGastosAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  CabeceraGastos.Enabled := false;
  QRLabel6.Enabled := false;
  QRLabel3.Enabled := false;
end;

procedure TRFactura2.CabeceraGastosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLabel6.Enabled := false;
  QRLabel3.Enabled := false;
end;

procedure TRFactura2.bndDescuentoComisionBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if DetallesGasto > 0 then
    bndDescuentoComision.Frame.DrawBottom := false
  else
    bndDescuentoComision.Frame.DrawBottom := true;
end;

procedure TRFactura2.bndDescuentoComisionAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if bndDescuentoComision.Enabled then
  begin
    bndDescuentoComision.Enabled:= False;
    bImpresoDescuento := true;
  end;
end;

procedure TRFactura2.BandaTotalesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  CuadroFormaPago;
  ConfiguracionCuadroTotales;

  try
    BandaNotas.Enabled:= not DFactura.mtFacturas_Cab2.FieldByName('notas_fc').IsNull;
  except
    //ERROR Blob incorrecto???
  end;
{
  if CabeceraFactura2.Color = clWhite then
    BandaTotales.Frame.DrawTop := false
  else
    BandaTotales.Frame.DrawTop := true;
}
end;

procedure TRFactura2.BandaTotalesAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Hoja := 0;
  sigue.Enabled := false;

  DFactura.mtFacturas_Det2.Filter := '';
  DFactura.mtFacturas_Det2.Filtered := false;
  DFactura.mtFacturas_Gas2.Filter := '';
  DFactura.mtFacturas_Gas2.Filtered := false;
  DFactura.mtFacturas_Bas2.Filter := '';
  DFactura.mtFacturas_Bas2.Filtered := false;

end;

procedure TRFactura2.BandaErrorCopiaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //Si es una copia comprobar que coincida con el original
  PrintBand:= bCopia and CambioFacturacion;
end;

procedure TRFactura2.BandaNotasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if not bBruto then
  begin
   qrlObservacionFactura.Caption:= DFactura.mtFacturas_Cab2.fieldbyname('notas_fc').AsString;
   PrintBand:= qrlObservacionFactura.Caption <> '';
  end
  else
  begin
    PrintBand:= False;
  end;
end;

procedure TRFactura2.BandaObservacionesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= EsClienteSeguro( sEmpresa, DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').AsString );
  if PrintBand then
  begin
    qrlAseguradora.Enabled:= True;
    if DFactura.mtFacturas_Cab2.FieldByName('fecha_factura_fc').AsDateTime < StrToDate('1/3/2012') then
    begin
      if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ESPA�A' then
        qrlAseguradora.Caption:= 'Operaci�n asegurada en Mapfre.'
      else
        qrlAseguradora.Caption:= 'Mapfre insured operation.';
    end
    else
    begin
      if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ESPA�A' then
        qrlAseguradora.Caption:= 'Operaci�n asegurada en COFACE'
      else
        qrlAseguradora.Caption:= 'COFACE insured operation.';
    end;
  end
  else
  begin
    qrlAseguradora.Enabled:= false;
  end;

  if (DataSet.FieldByName('cod_cliente_fc').AsString = 'FD') or
     (DataSet.FieldByName('cod_cliente_fc').AsString = 'BUR') then
  begin
    if not PrintBand then
    begin
      PrintBand:= true;
    end;
    mmoClienteObv.Lines.Clear;
    if (DataSet.FieldByName('cod_cliente_fc').AsString = 'FD') then
    begin
      with mmoClienteObv do
      begin
        Lines.Add('SUPLIER NUMBER: 91105');
        //Lines.Add('81');
      end;
    end
    else
    if (DataSet.FieldByName('cod_cliente_fc').AsString = 'BUR') then
    begin
      with mmoClienteObv do
      begin
        Lines.Add('The exporter of the product covered by this document (Customs Authorization No-NL/333/01/183)');
        Lines.Add('Declares that except where otherwise clearly indicated, these products are of EU preferencial origin.');
      end;
    end;
  end
  else
  begin
    mmoClienteObv.Enabled:= False;
  end;
end;

procedure TRFactura2.PiePaginaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //if sEmpresa = '050' then
  //begin
  //  psEtiqueta.Left:= 32;
  //end
  //else
  //begin
    psEtiqueta.Left:= 12;
  //end;

  //Numero de hoja de la factura
  HojaNum.Caption := IntToStr(NumeroHoja);


  if definitivo then
  begin
    if (Tag = 1) and not printOriginal then begin
      Tag := Tag + 1;
      Inc(Salto);
    end;
    if (Tag = 2) and not printEmpresa then begin
      Tag := Tag + 1;
      Inc(Salto);
    end;
    case Tag of
      0: psEtiqueta.Caption := '';
      1: psEtiqueta.Caption := 'ORIGINAL';
      2: psEtiqueta.Caption := 'ORIGINAL EMPRESA';
      3: psEtiqueta.Caption := 'COPIA 1/1ST COPY';
      4: psEtiqueta.Caption := 'COPIA 2/2ND COPY';
      5: psEtiqueta.Caption := 'COPIA 3/3RD COPY';
    else psEtiqueta.Caption := 'COPIA ' + IntToStr(Tag - (2 + salto)) + '/' + IntToStr(Tag - (2 + salto)) + 'TH COPY';
    end;
  end
  else
  begin
    psEtiqueta.Caption := 'COPIA INFORMATIVA';
  end;

  //if gProgramVersion = pvBAG then
    //qrmResponsabilidadEnvase.Left := 12;

  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ESPA�A' then
  begin
    qrmResponsabilidadEnvase.Lines.Clear;
    qrmResponsabilidadEnvase.Lines.Add('"De conformidad con lo establecido en la ley 11/1997, de 24 de abril, de envases y residuos de envases y, el art�culo 18.1 del  Real Decreto 782/1998,  de 30 de Abril que desarrolla');
    qrmResponsabilidadEnvase.Lines.Add('la Ley 11/1997; el responsable de la entrega  del residuo de envase o envase usado para su correcta  gesti�n ambiental de aquellos envases no identificados mediante el Punto Verde');
    if bHayGranadaEco then
      qrmResponsabilidadEnvase.Lines.Add('(sistema integrado de gesti�n  de Ecoembes), ser� el poseedor final del mismo".                                                                          ENTIDAD DE CONTROL ES-ECO-020-CV.  GRANADA ECO.')
    else
      qrmResponsabilidadEnvase.Lines.Add('(sistema integrado de gesti�n  de Ecoembes), ser� el poseedor final del mismo".                                                                          .');
  end
  else
  begin
    qrmResponsabilidadEnvase.Lines.Clear;
    qrmResponsabilidadEnvase.Lines.Add('"In accordance with which it is established in law 11/1997 dated April 24th about packaging and packaging waste, according to article 18.1 of Royal decree 782/1998 dated April');
    qrmResponsabilidadEnvase.Lines.Add('30th that develops law 11/1997; the responsible for the delivery of packaging and packaging waste used for proper enviroment management  from those packaging non identified by');
    if bHayGranadaEco then
      qrmResponsabilidadEnvase.Lines.Add('the green point (inegrated management system Ecoembes), will be the final holder".                                                        ENTIDAD DE CONTROL ES-ECO-020-CV.  POMEGRANATE ECO.')
    else
      qrmResponsabilidadEnvase.Lines.Add('the green point (inegrated management system Ecoembes), will be the final holder".                                                        ');
  end;

  (*Vuelto a poner a peticion de Esther Cuerda, si alguien vuelve a pedir que se quite que hable con ella*)
  //if EsGrupoSAT then
  begin
    qrmGarantia.Enabled:= True;
    qrmGarantia.Lines.Clear;
    if not (DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ESPA�A' ) then
    begin
      qrmGarantia.Lines.Add( 'Partial or complete rejections should be communicated and quantified no later than 48 hours after the reception of the goods by email or fax.' );
    end
    else
    begin
      qrmGarantia.Lines.Add( 'Las incidencias deben ser comunicadas y cuantificadas  por escrito dentro del plazo de 48 horas posteriores a la descarga de la mercanc�a.' );
    end;

    if rGGN.imprimir_garantia = true then
    begin
      if (DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ESPA�A') then  qrmGarantia.Lines.Add(rggn.descri_esp+rGGN.ggn_code)
      else  qrmGarantia.Lines.Add(rggn.descri_eng+rGGN.ggn_code);
    end;

    qrmResponsabilidadEnvase.Top:= 25;
    psEtiqueta.Top:= 63;
    HojaNum.Top:= 63;
    sigue.top:=63;
    PiePagina.Height:= 80;
  end;
  (*
  else
  begin
    qrmGarantia.Enabled:= False;
    qrmResponsabilidadEnvase.Top:= 0;
    psEtiqueta.Top:= 38;
    HojaNum.Top:= 38;
    Sigue.Top:=63;
    PiePagina.Height:= 55;
  end;
  *)
end;

procedure TRFactura2.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  bHayGranadaEco:= False;
  salto := 0;
  AlbaranNum := -1;
  FacturaNum := -2;
  FacturaCod := '';
  Hoja := 0;
//  RFactura.ReportTitle := StringReplace('Facturas ' + DFactura.mtFacturas_Cab.fieldbyname('cod_cliente_fc').AsString, '.', '', [rfReplaceAll, rfIgnoreCase]);
  RFactura2.ReportTitle := StringReplace('Factura ' + DFactura.mtFacturas_Cab2.fieldbyname('cod_factura_fc').AsString, '.', '', [rfReplaceAll, rfIgnoreCase]);
  AsignarTemporales;

   if UnicaDirSuministro then
  begin
    QRDirSum.Enabled := true;
    QRLabel13.Enabled := true;
    QRDBText13.Enabled := true;
    QRDBText12.Enabled := true;
    QRDBText11.Enabled := true;
    QRDBText10.Enabled := true;
    QRDBText9.Enabled := true;
    QRDBText14.Enabled := true;
    QRDBText8.Enabled := true;

    QRDirSum2.Enabled := true;
    QRLabel23.Enabled := true;
    QRDBText6.Enabled := true;
    QRDBText5.Enabled := true;
    QRDBText4.Enabled := true;
    QRDBText3.Enabled := true;
    QRDBText2.Enabled := true;
    QRDBText7.Enabled := true;
    QRDBText1.Enabled := true;

  end
  else
  begin
    QRDirSum.Enabled := false;
    QRLabel13.Enabled := false;
    QRDBText13.Enabled := false;
    QRDBText12.Enabled := false;
    QRDBText11.Enabled := false;
    QRDBText10.Enabled := false;
    QRDBText9.Enabled := false;
    QRDBText14.Enabled := false;
    QRDBText8.Enabled := false;

    QRDirSum2.Enabled := false;
    QRLabel23.Enabled := false;
    QRDBText6.Enabled := false;
    QRDBText5.Enabled := false;
    QRDBText4.Enabled := false;
    QRDBText3.Enabled := false;
    QRDBText2.Enabled := false;
    QRDBText7.Enabled := false;
    QRDBText1.Enabled := false;

  end;

end;

procedure TRFactura2.QuickRepStartPage(Sender: TCustomQuickRep);
begin
     //Nueva hoja
  Inc(Hoja);
  Bandas := 0;

  if definitivo then
  begin
    lblNumFactura.Caption:= DFactura.mtFacturas_Cab2.fieldbyname('cod_factura_fc').AsString;
  end
  else
  begin
    if bProforma then
      lblNumFactura.Caption:= 'PROFORMA'
    else
      lblNumFactura.Caption:= 'INFORMATIVA';
  end;
  lblNumFactura2.Caption := lblNumFactura.Caption;
end;

procedure TRFactura2.ConfigurarGastosYDescuentos;
begin
  bndDescuentoComision.Enabled := false;
  DFactura.mtFacturas_Gas2.Filter := ' cod_factura_fg = ' + QuotedStr(DFactura.mtFacturas_Cab2.FieldByName('cod_factura_fc').AsString);;
  DFactura.mtFacturas_Gas2.Filtered := True;
  DetallesGasto := DFactura.mtFacturas_Gas2.RecordCount;
  DetallesComision := mtComisiones.RecordCount;
  DetallesDescuento := mtDescuentos.RecordCount;
  DetallesEurosKg := mtEurosKg.RecordCount;
  if bImpresoDescuento then
    bndDescuento.PrintIfEmpty := false;
  if (DetallesGasto > 0) or not ( bImpresoDescuento ) then
  begin

    CabeceraGastos.Enabled:= True;
    bndComision.Enabled:= Length(RImportesCabecera.aRImportesComision) <> 0;
    bndDescuento.Enabled:= Length(RImportesCabecera.aRImportesDescuento) <> 0;
    bndEurosKg.Enabled:= Length(RImportesCabecera.aRImportesEurosKg) <> 0;
    BandaGastos.Enabled:= (DetallesGasto > 0);
    if (DetallesGasto = 0) then
    begin
      DetallesGasto := -1;
    end;
  end
  else
  begin
    BandaLinea.Frame.DrawBottom := true;
  end;
  AlbaranGasto := -1;
end;

procedure TRFactura2.ConfiguracionCuadroTotales;
var i: Integer;
begin
  i := DFactura.mtFacturas_Bas2.RecordCount;
  ActivarBases;
  ValoresTotales( i, true );
  CabeceraTotales( i, true );
//  if DFactura.mtFacturas_Cab2.fieldbyname('moneda_fc').asstring = 'EUR' then
//  begin
    ValoresTotalesEur( i, false);
    ConfiguraIVA ( false );
{
  end
  else
  begin
    ValoresTotalesEur( i, true );
    ConfiguraIVA ( true );
  end;
}
end;


procedure TRFactura2.PonProducto;
var
  sProducto, sEnvase: string;
begin
  bHayGranadaEco:= Trim(DFactura.mtFacturas_Det2.FieldByName('cod_producto_fd').AsString) = 'W';
     //POR DEFECTO EN CASTELLANO
  sEnvase := DFactura.mtFacturas_Det2.FieldByName('des_envase_fd').AsString;
  sProducto := DFactura.mtFacturas_Det2.FieldByName('des_producto_fd').AsString;
  Producto.Font.Style := producto.Font.Style;
  Producto.Top := producto.Top;

  if gProgramVersion = pvSAT then
  begin
    if Trim(DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString) <> 'ESPA�A' then
    begin
         //PRODUCTO
      if ((Trim(DFactura.mtFacturas_Det2.FieldByName('cod_producto_fd').AsString) = 'TOM') or
        (Trim(DFactura.mtFacturas_Det2.FieldByName('cod_producto_fd').AsString) = 'TOM')) and
        (UpperCase(Copy(DFactura.mtFacturas_Det2.FieldByName('calibre_fd').AsString, 1, 1)) = 'G') and
        (DFactura.mtFacturas_Det2.FieldByName('cod_envase_fd').AsString <> '001') then
      begin
        sProducto := 'BEEF';
      end;
    end;
       //******************************************************
       //S�LO VISUALIZAMOS CALIBRE PARA TImage PENINSULA Y TENERIFE
       //******************************************************
    if (DFactura.mtFacturas_Det2.FieldByName('cod_producto_fd').AsString = 'TOM') or
      (DFactura.mtFacturas_Det2.FieldByName('cod_producto_fd').AsString = 'TOM') then
    begin
      sProducto := sProducto + ' (' + DFactura.mtFacturas_Det2.FieldByName('calibre_fd').AsString + ')';
    end;

    if (DFactura.mtFacturas_Det2.FieldByName('cod_producto_fd').AsString = 'TCP') and
       (DFactura.mtFacturas_Det2.FieldByName('cod_cliente_albaran_fd').AsString = 'MER') then
    begin
      sProducto := 'TOMATE CHERRY';
    end;
  end;

  sProducto := DFactura.mtFacturas_Det2.FieldByName('nom_marca_fd').AsString + ' - ' + sProducto;
  Producto.Caption := sProducto;
  Envase.Caption := sEnvase;
end;

procedure TRFactura2.Prepara_Visualizacion;
begin
  DConfigMail.sAsunto:= AsuntoFactura;
  DConfigMail.sEmpresaConfig:= DFactura.mtFacturas_Cab2.FieldByName('cod_empresa_fac_fc').AsString;
  DConfigMail.sClienteConfig:= DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').AsString;

  RFactura2.Configurar(DFactura.mtFacturas_Cab2.FieldByName('cod_empresa_fac_fc').AsString, DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').AsString );
//  RFactura2.printOriginal := true;
//  RFactura2.printEmpresa := true;

//  DPreview.bCanSend := (DMConfig.EsLaFont);
//  RFactura2.Tag:= 1 ;
end;

procedure TRFactura2.ProductoPrint(sender: TObject; var Value: string);
begin
  value := ArreglaProductoGGN(rggn, DFactura.mtFacturas_Det2.FieldByName('cod_empresa_albaran_fd').AsString, DFactura.mtFacturas_Det2.FieldByName('cod_producto_fd').AsString, value);
end;

function TRFactura2.UnicaDirSuministro: boolean;
var CantDir: integer;
    DirSum: String;
begin

  CantDir := 1;
  DirSum :=  DFactura.mtFacturas_Det2.FieldByName('cod_dir_sum_fd').AsString;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select count(distinct cod_dir_sum_fd) cantidad from tfacturas_det ');
    SQL.Add(' where cod_factura_fd = ' + QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString) );
    Open;

    CantDir := FieldByname('cantidad').AsInteger;
    Close;
  end;

//  DFactura.mtFacturas_Det.First;
//  while not DFactura.mtFacturas_Det.eof do
//  begin
//    if DFactura.mtFacturas_Det.FieldByName('cod_dir_sum_fd').AsString <> dirSum then
//      inc ( CantDir);
//    DFactura.mtFacturas_Det.Next;
//  end;

  result := CantDir = 1;

  if result = true then
  begin
    // Buscamos datos albaran
    with DFactura.QDirSum do
    begin
      if Active then Close;
      with SQL do
      begin
        Clear;
        Add(' select dir_sum_sc, nombre_ds, tipo_via_ds, domicilio_ds, cod_postal_ds, provincia_ds, poblacion_ds, descripcion_p ');
        Add('   from frf_salidas_c                                          ');
        Add('  left join frf_dir_sum on cliente_ds = cliente_sal_sc         ');
        Add('                        and dir_sum_ds = dir_sum_sc            ');
        Add('   left join frf_paises on pais_p = pais_ds                    ');
        Add('  where empresa_sc = :empresa                                  ');
        Add('    and centro_salida_sc = :centro                             ');
        Add('    and n_albaran_sc = :albaran                                ');
        Add('    and fecha_sc = :fecha                                      ');
      end;

      ParamByName('empresa').AsString := DFactura.mtFacturas_Det2.FieldByName('cod_empresa_albaran_fd').AsString;
      ParamByName('centro').AsString := DFactura.mtFacturas_Det2.FieldByName('cod_centro_albaran_fd').AsString;
      ParamByName('albaran').AsInteger := DFactura.mtFacturas_Det2.FieldByName('n_albaran_fd').AsInteger;
      ParamByName('fecha').AsDatetime := DFactura.mtFacturas_Det2.FieldByName('fecha_albaran_fd').AsDateTime;
      Open;
    end;
  end;
end;

function TRFactura2.Unidades(cad: string): string;
begin
   //Cantidad  cajas
with DFactura.mtFacturas_Det2 do
  if cad = 'CAJ' then
  begin
    Unidades := FieldByName('cajas_fd').AsString;
  end
  else
    if cad = 'UND' then
    begin
      Unidades := FieldByName('unidades_fd').AsString;
    end
    else
      if cad = 'KGS' then
      begin
        Unidades := FormatFloat('#,##0.00', FieldByName('kilos_fd').AsFloat);
      end;
end;

procedure TRFactura2.CuadroFormaPago;
var
  iDif, iAltura: integer;
  aux : String;
begin
  QRMemoPago.Lines.Clear;
  if QRMemoPago.Lines.Count = 0 then
  begin
    with DFactura.mtFacturas_Cab2 do
    begin
      if Trim( FieldByName('des_forma_pago_fc').AsString) = '' then
      begin
        Rlin.Enabled := false;
        Plin.Enabled := false;
      end
      else
      begin
        Plin.Enabled := True;
        Rlin.Enabled := True;

        Aux := FieldByName('des_forma_pago_fc').AsString;
        while Pos(#$D#$A, Aux) > 0 do
        begin
          QRMemoPago.Lines.Add( Copy(Aux, 1, pos(#$D#$A, Aux) - 1));
          Aux := Copy(aux, Pos(#$D#$A, Aux) +2, Length(Aux));
        end;
        QRMemoPago.Lines.Add( Aux );
        iAltura:= 15 + ((  QRMemoPago.Lines.Count - 1 ) * 14 );
        QRMemoPago.Height:= iAltura;
        iAltura:= iAltura + 10;
        if rLin.Height < iAltura then
        begin
          iDif:= iAltura - rLin.Height;
          rLin.Height:= rLin.Height + iDif;
        end;
      end;
    end;
  end;
end;

function TRFactura2.CambioFacturacion: Boolean;
begin
  with DFactura.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select importe_total_fc from tfacturas_cab ');
    SQL.Add('  where cod_factura_fc = :clavefactura ');

    ParamByName('clavefactura').AsString := DFactura.mtFacturas_Cab2.FieldByName('cod_factura_fc').AsString;
    if OpenQuery(DFactura.QAux) then
    begin
      result := bRoundTo(FieldByName('importe_total_fc').AsFloat, -2) <> bRoundTo(DFactura.mtFacturas_Cab2. fieldbyname('importe_total_fc').AsFloat, -2);
    end
    else
    begin
      Result := True;
    end;
    Close;
  end;
end;

procedure TRFactura2.Configurar(const AEmpresa, ACliente: string);
var
  bAux: Boolean;
  sAux: string;
  ssEmpresa: string;
begin
    //CLIENTE ONLINE
  if ACliente = 'WEB' then
  begin
    PsDireccion.Enabled:= False;
    PsEmpresa.Enabled:= False;
    PsNif.Enabled:= False;

    if FileExists( gsDirActual + '\recursos\000Page.wmf') then
    begin
      QRImageCab.Top:= -18; //-20
      QRImageCab.Left:= -37; //-20
      QRImageCab.Width:= 763; //-30
      QRImageCab.Height:= 1102; //-20
      QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\000Page.wmf');
    end;
    begin
      if FileExists( gsDirActual + '\recursos\LogoBongranade.jpg') then
      begin
        imgQRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\LogoBongranade.jpg');
      end
      else
      if FileExists( gsDirActual + '\recursos\BongranadeSanflavino.jpg') then
      begin
        imgQRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\BongranadeSanflavino.jpg');
      end
      else
      if FileExists( gsDirActual + '\recursos\Sanflavino.jpg') then
      begin
        imgQRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\Sanflavino.jpg');
      end;
    end;
    Exit;
  end
  else
  begin
    imgQRImgLogo.Enabled:= False;
  end;

  //RESTO DE CLIENTES
  if Copy( AEmpresa, 1, 1 ) = 'F' then
    ssEmpresa:= 'BAG'
  else
  begin
    if ( AEmpresa = '050' ) or ( AEmpresa = '080' ) then
      ssEmpresa:= 'SAT'
  end;
  if PaisCliente(AEmpresa, ACliente) <> 'ES' then
    ssEmpresa := 'Ingles ' + ssEmpresa;

  sEmpresa:= AEmpresa;
  bAux:= FileExists( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
  if bAux then
  begin
    QRImageCab.Top:= -18; //-20
    QRImageCab.Left:= -37; //-20
    QRImageCab.Width:= 763; //-30
    QRImageCab.Height:= 1102; //-20
    QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\' + ssEmpresa + 'Page.wmf');
    QRImageCab.Stretch:= True;
    QRImageCab.Enabled:= True;
  end
  else
  begin
    QRImageCab.Enabled:= False;
    ConsultaOpen(DFactura.QAux,
      ' select nombre_e,nif_e,tipo_via_e,domicilio_e,cod_postal_e, ' +
      '        poblacion_e,nombre_p ' +
      ' from frf_empresas,frf_provincias ' +
      ' where empresa_e=' + QuotedStr(Trim(AEmpresa)) +
      '   and cod_postal_e[1,2]=codigo_p');

    with DFactura.QAux do
    begin
      PsEmpresa.Caption := FieldByName('nombre_e').AsString;
      PsNif.Caption := 'NIF: ' + FieldByName('nif_e').AsString;

      sAux := '';
      if Trim(FieldByName('tipo_via_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('tipo_via_e').AsString) + '. ';
      if Trim(FieldByName('domicilio_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('domicilio_e').AsString) + '      ';
      if Trim(FieldByName('cod_postal_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('cod_postal_e').AsString) + '  ';
      if Trim(FieldByName('poblacion_e').AsString) <> '' then
        sAux := sAux + Trim(FieldByName('poblacion_e').AsString) + '      ';
      if Trim(FieldByName('cod_postal_e').AsString) <> '' then
       sAux := sAux + '(' + Trim(FieldByName('nombre_p').AsString) + ')  ';

      PsDireccion.Caption := sAux;

      Close;
    end;
  end;

  PsDireccion.Enabled:= not bAux;
  PsEmpresa.Enabled:= not bAux;
  PsNif.Enabled:= not bAux;
end;

procedure TRFactura2.LabelFechaPrint(sender: TObject; var Value: String);
begin
  Value := DFactura.mtFacturas_Cab2.fieldbyname('fecha_factura_fc').AsString;
end;

procedure TRFactura2.LFecha2Print(sender: TObject; var Value: String);
begin
  Value := DFactura.mtFacturas_Cab2.fieldbyname('fecha_factura_fc').AsString;
end;

procedure TRFactura2.AlbaranPrint(sender: TObject; var Value: String);
var
  empresa : string;
  centro : string;
  albaran : integer;
  fecha : Tdatetime;
begin
  (*ALBARAN*)
    if ( Copy( DFactura.mtFacturas_Det2.FieldByName('cod_empresa_albaran_fd').asstring, 1, 1) = 'F' ) and
       ( DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').AsString <> 'ECI' ) then
    begin
      Value := Value + ' - ' +
           DFactura.mtFacturas_Det2.FieldByName('cod_empresa_albaran_fd').asstring +
           DFactura.mtFacturas_Det2.FieldByName('cod_centro_albaran_fd').asstring +
           Rellena( DFactura.mtFacturas_Det2.FieldBYName('n_albaran_fd').asstring, 5, '0', taLeftJustify ) +
           Coletilla( DFactura.mtFacturas_Det2.FieldBYName('cod_empresa_albaran_fd').asstring ) +
           ' - ' +  FormatDateTime( 'dd/mm/yy', DFactura.mtFacturas_Det2.FieldBYName('fecha_albaran_fd').AsDateTime );
    end
    else
    begin
      Value := Value + ' - ' +
           DFactura.mtFacturas_Det2.FieldBYName('n_albaran_fd').asstring +
           ' - ' +  FormatDateTime( 'dd/mm/yy', DFactura.mtFacturas_Det2.FieldBYName('fecha_albaran_fd').AsDateTime );
    end;


    empresa := DFactura.mtFacturas_Det2.FieldByName('cod_empresa_albaran_fd').asstring;
    centro :=   DFactura.mtFacturas_Det2.FieldByName('cod_centro_albaran_fd').asstring;
    fecha :=  DFactura.mtFacturas_Det2.FieldBYName('fecha_albaran_fd').asdatetime;
    albaran :=   DFactura.mtFacturas_Det2.FieldBYName('n_albaran_fd').asinteger;
    
    self.rGGN := ConfigurarGGN('database',empresa, centro, albaran, fecha, DFactura.mtFacturas_Cab2.FieldByName('cod_factura_fc').AsString);


end;

procedure TRFactura2.PedidoPrint(sender: TObject; var Value: String);
begin
  Value := '';
  if DFactura.mtFacturas_Det2.FieldBYName('pedido_fd').asstring <> '' then
    Value := '(' + DFactura.mtFacturas_Det2.FieldBYName('pedido_fd').asstring + ')  ';

  //BORRRAR
  if ( DFactura.mtFacturas_Det2.FieldBYName('n_albaran_fd').asstring  = '240452' ) and (DFactura.mtFacturas_Det2.FieldBYName('fecha_albaran_fd').asstring  = '27/04/2012' ) then
     Value := Value + 'BY TRUCK R6459BCD/BY SEA'
  else
     Value := Value + DFactura.mtFacturas_Det2.FieldBYName('matricula_fd').asstring;
end;

procedure TRFactura2.CabeceraTotales(const AIndice: Integer; AFlag: Boolean);
begin
  qrlblLabel.Enabled:= AFlag;
  qrlblBase.Enabled:= AFlag;
  qrlblIva.Enabled:= AFlag;
  qrlblTotal.Enabled:= AFlag;

  if AFlag then
  begin
    //CABECERAS
    if ClienteConRecargo( DFactura.mtFacturas_Cab2.FieldByName('cod_empresa_fac_fc').AsString,
                          DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').AsString,
                          DFactura.mtFacturas_Cab2.FieldByName('fecha_factura_fc').AsDateTime ) then
    begin
      //Recargo
      if DFactura.mtFacturas_Cab2.FieldByName('impuesto_fc').AsString = 'I' then
        qrlblLabel.Caption:= 'IVA+Recargo'
      else
        qrlblLabel.Caption:= 'IGIC+Recargo';
    end
    else
    begin
      if DFactura.mtFacturas_Cab2.FieldByName('impuesto_fc').AsString = 'I' then
        qrlblLabel.Caption:= 'IVA/VAT'
      else
        qrlblLabel.Caption:= 'IGIC';
    end;
  end;
end;

procedure TRFactura2.ValoresTotales(const AIndice: Integer; AFlag: Boolean);
var
  iInicio, iAltura, iIncCuadro, iIncTexto: Integer;
begin
  qrlblTotalLabel.Enabled:= AFlag;
  qrlblTotalBase.Enabled:= AFlag;
  qrlblTotalIva.Enabled:= AFlag;
  qrlblTotalTotal.Enabled:= AFlag;
  qrshpTotal1.Enabled:= AFlag;
  qrshpTotal2.Enabled:= AFlag;
  qrshpTotal3.Enabled:= AFlag;

  if AFlag then
  begin
     iInicio:= 24;
     iAltura:= 19;
     iIncCuadro:= 4;
     iIncTexto:= 7;

     qrlblTotalLabel.Top:= iInicio + ( iAltura * AIndice ) + iIncTexto;
     qrlblTotalBase.Top:= qrlblTotalLabel.Top;
     qrlblTotalIva.Top:= qrlblTotalLabel.Top;
     qrlblTotalTotal.Top:= qrlblTotalLabel.Top;
     qrshpTotal1.Top:= iInicio + ( iAltura * AIndice ) + iIncCuadro;
     qrshpTotal2.Top:= qrshpTotal1.Top;
     qrshpTotal3.Top:= qrshpTotal1.Top;

    //NETO
    qrlblTotalBase.Caption:= FormatFloat('#,##0.00', DFactura.mtFacturas_Cab2.FieldByName('importe_neto_fc').AsFloat );
    //IVA
    qrlblTotalIva.Caption:= FormatFloat('#,##0.00', DFactura.mtFacturas_Cab2.FieldByName('importe_impuesto_fc').AsFloat );
    //TOTAL
    qrlblTotalTotal.Caption:= FormatFloat('#,##0.00', DFactura.mtFacturas_Cab2.FieldByName('importe_total_fc').AsFloat );
  end;
end;

procedure TRFactura2.ConfiguraIVA(const AFlag: Boolean);
var iAltura, iAlturaBanda: integer;
begin

  if AFlag then
    iAltura := 25
  else
    iAltura := 0;

  if (DFactura.mtFacturas_Cab2.FieldByName('importe_impuesto_fc').AsFloat <> 0) or
     ((gProgramVersion = pvBAG) and (PaisCliente( DFactura.mtFacturas_Cab2.FieldByName('cod_empresa_fac_fc').AsString,
                                                  DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').AsString ) = 'ES')
                                and( DFactura.mtFacturas_Cab2.FieldByName('cod_cliente_fc').AsString <> 'WEB' )) then
  begin
    qrlDesIva.Enabled:= False;
    qrlDesIvaAlemania.Enabled:= False;
  end
  else
  begin
    qrlDesIva.Top:= qrlDesIva.Top + iAltura;
    qrlDesIva.AutoSize:= False;
    qrlDesIva.Alignment:= taRightJustify;
    qrlDesIva.Width:= qrlDesIvaAlemania.Width;
    qrlDesIva.Left:= qrlDesIvaAlemania.Left;

    qrlDesIva.Enabled:= True;

    qrlDesIva.Caption := DFactura.mtFacturas_Cab2.FieldByName('des_tipo_impuesto_fc').AsString;
    //                   + ' ' + FloatToStr( DFactura.mtFacturas_Bas2.FieldByName('porcentaje_impuesto_fb').AsFloat ) + '%';

    qrlDesIvaAlemania.Enabled:= DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA';
    qrlDesIvaAlemania.Top:= qrlDesIvaAlemania.Top + iAltura;
  end;

  iAlturaBanda := BandaTotales.Height;
  if qrlDesIvaAlemania.Enabled then
    iAlturaBanda := qrlDesIvaAlemania.Top
  else if qrlDesIva.Enabled then
    iAlturaBanda := qrlDesIva.Top
    else if qrLabelTotEur.Enabled then
      iAlturaBanda := qrLabelTotEur.Top;


  if rLin.Height > iAlturaBanda then
    BandaTotales.Height := rLin.Height + 25
  else
    BandaTotales.Height := iAlturaBanda;
end;

procedure TRFactura2.QuickRepAfterPrint(Sender: TObject);
begin
  DFactura.mtFacturas_Bas2.Filter := '';
  DFactura.mtFacturas_Bas2.Filtered := False;

  mtComisiones.Close;
  mtDescuentos.Close;
  mtEurosKg.Close;

  DFactura.QDirSum.Close;
end;

procedure TRFactura2.bndComisionBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblComision.Caption := 'Descuento   del ' + FormatFloat('#,##0.00',
                            mtComisiones.fieldbyname('porcentaje').asfloat) + '%' + '  sobre  ';
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    lblComisionUK.Caption := '-  ' + FormatFloat('#,##0.00', mtComisiones.fieldbyname('porcentaje').asfloat) + '%' + ' bonus   '
  else                                                                                                                          
    lblComisionUK.Caption := '-  ' + FormatFloat('#,##0.00',mtComisiones.fieldbyname('porcentaje').asfloat) + '%' + ' discount of   ';
  Inc(DetallesComision, -1);
end;

procedure TRFactura2.bndDescuentoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  lblDescuento.Caption := 'Descuento   del ' + FormatFloat('#,##0.00',
                            mtDescuentos.fieldbyname('porcentaje').asfloat) + '%' + '  sobre  ';
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    lblDescuentoUK.Caption := '-  ' + FormatFloat('#,##0.00', mtDescuentos.fieldbyname('porcentaje').asfloat) + '%' + ' bonus   '
  else
    lblDescuentoUK.Caption := '-  ' + FormatFloat('#,##0.00',mtDescuentos.fieldbyname('porcentaje').asfloat) + '%' + ' discount of   ';
  Inc(DetallesDescuento, -1);
end;

procedure TRFactura2.bndComisionAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  bndDescuentoComision.Enabled := (DetallesComision = 0) and (DetallesDescuento = 0) and (DetallesEurosKg = 0);
end;

procedure TRFactura2.bndDescuentoAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  bndDescuentoComision.Enabled := (DetallesComision = 0) and (DetallesDescuento = 0) and (DetallesEurosKg = 0);
end;

procedure TRFactura2.BandaGastosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Inc(DetallesGasto, -1);
  BandaGastos.Frame.DrawBottom := DetallesGasto = 0;
end;

procedure TRFactura2.HojaNumPrint(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := 'Hoja/Blatt: ' + Value
  else
    Value := 'Hoja/Page: ' + Value;
end;
procedure TRFactura2.plinPrint(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := ' Zahlung :'
  else
    Value := ' Payment :'
end;

procedure TRFactura2.DescriptiomPrint(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA'
   then
    Value := 'Abzug'
  else
    Value := 'Description'
end;

procedure TRFactura2.PsQRLabel33Print(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := '( Rechnung Nr.'
  else
    Value := '( Invoice N';
end;

procedure TRFactura2.PsQRLabel36Print(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := ''
  else
    Value := 'er';
end;

procedure TRFactura2.PsQRLabel34Print(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := '( Datum )'
  else
    Value := '( Invoice Date )';
end;

procedure TRFactura2.PsQRLabel35Print(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := 'Kunden Nr.'
  else
    Value := 'Cust. Code';
end;

procedure TRFactura2.qrlAlbaran2Print(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := 'Referenz'
  else
    Value := 'Delivery note';
end;

procedure TRFactura2.qrlProducto2Print(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := 'Produkt'
  else
    Value := 'Product';
end;

procedure TRFactura2.qrlCantidad2Print(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := 'Menge'
  else
    Value := 'Qty.';
end;

procedure TRFactura2.qrlUnidad2Print(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := 'Einheiten'
  else
    Value := 'Unit.';
end;

procedure TRFactura2.qrlPrecio2Print(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := 'E�Preis'
  else
    Value := 'Price';
end;

procedure TRFactura2.qrlImporte2Print(sender: TObject; var Value: String);
begin
  if DFactura.mtFacturas_Cab2.FieldByName('des_pais_fc').AsString = 'ALEMANIA' then
    Value := 'Preis Eur'
  else
    Value := 'Amount';
end;

procedure TRFactura2.AsignarTemporales;
begin
  mtComisiones := TkbmMemTable.Create(Self);
  with mtComisiones do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('porcentaje', ftFloat, 0, False);
    FieldDefs.Add('imp_base', ftFloat, 0, False);
    FieldDefs.Add('imp_comision', ftFloat, 0, False);

    CreateTable;
  end;

  mtDescuentos := TkbmMemTable.Create(Self);
  with mtDescuentos do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('porcentaje', ftFloat, 0, False);
    FieldDefs.Add('imp_base', ftFloat, 0, False);
    FieldDefs.Add('imp_descuento', ftFloat, 0, False);

    CreateTable;
  end;

  mtEurosKg := TkbmMemTable.Create(Self);
  with mtEurosKg do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('porcentaje', ftFloat, 0, False);
    FieldDefs.Add('total_kilos', ftFloat, 0, False);
    FieldDefs.Add('importe_euroskg', ftFloat, 0, False);

    CreateTable;
  end;

  bndComision.DataSet := mtComisiones;
  comision_imp_base.DataSet := mtComisiones;
  comision_importe.DataSet := mtComisiones;

  bndDescuento.DataSet := mtDescuentos;
  descuento_imp_base.DataSet := mtDescuentos;
  descuento_importe.DataSet := mtDescuentos;

  bndEurosKg.DataSet := mtEurosKg;
  total_kilos.DataSet := mtEurosKg;
  porcentaje.DataSet := mtEurosKg;
  euroskg_importe.DataSet := mtEurosKg;

end;

function TRFactura2.AsuntoFactura: string;
var sIniFactura, sFinFactura, sIniCliente, sFinCliente: string;
begin
  sIniFactura := DFactura.mtFacturas_Cab2.fieldbyname('n_factura_fc').AsString;
  sFinFactura := DFactura.mtFacturas_Cab2.fieldbyname('n_factura_fc').AsString;

  sIniCliente := DFactura.mtFacturas_Cab2.fieldbyname('cod_cliente_fc').AsString;
  sFinCliente := DFactura.mtFacturas_Cab2.fieldbyname('cod_cliente_fc').AsString;

  if sIniFactura <> sFinFactura then
  begin
    result:= 'Env�o facturas ' + sIniFactura + '-' + sFinFactura;
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
    result:= 'Env�o factura ' + sIniFactura + ' [' + desCliente( sIniCliente ) + ']';
  end;
end;

procedure TRFactura2.ValoresTotalesEur(const AIndice: Integer; AFlag: Boolean);
var
  iInicio, iAltura, iIncCuadro, iIncTexto: Integer;
begin
  qrLabelTotEur.Enabled:= AFlag;
  qrTotalBaseEur.Enabled:= AFlag;
  qrTotalIvaEur.Enabled:= AFlag;
  qrTotalEur.Enabled:= AFlag;
  qrshpTotalEur1.Enabled:= AFlag;
  qrshpTotalEur2.Enabled:= AFlag;
  qrshpTotalEur3.Enabled:= AFlag;

  iInicio:= 24;
  iAltura:= 19;
  iIncCuadro:= 4;
  iIncTexto:= 7;

  if AFlag then
  begin
     qrLabelTotEur.Top:= iInicio + ( iAltura * AIndice ) + (2 * iIncTexto) + iAltura;
     qrTotalBaseEur.Top:= qrLabelTotEur.Top;
     qrTotalIvaEur.Top:= qrLabelTotEur.Top;
     qrTotalEur.Top:= qrLabelTotEur.Top;
     qrshpTotalEur1.Top:= iInicio + ( iAltura * AIndice ) + (3 * iIncCuadro) + iAltura;
     qrshpTotalEur2.Top:= qrshpTotalEur1.Top;
     qrshpTotalEur3.Top:= qrshpTotalEur1.Top;

    //NETO
    qrTotalBaseEur.Caption:= FormatFloat('#,##0.00', DFactura.mtFacturas_Cab2.FieldByName('importe_neto_euros_fc').AsFloat );
    //IVA
    qrTotalIvaEur.Caption:= FormatFloat('#,##0.00', DFactura.mtFacturas_Cab2.FieldByName('importe_impuesto_euros_fc').AsFloat );
    //TOTAL
    qrTotalEur.Caption:= FormatFloat('#,##0.00', DFactura.mtFacturas_Cab2.FieldByName('importe_total_euros_fc').AsFloat );
  end
  else
//    qrlblTotalLabel.Caption := 'Total Euros';
    qrlblTotalLabel.Caption := 'Total ' + DFactura.mtFacturas_Cab2.fieldbyname('moneda_fc').AsString;
end;

procedure TRFactura2.DesactivarBases;
var i: integer;
    Etiqueta:  String;
begin
  for i:= 0 to 2 do
  begin
    Etiqueta := 'qlLabel' + IntToStr(i);
    TQRLabel(FindComponent(Etiqueta)).Enabled := False;

    Etiqueta := 'qsBase' + IntToStr(i);
    TQRShape(FindComponent(Etiqueta)).Enabled := False;
    Etiqueta := 'qsIva' + IntToStr(i);
    TQRShape(FindComponent(Etiqueta)).Enabled := False;
    Etiqueta := 'qsTotal' + IntToStr(i);
    TQRShape(FindComponent(Etiqueta)).Enabled := False;

    Etiqueta := 'qlBase' + IntToStr(i);
    TQRLabel(FindComponent(Etiqueta)).Enabled := False;
    Etiqueta := 'qlIva' + IntToStr(i);
    TQRLabel(FindComponent(Etiqueta)).Enabled := False;
    Etiqueta := 'qlTotal' + IntToStr(i);
    TQRLabel(FindComponent(Etiqueta)).Enabled := False;
  end;

end;

procedure TRFactura2.ActivarBases;
var i: integer;
    Etiqueta: String;
begin
  i := 0;
  while not DFactura.mtFacturas_Bas2.Eof do
  begin
    Etiqueta := 'qsBase' + IntToStr(i);
    TQRShape(FindComponent(Etiqueta)).Enabled := True;
    Etiqueta := 'qsIva' + IntToStr(i);
    TQRShape(FindComponent(Etiqueta)).Enabled := True;
    Etiqueta := 'qsTotal' + IntToStr(i);
    TQRShape(FindComponent(Etiqueta)).Enabled := True;

    Etiqueta := 'qlLabel' + IntToStr(i);
    TQRLabel(FindComponent(Etiqueta)).Enabled := True;
    TQRLabel(FindComponent(Etiqueta)).Caption :=  DFactura.mtFacturas_Bas2.FieldByName('porcentaje_impuesto_fb').AsString + '%';

    Etiqueta := 'qlBase' + IntToStr(i);
    TQRLabel(FindComponent(Etiqueta)).Enabled := True;
    TQRLabel(FindComponent(Etiqueta)).Caption :=  FormatFloat('#,##0.00', DFactura.mtFacturas_Bas2.FieldByName('importe_neto_fb').AsFloat);
    Etiqueta := 'qlIva' + IntToStr(i);
    TQRLabel(FindComponent(Etiqueta)).Enabled := True;
    TQRLabel(FindComponent(Etiqueta)).Caption :=  FormatFloat('#,##0.00', DFactura.mtFacturas_Bas2.FieldByName('importe_impuesto_fb').AsFloat);
    Etiqueta := 'qlTotal' + IntToStr(i);
    TQRLabel(FindComponent(Etiqueta)).Enabled := True;
    TQRLabel(FindComponent(Etiqueta)).Caption :=  FormatFloat('#,##0.00', DFactura.mtFacturas_Bas2.FieldByName('importe_total_fb').AsFloat);

    Inc(i);
    DFactura.mtFacturas_Bas2.Next;
  end;
end;

procedure TRFactura2.CreaQGrupoSAT;
begin
  QGrupoSAT := TBonnyQuery.Create(Self);
  with QGrupoSAT do
  begin
    SQL.Add(' select planta_epl from tempresa_plantas ');
    SQL.Add('  where empresa_epl = :grupo ');
    SQL.Add('    and planta_epl = :planta ');

    Prepare;
  end;
end;

function TRFactura2.EsGrupoSAT: boolean;
begin
  with QGrupoSAT do
  begin
    if Active then
      Close;

    ParamByName('grupo').AsString := 'SAT';
    ParamByName('planta').AsString := DFactura.mtFacturas_Cab2.FieldByName('cod_empresa_fac_fc').AsString;
    Open;

    Result := Not IsEmpty;
  end;
end;

procedure TRFactura2.bndEurosKgBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  lblEurosKg.Caption := 'Descuento   del ' + FormatFloat('#0.000',
//                            mtEurosKg.fieldbyname('porcentaje').asfloat) + ' Euros por Kilogramo ';
  Inc(DetallesEurosKg, -1);
end;

procedure TRFactura2.bndEurosKgAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  bndDescuentoComision.Enabled := (DetallesComision = 0) and (DetallesDescuento = 0) and (DetallesEurosKg = 0);
end;

procedure TRFactura2.bndPieAlbaranBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrsCostePlataforma1.Enabled:= bBruto;
  qrlCostePlataforma.Enabled:= bBruto;
  qrsCostePlataforma2.Enabled:= bBruto;
  qrlKilosPlataforma.Enabled:= bBruto;
  qrsCostePlataforma3.Enabled:= bBruto;
  qrlUnidadPlataforma.Enabled:= bBruto;
  qrsCostePlataforma4.Enabled:= bBruto;
  qrsCostePlataforma5.Enabled:= bBruto;
  if bBruto then
  begin
    bndPieAlbaran.Height:= 17;
    qrlCostePlataforma.Caption:= 'Peso Neto Total';
    qrlUnidadPlataforma.Caption:= 'KGS';
    qrlKilosPlataforma.Caption:= FormatFloat('#,##0',
       GetKilosNeto(
          DFactura.mtFacturas_Cab2.FieldByName('cod_factura_fc').AsString,
          DFactura.mtFacturas_Cab2.FieldByName('cod_empresa_fac_fc').AsString,
          DFactura.mtFacturas_Cab2.FieldByName('cod_serie_fac_fc').AsString,
          DFactura.mtFacturas_Cab2.FieldByName('n_factura_fc').AsInteger,
          DFactura.mtFacturas_Cab2.FieldByName('fecha_factura_fc').AsDateTime )  );
  end
  else
  begin
    bndPieAlbaran.Height:= 0;
  end;
end;

function TRFactura2.GetKilosNeto(const ACodFactura, AEmpresa, ASerie: string; const AFactura: integer; const Afecha: TDateTime ): Real;
begin
  if ACodFactura = 'FCT-F8016-00979' then
    result:= 125
  else
  with DMAuxDB.QAux do
  begin
    with SQL do
    begin
      Clear;
      Add(' SELECT n_albaran_sl, centro_origen_sl, unidad_precio_sl, producto_p, descripcion_p, ');
      Add('       ( select nvl(kilos_tp,0) from frf_tipo_palets where codigo_tp = tipo_palets_sl ) as pesoPalet, ');
      Add('        sum(kilos_sl) as kilosResumen ');
      Add(' FROM frf_salidas_c ');
      Add('      join frf_salidas_l ON (empresa_sl = empresa_sc) AND   (centro_salida_sl = centro_salida_sc) ');
      Add('                         AND   (n_albaran_sl = n_albaran_sc) AND   (fecha_sl = fecha_sc) ');
      Add('      join frf_productos on producto_p = producto_sl ');

      Add(' where empresa_sc = :empresa ');
      Add(' and n_factura_sc = :factura ');
      Add(' and fecha_factura_sc = :fecha ');
      Add(' and serie_fac_sc = :serie ');

      Add(' GROUP BY  n_albaran_sl, centro_origen_sl, unidad_precio_sl, producto_p, descripcion_p, pesoPalet ');
    end;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('factura').AsInteger := AFactura;
    ParamByName('fecha').AsDateTime := AFecha;
    ParamByName('serie').AsString := ASerie;
    try
      Open;
      result := 0;
      while not Eof do
      begin
        result := result + FieldByName('kilosResumen').AsInteger;
        Next;
      end;
    finally
      Close;
    end;

    if result = 0 then
    begin
      SQL.Clear;
      SQL.Add(' select n_albaran_fd, centro_origen_fd, unidad_facturacion_fd, cod_producto_fd, kilos_fd ');
      SQL.Add(' from tfacturas_det ');
      SQL.Add(' where cod_factura_fd = :codFactura ');

      ParamByName('codfactura').AsString := ACodFactura;
      try
        Open;
        while not Eof do
        begin
          result := result + FieldByName('kilos_fd').AsInteger;
          Next;
        end;
      finally
        Close;
      end;
    end;
  end;
end;

end.


