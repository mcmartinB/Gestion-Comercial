unit LTipoCostes;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLTipoCostes = class(TQuickRep)
    QRBand3: TQRBand;
    LCodigo: TQRLabel;
    LDescripcion: TQRLabel;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    fecha: TQRSysData;
    QRDBText3: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText4: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLMarcasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText3Print(sender: TObject; var Value: string);
    procedure QRDBText4Print(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLTipoCostes: TQRLTipoCostes;

implementation

uses CVariables, UDMAuxDB;

{$R *.DFM}

procedure TQRLTipoCostes.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLTipoCostes.QRLMarcasBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TQRDBText then
    begin
      TQRDBText(Components[i]).DataSet := DataSet;
    end;
  end;
end;

procedure TQRLTipoCostes.QRDBText3Print(sender: TObject;
  var Value: string);
var
  sAux: string;
  bFlag: boolean;
begin
  if DataSet.FieldByName('aplic_primera_etc').AsInteger <> 0 then
  begin
    bFlag := True;
    sAux := '1ª';
  end
  else
  begin
    bFlag := False;
    sAux := '';
  end;
  if DataSet.FieldByName('aplic_segunda_etc').AsInteger <> 0 then
  begin
    if bFlag then
    begin
      sAux := sAux + ', 2ª';
    end
    else
    begin
      bFlag := true;
      sAux := '2ª';
    end;
  end;
  if DataSet.FieldByName('aplic_tercera_etc').AsInteger <> 0 then
  begin
    if bFlag then
    begin
      sAux := sAux + ', 3ª';
    end
    else
    begin
      bFlag := true;
      sAux := '3ª';
    end;
  end;
  if DataSet.FieldByName('aplic_destrio_etc').AsInteger <> 0 then
  begin
    if bFlag then
    begin
      sAux := sAux + ', Destrio';
    end
    else
    begin
      sAux := 'Destrio';
    end;
  end;
  Value := sAux;
end;

procedure TQRLTipoCostes.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  if Value <> ''  then
    Value:= Value + '-' + DesCentro( '050', Value );
end;

end.
