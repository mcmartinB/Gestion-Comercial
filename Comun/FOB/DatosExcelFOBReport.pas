unit DatosExcelFOBReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRDatosExcelFOBReport = class(TQuickRep)
    BandaDetalle: TQRBand;
    QRBand4: TQRBand;
    PsQRLabel12: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    PsQRLabel15: TQRLabel;
    PsQRLabel16: TQRLabel;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    qrlblPeriodo: TQRLabel;
    qrlblTitulo: TQRLabel;
    LCategoria: TQRLabel;
    qrlLProducto: TQRLabel;
    qrlOrigen: TQRLabel;
    qrlDestino: TQRLabel;
    qrx1: TQRExpr;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrx2: TQRExpr;
    qrx3: TQRExpr;
    qrx4: TQRExpr;
    qrxprGastosL: TQRExpr;
    qrxprImporteL: TQRExpr;
    qrx7: TQRExpr;
    qrx8: TQRExpr;
    qrx9: TQRExpr;
    qrl5: TQRLabel;
    qrx14: TQRExpr;
    qrl6: TQRLabel;
    qrxprNeto: TQRExpr;
    qrl7: TQRLabel;
    qrx17: TQRExpr;
    qrx18: TQRExpr;
    qrx19: TQRExpr;
    SummaryBand1: TQRBand;
    qrlPsQRLabel5: TQRLabel;
    qrx10: TQRExpr;
    qrxprImporte: TQRExpr;
    qrxprGastos: TQRExpr;
    qrxprSumNeto: TQRExpr;
    qrx13: TQRExpr;
    lblGastos: TQRLabel;
    qrx20: TQRExpr;
    qrx21: TQRExpr;
    qrl8: TQRLabel;
    qrl9: TQRLabel;
    qrlCalibre: TQRLabel;
    qrxCalibre: TQRExpr;
    qrl10: TQRLabel;
    qrx22: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlblCortePrecio: TQRLabel;
    qrlblTipoGasto: TQRLabel;
    qrxpr1: TQRExpr;
    qrlbl5: TQRLabel;
    qrxpr2: TQRExpr;
    qrlbl4: TQRLabel;
    qrlbl3: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel1: TQRLabel;
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrx8Print(sender: TObject; var Value: String);
    procedure qrx14Print(sender: TObject; var Value: String);
    procedure qrx17Print(sender: TObject; var Value: String);
    procedure qrx19Print(sender: TObject; var Value: String);
    procedure qrx21Print(sender: TObject; var Value: String);
    procedure qrx22Print(sender: TObject; var Value: String);
    procedure qrlbl1Print(sender: TObject; var Value: String);
    procedure qrl3Print(sender: TObject; var Value: String);
    procedure qrl4Print(sender: TObject; var Value: String);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure qrx1Print(sender: TObject; var Value: String);
    procedure qrx2Print(sender: TObject; var Value: String);
    procedure qrx4Print(sender: TObject; var Value: String);
    procedure qrxpr2Print(sender: TObject; var Value: String);
    procedure qrlbl5Print(sender: TObject; var Value: String);
    procedure qrlbl4Print(sender: TObject; var Value: String);
    procedure QRBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    bDescuentos, bGasto, bEnvase, bSecciones: boolean;

    procedure ConfImportes( const AImportes: boolean );
  end;

  procedure PrevisualizarTablaFOB(
   const AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria, ACalibre: string;
   const ARangoFechaSalida, ADescuentos, AGastos, AEnvasado, ASecciones, AVerImportes, ANoP4H: boolean;
   const AEsHortaliza, EsProductoPropio, ACondicionPrecio: Integer; const APrecio: Real );


implementation

{$R *.DFM}

uses TablaListFobDM, bMath, UDMAuxDB, Dialogs, UDMMaster, CReportes, DPreview;

function DesPrecio( const ACondicion: Integer ): string;
begin
  case  ACondicion of
   1: Result:= '=';
   2: Result:= '<>';
   3: Result:= '>=';
   4: Result:= '<=';
   5: Result:= '>';
   6: Result:= '<';
   else Result:= '';
  end;
end;

procedure PrevisualizarTablaFOB(
   const AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria, ACalibre: string;
   const ARangoFechaSalida, ADescuentos, AGastos, AEnvasado, ASecciones, AVerImportes, ANoP4H: boolean;
   const AEsHortaliza, EsProductoPropio, ACondicionPrecio: Integer; const APrecio: Real );
var
  QRDatosExcelFOBReport: TQRDatosExcelFOBReport;
  sAux: string;
  iCategoria: Integer;
begin
  QRDatosExcelFOBReport := TQRDatosExcelFOBReport.Create(Application);
  PonLogoGrupoBonnysa(QRDatosExcelFOBReport, AEmpresa);
  QRDatosExcelFOBReport.bDescuentos:= True;
  QRDatosExcelFOBReport.bGasto:= True;
  QRDatosExcelFOBReport.bEnvase:= True;
  QRDatosExcelFOBReport.bSecciones:= True;

  if ACentroOrigen = '' then
    QRDatosExcelFOBReport.qrlOrigen.Caption := 'ORIGEN TODOS LOS CENTROS'
  else
    QRDatosExcelFOBReport.qrlOrigen.Caption := 'ORIGEN ' + desCentro( AEmpresa, ACentroOrigen );

  if ACentroSalida = '' then
    QRDatosExcelFOBReport.qrlDestino.Caption := 'SALIDA TODOS LOS CENTROS'
  else
    QRDatosExcelFOBReport.qrlDestino.Caption := 'DESTINO ' + desCentro( AEmpresa, ACentroSalida );

  if AProducto = '' then
  begin
    if AEsHortaliza = 1 then
    begin
      QRDatosExcelFOBReport.qrlLProducto.Caption := 'TODOS LOS PRODUCTOS (TOMATE)';
    end
    else
    if AEsHortaliza = 2 then
    begin
      QRDatosExcelFOBReport.qrlLProducto.Caption := 'TODOS LOS PRODUCTOS (HORTALIZAS)';
    end
    else
    if AEsHortaliza = 3 then
    begin
      QRDatosExcelFOBReport.qrlLProducto.Caption := 'TODOS LOS PRODUCTOS (FRUTAS)';
    end
    else
    begin
      QRDatosExcelFOBReport.qrlLProducto.Caption := 'TODOS LOS PRODUCTOS';
    end;
  end
  else
    QRDatosExcelFOBReport.qrlLProducto.Caption := AProducto + ' ' + desProducto(AEmpresa, AProducto);

  if ARangoFechaSalida then
  begin
    //QRDatosExcelFOBReport.qrlblTitulo.Caption := 'LISTADO FOB - SALIDAS';
    QRDatosExcelFOBReport.qrlblPeriodo.Caption := 'SALIDAS DEL ' + AFechaDesde + ' AL ' + AFechaHasta;
  end
  else
  begin
    //QRDatosExcelFOBReport.qrlblTitulo.Caption := 'LISTADO FOB - FACTURAS';
    QRDatosExcelFOBReport.qrlblPeriodo.Caption := 'FACTURAS DEL ' + AFechaDesde + ' AL ' + AFechaHasta;
  end;

  if EsProductoPropio = 1 then
  begin
    QRDatosExcelFOBReport.qrlblTitulo.Caption := 'LISTADO FOB - PRODUCTO PROPIO';
  end
  else
  if EsProductoPropio = 2 then
  begin
    QRDatosExcelFOBReport.qrlblTitulo.Caption := 'LISTADO FOB - COMPRAS A TERCEROS';
  end
  else
  begin
    if ARangoFechaSalida then
    begin
      QRDatosExcelFOBReport.qrlblTitulo.Caption := 'LISTADO FOB - SALIDAS';
    end
    else
    begin
      QRDatosExcelFOBReport.qrlblTitulo.Caption := 'LISTADO FOB - FACTURAS';
    end;
  end;

  QRDatosExcelFOBReport.qrlblTipoGasto.Caption:= 'Gastos';
  (*
  if iTipoGasto = 1 then
  begin
    QRDatosExcelFOBReport.qrlblTipoGasto.Caption:= 'Gastos Fact.';
  end
  else
  if iTipoGasto = 2 then
  begin
    QRDatosExcelFOBReport.qrlblTipoGasto.Caption:= 'Gastos No Fact.';
  end
  else
  begin
    QRDatosExcelFOBReport.qrlblTipoGasto.Caption:= '';
  end;
  *)

  if ACondicionPrecio > 0 then
  begin
    QRDatosExcelFOBReport.qrlblCortePrecio.Caption:= DesPrecio( ACondicionPrecio ) + ' ' + FloatToStr( APrecio ) + '€/kg';
  end
  else
  begin
    QRDatosExcelFOBReport.qrlblCortePrecio.Caption:= '';
  end;

  sAux:= '';
  if ACategoria <> '' then
  begin
    if TryStrToInt( ACategoria, iCategoria) then
    begin
      case iCategoria of
        1: sAux := 'CATEGORÍA: PRIMERA';
        2: sAux := 'CATEGORÍA: SEGUNDA';
        3: sAux := 'CATEGORÍA: TERCERA';
        else sAux := 'CATEGORÍA: ' + Trim(ACategoria);
      end;
    end
    else
    begin
      sAux := 'CATEGORÍA: ' + Trim(ACategoria);
    end;
  end
  else
  begin
    sAux := 'CATEGORÍA: TODAS';
  end;
  if ACalibre <> '' then
  begin
    sAux := sAux + ' // CALIBRE: ' + Trim( ACalibre);
  end;
  QRDatosExcelFOBReport.LCategoria.Caption:= sAux;

  QRDatosExcelFOBReport.ConfImportes( AVerImportes );

  Preview(QRDatosExcelFOBReport);
end;


procedure TQRDatosExcelFOBReport.ConfImportes( const AImportes: boolean );
begin
  if AImportes then
  begin
    qrxprImporteL.Expression:= '[importe]-[comision]';
    qrxprImporteL.Mask:= '#,##0.00';
    qrxprImporte.Expression:= 'sum([importe]-[comision])';
    qrxprImporte.Mask:= '#,##0.00';
    qrxprGastosL.Expression:= '[gasto_albaran]+[coste_envase]+[coste_seccion]';
    qrxprGastosL.Mask:= '#,##0.00';
    qrxprGastos.Expression:= 'sum([gasto_albaran]+[coste_envase]+[coste_seccion])';
    qrxprGastos.Mask:= '#,##0.00';
  end
  else
  begin
    qrxprImporteL.Expression:= 'IF([peso]=0,0,([importe]-[comision] )/[peso])';
    qrxprImporteL.Mask:= '#,##0.000';
    qrxprImporte.Expression:= 'IF(sum([peso])=0,0,( sum([importe]-[comision]) )/sum([peso]))';
    qrxprImporte.Mask:= '#,##0.000';
    qrxprGastosL.Expression:= 'IF([peso]=0,0,( [gasto_albaran]+[coste_envase]+[coste_seccion] )/[peso])';
    qrxprGastosL.Mask:= '#,##0.0000';
    qrxprGastos.Expression:= 'IF(sum([peso])=0,0,( sum([gasto_albaran]+[coste_envase]+[coste_seccion]) )/sum([peso]))';
    qrxprGastos.Mask:= '#,##0.0000';
  end;
end;

procedure TQRDatosExcelFOBReport.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  bFlag: boolean;
begin
  PrintBand:= ( bDescuentos or bGasto or bSecciones or bEnvase ) and not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  lblGastos.Caption:= 'NOTA: Los gastos incluyen -> ';
  bFlag:= false;
  if bGasto then
  begin
    lblGastos.Caption:= lblGastos.Caption + 'gastos de albarán';
    bFlag:= True;
  end;
  if bEnvase then
  begin
    if bFlag then
    begin
      lblGastos.Caption:= lblGastos.Caption + ' + ';
    end;
    lblGastos.Caption:= lblGastos.Caption + 'costes de envasado';
    bFlag:= True;
  end;
  if bSecciones then
  begin
    if bFlag then
    begin
      lblGastos.Caption:= lblGastos.Caption + ' + ';
    end;
    lblGastos.Caption:= lblGastos.Caption + 'coste secciones';
  end;
  if bDescuentos then
  begin
    lblGastos.Caption:= lblGastos.Caption + '. Los descuentos/comisiones estan incluidos en el importe bruto.';
  end;
end;

procedure TQRDatosExcelFOBReport.qrx8Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvase( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRDatosExcelFOBReport.qrx14Print(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 1, 4 );
end;

procedure TQRDatosExcelFOBReport.qrx17Print(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 5, 2 );
end;

procedure TQRDatosExcelFOBReport.qrx19Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( Value );
end;

procedure TQRDatosExcelFOBReport.qrx21Print(sender: TObject;
  var Value: String);
begin
  Value:= PaisCliente( DataSet.FieldByName('empresa').AsString, value );
end;

procedure TQRDatosExcelFOBReport.qrx22Print(sender: TObject;
  var Value: String);
begin
  if Value = '1' then
    Value:= 'Fac'
  else
  if Value = '2' then
    Value:= 'Abo'
  else
    Value:= 'No';
end;

procedure TQRDatosExcelFOBReport.qrl3Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrl3.AutoSize:= True;
    Value:= 'Cod.Cliente';
  end;
end;

procedure TQRDatosExcelFOBReport.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    Value:= 'Cliente';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRDatosExcelFOBReport.qrl4Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrl4.AutoSize:= True;
    Value:= 'Cod.Envase';
  end;
end;

procedure TQRDatosExcelFOBReport.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    Value:= 'Envase';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRDatosExcelFOBReport.qrx1Print(sender: TObject;
  var Value: String);
begin
  qrx1.AutoSize:= True;
  if Exporting then
  begin
    if DataSet.FieldByName('empresa').AsString = '050' then
    begin
      if Value = '1' then
      begin
        Value:= 'PENINSULA';
      end
      else
      if Value = '6' then
      begin
        Value:= 'TENERIFE';
      end
      else
      begin
        Value:= desCentro( DataSet.FieldByName('empresa').AsString, value );
      end;
    end;
  end;
end;

procedure TQRDatosExcelFOBReport.qrx2Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrx2.AutoSize:= True;
    if DataSet.FieldByName('empresa').AsString = '050' then
    begin
      if Value = '1' then
      begin
        Value:= 'PENINSULA';
      end
      else
      if Value = '6' then
      begin
        Value:= 'TENERIFE';
      end
      else
      begin
        Value:= desCentro( DataSet.FieldByName('empresa').AsString, value );
      end;
    end;
  end;
end;

procedure TQRDatosExcelFOBReport.qrx4Print(sender: TObject;
  var Value: String);
var
  sAux, sAux2: string;
begin
  if Exporting then
  begin
    qrx4.AutoSize:= True;
    sAux:= desProducto( DataSet.FieldByName('empresa').AsString , Value );
    if DataSet.FieldByName('empresa').AsString = '050' then
    begin
      sAux2:= Trim( StringReplace( sAux, 'TOMATE', '', []));
      if sAux2 <> '' then
      begin
        sAux:= sAux2;
      end;
    end;
    Value:= sAux;
  end;
end;

procedure TQRDatosExcelFOBReport.qrxpr2Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrxpr2.AutoSize:= True;
    Value:= desComercial( Value);
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRDatosExcelFOBReport.qrlbl5Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrlbl5.AutoSize:= True;
    Value:= 'Cod.Comercial';
  end
  else
  begin
    Value:= 'Com';
  end;
end;

procedure TQRDatosExcelFOBReport.qrlbl4Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrlbl4.AutoSize:= True;
    Value:= 'Nom.Comercial';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRDatosExcelFOBReport.QRBand5BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRDatosExcelFOBReport.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.

