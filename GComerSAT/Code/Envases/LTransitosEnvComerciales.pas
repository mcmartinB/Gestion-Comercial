unit LTransitosEnvComerciales;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRLTransitosEnvComerciales = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    LCentro: TQRLabel;
    QRLabel2: TQRLabel;
    qrdbtxtcentro_destino_ect: TQRDBText;
    qrdbtxtcont_entradas_c: TQRDBText;
    qrdbtxtcod_producto_ect: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel3: TQRLabel;
    QRLabel3: TQRLabel;
    qrdbtxtcod_producto_ect1: TQRDBText;
    qrdbtxtfecha_ect: TQRDBText;
    QRDBText3: TQRDBText;
    qrgrp1: TQRGroup;
    qrdbtxt1: TQRDBText;
    qrdbtxtcentro_ect1: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxtnota_ect: TQRDBText;
    qrlbl2: TQRLabel;
    qrdbtxtempresa_ect1: TQRDBText;
    qrdbtxtplanta_destino_ect: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure qrdbtxtcod_producto_ect1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcentro_ect1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcentro_destino_ectPrint(sender: TObject;
      var Value: String);
  private
    sEmpresa: string;
  public

  end;

var
  QRLTransitosEnvComerciales: TQRLTransitosEnvComerciales;

implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRLTransitosEnvComerciales.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLTransitosEnvComerciales.qrdbtxtcod_producto_ect1Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvComerProducto( DataSet.FieldByname('cod_operador_ect').AsString, Value );
end;

procedure TQRLTransitosEnvComerciales.qrdbtxtcentro_ect1Print(
  sender: TObject; var Value: String);
begin
  Value:= desCentro( DataSet.FieldByname('empresa_ect').AsString, Value );
end;

procedure TQRLTransitosEnvComerciales.qrdbtxtcentro_destino_ectPrint(
  sender: TObject; var Value: String);
begin
  Value:= StringReplace( desCentro( DataSet.FieldByname('empresa_ect').AsString, Value ), 'ALMACEN', '', [] );
  Value:= Trim( StringReplace( Value, 'ALMACÉN', '', [] ) );
end;

end.
