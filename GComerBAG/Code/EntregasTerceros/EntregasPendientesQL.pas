unit EntregasPendientesQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLEntregasPendientes = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    PageFooterBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRGroup1: TQRGroup;
    producto: TQRDBText;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    Proveedor: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRBand1: TQRBand;
    QRDBText10: TQRDBText;
    QRLabel1: TQRLabel;
    lblProveedor: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    SummaryBand1: TQRBand;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRLabel9: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRSysData1: TQRSysData;
    pais: TQRDBText;
    QRLabel10: TQRLabel;
    fecha: TQRDBText;
    QRLabel11: TQRLabel;
    lblMatricula: TQRLabel;
    Matricula: TQRDBText;
    lblRango: TQRLabel;
    qrlFechaLlegada: TQRLabel;
    qrlProducto: TQRLabel;
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure productoPrint(sender: TObject; var Value: String);
    procedure ProveedorPrint(sender: TObject; var Value: String);
    procedure fechaPrint(sender: TObject; var Value: String);
  private
    sEmpresa: string;
  public
    procedure PreparaListado( const AEmpresa, ACentro, Aproducto, AFechaIni, AFechaFin: string );
  end;

  function VerListadoEntregasPendientes( const AOwner: TComponent;
                            const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
                            const AEstadoEntrega, AEstadoFecha: Integer ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, EntregasPendientesDL, DPreview, UDMAuxDB, UDMConfig;

var
  QLEntregasPendientes: TQLEntregasPendientes;
  DLEntregasPendientes: TDLEntregasPendientes;

procedure VerListadoEntregasPendientesEx( const AOwner: TComponent;
                                          const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
                                          const AEstadoEntrega, AEstadoFecha: integer );
begin
  QLEntregasPendientes:= TQLEntregasPendientes.Create( AOwner );
  try
    QLEntregasPendientes.PreparaListado( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin );

    if DMConfig.EsMaset then
    begin
      QLEntregasPendientes.lblProveedor.Caption:= 'Almacén';
      QLEntregasPendientes.lblMatricula.Caption:= 'Matrícula';
      QLEntregasPendientes.Proveedor.DataField:= 'Almacen';
      QLEntregasPendientes.Matricula.DataField:= 'Matricula';
    end
    else
    begin
      QLEntregasPendientes.lblProveedor.Caption:= 'Proveedor';
      QLEntregasPendientes.lblMatricula.Caption:= 'Variedad';
      QLEntregasPendientes.Proveedor.DataField:= 'Proveedor';
      QLEntregasPendientes.Matricula.DataField:= 'descripcion';
    end;

    case AEstadoEntrega of
      0:QLEntregasPendientes.lblTitulo.Caption:= 'ENTREGAS PENDIENTES DE DESCARGAR';
      1:QLEntregasPendientes.lblTitulo.Caption:= 'ENTREGAS DESCARGADAS';
      2:QLEntregasPendientes.lblTitulo.Caption:= 'ENTREGAS DIRECTAS';
      3:QLEntregasPendientes.lblTitulo.Caption:= 'TODAS LAS ENTREGAS';
    end;

    case AEstadoFecha of
      0:QLEntregasPendientes.qrlFechaLlegada.Caption:= 'Fecha llegada definitiva';
      1:QLEntregasPendientes.qrlFechaLlegada.Caption:= 'Fecha llegada provisional';
      2:QLEntregasPendientes.qrlFechaLlegada.Caption:= 'Fecha llegada';
    end;

    Previsualiza( QLEntregasPendientes );
  finally
    FreeAndNil( QLEntregasPendientes );
  end;
end;

function VerListadoEntregasPendientes( const AOwner: TComponent; const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
                                       const AEstadoEntrega, AEstadoFecha: Integer ): Boolean;
begin
  DLEntregasPendientes:= TDLEntregasPendientes.Create( AOwner );
  try
    result:= DLEntregasPendientes.DatosQueryEntregasPendientes( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, AEstadoEntrega, AEstadoFecha );
    if result then
    begin
      VerListadoEntregasPendientesEx( AOwner, AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, AEstadoEntrega, AEstadoFecha );
    end;
  finally
    FreeAndNil( DLEntregasPendientes );
  end;
end;

procedure TQLEntregasPendientes.PreparaListado( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblCentro.Caption:= DesCentro( AEmpresa, ACentro );
  if AProducto = '' then
    qrlProducto.Caption:= 'TODOS LOS PRODUCTOS'
  else
    qrlProducto.Caption:= DesProducto( AEmpresa, AProducto );
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
end;

procedure TQLEntregasPendientes.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + desProducto( sEmpresa, Value );
end;

procedure TQLEntregasPendientes.productoPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( sEmpresa, Value );
end;

procedure TQLEntregasPendientes.ProveedorPrint(sender: TObject;
  var Value: String);
begin
  if DMConfig.EsMaset then
  begin
    Value:= desProveedorAlmacen( sEmpresa, DataSet.FieldByName('proveedor').AsString, Value );
  end
  else
  begin
    Value:= desProveedor( sEmpresa, Value );
  end;
end;

procedure TQLEntregasPendientes.fechaPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLEntregasPendientes.QEntregasPendientes.FieldByName('fecha').AsDateTime );
end;

end.
