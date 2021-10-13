unit LInventarioMaterialProveedor;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRLInventarioMaterialProveedor = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
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
    nota_esm: TQRDBText;
    qrlbl1: TQRLabel;
    qrgrpProveedor: TQRGroup;
    qrdbtxt1: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrlbl2: TQRLabel;
    qrdbtxt_c: TQRDBText;
    qrdbtxt_c1: TQRDBText;
    qrlbl3: TQRLabel;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure qrdbtxt_c2Print(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure qrdbtxt2Print(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public

  end;

var
  QRLInventarioMaterialProveedor: TQRLInventarioMaterialProveedor;

implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRLInventarioMaterialProveedor.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLInventarioMaterialProveedor.qrdbtxt_c2Print(sender: TObject;
  var Value: String);
begin
  Value:= StringReplace( desCentro( DataSet.FieldByname('empresa_esm').AsString, Value ), 'ALMACEN', '', [] );
  Value:= Trim( StringReplace( Value, 'ALMACÉN', '', [] ) );
end;

procedure TQRLInventarioMaterialProveedor.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvComerProducto( DataSet.FieldByname('cod_operador_esm').AsString, Value );
end;

procedure TQRLInventarioMaterialProveedor.qrdbtxt2Print(sender: TObject;
  var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByname('empresa_esm').AsString, Value );
end;

end.
