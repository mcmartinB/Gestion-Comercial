unit ServiciosEntregaRM;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos, DB, DBTables;

type
  TRMServiciosEntrega = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    fecha_c: TQRDBText;
    numero_c: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    qrestatus_sv: TQRDBText;
    ChildBand2: TQRChildBand;
    QRLabel5: TQRLabel;
    QRMemo: TQRMemo;
    ref_compra_c: TQRDBText;
    QServicios: TQuery;
    QSalidas: TQuery;
    DSMaestro: TDataSource;
    QGastos: TQuery;
    bnddSalidas: TQRSubDetail;
    bndCabSalidas: TQRBand;
    bndPieSalidas: TQRBand;
    bndCabGastos: TQRBand;
    bnddGastos: TQRSubDetail;
    bndPieGastos: TQRBand;
    qrdbtxtentrega: TQRDBText;
    qrdbtxtcod_proveedor: TQRDBText;
    qrdbtxtcod_almacen: TQRDBText;
    qrdbtxtalmacen: TQRDBText;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl8: TQRLabel;
    qrl10: TQRLabel;
    qreTipo: TQRDBText;
    qrefecha: TQRDBText;
    qrefactura: TQRDBText;
    qreImporte: TQRDBText;
    qrl11: TQRLabel;
    qreTipo1: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlblPalets: TQRLabel;
    qrdbtxtImporte: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreempresa_svPrint(sender: TObject; var Value: String);
    procedure qrestatus_svPrint(sender: TObject; var Value: String);
    procedure QServiciosAfterOpen(DataSet: TDataSet);
    procedure QServiciosBeforeClose(DataSet: TDataSet);
    procedure bndCabSalidasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtalmacenPrint(sender: TObject; var Value: String);
    procedure bndCabGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreTipo1Print(sender: TObject; var Value: String);
  private

  public
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; override;
  end;


implementation

uses
  CVariables, UDMAuxDB;

{$R *.DFM}

procedure TRMServiciosEntrega.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TRMServiciosEntrega.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= Trim( DataSet.FieldByName('observaciones_sec').AsString ) <> '';
  if PrintBand then
  begin
    QRMemo.Lines.Clear;
    QRMemo.Lines.Add( Trim( DataSet.FieldByName('observaciones_sec').AsString ) );
  end;
end;

procedure TRMServiciosEntrega.qreempresa_svPrint(sender: TObject; var Value: String);
begin
  Value:= value + ' ' + desEmpresa( value );
end;

procedure TRMServiciosEntrega.qrestatus_svPrint(sender: TObject; var Value: String);
begin
  if Value = '0' then
  begin
    Value:= Value + ' NUEVO, GASTOS PENDIENTES ASIGNAR';
  end
  else
  if Value = '1' then
  begin
    Value:= Value + ' MODIFICADO, REASIGNAR GASTOS PENDIENTE';
  end
  else
  if Value = '2' then
  begin
    Value:= Value + ' GASTOS ASIGNADOS';
  end ;
end;

constructor TRMServiciosEntrega.Create(AOwner: TComponent);
begin
  inherited;
  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select  empresa_ec empresa, codigo_ec entrega, ');
    SQL.Add('         proveedor_Ec cod_proveedor, ( select nombre_p from frf_proveedores ');
    SQL.Add('                                       where empresa_p = empresa_ec and proveedor_p = proveedor_ec ) proveedor, ');
    SQL.Add('         almacen_El cod_almacen, ( select nombre_pa from frf_proveedores_almacen ');
    SQL.Add('                                   where empresa_pa = empresa_ec and proveedor_pa = proveedor_ec and almacen_pa = almacen_el ) almacen, ');
    SQL.Add('         vehiculo_ec matricula, ');
    SQL.Add('         transporte_ec cod_transporte, transporte_ec || '' - '' || ( select descripcion_t from frf_transportistas ');
    SQL.Add('                                                                   where empresa_t = empresa_ec and transporte_t = transporte_ec ) transporte, ');
    SQL.Add('         producto_el cod_producto, ( select descripcion_p from frf_productos ');
    SQL.Add('                                     where empresa_p = empresa_ec and producto_p = producto_el ) producto, ');
    SQL.Add('         sum(palets_el) palets, ');
    SQL.Add('         sum(cajas_el) cajas, ');
    SQL.Add('         sum(kilos_el) kilos ');

    SQL.Add(' from frf_servicios_entrega_l, frf_entregas_c, frf_entregas_l ');

    SQL.Add(' where servicio_sel = :servicio_sec ');
    SQL.Add(' and codigo_ec = entrega_sel ');
    SQL.Add(' and codigo_el = codigo_ec ');
    SQL.Add(' group by empresa, entrega, matricula, cod_transporte, transporte, cod_producto, ');
    SQL.Add('           producto, cod_proveedor, proveedor, cod_almacen, almacen ');
    SQL.Add(' order by entrega ');


    Prepare;
  end;

  with QGastos do
  begin
    SQL.Add(' select tipo_seg Tipo, ref_fac_seg factura, fecha_fac_seg fecha, ');
    SQL.Add('        importe_seg Importe ');
    SQL.Add(' from frf_servicios_entrega_g ');
    SQL.Add(' where servicio_seg = :servicio_sec ');
    SQL.Add(' order by tipo_seg ');

    Prepare;
  end;
end;

destructor TRMServiciosEntrega.Destroy;
begin
  QSalidas.Close;
  QGastos.Close;
  Inherited;
end;

procedure TRMServiciosEntrega.QServiciosAfterOpen(DataSet: TDataSet);
begin
  QSalidas.Open;
  QGastos.Open;
end;

procedure TRMServiciosEntrega.QServiciosBeforeClose(DataSet: TDataSet);
begin
  QSalidas.Close;
  QGastos.Close;
end;

procedure TRMServiciosEntrega.bndCabSalidasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not QSalidas.IsEmpty;
end;

procedure TRMServiciosEntrega.qrdbtxtalmacenPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProveedorAlmacen( bnddSalidas.DataSet.FieldByName('empresa').AsString,
                              bnddSalidas.DataSet.FieldByName('cod_proveedor').AsString,
                              bnddSalidas.DataSet.FieldByName('cod_almacen').AsString );
end;

procedure TRMServiciosEntrega.bndCabGastosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not QGastos.IsEmpty;
end;

procedure TRMServiciosEntrega.qreTipo1Print(sender: TObject;
  var Value: String);
begin
  Value:= desTipoGastos( Value );
end;

end.
