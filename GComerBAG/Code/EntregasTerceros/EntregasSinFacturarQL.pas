unit EntregasSinFacturarQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLEntregasSinFacturar = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    bndCabecera: TQRBand;
    DetailBand1: TQRBand;
    LAlbaran: TQRLabel;
    LFecha: TQRLabel;

    LVariable: TQRLabel;
    LTitulo: TQRLabel;
    proveedor_ec: TQRDBText;
    vehiculo_ec: TQRDBText;
    codigo_Ec: TQRDBText;
    PsQRSysData1: TQRSysData;
    LPeriodo: TQRLabel;
    albaran_Ec: TQRDBText;
    LMatricula: TQRLabel;
    fecha_llegada_ec: TQRDBText;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    lblTipoGastos: TQRLabel;
    lblCliente: TQRLabel;
    QRDBText1: TQRDBText;
    kilos_el: TQRDBText;
    QRLabel4: TQRLabel;
    lblKilosTitulo: TQRLabel;
    SummaryBand1: TQRBand;
    producto_el: TQRDBText;
    QRLabel1: TQRLabel;
    kilos_ec: TQRExpr;
    procedure QRDBText1Print(sender: TObject; var Value: String);
  private

  public
    sEmpresa: string;
  end;

var
  QLEntregasSinFacturar: TQLEntregasSinFacturar;

implementation

{$R *.DFM}

uses
  EntregasSinFacturarFL, UDMAuxDB;

procedure TQLEntregasSinFacturar.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= desProveedor( sEmpresa, value );
end;

end.
