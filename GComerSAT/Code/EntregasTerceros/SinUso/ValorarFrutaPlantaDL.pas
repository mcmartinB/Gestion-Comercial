unit ValorarFrutaPlantaDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLValorarFrutaPlanta = class(TDataModule)
    QListadoStock: TQuery;
    TMemGastos: TkbmMemTable;
    QGastos: TQuery;
    QEntregas: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DesPreparaQuery;
    procedure PreparaQueryStockActual( const AProducto: string );
    procedure RellenarTablaDeGastos;
    procedure ObtenerGastosEx( const AEntrega, AProducto, AVariedad, ACalibre: string;
                               var AKilosCal, AKilosTot, AImporteCal, AImporteGas: real );

  public
    { Public declarations }
    function DatosQueryStock( const AEmpresa, ACentro, AProducto, AEntregaDesde, AEntregaHasta: string ): boolean;
    procedure ObtenerGastos( const AEntrega, AProducto, AVariedad, ACalibre: string;
                             var AKilosCal, AKilosTot, AImporteCal, AImporteGas: real );
  end;

implementation

{$R *.dfm}

uses variants;

procedure TDLValorarFrutaPlanta.DataModuleCreate(Sender: TObject);
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
    (*19/06/2009 añadio el abono devolucion mas otros dos gastos*)
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

procedure TDLValorarFrutaPlanta.DesPreparaQuery;
begin
  QListadoStock.Close;
  if QListadoStock.Prepared then
    QListadoStock.UnPrepare;
end;

procedure TDLValorarFrutaPlanta.PreparaQueryStockActual( const AProducto: string );
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
    SQL.Add(' AND rf_palet_pb.entrega between :entregadesde and :entregahasta');
    if AProducto <> '' then
      SQL.Add('   AND rf_palet_pb.producto = :producto ');
    SQL.Add(' AND frf_productos_proveedor.empresa_pp = :empresa ');
    SQL.Add(' AND frf_productos_proveedor.producto_pp = rf_palet_pb.producto ');
    SQL.Add(' AND frf_productos_proveedor.proveedor_pp = rf_palet_pb.proveedor ');
    SQL.Add(' AND frf_productos_proveedor.variedad_pp = rf_palet_pb.variedad ');
    SQL.Add(' AND rf_palet_pb.status not in (''R'',''B'') ');


    SQL.Add(' GROUP BY 1,2,3,4,5,6,7,8,9,10 ');

    SQL.Add(' ORDER BY descripcion_p, descripcion_breve_pp, calibre, fecha, entrega ');

    Prepare;
  end;
end;


procedure TDLValorarFrutaPlanta.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuery;
  if QGastos.Prepared then
    QGastos.UnPrepare;
  if QEntregas.Prepared then
    QEntregas.UnPrepare;
  TMemGastos.Close;
end;

function TDLValorarFrutaPlanta.DatosQueryStock( const AEmpresa, ACentro, AProducto, AEntregaDesde, AEntregaHasta: string ): boolean;
begin
  PreparaQueryStockActual( AProducto );
  with QListadoStock do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('entregadesde').AsString:= AEntregaDesde;
    ParamByName('entregahasta').AsString:= AEntregaHasta;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    Open;

    RellenarTablaDeGastos;

    result:= not IsEmpty;
  end;
end;

procedure TDLValorarFrutaPlanta.RellenarTablaDeGastos;
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

procedure TDLValorarFrutaPlanta.ObtenerGastos( const AEntrega, AProducto, AVariedad, ACalibre: string;
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

procedure TDLValorarFrutaPlanta.ObtenerGastosEx( const AEntrega, AProducto, AVariedad, ACalibre: string;
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

end.
