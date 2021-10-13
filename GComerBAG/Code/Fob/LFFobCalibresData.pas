unit LFFobCalibresData;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TFFobCalibresData = class(TDataModule)
    QSalidas: TQuery;
    kbmSalidasLin: TkbmMemTable;
    kbmSalidasCab: TkbmMemTable;
    DSSalidas: TDataSource;
    QGastos: TQuery;
    QCosteEnvase: TQuery;
    QProductoBase: TQuery;
    QDescuentos: TQuery;
    kbmDescuentos: TkbmMemTable;
    kbmPorCalibres: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    scentroOrigen: string;
    sEmpresa, sCentro, sProducto: String;
    dFecha: TDateTime;
    iAlbaran: Integer;
    iProductoBase: integer;

    iCajas_producto, iPalets_producto: Integer;
    rKilos_producto, rNeto_producto: Real;
    iCajas_tproducto, iPalets_tproducto: Integer;
    rKilos_tproducto, rNeto_tproducto: Real;

    iCajas_total, iPalets_total: Integer;
    rKilos_total, rNeto_total: Real;
    iCajas_ttotal, iPalets_ttotal: Integer;
    rKilos_ttotal, rNeto_ttotal: Real;

    (*gPalets, gCajas, gKilos, gImporte: Real;
    gtPalets, gtCajas, gtKilos, gtImporte: Real;*)
    ggtodos, ggtransito, gptodos, gptransito: Real;


    Procedure TablaTemporalCab;
    Procedure TablaTemporalLin;
    procedure TablaTemporalDescuentos;
    Procedure QuerySalidas;
    Procedure QueryGastos;
    Procedure QueryCosteEnvase;
    procedure QueryDescuentos;
    Procedure QueryProductoBase;

    function  ObtenerSalidas( const Aempresa, ACentro, AProducto, ACategoria: string;
                              const AFechaDesde, AFechaHasta: TDateTime ): boolean;
    function  RellenarTablas( const AProducto, ACategoria: string ): boolean;
    Procedure IniAcumProducto;
    Procedure IniAcumTotal;
    Procedure AcumProducto;
    Procedure AcumTotal;
    function  EsLineaValida( const AProducto, ACategoria: string ): boolean;
    Procedure NuevaLinea( const ACab, ALin: Integer );
    Procedure NuevaCabecera( const ACab: Integer );

    //GASTOS
    Procedure PutGastosAlbaranes;
    Procedure GastosAlbaran;
    Procedure DistribuirGastosAlbaran;

    //PASAR LA MONEDA A EUROS
    Procedure PasarAEuros;

    //COMISION DEL REPRESENTANTE - DESCUENTO DEL CLIENTE
    procedure PutDescuentos;
    procedure GetDescuento( var AComision, ADescuento, ADescuentoConIva: Real );
    procedure GetDescuentoAux( var AComision, ADescuento, ADescuentoConIva: Real );

    //COSTES ENVASE
    procedure PutCosteEnvase( const AEnvase, ASecciones: Boolean );
    procedure PutProductoBase;
    procedure GetCosteEnvase( var AEnvase, ASecciones: real );

    //LISTADO POR CALIBRES
    procedure TablaTemporalPorCalibres;
  public
    { Public declarations }
    procedure RellenarTablaPorCalibres;
    function ObtenerDatosListado( const Aempresa, ACentro, AProducto, ACategoria: string;
                             const AFechaDesde, AFechaHasta: TDateTime;
                             const bGastos, bEnvase, bEnvasado: Boolean ): boolean;
  end;

var
  FFobCalibresData: TFFobCalibresData;

implementation

{$R *.dfm}

uses bMath, UDMCambioMoneda, Dialogs, Variants;

procedure TFFobCalibresData.TablaTemporalCab;
begin
  kbmSalidasCab.SortOptions := [];
  kbmSalidasCab.FieldDefs.Clear;

  kbmSalidasCab.FieldDefs.Add('cab', ftInteger, 0, False);

  kbmSalidasCab.FieldDefs.Add('empresa', ftString, 3, False);
  kbmSalidasCab.FieldDefs.Add('centro_salida', ftString, 1, False);
  kbmSalidasCab.FieldDefs.Add('n_albaran', ftInteger, 0, False);
  kbmSalidasCab.FieldDefs.Add('fecha_albaran', ftDate, 0, False);

  kbmSalidasCab.FieldDefs.Add('producto', ftString, 3, False);

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

  kbmSalidasCab.IndexDefs.Add('Index1','cab',[]);
  kbmSalidasCab.CreateTable;
  kbmSalidasCab.IndexFieldNames:= 'cab';
  kbmSalidasCab.SortFields := 'cab';
end;

procedure TFFobCalibresData.TablaTemporalLin;
begin
  kbmSalidasLin.SortOptions := [];
  kbmSalidasLin.FieldDefs.Clear;

  kbmSalidasLin.FieldDefs.Add('cab', ftInteger, 0, False);
  kbmSalidasLin.FieldDefs.Add('lin', ftInteger, 0, False);

  kbmSalidasLin.FieldDefs.Add('empresa', ftString, 3, False);
  kbmSalidasLin.FieldDefs.Add('centro_salida', ftString, 1, False);
  kbmSalidasLin.FieldDefs.Add('n_albaran', ftInteger, 0, False);
  kbmSalidasLin.FieldDefs.Add('fecha_albaran', ftDate, 0, False);

  kbmSalidasLin.FieldDefs.Add('cliente_salida', ftString, 3, False);
  kbmSalidasLin.FieldDefs.Add('moneda', ftString, 3, False);
  kbmSalidasLin.FieldDefs.Add('transito', ftInteger, 0, False);

  kbmSalidasLin.FieldDefs.Add('producto', ftString, 3, False);
  kbmSalidasLin.FieldDefs.Add('envase', ftString, 9,  False);
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

  kbmSalidasLin.IndexDefs.Add('Index1','cab;lin',[]);
  kbmSalidasLin.CreateTable;
  kbmSalidasLin.IndexFieldNames:= 'cab;lin';
  kbmSalidasLin.SortFields := 'cab;lin';
end;

procedure TFFobCalibresData.TablaTemporalDescuentos;
begin
  kbmDescuentos.SortOptions := [];
  kbmDescuentos.FieldDefs.Clear;
  kbmDescuentos.FieldDefs.Add('empresa', ftString, 3, False);
  kbmDescuentos.FieldDefs.Add('cliente', ftString, 3, False);
  kbmDescuentos.FieldDefs.Add('fecha', ftDate, 0, False);
  kbmDescuentos.FieldDefs.Add('descuento', ftFloat, 0, False);
  kbmDescuentos.FieldDefs.Add('descuentoconiva', ftFloat, 0, False);
  kbmDescuentos.FieldDefs.Add('comision', ftFloat, 0, False);
  kbmDescuentos.IndexDefs.Add('Index1','cliente',[]);
  kbmDescuentos.CreateTable;
  kbmDescuentos.IndexFieldNames:= 'cliente';
  kbmDescuentos.SortFields := 'cliente';
end;

procedure TFFobCalibresData.TablaTemporalPorCalibres;
begin
  kbmPorCalibres.SortOptions := [];
  kbmPorCalibres.FieldDefs.Clear;
  kbmPorCalibres.FieldDefs.Add('calibre', ftString, 6, False);
  kbmPorCalibres.FieldDefs.Add('kilos', ftFloat, 0, False);
  kbmPorCalibres.FieldDefs.Add('neto', ftFloat, 0, False);
  kbmPorCalibres.FieldDefs.Add('coste', ftFloat, 0, False);
  kbmPorCalibres.FieldDefs.Add('fob', ftFloat, 0, False);
  kbmPorCalibres.IndexDefs.Add('Index1','calibre',[]);
  kbmPorCalibres.CreateTable;
  kbmPorCalibres.IndexFieldNames:= 'calibre';
  kbmPorCalibres.SortFields := 'calibre';
end;

procedure TFFobCalibresData.QueryProductoBase;
begin
  with QProductoBase do
  begin
    SQL.Clear;
    SQL.Add(' select producto_base_p ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where producto_p = :producto ');
    Prepare;
  end;
end;

procedure TFFobCalibresData.QuerySalidas;
begin
  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sc empresa, centro_salida_sc centro_salida, fecha_sc fecha_albaran, ');
    SQL.Add('          moneda_sc moneda, n_albaran_sc n_albaran, cliente_sal_sc cliente_salida, ');
    SQL.Add('          n_factura_sc factura, ');
    SQL.Add('          case when ( ref_transitos_sl is not null ) or ( nvl(es_transito_sc,0) =  1 ) then 1 else 0 end transito, ');
    SQL.Add('          producto_sl producto, envase_sl envase, categoria_sl categoria, calibre_sl calibre, ');
    SQL.Add('          sum(cajas_sl) cajas, sum(kilos_sl) kilos, sum(nvl(n_palets_sl,0)) palets, ');
    SQL.Add('          sum(importe_neto_sl) neto, sum(iva_sl) iva, sum(importe_total_sl) total  ');

    SQL.Add(' from frf_salidas_c, frf_salidas_l  ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and fecha_sc between :fechadesde and :fechahasta ');

    SQL.Add(' and empresa_sl = empresa_sc ');
    SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and centro_origen_sl = :centro ');

    SQL.Add(' and categoria_sl <> ''B'' ' );
    SQL.Add(' and cliente_sl not in (''0BO'', ''RET'', ''EG'', ''REA'')' );
    SQL.Add(' and nvl(kilos_sl,0) <> 0 ');

    SQL.Add(' and es_transito_sc <> 2 ');

    SQL.Add(' group by 1,2,3,4,5,6,7,8,9,10,11,12 ');
    SQL.Add(' order by 1,2,3,4,5,6,7,8,9,10,11,12 ');
    Prepare;
  end;
end;

procedure TFFobCalibresData.QueryGastos;
begin
  with QGastos do
  begin
    SQL.Clear;
    SQL.Add(' select  ');
    SQL.Add('        case when producto_g is null then 1 else 0 end generico, ');
    SQL.Add('        unidad_dist_tg unidad, facturable_tg facturable, ');
    SQL.Add('        gasto_transito_tg transito, importe_g importe ');
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');
    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add(' and centro_salida_g = :centro ');
    SQL.Add(' and n_albaran_g = :albaran ');
    SQL.Add(' and fecha_g = :fecha ');
    SQL.Add(' and ( ( producto_g = :producto ) or ( producto_g is null ) ) ');
    SQL.Add(' and tipo_tg = tipo_g ');

    Prepare;
  end;
end;

procedure TFFobCalibresData.QueryCosteEnvase;
begin
  with QCosteEnvase do
  begin
    SQL.Clear;
    SQL.Add('select first 1 anyo_ec, mes_ec, material_ec, personal_ec, general_ec ');
    SQL.Add('from frf_env_costes ');
    SQL.Add('where empresa_ec = :empresa ');
    SQL.Add('and centro_ec = :centro ');
    SQL.Add('and envase_ec = :envase ');
    SQL.Add('and producto_ec = :producto ');
    SQL.Add('and ( ( anyo_ec = :anyo and mes_ec <= :mes ) or ( anyo_ec < :anyo) )');
    SQL.Add('order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;
end;

procedure TFFobCalibresData.QueryDescuentos;
begin
  with QDescuentos do
  begin
    Close;
    if Prepared then
      UnPrepare;
    SQL.Clear;
    SQL.Add(' select GetComisionCliente(:empresa, cliente_c, :fecha) comision, ');
    SQL.Add('    GetDescuentoCliente( :empresa, cliente_c, :fecha, 2) descuento, ');
    SQL.Add('    GetDescuentoCliente( :empresa, cliente_c, :fecha, 3) descuento_con_iva ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where cliente_c = :cliente ');
    Prepare;
  end;
end;

procedure TFFobCalibresData.DataModuleCreate(Sender: TObject);
begin
  TablaTemporalCab;
  TablaTemporalLin;
  TablaTemporalDescuentos;

  TablaTemporalPorCalibres;

  QuerySalidas;
  QueryGastos;
  QueryCosteEnvase;
  QueryDescuentos;
  QueryProductoBase;
end;

procedure TFFobCalibresData.DataModuleDestroy(Sender: TObject);
  procedure UnPrepare( AQuery: TQuery );
  begin
    if AQuery.Prepared then
      AQuery.UnPrepare;
  end;
begin
  UnPrepare( QSalidas );
  UnPrepare( QGastos );
  UnPrepare( QProductoBase );
  UnPrepare( QCosteEnvase );
  UnPrepare( QDescuentos );
end;

function TFFobCalibresData.ObtenerDatosListado( const Aempresa, ACentro, AProducto, ACategoria: string;
                             const AFechaDesde, AFechaHasta: TDateTime;
                             const bGastos, bEnvase, bEnvasado: Boolean ): boolean;
begin
  scentroOrigen:= ACentro;
  kbmSalidasLin.MasterSource:= DSSalidas;
  result:= ObtenerSalidas( Aempresa, ACentro, AProducto, ACategoria, AFechaDesde, AFechaHasta );
  if result then
  begin
    if bGastos then
      PutGastosAlbaranes;

    kbmSalidasLin.MasterSource:= nil;
    kbmSalidasLin.First;

    PasarAEuros;
    PutDescuentos;

    if bEnvase or bEnvasado then
      PutCosteEnvase( bEnvase, bEnvasado );
  end
  else
  begin
    ShowMEssage('Listado sin datos.');
  end;
end;

function TFFobCalibresData.ObtenerSalidas( const AEmpresa, ACentro, AProducto, ACategoria: string;
                                           const AFechaDesde, AFechaHasta: TDateTime ): boolean;
begin
  with QSalidas do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaDesde').AsDateTime:= AFechaDesde;
    ParamByName('fechaHasta').AsDateTime:= AFechaHasta;

    Open;
    kbmSalidasLin.Close;
    kbmSalidasCab.Close;
    if not IsEmpty then
      result:= RellenarTablas( AProducto, ACategoria )
    else
      result:= False;
    Close;
  end;
end;

Procedure TFFobCalibresData.IniAcumProducto;
begin
  iCajas_producto:= 0;
  iPalets_producto:= 0;
  rKilos_producto:= 0;
  rNeto_producto:= 0;

  iCajas_tproducto:= 0;
  iPalets_tproducto:= 0;
  rKilos_tproducto:= 0;
  rNeto_tproducto:= 0;
end;

Procedure TFFobCalibresData.AcumProducto;
begin
  with QSalidas do
  begin
    iCajas_producto:= iCajas_producto + FieldByName('cajas').AsInteger;
    iPalets_producto:= iPalets_producto + FieldByName('palets').AsInteger;
    rKilos_producto:= rKilos_producto + FieldByName('kilos').AsFloat;
    rNeto_producto:= rNeto_producto + FieldByName('neto').AsFloat;
    if FieldByName('transito').AsInteger = 1 then
    begin
      rKilos_tproducto:= rKilos_tproducto + FieldByName('kilos').AsFloat;
      iCajas_tproducto:= iCajas_tproducto + FieldByName('cajas').AsInteger;
      iPalets_tproducto:= iPalets_tproducto + FieldByName('palets').AsInteger;
      rNeto_tproducto:= rNeto_tproducto + FieldByName('neto').AsFloat;
    end;
  end;
end;

Procedure TFFobCalibresData.IniAcumTotal;
begin
  iCajas_total:= 0;
  iPalets_total:= 0;
  rKilos_total:= 0;
  rNeto_total:= 0;

  iCajas_ttotal:= 0;
  iPalets_ttotal:= 0;
  rKilos_ttotal:= 0;
  rNeto_ttotal:= 0;
end;

Procedure TFFobCalibresData.AcumTotal;
begin
  with QSalidas do
  begin
    iCajas_total:= iCajas_total + FieldByName('cajas').AsInteger;
    iPalets_total:= iPalets_total + FieldByName('palets').AsInteger;
    rKilos_total:= rKilos_total + FieldByName('kilos').AsFloat;
    rNeto_total:= rNeto_total + FieldByName('neto').AsFloat;
    if FieldByName('transito').AsInteger = 1 then
    begin
      rKilos_ttotal:= rKilos_ttotal + FieldByName('kilos').AsFloat;
      iCajas_ttotal:= iCajas_ttotal + FieldByName('cajas').AsInteger;
      iPalets_ttotal:= iPalets_ttotal + FieldByName('palets').AsInteger;
      rNeto_ttotal:= rNeto_ttotal + FieldByName('neto').AsFloat;
    end;
  end;
end;

Procedure TFFobCalibresData.NuevaLinea( const ACab, ALin: Integer );
begin
  with QSalidas do
  begin
    kbmSalidasLin.Insert;
    kbmSalidasLin.FieldByName('cab').AsInteger:= ACab;
    kbmSalidasLin.FieldByName('lin').AsInteger:= ALin;

    kbmSalidasLin.FieldByName('empresa').AsString:= FieldByName('empresa').AsString;
    kbmSalidasLin.FieldByName('centro_salida').AsString:= FieldByName('centro_salida').AsString;
    kbmSalidasLin.FieldByName('n_albaran').AsInteger:= FieldByName('n_albaran').AsInteger;
    kbmSalidasLin.FieldByName('fecha_albaran').AsDateTime:= FieldByName('fecha_albaran').AsDateTime;

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

    kbmSalidasLin.FieldByName('gastos').AsFloat:= 0;
    kbmSalidasLin.Post;
  end;
end;

Procedure TFFobCalibresData.NuevaCabecera( const ACab: Integer );
begin
  with QSalidas do
  begin
    kbmSalidasCab.Insert;
    kbmSalidasCab.FieldByName('cab').AsInteger:= ACab;

    kbmSalidasCab.FieldByName('empresa').AsString:= sEmpresa;
    kbmSalidasCab.FieldByName('centro_salida').AsString:= sCentro;
    kbmSalidasCab.FieldByName('n_albaran').AsInteger:= iAlbaran;
    kbmSalidasCab.FieldByName('fecha_albaran').AsDateTime:= dFecha;

    kbmSalidasCab.FieldByName('producto').AsString:= sProducto;

    kbmSalidasCab.FieldByName('cajas_producto').AsInteger:= iCajas_producto;
    kbmSalidasCab.FieldByName('kilos_producto').AsFloat:= rKilos_producto;
    kbmSalidasCab.FieldByName('palets_producto').AsInteger:= iPalets_producto;
    kbmSalidasCab.FieldByName('neto_producto').AsFloat:= rNeto_producto;

    kbmSalidasCab.FieldByName('cajas_total').AsInteger:= iCajas_total;
    kbmSalidasCab.FieldByName('kilos_total').AsFloat:= rKilos_total;
    kbmSalidasCab.FieldByName('palets_total').AsInteger:= iPalets_total;
    kbmSalidasCab.FieldByName('neto_total').AsFloat:= rNeto_total;

    kbmSalidasCab.FieldByName('cajas_tproducto').AsInteger:= iCajas_tproducto;
    kbmSalidasCab.FieldByName('kilos_tproducto').AsFloat:= rKilos_tproducto;
    kbmSalidasCab.FieldByName('palets_tproducto').AsInteger:= iPalets_tproducto;
    kbmSalidasCab.FieldByName('neto_tproducto').AsFloat:= rNeto_tproducto;

    kbmSalidasCab.FieldByName('cajas_ttotal').AsInteger:= iCajas_ttotal;
    kbmSalidasCab.FieldByName('kilos_ttotal').AsFloat:= rKilos_ttotal;
    kbmSalidasCab.FieldByName('palets_ttotal').AsInteger:= iPalets_ttotal;
    kbmSalidasCab.FieldByName('neto_ttotal').AsFloat:= rNeto_ttotal;

    kbmSalidasCab.FieldByName('gastos_cajas_total').AsInteger:= 0;
    kbmSalidasCab.FieldByName('gastos_kilos_total').AsFloat:= 0;
    kbmSalidasCab.FieldByName('gastos_palets_total').AsInteger:= 0;
    kbmSalidasCab.FieldByName('gastos_neto_total').AsFloat:= 0;

    kbmSalidasCab.FieldByName('gastost_cajas_total').AsInteger:= 0;
    kbmSalidasCab.FieldByName('gastost_kilos_total').AsFloat:= 0;
    kbmSalidasCab.FieldByName('gastost_palets_total').AsInteger:= 0;
    kbmSalidasCab.FieldByName('gastost_neto_total').AsFloat:= 0;    

    kbmSalidasCab.FieldByName('gastos_cajas_producto').AsInteger:= 0;
    kbmSalidasCab.FieldByName('gastos_kilos_producto').AsFloat:= 0;
    kbmSalidasCab.FieldByName('gastos_palets_producto').AsInteger:= 0;
    kbmSalidasCab.FieldByName('gastos_neto_producto').AsFloat:= 0;

    kbmSalidasCab.FieldByName('gastost_cajas_producto').AsInteger:= 0;
    kbmSalidasCab.FieldByName('gastost_kilos_producto').AsFloat:= 0;
    kbmSalidasCab.FieldByName('gastost_palets_producto').AsInteger:= 0;
    kbmSalidasCab.FieldByName('gastost_neto_producto').AsFloat:= 0;

    kbmSalidasCab.Post;
  end;
end;

function TFFobCalibresData.EsLineaValida( const AProducto, ACategoria: string ): boolean;
begin
  if ACategoria <> '' then
  begin
    result := ( QSalidas.FieldByName('producto').AsString = AProducto ) and
              ( QSalidas.FieldByName('categoria').AsString = ACategoria );
  end
  else
  begin
    result := QSalidas.FieldByName('producto').AsString = AProducto;
  end;
  result:= result and (( QSalidas.FieldByName('neto').AsFloat <> 0 )
     or ( QSalidas.FieldByName('factura').AsString <> '' ));
end;


function TFFobCalibresData.RellenarTablas( const AProducto, ACategoria: string ): boolean;
var
  iCab, iLinea: Integer;
begin
  with QSalidas do
  begin
    iCab:= 0;
    iLinea:= 0;
    sEmpresa:= FieldByName('empresa').AsString;
    sCentro:= FieldByName('centro_salida').AsString;
    iAlbaran:= FieldByName('n_albaran').AsInteger;
    dFecha:= FieldByName('fecha_albaran').AsDateTime;
    sProducto:= AProducto;

    IniAcumProducto;
    IniAcumTotal;

    kbmSalidasCab.Open;
    kbmSalidasLin.Open;

    while not EOF do
    begin
      if EsLineaValida( AProducto, ACategoria ) then
      begin
        Inc( iLinea );
        NuevaLinea( iCab, iLinea );
        AcumProducto;
      end;
      AcumTotal;

      Next;

      if ( sEmpresa <> FieldByName('empresa').AsString ) or
         ( sCentro <> FieldByName('centro_salida').AsString ) or
         ( iAlbaran <> FieldByName('n_albaran').AsInteger ) or
         ( dFecha <> FieldByName('fecha_albaran').AsDateTime ) then
      begin
        if iLinea > 0 then
        begin
          NuevaCabecera( iCab );
          Inc( iCab );
        end;

        sEmpresa:= FieldByName('empresa').AsString;
        sCentro:= FieldByName('centro_salida').AsString;
        iAlbaran:= FieldByName('n_albaran').AsInteger;
        dFecha:= FieldByName('fecha_albaran').AsDateTime;

        IniAcumProducto;
        IniAcumTotal;
        iLinea:= 0;
      end;
    end;

    if iLinea > 0 then
    begin
      Inc( iCab );
      NuevaCabecera( iCab );
    end;
  end;
  result:= iCab > 1;
end;

Procedure TFFobCalibresData.PutGastosAlbaranes;
begin
  with kbmSalidasCab do
  begin
    First;
    while not EOF do
    begin
      GastosAlbaran;
      Next;
    end;
  end;
end;

Procedure TFFobCalibresData.GastosAlbaran;
var
  iMultiplicador: integer;
begin
  with QGastos do
  begin
    ParamByName('empresa').AsString:= kbmSalidasCab.fieldBYName('empresa').AsString;
    ParamByName('centro').AsString:= kbmSalidasCab.fieldBYName('centro_salida').AsString;
    ParamByName('albaran').AsInteger:= kbmSalidasCab.fieldBYName('n_albaran').AsInteger;
    ParamByName('fecha').AsDateTime:= kbmSalidasCab.fieldBYName('fecha_albaran').AsDateTime;
    ParamByName('producto').AsString:= kbmSalidasCab.fieldBYName('producto').AsString;
    Open;

    if not IsEmpty then
    begin
      (*
      gPalets:= 0;
      gCajas:= 0;
      gKilos:= 0;
      gImporte:= 0;

      gtPalets:= 0;
      gtCajas:= 0;
      gtKilos:= 0;
      gtImporte:= 0;
      *)
      ggtodos:= 0;
      ggtransito:= 0;
      gptodos:= 0;
      gptransito:= 0;

      while not Eof do
      begin
        if FieldByName('facturable').AsString = 'S' then
          iMultiplicador:= -1
        else
          iMultiplicador:= 1;

        if FieldByName('transito').AsInteger = 0 then
        begin
          (*
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
          *)
          //KILOS
          begin
            //gKilos:= gKilos +  ( FieldByName('importe').AsFloat * iMultiplicador );
            if FieldByName('generico').AsInteger = 1 then
            begin
              ggtodos:= ggtodos +  ( FieldByName('importe').AsFloat * iMultiplicador );
            end
            else
            begin
              gptodos:= gptodos +  ( FieldByName('importe').AsFloat * iMultiplicador );
            end;
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
            //gtKilos:= gtKilos + ( FieldByName('importe').AsFloat * iMultiplicador );
            if FieldByName('generico').AsInteger = 1 then
            begin
              ggtransito:= ggtransito +  ( FieldByName('importe').AsFloat * iMultiplicador );
            end
            else
            begin
              gptransito:= gptransito +  ( FieldByName('importe').AsFloat * iMultiplicador );
            end;
          end;
        end;
        Next;
      end;
      DistribuirGastosAlbaran;
    end;
    Close;
  end;
end;

Procedure TFFobCalibresData.DistribuirGastosAlbaran;
var
  rGastos: real;
begin
  (*TODO*)
  //Evitar las perdidas por redondeo
  with kbmSalidasCab do
  begin
    Edit;
    FieldByName('gastos_cajas_producto').AsFloat:= 0;
    FieldByName('gastos_palets_producto').AsFloat:= 0;
    FieldByName('gastos_neto_producto').AsFloat:= 0;

    FieldByName('gastos_cajas_total').AsFloat:= 0;
    FieldByName('gastos_palets_total').AsFloat:= 0;
    FieldByName('gastos_neto_total').AsFloat:= 0;

    FieldByName('gastost_cajas_producto').AsFloat:= 0;
    FieldByName('gastost_palets_producto').AsFloat:= 0;
    FieldByName('gastost_neto_producto').AsFloat:= 0;

    FieldByName('gastost_cajas_total').AsFloat:= 0;
    FieldByName('gastost_palets_total').AsFloat:= 0;
    FieldByName('gastost_neto_total').AsFloat:= 0;

    FieldByName('gastos_kilos_producto').AsFloat:= gptodos;
    FieldByName('gastost_kilos_producto').AsFloat:= gptransito;
    FieldByName('gastos_kilos_total').AsFloat:= ggtodos;
    FieldByName('gastost_kilos_total').AsFloat:= ggtransito;
    Post;
  end;
  with kbmSalidasLin do
  begin
    while not eof do
    begin
      rGastos:= 0;
      if kbmSalidasCab.FieldByName('kilos_producto').AsFloat <> 0 then
        rGastos:= rGastos + bRoundTo( ( ( gptodos * FieldByName('kilos').AsFloat ) / kbmSalidasCab.FieldByName('kilos_producto').AsFloat ), - 2);
      if kbmSalidasCab.FieldByName('kilos_total').AsFloat <> 0 then
        rGastos:= rGastos + bRoundTo( ( ( ggtodos * FieldByName('kilos').AsFloat ) / kbmSalidasCab.FieldByName('kilos_total').AsFloat ), - 2);
      if FieldByName('transito').AsInteger = 1 then
      begin
        if kbmSalidasCab.FieldByName('kilos_tproducto').AsFloat <> 0 then
          rGastos:= rGastos + bRoundTo( ( ( gptransito * FieldByName('kilos').AsFloat ) / kbmSalidasCab.FieldByName('kilos_tproducto').AsFloat ), - 2);
        if kbmSalidasCab.FieldByName('kilos_ttotal').AsFloat <> 0 then
          rGastos:= rGastos + bRoundTo( ( ( ggtransito * FieldByName('kilos').AsFloat ) / kbmSalidasCab.FieldByName('kilos_ttotal').AsFloat ), - 2);
        end;
      Edit;
      FieldByName('gastos').AsFloat:= rGastos;
      Post;
      Next;
    end;
  end;
end;

Procedure TFFobCalibresData.PasarAEuros;
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
          //kbmSalidasLin.FieldByName('moneda').AsString:= 'EUR';
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
          kbmSalidasLin.FieldByName('neto').AsString:= 'EUR';
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

procedure TFFobCalibresData.PutDescuentos;
var
  rComision, rDescuento, rDescuentoConIva: Real;
begin
  with kbmSalidasLin do
  begin
    First;
    kbmDescuentos.Open;
    while not eof do
    begin
      Edit;
      GetDescuento( rComision, rDescuento, rDescuentoConIva );
      FieldByName('comision').AsFloat:=
        bRoundTo( FieldByName('neto').AsFloat * rComision, -2 );
      FieldByName('descuento').AsFloat:=
        bRoundTo( ( FieldByName('neto').AsFloat - FieldByName('comision').AsFloat )* rDescuento, -2 );
//      FieldByName('descuentoconiva').AsFloat:=
//        bRoundTo( FieldByName('total').AsFloat * rDescuentoConIva, -2 );
      Post;
      Next;
    end;
    kbmDescuentos.Close;
  end;
end;

procedure TFFobCalibresData.GetDescuento( var AComision, ADescuento, ADescuentoConIva: Real );
begin
  if kbmDescuentos.Locate('empresa;cliente;fecha', VarArrayOf([
                          kbmSalidasLin.FieldByName('empresa').AsString,
                          kbmSalidasLin.FieldByName('cliente_salida').AsString,
                          kbmSalidasLin.FieldByName('fecha_albaran').AsDateTime]), []) then
  begin
    AComision:= kbmDescuentos.FieldByName('comision').AsFloat;
    ADescuento:= kbmDescuentos.FieldByName('descuento').AsFloat;
    ADescuentoConIva:= kbmDescuentos.FieldByName('descuentoconiva').AsFloat;
  end
  else
  begin
    GetDescuentoAux( AComision, ADescuento, ADescuentoConIva );
    with kbmDescuentos do
    begin
      Insert;
      FieldByName('empresa').AsString:= kbmSalidasLin.FieldByName('empresa').AsString;
      FieldByName('cliente').AsString:= kbmSalidasLin.FieldByName('cliente_salida').AsString;
      FieldByName('fecha').AsDateTime:= kbmSalidasLin.FieldByName('fecha_albaran').AsDateTime;
      FieldByName('comision').AsFloat:= AComision;
      FieldByName('descuento').AsFloat:= ADescuento;
      FieldByName('descuentoconiva').AsFloat:= ADescuentoConIva;
      Post;
    end;
  end;
end;

procedure TFFobCalibresData.GetDescuentoAux( var AComision, ADescuento, ADescuentoConIva: Real );
begin
  with QDescuentos do
  begin
    ParamByName('empresa').AsString:= kbmSalidasLin.FieldByName('empresa').AsString;
    ParamByName('cliente').AsString:= kbmSalidasLin.FieldByName('cliente_salida').AsString;
    ParamByName('fecha').AsDateTime:= kbmSalidasLin.FieldByName('fecha_albaran').AsDateTime;
    Open;
    AComision:= bRoundTo( FieldByName('comision').AsFloat / 100, -5);
    ADescuento:= bRoundTo( FieldByName('descuento').AsFloat / 100, -5);
    ADescuentoConIva:= bRoundTo( FieldByName('descuento_con_iva').AsFloat / 100, -5);
    Close;
  end;
end;

procedure TFFobCalibresData.PutCosteEnvase( const AEnvase, ASecciones: Boolean );
var
  rEnvase, rSecciones: real;
begin
  with kbmSalidasLin do
  begin
    First;
    PutProductoBase;
    while not eof do
    begin
      GetCosteEnvase( rEnvase, rSecciones );
      Edit;
      if AEnvase then
        FieldByName('coste_envase').AsFloat:= bRoundTo( FieldByName('kilos').AsFloat * rEnvase, -2 );
      if ASecciones then
        FieldByName('coste_secciones').AsFloat:= bRoundTo( FieldByName('kilos').AsFloat * rSecciones, -2 );
      Post;
      Next;
    end;
  end;
end;

procedure TFFobCalibresData.PutProductoBase;
begin
  with QProductoBase do
  begin
    ParamByName('producto').AsString:= kbmSalidasLin.FieldByName('producto').AsString;
    Open;
    iProductoBase:= FieldByName('producto_base_p').AsInteger;
    Close;
  end;
end;

procedure TFFobCalibresData.GetCosteEnvase( var AEnvase, ASecciones: real );
var
  iAnyo, iMes, iDia: Word;
begin
  with QCosteEnvase do
  begin
    ParamByName('empresa').AsString := kbmSalidasLin.FieldByName('empresa').AsString;
    ParamByName('centro').AsString := kbmSalidasLin.FieldByName('centro_salida').AsString;
    ParamByName('envase').AsString := kbmSalidasLin.FieldByName('envase').AsString;
    ParamByName('producto').AsString := kbmSalidasLin.FieldByName('producto').AsString;;
    DecodeDate( kbmSalidasLin.FieldByName('fecha_albaran').AsDateTime, iAnyo, iMes, iDia );
    ParamByName('anyo').AsInteger := iAnyo;
    ParamByName('mes').AsInteger := iMes;
    try
      Open;
      AEnvase := FieldByName('material_ec').AsFloat + FieldByName('personal_ec').AsFloat;
      ASecciones := FieldByName('general_ec').AsFloat;
    finally
      Close;
    end;
  end;
end;

procedure TFFobCalibresData.RellenarTablaPorCalibres;
var
  rNeto, rCoste, rFob: Real;
begin
  with kbmSalidasLin do
  begin
    First;
    kbmPorCalibres.Open;
    while not eof do
    begin
      rNeto:= FieldByName('neto').AsFloat - (FieldByName('comision').AsFloat + FieldByName('descuento').AsFloat);
      rCoste:= FieldByName('gastos').AsFloat + FieldByName('coste_envase').AsFloat + FieldByName('coste_secciones').AsFloat;
      rFOB:= rNeto - rCoste;
      if kbmPorCalibres.Locate('calibre',
         VarArrayOf([kbmSalidasLin.FieldByName('calibre').AsString]), []) then
      begin
        kbmPorCalibres.Edit;
        kbmPorCalibres.FieldByName('kilos').AsFloat:=
          kbmPorCalibres.FieldByName('kilos').AsFloat +
          FieldByName('kilos').AsFloat;
        kbmPorCalibres.FieldByName('neto').AsFloat:=
          kbmPorCalibres.FieldByName('neto').AsFloat + rNeto;
        kbmPorCalibres.FieldByName('coste').AsFloat:=
          kbmPorCalibres.FieldByName('coste').AsFloat + rCoste;
        kbmPorCalibres.FieldByName('fob').AsFloat:=
          kbmPorCalibres.FieldByName('fob').AsFloat + rFob;
        kbmPorCalibres.Post;
      end
      else
      begin
        kbmPorCalibres.Insert;
        kbmPorCalibres.FieldByName('calibre').AsString:=
          FieldByName('calibre').AsString;
        kbmPorCalibres.FieldByName('kilos').AsFloat:=
          FieldByName('kilos').AsFloat;
        kbmPorCalibres.FieldByName('neto').AsFloat:=  rNeto;
        kbmPorCalibres.FieldByName('coste').AsFloat:= rCoste;
        kbmPorCalibres.FieldByName('fob').AsFloat:= rFob;
        kbmPorCalibres.Post;
      end;
      next;
    end;
  end;
end;

end.
