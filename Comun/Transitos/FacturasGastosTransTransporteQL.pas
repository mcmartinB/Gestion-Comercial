unit FacturasGastosTransTransporteQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, DB, Variants;

type
  TQLFacturasGastosTransTransporte = class(TQuickRep)
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
    lblCentro: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel4: TQRLabel;
    lblKilosTitulo: TQRLabel;
    SummaryBand1: TQRBand;
    lblTotalKilos: TQRLabel;
    bndPieFactura: TQRBand;
    lblKilosTrans: TQRLabel;
    qrx1: TQRExpr;
    qrs1: TQRShape;
    qrlTotalFactura: TQRLabel;
    qrlTotalListado: TQRLabel;
    codigo: TQRDBText;
    qrlEntrega: TQRLabel;
    grpEmpresa: TQRGroup;
    lblProducto: TQRLabel;
    grpTransporte: TQRGroup;
    qrdbtxtEmpresa: TQRDBText;
    qrdbtxtTransporte: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxtagrupacion: TQRDBText;
    qrdbtxttipo1: TQRDBText;
    lblTransporte: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText6: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText7: TQRDBText;
    QRShape1: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    grpTipo: TQRGroup;
    QRDBText8: TQRDBText;
    grpFactura: TQRGroup;
    qrlblBndFactura: TQRLabel;
    bndEmpresa: TQRBand;
    QRLabel6: TQRLabel;
    lblAcumKilos: TQRLabel;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    bndAgruFact: TQRBand;
    QRLabel7: TQRLabel;
    lblKilos: TQRLabel;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure lblTotalKilosPrint(sender: TObject; var Value: String);
    procedure bndPieFacturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lblKilosTransPrint(sender: TObject; var Value: String);
    procedure qrdbtxtTransportePrint(sender: TObject; var Value: String);
    procedure qrdbtxtagrupacionPrint(sender: TObject; var Value: string);
    procedure qrdbtxttipo1Print(sender: TObject; var Value: string);
    procedure grpEmpresaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpTransporteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgFactura_BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLEuro_kiloPrint(sender: TObject; var Value: string);
    procedure qrdbtxtEmpresaPrint(sender: TObject; var Value: string);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText6Print(sender: TObject; var Value: string);
    procedure QRDBText7Print(sender: TObject; var Value: string);
    procedure grpTipoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRDBText8Print(sender: TObject; var Value: string);
    procedure grpFacturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lblAcumKilosPrint(sender: TObject; var Value: string);
    procedure bndAgruFactBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lblKilosPrint(sender: TObject; var Value: string);
    procedure QRLabel7Print(sender: TObject; var Value: string);
  private
    rAcumKilos, rKilosFactura, rTotalKilos, rKilos: real;
    sAsiento, sFecha: String;
  public
    sEmpresa: string;
    bAgruparFactura: boolean;
  end;

var
  QLFacturasGastosTransTransporte: TQLFacturasGastosTransTransporte;

implementation

{$R *.DFM}

uses
  FacturasGastosSalidasFL, UDMAuxDB;

procedure TQLFacturasGastosTransTransporte.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( value );
end;

procedure TQLFacturasGastosTransTransporte.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  rKilos:= rKilos + DataSet.FieldByName('kilos').AsFloat;
  rAcumKilos:= rAcumKilos + DataSet.FieldByName('kilos').AsFloat;
  rKilosFactura:= rKilosFactura + DataSet.FieldByName('kilos').AsFloat;
  rTotalKilos:= rTotalKilos + DataSet.FieldByName('kilos').AsFloat;
end;

procedure TQLFacturasGastosTransTransporte.QRDBText6Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('asiento').AsString = '' then
    Value := '';
end;

procedure TQLFacturasGastosTransTransporte.QRDBText7Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('asiento').AsString = ''  then
    Value := '';
end;

procedure TQLFacturasGastosTransTransporte.QRDBText8Print(sender: TObject;
  var Value: string);
begin
  Value:= Value + ' ' + desTipoGastos( value );
end;

procedure TQLFacturasGastosTransTransporte.QRLabel7Print(sender: TObject;
  var Value: string);
begin
  Value := Value + ' ' + DataSet.Fieldbyname('factura').AsString;
end;

procedure TQLFacturasGastosTransTransporte.QRLEuro_kiloPrint(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('kilos').AsFloat = 0 then
    Value := '0'
  else
    Value := FloatToStr( DataSet.FieldByName('kilos').AsFloat / DataSet.FieldByName('kilos').AsFloat );
end;

procedure TQLFacturasGastosTransTransporte.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rKilos:=0;
  rAcumKilos:= 0;
  rKilosFactura:= 0;
  rTotalKilos:= 0;
end;

procedure TQLFacturasGastosTransTransporte.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
//  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransTransporte.DetailBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if (DataSet.FieldByName('asiento').AsString <> '') and
     (DataSet.FieldByName('fecha_asiento').AsString <> '') then
  begin
    sAsiento := DataSet.FieldByName('asiento').AsString;
    sFecha := DataSet.FieldByName('fecha_asiento').AsString;
  end;
end;

procedure TQLFacturasGastosTransTransporte.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if (sAsiento <> '') and (sFecha <> '') then
  begin
    if (sAsiento = DataSet.FieldByName('asiento').AsString) and
       (sFecha = DataSet.FieldByName('fecha_asiento').AsString) then
    begin
       if not (DataSet.State in dsEditModes) then    DataSet.Edit;
       DataSet.FieldByName('asiento').Value := '';
       DataSet.FieldByName('fecha_asiento').Value := Null;
       DataSet.FieldByName('base_imponible').Value := 0;
       DataSet.Post;
    end
  end;
{
    else
    begin
      rAcumBaseImp := rAcumBaseImp + DataSet.FieldByName('base_imponible').AsFloat;
      rBaseImponible := rBaseImponible  + DataSet.FieldByName('base_imponible').AsFloat;
    end;
  end
  else
  begin
    rAcumBaseImp := rAcumBaseImp + DataSet.FieldByName('base_imponible').AsFloat;
    rBaseImponible := rBaseImponible  + DataSet.FieldByName('base_imponible').AsFloat;
  end;
}
end;

procedure TQLFacturasGastosTransTransporte.lblTotalKilosPrint(sender: TObject;
  var Value: String);
begin
  value:= FormatFloat( '#,##0.00', rTotalKilos );
  rTotalKilos := 0;
end;

procedure TQLFacturasGastosTransTransporte.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransTransporte.bndAgruFactBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bAgruparFactura;
end;

procedure TQLFacturasGastosTransTransporte.bndPieFacturaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
//  PrintBand:= bAgruparFactura;
//  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransTransporte.lblAcumKilosPrint(sender: TObject;
  var Value: string);
begin
  value:= FormatFloat( '#,##0.00', rAcumKilos );
  rAcumKilos:=0;
end;

procedure TQLFacturasGastosTransTransporte.lblKilosPrint(sender: TObject;
  var Value: string);
begin
  value:= FormatFloat( '#,##0.00', rKilos );
  rKilos:= 0;
end;

procedure TQLFacturasGastosTransTransporte.lblKilosTransPrint(sender: TObject; var Value: String);
begin
  value:= FormatFloat( '#,##0.00', rKilosFactura );
  rKilosFactura:= 0;
end;

procedure TQLFacturasGastosTransTransporte.qrdbtxtagrupacionPrint(sender: TObject;
  var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;

end;

procedure TQLFacturasGastosTransTransporte.qrdbtxtEmpresaPrint(sender: TObject;
  var Value: string);
begin
  value := value + ' - ' + desEmpresa(value);
end;

procedure TQLFacturasGastosTransTransporte.qrdbtxttipo1Print(sender: TObject;
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

procedure TQLFacturasGastosTransTransporte.qrdbtxtTransportePrint(sender: TObject;
  var Value: String);
begin
  value := value + ' - ' + desTransporte(DataSet.FieldByName('empresa').AsString, value);
end;

procedure TQLFacturasGastosTransTransporte.qrgFactura_BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransTransporte.grpEmpresaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
//  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransTransporte.grpFacturaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransTransporte.grpTipoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransTransporte.grpTransporteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.
