unit LAgrupaPrecalibrado;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TqrpAgrupaPrecalibrado = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRGroup1: TQRGroup;
    psImpresoEl: TQRSysData;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    PsQRDBText8: TQRDBText;
    PsQRDBText9: TQRDBText;
    PsQRDBText1: TQRDBText;
    PsQRDBText10: TQRDBText;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PageFooterBand1: TQRBand;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
  private

  public

  end;

implementation

{$R *.DFM}

uses UDMBaseDatos;

end.
