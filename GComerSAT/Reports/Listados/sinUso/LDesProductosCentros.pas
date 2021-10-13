unit LDesProductosCentros;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls, UDMBaseDatos;

type
  TQRLDesProductosCentros = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    Empresa: TQRLabel;
    QRLabel2: TQRLabel;
    empresa_dpc: TQRDBText;
    centro_dpc: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    QRLabel1: TQRLabel;
    envase_dpc: TQRDBText;
    descripcion_dpc: TQRDBText;
    procedure centro_dpcPrint(sender: TObject; var Value: String);
    procedure envase_dpcPrint(sender: TObject; var Value: String);
    
  private

  public
    sEmpresa: string;
  end;

var
  QRLDesProductosCentros: TQRLDesProductosCentros;

implementation

uses
  CVariables, DB, UDMAuxDB;

{$R *.DFM}


procedure TQRLDesProductosCentros.centro_dpcPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + desCentro( sEmpresa, Value );
end;

procedure TQRLDesProductosCentros.envase_dpcPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' - ' + desEnvase( sEmpresa, Value );
end;

end.
