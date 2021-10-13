unit ResumenConsumosClienteQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLResumenConsumosCliente = class(TQuickRep)
    BandaDetalle: TQRBand;
    QRBand4: TQRBand;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    qrlblTitulo: TQRLabel;
    SummaryBand1: TQRBand;
    qrlbl5: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl3: TQRLabel;
    qrgrpEntrega: TQRGroup;
    qrbndPieEntrega: TQRBand;
    qrlbl20: TQRLabel;
    qrlbl22: TQRLabel;
    qrbnd1: TQRBand;
    qrsysdt1: TQRSysData;
    qrlbl21: TQRLabel;
    qrlbl17: TQRLabel;
    qrdbtxtpal_importe_descuento: TQRDBText;
    qrdbtxtpal_importe_compra: TQRDBText;
    qrdbtxtkilos_destrio: TQRDBText;
    qrdbtxtkilos_otros: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrxpr11: TQRExpr;
    qrxpr13: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrlbl7: TQRLabel;
    qrlbl18: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrlbl15: TQRLabel;
    qrxpr4: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrdbtxtproducto4: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrdbtxtproducto3: TQRDBText;
    qrdbtxtproducto2: TQRDBText;
    procedure qrdbtxtproducto2Print(sender: TObject; var Value: String);
    procedure qrdbtxtproducto4Print(sender: TObject; var Value: String);
    procedure qrdbtxtproducto3Print(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public

  end;

  procedure PrevisualizarResumenClientes( const AEmpresa: string );

implementation

{$R *.DFM}

uses ResumenConsumosDL, UDMAuxDB,  DPreview, CReportes;


procedure PrevisualizarResumenClientes( const AEmpresa: string );
var
  QLResumenConsumosCliente: TQLResumenConsumosCliente;
begin
  QLResumenConsumosCliente := TQLResumenConsumosCliente.Create(Application);
  PonLogoGrupoBonnysa(QLResumenConsumosCliente, AEmpresa);
  QLResumenConsumosCliente.sEmpresa:= AEmpresa;
  QLResumenConsumosCliente.qrlblTitulo.Caption:= 'RESUMEN CONSUMOS POR CLIENTE' + AEmpresa;
  QLResumenConsumosCliente.ReportTitle:= 'RESUMEN_CONSUMOS_CLIENTE_' + AEmpresa ;
  Preview(QLResumenConsumosCliente);
end;

(*
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;

  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
*)



procedure TQLResumenConsumosCliente.qrdbtxtproducto4Print(sender: TObject;
  var Value: String);
begin
  if Value = '' then
  begin
    Value:= 'SIN CLIENTE';
  end
  else
  if DataSet.FieldByName('transito').AsBoolean then
  begin
    Value:= desEmpresa( Value );
  end
  else
  begin
    Value:= desCliente( Value );
  end;

end;

procedure TQLResumenConsumosCliente.qrdbtxtproducto3Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( sEmpresa, Value );
end;

procedure TQLResumenConsumosCliente.qrdbtxtproducto2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL PRODUCTO [' + Value + '] ' + desProducto( sEmpresa, Value );
end;

end.

