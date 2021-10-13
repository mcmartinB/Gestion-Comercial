unit QLServiciosTransporteSalidas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLServiciosTransporteSalidas = class(TQuickRep)
    cabecera: TQRBand;
    QRSysData2: TQRSysData;
    lblTitulo: TQRLabel;
    lblFecha: TQRLabel;
    lblCentro: TQRLabel;
    SummaryBand1: TQRBand;
    qrxservicios1: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    ColumnHeaderBand1: TQRBand;
    lblAgrupa: TQRLabel;
    QRLabel2: TQRLabel;
    qrlservicios: TQRLabel;
    lblMatricula: TQRLabel;
    qlImporte: TQRLabel;
    QRLabel6: TQRLabel;
    lblProducto: TQRLabel;
    lblPortes: TQRLabel;
    lblDestino: TQRLabel;
    detalle: TQRBand;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr9: TQRExpr;
    qrxservicios: TQRExpr;
    QRExpr1: TQRExpr;
    QRExpr5: TQRExpr;
    marca: TQRExpr;
    qrltransitos: TQRLabel;
    qrx1: TQRExpr;
    qrlCodPostal: TQRLabel;
    qrxPais: TQRExpr;
    qrxCliente: TQRExpr;
    qrlCliente: TQRLabel;
    qrxDesCliente: TQRExpr;
    qrlbl1: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrxpr3: TQRExpr;
    qrlFactura: TQRLabel;
    lblEnvases: TQRLabel;
    procedure qrxDesClientePrint(sender: TObject; var Value: String);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure qrlbl4Print(sender: TObject; var Value: String);
    procedure qrlbl3Print(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLServiciosTransporteSalidas: TQRLServiciosTransporteSalidas;

implementation

{$R *.DFM}

procedure TQRLServiciosTransporteSalidas.qrxDesClientePrint(
  sender: TObject; var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQRLServiciosTransporteSalidas.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  if not Exporting or  ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) = 0 ) then
  begin
    Value:= '';
  end
  else
  begin
    Value:= 'Transporte';
  end;
end;

procedure TQRLServiciosTransporteSalidas.qrlbl4Print(sender: TObject;
  var Value: String);
begin
  if not Exporting or  ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) = 0 ) then
  begin
    Value:= '';
  end
  else
  begin
    Value:= 'Cliente';
  end;
end;

procedure TQRLServiciosTransporteSalidas.qrlbl3Print(sender: TObject;
  var Value: String);
begin
  if not Exporting or  ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) = 0 ) then
  begin
    Value:= '';
  end
  else
  begin
    Value:= 'País';
  end;
end;

end.
