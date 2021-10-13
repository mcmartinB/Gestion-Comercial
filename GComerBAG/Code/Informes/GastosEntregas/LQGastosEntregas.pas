unit LQGastosEntregas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLGastosEntregas = class(TQuickRep)
    bndCabeceraListado: TQRBand;
    lblTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    bndPieListado: TQRBand;
    QRSysData2: TQRSysData;
    DetailBand1: TQRBand;
    entrega_ec: TQRDBText;
    QRDBText4: TQRDBText;
    proveedor_ec: TQRDBText;
    lblRangoFechas: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel1: TQRLabel;
    qrlTipoFecha: TQRLabel;
    QRLabel6: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRSubDetailGastos: TQRSubDetail;
    QRDBText6: TQRDBText;
    qreKilosEntrega1: TQRDBText;
    qreImporteEntrega1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText2: TQRDBText;
    qreImporteEntrega2: TQRDBText;
    QRDBText11: TQRDBText;
    QRCabGastos: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRShape1: TQRShape;
    QRPieGastos: TQRBand;
    QRDBText12: TQRDBText;
    lblProducto: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel14: TQRLabel;
    QRDBText13: TQRDBText;
    QRLabel15: TQRLabel;
    adjudicacion: TQRDBText;
    qrgProducto: TQRGroup;
    qreproducto_el: TQRDBText;
    bndPieProducto: TQRBand;
    qrlTotalProducto: TQRLabel;
    qrs1: TQRShape;
    SummaryBand1: TQRBand;
    QRLabel3: TQRLabel;
    qrs2: TQRShape;
    qreKilosEntrega: TQRDBText;
    qreImporteEntrega: TQRDBText;
    qrlDatosEntrega: TQRLabel;
    qrlImporteEntrega: TQRLabel;
    qrlPrecioEntregaKg: TQRLabel;
    qrlImporteProducto: TQRLabel;
    qrlPrecioProductoKg: TQRLabel;
    qrlImporteTotal: TQRLabel;
    qrlPrecioTotalKg: TQRLabel;
    qrlPiezas: TQRLabel;
    qreunidades_ec: TQRDBText;
    qreunidades_ec1: TQRDBText;
    qreimporte_ge: TQRDBText;
    qrlPrecioProductoUd: TQRLabel;
    qrlPrecioTotalUd: TQRLabel;
    qrlPrecioEntregaUd: TQRLabel;
    qrl1: TQRLabel;
    qrlKilosProducto: TQRLabel;
    qrlUdsProducto: TQRLabel;
    qrlUdsListado: TQRLabel;
    qrlKgsListado: TQRLabel;
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure proveedor_ecPrint(sender: TObject; var Value: String);
    procedure QRCabGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetailGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRPieGastosBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText12Print(sender: TObject; var Value: String);
    procedure QRDBText13Print(sender: TObject; var Value: String);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure adjudicacionPrint(sender: TObject; var Value: String);
    procedure qrgProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlTotalProductoPrint(sender: TObject; var Value: String);
    procedure qrlDatosEntregaPrint(sender: TObject; var Value: String);
    procedure qreKilosEntregaPrint(sender: TObject; var Value: String);
    procedure qreImporteEntregaPrint(sender: TObject; var Value: String);
    procedure qreImporteEntrega2Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreimporte_gePrint(sender: TObject; var Value: String);
  private
    bAgruparProducto: Boolean;
    rKgsLineas, rKgsEntrega, rKgsProducto, rKgsListado: real;
    rUdsLineas, rUdsEntrega, rUdsProducto, rUdsListado: real;
    bLineas, bProducto, bListado: boolean;
    rImporteLineas, rImporteProducto, rImporteListado: Real;

  public
    sEmpresa: string;

  end;

function Imprimir( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                   const AFechaIni, AFechaFin, AFechaCorte: TDateTime; const ACorte: Boolean;
                   const AAgruparProducto, ASepararHojas: boolean; const ASinGastos: Integer; 
                   const ATipoCodigo, AFacturaGrabada: Integer; const AFechaFactura: TDateTime ): boolean;

implementation

{$R *.DFM}

uses
  LDGastosEntregas, DPreview, UDMAuxDB, CReportes, UDMConfig;

var
  QLGastosEntregas: TQLGastosEntregas;

function Imprimir( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                   const AFechaIni, AFechaFin, AFechaCorte: TDateTime; const ACorte: Boolean;
                   const AAgruparProducto, ASepararHojas: boolean; const ASinGastos: Integer;
                   const ATipoCodigo, AFacturaGrabada: Integer; const AFechaFactura: TDateTime ): boolean;
begin
  DLGastosEntregas:= TDLGastosEntregas.Create( Application );
  try
    result:= DLGastosEntregas.ObtenerDatosCompletos(AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto,
                AFechaIni, AFechaFin, AFechaCorte, ACorte, AAgruparProducto, ASinGastos, ATipoCodigo, AFacturaGrabada, AFechaFactura );
    if result then
    begin
      QLGastosEntregas:= TQLGastosEntregas.Create( Application );
      QLGastosEntregas.sEmpresa:= AEmpresa;
      QLGastosEntregas.bAgruparProducto:= AAgruparProducto;
      QLGastosEntregas.qrgProducto.ForceNewPage:= ASepararHojas;
      QLGastosEntregas.qrlTipoFecha.Caption:= 'F.Llegada';
      PonLogoGrupoBonnysa( QLGastosEntregas, AEmpresa );
      if AEntrega = '' then
        QLGastosEntregas.lblRangoFechas.Caption:= DateToStr( AFechaIni ) + ' a ' +
                                                      DateToStr( AFechaFin )
      else
        QLGastosEntregas.lblRangoFechas.Caption:= 'ENTREGA ' + AEntrega;
      if DMConfig.EsMaset then
      begin
        QLGastosEntregas.lblProducto.Caption:= 'F.Conduce / Producto';
        QLGastosEntregas.adjudicacion.Enabled:= True;
      end
      else
      begin
        QLGastosEntregas.lblProducto.Caption:= 'Producto';
        QLGastosEntregas.adjudicacion.Enabled:= False;
      end;
      try
        Preview( QLGastosEntregas );
      except
        FreeAndNil(QLGastosEntregas);
        raise;
      end;
    end;
  finally
    DLGastosEntregas.CerrarQuery;
    FreeAndNil( DLGastosEntregas );
  end;
end;

procedure TQLGastosEntregas.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  If VAlue <> '0' then
  begin
    Value:= 'OK';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQLGastosEntregas.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value:= Value;
end;

procedure TQLGastosEntregas.QRDBText12Print(sender: TObject;
  var Value: String);
begin
  Value:= desTipoGastos( Value );
end;

procedure TQLGastosEntregas.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa_ec').AsString, Value );
end;

procedure TQLGastosEntregas.proveedor_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProveedor( DataSet.FieldByName('empresa_ec').AsString, Value );
end;

procedure TQLGastosEntregas.QRCabGastosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //PrintBand:=  not QRSubDetailGastos.DataSet.IsEmpty;
end;

procedure TQLGastosEntregas.QRSubDetailGastosBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  //PrintBand:=  not QRSubDetailGastos.DataSet.IsEmpty;
end;


procedure TQLGastosEntregas.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rKgsLineas:= rKgsLineas + DLGastosEntregas.QDetalleLinea.FieldByName('kilos_el').AsFloat;
  rKgsProducto:= rKgsProducto + DLGastosEntregas.QDetalleLinea.FieldByName('kilos_el').AsFloat;
  rKgsListado:= rKgsListado + DLGastosEntregas.QDetalleLinea.FieldByName('kilos_el').AsFloat;

  rUdsLineas:= rUdsLineas + DLGastosEntregas.QDetalleLinea.FieldByName('unidades_el').AsFloat;
  rUdsProducto:= rUdsProducto + DLGastosEntregas.QDetalleLinea.FieldByName('unidades_el').AsFloat;
  rUdsListado:= rUdsListado + DLGastosEntregas.QDetalleLinea.FieldByName('unidades_el').AsFloat;

  if not bLineas then
    bLineas:= DLGastosEntregas.QDetalleLinea.FieldByName('unidades_el').AsFloat = 0;
  if not bProducto then
    bProducto:= DLGastosEntregas.QDetalleLinea.FieldByName('unidades_el').AsFloat = 0;;
  if not bListado then
    bListado:= DLGastosEntregas.QDetalleLinea.FieldByName('unidades_el').AsFloat = 0;;
end;

procedure TQLGastosEntregas.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rKgsEntrega:= DataSet.FieldByName('kilos_ec').AsFloat;
  rUdsEntrega:= DataSet.FieldByName('unidades_ec').AsFloat;
  rKgsLineas:= 0;
  rUdsLineas:= 0;
  bLineas:= False;
end;

procedure TQLGastosEntregas.adjudicacionPrint(sender: TObject;
  var Value: String);
begin
  (*
  if DMConfig.EsValenciaBonde or DMConfig.EsTenerifeBonde  then
    Value:= '';
  *)
end;

procedure TQLGastosEntregas.qrgProductoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bAgruparProducto;
end;

procedure TQLGastosEntregas.qrlTotalProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL GASTOS PRODUCTO ' + DataSet.FieldByName('producto_el').AsString;
end;

procedure TQLGastosEntregas.qrlDatosEntregaPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('n_productos_ec').AsInteger <= 1 then
  begin
    Value:= '';
  end;
end;

procedure TQLGastosEntregas.qreKilosEntregaPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('n_productos_ec').AsInteger <= 1 then
  begin
    Value:= '';
  end;
end;

procedure TQLGastosEntregas.qreImporteEntregaPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('n_productos_ec').AsInteger <= 1 then
  begin
    Value:= '';
  end;
end;

procedure TQLGastosEntregas.qreImporteEntrega2Print(sender: TObject;
  var Value: String);
var
  rAux: Real;
begin
  rAux:= QRSubDetailGastos.DataSet.FieldByName('importe_ge').AsFloat;
    if rKgsEntrega <> rKgsLineas then
    begin
      if rKgsEntrega > 0 then
      begin
        rAux:= ( QRSubDetailGastos.DataSet.FieldByName('importe_ge').AsFloat * rKgsLineas ) / rKgsEntrega;
      end
      else
      begin
        rAux:= 0;
      end;
      Value:= FormatFloat('#,##0.00', rAux );
    end;

  rImporteLineas:=  rImporteLineas + rAux;
  rImporteProducto:=  rImporteProducto + rAux;
  rImporteListado:=  rImporteListado + rAux;
end;

procedure TQLGastosEntregas.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  rImporteLineas:=  0;
  rImporteProducto:=  0;
  rImporteListado:=  0;

  rKgsLineas:= 0;
  rKgsEntrega:= 0;
  rKgsProducto:= 0;
  rKgsListado:= 0;
  rUdsLineas:= 0;
  rUdsEntrega:= 0;
  rUdsProducto:= 0;
  rUdsListado:= 0;
  bLineas:= False;
  bProducto:= False;
  bListado:= False;

  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    qreunidades_ec.Mask:= '#,##0';
    qreunidades_ec1.Mask:= '#,##0';
    qreKilosEntrega.Mask:= '#,##0.00';
    qreKilosEntrega1.Mask:= '#,##0.00';
    qreImporteEntrega.Mask:= '#,##0.00';
    qreImporteEntrega1.Mask:= '#,##0.00';
    qreImporteEntrega2.Mask:= '#,##0.00';
  end
  else
  begin
    qreunidades_ec.Mask:= '#,##0u';
    qreunidades_ec1.Mask:= '#,##0u';
    qreKilosEntrega.Mask:= '#,##0.00k';
    qreKilosEntrega1.Mask:= '#,##0.00k';
    qreImporteEntrega.Mask:= '#,##0.00€';
    qreImporteEntrega1.Mask:= '#,##0.00€';
    qreImporteEntrega2.Mask:= '#,##0.00€';
  end

end;

procedure TQLGastosEntregas.QRPieGastosBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  sMask: String;
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    sMask:= '#,##0.000'
  else
    sMask:= '#,##0.000€';
  qrlImporteEntrega.Caption:= FormatFloat(sMask, rImporteLineas );

  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    sMask:= '#,##0.000'
  else
    sMask:= '#,##0.000€/k';
  if rKgsLineas = 0 then
  begin
    qrlPrecioEntregaKg.Caption:= '---';
  end
  else
  begin
    qrlPrecioEntregaKg.Caption:= FormatFloat( sMask, rImporteLineas / rKgsLineas );
  end;

  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    sMask:= '#,##0.000'
  else
    sMask:= '#,##0.000€/u';
  if ( rUdsLineas = 0 ) or bLineas then
  begin
    qrlPrecioEntregaUd.Caption:= '---';
  end
  else
  begin
    qrlPrecioEntregaUd.Caption:= FormatFloat( sMask, rImporteLineas / rUdsLineas );
  end;

  rImporteLineas:= 0;
  bLineas:= false;
end;

procedure TQLGastosEntregas.bndPieProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  sMask: String;
begin
  PrintBand:= bAgruparProducto;
  if PrintBand then
  begin
    if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
      sMask:= '#,##0'
    else
      sMask:= '#,##0u';
    qrlUdsProducto.Caption:= FormatFloat(sMask, rUdsProducto );

    if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
      sMask:= '#,##0.00'
    else
      sMask:= '#,##0.00k';
    qrlKilosProducto.Caption:= FormatFloat(sMask, rKgsProducto );

    if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
      sMask:= '#,##0.00'
    else
      sMask:= '#,##0.00€';
    qrlImporteProducto.Caption:= FormatFloat(sMask, rImporteProducto );

    if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
      sMask:= '#,##0.000'
    else
      sMask:= '#,##0.000€/k';
    if rKgsProducto = 0 then
    begin
      qrlPrecioProductoKg.Caption:= '---';
    end
    else
    begin
      qrlPrecioProductoKg.Caption:= FormatFloat( sMask, rImporteProducto / rKgsProducto );
    end;

    if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
      sMask:= '#,##0.000'
    else
      sMask:= '#,##0.000€/u';
    if ( rUdsProducto = 0 ) or bProducto then
    begin
      qrlPrecioProductoUd.Caption:= '---';
    end
    else
    begin
      qrlPrecioProductoUd.Caption:= FormatFloat( sMask, rImporteProducto / rUdsProducto );
    end;
  end;
  rKgsProducto:= 0;
  rUdsProducto:= 0;
  bProducto:= false;
  rImporteProducto:= 0;
end;

procedure TQLGastosEntregas.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  sMask: String;
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    sMask:= '#,##0'
  else
    sMask:= '#,##0u';
  qrlUdsListado.Caption:= FormatFloat(sMask, rUdsListado );

  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    sMask:= '#,##0.00'
  else
    sMask:= '#,##0.00k';
  qrlKgsListado.Caption:= FormatFloat(sMask, rKgsListado );

  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    sMask:= '#,##0.000'
  else
    sMask:= '#,##0.000€';
  qrlImporteTotal.Caption:= FormatFloat(sMask, rImporteListado );

  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    sMask:= '#,##0.000'
  else
    sMask:= '#,##0.000€/k';
  if rKgsListado = 0 then
  begin
    qrlPrecioTotalKg.Caption:= '---';
  end
  else
  begin
    qrlPrecioTotalKg.Caption:= FormatFloat( sMask, rImporteListado / rKgsListado );
  end;

  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    sMask:= '#,##0.000'
  else
    sMask:= '#,##0.000€/u';
  if ( rUdsListado = 0 ) or bListado then
  begin
    qrlPrecioTotalUd.Caption:= '---';
  end
  else
  begin
    qrlPrecioTotalUd.Caption:= FormatFloat( sMask, rImporteListado / rUdsListado );
  end;

  rKgsListado:= 0;
  rUdsListado:= 0;
  bListado:= false;
  rImporteListado:= 0;
end;

procedure TQLGastosEntregas.qreimporte_gePrint(sender: TObject;
  var Value: String);
var
  sMask: String;
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    sMask:= '#,##0.000'
  else
    sMask:= '#,##0.000€/k';

  if DLGastosEntregas.QDetalleGasto.FieldByName('kilos_linea_ge').AsFloat = 0 then
  begin
    Value:= '---';
  end
  else
  begin
    Value:= FormatFloat( sMask,
                       DLGastosEntregas.QDetalleGasto.FieldByName('importe_ge').AsFloat /
                       DLGastosEntregas.QDetalleGasto.FieldByName('kilos_linea_ge').AsFloat );
  end;
end;

procedure TQLGastosEntregas.QRDBText13Print(sender: TObject;
  var Value: String);
var
  sMask: String;
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    sMask:= '#,##0.000'
  else
    sMask:= '#,##0.000€/u';

  if DLGastosEntregas.QDetalleGasto.FieldByName('unidades_linea_ge').AsFloat = 0 then
  begin
    Value:= '---';
  end
  else
  begin
    Value:= FormatFloat( sMask,
                       DLGastosEntregas.QDetalleGasto.FieldByName('importe_ge').AsFloat /
                       DLGastosEntregas.QDetalleGasto.FieldByName('unidades_linea_ge').AsFloat );
  end;
end;

end.

