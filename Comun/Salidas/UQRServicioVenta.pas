unit UQRServicioVenta;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos, DB, DBTables;

type
  TQRServicioVenta = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    Empresa: TQRLabel;
    fecha_c: TQRDBText;
    numero_c: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    qrestatus_sv: TQRDBText;
    QRGroup1: TQRGroup;
    qreempresa_sv: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel1: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel5: TQRLabel;
    QRMemo: TQRMemo;
    ref_compra_c: TQRDBText;
    QRLabel3: TQRLabel;
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
    qreservicio_sv: TQRDBText;
    qreservicio_sv1: TQRDBText;
    qrealbaran: TQRDBText;
    qrecliente: TQRDBText;
    qrecliente1: TQRDBText;
    qrecliente2: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl8: TQRLabel;
    qrl9: TQRLabel;
    qrl10: TQRLabel;
    qreTipo: TQRDBText;
    qrefecha: TQRDBText;
    qrefactura: TQRDBText;
    qreProducto: TQRDBText;
    qreImporte: TQRDBText;
    qreProducto1: TQRDBText;
    qrl11: TQRLabel;
    qreTipo1: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreempresa_svPrint(sender: TObject; var Value: String);
    procedure qrestatus_svPrint(sender: TObject; var Value: String);
    procedure QServiciosAfterOpen(DataSet: TDataSet);
    procedure QServiciosBeforeClose(DataSet: TDataSet);
    procedure bndCabSalidasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrecliente2Print(sender: TObject; var Value: String);
    procedure bndCabGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreTipo1Print(sender: TObject; var Value: String);
    procedure qreProducto1Print(sender: TObject; var Value: String);
  private

  public
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; override;
  end;


implementation

uses
  CVariables, UDMAuxDB;

{$R *.DFM}

procedure TQRServicioVenta.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRServicioVenta.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= Trim( DataSet.FieldByName('observaciones_sv').AsString ) <> '';
  if PrintBand then
  begin
    QRMemo.Lines.Clear;
    QRMemo.Lines.Add( Trim( DataSet.FieldByName('observaciones_sv').AsString ) );
  end;
end;

procedure TQRServicioVenta.qreempresa_svPrint(sender: TObject; var Value: String);
begin
  Value:= value + ' ' + desEmpresa( value );
end;

procedure TQRServicioVenta.qrestatus_svPrint(sender: TObject; var Value: String);
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

constructor TQRServicioVenta.Create(AOwner: TComponent);
begin
  inherited;
  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select n_albaran_sc albaran, centro_origen_sl origen, fecha_sc fecha, cliente_sal_sc cliente, dir_sum_sc suministro ');

    SQL.Add(' from frf_salidas_servicios_venta, frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_ssv = :empresa_sv ');
    SQL.Add(' and servicio_ssv = :servicio_sv ');

    SQL.Add(' and empresa_sc = :empresa_sv ');
    SQL.Add(' and centro_salida_sc = centro_salida_ssv ');
    SQL.Add(' and n_albaran_sc = n_albaran_ssv ');
    SQL.Add(' and fecha_sc = fecha_ssv ');

    SQL.Add(' and empresa_sl = :empresa_sv ');
    SQL.Add(' and centro_salida_sl = centro_salida_ssv ');
    SQL.Add(' and n_albaran_sl = n_albaran_ssv ');
    SQL.Add(' and fecha_sl = fecha_ssv ');

    SQL.Add(' order by n_albaran_ssv ');

    Prepare;
  end;

  with QGastos do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_gsv Tipo, ref_fac_gsv factura, fecha_fac_gsv fecha, ');
    SQL.Add('        producto_gsv Producto, importe_gsv Importe ');
    SQL.Add(' from frf_gastos_servicios_venta ');
    SQL.Add(' where empresa_gsv = :empresa_sv ');
    SQL.Add(' and servicio_gsv = :servicio_sv ');
    SQL.Add(' order by tipo_gsv, producto_gsv ');
    Prepare;
  end;
end;

destructor TQRServicioVenta.Destroy;
begin
  QSalidas.Close;
  Inherited;
end;

procedure TQRServicioVenta.QServiciosAfterOpen(DataSet: TDataSet);
begin
  QSalidas.Open;
  QGastos.Open;
end;

procedure TQRServicioVenta.QServiciosBeforeClose(DataSet: TDataSet);
begin
  QSalidas.Close;
  QGastos.Close;
end;

procedure TQRServicioVenta.bndCabSalidasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not QSalidas.IsEmpty;
end;

procedure TQRServicioVenta.qrecliente2Print(sender: TObject;
  var Value: String);
var
  sAux: string;
begin
  sAux:= desSuministro( DataSet.FieldByName('empresa_sv').AsString,
                         Value, bnddSalidas.DataSet.FieldByName('suministro').AsString );
  if sAux = '' then
  begin
    Value:= desCliente( Value );
  end
  else
  begin
    Value:= sAux;
  end;
end;

procedure TQRServicioVenta.bndCabGastosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not QGastos.IsEmpty;
end;

procedure TQRServicioVenta.qreTipo1Print(sender: TObject;
  var Value: String);
begin
  Value:= desTipoGastos( Value );
end;

procedure TQRServicioVenta.qreProducto1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByName('empresa_sv').AsString,Value );
end;

end.
