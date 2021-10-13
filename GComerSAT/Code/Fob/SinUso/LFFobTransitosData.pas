unit LFFobTransitosData;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TFFobTransitosData = class(TDataModule)
    QSalidas: TQuery;
    kbmSalidasLin: TkbmMemTable;
    kbmSalidasCab: TkbmMemTable;
    DSSalidas: TDataSource;
    QGastos: TQuery;
    QCosteEnvase: TQuery;
    QProductoBase: TQuery;
    QDescuentos: TQuery;
    kbmDescuentos: TkbmMemTable;
    kbmSalidasAnyoSemana: TkbmMemTable;
    QTransitos: TQuery;
    kbmLinTransitos: TkbmMemTable;
    kbmCabTransitos: TkbmMemTable;
    DSTransitos: TDataSource;
    QTotalesAlbaran: TQuery;
    kbmTransitosAnyoSemana: TkbmMemTable;
    kbmAnyoSemana: TkbmMemTable;
    kbmListadoAnyoSemana: TkbmMemTable;
    DSListado: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sProducto: String;
    dFecha: TDateTime;
    iAlbaran: Integer;
    iProductoBase: integer;

    iCabTran, iLinTran: Integer;
    iMaxCabSal, iCabSal, iLinSal: Integer;


    gPalets, gCajas, gKilos, gImporte: Real;
    gtPalets, gtCajas, gtKilos, gtImporte: Real;

    procedure TablaTemporalCabTransitos;
    procedure TablaTemporalLinTransitos;
    Procedure TablaTemporalCab;
    Procedure TablaTemporalLin;
    procedure TablaTemporalDescuentos;
    Procedure QuerySalidas;
    procedure QueryTotalesAlbaran;
    procedure QueryTransitos;
    Procedure QueryGastos( const AExcluir036: Boolean = False );
    Procedure QueryProductoBase;
    Procedure QueryCosteEnvase;
    procedure QueryDescuentos;

    function  ObtenerSalidas( const AEmpresa, ASalida, ADestino, AProducto: string;
                              const AFechaDesde, AFechaHasta: TDateTime ): boolean;
    function  InsertarSalidas( const AEmpresa, AProducto: string; const ATransito: integer;
                               const AFecha: TDateTime ): boolean;
    Procedure RellenarTablas;
    Procedure InsertarTransitos;
    Procedure NuevaLinea;
    function  NumLinSal: integer;
    Procedure NuevaCabecera;

    //GASTOS
    Procedure PutGastosAlbaranes( const AExcluir036: Boolean = False );
    Procedure GastosAlbaran( const AExcluir036: Boolean = False );
    Procedure DistribuirGastosAlbaran;

    //PASAR LA MONEDA A EUROS
    Procedure PasarAEuros;

    //COMISION DEL REPRESENTANTE - DESCUENTO DEL CLIENTE
    procedure PutDescuentos;
    procedure GetDescuento( var AComision, ADescuento: Real );
    procedure GetDescuentoAux( var AComision, ADescuento: Real );

    //COSTES ENVASE
    procedure PutCosteEnvase( const AEnvasado, ASecciones: Boolean );
    procedure CosteEnvaseLineas( const ABEnvasado: boolean; const AEnvasado: Real;
                                 const ABSecciones: Boolean; const ASecciones: Real );
    procedure PutProductoBase;
    procedure PutCosteEnvaseTransito( var AEnvasado, ASecciones: real );
    procedure GetCosteEnvase( var AEnvasado, ASecciones: real );

    //LISTADO POR CALIBRES
    procedure TablaTemporalesListado;
    procedure RellenarSalidasAnyoSemana;
    procedure RellenarTransitosAnyoSemana;
    procedure ReunirTablasAnyoSemana;
  public
    { Public declarations }

    procedure RellenarTablaListadoAnyoSemana;
    procedure CerrarTablasListado;

    function ObtenerDatosListado(
               const Aempresa, ASalida, ADestino, AProducto: string;
               const AFechaDesde, AFechaHasta: TDateTime;
               const bGastos, bExcluir036, bEnvase, bEnvasado: Boolean ): boolean;
  end;

var
  FFobTransitosData: TFFobTransitosData;

implementation

{$R *.dfm}

uses bMath, UDMCambioMoneda, Dialogs, Variants, bTimeUtils;

procedure TFFobTransitosData.TablaTemporalCabTransitos;
begin
  kbmCabTransitos.SortOptions := [];
  kbmCabTransitos.FieldDefs.Clear;

  kbmCabTransitos.FieldDefs.Add('tran', ftInteger, 0, False);

  kbmCabTransitos.FieldDefs.Add('empresa', ftString, 3, False);
  kbmCabTransitos.FieldDefs.Add('centro_salida', ftString, 1, False);
  kbmCabTransitos.FieldDefs.Add('n_transito', ftinteger, 0, False);
  kbmCabTransitos.FieldDefs.Add('fecha_transito', ftdate, 0, False);

  kbmCabTransitos.FieldDefs.Add('kilos', ftFloat, 0, False);
  kbmCabTransitos.FieldDefs.Add('coste_kg', ftFloat, 0, False);

  kbmCabTransitos.IndexDefs.Add('Index1','tran',[]);
  kbmCabTransitos.CreateTable;
  kbmCabTransitos.IndexFieldNames:= 'tran';
  kbmCabTransitos.SortFields := 'tran';
end;

procedure TFFobTransitosData.TablaTemporalLinTransitos;
begin
  kbmLinTransitos.SortOptions := [];
  kbmLinTransitos.FieldDefs.Clear;

  kbmLinTransitos.FieldDefs.Add('tran', ftInteger, 0, False);
  kbmLinTransitos.FieldDefs.Add('lin', ftInteger, 0, False);

  kbmLinTransitos.FieldDefs.Add('envase', ftString, 3, False);
  kbmLinTransitos.FieldDefs.Add('fecha_transito', ftDate, 0, False);
  kbmLinTransitos.FieldDefs.Add('kilos', ftFloat, 0, False);
  kbmLinTransitos.FieldDefs.Add('coste_kg', ftFloat, 0, False);

  kbmLinTransitos.IndexDefs.Add('Index1','tran;lin',[]);
  kbmLinTransitos.CreateTable;
  kbmLinTransitos.IndexFieldNames:= 'tran;lin';
  kbmLinTransitos.SortFields := 'tran;lin';
end;

procedure TFFobTransitosData.TablaTemporalCab;
begin
  kbmSalidasCab.SortOptions := [];
  kbmSalidasCab.FieldDefs.Clear;

  kbmSalidasCab.FieldDefs.Add('tran', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('cab', ftInteger, 0, False);

  kbmSalidasCab.FieldDefs.Add('empresa', ftString, 3, False);
  kbmSalidasCab.FieldDefs.Add('centro_salida', ftString, 1, False);
  kbmSalidasCab.FieldDefs.Add('n_albaran', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('fecha_albaran', ftDate, 0, False);

  //CANTIDADES TOTAL PRODUCTO SELECCIONADO
  kbmSalidasCab.FieldDefs.Add('cajas_producto', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('kilos_producto', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('palets_producto', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('neto_producto', ftFloat, 0, False);

  //CANTIDADES TOTAL PRODUCTO SELECCIONADO DE TRANSITO
  kbmSalidasCab.FieldDefs.Add('cajas_tproducto', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('kilos_tproducto', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('palets_tproducto', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('neto_tproducto', ftFloat, 0, False);

  //CANTIDADES TOTALES TODOS LOS PRODUCTOS
  kbmSalidasCab.FieldDefs.Add('cajas_total', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('kilos_total', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('palets_total', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('neto_total', ftFloat, 0, False);

  //CANTIDADES TOTALES TODOS LOS PRODUCTOS DE TRANSITO
  kbmSalidasCab.FieldDefs.Add('cajas_ttotal', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('kilos_ttotal', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('palets_ttotal', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('neto_ttotal', ftFloat, 0, False);

  //GASTOS GENERALES
  kbmSalidasCab.FieldDefs.Add('gastos_cajas_total', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastos_kilos_total', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastos_palets_total', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastos_neto_total', ftFloat, 0, False);

  //GASTOS TRANSITO
  kbmSalidasCab.FieldDefs.Add('gastost_cajas_total', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastost_kilos_total', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastost_palets_total', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastost_neto_total', ftFloat, 0, False);

  //GASTOS GENERALES DEL PRODUCTO
  kbmSalidasCab.FieldDefs.Add('gastos_cajas_producto', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastos_kilos_producto', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastos_palets_producto', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastos_neto_producto', ftFloat, 0, False);

  //GASTOS TRANSITO
  kbmSalidasCab.FieldDefs.Add('gastost_cajas_producto', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastost_kilos_producto', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastost_palets_producto', ftFloat, 0, False);
  kbmSalidasCab.FieldDefs.Add('gastost_neto_producto', ftFloat, 0, False);

  kbmSalidasCab.IndexDefs.Add('Index1','tran;cab',[]);
  kbmSalidasCab.CreateTable;
  kbmSalidasCab.IndexFieldNames:= 'tran;cab';
  kbmSalidasCab.SortFields := 'tran;cab';
end;

procedure TFFobTransitosData.TablaTemporalLin;
begin
  kbmSalidasLin.SortOptions := [];
  kbmSalidasLin.FieldDefs.Clear;

  kbmSalidasLin.FieldDefs.Add('tran', ftInteger, 0, False);
  kbmSalidasLin.FieldDefs.Add('cab', ftInteger, 0, False);
  kbmSalidasLin.FieldDefs.Add('lin', ftInteger, 0, False);

  kbmSalidasLin.FieldDefs.Add('empresa', ftString, 3, False);
  kbmSalidasLin.FieldDefs.Add('centro_salida', ftString, 1, False);
  kbmSalidasLin.FieldDefs.Add('n_albaran', ftInteger, 0, False);
  kbmSalidasLin.FieldDefs.Add('fecha_albaran', ftDate, 0, False);
  kbmSalidasLin.FieldDefs.Add('fecha_salida', ftDate, 0, False);

  kbmSalidasLin.FieldDefs.Add('cliente_salida', ftString, 3, False);
  kbmSalidasLin.FieldDefs.Add('moneda', ftString, 3, False);
  kbmSalidasLin.FieldDefs.Add('transito', ftInteger, 0, False);

  kbmSalidasLin.FieldDefs.Add('producto', ftString, 3, False);
  kbmSalidasLin.FieldDefs.Add('envase', ftString, 3, False);
  kbmSalidasLin.FieldDefs.Add('categoria', ftString, 2, False);
  kbmSalidasLin.FieldDefs.Add('calibre', ftString, 6, False);

  kbmSalidasLin.FieldDefs.Add('cajas', ftInteger, 0, False);
  kbmSalidasLin.FieldDefs.Add('kilos', ftFloat, 0, False);
  kbmSalidasLin.FieldDefs.Add('palets', ftInteger, 0, False);

  kbmSalidasLin.FieldDefs.Add('neto', ftFloat, 0, False);
  kbmSalidasLin.FieldDefs.Add('iva', ftFloat, 0, False);
  kbmSalidasLin.FieldDefs.Add('total', ftFloat, 0, False);

  kbmSalidasLin.FieldDefs.Add('descuento', ftFloat, 0, False);
  kbmSalidasLin.FieldDefs.Add('comision', ftFloat, 0, False);

  kbmSalidasLin.FieldDefs.Add('gastos', ftFloat, 0, False);
  kbmSalidasLin.FieldDefs.Add('coste_envase', ftFloat, 0, False);
  kbmSalidasLin.FieldDefs.Add('coste_secciones', ftFloat, 0, False);

  kbmSalidasLin.IndexDefs.Add('Index1','tran;cab;lin',[]);
  kbmSalidasLin.CreateTable;
  kbmSalidasLin.IndexFieldNames:= 'tran;cab;lin';
  kbmSalidasLin.SortFields := 'tran;cab;lin';
end;

procedure TFFobTransitosData.TablaTemporalDescuentos;
begin
  kbmDescuentos.SortOptions := [];
  kbmDescuentos.FieldDefs.Clear;
  kbmDescuentos.FieldDefs.Add('empresa', ftString, 3, False);
  kbmDescuentos.FieldDefs.Add('cliente', ftString, 3, False);
  kbmDescuentos.FieldDefs.Add('fecha', ftDate, 0, False);
  kbmDescuentos.FieldDefs.Add('descuento', ftFloat, 0, False);
  kbmDescuentos.FieldDefs.Add('comision', ftFloat, 0, False);
  kbmDescuentos.IndexDefs.Add('Index1','cliente',[]);
  kbmDescuentos.CreateTable;
  kbmDescuentos.IndexFieldNames:= 'cliente';
  kbmDescuentos.SortFields := 'cliente';
end;

procedure TFFobTransitosData.TablaTemporalesListado;
begin
  kbmSalidasAnyoSemana.SortOptions := [];
  kbmSalidasAnyoSemana.FieldDefs.Clear;
  kbmSalidasAnyoSemana.FieldDefs.Add('anyosemana', ftString, 6, False);
  kbmSalidasAnyoSemana.FieldDefs.Add('envase', ftString, 6, False);
  kbmSalidasAnyoSemana.FieldDefs.Add('kilos', ftFloat, 0, False);
  kbmSalidasAnyoSemana.FieldDefs.Add('neto', ftFloat, 0, False);
  kbmSalidasAnyoSemana.FieldDefs.Add('gastos', ftFloat, 0, False);
  kbmSalidasAnyoSemana.FieldDefs.Add('fob', ftFloat, 0, False);
  kbmSalidasAnyoSemana.IndexDefs.Add('Index1','anyosemana;envase',[]);
  kbmSalidasAnyoSemana.CreateTable;
  kbmSalidasAnyoSemana.IndexFieldNames:= 'anyosemana;envase';
  kbmSalidasAnyoSemana.SortFields := 'anyosemana;envase';

  kbmTransitosAnyoSemana.SortOptions := [];
  kbmTransitosAnyoSemana.FieldDefs.Clear;
  kbmTransitosAnyoSemana.FieldDefs.Add('anyosemana', ftString, 6, False);
  kbmTransitosAnyoSemana.FieldDefs.Add('envase', ftString, 6, False);
  kbmTransitosAnyoSemana.FieldDefs.Add('kilos', ftFloat, 0, False);
  kbmTransitosAnyoSemana.IndexDefs.Add('Index1','anyosemana;envase',[]);
  kbmTransitosAnyoSemana.CreateTable;
  kbmTransitosAnyoSemana.IndexFieldNames:= 'anyosemana;envase';
  kbmTransitosAnyoSemana.SortFields := 'anyosemana;envase';

  kbmAnyoSemana.SortOptions := [];
  kbmAnyoSemana.FieldDefs.Clear;
  kbmAnyoSemana.FieldDefs.Add('anyosemana', ftString, 6, False);
  kbmAnyoSemana.IndexDefs.Add('Index1','anyosemana',[]);
  kbmAnyoSemana.CreateTable;
  kbmAnyoSemana.IndexFieldNames:= 'anyosemana';
  kbmAnyoSemana.SortFields := 'anyosemana';

  kbmListadoAnyoSemana.SortOptions := [];
  kbmListadoAnyoSemana.FieldDefs.Clear;
  kbmListadoAnyoSemana.FieldDefs.Add('anyosemana', ftString, 6, False);
  kbmListadoAnyoSemana.FieldDefs.Add('envase_tran', ftString, 6, False);
  kbmListadoAnyoSemana.FieldDefs.Add('kilos_tran', ftFloat, 0, False);
  kbmListadoAnyoSemana.FieldDefs.Add('envase_sal', ftString, 6, False);
  kbmListadoAnyoSemana.FieldDefs.Add('kilos_sal', ftFloat, 0, False);
  kbmListadoAnyoSemana.FieldDefs.Add('neto', ftFloat, 0, False);
  kbmListadoAnyoSemana.FieldDefs.Add('gastos', ftFloat, 0, False);
  kbmListadoAnyoSemana.FieldDefs.Add('fob', ftFloat, 0, False);
  kbmListadoAnyoSemana.IndexDefs.Add('Index1','anyosemana;envase_tran;envase_sal',[]);
  kbmListadoAnyoSemana.CreateTable;
  kbmListadoAnyoSemana.IndexFieldNames:= 'anyosemana;envase_tran;envase_sal';
  kbmListadoAnyoSemana.SortFields := 'anyosemana;envase_tran;envase_sal';
end;

procedure TFFobTransitosData.CerrarTablasListado;
begin
  kbmSalidasAnyoSemana.Close;
  kbmTransitosAnyoSemana.Close;
  kbmAnyoSemana.Close;
  kbmListadoAnyoSemana.Close;
end;

procedure TFFobTransitosData.QueryTransitos;
begin
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_tl empresa, referencia_tl n_transito, fecha_tl fecha_transito, ');
    SQL.Add('        centro_tl centro_salida, centro_origen_tl centro_origen, centro_destino_tl centro_destino, ');
    SQL.Add('        envase_tl envase, sum(kilos_tl) kilos ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :salida ');
    SQL.Add(' and centro_destino_tl = :destino ');
    SQL.Add(' and producto_tl = :producto ');
    SQL.Add(' and fecha_tl between :fechaini and :fechafin ');
    SQL.Add(' group by empresa_tl, referencia_tl, fecha_tl, centro_tl, ');
    SQL.Add('          centro_origen_tl, centro_destino_tl, envase_tl ');
    SQL.Add(' order by empresa_tl, referencia_tl, fecha_tl, centro_tl, ');
    SQL.Add('          centro_origen_tl, centro_destino_tl, envase_tl ');
    Prepare;
  end;
end;

procedure TFFobTransitosData.QuerySalidas;
begin
  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sc empresa, centro_salida_sc centro_salida, fecha_sc fecha_albaran, ');
    SQL.Add('        moneda_sc moneda, n_albaran_sc n_albaran, cliente_sal_sc cliente_salida, ');
    SQL.Add('        n_factura_sc factura, ');
    SQL.Add('        case when ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) then 1 else 0 end transito, ');
    SQL.Add('        producto_sl producto, envase_sl envase, categoria_sl categoria, calibre_sl calibre, ');
    SQL.Add('        sum(cajas_sl) cajas, sum(kilos_sl) kilos, sum(nvl(n_palets_sl,0)) palets, ');
    SQL.Add('        sum(importe_neto_sl) neto, sum(iva_sl) iva, sum(importe_total_sl) total ');

    SQL.Add('        from frf_salidas_c, frf_salidas_l ');

    SQL.Add('        where empresa_sc = :empresa ');
    SQL.Add('        and fecha_sc between :fechaini and :fechafin ');
    SQL.Add('        and empresa_sl = :empresa ');
    SQL.Add('        and centro_salida_sl = centro_salida_sc ');
    SQL.Add('        and fecha_sl = fecha_sc ');
    SQL.Add('        and n_albaran_sl = n_albaran_sc ');
    SQL.Add('        and ref_transitos_sl = :transito ');
    SQL.Add('        and producto_sl = :producto ');

    SQL.Add('        and ( precio_sl <> 0 or n_factura_sc is not null ) ');
    SQL.Add('        and cliente_sl = ''TS'' ');

    SQL.Add('        group by 1,2,3,4,5,6,7,8,9,10,11,12 ');
    SQL.Add('        order by 1,2,3,4,5,6,7,8,9,10,11,12  ');
    Prepare;
  end;
end;

procedure TFFobTransitosData.QueryTotalesAlbaran;
begin
  with QTotalesAlbaran do
  begin
    SQL.Clear;
    SQL.Add(' select sum(case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ) and producto_sl = :producto then cajas_sl else 0 end) cajas_t_producto, ');
    SQL.Add('        sum(case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ) then cajas_sl else 0 end) cajas_t_total, ');
    SQL.Add('        sum(case when producto_sl = :producto then cajas_sl else 0 end) cajas_producto, ');
    SQL.Add('        sum(cajas_sl) cajas_total, ');

    SQL.Add('        sum(case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ) and producto_sl = :producto then kilos_sl else 0 end) kilos_t_producto, ');
    SQL.Add('        sum(case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ) then kilos_sl else 0 end) kilos_t_total, ');
    SQL.Add('        sum(case when producto_sl = :producto then kilos_sl else 0 end) kilos_producto, ');
    SQL.Add('        sum(kilos_sl) kilos_total, ');

    SQL.Add('        sum(case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ) and producto_sl = :producto then nvl(n_palets_sl,0) else 0 end) palets_t_producto, ');
    SQL.Add('        sum(case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ) then nvl(n_palets_sl,0) else 0 end) palets_t_total, ');
    SQL.Add('        sum(case when producto_sl = :producto then nvl(n_palets_sl,0) else 0 end) palets_producto, ');
    SQL.Add('        sum(nvl(n_palets_sl,0)) palets_total, ');

    SQL.Add('        sum(case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ) and producto_sl = :producto then importe_neto_sl else 0 end) neto_t_producto, ');
    SQL.Add('        sum(case when ( ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) ) then importe_neto_sl else 0 end) neto_t_total, ');
    SQL.Add('        sum(case when producto_sl = :producto then importe_neto_sl else 0 end) neto_producto, ');
    SQL.Add('        sum(importe_neto_sl) neto_total ');

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

procedure TFFobTransitosData.QueryGastos( const AExcluir036: Boolean = False );
begin
  with QGastos do
  begin
    Close;
    if Prepared then
      Unprepare;
    SQL.Clear;
    SQL.Add(' select unidad_dist_tg unidad, facturable_tg facturable, ');
    SQL.Add('        gasto_transito_tg transito, importe_g importe ');
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');
    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add(' and centro_salida_g = :centro ');
    SQL.Add(' and n_albaran_g = :albaran ');
    SQL.Add(' and fecha_g = :fecha ');
    SQL.Add(' and tipo_tg = tipo_g ');
    if AExcluir036 then
      SQL.Add(' and tipo_g <> ''036'' ');
    Prepare;
  end;
end;

procedure TFFobTransitosData.QueryProductoBase;
begin
  with QProductoBase do
  begin
    SQL.Clear;
    SQL.Add(' select producto_base_p ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where empresa_p = :empresa ');
    SQL.Add(' and producto_p = :producto ');
    Prepare;
  end;
end;

procedure TFFobTransitosData.QueryCosteEnvase;
begin
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
end;

procedure TFFobTransitosData.QueryDescuentos;
begin
  with QDescuentos do
  begin
    Close;
    if Prepared then
      UnPrepare;
    SQL.Clear;
    SQL.Add(' select GetComisionCliente( empresa_c, cliente_c, :fecha) comision, ');
    SQL.Add('    GetDescuentoCliente( empresa_c, cliente_c, :fecha, 2) descuento ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add(' and cliente_c = :cliente ');
    Prepare;
  end;
end;

procedure TFFobTransitosData.DataModuleCreate(Sender: TObject);
begin
  TablaTemporalCabTransitos;
  TablaTemporalLinTransitos;
  TablaTemporalCab;
  TablaTemporalLin;
  TablaTemporalDescuentos;

  TablaTemporalesListado;

  QuerySalidas;
  QueryTotalesAlbaran;
  QueryTransitos;
  //QueryGastos( false );
  QueryProductoBase;
  QueryCosteEnvase;
  QueryDescuentos;
end;

procedure TFFobTransitosData.DataModuleDestroy(Sender: TObject);
  procedure UnPrepare( AQuery: TQuery );
  begin
    AQuery.Close;
    if AQuery.Prepared then
      AQuery.UnPrepare;
  end;
begin
  UnPrepare( QTransitos );
  UnPrepare( QTotalesAlbaran );
  UnPrepare( QSalidas );
  UnPrepare( QGastos );
  UnPrepare( QProductoBase );
  UnPrepare( QCosteEnvase );
  UnPrepare( QDescuentos );
end;

function TFFobTransitosData.ObtenerDatosListado(
                             const Aempresa, ASalida, ADestino, AProducto: string;
                             const AFechaDesde, AFechaHasta: TDateTime;
                             const bGastos, bExcluir036, bEnvase, bEnvasado: Boolean ): boolean;
begin
  kbmSalidasLin.MasterSource:= DSSalidas;
  result:= ObtenerSalidas( Aempresa, ASalida, ADestino, AProducto, AFechaDesde, AFechaHasta );
  if result then
  begin
    if bGastos then
    begin
      PutGastosAlbaranes( bExcluir036 );
    end;

    kbmSalidasLin.MasterSource:= nil;
    kbmSalidasLin.First;

    PasarAEuros;
    PutDescuentos;

    if bEnvase or bEnvasado then
    begin
      kbmSalidasLin.MasterFields:= 'tran';
      kbmSalidasLin.IndexFieldNames:= 'tran';
      kbmSalidasLin.MasterSource:= DSTransitos;
      PutCosteEnvase( bEnvase, bEnvasado );
      kbmSalidasLin.MasterSource:= nil;
    end;

  end
  else
  begin
    ShowMEssage('Listado sin datos.');
  end;
end;

function TFFobTransitosData.InsertarSalidas( const AEmpresa, AProducto: string;
           const ATransito: integer; const AFecha: TDateTime ): boolean;
begin
  with QSalidas do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('transito').AsInteger:= ATransito;
    ParamByName('fechaini').AsDateTime:= AFecha - 30;
    ParamByName('fechafin').AsDateTime:= AFecha + 30;

    Open;
    result:= not IsEmpty;
    if result then
      RellenarTablas;
    Close;
  end;
end;

function TFFobTransitosData.ObtenerSalidas( const AEmpresa, ASalida, ADestino, AProducto: string;
                                           const AFechaDesde, AFechaHasta: TDateTime ): boolean;
var
  bAux: boolean;
begin
  with QTransitos do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('salida').AsString:= ASalida;
    ParamByName('destino').AsString:= ADestino;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fechaini').AsDateTime:= AFechaDesde;
    ParamByName('fechafin').AsDateTime:= AFechaHasta;
    Open;

    kbmSalidasLin.Close;
    kbmSalidasCab.Close;
    kbmLinTransitos.Open;
    kbmCabTransitos.Open;

    iCabTran:= 1;
    iLinTran:= 0;
    iMaxCabSal:= 0;
    iLinSal:= 0;

    result:= False;
    kbmSalidasLin.Open;
    kbmSalidasCab.Open;
    kbmLinTransitos.Open;
    kbmCabTransitos.Open;
    while not Eof do
    begin
      bAux:= InsertarSalidas( AEmpresa, AProducto, FieldbyName('n_transito').AsInteger, FieldbyName('fecha_transito').AsDateTime );
      if bAux then
      begin
        InsertarTransitos;
        Inc( iCabTran );
        result:= True;
      end
      else
      begin
        Next; //Implicito en  InsertarTransitos
      end;
    end;
  end;
end;

procedure TFFobTransitosData.InsertarTransitos;
var
  sEmpresa, sCentro: string;
  iReferencia: integer;
  dFecha: TDateTime;
  rKilos: Real;
begin
  sEmpresa:= QTransitos.fieldByName('empresa').AsString;
  sCentro:= QTransitos.fieldByName('centro_salida').AsString;
  iReferencia:= QTransitos.FieldByName('n_transito').AsInteger;
  dFecha:= QTransitos.FieldByName('fecha_transito').AsDateTime;
  rkilos:= 0;
  iLinTran:= 0;
  while ( iReferencia = QTransitos.FieldByName('n_transito').AsInteger ) and
        ( dFecha = QTransitos.FieldByName('fecha_transito').AsDateTime ) and
        not QTransitos.Eof do
  begin
    with kbmLinTransitos do
    begin
      kbmLinTransitos.Insert;
      kbmLinTransitos.FieldByName('tran').AsInteger:= iCabTran;
      kbmLinTransitos.FieldByName('lin').AsInteger:= iLinTran;
      kbmLinTransitos.FieldByName('envase').AsString:= QTransitos.fieldByName('envase').AsString;
      kbmLinTransitos.FieldByName('fecha_transito').AsDateTime:= QTransitos.fieldByName('fecha_transito').AsDateTime;
      kbmLinTransitos.FieldByName('kilos').AsFloat:= QTransitos.fieldByName('kilos').AsFloat;
      kbmLinTransitos.FieldByName('coste_kg').AsFloat:= 0;
      kbmLinTransitos.Post;
      rkilos:= rkilos +  QTransitos.fieldByName('kilos').AsFloat;
      inc( iLinTran );
    end;
    QTransitos.Next;
  end;

  with kbmCabTransitos do
  begin
    kbmCabTransitos.Insert;
    kbmCabTransitos.FieldByName('tran').AsInteger:= iCabTran;

    kbmCabTransitos.FieldByName('empresa').AsString:= sEmpresa;
    kbmCabTransitos.FieldByName('centro_salida').AsString:= sCentro;
    kbmCabTransitos.FieldByName('n_transito').AsInteger:= iReferencia;
    kbmCabTransitos.FieldByName('fecha_transito').AsdateTime:= dFecha;

    kbmCabTransitos.FieldByName('kilos').AsFloat:= rKilos;
    kbmCabTransitos.FieldByName('coste_kg').AsFloat:= 0;
    kbmCabTransitos.Post;
  end;
end;

function  TFFobTransitosData.NumLinSal;
begin
  Inc(iLinSal);
  result:= iLinSal;
end;

Procedure TFFobTransitosData.NuevaLinea;
begin
  with QSalidas do
  begin
    kbmSalidasLin.Insert;
    kbmSalidasLin.FieldByName('tran').AsInteger:= iCabTran;
    kbmSalidasLin.FieldByName('cab').AsInteger:= iCabSal;
    kbmSalidasLin.FieldByName('lin').AsInteger:= NumLinSal;

    kbmSalidasLin.FieldByName('empresa').AsString:= FieldByName('empresa').AsString;
    kbmSalidasLin.FieldByName('centro_salida').AsString:= FieldByName('centro_salida').AsString;
    kbmSalidasLin.FieldByName('n_albaran').AsInteger:= FieldByName('n_albaran').AsInteger;
    kbmSalidasLin.FieldByName('fecha_albaran').AsDateTime:= FieldByName('fecha_albaran').AsDateTime;
    kbmSalidasLin.FieldByName('fecha_salida').AsDateTime:= QTransitos.FieldByName('fecha_transito').AsDateTime;

    kbmSalidasLin.FieldByName('cliente_salida').AsString:= FieldByName('cliente_salida').AsString;
    kbmSalidasLin.FieldByName('moneda').AsString:= FieldByName('moneda').AsString;
    kbmSalidasLin.FieldByName('transito').AsInteger:= FieldByName('transito').AsInteger;

    kbmSalidasLin.FieldByName('producto').AsString:= FieldByName('producto').AsString;
    kbmSalidasLin.FieldByName('envase').AsString:= FieldByName('envase').AsString;
    kbmSalidasLin.FieldByName('categoria').AsString:= FieldByName('categoria').AsString;
    kbmSalidasLin.FieldByName('calibre').AsString:= FieldByName('calibre').AsString;

    kbmSalidasLin.FieldByName('cajas').AsInteger:= FieldByName('cajas').AsInteger;
    kbmSalidasLin.FieldByName('kilos').AsFloat:= FieldByName('kilos').AsFloat;
    kbmSalidasLin.FieldByName('palets').AsInteger:= FieldByName('palets').AsInteger;

    kbmSalidasLin.FieldByName('neto').AsFloat:= FieldByName('neto').AsFloat;
    kbmSalidasLin.FieldByName('iva').AsFloat:= FieldByName('iva').AsFloat;
    kbmSalidasLin.FieldByName('total').AsFloat:= FieldByName('total').AsFloat;

    kbmSalidasLin.FieldByName('descuento').AsFloat:= 0;
    kbmSalidasLin.FieldByName('comision').AsFloat:= 0;

    kbmSalidasLin.FieldByName('gastos').AsFloat:= 0;
    kbmSalidasLin.FieldByName('coste_envase').AsFloat:= 0;
    kbmSalidasLin.FieldByName('coste_secciones').AsFloat:= 0;
    kbmSalidasLin.Post;
  end;
end;

Procedure TFFobTransitosData.NuevaCabecera;
begin
  if kbmSalidasCab.Locate('empresa;centro_salida;n_albaran;fecha_albaran',
       VarArrayOf([sEmpresa,sCentro,iAlbaran,dFecha]), []) then
  begin
    iCabSal:= kbmSalidasCab.FieldByName('cab').AsInteger;
  end
  else
  begin
    with QTotalesAlbaran do
    begin
      ParamByName('empresa').AsString:= sEmpresa;
      ParamByName('centro').AsString:= sCentro;
      ParamByName('albaran').AsInteger:= iAlbaran;
      ParamByName('fecha').AsDateTime:= dFecha;
      ParamByName('producto').AsString:= sProducto;
    end;


    inc( iMaxCabSal );
    iCabSal:= iMaxCabSal;
    with kbmSalidasCab do
    begin
      Insert;
      FieldByName('tran').AsInteger:= iCabTran;
      FieldByName('cab').AsInteger:= iCabSal;

      FieldByName('empresa').AsString:= sEmpresa;
      FieldByName('centro_salida').AsString:= sCentro;
      FieldByName('n_albaran').AsInteger:= iAlbaran;
      FieldByName('fecha_albaran').AsDateTime:= dFecha;

      QTotalesAlbaran.Open;
      FieldByName('cajas_producto').AsInteger:= QTotalesAlbaran.FieldByName('cajas_producto').AsInteger;
      FieldByName('kilos_producto').AsFloat:= QTotalesAlbaran.FieldByName('kilos_producto').AsFloat;
      FieldByName('palets_producto').AsInteger:= QTotalesAlbaran.FieldByName('palets_producto').AsInteger;
      FieldByName('neto_producto').AsFloat:= QTotalesAlbaran.FieldByName('neto_producto').AsFloat;

      FieldByName('cajas_total').AsInteger:= QTotalesAlbaran.FieldByName('cajas_total').AsInteger;
      FieldByName('kilos_total').AsFloat:= QTotalesAlbaran.FieldByName('kilos_total').AsFloat;
      FieldByName('palets_total').AsInteger:= QTotalesAlbaran.FieldByName('palets_total').AsInteger;
      FieldByName('neto_total').AsFloat:= QTotalesAlbaran.FieldByName('neto_total').AsFloat;

      FieldByName('cajas_tproducto').AsInteger:= QTotalesAlbaran.FieldByName('cajas_t_producto').AsInteger;
      FieldByName('kilos_tproducto').AsFloat:= QTotalesAlbaran.FieldByName('kilos_t_producto').AsFloat;
      FieldByName('palets_tproducto').AsInteger:= QTotalesAlbaran.FieldByName('palets_t_producto').AsInteger;
      FieldByName('neto_tproducto').AsFloat:= QTotalesAlbaran.FieldByName('neto_t_producto').AsFloat;

      FieldByName('cajas_ttotal').AsInteger:= QTotalesAlbaran.FieldByName('cajas_t_total').AsInteger;;
      FieldByName('kilos_ttotal').AsFloat:= QTotalesAlbaran.FieldByName('kilos_t_total').AsFloat;
      FieldByName('palets_ttotal').AsInteger:= QTotalesAlbaran.FieldByName('palets_t_total').AsInteger;
      FieldByName('neto_ttotal').AsFloat:= QTotalesAlbaran.FieldByName('neto_t_total').AsFloat;
      QTotalesAlbaran.Close;

      FieldByName('gastos_cajas_total').AsInteger:= 0;
      FieldByName('gastos_kilos_total').AsFloat:= 0;
      FieldByName('gastos_palets_total').AsInteger:= 0;
      FieldByName('gastos_neto_total').AsFloat:= 0;

      FieldByName('gastost_cajas_total').AsInteger:= 0;
      FieldByName('gastost_kilos_total').AsFloat:= 0;
      FieldByName('gastost_palets_total').AsInteger:= 0;
      FieldByName('gastost_neto_total').AsFloat:= 0;

      FieldByName('gastos_cajas_producto').AsInteger:= 0;
      FieldByName('gastos_kilos_producto').AsFloat:= 0;
      FieldByName('gastos_palets_producto').AsInteger:= 0;
      FieldByName('gastos_neto_producto').AsFloat:= 0;

      FieldByName('gastost_cajas_producto').AsInteger:= 0;
      FieldByName('gastost_kilos_producto').AsFloat:= 0;
      FieldByName('gastost_palets_producto').AsInteger:= 0;
      FieldByName('gastost_neto_producto').AsFloat:= 0;

      kbmSalidasCab.Post;
    end;
  end;
end;

procedure TFFobTransitosData.RellenarTablas;
begin
  with QSalidas do
  begin
    while not EOF do
    begin
      sEmpresa:= FieldByName('empresa').AsString;
      sCentro:= FieldByName('centro_salida').AsString;
      iAlbaran:= FieldByName('n_albaran').AsInteger;
      dFecha:= FieldByName('fecha_albaran').AsDateTime;
      sProducto:= FieldByName('producto').AsString;

      NuevaCabecera;
      NuevaLinea;
      Next;
    end;
  end;
end;

Procedure TFFobTransitosData.PutGastosAlbaranes( const AExcluir036: Boolean = False );
begin
  with kbmSalidasCab do
  begin
    First;
    QueryGastos( AExcluir036 );
    while not EOF do
    begin
      GastosAlbaran( AExcluir036 );
      Next;
    end;
  end;
end;

Procedure TFFobTransitosData.GastosAlbaran( const AExcluir036: Boolean = False );
var
  iMultiplicador: integer;
begin
  with QGastos do
  begin
    ParamByName('empresa').AsString:= kbmSalidasCab.fieldBYName('empresa').AsString;
    ParamByName('centro').AsString:= kbmSalidasCab.fieldBYName('centro_salida').AsString;
    ParamByName('albaran').AsInteger:= kbmSalidasCab.fieldBYName('n_albaran').AsInteger;
    ParamByName('fecha').AsDateTime:= kbmSalidasCab.fieldBYName('fecha_albaran').AsDateTime;
    Open;
    if not IsEmpty then
    begin
      gPalets:= 0;
      gCajas:= 0;
      gKilos:= 0;
      gImporte:= 0;
      gtPalets:= 0;
      gtCajas:= 0;
      gtKilos:= 0;
      gtImporte:= 0;
      while not Eof do
      begin
        if FieldByName('facturable').AsString = 'S' then
          iMultiplicador:= -1
        else
          iMultiplicador:= 1;
        if FieldByName('transito').AsInteger = 0 then
        begin
          if FieldByName('unidad').AsString = 'PALETS' then
          begin
            gPalets:= gPalets +  ( FieldByName('importe').AsFloat * iMultiplicador );
          end
          else
          if FieldByName('unidad').AsString = 'CAJAS' then
          begin
            gCajas:= gCajas +  ( FieldByName('importe').AsFloat * iMultiplicador );
          end
          else
          if FieldByName('unidad').AsString = 'IMPORTE' then
          begin
            gImporte:= gImporte +  ( FieldByName('importe').AsFloat * iMultiplicador );
          end
          else
          //KILOS
          begin
            gKilos:= gKilos +  ( FieldByName('importe').AsFloat * iMultiplicador );
          end;
        end
        else
        if FieldByName('transito').AsInteger = 1 then
        begin
          (*TODO*)
          (*
          if FieldByName('unidad').AsString = 'PALETS' then
          begin
            gtPalets:= gtPalets + ( FieldByName('importe').AsFloat * iMultiplicador );
          end
          else
          if FieldByName('unidad').AsString = 'CAJAS' then
          begin
            gtCajas:= gtCajas + ( FieldByName('importe').AsFloat * iMultiplicador );
          end
          else
          if FieldByName('unidad').AsString = 'IMPORTE' then
          begin
            gtImporte:= gtImporte + ( FieldByName('importe').AsFloat * iMultiplicador );
          end
          else
          *)
          //KILOS
          begin
            gtKilos:= gtKilos + ( FieldByName('importe').AsFloat * iMultiplicador );
          end;
        end;
        Next;
      end;
      DistribuirGastosAlbaran;
    end;
    Close;
  end;
end;

Procedure TFFobTransitosData.DistribuirGastosAlbaran;
var
  rGastos: real;
begin
  (*TODO*)
  //Evitar las perdidas por redondeo
  with kbmSalidasCab do
  begin
    Edit;
    FieldByName('gastos_cajas_total').AsFloat:= gCajas;
    FieldByName('gastos_kilos_total').AsFloat:= gKilos;
    FieldByName('gastos_palets_total').AsFloat:= gPalets;
    FieldByName('gastos_neto_total').AsFloat:= gImporte;

    FieldByName('gastost_cajas_total').AsFloat:= gtCajas;
    FieldByName('gastost_kilos_total').AsFloat:= gtKilos;
    FieldByName('gastost_palets_total').AsFloat:= gtPalets;
    FieldByName('gastost_neto_total').AsFloat:= gtImporte;

    (*TODO*)
    if FieldByName('cajas_total').AsInteger = 0 then
      FieldByName('gastos_cajas_producto').AsFloat:= 0
    else
      FieldByName('gastos_cajas_producto').AsFloat:=
        bRoundTo( ( gCajas * FieldByName('cajas_producto').AsInteger ) / FieldByName('cajas_total').AsInteger, -2 );
    if FieldByName('kilos_total').AsInteger = 0 then
      FieldByName('gastos_kilos_producto').AsFloat:= 0
    else
      FieldByName('gastos_kilos_producto').AsFloat:=
      bRoundTo( ( ( gPalets + gKilos ) * FieldByName('kilos_producto').AsInteger ) / FieldByName('kilos_total').AsInteger, -2 );
    (*TODO*)
    FieldByName('gastos_palets_producto').AsFloat:= 0;
    (*
    if FieldByName('palets_total').AsInteger = 0 then
      FieldByName('gastos_palets_producto').AsFloat:= 0
    else
      FieldByName('gastos_palets_producto').AsFloat:=
        bRoundTo( ( gPalets * FieldByName('palets_producto').AsInteger ) / FieldByName('palets_total').AsInteger, -2 );
    *)
    if FieldByName('neto_total').AsInteger = 0 then
      FieldByName('gastos_neto_producto').AsFloat:= 0
    else
      FieldByName('gastos_neto_producto').AsFloat:=
        bRoundTo( ( gImporte * FieldByName('neto_producto').AsInteger ) / FieldByName('neto_total').AsInteger, -2 );

    (*TODO*)
    //Los gastos de transito es las salidas se distribuyen por kilos????
    if FieldByName('kilos_ttotal').AsInteger = 0 then
      FieldByName('gastost_kilos_producto').AsFloat:= 0
    else
      FieldByName('gastost_kilos_producto').AsFloat:=
        bRoundTo( ( gtKilos * FieldByName('kilos_tproducto').AsInteger ) / FieldByName('kilos_ttotal').AsInteger, -2 );
    FieldByName('gastost_cajas_producto').AsFloat:= 0;
    FieldByName('gastost_palets_producto').AsFloat:= 0;
    FieldByName('gastost_neto_producto').AsFloat:= 0;
    Post;
  end;
  with kbmSalidasLin do
  begin
    while not eof do
    begin
      //Gastos generales, siempre
      begin
        rGastos:= 0;
        if kbmSalidasCab.FieldByName('cajas_producto').AsInteger <> 0 then
          rGastos:= rGastos + bRoundTo( ( kbmSalidasCab.FieldByName('gastos_cajas_producto').AsFloat * FieldByName('cajas').AsInteger ) /
                                 kbmSalidasCab.FieldByName('cajas_producto').AsInteger, -2 );
        if kbmSalidasCab.FieldByName('palets_producto').AsInteger <> 0 then
          rGastos:= rGastos + bRoundTo( ( kbmSalidasCab.FieldByName('gastos_palets_producto').AsFloat * FieldByName('palets').AsInteger ) /
                                 kbmSalidasCab.FieldByName('palets_producto').AsInteger, -2 );
        if kbmSalidasCab.FieldByName('kilos_producto').AsFloat <> 0 then
          rGastos:= rGastos + bRoundTo( ( kbmSalidasCab.FieldByName('gastos_kilos_producto').AsFloat  * FieldByName('kilos').AsFloat ) /
                                 kbmSalidasCab.FieldByName('kilos_producto').AsFloat, -2 );
        if kbmSalidasCab.FieldByName('neto_producto').AsFloat <> 0 then
          rGastos:= rGastos + bRoundTo( ( kbmSalidasCab.FieldByName('gastos_neto_producto').AsFloat * FieldByName('neto').AsFloat ) /
                                 kbmSalidasCab.FieldByName('neto_producto').AsFloat, -2 );
      end;
      //Solo si es productro de un transito
      if FieldByName('transito').AsInteger = 1 then
      begin
        (*TODO*)
        //Los gastos de transito es las salidas se distribuyen por kilos????
        if kbmSalidasCab.FieldByName('kilos_tproducto').AsFloat <> 0 then
          rGastos:= rGastos + bRoundTo( ( kbmSalidasCab.FieldByName('gastost_kilos_producto').AsFloat * FieldByName('kilos').AsFloat ) /
                                 kbmSalidasCab.FieldByName('kilos_tproducto').AsFloat, -2 );
      end;
      Edit;
      FieldByName('gastos').AsFloat:= rGastos;
      Post;
      Next;
    end;
  end;
end;

Procedure TFFobTransitosData.PasarAEuros;
var
  rChange: Real;
  dFecha: TDateTime;
  sMoneda: String;
begin
  with kbmSalidasLin do
  begin
    First;

    dFecha:= FieldByName('fecha_albaran').AsDateTime;
    sMoneda:= FieldByName('moneda').AsString;
    if ( sMoneda <> 'EUR' ) and ( sMoneda <> '' ) then
    begin
      rChange:= ToEuro( FieldByName('moneda').AsString, FieldByName('fecha_albaran').AsDateTime );
    end
    else
    begin
      rChange:= 1;
    end;

    while not EOF do
    begin
      if ( dFecha = FieldByName('fecha_albaran').AsDateTime ) and
         ( sMoneda = FieldByName('moneda').AsString ) then
      begin
        if sMoneda <> 'EUR' then
        begin
          kbmSalidasLin.Edit;
          kbmSalidasLin.FieldByName('moneda').AsString:= 'EUR';
          kbmSalidasLin.FieldByName('neto').AsFloat:= bRoundTo( FieldByName('neto').AsFloat *  rChange, -2 );
          kbmSalidasLin.FieldByName('iva').AsFloat:= bRoundTo( FieldByName('iva').AsFloat *  rChange, -2 );
          kbmSalidasLin.FieldByName('total').AsFloat:= bRoundTo( FieldByName('total').AsFloat *  rChange, -2 );
          kbmSalidasLin.Post;
        end;
      end
      else
      begin
        if (sMoneda <> 'EUR')  then
        begin
          if (sMoneda <> '') then
            rChange:= ToEuro( FieldByName('moneda').AsString, FieldByName('fecha_albaran').AsDateTime )
          else
            rChange:= 1;

          kbmSalidasLin.Edit;
          kbmSalidasLin.FieldByName('moneda').AsString:= 'EUR';
          kbmSalidasLin.FieldByName('neto').AsFloat:= bRoundTo( FieldByName('neto').AsFloat *  rChange, -2 );
          kbmSalidasLin.FieldByName('iva').AsFloat:= bRoundTo( FieldByName('iva').AsFloat *  rChange, -2 );
          kbmSalidasLin.FieldByName('total').AsFloat:= bRoundTo( FieldByName('total').AsFloat *  rChange, -2 );
          kbmSalidasLin.Post;
        end
        else
        begin
          rChange:= 1;
        end;
      end;

      Next;
    end;
  end;
end;

procedure TFFobTransitosData.PutDescuentos;
var
  rComision, rDescuento: Real;
begin
  with kbmSalidasLin do
  begin
    First;
    kbmDescuentos.Open;
    while not eof do
    begin
      Edit;
      GetDescuento( rComision, rDescuento );
      FieldByName('comision').AsFloat:=
        bRoundTo( FieldByName('neto').AsFloat * rComision, -2 );
      FieldByName('descuento').AsFloat:=
        bRoundTo( ( FieldByName('neto').AsFloat - FieldByName('comision').AsFloat )* rDescuento, -2 );
      Post;
      Next;
    end;
    kbmDescuentos.Close;
  end;
end;

procedure TFFobTransitosData.GetDescuento( var AComision, ADescuento: Real );
begin
  if kbmDescuentos.Locate('empresa;cliente;fecha', VarArrayOf([
                     kbmSalidasLin.FieldByName('empresa').AsString,
                     kbmSalidasLin.FieldByName('cliente_salida').AsString,
                     kbmSalidasLin.FieldByName('fecha_salida').AsDateTime]), []) then
  begin
    AComision:= kbmDescuentos.FieldByName('comision').AsFloat;
    ADescuento:= kbmDescuentos.FieldByName('descuento').AsFloat;
  end
  else
  begin
    GetDescuentoAux( AComision, ADescuento );
    with kbmDescuentos do
    begin
      Insert;
      FieldByName('empresa').AsString:= kbmSalidasLin.FieldByName('empresa').AsString;
      FieldByName('cliente').AsString:= kbmSalidasLin.FieldByName('cliente_salida').AsString;
      FieldByName('fecha').AsDateTime:= kbmSalidasLin.FieldByName('fecha_salida').AsDateTime;
      FieldByName('comision').AsFloat:= AComision;
      FieldByName('descuento').AsFloat:= ADescuento;
      Post;
    end;
  end;
end;

procedure TFFobTransitosData.GetDescuentoAux( var AComision, ADescuento: Real );
begin
  with QDescuentos do
  begin
    ParamByName('empresa').AsString:= kbmSalidasLin.FieldByName('empresa').AsString;
    ParamByName('cliente').AsString:= kbmSalidasLin.FieldByName('cliente_salida').AsString;
    ParamByName('fecha').AsDate:= kbmSalidasLin.FieldByName('fecha_salida').AsDateTime;
    Open;
    AComision:= bRoundTo( FieldByName('comision').AsFloat / 100, -5);
    ADescuento:= bRoundTo( FieldByName('descuento').AsFloat / 100, -5);
    Close;
  end;
end;

procedure TFFobTransitosData.PutCosteEnvase( const AEnvasado, ASecciones: Boolean );
var
  rEnvasado, rSeciones: Real;
begin
  with kbmCabTransitos do
  begin
    First;
    PutProductoBase;
    while not eof do
    begin
      PutCosteEnvaseTransito( rEnvasado, rSeciones );
      CosteEnvaseLineas( AEnvasado, rEnvasado, ASecciones, rSeciones );
      Next;
    end;
  end;
end;

procedure TFFobTransitosData.CosteEnvaseLineas( const ABEnvasado: boolean; const AEnvasado: Real;
                                                const ABSecciones: Boolean; const ASecciones: Real );
begin
  with kbmSalidasLin do
  begin
    First;
    while not eof do
    begin
      Edit;
      if ABEnvasado then
        FieldByName('coste_envase').AsFloat:= bRoundTo( FieldByName('kilos').AsFloat * AEnvasado, -2 );
      if ABSecciones then
        FieldByName('coste_secciones').AsFloat:= bRoundTo( FieldByName('kilos').AsFloat * ASecciones, -2 );
      Post;
      Next;
    end;
  end;
end;

procedure TFFobTransitosData.PutProductoBase;
begin
  with QProductoBase do
  begin
    ParamByName('empresa').AsString:= kbmSalidasLin.FieldByName('empresa').AsString;
    ParamByName('producto').AsString:= kbmSalidasLin.FieldByName('producto').AsString;
    Open;
    iProductoBase:= FieldByName('producto_base_p').AsInteger;
    Close;
  end;
end;

procedure TFFobTransitosData.PutCosteEnvaseTransito( var AEnvasado, ASecciones: real );
var
  rTotal: real;
begin
  GetCosteEnvase( AEnvasado, ASecciones );
  with kbmLinTransitos do
  begin
    rTotal:= 0;
    while not EOF do
    begin
      edit;
      FieldByName('coste_kg').AsFloat:= AEnvasado;
      Post;
      rTotal:= rTotal+ ( FieldByName('coste_kg').AsFloat * FieldByName('kilos').AsFloat );
      Next;
    end;
  end;
  with kbmCabTransitos do
  begin
    Edit;
    FieldByName('coste_kg').AsFloat:= bRoundTo(
      rTotal / FieldByName('kilos').AsFloat, - 5);
    Post;
    //AEnvasado:= FieldByName('coste_kg').AsFloat;
    //ASecciones:= FieldByName('coste_kg').AsFloat;
  end;
end;

procedure TFFobTransitosData.GetCosteEnvase( var AEnvasado, ASecciones: real );
var
  iAnyo, iMes, iDia: Word;
begin
  with QCosteEnvase do
  begin
    ParamByName('empresa').AsString := kbmCabTransitos.FieldByName('empresa').AsString;
    ParamByName('centro').AsString := kbmCabTransitos.FieldByName('centro_salida').AsString;
    ParamByName('envase').AsString := kbmLinTransitos.FieldByName('envase').AsString;
    ParamByName('producto').AsInteger := iProductoBase;
    DecodeDate( kbmCabTransitos.FieldByName('fecha_transito').AsDateTime, iAnyo, iMes, iDia );
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


procedure TFFobTransitosData.RellenarTablaListadoAnyoSemana;
begin
  RellenarTransitosAnyoSemana;
  RellenarSalidasAnyoSemana;
  ReunirTablasAnyoSemana;
end;

procedure TFFobTransitosData.RellenarTransitosAnyoSemana;
var
  rKilos: Real;
  sAnyoSemana, sEnvase: string;
begin
  with kbmLinTransitos do
  begin
    MasterSource:= nil;
    First;
    kbmTransitosAnyoSemana.Open;
    kbmAnyoSemana.Open;
    while not eof do
    begin
      rKilos:= FieldByName('kilos').AsFloat;
      sAnyoSemana:= AnyoSemana( FieldByName('fecha_transito').AsFloat );
      sEnvase:= FieldByName('envase').AsString;

      if not kbmAnyoSemana.Locate('anyosemana', VarArrayOf([sAnyoSemana]), []) then
      begin
        kbmAnyoSemana.Insert;
        kbmAnyoSemana.FieldByName('AnyoSemana').AsString:= sAnyoSemana;
        kbmAnyoSemana.Post;
      end;

      if kbmTransitosAnyoSemana.Locate('anyosemana;envase', VarArrayOf([sAnyoSemana, sEnvase]), []) then
      begin
        kbmTransitosAnyoSemana.Edit;
        kbmTransitosAnyoSemana.FieldByName('kilos').AsFloat:= kbmTransitosAnyoSemana.FieldByName('kilos').AsFloat + rKilos;
        kbmTransitosAnyoSemana.Post;
      end
      else
      begin
        kbmTransitosAnyoSemana.Insert;
        kbmTransitosAnyoSemana.FieldByName('AnyoSemana').AsString:= sAnyoSemana;
        kbmTransitosAnyoSemana.FieldByName('Envase').AsString:= sEnvase;
        kbmTransitosAnyoSemana.FieldByName('kilos').AsFloat:= rKilos;
        kbmTransitosAnyoSemana.Post;
      end;
      next;
    end;
  end;
end;

procedure TFFobTransitosData.RellenarSalidasAnyoSemana;
var
  rKilos, rNeto, rCoste, rFob: Real;
  sAnyoSemana, sEnvase: string;
begin
  with kbmSalidasLin do
  begin
    First;
    kbmSalidasAnyoSemana.Open;
    while not eof do
    begin
      sAnyoSemana:= AnyoSemana( FieldByName('fecha_salida').AsFloat );
      sEnvase:= FieldByName('envase').AsString;
      rKilos:= FieldByName('kilos').AsFloat;
      rNeto:= FieldByName('neto').AsFloat - (FieldByName('comision').AsFloat + FieldByName('descuento').AsFloat);
      rCoste:= FieldByName('gastos').AsFloat + FieldByName('coste_envase').AsFloat + FieldByName('coste_secciones').AsFloat;
      rFOB:= rNeto - rCoste;

      if kbmSalidasAnyoSemana.Locate('anyosemana;envase', VarArrayOf([sAnyoSemana, sEnvase]), []) then
      begin
        kbmSalidasAnyoSemana.Edit;
        kbmSalidasAnyoSemana.FieldByName('kilos').AsFloat:= kbmSalidasAnyoSemana.FieldByName('kilos').AsFloat + rKilos;
        kbmSalidasAnyoSemana.FieldByName('neto').AsFloat:= kbmSalidasAnyoSemana.FieldByName('neto').AsFloat + rNeto;
        kbmSalidasAnyoSemana.FieldByName('gastos').AsFloat:= kbmSalidasAnyoSemana.FieldByName('gastos').AsFloat + rCoste;
        kbmSalidasAnyoSemana.FieldByName('fob').AsFloat:= kbmSalidasAnyoSemana.FieldByName('fob').AsFloat + rFob;
        kbmSalidasAnyoSemana.Post;
      end
      else
      begin
        kbmSalidasAnyoSemana.Insert;
        kbmSalidasAnyoSemana.FieldByName('AnyoSemana').AsString:= sAnyoSemana;
        kbmSalidasAnyoSemana.FieldByName('Envase').AsString:= sEnvase;
        kbmSalidasAnyoSemana.FieldByName('kilos').AsFloat:= rKilos;
        kbmSalidasAnyoSemana.FieldByName('neto').AsFloat:=  rNeto;
        kbmSalidasAnyoSemana.FieldByName('gastos').AsFloat:= rCoste;
        kbmSalidasAnyoSemana.FieldByName('fob').AsFloat:= rFob;
        kbmSalidasAnyoSemana.Post;
      end;
      next;
    end;
  end;
end;

procedure TFFobTransitosData.ReunirTablasAnyoSemana;
begin
  kbmSalidasAnyoSemana.MasterFields:= 'anyosemana';
  kbmSalidasAnyoSemana.IndexFieldNames:= 'anyosemana';
  kbmSalidasAnyoSemana.MasterSource:= DSListado;
  kbmTransitosAnyoSemana.MasterFields:= 'anyosemana';
  kbmTransitosAnyoSemana.IndexFieldNames:= 'anyosemana';
  kbmTransitosAnyoSemana.MasterSource:= DSListado;

  kbmAnyoSemana.First;
  kbmSalidasAnyoSemana.First;
  kbmTransitosAnyoSemana.First;
  kbmListadoAnyoSemana.Open;
  while not kbmAnyoSemana.Eof do
  begin
   while ( not kbmTransitosAnyoSemana.Eof ) or ( not kbmSalidasAnyoSemana.Eof ) do
   begin
    if ( not kbmTransitosAnyoSemana.Eof ) and ( not kbmSalidasAnyoSemana.Eof ) then
    begin
      with kbmListadoAnyoSemana do
      begin
        insert;
        FieldByName('AnyoSemana').AsString:= kbmTransitosAnyoSemana.FieldByName('AnyoSemana').AsString;
        FieldByName('Envase_tran').AsString:= kbmTransitosAnyoSemana.FieldByName('envase').AsString;
        FieldByName('kilos_tran').AsFloat:= kbmTransitosAnyoSemana.FieldByName('kilos').AsFloat;
        FieldByName('Envase_sal').AsString:= kbmSalidasAnyoSemana.FieldByName('envase').AsString;
        FieldByName('kilos_sal').AsFloat:= kbmSalidasAnyoSemana.FieldByName('kilos').AsFloat;
        FieldByName('neto').AsFloat:=  kbmSalidasAnyoSemana.FieldByName('neto').AsFloat;
        FieldByName('gastos').AsFloat:= kbmSalidasAnyoSemana.FieldByName('gastos').AsFloat;
        FieldByName('fob').AsFloat:= kbmSalidasAnyoSemana.FieldByName('fob').AsFloat;
        Post;
      end;
      kbmTransitosAnyoSemana.Next;
      kbmSalidasAnyoSemana.Next;
    end
    else
    if not kbmTransitosAnyoSemana.Eof then
    begin
      with kbmListadoAnyoSemana do
      begin
        insert;
        FieldByName('AnyoSemana').AsString:= kbmTransitosAnyoSemana.FieldByName('AnyoSemana').AsString;
        FieldByName('Envase_tran').AsString:= kbmTransitosAnyoSemana.FieldByName('envase').AsString;
        FieldByName('kilos_tran').AsFloat:= kbmTransitosAnyoSemana.FieldByName('kilos').AsFloat;
        FieldByName('Envase_sal').AsString:= '';
        FieldByName('kilos_sal').AsFloat:= 0;
        FieldByName('neto').AsFloat:=  0;
        FieldByName('gastos').AsFloat:= 0;
        FieldByName('fob').AsFloat:= 0;
        Post;
      end;
      kbmTransitosAnyoSemana.Next;
    end
    else
    if not kbmSalidasAnyoSemana.Eof then
    begin
      with kbmListadoAnyoSemana do
      begin
        insert;
        FieldByName('AnyoSemana').AsString:= kbmTransitosAnyoSemana.FieldByName('AnyoSemana').AsString;
        FieldByName('Envase_tran').AsString:= '';
        FieldByName('kilos_tran').AsFloat:= 0;
        FieldByName('Envase_sal').AsString:= kbmSalidasAnyoSemana.FieldByName('envase').AsString;
        FieldByName('kilos_sal').AsFloat:= kbmSalidasAnyoSemana.FieldByName('kilos').AsFloat;
        FieldByName('neto').AsFloat:=  kbmSalidasAnyoSemana.FieldByName('neto').AsFloat;
        FieldByName('gastos').AsFloat:= kbmSalidasAnyoSemana.FieldByName('gastos').AsFloat;
        FieldByName('fob').AsFloat:= kbmSalidasAnyoSemana.FieldByName('fob').AsFloat;
       Post;
      end;
      kbmSalidasAnyoSemana.Next;
    end;
   end;
   kbmAnyoSemana.Next;
  end;
end;

end.
