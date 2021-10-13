unit DesgloseTransitosQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB;

type
  TQRDesgloseTransito = class(TQuickRep)
    bndPie: TQRBand;
    bndSalidas: TQRSubDetail;
    bndTransitos: TQRSubDetail;
    bndCabecera: TQRBand;
    centro_salida: TQRDBText;
    transito: TQRDBText;
    fecha: TQRDBText;
    bndTransitosPie: TQRBand;
    bndTransitosCab: TQRBand;
    QRLabel1: TQRLabel;
    bndSalidasPie: TQRBand;
    bndSalidasCab: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel31: TQRLabel;
    bndTotalProductoSalida: TQRChildBand;
    fecha_factura_sc: TQRDBText;
    n_factura_sc: TQRDBText;
    kilos_sl: TQRDBText;
    calibre_sl: TQRDBText;
    categoria_sl: TQRDBText;
    envase_sl: TQRDBText;
    producto_sl: TQRDBText;
    dir_sum_sc: TQRDBText;
    cliente_sal_sc: TQRDBText;
    fecha_sl: TQRDBText;
    n_albaran_sl: TQRDBText;
    centro_salida_sl: TQRDBText;
    empresa_sl: TQRDBText;
    ChildBand2: TQRChildBand;
    QRShape1: TQRShape;
    lblSalTotal: TQRLabel;
    lblSalProducto2: TQRLabel;
    lblSalProducto1: TQRLabel;
    ChildBand3: TQRChildBand;
    empresa_tl: TQRDBText;
    centro_tl: TQRDBText;
    referencia_tl: TQRDBText;
    fecha_tl: TQRDBText;
    producto_tl: TQRDBText;
    kilos_tl: TQRDBText;
    lblTraProducto1: TQRLabel;
    lblSalProductoVal1: TQRLabel;
    lblSalProductoVal2: TQRLabel;
    lblTraProductoVal1: TQRLabel;
    ChildBand4: TQRChildBand;
    QRShape2: TQRShape;
    lblTraTotal: TQRLabel;
    lblTraProducto2: TQRLabel;
    lblTraProductoVal2: TQRLabel;
    lblSalTotalVal: TQRLabel;
    lblTraTotalVal: TQRLabel;
    QRLabel28: TQRLabel;
    kilos_transito: TQRDBText;
    QRLabel29: TQRLabel;
    kilos_salidos: TQRDBText;
    QRLabel30: TQRLabel;
    kilos_pendientes: TQRDBText;
    QRSysData1: TQRSysData;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRSysData2: TQRSysData;
    QRShape3: TQRShape;
    procedure cliente_sal_scPrint(sender: TObject; var Value: String);
    procedure bndSalidasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndSalidasCabBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndTransitosCabBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndTransitosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndSalidasPieBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndTotalProductoSalidaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure ChildBand3AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndTransitosPieBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure producto_slPrint(sender: TObject; var Value: String);
    procedure producto_tlPrint(sender: TObject; var Value: String);
    procedure empresaPrint(sender: TObject; var Value: String);
    procedure centro_salidaPrint(sender: TObject; var Value: String);
    procedure transitoPrint(sender: TObject; var Value: String);
    procedure fechaPrint(sender: TObject; var Value: String);
  private
    sEmpresa: string;
    sProducto, sPrimer, sAnterior: string;
    rKilosProducto, rKilosTotal: real;
  public
    procedure CargarDataSets( const ATransito, ASalidasTransito, ATransitosTransito: TDataSet );

  end;

procedure Previsualizar( const AOwner: TComponent;
  const dsTransito, dsSalidasTransito, dsTransitosTransito: TDataset);



implementation

{$R *.DFM}

uses DPreview, CReportes, UDMAuxDB;

procedure Previsualizar( const AOwner: TComponent;
  const dsTransito, dsSalidasTransito, dsTransitosTransito: TDataset);
var
  MyReport: TQRDesgloseTransito;
begin
  MyReport:= TQRDesgloseTransito.Create( AOwner );
  try
    MyReport.CargarDataSets( dsTransito, dsSalidasTransito, dsTransitosTransito );
    CReportes.PonLogoGrupoBonnysa( MyReport, MyReport.sEmpresa);
    Preview( MyReport );
  except
    FreeAndNil( MyReport );
  end;
end;

procedure TQRDesgloseTransito.CargarDataSets( const ATransito, ASalidasTransito, ATransitosTransito: TDataSet );
begin
  sEmpresa:= ATransito.FieldByName('empresa').AsString;
  //DataSet:= ATransito;
  centro_salida.DataSet:= ATransito;
  transito.DataSet:= ATransito;
  fecha.DataSet:= ATransito;
  kilos_transito.DataSet:= ATransito;
  kilos_salidos.DataSet:= ATransito;
  kilos_pendientes.DataSet:= ATransito;

  bndSalidas.DataSet:= ASalidasTransito;
  empresa_sl.DataSet:= ASalidasTransito;
  centro_salida_sl.DataSet:= ASalidasTransito;
  n_albaran_sl.DataSet:= ASalidasTransito;
  fecha_sl.DataSet:= ASalidasTransito;
  producto_sl.DataSet:= ASalidasTransito;
  envase_sl.DataSet:= ASalidasTransito;
  categoria_sl.DataSet:= ASalidasTransito;
  calibre_sl.DataSet:= ASalidasTransito;
  kilos_sl.DataSet:= ASalidasTransito;
  n_factura_sc.DataSet:= ASalidasTransito;
  fecha_factura_sc.DataSet:= ASalidasTransito;
  cliente_sal_sc.DataSet:= ASalidasTransito;
  dir_sum_sc.DataSet:= ASalidasTransito;

  bndTransitos.DataSet:= ATransitosTransito;
  empresa_tl.DataSet:= ATransitosTransito;
  centro_tl.DataSet:= ATransitosTransito;
  referencia_tl.DataSet:= ATransitosTransito;
  fecha_tl.DataSet:= ATransitosTransito;
  producto_tl.DataSet:= ATransitosTransito;
  kilos_tl.DataSet:= ATransitosTransito;
end;

procedure TQRDesgloseTransito.cliente_sal_scPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + '/';
end;

procedure TQRDesgloseTransito.bndSalidasCabBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  sProducto:= bndSalidas.DataSet.FieldByName('producto_sl').AsString;
  sPrimer:= sProducto;
  sAnterior:= '';
  rKilosProducto:= 0;
  rKilosTotal:= 0;
end;

procedure TQRDesgloseTransito.bndSalidasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bndSalidas.DataSet.FieldByName('producto_sl').AsString <> sProducto;
  if PrintBand then
  begin
    sAnterior:= sProducto;
    sProducto:= bndSalidas.DataSet.FieldByName('producto_sl').AsString;
    lblSalProducto1.Caption:= 'TOTAL PRODUCTO ' + sAnterior;
    lblSalProductoVal1.Caption:= FormatFloat( '#,##0.00', rKilosProducto );
    rKilosProducto:= 0;
  end;
end;

procedure TQRDesgloseTransito.bndSalidasPieBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= sPrimer <> sProducto;
  if PrintBand then
  begin
    lblSalProducto2.Caption:= 'TOTAL PRODUCTO ' + sProducto;
    lblSalProductoVal2.Caption:= FormatFloat( '#,##0.00', rKilosProducto );
    rKilosProducto:= 0;
  end;
end;

procedure TQRDesgloseTransito.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblSalTotalVal.Caption:= FormatFloat( '#,##0.00', rKilosTotal );
end;

procedure TQRDesgloseTransito.bndTotalProductoSalidaAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  rKilosProducto:= rKilosProducto + bndSalidas.DataSet.fieldByName('kilos_sl').AsFloat;
  rKilosTotal:= rKilosTotal + bndSalidas.DataSet.fieldByName('kilos_sl').AsFloat;
end;

procedure TQRDesgloseTransito.bndTransitosCabBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  sProducto:= bndTransitos.DataSet.FieldByName('producto_tl').AsString;
  sPrimer:= sProducto;
  sAnterior:= sAnterior;
  rKilosProducto:= 0;
  rKilosTotal:= 0;
end;

procedure TQRDesgloseTransito.bndTransitosBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bndTransitos.DataSet.FieldByName('producto_tl').AsString <> sProducto;
  if PrintBand then
  begin
    sAnterior:= sProducto;
    sProducto:= bndTransitos.DataSet.FieldByName('producto_tl').AsString;
    lblTraProducto1.Caption:= 'TOTAL PRODUCTO ' + sAnterior;
    lblTraProductoVal1.Caption:= FormatFloat( '#,##0.00', rKilosProducto );
    rKilosProducto:= 0;
  end;
end;

procedure TQRDesgloseTransito.bndTransitosPieBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= sPrimer <> sProducto;
  if PrintBand then
  begin
    lblTraProducto2.Caption:= 'TOTAL PRODUCTO ' + sProducto;
    lblTraProductoVal2.Caption:= FormatFloat( '#,##0.00', rKilosProducto );
    rKilosProducto:= 0;
  end;
end;

procedure TQRDesgloseTransito.ChildBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblTraTotalVal.Caption:= FormatFloat( '#,##0.00', rKilosTotal );
end;

procedure TQRDesgloseTransito.ChildBand3AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  rKilosProducto:= rKilosProducto + bndTransitos.DataSet.fieldByName('kilos_tl').AsFloat;
  rKilosTotal:= rKilosTotal + bndTransitos.DataSet.fieldByName('kilos_tl').AsFloat;
end;


procedure TQRDesgloseTransito.producto_slPrint(sender: TObject;
  var Value: String);
begin
  Value:= value + '/ ' + desProductoCorto( sEmpresa, value );
end;

procedure TQRDesgloseTransito.producto_tlPrint(sender: TObject;
  var Value: String);
begin
  Value:= value + '/ ' + desProducto( sEmpresa, value );
end;

procedure TQRDesgloseTransito.empresaPrint(sender: TObject;
  var Value: String);
begin
  Value:= value + ' - ' + desEmpresa( value );
end;

procedure TQRDesgloseTransito.centro_salidaPrint(sender: TObject;
  var Value: String);
begin
  Value:= value + ' - ' + desCentro( sEmpresa, value );
end;

procedure TQRDesgloseTransito.transitoPrint(sender: TObject;
  var Value: String);
begin
  Value := 'TRÁNSITO Nº ' + Value;
end;

procedure TQRDesgloseTransito.fechaPrint(sender: TObject;
  var Value: String);
begin
  Value := 'FECHA TRÁNSITO ' + Value;
end;

end.
