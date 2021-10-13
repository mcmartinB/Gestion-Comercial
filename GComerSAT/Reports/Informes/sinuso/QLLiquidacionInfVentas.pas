unit QLLiquidacionInfVentas;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, SysUtils,
  Quickrpt, Graphics, Qrctrls, Db, DBTables;

type
  TQRLLiquidacionInfVentas = class(TQuickRep)
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
    DataSource2: TDataSource;
    QFOB: TQuery;
    PsQRDBText6: TQRDBText;
    BandaTotales: TQRBand;
    PsQRLabel14: TQRLabel;
    PsQRLabel60: TQRLabel;
    lSumKilosAprovecha: TQRExpr;
    MediaFOB: TQRLabel;
    porcentaje_total: TQRLabel;
    QRGroup1: TQRGroup;
    PsQRLabel1: TQRLabel;
    cosechero: TQRDBText;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRDBText5: TQRDBText;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    codCentro: TQRLabel;
    NomCentro: TQRLabel;
    codProducto: TQRLabel;
    nomProducto: TQRLabel;
    periodo: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel12: TQRLabel;
    lblAjuste: TQRLabel;
    lPorcenVendido: TQRDBText;
    PsQRLabel5: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel9: TQRLabel;
    QRLabel2: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel8: TQRLabel;
    QRLabel3: TQRLabel;
    QRExpr1: TQRExpr;
    txtTransitos: TQRDBText;
    lblTransitos: TQRLabel;
    QRLabel4: TQRLabel;
    lblSinAjuste: TQRLabel;
    procedure kilosPrint(sender: TObject; var Value: string);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PorcentajeCategoria(sender: TObject; var Value: string);
    procedure QRLLiquidacionCosecherosBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure PsQRLabel60Print(sender: TObject; var Value: string);
    procedure MediaFOBPrint(sender: TObject; var Value: string);
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure anyoPrint(sender: TObject; var Value: string);
    procedure QRGroup1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure porcentaje_totalPrint(sender: TObject; var Value: string);
    procedure lSumKilosAprovechaPrint(sender: TObject; var Value: string);
    procedure lPorcenVendidoPrint(sender: TObject; var Value: string);
    procedure lCatPrint(sender: TObject; var Value: string);
    procedure PsQRDBText6Print(sender: TObject; var Value: string);
    procedure PorcentajeSemanal(sender: TObject; var Value: string);
    procedure txtTransitosPrint(sender: TObject; var Value: string);
  private
    //Auxiliares
    AnyoSemanaActual: string;
    rFob, rFobReal: Real;
    rBrutoFOB, rNetoFOB: Real;

    //Sumatorios
    iKilosCos: Integer;
    rSumBrutoFOB, rSumNetoFOB: Real;
    iSumKilosAprovecha: Integer;

    vendidos, pendientes, porcen, fob: array[0..3] of real;

  public
    bDefinitivo: Boolean;
    bAprovechaSalida: Boolean;
    empresa: string;

    procedure DatosSimulacion(const AEmpresa, Acentro, AProducto, ACosechero: string;
      const AFechaIni, AFechaFin: TDate);
  end;

var
  QRLLiquidacionInfVentas: TQRLLiquidacionInfVentas;

implementation

uses CAuxiliar, Principal, UDMAuxDB, bSQLUtils, bMath,
  bTimeUtils, UReenvasado, UComunProductores;

{$R *.DFM}


procedure TQRLLiquidacionInfVentas.kilosPrint(sender: TObject;
  var Value: string);
var
  aux: real;
begin
  aux := StrToFloat(Value);
  if aux = 0 then Value := ''
  else Value := FormatFloat('#,##0', aux);
end;

procedure TQRLLiquidacionInfVentas.QRSubDetail1BeforePrint(
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

  rFob := QFOB.fieldbyname('fob').asfloat;
  rFobReal := rFob - QFOB.fieldbyname('coste_envasado').asfloat;

  rNetoFOB := Redondea(QKGSCosechados.fieldbyname('kilos_cat').asInteger * rFobReal, 2);
  rBrutoFOB := Redondea(QKGSCosechados.fieldbyname('kilos_cat').asInteger * rFob, 2);
  rSumNetoFOB := rSumNetoFOB + rNetoFOB;
  rSumBrutoFOB := rSumBrutoFOB + rBrutoFOB;

  iSumKilosAprovecha := iSumKilosAprovecha + QKGSCosechados.FieldByName('kilos_cat').AsInteger;
end;

procedure TQRLLiquidacionInfVentas.PorcentajeCategoria(sender: TObject;
  var Value: string);
begin
  if Value = '0' then Value := ''
  else Value := FormatFloat('#00.00', StrToFloat(Value)) + '%';
(*
    if QKGSCosechados.FieldByName('kilos_cat').AsFloat = 0 then
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
end;

procedure TQRLLiquidacionInfVentas.QRLLiquidacionCosecherosBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  AnyoSemanaActual := '';
  iSumKilosAprovecha := 0;
end;

procedure TQRLLiquidacionInfVentas.PsQRLabel60Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', iKilosCos);
end;

procedure TQRLLiquidacionInfVentas.MediaFOBPrint(sender: TObject;
  var Value: string);
begin
  if iSumKilosAprovecha <> 0 then
    Value := FormatFloat('#,##0.000', rSumNetoFOB / iSumKilosAprovecha)
  else
    Value := '';
end;

procedure TQRLLiquidacionInfVentas.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  Value := Trim(Value);
end;

procedure TQRLLiquidacionInfVentas.anyoPrint(sender: TObject;
  var Value: string);
begin
  Value := Copy(Value, 1, 4) + ' ' + Copy(Value, 5, 2);
end;

procedure TQRLLiquidacionInfVentas.QRGroup1AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  iKilosCos := 0;
  rSumBrutoFOB := 0;
  rSumNetoFOB := 0;
end;

procedure TQRLLiquidacionInfVentas.porcentaje_totalPrint(sender: TObject;
  var Value: string);
var
  aux: real;
begin
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
end;

function IndiceCategoria(const ACategoria: string): integer;
begin
  result := StrToInt(ACategoria) - 1;
end;

procedure TQRLLiquidacionInfVentas.DatosSimulacion(const AEmpresa, Acentro, AProducto, ACosechero: string;
  const AFechaIni, AFechaFin: TDate);
var
  i: integer;
  dFechaIni: TDate;
  rAux: Real;
begin
  for i := 1 to 4 do
  begin
    pendientes[i] := 0;
    vendidos[i] := -1;
    fob[i] := 0;
  end;

  dFechaIni := AFechaIni;
  //Porcentaje del transito vendida
  //if (ACentro = '6') and (AProducto = 'E') then
  begin
    lblTransitos.Enabled := true;
    txtTransitos.Enabled := true;

    //i:= 0;
    while dFechaIni < AFechaFin do
    begin
      rAux := PorcentajeTransitoVendido(AEmpresa, ACentro, AProducto, dFechaIni, dFechaIni + 6);
      with DMAuxDB.QAux do
      begin
        SQL.Clear;
        SQL.Add('Update tmp_categorias ');
        SQL.Add('set transitos_cat = :porcen ');
        SQL.Add('where anyosemana = :anyosemana ');
        ParamByName('anyosemana').AsString := AnyoSemana(dFechaIni);
        ParamByName('porcen').AsFloat := rAux;
        (*
        try
          ParamByName('porcen').AsFloat := PorcenArray[i];
        except
          ParamByName('porcen').AsFloat := -1;
        end;
        *)
        ExecSQL;
      end;
      dFechaIni := dFechaIni + 7;
      //Inc(i);
    end;
  end;
(*
  else
  begin
    lblTransitos.Enabled := False;
    txtTransitos.Enabled := False;
  end;
*)

  dFechaIni := AFechaIni;
  //Calcular kilos vendidos
  while dFechaIni < AFechaFin do
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('select case when categoria_sl not in (''1'',''2'',''3'') then ''4'' else categoria_sl end categoria, ');
      SQL.Add('       sum(kilos_sl) kilos_totales, ');

      SQL.Add('       sum( case when ');
      SQL.Add('                       (NVL( importe_neto_sl, 0 ) <> 0 ) or ');
      SQL.Add('                       (Exists (select * from frf_salidas_c ');
      SQL.Add('                                where empresa_sc = empresa_sl ');
      SQL.Add('                                  and centro_salida_sc = centro_salida_sl ');
      SQL.Add('                                  and n_albaran_sc = n_albaran_sl ');
      SQL.Add('                                  and fecha_sc = fecha_sl ');
      SQL.Add('                                  and n_factura_sc is not null ) ) ');
      SQL.Add('                 then kilos_sl else 0 end ) kilos_vendidos ');

      SQL.Add('from frf_salidas_l, frf_salidas_c ');

      SQL.Add('where empresa_sc = :empresa ');
      SQL.Add('  and fecha_sc between :fechaini and :fechafin ');

      SQL.Add('  and empresa_sl = :empresa ');
      SQL.Add('  and centro_origen_sl = :centro ');
      SQL.Add('  and centro_salida_sl = centro_salida_sc ');
      SQL.Add('  and n_albaran_sl = n_albaran_sc ');
      SQL.Add('  and fecha_sl = fecha_sc ');
      SQL.Add('  and fecha_sl between :fechaini and :fechafin ');
      SQL.Add('  and producto_sl = :producto ');
      SQL.Add('  and categoria_sl <> ''B'' ');
      SQL.Add('  and cliente_sl <> ''RET'' ');

      SQL.Add('group by categoria_sl ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('producto').AsString := AProducto;
      ParamByName('fechaini').AsDate := dFechaIni;
      ParamByName('fechafin').AsDate := dFechaIni + 6;

      Open;
      while not EOF do
      begin
        pendientes[IndiceCategoria(FieldByName('categoria').AsString)] :=
          FieldByName('kilos_totales').asfloat - FieldByName('kilos_vendidos').asfloat;
        vendidos[IndiceCategoria(FieldByName('categoria').AsString)] :=
          FieldByName('kilos_vendidos').asfloat;
        next;
      end;
      Close;

      for i := 0 to 3 do
      begin
        if vendidos[i] >= 0 then
        begin
          if (vendidos[i] + pendientes[i]) <> 0 then
            porcen[i] := (vendidos[i] * 100) / (vendidos[i] + pendientes[i])
          else
            porcen[i] := 0;
        end
        else
        begin
          porcen[i] := -1;
        end;
      end;

      SQL.Clear;
      SQL.Add('Update tmp_categorias ');
      SQL.Add('set vendidos_cat = :porcen ');
      SQL.Add('where anyosemana = :anyosemana ');
      SQL.Add('  and categoria = :categoria ');

      ParamByName('anyosemana').AsString := AnyoSemana(dFechaIni);
      ParamByName('porcen').AsFloat := porcen[0];
      ParamByName('categoria').AsString := '1';
      ExecSQL;

      ParamByName('porcen').AsFloat := porcen[1];
      ParamByName('categoria').AsString := '2';
      ExecSQL;

      ParamByName('porcen').AsFloat := porcen[2];
      ParamByName('categoria').AsString := '3';
      ExecSQL;

      ParamByName('porcen').AsFloat := porcen[3];
      ParamByName('categoria').AsString := '4';
      ExecSQL;

      dFechaIni := dFechaIni + 7;
    end;
end;

procedure TQRLLiquidacionInfVentas.lSumKilosAprovechaPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0', iSumKilosAprovecha);
end;

procedure TQRLLiquidacionInfVentas.lPorcenVendidoPrint(sender: TObject;
  var Value: string);
begin
  if (rFob = 0) then
  begin
    Value := '';
  end
  else
  begin
    if QKGSCosechados.FieldByName('vendidos_cat').AsFloat >= 0 then
    begin
      Value := FormatFloat('#00.00', QKGSCosechados.FieldByName('vendidos_cat').AsFloat) + '%';
    end
    else
    begin
      Value := '';
    end;
  end;
end;

procedure TQRLLiquidacionInfVentas.lCatPrint(sender: TObject;
  var Value: string);
begin
  if Value = '4' then
    Value := 'D';
end;

procedure TQRLLiquidacionInfVentas.PsQRDBText6Print(sender: TObject;
  var Value: string);
begin
  if (rFob = 0) then
    Value := ''
  else
    Value := FormatFloat('#,##0.000', rFobReal);
end;

procedure TQRLLiquidacionInfVentas.PorcentajeSemanal(sender: TObject;
  var Value: string);
begin
  if Value = '0' then Value := ''
  else Value := FormatFloat('#00.00', StrToFloat(Value)) + '%';
end;

procedure TQRLLiquidacionInfVentas.txtTransitosPrint(sender: TObject;
  var Value: string);
begin
  if (rFob = 0) then
  begin
    Value := '';
  end
  else
  begin
    if QKGSCosechados.FieldByName('transitos_cat').AsFloat > 100 then
    begin
      Value := '100%';
    end
    else
    begin
      if QKGSCosechados.FieldByName('transitos_cat').AsFloat < 0 then
      begin
        Value := '';
      end
      else
      begin
        Value := FormatFloat('#00.00', QKGSCosechados.FieldByName('transitos_cat').AsFloat) + '%';
      end;
    end;
  end;
end;

end.
