unit SalidasPorFacturaQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLSalidasPorFactura = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    PageFooterBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    factura: TQRDBText;
    cliente: TQRDBText;
    neto: TQRDBText;
    kilos: TQRDBText;
    QRLabel1: TQRLabel;
    lblProveedor: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRSysData1: TQRSysData;
    fecha_factura: TQRDBText;
    QRLabel11: TQRLabel;
    lblMatricula: TQRLabel;
    producto: TQRDBText;
    lblRango: TQRLabel;
    QRLabel2: TQRLabel;
    lblCliente: TQRLabel;
    bndGrupo: TQRGroup;
    QRBand1: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRShape1: TQRShape;
    SummaryBand1: TQRBand;
    QRShape2: TQRShape;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    lblTotal: TQRExpr;
    QRLabel3: TQRLabel;
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure fecha_facturaPrint(sender: TObject; var Value: String);
    procedure clientePrint(sender: TObject; var Value: String);
    procedure productoPrint(sender: TObject; var Value: String);
    procedure bndGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lblTotalPrint(sender: TObject; var Value: String);
    procedure QRBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    sEmpresa, sCliente, sProducto: string;
    slblTotal: string;
  public
    procedure PreparaListado(
      const AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin: string;
      const AAgrupar, AVisualizar: integer );
  end;

  function VerListadoSalidasPorFactura( const AOwner: TComponent;
    const AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin: string;
    const AAgrupar, AVisualizar: integer ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, SalidasPorFacturaDL, DPreview, UDMAuxDB, UDMConfig;

var
  QLSalidasPorFactura: TQLSalidasPorFactura;
  DLSalidasPorFactura: TDLSalidasPorFactura;

procedure VerListadoSalidasPorFacturaEx( const AOwner: TComponent;
  const AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin: string;
  const AAgrupar, AVisualizar: integer );
begin
  QLSalidasPorFactura:= TQLSalidasPorFactura.Create( AOwner );
  try
    QLSalidasPorFactura.PreparaListado( AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin, AAgrupar, AVisualizar );
    Previsualiza( QLSalidasPorFactura );
  finally
    FreeAndNil( QLSalidasPorFactura );
  end;
end;

function VerListadoSalidasPorFactura( const AOwner: TComponent;
  const AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin: string;
  const AAgrupar, AVisualizar: integer ): Boolean;
begin
  DLSalidasPorFactura:= TDLSalidasPorFactura.Create( AOwner );
  try
    result:= DLSalidasPorFactura.DatosQuerySalidasPorFactura( AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin, AAgrupar, AVisualizar );
    if result then
    begin
      VerListadoSalidasPorFacturaEx( AOwner, AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin, AAgrupar, AVisualizar );
    end;
  finally
    FreeAndNil( DLSalidasPorFactura );
  end;
end;

procedure TQLSalidasPorFactura.PreparaListado( const AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin: string;
                                               const AAgrupar, AVisualizar: integer );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  if ACentro <> '' then
    lblCentro.Caption:= DesCentro( AEmpresa, ACentro )
  else
    lblCentro.Caption:= 'Todos los centros.';
  if ACliente <> '' then
    lblCliente.Caption:= DesCliente( AEmpresa, ACliente )
  else
    lblCLiente.Caption:= 'Todos los Clientes.';
  if ( AFechaIni <> '' ) and ( AFechaFin <> '' ) then
  begin
    lblRango.Caption:= 'del ' + AFechaIni + ' al ' + AFechaFin;
  end
  else
  begin
    if AFechaIni <> '' then
    begin
      lblRango.Caption:= 'despues del ' + AFechaIni;
    end
    else
    if AFechaFin <> '' then
    begin
      lblRango.Caption:= 'antes del ' + AFechaFin;
    end
    else
    begin
      lblRango.Caption:= '';
    end;
  end;
  sEmpresa:= AEmpresa;
  case  AAgrupar of
    0: begin
         bndGrupo.Expression:= '[factura]+[fecha_factura]';
         lblTotal.Expression:= '[factura]';
         slblTotal:= 'TOTAL FACTURA';
       end;
    1: begin
         bndGrupo.Expression:= '[cliente]';
         lblTotal.Expression:= '[cliente]';
         slblTotal:= 'TOTAL CLIENTE';
       end;
    2: begin
         bndGrupo.Expression:= '[producto]';
         lblTotal.Expression:= '[producto]';
         slblTotal:= 'TOTAL PRODUCTO';
       end;
  end;

    lblTitulo.Caption:= 'SALIDAS POR NÚMERO DE FACTURA';
end;

procedure TQLSalidasPorFactura.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + desProducto( sEmpresa, Value );
end;

procedure TQLSalidasPorFactura.fecha_facturaPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLSalidasPorFactura.QSalidasPorFactura.FieldByName('fecha_factura').AsDateTime );
end;

procedure TQLSalidasPorFactura.clientePrint(sender: TObject;
  var Value: String);
begin
  value:= Value + ' ' + desCliente(sEmpresa, value);
  (*
  if sCliente <> Value then
  begin
    sCliente:= Value;
    value:= Value + ' ' + desCliente(sEmpresa, value);
  end
  else
  begin
    value:= '';
  end;
  *)
end;

procedure TQLSalidasPorFactura.productoPrint(sender: TObject;
  var Value: String);
begin
  value:= Value + ' ' + desProducto(sEmpresa, value);
  (*
  if sProducto <> Value then
  begin
    sProducto:= Value;
    value:= Value + ' ' + desProducto(sEmpresa, value);
  end
  else
  begin
    value:= '';
  end;
  *)
end;

procedure TQLSalidasPorFactura.bndGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  bndGrupo.Height:= 0;
end;

procedure TQLSalidasPorFactura.lblTotalPrint(sender: TObject;
  var Value: String);
begin
  Value:= sLblTotal + ' ' + Value;
end;

procedure TQLSalidasPorFactura.QRBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  sCliente:= '';
  sProducto:= '';
end;

procedure TQLSalidasPorFactura.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  sCliente:= '';
  sProducto:= '';
end;

end.
