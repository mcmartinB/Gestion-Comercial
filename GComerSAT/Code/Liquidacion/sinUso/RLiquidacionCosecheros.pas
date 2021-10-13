unit RLiquidacionCosecheros;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;
type
  TQRLiquidacionCosecheros = class(TQuickRep)
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
    lFOB: TQRDBText;
    DataSource2: TDataSource;
    QFOB: TQuery;
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
    PsQRLabel12: TQRLabel;
    PsQRLabel13: TQRLabel;
    BandaSeparador: TQRBand;
    PsQRDBText3: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRLabel34: TQRLabel;
    PsQRLabel35: TQRLabel;
    PsQRLabel36: TQRLabel;
    PsQRLabel37: TQRLabel;
    PsQRLabel38: TQRLabel;
    PsQRLabel39: TQRLabel;
    PsQRLabel45: TQRLabel;
    ps_kilos_cat_1: TQRLabel;
    BandaTotales: TQRChildBand;
    PsQRLabel14: TQRLabel;
    PsQRLabel60: TQRLabel;
    lSumKilosAprovecha: TQRExpr;
    MediaPrecioKilo: TQRLabel;
    MediaFOB: TQRLabel;
    PsQRLabel46: TQRLabel;
    lSumImporteFOB: TQRLabel;
    PsQRLabel62: TQRLabel;
    ps_fob_cat_1: TQRLabel;
    ps_bruto_cat_1: TQRLabel;
    porcentaje_total: TQRLabel;
    PsQRLabel59: TQRLabel;
    PsQRLabel64: TQRLabel;
    PsQRLabel66: TQRLabel;
    BandaSegunda: TQRChildBand;
    PsQRLabel63: TQRLabel;
    PsQRLabel61: TQRLabel;
    ps_kilos_cat_2: TQRLabel;
    PsQRLabel67: TQRLabel;
    PsQRLabel65: TQRLabel;
    ps_bruto_cat_2: TQRLabel;
    ps_fob_cat_2: TQRLabel;
    BandaTercera: TQRChildBand;
    PsQRLabel71: TQRLabel;
    PsQRLabel72: TQRLabel;
    PsQRLabel73: TQRLabel;
    PsQRLabel74: TQRLabel;
    PsQRLabel75: TQRLabel;
    PsQRLabel76: TQRLabel;
    PsQRLabel77: TQRLabel;
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
    PsQRLabel86: TQRLabel;
    PsQRLabel87: TQRLabel;
    PsQRLabel91: TQRLabel;
    PsQRLabel93: TQRLabel;
    PsQRLabel94: TQRLabel;
    PsQRLabel98: TQRLabel;
    PsQRLabel99: TQRLabel;
    PsQRLabel100: TQRLabel;
    bndCabResumen: TQRChildBand;
    lblComer: TQRLabel;
    valComer: TQRLabel;
    lblProd: TQRLabel;
    valProd: TQRLabel;
    lblAdmi: TQRLabel;
    valAdmi: TQRLabel;
    PsQRLabel109: TQRLabel;
    PsQRLabel110: TQRLabel;
    PsQRLabel111: TQRLabel;
    PsQRLabel112: TQRLabel;
    lblGastos2: TQRLabel;
    PsQRLabel114: TQRLabel;
    lblGastos: TQRLabel;
    BandaCuarta: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    bnd4Resumen: TQRChildBand;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    lblRComer: TQRLabel;
    lblRProd: TQRLabel;
    lblRAdmi: TQRLabel;
    lblKilos12a: TQRLabel;
    lblKilos12b: TQRLabel;
    lblKilos12c: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    procedure kilosPrint(sender: TObject; var Value: string);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure Porcentaje(sender: TObject; var Value: string);
    procedure lImporteFOBPrint(sender: TObject; var Value: string);
    procedure QRLLiquidacionCosecherosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure lSumImporteFOBPrint(sender: TObject; var Value: string);
    procedure PsQRLabel45Print(sender: TObject; var Value: string);
    procedure PsQRLabel46Print(sender: TObject; var Value: string);
    procedure lSumKilosAprovechaPrint(sender: TObject; var Value: string);
    procedure PsQRLabel60Print(sender: TObject; var Value: string);
    procedure MediaPrecioKiloPrint(sender: TObject; var Value: string);
    procedure MediaFOBPrint(sender: TObject; var Value: string);
    procedure ps_kilos_cat_1Print(sender: TObject; var Value: string);
    procedure ps_kilos_cat_2Print(sender: TObject; var Value: string);
    procedure ps_bruto_cat_1Print(sender: TObject; var Value: string);
    procedure ps_bruto_cat_2Print(sender: TObject; var Value: string);
    procedure ps_fob_cat_1Print(sender: TObject; var Value: string);
    procedure ps_fob_cat_2Print(sender: TObject; var Value: string);
    procedure PsQRLabel59Print(sender: TObject; var Value: string);
    procedure PsQRLabel61Print(sender: TObject; var Value: string);
    procedure BandaSeparadorBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel66Print(sender: TObject; var Value: string);
    procedure PsQRLabel67Print(sender: TObject; var Value: string);
    procedure PsQRLabel64Print(sender: TObject; var Value: string);
    procedure PsQRLabel65Print(sender: TObject; var Value: string);
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure anyoPrint(sender: TObject; var Value: string);
    procedure PsQRLabel72Print(sender: TObject; var Value: string);
    procedure PsQRLabel73Print(sender: TObject; var Value: string);
    procedure PsQRLabel74Print(sender: TObject; var Value: string);
    procedure PsQRLabel75Print(sender: TObject; var Value: string);
    procedure PsQRLabel76Print(sender: TObject; var Value: string);
    procedure PsQRLabel77Print(sender: TObject; var Value: string);
    procedure BandaSegundaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BandaTerceraBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lFOBPrint(sender: TObject; var Value: string);
    procedure PsQRDBText6Print(sender: TObject; var Value: string);
    procedure ChildBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
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
    procedure bndCabResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel86Print(sender: TObject; var Value: string);
    procedure PsQRLabel87Print(sender: TObject; var Value: string);
    procedure PsQRLabel91Print(sender: TObject; var Value: string);
    procedure PsQRLabel94Print(sender: TObject; var Value: string);
    procedure PsQRLabel98Print(sender: TObject; var Value: string);
    procedure PsQRLabel99Print(sender: TObject; var Value: string);
    procedure PsQRLabel93Print(sender: TObject; var Value: string);
    procedure PsQRLabel100Print(sender: TObject; var Value: string);
    procedure valComerPrint(sender: TObject; var Value: string);
    procedure valProdPrint(sender: TObject; var Value: string);
    procedure valAdmiPrint(sender: TObject; var Value: string);
    procedure BandaCuartaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel3Print(sender: TObject; var Value: string);
    procedure QRLabel4Print(sender: TObject; var Value: string);
    procedure QRLabel5Print(sender: TObject; var Value: string);
    procedure QRLabel6Print(sender: TObject; var Value: string);
    procedure QRLabel7Print(sender: TObject; var Value: string);
    procedure QRLabel8Print(sender: TObject; var Value: string);
    procedure QRLabel10Print(sender: TObject; var Value: string);
    procedure QRLabel11Print(sender: TObject; var Value: string);
    procedure QRLabel12Print(sender: TObject; var Value: string);
    procedure QRLabel13Print(sender: TObject; var Value: string);
    procedure QRLabel14Print(sender: TObject; var Value: string);
    procedure QRLabel15Print(sender: TObject; var Value: string);
    procedure bnd4ResumenBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure lCatPrint(sender: TObject; var Value: string);
    procedure PsQRDBText3Print(sender: TObject; var Value: string);
    procedure lblKilos12aPrint(sender: TObject; var Value: string);
    procedure lblRComerPrint(sender: TObject; var Value: string);
    procedure lblRProdPrint(sender: TObject; var Value: string);
    procedure lblRAdmiPrint(sender: TObject; var Value: string);
  private
    QResumen: TQuery;
    //Control
    iSemana, iSemanas: Integer;
    iCosecheros, iCosecherosTotal: Integer;
    bNuevoCosechero: Boolean;

    //Auxiliares
    rFob, rCoste, rFobReal: Real;
    rBrutoFOB, rNetoFOB: Real;
    rImporteNeto: Real;

    //Sumatorios
    iKilosCos: Integer;
    rSumBrutoFOB, rSumNetoFOB: Real;
    iSumKilosAprovecha, iSumKilosAprovecha1, iSumKilosAprovecha2, iSumKilosAprovecha3: Integer;

    //Por categoria
    kilos_cat_1, kilos_cat_2, kilos_cat_3, kilos_cat_4: Integer;
    porcen_cat_1, porcen_cat_2, porcen_cat_3, porcen_cat_4: Real;
    fob_cat_1, fob_cat_2, fob_cat_3, fob_cat_4: Real;
    bruto_cat_1, bruto_cat_2, bruto_cat_3, bruto_cat_4: Real;
    costes_cat1, costes_cat2, costes_cat3, costes_cat4: Real;
    liq_cat1, liq_cat2, liq_cat3, liq_cat4: Real;
    lines_cat_1, lines_cat_2, lines_cat_3, lines_cat_4: integer;

    procedure AnyadeNeto(cos, kcos, kapr, kapr1, kapr2, kapr3: integer; brutoFob, gEnv, netoFob, gGEnv, gCom, gAdm, neto: real);
    function FobAjustado(const AEmpresa, ACosechero, AProducto, AAnyosemana, ACategoria: string;
      const AFob: Real): Real;
  public
    rComercial, rAdministrativo, rProduccion: Real;
    rtComercial, rtAdministrativo, rtProduccion: Real;
    empresa: string;
    UnSoloCosechero: Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  QRLiquidacionCosecheros: TQRLiquidacionCosecheros;

implementation

uses CAuxiliar, Principal, UDMAuxDB, bSQLUtils, bMath, UCosteEnvasadoComunEx,
  bTimeUtils, ULiquidacionComun;

{$R *.DFM}

var
  bAjustarFobCalidad: boolean = true;

function GetAjusteCosFobSemanaEx( const AEmpresa, ACosechero, AProducto, AAnyoSemana, ACategoria: string ): real;
begin
  result:= 1;
(*
  try
    result:= GetAjusteLiq( AEmpresa, StrToInt( ACosechero ), AProducto, StrToInt( AAnyoSemana ), Acategoria );
  except
    result:= 1;
  end;
*)
(*
  if ( AAnyoSemana = '200542' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) and ( ACosechero = '64' ) then
  begin
    if ACategoria = '1' then result:= 1.138;
  end
  else
  if ( AAnyoSemana = '200543' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) and ( ACosechero = '64' ) then
  begin
    if ACategoria = '1' then result:= 1.208;
  end
  else
  if ( AAnyoSemana = '200544' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) and ( ACosechero = '64' ) then
  begin
    if ACategoria = '1' then result:= 1.292;
  end
  else
  if ( AAnyoSemana = '200545' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) then
  begin
    if ACategoria = '1' then
    begin
      if ( ACosechero = '64' ) then
        result:= 1.252
      else
        result:= 0.999;
    end;
  end
  else
  if ( AAnyoSemana = '200546' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) then
  begin
    if ACategoria = '1' then
    begin
      if ( ACosechero > '63' ) then
        result:= 1.163
      else
        result:= 0.999;
    end;
  end
  else
  if ( AAnyoSemana = '200547' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) then
  begin
    if ACategoria = '1' then
    begin
      if ( ACosechero > '63' ) then
        result:= 1.233
      else
        result:= 0.995;
    end;
  end
  else
  if ( AAnyoSemana = '200548' ) and ( AEmpresa = '050' ) and ( AProducto = 'T' ) then
  begin
    if ACategoria = '1' then
    begin
      if ( ACosechero > '63' ) then
        result:= 1.211
      else
        result:= 0.955;
    end;
  end;
*)
end;

function TQRLiquidacionCosecheros.FobAjustado(
  const AEmpresa, ACosechero, AProducto, AAnyosemana, ACategoria: string;
  const AFob: Real): Real;
var
  //rAjustePrimera, rAjusteSegunda, rAjusteResto: Real;
  rAusteCalidad: Real;
begin
  result := AFob;

  if bAjustarFobCalidad then
  begin
    rAusteCalidad:= GetAjusteCosFobSemanaEx(AEmpresa, ACosechero, AProducto, AAnyosemana, ACategoria );
    if rAusteCalidad <> 0 then
      result := bRoundTo(result * rAusteCalidad, -3);
  end;

  (*
  if AplicarAjusteFob(AEmpresa, ACosechero) then
  begin
    GetAjusteCosFobSemana(AEmpresa, ACosechero, AProducto, AAnyosemana, rAjustePrimera, rAjusteSegunda, rAjusteResto);
    if ACategoria = '1' then
      result := bRoundTo(result * (1 - (rAjustePrimera / 100)), -3)
    else
    if ACategoria = '2' then
      result := bRoundTo(result * (1 - (rAjusteSegunda / 100)), -3)
    else
      result := bRoundTo(result * (1 - (rAjusteResto / 100)), -3);
  end;
  *)
end;

procedure TQRLiquidacionCosecheros.AnyadeNeto(cos, kcos, kapr, kapr1, kapr2, kapr3: integer; brutoFob, gEnv, netoFob, gGEnv, gCom, gAdm, neto: real);
begin
  with DMAuxDB, QAux do
  begin
    SQL.Clear;
    SQL.Add(' update tmp_resum_liqui set ' +
      '   (kcos,kapr,kapr1,kapr2,kapr3,brutoFob,gEnv,netoFob,gGEnv,gCom,gAdm,neto)= ' +
      '   (:kcos,:kapr,:kapr1,:kapr2,:kapr3,:brutoFob,:gEnv,:netoFob,:gGEnv,:gCom,:gAdm,:neto) ' +
      ' where cod=:cod ');
    ParamByName('kcos').asinteger := kcos;
    ParamByName('kapr').asinteger := kapr;
    ParamByName('kapr1').asinteger := kapr1;
    ParamByName('kapr2').asinteger := kapr2;
    ParamByName('kapr3').asinteger := kapr3;
    ParamByName('brutoFob').asfloat := brutoFob;
    ParamByName('gEnv').asfloat := gEnv;
    ParamByName('netoFob').asfloat := netoFob;
    ParamByName('gGEnv').asfloat := gGEnv;
    ParamByName('gCom').asfloat := gCom;
    ParamByName('gAdm').asfloat := gAdm;
    ParamByName('neto').asfloat := neto;
    ParamByName('cod').asinteger := cos;
    ExecSql;
  end;
end;

procedure TQRLiquidacionCosecheros.kilosPrint(sender: TObject;
  var Value: string);
var
  aux: real;
begin
  (*BORRAR*)
  aux := StrToFloat(Value);
  {
  if Copy(QKGSCosechados.FieldByName('semana').asString,5,2) = '15' then
  begin
    if QCosecheros.FieldByName('cosechero').AsString = '58' then
      aux := aux + 100
    else
    if QCosecheros.FieldByName('cosechero').AsString = '51' then
      aux := aux - 604
    else
    if QCosecheros.FieldByName('cosechero').AsString = '100' then
      aux := aux - 3754;
  end;
  }
  if aux = 0 then Value := ''
  else Value := FormatFloat('#,##0', aux);
end;

procedure TQRLiquidacionCosecheros.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  rCosteEnv: RCosteEnvasado;
begin
  if QKGSCosechados.FieldByName('semana').asString = '' then Exit;
  if IntToStr(iSemana) <> QKGSCosechados.FieldByName('semana').asString then
  begin
    anyo.Enabled := true;
    kilos.Enabled := true;
    aprovecha.Enabled := true;
    aprovechados.Enabled := true;
    isemana := QKGSCosechados.FieldByName('semana').asinteger;
    Inc(iSemanas);
    ikilosCos := ikilosCos + QKGSCosechados.fieldbyname('kilos').asInteger;
  end
  else
  begin
    anyo.Enabled := False;
    kilos.Enabled := False;
    aprovecha.Enabled := False;
    aprovechados.Enabled := False;
  end;

  rFob := FobAjustado(empresa, QCosecheros.fieldbyname('cosechero').AsString,
    codProducto.Caption, QKGSCosechados.FieldByName('semana').AsString,
    QKGSCosechados.fieldbyname('categoria').AsString, QFOB.fieldbyname('fob').asfloat );


  rCosteEnv := GetCosteMensualEnvasado(empresa,
    codCentro.Caption,
    QCosecheros.fieldbyname('cosechero').AsString,
    codProducto.Caption,
    LunesAnyoSemana(QKGSCosechados.FieldByName('semana').asString));

  if QKGSCosechados.fieldbyname('categoria').AsString = '1' then
  begin
    rCoste := rCosteEnv.CostePrimera;
  end
  else
    if QKGSCosechados.fieldbyname('categoria').AsString = '2' then
    begin
      rCoste := rCosteEnv.CosteSegunda;
    end
    else
      if QKGSCosechados.fieldbyname('categoria').AsString = '3' then
      begin
        rCoste := rCosteEnv.CosteTercera;
      end
      else
        if QKGSCosechados.fieldbyname('categoria').AsString = '4' then
        begin
          rCoste := rCosteEnv.CosteResto;
        end;
  rCoste := bRoundTo(rCoste + QFOB.fieldbyname('coste_envasado').asfloat, -3);

  rFobReal := rFob - rCoste;

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
          kilos_cat_4 := kilos_cat_4 + QKGSCosechados.fieldbyname('kilos_cat').AsInteger;
          fob_cat_4 := fob_cat_4 + rNetoFOB;
          bruto_cat_4 := bruto_cat_4 + rBrutoFOB;
          lines_cat_4 := lines_cat_4 + 1;
        end;
end;

procedure TQRLiquidacionCosecheros.Porcentaje(sender: TObject;
  var Value: string);
begin
  if Value = '0' then Value := ''
  else Value := FormatFloat('#00.00', StrToFloat(Value)) + '%';
end;

procedure TQRLiquidacionCosecheros.lImporteFOBPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', rNetoFOB);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel45Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', rBrutoFOB);
end;

procedure TQRLiquidacionCosecheros.QRLLiquidacionCosecherosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  bNuevoCosechero := true;
  iCosecheros := 0;
  iCosecherosTotal := QCosecheros.RecordCount;

  kilos_cat_1 := 0;
  kilos_cat_2 := 0;
  kilos_cat_3 := 0;
  kilos_cat_4 := 0;
  porcen_cat_1 := 0;
  porcen_cat_2 := 0;
  porcen_cat_3 := 0;
  porcen_cat_4 := 0;
  fob_cat_1 := 0;
  fob_cat_2 := 0;
  fob_cat_3 := 0;
  fob_cat_4 := 0;
  bruto_cat_1 := 0;
  bruto_cat_2 := 0;
  bruto_cat_3 := 0;
  bruto_cat_4 := 0;
  costes_cat1 := 0;
  costes_cat2 := 0;
  costes_cat3 := 0;
  costes_cat4 := 0;
  liq_cat1 := 0;
  liq_cat2 := 0;
  liq_cat3 := 0;
  liq_cat4 := 0;
  lines_cat_1 := 0;
  lines_cat_2 := 0;
  lines_cat_3 := 0;
  lines_cat_4 := 0;
end;

procedure TQRLiquidacionCosecheros.DetailBand1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  bNuevoCosechero := False;
  Inc(iCosecheros);

  iSemana := -1;
  iSemanas := 0;

  iKilosCos := 0;
  rSumBrutoFOB := 0;
  rSumNetoFOB := 0;
end;

procedure TQRLiquidacionCosecheros.lSumImporteFOBPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', rSumNetoFOB);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel46Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', rSumBrutoFOB);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel60Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', iKilosCos);
end;

procedure TQRLiquidacionCosecheros.lSumKilosAprovechaPrint(sender: TObject;
  var Value: string);
var
  aux: real;
begin
  iSumKilosAprovecha := Redondea(StrToFloat(Value));

  (*BORRAR*)
  {
  if QCosecheros.FieldByName('cosechero').AsString = '58' then
    aux := iSumKilosAprovecha + 100
  else
  if QCosecheros.FieldByName('cosechero').AsString = '51' then
    aux := iSumKilosAprovecha - 604
  else
  if QCosecheros.FieldByName('cosechero').AsString = '100' then
    aux := iSumKilosAprovecha - 3754
  else
  }
  aux := iSumKilosAprovecha;

  Value := FormatFloat('#,##0', aux);

  //Procentaje
  if iKilosCos <> 0 then
  begin
    porcentaje_total.caption := Formatfloat('#00.00',
      porcen_cat_1 + porcen_cat_2 + porcen_cat_3 + porcen_cat_4) + '%';
  end
  else
    porcentaje_total.Caption := '';
end;

procedure TQRLiquidacionCosecheros.MediaPrecioKiloPrint(sender: TObject;
  var Value: string);
begin
  if iSumKilosAprovecha <> 0 then
    Value := FormatFloat('#,##0.000', rSumBrutoFOB / iSumKilosAprovecha)
  else
    Value := '';
end;

procedure TQRLiquidacionCosecheros.MediaFOBPrint(sender: TObject;
  var Value: string);
begin
  if iSumKilosAprovecha <> 0 then
    Value := FormatFloat('#,##0.000', rSumNetoFOB / iSumKilosAprovecha)
  else
    Value := '';
end;

procedure TQRLiquidacionCosecheros.ps_kilos_cat_1Print(sender: TObject;
  var Value: string);
begin
  iSumKilosAprovecha1:= kilos_cat_1;
  Value := FormatFloat('#,##0', kilos_cat_1);
end;

procedure TQRLiquidacionCosecheros.ps_kilos_cat_2Print(sender: TObject;
  var Value: string);
begin
  iSumKilosAprovecha2:= kilos_cat_2;
  Value := FormatFloat('#,##0', kilos_cat_2);
end;

procedure TQRLiquidacionCosecheros.ps_bruto_cat_1Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_1);
end;

procedure TQRLiquidacionCosecheros.ps_bruto_cat_2Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_2);
end;

procedure TQRLiquidacionCosecheros.ps_fob_cat_1Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', fob_cat_1);
end;

procedure TQRLiquidacionCosecheros.ps_fob_cat_2Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', fob_cat_2);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel59Print(sender: TObject;
  var Value: string);
begin
  if lines_cat_1 = 0 then
  begin
    Value := '';
    porcen_cat_1 := 0;
  end
  else
  begin
    porcen_cat_1 := Redondea(kilos_cat_1 * 100 / iKilosCos, 2);
    Value := FormatFloat('#00.00', porcen_cat_1) + '%';
  end;
end;

procedure TQRLiquidacionCosecheros.PsQRLabel61Print(sender: TObject;
  var Value: string);
begin
  if lines_cat_2 = 0 then
  begin
    Value := '';
    porcen_cat_2 := 0;
  end
  else
  begin
    porcen_cat_2 := Redondea(kilos_cat_2 * 100 / iKilosCos, 2);
    Value := FormatFloat('#00.00', porcen_cat_2) + '%';
  end;
end;

procedure TQRLiquidacionCosecheros.BandaSeparadorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  iSumKilosAprovecha1:= kilos_cat_1;
  PrintBand := (lines_cat_1 <> 0) and ((lines_cat_1 + lines_cat_2 + lines_cat_3) <> 0);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel66Print(sender: TObject;
  var Value: string);
begin
  if (lines_cat_1 = 0 ) or ( kilos_cat_1 = 0 ) then Value := ''
  else Value := FormatFloat('#,##0.000', bruto_cat_1 / kilos_cat_1);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel67Print(sender: TObject;
  var Value: string);
begin
  if ( lines_cat_2 = 0 ) or ( kilos_cat_2 = 0 )then Value := ''
  else Value := FormatFloat('#,##0.000', bruto_cat_2 / kilos_cat_2);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel64Print(sender: TObject;
  var Value: string);
begin
  if ( lines_cat_1 = 0 ) or ( kilos_cat_1 = 0 )then Value := ''
  else Value := FormatFloat('#,##0.000', fob_cat_1 / kilos_cat_1);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel65Print(sender: TObject;
  var Value: string);
begin
  if ( lines_cat_2 = 0 ) or ( kilos_cat_2 = 0 ) then Value := ''
  else Value := FormatFloat('#,##0.000', fob_cat_2 / kilos_cat_2);
end;

procedure TQRLiquidacionCosecheros.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  Value := Trim(Value);
end;

procedure TQRLiquidacionCosecheros.anyoPrint(sender: TObject;
  var Value: string);
begin
  Value := Copy(Value, 1, 4) + ' ' + Copy(Value, 5, 2);
end;

constructor TQRLiquidacionCosecheros.Create(AOwner: TComponent);
begin
  inherited;
  QResumen := TQuery.Create(nil);
  QResumen.DataBaseName := 'BDProyecto';
  UnSoloCosechero := False;
end;

destructor TQRLiquidacionCosecheros.Destroy;
begin
  FreeAndNil(QResumen);
  inherited;
end;

procedure TQRLiquidacionCosecheros.PsQRLabel72Print(sender: TObject;
  var Value: string);
begin
  if lines_cat_3 = 0 then
  begin
    Value := '';
    porcen_cat_3 := 0;
  end
  else
  begin
    porcen_cat_3 := Redondea(kilos_cat_3 * 100 / iKilosCos, 2);
    Value := FormatFloat('#00.00', porcen_cat_3) + '%';
  end;
end;

procedure TQRLiquidacionCosecheros.PsQRLabel73Print(sender: TObject;
  var Value: string);
begin
  iSumKilosAprovecha3:= kilos_cat_3;
  Value := FormatFloat('#,##0', kilos_cat_3);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel74Print(sender: TObject;
  var Value: string);
begin
  if lines_cat_3 = 0 then Value := ''
  else
  begin
    if kilos_cat_3 = 0 then
      Value := '0'
    else
      Value := FormatFloat('#,##0.000', bruto_cat_3 / kilos_cat_3);
  end;
end;

procedure TQRLiquidacionCosecheros.PsQRLabel75Print(sender: TObject;
  var Value: string);
begin
  if lines_cat_3 = 0 then Value := ''
  else
  begin
    if kilos_cat_3 = 0 then
      Value := '0'
    else
      Value := FormatFloat('#,##0.000', fob_cat_3 / kilos_cat_3);
  end;
end;

procedure TQRLiquidacionCosecheros.PsQRLabel76Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_3);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel77Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', fob_cat_3);
end;

procedure TQRLiquidacionCosecheros.BandaSegundaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  iSumKilosAprovecha2:= 0;
  PrintBand := (lines_cat_2 <> 0) and ((lines_cat_1 + lines_cat_2 + lines_cat_3) <> 0);
end;

procedure TQRLiquidacionCosecheros.BandaTerceraBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := (lines_cat_3 <> 0) and ((lines_cat_1 + lines_cat_2 + lines_cat_3) <> 0);
end;

procedure TQRLiquidacionCosecheros.lFOBPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', rFob);
end;

procedure TQRLiquidacionCosecheros.PsQRDBText3Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', rCoste);
end;

procedure TQRLiquidacionCosecheros.PsQRDBText6Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.000', rFobReal);
end;

procedure TQRLiquidacionCosecheros.ChildBand5BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := not bNuevoCosechero;
end;

procedure TQRLiquidacionCosecheros.bnd1ResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := (lines_cat_1 <> 0) and ((lines_cat_1 + lines_cat_2 + lines_cat_3) <> 0);
end;

procedure TQRLiquidacionCosecheros.bnd2ResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := (lines_cat_2 <> 0) and ((lines_cat_1 + lines_cat_2 + lines_cat_3) <> 0);
end;

procedure TQRLiquidacionCosecheros.bnd3ResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := (lines_cat_3 <> 0) and ((lines_cat_1 + lines_cat_2 + lines_cat_3) <> 0);
end;

procedure TQRLiquidacionCosecheros.bndPieResumenAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  AnyadeNeto(
    QCosecheros.FieldByName('cosechero').asinteger,
    iKilosCos,
    iSumKilosAprovecha,
    iSumKilosAprovecha1,
    iSumKilosAprovecha2,
    iSumKilosAprovecha3,
    rSumBrutoFOB,
    rSumBrutoFOB - rSumNetoFOB,
    rSumNetoFOB,
    rtComercial,
    rtProduccion,
    rtAdministrativo,
    rImporteNeto);

  iKilosCos:= 0;
  iSumKilosAprovecha:= 0;
  iSumKilosAprovecha1:= 0;
  iSumKilosAprovecha2:= 0;
  iSumKilosAprovecha3:= 0;
  rSumBrutoFOB:= 0;
  rSumNetoFOB:= 0;
  rtComercial:= 0;
  rtProduccion:= 0;
  rtAdministrativo:= 0;
  rImporteNeto:= 0;

  kilos_cat_1 := 0;
  kilos_cat_2 := 0;
  kilos_cat_3 := 0;
  kilos_cat_4 := 0;
  porcen_cat_1 := 0;
  porcen_cat_2 := 0;
  porcen_cat_3 := 0;
  porcen_cat_4 := 0;
  fob_cat_1 := 0;
  fob_cat_2 := 0;
  fob_cat_3 := 0;
  fob_cat_4 := 0;
  bruto_cat_1 := 0;
  bruto_cat_2 := 0;
  bruto_cat_3 := 0;
  bruto_cat_4 := 0;
  costes_cat1 := 0;
  costes_cat2 := 0;
  costes_cat3 := 0;
  costes_cat4 := 0;
  liq_cat1 := 0;
  liq_cat2 := 0;
  liq_cat3 := 0;
  liq_cat4 := 0;
  lines_cat_1 := 0;
  lines_cat_2 := 0;
  lines_cat_3 := 0;
  lines_cat_4 := 0;

  //Nueva Pagina
  if iCosecheros < iCosecherosTotal then
    QRLiquidacionCosecheros.NewPage;
end;

procedure TQRLiquidacionCosecheros.PsQRLabel42Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_1 - fob_cat_1);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel44Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_2 - fob_cat_2);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel78Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_3 - fob_cat_3);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel84Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', rSumBrutoFOB - rSumNetoFOB);
end;

procedure TQRLiquidacionCosecheros.bndCabResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  costes , aux: real;
begin
  (* SÓLO PRIMERA Y SEGUNDA
  rtAdministrativo:=redondea(rAdministrativo*iSumKilosAprovecha,2);
  rtComercial:=redondea(rComercial*iSumKilosAprovecha,2);
  rtProduccion:=redondea(rProduccion*iSumKilosAprovecha,2);
  rImporteNeto:=rSumNetoFOB-rtAdministrativo-rtComercial-rtProduccion;
  *)
  rtAdministrativo := redondea(rAdministrativo * (kilos_cat_1 + kilos_cat_2), 2);
  rtComercial := redondea(rComercial * (kilos_cat_1 + kilos_cat_2), 2);
  rtProduccion := redondea(rProduccion * (kilos_cat_1 + kilos_cat_2), 2);
  rImporteNeto := rSumNetoFOB - rtAdministrativo - rtComercial - rtProduccion;

  (*if rtAdministrativo + rtComercial + rtProduccion = 0 then
  begin
    lblGastos.Enabled:= false;
    lblGastos2.Enabled:= false;
    lblComer.Enabled:= false;
    lblAdmi.Enabled:= false;
    lblProd.Enabled:= false;
  end;*)

  aux:= (kilos_cat_1 + kilos_cat_2);
  costes := rtProduccion + rtComercial + rtAdministrativo;
  if aux <> 0 then
  begin
    costes_cat1 := redondea(costes * kilos_cat_1 / aux , 2);
    costes_cat2 := redondea(costes * kilos_cat_2 / aux, 2);
  end
  else
  begin
    costes_cat1 := 0;
    costes_cat2 := 0;
  end;
  costes_cat3 := 0;
  costes_cat4 := 0;
  costes_cat1 := costes_cat1 + (costes - (costes_cat1 + costes_cat2 + costes_cat3 + costes_cat4));

  liq_cat1 := fob_cat_1 - costes_cat1;
  liq_cat2 := fob_cat_2 - costes_cat2;
  liq_cat3 := fob_cat_3 - costes_cat3;
  liq_cat4 := fob_cat_4 - costes_cat4;

  bNuevoCosechero := True;
end;

procedure TQRLiquidacionCosecheros.PsQRLabel86Print(sender: TObject;
  var Value: string);
begin
  if costes_cat1 = 0 then
    Value := ''
  else
    Value := FormatFloat('#,##0.00', costes_cat1);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel87Print(sender: TObject;
  var Value: string);
begin
  if costes_cat2 = 0 then
    Value := ''
  else
    Value := FormatFloat('#,##0.00', costes_cat2);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel91Print(sender: TObject;
  var Value: string);
begin
  if costes_cat3 = 0 then
    Value := ''
  else
    Value := FormatFloat('#,##0.00', costes_cat3);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel94Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', liq_cat1);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel98Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', liq_cat2);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel99Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', liq_cat3);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel93Print(sender: TObject;
  var Value: string);
begin
  if costes_cat1 + costes_cat2 + costes_cat3 + costes_cat4 = 0 then
    Value := ''
  else
    Value := FormatFloat('#,##0.00', costes_cat1 + costes_cat2 + costes_cat3 + costes_cat4);
end;

procedure TQRLiquidacionCosecheros.PsQRLabel100Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', liq_cat1 + liq_cat2 + liq_cat3 + liq_cat4);
end;

procedure TQRLiquidacionCosecheros.valComerPrint(sender: TObject;
  var Value: string);
begin
(*  if rtComercial = 0 then
    Value:= ''
  else
*)
  Value := FormatFloat('#,##0.00', rtComercial);
end;

procedure TQRLiquidacionCosecheros.valProdPrint(sender: TObject;
  var Value: string);
begin
(*
  if rtProduccion = 0 then
    Value:= ''
  else
*)
  Value := FormatFloat('#,##0.00', rtProduccion);
end;

procedure TQRLiquidacionCosecheros.valAdmiPrint(sender: TObject;
  var Value: string);
begin
(*  if rtAdministrativo = 0 then
    Value:= ''
  else
*)
  Value := FormatFloat('#,##0.00', rtAdministrativo);
end;

procedure TQRLiquidacionCosecheros.BandaCuartaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := lines_cat_4 <> 0;
end;

procedure TQRLiquidacionCosecheros.QRLabel3Print(sender: TObject;
  var Value: string);
begin
  if lines_cat_4 = 0 then
  begin
    Value := '';
    porcen_cat_4 := 0;
  end
  else
  begin
    porcen_cat_4 := Redondea(kilos_cat_4 * 100 / iKilosCos, 2);
    Value := FormatFloat('#00.00', porcen_cat_4) + '%';
  end;
end;

procedure TQRLiquidacionCosecheros.QRLabel4Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', kilos_cat_4);
end;

procedure TQRLiquidacionCosecheros.QRLabel5Print(sender: TObject;
  var Value: string);
begin
  if (lines_cat_4 = 0) or (kilos_cat_4 = 0) then Value := ''
  else Value := FormatFloat('#,##0.000', bruto_cat_4 / kilos_cat_4);
end;

procedure TQRLiquidacionCosecheros.QRLabel6Print(sender: TObject;
  var Value: string);
begin
  if (lines_cat_4 = 0) or (kilos_cat_4 = 0) then Value := ''
  else Value := FormatFloat('#,##0.000', fob_cat_4 / kilos_cat_4);
end;

procedure TQRLiquidacionCosecheros.QRLabel7Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_4);
end;

procedure TQRLiquidacionCosecheros.QRLabel8Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', fob_cat_4);
end;

procedure TQRLiquidacionCosecheros.QRLabel10Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', kilos_cat_4);
end;

procedure TQRLiquidacionCosecheros.QRLabel11Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_4);
end;

procedure TQRLiquidacionCosecheros.QRLabel12Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', bruto_cat_4 - fob_cat_4);
end;

procedure TQRLiquidacionCosecheros.QRLabel13Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', fob_cat_4);
end;

procedure TQRLiquidacionCosecheros.QRLabel14Print(sender: TObject;
  var Value: string);
begin
  if costes_cat4 = 0 then
    Value := ''
  else
    Value := FormatFloat('#,##0.00', costes_cat4);
end;

procedure TQRLiquidacionCosecheros.QRLabel15Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', liq_cat4);
end;

procedure TQRLiquidacionCosecheros.bnd4ResumenBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := (lines_cat_4 <> 0);
end;

procedure TQRLiquidacionCosecheros.lCatPrint(sender: TObject;
  var Value: string);
begin
  if Value = '4' then
    Value := 'D';
end;

procedure TQRLiquidacionCosecheros.lblKilos12aPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', kilos_cat_1 + kilos_cat_2);
end;

procedure TQRLiquidacionCosecheros.lblRComerPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#0.0000', rComercial);
end;

procedure TQRLiquidacionCosecheros.lblRProdPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#0.0000', rProduccion);
end;

procedure TQRLiquidacionCosecheros.lblRAdmiPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#0.0000', rAdministrativo);
end;

end.

