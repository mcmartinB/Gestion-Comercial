unit StockFrutaPlantaMasetDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLStockFrutaPlantaMaset = class(TDataModule)
    QListadoStock: TQuery;
    QEntregas: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure DesPreparaQuery;
    procedure PreparaQueryStockActual( const APlanta, AProducto, AEntrega: string;
                                       const AAnyoSemana: Integer; const AVerVariedad: boolean;
                                       const AProveedor, AVariedad, ACalibre, APais: string;
                                       const AFEchaIni, AFechaFin: String;
                                       const AIgnorarPlatano: Boolean;
                                       const APlaceros: Integer );
    procedure PreparaQueryPaletsVolcados( const AProducto: string );

  public
    { Public declarations }
    function  DatosQueryStock( const AEmpresa, ACentro, AProducto, AEntrega: string;
                               const AAnyoSemana: Integer;
                               const AProveedor, AVariedad, ACalibre, APais: string;
                               const AFEchaIni, AFechaFin: String;
                               const AVerVariedad, AIgnorarPlatano: Boolean; const APlaceros: Integer ): boolean;
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

procedure TDLStockFrutaPlantaMaset.PreparaQueryStockActual( const APlanta, AProducto, AEntrega: string;
                                                            const AAnyoSemana: Integer;
                                                            const AVerVariedad: boolean;
                                                            const AProveedor, AVariedad, ACalibre, APais: string;
                                                            const AFEchaIni, AFechaFin: String;
                                                            const AIgnorarPlatano: Boolean;
                                                            const APlaceros: Integer );
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
    SQL.Add('         (select anyo_semana_ec from frf_entregas_c where codigo_ec = entrega ) albaran, ');
    SQL.Add('         (select adjudicacion_ec from frf_entregas_c where codigo_ec = entrega ) factura_conduce, ');
    SQL.Add('         (select nombre_p from frf_entregas_c,  frf_proveedores ');
    SQL.Add('          where codigo_ec = entrega ');
    SQL.Add('            and proveedor_p = proveedor_ec ) proveedor_p, ');

    SQL.Add('         proveedor, ( case when proveedor_almacen is not null then proveedor_almacen ');
    SQL.Add('                            else (select max(almacen_el) from frf_entregas_l where codigo_el = entrega) end) proveedor_almacen, ');
    SQL.Add('         (select nombre_pa from frf_proveedores_almacen ');
    SQL.Add('          where proveedor_pa = proveedor ');
    SQL.Add('            and almacen_pa = case when proveedor_almacen is not null then proveedor_almacen ');
    SQL.Add('                                  else (select max(almacen_el) from frf_entregas_l where codigo_el = entrega) end ');
    SQL.Add('         ) nombre_p,  ');

    SQL.Add('         (select vehiculo_ec from frf_entregas_c where codigo_ec = entrega ) matricula, ');
    SQL.Add('         (select descripcion_p from frf_productos where frf_productos.producto_p = rf_palet_pb.producto ) descripcion_p, ');
    SQL.Add('         frf_productos_proveedor.variedad_pp, ');

    SQL.Add('        case when frf_productos_proveedor.descripcion_breve_pp is not null ');
    SQL.Add('             then frf_productos_proveedor.descripcion_breve_pp ');
    SQL.Add('             else rf_palet_pb.variedad || '' - '' || frf_productos_proveedor.descripcion_pp ');
    SQL.Add('        end descripcion_breve_pp, ');

    SQL.Add('         frf_productos_proveedor.marca_pp, ');
    SQL.Add('         rf_palet_pb.producto, ');
    SQL.Add('         rf_palet_pb.categoria, ');
    SQL.Add('         rf_palet_pb.calibre, ');
    SQL.Add('         frf_productos_proveedor.pais_origen_pp pais, ');

    SQL.Add('         Count( distinct sscc ) palets, ');
    SQL.Add('        Sum( case when rf_palet_pb.peso <> 0  ');
    SQL.Add('                  then rf_palet_pb.peso ');
    SQL.Add('                  else rf_palet_pb.cajas * ( select case when cajas_el <> 0 then kilos_el / cajas_el else 0 end from frf_entregas_l ');
    SQL.Add('                                             where entrega = codigo_El and  proveedor = proveedor_el and variedad = variedad_el and producto = producto_el ) ');
    SQL.Add('             end ) peso, ');
    SQL.Add('        Sum(rf_palet_pb.peso) peso_palet, ');
    SQL.Add('        Sum(rf_palet_pb.cajas) cajas, ');
    SQL.Add('         round( sum( rf_palet_pb.cajas * ( select nvl( round( sum(kilos_el)/sum(cajas_el), 5 ), 0 ) peso_caja ');
    SQL.Add('                                    from frf_entregas_l ');
    SQL.Add('                                    where codigo_el = rf_palet_pb.entrega ');
    SQL.Add('                                      and variedad_el = rf_palet_pb.variedad ');
    SQL.Add('                                      and nvl(cajas_el,0) <> 0 ) ), 2) peso_teorico ');


    SQL.Add('  FROM   rf_palet_pb LEFT JOIN frf_productos_proveedor ON  ( frf_productos_proveedor.producto_pp = rf_palet_pb.producto ');
    SQL.Add('                                                           AND frf_productos_proveedor.proveedor_pp = rf_palet_pb.proveedor ');
    SQL.Add('                                                           AND frf_productos_proveedor.variedad_pp = rf_palet_pb.variedad ) ');

    SQL.Add('  WHERE rf_palet_pb.empresa = :empresa ');
    SQL.Add('  AND rf_palet_pb.centro = :centro ');
    SQL.Add('  AND ( rf_palet_pb.status= ''S'' ) ');

    if AProducto <> '' then
      SQL.Add('   AND rf_palet_pb.producto = :producto ');
    if AIgnorarPlatano then
      SQL.Add('   AND rf_palet_pb.producto <> ''PLA'' ');
    if AEntrega <> '' then
      SQL.Add('   AND rf_palet_pb.entrega = :entrega ');
    if AAnyoSemana <> -1 then
    begin
      SQL.Add('   AND (select anyo_semana_ec ');
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

    //Ignoramos verde, placeros y otras calidades
    //Para chanita el campo calidad es de texto, en el resto es un entero
    if APlanta = 'F17' then
    begin
      case APlaceros of
        0: //Ignorar placeros
           SQL.Add('   AND nvl(Trim(calidad),'''') = '''' ');
        2://Solo placeros
          SQL.Add('   AND nvl(Trim(calidad),'''') <> '''' ');
      end;
    end;

    SQL.Add(' GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19 ');

    if AProducto = 'PLA' then
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
    SQL.Add('         (select distinct(nombre_pa) from frf_entregas_l,  frf_proveedores_almacen ');
    SQL.Add('          where codigo_el = entrega ');
    SQL.Add('            and proveedor_pa = proveedor_el ');
    SQL.Add('            and almacen_pa = almacen_el ) nombre_p, ');
    SQL.Add('         (select vehiculo_ec from frf_entregas_c where codigo_ec = entrega ) matricula, ');
    SQL.Add('         (select descripcion_p from frf_productos where frf_productos.producto_p = rf_palet_pb.producto ) descripcion_p, ');

    SQL.Add('        case when frf_productos_proveedor.descripcion_breve_pp is not null ');
    SQL.Add('             then frf_productos_proveedor.descripcion_breve_pp ');
    SQL.Add('             else rf_palet_pb.variedad || '' - '' || frf_productos_proveedor.descripcion_pp ');
    SQL.Add('        end descripcion_breve_pp, ');

    SQL.Add('         rf_palet_pb.producto, ');
    SQL.Add('         rf_palet_pb.categoria, ');
    SQL.Add('         rf_palet_pb.calibre, ');
    SQL.Add('         frf_productos_proveedor.pais_origen_pp pais, ');

    SQL.Add('         Count( distinct sscc ) palets, ');
    SQL.Add('        Sum( case when rf_palet_pb.peso <> 0  ');
    SQL.Add('                  then rf_palet_pb.peso ');
    SQL.Add('                  else rf_palet_pb.cajas * ( select case when cajas_el <> 0 then kilos_el / cajas_el else 0 end from frf_entregas_l ');
    SQL.Add('                                             where entrega = codigo_El and  proveedor = proveedor_el and variedad = variedad_el and producto = producto_el ) ');
    SQL.Add('             end ) peso, ');
    SQL.Add('        Sum( rf_palet_pb.cajas * ( select case when cajas_el <> 0 then kilos_el / cajas_el else 0 end from frf_entregas_l ');
    SQL.Add('                                             where entrega = codigo_El and  proveedor = proveedor_el and variedad = variedad_el and producto = producto_el ) ');
    SQL.Add('            ) peso_teorico, ');
    SQL.Add('    Sum(rf_palet_pb.peso) peso_palet, ');

    SQL.Add('    Sum(rf_palet_pb.cajas) cajas ');

    SQL.Add(' FROM   frf_productos_proveedor, rf_palet_pb ');
    SQL.Add(' WHERE rf_palet_pb.empresa = :empresa ');
    SQL.Add('   AND rf_palet_pb.centro = :centro ');
    if AProducto <> '' then
      SQL.Add('   AND rf_palet_pb.producto = :producto ');
    SQL.Add('   AND rf_palet_pb.fecha_status between :fechaIni and :fechaFin ');
    SQL.Add('   AND ( rf_palet_pb.status=''V'' OR rf_palet_pb.status= ''R'' )');

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

function TDLStockFrutaPlantaMaset.DatosQueryStock( const AEmpresa, ACentro, AProducto, AEntrega: string;
                                                   const AAnyoSemana: Integer;
                                                   const AProveedor, AVariedad, ACalibre, APais: string;
                                                   const AFEchaIni, AFechaFin: String;
                                                   const AVerVariedad, AIgnorarPlatano: Boolean; const APlaceros: Integer ): boolean;
var
  dIni, dFin: TDateTime;
begin
  PreparaQueryStockActual( AEmpresa, AProducto, AEntrega, AAnyoSemana, AVerVariedad, AProveedor, AVariedad,
                           ACalibre, APais, AFEchaIni, AFechaFin, AIgnorarPlatano, APlaceros );
  with QListadoStock do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AEntrega <> '' then
      ParamByName('entrega').AsString:= AEntrega;
    if AAnyoSemana <> -1 then
      ParamByName('semana').AsInteger:= AAnyoSemana;

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
