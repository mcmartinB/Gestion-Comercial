unit ResumenInventariosReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, grimgctrl;

type
  TQRResumenInventarios = class(TQuickRep)
    QRBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblFecha: TQRLabel;
    lblProducto: TQRLabel;
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
    qrdbtxtcampo: TQRDBText;
    qrdbtxtintermedia1: TQRDBText;
    qrdbtxtintermedia2: TQRDBText;
    qrdbtxttercera: TQRDBText;
    qrdbtxtdestrio: TQRDBText;
    qrdbtxtexpedicion_c1: TQRDBText;
    qrdbtxtexpedicion_c2: TQRDBText;
    qrbndSummaryBand1: TQRBand;
    qrlblcampo: TQRLabel;
    qrlblprimera: TQRLabel;
    qrlblsegunda: TQRLabel;
    qrlbltercera: TQRLabel;
    qrlbldestrio: TQRLabel;
    qrlblprimera_: TQRLabel;
    qrlblsegunda_: TQRLabel;
    qrlbl12: TQRLabel;
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
    procedure qrgrpCabBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrbndSummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    rCampo, rPrimera, rSegunda, rTercera, rDestrio, rPrimera_, rSegunda_ : real;
  public

  end;

procedure PrintResumenInventarios( const AOwner: TComponent;
                                 const AEmpresa, ACentro, AProducto: string;
                                 const AFechaIni: TDateTime; const iATipo: integer );

implementation

{$R *.DFM}

uses
  ResumenInventariosData, DPreview, CReportes, UDMAuxDB;

var
  QRResumenInventarios: TQRResumenInventarios;

procedure PrintResumenInventarios( const AOwner: TComponent;
                                 const AEmpresa, ACentro, AProducto: string;
                                 const AFechaIni: TDateTime; const iATipo: integer );
begin
  QRResumenInventarios:= TQRResumenInventarios.Create( AOwner );
  try
    PonLogoGrupoBonnysa(QRResumenInventarios, AEmpresa);
    if AProducto = '' then
      QRResumenInventarios.lblProducto.Caption:= 'TODOS LOS PRODUCTOS.'
    else
      QRResumenInventarios.lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto );
    QRResumenInventarios.lblFecha.Caption:= 'Del ' + DateToStr( AFechaIni ) ;
    Previsualiza( QRResumenInventarios );
  finally
    FreeAndNil( QRResumenInventarios );
  end;
end;

procedure TQRResumenInventarios.qrdbtxtproducto1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByName('empresa').AsString, value );
end;

procedure TQRResumenInventarios.qrgrpCabBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rCampo:= rCampo + DataSet.FieldByName('campo').AsFloat;
  rPrimera:= rPrimera + DataSet.FieldByName('intermedia1').AsFloat;
  rSegunda:= rSegunda + DataSet.FieldByName('intermedia2').AsFloat;
  rTercera:= rTercera + DataSet.FieldByName('tercera').AsFloat;
  rDestrio:= rDestrio + DataSet.FieldByName('destrio').AsFloat;
  rPrimera_:= rPrimera_ + DataSet.FieldByName('expedicion_c1').AsFloat;
  rSegunda_:= rSegunda_ + DataSet.FieldByName('expedicion_c2').AsFloat;
end;

procedure TQRResumenInventarios.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  rCampo:= 0;
  rPrimera:= 0;
  rSegunda:= 0;
  rTercera:= 0;
  rDestrio:= 0;
  rPrimera_:= 0;
  rSegunda_:= 0;
end;

procedure TQRResumenInventarios.qrbndSummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblcampo.Caption:= FormatFloat('#,##0', rCampo );
  qrlblprimera.Caption:= FormatFloat('#,##0', rPrimera );
  qrlblsegunda.Caption:= FormatFloat('#,##0', rSegunda );
  qrlbltercera.Caption:= FormatFloat('#,##0', rTercera );
  qrlbldestrio.Caption:= FormatFloat('#,##0', rDestrio );
  qrlblprimera_.Caption:= FormatFloat('#,##0', rPrimera_ );
  qrlblsegunda_.Caption:= FormatFloat('#,##0', rSegunda_ );
end;

end.
