unit ControlImportesLineasQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRControlImportesLineas = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    lblPeriodo: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    coste: TQRExpr;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    secciones: TQRExpr;
    QRLabel1: TQRLabel;
    qrxGeneral: TQRExpr;
    qrlGeneral: TQRLabel;
    qrlTotal: TQRLabel;
    qrxTotal: TQRExpr;
    qrxpr1: TQRExpr;
    qrgrpCab: TQRGroup;
    qrbndPie: TQRBand;
    qrbndTotales: TQRBand;
    qrxpr2: TQRExpr;
    qrxpr5: TQRExpr;
    qrshpPie: TQRShape;
    qrshpTotal: TQRShape;
    qrxprcliente: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrxpr14: TQRExpr;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlblImporteFactura: TQRLabel;
    qrlblImporteFacturaTotal: TQRLabel;
    qrlblImporteLinea: TQRLabel;
    qrlblImporteLineaTotal: TQRLabel;
    qrlblDiferencia: TQRLabel;
    qrlblDiferenciaTotal: TQRLabel;
    procedure qrxpr14Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndTotalesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrxpr10Print(sender: TObject; var Value: String);
  private
    sEntrega: string;
    rImporteFactura, rImporteFacturaTotal: Real;
    rImporteLinea, rImporteLineaTotal: Real;
    bFlag: Boolean;
  public
    Empresa: string;
  end;

procedure PreviewReporte(const AEmpresa, AProducto, AProveedor, AAlmacen, AAnyoSemana, AEntrega: string;
                                  const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer; const AMaxRiesgo: Real; const AVerAlmacen: Boolean  );

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, ControlImportesLineasDR;


procedure PreviewReporte(const AEmpresa, AProducto, AProveedor, AAlmacen, AAnyoSemana, AEntrega: string;
                                  const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer; const AMaxRiesgo: Real; const AVerAlmacen: Boolean );
var
  QRControlImportesLineas: TQRControlImportesLineas;
begin
  try
    if ControlImportesLineasDR.OpenDataReporte( AEmpresa, AProducto, AProveedor, AAlmacen, AAnyoSemana, AEntrega, AFechaIni, AFechaFin, ATipo, AMaxRiesgo, AVerAlmacen  ) then
    begin
      QRControlImportesLineas := TQRControlImportesLineas.Create(nil);
      PonLogoGrupoBonnysa(QRControlImportesLineas, AEmpresa);
      QRControlImportesLineas.Empresa := AEmpresa;
      Preview(QRControlImportesLineas);
      DMBaseDatos.QListado.Close;
    end
    else
    begin
      ShowMessage('Listado sin datos.');
    end;
  finally
    ControlImportesLineasDR.CloseDataReporte;
  end;
end;

procedure TQRControlImportesLineas.qrxpr14Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.fieldByName('empresa').AsString, Value );
end;

procedure TQRControlImportesLineas.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  sEntrega:= '';
  rImporteFactura:= 0;
  rImporteFacturaTotal:= 0;
  rImporteLinea:= 0;
  rImporteLinea:= 0;
end;

procedure TQRControlImportesLineas.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if sEntrega <> DataSet.FieldByName('entrega').AsString then
  begin
    sEntrega:= DataSet.FieldByName('entrega').AsString;
    rImporteFactura:= rImporteFactura + DataSet.FieldByName('importe_factura').AsFloat;
    rImporteFacturaTotal:= rImporteFacturaTotal + DataSet.FieldByName('importe_factura').AsFloat;
    bFlag:= True;
  end
  else
  begin
    bFlag:= False;
  end;
  rImporteLinea:= rImporteLinea + DataSet.FieldByName('importe_linea').AsFloat;
  rImporteLineaTotal:= rImporteLineaTotal + DataSet.FieldByName('importe_linea').AsFloat;
end;

procedure TQRControlImportesLineas.qrbndPieBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblImporteFactura.Caption:= FormatFloat('#,##0.00', rImporteFactura);
  qrlblImporteLinea.Caption:= FormatFloat('#,##0.00', rImporteLinea);
  qrlblDiferencia.Caption:= FormatFloat('#,##0.00', rImporteFactura - rImporteLinea);
  rImporteFactura:= 0;
  rImporteLinea:= 0;
end;

procedure TQRControlImportesLineas.qrbndTotalesBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblImporteFacturaTotal.Caption:= FormatFloat('#,##0.00', rImporteFacturaTotal);
  qrlblImporteLineaTotal.Caption:= FormatFloat('#,##0.00', rImporteLineaTotal);
  qrlblDiferenciaTotal.Caption:= FormatFloat('#,##0.00', rImporteFacturaTotal - rImporteLineaTotal);
  rImporteFacturaTotal:= 0;
  rImporteLineaTotal:= 0;
end;

procedure TQRControlImportesLineas.qrxpr10Print(sender: TObject;
  var Value: String);
begin
  if not bflag then
  begin
    Value:= '';
  end;
end;

end.
