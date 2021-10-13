unit LVentasLineaProductoClienteReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLVentasLineaProductoClienteReport = class(TQuickRep)
    BandaDetalle: TQRBand;
    QRBand4: TQRBand;
    qrlbluno: TQRLabel;
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
    qrx2: TQRExpr;
    qrx3: TQRExpr;
    qrxprGastosL: TQRExpr;
    qrxprImporteL: TQRExpr;
    qrx7: TQRExpr;
    qrx9: TQRExpr;
    qrl6: TQRLabel;
    qrxprNeto: TQRExpr;
    lblGastos: TQRLabel;
    qrlbltres: TQRLabel;
    qrlbldos: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrxpr8: TQRExpr;
    qrlbl3: TQRLabel;
    qrxprpk31: TQRExpr;
    qrxprpk32: TQRExpr;
    qrxprpk33: TQRExpr;
    qrxprpk34: TQRExpr;
    qrxprpk35: TQRExpr;
    qrxprpk36: TQRExpr;
    qrlblpk21: TQRLabel;
    qrlblpk22: TQRLabel;
    qrlblpk23: TQRLabel;
    qrlblpk24: TQRLabel;
    qrlblpk25: TQRLabel;
    qrlblpk26: TQRLabel;
    qrxprc1: TQRExpr;
    qrxprc2: TQRExpr;
    qrxprc3: TQRExpr;
    qrgrp1: TQRGroup;
    qrgrp2: TQRGroup;
    qrbndPie1: TQRBand;
    qrbndPie2: TQRBand;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrxpr25: TQRExpr;
    qrshp2: TQRShape;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrxpr29: TQRExpr;
    qrxpr30: TQRExpr;
    qrxpr31: TQRExpr;
    qrxpr32: TQRExpr;
    qrxpr33: TQRExpr;
    qrxpr34: TQRExpr;
    qrxpr35: TQRExpr;
    qrshp3: TQRShape;
    qrxpr42: TQRExpr;
    qrxpr43: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr51: TQRExpr;
    qrxpr52: TQRExpr;
    qrxpr53: TQRExpr;
    qrxpr54: TQRExpr;
    qrxpr55: TQRExpr;
    qrxpr56: TQRExpr;
    qrxpr61: TQRExpr;
    qrxpr62: TQRExpr;
    qrxpr63: TQRExpr;
    qrxpr64: TQRExpr;
    qrxpr65: TQRExpr;
    qrxpr66: TQRExpr;
    qrlbluno_: TQRLabel;
    qrlbldos_: TQRLabel;
    qrlbltres_: TQRLabel;
    qFecha: TQRLabel;
    qrxFecha: TQRExpr;
    qAlbaran: TQRLabel;
    qrxAlbaran: TQRExpr;
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrxprpk31Print(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrxpr44Print(sender: TObject; var Value: String);
    procedure qrxpr43Print(sender: TObject; var Value: String);
    procedure qrxpr42Print(sender: TObject; var Value: String);
    procedure qrgrp1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrp2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPie2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbndPie1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbluno_Print(sender: TObject; var Value: String);
    procedure qrxFechaPrint(sender: TObject; var Value: string);
    procedure BandaDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    sEmpresa: string;
    iAgrupaciones: integer;
    bNivel1, bNivel2, bTotales, bVerTotales, bVerFecha: boolean;

  end;


implementation

{$R *.DFM}

uses ResumenListFobDM, bMath, UDMAuxDB, Dialogs;


procedure TQLVentasLineaProductoClienteReport.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  
  if not bVerTotales then
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLVentasLineaProductoClienteReport.BandaDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if qrlbluno.Caption = 'Artículo' then
  begin
    qrxprc1.Width := 60;
    if (Exporting and (Pos('XLS', UpperCase(ExportFilter.ClassName)) > 0)) then
      qrx1.Enabled := true
    else
      qrx1.Enabled := false;
  end
  else
  begin
    qrxprc1.Width := 26;
    qrx1.Enabled := true;
  end;

  if qrlbldos.Caption = 'Artículo' then
  begin
    qrxprc2.Width := 60;
    if (Exporting and (Pos('XLS', UpperCase(ExportFilter.ClassName)) > 0)) then
      qrx2.Enabled := true
    else
      qrx2.Enabled := false;
  end
  else
  begin
    qrxprc2.Width := 26;
    qrx2.Enabled := true;
  end;

  if qrlbltres.Caption = 'Artículo' then
  begin
    qrxprc3.Width := 60;
    if (Exporting and (Pos('XLS', UpperCase(ExportFilter.ClassName)) > 0)) then
      qrx3.Enabled := true
    else
      qrx3.Enabled := false;
  end
  else
  begin
    qrxprc3.Width := 26;
    qrx3.Enabled := true;
  end;

end;

procedure TQLVentasLineaProductoClienteReport.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
    
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLVentasLineaProductoClienteReport.qrxprpk31Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQLVentasLineaProductoClienteReport.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  BandaDetalle.Height:= 13;

  qrxprpk31.Top:= 0;
  qrxprpk32.Top:= 0;
  qrxprpk33.Top:= 0;
  qrxprpk34.Top:= 0;
  qrxprpk35.Top:= 0;
  qrxprpk36.Top:= 0;
  qrxFecha.Top:=0;
  qrxAlbaran.Top:=0;

  qrxpr11.Top:= 3;
  qrxpr12.Top:= 3;
  qrxpr13.Top:= 3;
  qrxpr14.Top:= 3;
  qrxpr15.Top:= 3;
  qrxpr16.Top:= 3;

  qrxpr51.Top:= 3;
  qrxpr52.Top:= 3;
  qrxpr53.Top:= 3;
  qrxpr54.Top:= 3;
  qrxpr55.Top:= 3;
  qrxpr56.Top:= 3;

  qrxpr61.Top:= 3;
  qrxpr62.Top:= 3;
  qrxpr63.Top:= 3;
  qrxpr64.Top:= 3;
  qrxpr65.Top:= 3;
  qrxpr66.Top:= 3;

  QRBand4.Height:= 20;

  qrlblpk21.Top:= 3;
  qrlblpk22.Top:= 3;
  qrlblpk23.Top:= 3;
  qrlblpk24.Top:= 3;
  qrlblpk25.Top:= 3;
  qrlblpk26.Top:= 3;
  qFecha.Top:=3;
  qAlbaran.Top := 3;

  if NOT ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    qrlblpk21.Enabled:= False;
    qrlblpk22.Enabled:= False;
    qrlblpk23.Enabled:= False;
    qrlblpk24.Enabled:= False;
    qrlblpk25.Enabled:= False;
    qrlblpk26.Enabled:= False;
    qFecha.Enabled := False;
    qrxFecha.Enabled := False;
    qAlbaran.Enabled := False;
    qrxAlbaran.Enabled := False;
  end
  ELSE
  begin
    qrlblpk21.Enabled:= True;
    qrlblpk22.Enabled:= True;
    qrlblpk23.Enabled:= True;
    qrlblpk24.Enabled:= True;
    qrlblpk25.Enabled:= True;
    qrlblpk26.Enabled:= True;
    if bVerFecha then
    begin
      qFecha.Enabled:= True;
      qrxFecha.Enabled := True;
      qAlbaran.Enabled:= True;
      qrxAlbaran.Enabled := True;
    end
    else
    begin
      qFecha.Enabled:= False;
      qrxFecha.Enabled := False;
      qAlbaran.Enabled:= False;
      qrxAlbaran.Enabled := False;
    end;
  end;

  qrxprpk32.Enabled:= False;
  qrlblpk22.Enabled:= False;
  qrxpr12.Enabled:= False;
  qrxpr52.Enabled:= False;
  qrxpr62.Enabled:= False;

  if bNivel1 then
  begin
    qrgrp1.Height:= 0;
    qrgrp1.Enabled:= True;
    qrbndPie1.enabled:= True;
  end
  else
  begin
    qrgrp1.enabled:= False;
    qrbndPie1.enabled:= False;
  end;
  if bNivel2 then
  begin
    qrgrp2.Height:= 0;
    qrgrp2.Enabled:= True;
    qrbndPie2.enabled:= True;
  end
  else
  begin
    qrgrp2.enabled:= False;
    qrbndPie2.enabled:= False;
  end;

  //totales
  QRBand1.Enabled:= bTotales;


  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    qrx1.AutoSize:= True;
    qrx2.AutoSize:= True;
    qrx3.AutoSize:= True;
  end
  else
  begin
    qrx1.AutoSize:= False;
    qrx2.AutoSize:= False;
    qrx3.AutoSize:= False;
  end;  
  if iAgrupaciones = 0 then
  begin
    qrlbluno.Enabled:= False;
    qrlbluno_.Enabled:= False;
    qrxprc1.Enabled:= False;
    qrx1.Enabled:= False;
            
    qrlbldos.Enabled:= False;
    qrlbldos_.Enabled:= False;
    qrxprc2.Enabled:= False;
    qrx2.Enabled:= False;

    qrlbltres.Enabled:= False;
    qrlbltres_.Enabled:= False;
    qrxprc3.Enabled:= False;
    qrx3.Enabled:= False;
  end
  else
  if iAgrupaciones = 1 then
  begin
    qrlbluno_.Left:= 34;
    qrx1.Left:= 34;
    qrx1.Height:= 321;

    qrlbldos.Enabled:= False;
    qrlbldos_.Enabled:= False;
    qrxprc2.Enabled:= False;
    qrx2.Enabled:= False;

    qrlbltres.Enabled:= False;
    qrlbltres_.Enabled:= False;
    qrxprc3.Enabled:= False;
    qrx3.Enabled:= False;
  end
  else
  if iAgrupaciones = 2 then
  begin
    qrlbluno_.Left:= 34;
    qrx1.Left:= 34;
    qrx1.Height:= 145;

    qrlbldos.left:= 182;
    qrlbldos_.left:= 210;
    qrxprc2.left:= 182;
    qrx2.Left:= 210;
    qrx1.Width:= 145;

    qrlbltres.Enabled:= False;
    qrlbltres_.Enabled:= False;
    qrxprc3.Enabled:= False;
    qrx3.Enabled:= False;
  end;

end;

procedure TQLVentasLineaProductoClienteReport.qrxpr44Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total ' + value;
end;

procedure TQLVentasLineaProductoClienteReport.qrxpr43Print(sender: TObject;
  var Value: String);
begin
  if qrlbldos.Caption = 'Periodo Facturación' then
  begin
    if Value = '' then
      Value:= 'Total SIN PERIODO '
    else if Value = 'D' then
      Value:= 'Total FACT. DIARIA '
    else if Value = 'S' then
      Value:= 'Total FACT. SEMANAL '
    else if Value = 'Q' then
      Value:= 'Total FACT. QUINCENAL '
    else if Value = 'M' then
      Value:= 'Total FACT. MENSUAL '
  end
  else
    Value:= 'Total ' + value;
end;


procedure TQLVentasLineaProductoClienteReport.qrxpr42Print(sender: TObject;
  var Value: String);
begin
  if qrlbluno.Caption = 'Periodo Facturación' then
  begin
    if Value = '' then
      Value:= 'Total SIN PERIODO '
    else if Value = 'D' then
      Value:= 'Total FACT. DIARIA '
    else if Value = 'S' then
      Value:= 'Total FACT. SEMANAL '
    else if Value = 'Q' then
      Value:= 'Total FACT. QUINCENAL '
    else if Value = 'M' then
      Value:= 'Total FACT. MENSUAL '
  end
  else
    Value:= 'Total ' + value;
end;

procedure TQLVentasLineaProductoClienteReport.qrgrp1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
    
  if not bVerTotales then
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLVentasLineaProductoClienteReport.qrgrp2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
    
  if not bVerTotales then
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLVentasLineaProductoClienteReport.qrbndPie2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
    
  if not bVerTotales then
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLVentasLineaProductoClienteReport.qrxFechaPrint(sender: TObject;
  var Value: string);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:='';
  end;
end;

procedure TQLVentasLineaProductoClienteReport.qrbndPie1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin

  if not bVerTotales then
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLVentasLineaProductoClienteReport.qrlbluno_Print(
  sender: TObject; var Value: String);
begin
  if not (  Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

end.

