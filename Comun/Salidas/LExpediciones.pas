unit LExpediciones;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls;
type
  TQRLExpediciones = class(TQuickRep)
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    fecha_sl: TQRDBText;
    descripcion_p: TQRDBText;
    kilos: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    LProducto: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    vehiculo_sc: TQRDBText;
    PsQRLabel1: TQRLabel;
    LMEmpresa: TQRMemo;
    PsQRLabel4: TQRLabel;
    LCentro: TQRLabel;
    LSemana: TQRLabel;
    LComunicado: TQRLabel;
    titulo: TQRMemo;
    sumario: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRLabel5: TQRLabel;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLExpedicionesBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure descripcion_pPrint(sender: TObject; var Value: string);
  private

  public
    LabelProducto, LabelCentro, LabelComunicado, LabelSemana: string;
  end;

var
  QRLExpediciones: TQRLExpediciones;

implementation

uses LFExpediciones, UDMAuxDB;

{$R *.DFM}

procedure TQRLExpediciones.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//     LProducto.Caption := LabelProducto;
end;

procedure TQRLExpediciones.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
{
     LSemana.Caption     := LabelSemana;
     LComunicado.Caption := LabelComunicado;
     LCentro.Caption     := LabelCentro;
}
end;

procedure TQRLExpediciones.QRLExpedicionesBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  LProducto.Caption := LabelProducto;
  LSemana.Caption := LabelSemana;
  LComunicado.Caption := LabelComunicado;
  LCentro.Caption := LabelCentro;
end;

procedure TQRLExpediciones.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
     // FLExpediciones.QListadosExpedicion2.Next;
end;

procedure TQRLExpediciones.descripcion_pPrint(sender: TObject;
  var Value: string);
begin
  Value := desPais(Value);
end;

end.
