unit QLLiquidacionProvedores;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;

type
  TQRLLiquidacionProvedores = class(TQuickRep)
    CabeceraPagina: TQRBand;
    PiePagina: TQRBand;
    lblTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRSubDetail1: TQRSubDetail;
    anyo: TQRDBText;
    kilos: TQRDBText;
    QKGSCosechados: TQuery;
    DataSource1: TDataSource;
    QCosecheros: TQuery;
    aprovecha: TQRDBText;
    aprovechados: TQRDBText;
    lCat: TQRDBText;
    lKilCat: TQRDBText;
    lPorCat: TQRDBText;
    lFOB: TQRDBText;
    DataSource2: TDataSource;
    QFOB: TQuery;
    PsQRDBText3: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRLabel37: TQRLabel;
    PsQRLabel45: TQRLabel;
    bnd1Resumen: TQRChildBand;
    bnd2Resumen: TQRChildBand;
    bnd3Resumen: TQRChildBand;
    bndPieResumen: TQRChildBand;
    PsQRLabel41: TQRLabel;
    PsQRLabel43: TQRLabel;
    PsQRLabel79: TQRLabel;
    PsQRLabel82: TQRLabel;
    PsQRLabel83: TQRLabel;
    PsQRLabel85: TQRLabel;
    PsQRLabel88: TQRLabel;
    PsQRLabel89: TQRLabel;
    PsQRLabel90: TQRLabel;
    PsQRLabel92: TQRLabel;
    PsQRLabel95: TQRLabel;
    PsQRLabel96: TQRLabel;
    PsQRLabel97: TQRLabel;
    PsQRExpr1: TQRExpr;
    PsQRLabel101: TQRLabel;
    PsQRLabel102: TQRLabel;
    PsQRLabel42: TQRLabel;
    PsQRLabel44: TQRLabel;
    PsQRLabel78: TQRLabel;
    PsQRLabel84: TQRLabel;
    bndCabResumen: TQRChildBand;
    PsQRLabel109: TQRLabel;
    PsQRLabel110: TQRLabel;
    PsQRLabel111: TQRLabel;
    PsQRLabel112: TQRLabel;
    QRGroup1: TQRGroup;
    PsQRLabel1: TQRLabel;
    cosechero: TQRDBText;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRDBText5: TQRDBText;
    PsQRLabel4: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    codCentro: TQRLabel;
    NomCentro: TQRLabel;
    codProducto: TQRLabel;
    nomProducto: TQRLabel;
    periodo: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel34: TQRLabel;
    PsQRLabel35: TQRLabel;
    PsQRLabel36: TQRLabel;
    PsQRLabel38: TQRLabel;
    PsQRLabel39: TQRLabel;
    BandaTotales: TQRBand;
    PsQRLabel14: TQRLabel;
    PsQRLabel60: TQRLabel;
    lSumKilosAprovecha: TQRExpr;
    MediaPrecioKilo: TQRLabel;
    MediaFOB: TQRLabel;
    PsQRLabel46: TQRLabel;
    lSumImporteFOB: TQRLabel;
    lblAjuste: TQRLabel;
    QRLabel28: TQRLabel;
    bnd4Resumen: TQRChildBand;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel2: TQRLabel;
    QRExpr1: TQRExpr;
    porcentaje_total: TQRLabel;
    lblTipoKilos: TQRLabel;
    lblSinAjuste: TQRLabel;
    procedure kilosPrint(sender: TObject; var Value: string);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Porcentaje(sender: TObject; var Value: string);
    procedure lImporteFOBPrint(sender: TObject; var Value: string);
    procedure QRLLiquidacionCosecherosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure lSumImporteFOBPrint(sender: TObject; var Value: string);
    procedure PsQRLabel45Print(sender: TObject; var Value: string);
    procedure PsQRLabel46Print(sender: TObject; var Value: string);
    procedure lSumKilosAprovechaPrint(sender: TObject; var Value: string);
    procedure PsQRLabel60Print(sender: TObject; var Value: string);
    procedure MediaPrecioKiloPrint(sender: TObject; var Value: string);
    procedure MediaFOBPrint(sender: TObject; var Value: string);
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure anyoPrint(sender: TObject; var Value: string);
    procedure bnd1ResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bnd2ResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bnd3ResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieResumenAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure PsQRLabel42Print(sender: TObject; var Value: string);
    procedure PsQRLabel44Print(sender: TObject; var Value: string);
    procedure PsQRLabel78Print(sender: TObject; var Value: string);
    procedure PsQRLabel84Print(sender: TObject; var Value: string);
    procedure QRGroup1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure lblAjustePrint(sender: TObject; var Value: string);
    procedure porcentaje_totalPrint(sender: TObject; var Value: string);
    procedure PsQRLabel43Print(sender: TObject; var Value: string);
    procedure PsQRLabel79Print(sender: TObject; var Value: string);
    procedure PsQRLabel85Print(sender: TObject; var Value: string);
    procedure PsQRLabel92Print(sender: TObject; var Value: string);
    procedure PsQRLabel88Print(sender: TObject; var Value: string);
    procedure PsQRLabel95Print(sender: TObject; var Value: string);
    procedure VersionDefinitivo(sender: TObject; var Value: string);
    procedure PsQRLabel36Print(sender: TObject; var Value: string);
    procedure PsQRLabel38Print(sender: TObject; var Value: string);
    procedure bndPieResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndCabResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lFOBPrint(sender: TObject; var Value: string);
    procedure PsQRDBText6Print(sender: TObject; var Value: string);
    procedure QRLabel28Print(sender: TObject; var Value: string);
    procedure bnd4ResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel30Print(sender: TObject; var Value: string);
    procedure QRLabel31Print(sender: TObject; var Value: string);
    procedure QRLabel32Print(sender: TObject; var Value: string);
    procedure QRLabel33Print(sender: TObject; var Value: string);
    procedure lCatPrint(sender: TObject; var Value: string);
    procedure PsQRLabel96Print(sender: TObject; var Value: string);
    procedure PsQRLabel89Print(sender: TObject; var Value: string);
    procedure PsQRLabel82Print(sender: TObject; var Value: string);
    procedure PsQRLabel34Print(sender: TObject; var Value: string);
    procedure lPorCatPrint(sender: TObject; var Value: string);
  private
    //Auxiliares
    AnyoSemanaActual: string;
    rFob, rFobReal, rCosteEnvasado: Real;
    rBrutoFOB, rNetoFOB: Real;

    //Sumatorios
    iKilosCos: Integer;
    rSumBrutoFOB, rSumNetoFOB: Real;
    iSumKilosAprovecha: Integer;

    //Por categoria
    kilos_cat_1, kilos_cat_2, kilos_cat_3, kilos_cat_d: Integer;
    //porcen_cat_1, porcen_cat_2, porcen_cat_3: Real;
    fob_cat_1, fob_cat_2, fob_cat_3, fob_cat_d: Real;
    bruto_cat_1, bruto_cat_2, bruto_cat_3, bruto_cat_d: Real;
    lines_cat_1, lines_cat_2, lines_cat_3, lines_cat_d: integer;

  public
    bDefinitivo: Boolean;
    bAprovechaSalida: Boolean;
    empresa: string;

  end;

var
  QRLLiquidacionProvedores: TQRLLiquidacionProvedores;

implementation

uses CAuxiliar, Principal, UDMAuxDB, bSQLUtils, bMath, dialogs;

{$R *.DFM}


procedure TQRLLiquidacionProvedores.kilosPrint(sender: TObject;
  var Value: string);
var
  aux: real;
begin
  aux := StrToFloat(Value);
  if aux = 0 then Value := ''
  else Value := FormatFloat('#,##0', aux);
end;

procedure TQRLLiquidacionProvedores.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  anyo.Enabled := AnyoSemanaActual <> QKGSCosechados.FieldByName('semana').AsString;
  kilos.Enabled := anyo.Enabled;
  aprovecha.Enabled := anyo.Enabled;
  aprovechados.Enabled := anyo.Enabled;
  AnyoSemanaActual := QKGSCosechados.FieldByName('semana').AsString;

  if anyo.Enabled then
  begin
    iKilosCos := iKilosCos + QKGSCosechados.FieldByName('kilos').AsInteger;
  end;

   //GetFOB( rFob, rCosteEnvasado, rFobReal );
  rFob := QFOB.fieldbyname('fob').asfloat;
  rCosteEnvasado := QFOB.fieldbyname('coste_envasado').asfloat;
  rFobReal := rFob - rCosteEnvasado;

  rNetoFOB := Redondea(QKGSCosechados.fieldbyname('kilos_cat').asInteger * rFobReal, 2);
  rBrutoFOB := Redondea(QKGSCosechados.fieldbyname('kilos_cat').asInteger * rFob, 2);
  rSumNetoFOB := rSumNetoFOB + rNetoFOB;
  rSumBrutoFOB := rSumBrutoFOB + rBrutoFOB;

  if QKGSCosechados.fieldbyname('categoria').AsString = '1' then
  begin
    kilos_cat_1 := kilos_cat_1 + QKGSCosechados.fieldbyname('kilos_cat').AsInteger;
    fob_cat_1 := fob_cat_1 + rNetoFOB;
    bruto_cat_1 := bruto_cat_1 + rBrutoFOB;
    lines_cat_1 := lines_cat_1 + 1;
  end
  else
    if QKGSCosechados.fieldbyname('categoria').AsString = '2' then
    begin
      kilos_cat_2 := kilos_cat_2 + QKGSCosechados.fieldbyname('kilos_cat').AsInteger;
      fob_cat_2 := fob_cat_2 + rNetoFOB;
      bruto_cat_2 := bruto_cat_2 + rBrutoFOB;
      lines_cat_2 := lines_cat_2 + 1;
    end
    else
      if QKGSCosechados.fieldbyname('categoria').AsString = '3' then
      begin
        kilos_cat_3 := kilos_cat_3 + QKGSCosechados.fieldbyname('kilos_cat').AsInteger;
        fob_cat_3 := fob_cat_3 + rNetoFOB;
        bruto_cat_3 := bruto_cat_3 + rBrutoFOB;
        lines_cat_3 := lines_cat_3 + 1;
      end
      else
        if QKGSCosechados.fieldbyname('categoria').AsString = '4' then
        begin
          kilos_cat_d := kilos_cat_d + QKGSCosechados.fieldbyname('kilos_cat').AsInteger;
          fob_cat_d := fob_cat_d + rNetoFOB;
          bruto_cat_d := bruto_cat_d + rBrutoFOB;
          lines_cat_d := lines_cat_d + 1;
        end;

  iSumKilosAprovecha := iSumKilosAprovecha + QKGSCosechados.FieldByName('kilos_cat').AsInteger;
end;

procedure TQRLLiquidacionProvedores.Porcentaje(sender: TObject;
  var Value: string);
begin
(*
  if Value='0' then Value:=''
  else
*)
  Value := FormatFloat('#00.00', StrToFloat(Value)) + '%';
end;

procedure TQRLLiquidacionProvedores.lImporteFOBPrint(sender: TObject;
  var Value: string);
begin
(*
  if ( rFob = 0 ) then
    Value:= ''
  else
*)
  Value := FormatFloat('#,##0.00', rNetoFOB);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel45Print(sender: TObject;
  var Value: string);
begin
  if bDefinitivo then
    Value := ''
  else
    Value := FormatFloat('#,##0.00', rBrutoFOB);
end;

procedure TQRLLiquidacionProvedores.QRLLiquidacionCosecherosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  AnyoSemanaActual := '';
  kilos_cat_1 := 0;
  kilos_cat_2 := 0;
  kilos_cat_3 := 0;
  kilos_cat_d := 0;
  fob_cat_1 := 0;
  fob_cat_2 := 0;
  fob_cat_3 := 0;
  fob_cat_d := 0;
  bruto_cat_1 := 0;
  bruto_cat_2 := 0;
  bruto_cat_3 := 0;
  bruto_cat_d := 0;
  lines_cat_1 := 0;
  lines_cat_2 := 0;
  lines_cat_3 := 0;
  lines_cat_d := 0;
  iSumKilosAprovecha := 0;
end;

procedure TQRLLiquidacionProvedores.lSumImporteFOBPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', rSumNetoFOB);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel46Print(sender: TObject;
  var Value: string);
begin
  if not bDefinitivo then
    Value := FormatFloat('#,##0.00', rSumBrutoFOB)
  else
    Value := '';
end;

procedure TQRLLiquidacionProvedores.PsQRLabel60Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', iKilosCos);
end;

procedure TQRLLiquidacionProvedores.lSumKilosAprovechaPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', iSumKilosAprovecha);

  //Procentaje
(*
  if iKilosCos<>0 then
  begin
    porcentaje_total.caption:= Formatfloat( '#00.00',
                                 Redondea( kilos_cat_1 * 100 / iKilosCos, 2 ) +
                                 Redondea( kilos_cat_2 * 100 / iKilosCos, 2 ) +
                                 Redondea( kilos_cat_3 * 100 / iKilosCos, 2 ) +
                                 Redondea( kilos_cat_d * 100 / iKilosCos, 2 )) + '%';
  end
  else
  begin
    porcentaje_total.Caption:='';
  end;
*)
end;

procedure TQRLLiquidacionProvedores.MediaPrecioKiloPrint(sender: TObject;
  var Value: string);
begin
  if not bDefinitivo then
    Value := FormatFloat('#,##0.000', rSumBrutoFOB / iSumKilosAprovecha)
  else
    Value := '';
end;

procedure TQRLLiquidacionProvedores.MediaFOBPrint(sender: TObject;
  var Value: string);
begin
  //if iSumKilosAprovecha<>0 then
  Value := FormatFloat('#,##0.000', rSumNetoFOB / iSumKilosAprovecha)
  //else
  //  Value:='';
end;

procedure TQRLLiquidacionProvedores.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  Value := Trim(Value);
end;

procedure TQRLLiquidacionProvedores.anyoPrint(sender: TObject;
  var Value: string);
begin
  Value := Copy(Value, 1, 4) + ' ' + Copy(Value, 5, 2);
end;

procedure TQRLLiquidacionProvedores.bnd1ResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := (lines_cat_1 <> 0) and not bDefinitivo;
end;

procedure TQRLLiquidacionProvedores.bnd2ResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := (lines_cat_2 <> 0) and not bDefinitivo;
end;

procedure TQRLLiquidacionProvedores.bnd3ResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := (lines_cat_3 <> 0) and not bDefinitivo;
end;

procedure TQRLLiquidacionProvedores.bnd4ResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := (lines_cat_d <> 0) and not bDefinitivo;
end;

procedure TQRLLiquidacionProvedores.bndPieResumenAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  kilos_cat_1 := 0;
  kilos_cat_2 := 0;
  kilos_cat_3 := 0;
  kilos_cat_d := 0;
  fob_cat_1 := 0;
  fob_cat_2 := 0;
  fob_cat_3 := 0;
  fob_cat_d := 0;
  bruto_cat_1 := 0;
  bruto_cat_2 := 0;
  bruto_cat_3 := 0;
  bruto_cat_d := 0;
  lines_cat_1 := 0;
  lines_cat_2 := 0;
  lines_cat_3 := 0;
  lines_cat_d := 0;
end;

procedure TQRLLiquidacionProvedores.PsQRLabel42Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_1 - fob_cat_1);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel44Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_2 - fob_cat_2);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel78Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_3 - fob_cat_3);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel84Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', rSumBrutoFOB - rSumNetoFOB);
end;

procedure TQRLLiquidacionProvedores.QRGroup1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  iKilosCos := 0;
  rSumBrutoFOB := 0;
  rSumNetoFOB := 0;
end;

procedure TQRLLiquidacionProvedores.lblAjustePrint(sender: TObject;
  var Value: string);
begin
  if bDefinitivo then
    //Value:= 'Defenitivo'
    Value := ''
  else
    Value := 'Simulación';
    //Value:= ' Ajuste del precio FOB : ' + FormatFloat('#,##0.00', AjusteGlobal );
    //Value:= ' Ajuste del precio FOB : ' + FormatFloat('#,##0.00', AjusteGlobal + AjusteCosechero );
end;

procedure TQRLLiquidacionProvedores.porcentaje_totalPrint(sender: TObject;
  var Value: string);
var
  aux: real;
begin
  //if not bTercera then
  //begin
  if iKilosCos = 0 then
  begin
    Value := '';
  end
  else
  begin
    aux := (100 * iSumKilosAprovecha) / iKilosCos;
    if aux = 0 then
      Value := ''
    else
      Value := FormatFloat('#00.00', aux) + '%';
  end;
  //end
  //else
  //begin
  //  Value:= '';
  //end;
end;

procedure TQRLLiquidacionProvedores.PsQRLabel43Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_cat_1);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel85Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_cat_2);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel92Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_cat_3);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel79Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_1);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel88Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_2);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel95Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_3);
end;

procedure TQRLLiquidacionProvedores.VersionDefinitivo(sender: TObject;
  var Value: string);
begin
  if bDefinitivo then
    Value := '';
end;

procedure TQRLLiquidacionProvedores.PsQRLabel36Print(sender: TObject;
  var Value: string);
begin
  if bDefinitivo then
    Value := 'Precio FOB/Kg'
  else
    Value := 'Pr/Kg';
end;

procedure TQRLLiquidacionProvedores.PsQRLabel38Print(sender: TObject;
  var Value: string);
begin
  if bDefinitivo then
    Value := 'Importe FOB'
  else
    Value := 'Neto';
end;

procedure TQRLLiquidacionProvedores.bndPieResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := not bDefinitivo;
end;

procedure TQRLLiquidacionProvedores.bndCabResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := not bDefinitivo;
end;

procedure TQRLLiquidacionProvedores.lFOBPrint(sender: TObject;
  var Value: string);
begin
  if bDefinitivo then
    Value := '';
end;

procedure TQRLLiquidacionProvedores.PsQRDBText6Print(sender: TObject;
  var Value: string);
begin
(*
  if ( rFobReal = 0 ) then
    Value:= '';
  *)
end;

procedure TQRLLiquidacionProvedores.QRLabel28Print(sender: TObject;
  var Value: string);
begin
  if not bDefinitivo then
    Value := FormatFloat('#,##0.000', (rSumBrutoFOB / iSumKilosAprovecha) - (rSumNetoFOB / iSumKilosAprovecha))
  else
    Value := '';
end;

procedure TQRLLiquidacionProvedores.QRLabel30Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', kilos_cat_d);
end;

procedure TQRLLiquidacionProvedores.QRLabel31Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_d);
end;

procedure TQRLLiquidacionProvedores.QRLabel32Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_d - fob_cat_d);
end;

procedure TQRLLiquidacionProvedores.QRLabel33Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', fob_cat_d);
end;

procedure TQRLLiquidacionProvedores.lCatPrint(sender: TObject;
  var Value: string);
begin
  if Value = '4' then
    Value := 'D';
end;

procedure TQRLLiquidacionProvedores.PsQRLabel96Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', fob_cat_3);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel89Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', fob_cat_2);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel82Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', fob_cat_1);
end;

procedure TQRLLiquidacionProvedores.PsQRLabel34Print(sender: TObject;
  var Value: string);
begin
  if bDefinitivo then
    Value := '';
end;

procedure TQRLLiquidacionProvedores.lPorCatPrint(sender: TObject;
  var Value: string);
var
  aux: real;
begin
(*    if QKGSCosechados.FieldByName('kilos_cat').AsFloat = 0 then
    begin
      Value:= '';
    end
    else
    begin
      aux:= ( 100 * QKGSCosechados.FieldByName('kilos_cat').AsFloat ) / QKGSCosechados.FieldByName('aprovechados').AsFloat;
      if aux = 0  then
        Value:= ''
      else
        Value:= FormatFloat('#00.00', aux )+'%';
    end;
*)
  if Value = '0' then Value := ''
  else Value := FormatFloat('#00.00', StrToFloat(Value)) + '%';
end;

end.
