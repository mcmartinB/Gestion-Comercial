unit LFacturasWEB;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, bNumericUtils,
  jpeg, UDMFacturacion;

type
  TQRLFacturasWEB = class(TQuickRep)
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
    PsQRDBText6: TQRDBText;
    BDProvincia: TQRDBText;
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
    bndComision: TQRChildBand;
    PsQRShape17: TQRShape;
    PsQRShape19: TQRShape;
    lblDesComision: TQRLabel;
    lblCantidadComision: TQRLabel;
    CabeceraFactura2: TQRChildBand;
    PsQRShape21: TQRShape;
    PsQRDBText8: TQRDBText;
    BDProvincia2: TQRDBText;
    PsQRDBText13: TQRDBText;
    PsQRDBText14: TQRDBText;
    Domicilio2: TQRDBText;
    tipoVia2: TQRDBText;
    PsQRDBText17: TQRDBText;
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
    qrlNeto: TQRLabel;
    qrlIva: TQRLabel;
    qrlTotal: TQRLabel;
    qrlEuro: TQRLabel;
    qrlMIva: TQRLabel;
    qrlMNeto: TQRLabel;
    plin: TQRLabel;
    rlin: TQRShape;
    Albaran: TQRDBText;
    lblPorcentajeComision: TQRLabel;
    Producto: TQRLabel;
    Pedido: TQRLabel;
    Envase: TQRLabel;
    psEtiqueta: TQRLabel;
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
    lblPorcentajeDescuento: TQRLabel;
    lblCantidadDescuento: TQRLabel;
    lblNumFactura2: TQRLabel;
    lblNumFactura: TQRLabel;
    BandaObservaciones: TQRChildBand;
    BonnyBand: TQRBand;
    QRMemoPago: TQRMemo;
    QRLabel1: TQRLabel;
    qrlMTotal: TQRLabel;
    qretipo_iva_tf: TQRDBText;
    qrlIva1: TQRLabel;
    qrlIva2Aux: TQRLabel;
    qrsVat: TQRShape;
    qrsCabVat: TQRShape;
    qrsVatCab2: TQRShape;
    qrlblClienteOnline: TQRLabel;
    qrshpClienteOnline: TQRShape;
    qrshpClienteOnline2: TQRShape;
    qrlblClienteOnline2: TQRLabel;
    QRImageCab: TQRImage;
    QRImgLogo: TQRImage;
    qrepais: TQRDBText;
    qrenif: TQRDBText;
    qrlAseguradora: TQRLabel;
    qrmReponsabilidadEnvase: TQRMemo;
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
    procedure HojaNumPrint(sender: TObject; var Value: string);
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
    procedure NomPais(sender: TObject; var Value: String);
    procedure NumNif(sender: TObject; var Value: String);
    procedure BandaObservacionesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlblClienteOnlinePrint(sender: TObject; var Value: String);
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
    procedure ConfiguraNeto;
    procedure ConfiguraIVA;
    procedure ConfiguraTotal;
    procedure ConfiguraTotalEuros;
    procedure PonProducto;
    procedure CuadroFormaPago;
    procedure ConfigurarGastosYDescuentos;
    procedure ConfiguracionCuadroTotales;

  public
    bCopia, definitivo, printEmpresa, printOriginal, bIncoterm: Boolean;
    salto: Integer;
    bHayGranada: boolean;
    sTextoInformativa: string;

    procedure Configurar;
    constructor Create(AOwner: TComponent); override;
  end;

var
  QRLFacturasWEB: TQRLFacturasWEB;

implementation

uses CAuxiliarDB, UDMAuxDB, StrUtils, CVariables,
     bMath, bSQLUtils, UDMBaseDatos, bTextUtils, CGlobal;

{$R *.DFM}

constructor TQRLFacturasWEB.Create(AOwner: TComponent);
begin
  inherited;
  definitivo := False;
  printEmpresa := True;
  printOriginal := True;
  bCopia := false;
  bIncoterm:= True;
  sTextoInformativa:= 'INFORMATIVA';
end;

procedure TQRLFacturasWEB.QuickReport1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  bHayGranada:= False;
  salto := 0;
  AlbaranNum := -1;
  FacturaNum := -2;
  Hoja := 0;
  QRLFacturasWEB.ReportTitle := StringReplace('Facturas ' + DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString, '.', '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TQRLFacturasWEB.CuadroFormaPago;
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

procedure TQRLFacturasWEB.BandaTotalesBeforePrint(Sender: TQRCustomBand;
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

procedure TQRLFacturasWEB.CabeceraFacturaBeforePrint(Sender: TQRCustomBand;
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
      qrlIva2Aux.Enabled:= False;
      qretipo_iva_tf.Enabled:= False;
      qrsCabVat.Enabled:= false;
      qrsVatCab2.Enabled:= False;
      precio_neto_tf.Width:=105;
      precio_neto_tf.Left:=605;
      qrsVat.Enabled:= False;
    end
    else
    begin
      qrlIva1.Enabled:= True;
      qrlIva2Aux.Enabled:= True;
      qretipo_iva_tf.Enabled:= True;
      qrsCabVat.Enabled:= True;
      qrsVatCab2.Enabled:= True;
      precio_neto_tf.Width:=83;
      precio_neto_tf.Left:=605;
      qrsVat.Enabled:= True;
    end;

    Detalles := DMFacturacion.QLineaFactura.RecordCount;
  end;

     //Si no tiene tipo via desplazar domicilio a la izquierda.
  if (Trim(tipoVia.DataSet.FieldByName('tipo_via').AsString) = '') then
  begin
    domicilio.Left := tipoVia.Left;
    domicilio2.Left := tipoVia2.Left;
    tipoVia.Enabled := false;
    tipoVia2.Enabled := false;
  end;
end;

procedure TQRLFacturasWEB.BandaLineaBeforePrint(Sender: TQRCustomBand;
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

function TQRLFacturasWEB.Unidades(cad: string): string;
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

procedure TQRLFacturasWEB.CabeceraGastosAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  CabeceraGastos.Enabled := false;
end;

procedure TQRLFacturasWEB.BandaGastosBeforePrint(Sender: TQRCustomBand;
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

procedure TQRLFacturasWEB.BonnyBandBeforePrint(Sender: TQRCustomBand;
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

procedure TQRLFacturasWEB.PiePaginaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  psEtiqueta.Left:= 12;
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

  if Trim( DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString ) = 'ESPAÑA' then
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
    if not ( Trim(DMFacturacion.QCabeceraFactura.FieldByName('pais_tfc').AsString ) = 'ESPAÑA' ) then
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

procedure TQRLFacturasWEB.CabeceraLineaBeforePrint(Sender: TQRCustomBand;
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
    uni.Enabled := true;
    qrlIva2Aux.Enabled := true;
    qrsCabVat.Enabled:= True;
    qrsVatCab2.Enabled:= True;

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
      uni.Enabled := false;
      qrlIva2Aux.Enabled := true;
      qrsCabVat.Enabled:= True;
      qrsVatCab2.Enabled:= True;
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
      uni.Enabled := false;
      qrlIva2Aux.Enabled := False;
      qrsCabVat.Enabled:= False;
      qrsVatCab2.Enabled:= False;
      l1.Enabled := false;
      l5.Enabled := false;
      l2.Enabled := false;
      l3.Enabled := false;
      l4.Enabled := false;
    end;
end;

procedure TQRLFacturasWEB.CabeceraFactura2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  BDProvincia2.Enabled := BDProvincia.Enabled;
  Domicilio2.Left := domicilio.Left;
end;

procedure TQRLFacturasWEB.BandaTotalesAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Hoja := 0;
  sigue.Enabled := false;
end;

procedure TQRLFacturasWEB.CabeceraFacturaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  sigue.Enabled := true;
  NumeroHoja := 1;
end;

procedure TQRLFacturasWEB.BandaLineaAfterPrint(Sender: TQRCustomBand;
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

procedure TQRLFacturasWEB.BandaGastosAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if CurrentY > 2645 then
    ForceNewPage;
end;

procedure TQRLFacturasWEB.QRLFacturasStartPage(Sender: TCustomQuickRep);
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
    //lblNumFactura.Caption:= 'INFORMATIVA';
  end;
  lblNumFactura2.Caption := lblNumFactura.Caption;
end;

procedure TQRLFacturasWEB.CabeceraFactura2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Inc(NumeroHoja);
end;

procedure TQRLFacturasWEB.PonProducto;
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

procedure TQRLFacturasWEB.Configurar;
var
  ssEmpresa: string;
  bAux: Boolean;
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString = 'WEB' then
  begin
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
        QRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\LogoBongranade.jpg');
      end
      else
      if FileExists( gsDirActual + '\recursos\BongranadeSanflavino.jpg') then
      begin
        QRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\BongranadeSanflavino.jpg');
      end
      else
      if FileExists( gsDirActual + '\recursos\Sanflavino.jpg') then
      begin
        QRImgLogo.Picture.LoadFromFile( gsDirActual + '\recursos\Sanflavino.jpg');
      end;
    end;
    QRImgLogo.AutoSize:= false;
    QRImgLogo.Height:= 95;
    QRImgLogo.Width:= 244;
    QRImgLogo.Top:= -21;
    QRImgLogo.Left:= 22;
  end
  else
  begin
    QRImgLogo.Enabled:= False;

    //RESTO DE CLIENTES
    if Copy( DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString, 1, 1 ) = 'F' then
      ssEmpresa:= 'BAG'
    else
      ssEmpresa:= DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString;
    sEmpresa:= DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString;
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
    end;
  end;
end;

procedure TQRLFacturasWEB.PedidoPrint(sender: TObject; var Value: string);
begin
  Value := '';
  if DMFacturacion.QLineaFactura.FieldBYName('pedido_tf').asstring <> '' then
    Value := '(' + DMFacturacion.QLineaFactura.FieldBYName('pedido_tf').asstring + ')  ';
  Value := Value + DMFacturacion.QLineaFactura.FieldBYName('vehiculo_tf').asstring;
end;

procedure TQRLFacturasWEB.AlbaranPrint(sender: TObject;
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

procedure TQRLFacturasWEB.ConfiguraNeto;
begin
  qrlNeto.Enabled:= True;
  qrlMNeto.Enabled:= True;
  qrsNeto.Enabled:= True;
  qrlImporteNeto.Enabled:= True;
  qrlImporteNeto.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalBase );
  qrlNeto.Caption:= 'Total Neto'
end;

procedure TQRLFacturasWEB.ConfiguraIVA;
begin
  if RImportesCabecera.rTotalIva <> 0 then
  begin
    qrlIva.Enabled:= True;
    qrlMIva.Enabled:= True;
    qrlMIva.Caption:= DMFacturacion.QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString;
    qrsIva.Enabled:= True;
    qrlImporteIva.Enabled:= True;
    qrlImporteIva.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalIva );

    qrlDesIva.Enabled:= False;

      if Copy(DMFacturacion.QCabeceraFactura.FieldByName('cod_iva_tfc').AsString,1,1) = 'I' then
        qrlIva.Caption:= 'Total IVA '
      else
        qrlIva.Caption:= 'Total IGIC';
    if bFlagIVA then
    begin
      qrlIva.Caption:= qrlIva.Caption + ' ' + FloatToStr( RImportesCabecera.aRImportesBases[0].rTipoIva ) + '%';
    end;
  end
  else
  begin
    qrlIva.Enabled:= False;
    qrlMIva.Enabled:= False;
    qrsIva.Enabled:= False;
    qrlImporteIva.Enabled:= False;

    qrlDesIva.Enabled:= True;
    qrlDesIva.Caption := DMFacturacion.QCabeceraFactura.FieldByName('descrip_iva_tfc').AsString +
                         ' ' + FloatToStr( RImportesCabecera.aRImportesBases[0].rTipoIva ) + '%';
  end;
end;

procedure TQRLFacturasWEB.ConfiguraTotal;
begin
  if RImportesCabecera.rTotalIva <> 0 then
  begin
    qrlTotal.Enabled:= True;
    qrlMTotal.Enabled:= True;
    qrlMTotal.Caption:= DMFacturacion.QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString;
    qrsTotal.Enabled:= True;
    qrlImporteTotal.Enabled:= True;
    qrlImporteTotal.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalImporte );

    qrlTotal.Caption:= 'Total Factura'
  end
  else
  begin
    qrlTotal.Enabled:= False;
    qrlMTotal.Enabled:= False;
    qrsTotal.Enabled:= False;
    qrlImporteTotal.Enabled:= False;
  end;
end;

procedure TQRLFacturasWEB.ConfiguraTotalEuros;
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString <> 'EUR' then
  begin
    qrlEuro.Enabled:= True;
    qrlMEuro.Enabled:= True;
    qrsEuro.Enabled:= True;
    qrlImporteEuro.Enabled:= True;
    qrlImporteEuro.Caption:= FormatFloat('#,##0.00', RImportesCabecera.rTotalEuros );

    qrlEuro.Caption:= 'Total Euro'
  end
  else
  begin
    qrlEuro.Enabled:= False;
    qrlMEuro.Enabled:= False;
    qrsEuro.Enabled:= False;
    qrlImporteEuro.Enabled:= False;
  end;
end;

procedure TQRLFacturasWEB.ConfiguracionCuadroTotales;
begin
  ConfiguraNeto;
  ConfiguraIVA;
  ConfiguraTotal;
  ConfiguraTotalEuros;
end;

procedure TQRLFacturasWEB.ConfigurarGastosYDescuentos;
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
      lblPorcentajeComision.Caption := FormatFloat('#,##0.00', RImportesCabecera.rTotalNeto);
      lblCantidadComision.Caption := formatfloat('#,##0.00', RImportesCabecera.rComision);
    end;

    if RImportesCabecera.rDescuento <> 0 then
    begin
      bndDescuento.Enabled := true;
      lblDesDescuento.Caption := 'Descuento del ' + FormatFloat('#,##0.00', RImportesCabecera.rTipoDescuento) + '%' + '  sobre  ';
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

procedure TQRLFacturasWEB.HojaNumPrint(sender: TObject; var Value: string);
begin
  Value := 'Hoja: ' + Value;
end;

procedure TQRLFacturasWEB.LFecha2Print(sender: TObject; var Value: string);
begin
  Value := DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsString;
end;

procedure TQRLFacturasWEB.LabelFechaPrint(sender: TObject; var Value: string);
begin
  Value := DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsString;
end;

procedure TQRLFacturasWEB.BandaErrorCopiaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //Si es una copia comprobar que coincida con el original
  PrintBand := bCopia and CambioFacturacion;
end;

function TQRLFacturasWEB.CambioFacturacion: boolean;
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

procedure TQRLFacturasWEB.bndComisionAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  bndComision.Enabled := false;
end;

procedure TQRLFacturasWEB.bndDescuentoAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  bndDescuento.Enabled := false;
end;

procedure TQRLFacturasWEB.bndDescuentoComisionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if DetallesGasto > 0 then
    bndDescuentoComision.Frame.DrawBottom := false
  else
    bndDescuentoComision.Frame.DrawBottom := true;
end;

procedure TQRLFacturasWEB.bndDescuentoComisionAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if bndDescuentoComision.Enabled then
  begin
    bndDescuentoComision.Enabled:= False;
    bImpresoDescuento := true;
  end;
end;

function TQRLFacturasWEB.NotaFactura: string;
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

procedure TQRLFacturasWEB.BandaNotasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   QRLabel1.Caption:= NotaFactura;
   PrintBand:= QRLabel1.Caption <> '';
end;

procedure TQRLFacturasWEB.qrlMNetoPrint(sender: TObject; var Value: String);
begin
  Value:= DMFacturacion.QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString;
end;

procedure TQRLFacturasWEB.NomPais(sender: TObject;
  var Value: String);
begin
  Value:= desPais( value );
end;

procedure TQRLFacturasWEB.NumNif(sender: TObject; var Value: String);
begin
  if Value <> '' then
  begin
    Value:= 'C.I.F.: ' + Value;
  end;
end;

procedure TQRLFacturasWEB.BandaObservacionesBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= EsClienteSeguro( sEmpresa, DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString );
  if PrintBand then
  begin
    qrlAseguradora.Enabled:= True;
    if DMFacturacion.QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime < StrToDate('1/9/2012') then
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
end;

procedure TQRLFacturasWEB.qrlblClienteOnlinePrint(sender: TObject;
  var Value: String);
begin
  if DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString = 'WEB' then
  begin
    Value:= 'Ventas cliente online.';
  end
  else
  if DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString = 'CON' then
  begin
    Value:= 'Ventas cliente contado';
  end
  else
  begin
    Value:= '';
  end;
end;

end.
