unit InformePoseiQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRInformePosei = class(TQuickRep)
    cabecera: TQRBand;
    detalle: TQRBand;
    qrlblPeriodo: TQRLabel;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    qrReferencia: TQRDBText;
    qrFecha: TQRDBText;
    qrDuaSalida: TQRDBText;
    qrFechaFactura: TQRDBText;
    qrFechaLlegada: TQRDBText;
    qrKilosTrans: TQRDBText;
    qrDuaLlegada: TQRDBText;
    qrCodFactura: TQRDBText;
    qrKilosFac: TQRDBText;
    qrImpFactura: TQRDBText;
    QRDBText1: TQRDBText;
    qrProducto: TQRDBText;
    qrCentro: TQRDBText;
    qrEmpresa: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    procedure qrEmpresaPrint(sender: TObject; var Value: string);
    procedure qrCentroPrint(sender: TObject; var Value: string);
    procedure qrProductoPrint(sender: TObject; var Value: string);
    procedure QRLabel16Print(sender: TObject; var Value: string);
    procedure QRDBText2Print(sender: TObject; var Value: string);
  private

  public

  end;

implementation

uses UDMAuxDB, UDMCalculoPosei;

{$R *.DFM}

procedure TQRInformePosei.qrCentroPrint(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesCentro( DataSet.FieldByName('empresa_transito').AsString, Value );
end;

procedure TQRInformePosei.QRDBText2Print(sender: TObject; var Value: string);
begin
  if Value = 'N' then
    Value := 'INFORMATIVO'
  else
    Value := 'DEFINITIVO';

end;

procedure TQRInformePosei.qrEmpresaPrint(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesEmpresa( Value );
end;

procedure TQRInformePosei.QRLabel16Print(sender: TObject; var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= 'EMP'
  else
    Value:= 'EMPRESA';
end;

procedure TQRInformePosei.qrProductoPrint(sender: TObject;
  var Value: string);
begin
  Value := Value + ' - ' + desProducto('', Value);
end;


end.
