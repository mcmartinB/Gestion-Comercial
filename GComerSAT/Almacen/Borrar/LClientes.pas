unit LClientes;

interface

uses SysUtils, DBTables, Classes, Controls, ExtCtrls, QuickRpt,
  Graphics, Qrctrls, Db;
type
  TQRLClientes = class(TQuickRep)
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
    PsQRLabel1: TQRLabel;
    empresa_c: TQRDBText;
    PsQRDBText9: TQRDBText;
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
  private
    conta: integer;
  public

  end;

var
  QRLClientes: TQRLClientes;

implementation

uses
  UDMAuxDB, UDMBaseDatos;

{$R *.DFM}

procedure TQRLClientes.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLClientes.LDireccionPrint(sender: TObject;
  var Value: string);
begin
  Value := IntToStr(Conta) + 'ª ' + Value;
end;

procedure TQRLClientes.QRSubDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Inc(Conta);
end;

procedure TQRLClientes.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  Conta := 0;
end;

procedure TQRLClientes.DetailBand1BeforePrint(Sender: TQRCustomBand;
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

procedure TQRLClientes.provincia_dsPrint(sender: TObject;
  var Value: string);
begin
  if provincia_ds.DataSet.FieldByName('pais_ds').AsString = 'ES' then
    Value := desProvincia(Value)
  else
    Value := provincia_ds.DataSet.FieldByName('provincia_ds').AsString;
end;

procedure TQRLClientes.pais_dsPrint(sender: TObject;
  var Value: string);
begin
  Value := desPais(Value);
end;

end.
