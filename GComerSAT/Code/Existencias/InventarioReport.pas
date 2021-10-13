unit InventarioReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TQRInventario = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    SummaryBand1: TQRBand;
    PsQRExpr5: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRLabel2: TQRLabel;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PageFooterBand1: TQRBand;
    PsQRLabel18: TQRLabel;
    ChildBand1: TQRChildBand;
    PageHeaderBand1: TQRBand;
    PsQRLabel19: TQRLabel;
    PsQRSysData1: TQRSysData;
    fecha_ic: TQRDBText;
    producto_ic: TQRDBText;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRDBText3: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    PsQRDBText10: TQRDBText;
    PsQRDBText11: TQRDBText;
    PsQRLabel11: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    PsQRLabel15: TQRLabel;
    PsQRShape4: TQRShape;
    PsQRShape5: TQRShape;
    PsQRLabel10: TQRLabel;
    PsQRLabel16: TQRLabel;
    PsQRLabel17: TQRLabel;
    PsQRDBText9: TQRDBText;
    PsQRDBText8: TQRDBText;
    PsQRShape6: TQRShape;
    PsQRShape7: TQRShape;
    ChildBand2: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    confeccCat1: TQRLabel;
    confeccCat2: TQRLabel;
    QRLabel6: TQRLabel;
    confeccTotal: TQRLabel;
    QRShape2: TQRShape;
    transitosCat1: TQRLabel;
    transitosCat2: TQRLabel;
    transitosTotal: TQRLabel;
    salidasCat1: TQRLabel;
    salidasCat2: TQRLabel;
    salidasTotal: TQRLabel;
    existAntCat1: TQRLabel;
    existAntCat2: TQRLabel;
    existAntTotal: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    PsQRLabel21: TQRLabel;
    ChildBand3: TQRChildBand;
    QRDBText1: TQRDBText;
    QRLabel4: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel5: TQRLabel;
    centro_ic: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrdbtxtkilos_ajuste_c1_ic: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrshp1: TQRShape;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrdbtxt3: TQRDBText;
    qrdbtxtkilos_ajuste_c1_ic1: TQRDBText;
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure PsQRDBText1Print(sender: TObject; var Value: string);
    procedure PsQRLabel11Print(sender: TObject; var Value: string);
    procedure PsQRLabel12Print(sender: TObject; var Value: string);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel21Print(sender: TObject; var Value: string);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure centro_icPrint(sender: TObject; var Value: String);
    procedure qrlbl1Print(sender: TObject; var Value: String);
  private
    total_inventario: real;
    conf1, conf2, sal1, sal2, tran1, tran2, exis1, exis2: real;
  public
    procedure LoadConfeccionado( const AConf1, AConf2, ASal1, ASal2, ATran1, ATran2, AExis1, AExis2: Real );
  end;

implementation

{$R *.DFM}

uses InventarioData, dialogs;

procedure TQRInventario.LoadConfeccionado( const AConf1, AConf2, ASal1, ASal2, ATran1, ATran2, AExis1, AExis2: Real );
begin
  conf1:= AConf1;
  conf2:= AConf2;
  Sal1 := ASal1;
  Sal2 := ASal2;
  Tran1 := ATran1;
  Tran2:= ATran2;
  Exis1 := AExis1;
  Exis2 := AExis2;
end;

procedure TQRInventario.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  Value := Value + ' ' + DMInventario.QInventarioCabdes_producto.AsString;
end;

procedure TQRInventario.PsQRDBText1Print(sender: TObject;
  var Value: string);
begin
  Value := 'Inventario del  ' + Value;
end;

procedure TQRInventario.PsQRLabel11Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', DMInventario.QInventarioCabkilos_cim_c1_ic.Value +
    DMInventario.QInventarioCabkilos_cia_c1_ic.Value);
end;

procedure TQRInventario.PsQRLabel12Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', DMInventario.QInventarioCabkilos_cim_c2_ic.Value +
    DMInventario.QInventarioCabkilos_cia_c2_ic.Value);
end;

procedure TQRInventario.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  total_inventario := total_inventario +
    DMInventario.QInventarioLinkilos_ce_c1_il.Value +
    DMInventario.QInventarioLinkilos_ce_c2_il.Value;
end;

procedure TQRInventario.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  total_inventario := DMInventario.QInventarioCabkilos_cec_ic.Value +
    DMInventario.QInventarioCabkilos_cim_c1_ic.Value +
    DMInventario.QInventarioCabkilos_cim_c2_ic.Value +
    DMInventario.QInventarioCabkilos_cia_c1_ic.Value +
    DMInventario.QInventarioCabkilos_cia_c2_ic.Value +
    DMInventario.QInventarioCabkilos_zd_c3_ic.Value +
    DMInventario.QInventarioCabkilos_zd_d_ic.Value;
end;

procedure TQRInventario.PsQRLabel21Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTAL INVENTARIO: ' + FormatFloat('#,##0.00', total_inventario);
end;

procedure TQRInventario.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  confeccCat1.Caption:= FormatFloat( '#,##0.00', conf1 );
  confeccCat2.Caption:= FormatFloat( '#,##0.00', conf2 );
  confeccTotal.Caption:= FormatFloat( '#,##0.00', conf1 + conf2 );

  salidasCat1.Caption:= FormatFloat( '#,##0.00', sal1 );
  salidasCat2.Caption:= FormatFloat( '#,##0.00', sal2 );
  salidasTotal.Caption:= FormatFloat( '#,##0.00', sal1 + sal2 );

  transitosCat1.Caption:= FormatFloat( '#,##0.00', tran1 );
  transitosCat2.Caption:= FormatFloat( '#,##0.00', tran2 );
  transitosTotal.Caption:= FormatFloat( '#,##0.00', tran1 + tran2 );

  existAntCat1.Caption:= FormatFloat( '#,##0.00', exis1 );
  existAntCat2.Caption:= FormatFloat( '#,##0.00', exis2 );
  existAntTotal.Caption:= FormatFloat( '#,##0.00', exis1 + exis2 );
end;

procedure TQRInventario.ChildBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= '' <> Trim( DMInventario.QInventarioCabnotas_ic.AsString );
end;

procedure TQRInventario.centro_icPrint(sender: TObject; var Value: String);
begin
  Value := Value + ' ' + DMInventario.QInventarioCabdes_centro.AsString;
end;

procedure TQRInventario.qrlbl1Print(sender: TObject; var Value: String);
begin
  Value := 'TOTAL AJUSTADO: ' + FormatFloat('#,##0.00', total_inventario +
              DMInventario.QInventarioCabkilos_ajuste_c1_ic.Value +
              DMInventario.QInventarioCabkilos_ajuste_c2_ic.Value +
              DMInventario.QInventarioCabkilos_ajuste_c3_ic.Value +
              DMInventario.QInventarioCabkilos_ajuste_cd_ic.Value +
              DMInventario.QInventarioCabkilos_ajuste_campo_ic.Value );
end;

end.
