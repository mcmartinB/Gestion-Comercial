unit ListadoFacturasQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRListadoFacturas = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    PsQRDBText8: TQRDBText;
    PsQRLabel9: TQRLabel;
    PsQRExpr1: TQRExpr;
    PsQRSysData1: TQRSysData;
    lblTitulo: TQRLabel;
    lblFechas: TQRLabel;
    LCliente: TQRLabel;
    PsQRDBText9: TQRDBText;
    lblClientes: TQRLabel;
    lblFacturas: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    qrgrpMoneda: TQRGroup;
    qrbndPieMoneda: TQRBand;
    qrlbl1: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrdbtxtn_factura_f: TQRDBText;
    qrlbl2: TQRLabel;
    qrSerie: TQRDBText;
    QRLabel1: TQRLabel;
    procedure LClientePrint(sender: TObject; var Value: string);
    procedure QRListadoFacBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrgrpMonedaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl1Print(sender: TObject; var Value: String);
  private

  public

  end;


implementation

uses UDMAuxDB;

{$R *.DFM}

procedure TQRListadoFacturas.LClientePrint(sender: TObject; var Value: string);
begin
  Value := desCliente(DataSet.FieldByName('cliente_fac_f').AsString);
end;

procedure TQRListadoFacturas.QRListadoFacBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i].ClassType = TQRDBText then
      TQRDBText(Components[i]).DataSet := DataSet;
  end;
end;

procedure TQRListadoFacturas.qrgrpMonedaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgrpMoneda.Height:= 0;
end;

procedure TQRListadoFacturas.qrlbl1Print(sender: TObject; var Value: String);
begin
  Value:= ' TOTAL ' + DataSet.FieldByName('moneda_f').AsString + ':'; 
end;

end.
