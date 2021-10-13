unit PaisesQM;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQMPaises = class(TQuickRep)
    QRBand1: TQRBand;
    fecha: TQRSysData;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    bndDetalle: TQRBand;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr4: TQRExpr;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    procedure QRExpr7Print(sender: TObject; var Value: String);
    procedure QRExpr4Print(sender: TObject; var Value: String);

  private

  public

  end;

  procedure VisualizarListado( const AOwner: TComponent );

implementation

uses UDMAuxDB, PaisesDM;

{$R *.DFM}

var
  QMPaises: TQMPaises;

procedure VisualizarListado( const AOwner: TComponent );
begin
  QMPaises:= TQMPaises.Create( AOwner );
  try
    QMPaises.Preview;
  finally
    FreeAndNil(QMPaises);
  end;
end;

procedure TQMPaises.QRExpr7Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desMoneda( Value );
end;

procedure TQMPaises.QRExpr4Print(sender: TObject;
  var Value: String);
begin
  if Value = '1' then
    Value:= 'SI'
  else
    Value:= 'NO';
end;

end.
