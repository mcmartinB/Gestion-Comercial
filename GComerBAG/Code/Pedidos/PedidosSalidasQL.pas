unit PedidosSalidasQL;

interface

uses
  Classes, Controls, ExtCtrls, QuickRpt, Qrctrls, Db, DBTables;

type
  TQLPedidosSalidas = class(TQuickRep)
    bndCabPagina: TQRBand;
    bndDetalle: TQRBand;
    QRSysData2: TQRSysData;
    producto: TQRDBText;
    unidades: TQRDBText;
    QRDBText12: TQRDBText;
    bndCabUnidad: TQRGroup;
    QRSysData3: TQRSysData;
    pedido: TQRDBText;
    fecha: TQRDBText;
    suministro: TQRDBText;
    des_suministro: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    lCliente: TQRLabel;
    lFechas: TQRLabel;
    lCentro: TQRLabel;
    QRDBText1: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel10: TQRLabel;
    bndCabPedido: TQRGroup;
    bndPiePedido: TQRBand;
    lAcumSalida: TQRLabel;
    lDifPedido: TQRLabel;
    lAcumPedido: TQRLabel;
    QRDBText2: TQRDBText;
    QRShape3: TQRShape;
    bndPieUnidad: TQRBand;
    lAcumPedidos: TQRLabel;
    lAcumSalidas: TQRLabel;
    lDifPedidos: TQRLabel;
    QRShape4: TQRShape;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    lblUnidades: TQRLabel;
    QRLabel11: TQRLabel;
    procedure des_suministroPrint(sender: TObject; var Value: String);
    procedure QRDBText13Print(sender: TObject; var Value: String);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure suministroPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndCabPedidoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPiePedidoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText9Print(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure lblUnidadesPrint(sender: TObject; var Value: String);
    procedure QRLabel11Print(sender: TObject; var Value: String);
    procedure bndPieUnidadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepEndPage(Sender: TCustomQuickRep);

  private
    iLineas: integer;
    sDirSum, sPedido: string;
    bPrintDirSum: boolean;

    acumSalida, acumSalidas, acumPedido, acumPedidos: Real;
    sProductoPedido: string;
  public
    bAgruparPedido: boolean;
  end;

implementation

{$R *.DFM}

uses PedidosSalidasDL, UDMAuxDB, SysUtils;

procedure TQLPedidosSalidas.suministroPrint(sender: TObject;
  var Value: String);
begin
  if not bPrintDirSum then
  begin
    Value:= '';
  end;
end;

procedure TQLPedidosSalidas.des_suministroPrint(sender: TObject;
  var Value: String);
begin
  if bPrintDirSum then
  begin
    if ( DataSet.FieldByName('suministro').asstring = '' ) or
      ( DataSet.FieldByName('cliente').asstring = DataSet.FieldByName('suministro').asstring ) then
    begin
      Value:= desCliente( value );
    end
    else
    begin
      Value:= desSuministro( DataSet.FieldByName('empresa').asstring,
                                      DataSet.FieldByName('cliente').asstring, value );
    end;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLPedidosSalidas.QRDBText13Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + DesCentro( DataSet.FieldByName('empresa').asstring, Value );
end;

procedure TQLPedidosSalidas.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if sDirSum = DataSet.FieldByName('suministro').asstring  then
  begin
    bPrintDirSum:= False;
  end
  else
  begin
    bPrintDirSum:= True;
    sDirSum:= DataSet.FieldByName('suministro').asstring;
  end;

  acumSalida:= acumSalida + DataSet.FieldByName('unidades_alb').asFloat;

  if sProductoPedido <> DataSet.FieldByName('producto').AsString +
                        DataSet.FieldByName('pedido').AsString  +
                        DataSet.FieldByName('fecha').AsString +
                        DataSet.FieldByName('unidad').AsString then
  begin
    sProductoPedido:= DataSet.FieldByName('producto').AsString +
                        DataSet.FieldByName('pedido').AsString +
                        DataSet.FieldByName('fecha').AsString+
                        DataSet.FieldByName('unidad').AsString;
    acumPedido:= acumPedido  + DataSet.FieldByName('unidades').asFloat;

    pedido.Enabled:= True;
    fecha.Enabled:= True;
    producto.Enabled:= True;
    unidades.Enabled:= True;
  end
  else
  begin
    pedido.Enabled:= False;
    fecha.Enabled:= False;
    producto.Enabled:= False;
    unidades.Enabled:= False;
  end;

  if sPedido <> DataSet.FieldByName('pedido').AsString  +
                DataSet.FieldByName('fecha').AsString +
                DataSet.FieldByName('unidad').AsString then
  begin
    sPedido:= DataSet.FieldByName('pedido').AsString  +
              DataSet.FieldByName('fecha').AsString +
              DataSet.FieldByName('unidad').AsString;
    pedido.Enabled:= True;
    fecha.Enabled:= True;
  end
  else
  begin
    pedido.Enabled:= False;
    fecha.Enabled:= False;
  end;

  inc(iLineas);
end;

procedure TQLPedidosSalidas.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  sDirSum:= '';
  sProductoPedido:= '';
  sPedido:= '';
  acumSalida:= 0;
  acumSalidas:= 0;
  acumPedido:= 0;
  acumPedidos:= 0;
  bndCabPedido.Height:= 0;
  if bAgruparPedido then
  begin
    bndPiePedido.Height:= 22;
  end
  else
  begin
    bndPiePedido.Height:= 0;
  end;
end;

procedure TQLPedidosSalidas.bndCabPedidoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  acumSalida:= 0;
  acumPedido:= 0;
  iLineas:= 0;
end;

procedure TQLPedidosSalidas.bndPiePedidoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  acumSalidas:= acumSalidas + acumSalida;
  acumPedidos:= acumPedidos + acumPedido;

  lAcumPedido.Caption:= FormatFloat('#,##0.00', acumPedido);
  lAcumSalida.Caption:= FormatFloat('#,##0.00', acumSalida);
  lDifPedido.Caption:= FormatFloat('#,##0.00', acumSalida - acumPedido );

  PrintBand:= iLineas > 1;
end;

procedure TQLPedidosSalidas.QRDBText9Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('lineas').AsFloat <> 1 then
    Value:= '';
end;

procedure TQLPedidosSalidas.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('lineas').AsFloat <> 1 then
    Value:= '';
end;

procedure TQLPedidosSalidas.lblUnidadesPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('unidad').AsString = 'K' then
    Value:= 'KILOS'
  else
  if DataSet.FieldByName('unidad').AsString = 'U' then
    Value:= 'UNIDADES'
  else
  if DataSet.FieldByName('unidad').AsString = 'C' then
    Value:= 'CAJAS';
end;

procedure TQLPedidosSalidas.QRLabel11Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('unidad').AsString = 'K' then
    Value:= 'TOTAL KILOS'
  else
  if DataSet.FieldByName('unidad').AsString = 'U' then
    Value:= 'TOTAL UNIDADES'
  else
  if DataSet.FieldByName('unidad').AsString = 'C' then
    Value:= 'TOTAL CAJAS';
end;

procedure TQLPedidosSalidas.bndPieUnidadBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lAcumPedidos.Caption:= FormatFloat('#,##0.00', acumPedidos );
  lAcumSalidas.Caption:= FormatFloat('#,##0.00', acumSalidas);
  lDifPedidos.Caption:= FormatFloat('#,##0.00', acumSalidas - acumPedidos );
  acumPedidos:= 0;
  acumSalidas:= 0;
end;

procedure TQLPedidosSalidas.QuickRepEndPage(Sender: TCustomQuickRep);
begin
  sDirSum:= '';
end;

end.
