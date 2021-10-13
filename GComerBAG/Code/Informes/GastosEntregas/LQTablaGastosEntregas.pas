unit LQTablaGastosEntregas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLTablaGastosEntregas = class(TQuickRep)
    bndCabeceraListado: TQRBand;
    lblTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    DetailBand1: TQRBand;
    entrega_ec: TQRDBText;
    qrdbtxtfecha_llegada_ec: TQRDBText;
    proveedor_ec: TQRDBText;
    lblRangoFechas: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel1: TQRLabel;
    qrlTipoFecha: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel7: TQRLabel;
    qrdbtxtkilos: TQRDBText;
    qrlPiezas: TQRLabel;
    qrdbtxtunidades: TQRDBText;
    qrdbtxtproveedor_ec: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    qrlbl1: TQRLabel;
    qrdbtxtproducto_el: TQRDBText;
    qrdbtxtg055: TQRDBText;
    qrdbtxtg056: TQRDBText;
    qrdbtxtg012: TQRDBText;
    qrdbtxtg057: TQRDBText;
    qrdbtxtg058: TQRDBText;
    qrdbtxtg014: TQRDBText;
    qrdbtxtg015: TQRDBText;
    qrdbtxtg016: TQRDBText;
    qrdbtxtg110: TQRDBText;
    qrdbtxtg060: TQRDBText;
    qrdbtxtg059: TQRDBText;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrxpr1: TQRExpr;
    qrdbtxtg054: TQRLabel;
    qrbndSummaryBand1: TQRBand;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrlbl14: TQRLabel;
    qrshp1: TQRShape;
    qrxpr13: TQRExpr;
    qrdbtxtfecha_llegada_ec1: TQRDBText;
    qrlbl15: TQRLabel;
    qrgrpCAB: TQRGroup;
    qrbndPIE: TQRBand;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrxpr20: TQRExpr;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrlbl16: TQRLabel;
    qrxpr25: TQRExpr;
    qrshp2: TQRShape;
    procedure proveedor_ecPrint(sender: TObject; var Value: String);
    procedure qrdbtxtproducto_elPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl14Print(sender: TObject; var Value: String);
    procedure qrbndSummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrpCABBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPIEBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl16Print(sender: TObject; var Value: String);
  private
    rCosteFruta, rCosteFrutaProducto: Real;
  public
    sEmpresa: string;

  end;

function Imprimir( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                   const AFechaIni, AFechaFin, AFechaCorte: TDateTime; ACorte: Boolean;
                   const AGastoGrabado: Integer; const ATipoCodigo, AFacturaGrabada: Integer; const AFechaFactura: TDateTime ): boolean;

implementation

{$R *.DFM}

uses
  LDGastosEntregas, DPreview, UDMAuxDB, CReportes, UDMConfig;

var
  QLTablaGastosEntregas: TQLTablaGastosEntregas;

function Imprimir( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                   const AFechaIni, AFechaFin, AFechaCorte: TDateTime; ACorte: Boolean;
                   const AGastoGrabado: Integer; const ATipoCodigo, AFacturaGrabada: Integer; const AFechaFactura: TDateTime ): boolean;
begin
  DLGastosEntregas:= TDLGastosEntregas.Create( Application );
  try
    result:= DLGastosEntregas.ObtenerDatosTabla(AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto,
                AFechaIni, AFechaFin, AFechaCorte, ACorte, AGastoGrabado, ATipoCodigo, AFacturaGrabada, AFechaFactura );
    if result then
    begin
      QLTablaGastosEntregas:= TQLTablaGastosEntregas.Create( Application );
      QLTablaGastosEntregas.sEmpresa:= AEmpresa;
      QLTablaGastosEntregas.qrlTipoFecha.Caption:= 'F.Llegada';
      PonLogoGrupoBonnysa( QLTablaGastosEntregas, AEmpresa );
      if AEntrega = '' then
        QLTablaGastosEntregas.lblRangoFechas.Caption:= DateToStr( AFechaIni ) + ' a ' +
                                                      DateToStr( AFechaFin )
      else
        QLTablaGastosEntregas.lblRangoFechas.Caption:= 'ENTREGA ' + AEntrega;

      try
        Preview( QLTablaGastosEntregas );
      except
        FreeAndNil(QLTablaGastosEntregas);
        raise;
      end;
    end;
  finally
    DLGastosEntregas.CerrarQuery;
    FreeAndNil( DLGastosEntregas );
  end;
end;

procedure TQLTablaGastosEntregas.proveedor_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProveedor( DataSet.FieldByName('empresa_ec').AsString, Value );
end;

procedure TQLTablaGastosEntregas.qrdbtxtproducto_elPrint(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.FieldByName('empresa_ec').AsString, Value );
end;

procedure TQLTablaGastosEntregas.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    entrega_ec.AutoSize:= True;
    proveedor_ec.AutoSize:= True;
    qrdbtxtproveedor_ec.AutoSize:= True;
    qrdbtxtfecha_llegada_ec.AutoSize:= True;
    qrdbtxtfecha.AutoSize:= True;
    qrdbtxtproducto_el.AutoSize:= True;
    qrdbtxtunidades.AutoSize:= True;
    qrdbtxtkilos.AutoSize:= True;
    qrdbtxtg054.AutoSize:= True;
    qrdbtxtg055.AutoSize:= True;
    qrdbtxtg056.AutoSize:= True;
    qrdbtxtg012.AutoSize:= True;
    qrdbtxtg057.AutoSize:= True;
    qrdbtxtg058.AutoSize:= True;
    qrdbtxtg014.AutoSize:= True;
    qrdbtxtg015.AutoSize:= True;
    qrdbtxtg059.AutoSize:= True;
    qrdbtxtg060.AutoSize:= True;
    qrdbtxtg110.AutoSize:= True;
    qrdbtxtg016.AutoSize:= True;
    qrxpr1.AutoSize:= True;
  end
  else
  begin
    entrega_ec.AutoSize:= False;
    proveedor_ec.AutoSize:= False;
    qrdbtxtproveedor_ec.AutoSize:= False;
    qrdbtxtfecha_llegada_ec.AutoSize:= False;
    qrdbtxtfecha.AutoSize:= False;
    qrdbtxtproducto_el.AutoSize:= False;
    qrdbtxtunidades.AutoSize:= False;
    qrdbtxtkilos.AutoSize:= False;
    qrdbtxtg054.AutoSize:= False;
    qrdbtxtg055.AutoSize:= False;
    qrdbtxtg056.AutoSize:= False;
    qrdbtxtg012.AutoSize:= False;
    qrdbtxtg057.AutoSize:= False;
    qrdbtxtg058.AutoSize:= False;
    qrdbtxtg014.AutoSize:= False;
    qrdbtxtg015.AutoSize:= False;
    qrdbtxtg059.AutoSize:= False;
    qrdbtxtg060.AutoSize:= False;
    qrdbtxtg110.AutoSize:= False;
    qrdbtxtg016.AutoSize:= False;
    qrxpr1.AutoSize:= False;
  end;
  rCosteFruta:= 0;
  rCosteFrutaProducto:= 0;
end;

procedure TQLTablaGastosEntregas.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  (*
  if DataSet.FieldByName('g010').AsFloat = 0 then
  begin
    if  DataSet.FieldByName('coste_previson').AsFloat = 0 then
    begin
      qrdbtxtg010.Caption:= '';
    end
    else
    begin
      qrdbtxtg010.Caption:= DataSet.FieldByName('coste_previson').AsString;
      rCosteFruta:= rCosteFruta + DataSet.FieldByName('coste_previson').AsFloat;
      rCosteFrutaProducto:= rCosteFrutaProducto + DataSet.FieldByName('coste_previson').AsFloat;
      qrdbtxtg010.Font.Style:= qrdbtxtg010.Font.Style + [fsItalic];
    end;
  end
  else
  *)
  begin
     rCosteFruta:= rCosteFruta + DataSet.FieldByName('g054').AsFloat;
     rCosteFrutaProducto:= rCosteFrutaProducto + DataSet.FieldByName('g054').AsFloat;
     qrdbtxtg054.Caption:= DataSet.FieldByName('g054').AsString;
     qrdbtxtg054.Font.Style:= qrdbtxtg054.Font.Style - [fsItalic];
  end;
end;

procedure TQLTablaGastosEntregas.qrlbl14Print(sender: TObject;
  var Value: String);
begin
  Value:= FloatToStr( rCosteFruta );
end;

procedure TQLTablaGastosEntregas.qrbndSummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLTablaGastosEntregas.qrgrpCABBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //No se imprime
  qrgrpCAB.Height:= 0;
end;

procedure TQLTablaGastosEntregas.qrbndPIEBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLTablaGastosEntregas.qrlbl16Print(sender: TObject;
  var Value: String);
begin
  Value:= FloatToStr( rCosteFrutaProducto );
  rCosteFrutaProducto:= 0;
end;

end.

