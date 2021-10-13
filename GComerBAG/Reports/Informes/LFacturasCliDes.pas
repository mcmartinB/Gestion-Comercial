unit LFacturasCliDes;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLFacturasCliDes = class(TQuickRep)
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRGroup1: TQRGroup;
    QRPieGrupo: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    PsQRLabel9: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr8: TQRExpr;
    TitleBand1: TQRBand;
    PsQRLabel8: TQRLabel;
    lblClientes: TQRLabel;
    lblFechas: TQRLabel;
    PsQRSysData1: TQRSysData;
    PageHeaderBand1: TQRBand;
    QRSysData2: TQRSysData;
  private

  public

  end;

var
  QRLFacturasCliDes: TQRLFacturasCliDes;

implementation

uses LFFacturasCliente;

{$R *.DFM}

end.
