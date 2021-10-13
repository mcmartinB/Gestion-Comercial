unit LCuentasVentaFacturaQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, db;

type
  TQLCuentasVentaFacturaQR = class(TQuickRep)
    bndCabecera: TQRBand;
    bndDetalle: TQRBand;
    bndCabFactura: TQRGroup;
    PsQRSysData1: TQRSysData;
    bndPieFactura: TQRBand;
    PsQRSysData2: TQRSysData;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr8: TQRExpr;
    PsQRShape2: TQRShape;
    PsQRExpr9: TQRExpr;
    PsQRExpr10: TQRExpr;
    PsQRExpr11: TQRExpr;
    PsQRExpr12: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr1: TQRExpr;
    ChildBand1: TQRChildBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PageFooterBand1: TQRBand;
    PsQRSysData3: TQRSysData;
    procedure PsQRExpr1Print(sender: TObject; var Value: string);
    procedure PsQRExpr2Print(sender: TObject; var Value: string);
    procedure PsQRExpr9Print(sender: TObject; var Value: string);
  private
  public
  end;

implementation

uses UDMAuxDB, UDMBaseDatos;

{$R *.DFM}

function Rellena(ACadena: string; ALong: integer; AChar: char = '0';
  ALeftToRight: Boolean = true): string;
begin
  if ALeftToRight then
    result := StringOfChar(AChar, ALong - length(ACadena)) + ACadena
  else
    result := ACadena + StringOfChar(AChar, ALong - length(ACadena));
end;

procedure TQLCuentasVentaFacturaQR.PsQRExpr1Print(sender: TObject;
  var Value: string);
begin
  Value := 'FACTURA: ' + Value;
end;

procedure TQLCuentasVentaFacturaQR.PsQRExpr2Print(sender: TObject;
  var Value: string);
begin
  Value := 'FECHA: ' + Value;
end;

procedure TQLCuentasVentaFacturaQR.PsQRExpr9Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTALES FACTURA ';
end;

end.
