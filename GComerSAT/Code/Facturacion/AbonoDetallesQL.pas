unit AbonoDetallesQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLAbonoDetalles = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblPeriodo: TQRLabel;
    PageFooterBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    n_factura: TQRDBText;
    fecha_factura: TQRDBText;
    fecha_albaran_fal: TQRDBText;
    n_albaran_fal: TQRDBText;
    cliente_sal_f: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    lblFecha_factura_1: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRSysData1: TQRSysData;
    centro_salida_fal: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    fecha_abono: TQRDBText;
    QRLabel3: TQRLabel;
    producto_fal: TQRDBText;
    abono: TQRDBText;
    descripcionCliente: TQRDBText;
    envase_fal: TQRDBText;
    lblProducto: TQRLabel;
    importe_total: TQRDBText;
    precio_fal: TQRDBText;
    unidades_fal: TQRDBText;
    unidad_fal: TQRDBText;
    QRDBText1: TQRDBText;
    QRLabel4: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    bndCabMoneda: TQRGroup;
    bndCabUnidad: TQRGroup;
    bndPieMoneda: TQRBand;
    bndPieUnidad: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel14: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    procedure descripcionClientePrint(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure envase_falPrint(sender: TObject; var Value: String);
    procedure QRLabel4Print(sender: TObject; var Value: String);
    procedure QRLabel3Print(sender: TObject; var Value: String);
    procedure importe_totalPrint(sender: TObject; var Value: String);
    procedure bndCabMonedaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndPieUnidadAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndPieMonedaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure unidades_falPrint(sender: TObject; var Value: String);
    procedure QRLabel15Print(sender: TObject; var Value: String);
    procedure QRLabel16Print(sender: TObject; var Value: String);
    procedure QRLabel18Print(sender: TObject; var Value: String);
    procedure QRLabel19Print(sender: TObject; var Value: String);
    procedure fecha_albaran_falPrint(sender: TObject; var Value: String);
    procedure fecha_facturaPrint(sender: TObject; var Value: String);
    procedure fecha_abonoPrint(sender: TObject; var Value: String);

  private
    sEmpresa: string;
    rAcumMoneda, rAcumUnidad, rAcumUnidades: Real;

  public
    procedure PreparaListado( const AEmpresa, AProducto, AEnvase, ACliente, AFechaIni, AFechaFin: string );

  end;

  function VerListadoOrden( const AOwner: TComponent;
                          const AEmpresa, AProducto, AEnvase, ACliente: string ;
                          const AFechaIni, AFechaFin: TDateTime;
                          const AAnulaciones: boolean ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, AbonoDetallesDL, DPreview, UDMAuxDB, bMath, Variants;

var
  QLAbonoDetalles: TQLAbonoDetalles;
  DLAbonoDetalles: TDLAbonoDetalles;

procedure VerListadoOrdenEx( const AOwner: TComponent;
                          const AEmpresa, AProducto, AEnvase, ACliente: string ;
                          const AFechaIni, AFechaFin: TDateTime );
begin
  QLAbonoDetalles:= TQLAbonoDetalles.Create( AOwner );
  try
    QLAbonoDetalles.PreparaListado( AEmpresa, AProducto, AEnvase, ACliente, DateToStr(AFechaIni), DateToStr(AFechaFin) );
    Previsualiza( QLAbonoDetalles );
  finally
    FreeAndNil( QLAbonoDetalles );
  end;
end;

function VerListadoOrden( const AOwner: TComponent;
                          const AEmpresa, AProducto, AEnvase, ACliente: string ;
                          const AFechaIni, AFechaFin: TDateTime;
                          const AAnulaciones: boolean ): Boolean;
begin
  DLAbonoDetalles:= TDLAbonoDetalles.Create( AOwner );
  try
    result:= DLAbonoDetalles.DatosListado( AEmpresa, AProducto, AEnvase, ACliente, AFechaIni, AFechaFin, AAnulaciones );
    if result then
    begin
      VerListadoOrdenEx( AOwner, AEmpresa, AProducto, AEnvase, ACliente, AFechaIni, AFechaFin );
    end;
  finally
    FreeAndNil( DLAbonoDetalles );
  end;
end;

procedure TQLAbonoDetalles.PreparaListado( const AEmpresa, AProducto, AEnvase, ACliente, AFechaIni, AFechaFin: string );
begin
  sEmpresa:= AEmpresa;
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblPeriodo.Caption:= 'Del ' + AFechaIni + ' al ' + AFechaFin;
  if AProducto = '' then
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS'
  else
    lblProducto.Caption:= AProducto + ' ' +  desProducto( sEmpresa, AProducto );
end;

procedure TQLAbonoDetalles.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rAcumMoneda:= 0;
  rAcumUnidad:= 0;
  rAcumUnidades:= 0;
end;

procedure TQLAbonoDetalles.descripcionClientePrint(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( value );
end;

procedure TQLAbonoDetalles.QRLabel4Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= 'Envase'
  else
    Value:= '';
end;

procedure TQLAbonoDetalles.envase_falPrint(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= Value
  else
    Value:= Value + ' '  + desEnvase( sEmpresa, Value );
end;

procedure TQLAbonoDetalles.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= desEnvase( sEmpresa, Value )
  else
    Value:= '';
end;

procedure TQLAbonoDetalles.QRLabel3Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= 'Producto'
  else
    Value:= 'Producto/Envase';
end;

procedure TQLAbonoDetalles.importe_totalPrint(sender: TObject;
  var Value: String);
begin
  rAcumMoneda:= rAcumMoneda + DataSet.FieldByName('importe_total').AsFloat;
  rAcumUnidad:= rAcumUnidad + DataSet.FieldByName('importe_total').AsFloat;
end;

procedure TQLAbonoDetalles.unidades_falPrint(sender: TObject;
  var Value: String);
begin
  rAcumUnidades:= rAcumUnidades + DataSet.FieldByName('unidades_fal').AsFloat
end;

procedure TQLAbonoDetalles.bndCabMonedaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

procedure TQLAbonoDetalles.bndPieUnidadAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  rAcumUnidad:= 0;
  rAcumUnidades:= 0;
end;

procedure TQLAbonoDetalles.bndPieMonedaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  rAcumMoneda:= 0;
end;

procedure TQLAbonoDetalles.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL UNIDAD ' + VALUE;
end;

procedure TQLAbonoDetalles.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL MONEDA ' + VALUE;
end;

procedure TQLAbonoDetalles.QRLabel15Print(sender: TObject;
  var Value: String);
begin
  Value:= FloatToStr( rAcumUnidades );
end;

procedure TQLAbonoDetalles.QRLabel16Print(sender: TObject;
  var Value: String);
begin
  Value:= FloatToStr( rAcumUnidad );
end;

procedure TQLAbonoDetalles.QRLabel18Print(sender: TObject;
  var Value: String);
begin
  Value:= FloatToStr( rAcumMoneda );
end;

procedure TQLAbonoDetalles.QRLabel19Print(sender: TObject;
  var Value: String);
begin
  if rAcumUnidades <> 0 then
    Value:= FormatFloat( '#.000', rAcumUnidad/ rAcumUnidades )
  else
    Value:= '';
end;

procedure TQLAbonoDetalles.fecha_albaran_falPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('fecha_albaran_fal').Value = NULL then
    Value:= '';
end;

procedure TQLAbonoDetalles.fecha_facturaPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('fecha_factura').Value = NULL then
    Value:= '';
end;

procedure TQLAbonoDetalles.fecha_abonoPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('fecha_abono').Value = NULL then
    Value:= '';
end;

end.
