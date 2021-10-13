unit FacturasSinContabilizarQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRFacturasSinContabilizar = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel8: TQRLabel;
    qrdbtxtn_factura_fc: TQRDBText;
    qrdbtxtfecha_factura_fc: TQRDBText;
    qrdbtxtcod_cliente_fc: TQRDBText;
    qrdbtxtmoneda_fc: TQRDBText;
    qrdbtxtimporte_neto_fc: TQRDBText;
    qrdbtxtimporte_conta_neto_fc: TQRDBText;
    PsQRSysData1: TQRSysData;
    lblTitulo: TQRLabel;
    lblFechas: TQRLabel;
    lblClientes: TQRLabel;
    lblFacturas: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    qrdbtxtn_factura_f: TQRDBText;
    qrlbl2: TQRLabel;
    qrdbtxtcod_cliente_fc1: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxtn_factura_fc1: TQRDBText;
    procedure lblFechasPrint(sender: TObject; var Value: string);
  private

  public


  end;

  procedure Imprimir;

  var  dFechaIni, dFechaFin: TDateTime;
  
implementation

uses FacturasSinContabilizarDM, Dpreview;

{$R *.DFM}

procedure Imprimir;
var
  QRFacturasSinContabilizar: TQRFacturasSinContabilizar;
begin
  QRFacturasSinContabilizar:= TQRFacturasSinContabilizar.Create( nil );
  try
    Dpreview.Preview( QRFacturasSinContabilizar );
  except
    FreeAndNil( QRFacturasSinContabilizar );
  end;
end;

procedure TQRFacturasSinContabilizar.lblFechasPrint(sender: TObject;
  var Value: string);
begin
  Value := 'Fecha de ' + DateToStr(dFechaIni) + ' a ' + DateToStr(dFechaFin);
end;

end.
