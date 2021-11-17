unit TablaTemporalFOBData;

interface

uses
  SysUtils, Classes, DB, DBClient, Provider, DBTables, kbmMemTable, MidasLib;

type
  TResultadosFob = record
    rPeso, rNeto, rDescuento, rGastos, rGastosFac, rGastosNoFac ,rGastosTran, rCosteEnvase, rCosteSecciones: Real;
    rPesoPrimera, rNetoPrimera, rDescuentoPrimera, rGastosPrimera, rGastosPrimeraFac, rGastosPrimeraNoFac, rGastosPrimeraTran, rEnvasePrimera, rSeccionesPrimera: Real;
    rPesoSegunda, rNetoSegunda, rDescuentoSegunda, rGastosSegunda, rGastosSegundaFac, rGastosSegundaNoFac, rGastosSegundaTran, rEnvaseSegunda, rSeccionesSegunda: Real;
    rPesoTercera, rNetoTercera, rDescuentoTercera, rGastosTercera, rGastosTerceraFac, rGastosTerceraNoFac, rGastosTerceraTran, rEnvaseTercera, rSeccionesTercera: Real;
    rPesoDestrio, rNetoDestrio, rDescuentoDestrio, rGastosDestrio, rGastosDestrioFac, rGastosDestrioNoFac, rGastosDestrioTran, rEnvaseDestrio, rSeccionesDestrio: Real;
   end;  

type
  TDMTablaTemporalFOB = class(TDataModule)
    Query: TQuery;
    DataSetProvider: TDataSetProvider;
    ClientDataSet: TClientDataSet;
    ClientDataSetcliente: TStringField;
    ClientDataSetalbaran: TIntegerField;
    ClientDataSetenvase: TStringField;
    ClientDataSetAgrupacion: TStringField;
    ClientDataSetcentro: TStringField;
    ClientDataSetfecha: TDateField;
    ClientDataSetmoneda: TStringField;
    ClientDataSetcambio: TFloatField;
    ClientDataSetkilos_producto: TFloatField;
    ClientDataSetcajas_producto: TFloatField;
    ClientDataSetpalets_producto: TFloatField;
    ClientDataSetkilos_transito: TFloatField;
    ClientDataSetkilos_total: TFloatField;
    ClientDataSetimporte: TFloatField;
    ClientDataSetdescuento: TFloatField;
    ClientDataSetcomision: TFloatField;
    ClientDataSetgasto_transito: TFloatField;
    DataSource: TDataSource;
    QKilos: TQuery;
    ClientDataSettransito: TIntegerField;
//    QProductoBase: TQuery;
    QCosteEnvase: TQuery;
    ClientDataSetgasto_comun: TFloatField;
    ClientDataSetcalibre: TStringField;
    ClientDataSetcoste_envasado: TFloatField;
    ClientDataSetcentro_origen: TStringField;
    ClientDataSetcategoria: TStringField;
    ClientDataSetproducto: TStringField;
    ClientDataSetfacturado: TIntegerField;
    qryFacturasManuales: TQuery;
    qryGastoAlbaran: TQuery;
    strngfldClientDataSetcomercial: TStringField;
    strngfldClientDataSetempresa: TStringField;
    fltfldClientDataSetunidades_producto: TFloatField;
    strngfldClientDataSetperiodoFact: TStringField;
    kmtCostesEnvasado: TkbmMemTable;
    qryCosteSeccion: TQuery;
    fltfldClientDataSetneto: TFloatField;
    fltfldClientDataSetcoste_envase: TFloatField;
    fltfldClientDataSetcoste_seccion: TFloatField;
    strngfldClientDataSetsuministro: TStringField;
    dbAuxSAT: TDatabase;
    qryGastosTransitosSAT: TQuery;
    kmtTransitosSAT_BAG: TkbmMemTable;
    qryKilosTransitosSAT: TQuery;
    qryTotalesBAG: TQuery;
    qryRelEnvases: TQuery;
    qryCosteEnvaseSAT: TQuery;
    fltfldClientDataSetdes_fac_importe: TFloatField;
    fltfldClientDataSetdes_fac_kilos: TFloatField;
    fltfldClientDataSetcomision_representante: TFloatField;
    fltfldClientDataSetdes_no_fac_importe: TFloatField;
    fltfldClientDataSetdes_no_fac_kilos: TFloatField;
    fltfldClientDataSetgasto_fac: TFloatField;
    fltfldClientDataSetgasto_no_fac: TFloatField;
    fltfldClientDataSetcoste_fruta: TFloatField;
    fltfldClientDataSetcoste_estructura: TFloatField;
    fltfldClientDataSetayudas_fruta: TFloatField;
    kmtAyudas: TkbmMemTable;
    qryAyudasSAT: TQuery;
    qryDatosTransitos: TQuery;
    qryDatosClienteBAG: TQuery;
    qryDatosPlantaBAG: TQuery;
    iClientDataSettipo_salida: TIntegerField;
    ClientDataSetpais: TStringField;
    ClientDataSetlinea: TStringField;
    ClientDataSetdes_fac_pale: TFloatField;
    ClientDataSetdes_no_fac_pale: TFloatField;
    ClientDataSetdes_no_fac_importe_neto: TFloatField;
    ClientDataSetimporte_total: TFloatField;
    qryAux: TQuery;
    ClientDataSetgas_no_facturable: TFloatField;
    ClientDataSetfecha_albaran: TDateField;
    Query1: TQuery;
    ClientDataSetkilos_reales: TFloatField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    rgKilosTotal, rgKilosTransito, rgKilosProdTotal, rgKilosProdTransito: Real;
    rgPaletsTotal, rgPaletsTransito, rgPaletsProdTotal, rgPaletsProdTransito: Real;
    rgCajasTotal, rgCajasTransito, rgCajasProdTotal, rgCajasProdTransito: Real;
    rgImporteTotal, rgImporteConIva, rgImporteTransito, rgImporteProdTotal, rgImporteProdTransito: Real;


    procedure RellenaDatosFaltantes(const bLiquida: boolean);
    procedure GetKilosAlbaran(const AEmpresa, ACentro: string; const AAlbaran: Integer; const AFecha: TDateTime; const AProducto: string);


    procedure PrepareQGastos;
    function  GetGastosAlbaran( const AEmpresa, ACentro: string; const AAlbaran: Integer; const AFecha: TDateTime ): Boolean;
    function  EsProductoConGasto: Boolean;
    procedure AddGasto( var AGastoNoFac, AGastoFac, AGastoTransito: Real );
    procedure AddGastoTotal( var AGastoNoFac, AGastoFac, AGastoTransito: Real );
    procedure AddGastoProducto( var AGastoNoFac, AGastoFac, AGastoTransito: Real );
    function  PutGasto( const AUnidades: Real;  const AUnidadesTotal: string; var ANoFac, AFac: Real ): Boolean;


    procedure GetCostesEnvasado( const AEmpresa, ACentro, AOrigen, AEnvase, AProducto: string;
                                 const AFEcha: TDateTime; const AProductoBase: integer;
                                 var AEnvasado, ASecciones: real );

    function CosteEnvaseDirecto( const AEmpresa, ACentro, AEnvase, AProducto: string;
                                 const AAnyo, AMes, AProductoBase: integer;
                                 var AEnvasado, ASecciones, APEnvasado, APSecciones: real; var AAnyoEnvase, AMesEnvase: Integer ): integer;
    function CosteEnvaseindirecto( const AEmpresa, ACentro, AEnvase, AProducto: string;
                                 const AAnyo, AMes, AProductoBase: integer;
                                 var AEnvasado, ASecciones, APEnvasado, PASecciones: real; var AAnyoEnvase, AMesEnvase: Integer ): integer;
    procedure  CostesSeccionEnvase( const AEmpresa, ACentro, AEnvase, AProducto: string;
                                   var ASecciones, PASecciones: real;
                                   const AProductoBase, AAnyo, AMes: integer );
    procedure CostesEnvasesFalta;
    procedure PreparaCostes;


    function  FacturasManualesEnvase: boolean;
    procedure AltaLineaManualListadoFOB;

    function GastosTransitosSAT: Real;
    function NuevoGastoTransitosSAT( const AMes: string; const AFechaIni, AFechaFin: Real ): Real;

    procedure SalvarAyuda( const AEmpresa, ACentro, AProducto, ACliente, AMes: string; const AEuros, APorcentaje: Real );
    procedure AyudasSAT( var AEuros, APorcentaje: real );
    procedure Ayudas050( var AEuros, APorcentaje: real );
    procedure Ayudas080( var AEuros, APorcentaje: real );
    procedure AyudasBAG( var AEuros, APorcentaje: real );
    function AyudaMensualTransito( const AFechaini, AFechaFin: TDateTime ): real;
    function AyudaMensualClienteBAG( const AProducto: string; const AFechaini, AFechaFin: TDateTime ): real;
  public
    { Public declarations }
    bBag: boolean;
    sAEmpresa: string;
      iAProductoPropio: Integer; // 1 -> propio     2 -> tercero       resto -> todo
    sACentroOrigen, sACentroSalida, sACliente, sATipoCliente: string;
    bAExcluirTipoCliente, bAExcluirInterplanta: Boolean;
      iAClienteFac: Integer;     // 1 -> facturable 2 -> no facturable resto -> todos
      //sASuministro: Boolean;     // true -> Desglosar direccion sumnistro
    sAPais, sAALbaran: string;
      bAAlb6Digitos: boolean;    // true -> como minimo seis digitos (almacen) false -> todos
      iAAlbFacturado: integer;   // 1 -> facturado  0 -> no facturado  resto -> todos
      bAManuales, bASoloManuales: boolean;
    sAFechaDesde, sAFEchaHasta: string;
      bAFechaSalida: Boolean;    // true -> rango fecha salidas false -> rango fecha facturas (solo facturados)
    sAProducto: string;
      iAEsHortaliza: integer;       // 0-> todos 1 -> tomate (no P4H) 2 -> hortalizas (no P4H) 3 -> fruta (no P4H) 4 -> solo P4H
    bANoP4h: boolean;
    sAEnvase, sACategoria: string;
    sACalibre: string;
    sATipoGasto, sAGrupoGasto: string;
      bANoGasto: Boolean;        // true -> excluye el gasto                       false -> lo incluye

    bAGastosNoFac, bAGastosFac, bAGastosFijos: Boolean;
    bAGastosTransitos: Boolean;
    bAComisiones, bADescuentos: Boolean;
    bACosteEnvase, bACosteSecciones, bAPromedio: Boolean;
    bCosteFruta, bAyudas, bCosteEstructura, bVerFecha: boolean;
    function ObtenerDatosComunFob(const bLiquida:Boolean): boolean;
    function ImportesFOB( var VPeso, VNeto, VDescuento, VGastos, VMaterial, VGeneral: Real;
                          var VResultadosFob: TResultadosFob): boolean;
    procedure AsignarBaseDeDatos( const ABaseDatos: string );
  end;

var
    DMTablaTemporalFOB: TDMTablaTemporalFOB;
    bEnvasesSinCoste: Boolean = False;

implementation

{$R *.dfm}

uses Variants, Dialogs, CGlobal, UDMCambioMoneda,  bMath, bTimeUtils,
     CosteMedioMateriaPrimaDM, CosteEstructuralDM, btextutils;

procedure TDMTablaTemporalFOB.AsignarBaseDeDatos( const ABaseDatos: string );
begin
  if  ABaseDatos = 'dbBAG' then
    bBag:= True
  else
  if  ABaseDatos = 'dbSAT' then
    bBag:= false
  else
    bBag:= gProgramVersion = pvBAG;

  Query.Close;
  QKilos.Close;
//  QProductoBase.Close;
  QCosteEnvase.Close;
  qryFacturasManuales.Close;
  qryGastoAlbaran.Close;
  qryCosteSeccion.Close;
  qryGastosTransitosSAT.Close;
  qryKilosTransitosSAT.Close;
  qryTotalesBAG.Close;
  qryRelEnvases.Close;
  qryCosteEnvaseSAT.Close;
  qryAyudasSat.Close;
  qryDatosTransitos.Close;
  qryDatosClienteBAG.Close;
  qryDatosPlantaBAG.Close;

  qryGastoAlbaran.UnPrepare;
//  QProductoBase.UnPrepare;
  QCosteEnvase.UnPrepare;
  qryCosteSeccion.UnPrepare;
  QKilos.UnPrepare;
  qryGastoAlbaran.UnPrepare;
  qryCosteEnvaseSAT.UnPrepare;
  qryAyudasSat.UnPrepare;
  qryDatosTransitos.UnPrepare;
  qryDatosClienteBAG.UnPrepare;
  qryDatosPlantaBAG.UnPrepare;

  Query.databasename:= ABaseDatos;
  QKilos.databasename:= ABaseDatos;
//  QProductoBase.databasename:= ABaseDatos;
  QCosteEnvase.databasename:= ABaseDatos;
  qryFacturasManuales.databasename:= ABaseDatos;
  qryGastoAlbaran.databasename:= ABaseDatos;
  qryCosteSeccion.databasename:= ABaseDatos;
  qryGastosTransitosSAT.databasename:= ABaseDatos;
  qryKilosTransitosSAT.databasename:= ABaseDatos;
  qryTotalesBAG.databasename:= ABaseDatos;
  qryRelEnvases.databasename:= ABaseDatos;
  qryCosteEnvaseSAT.databasename:= ABaseDatos;
  //qryAyudasSat.databasename:= ABaseDatos;
  //qryDatosTransitos.databasename:= ABaseDatos;
  //qryDatosClienteBAG.databasename:= ABaseDatos;
  qryDatosPlantaBAG.databasename:= ABaseDatos;

  qryGastoAlbaran.Prepare;
//  QProductoBase.Prepare;
  PreparaCostes;
  QKilos.Prepare;
  qryGastoAlbaran.Prepare;
  qryCosteEnvaseSAT.Prepare;
  qryAyudasSat.Prepare;
  qryDatosTransitos.Prepare;
  qryDatosClienteBAG.Prepare;
  qryDatosPlantaBAG.Prepare;
end;

procedure TDMTablaTemporalFOB.PrepareQGastos;
begin
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

    if bANoGasto then
    begin
      if sATipoGasto <> '' then
        SQL.Add(' and tipo_tg <> :tipo ');
      if sAGrupoGasto <> '' then
      begin
        if Pos( ',', sAGrupoGasto ) > 0 then
        begin
          SQL.Add(' AND   tipo_tg not in (' + ListaDeCadenas( sAGrupoGasto ) + ')');
        end
        else
        begin
          SQL.Add(' AND   tipo_tg <> ' +  QuotedStr(Trim( sAGrupoGasto ) ) );
        end;
      end;
    end
    else
    begin
      if sATipoGasto <> '' then
        SQL.Add(' and tipo_tg = :tipo ');
      if sAGrupoGasto <> '' then
      begin
        if Pos( ',', sAGrupoGasto ) > 0 then
        begin
          SQL.Add(' AND   tipo_tg in (' + ListaDeCadenas( sAGrupoGasto ) + ')');
        end
        else
        begin
          SQL.Add(' AND   tipo_tg = ' +  QuotedStr(Trim( sAGrupoGasto ) ) );
        end;
      end;
    end;

    SQL.Add(' group by producto, unidad, transito ');
    Prepare;
  end;
end;


procedure TDMTablaTemporalFOB.PreparaCostes;
begin
  with QCosteEnvase do
  begin
    SQL.Clear;
    if bBag then
    begin
      SQL.Add('select empresa_ec, centro_ec, anyo_ec, mes_ec, ( material_ec + personal_Ec ) coste_ec, general_ec secciones_ec, ');
      SQL.Add('                                ( material_ec + personal_Ec ) pcoste_ec, general_ec psecciones_ec ');
    end
    else
    begin
      SQL.Add('select empresa_ec, centro_ec, anyo_ec, mes_ec, ( material_ec + coste_ec ) coste_ec, secciones_ec, ');
      SQL.Add('                                ( pmaterial_ec + pcoste_ec ) pcoste_ec, psecciones_ec ');
    end;
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
    if bBag then
    begin
      SQL.Add('select first 1 anyo_ec, mes_ec, envase_ec, general_ec secciones_ec, general_ec psecciones_ec ');
    end
    else
    begin
      SQL.Add('select first 1 anyo_ec, mes_ec, envase_ec, secciones_ec, psecciones_ec ');
    end;
    SQL.Add('from frf_env_costes ');
    SQL.Add('where empresa_Ec = :empresa ');
    SQL.Add('and centro_ec = :centro ');
    SQL.Add('and envase_ec = :envase ');
    SQL.Add('and producto_ec = :producto ');
    SQL.Add('and ( ( anyo_ec = :anyo and mes_ec <= :mes ) or ( anyo_ec < :anyo) )');
    SQL.Add('order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;
end;

procedure TDMTablaTemporalFOB.DataModuleCreate(Sender: TObject);
begin
  CosteMedioMateriaPrimaDM.InicializaModulo;
  CosteEstructuralDM.InicializaModulo;

  bBag:= gProgramVersion = pvBAG;
    sAEmpresa:= '';
    iAProductoPropio:= -1;
    sACentroOrigen:= '';
    sACentroSalida:= '';
    sACliente:= '';
    sATipoCliente:= '';
    bAExcluirTipoCliente:= False;
    bAExcluirInterplanta:= True;
    iAClienteFac:= 1;     // 1 -> facturable 2 -> no facturable resto -> todos
    //sASuministro:= ASuministro;
    sAPais:= '';
    sAALbaran:= '';
    bAAlb6Digitos:= False;    // true -> como minimo seis digitos (almacen) false -> todos
    iAAlbFacturado:= -1;   // 1 -> facturado  0 -> no facturado  resto -> todos
    bAManuales:= True;
    bASoloManuales:= False;
    sAFechaDesde:= '';
    sAFEchaHasta:= '';
    bAFechaSalida:= True;    // true -> rango fecha salidas false -> rango fecha facturas (solo facturados)
    sAProducto:= '';
    iAEsHortaliza:= 0;       // 1 -> tomate 2 -> no tomate resto -> todos
    bANoP4H:= False;
    sAEnvase:= '';
    sACategoria:= '';
    sACalibre:= '';
    sATipoGasto:= '';
    sAGrupoGasto:='';
    bANoGasto:= false;        // true -> excluye el gasto                       false -> lo incluye

    bAGastosNoFac:= true;
    bAGastosFac:= true;
    bAGastosTransitos:= true;
    bAComisiones:= true;
    bADescuentos:= true;
    bACosteEnvase:= True;
    bCosteFruta:= False;
    bAyudas:= False;
    bCosteEstructura:= False;
    bACosteSecciones:= True;
    bAPromedio:= True;
    bVerFecha := False;
    bAGastosFijos := true;
{
  with QProductoBase do
  begin
    SQL.Clear;
    SQL.Add(' select producto_base_p ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where producto_p = :producto ');
    Prepare;
  end;
}

  PreparaCostes;

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
    SQL.Add(' and producto_g is null ');
    SQL.Add(' and tipo_tg = tipo_g ');
    SQL.Add(' group by producto, unidad, transito ');
    Prepare;
  end;

  kmtCostesEnvasado.FieldDefs.Clear;
  kmtCostesEnvasado.FieldDefs.Add('empresa_ec', ftString, 3, False);
  kmtCostesEnvasado.FieldDefs.Add('centro_ec', ftString, 3, False);
  kmtCostesEnvasado.FieldDefs.Add('envase_ec', ftString, 9, False);
  kmtCostesEnvasado.FieldDefs.Add('producto_ec', ftString, 3, False);
  kmtCostesEnvasado.FieldDefs.Add('origen_ec', ftString, 3, False);
  kmtCostesEnvasado.FieldDefs.Add('anyo_ec', ftInteger, 0, False);
  kmtCostesEnvasado.FieldDefs.Add('mes_ec', ftInteger, 0, False);

  kmtCostesEnvasado.FieldDefs.Add('coste_ec', ftFloat, 0, False);
  kmtCostesEnvasado.FieldDefs.Add('secciones_ec', ftFloat, 0, False);
  kmtCostesEnvasado.FieldDefs.Add('pcoste_ec', ftFloat, 0, False);
  kmtCostesEnvasado.FieldDefs.Add('psecciones_ec', ftFloat, 0, False);

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

  kmtAyudas.FieldDefs.Clear;
  kmtAyudas.FieldDefs.Add('empresa', ftString, 3, False);
  kmtAyudas.FieldDefs.Add('producto', ftString, 3, False);
  kmtAyudas.FieldDefs.Add('centro', ftString, 3, False);
  kmtAyudas.FieldDefs.Add('cliente', ftString, 3, False);
  kmtAyudas.FieldDefs.Add('mes', ftString, 6, False);
  kmtAyudas.FieldDefs.Add('ayuda_kilo', ftFloat, 0, False);
  kmtAyudas.FieldDefs.Add('ayuda_porcen', ftFloat, 0, False);
  kmtAyudas.IndexFieldNames:= 'mes';
  kmtAyudas.CreateTable;
  kmtAyudas.Open;

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
    //SQL.Add('and producto_base_ec = :producto ');
    SQL.Add('and ( ( anyo_ec = :anyo and mes_ec <= :mes ) or ( anyo_ec < :anyo) )');
    SQL.Add('order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;

  qryAyudasSAT.sql.Clear;
  qryAyudasSAT.sql.Add(' select eur_kilo_tenerife_p, eur_kilo_transito_p, ');
  qryAyudasSAT.sql.Add('        porcen_importe_tenerife_p, porcen_importe_transito_p ');
  qryAyudasSAT.sql.Add(' from frf_productos ');
  qryAyudasSAT.sql.Add(' where producto_p = :producto ');
  qryAyudasSAT.Prepare;

  qryDatosTransitos.sql.Clear;
  qryDatosTransitos.sql.Add(' select sum( importe_neto_sl ) importe_total, ');
  qryDatosTransitos.sql.Add('        sum( case when centro_origen_sl = ''6'' then importe_neto_sl else 0 end) importe_tenerife, ');
  qryDatosTransitos.sql.Add('        sum( kilos_sl ) kilos_total, ');
  qryDatosTransitos.sql.Add('        sum( case when centro_origen_sl = ''6'' then kilos_sl else 0 end) kilos_tenerife ');
  qryDatosTransitos.sql.Add(' from frf_salidas_l ');
  qryDatosTransitos.sql.Add(' where empresa_sl = :empresa ');
  qryDatosTransitos.sql.Add('   and producto_sl = :producto ');
  qryDatosTransitos.sql.Add('   and fecha_sl between :fechaini and :fechafin ');
  qryDatosTransitos.Prepare;

  qryDatosClienteBAG.sql.Clear;
  qryDatosClienteBAG.sql.Add(' select sum(kilos_sl) kilos, sum(importe_neto_sl) importe ');
  qryDatosClienteBAG.sql.Add(' from frf_salidas_l ');
  qryDatosClienteBAG.sql.Add(' where empresa_sl = ''080'' ');
  qryDatosClienteBAG.sql.Add(' and centro_salida_sl = ''6'' ');
  qryDatosClienteBAG.sql.Add(' and cliente_sl = ''BAG'' ');
  qryDatosClienteBAG.sql.Add(' and fecha_sl between :fechaini and :fechafin ');
  qryDatosClienteBAG.sql.Add(' and producto_sl = :producto ');
  qryDatosClienteBAG.Prepare;

  qryDatosPlantaBAG.sql.Clear;
  qryDatosPlantaBAG.sql.Add(' select sum(kilos_sl) kilos ');
  qryDatosPlantaBAG.sql.Add(' from frf_salidas_l ');
  qryDatosPlantaBAG.sql.Add(' where substr(empresa_sl,1,1) = ''F'' and empresa_sl <> ''F23'' ');
  qryDatosPlantaBAG.sql.Add(' and fecha_sl between :fechaini and :fechafin ');
  qryDatosPlantaBAG.sql.Add(' and producto_sl = :producto ');
end;

procedure TDMTablaTemporalFOB.DataModuleDestroy(Sender: TObject);
begin
  CosteMedioMateriaPrimaDM.FinalizaModulo;
  CosteEstructuralDM.FinalizaModulo;

  ClientDataSet.Close;
  kmtCostesEnvasado.Close;
  //mtListado.Close;

  QKilos.Close;
  qryGastoAlbaran.Close;
//  QProductoBase.Close;
  QCosteEnvase.Close;
  qryCosteSeccion.Close;

  kmtTransitosSAT_BAG.Close;
  qryGastosTransitosSAT.Close;
  qryKilosTransitosSAT.Close;
  qryTotalesBAG.Close;
  if dbAuxSAT.Connected then
    dbAuxSAT.Close;


  kmtAyudas.Close;

  QKilos.UnPrepare;
  qryGastoAlbaran.UnPrepare;
//  QProductoBase.UnPrepare;
  QCosteEnvase.UNPrepare;
  qryCosteSeccion.UNPrepare;
end;

(*
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
*)

function TDMTablaTemporalFOB.ObtenerDatosComunFob(const bLiquida:Boolean): Boolean;
var
  bAux: boolean;
begin
  ClientDataSet.Close;
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add(' SELECT empresa_sl empresa, cliente_sl cliente, pais_c pais, dir_sum_sc suministro, producto_sl producto, n_albaran_sc albaran,  fecha_sc fecha_albaran, n_orden_sc orden_carga, envase_sl envase, ');
  Query.SQL.Add('        nvl( linea_producto_e, ''00'' ) linea, ');
  Query.SQL.Add('        periodo_factura_c periodoFact, ');

  //Query.SQL.Add(' nvl(( select descripcion_lp from frf_linea_productos where linea_producto_lp = linea_producto_e ) ,''SIN ASIGNAR'') linea, ');

  //Comercial
    Query.SQL.Add('        nvl( comercial_sl,''000'') comercial,');

  Query.SQL.Add('        centro_salida_sc centro, fecha_sc fecha, moneda_sc moneda, categoria_sl categoria,');
  Query.SQL.Add('        nvl(agrupa_comercial_e,''SIN AGRUPACION'') agrupacion, ');
  Query.SQL.Add('        calibre_sl calibre, SUM(NVL(kilos_sl,0)) kilos_producto,');

  Query.SQL.Add('        SUM(NVL(kilos_reales_sl,0)) kilos_reales,');

  Query.SQL.Add('        SUM(NVL(cajas_sl,0)) cajas_producto, SUM(NVL(cajas_sl,0)*NVL(unidades_caja_sl,1)) unidades_producto, SUM(NVL(n_palets_sl,0)) palets_producto,');


  Query.SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0), 2) ) importe, ');
  Query.SQL.Add('        SUM(  Round( NVL(importe_total_sl,0), 2) ) importe_total, ');
  Query.SQL.Add('        0.0 comision, ');
  Query.SQL.Add('        0.0 descuento, ');

  if bAComisiones or bADescuentos then
  begin
    (*TODO*) //primero descuento facturable, despues comison facturabe, despues descuento normal
//    if bAComisiones and bADescuentos then
//    begin
      Query.SQL.Add('        GetDescuentosCliente( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) des_fac_importe, ');
      Query.SQL.Add('        get_eurkg_descuentos( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) des_fac_kilos, ');
      Query.SQL.Add('        get_eurpale_descuentos( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) des_fac_pale, ');
      Query.SQL.Add('        getcomisioncliente ( empresa_sl, cliente_sl, fecha_sl ) comision_representante, ');
      Query.SQL.Add('        GetDescuentosCliente( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) des_no_fac_importe, ');
      Query.SQL.Add('        get_eurkg_descuentos( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) des_no_fac_kilos, ');
      Query.SQL.Add('        get_eurpale_descuentos( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) des_no_fac_pale, ');
      Query.SQL.Add('        GetDescuentosCliente( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 3 ) des_no_fac_importe_neto, ');
{
    end
    else
    if bAComisiones then
    begin
      Query.SQL.Add('        GetDescuentosCliente( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) des_fac_importe, ');
      Query.SQL.Add('        get_eurkg_descuentos( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) des_fac_kilos, ');
      Query.SQL.Add('        get_eurpale_descuentos( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) des_fac_pale, ');
      Query.SQL.Add('        getcomisioncliente ( empresa_sl, cliente_sl, fecha_sl ) comision_representante, ');
      Query.SQL.Add('        0.0 des_no_fac_importe, ');
      Query.SQL.Add('        0.0 des_no_fac_kilos, ');
      Query.SQL.Add('        0.0 des_no_fac_pale, ');
      Query.SQL.Add('        0.0 des_no_fac_importe_neto, ');
    end
    else
    begin
      Query.SQL.Add('        0.0 des_fac_importe, ');
      Query.SQL.Add('        0.0 des_fac_kilos, ');
      Query.SQL.Add('        0.0 des_fac_pale, ');
      Query.SQL.Add('        0.0 comision_representante, ');
      Query.SQL.Add('        GetDescuentosCliente( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) des_no_fac_importe, ');
      Query.SQL.Add('        get_eurkg_descuentos( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) des_no_fac_kilos, ');
      Query.SQL.Add('        get_eurpale_descuentos( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) des_no_fac_pale, ');
      Query.SQL.Add('        GetDescuentosCliente( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 3 ) des_no_fac_importe_neto, ');
    end;
}
  end
  else
  begin
      Query.SQL.Add('        0.0 des_fac_importe, ');
      Query.SQL.Add('        0.0 des_fac_kilos, ');
      Query.SQL.Add('        0.0 des_fac_pale, ');
      Query.SQL.Add('        0.0 comision_representante, ');
      Query.SQL.Add('        0.0 des_no_fac_importe, ');
      Query.SQL.Add('        0.0 des_no_fac_kilos, ');
      Query.SQL.Add('        0.0 des_no_fac_pale, ');
      Query.SQL.Add('        0.0 des_no_fac_importe_neto, ');
  end;
  if bAGastosFijos then
    Query.SQL.Add('        GetGastosCliente( empresa_sl, cliente_sl, fecha_sl, 0 ) gas_no_facturable, ')
  else
    Query.SQL.Add('        0.0 gas_no_facturable, ');

  Query.SQL.Add('        es_transito_sc tipo_salida, ');
  Query.SQL.Add('        CASE WHEN ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ');
  Query.SQL.Add('                 THEN 1 ELSE 0 END Transito, ');
  Query.SQL.Add('        centro_origen_sl centro_origen, case when fecha_factura_sc is null then 0 else 1 end facturado ');

  Query.SQL.Add(' from frf_salidas_c ');
  Query.SQL.Add('       join frf_salidas_l on empresa_sl = empresa_sc and centro_salida_sl = centro_salida_sc ');
  Query.SQL.Add('                      and n_albaran_sl = n_albaran_sc  and fecha_sl = fecha_sc ');
  Query.SQL.Add('       join frf_clientes on cliente_c = cliente_fac_sc ');
  Query.SQL.Add('       join frf_envases on envase_e = envase_sl ');

  if bASoloManuales then
  begin
    Query.SQL.Add(' WHERE empresa_sc = ''###'' ')
  end
  else
  begin
    if sAEmpresa = 'SAT' then
      Query.SQL.Add(' WHERE (empresa_sc = ''050'' or empresa_sc = ''080'') ')
    else
    if sAEmpresa = 'BAG' then
      Query.SQL.Add(' WHERE (empresa_sc[1,1] = ''F'' ) ')
    else
      Query.SQL.Add(' WHERE empresa_sc = :empresa ');

    if sACliente <> '' then
    begin
      Query.SQL.Add(' AND   cliente_sal_sc = :cliente ');
    end;
    if sAPais <> '' then
    begin
      if length(sAPais) = 2 then
      begin
        Query.SQL.Add(' and pais_c = :pais');
      end
      else
      begin
        if UPPERCASE(sAPais) = 'NACIONAL' then
        begin
          Query.SQL.Add(' and pais_c = "ES" ');
        end
        else
          if UPPERCASE(sAPais) = 'EXTRANJERO' then
          begin
            Query.SQL.Add(' and pais_c <> "ES" ');
          end;
      end;
    end;

    if sATipoCliente <> '' then
    begin
      if bAExcluirTipoCliente then
      begin
        Query.SQL.Add(' and tipo_cliente_c <> :tipocliente ');
      end
      else
      begin
        Query.SQL.Add(' and tipo_cliente_c = :tipocliente ');
      end;
    end;
    if bAExcluirInterplanta then
    begin
      Query.SQL.Add(' and tipo_cliente_c <> ''IP'' ');
    end;
    if iAClienteFac = 1 then
    begin
      Query.SQL.Add(' and substr( cliente_sal_sc, 1, 1 ) <> ''0'' and  cliente_sal_sc not in (''RET'',''REA'',''REP'',''GAN'',''EG'',''BAA'') ');
    end
    else
    if iAClienteFac = 2 then
    begin
      Query.SQL.Add(' and ( substr( cliente_sal_sc, 1, 1 ) = ''0'' or  cliente_sal_sc  in (''RET'',''REA'',''REP'',''GAN'',''EG'',''BAA'') ) ');
    end;

    if bAFechaSalida then
      Query.SQL.Add(' AND   fecha_sc BETWEEN :fechadesde AND :fechahasta ')
    else
      Query.SQL.Add(' AND   fecha_factura_sc BETWEEN :fechadesde AND :fechahasta ');

    if sAALbaran <> '' then
      Query.SQL.Add(' AND   n_albaran_sc = :albaran ');

    if sACentroOrigen <> '' then
      Query.SQL.Add(' AND   centro_origen_sl = :centroorigen  ');

    if sACentroSalida <> '' then
      Query.SQL.Add(' AND   centro_salida_sl = :centrodestino  ');

    if bAAlb6Digitos then
      Query.SQL.Add(' AND   n_albaran_sc > 99999 ');

    if sAProducto <> '' then
    begin
      if ( Copy( sAProducto,1,1) <> '+' ) and ( Copy( sAProducto,1,1) <> '-' ) then
      begin
        Query.SQL.Add(' AND (producto_sl = :producto)  ');
      end
      else
      begin
        if Copy( sAProducto,1,1) = '+' then
          Query.SQL.Add(' AND (producto_sl in  ' + Copy( sAProducto,2,Length(sAProducto)-1) +  ' )  ')
        else
        if Copy( sAProducto,1,1) = '-' then
          Query.SQL.Add(' AND (producto_sl not in  ' + Copy( sAProducto,2,Length(sAProducto)-1) +  ' )  ')
      end;
    end;

      if bANoP4H then
      begin
        Query.SQL.Add(' AND empresa_Sc <> ''F18'' ');
      end;

      if iAEsHortaliza  = 1 then
      begin

        Query.SQL.Add(' AND exists (  ');
        Query.SQL.Add('              select * from frf_productos ');
        Query.SQL.Add('              where producto_p = producto_sl ');
        Query.SQL.Add('              and estomate_p = ''S'' ) ');
      end
      else
      if iAEsHortaliza  = 2 then
      begin
        Query.SQL.Add(' AND exists (  ');
        Query.SQL.Add('              select * from frf_productos ');
        Query.SQL.Add('              where producto_p = producto_sl ');
        Query.SQL.Add('              and eshortaliza_p = ''S'' ) ');
      end
      else
      if iAEsHortaliza  = 3 then
      begin
        Query.SQL.Add(' AND exists (  ');
        Query.SQL.Add('              select * from frf_productos ');
        Query.SQL.Add('              where producto_p = producto_sl ');
        Query.SQL.Add('              and eshortaliza_p = ''N'' ) ');
      end;

    if sAEnvase <> '' then
      Query.SQL.Add(' AND   envase_sl = :envase ');

    if sACategoria <> '' then
    begin
      if Pos( ',', sACategoria ) > 0 then
      begin
        Query.SQL.Add(' AND   categoria_sl in (' + ListaDeCadenas( sACategoria ) + ')');
      end
      else
      begin
        Query.SQL.Add(' AND   categoria_sl = ' + QuotedStr( Trim( sACategoria ) ) );
      end;
    end;
    if sACalibre <> '' then
    begin
      Query.SQL.Add(' AND   calibre_sl = :calibre ');
    end;


    if iAAlbFacturado = 0 then
    begin
      //Sin facturar
      Query.SQL.Add(' AND  fecha_factura_sc is null ');
    end
    else
    if iAAlbFacturado = 1 then
    begin
      //Facturados
      Query.SQL.Add(' AND  fecha_factura_sc is not null ');
    end;

    if iAProductoPropio = 1 then
    begin
      Query.SQL.Add(' AND   emp_procedencia_sl = empresa_sc ');
    end
    else
    if iAProductoPropio = 2 then
    begin
      Query.SQL.Add(' AND   emp_procedencia_sl <> empresa_sc ');
    end;

//    Query.SQL.Add(' AND   empresa_c = empresa_sc ');
    Query.SQL.Add(' AND   cliente_c = cliente_fac_sc ');
  end;

  (*PARCHE*)//Fruta dev, parche pedido por jorge
  Query.SQL.Add(' AND  not ( n_albaran_sc = 319671 and fecha_sc = ''15/07/2017'' ) ');

  Query.SQL.Add(' GROUP BY empresa, cliente, pais, suministro, producto, orden_carga, linea, periodoFact, albaran,  fecha_albaran, envase, comercial, ');
  Query.SQL.Add('          centro, fecha, moneda, categoria, agrupacion, calibre, tipo_salida, Transito, centro_origen, facturado, ');
  Query.SQL.Add('          comision, descuento, des_fac_importe, des_fac_kilos, des_fac_pale, comision_representante, des_no_fac_importe, des_no_fac_kilos, des_no_fac_pale, des_no_fac_importe_neto,');
  Query.SQL.Add('          gas_no_facturable ');


  Query.SQL.Add(' ORDER BY cliente_sl, empresa, centro_salida_sc, n_albaran_sc, fecha_sc, moneda_sc, envase_sl ');

  if not bASoloManuales then
  begin
    if ( sAEmpresa <> 'SAT' ) and ( sAEmpresa <> 'BAG' ) then
      Query.ParamByName('empresa').AsString := sAEmpresa;

    if sACentroOrigen <> '' then
      Query.ParamByName('centroorigen').AsString := sACentroOrigen;
    if sACentroSalida <> '' then
      Query.ParamByName('centrodestino').AsString := sACentroSalida;
    if sAALbaran <> '' then
      Query.ParamByName('albaran').AsString := sAALbaran;
    Query.ParamByName('fechadesde').AsString := sAFechaDesde;
    Query.ParamByName('fechahasta').AsString := sAFEchaHasta;
    if sACliente <> '' then
      Query.ParamByName('cliente').AsString := sACliente
    else
    if length(sAPais) = 2 then
      Query.ParamByName('pais').AsString := sAPais;
    if sATipoCliente <> '' then
      Query.ParamByName('tipocliente').AsString := sATipoCliente;
    //if sACategoria <> '' then
    //  Query.ParamByName('categoria').AsString := sACategoria;
    if sACalibre <> '' then
      Query.ParamByName('calibre').AsString := sACalibre;
    if sAEnvase <> '' then
      Query.ParamByName('envase').AsString := sAEnvase;

    if sAProducto <> '' then
    begin
      if ( Copy( sAProducto,1,1) <> '+' ) and ( Copy( sAProducto,1,1) <> '-' ) then
      begin
        Query.ParamByName('producto').AsString := sAProducto;
      end;
    end;
  end;

  //Query.Sql.SaveToFile('c:\pepe1.sql');
  Query.Open;
  try
    ClientDataSet.Open;
  finally
    Query.Close;
  end;
  if not ClientDataSet.IsEmpty then
  begin
    RellenaDatosFaltantes(bLiquida);
    result := True;
  end
  else
  begin
    result := False;
  end;
  if bAManuales then
  begin
    bAux:= FacturasManualesEnvase;
  end
  else
  begin
    bAux:= False;
  end;
  result:= result or  bAux;
end;

procedure TDMTablaTemporalFOB.RellenaDatosFaltantes(const bLiquida: Boolean) ;
var
  iAlbaran, iProductoBase: integer;
  fFactorCambio: Real;
  rCosteEnvase, rCosteSecciones: Real;
  bHayGasto, bEsDevolucion: Boolean;
  rGastoNoFac, rGastoFac, rGastoTransito: Real;
  sAlbaranProd: string;
  rComision, rDescuento, rDescuentoNeto, rAux, rComisionAux: Real;
  rEuroKilo, rPorcentaje: real;
begin
  fFactorCambio := 1;
  iAlbaran := 0;
  sAlbaranProd:= '';
  ClientDataSet.First;
  rDescuentoNeto := 0;
  rCosteEnvase:= 0;
  rCosteSecciones:= 0;
  bHayGasto:= False;

  PrepareQGastos;
  while not ClientDataSet.Eof do
  begin
    ClientDataSet.Edit;

    bEsDevolucion := false;

    if not bLiquida then
    begin
      if ClientDataSet.Fieldbyname('tipo_salida').AsInteger = 2 then    //Tipo de Salida - Devolucion
      begin
        bEsDevolucion := true;
        ClientDataSet.FieldByName('kilos_producto').AsFloat := 0;
        ClientDataSet.FieldByName('cajas_producto').AsFloat := 0;
        ClientDataSet.FieldByName('unidades_producto').AsFloat := 0;
        ClientDataSet.FieldByName('palets_producto').AsFloat := 0;
      end;
    end;


    if (bAComisiones) and (not bEsDevolucion) then
    begin
      rComision:= bRoundTo( ClientDataSet.FieldByName('kilos_producto').AsFloat * ClientDataSet.FieldByName('des_fac_kilos').AsFloat, 3);
      rComision:= rComision + bRoundTo( ClientDataSet.FieldByName('palets_producto').AsFloat * ClientDataSet.FieldByName('des_fac_pale').AsFloat, 3);
      rComision:= rComision + bRoundTo( ClientDataSet.FieldByName('importe').AsFloat * ( ClientDataSet.FieldByName('des_fac_importe').AsFloat / 100 ), 3 );
      rAux:= ClientDataSet.FieldByName('importe').AsFloat - rComision;
      if rAux > 0 then
      begin
        rComision:= rComision + bRoundTo( rAux * ( ClientDataSet.FieldByName('comision_representante').AsFloat / 100 ), 3 );
      end;
    end
    else
    begin
      rComision:= 0;
    end;

    if (bADescuentos) and (not bEsDevolucion) then
    begin
      // Calculamos las comisiones, aunque no se imprima-
      rComisionAux:= bRoundTo( ClientDataSet.FieldByName('kilos_producto').AsFloat * ClientDataSet.FieldByName('des_fac_kilos').AsFloat, 3);
      rComisionAux:= rComisionAux + bRoundTo( ClientDataSet.FieldByName('palets_producto').AsFloat * ClientDataSet.FieldByName('des_fac_pale').AsFloat, 3);
      rComisionAux:= rComisionAux + bRoundTo( ClientDataSet.FieldByName('importe').AsFloat * ( ClientDataSet.FieldByName('des_fac_importe').AsFloat / 100 ), 3 );
      rAux:= ClientDataSet.FieldByName('importe').AsFloat - rComisionAux;
      if rAux > 0 then
      begin
        rComisionAux:= rComisionAux + bRoundTo( rAux * ( ClientDataSet.FieldByName('comision_representante').AsFloat / 100 ), 3 );
      end;
      //
      rDescuentoNeto:=0;
      rDescuento:= bRoundTo( ClientDataSet.FieldByName('kilos_producto').AsFloat * ClientDataSet.FieldByName('des_no_fac_kilos').AsFloat, 3);
      rDescuento:= rDescuento + bRoundTo( ClientDataSet.FieldByName('palets_producto').AsFloat * ClientDataSet.FieldByName('des_no_fac_pale').AsFloat, 3);
      rAux:= ClientDataSet.FieldByName('importe').AsFloat - rComisionAux;
      if rAux > 0 then
      begin
        rDescuento:= rDescuento + bRoundTo( rAux * ( ClientDataSet.FieldByName('des_no_fac_importe').AsFloat / 100 ), 3 );
      end;
      //Añadir % descuentos No Facturados netos(sobre el total de la factura, incluido iva) 23/11/2018
      rAux :=  ClientDataSet.FieldByName('importe_total').AsFloat - rComision;
      if rAux > 0 then
      begin
        rDescuentoNeto:= rDescuentoNeto + bRoundTo( rAux * ( ClientDataSet.FieldByName('des_no_fac_importe_neto').AsFloat / 100 ), 3 );
      end;
    end
    else
    begin
      rDescuento:= 0;
      rDescuentoNeto:= 0;
    end;

    ClientDataSet.FieldByName('comision').AsFloat:= rComision;
    ClientDataSet.FieldByName('descuento').AsFloat:= rDescuento + rDescuentoNeto;
    ClientDataSet.FieldByName('neto').AsFloat:= ClientDataSet.FieldByName('importe').AsFloat - ( rComision + rDescuento + rDescuentoNeto);

    if iAlbaran <> ClientDataSet.FieldByName('albaran').AsInteger then
    begin
      iAlbaran := ClientDataSet.FieldByName('albaran').AsInteger;

      fFactorCambio := FactorCambioFOB(ClientDataSet.FieldByName('empresa').AsString,
        ClientDataSet.FieldByName('centro').AsString,
        ClientDataSet.FieldByName('fecha').AsString,
        ClientDataSet.FieldByName('albaran').AsString,
        ClientDataSet.FieldByName('moneda').AsString);
      if fFactorCambio = 0 then fFactorCambio := 1;
    end;

    if sAlbaranProd <> ClientDataSet.FieldByName('empresa').AsString + ClientDataSet.FieldByName('albaran').AsString + ClientDataSet.FieldByName('producto').AsString then
    begin
      sAlbaranProd:= ClientDataSet.FieldByName('empresa').AsString + ClientDataSet.FieldByName('albaran').AsString + ClientDataSet.FieldByName('producto').AsString;

      GetKilosAlbaran( ClientDataSet.FieldByName('empresa').AsString, ClientDataSet.FieldByName('centro').AsString, ClientDataSet.FieldByName('albaran').AsInteger,
        ClientDataSet.FieldByName('fecha').AsDateTime, ClientDataSet.FieldByName('producto').AsString);


      if bAGastosNoFac or bAGastosFac or bAGastosTransitos then
      begin
        bHayGasto:= GetGastosAlbaran( ClientDataSet.FieldByName('empresa').AsString, ClientDataSet.FieldByName('centro').AsString,
          ClientDataSet.FieldByName('albaran').AsInteger, ClientDataSet.FieldByName('fecha').AsDateTime  );
      end
      else
      begin
        bHayGasto:= False;
      end;
    end;

    if bACosteEnvase or bACosteSecciones then
    begin
//        QProductoBase.ParamByName('producto').AsString:= ClientDataSet.FieldByName('producto').AsString;
//        QProductoBase.Open;
//        iProductoBase:= QProductoBase.FieldByName('producto_base_p').AsInteger;
//        QProductoBase.Close;

        GetCostesEnvasado(ClientDataSet.FieldByName('empresa').AsString,
                          ClientDataSet.FieldByName('centro').AsString,
                          ClientDataSet.FieldByName('centro_origen').AsString,
                          ClientDataSet.FieldByName('envase').AsString,
                          ClientDataSet.FieldByName('producto').AsString,
                          ClientDataSet.FieldByName('fecha').AsDateTime,
                          iProductoBase, rCosteEnvase, rCosteSecciones ); //APromedio:= true
    end;

    ClientDataSet.FieldByName('cambio').AsFloat := fFactorCambio;
    ClientDataSet.FieldByName('kilos_transito').AsFloat := rgKilosTransito;
    ClientDataSet.FieldByName('kilos_total').AsFloat := rgKilosTotal;

    if (bHayGasto) and (not bEsDevolucion) then
    begin
      AddGasto(  rGastoNoFac, rGastoFac, rGastoTransito );
    end
    else
    begin
      rGastoNoFac:= 0;
      rGastoFac:= 0;
      rGastoTransito:= 0;
    end;
    if (bAGastosNoFac) and (not bEsDevolucion)then
    begin
      rGastoTransito:= rGastoTransito + GastosTransitosSAT;
    end;

    if (bAGastosFijos) and ( ClientDataSet.FieldByName('gas_no_facturable').AsFloat <> -1) then
    begin
      rGastoNoFac := rGastoNoFac +  bRoundTo( ClientDataSet.FieldByName('kilos_producto').AsFloat * ClientDataSet.FieldByName('gas_no_facturable').AsFloat, 3);
    end;

    ClientDataSet.FieldByName('gasto_comun').AsFloat := rGastoNoFac + rGastoFac;
    ClientDataSet.FieldByName('gasto_fac').AsFloat := rGastoFac;
    ClientDataSet.FieldByName('gasto_no_fac').AsFloat := rGastoNoFac;
    ClientDataSet.FieldByName('gasto_transito').AsFloat := rGastoTransito;

    if (bACosteEnvase) and (not bEsDevolucion) then
    begin
      ClientDataSet.FieldByName('coste_envase').AsFloat :=
        bRoundTo( rCosteEnvase * ClientDataSet.FieldByName('kilos_producto').AsFloat, -3);
    end
    else
    begin
      ClientDataSet.FieldByName('coste_envase').AsFloat := 0;
    end;

    if (bCosteFruta) and (not bEsDevolucion) then
    begin
      ClientDataSet.FieldByName('coste_fruta').AsFloat :=
        bRoundTo( CosteMedioMateriaPrimaDM.GetCosteMedioMateriaPrima( ClientDataSet.FieldByName('empresa').AsString,
                                                                      ClientDataSet.FieldByName('centro_origen').AsString,
                                                                      ClientDataSet.FieldByName('producto').AsString,
                                                                      ClientDataSet.FieldByName('categoria').AsString )
                  * ClientDataSet.FieldByName('kilos_producto').AsFloat, -3);
    end
    else
    begin
      ClientDataSet.FieldByName('coste_fruta').AsFloat := 0;
    end;


    if bAyudas  then
    begin
      if ( ClientDataSet.FieldByName('empresa').AsString = '050' ) or ( ClientDataSet.FieldByName('empresa').AsString = '080' ) then
      begin
        AyudasSAT( rEuroKilo, rPorcentaje );
      end
      else
      begin
        AyudasBAG( rEuroKilo, rPorcentaje );
      end;
        ClientDataSet.FieldByName('ayudas_fruta').AsFloat :=
            bRoundTo( ClientDataSet.FieldByName('kilos_producto').AsFloat * rEuroKilo, 2) +
            bRoundTo( ( ClientDataSet.FieldByName('importe').AsFloat * ClientDataSet.FieldByName('cambio').AsFloat ) * ( rPorcentaje / 100 ), 2) ;
    end
    else
    begin
      ClientDataSet.FieldByName('ayudas_fruta').AsFloat := 0;
    end;

    //Solo categoria comerciales
    if (bCosteEstructura) and (not bEsDevolucion) then
    begin
      ClientDataSet.FieldByName('coste_estructura').AsFloat :=
        bRoundTo( CosteEstructuralDM.GetCosteEstructura( ClientDataSet.FieldByName('empresa').AsString,
                                                         ClientDataSet.FieldByName('centro').AsString)
                  * ClientDataSet.FieldByName('kilos_producto').AsFloat, -3);
    end
    else
    begin
      ClientDataSet.FieldByName('coste_estructura').AsFloat := 0;
    end;

    if (bACosteSecciones) and (not bEsDevolucion) then
    begin
      ClientDataSet.FieldByName('coste_seccion').AsFloat:=
        bRoundTo( rCosteSecciones * ClientDataSet.FieldByName('kilos_producto').AsFloat, -3);
    end
    else
    begin
      ClientDataSet.FieldByName('coste_seccion').AsFloat:= 0;
    end;

    ClientDataSet.FieldByName('coste_envasado').AsFloat :=
      ClientDataSet.FieldByName('coste_envase').AsFloat + ClientDataSet.FieldByName('coste_seccion').AsFloat;


    ClientDataSet.Post;
    ClientDataSet.Next;
  end;
  qryGastoAlbaran.Close;
  ClientDataSet.First;

  if bEnvasesSinCoste then
    CostesEnvasesFalta;
end;


procedure TDMTablaTemporalFOB.AyudasSAT( var AEuros, APorcentaje: real );
begin
  if ( ClientDataSet.FieldByName('empresa').AsString = '050' ) then
  begin
    Ayudas050( AEuros, APorcentaje );
  end
  else
  begin
    Ayudas080( AEuros, APorcentaje );
  end;
end;

procedure TDMTablaTemporalFOB.Ayudas050( var AEuros, APorcentaje: real );
var
  sMes, sCliente: string;
  dPrimero, dUltimo: TDateTime;
  rAux: real;
begin
  sCliente:= '';
  sMes:= AnyoMesEx( ClientDataSet.FieldByName('fecha').AsDateTime, dPrimero, dUltimo );
  if not kmtAyudas.Locate('empresa;producto;centro;cliente;mes',
                      varArrayOf([ClientDataSet.FieldByName('empresa').AsString,
                                  ClientDataSet.FieldByName('producto').AsString,
                                  ClientDataSet.FieldByName('centro').AsString, sCliente, sMes]), [] ) then
  begin
    if ( ClientDataSet.FieldByName('centro').AsString = '6' ) then
    begin
      qryAyudasSAT.ParamByName('producto').AsString:= ClientDataSet.FieldByName('producto').AsString;
      qryAyudasSAT.Open;
      SalvarAyuda( ClientDataSet.FieldByName('empresa').AsString,
                   ClientDataSet.FieldByName('centro').AsString,
                   ClientDataSet.FieldByName('producto').AsString,
                   sCliente, sMes,
                 qryAyudasSAT.FieldByName('eur_kilo_tenerife_p').AsFloat,
                 qryAyudasSAT.FieldByName('porcen_importe_tenerife_p').AsFloat );
      qryAyudasSAT.Close;
    end
    else
    begin
      qryAyudasSAT.ParamByName('producto').AsString:= ClientDataSet.FieldByName('producto').AsString;
      qryAyudasSAT.Open;
      if ( qryAyudasSAT.FieldByName('eur_kilo_transito_p').AsFloat + qryAyudasSAT.FieldByName('porcen_importe_transito_p').AsFloat ) = 0 then
      begin
        SalvarAyuda( ClientDataSet.FieldByName('empresa').AsString,
                   ClientDataSet.FieldByName('centro').AsString,
                   ClientDataSet.FieldByName('producto').AsString, sCliente, sMes, 0, 0 );
      end
      else
      begin
        rAux:= AyudaMensualTransito( dPrimero, dUltimo );
        SalvarAyuda( ClientDataSet.FieldByName('empresa').AsString,
                   ClientDataSet.FieldByName('centro').AsString,
                   ClientDataSet.FieldByName('producto').AsString, sCliente, sMes, rAux, 0 );
      end;
      qryAyudasSAT.Close;
    end;
  end;
  AEuros:= kmtAyudas.FieldByName('ayuda_kilo').AsFloat;
  APorcentaje:= kmtAyudas.FieldByName('ayuda_porcen').AsFloat;
end;

procedure TDMTablaTemporalFOB.Ayudas080( var AEuros, APorcentaje: real );
var
  sMes, sCliente: string;
  dPrimero, dUltimo: TDateTime;
  rAux: real;
begin
  sMes:= AnyoMesEx( ClientDataSet.FieldByName('fecha').AsDateTime, dPrimero, dUltimo );
  if ClientDataSet.FieldByName('cliente').AsString = 'BAG' then
    sCliente:= 'BAG'
  else
    sCliente:= '';
  if not kmtAyudas.Locate('empresa;producto;centro;cliente;mes',
                      varArrayOf([ClientDataSet.FieldByName('empresa').AsString,
                                  ClientDataSet.FieldByName('producto').AsString,
                                  ClientDataSet.FieldByName('centro').AsString, sCliente, sMes]), [] ) then
  begin
    if ( ClientDataSet.FieldByName('centro').AsString = '6' ) then
    begin
      qryAyudasSAT.ParamByName('producto').AsString:= ClientDataSet.FieldByName('producto').AsString;
      qryAyudasSAT.Open;
      if sCliente = 'BAG' then
        //Ayuda exporta
        SalvarAyuda( ClientDataSet.FieldByName('empresa').AsString,
                   ClientDataSet.FieldByName('centro').AsString,
                   ClientDataSet.FieldByName('producto').AsString, sCliente, sMes,
                 qryAyudasSAT.FieldByName('eur_kilo_transito_p').AsFloat,
                 qryAyudasSAT.FieldByName('porcen_importe_transito_p').AsFloat )

      else
        //Ayuda local
         SalvarAyuda( ClientDataSet.FieldByName('empresa').AsString,
                   ClientDataSet.FieldByName('centro').AsString,
                   ClientDataSet.FieldByName('producto').AsString, sCliente, sMes,
                      qryAyudasSAT.FieldByName('eur_kilo_tenerife_p').AsFloat,
                 qryAyudasSAT.FieldByName('porcen_importe_tenerife_p').AsFloat );
      qryAyudasSAT.Close;
    end
    else
    begin
      qryAyudasSAT.ParamByName('producto').AsString:= ClientDataSet.FieldByName('producto').AsString;
      qryAyudasSAT.Open;
      if ( qryAyudasSAT.FieldByName('eur_kilo_transito_p').AsFloat + qryAyudasSAT.FieldByName('porcen_importe_transito_p').AsFloat ) = 0 then
      begin
        SalvarAyuda( ClientDataSet.FieldByName('empresa').AsString,
                   ClientDataSet.FieldByName('centro').AsString,
                   ClientDataSet.FieldByName('producto').AsString, sCliente, sMes, 0, 0 );
      end
      else
      begin
        rAux:= AyudaMensualTransito( dPrimero, dUltimo );
        SalvarAyuda( ClientDataSet.FieldByName('empresa').AsString,
                   ClientDataSet.FieldByName('centro').AsString,
                   ClientDataSet.FieldByName('producto').AsString, sCliente, sMes, rAux, 0 );
      end;
      qryAyudasSAT.Close;
    end;
  end;
  AEuros:= kmtAyudas.FieldByName('ayuda_kilo').AsFloat;
  APorcentaje:= kmtAyudas.FieldByName('ayuda_porcen').AsFloat;
end;


function TDMTablaTemporalFOB.AyudaMensualTransito( const AFechaini, AFechaFin: TDateTime ): real;
var
  rMaxKilos: real;
begin
  qryDatosTransitos.ParamByName('empresa').AsString:=  ClientDataSet.FieldByName('empresa').AsString;
  qryDatosTransitos.ParamByName('producto').AsString:=  ClientDataSet.FieldByName('producto').AsString;
  qryDatosTransitos.ParamByName('fechaini').AsDateTime:=  AFechaIni;
  qryDatosTransitos.ParamByName('fechafin').AsDateTime:=  AFechaFin;
  qryDatosTransitos.Open;
  //Importes ayuda transito mes
  result:= bRoundTo( qryDatosTransitos.FieldByName('kilos_tenerife').AsFloat*qryAyudasSAT.FieldByName('eur_kilo_transito_p').AsFloat, 2);
  result:= result +  bRoundTo( qryDatosTransitos.FieldByName('importe_tenerife').AsFloat*(qryAyudasSAT.FieldByName('porcen_importe_transito_p').AsFloat/100), 2);

  rMaxKilos:= qryDatosTransitos.FieldByName('kilos_total').AsInteger;
  if rMaxKilos < qryDatosTransitos.FieldByName('kilos_tenerife').AsFloat then
    rMaxKilos := qryDatosTransitos.FieldByName('kilos_tenerife').AsFloat;
  if rMaxKilos <> 0 then
    result:= bRoundTo( result / rMaxKilos,4)
  else
    result:= 0;
  qryDatosTransitos.Close;
end;

function TDMTablaTemporalFOB.AyudaMensualClienteBAG( const AProducto: string; const AFechaini, AFechaFin: TDateTime ): real;
var
  rAux: real;
begin
  //qryDatosPlantaBAG.ParamByName('empresa').AsString:=  ClientDataSet.FieldByName('empresa').AsString;
  qryDatosPlantaBAG.ParamByName('producto').AsString:=  ClientDataSet.FieldByName('producto').AsString;
  qryDatosPlantaBAG.ParamByName('fechaini').AsDateTime:=  AFechaIni;
  qryDatosPlantaBAG.ParamByName('fechafin').AsDateTime:=  AFechaFin;
  qryDatosPlantaBAG.Open;
  rAux:= qryDatosPlantaBAG.FieldByname('kilos').AsFloat;
  qryDatosPlantaBAG.Close;


  qryDatosClienteBAG.ParamByName('producto').AsString:=  AProducto;
  qryDatosClienteBAG.ParamByName('fechaini').AsDateTime:=  AFechaIni;
  qryDatosClienteBAG.ParamByName('fechafin').AsDateTime:=  AFechaFin;
  qryDatosClienteBAG.Open;

  if rAux < qryDatosClienteBAG.FieldByName('kilos').AsFloat then
    rAux:= qryDatosClienteBAG.FieldByName('kilos').AsFloat;

  //Importes ayuda transito mes
  result:= bRoundTo( qryDatosClienteBAG.FieldByName('kilos').AsFloat*qryAyudasSAT.FieldByName('eur_kilo_transito_p').AsFloat, 2);
  result:= result +  bRoundTo( qryDatosClienteBAG.FieldByName('importe').AsFloat*(qryAyudasSAT.FieldByName('porcen_importe_transito_p').AsFloat/100), 2);
  if rAux <> 0 then
    result:= bRoundTo( result / rAux,4)
  else
    result:= 0;
  qryDatosClienteBAG.Close;
end;

procedure TDMTablaTemporalFOB.SalvarAyuda( const AEmpresa, ACentro, AProducto, ACliente, AMes: string; const AEuros, APorcentaje: Real );
begin
  kmtAyudas.Insert;
  kmtAyudas.FieldByName('empresa').AsString:= AEmpresa;
  kmtAyudas.FieldByName('producto').AsString:= AProducto;
  kmtAyudas.FieldByName('centro').AsString:= ACentro;
  kmtAyudas.FieldByName('cliente').AsString:= ACliente;
  kmtAyudas.FieldByName('mes').AsString:= AMes;
  kmtAyudas.FieldByName('ayuda_kilo').AsFloat:= AEuros;
  kmtAyudas.FieldByName('ayuda_porcen').AsFloat:= APorcentaje;
  kmtAyudas.Post;
end;


function ProductoBagToSat( const AProducto: string ): string;
begin
//Suponemos que es de BAG a 080 ¿???
   if AProducto = 'PEH' then Result:= 'PEH'
   else if AProducto = 'CAL' then Result:= 'CAL'
   else if AProducto = 'GRA' then Result:= 'GRA'
   else if AProducto = 'LMA' then Result:= 'LMA'
   else if AProducto = 'MGO' then Result:= 'MGO'
   else if AProducto = 'PAP' then Result:= 'PAP'
   else if AProducto = 'PAM' then Result:= 'PAM'
   else if AProducto = 'PRO' then Result:= 'PRO'
   else if AProducto = 'PNA' then Result:= 'PNA'
   else if AProducto = 'PVE' then Result:= 'PVE'
   else Result:= '';

end;

procedure  TDMTablaTemporalFOB.AyudasBAG( var AEuros, APorcentaje: real );
var
  sProductoSAT: string;
  sMes, sEmpresa, sCliente, sCentro: string;
  dPrimero, dUltimo: TDateTime;
  rAux: real;
begin
  sCliente:= '';
  sCentro:= '';
  sProductoSAT:= ProductoBagToSat( ClientDataSet.FieldByName('producto').AsString );
  if sProductoSAT <> '' then
  begin
    sMes:= AnyoMesEx( ClientDataSet.FieldByName('fecha').AsDateTime, dPrimero, dUltimo );
    if ( Copy(ClientDataSet.FieldByName('empresa').AsString,1,1) = 'F' ) then
    begin
      if ( ClientDataSet.FieldByName('empresa').AsString = 'F23' ) then
        sEmpresa:= 'F23'
      else
        sEmpresa:= 'BAG';
    end
    else
    begin
      sEmpresa:= ClientDataSet.FieldByName('empresa').AsString;
    end;

    if not kmtAyudas.Locate('empresa;producto;centro;cliente;mes',
                      varArrayOf([sEmpresa, ClientDataSet.FieldByName('producto').AsString, sCentro, sCliente, sMes]), [] ) then
    begin
      if ( ClientDataSet.FieldByName('empresa').AsString = 'F23' ) then
      begin
        //Ayuda local
        qryAyudasSAT.ParamByName('producto').AsString:= sProductoSAT;
        qryAyudasSAT.Open;
        SalvarAyuda(sEmpresa, sCentro, ClientDataSet.FieldByName('producto').AsString, sCliente, sMes,
                 qryAyudasSAT.FieldByName('eur_kilo_tenerife_p').AsFloat,
                 qryAyudasSAT.FieldByName('porcen_importe_tenerife_p').AsFloat );
        qryAyudasSAT.Close;
      end
      else
      begin
        //Ayuda exporta, ventas de 080 a BAG
        qryAyudasSAT.ParamByName('producto').AsString:= sProductoSAT;
        qryAyudasSAT.Open;
        if ( qryAyudasSAT.FieldByName('eur_kilo_transito_p').AsFloat + qryAyudasSAT.FieldByName('porcen_importe_transito_p').AsFloat ) = 0 then
        begin
          SalvarAyuda( sEmpresa, sCentro, ClientDataSet.FieldByName('producto').AsString, sCliente, sMes, 0, 0 );
        end
        else
        begin
          rAux:= AyudaMensualClienteBAG( sProductoSAT, dPrimero, dUltimo );
          SalvarAyuda( sEmpresa, sCentro, ClientDataSet.FieldByName('producto').AsString, sCliente, sMes, rAux, 0 );
        end;
        qryAyudasSAT.Close;
      end;
    end;
    AEuros:= kmtAyudas.FieldByName('ayuda_kilo').AsFloat;
    APorcentaje:= kmtAyudas.FieldByName('ayuda_porcen').AsFloat;
  end
  else
  begin
    AEuros:= 0;
    APorcentaje:= 0;
  end;
end;


function TDMTablaTemporalFOB.GastosTransitosSAT: Real;
var
  sMes: string;
  dPrimero, dUltimo: TDateTime;
begin
  if ( Copy( ClientDataSet.FieldByName('empresa').AsString, 1, 1 ) = 'F' ) and
     ( ClientDataSet.FieldByName('empresa').AsString <> 'F23' ) then
  begin
    sMes:= AnyoMesEx( ClientDataSet.FieldByName('fecha').AsDateTime, dPrimero, dUltimo );
    if kmtTransitosSAT_BAG.Locate( 'mes;producto',
         VarArrayOf( [sMes, ClientDataSet.FieldByName('producto').AsString ]), [] ) then
    begin
      Result:= bRoundTo( ClientDataSet.FieldByName('kilos_producto').AsFloat * kmtTransitosSAT_BAG.FieldByName('coste').AsFloat, 2) ;
    end
    else
    begin
      Result:= bRoundTo( ClientDataSet.FieldByName('kilos_producto').AsFloat * NuevoGastoTransitosSAT( sMes, dPrimero, dUltimo ), 2);
    end;
  end
  else
  begin
    Result:= 0;
  end;
end;


procedure TDMTablaTemporalFOB.CostesEnvasesFalta;
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


procedure TDMTablaTemporalFOB.GetKilosAlbaran(
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

    rgPaletsTotal := FieldByName('total_palets').AsFloat;
    rgPaletsTransito := FieldByName('transito_palets').AsFloat;
    rgPaletsProdTotal := FieldByName('total_prod_palets').AsFloat;
    rgPaletsProdTransito := FieldByName('transito_prod_palets').AsFloat;

    rgCajasTotal := FieldByName('total_cajas').AsFloat;
    rgCajasTransito := FieldByName('transito_cajas').AsFloat;
    rgCajasProdTotal := FieldByName('total_prod_cajas').AsFloat;
    rgCajasProdTransito := FieldByName('transito_prod_cajas').AsFloat;

    rgImporteTotal := FieldByName('total_importe').AsFloat;
    rgImporteConIva := FieldByName('importe_con_iva').AsFloat;
    rgImporteTransito := FieldByName('transito_importe').AsFloat;
    rgImporteProdTotal := FieldByName('total_prod_importe').AsFloat;
    rgImporteProdTransito := FieldByName('transito_prod_importe').AsFloat;
    Close;
  end;
end;

function TDMTablaTemporalFOB.GetGastosAlbaran( const AEmpresa, ACentro: string;
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
    if sATipoGasto <> '' then
      ParamByName('tipo').AsString := sATipoGasto;
    Open;
    Result:= not isempty;
  end;
end;

function TDMTablaTemporalFOB.EsProductoConGasto: Boolean;
begin
  if qryGastoAlbaran.fieldByName('producto').AsString = '' then
  begin
    result:= True;
  end
  else
  if ClientDataSet.FieldByName('producto').AsString = qryGastoAlbaran.fieldByName('producto').AsString then
  begin
    result:= True;
  end
  else
  begin
    result:= False;
  end;
end;

function TDMTablaTemporalFOB.PutGasto( const AUnidades: Real;  const AUnidadesTotal: string; var ANoFac, AFac: Real ): Boolean;
var
  rAux: Real;
begin

  if ( AUnidades > 0 ) and ( ClientDataSet.FieldByName( AUnidadesTotal ).AsFloat  > 0 )then
  begin
    rAux:= ClientDataSet.FieldByName( AUnidadesTotal ).AsFloat / AUnidades;
    if bAGastosNoFac then
      ANoFac:= ANoFac +  qryGastoAlbaran.fieldByName('gasto_nofac').AsFloat * rAux;
    if bAGastosFac then
      AFac:= AFac +  qryGastoAlbaran.fieldByName('gasto_fac').AsFloat * rAux;
    result:= True;
  end
  else
  begin
    result:= False;
  end;
end;

procedure TDMTablaTemporalFOB.AddGastoTotal( var AGastoNoFac, AGastoFac, AGastoTransito: Real );

begin
  if ( qryGastoAlbaran.fieldByName('transito').AsInteger = 1 ) then
  begin
    if bAGastosTransitos then
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
        if not PutGasto( rgCajasTransito, 'cajas_producto',  AGastoTransito, AGastoFac ) then
        begin
          PutGasto( rgKilosTransito, 'kilos_producto',  AGastoTransito, AGastoFac );
        end;
      end
      else
      //PALETS
      if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'P' then
      begin
        if not PutGasto( rgPaletsTransito, 'palets_producto',  AGastoTransito, AGastoFac ) then
        begin
          if not PutGasto( rgCajasTransito, 'cajas_producto',  AGastoTransito, AGastoFac ) then
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
    end;
  end
  else
  if bAGastosNoFac or bAGastosFac then
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
      if not PutGasto( rgCajasTotal, 'cajas_producto',  AGastoNoFac, AGastoFac ) then
      begin
        PutGasto( rgKilosTotal, 'kilos_producto',  AGastoNoFac, AGastoFac );
      end;
    end
    else
    //PALETS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'P' then
    begin
      if not PutGasto( rgPaletsTotal, 'palets_producto',  AGastoNoFac, AGastoFac ) then
      begin
        if not PutGasto( rgCajasTotal, 'cajas_producto',  AGastoNoFac, AGastoFac ) then
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

procedure TDMTablaTemporalFOB.AddGastoProducto( var AGastoNoFac, AGastoFac, AGastoTransito: Real );
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
      if not PutGasto( rgCajasProdTransito, 'cajas_producto',  AGastoTransito, AGastoFac ) then
      begin
        PutGasto( rgKilosProdTransito, 'kilos_producto',  AGastoTransito, AGastoFac );
      end;
    end
    else
    //PALETS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'P' then
    begin
      if not PutGasto( rgPaletsProdTransito, 'palets_producto',  AGastoTransito, AGastoFac ) then
      begin
        if not PutGasto( rgCajasProdTransito, 'cajas_producto',  AGastoTransito, AGastoFac ) then
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
      if not PutGasto( rgCajasProdTotal, 'cajas_producto',  AGastoNoFac, AGastoFac ) then
      begin
        PutGasto( rgKilosProdTotal, 'kilos_producto',  AGastoNoFac, AGastoFac );
      end;
    end
    else
    //PALETS
    if Copy( qryGastoAlbaran.fieldByName('unidad').AsString, 1, 1 ) = 'P' then
    begin
      if not PutGasto( rgPaletsProdTotal, 'palets_producto',  AGastoNoFac, AGastoFac ) then
      begin
        if not PutGasto( rgCajasProdTotal, 'cajas_producto',  AGastoNoFac, AGastoFac ) then
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

procedure TDMTablaTemporalFOB.AddGasto( var AGastoNoFac, AGastoFac, AGastoTransito: Real );
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




procedure TDMTablaTemporalFOB.CostesSeccionEnvase( const AEmpresa, ACentro, AEnvase, AProducto: string; var ASecciones, PASecciones: real;
                                                   const AProductoBase, AAnyo, AMes: integer  );
begin
  if ( ClientDataSet.FieldByName('empresa').AsString = '080' ) or
     ( ClientDataSet.FieldByName('empresa').AsString = '050' ) then
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
      ASecciones:= FieldByName('secciones_ec').AsFloat;
      PASecciones:= FieldByName('psecciones_ec').AsFloat;
    finally
      Close;
    end;
  end
  else
  begin
    ASecciones:= 0;
    PASecciones:= 0;
  end;
end;

function TDMTablaTemporalFOB.CosteEnvaseDirecto( const AEmpresa, ACentro, AEnvase, AProducto: string;
  const AAnyo, AMes, AProductoBase: integer;
  var AEnvasado, ASecciones, APEnvasado, APSecciones: real; var AAnyoEnvase, AMesEnvase: Integer ): integer;
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
          APEnvasado := 0;
          APSecciones := 0;
          AEnvasado := 0;
          ASecciones := 0;
          AAnyoEnvase:= AAnyo;
          AMesEnvase:= AMes;
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
          First;

          APEnvasado := FieldByName('pcoste_ec').AsFloat;
          APSecciones := FieldByName('psecciones_ec').AsFloat;
          AEnvasado := FieldByName('coste_ec').AsFloat;
          ASecciones := FieldByName('secciones_ec').AsFloat;
          AAnyoEnvase:= FieldByName('anyo_ec').AsInteger;
          AMesEnvase:= FieldByName('mes_ec').AsInteger;
        end;
        (*
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
        *)
        (*
          APEnvasado := FieldByName('pcoste_ec').AsFloat;
          APSecciones := FieldByName('psecciones_ec').AsFloat;
          AEnvasado := FieldByName('coste_ec').AsFloat;
          ASecciones := FieldByName('secciones_ec').AsFloat;
        AAnyoEnvase:= FieldByName('anyo_ec').AsInteger;
        AMesEnvase:= FieldByName('mes_ec').AsInteger;
        *)
      finally
        Close;
      end;
    end;
end;


function TDMTablaTemporalFOB.CosteEnvaseindirecto( const AEmpresa, ACentro, AEnvase, AProducto: string;
                                 const AAnyo, AMes, AProductoBase: integer;
                                 var AEnvasado, ASecciones, APEnvasado, PASecciones: real; var AAnyoEnvase, AMesEnvase: Integer ): integer;
var
  sEmpresa, sEnvase: string;
begin
  if ( Copy( ClientDataSet.FieldByName('empresa').AsString, 1, 1 ) = 'F' )  then
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
        //ParamByName('producto').AsInteger:= getproductobasesat;
        ParamByName('anyo').AsInteger:= AAnyo;
        ParamByName('mes').AsInteger:= AMes;
        Open;
        if not IsEmpty then
        begin
            APEnvasado:= FieldByName('pcoste_ec').AsFloat;
            PASecciones:= FieldByName('psecciones_ec').AsFloat;
            AEnvasado:= FieldByName('coste_ec').AsFloat;
            ASecciones:= FieldByName('secciones_ec').AsFloat;
          (*
          if bAPromedio then
          begin
            AEnvasado:= FieldByName('pcoste_ec').AsFloat;
            ASecciones:= FieldByName('psecciones_ec').AsFloat;
          end
          else
          begin
            AEnvasado:= FieldByName('coste_ec').AsFloat;
            ASecciones:= FieldByName('secciones_ec').AsFloat;
          end;
          *)
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

procedure TDMTablaTemporalFOB.GetCostesEnvasado( const AEmpresa, ACentro, AOrigen, AEnvase, AProducto: string;
  const AFEcha: TDateTime; const AProductoBase: integer; var AEnvasado, ASecciones: real );
var
  iAnyo, iMes, iDia: Word;
  iAnyoEnvase, iMesEnvase: Integer;
  iTipo: Integer;
  APEnvasado, APSecciones, sAux1, sAux2: real;
begin
  DecodeDate( AFecha, iAnyo, iMes, iDia );
  if kmtCostesEnvasado.Locate('empresa_ec;centro_ec;envase_ec;producto_ec;origen_ec;anyo_ec;mes_ec',
                              VarArrayOf([ AEmpresa, ACentro, AEnvase, AProducto, AOrigen, iAnyo, iMes ]), []) then
  begin
    if bAPromedio then
    begin
       AEnvasado := kmtCostesEnvasado.FieldByName('pcoste_ec').AsFloat;
       ASecciones := kmtCostesEnvasado.FieldByName('psecciones_ec').AsFloat;
    end
    else
    begin
       AEnvasado := kmtCostesEnvasado.FieldByName('coste_ec').AsFloat;
       ASecciones := kmtCostesEnvasado.FieldByName('secciones_ec').AsFloat;
    end;
  end
  else
  begin
    iTipo:= CosteEnvaseDirecto( AEmpresa, ACentro, AEnvase, AProducto, iAnyo, iMes, AProductoBase, AEnvasado, ASecciones, APEnvasado, APSecciones, iAnyoEnvase, iMesEnvase );
    if iTipo = -1 then
    begin
      iTipo:= CosteEnvaseindirecto( AEmpresa, ACentro, AEnvase, AProducto, iAnyo, iMes, AProductoBase, AEnvasado, ASecciones,APEnvasado, APSecciones,iAnyoEnvase, iMesEnvase );
    end;

    if ( ACentro <> AOrigen )  and ( AEmpresa = '050' )then
    begin
      CostesSeccionEnvase( AEmpresa, AOrigen, AEnvase,  AProducto, sAux1, sAux2, AProductoBase, iAnyo, iMes );
      ASecciones := ASecciones + sAux1;
      APSecciones := APSecciones + sAux2;
    end;

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
    kmtCostesEnvasado.FieldByName('pcoste_ec').AsFloat:= APEnvasado;
    kmtCostesEnvasado.FieldByName('psecciones_ec').AsFloat:= APSecciones;
    kmtCostesEnvasado.Post;

    if bAPromedio then
    begin
       AEnvasado := APEnvasado;
       ASecciones := APSecciones;
    end;
  end;
end;


function TDMTablaTemporalFOB.FacturasManualesEnvase: boolean;
begin
   with qryFacturasManuales do
  begin
    SQL.Clear;
    SQL.Add(' SELECT cod_empresa_albaran_fd empresa, cod_cliente_fc cliente, ');
    SQL.Add('        (select pais_c from frf_clientes where cliente_c = cod_cliente_fc) pais, ');
    SQL.Add('        cod_dir_sum_fd suministro, ');
    //Comercial
//    SQL.Add('        nvl( ( select cod_comercial_cc from frf_clientes_comercial where cod_empresa_cc = cod_empresa_albaran_fd and cod_cliente_cc = cod_cliente_fc ),''000'') comercial,');
    SQL.Add('       cod_comercial_fd comercial, ');

    SQL.Add('        n_albaran_fd albaran, ');
    SQL.Add('        cod_producto_fd producto, ');
    SQL.Add('        cod_envase_fd envase, ');

    //SQL.Add(' nvl(( select descripcion_lp from frf_linea_productos where linea_producto_lp = linea_producto_e ) ,''SIN ASIGNAR'') linea, ');
    SQL.Add('        nvl( linea_producto_e, ''00'')  linea, ');
    SQL.Add('        periodo_factura_c periodoFact, ');
    SQL.Add('        nvl(agrupa_comercial_e,''SIN AGRUPACION'') agrupacion, ');

    SQL.Add('        cod_centro_albaran_fd centro, ');
    SQL.Add('        fecha_albaran_fd fecha, ');
    SQL.Add('        moneda_fc moneda, ');
    SQL.Add('        categoria_fd categoria, ');
    SQL.Add('        calibre_fd  calibre, ');
    SQL.Add('        0  Transito, ');
    SQL.Add('        centro_origen_fd centro_origen, ');
    SQL.Add('        2 facturado, ');
//    SQL.Add('        0 kilos_producto, ');
    SQL.Add('        GetDescuentosCliente( cod_empresa_albaran_fd, cod_cliente_albaran_fd, cod_centro_albaran_fd, cod_producto_fd, fecha_albaran_fd, 0 ) des_no_facturable, ');
    SQL.Add('        GetGastosCliente( cod_empresa_albaran_fd, cod_cliente_albaran_fd, fecha_albaran_fd, 0 ) gas_no_facturable, ');
    SQL.Add('        sum(nvl(kilos_fd,0)) kilos_producto, ');

    SQL.Add('        round( case when importe_neto_fc = 0 then  1 ');
    SQL.Add('                           else importe_neto_euros_fc/importe_neto_fc end, 5 ) cambio, ');

    SQL.Add('        SUM(  importe_neto_fd ) neto, SUM(  importe_linea_fd ) importe, SUM(  importe_total_descuento_fd ) descuento ');
    {
    SQL.Add('        SUM(  Round( NVL( ');
    SQL.Add('                             case when importe_neto_euros_fc = 0 then 0 ');
    SQL.Add('                                  else importe_neto_fd * importe_neto_fc / importe_neto_euros_fc ');
    SQL.Add('                             end ');
    SQL.Add('                                  ,0), 2) ) neto ');
    }
    SQL.Add('from tfacturas_cab');
    SQL.Add('     join tfacturas_det on cod_factura_fc = cod_factura_fd ');
    SQL.Add('     left join frf_envases on cod_envase_fd = envase_E  ');
    SQL.Add('     left join frf_clientes on cliente_c = cod_cliente_fc ');

    if sAEmpresa = 'BAG' then
      SQL.Add('where substr(cod_empresa_albaran_fd,1,1) = ''F'' ')
    else
    if sAEmpresa = 'SAT' then
      SQL.Add(' WHERE (cod_empresa_albaran_fd = ''050'' or cod_empresa_albaran_fd = ''080'') ')
    else
      SQL.Add(' WHERE cod_empresa_albaran_fd = :empresa ');


    (*PARCHE*)//Fruta dev, parche pedido por jorge
    SQL.Add(' AND  cod_factura_fc <> ''ACP-05017-00458'' ');

    SQL.Add(' and automatica_fc = 0 and anulacion_fc = 0 ');

    if bAFechaSalida then
      SQL.Add('and fecha_albaran_fd between :fechaini and :fechafin ')
    else
      SQL.Add('and fecha_factura_fc between :fechaini and :fechafin ');
    if sAALbaran <> '' then
      SQL.Add('and n_albaran_fd = :albaran ');

    if sAProducto <> '' then
    begin
      if ( Copy( sAProducto,1,1) <> '+' ) and ( Copy( sAProducto,1,1) <> '-' ) then
      begin
        SQL.Add(' AND (cod_producto_fd =  ' + QuotedStr( sAproducto) + ' )  ');
      end
      else
      begin
        if Copy( sAProducto,1,1) = '+' then
          SQL.Add(' AND (cod_producto_fd in  ' + Copy( sAProducto,2,Length(sAProducto)-1) +  ' )  ')
        else
        if Copy( sAProducto,1,1) = '-' then
          SQL.Add(' AND (cod_producto_fd not in  ' + Copy( sAProducto,2,Length(sAProducto)-1) +  ' )  ')
      end;
    end;


      if bANoP4H then
      begin
        SQL.Add(' AND cod_empresa_albaran_fd <> ''F18'' ');
      end;

      if iAEsHortaliza  = 1 then
      begin

        SQL.Add(' AND exists (  ');
        SQL.Add('              select * from frf_productos ');
        SQL.Add('              where producto_p = cod_producto_fd ');
        SQL.Add('              and estomate_p = ''S'' ) ');
      end
      else
      if iAEsHortaliza  = 2 then
      begin
        SQL.Add(' AND exists (  ');
        SQL.Add('              select * from frf_productos ');
        SQL.Add('              where producto_p = cod_producto_fd ');
        SQL.Add('              and eshortaliza_p = ''S'' ) ');
      end
      else
      if iAEsHortaliza  = 3 then
      begin
        SQL.Add(' AND exists (  ');
        SQL.Add('              select * from frf_productos ');
        SQL.Add('              where producto_p = cod_producto_fd ');
        SQL.Add('              and eshortaliza_p = ''N'' ) ');
      end;

    //if sACategoria <> '' then
    //  SQL.Add('and categoria_fd = :categoria ');
    if sACategoria <> '' then
    begin
      if Pos( ',', sACategoria ) > 0 then
      begin
        SQL.Add(' AND   categoria_fd in (' + ListaDeCadenas( sACategoria ) + ')');
      end
      else
      begin
        SQL.Add(' AND   categoria_fd = ' + QuotedStr( Trim( sACategoria ) ) );
      end;
    end;

    if sAEnvase <> '' then
      SQL.Add('and cod_envase_fd = :envase ');

    if sACentroOrigen <> '' then
      SQL.Add('and centro_origen_fd = :centroorigen ');
    if sACentroSalida <> '' then
      SQL.Add('and cod_centro_albaran_fd = :centrosalida ');


    //SQL.Add('and importe_neto_fd <> 0 ');


    if sACliente <> '' then
      SQL.Add('and cod_cliente_fc = :cliente ');

    if sATipoCliente <> '' then
    begin
      if bAExcluirTipoCliente then
      begin
        SQL.Add(' and exists (select * from frf_clientes where cliente_c = cod_cliente_fc and tipo_cliente_c <> :tipocliente) ');
      end
      else
      begin
        SQL.Add(' and exists (select * from frf_clientes where cliente_c = cod_cliente_fc and tipo_cliente_c = :tipocliente) ');
      end;
    end;
    if bAExcluirInterplanta then
    begin
      SQL.Add(' and exists (select * from frf_clientes where cliente_c = cod_cliente_fc and tipo_cliente_c <> ''IP'') ');
    end;
    if sAPais <> '' then
    begin
      if length(sAPais) = 2 then
      begin
        SQL.Add('and ( select pais_c from frf_clientes where cliente_c = cod_cliente_fc ) = :pais ');
      end
      else
      begin
        if UPPERCASE(sAPais) = 'NACIONAL' then
        begin
          SQL.Add('and ( select pais_c from frf_clientes where cliente_c = cod_cliente_fc ) = ''ES'' ');
        end
        else
          if UPPERCASE(sAPais) = 'EXTRANJERO' then
          begin
            SQL.Add('and ( select pais_c from frf_clientes where cliente_c = cod_cliente_fc ) <> ''ES'' ');
          end;
      end ;
    end;

    SQL.Add(' group by empresa, cliente, pais, suministro, comercial, albaran, producto, envase, linea, periodoFact, agrupacion, centro,');
    SQL.Add('          fecha, moneda, categoria, calibre, transito, centro_origen, facturado, cambio, des_no_facturable, gas_no_facturable');
    SQL.Add(' ORDER BY cliente, empresa, centro, albaran, fecha, moneda, envase ');
    if ( sAEmpresa <> 'SAT' ) and ( sAEmpresa <> 'BAG' ) then
      ParamByName('empresa').AsString := sAEmpresa;

    ParamByName('fechaini').AsString := sAFechaDesde;
    ParamByName('fechafin').AsString := sAFEchaHasta;
    if sAALbaran <> '' then
      ParamByName('albaran').AsString := sAALbaran;
    if sACentroOrigen <> '' then
      ParamByName('centroorigen').AsString := sACentroOrigen;
    if sACentroSalida <> '' then
      ParamByName('centrosalida').AsString := sACentroSalida;
    if sACliente <> '' then
      ParamByName('cliente').AsString := sACliente;
    if sATipoCliente <> '' then
      ParamByName('tipocliente').AsString := sATipoCliente;
    //if sACategoria <> '' then
    //  ParamByName('categoria').AsString := sACategoria;
    if sAEnvase <> '' then
      ParamByName('envase').AsString := sAEnvase;
    if length(sAPais) = 2 then
    begin
      ParamByName('pais').AsString := sAPais;
    end;

    //SQL.SaveToFile('c:\pepe2.sql');
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

procedure TDMTablaTemporalFOB.AltaLineaManualListadoFOB;
var bEsDevolucion : boolean;
begin
   bEsDevolucion := false;
  //Buscamos si es un albaran de devolución
  with qryAux do
  begin
    SQL.Clear;
    SQL.Add(' select es_transito_sc ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');

    ParamByName('empresa').AsString:= qryFacturasManuales.FieldByName('empresa').AsString;
    ParamByName('centro').AsString:= qryFacturasManuales.FieldByName('centro').AsString;
    ParamByName('albaran').AsString:= qryFacturasManuales.FieldByName('albaran').AsString;
    ParamByName('fecha').AsDate:= qryFacturasManuales.FieldByName('fecha').AsDateTime;
    Open;
    if qryAux.Fieldbyname('es_transito_sc').AsString = '2' then   // Es devolucion
      bEsDevolucion := True
    else
      bEsDevolucion := False;

    Close;
  end;

  ClientDataSet.Insert;
  strngfldClientDataSetempresa.AsString:= qryFacturasManuales.FieldByName('empresa').AsString;
  ClientDataSetcentro.AsString:= qryFacturasManuales.FieldByName('centro').AsString;
  ClientDataSetcentro_origen.AsString:= qryFacturasManuales.FieldByName('centro_origen').AsString;
  ClientDataSetproducto.AsString:= qryFacturasManuales.FieldByName('producto').AsString;
  ClientDataSetcategoria.AsString:= qryFacturasManuales.FieldByName('categoria').AsString;
  ClientDataSetcalibre.AsString:= qryFacturasManuales.FieldByName('calibre').AsString;
  strngfldClientDataSetcomercial.AsString:= qryFacturasManuales.FieldByName('comercial').AsString;
  ClientDataSetcliente.AsString:= qryFacturasManuales.FieldByName('cliente').AsString;
  strngfldClientDataSetsuministro.AsString:= qryFacturasManuales.FieldByName('suministro').AsString;
  ClientDataSetmoneda.AsString:= qryFacturasManuales.FieldByName('moneda').AsString;
  ClientDataSetfecha.AsDateTime:= qryFacturasManuales.FieldByName('fecha').AsDateTime;
  ClientDataSetalbaran.AsString:= qryFacturasManuales.FieldByName('albaran').AsString;
  ClientDataSetfecha_albaran.AsDateTime:= qryFacturasManuales.FieldByName('fecha').AsDateTime;
  ClientDataSetpais.AsString:= qryFacturasManuales.FieldByName('pais').AsString;

  if ClientDataSetmoneda.AsString <> 'EUR' then
    ClientDataSetcambio.AsFloat:= qryFacturasManuales.FieldByName('cambio').AsFloat
  else
    ClientDataSetcambio.AsFloat:= 1;
  if qryFacturasManuales.FieldByName('neto').AsFloat < 0 then
    ClientDataSetfacturado.AsInteger:= 2
  else
    ClientDataSetfacturado.AsInteger:= 1;

  ClientDataSetenvase.AsString:= qryFacturasManuales.FieldByName('envase').AsString;
  ClientDataSetlinea.AsString:= qryFacturasManuales.FieldByName('linea').AsString;
  strngfldClientDataSetperiodoFact.AsString:= qryFacturasManuales.FieldByName('periodoFact').AsString;
  ClientDataSetAgrupacion.AsString:= qryFacturasManuales.FieldByName('agrupacion').AsString;

  ClientDataSetkilos_producto.AsFloat:= qryFacturasManuales.FieldByName('kilos_producto').AsFloat;
  fltfldClientDataSetunidades_producto.AsFloat:= 0;
  ClientDataSetpalets_producto.AsFloat:= 0;
  ClientDataSetcajas_producto.AsFloat:= 0;
  ClientDataSetkilos_transito.AsFloat:= 0;
  ClientDataSetkilos_total.AsFloat:= 0;

    //Moneda del albaran, pasar a euros
  ClientDataSetimporte.AsFloat:= qryFacturasManuales.FieldByName('importe').AsFloat;
  if bEsDevolucion or (not bAComisiones) then
    ClientDataSetcomision.AsFloat:= 0
  else
    ClientDataSetcomision.AsFloat:= qryFacturasManuales.FieldByName('descuento').AsFloat;
  if bEsDevolucion or (not bADescuentos) then
    ClientDataSetdescuento.AsFloat:= 0
  else
    ClientDataSetdescuento.AsFloat := qryFacturasManuales.FieldByName('importe').AsFloat * qryFacturasManuales.FieldByName('des_no_facturable').AsFloat / 100;
  ClientDataSetgasto_comun.AsFloat:= 0;
  fltfldClientDataSetgasto_fac.AsFloat:= 0;
  if bEsDevolucion or (not bAGastosFijos) then
    fltfldClientDataSetgasto_no_fac.AsFloat:= 0
  else
    fltfldClientDataSetgasto_no_fac.AsFloat:= qryFacturasManuales.FieldByName('importe').AsFloat * qryFacturasManuales.FieldByName('gas_no_facturable').AsFloat / 100;
  ClientDataSettransito.AsFloat:= 0;
  ClientDataSetgasto_transito.AsFloat:= 0;
  fltfldClientDataSetcoste_envase.AsFloat:= 0;
  fltfldClientDataSetcoste_seccion.AsFloat:= 0;
  ClientDataSetcoste_envasado.AsFloat:= 0;
  fltfldClientDataSetneto.AsFloat:= qryFacturasManuales.FieldByName('neto').AsFloat;
  ClientDataSet.Post;
end;


function TDMTablaTemporalFOB.NuevoGastoTransitosSAT( const AMes: string; const AFechaIni, AFechaFin: Real ): Real;
var
  rImporte, rKilosSAT, sKilosBAG: real;
begin
  with qryGastosTransitosSAT do
  begin
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    ParamByName('producto').AsString:= ProductoBagToSat( ClientDataSet.FieldByName('producto').AsString );
    Open;
    rImporte:= FieldByName('importe').AsFloat;
    Close;
  end;

  with qryKilosTransitosSAT do
  begin
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    ParamByName('producto').AsString:= ProductoBagToSat( ClientDataSet.FieldByName('producto').AsString );
    Open;
    rKilosSAT:= FieldByName('kilos').AsFloat;
    Close;
  end;

  with qryTotalesBAG do
  begin
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    ParamByName('producto').AsString:= ClientDataSet.FieldByName('producto').AsString;
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
  kmtTransitosSAT_BAG.FieldByName('producto').AsString:= ClientDataSet.FieldByName('producto').AsString;
  kmtTransitosSAT_BAG.FieldByName('coste').AsFloat:= Result;
  kmtTransitosSAT_BAG.Post;
end;

(*
function TDMTablaTemporalFOB.GastosTransitosSAT: Real;
var
  sMes: string;
  dPrimero, dUltimo: TDateTime;
begin
  if ( Copy( ClientDataSet.FieldByName('empresa').AsString, 1, 1 ) = 'F' ) and
     ( ClientDataSet.FieldByName('empresa').AsString <> 'F23' ) then
  begin
    sMes:= AnyoMesEx( ClientDataSet.FieldByName('fecha').AsDateTime, dPrimero, dUltimo );
    if kmtTransitosSAT_BAG.Locate( 'mes;producto',
         VarArrayOf( [sMes, ClientDataSet.FieldByName('producto').AsString ]), [] ) then
    begin
      Result:= bRoundTo( ClientDataSet.FieldByName('kilos_producto').AsFloat * kmtTransitosSAT_BAG.FieldByName('coste').AsFloat, 2) ;
    end
    else
    begin
      Result:= bRoundTo( ClientDataSet.FieldByName('kilos_producto').AsFloat * NuevoGastoTransitosSAT( sMes, dPrimero, dUltimo ), 2);
    end;
  end
  else
  begin
    Result:= 0;
  end;
end;
*)

(***************************************************************************************************************************
****************************************************************************************************************************)
procedure IncializarResultadosFOB( var VResultadosFob: TResultadosFob );
begin
  with VResultadosFob do
  begin
    rPeso:= 0;
    rNeto:= 0;
    rDescuento:= 0;
    rGastos:= 0;
    rGastosFac:= 0;
    rGastosNoFac := 0;
    rGastosTran:= 0;
    rCosteEnvase:= 0;
    rCosteSecciones:= 0;
    rPesoPrimera:= 0;
    rNetoPrimera:= 0;
    rDescuentoPrimera:= 0;
    rGastosPrimera:= 0;
    rGastosPrimeraFac:= 0;
    rGastosPrimeraNoFac:= 0;
    rGastosPrimeraTran:= 0;
    rEnvasePrimera:= 0;
    rSeccionesPrimera:= 0;
    rPesoSegunda:= 0;
    rNetoSegunda:= 0;
    rDescuentoSegunda:= 0;
    rGastosSegunda:= 0;
    rGastosSegundaFac:= 0;
    rGastosSegundaNoFac:= 0;
    rGastosSegundaTran:= 0;
    rEnvaseSegunda:= 0;
    rSeccionesSegunda:= 0;
    rPesoTercera:= 0;
    rNetoTercera:= 0;
    rDescuentoTercera:= 0;
    rGastosTercera:= 0;
    rGastosTerceraFac:= 0;
    rGastosTerceraNoFac:= 0;
    rGastosTerceraTran:= 0;
    rEnvaseTercera:= 0;
    rSeccionesTercera:= 0;
    rPesoDestrio:= 0;
    rNetoDestrio:= 0;
    rDescuentoDestrio:= 0;
    rGastosDestrio:= 0;
    rGastosDestrioFac:= 0;
    rGastosDestrioNoFac:= 0;
    rGastosDestrioTran:= 0;
    rEnvaseDestrio:= 0;
    rSeccionesDestrio:= 0;
  end;
end;

function TDMTablaTemporalFOB.ImportesFOB( var VPeso, VNeto, VDescuento, VGastos, VMaterial, VGeneral: Real;
                          var VResultadosFob: TResultadosFob): boolean;
begin
   IncializarResultadosFOB( VResultadosFob );
   Result:= ObtenerDatosComunFob(false);

  if Result then
  begin
     ClientDataSet.First;
     while not ClientDataSet.Eof do
     begin
       VResultadosFob.rPeso:= VResultadosFob.rPeso + ClientDataSetkilos_producto.AsFloat;
       VResultadosFob.rNeto:= VResultadosFob.rNeto + ClientDataSetimporte.AsFloat;
       VResultadosFob.rDescuento:= VResultadosFob.rDescuento + ClientDataSetdescuento.AsFloat + ClientDataSetcomision.AsFloat;
       VResultadosFob.rGastos:= VResultadosFob.rGastos + ClientDataSetgasto_comun.AsFloat + ClientDataSetgasto_transito.AsFloat;
       VResultadosFob.rCosteEnvase:= VResultadosFob.rCosteEnvase + fltfldClientDataSetcoste_envase.AsFloat;
       VResultadosFob.rCosteSecciones:= VResultadosFob.rCosteSecciones + fltfldClientDataSetcoste_seccion.AsFloat;
       VResultadosFob.rGastosFac:= VResultadosFob.rGastosFac + fltfldClientDataSetgasto_fac.AsFloat;
       VResultadosFob.rGastosNoFac:= VResultadosFob.rGastosNoFac + fltfldClientDataSetgasto_no_fac.AsFloat;
       VResultadosFob.rGastosTran:= VResultadosFob.rGastosTran + ClientDataSetgasto_transito.AsFloat;


       if ClientDataSet.FieldByName('categoria').AsString = '1' then
       begin
         //Primera
         VResultadosFob.rPesoPrimera:= VResultadosFob.rPesoPrimera + ClientDataSetkilos_producto.AsFloat;
         VResultadosFob.rNetoPrimera:= VResultadosFob.rNetoPrimera + ClientDataSetimporte.AsFloat;
         VResultadosFob.rDescuentoPrimera:= VResultadosFob.rDescuentoPrimera + ClientDataSetdescuento.AsFloat + ClientDataSetcomision.AsFloat;
         VResultadosFob.rGastosPrimera:= VResultadosFob.rGastosPrimera + ClientDataSetgasto_comun.AsFloat + ClientDataSetgasto_transito.AsFloat;
         VResultadosFob.rEnvasePrimera:= VResultadosFob.rEnvasePrimera + fltfldClientDataSetcoste_envase.AsFloat;
         VResultadosFob.rSeccionesPrimera:= VResultadosFob.rSeccionesPrimera + fltfldClientDataSetcoste_seccion.AsFloat;
         VResultadosFob.rGastosPrimeraFac:= VResultadosFob.rGastosPrimeraFac + fltfldClientDataSetgasto_fac.AsFloat;
         VResultadosFob.rGastosPrimeraNoFac:= VResultadosFob.rGastosPrimeraNoFac + fltfldClientDataSetgasto_no_fac.AsFloat;
         VResultadosFob.rGastosPrimeraTran:= VResultadosFob.rGastosPrimeraTran + ClientDataSetgasto_transito.AsFloat;
       end
       else
       if ClientDataSet.FieldByName('categoria').AsString = '2' then
       begin
         //Segunda
         VResultadosFob.rPesoSegunda:= VResultadosFob.rPesoSegunda + ClientDataSetkilos_producto.AsFloat;
         VResultadosFob.rNetoSegunda:= VResultadosFob.rNetoSegunda + ClientDataSetimporte.AsFloat;
         VResultadosFob.rDescuentoSegunda:= VResultadosFob.rDescuentoSegunda + ClientDataSetdescuento.AsFloat + ClientDataSetcomision.AsFloat;
         VResultadosFob.rGastosSegunda:= VResultadosFob.rGastosSegunda + ClientDataSetgasto_comun.AsFloat + ClientDataSetgasto_transito.AsFloat;
         VResultadosFob.rEnvaseSegunda:= VResultadosFob.rEnvaseSegunda + fltfldClientDataSetcoste_envase.AsFloat;
         VResultadosFob.rSeccionesSegunda:= VResultadosFob.rSeccionesSegunda + fltfldClientDataSetcoste_seccion.AsFloat;
         VResultadosFob.rGastosSegundaFac:= VResultadosFob.rGastosSegundaFac + fltfldClientDataSetgasto_fac.AsFloat;
         VResultadosFob.rGastosSegundaNoFac:= VResultadosFob.rGastosSegundaNoFac + fltfldClientDataSetgasto_no_fac.AsFloat;
         VResultadosFob.rGastosSegundaTran:= VResultadosFob.rGastosSegundaTran + ClientDataSetgasto_transito.AsFloat;
       end
       else
       if ClientDataSet.FieldByName('categoria').AsString = '3' then
       begin
         //Tercera
         VResultadosFob.rPesoTercera:= VResultadosFob.rPesoTercera + ClientDataSetkilos_producto.AsFloat;
         VResultadosFob.rNetoTercera:= VResultadosFob.rNetoTercera + ClientDataSetimporte.AsFloat;
         VResultadosFob.rDescuentoTercera:= VResultadosFob.rDescuentoTercera + ClientDataSetdescuento.AsFloat + ClientDataSetcomision.AsFloat;
         VResultadosFob.rGastosTercera:= VResultadosFob.rGastosTercera + ClientDataSetgasto_comun.AsFloat + ClientDataSetgasto_transito.AsFloat;
         VResultadosFob.rEnvaseTercera:= VResultadosFob.rEnvaseTercera + fltfldClientDataSetcoste_envase.AsFloat;
         VResultadosFob.rSeccionesTercera:= VResultadosFob.rSeccionesTercera + fltfldClientDataSetcoste_seccion.AsFloat;
         VResultadosFob.rGastosTerceraFac:= VResultadosFob.rGastosTerceraFac + fltfldClientDataSetgasto_fac.AsFloat;
         VResultadosFob.rGastosTerceraNoFac:= VResultadosFob.rGastosTerceraNoFac + fltfldClientDataSetgasto_no_fac.AsFloat;
         VResultadosFob.rGastosTerceraTran:= VResultadosFob.rGastosTerceraTran + ClientDataSetgasto_transito.AsFloat;
       end
       else
       begin
         //Destrio
         VResultadosFob.rPesoDestrio:= VResultadosFob.rPesoDestrio + ClientDataSetkilos_producto.AsFloat;
         VResultadosFob.rNetoDestrio:= VResultadosFob.rNetoDestrio + ClientDataSetimporte.AsFloat;
         VResultadosFob.rDescuentoDestrio:= VResultadosFob.rDescuentoDestrio + ClientDataSetdescuento.AsFloat + ClientDataSetcomision.AsFloat;
         VResultadosFob.rGastosDestrio:= VResultadosFob.rGastosDestrio + ClientDataSetgasto_comun.AsFloat + ClientDataSetgasto_transito.AsFloat;
         VResultadosFob.rEnvaseDestrio:= VResultadosFob.rEnvaseDestrio + fltfldClientDataSetcoste_envase.AsFloat;
         VResultadosFob.rSeccionesDestrio:= VResultadosFob.rSeccionesDestrio + fltfldClientDataSetcoste_seccion.AsFloat;
         VResultadosFob.rGastosDestrioFac:= VResultadosFob.rGastosDestrioFac + fltfldClientDataSetgasto_fac.AsFloat;
         VResultadosFob.rGastosDestrioNoFac:= VResultadosFob.rGastosDestrioNoFac + fltfldClientDataSetgasto_no_fac.AsFloat;
         VResultadosFob.rGastosDestrioTran:= VResultadosFob.rGastosDestrioTran + ClientDataSetgasto_transito.AsFloat;
       end;
       ClientDataSet.Next;
     end;
     ClientDataSet.First;

    VPeso:= VResultadosFob.rPeso;
    VNeto:= VResultadosFob.rNeto;
    VDescuento:= VResultadosFob.rDescuento;
    VGastos:= VResultadosFob.rGastos;
    VMaterial:= VResultadosFob.rCosteEnvase;
    VGeneral:= VResultadosFob.rCosteSecciones;
  end
  else
  begin
    VPeso:= 0;
    VNeto:= 0;
    VDescuento:= 0;
    VGastos:= 0;
    VMaterial:= 0;
    VGeneral:= 0;
  end;
end;

end.
