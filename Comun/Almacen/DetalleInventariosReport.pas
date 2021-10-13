unit DetalleInventariosReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, grimgctrl;

type
  TQRDetalleInventarios = class(TQuickRep)
    QRBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblFecha: TQRLabel;
    lblProducto: TQRLabel;
    qrbndDetalle: TQRBand;
    qrdbtxtexpedicion_c1: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtdes_envase: TQRDBText;
    qrdbtxtexpedicion_c2: TQRDBText;
    qrgrpCab: TQRGroup;
    qrdbtxtempresa: TQRDBText;
    qrdbtxtcentro: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrchldbndChildBand1: TQRChildBand;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrbndPie: TQRBand;
    qrdbtxtcampo1: TQRDBText;
    qrdbtxtintermedia11: TQRDBText;
    qrdbtxtintermedia21: TQRDBText;
    qrdbtxttercera1: TQRDBText;
    qrdbtxtdestrio1: TQRDBText;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrshp1: TQRShape;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrlbldestrio: TQRLabel;
    qrlbltercera: TQRLabel;
    qrlblsegunda: TQRLabel;
    qrlblprimera: TQRLabel;
    qrlblcampo: TQRLabel;
    qrlbl19: TQRLabel;
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
    procedure qrbndPieAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrbndSummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    rCampo, rPrimera, rSegunda, rTercera, rDestrio: real;
  public

  end;

procedure PrintDetalleInventarios( const AOwner: TComponent;
                                 const AEmpresa, ACentro, AProducto: string;
                                 const AFechaIni: TDateTime; const iATipo: integer );

implementation

{$R *.DFM}

uses
  ResumenInventariosData, DPreview, CReportes, UDMAuxDB;

var
  QRDetalleInventarios: TQRDetalleInventarios;

procedure PrintDetalleInventarios( const AOwner: TComponent;
                                 const AEmpresa, ACentro, AProducto: string;
                                 const AFechaIni: TDateTime; const iATipo: integer );
begin
  QRDetalleInventarios:= TQRDetalleInventarios.Create( AOwner );
  try
    PonLogoGrupoBonnysa(QRDetalleInventarios, AEmpresa);
    if AProducto = '' then
      QRDetalleInventarios.lblProducto.Caption:= 'TODOS LOS PRODUCTOS.'
    else
      QRDetalleInventarios.lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto );
    QRDetalleInventarios.lblFecha.Caption:= 'Del ' + DateToStr( AFechaIni ) ;
    Previsualiza( QRDetalleInventarios );
  finally
    FreeAndNil( QRDetalleInventarios );
  end;
end;

procedure TQRDetalleInventarios.qrdbtxtproducto1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByName('empresa').AsString, value );
end;

procedure TQRDetalleInventarios.qrbndPieAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  rCampo:= rCampo + DataSet.FieldByName('campo').AsFloat;
  rPrimera:= rPrimera + DataSet.FieldByName('intermedia1').AsFloat;
  rSegunda:= rSegunda + DataSet.FieldByName('intermedia2').AsFloat;
  rTercera:= rTercera + DataSet.FieldByName('tercera').AsFloat;
  rDestrio:= rDestrio + DataSet.FieldByName('destrio').AsFloat;
end;

procedure TQRDetalleInventarios.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  rCampo:= 0;
  rPrimera:= 0;
  rSegunda:= 0;
  rTercera:= 0;
  rDestrio:= 0;
end;

procedure TQRDetalleInventarios.qrbndSummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblcampo.Caption:= FormatFloat('#,##0', rCampo );
  qrlblprimera.Caption:= FormatFloat('#,##0', rPrimera );
  qrlblsegunda.Caption:= FormatFloat('#,##0', rSegunda );
  qrlbltercera.Caption:= FormatFloat('#,##0', rTercera );
  qrlbldestrio.Caption:= FormatFloat('#,##0', rDestrio );
end;

end.
