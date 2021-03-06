unit UDMCalculoPosei;

interface

uses
  SysUtils, Classes, DBTables, DB, Forms, Dialogs, kbmMemTable, UDMAuxDB, Variants, bMath, CVariables, StdCtrls;

type
  TDMCalculoPosei = class(TDataModule)
    QTransito: TQuery;
    QPacking: TQuery;
    QAlbaran: TQuery;
    QFactura: TQuery;
    QPosei: TQuery;
    QBorrarPosei: TQuery;
    QAlbaranResto: TQuery;
    QAux: TQuery;
    QDescProducto: TQuery;
    QDescCliente: TQuery;
    QDescCentro: TQuery;
    QGastoAlbaran: TQuery;
    QAlbaranAgrupado: TQuery;
    kmtAlbPartidos: TkbmMemTable;
    kmtAlbPartidosempresa_alb: TStringField;
    kmtAlbPartidoscentro_alb: TStringField;
    kmtAlbPartidosnumero_alb: TIntegerField;
    kmtAlbPartidosfecha_alb: TDateTimeField;
    kmtAlbPartidoskilos_alb: TCurrencyField;
    kmtAlbPartidosproducto_alb: TStringField;
    kmtAlbPartidosempresa_fac_alb: TStringField;
    kmtAlbPartidosserie_fac_alb: TStringField;                            
    kmtAlbPartidosnumero_fac_alb: TIntegerField;
    kmtAlbPartidosfecha_fac_alb: TDateTimeField;
    kmtAlbPartidoscajas_alb: TIntegerField;
    QAlbaranDirecto: TQuery;
    kmtInforme: TkbmMemTable;
    StringField1: TStringField;
    kmtInformecentro_transito_p: TStringField;
    kmtInformeanyo_p: TIntegerField;
    kmtInformesemestre_p: TIntegerField;
    kmtInformeproducto_p: TStringField;
    kmtInformeref_transito_p: TIntegerField;
    kmtInformefecha_transito_p: TDateField;
    kmtInformecajas_transito_p: TIntegerField;
    kmtInformekilos_transito_p: TCurrencyField;
    kmtInformefecha_llegada: TDateField;
    kmtInformedua_llegada: TStringField;
    kmtInformecodigo_factura_p: TStringField;
    kmtInformefecha_factura: TDateField;
    kmtInformecajas: TIntegerField;
    kmtInformekilos: TCurrencyField;
    kmtInformeimporte: TCurrencyField;
    QConsulta: TQuery;
    QDeposito: TQuery;
    kmtInformedua_salida: TStringField;
    kmtInformeimporte_factura: TCurrencyField;
    kmtControl: TkbmMemTable;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    IntegerField3: TIntegerField;
    DateField1: TDateField;
    CurrencyField1: TCurrencyField;
    CurrencyField2: TCurrencyField;
    kmtControldiferencia: TFloatField;
    kmtInformedefinitivo: TStringField;
    kmtControldefinitivo: TStringField;
    QPoseiTemp: TQuery;
    QPoseiTemp2: TQuery;
  private
    { Private declarations }
    iAnyo, iSemestre, iLinea: integer;
    sProducto, sAgrupacion, sDefinitivo: String;
    dFechaIni, dFechaFin: TDateTime;
    rKilosAsignados, rKilosPosei, rKilosParaAsignar, rKilosRestoTrans: real;
    rPrecioAlbaran: real;

    procedure CalcularPosei(var VLabel: TLabel);
    procedure PreparaQuerys;
    function BorrarPosei: boolean;
    procedure InsertarPosei (const AKilos: Real);
    procedure InsertarPoseiTemp;
//    procedure InsertarPoseiTemp2 (const AAnyo, ASemestre: integer; const AProductoT, AEmpresaT, ACentroT, ATransito, AFechaT, AOrden,
//                                 AEmpresaA, ACentroA, AAlbaran, AFechaA, AProductoA: String; const AKilosT, AKilosA, AKilosAsig: real);
    procedure InsertarPoseiAlbaran_1 (const AKilos: Real);
    procedure InsertarPoseiAlbaran_2 (const AKilos: Real);
    procedure InsertarPoseiAlbaran_3 (const AKilos: Real);
    procedure InsertarPoseiAlbaran_4 (const AKilos: Real);
    procedure BuscarPacking;
    procedure BuscarAlbaran_1;
    procedure BuscarAlbaran_2;
    function BuscarKilosPosei (const AEmpresa, ACentro, AAlbaran, AFecha, AProducto, AEnvase: string): real;
    function CalcularPrecioAlbaran( const AEmpresa, ACentro, AAlbaran, AFecha, AProducto: string): real;
    function BuscarKilosAsignadosTrans (const AEmpresa, ACentro, ATransito, AFecha, AProducto: string): real;
    procedure BuscarAlbDirecto;
    procedure BuscarDepositoAduana;

    procedure CrearQuerys;
    procedure CrearQDescProducto;
    procedure CrearQDescCliente;
    procedure CrearQDescCentro;
    procedure CrearQGastoAlbaran;
    procedure CrearQAlbaranAgrupado;
    function EjecutaQDescProducto (const AEmpresa, ACliente, AProducto, AFecha: string): Boolean;
    function EjecutaQDescCliente (const AEmpresa, ACliente, AFecha: string): Boolean;
    function EjecutaQDescCentro (const AEmpresa, ACliente, ACentro, AFecha: String): Boolean;
    function EjecutaQGastoAlbaran (const AEmpresa, ACentro, AAlbaran, AFecha: String): Boolean;
    function EjecutaQAlbaranAgrupado (const AEmpresa, ACentro, AAlbaran, AFecha, AProducto: String): boolean;
    procedure AddGastos(var AGastoFactAlb: Real);
    function EsProductoConGasto (const AProducto: string): Boolean;
    procedure AddGastoTotal( var AGastoFac: Real );
    procedure AddGastoProducto( var AGastoFac: Real );
    function PutGasto( const AUnidades: Real;  const AUnidadesTotal: string; var AFac: Real ): Boolean;

    procedure InsertarkmtInforme;
    procedure InsertarkmtControl;
    procedure ModificarkmtControl;

    function BuscarSigLinea: integer;



  public
    { Public declarations }
    procedure ObtenerDatos(AEmpresa, ACentro, AAgrupacion, AProducto: string; AFechaIni, AFechaFin: TDateTime; AAnyo, ASemestre: integer; ADefinitivo: String; var VLabel: TLabel);
    procedure CargarDatosInforme;
    procedure CargarDatosControl;

  end;

var
  DMCalculoPosei: TDMCalculoPosei;

implementation

{$R *.dfm}

procedure TDMCalculoPosei.ObtenerDatos(AEmpresa, ACentro, AAgrupacion, AProducto: String; AFechaIni, AFechaFin: TDateTime; AAnyo, ASemestre: integer; ADefinitivo: String; var VLabel: TLabel);
begin
  dFechaIni := AFechaIni;
  dFechaFin := AFechaFin;
  sProducto := AProducto;
  sAgrupacion := AAGrupacion;
  iAnyo := AAnyo;
  iSemestre := ASemestre;
  sDefinitivo := ADefinitivo;

  CrearQuerys;

  with QTransito do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add(' select distinct ''T'' tipo, empresa_tc empresa, centro_tc centro, centro_destino_tc centro_destino,                                                       ');
    SQL.Add('        referencia_tc referencia, fecha_tc fecha, fecha_entrada_tc fecha_entrada, producto_tl producto,                                                    ');
    SQl.Add('        sum(cajas_tl) cajas, sum(kilos_tl) kilos, sum(kilos_tl) kilos_posei                                                                                ');
    SQL.Add(' from frf_transitos_c                                                                                                                                      ');
    SQL.Add(' join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl and referencia_tc = referencia_tl and fecha_tc = fecha_tl                       ');
    SQL.Add(' join frf_depositos_aduana_c on empresa_dac = empresa_tc and centro_dac = centro_tc and referencia_dac = referencia_tc and fecha_dac = fecha_tc            ');
    SQL.Add(' where empresa_tc = :empresa                                                                                                                               ');
    SQL.Add('   and centro_tc = :centro                                                                                                                                 ');
    SQL.Add('   and fecha_tc between :fechaini and :fechafin                                                                                                            ');

    if Trim( AAgrupacion ) <> '' then
      SQL.Add(' and producto_tl in (select producto_a from frf_agrupacion where codigo_a = :agrupacion)                                                               ');

    if AProducto <> '' then
      SQL.Add(' and producto_tl = :producto                                                                                                                             ');

    SQL.Add('  group by empresa, centro, centro_destino, referencia, fecha, fecha_entrada, producto                                                                     ');


    SQL.Add(' union                     ');

    SQL.Add(' select distinct ''A'' tipo, empresa_sc empresa, centro_salida_sc centro, centro_salida_sc centro_destino,                                                 ');
    SQL.Add('        n_albaran_sc referencia, fecha_sc  fecha, fecha_sc fecha_entrada, producto_sl producto,                                                            ');
    SQL.Add('        sum(cajas_sl) cajas, sum(kilos_sl) kilos, sum(kilos_posei_sl) kilos_posei                                                                                                           ');
    SQL.Add(' from frf_salidas_c                                                                                                                                        ');
    SQL.Add(' join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl             ');
    SQL.Add(' join frf_depositos_aduana_c on empresa_dac = empresa_sc and centro_dac = centro_salida_sc and referencia_dac = n_albaran_sc and fecha_dac = fecha_sc      ');
    SQL.Add(' where empresa_sc = :empresa                                                                                                                               ');
    SQL.Add('   and centro_salida_sc = :centro                                                                                                                          ');
    SQL.Add('   and fecha_factura_sc between :fechaini and :fechafin                                                                                                    ');
    SQL.Add('   and fecha_sc between :fechaini and :fechafin                                                                                                            ');

    if Trim( AAgrupacion ) <> '' then
      SQL.Add(' and producto_sl in (select producto_a from frf_agrupacion where codigo_a = :agrupacion)                                                               ');

    if AProducto <> '' then
      SQL.Add(' and producto_sl = :producto                                                                                                                             ');

    SQL.Add(' group by empresa, centro, centro_destino, referencia, fecha, fecha_entrada, producto                                                                      ');
    SQL.Add(' order by tipo, empresa, centro, centro_destino, referencia, fecha, fecha_entrada, producto                                                                ');


    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    if AAgrupacion <> '' then
      ParamByName('agrupacion').AsString:= AAgrupacion;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;

    Open;
//    try
      if IsEmpty then
      begin
        ShowMessage('Sin datos para los parametros seleccionados.');
      end
      else
      begin
          CalcularPosei( VLabel);
      end;
//    except
//      raise Exception.Create('ATENCION! Se ha producido un error.');
//      exit;
//    end;

    ShowMessage (' Proceso finalizado correctamente.');
    Close;
  end;
end;

procedure TDMCalculoPosei.PreparaQuerys;
begin
  with QPacking do
  begin
    SQL.Clear;

    SQL.Add(' select orden_pl, empresa_pl, producto_pl, envase_pl, peso_neto_e,                                                                                               ');
    SQL.Add('        sum(cajas_pl) cajas_pl,                                                                                                                                  ');
    SQL.Add('        sum(case when peso_pl <> 0 then peso_pl else  cajas_pl * peso_neto_e end) kilos_pl                                                                       ');
    SQL.Add('  from frf_packing_list                                                                                                                                          ');
    SQL.Add('  left join frf_envases on envase_e = envase_pl                                                                                                                  ');
    SQL.Add(' where empresa_pl = :empresa                                                                                                                                     ');
    SQL.Add('   and ref_transito_pl = :transito                                                                                                                               ');
    SQL.Add('   and fecha_transito_pl = :fecha_transito                                                                                                                       ');
    SQL.Add('   and producto_pl = :producto                                                                                                                                   ');
    SQL.Add(' group by orden_pl, empresa_pl, producto_pl, envase_pl, peso_neto_e                                                                                              ');
    SQL.Add(' order by orden_pl, empresa_pl, producto_pl, envase_pl, peso_neto_e                                                                                              ');

    Prepare;
  end;

  with QDeposito do
  begin
    SQL.Clear;

    SQL.Add(' select dua_exporta_dac dua_salida, dvd_dac dua_llegada   ');
    SQL.Add('   from frf_depositos_aduana_c                            ');
    SQL.Add(' where empresa_dac = :empresa                             ');
    SQL.Add('   and centro_dac = :centro                               ');
    SQL.Add('   and referencia_dac = :referencia                       ');
    SQL.Add('   and fecha_dac = :fecha                                 ');

    Prepare;
  end;

  with QAlbaran do
  begin
    SQL.Clear;

    SQL.Add(' select empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc,                                                                                               ');
    SQL.Add('        empresa_fac_sc, serie_fac_sc, fecha_factura_sc, n_factura_sc, producto_sl, envase_sl,                                                               ');
    SQL.Add('        nvl(sum(cajas_sl),0) cajas, nvl(sum(kilos_sl),0) kilos, nvl(sum(kilos_posei_sl), 0) kilos_posei                                                     ');
    SQL.Add(' from frf_salidas_c                                                                                                                                         ');
    SQL.Add(' join frf_salidas_l on empresa_sl = empresa_sc and centro_salida_sl = centro_salida_sc and n_albaran_sl = n_albaran_sc and fecha_sl = fecha_sc              ');
    SQL.Add(' where empresa_sc = :empresa                                                                                                                                ');
    SQL.Add('   and centro_salida_sc = :centro                                                                                                                           ');
    SQL.Add('   and n_orden_sc = :orden                                                                                                                                  ');
    SQL.Add('   and producto_sl = :producto                                                                                                                              ');
    SQL.Add('   and envase_sl = :envase                                                                                                                                  ');
    SQL.Add('   and fecha_factura_sc between :fechaini and :fechafin                                                                                                     ');
    SQL.Add(' group by empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, empresa_fac_sc, serie_fac_sc, fecha_factura_sc, n_factura_sc, producto_sl, envase_sl        ');

    Prepare;
  end;

    with QAlbaranDirecto do
  begin
    SQL.Clear;

    SQL.Add(' select empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, empresa_fac_sc, serie_fac_sc, fecha_factura_sc, n_factura_sc,                     ');
    SQL.Add('        producto_sl, sum(cajas_sl) cajas_sl, sum(kilos_sl) kilos_sl, sum(kilos_posei_sl) kilos_posei_sl                                         ');
    SQL.Add(' from frf_salidas_c                                                                                                                             ');
    SQL.Add(' join frf_salidas_l on empresa_sl = empresa_sc and centro_salida_sl = centro_salida_sc and n_albaran_sl = n_albaran_sc and fecha_sl = fecha_sc  ');
    SQL.Add(' where empresa_sc = :empresa                                                                                                                    ');
    SQL.Add('   and centro_salida_sc = :centro                                                                                                               ');
    SQL.Add('   and fecha_sc = :fecha                                                                                                                        ');
    SQL.Add('   and n_albaran_sc = :albaran                                                                                                                  ');
    SQL.Add(' group by empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, empresa_fac_sc, serie_fac_sc, fecha_factura_sc, n_factura_sc, producto_sl       ');

    Prepare;
  end;

  with QFactura do
  begin
    SQL.Clear;

    SQL.Add(' select cod_factura_fc, fecha_factura_fc, importe_neto_fc importe_total, importe_neto_euros_fc importe_total_euros         ');
    SQL.Add(' from tfacturas_cab                                                                        ');
    SQL.Add(' where cod_empresa_fac_fc = :empresa_fac                                                   ');
    SQL.Add('   and cod_serie_fac_fc = :serie_fac                                                       ');
    SQL.Add('   and n_factura_fc = :numero_fac                                                          ');
    SQL.Add('   and fecha_factura_fc = :fecha_fac                                                       ');

    Prepare;
  end;

  with QAlbaranResto do
  begin
    SQL.Clear;

    SQL.Add(' select empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, empresa_fac_sc, serie_fac_sc, fecha_factura_sc, n_factura_sc,                             ');
    SQL.Add('        producto_sl, categoria_sl, sum(cajas_sl) cajas_sl, sum(kilos_sl) kilos_sl, sum(kilos_posei_sl) kilos_posei_sl                                   ');
    SQL.Add('  from frf_salidas_c                                                                                                                                    ');
    SQL.Add('  join frf_salidas_l on empresa_sl = empresa_sc and centro_salida_sl = centro_salida_sc and n_albaran_sl = n_albaran_sc and fecha_sl = fecha_sc         ');
    SQL.Add(' where empresa_sc = :empresa                                                                                                                            ');
    SQL.Add('   and centro_salida_sc = :centro                                                    ');  //Centro Destino Transito
    SQL.Add('   and producto_sl = :producto                                                                                                                          ');
    SQL.Add('   and fecha_sc between :fechaini and :fechafin                                      ');  //Fecha Transito + 30
    SQL.Add('   and fecha_factura_sc between :fechaini_tran and :fechafin_tran                    ');  //Facturado en el mismo periodo
    SQL.Add(' group by empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, empresa_fac_sc, serie_fac_sc, fecha_factura_sc, n_factura_sc, producto_sl, categoria_sl ');
    SQL.Add(' order by fecha_sc                                                                                                                                      ');

    Prepare;
  end;

  with QPosei do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add(' select * from frf_posei                      ');
    SQL.Add('  where anyo_p = :anyo                        ');
    SQL.Add('    and semestre_p = :semestre                ');
    if sProducto <> '' then
      SQL.Add('    and producto_p = :producto              ');
//    if sAgrupacion <> '' then
//      SQL.Add('    and producto_p in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');

    ParamByName('anyo').AsInteger :=  iAnyo;
    ParamByName('semestre').AsInteger :=  iSemestre;
    if sProducto <> '' then
      ParamByName('producto').AsString :=  sProducto;
//    if sAgrupacion <> '' then
//      ParamByName('agrupacion').AsString := sAgrupacion;

    Open;
  end;
{
  with QPoseiTemp do
  begin
    if Active then
      Close;

      SQL.Clear;
      SQL.Add(' select * from frf_posei_temp                 ');

      Open;
      if not IsEmpty then
        Delete;
  end;
}
end;

function TDMCalculoPosei.PutGasto(const AUnidades: Real;  const AUnidadesTotal: string; var AFac: Real): Boolean;
var
  rAux, rUnidadesTotal: Real;
begin
  rUnidadesTotal :=  QAux.FieldByName( AUnidadesTotal ).AsFloat;

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

procedure TDMCalculoPosei.AddGastos(var AGastoFactAlb: Real);
begin
  AGastoFactAlb := 0;

  QGastoAlbaran.First;
  while not QGastoAlbaran.Eof do
  begin
    if EsProductoConGasto (QAux.FieldByName('producto_sl').AsString) then
    begin
      if QGastoAlbaran.fieldByName('producto').AsString = '' then
        AddGastoTotal( AGastoFactAlb)
      else
        AddGastoProducto( AGastoFactAlb );
    end;

    QGastoAlbaran.Next;
  end;



end;

procedure TDMCalculoPosei.AddGastoTotal(var AGastoFac: Real);
var sKilos, sCajas, sPalets, sImporte: string;
begin
   sKilos := 'kilos_sl';
   sCajas := 'cajas_sl';
   sPalets := 'palet_sl';
   sImporte := 'importe_neto_sl';

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

procedure TDMCalculoPosei.AddGastoProducto(var AGastoFac: Real);
var sKilos, sCajas, sPalets, sImporte: string;
begin
  sKilos := 'kilos_sl';
  sCajas := 'cajas_sl';
  sPalets := 'palet_sl';
  sImporte := 'importe_neto_sl';

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

function TDMCalculoPosei.BorrarPosei: boolean;
begin

  Result := false;
  with QBorrarPosei do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add(' delete from frf_posei  ');
    SQL.Add('  where anyo_p = :anyo                        ');
    SQL.Add('    and semestre_p = :semestre                ');
    if sProducto <> '' then
      SQL.Add('    and producto_p = :producto                ');
    if sAgrupacion <> '' then
      SQL.Add('    and producto_p in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');

    ParamByName('anyo').AsInteger :=  iAnyo;
    ParamByName('semestre').AsInteger :=  iSemestre;
    if sProducto <> '' then
      ParamByName('producto').AsString :=  sProducto;
    if sAgrupacion <> '' then
      ParamByName('agrupacion').AsString := sAgrupacion;

    ExecSQL;

  finally
    result := true;
    QBorrarPosei.Close;
  end;

end;

procedure TDMCalculoPosei.CalcularPosei(var VLabel: TLabel);
begin

   // PROCESO
  // 1? Buscamos cargas directas en el Packing List (lo que realmente se ha vendido)
  // 2? Buscamos en albaranes de venta, una linea que contenga todos los kilos del transito, para que tengamos 1 transito --> 1 factura
  // 3? Buscamos en albaranes de venta, en muchas lineas hasta conseguir todos los kilos del transito

  // Borrar Informaci?n
  if not BorrarPosei then
  begin
    ShowMessage(' ERROR. No se puede borrar datos de POSEI para el A?o ' + IntToStr(iAnyo) + ' y Semestre ' + IntToStr(iSemestre) );
    Exit;
  end;

  //Preparamos Querys
  PreparaQuerys;
  if kmtAlbPartidos.Active then kmtAlbPartidos.Close;
  kmtAlbPartidos.Open;

   Application.ProcessMessages;

  //Proceso
  iLinea := BuscarSigLinea;

  while not QTransito.eof  do
  begin
    VLabel.caption:= '(1) Calculo POSEI: ' + QTransito.FieldByName('empresa').AsString + '  '
                                           + QTransito.FieldByName('centro').AsString + '  '
                                           + QTransito.FieldByName('referencia').AsString + '  '
                                           + QTransito.FieldByName('fecha').AsString + '  '
                                           + QTransito.FieldByName('producto').AsString;
    Application.ProcessMessages;

    //Buscar Datos de Deposito aduana
    BuscarDepositoAduana;

    rKilosAsignados := 0;
    rKilosRestoTrans := 0;
    //Transitos
    if QTransito.FieldByName('tipo').AsString = 'T' then
    begin
      //Buscar Packing List en Los Llanos
      BuscarPacking;
    end
    else
    //Albaranes Venta Directos
    begin
      BuscarAlbDirecto;
    end;

    QTransito.Next;
  end;


  QTransito.First;
  while not QTransito.Eof do
  begin
    VLabel.caption:= '(2) Calculo POSEI: ' + QTransito.FieldByName('empresa').AsString + '  '
                                           + QTransito.FieldByName('centro').AsString + '  '
                                           + QTransito.FieldByName('referencia').AsString + '  '
                                           + QTransito.FieldByName('fecha').AsString + '  '
                                           + QTransito.FieldByName('producto').AsString;
    Application.ProcessMessages;

    //Buscar Datos de Deposito aduana
    BuscarDepositoAduana;

    if QTransito.FieldByName('tipo').AsString = 'T' then
    begin
      rKilosAsignados := BuscarKilosAsignadosTrans(QTransito.FieldByName('empresa').AsString, QTransito.FieldByName('centro').AsString,
                                                   QTransito.FieldByName('referencia').AsString, QTransito.FieldByName('fecha').AsString, QTransito.FieldByName('producto').AsString) ;
      rKilosRestoTrans := QTransito.FieldByName('kilos').AsFloat - rKilosAsignados;

      //Buscar Albaranes sin orden de carga , 1 Linea que contenga todos los kilos del transito.
      if rKilosRestoTrans > 0 then
      begin
         BuscarAlbaran_1;
      end;

      rKilosRestoTrans := QTransito.FieldByName('kilos').AsFloat - rKilosAsignados;

      //Buscar Albaranes sin orden de carga , MUCHAS Linea que contenga  el total de kilos del transito
      if rKilosRestoTrans > 0 then
      begin
        BuscarAlbaran_2;
      end;

      //No se ha podido asignar kilos de salida
      if rKilosRestoTrans > 0 then
      begin
        //Insertamos en Tabla Posei
        InsertarPoseiAlbaran_4 (rKilosRestoTrans);
        Inc(iLinea);
      end;
    end;

    QTransito.Next;
  end;


end;

procedure TDMCalculoPosei.BuscarAlbaran_2;
begin

  kmtAlbPartidos.SortOn('empresa_alb;centro_alb;fecha_alb', []);
  kmtAlbPartidos.First;
  while not kmtAlbPartidos.Eof do
  begin
    if rKilosRestoTrans > 0 then
    begin
      if rKilosRestoTrans >= kmtAlbPartidos.FieldByName('kilos_alb').AsFloat then
        rKilosParaAsignar := kmtAlbPartidos.FieldByName('kilos_alb').AsFloat
      else
        rKilosParaAsignar := rKilosRestoTrans;

      rPrecioAlbaran := CalcularPrecioAlbaran(kmtAlbPartidos.FieldByName('empresa_alb').AsString, kmtAlbPartidos.FieldByName('centro_alb').AsString,
                                            kmtAlbPartidos.FieldByName('numero_alb').AsString, kmtAlbPartidos.FieldByName('fecha_alb').AsString,
                                            kmtAlbPartidos.FieldByName('producto_alb').AsString);
      //Buscar Factura Venta
      if QFactura.Active then
        QFactura.Close;
      QFactura.ParamByName('empresa_fac').AsString := kmtAlbPartidos.FieldByName('empresa_fac_alb').AsString;
      QFactura.ParamByName('serie_fac').AsString := kmtAlbPartidos.FieldByName('serie_fac_alb').AsString;
      QFactura.ParamByName('numero_fac').AsString := kmtAlbPartidos.FieldByName('numero_fac_alb').AsString;
      QFactura.ParamByName('fecha_fac').AsString := kmtAlbPartidos.FieldByName('fecha_fac_alb').AsString;
      QFactura.Open;
      while not QFactura.Eof do
      begin
        try
          //Insertamos en Tabla Posei
          InsertarPoseiAlbaran_2 (rKilosParaAsignar);
          rKilosAsignados := rKilosAsignados + QPosei.FieldByName('kilos_albaran_p').AsFloat;
          rKilosRestoTrans := rKilosRestoTrans - QPosei.FieldByName('kilos_albaran_p').AsFloat;
          Inc(iLinea);

        except
            ShowMessage(' ERROR, al insertar registro en Tabla POSEI.');
            exit;
        end;

        QFactura.Next;
      end;


    end
    else exit;

    kmtAlbPartidos.Next;
  end;
end;

procedure TDMCalculoPosei.BuscarAlbDirecto;
begin
  if QAlbaranDirecto.Active then
    QAlbaranDirecto.Close;

  QAlbaranDirecto.ParamByName('empresa').AsString := QTransito.FieldByName('empresa').AsString;
  QAlbaranDirecto.ParamByName('centro').AsString := QTransito.FieldByName('centro_destino').AsString;
  QAlbaranDirecto.ParamByName('fecha').AsString := QTransito.FieldByName('fecha').AsString;
  QAlbaranDirecto.ParamByName('albaran').AsString := QTransito.FieldByName('referencia').AsString;

  QAlbaranDirecto.Open;

  while (not QAlbaranDirecto.Eof) do
  begin
    rPrecioAlbaran := CalcularPrecioAlbaran(QAlbaranDirecto.FieldByName('empresa_sc').AsString, QAlbaranDirecto.FieldByName('centro_salida_sc').AsString,
                                              QAlbaranDirecto.FieldByName('n_albaran_sc').AsString, QAlbaranDirecto.FieldByName('fecha_sc').AsString,
                                              QAlbaranDirecto.FieldByName('producto_sl').AsString);
    //Buscar Factura Venta
    if QFactura.Active then
      QFactura.Close;
    QFactura.ParamByName('empresa_fac').AsString := QAlbaranDirecto.FieldByName('empresa_fac_sc').AsString;
    QFactura.ParamByName('serie_fac').AsString := QAlbaranDirecto.FieldByName('serie_fac_sc').AsString;
    QFactura.ParamByName('numero_fac').AsString := QAlbaranDirecto.FieldByName('n_factura_sc').AsString;
    QFactura.ParamByName('fecha_fac').AsString := QAlbaranDirecto.FieldByName('fecha_factura_sc').AsString;
    QFactura.Open;
    while not QFactura.Eof do
    begin
      try
        //Insertamos en Tabla Posei
        InsertarPoseiAlbaran_3 (QAlbaranDirecto.FieldByName('kilos_posei_sl').AsFloat);
        rKilosAsignados := rKilosAsignados + QPosei.FieldByName('kilos_albaran_p').AsFloat;
        rKilosRestoTrans := 0;
        Inc(iLinea);

      except
          ShowMessage(' ERROR, al insertar registro en Tabla POSEI.');
          exit;
      end;

      QFactura.Next;
    end;

    QAlbaranDirecto.Next;
  end;
end;

procedure TDMCalculoPosei.BuscarDepositoAduana;
begin
  if QDeposito.Active then
    QDeposito.Close;

  QDeposito.ParamByName('empresa').AsString := QTransito.FieldByName('empresa').AsString;
  QDeposito.ParamByName('centro').AsString := QTransito.FieldByName('centro').AsString;
  QDeposito.ParamByName('referencia').AsString := QTransito.FieldByName('referencia').AsString;
  QDeposito.ParamByName('fecha').AsString := QTransito.FieldByName('fecha').AsString;
  QDeposito.Open;

end;

procedure TDMCalculoPosei.BuscarAlbaran_1;
begin
  if not kmtAlbPartidos.IsEmpty then
   kmtAlbPartidos.EmptyTable;

  if QAlbaranResto.Active then
    QAlbaranResto.Close;

  QAlbaranResto.ParamByName('empresa').AsString := QTransito.FieldByName('empresa').AsString;
  QAlbaranResto.ParamByName('centro').AsString := QTransito.FieldByName('centro_destino').AsString;
  QAlbaranResto.ParamByName('producto').AsString := QTransito.FieldByName('producto').AsString;
  QAlbaranResto.ParamByName('fechaini').AsDateTime := QTransito.FieldByName('fecha_entrada').AsDateTime;
  QAlbaranResto.ParamByName('fechafin').AsDateTime := QTransito.FieldByName('fecha_entrada').AsDateTime + 30;
  QAlbaranResto.ParamByName('fechaini_tran').AsDateTime := dFechaIni;
  QAlbaranResto.ParamByName('fechafin_tran').AsDateTime := dFechaFin;

  QAlbaranResto.Open;

  while (not QAlbaranResto.Eof) and (rKilosRestoTrans > 0) do
  begin
    rKilosPosei := BuscarKilosPosei(QAlbaranResto.FieldByName('empresa_sc').AsString, QAlbaranResto.FieldByName('centro_salida_sc').AsString,
                                   QAlbaranResto.FieldByName('n_albaran_sc').AsString, QAlbaranResto.FieldByName('fecha_sc').AsString, QAlbaranResto.FieldByName('producto_sl').AsString, '');
    rKilosParaAsignar := QAlbaranResto.FieldByName('kilos_posei_sl').AsFloat - rKilosPosei;
{
    if rKilosRestoTrans <= rKilosParaAsignar then
    begin
      rPrecioAlbaran := CalcularPrecioAlbaran(QAlbaranResto.FieldByName('empresa_sc').AsString, QAlbaranResto.FieldByName('centro_salida_sc').AsString,
                                              QAlbaranResto.FieldByName('n_albaran_sc').AsString, QAlbaranResto.FieldByName('fecha_sc').AsString,
                                              QAlbaranResto.FieldByName('producto_sl').AsString);
      //Buscar Factura Venta
      if QFactura.Active then
        QFactura.Close;
      QFactura.ParamByName('empresa_fac').AsString := QAlbaranResto.FieldByName('empresa_fac_sc').AsString;
      QFactura.ParamByName('serie_fac').AsString := QAlbaranResto.FieldByName('serie_fac_sc').AsString;
      QFactura.ParamByName('numero_fac').AsString := QAlbaranResto.FieldByName('n_factura_sc').AsString;
      QFactura.ParamByName('fecha_fac').AsString := QAlbaranResto.FieldByName('fecha_factura_sc').AsString;
      QFactura.Open;
      while not QFactura.Eof do
      begin
        try
          //Insertamos en Tabla Posei
          InsertarPoseiAlbaran_1 (rKilosRestoTrans);
          rKilosAsignados := rKilosAsignados + QPosei.FieldByName('kilos_albaran_p').AsFloat;
          rKilosRestoTrans := 0;
          Inc(iLinea);

        except
            ShowMessage(' ERROR, al insertar registro en Tabla POSEI.');
            exit;
        end;

        QFactura.Next;
      end;

    end
    else
    begin
}
      if rKilosParaAsignar > 0 then
      begin
        kmtAlbPartidos.Insert;

        kmtAlbPartidos.FieldByName('empresa_alb').AsString := QAlbaranResto.FieldByName('empresa_sc').AsString;
        kmtAlbPartidos.FieldByName('centro_alb').AsString := QAlbaranResto.FieldByName('centro_salida_sc').AsString;
        kmtAlbPartidos.FieldByName('numero_alb').AsString := QAlbaranResto.FieldByName('n_albaran_sc').AsString;
        kmtAlbPartidos.FieldByName('fecha_alb').AsString := QAlbaranResto.FieldByName('fecha_sc').AsString;
        kmtAlbPartidos.FieldByName('empresa_fac_alb').AsString := QAlbaranResto.FieldByName('empresa_fac_sc').AsString;
        kmtAlbPartidos.FieldByName('serie_fac_alb').AsString := QAlbaranResto.FieldByName('serie_fac_sc').AsString;
        kmtAlbPartidos.FieldByName('numero_fac_alb').AsString := QAlbaranResto.FieldByName('n_factura_sc').AsString;
        kmtAlbPartidos.FieldByName('fecha_fac_alb').AsString := QAlbaranResto.FieldByName('fecha_factura_sc').AsString;
        kmtAlbPartidos.FieldByName('producto_alb').AsString := QAlbaranResto.FieldByName('producto_sl').AsString;
        kmtAlbPartidos.FieldByName('cajas_alb').AsFloat := rKilosParaAsignar / (QAlbaranResto.FieldByName('kilos_posei_sl').AsFloat / QAlbaranResto.FieldByName('cajas_sl').AsFloat);
        kmtAlbPartidos.FieldByName('kilos_alb').AsFloat := rKilosParaAsignar;

        kmtAlbPartidos.Post;
      end;
//    end;

    QAlbaranResto.Next;
  end;

end;

function TDMCalculoPosei.BuscarKilosPosei (const AEmpresa, ACentro, AAlbaran, AFecha, AProducto, AEnvase: string): real;
begin
  with QAux do
  try
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(' select nvl(sum(kilos_albaran_p), 0) kilos from frf_posei    ');
    SQL.Add('  where empresa_albaran_p = :empresa                         ');
    SQL.Add('    and centro_albaran_p = :centro                           ');
    SQL.Add('    and n_albaran_p = :albaran                               ');
    SQL.Add('    and fecha_albaran_p = :fecha                             ');
    SQL.Add('    and producto_p = :producto                               ');
    if AEnvase <> '' then
      SQL.Add('  and articulo_albaran_p = :envase                         ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsString := AAlbaran;
    ParamByName('fecha').AsString := AFecha;
    ParamByName('producto').AsString := AProducto;
    if AEnvase <> '' then
      ParamByName('envase').AsString := AEnvase;

    Open;
    result := Fieldbyname('kilos').AsFloat;
  finally
    Close;
  end;
end;

function TDMCalculoPosei.CalcularPrecioAlbaran (const AEmpresa, ACentro, AAlbaran, AFecha, AProducto: string): real;
var rDescFacImporte, rDescFacKilos, rDescFacPale, rGastoFactAlb, rGastoFactTotal: Real;
    rDescImp, rDescKilo, rDescPale: real;
    rKilosTotal, rImpNetoTotal: real;
begin

  rPrecioAlbaran := 0;
  with QAux do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add(' select * from frf_salidas_l               ');
    SQL.Add(' where  empresa_sl = :empresa      ');
    SQL.Add('    and centro_salida_sl = :centro        ');
    SQL.Add('    and n_albaran_sl = :albaran            ');
    SQL.Add('    and fecha_sl = :fecha          ');
    SQL.Add('    and producto_sl = :producto            ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsString := AAlbaran;
    ParamByName('fecha').AsString := AFecha;
    ParamByName('producto').AsString := AProducto;
    Open;

    while not QAux.Eof do
    begin
      //Descuentos
      if EjecutaQDescProducto(QAux.FieldByName('empresa_sl').AsString, QAux.FieldByName('cliente_sl').AsString,
                              QAux.FieldByName('producto_sl').AsString, QAux.FieldByName('fecha_sl').AsString) then
      begin
        rDescFacImporte := QDescProducto.FieldByName('facturable_dp').AsFloat;
        rDescFacKilos := QDescProducto.FieldByName('eurkg_facturable_dp').AsFloat;
        rDescFacPale  := QDescProducto.FieldByName('eurpale_facturable_dp').AsFloat;
      end
      else if EjecutaQDescCliente( QAux.FieldByName('empresa_sl').AsString, QAux.FieldByName('cliente_sl').AsString, QAux.FieldByName('fecha_sl').AsString) then
      begin
        rDescFacImporte := QDescCliente.FieldByName('facturable_dc').AsFloat;
        rDescFacKilos := QDescCliente.FieldByName('eurkg_facturable_dc').AsFloat;
        rDescFacPale := QDescCliente.FieldByName('eurpale_facturable_dc').AsFloat;
      end
      else
      begin
        rDescFacImporte := 0;
        rDescFacKilos := 0;
        rDescFacPale := 0;
      end;

      rDescImp := (rDescFacImporte * QAux.FieldByName('importe_neto_sl').AsFloat) / 100;
      rDescKilo := rDescFacKilos * QAux.FieldByName('kilos_sl').AsFloat;
      rDescPale := rDescFacPale * QAux.FieldByName('n_palets_sl').AsFloat;

      //Gastos
          //Gastos
      if EjecutaQGastoAlbaran (QAux.FieldByName('empresa_sl').AsString, QAux.FieldByName('centro_salida_sl').AsString,
                               QAux.FieldByName('n_albaran_sl').AsString, QAux.FieldByName('fecha_sl').AsString) then
      begin
        EjecutaQAlbaranAgrupado (QAux.FieldByName('empresa_sl').AsString, QAux.FieldByName('centro_salida_sl').AsString,
                               QAux.FieldByName('n_albaran_sl').AsString, QAux.FieldByName('fecha_sl').AsString, QAux.FieldByName('producto_sl').AsString);
        AddGastos (rGastoFactAlb);
//      rGastoFactTotal := rGastoFactTotal + rGastoFactAlb;
      rGastoFactTotal := rGastoFactAlb;
      end
      else
      begin                                                                    
        rGastoFactTotal := 0;
      end;

      rImpNetoTotal := rImpNetoTotal + QAux.FieldByName('importe_neto_sl').AsFloat - (rDescImp + rDescKilo + rDescPale) - rGastoFactTotal;
      rKilosTotal := rKilosTotal + QAux.FieldByName('kilos_sl').AsFloat;

      QAux.Next;
    end;
  end;

  Result := rImpNetoTotal / rKilosTotal;

end;

procedure TDMCalculoPosei.CargarDatosInforme;
begin
  // Cargamos tabla temporal
  if kmtInforme.Active then
    kmtInforme.Close;

  kmtInforme.Open;

  while not DMAuxDB.QAux.Eof do
  begin
    InsertarkmtInforme;

    DMAuxDB.QAux.Next;
  end;

  kmtInforme.SortOn('anyo;semestre;producto;empresa_transito;centro_transito;ref_transito;fecha_transito;fecha_factura',[]);

end;

procedure TDMCalculoPosei.CargarDatosControl;
begin
  // Cargamos tabla temporal
  if kmtControl.Active then
    kmtControl.Close;

  kmtControl.Filter := '';
  kmtControl.Filtered := false;
  kmtControl.Open;

  while not DMAuxDB.QAux.Eof do
  begin
  if kmtControl.Locate( 'empresa_transito;centro_transito;ref_transito;fecha_transito;producto',
                       VarArrayOf([DMAuxDB.QAux.FieldByName('empresa_transito_p').AsString, DMAuxDB.QAux.FieldByName('centro_transito_p').AsString,
                                   DMAuxDB.QAux.FieldByName('ref_transito_p').AsString, DMAuxDB.QAux.FieldByName('fecha_transito_p').AsString,
                                   DMAuxDB.QAux.FieldByName('producto_p').AsString]), []) then
      ModificarkmtControl
  else
      InsertarkmtControl;

    DMAuxDB.QAux.Next;
  end;

  kmtControl.SortOn('empresa_transito;centro_transito;ref_transito;fecha_transito;producto',[]);
  kmtControl.First;
  while not kmtControl.Eof do
  begin
    kmtControl.Edit;
    kmtControl.FieldByName('diferencia').AsFloat := bRoundTo(kmtControl.FieldByName('kilos_transito').AsFloat - kmtControl.FieldByName('kilos_factura').AsFloat, 2);
    kmtControl.Post;

    kmtControl.Next;
  end;
  kmtControl.Filter := 'diferencia <> 0';
  kmtControl.Filtered := true;

end;

function TDMCalculoPosei.BuscarKilosAsignadosTrans (const AEmpresa, ACentro, ATransito, AFecha, AProducto: string): real;
begin
  with QAux do
  try
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(' select nvl(sum(kilos_albaran_p), 0) kilos from frf_posei     ');
    SQL.Add('  where empresa_transito_p = :empresa                         ');
    SQL.Add('    and centro_transito_p = :centro                           ');
    SQL.Add('    and ref_transito_p = :transito                            ');
    SQL.Add('    and fecha_transito_p = :fecha                             ');
    SQL.Add('    and producto_p = :producto                                ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('transito').AsString := ATransito;
    ParamByName('fecha').AsString := AFecha;
    ParamByName('producto').AsString := AProducto;

    Open;
    result := Fieldbyname('kilos').AsFloat;
  finally
    Close;
  end;
end;

procedure TDMCalculoPosei.CrearQuerys;
begin

  CrearQDescCentro;
  CrearQDescCliente;
  CrearQDescProducto;
  CrearQGastoAlbaran;
  CrearQAlbaranAgrupado;

end;

procedure TDMCalculoPosei.CrearQAlbaranAgrupado;
begin
  with QAlbaranAgrupado do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_posei_sl) total_kilos, ');
    SQL.Add('        sum(case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                    then kilos_posei_sl else 0 end) transito_kilos, ');
    SQL.Add('        sum(case when producto_sl = :producto then kilos_posei_sl else 0 end ) total_prod_kilos, ');
    SQL.Add('        sum(case when producto_sl = :producto then ');
    SQL.Add('                     ( case when ( ref_transitos_sl is not NULL ) or ( nvl(es_transito_sc,0) =  1 ) ');
    SQL.Add('                            then kilos_posei_sl else 0 end ) ');
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

procedure TDMCalculoPosei.CrearQDescCentro;
begin
  with QDescCentro do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' select NVL(facturable_dc,0), NVL(no_fact_bruto_dc, 0), NVL(no_fact_neto_dc, 0),  ');     //Importe
    SQL.Add('        NVL(eurkg_facturable_dc, 0), NVL(eurkg_no_facturable_dc, 0),              ');    //Kilo
    SQL.Add('        NVL(eurpale_facturable_dc,0), NVL(eurpale_no_facturable_dc, 0)           ');     //Pale
    SQL.Add(' from frf_descuentos_centro                                                       ');     //Kilos
    SQL.Add(' where empresa_dc  = :empresa                                                     ');     //Pale
    SQL.Add(' and cliente_dc = :cliente                                                        ');
    SQL.Add(' and centro_dc = :centro                                                          ');
    SQL.Add(' and ((:fecha between fecha_ini_dc and fecha_fin_dc) or (:fecha >= fecha_ini_dc and fecha_fin_dc is null)) ');

    Prepare;
  end;
end;

procedure TDMCalculoPosei.CrearQDescCliente;
begin
  with QDescCliente do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' select NVL(facturable_dc,0) facturable_dc, NVL(no_fact_bruto_dc, 0) no_fact_bruto_dc, NVL(no_fact_neto_dc, 0) no_fact_neto_dc,  ');     //Importe
    SQL.Add('        NVL(eurkg_facturable_dc, 0) eurkg_facturable_dc, NVL(eurkg_no_facturable_dc, 0) eurkg_no_facturable_dc,              ');    //Kilo
    SQL.Add('        NVL(eurpale_facturable_dc,0) eurpale_facturable_dc, NVL(eurpale_no_facturable_dc, 0) eurpale_no_facturable_dc          ');     //Pale
    SQL.Add(' from frf_descuentos_cliente                                                      ');     //Kilos
    SQL.Add(' where empresa_dc  = :empresa                                                     ');     //Pale
    SQL.Add(' and cliente_dc = :cliente                                                        ');
    SQL.Add(' and ((:fecha between fecha_ini_dc and fecha_fin_dc) or (:fecha >= fecha_ini_dc and fecha_fin_dc is null)) ');

    Prepare;
  end;
end;

procedure TDMCalculoPosei.CrearQDescProducto;
begin
  with QDescProducto do
  begin
    if Active then Close;

    SQL.Clear;
    SQL.Add(' select NVL(facturable_dp, 0) facturable_dp, NVL(no_fact_bruto_dp, 0) no_fact_bruto_dp, NVL(no_fact_neto_dp, 0) no_fact_neto_dp, ');    //Importe
    SQL.Add('        NVL(eurkg_facturable_dp,0) eurkg_facturable_dp, NVL(eurkg_no_facturable_dp, 0) eurkg_no_facturable_dp,                   ');    //Kilo
    SQL.Add('        NVL(eurpale_facturable_dp,0) eurpale_facturable_dp, NVL(eurpale_no_facturable_dp, 0) eurpale_no_facturable_dp            ');    //Pale
    SQL.Add(' from frf_descuentos_producto                                                     ');
    SQL.Add(' where empresa_dp  = :empresa                                                     ');
    SQL.Add(' and cliente_dp = :cliente                                                        ');
    SQL.Add(' and producto_dp = :producto                                                      ');
    SQL.Add(' and ((:fecha between fecha_ini_dp and fecha_fin_dp) or (:fecha >= fecha_ini_dp and fecha_fin_dp is null)) ');

    Prepare;
  end;
end;

procedure TDMCalculoPosei.CrearQGastoAlbaran;
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

function TDMCalculoPosei.EjecutaQAlbaranAgrupado (const AEmpresa, ACentro, AAlbaran, AFecha, AProducto: string): boolean;
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

function TDMCalculoPosei.EjecutaQDescCentro (const AEmpresa, ACliente, ACentro, AFecha: string): Boolean;
begin
  with QDescCentro do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cliente').AsString := ACliente;
    ParamByName('centro').AsString := ACentro;
    ParamByName('fecha').AsString := AFecha;

    Open;
    Result := not IsEmpty;
  end;
end;

function TDMCalculoPosei.EjecutaQDescCliente(const AEmpresa, ACliente, AFecha: string): Boolean;
begin
  with QDescCliente do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cliente').AsString := ACliente;
    ParamByName('fecha').AsString := AFecha;

    Open;
    Result := not IsEmpty;
  end;
end;

function TDMCalculoPosei.EjecutaQDescProducto(const AEmpresa, ACliente, AProducto, AFecha: string): Boolean;
begin
  with QDescProducto do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cliente').AsString := ACliente;
    ParamByName('producto').AsString := AProducto;
    ParamByName('fecha').AsString := AFecha;

    Open;
    Result := not IsEmpty;
  end;
end;

function TDMCalculoPosei.EjecutaQGastoAlbaran(const AEmpresa, ACentro, AAlbaran, AFecha: String): Boolean;
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

function TDMCalculoPosei.EsProductoConGasto (const AProducto: string): Boolean;
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

procedure TDMCalculoPosei.BuscarPacking;
var rKilosPacking, rKilosPosei, rKilosAAsignar, rKilosTotal: real;
begin

  if QPacking.Active then
    QPacking.Close;
  QPacking.ParamByName('empresa').AsString := QTransito.FieldByName('empresa').AsString;
  QPacking.ParamByName('transito').AsString := QTransito.FieldByName('referencia').AsString;
  QPacking.ParamByName('fecha_transito').AsString := QTransito.FieldByName('fecha').AsString;
  QPacking.ParamByName('producto').AsString := QTransito.FieldByName('producto').AsString;
  QPacking.Open;
  while not (QPacking.Eof) and (bRoundto(rKilosAsignados + QPacking.FieldByName('kilos_pl').AsFloat, 2) <= QTransito.FieldByName('kilos').AsFloat) do
  begin
    rKilosPacking := 0;

    //Buscar Albaran Salida
    if QAlbaran.Active then
      QAlbaran.Close;
    QAlbaran.ParamByName('empresa').AsString :=  QPacking.FieldByName('empresa_pl').AsString;
    QAlbaran.ParamByName('centro').AsString := QTransito.FieldByName('centro_destino').AsString;
    QAlbaran.ParamByName('orden').AsString :=  QPacking.FieldByName('orden_pl').AsString;
    QAlbaran.ParamByName('producto').AsString :=  QPacking.FieldByName('producto_pl').AsString;
    QAlbaran.ParamByName('envase').AsString :=  QPacking.FieldByName('envase_pl').AsString;
    QAlbaran.ParamByName('fechaini').AsDateTime :=  dFechaIni;
    QAlbaran.ParamByName('fechafin').AsDateTime :=  dFechaFin;
    QAlbaran.Open;
    while (not QAlbaran.Eof) and (rKilosPacking < QPacking.FieldByName('kilos_pl').AsFloat ) do//and (QPacking.FieldByName('kilos_pl').AsFloat <= QAlbaran.FieldByName('kilos_posei').AsFloat) do
    begin
      //Buscamos kilos del albaran en posei
      rKilosPosei := BuscarKilosPosei(QAlbaran.FieldByName('empresa_sc').AsString, QAlbaran.FieldByName('centro_salida_sc').AsString,
                                      QAlbaran.FieldByName('n_albaran_sc').AsString, QAlbaran.FieldByName('fecha_sc').AsString, QAlbaran.FieldByName('producto_sl').AsString, QAlbaran.ParamByName('envase').AsString);
      rKilosAAsignar := QAlbaran.FieldByName('kilos_posei').AsFloat - bRoundTo(rKilosPosei, 2);
      if QPacking.FieldByName('kilos_pl').AsFloat >= rKilosAAsignar  then
        //Kilos a Asignar = kilos_albaran - kilos_posei
        rKilosTotal := rKilosAAsignar
      else
        rKilosTotal := QPacking.FieldByName('kilos_pl').AsFloat;
      // Buscamos descuentos y gastos del albaran
      rPrecioAlbaran := CalcularPrecioAlbaran(QAlbaran.FieldByName('empresa_sc').AsString, QAlbaran.FieldByName('centro_salida_sc').AsString,
                                              QAlbaran.FieldByName('n_albaran_sc').AsString, QAlbaran.FieldByName('fecha_sc').AsString,
                                              QAlbaran.FieldByName('producto_sl').AsString) ;
      //Buscar Factura Venta
      if QFactura.Active then
        QFactura.Close;
      QFactura.ParamByName('empresa_fac').AsString := QAlbaran.FieldByName('empresa_fac_sc').AsString;
      QFactura.ParamByName('serie_fac').AsString := QAlbaran.FieldByName('serie_fac_sc').AsString;
      QFactura.ParamByName('numero_fac').AsString := QAlbaran.FieldByName('n_factura_sc').AsString;
      QFactura.ParamByName('fecha_fac').AsString := QAlbaran.FieldByName('fecha_factura_sc').AsString;
      QFactura.Open;
      while not QFactura.Eof do
      begin
        try
          //Insertamos en Tabla Posei
          InsertarPosei (rKilosTotal);
          rKilosAsignados := rKilosAsignados + QPosei.FieldByName('kilos_albaran_p').AsFloat;
          rKilosPacking := rKilosPacking + QPosei.FieldByName('kilos_albaran_p').AsFloat;
          Inc(iLinea);

        except
            ShowMessage(' ERROR, al insertar registro en Tabla POSEI.');
            exit;
        end;

        QFactura.Next;
      end;
      QAlbaran.Next;
    end;
    QPacking.Next;
  end;
end;

function TDMCalculoPosei.BuscarSigLinea: integer;
begin
  with QAux do
  try
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(' select nvl(max(n_linea_p), 0) n_linea from frf_posei   ');

    Open;
    result := Fieldbyname('n_linea').AsInteger + 1;
  finally
    Close;
  end;
end;

procedure TDMCalculoPosei.InsertarkmtInforme;
begin


  kmtInforme.Insert;

  kmtInforme.FieldByName('definitivo').AsString := DMAuxDB.QAux.FieldByName('definitivo_p').AsString;
  kmtInforme.FieldByName('anyo').AsInteger := DMAuxDB.QAux.FieldByName('anyo_p').AsInteger;
  kmtInforme.FieldByName('semestre').AsInteger := DMAuxDB.QAux.FieldByName('semestre_p').AsInteger;
  kmtInforme.FieldByName('producto').AsString := DMAuxDB.QAux.FieldByName('producto_p').AsString;
  kmtInforme.FieldByName('empresa_transito').AsString := DMAuxDB.QAux.FieldByName('empresa_transito_p').AsString;
  kmtInforme.FieldByName('centro_transito').AsString := DMAuxDB.QAux.FieldByName('centro_transito_p').AsString;
  kmtInforme.FieldByName('ref_transito').AsString := DMAuxDB.QAux.FieldByName('ref_transito_p').AsString;
  kmtInforme.FieldByName('fecha_transito').AsString := DMAuxDB.QAux.FieldByName('fecha_transito_p').AsString;
  kmtInforme.FieldByName('cajas_transito').AsInteger := DMAuxDB.QAux.FieldByName('cajas_transito_p').AsInteger;
  kmtInforme.FieldByName('kilos_transito').AsFloat := DMAuxDB.QAux.FieldByName('kilos_transito_p').AsFloat;

  kmtInforme.FieldByName('dua_salida').AsString := DMAuxDB.QAux.FieldByName('dua_salida_p').AsString;
  kmtInforme.FieldByName('fecha_llegada').AsString := DMAuxDB.QAux.FieldByName('fecha_llegada_p').AsString;
  kmtInforme.FieldByName('dua_llegada').AsString := DMAuxDB.QAux.FieldByName('dua_llegada_p').AsString;


  kmtInforme.FieldByName('codigo_factura').AsString := DMAuxDB.QAux.FieldByName('codigo_factura_p').AsString;
  kmtInforme.FieldByName('fecha_factura').AsString := DMAuxDB.QAux.FieldByName('fecha_factura_p').AsString;
  kmtInforme.FieldByName('cajas').AsInteger := DMAuxDB.QAux.FieldByName('cajas_albaran_p').AsInteger;
  kmtInforme.FieldByName('kilos').AsFloat := DMAuxDB.QAux.FieldByName('kilos_albaran_p').AsFloat;
  kmtInforme.FieldByName('importe').AsFloat := DMAuxDB.QAux.FieldByName('importe_neto_albaran_p').AsFloat;
  kmtInforme.FieldByName('importe_factura').AsFloat := DMAuxDB.QAux.FieldByName('importe_total_factura_p').AsFloat;

  kmtInforme.Post;
end;

procedure TDMCalculoPosei.InsertarkmtControl;
begin


  kmtControl.Insert;

  kmtControl.FieldByName('definitivo').AsString := DMAuxDB.QAux.FieldByName('definitivo_p').AsString;
  kmtControl.FieldByName('empresa_transito').AsString := DMAuxDB.QAux.FieldByName('empresa_transito_p').AsString;
  kmtControl.FieldByName('centro_transito').AsString := DMAuxDB.QAux.FieldByName('centro_transito_p').AsString;
  kmtControl.FieldByName('ref_transito').AsString := DMAuxDB.QAux.FieldByName('ref_transito_p').AsString;
  kmtControl.FieldByName('fecha_transito').AsString := DMAuxDB.QAux.FieldByName('fecha_transito_p').AsString;
  kmtControl.FieldByName('producto').AsString := DMAuxDB.QAux.FieldByName('producto_p').AsString;
  kmtControl.FieldByName('kilos_transito').AsFloat := DMAuxDB.QAux.FieldByName('kilos_transito_p').AsFloat;
  kmtControl.FieldByName('kilos_factura').AsFloat := DMAuxDB.QAux.FieldByName('kilos_albaran_p').AsFloat;

  kmtControl.Post;
end;

procedure TDMCalculoPosei.InsertarPosei ( const AKilos: Real);
begin
  try
    QPosei.Insert;

    QPosei.FieldByName('anyo_p').AsInteger :=  iAnyo;
    QPosei.FieldByName('semestre_p').AsInteger :=  iSemestre;
    QPosei.FieldByName('n_linea_p').AsInteger :=  iLinea;
    QPosei.FieldByName('producto_p').AsString :=  QPacking.ParamByName('producto').AsString;
    QPosei.FieldByName('definitivo_p').AsString := sDefinitivo;
    QPosei.FieldByName('empresa_transito_p').AsString := QTransito.FieldByName('empresa').AsString;
    QPosei.FieldByName('centro_transito_p').AsString := QTransito.FieldByName('centro').AsString;
    QPosei.FieldByName('ref_transito_p').AsString := QTransito.FieldByName('referencia').AsString;
    QPosei.FieldByName('fecha_transito_p').AsString := QTransito.FieldByName('fecha').AsString;
    QPosei.FieldByName('dua_salida_p').AsString := QDeposito.FieldByName('dua_salida').AsString;
    QPosei.FieldByName('fecha_llegada_p').AsString := QTransito.FieldByName('fecha_entrada').AsString;
    QPosei.FieldByName('dua_llegada_p').AsString := QDeposito.FieldByName('dua_llegada').AsString;
    QPosei.FieldByName('cajas_transito_p').AsFloat := QTransito.FieldByName('cajas').AsFloat;
    QPosei.FieldByName('kilos_transito_p').AsFloat := QTransito.FieldByName('kilos').AsFloat;
    QPosei.FieldByName('orden_carga_p').AsString := QPacking.FieldByName('orden_pl').AsString;
    QPosei.FieldByName('empresa_albaran_p').AsString := QAlbaran.FieldByName('empresa_sc').AsString;
    QPosei.FieldByName('centro_albaran_p').AsString := QAlbaran.FieldByName('centro_salida_sc').AsString;
    QPosei.FieldByName('n_albaran_p').AsInteger := QAlbaran.FieldByName('n_albaran_sc').AsInteger;
    QPosei.FieldByName('fecha_albaran_p').AsString := QAlbaran.FieldByName('fecha_sc').AsString;
    QPosei.FieldByName('articulo_albaran_p').AsString := QPacking.FieldByName('envase_pl').AsString;
{
    //Hay diferencias de kilos entre el packing y el albaran
    if QAlbaran.FieldByName('cajas').AsFloat = QPacking.FieldByName('cajas_pl').AsFloat then
    begin
      QPosei.FieldByName('cajas_albaran_p').AsFloat := QAlbaran.FieldByName('cajas').AsFloat;
      QPosei.FieldByName('kilos_albaran_p').AsFloat := QAlbaran.FieldByName('kilos_posei').AsFloat;
      QPosei.FieldByName('importe_neto_albaran_p').AsFloat := rPrecioAlbaran * QAlbaran.FieldByName('kilos').AsFloat;
    end
    else
    begin
}
      QPosei.FieldByName('cajas_albaran_p').AsFloat := AKilos / QPacking.FieldByName('peso_neto_e').AsFloat ;
      QPosei.FieldByName('kilos_albaran_p').AsFloat := AKilos;
      QPosei.FieldByName('importe_neto_albaran_p').AsFloat := rPrecioAlbaran * AKilos;

//    end;

    QPosei.FieldByName('codigo_factura_p').AsString := QFactura.FieldByName('cod_factura_fc').AsString;
    QPosei.FieldByName('fecha_factura_p').AsString :=  QFactura.FieldByName('fecha_factura_fc').AsString;
    QPosei.FieldByName('importe_total_factura_p').AsFloat :=  QFactura.FieldByName('importe_total').AsFloat;
    QPosei.FieldByName('tipo_p').AsString := 'T';
    QPosei.FieldByName('fecha_actualiza_p').AsDateTime := Now;
    QPosei.FieldByName('usuario_actualiza_p').AsString := gsCodigo;


    QPosei.Post;

  except
    raise;
  end;
end;

procedure TDMCalculoPosei.InsertarPoseiAlbaran_1(const AKilos: Real);
begin
  try
    QPosei.Insert;

    QPosei.FieldByName('anyo_p').AsInteger :=  iAnyo;
    QPosei.FieldByName('semestre_p').AsInteger :=  iSemestre;
    QPosei.FieldByName('n_linea_p').AsInteger :=  iLinea;
    QPosei.FieldByName('producto_p').AsString :=  QAlbaranResto.FieldByName('producto_sl').AsString;
    QPosei.FieldByName('definitivo_p').AsString := sDefinitivo;
    QPosei.FieldByName('empresa_transito_p').AsString := QTransito.FieldByName('empresa').AsString;
    QPosei.FieldByName('centro_transito_p').AsString := QTransito.FieldByName('centro').AsString;
    QPosei.FieldByName('ref_transito_p').AsString := QTransito.FieldByName('referencia').AsString;
    QPosei.FieldByName('fecha_transito_p').AsString := QTransito.FieldByName('fecha').AsString;
    QPosei.FieldByName('dua_salida_p').AsString := QDeposito.FieldByName('dua_salida').AsString;
    QPosei.FieldByName('fecha_llegada_p').AsString := QTransito.FieldByName('fecha_entrada').AsString;
    QPosei.FieldByName('dua_llegada_p').AsString := QDeposito.FieldByName('dua_llegada').AsString;
    QPosei.FieldByName('cajas_transito_p').AsFloat := QTransito.FieldByName('cajas').AsFloat;
    QPosei.FieldByName('kilos_transito_p').AsFloat := QTransito.FieldByName('kilos').AsFloat;
    QPosei.FieldByName('orden_carga_p').AsString := '';
    QPosei.FieldByName('empresa_albaran_p').AsString := QAlbaranResto.FieldByName('empresa_sc').AsString;
    QPosei.FieldByName('centro_albaran_p').AsString := QAlbaranResto.FieldByName('centro_salida_sc').AsString;
    QPosei.FieldByName('n_albaran_p').AsInteger := QAlbaranResto.FieldByName('n_albaran_sc').AsInteger;
    QPosei.FieldByName('fecha_albaran_p').AsString := QAlbaranResto.FieldByName('fecha_sc').AsString;
    QPosei.FieldByName('articulo_albaran_p').AsString := '';
    QPosei.FieldByName('cajas_albaran_p').AsFloat := AKilos / (QAlbaranResto.FieldByName('kilos_posei_sl').AsFloat / QAlbaranResto.FieldByName('cajas_sl').AsFloat);
    QPosei.FieldByName('kilos_albaran_p').AsFloat := AKilos;
    QPosei.FieldByName('importe_neto_albaran_p').AsFloat := rPrecioAlbaran * AKilos;
    QPosei.FieldByName('codigo_factura_p').AsString := QFactura.FieldByName('cod_factura_fc').AsString;
    QPosei.FieldByName('fecha_factura_p').AsString :=  QFactura.FieldByName('fecha_factura_fc').AsString;
    QPosei.FieldByName('importe_total_factura_p').AsFloat :=  QFactura.FieldByName('importe_total').AsFloat;
    QPosei.FieldByName('tipo_p').AsString := 'T';
    QPosei.FieldByName('fecha_actualiza_p').AsDateTime := Now;
    QPosei.FieldByName('usuario_actualiza_p').AsString := gsCodigo;

    QPosei.Post;
  except
    raise;
  end;
end;

procedure TDMCalculoPosei.InsertarPoseiAlbaran_2(const AKilos: Real);
begin
  try

    QPosei.Insert;

    QPosei.FieldByName('anyo_p').AsInteger :=  iAnyo;
    QPosei.FieldByName('semestre_p').AsInteger :=  iSemestre;
    QPosei.FieldByName('n_linea_p').AsInteger :=  iLinea;
    QPosei.FieldByName('producto_p').AsString :=  kmtAlbPartidos.FieldByName('producto_alb').AsString;
    QPosei.FieldByName('definitivo_p').AsString := sDefinitivo;
    QPosei.FieldByName('empresa_transito_p').AsString := QTransito.FieldByName('empresa').AsString;
    QPosei.FieldByName('centro_transito_p').AsString := QTransito.FieldByName('centro').AsString;
    QPosei.FieldByName('ref_transito_p').AsString := QTransito.FieldByName('referencia').AsString;
    QPosei.FieldByName('fecha_transito_p').AsString := QTransito.FieldByName('fecha').AsString;
    QPosei.FieldByName('dua_salida_p').AsString := QDeposito.FieldByName('dua_salida').AsString;
    QPosei.FieldByName('fecha_llegada_p').AsString := QTransito.FieldByName('fecha_entrada').AsString;
    QPosei.FieldByName('dua_llegada_p').AsString := QDeposito.FieldByName('dua_llegada').AsString;
    QPosei.FieldByName('cajas_transito_p').AsFloat := QTransito.FieldByName('cajas').AsFloat;
    QPosei.FieldByName('kilos_transito_p').AsFloat := QTransito.FieldByName('kilos').AsFloat;
    QPosei.FieldByName('orden_carga_p').AsString := '';
    QPosei.FieldByName('empresa_albaran_p').AsString := kmtAlbPartidos.FieldByName('empresa_alb').AsString;
    QPosei.FieldByName('centro_albaran_p').AsString := kmtAlbPartidos.FieldByName('centro_alb').AsString;
    QPosei.FieldByName('n_albaran_p').AsInteger := kmtAlbPartidos.FieldByName('numero_alb').AsInteger;
    QPosei.FieldByName('fecha_albaran_p').AsString := kmtAlbPartidos.FieldByName('fecha_alb').AsString;
    QPosei.FieldByName('articulo_albaran_p').AsString := '';
    if kmtAlbPartidos.FieldByName('cajas_alb').AsFloat = 0 then
      QPosei.FieldByName('cajas_albaran_p').AsFloat := 0
    else
      QPosei.FieldByName('cajas_albaran_p').AsFloat := AKilos / (kmtAlbPartidos.FieldByName('kilos_alb').AsFloat / kmtAlbPartidos.FieldByName('cajas_alb').AsFloat);
    QPosei.FieldByName('kilos_albaran_p').AsFloat := AKilos;
    QPosei.FieldByName('importe_neto_albaran_p').AsFloat := rPrecioAlbaran * AKilos;
    QPosei.FieldByName('codigo_factura_p').AsString := QFactura.FieldByName('cod_factura_fc').AsString;
    QPosei.FieldByName('fecha_factura_p').AsString :=  QFactura.FieldByName('fecha_factura_fc').AsString;
    QPosei.FieldByName('importe_total_factura_p').AsFloat :=  QFactura.FieldByName('importe_total').AsFloat;
    QPosei.FieldByName('tipo_p').AsString := 'T';
    QPosei.FieldByName('fecha_actualiza_p').AsDateTime := Now;
    QPosei.FieldByName('usuario_actualiza_p').AsString := gsCodigo;

    QPosei.Post;
  except
    raise;
  end;
end;

procedure TDMCalculoPosei.InsertarPoseiAlbaran_3(const AKilos: Real);
begin
  //Directo
  try
    QPosei.Insert;

    QPosei.FieldByName('anyo_p').AsInteger :=  iAnyo;
    QPosei.FieldByName('semestre_p').AsInteger :=  iSemestre;
    QPosei.FieldByName('n_linea_p').AsInteger :=  iLinea;
    QPosei.FieldByName('producto_p').AsString :=  QAlbaranDirecto.FieldByName('producto_sl').AsString;
    QPosei.FieldByName('definitivo_p').AsString := sDefinitivo;
    QPosei.FieldByName('empresa_transito_p').AsString := QTransito.FieldByName('empresa').AsString;
    QPosei.FieldByName('centro_transito_p').AsString := QTransito.FieldByName('centro').AsString;
    QPosei.FieldByName('ref_transito_p').AsString := QTransito.FieldByName('referencia').AsString;
    QPosei.FieldByName('fecha_transito_p').AsString := QTransito.FieldByName('fecha').AsString;
    QPosei.FieldByName('dua_salida_p').AsString := QDeposito.FieldByName('dua_salida').AsString;
    QPosei.FieldByName('fecha_llegada_p').AsString := QTransito.FieldByName('fecha_entrada').AsString;
    QPosei.FieldByName('dua_llegada_p').AsString := QDeposito.FieldByName('dua_llegada').AsString;
    QPosei.FieldByName('cajas_transito_p').AsFloat := QTransito.FieldByName('cajas').AsFloat;
    QPosei.FieldByName('kilos_transito_p').AsFloat := QTransito.FieldByName('kilos').AsFloat;
    QPosei.FieldByName('orden_carga_p').AsString := '';
    QPosei.FieldByName('empresa_albaran_p').AsString := QAlbaranDirecto.FieldByName('empresa_sc').AsString;
    QPosei.FieldByName('centro_albaran_p').AsString := QAlbaranDirecto.FieldByName('centro_salida_sc').AsString;
    QPosei.FieldByName('n_albaran_p').AsInteger := QAlbaranDirecto.FieldByName('n_albaran_sc').AsInteger;
    QPosei.FieldByName('fecha_albaran_p').AsString := QAlbaranDirecto.FieldByName('fecha_sc').AsString;
    QPosei.FieldByName('articulo_albaran_p').AsString := '';
    QPosei.FieldByName('cajas_albaran_p').AsFloat := QAlbaranDirecto.FieldByName('cajas_sl').AsFloat;
    QPosei.FieldByName('kilos_albaran_p').AsFloat := QAlbaranDirecto.FieldByName('kilos_sl').AsFloat;
    QPosei.FieldByName('importe_neto_albaran_p').AsFloat := rPrecioAlbaran * QAlbaranDirecto.FieldByName('kilos_sl').AsFloat;
    QPosei.FieldByName('codigo_factura_p').AsString := QFactura.FieldByName('cod_factura_fc').AsString;
    QPosei.FieldByName('fecha_factura_p').AsString :=  QFactura.FieldByName('fecha_factura_fc').AsString;
    QPosei.FieldByName('importe_total_factura_p').AsFloat :=  QFactura.FieldByName('importe_total').AsFloat;
    QPosei.FieldByName('tipo_p').AsString := 'S';
    QPosei.FieldByName('fecha_actualiza_p').AsDateTime := Now;
    QPosei.FieldByName('usuario_actualiza_p').AsString := gsCodigo;

    QPosei.Post;
  except
    raise;
  end;
end;

procedure TDMCalculoPosei.InsertarPoseiAlbaran_4(const AKilos: Real);
begin
  //Sin Asignar
  try
    QPosei.Insert;

    QPosei.FieldByName('anyo_p').AsInteger :=  iAnyo;
    QPosei.FieldByName('semestre_p').AsInteger :=  iSemestre;
    QPosei.FieldByName('n_linea_p').AsInteger :=  iLinea;
    QPosei.FieldByName('producto_p').AsString :=  QTransito.FieldByName('producto').AsString;
    QPosei.FieldByName('definitivo_p').AsString := sDefinitivo;
    QPosei.FieldByName('empresa_transito_p').AsString := QTransito.FieldByName('empresa').AsString;
    QPosei.FieldByName('centro_transito_p').AsString := QTransito.FieldByName('centro').AsString;
    QPosei.FieldByName('ref_transito_p').AsString := QTransito.FieldByName('referencia').AsString;
    QPosei.FieldByName('fecha_transito_p').AsString := QTransito.FieldByName('fecha').AsString;
    QPosei.FieldByName('dua_salida_p').AsString := QDeposito.FieldByName('dua_salida').AsString;
    QPosei.FieldByName('fecha_llegada_p').AsString := QTransito.FieldByName('fecha_entrada').AsString;
    QPosei.FieldByName('dua_llegada_p').AsString := QDeposito.FieldByName('dua_llegada').AsString;
    QPosei.FieldByName('cajas_transito_p').AsFloat := QTransito.FieldByName('cajas').AsFloat;
    QPosei.FieldByName('kilos_transito_p').AsFloat := QTransito.FieldByName('kilos').AsFloat;
    QPosei.FieldByName('orden_carga_p').AsString := '';
    QPosei.FieldByName('empresa_albaran_p').AsString := '';
    QPosei.FieldByName('centro_albaran_p').AsString := '';
    QPosei.FieldByName('n_albaran_p').AsString := '';
    QPosei.FieldByName('fecha_albaran_p').AsString := '';
    QPosei.FieldByName('articulo_albaran_p').AsString := '';
    QPosei.FieldByName('cajas_albaran_p').AsFloat := 0;
    QPosei.FieldByName('kilos_albaran_p').AsFloat :=0;
    QPosei.FieldByName('importe_neto_albaran_p').AsFloat := 0;
    QPosei.FieldByName('codigo_factura_p').AsString := '';
    QPosei.FieldByName('fecha_factura_p').AsString :=  '';
    QPosei.FieldByName('importe_total_factura_p').AsFloat :=  0;
    QPosei.FieldByName('tipo_p').AsString := '';
    QPosei.FieldByName('fecha_actualiza_p').AsDateTime := Now;
    QPosei.FieldByName('usuario_actualiza_p').AsString := gsCodigo;

    QPosei.Post;
  except
    raise;
  end;
end;

procedure TDMCalculoPosei.InsertarPoseiTemp;
begin

  QPoseiTemp.Insert;

  QPoseiTemp.FieldByName('anyo_p').AsInteger :=  iAnyo;
  QPoseiTemp.FieldByName('semestre_p').AsInteger :=  iSemestre;
  QPoseiTemp.FieldByName('producto_p').AsString :=  QTransito.FieldByName('producto').AsString;
  QPoseiTemp.FieldByName('empresa_transito_p').AsString := QTransito.FieldByName('empresa').AsString;
  QPoseiTemp.FieldByName('centro_transito_p').AsString := QTransito.FieldByName('centro').AsString;
  QPoseiTemp.FieldByName('ref_transito_p').AsString := QTransito.FieldByName('referencia').AsString;
  QPoseiTemp.FieldByName('fecha_transito_p').AsString := QTransito.FieldByName('fecha').AsString;
  QPoseiTemp.FieldByName('kilos_transito_p').AsFloat := QTransito.FieldByName('kilos').AsFloat;
  QPoseiTemp.FieldByName('empresa_albaran_p').AsString := QAlbaranResto.FieldByName('empresa_sc').AsString;
  QPoseiTemp.FieldByName('centro_albaran_p').AsString := QAlbaranResto.FieldByName('centro_salida_sc').AsString;
  QPoseiTemp.FieldByName('n_albaran_p').AsString := QAlbaranResto.FieldByName('n_albaran_sc').AsString;
  QPoseiTemp.FieldByName('fecha_albaran_p').AsString := QAlbaranResto.FieldByName('fecha_sc').AsString;
  QPoseiTemp.FieldByName('producto_albaran_p').AsString := QAlbaranResto.FieldByName('producto_sl').AsString;
  QPoseiTemp.FieldByName('kilos_albaran_p').AsFloat := QAlbaranResto.FieldByName('kilos_sl').AsFloat;         //Kilos Albaran
  QPoseiTemp.FieldByName('kilos_para_asignar_p').AsFloat := rKilosParaAsignar;         //Kilos de Albaran para asignar en Transito

  QPoseiTemp.Post;

end;
{
procedure TDMCalculoPosei.InsertarPoseiTemp2 (const AAnyo, ASemestre: integer; const AProductoT, AEmpresaT, ACentroT, ATransito, AFechaT, AOrden,
                                              AEmpresaA, ACentroA, AAlbaran, AFechaA, AProductoA: String; const AKilosT, AKilosA, AKilosAsig: real);
begin

  QPoseiTemp2.Insert;

  QPoseiTemp2.FieldByName('anyo_p').AsInteger :=  AAnyo;
  QPoseiTemp2.FieldByName('semestre_p').AsInteger :=  ASemestre;
  QPoseiTemp2.FieldByName('producto_p').AsString :=  AProductoT;
  QPoseiTemp2.FieldByName('empresa_transito_p').AsString := AEmpresaT;
  QPoseiTemp2.FieldByName('centro_transito_p').AsString := ACentroT;
  QPoseiTemp2.FieldByName('ref_transito_p').AsString := ATransito;
  QPoseiTemp2.FieldByName('fecha_transito_p').AsString := AFechaT;
  QPoseiTemp2.FieldByName('kilos_transito_p').AsFloat := AKilosT;
  QPoseiTemp2.FieldByName('empresa_albaran_p').AsString := AEmpresaA;
  QPoseiTemp2.FieldByName('centro_albaran_p').AsString := ACentroA;
  QPoseiTemp2.FieldByName('n_albaran_p').AsString := AAlbaran;
  QPoseiTemp2.FieldByName('fecha_albaran_p').AsString := AFechaA;
  QPoseiTemp2.FieldByName('producto_albaran_p').AsString := AProductoA;
  QPoseiTemp2.FieldByName('kilos_albaran_p').AsFloat := AKilosA;               //Kilos Albaran
  QPoseiTemp2.FieldByName('kilos_asignados_p').AsFloat := AKilosAsig;         //Kilos de Albaran asignados

  QPoseiTemp2.Post;

end;
}
procedure TDMCalculoPosei.ModificarkmtControl;
begin

  kmtControl.Edit;

  kmtControl.FieldByName('kilos_factura').AsFloat := kmtControl.FieldByName('kilos_factura').AsFloat + DMAuxDB.QAux.FieldByName('kilos_albaran_p').AsFloat;

  kmtControl.Post;

end;

end.
