unit ParteProduccionQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLParteProduccion = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    lblPeriodo: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    coste: TQRExpr;
    PsQRLabel6: TQRLabel;
    secciones: TQRExpr;
    QRLabel1: TQRLabel;
    qrxGeneral: TQRExpr;
    qrlGeneral: TQRLabel;
    qrlTotal: TQRLabel;
    qrxTotal: TQRExpr;
    qrxpr1: TQRExpr;
    qrbndTotales: TQRBand;
    qrshpTotal: TQRShape;
    qrxpr9: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlblPsQRLabel5: TQRLabel;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr12: TQRExpr;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr5: TQRExpr;
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
    qrxpr25: TQRExpr;
    qrgrp1: TQRGroup;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrbndPieGroup: TQRBand;
    qrshp1: TQRShape;
    qrxpr29: TQRExpr;
    qrxpr30: TQRExpr;
    qrxpr31: TQRExpr;
    qrxpr32: TQRExpr;
    qrxpr33: TQRExpr;
    qrxpr34: TQRExpr;
    qrxpr35: TQRExpr;
    qrxpr36: TQRExpr;
    qrxpr37: TQRExpr;
    qrxpr38: TQRExpr;
    qrxpr39: TQRExpr;
    qrxpr40: TQRExpr;
    qrlblStockIni: TQRLabel;
    qrlblEntradas: TQRLabel;
    qrlblSalidas: TQRLabel;
    qrlblStockFin: TQRLabel;
    qrshp2: TQRShape;
    qrshp3: TQRShape;
    qrshp4: TQRShape;
    qrshp5: TQRShape;
    qrxpr49: TQRExpr;
    qrlbl21: TQRLabel;
    procedure qrlblPsQRLabel5Print(sender: TObject; var Value: String);
    procedure qrxpr13Print(sender: TObject; var Value: String);
    procedure qrxpr14Print(sender: TObject; var Value: String);
    procedure qrxpr28Print(sender: TObject; var Value: String);
    procedure PageHeaderBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrxpr49Print(sender: TObject; var Value: String);
  private

  public
    sEmpresa: string;
    iTipo: integer;
  end;

procedure PreviewReporte(const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer );

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, ParteProduccionDL;


procedure PreviewReporte(const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFechaIni, AFechaFin: TDateTime; const ATipo: Integer );
var
  QLParteProduccion: TQLParteProduccion;
begin
  try
    if ParteProduccionDL.OpenDataReporte( ABaseDatos, AEmpresa, AProducto, ACentro, AFechaIni, AFechaFin, ATipo  ) then
    begin
      QLParteProduccion := TQLParteProduccion.Create(nil);
      QLParteProduccion.iTipo:= ATipo;
      if AFechaIni <> AFechaFin then
        QLParteProduccion.lblPeriodo.Caption:= 'Parte del ' + FormatDateTime('dd/mm/yyyy', AFechaIni) + ' al ' + FormatDateTime('dd/mm/yyyy', AFechaFin)
      else
        QLParteProduccion.lblPeriodo.Caption:= 'Parte del ' + FormatDateTime('dd/mm/yyyy', AFechaIni);
      PonLogoGrupoBonnysa(QLParteProduccion, AEmpresa);
      QLParteProduccion.sEmpresa := AEmpresa;
      Preview(QLParteProduccion);
      DMBaseDatos.QListado.Close;
    end
    else
    begin
      ShowMessage('Listado sin datos.');
    end;
  finally
    ParteProduccionDL.CloseDataReporte;
  end;
end;

procedure TQLParteProduccion.qrlblPsQRLabel5Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= 'Empresa'
  else
    Value:= 'Emp';
end;

procedure TQLParteProduccion.qrxpr14Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= desCentro( DataSet.fieldByName('empresa').AsString, Value )
  else
    Value:= '';
end;

procedure TQLParteProduccion.qrxpr13Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.fieldByName('empresa').AsString, Value );
end;


procedure TQLParteProduccion.qrxpr28Print(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( DataSet.fieldByName('empresa').AsString, Value );
end;

procedure TQLParteProduccion.PageHeaderBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if iTipo = 0 then
  begin
    qrlblStockIni.Caption:= 'STOCK INICIAL RF';
    qrlblEntradas.Caption:= 'ENTRADAS RF';
    qrlblStockFin.Caption:= 'STOCK FINAL RF';
  end
  else
  begin
    qrlblStockIni.Caption:= 'INVENTARIO INICIAL';
    qrlblEntradas.Caption:= 'ENTRADAS COMERCIAL';
    qrlblStockFin.Caption:= 'INVENTARIO FINAL';
  end;
end;

procedure TQLParteProduccion.qrxpr49Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desCentro( DataSet.fieldByName('empresa').AsString, Value );
end;

end.
