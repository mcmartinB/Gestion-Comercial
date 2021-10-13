unit LAlbaranesEnviados;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLAlbaranesEnviados = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    Titulo: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    DBAlbaran: TQRDBText;
    DBFecha: TQRDBText;
    DBHora: TQRDBText;
    DBFechaEnv: TQRDBText;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    qrl1: TQRLabel;
    DBCliente: TQRDBText;
    DBDesCliente: TQRDBText;
    procedure DBDesClientePrint(sender: TObject; var Value: String);
  private

  public
    sEmpresa: string;
  end;

var
  QRLAlbaranesEnviados: TQRLAlbaranesEnviados;

implementation

uses LFAlbaranesEnviados, UDMAuxDB;

{$R *.DFM}

procedure TQRLAlbaranesEnviados.DBDesClientePrint(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( Value );
end;

end.
