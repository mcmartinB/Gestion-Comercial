unit DatosExcelFOBReportEx;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRDatosExcelFOBReportEx = class(TQuickRep)
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
    qrx15: TQRExpr;
    qrl7: TQRLabel;
    qrx17: TQRExpr;
    qrx18: TQRExpr;
    SummaryBand1: TQRBand;
    qrlPsQRLabel5: TQRLabel;
    qrx10: TQRExpr;
    qrxprImporte: TQRExpr;
    qrxprGastos: TQRExpr;
    qrx16: TQRExpr;
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
    qrlbl2: TQRLabel;
    qrlblCortePrecio: TQRLabel;
    qrlblTipoGasto: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl4: TQRLabel;
    qrxprComisionL: TQRExpr;
    qrxprEnvasadoL: TQRExpr;
    qrxprComision: TQRExpr;
    qrxprEnvasado: TQRExpr;
    qrxprqrx19: TQRExpr;
    qrxpr1: TQRExpr;
    qrlbl5: TQRLabel;
    qrxpr2: TQRExpr;
    qrlbl6: TQRLabel;
    qrlbl3: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel1: TQRLabel;
    QRFecha_Albaran: TQRExpr;
    QRLFecha_Albaran: TQRLabel;
    QRLEmpresa: TQRLabel;
    QREmpresa: TQRExpr;
    qUnidadesProducto: TQRExpr;
    QRLabel2: TQRLabel;
    qrlComisionFac: TQRLabel;
    qrComisionFac: TQRExpr;
    QRExpr2: TQRExpr;
    qrlComisionNoFac: TQRLabel;
    qrComisionNoFac: TQRExpr;
    QRExpr4: TQRExpr;
    qrlGastoFac: TQRLabel;
    qrGastoFac: TQRExpr;
    QRExpr6: TQRExpr;
    qrlGastoNoFac: TQRLabel;
    qrGastoNoFac: TQRExpr;
    QRExpr8: TQRExpr;
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
    procedure qrxprqrx19Print(sender: TObject; var Value: String);
    procedure qrxpr2Print(sender: TObject; var Value: String);
    procedure qrlbl5Print(sender: TObject; var Value: String);
    procedure qrlbl6Print(sender: TObject; var Value: String);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private

  public
    bDescuentos, bGasto, bEnvase, bSecciones: boolean;

    procedure ConfImportes( const AImportes: boolean );
  end;

procedure PrevisualizarTablaFOB_EX(
   const AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria, ACalibre: string;
   const ARangoFechaSalida, ADescuentos, AGastos, AEnvasado, ASecciones, AVerImportes, ANoP4H: boolean;
   const AEsHortaliza, EsProductoPropio, ACondicionPrecio: Integer; const APrecio: Real );

implementation

{$R *.DFM}

uses TablaListFobDM, bMath, UDMAuxDB, Dialogs, UDMMaster,CReportes, DPreview;

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

procedure PrevisualizarTablaFOB_EX(
   const AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria, ACalibre: string;
   const ARangoFechaSalida, ADescuentos, AGastos, AEnvasado, ASecciones, AVerImportes, ANoP4H: boolean;
   const AEsHortaliza, EsProductoPropio, ACondicionPrecio: Integer; const APrecio: Real );
var
  QRDatosExcelFOBReport: TQRDatosExcelFOBReportEx;
  sAux: string;
  iCategoria: Integer;
begin
  //ADescuentos:= chkDescuentos.Checked or chkComisiones.Checked;
  //AGastos:= chkGastosNoFac.Checked or chkGastosFac.Checked;
  //AEnvasado:= chkEnvase.Checked;
  //ASecciones:= chkSecciones.Checked;
  QRDatosExcelFOBReport := TQRDatosExcelFOBReportEx.Create(Application);
  PonLogoGrupoBonnysa(QRDatosExcelFOBReport, AEmpresa );
  QRDatosExcelFOBReport.bDescuentos:= ADescuentos;
  QRDatosExcelFOBReport.bGasto:= AGastos;
  QRDatosExcelFOBReport.bEnvase:= AEnvasado;
  QRDatosExcelFOBReport.bSecciones:= ASecciones;

  if ACentroOrigen = '' then
    QRDatosExcelFOBReport.qrlOrigen.Caption := 'ORIGEN TODOS LOS CENTROS'
  else
    QRDatosExcelFOBReport.qrlOrigen.Caption := 'ORIGEN ' + DesCentro( AEmpresa, ACentroOrigen );

  if ACentroSalida = '' then
    QRDatosExcelFOBReport.qrlDestino.Caption := 'SALIDA TODOS LOS CENTROS'
  else
    QRDatosExcelFOBReport.qrlDestino.Caption := 'DESTINO ' + DesCentro( AEmpresa, ACentroSalida );

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


procedure TQRDatosExcelFOBReportEx.BandaDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) then
  begin
    QREmpresa.Enabled := true;
    QRFecha_Albaran.Enabled := true;
    qUnidadesProducto.Enabled := true;
    qrComisionFac.Enabled := True;
    qrComisionNoFac.Enabled := true;
    qrGastoFac.Enabled := true;
    qrGastoNoFac.Enabled := true;
    qrx18.Width := 200;
  end
  else
  begin
    QREmpresa.Enabled := false;
    QRFecha_Albaran.Enabled := False;
    qUnidadesProducto.Enabled := False;
    qrComisionFac.Enabled := False;
    qrComisionNoFac.Enabled := False;
    qrGastoFac.Enabled := False;
    qrGastoNoFac.Enabled := False;
    qrx18.Width := 85;
  end;
end;

procedure TQRDatosExcelFOBReportEx.ConfImportes( const AImportes: boolean );
begin
  //
  if AImportes then
  begin
    qrxprImporteL.Expression:= '[importe]';
    qrxprImporteL.Mask:= '#,##0.00';
    qrxprImporte.Expression:= 'sum([importe])';
    qrxprImporte.Mask:= '#,##0.00';
    qrxprComisionL.Expression:= '[comision]';
    qrxprComisionL.Mask:= '#,##0.000';
    qrxprComision.Expression:= 'sum([comision])';
    qrxprComision.Mask:= '#,##0.000';
    qrxprGastosL.Expression:= '[gasto_albaran]';
    qrxprGastosL.Mask:= '#,##0.00';
    qrxprGastos.Expression:= 'sum([gasto_albaran])';
    qrxprGastos.Mask:= '#,##0.00';
    qrxprEnvasadoL.Expression:= '[coste_envase]+[coste_seccion]';
    qrxprEnvasadoL.Mask:= '#,##0.00';
    qrxprEnvasado.Expression:= 'sum([coste_envase]+[coste_seccion])';
    qrxprEnvasado.Mask:= '#,##0.00';
  end
  else
  begin
    qrxprImporteL.Expression:= 'IF([peso]=0,0,( [importe] )/[peso])';
    qrxprImporteL.Mask:= '#,##0.000';
    qrxprImporte.Expression:= 'IF(sum([peso])=0,0,( sum([importe]) )/sum([peso]))';
    qrxprImporte.Mask:= '#,##0.000';
    qrxprComisionL.Expression:= 'IF([peso]=0,0,( [comision] )/[peso])';
    qrxprComisionL.Mask:= '#,##0.0000';
    qrxprComision.Expression:= 'IF(sum([peso])=0,0,( sum([comision]) )/sum([peso]))';
    qrxprComision.Mask:= '#,##0.0000';
    qrxprGastosL.Expression:= 'IF([peso]=0,0,( [gasto_albaran] )/[peso])';
    qrxprGastosL.Mask:= '#,##0.0000';
    qrxprGastos.Expression:= 'IF(sum([peso])=0,0,( sum([gasto_albaran]) )/sum([peso]))';
    qrxprGastos.Mask:= '#,##0.0000';
    qrxprEnvasadoL.Expression:= 'IF([peso]=0,0,( [coste_envase]+[coste_seccion] )/[peso])';
    qrxprEnvasadoL.Mask:= '#,##0.0000';
    qrxprEnvasado.Expression:= 'IF(sum([peso])=0,0,( sum([coste_envase]+[coste_seccion]) )/sum([peso]))';
    qrxprEnvasado.Mask:= '#,##0.0000';
  end;
end;

procedure TQRDatosExcelFOBReportEx.PageFooterBand1BeforePrint(
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

procedure TQRDatosExcelFOBReportEx.qrx8Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvase( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRDatosExcelFOBReportEx.qrx14Print(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 1, 4 );
end;

procedure TQRDatosExcelFOBReportEx.qrx17Print(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 5, 2 );
end;

procedure TQRDatosExcelFOBReportEx.qrx19Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( Value );
end;

procedure TQRDatosExcelFOBReportEx.qrx21Print(sender: TObject;
  var Value: String);
begin
  Value:= PaisCliente( DataSet.FieldByName('empresa').AsString, value );
end;

procedure TQRDatosExcelFOBReportEx.qrx22Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportEx.qrl3Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrl3.AutoSize:= True;
    Value:= 'Cod.Cliente';
  end;
end;

procedure TQRDatosExcelFOBReportEx.qrlbl1Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportEx.qrl4Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrl4.AutoSize:= True;
    Value:= 'Cod.Envase';
  end;
end;

procedure TQRDatosExcelFOBReportEx.qrlbl2Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportEx.qrx1Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportEx.qrx2Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportEx.qrx4Print(sender: TObject;
  var Value: String);
var
  sAux, sAux2: string;
begin
  if Exporting then
  begin
    qrx4.AutoSize:= True;
    sAux:= Value + ' - ' + desProducto( DataSet.FieldByName('empresa').AsString , Value );
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

procedure TQRDatosExcelFOBReportEx.qrxprqrx19Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) )then
    Value:= desCliente( Value )
  else
    Value:= '';
end;

procedure TQRDatosExcelFOBReportEx.qrxpr2Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportEx.qrlbl5Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportEx.qrlbl6Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrlbl6.AutoSize:= True;
    Value:= 'Nom.Comercial';
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRDatosExcelFOBReportEx.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRDatosExcelFOBReportEx.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) then
  begin
    QRLEmpresa.Enabled := true;
    QRLabel2.Enabled := true;
    QRLFecha_Albaran.Enabled := true;
    qrlComisionFac.Enabled := True;
    qrlComisionNoFac.Enabled := true;
    qrlGastoFac.Enabled := true;
    qrlGastoNoFac.Enabled := true;
  end
  else
  begin
    QRLEmpresa.Enabled := false;
    QRLabel2.Enabled := false;
    QRLFecha_Albaran.Enabled := False;
    qrlComisionFac.Enabled := False;
    qrlComisionNoFac.Enabled := False;
    qrlGastoFac.Enabled := False;
    qrlGastoNoFac.Enabled := False;
  end;
end;

procedure TQRDatosExcelFOBReportEx.QRBand5BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.

