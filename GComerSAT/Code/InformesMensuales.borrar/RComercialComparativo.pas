unit RComercialComparativo;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TqrpComercialComparativo = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    Titulo: TQRLabel;
    PageFooterBand1: TQRBand;
    QVentasActual: TQuery;
    QVentasAnterior: TQuery;
    SemanaDetail: TQRSubDetail;
    PsQRDBText1: TQRDBText;
    lblKilosActual: TQRDBText;
    lblEurosActual: TQRDBText;
    lblKilosAnterior: TQRDBText;
    lblEurosAnterior: TQRDBText;
    lblPromedioActual: TQRLabel;
    lblPromedioAnterior: TQRLabel;
    lblDifPromedio: TQRLabel;
    lblDifKilos: TQRLabel;
    lblDifEuros: TQRLabel;
    QRPieSemana: TQRBand;
    lblAPromedioActual: TQRLabel;
    lblAPromedioAnterior: TQRLabel;
    lblADifKilos: TQRLabel;
    lblADifEuros: TQRLabel;
    lblADifPromedio: TQRLabel;
    lblAKilosAnterior: TQRLabel;
    lblAEurosAnterior: TQRLabel;
    lblAKilosActual: TQRLabel;
    lblAEurosActual: TQRLabel;
    QAActual: TQuery;
    QAAnterior: TQuery;
    cabSemana: TQRBand;
    lblPKilosActual: TQRLabel;
    lblPEurosActual: TQRLabel;
    lblPKilosAnterior: TQRLabel;
    lblPEurosAnterior: TQRLabel;
    lblPPromedioActual: TQRLabel;
    lblPPromedioAnterior: TQRLabel;
    lblPDifKilos: TQRLabel;
    lblPDifEuros: TQRLabel;
    lblPDifPromedio: TQRLabel;
    ChildBand1: TQRChildBand;
    ChildBand3: TQRChildBand;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    ChildBand4: TQRChildBand;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLabel9: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    PsQRLabel12: TQRLabel;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    PsQRLabel15: TQRLabel;
    AnyoAnterior: TQRLabel;
    AnyoActual: TQRLabel;
    lblCentro: TQRLabel;
    lblProducto: TQRLabel;
    GrupoDetalle: TQRSubDetail;
    QEntradasActual: TQuery;
    QEntradasAnterior: TQuery;
    lblGEntradaActual: TQRLabel;
    lblGEntradaAnterior: TQRLabel;
    lblGDifEntrada: TQRLabel;
    cabGrupo: TQRBand;
    pieGrupo: TQRBand;
    ChildBand5: TQRChildBand;
    lblAGEntradaActual: TQRLabel;
    lblAGEntradaAnterior: TQRLabel;
    lblAGDifEntrada: TQRLabel;
    lblPGEntradaActual: TQRLabel;
    lblPGEntradaAnterior: TQRLabel;
    lblPGDifEntrada: TQRLabel;
    ChildBand6: TQRChildBand;
    lblTGEntradaActual: TQRLabel;
    lblTGEntradaAnterior: TQRLabel;
    lblTGDifEntrada: TQRLabel;
    lblCosecheroGrupo: TQRLabel;
    AjenoDetalle: TQRSubDetail;
    ChildBand7: TQRChildBand;
    ChildBand8: TQRChildBand;
    lblAAEntradaActual: TQRLabel;
    lblAAEntradaAnterior: TQRLabel;
    lblAADifEntrada: TQRLabel;
    lblPAEntradaActual: TQRLabel;
    lblPAEntradaAnterior: TQRLabel;
    lblPADifEntrada: TQRLabel;
    lblAEntradaActual: TQRLabel;
    lblAEntradaAnterior: TQRLabel;
    lblADifEntrada: TQRLabel;
    lblCosecheroAjeno: TQRLabel;
    ChildBand9: TQRChildBand;
    lblAcumCosecheroAjeno: TQRLabel;
    lblTotalCosecheroAjeno: TQRLabel;
    PsQRLabel16: TQRLabel;
    PsQRLabel17: TQRLabel;
    PsQRLabel18: TQRLabel;
    pieAjeno: TQRBand;
    ChildBand10: TQRChildBand;
    ChildBand11: TQRChildBand;
    PsQRLabel19: TQRLabel;
    lblTotalPeriodoActual: TQRLabel;
    lblTotalPeriodoAnterior: TQRLabel;
    lblDifPeriodo: TQRLabel;
    PsQRLabel23: TQRLabel;
    lblTotalAcumuladoActual: TQRLabel;
    lblTotalAcumuladoAnterior: TQRLabel;
    lblDifAcumulado: TQRLabel;
    AnyoActual2: TQRLabel;
    AnyoAnterior2: TQRLabel;
    PsQRLabel22: TQRLabel;
    Titulo2: TQRLabel;
    PsQRLabel4: TQRLabel;
    lblTKilosActual: TQRLabel;
    lblTEurosActual: TQRLabel;
    lblTPromedioActual: TQRLabel;
    lblTKilosAnterior: TQRLabel;
    lblTEurosAnterior: TQRLabel;
    lblTPromedioAnterior: TQRLabel;
    lblTDifKilos: TQRLabel;
    lblTDifEuros: TQRLabel;
    lblTDifPromedio: TQRLabel;
    ChildBand2: TQRChildBand;
    lblCampanya: TQRLabel;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRShape3: TQRShape;
    PsQRShape4: TQRShape;
    PsQRShape5: TQRShape;
    PsQRShape6: TQRShape;
    PsQRShape7: TQRShape;
    PsQRShape8: TQRShape;
    lblEuros: TQRLabel;
    PsQRSysData1: TQRSysData;
    procedure SemanaDetailNeedData(Sender: TObject; var MoreData: Boolean);
    procedure SemanaDetailAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure PsQRDBText1Print(sender: TObject; var Value: string);
    procedure lblKilosActualPrint(sender: TObject; var Value: string);
    procedure lblEurosActualPrint(sender: TObject; var Value: string);
    procedure lblKilosAnteriorPrint(sender: TObject; var Value: string);
    procedure lblEurosAnteriorPrint(sender: TObject; var Value: string);
    procedure SemanaDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRPieSemanaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cabSemanaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure GrupoDetalleNeedData(Sender: TObject; var MoreData: Boolean);
    procedure GrupoDetalleAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure ChildBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure GrupoDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure pieGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand6BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure AjenoDetalleNeedData(Sender: TObject; var MoreData: Boolean);
    procedure AjenoDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure AjenoDetalleAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure pieAjenoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cabGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRLabel3Print(sender: TObject; var Value: string);
    procedure ChildBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    bCortar, bQuedan: boolean;

    sEmpresa: string;
    sCentro: string;
    sProducto: string;
    iAnyo: integer;
    iMesDesde: integer;
    iMesHasta: integer;

    inicioActual, finActual, campanyaActual: TDate;
    inicioAnterior, finAnterior, campanyaAnterior: TDate;

    iAccion: Integer;
    iActual, iAnterior: integer;

    nActual, nAnterior: integer;
    aKilosActual, aKilosAnterior: real;
    aEurosActual, aEurosAnterior: real;

    nActualGrupo, nActualAjeno: Integer;
    nAnteriorGrupo, nAnteriorAjeno: Integer;
    aActualGrupo, pActualGrupo, tActualGrupo: Real;
    aAnteriorGrupo, pAnteriorGrupo, tAnteriorGrupo: Real;
    aActualAjeno, pActualAjeno, tActualAjeno: Real;
    aAnteriorAjeno, pAnteriorAjeno, tAnteriorAjeno: Real;

    function OpenVentasSemanal: boolean;
    procedure OpenEntradasCosecheros;
    procedure CloseQuerys;
    procedure PonTitulo;
    procedure FechasListado;

  public
    destructor Destroy; override;
  end;

procedure InformeComercialComparativo(const AEmpresa, ACentro, AProducto, AAnyo,
  AMesDesde, AMesHasta, AAcumDesde: string);

implementation

uses bSQLUtils, bTimeUtils, bMath, UDMAuxDB, DateUtils, CREportes, DPreview,
  bDialogs;

{$R *.DFM}

var
  QRComercialComparativo: TqrpComercialComparativo;

procedure InformeComercialComparativo(const AEmpresa, ACentro, AProducto, AAnyo,
  AMesDesde, AMesHasta, AAcumDesde: string);
var
  year, month, day: word;
begin
  QRComercialComparativo := TqrpComercialComparativo.Create(nil);

  QRComercialComparativo.sEmpresa := AEmpresa;
  QRComercialComparativo.sCentro := ACentro;
  QRComercialComparativo.sProducto := AProducto;
  QRComercialComparativo.iAnyo := StrToInt(AAnyo);
  QRComercialComparativo.iMesDesde := StrToInt(AMesDesde);
  QRComercialComparativo.iMesHasta := StrToInt(AMesHasta);
  if AAcumDesde <> '' then
  begin
    QRComercialComparativo.campanyaActual := StrToDate(AAcumDesde);
    decodeDate(QRComercialComparativo.campanyaActual, year, month, day);
    QRComercialComparativo.campanyaAnterior := encodeDate(year - 1, month, day);
  end
  else
  begin
    QRComercialComparativo.campanyaActual := -1;
    QRComercialComparativo.campanyaAnterior := -1;
  end;
  QRComercialComparativo.FechasListado;
  QRComercialComparativo.bCortar := AMesDesde <> AMesHasta;
  if QRComercialComparativo.OpenVentasSemanal then
  begin
    QRComercialComparativo.OpenEntradasCosecheros;
    PonLogoGrupoBonnysa(QRComercialComparativo, AEmpresa);
    QRComercialComparativo.PonTitulo;

    Preview(QRComercialComparativo);
  end
  else
  begin
    Informar('Informe sin datos.   ');
    FreeAndNil(QRComercialComparativo);
  end;
end;

procedure TqrpComercialComparativo.FechasListado;
var
  aux: Integer;
  year, month, day: word;
  auxDate: TDate;
begin
  LimitesMes(iAnyo, iMesDesde, inicioActual, auxDate);
  LimitesMes(iAnyo, iMesHasta, auxDate, finActual);

  LimitesMes(iAnyo - 1, iMesDesde, inicioAnterior, auxDate);
  LimitesMes(iAnyo - 1, iMesHasta, auxDate, finAnterior);

  if campanyaActual = -1 then
  begin
    (*CENTRO*)
    ConsultaPrepara(DMAuxDB.Qaux,
      ' Select ejercicio_e from frf_ejercicios ' +
      ' Where empresa_e=:empresa and centro_e=:centro ' +
      ' and producto_e=:producto ');
    with DMAuxDB.Qaux do
    begin
      ParamByName('empresa').AsString := sEmpresa;
      ParamByName('centro').AsString := sCentro;
      ParamByName('producto').AsString := sProducto;

      aux := ConsultaOpen(DMAuxDB.Qaux, False);


      if aux = 0 then
      begin
        Cancel;
        Close;
        raise Exception.Create('Falta la fecha de inicio del ejercicio.');
      end;

      if FieldByName('ejercicio_e').AsDateTime > inicioActual then
        campanyaActual := inicioActual
      else
        campanyaActual := FieldByName('ejercicio_e').AsDateTime;
      Cancel;
      Close;
    end;
    decodeDate(campanyaActual, year, month, day);
    campanyaAnterior := encodeDate(year - 1, month, day);
  end;
end;

procedure TqrpComercialComparativo.CloseQuerys;
begin
  QVentasActual.Close;
  QVentasAnterior.Close;
  QAActual.Close;
  QAAnterior.Close;
  QEntradasActual.Close;
  QEntradasAnterior.Close;
end;

function TqrpComercialComparativo.OpenVentasSemanal: boolean;
begin
  nActual := 0;
  with QVentasActual do
  begin
    SQL.Clear;
    SQL.Add(' select YEARANDWEEK( fecha_sl ) fecha, ');
    SQL.Add('       sum( kilos_sl ) kilos, ');
    SQL.Add('       sum( EUROS( moneda_sc, fecha_sl, importe_neto_sl ) ) euros ');

    SQL.Add(' from frf_salidas_l, frf_salidas_c ');
    SQL.Add(' where empresa_sl ' + SQLEqualS(sEmpresa));

    (*if ( sCentro = '1' ) or ( sCentro = '2' ) then
      SQL.Add( '   and  centro_origen_sl in(' + QuotedStr('1') + ',' + QuotedStr('2') + ') ')
    else*)
    SQL.Add('   and centro_origen_sl ' + SQLEqualS(sCentro));

    SQL.Add('   and producto_sl ' + SQLEqualS(sProducto));
    SQL.Add('   and YEAR(fecha_sl) ' + SQLEqualN(IntToStr(iAnyo)));
    SQL.Add('   and MONTh(fecha_sl) ' + SQLRangeN(IntToStr(iMesDesde), IntToStr(iMesHasta)));
    SQL.Add('   and categoria_sl in (' + SQLString('1') + ',' + SQLString('2') + ')');

    SQL.Add('   and empresa_sc ' + SQLEqualS(sEmpresa));
    SQL.Add('   and centro_salida_sc = centro_salida_sl ');
    SQL.Add('   and n_albaran_sc = n_albaran_sl ');
    SQL.Add('   and fecha_sc = fecha_sl ');

    SQL.Add(' group by 1 ');
    SQL.Add(' order by 1 ');

    if OpenQuery(QVentasActual) then
    begin
      while not EOF do
      begin
        Inc(nActual);
        Next;
      end;
    end;
  end;
  if nActual = 0 then
  begin
    result := false;
    exit;
  end;
  result := true;

  nAnterior := 0;
  with QVentasAnterior do
  begin
    SQL.Clear;
    SQL.Add(' select YEARANDWEEK( fecha_sl ) fecha, ');
    SQL.Add('       sum( kilos_sl ) kilos, ');
    SQL.Add('       sum( EUROS( moneda_sc, fecha_sl, importe_neto_sl ) ) euros ');

    SQL.Add(' from frf_salidas_l, frf_salidas_c ');
    SQL.Add(' where empresa_sl ' + SQLEqualS(sEmpresa));

    (*if ( sCentro = '1' ) or ( sCentro = '2' ) then
      SQL.Add( '   and  centro_origen_sl in(' + QuotedStr('1') + ',' + QuotedStr('2') + ') ')
    else*)
    SQL.Add('   and centro_origen_sl ' + SQLEqualS(sCentro));

    SQL.Add('   and producto_sl ' + SQLEqualS(sProducto));
    SQL.Add('   and YEAR(fecha_sl) ' + SQLEqualN(IntToStr(iAnyo - 1)));
    SQL.Add('   and MONTh(fecha_sl) ' + SQLRangeN(IntToStr(iMesDesde), IntToStr(iMesHasta)));
    SQL.Add('   and categoria_sl in (' + SQLString('1') + ',' + SQLString('2') + ')');

    SQL.Add('   and empresa_sc ' + SQLEqualS(sEmpresa));
    SQL.Add('   and centro_salida_sc = centro_salida_sl ');
    SQL.Add('   and n_albaran_sc = n_albaran_sl ');
    SQL.Add('   and fecha_sc = fecha_sl ');

    SQL.Add(' group by 1 ');
    SQL.Add(' order by 1 ');

    if OpenQuery(QVentasAnterior) then
    begin
      while not EOF do
      begin
        Inc(nAnterior);
        Next;
      end;
    end;
  end;

  with QAActual do
  begin
    SQL.Clear;
    SQL.Add(' select sum( kilos_sl ) kilos, ');
    SQL.Add('       sum( EUROS( moneda_sc, fecha_sl, importe_neto_sl ) ) euros ');

    SQL.Add(' from frf_salidas_l, frf_salidas_c ');
    SQL.Add(' where empresa_sl ' + SQLEqualS(sEmpresa));

    (*if ( sCentro = '1' ) or ( sCentro = '2' ) then
      SQL.Add( '   and  centro_origen_sl in(' + QuotedStr('1') + ',' + QuotedStr('2') + ') ')
    else*)
    SQL.Add('   and centro_origen_sl ' + SQLEqualS(sCentro));

    SQL.Add('   and producto_sl ' + SQLEqualS(sProducto));
    SQL.Add('   and fecha_sl ' + SQLRangeD(DateToStr(campanyaActual),
      DateToStr(inicioActual - 1)));
    SQL.Add('   and categoria_sl in (' + SQLString('1') + ',' + SQLString('2') + ')');

    SQL.Add('   and empresa_sc ' + SQLEqualS(sEmpresa));
    SQL.Add('   and centro_salida_sc = centro_salida_sl ');
    SQL.Add('   and n_albaran_sc = n_albaran_sl ');
    SQL.Add('   and fecha_sc = fecha_sl ');

    OpenQuery(QAActual);
  end;

  with QAAnterior do
  begin
    SQL.Clear;
    SQL.Add(' select sum( kilos_sl ) kilos, ');
    SQL.Add('       sum( EUROS( moneda_sc, fecha_sl, importe_neto_sl ) ) euros ');

    SQL.Add(' from frf_salidas_l, frf_salidas_c ');
    SQL.Add(' where empresa_sl ' + SQLEqualS(sEmpresa));

    (*if ( sCentro = '1' ) or ( sCentro = '2' ) then
      SQL.Add( '   and  centro_origen_sl in(' + QuotedStr('1') + ',' + QuotedStr('2') + ') ')
    else*)
    SQL.Add('   and centro_origen_sl ' + SQLEqualS(sCentro));

    SQL.Add('   and producto_sl ' + SQLEqualS(sProducto));
    SQL.Add('   and fecha_sl ' + SQLRangeD(DateToStr(campanyaAnterior),
      DateToStr(inicioAnterior - 1)));
    SQL.Add('   and categoria_sl in (' + SQLString('1') + ',' + SQLString('2') + ')');

    SQL.Add('   and empresa_sc ' + SQLEqualS(sEmpresa));
    SQL.Add('   and centro_salida_sc = centro_salida_sl ');
    SQL.Add('   and n_albaran_sc = n_albaran_sl ');
    SQL.Add('   and fecha_sc = fecha_sl ');

    OpenQuery(QAAnterior);
  end;
end;

procedure TqrpComercialComparativo.OpenEntradasCosecheros;
begin
  nActualGrupo := 0;
  nActualAjeno := 0;
  aActualGrupo := 0;
  pActualGrupo := 0;
  tActualGrupo := 0;
  aActualAjeno := 0;
  pActualAjeno := 0;
  tActualAjeno := 0;
  with QEntradasActual do
  begin
    (*CODEBREAK*)
    //20040411.Teresa quiere que salgan juntos los cosecheros externos 64,65,66 Costa de Nijar
    SQL.Add(' select case when cosechero_e2l in (64,65,66) then 64 else cosechero_e2l end cosechero_e2l, ');
    SQL.Add('        pertenece_grupo_c, ');
    SQL.Add('        sum(case when fecha_e2l < ' + SQLString(DateToStr(inicioActual)));
    SQL.Add('                 then total_kgs_e2l else 0 end) acumulado, ');
    SQL.Add('        sum(case when fecha_e2l >= ' + SQLString(DateToStr(inicioActual)));
    SQL.Add('                 then total_kgs_e2l else 0 end) periodo, ');
    SQL.Add('        sum(total_kgs_e2l) total ');
    SQL.Add(' from frf_entradas2_l, frf_cosecheros ');
    SQL.Add(' where empresa_e2l ' + SQLEqualS(sEmpresa));

    (*if ( sCentro = '1' ) or ( sCentro = '2' ) then
      SQL.Add( '   and  centro_e2l in(' + QuotedStr('1') + ',' + QuotedStr('2') + ') ')
    else*)
    SQL.Add('   and centro_e2l ' + SQLEqualS(sCentro));

    SQL.Add('   and fecha_e2l ' + SQLRangeD(DateToStr(campanyaActual), DateToStr(finActual)));
    SQL.Add('   and producto_e2l ' + SQLEqualS(sProducto));

    SQL.Add('   and empresa_c ' + SQLEqualS(sEmpresa));
    SQL.Add('   and cosechero_c = cosechero_e2l ');

    SQL.Add(' group by 1, 2 ');
    SQL.Add(' order by 1, 2 DESC ');

    if OpenQuery(QEntradasActual) then
    begin
      while not EOF do
      begin
        if Fields[1].AsString = 'S' then
        begin
          Inc(nActualGrupo);
          aActualGrupo := aActualGrupo + Fields[2].AsFloat;
          pActualGrupo := pActualGrupo + Fields[3].AsFloat;
          tActualGrupo := tActualGrupo + Fields[4].AsFloat;
        end
        else
        begin
          Inc(nActualAjeno);
          //aActualAjeno:= aActualAjeno + Fields[2].AsFloat;
          pActualAjeno := pActualAjeno + Fields[3].AsFloat;
          tActualAjeno := tActualAjeno + Fields[4].AsFloat;
        end;
        Next;
      end;
      nActualAjeno := nActualAjeno + nActualGrupo;
    end;
  end;

  nAnteriorGrupo := 0;
  aAnteriorGrupo := 0;
  pAnteriorGrupo := 0;
  tAnteriorGrupo := 0;
  nAnteriorAjeno := 0;
  aAnteriorAjeno := 0;
  pAnteriorAjeno := 0;
  tAnteriorAjeno := 0;
  with QEntradasAnterior do
  begin
    SQL.Clear;
    (*CODEBREAK*)
    //20040411.Teresa quiere que salgan juntos los cosecheros externos 64,65,66 Costa de Nijar
    SQL.Add(' select case when cosechero_e2l in (64,65,66) then 64 else cosechero_e2l end cosechero_e2l, ');
    SQL.Add('        pertenece_grupo_c, ');
    SQL.Add('        sum(case when fecha_e2l < ' + SQLString(DateToStr(inicioAnterior)));
    SQL.Add('                 then total_kgs_e2l else 0 end) acumulado, ');
    SQL.Add('        sum(case when fecha_e2l >= ' + SQLString(DateToStr(inicioAnterior)));
    SQL.Add('                 then total_kgs_e2l else 0 end) periodo, ');
    SQL.Add('        sum(total_kgs_e2l) total ');
    SQL.Add(' from frf_entradas2_l, frf_cosecheros ');
    SQL.Add(' where empresa_e2l ' + SQLEqualS(sEmpresa));

    (*if ( sCentro = '1' ) or ( sCentro = '2' ) then
      SQL.Add( '   and  centro_e2l in(' + QuotedStr('1') + ',' + QuotedStr('2') + ') ')
    else*)
    SQL.Add('   and centro_e2l ' + SQLEqualS(sCentro));

    SQL.Add('   and fecha_e2l ' + SQLRangeD(DateToStr(campanyaAnterior), DateToStr(finAnterior)));
    SQL.Add('   and producto_e2l ' + SQLEqualS(sProducto));

    SQL.Add('   and empresa_c ' + SQLEqualS(sEmpresa));
    SQL.Add('   and cosechero_c = cosechero_e2l ');

    SQL.Add(' group by 1, 2  ');
    SQL.Add(' order by 1, 2 DESC ');

    if OpenQuery(QEntradasAnterior) then
    begin
      while not EOF do
      begin
        if Fields[1].AsString = 'S' then
        begin
          Inc(nAnteriorGrupo);
          aAnteriorGrupo := aAnteriorGrupo + Fields[2].AsFloat;
          pAnteriorGrupo := pAnteriorGrupo + Fields[3].AsFloat;
          tAnteriorGrupo := tAnteriorGrupo + Fields[4].AsFloat;
        end
        else
        begin
          Inc(nAnteriorAjeno);
          aAnteriorAjeno := aAnteriorAjeno + Fields[2].AsFloat;
          pAnteriorAjeno := pAnteriorAjeno + Fields[3].AsFloat;
          tAnteriorAjeno := tAnteriorAjeno + Fields[4].AsFloat;
        end;
        Next;
      end;
      nAnteriorAjeno := nAnteriorAjeno + nAnteriorGrupo;
    end;
  end;
end;

procedure TqrpComercialComparativo.PonTitulo;
var
  anyo: integer;
begin
  Titulo.Caption := 'INFORME COMERCIAL COMPARATIVO AL  "' + DateToStr(finActual) +
    '" ( CATEGORIAS I y II )';
  lblCentro.Caption := Trim(desCentro(sEmpresa, sCentro));
  lblProducto.Caption := Trim(desProducto(sEmpresa, sProducto));

  anyo := YearOf(finActual);
  AnyoActual.Caption := IntToStr(anyo);
  AnyoAnterior.Caption := IntToStr(anyo - 1);

  Titulo2.Caption := 'KILOS ENTRADOS HASTA EL  "' + DateToStr(finActual) + '"';
  AnyoActual2.Caption := 'AÑO ' + IntToStr(anyo);
  AnyoAnterior2.Caption := 'AÑO ' + IntToStr(anyo - 1);

  if bCortar then
    lblCampanya.caption := 'Inicio acumulado: ' + DateToStr(campanyaActual)
  else
    lblCampanya.caption := 'Inicio de campaña: ' + DateToStr(campanyaActual);
end;

function CmpSemana(const AValue1, AValue2: string): integer;
var
  sAux: string;
begin
  if (AValue2 = '') then
  begin
    result := -1;
  end
  else
  begin
    sAux := IntToStr(StrToInt(copy(AValue2, 1, 4)) + 1) + copy(AValue2, 5, 2);
    if AValue1 = sAux then
    begin
      result := 0;
    end
    else
      if (AValue1 > sAux) then
      begin
        result := 1;
      end
      else
      begin
        result := -1;
      end
  end;
end;

destructor TqrpComercialComparativo.Destroy;
begin
  CloseQuerys;
  inherited;
end;

procedure TqrpComercialComparativo.SemanaDetailNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := (iActual <> nActual) or (iAnterior <> nAnterior);
  bQuedan := MoreData;
  if MoreData then
  begin
    if iActual = nActual then
    begin
      iAccion := 1;
    end
    else
      if iAnterior = nAnterior then
      begin
        iAccion := -1;
      end
      else
      begin
        iAccion := CmpSemana(QVentasActual.Fields[0].AsString,
          QVentasAnterior.Fields[0].AsString);
      end;
    case iAccion of
      -1: Inc(iActual);
      0: begin Inc(iActual); Inc(iAnterior); end;
      1: Inc(iAnterior);
    end;
  end;
end;

procedure TqrpComercialComparativo.SemanaDetailAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if (iAccion <= 0) then QVentasActual.Next;
  if (iAccion >= 0) then QVentasAnterior.Next;
end;

procedure TqrpComercialComparativo.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  iAnterior := 0;
  iActual := 0;

  aKilosActual := 0;
  aKilosAnterior := 0;

  aEurosActual := 0;
  aEurosAnterior := 0;

  QVentasActual.First;
  QVentasAnterior.First;

  QEntradasActual.First;
  QEntradasAnterior.First;
end;

procedure TqrpComercialComparativo.PsQRDBText1Print(sender: TObject;
  var Value: string);
begin
  if iAccion <= 0 then
  begin
    Value := copy(QVentasActual.Fields[0].AsString, 5, 2);
  end
  else
  begin
    Value := copy(QVentasAnterior.Fields[0].AsString, 5, 2);
  end;
end;

procedure TqrpComercialComparativo.lblKilosActualPrint(sender: TObject;
  var Value: string);
begin
  if iAccion > 0 then
  begin
    Value := '';
  end;
end;

procedure TqrpComercialComparativo.lblEurosActualPrint(sender: TObject;
  var Value: string);
begin
  if iAccion > 0 then
  begin
    Value := '';
  end;
end;

procedure TqrpComercialComparativo.lblKilosAnteriorPrint(sender: TObject;
  var Value: string);
begin
  if iAccion < 0 then
  begin
    Value := '';
  end;
end;

procedure TqrpComercialComparativo.lblEurosAnteriorPrint(sender: TObject;
  var Value: string);
begin
  if iAccion < 0 then
  begin
    Value := '';
  end;
end;


procedure TqrpComercialComparativo.SemanaDetailBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  promedioAnterior, promedioActual: Real;
  kilosAnterior, kilosActual: Real;
  eurosAnterior, eurosActual: Real;
begin
  KilosActual := 0;
  EurosActual := 0;
  promedioActual := 0;
  KilosAnterior := 0;
  EurosAnterior := 0;
  promedioAnterior := 0;

  if iAccion > 0 then
  begin
    lblPromedioActual.Caption := '';
  end
  else
  begin
    try
      KilosActual := QVentasActual.fieldbyname('kilos').asfloat;
      EurosActual := QVentasActual.fieldbyname('euros').asfloat;
      promedioActual := bRoundTo(eurosActual / kilosActual, -3);
      lblPromedioActual.Caption := FormatFloat('#,##0.000', promedioActual);
    except
      promedioActual := 0;
      lblPromedioActual.Caption := 'ERROR';
    end;
  end;
  if iAccion < 0 then
  begin
    lblPromedioAnterior.Caption := '';
  end
  else
  begin
    try
      KilosAnterior := QVentasAnterior.fieldbyname('kilos').asfloat;
      EurosAnterior := QVentasAnterior.fieldbyname('euros').asfloat;
      promedioAnterior := bRoundTo(eurosAnterior / kilosAnterior, -3);
      lblPromedioAnterior.Caption := FormatFloat('#,##0.000', promedioAnterior);
    except
      promedioAnterior := 0;
      lblPromedioAnterior.Caption := 'ERROR';
    end;
  end;
  lblDifKilos.Caption := FormatFloat('#,##0.00', kilosActual - kilosAnterior);
  lblDifEuros.Caption := FormatFloat('#,##0.00', eurosActual - eurosAnterior);
  lblDifPromedio.Caption := FormatFloat('#,##0.000', promedioActual - promedioAnterior);

  aKilosActual := aKilosActual + kilosActual;
  aKilosAnterior := aKilosAnterior + KilosAnterior;
  aEurosActual := aEurosActual + EurosActual;
  aEurosAnterior := aEurosAnterior + EurosAnterior;
end;



procedure TqrpComercialComparativo.QRPieSemanaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  promedioActual, promedioAnterior: real;
begin
  lblAKilosActual.Caption := FormatFloat('#,##0.00', aKilosActual);
  lblAEurosActual.Caption := FormatFloat('#,##0.00', aEurosActual);
  if aKilosActual = 0 then
  begin
    promedioActual := 0;
  end
  else
  begin
    promedioActual := bRoundTo(aEurosActual / aKilosActual, -3);
  end;
  lblAPromedioActual.Caption := FormatFloat('#,##0.000', promedioActual);

  lblAKilosAnterior.Caption := FormatFloat('#,##0.00', aKilosAnterior);
  lblAEurosAnterior.Caption := FormatFloat('#,##0.00', aEurosAnterior);
  if aKilosAnterior = 0 then
  begin
    promedioAnterior := 0;
  end
  else
  begin
    promedioAnterior := bRoundTo(aEurosAnterior / aKilosAnterior, -3);
  end;
  lblAPromedioAnterior.Caption := FormatFloat('#,##0.000', promedioAnterior);

  lblADifKilos.Caption := FormatFloat('#,##0.00', aKilosActual - akilosAnterior);
  lblADifEuros.Caption := FormatFloat('#,##0.00', aEurosActual - aEurosAnterior);
  lblADifPromedio.Caption := FormatFloat('#,##0.000', promedioActual - promedioAnterior);
end;

procedure TqrpComercialComparativo.cabSemanaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  promedioActual, promedioAnterior: real;
begin
  lblPKilosActual.Caption := FormatFloat('#,##0.00', QAActual.FieldByName('kilos').AsFloat);
  lblPEurosActual.Caption := FormatFloat('#,##0.00', QAActual.FieldByName('euros').AsFloat);
  if QAActual.FieldByName('kilos').AsFloat = 0 then
  begin
    promedioActual := 0;
  end
  else
  begin
    promedioActual := bRoundTo(QAActual.FieldByName('euros').AsFloat /
      QAActual.FieldByName('kilos').AsFloat, -3);
  end;
  lblPPromedioActual.Caption := FormatFloat('#,##0.000', promedioActual);

  lblPKilosAnterior.Caption := FormatFloat('#,##0.00', QAAnterior.FieldByName('kilos').AsFloat);
  lblPEurosAnterior.Caption := FormatFloat('#,##0.00', QAAnterior.FieldByName('euros').AsFloat);
  if QAAnterior.FieldByName('kilos').AsFloat = 0 then
  begin
    promedioAnterior := 0;
  end
  else
  begin
    promedioAnterior := bRoundTo(QAAnterior.FieldByName('euros').AsFloat /
      QAAnterior.FieldByName('kilos').AsFloat, -3);
  end;
  lblPPromedioAnterior.Caption := FormatFloat('#,##0.000', promedioAnterior);

  lblPDifKilos.Caption := FormatFloat('#,##0.00', QAActual.FieldByName('kilos').AsFloat -
    QAAnterior.FieldByName('kilos').AsFloat);
  lblPDifEuros.Caption := FormatFloat('#,##0.00', QAActual.FieldByName('euros').AsFloat -
    QAAnterior.FieldByName('euros').AsFloat);
  lblPDifPromedio.Caption := FormatFloat('#,##0.000', promedioActual - promedioAnterior);
end;

procedure TqrpComercialComparativo.ChildBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  promedioActual, promedioAnterior: real;
begin
  aKilosActual := aKilosActual + QAActual.FieldByName('kilos').AsFloat;
  aEurosActual := aEurosActual + QAActual.FieldByName('euros').AsFloat;
  aKilosAnterior := aKilosAnterior + QAAnterior.FieldByName('kilos').AsFloat;
  aEurosAnterior := aEurosAnterior + QAAnterior.FieldByName('euros').AsFloat;

  lblTKilosActual.Caption := FormatFloat('#,##0.00', aKilosActual);
  lblTEurosActual.Caption := FormatFloat('#,##0.00', aEurosActual);
  if aKilosActual = 0 then
  begin
    promedioActual := 0;
  end
  else
  begin
    promedioActual := bRoundTo(aEurosActual / aKilosActual, -3);
  end;
  lblTPromedioActual.Caption := FormatFloat('#,##0.000', promedioActual);

  lblTKilosAnterior.Caption := FormatFloat('#,##0.00', aKilosAnterior);
  lblTEurosAnterior.Caption := FormatFloat('#,##0.00', aEurosAnterior);
  if aKilosAnterior = 0 then
  begin
    promedioAnterior := 0;
  end
  else
  begin
    promedioAnterior := bRoundTo(aEurosAnterior / aKilosAnterior, -3);
  end;
  lblTPromedioAnterior.Caption := FormatFloat('#,##0.000', promedioAnterior);

  lblTDifKilos.Caption := FormatFloat('#,##0.00', aKilosActual - aKilosAnterior);
  lblTDifEuros.Caption := FormatFloat('#,##0.00', aEurosActual - aEurosAnterior);
  lblTDifPromedio.Caption := FormatFloat('#,##0.000', promedioActual - promedioAnterior);

  iActual := 0;
  iAnterior := 0;
end;

procedure TqrpComercialComparativo.GrupoDetalleNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := (iActual <> nActualGrupo) or (iAnterior <> nAnteriorGrupo);
  if MoreData then
  begin
    if QEntradasActual.Fields[0].AsString = QEntradasAnterior.Fields[0].AsString then
    begin
      iAccion := 0;
      Inc(iActual);
      Inc(iAnterior);
    end
    else
      if (iAnterior = nAnteriorAjeno) or
        (StrToInt(QEntradasActual.Fields[0].AsString) <
        StrToInt(QEntradasAnterior.Fields[0].AsString))
        then
      begin
        iAccion := -1;
        Inc(iActual);
      end
      else
      begin
        iAccion := 1;
        Inc(iAnterior);
      end;
  end;
end;

procedure TqrpComercialComparativo.GrupoDetalleAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if (iAccion <= 0) then QEntradasActual.Next;
  if (iAccion >= 0) then QEntradasAnterior.Next;
end;

procedure TqrpComercialComparativo.GrupoDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  auxActual, auxAnterior: real;
begin
  if iAccion < 0 then
    auxAnterior := 0
  else
    auxAnterior := QEntradasAnterior.FieldbyName('periodo').AsFloat;

  if iAccion > 0 then
  begin
    lblCosecheroGrupo.Caption := QEntradasAnterior.Fields[0].AsString +
      ' ' + desCosechero(sEmpresa, QEntradasAnterior.Fields[0].AsString);
    auxActual := 0
  end
  else
  begin
    lblCosecheroGrupo.Caption := QEntradasActual.Fields[0].AsString +
      ' ' + desCosechero(sEmpresa, QEntradasActual.Fields[0].AsString);
    auxActual := QEntradasActual.FieldbyName('periodo').AsFloat;
  end;

  PrintBand := (auxActual <> 0) or (auxAnterior <> 0);

  lblGEntradaActual.Caption := FormatFloat('#,##0.00', auxActual);
  lblGEntradaAnterior.Caption := FormatFloat('#,##0.00', auxAnterior);
  lblGDifEntrada.Caption := FormatFloat('#,##0.000', auxActual - auxAnterior);
end;

procedure TqrpComercialComparativo.ChildBand5BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  lblAGEntradaActual.Caption := FormatFloat('#,##0.00', aActualGrupo);
  lblAGEntradaAnterior.Caption := FormatFloat('#,##0.00', aAnteriorGrupo);
  lblAGDifEntrada.Caption := FormatFloat('#,##0.000', aActualGrupo - aAnteriorGrupo);
end;

procedure TqrpComercialComparativo.pieGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  lblPGEntradaActual.Caption := FormatFloat('#,##0.00', pActualGrupo);
  lblPGEntradaAnterior.Caption := FormatFloat('#,##0.00', pAnteriorGrupo);
  lblPGDifEntrada.Caption := FormatFloat('#,##0.000', pActualGrupo - pAnteriorGrupo);
end;

procedure TqrpComercialComparativo.ChildBand6BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  lblTGEntradaActual.Caption := FormatFloat('#,##0.00', tActualGrupo);
  lblTGEntradaAnterior.Caption := FormatFloat('#,##0.00', tAnteriorGrupo);
  lblTGDifEntrada.Caption := FormatFloat('#,##0.000', tActualGrupo - tAnteriorGrupo);
end;

procedure TqrpComercialComparativo.AjenoDetalleNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := (iActual <> nActualAjeno) or (iAnterior <> nAnteriorAjeno);
  if MoreData then
  begin
    if QEntradasActual.Fields[0].AsString = QEntradasAnterior.Fields[0].AsString then
    begin
      iAccion := 0;
      Inc(iActual);
      Inc(iAnterior);
    end
    else
      if ((iAnterior = nAnteriorAjeno) or
        (StrToInt(QEntradasActual.Fields[0].AsString) <
        StrToInt(QEntradasAnterior.Fields[0].AsString)) ) and
        ( not QEntradasActual.EOF )
        then
      begin
        iAccion := -1;
        Inc(iActual);
      end
      else
      begin
        iAccion := 1;
        Inc(iAnterior);
      end;
  end;
end;

procedure TqrpComercialComparativo.AjenoDetalleAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  if (iAccion <= 0) then QEntradasActual.Next;
  if (iAccion >= 0) then QEntradasAnterior.Next;
end;

procedure TqrpComercialComparativo.AjenoDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  auxAnterior, auxActual: Real;
  auxAcumAnterior, auxAcumActual: Real;
  auxTotalAnterior, auxTotalActual: Real;
begin
  if iAccion < 0 then
  begin
    auxAnterior := 0;
    auxAcumAnterior := 0;
    auxTotalAnterior := 0;
  end
  else
  begin
    auxAnterior := QEntradasAnterior.FieldbyName('periodo').AsFloat;
    auxAcumAnterior := QEntradasAnterior.FieldbyName('acumulado').AsFloat;
    auxTotalAnterior := QEntradasAnterior.FieldbyName('total').AsFloat;
  end;

  if iAccion > 0 then
  begin
    (*CODEBREAK*)
    //20040411.Teresa quiere que salgan juntos los cosecheros externos 64,65,66 Costa de Nijar
    if QEntradasAnterior.Fields[0].AsString = '64' then
    begin
      lblCosecheroAjeno.Caption:= 'COSTA DE NIJAR (64,65,66)';
      lblAcumCosecheroAjeno.Caption := 'ANTERIOR (64,65,66)';
      lblTotalCosecheroAjeno.Caption := 'TOTAL (64,65,66)';
    end
    else
    begin
      lblCosecheroAjeno.Caption := QEntradasAnterior.Fields[0].AsString + ' ' +
        desCosechero(sEmpresa, QEntradasAnterior.Fields[0].AsString); ;
      lblAcumCosecheroAjeno.Caption := 'ANTERIOR ' + QEntradasAnterior.Fields[0].AsString;
      lblTotalCosecheroAjeno.Caption := 'TOTAL ' + QEntradasAnterior.Fields[0].AsString;
    end;
    auxActual := 0;
    auxAcumActual := 0;
    auxTotalActual := 0;
  end
  else
  begin
    (*CODEBREAK*)
    //20040411.Teresa quiere que salgan juntos los cosecheros externos 64,65,66 Costa de Nijar
    if QEntradasActual.Fields[0].AsString = '64' then
    begin
      lblCosecheroAjeno.Caption:= 'COSTA DE NIJAR (64,65,66)';
      lblAcumCosecheroAjeno.Caption := 'ANTERIOR (64,65,66)';
      lblTotalCosecheroAjeno.Caption := 'TOTAL (64,65,66)';
    end
    else
    begin
      lblCosecheroAjeno.Caption := QEntradasActual.Fields[0].AsString + ' ' +
        desCosechero(sEmpresa, QEntradasActual.Fields[0].AsString);
      lblAcumCosecheroAjeno.Caption := 'ANTERIOR ' + QEntradasActual.Fields[0].AsString;
      lblTotalCosecheroAjeno.Caption := 'TOTAL ' + QEntradasActual.Fields[0].AsString;
    end;
    auxActual := QEntradasActual.FieldbyName('periodo').AsFloat;
    auxAcumActual := QEntradasActual.FieldbyName('acumulado').AsFloat;
    auxTotalActual := QEntradasActual.FieldbyName('total').AsFloat;
  end;

  //PrintBand := (auxActual <> 0) or (auxAnterior <> 0);

  lblAEntradaActual.Caption := FormatFloat('#,##0.00', auxActual);
  lblAEntradaAnterior.Caption := FormatFloat('#,##0.00', auxAnterior);
  lblADifEntrada.Caption := FormatFloat('#,##0.000', auxActual - auxAnterior);

  lblAAEntradaActual.Caption := FormatFloat('#,##0.00', auxAcumActual);
  lblAAEntradaAnterior.Caption := FormatFloat('#,##0.00', auxAcumAnterior);
  lblAADifEntrada.Caption := FormatFloat('#,##0.000', auxAcumActual - auxAcumAnterior);

  lblPAEntradaActual.Caption := FormatFloat('#,##0.00', auxTotalActual);
  lblPAEntradaAnterior.Caption := FormatFloat('#,##0.00', auxTotalAnterior);
  lblPADifEntrada.Caption := FormatFloat('#,##0.000', auxTotalActual - auxTotalAnterior);
end;

procedure TqrpComercialComparativo.pieAjenoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin

  lblTotalPeriodoActual.Caption := FormatFloat('#,##0.00', pActualGrupo + pActualAjeno);
  lblTotalPeriodoAnterior.Caption := FormatFloat('#,##0.00', pAnteriorGrupo + pAnteriorAjeno);
  lblDifPeriodo.Caption := FormatFloat('#,##0.00', (pActualGrupo + pActualAjeno) -
    (pAnteriorGrupo + pAnteriorAjeno));

  lblTotalAcumuladoActual.Caption := FormatFloat('#,##0.00', tActualGrupo + tActualAjeno);
  lblTotalAcumuladoAnterior.Caption := FormatFloat('#,##0.00', tAnteriorGrupo + tAnteriorAjeno);
  lblDifAcumulado.Caption := FormatFloat('#,##0.00', (tActualGrupo + tActualAjeno) -
    (tAnteriorGrupo + tAnteriorAjeno));
end;

procedure TqrpComercialComparativo.cabGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if bCortar then ForceNewPage;
end;

procedure TqrpComercialComparativo.PsQRLabel3Print(sender: TObject;
  var Value: string);
begin
  if bCortar then
    value := 'TOTAL PERIODO'
  else
    value := 'TOTAL MES';
end;

procedure TqrpComercialComparativo.ChildBand4BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := bQuedan;
end;

end.
