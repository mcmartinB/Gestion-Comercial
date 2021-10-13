unit LExpedicionesResumen;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls;
type
  TQRLExpedicionesResumen = class(TQuickRep)
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    descripcion_p: TQRDBText;
    kilos: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    LMEmpresa: TQRMemo;
    PsQRLabel4: TQRLabel;
    LCentro: TQRLabel;
    LSemana: TQRLabel;
    LComunicado: TQRLabel;
    titulo: TQRMemo;
    sumario: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRLabel5: TQRLabel;
    qtxtproducto: TQRDBText;
    qrgrpProducto: TQRGroup;
    qrbndPieProducto: TQRBand;
    qrxpr1: TQRExpr;
    qtxtproducto_sl: TQRDBText;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLExpedicionesBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure descripcion_pPrint(sender: TObject; var Value: string);
    procedure qtxtproductoPrint(sender: TObject; var Value: String);
    procedure qrgrpProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qtxtproducto_slPrint(sender: TObject; var Value: String);
  private

  public
    LabelProducto, LabelCentro, LabelComunicado, LabelSemana: string;
  end;

var
  QRLExpedicionesResumen: TQRLExpedicionesResumen;

implementation

uses LFExpediciones, UDMAuxDB;

{$R *.DFM}

procedure TQRLExpedicionesResumen.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//     LProducto.Caption := LabelProducto;
end;

procedure TQRLExpedicionesResumen.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
{
     LSemana.Caption     := LabelSemana;
     LComunicado.Caption := LabelComunicado;
     LCentro.Caption     := LabelCentro;
}
end;

procedure TQRLExpedicionesResumen.QRLExpedicionesBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  LSemana.Caption := LabelSemana;
  LComunicado.Caption := LabelComunicado;
  LCentro.Caption := LabelCentro;
end;

procedure TQRLExpedicionesResumen.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
     // FLExpediciones.QListadosExpedicion2.Next;
end;

procedure TQRLExpedicionesResumen.descripcion_pPrint(sender: TObject;
  var Value: string);
begin
  Value := desPais(Value);
end;

procedure TQRLExpedicionesResumen.qtxtproductoPrint(sender: TObject;
  var Value: String);
begin
  Value := desProducto(DataSet.FieldByName('empresa_sl').AsString,Value);
end;

procedure TQRLExpedicionesResumen.qrgrpProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrgrpProducto.Height:= 0;
end;

procedure TQRLExpedicionesResumen.qtxtproducto_slPrint(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + desProducto(DataSet.FieldByName('empresa_sl').AsString,Value);
end;

end.
