unit GastosProveedorQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLGastosProveedor = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    bndCabecera: TQRBand;
    DetailBand1: TQRBand;
    LAlbaran: TQRLabel;
    LFecha: TQRLabel;

    LVariable: TQRLabel;
    LTitulo: TQRLabel;
    DBAlbaran: TQRDBText;
    DBFecha: TQRDBText;
    DBVariable: TQRDBText;
    PsQRSysData1: TQRSysData;
    LPeriodo: TQRLabel;
    DBCliente: TQRDBText;
    LMatricula: TQRLabel;
    DBMatricula: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    lblTipoGastos: TQRLabel;
    lblCliente: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel4: TQRLabel;
    lblKilosTitulo: TQRLabel;
    SummaryBand1: TQRBand;
    QRExpr2: TQRExpr;
    lblAcumKilos: TQRLabel;
    lblProducto: TQRLabel;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure DBClientePrint(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure lblAcumKilosPrint(sender: TObject; var Value: String);
  private
    rAcumKilos: real;
  public
    sEmpresa: string;
    bVariosTipos: boolean;
  end;

var
  QLGastosProveedor: TQLGastosProveedor;

implementation

{$R *.DFM}

uses
  GastosProveedorFL, UDMAuxDB;

procedure TQLGastosProveedor.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProveedor( sEmpresa, value );
end;

procedure TQLGastosProveedor.DBClientePrint(sender: TObject;
  var Value: String);
begin
  Value:= desTipoGastos( value );
end;

procedure TQLGastosProveedor.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  if ( DataSet.FieldByName('tipo').AsString = '110' ) or not bVariosTipos then
  begin
    rAcumKilos:= rAcumKilos + DataSet.FieldByName('kilos').AsFloat;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLGastosProveedor.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rAcumKilos:= 0;
end;

procedure TQLGastosProveedor.lblAcumKilosPrint(sender: TObject;
  var Value: String);
begin
  value:= FormatFloat( '#,##0.00', rAcumKilos );
end;

end.
