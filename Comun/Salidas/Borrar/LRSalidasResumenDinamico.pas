unit LRSalidasResumenDinamico;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLSalidasResumenDinamico = class(TQuickRep)
    QRBand4: TQRBand;
    qrlbluno: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    PsQRLabel16: TQRLabel;
    QRBand5: TQRBand;
    PsQRSysData3: TQRSysData;
    PageFooterBand1: TQRBand;
    PsQRSysData2: TQRSysData;
    qrlblPeriodo: TQRLabel;
    qrlblTitulo: TQRLabel;
    LCategoria: TQRLabel;
    qrlLProducto: TQRLabel;
    qrlDestino: TQRLabel;
    qrlbltres: TQRLabel;
    qrlbldos: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrgrp1: TQRGroup;
    qrgrp2: TQRGroup;
    qrbndPie1: TQRBand;
    qrbndPie2: TQRBand;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr9: TQRExpr;
    qrshp2: TQRShape;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrxpr29: TQRExpr;
    qrshp3: TQRShape;
    qrxpr42: TQRExpr;
    qrxpr43: TQRExpr;
    qrxpr11: TQRExpr;
    qrxpr51: TQRExpr;
    qrxpr61: TQRExpr;
    BandaDetalle: TQRBand;
    qrx1: TQRExpr;
    qrx2: TQRExpr;
    qrx3: TQRExpr;
    qrxprImporteL: TQRExpr;
    qrx7: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxprpk31: TQRExpr;
    qrxprc1: TQRExpr;
    qrxprc2: TQRExpr;
    qrxprc3: TQRExpr;
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrxprpk31Print(sender: TObject; var Value: String);
    procedure qrx9Print(sender: TObject; var Value: String);
    procedure PsQRLabel16Print(sender: TObject; var Value: String);
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
  private

  public
    sEmpresa: string;
    iAgrupaciones: integer;
    bNivel1, bNivel2, bTotales, bVerTotales, bImportes: boolean;

  end;


implementation

{$R *.DFM}

uses ResumenListFobDM, bMath, UDMAuxDB, Dialogs;


procedure TQLSalidasResumenDinamico.SummaryBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  
  if not bVerTotales then
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLSalidasResumenDinamico.PageFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
    
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLSalidasResumenDinamico.qrxprpk31Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQLSalidasResumenDinamico.qrx9Print(sender: TObject;
  var Value: String);
begin

  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQLSalidasResumenDinamico.PsQRLabel16Print(
  sender: TObject; var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQLSalidasResumenDinamico.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  iAux: Integer;
begin

  PsQRLabel14.Enabled:= bImportes;
  PsQRLabel16.Enabled:= bImportes;
  qrxprImporteL.Enabled:= bImportes;
  qrxprpk31.Enabled:= bImportes;
  qrxpr9.Enabled:= bImportes;
  qrxpr11.Enabled:= bImportes;
  qrxpr29.Enabled:= bImportes;
  qrxpr51.Enabled:= bImportes;
  QRExpr2.Enabled:= bImportes;
  qrxpr61.Enabled:= bImportes;

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
    qrxprc1.Enabled:= False;
    qrx1.Enabled:= False;

    qrlbldos.Enabled:= False;
    qrxprc2.Enabled:= False;
    qrx2.Enabled:= False;

    qrlbltres.Enabled:= False;
    qrxprc3.Enabled:= False;
    qrx3.Enabled:= False;
  end
  else
  if iAgrupaciones = 1 then
  begin
    qrx1.Left:= 34;
    qrx1.Height:= 321;

    qrlbldos.Enabled:= False;
    qrxprc2.Enabled:= False;
    qrx2.Enabled:= False;

    qrlbltres.Enabled:= False;
    qrxprc3.Enabled:= False;
    qrx3.Enabled:= False;
  end
  else
  if iAgrupaciones = 2 then
  begin
    qrx1.Left:= 34;
    qrx1.Height:= 145;

    qrlbldos.left:= 182;
    qrxprc2.left:= 182;
    qrx2.Left:= 210;
    qrx1.Width:= 145;

    qrlbltres.Enabled:= False;
    qrxprc3.Enabled:= False;
    qrx3.Enabled:= False;
  end;
end;

procedure TQLSalidasResumenDinamico.qrxpr44Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total ' + value;
end;

procedure TQLSalidasResumenDinamico.qrxpr43Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total ' + value;
end;

procedure TQLSalidasResumenDinamico.qrxpr42Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total ' + value;
end;

procedure TQLSalidasResumenDinamico.qrgrp1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
    
  if not bVerTotales then
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLSalidasResumenDinamico.qrgrp2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
    
  if not bVerTotales then
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLSalidasResumenDinamico.qrbndPie2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
    
  if not bVerTotales then
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQLSalidasResumenDinamico.qrbndPie1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin

  if not bVerTotales then
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

end.

