unit DatosExcelFOBReportPlataforma;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRDatosExcelFOBReportPlataforma = class(TQuickRep)
    BandaDetalle: TQRBand;
    QRBand4: TQRBand;
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
    qrlCentro: TQRLabel;
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
    qrxpr2: TQRExpr;
    qrlbl5: TQRLabel;
    qrxpr3: TQRExpr;
    qrlbl6: TQRLabel;
    qrlbl3: TQRLabel;
    qrxpr4: TQRExpr;
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
    procedure qrx2Print(sender: TObject; var Value: String);
    procedure qrx4Print(sender: TObject; var Value: String);
    procedure qrxprqrx19Print(sender: TObject; var Value: String);
    procedure qrxpr3Print(sender: TObject; var Value: String);
    procedure qrlbl5Print(sender: TObject; var Value: String);
    procedure qrlbl6Print(sender: TObject; var Value: String);
    procedure qrxpr4Print(sender: TObject; var Value: String);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    bDescuentos, bGasto, bCosteMaterial, bCosteGeneral: boolean;

    procedure ConfImportes( const AImportes: boolean );
  end;


implementation

{$R *.DFM}

uses TablaListFobDM, bMath, UDMAuxDB, Dialogs, UDMMaster;


procedure TQRDatosExcelFOBReportPlataforma.ConfImportes( const AImportes: boolean );
begin
  //
  if AImportes then
  begin
    qrxprImporteL.Expression:= '[importe]';
    qrxprImporteL.Mask:= '#,##0.00';
    qrxprImporte.Expression:= 'sum([importe])';
    qrxprImporte.Mask:= '#,##0.00';
    qrxprComisionL.Expression:= '[comision]';
    qrxprComisionL.Mask:= '#,##0.00';
    qrxprComision.Expression:= 'sum([comision])';
    qrxprComision.Mask:= '#,##0.00';
    qrxprGastosL.Expression:= '[gasto_albaran]';
    qrxprGastosL.Mask:= '#,##0.00';
    qrxprGastos.Expression:= 'sum([gasto_albaran])';
    qrxprGastos.Mask:= '#,##0.00';
    qrxprEnvasadoL.Expression:= '[coste_material]+[coste_general]';
    qrxprEnvasadoL.Mask:= '#,##0.00';
    qrxprEnvasado.Expression:= 'sum([coste_material]+[coste_general])';
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
    qrxprEnvasadoL.Expression:= 'IF([peso]=0,0,( [coste_material]+[coste_general] )/[peso])';
    qrxprEnvasadoL.Mask:= '#,##0.0000';
    qrxprEnvasado.Expression:= 'IF(sum([peso])=0,0,( sum([coste_material]+[coste_general]) )/sum([peso]))';
    qrxprEnvasado.Mask:= '#,##0.0000';
  end;
end;

procedure TQRDatosExcelFOBReportPlataforma.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  bFlag: boolean;
begin
  PrintBand:= ( bDescuentos or bGasto or bCosteMaterial or bCosteGeneral ) and not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  lblGastos.Caption:= 'NOTA: Los gastos incluyen -> ';
  bFlag:= false;
  if bGasto then
  begin
    lblGastos.Caption:= lblGastos.Caption + 'gastos de albarán';
    bFlag:= True;
  end;
  if bCosteMaterial then
  begin
    if bFlag then
    begin
      lblGastos.Caption:= lblGastos.Caption + ' + ';
    end;
    lblGastos.Caption:= lblGastos.Caption + 'costes de material/personal envasado';
    bFlag:= True;
  end;
  if bCosteGeneral then
  begin
    if bFlag then
    begin
      lblGastos.Caption:= lblGastos.Caption + ' + ';
    end;
    lblGastos.Caption:= lblGastos.Caption + 'coste general envasado';
  end;
  if bDescuentos then
  begin
    lblGastos.Caption:= lblGastos.Caption + '. Los descuentos/comisiones estan incluidos en el importe bruto.';
  end;
end;

procedure TQRDatosExcelFOBReportPlataforma.qrx8Print(sender: TObject;
  var Value: String);
begin
  Value:= desEnvase( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRDatosExcelFOBReportPlataforma.qrx14Print(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 1, 4 );
end;

procedure TQRDatosExcelFOBReportPlataforma.qrx17Print(sender: TObject;
  var Value: String);
begin
  Value:= Copy( Value, 5, 2 );
end;

procedure TQRDatosExcelFOBReportPlataforma.qrx19Print(sender: TObject;
  var Value: String);
begin
  Value:= desCliente( Value );
end;

procedure TQRDatosExcelFOBReportPlataforma.qrx21Print(sender: TObject;
  var Value: String);
begin
  Value:= PaisCliente( DataSet.FieldByName('empresa').AsString, value );
end;

procedure TQRDatosExcelFOBReportPlataforma.qrx22Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportPlataforma.qrl3Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrl3.AutoSize:= True;
    Value:= 'Cod.Cliente';
  end;
end;

procedure TQRDatosExcelFOBReportPlataforma.qrlbl1Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportPlataforma.qrl4Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrl4.AutoSize:= True;
    Value:= 'Cod.Envase';
  end;
end;

procedure TQRDatosExcelFOBReportPlataforma.qrlbl2Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportPlataforma.qrx2Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrx2.AutoSize:= True;
    Value:= DataSet.FieldByName('empresa').AsString + '-' + Value + ' ' + desCentro( DataSet.FieldByName('empresa').AsString, value );
  end
  else
  begin
    Value:= DataSet.FieldByName('empresa').AsString + '-' + Value;
  end;
end;

procedure TQRDatosExcelFOBReportPlataforma.qrx4Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportPlataforma.qrxprqrx19Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) )then
    Value:= desSuministro( DataSet.FieldByName('empresa').AsString, Value, DataSet.FieldByName('suministro').AsString )
  else
    Value:= '';
end;

procedure TQRDatosExcelFOBReportPlataforma.qrxpr3Print(sender: TObject;
  var Value: String);
begin
  if Exporting then
  begin
    qrxpr3.AutoSize:= True;
    Value:= desComercial( Value);
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRDatosExcelFOBReportPlataforma.qrlbl5Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportPlataforma.qrlbl6Print(sender: TObject;
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

procedure TQRDatosExcelFOBReportPlataforma.qrxpr4Print(sender: TObject;
  var Value: String);
begin
  Value:= '';
end;

procedure TQRDatosExcelFOBReportPlataforma.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRDatosExcelFOBReportPlataforma.QRBand5BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

end.

