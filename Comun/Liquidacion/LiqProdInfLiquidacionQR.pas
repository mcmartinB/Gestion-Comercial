unit LiqProdInfLiquidacionQR;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, grimgctrl;
type
  TQRLiqProdInfLiquidacion = class(TQuickRep)
    PageFooterBand1: TQRBand;
    qrbndBandaDetalle: TQRBand;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    qtxtkilos_pri: TQRDBText;
    qtxtkilos_ter: TQRDBText;
    qtxtkilos_des: TQRDBText;
    qrgrpCosechero: TQRGroup;
    qtxtcosechero1: TQRDBText;
    qtxtcosechero2: TQRDBText;
    qtxtkilos_liq: TQRDBText;
    qtxtkilos_ent: TQRDBText;
    qrbnd1: TQRBand;
    qrshp1: TQRShape;
    qrgrpCentro: TQRGroup;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl36: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr18: TQRExpr;                                     
    qrxpr20: TQRExpr;
    qrxpr22: TQRExpr;
    qrbndPieCosechero: TQRBand;
    qrshp5: TQRShape;
    qrxpr74: TQRExpr;
    qrxpr75: TQRExpr;
    qrxpr76: TQRExpr;
    qrxpr78: TQRExpr;
    qrxpr80: TQRExpr;
    qrxpr82: TQRExpr;
    qrlbl17: TQRLabel;
    qtxtcosechero_ent: TQRDBText;
    qtxtprecio_venta: TQRDBText;
    qtxtprecio_venta1: TQRDBText;
    qrlbl8: TQRLabel;
    qrxpr4: TQRExpr;
    qtxtprecio_venta2: TQRDBText;
    qtxtprecio_gastos: TQRDBText;
    qtxtprecio_liquido: TQRDBText;
    qtxtMes: TQRDBText;
    QRLabel3: TQRLabel;
    qtxtproducto_ent: TQRDBText;
    qrlbl2: TQRLabel;
    qrdbtxtempresa: TQRDBText;
    qrlblperiodo: TQRLabel;
    qrlbl1: TQRLabel;
    qrdbtxtcentro: TQRDBText;
    qrbndPieProducto: TQRBand;
    QRShape1: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRLabel1: TQRLabel;
    procedure qrdbtxtempresaPrint(sender: TObject; var Value: String);
    procedure qtxtproducto_entPrint(sender: TObject; var Value: String);
    procedure qtxtcosechero2Print(sender: TObject; var Value: String);
    procedure qtxtcosechero1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcentroPrint(sender: TObject; var Value: String);
    procedure qtxtcosechero_entPrint(sender: TObject; var Value: String);
    procedure QRLabel1Print(sender: TObject; var Value: String);
  private

  public

  end;

  procedure Imprimir( const AFechaini, AFechafin: TDateTime );

implementation

uses
  LiqProdLiquidacionDM, UDMAuxDB, DPreview;

{$R *.DFM}

procedure Imprimir( const AFechaini, AFechafin: TDateTime );
var
  QRLiqProdInfLiquidacion: TQRLiqProdInfLiquidacion;
begin
  QRLiqProdInfLiquidacion:= TQRLiqProdInfLiquidacion.Create( nil );
  try
    QRLiqProdInfLiquidacion.qrlblperiodo.Caption:= 'Periodo del ' + FormatDateTime('dd/mm/yyyy', AFechaini) + ' al ' + FormatDateTime('dd/mm/yyyy', AFechaFin);
    Preview( QRLiqProdInfLiquidacion );
  except
    FreeAndNil( QRLiqProdInfLiquidacion );
  end;
end;

procedure TQRLiqProdInfLiquidacion.qrdbtxtempresaPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desEmpresa( Value );
end;

procedure TQRLiqProdInfLiquidacion.qtxtproducto_entPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiqProdInfLiquidacion.qrdbtxtcentroPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - '  + descentro( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiqProdInfLiquidacion.qtxtcosechero1Print(sender: TObject;
  var Value: String);
begin
  If  Value = '-1' then
    Value:= 'T';
end;

procedure TQRLiqProdInfLiquidacion.qtxtcosechero2Print(sender: TObject;
  var Value: String);
begin
  If  Value <> '-1' then
    Value:= desCosechero( DataSet.FieldByName('empresa').AsString, Value )
  else
    Value:= 'ENTRADA DE TRÁNSITOS';
end;

procedure TQRLiqProdInfLiquidacion.qtxtcosechero_entPrint(sender: TObject;
  var Value: String);
begin
  If  Value <> '-1' then
    Value:= 'TOTAL ' + desCosechero( DataSet.FieldByName('empresa').AsString, Value )
  else
    Value:= 'TOTAL ENTRADA DE TRÁNSITOS';
end;
(*
  kmtMes.FieldDefs.Add('codigo', ftInteger, 0, False);
  kmtMes.FieldDefs.Add('keyMes', ftString, 15, False);
  kmtMes.FieldDefs.Add('anyomes', ftString, 6, False);
  kmtMes.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  kmtMes.FieldDefs.Add('fecha_fin', ftDate, 0, False);
  kmtMes.FieldDefs.Add('fecha_calculo', ftDate, 0, False);
  kmtMes.FieldDefs.Add('hora_calculo', ftString, 5, False);
*)


procedure TQRLiqProdInfLiquidacion.QRLabel1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL PROD. ' + Dataset.FieldByname('producto').AsString;
end;

end.
