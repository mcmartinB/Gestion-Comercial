unit EnvasesFOBData;

interface

uses
  SysUtils, Classes, DB, DBClient, Provider, DBTables, kbmMemTable, MidasLib;

type
  TDMEnvasesFOBData = class(TDataModule)
    Query: TQuery;
    DataSetProvider: TDataSetProvider;
    ClientDataSet: TClientDataSet;
    ClientDataSetcliente: TStringField;
    ClientDataSetalbaran: TIntegerField;
    ClientDataSetenvase: TStringField;
    ClientDataSetcentro: TStringField;
    ClientDataSetfecha: TDateField;
    ClientDataSetmoneda: TStringField;
    ClientDataSetcambio: TFloatField;
    ClientDataSetkilos_producto: TFloatField;
    ClientDataSetkilos_transito: TFloatField;
    ClientDataSetkilos_total: TFloatField;
    ClientDataSetneto: TFloatField;
    ClientDataSetgasto_transito: TFloatField;
    ClientDataSetcoste_envase: TFloatField;
    DataSource: TDataSource;
    QKilos: TQuery;
    ClientDataSettransito: TIntegerField;
    QGastosGenerales: TQuery;
    QProductoBase: TQuery;
    QCosteEnvase: TQuery;
    ClientDataSetgasto_comun: TFloatField;
    ClientDataSetcalibre: TStringField;
    ClientDataSetcoste_envasado: TFloatField;
    ClientDataSetcoste_seccion: TFloatField;
    ClientDataSetcentro_origen: TStringField;
    QGastosProducto: TQuery;
    ClientDataSetcategoria: TStringField;
    strngfldClientDataSetanyosemana: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure RellenaDatosFaltantes( const AEmpresa, AProducto: string; const AProductoBase: integer;
      const ACategoria: string; const AGasto, ANo036, ACosteEnvase, ASecciones: boolean );
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
    (*
    function GetCosteEnvasadoBonnysa( const AEmpresa, ACentro, AProducto, ACategoria: string; const AFecha: TDateTime): real;
    function GetCosteEnvasadoBonnysaEx( const AEmpresa, ACentro, AProducto, ACategoria, AAnyoMes: string): real;
    *)
    procedure PrepareQGastos( const ANo036: boolean );
  public
    { Public declarations }
    function ObtenerDatosInf(const AEmpresa, ACentroOrigen, ACentroDestino,
            AFechaDesde, AFEchaHasta, AEnvase, AClienteDesde, AClienteHasta,
            AProducto, APais, ACategoria: string;
      const AGasto, ANo036, ACosteEnvase, ACosteSecciones, AAlb6Digitos, AAlbaran, ACalibre, AAnyoSemana: boolean): boolean;
  end;

implementation

{$R *.dfm}

uses bMath, Variants, UDMCambioMoneda, UDMconfig;

procedure TDMEnvasesFOBData.PrepareQGastos( const ANo036: boolean );
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

procedure TDMEnvasesFOBData.DataModuleCreate(Sender: TObject);
begin
(*
  kbmMemTable.SortOptions := [];                                           // Optional.
  kbmMemTable.FieldDefs.Clear; //We dont need this line, but it does not hurt either.
  kbmMemTable.FieldDefs.Add('centro', ftString, 1, False);
  kbmMemTable.FieldDefs.Add('categoria', ftString, 2, False);
  kbmMemTable.FieldDefs.Add('anyomes', ftString, 6, False);
  kbmMemTable.FieldDefs.Add('coste', ftFloat, 0, False);
  kbmMemTable.IndexDefs.Add('Index1','anyomes',[]);
  kbmMemTable.CreateTable;
  kbmMemTable.IndexFieldNames:= 'centro;categoria;anyomes';
  kbmMemTable.SortFields := 'centro;categoria;anyomes';
*)

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


  with QKilos do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) total, ');
    SQL.Add('        sum(case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                    then kilos_sl else 0 end) transito, ');
    SQL.Add('        sum(case when producto_sl = :producto then kilos_sl else 0 end ) total_prod, ');
    SQL.Add('                sum(case when producto_sl = :producto then ');
    SQL.Add('                     ( case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                            then kilos_sl else 0 end ) ');
    SQL.Add('                 else 0 end ) transito_prod  ');

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
end;

procedure TDMEnvasesFOBData.DataModuleDestroy(Sender: TObject);
begin
  QKilos.UnPrepare;
  QGastosGenerales.UnPrepare;
  QGastosProducto.UnPrepare;
  QProductoBase.UnPrepare;
  QCosteEnvase.UNPrepare;
  ClientDataSet.Close;
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

function TDMEnvasesFOBData.ObtenerDatosInf(const AEmpresa, ACentroOrigen, ACentroDestino,
        AFechaDesde, AFEchaHasta, AEnvase, AClienteDesde, AClienteHasta,
        AProducto, APais, ACategoria: string;
  const AGasto, ANo036, ACosteEnvase, ACosteSecciones, AAlb6Digitos, AAlbaran, ACalibre, AAnyoSemana: boolean): boolean;
var
  iProductoBase: integer;
begin
  Query.SQL.Clear;
  Query.SQL.Add(' SELECT cliente_sl cliente, n_albaran_sc albaran, envase_sl envase, ');
  Query.SQL.Add('        centro_salida_sc centro, fecha_sc fecha, moneda_sc moneda, ');
  Query.SQL.Add('      categoria_sl categoria,');
  (*CALIBRE*)
  if ACalibre then
  begin
    Query.SQL.Add('        calibre_sl calibre,');
  end
  else
  begin
    Query.SQL.Add('        ''CALIBR'' calibre,');
  end;
  Query.SQL.Add('        SUM(NVL(kilos_sl,0)) kilos_producto, ');

  Query.SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0)* ');
  Query.SQL.Add('             (1-(GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100))* ');
  Query.SQL.Add('             (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 2 )/100)), 2) ) neto, ');


  //Query.SQL.Add('        CASE WHEN producto_sl = ' + QuotedStr('E') + ' THEN 1 ELSE 0 END Transito ');
  Query.SQL.Add('        CASE WHEN ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ');
  Query.SQL.Add('                 THEN 1 ELSE 0 END Transito, ');
  if AAnyoSemana then
     Query.SQL.Add('        centro_origen_sl centro_origen, yearandweek( fecha_sl) anyosemana')
  else
     Query.SQL.Add('        centro_origen_sl centro_origen, ''XXXXXX'' anyosemana');

  Query.SQL.Add(' FROM frf_salidas_c, frf_salidas_l, frf_clientes ');

  Query.SQL.Add(' WHERE empresa_sc = :empresa ');
  Query.SQL.Add(' AND   cliente_sal_sc BETWEEN :clientedesde AND :clientehasta ');
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
  Query.SQL.Add(' AND ((producto_sl = :productouno) or (producto_sl = :productodos)) ');

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

  Query.SQL.Add(' AND   NVL(precio_sl,0) <> 0 ');

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

  Query.SQL.Add(' GROUP BY cliente_sl, envase_sl, centro_salida_sc, n_albaran_sc, fecha_sc, moneda_sc, 7, 8, 11, 12, anyosemana ');
  Query.SQL.Add(' ORDER BY cliente_sl, centro_salida_sc, n_albaran_sc, fecha_sc, moneda_sc, envase_sl ');

  Query.ParamByName('empresa').AsString := AEmpresa;
  if ACentroOrigen <> '' then
    Query.ParamByName('centroorigen').AsString := ACentroOrigen;
  if ACentroDestino <> '' then
    Query.ParamByName('centrodestino').AsString := ACentroDestino;
  Query.ParamByName('fechadesde').AsString := AFechaDesde;
  Query.ParamByName('fechahasta').AsString := AFEchaHasta;
  Query.ParamByName('clientedesde').AsString := AClienteDesde;
  Query.ParamByName('clientehasta').AsString := AClienteHasta;
  if ACategoria <> '' then
    Query.ParamByName('categoria').AsString := ACategoria;
  if AEnvase <> '' then
    Query.ParamByName('envase').AsString := AEnvase;
  if length(AProducto) > 1 then
  begin
    Query.ParamByName('productouno').AsString := 'E';
    Query.ParamByName('productodos').AsString := 'T';
  end
  else
  begin
    Query.ParamByName('productouno').AsString := AProducto;
    Query.ParamByName('productodos').AsString := AProducto;
  end;
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

  QProductoBase.ParamByName('empresa').AsString:= AEmpresa;
  if length(AProducto) > 1 then
  begin
    QProductoBase.ParamByName('producto').AsString:= 'T';
  end
  else
  begin
    QProductoBase.ParamByName('producto').AsString:= AProducto;
  end;
  QProductoBase.Open;
  iProductoBase:= QProductoBase.FieldByName('producto_base_p').AsInteger;
  QProductoBase.Close;

  (*
  if ACosteSecciones then
    kbmMemTable.Open;
  try
  *)
    ClientDataSet.IndexFieldNames:= 'envase;albaran';
    RellenaDatosFaltantes(AEmpresa, AProducto, iProductoBase, ACategoria, AGasto, ANo036, ACosteEnvase, ACosteSecciones );
  (*
  finally
    if ACosteSecciones then
      kbmMemTable.Close;
  end;
  *)

  if ACalibre then
  begin
    if AAlbaran then
    begin
      ClientDataSet.IndexFieldNames:= 'envase;cliente;albaran;calibre';
    end
    else
    begin
      ClientDataSet.IndexFieldNames:= 'envase;cliente;calibre';
    end;
  end
  else
  begin
    ClientDataSet.IndexFieldNames:= 'envase;cliente;albaran';
  end;
end;

procedure TDMEnvasesFOBData.RellenaDatosFaltantes( const AEmpresa, AProducto: string; const AProductoBase: integer;
      const ACategoria: string; const AGasto, ANo036, ACosteEnvase, ASecciones: boolean );
var
  iAlbaran: integer;
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

  ClientDataSet.First;
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
        ClientDataSet.FieldByName('fecha').AsDateTime, AProducto);
      if AGasto then
      begin
        GetGastosAlbaran( fGastoGeneralComun, fGastoGeneralTransito, fGastoProductoComun, fGastoProductoTransito,
          AEmpresa, ClientDataSet.FieldByName('centro').AsString,
          ClientDataSet.FieldByName('albaran').AsInteger,
          ClientDataSet.FieldByName('fecha').AsDateTime, AProducto );
      end;
      (*
      if ASecciones then
      begin
        fCosteEnvasado:= GetCosteEnvasadoBonnysa( AEmpresa,
                                                  ClientDataSet.FieldByName('centro_origen').AsString,
                                                  AProducto,
                                                  ClientDataSet.FieldByName('categoria').AsString,
                                                  ClientDataSet.FieldByName('fecha').AsDateTime );
      end;
      *)
    end;
    if ACosteEnvase or ASecciones then
    begin
      GetCostesEnvasado(AEmpresa, ClientDataSet.FieldByName('centro').AsString,
                          ClientDataSet.FieldByName('envase').AsString,
                          ClientDataSet.FieldByName('fecha').AsDateTime,
                          AProductoBase, rCosteEnvase, rCosteSecciones);
    end;

    ClientDataSet.Edit;
    ClientDataSet.FieldByName('cambio').AsFloat := fFactorCambio;
    ClientDataSet.FieldByName('kilos_transito').AsFloat := fKilosTransito;
    ClientDataSet.FieldByName('kilos_total').AsFloat := fKilosTotal;
    if AGasto then
    begin
      ClientDataSet.FieldByName('gasto_comun').AsFloat :=
        bRoundTo((fGastoGeneralComun * ClientDataSet.FieldByName('kilos_producto').AsFloat)
        / fKilosTotal, -3);
      if fKilosProdTotal <> 0 then
        ClientDataSet.FieldByName('gasto_comun').AsFloat := ClientDataSet.FieldByName('gasto_comun').AsFloat +
          bRoundTo((fGastoProductoComun * ClientDataSet.FieldByName('kilos_producto').AsFloat)
          / fKilosProdTotal, -3);

      if ClientDataSet.FieldByName('transito').AsFloat = 1 then
      begin
        ClientDataSet.FieldByName('gasto_transito').AsFloat :=
          bRoundTo((fGastoGeneralTransito * ClientDataSet.FieldByName('kilos_producto').AsFloat)
          / fKilosTransito, -3);
        ClientDataSet.FieldByName('gasto_transito').AsFloat := ClientDataSet.FieldByName('gasto_transito').AsFloat +
          bRoundTo((fGastoProductoTransito * ClientDataSet.FieldByName('kilos_producto').AsFloat)
          / fKilosProdTransito, -3);
      end
      else
      begin
        ClientDataSet.FieldByName('gasto_transito').AsFloat := 0;
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
        ClientDataSet.FieldByName('coste_envasado').AsFloat :=
          ClientDataSet.FieldByName('coste_envase').AsFloat;
    end
    else
    begin
      ClientDataSet.FieldByName('coste_envase').AsFloat := 0;
      ClientDataSet.FieldByName('coste_envasado').AsFloat := 0;
    end;

    if ASecciones then
    begin
      ClientDataSet.FieldByName('coste_envase').AsFloat := ClientDataSet.FieldByName('coste_envase').AsFloat +
        bRoundTo( rCosteSecciones * ClientDataSet.FieldByName('kilos_producto').AsFloat, -3);
      ClientDataSet.FieldByName('coste_seccion').AsFloat:=
        bRoundTo( rCosteSecciones * ClientDataSet.FieldByName('kilos_producto').AsFloat, -3);
    end;

    ClientDataSet.Post;
    ClientDataSet.Next;
  end;
  ClientDataSet.First;
end;


procedure TDMEnvasesFOBData.GetKilosAlbaran(var AKilosTotal, AKilosTransito, AKilosProdTotal, AKilosProdTransito: Real;
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

procedure TDMEnvasesFOBData.GetGastosAlbaran(
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

procedure TDMEnvasesFOBData.GetCostesEnvasado( const AEmpresa, ACentro, AEnvase: string;
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

end.
