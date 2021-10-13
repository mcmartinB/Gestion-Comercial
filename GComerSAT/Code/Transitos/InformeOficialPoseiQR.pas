unit InformeOficialPoseiQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRInformeOficialPosei = class(TQuickRep)
    detalle: TQRBand;
    QRBand1: TQRBand;
    qrshp1: TQRShape;
    qrFechaFactura: TQRDBText;
    QRLabel6: TQRLabel;
    qrCodFactura: TQRDBText;
    qrKilosFac: TQRDBText;
    qrImpFactura: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    qrProducto: TQRDBText;
    cabecera: TQRBand;
    qrlblPeriodo: TQRLabel;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    procedure qrEmpresaPrint(sender: TObject; var Value: string);
    procedure qrCentroPrint(sender: TObject; var Value: string);
    procedure qrProductoPrint(sender: TObject; var Value: string);
    procedure QRLabel16Print(sender: TObject; var Value: string);
    procedure QRDBText2Print(sender: TObject; var Value: string);
    procedure qrCodFacturaPrint(sender: TObject; var Value: string);
    procedure QRDBText6Print(sender: TObject; var Value: string);
    procedure QRDBText9Print(sender: TObject; var Value: string);
    procedure detalleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    function CompletaNIF (const APais, ANif: string ): string;
  public

  end;

implementation

uses UDMAuxDB, UDMCalculoPosei;

{$R *.DFM}

function TQRInformeOficialPosei.CompletaNIF(const APais, ANif: string): string;
begin
  if Pos( APais, ANif ) = 0 then
    Result:= APais + ANif
  else
    Result:= ANif;
end;

procedure TQRInformeOficialPosei.detalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if DataSet.FieldByName('importe').AsFloat = 0 then
    PrintBand := false
  else
    PrintBand := true;
end;

procedure TQRInformeOficialPosei.qrCentroPrint(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesCentro( DataSet.FieldByName('empresa_transito').AsString, Value );
end;

procedure TQRInformeOficialPosei.qrCodFacturaPrint(sender: TObject;
  var Value: string);
begin
  value:= Copy(DataSet.FieldByName('codigo_factura').AsString, 1, 3) +
          Copy(DataSet.FieldByName('codigo_factura').AsString, 8, 2) +
          Copy(DataSet.FieldByName('codigo_factura').AsString, 11, 5);
end;

procedure TQRInformeOficialPosei.QRDBText2Print(sender: TObject; var Value: string);
begin
  if Value = 'N' then
    Value := 'INFORMATIVO'
  else
    Value := 'DEFINITIVO';

end;

procedure TQRInformeOficialPosei.QRDBText6Print(sender: TObject;
  var Value: string);
begin
  Value := StringReplace(Value, '-', '', [rfReplaceAll, rfIgnoreCase]);
  if Trim(DataSet.FieldByName('codigo_pais').AsString) = 'ES' then
  begin
    if Value[1] in ['0'..'9'] then
      Value := '0' + Value;
  end
  else
  begin
//    Value := CompletaNIF( DataSet.FieldByName('codigo_pais').AsString, Value );
    Value := '';
  end;


end;

procedure TQRInformeOficialPosei.QRDBText9Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('codigo_pais').AsString <> 'ES' then
    Value := '';
end;

procedure TQRInformeOficialPosei.qrEmpresaPrint(sender: TObject; var Value: string);
begin
  Value := Value + ' - ' + DesEmpresa( Value );
end;

procedure TQRInformeOficialPosei.QRLabel16Print(sender: TObject; var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= 'EMP'
  else
    Value:= 'EMPRESA';
end;

procedure TQRInformeOficialPosei.qrProductoPrint(sender: TObject;
  var Value: string);
begin
  Value := Value + ' - ' + desProducto('', Value);
end;


end.
