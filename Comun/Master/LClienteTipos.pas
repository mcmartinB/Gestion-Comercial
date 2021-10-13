unit LClienteTipos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, TypInfo;

type
  TQRLClienteTipos = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    qrdbtxtcodigo_ctp: TQRDBText;
    qrdbtxtdescripcion_ctp: TQRDBText;
    QRSysData2: TQRSysData;
  private

  public

  end;

var
  QRLClienteTipos: TQRLClienteTipos;

implementation

uses CVariables, MClienteTipos, UDMAuxDB;

{$R *.DFM}

end.
