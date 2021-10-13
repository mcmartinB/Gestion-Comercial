unit EntregasPendientesMasetQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLEntregasPendientesMaset = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCentro: TQRLabel;
    PageFooterBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRGroup1: TQRGroup;
    producto: TQRDBText;
    DetailBand1: TQRBand;
    QRBand1: TQRBand;
    QRDBText10: TQRDBText;
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
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    lblFecha_llegada: TQRDBText;
    lblFecha_carga: TQRDBText;
    QRDBText2: TQRDBText;
    lblMatricula: TQRDBText;
    albaran: TQRDBText;
    QRDBText3: TQRDBText;
    lblPalets: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    factura_conduce: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel5: TQRLabel;
    lblFacturaConduce: TQRLabel;
    QRLabel10: TQRLabel;
    transporte: TQRDBText;
    puerto: TQRDBText;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    lblRango: TQRLabel;
    qrlFechaLlegada: TQRLabel;
    qrlProducto: TQRLabel;
    qrgSemana: TQRGroup;
    qrlMsgSemana: TQRLabel;
    bndPieSemana: TQRBand;
    qrealbaran: TQRDBText;
    qrxTotAlbaran: TQRExpr;
    qrxTotAlbaranCaj: TQRExpr;
    qrxTotAlbaranKil: TQRExpr;
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure productoPrint(sender: TObject; var Value: String);
    procedure lblFecha_cargaPrint(sender: TObject; var Value: String);
    procedure albaranPrint(sender: TObject; var Value: String);
    procedure transportePrint(sender: TObject; var Value: String);
    procedure lblFecha_llegadaPrint(sender: TObject; var Value: String);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrealbaranPrint(sender: TObject; var Value: String);
  private
    sEmpresa, sProducto: string;
  public
    procedure PreparaListado( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string; const AAnyoSemana: integer );
  end;

  function VerListadoEntregasPendientesMaset( const AOwner: TComponent;
                            const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
                            const AAnyoSemana, AEstadoEntrega, AEstadoFecha: Integer ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, EntregasPendientesMasetDL, DPreview, UDMAuxDB, UDMConfig;

var
  QLEntregasPendientesMaset: TQLEntregasPendientesMaset;
  DLEntregasPendientesMaset: TDLEntregasPendientesMaset;

procedure VerListadoEntregasPendientesMasetEx( const AOwner: TComponent;
            const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
            const AAnyoSemana, AEstadoEntrega, AEstadoFecha: Integer );
begin
  QLEntregasPendientesMaset:= TQLEntregasPendientesMaset.Create( AOwner );
  try
    QLEntregasPendientesMaset.PreparaListado( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, AAnyoSemana  );

    case AEstadoEntrega of
      0:QLEntregasPendientesMaset.lblTitulo.Caption:= 'ENTREGAS PENDIENTES DE DESCARGAR';
      1:QLEntregasPendientesMaset.lblTitulo.Caption:= 'ENTREGAS DESCARGADAS';
      2:QLEntregasPendientesMaset.lblTitulo.Caption:= 'ENTREGAS DIRECTAS';
      3:QLEntregasPendientesMaset.lblTitulo.Caption:= 'TODAS LAS ENTREGAS';
    end;
    case AEstadoFecha of
      0:QLEntregasPendientesMaset.qrlFechaLlegada.Caption:= 'Fecha llegada definitiva';
      1:QLEntregasPendientesMaset.qrlFechaLlegada.Caption:= 'Fecha llegada provisional';
      2:QLEntregasPendientesMaset.qrlFechaLlegada.Caption:= 'Fecha llegada';
    end;

    Previsualiza( QLEntregasPendientesMaset );
  finally
    FreeAndNil( QLEntregasPendientesMaset );
  end;
end;

function VerListadoEntregasPendientesMaset( const AOwner: TComponent;
                                            const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
                                            const AAnyoSemana, AEstadoEntrega, AEstadoFecha: Integer ): Boolean;
begin
  DLEntregasPendientesMaset:= TDLEntregasPendientesMaset.Create( AOwner );
  try
    result:= DLEntregasPendientesMaset.DatosQueryEntregasPendientes( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, AAnyoSemana, AEstadoEntrega, AEstadoFecha );
    if result then
    begin
      VerListadoEntregasPendientesMasetEx( AOwner, AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, AAnyoSemana, AEstadoEntrega, AEstadoFecha );
    end;
  finally
    FreeAndNil( DLEntregasPendientesMaset );
  end;
end;

procedure TQLEntregasPendientesMaset.PreparaListado( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string; const AAnyoSemana: integer );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );
  lblCentro.Caption:= DesCentro( AEmpresa, ACentro );
  if AProducto <> '' then
  begin
    qrlProducto.Caption:= desProducto( AEmpresa, AProducto );
  end
  else
  begin
    qrlProducto.Caption:= 'TODOS LOS PRODUCTOS';
  end;
  if ( AFechaIni <> '' ) and ( AFechaFin <> '' ) then
  begin
    lblRango.Caption:= 'del ' + AFechaIni + ' al ' + AFechaFin;
  end
  else
  begin
    if AFechaIni <> '' then
    begin
      lblRango.Caption:= 'despues del ' + AFechaIni;
    end;
    if AFechaFin <> '' then
    begin
      lblRango.Caption:= 'antes del ' + AFechaFin;
    end
    else
    begin
    if AAnyoSemana  <> -1 then
    begin
      lblRango.Caption:= 'SEMANA: ' + IntToStr( AAnyoSemana );
    end
    else
    begin
      lblRango.Caption:= '';
    end;
    end;
  end;
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  qrgSemana.Height:= 1;
end;

procedure TQLEntregasPendientesMaset.QRDBText10Print(sender: TObject;
  var Value: String);
begin
  Value := 'TOTAL ' + desProducto( sEmpresa, Value );
end;

procedure TQLEntregasPendientesMaset.productoPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( sEmpresa, Value );
end;


procedure TQLEntregasPendientesMaset.lblFecha_cargaPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLEntregasPendientesMaset.QEntregasPendientes.FieldByName('fecha_carga').AsDateTime );
end;

procedure TQLEntregasPendientesMaset.albaranPrint(sender: TObject;
  var Value: String);
var
  iAux: integer;
begin
  if DLEntregasPendientesMaset.QEntregasPendientes.FieldByName('producto').AsString = 'PLA' then
  begin
    Value:= IntToStr( DLEntregasPendientesMaset.QEntregasPendientes.FieldByName('albaran').Asinteger mod 100 );
  end
  else
  begin
    Value:= DLEntregasPendientesMaset.QEntregasPendientes.FieldByName('pais').AsString;
  end;
end;

procedure TQLEntregasPendientesMaset.transportePrint(sender: TObject;
  var Value: String);
begin
  Value := desTransporte( sEmpresa, Value );
end;

procedure TQLEntregasPendientesMaset.lblFecha_llegadaPrint(sender: TObject;
  var Value: String);
begin
  if Value <> '' then
    Value:= FormatDateTime('dd/mm/yy', DLEntregasPendientesMaset.QEntregasPendientes.FieldByName('fecha_llegada').AsDateTime );
end;

procedure TQLEntregasPendientesMaset.QRBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= (DataSet.FieldByName('producto').AsString = 'PLA' ) and ( ( sEmpresa = '037' ) or ( sEmpresa = 'F17' ) or ( sEmpresa = 'F23' ) or  ( sEmpresa = 'F24' ) );
end;

procedure TQLEntregasPendientesMaset.qrealbaranPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL SEMANA ' + Value;
end;

end.
