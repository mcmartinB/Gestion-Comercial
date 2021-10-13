unit LiqProdVendidoResumenQR;

interface
                                                                              
uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, grimgctrl;
type
  TQRLiqProdVendidoResumen = class(TQuickRep)
    qrbndBandaDetalle: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
    qtxtempresa_liq: TQRDBText;
    qrlbl15: TQRLabel;
    qtxtkilos_pri: TQRDBText;
    qtxtkilos_ter: TQRDBText;
    qtxtkilos_des: TQRDBText;
    qtxtkilos_mer: TQRDBText;
    qtxtgastos_fac_liq: TQRDBText;
    qtxtdescuentos_fac_liq: TQRDBText;
    qtxtimporte_liq: TQRDBText;
    qtxtgastos_fac_liq1: TQRDBText;
    qtxtcostes_sec_transito_liq: TQRDBText;
    qrgrpCentro: TQRGroup;
    qrlbl1: TQRLabel;
    qtxtcentro_ent: TQRDBText;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qtxtkilos_merma: TQRDBText;
    qtxtkilos_disponibles: TQRDBText;
    qrlbl10: TQRLabel;
    qrlbl3: TQRLabel;
    qtxtproducto_ent: TQRDBText;
    qrlblperiodo: TQRLabel;
    qtxtpor_merma: TQRDBText;
    qrlbl11: TQRLabel;
    qtxtkilos_disponibles1: TQRDBText;
    qtxtpor_facturado: TQRDBText;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qtxtkilos_iniciales: TQRDBText;
    qrlbl14: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qtxtkilos_salida_venta: TQRDBText;
    qtxtporcentaje_dsiponible: TQRDBText;
    qrshp1: TQRShape;
    qrshp2: TQRShape;
    qrlbl18: TQRLabel;
    qrlbl19: TQRLabel;
    procedure qtxtempresa_liqPrint(sender: TObject; var Value: String);
    procedure qtxtproducto_entPrint(sender: TObject; var Value: String);
    procedure qtxtcentro_entPrint(sender: TObject; var Value: String);
    procedure qtxtkilos_mermaPrint(sender: TObject;
      var Value: String);
    procedure qtxtkilos_disponiblesPrint(sender: TObject;
      var Value: String);
    procedure qrlblFacturado(sender: TObject; var Value: String);
    procedure qtxtkilos_disponibles1Print(sender: TObject;
      var Value: String);
    procedure qtxtpor_facturadoPrint(sender: TObject; var Value: String);
  private
    sEmpresa: String;
    bFacturado: boolean;
  public

  end;

  procedure Imprimir( const AEmpresa: String; const AFechaIni, AFechaFin: TDateTime; const AFacturado: boolean );

implementation

uses
  LiqProdVendidoDM, UDMAuxDB, DPreview;

{$R *.DFM}

procedure Imprimir( const AEmpresa: String; const AFechaIni, AFechaFin: TDateTime; const AFacturado: boolean );
var
  QRLiqProdVendidoResumen: TQRLiqProdVendidoResumen;
begin
  QRLiqProdVendidoResumen:= TQRLiqProdVendidoResumen.Create( nil );
  try
    QRLiqProdVendidoResumen.qrlblperiodo.caption:= 'del ' + FormatDateTime('dd/mm/yyyy', AFechaIni ) + ' al ' + FormatDateTime('dd/mm/yyyy', AFechaFin );
    QRLiqProdVendidoResumen.bFacturado:= AFacturado;
    QRLiqProdVendidoResumen.sEmpresa:= AEmpresa;

    if QRLiqProdVendidoResumen.sEmpresa = 'SAT' then
      QRLiqProdVendidoResumen.qrgrpCentro.Expression := '[centro] + [producto]'
    else
      QRLiqProdVendidoResumen.qrgrpCentro.Expression := '[empresa] + [centro] + [producto]';


    Preview( QRLiqProdVendidoResumen );
  except
    FreeAndNil( QRLiqProdVendidoResumen );
  end;
end;

procedure TQRLiqProdVendidoResumen.qtxtempresa_liqPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desEmpresa( Value );
end;

procedure TQRLiqProdVendidoResumen.qtxtproducto_entPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiqProdVendidoResumen.qtxtcentro_entPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - '  + descentro( DataSet.FieldByName('empresa').AsString, Value );
end;

(*77
  kmtSemana.FieldDefs.Add('codigo', ftInteger, 0, False);
  kmtSemana.FieldDefs.Add('keySem', ftString, 15, False);
  kmtSemana.FieldDefs.Add('', ftString, 3, False);
  kmtSemana.FieldDefs.Add('', ftString, 3, False);
  kmtSemana.FieldDefs.Add('', ftString, 3, False);
  kmtSemana.FieldDefs.Add('', ftString, 6, False);
  kmtSemana.FieldDefs.Add('', ftDate, 0, False);
  kmtSemana.FieldDefs.Add('', ftDate, 0, False);
  kmtSemana.FieldDefs.Add('', ftDate, 0, False);
  kmtSemana.FieldDefs.Add('', ftString, 5, False);

  kmtSemana.FieldDefs.Add('precio_coste_comercial', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('precio_coste_produccion', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('precio_coste_administracion', ftFloat, 0, False);

  kmtSemana.FieldDefs.Add('', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('', ftFloat, 0, False);
  *)

procedure TQRLiqProdVendidoResumen.qtxtkilos_mermaPrint(
  sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('kilos_merma').AsFloat >= 0  then
  begin
    qtxtkilos_merma.Color:= clWhite;
  end
  else
  begin
    qtxtkilos_merma.Color:= clSilver;
  end;

  qtxtporcentaje_dsiponible.Frame.DrawRight:= bFacturado;
end;

procedure TQRLiqProdVendidoResumen.qtxtkilos_disponiblesPrint(
  sender: TObject; var Value: String);
begin
  if Abs( DataSet.FieldByName('kilos_objetivo').AsFloat - DataSet.FieldByName('kilos_disponibles').AsFloat) < 1  then
  begin
    qtxtkilos_disponibles.Color:= clWhite;
  end
  else
  begin
    qtxtkilos_disponibles.Color:= clSilver;
  end;
end;

procedure TQRLiqProdVendidoResumen.qrlblFacturado(sender: TObject;
  var Value: String);
begin
  if not bFacturado then
    Value:= '';
end;

procedure TQRLiqProdVendidoResumen.qtxtkilos_disponibles1Print(
  sender: TObject; var Value: String);
begin
  if not bFacturado then
  begin
    Value:= '';
  end
  else
  begin
    if Abs( DataSet.FieldByName('kilos_objetivo').AsFloat - DataSet.FieldByName('kilos_disponibles').AsFloat) < 1  then
    begin
      qtxtkilos_disponibles.Color:= clWhite;
    end
    else
    begin
      qtxtkilos_disponibles.Color:= clSilver;
    end;
  end;
end;

procedure TQRLiqProdVendidoResumen.qtxtpor_facturadoPrint(sender: TObject;
  var Value: String);
begin
  if not bFacturado then
  begin
    Value:= '';
  end
  else
  begin
    if DataSet.FieldByName('kilos_merma').AsFloat >= 0  then
    begin
      qtxtkilos_merma.Color:= clWhite;
    end
    else
    begin
      qtxtkilos_merma.Color:= clSilver;
    end;
  end;
end;

end.
