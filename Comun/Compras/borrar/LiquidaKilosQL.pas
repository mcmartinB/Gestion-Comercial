unit LiquidaKilosQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLLiquidaKilos = class(TQuickRep)
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    qrlblTitulo: TQRLabel;
    QRBand1: TQRBand;
    qrdbtproveedor: TQRDBText;
    qrdbtxtproductor: TQRDBText;
    qrdbtxtnom_productor: TQRDBText;
    qrdbtxtentrega: TQRDBText;
    qrdbtxtcajas: TQRDBText;
    qrdbtxtkilos: TQRDBText;
    bndcChildBand1: TQRChildBand;
    qrlbl1: TQRLabel;
    qrlblProductor: TQRLabel;
    qrlblEntrega: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrgrpEmpresa: TQRGroup;
    qrdbtxtempresa_ec: TQRDBText;
    qrbndPieEmpresa: TQRBand;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrbndSummaryBand1: TQRBand;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrlbl6: TQRLabel;
    qrshp1: TQRShape;
    qrshp2: TQRShape;
    qrdbtxt1: TQRDBText;
    qrdbtxtkilos_almacen: TQRDBText;
    qrdbtxtcajas_rf: TQRDBText;
    qrdbtxtkilos_rf: TQRDBText;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrshp4: TQRShape;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrshpDiffKAlmacen: TQRShape;
    qrshpDiffRF: TQRShape;
    qrlbl3: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrshpDiffCAlmacen: TQRShape;
    qrlblVentas1: TQRLabel;
    qrlblVentas2: TQRLabel;
    qrbnd1: TQRBand;
    qrsysdt1: TQRSysData;
    qrgrpGrupo: TQRGroup;
    qrbndPieGrupo: TQRBand;
    qrshp3: TQRShape;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrshp5: TQRShape;
    bndcChildBand2: TQRChildBand;
    qrshpDiffKRF: TQRShape;
    qrdbtxtkilos_rf1: TQRDBText;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrpEmpresaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtnom_productorPrint(sender: TObject;
      var Value: String);
    procedure qrgrpGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtempresa_ecPrint(sender: TObject; var Value: String);

  private
     bPorCategoria, bDetalle: Boolean;

  public

  end;

  procedure PrevisualizarKilos( const AEmpresa, AProducto, ACategoria, AAnyoSemana, AEntrega: string; const APorCategoria, AVerEntrega: boolean );

implementation

{$R *.DFM}

uses LiquidaKilosDL, UDMAuxDB,  DPreview, CReportes;


procedure PrevisualizarKilos( const AEmpresa, AProducto, ACategoria, AAnyoSemana, AEntrega: string; const APorCategoria, AVerEntrega: boolean );
var
  QLLiquidaKilos: TQLLiquidaKilos;
begin
  QLLiquidaKilos := TQLLiquidaKilos.Create(Application);
  PonLogoGrupoBonnysa(QLLiquidaKilos, AEmpresa);
  if AEntrega <> '' then
  begin
    QLLiquidaKilos.qrlblTitulo.Caption:= 'KILOS LIQUIDACIÓN  - ENTREGA ' + AEntrega;
    QLLiquidaKilos.ReportTitle:= 'INCIDENCIAS_LIQUIDACION_PLATANO_ENTREGA_' + AEntrega;
  end
  else
  begin
    QLLiquidaKilos.qrlblTitulo.Caption:= 'KILOS LIQUIDACIÓN - SEMANA ' + AAnyoSemana;
    QLLiquidaKilos.ReportTitle:= 'KILOS_LIQUIDACION_SEMANA_' + AAnyoSemana;
  end;
  QLLiquidaKilos.qrlblEntrega.Enabled:= AVerEntrega;
  QLLiquidaKilos.qrdbtxtEntrega.Enabled:= AVerEntrega;

  QLLiquidaKilos.bPorCategoria:= APorCategoria;
  QLLiquidaKilos.bDetalle:= AVerEntrega;
  IF APorCategoria then
  begin
    QLLiquidaKilos.qrdbtproveedor.DataField:= 'categoria';
    QLLiquidaKilos.qrdbtxtproductor.DataField:= 'variedad';
    QLLiquidaKilos.qrdbtxtnom_productor.DataField:= 'categoria';

    QLLiquidaKilos.qrdbtxtproductor.Height:= 25;
    QLLiquidaKilos.qrdbtxtproductor.Left:= 82;
    QLLiquidaKilos.qrdbtxtnom_productor.Height:= 275;
    QLLiquidaKilos.qrdbtxtnom_productor.Left:= 111;

    QLLiquidaKilos.qrlblProductor.Caption:= 'Categoria/Variedad';
    QLLiquidaKilos.qrgrpGrupo.Expression:= '[empresa]+[categoria]';
  end
  else
  begin
    QLLiquidaKilos.qrdbtproveedor.DataField:= 'proveedor';
    QLLiquidaKilos.qrdbtxtproductor.DataField:= 'productor';
    QLLiquidaKilos.qrdbtxtnom_productor.DataField:= 'productor';

    QLLiquidaKilos.qrdbtxtproductor.Height:= 80;
    QLLiquidaKilos.qrdbtxtproductor.Left:= 82;
    QLLiquidaKilos.qrdbtxtnom_productor.Height:= 221;
    QLLiquidaKilos.qrdbtxtnom_productor.Left:= 165;

    QLLiquidaKilos.qrlblProductor.Caption:= 'Productor';
    QLLiquidaKilos.qrgrpGrupo.Expression:= '[empresa]+[proveedor]';
  end;
  Preview(QLLiquidaKilos);
end;

procedure TQLLiquidaKilos.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrshpDiffCAlmacen.Enabled:= ( DataSet.FieldByName('diff_calmacen').AsFloat <> 0 );
  qrshpDiffKAlmacen.Enabled:= ( DataSet.FieldByName('diff_kalmacen').AsFloat <> 0 );
  qrshpDiffKRF.Enabled:= False;
  //qrshpDiffKRF.Enabled:= ( DataSet.FieldByName('diff_krf').AsFloat <> 0 ) and
  //                      ( DataSet.FieldByName('almacen').AsFloat <> 0 );
  qrshpDiffRf.Enabled:= ( DataSet.FieldByName('diff_crf').AsFloat <> 0 ) and
                        ( DataSet.FieldByName('almacen').AsFloat <> 0 );
end;

procedure TQLLiquidaKilos.qrgrpEmpresaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrlblVentas1.Enabled:= DataSet.FieldByName('almacen').AsFloat = 0;
  qrlblVentas2.Enabled:= DataSet.FieldByName('almacen').AsFloat = 0;
end;

procedure TQLLiquidaKilos.qrdbtxtnom_productorPrint(sender: TObject;
  var Value: String);
begin
  if bPorCategoria then
  begin
    //Value:= desCategoria( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('producto').AsString, Value );
    Value:= DataSet.FieldByName('variedad').AsString + ' ' +
            desVariedad( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('proveedor').AsString,
                         DataSet.FieldByName('producto').AsString, DataSet.FieldByName('variedad').AsString );
  end
  else
  begin
    Value:= desProveedorAlmacen( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('proveedor').AsString, Value );
  end;
end;

procedure TQLLiquidaKilos.qrgrpGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgrpGrupo.Height:= 0;
end;

procedure TQLLiquidaKilos.qrbndPieGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bDetalle;
end;

procedure TQLLiquidaKilos.qrdbtxtempresa_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' '  + desEmpresa( Value );
end;

end.

