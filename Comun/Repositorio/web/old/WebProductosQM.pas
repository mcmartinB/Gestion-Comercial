unit WebProductosQM;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQMWebProductos = class(TQuickRep)
    QRBand1: TQRBand;
    fecha: TQRSysData;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    LEmpresa: TQRLabel;
    bndDetalle: TQRBand;
    QRExpr5: TQRExpr;
    QRLabel1: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr1: TQRExpr;
    QRLabel2: TQRLabel;
  private
    (*
    empresa, transporte, cliente: string;
    bEmpresa, bTransporte, bCliente: Boolean;
    *)
  public

  end;

var
  QMWebProductos: TQMWebProductos;

implementation

uses WebDM;

{$R *.DFM}

end.
