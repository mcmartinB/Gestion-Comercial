unit FacturasGastosTransitosQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLFacturasGastosTransitos = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    bndCabecera: TQRBand;
    DetailBand1: TQRBand;
    qrlblCabCentro: TQRLabel;

    LVariable: TQRLabel;
    LTitulo: TQRLabel;
    DBAlbaran: TQRDBText;                                              
    DBFecha: TQRDBText;
    PsQRSysData1: TQRSysData;
    LPeriodo: TQRLabel;
    LMatricula: TQRLabel;
    DBMatricula: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel4: TQRLabel;
    lblKilosTitulo: TQRLabel;
    SummaryBand1: TQRBand;
    QRExpr2: TQRExpr;
    lblAcumKilos: TQRLabel;
    bndPieFactura: TQRBand;
    qrl1: TQRLabel;
    qrx1: TQRExpr;
    qrefactura: TQRDBText;
    qrs1: TQRShape;
    qrlTotalFactura: TQRLabel;
    qrlTotalListado: TQRLabel;
    codigo: TQRDBText;
    qrlEntrega: TQRLabel;
    qrgrpAgrupacion: TQRGroup;
    lblProducto: TQRLabel;
    qrgrpTipo: TQRGroup;
    qrgFactura_: TQRGroup;
    qrlblBndFactura: TQRLabel;
    qrdbtxtProducto: TQRDBText;
    qrdbtxttipo: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxttipo1: TQRDBText;
    qrdbtxtagrupacion: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel1: TQRLabel;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure lblAcumKilosPrint(sender: TObject; var Value: String);
    procedure bndPieFacturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrl1Print(sender: TObject; var Value: String);
    procedure qrdbtxttipoPrint(sender: TObject; var Value: String);
    procedure qrgrpAgrupacionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrpTipoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgFactura_BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxttipo1Print(sender: TObject; var Value: string);
    procedure qrdbtxtagrupacionPrint(sender: TObject; var Value: string);
    procedure QRDBText4Print(sender: TObject; var Value: string);
  private
    rAcumKilos, rKilosFactura: real;
  public
    sEmpresa: string;
    bAgruparFactura: boolean;
  end;

var
  QLFacturasGastosTransitos: TQLFacturasGastosTransitos;

implementation

{$R *.DFM}

uses
  FacturasGastosTransitosFL, UDMAuxDB;

procedure TQLFacturasGastosTransitos.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( sEmpresa, value );
end;

procedure TQLFacturasGastosTransitos.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  rAcumKilos:= rAcumKilos + DataSet.FieldByName('kilos').AsFloat;
  rKilosFactura:= rKilosFactura + DataSet.FieldByName('kilos').AsFloat;
end;

procedure TQLFacturasGastosTransitos.QRDBText4Print(sender: TObject;
  var Value: string);
begin
  Value := Value + '-' + desProducto (DataSet.FieldByName('empresa').AsString, Value);
end;

procedure TQLFacturasGastosTransitos.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rAcumKilos:= 0;
  rKilosFactura:= 0;
  qrgFactura_.Height:= 0;
end;

procedure TQLFacturasGastosTransitos.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransitos.lblAcumKilosPrint(sender: TObject;
  var Value: String);
begin
  value:= FormatFloat( '#,##0.00', rAcumKilos );
end;

procedure TQLFacturasGastosTransitos.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransitos.bndPieFacturaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bAgruparFactura;
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransitos.qrl1Print(sender: TObject; var Value: String);
begin
  value:= FormatFloat( '#,##0.00', rKilosFactura );
  rKilosFactura:= 0;
end;

procedure TQLFacturasGastosTransitos.qrdbtxtagrupacionPrint(sender: TObject;
  var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end
end;

procedure TQLFacturasGastosTransitos.qrdbtxttipo1Print(sender: TObject;
  var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end
  else
  begin
    Value:= Value + ' ' + desTipoGastos( value );
  end;
end;

procedure TQLFacturasGastosTransitos.qrdbtxttipoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desTipoGastos( value );
end;

procedure TQLFacturasGastosTransitos.qrgFactura_BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransitos.qrgrpAgrupacionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransitos.qrgrpTipoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.
