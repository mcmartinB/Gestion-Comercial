unit ListPackingOrdenQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLListPackingOrden = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblPeriodo: TQRLabel;
    PageFooterBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRGroup1: TQRGroup;
    envase: TQRDBText;
    DetailBand1: TQRBand;
    fecha: TQRDBText;
    sscc: TQRDBText;
    kilos: TQRDBText;
    cajas: TQRDBText;
    cliente: TQRDBText;
    QRBand1: TQRBand;
    QRDBText10: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    SummaryBand1: TQRBand;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRLabel9: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRSysData1: TQRSysData;
    albaran: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    orden: TQRDBText;
    QRLabel3: TQRLabel;
    transportista: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    lblProducto: TQRLabel;
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure envasePrint(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure transportistaPrint(sender: TObject; var Value: String);
    procedure ssccPrint(sender: TObject; var Value: String);
    procedure QRDBText1Print(sender: TObject; var Value: String);

  private
    sEmpresa: string;

  public
    procedure PreparaListado( const AEmpresa, AProducto, AEnvase, ACliente, AFechaIni, AFechaFin: string );

  end;

  function VerListadoOrden( const AOwner: TComponent;
                          const AEmpresa, AProducto, AEnvase, ACliente: string ;
                          const AFechaIni, AFechaFin: TDateTime ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, ListPackingOrdenDL, DPreview, UDMAuxDB, bMath;

var
  QLListPackingOrden: TQLListPackingOrden;
  DLListPackingOrden: TDLListPackingOrden;

procedure VerListadoOrdenEx( const AOwner: TComponent;
                          const AEmpresa, AProducto, AEnvase, ACliente: string ;
                          const AFechaIni, AFechaFin: TDateTime );
begin
  QLListPackingOrden:= TQLListPackingOrden.Create( AOwner );
  try
    QLListPackingOrden.PreparaListado( AEmpresa, AProducto, AEnvase, ACliente, DateToStr(AFechaIni), DateToStr(AFechaFin) );
    Previsualiza( QLListPackingOrden );
  finally
    FreeAndNil( QLListPackingOrden );
  end;
end;

function VerListadoOrden( const AOwner: TComponent;
                          const AEmpresa, AProducto, AEnvase, ACliente: string ;
                          const AFechaIni, AFechaFin: TDateTime ): Boolean;
begin
  DLListPackingOrden:= TDLListPackingOrden.Create( AOwner );
  try
    result:= DLListPackingOrden.DatosListado( AEmpresa, AProducto, AEnvase, ACliente, AFechaIni, AFechaFin );
    if result then
    begin
      VerListadoOrdenEx( AOwner, AEmpresa, AProducto, AEnvase, ACliente, AFechaIni, AFechaFin );
    end;
  finally
    FreeAndNil( DLListPackingOrden );
  end;
end;

procedure TQLListPackingOrden.PreparaListado( const AEmpresa, AProducto, AEnvase, ACliente, AFechaIni, AFechaFin: string );
begin
  sEmpresa:= AEmpresa;
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblPeriodo.Caption:= 'Del ' + AFechaIni + ' al ' + AFechaFin;
  if AProducto = '' then
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS'
  else
    lblProducto.Caption:= AProducto + ' ' +  desProductoBase( sEmpresa, AProducto );
end;

procedure TQLListPackingOrden.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value:= 'ENVASE ' + Value + ' ' + desEnvasePBase( sEmpresa, value, DLListPackingOrden.QListadoOrdenCarga.FieldByName('producto_base_pl').AsString );
end;

procedure TQLListPackingOrden.envasePrint(sender: TObject;
  var Value: String);
begin                                                         
  Value:= Value + ' ' + desEnvasePBase( sEmpresa, value, DataSet.FieldByName('producto_base_pl').AsString );
end;

procedure TQLListPackingOrden.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( value );
end;

procedure TQLListPackingOrden.transportistaPrint(sender: TObject;
  var Value: String);
begin
  Value:= desTransporte( sEmpresa, value );
end;

procedure TQLListPackingOrden.ssccPrint(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '''' + Value;
  end;
end;

procedure TQLListPackingOrden.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '''' + Value;
  end;
end;

end.
