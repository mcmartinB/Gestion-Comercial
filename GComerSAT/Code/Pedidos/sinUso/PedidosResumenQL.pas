unit PedidosResumenQL;

interface

uses
  Classes, Controls, ExtCtrls, QuickRpt, Qrctrls, Db, DBTables;

type
  TQLPedidosResumen = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    bndDetalle: TQRBand;
    QRSysData2: TQRSysData;
    QRDBText3: TQRDBText;
    QRSysData3: TQRSysData;
    QRDBText14: TQRDBText;
    QRDBText4: TQRDBText;
    lCliente: TQRLabel;
    lFechas: TQRLabel;
    lCentro: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRDBText2: TQRDBText;
    bndCabUnidad: TQRGroup;
    bndPieUnidad: TQRBand;
    QRLabel7: TQRLabel;
    lbACajas: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape1: TQRShape;
    lblSinPedidos: TQRLabel;
    lblHaySinPedidos: TQRLabel;
    Query1: TQuery;
    lSuministro: TQRLabel;
    lbCajas: TQRLabel;
    lbUnidades: TQRLabel;
    lbKilos: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    lbAUnidades: TQRLabel;
    lbAKilos: TQRLabel;
    procedure QRDBText4Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRLabel7Print(sender: TObject; var Value: String);
    procedure bndPieUnidadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
    rAKilos: real;
    iACajas, iAUnidades: integer;

    procedure GetCajasKilosUnidades( var AKilos: real; var ACajas, AUnidades: integer );
  public
    sEmpresa: String;
  end;

implementation

{$R *.DFM}

uses PedidosResumenDL, UDMAuxDB, SysUtils, bMath;

procedure TQLPedidosResumen.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rAKilos:= 0;
  iACajas:= 0;
  iAUnidades:= 0;
end;

procedure TQLPedidosResumen.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvase(sEmpresa, Value );
end;

procedure TQLPedidosResumen.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto(sEmpresa, Value );
end;

procedure TQLPedidosResumen.QRLabel7Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL KILOS';
end;

procedure TQLPedidosResumen.bndPieUnidadBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbAKilos.Caption:= FormatFloat( '#,##0.00', rAKilos );
  lbACajas.Caption:= FormatFloat( '#,##0', iACajas );
  lbAUnidades.Caption:= FormatFloat( '#,##0', iAUnidades );
  rAKilos:= 0;
  iACajas:= 0;
  iAUnidades:= 0;
end;

procedure TQLPedidosResumen.GetCajasKilosUnidades( var AKilos: real; var ACajas, AUnidades: integer );
var
  rPesoCaja: real;
  iUnidadesCaja: integer;
begin
  if Trim( Query1.SQL.Text ) = '' then
  begin
    Query1.SQL.Add(' select peso_neto_e, nvl(unidades_e,1) unidades_e');
    Query1.SQL.Add(' from frf_envases ');
    Query1.SQL.Add(' where empresa_e = :empresa ');
    Query1.SQL.Add(' and envase_e = :envase ');
    Query1.SQL.Add(' and producto_base_e = ');
    Query1.SQL.Add(' ( select producto_base_p ');
    Query1.SQL.Add('   from frf_productos ');
    Query1.SQL.Add('   where empresa_p = :empresa ');
    Query1.SQL.Add('     and producto_p = :producto ');
    Query1.SQL.Add(' ) ');
  end;
  Query1.ParamByName('empresa').AsString:= sEmpresa;
  Query1.ParamByName('envase').AsString:= DataSet.FieldByName('envase').AsString;
  Query1.ParamByName('producto').AsString:= DataSet.FieldByName('producto').AsString;
  Query1.Open;
  if Query1.IsEmpty then
  begin
    rPesoCaja:= 0;
    iUnidadesCaja:= 0;
  end
  else
  begin
    rPesoCaja:= Query1.FieldByName('peso_neto_e').AsFloat;
    iUnidadesCaja:= Query1.FieldByName('unidades_e').AsInteger;
  end;
  Query1.Close;

  if DataSet.FieldByName('unidad').AsString = 'C' then
  begin
    ACajas:= DataSet.FieldByName('unidades_pedidas').AsInteger;
    AKilos:= bRoundTo( ACajas * rPesoCaja, -2 );
    AUnidades:= ACajas * iUnidadesCaja;
  end
  else
  if DataSet.FieldByName('unidad').AsString = 'U' then
  begin
    AUnidades:= DataSet.FieldByName('unidades_pedidas').AsInteger;
    if iUnidadesCaja > 0 then
    begin
      ACajas:= AUnidades div iUnidadesCaja;
    end;
    AKilos:= bRoundTo( ACajas * rPesoCaja, -2 );
  end
  else
  begin
    AKilos:= bRoundTo( DataSet.FieldByName('unidades_pedidas').AsFloat, -2 );
    if rPesoCaja > 0 then
    begin
      ACajas:= Trunc( AKilos / rPesoCaja );
    end;
    AUnidades:= ACajas * iUnidadesCaja;
  end;
end;

procedure TQLPedidosResumen.bndDetalleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  rKilos: real;
  iCajas, iUnidades: integer;
begin
  GetCajasKilosUnidades( rKilos, iCajas, iUnidades );

  rAKilos:= rAKilos + rKilos;
  iAUnidades:= iAUnidades + iUnidades;
  iAcajas:= iACajas + iCajas;

  lbKilos.Caption:= FormatFloat('#,##0.00', rKilos );
  lbUnidades.Caption:= FormatFloat('#,##0', iUnidades );
  lbCajas.Caption:= FormatFloat('#,##0', iCajas );
end;

end.
