unit LFacturasCliente;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLFActurasCliente = class(TQuickRep)
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    SummaryBand1: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRLabel7: TQRLabel;
    TitleBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblFechas: TQRLabel;
    lblClientes: TQRLabel;
    PageHeaderBand1: TQRBand;
    QRSysData2: TQRSysData;
    QRDBText1: TQRDBText;
    QRShape1: TQRShape;
    procedure QRDBText1Print(sender: TObject; var Value: String);
  private

  public
    sEmpresa: String;
  end;

var
  QRLFActurasCliente: TQRLFActurasCliente;

implementation

uses LFFacturasCliente, UDMAuxDB;

{$R *.DFM}

procedure TQRLFActurasCliente.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= DesCliente( Value );
end;

end.
