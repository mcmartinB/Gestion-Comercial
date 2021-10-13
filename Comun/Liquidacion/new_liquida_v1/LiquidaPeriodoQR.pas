unit LiquidaPeriodoQR;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, grimgctrl;
type
  TQRLiquidaPeriodo = class(TQuickRep)
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrlbl3: TQRLabel;
    qrlblPsQRLabel1: TQRLabel;
    qrlblPsQRLabel2: TQRLabel;
    qrlbl4: TQRLabel;
    qrdbtxtprecioLiquidar: TQRDBText;
    qrdbtxtimporteLiquidar: TQRDBText;
    qrdbtxtkilos_in: TQRDBText;
    qrdbtxtpoblacion_b: TQRDBText;
    qrdbtxtkilos_out1: TQRDBText;
    qrdbtxtkilos_out2: TQRDBText;
    qrdbtxtkilos_out3: TQRDBText;
    qrgrpCosechero: TQRGroup;
    qrgrpPlantacion: TQRGroup;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrdbtxtanyosemana1: TQRDBText;
    qrdbtxtplantacion: TQRDBText;
    qrdbtxtplantacion1: TQRDBText;
    qrbndPieCosechero: TQRBand;
    qrbndPiePlantacion: TQRBand;
    qrlbl6: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrlbl7: TQRLabel;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrpdfshp2: TQRPDFShape;
    qrpdfshp3: TQRPDFShape;
    bndcChildBand2: TQRChildBand;
    qrdbtxtanyosemana: TQRDBText;
    qrdbtxtcosechero: TQRDBText;
    qrlblPeriodo: TQRLabel;
    procedure qrdbtxtplantacion1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcosecheroPrint(sender: TObject; var Value: String);
    procedure qrlbl7Print(sender: TObject; var Value: String);
    procedure qrlbl6Print(sender: TObject; var Value: String);
    procedure qrgrpCosecheroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtkilos_out1Print(sender: TObject; var Value: String);
    procedure qrdbtxtkilos_out2Print(sender: TObject; var Value: String);
    procedure qrdbtxtkilos_out3Print(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLiquidaPeriodo: TQRLiquidaPeriodo;

implementation

uses
  LiquidaPeriodoDM, UDMAuxDB;

{$R *.DFM}

(*
  kmtLiquidacion.FieldDefs.Add('lunes', ftDate, 0, False);
  kmtLiquidacion.FieldDefs.Add('domingo', ftDate, 0, False);
*)


procedure TQRLiquidaPeriodo.qrdbtxtplantacion1Print(
  sender: TObject; var Value: String);
begin
  Value:= desPlantacion( DataSet.FieldByName('empresa').AsString,
                           DataSet.FieldByName('producto').AsString,
                           DataSet.FieldByName('cosechero').AsString,
                           DataSet.FieldByName('plantacion').AsString,
                           DataSet.FieldByName('anyosemanaplanta').AsString);
end;

procedure TQRLiquidaPeriodo.qrdbtxtcosecheroPrint(
  sender: TObject; var Value: String);
begin
  Value:= desCosechero( DataSet.FieldByName('empresa').AsString,
                        DataSet.FieldByName('cosechero').AsString);
end;

procedure TQRLiquidaPeriodo.qrlbl7Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL PLANT. ' +  DataSet.FieldByName('cosechero').AsString + '-' +
                        DataSet.FieldByName('plantacion').AsString;
end;

procedure TQRLiquidaPeriodo.qrlbl6Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL COS.' +  DataSet.FieldByName('cosechero').AsString + '-' +
                        desCosechero( DataSet.FieldByName('empresa').AsString,
                                       DataSet.FieldByName('cosechero').AsString);
end;

procedure TQRLiquidaPeriodo.qrgrpCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrgrpCosechero.Height:= 0;
end;

procedure TQRLiquidaPeriodo.qrdbtxtkilos_out1Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desEmpresa( Value );
end;

procedure TQRLiquidaPeriodo.qrdbtxtkilos_out2Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + descentro( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiquidaPeriodo.qrdbtxtkilos_out3Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

end.
