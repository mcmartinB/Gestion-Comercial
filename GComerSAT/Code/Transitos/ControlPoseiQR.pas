unit ControlPoseiQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRControlPosei = class(TQuickRep)
    cabecera: TQRBand;
    detalle: TQRBand;
    QRBand1: TQRBand;
    qrlblPeriodo: TQRLabel;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    qrReferencia: TQRDBText;
    qrshp1: TQRShape;
    qrFecha: TQRDBText;
    qrKilosTrans: TQRDBText;
    qrKilosFac: TQRDBText;
    qrProducto: TQRDBText;
    qrCentro: TQRDBText;
    qrEmpresa: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel6: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRExpr3: TQRExpr;
    QRSysData1: TQRSysData;
    procedure qrEmpresaPrint(sender: TObject; var Value: string);
    procedure qrCentroPrint(sender: TObject; var Value: string);
    procedure qrProductoPrint(sender: TObject; var Value: string);
    procedure QRLabel16Print(sender: TObject; var Value: string);
  private

  public

  end;

implementation

uses UDMAuxDB, UDMCalculoPosei;

{$R *.DFM}

procedure TQRControlPosei.qrCentroPrint(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesCentro( DataSet.FieldByName('empresa_transito').AsString, Value );
end;

procedure TQRControlPosei.qrEmpresaPrint(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesEmpresa( Value );
end;

procedure TQRControlPosei.QRLabel16Print(sender: TObject; var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= 'EMP'
  else
    Value:= 'EMPRESA';
end;

procedure TQRControlPosei.qrProductoPrint(sender: TObject;
  var Value: string);
begin
  Value := Value + ' - ' + desProducto('', Value);
end;


end.
