unit ReclamacionesQM;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQMReclamaciones = class(TQuickRep)
    QRBand1: TQRBand;
    fecha: TQRSysData;
    QRSysData2: TQRSysData;
    ChildBand1: TQRChildBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    ChildBand2: TQRChildBand;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    ChildBand3: TQRChildBand;
    QRDBText9: TQRDBText;
    ChildBand4: TQRChildBand;
    ChildBand5: TQRChildBand;
    ChildBand6: TQRChildBand;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText18: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    QRLabel3: TQRLabel;
    QRShape2: TQRShape;
    QRLabel4: TQRLabel;
    QRShape3: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRDBText20: TQRDBText;
    QRDBText21: TQRDBText;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRLabel25: TQRLabel;
    QRLabel27: TQRLabel;
    QRDBText22: TQRDBText;
    QRLabel28: TQRLabel;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRLabel31: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText19: TQRDBText;
    QRLabel23: TQRLabel;
    QRDBText25: TQRDBText;
    QRLabel26: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    lblEmpresa: TQRLabel;
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure QRDBText7Print(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure QRLabel26Print(sender: TObject; var Value: String);
  private
    sUnidad: String;
  public

  end;

var
  QMReclamaciones: TQMReclamaciones;

implementation

uses UDMAuxDB, WEBDM;

{$R *.DFM}

procedure TQMReclamaciones.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + '%';
end;

procedure TQMReclamaciones.QRDBText7Print(sender: TObject;
  var Value: String);
begin
  if UpperCase(Value) = 'K' then
    Value:= 'Kilos'
  else
  if UpperCase(Value) = 'C' then
    Value:= 'Cajas'
  else
  if UpperCase(Value) = 'U' then
    Value:= 'Unidades';
  sUnidad:= Value;
end;

procedure TQMReclamaciones.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + DMWEB.DesCliente( Value );
end;

procedure TQMReclamaciones.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + DMWEB.DesProducto( Value );
end;

procedure TQMReclamaciones.QRLabel26Print(sender: TObject;
  var Value: String);
begin
  Value:= sUnidad;
end;

end.
