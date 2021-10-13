unit MargenSemanalCentralQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLMargenSemanalCentral = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    lblProducto: TQRLabel;
    bndDetalle: TQRBand;
    qreimporte_venta: TQRDBText;
    qrxbeneficio: TQRExpr;
    qreproducto1: TQRDBText;
    qrepeso_albaran: TQRDBText;
    bndcChildBand2: TQRChildBand;
    qrl48: TQRLabel;
    qrl5: TQRLabel;
    qrlBenef: TQRLabel;
    qrlAnyoSem: TQRLabel;
    qrl2: TQRLabel;
    qreSemana: TQRDBText;
    qreimporte_compra: TQRDBText;
    qreimporte_transporte: TQRDBText;
    qrlimporte_compra: TQRLabel;
    qrlimporte_transporte: TQRLabel;
    qrecoste_general: TQRDBText;
    qrecoste_material: TQRDBText;
    qrecoste_personal: TQRDBText;
    qrecoste_financiero: TQRDBText;
    qrlcoste_material: TQRLabel;
    qrlcoste_general: TQRLabel;
    qrlcoste_personal: TQRLabel;
    qrlcoste_financiero: TQRLabel;
    qrlimporte_transito: TQRLabel;
    qreimporte_transito: TQRDBText;
    qrgCabProducto: TQRGroup;
    bndPieProducto: TQRBand;
    qrxbeneficio2: TQRExpr;
    qrximporte_transporte: TQRExpr;
    qrxpeso_albaran: TQRExpr;
    qrximporte_venta: TQRExpr;
    qrximporte_transito: TQRExpr;
    qrxcoste_material: TQRExpr;
    qrxcoste_personal: TQRExpr;
    qrxcoste_general: TQRExpr;
    qrxcoste_financiero: TQRExpr;
    qrximporte_compra: TQRExpr;
    bndTotales: TQRBand;
    qrxpeso_albarant: TQRExpr;
    qrximporte_ventat: TQRExpr;
    qrxbeneficio3: TQRExpr;
    qrximporte_comprat: TQRExpr;
    qrximporte_transportet: TQRExpr;
    qrximporte_transitot: TQRExpr;
    qrxcoste_materialt: TQRExpr;
    qrxcoste_personalt: TQRExpr;
    qrxcoste_generalt: TQRExpr;
    qrxcoste_financierot: TQRExpr;
    qrsTotales: TQRShape;
    qrlblCliente: TQRLabel;
    procedure qreProductoPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrgCabProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndTotalesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreimporte_compraPrint(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public
    bPaletsEntrada, bPaletsSalida, bVariasSemanas: boolean;

    procedure PreparaListado( const AEmpresa, ACliente, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const AExpandido: boolean );
  end;

procedure VerMargenSemanal( const AOwner: TComponent;
                            const APaletsEntrada, APaletsSalida: boolean;
                            const AEmpresa, ACliente, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime;
                            const AExpandido: boolean  );

implementation

{$R *.DFM}

uses
  CReportes, MargenBeneficiosCentralDL, DPreview, UDMAuxDB, bMath, Printers;

var
  QLMargenSemanalCentral: TQLMargenSemanalCentral;


procedure VerMargenSemanal( const AOwner: TComponent;
                            const APaletsEntrada, APaletsSalida: boolean;
                            const AEmpresa, ACliente, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime;
                            const AExpandido: boolean  );
begin
  QLMargenSemanalCentral:= TQLMargenSemanalCentral.Create( AOwner );
  try
    QLMargenSemanalCentral.PreparaListado( AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, AExpandido );
    QLMargenSemanalCentral.bPaletsEntrada:= APaletsEntrada;
    QLMargenSemanalCentral.bPaletsSalida:= APaletsSalida;
    QLMargenSemanalCentral.bVariasSemanas:= ( AFechaFin - AFechaIni ) > 6;
    QLMargenSemanalCentral.bndDetalle.ForceNewPage:= APaletsEntrada or APaletsSalida;
    Previsualiza( QLMargenSemanalCentral );
  finally
    FreeAndNil( QLMargenSemanalCentral );
  end;
end;

procedure TQLMargenSemanalCentral.PreparaListado( const AEmpresa, ACliente, AProducto: string;
                                           const AFechaIni, AFechaFin: TDateTime;
                                           const AExpandido: boolean );
begin
  sEmpresa:= AEmpresa;

  PonLogoGrupoBonnysa( self, AEmpresa );

  if AProducto <> '' then
    lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto )
  else
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';

  if ACliente <> '' then
    qrlblCliente.Caption:= ACliente + ' ' + desCliente( ACliente )
  else
    qrlblCliente.Caption:= 'TODOS LOS CLIENTES';

  lblRango.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );

  if AExpandido then
  begin
    Page.Orientation:= poLandscape;
    qrsTotales.Width:= 817;
  end
  else
  begin
    Page.Orientation:= poPortrait;
    qrsTotales.Width:= 262;
  end;
  qrlimporte_compra.Enabled:= AExpandido;
  qrlimporte_transporte.Enabled:= AExpandido;
  qrlimporte_transito.Enabled:= AExpandido;
  qreimporte_compra.Enabled:= AExpandido;
  qreimporte_transporte.Enabled:= AExpandido;
  qreimporte_transito.Enabled:= AExpandido;

  qrlcoste_general.Enabled:= AExpandido;
  qrlcoste_personal.Enabled:= AExpandido;
  qrlcoste_material.Enabled:= AExpandido;
  qrlcoste_financiero.Enabled:= AExpandido;
  qrecoste_general.Enabled:= AExpandido;
  qrecoste_personal.Enabled:= AExpandido;
  qrecoste_material.Enabled:= AExpandido;
  qrecoste_financiero.Enabled:= AExpandido;

  qrximporte_compra.Enabled:= AExpandido;
  qrximporte_transporte.Enabled:= AExpandido;
  qrximporte_transito.Enabled:= AExpandido;
  qrxcoste_general.Enabled:= AExpandido;
  qrxcoste_personal.Enabled:= AExpandido;
  qrxcoste_material.Enabled:= AExpandido;
  qrxcoste_financiero.Enabled:= AExpandido;

  qrximporte_comprat.Enabled:= AExpandido;
  qrximporte_transportet.Enabled:= AExpandido;
  qrximporte_transitot.Enabled:= AExpandido;
  qrxcoste_generalt.Enabled:= AExpandido;
  qrxcoste_personalt.Enabled:= AExpandido;
  qrxcoste_materialt.Enabled:= AExpandido;
  qrxcoste_financierot.Enabled:= AExpandido;
end;

procedure TQLMargenSemanalCentral.qreProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( sEmpresa, Value );
end;

procedure TQLMargenSemanalCentral.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  if Exporting then
  begin
    qrepeso_albaran.Mask:= '#,##0.00';
    qrxbeneficio.Mask:= '#,##0.00';
    qreimporte_venta.Mask:= '#,##0.00';
    qreimporte_compra.Mask:= '#,##0.00';
    qreimporte_transporte.Mask:= '#,##0.00';
    qreimporte_transito.Mask:= '#,##0.00';
    qrecoste_general.Mask:= '#,##0.00';
    qrecoste_personal.Mask:= '#,##0.00';
    qrecoste_material.Mask:= '#,##0.00';
    qrecoste_financiero.Mask:= '#,##0.00';

    lblTitulo.Left:= 5;
    lblProducto.Left:= 5;
  end
  else
  begin
    qrepeso_albaran.Mask:= '#,##0.00';
    qrxpeso_albaran.Mask:= '#,##0';
    qrxpeso_albarant.Mask:= '#,##0';

    qrxbeneficio.Mask:= '#,##0.00€';
    qrxbeneficio2.Mask:= '#,##0€';
    qrxbeneficio3.Mask:= '#,##0€';

    qreimporte_venta.Mask:= '#,##0.00€';
    qrximporte_venta.Mask:= '#,##0€';
    qrximporte_ventat.Mask:= '#,##0€';

    qreimporte_compra.Mask:= '#,##0.00';
    qreimporte_transporte.Mask:= '#,##0.00';
    qreimporte_transito.Mask:= '#,##0.00';
    qrecoste_general.Mask:= '#,##0.00';
    qrecoste_personal.Mask:= '#,##0.00';
    qrecoste_material.Mask:= '#,##0.00';
    qrecoste_financiero.Mask:= '#,##0.00';

    qrximporte_compra.Mask:= '#,##0€';
    qrximporte_transporte.Mask:= '#,##0€';
    qrximporte_transito.Mask:= '#,##0€';
    qrxcoste_general.Mask:= '#,##0€';
    qrxcoste_personal.Mask:= '#,##0€';
    qrxcoste_material.Mask:= '#,##0€';
    qrxcoste_financiero.Mask:= '#,##0€';

    qrximporte_comprat.Mask:= '#,##0.00€';
    qrximporte_transportet.Mask:= '#,##0€';
    qrximporte_transito.Mask:= '#,##0€';
    qrxcoste_generalt.Mask:= '#,##0€';
    qrxcoste_personalt.Mask:= '#,##0€';
    qrxcoste_materialt.Mask:= '#,##0€';
    qrxcoste_financierot.Mask:= '#,##0€';

    lblTitulo.Left:= qreSemana.Left;
    lblProducto.Left:= qreSemana.Left;
  end;
end;

procedure TQLMargenSemanalCentral.qrgCabProductoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bVariasSemanas and not Exporting;
end;

procedure TQLMargenSemanalCentral.bndTotalesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not Exporting;
end;

procedure TQLMargenSemanalCentral.qreimporte_compraPrint(sender: TObject;
  var Value: String);
begin
  if Exporting then
    TQRDBText( sender ).Frame.DrawLeft:= False
  else
    TQRDBText( sender ).Frame.DrawLeft:= True;
end;

end.
