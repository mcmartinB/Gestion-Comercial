unit LComprobacionGastosSalidasBAG;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLComprobacionGastosSalidasBAG = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    bndCabecera: TQRBand;
    DetailBand1: TQRBand;
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
    lblTipoTransito: TQRLabel;
    lblTipoGastos: TQRLabel;
    lblCliente: TQRLabel;
    qrdbtxtcodigo: TQRDBText;
    qrlbl1: TQRLabel;
  private

  public

  end;

var
  QRLComprobacionGastosSalidasBAG: TQRLComprobacionGastosSalidasBAG;

implementation

{$R *.DFM}

uses
  LFComprobacionGastosSalidasBAG;

end.
