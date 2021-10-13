unit MargenBVolcadosQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLMargenBVolcados = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    lblProducto: TQRLabel;
    bndDetalle: TQRBand;
    qrbndColumnHeaderBand1: TQRBand;
    qrlblqrl23: TQRLabel;
    qrlblqrl36: TQRLabel;
    qrlblqrl37: TQRLabel;
    qrlblqrl38: TQRLabel;
    qrlblqrl39: TQRLabel;
    qrlblqrl40: TQRLabel;
    qrlblqrl41: TQRLabel;
    qrlblqrl42: TQRLabel;
    qrlblqrl43: TQRLabel;
    qrlblqrl44: TQRLabel;
    qrlblqrl45: TQRLabel;
    qrlblqrl47: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrxprqrx6: TQRExpr;
    qrxprqrx7: TQRExpr;
    qrxprqrx9: TQRExpr;
    qrxprqrx11: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrdbtxtcentro: TQRDBText;
    qrdbtxtentrega: TQRDBText;
    qrdbtxtproveedor: TQRDBText;
    qrdbtxtvariedad: TQRDBText;
    qrdbtxtsscc: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    qrdbtxtOrden_carga: TQRDBText;
    qrdbtxtcalibre: TQRDBText;
    qrdbtxtcajas: TQRDBText;
    qrdbtxtunidades: TQRDBText;
    qrdbtxtpeso: TQRDBText;
    qrdbtxtpeso_bruto: TQRDBText;
    qrdbtxtprecio: TQRDBText;
  private
    sEmpresa: string;
  public
    procedure PreparaListado( const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

procedure VerMargenBVolcados( const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );

implementation

{$R *.DFM}

uses
  MargenBProveedorDL, CReportes, DPreview, UDMAuxDB, bMath;

var
  QLMargenBVolcados: TQLMargenBVolcados;


procedure VerMargenBVolcados( const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );
begin
  Application.CreateForm( TQLMargenBVolcados, QLMargenBVolcados );
  try
    QLMargenBVolcados.PreparaListado( AEmpresa, AProducto, AFechaIni, AFechaFin );
    //QLCuadreAlmacenSemanalResumen.bPaletsEntrada:= APaletsEntrada;
    //QLCuadreAlmacenSemanalResumen.bPaletsSalida:= APaletsSalida;
    Previsualiza( QLMargenBVolcados );
  finally
    FreeAndNil( QLMargenBVolcados );
  end;
end;

procedure TQLMargenBVolcados.PreparaListado( const AEmpresa, AProducto: string;
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
    Value:= 'Palets volcados la semana anterior cargados la semana actual.';
  end
  else
  if Value = '1' then
  begin
    Value:= 'Palets volcados la semana actual cargados la semana actual.';
  end
  else
  if Value = '2' then
  begin
    Value:= 'Palets volcados la semana actual cargados la semana siguiente.';
  end;


  mtPrecios.FieldDefs.Clear;
  mtPrecios.FieldDefs.Add('producto_precio', ftString, 3, False);
  mtPrecios.FieldDefs.Add('proveedor_precio', ftString, 3, False);
  mtPrecios.FieldDefs.Add('empresa_precio', ftString, 3, False);
  mtPrecios.FieldDefs.Add('precio_maximo', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_minimo', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_maximo_previsto', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_minimo_previsto', ftFloat, 0, False);

  mtPrecios.FieldDefs.Add('precio_fruta_max', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_fruta_min', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_fruta_max_previsto', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_fruta_min_previsto', ftFloat, 0, False);

  mtPrecios.FieldDefs.Add('precio_transporte_max', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_transporte_min', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_transporte_max_previsto', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_transporte_min_previsto', ftFloat, 0, False);

  mtPrecios.CreateTable;  

*)

end.
