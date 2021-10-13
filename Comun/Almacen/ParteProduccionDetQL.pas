unit ParteProduccionDetQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLParteProduccionDet = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    lblPeriodo: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    QRLabel1: TQRLabel;
    qrlbl5: TQRLabel;
    qrlblPsQRLabel5: TQRLabel;
    qrgrp1: TQRGroup;
    qrxpr26: TQRExpr;
    qrxpr27: TQRExpr;
    qrxpr28: TQRExpr;
    qrbndPieGroup: TQRBand;
    qrshp1: TQRShape;
    qrxpr33: TQRExpr;
    qrxpr38: TQRExpr;
    qrxpr39: TQRExpr;
    qrxpr40: TQRExpr;
    qrxpr49: TQRExpr;
    DetailBand1: TQRBand;
    secciones: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr9: TQRExpr;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrlbl22: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrxpr41: TQRExpr;
    qrxpr42: TQRExpr;
    qrxpr43: TQRExpr;
    qrxpr44: TQRExpr;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrxpr45: TQRExpr;
    qrxpr46: TQRExpr;
    qrxpr47: TQRExpr;
    qrxpr48: TQRExpr;
    qrshp6: TQRShape;
    qrxpr50: TQRExpr;
    qrxpr51: TQRExpr;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrxpr52: TQRExpr;
    qrxpr53: TQRExpr;
    qrxpr54: TQRExpr;
    qrxpr55: TQRExpr;
    qrxpr56: TQRExpr;
    qrxpr57: TQRExpr;
    qrlbl23: TQRLabel;
    qrlbl24: TQRLabel;
    qrlbl25: TQRLabel;
    qrxpr58: TQRExpr;
    qrxpr59: TQRExpr;
    qrlbl26: TQRLabel;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr10: TQRExpr;
    qrshp2: TQRShape;
    qrshp3: TQRShape;
    qrshp4: TQRShape;
    qrxpr11: TQRExpr;
    qrxpr12: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr19: TQRExpr;
    qrxpr20: TQRExpr;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrxpr29: TQRExpr;
    qrxpr30: TQRExpr;
    qrxpr31: TQRExpr;
    qrxpr32: TQRExpr;
    qrxpr34: TQRExpr;
    qrxpr35: TQRExpr;
    qrxpr36: TQRExpr;
    qrlbl2: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    grCentro1: TQRBand;
    QRShape1: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    QRExpr5: TQRExpr;
    qrl6: TQRLabel;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    qrl7: TQRLabel;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    qrl8: TQRLabel;
    QRExpr15: TQRExpr;
    QRExpr16: TQRExpr;
    QRExpr17: TQRExpr;
    QRExpr18: TQRExpr;
    qrl9: TQRLabel;
    QRExpr19: TQRExpr;
    QRExpr20: TQRExpr;
    QRExpr21: TQRExpr;
    QRExpr22: TQRExpr;
    QRShape2: TQRShape;
    qrl10: TQRLabel;
    qrl11: TQRLabel;
    qrl12: TQRLabel;
    qrl13: TQRLabel;
    procedure qrlblPsQRLabel5Print(sender: TObject; var Value: String);
    procedure qrxpr13Print(sender: TObject; var Value: String);
    procedure qrxpr14Print(sender: TObject; var Value: String);
    procedure qrxpr28Print(sender: TObject; var Value: String);
    procedure qrxpr49Print(sender: TObject; var Value: String);
    procedure grCentro1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
  private
    ent_categoria_1, ent_categoria_2, ent_categoria_3, ent_categoria_4,
    sal_categoria_1, sal_categoria_2, sal_categoria_3, sal_categoria_4: currency;

    function HayMovimientos: boolean;

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
  QLParteProduccionDet: TQLParteProduccionDet;
begin
  try
    if ParteProduccionDL.OpenDataReporte( ABaseDatos, AEmpresa, AProducto, ACentro, AFechaIni, AFechaFin, ATipo  ) then
    begin
      QLParteProduccionDet := TQLParteProduccionDet.Create(nil);
      QLParteProduccionDet.iTipo:= ATipo;
      if AFechaIni <> AFechaFin then
        QLParteProduccionDet.lblPeriodo.Caption:= 'Parte del ' + FormatDateTime('dd/mm/yyyy', AFechaIni) + ' al ' + FormatDateTime('dd/mm/yyyy', AFechaFin)
      else
        QLParteProduccionDet.lblPeriodo.Caption:= 'Parte del ' + FormatDateTime('dd/mm/yyyy', AFechaIni);
      PonLogoGrupoBonnysa(QLParteProduccionDet, AEmpresa);
      QLParteProduccionDet.sEmpresa := AEmpresa;
      try
        Preview(QLParteProduccionDet);
      except
        FreeAndNil(QLParteProduccionDet);
      end;
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

procedure TQLParteProduccionDet.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  ent_categoria_1 := ent_categoria_1 + DataSet.FieldByName('entradas_categoria_1').AsFloat;
  ent_categoria_2 := ent_categoria_2 + DataSet.FieldByName('entradas_categoria_2').AsFloat;
  ent_categoria_3 := ent_categoria_3 + DataSet.FieldByName('entradas_categoria_3').AsFloat;
  ent_categoria_4 := ent_categoria_4 + DataSet.FieldByName('entradas_categoria_4').AsFloat;

  sal_categoria_1 := sal_categoria_1 + DataSet.FieldByName('salidas_categoria_1').AsFloat;
  sal_categoria_2 := sal_categoria_2 + DataSet.FieldByName('salidas_categoria_2').AsFloat;
  sal_categoria_3 := sal_categoria_3 + DataSet.FieldByName('salidas_categoria_3').AsFloat;
  sal_categoria_4 := sal_categoria_4 + DataSet.FieldByName('salidas_categoria_4').AsFloat;
end;

procedure TQLParteProduccionDet.grCentro1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if not HayMovimientos then
  begin
    qrl10.Enabled := false;
    qrl11.Enabled := false;
    qrl12.Enabled := false;
    qrl13.Enabled := false;
    qrshape2.Enabled := false;
    qrl5.Enabled := false;
    qrExpr5.Enabled := false;
    qrExpr7.Enabled := false;
  end
  else
  begin
    qrl10.Enabled := true;
    qrl11.Enabled := true;
    qrl12.Enabled := true;
    qrl13.Enabled := true;
    qrshape2.Enabled := true;
    qrl5.Enabled := true;
    qrExpr5.Enabled := true;
    qrExpr7.Enabled := true;
  end;

  if (ent_categoria_1 = 0) and (sal_categoria_1 = 0) then
  begin
    qrl6.Enabled := False;
    QRExpr6.Enabled := False;
    QRExpr9.Enabled := False;
    QRExpr8.Enabled := False;
    QRExpr10.Enabled := False;
  end
  else
    begin
    qrl6.Enabled := True;
    QRExpr6.Enabled := True;
    QRExpr9.Enabled := True;
    QRExpr8.Enabled := True;
    QRExpr10.Enabled := True;
    end;

  if (ent_categoria_2 = 0) and (sal_categoria_2 = 0) then
  begin
    qrl8.Enabled := False;
    QRExpr15.Enabled := False;
    QRExpr16.Enabled := False;
    QRExpr17.Enabled := False;
    QRExpr18.Enabled := False;
  end
  else
    begin
    qrl8.Enabled := True;
    QRExpr15.Enabled := True;
    QRExpr16.Enabled := True;
    QRExpr17.Enabled := True;
    QRExpr18.Enabled := True;
    end;

  if (ent_categoria_3 = 0) and (sal_categoria_3 = 0) then
  begin
    qrl7.Enabled := False;
    QRExpr11.Enabled := False;
    QRExpr12.Enabled := False;
    QRExpr13.Enabled := False;
    QRExpr14.Enabled := False;
  end
  else
    begin
    qrl7.Enabled := True;
    QRExpr11.Enabled := True;
    QRExpr12.Enabled := True;
    QRExpr13.Enabled := True;
    QRExpr14.Enabled := True;
    end;

  if (ent_categoria_4= 0) and (sal_categoria_4= 0) then
  begin
    qrl9.Enabled := False;
    QRExpr19.Enabled := False;
    QRExpr20.Enabled := False;
    QRExpr21.Enabled := False;
    QRExpr22.Enabled := False;
  end
  else
    begin
    qrl9.Enabled := True;
    QRExpr19.Enabled := True;
    QRExpr20.Enabled := True;
    QRExpr21.Enabled := True;
    QRExpr22.Enabled := True;
    end;
end;

function TQLParteProduccionDet.HayMovimientos: boolean;
begin
  if (ent_categoria_1 = 0) and (ent_categoria_2 = 0) and (ent_categoria_3 = 0) and (ent_categoria_4 = 0) and
     (sal_categoria_1 = 0) and (sal_categoria_2 = 0) and (sal_categoria_3 = 0) and (sal_categoria_4 = 0) then
     result := false
  else
    result := true;
end;

procedure TQLParteProduccionDet.qrlblPsQRLabel5Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= 'Empresa'
  else
    Value:= 'Emp';
end;

procedure TQLParteProduccionDet.qrxpr14Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= desCentro( DataSet.fieldByName('empresa').AsString, Value )
  else
    Value:= '';
end;

procedure TQLParteProduccionDet.qrxpr13Print(sender: TObject;
  var Value: String);
begin
  Value:= desProducto( DataSet.fieldByName('empresa').AsString, Value );
end;


procedure TQLParteProduccionDet.qrxpr28Print(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( DataSet.fieldByName('empresa').AsString, Value );
end;

procedure TQLParteProduccionDet.qrxpr49Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desCentro( DataSet.fieldByName('empresa').AsString, Value );
end;

procedure TQLParteProduccionDet.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  ent_categoria_1 := 0;
  ent_categoria_2 := 0;
  ent_categoria_3 := 0;
  ent_categoria_4 := 0;

  sal_categoria_1 := 0;
  sal_categoria_2 := 0;
  sal_categoria_3 := 0;
  sal_categoria_4 := 0;
end;

end.
