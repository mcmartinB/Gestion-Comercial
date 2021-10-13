unit LSelecRefGastos;

interface

uses Classes, Graphics, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, QRCtrls;

type
  TQRLSelectRefGastos = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    Empresa: TQRLabel;
    LCentro: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRLabel2: TQRLabel;
    PsQRDBText4: TQRDBText;
    procedure QRSysData1Print(sender: TObject; var Value: string);
  private

  public

  end;

var
  QRLSelectRefGastos: TQRLSelectRefGastos;

implementation

uses
  CVariables, LFSalidasRefGastos;

{$R *.DFM}

procedure TQRLSelectRefGastos.QRSysData1Print(sender: TObject; var Value: string);
begin
  if Tag > 0 then
    Value := Value + ' de ' + IntToStr(Tag);
end;

end.
