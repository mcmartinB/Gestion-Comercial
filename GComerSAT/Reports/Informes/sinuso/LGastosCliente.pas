unit LGastosCliente;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLGastosCliente = class(TQuickRep)
    QRTitulo: TQRBand;
    PsQRLabel7: TQRLabel;
    lblCliente: TQRLabel;
    lblMoneda: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRGrupo: TQRBand;
    QRSub: TQRSubDetail;
    LAlbaran: TQRLabel;
    LFecha: TQRLabel;
    PsQRDBText1: TQRDBText;
    DBImporte: TQRDBText;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    DBAlbaran: TQRDBText;
    PsQRDBText4: TQRDBText;
    GroupFooterBand1: TQRBand;
    PsQRLabel5: TQRLabel;
    PsQRDBText3: TQRDBText;
    qrlblKilos: TQRLabel;
    qrlblPrecio: TQRLabel;
    qrdbtxtimporte: TQRDBText;
    qrxprPrecio: TQRExpr;
    qrbndSummaryBand1: TQRBand;
    qrlbl1: TQRLabel;
    qlKilos: TQRLabel;
    qlImporte: TQRLabel;
    qlPrecio: TQRLabel;
    qrlblKilost: TQRLabel;
    qrlblImporte: TQRLabel;
    qrlblPreciot: TQRLabel;
    qrlblCliente: TQRLabel;
    qrdbtxtCliente: TQRDBText;
    qrlblPais: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlblFactura: TQRLabel;
    qrlblFechaFac: TQRLabel;
    procedure DBAlbaranPrint(sender: TObject; var Value: string);
    procedure PsQRDBText4Print(sender: TObject; var Value: string);
    procedure LAlbaranPrint(sender: TObject; var Value: string);
    procedure LFechaPrint(sender: TObject; var Value: string);
    procedure QRLGastosClienteBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qlKilosPrint(sender: TObject; var Value: String);
    procedure qrlblKilostPrint(sender: TObject; var Value: String);
    procedure qlImportePrint(sender: TObject; var Value: String);
    procedure qrlblImportePrint(sender: TObject; var Value: String);
    procedure qlPrecioPrint(sender: TObject; var Value: String);
    procedure GroupFooterBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrlblPreciotPrint(sender: TObject; var Value: String);
    procedure QRSubBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlblClientePrint(sender: TObject; var Value: String);
    procedure qrdbtxtfacturaPrint(sender: TObject; var Value: String);
    procedure qrdbtxtfecha_facPrint(sender: TObject; var Value: String);
  private
    fech_aux, alb_aux: string;
    kilos, importe: real;
    kilost, importet: reaL;
  public
    bCliente: Boolean;
  end;

var
  QRLGastosCliente: TQRLGastosCliente;

implementation

{$R *.DFM}

procedure TQRLGastosCliente.DBAlbaranPrint(sender: TObject;
  var Value: string);
begin
  LAlbaran.Caption := Value;
  Value := '';
  alb_aux := '';
end;

procedure TQRLGastosCliente.PsQRDBText4Print(sender: TObject;
  var Value: string);
begin
  LFecha.Caption := Value;
  Value := '';
  fech_aux := '';
end;

procedure TQRLGastosCliente.LAlbaranPrint(sender: TObject;
  var Value: string);
begin
  if Value = alb_aux then
    Value := ''
  else
    alb_aux := Value;
end;

procedure TQRLGastosCliente.LFechaPrint(sender: TObject;
  var Value: string);
begin
  if Value = fech_aux then
    Value := ''
  else
    fech_aux := Value;
end;

procedure TQRLGastosCliente.QRLGastosClienteBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  kilos:= 0;
  importe:= 0;
  kilost:= 0;
  importet:= 0;
end;

procedure TQRLGastosCliente.qlKilosPrint(sender: TObject;
  var Value: String);
begin
  Value := FormatFLoat('#,##0.00', kilos);
end;

procedure TQRLGastosCliente.qrlblKilostPrint(sender: TObject;
  var Value: String);
begin
  Value := FormatFLoat('#,##0.00', kilost);
end;

procedure TQRLGastosCliente.qlImportePrint(sender: TObject;
  var Value: String);
begin
  Value := FormatFLoat('#,##0.00', importe);
end;

procedure TQRLGastosCliente.qrlblImportePrint(sender: TObject;
  var Value: String);
begin
  Value := FormatFLoat('#,##0.00', importet);
end;

procedure TQRLGastosCliente.qlPrecioPrint(sender: TObject;
  var Value: String);
begin
  if kilos <> 0 then
    Value:=  FormatFLoat('#,##0.000', importe/kilos)
  else
    Value:=  FormatFLoat('#,##0.000', 0);
end;

procedure TQRLGastosCliente.qrlblPreciotPrint(sender: TObject;
  var Value: String);
begin
  if kilost <> 0 then
    Value:=  FormatFLoat('#,##0.000', importet/kilost)
  else
    Value:=  FormatFLoat('#,##0.000', 0);
end;

procedure TQRLGastosCliente.GroupFooterBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  importe := 0;
  kilos := 0;
end;

procedure TQRLGastosCliente.QRSubBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  importe := importe + QRSub.DataSet.FieldByName('importe').AsFloat;
  importet := importet + QRSub.DataSet.FieldByName('importe').AsFloat;
  kilos := kilos + QRSub.DataSet.FieldByName('KILOS').AsFloat;
  kilosT := kilosT + QRSub.DataSet.FieldByName('KILOS').AsFloat;

  qrlblFechaFac.Caption:= FormatDateTime('dd/mm/yy', QRSub.DataSet.FieldByName('fecha_fac').AsDateTime );
  qrlblFactura.Caption:= QRSub.DataSet.FieldByName('factura').AsString;
end;

procedure TQRLGastosCliente.qrlblClientePrint(sender: TObject;
  var Value: String);
begin
  if bCliente then
    Value:= '';
end;

procedure TQRLGastosCliente.qrdbtxtfacturaPrint(sender: TObject;
  var Value: String);
begin
  if value = 'pp' then
    value:= 'Helo my friends';
end;

procedure TQRLGastosCliente.qrdbtxtfecha_facPrint(sender: TObject;
  var Value: String);
begin
  if value = 'pp' then
    value:= 'Helo my friends';
end;

end.
