unit LInventarioEnvComerciales;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRLInventarioEnvComerciales = class(TQuickRep)
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
    descripcion_c: TQRDBText;
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
    nota_ecs: TQRDBText;
    qrlbl1: TQRLabel;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure descripcion_cPrint(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public

  end;

var
  QRLInventarioEnvComerciales: TQRLInventarioEnvComerciales;

implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRLInventarioEnvComerciales.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLInventarioEnvComerciales.descripcion_cPrint(sender: TObject;
  var Value: String);
begin
  Value:= StringReplace( desCentro( DataSet.FieldByname('empresa_ecs').AsString, Value ), 'ALMACEN', '', [] );
  Value:= Trim( StringReplace( Value, 'ALMACÉN', '', [] ) );
end;

procedure TQRLInventarioEnvComerciales.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvComerProducto( DataSet.FieldByname('cod_operador_ecs').AsString, Value );
end;

end.
