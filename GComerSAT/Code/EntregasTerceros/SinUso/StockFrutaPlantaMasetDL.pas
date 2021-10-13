unit StockFrutaPlantaMasetDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLStockFrutaPlantaMaset = class(TDataModule)
    QListadoStock: TQuery;
    QGastos: TQuery;
    QEntregas: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure DesPreparaQuery;
    procedure PreparaQueryStockActual( const AProducto, ASemana, AEntrega: string; const AVerVariedad: boolean;
                                       const AProveedor, AVariedad, ACalibre, APais: string;
                                       const AFEchaIni, AFechaFin: String;
                                       const AIgnorarPlatano: Boolean );
    procedure PreparaQueryPaletsVolcados( const AProducto: string );

  public
    { Public declarations }
    function  DatosQueryStock( const AEmpresa, ACentro, AProducto, ASemana, AEntrega: string;
                               const AProveedor, AVariedad, ACalibre, APais: string;
                               const AFEchaIni, AFechaFin: String;
                               const AVerVariedad, AIgnorarPlatano: Boolean ): boolean;
    function  DatosQueryVolcados( const AEmpresa, ACentro, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime ): boolean;
  end;

implementation

{$R *.dfm}

uses variants, UDMConfig;

procedure TDLStockFrutaPlantaMaset.DesPreparaQuery;
begin
  QListadoStock.Close;
  if QListadoStock.Prepared then
    QListadoStock.UnPrepare;
end;

procedure TDLStockFrutaPlantaMaset.PreparaQueryStockActual( const AProducto, ASemana, AEntrega: string;
                                                            const AVerVariedad: boolean;
                                                            const AProveedor, AVariedad, ACalibre, APais: string;
                                                            const AFEchaIni, AFechaFin: String;
                                                            const AIgnorarPlatano: Boolean );
var
  dIni, dFin: TDateTime;
begin
  DesPreparaQuery;
  with QListadoStock do
  begin

    SQL.Clear;
    SQL.Add(' SELECT ');
    SQL.Add('         rf_palet_pb.status, rf_palet_pb.entrega, ');
    SQL.Add('         (select fecha_llegada_ec from frf_entregas_c where codigo_ec = entrega ) fecha_llegada, ');
    SQL.Add('         (select fecha_carga_ec from frf_entregas_c where codigo_ec = entrega ) fecha_carga, ');
    SQL.Add('         (select albaran_ec[1,2] from frf_entregas_c where codigo_ec = entrega ) albaran, ');
    SQL.Add('         (select adjudicacion_ec from frf_entregas_c where codigo_ec = entrega ) factura_conduce, ');
    SQL.Add('         (select nombre_p from frf_entregas_c,  frf_proveedores ');
    SQL.Add('          where codigo_ec = entrega ');
    SQL.Add('            and empresa_p = :empresa ');
    SQL.Add('            and proveedor_p = proveedor_ec ) proveedor_p, ');
    SQL.Add('         (select nombre_pa from frf_entregas_c,  frf_proveedores_almacen ');
    SQL.Add('          where codigo_ec = entrega ');
    SQL.Add('            and empresa_pa = :empresa ');
    SQL.Add('            and proveedor_pa = proveedor_ec ');
    SQL.Add('            and almacen_pa = almacen_ec ) nombre_p, ');
    SQL.Add('         (select vehiculo_ec from frf_entregas_c where codigo_ec = entrega ) matricula, ');
    SQL.Add('         (select descripcion_p from frf_productos where frf_productos.empresa_p = :empresa AND frf_productos.producto_p = rf_palet_pb.producto ) descripcion_p, ');
    SQL.Add('         frf_productos_proveedor.variedad_pp, ');
    SQL.Add('         frf_productos_proveedor.descripcion_breve_pp, ');
    SQL.Add('         frf_productos_proveedor.marca_pp, ');
    SQL.Add('         rf_palet_pb.producto, ');
    SQL.Add('         rf_palet_pb.categoria, ');
    SQL.Add('         rf_palet_pb.calibre, ');
    SQL.Add('         frf_productos_proveedor.pais_origen_pp pais, ');
    SQL.Add('         Count( distinct sscc ) palets, Sum(rf_palet_pb.peso) peso, Sum(rf_palet_pb.cajas) cajas, ');
    SQL.Add('         round( sum( rf_palet_pb.cajas * ( select nvl( round( sum(kilos_el)/sum(cajas_el), 5 ), 0 ) peso_caja ');
    SQL.Add('                                    from frf_entregas_l ');
    SQL.Add('                                    where codigo_el = rf_palet_pb.entrega ');
    SQL.Add('                                      and variedad_el = rf_palet_pb.variedad ');
    SQL.Add('                                      and nvl(cajas_el,0) <> 0 ) ), 2) peso_teorico ');


    SQL.Add('  FROM   rf_palet_pb, ');
    SQL.Add('         frf_productos_proveedor ');

    SQL.Add('  WHERE rf_palet_pb.empresa = :empresa ');
    SQL.Add('  AND rf_palet_pb.centro = :centro ');
    SQL.Add('  AND ( rf_palet_pb.status= ''S'' ) ');

    if AProducto <> '' then
      SQL.Add('   AND rf_palet_pb.producto = :producto ');
    if AIgnorarPlatano then
      SQL.Add('   AND rf_palet_pb.producto <> ''P'' ');
    if AEntrega <> '' then
      SQL.Add('   AND rf_palet_pb.entrega = :entrega ');
    if ASemana <> '' then
    begin
      SQL.Add('   AND (select albaran_ec[1,2] ');
      SQL.Add('        from frf_entregas_c ');
      SQL.Add('        where codigo_Ec = entrega) = :semana ');
    end;

    if AProveedor <> '' then
      SQL.Add('   AND rf_palet_pb.proveedor = :proveedor ');
    if AVariedad <> '' then
      SQL.Add('   AND rf_palet_pb.variedad = :variedad ');
    if ACalibre <> '' then
      SQL.Add('   AND rf_palet_pb.calibre = :calibre ');
    if APais <> '' then
      SQL.Add('   AND frf_productos_proveedor.pais_origen_pp = :pais ');

    if tryStrToDate( AFEchaIni, dIni ) then
      SQL.Add('   AND Date( rf_palet_pb.fecha_alta ) >= :fechaini ');
    if tryStrToDate( AFEchaFin, dFin ) then
      SQL.Add('   AND Date( rf_palet_pb.fecha_alta ) <= :fechafin ');



    SQL.Add('  AND frf_productos_proveedor.empresa_pp = :empresa ');
    SQL.Add('  AND frf_productos_proveedor.producto_pp = rf_palet_pb.producto ');
    SQL.Add('  AND frf_productos_proveedor.proveedor_pp = rf_palet_pb.proveedor ');
    SQL.Add('  AND frf_productos_proveedor.variedad_pp = rf_palet_pb.variedad ');

    SQL.Add(' GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17 ');

    if AProducto = 'P' then
    begin
      if AVerVariedad then
        SQL.Add(' ORDER BY descripcion_p, albaran, descripcion_breve_pp, calibre, fecha_llegada, entrega, status ')
      else
        SQL.Add(' ORDER BY descripcion_p, albaran, fecha_llegada, entrega, status ');
    end
    else
    begin
      if AVerVariedad then
        SQL.Add(' ORDER BY descripcion_p, descripcion_breve_pp, calibre, fecha_llegada, entrega, status ')
      else
        SQL.Add(' ORDER BY descripcion_p, fecha_llegada, entrega, status ');
    end;

    Prepare;
  end;
end;

procedure TDLStockFrutaPlantaMaset.PreparaQueryPaletsVolcados( const AProducto: string );
begin
  DesPreparaQuery;
  with QListadoStock do
  begin
    SQL.Clear;
    SQL.Add(' SELECT ');
    SQL.Add('         rf_palet_pb.status, rf_palet_pb.entrega, ');
    SQL.Add('         (select fecha_llegada_ec from frf_entregas_c where codigo_ec = entrega ) fecha_llegada, ');
    SQL.Add('         (select fecha_carga_ec from frf_entregas_c where codigo_ec = entrega ) fecha_carga, ');
    SQL.Add('         (select albaran_ec from frf_entregas_c where codigo_ec = entrega ) albaran, ');
    SQL.Add('         (select adjudicacion_ec from frf_entregas_c where codigo_ec = entrega ) factura_conduce, ');
    SQL.Add('         (select nombre_pa from frf_entregas_c,  frf_proveedores_almacen ');
    SQL.Add('          where codigo_ec = entrega ');
    SQL.Add('            and empresa_pa = :empresa ');
    SQL.Add('            and proveedor_pa = proveedor_ec ');
    SQL.Add('            and almacen_pa = almacen_ec ) nombre_p, ');
    SQL.Add('         (select vehiculo_ec from frf_entregas_c where codigo_ec = entrega ) matricula, ');
    SQL.Add('         (select descripcion_p from frf_productos where frf_productos.empresa_p = :empresa AND frf_productos.producto_p = rf_palet_pb.producto ) descripcion_p, ');
    SQL.Add('         frf_productos_proveedor.descripcion_breve_pp, ');
    SQL.Add('         rf_palet_pb.producto, ');
    SQL.Add('         rf_palet_pb.categoria, ');
    SQL.Add('         rf_palet_pb.calibre, ');
    SQL.Add('         frf_productos_proveedor.pais_origen_pp pais, ');
    SQL.Add('         Count( distinct sscc ) palets, Sum(rf_palet_pb.peso) peso, Sum(rf_palet_pb.cajas) cajas ');

    SQL.Add(' FROM   frf_productos_proveedor, rf_palet_pb ');
    SQL.Add(' WHERE rf_palet_pb.empresa = :empresa ');
    SQL.Add('   AND rf_palet_pb.centro = :centro ');
    if AProducto <> '' then
      SQL.Add('   AND rf_palet_pb.producto = :producto ');
    SQL.Add('   AND rf_palet_pb.fecha_status between :fechaIni and :fechaFin ');
    SQL.Add('   AND ( rf_palet_pb.status=''V'' OR rf_palet_pb.status= ''R'' )');

    SQL.Add('   AND frf_productos_proveedor.empresa_pp = :empresa ');
    SQL.Add('   AND frf_productos_proveedor.producto_pp = rf_palet_pb.producto');
    SQL.Add('   AND frf_productos_proveedor.proveedor_pp = rf_palet_pb.proveedor ');
    SQL.Add('   AND frf_productos_proveedor.variedad_pp = rf_palet_pb.variedad  ');


    SQL.Add(' GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13, 14 ');
    //SQL.Add(' GROUP BY rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_productos.descripcion_p,  ');
    //SQL.Add('          frf_productos_proveedor.descripcion_breve_pp, rf_palet_pb.categoria, rf_palet_pb.calibre ');
    SQL.Add('  ORDER BY descripcion_p, nombre_p, descripcion_breve_pp, calibre, fecha_llegada, entrega, status ');
    Prepare;
  end;
end;

procedure TDLStockFrutaPlantaMaset.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuery;
end;

function TDLStockFrutaPlantaMaset.DatosQueryStock( const AEmpresa, ACentro, AProducto, ASemana, AEntrega: string;
                                                   const AProveedor, AVariedad, ACalibre, APais: string;
                                                   const AFEchaIni, AFechaFin: String;
                                                   const AVerVariedad, AIgnorarPlatano: Boolean ): boolean;
var
  dIni, dFin: TDateTime;
begin
  PreparaQueryStockActual( AProducto, ASemana, AEntrega, AVerVariedad, AProveedor, AVariedad,
                           ACalibre, APais, AFEchaIni, AFechaFin, AIgnorarPlatano );
  with QListadoStock do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AEntrega <> '' then
      ParamByName('entrega').AsString:= AEntrega;
    if ASemana <> '' then
      ParamByName('semana').AsString:= ASemana;

    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AVariedad <> '' then
      ParamByName('variedad').AsString:= AVariedad;
    if ACalibre <> '' then
      ParamByName('calibre').AsString:= ACalibre;
    if APais <> '' then
      ParamByName('pais').AsString:= APais;

    if tryStrToDate( AFEchaIni, dIni ) then
      ParamByName('fechaini').AsDateTime:= dIni;
    if tryStrToDate( AFEchaFin, dFin ) then
      ParamByName('fechafin').AsDateTime:= dFin;

    Open;

    result:= not IsEmpty;
  end;
end;

function TDLStockFrutaPlantaMaset.DatosQueryVolcados( const AEmpresa, ACentro, AProducto: string;
                                                      const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  PreparaQueryPaletsVolcados( AProducto );
  with QListadoStock do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaIni').AsDateTime:= AFechaIni;
    ParamByName('fechaFin').AsDateTime:= AFechaFin + 1;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    Open;
    result:= not IsEmpty;
  end;
end;

end.
