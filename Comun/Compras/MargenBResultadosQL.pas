unit MargenBResultadosQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLMargenBResultados = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    lblProducto: TQRLabel;
    bndDetalle: TQRBand;
    qrbndColumnHeaderBand1: TQRBand;
    qrlblqrl36: TQRLabel;
    qrlblqrl37: TQRLabel;
    qrlblqrl42: TQRLabel;
    qrlblqrl43: TQRLabel;
    qrlblqrl44: TQRLabel;
    qrlblqrl45: TQRLabel;
    qrdbtxtcentro: TQRDBText;
    qrdbtxtentrega: TQRDBText;
    qrdbtxtcajas: TQRDBText;
    qrdbtxtunidades: TQRDBText;
    qrdbtxtpeso: TQRDBText;
    qrdbtxtpeso_bruto: TQRDBText;
    qrdbtxtprecio: TQRDBText;
    qrdbtxtcajas_albaran: TQRDBText;
    qrdbtxtunidades_albaran: TQRDBText;
    qrdbtxtpeso_albaran: TQRDBText;
    qrdbtxtimporte_albaran: TQRDBText;
    qrdbtxtcajas_volcadas: TQRDBText;
    qrdbtxtunidades_volcadas: TQRDBText;
    qrdbtxtpeso_volcadas: TQRDBText;
    qrdbtxtimporte_volcadas: TQRDBText;
    qrdbtxtprecio_volcadas: TQRDBText;
    qrdbtxtcajas_volcadas1: TQRDBText;
    qrdbtxtunidades_volcadas1: TQRDBText;
    qrdbtxtpeso_volcadas1: TQRDBText;
    qrlbl2: TQRLabel;
    qrdbtxtunidades_albaran1: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrdbtxtunidades_albaran2: TQRDBText;
    qrdbtxtunidades_albaran3: TQRDBText;
    qrdbtxtunidades_albaran4: TQRDBText;
    qrdbtxtunidades_albaran5: TQRDBText;
    qrdbtxtunidades_albaran6: TQRDBText;
    qrdbtxtunidades_albaran7: TQRDBText;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrxpr1: TQRExpr;
    qrlbl12: TQRLabel;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrshp1: TQRShape;
    qrshp2: TQRShape;
    qrlbl15: TQRLabel;
    qrdbtxtcajas_conf_carga: TQRDBText;
    qrdbtxtunidades_conf_carga: TQRDBText;
    qrdbtxtpeso_conf_carga: TQRDBText;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrdbtxtcajas_conf_carga1: TQRDBText;
    qrdbtxtcajas_cargadas: TQRDBText;
    qrxpr7: TQRExpr;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl24: TQRLabel;
    qrdbtxtcajas_conf_carga2: TQRDBText;
    qrdbtxtcajas_cargadas1: TQRDBText;
    qrxpr8: TQRExpr;
    qrlbl25: TQRLabel;
    qrdbtxtcajas_conf_carga3: TQRDBText;
    qrdbtxtdescuentos: TQRDBText;
    qrdbtxtcajas_albaran1: TQRDBText;
    qrdbtxtunidades_albaran8: TQRDBText;
    qrdbtxtpeso_albaran1: TQRDBText;
    qrlbl26: TQRLabel;
    qrdbtxtcajas_cargadas2: TQRDBText;
    qrdbtxtunidades_cargadas: TQRDBText;
    qrdbtxtpeso_cargadas: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    procedure qrdbtxtentregaPrint(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public
    procedure PreparaListado( const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

procedure VerMargenBResultados( const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );

implementation

{$R *.DFM}

uses
  MargenBCodeComunDL, CReportes, DPreview, UDMAuxDB, bMath;

var
  QLMargenBResultados: TQLMargenBResultados;


procedure VerMargenBResultados( const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );
begin
  Application.CreateForm( TQLMargenBResultados, QLMargenBResultados );
  try
    QLMargenBResultados.PreparaListado( AEmpresa, AProducto, AFechaIni, AFechaFin );
    Previsualiza( QLMargenBResultados );
  finally
    FreeAndNil( QLMargenBResultados );
  end;
end;

procedure TQLMargenBResultados.PreparaListado( const AEmpresa, AProducto: string;
                                           const AFechaIni, AFechaFin: TDateTime );
begin
  sEmpresa:= AEmpresa;

  PonLogoGrupoBonnysa( self, AEmpresa );

  if AProducto <> '' then
    lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto )
  else
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';

  lblRango.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );
end;


procedure TQLMargenBResultados.qrdbtxtentregaPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TODOS LOS CLIENTES';
end;

end.
