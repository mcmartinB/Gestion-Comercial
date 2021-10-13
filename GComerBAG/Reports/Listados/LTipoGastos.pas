unit LTipoGastos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Dialogs;

type
  TQRLTiposGastos = class(TQuickRep)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    tipo_tg: TQRDBText;
    descripcion_tg: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    facturable_tg: TQRDBText;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRSysData3: TQRSysData;
    PsQRLabel1: TQRLabel;
    cta_venta_tg: TQRDBText;
    PsQRLabel2: TQRLabel;
    PsQRDBText1: TQRDBText;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    agrupacion_tg: TQRDBText;
    agrupacion_contable_tg: TQRDBText;
    procedure facturable_tgPrint(sender: TObject; var Value: string);
    procedure QRLTiposGastosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure PsQRDBText1Print(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLTiposGastos: TQRLTiposGastos;

implementation

uses
  MTipoGastos;

{$R *.DFM}

function TipoIva( const ATipo: Integer ): string;
begin

  if ATipo = 0 then
  begin
    result:= 'IVA Super';
  end
  else
  if ATipo = 1 then
  begin
    result:= 'IVA Reducido';
  end
  else
  if ATipo = 2 then
  begin
    result:= 'IVA General';
  end
  else
  begin
    result:= '';
  end;
end;

procedure TQRLTiposGastos.facturable_tgPrint(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('gasto_transito_tg').AsInteger <> 2 then
  begin
    if value = 'S' then
    begin
      value := TipoIva( DataSet.FieldByName('tipo_iva_tg').AsInteger )
    end
    else
      if value = 'N' then
        value := 'No';
  end
  else
  begin
    value:= '';
  end;
end;

procedure TQRLTiposGastos.QRLTiposGastosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
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

procedure TQRLTiposGastos.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  if value = '0' then
    value := 'Salidas'
  else
  if value = '1' then
    value := 'Transitos'
  else
  if value = '2' then
    value := 'Compras'
  else
    value := '';
end;

procedure TQRLTiposGastos.PsQRDBText1Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('gasto_transito_tg').AsInteger <> 2 then
  begin
    if value = 'S' then
    begin
      value := 'Si '
    end
    else
      if value = 'N' then
        value := 'No';
  end
  else
  begin
    value:= '';
  end;
end;

end.
