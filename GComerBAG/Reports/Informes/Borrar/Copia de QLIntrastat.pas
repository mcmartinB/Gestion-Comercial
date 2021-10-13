unit QLIntrastat;

interface

uses Classes, Controls, StdCtrls, ExtCtrls,
  Quickrpt, Graphics, Qrctrls, SysUtils;
type
  TQRLIntrastat = class(TQuickRep)
    DetailBand1: TQRBand;
    QRGroup1: TQRGroup;
    ChildBand1: TQRChildBand;
    PsQRLabel23: TQRLabel;
    PsQRShape18: TQRShape;
    PsQRLabel17: TQRLabel;
    PsQRShape13: TQRShape;
    PsQRLabel18: TQRLabel;
    PsQRShape14: TQRShape;
    PsQRLabel19: TQRLabel;
    PsQRShape15: TQRShape;
    PsQRLabel20: TQRLabel;
    PsQRShape16: TQRShape;
    PsQRLabel21: TQRLabel;
    PsQRShape17: TQRShape;
    PsQRLabel22: TQRLabel;
    QRGroup2: TQRGroup;
    QRLabel1: TQRLabel;
    QRBand1: TQRBand;
    PsQRLabel10: TQRLabel;
    PsQRDBText2: TQRDBText;
    PsQRLabel8: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRShape2: TQRShape;
    PsQRShape4: TQRShape;
    PsQRShape6: TQRShape;
    PsQRShape8: TQRShape;
    PsQRShape10: TQRShape;
    PsQRShape12: TQRShape;
    QRLabel2: TQRLabel;
    QRExpr1: TQRExpr;
    QRBand2: TQRBand;
    QRMemo1: TQRMemo;
    QRMemo2: TQRMemo;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    procedure PsQRLabel11Print(sender: TObject; var Value: string);
    procedure Linea4Print(sender: TObject; var Value: string);
    procedure PsQRLabel10Print(sender: TObject; var Value: string);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure PsQRDBText2Print(sender: TObject; var Value: String);
    procedure PsQRDBText1Print(sender: TObject; var Value: String);
  private

  public
    sMes, sAnyo: string;
    bComunitario: Boolean;
  end;

var
  QRLIntrastat: TQRLIntrastat;

implementation

uses Lintrastat, UDMAuxDB, UDMBaseDatos, bTextUtils;

{$R *.DFM}

procedure TQRLIntrastat.PsQRLabel11Print(sender: TObject;
  var Value: string);
begin
  if bComunitario then
  begin
    if DMBaseDatos.QListado.FieldByName('centro').asstring = '1' then
      value := 'CENTRO ALICANTE.'
    else
    if DMBaseDatos.QListado.FieldByName('centro').asstring = '2' then
      value := 'CENTRO ALMERÍA.'
    else
    if DMBaseDatos.QListado.FieldByName('centro').asstring = '6' then
      value := 'CENTRO TENERIFE.'
    else
      value := 'OTROS CENTROS.';
  end
  else
  begin
    value := 'PAISES NO COMUNITARIOS';
  end;
end;

procedure TQRLIntrastat.Linea4Print(sender: TObject; var Value: string);
begin
  Value := sMes + ' de ' + sAnyo + ' las siguientes expediciones: '
end;

procedure TQRLIntrastat.PsQRLabel10Print(sender: TObject;
  var Value: string);
begin
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'TOMATES FRESCOS' then
    Value := '0702.00.00'
  else
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'BREVAS' then
    Value := '0804.20.10'
  else
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'LIMONES' then
    Value := '0805.50.10'
  else
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'NARANJAS' then
    Value := '0805.10.30'
  else
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'PIMIENTOS' then
    Value := '0709.60.10'
  else
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'MELONES' then
    Value := '0807.19.10'
  else
    Value := '0000.00.00';
end;

procedure TQRLIntrastat.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRGroup2.Height:= 0;
  DetailBand1.Height:= 0;
end;

procedure TQRLIntrastat.PsQRDBText2Print(sender: TObject;
  var Value: String);
begin
  Value:= CapitalCase( Value );
end;

procedure TQRLIntrastat.PsQRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= CapitalCase( Value );
end;

end.
