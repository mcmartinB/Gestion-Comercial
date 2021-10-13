unit LiquidacionEntregaQL;

interface


uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLLiquidacionEntrega = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel7: TQRLabel;
    bndEntrega: TQRBand;
    producto: TQRDBText;
    variedad: TQRDBText;
    calibre: TQRDBText;
    entrega: TQRDBText;
    bndGastos: TQRSubDetail;
    lblTipoGastos: TQRLabel;
    lblGastos: TQRLabel;
    bndCabGastos: TQRBand;
    bndPieGastos: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    lblDesGastos: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel17: TQRLabel;
    lblResultadoRem: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel41: TQRLabel;
    lblCuadreKg: TQRLabel;
    totalCompra: TQRDBText;
    totalKgCompra: TQRDBText;
    totalVenta: TQRDBText;
    totalKgVenta: TQRDBText;
    pendienteVenta: TQRDBText;
    totalKgDestrio: TQRDBText;
    totalDestrio: TQRDBText;
    ajusteKgVenta: TQRDBText;
    ajusteKgDestrio: TQRDBText;
    totalAbonos: TQRDBText;
    lblCheckCte: TQRLabel;
    qrbnd1: TQRBand;
    qrsysdt1: TQRSysData;
    procedure bndEntregaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndGastosNeedData(Sender: TObject; var MoreData: Boolean);
    procedure bndGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure productoPrint(sender: TObject; var Value: String);
    procedure variedadPrint(sender: TObject; var Value: String);
    procedure calibrePrint(sender: TObject; var Value: String);
  private
    iGastoActual: integer;

  public

    procedure PreparaListado;
  end;

   function VerLiquidacionEntrega( const AOwner: TComponent; const ACodigo: string): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, LiquidacionEntregaDL, DPreview, UDMAuxDB, bMath;

var
  QLLiquidacionEntrega: TQLLiquidacionEntrega;

function VerLiquidacionEntrega( const AOwner: TComponent; const ACodigo: string): Boolean;
begin
  Result:= True;
  QLLiquidacionEntrega:= TQLLiquidacionEntrega.Create( AOwner );
  try
    QLLiquidacionEntrega.PreparaListado;
    Previsualiza( QLLiquidacionEntrega );
  finally
    FreeAndNil( QLLiquidacionEntrega );
  end;
end;

procedure TQLLiquidacionEntrega.PreparaListado;
begin
  //PonLogoGrupoBonnysa( self, AEmpresa );
  //lblCentro.Caption:= DesCentro( AEmpresa, ACentro );
  lblTitulo.Caption:= 'LIQUIDACIÓN REMESA DE ENTREGA';
end;

procedure TQLLiquidacionEntrega.bndEntregaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  iGastoActual:= 0;
end;

procedure TQLLiquidacionEntrega.bndGastosNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= iGastoActual < DLLiquidacionEntrega.iTipoGastos;
end;

procedure TQLLiquidacionEntrega.bndGastosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  sAux: string;
begin
  sAux:= DLLiquidacionEntrega.aTipoGastos[ iGastoActual ];
  lblTipoGastos.Caption:= sAux;
  lblDesGastos.Caption:= desTipoGastos( sAux );
  lblGastos.Caption:= FormatFloat( '#,##0.00', DataSet.FieldByName( 'g'+sAux).AsFloat );
  iGastoActual:= iGastoActual + 1;
end;

procedure TQLLiquidacionEntrega.bndPieGastosBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  rAux: real;
begin
  with DataSet do
  begin
    rAux:= FieldByname('totalCompra').AsFloat +
           FieldByname('totalVenta').AsFloat +
           FieldByname('totalDestrio').AsFloat +
           FieldByname('totalAbonos').AsFloat +
          FieldByname('pendienteVenta').AsFloat;
    lblResultadoRem.Caption:= FormatFloat( '#,##0.00', rAux );

    rAux:= FieldByname('totalKgCompra').AsFloat +
           FieldByname('totalKgVenta').AsFloat +
           FieldByname('totalKgDestrio').AsFloat +
           FieldByname('ajusteKgVenta').AsFloat +
          FieldByname('ajusteKgDestrio').AsFloat;
    lblCuadreKg.Caption:= FormatFloat( '#,##0.00', rAux );

    lblCheckCte.Caption:= FormatFloat( '#,##0.00', 0 );
  end;
end;

procedure TQLLiquidacionEntrega.productoPrint(sender: TObject;
  var Value: String);
begin
  if Value = '' then
    Value:= 'TODOS LOS PRODUCTOS'
  else
   Value:= Value + ' ' + desProducto( '078', Value );
end;

procedure TQLLiquidacionEntrega.variedadPrint(sender: TObject;
  var Value: String);
begin
  if Value = '' then
    Value:= 'TODAS LAS VARIEDADES'
  else
   Value:= Value + ' ' + desVariedad( '078', Dataset.FieldByName('proveedor').AsString,
                                      Dataset.FieldByName('producto').AsString, Value );
end;

procedure TQLLiquidacionEntrega.calibrePrint(sender: TObject;
  var Value: String);
begin
  if Value = '' then
    Value:= 'TODOS'
  else
   Value:= Value;
end;

end.
