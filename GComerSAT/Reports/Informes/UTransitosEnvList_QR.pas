unit UTransitosEnvList_QR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TTransitosEnvList_QR = class(TQuickRep)
    bndTitulo: TQRBand;
    bndResumen: TQRBand;
    bndDetalle: TQRBand;
    bndCabecera: TQRGroup;
    bndPie: TQRBand;
    QRLabel1: TQRLabel;
    qrlSalida: TQRLabel;
    lblPeriodo: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRDBText7: TQRDBText;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRLabel6: TQRLabel;
    QRShape1: TQRShape;
    lblProducto: TQRLabel;
    QRLabel7: TQRLabel;
    categoria_tl: TQRDBText;
    qrlDestino: TQRLabel;
    procedure QRDBText7Print(sender: TObject; var Value: String);
  private

  public

  end;

  procedure Previsualizar( const AEmpresa, ASalida, ADestino, AProducto: string;
                           const AFechainicio, AFechafin: TDateTime;
                           const AFechaSalida: boolean );

implementation

{$R *.DFM}

uses
  UTransitosEnvList_MD, UDMAUXDB, CReportes, DPreview;

var
  QRTransitosEnvList: TTransitosEnvList_QR;

procedure Previsualizar( const AEmpresa, ASalida, ADestino, AProducto: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const AFechaSalida: boolean );
begin
  QRTransitosEnvList:= TTransitosEnvList_QR.Create( nil );
  with QRTransitosEnvList do
  begin
    PonLogoGrupoBonnysa( QRTransitosEnvList, AEmpresa );

    if ASalida = '' then
      qrlSalida.Caption:= 'SALIDA:  TODOS LOS CENTROS.'
    else
      qrlSalida.Caption:= 'SALIDA: ' + ASalida + ' ' + DesCentro( AEmpresa, ASalida );
    if ADestino = '' then
      qrlDestino.Caption := 'DESTINO: TODOS LOS CENTROS.'
    else
      qrlDestino.Caption := 'DESTINO: ' + ADestino + ' ' + DesCentro( AEmpresa, ADestino );

    if AFechaSalida then
      lblPeriodo.Caption:= 'Salida del ' + DateToStr( AFechainicio ) + ' al ' + DateToStr( AFechafin ) + '.'
    else
      lblPeriodo.Caption:= 'Entrada del ' + DateToStr( AFechainicio ) + ' al ' + DateToStr( AFechafin ) + '.';
    if AProducto = '' then
      lblProducto.Caption := 'Todos los productos.'
    else
      lblProducto.Caption := AProducto + ' ' + desProducto( AEmpresa, AProducto );

    bndResumen.Enabled:= AProducto = '';
  end;
  try
    MDTransitosEnvList.kbmTransitos.Sort([]);
    MDTransitosEnvList.kbmTransitos.First;
    Preview( QRTransitosEnvList );
  except
    FreeAndNil( QRTransitosEnvList );
  end;
end;


procedure TTransitosEnvList_QR.QRDBText7Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + Value + ':';
end;

end.
