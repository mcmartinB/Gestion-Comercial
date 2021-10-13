unit LFacturasCliSem;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLFacturasCliSem = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    QRGroup1: TQRGroup;
    PsQRLabel1: TQRLabel;
    QRPieGrupo: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    SummaryBand1: TQRBand;
    PsQRLabel8: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr8: TQRExpr;
    PageHeaderBand1: TQRBand;
    QRSysData2: TQRSysData;
    lblClientes: TQRLabel;
    lblFechas: TQRLabel;
    PsQRSysData1: TQRSysData;
  private

  public

  end;

var
  QRLFacturasCliSem: TQRLFacturasCliSem;

implementation

uses LFFacturasCliente;

{$R *.DFM}

end.
