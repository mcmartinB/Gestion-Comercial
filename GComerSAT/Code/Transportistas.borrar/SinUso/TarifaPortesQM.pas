unit TarifaPortesQM;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQMTarifaPortes = class(TQuickRep)
    QRBand1: TQRBand;
    fecha: TQRSysData;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    LEmpresa: TQRLabel;
    bndDetalle: TQRBand;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr1: TQRExpr;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel3: TQRLabel;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRExpr3Print(sender: TObject; var Value: String);
    procedure QRExpr4Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr6Print(sender: TObject; var Value: String);
    procedure QRExpr8Print(sender: TObject; var Value: String);
    procedure QRExpr5Print(sender: TObject; var Value: String);
  private
    empresa, transporte, cliente: string;
    bEmpresa, bTransporte, bCliente: Boolean;
  public

  end;

var
  QMTarifaPortes: TQMTarifaPortes;

implementation

uses UDMAuxDB, TarifaPortesDM;

{$R *.DFM}

procedure TQMTarifaPortes.QRSysData1Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQMTarifaPortes.QRExpr3Print(sender: TObject; var Value: String);
begin
  if not bTransporte then
    Value:= ''
  else
    Value:= desTransporte( DataSet.FieldByName('empresa_csp').AsString, Value );
end;

procedure TQMTarifaPortes.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  empresa:= '';
  transporte:= '';
  cliente:= '';
end;

procedure TQMTarifaPortes.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if empresa <> DataSet.FieldByName('empresa_csp').AsString then
  begin
    bEmpresa:= True;
    empresa:= DataSet.FieldByName('empresa_csp').AsString;
  end
  else
  begin
    bEmpresa:= False;
  end;

  if transporte <> empresa + DataSet.FieldByName('transporte_csp').AsString then
  begin
    bTransporte:= True;
    transporte:= empresa + DataSet.FieldByName('transporte_csp').AsString;
    bndDetalle.Color:= clSilver;
  end
  else
  begin
    bTransporte:= False;
    bndDetalle.Color:= clWhite;
  end;

  if cliente <> transporte + DataSet.FieldByName('cliente_csp').AsString then
  begin
    bcliente:= True;
    cliente:= transporte + DataSet.FieldByName('cliente_csp').AsString;
  end
  else
  begin
    bcliente:= False;
  end;
end;

procedure TQMTarifaPortes.QRExpr6Print(sender: TObject; var Value: String);
begin
  if not bTransporte then
    Value:= '';
end;

procedure TQMTarifaPortes.QRExpr8Print(sender: TObject; var Value: String);
begin
if not bCliente then
    Value:= '';
end;

procedure TQMTarifaPortes.QRExpr5Print(sender: TObject; var Value: String);
begin
if not bEmpresa then
    Value:= '';
end;

procedure TQMTarifaPortes.QRExpr4Print(sender: TObject; var Value: String);
begin
  Value:= desSuministro( DataSet.FieldByName('empresa_csp').AsString,
    DataSet.FieldByName('cliente_csp').AsString, Value );
  if Trim(Value) = '' then
    Value:= desCliente( DataSet.FieldByName('empresa_csp').AsString,
      DataSet.FieldByName('dir_sum_csp').AsString );
  if Trim(Value) = '' then
    Value:= '>>(SUM.ERRONEO)<<';
end;

end.
