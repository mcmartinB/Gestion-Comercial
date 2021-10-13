unit RLiquidacionSinValorar;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;
type
  TQRLiquidacionSinValorar = class(TQuickRep)
    CabeceraPagina: TQRBand;
    PiePagina: TQRBand;
    QRLabel1: TQRLabel;
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
    DetailBand1: TQRBand;
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
    BandaSeparador: TQRBand;
    BandaSegunda: TQRChildBand;
    ChildBand5: TQRChildBand;
    PsQRLabel16: TQRLabel;
    PsQRLabel17: TQRLabel;
    PsQRLabel18: TQRLabel;
    PsQRLabel19: TQRLabel;
    PsQRLabel20: TQRLabel;
    PsQRLabel21: TQRLabel;
    PsQRLabel22: TQRLabel;
    PsQRLabel23: TQRLabel;
    PsQRLabel29: TQRLabel;
    PsQRLabel30: TQRLabel;
    PsQRLabel31: TQRLabel;
    PsQRLabel32: TQRLabel;
    PsQRLabel33: TQRLabel;
    PsQRLabel40: TQRLabel;
    PsQRLabel109: TQRLabel;
    PsQRLabel41: TQRLabel;
    PsQRLabel83: TQRLabel;
    PsQRLabel90: TQRLabel;
    PsQRLabel97: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QCosecherosCount: TQuery;
    ps_kilos_cat_1: TQRLabel;
    PsQRLabel59: TQRLabel;
    ps_kilos_cat_2: TQRLabel;
    PsQRLabel61: TQRLabel;
    PsQRLabel73: TQRLabel;
    PsQRLabel72: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    lSumKilosAprovecha: TQRExpr;
    porcentaje_total: TQRLabel;
    PsQRLabel60: TQRLabel;
    procedure kilosPrint(sender: TObject; var Value: string);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Porcentaje(sender: TObject; var Value: string);
    procedure QRLLiquidacionCosecherosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure lSumKilosAprovechaPrint(sender: TObject; var Value: string);
    procedure PsQRLabel60Print(sender: TObject; var Value: string);
    procedure ps_kilos_cat_1Print(sender: TObject; var Value: string);
    procedure ps_kilos_cat_2Print(sender: TObject; var Value: string);
    procedure PsQRLabel59Print(sender: TObject; var Value: string);
    procedure PsQRLabel61Print(sender: TObject; var Value: string);
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure anyoPrint(sender: TObject; var Value: string);
    procedure PsQRLabel72Print(sender: TObject; var Value: string);
    procedure PsQRLabel73Print(sender: TObject; var Value: string);
    procedure ChildBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel2Print(sender: TObject; var Value: string);
    procedure QRLabel3Print(sender: TObject; var Value: string);
    procedure lCatPrint(sender: TObject; var Value: string);
    procedure BandaSegundaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BandaSeparadorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    //Control
    iSemana: Integer;
    iCosecheros, iCosecherosTotal: Integer;
    bNuevoCosechero: Boolean;

    //Sumatorios
    iKilosCos: Integer;

    //Por categoria
    kilos_cat_1, kilos_cat_2, kilos_cat_3, kilos_cat_4: Integer;
    porcen_cat_1, porcen_cat_2, porcen_cat_3, porcen_cat_4: Real;

  public
    empresa: string;

  end;

var
  QRLiquidacionSinValorar: TQRLiquidacionSinValorar;

implementation

uses CAuxiliar, Principal, UDMAuxDB, bSQLUtils, bMath,
  bTimeUtils, UDMBaseDatos, Forms, CReportes;

{$R *.DFM}

procedure TQRLiquidacionSinValorar.kilosPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', StrToFloat(Value));
end;

procedure TQRLiquidacionSinValorar.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if QKGSCosechados.FieldByName('semana').asString = '' then Exit;
  if IntToStr(iSemana) <> QKGSCosechados.FieldByName('semana').asString then
  begin
    anyo.Enabled := true;
    kilos.Enabled := true;
    aprovecha.Enabled := true;
    aprovechados.Enabled := true;
    isemana := QKGSCosechados.FieldByName('semana').asinteger;
    ikilosCos := ikilosCos + QKGSCosechados.fieldbyname('kilos').asInteger;
  end
  else
  begin
    anyo.Enabled := False;
    kilos.Enabled := False;
    aprovecha.Enabled := False;
    aprovechados.Enabled := False;
  end;

  if QKGSCosechados.fieldbyname('categoria').AsString = '1' then
  begin
    kilos_cat_1 := kilos_cat_1 + QKGSCosechados.fieldbyname('kilos_cat').AsInteger;
  end
  else
  if QKGSCosechados.fieldbyname('categoria').AsString = '2' then
  begin
    kilos_cat_2 := kilos_cat_2 + QKGSCosechados.fieldbyname('kilos_cat').AsInteger;
  end
  else
  if QKGSCosechados.fieldbyname('categoria').AsString = '3' then
  begin
    kilos_cat_3 := kilos_cat_3 + QKGSCosechados.fieldbyname('kilos_cat').AsInteger;
  end
  else
  if QKGSCosechados.fieldbyname('categoria').AsString = '4' then
  begin
    kilos_cat_4 := kilos_cat_4 + QKGSCosechados.fieldbyname('kilos_cat').AsInteger;
  end;
end;

procedure TQRLiquidacionSinValorar.Porcentaje(sender: TObject;
  var Value: string);
begin
  if Value = '0' then Value := ''
  else Value := FormatFloat('#0.00', StrToFloat(Value)) + '%';
end;

procedure TQRLiquidacionSinValorar.QRLLiquidacionCosecherosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  bNuevoCosechero := true;
  iCosecheros := 0;
  iCosecherosTotal := QCosecherosCount.Fields[0].AsInteger;

  kilos_cat_1 := 0;
  kilos_cat_2 := 0;
  kilos_cat_3 := 0;
  kilos_cat_4 := 0;
  porcen_cat_1 := 0;
  porcen_cat_2 := 0;
  porcen_cat_3 := 0;
  porcen_cat_4 := 0;

end;

procedure TQRLiquidacionSinValorar.DetailBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  bNuevoCosechero := False;
  Inc(iCosecheros);

  iSemana := -1;
  iKilosCos := 0;
 end;

procedure TQRLiquidacionSinValorar.PsQRLabel60Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', iKilosCos);
end;

procedure TQRLiquidacionSinValorar.lSumKilosAprovechaPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', Redondea(StrToFloat(Value)));

  //Procentaje
  if iKilosCos <> 0 then
  begin
    porcentaje_total.caption := Formatfloat('#0.00',
      porcen_cat_1 + porcen_cat_2 + porcen_cat_3 + porcen_cat_4) + '%';
  end
  else
    porcentaje_total.Caption := '';
end;

procedure TQRLiquidacionSinValorar.ps_kilos_cat_1Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', kilos_cat_1);
end;

procedure TQRLiquidacionSinValorar.ps_kilos_cat_2Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', kilos_cat_2);
end;

procedure TQRLiquidacionSinValorar.PsQRLabel59Print(sender: TObject;
  var Value: string);
begin
  if iKilosCos = 0 then
  begin
    Value := '';
  end
  else
  begin
    porcen_cat_1 := Redondea(kilos_cat_1 * 100 / iKilosCos, 2);
    Value := FormatFloat('#0.00', porcen_cat_1) + '%';
  end;
end;

procedure TQRLiquidacionSinValorar.PsQRLabel61Print(sender: TObject;
  var Value: string);
begin
  if iKilosCos = 0 then
  begin
    Value := '';
  end
  else
  begin
    porcen_cat_2 := Redondea(kilos_cat_2 * 100 / iKilosCos, 2);
    Value := FormatFloat('#0.00', porcen_cat_2) + '%';
  end;
end;

procedure TQRLiquidacionSinValorar.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  Value := Trim(Value);
end;

procedure TQRLiquidacionSinValorar.anyoPrint(sender: TObject;
  var Value: string);
begin
  Value := Copy(Value, 1, 4) + ' ' + Copy(Value, 5, 2);
end;

procedure TQRLiquidacionSinValorar.PsQRLabel72Print(sender: TObject;
  var Value: string);
begin
  if iKilosCos = 0 then
  begin
    Value := '';
  end
  else
  begin
    porcen_cat_3 := Redondea(kilos_cat_3 * 100 / iKilosCos, 2);
    Value := FormatFloat('#0.00', porcen_cat_3) + '%';
  end;
end;

procedure TQRLiquidacionSinValorar.PsQRLabel73Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', kilos_cat_3);
end;

procedure TQRLiquidacionSinValorar.ChildBand5BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := not bNuevoCosechero;
end;

procedure TQRLiquidacionSinValorar.BandaSegundaAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  kilos_cat_1 := 0;
  kilos_cat_2 := 0;
  kilos_cat_3 := 0;
  kilos_cat_4 := 0;
  porcen_cat_1 := 0;
  porcen_cat_2 := 0;
  porcen_cat_3 := 0;
  porcen_cat_4 := 0;

  if iCosecheros < iCosecherosTotal then
  begin
    NewPage;
  end;
end;

procedure TQRLiquidacionSinValorar.BandaSeparadorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  bNuevoCosechero := True;
end;

procedure TQRLiquidacionSinValorar.QRLabel2Print(sender: TObject;
  var Value: string);
begin
  if iKilosCos = 0 then
  begin
    Value := '';
  end
  else
  begin
    porcen_cat_4 := Redondea(kilos_cat_4 * 100 / iKilosCos, 2);
    Value := FormatFloat('#0.00', porcen_cat_4) + '%';
  end;
end;

procedure TQRLiquidacionSinValorar.QRLabel3Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', kilos_cat_4);
end;

procedure TQRLiquidacionSinValorar.lCatPrint(sender: TObject;
  var Value: string);
begin
  if Value = '4' then
    Value := 'D';
end;

end.

