unit URRemesa;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, UFManRemesas;

type
  TRRemesa = class(TQuickRep)
    QRBandaCabecera: TQRBand;
    lb1: TQRLabel;
    lbFecha: TQRLabel;
    qrGrupoRemesa: TQRGroup;
    lb2: TQRLabel;
    qrNumRemesa: TQRDBText;
    lb3: TQRLabel;
    qrCodCliente: TQRDBText;
    qrDesCliente: TQRDBText;
    lb4: TQRLabel;
    qrFechaVto: TQRDBText;
    lb5: TQRLabel;
    qrCodBanco: TQRDBText;
    qrDesBanco: TQRDBText;
    lb6: TQRLabel;
    qrDesMoneda: TQRDBText;
    lb7: TQRLabel;
    qrFechaDto: TQRDBText;
    lb8: TQRLabel;
    lb9: TQRLabel;
    lb10: TQRLabel;
    lb11: TQRLabel;
    lb12: TQRLabel;
    qs1: TQRShape;
    qrDetalleRemesa: TQRBand;
    qrCodFactura: TQRDBText;
    qrFecFactura: TQRDBText;
    qrImpCobrado: TQRDBText;
    lbDiferencia: TQRLabel;
    lb13: TQRLabel;
    qrNumFactura: TQRDBText;
    lbImpFactura: TQRLabel;
    qrPieTotales: TQRBand;
    qs2: TQRShape;
    lbTotalFactura: TQRLabel;
    lbTotalCobrado: TQRLabel;
    lbTotalDiferencia: TQRLabel;
    lb14: TQRLabel;
    qs3: TQRShape;
    lb15: TQRLabel;
    qrTotalRemesa: TQRDBText;
    lb16: TQRLabel;
    lbTotalCobrado2: TQRLabel;
    lb17: TQRLabel;
    lbDescuadre: TQRLabel;
    qrTotalRemesaEur: TQRDBText;
    qrTotalGastosEur: TQRDBText;
    lb18: TQRLabel;
    lb19: TQRLabel;
    qrTotalLiquidoEur: TQRDBText;
    lb20: TQRLabel;
    lb21: TQRLabel;
    login: TQRChildBand;
    qrlbl1: TQRLabel;
    qrm1: TQRMemo;
    procedure QRBandaCabeceraBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrDetalleRemesaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrGrupoRemesaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrDetalleRemesaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure qrPieTotalesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure loginBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    rTotalFactura, rTotalCobrado: real;

  public

  end;

var
  RRemesa: TRRemesa;

implementation


{$R *.DFM}

procedure TRRemesa.QRBandaCabeceraBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbFecha.Caption := FormatDatetime('dd/mm/yyyy', Now);
end;

procedure TRRemesa.qrDetalleRemesaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if DataSet.Fieldbyname('es_fac_comercial_rf').AsFloat = 0 then
  begin
    lbImpFactura.Caption := FormatFloat('#,##0.00', DataSet.FieldByName('importe_cobrado_rf').AsFloat);
    lbDiferencia.Caption := FormatFloat('#,##0.00', 0);
  end
  else
  begin
    lbImpFactura.Caption := FormatFloat('#,##0.00', DataSet.FieldByName('impFactura').AsFloat);
    lbDiferencia.Caption := FormatFloat('#,##0.00', DataSet.FieldByName('impFactura').AsFloat -
                                                    DataSet.FieldByName('importe_cobrado_rf').AsFloat);
  end;
end;

procedure TRRemesa.qrGrupoRemesaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rTotalFactura := 0;
  rTotalCobrado := 0;
end;

procedure TRRemesa.qrDetalleRemesaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  if DataSet.FieldByName('es_fac_comercial_rf').AsInteger = 0 then
    rTotalFactura := rTotalFactura + DataSet.FieldByName('importe_cobrado_rf').AsFloat
  else
    rTotalFactura := rTotalFactura + DataSet.FieldByName('impFactura').AsFloat;
  rTotalCobrado := rTotalCobrado + DataSet.FieldByName('importe_cobrado_rf').AsFloat;
end;

procedure TRRemesa.qrPieTotalesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbTotalFactura.Caption := FormatFloat('#,##0.00', rTotalFactura);
  lbTotalCobrado.Caption := FormatFloat('#,##0.00', rTotalCobrado);
  lbTotalDiferencia.Caption := FormatFloat('#,##0.00', rTotalFactura-rTotalCobrado);

  lbTotalCobrado2.Caption := FormatFloat('#,##0.00', rTotalCobrado);
  lbDescuadre.Caption :=  FormatFloat('#,##0.00', DataSet.FieldByName('importe_cobro_rc').AsFloat -
                                                  rTotalCobrado);
  lb21.Caption := DataSet.FieldByName('desMoneda').AsString;
end;

procedure TRRemesa.loginBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= Trim( DataSet.FieldByName('notas_rc').AsString ) <> '';
  if PrintBand then
    qrm1.Lines.Text:= DataSet.FieldByName('notas_rc').AsString;
end;

end.
