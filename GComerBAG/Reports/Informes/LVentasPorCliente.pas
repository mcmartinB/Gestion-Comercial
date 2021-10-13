unit LVentasPorCliente;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

{type  //RICARDO
  APrecios = record
    ind: integer;
    prec: real;
  end;
}
type
  TQRLVentasPorCliente = class(TQuickRep)
    BSub: TQRSubDetail;
    BPieG: TQRBand;
    PsQRDBSemana: TQRDBText;
    PsQRDBKilos: TQRDBText;
    PsQRDBPrecio: TQRDBText;
    DetailBand1: TQRBand;
    PsQRDBCliente: TQRDBText;
    PageHeaderBand1: TQRBand;
    lblProducto: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRETotKilos: TQRExpr;
    PsQRShape1: TQRShape;
    MediaTotal: TQRLabel;
    PsQRSysData3: TQRSysData;
    PsQRShape2: TQRShape;
    lblUnidad: TQRLabel;
    lblPrecio: TQRLabel;
    lblCategorias: TQRLabel;
    lblEnvase: TQRLabel;
    QRBand1: TQRBand;
    PsQRLabel7: TQRLabel;
    lblPeriodo: TQRLabel;
    lblCentro: TQRLabel;
    PsQRSysData2: TQRSysData;
    procedure PsQRDBClientePrint(sender: TObject; var Value: string);
    procedure PsQRDBKilosPrint(sender: TObject; var Value: string);
    procedure PsQRDBSemanaPrint(sender: TObject; var Value: string);
    procedure PsQRDBPrecioPrint(sender: TObject; var Value: string);
    procedure QRLVentasPorClienteBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure PsQRETotKilosPrint(sender: TObject; var Value: string);
    procedure MediaTotalPrint(sender: TObject; var Value: string);
    procedure lblProductoPrint(sender: TObject; var Value: string);
    procedure BSubBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BPieGAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    sCliente: string;
    iSemana, iLineas: integer;
    rKilos, rNeto, rAcuKilos, rAcuNeto: real;
    arKilos, arNeto: array of real;

    procedure AcumularValores( const ALinea: integer; const AKilos, ANeto: real );
  public

  end;

var
  QRLVentasPorCliente: TQRLVentasPorCliente;

implementation

uses LFVentasPorCliente, UDMAuxDB;

{$R *.DFM}


procedure TQRLVentasPorCliente.QRLVentasPorClienteBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  i: integer;
begin
     //Inicializa las variables
  sCliente := '';
  iSemana := 0;
  iLineas := 0;

  rAcuKilos := 0;
  rAcuNeto := 0;
  for i:= 0 to Length( arKilos ) - 1 do
  begin
    arKilos[i]:= 0;
    arNeto[i]:= 0;
  end;
end;

//                       BANDA CABECERA

procedure TQRLVentasPorCliente.lblProductoPrint(sender: TObject;
  var Value: string);
begin
  Value := FLVentasPorCliente.dProducto;
end;

//                      BANDA DETALLE

procedure TQRLVentasPorCliente.PsQRDBClientePrint(sender: TObject;
  var Value: string);
begin
     //si el cliente es ZZZ se escriben los totales y por lo tanto el titulo es TOTAL
  sCliente := Value;
  if sCliente = 'ZZZ' then
    Value := 'TOTALES';
end;

//                     BANDA SUBDETALLE

procedure TQRLVentasPorCliente.BSubBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  //Acumular importe neto de ventas y kilos
  inc(iLineas);
  if sCliente <> 'ZZZ' then
  begin
    AcumularValores( iLineas, BSub.DataSet.FieldByName('kilos_tvc').AsFloat, BSub.DataSet.FieldByName('neto_tvc').AsFloat );
  end;
end;

procedure TQRLVentasPorCliente.PsQRDBSemanaPrint(sender: TObject;
  var Value: string);
begin
     //Se guarda el numero de la semana, para que actue de indice en los acumulados
  iSemana := StrToInt(Copy(value, 4, 3));
  value:= Copy(value, 3, 4);

     //Sólo se escribe el numero de la semana en la primera columna
  if QRLVentasPorCliente.CurrentColumn > 1 then
    Value := '';
end;

procedure TQRLVentasPorCliente.PsQRDBKilosPrint(sender: TObject;
  var Value: string);
begin
  if sCliente = 'ZZZ' then
  begin
    PsQRDBKilos.AutoSize := true;
    value := FormatFloat('#,##0', arKilos[iLineas-1]);
  end
  else
  begin
    value:= FormatFloat('#,##0', BSub.DataSet.FieldByName('kilos_tvc').AsFloat );
  end;
end;

procedure TQRLVentasPorCliente.PsQRDBPrecioPrint(sender: TObject;
  var Value: string);
begin
  //Se saca el precio medio para todos los cliente durante una misma semana
  if sCliente = 'ZZZ' then
  begin
    if arKilos[iLineas-1] > 0 then
    begin
      value := FormatFloat('0.000', arNeto[iLineas-1] / arKilos[iLineas-1] );
    end
    else
    begin
      value := '0,000';
    end;
  end
  else
  begin
    if BSub.DataSet.FieldByName('kilos_tvc').AsFloat <> 0 then
      value := FormatFloat('0.000', BSub.DataSet.FieldByName('neto_tvc').AsFloat / BSub.DataSet.FieldByName('kilos_tvc').AsFloat )
    else
      value := '0,000';
  end;
end;

//               BANDA DEL PIE DE GRUPO

procedure TQRLVentasPorCliente.BPieGAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  NewColumn;
end;

procedure TQRLVentasPorCliente.PsQRETotKilosPrint(sender: TObject;
  var Value: string);
begin
     //Si el cliente es ZZZ se escribe el total de los kilos de todos los clientes
  if sCliente = 'ZZZ' then
  begin
    Value := FormatFloat('#,##0', rAcuKilos);
  end;
end;

procedure TQRLVentasPorCliente.MediaTotalPrint(sender: TObject;
  var Value: string);
begin
  if sCliente = 'ZZZ' then
  begin
    if rAcuKilos <> 0 then
      Value := FormatFloat('0.000', (rAcuNeto / rAcuKilos))
    else
      Value := '0.000';
  end
  else
  begin
    if rKilos <> 0 then
      Value := FormatFloat('0.000', (rNeto / rKilos))
    else
      Value := '0.000';
    end;
end;

procedure TQRLVentasPorCliente.AcumularValores( const ALinea: integer; const AKilos, ANeto: real );
begin
  if Length( arKilos ) < ALinea then
  begin
    SetLength( arKilos, ALinea );
    arKilos[ALinea-1]:= 0;
    SetLength( arNeto, ALinea );
    arNeto[ALinea-1]:= 0;
  end;
  arKilos[ALinea-1]:= arKilos[ALinea-1] + AKilos;
  arNeto[ALinea-1]:= arNeto[ALinea-1] + ANeto;
  rNeto := rNeto + ANeto;
  rKilos := rKilos + AKilos;
  rAcuNeto := rAcuNeto + ANeto;
  rAcuKilos := rAcuKilos + AKilos;
end;

procedure TQRLVentasPorCliente.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  iLineas:= 0;
  rKilos:= 0;
  rNeto:= 0;
end;

end.
