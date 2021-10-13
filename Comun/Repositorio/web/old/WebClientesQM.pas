unit WebClientesQM;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQMWebClientes = class(TQuickRep)
    QRBand1: TQRBand;
    fecha: TQRSysData;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    LEmpresa: TQRLabel;
    bndDetalle: TQRBand;
    QRExpr5: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr1: TQRExpr;
    QRLabel5: TQRLabel;
  private
  (*
    empresa, transporte, cliente: string;
    bEmpresa, bTransporte, bCliente: Boolean;
  *)
  public

  end;

var
  QMWebClientes: TQMWebClientes;

implementation

uses WebDM;

{$R *.DFM}

end.
