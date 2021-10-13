unit MargenCargaRFAlmacenPaletsQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLMargenCargaRFAlmacenPalets = class(TQuickRep)
    BandaDetalle: TQRBand;
    QRBand4: TQRBand;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    qrlblTitulo: TQRLabel;
    SummaryBand1: TQRBand;
    qrdbtxtpal_cliente: TQRDBText;
    qrdbtxtpal_cajas_confeccionados: TQRDBText;
    qrdbtxtpal_kilos_teoricos: TQRDBText;
    qrdbtxtcompra: TQRDBText;
    qrdbtxtpal_importe_compra: TQRDBText;
    qrdbtxtpal_importe_descuento: TQRDBText;
    qrdbtxtpal_importe_gastos: TQRDBText;
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
    qrdbtxtpal_cliente_sal: TQRDBText;
    qrdbtxtpal_cliente_sal2: TQRDBText;
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
    qrlbl20: TQRLabel;
    qrlbl11: TQRLabel;
    qrdbtxtpal_kilos_liquidar: TQRDBText;
    qrdbtxtpal_kilos_liquidar1: TQRDBText;
    qrxpr9: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrlbl23: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl24: TQRLabel;
    qrgrpCategoria: TQRGroup;
    qrbndPieCategoria: TQRBand;
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
    qrbnd1: TQRBand;
    qrsysdt1: TQRSysData;
    qrlbl1: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl21: TQRLabel;
    qrxpr17: TQRExpr;
    qrdbtxtvariedad: TQRDBText;
    qrdbtxtvariedad1: TQRDBText;
    qrdbtxtpal_entrega5: TQRDBText;
    qrdbtxtpal_entrega: TQRDBText;
    qrdbtxtpal_albaran_sal: TQRDBText;
    qrdbtxtpal_status: TQRDBText;
    qrdbtxtpal_categoria: TQRDBText;
    qrlbl25: TQRLabel;
    qrlbl26: TQRLabel;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrdbtxtvariedad2: TQRDBText;
    qrlbl15: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrdbtxtfecha_status: TQRDBText;
    qrlbl17: TQRLabel;
    procedure qrgrpCategoriaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtcompraPrint(sender: TObject;
      var Value: String);
    procedure qrlbl28Print(sender: TObject; var Value: String);
    procedure qrdbtxtpal_entrega5Print(sender: TObject; var Value: String);
    procedure qrdbtxtpal_statusPrint(sender: TObject; var Value: String);
    procedure qrdbtxtvariedad2Print(sender: TObject; var Value: String);
  private

  public

  end;

  procedure PrevisualizarPalets( const AEmpresa: string );

implementation

{$R *.DFM}

uses MargenCargaRFAlmacenDL, UDMAuxDB,  DPreview, CReportes;

(*
  kmtPalet.FieldDefs.Add('sscc_origen', ftString, 20, False);
  kmtPalet.FieldDefs.Add('status', ftString, 3, False);
  kmtPalet.FieldDefs.Add('calidad', ftString, 3, False);
  kmtPalet.FieldDefs.Add('fecha_alta', ftDate, 0, False);

  kmtPalet.FieldDefs.Add('tieneimporte', ftBoolean, 0, False);
  kmtPalet.FieldDefs.Add('importelinea', ftBoolean, 0, False);
  kmtPalet.FieldDefs.Add('importecorrecto', ftBoolean, 0, False);
*)

procedure PrevisualizarPalets( const AEmpresa: string );
var
  QLMargenCargaRFAlmacenPalets: TQLMargenCargaRFAlmacenPalets;
begin
  QLMargenCargaRFAlmacenPalets := TQLMargenCargaRFAlmacenPalets.Create(Application);
  PonLogoGrupoBonnysa(QLMargenCargaRFAlmacenPalets, AEmpresa);
  //sAux:= QLMargenCargaRFAlmacenPalets.DataSet.FieldByName('pal_anyo_semana').AsString;
  QLMargenCargaRFAlmacenPalets.qrlblTitulo.Caption:= 'MARGEN PALETS CARGA' + AEmpresa;
  QLMargenCargaRFAlmacenPalets.ReportTitle:= 'MARGEN_PALETS_CARGA_' + AEmpresa ;
  Preview(QLMargenCargaRFAlmacenPalets);
end;


procedure TQLMargenCargaRFAlmacenPalets.qrgrpCategoriaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  //qrgrpCategoria.Height:= 0;
end;

procedure TQLMargenCargaRFAlmacenPalets.qrdbtxtcompraPrint(
  sender: TObject; var Value: String);
begin
  (*
  kmtPalet.FieldDefs.Add('', ftBoolean, 0, False);
  kmtPalet.FieldDefs.Add('', ftBoolean, 0, False);
  *)
  if not DataSet.FieldByName('tieneimporte').AsBoolean then
  begin
    Value:= 'FALTA';
    qrdbtxtcompra.Font.Style:= qrdbtxtcompra.Font.Style - [fsStrikeOut];
    qrdbtxtcompra.Font.Style:= qrdbtxtcompra.Font.Style + [fsItalic];
  end
  else
  begin
    if not DataSet.FieldByName('importecorrecto').AsBoolean then
    begin
      qrdbtxtcompra.Font.Style:= qrdbtxtcompra.Font.Style + [fsStrikeOut];
      qrdbtxtcompra.Font.Style:= qrdbtxtcompra.Font.Style - [fsItalic];
    end
    else
    begin
      qrdbtxtcompra.Font.Style:= qrdbtxtcompra.Font.Style - [fsStrikeOut];
      qrdbtxtcompra.Font.Style:= qrdbtxtcompra.Font.Style - [fsItalic];
    end;
    if DataSet.FieldByName('importelinea').AsBoolean then
    begin
      Value:= Value + ' L';
    end
    else
    begin
      Value:= Value + ' F';
    end;
  end;
end;

procedure TQLMargenCargaRFAlmacenPalets.qrlbl28Print(sender: TObject;
  var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByName('empresa').Text, DataSet.FieldByName('proveedor').Text ) + ' - ' +
    desProveedorAlmacen( DataSet.FieldByName('empresa').Text, DataSet.FieldByName('proveedor').Text, DataSet.FieldByName('almacen').Text );
end;

procedure TQLMargenCargaRFAlmacenPalets.qrdbtxtpal_entrega5Print(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' / ' +  DataSet.FieldByName('centro').Text;
end;

procedure TQLMargenCargaRFAlmacenPalets.qrdbtxtpal_statusPrint(
  sender: TObject; var Value: String);
begin
  Value:= Value + ' / ' +  DataSet.FieldByName('almacen').Text;
end;

procedure TQLMargenCargaRFAlmacenPalets.qrdbtxtvariedad2Print(
  sender: TObject; var Value: String);
begin
  Value:= desVariedad( DataSet.FieldByName('empresa').Text, DataSet.FieldByName('proveedor').Text,
                       DataSet.FieldByName('producto').Text, DataSet.FieldByName('variedad').Text )
end;

end.

