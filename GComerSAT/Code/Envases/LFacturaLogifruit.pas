unit LFacturaLogifruit;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLFacturaLogifruit = class(TQuickRep)
    TitleBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblPeriodo: TQRLabel;
    qrdbtxtoperador: TQRDBText;
    bndCabDetalle: TQRGroup;
    qrbndDetailBand1: TQRBand;
    qrdbtxtcantidad1: TQRDBText;
    qrdbtxtcantidad2: TQRDBText;
    qrdbtxtenv_0618: TQRDBText;
    qrdbtxtenv_3416: TQRDBText;
    qrdbtxtenv_6412: TQRDBText;
    qrdbtxtenv_resto: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    qrdbtxtreferencia: TQRDBText;
    qrdbtxtoperador2: TQRDBText;
    qrdbtxtalmacen: TQRDBText;
    qrlbl2: TQRLabel;
    qrgrp1: TQRGroup;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    bndPieDetalle: TQRBand;
    qrlbl10: TQRLabel;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrdbtxtoperador1: TQRDBText;
    bndPieCadDetalle: TQRBand;
    qrlbl15: TQRLabel;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr13: TQRExpr;
    qrbndSummaryBand1: TQRBand;
    qrlbl1: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrxpr20: TQRExpr;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrshp1: TQRShape;
    qrshp2: TQRShape;
    qrshp3: TQRShape;
    qrshp4: TQRShape;
    procedure qrdbtxtoperador1Print(sender: TObject; var Value: String);
    procedure qrdbtxtoperadorPrint(sender: TObject; var Value: String);
    procedure qrdbtxtalmacenPrint(sender: TObject; var Value: String);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure qrlbl10Print(sender: TObject; var Value: String);
    procedure qrlbl15Print(sender: TObject; var Value: String);
  private

  public
    sEmpresa: string;

  end;

var
  QRLFacturaLogifruit: TQRLFacturaLogifruit;

implementation



uses LFFacturaLogifruit, UDMAuxDB, bTextUtils;

{$R *.DFM}

(*
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
  end;
*)

procedure TQRLFacturaLogifruit.qrdbtxtoperador1Print(
  sender: TObject; var Value: String);
begin
  Value:= desCentro( DataSet.FieldbyName('empresa').AsString, Value );
end;

procedure TQRLFacturaLogifruit.qrdbtxtoperadorPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' '  + desEnvComerOperador( Value );
end;

procedure TQRLFacturaLogifruit.qrdbtxtalmacenPrint(sender: TObject;
  var Value: String);
var
  sAux: string;
begin
  if DataSet.FieldbyName('tipo').AsString = '1' then
  begin
    Value:= Value + ' ' + desEnvComerAlmacen( DataSet.FieldbyName('cliente').AsString, Value );
  end
  else
  if DataSet.FieldbyName('tipo').AsString = '2' then
  begin
    sAux:= desSuministro( DataSet.FieldbyName('empresa').AsString, DataSet.FieldbyName('cliente').AsString, Value );
    if sAux <> '' then
    begin
      Value:= Value + ' '  + sAux;
    end
    else
    begin
      Value:= Value + ' '  + desCliente( Value );
    end;

  end;
end;

procedure TQRLFacturaLogifruit.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldbyName('tipo').AsString = '1' then
    Value:= 'NUESTRAS ENTREGAS'
  else
  if DataSet.FieldbyName('tipo').AsString = '2' then
    Value:= 'SUS ENTREGAS AL DISTRIBUIDOR';
end;

procedure TQRLFacturaLogifruit.qrlbl10Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ALMACÉN ' + DataSet.FieldbyName('cliente').AsString + '/' +
          DataSet.FieldbyName('almacen').AsString;
end;

procedure TQRLFacturaLogifruit.qrlbl15Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldbyName('tipo').AsString = '1' then
    Value:= 'NUESTRAS ENTREGAS ' + DataSet.FieldbyName('empresa').AsString + '/' + DataSet.FieldbyName('centro').AsString
  else
  if DataSet.FieldbyName('tipo').AsString = '2' then
    Value:= 'SUS ENTREGAS ' + DataSet.FieldbyName('empresa').AsString + '/' + DataSet.FieldbyName('centro').AsString;
end;

end.
