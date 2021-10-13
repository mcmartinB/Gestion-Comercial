unit ResumenEntregasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLResumenEntregas = class(TQuickRep)
    QRBCabecera: TQRBand;
    QRBDetalle: TQRBand;
    QRBSumario: TQRBand;
    QRBGrupo: TQRGroup;
    QRLabel6: TQRLabel;
    QRLCosechero: TQRLabel;
    QRLKilos: TQRLabel;
    QRLCajas: TQRLabel;
    proveedor_ec: TQRDBText;
    desAlmacen: TQRDBText;
    QRDBTCajas: TQRDBText;
    QRDBTKilos: TQRDBText;
    QRBTitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLDesde: TQRLabel;
    QRLHasta: TQRLabel;
    psAgrupacion: TQRLabel;
    QListado: TQuery;
    desProveedor: TQRDBText;
    almacen_ec: TQRDBText;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRBPieGrupo: TQRBand;
    QRLTotalParcial: TQRLabel;
    QRShape1: TQRShape;
    QRShape5: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel2: TQRLabel;
    palets_el: TQRDBText;
    QRShape2: TQRShape;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    psCentro: TQRLabel;
    QRLabel3: TQRLabel;
    entregas_ec: TQRDBText;
    QRShape3: TQRShape;
    QRExpr5: TQRExpr;
    QRExpr8: TQRExpr;
    psSemana: TQRLabel;
    aprovechados_el: TQRDBText;
    porcen_aprovechados_el: TQRDBText;
    lblAprovechados: TQRLabel;
    sepAprovechadosCos: TQRShape;
    sepPorcenAprovechadosCos: TQRShape;
    lAprovechadosCos: TQRLabel;
    lPorcenAprovechadosCos: TQRLabel;
    lAprovechadosTotal: TQRLabel;
    lPorcenAprovechadosTotal: TQRLabel;
    psProducto: TQRLabel;
    procedure QRLTotalParcialPrint(sender: TObject; var Value: String);
    procedure porcen_aprovechados_elPrint(sender: TObject;
      var Value: String);
    procedure aprovechados_elPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBPieGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBSumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    rKilosCos, rKilosTotal:Real;
    bFlagAprovechadosCos, bFlagAprovechadosTotal: Boolean;
    rAprovechadosCos, rAprovechadosTotal:Real;

  public
    procedure VerAprovechados( const AVer: Boolean );
  end;

var
  QLResumenEntregas: TQLResumenEntregas;

implementation

{$R *.DFM}


procedure TQLResumenEntregas.QRLTotalParcialPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'Total OPP/Proveedor ' + QListado.fieldbyname('proveedor_ec').AsString + ' ...'
end;

procedure TQLResumenEntregas.aprovechados_elPrint(sender: TObject;
  var Value: String);
begin
  if QListado.fieldbyname('aprovechados_el').AsString <> '' then
  begin
    Value:= FormatFloat( '#,##0.00', QListado.fieldbyname('aprovechados_el').AsFloat );
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLResumenEntregas.porcen_aprovechados_elPrint(sender: TObject;
  var Value: String);
begin
  if QListado.fieldbyname('aprovechados_el').AsString <> '' then
  begin
    if QListado.fieldbyname('kilos_el').AsFloat <> 0 then
    begin
      Value:= FormatFloat( '#,##0.00',
                ( ( QListado.fieldbyname('aprovechados_el').AsFloat * 100 ) /
                    QListado.fieldbyname('kilos_el').AsFloat ) );
    end
    else
    begin
      Value:= 'ERROR';
    end;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLResumenEntregas.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rKilosCos:= 0;
  rKilosTotal:= 0;
  bFlagAprovechadosCos:= False;
  bFlagAprovechadosTotal:= False;
  rAprovechadosCos:= 0;
  rAprovechadosTotal:= 0;
end;

procedure TQLResumenEntregas.QRBDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rKilosCos:= rKilosCos +  QListado.fieldbyname('kilos_el').AsFloat;
  rKilosTotal:= rKilosTotal +  QListado.fieldbyname('kilos_el').AsFloat;

  if QListado.fieldbyname('aprovechados_el').AsString <> '' then
  begin
    if not bFlagAprovechadosCos then
      bFlagAprovechadosCos:= True;
    if not bFlagAprovechadosTotal then
      bFlagAprovechadosTotal:= True;
    rAprovechadosCos:= rAprovechadosCos + QListado.fieldbyname('aprovechados_el').AsFloat;
    rAprovechadosTotal:= rAprovechadosTotal +  QListado.fieldbyname('aprovechados_el').AsFloat;
  end;
end;

procedure TQLResumenEntregas.QRBPieGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bFlagAprovechadosCos then
  begin
    lAprovechadosCos.Caption:= FormatFloat( '#,##0.00', rAprovechadosCos );
    if rKilosCos <> 0 then
    begin
      lPorcenAprovechadosCos.Caption:= FormatFloat( '#,##0.00', ( rAprovechadosCos * 100 ) / rKilosCos );
    end
    else
    begin
      lPorcenAprovechadosCos.Caption:= 'ERROR';
    end;
  end
  else
  begin
    lAprovechadosCos.Caption:= '';
    lPorcenAprovechadosCos.Caption:= '';
  end;

  rKilosCos:= 0;
  bFlagAprovechadosCos:= False;
  rAprovechadosCos:= 0;
end;

procedure TQLResumenEntregas.QRBSumarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bFlagAprovechadosTotal then
  begin
    lAprovechadosTotal.Caption:= FormatFloat( '#,##0.00', rAprovechadosTotal );
    if rKilosTotal <> 0 then
    begin
      lPorcenAprovechadosTotal.Caption:= FormatFloat( '#,##0.00', ( rAprovechadosTotal * 100 ) / rKilosTotal );
    end
    else
    begin
      lPorcenAprovechadosTotal.Caption:= 'ERROR';
    end;
  end
  else
  begin
    lAprovechadosTotal.Caption:= '';
    lPorcenAprovechadosTotal.Caption:= '';
  end;

  rKilosTotal:= 0;
  bFlagAprovechadosTotal:= False;
  rAprovechadosTotal:= 0;
end;

procedure TQLResumenEntregas.VerAprovechados( const AVer: Boolean );
begin
  lblAprovechados.Enabled:= AVer;
  aprovechados_el.Enabled:= AVer;
  porcen_aprovechados_el.Enabled:= AVer;
  lAprovechadosCos.Enabled:= AVer;
  lPorcenAprovechadosCos.Enabled:= AVer;
  sepAprovechadosCos.Enabled:= AVer;
  sepPorcenAprovechadosCos.Enabled:= AVer;
  lAprovechadosTotal.Enabled:= AVer;
  lPorcenAprovechadosTotal.Enabled:= AVer;
end;

end.
