unit LClientesAlm;

interface

uses SysUtils, DBTables, Classes, Controls, ExtCtrls, QuickRpt,
  Graphics, Qrctrls, Db;
type
  TQRLClientesAlm = class(TQuickRep)
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRSysData1: TQRSysData;
    DetailBand1: TQRBand;
    cliente_c: TQRDBText;
    PsQRLabel3: TQRLabel;
    nif_c: TQRDBText;
    PsQRLabel4: TQRLabel;
    telefono_c: TQRDBText;
    domicilio_c: TQRDBText;
    poblacion_c: TQRDBText;
    cod_postal_c: TQRDBText;
    nombre_c: TQRDBText;
    tipo_via_c: TQRDBText;
    PsQRDBText11: TQRDBText;
    PsQRLabel7: TQRLabel;
    PsQRDBText14: TQRDBText;
    PsQRLabel8: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRLabel10: TQRLabel;
    QRSubDetail: TQRSubDetail;
    dir_sum_ds: TQRDBText;
    nombre_ds: TQRDBText;
    tipo_via_ds: TQRDBText;
    domicilio_ds: TQRDBText;
    cod_postal_ds: TQRDBText;
    provincia_ds: TQRDBText;
    poblacion_ds: TQRDBText;
    telefono_ds: TQRDBText;
    pais_ds: TQRDBText;
    PsQRLabel12: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    PsQRLabel15: TQRLabel;
    PsQRLabel16: TQRLabel;
    DSDescripciones: TDataSource;
    QDescripciones: TQuery;
    grupoEmpresa: TQRGroup;
    telefono2_c: TQRDBText;
    fax_c: TQRDBText;
    QRLabel2: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    es_comunitario_c: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure LDireccionPrint(sender: TObject; var Value: string);
    procedure QRSubDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure provincia_dsPrint(sender: TObject; var Value: string);
    procedure pais_dsPrint(sender: TObject; var Value: string);
    procedure es_comunitario_cPrint(sender: TObject; var Value: String);
  private
    conta: integer;
  public

  end;

var
  QRLClientesAlm: TQRLClientesAlm;

implementation

uses
  UDMAuxDB, UDMBaseDatos;

{$R *.DFM}

procedure TQRLClientesAlm.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLClientesAlm.LDireccionPrint(sender: TObject;
  var Value: string);
begin
  Value := IntToStr(Conta) + 'ª ' + Value;
end;

procedure TQRLClientesAlm.QRSubDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Inc(Conta);
end;

procedure TQRLClientesAlm.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Conta := 0;
end;

procedure TQRLClientesAlm.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Trim(DMBaseDatos.QGeneral.FieldByName('tipo_via_c').AsString) = '' then
  begin
    domicilio_c.Left := 75;
    tipo_via_c.Enabled := False;
  end
  else
  begin
    domicilio_c.Left := 100;
    tipo_via_c.Enabled := True;
  end;
end;

procedure TQRLClientesAlm.provincia_dsPrint(sender: TObject;
  var Value: string);
begin
  if provincia_ds.DataSet.FieldByName('pais_ds').AsString = 'ES' then
    Value := desProvincia(Value)
  else
    Value := provincia_ds.DataSet.FieldByName('provincia_ds').AsString;
end;

procedure TQRLClientesAlm.pais_dsPrint(sender: TObject;
  var Value: string);
begin
  Value := desPais(Value);
end;

procedure TQRLClientesAlm.es_comunitario_cPrint(sender: TObject;
  var Value: String);
begin
  if Value = 'S' then
    Value:= 'SI'
  else
  if Value = 'N' then
    Value:= 'NO'
  else
  if Value = '' then
    Value:= 'FALTA';
end;

end.
