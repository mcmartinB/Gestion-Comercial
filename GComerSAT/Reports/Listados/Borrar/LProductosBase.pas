unit LProductosBase;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLProductosBase = class(TQuickRep)
    QRBand1: TQRBand;
    fecha: TQRSysData;
    QRBand3: TQRBand;
    LCodigo: TQRLabel;
    LDescripcion: TQRLabel;
    QRBand2: TQRBand;
    QRDBText2: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRGroup1: TQRGroup;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
  private

  public

  end;

implementation

{$R *.DFM}

uses UDMBaseDatos;

end.
