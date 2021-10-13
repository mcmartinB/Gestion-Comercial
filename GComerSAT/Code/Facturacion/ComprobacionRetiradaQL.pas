unit ComprobacionRetiradaQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,
  FacturacionCB;

type
  TQLComprobacionRetirada = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    bndDetalle: TQRBand;
    kilos_sl: TQRDBText;
    etqTitulo: TQRSysData;
    etqImpresoTitulo: TQRSysData;
    PageFooterBand1: TQRBand;
    QRSysData3: TQRSysData;
    etqRangoFechasTitulos: TQRLabel;
    etqClienteTitulo: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    n_albaran_sc: TQRDBText;
    fecha_sc: TQRDBText;
    n_factura_sc: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel1: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    SummaryBand1: TQRBand;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRLabel6: TQRLabel;
    QRExpr7: TQRExpr;
    etqOrigenTitulo: TQRLabel;
    etqSalidaTitulo: TQRLabel;
    etqCategoriaTitulo: TQRLabel;
    qrlbl1: TQRLabel;
    qrgrpCliente: TQRGroup;
    qrbndPieCliente: TQRBand;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    qrlbl2: TQRLabel;
    qrlblProducto: TQRLabel;
    etqEmpresa: TQRLabel;
    procedure producto_slPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel6Print(sender: TObject; var Value: String);
    procedure qrgrpClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPieClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl2Print(sender: TObject; var Value: String);
  private
    sEmpresa: String;
    iContadores: Integer;
    bAgruparCliente, bVerDetalle: Boolean;

  public
    constructor Create( AOwner: TComponent ); Override;
    destructor Destroy; Override;
  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
procedure ExecuteReport( APadre: TComponent; AParametros: RClienteQL );

implementation

{$R *.DFM}

uses Dialogs, ComprobacionRetiradaDL, UDMAuxDB, DPreview, CReportes;

var
  QLComprobacionRetirada: TQLComprobacionRetirada;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLComprobacionRetirada:= TQLComprobacionRetirada.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  ComprobacionRetiradaDL.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLComprobacionRetirada <> nil then
        FreeAndNil( QLComprobacionRetirada );
    end;
  end;
  ComprobacionRetiradaDL.UnloadModule;
end;

procedure ExecuteReport( APadre: TComponent; AParametros: RClienteQL );
begin
  LoadReport( APadre );
  if ComprobacionRetiradaDL.OpenData( APadre, AParametros) <> 0 then
  begin
     QLComprobacionRetirada.sEmpresa:= AParametros.sEmpresa;

     if AParametros.sSerie <> '' then
      QLComprobacionRetirada.etqEmpresa.Caption := desEmpresa(AParametros.sEmpresa) + '    Serie ' + AParametros.sSerie
     else
      QLComprobacionRetirada.etqEmpresa.Caption := desEmpresa(AParametros.sEmpresa);

     case AParametros.iProcedencia of
       0://TODOS
         QLComprobacionRetirada.ReportTitle:= 'FACTURAS POR PRODUCTO';
       1://DE LA EMPRESA
         QLComprobacionRetirada.ReportTitle:= 'FACTURAS POR PRODUCTO PROPIO ';
       2://DE TERCEROS
         QLComprobacionRetirada.ReportTitle:= 'FACTURAS POR PRODUCTO DE TERCEROS ';
     end;

     if AParametros.sProducto <> '' then
     begin
       QLComprobacionRetirada.qrlblProducto.Caption:= AParametros.sProducto + ' - ' +
         desProducto( AParametros.sEmpresa, AParametros.sProducto );
     end
     else
     begin
      if AParametros.sAgrupacion <> '' then
        QLComprobacionRetirada.qrlblProducto.Caption:= AParametros.sAgrupacion + ' - ' +
            desAgrupacion( AParametros.sAgrupacion )
       else
        QLComprobacionRetirada.qrlblProducto.Caption:= 'TODOS LOS PRODUCTOS ';
     end;
{
       case AParametros.iTipo of
         0://TOMATE
           QLComprobacionRetirada.qrlblProducto.Caption:= 'TODOS LOS TIPOS DE TOMATE';
         1://NO TOMATE
           QLComprobacionRetirada.qrlblProducto.Caption:= 'TODOS MENOS LOS TOMATES ';
         2://BERENJENAS
           QLComprobacionRetirada.qrlblProducto.Caption:= 'BERENJENAS ';
         3://PIMIENTOS
           QLComprobacionRetirada.qrlblProducto.Caption:= 'PIMIENTOS ';
         4: //TODOS
           QLComprobacionRetirada.qrlblProducto.Caption:= 'TODOS LOS PRODUCTOS ';
       end;
     end;
 }

     if AParametros.bFechaFactura then
       QLComprobacionRetirada.etqRangoFechasTitulos.Caption:= 'Facturas del ' +
         DateToStr( AParametros.dFechaDesde ) +
         ' al ' + DateToStr( AParametros.dFechaHasta )
     else
       QLComprobacionRetirada.etqRangoFechasTitulos.Caption:= 'Salidas del ' +
         DateToStr( AParametros.dFechaDesde ) +
         ' al ' + DateToStr( AParametros.dFechaHasta );

     if AParametros.sCliente <> '' then
     begin
       QLComprobacionRetirada.etqClienteTitulo.Caption:= AParametros.sCliente +
         '/' + desCliente( AParametros.sCliente );
     end
     else
     begin
       QLComprobacionRetirada.etqClienteTitulo.Caption:= '';
     end;

     //CENTRO ORIGEN
     if AParametros.sCentroOrigen <> '' then
     begin
       QLComprobacionRetirada.etqOrigenTitulo.Caption:= 'ORIGEN: ' +
         AParametros.sCentroOrigen + desCentro( AParametros.sEmpresa, AParametros.sCentroOrigen );
     end
     else
     begin
       QLComprobacionRetirada.etqOrigenTitulo.Caption:= 'CENTRO ORIGEN: TODOS';
     end;
     //CENTRO SALIDA
     if AParametros.sCentroSalida <> '' then
     begin
       QLComprobacionRetirada.etqSalidaTitulo.Caption:= 'SALIDA: ' +
         AParametros.sCentroSalida + desCentro( AParametros.sEmpresa, AParametros.sCentroSalida );
     end
     else
     begin
       QLComprobacionRetirada.etqSalidaTitulo.Caption:= 'CENTRO SALIDA: TODOS';
     end;
     //CATEGORIA
     if AParametros.sCategoria <> '' then
     begin
       QLComprobacionRetirada.etqCategoriaTitulo.Caption:= 'CATEGORIA: ' + AParametros.sCategoria;
     end
     else
     begin
       QLComprobacionRetirada.etqCategoriaTitulo.Caption:= 'CATEGORIA: TODAS';
     end;

     QLComprobacionRetirada.bAgruparCliente:= AParametros.bAgruparCliente;
     QLComprobacionRetirada.bVerDetalle:= AParametros.bVerDetalle;

//     PonLogoGrupoBonnysa( QLComprobacionRetirada, AParametros.sEmpresa );
     PonLogoGrupoBonnysa( QLComprobacionRetirada );
     Previsualiza( QLComprobacionRetirada );
  end
  else
  begin
    ShowMessage('Sin datos para mostrar para los parametros de selección introducidos.');
  end;
  UnloadReport;
end;

constructor TQLComprobacionRetirada.Create( AOwner: TComponent );
begin
  inherited;
  //BEGIN CODE

  //END CODE
end;

destructor TQLComprobacionRetirada.Destroy;
begin
  //BEGIN CODE

  //END CODE
  inherited;
end;

procedure TQLComprobacionRetirada.producto_slPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( sEmpresa, Value );
end;

procedure TQLComprobacionRetirada.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  iContadores:= 0;
end;

procedure TQLComprobacionRetirada.bndDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  iContadores:= iContadores + 1;
  if bVerDetalle then
    Sender.Height:= 14
  else
    Sender.Height:= 0;
end;

procedure TQLComprobacionRetirada.QRLabel6Print(sender: TObject;
  var Value: String);
begin
  Value:= '(' + IntToStr( iContadores ) + ' facturas).'
end;

procedure TQLComprobacionRetirada.qrgrpClienteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Sender.Height:= 0;
  PrintBand:= bAgruparCliente; 
end;

procedure TQLComprobacionRetirada.qrbndPieClienteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bAgruparCliente;
end;

procedure TQLComprobacionRetirada.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  if bVerDetalle then
    Value:= 'TOTAL CLIENTE ' + DataSet.fieldByName('cliente').AsString
  else
    Value:= DataSet.fieldByName('cliente').AsString + ' - ' +
            DataSet.fieldByName('nombre').AsString;
end;

end.
