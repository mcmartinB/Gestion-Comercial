unit ArticuloDesgloseSalQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRArticuloDesgloseSal = class(TQuickRep)
    cabecera: TQRBand;
    detalle: TQRBand;
    qrlblPeriodo: TQRLabel;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    qrEmpresa: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel10: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    procedure qrEmpresaPrint(sender: TObject; var Value: string);
    procedure qrCentroPrint(sender: TObject; var Value: string);
    procedure qrProductoPrint(sender: TObject; var Value: string);
    procedure QRLabel16Print(sender: TObject; var Value: string);
  private

  public

  end;

implementation

uses UDMAuxDB, ArticuloDesgloseSal;

{$R *.DFM}

procedure TQRArticuloDesgloseSal.qrCentroPrint(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesCentro( DataSet.FieldByName('empresa_transito').AsString, Value );
end;

procedure TQRArticuloDesgloseSal.qrEmpresaPrint(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesEmpresa( Value );
end;

procedure TQRArticuloDesgloseSal.QRLabel16Print(sender: TObject; var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= 'EMP'
  else
    Value:= 'EMPRESA';
end;

procedure TQRArticuloDesgloseSal.qrProductoPrint(sender: TObject;
  var Value: string);
begin
  Value := Value + ' - ' + desProducto('', Value);
end;


end.
