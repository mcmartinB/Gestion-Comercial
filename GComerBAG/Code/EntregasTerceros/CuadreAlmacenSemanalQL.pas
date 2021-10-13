unit CuadreAlmacenSemanalQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLCuadreAlmacenSemanal = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    lblProducto: TQRLabel;
    bnddPaletsConfeccionados: TQRSubDetail;
    qrefecha_alta: TQRDBText;
    qrefecha_carga: TQRDBText;
    qrecentro: TQRDBText;
    qreorden: TQRDBText;
    qreean128: TQRDBText;
    qreean13: TQRDBText;
    qreenvase: TQRDBText;
    qrecajas: TQRDBText;
    qrepeso: TQRDBText;
    qrepeso_teorico: TQRDBText;
    qrestatus: TQRDBText;
    bndDetalle: TQRBand;
    bndCabPaletsConfeccionados: TQRGroup;
    qregrupo: TQRDBText;
    bndCabPaletsProveedores: TQRGroup;
    qregrupo_in: TQRDBText;
    bnddPaletsProveedores: TQRSubDetail;
    qrefecha: TQRDBText;
    qrecentro1: TQRDBText;
    qreentrega: TQRDBText;
    qresscc: TQRDBText;
    qreproveedor: TQRDBText;
    qrevariedad: TQRDBText;
    qrecalibre: TQRDBText;
    qrecajas_in: TQRDBText;
    qrepeso_in: TQRDBText;
    qrepeso_bruto: TQRDBText;
    qrestatus_in: TQRDBText;
    bndTituloConfeccionado: TQRBand;
    bndTituloProveedor: TQRBand;
    bndPieConfeccionados: TQRBand;
    bndPieProveedor: TQRBand;
    qrx2: TQRExpr;
    qrx3: TQRExpr;
    qrx4: TQRExpr;
    qrx6: TQRExpr;
    qrx7: TQRExpr;
    qrx9: TQRExpr;
    qreunidades: TQRDBText;
    qreunidades1: TQRDBText;
    bndcChildBand3: TQRChildBand;
    qrl8: TQRLabel;
    qrl9: TQRLabel;
    qrl10: TQRLabel;
    qrl11: TQRLabel;
    qrl12: TQRLabel;
    qrl14: TQRLabel;
    qrl15: TQRLabel;
    qrl16: TQRLabel;
    qrl17: TQRLabel;
    qrl18: TQRLabel;
    qrl20: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl21: TQRLabel;
    bndcChildBand4: TQRChildBand;
    qrl23: TQRLabel;
    qrl36: TQRLabel;
    qrl37: TQRLabel;
    qrl38: TQRLabel;
    qrl39: TQRLabel;
    qrl40: TQRLabel;
    qrl41: TQRLabel;
    qrl42: TQRLabel;
    qrl43: TQRLabel;
    qrl44: TQRLabel;
    qrl45: TQRLabel;
    qrl47: TQRLabel;
    qrx10: TQRExpr;
    qrx11: TQRExpr;
    qreproducto1: TQRDBText;
    bndcChildBand1: TQRChildBand;
    qrePesoRFIn: TQRDBText;
    qreUnidadesRFIn: TQRDBText;
    qrlRFIn: TQRLabel;
    qrl3: TQRLabel;
    qrs1: TQRShape;
    qrs4: TQRShape;
    qrlMerma: TQRLabel;
    qrekilos_in_valor: TQRDBText;
    qrekilos_albaran: TQRDBText;
    qrepeso_albaran: TQRDBText;
    qrecajas_albaran: TQRDBText;
    qreunidades_albaran: TQRDBText;
    qrl1: TQRLabel;
    qrl5: TQRLabel;
    qrl22: TQRLabel;
    qrl24: TQRLabel;
    qrs3: TQRShape;
    qrl25: TQRLabel;
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
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qregrupoPrint(sender: TObject; var Value: String);
    procedure qregrupo_inPrint(sender: TObject; var Value: String);
    procedure qreenvasePrint(sender: TObject; var Value: String);
    procedure qrevariedadPrint(sender: TObject; var Value: String);
    procedure qreproveedorPrint(sender: TObject; var Value: String);
    procedure bndCabPaletsConfeccionadosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndTituloProveedorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndcChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrl19Print(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public
    bPaletsEntrada, bPaletsSalida: boolean;

    procedure PreparaListado( const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

procedure VerCuadreAlmacenSemanal( const AOwner: TComponent;
                            const APaletsEntrada, APaletsSalida: boolean;
                            const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );

implementation

{$R *.DFM}

uses
  CReportes, MargenBeneficiosDL, DPreview, UDMAuxDB, bMath;

var
  QLCuadreAlmacenSemanal: TQLCuadreAlmacenSemanal;


procedure VerCuadreAlmacenSemanal( const AOwner: TComponent;
                            const APaletsEntrada, APaletsSalida: boolean;
                            const AEmpresa, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime  );
begin
  QLCuadreAlmacenSemanal:= TQLCuadreAlmacenSemanal.Create( AOwner );
  try
    QLCuadreAlmacenSemanal.PreparaListado( AEmpresa, AProducto, AFechaIni, AFechaFin );
    QLCuadreAlmacenSemanal.bPaletsEntrada:= APaletsEntrada;
    QLCuadreAlmacenSemanal.bPaletsSalida:= APaletsSalida;
    QLCuadreAlmacenSemanal.bndDetalle.ForceNewPage:= APaletsEntrada or APaletsSalida;
    Previsualiza( QLCuadreAlmacenSemanal );
  finally
    FreeAndNil( QLCuadreAlmacenSemanal );
  end;
end;

procedure TQLCuadreAlmacenSemanal.PreparaListado( const AEmpresa, AProducto: string;
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

procedure TQLCuadreAlmacenSemanal.qreProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( sEmpresa, Value );
end;

procedure TQLCuadreAlmacenSemanal.bndDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  bnddPaletsConfeccionados.DataSet.Filter:= 'producto_out = '  + DataSet.FieldByName('producto').AsString;
  bnddPaletsProveedores.DataSet.Filter:= 'producto_in = '  + QuotedStr( DataSet.FieldByName('producto').AsString );
end;

procedure TQLCuadreAlmacenSemanal.qregrupoPrint(sender: TObject;
  var Value: String);
begin
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
end;

procedure TQLCuadreAlmacenSemanal.qregrupo_inPrint(sender: TObject;
  var Value: String);
begin
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
end;

procedure TQLCuadreAlmacenSemanal.qreenvasePrint(sender: TObject;
  var Value: String);
begin
    Value:= Value + ' ' + desEnvaseProducto ( sEmpresa, Value, bnddPaletsConfeccionados.DataSet.FieldByName('producto_out').AsString );
end;

procedure TQLCuadreAlmacenSemanal.qrevariedadPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desVariedad( sEmpresa, bnddPaletsProveedores.DataSet.FieldByName('proveedor_in').AsString, bnddPaletsProveedores.DataSet.FieldByName('producto_in').AsString, Value );
end;

procedure TQLCuadreAlmacenSemanal.qreproveedorPrint(sender: TObject;
  var Value: String);
begin
    Value:= Value + ' ' + desProveedor ( sEmpresa, Value );
end;

procedure TQLCuadreAlmacenSemanal.bndCabPaletsConfeccionadosBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bPaletsSalida;
end;

procedure TQLCuadreAlmacenSemanal.bndTituloProveedorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bPaletsEntrada;
end;

procedure TQLCuadreAlmacenSemanal.bndcChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not( bPaletsEntrada or bPaletsSalida );
end;

procedure TQLCuadreAlmacenSemanal.qrl19Print(sender: TObject; var Value: String);
begin
  Value:= '';
end;

end.
