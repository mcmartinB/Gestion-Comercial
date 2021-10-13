unit ComprasProductoProveedorQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLComprasProductoProveedor = class(TQuickRep)
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
    qrgCabProveedor: TQRGroup;
    bndPieProveedor: TQRBand;
    qreProveedor: TQRDBText;
    qrxCajasProveedor: TQRExpr;
    qrxPesoProveedor: TQRExpr;
    QRLabel3: TQRLabel;
    qrlImporteProveedor: TQRLabel;
    qrlImporteProducto: TQRLabel;
    QRLabel8: TQRLabel;
    qrlPrecioProveedor: TQRLabel;
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
    qrlAviso: TQRLabel;
    qrenombre_p: TQRDBText;
    qrefecha: TQRDBText;
    qrlDetalleFactura: TQRLabel;
    qrlDetalleGastos: TQRLabel;
    qrlGasto: TQRLabel;
    qrlCoste: TQRLabel;
    qrlCosteEntrega: TQRLabel;
    qrlGastoEntrega: TQRLabel;
    qrlCosteProveedor: TQRLabel;
    qrlGastoProveedor: TQRLabel;
    qrlCosteProducto: TQRLabel;
    qrlGastoProducto: TQRLabel;
    procedure qreProductoPrint(sender: TObject; var Value: String);
    procedure fechaPrint(sender: TObject; var Value: String);
    procedure qreProveedorPrint(sender: TObject; var Value: String);
    procedure bndPieProveedorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
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
    procedure bndPieProveedorAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndPieProductoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrxCajasEntregaPrint(sender: TObject; var Value: String);
    procedure qrxPresoEntregaPrint(sender: TObject; var Value: String);
    procedure qrxCajasProveedorPrint(sender: TObject; var Value: String);
    procedure qrxPesoProveedorPrint(sender: TObject; var Value: String);
    procedure qrxCajasProductoPrint(sender: TObject; var Value: String);
    procedure qrxPesoProductoPrint(sender: TObject; var Value: String);
    procedure qrgProveedorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrefechaPrint(sender: TObject; var Value: String);
    procedure qrgCabEntregaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    rCosteEntrega, rCosteProveedor, rCosteProducto: Real;
    rGastoEntrega, rGastoProveedor, rGastoProducto: Real;
    rCajasEntrega, rCajasProveedor, rCajasProducto: Real;
    rBrutoEntrega, rBrutoProveedor, rBrutoProducto: Real;
    rNetoEntrega, rNetoProveedor, rNetoProducto: Real;

  public
    procedure PreparaListado( const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta: string );
  end;

  function ListadoComprasProductoProveedor( const AOwner: TComponent;
                            const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta: string;
                            AMensaje: TLabel ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, ComprasProductoProveedorDL, DPreview, UDMAuxDB, bMath, UDMConfig, DateUtils;

var
  QLComprasProductoProveedor: TQLComprasProductoProveedor;
  DLComprasProductoProveedor: TDLComprasProductoProveedor;

procedure ListadoComprasProductoProveedorEx( const AOwner: TComponent;
                             const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta: string );
begin
  QLComprasProductoProveedor:= TQLComprasProductoProveedor.Create( AOwner );
  try
    QLComprasProductoProveedor.PreparaListado( AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta );
    Previsualiza( QLComprasProductoProveedor );
  finally
    FreeAndNil( QLComprasProductoProveedor );
  end;
end;

function ListadoComprasProductoProveedor( const AOwner: TComponent;
                          const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta: string;
                          AMensaje: TLabel ): Boolean;
begin
  DLComprasProductoProveedor:= TDLComprasProductoProveedor.Create( AOwner );
  try
    result:= DLComprasProductoProveedor.DatosComprasProductoProveedor( AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AMensaje );
    if result then
    begin
      ListadoComprasProductoProveedorEx( AOwner, AEmpresa,  AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta );
    end;
  finally
    FreeAndNil( DLComprasProductoProveedor );
  end;
end;

procedure TQLComprasProductoProveedor.PreparaListado( const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta: string );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblRangoFechas.Caption:= 'Del ' + AFechaDesde + ' al ' + AFechaHasta;
  if AProveedor <> '' then
    lblProveedor.Caption:= DesProveedor( AEmpresa, AProveedor )
  else
    lblProveedor.Caption:= 'TODOS LOS PROVEEDORES';
  lblTitulo.Caption:= 'INFORME BENEFICIO PRODUCTO';
end;

procedure TQLComprasProductoProveedor.qreProductoPrint(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQLComprasProductoProveedor.fechaPrint(sender: TObject;
  var Value: String);
begin

  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLComprasProductoProveedor.QListadoStock.FieldByName('fecha').AsDateTime );
end;

procedure TQLComprasProductoProveedor.qrefechaPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then

    Value:= FormatFloat('00', WeekOfTheYear( DLComprasProductoProveedor.QListadoStock.FieldByName('fecha').AsDateTime ) );
end;

procedure TQLComprasProductoProveedor.qreProveedorPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' +  DataSet.fieldByName('proveedor').AsString + ' ' + DataSet.fieldByName('nombre_p').AsString
end;

procedure TQLComprasProductoProveedor.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rCosteEntrega:= 0;
  rCosteProveedor:= 0;
  rCosteProducto:= 0;

  rGastoEntrega:= 0;
  rGastoProveedor:= 0;
  rGastoProducto:= 0;

  rBrutoEntrega:= 0;
  rBrutoProveedor:= 0;
  rBrutoProducto:= 0;

  rNetoEntrega:= 0;
  rNetoProveedor:= 0;
  rNetoProducto:= 0;

  rCajasEntrega:= 0;
  rCajasProveedor:= 0;
  rCajasProducto:= 0;
end;

procedure TQLComprasProductoProveedor.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rKilosCal, rKilosTot, rImporteLinea, rFacturas, rGastos: real;
  rKilosLin, rImporteLin: real;
  rCoste, rGasto: Real;
begin
    rKilosLin:= DLComprasProductoProveedor.QListadoStock.FieldByName('peso').AsFloat;

    if rKilosLin < 0 then
    begin
      lblImporte.Caption:= '0.00';
      lblPrecio.Caption:= '0.000';
      qrlDetalleFactura.Caption:= '0.000';
      qrlDetalleGastos.Caption:= '0.000';
      exit;
    end;

    DLComprasProductoProveedor.ObtenerGastos(
        DLComprasProductoProveedor.QListadoStock.FieldByName( 'entrega' ).AsString,
        DLComprasProductoProveedor.QListadoStock.FieldByName( 'producto' ).AsString,
        DLComprasProductoProveedor.QListadoStock.FieldByName( 'variedad' ).AsString,
        DLComprasProductoProveedor.QListadoStock.FieldByName( 'calibre' ).AsString,
        rKilosCal, rKilosTot, rImporteLinea, rFacturas, rGastos);

    if ( rImporteLinea < 0 ) or ( rKilosCal < 0 )then
    begin
      lblImporte.Caption:= '0.00';
      lblPrecio.Caption:= '0.000';
      qrlDetalleFactura.Caption:= '0.000';
      qrlDetalleGastos.Caption:= '0.000';
      exit;
    end;

    rImporteLin:= 0;
    rCoste:= 0;
    rGasto:= 0;

    if rImporteLinea <> 0 then
    begin
      if rKilosTot <> 0 then
      begin
        rCoste:= rImporteLinea;
        rImporteLin:= bRoundTo( ( rKilosCal * rGastos ) / rKilosTot, -2 );
        rGasto:= rImporteLin;
        rImporteLin:= bRoundTo( rImporteLin + rImporteLinea, -2 );
      end;
    end
    else
    begin
      if rKilosTot <> 0 then
      begin
        rImporteLin:= bRoundTo( ( rKilosCal * ( rGastos + rFacturas ) ) / rKilosTot, -2 );
        rCoste:= bRoundTo( ( rKilosCal * ( rFacturas ) ) / rKilosTot, -2 );
        rGasto:= bRoundTo( ( rKilosCal * ( rGastos ) ) / rKilosTot, -2 );
      end;
    end;

    if rKilosCal <> 0 then
    begin
      rImporteLin:= bRoundTo( ( rKilosLin * rImporteLin ) / rKilosCal, -2 );
      rCoste:= bRoundTo( ( rKilosLin * rCoste ) / rKilosCal, -2 );
      rGasto:= bRoundTo( ( rKilosLin * rGasto ) / rKilosCal, -2 );
    end
    else
    begin
      rImporteLin:= 0;
      rCoste:= 0;
      rGasto:= 0;
    end;


    if rImporteLin = 0 then
    begin
      lblPrecio.Caption:= 'ERR';
      lblImporte.Caption:= 'ERR';
      qrlDetalleFactura.Caption:= 'ERR';
      qrlDetalleGastos.Caption:= 'ERR';
    end
    else
    begin
      if rKilosLin <> 0 then
      begin
        if rCoste = 0 then
          qrlDetalleFactura.Caption:= 'ERR'
        else
          qrlDetalleFactura.Caption:= FormatFloat( '#,##0.000', rCoste / rKilosLin );
        qrlDetalleGastos.Caption:= FormatFloat( '#,##0.000', rGasto / rKilosLin );
        lblPrecio.Caption:= FormatFloat( '#,##0.000', rImporteLin / rKilosLin );
        lblImporte.Caption:= FormatFloat( '#,##0.00', rImporteLin );
      end
      else
      begin
        lblImporte.Caption:= FormatFloat( '#,##0.00', rImporteLin );
        qrlDetalleFactura.Caption:= 'ERR';
        qrlDetalleGastos.Caption:= 'ERR';
        lblPrecio.Caption:= 'ERR';
      end;
    end;

    rCosteEntrega:= rCosteEntrega + rCoste;
    rCosteProveedor:= rCosteProveedor + rCoste;
    rCosteProducto:= rCosteProducto + rCoste;

    rGastoEntrega:= rGastoEntrega + rGasto;
    rGastoProveedor:= rGastoProveedor + rGasto;
    rGastoProducto:= rGastoProducto + rGasto;

    rBrutoEntrega:= rBrutoEntrega + rKilosLin;
    rBrutoProveedor:= rBrutoProveedor + rKilosLin;
    rBrutoProducto:= rBrutoProducto + rKilosLin;

    rCajasEntrega:= rCajasEntrega + DLComprasProductoProveedor.QListadoStock.FieldByName('cajas').AsInteger;
    rCajasProveedor:= rCajasProveedor + DLComprasProductoProveedor.QListadoStock.FieldByName('cajas').AsInteger;
    rCajasProducto:=  rCajasProducto + DLComprasProductoProveedor.QListadoStock.FieldByName('cajas').AsInteger;

    if rImporteLin <> 0 then
    begin
      rNetoEntrega:= rNetoEntrega + rKilosLin;
      rNetoProveedor:= rNetoProveedor + rKilosLin;
      rNetoProducto:= rNetoProducto + rKilosLin;
    end;
end;

procedure TQLComprasProductoProveedor.bndPieEntregaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= False;
  qrlImporteEntrega.Caption:= FormatFloat( '#,##0.00', rCosteEntrega + rGastoEntrega );
  if rNetoEntrega <> 0 then
  begin
    qrlCosteEntrega.Caption:= FormatFloat( '#,##0.000', rCosteEntrega / rNetoEntrega);
    qrlGastoEntrega.Caption:= FormatFloat( '#,##0.000', rGastoEntrega / rNetoEntrega);
    qrlPrecioEntrega.Caption:= FormatFloat( '#,##0.000', ( rCosteEntrega + rGastoEntrega ) / rNetoEntrega );
  end
  else
  begin
    qrlPrecioEntrega.Caption:= '0.000';
    qrlCosteEntrega.Caption:= '0.000';
    qrlGastoEntrega.Caption:= '0.000';
  end;
end;

procedure TQLComprasProductoProveedor.bndPieEntregaAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
    rCosteEntrega:= 0;
    rGastoEntrega:= 0;
    rNetoEntrega:= 0;
    rBrutoEntrega:= 0;
    rCajasEntrega:= 0;
end;

procedure TQLComprasProductoProveedor.bndPieProveedorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlImporteProveedor.Caption:= FormatFloat( '#,##0.00', rCosteProveedor + rGastoProveedor);
  if rNetoProveedor <> 0 then
  begin
    qrlCosteProveedor.Caption:= FormatFloat( '#,##0.000', rCosteProveedor / rNetoProveedor );
    qrlGastoProveedor.Caption:= FormatFloat( '#,##0.000', rGastoProveedor / rNetoProveedor );
    qrlPrecioProveedor.Caption:= FormatFloat( '#,##0.000', ( rCosteProveedor + rGastoProveedor ) / rNetoProveedor );
  end
  else
  begin
    qrlCosteProveedor.Caption:= '0.000';
    qrlGastoProveedor.Caption:= '0.000';
    qrlPrecioProveedor.Caption:= '0.000';
  end;
end;

procedure TQLComprasProductoProveedor.bndPieProveedorAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
    rCosteProveedor:= 0;
    rGastoProveedor:= 0;
    rNetoProveedor:= 0;
    rBrutoProveedor:= 0;
    rCajasProveedor:= 0;
end;


procedure TQLComprasProductoProveedor.bndPieProductoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    qrlImporteProducto.Caption:= FormatFloat( '#,##0.00', rCosteProducto + rGastoProducto);
    if rNetoProducto <> 0 then
    begin
      qrlPrecioProducto.Caption:= FormatFloat( '#,##0.000', ( rCosteProducto + rGastoProducto ) / rNetoProducto );
      qrlCosteProducto.Caption:= FormatFloat( '#,##0.000', rCosteProducto / rNetoProducto );
      qrlGastoProducto.Caption:= FormatFloat( '#,##0.000', rGastoProducto / rNetoProducto );
    end
    else
    begin
      qrlPrecioProducto.Caption:= '0.000';
      qrlCosteProducto.Caption:= '0.000';
      qrlGastoProducto.Caption:= '0.000';
    end;
end;

procedure TQLComprasProductoProveedor.bndPieProductoAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
    rCosteProducto:= 0;
    rGastoProducto:= 0;
    rCajasProducto:= 0;
    rBrutoProducto:= 0;
    rNetoProducto:= 0;
end;

procedure TQLComprasProductoProveedor.qreentregaPrint(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ENTREGA ' + Value;
end;

procedure TQLComprasProductoProveedor.qrxCajasEntregaPrint(sender: TObject;
  var Value: String);
begin
  Value:=  FormatFloat( '#,##0', rCajasEntrega );
end;

procedure TQLComprasProductoProveedor.qrxPresoEntregaPrint(sender: TObject;
  var Value: String);
begin
  Value:=  FormatFloat( '#,##0.00', rBrutoEntrega );
end;

procedure TQLComprasProductoProveedor.qrxCajasProveedorPrint(sender: TObject;
  var Value: String);
begin
  Value:=  FormatFloat( '#,##0', rCajasProveedor );
end;

procedure TQLComprasProductoProveedor.qrxPesoProveedorPrint(sender: TObject;
  var Value: String);
begin
  Value:=  FormatFloat( '#,##0.00', rBrutoProveedor );
end;

procedure TQLComprasProductoProveedor.qrxCajasProductoPrint(sender: TObject;
  var Value: String);
begin
   Value:=  FormatFloat( '#,##0', rCajasProducto );
end;

procedure TQLComprasProductoProveedor.qrxPesoProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:=  FormatFloat( '#,##0.00', rBrutoProducto );
end;

procedure TQLComprasProductoProveedor.qrgProveedorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= False;
end;

procedure TQLComprasProductoProveedor.qrgCabEntregaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= False;
end;

end.
