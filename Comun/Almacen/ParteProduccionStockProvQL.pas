unit ParteProduccionStockProvQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLParteProduccionStockProv = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    coste: TQRExpr;
    PsQRLabel6: TQRLabel;
    secciones: TQRExpr;
    QRLabel1: TQRLabel;
    qrxGeneral: TQRExpr;
    qrxpr1: TQRExpr;
    qrbndTotales: TQRBand;
    qrshpTotal: TQRShape;
    qrxpr9: TQRExpr;
    qrxpr10: TQRExpr;
    qrxpr11: TQRExpr;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlblPsQRLabel5: TQRLabel;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrgrp1: TQRGroup;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrbndPieGroup: TQRBand;
    qrshp1: TQRShape;
    qrxpr29: TQRExpr;
    qrxpr30: TQRExpr;
    qrxpr31: TQRExpr;
    qrxpr32: TQRExpr;
    qrxpr33: TQRExpr;
    qrxpr34: TQRExpr;
    qrxpr28: TQRExpr;
    qrxpr41: TQRExpr;
    qrlblPeriodo: TQRLabel;
    procedure qrlblPsQRLabel5Print(sender: TObject; var Value: String);
    procedure qrxpr13Print(sender: TObject; var Value: String);
    procedure qrxpr14Print(sender: TObject; var Value: String);
    procedure qrxpr28Print(sender: TObject; var Value: String);
  private

  public
    sEmpresa: string;
    iTipo: integer;
  end;

procedure VerStockInicial(const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFecha: TDateTime; const ATipo: Integer );

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, ParteProduccionControlDL;


procedure VerStockInicial(const ABaseDatos, AEmpresa, AProducto, ACentro: string; const AFecha: TDateTime; const ATipo: Integer );
var
  QLParteProduccionStockProv: TQLParteProduccionStockProv;
begin
  try
    if ParteProduccionControlDL.OpenDataStockProv( ABaseDatos, AEmpresa, AProducto, ACentro, AFecha, ATipo  ) then
    begin
      QLParteProduccionStockProv := TQLParteProduccionStockProv.Create(nil);
      QLParteProduccionStockProv.qrlblPeriodo.Caption:= 'Stock del ' + FormatDateTime('dd/mm/yyyy', AFecha);
      PonLogoGrupoBonnysa(QLParteProduccionStockProv, AEmpresa);
      QLParteProduccionStockProv.sEmpresa := AEmpresa;
      QLParteProduccionStockProv.iTipo:= ATipo;
      Preview(QLParteProduccionStockProv);
      DMBaseDatos.QListado.Close;
    end
    else
    begin
      ShowMessage('Listado sin datos.');
    end;
  finally
    ParteProduccionControlDL.CloseDataReporte;
  end;
end;

procedure TQLParteProduccionStockProv.qrlblPsQRLabel5Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= 'Empresa'
  else
    Value:= 'Emp';
end;

procedure TQLParteProduccionStockProv.qrxpr14Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= desCentro( DataSet.fieldByName('empresa').AsString, Value )
  else
    Value:= '';
end;

procedure TQLParteProduccionStockProv.qrxpr13Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.fieldByName('empresa').AsString, Value );
end;


procedure TQLParteProduccionStockProv.qrxpr28Print(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( DataSet.fieldByName('empresa').AsString, Value );
end;

end.
