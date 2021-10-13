unit AgingQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQLAging = class(TQuickRep)
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    qrdbtxtcod_cliente: TQRDBText;
    qrdbtxtpagares: TQRDBText;
    qrdbtxtmenos30: TQRDBText;
    qrdbtxtentre31y60: TQRDBText;
    qrdbtxtentre61y75: TQRDBText;
    SummaryBand1: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRLabel7: TQRLabel;
    TitleBand1: TQRBand;
    qrlblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    PageHeaderBand1: TQRBand;
    QRSysData2: TQRSysData;
    qrdbtxtcliente: TQRDBText;
    qrdbtxtriesgo: TQRDBText;
    qrdbtxtmas121: TQRDBText;
    qrdbtxtentre91y120: TQRDBText;
    qrdbtxtentre76y90: TQRDBText;
    qrdbtxtpmc: TQRDBText;
    qrdbtxtdeficit: TQRDBText;
    qrdbtxtclasificacion: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    QRExpr2: TQRExpr;
    qrlblDeficit: TQRLabel;
    qrlblDiasCobro: TQRLabel;
    qrshp1: TQRShape;
    qrshp2: TQRShape;
    qrshp3: TQRShape;
    qrshp4: TQRShape;
    qrshp5: TQRShape;
    qrshp6: TQRShape;
    qrshp7: TQRShape;
    qrshp8: TQRShape;
    qrshp9: TQRShape;
    qrshp10: TQRShape;
    qrshp11: TQRShape;
    qrshp12: TQRShape;
    procedure PageHeaderBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    sEmpresa: String;
  end;

  procedure AgingView( const AOwner: TComponent; const AEmpresa, AFechaIni, AFechaFin, ADias, ADeficit: string );


implementation

uses AgingDL, UDMAuxDB, DPreview, CReportes;

{$R *.DFM}

var
  QLAging: TQLAging;

procedure AgingView( const AOwner: TComponent; const AEmpresa, AFechaIni, AFechaFin, ADias, ADeficit: string );
begin
  QLAging:= TQLAging.Create( AOwner );
  try
    QLAging.sEmpresa:= AEmpresa;
    QLAging.qrlblTitulo.Caption:= 'AGING';
    if AEmpresa <> '' then
      QLAging.qrlblTitulo.Caption:= QLAging.qrlblTitulo.Caption + ' ' + AEmpresa + ' - ' + desEmpresa( AEmpresa );
    QLAging.qrlblTitulo.Caption:= QLAging.qrlblTitulo.Caption + ' del ' + AFechaIni + ' al ' + AFechaFin;
    QLAging.qrlblDiasCobro.Caption:= '+' + ADias + ' días';
    QLAging.qrlblDeficit.Caption:= '<+' + ADeficit + '€';
    Previsualiza(QLAging);
  finally
    FreeAndNil( QLAging );
  end;
end;

procedure TQLAging.PageHeaderBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.
