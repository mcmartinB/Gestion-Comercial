unit QLServiciosTransporteEntregas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLServiciosTransporteEntregas = class(TQuickRep)
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
    fecha: TQRDBText;
    marca: TQRExpr;
    qrltransitos: TQRLabel;
  private

  public

  end;

var
  QRLServiciosTransporteEntregas: TQRLServiciosTransporteEntregas;

implementation

{$R *.DFM}

end.
