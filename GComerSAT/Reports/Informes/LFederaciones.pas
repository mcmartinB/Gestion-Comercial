unit LFederaciones;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLFederaciones = class(TQuickRep)
    cabecera: TQRBand;
    detalle: TQRBand;
    pie: TQRBand;
    descripcion_p: TQRDBText;
    kilos: TQRDBText;
    QRSysData1: TQRSysData;
    LPais: TQRLabel;
    LKilos: TQRLabel;
    PsQRShape2: TQRShape;
    PsQRShape1: TQRShape;
    PsQRShape3: TQRShape;
    PsQRShape4: TQRShape;
    QRBand1: TQRBand;
    total: TQRExpr;
    PsQRShape6: TQRShape;
    LTotal: TQRLabel;
    PsQRShape5: TQRShape;
    PsQRShape7: TQRShape;
    PsQRShape8: TQRShape;
    bultos: TQRDBText;
    totalBultos: TQRExpr;
    PsQRLabel1: TQRLabel;
    label1: TQRLabel;
    label2: TQRLabel;
    label3: TQRLabel;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    procedure cabeceraBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    provincia: string;
    fecha: string;
  end;

var
  QRLFederaciones: TQRLFederaciones;

implementation

uses LResumenFederaciones;

{$R *.DFM}

procedure TQRLFederaciones.cabeceraBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  label1.Caption := provincia;
  label2.Caption := fecha;
end;

end.
