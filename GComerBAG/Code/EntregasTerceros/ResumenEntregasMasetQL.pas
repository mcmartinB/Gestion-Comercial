unit ResumenEntregasMasetQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLResumenEntregasMaset = class(TQuickRep)
    QRBCabecera: TQRBand;
    QRBDetalle: TQRBand;
    QRBSumario: TQRBand;
    QRBGrupoProveedor: TQRGroup;
    QRLabel6: TQRLabel;
    QRLCosechero: TQRLabel;
    proveedor_ec: TQRDBText;
    QRDBTCajas: TQRDBText;
    kilos_albaran_el: TQRDBText;
    QRBTitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLDesde: TQRLabel;
    QRLHasta: TQRLabel;
    psProducto: TQRLabel;
    QListado: TQuery;
    desProveedor: TQRDBText;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRBPieGrupo: TQRBand;
    QRShape1: TQRShape;
    QRShape5: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    albaran_ec: TQRDBText;
    QRShape2: TQRShape;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    psCentro: TQRLabel;
    psSemana: TQRLabel;
    kilos_destarados_el: TQRDBText;
    porcen_aprovechados_el: TQRDBText;
    sepAprovechadosCos: TQRShape;
    sepPorcenAprovechadosCos: TQRShape;
    lPorcenAlbCos: TQRLabel;
    lPorcenAlbTotal: TQRLabel;
    QRBGrupoAlmacen: TQRGroup;
    qrdbtxtalmacen_el: TQRDBText;
    desAlmacen: TQRDBText;
    QRBand1: TQRBand;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRShape7: TQRShape;
    QRExpr11: TQRExpr;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    lPorcenAlbAlm: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    kilos_aprovechados_el: TQRDBText;
    kilos_reales_el: TQRDBText;
    QRShape3: TQRShape;
    QRExpr5: TQRExpr;
    QRShape8: TQRShape;
    QRShape11: TQRShape;
    QRExpr8: TQRExpr;
    QRShape12: TQRShape;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLCajas: TQRLabel;
    QRLKilos: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRExpr19: TQRExpr;
    QRShape13: TQRShape;
    lPorcenDesAlm: TQRLabel;
    lPorcenDesCos: TQRLabel;
    QRShape14: TQRShape;
    lPorcenDesTotal: TQRLabel;
    codigo_ec: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    vehiculo_ec: TQRDBText;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lPorcenAlbAlmPrint(sender: TObject; var Value: String);
    procedure lPorcenDesAlmPrint(sender: TObject; var Value: String);
    procedure lPorcenAlbTotalPrint(sender: TObject; var Value: String);
    procedure lPorcenDesTotalPrint(sender: TObject; var Value: String);
    procedure lPorcenAlbCosPrint(sender: TObject; var Value: String);
    procedure lPorcenDesCosPrint(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRLabel9Print(sender: TObject; var Value: String);
    procedure QRBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBPieGrupoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBSumarioAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure kilos_reales_elPrint(sender: TObject; var Value: String);
    procedure QRLabel11Print(sender: TObject; var Value: String);
    procedure QRLabel15Print(sender: TObject; var Value: String);
    procedure QRLabel16Print(sender: TObject; var Value: String);
    procedure desAlmacenPrint(sender: TObject; var Value: String);

  private

    rKilosAlbaranCos, rKilosAlbaranAlm, rKilosAlbaranTotal:Real;
    rKilosDestaradosCos, rKilosDestaradosAlm, rKilosDestaradosTotal:Real;
    rKilosRealesCos, rKilosRealesAlm, rKilosRealesTotal:Real;
    rKilosAprovechadosCos, rKilosAprovechadosAlm, rKilosAprovechadosTotal:Real;

  public
    rSobrepeso: real;
  end;

var
  QLResumenEntregasMaset: TQLResumenEntregasMaset;

implementation

{$R *.DFM}

uses
  UDMAuxDB;


procedure TQLResumenEntregasMaset.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rKilosAlbaranCos:= 0;
  rKilosAlbaranAlm:= 0;
  rKilosAlbaranTotal:= 0;

  rKilosDestaradosCos:= 0;
  rKilosDestaradosAlm:= 0;
  rKilosDestaradosTotal:= 0;

  rKilosRealesCos:= 0;
  rKilosRealesAlm:= 0;
  rKilosRealesTotal:= 0;

  rKilosAprovechadosCos:= 0;
  rKilosAprovechadosAlm:= 0;
  rKilosAprovechadosTotal:= 0;
end;

procedure TQLResumenEntregasMaset.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rAux: real;
begin
  rKilosAlbaranCos:= rKilosAlbaranCos +  QListado.fieldbyname('kilos_albaran_el').AsFloat;
  rKilosAlbaranAlm:= rKilosAlbaranAlm +  QListado.fieldbyname('kilos_albaran_el').AsFloat;
  rKilosAlbaranTotal:= rKilosAlbaranTotal +  QListado.fieldbyname('kilos_albaran_el').AsFloat;

  rKilosAprovechadosCos:= rKilosAprovechadosCos + QListado.fieldbyname('kilos_aprovechados_el').AsFloat;
  rKilosAprovechadosAlm:= rKilosAprovechadosAlm + QListado.fieldbyname('kilos_aprovechados_el').AsFloat;
  rKilosAprovechadosTotal:= rKilosAprovechadosTotal +  QListado.fieldbyname('kilos_aprovechados_el').AsFloat;

  rKilosDestaradosCos:= rKilosDestaradosCos +  QListado.fieldbyname('kilos_destarados_el').AsFloat;
  rKilosDestaradosAlm:= rKilosDestaradosAlm +  QListado.fieldbyname('kilos_destarados_el').AsFloat;
  rKilosDestaradosTotal:= rKilosDestaradosTotal +  QListado.fieldbyname('kilos_destarados_el').AsFloat;

  rAux:= ( 1 - ( rSobrepeso / 100 ) ) * QListado.fieldbyname('kilos_destarados_el').AsFloat;
  rKilosRealesCos:= rKilosRealesCos + rAux;
  rKilosRealesAlm:= rKilosRealesAlm + rAux;
  rKilosRealesTotal:= rKilosRealesTotal +  rAux;
end;

procedure TQLResumenEntregasMaset.lPorcenAlbAlmPrint(sender: TObject;
  var Value: String);
begin
  if rKilosAlbaranAlm <> 0 then
    Value:= FormatFloat( '#,##0.00', ( rKilosAprovechadosAlm * 100 ) / rKilosAlbaranAlm )
  else
    Value:= '0,00';
end;

procedure TQLResumenEntregasMaset.lPorcenDesAlmPrint(sender: TObject;
  var Value: String);
begin
  if rKilosRealesAlm <> 0 then
    Value:= FormatFloat( '#,##0.00', ( rKilosAprovechadosAlm * 100 ) / rKilosRealesAlm )
  else
    Value:= '0,00';
end;

procedure TQLResumenEntregasMaset.lPorcenAlbCosPrint(sender: TObject;
  var Value: String);
begin
  if rKilosAlbaranCos <> 0 then
    Value:= FormatFloat( '#,##0.00', ( rKilosAprovechadosCos * 100 ) / rKilosAlbaranCos )
  else
    Value:= '0,00';
end;

procedure TQLResumenEntregasMaset.lPorcenDesCosPrint(sender: TObject;
  var Value: String);
begin
  if rKilosRealesCos <> 0 then
    Value:= FormatFloat( '#,##0.00', ( rKilosAprovechadosCos * 100 ) / rKilosRealesCos )
  else
    Value:= '0,00';
end;

procedure TQLResumenEntregasMaset.lPorcenAlbTotalPrint(sender: TObject;
  var Value: String);
begin
  if rKilosAlbaranTotal <> 0 then
    Value:= FormatFloat( '#,##0.00', ( rKilosAprovechadosTotal * 100 ) / rKilosAlbaranTotal )
  else
    Value:= '0,00';
end;

procedure TQLResumenEntregasMaset.lPorcenDesTotalPrint(sender: TObject;
  var Value: String);
begin
  if rKilosRealesTotal <> 0 then
    Value:= FormatFloat( '#,##0.00', ( rKilosAprovechadosTotal * 100 ) / rKilosRealesTotal )
  else
    Value:= '0,00';
end;

procedure TQLResumenEntregasMaset.QRLabel9Print(sender: TObject;
  var Value: String);
var
  rAux: real;
begin
  rAux:= ( 1 - ( rSobrepeso / 100 ) ) * QListado.fieldbyname('kilos_destarados_el').AsFloat;
  if rAux <> 0 then
    Value:= FormatFloat( '#,##0.00',
            ( DataSet.FieldByName('kilos_aprovechados_el').AsFloat * 100 ) / rAux )
  else
    Value:= '0,00';
end;

procedure TQLResumenEntregasMaset.QRBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  rKilosAlbaranAlm:= 0;
  rKilosAprovechadosAlm:= 0;
  rKilosDestaradosAlm:= 0;
  rKilosRealesAlm:= 0;
end;

procedure TQLResumenEntregasMaset.QRBPieGrupoAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  rKilosAlbaranCos:= 0;
  rKilosAprovechadosCos:= 0;
  rKilosDestaradosCos:= 0;
  rKilosRealesCos:= 0;
end;

procedure TQLResumenEntregasMaset.QRBSumarioAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  rKilosAlbaranTotal:= 0;
  rKilosAprovechadosTotal:= 0;
  rKilosDestaradosTotal:= 0;
  rKilosRealesTotal:= 0;
end;

procedure TQLResumenEntregasMaset.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + Value;
end;

procedure TQLResumenEntregasMaset.kilos_reales_elPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', ( 1 - ( rSobrepeso / 100 ) ) * QListado.fieldbyname('kilos_destarados_el').AsFloat );
end;

procedure TQLResumenEntregasMaset.QRLabel11Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rKilosRealesAlm );
end;

procedure TQLResumenEntregasMaset.QRLabel15Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rKilosRealesCos );
end;

procedure TQLResumenEntregasMaset.QRLabel16Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rKilosRealesTotal );
end;

procedure TQLResumenEntregasMaset.desAlmacenPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProveedorAlmacen( DataSet.fieldByName('empresa_ec').AsString,
                               DataSet.fieldByName('proveedor_ec').AsString, Value );
end;

end.
