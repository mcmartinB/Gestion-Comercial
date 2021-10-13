unit QLRemesasBancoTotal;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, UDMBaseDatos, Qrctrls;
type
  TQRLRemesasBancoTotal = class(TQuickRep)
    TitleBand1: TQRBand;
    BandaPie: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    BandaBancosPie: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    QRSysData2: TQRSysData;
    BandaBancosCab: TQRBand;
    lPeriodo: TQRLabel;
    lBanco: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel3: TQRLabel;
    BandaBancos: TQRSubDetail;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    BandaMonedas: TQRSubDetail;
    BandaMonedasCab: TQRBand;
    BandaMonedasPie: TQRBand;
    PsQRDBText6: TQRDBText;
    descripcion_m: TQRDBText;
    PsQRDBText8: TQRDBText;
    PsQRDBText9: TQRDBText;
    PsQRDBText10: TQRDBText;
    PsQRLabel2: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRExpr5: TQRExpr;
  private

  public

  end;

var
  QRLRemesasBancoTotal: TQRLRemesasBancoTotal;

implementation

{$R *.DFM}

end.
