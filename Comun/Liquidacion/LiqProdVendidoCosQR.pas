unit LiqProdVendidoCosQR;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, grimgctrl;
type
  TQRLiqProdVendidoCos = class(TQuickRep)
    PageFooterBand1: TQRBand;
    qrbndBandaDetalle: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
    qtxtempresa_liq: TQRDBText;
    qtxtproducto_ent: TQRDBText;
    qrlblperiodo: TQRLabel;
    qtxtkilos_pri: TQRDBText;
    qtxtkilos_ter: TQRDBText;
    qtxtkilos_des: TQRDBText;
    qtxtkilos_mer: TQRDBText;
    qrgrpCosechero: TQRGroup;
    qtxtcosechero1: TQRDBText;
    qtxtcosechero2: TQRDBText;
    qtxtgastos_fac_liq: TQRDBText;
    qtxtdescuentos_fac_liq: TQRDBText;
    qtxtimporte_liq: TQRDBText;
    qtxtkilos_liq: TQRDBText;
    qtxtgastos_fac_liq1: TQRDBText;
    qtxtkilos_ent: TQRDBText;
    qtxtcostes_sec_transito_liq: TQRDBText;
    qrbnd1: TQRBand;
    qrxpr1: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrshp1: TQRShape;
    qrgrpCentro: TQRGroup;
    qrlbl1: TQRLabel;
    qtxtcentro_ent: TQRDBText;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl36: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qtxtcostes_financiero_liq: TQRDBText;
    qrxpr2: TQRExpr;
    qtxtcostes_financiero_liq1: TQRDBText;
    qrlbl10: TQRLabel;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrxpr20: TQRExpr;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrxpr25: TQRExpr;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrshp2: TQRShape;
    qrgrpFacturadoCab: TQRGroup;
    qrbndFacturadoPie: TQRBand;
    qrshp3: TQRShape;
    qrxpr38: TQRExpr;
    qrxpr39: TQRExpr;
    qrxpr40: TQRExpr;
    qrxpr41: TQRExpr;
    qrxpr42: TQRExpr;
    qrxpr43: TQRExpr;
    qrxpr44: TQRExpr;
    qrxpr45: TQRExpr;
    qrxpr46: TQRExpr;
    qrxpr47: TQRExpr;
    qrxpr48: TQRExpr;
    qrxpr49: TQRExpr;
    qrbndPieCosechero: TQRBand;
    qrshp5: TQRShape;
    qrxpr74: TQRExpr;
    qrxpr75: TQRExpr;
    qrxpr76: TQRExpr;
    qrxpr77: TQRExpr;
    qrxpr78: TQRExpr;
    qrxpr79: TQRExpr;
    qrxpr80: TQRExpr;
    qrxpr81: TQRExpr;
    qrxpr82: TQRExpr;
    qrxpr83: TQRExpr;
    qrxpr84: TQRExpr;
    qrxpr85: TQRExpr;
    qtxtfacturado: TQRDBText;
    qrlbl17: TQRLabel;
    qtxtcosechero_ent: TQRDBText;
    qrxpr50: TQRExpr;
    qrxpr51: TQRExpr;
    qrxpr52: TQRExpr;
    qrxpr53: TQRExpr;
    qrxpr54: TQRExpr;
    qrxpr55: TQRExpr;
    qrxpr56: TQRExpr;
    qrxpr57: TQRExpr;
    qrxpr58: TQRExpr;
    qrxpr59: TQRExpr;
    qrxpr60: TQRExpr;
    qrxpr61: TQRExpr;
    procedure qtxtempresa_liqPrint(sender: TObject; var Value: String);
    procedure qtxtproducto_entPrint(sender: TObject; var Value: String);
    procedure qtxtcosechero2Print(sender: TObject; var Value: String);
    procedure qtxtcosechero1Print(sender: TObject; var Value: String);
    procedure qtxtcentro_entPrint(sender: TObject; var Value: String);
    procedure qrgrpFacturadoCabBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qtxtkilos_merPrint(sender: TObject; var Value: String);
    procedure qtxtfacturadoPrint(sender: TObject; var Value: String);
    procedure qtxtcosechero_entPrint(sender: TObject; var Value: String);
  private

  public

  end;

  procedure Imprimir( const AFechaini, AFechafin: TDateTime );

implementation

uses
  LiqProdVendidoDM, UDMAuxDB, DPreview;

{$R *.DFM}

procedure Imprimir( const AFechaini, AFechafin: TDateTime );
var
  QRLiqProdVendido: TQRLiqProdVendidoCos;
begin
  QRLiqProdVendido:= TQRLiqProdVendidoCos.Create( nil );
  try
    QRLiqProdVendido.qrlblperiodo.Caption:= 'Periodo del ' + FormatDateTime('dd/mm/yyyy', AFechaini) + ' al ' + FormatDateTime('dd/mm/yyyy', AFechaFin);
    Preview( QRLiqProdVendido );
  except
    FreeAndNil( QRLiqProdVendido );
  end;
end;

procedure TQRLiqProdVendidoCos.qtxtempresa_liqPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desEmpresa( Value );
end;

procedure TQRLiqProdVendidoCos.qtxtproducto_entPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desProducto( DataSet.FieldByName('empresa_ent').AsString, Value );
end;

procedure TQRLiqProdVendidoCos.qtxtcentro_entPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - '  + descentro( DataSet.FieldByName('empresa_ent').AsString, Value );
end;

procedure TQRLiqProdVendidoCos.qtxtcosechero1Print(sender: TObject;
  var Value: String);
begin
  If  Value = '-1' then
    Value:= 'T';
end;

procedure TQRLiqProdVendidoCos.qtxtcosechero2Print(sender: TObject;
  var Value: String);
begin
  If  Value <> '-1' then
    Value:= desCosechero( DataSet.FieldByName('empresa_ent').AsString, Value )
  else
    Value:= 'ENTRADA DE TRÁNSITOS';
end;

procedure TQRLiqProdVendidoCos.qrgrpFacturadoCabBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrgrpFacturadoCab.Height:= 0;
end;

procedure TQRLiqProdVendidoCos.qtxtkilos_merPrint(sender: TObject;
  var Value: String);
begin
  if Value = '1' then value:= 'SI' else value:= 'NO';
end;

procedure TQRLiqProdVendidoCos.qtxtfacturadoPrint(sender: TObject;
  var Value: String);
begin
    if Value = '1' then value:= 'Facturado' else value:= 'Pendiente';
end;

procedure TQRLiqProdVendidoCos.qtxtcosechero_entPrint(sender: TObject;
  var Value: String);
begin
  If  Value <> '-1' then
    Value:= 'TOTAL ' + desCosechero( DataSet.FieldByName('empresa_ent').AsString, Value )
  else
    Value:= 'TOTAL ENTRADA DE TRÁNSITOS';
end;

end.
