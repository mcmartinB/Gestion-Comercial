unit LTipoEntregas;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;
type
  TQRLTipoEntregas = class(TQuickRep)
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    tipo_et: TQRDBText;
    descripcion_et: TQRDBText;
    ajuste_et: TQRDBText;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QListado: TQuery;
    QRLabel6: TQRLabel;
    qrgEmpresa: TQRGroup;
    qreempresa_et: TQRDBText;
    qrl1: TQRLabel;
    qremerma_et: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure qreempresa_etPrint(sender: TObject; var Value: String);
    procedure ajuste_etPrint(sender: TObject; var Value: String);
    procedure qremerma_etPrint(sender: TObject; var Value: String);
  private

  public
    destructor Destroy; override;
  end;

var
  QRLTipoEntregas: TQRLTipoEntregas;

implementation

{$R *.DFM}

uses
  UDMAuxDB;

procedure TQRLTipoEntregas.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

destructor TQRLTipoEntregas.Destroy;
begin
  if QListado.Active then QListado.Close;
  inherited;
end;

procedure TQRLTipoEntregas.qreempresa_etPrint(sender: TObject;
  var Value: String);
begin
  Value:= value + ' '  + DesEmpresa( value );
end;

procedure TQRLTipoEntregas.ajuste_etPrint(sender: TObject;
  var Value: String);
begin
  if Value = '1' then
  begin
    Value:= '1 Salidas';
  end
  else
  begin
    Value:= '0 Escandallo';
  end;
end;

procedure TQRLTipoEntregas.qremerma_etPrint(sender: TObject;
  var Value: String);
begin
  if Value = '1' then
  begin
    Value:= '1 Con Merma';
  end
  else
  begin
    Value:= '0 Sin Merma';
  end;
end;

end.
