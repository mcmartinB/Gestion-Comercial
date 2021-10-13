unit QLSalidasAlmacen;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, dbtables,
  LSalidasResumenForm, dialogs, db;

type
  TQRLSalidasAlmacen = class(TQuickRep)
    bndTitulo: TQRBand;
    QRLabelTitle: TQRLabel;
    QRSysData2: TQRSysData;
    bndDetallePais: TQRSubDetail;
    lblNomPais: TQRDBText;
    lblKilosCat1Pais: TQRDBText;
    lblKilosCat2Pais: TQRDBText;
    lblKilosPais: TQRDBText;
    bndCabGrupoPais: TQRGroup;
    bndPieGrupoPais: TQRBand;
    etqTotalPais: TQRExpr;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    bndDetalleCalibre: TQRSubDetail;
    bndPieGrupoCalibre: TQRBand;
    bndCabCalibre: TQRBand;
    lblCodCalibre: TQRDBText;
    lblKilosCat1Calibre: TQRDBText;
    lblKilosCat2Calibre: TQRDBText;
    lblKilosCalibre: TQRDBText;
    QRLabel7: TQRLabel;
    lblAcumCat1Pais: TQRLabel;
    lblAcumCat2Pais: TQRLabel;
    lblAcumPais: TQRLabel;
    lblAcumCat1Calibre: TQRLabel;
    lblAcumCat2Calibre: TQRLabel;
    lblAcumCalibre: TQRLabel;
    bndCadGrupoCalibre: TQRGroup;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    lblTmp: TQRDBText;
    QRLabel8: TQRLabel;
    QRBand1: TQRBand;
    ChildBand1: TQRChildBand;
    lblTercera: TQRLabel;
    lblRetirada: TQRLabel;
    lblIndustria: TQRLabel;
    bndCabPais: TQRBand;
    QRLabel9: TQRLabel;
    ChildBand2: TQRChildBand;
    PsQRLabel1: TQRLabel;
    lblProducto: TQRLabel;
    lblPeriodo: TQRLabel;
    lblOrigen: TQRLabel;
    lblNumSemana: TQRLabel;
    lblSalida: TQRLabel;
    procedure etqTotalPaisPrint(sender: TObject; var Value: string);
    procedure bndCabGrupoPaisBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLSalidasAlmacenBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure lblKilosCat1PaisPrint(sender: TObject; var Value: string);
    procedure lblKilosCat2PaisPrint(sender: TObject; var Value: string);
    procedure lblKilosPaisPrint(sender: TObject; var Value: string);
    procedure lblAcumCat1PaisPrint(sender: TObject; var Value: string);
    procedure lblAcumCat2PaisPrint(sender: TObject; var Value: string);
    procedure lblAcumPaisPrint(sender: TObject; var Value: string);
    procedure lblKilosCat1CalibrePrint(sender: TObject; var Value: string);
    procedure lblKilosCat2CalibrePrint(sender: TObject; var Value: string);
    procedure lblKilosCalibrePrint(sender: TObject; var Value: string);
    procedure lblAcumCat1CalibrePrint(sender: TObject; var Value: string);
    procedure lblAcumCat2CalibrePrint(sender: TObject; var Value: string);
    procedure lblAcumCalibrePrint(sender: TObject; var Value: string);
    procedure lblTmpPrint(sender: TObject; var Value: string);
    procedure bndCadGrupoCalibreBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

    _acumCat1, _acumCat2, _acumTotal: Real;

    canPrintCabPais: Boolean;
    QGuiaPais, QCat1Pais, QCat2Pais: TQuery;
    DSPais: TDataSource;

    QGuiaCalibre, QCat1Calibre, QCat2Calibre: TQuery;
    DSCalibre: TDataSource;

  public
    empresa, producto: string;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  QRLSalidasAlmacen: TQRLSalidasAlmacen;

implementation

uses UDMAuxDB, bSQLUtils;

{$R *.DFM}

constructor TQRLSalidasAlmacen.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited;

  //Desglose por pais y categoria
  QGuiaPais := TQuery.Create(nil);
  QGuiaPais.DatabaseName := 'BDProyecto';
  QGuiaPais.SQL.Add(' SELECT descripcion_p nomPais, pais, SUM( kilos ) as kilos ' +
    ' FROM tmpSalidas, frf_paises ' +
    ' WHERE (categoria="1" OR categoria="2") ' +
    '   AND cliente <> "RET" ' +
    '   AND pais <> "1TR" ' + //IGNORAMOS LOS TRANSITOS
    '   AND pais_p = pais[2,3] ' +
    ' GROUP BY 1,2 ORDER BY 1 ');

  QGuiaPais.fielddefs.update;
  for i := 0 to QGuiaPais.fielddefs.count - 1 do QGuiaPais.fielddefs.AddFieldDef;
  bndDetallePais.DataSet := QGuiaPais;
  lblNomPais.DataSet := QGuiaPais;
  lblNomPais.DataField := 'nomPais';
  lblKilosPais.DataSet := QGuiaPais;
  lblKilosPais.DataField := 'kilos';

  QCat1Pais := TQuery.Create(nil);
  QCat1Pais.DatabaseName := 'BDProyecto';
  QCat1Pais.SQL.Add(' SELECT pais, SUM( kilos ) as kilos FROM tmpSalidas ' +
    ' WHERE pais = :pais ' +
    '   AND categoria ' + SQLEqualS('1') +
    '   AND cliente ' + SQLEqualS('RET', '<>') +
    ' GROUP BY pais ORDER BY pais ');
  lblKilosCat1Pais.DataSet := QCat1Pais;
  lblKilosCat1Pais.DataField := 'kilos';

  QCat2Pais := TQuery.Create(nil);
  QCat2Pais.DatabaseName := 'BDProyecto';
  QCat2Pais.SQL.Add(' SELECT pais, SUM( kilos ) as kilos FROM tmpSalidas ' +
    ' WHERE pais = :pais ' +
    '   AND categoria ' + SQLEqualS('2') +
    '   AND cliente ' + SQLEqualS('RET', '<>') +
    ' GROUP BY pais ORDER BY pais');
  lblKilosCat2Pais.DataSet := QCat2Pais;
  lblKilosCat2Pais.DataField := 'kilos';

  DSPais := TDataSource.Create(nil);
  DSPais.DataSet := QGuiaPais;
  QCat1Pais.DataSource := DSPais;
  QCat2Pais.DataSource := DSPais;


  //Desglose por calibre
  QGuiaCalibre := TQuery.Create(nil);
  QGuiaCalibre.DatabaseName := 'BDProyecto';
  QGuiaCalibre.SQL.Add(' SELECT calibre, pais[1,1] grupo, SUM( kilos ) kilos ' +
    ' FROM tmpSalidas ' +
    ' WHERE (categoria="1" OR categoria="2") ' +
    '   AND cliente <> "RET" ' +
    ' GROUP BY 1,2 ORDER BY 2,1');
  bndDetalleCalibre.DataSet := QGuiaCalibre;
  lblCodCalibre.DataSet := QGuiaCalibre;
  lblCodCalibre.DataField := 'calibre';
  lblKilosCalibre.DataSet := QGuiaCalibre;
  lblKilosCalibre.DataField := 'kilos';
  lblTmp.DataSet := QGuiaCalibre;
  lblTmp.DataField := 'grupo';

  QCat1Calibre := TQuery.Create(nil);
  QCat1Calibre.DatabaseName := 'BDProyecto';
  QCat1Calibre.SQL.Add(' SELECT calibre, pais[1,1] grupo, SUM( kilos ) kilos ' +
    ' FROM tmpSalidas ' +
    ' WHERE calibre = :calibre ' +
    '   AND pais[1,1] = :grupo ' +
    '   AND categoria  ' + SQLEqualS('1') +
    '   AND cliente ' + SQLEqualS('RET', '<>') +
    ' GROUP BY 1,2 ORDER BY 2,1');
  lblKilosCat1Calibre.DataSet := QCat1Calibre;
  lblKilosCat1Calibre.DataField := 'kilos';

  QCat2Calibre := TQuery.Create(nil);
  QCat2Calibre.DatabaseName := 'BDProyecto';
  QCat2Calibre.SQL.Add(' SELECT calibre, pais[1,1] grupo, SUM( kilos ) kilos ' +
    ' FROM tmpSalidas ' +
    ' WHERE calibre = :calibre ' +
    '   AND pais[1,1] = :grupo ' +
    '   AND categoria = "2" ' +
    '   AND cliente <> "RET" ' +
    ' GROUP BY 1,2 ORDER BY 2,1');
  lblKilosCat2Calibre.DataSet := QCat2Calibre;
  lblKilosCat2Calibre.DataField := 'kilos';

  DSCalibre := TDataSource.Create(nil);
  DSCalibre.DataSet := QGuiaCalibre;
  QCat1Calibre.DataSource := DSCalibre;
  QCat2Calibre.DataSource := DSCalibre;

  //Desglose por pais y categoria
  QGuiaPais.Open;
  QCat1Pais.Open;
  QCat2Pais.Open;

  //Desglose por calibre
  QGuiaCalibre.Open;
  QCat1Calibre.Open;
  QCat2Calibre.Open;
end;

destructor TQRLSalidasAlmacen.Destroy;
begin
  QGuiaPais.Close;
  QCat1Pais.Close;
  QCat2Pais.Close;

  QGuiaCalibre.Close;
  QCat1Calibre.Close;
  QCat2Calibre.Close;

  QGuiaPais.Free;
  QCat1Pais.Free;
  QCat2Pais.Free;
  DSPais.Free;

  QGuiaCalibre.Free;
  QCat1Calibre.Free;
  QCat2Calibre.Free;
  DSCalibre.Free;

  inherited;
end;



procedure TQRLSalidasAlmacen.etqTotalPaisPrint(sender: TObject;
  var Value: string);
var
  cod: string;
begin
  cod := Copy(Value, 1, 1);

  if cod = '0' then
    Value := 'TOTAL'
  else
    VAlue := 'SALIDAS + TRANSITOS';
end;

procedure TQRLSalidasAlmacen.QRLSalidasAlmacenBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  canPrintCabPais := true;

  _acumCat1 := 0;
  _acumCat2 := 0;
  _acumTotal := 0;
end;

procedure TQRLSalidasAlmacen.bndCabGrupoPaisBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := canPrintCabPais;
  if canPrintCabPais then canPrintCabPais := false;
end;

procedure TQRLSalidasAlmacen.lblKilosCat1PaisPrint(sender: TObject;
  var Value: string);
var
  aux: Real;
begin
  aux := StrToFloat(Value);
  _acumCat1 := _acumCat1 + aux;
  Value := FormatFloat('#,##0.00', aux);
end;

procedure TQRLSalidasAlmacen.lblKilosCat2PaisPrint(sender: TObject;
  var Value: string);
var
  aux: Real;
begin
  aux := StrToFloat(Value);
  _acumCat2 := _acumCat2 + aux;
  Value := FormatFloat('#,##0.00', aux);
end;

procedure TQRLSalidasAlmacen.lblKilosPaisPrint(sender: TObject;
  var Value: string);
var
  aux: Real;
begin
  aux := StrToFloat(Value);
  _acumTotal := _acumTotal + aux;
  Value := FormatFloat('#,##0.00', aux);
end;

procedure TQRLSalidasAlmacen.lblAcumCat1PaisPrint(sender: TObject;
  var Value: string);
begin
  if _acumCat1 <> 0 then
    Value := FormatFloat('#,##0.00', _acumCat1)
  else
    Value := '';
end;

procedure TQRLSalidasAlmacen.lblAcumCat2PaisPrint(sender: TObject;
  var Value: string);
begin
  if _acumCat2 <> 0 then
    Value := FormatFloat('#,##0.00', _acumCat2)
  else
    Value := '';
end;

procedure TQRLSalidasAlmacen.lblAcumPaisPrint(sender: TObject;
  var Value: string);
begin
  if _acumTotal <> 0 then
    Value := FormatFloat('#,##0.00', _acumTotal)
  else
    Value := '';
end;

procedure TQRLSalidasAlmacen.bndCadGrupoCalibreBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  _acumCat1 := 0;
  _acumCat2 := 0;
  _acumTotal := 0;
end;

procedure TQRLSalidasAlmacen.lblKilosCat1CalibrePrint(sender: TObject;
  var Value: string);
var
  aux: Real;
begin
  aux := StrToFloat(Value);
  _acumCat1 := _acumCat1 + aux;
  Value := FormatFloat('#,##0.00', aux);
end;

procedure TQRLSalidasAlmacen.lblKilosCat2CalibrePrint(sender: TObject;
  var Value: string);
var
  aux: Real;
begin
  aux := StrToFloat(Value);
  _acumCat2 := _acumCat2 + aux;
  Value := FormatFloat('#,##0.00', aux);
end;

procedure TQRLSalidasAlmacen.lblKilosCalibrePrint(sender: TObject;
  var Value: string);
var
  aux: Real;
begin
  aux := StrToFloat(Value);
  _acumTotal := _acumTotal + aux;
  Value := FormatFloat('#,##0.00', aux);
end;

procedure TQRLSalidasAlmacen.lblAcumCat1CalibrePrint(sender: TObject;
  var Value: string);
begin
  if _acumCat1 <> 0 then
    Value := FormatFloat('#,##0.00', _acumCat1)
  else
    Value := '';
end;

procedure TQRLSalidasAlmacen.lblAcumCat2CalibrePrint(sender: TObject;
  var Value: string);
begin
  if _acumCat2 <> 0 then
    Value := FormatFloat('#,##0.00', _acumCat2)
  else
    Value := '';
end;

procedure TQRLSalidasAlmacen.lblAcumCalibrePrint(sender: TObject;
  var Value: string);
begin
  if _acumCat2 <> 0 then
    Value := FormatFloat('#,##0.00', _acumTotal)
  else
    Value := '';
end;

procedure TQRLSalidasAlmacen.lblTmpPrint(sender: TObject;
  var Value: string);
begin
  if Value = '0' then
    Value := 'SALIDAS'
  else
    if Value = '1' then
      Value := 'TRÁNSITOS'
    else
      Value := 'DESCONOCIDO';
end;

end.
