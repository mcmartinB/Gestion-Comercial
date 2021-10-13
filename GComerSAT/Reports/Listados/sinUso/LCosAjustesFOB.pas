unit LCosAjustesFOB;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;
type
  TQRLCosAjustesFOB = class(TQuickRep)
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QListado: TQuery;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRGroup1: TQRGroup;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRExpr5Print(sender: TObject; var Value: string);
    procedure QRExpr6Print(sender: TObject; var Value: string);
    procedure QRExpr8Print(sender: TObject; var Value: string);
  private

  public
    destructor Destroy; override;
  end;

var
  QRLCosAjustesFOB: TQRLCosAjustesFOB;

implementation

{$R *.DFM}

uses UDMAuxDB;

procedure TQRLCosAjustesFOB.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

destructor TQRLCosAjustesFOB.Destroy;
begin
  if QListado.Active then QListado.Close;
  inherited;
end;

procedure TQRLCosAjustesFOB.QRExpr5Print(sender: TObject;
  var Value: string);
begin
  Value := Trim(desEmpresa(Value));
end;

procedure TQRLCosAjustesFOB.QRExpr6Print(sender: TObject;
  var Value: string);
begin
  Value := Trim(desCosechero(DataSet.fieldByName('empresa_caf').AsString, Value));
end;

procedure TQRLCosAjustesFOB.QRExpr8Print(sender: TObject;
  var Value: string);
begin
  Value := Trim(desProducto(DataSet.fieldByName('empresa_caf').AsString, Value));
end;

end.
