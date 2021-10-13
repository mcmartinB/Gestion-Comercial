unit PedidosQM;

interface

uses
  Classes, Controls, ExtCtrls, QuickRpt, Qrctrls, Db, DBTables;

type
  TQMPedidos = class(TQuickRep)
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
    QRGroup2: TQRGroup;
    QRBand1: TQRBand;
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
    lbCajas: TQRLabel;
    lbKilos: TQRLabel;
    lbACajas: TQRLabel;
    lbAKilos: TQRLabel;
    QRLabel13: TQRLabel;
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
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
    bAnulado: boolean;
    rKilos, rAKilos: real;
    iCajas, iACajas: integer;

  public
    bNotas: boolean;
  end;

implementation

{$R *.DFM}

uses PedidosDM, UDMAuxDB, SysUtils, bMath;


procedure TQMPedidos.QRGroup2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  QRGroup2.Height:= 0;
end;

procedure TQMPedidos.QRDBText1Print(sender: TObject; var Value: String);
begin
  Value:= Value + '/ ' + desCentro( DataSet.FieldByName('empresa_pdc').asstring, value );
end;

procedure TQMPedidos.QRDBText3Print(sender: TObject; var Value: String);
begin
  Value:= desProducto( DataSet.FieldByName('empresa_pdc').asstring, value );
end;

procedure TQMPedidos.QRDBText12Print(sender: TObject; var Value: String);
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

procedure TQMPedidos.QRDBText7Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desEnvaseP( DataSet.FieldByName('empresa_pdc').asstring, value, DataSet.FieldByName('producto_pdd').asstring );
end;

procedure TQMPedidos.QRDBText10Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desColor( DataSet.FieldByName('empresa_pdc').asstring,
                                  DataSet.FieldByName('producto_pdd').asstring, value );
end;

procedure TQMPedidos.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value:= Value + ' ' + desCliente( value );
end;

procedure TQMPedidos.QRLabel3Print(sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('cliente_pdc').asstring = DataSet.FieldByName('dir_suministro_pdc').asstring then
    Value:= '';
end;

procedure TQMPedidos.QRDBText14Print(sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('cliente_pdc').asstring = DataSet.FieldByName('dir_suministro_pdc').asstring then
    Value:= ''
  else
    Value:= Value + ' ' + desSuministro( DataSet.FieldByName('empresa_pdc').asstring,
                                       DataSet.FieldByName('cliente_pdc').asstring, value );
end;

procedure TQMPedidos.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRGroup2.Height:= 0;
  rAKilos:= 0;
  iACajas:= 0;
end;

procedure TQMPedidos.bndNotasHijaBeforePrint(Sender: TQRCustomBand;
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

procedure TQMPedidos.bndNotasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bNotas;
  if bNotas then
  begin
    PrintBand:= ( DMPedidos.QNotas.FieldByName('observaciones_pdc').AsString <> '' );
    mmoNotas.Lines.Clear;
    mmoNotas.Lines.Add(DMPedidos.QNotas.FieldByName('observaciones_pdc').AsString );
  end;
end;

procedure TQMPedidos.QRLabel13Print(sender: TObject; var Value: String);
begin
  if bNotas then
  begin
    if DMPedidos.QNotas.FieldByName('observaciones_pdc').AsString <> '' then
      Value:= 'Observaciones'
    else
      Value:= '';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQMPedidos.anulado_pdcPrint(sender: TObject; var Value: String);
begin
  bAnulado:= Value <> '0';
  if bAnulado then
    Value:= 'Pedido Anulado'
  else
    Value:= '';
end;

procedure TQMPedidos.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bAnulado and ( Trim( Dataset.FieldByName('motivo_anulacion_pdc').AsString ) <> '' );
end;

procedure TQMPedidos.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rPesoCaja: real;
  iUnidadesCaja: integer;
begin
  rPesoCaja:= DataSet.FieldByName('peso_neto_e').AsFloat;
  iUnidadesCaja:= DataSet.FieldByName('unidades_e').AsInteger;

  if DataSet.FieldByName('unidad_pdd').AsString = 'C' then
  begin
    iCajas:= DataSet.FieldByName('unidades_pdd').AsInteger;
    rKilos:= bRoundTo( iCajas * rPesoCaja, -2 );
  end
  else
  if DataSet.FieldByName('unidad_pdd').AsString = 'U' then
  begin
    if iUnidadesCaja > 0 then
    begin
      iCajas:= DataSet.FieldByName('unidades_pdd').AsInteger div iUnidadesCaja;
    end;
    rKilos:= bRoundTo( iCajas * rPesoCaja, -2 );
  end
  else
  begin
    rKilos:= bRoundTo( DataSet.FieldByName('unidades_pdd').AsFloat, -2 );
    if rPesoCaja > 0 then
    begin
      iCajas:= Trunc( rKilos / rPesoCaja );
    end;
  end;

  rAKilos:= rAKilos + rKilos;
  iAcajas:= iACajas + iCajas;

  lbKilos.Caption:= FormatFloat('#,##0.00', rKilos );
  lbCajas.Caption:= FormatFloat('#,##0', iCajas );
end;

procedure TQMPedidos.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbAKilos.Caption:= FormatFloat( '#,##0.00', rAKilos );
  lbACajas.Caption:= FormatFloat( '#,##0', iACajas );
  rAKilos:= 0;
  iACajas:= 0;
end;

end.
