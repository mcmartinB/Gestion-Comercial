unit LiquidaValorarCargaDirectaQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLLiquidaValorarCargaDirecta = class(TQuickRep)
    BandaDetalle: TQRBand;
    QRBand4: TQRBand;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    qrlblTitulo: TQRLabel;
    qrdbtxtpal_categoria: TQRDBText;
    qrdbtxtpal_cliente: TQRDBText;
    qrdbtxtpal_kilos_teoricos: TQRDBText;
    qrdbtxtpal_importe_neto: TQRDBText;
    qrdbtxtpal_importe_compra: TQRDBText;
    qrdbtxtpal_importe_gastos: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl17: TQRLabel;
    qrdbtxtpal_cliente_sal: TQRDBText;
    qrdbtxtpal_cliente_sal2: TQRDBText;
    qrdbtxtpal_entrega: TQRDBText;
    qrlbl18: TQRLabel;
    qrlbl10: TQRLabel;
    qrdbtxtpal_albaran_sal: TQRDBText;
    qrlbl11: TQRLabel;
    qrdbtxtpal_kilos_liquidar: TQRDBText;
    qrbnd1: TQRBand;
    qrsysdt1: TQRSysData;
    qrlbl1: TQRLabel;
    qrdbtxtpal_entrega5: TQRDBText;
    qrdbtxtproveedor: TQRDBText;
    qrdbtxtproveedor1: TQRDBText;
    qrdbtxtproveedor2: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtenvase_alb: TQRDBText;
    qrdbtxtenvase1: TQRDBText;
    qrdbtxtsum_alb: TQRDBText;
    qrlbl16: TQRLabel;
    qrdbtxtproveedor3: TQRDBText;
    qrlblProducto: TQRLabel;
    qrlblRango: TQRLabel;
    qrshp1: TQRShape;
    qrdbtxtalbaran: TQRDBText;
    qrdbtxtempresa: TQRDBText;
    qrlbl9: TQRLabel;
    qrbndTitleBand1: TQRBand;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl24: TQRLabel;
    qrlbl25: TQRLabel;
    qrlbl26: TQRLabel;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl31: TQRLabel;
    qrlbl32: TQRLabel;
    qrlbl33: TQRLabel;
    qrlbl34: TQRLabel;
    qrlbl35: TQRLabel;
    qrlbl36: TQRLabel;
    qrdbtxtsemana: TQRDBText;
    qrlbl37: TQRLabel;
    qrlbl38: TQRLabel;
    procedure qrdbtxtenvase1Print(sender: TObject; var Value: String);
    procedure qrdbtxtsum_albPrint(sender: TObject; var Value: String);
    procedure qrdbtxtproveedor3Print(sender: TObject; var Value: String);
    procedure qrdbtxtenvase2Print(sender: TObject; var Value: String);
    procedure qrdbtxtalbaranPrint(sender: TObject; var Value: String);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndTitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtsemanaPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrbnd1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

  procedure PrevisualizarPreciosCarga( const AProducto, ARango: string );

implementation

{$R *.DFM}

uses CargaDirectaDL, UDMAuxDB,  DPreview, CReportes;

procedure PrevisualizarPreciosCarga( const AProducto, ARango: string );
var
  QLLiquidaValorarCargaDirecta: TQLLiquidaValorarCargaDirecta;
begin
  QLLiquidaValorarCargaDirecta := TQLLiquidaValorarCargaDirecta.Create(Application);
  PonLogoGrupoBonnysa(QLLiquidaValorarCargaDirecta, QLLiquidaValorarCargaDirecta.DataSet.FieldByName('empresa').AsString);
  QLLiquidaValorarCargaDirecta.qrlblTitulo.Caption:= 'PRECIOS VENTA CARGA DIRECTA ';
  QLLiquidaValorarCargaDirecta.qrlblRango.Caption:=  ARango;
  QLLiquidaValorarCargaDirecta.qrlblProducto.Caption:=  AProducto;
  QLLiquidaValorarCargaDirecta.ReportTitle:= 'PRECIOS_VENTA_CARGA';
  Preview(QLLiquidaValorarCargaDirecta);
end;


procedure TQLLiquidaValorarCargaDirecta.qrdbtxtenvase1Print(
  sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('envase').AsString <> '' then
    Value:= desEnvase( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('envase').AsString )
  else
    Value:= desVariedad( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('proveedor').AsString,
                         DataSet.FieldByName('producto').AsString, value )
end;

procedure TQLLiquidaValorarCargaDirecta.qrdbtxtsum_albPrint(
  sender: TObject; var Value: String);
begin
  Value:= desCliente( Value );
end;

procedure TQLLiquidaValorarCargaDirecta.qrdbtxtproveedor3Print(
  sender: TObject; var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByName('empresa').AsString,  Value );
end;

procedure TQLLiquidaValorarCargaDirecta.qrdbtxtenvase2Print(
  sender: TObject; var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByName('producto').AsString,  Value );
end;

procedure TQLLiquidaValorarCargaDirecta.qrdbtxtalbaranPrint(
  sender: TObject; var Value: String);
begin
  if Value <> '' then
  begin
    if Value = '0' then
      Value:= 'O'
    else
    if Value = '1' then
      Value:= 'S'
    else
    if Value = '2' then
      Value:= 'T';
  end;
end;

procedure TQLLiquidaValorarCargaDirecta.QRBand4BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLLiquidaValorarCargaDirecta.qrbndTitleBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLLiquidaValorarCargaDirecta.qrdbtxtsemanaPrint(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TQLLiquidaValorarCargaDirecta.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    qrdbtxtproveedor3.AutoSize:= True;
    qrdbtxtenvase1.AutoSize:= True;
    qrdbtxtalbaran.AutoSize:= True;
    qrdbtxtsum_alb.AutoSize:= True;
  end
  else
  begin
    qrdbtxtproveedor3.AutoSize:= False;
    qrdbtxtproveedor3.Width:= 119;
    qrdbtxtenvase1.AutoSize:= False;
    qrdbtxtenvase1.Width:= 151;
    qrdbtxtalbaran.AutoSize:= False;
    qrdbtxtalbaran.Width:= 10;
    qrdbtxtsum_alb.AutoSize:= False;
    qrdbtxtsum_alb.Width:= 120;
  end;

end;

procedure TQLLiquidaValorarCargaDirecta.qrbnd1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.

