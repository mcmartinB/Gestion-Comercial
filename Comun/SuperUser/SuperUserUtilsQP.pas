unit SuperUserUtilsQP;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQPSuperUserUtils = class(TQuickRep)
    qrbnd1: TQRBand;
    qrdbtxtempresa_tc: TQRDBText;
    qrdbtxtcentro_tc: TQRDBText;
    qrdbtxtfecha_tc: TQRDBText;
    qrdbtxtreferencia_tc: TQRDBText;
    qrdbtxtpalets: TQRDBText;
    qrdbtxtcajas: TQRDBText;
    qrdbtxtbruto: TQRDBText;
    qrdbtxtneto: TQRDBText;
    qrlbl1: TQRLabel;
    procedure qrbnd1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

implementation

uses
  SuperUserUtilsDP;

{$R *.DFM}
{

}


function EsNumero( AChar: Char ): Boolean;
begin
  result:=  ( AChar = '0' ) or ( AChar = '1' )or ( AChar = '2' )or ( AChar = '3' )or ( AChar = '4' )or ( AChar = '5' )or ( AChar = '6' )
            or ( AChar = '7' )or ( AChar = '8' )or ( AChar = '9' )or ( AChar = '.' )or ( AChar = ',' );
end;

procedure TQPSuperUserUtils.qrbnd1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  peso: string;
  j: integer;
begin
  peso:= '';
  j:= Pos( 'PESO', UpperCase(DataSet.FieldByName('nota_tc').AsString) );
  if j = 0 then
    j:= Pos( 'PRESO', UpperCase(DataSet.FieldByName('nota_tc').AsString) );


  if j > 0 then
  begin
    while ( j < Length(DataSet.FieldByName('nota_tc').AsString) ) and not EsNumero( DataSet.FieldByName('nota_tc').AsString[j] ) do
    begin
      Inc(j)
    end;
    while ( j < Length(DataSet.FieldByName('nota_tc').AsString) ) and EsNumero( DataSet.FieldByName('nota_tc').AsString[j] ) do
    begin
      if DataSet.FieldByName('nota_tc').AsString[j] <> '.' then
         peso:= peso + DataSet.FieldByName('nota_tc').AsString[j];
      Inc(j)
    end;
    qrlbl1.Caption:= peso;
  end;
end;

end.
