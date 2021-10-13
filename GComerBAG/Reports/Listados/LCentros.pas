unit LCentros;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRLCentros = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    Empresa: TQRLabel;
    LCentro: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    empresa_c: TQRDBText;
    centro_c: TQRDBText;
    descripcion_c: TQRDBText;
    cont_entradas_c: TQRDBText;
    cont_albaranes_c: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel3: TQRLabel;
    ChildBand1: TQRChildBand;
    lblDireccion: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRGroup1: TQRGroup;
    QRLabel5: TQRLabel;
    QRBand2: TQRBand;
    ChildBand2: TQRChildBand;
    QRDBText4: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLCentrosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure empresa_cPrint(sender: TObject; var Value: String);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText4Print(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public

  end;

var
  QRLCentros: TQRLCentros;

implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}

procedure TQRLCentros.QRLCentrosBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i].ClassType = TQRDBText then
      TQRDBText(Components[i]).DataSet := DataSet;
  end;
  sEmpresa:= '';
end;

procedure TQRLCentros.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLCentros.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Sender.Height:= 1;
end;

procedure TQRLCentros.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  Value: string;
begin
  Value := Trim(DataSet.FieldByName('direccion_c').AsString);

  if Value <> '' then
  begin
    if Trim(DataSet.FieldByName('poblacion_c').AsString) <> '' then
    begin
      Value := Value + ' (' + Trim(DataSet.FieldByName('poblacion_c').AsString) + ')';
    end;
  end
  else
    Value := Trim(DataSet.FieldByName('poblacion_c').AsString);

  if Value <> '' then
  begin
    if Trim(DataSet.FieldByName('cod_postal_c').AsString) <> '' then
    begin
      if (Trim(DataSet.FieldByName('direccion_c').AsString) = '') or
        (Trim(DataSet.FieldByName('poblacion_c').AsString) = '') then
        Value := Value + ' - ' + Trim(DataSet.FieldByName('cod_postal_c').AsString)
      else
        Value := Value + ' ' + Trim(DataSet.FieldByName('cod_postal_c').AsString);
    end;
  end
  else
    Value := Trim(DataSet.FieldByName('cod_postal_c').AsString);

  if DataSet.FieldByName('pais_c').AsString <> 'ES' then
  begin
    if Value <> '' then
      Value:= Value + ', ' + DesPais( DataSet.FieldByName('pais_c').AsString )
    else
      Value:= DesPais( DataSet.FieldByName('pais_c').AsString );
  end;

  lblDireccion.Caption:= Value;
  PrintBand:= Value <> '';
end;

procedure TQRLCentros.empresa_cPrint(sender: TObject; var Value: String);
begin
  if Value <> sEmpresa then
  begin
    sEmpresa:= Value;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLCentros.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= TRIM(DataSet.FieldByName('email_c').AsString) <> '';
end;

procedure TQRLCentros.QRDBText4Print(sender: TObject; var Value: String);
begin
  Value:= 'E-Mail: ' + Value;
end;

end.
