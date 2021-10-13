unit LVentasFOB;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLVentasFOB = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DBCliente: TQRDBText;
    DBKilos: TQRDBText;
    DBImporte: TQRDBText;
    DBGastos: TQRDBText;
    DBNeto: TQRDBText;
    LCliente: TQRLabel;
    LKilos: TQRLabel;
    LVenta: TQRLabel;
    LGastos: TQRLabel;
    LNeto: TQRLabel;
    LVentasT: TQRLabel;
    LGastosT: TQRLabel;
    LNetoT: TQRLabel;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    PsQRShape4: TQRShape;
    PsQRShape5: TQRShape;
    PsQRLabel1: TQRLabel;
    PsQRShape6: TQRShape;
    PsQRShape7: TQRShape;
    PsQRShape8: TQRShape;
    PsQRShape9: TQRShape;
    LEuros: TQRLabel;
    PsQRLabel2: TQRLabel;
    DBPromedio: TQRExpr;
    DBPromedio2: TQRExpr;
    PsQRShape10: TQRShape;
    PsQRShape14: TQRShape;
    ChildBand1: TQRChildBand;
    PsQRLabel8: TQRLabel;
    DBNomCliente: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    LCentro: TQRLabel;
    LProducto: TQRLabel;
    LCategoria: TQRLabel;
    LPeriodo: TQRLabel;
    PsQRSysData3: TQRSysData;
    DBSumKilos: TQRExpr;
    procedure QRLVentasFOBBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DBKilosPrint(sender: TObject; var Value: string);
    procedure DBImportePrint(sender: TObject; var Value: string);
    procedure DBGastosPrint(sender: TObject; var Value: string);
    procedure DBNetoPrint(sender: TObject; var Value: string);
    procedure LVentasTPrint(sender: TObject; var Value: string);
    procedure LGastosTPrint(sender: TObject; var Value: string);
    procedure LNetoTPrint(sender: TObject; var Value: string);
    procedure DBNomClientePrint(sender: TObject; var Value: String);
  private
    vent, gast, net: real;
  public
    sCodEmpresa, sEmpresa: string;

  end;

var
  QRLVentasFOB: TQRLVentasFOB;

implementation

uses UDMAuxDB, bNumericUtils, UDMBaseDatos;

{$R *.DFM}

//**************************  REPORT  ******************************************

procedure TQRLVentasFOB.QRLVentasFOBBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
     //Darle valor a la propiedad DataField de los campos de base de datos
  DBCliente.DataField := 'cliente_tvf';
  DBNomCliente.DataField := 'cliente_tvf';
  DBKilos.DataField := 'kilos_tvf';
  DBSumKilos.Expression := 'sum([kilos_tvf])';
  DBImporte.DataField := 'importe_venta_tvf';
  DBGastos.DataField := 'gastos_tvf';
  DBNeto.DataField := 'neto_tvf';

  (*ATENCION
    Teresa 2005.04.25 Para sacar un listado especifico
  DBPromedio.Expression:= '(TTemporal.importe_venta_tvf / TTemporal.kilos_tvf)';
  DBPromedio2.Expression:= '(SUM(TTemporal.importe_venta_tvf)/SUM(TTEmporal.kilos_tvf))';
  *)

     //Inicializar variables
  vent := 0;
  gast := 0;
  net := 0;
end;

//*****************************  DETALLE(ACUMULAR)  ***************************

procedure TQRLVentasFOB.DBKilosPrint(sender: TObject; var Value: string);
begin
  //acumular los valores
  Value := FormatFloat('#,##0.00', StrToFloat(value));
end;

procedure TQRLVentasFOB.DBImportePrint(sender: TObject; var Value: string);
begin
  vent := vent + StrToFloat(Value);
  Value := FormatFloat('#,##0.00', StrToFloat(value));
end;

procedure TQRLVentasFOB.DBGastosPrint(sender: TObject; var Value: string);
begin
  gast := gast + StrToFloat(Value);
  Value := FormatFloat('#,##0.00', StrToFloat(value));
end;

procedure TQRLVentasFOB.DBNetoPrint(sender: TObject; var Value: string);
begin
  net := net + StrToFloat(Value);
  Value := FormatFloat('#,##0.00', StrToFloat(value));
end;

//***********************  SUMARIO(MOSTRAR ACUMULADOS)  ************************

procedure TQRLVentasFOB.LVentasTPrint(sender: TObject; var Value: string);
begin
  value := FormatFloat('#,##0.00', vent);
end;

procedure TQRLVentasFOB.LGastosTPrint(sender: TObject; var Value: string);
begin
  value := FormatFloat('#,##0.00', gast);
end;

procedure TQRLVentasFOB.LNetoTPrint(sender: TObject; var Value: string);
begin
  value := FormatFloat('#,##0.00', net);
end;

procedure TQRLVentasFOB.DBNomClientePrint(sender: TObject; var Value: String);
begin
  Value := desCliente(sCodEmpresa, value);
end;

end.
