unit StockFrutaPlantaDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLStockFrutaPlanta = class(TDataModule)
    QListadoStock: TQuery;
    TMemGastos: TkbmMemTable;
    QGastos: TQuery;
    QEntregas: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DesPreparaQuery;
    procedure PreparaQueryStockActual( const AProducto, AEntrega: string;
                                       const AProveedor, AVariedad, ACalibre, APais: string;
                                       const AFEchaIni, AFechaFin: String );
    procedure RellenarTablaDeGastos;
    procedure ObtenerGastosEx( const AEntrega, AProducto, AVariedad, ACalibre: string;
                               var AKilosCal, AKilosTot, AImporteCal, AImporteGas: real );
    procedure PreparaQueryPaletsVolcados( const AProducto: string );

  public
    { Public declarations }
    function  DatosQueryStock( const AEmpresa, ACentro, AProducto, AEntrega: string;
                               const AProveedor, AVariedad, ACalibre, APais: string;
                               const AFEchaIni, AFechaFin: String;
                               const AValorar: Boolean ): boolean;
    function  DatosQueryVolcados( const AEmpresa, ACentro, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime ): boolean;
    procedure ObtenerGastos( const AEntrega, AProducto, AVariedad, ACalibre: string;
                             var AKilosCal, AKilosTot, AImporteCal, AImporteGas: real );
  end;

implementation

{$R *.dfm}

uses variants, UDMConfig;

procedure TDLStockFrutaPlanta.DataModuleCreate(Sender: TObject);
begin
  //Kilos para repercutir los gastos y importe entrega por si factura de proveedor no grabado
  with QEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        sum( case when ( calibre_el = :calibre and variedad_el = :variedad ) ');
    SQL.Add('                       then kilos_el else 0 end) kilosCal, ');
    SQL.Add('        sum( kilos_el ) kilosTot, ');
    SQL.Add('        sum( case when ( calibre_el = :calibre and variedad_el = :variedad ) ');
    SQL.Add('                       then precio_kg_el * kilos_el else 0 end) importeCal, ');
    SQL.Add('        sum( precio_kg_el * kilos_el ) importeTot ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el = :entrega ');
    SQL.Add(' and producto_el = :producto ');
    Prepare;
  end;

(*****************)
(*PARCHE 20080327*)
(*Como sabemos que gasto es la factura del proveedor, que equivale al sumatorio del
  importe grabado en las lineas en bondelicious el "001" *)
(*****************)
  with QGastos do
  begin
    SQL.Clear;
    SQL.Add(' select sum( importe_ge ) importe  ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :entrega ');
    SQL.Add(' and ( nvl(producto_ge,'''') = '''' or producto_ge = :producto ) ');
    SQL.Add(' and tipo_ge not in (''001'',''005'',''021'',''022'') ');
    //SQL.Add(' group by tipo_ge ');
    Prepare;
  end;

  TMemGastos.FieldDefs.Clear;
  TMemGastos.FieldDefs.Add('entrega', ftString, 12, False);
  TMemGastos.FieldDefs.Add('producto', ftString, 3, False);
  TMemGastos.FieldDefs.Add('variedad', ftString, 3, False);
  TMemGastos.FieldDefs.Add('calibre', ftString, 6, False);

  TMemGastos.FieldDefs.Add('kilosCal', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('kilosTot', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('importeCal', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('importeGas', ftFloat, 0, False);

  TMemGastos.IndexFieldNames:= 'entrega;producto;calibre';
  TMemGastos.CreateTable;
  TMemGastos.Open;
end;

procedure TDLStockFrutaPlanta.DesPreparaQuery;
begin
  QListadoStock.Close;
  if QListadoStock.Prepared then
    QListadoStock.UnPrepare;
end;

procedure TDLStockFrutaPlanta.PreparaQueryStockActual( const AProducto, AEntrega: string;
                                                       const AProveedor, AVariedad, ACalibre, APais: string;
                                                       const AFEchaIni, AFechaFin: String );
var
  dIni, dFin: TDateTime;
begin
  DesPreparaQuery;
  with QListadoStock do
  begin
    SQL.Clear;
    SQL.Add(' SELECT ');
    SQL.Add('        rf_palet_pb.entrega, ');
    SQL.Add('        (select fecha_llegada_ec from frf_entregas_c where codigo_ec = entrega ) fecha, ');
    SQL.Add('        (select nombre_p from frf_proveedores where frf_proveedores.empresa_p = :empresa AND frf_proveedores.proveedor_p = rf_palet_pb.proveedor  ) nombre_p, ');
    SQL.Add('        (select descripcion_p from frf_productos where frf_productos.empresa_p = :empresa AND frf_productos.producto_p = rf_palet_pb.producto ) descripcion_p, ');
    SQL.Add('        frf_productos_proveedor.descripcion_breve_pp, ');
    SQL.Add('        rf_palet_pb.variedad, ');
    SQL.Add('        rf_palet_pb.producto, ');
    SQL.Add('        rf_palet_pb.categoria, ');
    SQL.Add('        rf_palet_pb.calibre, ');
    SQL.Add('        frf_productos_proveedor.pais_origen_pp pais, ');
    SQL.Add('        Count(*) palets, Sum(rf_palet_pb.peso) peso, Sum(rf_palet_pb.cajas) cajas ');

    SQL.Add(' FROM   rf_palet_pb, ');
    SQL.Add('        frf_productos_proveedor ');


    SQL.Add(' WHERE rf_palet_pb.empresa = :empresa ');
    SQL.Add(' AND rf_palet_pb.centro = :centro ');
    SQL.Add(' AND rf_palet_pb.status= ''S'' ');
    if AProducto <> '' then
      SQL.Add('   AND rf_palet_pb.producto = :producto ');
    if AEntrega <> '' then
      SQL.Add('   AND rf_palet_pb.entrega = :entrega ');

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

    SQL.Add(' AND frf_productos_proveedor.empresa_pp = :empresa ');
    SQL.Add(' AND frf_productos_proveedor.producto_pp = rf_palet_pb.producto ');
    SQL.Add(' AND frf_productos_proveedor.proveedor_pp = rf_palet_pb.proveedor ');
    SQL.Add(' AND frf_productos_proveedor.variedad_pp = rf_palet_pb.variedad ');


    SQL.Add(' GROUP BY 1,2,3,4,5,6,7,8,9,10 ');

    SQL.Add(' ORDER BY descripcion_p, descripcion_breve_pp, calibre, fecha, entrega ');

    Prepare;
  end;
end;

procedure TDLStockFrutaPlanta.PreparaQueryPaletsVolcados( const AProducto: string );
begin
  DesPreparaQuery;
  with QListadoStock do
  begin
    SQL.Clear;
    SQL.Add(' SELECT rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_productos.descripcion_p, ');
    SQL.Add('        frf_productos_proveedor.descripcion_breve_pp, rf_palet_pb.categoria, rf_palet_pb.calibre, ');
    //SQL.Add('        Count(*) palets, Sum(rf_palet_pb.peso_bruto) peso, Sum(rf_palet_pb.cajas) cajas');
    SQL.Add('        Count(*) palets, Sum(rf_palet_pb.peso) peso, Sum(rf_palet_pb.cajas) cajas');
    SQL.Add(' FROM   frf_productos, frf_productos_proveedor, frf_proveedores, rf_palet_pb ');
    SQL.Add(' WHERE rf_palet_pb.empresa = :empresa ');
    SQL.Add('   AND rf_palet_pb.centro = :centro ');
    if AProducto <> '' then
      SQL.Add('   AND rf_palet_pb.producto = :producto ');
    SQL.Add('   AND rf_palet_pb.fecha_status between :fechaIni and :fechaFin ');
    SQL.Add('   AND frf_proveedores.empresa_p = :empresa ');
    SQL.Add('   AND frf_proveedores.proveedor_p = rf_palet_pb.proveedor  ');
    SQL.Add('   AND frf_productos_proveedor.empresa_pp = :empresa ');
    SQL.Add('   AND frf_productos_proveedor.producto_pp = rf_palet_pb.producto');
    SQL.Add('   AND frf_productos_proveedor.proveedor_pp = rf_palet_pb.proveedor ');
    SQL.Add('   AND frf_productos_proveedor.variedad_pp = rf_palet_pb.variedad  ');
    SQL.Add('   AND frf_productos.empresa_p = :empresa  ');
    SQL.Add('   AND frf_productos.producto_p = rf_palet_pb.producto ');
    SQL.Add('   AND rf_palet_pb.status=''V'' ');
    SQL.Add(' GROUP BY rf_palet_pb.entrega, frf_proveedores.nombre_p, frf_productos.descripcion_p,  ');
    SQL.Add('          frf_productos_proveedor.descripcion_breve_pp, rf_palet_pb.categoria, rf_palet_pb.calibre ');
    SQL.Add('  ORDER BY frf_productos.descripcion_p, frf_productos_proveedor.descripcion_breve_pp, ');
    SQL.Add('           rf_palet_pb.calibre, rf_palet_pb.entrega ');
    Prepare;
  end;
end;

procedure TDLStockFrutaPlanta.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuery;
  TMemGastos.Close;
end;

function TDLStockFrutaPlanta.DatosQueryStock( const AEmpresa, ACentro, AProducto, AEntrega: string;
                                              const AProveedor, AVariedad, ACalibre, APais: string;
                                              const AFEchaIni, AFechaFin: String;
                                              const AValorar: Boolean ): boolean;
var
  dIni, dFin: TDateTime;
begin
  PreparaQueryStockActual( AProducto, AEntrega, AProveedor, AVariedad, ACalibre, APais, AFEchaIni, AFechaFin );
  with QListadoStock do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AEntrega <> '' then
      ParamByName('entrega').AsString:= AEntrega;

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

    if AValorar then
      RellenarTablaDeGastos;

    result:= not IsEmpty;
  end;
end;

procedure TDLStockFrutaPlanta.RellenarTablaDeGastos;
var
  rKilosCal, rKilosTot, rImporteCal, rImporteGas: real;
begin
  with QListadoStock do
  begin
    First;
    while not EOF do
    begin
      ObtenerGastos( FieldByname('entrega').AsString, FieldByname('producto').AsString, FieldByname('variedad').AsString,
        FieldByname('calibre').AsString, rKilosCal, rKilosTot, rImporteCal, rImporteGas );
      Next;
    end;
    First;
  end;
end;

procedure TDLStockFrutaPlanta.ObtenerGastos( const AEntrega, AProducto, AVariedad, ACalibre: string;
                                             var AKilosCal, AKilosTot, AImporteCal, AImporteGas: real );
begin
  if TMemGastos.Locate('entrega;producto;variedad;calibre', VarArrayOf([AEntrega, AProducto, AVariedad, ACalibre]), []) then
  begin
    AKilosCal:= TMemGastos.FieldByName('kilosCal').AsFloat;
    AKilosTot:= TMemGastos.FieldByName('kilosTot').AsFloat;
    AImporteCal:= TMemGastos.FieldByName('importeCal').AsFloat;
    AImporteGas:= TMemGastos.FieldByName('importeGas').AsFloat;
  end
  else
  begin
    ObtenerGastosEx( AEntrega, AProducto, AVariedad, ACalibre, AKilosCal, AKilosTot, AImporteCal, AImporteGas );
    with TMemGastos do
    begin
      Insert;
      TMemGastos.FieldByName('entrega').AsString:= AEntrega;
      TMemGastos.FieldByName('producto').AsString:= AProducto;
      TMemGastos.FieldByName('variedad').AsString:= AVariedad;
      TMemGastos.FieldByName('calibre').AsString:= ACalibre;
      TMemGastos.FieldByName('kilosCal').AsFloat:= AKilosCal;
      TMemGastos.FieldByName('kilosTot').AsFloat:= AKilosTot;
      TMemGastos.FieldByName('importeCal').AsFloat:= AImporteCal;
      TMemGastos.FieldByName('importeGas').AsFloat:= AImporteGas;
      Post;
    end;
  end;
end;

procedure TDLStockFrutaPlanta.ObtenerGastosEx( const AEntrega, AProducto, AVariedad, ACalibre: string;
                                               var AKilosCal, AKilosTot, AImporteCal, AImporteGas: real );
begin
  with QGastos do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    ParamByName('producto').AsString:= AProducto;
    Open;
    AImporteGas:= FieldByname('importe').AsFloat;
    Close;
  end;
  with QEntregas do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('variedad').AsString:= AVariedad;
    ParamByName('calibre').AsString:= ACalibre;
    Open;
    AKilosCal:= FieldByname('kilosCal').AsFloat;
    AKilosTot:= FieldByname('kilosTot').AsFloat;
    AImporteCal:= FieldByname('importeCal').AsFloat;
    Close;
  end;
end;

function TDLStockFrutaPlanta.DatosQueryVolcados( const AEmpresa, ACentro, AProducto: string;
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
