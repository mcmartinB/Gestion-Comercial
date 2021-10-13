unit LFacturasKilos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, bNumericUtils,
  jpeg, UDMFacturacion;

type
  TQRLFacturasKilos = class(TQuickRep)
    BandaTotales: TQRBand;
    PiePagina: TQRBand;
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
    qrlImporteNeto: TQRLabel;
    qrlImporteIva: TQRLabel;
    qrlImporteTotal: TQRLabel;
    qrsTotal: TQRShape;
    qrsIva: TQRShape;
    qrsNeto: TQRShape;
    qrlDesIva: TQRLabel;
    QRChildBand1: TQRChildBand;
    PsQRShape8: TQRShape;
    PsQRShape9: TQRShape;
    CabeceraFactura: TQRGroup;
    PsQRShape1: TQRShape;
    LabelFecha: TQRLabel;
    PsQRShape16: TQRShape;
    PsQRLabel6: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRShape20: TQRShape;
    PsQRShape23: TQRShape;
    PsQRShape22: TQRShape;
    PsQRShape18: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    PsQRLabel9: TQRLabel;
    PsQRShape7: TQRShape;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    tipoVia: TQRDBText;
    domicilio: TQRDBText;
    PsQRDBText5: TQRDBText;
    cod_postal: TQRDBText;
    BDPais: TQRDBText;
    BandaLinea: TQRSubDetail;
    cajas: TQRLabel;
    Unidad: TQRDBText;
    PrecioUnidad: TQRDBText;
    precio_neto_tf: TQRDBText;
    lin2: TQRShape;
    lin5: TQRShape;
    lin6: TQRShape;
    lin7: TQRShape;
    lin8: TQRShape;
    CabeceraGastos: TQRChildBand;
    PsQRLabel7: TQRLabel;
    PsQRShape10: TQRShape;
    BandaGastos: TQRSubDetail;
    descripcion_tg: TQRDBText;
    importe_tg: TQRDBText;
    PsQRShape11: TQRShape;
    PsQRShape12: TQRShape;
    albaran_tg: TQRDBText;
    fecha_alb_tg: TQRDBText;
    PsQRShape13: TQRShape;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    sep3: TQRLabel;
    LabelNif: TQRLabel;
    bndComision: TQRChildBand;
    PsQRShape17: TQRShape;
    PsQRShape19: TQRShape;
    lblDesComision: TQRLabel;
    lblCantidadComision: TQRLabel;
    CabeceraFactura2: TQRChildBand;
    PsQRShape21: TQRShape;
    PsQRDBText8: TQRDBText;
    cod_postal2: TQRDBText;
    PsQRDBText14: TQRDBText;
    Domicilio2: TQRDBText;
    tipoVia2: TQRDBText;
    PsQRDBText17: TQRDBText;
    labelNif2: TQRLabel;
    HojaNum: TQRLabel;
    CabeceraLinea: TQRChildBand;
    ChildBand3: TQRChildBand;
    alb: TQRLabel;
    pro: TQRLabel;
    can: TQRLabel;
    uni: TQRLabel;
    pre: TQRLabel;
    qrlImp1Aux: TQRLabel;
    l1: TQRShape;
    l5: TQRShape;
    l2: TQRShape;
    l3: TQRShape;
    l4: TQRShape;
    con: TQRLabel;
    PsQRShape42: TQRShape;
    PsQRShape43: TQRShape;
    sigue: TQRLabel;
    qrsEuro: TQRShape;
    qrlImporteEuro: TQRLabel;
    qrlMEuro: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRLabel15: TQRLabel;
    PsQRLabel17: TQRLabel;
    PsQRLabel18: TQRLabel;
    PsQRLabel19: TQRLabel;
    qrlImp2: TQRLabel;
    PsQRLabel21: TQRLabel;
    PsQRLabel24: TQRLabel;
    Descriptiom: TQRLabel;
    Date: TQRLabel;
    PsQRLabel31: TQRLabel;
    PsQRDBText18: TQRDBText;
    LFecha2: TQRLabel;
    PsQRShape14: TQRShape;
    PsQRLabel16: TQRLabel;
    PsQRLabel26: TQRLabel;
    PsQRShape15: TQRShape;
    PsQRShape24: TQRShape;
    PsQRShape25: TQRShape;
    PsQRShape26: TQRShape;
    PsQRShape27: TQRShape;
    PsQRShape28: TQRShape;
    PsQRLabel32: TQRLabel;
    PsQRShape30: TQRShape;
    PsQRLabel33: TQRLabel;
    PsQRLabel34: TQRLabel;
    PsQRLabel35: TQRLabel;
    alb2: TQRLabel;
    con2: TQRLabel;
    qrlImp2Aux: TQRLabel;
    pro2: TQRLabel;
    can2: TQRLabel;
    uni2: TQRLabel;
    pre2: TQRLabel;
    qrlNeto: TQRLabel;
    qrlIva: TQRLabel;
    qrlTotal: TQRLabel;
    qrlEuro: TQRLabel;
    qrlMIva: TQRLabel;
    qrlMNeto: TQRLabel;
    plin: TQRLabel;
    rlin: TQRShape;
    Albaran: TQRDBText;
    PsQRLabel36: TQRLabel;
    PsQRLabel25: TQRLabel;
    PsQRLabel37: TQRLabel;
    lblPorcentajeComision: TQRLabel;
    lblDesComisionUK: TQRLabel;
    Producto: TQRLabel;
    Pedido: TQRLabel;
    Envase: TQRLabel;
    psEtiqueta: TQRLabel;
    qrlDesIvaAlemania: TQRLabel;
    BandaErrorCopia: TQRChildBand;
    BandaNotas: TQRChildBand;
    qrlErrofactura: TQRLabel;
    bndDescuento: TQRChildBand;
    bndDescuentoComision: TQRChildBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    lblDesDescuento: TQRLabel;
    lblDesDescuentoUK: TQRLabel;
    lblPorcentajeDescuento: TQRLabel;
    lblCantidadDescuento: TQRLabel;
    lblNumFactura2: TQRLabel;
    lblNumFactura: TQRLabel;
    BandaObservaciones: TQRChildBand;
    BonnyBand: TQRBand;
    QRImageCab: TQRImage;
    PsEmpresa: TQRLabel;
    PsDireccion: TQRLabel;
    PsNif: TQRLabel;
    QRMemoPago: TQRMemo;
    qrlObservacionFactura: TQRLabel;
    qrlMTotal: TQRLabel;
    qretipo_iva_tf: TQRDBText;
    qrlIva1: TQRLabel;
    qrlVAT1: TQRLabel;
    qrlIva2Aux: TQRLabel;
    qrlVat2Aux: TQRLabel;
    qrsVat: TQRShape;
    qrsCabVat: TQRShape;
    qrsVatCab2: TQRShape;
    qrgCabAlbaran: TQRGroup;
    bndPieAlbaran: TQRBand;
    qrsCostePlataforma1: TQRShape;
    qrsCostePlataforma2: TQRShape;
    qrsCostePlataforma3: TQRShape;
    qrsCostePlataforma4: TQRShape;
    qrsCostePlataforma5: TQRShape;
    qrlCostePlataforma: TQRLabel;
    qrlKilosPlataforma: TQRLabel;
    qrlUnidadPlataforma: TQRLabel;
    qrlPrecioPlataforma: TQRLabel;
    qrlImportePlataforma: TQRLabel;
    qrlIncoterm1: TQRLabel;
    qrsIncoterm1: TQRShape;
    qrlIncoterm2: TQRLabel;
    qrsIncoterm2: TQRShape;
    qrlIncotermLabel1: TQRLabel;
    qrlIncotermLabel2: TQRLabel;
    qrsVat3: TQRShape;
    qrsVat4: TQRShape;
    qrsVat2: TQRShape;
    qrsVat5: TQRShape;
    qrmReponsabilidadEnvase: TQRMemo;
    qrlAseguradora: TQRLabel;
    mmoClienteObv: TQRMemo;
    qreiva_tg: TQRDBText;
    qrmGarantia: TQRMemo;
    procedure QuickReport1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BandaTotalesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabeceraFacturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaLineaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabeceraGastosAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndComisionAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BonnyBandBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PiePaginaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabeceraLineaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure CabeceraFactura2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaTotalesAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure CabeceraFacturaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaLineaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaGastosAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRLFacturasStartPage(Sender: TCustomQuickRep);
    procedure CabeceraFactura2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure PedidoPrint(sender: TObject; var Value: string);
    procedure AlbaranPrint(sender: TObject; var Value: string);
    procedure PsQRLabel33Print(sender: TObject; var Value: string);
    procedure PsQRLabel36Print(sender: TObject; var Value: string);
    procedure PsQRLabel34Print(sender: TObject; var Value: string);
    procedure PsQRLabel35Print(sender: TObject; var Value: string);
    procedure alb2Print(sender: TObject; var Value: string);
    procedure pro2Print(sender: TObject; var Value: string);
    procedure can2Print(sender: TObject; var Value: string);
    procedure uni2Print(sender: TObject; var Value: string);
    procedure pre2Print(sender: TObject; var Value: string);
    procedure qrlImp2AuxPrint(sender: TObject; var Value: string);
    procedure HojaNumPrint(sender: TObject; var Value: string);
    procedure plinPrint(sender: TObject; var Value: string);
    procedure DescriptiomPrint(sender: TObject; var Value: string);
    procedure LFecha2Print(sender: TObject; var Value: string);
    procedure LabelFechaPrint(sender: TObject; var Value: string);
    procedure BandaErrorCopiaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDescuentoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndDescuentoComisionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDescuentoComisionAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaNotasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure UnidadPrint(sender: TObject; var Value: String);
    procedure qrlMNetoPrint(sender: TObject; var Value: String);
    procedure qrgCabAlbaranBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieAlbaranBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PrecioUnidadPrint(sender: TObject; var Value: String);
    procedure precio_neto_tfPrint(sender: TObject; var Value: String);
    procedure BandaObservacionesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cod_postalPrint(sender: TObject; var Value: String);
  private
    sEmpresa: String;
    AlbaranNum: Integer;
    AlbaranGasto: Integer;
    FacturaNum: Integer;
    rKilosFacturados: Real;

    Detalles: Integer;
    DetallesGasto: Integer;

    bImpresoDescuento: boolean;
    EnvaseComercial: boolean;
    bFlagIVA: Boolean;

    bPlataforma: Boolean;
    rPrecioPlataforma: real;
    rKilosPlataforma, rCostePlataforma: real;
    rNewImporte, rNewPrecio: real;

    Hoja: Integer;
    NumeroHoja: Integer;
    Bandas: Integer;

    RImportesCabecera: TRImportesCabecera;

    function  NotaFactura: string;

    function Unidades(cad: string): string;
    function CambioFacturacion: Boolean;
    procedure ConfiguraNeto;
    procedure ConfiguraIVA;
    procedure ConfiguraTotal;
    procedure ConfiguraTotalEuros;
    procedure PonProducto;
    procedure CuadroFormaPago;
    procedure ConfigurarGastosYDescuentos;
    procedure ConfiguracionCuadroTotales;
    function  CostePlataforma( const AEmpresa, ACentro: string; const AAlbaran: integer;
                               const AFecha: TDateTime; var APrecioPlataforma: real ): boolean;
    function GetResumen(const AEmpresa: string; const AFactura: integer; const Afecha: TDateTime ): Integer;

  public
    bCopia, definitivo, printEmpresa, printOriginal, bProforma: Boolean;
    salto: Integer;
    bHayGranada: Boolean;
    procedure Configurar(const AEmpresa: string);
    constructor Create(AOwner: TComponent); override;
  end;

var
  QRLFacturasKilos: TQRLFacturasKilos;

implementation

uses UDMAuxDB, CAuxiliarDB, StrUtils, CVariables,
     bMath, bSQLUtils, UDMBaseDatos, DBTables, DB, CGlobal;

{$R *.DFM}

constructor TQRLFacturasKilos.Create(AOwner: TComponent);
begin
  inherited;
  definitivo := False;
  bProforma:= False;
  printEmpresa := True;
  printOriginal := True;
  bCopia := false;
end;

procedure TQRLFacturasKilos.QuickReport1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  bHayGranada:= False;
  salto := 0;
  AlbaranNum := -1;
  FacturaNum := -2;
  Hoja := 0;
  QRLFacturasKilos.ReportTitle := StringReplace('Facturas ' + DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString, '.', '', [rfReplaceAll, rfIgnoreCase]);
  rCostePlataforma:= 0;
  rKilosPlataforma:= 0;
  rKilosFacturados:= 0;

  //Condicion de pago
  if //DataSet.FieldByName('porte_bonny_tfc').AsInteger = 1 ) and
     ( DataSet.FieldByName('incoterm_tfc').AsString <> '' ) then
  begin

    qrlIncoterm1.Caption:= DataSet.FieldByName('incoterm_tfc').AsString + ' ' +
                           DataSet.FieldByName('plaza_incoterm_tfc').AsString;
                           // desIncoterm( DataSet.FieldByName('incoterm_tfc').AsString );
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

procedure TQRLFacturasKilos.CuadroFormaPago;
var
  iDif, iAltura: integer;
begin
  if QRMemoPago.Lines.Count = 0 then
  begin
    with DMFacturacion.QCabeceraFactura do
    begin
      QRMemoPago.Lines.Clear;
      if Trim( FieldByName('descripcion_fp').AsString) = '' then
      begin
        Rlin.Enabled := false;
        Plin.Enabled := false;
      end
      else
      begin
        Plin.Enabled := True;
        Rlin.Enabled := True;

        QRMemoPago.Lines.Add( FieldByName('descripcion_fp').AsString );
        if Trim(FieldByName('descripcion2_fp').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('descripcion2_fp').AsString );
        if Trim(FieldByName('descripcion3_fp').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('descripcion3_fp').AsString );
        if Trim(FieldByName('descripcion4_fp').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('descripcion4_fp').AsString );
        if Trim(FieldByName('descripcion5_fp').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('descripcion5_fp').AsString );
        if Trim(FieldByName('descripcion6_fp').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('descripcion6_fp').AsString );
        if Trim(FieldByName('descripcion7_fp').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('descripcion7_fp').AsString );
        if Trim(FieldByName('descripcion8_fp').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('descripcion8_fp').AsString );
        if Trim(FieldByName('descripcion9_fp').AsString) <> '' then
          QRMemoPago.Lines.Add( FieldByName('descripcion9_fp').AsString );

        iAltura:= 15 + ((  QRMemoPago.Lines.Count - 1 ) * 14 );
        QRMemoPago.Height:= iAltura;
        iAltura:= iAltura + 10;
        if rLin.Height < iAltura then
        begin
          iDif:= iAltura - rLin.Height;
          rLin.Height:= rLin.Height + iDif;
          BandaTotales.Height:= BandaTotales.Height + iDif;
        end;
      end;
    end;
  end;
end;

procedure TQRLFacturasKilos.BandaTotalesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  CuadroFormaPago;
  ConfiguracionCuadroTotales;

  try
    BandaNotas.Enabled:= not DMFacturacion.QCabeceraFactura.FieldByName('nota_albaran_tfc').IsNull;
  except
    //ERROR Blob incorrecto???
  end;

(*
  if EnvaseComercial then
  begin
       //SÓLO PARA CLIENTES ESPAÑOLES
    if Trim(BDPais.DataSet.FieldByName('pais_tfc').AsString) = 'ESPAÑA' then
    begin
      BandaObservaciones.Enabled := true;
      BandaTotales.LinkBand := BandaObservaciones;
    end;
  end
  else
  begin
    BandaObservaciones.Enabled := false;
    BandaTotales.LinkBand := nil;
  end;
*)

  if CabeceraFactura2.Color = clWhite then
    BandaTotales.Frame.DrawTop := false
  else
    BandaTotales.Frame.DrawTop := true;
end;

function CompletaNif( const APais, ANif: string ): string;
begin
  if Pos( APais, ANif ) = 0 then
    Result:= APais + ANif
  else
    Result:= ANif;
end;


procedure TQRLFacturasKilos.CabeceraFacturaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     //Etiquetas de la cabecera, hasta la siguiente factura no cambia
     //el valor que tienen asignado
  if FacturaNum <> DataSet.FieldByName('factura_tfc').AsInteger then
  begin
    FacturaNum := DataSet.FieldByName('factura_tfc').AsInteger;

    bImpresoDescuento := ( DMFacturacion.QCabeceraFactura.FieldByName('descuento_tfc').AsFloat = 0 ) and
                         ( DMFacturacion.QCabeceraFactura.FieldByName('comision_tfc').AsFloat = 0 );

    RImportesCabecera:= DatosTotalesFactura( DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                                             DMFacturacion.QCabeceraFactura.FieldByName('factura_tfc').AsInteger,
                                             DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime
                                             );
    bFlagIVA:= Length(RImportesCabecera.aRImportesBases) = 1;
    if bFlagIVA then
    begin
      qrlIva1.Enabled:= False;
      qrlVat1.Enabled:= False;
      qrlIva2Aux.Enabled:= False;
      qrlVat2Aux.Enabled:= False;
      qretipo_iva_tf.Enabled:= False;
      qrsCabVat.Enabled:= false;
      qrsVatCab2.Enabled:= False;
      precio_neto_tf.Width:=105;
      precio_neto_tf.Left:=605;
      qrsVat.Enabled:= False;
      lblCantidadComision.Width:= 105;
      lblCantidadComision.Left:=605;
      lblCantidadDescuento.Width:= 105;
      lblCantidadDescuento.Left:=605;
      qrsVat3.Enabled:= False;
      qrsVat4.Enabled:= False;
      qrsVat5.Enabled:= False;
      qrsVat2.Enabled:= False;
      qreiva_tg.Enabled:= False;
    end
    else
    begin
      qrlIva1.Enabled:= True;
      qrlVat1.Enabled:= True;
      qrlIva2Aux.Enabled:= True;
      qrlVat2Aux.Enabled:= True;
      qretipo_iva_tf.Enabled:= True;
      qrsCabVat.Enabled:= True;
      qrsVatCab2.Enabled:= True;
      precio_neto_tf.Width:=83;
      precio_neto_tf.Left:=605;
      qrsVat.Enabled:= True;
      lblCantidadComision.Width:= 83;
      lblCantidadComision.Left:=605;
      lblCantidadDescuento.Width:= 83;
      lblCantidadDescuento.Left:=605;
      qrsVat3.Enabled:= True;
      qrsVat4.Enabled:= True;
      qrsVat5.Enabled:= True;
      qrsVat2.Enabled:= True;
      qreiva_tg.Enabled:= True;
    end;

    Detalles := DMFacturacion.QLineaFactura.RecordCount;
    EnvaseComercial := false;
    if Trim(BDPais.DataSet.FieldByName('pais_tfc').AsString) = 'ESPAÑA' then
    begin
      LabelNif.Caption := 'C.I.F. : ' +
        self.DataSet.FieldByName('nif_tfc').AsString;

    end
    else
    begin
      LabelNif.Caption := 'V.A.T. : ' +  CompletaNif( self.DataSet.FieldByName('pais_c').AsString, self.DataSet.FieldByName('nif_tfc').AsString );
    end;
  end;

     //Si no tiene tipo via desplazar domicilio a la izquierda.
  if (Trim(tipoVia.DataSet.FieldByName('tipo_via_tfc').AsString) = '') then
  begin
    domicilio.Left := tipoVia.Left;
    tipoVia.Enabled := false;
    tipoVia2.Enabled := false;
  end;
end;

procedure TQRLFacturasKilos.BandaLineaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rAux: real;
begin
     //Sólo se imprime una vez el numero de albaran- pedido- centro y fecha
     //Deshabilitamos hasta que uno de ellos cambie
  bndPieAlbaran.Frame.DrawBottom := false;
  if AlbaranNum = DMFacturacion.QLineaFactura.FieldByName('albaran_tf').AsInteger then
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
    cajas.Top := 0;
    unidad.Top := 0;
    PrecioUnidad.Top := 0;
    precio_neto_tf.Top := 0;
    qretipo_iva_tf.Top := 0;
    lin2.Height := 29;
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
    Albarannum := DMFacturacion.QLineaFactura.FieldByName('albaran_tf').AsInteger;

    Albaran.Font.Style := Albaran.Font.Style + [fsBold];
    producto.Font.Style := Albaran.Font.Style + [fsBold];

    BandaLinea.Height := 33;

    Albaran.Top := 6;
    Pedido.Top := 17;
    producto.Top := 6;
    envase.Top := 17;
    cajas.Top := 6;
    unidad.Top := 6;
    PrecioUnidad.Top := 6;
    precio_neto_tf.Top := 6;
    qretipo_iva_tf.Top := 6;
    lin2.Height := 34;
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
  cajas.Caption := Unidades(DMFacturacion.QLineaFactura.FieldByName('unidad_medida_tf').AsString);

     //Con que un sólo envase se comercial hay que escribrir el texto asociado
     //al final de la factura. Aqui levantamos el flag para indicarlo
  if DMFacturacion.QLineaFactura.FieldByName('envase_comer_tf').AsString = 'S' then
    EnvaseComercial := true;

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

  rKilosFacturados:= rKilosFacturados + DMFacturacion.QLineaFactura.FieldBYName('kilos_tf').AsFloat;
  //qrlblKilos.Caption:= FormatFloat( '#,##0.00', DMFacturacion.QLineaFactura.FieldBYName('kilos_tf').AsFloat);

  if bPlataforma then
  begin
    rAux:= bRoundTo( DMFacturacion.QLineaFactura.FieldBYName('kilos_tf').AsFloat * rPrecioPlataforma, 2 );
    rNewImporte:= DMFacturacion.QLineaFactura.FieldBYName('precio_neto_tf').AsFloat + rAux;

    rCostePlataforma:= rCostePlataforma + rAux;
    rKilosPlataforma:= rKilosPlataforma + bRoundTo(DMFacturacion.QLineaFactura.FieldBYName('kilos_tf').AsFloat,0);

    if UpperCase( DMFacturacion.QLineaFactura.FieldByName('unidad_medida_tf').AsString ) = 'KGS' then
    begin
      rNewPrecio:=  bRoundTo( rNewImporte / DMFacturacion.QLineaFactura.FieldBYName('kilos_tf').AsFloat, 3 );
    end
    else
    if UpperCase( DMFacturacion.QLineaFactura.FieldByName('unidad_medida_tf').AsString )  = 'UND' then
    begin
      rNewPrecio:=  bRoundTo( rNewImporte / DMFacturacion.QLineaFactura.FieldBYName('unidades_tf').AsFloat, 3 );
    end
    else
    if UpperCase( DMFacturacion.QLineaFactura.FieldByName('unidad_medida_tf').AsString )  = 'CAJ' then
    begin
      rNewPrecio:=  bRoundTo( rNewImporte / DMFacturacion.QLineaFactura.FieldBYName('cajas_tf').AsFloat, 3 );
    end;
  end;
end;

function TQRLFacturasKilos.Unidades(cad: string): string;
begin
     //Cantidad  cajas
  with DMFacturacion.QLineaFactura do
    if cad = 'CAJ' then
    begin
      Unidades := FieldByName('cajas_tf').AsString;
    end
    else
      if cad = 'UND' then
      begin
        Unidades := FieldByName('unidades_tf').AsString;
      end
      else
        if cad = 'KGS' then
        begin
          Unidades := FormatFloat('#,##0.00', FieldByName('kilos_tf').AsFloat);
        end;
end;

procedure TQRLFacturasKilos.CabeceraGastosAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  CabeceraGastos.Enabled := false;
end;

procedure TQRLFacturasKilos.BandaGastosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if AlbaranGasto = DMFacturacion.QLineaGastos.FieldByName('albaran_tg').AsInteger then
  begin
    if albaran_tg.Enabled = true then
    begin
      Albaran_tg.Enabled := false;
      Fecha_Alb_tg.Enabled := false;
      sep3.Enabled := false;
    end;
  end
  else
  begin
    Albaran_tg.Enabled := true;
    Fecha_Alb_tg.Enabled := true;
    sep3.Enabled := true;
    AlbaranGasto := DMFacturacion.QLineaGastos.FieldByName('albaran_tg').AsInteger;
  end;

  Inc(DetallesGasto, -1);
  importe_tg.Mask := '#,##0.00';
  BandaGastos.Frame.DrawBottom := DetallesGasto = 0;
end;

procedure TQRLFacturasKilos.BonnyBandBeforePrint(Sender: TQRCustomBand;
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
end;

procedure TQRLFacturasKilos.PiePaginaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
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

  if Trim(DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString) = 'ESPAÑA' then
  begin
    qrmReponsabilidadEnvase.Lines.Clear;
    qrmReponsabilidadEnvase.Lines.Add('"De conformidad con lo establecido en la ley 11/1997, de 24 de abril, de envases y residuos de envases y, el artículo 18.1 del  Real Decreto 782/1998,  de 30 de Abril que desarrolla');
    qrmReponsabilidadEnvase.Lines.Add('la Ley 11/1997; el responsable de la entrega  del residuo de envase o envase usado para su correcta  gestión ambiental de aquellos envases no identificados mediante el Punto Verde');
    if bHayGranada then
      qrmReponsabilidadEnvase.Lines.Add('(sistema integrado de gestión  de Ecoembes), será el poseedor final del mismo".                                                                          ENTIDAD DE CONTROL ES-ECO-020-CV.  GRANADA ECO.')
    else
      qrmReponsabilidadEnvase.Lines.Add('(sistema integrado de gestión  de Ecoembes), será el poseedor final del mismo".                                                                          ');
  end
  else
  begin
    qrmReponsabilidadEnvase.Lines.Clear;
    qrmReponsabilidadEnvase.Lines.Add('"In accordance with which it is established in law 11/1997 dated April 24th about packaging and packaging waste, according to article 18.1 of Royal decree 782/1998 dated April');
    qrmReponsabilidadEnvase.Lines.Add('30th that develops law 11/1997; the responsible for the delivery of packaging and packaging waste used for proper enviroment management  from those packaging non identified by');
    if bHayGranada then
      qrmReponsabilidadEnvase.Lines.Add('the green point (inegrated management system Ecoembes), will be the final holder".                                                        ENTIDAD DE CONTROL ES-ECO-020-CV.  POMEGRANATE ECO.')
    else
      qrmReponsabilidadEnvase.Lines.Add('the green point (inegrated management system Ecoembes), will be the final holder".                                                        ');
  end;

  (*Vuelto a poner a peticion de Esther Cuerda, si alguien vuelve a pedir que se quite que hable con ella*)
  //if gProgramVersion = pvSAT then
  begin
    qrmGarantia.Enabled:= True;
    qrmGarantia.Lines.Clear;
    if not ( Trim(DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString) = 'ESPAÑA' ) then
    begin
      qrmGarantia.Lines.Add( 'Partial or complete rejections should be communicated and quantified no later than 48 hours after the reception of the goods by email or fax.' );
      if CGlobal.gProgramVersion = CGlobal.pvSAT then
        qrmGarantia.Lines.Add( 'All the fruit and vegatables produts packed by S.A.T. Nº9359 BONNYSA are certified according to GLOBALGAP (EUREPGAP) IFA V5.0 product standards.     GGN=4049928415684');
    end
    else
    begin
      qrmGarantia.Lines.Add( 'Las incidencias deben ser comunicadas y cuantificadas  por escrito dentro del plazo de 48 horas posteriores a la descarga de la mercancía.' );
      if CGlobal.gProgramVersion = CGlobal.pvSAT then
        qrmGarantia.Lines.Add( 'Toda la producción hortofrutícola comercializada por S.A.T. Nº9359 BONNYSA está certificada conforme a la norma GLOBALGAP (EUREPGAP) IFA V5.0.    GGN=4049928415684');
    end;

    if CGlobal.gProgramVersion = CGlobal.pvSAT then
      qrmReponsabilidadEnvase.Top:= 25
    else
      qrmReponsabilidadEnvase.Top:= 15;
    psEtiqueta.Top:= 65;
    HojaNum.Top:= 65;
    sigue.Top:= 65;
    PiePagina.Height:= 82;
  end;
  (*
  else
  begin
    qrmGarantia.Enabled:= False;  
    qrmReponsabilidadEnvase.Top:= 0;
    psEtiqueta.Top:= 40;
    HojaNum.Top:= 40;
    sigue.Top:= 40;
    PiePagina.Height:= 57;
  end;
  *)
end;

procedure TQRLFacturasKilos.CabeceraLineaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if detalles >= 0 then
  begin
    CabeceraLinea.Color := cl3DLight;
    alb.Enabled := true;
    pro.Enabled := true;
    con.Enabled := false;
    can.Enabled := true;
    pre.Enabled := true;
    qrlImp1Aux.Enabled := true;
    qrlImp2Aux.Enabled := true;
    uni.Enabled := true;
    alb2.Enabled := true;
    pro2.Enabled := true;
    con2.Enabled := false;
    can2.Enabled := true;
    pre2.Enabled := true;
    qrlIva2Aux.Enabled := true;
    qrlVat2Aux.Enabled := true;
    qrsCabVat.Enabled:= True;
    qrsVatCab2.Enabled:= True;

    uni2.Enabled := true;
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
      alb.Enabled := true;
      pro.Enabled := false;
      con.Enabled := true;
      can.Enabled := false;
      pre.Enabled := false;
      qrlImp1Aux.Enabled := true;
      qrlImp2Aux.Enabled := true;
      uni.Enabled := false;
      alb2.Enabled := true;
      pro2.Enabled := false;
      con2.Enabled := true;
      can2.Enabled := false;
      pre2.Enabled := false;
      qrlIva2Aux.Enabled := true;
      qrlVat2Aux.Enabled := true;
      qrsCabVat.Enabled:= True;
      qrsVatCab2.Enabled:= True;
      uni2.Enabled := false;
      l1.Enabled := true;
      l5.Enabled := false;
      l2.Enabled := false;
      l3.Enabled := False;
      l4.Enabled := true;
    end
    else
    begin
      CabeceraLinea.Color := clWhite;
      alb.Enabled := false;
      pro.Enabled := false;
      con.Enabled := false;
      can.Enabled := false;
      pre.Enabled := false;
      qrlImp1Aux.Enabled := False;
      qrlImp2Aux.Enabled := False;
      uni.Enabled := false;
      alb2.Enabled := false;
      pro2.Enabled := false;
      con2.Enabled := false;
      can2.Enabled := false;
      pre2.Enabled := false;
      qrlIva2Aux.Enabled := False;
      qrlVat2Aux.Enabled := False;
      qrsCabVat.Enabled:= False;
      qrsVatCab2.Enabled:= False;
      uni2.Enabled := false;
      l1.Enabled := false;
      l5.Enabled := false;
      l2.Enabled := false;
      l3.Enabled := false;
      l4.Enabled := false;
    end;
end;

procedure TQRLFacturasKilos.CabeceraFactura2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  labelNif2.Caption := LabelNif.Caption;
  Domicilio2.Left := domicilio.Left;
end;

procedure TQRLFacturasKilos.BandaTotalesAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Hoja := 0;
  sigue.Enabled := false;
end;

procedure TQRLFacturasKilos.CabeceraFacturaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  sigue.Enabled := true and (DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString <> 'ALEMANIA');
  NumeroHoja := 1;
end;

procedure TQRLFacturasKilos.BandaLineaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if CurrentY > 2645 then
  begin
    ForceNewPage;

       //Para volver a imprimir albaran- pedido- centro y fecha
       //en la primera Lines de la segunda hoja, aunque sea el mismo de la hoja
       //anterior
    if Albarannum = DMFacturacion.QLineaFactura.FieldByName('albaran_tf').AsInteger then
      Albarannum := 0;
  end;
end;

procedure TQRLFacturasKilos.BandaGastosAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if CurrentY > 2645 then
    ForceNewPage;
end;

procedure TQRLFacturasKilos.QRLFacturasStartPage(Sender: TCustomQuickRep);
begin
     //Nueva hoja
  Inc(Hoja);
  Bandas := 0;

  if definitivo then
  begin
    lblNumFactura.Caption:= NewCodigoFactura( DataSet.FieldByName('cod_empresa_tfc').AsString,
                      DataSet.FieldByName('tipo_factura_tfc').AsString,
                      DataSet.FieldByName('cod_iva_tfc').AsString,
                      DataSet.FieldByName('fecha_tfc').AsDateTime,
                      DataSet.FieldByName('n_factura_tfc').AsInteger );
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

procedure TQRLFacturasKilos.CabeceraFactura2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Inc(NumeroHoja);
end;

procedure TQRLFacturasKilos.PonProducto;
var sProducto, sEnvase: string;
begin
  if not bHayGranada then
    bHayGranada:= DMFacturacion.QLineaFactura.FieldByName('cod_producto_tf').asstring = 'W';
     //POR DEFECTO EN CASTELLANO
  sEnvase := desEnvaseClienteEx(
    DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
    DMFacturacion.QLineaFactura.FieldByName('cod_producto_tf').asstring,
    DMFacturacion.QLineaFactura.FieldByName('cod_envase_tf').asstring,
    DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString);
     //sEnvase:=DMFacturacion.QLineaFactura.FieldByName('envase_tf').asstring;
  sProducto := DMFacturacion.QLineaFactura.FieldByName('producto_tf').AsString;
  Producto.Font.Style := producto.Font.Style;
  Producto.Top := producto.Top;

  if Trim(BDPais.DataSet.FieldByName('pais_tfc').AsString) <> 'ESPAÑA' then
  begin
       //ENVASE
       (*if Trim(DMFacturacion.QLineaFactura.FieldByName('descripcion2_e').asstring)<>'' then
       begin
         sEnvase :=DMFacturacion.QLineaFactura.FieldByName('descripcion2_e').asstring;
       end;*)

       //PRODUCTO
    if ((Trim(DMFacturacion.QLineaFactura.FieldByName('cod_producto_tf').AsString) = 'E') or
      (Trim(DMFacturacion.QLineaFactura.FieldByName('cod_producto_tf').AsString) = 'T')) and
      (UpperCase(Copy(DMFacturacion.QLineaFactura.FieldByName('calibre_tf').AsString, 1, 1)) = 'G') and
      (DMFacturacion.QLineaFactura.FieldByName('cod_envase_tf').AsString <> '001') then
    begin
      sProducto := 'BEEF';
    end
    else
      if Trim(DMFacturacion.QLineaFactura.FieldByName('producto2_tf').asstring) <> '' then
      begin
         //Descripcion en ingles
        sProducto := Trim(DMFacturacion.QLineaFactura.FieldByName('producto2_tf').AsString);
      end;
  end;

     //******************************************************
     //SÓLO VISUALIZAMOS CALIBRE PARA TImage PENINSULA Y TENERIFE
     //******************************************************
  if (DMFacturacion.QLineaFactura.FieldByName('cod_producto_tf').AsString = 'T') or
    (DMFacturacion.QLineaFactura.FieldByName('cod_producto_tf').AsString = 'E') then
  begin
    sProducto := sProducto + ' (' + DMFacturacion.QLineaFactura.FieldByName('calibre_tf').AsString + ')';
  end;

  if (DMFacturacion.QLineaFactura.FieldByName('cod_producto_tf').AsString = 'F') and
     (DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString = 'MER') then
  begin
    sProducto := 'TOMATE CHERRY';
  end;

  sProducto := DMFacturacion.QLineaFactura.FieldByName('nom_marca_tf').AsString + ' - ' + sProducto;
  Producto.Caption := sProducto;
  Envase.Caption := sEnvase;
end;

procedure TQRLFacturasKilos.Configurar(const AEmpresa: string);
var
  bAux: Boolean;
  sAux, ssEmpresa: string;
begin
  sEmpresa:= AEmpresa;
      if ( AEmpresa = '050' ) or ( AEmpresa = '050' ) then
      ssEmpresa:= '080'
    else
      ssEmpresa:= AEmpresa;
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
    ConsultaOpen(DMAuxDB.QAux,
      ' select nombre_e,nif_e,tipo_via_e,domicilio_e,cod_postal_e, ' +
      '        poblacion_e,nombre_p ' +
      ' from frf_empresas,frf_provincias ' +
      ' where empresa_e=' + QuotedStr(Trim(AEmpresa)) +
      '   and cod_postal_e[1,2]=codigo_p');

    with DMAuxDB.QAux do
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

procedure TQRLFacturasKilos.PedidoPrint(sender: TObject; var Value: string);
begin
  Value := '';
  if DMFacturacion.QLineaFactura.FieldBYName('pedido_tf').asstring <> '' then
    Value := '(' + DMFacturacion.QLineaFactura.FieldBYName('pedido_tf').asstring + ')  ';

  //BORRRAR
  if ( DMFacturacion.QLineaFactura.FieldBYName('albaran_tf').asstring  = '240452' ) and (DMFacturacion.QLineaFactura.FieldBYName('fecha_alb_tf').asstring  = '27/04/2012' ) then
     Value := Value + 'BY TRUCK R6459BCD/BY SEA'
  else
     Value := Value + DMFacturacion.QLineaFactura.FieldBYName('vehiculo_tf').asstring;


end;

procedure TQRLFacturasKilos.AlbaranPrint(sender: TObject;
  var Value: string);
begin
  Value := Value + ' - ' + DMFacturacion.QLineaFactura.FieldBYName('albaran_tf').asstring +
    ' - ' + DMFacturacion.QLineaFactura.FieldBYName('fecha_alb_tf').asstring;
end;


(*******************************************************************************
                 TRADUCIR AL ALEMAN
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)

procedure TQRLFacturasKilos.PsQRLabel33Print(sender: TObject;
  var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := 'Rechnung Nr.'
  else
    Value := 'Invoice N';
end;

procedure TQRLFacturasKilos.PsQRLabel36Print(sender: TObject;
  var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := ''
  else
    Value := 'er';
end;

procedure TQRLFacturasKilos.PsQRLabel34Print(sender: TObject;
  var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := 'Datum'
  else
    Value := 'Date';
end;

procedure TQRLFacturasKilos.PsQRLabel35Print(sender: TObject;
  var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := 'Kunden Nr.'
  else
    Value := 'Cust. Code';
end;

procedure TQRLFacturasKilos.alb2Print(sender: TObject; var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := 'Referenz'
  else
    Value := 'Delivery note';
end;

procedure TQRLFacturasKilos.pro2Print(sender: TObject; var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := 'Produkt'
  else
    Value := 'Product';
end;

procedure TQRLFacturasKilos.can2Print(sender: TObject; var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := 'Menge'
  else
    Value := 'Qty.';
end;

procedure TQRLFacturasKilos.uni2Print(sender: TObject; var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := 'Einheiten'
  else
    Value := 'Unit.';
end;

procedure TQRLFacturasKilos.pre2Print(sender: TObject; var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := 'E´Preis'
  else
    Value := 'Price';
end;

procedure TQRLFacturasKilos.qrlImp2AuxPrint(sender: TObject; var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := 'Preis Eur'
  else
    Value := 'Amount';
end;

procedure TQRLFacturasKilos.ConfiguraNeto;
begin
  qrlNeto.Enabled:= True;
  qrlMNeto.Enabled:= True;
  qrsNeto.Enabled:= True;
  qrlImporteNeto.Enabled:= True;
  qrlImporteNeto.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalBase );


  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
  begin
    qrlNeto.Caption:= 'Total / Gesamtbetrag';
  end
  else
  begin
    qrlNeto.Caption:= 'Total Neto / Net'
  end;
end;

procedure TQRLFacturasKilos.ConfiguraIVA;
begin
  if RImportesCabecera.rTotalIva <> 0 then
  begin
    (*RECARGO*)
    if ClienteConRecargo( DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                          DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString,
                          DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime ) then
    begin
      qrlIva.Top:= 34;
      qrlIva.Enabled:= True;
      qrlMIva.Enabled:= True;
      qrlMIva.Caption:= DMFacturacion.QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString;
      qrsIva.Enabled:= True;
      qrlImporteIva.Enabled:= True;
      qrlImporteIva.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalIva );

      qrlDesIva.Top:= 48;
      qrlDesIva.AutoSize:= True;
      qrlDesIva.Alignment:= taLeftJustify;
      qrlDesIva.Left:= qrlIva.Left;

      qrlDesIva.Enabled:= True;
      qrlDesIva.Caption:= '+Recargo equivalencia'; //recargo
      qrlDesIvaAlemania.Enabled:= False;

      if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
      begin
        if Copy(DMFacturacion.QCabeceraFactura.FieldByName('cod_iva_tfc').AsString,1,1) = 'I' then
          qrlIva.Caption:= 'Total IVA / VAT'
        else
          qrlIva.Caption:= 'Total IGIC';
      end
      else
      begin
        if Copy(DMFacturacion.QCabeceraFactura.FieldByName('cod_iva_tfc').AsString,1,1) = 'I' then
          qrlIva.Caption:= 'Total IVA / VAT'
        else
          qrlIva.Caption:= 'Total IGIC';
      end;
      if bFlagIVA then
      begin
        qrlIva.Caption:= qrlIva.Caption + ' ' + FloatToStr( RImportesCabecera.aRImportesBases[0].rTipoIva ) + '%';  
      end;
    end
    else
    begin
      qrlIva.Top:= 40;
      qrlIva.Enabled:= True;
      qrlMIva.Enabled:= True;
      qrlMIva.Caption:= DMFacturacion.QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString;
      qrsIva.Enabled:= True;
      qrlImporteIva.Enabled:= True;
      qrlImporteIva.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalIva );

      qrlDesIva.Enabled:= False;
      qrlDesIvaAlemania.Enabled:= False;

      if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
      begin
        if Copy(DMFacturacion.QCabeceraFactura.FieldByName('cod_iva_tfc').AsString,1,1) = 'I' then
          qrlIva.Caption:= 'Total IVA / VAT'
        else
          qrlIva.Caption:= 'Total IGIC';
      end
      else
      begin
        if Copy(DMFacturacion.QCabeceraFactura.FieldByName('cod_iva_tfc').AsString,1,1) = 'I' then
          qrlIva.Caption:= 'Total IVA / VAT'
        else
          qrlIva.Caption:= 'Total IGIC';
      end;
      if bFlagIVA then
      begin
        qrlIva.Caption:= qrlIva.Caption + ' ' + FloatToStr( RImportesCabecera.aRImportesBases[0].rTipoIva ) + '%';
      end;
    end;
  end
  else
  begin
    qrlIva.Enabled:= False;
    qrlMIva.Enabled:= False;
    qrsIva.Enabled:= False;
    qrlImporteIva.Enabled:= False;

    qrlDesIva.Top:= 40;
    qrlDesIva.AutoSize:= False;
    qrlDesIva.Alignment:= taRightJustify;
    qrlDesIva.Width:= qrlDesIvaAlemania.Width;
    qrlDesIva.Left:= qrlDesIvaAlemania.Left;

    qrlDesIva.Enabled:= True;
    qrlDesIva.Caption := DMFacturacion.QCabeceraFactura.FieldByName('descrip_iva_tfc').AsString +
                         ' ' + FloatToStr( RImportesCabecera.aRImportesBases[0].rTipoIva ) + '%';

    qrlDesIvaAlemania.Enabled:= DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA';
  end;
end;

procedure TQRLFacturasKilos.ConfiguraTotal;
begin
  if RImportesCabecera.rTotalIva <> 0 then
  begin
    qrlTotal.Enabled:= True;
    qrlMTotal.Enabled:= True;
    qrlMTotal.Caption:= DMFacturacion.QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString;
    qrsTotal.Enabled:= True;
    qrlImporteTotal.Enabled:= True;
    qrlImporteTotal.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalImporte );

    if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    begin
      qrlTotal.Caption:= 'Total Factura / Invoice';
    end
    else
    begin
      qrlTotal.Caption:= 'Total Factura / Invoice'
    end;
  end
  else
  begin
    qrlTotal.Enabled:= False;
    qrlMTotal.Enabled:= False;
    qrsTotal.Enabled:= False;
    qrlImporteTotal.Enabled:= False;
  end;
end;

procedure TQRLFacturasKilos.ConfiguraTotalEuros;
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString <> 'EUR' then
  begin
    qrlEuro.Enabled:= True;
    qrlMEuro.Enabled:= True;
    qrsEuro.Enabled:= True;
    qrlImporteEuro.Enabled:= True;
    qrlImporteEuro.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalEuros );

    if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    begin
      qrlEuro.Caption:= 'Total Euro';
    end
    else
    begin
      qrlEuro.Caption:= 'Total Euro'
    end;
  end
  else
  begin
    qrlEuro.Enabled:= False;
    qrlMEuro.Enabled:= False;
    qrsEuro.Enabled:= False;
    qrlImporteEuro.Enabled:= False;
  end;
end;

procedure TQRLFacturasKilos.ConfiguracionCuadroTotales;
begin
  ConfiguraNeto;
  ConfiguraIVA;
  ConfiguraTotal;
  ConfiguraTotalEuros;
end;

procedure TQRLFacturasKilos.ConfigurarGastosYDescuentos;
begin
  DetallesGasto := DMFacturacion.QLineaGastos.RecordCount;
  if (DetallesGasto > 0) or not ( bImpresoDescuento ) then
  begin
    CabeceraGastos.Enabled:= True;
    bndComision.Enabled:= RImportesCabecera.rComision <> 0;
    bndDescuento.Enabled:= RImportesCabecera.rDescuento <> 0;
    bndDescuentoComision.Enabled:= bndComision.Enabled or bndDescuento.Enabled;
    BandaGastos.Enabled:= (DetallesGasto > 0);

    if RImportesCabecera.rComision <> 0 then
    begin
      lblDesComision.Caption := 'Descuento   del ' + FormatFloat('#,##0.00', RImportesCabecera.rTipoComision) + '%' + '  sobre  ';
      if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
        lblDesComisionUK.Caption := '-  ' + FormatFloat('#,##0.00', RImportesCabecera.rTipoComision) + '%' + ' bonus   '
      else
        lblDesComisionUK.Caption := '-  ' + FormatFloat('#,##0.00', RImportesCabecera.rTipoComision) + '%' + ' discount of   ';
      lblPorcentajeComision.Caption := FormatFloat('#,##0.00', RImportesCabecera.rTotalNeto);
      lblCantidadComision.Caption := formatfloat('#,##0.00', RImportesCabecera.rComision);
    end;

    if RImportesCabecera.rDescuento <> 0 then
    begin
      bndDescuento.Enabled := true;
      lblDesDescuento.Caption := 'Descuento del ' + FormatFloat('#,##0.00', RImportesCabecera.rTipoDescuento) + '%' + '  sobre  ';
      if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
        lblDesDescuentoUK.Caption := '-  ' + FormatFloat('#,##0.00', RImportesCabecera.rTipoDescuento) + '%' + ' bonus   '
      else
        lblDesDescuentoUK.Caption := '-  ' + FormatFloat('#,##0.00', RImportesCabecera.rTipoDescuento) + '%' + ' discount of   ';
      lblPorcentajeDescuento.Caption := FormatFloat('#,##0.00', RImportesCabecera.rTotalNeto - RImportesCabecera.rComision);
      lblCantidadDescuento.Caption := formatfloat('#,##0.00', RImportesCabecera.rDescuento);
    end;

    if (DetallesGasto = 0) then
    begin
      DetallesGasto := -1;
    end;
  end
  else
  begin
    bndPieAlbaran.Frame.DrawBottom := true;
  end;
  AlbaranGasto := -1;
end;

procedure TQRLFacturasKilos.HojaNumPrint(sender: TObject; var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := 'Hoja/Blatt: ' + Value
  else
    Value := 'Hoja/Page: ' + Value;
end;

procedure TQRLFacturasKilos.plinPrint(sender: TObject; var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA' then
    Value := ' Zahlung :'
  else
    Value := ' Payment :'
end;

procedure TQRLFacturasKilos.DescriptiomPrint(sender: TObject;
  var Value: string);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ALEMANIA'
   then
    Value := 'Abzug'
  else
    Value := 'Description'
end;

procedure TQRLFacturasKilos.LFecha2Print(sender: TObject; var Value: string);
begin
  Value := DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsString;
end;

procedure TQRLFacturasKilos.LabelFechaPrint(sender: TObject; var Value: string);
begin
  Value := DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsString;
end;

procedure TQRLFacturasKilos.BandaErrorCopiaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //Si es una copia comprobar que coincida con el original
  PrintBand:= bCopia and CambioFacturacion;
end;

function TQRLFacturasKilos.CambioFacturacion: boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select importe_total_f from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add(' and n_factura_f = :factura ');
    SQL.Add(' and fecha_factura_f = :fecha ');
    ParamByName('empresa').AsString := DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString;
    ParamByName('factura').AsInteger := DMFacturacion.QCabeceraFactura.FieldByName('n_factura_tfc').AsInteger;
    ParamByName('fecha').AsDateTime := DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime;
    if OpenQuery(DMAuxDB.QAux) then
    begin
      result := bRoundTo(FieldByName('importe_total_f').AsFloat, -2) <> bRoundTo(RImportesCabecera.rTotalImporte, -2);
    end
    else
    begin
      Result := True;
    end;
    Close;
  end;
end;

procedure TQRLFacturasKilos.bndComisionAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  bndComision.Enabled := false;
end;

procedure TQRLFacturasKilos.bndDescuentoAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  bndDescuento.Enabled := false;
end;

procedure TQRLFacturasKilos.bndDescuentoComisionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if DetallesGasto > 0 then
    bndDescuentoComision.Frame.DrawBottom := false
  else
    bndDescuentoComision.Frame.DrawBottom := true;
end;

procedure TQRLFacturasKilos.bndDescuentoComisionAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if bndDescuentoComision.Enabled then
  begin
    bndDescuentoComision.Enabled:= False;
    bImpresoDescuento := true;
  end;
end;

function TQRLFacturasKilos.NotaFactura: string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nota_albaran_tfc ');
    SQL.Add(' from tmp_facturas_c ');
    SQL.Add(' where usuario_tfc = :usuario ');
    SQL.Add(' and cod_empresa_tfc = :empresa ');
    SQL.Add(' and factura_tfc = :factura ');
    SQL.Add(' and fecha_tfc = :fecha ');
    ParamByName('empresa').AsString:= DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString;
    ParamByName('usuario').AsString:= DMFacturacion.QCabeceraFactura.FieldByName('usuario_tfc').AsString;
    ParamByName('factura').AsString:= DMFacturacion.QCabeceraFactura.FieldByName('factura_tfc').AsString;
    ParamByName('fecha').AsString:= DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsString;
    try
      Open;
      if not isEmpty then
      begin
        result:= FieldByName('nota_albaran_tfc').AsString;
      end;
    except
      result:= '';
    end;
  end;
end;

procedure TQRLFacturasKilos.BandaNotasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  sAux: string;
begin
  sAux:= NotaFactura;
  if sAux <> '' then
  begin
    qrlObservacionFactura.Caption:= sAux;
    PrintBand:= True;
  end
  else
  begin
    PrintBand:= false;
  end;

end;

procedure TQRLFacturasKilos.UnidadPrint(sender: TObject; var Value: String);
begin
(*
  if EsLiquido( DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                DMFacturacion.QLineaFactura.FieldByName('cod_envase_tf').asstring ) and
     ( DMFacturacion.QLineaFactura.FieldByName('unidad_medida_tf').AsString = 'KGS' ) then
  begin
      Value:= 'LITROS';
  end;
*)
end;

procedure TQRLFacturasKilos.qrlMNetoPrint(sender: TObject; var Value: String);
begin
  Value:= DMFacturacion.QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString;
end;

procedure TQRLFacturasKilos.qrgCabAlbaranBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgCabAlbaran.Height:= 0;

  //Buscar si tiene coste de plataforma
  bPlataforma:= CostePlataforma( DMFacturacion.QLineaFactura.FieldBYName('cod_empresa_tf').asstring,
                                 DMFacturacion.QLineaFactura.FieldBYName('centro_salida_tf').asstring,
                                 DMFacturacion.QLineaFactura.FieldBYName('albaran_tf').asInteger,
                                 DMFacturacion.QLineaFactura.FieldBYName('fecha_alb_tf').AsDateTime,
                                 rPrecioPlataforma );
end;

function TQRLFacturasKilos.CostePlataforma( const AEmpresa, ACentro: string; const AAlbaran: integer;
                                       const AFecha: TDateTime; var APrecioPlataforma: real ): boolean;
var
  sCliente: string;
begin
  if gbPlataforma then
  begin
    with DMFacturacion.QCosteEstadistico do
    begin
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('albaran').AsInteger:= AAlbaran;
      ParamByName('fecha').AsDateTime:= AFecha;
      Open;
      result:= not IsEmpty;
      sCliente:= FieldByName('cliente_dal').AsString;
      Close;
    end;

    if result then
    begin
      with DMFacturacion.QCosteKgPlataforma do
      begin
        ParamByName('empresa').AsString:= AEmpresa;
        ParamByName('centro').AsString:= ACentro;
        ParamByName('albaran').AsInteger:= AAlbaran;
        ParamByName('fecha').AsDateTime:= AFecha;
        ParamByName('cliente').AsString:= sCliente;
        Open;
        APrecioPlataforma:= FieldByName('fob_plataforma_p').AsFloat;
        Close;
      end;
      result:= APrecioPlataforma <> 0;
    end
    else
    begin
      APrecioPlataforma:= 0;
    end;
  end
  else
  begin
    result:= false;
  end;
end;

procedure TQRLFacturasKilos.PrecioUnidadPrint(sender: TObject;
  var Value: String);
begin
  if bPlataforma then
  begin
    Value:= FormatFloat('#,##0.000', rNewPrecio );
  end;
end;

procedure TQRLFacturasKilos.precio_neto_tfPrint(sender: TObject;
  var Value: String);
begin
  if bPlataforma then
  begin
    Value:= FormatFloat('#,##0.00', rNewImporte );
  end;
end;

function TQRLFacturasKilos.GetResumen(const AEmpresa: string; const AFactura: integer; const Afecha: TDateTime ): Integer;
begin
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
      Add('      join frf_productos on empresa_p = empresa_sl and producto_p = producto_sl ');

      Add(' where empresa_sc = :empresa ');
      Add(' and n_factura_sc = :factura ');
      Add(' and fecha_factura_sc = :fecha ');

      Add(' GROUP BY  n_albaran_sl, centro_origen_sl, unidad_precio_sl, producto_p, descripcion_p, pesoPalet ');
    end;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('factura').AsInteger := AFactura;
    ParamByName('fecha').AsDateTime := AFecha;
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
  end;
end;

procedure TQRLFacturasKilos.bndPieAlbaranBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bPlataforma then
  begin
    bndPieAlbaran.Height:= 17;
    qrlCostePlataforma.Caption:= 'Coste Plataforma';
    qrlUnidadPlataforma.Caption:= 'KGS';
    qrlKilosPlataforma.Caption:= FormatFloat('#,##0,00', rKilosPlataforma );
    if rKilosPlataforma > 0 then
      qrlPrecioPlataforma.Caption:= FormatFloat('#,##0.000', bRoundTo( rCostePlataforma / rKilosPlataforma, 3) )
    else
      qrlPrecioPlataforma.Caption:= FormatFloat('#,##0.000', 0 );
    qrlImportePlataforma.Caption:= FormatFloat('#,##0.00', -1 * rCostePlataforma  );

    qrsCostePlataforma1.Enabled:= True;
    qrsCostePlataforma2.Enabled:= True;
    qrsCostePlataforma3.Enabled:= True;
    qrsCostePlataforma4.Enabled:= True;
    qrsCostePlataforma5.Enabled:= True;

    bndPieAlbaran.Frame.DrawTop:= False;
  end
  else
  begin
    bndPieAlbaran.Height:= 17;
    qrlCostePlataforma.Caption:= 'Peso Neto Total';
    qrlUnidadPlataforma.Caption:= 'KGS';

    qrlKilosPlataforma.Caption:= FormatFloat('#,##0', GetResumen( Dataset.FieldByName('cod_empresa_tfc').AsString, Dataset.FieldByName('factura_tfc').AsInteger, Dataset.FieldByName('fecha_tfc').AsDateTime )  );
    rKilosFacturados:= 0;

    qrlPrecioPlataforma.Enabled:= false;
    qrlImportePlataforma.Enabled:= false;

    qrsCostePlataforma1.Enabled:= False;
    qrsCostePlataforma2.Enabled:= False;
    qrsCostePlataforma3.Enabled:= False;
    qrsCostePlataforma4.Enabled:= False;
    qrsCostePlataforma5.Enabled:= False;

    bndPieAlbaran.Frame.DrawTop:= True;
  end;
  rCostePlataforma:= 0;
  rKilosPlataforma:= 0;
end;

procedure TQRLFacturasKilos.BandaObservacionesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= EsClienteSeguro( sEmpresa, DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString );
  if PrintBand then
  begin
    qrlAseguradora.Enabled:= True;
    if DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime < StrToDate('1/3/2012') then
    begin
      if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ESPAÑA' then
        qrlAseguradora.Caption:= 'Operación asegurada en Mapfre.'
      else
        qrlAseguradora.Caption:= 'Mapfre insured operation.';
    end
    else
    begin
      if DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString = 'ESPAÑA' then
        qrlAseguradora.Caption:= 'Operación asegurada en COFACE'
      else
        qrlAseguradora.Caption:= 'COFACE insured operation.';
    end;
  end
  else
  begin
    qrlAseguradora.Enabled:= false;
  end;

  if (DataSet.FieldByName('cod_cliente_tfc').AsString = 'FD') or
     (DataSet.FieldByName('cod_cliente_tfc').AsString = 'BUR') then
  begin
    if not PrintBand then
    begin
      PrintBand:= true;
    end;
    mmoClienteObv.Lines.Clear;
    if (DataSet.FieldByName('cod_cliente_tfc').AsString = 'FD') then
    begin
      with mmoClienteObv do
      begin
        Lines.Add('SUPLIER NUMBER: 91105');
        //Lines.Add('81');
      end;
    end
    else
    if (DataSet.FieldByName('cod_cliente_tfc').AsString = 'BUR') then
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

procedure TQRLFacturasKilos.cod_postalPrint(sender: TObject; var Value: String);
begin
  if Trim(BDPais.DataSet.FieldByName('pais_tfc').AsString) = 'ESPAÑA' then
  begin
    Value := Trim( Value + ' ' + DataSet.FieldByName('provincia_tfc').AsString );
  end;
end;

end.
