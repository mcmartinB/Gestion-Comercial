unit UQRCompras;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRCompras = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    Empresa: TQRLabel;
    LCentro: TQRLabel;
    fecha_c: TQRDBText;
    numero_c: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    proveedor_c: TQRDBText;
    QRGroup1: TQRGroup;
    empresa_c: TQRDBText;
    centro_c: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel1: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel5: TQRLabel;
    QRMemo: TQRMemo;
    ref_compra_c: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    quien_compra_c: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure numero_cPrint(sender: TObject; var Value: String);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure empresa_cPrint(sender: TObject; var Value: String);
    procedure centro_cPrint(sender: TObject; var Value: String);
    procedure proveedor_cPrint(sender: TObject; var Value: String);
  private

  public

  end;


implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRCompras.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRCompras.numero_cPrint(sender: TObject; var Value: String);
begin
  Value:= FormatFloat( '00000', DataSet.FieldByName('numero_c').AsInteger );
end;

procedure TQRCompras.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= Trim( DataSet.FieldByName('observaciones_c').AsString ) <> '';
  if PrintBand then
  begin
    QRMemo.Lines.Clear;
    QRMemo.Lines.Add( Trim( DataSet.FieldByName('observaciones_c').AsString ) );
  end;
end;

procedure TQRCompras.empresa_cPrint(sender: TObject; var Value: String);
begin
  Value:= desEmpresa( value );
end;

procedure TQRCompras.centro_cPrint(sender: TObject; var Value: String);
begin
  Value:= desCentro( DataSet.FieldByName('empresa_c').AsString, value );
end;

procedure TQRCompras.proveedor_cPrint(sender: TObject; var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByName('empresa_c').AsString, value );
end;

end.
