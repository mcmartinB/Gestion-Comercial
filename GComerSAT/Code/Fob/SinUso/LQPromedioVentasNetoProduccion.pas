unit LQPromedioVentasNetoProduccion;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB;

type
  TQLPromedioVentasNetoProduccion = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    QRSysData1: TQRSysData;
    lblCentroOrigen: TQRLabel;
    lblCliente: TQRLabel;
    lblProducto: TQRLabel;
    lblFechas: TQRLabel;
    QRSysData2: TQRSysData;
    lblEmpresa: TQRLabel;
    bndCabProductos: TQRBand;
    QRShape5: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRDBText2: TQRDBText;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRDBText3: TQRDBText;
    bndCabClienrtes: TQRBand;
    QRShape6: TQRShape;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRDBText4: TQRDBText;
    QRExpr19: TQRExpr;
    QRExpr20: TQRExpr;
    QRDBText5: TQRDBText;
    bndPieProductos: TQRBand;
    QRExpr21: TQRExpr;
    QRExpr22: TQRExpr;
    bndPieClientes: TQRBand;
    QRExpr23: TQRExpr;
    QRExpr24: TQRExpr;
    QRShape4: TQRShape;
    QRShape3: TQRShape;
    QRShape2: TQRShape;
    QRShape1: TQRShape;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRLabel3: TQRLabel;
    QRExpr4: TQRExpr;
    QRExpr15: TQRExpr;
    QRLabel11: TQRLabel;
    QRExpr16: TQRExpr;
    QRExpr17: TQRExpr;
    QRLabel5: TQRLabel;
    QRExpr11: TQRExpr;
    QRExpr18: TQRExpr;
    QRExpr25: TQRExpr;
    QRExpr26: TQRExpr;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    bndCabPais: TQRBand;
    QRShape7: TQRShape;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRDBText8: TQRDBText;
    QRExpr27: TQRExpr;
    QRExpr28: TQRExpr;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    bndPiePais: TQRBand;
    QRExpr29: TQRExpr;
    QRExpr30: TQRExpr;
    QRExpr31: TQRExpr;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRLabel22: TQRLabel;
    lblKgsSinFacturar: TQRLabel;
    QRShape11: TQRShape;
    QRLabel23: TQRLabel;
    QRExpr32: TQRExpr;
    QRExpr33: TQRExpr;
    lblCentroSalida: TQRLabel;
    procedure bndCabProductosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndCabClienrtesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRDBText7Print(sender: TObject; var Value: String);
    procedure bndCabPaisBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure QRDBText5Print(sender: TObject; var Value: String);
  private
    bPromedioClientes: Boolean;
    bPromedioProductos: Boolean;
    bPromedioPaises: Boolean;

    procedure PreparaListado( const AKilosSinFacturar: real;
                              const ADesgloseProductos, ADesgloseClientes, ADesglosePaises: Boolean );
    //procedure PintarGrafico;
  public

  end;

  procedure PromedioVentasNetoProduccionReport( const AOwner: TComponent;
     const AKilosSinFacturar: real; const ADesgloseProductos, ADesgloseClientes, ADesglosePaises: Boolean );

implementation

{$R *.DFM}

uses
  LDPromedioVentasNetoProduccion, CReportes, DPreview, UDMAuxDB, UPieChart, bMath;

var
  QLPromedioVentasNetoProduccion: TQLPromedioVentasNetoProduccion;

procedure PromedioVentasNetoProduccionReport( const AOwner: TComponent;  const AKilosSinFacturar: real;
     const ADesgloseProductos, ADesgloseClientes, ADesglosePaises: Boolean );
begin

  QLPromedioVentasNetoProduccion:= TQLPromedioVentasNetoProduccion.Create( AOwner );
  try
    QLPromedioVentasNetoProduccion.PreparaListado( AKilosSinFacturar, ADesgloseProductos, ADesgloseClientes, ADesglosePaises );
    Previsualiza( QLPromedioVentasNetoProduccion );
  finally
    FreeAndNil( QLPromedioVentasNetoProduccion );
  end;
end;

procedure TQLPromedioVentasNetoProduccion.PreparaListado( const AKilosSinFacturar: real;
             const ADesgloseProductos, ADesgloseClientes, ADesglosePaises: Boolean );
begin
  PonLogoGrupoBonnysa( self );
  lblEmpresa.Caption:= DataSet.FieldByname('empresa').AsString + ' '  +
                       desEmpresa( DataSet.FieldByname('empresa').AsString );

 if DataSet.FieldByname('producto').AsString <> '' then
  begin
    lblProducto.Caption:= desProducto( DataSet.FieldByname('empresa').AsString,
                                       DataSet.FieldByname('producto').AsString );
    if ( ( DataSet.FieldByname('producto').AsString = 'T' ) or
         ( DataSet.FieldByname('producto').AsString = 'E' ) ) and
       (  DataSet.FieldByname('empresa').AsString = '050' ) then
    begin
      lblProducto.Caption:= lblProducto.Caption + ' [' + DataSet.FieldByname('producto').AsString + ']';
    end;
  end
  else
  begin
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';
  end;

  lblCentroSalida.Caption:= 'SALIDA: TODOS LOS CENTROS';
  if DataSet.FieldByname('centro_salida').AsString <> '' then
  begin
    lblCentroSalida.Caption:= 'SALIDA: ' + DesCentro( DataSet.FieldByname('empresa').AsString,
                                               DataSet.FieldByname('centro_salida').AsString );
  end;
  lblCentroOrigen.Caption:= 'ORIGEN: TODOS LOS CENTROS';
  if DataSet.FieldByname('centro_origen').AsString <> '' then
  begin
    lblCentroOrigen.Caption:= 'ORIGEN: ' + DesCentro( DataSet.FieldByname('empresa').AsString,
                                               DataSet.FieldByname('centro_origen').AsString );
  end;

  lblCliente.Caption:= '';
  if DataSet.FieldByname('cliente').AsString <> '' then
  begin
    lblCliente.Caption:= 'CLIENTE: ' + DesCliente( DataSet.FieldByname('empresa').AsString,
                                               DataSet.FieldByname('cliente').AsString );
  end;
  if DataSet.FieldByname('pais').AsString <> '' then
  begin
    lblCliente.Caption:= 'PAIS: ' + DesPais( DataSet.FieldByname('pais').AsString );
  end;
  if lblCliente.Caption = '' then
  begin
    lblCliente.Caption:= 'TODOS LOS CLIENTES';
  end;

  if DataSet.FieldByname('fecha_ini').AsString = DataSet.FieldByname('fecha_fin').AsString then
  begin
    lblFechas.Caption:= DataSet.FieldByname('fecha_ini').AsString;
  end
  else
  begin
    lblFechas.Caption:= 'Del ' + DataSet.FieldByname('fecha_ini').AsString +
                        ' al ' + DataSet.FieldByname('fecha_fin').AsString;
  end;

  ReportTitle:= 'PROMEDIO VENTAS NETO PRODUCCION';

  bPromedioClientes:= ADesgloseClientes;
  bPromedioPaises:= ADesglosePaises;
  bPromedioProductos:= ADesgloseProductos;

  lblKgsSinFacturar.Caption:= FormatFloat( '#,##0.00', AKilosSinFacturar );

  //PintarGrafico;
end;

(*
procedure TQLPromedioVentasNetoProduccion.PintarGrafico;
var
  arCostes: array[0..4] of real;
  asCostes: array[0..4] of string;
begin
  arCostes[0]:= bRoundTo( DataSet.FieldByname('descuento').AsFloat +
                                DataSet.FieldByname('comision').AsFloat, -2);
  asCostes[0]:= 'Comisiones y Descuentos';

  arCostes[1]:= bRoundTo( DataSet.FieldByname('gasto_salidas').AsFloat, -2);
  asCostes[1]:= 'Gastos Ventas';

  arCostes[2]:= bRoundTo( DataSet.FieldByname('coste_envasado').AsFloat +
                                DataSet.FieldByname('coste_secciones').AsFloat, -2);
  asCostes[2]:= 'Costes Envasado';

  arCostes[3]:= bRoundTo( DataSet.FieldByname('coste_indirecto').AsFloat, -2);
  asCostes[3]:= 'Costes Indirectos';

  arCostes[4]:= bRoundTo( DataSet.FieldByname('gasto_transitos').AsFloat, -2);
  asCostes[4]:= 'Gastos Tte. Tenerife';

  PaintPieChart( imgPieChartGrande.Canvas, 125, arCostes, asCostes, 1 );
end;
*)

procedure TQLPromedioVentasNetoProduccion.bndCabProductosBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bPromedioProductos;
end;

procedure TQLPromedioVentasNetoProduccion.QRDBText3Print(sender: TObject;
  var Value: String);
begin
//bndDesgloseProductos.
  Value:= DesProducto(DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQLPromedioVentasNetoProduccion.bndCabClienrtesBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bPromedioClientes;
end;

procedure TQLPromedioVentasNetoProduccion.QRDBText7Print(sender: TObject;
  var Value: String);
begin
//bndDesgloseClientes.
//  Value:= DesCliente(DataSet.FieldByName('empresa_cli').AsString, Value );
end;

procedure TQLPromedioVentasNetoProduccion.bndCabPaisBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bPromedioPaises;
end;

procedure TQLPromedioVentasNetoProduccion.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value:= desPais( Value );
end;

procedure TQLPromedioVentasNetoProduccion.QRDBText5Print(sender: TObject;
  var Value: String);
begin
Value:= DesCliente(DataSet.FieldByName('empresa').AsString, Value );
end;

end.
