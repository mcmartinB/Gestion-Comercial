unit LPrecioDiarioEnvases;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;
type
  TQRLPrecioDiarioEnvases = class(TQuickRep)
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRDBText1: TQRDBText;
    qreenvase_epd: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel4: TQRLabel;
    PsQRSysData1: TQRSysData;
    QListado: TQuery;
    QRLabel6: TQRLabel;
    qrgCab: TQRGroup;
    qrefecha_epd: TQRDBText;
    qreproducto_: TQRDBText;
    qreprecio_epd: TQRDBText;
    qrlFecha: TQRLabel;
    qreund_factura_epd: TQRDBText;
    qrl1: TQRLabel;
    qrepvp_epd: TQRDBText;
    qrl2: TQRLabel;
    procedure qreenvase_epdPrint(sender: TObject; var Value: String);
    procedure qreproducto_Print(sender: TObject; var Value: String);
    procedure PsQRDBText1Print(sender: TObject; var Value: String);
  private

  public
    destructor Destroy; override;
  end;

var
  QRLPrecioDiarioEnvases: TQRLPrecioDiarioEnvases;

implementation

uses UDMAuxDB;

{$R *.DFM}

destructor TQRLPrecioDiarioEnvases.Destroy;
begin
  if QListado.Active then QListado.Close;
  inherited;
end;

procedure TQRLPrecioDiarioEnvases.qreenvase_epdPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + DataSet.FieldByname('descripcion_e').AsString;
end;

procedure TQRLPrecioDiarioEnvases.qreproducto_Print(sender: TObject;
  var Value: String);
begin

  Value:= Value + ' - ' + desProducto( DataSet.FieldByname('empresa_epd').AsString,
                                         DataSet.FieldByname('producto_epd').AsString );
end;

procedure TQRLPrecioDiarioEnvases.PsQRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + DataSet.FieldByname('centro_epd').AsString
end;

end.
