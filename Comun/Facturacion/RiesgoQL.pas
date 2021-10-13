unit RiesgoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,
  FacturacionCB;

type
  TQLRiesgo = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    bndDetalle: TQRBand;
    etqImpresoTitulo: TQRSysData;
    PageFooterBand1: TQRBand;
    QRSysData3: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    n_factura_sc: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel1: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel2: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel3: TQRLabel;
    etqPaisTitulo: TQRLabel;
    QRLabel6: TQRLabel;
    qrlTitulo: TQRLabel;
    qrlDesde: TQRLabel;
    qrlbl1: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr3: TQRExpr;
    qrxpr5: TQRExpr;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lblExcesoPrint(sender: TObject; var Value: String);
    procedure lblFaltaPrint(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
  private
    sEmpresa: String;
    rExceso: Real;
    bExceso: Boolean;
  public
    constructor Create( AOwner: TComponent ); Override;
    destructor Destroy; Override;
  end;

procedure ExecuteReport( APadre: TComponent; const AEmpresa, APais: string; const AFechaDesde: TDateTime );

implementation

{$R *.DFM}

uses Dialogs, RiesgoDL, UDMAuxDB, DPreview, CReportes;

var
  QLRiesgo: TQLRiesgo;


procedure ExecuteReport( APadre: TComponent; const AEmpresa, APais: string; const AFechaDesde: TDateTime );
begin
  QLRiesgo:= TQLRiesgo.Create( APadre );
  try
    QLRiesgo.sEmpresa:= AEmpresa;
    QLRiesgo.qrlTitulo.Caption:= 'RIESGO CLIENTE (' + DateToStr( Now ) + ')';
    QLRiesgo.ReportTitle:= 'RIESGO CLIENTE ' + FormatDateTime( 'yyyymmdd', Now );
    if APais <> '' then
      QLRiesgo.etqPaisTitulo.Caption:= APais + ' ' + DesPais( APais )
    else
      QLRiesgo.etqPaisTitulo.Caption:= '';
    QLRiesgo.qrlDesde.Caption:= 'Desde el ' + DateToStr( AFechaDesde );
    PonLogoGrupoBonnysa( QLRiesgo, AEmpresa );
    Previsualiza( QLRiesgo );
  except
    FreeAndNil( QLRiesgo );
  end;
end;

constructor TQLRiesgo.Create( AOwner: TComponent );
begin
  inherited;
  //BEGIN CODE

  //END CODE
end;

destructor TQLRiesgo.Destroy;
begin
  //BEGIN CODE

  //END CODE
  inherited;
end;

procedure TQLRiesgo.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if DataSet.FieldByName('clasificacion').AsString = '' then
  begin
    bExceso:= false;
    rExceso:= DataSet.FieldByName('riesgo').AsFloat;
  end
  else
  begin
    bExceso:= true;
    rExceso:= DataSet.FieldByName('riesgo').AsFloat - DataSet.FieldByName('clasificacion').AsFloat;
  end;
end;

procedure TQLRiesgo.lblExcesoPrint(sender: TObject;
  var Value: String);
begin
  if bExceso then
  begin
    if rExceso > 0 then
    begin
      Value:= FormatFloat('#,##0.00', rExceso );
    end
    else
    begin
      Value:= '';
    end;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLRiesgo.lblFaltaPrint(sender: TObject;
  var Value: String);
begin
  if bExceso then
  begin
    if rExceso <= 0 then
    begin
      Value:= FormatFloat('#,##0.00', rExceso * -1);
    end
    else
    begin
      Value:= '';
    end;
  end
  else
  begin
    Value:= FormatFloat('#,##0.00', rExceso);
  end;
end;

procedure TQLRiesgo.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('clasificacion').AsString = '' then
    Value:= '';
end;

end.
