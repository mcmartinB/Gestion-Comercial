unit QLServiciosTransporteSalidas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLServiciosTransporteSalidas = class(TQuickRep)
    cabecera: TQRBand;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    lblFecha: TQRLabel;
    lblCentro: TQRLabel;
    SummaryBand1: TQRBand;
    qrxservicios1: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    ColumnHeaderBand1: TQRBand;
    lblAgrupa: TQRLabel;
    QRLabel2: TQRLabel;
    qrlservicios: TQRLabel;
    lblMatricula: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    lblProducto: TQRLabel;
    lblPortes: TQRLabel;
    lblDestino: TQRLabel;
    detalle: TQRBand;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr9: TQRExpr;
    qrxservicios: TQRExpr;
    QRExpr1: TQRExpr;
    QRExpr5: TQRExpr;
    marca: TQRExpr;
    qrltransitos: TQRLabel;
    qrx1: TQRExpr;
    qrlCodPostal: TQRLabel;
    qrxPais: TQRExpr;
    qrxCliente: TQRExpr;
    qrlCliente: TQRLabel;
  private

  public

  end;

var
  QRLServiciosTransporteSalidas: TQRLServiciosTransporteSalidas;

implementation

{$R *.DFM}

end.
