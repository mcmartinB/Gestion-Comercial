unit CuadreAlmacenSemanalResumenQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLCuadreAlmacenSemanalResumen = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    lblProducto: TQRLabel;
    bndDetalle: TQRBand;
    qreproducto1: TQRDBText;
    qrekilos_albaran: TQRDBText;
    qrepeso_albaran: TQRDBText;
    qrecajas_albaran: TQRDBText;
    qreunidades_albaran: TQRDBText;
    qrl1: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrs3: TQRShape;
    qrl9: TQRLabel;
    bndcChildBand1: TQRChildBand;
    qrePesoRFIn: TQRDBText;
    qreUnidadesRFIn: TQRDBText;
    qrlRFIn: TQRLabel;
    qrl3: TQRLabel;
    qrs1: TQRShape;
    qrs4: TQRShape;
    qrlMerma: TQRLabel;
    qrekilos_in_valor: TQRDBText;
    qrepeso_rfout_teorico: TQRDBText;
    qrl4: TQRLabel;
    qrecajas_confecionado_adelantado: TQRDBText;
    qrekilos_confecionado_adelantado: TQRDBText;
    qrepeso_confecionado_adelantado: TQRDBText;
    qreunidades_confecionado_adelantado: TQRDBText;
    qrl2: TQRLabel;
    qrl26: TQRLabel;
    qrl27: TQRLabel;
    qrl28: TQRLabel;
    qrx1: TQRExpr;
    qrx17: TQRExpr;
    qrx18: TQRExpr;
    qrx19: TQRExpr;
    qrx5: TQRExpr;
    qrx20: TQRExpr;
    qrx21: TQRExpr;
    qrx8: TQRExpr;
    qrl29: TQRLabel;
    qrepeso_volcado_anterior: TQRDBText;
    qreunidades_volcado_anterior: TQRDBText;
    qrl13: TQRLabel;
    qrl30: TQRLabel;
    qrs2: TQRShape;
    qrs5: TQRShape;
    qrl31: TQRLabel;
    qrekilos_volcado_anterior: TQRDBText;
    qrecajas_volcado_anterior: TQRDBText;
    qrl32: TQRLabel;
    qrecajas_volcado_adelantado: TQRDBText;
    qrekilos_volcado_adelantado: TQRDBText;
    qrepeso_volcado_adelantado: TQRDBText;
    qreunidades_volcado_adelantado: TQRDBText;
    qrl33: TQRLabel;
    qrl34: TQRLabel;
    qrl19: TQRLabel;
    qrl35: TQRLabel;
    qrx22: TQRExpr;
    qrx23: TQRExpr;
    qrx24: TQRExpr;
    qrx12: TQRExpr;
    qrx13: TQRExpr;
    qrx14: TQRExpr;
    qrx15: TQRExpr;
    qrx16: TQRExpr;
    qrl46: TQRLabel;
    qrl48: TQRLabel;
    qrx26: TQRExpr;
    qrx27: TQRExpr;
    qrx28: TQRExpr;
    procedure qreProductoPrint(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public
    procedure PreparaListado( const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

procedure VerCuadreAlmacenSemanal( const AOwner: TComponent;
                            const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );

implementation

{$R *.DFM}

uses
  CReportes, MargenBeneficiosDL, DPreview, UDMAuxDB, bMath;

var
  QLCuadreAlmacenSemanalResumen: TQLCuadreAlmacenSemanalResumen;


procedure VerCuadreAlmacenSemanal( const AOwner: TComponent;
                            const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );
begin
  QLCuadreAlmacenSemanalResumen:= TQLCuadreAlmacenSemanalResumen.Create( AOwner );
  try
    QLCuadreAlmacenSemanalResumen.PreparaListado( AEmpresa, AProducto, AFechaIni, AFechaFin );
    //QLCuadreAlmacenSemanalResumen.bPaletsEntrada:= APaletsEntrada;
    //QLCuadreAlmacenSemanalResumen.bPaletsSalida:= APaletsSalida;
    Previsualiza( QLCuadreAlmacenSemanalResumen );
  finally
    FreeAndNil( QLCuadreAlmacenSemanalResumen );
  end;
end;

procedure TQLCuadreAlmacenSemanalResumen.PreparaListado( const AEmpresa, AProducto: string;
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

procedure TQLCuadreAlmacenSemanalResumen.qreProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( sEmpresa, Value );
end;

end.
