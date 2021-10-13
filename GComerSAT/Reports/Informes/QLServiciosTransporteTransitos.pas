unit QLServiciosTransporteTransitos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLServiciosTransporteTransitos = class(TQuickRep)
    cabecera: TQRBand;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    lblFecha: TQRLabel;
    lblCentro: TQRLabel;
    SummaryBand1: TQRBand;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    ColumnHeaderBand1: TQRBand;
    lblAgrupa: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    lblMatricula: TQRLabel;
    QRLabel6: TQRLabel;
    lblProducto: TQRLabel;
    lblPortes: TQRLabel;
    lblDestino: TQRLabel;
    detalle: TQRBand;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr5: TQRExpr;
    qrltransitos: TQRLabel;
    qrlblImporte: TQRLabel;
    qrlbl1: TQRLabel;
    qrxpr2: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr3: TQRExpr;
    qrlbl2: TQRLabel;
    qrxprmarca: TQRExpr;
    qrxpr4: TQRExpr;
    procedure qrlbl2Print(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLServiciosTransporteTransitos: TQRLServiciosTransporteTransitos;

implementation

{$R *.DFM}

procedure TQRLServiciosTransporteTransitos.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  if Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) then
  begin
    Value:= 'Transporte';
  end
  else
  begin
    Value:= '';
  end;
end;

end.
