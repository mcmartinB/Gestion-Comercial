unit LTransportistas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLTransportistas = class(TQuickRep)
    QRBand1: TQRBand;
    fecha: TQRSysData;
    QRBand3: TQRBand;
    QRBand2: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    LCodigo: TQRLabel;
    LDescripcion: TQRLabel;
    transporte_t: TQRDBText;
    descripcion_t: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel3: TQRLabel;
    qrdbtxtcif_t: TQRDBText;
    ChildBand1: TQRChildBand;
    QRDBText4: TQRDBText;
    ChildBand2: TQRChildBand;
    QRDBText5: TQRDBText;
    QRLabel4: TQRLabel;
    qrdbtxtfax_t: TQRDBText;
    qrlbl1: TQRLabel;
    procedure QRSysData2Print(sender: TObject; var Value: string);
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLTransportistasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

var
  QRLTransportistas: TQRLTransportistas;

implementation

uses CVariables, DB;

{$R *.DFM}

procedure TQRLTransportistas.QRSysData2Print(sender: TObject;
  var Value: string);
begin
  Value := StrUpper(PChar(Value));
end;

procedure TQRLTransportistas.QRSysData1Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLTransportistas.QRLTransportistasBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TQRDBText then
    begin
      TQRDBText(Components[i]).DataSet := DataSet;
    end;
  end;
end;

procedure TQRLTransportistas.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= ( DataSet.FieldByName('direccion2_t').AsString <> '' ) or
              ( DataSet.FieldByName('fax_t').AsString <> '' );
  if PrintBand then
  begin
    if DataSet.FieldByName('fax_t').AsString <> '' then
    begin
      qrdbtxtfax_t.Caption:= 'Fax'
    end
    else
    begin
      qrdbtxtfax_t.Caption:= '';
    end;
  end;
end;

procedure TQRLTransportistas.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= DataSet.FieldByName('notas_t').AsString <> '';
end;

end.
