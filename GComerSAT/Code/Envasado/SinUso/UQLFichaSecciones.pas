unit UQLFichaSecciones;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, DB, DBTables;

type
  TQLFichaSecciones = class(TQuickRep)
    QRBand3: TQRBand;
    LDescripcion: TQRLabel;
    QRBand2: TQRBand;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    fecha: TQRSysData;
    QCostesEnvasado: TQuery;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    BandaCorte: TQRGroup;
    QRLabel2: TQRLabel;
    QRGroup1: TQRGroup;
    productor_ce: TQRDBText;
    nombre_c: TQRDBText;
    qreCentro: TQRDBText;
    QRGroup2: TQRGroup;
    tipo_entrada_epc: TQRDBText;
    descripcion_et: TQRDBText;
    QRDBText1: TQRDBText;
    qreDescripcion: TQRDBText;
    qrlFecha: TQRLabel;
    qreCentro1: TQRDBText;
    qreProducto1: TQRDBText;
    qrecoste_kg_emc: TQRDBText;
    qreanyo_mes_emc: TQRDBText;
    qrlCoste: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure QRLMarcasBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: string);
    procedure qreCentroPrint(sender: TObject; var Value: string);
    procedure QRDBText5Print(sender: TObject; var Value: string);
    procedure qreDescripcionPrint(sender: TObject; var Value: String);
  private

  public

  end;

var
  QLFichaSecciones: TQLFichaSecciones;

implementation

uses CVariables, UDMAuxDB;

{$R *.DFM}

procedure TQLFichaSecciones.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQLFichaSecciones.QRLMarcasBeforePrint(Sender: TCustomQuickRep;
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

procedure TQLFichaSecciones.QRDBText1Print(sender: TObject;
  var Value: string);
begin
  Value := desEmpresa(value);
end;

procedure TQLFichaSecciones.qreCentroPrint(sender: TObject;
  var Value: string);
begin
  Value := desCentro(DataSet.fieldbyname('empresa_epc').AsString, value);
end;

procedure TQLFichaSecciones.QRDBText5Print(sender: TObject;
  var Value: string);
begin
  Value := '- ' + Value + ' -';
end;

procedure TQLFichaSecciones.qreDescripcionPrint(sender: TObject;
  var Value: String);
begin
  if not qreCentro.Enabled then
  begin
    Value:= '';
  end;
end;

end.
