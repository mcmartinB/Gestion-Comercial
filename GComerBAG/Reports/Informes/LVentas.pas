unit LVentas;
interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLVentas = class(TQuickRep)
    DetailBand1: TQRBand;
    TitleBand1: TQRBand;
    SummaryBand1: TQRBand;
    PageFooterBand1: TQRBand;
    Grupo: TQRGroup;
    QRGroup2: TQRGroup;
    PsQRLabel1: TQRLabel;
    LCentro: TQRLabel;
    LProducto: TQRLabel;
    PsQRSysData1: TQRSysData;
    DBCliente: TQRDBText;
    LCliente: TQRLabel;
    DBEnvase: TQRDBText;
    DBCategoria: TQRDBText;
    DBNeto: TQRDBText;
    DBIva: TQRDBText;
    DBTotal: TQRDBText;
    PsQRSysData2: TQRSysData;
    PieGrupo: TQRBand;
    Periodo: TQRLabel;
    LTTotalAcu: TQRLabel;
    AcuNeto: TQRLabel;
    AcuIva: TQRLabel;
    AcuImporte: TQRLabel;
    AcuNeto2: TQRLabel;
    AcuIva2: TQRLabel;
    AcuImporte2: TQRLabel;
    PieGrupo2: TQRBand;
    PsQRLabel3: TQRLabel;
    LNetoCli: TQRLabel;
    LIvaCli: TQRLabel;
    LTotalCli: TQRLabel;
    DBAlbaran: TQRDBText;
    DBFechaAlb: TQRDBText;
    ChildBand1: TQRChildBand;
    LAlbaran: TQRLabel;
    LFEcha: TQRLabel;
    LEnvase: TQRLabel;
    LCategoria: TQRLabel;
    LImporte: TQRLabel;
    LIva: TQRLabel;
    LTotal: TQRLabel;
    LFechaFac: TQRLabel;
    LNumFac: TQRLabel;
    DBFactura: TQRDBText;
    DBFechaFac: TQRDBText;
    LTipo: TQRLabel;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    PsQRLabel2: TQRLabel;
    DBKilos: TQRDBText;
    AcuKilos: TQRLabel;
    LKilosCli: TQRLabel;
    AcuKilos2: TQRLabel;
    PsQRShape4: TQRShape;
    procedure QRLVentasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PeriodoPrint(sender: TObject; var Value: string);
    procedure LClientePrint(sender: TObject; var Value: string);
    procedure DBNetoPrint(sender: TObject; var Value: string);
    procedure DBIvaPrint(sender: TObject; var Value: string);
    procedure DBTotalPrint(sender: TObject; var Value: string);
    procedure PieGrupoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure PieGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure LEnvase2Print(sender: TObject; var Value: string);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PieGrupo2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure PieGrupo2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel3Print(sender: TObject; var Value: string);
    procedure DBClientePrint(sender: TObject; var Value: string);
    procedure DBAlbaranPrint(sender: TObject; var Value: string);
    procedure DBFechaAlbPrint(sender: TObject; var Value: string);
    procedure DBFacturaPrint(sender: TObject; var Value: string);
    procedure DBFechaFacPrint(sender: TObject; var Value: string);
    procedure DBKilosPrint(sender: TObject; var Value: string);

  private
    fech_fac, n_fac: string;
    n_alb, fech_alb: string;
    cli: string;
  public

  end;

var
  QRLVentas: TQRLVentas;
  kilos, neto, iva, importe: real;
  ckilos, cneto, civa, cimporte: real;
  tkilos, tneto, tiva, timporte: real;

implementation

uses LFVentas, UDMAuxDB;

{$R *.DFM}
//                              REPORT

procedure TQRLVentas.QRLVentasBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
      //inicializar variables
  kilos := 0;
  neto := 0;
  iva := 0;
  importe := 0;
  cneto := 0;
  ckilos := 0;
  civa := 0;
  cimporte := 0;
  tkilos := 0;
  tneto := 0;
  tiva := 0;
  timporte := 0;
  fech_fac := '';
  n_fac := '';
      //asignar los campos de la tabla a los componentes del report
  DBCliente.DataField := 'cliente_tv';

  DBAlbaran.DataField := 'n_albaran_tv';
  DBFechaAlb.DataField := 'fecha_tv';
  DBFactura.DataField := 'n_factura_tv';
  DBFechaFac.DataField := 'fecha_factura_tv';

  DBEnvase.DataField := 'envase_tv';
  DBCategoria.DataField := 'categoria_tv';
  DBKilos.DataField := 'kilos_tv';
  DBNeto.DataField := 'neto_tv';
  DBIva.DataField := 'iva_tv';
  DBTotal.DataField := 'total_tv';

end;

//                              TITULO

procedure TQRLVentas.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
        //Poner la descripciones de empresa, centro, producto
  LCentro.Caption := FLVentas.ECentro.Text + '  ' + FLVentas.STCentro.Caption;
  if FLVentas.edtEnvase.Text <> '' then
    LProducto.Caption := FLVentas.EProducto.Text + ' / ' + FLVentas.edtEnvase.Text + ' ' + FLVentas.stEnvase.Caption
  else
    LProducto.Caption := FLVentas.EProducto.Text + '  ' + FLVentas.STProducto.Caption;
  case FLVentas.RGFactura.ItemIndex of
    0: LTipo.Caption := 'FACTURADAS';
    1: LTipo.Caption := 'PTES. FACTURAR';
    2: LTipo.Caption := 'TODAS';
  end;
end;

procedure TQRLVentas.PeriodoPrint(sender: TObject; var Value: string);
begin
  Value := FLVentas.MEDesde.Text + ' a ' + FLVentas.MEHasta.Text;
end;

//                             CABECERA GRUPO1

procedure TQRLVentas.DBClientePrint(sender: TObject; var Value: string);
begin
  cli := value;
end;

procedure TQRLVentas.LClientePrint(sender: TObject; var Value: string);
begin
  Value := desCliente(FLVentas.TTemporal.FieldByName('cliente_tv').AsString);
end;

//                              CABECERA GRUPO2
//esta cabecera de grupo tiene la propiedad height = 0

procedure TQRLVentas.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  fech_fac := '';
  n_fac := '';
  n_alb := '';
  fech_alb := '';
end;

//                              DETALLE

procedure TQRLVentas.DBAlbaranPrint(sender: TObject; var Value: string);
begin
  if n_alb = value then
    value := ''
  else
    n_alb := value;
end;

procedure TQRLVentas.DBFechaAlbPrint(sender: TObject; var Value: string);
begin
  if fech_alb = value then
    value := ''
  else
    fech_alb := value;
end;

procedure TQRLVentas.DBFacturaPrint(sender: TObject; var Value: string);
begin
  if n_fac = value then
    value := ''
  else
    n_fac := value;
     //para las ventas pendientes de facturar
  if Value = '0' then
    Value := '';
end;

procedure TQRLVentas.DBFechaFacPrint(sender: TObject; var Value: string);
begin
  if fech_fac = value then
    value := ''
  else
  begin
    fech_fac := value;
    if Value = '30/12/1899' then
      Value := ''
    else
      value := FormatDateTime('dd/mm/yy', StrToDate(Value));
  end;
end;

procedure TQRLVentas.LEnvase2Print(sender: TObject; var Value: string);
begin
  Value := desEnvaseP(FLVentas.EEmpresa.Text,
    FLVentas.TTemporal.FieldByName('envase_tv').AsString,
    FLVentas.TTemporal.FieldByName('producto_tv').AsString);
end;

procedure TQRLVentas.DBNetoPrint(sender: TObject; var Value: string);
begin
  neto := neto + StrToFloat(Value);
  cneto := cneto + StrToFloat(Value);
  tneto := tneto + StrToFloat(Value);
  Value := FormatFloat('#,##0.00', StrToFloat(Value));
end;

procedure TQRLVentas.DBIvaPrint(sender: TObject; var Value: string);
begin
  iva := iva + StrToFloat(Value);
  civa := civa + StrToFloat(Value);
  tiva := tiva + StrToFloat(Value);
  Value := FormatFloat('#,##0.00', StrToFloat(Value));
end;

procedure TQRLVentas.DBTotalPrint(sender: TObject; var Value: string);
begin
  importe := importe + StrToFloat(Value);
  cimporte := cimporte + StrToFloat(Value);
  timporte := timporte + StrToFloat(Value);
  Value := FormatFloat('#,##0.00', StrToFloat(Value));
end;

//                           PIE DE GRUPO

procedure TQRLVentas.PieGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
        //totales por albaran
  AcuKilos.Caption := FormatFloat('#,##0.00', kilos);
  AcuNeto.Caption := FormatFloat('#,##0.00', neto);
  AcuIva.Caption := FormatFloat('#,##0.00', iva);
  AcuImporte.Caption := FormatFloat('#,##0.00', importe)
end;

procedure TQRLVentas.PieGrupoAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
        //inicializar totales por albaran
  kilos := 0;
  neto := 0;
  iva := 0;
  importe := 0;
end;

//                            PIE DE GRUPO 2

procedure TQRLVentas.PieGrupo2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     //totales por cliente
  LKilosCli.Caption := FormatFloat('#,##0.00', ckilos);
  LNetoCli.Caption := FormatFloat('#,##0.00', cneto);
  LIvaCli.Caption := FormatFloat('#,##0.00', civa);
  LTotalCli.Caption := FormatFloat('#,##0.00', cimporte);
end;

procedure TQRLVentas.PieGrupo2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
     //inicializo totales por cliente
  ckilos := 0;
  cneto := 0;
  civa := 0;
  cimporte := 0;
end;

procedure TQRLVentas.PsQRLabel3Print(sender: TObject; var Value: string);
begin
  Value := ' Total  ' + Cli + ' ...........:';
  PsQRLabel3.Left := 164;
end;

//                               SUMARIO

procedure TQRLVentas.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  AcuKilos2.Caption := FormatFloat('#,##0.00', tkilos);
  AcuNeto2.Caption := FormatFloat('#,##0.00', tneto);
  AcuIva2.Caption := FormatFloat('#,##0.00', tiva);
  AcuImporte2.Caption := FormatFloat('#,##0.00', timporte)
end;

procedure TQRLVentas.DBKilosPrint(sender: TObject; var Value: string);
begin
  kilos := kilos + StrToFloat(Value);
  ckilos := ckilos + StrToFloat(Value);
  tkilos := tkilos + StrToFloat(Value);
  Value := FormatFloat('#,##0.00', StrToFloat(Value));
end;

end.
