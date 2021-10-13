unit CDMTablaFOB;

interface

uses
  SysUtils, Classes, DB, DBClient, Provider, DBTables, kbmMemTable, MidasLib;

type
  TDMTablaFOB = class(TDataModule)
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
    DataSource: TDataSource;
    QKilos: TQuery;
    ClientDataSettransito: TIntegerField;
    QGastosGenerales: TQuery;
    QProductoBase: TQuery;
    QCosteEnvase: TQuery;
    ClientDataSetgasto_comun: TFloatField;
    ClientDataSetcalibre: TStringField;
    ClientDataSetcoste_envasado: TFloatField;
    ClientDataSetcentro_origen: TStringField;
    QGastosProducto: TQuery;
    ClientDataSetcategoria: TStringField;
    mtListado: TkbmMemTable;
    ClientDataSetproducto: TStringField;
    ClientDataSetempresa: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure RellenaDatosFaltantes( const ACategoria: string; const AGasto: integer; const  ACosteEnvase: boolean );
(*
    function  GetCambio( const AMoneda: String; const AFecha: TDateTime ): Real;
*)
    procedure GetKilosAlbaran(var AKilosTotal, AKilosTransito, AKilosProdTotal, AKilosProdTransito: Real;
      const AEmpresa, ACentro: string; const AAlbaran: Integer; const AFecha: TDateTime; const AProducto: string);
    procedure GetGastosAlbaran(var AGastosGeneralComun, AGastosGeneralTransito, AGastosProductoComun, AGastosProductoTransito: Real;
      const AEmpresa, ACentro: string; const AAlbaran: Integer;
      const AFecha: TDateTime; const AProducto: string );
    procedure GetCostesEnvasado( const AEmpresa, ACentro, AEnvase, AProducto: string;
                                 const AFEcha: TDateTime; const AProductoBase: integer; var AEnvasado: real );
    procedure PrepareQGastos( const AFacturables: boolean );

    procedure ModLineaIntrastat;
    procedure AltaLineaIntrastat( const AComunitario, AProvincia, APais, AProducto, AEnvase: string );
  public
    { Public declarations }
    function  ObtenerDatos(const AEmpresa, ACentroOrigen, ACentroDestino, AFechaDesde, AFEchaHasta,
                                 AEnvase, ACliente, AProducto, APais, ACategoria: string;
                           const ADescuento, AGasto, AAlbFacturado: integer;
                           const ACosteEnvase: boolean ): boolean;

    procedure ListadoIntrastat;
  end;


implementation

{$R *.dfm}

uses bMath, Variants, UDMCambioMoneda, bTimeUtils, UDMAuxDB;

procedure TDMTablaFOB.PrepareQGastos( const AFacturables: boolean );
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
    SQL.Add(' and tipo_tg = tipo_g ');
    SQL.Add(' and descontar_fob_tg = ''S'' ');
    if AFacturables then
      SQL.Add(' and facturable_tg = "S" ');

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
    SQL.Add(' and tipo_tg = tipo_g ');
    SQL.Add(' and descontar_fob_tg = ''S'' ');
    if AFacturables then
      SQL.Add(' and facturable_tg = "S" ');

    Prepare;
  end;
end;

procedure TDMTablaFOB.DataModuleCreate(Sender: TObject);
begin
  mtListado.FieldDefs.Clear;
  mtListado.FieldDefs.Add('empresa', ftString, 3, False);
  mtListado.IndexFieldNames:= 'empresa';
  mtListado.CreateTable;


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
    SQL.Add('select first 1 anyo_ec, mes_ec, ( material_ec + personal_ec + general_ec ) coste_ec ');
    SQL.Add('from frf_env_costes ');
    SQL.Add('where empresa_ec = :empresa ');
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
    SQL.Add(' select sum(kilos_sl) total, ');
    SQL.Add('        sum(case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                    then kilos_sl else 0 end) transito, ');
    SQL.Add('        sum(case when producto_sl = :producto then kilos_sl else 0 end ) total_prod, ');
    SQL.Add('        sum(case when producto_sl = :producto then ');
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

procedure TDMTablaFOB.DataModuleDestroy(Sender: TObject);
begin
  ClientDataSet.Close;
  mtListado.Close;

  QKilos.UnPrepare;
  QGastosGenerales.UnPrepare;
  QGastosProducto.UnPrepare;
  QProductoBase.UnPrepare;
  QCosteEnvase.UNPrepare;
end;

(*
  AAlbFacturado
  -1 todos
   0 sin facturar
   1 Sin facturar o transitos sin asignar
   2 facturados
   3 facturados y asignados
  ADescuento
  -1 sin descuentos
   0 todos los descuentos
   1 solo los facturables
  AGastos
  -1 sin gastos
   0 todos los gastos
   1 solo los facturables
*)

function TDMTablaFOB.ObtenerDatos(const AEmpresa, ACentroOrigen, ACentroDestino,
        AFechaDesde, AFEchaHasta, AEnvase, ACliente, AProducto, APais, ACategoria: string;
  const ADescuento, AGasto, AAlbFacturado: integer; const ACosteEnvase: boolean ): boolean;
begin
  Query.SQL.Clear;
  Query.SQL.Add(' SELECT empresa_sc empresa, cliente_sl cliente, n_albaran_sc albaran, producto_sl producto, envase_sl envase, ');
  Query.SQL.Add('        centro_salida_sc centro, fecha_sc fecha, moneda_sc moneda, categoria_sl categoria,');
  Query.SQL.Add('        calibre_sl calibre, centro_origen_sl centro_origen, ');

  Query.SQL.Add('        CASE WHEN ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ');
  Query.SQL.Add('                 THEN 1 ELSE 0 END Transito, ');

  Query.SQL.Add('        SUM(NVL(kilos_sl,0)) kilos_producto,');

  if ADescuento  = -1 then
  begin
    //Sin descuento
    Query.SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0), 2) ) neto ');
  end
  else
  if ADescuento  = 0 then
  begin
    //Con descuento
    Query.SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0)* ');
    Query.SQL.Add('             (1-(GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100))* ');
    Query.SQL.Add('             (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 2 )/100)), 2) ) neto ');
  end
  else
  if ADescuento  = 1 then
  begin
    //Solo el facturable
    Query.SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0)* ');
    Query.SQL.Add('             (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 2 )/100)), 1) ) neto ');
  end;


  Query.SQL.Add(' FROM frf_salidas_c, frf_salidas_l, frf_clientes ');

  if AEmpresa = 'BAG' then
  begin
    Query.SQL.Add(' WHERE empresa_sc[1] = ''F''                        ');
    Query.SQL.Add('   AND fecha_sc BETWEEN :fechadesde AND :fechahasta ');
  end
  else
  begin
    Query.SQL.Add(' WHERE empresa_sc = :empresa ');
    Query.SQL.Add(' AND   fecha_sc BETWEEN :fechadesde AND :fechahasta ');
  end;
  if ACliente <> '' then
  begin
    Query.SQL.Add(' AND   cliente_sal_sc = :cliente ');
  end;

  Query.SQL.Add(' AND   empresa_sl = empresa_sc ');
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
  end;

  //Query.SQL.Add(' AND   NVL(precio_sl,0) <> 0 '); //valorado
  if AAlbFacturado = 0 then
  begin
    //Sin facturar
    Query.SQL.Add(' AND  fecha_factura_sc is null ');
  end
  else
  if AAlbFacturado = 1 then
  begin
    //Sin facturar y transitos sin asignar
    Query.SQL.Add(' AND  ( fecha_factura_sc is null ');
    Query.SQL.Add(' or exists ( select * ');
    Query.SQL.Add('                   from frf_transitos_c ');
    Query.SQL.Add('                   where empresa_tc = empresa_sc ');
    Query.SQL.Add('                   and referencia_tc in ( select sl.ref_transitos_sl from frf_salidas_l sl ');
    Query.SQL.Add('                                          where sl.empresa_sl = empresa_sc and sl.centro_salida_sl = centro_salida_sc ');
    Query.SQL.Add('                                          and sl.n_albaran_sl = n_albaran_sc and sl.fecha_sl = fecha_sc ');
    Query.SQL.Add('                                          and sl.centro_origen_sl = centro_tc  ) ');
    Query.SQL.Add('                   and fecha_tc between fecha_sc - 180 and fecha_sc + 30 ');
    Query.SQL.Add('                   and status_gastos_tc = "N" ) )');
  end
  else
  if AAlbFacturado = 2 then
  begin
    //Facturados
    Query.SQL.Add(' AND  fecha_factura_sc is not null ');
  end
  else
  if AAlbFacturado = 3 then
  begin
    //Facturados y asignados
    Query.SQL.Add(' AND  fecha_factura_sc is not null ');
    Query.SQL.Add(' and not exists ( select * ');
    Query.SQL.Add('                   from frf_transitos_c ');
    Query.SQL.Add('                   where empresa_tc = empresa_sc ');
    Query.SQL.Add('                   and referencia_tc in ( select sl.ref_transitos_sl from frf_salidas_l sl ');
    Query.SQL.Add('                                          where sl.empresa_sl = empresa_sc and sl.centro_salida_sl = centro_salida_sc ');
    Query.SQL.Add('                                          and sl.n_albaran_sl = n_albaran_sc and sl.fecha_sl = fecha_sc ');
    Query.SQL.Add('                                          and sl.centro_origen_sl = centro_tc  ) ');
    Query.SQL.Add('                   and fecha_tc between fecha_sc - 180 and fecha_sc + 30 ');
    Query.SQL.Add('                   and status_gastos_tc = "N" ) ');
  end;

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

  Query.SQL.Add(' GROUP BY empresa_sc, cliente_sl, n_albaran_sc, producto_sl, envase_sl, centro_salida_sc,  fecha_sc, ');
  Query.SQL.Add('          moneda_sc, categoria_sl, calibre_sl, centro_origen_sl, 12 ');
  Query.SQL.Add(' ORDER BY empresa_sc, cliente_sl, centro_salida_sc, n_albaran_sc, fecha_sc, moneda_sc, envase_sl ');

  if AEmpresa <> 'BAG' then
    Query.ParamByName('empresa').AsString := AEmpresa;
  Query.ParamByName('fechadesde').AsString := AFechaDesde;
  Query.ParamByName('fechahasta').AsString := AFEchaHasta;

  if ACentroOrigen <> '' then
    Query.ParamByName('centroorigen').AsString := ACentroOrigen;
  if ACentroDestino <> '' then
    Query.ParamByName('centrodestino').AsString := ACentroDestino;
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

  RellenaDatosFaltantes(ACategoria, AGasto, ACosteEnvase );
end;

procedure TDMTablaFOB.RellenaDatosFaltantes( const ACategoria: string; const AGasto:integer; const ACosteEnvase: boolean );
var
  iAlbaran, iProductoBase: integer;
  fFactorCambio, fKilosTotal, fKilosTransito, fKilosProdTotal, fKilosProdTransito, rCosteEnvase: Real;
  fGastoGeneralComun, fGastoGeneralTransito, fGastoProductoComun, fGastoProductoTransito: Real;
begin
  fFactorCambio := 1;
  iAlbaran := 0;
  ClientDataSet.First;
  rCosteEnvase:= 0;
  PrepareQGastos( AGasto = 1 );
  while not ClientDataSet.Eof do
  begin
    if iAlbaran <> ClientDataSet.FieldByName('albaran').AsInteger then
    begin
      iAlbaran := ClientDataSet.FieldByName('albaran').AsInteger;
      (*FACTORCAMBIO*)
      (*
      fFactorCambio := FactorCambioFOB(ClientDataSet.FieldByName('empresa').AsString,
        ClientDataSet.FieldByName('centro').AsString,
        ClientDataSet.FieldByName('fecha').AsString,
        ClientDataSet.FieldByName('albaran').AsString,
        ClientDataSet.FieldByName('moneda').AsString);
      if fFactorCambio = 0 then
      *)
        fFactorCambio := 1;

      GetKilosAlbaran(fKilosTotal, fKilosTransito, fKilosProdTotal, fKilosProdTransito, ClientDataSet.FieldByName('empresa').AsString,
        ClientDataSet.FieldByName('centro').AsString, ClientDataSet.FieldByName('albaran').AsInteger,
        ClientDataSet.FieldByName('fecha').AsDateTime, ClientDataSet.FieldByName('producto').AsString);
      if AGasto >= 0 then
      begin
        GetGastosAlbaran( fGastoGeneralComun, fGastoGeneralTransito, fGastoProductoComun, fGastoProductoTransito,
          ClientDataSet.FieldByName('empresa').AsString, ClientDataSet.FieldByName('centro').AsString, ClientDataSet.FieldByName('albaran').AsInteger,
          ClientDataSet.FieldByName('fecha').AsDateTime, ClientDataSet.FieldByName('producto').AsString );
      end;
    end;
    if ACosteEnvase  then
    begin
        QProductoBase.ParamByName('producto').AsString:= ClientDataSet.FieldByName('producto').AsString;
        QProductoBase.Open;
        iProductoBase:= QProductoBase.FieldByName('producto_base_p').AsInteger;
        QProductoBase.Close;

        GetCostesEnvasado(ClientDataSet.FieldByName('empresa').AsString, ClientDataSet.FieldByName('centro').AsString,
                          ClientDataSet.FieldByName('envase').AsString,
                          ClientDataSet.FieldByName('producto').AsString,
                          ClientDataSet.FieldByName('fecha').AsDateTime,
                          iProductoBase, rCosteEnvase);
    end;
    ClientDataSet.Edit;
    ClientDataSet.FieldByName('cambio').AsFloat := fFactorCambio;
    ClientDataSet.FieldByName('kilos_transito').AsFloat := fKilosTransito;
    ClientDataSet.FieldByName('kilos_total').AsFloat := fKilosTotal;
    if AGasto >= 0  then
    begin
      if fKilosTotal <> 0 then
        ClientDataSet.FieldByName('gasto_comun').AsFloat :=
          bRoundTo((fGastoGeneralComun * ClientDataSet.FieldByName('kilos_producto').AsFloat)
          / fKilosTotal, -3)
      else
        ClientDataSet.FieldByName('gasto_comun').AsFloat := 0;
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
      ClientDataSet.FieldByName('coste_envasado').AsFloat :=
        bRoundTo( rCosteEnvase * ClientDataSet.FieldByName('kilos_producto').AsFloat, -3);
    end
    else
    begin
      ClientDataSet.FieldByName('coste_envasado').AsFloat:= 0;
    end;

    ClientDataSet.Post;
    ClientDataSet.Next;
  end;
  ClientDataSet.First;
end;

procedure TDMTablaFOB.GetKilosAlbaran(var AKilosTotal, AKilosTransito, AKilosProdTotal, AKilosProdTransito: Real;
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

procedure TDMTablaFOB.GetGastosAlbaran(
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

procedure TDMTablaFOB.GetCostesEnvasado( const AEmpresa, ACentro, AEnvase, AProducto: string;
  const AFEcha: TDateTime; const AProductoBase: integer; var AEnvasado: real );
var
  iAnyo, iMes, iDia: Word;
begin
  with QCosteEnvase do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('envase').AsString := AEnvase;
    ParamByName('producto').AsString := AProducto;
    DecodeDate( AFecha, iAnyo, iMes, iDia );
    ParamByName('anyo').AsInteger := iAnyo;
    ParamByName('mes').AsInteger := iMes;
    try
      Open;
      AEnvasado := FieldByName('coste_ec').AsFloat;
    finally
      Close;
    end;
  end;
end;


procedure PaisDestino( const AEmpresa, ACliente: string; var VPais, VComunitario: string );
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select pais_c, case when comunitario_p =1 then ''S'' else ''N'' end comunitario_c ');
    SQL.Add('from frf_clientes, frf_paises ');
    SQL.Add('where cliente_c = :cliente ');
    SQL.Add('and pais_c = pais_p ');
    ParamByName('cliente').AsString:=ACliente;
    Open;
    VPais:= FieldByName('pais_c').AsString;
    VComunitario:= FieldByName('comunitario_c').AsString;
    Close;
  end;
end;

function ProvinciaOrigen( const AEmpresa, ACentro: string ): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select cod_postal_c[1,2] provincia ');
    SQL.Add('from frf_centros ');
    SQL.Add('where empresa_c = :empresa ');
    SQL.Add('and centro_c = :centro ');
    ParamByName('empresa').AsString:=AEmpresa;
    ParamByName('centro').AsString:=ACentro;
    Open;
    result:= FieldByName('provincia').AsString;
    Close;
  end;
end;

procedure TDMTablaFOB.ListadoIntrastat;
var
  sComunitario, sPais, sProvincia: string;
begin
  mtListado.Close;
  mtListado.FieldDefs.Clear;
  mtListado.FieldDefs.Add('comunitario', ftString, 1, False);
  mtListado.FieldDefs.Add('provincia', ftString, 2, False);
  mtListado.FieldDefs.Add('pais', ftString, 2, False);
  mtListado.FieldDefs.Add('producto', ftString, 3, False);
  mtListado.FieldDefs.Add('envase', ftString, 9, False);
  mtListado.FieldDefs.Add('peso', ftFloat, 0, False);
  mtListado.FieldDefs.Add('importe', ftFloat, 0, False);

  mtListado.IndexFieldNames:= 'comunitario;provincia;pais;producto;envase';
  mtListado.CreateTable;
  mtListado.Open;

  with ClientDataSet do
  begin
    First;
    while not EOF do
    begin
      sProvincia:= ProvinciaOrigen( FieldByName('empresa').AsString, FieldByName('centro').AsString );
      PaisDestino( FieldByName('empresa').AsString, FieldByName('cliente').AsString, sPais, sComunitario );
      if mtListado.Locate('comunitario;provincia;pais;producto;envase',
                     VarArrayOf([sComunitario, sProvincia, sPais, FieldByName('producto').AsString, FieldByName('envase').AsString]), []) then
        ModLineaIntrastat
      else
        AltaLineaIntrastat( sComunitario, sProvincia,  sPais, FieldByName('producto').AsString, FieldByName('envase').AsString );
      Next;
    end;
    Close;
  end;
  mtListado.SortOn('comunitario;provincia;pais;producto;envase',[]);
end;

procedure TDMTablaFOB.ModLineaIntrastat;
var
  rAux: real;
begin
  with mtListado do
  begin
    Edit;

    FieldByName('peso').AsFloat:= FieldByName('peso').AsFloat + ClientDataSet.FieldByName('kilos_producto').AsFloat;
    //Moneda del albaran, pasar a euros
    rAux:= bRoundTo( ( ClientDataSet.FieldByName('gasto_comun').AsFloat + ClientDataSet.FieldByName('gasto_transito').AsFloat )
                                             * ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('importe').AsFloat:= FieldByName('importe').AsFloat + bRoundTo(ClientDataSet.FieldByName('neto').AsFloat * ClientDataSet.FieldByName('cambio').AsFloat, 2 ) - rAux;
    Post;
  end;
end;

procedure TDMTablaFOB.AltaLineaIntrastat( const AComunitario, AProvincia, APais, AProducto, AEnvase: string );
var
  rAux: real;
begin
  with mtListado do
  begin
    Insert;
    FieldByName('comunitario').AsString:= AComunitario;
    FieldByName('provincia').AsString:= AProvincia;
    FieldByName('pais').AsString:= APais;
    FieldByName('producto').AsString:= AProducto;
    FieldByName('envase').AsString:= AEnvase;

    FieldByName('peso').AsFloat:= ClientDataSet.FieldByName('kilos_producto').AsFloat;
    //Moneda del albaran, pasar a euros
    rAux:= bRoundTo( ( ClientDataSet.FieldByName('gasto_comun').AsFloat + ClientDataSet.FieldByName('gasto_transito').AsFloat )
                                             * ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('importe').AsFloat:= bRoundTo(ClientDataSet.FieldByName('neto').AsFloat * ClientDataSet.FieldByName('cambio').AsFloat, 2 ) - rAux;
    Post;
  end;
end;

end.
