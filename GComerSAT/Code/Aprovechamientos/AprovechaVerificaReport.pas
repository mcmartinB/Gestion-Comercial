unit AprovechaVerificaReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRAprovechaVerifica = class(TQuickRep)
    DetailBand1: TQRBand;
    TitleBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData2: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    lblCentro: TQRLabel;
    lblProducto: TQRLabel;
    lblFecha: TQRLabel;
    qrlblCalidad: TQRLabel;
    qrdbtxtcalidad_ec: TQRDBText;
    QRDBTextProducto: TQRDBText;
    QRDBTextDescProducto: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    procedure lblCentro2Print(sender: TObject; var Value: string);
    procedure lblFecha2Print(sender: TObject; var Value: string);
    procedure lblProducto2Print(sender: TObject; var Value: string);
  private

  public

  end;

implementation

{$R *.DFM}

uses UDMBaseDatos, UDMAuxDB;

procedure TQRAprovechaVerifica.lblCentro2Print(sender: TObject;
  var Value: string);
begin
  Value := lblCentro.Caption;
end;

procedure TQRAprovechaVerifica.lblFecha2Print(sender: TObject;
  var Value: string);
begin
  Value := lblFecha.Caption;
end;

procedure TQRAprovechaVerifica.lblProducto2Print(sender: TObject;
  var Value: string);
begin
  Value := lblProducto.Caption;
end;

end.
