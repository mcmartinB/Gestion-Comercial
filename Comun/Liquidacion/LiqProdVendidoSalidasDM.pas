unit LiqProdVendidoSalidasDM;

interface

uses
  SysUtils, Classes, DB, DBTables, LiqProdVendidoDM, DateUtils, bMath;

type
  TDMLiqProdVendidoSalidas = class(TDataModule)
    qrySalidas: TQuery;
    qryAux: TQuery;
    qryKilosSalidas: TQuery;
    qryKilosTransitosOut: TQuery;
    qryKilosSalida: TQuery;
    qryKilosTransito: TQuery;
    qryCosteEnvasado: TQuery;
    qryGastoAlbaran: TQuery;
    qryGastoTransito: TQuery;
    qryCostePresupuesto: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa: String;
    rCosteAbonoSem: Real;

    //Parametros de entrada
    bFacturado: Boolean;
    //sEmpresa, sCentro, sProducto, sSemana: string;
    //dFechaIni, dFechaFin: TDateTime;

    iCodigo, iLinea: Integer;
    skilos_pri, skilos_seg, skilos_ter, skilos_des, skilos_total: Real; //Salidas

    procedure InicializarVariables;
    function  InsertarSalidasDesde( const AEmpresa, ACentro, AProducto: string;  const  AKilos, AKilosTotal: Real ): real;
    function  InsertarSalidasHasta( const AEmpresa, ACentro, AProducto: string;  const  AKilosTotal: Real ): Real;
    procedure GrabarKilosSalida( const AEmpresa, ACentro, AProducto: string;  const AKilos: Real = 0 );

    procedure ImportesSalida( const AKilos: Real; var ACajas: integer; var rImporte, rDescuentoFac, rDescuentoNoFac, rAbonos, rEnvasado, rReEnvasado, rGastoNoFac, rGastoFac, rGastoTran, rFinanciero: real );
    function  GetCosteAbonos( const AEmpresa, ACentro, AProducto: string; const AFechaIni, AFechaFin: Real): Real;
    function  CosteEnvasadoEx( const ATipo: string; const AAnyomes: Integer; const AKilos: real ): Real;
    function  CosteEnvasado( const ATipo: string; const AAnyomes: Integer; const AKilos: real ): Real;
    function  CosteEnvasado_PEH( const ATipo: string; const AAnyomes: Integer; const AKilos: real ): Real;
    function  CosteEnvasado_PAP( const ATipo: string; const AAnyomes: Integer; const AKilos: real ): Real;
    function  CostePresupuesto( const ATipo: string; const AKilos: real ): Real;
    procedure GastosAlbaran( const AKilos: Real; var AImpFac, AImpNoFac: real );
    procedure GastosTransitos( const AKilos: Real; var AImporte: real );
    function  CosteFinaciero( const AKilos: real ): real;

    function EsClienteFacurable: Boolean;

  public
    { Public declarations }
    function SalidasSemana( const ACodigo: Integer; const AEmpresa, ACentro, AProducto: string;
                            const ADesde, AHasta: TDateTime; const AStockIni, AKilosTotal: Real; const AFacturado: boolean ): R_KilosSalidas;
    procedure KilosSalidasSemana( const AEmpresa, ACentro, AProducto: string;
                                 const ADesde, AHasta: TDateTime; var AKilosSalidas, AKilosTransitos: real );
  end;

var
  DMLiqProdVendidoSalidas: TDMLiqProdVendidoSalidas;

implementation

{$R *.dfm}

uses
  Math, bTimeUtils, dialogs, UDMMaster, UDMConfig,
  LiqProdErroresUnit, UDMAuxDB, UDMCambioMoneda;

function StrHourToInt( const AHora: string ): Integer;
begin
  result:= StrToIntDef(  StringReplace( AHora, ':', '',[]), 0);
end;

procedure TDMLiqProdVendidoSalidas.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TDMLiqProdVendidoSalidas.DataModuleCreate(Sender: TObject);
begin
  with qryKilosSalidas do
  begin
    SQL.Clear;

    SQL.Add('select sum( kilos_sl ) kilos ');
    SQL.Add('from frf_salidas_c ');
    SQL.Add('     join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl ');
    SQL.Add('                          and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
    if sEmpresa = 'SAT' then
      SQL.Add('where empresa_sc in ( ''050'',''080'' ) ')
    else
      SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('  and centro_salida_sc= :centro ');
    //SQL.Add('  and producto_sl = :producto ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    SQL.Add('  and producto_sl = :producto ');
    SQL.Add('and fecha_sc between :fechaini and :fechafin ');
    SQL.Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion
  end;

  with qryKilosSalida do
  begin
    SQL.Clear;
    SQL.Add('select ');
    //SQL.Add('       sum( case when producto_sl = :producto then kilos_sl else 0 end )  kilos_producto, ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    SQL.Add('       sum( case when ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ) = :producto then kilos_sl else 0 end )  kilos_producto, ');
    SQL.Add('       sum( kilos_sl ) kilos ');
    SQL.Add('from frf_salidas_l ');
    if sEmpresa = 'SAT' then
      SQL.Add('where empresa_sl in ( ''050'',''080'' ) ')
    else
      SQL.Add('where empresa_sl = :empresa ');
    SQL.Add('and centro_salida_sl = :centro ');
    SQL.Add('and fecha_sl = :fecha ');
    SQL.Add('and n_albaran_sl = :albaran ');
  end;

  with qryKilosTransitosOut do
  begin
    Sql.Clear;
    Sql.Add('select sum(kilos_tl ) kilos ');
    Sql.Add('from frf_transitos_c ');
    Sql.Add('     join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
    Sql.Add('                          and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
    if sEmpresa = 'SAT' then
      Sql.Add('where empresa_tl in ( ''050'',''080'' ) ')
    else
      Sql.Add('where empresa_tl = :empresa ');
    Sql.Add(' and centro_tl = :centro ');
    //Sql.Add(' and producto_tl = :producto ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    Sql.Add(' and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto ');
    Sql.Add(' and fecha_tl between :fechaini and :fechafin ');
  end;

  with qryKilosTransito do
  begin
    Sql.Clear;
    Sql.Add('select ');
    //Sql.Add('       sum( case when producto_tl = :producto then kilos_tl else 0 end )  kilos_producto, ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    Sql.Add('       sum( case when ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto then kilos_tl else 0 end )  kilos_producto, ');
    Sql.Add('       sum( kilos_tl ) kilos ');
    Sql.Add('from frf_transitos_l ');
    if sEmpresa = 'SAT' then
      Sql.Add('where empresa_tl in ( ''050'',''080'' ) ')
    else
      Sql.Add('where empresa_tl = :empresa ');
    Sql.Add('and centro_tl = :centro ');
    Sql.Add('and fecha_tl = :fecha ');
    Sql.Add('and referencia_tl = :referencia ');
  end;

  with qrySalidas do
  begin
    SQL.Clear;
    SQL.Add('select ''V'' tipo, frf_salidas_l.rowid, empresa_sl empresa, centro_salida_sl centro_sal, month(fecha_sl) mes, year(fecha_sl) anyo, ');
    SQL.Add('       n_albaran_sl referencia, fecha_sl fecha, hora_sc hora,  cliente_sal_sc cliente, moneda_sc moneda,');
    SQL.Add('       case when nvl(fecha_factura_sc,'''') = '''' then 0 else 1 end facturado, ');
    //SQL.Add('       producto_sl producto, categoria_sl categoria, envase_sl envase, cajas_sl cajas, kilos_sl kilos, ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    SQL.Add('       ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ) producto, categoria_sl categoria, envase_sl envase, cajas_sl cajas, kilos_sl kilos, ');
    if DMConfig.EsLaFont then
    begin
      SQL.Add('       euros(moneda_sc, fecha_sc,importe_neto_sl) importe, ');
      //SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) porc_nofac,  ');
      //SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) porc_fac  ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ), fecha_sl, 0 ) porc_nofac,  ');
      SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ), fecha_sl, 1 ) +  ');
      SQL.Add('         getcomisioncliente( empresa_sl, cliente_sl, fecha_sl ) porc_fac  ');
    end
    else
    begin
      SQL.Add('       0.0 importe, 0.0 porc_nofac, 0.0 porc_fac ');
    end;
    SQL.Add('from frf_salidas_c ');
    SQL.Add('     join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl ');
    SQL.Add('                          and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
    if sEmpresa = 'SAT' then
      SQL.Add('where empresa_sc in ( ''050'',''080'' ) ')
    else
      SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('  and centro_salida_sc= :centro ');
    //SQL.Add('  and producto_sl = :producto ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    SQL.Add('  and ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ) = :producto ');
    SQL.Add('and fecha_sc between :fechaini and :fechafin ');
    SQL.Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion

    Sql.Add('union ');

    Sql.Add('select ''T'' tipo, frf_transitos_l.rowid, empresa_tl empresa, centro_tl centro_sal, month(fecha_tl) mes, year(fecha_tl) anyo, ');
    Sql.Add('       referencia_tl referencia, fecha_tl fecha, nvl(hora_tc,''12:00'') hora, centro_destino_tl cliente, ''EUR'' moneda, 0 facturado,');
    //Sql.Add('       producto_tl producto, categoria_tl categoria, envase_tl envase, cajas_tl cajas, kilos_tl kilos, 0.0 importe, 0.0 porc_nofac, 0.0 porc_fac ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    Sql.Add('       ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) producto, categoria_tl categoria, envase_tl envase, cajas_tl cajas, kilos_tl kilos, 0.0 importe, 0.0 porc_nofac, 0.0 porc_fac ');
    Sql.Add('from frf_transitos_c ');
    Sql.Add('     join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
    Sql.Add('                          and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
    if sEmpresa = 'SAT' then
      Sql.Add('where empresa_tl in ( ''050'',''080'' ) ')
    else
      Sql.Add('where empresa_tl = :empresa ');
    Sql.Add(' and centro_tl = :centro ');
    //Sql.Add(' and producto_tl = :producto ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    Sql.Add(' and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto ');
    Sql.Add(' and fecha_tl between :fechaini and :fechafin ');
    Sql.Add(' order by empresa, centro_sal, mes, anyo, fecha, hora, referencia ');
  end;

  with qryCosteEnvasado do
  begin
    SQL.Clear;

    //SQL.Add(' select ( anyo_ec * 100 ) + mes_ec anyomes, coste_ec + secciones_ec coste_envasado, material_ec coste_material ');
    //PEPE
    SQL.Add(' select coste_ec + secciones_ec coste_envasado, material_ec coste_material ');
    SQL.Add(' from frf_env_costes ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and envase_ec = :envase ');
    SQL.Add(' and centro_ec = :centro ');
    SQL.Add(' and ( anyo_ec * 100 ) + mes_ec = :anyomes');
    //PEPE
    (*SQL.Add(' and ( anyo_ec * 100 ) + mes_ec = ');
    SQL.Add(' ( ');
    SQL.Add('   select max( ( anyo_ec * 100 ) + mes_ec) ');
    SQL.Add('   from frf_env_costes ');
    SQL.Add('   where empresa_ec = :empresa ');
    SQL.Add('   and envase_ec = :envase ');
    SQL.Add('   and centro_ec = :centro ');
    SQL.Add('   and  ( anyo_ec * 100 ) + mes_ec <= :anyomes ');
    SQL.Add(' ) ');
    *)
  end;

  with qryCostePresupuesto do
  begin
    SQL.Clear;
    SQL.Add(' select coste_directo_cap + coste_seccion_cap coste_envasado, coste_material_cap coste_material ');
    SQL.Add(' from frf_costes_agrupa_prod ');
    SQL.Add(' where empresa_cap = :empresa ');
    SQL.Add(' and centro_cap = :centro ');
    SQL.Add(' and :fecha between fecha_ini_cap and nvl(fecha_fin_cap,today) ');
    SQL.Add(' and agrupacion_cap = ( select agrupacion_e  from frf_envases where envase_e = :envase ) ');
    SQL.Add(' and case when producto_cap = ''TOM'' then ''TOM'' else producto_cap end = :producto ');
  end;

  with qryGastoAlbaran do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        sum( case when ( case when producto_g = ''TOM'' then ''TOM'' else producto_g end ) = :producto then ');
    SQL.Add('              case when facturable_tg = ''S'' then importe_g else 0 end ');
    SQL.Add('              else 0 end ) producto_fac, ');
    SQL.Add('        sum( case when ( case when producto_g = ''TOM'' then ''TOM'' else producto_g end ) = :producto then ');
    SQL.Add('              case when facturable_tg = ''N'' then importe_g else 0 end ');
    SQL.Add('              else 0 end ) producto_nofac, ');

    SQL.Add('        sum( case when producto_g is null then ');
    SQL.Add('              case when facturable_tg = ''S'' then importe_g else 0 end ');
    SQL.Add('              else 0 end ) todos_fac, ');
    SQL.Add('        sum( case when producto_g is null then ');
    SQL.Add('              case when facturable_tg = ''N'' then importe_g else 0 end ');
    SQL.Add('              else 0 end ) todos_nofac ');

    SQL.Add(' from frf_gastos ');
    SQL.Add('      join frf_tipo_gastos on tipo_tg = tipo_g ');
    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add(' and centro_salida_g = :centro ');
    SQL.Add(' and fecha_g = :fecha ');
    SQL.Add(' and n_albaran_g = :albaran ');
    //SQL.Add(' and ( ( producto_g = :producto ) or ( producto_g is null ) ) ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    SQL.Add(' and ( ( ( case when producto_g = ''TOM'' then ''TOM'' else producto_g end ) = :producto ) or ( producto_g is null ) ) ');
    SQL.Add(' and gasto_transito_tg = 0 ');
  end;

  with qryGastoTransito do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    //SQL.Add('        sum( case when producto_gt = :producto  then importe_gt else 0 end )  producto, ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    SQL.Add('        sum( case when ( case when producto_gt = ''TOM'' then ''TOM'' else producto_gt end ) = :producto  then importe_gt else 0 end )  producto, ');
    SQL.Add('        sum( case when producto_gt is null then importe_gt else 0 end ) todos ');

    SQL.Add(' from frf_gastos_trans ');
    SQL.Add(' where empresa_gt = :empresa ');
    SQL.Add(' and centro_gt = :centro ');
    SQL.Add(' and fecha_gt = :fecha ');
    SQL.Add(' and referencia_gt = :referencia ');
  end;

end;


procedure TDMLiqProdVendidoSalidas.InicializarVariables;
begin
  iLinea:= 0;

  skilos_pri:= 0;
  skilos_seg:= 0;
  skilos_ter:= 0;
  skilos_des:= 0;
  skilos_total:= 0;
end;

procedure TDMLiqProdVendidoSalidas.KilosSalidasSemana( const AEmpresa, ACentro, AProducto: string; const ADesde, AHasta: TDateTime;
                                                      var AKilosSalidas, AKilosTransitos: real );
begin
  sEmpresa := AEmpresa;

  with qryKilosSalidas do
  begin
    SQL.Clear;
    if ( (AProducto = 'PEH') and (ADesde < STrToDate('01/11/2020') ) ) or
       ( (AProducto = 'PAP') and (ADesde < StrToDate('29/06/2020') ) ) then
//       ((AProducto = 'PAP') and (ADesde >= StrToDate('29/06/2020')) and (ACentro = '6'))) then  //SOLO Para calculo Junio 2020
    begin
      SQL.Add(' select sum( kilos_sl ) kilos ');
      SQL.Add('  from frf_salidas_c ');
      SQL.Add('      join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl ');
      SQL.Add('                                  and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
      SQL.Add(' where empresa_sc[1] = ''F'' ');
      SQL.Add('   and producto_sl = :producto ');
      SQL.Add('   and fecha_sc between :fechaini and :fechafin ');
      SQL.Add('   and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion

      ParamByName('fechaini').AsDateTime:= ADesde;
      ParamByName('fechafin').AsDateTime:= AHasta;
      ParamByName('producto').AsString:= AProducto;
    end
    else if (AProducto = 'PAP') and  ((ADesde >= StrToDate('29/06/2020')) and (ADesde < StrToDate('01/11/2020'))) and (ACentro = '4') then
    begin
      //busco entradas del centro 1 y 4
      SQL.Add('select sum( kilos_sl ) kilos ');
      SQL.Add('from frf_salidas_c ');
      SQL.Add('     join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl ');
      SQL.Add('                          and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
      if sEmpresa = 'SAT' then
        SQL.Add('where empresa_sc in ( ''050'',''080'' ) ')
      else
        SQL.Add('where empresa_sc = :empresa ');
      SQL.Add('  and centro_salida_sc in(1,4) ');
      SQL.Add('  and producto_sl = :producto ');
      SQL.Add('and fecha_sc between :fechaini and :fechafin ');
      SQL.Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion
      if sEmpresa <> 'SAT' then
        ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('fechaini').AsDateTime:= ADesde;
      ParamByName('fechafin').AsDateTime:= AHasta;
      ParamByName('producto').AsString:= AProducto;
    end
    else
    begin
      SQL.Add('select sum(kilos) as kilos from ( ');
      SQL.Add('select sum( kilos_sl ) kilos ');
      SQL.Add('from frf_salidas_c ');
      SQL.Add('     join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl ');
      SQL.Add('                          and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
      if sEmpresa = 'SAT' then
        SQL.Add('where empresa_sc in ( ''050'',''080'' ) ')
      else
        SQL.Add('where empresa_sc = :empresa ');
      SQL.Add('  and centro_salida_sc= :centro ');
      SQL.Add('  and producto_sl = :producto ');
      SQL.Add('and fecha_sc between :fechaini and :fechafin ');
      SQL.Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion

      SQL.Add(' union ');

      SQL.Add(' select sum(kilos_desglose_sl2) kilos from frf_salidas_l2          ');
      if sEmpresa = 'SAT' then
        SQL.Add('where empresa_sl2 in ( ''050'',''080'' ) ')
      else
        SQL.Add(' 		where empresa_sl2 = :empresa                                ');
      SQL.Add(' 		    and centro_salida_sl2 = :centro                           ');
      SQL.Add('         and producto_desglose_sl2 = :producto                     ');
      SQL.Add('         and fecha_sl2 between  :fechaini and :fechafin            ');
      SQL.Add(' ) as x ');

      if sEmpresa <> 'SAT' then
        ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('fechaini').AsDateTime:= ADesde;
      ParamByName('fechafin').AsDateTime:= AHasta;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('producto').AsString:= AProducto;
    end;
    Open;

    AKilosSalidas:= fieldByname('kilos').Asfloat;
    Close;

  end;

  with qryKilosTransitosOut do
  begin
    Sql.Clear;
    Sql.Add('select sum(kilos_tl ) kilos ');
    Sql.Add('from frf_transitos_c ');
    Sql.Add('     join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
    Sql.Add('                          and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
    if sEmpresa = 'SAT' then
      Sql.Add('where empresa_tl in ( ''050'',''080'' ) ')
    else
      Sql.Add('where empresa_tl = :empresa ');
    Sql.Add(' and centro_tl = :centro ');
    //Sql.Add(' and producto_tl = :producto ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    Sql.Add(' and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto ');
    Sql.Add(' and fecha_tl between :fechaini and :fechafin ');

    if sEmpresa <> 'SAT' then
      ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('fechaini').AsDateTime:= ADesde;
    ParamByName('fechafin').AsDateTime:= AHasta;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('producto').AsString:= AProducto;

    Open;
    AKilosTransitos:= fieldByname('kilos').Asfloat;
    Close;
  end;
end;


function TDMLiqProdVendidoSalidas.SalidasSemana(const ACodigo: Integer; const AEmpresa, ACentro, AProducto: string;
                             const ADesde, AHasta: TDateTime; const AStockIni, AKilosTotal: Real; const AFacturado: boolean ): R_KilosSalidas;
var
  i: integer;
  dFechaIni, dFechaFin: TDateTime;
  rAnteriores, rObjetivo: Real;
begin
  InicializarVariables;
  (*TODO Desde primera entrada inclusive - ultima entrada no incluida *)
  if not DMLiqProdVendido.bSoloAjuste  then
    rCosteAbonoSem:= GetCosteAbonos( AEmpresa, ACentro, AProducto, ADesde, AHasta )
  else
    rCosteAbonoSem:= 0;
  rAnteriores:= AStockIni;
  rObjetivo:= AKilosTotal;
  iCodigo:= ACodigo;

  i:= 0;
  while (bRoundTo(skilos_total, 2) < AKilosTotal ) And ( dFechaFin < Now ) do
  begin
    dFechaIni:= ADesde + ( 7 * i );
    dFechaFin:= AHasta + ( 7 * i );

  with qrySalidas do
  begin
    SQL.Clear;
    if ( (AProducto = 'PEH') and (ADesde < STrToDate('01/11/2020') )) or
       ((AProducto = 'PAP') and (ADesde < StrToDate('29/06/2020') )) then
//       ((AProducto = 'PAP') and (ADesde >= StrToDate('29/06/2020')) and (ACentro = '6')) then                 //Solo para Calcular Junio2020
    begin
      SQL.Add('select ''V'' tipo, frf_salidas_l.rowid, empresa_sl empresa, centro_salida_sl centro_sal, month(fecha_sl) mes, year(fecha_sl) anyo, ');
      SQL.Add('       n_albaran_sl referencia, fecha_sl fecha, hora_sc hora,  cliente_sal_sc cliente, moneda_sc moneda,');
      SQL.Add('       case when nvl(fecha_factura_sc,'''') = '''' then 0 else 1 end facturado, ');
      SQL.Add('       producto_sl producto, categoria_sl categoria, envase_sl envase, cajas_sl cajas, kilos_sl kilos, ');
      if DMConfig.EsLaFont then
      begin
        SQL.Add('       euros(moneda_sc, fecha_sc,importe_neto_sl) importe, ');
        SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) porc_nofac,  ');
        SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) +  ');
        SQL.Add('       getcomisioncliente( empresa_sl, cliente_sl, fecha_sl ) porc_fac  ');
      end
      else
      begin
        SQL.Add('       0.0 importe, 0.0 porc_nofac, 0.0 porc_fac ');
      end;
      SQL.Add('from frf_salidas_c  frf_salidas_c');
      SQL.Add('     join frf_salidas_l frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl ');
      SQL.Add('                                and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
      SQL.Add('where empresa_sc[1] = ''F'' ');
      SQL.Add('  and producto_sl = :producto ');
      SQL.Add('and fecha_sc between :fechaini and :fechafin ');
      SQL.Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion

      Sql.Add(' order by empresa, centro_sal, mes, anyo, fecha, hora, referencia ');

      ParamByName('fechaini').AsDateTime:= dFechaIni;
      ParamByName('fechafin').AsDateTime:= dFechaFin;
      ParamByName('producto').AsString:= AProducto;

    end
    else if ((AProducto = 'PAP') and  (ADesde >= StrToDate('29/06/2020')) and (ACentro = '4')) then
    begin
      SQL.Add('select ''V'' tipo, frf_salidas_l.rowid, empresa_sl empresa, centro_salida_sl centro_sal, month(fecha_sl) mes, year(fecha_sl) anyo, ');
      SQL.Add('       n_albaran_sl referencia, fecha_sl fecha, hora_sc hora,  cliente_sal_sc cliente, moneda_sc moneda,');
      SQL.Add('       case when nvl(fecha_factura_sc,'''') = '''' then 0 else 1 end facturado, ');
      //SQL.Add('       producto_sl producto, categoria_sl categoria, envase_sl envase, cajas_sl cajas, kilos_sl kilos, ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      SQL.Add('       producto_sl producto, categoria_sl categoria, envase_sl envase, cajas_sl cajas, kilos_sl kilos, ');
      if DMConfig.EsLaFont then
      begin
        SQL.Add('       euros(moneda_sc, fecha_sc,importe_neto_sl) importe, ');
        //SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) porc_nofac,  ');
        //SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) porc_fac  ');
        //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
        SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ), fecha_sl, 0 ) porc_nofac,  ');
        SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ), fecha_sl, 1 ) +  ');
        SQL.Add('         getcomisioncliente( empresa_sl, cliente_sl, fecha_sl ) porc_fac  ');
      end
      else
      begin
        SQL.Add('       0.0 importe, 0.0 porc_nofac, 0.0 porc_fac ');
      end;
      SQL.Add('from frf_salidas_c ');
      SQL.Add('     join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl ');
      SQL.Add('                          and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
      if sEmpresa = 'SAT' then
        SQL.Add('where empresa_sc in ( ''050'',''080'' ) ')
      else
        SQL.Add('where empresa_sc = :empresa ');
      SQL.Add('  and centro_salida_sc in (1,4) ');
      SQL.Add('  and producto_sl = :producto ');
      SQL.Add('and fecha_sc between :fechaini and :fechafin ');
      SQL.Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion
      if sEmpresa <> 'SAT' then
        ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('fechaini').AsDateTime:= dFechaIni;
      ParamByName('fechafin').AsDateTime:= dFechaFin;
      ParamByName('producto').AsString:= AProducto;
    end
    else
    begin
      SQL.Add('select ''V'' tipo, frf_salidas_l.rowid, empresa_sl empresa, centro_salida_sl centro_sal, month(fecha_sl) mes, year(fecha_sl) anyo, ');
      SQL.Add('       n_albaran_sl referencia, fecha_sl fecha, hora_sc hora,  cliente_sal_sc cliente, moneda_sc moneda,');
      SQL.Add('       case when nvl(fecha_factura_sc,'''') = '''' then 0 else 1 end facturado, ');
      //SQL.Add('       producto_sl producto, categoria_sl categoria, envase_sl envase, cajas_sl cajas, kilos_sl kilos, ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      SQL.Add('       producto_sl producto, categoria_sl categoria, envase_sl envase, cajas_sl cajas, kilos_sl kilos, ');
      if DMConfig.EsLaFont then
      begin
        SQL.Add('       euros(moneda_sc, fecha_sc,importe_neto_sl) importe, ');
        //SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) porc_nofac,  ');
        //SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) porc_fac  ');
        //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
        SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ), fecha_sl, 0 ) porc_nofac,  ');
        SQL.Add('       fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ), fecha_sl, 1 ) +  ');
        SQL.Add('         getcomisioncliente( empresa_sl, cliente_sl, fecha_sl ) porc_fac  ');
      end
      else
      begin
        SQL.Add('       0.0 importe, 0.0 porc_nofac, 0.0 porc_fac ');
      end;
      SQL.Add('from frf_salidas_c ');
      SQL.Add('     join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl ');
      SQL.Add('                          and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
      if sEmpresa = 'SAT' then
        SQL.Add('where empresa_sc in ( ''050'',''080'' ) ')
      else
        SQL.Add('where empresa_sc = :empresa ');
      SQL.Add('  and centro_salida_sc= :centro ');
      SQL.Add('  and producto_sl = :producto ');
      SQL.Add('and fecha_sc between :fechaini and :fechafin ');
      SQL.Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion

      Sql.Add('union ');

      Sql.Add('select ''T'' tipo, frf_transitos_l.rowid, empresa_tl empresa, centro_tl centro_sal, month(fecha_tl) mes, year(fecha_tl) anyo, ');
      Sql.Add('       referencia_tl referencia, fecha_tl fecha, nvl(hora_tc,''12:00'') hora, centro_destino_tl cliente, ''EUR'' moneda, 0 facturado,');
      Sql.Add('       ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) producto, categoria_tl categoria, envase_tl envase, cajas_tl cajas, kilos_tl kilos, 0.0 importe, 0.0 porc_nofac, 0.0 porc_fac ');
      Sql.Add('from frf_transitos_c ');
      Sql.Add('     join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
      Sql.Add('                          and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
      if sEmpresa = 'SAT' then
        Sql.Add('where empresa_tl in ( ''050'',''080'' ) ')
      else
        Sql.Add('where empresa_tl = :empresa ');
      Sql.Add(' and centro_tl = :centro ');
      Sql.Add(' and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto ');
      Sql.Add(' and fecha_tl between :fechaini and :fechafin ');

      SQL.Add(' union ');

      SQL.Add(' select ''V'' tipo, frf_salidas_l.rowid, empresa_sl empresa, centro_salida_sl centro_sal, month(fecha_sl) mes, year(fecha_sl) anyo, ');
      SQL.Add('        n_albaran_sl referencia, fecha_sl fecha, hora_sc hora,  cliente_sal_sc cliente, moneda_sc moneda,                           ');
      SQL.Add('        case when nvl(fecha_factura_sc,'''') = '''' then 0 else 1 end facturado,                                                    ');
      SQL.Add('        producto_desglose_sl2 producto, categoria_sl categoria, envase_sl envase, 0 cajas, kilos_desglose_sl2 kilos,                ');
      SQL.Add('       euros(moneda_sc, fecha_sc,importe_neto_sl*porcentaje_sl2/100) importe,                                                       ');
      SQL.Add('              fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 0 ) porc_nofac,                 ');
      SQL.Add('              fGetPorcenDescuento( empresa_sl, cliente_sl, centro_salida_sl, producto_sl, fecha_sl, 1 ) +                           ');
      SQL.Add('              getcomisioncliente( empresa_sl, cliente_sl, fecha_sl ) porc_fac                                                       ');

      SQL.Add(' from frf_salidas_c                                                                                                                 ');
      SQL.Add('      join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl                                         ');
      SQL.Add('                           and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl                                                  ');
      SQL.Add('      join frf_salidas_l2 on empresa_sl = empresa_sl2 and centro_salida_sl = centro_salida_sl2                                      ');
      SQL.Add('                           and n_albaran_sl = n_albaran_sl2 and fecha_sl = fecha_sl2 and id_linea_albaran_sl = id_linea_albaran_sl2 ');
      if sEmpresa = 'SAT' then
        SQL.Add('where empresa_sc in ( ''050'',''080'' ) ')
      else
        SQL.Add(' where empresa_sc = :empresa                                                                                                        ');
      SQL.Add('   and centro_salida_sc= :centro                                                                                                    ');
      SQL.Add('   and producto_desglose_sl2 = :producto                                                                                            ');
      SQL.Add(' and fecha_sc between :fechaini and :fechafin                                                                                       ');
      Sql.Add(' order by empresa, centro_sal, mes, anyo, fecha, hora, referencia ');

      if sEmpresa <> 'SAT' then
        ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('fechaini').AsDateTime:= dFechaIni;
      ParamByName('fechafin').AsDateTime:= dFechaFin;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('producto').AsString:= AProducto;
    end;

      Open;
      try
        if not IsEmpty then
        begin
          if rAnteriores > 0 then
          begin
            rAnteriores:= InsertarSalidasDesde( AEmpresa, ACentro, AProducto, rAnteriores, rObjetivo );
            if rAnteriores < 0 then
            begin
              rObjetivo:= rObjetivo + rAnteriores;
              rAnteriores:= 0;
            end;
          end;
          if rAnteriores = 0 then
            rObjetivo:= InsertarSalidasHasta( AEmpresa, ACentro, AProducto, rObjetivo );
        end;
      finally
        Close;
      end;
    end;
    Inc( i );
  end;

  Result.rKilosPrimera:= skilos_pri;
  Result.rKilosSegunda:= skilos_seg;
  Result.rKilosTercera:= skilos_ter;
  Result.rKilosDestrio:= skilos_des;
  Result.rKilosTotal:= skilos_total;
end;

function TDMLiqProdVendidoSalidas.InsertarSalidasDesde
( const AEmpresa, ACentro, AProducto: string;  const  AKilos, AKilosTotal: Real ): real;
begin
  result:= AKilos;
  while ( result > 0 ) and ( not qrySalidas.Eof ) do
  begin
    result:= result - qrySalidas.FieldByName('kilos').AsFloat;
    if result >= 0 then
      qrySalidas.Next;
  end;
  if result < 0 then
  begin
    result:= result * -1;
    if result > AKilosTotal then
    begin
      GrabarKilosSalida( AEmpresa, ACentro, AProducto, AKilosTotal  );
      result:= AKilosTotal * -1;
    end
    else
    begin
      GrabarKilosSalida( AEmpresa, ACentro, AProducto, result );
      result:= result * -1;
    end;
    qrySalidas.Next;
  end;
end;

function TDMLiqProdVendidoSalidas.InsertarSalidasHasta( const AEmpresa, ACentro, AProducto: string;  const  AKilosTotal: Real ): real;
begin
  result:= AKilosTotal;

  while ( not qrySalidas.Eof ) and ( result >  0 )  do
  begin
     result:= result - qrySalidas.FieldByName('kilos').AsFloat;
     if result >= 0 then
     begin
       GrabarKilosSalida( AEmpresa, ACentro, AProducto );
       qrySalidas.Next;
     end;
  end;

  if ( not qrySalidas.Eof ) and ( result < 0 ) then
  begin
     result:= result + qrySalidas.FieldByName('kilos').AsFloat;
     GrabarKilosSalida( AEmpresa, ACentro, AProducto, result );
     result:= 0;
  end;
end;


function TDMLiqProdVendidoSalidas.EsClienteFacurable: Boolean;
begin
  (*TODO*)//Comprobar que sea cliente facturable
  result:=  ( Copy(qrySalidas.FieldByName('cliente').AsString,1,1) <> '0' ) and
            ( qrySalidas.FieldByName('cliente').AsString <> 'RET' ) and
            ( qrySalidas.FieldByName('cliente').AsString <> 'REA' ) and
            ( qrySalidas.FieldByName('cliente').AsString <> 'EG' ) and
            ( qrySalidas.FieldByName('cliente').AsString <> 'REP' ) and
            ( qrySalidas.FieldByName('cliente').AsString <> 'BAA' ) and
            ( qrySalidas.FieldByName('cliente').AsString <> 'GAN' ) ;
end;

procedure TDMLiqProdVendidoSalidas.GrabarKilosSalida( const AEmpresa, ACentro, AProducto: string;  const AKilos: Real = 0 );
var
  sAux: string;
  iCajas: integer;
  rKilos, rImporte, rAux: Real;
  rDescuentoNoFac, rDescuentoFac, rAbonos, rEnvasado, rGastoNoFac, rGastoFac,
  rGastoTran, rReEnvasado, rFinanciero, rLiquido: Real;
begin
  if AKilos = 0 then
    rKilos:= qrySalidas.FieldByName('kilos').AsFloat
  else
    rKilos:= AKilos;

  skilos_total:= skilos_total + rKilos;
  if qrySalidas.FieldByName('categoria').AsString = '1' then
  begin
    //Seleccionado/Directos
    skilos_pri:= skilos_pri + rKilos;
    sAux:= '1';
  end
  else
  if qrySalidas.FieldByName('categoria').AsString = '2' then
  begin
    //Industria
    skilos_seg:= skilos_seg + rKilos;
    sAux:= '2';
  end
  else
  if qrySalidas.FieldByName('categoria').AsString = '3' then
  begin
    //Compra
    skilos_ter:= skilos_ter + rKilos;
    sAux:= '3';
  end
  else
  begin
    //Destrio
    skilos_des:= skilos_des + rKilos;
    sAux:= '4';
  end;

  with DMLiqProdVendido do
  begin
    Inc( iLinea );

    kmtSalidas.Insert;
    kmtSalidas.FieldByName('codigo_sal').AsInteger:= iCodigo;
    kmtSalidas.FieldByName('linea_sal').AsInteger:= iLinea;

    if qrySalidas.FieldByName('tipo').AsString = 'T' then
    begin
      kmtSalidas.FieldByName('origen_sal').AsString:= 'T';
      kmtSalidas.FieldByName('facturado_sal').AsInteger:= 0;
    end
    else
    begin
      if EsClienteFacurable then
      begin
        kmtSalidas.FieldByName('origen_sal').AsString:= 'V'; //Venta
        kmtSalidas.FieldByName('facturado_sal').AsInteger:= qrySalidas.FieldByName('facturado').AsInteger;
      end
      else
      begin
        kmtSalidas.FieldByName('origen_sal').AsString:= 'R'; //Rterirada/Botado/Placeros
        kmtSalidas.FieldByName('facturado_sal').AsInteger:= 1;
      end;
    end;

//    kmtSalidas.FieldByName('empresa_sal').AsString:= AEmpresa;
    kmtSalidas.FieldByName('empresa_sal').AsString:= qrySalidas.FieldByName('empresa').AsString;
    kmtSalidas.FieldByName('centro_sal').AsString:= ACentro;
    kmtSalidas.FieldByName('n_salida').AsInteger:= qrySalidas.FieldByName('referencia').AsInteger;
    kmtSalidas.FieldByName('fecha_sal').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
    kmtSalidas.FieldByName('hora_sal').AsInteger:= StrHourToInt( qrySalidas.FieldByName('hora').AsString );

    kmtSalidas.FieldByName('producto_sal').AsString:= AProducto;
    kmtSalidas.FieldByName('destino_sal').AsString:= qrySalidas.FieldByName('cliente').AsString;

    kmtSalidas.FieldByName('envase_sal').AsString:= qrySalidas.FieldByName('envase').AsString;

    kmtSalidas.FieldByName('categoria_sal').AsString:= sAux;
    kmtSalidas.FieldByName('kilos_sal').AsFloat:= rKilos;

    if DMLiqProdVendido.bSoloAjuste then
    begin
      iCajas:= 0;
      rImporte:= 0;
      rDescuentoFac:= 0;
      rDescuentoNoFac:= 0;
      rAbonos:= 0;
      rEnvasado:= 0;
      rReEnvasado:= 0;
      rGastoNoFac:= 0;
      rGastoFac:= 0;
      rGastoTran:= 0;
      rFinanciero:= 0;
      rLiquido:= 0;
    end
    else
    begin
      ImportesSalida( rKilos, iCajas, rImporte, rDescuentoFac, rDescuentoNoFac, rAbonos, rEnvasado, rReEnvasado, rGastoNoFac, rGastoFac, rGastoTran, rFinanciero );
      rLiquido:= rImporte - ( rDescuentoFac + rDescuentoNoFac + rAbonos + rEnvasado + rReEnvasado + rGastoNoFac + rGastoFac + rGastoTran + rFinanciero );
    end;

    kmtSalidas.FieldByName('cajas_sal').AsFloat:= iCajas;
    kmtSalidas.FieldByName('importe_sal').AsFloat:= rImporte;
    kmtSalidas.FieldByName('descuentos_fac_sal').AsFloat:= rDescuentoFac;
    kmtSalidas.FieldByName('descuentos_nofac_sal').AsFloat:= rDescuentoNoFac;
    kmtSalidas.FieldByName('costes_abonos_sal').AsFloat:= rAbonos;
    kmtSalidas.FieldByName('costes_sec_transito_sal').AsFloat:= rReEnvasado;
    kmtSalidas.FieldByName('gastos_transito_sal').AsFloat:= rGastoTran;
    kmtSalidas.FieldByName('costes_envasado_sal').AsFloat:= rEnvasado;
    kmtSalidas.FieldByName('gastos_nofac_sal').AsFloat:= rGastoNoFac;
    kmtSalidas.FieldByName('gastos_fac_sal').AsFloat:= rGastoFac;
    kmtSalidas.FieldByName('costes_financiero_sal').AsFloat:= rFinanciero;
    kmtSalidas.FieldByName('liquido_sal').AsFloat:= rLiquido;

    kmtSalidas.Post;
  end;
end;

procedure TDMLiqProdVendidoSalidas.ImportesSalida( const AKilos: Real; var ACajas: integer; var rImporte, rDescuentoFac, rDescuentoNoFac, rAbonos, rEnvasado, rReEnvasado, rGastoNoFac, rGastoFac, rGastoTran, rFinanciero: real );
begin
  rImporte:= 0;
  rDescuentoFac:= 0;
  rDescuentoNoFac:= 0;
  rAbonos:= 0;
  rEnvasado:= 0;
  rReEnvasado:= 0;
  rGastoNoFac:= 0;
  rGastoFac:= 0;
  rGastoTran:= 0;
  rFinanciero:= 0;

  with DMLiqProdVendido  do
  begin
    if  qrySalidas.FieldByName('kilos').AsFloat <> 0 then
    begin
      if qrySalidas.FieldByName('kilos').AsFloat = AKilos then
      begin
        rImporte:= qrySalidas.FieldByName('importe').AsFloat;
        ACajas:= qrySalidas.FieldByName('cajas').AsInteger;
      end
      else
      begin
        rImporte:= RoundTo( ( qrySalidas.FieldByName('importe').AsFloat * AKilos ) /  qrySalidas.FieldByName('kilos').AsFloat, -2 );
        ACajas:= Trunc( ( qrySalidas.FieldByName('cajas').AsInteger * AKilos ) /  qrySalidas.FieldByName('kilos').AsFloat );
      end;

      rDescuentoFac:= RoundTo( rImporte * ( qrySalidas.FieldByName('porc_fac').AsFloat / 100 ), -2);
      rAbonos:= RoundTo( rCosteAbonoSem * AKilos * -1, -2 );



      if DMConfig.EsLaFont then
      begin
        if kmtSalidas.FieldByName('origen_sal').AsString = 'T' then
        begin
          if kmtSalidas.FieldByName('centro_sal').AsString = '6' then       // 10/03/2020 - Para ejercicio 2020-2021, los coste_envasado+coste_seccion del centro 6, no se incluyen en la liquidacion, puesto que ya esta calculado en las salidas. Sino, se duplica importes.
            rReEnvasado := 0
          else
            rReEnvasado:= RoundTo( CosteEnvasadoEx( 'T',( ( qrySalidas.FieldByName('anyo').AsInteger * 100 ) + qrySalidas.FieldByName('mes').AsInteger ), AKilos ), -2 );

          GastosTransitos( AKilos, rGastoTran );
          rEnvasado:= 0;
          rGastoFac:= 0;
          rGastoNoFac:= 0;
        end
        else
        begin
          GastosAlbaran( AKilos, rGastoFac, rGastoNoFac );
          rEnvasado:= RoundTo( CosteEnvasadoEx( 'V', ( ( qrySalidas.FieldByName('anyo').AsInteger * 100 ) + qrySalidas.FieldByName('mes').AsInteger ), AKilos ), -2 );
          rGastoTran:= 0;
          rReEnvasado:= 0;
        end;
        rDescuentoNoFac:= RoundTo( ( rImporte - ( rDescuentoFac + rGastoFac ) ) * ( qrySalidas.FieldByName('porc_nofac').AsFloat / 100 ), -2);

        if kmtSalidas.FieldByName('origen_sal').AsString = 'V' then
        begin
          if ( qrySalidas.FieldByName('categoria').AsString = '1' ) or ( qrySalidas.FieldByName('categoria').AsString = '2' ) then
          begin
            rFinanciero:= CosteFinaciero( AKilos );
          end
          else
          begin
            rFinanciero:= 0;
          end;
        end;
      end
      else
      begin
          rEnvasado:= 0;
          rGastoFac:= 0;
          rGastoNoFac:= 0;
          rGastoTran:= 0;
          rReEnvasado:= 0;
          rFinanciero:= 0;
      end;
    end;
  end;
end;

function TDMLiqProdVendidoSalidas.GetCosteAbonos( const AEmpresa, ACentro, AProducto: string;  const AFechaIni, AFechaFin: Real): Real;
var
  rAbonosSem,  rKilosSalProSem: Real; //rKilosSalTotSem,
  rKilosTraProSem: Real; //rKilosTraTotSem,
begin
  (*TODO*)
  //Rango de fechas de abonos, �cual debe ser?
  //Semana a liquidar, dias de los que pillo salidas?
//  with UDMMaster.DMMaster.qryAux do
  with qryAux do
  begin
    SQL.Clear;
    if ( (AProducto = 'PEH') and (AFechaini < STrToDate('01/11/2020')  ))  or
       ((AProducto = 'PAP') and (AFechaini < StrToDate('29/06/2020'))) then
//       ((AProducto = 'PAP') and (AFechaIni >= StrToDate('29/06/2020')) and (ACentro = '6'))) then   //SOLO para Calculo Junio 2020
    begin
      SQL.Add('select sum(importe_neto_fd) importe');
      SQL.Add('from tfacturas_cab ');
      SQL.Add('     join  tfacturas_det on cod_factura_fc = cod_factura_fd ');
      SQL.Add('     join comerbag::frf_salidas_c on cod_empresa_albaran_fd = empresa_sc ');
      SQL.Add('                       and cod_centro_albaran_fd = centro_salida_sc ');
      SQL.Add('               	      and n_albaran_fd = n_albaran_sc ');
      SQL.Add('       	 	            and fecha_albaran_fd = fecha_sc ');
      SQL.Add('                       and es_transito_sc <> 2 ');                //Tipo Salida: Devolucion
//      SQL.Add('where cod_empresa_fac_fc[1] = ''F'' ');                    //Modificado por Carmen 22/09/2020 debe cogerse los abonos relacionados a los albaranes
//    SQL.Add('and fecha_factura_fc between :fechaini and :fechafin ');     //Modificado por Carmen 22/09/2020 debe cogerse los abonos relacionados a los albaranes
      SQL.Add('where cod_empresa_albaran_fd[1] = ''F'' ');
      SQL.Add('and fecha_albaran_fd between :fechaini and :fechafin ');
      SQL.Add('and anulacion_fc = 0 ');
      SQL.Add('and automatica_fc = 0 ');
      SQL.Add('and cod_producto_fd = :producto ');

      ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
      ParamByName('producto').AsString:= AProducto;
    end
    else if ((AProducto = 'PAP') and  (AFechaIni >= StrToDate('29/06/2020')) and (ACentro = '4')) then
    begin
      SQL.Add('select sum(importe_neto_fd) importe');
      SQL.Add('from tfacturas_cab ');
      SQL.Add('     join  tfacturas_det on cod_factura_fc = cod_factura_fd ');
      SQL.Add('     join frf_salidas_c on cod_empresa_albaran_fd = empresa_sc ');
      SQL.Add('                       and cod_centro_albaran_fd = centro_salida_sc ');
      SQL.Add('               	      and n_albaran_fd = n_albaran_sc ');
      SQL.Add('       	 	            and fecha_albaran_fd = fecha_sc ');
      SQL.Add('                       and es_transito_sc <> 2 ');                //Tipo Salida: Devolucion
      if AEmpresa = 'SAT' then
        SQL.Add('where cod_empresa_albaran_fd in ( ''050'',''080'' ) ')
      else
        SQL.Add('where cod_empresa_albaran_fd = :empresa ');
      SQL.Add('and fecha_albaran_fd between :fechaini and :fechafin ');
      SQL.Add('and anulacion_fc = 0 ');
      SQL.Add('and automatica_fc = 0 ');
      SQL.Add('and cod_producto_fd = :producto ');
      SQL.Add('and cod_centro_albaran_fd in (1,4) ');
      if AEmpresa <> 'SAT' then
        ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
      ParamByName('producto').AsString:= AProducto;
    end
    else
    begin
      SQL.Add(' select sum(importe) as importe from (    ');
      SQL.Add('select sum(importe_neto_fd) importe');
      SQL.Add('from tfacturas_cab ');
      SQL.Add('     join  tfacturas_det on cod_factura_fc = cod_factura_fd ');
      SQL.Add('     join frf_salidas_c on cod_empresa_albaran_fd = empresa_sc ');
      SQL.Add('                       and cod_centro_albaran_fd = centro_salida_sc ');
      SQL.Add('               	      and n_albaran_fd = n_albaran_sc ');
      SQL.Add('       	 	            and fecha_albaran_fd = fecha_sc ');
      SQL.Add('                       and es_transito_sc <> 2 ');                //Tipo Salida: Devolucion
      if AEmpresa = 'SAT' then
        SQL.Add('where cod_empresa_albaran_fd in ( ''050'',''080'' ) ')
      else
        SQL.Add('where cod_empresa_albaran_fd = :empresa ');
      SQL.Add('and fecha_albaran_fd between :fechaini and :fechafin ');
      SQL.Add('and anulacion_fc = 0 ');
      SQL.Add('and automatica_fc = 0 ');
      SQL.Add('and cod_producto_fd = :producto ');
      SQL.Add('and cod_centro_albaran_fd = :centro ');

      SQL.Add(' union ');

      SQL.Add('select sum(importe_neto_fd * porcentaje_sl2/100) importe                ');
      SQL.Add('from tfacturas_cab                                                      ');
      SQL.Add('     join  tfacturas_det on cod_factura_fc = cod_factura_fd             ');
      SQL.Add('     join frf_salidas_c on cod_empresa_albaran_fd = empresa_sc          ');
      SQL.Add('                       and cod_centro_albaran_fd = centro_salida_sc     ');
      SQL.Add('               	      and n_albaran_fd = n_albaran_sc                  ');
      SQL.Add('       	 	            and fecha_albaran_fd = fecha_sc                  ');
      SQL.Add('                       and es_transito_sc <> 2                          ');
      SQL.Add('     join frf_salidas_l on empresa_sl = empresa_sc                      ');
      SQL.Add('                       and centro_salida_sl = centro_salida_sc          ');
      SQL.Add('                       and n_albaran_sl = n_albaran_sc                  ');
      SQL.Add('                       and fecha_sl = fecha_sc                          ');
      SQL.Add('    join frf_salidas_l2 on empresa_sl = empresa_sl2                     ');
      SQL.Add('			                  and centro_salida_sl = centro_salida_sl2         ');
      SQL.Add('                       and n_albaran_sl = n_albaran_sl2                 ');
      SQL.Add('		                  	and fecha_sl = fecha_sl2                         ');
      SQL.Add('                       and frf_salidas_l.rowid = id_linea_albaran_sl2   ');
      if AEmpresa = 'SAT' then
        SQL.Add('where cod_empresa_albaran_fd in ( ''050'',''080'' ) ')
      else
        SQL.Add('where cod_empresa_albaran_fd = :empresa                                     ');
      SQL.Add('and fecha_albaran_fd between :fechaini and :fechafin                    ');
      SQL.Add('and anulacion_fc = 0                                                    ');
      SQL.Add('and automatica_fc = 0                                                   ');
      SQL.Add('and producto_desglose_sl2 = :producto                                   ');
      SQL.Add('and cod_centro_albaran_fd = :centro                                     ');
      SQL.Add(' ) as x ');

      if AEmpresa <> 'SAT' then
        ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('producto').AsString:= AProducto;
    end;


    Open;
    rAbonosSem:= FieldByName('importe').AsFloat;
    Close;
  end;

  with qryAux do
  begin
    SQL.Clear;
    if ( (AProducto = 'PEH') and (AFechaini < STrToDate('01/11/2020') ) ) or
       ((AProducto = 'PAP') and  (AFechaini < StrToDate('29/06/2020'))) then
//       ((AProducto = 'PAP') and (AFechaIni >= StrToDate('29/06/2020')) and (ACentro = '6')) then    //SOLO para calculo Junio 2020
    begin
      SQL.Add('select ');
      SQL.Add('       sum( case when producto_sl = :producto then kilos_sl else 0 end )  kilos_producto, ');
      SQL.Add('       sum( kilos_sl ) kilos ');
      SQL.Add('from comerbag::frf_salidas_c, comerbag::frf_salidas_l ');
      SQL.Add('where empresa_sl[1] = ''F'' ');
      SQL.Add('and fecha_sl between :fechaini and :fechafin ');

      SQL.Add(' and empresa_sc = empresa_sl ');
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      SQL.Add(' and n_albaran_sc = n_albaran_sl ');
      SQL.Add(' and fecha_sc = fecha_sl ');
      SQL.Add(' and es_transito_sc <> 2 ');               //Tipo Salida: Devolucion


      ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
      ParamByName('producto').AsString:= AProducto;
    end
    else if ((AProducto = 'PAP') and  (AFechaini >= StrToDate('29/06/2020')) and (ACentro = '4')) then
    begin
          SQL.Add('select ');
      SQL.Add('       sum( case when producto_sl = :producto then kilos_sl else 0 end )  kilos_producto ');
//      SQL.Add('       sum( kilos_sl ) kilos ');
      SQL.Add('from frf_salidas_c, frf_salidas_l ');
      if AEmpresa = 'SAT' then
        SQL.Add('where empresa_sl in ( ''050'',''080'' ) ')
      else
        SQL.Add('where empresa_sl = :empresa ');
      SQL.Add('and centro_salida_sl in(1,4) ');
      SQL.Add('and fecha_sl between :fechaini and :fechafin ');

      SQL.Add(' and empresa_sc = empresa_sl ');
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      SQL.Add(' and n_albaran_sc = n_albaran_sl ');
      SQL.Add(' and fecha_sc = fecha_sl ');
      SQL.Add(' and es_transito_sc <> 2 ');               //Tipo Salida: Devolucion
      if AEmpresa <> 'SAT' then
        ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
      ParamByName('producto').AsString:= AProducto;
    end
    else
    begin
      SQL.Add(' select sum(kilos_producto) as kilos_producto from( ');

      SQL.Add('select ');
      SQL.Add('       sum( case when producto_sl = :producto then kilos_sl else 0 end )  kilos_producto ');
//      SQL.Add('       sum( kilos_sl ) kilos ');
      SQL.Add('from frf_salidas_c, frf_salidas_l ');
      if AEmpresa = 'SAT' then
        SQL.Add('where empresa_sl in ( ''050'',''080'' ) ')
      else
        SQL.Add('where empresa_sl = :empresa ');
      SQL.Add('and centro_salida_sl = :centro ');
      SQL.Add('and fecha_sl between :fechaini and :fechafin ');

      SQL.Add(' and empresa_sc = empresa_sl ');
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      SQL.Add(' and n_albaran_sc = n_albaran_sl ');
      SQL.Add(' and fecha_sc = fecha_sl ');
      SQL.Add(' and es_transito_sc <> 2 ');               //Tipo Salida: Devolucion

      SQL.Add(' union                                                  ');

      SQL.Add(' select                                                 ');
      SQL.Add('        sum( kilos_desglose_sl2 )  kilos_producto       ');
      SQL.Add(' from frf_salidas_c, frf_salidas_l, frf_salidas_l2      ');
      if AEmpresa = 'SAT' then
        SQL.Add('where empresa_sl in ( ''050'',''080'' ) ')
      else
        SQL.Add(' where empresa_sl = :empresa                            ');
      SQL.Add(' and centro_salida_sl = :centro                         ');
      SQL.Add(' and fecha_sl between :fechaini and :fechafin           ');

      SQL.Add('  and empresa_sc = empresa_sl                            ');
      SQL.Add('  and centro_salida_sc = centro_salida_sl                ');
      SQL.Add('  and n_albaran_sc = n_albaran_sl                        ');
      SQL.Add('  and fecha_sc = fecha_sl                                ');

      SQL.Add('  and empresa_sl = empresa_sl2                             ');
      SQL.Add('  and centro_salida_sl = centro_salida_sl2                 ');
      SQL.Add('  and n_albaran_sl = n_albaran_sl2                         ');
      SQL.Add('  and fecha_sl = fecha_sl2                                 ');
      SQL.Add('  and id_linea_albaran_sl = id_linea_albaran_sl2            ');
      SQL.Add('  and producto_desglose_sl2 = :producto                    ');
      SQL.Add(' ) as x ');


      if AEmpresa <> 'SAT' then
        ParamByName('empresa').AsString:= AEmpresa;
        ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('producto').AsString:= AProducto;
    end;

    Open;
    rKilosSalProSem:= FieldByName('kilos_producto').AsFloat;
    Close;
  end;

  with qryAux do
  begin
    Sql.Clear;
    Sql.Add('select ');
    Sql.Add('       sum( case when ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto then kilos_tl else 0 end )  kilos_producto, ');
    Sql.Add('       sum( kilos_tl ) kilos ');
    Sql.Add('from frf_transitos_l ');
    if AEmpresa = 'SAT' then
      Sql.Add('where empresa_tl in ( ''050'',''080'' ) ')
    else
      Sql.Add('where empresa_tl = :empresa ');
    Sql.Add('and centro_tl = :centro ');
    Sql.Add('and fecha_tl between :fechaini and :fechafin ');

    if AEmpresa <> 'SAT' then
      ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('producto').AsString:= AProducto;

    Open;
    rKilosTraProSem:= FieldByName('kilos_producto').AsFloat;
    Close;
  end;

  if rKilosSalProSem + rKilosTraProSem > 0 then
  begin
    Result:= rAbonosSem / ( rKilosSalProSem + rKilosTraProSem );
  end
  else
  begin
    Result:= 0;
  end;
end;

function Agrupacion( AEmpresa, AEnvase: string): string;
begin

  UDMAuxDB.DMAuxDB.QAux.sql.Clear;
  UDMAuxDB.DMAuxDB.QAux.sql.Add(' select nvl(agrupacion_e,envase_e) agrupa from frf_envases where envase_e = :envase ');
  UDMAuxDB.DMAuxDB.QAux.ParamByName('envase').AsString:= AEnvase;
  UDMAuxDB.DMAuxDB.QAux.OpeN;
  try
    result:= UDMAuxDB.DMAuxDB.QAux.FieldByName('agrupa').AsString;
  finally
    UDMAuxDB.DMAuxDB.QAux.Close;
  end;
end;

function TDMLiqProdVendidoSalidas.CosteEnvasadoEx( const ATipo: string; const AAnyomes: Integer; const AKilos: real ): Real;
begin
  if ((qrySalidas.FieldByName('producto').AsString = 'PEH') and ( qrySalidas.FieldByName('fecha').AsDateTime < StrToDate('01/11/2020')) and (qrySalidas.FieldByName('centro_sal').AsString = '6'))  then
    result:= CosteEnvasado_PEH( ATipo, AAnyomes, AKilos )
  else
    if ((qrySalidas.FieldByName('producto').AsString = 'PAP') and ( qrySalidas.FieldByName('fecha').AsDateTime < StrToDate('29/06/2020')) and (qrySalidas.FieldByName('centro_sal').AsString = '6') ) then
      result:= CosteEnvasado_PAP( ATipo, AAnyomes, AKilos )
    else
      result:= CosteEnvasado( ATipo, AAnyomes, AKilos );

  if result = -1 then
  begin
     (*
        result:= 0;
        PutError( kelNoCosteEnvasado, qrySalidas.FieldByName('envase').AsString + ' -> ' +
        Agrupacion(qrySalidas.FieldByName('empresa').AsString, qrySalidas.FieldByName('envase').AsString ) );
     *)
//PEPE
    if LiqProdVendidoDM.DMLiqProdVendido.bUsarPresupuesto then
    begin
      result:= CostePresupuesto( ATipo, AKilos );
      if result = -1  then
      begin
        result:= 0;
        PutError( kelNoCosteEnvasado, qrySalidas.FieldByName('envase').AsString + ' -> ' +
        Agrupacion(qrySalidas.FieldByName('empresa').AsString, qrySalidas.FieldByName('envase').AsString ) );

      end;
    end
    else
    begin
      result:= 0;
      PutError( kelNoCostePresupuesto, qrySalidas.FieldByName('envase').AsString  );
    end;
  end;
end;


function TDMLiqProdVendidoSalidas.CosteEnvasado( const ATipo: string; const AAnyomes: Integer; const AKilos: real ): Real;
begin
  with qryCosteEnvasado do
  begin
      SQL.Clear;
      SQL.Add(' select coste_ec + secciones_ec coste_envasado, material_ec coste_material ');
      SQL.Add(' from frf_env_costes  ');
      SQL.Add(' where empresa_ec = :empresa ');
      SQL.Add(' and envase_ec = :envase ');
      SQL.Add(' and centro_ec = :centro ');
      SQL.Add(' and ( anyo_ec * 100 ) + mes_ec = :anyomes');

      ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
      ParamByName('anyomes').AsInteger:= AAnyomes;

      ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
      ParamByName('envase').AsString:= qrySalidas.FieldByName('envase').AsString;
      Open;
      try
        if not isEmpty then
        begin
          if ATipo = 'T' then
          begin
            result:= RoundTo( AKilos * FieldByName('coste_envasado').AsFloat, -2 );
          end
          else
          begin
            result:= RoundTo( AKilos * ( FieldByName('coste_material').AsFloat + FieldByName('coste_envasado').AsFloat ), -2 ) ;
          end;
        end
        else
        begin
          result:= -1;
        end;
      finally
        Close;
      end;
  end;
end;

function TDMLiqProdVendidoSalidas.CosteEnvasado_PAP(const ATipo: string;
  const AAnyomes: Integer; const AKilos: real): Real;
  var iCosteEnvasado, iCosteMaterial, iCosteBag: currency;
  sAnyoMes, sAnyo, sMes: String;
begin
  with qryCosteEnvasado do
  begin
      if qrySalidas.FieldByName('producto').AsString = 'PAP' then
      begin
        //coste Envasado + Coste seccion   SAT
        SQL.Clear;
          SQL.Add(' select c1.coste_ec + c1.secciones_ec coste_envasado     ');
          SQL.Add(' from frf_env_costes c1                                  ');
          SQL.Add(' where c1.empresa_ec = :empresa ');
          SQL.Add(' and c1.centro_ec = :centro_sal ');
          SQL.Add(' and c1.producto_ec = :producto ');
          SQL.Add(' and c1.envase_ec = (select min(envase_ec) from frf_env_costes c2   ');
          SQL.Add(' 	                   where c1.empresa_ec = c2.empresa_ec           ');
          SQL.Add(' 			                 and c1.centro_ec = c2.centro_ec             ');
          SQL.Add(' 			                 and c1.producto_ec = c2.producto_ec         ');
          SQL.Add('                        and c1.anyo_ec = c2.anyo_ec                 ');
          SQL.Add('                        and c1.mes_ec = c2.mes_ec                   ');
          SQL.Add(' 			                 and c2.coste_ec <> 0)                       ');
          SQL.Add(' and ( c1.anyo_ec * 100 ) + c1.mes_ec = :anyomes                    ');

        if YearOF(qrySalidas.fieldbyname('fecha').AsDateTime) <= 2018 then
          ParamByName('empresa').AsString:= '080'
        else
          ParamByName('empresa').AsString:= '050';
        ParamByName('anyomes').AsInteger:= AAnyomes;
        ParamByName('centro_sal').AsString:= '6';
        ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
      end
      else
      begin
        SQL.Clear;
        SQL.Add(' select coste_ec + secciones_ec coste_envasado, material_ec coste_material ');
        SQL.Add(' from frf_env_costes ');
        SQL.Add(' where empresa_ec = :empresa ');
        SQL.Add(' and envase_ec = :envase ');
        SQL.Add(' and centro_ec = :centro ');
        SQL.Add(' and ( anyo_ec * 100 ) + mes_ec = :anyomes');

        ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
        ParamByName('anyomes').AsInteger:= AAnyomes;
        ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
        ParamByName('envase').AsString:= qrySalidas.FieldByName('envase').AsString;
      end;
      Open;
      try
        if not isEmpty then
        begin
          iCosteEnvasado := FieldByName('coste_envasado').AsFloat;

          // Coste Material - MEDIA  SAT
          SQL.Clear;
          SQL.Add(' select sum(material_ec) / count(material_ec) coste_material  ');
          SQL.Add(' from frf_env_costes                                          ');
          SQL.Add(' where empresa_ec = :empresa                                  ');
          SQL.Add(' and centro_ec = :centro                                      ');
          SQL.Add(' and producto_ec = :producto                                  ');
          SQL.Add(' and ( anyo_ec * 100 ) + mes_ec = :anyomes                    ');
          SQL.Add(' and material_ec <> 0                                         ');

        if YearOF(qrySalidas.fieldbyname('fecha').AsDateTime) <= 2018 then
            ParamByName('empresa').AsString:= '080'
          else
            ParamByName('empresa').AsString:= '050';
          ParamByName('anyomes').AsInteger:= AAnyomes;
          ParamByName('centro').AsString:= '6';
          ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;

          Open;
          iCosteMaterial := FieldByName('coste_material').AsFloat;

          if qrySalidas.FieldByName('empresa').AsString = 'F17' then
          begin
          //Coste envasado + seccion + material BAG
          sAnyoMes := IntToStr(AAnyomes);
          sAnyo := Copy(sAnyoMes,1,4);
          sMes := Copy(sAnyoMes,5,6);
          SQL.Clear;
          SQL.Add(' select first 1 material_ec + personal_ec + general_ec  coste_bag                                                          ');
          SQL.Add(' from comerbag::frf_env_costes                                                                                             ');
          SQL.Add(' where empresa_ec = :empresa                                                                                               ');
          SQL.Add(' and envase_ec = :envase                                                                                                   ');
          SQL.Add(' and producto_ec = :producto                                                                                               ');
          SQL.Add(' and centro_ec = :centro                                                                                                   ');
          SQL.Add(' and ( ( anyo_ec = :anyo and mes_ec <= :mes ) or ( anyo_ec < :anyo) )                                                      ');
          SQL.Add(' order by anyo_ec desc, mes_ec desc                                                                                        ');


          ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
          ParamByName('anyo').AsInteger:= StrToInt(sAnyo);
          ParamByName('mes').AsInteger:= StrToInt(sMes);
          ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
          ParamByName('envase').AsString:= qrySalidas.FieldByName('envase').AsString;
          ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;

          Open;

          if not isEmpty then
            iCosteBag := fieldbyname('coste_bag').AsFloat
          else
            iCosteBag := 0;
          end
          else
            iCosteBag := 0;

          if ATipo = 'T' then
          begin
            result:= RoundTo( AKilos * iCosteEnvasado, -2 );
          end
          else
          begin
            result:= RoundTo( AKilos * ( iCosteEnvasado  + iCosteMaterial + iCosteBag), -2 ) ;
          end;
        end
        else
        begin
          result:= -1;
        end;
      finally
        Close;
      end;
  end;
end;

function TDMLiqProdVendidoSalidas.CosteEnvasado_PEH( const ATipo: string; const AAnyomes: Integer; const AKilos: real ): Real;
begin
  with qryCosteEnvasado do
  begin
      if qrySalidas.FieldByName('producto').AsString = 'PEH' then
      begin
        SQL.Clear;
        SQL.Add(' select personal_ec + general_ec coste_envasado, material_ec coste_material ');
        SQL.Add(' from comerbag::frf_env_costes ');
        SQL.Add(' where empresa_ec = :empresa ');
        SQL.Add(' and envase_ec = :envase ');
        SQL.Add(' and centro_ec = :centro ');
        SQL.Add(' and ( anyo_ec * 100 ) + mes_ec = :anyomes');

        ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
        ParamByName('anyomes').AsInteger:= AAnyomes;
        ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
        ParamByName('envase').AsString:= qrySalidas.FieldByName('envase').AsString;
      end
      else
      begin
        SQL.Clear;
        SQL.Add(' select coste_ec + secciones_ec coste_envasado, material_ec coste_material ');
        SQL.Add(' from frf_env_costes ');
        SQL.Add(' where empresa_ec = :empresa ');
        SQL.Add(' and envase_ec = :envase ');
        SQL.Add(' and centro_ec = :centro ');
        SQL.Add(' and ( anyo_ec * 100 ) + mes_ec = :anyomes');

        ParamByName('empresa').AsString:= '080';
        ParamByName('anyomes').AsInteger:= AAnyomes;

        ParamByName('centro').AsString:= '6';
        ParamByName('envase').AsString:= qrySalidas.FieldByName('envase').AsString;
      end;
      Open;
      try
        if not isEmpty then
        begin
          if ATipo = 'T' then
          begin
            result:= RoundTo( AKilos * FieldByName('coste_envasado').AsFloat, -2 );
          end
          else
          begin
            result:= RoundTo( AKilos * ( FieldByName('coste_material').AsFloat + FieldByName('coste_envasado').AsFloat ), -2 ) ;
          end;
        end
        else
        begin
          result:= -1;
        end;
      finally
        Close;
      end;
  end;
end;


function TDMLiqProdVendidoSalidas.CostePresupuesto( const ATipo: string; const AKilos: real ): Real;
begin
  with qryCostePresupuesto do
  begin
      if (qrySalidas.FieldByName('producto').AsString = 'PAP') or
         (qrySalidas.FieldByName('producto').AsString = 'PEH') then
      begin
        if YearOF(qrySalidas.fieldbyname('fecha').AsDateTime) <= 2018 then
            ParamByName('empresa').AsString:= '080'
          else
            ParamByName('empresa').AsString:= '050';
        ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
        ParamByName('centro').AsString:= '6';
        ParamByName('envase').AsString:= qrySalidas.FieldByName('envase').AsString;
        ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
      end
      else
      begin
        ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
        ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
        ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
        ParamByName('envase').AsString:= qrySalidas.FieldByName('envase').AsString;
        ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
      end;
      Open;
      try
        if not isEmpty then
        begin
          if ATipo = 'T' then
          begin
            result:= RoundTo( AKilos * FieldByName('coste_envasado').AsFloat, -2 );
          end
          else
          begin
            result:= RoundTo( AKilos * ( FieldByName('coste_material').AsFloat + FieldByName('coste_envasado').AsFloat ), -2 ) ;
          end;
        end
        else
        begin
          result:= -1;
        end;
      finally
        Close;
      end;
  end;
end;

procedure TDMLiqProdVendidoSalidas.GastosAlbaran( const AKilos: Real; var AImpFac, AImpNoFac: real );
var
  rKilos_producto, rKilos: Real;
  rProducto_fac, rProducto_nofac, rTodos_fac, rTodos_nofac: Real;
begin
  with qryKilosSalida do
  begin
    SQL.Clear;
    if ((qrySalidas.FieldByName('producto').AsString = 'PEH') and  (qrySalidas.FieldByName('fecha').AsDateTime < StrToDate('01/11/2020'))) or
       ((qrySalidas.FieldByName('producto').AsString = 'PAP') and  (qrySalidas.FieldByName('fecha').AsDateTime < StrToDate('29/06/2020'))) then
//       ((qrySalidas.FieldByName('producto').AsString = 'PAP') and (qrySalidas.FieldByName('fecha').AsDateTime >= StrToDate('29/06/2020')) and (qrySalidas.FieldByName('centro_sal').AsString = '6'))) then    //SOLO para Calculo Junio 2020
    begin
      SQL.Add('select ');
      SQL.Add('       sum( case when producto_sl = :producto then kilos_sl else 0 end )  kilos_producto, ');
      SQL.Add('       sum( kilos_sl ) kilos ');
      SQL.Add('from comerbag::frf_salidas_l ');
      SQL.Add('where empresa_sl = :empresa ');
      SQL.Add('and centro_salida_sl = :centro ');
      SQL.Add('and fecha_sl = :fecha ');
      SQL.Add('and n_albaran_sl = :albaran ');

      ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
      ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
      ParamByName('albaran').AsInteger:= qrySalidas.FieldByName('referencia').AsInteger;
      ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
      ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
    end
    else if ((qrySalidas.FieldByName('producto').AsString = 'PAP') and (qrySalidas.FieldByName('fecha').AsDateTime >= StrToDate('29/06/2020')) and (qrySalidas.FieldByName('centro_sal').AsString = '4')) then
    begin
      SQL.Add('select ');
      SQL.Add('       sum( case when producto_sl = :producto then kilos_sl else 0 end )  kilos_producto, ');
      SQL.Add('       sum( kilos_sl ) kilos ');
      SQL.Add('from frf_salidas_l ');
      if sEmpresa = 'SAT' then
        SQL.Add('where empresa_sl in ( ''050'',''080'' ) ')
      else
        SQL.Add('where empresa_sl = :empresa ');
      SQL.Add('and centro_salida_sl in(1,4)  ');
      SQL.Add('and fecha_sl = :fecha ');
      SQL.Add('and n_albaran_sl = :albaran ');

      if sEmpresa <> 'SAT' then
        ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
      ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
      ParamByName('albaran').AsInteger:= qrySalidas.FieldByName('referencia').AsInteger;
      ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
    end
    else
    begin
      SQL.Add('select ');
      SQL.Add('       sum( case when producto_sl = :producto then kilos_sl else 0 end )  kilos_producto, ');
      SQL.Add('       sum( kilos_sl ) kilos ');
      SQL.Add('from frf_salidas_l ');
      if sEmpresa = 'SAT' then
        SQL.Add('where empresa_sl in ( ''050'',''080'' ) ')
      else
        SQL.Add('where empresa_sl = :empresa ');
      SQL.Add('and centro_salida_sl = :centro ');
      SQL.Add('and fecha_sl = :fecha ');
      SQL.Add('and n_albaran_sl = :albaran ');

      if sEmpresa <> 'SAT' then
        ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
      ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
      ParamByName('albaran').AsInteger:= qrySalidas.FieldByName('referencia').AsInteger;
      ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
      ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
    end;

    Open;
    try
      rKilos_producto:= FieldByName('kilos_producto').AsFloat;
      rKilos:= FieldByName('kilos').AsFloat;
    finally
      Close;
    end;

    SQL.Clear;
    SQL.Add(' select sum(kilos_desglose_sl2) kilos_desglose ');
    SQL.Add(' from frf_salidas_l2 ');
    if sEmpresa = 'SAT' then
      SQL.Add('where empresa_sl2 in ( ''050'',''080'' ) ')
    else
      SQL.Add('where empresa_sl2 = :empresa ');
    SQL.Add('and centro_salida_sl2 = :centro ');
    SQL.Add('and fecha_sl2 = :fecha ');
    SQL.Add('and n_albaran_sl2 = :albaran ');
    SQL.Add('and producto_desglose_sl2 = :producto ');

    if sEmpresa <> 'SAT' then
      ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
    ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
    ParamByName('albaran').AsInteger:= qrySalidas.FieldByName('referencia').AsInteger;
    ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
    ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
    Open;
    try
      rKilos_producto:= rKilos_producto + FieldByName('kilos_desglose').AsFloat;
    finally
      Close;
    end;
  end;

  with qryGastoAlbaran do
  begin
    SQL.Clear;
    if ((qrySalidas.FieldByName('producto').AsString = 'PEH') and (qrySalidas.FieldByName('fecha').AsDateTime < StrToDate('01/11/2020'))) or
       ((qrySalidas.FieldByName('producto').AsString = 'PAP') and (qrySalidas.FieldByName('fecha').AsDateTime < StrToDate('29/06/2020'))) then
//       ((qrySalidas.FieldByName('producto').AsString = 'PAP') and (qrySalidas.FieldByName('fecha').AsDateTime >= StrToDate('29/06/2020')) and (qrySalidas.FieldByName('centro_sal').AsString = '6'))) then    //SOLO para Calculo 2020
    begin
      SQL.Add(' select ');
      SQL.Add('        sum( case when producto_g = :producto then ');
      SQL.Add('              case when facturable_tg = ''S'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) producto_fac, ');
      SQL.Add('        sum( case when producto_g = :producto then ');
      SQL.Add('              case when facturable_tg = ''N'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) producto_nofac, ');

      SQL.Add('        sum( case when producto_g is null then ');
      SQL.Add('              case when facturable_tg = ''S'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) todos_fac, ');
      SQL.Add('        sum( case when producto_g is null then ');
      SQL.Add('              case when facturable_tg = ''N'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) todos_nofac ');

      SQL.Add(' from comerbag::frf_gastos ');
      SQL.Add('      join comerbag::frf_tipo_gastos on tipo_tg = tipo_g ');
      SQL.Add(' where empresa_g = :empresa ');
      SQL.Add(' and centro_salida_g = :centro ');
      SQL.Add(' and fecha_g = :fecha ');
      SQL.Add(' and n_albaran_g = :albaran ');
      SQL.Add(' and ( ( producto_g = :producto ) or ( producto_g is null ) ) ');
      SQL.Add(' and gasto_transito_tg = 0 ');

      ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
      ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
      ParamByName('albaran').AsInteger:= qrySalidas.FieldByName('referencia').AsInteger;
      ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
      ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
    end
    else if ((qrySalidas.FieldByName('producto').AsString = 'PAP') and  (qrySalidas.FieldByName('fecha').AsDateTime >= StrToDate('29/06/2020')) and (qrySalidas.FieldByName('centro_sal').AsString = '4')) then
    begin
          SQL.Add(' select ');
      SQL.Add('        sum( case when producto_g = :producto then ');
      SQL.Add('              case when facturable_tg = ''S'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) producto_fac, ');
      SQL.Add('        sum( case when producto_g = :producto then ');
      SQL.Add('              case when facturable_tg = ''N'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) producto_nofac, ');

      SQL.Add('        sum( case when producto_g is null then ');
      SQL.Add('              case when facturable_tg = ''S'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) todos_fac, ');
      SQL.Add('        sum( case when producto_g is null then ');
      SQL.Add('              case when facturable_tg = ''N'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) todos_nofac ');

      SQL.Add(' from frf_gastos ');
      SQL.Add('      join frf_tipo_gastos on tipo_tg = tipo_g ');
      SQL.Add(' where empresa_g = :empresa ');
      SQL.Add(' and centro_salida_g in (1,4) ');
      SQL.Add(' and fecha_g = :fecha ');
      SQL.Add(' and n_albaran_g = :albaran ');
      SQL.Add(' and ( ( producto_g = :producto ) or ( producto_g is null ) ) ');
      SQL.Add(' and gasto_transito_tg = 0 ');

      ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
      ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
      ParamByName('albaran').AsInteger:= qrySalidas.FieldByName('referencia').AsInteger;
      ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
    end
    else
    begin
      SQL.Add(' select ');
      SQL.Add('        sum( case when producto_g = :producto then ');
      SQL.Add('              case when facturable_tg = ''S'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) producto_fac, ');
      SQL.Add('        sum( case when producto_g = :producto then ');
      SQL.Add('              case when facturable_tg = ''N'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) producto_nofac, ');

      SQL.Add('        sum( case when producto_g is null then ');
      SQL.Add('              case when facturable_tg = ''S'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) todos_fac, ');
      SQL.Add('        sum( case when producto_g is null then ');
      SQL.Add('              case when facturable_tg = ''N'' then importe_g else 0 end ');
      SQL.Add('              else 0 end ) todos_nofac ');

      SQL.Add(' from frf_gastos ');
      SQL.Add('      join frf_tipo_gastos on tipo_tg = tipo_g ');
      SQL.Add(' where empresa_g = :empresa ');
      SQL.Add(' and centro_salida_g = :centro ');
      SQL.Add(' and fecha_g = :fecha ');
      SQL.Add(' and n_albaran_g = :albaran ');
      SQL.Add(' and ( ( producto_g = :producto ) or ( producto_g is null ) ) ');
      SQL.Add(' and gasto_transito_tg = 0 ');

      ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
      ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
      ParamByName('albaran').AsInteger:= qrySalidas.FieldByName('referencia').AsInteger;
      ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
      ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;
    end;

    Open;
    try
      rProducto_fac:= FieldByName('producto_fac').AsFloat * -1;
      rTodos_fac:= FieldByName('todos_fac').AsFloat * -1;
      if qrySalidas.FieldByName('moneda').AsString <> 'EUR' then
      begin
        rProducto_fac:= ChangeToEuro( qrySalidas.FieldByName('moneda').AsString, qrySalidas.FieldByName('fecha').AsDateTime, rProducto_fac );
        rTodos_fac:= ChangeToEuro( qrySalidas.FieldByName('moneda').AsString, qrySalidas.FieldByName('fecha').AsDateTime, rTodos_fac );
      end;

      //Segun Raul los gastos de transporte en libras estan en libras
      rProducto_nofac:= FieldByName('producto_nofac').AsFloat;
      rTodos_nofac:= FieldByName('todos_nofac').AsFloat;
      if qrySalidas.FieldByName('moneda').AsString <> 'EUR' then
      begin
        rProducto_nofac:= ChangeToEuro( qrySalidas.FieldByName('moneda').AsString, qrySalidas.FieldByName('fecha').AsDateTime, rProducto_nofac );
        rTodos_nofac:= ChangeToEuro( qrySalidas.FieldByName('moneda').AsString, qrySalidas.FieldByName('fecha').AsDateTime, rTodos_nofac );
      end;
    finally
      Close;
    end;
  end;

  if rKilos_producto > 0 then
  begin
    AImpFac:= RoundTo( AKilos * ( rProducto_fac / rKilos_producto ), -2 );
    AImpNoFac:= RoundTo( AKilos * ( rProducto_nofac / rKilos_producto ), -2 );
  end
  else
  begin
    AImpFac:= 0;
    AImpNoFac:= 0;
  end;
  if rKilos <> 0 then
  begin
    AImpFac:= AImpFac + RoundTo( AKilos * ( rTodos_fac / rKilos ), -2 );
    AImpNoFac:= AImpNoFac + RoundTo( AKilos * ( rTodos_nofac / rKilos ), -2 );
  end;
end;

procedure TDMLiqProdVendidoSalidas.GastosTransitos( const AKilos: Real; var AImporte: real );
var
  rKilos_producto, rKilos: Real;
  rProducto, rTodos: Real;
begin
  with qryKilosTransito do
  begin
    Sql.Clear;
    Sql.Add('select ');
    Sql.Add('       sum( case when ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto then kilos_tl else 0 end )  kilos_producto, ');
    Sql.Add('       sum( kilos_tl ) kilos ');
    Sql.Add('from frf_transitos_l ');
    if sEmpresa = 'SAT' then
      Sql.Add('where empresa_tl in ( ''050'',''080'' ) ')
    else
      Sql.Add('where empresa_tl = :empresa ');
    Sql.Add('and centro_tl = :centro ');
    Sql.Add('and fecha_tl = :fecha ');
    Sql.Add('and referencia_tl = :referencia ');


    if sEmpresa <> 'SAT' then
      ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
    ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
    ParamByName('referencia').AsInteger:= qrySalidas.FieldByName('referencia').AsInteger;
    ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
    ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;

    Open;
    try
      rKilos_producto:= FieldByName('kilos_producto').AsFloat;
      rKilos:= FieldByName('kilos').AsFloat;
    finally
      Close;
    end;
  end;

  with qryGastoTransito do
  begin
    ParamByName('empresa').AsString:= qrySalidas.FieldByName('empresa').AsString;
    ParamByName('fecha').AsDateTime:= qrySalidas.FieldByName('fecha').AsDateTime;
    ParamByName('referencia').AsInteger:= qrySalidas.FieldByName('referencia').AsInteger;
    ParamByName('centro').AsString:= qrySalidas.FieldByName('centro_sal').AsString;
    ParamByName('producto').AsString:= qrySalidas.FieldByName('producto').AsString;

    Open;
    try
      rProducto:= FieldByName('producto').AsFloat;
      rTodos:= FieldByName('todos').AsFloat;
    finally
      Close;
    end;
  end;

  if rKilos_producto > 0 then
  begin
    AImporte:= RoundTo( AKilos * ( rProducto / rKilos_producto ), -2 );
  end
  else
  begin
    AImporte:= 0;
  end;
  if rKilos <> 0 then
  begin
    AImporte:= AImporte + RoundTo( AKilos * ( rTodos / rKilos ), -2 );
  end;
end;

function TDMLiqProdVendidoSalidas.CosteFinaciero( const AKilos: real ): real;
begin
  with DMLiqProdVendido  do
  begin
    Result:= RoundTo( AKilos * ( kmtSemana.FieldByName('precio_coste_comercial').AsFloat +
                       kmtSemana.FieldByName('precio_coste_produccion').AsFloat +
                       kmtSemana.FieldByName('precio_coste_administracion').AsFloat ) , -2);
  end;
end;

end.
