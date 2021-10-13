unit LiqProdLiquidacionCosQR;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, grimgctrl;
type
  TQRLiqProdLiquidacionCos = class(TQuickRep)
    PageFooterBand1: TQRBand;
    qrbndBandaDetalle: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
    qtxtempresa_liq: TQRDBText;
    qrlblperiodo: TQRLabel;
    qtxtkilos_pri: TQRDBText;
    qtxtkilos_ter: TQRDBText;
    qtxtkilos_des: TQRDBText;
    qrgrpCosechero: TQRGroup;
    qtxtcosechero1: TQRDBText;
    qtxtcosechero2: TQRDBText;
    qrbnd1: TQRBand;
    qrshp1: TQRShape;
    qrgrpCentro: TQRGroup;
    qrlbl1: TQRLabel;
    qtxtcentro_ent: TQRDBText;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr22: TQRExpr;
    qrbndPieCosechero: TQRBand;
    qrshp5: TQRShape;
    qrxpr74: TQRExpr;
    qrxpr75: TQRExpr;
    qrxpr76: TQRExpr;
    qrxpr82: TQRExpr;
    qrlbl17: TQRLabel;
    qtxtcosechero_ent: TQRDBText;
    qtxtprecio_venta1: TQRDBText;
    qrlbl8: TQRLabel;
    qrxpr4: TQRExpr;
    qtxtprecio_liquido: TQRDBText;
    qtxtMes: TQRDBText;
    QRLabel3: TQRLabel;
    qtxtproducto_ent: TQRDBText;
    qtxtcosechero: TQRDBText;
    qtxtcosechero3: TQRDBText;
    qrdbtxtempresa: TQRDBText;
    qtxtempresa: TQRDBText;
    qtxtcentro: TQRDBText;
    qtxtproducto: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrdbtxtcentro: TQRDBText;
    qrdbtxtempresa1: TQRDBText;
    procedure qtxtempresa_liqPrint(sender: TObject; var Value: String);
    procedure qtxtproducto_entPrint(sender: TObject; var Value: String);
    procedure qtxtcosechero2Print(sender: TObject; var Value: String);
    procedure qtxtcosechero1Print(sender: TObject; var Value: String);
    procedure qtxtcentro_entPrint(sender: TObject; var Value: String);
    procedure qtxtcosechero_entPrint(sender: TObject; var Value: String);
    procedure qtxtcosecheroPrint(sender: TObject; var Value: String);
    procedure qtxtcosechero3Print(sender: TObject; var Value: String);
    procedure qrgrpCosecheroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieCosecheroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbnd1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qtxtproductoPrint(sender: TObject; var Value: String);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure qrdbtxtempresaPrint(sender: TObject; var Value: String);
    procedure ColumnHeaderBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtcentroPrint(sender: TObject; var Value: String);
    procedure qrdbtxtempresa1Print(sender: TObject; var Value: String);
    procedure QRLabel3Print(sender: TObject; var Value: String);
    procedure qrlbl1Print(sender: TObject; var Value: String);
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
  QRLiqProdLiquidacionCos: TQRLiqProdLiquidacionCos;
begin
  QRLiqProdLiquidacionCos:= TQRLiqProdLiquidacionCos.Create( nil );
  try
    QRLiqProdLiquidacionCos.qrlblperiodo.Caption:= 'Periodo del ' + FormatDateTime('dd/mm/yyyy', AFechaini) + ' al ' + FormatDateTime('dd/mm/yyyy', AFechaFin);
    Preview( QRLiqProdLiquidacionCos );
  except
    FreeAndNil( QRLiqProdLiquidacionCos );
  end;
end;

procedure TQRLiqProdLiquidacionCos.qtxtempresa_liqPrint(
  sender: TObject; var Value: String);
begin
  if  ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= Value + ' - '  + desEmpresa( Value );
end;

procedure TQRLiqProdLiquidacionCos.qtxtproducto_entPrint(
  sender: TObject; var Value: String);
begin
  if  ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= Value + ' - '  + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiqProdLiquidacionCos.qtxtcentro_entPrint(sender: TObject;
  var Value: String);
begin
  if  ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= Value + ' - '  + descentro( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiqProdLiquidacionCos.qtxtcosechero1Print(sender: TObject;
  var Value: String);
begin
  If  Value = '-1' then
    Value:= 'T';
end;

procedure TQRLiqProdLiquidacionCos.qtxtcosechero2Print(sender: TObject;
  var Value: String);
begin
  If  Value <> '-1' then
    Value:= desCosechero( DataSet.FieldByName('empresa').AsString, Value )
  else
    Value:= 'ENTRADA DE TRÁNSITOS';
end;

procedure TQRLiqProdLiquidacionCos.qtxtcosechero_entPrint(sender: TObject;
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


procedure TQRLiqProdLiquidacionCos.qtxtcosecheroPrint(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
     If  Value = '-1' then
      Value:= 'T';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLiqProdLiquidacionCos.qtxtcosechero3Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    If  Value <> '-1' then
      Value:= desCosechero( DataSet.FieldByName('empresa').AsString, Value )
    else
      Value:= 'ENTRADA DE TRÁNSITOS';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLiqProdLiquidacionCos.qrgrpCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRLiqProdLiquidacionCos.qrbndPieCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRLiqProdLiquidacionCos.qrbnd1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRLiqProdLiquidacionCos.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRLiqProdLiquidacionCos.qtxtproductoPrint(sender: TObject;
  var Value: String);
begin
  //
  if  not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiqProdLiquidacionCos.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  if  not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TQRLiqProdLiquidacionCos.qrdbtxtempresaPrint(sender: TObject;
  var Value: String);
begin
  if  not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

(*
  kmtLiqCos.FieldDefs.Add('codigo', ftInteger, 0, False);
  kmtLiqCos.FieldDefs.Add('keyMes', ftString, 15, False);
  kmtLiqCos.FieldDefs.Add('', ftString, 3, False);
  kmtLiqCos.FieldDefs.Add('', ftString, 3, False);
  kmtLiqCos.FieldDefs.Add('', ftString, 3, False);
  kmtLiqCos.FieldDefs.Add('', ftString, 3, False);
  kmtLiqCos.FieldDefs.Add('', ftString, 6, False);

  kmtLiqCos.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  kmtLiqCos.FieldDefs.Add('fecha_fin', ftDate, 0, False);
  kmtLiqCos.FieldDefs.Add('fecha_calculo', ftDate, 0, False);
  kmtLiqCos.FieldDefs.Add('hora_calculo', ftString, 5, False);

  kmtLiqCos.FieldDefs.Add('', ftInteger, 0, False);
  kmtLiqCos.FieldDefs.Add('', ftInteger, 0, False);
  kmtLiqCos.FieldDefs.Add('', ftInteger, 0, False);

  kmtLiqCos.FieldDefs.Add('', ftFloat, 0, False);
  kmtLiqCos.FieldDefs.Add('', ftFloat, 0, False);
*)

procedure TQRLiqProdLiquidacionCos.ColumnHeaderBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
   PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRLiqProdLiquidacionCos.qrdbtxtcentroPrint(sender: TObject;
  var Value: String);
begin
  if  not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= descentro( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiqProdLiquidacionCos.qrdbtxtempresa1Print(sender: TObject;
  var Value: String);
begin
  if  not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= ''
  else
    Value:= desEmpresa( Value );;
end;

procedure TQRLiqProdLiquidacionCos.QRLabel3Print(sender: TObject;
  var Value: String);
begin
  if  ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TQRLiqProdLiquidacionCos.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  if  ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

end.
