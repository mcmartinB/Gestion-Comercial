unit DiasCobroQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLDiasCobro = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRSysData1: TQRSysData;
    lblTitulo: TQRLabel;
    PsQRLabel12: TQRLabel;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    lblPeriodo: TQRLabel;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl4: TQRLabel;
    qrl6: TQRLabel;
    qrdbtxtcta_cliente_c: TQRDBText;
    qrdbtxtdes_cliente: TQRDBText;
    qrdbtxtcta_cliente: TQRDBText;
    lblCliente: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
  private

  public

  end;

var
  QLDiasCobro: TQLDiasCobro;

implementation

uses DiasCobroFL;

{$R *.DFM}

//******************************  REPORT  **************************************

end.
