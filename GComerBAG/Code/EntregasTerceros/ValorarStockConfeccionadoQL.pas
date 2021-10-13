unit ValorarStockConfeccionadoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLValorarStockConfeccionado = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    qrdbtxtfecha_alta: TQRDBText;
    qrdbtxtstatus: TQRDBText;
    qrdbtxtfecha_status: TQRDBText;
    qrdbtxtkilos: TQRDBText;
    qrdbtxtcajas_c: TQRDBText;
    QRLabel1: TQRLabel;
    qrlblFechaAlta: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel3: TQRLabel;
    lblRangoFechas: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText11: TQRDBText;
    qrlblProducto: TQRLabel;
    qrgrpPlanta: TQRGroup;
    qrbndPiePlanta: TQRBand;
    qrdbtxtproducto_apb: TQRDBText;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrbndSummaryBand1: TQRBand;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrdbtxtimporte_fruta: TQRDBText;
    qrxpr5: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrlbl3: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl6: TQRLabel;
    qrdbtxtcajas: TQRDBText;
    qrxpr6: TQRExpr;
    qrxpr8: TQRExpr;
    bndsdDetalle: TQRSubDetail;
    qrdbtxt1: TQRDBText;
    qrdbtxtkilos_d: TQRDBText;
    qrdbtxtcoste_d: TQRDBText;
    qrxpr12: TQRExpr;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtenvase1: TQRDBText;
    qrdbtxtean128: TQRDBText;
    qrdbtxtcliente: TQRDBText;
    qrdbtxtean13: TQRDBText;
    qrdbtxtstatus1: TQRDBText;
    qrbndCabDetalle: TQRBand;
    qrlbl8: TQRLabel;
    qrlblEan134: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrbndPieDetalle: TQRBand;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrdbtxtpalets_c: TQRDBText;
    qrlbl7: TQRLabel;
    procedure qrgrpPlantaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl1Print(sender: TObject; var Value: String);
    procedure qrdbtxtproducto_apbPrint(sender: TObject; var Value: String);
    procedure qrdbtxtenvase1Print(sender: TObject; var Value: String);
    procedure qrdbtxtean128Print(sender: TObject; var Value: String);
    procedure qrdbtxtean13Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

    procedure PreparaListado( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                              const AProducto, ACliente, AEnvase: string; const AVerDetalle: Boolean );
  end;

  function VerListadoStock( const AOwner: TComponent;
                            const AEmpresa, ACentro: string; const AFecha: TDateTime;
                            const AProducto, ACliente, AEnvase: string; const AVerDetalle: Boolean  ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, ValorarStockConfeccionadoDL, DPreview, UDMAuxDB, bMath;

var
  QLValorarStockConfeccionado: TQLValorarStockConfeccionado;
  DLValorarStockConfeccionado: TDLValorarStockConfeccionado;

procedure VerListadoStockEx( const AOwner: TComponent;
                          const AEmpresa, ACentro: string; const AFecha: TDateTime;
                          const AProducto, ACliente, AEnvase: string; const AVerDetalle: Boolean );
begin
  QLValorarStockConfeccionado:= TQLValorarStockConfeccionado.Create( AOwner );
  try
    QLValorarStockConfeccionado.PreparaListado( AEmpresa, ACentro, AFecha, AProducto, ACliente, AEnvase, AVerDetalle );

    Previsualiza( QLValorarStockConfeccionado );
  finally
    FreeAndNil( QLValorarStockConfeccionado );
  end;
end;

function VerListadoStock( const AOwner: TComponent;
                          const AEmpresa, ACentro: string; const AFecha: TDateTime;
                          const AProducto, ACliente, AEnvase: string;
                          const AVerDetalle: boolean ): Boolean;
begin
  DLValorarStockConfeccionado:= TDLValorarStockConfeccionado.Create( AOwner );
  try
    result:= DLValorarStockConfeccionado.DatosQueryStock( AEmpresa, ACentro, AFEcha, AProducto, ACliente, AEnvase );
    if result then
    begin
      VerListadoStockEx( AOwner, AEmpresa, ACentro, AFecha, AProducto, ACliente, AEnvase, AVerDetalle );
    end;
  finally
    FreeAndNil( DLValorarStockConfeccionado );
  end;
end;


procedure TQLValorarStockConfeccionado.PreparaListado( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                          const AProducto, ACliente, AEnvase: string; const AVerDetalle: boolean );
begin
  if AEmpresa = '' then
  begin
    PonLogoGrupoBonnysa( self, 'BAG' );
    if ACentro = '' then
      lblCentro.Caption:= 'TODOS LOS CENTROS'
    else
      lblCentro.Caption:= 'CENTRO = ' + ACentro;
    if AProducto = '' then
      qrlblProducto.Caption:= 'TODOS LOS PRODUCTOS'
    else
      qrlblProducto.Caption:= 'PRODUCTO = ' + AProducto;
  end
  else
  begin
    PonLogoGrupoBonnysa( self, AEmpresa );
    if ACentro = '' then
      lblCentro.Caption:= 'TODOS LOS CENTROS'
    else
      lblCentro.Caption:= DesCentro( AEmpresa, ACentro );
    if AProducto = '' then
      qrlblProducto.Caption:= 'TODOS LOS PRODUCTOS'
    else
      qrlblProducto.Caption:= desProducto( AEmpresa, AProducto );
  end;

  lblTitulo.Caption:= 'VALORAR STOCK FRUTA CONFECCIONADA';
  lblRangoFechas.Caption:= 'STOCK A ' + FormatDateTime('dd/mm/yyyy', AFEcha );

  bndsdDetalle.Enabled:= AVerDetalle;
  qrbndCabDetalle.Enabled:= AVerDetalle;
  qrbndPieDetalle.Enabled:= AVerDetalle;
end;

procedure TQLValorarStockConfeccionado.qrgrpPlantaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

procedure TQLValorarStockConfeccionado.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total planta ' + DataSet.fieldByName('empresa').AsString;
end;

procedure TQLValorarStockConfeccionado.qrdbtxtproducto_apbPrint(
  sender: TObject; var Value: String);
begin
  Value:= desProducto( DataSet.fieldByName('empresa').AsString, Value );
end;

procedure TQLValorarStockConfeccionado.qrdbtxtenvase1Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvaseP( DataSet.fieldByName('empresa').AsString, Value,
                      DataSet.fieldByName('producto').AsString );
end;

procedure TQLValorarStockConfeccionado.qrdbtxtean128Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '''' + Value;
end;

procedure TQLValorarStockConfeccionado.qrdbtxtean13Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '''' + Value;
end;

procedure TQLValorarStockConfeccionado.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    qrlblFechaAlta.Height := qrlblEan134.Height;
    qrdbtxtfecha_alta.Height:= qrlblFechaAlta.Height;
  end
  else
  begin
    qrlblFechaAlta.Height := 68;
    qrdbtxtfecha_alta.Height:= 68;
  end;
end;

end.
