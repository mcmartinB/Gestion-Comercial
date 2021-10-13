unit MargenBConfeccionadoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLMargenBConfeccionado = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    lblProducto: TQRLabel;
    bndDetalle: TQRBand;
    qrbndColumnHeaderBand1: TQRBand;
    qrlblqrl8: TQRLabel;
    qrlblqrl9: TQRLabel;
    qrlblqrl10: TQRLabel;
    qrlblqrl21: TQRLabel;
    qrlblqrl11: TQRLabel;
    qrlblqrl12: TQRLabel;
    qrlblqrl14: TQRLabel;
    qrlblqrl15: TQRLabel;
    qrlblqrl16: TQRLabel;
    qrlblqrl17: TQRLabel;
    qrlblqrl20: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrxprqrx2: TQRExpr;
    qrxprqrx10: TQRExpr;
    qrxprqrx3: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlblCalibre: TQRLabel;
    qrsbdtlPalet: TQRSubDetail;
    qrdbtxtcentro1: TQRDBText;
    qrdbtxtcentro: TQRDBText;
    qrdbtxtcentro2: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtfecha_alta: TQRDBText;
    qrdbtxtfecha_carga: TQRDBText;
    qrdbtxtorden: TQRDBText;
    qrdbtxtean128: TQRDBText;
    qrdbtxtean13: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtcajas1: TQRDBText;
    qrdbtxtcajas: TQRDBText;
    qrdbtxtunidades: TQRDBText;
    qrdbtxtpeso: TQRDBText;
    qrdbtxtstatus: TQRDBText;
    qrdbtxtproducto1: TQRDBText;
    qrdbtxtcajas2: TQRDBText;
    qrdbtxtunidades1: TQRDBText;
    qrdbtxtpeso1: TQRDBText;
  private
    sEmpresa: string;

  public
    procedure PreparaListado( const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const DatosCab: TDataSet );
  end;

procedure VerMargenBConfeccionado( const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime;
                            const DatosCab: TDataSet  );

implementation

{$R *.DFM}

uses
  CReportes, MargenBConfeccionDL, DPreview, UDMAuxDB, bMath;

var
  QLMargenBConfeccionado: TQLMargenBConfeccionado;


procedure VerMargenBConfeccionado( const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime;
                            const DatosCab: TDataSet  );
begin
  Application.CreateForm( TQLMargenBConfeccionado, QLMargenBConfeccionado );
  try
    QLMargenBConfeccionado.PreparaListado( AEmpresa, AProducto, AFechaIni, AFechaFin, DatosCab );
    //QLCuadreAlmacenSemanalResumen.bPaletsEntrada:= APaletsEntrada;
    //QLCuadreAlmacenSemanalResumen.bPaletsSalida:= APaletsSalida;
    Previsualiza( QLMargenBConfeccionado );
  finally
    FreeAndNil( QLMargenBConfeccionado );
  end;
end;


procedure TQLMargenBConfeccionado.PreparaListado( const AEmpresa, AProducto: string;
                                           const AFechaIni, AFechaFin: TDateTime;
                                           const DatosCab: TDataSet );
begin
  sEmpresa:= AEmpresa;

  PonLogoGrupoBonnysa( self, AEmpresa );

  if AProducto <> '' then
    lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto )
  else
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';

  lblRango.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );

  DataSet:= DatosCab;
  qrdbtxtproducto1.DataSet:= DatosCab;
  qrdbtxtcajas2.DataSet:= DatosCab;
  qrdbtxtunidades1.DataSet:= DatosCab;
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

end.
