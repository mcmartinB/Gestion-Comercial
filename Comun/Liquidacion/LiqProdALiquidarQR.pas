unit LiqProdALiquidarQR;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables, grimgctrl;
type
  TQRLiqProdALiquidar = class(TQuickRep)
    qrbndBandaDetalle: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRLabel6: TQRLabel;
    qtxtempresa_liq: TQRDBText;
    qrlbl15: TQRLabel;
    qrgrpCentro: TQRGroup;
    qtxtcentro_ent: TQRDBText;
    qtxtproducto_ent: TQRDBText;
    qrlbl3: TQRLabel;
    qrlblCentro: TQRLabel;
    qrlblperiodo: TQRLabel;
    procedure qtxtempresa_liqPrint(sender: TObject; var Value: String);
    procedure qtxtproducto_entPrint(sender: TObject; var Value: String);
    procedure qtxtcentro_entPrint(sender: TObject; var Value: String);
  private

  public

  end;

  procedure Imprimir( const ADIni, ADFin: TDateTime );

implementation

uses
  LiqProdVendidoDM, UDMAuxDB, DPreview;

{$R *.DFM}

procedure Imprimir( const ADIni, ADFin: TDateTime );
var
  QRLiqProdALiquidar: TQRLiqProdALiquidar;
begin
  QRLiqProdALiquidar:= TQRLiqProdALiquidar.Create( nil );
  try
    QRLiqProdALiquidar.qrlblperiodo.caption:= 'del ' + FormatFloat('dd/mm/yy', ADIni ) + ' al ' + FormatFloat('dd/mm/yy', ADFin );
    Preview( QRLiqProdALiquidar );
  except
    FreeAndNil( QRLiqProdALiquidar );
  end;
end;

procedure TQRLiqProdALiquidar.qtxtempresa_liqPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desEmpresa( Value );
end;

procedure TQRLiqProdALiquidar.qtxtproducto_entPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' - '  + desProducto( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRLiqProdALiquidar.qtxtcentro_entPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - '  + descentro( DataSet.FieldByName('empresa').AsString, Value );
end;

end.
