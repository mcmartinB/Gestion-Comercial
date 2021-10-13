unit ListControlIntrasatQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, ListControlIntrasatDL, bMath;

type
  TQLListControlIntrasat = class(TQuickRep)
    bndTitulo: TQRBand;
    bndDetalle: TQRBand;
    bndPiePagina: TQRBand;
    lblImpresoEl: TQRSysData;
    lblTitulo: TQRSysData;
    lblPaginaNum: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRBand5: TQRBand;
    QRBand6: TQRBand;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBText20: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    SummaryBand1: TQRBand;
    QRExpr6: TQRExpr;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape12: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    lblRangoFechas: TQRLabel;
    lblTipo: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText21: TQRDBText;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QGastoAlbaran: TQuery;
    QAlbaranAgrupado: TQuery;
    procedure QRDBText12Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QRDBText13Print(sender: TObject; var Value: String);
    procedure QRDBText4Print(sender: TObject; var Value: String);
    procedure QRDBText14Print(sender: TObject; var Value: String);
    procedure QRDBText15Print(sender: TObject; var Value: String);
    procedure QRDBText7Print(sender: TObject; var Value: String);
    procedure QRDBText20Print(sender: TObject; var Value: String);
    procedure QRDBText19Print(sender: TObject; var Value: String);
    procedure QRDBText18Print(sender: TObject; var Value: String);
    procedure QRDBText17Print(sender: TObject; var Value: String);
    procedure QRDBText16Print(sender: TObject; var Value: String);
    procedure QRDBText21Print(sender: TObject; var Value: string);

    procedure AddGastos(var AGastoFactAlb: Real);
    function EsProductoConGasto (const AProducto: string): Boolean;
    procedure AddGastoTotal( var AGastoFac: Real );
    function PutGasto( const AUnidades: Real;  const AUnidadesTotal: string; var AFac: Real ): Boolean;
    procedure AddGastoProducto( var AGastoFac: Real );
    procedure CrearQGastoAlbaran;
    procedure CrearQAlbaranAgrupado;
    function EjecutaQGastoAlbaran (const AEmpresa, ACentro, AAlbaran, AFecha: String): Boolean;
    function EjecutaQAlbaranAgrupado (const AEmpresa, ACentro, AAlbaran, AFecha, AProducto: String): boolean;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroup5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr7Print(sender: TObject; var Value: string);
    procedure QRGroup4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRExpr8Print(sender: TObject; var Value: string);
    procedure QRExpr9Print(sender: TObject; var Value: string);
    procedure QRExpr10Print(sender: TObject; var Value: string);
    procedure QRExpr12Print(sender: TObject; var Value: string);
    procedure QRExpr11Print(sender: TObject; var Value: string);


  private
    sEmpresa: string;
    rTotalNetoProd, rTotalNetoEsTom, rTotalNetoPais, rTotalNetoCom, rTotalNetoCen, rTotalN: real;
  public

  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
procedure ExecuteReport( APadre: TComponent; AParametros: RParametrosListControlIntrasat );

implementation

{$R *.DFM}

uses UDMAuxDB, CReportes, Dpreview, Dialogs, CFactura;

var
  QLListControlIntrasat: TQLListControlIntrasat;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLListControlIntrasat:= TQLListControlIntrasat.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  ListControlIntrasatDL.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLListControlIntrasat <> nil then
        FreeAndNil( QLListControlIntrasat );
    end;
  end;
  ListControlIntrasatDL.UnloadModule;
end;

procedure ExecuteReport( APadre: TComponent; AParametros: RParametrosListControlIntrasat );
begin
  LoadReport( APadre );
  if ListControlIntrasatDL.OpenData( APadre, AParametros) <> 0 then
  begin
    QLListControlIntrasat.ReportTitle:= 'CONTROL INTRASTAT';
    if AParametros.bGrupoEmp = 0 then
      QLListControlIntrasat.sEmpresa:= '050'
    else if AParametros.bGrupoEmp = 1 then
      QLListControlIntrasat.sEmpresa:= 'F17'
    else
      QLListControlIntrasat.sEmpresa:= AParametros.sEmpresa;
    QLListControlIntrasat.lblRangoFechas.Caption:= 'Del ' + DateToStr( AParametros.dFechaDesde ) +
      ' al ' + DateToStr( AParametros.dFechaHasta );
    case AParametros.iTipo of
      0: QLListControlIntrasat.lblTipo.Caption:= '';
      1: QLListControlIntrasat.lblTipo.Caption:= 'SÓLO COMUNITARIOS';
      2: QLListControlIntrasat.lblTipo.Caption:= 'SÓLO NO COMUNITARIOS';
      3: QLListControlIntrasat.lblTipo.Caption:= DesPais( AParametros.sPais );
    end;
    PonLogoGrupoBonnysa( QLListControlIntrasat, AParametros.sEmpresa );
    Previsualiza( QLListControlIntrasat );
  end
  else
  begin
    ShowMessage('Sin datos para mostrar para los parametros de selección introducidos.');
  end;
  UnloadReport;
end;

procedure TQLListControlIntrasat.AddGastoProducto(var AGastoFac: Real);
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

procedure TQLListControlIntrasat.AddGastos(var AGastoFactAlb: Real);
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

procedure TQLListControlIntrasat.AddGastoTotal(var AGastoFac: Real);
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

procedure TQLListControlIntrasat.CrearQAlbaranAgrupado;
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

procedure TQLListControlIntrasat.CrearQGastoAlbaran;
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

function TQLListControlIntrasat.EjecutaQAlbaranAgrupado(const AEmpresa, ACentro,
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

function TQLListControlIntrasat.EjecutaQGastoAlbaran(const AEmpresa, ACentro,
  AAlbaran, AFecha: String): Boolean;
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

function TQLListControlIntrasat.EsProductoConGasto(
  const AProducto: string): Boolean;
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

function TQLListControlIntrasat.PutGasto(const AUnidades: Real; const AUnidadesTotal: string; var AFac: Real): Boolean;
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

procedure TQLListControlIntrasat.QRDBText12Print(sender: TObject;
  var Value: String);
begin
  Value:= desCentro( sEmpresa, Value );
end;

procedure TQLListControlIntrasat.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  if Value = 'S' then
    Value:= 'CLIENTES COMUNITARIOS'
  else
    Value:= 'CLIENTES NO COMUNITARIOS';
end;

procedure TQLListControlIntrasat.QRDBText13Print(sender: TObject;
  var Value: String);
begin
  Value:= DesPais( Value );
end;

procedure TQLListControlIntrasat.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  if Value = 'S' then
    Value:= 'TOMATES FRESCOS'
  else
    Value:= 'OTROS PRODUCTOS';
end;

procedure TQLListControlIntrasat.QRDBText14Print(sender: TObject;
  var Value: String);
begin
  Value:= DesProducto( sEmpresa, Value );
end;

procedure TQLListControlIntrasat.QRDBText15Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('transito').AsString = '0' then
  begin
    Value:= DesCliente( Value );
  end
  else
  begin
    Value:= DesCentro( sEmpresa, Value );
  end;
end;

procedure TQLListControlIntrasat.QRDBText7Print(sender: TObject;
  var Value: String);
begin
  if Value = '0' then
    Value:= 'S'
  else
    Value:= 'T';
end;

procedure TQLListControlIntrasat.QRExpr10Print(sender: TObject;
  var Value: string);
begin
  value := FormatFloat('#,##0.00', rTotalNetoCom);
end;

procedure TQLListControlIntrasat.QRExpr11Print(sender: TObject;
  var Value: string);
begin
  value := FormatFloat('#,##0.00', rTotalNetoCen);
end;

procedure TQLListControlIntrasat.QRExpr12Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', rTotalN);
end;

procedure TQLListControlIntrasat.QRExpr7Print(sender: TObject;
  var Value: string);
begin
  value := FormatFloat('#,##0.00', rTotalNetoProd);
end;

procedure TQLListControlIntrasat.QRExpr8Print(sender: TObject;
  var Value: string);
begin
  value := FormatFloat('#,##0.00', rTotalNetoEsTom);
end;

procedure TQLListControlIntrasat.QRExpr9Print(sender: TObject;
  var Value: string);
begin
  value := FormatFloat('#,##0.00', rTotalNetoPais);
end;

procedure TQLListControlIntrasat.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rTotalNetoCen := 0;
end;

procedure TQLListControlIntrasat.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rTotalNetoCom := 0;
end;

procedure TQLListControlIntrasat.QRGroup3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rTotalNetoPais := 0;
end;

procedure TQLListControlIntrasat.QRGroup4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rTotalNetoEsTom := 0;
end;

procedure TQLListControlIntrasat.QRGroup5BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  rTotalNetoProd := 0;
end;

procedure TQLListControlIntrasat.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  CrearQGastoAlbaran;
  CrearQAlbaranAgrupado;
  rTotalN := 0;
end;

procedure TQLListControlIntrasat.QRDBText20Print(sender: TObject;
  var Value: String);
begin
  Value:= 'KGS TOTALES DE ' + Value + ' "' + DesProducto( sEmpresa, Value ) + '" A ' +
    DesPais( DataSet.FieldByName('pais').AsString )  + ' DESDE EL CENTRO ' +
    DataSet.FieldByName('centro').AsString;;
end;

procedure TQLListControlIntrasat.QRDBText21Print(sender: TObject; var Value: string);
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

  Value := FormatFloat('#,##0.00', rTotalNeto);
  rTotalNetoProd := rTotalNetoProd + rTotalNeto;
  rTotalNetoEsTom := rTotalNetoEsTom + rTotalNeto;
  rTotalNetoPais := rTotalNetoPais + rTotalNeto;
  rTotalNetoCom := rTotalNetoCom + rTotalNeto;
  rTotalNetoCen := rTotalNetoCen + rTotalNeto;
  rTotalN := rTotalN + rTotalNeto;

end;

procedure TQLListControlIntrasat.QRDBText19Print(sender: TObject;
  var Value: String);
begin
  if Value = 'S' then
    Value:= 'KGS TOTALES DE TOMATES FRESCOS A ' + DesPais( DataSet.FieldByName('pais').AsString )
       + ' DESDE EL CENTRO ' + DataSet.FieldByName('centro').AsString
  else
    Value:= 'KGS TOTALES DE OTROS PRODUCTOS A ' + DesPais( DataSet.FieldByName('pais').AsString )
       + ' DESDE EL CENTRO ' + DataSet.FieldByName('centro').AsString;
end;

procedure TQLListControlIntrasat.QRDBText18Print(sender: TObject;
  var Value: String);
begin
  Value:= 'KGS TOTALES DE PRODUCTO A ' + DesPais( DataSet.FieldByName('pais').AsString ) +
    ' DESDE EL CENTRO ' + DataSet.FieldByName('centro').AsString;
end;

procedure TQLListControlIntrasat.QRDBText17Print(sender: TObject;
  var Value: String);
begin
  if Value = 'S' then
    Value:= 'TOTAL EXPORTACIONES COMUNITARIAS CENTRO ' + DataSet.FieldByName('centro').AsString
  else
    Value:= 'TOTAL EXPORTACIONES NO COMUNITARIAS CENTRO ' + DataSet.FieldByName('centro').AsString;
end;

procedure TQLListControlIntrasat.QRDBText16Print(sender: TObject;
  var Value: String);
begin
    Value:= 'TOTAL EXPORTACIONES DEL CENTRO ' + DataSet.FieldByName('centro').AsString;
end;

end.
