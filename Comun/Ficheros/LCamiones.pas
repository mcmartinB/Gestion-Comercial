unit LCamiones;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLCamiones = class(TQuickRep)
    QRBand1: TQRBand;
    fecha: TQRSysData;
    QRBand3: TQRBand;
    QRBand2: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    LCodigo: TQRLabel;
    LDescripcion: TQRLabel;
    LTara: TQRLabel;
    camion_c: TQRDBText;
    descripcion_c: TQRDBText;
    tara_c: TQRDBText;
    ChildBand2: TQRChildBand;
    QRDBText5: TQRDBText;
    QRLabel4: TQRLabel;
    procedure QRSysData2Print(sender: TObject; var Value: string);
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLTransportistasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

var
  QRLCamiones: TQRLCamiones;

implementation

uses CVariables, DB;

{$R *.DFM}

procedure TQRLCamiones.QRSysData2Print(sender: TObject;
  var Value: string);
begin
  Value := StrUpper(PChar(Value));
end;

procedure TQRLCamiones.QRSysData1Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLCamiones.QRLTransportistasBeforePrint(
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

procedure TQRLCamiones.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= DataSet.FieldByName('notas_t').AsString <> '';
end;

end.
