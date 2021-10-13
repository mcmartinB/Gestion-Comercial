unit PedidosEnvaseQL;

interface

uses
  Classes, Controls, ExtCtrls, QuickRpt, Qrctrls, Db, DBTables;

type
  TQLPedidosEnvase = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    bndDetalle: TQRBand;
    QRSysData2: TQRSysData;
    QRDBText3: TQRDBText;
    unidades_pedidas: TQRDBText;
    unidades_servidas: TQRDBText;
    QRSysData3: TQRSysData;
    QRDBText14: TQRDBText;
    QRDBText4: TQRDBText;
    lCliente: TQRLabel;
    lFechas: TQRLabel;
    lCentro: TQRLabel;
    QRDBText1: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRDBText2: TQRDBText;
    lDiff: TQRLabel;
    bndCabUnidad: TQRGroup;
    bndPieUnidad: TQRBand;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    lAcumPedidos: TQRLabel;
    lAcumSalidas: TQRLabel;
    lDifPedidos: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    lblSinPedidos: TQRLabel;
    lblHaySinPedidos: TQRLabel;
    lblSemana: TQRLabel;
    Semana: TQRDBText;
    QRGCabGrupo: TQRGroup;
    QRBPieGrupo: TQRBand;
    QRDBText5: TQRDBText;
    lGrupoSalidas: TQRLabel;
    lGrupoPedidos: TQRLabel;
    lGrupoDifPedidos: TQRLabel;
    QRLabel12: TQRLabel;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText4Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRLabel6Print(sender: TObject; var Value: String);
    procedure QRLabel7Print(sender: TObject; var Value: String);
    procedure bndPieUnidadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SemanaPrint(sender: TObject; var Value: String);
    procedure QRDBText5Print(sender: TObject; var Value: String);
    procedure QRBPieGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGCabGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private

  public
    bSinPedidos, bHaySinPedidos, bFecha: boolean;
    sEmpresa: String;
    rPedido, rServido: real;
    rGrupoPedido, rGrupoServido: real;
  end;

implementation

{$R *.DFM}

uses PedidosEnvaseDL, UDMAuxDB, SysUtils, bMath;

procedure TQLPedidosEnvase.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rPedido:= 0;
  rServido:= 0;
  rGrupoPedido:= 0;
  rGrupoServido:= 0;
end;

procedure TQLPedidosEnvase.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  if Value = 'K' then
  begin
    Value:= 'KILOS';
  end
  else
  if Value = 'U' then
  begin
    Value:= 'UNIDADES';
  end
  else
  if Value = 'C' then
  begin
    Value:= 'CAJAS';
  end;
end;

procedure TQLPedidosEnvase.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvaseP( sEmpresa, Value, DataSet.fieldByName('producto').AsString );
end;

procedure TQLPedidosEnvase.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( sEmpresa, Value );
end;

procedure TQLPedidosEnvase.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rPedido:= rPedido + bRoundTo(DataSet.fieldByName('unidades_pedidas').AsFloat, -2);
  rServido:= rServido + bRoundTo(DataSet.fieldByName('unidades_servidas').AsFloat, -2);
  lDiff.Caption:= FormatFloat( '#,##0.00', bRoundTo(DataSet.fieldByName('unidades_servidas').AsFloat, -2) -
                  bRoundTo(DataSet.fieldByName('unidades_pedidas').AsFloat, -2) );
  rGrupoPedido:= rGrupoPedido + bRoundTo(DataSet.fieldByName('unidades_pedidas').AsFloat, -2);
  rGrupoServido:= rGrupoServido + bRoundTo(DataSet.fieldByName('unidades_servidas').AsFloat, -2);
end;

procedure TQLPedidosEnvase.QRLabel6Print(sender: TObject;
  var Value: String);
begin
  Value:= DataSet.fieldByName('unidad').AsString;
  if Value = 'K' then
  begin
    Value:= 'KILOS';
  end
  else
  if Value = 'U' then
  begin
    Value:= 'UNIDADES';
  end
  else
  if Value = 'C' then
  begin
    Value:= 'CAJAS';
  end;
end;

procedure TQLPedidosEnvase.QRLabel7Print(sender: TObject;
  var Value: String);
begin
  Value:= DataSet.fieldByName('unidad').AsString;
  if Value = 'K' then
  begin
    Value:= 'TOTAL KILOS';
  end
  else
  if Value = 'U' then
  begin
    Value:= 'TOTAL UNIDADES';
  end
  else
  if Value = 'C' then
  begin
    Value:= 'TOTAL CAJAS';
  end;
end;

procedure TQLPedidosEnvase.bndPieUnidadBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lAcumSalidas.Caption:= FormatFloat( '#,##0.00', rServido );
  lAcumPedidos.Caption:= FormatFloat( '#,##0.00', rPedido );
  lDifPedidos.Caption:= FormatFloat( '#,##0.00', rServido - rPedido );

  rPedido:= 0;
  rServido:= 0;
end;

procedure TQLPedidosEnvase.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if bSinPedidos then
  begin
    lblSinPedidos.Caption:= 'Las cantidades servidas incluyen las salidas que no tienen un número de pedido grabado.';
    if bHaySinPedidos then
    begin
      //lblHaySinPedidos.Caption:= 'Se han encontrado salida sin pedido asociado.';
      lblHaySinPedidos.Caption:= '';
    end
    else
    begin
      //lblHaySinPedidos.Caption:= 'No se ha encontrado ninguna salida sin pedido asociado.';
      lblHaySinPedidos.Caption:= '';
    end;
  end
  else
  begin
    lblSinPedidos.Caption:= 'Las cantidades servidas solo incluyen las salidas con un número de pedido asociado válido.';
    lblHaySinPedidos.Caption:= '';
  end;
end;

procedure TQLPedidosEnvase.SemanaPrint(sender: TObject; var Value: String);
begin
  if bFecha then
  begin
    Value:= Copy(Value, 7, 2) + '/' + Copy(Value, 5, 2) + '/' + Copy(Value, 3, 2);
  end;
end;

procedure TQLPedidosEnvase.QRDBText5Print(sender: TObject;
  var Value: String);
begin
  if bFecha then
  begin
    Value:= UpperCase( lblSemana.Caption + ': ' + Copy(Value, 7, 2) + '/' + Copy(Value, 5, 2) + '/' + Copy(Value, 3, 2) );
  end
  else
  begin
    Value:= UpperCase( lblSemana.Caption + ': ' + Value );
  end;
end;

procedure TQLPedidosEnvase.QRBPieGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= lblSemana.Caption <> '';
  if PrintBand then
  begin
    lGrupoSalidas.Caption:= FormatFloat( '#,##0.00', rGrupoServido );
    lGrupoPedidos.Caption:= FormatFloat( '#,##0.00', rGrupoPedido );
    lGrupoDifPedidos.Caption:= FormatFloat( '#,##0.00', rGrupoServido - rGrupoPedido );

    rGrupoPedido:= 0;
    rGrupoServido:= 0;
  end;
end;

procedure TQLPedidosEnvase.QRGCabGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRGCabGrupo.Height:= 0;
end;

end.
