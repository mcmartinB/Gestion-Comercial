unit CRLDifClienteSalidasDeposito;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRLDifClienteSalidasDeposito = class(TQuickRep)
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
    qrecentro: TQRDBText;
    qrealbaran: TQRDBText;
    qrefecha_transito: TQRDBText;
    qrecentro_transito: TQRDBText;
    QRLabel7: TQRLabel;
    qrefecha: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrecliente_salida: TQRDBText;
    qrecliente_deposito: TQRDBText;
    qrl5: TQRLabel;
    qrepuerto_tc: TQRDBText;
    procedure qrecliente_salidaPrint(sender: TObject; var Value: String);
    procedure qrecliente_depositoPrint(sender: TObject; var Value: String);
  private

  public

  end;

  procedure Previsualizar( const AEmpresa, ACentro: string;
                           const AFechainicio, AFechafin: TDateTime );

implementation

{$R *.DFM}

uses
  CDLDifClienteSalidasDeposito, UDMAUXDB, CReportes, DPreview;

var
  RLDifClienteSalidasDeposito: TRLDifClienteSalidasDeposito;
  (*
    SQL.Add(' select empresa_das empresa, centro_salida_das , n_albaran_das , fecha_das , cliente_sal_sc , ');
    SQL.Add('        cliente_dal , referencia_dac , fecha_dac , centro_dac   ');
  *)
procedure Previsualizar( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime );
begin
  RLDifClienteSalidasDeposito:= TRLDifClienteSalidasDeposito.Create( nil );
  with RLDifClienteSalidasDeposito do
  begin
    PonLogoGrupoBonnysa( RLDifClienteSalidasDeposito, AEmpresa );
    lblCentro.Caption:= ACentro + ' ' + DesCentro( AEmpresa, ACentro );
    lblPeriodo.Caption:= 'Del ' + DateToStr( AFechainicio ) + ' al ' + DateToStr( AFechafin ) + '.';
  end;
  try
    Preview( RLDifClienteSalidasDeposito );
  except
    FreeAndNil( RLDifClienteSalidasDeposito );
  end;
end;


procedure TRLDifClienteSalidasDeposito.qrecliente_salidaPrint(
  sender: TObject; var Value: String);
begin
  Value:= value + ' ' + desCliente( DataSet.FieldByName('empresa').AsString, value );
end;

procedure TRLDifClienteSalidasDeposito.qrecliente_depositoPrint(
  sender: TObject; var Value: String);
begin
  Value:= value + ' ' + desCliente( DataSet.FieldByName('empresa').AsString, value );
end;

end.
