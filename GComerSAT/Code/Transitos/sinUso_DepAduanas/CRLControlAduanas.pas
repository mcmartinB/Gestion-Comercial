unit CRLControlAduanas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRLControlAduanas = class(TQuickRep)
    bndTitulo: TQRBand;
    bndResumen: TQRBand;
    bndDetalle: TQRBand;
    QRLabel1: TQRLabel;
    lblCentro: TQRLabel;
    lblPeriodo: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    qrefecha_tc: TQRDBText;
    qrereferencia_tc: TQRDBText;
    qrekilos_dal: TQRDBText;
    QRLabel7: TQRLabel;
    qrefecha_entrada_dda_dac: TQRDBText;
    qrecajas: TQRDBText;
    qrecategoria: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qredvd_dac: TQRDBText;
    qredvd_dac1: TQRDBText;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrxDifDDA: TQRExpr;
    qrxDiffAlb: TQRExpr;
    qrs1: TQRShape;
    qrs2: TQRShape;
    qrs3: TQRShape;
    qrs4: TQRShape;
    procedure qrefecha_entrada_dda_dacPrint(sender: TObject;
      var Value: String);
  private

  public

  end;

  procedure Previsualizar( const AEmpresa, ACentro: string;
                           const AFechainicio, AFechafin: TDateTime );

implementation

{$R *.DFM}

uses
  CDLControlAduanas, UDMAUXDB, CReportes, DPreview;

var
  RLControlAduanas: TRLControlAduanas;
  (*
  empresa_tc, centro_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc,
  codigo_dac, dvd_dac, fecha_entrada_dda_dac, embarque_dac, dua_exporta_dac,
  sum(kilos_tl) kilos_tc,
  ( select sum( kilos_dal) from frf_depositos_aduana_l where codigo_dal = codigo_dac ) kilos_dal,
  ( select sum( kilos_das) from frf_depositos_aduana_sal where codigo_das = codigo_dac ) kilos_das
  *)
procedure Previsualizar( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime );
begin
  RLControlAduanas:= TRLControlAduanas.Create( nil );
  with RLControlAduanas do
  begin
    PonLogoGrupoBonnysa( RLControlAduanas, AEmpresa );
    lblCentro.Caption:= ACentro + ' ' + DesCentro( AEmpresa, ACentro );
    lblPeriodo.Caption:= 'Del ' + DateToStr( AFechainicio ) + ' al ' + DateToStr( AFechafin ) + '.';
  end;
  try
    Preview( RLControlAduanas );
  except
    FreeAndNil( RLControlAduanas );
  end;
end;


procedure TRLControlAduanas.qrefecha_entrada_dda_dacPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime( 'dd/mm/yy', DataSet.FieldByname('fecha_entrada_dda_dac').AsDateTime );
end;

end.
