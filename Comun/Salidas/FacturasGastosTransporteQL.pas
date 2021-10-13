unit FacturasGastosTransporteQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, DB, Variants;

type
  TQLFacturasGastosTransporte = class(TQuickRep)
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
    bndTotal: TQRBand;
    lblTotalKilos: TQRLabel;
    bndEmpresa: TQRBand;
    lblAcumKilos: TQRLabel;
    qrx1: TQRExpr;
    qrlTotalFactura: TQRLabel;
    qrlTotalListado: TQRLabel;
    codigo: TQRDBText;
    qrlEntrega: TQRLabel;
    grpEmpresa: TQRGroup;
    lblProducto: TQRLabel;
    grpTransporte: TQRGroup;
    qrdbtxtEmpresa: TQRDBText;
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
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    grpTipo: TQRGroup;
    bndPieFactura: TQRBand;
    lblKilosTrans: TQRLabel;
    QRLabel7: TQRLabel;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRDBText8: TQRDBText;
    qrdbtxtTransporte: TQRDBText;
    qrs1: TQRShape;
    QRShape1: TQRShape;
    grpFactura: TQRGroup;
    qrlblBndFactura: TQRLabel;
    bndAgruFact: TQRBand;
    QRLabel6: TQRLabel;
    lblKilos: TQRLabel;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure lblTotalKilosPrint(sender: TObject; var Value: String);
    procedure bndEmpresaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxttipoPrint(sender: TObject; var Value: String);
    procedure qrdbtxtagrupacionPrint(sender: TObject; var Value: string);
    procedure qrdbtxttipo1Print(sender: TObject; var Value: string);
    procedure grpEmpresaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpTransporteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgFactura_BeforePrint(Sender: TQRCustomBand;
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
    procedure lblKilosTransPrint(sender: TObject; var Value: string);
    procedure qrlTotalFacturaPrint(sender: TObject; var Value: string);
    procedure qrdbtxtTransportePrint(sender: TObject; var Value: string);
    procedure lblAcumKilosPrint(sender: TObject; var Value: string);
    procedure lblKilosPrint(sender: TObject; var Value: string);
    procedure bndAgruFactBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure grpFacturaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel6Print(sender: TObject; var Value: string);
    procedure grpTipoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    rTotalKilos, rAcumKilos, rKilosFactura, rKilos: real;
    sAsiento, sFecha: String;
  public
    bAgruparFactura: boolean;
  end;

var
  QLFacturasGastosTransporte: TQLFacturasGastosTransporte;

implementation

{$R *.DFM}

uses
  FacturasGastosSalidasFL, UDMAuxDB;

procedure TQLFacturasGastosTransporte.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( value );
end;

procedure TQLFacturasGastosTransporte.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  rTotalKilos:= rTotalKilos + DataSet.FieldByName('kilos').AsFloat;
  rAcumKilos:= rAcumKilos + DataSet.FieldByName('kilos').AsFloat;
  rKilosFactura:= rKilosFactura + DataSet.FieldByName('kilos').AsFloat;
  rKilos:= rKilos + DataSet.FieldByName('kilos').AsFloat;
end;

procedure TQLFacturasGastosTransporte.QRDBText6Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('asiento').AsString = '' then
    Value := '';
end;

procedure TQLFacturasGastosTransporte.QRDBText7Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('asiento').AsString = ''  then
    Value := '';
end;

procedure TQLFacturasGastosTransporte.qrdbtxtTransportePrint(sender: TObject;
  var Value: string);
begin
  value := value + ' - ' + desTransporte(DataSet.FieldByName('empresa').AsString, value);
end;

procedure TQLFacturasGastosTransporte.QRLabel6Print(sender: TObject;
  var Value: string);
begin
  Value := Value + ' ' + DataSet.Fieldbyname('factura').AsString;
end;

procedure TQLFacturasGastosTransporte.QRLEuro_kiloPrint(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('kilos').AsFloat = 0 then
    Value := '0'
  else
    Value := FloatToStr( DataSet.FieldByName('kilos').AsFloat / DataSet.FieldByName('kilos').AsFloat );
end;

procedure TQLFacturasGastosTransporte.qrlTotalFacturaPrint(sender: TObject;
  var Value: string);
begin
  Value := Value  + ' ' + DataSet.FieldbyName('empresa').AsString;
end;

procedure TQLFacturasGastosTransporte.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rTotalKilos:=0;
  rAcumKilos:= 0;
  rKilosFactura:= 0;
  rKilos:= 0;
end;

procedure TQLFacturasGastosTransporte.DetailBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if (DataSet.FieldByName('asiento').AsString <> '') and
     (DataSet.FieldByName('fecha_asiento').AsString <> '') then
  begin
    sAsiento := DataSet.FieldByName('asiento').AsString;
    sFecha := DataSet.FieldByName('fecha_asiento').AsString;
  end;
end;

procedure TQLFacturasGastosTransporte.DetailBand1BeforePrint(
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

procedure TQLFacturasGastosTransporte.lblTotalKilosPrint(sender: TObject;
  var Value: String);
begin
  value:= FormatFloat( '#,##0.00', rTotalKilos );
  rTotalKilos := 0;
end;

procedure TQLFacturasGastosTransporte.lblAcumKilosPrint(sender: TObject;
  var Value: string);
begin
  value:= FormatFloat( '#,##0.00', rAcumKilos );
  rAcumKilos:=0;
end;

procedure TQLFacturasGastosTransporte.lblKilosPrint(sender: TObject;
  var Value: string);
begin
  value:= FormatFloat( '#,##0.00', rKilos );
  rKilos:= 0;
end;

procedure TQLFacturasGastosTransporte.lblKilosTransPrint(sender: TObject;
  var Value: string);
begin
  value:= FormatFloat( '#,##0.00', rKilosFactura );
  rKilosFactura:= 0;
end;

procedure TQLFacturasGastosTransporte.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransporte.bndAgruFactBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bAgruparFactura;
end;

procedure TQLFacturasGastosTransporte.bndEmpresaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
//  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransporte.qrdbtxtagrupacionPrint(sender: TObject;
  var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;

end;

procedure TQLFacturasGastosTransporte.qrdbtxtEmpresaPrint(sender: TObject;
  var Value: string);
begin
  value := value + ' - ' + desEmpresa(value);
end;

procedure TQLFacturasGastosTransporte.qrdbtxttipo1Print(sender: TObject;
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

procedure TQLFacturasGastosTransporte.qrdbtxttipoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desTipoGastos( value );
end;

procedure TQLFacturasGastosTransporte.qrgFactura_BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransporte.grpEmpresaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
//  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransporte.grpFacturaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransporte.grpTipoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLFacturasGastosTransporte.grpTransporteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.
