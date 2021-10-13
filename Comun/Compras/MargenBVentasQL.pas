unit MargenBVentasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLMargenBVentas = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    lblProducto: TQRLabel;
    bndDetalle: TQRBand;
    qrdbtxtfecha_alta: TQRDBText;
    qrdbtxtcentro: TQRDBText;
    qrdbtxtorden: TQRDBText;
    qrdbtxtean128: TQRDBText;
    qrdbtxtean13: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtpeso: TQRDBText;
    qrdbtxtpeso_teorico: TQRDBText;
    qrdbtxtstatus: TQRDBText;
    qrbndColumnHeaderBand1: TQRBand;
    qrlblqrl8: TQRLabel;
    qrlblqrl9: TQRLabel;
    qrlblqrl10: TQRLabel;
    qrlblqrl21: TQRLabel;
    qrlblqrl11: TQRLabel;
    qrlblqrl12: TQRLabel;
    qrlblqrl14: TQRLabel;
    qrlblqrl16: TQRLabel;
    qrlblqrl17: TQRLabel;
    qrlblqrl18: TQRLabel;
    qrlblqrl20: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrxprqrx2: TQRExpr;
    qrxprqrx10: TQRExpr;
    qrxprqrx3: TQRExpr;
    qrxprqrx4: TQRExpr;
    qrlbl1: TQRLabel;
    qrdbtxtcoste_personal: TQRDBText;
    qrdbtxtimporte_albaranes: TQRDBText;
    qrdbtxtgasto_venta: TQRDBText;
    qrlbl2: TQRLabel;
    qrsbdtlClientes: TQRSubDetail;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtcliente: TQRDBText;
    qrdbtxtcajas_albaran: TQRDBText;
    qrdbtxtunidades_albaran: TQRDBText;
    qrdbtxtpeso_albaran: TQRDBText;
    qrdbtxtimporte_albaran: TQRDBText;
    qrdbtxtdescuentos: TQRDBText;
    qrdbtxtgasto_venta1: TQRDBText;
    qrdbtxtimporte_abonos: TQRDBText;
    qrdbtxtcoste_material: TQRDBText;
    qrdbtxtcoste_personal1: TQRDBText;
    qrdbtxtcoste_general: TQRDBText;
    qrdbtxtcoste_financiero: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrdbtxtproducto2: TQRDBText;
    qrdbtxtcliente1: TQRDBText;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrlbl3: TQRLabel;
    qrdbtxtdescuentos1: TQRDBText;
    qrdbtxtdescuentos2: TQRDBText;
    qrxpr8: TQRExpr;
    qrdbtxtcajas_albaran1: TQRDBText;
    qrdbtxtunidades_albaran1: TQRDBText;
    qrdbtxtpeso_albaran1: TQRDBText;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    procedure qrdbtxtproducto2Print(sender: TObject; var Value: String);
    procedure qrdbtxtcliente1Print(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public
    procedure PreparaListado( const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

procedure VerMargenBVentas( const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );

implementation

{$R *.DFM}

uses
  CReportes, MargenBVentasDL, DPreview, UDMAuxDB, bMath;

var
  QLMargenBVentas: TQLMargenBVentas;


procedure VerMargenBVentas( const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );
begin
  Application.CreateForm( TQLMargenBVentas, QLMargenBVentas );
  try
    QLMargenBVentas.PreparaListado( AEmpresa, AProducto, AFechaIni, AFechaFin );
    //QLCuadreAlmacenSemanalResumen.bPaletsEntrada:= APaletsEntrada;
    //QLCuadreAlmacenSemanalResumen.bPaletsSalida:= APaletsSalida;
    Previsualiza( QLMargenBVentas );
  finally
    FreeAndNil( QLMargenBVentas );
  end;
end;


procedure TQLMargenBVentas.PreparaListado( const AEmpresa, AProducto: string;
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

(*

  if Value = '0' then
  begin
    Value:= 'Palets confecionados la semana anterior cargados la semana actual.';
  end
  else
  if Value = '1' then
  begin
    Value:= 'Palets confecionados la semana actual cargados la semana actual.';
  end
  else
  if Value = '2' then
  begin
    Value:= 'Palets confecionados la semana actual cargados la semana siguiente.';
  end;


*)

procedure TQLMargenBVentas.qrdbtxtproducto2Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( sEmpresa, Value );
end;

procedure TQLMargenBVentas.qrdbtxtcliente1Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( Value );
end;

end.
