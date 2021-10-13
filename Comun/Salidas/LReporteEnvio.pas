unit LReporteEnvio;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRReporteEnvio = class(TQuickRep)
    TitleBand1: TQRBand;
    LCliente: TQRLabel;
    MEnviados: TQRMemo;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    LEnviados: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRSysData2: TQRSysData;
    PsQRLabel5: TQRLabel;
    PSQRLDireccion: TQRLabel;
    LDireccion: TQRLabel;
    ChildBand1: TQRChildBand;
    Memo: TQRMemo;
    PsQRLabel4: TQRLabel;
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

  procedure ImprimirReporteFacturas(ACliente, ADesde, AHasta, AEmail: string;  AMensaje: TStrings);

var
  QRReporteEnvio: TQRReporteEnvio;

implementation

{$R *.DFM}

procedure TQRReporteEnvio.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := (Memo.Lines.Count > 0);
end;


procedure ImprimirReporteFacturas(ACliente, ADesde, AHasta, AEmail: string;
  AMensaje: TStrings);
var
  rep: TQRReporteEnvio;
begin
  (*TODO*)
  //Condicionos para imprimir reporte, mucho gasto en papel
  Exit;

  rep := nil;
  try
    rep := TQRReporteEnvio.Create(Application);
    rep.LCliente.Caption := ACliente;
    rep.LDireccion.Caption := AEmail;
       //rellenar memo con los numeros de las facturas
    rep.MEnviados.Lines.Add('De la ' + ADesde + ' a la ' + AHasta);
    rep.LEnviados.Caption := 'Facturas enviadas: ';
    rep.ShowProgress := False;
    rep.Memo.Lines.AddStrings(AMensaje);
    rep.Print;
  finally
    rep.Free;
    Application.ProcessMessages;
  end;
end;

end.
