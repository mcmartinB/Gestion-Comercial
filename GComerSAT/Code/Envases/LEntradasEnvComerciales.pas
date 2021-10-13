unit LEntradasEnvComerciales;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRLEntradasEnvComerciales = class(TQuickRep)
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
    qrdbtxtcentro_eca: TQRDBText;
    qrdbtxtcentro_eca1: TQRDBText;
    qrdbtxtcont_entradas_c: TQRDBText;
    qrdbtxtcod_producto_eca: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel3: TQRLabel;
    QRLabel3: TQRLabel;
    qrdbtxtcod_producto_eca1: TQRDBText;
    qrdbtxtfecha_eca: TQRDBText;
    qrdbtxtstock_eca: TQRDBText;
    qrdbtxt1: TQRDBText;
    qrdbtxtcod_producto_ece: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxtcod_producto_ece1: TQRDBText;
    qrdbtxtreferencia_ece: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure qrdbtxtcentro_eca1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcod_producto_eca1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcod_producto_ecePrint(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public

  end;

var
  QRLEntradasEnvComerciales: TQRLEntradasEnvComerciales;

implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRLEntradasEnvComerciales.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLEntradasEnvComerciales.qrdbtxtcentro_eca1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( DataSet.FieldByname('empresa_ece').AsString, Value );
end;

procedure TQRLEntradasEnvComerciales.qrdbtxtcod_producto_eca1Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvComerAlmacen( DataSet.FieldByname('cod_operador_ece').AsString, Value );
end;

procedure TQRLEntradasEnvComerciales.qrdbtxtcod_producto_ecePrint(sender: TObject;
  var Value: String);
begin
  Value:= desEnvComerProducto( DataSet.FieldByname('cod_operador_ece').AsString, Value );
end;

end.
