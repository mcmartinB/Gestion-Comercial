unit TablaTmpFob;

interface

(*
create table tmp_sal_resumen (
  tusuario_sr CHAR(8),
  tempresa_sr CHAR(3),
  tcentro_sr CHAR(1),
  tproducto_sr CHAR(1),
  tcategoria_sr CHAR(2),
  tcalibre_sr CHAR(6),
  tenvase_sr CHAR(3),
  tcliente_sr CHAR(3),
  tanyosemana_sr CHAR(6),
  tfecha_salida_sr DATE,
  tfecha_albaran_sr DATE,
  tnum_albaran_sr INTEGER,
  tmoneda_sr CHAR(3),
  tcambio_sr DECIMAL(10,6),
  tpalets_linea_sr DECIMAL(10,2),
  tcajas_linea_sr DECIMAL(10,2),
  tkilos_linea_sr DECIMAL(10,2),
  timporte_linea_sr DECIMAL(10,2),
  tdescuento_linea_sr DECIMAL(10,2),
  tcomision_linea_sr DECIMAL(10,2),
  tgasto_linea_sr DECIMAL(10,2),
  tgasto_tenerife_sr DECIMAL(10,2),
  tkilos_prod_sr DECIMAL(10,2),
  tkilos_total_sr DECIMAL(10,2),
  tkilos_tran_linea_sr DECIMAL(10,2),
  tkilos_tran_prod_sr DECIMAL(10,2),
  tkilos_tran_total_sr DECIMAL(10,2),
  tgasto_g_todos_sr DECIMAL(10,2),
  tgasto_g_prod_sr DECIMAL(10,2),
  tgasto_t_todos_sr DECIMAL(10,2),
  tgasto_t_prod_sr DECIMAL(10,2)
 )

CREATE  INDEX ialbaran_sr ON tmp_sal_resumen (
  tusuario_sr ASC,
  tempresa_sr ASC,
  tcentro_sr ASC,
  tnum_albaran_sr ASC,
  tfecha_albaran_sr ASC)

CREATE  INDEX icliente_sr ON tmp_sal_resumen (
  tusuario_sr ASC,
  tempresa_sr ASC,
  tcliente_sr ASC)

create table tmp_tran_indirect (
   tusuario_ti CHAR(8),
   tempresa_ti CHAR(3),
   tcentro_transito_ti CHAR(1),
   tref_transito_ti INTEGER,
   tfecha_transito_ti DATE,
   tcentro_origen_ti CHAR(1),
   tref_origen_ti INTEGER,
   tfecha_origen_ti DATE,
   tfecha_salida_ti DATE,
   tproducto_ti CHAR(1),
   tcliente_ti CHAR(3),
   tcategoria_ti CHAR(2),
   tkgs_ti DECIMAL(10,2)
)
*)


//***************************************************************************//
// ESTA FUNCION RELLENA LA TABLA tmp_sal_resumen
// PARAMETROS


function Inicializar: Boolean;
function Finalizar: Boolean;
function Configurar(const ACentroOrigen, AFacturado, AValorado, ACompletar: boolean): boolean;
function Ejecutar(const AUsuario, AEmpresa, ACentroOrigen,
  AProducto, AFechaIni, AFechaFin: string;
  const ACategoria: string = '';
  const ACliente: string = ''): integer;

procedure BorrarDatosActuales(const AUsuario: string);

implementation

uses
  Forms, SysUtils, DB, DBTables, bMath, bTimeUtils, UDMCambioMoneda, Debug;

var
  bInicializado, bConfigurado: Boolean;
  bCentroOrigen: Boolean;
  bFacturado: Boolean;
  bValorado: Boolean;
  bCompletar: Boolean;

  QAux, QList, QAux2: TQuery;
  QCambioFactura: TQuery;
  QGrabarMoneda, QDatosMoneda: TQuery;
  QGastosAlbaran, QGastosTenerife, QGrabarGastos, QGrabarGastosTen: TQuery;
  QTotalesAlbaran, QGrabarTotales: TQuery;
  QModificarSalida, QInsertarSalida, QBuscarSalida: TQuery;
  QTransitosDirectos, QTransitosIndirectos, QInsertarTransito: TQuery;

function Configurar(const ACentroOrigen, AFacturado, AValorado, ACompletar: boolean): boolean;
begin
  if not bConfigurado then
    bConfigurado := true;
  bCentroOrigen := ACentroOrigen;
  bFacturado := AFacturado;
  bValorado := AValorado;
  bCompletar := ACompletar;
  result := bConfigurado;
end;

procedure CrearQuerys;
begin
  QCambioFactura := TQuery.Create(Application);
  with QCambioFactura do
  begin
    DatabaseName := 'BDProyecto';
    SQL.Clear;
    SQL.Add(' select nvl( importe_total_f, 0 ) importe_total_f, ');
    SQL.Add('        nvl( importe_euros_f, 0 ) importe_euros_f');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f = :empresa ');
    SQL.Add('   and n_factura_f = :factura ');
    SQL.Add('   and fecha_factura_f = :fecha ');
    Prepare;
  end;

  QGrabarMoneda := TQuery.Create(Application);
  with QGrabarMoneda do
  begin
    DatabaseName := 'BDProyecto';
    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen  ');
    SQL.Add(' set tmoneda_sr = :moneda,  ');
    SQL.Add('     tcambio_sr = :cambio  ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tempresa_sr = :empresa ');
    SQL.Add(' and tcentro_sr = :centro ');
    SQL.Add(' and tnum_albaran_sr = :albaran ');
    SQL.Add(' and tfecha_albaran_sr = :fecha ');
    Prepare;
  end;

  QDatosMoneda := TQuery.Create(Application);
  with QDatosMoneda do
  begin
    DatabaseName := 'BDProyecto';
    SQL.Clear;
    SQL.Add(' select moneda_sc, n_factura_sc, fecha_factura_sc ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');
    Prepare;
  end;

  QGastosAlbaran := TQuery.Create(Application);
  with QGastosAlbaran do
  begin
    DatabaseName := 'BDProyecto';
    SQL.Clear;
    SQL.Add(' select NVL( unidad_dist_tg, ''KILOS'' ), sum(case when facturable_tg = ''S'' then -1 else 1 end * importe_g) ');
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');
    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add(' and centro_salida_g = :centro ');
    SQL.Add(' and n_albaran_g = :albaran ');
    SQL.Add(' and fecha_g = :fecha ');
    SQL.Add(' and tipo_tg = tipo_g ');
    SQL.Add(' and gasto_transito_tg = 0 ');
    SQL.Add(' and descontar_fob_tg <> ''N'' ');
    SQL.Add(' group by 1 ');
    Prepare;
  end;

  QGastosTenerife := TQuery.Create(Application);
  with QGastosTenerife do
  begin
    DatabaseName := 'BDProyecto';
    SQL.Clear;
    SQL.Add(' select NVL( unidad_dist_tg, ''KILOS'' ), sum(case when facturable_tg = ''S'' then -1 else 1 end * importe_g) ');
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');
    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add(' and centro_salida_g = :centro ');
    SQL.Add(' and n_albaran_g = :albaran ');
    SQL.Add(' and fecha_g = :fecha ');
    SQL.Add(' and tipo_tg = tipo_g ');
    SQL.Add(' and gasto_transito_tg = 1 ');
    SQL.Add(' and descontar_fob_tg <> ''N'' ');
    SQL.Add(' group by 1 ');
    Prepare;
  end;

  QGrabarGastos := TQuery.Create(Application);
  with QGrabarGastos do
  begin
    DatabaseName := 'BDProyecto';
    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set  tgasto_palets_sr = :gpalets, ');
    SQL.Add('      tgasto_cajas_sr = :gcajas, ');
    SQL.Add('      tgasto_kilos_sr = :gkilos, ');
    SQL.Add('      tgasto_importe_sr = :gimporte ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tempresa_sr = :empresa ');
    SQL.Add(' and tcentro_sr = :centro ');
    SQL.Add(' and tnum_albaran_sr = :albaran ');
    SQL.Add(' and tfecha_albaran_sr = :fecha ');
    Prepare;
  end;

  QGrabarGastosTen := TQuery.Create(Application);
  with QGrabarGastosTen do
  begin
    DatabaseName := 'BDProyecto';
    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set  tgasto_tpalets_sr = :gtpalets, ');
    SQL.Add('      tgasto_tcajas_sr = :gtcajas, ');
    SQL.Add('      tgasto_tkilos_sr = :gtkilos, ');
    SQL.Add('      tgasto_timporte_sr = :gtimporte ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tempresa_sr = :empresa ');
    SQL.Add(' and tcentro_sr = :centro ');
    SQL.Add(' and tnum_albaran_sr = :albaran ');
    SQL.Add(' and tfecha_albaran_sr = :fecha ');
    Prepare;
  end;

  QTotalesAlbaran := TQuery.Create(Application);
  with QTotalesAlbaran do
  begin
    DatabaseName := 'BDProyecto';
  end;

  QGrabarTotales := TQuery.Create(Application);
  with QGrabarTotales do
  begin
    DatabaseName := 'BDProyecto';
    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set  tpalets_total_sr = :palets, ');
    SQL.Add('      tcajas_total_sr = :cajas, ');
    SQL.Add('      tkilos_total_sr = :kilos, ');
    SQL.Add('      timporte_total_sr = :importe, ');

    SQL.Add('      tpalets_prod_sr = :palets_prod, ');
    SQL.Add('      tcajas_prod_sr = :cajas_prod, ');
    SQL.Add('      tkilos_prod_sr = :kilos_prod, ');
    SQL.Add('      timporte_prod_sr = :importe_prod, ');

    SQL.Add('      tpalets_tran_total_sr = :tpalets, ');
    SQL.Add('      tcajas_tran_total_sr = :tcajas, ');
    SQL.Add('      tkilos_tran_total_sr = :tkilos, ');
    SQL.Add('      timporte_tran_total_sr = :timporte ');

    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tempresa_sr = :empresa ');
    SQL.Add(' and tcentro_sr = :centro ');
    SQL.Add(' and tnum_albaran_sr = :albaran ');
    SQL.Add(' and tfecha_albaran_sr = :fecha ');
    Prepare;
  end;

  QModificarSalida := TQuery.Create(Application);
  QModificarSalida.DatabaseName := 'BDProyecto';
  with QModificarSalida do
  begin
    SQL.Add('update tmp_sal_resumen set');

    SQL.Add(' tpalets_linea_sr = tpalets_linea_sr + :palets, ');
    SQL.Add(' tcajas_linea_sr = tcajas_linea_sr + :cajas, ');
    SQL.Add(' tkilos_linea_sr = tkilos_linea_sr + :kilos, ');
    SQL.Add(' timporte_linea_sr = timporte_linea_sr + :importe, ');
    SQL.Add(' tpalets_tran_linea_sr = tpalets_tran_linea_sr + :palets, ');
    SQL.Add(' tcajas_tran_linea_sr = tcajas_tran_linea_sr + :cajas, ');
    SQL.Add(' tkilos_tran_linea_sr = tkilos_tran_linea_sr + :kilos, ');
    SQL.Add(' timporte_tran_linea_sr = timporte_tran_linea_sr + :importe ');

    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tempresa_sr = :empresa ');
    SQL.Add(' and tcentro_sr = :centro ');
    SQL.Add(' and tproducto_sr = :producto ');
    SQL.Add(' and tcategoria_sr = :categoria ');
    SQL.Add(' and tcalibre_sr = :calibre ');
    SQL.Add(' and tenvase_sr = :envase ');
    SQL.Add(' and tcliente_sr = :cliente ');
    SQL.Add(' and tanyosemana_sr = :anyosemana ');
    SQL.Add(' and tfecha_salida_sr = :fecha_sal ');
    SQL.Add(' and tfecha_albaran_sr = :fecha_alb ');
    SQL.Add(' and tnum_albaran_sr = :n_albaran ');
    SQL.Add(' and tmoneda_sr = :moneda ');
    SQL.Add(' and tcambio_sr = :cambio ');
    Prepare;
  end;

  QInsertarSalida := TQuery.Create(Application);
  QInsertarSalida.DatabaseName := 'BDProyecto';
  with QInsertarSalida do
  begin
    SQL.Add('insert into tmp_sal_resumen values (');

    SQL.Add(' :usuario, ');
    SQL.Add(' :empresa, ');
    SQL.Add(' :centro, ');
    SQL.Add(' :producto, ');
    SQL.Add(' :categoria, ');
    SQL.Add(' :calibre, ');
    SQL.Add(' :envase, ');
    SQL.Add(' :cliente, ');
    SQL.Add(' :anyosemana, ');
    SQL.Add(' :fecha_sal, ');
    SQL.Add(' :fecha_alb, ');
    SQL.Add(' :n_albaran, ');
    SQL.Add(' :moneda, ');
    SQL.Add(' :cambio, ');
    SQL.Add(' :palets, ');
    SQL.Add(' :cajas, ');
    SQL.Add(' :kilos, ');
    SQL.Add(' :importe, ');

    SQL.Add(' 0, 0, 0, 0, ');
    SQL.Add(' 0, 0, 0, 0, ');
    SQL.Add(' 0, 0, 0, 0, ');
    SQL.Add(' 0, 0, 0, 0, ');
    SQL.Add(' :palets, :cajas, :kilos, :importe, ');
    SQL.Add(' 0, 0, 0, 0,  ');
    SQL.Add(' 0, 0, 0, 0 ) ');
    Prepare;
  end;

  QBuscarSalida := TQuery.Create(Application);
  QBuscarSalida.DatabaseName := 'BDProyecto';
  with QBuscarSalida do
  begin
    SQL.Add('select * from tmp_sal_resumen ');

    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tempresa_sr = :empresa ');
    SQL.Add(' and tcentro_sr = :centro ');
    SQL.Add(' and tproducto_sr = :producto ');
    SQL.Add(' and tcategoria_sr = :categoria ');
    SQL.Add(' and tcalibre_sr = :calibre ');
    SQL.Add(' and tenvase_sr = :envase ');
    SQL.Add(' and tcliente_sr = :cliente ');
    SQL.Add(' and tanyosemana_sr = :anyosemana ');
    SQL.Add(' and tfecha_salida_sr = :fecha_sal ');
    SQL.Add(' and tfecha_albaran_sr = :fecha_alb ');
    SQL.Add(' and tnum_albaran_sr = :n_albaran ');
    SQL.Add(' and tmoneda_sr = :moneda ');
    SQL.Add(' and tcambio_sr = :cambio ');
    Prepare;
  end;

  QTransitosIndirectos := TQuery.Create(Application);
  QTransitosIndirectos.DatabaseName := 'BDProyecto';
  with QTransitosIndirectos do
  begin
    SQL.Add('select empresa_tl, ');
    SQL.Add('       centro_tl, ');
    SQL.Add('       referencia_tl, ');
    SQL.Add('       fecha_tl, ');
    SQL.Add('       centro_origen_tl, ');
    SQL.Add('       sum(kilos_tl) ');
    SQL.Add('from frf_transitos_l ');
    SQL.Add('where empresa_tl = :empresa ');
    SQL.Add('  and centro_origen_tl = :centro ');
    SQL.Add('  and ref_origen_tl = :referencia ');
    SQL.Add('  and fecha_origen_tl = :fecha ');
    SQL.Add('  and producto_tl = :producto  ');
    SQL.Add('group by 1,2,3,4, 5 ');
    Prepare;
  end;

  QInsertarTransito := TQuery.Create(Application);
  QInsertarTransito.DatabaseName := 'BDProyecto';
  with QInsertarTransito do
  begin
    SQL.Add('insert into tmp_tran_indirect values (');
    SQL.Add(' :usuario, ');
    SQL.Add(' :empresa, ');
    SQL.Add(' :centro_transito, ');
    SQL.Add(' :ref_transito, ');
    SQL.Add(' :fecha_transito, ');
    SQL.Add(' :centro_origen, ');
    SQL.Add(' :ref_origen, ');
    SQL.Add(' :fecha_origen, ');
    SQL.Add(' :fecha_salida, ');
    SQL.Add(' :producto, ');
    SQL.Add(' :cliente, ');
    SQL.Add(' :categoria, ');
    SQL.Add(' :kilos )');
    Prepare;
  end;

  QTransitosDirectos := TQuery.Create(Application);
  QTransitosDirectos.DatabaseName := 'BDProyecto';
  with QTransitosDirectos do
  begin
    SQL.Clear;

    SQL.Add('select empresa_tl, ');
    SQL.Add('       centro_tl, ');
    SQL.Add('       referencia_tl, ');
    SQL.Add('       fecha_tl ');
    SQL.Add('from frf_transitos_l ');
    SQL.Add('where empresa_tl = :empresa ');
      (*BEGIN TRANSITOS DIRECTAS*)
    SQL.Add('  and centro_tl = :centro ');
    SQL.Add('  and ref_origen_tl is null ');
      (*END TRANSITOS DIRECTAS*)
    SQL.Add('  and producto_tl = :producto  ');
    SQL.Add('  and fecha_tl between :fechaini and :fechafin ');
    SQL.Add('group by 1,2,3,4 ');
    Prepare;
  end;
end;

procedure DestruirQuerys;
begin
  FreeAndNil(QDatosMoneda);
  if QGrabarMoneda.Prepared then
    QGrabarMoneda.UnPrepare;
  FreeAndNil(QGrabarMoneda);
  FreeAndNil(QGastosAlbaran);
  if QGrabarGastos.Prepared then
    QGrabarGastos.UnPrepare;
  FreeAndNil(QGrabarGastos);
  FreeAndNil(QGastosTenerife);
  if QGrabarGastosTen.Prepared then
    QGrabarGastosTen.UnPrepare;
  FreeAndNil(QGrabarGastosTen);
  FreeAndNil(QTotalesAlbaran);
  if QGrabarTotales.Prepared then
    QGrabarTotales.UnPrepare;
  FreeAndNil(QGrabarTotales);
  if QModificarSalida.Prepared then
    QModificarSalida.UnPrepare;
  FreeAndNil(QModificarSalida);
  if QInsertarSalida.Prepared then
    QInsertarSalida.UnPrepare;
  FreeAndNil(QInsertarSalida);
  if QBuscarSalida.Prepared then
    QBuscarSalida.UnPrepare;
  FreeAndNil(QBuscarSalida);
  if QTransitosIndirectos.Prepared then
    QTransitosIndirectos.UnPrepare;
  FreeAndNil(QTransitosIndirectos);
  if QInsertarTransito.Prepared then
    QInsertarTransito.UnPrepare;
  FreeAndNil(QInsertarTransito);
  if QTransitosDirectos.Prepared then
    QTransitosDirectos.UnPrepare;
  FreeAndNil(QTransitosDirectos);
end;

function Inicializar: Boolean;
begin
  if not bInicializado then
  begin
    CrearQuerys;
    bInicializado := true;
  end;
  result := bInicializado;
end;

function Finalizar: Boolean;
begin
  if bInicializado then
  begin
    DestruirQuerys;
    bInicializado := false;
  end;
  result := not bInicializado;
end;

procedure BorrarDatosActuales(const AUsuario: string);
begin
  with QAux do
  begin
    SQL.Clear;
    SQL.Add('delete from tmp_sal_resumen where tusuario_sr = ' + QuotedStr(AUsuario));
    ExecSQL;
    SQL.Clear;
    SQL.Add('delete from tmp_tran_indirect where tusuario_ti = ' + QuotedStr(AUsuario));
    ExecSQL;
  end;
end;

function ExisteSalida(const ADataSet: TDataSet; const AFecha: TDateTime): boolean;
begin
  with QBuscarSalida do
  begin
    Params[0].Value := ADataSet.Fields[0].Value;
    Params[1].Value := ADataSet.Fields[1].Value;
    Params[2].Value := ADataSet.Fields[2].Value;
    Params[3].Value := ADataSet.Fields[3].Value;
    Params[4].Value := ADataSet.Fields[4].Value;
    Params[5].Value := ADataSet.Fields[5].Value;
    Params[6].Value := ADataSet.Fields[6].Value;
    Params[7].Value := ADataSet.Fields[7].Value;
    Params[8].AsString := AnyoSemana(AFecha);
    Params[9].AsDateTime := AFecha;
    Params[10].Value := ADataSet.Fields[8].Value;
    Params[11].Value := ADataSet.Fields[9].Value;
    Params[12].Value := ADataSet.Fields[10].Value;
    Params[13].Value := ADataSet.Fields[11].Value;

    Open;
    result := not IsEmpty;
    Close;
  end;
end;

procedure ModificarSalida(const ADataSet: TDataSet; const AFecha: TDateTime);
begin
  with QModificarSalida do
  begin
    Params[8].Value := ADataSet.Fields[0].Value;
    Params[9].Value := ADataSet.Fields[1].Value;
    Params[10].Value := ADataSet.Fields[2].Value;
    Params[11].Value := ADataSet.Fields[3].Value;
    Params[12].Value := ADataSet.Fields[4].Value;
    Params[13].Value := ADataSet.Fields[5].Value;
    Params[14].Value := ADataSet.Fields[6].Value;
    Params[15].Value := ADataSet.Fields[7].Value;

    Params[16].AsString := AnyoSemana(AFecha);
    Params[17].AsDateTime := AFecha;

    Params[18].Value := ADataSet.Fields[8].Value;
    Params[19].Value := ADataSet.Fields[9].Value;
    Params[20].Value := ADataSet.Fields[10].Value;
    Params[21].Value := ADataSet.Fields[11].Value;

    ParamByName('palets').Value := ADataSet.Fields[12].Value;
    ParamByName('cajas').Value := ADataSet.Fields[13].Value;
    ParamByName('kilos').Value := ADataSet.Fields[14].Value;
    ParamByName('importe').Value := ADataSet.Fields[15].Value;

    ExecSQL;
  end;
end;

function InsertarSalida(const ADataSet: TDataSet; const AFecha: TDateTime): integer;
begin
  result := 1;
  with QInsertarSalida do
  begin
    Params[0].Value := ADataSet.Fields[0].Value;
    Params[1].Value := ADataSet.Fields[1].Value;
    Params[2].Value := ADataSet.Fields[2].Value;
    Params[3].Value := ADataSet.Fields[3].Value;
    Params[4].Value := ADataSet.Fields[4].Value;
    Params[5].Value := ADataSet.Fields[5].Value;
    Params[6].Value := ADataSet.Fields[6].Value;
    Params[7].Value := ADataSet.Fields[7].Value;
    Params[8].AsString := AnyoSemana(AFecha);
    Params[9].AsDateTime := AFecha;
    Params[10].Value := ADataSet.Fields[8].Value;
    Params[11].Value := ADataSet.Fields[9].Value;
    Params[12].Value := ADataSet.Fields[10].Value;
    Params[13].Value := ADataSet.Fields[11].Value;
    ParamByName('palets').Value := ADataSet.Fields[12].Value;
    ParamByName('cajas').Value := ADataSet.Fields[13].Value;
    ParamByName('kilos').Value := ADataSet.Fields[14].Value;
    ParamByName('importe').Value := ADataSet.Fields[15].Value;

    ExecSQL;
  end;
end;

function InsertarTransito(const AUsuario, AEmpresa,
  ACentro, AReferencia, AFecha,
  AOrigen, ARefOrigen, AFechaOrigen,
  AFechaSalida, AProducto, ACliente, ACategoria: string;
  const AKilos: Real): integer;
begin
  result := 1;
  with QInsertarTransito do
  begin
    Params[0].AsString := AUsuario;
    Params[1].AsString := AEmpresa;
    Params[2].AsString := ACentro;
    Params[3].AsString := AReferencia;
    Params[4].AsString := AFecha;
    Params[5].AsString := AOrigen;
    Params[6].AsString := ARefOrigen;
    Params[7].AsString := AFechaOrigen;
    Params[8].AsString := AFechaSalida;
    Params[9].AsString := AProducto;
    Params[10].AsString := ACliente;
    Params[11].AsString := ACategoria;
    Params[12].AsFloat := AKilos;

    ExecSQL;
  end;
end;

function InsertarSalidasTransito(const AUsuario, AEmpresa, ACentroOrigen, AReferencia,
  AFechaTransito, AFechaSalida, AProducto, ACliente, ACategoria: string): integer;
var
  QSalidas: TQuery;
  dAux: TDateTime;
begin
  dAux := StrToDate(AFechaSalida);
  result := 0;
  QSalidas := TQuery.Create(Application);
  QSalidas.DatabaseName := 'BDProyecto';
  try
    with QSalidas do
    begin
      SQL.Clear;

      SQL.Add('select ' + QuotedStr(AUsuario) + ', ');
      SQL.Add('       empresa_sl, ');
      SQL.Add('       centro_salida_sl, ');
      SQL.Add('       producto_sl, ');
      SQL.Add('       categoria_sl, ');
      SQL.Add('       calibre_sl, ');
      SQL.Add('       envase_sl, ');
      SQL.Add('       cliente_sl, ');
      //SQL.Add( '       YEARANDWEEK( ' + QuotedStr( AFecha ) + ' ), ');
      SQL.Add('       fecha_sl, ');
      SQL.Add('       n_albaran_sl, ');
      SQL.Add('       ''EUR'', ');
      SQL.Add('       1, ');
      SQL.Add('       sum( nvl( n_palets_sl, 0 ) ), ');
      SQL.Add('       sum( nvl( cajas_sl, 0 ) ), ');
      SQL.Add('       sum( nvl( kilos_sl, 0 ) ), ');
      SQL.Add('       sum( nvl( importe_neto_sl, 0 ) ) ');

      SQL.Add('from frf_salidas_l, frf_salidas_c');
      SQL.Add('where empresa_sl = :empresa ');
      SQL.Add('  and centro_origen_sl = :centro ');
      SQL.Add('  and ref_transitos_sl = :referencia ');
      SQL.Add('  and producto_sl = :producto  ');
      if ACategoria <> '' then
        SQL.Add('  and categoria_sl = :categoria ');
      if ACliente <> '' then
        SQL.Add('  and cliente_sl = :cliente ');
      SQL.Add('  and fecha_sl between ( :fecha - 30 ) and ( :fecha + 60 ) ');

      //SQL.Add('  and calibre_sl in (''M'',''MM'') ');


      //TODOS LOS ALBARANES FACTURADOS O CON LINEAS CON PRECIO DISTINTO DE 0
      SQL.Add('  and empresa_sc = empresa_sl ');
      SQL.Add('  and centro_salida_sc = centro_salida_sl ');
      SQL.Add('  and n_albaran_sc = n_albaran_sl ');
      SQL.Add('  and fecha_sc = fecha_sl ');

      if bFacturado then
      begin
        SQL.Add('   and NVL( n_factura_sc, '''' ) <> ''''  ');
      end
      else
        if bValorado then
        begin
          SQL.Add('  and ( ( NVL( precio_sl, 0 ) <> 0 ) or ( NVL( n_factura_sc, '''' ) <> '''' ) ) ');
        end;

      SQL.Add('group by 1,2,3,4,5,6,7,8,9,10,11 ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentroOrigen;
      ParamByName('fecha').AsDate := StrToDate(AFechaTransito);
      ParamByName('referencia').AsString := AReferencia;
      ParamByName('producto').AsString := AProducto;

      if ACategoria <> '' then
        ParamByName('categoria').AsString := ACategoria;
      if ACliente <> '' then
        ParamByName('cliente').AsString := ACliente;

      Open;

      while not Eof do
      begin
        if ExisteSalida(QSalidas, dAux) then
        begin
          ModificarSalida(QSalidas, dAux);
        end
        else
        begin
          result := result + InsertarSalida(QSalidas, dAux);
        end;
        next;
      end;
      Close;
    end;
  finally
    FreeAndNil(QSalidas);
  end;
end;

function TransitosIndirectos(const AUsuario, AEmpresa, ACentroOrigen, AReferencia,
  AFechaTransito, AFechaSalida, AProducto, ACliente,
  ACategoria: string): integer;
begin
  result := 0;
  with QTransitosIndirectos do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentroOrigen;
    ParamByName('referencia').AsString := AReferencia;
    ParamByName('fecha').AsDate := StrToDate(AFechaTransito);
    ParamByName('producto').AsString := AProducto;


    Open;
    while not Eof do
    begin
      InsertarTransito(AUsuario, AEmpresa,
        Fields[1].AsString, Fields[2].AsString, Fields[3].AsString,
        ACentroOrigen, AReferencia, AFechaTransito,
        AFechaSalida, AProducto, ACliente, ACategoria,
        Fields[5].AsFloat);
        (*
        result:= result + InsertarSalidasTransito( AUsuario, Fields[0].AsString, Fields[4].AsString,
                                          Fields[2].AsString, Fields[3].AsString, AFechaSalida,
                                          AProducto, ACliente, ACategoria );
        *)
        (*
        result:= result + TransitosIndirectos( AUsuario, Fields[0].AsString, Fields[1].AsString,
                                          Fields[2].AsString, Fields[3].AsString, AFechaSalida,
                                          AProducto, ACliente, ACategoria );
        *)
      next;
    end;
    Close;
  end;
end;


function TransitosDirectos(const AUsuario, AEmpresa, ACentroOrigen, AProducto, ACategoria, ACliente: string;
  const AFechaIni, AFechaFin: TDateTime): integer;
begin
  result := 0;
  with QTransitosDirectos do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentroOrigen;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fechaini').AsDate := AFechaIni;
    ParamByName('fechafin').AsDate := AFechaFin;

    Open;
    while not Eof do
    begin
        //EN LOS TRANSITOS DIRECTOS LA FECHA DE SALIDA COINCIDE CON LA DEL TRANSITO
      result := result + InsertarSalidasTransito(AUsuario, Fields[0].AsString, Fields[1].AsString,
        Fields[2].AsString, Fields[3].AsString, Fields[3].AsString,
        AProducto, ACliente, ACategoria);
      result := result + TransitosIndirectos(AUsuario, Fields[0].AsString, Fields[1].AsString,
        Fields[2].AsString, Fields[3].AsString, Fields[3].AsString,
        AProducto, ACliente, ACategoria);
      next;
    end;
    Close;
  end;
end;


function SalidasDirectas(const AUsuario, AEmpresa, ACentroOrigen, AProducto, ACategoria, ACliente: string;
  const AFechaIni, AFechaFin: TDateTime): integer;
begin
  with QAux do
  begin
    SQL.Clear;

    SQL.Add('insert into tmp_sal_resumen ');
    SQL.Add('select ' + QuotedStr(AUsuario) + ', ');
    SQL.Add('       empresa_sl, ');
    SQL.Add('       centro_salida_sl, ');
    SQL.Add('       producto_sl, ');
    SQL.Add('       categoria_sl, ');
    SQL.Add('       calibre_sl, ');
    SQL.Add('       envase_sl, ');
    SQL.Add('       cliente_sl, ');
    //SQL.Add( '       YEARANDWEEK(fecha_sl), ');
    SQL.Add('       ' + QuotedStr(AnyoSemana(AFechaIni)) + ', ');
    SQL.Add('       fecha_sl, '); //LA FECHA DE SALIDA DE LA FRUTA ES LA MISMA DEL ALBARAN
    SQL.Add('       fecha_sl, ');
    SQL.Add('       n_albaran_sl, ');
    SQL.Add('       ''EUR'', ');
    SQL.Add('       1, ');
    SQL.Add('       sum( nvl( n_palets_sl, 0 ) ), ');
    SQL.Add('       sum( nvl( cajas_sl, 0 ) ), ');
    SQL.Add('       sum( nvl( kilos_sl, 0 ) ), ');
    SQL.Add('       sum( nvl( importe_neto_sl, 0 ) ), ');
    SQL.Add('       sum(0),sum(0),sum(0), ');
    SQL.Add('       sum(0),sum(0),sum(0),sum(0), ');
    SQL.Add('       sum(0),sum(0),sum(0),sum(0), ');
    SQL.Add('       sum(0),sum(0),sum(0),sum(0),sum(0), ');
    SQL.Add('       sum(0),sum(0),sum(0),sum(0), ');
    SQL.Add('       sum(0),sum(0),sum(0),sum(0), ');
    SQL.Add('       sum(0),sum(0),sum(0),sum(0) ');

    SQL.Add('from frf_salidas_l, frf_salidas_c');
    SQL.Add('where empresa_sl = :empresa ');

    if bCentroOrigen then
    begin
      SQL.Add('  and ( nvl(es_transito_sc,0) =  0 ) ');
      SQL.Add('  and centro_origen_sl = :centro ');
      SQL.Add('  and ref_transitos_sl is null ');
    end
    else
    begin
      SQL.Add('  and centro_salida_sl = :centro ');
    end;

    SQL.Add('  and producto_sl = :producto  ');
    if ACategoria <> '' then
      SQL.Add('  and categoria_sl = :categoria ');
    if ACliente <> '' then
      SQL.Add('  and cliente_sl = :cliente ');
    SQL.Add('  and fecha_sl between :fechaini and :fechafin ');

    //TODOS LOS ALBARANES FACTURADOS O CON LINEAS CON PRECIO DISTINTO DE 0
    SQL.Add('  and empresa_sc = empresa_sl ');
    SQL.Add('  and centro_salida_sc = centro_salida_sl ');
    SQL.Add('  and n_albaran_sc = n_albaran_sl ');
    SQL.Add('  and fecha_sc = fecha_sl ');

    if bFacturado then
    begin
      SQL.Add('   and NVL( n_factura_sc, '''' ) <> ''''  ');
    end
    else
    if bValorado then
    begin
      SQL.Add('  and ( ( NVL( precio_sl, 0 ) <> 0 ) or ( NVL( n_factura_sc, '''' ) <> '''' ) ) ');
    end;

    (*ENSALADA*)
    (*SQL.Add('  and envase_sl <> ''324'' ');*)


    SQL.Add('group by 1,2,3,4,5,6,7,8,9,10,11,12 ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentroOrigen;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fechaini').AsDate := AFechaIni;
    ParamByName('fechafin').AsDate := AFechaFin;

    if ACategoria <> '' then
      ParamByName('categoria').AsString := ACategoria;
    if ACliente <> '' then
      ParamByName('cliente').AsString := ACliente;

    ExecSQL;
    result := RowsAffected;
  end;
end;

procedure GrabarMoneda(const AUsuario, AMoneda: string;
  const ACambio: Real);
begin
  with QGrabarMoneda do
  begin
    ParamByName('usuario').AsString := AUsuario;
    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('centro').AsString := QList.FieldByName('tcentro_sr').AsString;
    ParamByName('albaran').AsString := QList.FieldByName('tnum_albaran_sr').AsString;
    ParamByName('fecha').AsDate := QList.FieldByName('tfecha_albaran_sr').AsDateTime;
    ParamByName('moneda').AsString := AMoneda;
    ParamByName('cambio').AsFloat := ACambio;
    ExecSQL;
  end;
end;

procedure DatosMoneda(const AUsuario: string);
var
  rFactorCambio: real;
begin
  with QDatosMoneda do
  begin
    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('centro').AsString := QList.FieldByName('tcentro_sr').AsString;
    ParamByName('albaran').AsString := QList.FieldByName('tnum_albaran_sr').AsString;
    ParamByName('fecha').AsDate := QList.FieldByName('tfecha_albaran_sr').AsDateTime;

    Open;
    try
      if FieldByName('moneda_sc').AsString <> 'EUR' then
      begin
        rFactorCambio := FactorCambioLIQ(QList.FieldByName('tempresa_sr').AsString,
          FieldByName('n_factura_sc').AsString,
          FieldByName('fecha_factura_sc').AsString,
          FieldByName('moneda_sc').AsString,
          QList.FieldByName('tfecha_albaran_sr').AsString);
        GrabarMoneda(AUsuario, FieldByName('moneda_sc').AsString, rFactorCambio);
      end;
    finally
      Close;
    end;
  end;
end;

procedure SQLDistribucionGasto(const ATipo: string; const AValue: Real;
  var AGPalets, AGCajas, AGKilos, AGImporte: Real);
begin
  if ATipo = 'KILOS' then
  begin
    AGKilos := AValue;
  end
  else
    if ATipo = 'CAJAS' then
    begin
      AGCajas := AValue;
    end
    else
      if ATipo = 'IMPORTE' then
      begin
        AGImporte := AValue;
      end
      else
        if ATipo = 'PALETS' then
        begin
          AGPalets := AValue;
        end
        else //KILOS
        begin
          AGKilos := AValue;
        end;
end;

procedure GastosAlbaran(const AUsuario: string);
var
  AGPalets, AGCajas, AGKilos, AGImporte: Real;
begin
  AGPalets := 0;
  AGCajas := 0;
  AGKilos := 0;
  AGImporte := 0;

  with QGastosAlbaran do
  begin
    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('centro').AsString := QList.FieldByName('tcentro_sr').AsString;
    ParamByName('albaran').AsString := QList.FieldByName('tnum_albaran_sr').AsString;
    ParamByName('fecha').AsDate := QList.FieldByName('tfecha_albaran_sr').AsDateTime;

    Open;
    if not IsEmpty then
    begin
      while not EOF do
      begin
        SQLDistribucionGasto(Fields[0].AsString, Fields[1].AsFloat, AGPalets, AGCajas, AGKilos, AGImporte);
        Next;
      end;
      with QGrabarGastos do
      begin
        ParamByName('usuario').AsString := AUsuario;
        ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
        ParamByName('centro').AsString := QList.FieldByName('tcentro_sr').AsString;
        ParamByName('albaran').AsString := QList.FieldByName('tnum_albaran_sr').AsString;
        ParamByName('fecha').AsDate := QList.FieldByName('tfecha_albaran_sr').AsDateTime;
        ParamByName('gpalets').AsFloat := AGPalets;
        ParamByName('gcajas').AsFloat := AGCajas;
        ParamByName('gkilos').AsFloat := AGKilos;
        ParamByName('gimporte').AsFloat := AGImporte;
        ExecSQL;
      end;
    end;
    Close;
  end;

  AGPalets := 0;
  AGCajas := 0;
  AGKilos := 0;
  AGImporte := 0;
  with QGastosTenerife do
  begin
    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('centro').AsString := QList.FieldByName('tcentro_sr').AsString;
    ParamByName('albaran').AsString := QList.FieldByName('tnum_albaran_sr').AsString;
    ParamByName('fecha').AsDate := QList.FieldByName('tfecha_albaran_sr').AsDateTime;

    Open;
    if not IsEmpty then
    begin
      while not EOF do
      begin
        SQLDistribucionGasto(Fields[0].AsString, Fields[1].AsFloat, AGPalets, AGCajas, AGKilos, AGImporte);
        Next;
      end;
      with QGrabarGastosTen do
      begin
        ParamByName('usuario').AsString := AUsuario;
        ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
        ParamByName('centro').AsString := QList.FieldByName('tcentro_sr').AsString;
        ParamByName('albaran').AsString := QList.FieldByName('tnum_albaran_sr').AsString;
        ParamByName('fecha').AsDate := QList.FieldByName('tfecha_albaran_sr').AsDateTime;
        ParamByName('gtpalets').AsFloat := AGPalets;
        ParamByName('gtcajas').AsFloat := AGCajas;
        ParamByName('gtkilos').AsFloat := AGKilos;
        ParamByName('gtimporte').AsFloat := AGImporte;
        //ParamByName('gtenerife').AsFloat := QGastosTenerife.Fields[0].AsFloat;
        ExecSQL;
      end;
    end;
    Close;
  end;
end;

procedure TotalesAlbaran(const AUsuario: string);
var
  rPaletsTot, rCajasTot, rKilosTot, rImporteTot: real;
  rPaletsProd, rCajasProd, rKilosProd, rImporteProd: real;
  rPaletsTran, rCajasTran, rKilosTran, rImporteTran: real;
begin
  with QTotalesAlbaran do
  begin
    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('centro').AsString := QList.FieldByName('tcentro_sr').AsString;
    ParamByName('albaran').AsInteger := QList.FieldByName('tnum_albaran_sr').AsInteger;
    ParamByName('fecha').AsDate := QList.FieldByName('tfecha_albaran_sr').AsDateTime;

    Open;

    rPaletsTot := Fields[0].AsFloat;
    rCajasTot := Fields[1].AsFloat;
    rKilosTot := Fields[2].AsFloat;
    rImporteTot := Fields[3].AsFloat;
    rPaletsProd := Fields[4].AsFloat;
    rCajasProd := Fields[5].AsFloat;
    rKilosProd := Fields[6].AsFloat;
    rImporteProd := Fields[7].AsFloat;
    rPaletsTran := Fields[8].AsFloat;
    rCajasTran := Fields[9].AsFloat;
    rKilosTran := Fields[10].AsFloat;
    rImporteTran := Fields[11].AsFloat;

    Close;
  end;

  with QGrabarTotales do
  begin
    ParamByName('usuario').AsString := AUsuario;
    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('centro').AsString := QList.FieldByName('tcentro_sr').AsString;
    ParamByName('albaran').AsString := QList.FieldByName('tnum_albaran_sr').AsString;
    ParamByName('fecha').AsDate := QList.FieldByName('tfecha_albaran_sr').AsDateTime;
    ParamByName('palets').AsFloat := rPaletsTot;
    ParamByName('cajas').AsFloat := rCajasTot;
    ParamByName('kilos').AsFloat := rKilosTot;
    ParamByName('importe').AsFloat := rImporteTot;
    ParamByName('palets_prod').AsFloat := rPaletsProd;
    ParamByName('cajas_prod').AsFloat := rCajasProd;
    ParamByName('kilos_prod').AsFloat := rKilosProd;
    ParamByName('importe_prod').AsFloat := rImporteProd;
    ParamByName('tpalets').AsFloat := rPaletsTran;
    ParamByName('tcajas').AsFloat := rCajasTran;
    ParamByName('tkilos').AsFloat := rKilosTran;
    ParamByName('timporte').AsFloat := rImporteTran;
    ExecSQL;
  end;
end;

procedure CompletarDatosEx(const AUsuario: string);
begin
  DatosMoneda(AUsuario);
  TotalesAlbaran(AUsuario);
  GastosAlbaran(AUsuario);
end;

procedure CompletarDatos(const AUsuario: string);
begin
  with QList do
  begin
    SQL.Clear;
    SQL.Add(' select tempresa_sr, tcentro_sr, tfecha_albaran_sr, tnum_albaran_sr, tproducto_sr');
    SQL.Add(' from tmp_sal_resumen  ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' group by 1,2,3,4,5 ');
    ParamByName('usuario').AsString := AUsuario;

    Open;
  end;

  with QTotalesAlbaran do
  begin
    SQL.Clear;
    SQL.Add(' select sum( nvl( n_palets_sl, 0 ) ), ');
    SQL.Add('        sum( nvl( cajas_sl, 0 ) ), ');
    SQL.Add('        sum( nvl( kilos_sl, 0 ) ), ');
    SQL.Add('        sum( nvl( importe_neto_sl, 0 ) ), ');

    ;

    SQL.Add('        sum( nvl( case when producto_sl = ' + QuotedStr( QList.FieldByName('tproducto_sr').AsString ) + ' then n_palets_sl else 0 end, 0 ) ), ');
    SQL.Add('        sum( nvl( case when producto_sl = ' + QuotedStr( QList.FieldByName('tproducto_sr').AsString ) + ' then cajas_sl else 0 end, 0 ) ), ');
    SQL.Add('        sum( nvl( case when producto_sl = ' + QuotedStr( QList.FieldByName('tproducto_sr').AsString ) + ' then kilos_sl else 0 end, 0 ) ), ');
    SQL.Add('        sum( nvl( case when producto_sl = ' + QuotedStr( QList.FieldByName('tproducto_sr').AsString ) + ' then importe_neto_sl else 0 end, 0 ) ), ');

    SQL.Add('        sum( nvl( case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) = 1 ) ) then n_palets_sl else 0 end, 0 ) ), ');
    SQL.Add('        sum( nvl( case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) = 1 ) ) then cajas_sl else 0 end, 0 ) ), ');
    SQL.Add('        sum( nvl( case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) = 1 ) ) then kilos_sl else 0 end, 0 ) ), ');
    SQL.Add('        sum( nvl( case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) = 1 ) ) then importe_neto_sl else 0 end, 0 ) ) ');

    SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');
    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and n_albaran_sl = :albaran ');
    SQL.Add(' and fecha_sl = :fecha ');
  end;

  with QList do
  begin
    try
      while not EOF do
      begin
        CompletarDatosEx(AUsuario);
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

procedure GastosLinea(const AUsuario: string);
begin
  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tgasto_linea_sr = ( tgasto_palets_sr * tpalets_linea_sr ) / tpalets_total_sr ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tpalets_total_sr <> 0 ');
    ParamByName('usuario').AsString := AUsuario;
    ExecSQL;

    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tgasto_linea_sr = tgasto_linea_sr + ( tgasto_cajas_sr * tcajas_linea_sr ) / tcajas_total_sr ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tcajas_total_sr <> 0 ');
    ParamByName('usuario').AsString := AUsuario;
    ExecSQL;

    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tgasto_linea_sr = tgasto_linea_sr + ( tgasto_kilos_sr * tkilos_linea_sr ) / tkilos_total_sr ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tkilos_total_sr <> 0 ');
    ParamByName('usuario').AsString := AUsuario;
    ExecSQL;

    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tgasto_linea_sr = tgasto_linea_sr + ( tgasto_importe_sr * timporte_linea_sr ) / timporte_total_sr ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and timporte_total_sr <> 0 ');
    ParamByName('usuario').AsString := AUsuario;
    ExecSQL;
  end;
end;

procedure GastosTenerife(const AUsuario: string);
begin
  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tgasto_tenerife_sr = ( tgasto_tpalets_sr * tpalets_tran_linea_sr ) / tpalets_tran_total_sr ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tpalets_tran_total_sr <> 0 ');
    ParamByName('usuario').AsString := AUsuario;
    ExecSQL;

    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tgasto_tenerife_sr = tgasto_tenerife_sr + ( tgasto_tcajas_sr * tcajas_tran_linea_sr ) / tcajas_tran_total_sr ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tcajas_tran_total_sr <> 0 ');
    ParamByName('usuario').AsString := AUsuario;
    ExecSQL;

    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tgasto_tenerife_sr = tgasto_tenerife_sr + ( tgasto_tkilos_sr * tkilos_tran_linea_sr ) / tkilos_tran_total_sr ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tkilos_tran_total_sr <> 0 ');
    ParamByName('usuario').AsString := AUsuario;
    ExecSQL;

    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tgasto_tenerife_sr = tgasto_tenerife_sr + ( tgasto_timporte_sr * timporte_tran_linea_sr ) / timporte_tran_total_sr ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and timporte_tran_total_sr <> 0 ');
    ParamByName('usuario').AsString := AUsuario;
    ExecSQL;
  end;
end;

(*
procedure ComisionDescuentoEx(const AUsuario: string);
var
  rComision, rDescuento: real;
begin
  with QAux do
  begin
    SQL.Clear;

    SQL.Add(' select GetDescuentoCliente( empresa_c, cliente_c, :fecha, 2) descuento, ');
    SQL.Add('    GetComisionCliente( empresa_c, cliente_c, :fecha) comision ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add(' and cliente_c = :cliente ');

    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('cliente').AsString := QList.FieldByName('tcliente_sr').AsString;
    ParamByName('fecha').AsDate := QList.FieldByName('tfecha_albaran_sr').AsDateTime;

    Open;
    rDescuento := Fields[0].AsFloat;
    rComision := Fields[1].AsFloat;
    Close;
  end;

  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tcomision_linea_sr = ( timporte_linea_sr * ( :comision / 100 ) )  ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tempresa_sr = :empresa ');
    SQL.Add(' and tcliente_sr = :cliente ');
    ParamByName('usuario').AsString := AUsuario;
    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('cliente').AsString := QList.FieldByName('tcliente_sr').AsString;
    ParamByName('comision').AsFloat := rComision;
    ExecSQL;

    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tdescuento_linea_sr = ( ( timporte_linea_sr - tcomision_linea_sr ) * ( :descuento / 100 ) )  ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tempresa_sr = :empresa ');
    SQL.Add(' and tcliente_sr = :cliente ');
    ParamByName('usuario').AsString := AUsuario;
    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('cliente').AsString := QList.FieldByName('tcliente_sr').AsString;
    ParamByName('descuento').AsFloat := rDescuento;
    ExecSQL;
  end;
end;
*)

procedure DescuentoEx(const AUsuario: string);
begin
  with QAux do
  begin
    Close;
    SQL.Clear;

    SQL.Add(' select * ');
    SQL.Add(' from frf_descuentos_cliente ');
    SQL.Add(' where empresa_dc = :empresa  ');
    SQL.Add(' and cliente_dc = :cliente ');
    SQL.Add(' order by fecha_ini_dc asc ');

    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('cliente').AsString := QList.FieldByName('tcliente_sr').AsString;

    try
      Open;
    except
      Close;
      Exit;
    end;
  end;

  while not QAux.Eof do
  with QAux2 do
  begin

    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tdescuento_linea_sr = ( ( timporte_linea_sr - tcomision_linea_sr ) * ( :descuento / 100 ) )  ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tempresa_sr = :empresa ');
    SQL.Add(' and tcliente_sr = :cliente ');
    SQL.Add(' and tfecha_albaran_sr between :ini and :fin ');
    ParamByName('usuario').AsString := AUsuario;
    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('cliente').AsString := QList.FieldByName('tcliente_sr').AsString;
    ParamByName('ini').AsDate := QAux.FieldByName('fecha_ini_dc').AsDateTime;
    if QAux.FieldByName('fecha_fin_dc').AsString = '' then
      ParamByName('fin').AsDate := Date
    else
      ParamByName('fin').AsDate := QAux.FieldByName('fecha_fin_dc').AsDateTime;
    ParamByName('descuento').AsFloat := QAux.FieldByName('facturable_dc').AsFloat + QAux.FieldByName('no_facturable_dc').AsFloat;
    ExecSQL;
    QAux.Next;
  end;
  QAux.Close;
end;

procedure ComisionEx(const AUsuario: string);
var
  saux: string;
begin
  with QAux do
  begin
    SQL.Clear;

    SQL.Add(' select representante_c ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where empresa_c = :empresa  ');
    SQL.Add(' and cliente_c = :cliente ');

    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('cliente').AsString := QList.FieldByName('tcliente_sr').AsString;

    Open;
    saux:= Fields[0].AsString;
    close;

    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_representantes_comision ');
    SQL.Add(' where empresa_rc = :empresa ');
    SQL.Add(' and representante_rc = :aux ');
    SQL.Add(' order by fecha_ini_rc asc ');

    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('aux').AsString := sAux;

    Open;

  end;

  while not QAux.Eof do
  with QAux2 do
  begin
    SQL.Clear;
    SQL.Add(' update tmp_sal_resumen ');
    SQL.Add(' set tcomision_linea_sr = ( timporte_linea_sr * ( :comision / 100 ) )  ');
    SQL.Add(' where tusuario_sr = :usuario ');
    SQL.Add(' and tempresa_sr = :empresa ');
    SQL.Add(' and tcliente_sr = :cliente ');
    SQL.Add(' and tfecha_albaran_sr between :ini and :fin ');
    ParamByName('usuario').AsString := AUsuario;
    ParamByName('empresa').AsString := QList.FieldByName('tempresa_sr').AsString;
    ParamByName('cliente').AsString := QList.FieldByName('tcliente_sr').AsString;

    ParamByName('ini').AsDate := QAux.FieldByName('fecha_ini_rc').AsDateTime;
    if QAux.FieldByName('fecha_fin_rc').AsString = '' then
      ParamByName('fin').AsDate := Date
    else
      ParamByName('fin').AsDate := QAux.FieldByName('fecha_fin_rc').AsDateTime;
    ParamByName('comision').AsFloat := QAux.FieldByName('comision_rc').AsFloat;
    ExecSQL;

    QAux.Next;
  end;
  QAux.Close;
end;

procedure ComisionDescuento(const AUsuario: string);
begin
  with QList do
  begin
    SQL.Clear;
    SQL.Add(' select tempresa_sr, tcliente_sr ');
    SQL.Add(' from tmp_sal_resumen where tusuario_sr = :usuario ');
    SQL.Add(' group by 1,2 ');
    ParamByName('usuario').AsString := AUsuario;

    Open;
    try
      while not EOF do
      begin
        //ComisionDescuentoEx(AUsuario);
        ComisionEx(AUsuario);
        DescuentoEx(AUsuario);

        Next;
      end;
    finally
      Close;
    end;
  end;
end;

function SalidasSemanal(const AUsuario, AEmpresa, ACentroOrigen, AProducto,
  ACategoria, ACliente: string;
  const AFechaIni, AfechaFin: TDateTime): Integer;
begin
  //Result:= 0;
  Result := SalidasDirectas(AUsuario, AEmpresa, ACentroOrigen, AProducto,
    ACategoria, ACliente, AFechaIni, AFechaFin);
  if bCentroOrigen then
  begin
    //TENER EN CUENTA LOS TRANSITOS CUANDO QUEREMOS SABER A CUANTO SE VENDIO
    //LA FRUTA QUE SALIO DEL CENTRO X
    Result := Result + TransitosDirectos(AUsuario, AEmpresa, ACentroOrigen, AProducto,
      ACategoria, ACliente, AFechaIni, AFechaFin);
  end;
end;

function GetKilosIgnorar(const AEmpresa, ACentro, ARef, AFecha, AFechaInicial,
  AProducto, ACategoria: string): Real;
var
  QSelect: TQuery;
begin
  QSelect := TQuery.Create(Application);
  QSelect.DatabaseName := 'BDProyecto';

  try
    with QSelect do
    begin
      SQL.Add(' select nvl( sum( kilos_tl ), 0 ) kilos ');
      SQL.Add(' from frf_transitos_l ');
      SQL.Add(' where empresa_tl = :empresa ');
      SQL.Add('   and centro_tl = :centro ');
      SQL.Add('   and referencia_tl = :ref ');
      SQL.Add('   and fecha_tl = :fecha ');
      SQL.Add('   and fecha_origen_tl < :corte ');
      SQL.Add('   and producto_tl = :producto ');
      if ACategoria <> '' then
        SQL.Add('   and categoria_tl = :categoria ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('ref').AsString := ARef;
      ParamByName('fecha').AsString := AFecha;
      ParamByName('corte').AsString := AFechaInicial;
      ParamByName('producto').AsString := AProducto;
      if ACategoria <> '' then
        ParamByName('categoria').AsString := ACategoria;

      Open;
      result := Fields[0].AsFloat;
      Close;
    end;
  finally
    FreeAndNil(QSelect);
  end;
end;

procedure SalidasTransitoIndirecto(var AQuery: TQuery; const AUsuario: string;
  const AEmpresa, AOrigen, ARef, AFecha, AProducto, ACliente, ACategoria: string);
begin
  //Es la misma query que utilizo para sacar salidas de transitos directos
  with AQuery do
  begin
    SQL.Clear;

    SQL.Add('select ' + QuotedStr(AUsuario) + ',');
    SQL.Add('       empresa_sl, ');
    SQL.Add('       centro_salida_sl, ');
    SQL.Add('       producto_sl, ');
    SQL.Add('       categoria_sl, ');
    SQL.Add('       calibre_sl, ');
    SQL.Add('       envase_sl, ');
    SQL.Add('       cliente_sl, ');
    SQL.Add('       fecha_sl, ');
    SQL.Add('       n_albaran_sl, ');
    SQL.Add('       ''EUR'', ');
    SQL.Add('       1, ');
    SQL.Add('       sum( nvl( n_palets_sl, 0 ) ) palets, ');
    SQL.Add('       sum( nvl( cajas_sl, 0 ) ) cajas, ');
    SQL.Add('       sum( nvl( kilos_sl, 0 ) ) kilos, ');
    SQL.Add('       sum( nvl( importe_neto_sl, 0 ) ) importe');

    SQL.Add('from frf_salidas_l, frf_salidas_c');
    SQL.Add('where empresa_sl = :empresa ');
    SQL.Add('  and centro_origen_sl = :centro ');
    SQL.Add('  and ref_transitos_sl = :referencia ');
    SQL.Add('  and producto_sl = :producto  ');
    if ACategoria <> '' then
      SQL.Add('  and categoria_sl = :categoria ');
    if ACliente <> '' then
      SQL.Add('  and cliente_sl = :cliente ');
      SQL.Add('  and fecha_sl between ( :fecha - 30 ) and ( :fecha + 60 ) ');

    //TODOS LOS ALBARANES FACTURADOS O CON LINEAS CON PRECIO DISTINTO DE 0
    SQL.Add('  and empresa_sc = empresa_sl ');
    SQL.Add('  and centro_salida_sc = centro_salida_sl ');
    SQL.Add('  and n_albaran_sc = n_albaran_sl ');
    SQL.Add('  and fecha_sc = fecha_sl ');

    if bFacturado then
    begin
      SQL.Add('   and NVL( n_factura_sc, '''' ) <> ''''  ');
    end
    else
      if bValorado then
      begin
        SQL.Add('  and ( ( NVL( precio_sl, 0 ) <> 0 ) or ( NVL( n_factura_sc, '''' ) <> '''' ) ) ');
      end;

    SQL.Add('group by 1,2,3,4,5,6,7,8,9,10,11 ');
    SQL.Add('order by 9,10,15 ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := AOrigen;
    ParamByName('fecha').AsDate := StrToDate(AFecha);
    ParamByName('referencia').AsString := ARef;
    ParamByName('producto').AsString := AProducto;

    if ACategoria <> '' then
      ParamByName('categoria').AsString := ACategoria;
    if ACliente <> '' then
      ParamByName('cliente').AsString := ACliente;

    Open;
  end;
end;

//Dev lo que sobra del ultimo albaran

function IgnorarKilosSalidas(const AQuery: TQuery; const AValue: Real): Real;
var
  rKilos: real;
begin
  rKilos := AQuery.fieldByName('kilos').AsFloat;
  while rKilos < AValue do
  begin
    AQuery.Next;
    rKilos := rkilos + AQuery.fieldByName('kilos').AsFloat;
    if rKilos = 0 then
      Break;
  end;
  result := rKilos - AValue;
end;


function InsertarSalidaEx(const ADataSet: TDataSet; const AFecha: TDateTime;
  const AKilos: Real): integer;
var
  QInsert: TQuery;
begin
  (*PARCHE 17/01/2007*)
  (*Hasta ahora no se habian tenido en cuenta estos gastos*)
  (*
  result:= 0;
  Exit;
  *)

  result := 1;
  QInsert := TQuery.Create(Application);
  QInsert.DatabaseName := 'BDProyecto';
  try
    with QInsert do
    begin
      SQL.Clear;

      SQL.Add('insert into tmp_sal_resumen values (');

      SQL.Add(' :usuario, ');
      SQL.Add(' :empresa, ');
      SQL.Add(' :centro, ');
      SQL.Add(' :producto, ');
      SQL.Add(' :categoria, ');
      SQL.Add(' :calibre, ');
      SQL.Add(' :envase, ');
      SQL.Add(' :cliente, ');
      SQL.Add(' :anyosemana, ');
      SQL.Add(' :fecha_sal, ');
      SQL.Add(' :fecha_alb, ');
      SQL.Add(' :n_albaran, ');
      SQL.Add(' :moneda, ');
      SQL.Add(' :cambio, ');
      SQL.Add(' :palets, ');
      SQL.Add(' :cajas, ');
      SQL.Add(' :kilos, ');
      SQL.Add(' :importe, ');

      SQL.Add(' 0, 0, 0,');
      SQL.Add(' 0, 0, 0, 0,');
      SQL.Add(' 0, 0, 0, 0, ');


      SQL.Add(' 0, ');
      SQL.Add(' 0, 0, 0, 0, ');
      SQL.Add(' 0, 0, 0, 0, ');
      SQL.Add(' 0, 0, 0, 0, ');
      SQL.Add(' 0, 0, 0, 0 ) ');
      SQL.Add(' 0, 0, 0, 0 ) ');


      Params[0].AsString := ADataSet.Fields[0].AsString;
      Params[1].AsString := ADataSet.Fields[1].AsString;
      Params[2].AsString := ADataSet.Fields[2].AsString;
      Params[3].AsString := ADataSet.Fields[3].AsString;
      Params[4].AsString := ADataSet.Fields[4].AsString;
      Params[5].AsString := ADataSet.Fields[5].AsString;
      Params[6].AsString := ADataSet.Fields[6].AsString;
      Params[7].AsString := ADataSet.Fields[7].AsString;
      Params[8].AsString := AnyoSemana(AFecha);
      Params[9].AsDateTime := AFecha;
      Params[10].AsDateTime := ADataSet.Fields[8].AsDateTime;
      Params[11].AsInteger := ADataSet.Fields[9].AsInteger;
      Params[12].AsString := ADataSet.Fields[10].AsString;
      Params[13].AsFloat := ADataSet.Fields[11].AsFloat;
      if ADataSet.FieldByName('kilos').AsFloat = 0 then
      begin
        ParamByName('palets').asFloat := 0;
        ParamByName('cajas').asFloat := 0;
        ParamByName('kilos').asFloat := 0;
        ParamByName('importe').asFloat := 0;
      end
      else
      begin
        ParamByName('palets').asFloat := bRoundTo((ADataSet.FieldByName('palets').AsFloat * Akilos) / ADataSet.FieldByName('kilos').AsFloat, 0);
        ParamByName('cajas').asFloat := bRoundTo((ADataSet.FieldByName('cajas').AsFloat * Akilos) / ADataSet.FieldByName('kilos').AsFloat, 0);
        ParamByName('kilos').asFloat := AKilos;
        ParamByName('importe').asFloat := bRoundTo((ADataSet.FieldByName('importe').AsFloat * Akilos) / ADataSet.FieldByName('kilos').AsFloat, -2);
      end;
      ExecSQL;
    end;
  finally
    FreeAndNil(QInsert);
  end;
end;


function PasarAlbaranes(const ATransitos, ASalidas: TQuery;
  const AFechaInicio: string;
  var ASobran: Real): Integer;
var
  rKilosTransito, rKilosQuedan, rKilosPasar: Real;
begin
  result := 0;
  rKilosTransito := ATransitos.fieldByName('tkgs_ti').AsFloat;

  if rKilosTransito <= ASobran then
  begin
    ASobran := ASobran - rKilosTransito;
    InsertarSalidaEx(ASalidas, StrToDate(AFechaInicio), rKilosTransito);
    result := result + 1;
    if ASobran = 0 then
      ASalidas.Next;
  end
  else
  begin
    rKilosQuedan := rKilosTransito;
    rKilosPasar := ASobran;
    while (rKilosQuedan > rKilosPasar) and (not ASalidas.Eof) do
    begin
      InsertarSalidaEx(ASalidas, StrToDate(AFechaInicio), rKilosPasar);
      result := result + 1;
      ASalidas.Next;
      rKilosQuedan := rKilosQuedan - rKilosPasar;
      rKilosPasar := ASalidas.FieldByName('kilos').AsFloat;
    end;
    if not ASalidas.Eof then
    begin
      ASobran := rKilosPasar - rKilosQuedan;
      InsertarSalidaEx(ASalidas, StrToDate(AFechaInicio), rKilosQuedan);
      result := result + 1;
      if ASobran = 0 then
        ASalidas.Next;
    end;
  end;
end;

function SalidasTransitosInDirectos(const AUsuario: string): Integer;
var
  QSelect, QSalidas: TQuery;
  sCentro, sRef, sFecha: string;
  rKilosIgnorar, rSobran: Real;
begin
  QSelect := TQuery.Create(Application);
  QSelect.DatabaseName := 'BDProyecto';
  QSalidas := TQuery.Create(Application);
  QSalidas.DatabaseName := 'BDProyecto';

  try
    with QSelect do
    begin
      SQL.Add(' select * ');
      SQL.Add(' from tmp_tran_indirect ');
      SQL.Add(' where tusuario_ti = :usuario ');
      SQL.Add(' order by tusuario_ti, tempresa_ti, tcentro_transito_ti, tfecha_transito_ti, tref_transito_ti, ');
      SQL.Add('          tcentro_origen_ti, tfecha_origen_ti, tref_origen_ti, ');
      SQL.Add('          tproducto_ti, tcliente_ti, tcategoria_ti  ');
      ParamByName('usuario').AsString := AUsuario;

      Open;
      sCentro := '';
      sRef := '';
      sFecha := '';
      rSobran := 0;
      result := 0;
      while not EOF do
      begin
        if not ((sCentro = FieldByName('tcentro_transito_ti').asString) and
          (sRef = FieldByName('tref_transito_ti').asString) and
          (sFecha = FieldByName('tfecha_transito_ti').asString)) then
        begin
          sCentro := FieldByName('tcentro_transito_ti').asString;
          sRef := FieldByName('tref_transito_ti').asString;
          sFecha := FieldByName('tfecha_transito_ti').asString;

          SalidasTransitoIndirecto(QSalidas, AUsuario,
            FieldByName('tempresa_ti').asString,
            FieldByName('tcentro_origen_ti').asString,
            FieldByName('tref_transito_ti').asString,
            FieldByName('tfecha_transito_ti').asString,
            FieldByName('tproducto_ti').asString,
            FieldByName('tcliente_ti').asString,
            FieldByName('tcategoria_ti').asString);

          rKilosIgnorar := GetKilosIgnorar(FieldByName('tempresa_ti').asString,
            FieldByName('tcentro_transito_ti').asString,
            FieldByName('tref_transito_ti').asString,
            FieldByName('tfecha_transito_ti').asString,
            FieldByName('tfecha_origen_ti').asString,
            FieldByName('tproducto_ti').asString,
            FieldByName('tcategoria_ti').asString);


          rSobran := IgnorarKilosSalidas(QSalidas, rKilosIgnorar);

          result := result + PasarAlbaranes(QSelect, QSalidas, FieldByName('tfecha_salida_ti').asString, rSobran);
        end
        else
        begin
          result := result + PasarAlbaranes(QSelect, QSalidas, FieldByName('tfecha_salida_ti').asString, rSobran);
        end;
        Next;
      end;
      Close;
    end;
  finally
    FreeAndNil(QSelect);
    FreeAndNil(QSalidas);
  end;
end;

function SalidasResumen(const AUsuario, AEmpresa, ACentroOrigen, AProducto,
  ACategoria, ACliente, AFechaIni, AFechaFin: string): Integer;
var
  ini, fin, lunes, domingo: TDateTime;
begin
  ini := StrToDate(AFechaIni);
  lunes := bTimeUtils.LunesAnterior(ini);
  fin := StrToDate(AFechaFin);
  domingo := bTimeUtils.DomingoSiguiente(fin);
  result := 0;

  if ini <= fin then
  begin
    if (domingo - lunes) = 6 then
    begin
      result := SalidasSemanal(AUsuario, AEmpresa, ACentroOrigen, AProducto, ACategoria, ACliente, ini, fin); //Solo pedimos datos de una semana
    end
    else
    begin  //Hay datos de por lo menos dos semanas
      result := SalidasSemanal(AUsuario, AEmpresa, ACentroOrigen, AProducto, ACategoria, ACliente, ini, DomingoSiguiente(ini)); //Pedazo semana inicial
      result := result + SalidasSemanal(AUsuario, AEmpresa, ACentroOrigen, AProducto, ACategoria, ACliente, LunesAnterior(fin), fin); //Pedazo semana final
      ini := DomingoSiguiente(ini) + 1; //Lunes siguiente
      fin := LunesAnterior(fin) - 1;  //Domingo anterior
      while ini < fin do  //Resto Semanas
      begin
        result := result + SalidasSemanal(AUsuario, AEmpresa, ACentroOrigen, AProducto, ACategoria, ACliente, ini, ini + 6);
        ini := ini + 7;
      end;
    end;
  end;

  if bCentroOrigen then
  begin
    Result := Result + SalidasTransitosInDirectos(AUsuario);
  end;

end;

function RellenarTabla(const AUsuario, AEmpresa, ACentroOrigen, AProducto,
  AFechaIni, AFechaFin, ACategoria, ACliente: string): Integer;
//var
//  i: cardinal;
begin
  //i:= GetTickCount;
  BorrarDatosActuales(AUsuario); //

  Result := SalidasResumen(AUsuario, AEmpresa, ACentroOrigen, AProducto,
    ACategoria, ACliente, AFechaIni, AFechaFin);
  if Result > 0 then
  begin
    //REALIZAR SI HAY DATOS
    if bCompletar then
    begin
      CompletarDatos(AUsuario);
      if boolComision then
        ComisionDescuento(AUsuario); //
      if boolGastos  then
      begin
        GastosLinea(AUsuario); //
        GastosTenerife(AUsuario); //
      end;
    end;
  end;
  //ShowMessage( IntToStr( GetTickCount - i ) );
end;

function Ejecutar(const AUsuario, AEmpresa, ACentroOrigen, AProducto,
  AFechaIni, AFechaFin: string;
  const ACategoria: string = '';
  const ACliente: string = ''): integer;
begin
  if bInicializado and bConfigurado then
  begin
    try
      result := RellenarTabla(AUsuario, AEmpresa, ACentroOrigen, AProducto,
        AFechaIni, AFechaFin, ACategoria, ACliente);
    except
      //Error imprevisto
      result := -3;
    end;
  end
  else
  begin
    if not bInicializado then
    begin
      //No inicializado
      result := -1;
    end
    else
    begin
      //No configurado
      result := -2;
    end;
  end;
  bConfigurado := False;
end;

initialization
  QAux := TQuery.Create(Application);
  QAux.DatabaseName := 'BDProyecto';
  QList := TQuery.Create(Application);
  QList.DatabaseName := 'BDProyecto';
  QAux2 := TQuery.Create(Application);
  QAux2.DatabaseName := 'BDProyecto';

(*
finalization
  if QAux <> nil then
    FreeAndNil(QAux);
  if QList <> nil then
    FreeAndNil(QList);
*)

end.

