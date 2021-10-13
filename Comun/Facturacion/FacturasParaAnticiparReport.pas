unit FacturasParaAnticiparReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, grimgctrl;

type
  TQRFacturasParaAnticipar = class(TQuickRep)
    QRBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblFecha: TQRLabel;
    qrbndDetalle: TQRBand;
    qrdbtxtexpedicion_c1: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtdes_envase: TQRDBText;
    qrdbtxtexpedicion_c2: TQRDBText;
    qrchldbndChildBand1: TQRChildBand;
    qrlbl2: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrdbtxtempresa: TQRDBText;
    qrdbtxtcentro: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    qrdbtxtcentro1: TQRDBText;
    qrdbtxtfecha1: TQRDBText;
    qrdbtxtcliente: TQRDBText;
    qrlbl12: TQRLabel;
    qrbnd1: TQRBand;
    qrdbtxtfecha_cmr: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl13: TQRLabel;
  private

  public

  end;

procedure PrintFacturasParaAnticipar( const AOwner: TComponent;
                                 const AEmpresa, APais: String; const APaises: Integer;
                                 const AFechaIni, AFechaFin: TDateTime );

implementation

{$R *.DFM}

uses
  FacturasParaAnticiparData, DPreview, CReportes, UDMAuxDB, variants;

var
  QRFacturasParaAnticipar: TQRFacturasParaAnticipar;

procedure PrintFacturasParaAnticipar( const AOwner: TComponent;
                                 const AEmpresa, APais: String; const APaises: Integer;
                                 const AFechaIni, AFechaFin: TDateTime );
begin
  QRFacturasParaAnticipar:= TQRFacturasParaAnticipar.Create( AOwner );
  try
    PonLogoGrupoBonnysa(QRFacturasParaAnticipar, AEmpresa);
    QRFacturasParaAnticipar.lblFecha.Caption:= 'Factura desde el ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );
    Previsualiza( QRFacturasParaAnticipar );
  finally
    FreeAndNil( QRFacturasParaAnticipar );
  end;
end;

end.
