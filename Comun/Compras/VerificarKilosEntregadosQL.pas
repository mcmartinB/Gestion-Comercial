unit VerificarKilosEntregadosQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLVerificarKilosEntregados = class(TQuickRep)
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
    qrlblProveedor: TQRLabel;
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
    qrdbtxt1: TQRDBText;
    qrdbtxtkilos_almacen: TQRDBText;
    qrdbtxtcajas_rf: TQRDBText;
    qrdbtxtkilos_rf: TQRDBText;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
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
    qrlbl2: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrdbtxtkilos_rf2: TQRDBText;
    qrxpr19: TQRExpr;
    qrxpr20: TQRExpr;
    qrxpr21: TQRExpr;
    qrgrpAlmacen: TQRGroup;
    qrbndPieAlmacen: TQRBand;
    QRShape1: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRShape2: TQRShape;
    QRExpr7: TQRExpr;
    lblProveedor: TQRDBText;
    lblProductor: TQRDBText;
    qrdbtxtempresa: TQRDBText;
    qrdbtxtnom_categoria: TQRDBText;
    qrlblRango: TQRLabel;
    qrlblProductor: TQRLabel;
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
    procedure qrgrpAlmacenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtempresaPrint(sender: TObject; var Value: String);
    procedure qrdbtxtnom_categoriaPrint(sender: TObject; var Value: String);
    procedure qrbndPieAlmacenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieEmpresaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndcChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndSummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbnd1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
     bPorCategoria, bDetalle: Boolean;

  public

  end;

  procedure PrevisualizarKilos( const AEmpresa, AProducto, ACategoria: string; const ARango: Integer;
                                const AAnyoSemana, AEntrega: string; const AIni, AFin: TDateTime;
                                const APorCategoria, AVerEntrega: boolean );

implementation

{$R *.DFM}

uses VerificarKilosEntregadosDL, UDMAuxDB,  DPreview, CReportes;


procedure PrevisualizarKilos( const AEmpresa, AProducto, ACategoria: string; const ARango: Integer;
                                const AAnyoSemana, AEntrega: string; const AIni, AFin: TDateTime;
                                const APorCategoria, AVerEntrega: boolean );
var
  QLVerificarKilosEntregados: TQLVerificarKilosEntregados;
begin
  QLVerificarKilosEntregados := TQLVerificarKilosEntregados.Create(Application);
  PonLogoGrupoBonnysa(QLVerificarKilosEntregados, AEmpresa);

  if ARango = 0 then
  begin
    QLVerificarKilosEntregados.qrlblRango.Caption:= 'Año/Semana: ' + AAnyoSemana;
    QLVerificarKilosEntregados.ReportTitle:= 'VERIFICAR_ENTREGAS_ ' + AAnyoSemana;
  end
  else
  if ARango = 1 then
  begin
    QLVerificarKilosEntregados.qrlblRango.Caption:= 'Entrega: ' + AEntrega;
    QLVerificarKilosEntregados.ReportTitle:= 'VERIFICAR_ENTREGAS_' + AEntrega;
  end
  else
  if ARango = 2 then
  begin
    QLVerificarKilosEntregados.qrlblRango.Caption:= 'Entregas del ' + FormatDateTime('dd/mm/yyyy', Aini) + ' al ' + FormatDateTime('dd/mm/yyyy', AFin);
    QLVerificarKilosEntregados.ReportTitle:= 'VERIFICAR_ENTREGAS_' + FormatDateTime('ddmmyyyy', Aini) + '_' + FormatDateTime('ddmmyyyy', AFin);
  end;

   QLVerificarKilosEntregados.qrlblEntrega.Enabled:= AVerEntrega;
  QLVerificarKilosEntregados.qrdbtxtEntrega.Enabled:= AVerEntrega;

  QLVerificarKilosEntregados.bPorCategoria:= APorCategoria;
  QLVerificarKilosEntregados.bDetalle:= AVerEntrega;
  IF APorCategoria then
  begin
    QLVerificarKilosEntregados.qrdbtproveedor.DataField:= 'categoria';
    QLVerificarKilosEntregados.qrdbtxtnom_categoria.DataField:= 'categoria';
    QLVerificarKilosEntregados.qrdbtxtproductor.DataField:= 'variedad';
    QLVerificarKilosEntregados.qrdbtxtnom_productor.DataField:= 'variedad';

    QLVerificarKilosEntregados.qrlblProveedor.Caption:= 'Categoria';
    QLVerificarKilosEntregados.qrlblProductor.Caption:= 'Variedad';
    QLVerificarKilosEntregados.qrgrpGrupo.Expression:= '[empresa]+[producto]+[categoria]';
    QLVerificarKilosEntregados.qrgrpAlmacen.Expression:= '';
    QLVerificarKilosEntregados.qrgrpAlmacen.Enabled:= False;
    QLVerificarKilosEntregados.qrbndPieAlmacen.Enabled:= False;
    QLVerificarKilosEntregados.lblProveedor.Enabled:= False;
    QLVerificarKilosEntregados.lblProductor.Enabled:= False;
  end
  else
  begin
    QLVerificarKilosEntregados.qrdbtproveedor.DataField:= 'proveedor';
    QLVerificarKilosEntregados.qrdbtxtnom_categoria.DataField:= 'proveedor';
    QLVerificarKilosEntregados.qrdbtxtproductor.DataField:= 'productor';
    QLVerificarKilosEntregados.qrdbtxtnom_productor.DataField:= 'productor';

    QLVerificarKilosEntregados.qrlblProveedor.Caption:= 'Proveedor';
    QLVerificarKilosEntregados.qrlblProductor.Caption:= 'Productor';

    QLVerificarKilosEntregados.qrgrpGrupo.Expression:= '[empresa]+[producto]+[proveedor]';
    QLVerificarKilosEntregados.qrgrpAlmacen.Expression:= '[empresa]+[producto]+[proveedor]+[productor]';
    QLVerificarKilosEntregados.qrgrpAlmacen.Enabled:= True;
    QLVerificarKilosEntregados.qrbndPieAlmacen.Enabled:= True;
    QLVerificarKilosEntregados.lblProveedor.Enabled:= True;
    QLVerificarKilosEntregados.lblProductor.Enabled:= True;
  end;
  Preview(QLVerificarKilosEntregados);
end;

procedure TQLVerificarKilosEntregados.QRBand1BeforePrint(Sender: TQRCustomBand;
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

procedure TQLVerificarKilosEntregados.qrgrpEmpresaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrlblVentas1.Enabled:= DataSet.FieldByName('almacen').AsFloat = 0;
  qrlblVentas2.Enabled:= DataSet.FieldByName('almacen').AsFloat = 0;
end;

procedure TQLVerificarKilosEntregados.qrdbtxtnom_productorPrint(sender: TObject;
  var Value: String);
begin
  if bPorCategoria then
  begin
    Value:= desVariedad( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('proveedor').AsString,
                         DataSet.FieldByName('producto').AsString, DataSet.FieldByName('variedad').AsString );
  end
  else
  begin
    Value:= desProveedorAlmacen( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('proveedor').AsString, Value );
  end;
end;

procedure TQLVerificarKilosEntregados.qrgrpGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgrpGrupo.Height:= 0;
end;

procedure TQLVerificarKilosEntregados.qrbndPieGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bDetalle and not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLVerificarKilosEntregados.qrdbtxtempresa_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' '  + desEmpresa( Value );
end;

procedure TQLVerificarKilosEntregados.qrgrpAlmacenBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgrpAlmacen.Height:= 0;
end;

procedure TQLVerificarKilosEntregados.qrdbtxtempresaPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - '  + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQLVerificarKilosEntregados.qrdbtxtnom_categoriaPrint(
  sender: TObject; var Value: String);
begin
  if bPorCategoria then
  begin
    Value:= desCategoria( DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('producto').AsString, Value );
  end
  else
  begin
    Value:= desProveedor( DataSet.FieldByName('empresa').AsString, Value );
  end;
end;

procedure TQLVerificarKilosEntregados.qrbndPieAlmacenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) )
end;

procedure TQLVerificarKilosEntregados.qrbndPieEmpresaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) )
end;

procedure TQLVerificarKilosEntregados.bndcChildBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) )
end;

procedure TQLVerificarKilosEntregados.qrbndSummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) )
end;

procedure TQLVerificarKilosEntregados.qrbnd1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) )
end;

end.

