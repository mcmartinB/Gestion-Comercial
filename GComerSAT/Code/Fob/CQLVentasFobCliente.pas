unit CQLVentasFobCliente;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLVentasFobCliente = class(TQuickRep)
    BandaDetalle: TQRBand;
    QRBand4: TQRBand;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    PsQRLabel15: TQRLabel;
    PsQRLabel16: TQRLabel;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    LPeriodoFacturas: TQRLabel;
    PsQRLabel25: TQRLabel;
    LCategoria: TQRLabel;
    qrlOrigen: TQRLabel;
    qrlDestino: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrx3: TQRExpr;
    qrx5: TQRExpr;
    qrx6: TQRExpr;
    qrx7: TQRExpr;
    qrx9: TQRExpr;
    qrl6: TQRLabel;
    qrx15: TQRExpr;
    qrx19: TQRExpr;
    SummaryBand1: TQRBand;
    qrlPsQRLabel5: TQRLabel;
    qrx10: TQRExpr;
    qrx11: TQRExpr;
    qrx12: TQRExpr;
    qrx16: TQRExpr;
    qrx13: TQRExpr;
    lblGastos: TQRLabel;
    qrx20: TQRExpr;
    qrl8: TQRLabel;
    qrgProducto: TQRGroup;
    qrxProducto: TQRExpr;
    qrxDesProducto: TQRExpr;
    bndPieProducto: TQRBand;
    qrl1: TQRLabel;
    qrx1: TQRExpr;
    qrx2: TQRExpr;
    qrx4: TQRExpr;
    qrx8: TQRExpr;
    qrx18: TQRExpr;
    qrgCategoria: TQRGroup;
    bndPieCategoria: TQRBand;
    qrl4: TQRLabel;
    qrx21: TQRExpr;
    qrx22: TQRExpr;
    qrx23: TQRExpr;
    qrx24: TQRExpr;
    qrx25: TQRExpr;
    LPeriodo: TQRLabel;
    qrx17: TQRExpr;
    qrl7: TQRLabel;
    qrx26: TQRExpr;
    qrx27: TQRExpr;
    qrx28: TQRExpr;
    qrl9: TQRLabel;
    qrl10: TQRLabel;
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrx19Print(sender: TObject; var Value: String);
    procedure qrxDesProductoPrint(sender: TObject; var Value: String);
    procedure qrl1Print(sender: TObject; var Value: String);
    procedure qrl4Print(sender: TObject; var Value: String);
  private

  public
    sEmpresa: string;
    bDescuentos, bGasto, bEnvase: boolean;

  end;


implementation

{$R *.DFM}

uses bMath, UDMAuxDB, Dialogs;

procedure TQLVentasFobCliente.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  bFlag: boolean;
begin
  PrintBand:= ( bDescuentos or bGasto or bEnvase ) and not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  lblGastos.Caption:= 'NOTA: Los gastos incluyen -> ';
  bFlag:= false;
  if bGasto then
  begin
    lblGastos.Caption:= lblGastos.Caption + 'gastos de albarán';
    bFlag:= True;
  end;
  if bEnvase then
  begin
    if bFlag then
    begin
      lblGastos.Caption:= lblGastos.Caption + ' + ';
    end;
    lblGastos.Caption:= lblGastos.Caption + 'costes de envasado';
  end;
  if bDescuentos then
  begin
    lblGastos.Caption:= lblGastos.Caption + '.' + #13 + #10 + ' Los descuentos/comisiones estan incluidos en el importe bruto.';
  end;
end;

procedure TQLVentasFobCliente.qrx19Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( Value );
end;

procedure TQLVentasFobCliente.qrxDesProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( sEmpresa, Value );
end;

procedure TQLVentasFobCliente.qrl1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL PRODUCTO ' +  DataSet.fieldByName('producto').AsString + ' ' +
          desProducto( sEmpresa, DataSet.fieldByName('producto').AsString );
end;

procedure TQLVentasFobCliente.qrl4Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL CATEGORIA ' +  DataSet.fieldByName('categoria').AsString +  ' ' +
          DataSet.fieldByName('producto').AsString;
end;

end.

