unit ValorarStockProveedorQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLValorarStockProveedor = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    qrdbtxtkilos: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
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
    qrdbtxtalmacen_el: TQRDBText;
    qrdbtxtproducto_apb: TQRDBText;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrbndSummaryBand1: TQRBand;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrdbtxtimporte_fruta: TQRDBText;
    qrdbtxtimporte_transitos: TQRDBText;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    bndDetalle: TQRSubDetail;
    bndCabDetalle: TQRBand;
    qrdbtxtsscc: TQRDBText;
    qrdbtxtvariedad: TQRDBText;
    qrdbtxtcalibre_apb: TQRDBText;
    qrdbtxtlote_apb: TQRDBText;
    qrdbtxtfecha_alta: TQRDBText;
    qrdbtxtstatus_apb: TQRDBText;
    qrdbtxtfecha_status_apb: TQRDBText;
    qrdbtxtlinea_volcado_apb: TQRDBText;
    qrdbtxtcajas_apb: TQRDBText;
    qrdbtxtpeso_apb: TQRDBText;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    procedure qrgrpPlantaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl1Print(sender: TObject; var Value: String);
    procedure qrdbtxtalmacen_elPrint(sender: TObject; var Value: String);
    procedure qrdbtxtproducto_apbPrint(sender: TObject; var Value: String);
    procedure qrdbtxtssccPrint(sender: TObject; var Value: String);
    procedure qrdbtxtlote_apbPrint(sender: TObject; var Value: String);
    procedure QRDBText4Print(sender: TObject; var Value: String);
  private

  public

    procedure PreparaListado( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                              const AProducto, AEntrega, AProveedor, AVariedad, ACalibre: string;
                              const AVerDetalle: Boolean );
  end;

  function VerListadoStock( const AOwner: TComponent;
                            const AEmpresa, ACentro: string; const AFecha: TDateTime;
                            const AProducto, AEntrega, AProveedor, AVariedad, ACalibre: string;
                            const AVerDetalle: Boolean  ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, ValorarStockProveedorDL, DPreview, UDMAuxDB, bMath;

var
  QLValorarStockProveedor: TQLValorarStockProveedor;
  DLValorarStockProveedor: TDLValorarStockProveedor;

procedure VerListadoStockEx( const AOwner: TComponent;
                          const AEmpresa, ACentro: string; const AFecha: TDateTime;
                          const AProducto, AEntrega, AProveedor, AVariedad, ACalibre: string;
                          const AVerDetalle: Boolean );
begin
  QLValorarStockProveedor:= TQLValorarStockProveedor.Create( AOwner );
  try
    QLValorarStockProveedor.PreparaListado( AEmpresa, ACentro, AFecha, AProducto, AEntrega,
                                            AProveedor, AVariedad, ACalibre, AVerDetalle);

    Previsualiza( QLValorarStockProveedor );
  finally
    FreeAndNil( QLValorarStockProveedor );
  end;
end;


function VerListadoStock( const AOwner: TComponent;
                          const AEmpresa, ACentro: string; const AFecha: TDateTime;
                          const AProducto, AEntrega, AProveedor, AVariedad, ACalibre: string;
                          const AVerDetalle: Boolean ): Boolean;
begin
  DLValorarStockProveedor:= TDLValorarStockProveedor.Create( AOwner );
  try
    result:= DLValorarStockProveedor.DatosQueryStock( AEmpresa, ACentro, AFEcha, AProducto, AEntrega,
                                                      AProveedor, AVariedad, ACalibre );
    if result then
    begin
      VerListadoStockEx( AOwner, AEmpresa, ACentro, AFecha, AProducto, AEntrega,
                         AProveedor, AVariedad, ACalibre, AVerDetalle );
    end;
  finally
    FreeAndNil( DLValorarStockProveedor );
  end;
end;


procedure TQLValorarStockProveedor.PreparaListado( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                          const AProducto, AEntrega, AProveedor, AVariedad, ACalibre: string;
                          const AVerDetalle: Boolean );
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


  lblTitulo.Caption:= 'VALORAR STOCK FRUTA PROVEEDOR';
  lblRangoFechas.Caption:= 'STOCK A ' + FormatDateTime('dd/mm/yyyy', AFEcha );

  bndDetalle.Enabled:= AVerDetalle;
  bndCabDetalle.Enabled:= AVerDetalle;
end;

procedure TQLValorarStockProveedor.qrgrpPlantaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Sender.Height:= 0;
end;

procedure TQLValorarStockProveedor.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total planta ' + DataSet.fieldByName('empresa').AsString;
end;

procedure TQLValorarStockProveedor.qrdbtxtalmacen_elPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProveedor( DataSet.fieldByName('origen').AsString,
                               DataSet.fieldByName('proveedor').AsString );
  //Value:= desProveedorAlmacen( DataSet.fieldByName('origen').AsString,
  //                             DataSet.fieldByName('proveedor').AsString, Value );
end;

procedure TQLValorarStockProveedor.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  Value:= '';
end;

procedure TQLValorarStockProveedor.qrdbtxtproducto_apbPrint(
  sender: TObject; var Value: String);
begin
  Value:= desProducto( DataSet.fieldByName('empresa').AsString,
                               Value );
end;

procedure TQLValorarStockProveedor.qrdbtxtssccPrint(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '''' + Value;
end;

procedure TQLValorarStockProveedor.qrdbtxtlote_apbPrint(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '''' + Value;
end;

end.
