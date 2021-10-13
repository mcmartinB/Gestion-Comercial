unit ExistenciasLameQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRExistenciasLame = class(TQuickRep)
    cabecera: TQRBand;
    detalle: TQRBand;
    pie: TQRBand;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    qrlblPeriodo: TQRLabel;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    qrEntrada: TQRDBText;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrshp1: TQRShape;
    qrFecha: TQRDBText;
    qrReferencia: TQRDBText;
    qrDua: TQRDBText;
    qrProducto: TQRDBText;
    QRLabel6: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    qrlbl1: TQRLabel;
    qrlCentro: TQRLabel;
    qrEmpresa: TQRDBText;
    QRLabel2: TQRLabel;
    qrCentro: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    procedure qrEmpresaPrint(sender: TObject; var Value: string);
    procedure qrCentroPrint(sender: TObject; var Value: string);
    procedure qrProductoPrint(sender: TObject; var Value: string);
  private

  public

  end;

implementation

uses UDMAuxDB;

{$R *.DFM}

procedure TQRExistenciasLame.qrCentroPrint(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesCentro( DataSet.FieldByName('empresa_dac').AsString, Value );
end;

procedure TQRExistenciasLame.qrEmpresaPrint(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesEmpresa( Value );
end;

procedure TQRExistenciasLame.qrProductoPrint(sender: TObject;
  var Value: string);
begin
  Value := Value + ' - ' + desProducto('', Value);
end;

end.
