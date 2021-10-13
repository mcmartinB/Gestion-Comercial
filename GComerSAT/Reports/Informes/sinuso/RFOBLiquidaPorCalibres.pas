unit RFOBLiquidaPorCalibres;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TQRFOBLiquidaPorCalibres = class(TQuickRep)
    Query: TQuery;
    bndCabCategoria: TQRGroup;
    bndPieCategoria: TQRBand;
    bndDetalle: TQRBand;
    categoria: TQRExpr;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
    QRExpr8: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    SummaryBand1: TQRBand;
    QRShape1: TQRShape;
    QRLabel9: TQRLabel;
    QRExpr4: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr16: TQRExpr;
    QRExpr17: TQRExpr;
    QRExpr18: TQRExpr;
    ChildBand1: TQRChildBand;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
    PageHeaderBand1: TQRBand;
    lblProducto: TQRLabel;
    lblCentro: TQRLabel;
    QRSysData2: TQRSysData;
    lblPeriodo: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel10: TQRLabel;
    procedure QRExpr8Print(sender: TObject; var Value: string);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRExpr15Print(sender: TObject; var Value: string);
  private

  public
    constructor Create(AOwner: TComponent); override;

    procedure ConfigTitulo(const AEmpresa, ACentro, AProducto, ADesde, AHasta: string);
  end;

implementation

{$R *.DFM}

uses UDMAuxDB, CReportes;

constructor TQRFOBLiquidaPorCalibres.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Query.SQL.Add('select tempresa_sr empresa, tproducto_sr producto,');
  Query.SQL.Add('       tcategoria_sr categoria, tcalibre_sr calibre, ');
  Query.SQL.Add('       round(sum(timporte_linea_sr * tcambio_sr),2) importe, ');
  Query.SQL.Add('       round(sum((tgasto_linea_sr + tcomision_linea_sr + tdescuento_linea_sr + tgasto_tenerife_sr )* tcambio_sr),2) gasto, ');
  Query.SQL.Add('       sum(tkilos_linea_sr) kilos ');
  Query.SQL.Add('from tmp_sal_resumen ');
  Query.SQL.Add('where tusuario_sr = :usuario ');
  Query.SQL.Add('group by 1,2,3,4 ');
  Query.SQL.Add('order by 1,2,3,4 ');
end;

procedure TQRFOBLiquidaPorCalibres.ConfigTitulo(const AEmpresa, ACentro, AProducto, ADesde, AHasta: string);
begin
  PonLogoGrupoBonnysa(self, AEmpresa);
  lblCentro.Caption := ACentro + ' - ' + desCentro(AEmpresa, ACentro);
  lblProducto.Caption := AProducto + ' - ' + desProducto(AEmpresa, AProducto);
  lblPeriodo.Caption := ADesde + ' - ' + AHasta;
end;

procedure TQRFOBLiquidaPorCalibres.QRExpr8Print(sender: TObject;
  var Value: string);
begin
  Value := desCategoria(DataSet.fieldByName('empresa').AsString,
    DataSet.fieldByName('producto').AsString, Value);
end;

procedure TQRFOBLiquidaPorCalibres.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  bndCabCategoria.Height := 0;
end;

procedure TQRFOBLiquidaPorCalibres.QRExpr15Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTAL CAT. ' + Value + ' - ' +
    desCategoria(DataSet.fieldByName('empresa').AsString,
    DataSet.fieldByName('producto').AsString, Value);
end;

end.

