unit LProductividadPlantacionesQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, db;

type
  TQLProductividadPlantacionesQR = class(TQuickRep)
    bndCabecera: TQRBand;
    bndResumen: TQRBand;
    bndDetalle: TQRBand;
    bndCabProvincia: TQRGroup;
    bndCabCosechero: TQRGroup;
    PsQRSysData1: TQRSysData;
    PsQRDBText7: TQRDBText;
    bndPieProvincia: TQRBand;
    bndPieCosechero: TQRBand;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRSysData2: TQRSysData;
    PsQRLabel1: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr8: TQRExpr;
    PsQRExpr9: TQRExpr;
    PsQRExpr10: TQRExpr;
    PsQRExpr11: TQRExpr;
    PsQRExpr12: TQRExpr;
    PsQRExpr13: TQRExpr;
    PsQRExpr14: TQRExpr;
    PsQRExpr15: TQRExpr;
    PsQRExpr16: TQRExpr;
    PsQRExpr17: TQRExpr;
    PsQRExpr18: TQRExpr;
    PsQRExpr19: TQRExpr;
    PsQRExpr20: TQRExpr;
    PsQRExpr21: TQRExpr;
    PsQRExpr22: TQRExpr;
    PsQRExpr23: TQRExpr;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRExpr24: TQRExpr;
    PsQRExpr25: TQRExpr;
    PsQRExpr26: TQRExpr;
    PsQRExpr27: TQRExpr;
    PsQRExpr28: TQRExpr;
    PsQRExpr29: TQRExpr;
    PsQRExpr30: TQRExpr;
    PsQRExpr31: TQRExpr;
    PsQRExpr32: TQRExpr;
    lblLeyend8: TQRLabel;
    lblLeyend7: TQRLabel;
    lblLeyend6: TQRLabel;
    lblLeyend1: TQRLabel;
    lblLeyend2: TQRLabel;
    lblLeyend3: TQRLabel;
    lblLeyend4: TQRLabel;
    lblLeyend5: TQRLabel;
    ChildBand1: TQRChildBand;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    lblPeriodoAux: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    lblAcumuladoAux: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    lblPeriodo: TQRLabel;
    lblAcumulado: TQRLabel;
    lblPuntoLeyenda: TQRLabel;
    lblPuntoKGSPer: TQRLabel;
    lblPuntoKGSAcum: TQRLabel;
    lblPuntoDesde: TQRLabel;
    lblPuntoPeriodo: TQRLabel;
    lblProducto: TQRLabel;
    lblPeriodoProd: TQRLabel;
    PsQRShape3: TQRShape;
    PsQRShape4: TQRShape;
    QRBand1: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRSysData3: TQRSysData;
    procedure PsQRDBText1Print(sender: TObject; var Value: string);
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure PsQRDBText7Print(sender: TObject; var Value: string);
    procedure PsQRLabel3Print(sender: TObject; var Value: string);
    procedure PsQRLabel1Print(sender: TObject; var Value: string);
    procedure QLProductividadPlantacionesQRStartPage(
      Sender: TCustomQuickRep);
    procedure bndCabCosecheroAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndCabCosecheroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QLProductividadPlantacionesQRBeforePrint(
      Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure ChildBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieProvinciaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRExpr3Print(sender: TObject; var Value: string);
    procedure PsQRExpr1Print(sender: TObject; var Value: string);
    procedure PsQRExpr8Print(sender: TObject; var Value: string);
    procedure PsQRExpr2Print(sender: TObject; var Value: string);
    procedure PsQRExpr9Print(sender: TObject; var Value: string);
    procedure PsQRExpr10Print(sender: TObject; var Value: string);
    procedure PsQRExpr17Print(sender: TObject; var Value: string);
    procedure PsQRExpr18Print(sender: TObject; var Value: string);
    procedure PsQRExpr25Print(sender: TObject; var Value: string);
    procedure PsQRExpr26Print(sender: TObject; var Value: string);
    procedure PsQRExpr11Print(sender: TObject; var Value: string);
    procedure PsQRExpr21Print(sender: TObject; var Value: string);
    procedure PsQRExpr27Print(sender: TObject; var Value: string);
    procedure PsQRExpr13Print(sender: TObject; var Value: string);
    procedure PsQRExpr29Print(sender: TObject; var Value: string);
    procedure PsQRExpr19Print(sender: TObject; var Value: string);
  private
    paintLeyend: Boolean;
    paintBand: Boolean;

    bSuperficieCos, bPlantasCos: boolean;
    bSuperficiePro, bPlantasPro: boolean;
    bSuperficieTot, bPlantasTot: boolean;

  public
    //inicio,fin,ejercicio: TDate;
    compressReport: Boolean;
    //QSectoresPunto: TDataSet;
  end;

implementation

uses LProductividadPlantaciones, UDMAuxDB, bTextUtils;

{$R *.DFM}

procedure TQLProductividadPlantacionesQR.PsQRDBText1Print(sender: TObject;
  var Value: string);
begin
  Value := UpperCase(desProvincia(Value));
end;

procedure TQLProductividadPlantacionesQR.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  Value := Rellena(Value, 2, '0') + '  ' +
    desCosechero(DataSet.FieldByName('empresa_p').AsString, Value);
end;

procedure TQLProductividadPlantacionesQR.PsQRDBText7Print(sender: TObject;
  var Value: string);
begin
  Value := Rellena(DataSet.FieldByName('cosechero_p').AsString, 3, '0') +
    Rellena(Value, 2, '0') + '  ' +
    DataSet.FieldByName('ano_semana_p').AsString + ' ' +
    DataSet.FieldByName('descripcion_p').AsString;
end;

procedure TQLProductividadPlantacionesQR.PsQRLabel3Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTALES ' +
    UpperCase(desProvincia(DataSet.FieldByName('provincia').AsString));
end;

procedure TQLProductividadPlantacionesQR.PsQRLabel1Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTALES';
  {Value:= 'TOTALES COSECHERO ' +
          UpperCase(Rellena(DataSet.FieldByName('cosechero_p').AsString,2,'0'));}
end;

procedure TQLProductividadPlantacionesQR.QLProductividadPlantacionesQRStartPage(
  Sender: TCustomQuickRep);
begin
  paintLeyend := true;
  paintBand := true;
end;

procedure TQLProductividadPlantacionesQR.bndCabCosecheroAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  paintLeyend := false;
end;

procedure TQLProductividadPlantacionesQR.bndCabCosecheroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  lblLeyend1.Enabled := paintLeyend;
  lblLeyend2.Enabled := paintLeyend;
  lblLeyend3.Enabled := paintLeyend;
  lblLeyend4.Enabled := paintLeyend;
  lblLeyend5.Enabled := paintLeyend;
  lblLeyend6.Enabled := paintLeyend;
  lblLeyend7.Enabled := paintLeyend;
  lblLeyend8.Enabled := paintLeyend;
  lblAcumulado.Enabled := paintLeyend;
  lblPeriodo.Enabled := paintLeyend;
end;

procedure TQLProductividadPlantacionesQR.QLProductividadPlantacionesQRBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  if compressReport then
  begin
    bndCabProvincia.Height := 25
  end
  else
  begin
    bndCabProvincia.Height := 40;
  end;
  bndCabProvincia.ForceNewPage := not compressReport;
  //QSectoresPunto.First;
end;

procedure TQLProductividadPlantacionesQR.ChildBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  paintBand := false;
end;

procedure TQLProductividadPlantacionesQR.ChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := paintBand;
end;

procedure TQLProductividadPlantacionesQR.bndPieProvinciaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
{var
  periodo, acumulado: real;}
begin
{
  if (DataSet.FieldByName('provincia').AsString =
      QSectoresPunto.FieldByName('provincia').AsString) and
     (QSectoresPunto.FieldByName('kilosAcumulados').AsFloat <> 0 ) then
  begin
    lblPuntoKGSPer.Enabled:= true;
    lblPuntoKGSAcum.Enabled:= true;
    lblPuntoLeyenda.Enabled:= true;
    lblPuntoDesde.Enabled:= true;
    lblPuntoPeriodo.Enabled:= true;

    //bndPieProvincia.Height:= 45;

    periodo:= 0;
    acumulado:= 0;
    while (DataSet.FieldByName('provincia').AsString =
          QSectoresPunto.FieldByName('provincia').AsString)  and
          not QSectoresPunto.EOF do
    begin
      periodo:= periodo + QSectoresPunto.FieldByName('kilosPeriodo').AsFloat;
      acumulado:= acumulado + QSectoresPunto.FieldByName('kilosAcumulados').AsFloat;
      QSectoresPunto.Next;
    end;
    lblPuntoKGSPer.Caption:= FormatFloat('#,##0', periodo);
    lblPuntoKGSAcum.Caption:= FormatFloat('#,##0', acumulado);

  end
  else
  begin
    lblPuntoKGSPer.Enabled:= false;
    lblPuntoKGSAcum.Enabled:= false;
    lblPuntoLeyenda.Enabled:= false;
    lblPuntoDesde.Enabled:= false;
    lblPuntoPeriodo.Enabled:= false;

    //bndPieProvincia.Height:= 25;
  end;}
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr3Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('plantas_p').AsInteger = 0 then
    Value := '0';
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr1Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('plantas_p').AsInteger = 0 then
    Value := '0';
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr8Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('superficie_p').AsInteger = 0 then
    Value := '0';
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr2Print(sender: TObject;
  var Value: string);
begin
  if DataSet.FieldByName('superficie_p').AsInteger = 0 then
    Value := '0';
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr9Print(sender: TObject;
  var Value: string);
begin
  bSuperficieCos := StrToFloat(StringReplace(Value, '.', '', [rfReplaceAll, rfIgnoreCase])) <> 0;
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr10Print(sender: TObject;
  var Value: string);
begin
  bPlantasCos := StrToFloat(StringReplace(Value, '.', '', [rfReplaceAll, rfIgnoreCase])) <> 0;
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr17Print(sender: TObject;
  var Value: string);
begin
  bSuperficiePro := StrToFloat(StringReplace(Value, '.', '', [rfReplaceAll, rfIgnoreCase])) <> 0;
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr18Print(sender: TObject;
  var Value: string);
begin
  bPlantasPro := StrToFloat(StringReplace(Value, '.', '', [rfReplaceAll, rfIgnoreCase])) <> 0;
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr25Print(sender: TObject;
  var Value: string);
begin
  bSuperficieTot := StrToFloat(StringReplace(Value, '.', '', [rfReplaceAll, rfIgnoreCase])) <> 0;
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr26Print(sender: TObject;
  var Value: string);
begin
  bSuperficieTot := StrToFloat(StringReplace(Value, '.', '', [rfReplaceAll, rfIgnoreCase])) <> 0;
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr11Print(sender: TObject;
  var Value: string);
begin
  if not bSuperficieCos then
    Value := '0';
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr19Print(sender: TObject;
  var Value: string);
begin
  if not bSuperficiePro then
    Value := '0';
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr27Print(sender: TObject;
  var Value: string);
begin
  if not bSuperficieTot then
    Value := '0';
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr13Print(sender: TObject;
  var Value: string);
begin
  if not bPlantasCos then
    Value := '0';
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr21Print(sender: TObject;
  var Value: string);
begin
  if not bPlantasPro then
    Value := '0';
end;

procedure TQLProductividadPlantacionesQR.PsQRExpr29Print(sender: TObject;
  var Value: string);
begin
  if not bPlantasTot then
    Value := '0';
end;

end.
