unit BeneficioProductoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLBeneficioProducto = class(TQuickRep)
    bndTituloListado: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    PageFooterBand1: TQRBand;
    bndCabeceraListado: TQRBand;
    qrgCabProducto: TQRGroup;
    QRDBText9: TQRDBText;
    bndDetalle: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    bndPieProducto: TQRBand;
    qreProducto: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    qrxCajasProducto: TQRExpr;
    qrxPesoProducto: TQRExpr;
    QRSysData1: TQRSysData;
    QRLabel11: TQRLabel;
    fecha: TQRDBText;
    QRLabel3: TQRLabel;
    qrlImporteProducto: TQRLabel;
    QRLabel8: TQRLabel;
    qrlPrecioProducto: TQRLabel;
    lblImporte: TQRLabel;
    lblPrecio: TQRLabel;
    qrgCabEntrega: TQRGroup;
    QRLabel13: TQRLabel;
    bndPieEntrega: TQRBand;
    qreentrega: TQRDBText;
    qrxCajasEntrega: TQRExpr;
    qrxPresoEntrega: TQRExpr;
    qrlImporteEntrega: TQRLabel;
    qrlPrecioEntrega: TQRLabel;
    lblRangoFechas: TQRLabel;
    lblProveedor: TQRLabel;
    qrefecha: TQRDBText;
    qrlDetalleFactura: TQRLabel;
    qrlDetalleGastos: TQRLabel;
    qrlGasto: TQRLabel;
    qrlCoste: TQRLabel;
    qrlCosteEntrega: TQRLabel;
    qrlGastoEntrega: TQRLabel;
    qrlCosteProducto: TQRLabel;
    qrlGastoProducto: TQRLabel;
    qrlSPrecio: TQRLabel;
    qrlSImporte: TQRLabel;
    qrlSPrecioEntrega: TQRLabel;
    qrlSImporteEntrega: TQRLabel;
    qrlSPrecioProducto: TQRLabel;
    qrlSImporteProducto: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel9: TQRLabel;
    qrlBImporte: TQRLabel;
    qrlBPrecio: TQRLabel;
    qrlBMargen: TQRLabel;
    qrlBImporteEntrega: TQRLabel;
    qrlBPrecioEntrega: TQRLabel;
    qrlBMargenEntrega: TQRLabel;
    qrlBImporteProducto: TQRLabel;
    qrlBPrecioProducto: TQRLabel;
    qrlBMargenProducto: TQRLabel;
    qrsS1Detalle: TQRShape;
    qrsS1Entrega: TQRShape;
    qrsS1Producto: TQRShape;
    qrlSCoste: TQRLabel;
    qrlSVenta: TQRLabel;
    qrsS2Detalle: TQRShape;
    qrsS2Entrega: TQRShape;
    qrsS2Producto: TQRShape;
    qrsS2CabProducto: TQRShape;
    qrsS1CabProducto: TQRShape;
    qrsS1CabListado: TQRShape;
    qrsS2CabListado: TQRShape;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrlSVentaEntrega: TQRLabel;
    qrlSCosteEntrega: TQRLabel;
    qrlSVentaProducto: TQRLabel;
    qrlSCosteProducto: TQRLabel;
    qrsS3Detalle: TQRShape;
    qrenombre_p: TQRDBText;
    qrl5: TQRLabel;
    qrsS3Entrega: TQRShape;
    qrss3Producto: TQRShape;
    qrsS3CabProducto: TQRShape;
    qrsS3CabListado: TQRShape;
    qlPesoAprovecha: TQRDBText;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qlTxtKilosAprovecha: TQRLabel;
    procedure qreProductoPrint(sender: TObject; var Value: String);
    procedure fechaPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndPieProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreentregaPrint(sender: TObject; var Value: String);
    procedure bndPieEntregaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieEntregaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndPieProductoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrxCajasEntregaPrint(sender: TObject; var Value: String);
    procedure qrxPresoEntregaPrint(sender: TObject; var Value: String);
    procedure qrxCajasProductoPrint(sender: TObject; var Value: String);
    procedure qrxPesoProductoPrint(sender: TObject; var Value: String);
    procedure qrgProveedorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgCabEntregaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrefechaPrint(sender: TObject; var Value: String);
    procedure qrxpr1Print(sender: TObject; var Value: String);
    procedure qrxpr2Print(sender: TObject; var Value: String);
  private
    rCosteEntrega, rCosteProducto: Real;
    rGastoEntrega, rGastoProducto: Real;
    rCajasEntrega, rCajasProducto: Real;
    rKilosTotalEntrega, rKilosTotalProducto: Real;
    rKilosAprovechaEntrega, rKilosAprovechaProducto: Real;

    rSImporteEntrega, rSImporteProducto: Real;
    rSCosteEntrega, rSCosteProducto: Real;
    rSVentaEntrega, rSVentaProducto: Real;
    rSKilosTotalEntrega, rSKilosTotalProducto: Real;
    rSKilosAprovechaEntrega, rSKilosAprovechaProducto: Real;

    rBeneficioEntrega, rBeneficioProducto: Real;

  public
    procedure PreparaListado( const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AAprovecha: string );
  end;

  function ListadoBeneficioProducto( const AOwner: TComponent;
                            const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AAprovecha: string;
                            AMensaje: TLabel ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, BeneficioProductoDL, DPreview, UDMAuxDB, bMath, UDMConfig, DateUtils;

var
  QLBeneficioProducto: TQLBeneficioProducto;
  DLBeneficioProducto: TDLBeneficioProducto;

procedure ListadoBeneficioProductoEx( const AOwner: TComponent;
                             const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AAprovecha: string );
begin
  QLBeneficioProducto:= TQLBeneficioProducto.Create( AOwner );
  try
    QLBeneficioProducto.PreparaListado( AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AAprovecha );
    Previsualiza( QLBeneficioProducto );
  finally
    FreeAndNil( QLBeneficioProducto );
  end;
end;

function ListadoBeneficioProducto( const AOwner: TComponent;
                          const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AAprovecha: string;
                          AMensaje: TLabel ): Boolean;
begin
  DLBeneficioProducto:= TDLBeneficioProducto.Create( AOwner );
  try
    result:= DLBeneficioProducto.DatosBeneficioProducto( AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AAprovecha, AMensaje );
    if result then
    begin
      ListadoBeneficioProductoEx( AOwner, AEmpresa,  AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AAprovecha );
    end;
  finally
    FreeAndNil( DLBeneficioProducto );
  end;
end;

procedure TQLBeneficioProducto.PreparaListado( const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AAprovecha: string );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  qlTxtKilosAprovecha.Caption:= AAprovecha + '%Kgs';
  lblRangoFechas.Caption:= 'Del ' + AFechaDesde + ' al ' + AFechaHasta;
  if AProveedor <> '' then
    lblProveedor.Caption:= DesProveedor( AEmpresa, AProveedor )
  else
    lblProveedor.Caption:= 'TODOS LOS PROVEEDORES';
  lblTitulo.Caption:= 'BENEFICIO COMPRAS POR PRODUCTO';
end;

procedure TQLBeneficioProducto.qreProductoPrint(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQLBeneficioProducto.fechaPrint(sender: TObject;
  var Value: String);
begin

  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLBeneficioProducto.QListadoStock.FieldByName('fecha').AsDateTime );
end;

procedure TQLBeneficioProducto.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rCosteEntrega:= 0;
  rCosteProducto:= 0;

  rGastoEntrega:= 0;
  rGastoProducto:= 0;

  rKilosTotalEntrega:= 0;
  rKilosAprovechaEntrega:= 0;
  rKilosTotalProducto:= 0;
  rKilosAprovechaProducto:= 0;

  rCajasEntrega:= 0;
  rCajasProducto:= 0;

  rSImporteEntrega:= 0;
  rSImporteProducto:= 0;

  rSKilosTotalEntrega:= 0;
  rSKilosAprovechaEntrega:= 0;
  rSKilosTotalProducto:= 0;
  rSKilosAprovechaProducto:= 0;

  rSCosteEntrega:= 0;
  rSCosteProducto:= 0;

  rSVentaEntrega:= 0;
  rSVentaProducto:= 0;

  rBeneficioEntrega:= 0;
  rBeneficioProducto:= 0;
end;

procedure TQLBeneficioProducto.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rAux: real;
  sProducto: string;
  iSemana: Integer;
  iYear: Word;
  rKilosCal, rKilosTot, rImporteLinea, rFacturas, rGastos: real;
  rKilosTotalLin, rKilosAprovechaLin, rImporteTotalLin: real;
  rCoste, rGasto: Real;
  rSKilos, rSImporte, rSGastos, rSCoste, rSPrecio: Real;
begin
  sProducto:= DataSet.FieldByName('producto').AsString;
  iSemana:= WeekOfTheYear( DataSet.FieldByName('fecha').AsDateTime, iYear );
  iSemana:= ( iYear * 100 ) + iSemana;

  //*************************************************************************************
  //Importes entrega  *********************************************************************
  //Kilos totales
  //*************************************************************************************
  rKilosTotalLin:= DLBeneficioProducto.QListadoStock.FieldByName('peso_total').AsFloat;
  rKilosAprovechaLin:= DLBeneficioProducto.QListadoStock.FieldByName('peso_aprovechado').AsFloat;

    if rKilosTotalLin < 0 then
    begin
      lblImporte.Caption:= '0.00';
      lblPrecio.Caption:= '0.000';
      qrlDetalleFactura.Caption:= '0.000';
      qrlDetalleGastos.Caption:= '0.000';
      exit;
    end;

    DLBeneficioProducto.ObtenerGastos(
        DLBeneficioProducto.QListadoStock.FieldByName( 'entrega' ).AsString,
        DLBeneficioProducto.QListadoStock.FieldByName( 'producto' ).AsString,
        DLBeneficioProducto.QListadoStock.FieldByName( 'variedad' ).AsString,
        DLBeneficioProducto.QListadoStock.FieldByName( 'calibre' ).AsString,
        rKilosCal, rKilosTot, rImporteLinea, rFacturas, rGastos);

    if ( rImporteLinea < 0 ) or ( rKilosCal < 0 )then
    begin
      lblImporte.Caption:= '0.00';
      lblPrecio.Caption:= '0.000';
      qrlDetalleFactura.Caption:= '0.000';
      qrlDetalleGastos.Caption:= '0.000';
      exit;
    end;

    rImporteTotalLin:= 0;
    rCoste:= 0;
    rGasto:= 0;

    if rImporteLinea <> 0 then
    begin
      if rKilosTot <> 0 then
      begin
        rCoste:= rImporteLinea;
        rImporteTotalLin:= bRoundTo( ( rKilosCal * rGastos ) / rKilosTot, -2 );
        rGasto:= rImporteTotalLin;
        rImporteTotalLin:= bRoundTo( rImporteTotalLin + rImporteLinea, -2 );
      end;
    end
    else
    begin
      if rKilosTot <> 0 then
      begin
        rImporteTotalLin:= bRoundTo( ( rKilosCal * ( rGastos + rFacturas ) ) / rKilosTot, -2 );
        rCoste:= bRoundTo( ( rKilosCal * ( rFacturas ) ) / rKilosTot, -2 );
        rGasto:= bRoundTo( ( rKilosCal * ( rGastos ) ) / rKilosTot, -2 );
      end;
    end;

    if rKilosCal <> 0 then
    begin
      rImporteTotalLin:= bRoundTo( ( rKilosTotalLin * rImporteTotalLin ) / rKilosCal, -2 );
      rCoste:= bRoundTo( ( rKilosTotalLin * rCoste ) / rKilosCal, -2 );
      rGasto:= bRoundTo( ( rKilosTotalLin * rGasto ) / rKilosCal, -2 );
    end
    else
    begin
      rImporteTotalLin:= 0;
      rCoste:= 0;
      rGasto:= 0;
    end;


(*
    if rImporteLin = 0 then
    begin
      lblPrecio.Caption:= 'ERR';
      lblImporte.Caption:= 'ERR';
      qrlDetalleFactura.Caption:= 'ERR';
      qrlDetalleGastos.Caption:= 'ERR';
    end
    else
    begin
*)
      if rKilosTotalLin <> 0 then
      begin
        if rCoste = 0 then
          qrlDetalleFactura.Caption:= 'ERR'
        else
          qrlDetalleFactura.Caption:= FormatFloat( '#,##0.000', rCoste / rKilosTotalLin );
        qrlDetalleGastos.Caption:= FormatFloat( '#,##0.000', rGasto / rKilosTotalLin );
        lblPrecio.Caption:= FormatFloat( '#,##0.000', rImporteTotalLin / rKilosTotalLin );
        lblImporte.Caption:= FormatFloat( '#,##0.00', rImporteTotalLin );
      end
      else
      begin
        lblImporte.Caption:= FormatFloat( '#,##0.00', rImporteTotalLin );
        qrlDetalleFactura.Caption:= 'ERR';
        qrlDetalleGastos.Caption:= 'ERR';
        lblPrecio.Caption:= 'ERR';
      end;
//    end;

    rCosteEntrega:= rCosteEntrega + rCoste;
    rCosteProducto:= rCosteProducto + rCoste;

    rGastoEntrega:= rGastoEntrega + rGasto;
    rGastoProducto:= rGastoProducto + rGasto;

    rKilosTotalEntrega:= rKilosTotalEntrega + rKilosTotalLin;
    rKilosTotalProducto:= rKilosTotalProducto + rKilosTotalLin;
    rKilosAprovechaEntrega:= rKilosAprovechaEntrega + rKilosAprovechaLin;
    rKilosAprovechaProducto:= rKilosAprovechaProducto + rKilosAprovechaLin;

    rCajasEntrega:= rCajasEntrega + DLBeneficioProducto.QListadoStock.FieldByName('cajas').AsInteger;
    rCajasProducto:=  rCajasProducto + DLBeneficioProducto.QListadoStock.FieldByName('cajas').AsInteger;




  //*************************************************************************************
  //Importe ventas  *********************************************************************
  //Kilos aprovechados -->> kilos totales ajustados un porcentaje que indicamos en la entrada de datos
  //*************************************************************************************
  DLBeneficioProducto.GetPrecioMedio( IntToStr( iSemana ), sProducto, rSKilos, rSImporte, rSGastos, rSCoste );
  if rSKilos <> 0 then
  begin
    rSPrecio:= bRoundTo( ( rSImporte - (rSGastos + rSCoste ) ) / rSKilos, -3 );
    rSCoste:= bRoundTo( ( rSGastos + rSCoste ) / rSKilos, -3 );
    rAux:= bRoundTo( rSImporte / rSKilos, -3 );
    rSImporte:= bRoundTo ( rSPrecio * rKilosAprovechaLin, -2 );
  end
  else
  begin
    rSPrecio:= 0;
    rSCoste:= 0;
    rAux:= 0;
    rSImporte:= 0;
  end;


  qrlSPrecio.Caption:= FormatFloat( '#,##0.000', rSPrecio );
  qrlSCoste.Caption:= FormatFloat( '#,##0.000', rSCoste );
  qrlSVenta.Caption:= FormatFloat( '#,##0.000', rAux );
  qrlSImporte.Caption:= FormatFloat( '#,##0.00', rSImporte );

  rSCoste:= bRoundTo ( rSCoste * rKilosAprovechaLin, -2 );
  rAux:= bRoundTo ( rAux * rKilosAprovechaLin, -2 );


  rSImporteEntrega:= rSImporteEntrega + rSImporte;
  rSImporteProducto:= rSImporteProducto + rSImporte;

  rSCosteEntrega:= rSCosteEntrega + rSCoste;
  rSCosteProducto:= rSCosteProducto + rSCoste;

  rSVentaEntrega:= rSVentaEntrega + rAux;
  rSVentaProducto:= rSVentaProducto + rAux;

  rSKilosTotalEntrega:= rSKilosTotalEntrega + rKilosTotalLin;
  rSKilosTotalProducto:= rSKilosTotalProducto + rKilosTotalLin;
  rSKilosAprovechaEntrega:= rSKilosAprovechaEntrega + rKilosAprovechaLin;
  rSKilosAprovechaProducto:= rSKilosAprovechaProducto + rKilosAprovechaLin;

  //Beneficio
  rAux:= rSImporte - rImporteTotalLin;
  qrlBImporte.Caption:= FormatFloat( '#,##0.00', rAux );
  if rImporteTotalLin <> 0 then
    qrlBMargen.Caption:= FormatFloat( '#,##0.00', ( rAux * 100 ) / rImporteTotalLin )
  else
    qrlBMargen.Caption:= FormatFloat( '#,##0.00', 0 );
  if rKilosTotalLin <> 0 then
    qrlBPrecio.Caption:= FormatFloat( '#,##0.000', rAux / rKilosTotalLin )
  else
    qrlBPrecio.Caption:= FormatFloat( '#,##0.000', 0 );

  rBeneficioEntrega:= rBeneficioEntrega + rAux;
  rBeneficioProducto:= rBeneficioProducto + rAux;

end;

procedure TQLBeneficioProducto.bndPieEntregaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rAux: Real;
begin
  PrintBand:= False;
  qrlImporteEntrega.Caption:= FormatFloat( '#,##0.00', rCosteEntrega + rGastoEntrega );
  if rKilosTotalEntrega <> 0 then
  begin
    qrlCosteEntrega.Caption:= FormatFloat( '#,##0.000', rCosteEntrega / rKilosTotalEntrega);
    qrlGastoEntrega.Caption:= FormatFloat( '#,##0.000', rGastoEntrega / rKilosTotalEntrega);
    qrlPrecioEntrega.Caption:= FormatFloat( '#,##0.000', ( rCosteEntrega + rGastoEntrega ) / rKilosTotalEntrega );
  end
  else
  begin
    qrlPrecioEntrega.Caption:= '0.000';
    qrlCosteEntrega.Caption:= '0.000';
    qrlGastoEntrega.Caption:= '0.000';
  end;

  if rSKilosAprovechaEntrega <> 0 then
  begin
    rAux:= bRoundTo( ( rSImporteEntrega/ rSKilosAprovechaEntrega ), -3 );
    rSVentaEntrega:= bRoundTo( ( rSVentaEntrega/ rSKilosAprovechaEntrega ), -3 );
    rSCosteEntrega:= bRoundTo( ( rSCosteEntrega/ rSKilosAprovechaEntrega ), -3 );
  end
  else
  begin
    rAux:= 0;
    rSVentaEntrega:= 0;
    rSCosteEntrega:= 0;
  end;
  qrlSPrecioEntrega.Caption:= FormatFloat( '#,##0.000',  rAux );
  qrlSImporteEntrega.Caption:= FormatFloat( '#,##0.00', rSImporteEntrega );
  qrlSCosteEntrega.Caption:= FormatFloat( '#,##0.000', rSCosteEntrega );
  qrlSVentaEntrega.Caption:= FormatFloat( '#,##0.000', rSVentaEntrega );


  //Beneficio
  //rAux:= rBeneficioEntrega - ( rCosteEntrega + rGastoEntrega );
  qrlBImporteEntrega.Caption:= FormatFloat( '#,##0.00', rBeneficioProducto );
  if ( rCosteEntrega + rGastoEntrega ) <> 0 then
    qrlBMargenEntrega.Caption:= FormatFloat( '#,##0.00', ( rBeneficioProducto * 100 ) / ( rCosteEntrega + rGastoEntrega ) )
  else
    qrlBMargenEntrega.Caption:= FormatFloat( '#,##0.00', 0 );
  if rKilosTotalEntrega <> 0 then
    qrlBPrecioEntrega.Caption:= FormatFloat( '#,##0.000', rBeneficioProducto / rKilosTotalEntrega )
  else
    qrlBPrecioEntrega.Caption:= FormatFloat( '#,##0.000', 0 );
end;

procedure TQLBeneficioProducto.bndPieEntregaAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
    rCosteEntrega:= 0;
    rGastoEntrega:= 0;
    rKilosTotalEntrega:= 0;
    rKilosAprovechaEntrega:= 0;
    rCajasEntrega:= 0;
    rSKilosTotalEntrega:= 0;
    rSKilosAprovechaEntrega:= 0;
    rSImporteEntrega:= 0;
    rSVentaEntrega:= 0;
    rSCosteEntrega:= 0;
    rBeneficioEntrega:= 0;
end;

procedure TQLBeneficioProducto.bndPieProductoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rAux: Real;
begin
    qrlImporteProducto.Caption:= FormatFloat( '#,##0.00', rCosteProducto + rGastoProducto);
    if rKilosTotalProducto <> 0 then
    begin
      qrlPrecioProducto.Caption:= FormatFloat( '#,##0.000', ( rCosteProducto + rGastoProducto ) / rKilosTotalProducto );
      qrlCosteProducto.Caption:= FormatFloat( '#,##0.000', rCosteProducto / rKilosTotalProducto );
      qrlGastoProducto.Caption:= FormatFloat( '#,##0.000', rGastoProducto / rKilosTotalProducto );
    end
    else
    begin
      qrlPrecioProducto.Caption:= '0.000';
      qrlCosteProducto.Caption:= '0.000';
      qrlGastoProducto.Caption:= '0.000';
    end;

  if rSKilosAprovechaProducto <> 0 then
  begin
    rAux:= bRoundTo( rSImporteProducto / rSKilosAprovechaProducto, -3 );
    rSVentaProducto:= bRoundTo( ( rSVentaProducto/ rSKilosAprovechaProducto ), -3 );
    rSCosteProducto:= bRoundTo( ( rSCosteProducto/ rSKilosAprovechaProducto ), -3 );
  end
  else
  begin
    rAux:= 0;
    rSVentaProducto:= 0;
    rSCosteProducto:= 0;
  end;
  qrlSPrecioProducto.Caption:= FormatFloat( '#,##0.000', rAux );
  qrlSImporteProducto.Caption:= FormatFloat( '#,##0.00', rSImporteProducto);
  qrlSCosteProducto.Caption:= FormatFloat( '#,##0.000', rSCosteProducto );
  qrlSVentaProducto.Caption:= FormatFloat( '#,##0.000', rSVentaProducto );

  //Beneficio
  //rAux:= rBeneficioProducto - ( rCosteProducto + rGastoProducto );
  qrlBImporteProducto.Caption:= FormatFloat( '#,##0.00', rBeneficioProducto );
  if ( rCosteProducto + rGastoProducto ) <> 0 then
    qrlBMargenProducto.Caption:= FormatFloat( '#,##0.00', ( rBeneficioProducto * 100 ) / ( rCosteProducto + rGastoProducto ) )
  else
    qrlBMargenProducto.Caption:= FormatFloat( '#,##0.00', 0 );
  if rKilosTotalProducto <> 0 then
    qrlBPrecioProducto.Caption:= FormatFloat( '#,##0.000', rBeneficioProducto / rKilosTotalProducto )
  else
    qrlBPrecioProducto.Caption:= FormatFloat( '#,##0.000', 0 );
end;

procedure TQLBeneficioProducto.bndPieProductoAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
    rCosteProducto:= 0;
    rGastoProducto:= 0;
    rCajasProducto:= 0;
    rKilosTotalProducto:= 0;
    rKilosAprovechaProducto:= 0;
    rSImporteProducto:= 0;
    rSKilosTotalProducto:= 0;
    rSKilosAprovechaProducto:= 0;
    rSVentaProducto:= 0;
    rSCosteProducto:= 0;
    rBeneficioProducto:= 0;
end;

procedure TQLBeneficioProducto.qreentregaPrint(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ENTREGA ' + Value;
end;

procedure TQLBeneficioProducto.qrxCajasEntregaPrint(sender: TObject;
  var Value: String);
begin
  Value:=  FormatFloat( '#,##0', rCajasEntrega );
end;

procedure TQLBeneficioProducto.qrxPresoEntregaPrint(sender: TObject;
  var Value: String);
begin
  Value:=  FormatFloat( '#,##0.00', rKilosTotalEntrega );
end;

procedure TQLBeneficioProducto.qrxCajasProductoPrint(sender: TObject;
  var Value: String);
begin
   Value:=  FormatFloat( '#,##0', rCajasProducto );
end;

procedure TQLBeneficioProducto.qrxPesoProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:=  FormatFloat( '#,##0.00', rKilosTotalProducto );
end;

procedure TQLBeneficioProducto.qrgProveedorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= False;
end;

procedure TQLBeneficioProducto.qrgCabEntregaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= False;
end;

procedure TQLBeneficioProducto.qrefechaPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat('00', WeekOfTheYear( DataSet.FieldByName('fecha').AsDateTime ) );
end;

procedure TQLBeneficioProducto.qrxpr1Print(sender: TObject;
  var Value: String);
begin
  Value:=  FormatFloat( '#,##0.00', rKilosAprovechaEntrega );
end;

procedure TQLBeneficioProducto.qrxpr2Print(sender: TObject;
  var Value: String);
begin
  Value:=  FormatFloat( '#,##0.00', rKilosAprovechaProducto );
end;

end.
