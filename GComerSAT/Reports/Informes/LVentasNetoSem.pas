unit LVentasNetoSem;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLVentasSem = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PsQRDBText1: TQRDBText;
    eKilos2: TQRDBText;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    lTotal: TQRLabel;
    PsQRLabel4: TQRLabel;
    SummaryBand1: TQRBand;
    PsQRLabel5: TQRLabel;
    sKilos: TQRExpr;
    sTotal: TQRExpr;
    lblCliente: TQRLabel;
    lblPeriodo: TQRLabel;
    PsQRSysData2: TQRSysData;
    lKilos2: TQRLabel;
    lTotal2: TQRLabel;
    eKilos: TQRDBText;
    bandEnvase: TQRChildBand;
    sTotal2: TQRExpr;
    sKilos2: TQRExpr;
    bandCompare: TQRChildBand;
    lblAnterior: TQRLabel;
    lblActual: TQRLabel;
    lblEnvase: TQRLabel;
    eTotal2: TQRExpr;
    eTotal: TQRExpr;
    lblMoneda: TQRLabel;
    lblCategoria: TQRLabel;
    QRBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRSysData1: TQRSysData;
    procedure PsQRLabel4Print(sender: TObject; var Value: string);
    procedure QRLVentasSemBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure eTotalPrint(sender: TObject; var Value: string);
    procedure eTotal2Print(sender: TObject; var Value: string);
    procedure bandEnvaseBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    producto, envase: string;
    bCompare: Boolean;
  end;

var
  QRLVentasSem: TQRLVentasSem;

implementation

uses LFVentasNetoSem;

{$R *.DFM}

procedure TQRLVentasSem.PsQRLabel4Print(sender: TObject;
  var Value: string);
begin
  if producto <> '' then
    Value := value + ' [' + producto + ']';
end;

procedure TQRLVentasSem.QRLVentasSemBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  if not bCompare then
  begin
    eKilos.DataField := eKilos2.DataField;
    eTotal.Expression := eTotal2.Expression;
    sKilos.Expression := sKilos2.Expression;
    sTotal.Expression := sTotal2.Expression;

    lKilos2.Enabled := false;
    lTotal2.Enabled := false;
    sKilos2.Enabled := false;
    sTotal2.Enabled := false;
    eKilos2.Enabled := false;
    eTotal2.Enabled := false;

    bandCompare.Enabled := false;
  end;
end;

procedure TQRLVentasSem.eTotalPrint(sender: TObject; var Value: string);
begin
  if DataSet.FieldByName(eKilos.DataField).AsFloat = 0 then Value := '0,00';
end;

procedure TQRLVentasSem.eTotal2Print(sender: TObject; var Value: string);
begin
  if DataSet.FieldByName(eKilos2.DataField).AsFloat = 0 then Value := '0,00';
end;

procedure TQRLVentasSem.bandEnvaseBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := envase <> '';
end;

end.
