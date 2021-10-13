unit LClientes_Edi;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLClientes_Edi = class(TQuickRep)
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    PsQRLabel2: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    Suministro: TQRDBText;
    PsQRDBText4: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel9: TQRLabel;
    PsQRSysData3: TQRSysData;
    qrgCabGrupo: TQRGroup;
    qreEmpresa: TQRDBText;
    codigo_ce: TQRDBText;
    qrgCabCliente: TQRGroup;
    QRDBText2: TQRDBText;
    bndPieEmp: TQRBand;
    procedure PsQRSysData2Print(sender: TObject; var Value: string);
    procedure QRLClientes_EdiBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qreEmpresaPrint(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure SuministroPrint(sender: TObject; var Value: String);
  private
    sEmpresa, sCliente: string;
  public

  end;

var
  QRLClientes_Edi: TQRLClientes_Edi;

implementation

uses CVariables, UDMauxDB;

{$R *.DFM}

procedure TQRLClientes_Edi.PsQRSysData2Print(sender: TObject;
  var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

procedure TQRLClientes_Edi.QRLClientes_EdiBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
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

procedure TQRLClientes_Edi.qreEmpresaPrint(sender: TObject;
  var Value: String);
begin
  sEmpresa:= value;
  value:= sEmpresa + ' ' + desEmpresa( sEmpresa );
end;

procedure TQRLClientes_Edi.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  sCliente:= value;
  value:= sCliente + ' ' + desCliente( sCliente );
end;

procedure TQRLClientes_Edi.SuministroPrint(sender: TObject;
  var Value: String);
begin
  value:= value + ' ' + desSuministro( sEmpresa, sCliente, Value );
end;

end.
