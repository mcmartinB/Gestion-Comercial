unit UQRDestrioDiario;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRDestrioDiario = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    Empresa: TQRLabel;
    LCentro: TQRLabel;
    fecha_de: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    unidades_de: TQRDBText;
    QRGroup1: TQRGroup;
    empresa_c: TQRDBText;
    centro_c: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    destrio_de: TQRDBText;
    QRLabel3: TQRLabel;
    unidad_de: TQRDBText;
    producto_de: TQRDBText;
    QRLabel4: TQRLabel;
    porcentaje_de: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    procedure empresa_cPrint(sender: TObject; var Value: String);
    procedure centro_cPrint(sender: TObject; var Value: String);
    procedure producto_dePrint(sender: TObject; var Value: String);
    procedure unidad_dePrint(sender: TObject; var Value: String);
  private

  public

  end;


implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRDestrioDiario.empresa_cPrint(sender: TObject; var Value: String);
begin
  Value:= desEmpresa( value );
end;

procedure TQRDestrioDiario.centro_cPrint(sender: TObject; var Value: String);
begin
  Value:= desCentro( DataSet.FieldByName('empresa_de').AsString, value );
end;

procedure TQRDestrioDiario.producto_dePrint(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByName('empresa_de').AsString, value );
end;

procedure TQRDestrioDiario.unidad_dePrint(sender: TObject;
  var Value: String);
begin
  if Value = 'K' then
    Value:= 'Kilos'
  else
    Value:= 'Unidades';
end;

end.
