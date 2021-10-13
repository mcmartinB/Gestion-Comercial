unit LiquidaValorarPaletsQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLLiquidaValorarPalets = class(TQuickRep)
    BandaDetalle: TQRBand;
    QRBand4: TQRBand;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    qrlblTitulo: TQRLabel;
    SummaryBand1: TQRBand;
    qrdbtxtpal_categoria: TQRDBText;
    qrdbtxtpal_cliente: TQRDBText;
    qrdbtxtpal_status: TQRDBText;
    qrdbtxtpal_cajas_confeccionados: TQRDBText;
    qrdbtxtpal_kilos_teoricos: TQRDBText;
    qrdbtxtpal_importe_neto: TQRDBText;
    qrdbtxtpal_importe_compra: TQRDBText;
    qrdbtxtpal_importe_descuento: TQRDBText;
    qrdbtxtpal_importe_gastos: TQRDBText;
    qrdbtxtpal_importe_material: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrlbl3: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl17: TQRLabel;
    qrdbtxtpal_cliente_sal: TQRDBText;
    qrdbtxtpal_cliente_sal2: TQRDBText;
    qrdbtxtpal_entrega: TQRDBText;
    qrlbl18: TQRLabel;
    qrdbtxtpal_envase_sal: TQRDBText;
    qrlbl10: TQRLabel;
    qrgrpEntrega: TQRGroup;
    qrbndPieEntrega: TQRBand;
    qrxpr8: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrdbtxtpal_entrega1: TQRDBText;
    qrdbtxtpal_entrega2: TQRDBText;
    qrdbtxtpal_entrega3: TQRDBText;
    qrdbtxtpal_entrega4: TQRDBText;
    qrdbtxtpal_albaran_sal: TQRDBText;
    qrxpr17: TQRExpr;
    qrlbl20: TQRLabel;
    qrlbl11: TQRLabel;
    qrdbtxtpal_kilos_liquidar: TQRDBText;
    qrdbtxtpal_kilos_liquidar1: TQRDBText;
    qrxpr9: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrlbl21: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl24: TQRLabel;
    qrgrpCategoria: TQRGroup;
    qrbndPieCategoria: TQRBand;
    qrxpr20: TQRExpr;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrxpr25: TQRExpr;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrxpr29: TQRExpr;
    qrshpLinCategoria: TQRShape;
    qrdbtxtpal_proveedor1: TQRDBText;
    qrdbtxtpal_categoria1: TQRDBText;
    qrxpr30: TQRExpr;
    qrlbl25: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrbnd1: TQRBand;
    qrsysdt1: TQRSysData;
    qrlbl1: TQRLabel;
    qrdbtxtpal_entrega5: TQRDBText;
    procedure qrdbtxtpal_albaran_salPrint(sender: TObject;
      var Value: String);
    procedure qrdbtxtpal_proveedorPrint(sender: TObject;
      var Value: String);
    procedure qrdbtxtpal_proveedor1Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtpal_categoria1Print(sender: TObject;
      var Value: String);
    procedure qrgrpCategoriaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtpal_entrega5Print(sender: TObject; var Value: String);
    procedure NumPalets(sender: TObject; var Value: String);
  private
     procedure VerPrecios( const APrecios: boolean );
  public

  end;

  procedure PrevisualizarPalets( const AEmpresa: string; const APrecios: boolean );

implementation

{$R *.DFM}

uses LiquidaEntregaDL, UDMAuxDB,  DPreview, CReportes;

(*
  kmtPalet.FieldDefs.Add('pal_anyo_semana', ftString, 6, False);
  kmtPalet.FieldDefs.Add('pal_empresa', ftString, 3, False);
  kmtPalet.FieldDefs.Add('pal_proveedor', ftString, 3, False);
  kmtPalet.FieldDefs.Add('pal_entrega', ftString, 12, False);
  kmtPalet.FieldDefs.Add('pal_sscc_final', ftString, 20, False);
  kmtPalet.FieldDefs.Add('pal_categoria', ftString, 3, False);
  kmtPalet.FieldDefs.Add('pal_sscc_origen', ftString, 20, False);
  kmtPalet.FieldDefs.Add('pal_status', ftString, 1, False);
  kmtPalet.FieldDefs.Add('pal_valorado', ftInteger, 0, False);

  kmtPalet.FieldDefs.Add('pal_cajas_confeccionados', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_kilos_confeccionados', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_kilos_comerciales', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_kilos_destrio', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_kilos_placero', ftFloat, 0, False);

  kmtPalet.FieldDefs.Add('pal_importe_neto', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_descuento', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_gastos', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_material', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_personal', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_general', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_compra', ftFloat, 0, False);
  kmtPalet.FieldDefs.Add('pal_importe_fruta', ftFloat, 0, False);
*)

procedure PrevisualizarPalets( const AEmpresa: string; const APrecios: boolean );
var
  QLLiquidaValorarPalets: TQLLiquidaValorarPalets;
  sAux: string;
begin
  QLLiquidaValorarPalets := TQLLiquidaValorarPalets.Create(Application);
  PonLogoGrupoBonnysa(QLLiquidaValorarPalets, AEmpresa);
  QLLiquidaValorarPalets.VerPrecios( APrecios );
  sAux:= QLLiquidaValorarPalets.DataSet.FieldByName('pal_anyo_semana').AsString;
  QLLiquidaValorarPalets.qrlblTitulo.Caption:= 'VALORAR PALETS PLATANO ' + AEmpresa  + ' - SEMANA ' + sAux;
  QLLiquidaValorarPalets.ReportTitle:= 'VALORAR_PALETS_PLATANO_' + AEmpresa  + '_SEMANA_' + sAux;
  Preview(QLLiquidaValorarPalets);
end;

procedure TQLLiquidaValorarPalets.VerPrecios( const APrecios: boolean );
begin
  if not APrecios then
  begin
    qrdbtxtpal_importe_neto.DataField:= 'pal_importe_neto';
    qrdbtxtpal_importe_descuento.DataField:= 'pal_importe_descuento';
    qrdbtxtpal_importe_gastos.DataField:= 'pal_importe_gastos';
    qrdbtxtpal_importe_compra.DataField:= 'pal_importe_compra';
    qrdbtxtpal_importe_material.DataField:= 'pal_importe_envasado';
    //qrdbtxtpal_importe_general.DataField:= 'pal_importe_liquidar';
  end
  else
  begin
    qrdbtxtpal_importe_neto.DataField:= 'pal_precio_neto';
    qrdbtxtpal_importe_descuento.DataField:= 'pal_precio_descuento';
    qrdbtxtpal_importe_gastos.DataField:= 'pal_precio_gastos';
    qrdbtxtpal_importe_compra.DataField:= 'pal_precio_compra';
    qrdbtxtpal_importe_material.DataField:= 'pal_precio_envasado';
    //qrdbtxtpal_importe_general.DataField:= 'pal_precio_liquidar';
  end;
end;

procedure TQLLiquidaValorarPalets.qrdbtxtpal_albaran_salPrint(
  sender: TObject; var Value: String);
begin
  Value:= '-> ' + Copy( Value, 12, 8 );
  (*
  if Value = '0' then
    Value:= 'Resto'
  else
    Value:= '';
  *)
end;

procedure TQLLiquidaValorarPalets.qrgrpCategoriaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrgrpCategoria.Height:= 0;
end;

procedure TQLLiquidaValorarPalets.qrdbtxtpal_proveedorPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + '/' + DataSet.FieldByName('pal_almacen').AsString;
end;

procedure TQLLiquidaValorarPalets.qrdbtxtpal_proveedor1Print(
  sender: TObject; var Value: String);
begin
  Value:= DataSet.FieldByName('pal_empresa').AsString + '/' + Value + '/' + DataSet.FieldByName('pal_almacen').AsString + ' ' +
          desProveedorAlmacen( DataSet.FieldByName('pal_empresa').AsString, Value, DataSet.FieldByName('pal_almacen').AsString );
end;

procedure TQLLiquidaValorarPalets.qrdbtxtpal_categoria1Print(
  sender: TObject; var Value: String);
begin
  Value:= 'Categoría ' + Value
end;


procedure TQLLiquidaValorarPalets.qrdbtxtpal_entrega5Print(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 8, 5 );
end;

procedure TQLLiquidaValorarPalets.NumPalets(sender: TObject;
  var Value: String);
begin
  Value:= 'Palets ' + Value;
end;

end.

