unit LQGastosEntregasEx;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLGastosEntregasEx = class(TQuickRep)
    bndCabeceraListado: TQRBand;
    lblTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    bndPieListado: TQRBand;
    QRSysData2: TQRSysData;
    DetailBand1: TQRBand;
    lblRangoFechas: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel1: TQRLabel;
    qrlTipoFecha: TQRLabel;
    QRLabel6: TQRLabel;
    QRSubDetailGastos: TQRSubDetail;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText2: TQRDBText;
    qreImporteEntrega2: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    lblProducto: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel7: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel3: TQRLabel;
    qrs2: TQRShape;
    qrlblImporteTotal: TQRLabel;
    qrlPiezas: TQRLabel;
    qrlblGastoTotal: TQRLabel;
    qrlblKilosTotal: TQRLabel;
    qrlblUnidadesTotal: TQRLabel;
    qtxtimporte_ec: TQRDBText;
    qtxtkilos_ec: TQRDBText;
    qtxtunidades_ec: TQRDBText;
    qtxtfecha: TQRDBText;
    qtxtcodigo_ec: TQRDBText;
    productoLin: TQRDBText;
    qtxtproveedor_ec: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrdbtxtproducto_el: TQRDBText;
    qrdbtxtproveedor_ec1: TQRDBText;
    qrdbtxtcodigo_ec: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    qrdbtxtunidades_ec: TQRDBText;
    qrdbtxtkilos_ec: TQRDBText;
    qrdbtxtimporte_ec: TQRDBText;
    qrbndPieProducto: TQRBand;
    qrgrpProducto: TQRGroup;
    qrlbl6: TQRLabel;
    qrlblUnidadesPro: TQRLabel;
    qrlblKilosPro: TQRLabel;
    qrlblImportesPro: TQRLabel;
    qrlblGastoPro: TQRLabel;
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure qtxtproveedor_ecPrint(sender: TObject; var Value: String);
    procedure QRDBText12Print(sender: TObject; var Value: String);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetailGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrbndPieProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrpProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieListadoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl6Print(sender: TObject; var Value: String);
  private
    rUnidades, rKilos, rImporte, rGasto: Real;
    rUnidadesPro, rKilosPro, rImportePro, rGastoPro: Real;

  public
    sEmpresa: string;

  end;

function Imprimir( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                   const AFechaIni, AFechaFin, AFechaCorte: TDateTime; const ACorte: Boolean;
                   const AAgruparProducto, ASepararHojas: boolean; const ASinGastos: Integer;
                   const ATipoCodigo, AFacturaGrabada: Integer; const AFechaFactura: TDateTime ): boolean;

implementation

{$R *.DFM}

uses
  LDGastosEntregas, DPreview, UDMAuxDB, CReportes, UDMConfig;

var
  QLGastosEntregasEx: TQLGastosEntregasEx;

function Imprimir( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                   const AFechaIni, AFechaFin, AFechaCorte: TDateTime; const ACorte: Boolean;
                   const AAgruparProducto, ASepararHojas: boolean; const ASinGastos: Integer;
                   const ATipoCodigo, AFacturaGrabada: Integer; const AFechaFactura: TDateTime ): boolean;
begin
  DLGastosEntregas:= TDLGastosEntregas.Create( Application );
  try
    result:= DLGastosEntregas.ObtenerDatosCompletos(AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto,
                AFechaIni, AFechaFin, AFechaCorte, ACorte, AAgruparProducto, ASinGastos, ATipoCodigo, AFacturaGrabada, AFechaFactura );
    if result then
    begin
      QLGastosEntregasEx:= TQLGastosEntregasEx.Create( Application );
      QLGastosEntregasEx.sEmpresa:= AEmpresa;
      QLGastosEntregasEx.qrlTipoFecha.Caption:= 'F.Llegada';
      PonLogoGrupoBonnysa( QLGastosEntregasEx, AEmpresa );
      if AEntrega = '' then
        QLGastosEntregasEx.lblRangoFechas.Caption:= DateToStr( AFechaIni ) + ' a ' +
                                                      DateToStr( AFechaFin )
      else
        QLGastosEntregasEx.lblRangoFechas.Caption:= 'ENTREGA ' + AEntrega;
      try
        Preview( QLGastosEntregasEx );
      except
        FreeAndNil(QLGastosEntregasEx);
        raise;
      end;
    end;
  finally
    DLGastosEntregas.CerrarQuery;
    FreeAndNil( DLGastosEntregas );
  end;
end;

procedure TQLGastosEntregasEx.QRDBText12Print(sender: TObject;
  var Value: String);
begin
  Value:= desTipoGastos( Value );
end;

procedure TQLGastosEntregasEx.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa_ec').AsString, Value );
end;

procedure TQLGastosEntregasEx.qtxtproveedor_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProveedor( DataSet.FieldByName('empresa_ec').AsString, Value );
end;

procedure TQLGastosEntregasEx.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );

  rUnidadesPro:= rUnidadesPro +  DataSet.fieldByName('unidades_ec').AsInteger;
  rKilosPro:= rKilosPro + DataSet.fieldByName('kilos_ec').AsInteger;
  rImportePro:= rImportePro + DataSet.fieldByName('importe_ec').AsFloat;
  rGastoPro:= rGastopro + QRSubDetailGastos.DataSet.fieldByName('importe_ge').AsFloat;
end;

procedure TQLGastosEntregasEx.QRSubDetailGastosBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qtxtimporte_ec.Enabled:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  qtxtunidades_ec.Enabled:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  qtxtkilos_ec.Enabled:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  qtxtcodigo_ec.Enabled:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  qtxtfecha.Enabled:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  qtxtproveedor_ec.Enabled:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  productoLin.Enabled:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLGastosEntregasEx.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rUnidades:= 0;
  rKilos:= 0;
  rImporte:= 0;
  rGasto:= 0;
  rUnidadesPro:= 0;
  rKilosPro:= 0;
  rImportePro:= 0;
  rGastoPro:= 0;
end;

procedure TQLGastosEntregasEx.qrbndPieProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblUnidadesPro.Caption:= FormatFloat('#,###', rUnidadesPro);
  qrlblKilosPro.Caption:= FormatFloat('#,###', rKilosPro);
  qrlblImportesPro.Caption:= FormatFloat('#,###', rImportePro);
  qrlblGastoPro.Caption:= FormatFloat('#,###', rGastoPro);

  rUnidades:= rUnidadesPro +  rUnidades;
  rKilos:= rKilosPro + rKilos;
  rImporte:= rImportePro + rImporte;
  rGasto:= rGastopro + rGasto;

  rUnidadesPro:= 0;
  rKilosPro:= 0;
  rImportePro:= 0;
  rGastoPro:= 0;

  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLGastosEntregasEx.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblUnidadesTotal.Caption:= FormatFloat('#,###', rUnidades);
  qrlblKilosTotal.Caption:= FormatFloat('#,###', rKilos);
  qrlblImporteTotal.Caption:= FormatFloat('#,###', rImporte);
  qrlblGastoTotal.Caption:= FormatFloat('#,###', rGasto);

  rUnidades:= 0;
  rKilos:= 0;
  rImporte:= 0;
  rGasto:= 0;

  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLGastosEntregasEx.qrgrpProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrgrpProducto.Height:= 0;
end;

procedure TQLGastosEntregasEx.bndPieListadoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLGastosEntregasEx.qrlbl6Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL GASTOS ' + desProducto( DataSet.FieldByName('empresa_ec').AsString,DataSet.FieldByName('producto_el').AsString );
end;

end.

