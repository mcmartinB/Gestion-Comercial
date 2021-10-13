unit CosteFrutaProductoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLCosteFrutaProducto = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    PageFooterBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRGroup1: TQRGroup;
    QRDBText9: TQRDBText;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRBand1: TQRBand;
    QRDBText10: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    SummaryBand1: TQRBand;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRLabel9: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRSysData1: TQRSysData;
    pais: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    fecha: TQRDBText;
    QRGroupCabVariedad: TQRGroup;
    QRLabel12: TQRLabel;
    QRGroupPieVariedad: TQRBand;
    QRDBText11: TQRDBText;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRLabel3: TQRLabel;
    lblAcumVariedad: TQRLabel;
    lblAcumProducto: TQRLabel;
    lblAcumTotal: TQRLabel;
    QRLabel8: TQRLabel;
    lblPrecioVariedad: TQRLabel;
    lblPrecioProducto: TQRLabel;
    lblPrecioTotal: TQRLabel;
    lblImporte: TQRLabel;
    lblPrecio: TQRLabel;
    QRGroup2: TQRGroup;
    QRLabel13: TQRLabel;
    QRGroupPieCalibre: TQRBand;
    QRDBText3: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr4: TQRExpr;
    lblAcumCalibre: TQRLabel;
    lblPrecioCalibre: TQRLabel;
    lblRangoFechas: TQRLabel;
    lblProveedor: TQRLabel;
    qrlAviso: TQRLabel;
    qrlTipoGatos: TQRLabel;
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure fechaPrint(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure QRGroupCabVariedadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroupPieVariedadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRGroupPieCalibreBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroupPieCalibreAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRGroupPieVariedadAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure SummaryBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure QRExpr4Print(sender: TObject; var Value: String);
    procedure QRExpr8Print(sender: TObject; var Value: String);
    procedure QRExpr9Print(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRExpr3Print(sender: TObject; var Value: String);
    procedure QRExpr5Print(sender: TObject; var Value: String);
    procedure QRExpr6Print(sender: TObject; var Value: String);
  private
    rImporteCalibre, rImporteVariedad, rImporteProducto, rImporteTotal: Real;
    rCajasCalibre, rCajasVariedad, rCajasProducto, rCajasTotal: Real;
    rBrutoCalibre, rBrutoVariedad, rBrutoProducto, rBrutoTotal: Real;
    rNetoCalibre, rNetoVariedad, rNetoProducto, rNetoTotal: Real;
    sTipoGasto: string;
    bMasImporte: Boolean;
  public
    bAgruparVariedad, bAgruparCalibre, bResumen: Boolean;
    procedure PreparaListado( const AEmpresa, ACentro, AProducto, AProveedor, AEntrega, ATipoGasto: string;
                              const AMasImporte: Boolean; const AFechaDesde, AFechaHasta: string );
  end;

  function VerListadoStock( const AOwner: TComponent;
                            const AEmpresa, ACentro, AProducto, AProveedor, AEntrega, ATipoGasto: string;
                            const AMasImporte: Boolean; const AFechaDesde, AFechaHasta: string;
                            const AAgruparVariedad, AAgruparCalibre, AVerDetalle: Boolean;
                            AMensaje: TLabel ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, CosteFrutaProductoDL, DPreview, UDMAuxDB, bMath, UDMConfig;

var
  QLCosteFrutaProducto: TQLCosteFrutaProducto;
  DLCosteFrutaProducto: TDLCosteFrutaProducto;

procedure VerListadoStockEx( const AOwner: TComponent;
                             const AEmpresa, ACentro, AProducto, AProveedor, AEntrega, ATipoGasto: string;
                             const AMasImporte: boolean; const AFechaDesde, AFechaHasta: string;
                             const AAgruparVariedad, AAgruparCalibre, AVerDetalle: Boolean  );
begin
  QLCosteFrutaProducto:= TQLCosteFrutaProducto.Create( AOwner );
  try
    QLCosteFrutaProducto.PreparaListado( AEmpresa, ACentro, AProducto, AProveedor, AEntrega, ATipoGasto, AMasImporte, AFechaDesde, AFechaHasta );
    QLCosteFrutaProducto.bAgruparVariedad:= AAgruparVariedad;
    QLCosteFrutaProducto.bAgruparCalibre:= AAgruparCalibre;
    QLCosteFrutaProducto.bResumen:= not AVerDetalle;
    Previsualiza( QLCosteFrutaProducto );
  finally
    FreeAndNil( QLCosteFrutaProducto );
  end;
end;

function VerListadoStock( const AOwner: TComponent;
                          const AEmpresa, ACentro, AProducto, AProveedor, AEntrega, ATipoGasto: string;
                          const AMasImporte: Boolean; const AFechaDesde, AFechaHasta: string;
                          const AAgruparVariedad, AAgruparCalibre, AVerDetalle: Boolean; AMensaje: TLabel ): Boolean;
begin
  DLCosteFrutaProducto:= TDLCosteFrutaProducto.Create( AOwner );
  try
    result:= DLCosteFrutaProducto.DatosQueryFrutaProveedor( AEmpresa, ACentro, AProducto, AProveedor, AEntrega, ATipoGasto,  AMasImporte,
                                                            AFechaDesde, AFechaHasta, AAgruparVariedad, AAgruparCalibre, AMensaje );
    if result then
    begin
      VerListadoStockEx( AOwner, AEmpresa, ACentro, AProducto, AProveedor, AEntrega, ATipoGasto, AMasImporte, AFechaDesde, AFechaHasta, AAgruparVariedad, AAgruparCalibre, AVerDetalle );
    end;
  finally
    FreeAndNil( DLCosteFrutaProducto );
  end;
end;

procedure TQLCosteFrutaProducto.PreparaListado( const AEmpresa, ACentro, AProducto, AProveedor, AEntrega, ATipoGasto: string;
                                                const AMasImporte: Boolean; const AFechaDesde, AFechaHasta: string );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblCentro.Caption:= DesCentro( AEmpresa, ACentro );
  lblRangoFechas.Caption:= 'Del ' + AFechaDesde + ' al ' + AFechaHasta;
  if AProveedor <> '' then
    lblProveedor.Caption:= DesProveedor( AEmpresa, AProveedor )
  else
    lblProveedor.Caption:= 'TODOS LOS PROVEEDORES';
  lblTitulo.Caption:= 'RESUMEN ENTREGAS POR PRODUCTO';
  sTipoGasto:= ATipoGasto;
  bMasImporte:= AMasImporte;
  if ATipoGasto <> '' then
    qrlTipoGatos.Caption:= ATipoGasto + ' ' + desTipoGastos( sTipoGasto )
  else
    qrlTipoGatos.Caption:= 'TODOS LOS COSTES.';
end;

procedure TQLCosteFrutaProducto.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQLCosteFrutaProducto.fechaPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLCosteFrutaProducto.QListadoStock.FieldByName('fecha').AsDateTime );
end;

procedure TQLCosteFrutaProducto.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + Value;
end;

procedure TQLCosteFrutaProducto.QRGroupCabVariedadBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= False;
end;

procedure TQLCosteFrutaProducto.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rImporteCalibre:= 0;
  rImporteVariedad:= 0;
  rImporteProducto:= 0;
  rImporteTotal:= 0;

  rBrutoCalibre:= 0;
  rBrutoVariedad:= 0;
  rBrutoProducto:= 0;
  rBrutoTotal:= 0;

  rNetoCalibre:= 0;
  rNetoVariedad:= 0;
  rNetoProducto:= 0;
  rNetoTotal:= 0;

  rCajasCalibre:= 0;
  rCajasVariedad:= 0;
  rCajasProducto:= 0;
  rCajasTotal:= 0;
end;

procedure TQLCosteFrutaProducto.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rKilosCal, rKilosTot, rImporteLinea, rFacturas, rGastos: real;
  rKilosLin, rImporteLin: real;
begin
    rKilosLin:= DLCosteFrutaProducto.QListadoStock.FieldByName('peso').AsFloat;

    if rKilosLin < 0 then
    begin
      lblPrecio.Caption:= '0.00';
      lblPrecio.Caption:= '0.000';
      exit
    end;

    DLCosteFrutaProducto.ObtenerGastos(
        DLCosteFrutaProducto.QListadoStock.FieldByName( 'entrega' ).AsString,
        DLCosteFrutaProducto.QListadoStock.FieldByName( 'producto' ).AsString,
        DLCosteFrutaProducto.QListadoStock.FieldByName( 'variedad' ).AsString,
        DLCosteFrutaProducto.QListadoStock.FieldByName( 'calibre' ).AsString,
        sTipoGasto, bMasImporte, rKilosCal, rKilosTot, rImporteLinea, rFacturas, rGastos);

    if ( rImporteLinea < 0 ) or ( rKilosCal < 0 )then
    begin
      lblPrecio.Caption:= '0.00';
      lblPrecio.Caption:= '0.000';
      exit
    end;

    rImporteLin:= 0;
    begin
      if rImporteLinea <> 0 then
      begin
        if rKilosTot <> 0 then
          rImporteLin:= bRoundTo( ( rKilosCal * rGastos ) / rKilosTot, -2 );
        rImporteLin:= bRoundTo( rImporteLin + rImporteLinea, -2 );
      end
      else
      begin
        if rKilosTot <> 0 then
          rImporteLin:= bRoundTo( ( rKilosCal * ( rGastos + rFacturas ) ) / rKilosTot, -2 );
      end;
    end;

    if rKilosCal <> 0 then
      rImporteLin:= bRoundTo( ( rKilosLin * rImporteLin ) / rKilosCal, -2 )
    else
      rImporteLin:= 0;

    if rImporteLin = 0 then
    begin
      lblPrecio.Caption:= 'FALTA';
      lblImporte.Caption:= 'FALTA';
    end
    else
    begin
      if rKilosLin <> 0 then
      begin
        lblPrecio.Caption:= FormatFloat( '#,##0.000', rImporteLin / rKilosLin );
        lblImporte.Caption:= FormatFloat( '#,##0.00', rImporteLin );
      end
      else
      begin
        lblImporte.Caption:= FormatFloat( '#,##0.00', rImporteLin );
        lblPrecio.Caption:= 'FALTA';
      end;
    end;

    rImporteCalibre:= rImporteCalibre + rImporteLin;
    rImporteVariedad:= rImporteVariedad + rImporteLin;
    rImporteProducto:= rImporteProducto + rImporteLin;
    rImporteTotal:= rImporteTotal + rImporteLin;

    rBrutoCalibre:= rBrutoCalibre + rKilosLin;
    rBrutoVariedad:= rBrutoVariedad + rKilosLin;
    rBrutoProducto:= rBrutoProducto + rKilosLin;
    rBrutoTotal:= rBrutoTotal + rKilosLin;

    rCajasCalibre:= rCajasCalibre + DLCosteFrutaProducto.QListadoStock.FieldByName('cajas').AsInteger;
    rCajasVariedad:= rCajasVariedad + DLCosteFrutaProducto.QListadoStock.FieldByName('cajas').AsInteger;
    rCajasProducto:=  rCajasProducto + DLCosteFrutaProducto.QListadoStock.FieldByName('cajas').AsInteger;
    rCajasTotal:= rCajasTotal + DLCosteFrutaProducto.QListadoStock.FieldByName('cajas').AsInteger;

    if rImporteLin <> 0 then
    begin
      rNetoCalibre:= rNetoCalibre + rKilosLin;
      rNetoVariedad:= rNetoVariedad + rKilosLin;
      rNetoProducto:= rNetoProducto + rKilosLin;
      rNetoTotal:= rNetoTotal + rKilosLin;
    end;
  PrintBand:= not bResumen;
end;

procedure TQLCosteFrutaProducto.QRGroupPieCalibreBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bAgruparCalibre;
    lblAcumCalibre.Caption:= FormatFloat( '#,##0.00', rImporteCalibre );
    if rNetoCalibre <> 0 then
      lblPrecioCalibre.Caption:= FormatFloat( '#,##0.000', rImporteCalibre / rNetoCalibre )
    else
      lblPrecioCalibre.Caption:= '0.000';
end;

procedure TQLCosteFrutaProducto.QRGroupPieCalibreAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
    rImporteCalibre:= 0;
    rNetoCalibre:= 0;
    rBrutoCalibre:= 0;
    rCajasCalibre:= 0;
end;

procedure TQLCosteFrutaProducto.QRGroupPieVariedadBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bAgruparVariedad;
    lblAcumVariedad.Caption:= FormatFloat( '#,##0.00', rImporteVariedad );
    if rNetoVariedad <> 0 then
      lblPrecioVariedad.Caption:= FormatFloat( '#,##0.000', rImporteVariedad / rNetoVariedad )
    else
      lblPrecioVariedad.Caption:= '0.000';
end;

procedure TQLCosteFrutaProducto.QRGroupPieVariedadAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
    rImporteVariedad:= 0;
    rNetoVariedad:= 0;
    rBrutoVariedad:= 0;
    rCajasVariedad:= 0;
end;


procedure TQLCosteFrutaProducto.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    lblAcumProducto.Caption:= FormatFloat( '#,##0.00', rImporteProducto );
    if rNetoProducto <> 0 then
      lblPrecioProducto.Caption:= FormatFloat( '#,##0.000', rImporteProducto / rNetoProducto )
    else
      lblPrecioProducto.Caption:= '0.000';
end;

procedure TQLCosteFrutaProducto.QRBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
    rImporteProducto:= 0;
    rCajasProducto:= 0;
    rBrutoProducto:= 0;
    rNetoProducto:= 0;
end;

procedure TQLCosteFrutaProducto.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
    lblAcumTotal.Caption:= FormatFloat( '#,##0.00', rImporteTotal );
    (*
    if rNetoTotal <> 0 then
      lblPrecioTotal.Caption:= FormatFloat( '#,##0.000', rImporteTotal / rNetoTotal )
    else
      lblPrecioTotal.Caption:= '0.000';
    *)
  //El precio total no tiene sentido, no mezclemos higos con platanos ....
  lblPrecioTotal.Caption:= '';
end;

procedure TQLCosteFrutaProducto.SummaryBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
    rImporteTotal:= 0;
    rBrutoTotal:= 0;
    rNetoTotal:= 0;
    rCajasTotal:= 0;
end;

procedure TQLCosteFrutaProducto.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL CALIBRE ' + Value;
end;

procedure TQLCosteFrutaProducto.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  if bResumen then
    Value:=  FormatFloat( '#,##0', rCajasCalibre );
end;

procedure TQLCosteFrutaProducto.QRExpr4Print(sender: TObject;
  var Value: String);
begin
  if bResumen then
    Value:=  FormatFloat( '#,##0.00', rBrutoCalibre );
end;

procedure TQLCosteFrutaProducto.QRExpr8Print(sender: TObject;
  var Value: String);
begin
  if bResumen then
    Value:=  FormatFloat( '#,##0', rCajasVariedad );
end;

procedure TQLCosteFrutaProducto.QRExpr9Print(sender: TObject;
  var Value: String);
begin
  if bResumen then
    Value:=  FormatFloat( '#,##0.00', rBrutoVariedad );
end;

procedure TQLCosteFrutaProducto.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  if bResumen then
    Value:=  FormatFloat( '#,##0', rCajasProducto );
end;

procedure TQLCosteFrutaProducto.QRExpr3Print(sender: TObject;
  var Value: String);
begin
  if bResumen then
    Value:=  FormatFloat( '#,##0.00', rBrutoProducto );
end;

procedure TQLCosteFrutaProducto.QRExpr5Print(sender: TObject;
  var Value: String);
begin
  if bResumen then
    Value:=  FormatFloat( '#,##0.00', rCajasTotal);
end;

procedure TQLCosteFrutaProducto.QRExpr6Print(sender: TObject;
  var Value: String);
begin
  if bResumen then
    Value:=  FormatFloat( '#,##0.00', rBrutoTotal );
end;

end.
