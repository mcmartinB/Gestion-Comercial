unit AlbaranAPedidoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLAlbaranAPedido = class(TQuickRep)
    bndCabInforme: TQRBand;
    bndInforme: TQRBand;
    qrmInforme: TQRMemo;
    qrsysdtImpresoEl: TQRSysData;
    qrlTitulo: TQRLabel;
  private

  public

  end;

var
  QLAlbaranAPedido: TQLAlbaranAPedido;

implementation

{$R *.DFM}

end.
