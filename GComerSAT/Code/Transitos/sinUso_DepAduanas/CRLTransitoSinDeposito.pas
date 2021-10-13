unit CRLTransitoSinDeposito;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRLTransitoSinDeposito = class(TQuickRep)
    bndTitulo: TQRBand;
    bndResumen: TQRBand;
    bndDetalle: TQRBand;
    QRLabel1: TQRLabel;
    lblCentro: TQRLabel;
    lblPeriodo: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    qrefecha_tc: TQRDBText;
    qrereferencia_tc: TQRDBText;
    qrekilos_dal: TQRDBText;
    qrekilos_das: TQRDBText;
    QRLabel7: TQRLabel;
    qrefecha_entrada_dda_dac: TQRDBText;
    qrecajas: TQRDBText;
    qrecategoria: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qredvd_dac: TQRDBText;
    qredvd_dac1: TQRDBText;
    qrl5: TQRLabel;
    qredes_puerto_tc: TQRDBText;
    procedure qredes_puerto_tcPrint(sender: TObject; var Value: String);
    procedure qrecategoriaPrint(sender: TObject; var Value: String);
  private

  public

  end;

  procedure Previsualizar( const AEmpresa, ACentro: string;
                           const AFechainicio, AFechafin: TDateTime );

implementation

{$R *.DFM}

uses
  CDLTransitoSinDeposito, UDMAUXDB, CReportes, DPreview;

var
  RLTransitoSinDeposito: TRLTransitoSinDeposito;
  (*
  empresa_tc, centro_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc, ');
    SQL.Add('         sum(kilos_tl) kilos_tc
  *)
procedure Previsualizar( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime );
begin
  RLTransitoSinDeposito:= TRLTransitoSinDeposito.Create( nil );
  with RLTransitoSinDeposito do
  begin
    PonLogoGrupoBonnysa( RLTransitoSinDeposito, AEmpresa );
    lblCentro.Caption:= ACentro + ' ' + DesCentro( AEmpresa, ACentro );
    lblPeriodo.Caption:= 'Del ' + DateToStr( AFechainicio ) + ' al ' + DateToStr( AFechafin ) + '.';
  end;
  try
    Preview( RLTransitoSinDeposito );
  except
    FreeAndNil( RLTransitoSinDeposito );
  end;
end;


procedure TRLTransitoSinDeposito.qredes_puerto_tcPrint(sender: TObject;
  var Value: String);
begin
  Value:= desAduana( Value );
end;

procedure TRLTransitoSinDeposito.qrecategoriaPrint(sender: TObject;
  var Value: String);
begin
  Value:= desTransporte( DataSet.FieldByName('empresa_tc').AsString, Value );
end;

end.
