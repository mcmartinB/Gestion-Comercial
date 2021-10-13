unit FacturasGastosSalidasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLFacturasGastosSalidas = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    bndCabecera: TQRBand;
    DetailBand1: TQRBand;
    LAlbaran: TQRLabel;

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
    lblCliente: TQRLabel;
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
    qrdbtxtagrupacion: TQRDBText;
    qrdbtxttipo1: TQRDBText;
    lblTransporte: TQRLabel;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure lblAcumKilosPrint(sender: TObject; var Value: String);
    procedure bndPieFacturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrl1Print(sender: TObject; var Value: String);
    procedure qrdbtxttipoPrint(sender: TObject; var Value: String);
    procedure qrdbtxtagrupacionPrint(sender: TObject; var Value: string);
    procedure qrdbtxttipo1Print(sender: TObject; var Value: string);
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
  private
    rAcumKilos, rKilosFactura: real;
  public
    sEmpresa: string;
    bAgruparFactura: boolean;
  end;

var
  QLFacturasGastosSalidas: TQLFacturasGastosSalidas;

implementation

{$R *.DFM}

uses
  FacturasGastosSalidasFL, UDMAuxDB;

procedure TQLFacturasGastosSalidas.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( value );
end;

procedure TQLFacturasGastosSalidas.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  rAcumKilos:= rAcumKilos + DataSet.FieldByName('kilos').AsFloat;
  rKilosFactura:= rKilosFactura + DataSet.FieldByName('kilos').AsFloat;
end;

procedure TQLFacturasGastosSalidas.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rAcumKilos:= 0;
  rKilosFactura:= 0;
  qrgFactura_.Height:= 0;
end;

procedure TQLFacturasGastosSalidas.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosSalidas.lblAcumKilosPrint(sender: TObject;
  var Value: String);
begin
  value:= FormatFloat( '#,##0.00', rAcumKilos );
end;

procedure TQLFacturasGastosSalidas.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosSalidas.bndPieFacturaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bAgruparFactura;
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosSalidas.qrl1Print(sender: TObject; var Value: String);
begin
  value:= FormatFloat( '#,##0.00', rKilosFactura );
  rKilosFactura:= 0;
end;

procedure TQLFacturasGastosSalidas.qrdbtxtagrupacionPrint(sender: TObject;
  var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;

end;

procedure TQLFacturasGastosSalidas.qrdbtxttipo1Print(sender: TObject;
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

procedure TQLFacturasGastosSalidas.qrdbtxttipoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desTipoGastos( value );
end;

procedure TQLFacturasGastosSalidas.qrgFactura_BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosSalidas.qrgrpAgrupacionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosSalidas.qrgrpTipoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.
