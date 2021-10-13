unit MargenBCargadosQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLMargenBCargados = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    lblProducto: TQRLabel;
    bndDetalle: TQRBand;
    qrbndColumnHeaderBand1: TQRBand;
    qrbndSummaryBand1: TQRBand;
    qrxprqrx6: TQRExpr;
    qrxprqrx7: TQRExpr;
    qrxprqrx11: TQRExpr;
    qrlblqrl23: TQRLabel;
    qrlblqrl36: TQRLabel;
    qrlblqrl37: TQRLabel;
    qrlblqrl38: TQRLabel;
    qrlblqrl39: TQRLabel;
    qrlblqrl40: TQRLabel;
    qrlblqrl41: TQRLabel;
    qrlblqrl42: TQRLabel;
    qrlblqrl43: TQRLabel;
    qrlbl: TQRLabel;
    qrlblqrl47: TQRLabel;
    qrsbdtlPalets: TQRSubDetail;
    qrdbtxtfecha: TQRDBText;
    qrdbtxtcentro: TQRDBText;
    qrdbtxtentrega: TQRDBText;
    qrdbtxtsscc: TQRDBText;
    qrdbtxtproveedor: TQRDBText;
    qrdbtxtprecio: TQRDBText;
    qrdbtxtvariedad: TQRDBText;
    qrdbtxtcalibre: TQRDBText;
    qrdbtxtcajas: TQRDBText;
    qrdbtxtunidades: TQRDBText;
    qrdbtxtpeso: TQRDBText;
    qrdbtxtstatus: TQRDBText;
    qrdbtxtfecha1: TQRDBText;
    qrdbtxtcentro1: TQRDBText;
    qrdbtxtentrega1: TQRDBText;
    qrbndPiePalets: TQRBand;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrdbtxtcajas1: TQRDBText;
    qrdbtxtunidades1: TQRDBText;
    qrdbtxtpeso1: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxtcalibre1: TQRDBText;
    qrlbl2: TQRLabel;
    qrdbtxtOrden_carga: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrdbtxtpeso2: TQRDBText;
    qrdbtxtpeso3: TQRDBText;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
  private
    sEmpresa: string;
  public
    procedure PreparaListado( const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

procedure VerMargenBCargados( const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );

implementation

{$R *.DFM}

uses
  MargenBProveedorDL, CReportes, DPreview, UDMAuxDB, bMath;

var
  QLMargenBCargados: TQLMargenBCargados;


procedure VerMargenBCargados( const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );
begin
  Application.CreateForm( TQLMargenBCargados, QLMargenBCargados );
  try
    QLMargenBCargados.PreparaListado( AEmpresa, AProducto, AFechaIni, AFechaFin );
    //QLCuadreAlmacenSemanalResumen.bPaletsEntrada:= APaletsEntrada;
    //QLCuadreAlmacenSemanalResumen.bPaletsSalida:= APaletsSalida;
    Previsualiza( QLMargenBCargados );
  finally
    FreeAndNil( QLMargenBCargados );
  end;
end;

procedure TQLMargenBCargados.PreparaListado( const AEmpresa, AProducto: string;
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

end.
