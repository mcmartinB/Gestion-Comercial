unit RResumenLiqCos;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils, Dialogs,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;
type
  TQRResumenLiqCos = class(TQuickRep)
    CabeceraPagina: TQRBand;
    PiePagina: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QResumenKilos: TQuery;
    QRLabel6: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRSubDetail2: TQRSubDetail;
    QRDBText20: TQRDBText;
    QRDBText21: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    QRDBText26: TQRDBText;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    lblCentro: TQRLabel;
    lblNomCentro: TQRLabel;
    lblProducto: TQRLabel;
    lblNomProducto: TQRLabel;
    lblPeriodo: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QResumenImportes: TQuery;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    PsQRLabel80: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    PsQRLabel81: TQRLabel;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRExpr15: TQRExpr;
    QRExpr16: TQRExpr;
    QRExpr17: TQRExpr;
    QRExpr18: TQRExpr;
    QRExpr19: TQRExpr;
    QRExpr20: TQRExpr;
    QRExpr21: TQRExpr;
    QRExpr22: TQRExpr;
    QRDBText27: TQRDBText;
    QRExpr23: TQRExpr;
    QRExpr24: TQRExpr;
    QRLabel5: TQRLabel;
    QRLabel10: TQRLabel;
    QRExpr25: TQRExpr;
    QRExpr26: TQRExpr;
    QRExpr27: TQRExpr;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel13: TQRLabel;
    QRLabel4: TQRLabel;
    QRExpr28: TQRExpr;
    QRExpr29: TQRExpr;
    QRExpr30: TQRExpr;

  private

  public
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;

  end;

var
  QRResumenLiqCos: TQRResumenLiqCos;

implementation

uses CAuxiliar, Principal, UDMAuxDB;

{$R *.DFM}

constructor TQRResumenLiqCos.Create(AOwner: TComponent);
var
  a,b,c: boolean;
begin
  inherited;
  with QResumenImportes do
  begin
    DataBaseName := 'BDProyecto';
    SQL.Clear;
    SQl.add(' select * from tmp_resum_liqui order by cod ');
    Open;
  end;
  with QResumenKilos do
  begin
    DataBaseName := 'BDProyecto';
    SQL.Clear;
    SQl.add(' select * from tmp_resum_liqui order by cod ');
    Open;
  end;
end;

destructor TQRResumenLiqCos.Destroy;
begin
  QResumenImportes.Close;
  QResumenKilos.Close;
  inherited;
end;

end.

