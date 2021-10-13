unit PedidosClienteQM;

interface

uses
  Classes, Controls, ExtCtrls, QuickRpt, Qrctrls, Db, DBTables;

type
  TQMPedidosCliente = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRGroup1: TQRGroup;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRGroup2: TQRGroup;
    QRBand1: TQRBand;
    QRDBText13: TQRDBText;
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
    procedure QRGroup2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRDBText12Print(sender: TObject; var Value: String);
    procedure QRDBText7Print(sender: TObject; var Value: String);
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

  private
    bAnulado: boolean;
  public
    bNotas: boolean;
  end;

implementation

{$R *.DFM}

uses PedidosClienteDM, UDMAuxDB, SysUtils;


procedure TQMPedidosCliente.QRGroup2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  QRGroup2.Height:= 0;
end;

procedure TQMPedidosCliente.QRDBText1Print(sender: TObject; var Value: String);
begin
  Value:= Value + '/ ' + desCentro( DataSet.FieldByName('empresa_pdc').asstring, value );
end;

procedure TQMPedidosCliente.QRDBText3Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa_pdc').asstring, value );
end;

procedure TQMPedidosCliente.QRDBText12Print(sender: TObject; var Value: String);
begin
  if Value = 'K' then
    Value:= 'KILOS'
  else
  if Value = 'U' then
    Value:= 'UNIDADES'
  else
  if Value = 'C' then
    Value:= 'CAJAS';
end;

procedure TQMPedidosCliente.QRDBText7Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desEnvase( DataSet.FieldByName('empresa_pdc').asstring, value );
end;

procedure TQMPedidosCliente.QRDBText10Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desColor( DataSet.FieldByName('empresa_pdc').asstring,
                                  DataSet.FieldByName('producto_pdd').asstring, value );
end;

procedure TQMPedidosCliente.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desCliente( DataSet.FieldByName('empresa_pdc').asstring, value );
end;

procedure TQMPedidosCliente.QRLabel3Print(sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('cliente_pdc').asstring = DataSet.FieldByName('dir_suministro_pdc').asstring then
    Value:= '';
end;

procedure TQMPedidosCliente.QRDBText14Print(sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('cliente_pdc').asstring = DataSet.FieldByName('dir_suministro_pdc').asstring then
    Value:= ''
  else
    Value:= Value + ' ' + desSuministro( DataSet.FieldByName('empresa_pdc').asstring,
                                       DataSet.FieldByName('cliente_pdc').asstring, value );
end;

procedure TQMPedidosCliente.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRGroup2.Height:= 0;
end;

procedure TQMPedidosCliente.bndNotasHijaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bNotas;
  (*
  if bNotas then
  begin
    PrintBand:= ( DMPedidosCliente.QNotas.FieldByName('observaciones_pdc').AsString <> '' );
    mmoNotas.Lines.Add(DMPedidosCliente.QNotas.FieldByName('observaciones_pdc').AsString );
  end;
  *)
end;

procedure TQMPedidosCliente.bndNotasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bNotas;
  if bNotas then
  begin
    PrintBand:= ( DMPedidosCliente.QNotas.FieldByName('observaciones_pdc').AsString <> '' );
    mmoNotas.Lines.Clear;
    mmoNotas.Lines.Add(DMPedidosCliente.QNotas.FieldByName('observaciones_pdc').AsString );
  end;
end;

procedure TQMPedidosCliente.QRLabel13Print(sender: TObject; var Value: String);
begin
  if bNotas then
  begin
    if DMPedidosCliente.QNotas.FieldByName('observaciones_pdc').AsString <> '' then
      Value:= 'Observaciones'
    else
      Value:= '';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQMPedidosCliente.anulado_pdcPrint(sender: TObject; var Value: String);
begin
  bAnulado:= Value <> '0';
  if bAnulado then
    Value:= 'Pedido Anulado'
  else
    Value:= '';
end;

procedure TQMPedidosCliente.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bAnulado and ( Trim( Dataset.FieldByName('motivo_anulacion_pdc').AsString ) <> '' );
end;

end.
