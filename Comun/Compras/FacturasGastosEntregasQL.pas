unit FacturasGastosEntregasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLFacturasGastosEntregas = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    bndCabecera: TQRBand;
    DetailBand1: TQRBand;
    qrlblLProveedor: TQRLabel;

    LVariable: TQRLabel;
    LTitulo: TQRLabel;
    DBFecha: TQRDBText;
    PsQRSysData1: TQRSysData;
    LPeriodo: TQRLabel;
    LMatricula: TQRLabel;
    DBMatricula: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    lblCliente: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel4: TQRLabel;
    lblKilosTitulo: TQRLabel;
    SummaryBand1: TQRBand;
    QRExpr2: TQRExpr;
    bndPieFactura: TQRBand;
    qrx1: TQRExpr;
    qrs1: TQRShape;
    qrlTotalListado: TQRLabel;
    qrlEntrega: TQRLabel;
    qrgrpProveedor: TQRGroup;
    qrlblProducto: TQRLabel;
    qrgrpProducto: TQRGroup;
    qrgrpEntrega: TQRGroup;
    qrdbtxtproveedor: TQRDBText;
    qrdbtxtproveedor1: TQRDBText;
    qrdbtxttipo: TQRDBText;
    qrdbtxtProducto: TQRDBText;
    qrdbtxtentrega: TQRDBText;
    qrdbtxtkilos: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxtProducto1: TQRDBText;
    qrdbtxtentrega1: TQRDBText;
    qrdbtxttipo1: TQRDBText;
    qrlbl2: TQRLabel;
    lblProducto: TQRLabel;
    qrdbtxtentrega2: TQRDBText;
    qrlbl3: TQRLabel;
    qrdbtxtproveedor2: TQRDBText;
    qrdbtxtproveedor3: TQRDBText;
    qrdbtxtProducto2: TQRDBText;
    qrdbtxtProducto3: TQRDBText;
    qrdbtxtentrega3: TQRDBText;
    qrdbtxtllegada: TQRDBText;
    qrdbtxtkilos1: TQRDBText;
    procedure qrdbtxtproveedor1Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qreProducto1Print(sender: TObject; var Value: String);
    procedure qrdbtxttipoPrint(sender: TObject; var Value: String);
    procedure qrgrpEntregaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure qrgrpProveedorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrpProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieFacturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtentrega3Print(sender: TObject; var Value: String);
    procedure qrdbtxtProducto3Print(sender: TObject; var Value: String);
    procedure qrdbtxtproveedor3Print(sender: TObject; var Value: String);
    procedure qrdbtxtkilos1Print(sender: TObject; var Value: String);
  private
    rAcumKilos: real;
  public

    bAgruparProducto: boolean;
  end;

var
  QLFacturasGastosEntregas: TQLFacturasGastosEntregas;

implementation

{$R *.DFM}

uses
  FacturasGastosEntregasFL, UDMAuxDB;

procedure TQLFacturasGastosEntregas.qrdbtxtproveedor1Print(sender: TObject;
  var Value: String);
begin
  if bAgruparProducto then
  begin
    Value:= desProducto( DataSet.fieldByName('empresa').AsString, Value );
  end
  else
  begin
    Value:= desProveedor( DataSet.fieldByName('empresa').AsString, value );
  end;
end;

procedure TQLFacturasGastosEntregas.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rAcumKilos:= 0;
  if bAgruparProducto then
  begin
    qrgrpProveedor.Expression:= '[empresa]+[producto]';
    qrlblLProveedor.Caption:= 'Producto';
    qrlblProducto.Caption:= 'Proveedor';
    qrdbtxtproveedor.DataField:= 'producto';
    qrdbtxtproveedor1.DataField:= 'producto';
    qrdbtxtProducto.DataField:= 'proveedor';
    qrdbtxtProducto1.DataField:= 'proveedor';

    qrdbtxtproveedor2.DataField:= 'producto';
    qrdbtxtproveedor3.DataField:= 'producto';
    qrdbtxtProducto2.DataField:= 'proveedor';
    qrdbtxtProducto3.DataField:= 'proveedor';
  end
  else
  begin
    qrgrpProveedor.Expression:= '[empresa]+[proveedor]';
    qrlblLProveedor.Caption:= 'Proveedor';
    qrlblProducto.Caption:= 'Producto';
    qrdbtxtproveedor.DataField:= 'proveedor';
    qrdbtxtproveedor1.DataField:= 'proveedor';
    qrdbtxtProducto.DataField:= 'producto';
    qrdbtxtProducto1.DataField:= 'producto';

    qrdbtxtproveedor2.DataField:= 'proveedor';
    qrdbtxtproveedor3.DataField:= 'proveedor';
    qrdbtxtProducto2.DataField:= 'producto';
    qrdbtxtProducto3.DataField:= 'producto';

  end;
end;

procedure TQLFacturasGastosEntregas.qreProducto1Print(sender: TObject;
  var Value: String);
begin
  if bAgruparProducto then
  begin
    Value:= desProveedor( DataSet.fieldByName('empresa').AsString, value );
  end
  else
  begin
    Value:= desProducto( DataSet.fieldByName('empresa').AsString, Value );
  end;
end;

procedure TQLFacturasGastosEntregas.qrdbtxttipoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desTipoGastos( value );
end;

procedure TQLFacturasGastosEntregas.qrgrpEntregaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  rAcumKilos:= rAcumKilos + DataSet.FieldByName('kilos').AsFloat;
  //rKilosFactura:= rKilosFactura + DataSet.FieldByName('kilos').AsFloat;
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosEntregas.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  value:= FormatFloat( '#,##0.00', rAcumKilos );
end;

procedure TQLFacturasGastosEntregas.qrgrpProveedorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosEntregas.qrgrpProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosEntregas.bndPieFacturaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosEntregas.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosEntregas.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosEntregas.qrdbtxtentrega3Print(sender: TObject;
  var Value: String);
begin
  if   not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TQLFacturasGastosEntregas.qrdbtxtkilos1Print(sender: TObject;
  var Value: String);
begin
  if   not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TQLFacturasGastosEntregas.qrdbtxtProducto3Print(sender: TObject;
  var Value: String);
begin
  if not  ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
  begin
    if bAgruparProducto then
    begin
      Value:= desProveedor( DataSet.fieldByName('empresa').AsString, value );
    end
    else
    begin
      Value:= desProducto( DataSet.fieldByName('empresa').AsString, Value );
    end;
  end;
end;

procedure TQLFacturasGastosEntregas.qrdbtxtproveedor3Print(sender: TObject;
  var Value: String);
begin
  if not  ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
  begin
    if bAgruparProducto then
    begin
      Value:= desProducto( DataSet.fieldByName('empresa').AsString, Value );
    end
    else
    begin
      Value:= desProveedor( DataSet.fieldByName('empresa').AsString, value );
    end;
  end;
end;

end.
