unit PedidosSinAsignarQL;

interface

uses
  Classes, Controls, ExtCtrls, QuickRpt, Qrctrls, Db, DBTables;

type
  TQLPedidosSinAsignar = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    lblCentro: TQRDBText;
    referencia: TQRDBText;
    fecha: TQRDBText;
    pedido: TQRDBText;
    QRGroup3: TQRGroup;
    QRDBText2: TQRDBText;
    QRSysData3: TQRSysData;
    ChildBand2: TQRChildBand;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    qrlReferencia: TQRLabel;
    qrlFecha: TQRLabel;
    qrlPedido: TQRLabel;
    QRGroup1: TQRGroup;
    QRDBText14: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    lblRango: TQRLabel;
    procedure lblCentroPrint(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QRDBText14Print(sender: TObject; var Value: String);

  private

  public
    procedure Configurar( const APedidos: boolean );
  end;

implementation

{$R *.DFM}

uses PedidosSinAsignarDL, UDMAuxDB;




procedure TQLPedidosSinAsignar.lblCentroPrint(sender: TObject; var Value: String);
begin
  Value:= Value + '/ ' + desCentro( DataSet.FieldByName('empresa').asstring, value );
end;

procedure TQLPedidosSinAsignar.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value:= desCliente( DataSet.FieldByName('empresa').asstring, value );
end;


procedure TQLPedidosSinAsignar.QRDBText14Print(sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('cliente').asstring = DataSet.FieldByName('suministro').asstring then
    Value:= desCliente( DataSet.FieldByName('empresa').asstring, value )
  else
    Value:= desSuministro( DataSet.FieldByName('empresa').asstring,
                           DataSet.FieldByName('cliente').asstring, value );
end;

procedure TQLPedidosSinAsignar.Configurar( const APedidos: boolean );
begin
  if APedidos then
  begin
    ReportTitle:= 'LISTADO DE PEDIDOS SIN ASIGNAR';
    qrlReferencia.Caption:= 'Pedido';
    qrlPedido.Enabled:= False;
    pedido.Enabled:= False;
  end
  else
  begin
   ReportTitle:= 'LISTADO DE SALIDAS SIN ASIGNAR';
    qrlReferencia.Caption:= 'Albarán';
    qrlPedido.Enabled:= True;
    pedido.Enabled:= True;
  end;
end;

end.
