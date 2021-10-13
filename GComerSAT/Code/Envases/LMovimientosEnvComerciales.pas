unit LMovimientosEnvComerciales;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, grimgctrl;

type
  TQRLMovimientosEnvComerciales = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    nota: TQRDBText;
    PsQRSysData1: TQRSysData;
    bndCabOperdador: TQRGroup;
    bndPieOperador: TQRBand;
    bndPieProducto: TQRBand;
    SummaryBand1: TQRBand;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    lblPeriodo: TQRLabel;
    qrdbtxtalbaran: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    qryMovimientos: TQuery;
    qrdbtxtenv_comer_producto_e: TQRDBText;
    bndCabProducto: TQRGroup;
    qrlbl2: TQRLabel;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtoperador: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    bndcChildBand1: TQRChildBand;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlblStock: TQRLabel;
    qrlblAlmacen: TQRLabel;
    qrlblStockProducto: TQRLabel;
    qrlblStockOperador: TQRLabel;
    qrlblStockTotal: TQRLabel;
    qrgrpDiario: TQRGroup;
    qrbndPieDairio: TQRBand;
    qrlblStockDiario: TQRLabel;
    qrdbtxtfecha1: TQRDBText;
    qrdbtxtcentro: TQRDBText;
    bndcChildBand2: TQRChildBand;
    qrdbtxtoperador4: TQRDBText;
    procedure qrdbtxtalbaranPrint(sender: TObject; var Value: String);
    procedure qrdbtxtoperador4Print(sender: TObject; var Value: String);
    procedure qrdbtxtproductoPrint(sender: TObject; var Value: String);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndCabProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure notaPrint(sender: TObject; var Value: String);
    procedure bndCabOperdadorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndPieProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieOperadorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure PsQRLabel13Print(sender: TObject; var Value: String);
    procedure qrgrpDiarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieDairioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtfecha1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcentroPrint(sender: TObject; var Value: String);
  private
    iStockProducto, iStockOperador, iStockTotal: Integer;

  public
    sEmpresa: string;
    bDiario: Boolean;

    destructor Destroy; override;
  end;

var
  QRLMovimientosEnvComerciales: TQRLMovimientosEnvComerciales;

implementation



uses LFSalidasEnvases, UDMAuxDB, bTextUtils;

{$R *.DFM}

(*
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
  end;
*)

destructor TQRLMovimientosEnvComerciales.Destroy;
begin
  qryMovimientos.Close;
  inherited;
end;

procedure TQRLMovimientosEnvComerciales.qrdbtxtalbaranPrint(
  sender: TObject; var Value: String);
begin
  if Value = '0' then Value := 'IN' //  inventario
  else if Value = '1' then Value := 'AJ' //  ajustes
  else if Value = '2' then Value := 'EC' //  entradas cajas
  else if Value = '3' then Value := 'ETC' // entradas por transitos de cajas
  else if Value = '4' then Value := 'ETF' // entradas por transitos de fruta
  else if Value = '5' then Value := 'STC' // salidas por transitos de caja
  else if Value = '6' then Value := 'SVF' // salidas por transitos de fruta
  else if Value = '7' then Value := 'STF'; // salidas por ventas de fruta
end;

procedure TQRLMovimientosEnvComerciales.qrdbtxtoperador4Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' '  + desEnvComerOperador( Value );
end;

procedure TQRLMovimientosEnvComerciales.qrdbtxtproductoPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' '  + desEnvComerProducto( DataSet.FieldbyName('operador').AsString, Value );
end;

procedure TQRLMovimientosEnvComerciales.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  iStockTotal:= 0;
end;

procedure TQRLMovimientosEnvComerciales.bndCabOperdadorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  iStockOperador:= 0;
end;

procedure TQRLMovimientosEnvComerciales.bndCabProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  iStockProducto:= 0;
end;

procedure TQRLMovimientosEnvComerciales.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  //Stock
  if DataSet.FieldbyName('tipo').AsString = '0' then
  begin
    iStockProducto:= DataSet.FieldbyName('stock').AsInteger;
  end
  else
  begin
    iStockProducto:= iStockProducto + DataSet.FieldbyName('cantidad').AsInteger;
  end;
  qrlblStock.Caption:= FormatFloat('#,##0', iStockProducto );

  //Almacen
  if DataSet.FieldbyName('tipo').AsString = '2' then
    qrlblAlmacen.Caption := DataSet.FieldbyName('almacen').AsString  + ' ' +
                            desEnvComerAlmacen( DataSet.FieldbyName('operador').AsString,
                                                DataSet.FieldbyName('almacen').AsString )
  else if DataSet.FieldbyName('tipo').AsString = '3' then
    qrlblAlmacen.Caption := DataSet.FieldbyName('almacen').AsString  + ' ' +
                            desCentro( DataSet.FieldbyName('empresa').AsString,
                                                DataSet.FieldbyName('almacen').AsString )
  else if DataSet.FieldbyName('tipo').AsString = '4' then
    qrlblAlmacen.Caption := DataSet.FieldbyName('almacen').AsString  + ' ' +
                            desCentro( DataSet.FieldbyName('empresa').AsString,
                                                DataSet.FieldbyName('almacen').AsString )
  else if DataSet.FieldbyName('tipo').AsString = '5' then
    qrlblAlmacen.Caption := DataSet.FieldbyName('almacen').AsString  + ' ' +
                            desCentro( DataSet.FieldbyName('empresa').AsString,
                                                DataSet.FieldbyName('almacen').AsString )
  else if DataSet.FieldbyName('tipo').AsString = '6' then
  begin
    qrlblAlmacen.Caption := desSuministro( DataSet.FieldbyName('empresa').AsString,
                            DataSet.FieldbyName('cliente').AsString,
                            DataSet.FieldbyName('almacen').AsString );
    qrlblAlmacen.Caption:= Trim( StringReplace( qrlblAlmacen.Caption, 'MERCADONA', '', [] ) );
    if qrlblAlmacen.Caption = '' then
    begin
      qrlblAlmacen.Caption := DataSet.FieldbyName('cliente').AsString  + ' ' +
                              desCliente( DataSet.FieldbyName('cliente').AsString );
    end
    else
    begin
      qrlblAlmacen.Caption := DataSet.FieldbyName('cliente').AsString  + '/' +
                              DataSet.FieldbyName('almacen').AsString  + ' ' + qrlblAlmacen.Caption;
    end;
  end
  else if DataSet.FieldbyName('tipo').AsString = '7' then
    qrlblAlmacen.Caption := DataSet.FieldbyName('almacen').AsString  + ' ' +
                            desCentro( DataSet.FieldbyName('empresa').AsString,
                                                DataSet.FieldbyName('almacen').AsString )
  else
    qrlblAlmacen.Caption := '';
end;

procedure TQRLMovimientosEnvComerciales.notaPrint(sender: TObject;
  var Value: String);
begin
  Value:= Trim( Value );
end;

procedure TQRLMovimientosEnvComerciales.qrbndPieDairioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bDiario;
  qrlblStockDiario.Caption:=  FormatFloat('#,##0', iStockProducto );
end;

procedure TQRLMovimientosEnvComerciales.bndPieProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  iStockOperador:= iStockOperador + iStockProducto;
  qrlblStockProducto.Caption:=  FormatFloat('#,##0', iStockProducto );
end;

procedure TQRLMovimientosEnvComerciales.bndPieOperadorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  iStockTotal:= iStockTotal + iStockOperador;
  qrlblStockOperador.Caption:=  FormatFloat('#,##0', iStockOperador );
end;

procedure TQRLMovimientosEnvComerciales.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblStockTotal.Caption:=  FormatFloat('#,##0', iStockTotal );
end;

procedure TQRLMovimientosEnvComerciales.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Stock envase ' + DataSet.FieldbyName('empresa').AsString + '/' + DataSet.FieldbyName('centro').AsString + ' - ' +
          DataSet.FieldbyName('operador').AsString + '/' + DataSet.FieldbyName('producto').AsString;
end;

procedure TQRLMovimientosEnvComerciales.PsQRLabel13Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Stock operador ' +  DataSet.FieldbyName('empresa').AsString + '/' + DataSet.FieldbyName('centro').AsString + ' - ' +
          DataSet.FieldbyName('operador').AsString;
end;

procedure TQRLMovimientosEnvComerciales.qrgrpDiarioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bDiario;
  qrgrpDiario.Height:= 1;
end;

procedure TQRLMovimientosEnvComerciales.qrdbtxtfecha1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value;
end;

procedure TQRLMovimientosEnvComerciales.qrdbtxtcentroPrint(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( DataSet.FieldbyName('empresa').AsString, Value );
end;

end.
