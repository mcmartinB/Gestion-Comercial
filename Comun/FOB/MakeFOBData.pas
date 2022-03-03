unit MakeFOBData;

interface

uses
  SysUtils, Classes, DB, DBClient, Provider, DBTables, kbmMemTable, MidasLib;

type
  TDMMakeFOBData = class(TDataModule)
    qryDatosAlbaran: TQuery;
    DataSource: TDataSource;
    QKilos: TQuery;
    QProductoBase: TQuery;
    QCosteEnvase: TQuery;
    qryFacturasManuales: TQuery;
    qryGastoAlbaran: TQuery;
    kmtCostesEnvasado: TkbmMemTable;
    qryCosteSeccion: TQuery;
    dbAuxSAT: TDatabase;
    qryGastosTransitosSAT: TQuery;
    kmtTransitosSAT_BAG: TkbmMemTable;
    qryKilosTransitosSAT: TQuery;
    qryTotalesBAG: TQuery;
    qryRelEnvases: TQuery;
    qryCosteEnvaseSAT: TQuery;
    qryTablaMasterFOB: TQuery;
    qryCodFactura: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    rgKilosTotal, rgKilosTransito, rgKilosProdTotal, rgKilosProdTransito: Real;
    igPaletsTotal, igPaletsTransito, igPaletsProdTotal, igPaletsProdTransito: Integer;
    igCajasTotal, igCajasTransito, igCajasProdTotal, igCajasProdTransito: Integer;
    rgImporteTotal, rgImporteTransito, rgImporteProdTotal, rgImporteProdTransito: Real;

    procedure RellenaDatosFOB;
    procedure GetKilosAlbaran(const AEmpresa, ACentro: string; const AAlbaran: Integer; const AFecha: TDateTime; const AProducto: string);

    function  GetGastosAlbaran( const AEmpresa, ACentro: string; const AAlbaran: Integer; const AFecha: TDateTime ): Boolean;
    function  EsProductoConGasto: Boolean;
    procedure AddGasto( var AGastoNoFac, AGastoFac, AGastoTransito: Real );
    procedure AddGastoTotal( var AGastoNoFac, AGastoFac, AGastoTransito: Real );
    procedure AddGastoProducto( var AGastoNoFac, AGastoFac, AGastoTransito: Real );
    function  PutGasto( const AUnidades: Real;  const AUnidadesTotal: string; var ANoFac, AFac: Real ): Boolean;

    procedure GetCostesEnvasado( const AEmpresa, ACentro, AOrigen, AEnvase, AProducto: string;
                                 const AFEcha: TDateTime; const AProductoBase: integer;
                                 var AEnvasado, ASecciones: real );
    function  CosteEnvaseDirecto( const AEmpresa, ACentro, AEnvase, AProducto: string;
                                 const AAnyo, AMes, AProductoBase: integer;
                                 var AEnvasado, ASecciones: real; var AAnyoEnvase, AMesEnvase: Integer ): integer;
    function  CosteEnvaseindirecto( const AEmpresa, ACentro, AEnvase, AProducto: string;
                                 const AAnyo, AMes, AProductoBase: integer;
                                 var AEnvasado, ASecciones: real; var AAnyoEnvase, AMesEnvase: Integer ): integer;
    function  CostesSeccionEnvase( const AEmpresa, ACentro, AEnvase, AProducto: string;
                                   const AProductoBase, AAnyo, AMes: integer ): real;
    procedure CostesEnvasesFalta;

    function  FacturasManualesEnvase( const ADias: Integer ): boolean;
    procedure AltaLineaManualListadoFOB;

    function  GastosTransitosSAT: Real;
    function  NuevoGastoTransitosSAT( const AMes: string; const AFechaIni, AFechaFin: Real ): Real;

    function   CodFactura( const AEmpresa, ASerie: string; const ANumero: Integer; const AFecha: TDateTime ): string;
  public
    { Public declarations }
    function  ObtenerDatosComunFob( const ADias: Integer ): Boolean;
  end;

var
    DMMakeFOBData: TDMMakeFOBData;
    bEnvasesSinCoste: Boolean = False;

implementation

{$R *.dfm}

uses Variants, Dialogs, CGlobal, UDMCambioMoneda,  bMath, bTimeUtils;

procedure TDMMakeFOBData.DataModuleCreate(Sender: TObject);
begin
  with QProductoBase do
  begin
    SQL.Clear;
    SQL.Add(' select producto_base_p ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where producto_p = :producto ');
    Prepare;
  end;

  with QCosteEnvase do
  begin
    SQL.Clear;
    //if CGlobal.gProgramVersion = CGlobal.pvBAG then
    //begin
      //SQL.Add('select empresa_ec, centro_ec, anyo_ec, mes_ec, ( material_ec + personal_Ec ) coste_ec, general_ec secciones_ec, ');
      //SQL.Add('                                ( material_ec + personal_Ec ) pcoste_ec, general_ec psecciones_ec ');
//    end
//    else
//    begin
    SQL.Add('select empresa_ec, centro_ec, anyo_ec, mes_ec, ( material_ec + coste_ec ) coste_ec, secciones_ec, ');
    SQL.Add('                                ( pmaterial_ec + pcoste_ec ) pcoste_ec, psecciones_ec ');
    //end;
    SQL.Add('from frf_env_costes ');
    SQL.Add('where empresa_ec = :empresa ');
    SQL.Add('and envase_ec = :envase ');
    SQL.Add('and producto_ec = :producto ');
    SQL.Add('and ( ( anyo_ec = :anyo and mes_ec <= :mes ) or ( anyo_ec < :anyo) )');
    SQL.Add('order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;

  with qryCosteSeccion do
  begin
    SQL.Clear;
//    if CGlobal.gProgramVersion = CGlobal.pvBAG then
//    begin
//      SQL.Add('select first 1 anyo_ec, mes_ec, envase_ec, general_ec secciones_ec, general_ec psecciones_ec ');
//    end
//    else
//    begin
    SQL.Add('select first 1 anyo_ec, mes_ec, envase_ec, secciones_ec, psecciones_ec ');
//  end;
    SQL.Add('from frf_env_costes ');
    SQL.Add('where empresa_Ec = :empresa ');
    SQL.Add('and centro_ec = :centro ');
    SQL.Add('and envase_ec = :envase ');
    SQL.Add('and producto_ec = :producto ');
    SQL.Add('and ( ( anyo_ec = :anyo and mes_ec <= :mes ) or ( anyo_ec < :anyo) )');
    SQL.Add('order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;

  with QKilos do
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
    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and n_albaran_sl = :albaran ');
    SQL.Add(' and fecha_sl = :fecha ');
    Prepare;
  end;

  with qryGastoAlbaran do
  begin
    Close;
    if Prepared then
      UnPrepare;
    SQL.Clear;

    (*#GASTO_TRANSITO#*)
    SQL.Add(' select producto_g producto, unidad_dist_tg unidad, gasto_transito_tg transito,');
    SQL.Add('        sum( case when facturable_tg = ''S'' ');
    SQL.Add('                  then importe_g * -1 ');
    SQL.Add('                  else 0 end ) gasto_fac, ');
    SQL.Add('        sum( case when facturable_tg <> ''S'' ');
    SQL.Add('                 then importe_g  ');
    SQL.Add('                 else 0 end ) gasto_nofac ');
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');
    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add(' and centro_salida_g = :centro ');
    SQL.Add(' and n_albaran_g = :albaran ');
    SQL.Add(' and fecha_g = :fecha ');
    SQL.Add(' and tipo_tg = tipo_g ');
    SQL.Add(' group by producto, unidad, transito ');
    Prepare;
  end;

  kmtCostesEnvasado.FieldDefs.Clear;
  kmtCostesEnvasado.FieldDefs.Add('empresa_ec', ftString, 3, False);
  kmtCostesEnvasado.FieldDefs.Add('centro_ec', ftString, 3, False);
  kmtCostesEnvasado.FieldDefs.Add('envase_ec', ftString, 9,  False);
  kmtCostesEnvasado.FieldDefs.Add('producto_ec', ftString, 3, False);
  kmtCostesEnvasado.FieldDefs.Add('origen_ec', ftString, 3, False);
  kmtCostesEnvasado.FieldDefs.Add('anyo_ec', ftInteger, 0, False);
  kmtCostesEnvasado.FieldDefs.Add('mes_ec', ftInteger, 0, False);

  kmtCostesEnvasado.FieldDefs.Add('coste_ec', ftFloat, 0, False);
  kmtCostesEnvasado.FieldDefs.Add('secciones_ec', ftFloat, 0, False);

  kmtCostesEnvasado.FieldDefs.Add('existe', ftInteger, 0, False);
  kmtCostesEnvasado.FieldDefs.Add('anyo', ftInteger, 0, False);
  kmtCostesEnvasado.FieldDefs.Add('mes', ftInteger, 0, False);
  kmtCostesEnvasado.CreateTable;
  kmtCostesEnvasado.Open;

  (*TODO*)(*PARCHE*)(*Calculo costes transitos hortalizas de SAT a BAG*)
  with qryGastosTransitosSAT do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_g) importe ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add('     join frf_gastos on empresa_g = empresa_sc and centro_salida_g = centro_salida_sc and fecha_g = fecha_sc and n_albaran_g = n_albaran_sc ');
    SQL.Add(' where empresa_sc = ''080'' ');
    SQL.Add('  and fecha_sc between :fechaini and :fechafin ');
    SQL.Add('  and cliente_sal_sc = ''BAG'' ');
    SQL.Add('  and exists ');
    SQL.Add('          ( select * from frf_salidas_l ');
    SQL.Add('            where empresa_sl = empresa_sc and centro_salida_sl = centro_salida_sc and fecha_sl = fecha_sc and n_albaran_sl = n_albaran_sc ');
    SQL.Add('            and producto_sl = :producto  and centro_origen_sl = ''6'' )  ');
  end;

  with qryKilosTransitosSAT do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) kilos ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = ''080'' ');
    SQL.Add(' and fecha_sl between  :fechaini and :fechafin ');
    SQL.Add(' and producto_sl = :producto ');
    SQL.Add(' and cliente_sl = ''BAG'' ');
    SQL.Add(' and centro_origen_sl = ''6'' ');
  end;

  with qryTotalesBAG do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) kilos ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where substr(empresa_sl,1,1) = ''F'' ');
    SQL.Add(' and empresa_sl <> ''F23'' ');
    SQL.Add(' and fecha_sl between  :fechaini and :fechafin ');
    SQL.Add(' and producto_sl = :producto ');
  end;

  kmtTransitosSAT_BAG.FieldDefs.Clear;
  kmtTransitosSAT_BAG.FieldDefs.Add('mes', ftString, 6, False);
  kmtTransitosSAT_BAG.FieldDefs.Add('producto', ftString, 3, False);
  kmtTransitosSAT_BAG.FieldDefs.Add('coste', ftFloat, 0, False);
  kmtTransitosSAT_BAG.IndexFieldNames:= 'mes';
  kmtTransitosSAT_BAG.CreateTable;
  kmtTransitosSAT_BAG.Open;

  (*TODO*)(*PARCHE*)(*Buscar costes de envasado de BAG en SAT*)
  with qryRelEnvases do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from rel_envases_sat_bag ');
    SQL.Add(' where envase_bag_esb = :envase ');
  end;

  with qryCosteEnvaseSAT do
  begin
    SQL.Clear;
    SQL.Add('select empresa_ec, centro_ec, anyo_ec, mes_ec, ( material_ec + coste_ec ) coste_ec, secciones_ec, ');
    SQL.Add('                                ( pmaterial_ec + pcoste_ec ) pcoste_ec, psecciones_ec ');
    SQL.Add('from frf_env_costes ');
    SQL.Add('where empresa_ec = :empresa ');
    SQL.Add('and envase_ec = :envase ');
    SQL.Add('and ( ( anyo_ec = :anyo and mes_ec <= :mes ) or ( anyo_ec < :anyo) )');
    SQL.Add('order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;

  with qryCodFactura do
  begin
    SQL.Clear;
    SQL.Add(' select cod_factura_fc ');
    SQL.Add(' from tfacturas_cab ');
    SQL.Add(' where cod_empresa_fac_fc = :empresa ');
    SQL.Add(' and cod_serie_fac_fc = :serie ');
    SQL.Add(' and fecha_factura_fc = :fecha ');
    SQL.Add(' and n_factura_fc = :numero ');
    Prepare;
  end;
end;

procedure TDMMakeFOBData.DataModuleDestroy(Sender: TObject);
begin
  kmtCostesEnvasado.Close;
  //mtListado.Close;

  QKilos.Close;
  qryGastoAlbaran.Close;
  QProductoBase.Close;
  QCosteEnvase.Close;
  qryCosteSeccion.Close;

  kmtTransitosSAT_BAG.Close;
  qryGastosTransitosSAT.Close;
  qryKilosTransitosSAT.Close;
  qryTotalesBAG.Close;
  if dbAuxSAT.Connected then
    dbAuxSAT.Close;

  QKilos.UnPrepare;
  qryGastoAlbaran.UnPrepare;
  QProductoBase.UnPrepare;
  QCosteEnvase.UNPrepare;
  qryCosteSeccion.UNPrepare;
end;

function SQLCategoriasComerciales( const AEmpresa: string ): string;
begin
  //CategoriasComerciales
  if ( AEmpresa = '050' ) or ( AEmpresa = '080' ) or ( AEmpresa = 'SAT' ) then
  begin
    result:= ' AND   ((categoria_sl = "1") or (categoria_sl = "2") or (categoria_sl = "3")) ';
  end
  else
  begin
    result:= '';
  end;
end;

function TDMMakeFOBData.ObtenerDatosComunFob( const ADias: Integer ): Boolean;
var
  bAux: boolean;
begin
  qryTablaMasterFOB.Close;
  qryTablaMasterFOB.SQL.Clear;
  qryTablaMasterFOB.SQL.Add(' delete from tfob_data ');
  if gProgramVersion = pvBAG then
    qryTablaMasterFOB.SQL.Add(' WHERE base_datos_fd = ''BAG'' ')
  else
    qryTablaMasterFOB.SQL.Add(' WHERE base_datos_fd = ''SAT'' ');
  qryTablaMasterFOB.SQL.Add(' and fecha_albaran_fd >= :fechadesde  ');
  qryTablaMasterFOB.ParamByName('fechadesde').AsDateTime:= Now - ADias;
  qryTablaMasterFOB.ExecSQL;

  with qryTablaMasterFOB do
  begin
    SQL.Clear;
    SQL.Add( 'select * From tfob_data ');;
    Open;
  end;

  qryDatosAlbaran.SQL.Clear;
  qryDatosAlbaran.SQL.Add(' SELECT empresa_sl empresa, cliente_sl cliente, dir_sum_sc suministro, producto_sl producto, n_albaran_sc albaran,  n_orden_sc orden_carga, envase_sl envase, ');
  qryDatosAlbaran.SQL.Add(' nvl(( select descripcion_lp from frf_linea_productos where linea_producto_lp = linea_producto_e ) ,''SIN ASIGNAR'') linea, ');

  //Comercial
  qryDatosAlbaran.SQL.Add('        nvl( comercial_sl,''000'') comercial, empresa_fac_sc, serie_fac_sc, fecha_factura_sc fecha_factura, n_factura_sc n_factura, ');

  qryDatosAlbaran.SQL.Add('        centro_salida_sc centro, fecha_sc fecha, moneda_sc moneda, categoria_sl categoria,');
  qryDatosAlbaran.SQL.Add('        nvl(agrupa_comercial_e,''SIN AGRUPACION'') agrupacion, ');
  qryDatosAlbaran.SQL.Add('        calibre_sl calibre, SUM(NVL(kilos_sl,0)) kilos_producto,');

  qryDatosAlbaran.SQL.Add('        SUM(NVL(cajas_sl,0)) cajas_producto, SUM(NVL(cajas_sl,0)*NVL(unidades_caja_sl,1)) unidades_producto, SUM(NVL(n_palets_sl,0)) palets_producto,');


  qryDatosAlbaran.SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0), 2) ) importe, ');
  (*TODO*) //primero descuento facturable, despues comison facturabe, despues descuento normal
  qryDatosAlbaran.SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0)* ');
  qryDatosAlbaran.SQL.Add('              ((GetDescuentoCliente( empresa_sl, cliente_sl, fecha_sl, 1 )/100)), 2) + ');
  qryDatosAlbaran.SQL.Add('              Round( NVL(importe_neto_sl,0)* ');
  qryDatosAlbaran.SQL.Add('             (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 1 )/100))* ');
  qryDatosAlbaran.SQL.Add('             ((GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100)), 2) ) comision, ');

  qryDatosAlbaran.SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0)* ');
  qryDatosAlbaran.SQL.Add('             (1-(GetDescuentoCliente( empresa_sl, cliente_sl, fecha_sl, 1 )/100))* ');
  qryDatosAlbaran.SQL.Add('             (1-(GetComisionCliente( empresa_sl, cliente_sl, fecha_sl )/100))* ');
  qryDatosAlbaran.SQL.Add('             ((GetDescuentoCliente( empresa_sl, cliente_sl, fecha_sl, 0 )/100)), 2) ) descuento, ');

  qryDatosAlbaran.SQL.Add('        CASE WHEN ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ');
  qryDatosAlbaran.SQL.Add('                 THEN 1 ELSE 0 END Transito, ');
  qryDatosAlbaran.SQL.Add('        centro_origen_sl centro_origen, case when fecha_factura_sc is null then 0 else 1 end facturado ');

  qryDatosAlbaran.SQL.Add(' from frf_salidas_c ');
  qryDatosAlbaran.SQL.Add('       join frf_salidas_l on empresa_sl = empresa_sc and centro_salida_sl = centro_salida_sc ');
  qryDatosAlbaran.SQL.Add('                      and n_albaran_sl = n_albaran_sc  and fecha_sl = fecha_sc ');
  qryDatosAlbaran.SQL.Add('       join frf_clientes on cliente_c = cliente_fac_sc ');
  qryDatosAlbaran.SQL.Add('       join frf_envases on envase_e = envase_sl ');

  if gProgramVersion = pvBAG then
    qryDatosAlbaran.SQL.Add(' WHERE (empresa_sc[1,1] = ''F'' ) ')
  else
    qryDatosAlbaran.SQL.Add(' WHERE (empresa_sc = ''050'' or empresa_sc = ''080'') ');
  qryDatosAlbaran.SQL.Add(' AND   fecha_sc >= :fechadesde  ');

  qryDatosAlbaran.SQL.Add(' GROUP BY empresa, cliente, suministro, producto, orden_carga, linea, albaran,  envase, comercial, ');
  qryDatosAlbaran.SQL.Add('          centro, fecha, moneda, categoria, agrupacion, calibre, empresa_fac_sc, serie_fac_sc, fecha_factura, n_factura, ');
  qryDatosAlbaran.SQL.Add('          Transito, centro_origen, facturado ');
  qryDatosAlbaran.SQL.Add(' ORDER BY cliente_sl, empresa, centro_salida_sc, n_albaran_sc, fecha_sc, moneda_sc, envase_sl ');

  qryDatosAlbaran.ParamByName('fechadesde').AsDateTime:= Now - ADias;

  //Query.Sql.SaveToFile('c:\pepe.sql');
  qryDatosAlbaran.Open;
  if not qryDatosAlbaran.IsEmpty then
  begin
    RellenaDatosFOB;
    result := True;
  end
  else
  begin
    result := False;
  end;
  bAux:= FacturasManualesEnvase( ADias );
  result:= result or  bAux;
end;

function TDMMakeFOBData.CodFactura( const AEmpresa, ASerie: string; const ANumero: Integer; const AFecha: TDateTime ): string;
begin
  with qryCodFactura  do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('serie').AsString:= ASerie;
    ParamByName('numero').AsInteger:= ANumero;
    ParamByName('fecha').AsDatetime:= AFecha;
    Open;
    Result:= FieldByName('cod_factura_fc').AsString;
    Close;
  end;
end;

procedure TDMMakeFOBData.RellenaDatosFOB;
var
  iAlbaran, iProductoBase: integer;
  fFactorCambio: Real;
  rCosteEnvase, rCosteSecciones: Real;
  bHayGasto: Boolean;
  rGastoNoFac, rGastoFac, rGastoTransito: Real;
  sAlbaranProd: string;
begin
  fFactorCambio := 1;
  iAlbaran := 0;
  sAlbaranProd:= '';
  rCosteEnvase:= 0;
  rCosteSecciones:= 0;
  bHayGasto:= False;

  qryDatosAlbaran.First;
  while not qryDatosAlbaran.Eof do
  begin
    qryTablaMasterFOB.Insert;

    if gProgramVersion = pvBAG then
      qryTablaMasterFOB.FieldByName('base_datos_fd').AsString:= 'BAG'
    else
      qryTablaMasterFOB.FieldByName('base_datos_fd').AsString:= 'SAT';
    qryTablaMasterFOB.FieldByName('empresa_fd').AsString:= qryDatosAlbaran.FieldByName('empresa').AsString;
    qryTablaMasterFOB.FieldByName('centro_origen_fd').AsString:= qryDatosAlbaran.FieldByName('centro_origen').AsString;
    qryTablaMasterFOB.FieldByName('centro_salida_fd').AsString:= qryDatosAlbaran.FieldByName('centro').AsString;
    qryTablaMasterFOB.FieldByName('cliente_fd').AsString:= qryDatosAlbaran.FieldByName('cliente').AsString;
    qryTablaMasterFOB.FieldByName('suministro_fd').AsString:= qryDatosAlbaran.FieldByName('suministro').AsString;
    qryTablaMasterFOB.FieldByName('n_albaran_fd').AsInteger:= qryDatosAlbaran.FieldByName('albaran').AsInteger;
    //orden_carga
    qryTablaMasterFOB.FieldByName('fecha_albaran_fd').AsDateTime:= qryDatosAlbaran.FieldByName('fecha').AsDateTime;
    qryTablaMasterFOB.FieldByName('producto_fd').AsString:= qryDatosAlbaran.FieldByName('producto').AsString;
    qryTablaMasterFOB.FieldByName('agrupacion_comercial_fd').AsString:= qryDatosAlbaran.FieldByName('agrupacion').AsString;
    qryTablaMasterFOB.FieldByName('linea_fd').AsString:= qryDatosAlbaran.FieldByName('linea').AsString;
    qryTablaMasterFOB.FieldByName('envase_fd').AsString:= qryDatosAlbaran.FieldByName('envase').AsString;
    qryTablaMasterFOB.FieldByName('categoria_fd').AsString:= qryDatosAlbaran.FieldByName('categoria').AsString;
    qryTablaMasterFOB.FieldByName('calibre_fd').AsString:= qryDatosAlbaran.FieldByName('calibre').AsString;

    qryTablaMasterFOB.FieldByName('transito_fd').AsInteger:= qryDatosAlbaran.FieldByName('Transito').AsInteger;
    qryTablaMasterFOB.FieldByName('moneda_fd').AsString:= qryDatosAlbaran.FieldByName('moneda').AsString;
    qryTablaMasterFOB.FieldByName('facturado_fd').AsInteger:= qryDatosAlbaran.FieldByName('facturado').AsInteger;
    qryTablaMasterFOB.FieldByName('comercial_fd').AsString:= qryDatosAlbaran.FieldByName('comercial').AsString;
    qryTablaMasterFOB.FieldByName('cod_factura_fd').AsString:= CodFactura( qryDatosAlbaran.FieldByName('empresa_fac_sc').AsString,
                                                                           qryDatosAlbaran.FieldByName('serie_fac_sc').AsString,
                                                                           qryDatosAlbaran.FieldByName('n_factura').AsInteger,
                                                                           qryDatosAlbaran.FieldByName('fecha_factura').AsDateTime );
    qryTablaMasterFOB.FieldByName('n_factura_fd').AsInteger:= qryDatosAlbaran.FieldByName('n_factura').AsInteger;
    qryTablaMasterFOB.FieldByName('fecha_factura_fd').AsDateTime:= qryDatosAlbaran.FieldByName('fecha_factura').AsDateTime;

    qryTablaMasterFOB.FieldByName('palets_producto_fd').AsInteger:= qryDatosAlbaran.FieldByName('palets_producto').AsInteger;
    qryTablaMasterFOB.FieldByName('kilos_producto_fd').AsFloat:= qryDatosAlbaran.FieldByName('kilos_producto').AsFloat;
    qryTablaMasterFOB.FieldByName('cajas_producto_fd').AsInteger:= qryDatosAlbaran.FieldByName('cajas_producto').AsInteger;
    qryTablaMasterFOB.FieldByName('unidades_producto_fd').AsInteger:= qryDatosAlbaran.FieldByName('unidades_producto').AsInteger;

    if iAlbaran <> qryDatosAlbaran.FieldByName('albaran').AsInteger then
    begin
      iAlbaran := qryDatosAlbaran.FieldByName('albaran').AsInteger;

      fFactorCambio := FactorCambioFOB(qryDatosAlbaran.FieldByName('empresa').AsString,
        qryDatosAlbaran.FieldByName('centro').AsString,
        qryDatosAlbaran.FieldByName('fecha').AsString,
        qryDatosAlbaran.FieldByName('albaran').AsString,
        qryDatosAlbaran.FieldByName('moneda').AsString);
      if fFactorCambio = 0 then fFactorCambio := 1;
    end;
    qryTablaMasterFOB.FieldByName('cambio_fd').AsFloat:= fFactorCambio;

    if sAlbaranProd <> qryDatosAlbaran.FieldByName('empresa').AsString + qryDatosAlbaran.FieldByName('albaran').AsString + qryDatosAlbaran.FieldByName('producto').AsString then
    begin
      sAlbaranProd:= qryDatosAlbaran.FieldByName('empresa').AsString + qryDatosAlbaran.FieldByName('albaran').AsString + qryDatosAlbaran.FieldByName('producto').AsString;

      GetKilosAlbaran( qryDatosAlbaran.FieldByName('empresa').AsString, qryDatosAlbaran.FieldByName('centro').AsString, qryDatosAlbaran.FieldByName('albaran').AsInteger,
        qryDatosAlbaran.FieldByName('fecha').AsDateTime, qryDatosAlbaran.FieldByName('producto').AsString);


      bHayGasto:= GetGastosAlbaran( qryDatosAlbaran.FieldByName('empresa').AsString, qryDatosAlbaran.FieldByName('centro').AsString,
          qryDatosAlbaran.FieldByName('albaran').AsInteger, qryDatosAlbaran.FieldByName('fecha').AsDateTime  );
    end;
    {
    rgKilosProdTotal, : Real;
    rgPaletsProdTotal, : Real;
    rgCajasProdTotal, : Real;
    rgImporteTotal, rgImporteTransito, rgImporteProdTotal, rgImporteProdTransito: Real;
    }
    qryTablaMasterFOB.FieldByName('palets_total_fd').AsInteger:= igPaletsTotal;
    qryTablaMasterFOB.FieldByName('kilos_total_fd').AsFloat:= rgKilosTotal;
    qryTablaMasterFOB.FieldByName('cajas_total_fd').AsInteger:= igCajasTotal;
    qryTablaMasterFOB.FieldByName('unidades_total_fd').AsInteger:= 0;
    qryTablaMasterFOB.FieldByName('palets_transito_producto_fd').AsInteger:= igPaletsProdTransito;
    qryTablaMasterFOB.FieldByName('kilos_transito_producto_fd').AsFloat:= rgKilosProdTransito;
    qryTablaMasterFOB.FieldByName('cajas_transito_producto_fd').AsInteger:= igCajasProdTransito;
    qryTablaMasterFOB.FieldByName('unidades_transito_producto_fd').AsInteger:= 0;
    qryTablaMasterFOB.FieldByName('palets_transito_total_fd').AsInteger:= igPaletsTransito;
    qryTablaMasterFOB.FieldByName('kilos_transito_total_fd').AsFloat:= rgKilosTransito;
    qryTablaMasterFOB.FieldByName('cajas_transito_total_fd').AsInteger:= igCajasTransito;
    qryTablaMasterFOB.FieldByName('unidades_transito_total_fd').AsInteger:= 0;


    QProductoBase.ParamByName('producto').AsString:= qryDatosAlbaran.FieldByName('producto').AsString;
    QProductoBase.Open;
    iProductoBase:= QProductoBase.FieldByName('producto_base_p').AsInteger;
    QProductoBase.Close;

    GetCostesEnvasado(qryDatosAlbaran.FieldByName('empresa').AsString,
                          qryDatosAlbaran.FieldByName('centro').AsString,
                          qryDatosAlbaran.FieldByName('centro_origen').AsString,
                          qryDatosAlbaran.FieldByName('envase').AsString,
                          qryDatosAlbaran.FieldByName('producto').AsString,
                          qryDatosAlbaran.FieldByName('fecha').AsDateTime,
                          iProductoBase, rCosteEnvase, rCosteSecciones ); //APromedio:= true
    if bHayGasto then
    begin
      AddGasto(  rGastoNoFac, rGastoFac, rGastoTransito );
    end
    else
    begin
      rGastoNoFac:= 0;
      rGastoFac:= 0;
      rGastoTransito:= 0;
    end;
    rGastoTransito:= rGastoTransito + GastosTransitosSAT;

    qryTablaMasterFOB.FieldByName('importe_fd').AsFloat:= qryDatosAlbaran.FieldByName('importe').AsFloat;
    qryTablaMasterFOB.FieldByName('comision_fd').AsFloat:= qryDatosAlbaran.FieldByName('comision').AsFloat;
    qryTablaMasterFOB.FieldByName('gasto_facturable_fd').AsFloat:= rGastoFac;
    qryTablaMasterFOB.FieldByName('base_fd').AsFloat:= qryTablaMasterFOB.FieldByName('importe_fd').AsFloat -
      ( qryTablaMasterFOB.FieldByName('comision_fd').AsFloat + qryTablaMasterFOB.FieldByName('gasto_facturable_fd').AsFloat );
    qryTablaMasterFOB.FieldByName('descuento_fd').AsFloat:= qryDatosAlbaran.FieldByName('descuento').AsFloat;
    qryTablaMasterFOB.FieldByName('gasto_comun_fd').AsFloat:= rGastoNoFac;
    qryTablaMasterFOB.FieldByName('gasto_transito_fd').AsFloat:= rGastoTransito;
    qryTablaMasterFOB.FieldByName('coste_envase_fd').AsFloat:= bRoundTo( rCosteEnvase * qryDatosAlbaran.FieldByName('kilos_producto').AsFloat, -3);
    qryTablaMasterFOB.FieldByName('coste_seccion_fd').AsFloat:= bRoundTo( rCosteSecciones * qryDatosAlbaran.FieldByName('kilos_producto').AsFloat, -3);
    qryTablaMasterFOB.FieldByName('coste_envasado_fd').AsFloat:= qryTablaMasterFOB.FieldByName('coste_seccion_fd').AsFloat + qryTablaMasterFOB.FieldByName('coste_envase_fd').AsFloat;
    qryTablaMasterFOB.FieldByName('neto_fd').AsFloat:= qryTablaMasterFOB.FieldByName('base_fd').AsFloat -
     ( qryTablaMasterFOB.FieldByName('descuento_fd').AsFloat + qryTablaMasterFOB.FieldByName('gasto_comun_fd').AsFloat +
       qryTablaMasterFOB.FieldByName('gasto_transito_fd').AsFloat + qryTablaMasterFOB.FieldByName('coste_envasado_fd').AsFloat );


    qryTablaMasterFOB.Post;
    qryDatosAlbaran.Next;
  end;
  qryGastoAlbaran.Close;

  if bEnvasesSinCoste then
    CostesEnvasesFalta;
end;

procedure TDMMakeFOBData.CostesEnvasesFalta;
var
  sAux, sEnvase: string;
  bFlag: Boolean;
begin
  sAux:= 'ENVASES SIN COSTE GRABADO';


  kmtCostesEnvasado.SortFields:= 'empresa_ec;centro_ec;envase_ec';
  kmtCostesEnvasado.Sort([]);
  kmtCostesEnvasado.First;
  bFlag:= False;
  sEnvase:= '';
  while not kmtCostesEnvasado.Eof do
  begin
    if kmtCostesEnvasado.FieldByName('existe').AsInteger = -1 then
    begin
      bFlag:= True;
      if sEnvase <> kmtCostesEnvasado.FieldByName('empresa_ec').AsString +
                    kmtCostesEnvasado.FieldByName('centro_ec').AsString +
                    kmtCostesEnvasado.FieldByName('envase_ec').AsString  then
      begin
        sAux:= sAux + #13 + #10 + kmtCostesEnvasado.FieldByName('empresa_ec').AsString + ' - ' +
               kmtCostesEnvasado.FieldByName('centro_ec').AsString + ' - ' +
               kmtCostesEnvasado.FieldByName('envase_ec').AsString;{ + ' - ' +
               desEnvase( kmtCostesEnvasado.FieldByName('empresa_ec').AsString,
                          kmtCostesEnvasado.FieldByName('envase_ec').AsString ) ;}
        sEnvase:= kmtCostesEnvasado.FieldByName('empresa_ec').AsString +
                    kmtCostesEnvasado.FieldByName('centro_ec').AsString +
                    kmtCostesEnvasado.FieldByName('envase_ec').AsString;
      end;
    end;

    kmtCostesEnvasado.Next;
  end;
  kmtCostesEnvasado.First;
  if bFlag then
    ShowMessage( sAux );
end;


procedure TDMMakeFOBData.GetKilosAlbaran(
      const AEmpresa, ACentro: string; const AAlbaran: Integer; const AFecha: TDateTime; const AProducto: string);
begin
  with QKilos do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsInteger := AAlbaran;
    ParamByName('fecha').AsDateTime := AFecha;
    ParamByName('producto').AsString := AProducto;

    Open;
    rgKilosTotal := FieldByName('total_kilos').AsFloat;
    rgKilosTransito := FieldByName('transito_kilos').AsFloat;
    rgKilosProdTotal := FieldByName('total_prod_kilos').AsFloat;
    rgKilosProdTransito := FieldByName('transito_prod_kilos').AsFloat;

    igPaletsTotal := FieldByName('total_palets').AsInteger;
    igPaletsTransito := FieldByName('transito_palets').AsInteger;
    igPaletsProdTotal := FieldByName('total_prod_palets').AsInteger;
    igPaletsProdTransito := FieldByName('transito_prod_palets').AsInteger;

    igCajasTotal := FieldByName('total_cajas').AsInteger;
    igCajasTransito := FieldByName('transito_cajas').AsInteger;
    igCajasProdTotal := FieldByName('total_prod_cajas').AsInteger;
    igCajasProdTransito := FieldByName('transito_prod_cajas').AsInteger;

    rgImporteTotal := FieldByName('total_importe').AsFloat;
    rgImporteTransito := FieldByName('transito_importe').AsFloat;
    rgImporteProdTotal := FieldByName('total_prod_importe').AsFloat;
    rgImporteProdTransito := FieldByName('transito_prod_importe').AsFloat;
    Close;
  end;
end;

function TDMMakeFOBData.GetGastosAlbaran( const AEmpresa, ACentro: string;
                                               const AAlbaran: Integer; const AFecha: TDateTime ): Boolean;
begin
  //Todos los gastos
  with qryGastoAlbaran do
  begin
    if Active then
      Close;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsInteger := AAlbaran;
    ParamByName('fecha').AsDateTime := AFecha;
    Open;
    Result:= not isempty;
  end;
end;

function TDMMakeFOBData.EsProductoConGasto: Boolean;
begin
  if qryGastoAlbaran.fieldByName('producto').AsString = '' then
  begin
    result:= True;
  end
  else
  if qryDatosAlbaran.FieldByName('producto').AsString = qryGastoAlbaran.fieldByName('producto').AsString then
  begin
    result:= True;
  end
  else
  begin
    result:= False;
  end;
end;

function TDMMakeFOBData.PutGasto( const AUnidades: Real;  const AUnidadesTotal: string; var ANoFac, AFac: Real ): Boolean;
var
  rAux: Real;
begin
  if ( AUnidades > 0 ) and ( qryDatosAlbaran.FieldByName( AUnidadesTotal ).AsFloat  > 0 )then
  begin
    rAux:= qryDatosAlbaran.FieldByName( AUnidadesTotal ).AsFloat / AUnidades;
    ANoFac:= ANoFac +  qryGastoAlbaran.fieldByName('gasto_nofac').AsFloat * rAux;
    AFac:= AFac +  qryGastoAlbaran.fieldByName('gasto_fac').AsFloat * rAux;
    result:= True;
  end
  else
  begin
    result:= False;
  end;
end;

procedure TDMMakeFOBData.AddGastoTotal( var AGastoNoFac, AGastoFac, AGastoTransito: Real );

begin
  if qryGastoAlbaran.fieldByName('transito').AsInteger = 1 then
  begin
    //KILOGRAMOS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'K' then
    begin
      PutGasto( rgKilosTransito, 'kilos_producto',  AGastoTransito, AGastoFac );
    end
    else
    //CAJAS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'C' then
    begin
      if not PutGasto( igCajasTransito, 'cajas_producto',  AGastoTransito, AGastoFac ) then
      begin
        PutGasto( rgKilosTransito, 'kilos_producto',  AGastoTransito, AGastoFac );
      end;
    end
    else
    //PALETS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'P' then
    begin
      if not PutGasto( igPaletsTransito, 'palets_producto',  AGastoTransito, AGastoFac ) then
      begin
        if not PutGasto( igCajasTransito, 'cajas_producto',  AGastoTransito, AGastoFac ) then
        begin
          PutGasto( rgKilosTransito, 'kilos_producto',  AGastoTransito, AGastoFac );
        end;
      end;
    end
    else
    //IMPORTE
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'I' then
    begin
      if not PutGasto( rgImporteTransito, 'importe',  AGastoTransito, AGastoFac ) then
      begin
        PutGasto( rgKilosTransito, 'kilos_producto',  AGastoTransito, AGastoFac );
      end;
    end;
  end
  else
  begin
    //KILOGRAMOS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'K' then
    begin
      PutGasto( rgKilosTotal, 'kilos_producto', AGastoNoFac, AGastoFac );
    end
    else
    //CAJAS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'C' then
    begin
      if not PutGasto( igCajasTotal, 'cajas_producto',  AGastoNoFac, AGastoFac ) then
      begin
        PutGasto( rgKilosTotal, 'kilos_producto',  AGastoNoFac, AGastoFac );
      end;
    end
    else
    //PALETS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'P' then
    begin
      if not PutGasto( igPaletsTotal, 'palets_producto',  AGastoNoFac, AGastoFac ) then
      begin
        if not PutGasto( igCajasTotal, 'cajas_producto',  AGastoNoFac, AGastoFac ) then
        begin
          PutGasto( rgKilosTotal, 'kilos_producto',  AGastoNoFac, AGastoFac );
        end;
      end;
    end
    else
    //IMPORTE
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'I' then
    begin
      if not PutGasto( rgImporteTotal, 'importe',  AGastoNoFac, AGastoFac ) then
      begin
        PutGasto( rgKilosTotal, 'kilos_producto',  AGastoNoFac, AGastoFac );
      end;
    end;
  end;

end;

procedure TDMMakeFOBData.AddGastoProducto( var AGastoNoFac, AGastoFac, AGastoTransito: Real );
begin
  if qryGastoAlbaran.fieldByName('transito').AsInteger = 1 then
  begin
    //KILOGRAMOS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'K' then
    begin
      PutGasto( rgKilosProdTransito, 'kilos_producto',  AGastoTransito, AGastoFac );
    end
    else
    //CAJAS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'C' then
    begin
      if not PutGasto( igCajasProdTransito, 'cajas_producto',  AGastoTransito, AGastoFac ) then
      begin
        PutGasto( rgKilosProdTransito, 'kilos_producto',  AGastoTransito, AGastoFac );
      end;
    end
    else
    //PALETS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'P' then
    begin
      if not PutGasto( igPaletsProdTransito, 'palets_producto',  AGastoTransito, AGastoFac ) then
      begin
        if not PutGasto( igCajasProdTransito, 'cajas_producto',  AGastoTransito, AGastoFac ) then
        begin
          PutGasto( rgKilosProdTransito, 'kilos_producto',  AGastoTransito, AGastoFac );
        end;
      end;
    end
    else
    //IMPORTE
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'I' then
    begin
      if not PutGasto( rgImporteProdTransito, 'importe',  AGastoTransito, AGastoFac ) then
      begin
        PutGasto( rgKilosProdTransito, 'kilos_producto',  AGastoTransito, AGastoFac );
      end;
    end;
  end
  else
  begin
    //KILOGRAMOS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'K' then
    begin
      PutGasto( rgKilosProdTotal, 'kilos_producto', AGastoNoFac, AGastoFac );
    end
    else
    //CAJAS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'C' then
    begin
      if not PutGasto( igCajasProdTotal, 'cajas_producto',  AGastoNoFac, AGastoFac ) then
      begin
        PutGasto( rgKilosProdTotal, 'kilos_producto',  AGastoNoFac, AGastoFac );
      end;
    end
    else
    //PALETS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'P' then
    begin
      if not PutGasto( igPaletsProdTotal, 'palets_producto',  AGastoNoFac, AGastoFac ) then
      begin
        if not PutGasto( igCajasProdTotal, 'cajas_producto',  AGastoNoFac, AGastoFac ) then
        begin
          PutGasto( rgKilosProdTotal, 'kilos_producto',  AGastoNoFac, AGastoFac );
        end;
      end;
    end
    else
    //IMPORTE
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'I' then
    begin
      if not PutGasto( rgImporteProdTotal, 'importe',  AGastoNoFac, AGastoFac ) then
      begin
        PutGasto( rgKilosProdTotal, 'kilos_producto',  AGastoNoFac, AGastoFac );
      end;
    end;
  end;
end;

procedure TDMMakeFOBData.AddGasto( var AGastoNoFac, AGastoFac, AGastoTransito: Real );
begin
  AGastoNoFac:= 0;
  AGastoFac:= 0;
  AGastoTransito:= 0;

  qryGastoAlbaran.First;
  while not qryGastoAlbaran.Eof do
  begin
    if EsProductoConGasto then
    begin
      if qryGastoAlbaran.fieldByName('producto').AsString = '' then
        AddGastoTotal( AGastoNoFac, AGastoFac, AGastoTransito )
      else
        AddGastoProducto( AGastoNoFac, AGastoFac, AGastoTransito );
    end;
    qryGastoAlbaran.next;
  end;
end;




function TDMMakeFOBData.CostesSeccionEnvase( const AEmpresa, ACentro, AEnvase, AProducto: string;
                                                   const AProductoBase, AAnyo, AMes: integer  ): real;
begin
  if ( qryDatosAlbaran.FieldByName('empresa').AsString = '080' ) or
     ( qryDatosAlbaran.FieldByName('empresa').AsString = '050' ) then
  with qryCosteSeccion do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('envase').AsString := AEnvase;
    ParamByName('producto').AsString := AProducto;
    ParamByName('anyo').AsInteger := AAnyo;
    ParamByName('mes').AsInteger := AMes;
    try
      Open;
      Result:= FieldByName('psecciones_ec').AsFloat;
    finally
      Close;
    end;
  end
  else
  begin
    Result:= 0;
  end;
end;

function TDMMakeFOBData.CosteEnvaseDirecto( const AEmpresa, ACentro, AEnvase, AProducto: string;
  const AAnyo, AMes, AProductoBase: integer;
  var AEnvasado, ASecciones: real; var AAnyoEnvase, AMesEnvase: Integer ): integer;
begin
    with QCosteEnvase do
    begin
      Filtered:= False;
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('envase').AsString := AEnvase;
      ParamByName('producto').AsString := AProducto;
      ParamByName('anyo').AsInteger := AAnyo;
      ParamByName('mes').AsInteger := AMes;
      try
        Open;
        if IsEmpty then
        begin
          //raise Exception.Create('Sin coste de envasado para el artículo "' + AEnvase + '" producto base "' + IntToStr( AProductoBase ) + '".');
          result:= -1;
        end
        else
        begin
          result:= 1;
          Filter:= '';
          Filtered:= True;
          Filter:= 'centro_ec = ' + QuotedStr( ACentro );
          if IsEmpty then
          begin
            result:= 0;
            Filter:= '';
          end;
        end;
        First;
        //if bAPromedio then
        begin
          AEnvasado := FieldByName('pcoste_ec').AsFloat;
          ASecciones := FieldByName('psecciones_ec').AsFloat;
        end;
        {
        else
        begin
          AEnvasado := FieldByName('coste_ec').AsFloat;
          ASecciones := FieldByName('secciones_ec').AsFloat;
        end;
        }
        AAnyoEnvase:= FieldByName('anyo_ec').AsInteger;
        AMesEnvase:= FieldByName('mes_ec').AsInteger;
      finally
        Close;
      end;
    end;
end;

function TDMMakeFOBData.CosteEnvaseindirecto( const AEmpresa, ACentro, AEnvase, AProducto: string;
                                 const AAnyo, AMes, AProductoBase: integer;
                                 var AEnvasado, ASecciones: real; var AAnyoEnvase, AMesEnvase: Integer ): integer;
var
  sEmpresa, sEnvase: string;
begin
  if ( Copy( qryDatosAlbaran.FieldByName('empresa').AsString, 1, 1 ) = 'F' )  then
  begin
    result:= 1;
    with qryRelEnvases do
    begin
      ParamByName('envase').AsString:= AEnvase;
      Open;
      if not IsEmpty then
      begin
        sEmpresa:= FieldByName('empresa_sat_esb').AsString;
        sEnvase:= FieldByName('envase_sat_esb').AsString;
      end
      else
      begin
        result:= -1;
      end;
      Close;
    end;
    if result = 1 then
    begin
      with qryCosteEnvaseSAT do
      begin
        ParamByName('empresa').AsString:= sEmpresa;
        ParamByName('envase').AsString:= sEnvase;
        ParamByName('anyo').AsInteger:= AAnyo;
        ParamByName('mes').AsInteger:= AMes;
        Open;
        if not IsEmpty then
        begin
          //if bAPromedio then
          begin
            AEnvasado:= FieldByName('pcoste_ec').AsFloat;
            ASecciones:= FieldByName('psecciones_ec').AsFloat;
          end;
          {
          else
          begin
            AEnvasado:= FieldByName('coste_ec').AsFloat;
            ASecciones:= FieldByName('secciones_ec').AsFloat;
          end;
          }
          AAnyoEnvase:= FieldByName('anyo_ec').AsInteger;
          AMesEnvase:= FieldByName('mes_ec').AsInteger;
        end
        else
        begin
          result:= -1;
        end;
        Close;
      end;
    end;
  end
  else
  begin
    Result:= -1;
  end;
end;

procedure TDMMakeFOBData.GetCostesEnvasado( const AEmpresa, ACentro, AOrigen, AEnvase, AProducto: string;
  const AFEcha: TDateTime; const AProductoBase: integer; var AEnvasado, ASecciones: real );
var
  iAnyo, iMes, iDia: Word;
  iAnyoEnvase, iMesEnvase: Integer;
  iTipo: Integer;
begin
  DecodeDate( AFecha, iAnyo, iMes, iDia );
  if kmtCostesEnvasado.Locate('empresa_ec;centro_ec;envase_ec;producto_ec;origen_ec;anyo_ec;mes_ec',
                              VarArrayOf([ AEmpresa, ACentro, AEnvase, AProducto, AOrigen, iAnyo, iMes ]), []) then
  begin
     AEnvasado := kmtCostesEnvasado.FieldByName('coste_ec').AsFloat;
     ASecciones := kmtCostesEnvasado.FieldByName('secciones_ec').AsFloat;
  end
  else
  begin
    iTipo:= CosteEnvaseDirecto( AEmpresa, ACentro, AEnvase, AProducto, iAnyo, iMes, AProductoBase, AEnvasado, ASecciones, iAnyoEnvase, iMesEnvase );
    if iTipo = -1 then
    begin
      iTipo:= CosteEnvaseindirecto( AEmpresa, ACentro, AEnvase, AProducto, iAnyo, iMes, AProductoBase, AEnvasado, ASecciones,iAnyoEnvase, iMesEnvase );
    end;

    if ( ACentro <> AOrigen )  and ( AEmpresa = '050' )then
      ASecciones := ASecciones + CostesSeccionEnvase( AEmpresa, AOrigen, AEnvase, AProducto, AProductoBase, iAnyo, iMes );

    kmtCostesEnvasado.Insert;
    kmtCostesEnvasado.FieldByName('empresa_ec').AsString:= AEmpresa;
    kmtCostesEnvasado.FieldByName('centro_ec').AsString:= ACentro;
    kmtCostesEnvasado.FieldByName('envase_ec').AsString:= AEnvase;
    kmtCostesEnvasado.FieldByName('producto_ec').AsString := AProducto;
    kmtCostesEnvasado.FieldByName('origen_ec').AsString:= AOrigen;
    kmtCostesEnvasado.FieldByName('anyo_ec').AsInteger:= iAnyo;
    kmtCostesEnvasado.FieldByName('mes_ec').AsInteger:= iMes;

    kmtCostesEnvasado.FieldByName('existe').AsInteger:= iTipo;
    kmtCostesEnvasado.FieldByName('anyo').AsInteger:= iAnyoEnvase;
    kmtCostesEnvasado.FieldByName('mes').AsInteger:= iMesEnvase;

    kmtCostesEnvasado.FieldByName('coste_ec').AsFloat:= AEnvasado;
    kmtCostesEnvasado.FieldByName('secciones_ec').AsFloat:= ASecciones;

    kmtCostesEnvasado.Post;
  end;
end;


function TDMMakeFOBData.FacturasManualesEnvase( const ADias: Integer ): boolean;
begin
  with qryFacturasManuales do
  begin
    SQL.Clear;
    SQL.Add(' SELECT cod_empresa_albaran_fd empresa, cod_cliente_fc cliente, ');
    SQL.Add('        cod_dir_sum_fd suministro, ');
    //Comercial
    SQL.Add('        nvl( ( select cod_comercial_cc from frf_clientes_comercial where cod_empresa_cc = cod_empresa_albaran_fd and cod_cliente_cc = cod_cliente_fc ),''000'') comercial,');


    SQL.Add('        n_albaran_fd albaran, ');
    SQL.Add('        cod_producto_fd producto, ');
    SQL.Add('        cod_envase_fd envase, ');

    SQL.Add(' nvl(( select descripcion_lp from frf_linea_productos where linea_producto_lp = linea_producto_e ) ,''SIN ASIGNAR'') linea, ');
    SQL.Add('        nvl(agrupa_comercial_e,''SIN AGRUPACION'') agrupacion, ');

    SQL.Add('        cod_centro_albaran_fd centro, ');
    SQL.Add('        fecha_albaran_fd fecha, ');
    SQL.Add('        fecha_factura_fc, n_factura_fc, cod_factura_fc, ');
    SQL.Add('        moneda_fc moneda, ');
    SQL.Add('        categoria_fd categoria, ');
    SQL.Add('        calibre_fd  calibre, ');
    SQL.Add('        0  Transito, ');
    SQL.Add('        centro_origen_fd centro_origen, ');
    SQL.Add('        2 facturado, ');
    SQL.Add('        0 kilos_producto, ');
    SQL.Add('        round( case when importe_neto_fc = 0 then  1 ');
    SQL.Add('                           else importe_neto_euros_fc/importe_neto_fc end, 5 ) cambio, ');
    SQL.Add('        SUM(  importe_neto_fd ) neto, SUM(  importe_linea_fd ) importe, SUM(  importe_total_descuento_fd ) descuento ');

    SQL.Add('from tfacturas_cab');
    SQL.Add('     join tfacturas_det on cod_factura_fc = cod_factura_fd ');
    SQL.Add('     left join frf_envases on cod_envase_fd = envase_E  ');

    if gProgramVersion = pvBAG then
      SQL.Add(' WHERE (cod_empresa_albaran_fd[1,1] = ''F'' ) ')
    else
      SQL.Add(' WHERE (cod_empresa_albaran_fd = ''050'' or cod_empresa_albaran_fd = ''080'') ');
    SQL.Add(' and automatica_fc = 0 and anulacion_fc = 0 ');
    SQL.Add(' AND   fecha_albaran_fd >= :fechadesde  ');


    SQL.Add(' group by empresa, cliente, suministro, comercial, albaran, producto, envase, linea, agrupacion, centro,');
    SQL.Add('          fecha, moneda, categoria, calibre, transito, centro_origen, facturado, kilos_producto, cambio, ');
    SQL.Add('          fecha_factura_fc, n_factura_fc, cod_factura_fc ');
    SQL.Add(' ORDER BY cliente, empresa, centro, albaran, fecha, moneda, envase ');

    ParamByName('fechadesde').AsDateTime := Now - ADias;

    //SQL.SaveToFile('c:\pepe.sql');
    Open;
    Result:= not IsEmpty;

    First;
    while not EOF do
    begin
      AltaLineaManualListadoFOB;
      Next;
    end;
    Close;
  end;
end;

procedure TDMMakeFOBData.AltaLineaManualListadoFOB;
begin
  qryTablaMasterFOB.Insert;
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    qryTablaMasterFOB.FieldByName('base_datos_fd').AsString:= 'BAG'
  else
    qryTablaMasterFOB.FieldByName('base_datos_fd').AsString:= 'SAT';
  qryTablaMasterFOB.FieldByName('empresa_fd').AsString:= qryFacturasManuales.FieldByName('empresa').AsString;
  qryTablaMasterFOB.FieldByName('centro_origen_fd').AsString:= qryFacturasManuales.FieldByName('centro_origen').AsString;
  qryTablaMasterFOB.FieldByName('centro_salida_fd').AsString:= qryFacturasManuales.FieldByName('centro').AsString;
  qryTablaMasterFOB.FieldByName('cliente_fd').AsString:= qryFacturasManuales.FieldByName('cliente').AsString;
  qryTablaMasterFOB.FieldByName('suministro_fd').AsString:= qryFacturasManuales.FieldByName('suministro').AsString;
  qryTablaMasterFOB.FieldByName('n_albaran_fd').AsInteger:= qryFacturasManuales.FieldByName('albaran').AsInteger;
  qryTablaMasterFOB.FieldByName('fecha_albaran_fd').AsDateTime:= qryFacturasManuales.FieldByName('fecha').AsDateTime;
  qryTablaMasterFOB.FieldByName('producto_fd').AsString:= qryFacturasManuales.FieldByName('producto').AsString;
  qryTablaMasterFOB.FieldByName('agrupacion_comercial_fd').AsString:= qryFacturasManuales.FieldByName('agrupacion').AsString;
  qryTablaMasterFOB.FieldByName('linea_fd').AsString:= qryFacturasManuales.FieldByName('linea').AsString;
  qryTablaMasterFOB.FieldByName('envase_fd').AsString:= qryFacturasManuales.FieldByName('envase').AsString;
  qryTablaMasterFOB.FieldByName('categoria_fd').AsString:= qryFacturasManuales.FieldByName('categoria').AsString;
  qryTablaMasterFOB.FieldByName('calibre_fd').AsString:= qryFacturasManuales.FieldByName('calibre').AsString;


  qryTablaMasterFOB.FieldByName('palets_producto_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('kilos_producto_fd').AsFloat:= 0;
  qryTablaMasterFOB.FieldByName('cajas_producto_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('unidades_producto_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('palets_total_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('kilos_total_fd').AsFloat:= 0;
  qryTablaMasterFOB.FieldByName('cajas_total_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('unidades_total_fd').AsInteger:= 0;

  qryTablaMasterFOB.FieldByName('transito_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('palets_transito_producto_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('kilos_transito_producto_fd').AsFloat:= 0;
  qryTablaMasterFOB.FieldByName('cajas_transito_producto_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('unidades_transito_producto_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('palets_transito_total_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('kilos_transito_total_fd').AsFloat:= 0;
  qryTablaMasterFOB.FieldByName('cajas_transito_total_fd').AsInteger:= 0;
  qryTablaMasterFOB.FieldByName('unidades_transito_total_fd').AsInteger:= 0;

  qryTablaMasterFOB.FieldByName('moneda_fd').AsString:= qryFacturasManuales.FieldByName('moneda').AsString;
  if qryTablaMasterFOB.FieldByName('moneda_fd').AsString <> 'EUR' then
    qryTablaMasterFOB.FieldByName('cambio_fd').AsFloat:= qryFacturasManuales.FieldByName('cambio').AsFloat
  else
    qryTablaMasterFOB.FieldByName('cambio_fd').AsFloat:= 1;
  qryTablaMasterFOB.FieldByName('importe_fd').AsFloat:= qryFacturasManuales.FieldByName('importe').AsFloat;
  qryTablaMasterFOB.FieldByName('comision_fd').AsFloat:= qryFacturasManuales.FieldByName('descuento').AsFloat;
  {}qryTablaMasterFOB.FieldByName('gasto_facturable_fd').AsFloat:= 0;
  {}qryTablaMasterFOB.FieldByName('base_fd').AsFloat:= qryFacturasManuales.FieldByName('neto').AsFloat;
  {}qryTablaMasterFOB.FieldByName('descuento_fd').AsFloat:= 0;
  {}qryTablaMasterFOB.FieldByName('gasto_comun_fd').AsFloat:= 0;
  {}qryTablaMasterFOB.FieldByName('gasto_transito_fd').AsFloat:= 0;
  {}qryTablaMasterFOB.FieldByName('coste_envase_fd').AsFloat:= 0;
  {}qryTablaMasterFOB.FieldByName('coste_seccion_fd').AsFloat:= 0;
  {}qryTablaMasterFOB.FieldByName('coste_envasado_fd').AsFloat:= 0;
  qryTablaMasterFOB.FieldByName('neto_fd').AsFloat:= qryTablaMasterFOB.FieldByName('base_fd').AsFloat;
  if qryTablaMasterFOB.FieldByName('neto_fd').AsFloat < 0 then
    qryTablaMasterFOB.FieldByName('facturado_fd').AsInteger:= 2
  else
    qryTablaMasterFOB.FieldByName('facturado_fd').AsInteger:= 1;
  qryTablaMasterFOB.FieldByName('cod_factura_fd').AsString:= qryFacturasManuales.FieldByName('cod_factura_fc').AsString;
  qryTablaMasterFOB.FieldByName('n_factura_fd').AsInteger:= qryFacturasManuales.FieldByName('n_factura_fc').AsInteger;
  qryTablaMasterFOB.FieldByName('fecha_factura_fd').AsDateTime:= qryFacturasManuales.FieldByName('fecha_factura_fc').AsDateTime;
  qryTablaMasterFOB.FieldByName('comercial_fd').AsString:= qryFacturasManuales.FieldByName('comercial').AsString;
  qryTablaMasterFOB.Post;




end;

function ProductoBagToSat( const AProducto: string ): string;
begin
   if AProducto = 'PEH' then Result:= 'H'
   else if AProducto = 'CAL' then Result:= 'CAL'
   else if AProducto = 'GRA' then Result:= 'GRA'
   else if AProducto = 'LMA' then Result:= 'LMA'
   else if AProducto = 'MGO' then Result:= 'MGO'
   else if AProducto = 'PAP' then Result:= 'PAP'
   else Result:= '';
end;


function TDMMakeFOBData.NuevoGastoTransitosSAT( const AMes: string; const AFechaIni, AFechaFin: Real ): Real;
var
  rImporte, rKilosSAT, sKilosBAG: real;
begin
  with qryGastosTransitosSAT do
  begin
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    ParamByName('producto').AsString:= ProductoBagToSat( qryDatosAlbaran.FieldByName('producto').AsString );
    Open;
    rImporte:= FieldByName('importe').AsFloat;
    Close;
  end;

  with qryKilosTransitosSAT do
  begin
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    ParamByName('producto').AsString:= ProductoBagToSat( qryDatosAlbaran.FieldByName('producto').AsString );
    Open;
    rKilosSAT:= FieldByName('kilos').AsFloat;
    Close;
  end;

  with qryTotalesBAG do
  begin
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    ParamByName('producto').AsString:= qryDatosAlbaran.FieldByName('producto').AsString;
    Open;
    sKilosBAG:= FieldByName('kilos').AsFloat;
    Close;
  end;

  if sKilosBAG <> 0 then
  begin
    if sKilosBAG < rKilosSAT then
    begin
      Result:= bRoundTo( rImporte / rKilosSAT, 3 );
    end
    else
    begin
      Result:= bRoundTo( rImporte / sKilosBAG, 3 );
    end;
  end
  else
  begin
    Result:= 0;
  end;

  kmtTransitosSAT_BAG.Insert;
  kmtTransitosSAT_BAG.FieldByName('mes').AsString:= AMes;
  kmtTransitosSAT_BAG.FieldByName('producto').AsString:= qryDatosAlbaran.FieldByName('producto').AsString;
  kmtTransitosSAT_BAG.FieldByName('coste').AsFloat:= Result;
  kmtTransitosSAT_BAG.Post;
end;

function TDMMakeFOBData.GastosTransitosSAT: Real;
var
  sMes: string;
  dPrimero, dUltimo: TDateTime;
begin
  if ( Copy( qryDatosAlbaran.FieldByName('empresa').AsString, 1, 1 ) = 'F' ) and
     ( qryDatosAlbaran.FieldByName('empresa').AsString <> 'F23' ) then
  begin
    sMes:= AnyoMesEx( qryDatosAlbaran.FieldByName('fecha').AsDateTime, dPrimero, dUltimo );
    if kmtTransitosSAT_BAG.Locate( 'mes;producto',
         VarArrayOf( [sMes, qryDatosAlbaran.FieldByName('producto').AsString ]), [] ) then
    begin
      Result:= bRoundTo( qryDatosAlbaran.FieldByName('kilos_producto').AsFloat * kmtTransitosSAT_BAG.FieldByName('coste').AsFloat, 2) ;
    end
    else
    begin
      Result:= bRoundTo( qryDatosAlbaran.FieldByName('kilos_producto').AsFloat * NuevoGastoTransitosSAT( sMes, dPrimero, dUltimo ), 2);
    end;
  end
  else
  begin
    Result:= 0;
  end;
end;

end.
