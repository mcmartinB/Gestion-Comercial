unit LDescuentosCliente;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLDescuentosCliente = class(TQuickRep)
    QRTitulo: TQRBand;
    qlTitulo: TQRLabel;
    lblCliente: TQRLabel;
    PsQRSysData1: TQRSysData;
    qrlblPais: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrlblPsQRLabel1: TQRLabel;
    qrlblPsQRLabel2: TQRLabel;
    qrlblPsQRLabel3: TQRLabel;
    qrlblCliente: TQRLabel;
    qrlblKilos: TQRLabel;
    qrlblPsQRLabel4: TQRLabel;
    qrlblPrecio: TQRLabel;
    qrbndDetailBand1: TQRBand;
    qrdbtxtcod_cliente: TQRDBText;
    qrdbtxtcliente1: TQRDBText;
    qrdbtxtPsQRDBText3: TQRDBText;
    qrdbtxtPsQRDBText1: TQRDBText;
    qrdbtxtCliente: TQRDBText;
    qrdbtxtimporte: TQRDBText;
    qrdbtxtDBImporte: TQRDBText;
    qrlblTipo: TQRLabel;
    qrlbl1: TQRLabel;
    qrxpr1: TQRExpr;
    qrdbtxtcod_cliente1: TQRDBText;
    qrlbl2: TQRLabel;
    procedure qrlblPrecioPrint(sender: TObject; var Value: String);
    procedure qrlblPsQRLabel4Print(sender: TObject; var Value: String);
  private
  public
  end;

var
  QRLDescuentosCliente: TQRLDescuentosCliente;

implementation

{$R *.DFM}

uses
  UDMBaseDatos;

procedure TQRLDescuentosCliente.qrlblPrecioPrint(sender: TObject;
  var Value: String);
begin
  if Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) then
  begin
    Value:= 'Cliente';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLDescuentosCliente.qrlblPsQRLabel4Print(sender: TObject;
  var Value: String);
begin
  if Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) then
  begin
    Value:= 'Representantes';
  end
  else
  begin
    Value:= '';
  end;
end;

end.
