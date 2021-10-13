unit LFormaPago;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, TypInfo;

type
  TQRLFormaPago = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRSysData2: TQRSysData;
    ChildBand1: TQRChildBand;
    ChildBand2: TQRChildBand;
    ChildBand3: TQRChildBand;
    ChildBand4: TQRChildBand;
    ChildBand5: TQRChildBand;
    bndcChildBand6: TQRChildBand;
    PsQRDBText5: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel3: TQRLabel;
    qrdbtxtbanco_fp: TQRDBText;
    qrlbl2: TQRLabel;
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSysData2Print(sender: TObject; var Value: string);
    procedure QRLFormaPagoBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure banco_fpPrint(sender: TObject; var Value: String);
    procedure bndcChildBand6BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

var
  QRLFormaPago: TQRLFormaPago;

implementation

uses CVariables, MFormasPago, UDMAuxDB;

{$R *.DFM}

procedure TQRLFormaPago.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := DataSet.FieldByName('descripcion_fp').AsString <> ''
end;

procedure TQRLFormaPago.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := DataSet.FieldByName('descripcion2_fp').AsString <> ''
end;

procedure TQRLFormaPago.ChildBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := DataSet.FieldByName('descripcion3_fp').AsString <> ''
end;

procedure TQRLFormaPago.ChildBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := DataSet.FieldByName('descripcion4_fp').AsString <> ''
end;

procedure TQRLFormaPago.ChildBand5BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := DataSet.FieldByName('descripcion5_fp').AsString <> ''
end;

procedure TQRLFormaPago.bndcChildBand6BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := DataSet.FieldByName('descripcion6_fp').AsString <> ''
end;

procedure TQRLFormaPago.QRSysData2Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLFormaPago.QRLFormaPagoBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  i: integer;
begin
  for i := 0 to self.ComponentCount - 1 do
  begin
    if self.Components[i] is TQRDBText then
    begin
      TQRDBText(self.Components[i]).DataSet := DataSet;
    end;
  end;
end;

procedure TQRLFormaPago.banco_fpPrint(sender: TObject; var Value: String);
begin
  Value:= Value  +  ' ' + DesBanco( Value );

end;

end.
