unit CRLSalidasDepositoPais;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRLSalidasDepositoPais = class(TQuickRep)
    bndTitulo: TQRBand;
    bndResumen: TQRBand;
    bndDetalle: TQRBand;
    QRLabel1: TQRLabel;
    lblCentro: TQRLabel;
    lblPeriodo: TQRLabel;
    ChildBand1: TQRChildBand;
    qrepais_dal: TQRDBText;
    qrekilos_das: TQRDBText;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrepais_dal1: TQRDBText;
    qrepkilos_das: TQRDBText;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl1: TQRLabel;
    procedure qrepais_dalPrint(sender: TObject; var Value: String);
    procedure qrl5Print(sender: TObject; var Value: String);
    procedure qrepkilos_dasPrint(sender: TObject; var Value: String);
  private
    rKilos: real;
  public

  end;

  procedure Previsualizar( const AEmpresa, ACentro: string;
                           const AFechainicio, AFechafin: TDateTime;
                           const AKilos: real );

implementation

{$R *.DFM}

uses
  CDLSalidasDepositoPais, UDMAUXDB, CReportes, DPreview;

var
  QRLSalidasDepositoPais: TQRLSalidasDepositoPais;

procedure Previsualizar( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const AKilos: real );
begin
  QRLSalidasDepositoPais:= TQRLSalidasDepositoPais.Create( nil );
  with QRLSalidasDepositoPais do
  begin
    rKilos:= AKilos;
    PonLogoGrupoBonnysa( QRLSalidasDepositoPais, AEmpresa );
    lblCentro.Caption:= ACentro + ' ' + DesCentro( AEmpresa, ACentro );
    lblPeriodo.Caption:= 'Del ' + DateToStr( AFechainicio ) + ' al ' + DateToStr( AFechafin ) + '.';
  end;
  try
    Preview( QRLSalidasDepositoPais );
  except
    FreeAndNil( QRLSalidasDepositoPais );
  end;
end;


procedure TQRLSalidasDepositoPais.qrepais_dalPrint(sender: TObject;
  var Value: String);
begin
  Value:= desPais( Value );
end;

procedure TQRLSalidasDepositoPais.qrl5Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat('#,##0.00', rKilos );
end;

procedure TQRLSalidasDepositoPais.qrepkilos_dasPrint(sender: TObject;
  var Value: String);
begin
  if rKilos > 0 then
    Value:= FormatFloat('#,##0.00%', ( DataSet.FieldByName( 'kilos_das' ).AsFloat/rKilos ) * 100 )
  else
    Value:= FormatFloat('#,##0.00%', 0 )
end;

end.
