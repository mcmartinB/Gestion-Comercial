unit CQBalanceCompras;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB;

type
  TQBalanceCompras = class(TQuickRep)
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
    QRLabel4: TQRLabel;
    qrs1: TQRShape;
    qrx4: TQRExpr;
    fecha: TQRDBText;
    qrl4: TQRLabel;
    qreproducto_ge1: TQRDBText;
    procedure qrxSumCompraPrint(sender: TObject; var Value: String);
    procedure qrx1Print(sender: TObject; var Value: String);
    procedure qrl4Print(sender: TObject; var Value: String);
    procedure qreproducto_ge1Print(sender: TObject; var Value: String);
    procedure qreclientePrint(sender: TObject; var Value: String);
    procedure qreenvasePrint(sender: TObject; var Value: String);
    procedure fechaPrint(sender: TObject; var Value: String);
    procedure qre_tl4Print(sender: TObject; var Value: String);
    procedure qre_tl1Print(sender: TObject; var Value: String);
  private
    sEmpresa: string;
    rSumFacturas, rSumVentas: Real;

  public

  end;

procedure Previsualizar( const AOwner: TComponent;  const AEmpresa, ACentro, AEntrega: String );


implementation

{$R *.DFM}

uses DPreview, CReportes, UDMAuxDB, CDBalanceCompra;

procedure Previsualizar( const AOwner: TComponent;  const AEmpresa, ACentro, AEntrega: String );
var
  MyReport: TQBalanceCompras;
begin
  MyReport:= TQBalanceCompras.Create( AOwner );
  try
    try
      CDBalanceCompra.ObtenerDatos( AOwner, AEmpresa, ACentro, AEntrega );
      PonLogoGrupoBonnysa(MyReport, AEmpresa);
      MyReport.qrlTitulo.Caption := 'BALANCE ENTREGA ' + AEntrega;
      MyReport.ReportTitle := 'BALANCE ENTREGA ' + AEntrega;
      MyReport.sEmpresa := AEmpresa;
      Preview( MyReport );
    except
      FreeAndNil( MyReport );
    end;
  finally
    CDBalanceCompra.CerrarDatos;
  end;

end;


procedure TQBalanceCompras.qrxSumCompraPrint(sender: TObject;
  var Value: String);
begin
  rSumFacturas:= qrxSumCompra.Value.dblResult;
end;

procedure TQBalanceCompras.qrx1Print(sender: TObject; var Value: String);
begin
  rSumVentas:= qrx1.Value.dblResult;
end;

procedure TQBalanceCompras.qrl4Print(sender: TObject; var Value: String);
begin
  Value:= FormatFloat('#,##0.00', rSumVentas - rSumFacturas );
end;

procedure TQBalanceCompras.qreproducto_ge1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( sEmpresa, Value );
end;

procedure TQBalanceCompras.qre_tl1Print(sender: TObject;
  var Value: String);
begin
  if ( Value = '00V' ) or ( Value = '00D' ) then
  begin
    Value:= '';
  end;
end;

procedure TQBalanceCompras.qreclientePrint(sender: TObject;
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
    Value:= desCliente( Value );
  end;

end;

procedure TQBalanceCompras.qre_tl4Print(sender: TObject;
  var Value: String);
begin
  if ( Value = 'VERDE' ) or ( Value = 'DESTRIO' ) then
  begin
    Value:= '';
  end;
end;

procedure TQBalanceCompras.qreenvasePrint(sender: TObject;
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

procedure TQBalanceCompras.fechaPrint(sender: TObject; var Value: String);
begin
  Value:= 'Fecha llegada ' + Value;
end;

end.
