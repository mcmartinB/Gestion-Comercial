unit LiqProdVendidoPlanQR;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, grimgctrl;
type
  TQRLiqProdVendidoPlan = class(TQuickRep)
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
    qrlbl15: TQRLabel;
    qrdbtxtfecha_fin: TQRDBText;
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
    qrgrpPlantacion: TQRGroup;
    qtxtcosechero: TQRDBText;
    qtxtplantacion: TQRDBText;
    qtxtSemana_planta: TQRDBText;
    qtxtSemana_planta1: TQRDBText;
    qtxtkilos_ent: TQRDBText;
    qtxtcostes_sec_transito_liq: TQRDBText;
    qrbnd1: TQRBand;
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
    anysem_liq: TQRDBText;
    qtxtcostes_financiero_liq: TQRDBText;
    qrxpr2: TQRExpr;
    qtxtcostes_financiero_liq1: TQRDBText;
    qrlbl10: TQRLabel;
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
    qrbndPiePlantacion: TQRBand;
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
    qrshp4: TQRShape;
    qrbndPieCosechero: TQRBand;
    qtxtfacturado: TQRDBText;
    qtxtplantacion_ent1: TQRDBText;
    qrshp5: TQRShape;
    qrxpr62: TQRExpr;
    qrxpr63: TQRExpr;
    qrxpr64: TQRExpr;
    qrxpr65: TQRExpr;
    qrxpr66: TQRExpr;
    qrxpr67: TQRExpr;
    qrxpr68: TQRExpr;
    qrxpr69: TQRExpr;
    qrxpr70: TQRExpr;
    qrxpr71: TQRExpr;
    qrxpr72: TQRExpr;
    qrxpr73: TQRExpr;
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
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrshp6: TQRShape;
    qrlbl16: TQRLabel;
    qtxtcosechero_ent: TQRDBText;
    qrxpr86: TQRExpr;
    qrxpr87: TQRExpr;
    qrxpr88: TQRExpr;
    qrxpr89: TQRExpr;
    qrxpr90: TQRExpr;
    qrxpr91: TQRExpr;
    qrxpr92: TQRExpr;
    qrxpr93: TQRExpr;
    qrxpr94: TQRExpr;
    qrxpr95: TQRExpr;
    qrxpr96: TQRExpr;
    qrxpr97: TQRExpr;
    qrshp1: TQRShape;
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
    qrlbl17: TQRLabel;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrxpr29: TQRExpr;
    qrxpr30: TQRExpr;
    qrxpr31: TQRExpr;
    qrxpr32: TQRExpr;
    qrxpr33: TQRExpr;
    qrxpr34: TQRExpr;
    qrxpr35: TQRExpr;
    qrxpr36: TQRExpr;
    qrxpr37: TQRExpr;
    procedure qtxtempresa_liqPrint(sender: TObject; var Value: String);
    procedure qtxtproducto_entPrint(sender: TObject; var Value: String);
    procedure qtxtcosechero2Print(sender: TObject; var Value: String);
    procedure qtxtSemana_planta1Print(sender: TObject; var Value: String);
    procedure qtxtcosechero1Print(sender: TObject; var Value: String);
    procedure qtxtplantacionPrint(sender: TObject; var Value: String);
    procedure qtxtcentro_entPrint(sender: TObject; var Value: String);
    procedure qrgrpFacturadoCabBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qtxtkilos_merPrint(sender: TObject; var Value: String);
    procedure qtxtfacturadoPrint(sender: TObject; var Value: String);
  private

  public

  end;

  procedure Imprimir;

implementation

uses
  LiqProdVendidoDM, UDMAuxDB, DPreview;

{$R *.DFM}

procedure Imprimir;
var
  QRLiqProdVendido: TQRLiqProdVendidoPlan;
begin
  QRLiqProdVendido:= TQRLiqProdVendidoPlan.Create( nil );
  try
    Preview( QRLiqProdVendido );
  except
    FreeAndNil( QRLiqProdVendido );
  end;
end;

procedure TQRLiqProdVendidoPlan.qtxtempresa_liqPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desEmpresa( Value );
end;

procedure TQRLiqProdVendidoPlan.qtxtproducto_entPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desProducto( DataSet.FieldByName('empresa_ent').AsString, Value );
end;

procedure TQRLiqProdVendidoPlan.qtxtcentro_entPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - '  + descentro( DataSet.FieldByName('empresa_ent').AsString, Value );
end;

procedure TQRLiqProdVendidoPlan.qtxtcosechero1Print(sender: TObject;
  var Value: String);
begin
  If  Value = '-1' then
    Value:= 'T';
end;

procedure TQRLiqProdVendidoPlan.qtxtcosechero2Print(sender: TObject;
  var Value: String);
begin
  If  Value <> '-1' then
    Value:= desCosechero( DataSet.FieldByName('empresa_ent').AsString, Value )
  else
    Value:= 'ENTRADA DE TRÁNSITOS';
end;

procedure TQRLiqProdVendidoPlan.qtxtplantacionPrint(sender: TObject;
  var Value: String);
begin
  If  Value = '-1' then
    Value:= DataSet.FieldByName('centro_origen_ent').AsString;
end;

procedure TQRLiqProdVendidoPlan.qtxtSemana_planta1Print(sender: TObject;
  var Value: String);
begin
  If  Value <> '-1' then
    Value:= desPlantacion( DataSet.FieldByName('empresa_ent').AsString,
                         DataSet.FieldByName('producto_ent').AsString,
                         DataSet.FieldByName('cosechero_ent').AsString, Value,
                         DataSet.FieldByName('semana_planta_ent').AsString )
  else
    Value:= desCentro( DataSet.FieldByName('empresa_ent').AsString,
                           DataSet.FieldByName('centro_origen_ent').AsString );
end;

(*
  kmtLiquidacion.FieldDefs.Add('liquido_liq', ftFloat, 0, False);
*)

procedure TQRLiqProdVendidoPlan.qrgrpFacturadoCabBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrgrpFacturadoCab.Height:= 0;
end;

procedure TQRLiqProdVendidoPlan.qtxtkilos_merPrint(sender: TObject;
  var Value: String);
begin
  if Value = '1' then value:= 'SI' else value:= 'NO';
end;

procedure TQRLiqProdVendidoPlan.qtxtfacturadoPrint(sender: TObject;
  var Value: String);
begin
    if Value = '1' then value:= 'Facturado' else value:= 'Pendiente';
end;

end.
