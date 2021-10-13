unit LDatosCobroCliente;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLDatosCobroCliente = class(TQuickRep)
    QRTitulo: TQRBand;
    qlTitulo: TQRLabel;
    lblCliente: TQRLabel;
    PsQRSysData1: TQRSysData;
    qrlblPais: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrlblPsQRLabel1: TQRLabel;
    qrlblPsQRLabel3: TQRLabel;
    qrlblKilos: TQRLabel;
    qrlblPsQRLabel4: TQRLabel;
    qrbndDetailBand1: TQRBand;
    qrdbtxtcod_cliente: TQRDBText;
    qrdbtxtcliente1: TQRDBText;
    qrdbtxtPsQRDBText3: TQRDBText;
    qrdbtxtPsQRDBText1: TQRDBText;
    qrdbtxtCliente: TQRDBText;
    qrdbtxtimporte: TQRDBText;
    qrdbtxtDBImporte: TQRDBText;
    qrlblBanco: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel3: TQRLabel;
    qrlbl3: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    qrdbtxtmax_riesgo: TQRDBText;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    QRDBText6: TQRDBText;
    qrgrpPais: TQRGroup;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    qrlblFPago: TQRLabel;
    qrbndPageFooterBand1: TQRBand;
    qrlbl7: TQRLabel;
    QRDBText10: TQRDBText;
    qrlbl8: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrlbl9: TQRLabel;
    qrdbtxtcuenta: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxtforma_pago: TQRDBText;
    procedure QRDBText9Print(sender: TObject; var Value: String);
    procedure QRDBText4Print(sender: TObject; var Value: String);
    procedure qrgrpPaisBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure qrlbl8Print(sender: TObject; var Value: String);
    procedure qrbndPageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
  public
  end;

var
  QRLDatosCobroCliente: TQRLDatosCobroCliente;

implementation

{$R *.DFM}

uses
  UDMBaseDatos;

(*
empresa, , , , ,
, , , , ,
, , , ,
, , , ,
*)

(*
  if Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) then
  begin
    Value:= 'Cliente';
  end
  else
  begin
    Value:= '';
  end;
*)

procedure TQRLDatosCobroCliente.QRDBText9Print(sender: TObject;
  var Value: String);
begin
  if Value = 'S' then
    Value:= 'COMUNITARIO'
  else
    Value:= 'EXTRACOMUNITARIO';
end;

procedure TQRLDatosCobroCliente.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  if Value = '1' then
    Value:= 'SI'
  else
    Value:= 'NO';
end;

procedure TQRLDatosCobroCliente.qrgrpPaisBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) then
  begin
    PrintBand:= False
  end
  else
  begin
    PrintBand:= True;
  end;
end;

procedure TQRLDatosCobroCliente.qrbndPageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) then
  begin
    PrintBand:= False
  end
  else
  begin
    PrintBand:= True;
  end;
end;

procedure TQRLDatosCobroCliente.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQRLDatosCobroCliente.qrlbl8Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

end.
