unit StockFrutaConfeccionadaMasetQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLStockFrutaConfeccionadaMaset = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    PageFooterBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    fecha_carga: TQRDBText;
    formato: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText8: TQRDBText;
    etqCarga: TQRLabel;
    lblFormato: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRSysData1: TQRSysData;
    des_Envase: TQRDBText;
    des_formato: TQRDBText;
    lblClientes: TQRLabel;
    fecha_alta: TQRDBText;
    etqAlta: TQRLabel;
    bndGroup1: TQRGroup;
    bndGroup2: TQRGroup;
    lblGroup1: TQRDBText;
    lblGroup2: TQRDBText;
    bndPieGroup1: TQRBand;
    bndPieGroup2: TQRBand;
    lblPieGroup2: TQRDBText;
    lblPieGroup1: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRBand1: TQRBand;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRLabel2: TQRLabel;
    lblProducto: TQRDBText;
    etqProducto: TQRLabel;
    procedure fecha_cargaPrint(sender: TObject; var Value: String);
    procedure fecha_altaPrint(sender: TObject; var Value: String);
    procedure lblGroup1Print(sender: TObject; var Value: String);
    procedure lblGroup2Print(sender: TObject; var Value: String);
    procedure lblPieGroup2Print(sender: TObject; var Value: String);
    procedure lblPieGroup1Print(sender: TObject; var Value: String);
    procedure lblProductoPrint(sender: TObject; var Value: String);
  private
    sEmpresa: String;
    bAgruparProducto: boolean;
  public
    procedure PreparaListado( const AEmpresa, ACentro, ACliente, AFechaDesde, AFechaHasta: string;
                              const AResumen, AAgruparProducto: boolean );
  end;

  function VerListadoStockConfeccionado( const AOwner: TComponent;
                            const AEmpresa, ACentro, ACliente: string;
                            const AFechaCarga: TDateTime;
                            const AResumen, AAgruparProducto: Boolean ): Boolean;
  function VerListadoPaletsConfeccionados( const AOwner: TComponent;
                               const AEmpresa, ACentro, ACliente: string;
                               const AFechaDesde, AFechaHasta: TDateTime;
                               const AResumen, AAgruparProducto: Boolean ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, StockFrutaConfeccionadaMasetDL, DPreview, UDMAuxDB;

var
  QLStockFrutaConfeccionadaMaset: TQLStockFrutaConfeccionadaMaset;
  DLStockFrutaConfeccionadaMaset: TDLStockFrutaConfeccionadaMaset;

procedure VerListadoStockConfeccionadoEx( const AOwner: TComponent;
                                          const AEmpresa, ACentro, ACliente: string;
                                          const AResumen, AAgruparProducto: boolean );
begin
  QLStockFrutaConfeccionadaMaset:= TQLStockFrutaConfeccionadaMaset.Create( AOwner );
  try
    QLStockFrutaConfeccionadaMaset.PreparaListado( AEmpresa, ACentro, ACliente, '', '', AResumen, AAgruparProducto );
    Previsualiza( QLStockFrutaConfeccionadaMaset );
  finally
    FreeAndNil( QLStockFrutaConfeccionadaMaset );
  end;
end;

function VerListadoStockConfeccionado( const AOwner: TComponent; const AEmpresa, ACentro, ACliente: string;
                                       const AFechaCarga: TDateTime;
                                       const AResumen, AAgruparProducto: Boolean ): Boolean;
begin
  DLStockFrutaConfeccionadaMaset:= TDLStockFrutaConfeccionadaMaset.Create( AOwner );
  try
    result:= DLStockFrutaConfeccionadaMaset.DatosQueryStock( AEmpresa, ACentro, ACliente, AFechaCarga,
                                                             AResumen, AAgruparProducto );
    if result then
    begin
      VerListadoStockConfeccionadoEx( AOwner, AEmpresa, ACentro, ACliente, AResumen , AAgruparProducto );
    end;
  finally
    FreeAndNil( DLStockFrutaConfeccionadaMaset );
  end;
end;

procedure VerListadoPaletsConfeccionadosEx( const AOwner: TComponent;
                                const AEmpresa, ACentro, ACliente: string;
                                const AFechaDesde, AFechaHasta: TDateTime;
                                const AResumen, AAgruparProducto: boolean  );
begin
  QLStockFrutaConfeccionadaMaset:= TQLStockFrutaConfeccionadaMaset.Create( AOwner );
  try
    QLStockFrutaConfeccionadaMaset.PreparaListado( AEmpresa, ACentro, ACliente, DateToStr( AFechaDesde) , DateToStr( AFechaHasta ),
                                                   AResumen, AAgruparProducto );
    Previsualiza( QLStockFrutaConfeccionadaMaset );
  finally
    FreeAndNil( QLStockFrutaConfeccionadaMaset );
  end;
end;

function VerListadoPaletsConfeccionados( const AOwner: TComponent;
                             const AEmpresa, ACentro, ACliente: string;
                             const AFechaDesde, AFechaHasta: TDateTime;
                             const AResumen, AAgruparProducto: Boolean ): Boolean;
begin
  DLStockFrutaConfeccionadaMaset:= TDLStockFrutaConfeccionadaMaset.Create( AOwner );
  try
    result:= DLStockFrutaConfeccionadaMaset.DatosQueryConfeccionado( AEmpresa, ACentro, ACliente, AFechaDesde, AFechaHasta, AResumen, AAgruparProducto );
    if result then
    begin
      VerListadoPaletsConfeccionadosEx( AOwner, AEmpresa, ACentro, ACliente, AFechaDesde, AFechaHasta, AResumen, AAgruparProducto );
    end;
  finally
    FreeAndNil( DLStockFrutaConfeccionadaMaset );
  end;
end;

procedure TQLStockFrutaConfeccionadaMaset.PreparaListado( const AEmpresa, ACentro, ACliente, AFechaDesde, AFechaHasta: string;
                                                          const AResumen, AAgruparProducto: boolean );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblCentro.Caption:= DesCentro( AEmpresa, ACentro );
  if ACliente <> '' then
    lblClientes.Caption:= DesCliente( AEmpresa, ACliente )
  else
    lblClientes.Caption:= 'TODOS LOS CLIENTES';
  sEmpresa:= AEmpresa;
  if AFechaDesde <> '' then
  begin
    if AFechaDesde <> AFechaHasta then
      lblTitulo.Caption:= 'PALETS CONFECCIONADOS DEL "' + AFechadesde + '" AL "'  + AFechaHasta + '"'
    else
      lblTitulo.Caption:= 'PALETS CONFECCIONADOS EL "' + AFechadesde + '"';
  end
  else
    lblTitulo.Caption:= 'STOCK FRUTA CONFECCIONADA';


  bndGroup1.Enabled:= not AResumen;
  bndGroup2.Enabled:= not AResumen;
  bndPieGroup1.Enabled:= not AResumen;
  bndPieGroup2.Enabled:= not AResumen;
  fecha_carga.Enabled:= not AResumen;
  fecha_alta.Enabled:= not AResumen;
  lblProducto.Enabled:= AResumen;
  etqCarga.Enabled:= not AResumen;
  etqAlta.Enabled:= not AResumen;
  etqProducto.Enabled:= AResumen;

  bAgruparProducto:= AAgruparProducto;

  if AResumen then
  begin
    bndGroup1.Expression:= '';
    bndGroup1.Expression:= '';
    lblGroup1.DataField:= '';
    lblGroup2.DataField:= '';
    lblPieGroup1.DataField:= '';
    lblPieGroup2.DataField:= '';
  end
  else
  begin
    if AAgruparProducto then
    begin
      bndGroup1.Expression:= '[producto]';
      bndGroup2.Expression:= '[producto]+[fecha_carga]';
      lblGroup1.DataField:= 'producto';
      lblGroup2.DataField:= 'fecha_carga';
      lblPieGroup1.DataField:= 'producto';
      lblPieGroup2.DataField:= 'fecha_carga';
    end
    else
    begin
      bndGroup1.Expression:= '[fecha_carga]';
      bndGroup2.Expression:= '[fecha_carga]+[producto]';
      lblGroup1.DataField:= 'fecha_carga';
      lblGroup2.DataField:= 'producto';
      lblPieGroup1.DataField:= 'fecha_carga';
      lblPieGroup2.DataField:= 'producto';
    end;
  end;
end;

procedure TQLStockFrutaConfeccionadaMaset.fecha_cargaPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatDateTime( 'dd/mm/yy', DataSet.Fieldbyname( 'fecha_carga').AsDateTime );
end;

procedure TQLStockFrutaConfeccionadaMaset.fecha_altaPrint(sender: TObject;
  var Value: String);
begin
  Value:= FormatDateTime( 'dd/mm/yy', DataSet.Fieldbyname( 'fecha_alta').AsDateTime );
end;

procedure TQLStockFrutaConfeccionadaMaset.lblGroup1Print(sender: TObject;
  var Value: String);
begin
  if bAgruparProducto then
   Value:= desProductoBase( sEmpresa, DataSet.Fieldbyname( 'producto').AsString )
  else
    Value:= FormatDateTime( 'dd/mm/yy', DataSet.Fieldbyname( 'fecha_carga').AsDateTime );
end;

procedure TQLStockFrutaConfeccionadaMaset.lblPieGroup1Print(sender: TObject;
  var Value: String);
begin
  if bAgruparProducto then
   Value:= 'TOTAL ' + desProductoBase( sEmpresa, DataSet.Fieldbyname( 'producto').AsString )
  else
    Value:= 'TOTAL ' + FormatDateTime( 'dd/mm/yy', DataSet.Fieldbyname( 'fecha_carga').AsDateTime );
end;

procedure TQLStockFrutaConfeccionadaMaset.lblGroup2Print(sender: TObject;
  var Value: String);
begin
  if bAgruparProducto then
    Value:= desProductoBase( sEmpresa, DataSet.Fieldbyname( 'producto').AsString ) + ' ' +
            FormatDateTime( 'dd/mm/yy', DataSet.Fieldbyname( 'fecha_carga').AsDateTime )
  else
    Value:= FormatDateTime( 'dd/mm/yy', DataSet.Fieldbyname( 'fecha_carga').AsDateTime ) + ' ' +
            desProductoBase( sEmpresa, DataSet.Fieldbyname( 'producto').AsString );

end;

procedure TQLStockFrutaConfeccionadaMaset.lblPieGroup2Print(sender: TObject;
  var Value: String);
begin
  if bAgruparProducto then
    Value:= 'TOTAL ' + desProductoBase( sEmpresa, DataSet.Fieldbyname( 'producto').AsString ) + ' ' +
            FormatDateTime( 'dd/mm/yy', DataSet.Fieldbyname( 'fecha_carga').AsDateTime )
  else
    Value:= 'TOTAL ' + FormatDateTime( 'dd/mm/yy', DataSet.Fieldbyname( 'fecha_carga').AsDateTime ) + ' ' +
            desProductoBase( sEmpresa, DataSet.Fieldbyname( 'producto').AsString );
end;


procedure TQLStockFrutaConfeccionadaMaset.lblProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProductoBase( sEmpresa, DataSet.Fieldbyname( 'producto').AsString );
end;

end.
