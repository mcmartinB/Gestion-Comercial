unit QLIntrastat;

interface

uses Classes, Controls, StdCtrls, ExtCtrls, Quickrpt, Graphics, Qrctrls, SysUtils, bMath,
  DB, DBTables;
type
  TQRLIntrastat = class(TQuickRep)
    DetailBand1: TQRBand;
    QRGroup1: TQRGroup;
    ChildBand1: TQRChildBand;
    PsQRLabel23: TQRLabel;
    PsQRShape18: TQRShape;
    PsQRLabel17: TQRLabel;
    PsQRShape13: TQRShape;
    PsQRLabel18: TQRLabel;
    PsQRShape14: TQRShape;
    PsQRLabel19: TQRLabel;
    PsQRShape15: TQRShape;
    PsQRLabel20: TQRLabel;
    PsQRShape16: TQRShape;
    PsQRLabel21: TQRLabel;
    PsQRShape17: TQRShape;
    PsQRLabel22: TQRLabel;
    QRGroup2: TQRGroup;
    QRLabel1: TQRLabel;
    QRBand1: TQRBand;
    PsQRLabel10: TQRLabel;
    PsQRDBText2: TQRDBText;
    PsQRLabel8: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRShape2: TQRShape;
    PsQRShape4: TQRShape;
    PsQRShape6: TQRShape;
    PsQRShape8: TQRShape;
    PsQRShape10: TQRShape;
    PsQRShape12: TQRShape;
    QRLabel2: TQRLabel;
    QRExpr1: TQRExpr;
    QRBand2: TQRBand;
    QRMemo1: TQRMemo;
    QRMemo2: TQRMemo;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRExpr2: TQRExpr;
    QGastoAlbaran: TQuery;
    QAlbaranAgrupado: TQuery;
    QRExpr3: TQRExpr;
    procedure PsQRLabel11Print(sender: TObject; var Value: string);
    procedure Linea4Print(sender: TObject; var Value: string);
    procedure PsQRLabel10Print(sender: TObject; var Value: string);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure PsQRDBText2Print(sender: TObject; var Value: String);
    procedure PsQRDBText1Print(sender: TObject; var Value: String);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure AddGastos(var AGastoFactAlb: Real);
    function EsProductoConGasto (const AProducto: string): Boolean;
    procedure AddGastoTotal( var AGastoFac: Real );
    function PutGasto( const AUnidades: Real;  const AUnidadesTotal: string; var AFac: Real ): Boolean;
    procedure AddGastoProducto( var AGastoFac: Real );
    procedure CrearQGastoAlbaran;
    procedure CrearQAlbaranAgrupado;
    function EjecutaQGastoAlbaran (const AEmpresa, ACentro, AAlbaran, AFecha: String): Boolean;
    function EjecutaQAlbaranAgrupado (const AEmpresa, ACentro, AAlbaran, AFecha, AProducto: String): boolean;
    procedure QRExpr2Print(sender: TObject; var Value: string);
    procedure QRExpr4Print(sender: TObject; var Value: string);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
    rTotalN, rTotalNetoGrupo : real;


  public
    sMes, sAnyo: string;
    bComunitario: Boolean;
  end;

var
  QRLIntrastat: TQRLIntrastat;

implementation

uses Lintrastat, UDMAuxDB, UDMBaseDatos, bTextUtils, CFactura;

{$R *.DFM}

procedure TQRLIntrastat.PsQRLabel11Print(sender: TObject;
  var Value: string);
begin
  if bComunitario then
  begin
    if DMBaseDatos.QListado.FieldByName('centro').asstring = '1' then
      value := 'CENTRO ALICANTE.'
    else
    if DMBaseDatos.QListado.FieldByName('centro').asstring = '2' then
      value := 'CENTRO ALMERÍA.'
    else
    if DMBaseDatos.QListado.FieldByName('centro').asstring = '6' then
      value := 'CENTRO TENERIFE.'
    else
      value := 'OTROS CENTROS.';
  end
  else
  begin
    value := 'PAISES NO COMUNITARIOS';
  end;
end;

procedure TQRLIntrastat.AddGastoProducto(var AGastoFac: Real);
var sKilos, sCajas, sPalets, sImporte: string;
begin
  sKilos := 'kilos';
  sCajas := 'cajas';
  sPalets := 'palets';
  sImporte := 'neto';

  //KILOGRAMOS
  if Copy( QGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'K' then
  begin
    PutGasto( QAlbaranAgrupado.FieldByName('total_prod_kilos').AsFloat, sKilos, AGastoFac );
  end
  else
  //CAJAS
  if Copy( QGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'C' then
  begin
    if not PutGasto( QAlbaranAgrupado.FieldByName('total_prod_cajas').AsFloat, sCajas,  AGastoFac ) then
    begin
      PutGasto( QAlbaranAgrupado.FieldByName('total_prod_kilos').AsFloat, sKilos, AGastoFac );
    end;
  end
  else
  //PALETS
  if Copy( QGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'P' then
  begin
    if not PutGasto( QAlbaranAgrupado.FieldByName('total_prod_palets').AsFloat, sPalets, AGastoFac ) then
    begin
      if not PutGasto( QAlbaranAgrupado.FieldByName('total_prod_cajas').AsFloat, sCajas, AGastoFac ) then
      begin
        PutGasto( QAlbaranAgrupado.FieldByName('total_prod_kilos').AsFloat, sKilos, AGastoFac );
      end;
    end;
  end
  else
  //IMPORTE
  if Copy( QGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'I' then
  begin
    if not PutGasto( QAlbaranAgrupado.FieldByName('total_prod_importe').AsFloat, sImporte, AGastoFac ) then
    begin
      PutGasto( QAlbaranAgrupado.FieldByName('total_prod_kilos').AsFloat, sKilos, AGastoFac );
    end;
  end;
end;

procedure TQRLIntrastat.AddGastos(var AGastoFactAlb: Real);
begin
  AGastoFactAlb := 0;

  QGastoAlbaran.First;
  while not QGastoAlbaran.Eof do
  begin
    if EsProductoConGasto (DataSet.FieldByName('producto').AsString) then
    begin
      if QGastoAlbaran.fieldByName('producto').AsString = '' then
        AddGastoTotal( AGastoFactAlb)
      else
        AddGastoProducto( AGastoFactAlb );
    end;

    QGastoAlbaran.Next;
  end;

end;

procedure TQRLIntrastat.AddGastoTotal(var AGastoFac: Real);
var sKilos, sCajas, sPalets, sImporte: string;
begin
   sKilos := 'kilos';
   sCajas := 'cajas';
   sPalets := 'palet';
   sImporte := 'neto';

  //KILOGRAMOS
  if Copy( QGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'K' then
  begin
    PutGasto( QAlbaranAgrupado.FieldByName('total_kilos').AsFloat, sKilos, AGastoFac );
  end
  else
  //CAJAS
  if Copy( QGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'C' then
  begin
    if not PutGasto( QAlbaranAgrupado.FieldByName('total_cajas').AsFloat, sCajas,  AGastoFac ) then
    begin
      PutGasto( QAlbaranAgrupado.FieldByName('total_kilos').AsFloat, sKilos,  AGastoFac );
    end;
  end
  else
  //PALETS
  if Copy( QGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'P' then
  begin
    if not PutGasto( QAlbaranAgrupado.FieldByName('total_palets').AsFloat, sPalets,  AGastoFac ) then
    begin
      if not PutGasto( QAlbaranAgrupado.FieldByName('total_cajas').AsFloat, sCajas,  AGastoFac ) then
      begin
        PutGasto( QAlbaranAgrupado.FieldByName('total_kilos').AsFloat, sKilos,  AGastoFac );
      end;
    end;
  end
  else
  //IMPORTE
  if Copy( QGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'I' then
  begin
    if not PutGasto( QAlbaranAgrupado.FieldByName('total_importe').AsFloat, sImporte,  AGastoFac ) then
    begin
      PutGasto( QAlbaranAgrupado.FieldByName('total_kilos').AsFloat, sKilos,  AGastoFac );
    end;
  end;
end;

function TQRLIntrastat.PutGasto(const AUnidades: Real; const AUnidadesTotal: string; var AFac: Real): Boolean;
var
  rAux, rUnidadesTotal: Real;
begin
  rUnidadesTotal :=  DataSet.FieldByName( AUnidadesTotal ).AsFloat;

  if ( AUnidades > 0 ) and ( rUnidadesTotal  > 0 )then
  begin
    rAux:= rUnidadesTotal / AUnidades;
    AFac:= AFac +  QGastoAlbaran.fieldByName('gasto_fac').AsFloat * rAux;
    result:= True;
  end
  else
  begin
    result:= False;
  end;
end;

procedure TQRLIntrastat.CrearQAlbaranAgrupado;
begin
  with QAlbaranAgrupado do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) total_kilos, ');
    SQL.Add('        sum(case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                    then kilos_sl else 0 end) transito_kilos, ');
    SQL.Add('        sum(case when producto_sl = :producto then kilos_sl else 0 end ) total_prod_kilos, ');
    SQL.Add('        sum(case when producto_sl = :producto then ');
    SQL.Add('                     ( case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                            then kilos_sl else 0 end ) ');
    SQL.Add('                 else 0 end ) transito_prod_kilos,  ');

    SQL.Add('        sum(cajas_sl) total_cajas, ');
    SQL.Add('        sum(case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                    then cajas_sl else 0 end) transito_cajas, ');
    SQL.Add('        sum(case when producto_sl = :producto then cajas_sl else 0 end ) total_prod_cajas, ');
    SQL.Add('        sum(case when producto_sl = :producto then ');
    SQL.Add('                     ( case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                            then cajas_sl else 0 end ) ');
    SQL.Add('                 else 0 end ) transito_prod_cajas,  ');

    SQL.Add('        sum(n_palets_sl) total_palets, ');
    SQL.Add('        sum(case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                    then n_palets_sl else 0 end) transito_palets, ');
    SQL.Add('        sum(case when producto_sl = :producto then n_palets_sl else 0 end ) total_prod_palets, ');
    SQL.Add('        sum(case when producto_sl = :producto then ');
    SQL.Add('                     ( case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                            then n_palets_sl else 0 end ) ');
    SQL.Add('                 else 0 end ) transito_prod_palets,  ');

    SQL.Add('        sum(importe_neto_sl) total_importe, ');
    SQL.Add('        sum(importe_total_sl) importe_con_iva, ');
    SQL.Add('        sum(case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                    then importe_neto_sl else 0 end) transito_importe, ');
    SQL.Add('        sum(case when producto_sl = :producto then importe_neto_sl else 0 end ) total_prod_importe, ');
    SQL.Add('        sum(case when producto_sl = :producto then ');
    SQL.Add('                     ( case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                            then importe_neto_sl else 0 end ) ');
    SQL.Add('                 else 0 end ) transito_prod_importe  ');

    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');
    SQL.Add(' and empresa_sl = empresa_sc ');
    SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    SQL.Add(' and fecha_sl = fecha_sc ');

    Prepare;
  end;
end;

procedure TQRLIntrastat.CrearQGastoAlbaran;
begin
  with QGastoAlbaran do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' select producto_g producto, unidad_dist_tg unidad, gasto_transito_tg transito,  ');
    SQL.Add('         sum( case when facturable_tg = ''S''                                    ');
    SQL.Add('                   then importe_g * -1                                           ');
    SQL.Add('                   else 0 end ) gasto_fac,                                       ');
    SQL.Add('         sum( case when facturable_tg <> ''S''                                   ');
    SQL.Add('                  then importe_g                                                 ');
    SQL.Add('                  else 0 end ) gasto_nofac                                       ');
    SQL.Add('  from frf_gastos, frf_tipo_gastos                                               ');
    SQL.Add('  where empresa_g = :empresa                                                     ');
    SQL.Add('  and centro_salida_g = :centro                                                  ');
    SQL.Add('  and n_albaran_g = :albaran                                                     ');
    SQL.Add('  and fecha_g = :fecha                                                           ');
    SQL.Add('  and tipo_tg = tipo_g                                                           ');
    SQL.Add(' group by producto, unidad, transito                                             ');

    Prepare;
  end;

end;

procedure TQRLIntrastat.DetailBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var rComision, rDescuento, rEurosKg, rEurosPale, rGastoFactAlb: real;
    rImpComision, rImpDescuento, rImpEurosKg, rImpEurosPale, rTotalNeto: real;
    rImporte: real;
begin
  rImporte := DataSet.Fieldbyname('neto').AsFloat;

  rComision := GetPorcentajeComision(Dataset.FieldByName('representante').AsString,
                                     Dataset.FieldByName('fecha').AsDatetime);

  rDescuento := GetPorcentajeDescuento(Dataset.FieldByName('empresa').AsString,
                                      Dataset.FieldByName('cliente').asString,
                                      Dataset.FieldByName('centro').asString,
                                      Dataset.FieldByName('producto').AsString,
                                      Dataset.FieldByName('fecha').AsDatetime);

  rEurosKg := GetEurosKg(Dataset.FieldByName('empresa').AsString,
                        Dataset.FieldByName('cliente').asString,
                        Dataset.FieldByName('centro').asString,
                        Dataset.FieldByName('producto').AsString,
                        Dataset.FieldByName('fecha').AsDatetime);

  rEurosPale:= GetEurosPale(Dataset.FieldByName('empresa').AsString,
                            Dataset.FieldByName('cliente').asString,
                            Dataset.FieldByName('centro').asString,
                            Dataset.FieldByName('producto').AsString,
                            Dataset.FieldByName('fecha').AsDatetime);

   rImpComision := bRoundTo(DataSet.FieldByName('neto').AsFloat * rComision/100, 2);
   rImpDescuento:= bRoundTo((DataSet.FieldByName('neto').AsFloat - rImpComision) * rDescuento/100, 3);
   rImpEurosKg := bRoundTo(DataSet.FieldByName('kilos').AsFloat * rEurosKg);
   rImpEurosPale := bRoundTo(DataSet.FieldByName('palets').AsFloat * rEurosPale);

  if EjecutaQGastoAlbaran (DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('centro').AsString,
                           DataSet.FieldByName('referencia').AsString, DataSet.FieldByName('fecha').AsString) then
  begin
     EjecutaQAlbaranAgrupado (DataSet.FieldByName('empresa').AsString, DataSet.FieldByName('centro').AsString,
                              DataSet.FieldByName('referencia').AsString, DataSet.FieldByName('fecha').AsString, DataSet.FieldByName('producto').AsString);
     AddGastos (rGastoFactAlb);
  end;

  rTotalNeto := rImporte - (rImpComision + rImpDescuento + rImpEurosKg + rImpEurosPale) - rGastoFactAlb;

  rTotalN := rTotalN + rTotalNeto;
  rTotalNetoGrupo := rTotalNetoGrupo +  rTotalNeto;

end;

function TQRLIntrastat.EjecutaQAlbaranAgrupado(const AEmpresa, ACentro,
  AAlbaran, AFecha, AProducto: String): boolean;
begin
  with QAlbaranAgrupado do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsString := AAlbaran;
    ParamByName('fecha').AsString := AFecha;
    ParamByName('producto').AsString := AProducto;

    Open;
    Result := not IsEmpty;
  end;

end;

function TQRLIntrastat.EjecutaQGastoAlbaran(const AEmpresa, ACentro, AAlbaran,
  AFecha: String): Boolean;
begin
  with QGastoAlbaran do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsString := AAlbaran;
    ParamByName('fecha').AsString := AFecha;

    Open;
    Result := not IsEmpty;
  end;

end;

function TQRLIntrastat.EsProductoConGasto(const AProducto: string): Boolean;
begin
  if QGastoAlbaran.fieldByName('producto').AsString = '' then
  begin
    result:= True;
  end
  else
  if AProducto = QGastoAlbaran.fieldByName('producto').AsString then
  begin
    result:= True;
  end
  else
  begin
    result:= False;
  end;
end;

procedure TQRLIntrastat.Linea4Print(sender: TObject; var Value: string);
begin
  Value := sMes + ' de ' + sAnyo + ' las siguientes expediciones: '
end;

procedure TQRLIntrastat.PsQRLabel10Print(sender: TObject;
  var Value: string);
begin
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'TOMATES FRESCOS' then
    Value := '0702.00.00'
  else
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'BREVAS' then
    Value := '0804.20.10'
  else
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'LIMONES' then
    Value := '0805.50.10'
  else
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'NARANJAS' then
    Value := '0805.10.30'
  else
  if Pos( 'BERENJENA', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0709.30.00'
  else
  if Pos( 'PIMIENTO', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0709.60.10'
  else
  if UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) = 'MELONES' then
    Value := '0807.19.10'
  else
  if Pos( 'PAPAYA', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0807.20.00'
  else
  if Pos( 'PEPINO', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0707.00.05'
  else
  if Pos( 'CALABACIN', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0709.93.10'
  else
  if Pos( 'GRANADA', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0810.90.75'
  else
  if Pos( 'BONIATO', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0714.20.10'
  else
  if Pos( 'AGUACATE', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0804.40.00'
  else
  if Pos( 'CALABAZA', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0709.93.90'
  else
  if Pos( 'DATIL MEDJOUL', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0804.10.00'
  else
  if Pos( 'GAZPACHO', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '2009.50.90'
  else
  if Pos( 'GRANADA', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0810.90.75'
  else
  if Pos( 'GUACAMOLE', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '2005.10.00.80'
  else
  if Pos( 'LIMA', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0805.50.90'
  else
  if Pos( 'PIÑA', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0804.30.00'
  else
  if Pos( 'PITAYA', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0810.90.20'
  else
  if Pos( 'PLATANO DE CANARIAS', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0803.10.10'
  else
  if Pos( 'SABORSADA', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '2106.90.98'
  else
  if Pos( 'SALMOREJO', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '2009.50.90'
  else
  if Pos( 'SPREADSTO TOMATE', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '2103.90.90'
  else
  if Pos( 'TOMATE RALLADO', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '2002.90.19'
  else
  if Pos( 'UVA', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0806.10.10'                 
  else
  if Pos( 'TOMATE SECO', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '0712.90.30'
  else
  if Pos( 'ZUMO DE TOMATE', UpperCase( DMBaseDatos.QListado.FieldByName('descripcion').AsString ) ) > 0  then
    Value := '2009.50.90'
  else
    Value := '0000.00.00';
end;

procedure TQRLIntrastat.QRExpr2Print(sender: TObject; var Value: string);
begin
  Value := FormatFloat('#,##0.00', rTotalNetoGrupo);
end;

procedure TQRLIntrastat.QRExpr4Print(sender: TObject; var Value: string);
begin
  Value := FormatFloat('#,##0.00', rTotalN);
end;

procedure TQRLIntrastat.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rTotalNetoGrupo := 0;
end;

procedure TQRLIntrastat.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRGroup2.Height:= 0;
  DetailBand1.Height:= 0;
  rTotalN := 0;

  CrearQGastoAlbaran;
  CrearQAlbaranAgrupado;
end;

procedure TQRLIntrastat.PsQRDBText2Print(sender: TObject;
  var Value: String);
begin
  Value:= CapitalCase( Value );
end;

procedure TQRLIntrastat.PsQRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= CapitalCase( Value );
end;

end.
