unit CDBalanceComprasProveedor;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable, DBClient, Provider, MidasLib;

type
  TDBalanceComprasProveedor = class(TDataModule)
    QGastosEntregas: TQuery;
    QSalidasEntregas: TQuery;
    QEntregas: TQuery;
    Query: TQuery;
    DataSetProvider: TDataSetProvider;
    ClientDataSet: TClientDataSet;
    ClientDataSetcliente: TStringField;
    ClientDataSetproducto: TStringField;
    ClientDataSetalbaran: TIntegerField;
    ClientDataSetenvase: TStringField;
    ClientDataSetcentro: TStringField;
    ClientDataSetfecha: TDateField;
    ClientDataSetmoneda: TStringField;
    ClientDataSetcambio: TFloatField;
    ClientDataSetcategoria: TStringField;
    ClientDataSetcalibre: TStringField;
    ClientDataSetkilos_producto: TFloatField;
    ClientDataSetkilos_transito: TFloatField;
    ClientDataSetkilos_total: TFloatField;
    ClientDataSetneto: TFloatField;
    ClientDataSetgasto_comun: TFloatField;
    ClientDataSetgasto_transito: TFloatField;
    ClientDataSetcoste_envase: TFloatField;
    ClientDataSettransito: TIntegerField;
    ClientDataSetcoste_envasado: TFloatField;
    ClientDataSetcentro_origen: TStringField;
    ClientDataSetcoste_seccion: TFloatField;
    QCambio: TQuery;
    QKilos: TQuery;
    QGastosGenerales: TQuery;
    QProductoBase: TQuery;
    QCosteEnvase: TQuery;
    QGastosProducto: TQuery;
    mtSalidasValoradas: TkbmMemTable;
    DSEntregas: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QEntregasAfterOpen(DataSet: TDataSet);
    procedure QEntregasBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    sCentroSalida: string;

    //procedure SQLEntregas;
    procedure SQLEntregasPlus( const AProveedor: string );
    procedure RellenaDatosFaltantes( const AEmpresa: string; const ACategoria: string;
                                     const AGasto, ANo036, ACosteEnvase, ASecciones: boolean );
(*
    function  GetCambio( const AMoneda: String; const AFecha: TDateTime ): Real;
*)
    procedure GetKilosAlbaran(var AKilosTotal, AKilosTransito, AKilosProdTotal, AKilosProdTransito: Real;
      const AEmpresa, ACentro: string; const AAlbaran: Integer; const AFecha: TDateTime; const AProducto: string);
    procedure GetGastosAlbaran(var AGastosGeneralComun, AGastosGeneralTransito, AGastosProductoComun, AGastosProductoTransito: Real;
      const AEmpresa, ACentro: string; const AAlbaran: Integer;
      const AFecha: TDateTime; const AProducto: string );
    procedure GetCostesEnvasado( const AEmpresa, ACentro, AEnvase: string;
                                 const AFEcha: TDateTime; const AProductoBase: integer;
                                 var AEnvasado, ASecciones: real );
    procedure PrepareQGastos( const ANo036: boolean );

    //procedure AltaLineaListadoFOB( const ASemana, ACategoria: string );
    //procedure ModLineaListadoFOB( const ASemana: string );

    procedure ValorarSalidas;
    function  GetPrecioFob: Real;
  public
    { Public declarations }
    function  ObtenerDatos(const AEmpresa, ACentroOrigen, ACentroDestino, AFechaDesde, AFEchaHasta,
                                 AEnvase, ACliente, AProducto, APais, ACategoria: string;
                           const AClienteIgual, ADescuento, AGasto, ANo036, ACosteEnvase, ACosteSecciones, AAlb6Digitos, AAlbValor, AFacturado: boolean): boolean;

    //procedure ListadoFOB;
  end;

  //function  ObtenerDatos( const AOwner: TComponent;  const Empresa, ACentro, AEntrega: String ): boolean;
  function  ObtenerDatosPlus( const AOwner: TComponent;  const Empresa, AProveedor: String; const AFechaIni, AFechaFin: TDateTime ): boolean;
  procedure CerrarDatos;

var
  DBalanceComprasProveedor: TDBalanceComprasProveedor;

implementation

{$R *.dfm}

uses bMath, Variants, UDMCambioMoneda, UDMconfig, bTimeUtils;

procedure TDBalanceComprasProveedor.QEntregasAfterOpen(DataSet: TDataSet);
begin
  QGastosEntregas.Open;
  QSalidasEntregas.Open;
end;

procedure TDBalanceComprasProveedor.QEntregasBeforeClose(
  DataSet: TDataSet);
begin
  QGastosEntregas.Close;
  QSalidasEntregas.Close;
end;

(*
function ObtenerDatos( const AOwner: TComponent;  const Empresa, ACentro, AEntrega: String ): boolean;
begin
  DBalanceComprasProveedor:= TDBalanceComprasProveedor.Create( AOwner );
  with DBalanceComprasProveedor do
  begin
    sCentroSalida:= ACentro;
    SQLEntregas;
    QEntregas.ParamByName('entrega').AsString:= AEntrega;
    QEntregas.Open;
    result:= not QEntregas.IsEmpty;
    if result then
    begin
      mtSalidasValoradas.Open;
      ValorarSalidas;
      mtSalidasValoradas.SortOn('entrega;empresa;cliente;producto;envase;fecha',[]);
    end;
  end;
end;
*)

function ObtenerDatosPlus( const AOwner: TComponent;  const Empresa, AProveedor: String; const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  DBalanceComprasProveedor:= TDBalanceComprasProveedor.Create( AOwner );
  with DBalanceComprasProveedor do
  begin
    SQLEntregasPlus( AProveedor );
    QEntregas.ParamByName('empresa').AsString:= Empresa;
    if Trim( AProveedor ) <> '' then
     QEntregas.ParamByName('proveedor').AsString:= AProveedor;
    QEntregas.ParamByName('fechaini').AsDate:= AFechaIni;
    QEntregas.ParamByName('fechafin').AsDate:= AFechaFin;
    QEntregas.Open;
    result:= not QEntregas.IsEmpty;
    if result then
    begin
      mtSalidasValoradas.Open;
      while not QEntregas.Eof do
      begin
        ValorarSalidas;
        QEntregas.Next;
      end;
      mtSalidasValoradas.SortOn('entrega;empresa;cliente;producto;envase;fecha',[]);
      QEntregas.First;
    end;
  end;
end;

procedure CerrarDatos;
begin
  DBalanceComprasProveedor.QEntregas.Close;
  DBalanceComprasProveedor.mtSalidasValoradas.Close;
  FreeAndNil( DBalanceComprasProveedor );
end;

procedure TDBalanceComprasProveedor.ValorarSalidas;
begin
  while not QSalidasEntregas.Eof do
  begin
    with mtSalidasValoradas do
    begin
      Insert;
      FieldByName('entrega').AsString:= QSalidasEntregas.FieldByName('codigo').AsString;
      FieldByName('empresa').AsString:= QSalidasEntregas.FieldByName('empresa').AsString;
      FieldByName('cliente').AsString:= QSalidasEntregas.FieldByName('cliente').AsString;
      FieldByName('envase').AsString:= QSalidasEntregas.FieldByName('envase').AsString;
      FieldByName('producto').AsString:= QSalidasEntregas.FieldByName('producto').AsString;
      FieldByName('fecha').AsDateTime:= QSalidasEntregas.FieldByName('fecha').AsDateTime;
      FieldByName('porcentaje').AsFloat:= QSalidasEntregas.FieldByName('porcentaje').AsFloat;
      FieldByName('kilos').AsFloat:= BRoundTO( ( QEntregas.FieldByName('kilos_entrega').AsFloat * FieldByName('porcentaje').AsFloat ) / 100, 2 );
      FieldByName('precio').AsFloat:= GetPrecioFob;
      FieldByName('importe').AsFloat:= BRoundTO( FieldByName('kilos').AsFloat *  FieldByName('precio').AsFloat, 2);
      Post;
    end;
    QSalidasEntregas.Next;
  end;
end;

function TDBalanceComprasProveedor.GetPrecioFob: Real;
var
  rKilos, rImporte: real;
begin
  if ( QSalidasEntregas.FieldByName('envase').AsString = 'VERDE' ) or
     ( QSalidasEntregas.FieldByName('envase').AsString = 'DESTRIO' ) then
  begin
    result:= 0;
  end
  else
  if ObtenerDatos( QSalidasEntregas.FieldByName('empresa').AsString, sCentroSalida, sCentroSalida,
                   QSalidasEntregas.FieldByName('fecha').AsString,
                   QSalidasEntregas.FieldByName('fecha').AsString,
                   QSalidasEntregas.FieldByName('envase').AsString,
                   QSalidasEntregas.FieldByName('cliente').AsString,
                   QSalidasEntregas.FieldByName('producto').AsString,
                   '', '', True, True, True, False, True, True, False, True, False ) then
  begin
    rKilos:= 0;
    rImporte:= 0;
    with ClientDataSet do
    begin
      First;
      while not EOF do
      begin
        rKilos:= rKilos + ClientDataSet.FieldByName('kilos_producto').AsFloat;
        //Moneda del albaran, pasar a euros
        rImporte:= rImporte + bRoundTo(ClientDataSet.FieldByName('neto').AsFloat * ClientDataSet.FieldByName('cambio').AsFloat, 2 );
        rImporte:= rImporte - bRoundTo( ( ClientDataSet.FieldByName('gasto_comun').AsFloat + ClientDataSet.FieldByName('gasto_transito').AsFloat )
                                             * ClientDataSet.FieldByName('cambio').AsFloat, 2 );
        //En euros
        rImporte:= rImporte - ( ClientDataSet.FieldByName('coste_envase').AsFloat + ClientDataSet.FieldByName('coste_seccion').AsFloat );

        Next;
      end;
      Close;
    end;
    if rKilos > 0 then
    begin
      result:= bRoundTo( rImporte / rKilos, 3 );
    end
    else
    begin
      result:= 0;
    end;
  end
  else
  begin
    result:= 0;
  end;
end;

(*
procedure TDBalanceComprasProveedor.SQLEntregas;
begin
  with QEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ec empresa, codigo_ec entrega, fecha_llegada_ec fecha, sum(kilos_el) kilos_entrega ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l  ');
    SQL.Add(' where codigo_ec = :entrega  ');
    SQL.Add(' and codigo_el = :entrega ');
    SQL.Add(' group by 1,2,3 ');
  end;
end;
*)

procedure TDBalanceComprasProveedor.SQLEntregasPlus( const AProveedor: string );
begin
  with QEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ec empresa, proveedor_ec proveedor, codigo_ec entrega, fecha_llegada_ec fecha, sum(kilos_el) kilos_entrega ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l  ');
    SQL.Add(' where empresa_ec = :empresa  ');
    if Trim( AProveedor ) <> '' then
      SQL.Add(' and proveedor_ec = :proveedor  ');
    SQL.Add(' and fecha_llegada_ec between :fechaini and :fechafin  ');
    SQL.Add(' and codigo_el = codigo_ec ');
    SQL.Add(' group by 1,2,3,4 ');
    SQL.Add(' order by 1,2,3 ');
  end;
end;

procedure TDBalanceComprasProveedor.DataModuleCreate(Sender: TObject);
begin
  with QGastosEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select producto_ge, tipo_ge, ');
    SQL.Add('        (select descripcion_tg from frf_tipo_gastos where tipo_tg = tipo_ge ) des_gasto, ');
    SQL.Add('        ref_fac_ge, fecha_fac_ge, importe_ge ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :entrega ');
    SQL.Add(' order by producto_ge, tipo_ge ');
  end;

  with QSalidasEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec codigo, empresa_ec empresa, ''00V'' cliente, '''' producto, ''VERDE'' envase, fecha_llegada_ec fecha, tomate_verde_ec porcentaje ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where codigo_ec = :entrega ');
    SQL.Add(' union ');
    SQL.Add(' select codigo_ec, empresa_ec, ''00D'', '''' producto, ''DESTRIO'', fecha_llegada_ec, destrio_ec ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where codigo_ec = :entrega ');
    SQL.Add(' union ');
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_calidad ');
    SQL.Add(' where codigo_eca = :entrega ');
    SQL.Add(' order by cliente, envase ');
  end;

  mtSalidasValoradas.FieldDefs.Clear;
  mtSalidasValoradas.FieldDefs.Add('entrega', ftString, 12, False);
  mtSalidasValoradas.FieldDefs.Add('empresa', ftString, 3, False);
  mtSalidasValoradas.FieldDefs.Add('cliente', ftString, 3, False);
  mtSalidasValoradas.FieldDefs.Add('producto', ftString, 3, False);
  mtSalidasValoradas.FieldDefs.Add('envase', ftString, 8, False);
  mtSalidasValoradas.FieldDefs.Add('fecha', ftDate, 0, False);
  mtSalidasValoradas.FieldDefs.Add('porcentaje', ftFloat, 0, False);
  mtSalidasValoradas.FieldDefs.Add('kilos', ftFloat, 0, False);
  mtSalidasValoradas.FieldDefs.Add('precio', ftFloat, 0, False);
  mtSalidasValoradas.FieldDefs.Add('importe', ftFloat, 0, False);

  mtSalidasValoradas.IndexFieldNames:= 'entrega;empresa;cliente;producto;envase;fecha';
  mtSalidasValoradas.CreateTable;

  //
  // PRECIOS FOB
  //

  with QProductoBase do
  begin
    SQL.Clear;
    SQL.Add(' select producto_base_p ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where empresa_p = :empresa ');
    SQL.Add(' and producto_p = :producto ');
    Prepare;
  end;

  with QCosteEnvase do
  begin
    SQL.Clear;
    SQL.Add('select first 1 anyo_ec, mes_ec, ( material_ec + coste_ec ) coste_ec, secciones_ec ');
    SQL.Add('from frf_env_costes ');
    SQL.Add('where empresa_ec = :empresa ');
    SQL.Add('and centro_ec = :centro ');
    SQL.Add('and envase_ec = :envase ');
    SQL.Add('and producto_base_ec = :producto ');
    SQL.Add('and ( ( anyo_ec = :anyo and mes_ec <= :mes ) or ( anyo_ec < :anyo) )');
    SQL.Add('order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;

  with QCambio do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 fecha_ce, cambio_ce ');
    SQL.Add(' from frf_cambios_euros ');
    SQL.Add(' where moneda_ce = :moneda ');
    SQL.Add(' and fecha_ce < :fecha ');
    SQL.Add(' order by fecha_ce desc ');
    Prepare;
  end;

  with QKilos do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) total, ');
    SQL.Add('        sum(case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) <>  0 ) ');
    SQL.Add('                    then kilos_sl else 0 end) transito, ');
    SQL.Add('        sum(case when producto_sl = :producto then kilos_sl else 0 end ) total_prod, ');
    SQL.Add('        sum(case when producto_sl = :producto then ');
    SQL.Add('                     ( case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) <>  0 ) ');
    SQL.Add('                            then kilos_sl else 0 end ) ');
    SQL.Add('                 else 0 end ) transito_prod  ');

    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');
    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and centro_origen_sl = :centro ');
    SQL.Add(' and n_albaran_sl = :albaran ');
    SQL.Add(' and fecha_sl = :fecha ');
    Prepare;
  end;
end;

procedure TDBalanceComprasProveedor.DataModuleDestroy(Sender: TObject);
begin
  ClientDataSet.Close;

  QCambio.UnPrepare;
  QKilos.UnPrepare;
  QGastosGenerales.UnPrepare;
  QGastosProducto.UnPrepare;
  QProductoBase.UnPrepare;
  QCosteEnvase.UNPrepare;

  QGastosEntregas.Close;
  QEntregas.Close;
  mtSalidasValoradas.Close;
end;

procedure TDBalanceComprasProveedor.PrepareQGastos( const ANo036: boolean );
begin
  with QGastosGenerales do
  begin
    Close;
    if Prepared then
      UnPrepare;
    SQL.Clear;
    (*#GASTO_TRANSITO#*)
    SQL.Add(' select SUM((CASE WHEN gasto_transito_tg = 0 THEN importe_g ELSE 0 END) * ');
    SQL.Add('            (CASE WHEN facturable_tg = ''S'' THEN -1 ELSE 1 END)) gasto_comun, ');
    SQL.Add('        SUM((CASE WHEN gasto_transito_tg = 1 THEN importe_g ELSE 0 END) * ');
    SQL.Add('            (CASE WHEN facturable_tg = ''S'' THEN -1 ELSE 1 END))gasto_transito ');
    (*
    SQL.Add(' select SUM(importe_g * (CASE WHEN facturable_tg = ''S'' THEN -1 ELSE 1 END)) gasto_comun, ');
    SQL.Add('        0 gasto_transito ');
    *)
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');
    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add(' and centro_salida_g = :centro ');
    SQL.Add(' and n_albaran_g = :albaran ');
    SQL.Add(' and fecha_g = :fecha ');
    SQL.Add(' and producto_g is null ');
    if ANo036 then
      SQL.Add(' and tipo_g <> ''036'' ');
    SQL.Add(' and tipo_tg = tipo_g ');
    SQL.Add(' and descontar_fob_tg = ''S'' ');

    Prepare;
  end;

  with QGastosProducto do
  begin
    Close;
    if Prepared then
      UnPrepare;
    SQL.Clear;
    (*#GASTO_TRANSITO#*)
    SQL.Add(' select SUM((CASE WHEN gasto_transito_tg = 0 THEN importe_g ELSE 0 END) * ');
    SQL.Add('            (CASE WHEN facturable_tg = ''S'' THEN -1 ELSE 1 END)) gasto_comun, ');
    SQL.Add('        SUM((CASE WHEN gasto_transito_tg = 1 THEN importe_g ELSE 0 END) * ');
    SQL.Add('            (CASE WHEN facturable_tg = ''S'' THEN -1 ELSE 1 END))gasto_transito ');
    (*
    SQL.Add(' select SUM(importe_g * (CASE WHEN facturable_tg = ''S'' THEN -1 ELSE 1 END)) gasto_comun, ');
    SQL.Add('        0 gasto_transito ');
    *)
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');
    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add(' and centro_salida_g = :centro ');
    SQL.Add(' and n_albaran_g = :albaran ');
    SQL.Add(' and fecha_g = :fecha ');
    SQL.Add(' and producto_g = :producto  ');
    if ANo036 then
      SQL.Add(' and tipo_g <> ''036'' ');
    SQL.Add(' and tipo_tg = tipo_g ');
    SQL.Add(' and descontar_fob_tg = ''S'' ');

    Prepare;
  end;
end;


function SQLCategoriasComerciales( const AEmpresa: string ): string;
begin
  (*TODO*)
  //CategoriasComerciales
  if AEmpresa = '050' then
  begin
    result:= ' AND   ((categoria_sl = "1") or (categoria_sl = "2") or (categoria_sl = "3")) ';
  end
  else
  begin
    result:= '';
  end;
end;

function TDBalanceComprasProveedor.ObtenerDatos(const AEmpresa, ACentroOrigen, ACentroDestino,
        AFechaDesde, AFEchaHasta, AEnvase, ACliente, AProducto, APais, ACategoria: string;
  const AClienteIgual, ADescuento, AGasto, ANo036, ACosteEnvase, ACosteSecciones, AAlb6Digitos, AAlbValor, AFacturado: boolean): boolean;
begin
  Query.SQL.Clear;
  Query.SQL.Add(' SELECT cliente_sl cliente, n_albaran_sc albaran, producto_sl producto, envase_sl envase, ');
  Query.SQL.Add('        centro_salida_sc centro, fecha_sc fecha, moneda_sc moneda, categoria_sl categoria,');

  Query.SQL.Add('        calibre_sl calibre, SUM(NVL(kilos_sl,0)) kilos_producto,');

  if ADescuento then
  begin
    Query.SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0)* ');
    Query.SQL.Add('             (1-(GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100))* ');
    Query.SQL.Add('             (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 2 )/100)), 2) ) neto, ');
  end
  else
  begin
    Query.SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0), 2) ) neto, ');
  end;

  //Query.SQL.Add('        CASE WHEN producto_sl = ' + QuotedStr('E') + ' THEN 1 ELSE 0 END Transito ');
  Query.SQL.Add('        CASE WHEN ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) <>  0 ) ');
  Query.SQL.Add('                 THEN 1 ELSE 0 END Transito, ');
  Query.SQL.Add('        centro_origen_sl centro_origen');

  Query.SQL.Add(' FROM frf_salidas_c, frf_salidas_l, frf_clientes ');

  Query.SQL.Add(' WHERE empresa_sc = :empresa ');
  if ACliente <> '' then
  begin
    if AClienteIgual then
      Query.SQL.Add(' AND   cliente_sal_sc = :cliente ')
    else
      Query.SQL.Add(' AND   cliente_sal_sc <> :cliente ');
  end;
  Query.SQL.Add(' AND   fecha_sc BETWEEN :fechadesde AND :fechahasta ');
  if AAlb6Digitos then
    Query.SQL.Add(' AND   n_albaran_sc > 99999 ');

  Query.SQL.Add(' AND   empresa_sl = :empresa ');
  Query.SQL.Add(' AND   centro_salida_sl = centro_salida_sc ');
  Query.SQL.Add(' AND   n_albaran_sl = n_albaran_sc ');
  Query.SQL.Add(' AND   fecha_sl = fecha_sc ');
  if ACentroOrigen <> '' then
    Query.SQL.Add(' AND   centro_origen_sl = :centroorigen  ');
  if ACentroDestino <> '' then
    Query.SQL.Add(' AND   centro_salida_sl = :centrodestino  ');
  if AProducto <> '' then
    Query.SQL.Add(' AND (producto_sl = :producto)  ');

  if AEnvase <> '' then
    Query.SQL.Add(' AND   envase_sl = :envase ');

  if ACategoria <> '' then
  begin
    Query.SQL.Add(' AND   categoria_sl = :categoria ');
  end
  else
  begin
    Query.SQL.Add( SQLCategoriasComerciales( AEmpresa ) );
  end;

  if AAlbValor then
  begin
    Query.SQL.Add(' AND  ( NVL(precio_sl,0) <> 0 or fecha_factura_sc is not null )');
  end
  else
  begin
    if AFacturado then
    begin
      Query.SQL.Add(' AND   fecha_factura_sc is not null ');
    end
  end;

  Query.SQL.Add(' AND   empresa_c = :empresa ');
  Query.SQL.Add(' AND   cliente_c = cliente_fac_sc ');
  if length(APais) = 2 then
  begin
    Query.SQL.Add(' and pais_c = :pais');
  end
  else
  begin
    if UPPERCASE(APais) = 'NACIONAL' then
    begin
      Query.SQL.Add(' and pais_c = "ES" ');
    end
    else
      if UPPERCASE(APais) = 'EXTRANJERO' then
      begin
        Query.SQL.Add(' and pais_c <> "ES" ');
      end;
  end;

  Query.SQL.Add(' GROUP BY cliente_sl, producto_sl, envase_sl, centro_salida_sc, n_albaran_sc, fecha_sc, moneda_sc, 8, 9, 12, 13 ');
  Query.SQL.Add(' ORDER BY cliente_sl, centro_salida_sc, n_albaran_sc, fecha_sc, moneda_sc, envase_sl ');

  Query.ParamByName('empresa').AsString := AEmpresa;
  if ACentroOrigen <> '' then
    Query.ParamByName('centroorigen').AsString := ACentroOrigen;
  if ACentroDestino <> '' then
    Query.ParamByName('centrodestino').AsString := ACentroDestino;
  Query.ParamByName('fechadesde').AsString := AFechaDesde;
  Query.ParamByName('fechahasta').AsString := AFEchaHasta;
  if ACliente <> '' then
    Query.ParamByName('cliente').AsString := ACliente;
  if ACategoria <> '' then
    Query.ParamByName('categoria').AsString := ACategoria;
  if AEnvase <> '' then
    Query.ParamByName('envase').AsString := AEnvase;
  if AProducto <> '' then
    Query.ParamByName('producto').AsString := AProducto;
  if length(APais) = 2 then
  begin
    Query.ParamByName('pais').AsString := APais;
  end;

  Query.Open;
  if Query.IsEmpty then
  begin
    Query.Close;
    result := false;
    Exit;
  end;
  result := true;
  try
    ClientDataSet.Close;
    ClientDataSet.Open;
  finally
    Query.Close;
  end;

  RellenaDatosFaltantes(AEmpresa, ACategoria, AGasto, ANo036, ACosteEnvase, ACosteSecciones );
end;

procedure TDBalanceComprasProveedor.RellenaDatosFaltantes( const AEmpresa: string; const ACategoria: string;
                                 const AGasto, ANo036, ACosteEnvase, ASecciones: boolean );
var
  iAlbaran, iProductoBase: integer;
  fFactorCambio, fKilosTotal, fKilosTransito, fKilosProdTotal, fKilosProdTransito,
  rCosteEnvase, rCosteSecciones: Real;
  fGastoGeneralComun, fGastoGeneralTransito, fGastoProductoComun, fGastoProductoTransito: Real;
begin
  fFactorCambio := 1;
  iAlbaran := 0;
  ClientDataSet.First;
  rCosteEnvase:= 0;
  rCosteSecciones:= 0;
  PrepareQGastos( ANo036 );
  while not ClientDataSet.Eof do
  begin
    if iAlbaran <> ClientDataSet.FieldByName('albaran').AsInteger then
    begin
      iAlbaran := ClientDataSet.FieldByName('albaran').AsInteger;

      fFactorCambio := FactorCambioFOB('050', ClientDataSet.FieldByName('centro').AsString,
        ClientDataSet.FieldByName('fecha').AsString,
        ClientDataSet.FieldByName('albaran').AsString,
        ClientDataSet.FieldByName('moneda').AsString);
      if fFactorCambio = 0 then fFactorCambio := 1;

      GetKilosAlbaran(fKilosTotal, fKilosTransito, fKilosProdTotal, fKilosProdTransito, AEmpresa,
        ClientDataSet.FieldByName('centro').AsString, ClientDataSet.FieldByName('albaran').AsInteger,
        ClientDataSet.FieldByName('fecha').AsDateTime, ClientDataSet.FieldByName('producto').AsString);
      if AGasto then
      begin
        GetGastosAlbaran( fGastoGeneralComun, fGastoGeneralTransito, fGastoProductoComun, fGastoProductoTransito,
          AEmpresa, ClientDataSet.FieldByName('centro').AsString, ClientDataSet.FieldByName('albaran').AsInteger,
          ClientDataSet.FieldByName('fecha').AsDateTime, ClientDataSet.FieldByName('producto').AsString );
      end;
    end;
    if ACosteEnvase or ASecciones then
    begin
        QProductoBase.ParamByName('empresa').AsString:= AEmpresa;
        QProductoBase.ParamByName('producto').AsString:= ClientDataSet.FieldByName('producto').AsString;
        QProductoBase.Open;
        iProductoBase:= QProductoBase.FieldByName('producto_base_p').AsInteger;
        QProductoBase.Close;

        GetCostesEnvasado(AEmpresa, ClientDataSet.FieldByName('centro').AsString,
                          ClientDataSet.FieldByName('envase').AsString,
                          ClientDataSet.FieldByName('fecha').AsDateTime,
                          iProductoBase, rCosteEnvase, rCosteSecciones);
    end;
    ClientDataSet.Edit;
    ClientDataSet.FieldByName('cambio').AsFloat := fFactorCambio;
    ClientDataSet.FieldByName('kilos_transito').AsFloat := fKilosTransito;
    ClientDataSet.FieldByName('kilos_total').AsFloat := fKilosTotal;
    if AGasto then
    begin
      if fKilosTotal <> 0 then
      ClientDataSet.FieldByName('gasto_comun').AsFloat :=
        bRoundTo((fGastoGeneralComun * ClientDataSet.FieldByName('kilos_producto').AsFloat)
        / fKilosTotal, -3);
      if fKilosProdTotal <> 0 then
        ClientDataSet.FieldByName('gasto_comun').AsFloat := ClientDataSet.FieldByName('gasto_comun').AsFloat +
          bRoundTo((fGastoProductoComun * ClientDataSet.FieldByName('kilos_producto').AsFloat)
          / fKilosProdTotal, -3);

      ClientDataSet.FieldByName('gasto_transito').AsFloat := 0;
      if ClientDataSet.FieldByName('transito').AsFloat = 1 then
      begin
        if fKilosTransito > 0 then
        begin
          ClientDataSet.FieldByName('gasto_transito').AsFloat :=
            bRoundTo((fGastoGeneralTransito * ClientDataSet.FieldByName('kilos_producto').AsFloat)
            / fKilosTransito, -3);

        end;

        if fKilosProdTransito > 0 then
        begin
          ClientDataSet.FieldByName('gasto_transito').AsFloat := ClientDataSet.FieldByName('gasto_transito').AsFloat +
            bRoundTo((fGastoProductoTransito * ClientDataSet.FieldByName('kilos_producto').AsFloat)
            / fKilosProdTransito, -3);
        end;
      end;
    end
    else
    begin
      ClientDataSet.FieldByName('gasto_comun').AsFloat := 0;
      ClientDataSet.FieldByName('gasto_transito').AsFloat := 0;
    end;

    if ACosteEnvase then
    begin
      ClientDataSet.FieldByName('coste_envase').AsFloat :=
        bRoundTo( rCosteEnvase * ClientDataSet.FieldByName('kilos_producto').AsFloat, -3);
    end
    else
    begin
      ClientDataSet.FieldByName('coste_envase').AsFloat := 0;
    end;

    if ASecciones then
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
  ClientDataSet.First;
end;

procedure TDBalanceComprasProveedor.GetKilosAlbaran(var AKilosTotal, AKilosTransito, AKilosProdTotal, AKilosProdTransito: Real;
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
    AKilosTotal := FieldByName('total').AsFloat;
    AKilosTransito := FieldByName('transito').AsFloat;
    AKilosProdTotal := FieldByName('total_prod').AsFloat;
    AKilosProdTransito := FieldByName('transito_prod').AsFloat;
    Close;
  end;
end;

procedure TDBalanceComprasProveedor.GetGastosAlbaran(
      var AGastosGeneralComun, AGastosGeneralTransito, AGastosProductoComun, AGastosProductoTransito: Real;
      const AEmpresa, ACentro: string; const AAlbaran: Integer;
      const AFecha: TDateTime; const AProducto: string );
begin

  with QGastosGenerales do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsInteger := AAlbaran;
    ParamByName('fecha').AsDateTime := AFecha;
    try
      Open;
      AGastosGeneralComun := FieldByName('gasto_comun').AsFloat;
      AGastosGeneralTransito := FieldByName('gasto_transito').AsFloat;
    finally
      Close;
    end;
  end;

  with QGastosProducto do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsInteger := AAlbaran;
    ParamByName('fecha').AsDateTime := AFecha;
    ParamByName('producto').AsString := AProducto;
    try
      Open;
      AGastosProductoComun := FieldByName('gasto_comun').AsFloat;
      AGastosProductoTransito := FieldByName('gasto_transito').AsFloat;
    finally
      Close;
    end;
  end;
end;

procedure TDBalanceComprasProveedor.GetCostesEnvasado( const AEmpresa, ACentro, AEnvase: string;
  const AFEcha: TDateTime; const AProductoBase: integer; var AEnvasado, ASecciones: real );
var
  iAnyo, iMes, iDia: Word;
begin
  with QCosteEnvase do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('envase').AsString := AEnvase;
    ParamByName('producto').AsInteger := AProductoBase;
    DecodeDate( AFecha, iAnyo, iMes, iDia );
    ParamByName('anyo').AsInteger := iAnyo;
    ParamByName('mes').AsInteger := iMes;
    try
      Open;
      AEnvasado := FieldByName('coste_ec').AsFloat;
      ASecciones := FieldByName('secciones_ec').AsFloat;
    finally
      Close;
    end;
  end;
end;

(*
procedure TDBalanceCompra.ListadoFOB;
var
  sSemana, sCategoria: string;
begin
  mtListado.Close;
  mtListado.FieldDefs.Clear;
  mtListado.FieldDefs.Add('producto', ftString, 3, False);
  mtListado.FieldDefs.Add('categoria', ftString, 5, False);
  mtListado.FieldDefs.Add('cliente', ftString, 3, False);
  mtListado.FieldDefs.Add('semana', ftString, 6, False);
  mtListado.FieldDefs.Add('peso', ftFloat, 0, False);
  mtListado.FieldDefs.Add('importe', ftFloat, 0, False);
  mtListado.FieldDefs.Add('gasto_albaran', ftFloat, 0, False);
  mtListado.FieldDefs.Add('coste_envase', ftFloat, 0, False);

  mtListado.IndexFieldNames:= 'producto;categoria;cliente;semana';
  mtListado.CreateTable;
  mtListado.Open;

  with ClientDataSet do
  begin
    First;
    while not EOF do
    begin
      sSemana:= AnyoSemana( FieldByName('fecha').AsDateTime );
      if ( FieldByName('categoria').AsString = '1' ) or ( FieldByName('categoria').AsString = '2' ) then
      begin
        sCategoria:= '1ª+2ª';
      end
      else
      begin
        sCategoria:= '3ª';
      end;
      if mtListado.Locate('producto;categoria;cliente;semana',
                     VarArrayOf([FieldByName('producto').AsString, sCategoria, FieldByName('cliente').AsString, sSemana]), []) then
        ModLineaListadoFOB( sSemana )
      else
        AltaLineaListadoFOB( sSemana, sCategoria );
      Next;
    end;

  end;
  mtListado.SortOn('producto;categoria;cliente;semana',[]);
end;

procedure TDBalanceCompra.AltaLineaListadoFOB( const ASemana, ACategoria: string );
begin
  with mtListado do
  begin
    Insert;
    FieldByName('producto').AsString:= ClientDataSet.FieldByName('producto').AsString;
    FieldByName('cliente').AsString:= ClientDataSet.FieldByName('cliente').AsString;
    FieldByName('semana').AsString:= ASemana;
    FieldByName('categoria').AsString:= ACategoria;


    FieldByName('peso').AsFloat:= ClientDataSet.FieldByName('kilos_producto').AsFloat;

    //Moneda del albaran, pasar a euros
    FieldByName('importe').AsFloat:= bRoundTo(ClientDataSet.FieldByName('neto').AsFloat * ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('gasto_albaran').AsFloat:= bRoundTo( ( ClientDataSet.FieldByName('gasto_comun').AsFloat + ClientDataSet.FieldByName('gasto_transito').AsFloat )
                                             * ClientDataSet.FieldByName('cambio').AsFloat, 2 ); ;

    //En euros
    FieldByName('coste_envase').AsFloat:= ClientDataSet.FieldByName('coste_envase').AsFloat +
                                          ClientDataSet.FieldByName('coste_seccion').AsFloat;
    Post;
  end;
end;

procedure TDBalanceCompra.ModLineaListadoFOB( const ASemana: string );
begin
  with mtListado do
  begin
    Edit;

    FieldByName('peso').AsFloat:= FieldByName('peso').AsFloat + ClientDataSet.FieldByName('kilos_producto').AsFloat;

    //Moneda del albaran, pasar a euros
    FieldByName('importe').AsFloat:= FieldByName('importe').AsFloat +
                                     bRoundTo(ClientDataSet.FieldByName('neto').AsFloat * ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('gasto_albaran').AsFloat:= FieldByName('gasto_albaran').AsFloat +
                                   bRoundTo( ( ClientDataSet.FieldByName('gasto_comun').AsFloat + ClientDataSet.FieldByName('gasto_transito').AsFloat )
                                             * ClientDataSet.FieldByName('cambio').AsFloat, 2 ); ;

    //En euros
    FieldByName('coste_envase').AsFloat:= FieldByName('coste_envase').AsFloat +
                                    ClientDataSet.FieldByName('coste_envase').AsFloat +
                                    ClientDataSet.FieldByName('coste_seccion').AsFloat;                                     ;
    Post;
  end;
end;

*)

end.
