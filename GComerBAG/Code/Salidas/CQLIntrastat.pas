unit CQLIntrastat;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLIntrastat = class(TQuickRep)
    QRGroup1: TQRGroup;
    BandaDetalle: TQRBand;
    QRBand4: TQRBand;
    PsQRLabel12: TQRLabel;
    PsQRLabel13: TQRLabel;
    lblGastosEtiqueta: TQRLabel;
    PsQRLabel15: TQRLabel;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    LPeriodo: TQRLabel;
    lblTitulo: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    qrl1: TQRLabel;
    qrx1: TQRExpr;
    qrx2: TQRExpr;
    qrx3: TQRExpr;
    QRExpr1: TQRExpr;
    QRLabel1: TQRLabel;
    QRBandCabProducto: TQRGroup;
    QRBandPieProducto: TQRBand;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRShape1: TQRShape;
    procedure qrx3Print(sender: TObject; var Value: String);
    procedure qrx1Print(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure qrx2Print(sender: TObject; var Value: String);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public
    sEmpresa: string;

  end;


implementation

{$R *.DFM}

uses CDMTablaFOB, bMath, UDMAuxDB;

procedure TQLIntrastat.qrx1Print(sender: TObject; var Value: String);
begin
  Value:= desProvincia( Value );
end;

procedure TQLIntrastat.qrx3Print(sender: TObject; var Value: String);
begin
  if Value = 'S' then
    Value:= 'COMUNITARIO'
  else
    Value:= 'EXTRACOMUNITARIO'
end;


procedure TQLIntrastat.QRExpr2Print(sender: TObject; var Value: String);
begin
  Value:= desPais( Value );
end;

procedure TQLIntrastat.qrx2Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desProducto( sEmpresa, Value );
end;

procedure TQLIntrastat.QRExpr1Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desEnvaseP( sEmpresa, Value, DataSet.FieldByname('producto').AsString );
end;

procedure TQLIntrastat.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRBandCabProducto.Height:= 0;
end;

end.
