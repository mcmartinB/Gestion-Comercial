unit RecadvQM;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQMRecadv = class(TQuickRep)
    QRBand1: TQRBand;
    fecha: TQRSysData;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    bndDetalle: TQRBand;
    QRGroup1: TQRGroup;
    QRExpr5: TQRExpr;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRGroup2: TQRGroup;
    QRExpr6: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr10: TQRExpr;
    n_palets_pie: TQRExpr;
    QRExpr1: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    ChildBand2: TQRChildBand;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel15: TQRLabel;
    procedure QRExpr5Print(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRExpr7Print(sender: TObject; var Value: String);
    procedure QRExpr4Print(sender: TObject; var Value: String);
    procedure QRExpr11Print(sender: TObject; var Value: String);
    procedure QRExpr12Print(sender: TObject; var Value: String);
    procedure QRExpr15Print(sender: TObject; var Value: String);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
    bDetalle: Boolean;
  public

  end;

procedure VisualizarListado(const AOwner: TComponent; const ADetalle: Boolean);

implementation

uses UDMAuxDB, RecadvDM;

{$R *.DFM}

var
  QMRecadv: TQMRecadv;

procedure VisualizarListado(const AOwner: TComponent; const ADetalle: Boolean);
begin
  QMRecadv := TQMRecadv.Create(AOwner);
  try
    QMRecadv.bDetalle:= ADetalle;
    QMRecadv.Preview;
  finally
    FreeAndNil(QMRecadv);
  end;
end;

procedure TQMRecadv.QRExpr5Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desEmpresa( Value );
end;

procedure TQMRecadv.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  Value:= Value  + ' ' +  desProductoBase( DataSet.FieldByName('empresa_f').AsString, Value);
end;

procedure TQMRecadv.QRExpr7Print(sender: TObject;
  var Value: String);
begin
  Value:= Value  + ' ' +  desTipoPalet( Value );
end;

procedure TQMRecadv.QRExpr4Print(sender: TObject;
  var Value: String);
begin
  Value:= Value  + ' ' +  desEnvaseProducto( DataSet.FieldByName('empresa_f').AsString, Value, DataSet.FieldByName('productop_f').AsString);
end;

procedure TQMRecadv.QRExpr11Print(sender: TObject;
  var Value: String);
begin
  Value:= Value  + ' ' +  desCliente( Value);
end;

procedure TQMRecadv.QRExpr12Print(sender: TObject;
  var Value: String);
begin
  Value:= Value  + ' ' +  desSuministro(
    DataSet.FieldByName('empresa_f').AsString,
    DataSet.FieldByName('cliente_fc').AsString, Value);
end;

procedure TQMRecadv.QRExpr15Print(sender: TObject;
  var Value: String);
begin
  if Value = 'C' then
    Value:= Value + ' Cajas'
  else
  if Value = 'U' then
    Value:= Value + ' Unidades'
  else
    Value:= Value + ' Kilos';
end;

procedure TQMRecadv.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= ( DataSet.FieldByName('formato_cliente_fc').AsString <> '' ) and bDetalle;
end;

procedure TQMRecadv.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= ( DataSet.FieldByName('formato_cliente_fc').AsString <> '' ) and bDetalle;
end;

end.
