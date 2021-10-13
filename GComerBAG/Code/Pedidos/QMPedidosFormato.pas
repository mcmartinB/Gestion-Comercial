unit QMPedidosFormato;

interface

uses
  Classes, Controls, ExtCtrls, QuickRpt, Qrctrls, Db, DBTables;

type
  TqrpMPedidosFormato = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRGroup1: TQRGroup;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    formato_cliente_pdd: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    cantidad_pdd: TQRDBText;
    QRDBText12: TQRDBText;
    QRGroup2: TQRGroup;
    QRBand1: TQRBand;
    QRExpr1: TQRExpr;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRGroup3: TQRGroup;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText14: TQRDBText;
    QRSysData3: TQRSysData;
    QRLabel12: TQRLabel;
    QRShape1: TQRShape;
    QRBand2: TQRBand;
    bndNotas: TQRBand;
    bndNotasHija: TQRChildBand;
    mmoNotas: TQRMemo;
    QRLabel13: TQRLabel;
    anulado_pdc: TQRDBText;
    ChildBand3: TQRChildBand;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel9: TQRLabel;
    motivo_anulacion_pdc: TQRDBText;
    QRDBText15: TQRDBText;
    lblPeriodo: TQRLabel;
    lblProducto: TQRLabel;
    cajas_pdd: TQRDBText;
    cajas_aservir_pdd: TQRDBText;
    cajas_servidas_pdd: TQRDBText;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRExpr2: TQRExpr;
    QRDBText1: TQRDBText;
    procedure QRGroup2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure formato_cliente_pddPrint(sender: TObject; var Value: String);
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QRLabel3Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText14Print(sender: TObject; var Value: String);
    procedure bndNotasHijaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndNotasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel13Print(sender: TObject; var Value: String);
    procedure anulado_pdcPrint(sender: TObject; var Value: String);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cajas_servidas_pddPrint(sender: TObject; var Value: String);

  private
    bAnulado: boolean;
    iAcumServidas: integer;
  public
    bNotas: boolean;
  end;

implementation

{$R *.DFM}

uses DMPedidosFormato, UDMAuxDB, SysUtils;


procedure TqrpMPedidosFormato.QRGroup2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  QRGroup2.Height:= 0;
end;

procedure TqrpMPedidosFormato.QRDBText3Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa_pdc').asstring, value );
end;

procedure TqrpMPedidosFormato.formato_cliente_pddPrint(sender: TObject; var Value: String);
begin
  Value:= desFormatoCliente( DataSet.FieldByName('empresa_pdc').asstring,
    DataSet.FieldByName('cliente_pdc').asstring, DataSet.FieldByName('dir_suministro_pdc').asstring,
    value, DataSet.FieldByName('fecha_pdc').asstring );
end;

procedure TqrpMPedidosFormato.QRDBText10Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desColor( DataSet.FieldByName('empresa_pdc').asstring,
                                  DataSet.FieldByName('producto_pdd').asstring, value );
end;

procedure TqrpMPedidosFormato.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desCliente( value );
end;

procedure TqrpMPedidosFormato.QRLabel3Print(sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('cliente_pdc').asstring = DataSet.FieldByName('dir_suministro_pdc').asstring then
    Value:= '';
end;

procedure TqrpMPedidosFormato.QRDBText14Print(sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('cliente_pdc').asstring = DataSet.FieldByName('dir_suministro_pdc').asstring then
    Value:= ''
  else
    Value:= Value + ' ' + desSuministro( DataSet.FieldByName('empresa_pdc').asstring,
                                       DataSet.FieldByName('cliente_pdc').asstring, value );
end;

procedure TqrpMPedidosFormato.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRGroup2.Height:= 0;
  iAcumServidas:= 0;
end;

procedure TqrpMPedidosFormato.bndNotasHijaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bNotas;
  (*
  if bNotas then
  begin
    PrintBand:= ( DMPedidos.QNotas.FieldByName('observaciones_pdc').AsString <> '' );
    mmoNotas.Lines.Add(DMPedidos.QNotas.FieldByName('observaciones_pdc').AsString );
  end;
  *)
end;

procedure TqrpMPedidosFormato.bndNotasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bNotas;
  if bNotas then
  begin
    PrintBand:= ( dtmMPedidosFormato.QNotas.FieldByName('observaciones_pdc').AsString <> '' );
    mmoNotas.Lines.Clear;
    mmoNotas.Lines.Add(dtmMPedidosFormato.QNotas.FieldByName('observaciones_pdc').AsString );
  end;
end;

procedure TqrpMPedidosFormato.QRLabel13Print(sender: TObject; var Value: String);
begin
  if bNotas then
  begin
    if dtmMPedidosFormato.QNotas.FieldByName('observaciones_pdc').AsString <> '' then
      Value:= 'Observaciones'
    else
      Value:= '';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TqrpMPedidosFormato.anulado_pdcPrint(sender: TObject; var Value: String);
begin
  bAnulado:= Value <> '0';
  if bAnulado then
    Value:= 'Pedido Anulado'
  else
    Value:= '';
end;

procedure TqrpMPedidosFormato.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bAnulado and ( Trim( Dataset.FieldByName('motivo_anulacion_pdc').AsString ) <> '' );
end;

procedure TqrpMPedidosFormato.cajas_servidas_pddPrint(sender: TObject;
  var Value: String);
var
  iAux: integer;
begin
  with dtmMPedidosFormato.QListado do
  begin
    iAux:= dtmMPedidosFormato.CajasServidasLinea( FieldByName('empresa_pdc').AsString,
                                                  FieldByName('centro_pdc').AsString,
                                                  FieldByName('pedido_pdc').AsString,
                                                  FieldByName('producto_pdd').AsString,
                                                  FieldByName('formato_cliente_pdd').AsString,
                                                  FieldByName('categoria_pdd').AsString,
                                                  FieldByName('calibre_pdd').AsString );
    Value:= FormatFloat( '#,##0', iAux );
    iAcumServidas:= iAcumServidas + iAux;
  end;
end;

procedure TqrpMPedidosFormato.QRDBText1Print(sender: TObject; var Value: String);
begin
  //Value:= Value + '/ ' + desCentro( DataSet.FieldByName('empresa_pdc').asstring, value );
  Value:= FormatFloat( '#,##0', iAcumServidas );
  iAcumServidas:= 0;
end;

end.
