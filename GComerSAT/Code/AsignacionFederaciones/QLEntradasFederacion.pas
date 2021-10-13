unit QLEntradasFederacion;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLLEntradasFederacion = class(TQuickRep)
    cabecera: TQRBand;
    detalle: TQRBand;
    pie: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    QRGroup1: TQRGroup;
    QRExpr1: TQRExpr;
    lblFecha: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr6: TQRExpr;
    QRBand2: TQRBand;
    QRExpr8: TQRExpr;
    QRLabel1: TQRLabel;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRGroup2: TQRGroup;
    QRExpr11: TQRExpr;
    QRBand3: TQRBand;
    QRShape3: TQRShape;
    QRExpr5: TQRExpr;
    QRLabel6: TQRLabel;
    QRMemo: TQRMemo;
    lblCentro: TQRLabel;
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRExpr3Print(sender: TObject; var Value: String);
    procedure QRExpr11Print(sender: TObject; var Value: String);
    procedure QRLabel6Print(sender: TObject; var Value: String);
    procedure QRLabel1Print(sender: TObject; var Value: String);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    provincia: string;
    fecha: string;
  end;

var
  QRLLEntradasFederacion: TQRLLEntradasFederacion;

implementation

uses UDMAuxDB, DLEntradasFederacion, kbmMemTable, DB, bTextUtils;

{$R *.DFM}

procedure TQRLLEntradasFederacion.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  Value:=  Value + ' ' + desProducto( DataSet.FieldByName('empresa_p').AsString, Value );
end;

procedure TQRLLEntradasFederacion.QRExpr11Print(sender: TObject;
  var Value: String);
begin
  Value:=  Value + ' ' + desFederacion( Value );
end;

procedure TQRLLEntradasFederacion.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  Value:=  desCosechero( DataSet.FieldByName('empresa_p').AsString, Value );
end;

procedure TQRLLEntradasFederacion.QRExpr3Print(sender: TObject;
  var Value: String);
begin
  Value:=  desPlantacion( DataSet.FieldByName('empresa_p').AsString,
                                        DataSet.FieldByName('producto_p').AsString,
                                        DataSet.FieldByName('cosechero_p').AsString,
                                        Value, DataSet.FieldByName('ano_semana_p').AsString );
end;

procedure TQRLLEntradasFederacion.QRLabel6Print(sender: TObject;
  var Value: String);
begin
  Value:= DataSet.FieldByName('producto_p').AsString +
          ': TOTAL FEDERACIÓN ' +
          DataSet.FieldByName('federacion_p').AsString;
end;

procedure TQRLLEntradasFederacion.QRLabel1Print(sender: TObject;
  var Value: String);
begin
  Value:= DataSet.FieldByName('producto_p').AsString +
          ': TOTAL PRODUCTO ';
end;

procedure TQRLLEntradasFederacion.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  sProducto: string;
begin
  with DMLEntradasFederacion.mtResumen do
  begin
    Filter:= 'producto = ' + QuotedStr( DataSet.FieldByName('producto_p').AsString );
    Filtered:= True;
    if not IsEmpty then
    begin
      PrintBand:= True;
      QRMemo.Lines.Clear;
      QRMemo.Lines.Add( 'FEDERACIÓN    KILOS      %' );
      QRMemo.Lines.Add( '--------------------------' );

      First;
      while not EOF do
      begin
        ;
        QRMemo.Lines.Add( Rellena( FieldByName('federacion').AsString, 4, ' ', taRightJustify ) + ' ' +
                          Rellena( FormatFloat('#,##0.00', FieldByName('kilos').AsFloat ), 14, ' ', taLeftJustify ) + ' ' +
                          Rellena( FormatFloat('#,##0.00', FieldByName('porcentaje').AsFloat ), 6, ' ', taLeftJustify ));
        Next;
      end;
      QRMemo.Lines.Add( '--------------------------' );
      QRMemo.Lines.Add( Rellena( FormatFloat('#,##0.00', FieldByName('total').AsFloat ), 19, ' ', taLeftJustify ) + ' 100,00');
    end
    else
    begin
      PrintBand:= False;
    end;
  end;
end;

end.
