unit ResumenConsumosEntregaQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLResumenConsumosEntrega = class(TQuickRep)
    BandaDetalle: TQRBand;
    QRBand4: TQRBand;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    qrlblTitulo: TQRLabel;
    SummaryBand1: TQRBand;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrdbtxtpal_cliente_sal: TQRDBText;
    qrgrpEntrega: TQRGroup;
    qrbndPieEntrega: TQRBand;
    qrlbl20: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl24: TQRLabel;
    qrgrpCategoria: TQRGroup;
    qrbndPieCategoria: TQRBand;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrxpr25: TQRExpr;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrxpr29: TQRExpr;
    qrshpLinCategoria: TQRShape;
    qrbnd1: TQRBand;
    qrsysdt1: TQRSysData;
    qrlbl1: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl17: TQRLabel;
    qrdbtxtpal_kilos_liquidar: TQRDBText;
    qrdbtxtpal_kilos_liquidar1: TQRDBText;
    qrdbtxtcompra: TQRDBText;
    qrdbtxtpal_importe_descuento: TQRDBText;
    qrdbtxtpal_importe_gastos: TQRDBText;
    qrdbtxtpal_importe_compra: TQRDBText;
    qrdbtxtarancel: TQRDBText;
    qrdbtxtkilos_destrio: TQRDBText;
    qrdbtxtkilos_otros: TQRDBText;
    qrdbtxtpal_cliente: TQRDBText;
    qrdbtxtpal_envase_sal: TQRDBText;
    qrdbtxtpal_status: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrdbtxt3: TQRDBText;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrdbtxtproducto1: TQRDBText;
    qrdbtxtalmacen: TQRDBText;
    qrdbtxtproducto2: TQRDBText;
    qrdbtxtproducto3: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl18: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrlbl15: TQRLabel;
    qrxpr2: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrlbl10: TQRLabel;
    qrdbtxtalmacen1: TQRDBText;
    qrdbtxtproducto4: TQRDBText;
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
    procedure qrdbtxtalmacenPrint(sender: TObject; var Value: String);
    procedure qrdbtxtproducto2Print(sender: TObject; var Value: String);
    procedure qrdbtxtproducto3Print(sender: TObject; var Value: String);
    procedure soloexportacion(sender: TObject; var Value: String);
    procedure noexportacion(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtalmacen1Print(sender: TObject; var Value: String);
    procedure qrdbtxtproducto4Print(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public

  end;

  procedure PrevisualizarResumenEntrega( const AEmpresa: string );

implementation

{$R *.DFM}

uses ResumenConsumosDL, UDMAuxDB,  DPreview, CReportes;


procedure PrevisualizarResumenEntrega( const AEmpresa: string );
var
  QLResumenConsumosEntrega: TQLResumenConsumosEntrega;
begin
  QLResumenConsumosEntrega := TQLResumenConsumosEntrega.Create(Application);
  PonLogoGrupoBonnysa(QLResumenConsumosEntrega, AEmpresa);
  QLResumenConsumosEntrega.sEmpresa:= AEmpresa;
  QLResumenConsumosEntrega.qrlblTitulo.Caption:= 'RESUMEN CONSUMOS POR ENTREGA' + AEmpresa;
  QLResumenConsumosEntrega.ReportTitle:= 'RESUMEN_CONSUMOS_ENTREGA_' + AEmpresa ;
  Preview(QLResumenConsumosEntrega);
end;


procedure TQLResumenConsumosEntrega.qrdbtxtproducto1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( sEmpresa, Value );
end;

procedure TQLResumenConsumosEntrega.qrdbtxtalmacenPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProveedorAlmacen( sEmpresa, DataSet.fieldByName('proveedor').AsString, Value );
end;

procedure TQLResumenConsumosEntrega.qrdbtxtproducto2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL PRODUCTO [' + Value + '] ' + desProducto( sEmpresa, Value );
end;

procedure TQLResumenConsumosEntrega.qrdbtxtproducto3Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ALMACEN ' + DataSet.fieldByName('proveedor').AsString + '/' + Value +
          ' [' + DataSet.fieldByName('producto').AsString + '] ';
end;



procedure TQLResumenConsumosEntrega.soloexportacion(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQLResumenConsumosEntrega.noexportacion(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLResumenConsumosEntrega.qrdbtxtalmacen1Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end
  else
  begin
    Value:= desProveedorAlmacen( sEmpresa, DataSet.fieldByName('proveedor').AsString, Value );
  end;
end;

procedure TQLResumenConsumosEntrega.qrdbtxtproducto4Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end
  else
  begin
    Value:= desProducto( sEmpresa, Value );
  end;
end;

end.

