unit FacturasNacionalRI;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, bNumericUtils,
  jpeg, UDMFacturacion;

type
  TRIFacturasNacional = class(TQuickRep)
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
    qrlblTotalBase: TQRLabel;
    qrlblTotalIva: TQRLabel;
    qrlblTotalTotal: TQRLabel;
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
    qlCliente: TQRDBText;
    qlTipoVia: TQRDBText;
    qlDomicilio: TQRDBText;
    qlPoblacion: TQRDBText;
    qlCodProvincia: TQRDBText;
    qlProvincia: TQRDBText;
    qlPais: TQRDBText;
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
    qlCif: TQRLabel;
    bndComision: TQRChildBand;
    PsQRShape17: TQRShape;
    PsQRShape19: TQRShape;
    lblDesComision: TQRLabel;
    lblCantidadComision: TQRLabel;
    CabeceraFactura2: TQRChildBand;
    PsQRShape21: TQRShape;
    qlPais2: TQRDBText;
    qlProvincia2: TQRDBText;
    qlCodProvincia2: TQRDBText;
    qlPoblacion2: TQRDBText;
    qlDomicilio2: TQRDBText;
    qlTipoVia2: TQRDBText;
    qlCliente2: TQRDBText;
    qlCif2: TQRLabel;
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
    qrlblBase: TQRLabel;
    qrlblIVA: TQRLabel;
    qrlblTotal: TQRLabel;
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
    BandaErrorCopia: TQRChildBand;
    BandaNotas: TQRChildBand;
    PsQRLabel51: TQRLabel;
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
    QRLabel1: TQRLabel;
    qretipo_iva_tf: TQRDBText;
    qrlIva1: TQRLabel;
    qrlVAT1: TQRLabel;
    qrlIva2Aux: TQRLabel;
    qrlVat2Aux: TQRLabel;
    qrsVat: TQRShape;
    qrsCabVat: TQRShape;
    qrsVatCab2: TQRShape;
    qrlIncotermLabel1: TQRLabel;
    qrlIncoterm1: TQRLabel;
    qrsIncoterm1: TQRShape;
    qrsIncoterm2: TQRShape;
    qrlIncotermLabel2: TQRLabel;
    qrlIncoterm2: TQRLabel;
    qrsVat2: TQRShape;
    qreiva_tg: TQRDBText;
    qrsVat3: TQRShape;
    qrsVat4: TQRShape;
    qrsVat5: TQRShape;
    qlClienteWEB: TQRLabel;
    qlClienteWEB2: TQRLabel;
    imgQRImgLogo: TQRImage;
    qrlAseguradora: TQRLabel;
    psEtiqueta: TQRLabel;
    HojaNum: TQRLabel;
    sigue: TQRLabel;
    qrmReponsabilidadEnvase: TQRMemo;
    qrshpreducido1: TQRShape;
    qrshpreducido2: TQRShape;
    qrshpreducido3: TQRShape;
    qrshpGeneral1: TQRShape;
    qrshpGeneral2: TQRShape;
    qrshpGeneral3: TQRShape;
    qrshpSuper1: TQRShape;
    qrshpSuper2: TQRShape;
    qrshpSuper3: TQRShape;
    qrshpTotal1: TQRShape;
    qrshpTotal2: TQRShape;
    qrshpTotal3: TQRShape;
    qrlblTotalLabel: TQRLabel;
    qrlblSuperLabel: TQRLabel;
    qrlblSuperbase: TQRLabel;
    qrlblSuperIva: TQRLabel;
    qrlblSupertotal: TQRLabel;
    qrlblReducidoLabel: TQRLabel;
    qrlblReducidoBase: TQRLabel;
    qrlblReducidoIva: TQRLabel;
    qrlblReducidototal: TQRLabel;
    qrlblGeneralLabel: TQRLabel;
    qrlblGeneralBase: TQRLabel;
    qrlblGeneralIva: TQRLabel;
    qrlblGeneralTotal: TQRLabel;
    qrlblLabel: TQRLabel;
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
    procedure qrlMNetoPrint(sender: TObject; var Value: String);
    procedure BandaObservacionesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    sEmpresa: String;
    AlbaranNum: Integer;
    AlbaranGasto: Integer;
    FacturaNum: Integer;

    Detalles: Integer;
    DetallesGasto: Integer;

    bImpresoDescuento: boolean;
    bFlagIVA: Boolean;

    Hoja: Integer;
    NumeroHoja: Integer;
    Bandas: Integer;

    RImportesCabecera: TRImportesCabecera;

    function  NotaFactura: string;

    function Unidades(cad: string): string;
    function CambioFacturacion: Boolean;
    procedure PonProducto;
    procedure CuadroFormaPago;
    procedure ConfigurarGastosYDescuentos;
    procedure ConfiguracionCuadroTotales;
    function  OrdenarIVAS( var iSuper, iReducido, iGeneral: Integer ): integer;
    procedure BaseSuper( const AIndice: Integer; const AFlag: Boolean );
    procedure BaseReducida( const AIndice: Integer; const AFlag: Boolean );
    procedure BaseGeneral( const AIndice: Integer; AFlag: Boolean );
    procedure ValoresTotales( const AIndice: Integer; AFlag: Boolean );
    procedure CabeceraTotales( const AIndice: Integer; AFlag: Boolean );

  public
    bCopia, definitivo, printEmpresa, printOriginal, bIncoterm: Boolean;
    salto: Integer;
    sTextoInformativa: string;
    bHayGranada: Boolean;

    procedure Configurar(const AEmpresa, ACliente: string);
    constructor Create(AOwner: TComponent); override;
  end;

var
  QRLFacturasNacional: TRIFacturasNacional;

implementation

uses CAuxiliarDB, UDMAuxDB, StrUtils, CVariables,
     bMath, bSQLUtils, UDMBaseDatos, bTextUtils, CGlobal;

{$R *.DFM}

constructor TRIFacturasNacional.Create(AOwner: TComponent);
begin
  inherited;
  definitivo := False;
  printEmpresa := True;
  printOriginal := True;
  bCopia := false;
  bIncoterm:= True;
  sTextoInformativa:= 'INFORMATIVA';
end;

procedure TRIFacturasNacional.QuickReport1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  bHayGranada:= false;
  salto := 0;
  AlbaranNum := -1;
  FacturaNum := -2;
  Hoja := 0;
  ReportTitle := StringReplace('Facturas ' + DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString, '.', '', [rfReplaceAll, rfIgnoreCase]);

  if bIncoterm then
  begin
    with DMFacturacion do
    begin
      qrlIncoterm1.Caption:= Incoterm( QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                                     QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString,
                                     QLineaFactura.FieldByName('cod_dir_sum_tf').AsString );
      qrlIncoterm2.Caption:= qrlIncoterm1.Caption;
      qrsIncoterm1.Enabled:= qrlIncoterm2.Caption <> '';
      qrsIncoterm2.Enabled:= qrsIncoterm1.Enabled;
      qrlIncotermLabel1.Enabled:= qrsIncoterm1.Enabled;
      qrlIncotermLabel2.Enabled:= qrsIncoterm1.Enabled;
    end;
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

procedure TRIFacturasNacional.CuadroFormaPago;
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

procedure TRIFacturasNacional.BandaTotalesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin

  CuadroFormaPago;
  ConfiguracionCuadroTotales;

  try
    BandaNotas.Enabled:= not DMFacturacion.QCabeceraFactura.FieldByName('nota_albaran_tfc').IsNull;
  except
    //ERROR Blob incorrecto???
  end;

  if CabeceraFactura2.Color = clWhite then
    BandaTotales.Frame.DrawTop := false
  else
    BandaTotales.Frame.DrawTop := true;
end;

procedure TRIFacturasNacional.CabeceraFacturaBeforePrint(Sender: TQRCustomBand;
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
    if Trim(qlProvincia.DataSet.FieldByName('provincia_tfc').AsString) <> '' then
      qlProvincia.Enabled := true
    else
      qlProvincia.Enabled := false;
    qlCif.Caption := 'C.I.F. : ' +
      self.DataSet.FieldByName('nif_tfc').AsString;

  end;

     //Si no tiene tipo via desplazar domicilio a la izquierda.
  if (Trim(qlTipoVia.DataSet.FieldByName('tipo_via_tfc').AsString) = '') then
  begin
    qlDomicilio.Left := qlTipoVia.Left;
    qlTipoVia.Enabled := false;
    qlTipoVia2.Enabled := false;
  end;
end;

procedure TRIFacturasNacional.BandaLineaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     //Sólo se imprime una vez el numero de albaran- pedido- centro y fecha
     //Deshabilitamos hasta que uno de ellos cambie
  BandaLinea.Frame.DrawBottom := false;
  if AlbaranNum = DMFacturacion.QLineaFactura.FieldByName('albaran_tf').AsInteger then
  begin
    if Albaran.Enabled = true then
    begin
      Albaran.Enabled := false;
      Pedido.Enabled := false;
    end;
    Albaran.Font.Style := Albaran.Font.Style - [fsBold];
    Producto.Font.Style := Albaran.Font.Style - [fsBold];

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
    BandaLinea.Height := 28;

  end
  else
  begin
    Albaran.Enabled := true;
    Pedido.Enabled := true;
    Albarannum := DMFacturacion.QLineaFactura.FieldByName('albaran_tf').AsInteger;

    Albaran.Font.Style := Albaran.Font.Style + [fsBold];
    producto.Font.Style := Albaran.Font.Style + [fsBold];

    BandaLinea.Height := 38;
    Albaran.Top := 11;
    Pedido.Top := 22;
    producto.Top := 11;
    envase.Top := 22;
    cajas.Top := 11;
    unidad.Top := 11;
    PrecioUnidad.Top := 11;
    precio_neto_tf.Top := 11;
    qretipo_iva_tf.Top := 11;
    lin2.Height := 39;
    lin5.Height := 39;
    lin6.Height := 39;
    lin7.Height := 39;
    lin8.Height := 39;
    qrsVat.Height := 39;
  end;


     //******************************************************
     //Descripcion del producto
     //******************************************************
  PonProducto;

     //Segun la unidad de medida este valor seran Kgs, cajas o unidades
  cajas.Caption := Unidades(DMFacturacion.QLineaFactura.FieldByName('unidad_medida_tf').AsString);

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

function TRIFacturasNacional.Unidades(cad: string): string;
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

procedure TRIFacturasNacional.CabeceraGastosAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  CabeceraGastos.Enabled := false;
end;

procedure TRIFacturasNacional.BandaGastosBeforePrint(Sender: TQRCustomBand;
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
  BandaGastos.Frame.DrawBottom := DetallesGasto = 0;
  importe_tg.Mask := '#,##0.00';
end;

procedure TRIFacturasNacional.BonnyBandBeforePrint(Sender: TQRCustomBand;
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

procedure TRIFacturasNacional.PiePaginaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  bSpain: Boolean;
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

  bSpain:= True;
  if bSpain then
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

  //if gProgramVersion = pvSAT then
  begin
    qrmGarantia.Enabled:= True;
    qrmGarantia.Lines.Clear;
    if not bSpain then
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

procedure TRIFacturasNacional.CabeceraLineaBeforePrint(Sender: TQRCustomBand;
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

procedure TRIFacturasNacional.CabeceraFactura2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qlCif2.Caption := qlCif.Caption;
  qlProvincia2.Enabled := qlProvincia.Enabled;
  qlDomicilio2.Left := qlDomicilio.Left;
end;

procedure TRIFacturasNacional.BandaTotalesAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Hoja := 0;
  sigue.Enabled := false;
end;

procedure TRIFacturasNacional.CabeceraFacturaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  sigue.Enabled := true;
  NumeroHoja := 1;
end;

procedure TRIFacturasNacional.BandaLineaAfterPrint(Sender: TQRCustomBand;
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

procedure TRIFacturasNacional.BandaGastosAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if CurrentY > 2645 then
    ForceNewPage;
end;

procedure TRIFacturasNacional.QRLFacturasStartPage(Sender: TCustomQuickRep);
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
    lblNumFactura.Caption:= UpperCase(sTextoInformativa);
  end;
  lblNumFactura2.Caption := lblNumFactura.Caption;
end;

procedure TRIFacturasNacional.CabeceraFactura2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Inc(NumeroHoja);
end;

procedure TRIFacturasNacional.PonProducto;
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

  sProducto := DMFacturacion.QLineaFactura.FieldByName('nom_marca_tf').AsString + ' - ' + sProducto;
  Producto.Caption := sProducto;
  Envase.Caption := sEnvase;
end;

procedure TRIFacturasNacional.Configurar(const AEmpresa, ACliente: string);
var
  bAux: Boolean;
  sAux: string;
  ssEmpresa: string;
begin

  //CLIENTE ONLINE
  if ACliente = 'WEB' then
  begin
    qlCliente.Top:= qlCliente.Top + 9;
    qlTipoVia.Top:= qlTipoVia.Top + 9;
    qlDomicilio.Top:= qlDomicilio.Top + 9;
    qlPoblacion.Top:= qlPoblacion.Top + 9;
    qlCodProvincia.Top:= qlCodProvincia.Top + 9;
    qlProvincia.Top:= qlProvincia.Top + 9;
    qlPais.Top:= qlPais.Top + 9;
    qlCif.Top:= qlCif.Top + 9;
    qlCliente2.Top:= qlCliente2.Top + 9;
    qlTipoVia2.Top:= qlTipoVia2.Top + 9;
    qlDomicilio2.Top:= qlDomicilio2.Top + 9;
    qlPoblacion2.Top:= qlPoblacion2.Top + 9;
    qlCodProvincia2.Top:= qlCodProvincia2.Top + 9;
    qlProvincia2.Top:= qlProvincia2.Top + 9;
    qlPais2.Top:= qlPais2.Top + 9;
    qlCif2.Top:= qlCif2.Top + 9;
    qlClienteWEB.Enabled:= True;
    qlClienteWEB2.Enabled:= True;
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
    (*TODO*)
    (*
    if Now < StrToDate('1/2/2014') then
    begin
      if FileExists( gsDirActual + '\recursos\LogoPicaroGourmet.jpg') then
      begin
        QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\LogoPicaroGourmet.jpg');
      end;
    end
    else
    *)
    begin
      if FileExists( gsDirActual + '\recursos\LogoBongranade.jpg') then
      begin
        QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\LogoBongranade.jpg');
      end
      else
      if FileExists( gsDirActual + '\recursos\BongranadeSanflavino.jpg') then
      begin
        QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\BongranadeSanflavino.jpg');
      end
      else
      if FileExists( gsDirActual + '\recursos\Sanflavino.jpg') then
      begin
        QRImageCab.Picture.LoadFromFile( gsDirActual + '\recursos\Sanflavino.jpg');
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
    ssEmpresa:= AEmpresa;
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

procedure TRIFacturasNacional.PedidoPrint(sender: TObject; var Value: string);
begin
  Value := '';
  if DMFacturacion.QLineaFactura.FieldBYName('pedido_tf').asstring <> '' then
    Value := '(' + DMFacturacion.QLineaFactura.FieldBYName('pedido_tf').asstring + ')  ';
  Value := Value + DMFacturacion.QLineaFactura.FieldBYName('vehiculo_tf').asstring;
end;

procedure TRIFacturasNacional.AlbaranPrint(sender: TObject;
  var Value: string);
begin
  (*ALBARAN*)
    if ( Copy( DMFacturacion.QLineaFactura.FieldBYName('cod_empresa_tf').asstring, 1, 1) = 'F' ) and
       ( DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString <> 'ECI' ) then
    //if ( Copy( DMFacturacion.QLineaFactura.FieldBYName('cod_empresa_tf').asstring, 1, 1) = 'F' ) then
    begin
      Value := Value + ' - ' +
           DMFacturacion.QLineaFactura.FieldBYName('cod_empresa_tf').asstring +
           DMFacturacion.QLineaFactura.FieldBYName('centro_salida_tf').asstring +
           Rellena( DMFacturacion.QLineaFactura.FieldBYName('albaran_tf').asstring, 5, '0', taLeftJustify ) +
           Coletilla( DMFacturacion.QLineaFactura.FieldBYName('cod_empresa_tf').asstring ) +
           ' - ' +  FormatDateTime( 'dd/mm/yy', DMFacturacion.QLineaFactura.FieldBYName('fecha_alb_tf').AsDateTime );

    end
    else
    begin
      Value := Value + ' - ' +
           DMFacturacion.QLineaFactura.FieldBYName('albaran_tf').asstring +
           ' - ' +  FormatDateTime( 'dd/mm/yy', DMFacturacion.QLineaFactura.FieldBYName('fecha_alb_tf').AsDateTime );
    end;
end;


(*******************************************************************************
                 TRADUCIR AL ALEMAN
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)

function TRIFacturasNacional.OrdenarIVAS( var iSuper, iReducido, iGeneral: Integer ): integer;
var
  rSuper, rReducido: Real; //, rGeneral
begin
  //Tipos de IVA ordenados de menor a mayor
  result:= Length( RImportesCabecera.aRImportesBases );
  iSuper:= 0;
  rSuper:= RImportesCabecera.aRImportesBases[0].rTipoIva;
  if result > 1 then
  begin
    if RImportesCabecera.aRImportesBases[1].rTipoIva > rSuper then
    begin
      rReducido:= RImportesCabecera.aRImportesBases[1].rTipoIva;
      iReducido:= 1;
    end
    else
    begin
      rReducido:= rSuper;
      rSuper:= RImportesCabecera.aRImportesBases[1].rTipoIva;
      iReducido:= iSuper;
      iSuper:= 1;
    end;
    if result > 2 then
    begin
      if RImportesCabecera.aRImportesBases[2].rTipoIva > rReducido then
      begin
        //rGeneral:= RImportesCabecera.aRImportesBases[2].rTipoIva;
        iGeneral:= 2;
      end
      else
      begin
        if RImportesCabecera.aRImportesBases[1].rTipoIva > rSuper then
        begin
          //rGeneral:= rReducido;
          //rReducido:= RImportesCabecera.aRImportesBases[2].rTipoIva;
          iGeneral:= iReducido;
          iReducido:= 2;
        end
        else
        begin
          //rGeneral:= rReducido;
          //rReducido:= rSuper;
          //rSuper:= RImportesCabecera.aRImportesBases[2].rTipoIva;
          iGeneral:= iReducido;
          iReducido:= iSuper;
          iSuper:= 2;
        end;
      end;
    end
    else
    begin
      //rGeneral:= 0;
      iGeneral:= -1;
    end;
  end
  else
  begin
    //rReducido:= 0;
    //rGeneral:= 0;
    iReducido:= -1;
    iGeneral:= -1;
  end;
end;

procedure TRIFacturasNacional.BaseSuper( const AIndice: Integer; const AFlag: Boolean );
begin
  qrlblSuperLabel.Enabled:= AFlag;
  qrlblSuperBase.Enabled:= AFlag;
  qrlblSuperIva.Enabled:= AFlag;
  qrlblSuperTotal.Enabled:= AFlag;
  qrshpSuper1.Enabled:= AFlag;
  qrshpSuper2.Enabled:= AFlag;
  qrshpSuper3.Enabled:= AFlag;
  if AFlag then
  begin
    //Pintar valoresa
    qrlblSuperLabel.Caption:= FloatToStr( RImportesCabecera.aRImportesBases[AIndice].rTipoIva ) + '%'; //falta quitar recargo
    qrlblSuperBase.Caption:= FormatFloat('#,##0.00', RImportesCabecera.aRImportesBases[AIndice].rBase );
    qrlblSuperIva.Caption:= FormatFloat('#,##0.00', RImportesCabecera.aRImportesBases[AIndice].rIva );
    qrlblSuperTotal.Caption:= FormatFloat('#,##0.00', RImportesCabecera.aRImportesBases[AIndice].rBase +
                                                    RImportesCabecera.aRImportesBases[AIndice].rIva );
  end;
end;

procedure TRIFacturasNacional.BaseReducida( const AIndice: Integer; const AFlag: Boolean );
begin
  qrlblReducidoLabel.Enabled:= AFlag;
  qrlblReducidoBase.Enabled:= AFlag;
  qrlblReducidoIva.Enabled:= AFlag;
  qrlblReducidoTotal.Enabled:= AFlag;
  qrshpReducido1.Enabled:= AFlag;
  qrshpReducido2.Enabled:= AFlag;
  qrshpReducido3.Enabled:= AFlag;
  if AFlag then
  begin
    //Pintar valoresa
    qrlblReducidoLabel.Caption:= FloatToStr( RImportesCabecera.aRImportesBases[AIndice].rTipoIva ) + '%'; //falta quitar recargo
    qrlblReducidoBase.Caption:= FormatFloat('#,##0.00', RImportesCabecera.aRImportesBases[AIndice].rBase );
    qrlblReducidoIva.Caption:= FormatFloat('#,##0.00', RImportesCabecera.aRImportesBases[AIndice].rIva );
    qrlblReducidoTotal.Caption:= FormatFloat('#,##0.00', RImportesCabecera.aRImportesBases[AIndice].rBase +
                                                    RImportesCabecera.aRImportesBases[AIndice].rIva );
  end;
end;

procedure TRIFacturasNacional.BaseGeneral( const AIndice: Integer; AFlag: Boolean );
begin
  qrlblGeneralLabel.Enabled:= AFlag;
  qrlblGeneralBase.Enabled:= AFlag;
  qrlblGeneralIva.Enabled:= AFlag;
  qrlblGeneralTotal.Enabled:= AFlag;
  qrshpGeneral1.Enabled:= AFlag;
  qrshpGeneral2.Enabled:= AFlag;
  qrshpGeneral3.Enabled:= AFlag;
  if AFlag then
  begin
    //Pintar valoresa
    qrlblGeneralLabel.Caption:= FloatToStr( RImportesCabecera.aRImportesBases[AIndice].rTipoIva ) + '%'; //falta quitar recargo
    qrlblGeneralBase.Caption:= FormatFloat('#,##0.00', RImportesCabecera.aRImportesBases[AIndice].rBase );
    qrlblGeneralIva.Caption:= FormatFloat('#,##0.00', RImportesCabecera.aRImportesBases[AIndice].rIva );
    qrlblGeneralTotal.Caption:= FormatFloat('#,##0.00', RImportesCabecera.aRImportesBases[AIndice].rBase +
                                                    RImportesCabecera.aRImportesBases[AIndice].rIva );
  end;
end;

procedure TRIFacturasNacional.ValoresTotales( const AIndice: Integer; AFlag: Boolean );
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
    qrlblTotalBase.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalBase );
    //IVA
    qrlblTotalIva.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalIva );
    //TOTAL
    qrlblTotalTotal.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalImporte );
  end;
end;

procedure TRIFacturasNacional.CabeceraTotales( const AIndice: Integer; AFlag: Boolean );
begin
  qrlblLabel.Enabled:= AFlag;
  qrlblBase.Enabled:= AFlag;
  qrlblIva.Enabled:= AFlag;
  qrlblTotal.Enabled:= AFlag;

  if AFlag then
  begin
    //CABECERAS
    if ClienteConRecargo( DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                        DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString,
                        DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime ) then
    begin
      //Recargo
      if Copy(DMFacturacion.QCabeceraFactura.FieldByName('cod_iva_tfc').AsString,1,1) = 'I' then
        qrlblLabel.Caption:= 'IVA+Recargo'
      else
        qrlblLabel.Caption:= 'IGIC+Recargo';
    end
    else
    begin
      if Copy(DMFacturacion.QCabeceraFactura.FieldByName('cod_iva_tfc').AsString,1,1) = 'I' then
        qrlblLabel.Caption:= 'IVA/VAT'
      else
        qrlblLabel.Caption:= 'IGIC';
    end;
  end;
end;

procedure TRIFacturasNacional.ConfiguracionCuadroTotales;
var
  i: Integer;
  iSuper, iReducido, iGeneral: integer;
begin
  i:= OrdenarIVAS( iSuper, iReducido, iGeneral );

  BaseSuper( iSuper, True );
  if i > 1 then
  begin
    BaseReducida( iReducido, True );
    if i > 2 then
    begin
      BaseGeneral( iGeneral, True );
    end
    else
    begin
      BaseGeneral( iGeneral, False );
    end;
  end
  else
  begin
    BaseReducida( iReducido, False );
    BaseGeneral( iGeneral, False );
  end;

  ValoresTotales( i, true );
  CabeceraTotales( i, true );
end;

procedure TRIFacturasNacional.ConfigurarGastosYDescuentos;
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
      lblDesComisionUK.Caption := '-  ' + FormatFloat('#,##0.00', RImportesCabecera.rTipoComision) + '%' + ' discount of   ';
      lblPorcentajeComision.Caption := FormatFloat('#,##0.00', RImportesCabecera.rTotalNeto);
      lblCantidadComision.Caption := formatfloat('#,##0.00', RImportesCabecera.rComision);
    end;

    if RImportesCabecera.rDescuento <> 0 then
    begin
      bndDescuento.Enabled := true;
      lblDesDescuento.Caption := 'Descuento del ' + FormatFloat('#,##0.00', RImportesCabecera.rTipoDescuento) + '%' + '  sobre  ';
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
    BandaLinea.Frame.DrawBottom := true;
  end;
  AlbaranGasto := -1;
end;

procedure TRIFacturasNacional.LFecha2Print(sender: TObject; var Value: string);
begin
  Value := DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsString;
end;

procedure TRIFacturasNacional.LabelFechaPrint(sender: TObject; var Value: string);
begin
  Value := DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsString;
end;

procedure TRIFacturasNacional.BandaErrorCopiaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //Si es una copia comprobar que coincida con el original
  PrintBand := bCopia and CambioFacturacion;
end;

function TRIFacturasNacional.CambioFacturacion: boolean;
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

procedure TRIFacturasNacional.bndComisionAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  bndComision.Enabled := false;
end;

procedure TRIFacturasNacional.bndDescuentoAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  bndDescuento.Enabled := false;
end;

procedure TRIFacturasNacional.bndDescuentoComisionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if DetallesGasto > 0 then
    bndDescuentoComision.Frame.DrawBottom := false
  else
    bndDescuentoComision.Frame.DrawBottom := true;
end;

procedure TRIFacturasNacional.bndDescuentoComisionAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if bndDescuentoComision.Enabled then
  begin
    bndDescuentoComision.Enabled:= False;
    bImpresoDescuento := true;
  end;
end;

function TRIFacturasNacional.NotaFactura: string;
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

procedure TRIFacturasNacional.BandaNotasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   QRLabel1.Caption:= NotaFactura;
   PrintBand:= QRLabel1.Caption <> '';
end;

procedure TRIFacturasNacional.qrlMNetoPrint(sender: TObject; var Value: String);
begin
  Value:= DMFacturacion.QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString;
end;

procedure TRIFacturasNacional.BandaObservacionesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   PrintBand:= EsClienteSeguro( sEmpresa, DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString );
  if PrintBand then
  begin
    qrlAseguradora.Enabled:= True;
    if DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime < StrToDate('1/9/2012') then
    begin
      qrlAseguradora.Caption:= 'Operación asegurada en Mapfre.'
    end
    else
    begin
      qrlAseguradora.Caption:= 'Operación asegurada en COFACE'
    end;
  end
  else
  begin
    qrlAseguradora.Enabled:= false;
  end;
end;

end.
