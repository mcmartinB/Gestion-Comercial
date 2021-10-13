unit LEntradasEnvProveedor;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRLEntradasEnvProveedor = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    qrdbtxtcont_entradas_c: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRLabel3: TQRLabel;
    qrdbtxtentrada_pm: TQRDBText;
    qrdbtxt1: TQRDBText;
    qrdbtxtcod_producto_pm: TQRDBText;
    qrdbtxtreferencia_pm: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrdbtxtcantidad_pm: TQRDBText;
    qrdbtxtfecha_em: TQRDBText;
    qrlbl4: TQRLabel;
    qrgrpProveedor: TQRGroup;
    qrdbtxt2: TQRDBText;
    qrdbtxt3: TQRDBText;
    qrdbtxtcod_proveedor_em1: TQRDBText;
    qrdbtxtcod_proveedor_em: TQRDBText;
    qrlbl5: TQRLabel;
    qrlbl1: TQRLabel;
    qrxprDif: TQRExpr;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure qrdbtxtcod_producto_pmPrint(sender: TObject; var Value: String);
    procedure qrgrpCentroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl1Print(sender: TObject; var Value: String);
    procedure qrgrp3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtcentro_emPrint(sender: TObject; var Value: String);
    procedure qrdbtxtcod_proveedor_em1Print(sender: TObject;
      var Value: String);
  private
    sEmpresa: string;
  public

  end;

var
  QRLEntradasEnvProveedor: TQRLEntradasEnvProveedor;

implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRLEntradasEnvProveedor.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLEntradasEnvProveedor.qrdbtxtcod_producto_pmPrint(sender: TObject;
  var Value: String);
begin
  Value:= desEnvComerProducto( DataSet.FieldByname('cod_operador_em').AsString, Value );
end;

procedure TQRLEntradasEnvProveedor.qrgrpCentroBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

procedure TQRLEntradasEnvProveedor.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total ' + DataSet.FieldByname('cod_operador_em').AsString +
          '/' +  DataSet.FieldByname('cod_producto_em').AsString;
end;

procedure TQRLEntradasEnvProveedor.qrgrp3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

procedure TQRLEntradasEnvProveedor.qrdbtxtcentro_emPrint(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( DataSet.FieldByname('empresa_em').AsString, Value );
end;

procedure TQRLEntradasEnvProveedor.qrdbtxtcod_proveedor_em1Print(
  sender: TObject; var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByname('empresa_em').AsString, Value );
end;

end.
