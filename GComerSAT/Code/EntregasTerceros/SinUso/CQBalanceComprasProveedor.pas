unit CQBalanceComprasProveedor;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB;

type
  TQBalanceComprasProveedor = class(TQuickRep)
    bndPie: TQRBand;
    bnddFacturas: TQRSubDetail;
    bnddVentas: TQRSubDetail;
    bndCabecera: TQRBand;
    bndTransitosPie: TQRBand;
    bndTransitosCab: TQRBand;
    QRLabel1: TQRLabel;
    bndSalidasPie: TQRBand;
    bndSalidasCab: TQRBand;
    QRLabel3: TQRLabel;
    qrlTitulo: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel31: TQRLabel;
    lblSalProducto2: TQRLabel;
    lblTraProducto2: TQRLabel;
    QRSysData1: TQRSysData;
    QRDBText1: TQRDBText;
    QRSysData2: TQRSysData;
    qreproducto_ge: TQRDBText;
    qredes_gasto: TQRDBText;
    qretipo_ge: TQRDBText;
    qreimporte_ge: TQRDBText;
    qreref_fac_ge: TQRDBText;
    qrefecha_fac_ge: TQRDBText;
    qre_tl1: TQRDBText;
    qre_tl3: TQRDBText;
    qre_tl4: TQRDBText;
    qre_tl5: TQRDBText;
    bnd1: TQRBand;
    qrekilos: TQRDBText;
    qrekilos1: TQRDBText;
    qrekilos2: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrecliente: TQRDBText;
    qreenvase: TQRDBText;
    qrxSumCompra: TQRExpr;
    qrx1: TQRExpr;
    qrx2: TQRExpr;
    bndSumario: TQRBand;
    qrx4: TQRExpr;
    qreproducto_ge1: TQRDBText;
    qrlENTREGA: TQRLabel;
    qrs1: TQRShape;
    qrl4: TQRLabel;
    QRLabel2: TQRLabel;
    qrs2: TQRShape;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrlFechas: TQRLabel;
    qrgrpProveedor: TQRGroup;
    qrlblProveedor: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrlbl1: TQRLabel;
    qrbndPieProveedor: TQRBand;
    bndcChildBand2: TQRChildBand;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    procedure qrxSumCompraPrint(sender: TObject; var Value: String);
    procedure qrx1Print(sender: TObject; var Value: String);
    procedure qrl4Print(sender: TObject; var Value: String);
    procedure qreproducto_ge1Print(sender: TObject; var Value: String);
    procedure qreclientePrint(sender: TObject; var Value: String);
    procedure qreenvasePrint(sender: TObject; var Value: String);
    procedure fechaPrint(sender: TObject; var Value: String);
    procedure qre_tl4Print(sender: TObject; var Value: String);
    procedure qre_tl1Print(sender: TObject; var Value: String);
    procedure qrlENTREGAPrint(sender: TObject; var Value: String);
    procedure qrl5Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrlblProveedorPrint(sender: TObject; var Value: String);
    procedure qrlbl1Print(sender: TObject; var Value: String);
    procedure bndcChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieProveedorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndcChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure qrlbl3Print(sender: TObject; var Value: String);
    procedure qrl6Print(sender: TObject; var Value: String);
  private
    bProveedor: Boolean;
    sEmpresa, sProveedor: string;
    rSumFacturasGrupo, rSumVentasGrupo: Real;
    rSumFacturasProveedor, rSumVentasProveedor: Real;
    rSumFacturasTotal, rSumVentasTotal: Real;


  public

  end;

procedure Previsualizar( const AOwner: TComponent;  const AEmpresa, AProveedor: String; const AFechaIni, AFechaFin: TDateTime );


implementation

{$R *.DFM}

uses DPreview, CReportes, UDMAuxDB, CDBalanceComprasProveedor;

procedure Previsualizar( const AOwner: TComponent;  const AEmpresa, AProveedor: String; const AFechaIni, AFechaFin: TDateTime );
var
  MyReport: TQBalanceComprasProveedor;
begin
  MyReport:= TQBalanceComprasProveedor.Create( AOwner );
  try
    PonLogoGrupoBonnysa(MyReport, AEmpresa);
    MyReport.qrlTitulo.Caption := 'RESUMEN BALANCE ENTREGA ';
    MyReport.ReportTitle := 'RESUMEN BALANCE ENTREGA ';
    //MyReport.qrlProveedor.Caption:= desProveedor( AEmpresa, AProveedor );
    MyReport.bProveedor:= Trim( AProveedor ) = '';
    MyReport.qrlFechas.Caption:= 'Desde el ' + FormatDateTime('dd/mm/yy', AFechaIni ) + ' al ' + FormatDateTime('dd/mm/yy', AFechaFin );
    MyReport.sEmpresa := AEmpresa;
    Preview( MyReport );
  except
    FreeAndNil( MyReport );
  end;
end;


procedure TQBalanceComprasProveedor.qrxSumCompraPrint(sender: TObject;
  var Value: String);
begin
  rSumFacturasGrupo:= qrxSumCompra.Value.dblResult;
  rSumFacturasProveedor:= rSumFacturasGrupo + rSumFacturasProveedor;
  rSumFacturasTotal:= rSumFacturasGrupo + rSumFacturasTotal;
end;

procedure TQBalanceComprasProveedor.qrx1Print(sender: TObject; var Value: String);
begin
  rSumVentasGrupo:= qrx1.Value.dblResult;
  rSumVentasProveedor:= rSumVentasGrupo + rSumVentasProveedor;
  rSumVentasTotal:= rSumVentasGrupo + rSumVentasTotal;
end;

procedure TQBalanceComprasProveedor.qrl4Print(sender: TObject; var Value: String);
begin
  Value:= FormatFloat('#,##0.00', rSumVentasGrupo - rSumFacturasGrupo );
end;

procedure TQBalanceComprasProveedor.qreproducto_ge1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( sEmpresa, Value );
end;

procedure TQBalanceComprasProveedor.qre_tl1Print(sender: TObject;
  var Value: String);
begin
  if ( Value = '00V' ) or ( Value = '00D' ) then
  begin
    Value:= '';
  end;
end;

procedure TQBalanceComprasProveedor.qreclientePrint(sender: TObject;
  var Value: String);
begin
  if ( Value = '00V' )  then
  begin
    Value:= 'VERDE';
  end
  else
  if ( Value = '00D' )  then
  begin
    Value:= 'DESTRIO';
  end
  else
  begin
    Value:= desCliente( sEmpresa, Value );
  end;

end;

procedure TQBalanceComprasProveedor.qre_tl4Print(sender: TObject;
  var Value: String);
begin
  if ( Value = 'VERDE' ) or ( Value = 'DESTRIO' ) then
  begin
    Value:= '';
  end;
end;

procedure TQBalanceComprasProveedor.qreenvasePrint(sender: TObject;
  var Value: String);
begin
  if ( Value = 'VERDE' ) or ( Value = 'DESTRIO' ) then
  begin
    Value:= '';
  end
  else
  begin
    Value:= desEnvase( sEmpresa, Value );
  end;
end;

procedure TQBalanceComprasProveedor.fechaPrint(sender: TObject; var Value: String);
begin
  Value:= 'Fecha llegada ' + Value;
end;

procedure TQBalanceComprasProveedor.qrlENTREGAPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'ENTREGA ' + DataSet.FieldByName('entrega').AsString + ' (' + FormatDateTime('dd/mm/yyyy', DataSet.FieldByName('fecha').AsDateTime)+ ')';
end;

procedure TQBalanceComprasProveedor.qrl5Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat('#,##0.00', rSumVentasTotal - rSumFacturasTotal );
end;

procedure TQBalanceComprasProveedor.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  rSumVentasProveedor:= 0;
  rSumFacturasProveedor:= 0;
  rSumVentasTotal:= 0;
  rSumFacturasTotal:= 0;
  sProveedor:= '';
end;

procedure TQBalanceComprasProveedor.qrlblProveedorPrint(sender: TObject;
  var Value: String);
begin
  Value:= DataSet.FieldByName('proveedor').AsString + ' ' + desProveedor( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('proveedor').AsString );
end;

procedure TQBalanceComprasProveedor.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  Value:= '... ' + DataSet.FieldByName('proveedor').AsString + ' ' + desProveedor( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('proveedor').AsString );
end;

procedure TQBalanceComprasProveedor.bndcChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= sProveedor = DataSet.FieldByName('proveedor').AsString;
end;

procedure TQBalanceComprasProveedor.bndPieBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  sProveedor:= DataSet.FieldByName('proveedor').AsString;
end;

procedure TQBalanceComprasProveedor.qrbndPieProveedorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bProveedor;
end;

procedure TQBalanceComprasProveedor.bndcChildBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bProveedor;
end;

procedure TQBalanceComprasProveedor.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'BALANCE PROV. ' +  DataSet.FieldByName('proveedor').AsString;
end;

procedure TQBalanceComprasProveedor.qrlbl3Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat('#,##0.00', rSumVentasProveedor - rSumFacturasProveedor );
  rSumVentasProveedor:= 0;
  rSumFacturasProveedor:= 0;
end;

procedure TQBalanceComprasProveedor.qrl6Print(sender: TObject;
  var Value: String);
begin
  if bProveedor then
    Value:= 'BALANCE TOTAL'
  else
    Value:= 'BALANCE PROV. ' +  DataSet.FieldByName('proveedor').AsString;
end;

end.
