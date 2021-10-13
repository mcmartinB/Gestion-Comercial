unit ListEntregasQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, EntregasCB;

type
  TQLListEntregas = class(TQuickRep)
    bndDetalle: TQRBand;
    bndTitulo: TQRBand;
    PageFooterBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    QRSysData1: TQRSysData;
    fecha_llegada_ec: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRSysData2: TQRSysData;
    bndLineas: TQRSubDetail;
    bndCabLineas: TQRBand;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    bndPieLineas: TQRBand;
    QRShape1: TQRShape;
    QRLabel3: TQRLabel;
    lblProducto: TQRLabel;
    lblRango: TQRLabel;
    ChildBand1: TQRChildBand;
    QRDBText23: TQRDBText;
    QRLabel20: TQRLabel;
    QRLabel22: TQRLabel;
    adjudicacion_ec: TQRDBText;
    centro_llegada_ec: TQRDBText;
    codigo_ec: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText28: TQRDBText;
    calibre_el: TQRDBText;
    categoria_el: TQRDBText;
    QRDBText29: TQRDBText;
    QRDBText30: TQRDBText;
    QRDBText31: TQRDBText;
    QRDBText32: TQRDBText;
    QRLabel25: TQRLabel;
    bndCabPacking: TQRBand;
    QRShape4: TQRShape;
    QRLabel29: TQRLabel;
    bndPacking: TQRSubDetail;
    bndPiePacking: TQRBand;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRDBText14: TQRDBText;
    unidad_precio_el: TQRDBText;
    QRLabel30: TQRLabel;
    bndCabResumenSatus: TQRBand;
    QRShape3: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel33: TQRLabel;
    bndResumenSatus: TQRSubDetail;
    bndPieResumenStatus: TQRBand;
    bndCabCalibrePacking: TQRBand;
    QRShape5: TQRShape;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    bndCalibrePacking: TQRSubDetail;
    bndPieCalibrePacking: TQRBand;
    SummaryBand1: TQRBand;
    QRDBText11: TQRDBText;
    calibre: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText36: TQRDBText;
    status: TQRDBText;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    l1_status: TQRLabel;
    l1_cajas: TQRLabel;
    l1_peso_bruto: TQRLabel;
    l1_peso: TQRLabel;
    l2_calibre: TQRLabel;
    l2_cajas: TQRLabel;
    l2_peso_bruto: TQRLabel;
    l2_peso: TQRLabel;
    QRShape6: TQRShape;
    QRLabel41: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    min_Fecha: TQRLabel;
    max_Fecha: TQRLabel;
    QRDBText10: TQRDBText;
    qreDes: TQRDBText;
    qrlDes: TQRLabel;
    bndcSumary: TQRChildBand;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrs1: TQRShape;
    qrl5: TQRLabel;
    qrlpalets: TQRLabel;
    qrlcajas: TQRLabel;
    qrlunidades: TQRLabel;
    qrlkilos: TQRLabel;
    qrx1: TQRExpr;
    qrl6: TQRLabel;
    qrlbl1: TQRLabel;
    qrdbtxtcalibre: TQRDBText;
    qrdbtxtproducto_el: TQRDBText;
    bndProveedor: TQRGroup;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBText20: TQRDBText;
    QRDBText21: TQRDBText;
    QRLabel6: TQRLabel;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    procedure QRDBText9Print(sender: TObject; var Value: String);
    procedure bndPieLineasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText28Print(sender: TObject; var Value: String);
    procedure bndCabPackingBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPiePackingBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure unidad_precio_elPrint(sender: TObject; var Value: String);
    procedure QRDBText8Print(sender: TObject; var Value: String);
    procedure Desproveedor_ecPrint(sender: TObject; var Value: String);
    procedure bndCabResumenSatusBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndCabCalibrePackingBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndResumenSatusBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndCalibrePackingBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lblDes_transporte_ecPrint(sender: TObject;
      var Value: String);
    procedure bndCabLineasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrl5Print(sender: TObject; var Value: String);
    procedure bndcSumaryBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndLineasBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lblEmpresaPrint(sender: TObject; var Value: string);
  private
    rAPalets, rACajas, rAUnidades, rAKilos: Real;
    OldEmpresa: String;
  public
    bPrintDetalle, bPrintNotas: Boolean;
    bPrintPacking, bPrintResumen: Boolean;
    bPrintTotales: Boolean;
  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
procedure ExecuteReport( const APadre: TComponent; const AParametros: REntregasQL; const AVerResumen, AVerBorrados: Boolean );

implementation

{$R *.DFM}

uses UMDEntregas, UDMAuxDB, CReportes, DPreview, UDMConfig, Dialogs;

var
  QLListEntregas: TQLListEntregas;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLListEntregas:= TQLListEntregas.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  UMDEntregas.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLListEntregas <> nil then
        FreeAndNil( QLListEntregas );
    end;
  end;
  UMDEntregas.UnloadModule;
end;

procedure ExecuteReport( const APadre: TComponent; const AParametros: REntregasQL; const AVerResumen, AVerBorrados: Boolean );
var
  i: integer;
begin
  LoadReport( APadre );
  if UMDEntregas.OpenData( APadre, AParametros, AVerResumen, AVerBorrados ) <> 0 then
  begin
    QLListEntregas.DataSet:= MDEntregas.QListEntregasC;
    for i:= 0 to QLListEntregas.ComponentCount - 1 do
    begin
      if QLListEntregas.Components[i] is TQRDBText then
      begin
        TQRDBText( QLListEntregas.Components[i] ).DataSet:= MDEntregas.QListEntregasC;
      end;
    end;
    QLListEntregas.bndLineas.DataSet:= MDEntregas.TListEntregasL;
    for i:= 0 to QLListEntregas.bndLineas.ControlCount - 1 do
    begin
      if QLListEntregas.bndLineas.Controls[i] is TQRDBText then
      begin
        TQRDBText( QLListEntregas.bndLineas.Controls[i] ).DataSet:= MDEntregas.TListEntregasL;
      end;
    end;

    QLListEntregas.bndPacking.DataSet:= MDEntregas.TListPackingList;
    for i:= 0 to QLListEntregas.bndPacking.ControlCount - 1 do
    begin
      if QLListEntregas.bndPacking.Controls[i] is TQRDBText then
      begin
        TQRDBText( QLListEntregas.bndPacking.Controls[i] ).DataSet:= MDEntregas.TListPackingList;
      end;
    end;

    QLListEntregas.bPrintDetalle:= AParametros.bPrintDetalle;
    QLListEntregas.bPrintTotales:= ( AParametros.bPrintDetalle and ( AParametros.sProducto <> '' ) );
    QLListEntregas.bPrintNotas:= AParametros.bPrintObservacion;
    QLListEntregas.bPrintPacking:= AParametros.bPrintPacking;
    QLListEntregas.bPrintResumen:= AVerResumen;
    QLListEntregas.ReportTitle:= 'ENTREGAS PROVEEDOR';
    if AParametros.sProducto <> '' then
    begin
      QLListEntregas.lblProducto.Caption:= AParametros.sProducto + ' ' +
        desProducto( AParametros.sEmpresa, AParametros.sProducto );
    end
    else
    begin
      QLListEntregas.lblProducto.Caption:= '';
    end;
    QLListEntregas.lblRango.Caption:= 'Del ' + DateToStr( AParametros.dFechaDesde ) +
      ' al ' + DateToStr( AParametros.dFechaHasta );

//     PonLogoGrupoBonnysa( QLListEntregas, AParametros.sEmpresa );

     QLListEntregas.rAPalets:= 0;
     QLListEntregas.rACajas:= 0;
     QLListEntregas.rAUnidades:= 0;
     QLListEntregas.rAKilos:= 0;
     Previsualiza( QLListEntregas );
  end
  else
  begin
    ShowMessage('Sin datos para mostrar para los parametros de selección introducidos.');
  end;
  UnloadReport;
end;


procedure TQLListEntregas.bndPieLineasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=bPrintDetalle and not MDEntregas.TListEntregasL.IsEmpty;
end;

procedure TQLListEntregas.QRDBText9Print(sender: TObject; var Value: String);
begin
  Value:= desProveedorAlmacen( DataSet.FieldByName('empresa_ec').AsString,
                               DataSet.FieldByName('proveedor_ec').AsString, Value );
end;

procedure TQLListEntregas.lblDes_transporte_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= desTransporte( DataSet.FieldByName('empresa_ec').AsString, Value );
end;

procedure TQLListEntregas.lblEmpresaPrint(sender: TObject; var Value: string);
begin
  Value := DataSet.FieldByName('empresa_ec').AsString + ' - ' +
           desEmpresa(DataSet.FieldByName('empresa_ec').AsString);
end;

procedure TQLListEntregas.QRDBText28Print(sender: TObject;
  var Value: String);
begin
  Value:= DesVariedad( bndLineas.DataSet.FieldByName('empresa_el').AsString,
               bndLineas.DataSet.FieldByName('proveedor_el').AsString,
               bndLineas.DataSet.FieldByName('producto_el').AsString,
               bndLineas.DataSet.FieldByName('variedad_el').AsString );
end;

procedure TQLListEntregas.bndCabLineasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not MDEntregas.TListEntregasL.IsEmpty and bPrintDetalle;
end;

procedure TQLListEntregas.bndCabPackingBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not MDEntregas.TListPackingList.IsEmpty and bPrintPacking;
end;

procedure TQLListEntregas.bndPiePackingBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not MDEntregas.TListPackingList.IsEmpty and bPrintPacking;
  if PrintBand then
  begin
    min_Fecha.Caption:= 'Inicio: ' + MDEntregas.TListFechasPacking.FieldByName('min_fecha').AsString;
    max_Fecha.Caption:= 'Fin: ' + MDEntregas.TListFechasPacking.FieldByName('max_fecha').AsString;
  end;
end;

procedure TQLListEntregas.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bPrintNotas and (Trim(MDEntregas.QListEntregasC.FieldByName('observaciones_ec').AsString) <> '');
end;

procedure TQLListEntregas.unidad_precio_elPrint(sender: TObject;
  var Value: String);
begin
  if Value = '1' then
    Value:= 'Caja'
  else
  if Value = '2' then
    Value:= 'Und.'
  else
    Value:= 'Kg.'
end;

procedure TQLListEntregas.QRDBText8Print(sender: TObject;
  var Value: String);
begin
  (*if ( DMConfig.EsValenciaBonde or DMConfig.EsTenerifeBonde ) then
  begin
    Value:= '';
  end;
  *)
end;

procedure TQLListEntregas.Desproveedor_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByName('empresa_ec').AsString,
                        DataSet.FieldByName('proveedor_ec').AsString)
end;

procedure TQLListEntregas.bndCabResumenSatusBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not MDEntregas.TListStatusPacking.IsEmpty and bPrintResumen;
end;

procedure TQLListEntregas.bndResumenSatusBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not MDEntregas.TListStatusPacking.IsEmpty and bPrintResumen;
  if PrintBand then
  begin
    l1_status.caption:= MDEntregas.TListStatusPacking.FieldByName('status').AsString;
    l1_cajas.caption:= MDEntregas.TListStatusPacking.FieldByName('cajas').AsString;
    l1_peso_bruto.caption:= MDEntregas.TListStatusPacking.FieldByName('peso_bruto').AsString;
    l1_peso.caption:= MDEntregas.TListStatusPacking.FieldByName('peso').AsString;
  end;
end;      

procedure TQLListEntregas.bndCabCalibrePackingBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not MDEntregas.TListCalibrePacking.IsEmpty and bPrintResumen;
end;

procedure TQLListEntregas.bndCalibrePackingBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not MDEntregas.TListCalibrePacking.IsEmpty and bPrintResumen;
  if PrintBand then
  begin
    l2_calibre.caption:= MDEntregas.TListCalibrePacking.FieldByName('calibre').AsString;
    l2_cajas.caption:= MDEntregas.TListCalibrePacking.FieldByName('cajas').AsString;
    l2_peso_bruto.caption:= MDEntregas.TListCalibrePacking.FieldByName('peso_bruto').AsString;
    l2_peso.caption:= MDEntregas.TListCalibrePacking.FieldByName('peso').AsString;
  end;

  //palets borrados - totales packing
end;

procedure TQLListEntregas.qrl5Print(sender: TObject; var Value: String);
begin
  Value:= DesProducto( bndLineas.DataSet.FieldByName('empresa_el').AsString,
                       bndLineas.DataSet.FieldByName('producto_el').AsString );
end;

procedure TQLListEntregas.bndcSumaryBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bPrintTotales;
  if PrintBand then
  begin
    qrlPalets.Caption:= FormatFloat( '#,##0', rAPalets );
    qrlCajas.Caption:= FormatFloat( '#,##0', rACajas );
    qrlUnidades.Caption:= FormatFloat( '#,##0', rAUnidades );
    qrlKilos.Caption:= FormatFloat( '#,##0.00', rAKilos );
  end;
  rAPalets:= 0;
  rACajas:= 0;
  rAUnidades:= 0;
  rAKilos:= 0;
end;

procedure TQLListEntregas.bndLineasBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not MDEntregas.TListEntregasL.IsEmpty and bPrintDetalle;
  if bPrintTotales then
  begin
    rAPalets:= rAPalets + bndLineas.DataSet.FieldByName('palets_el').AsFloat;
    rACajas:= rACajas + bndLineas.DataSet.FieldByName('cajas_el').AsFloat;
    rAUnidades:= rAUnidades + bndLineas.DataSet.FieldByName('unidades_el').AsFloat;
    rAKilos:= rAKilos + bndLineas.DataSet.FieldByName('kilos_el').AsFloat;
  end;
end;

end.
