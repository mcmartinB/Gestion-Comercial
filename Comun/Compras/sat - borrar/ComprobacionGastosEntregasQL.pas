unit ComprobacionGastosEntregasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLComprobacionGastosEntregas = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    bndCabecera: TQRBand;
    DetailBand1: TQRBand;
    LAlbaran: TQRLabel;
    LFecha: TQRLabel;

    LVariable: TQRLabel;
    LTitulo: TQRLabel;
    DBAlbaran: TQRDBText;
    DBFecha: TQRDBText;
    DBVariable: TQRDBText;
    PsQRSysData1: TQRSysData;
    LPeriodo: TQRLabel;
    LCliente: TQRLabel;
    DBCliente: TQRDBText;
    LMatricula: TQRLabel;
    DBMatricula: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    lblTipoGastos: TQRLabel;
    lblCliente: TQRLabel;
  private

  public

  end;

var
  QLComprobacionGastosEntregas: TQLComprobacionGastosEntregas;

implementation

{$R *.DFM}

end.
