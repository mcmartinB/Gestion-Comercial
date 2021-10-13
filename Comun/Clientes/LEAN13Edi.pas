unit LEAN13Edi;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db,
  DBTables;
                             
type
  TQRLEan13Edi = class(TQuickRep)
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    cliente_ee: TQRDBText;
    envase_ee: TQRDBText;
    ean13_ee: TQRDBText;
    fecha_baja_ee: TQRDBText;
    descripcion_ee: TQRDBText;
    QRSysData2: TQRSysData;
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    empresa_ee: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel5: TQRLabel;
    QRBand2: TQRBand;
{    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);}
    procedure QRSysData2Print(sender: TObject; var Value: string);
    procedure QRLEan13BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure empresa_eePrint(sender: TObject; var Value: String);
    procedure cliente_eePrint(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLEan13Edi: TQRLEan13Edi;

implementation

uses CVariables, UDMBaseDatos, UDMAuxDB;

{$R *.DFM}

procedure TQRLEan13Edi.QRLEan13BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i].ClassType = TQRDBText then
      TQRDBText(Components[i]).DataSet := DataSet;
  end;
end;

procedure TQRLEan13Edi.QRSysData2Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLEan13Edi.empresa_eePrint(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + DesEmpresa( Value );
end;

procedure TQRLEan13Edi.cliente_eePrint(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + DesCliente( Value );
end;

end.
