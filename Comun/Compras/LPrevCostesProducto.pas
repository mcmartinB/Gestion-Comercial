unit LPrevCostesProducto;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRLPrevCostesProducto = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    LCentro: TQRLabel;
    QRLabel2: TQRLabel;
    qrdbtxtempresa_eca: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel3: TQRLabel;
    QRLabel3: TQRLabel;
    qrdbtxtfecha_eca: TQRDBText;
    qrdbtxtstock_eca: TQRDBText;
    qrdbtxt1: TQRDBText;
    qrdbtxtcod_producto_ece: TQRDBText;
    qrdbtxtfecha_ece: TQRDBText;
    qrdbtxtcantidad_ece: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrdbtxtcoste_primera_pcp: TQRDBText;
    qrdbtxtcoste_resto_pcp: TQRDBText;
    qrdbtxtcoste_producto_pcp: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure qrdbtxtcentro_eca1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcod_producto_ecePrint(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLPrevCostesProducto: TQRLPrevCostesProducto;

implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRLPrevCostesProducto.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLPrevCostesProducto.qrdbtxtcentro_eca1Print(sender: TObject;
  var Value: String);
begin
  Value:= desEmpresa( Value );
end;

procedure TQRLPrevCostesProducto.qrdbtxtcod_producto_ecePrint(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByname('empresa_pcp').AsString, Value );
end;

end.
