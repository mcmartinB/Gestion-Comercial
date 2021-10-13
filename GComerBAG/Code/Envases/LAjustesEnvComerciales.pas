unit LAjustesEnvComerciales;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRLAjustesEnvComerciales = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    Empresa: TQRLabel;
    QRLabel2: TQRLabel;
    empresa_c: TQRDBText;
    centro_c: TQRDBText;
    nota_Ecc: TQRDBText;
    qrdbtxtcont_entradas_c: TQRDBText;
    cont_albaranes_c: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel3: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxtcentro_ecc: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure qrdbtxtcentro_eccPrint(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public

  end;

var
  QRLAjustesEnvComerciales: TQRLAjustesEnvComerciales;

implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRLAjustesEnvComerciales.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLAjustesEnvComerciales.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvComerProducto( DataSet.FieldByname('cod_operador_ecc').AsString, Value );
end;

procedure TQRLAjustesEnvComerciales.qrdbtxtcentro_eccPrint(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( DataSet.FieldByname('empresa_ecc').AsString, Value );
  Value:= StringReplace( Value, 'ALMACEN', '', []);
  Value:= Trim( StringReplace( Value, 'ALMACÉN', '', []) );
end;

end.
