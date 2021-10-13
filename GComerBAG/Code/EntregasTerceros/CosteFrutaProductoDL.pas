unit CosteFrutaProductoDL;

interface

uses
  SysUtils, StdCtrls, Forms, Classes, DB, DBTables, kbmMemTable;

type
  TDLCosteFrutaProducto = class(TDataModule)
    QListadoStock: TQuery;
    TMemGastos: TkbmMemTable;
    QGastos: TQuery;
    QEntregas: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DesPreparaQuery;
    procedure PreparaQueryFrutaProveedor( const ACentro, AProducto, AProveedor, AEntrega: string;
                                          const AAgruparVariedad, AAgruparCalibre, AAgruparProveedor: Boolean );
    procedure ObtenerGastosEx( const AEntrega, AProducto, AVariedad, ACalibre: string;
                               var AKilosCal, AImporteLinea, AKilosTot, AImporteTotal, AFacturas, AGastos: real );
    procedure RellenarTablaDeGastos( AMensaje: TLabel );

  public
    { Public declarations }
    function DatosQueryFrutaProveedor( const AEmpresa, ACentro, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta: string;
                                       const AAgruparVariedad, AAgruparCalibre, AAgruparProveedor: Boolean; AMensaje: TLabel ): boolean;
    function ObtenerGastos( const AEntrega, AProducto, AVariedad, ACalibre: string;
                             var AKilosCal, AKilosTot, AImporteLinea, AFacturas, AGastos: real ): boolean;
  end;

implementation

{$R *.dfm}

uses variants, UDMConfig;

procedure TDLCosteFrutaProducto.DataModuleCreate(Sender: TObject);
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
    SQL.Add('                       then precio_kg_el * kilos_el else 0 end) importeLinea, ');
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
    //SQL.Add(' select sum( case when tipo_ge in (''001'',''005'',''021'',''022'', ''110'') then importe_ge else 0 end ) facturas,  ');
    //SQL.Add('        sum( case when tipo_ge not in (''001'',''005'',''021'',''022'', ''110'') then importe_ge else 0 end ) gastos  ');
//    SQL.Add(' select sum( case when tipo_ge = ''010'' then importe_ge else 0 end ) facturas,  ');
//    SQL.Add('        sum( case when tipo_ge <> ''010'' then importe_ge else 0 end ) gastos  ');
    SQL.Add(' select sum( case when tipo_ge = ''054'' then importe_ge else 0 end ) facturas,  ');
    SQL.Add('        sum( case when tipo_ge <> ''054'' then importe_ge else 0 end ) gastos  ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :entrega ');
    Prepare;
  end;

  TMemGastos.FieldDefs.Clear;
  TMemGastos.FieldDefs.Add('entrega', ftString, 12, False);
  TMemGastos.FieldDefs.Add('producto', ftString, 3, False);
  TMemGastos.FieldDefs.Add('variedad', ftString, 3, False);
  TMemGastos.FieldDefs.Add('calibre', ftString, 6, False);

  TMemGastos.FieldDefs.Add('kilosCal', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('kilosTot', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('facturas', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('gastos', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('importeLinea', ftFloat, 0, False);
  TMemGastos.FieldDefs.Add('importeTotal', ftFloat, 0, False);

  TMemGastos.IndexFieldNames:= 'entrega;producto;calibre';
  TMemGastos.CreateTable;
  TMemGastos.Open;
end;

procedure TDLCosteFrutaProducto.DesPreparaQuery;
begin
  QListadoStock.Close;
  if QListadoStock.Prepared then
    QListadoStock.UnPrepare;
end;

procedure TDLCosteFrutaProducto.PreparaQueryFrutaProveedor( const ACentro, AProducto, AProveedor, AEntrega: string;
                                                            const AAgruparVariedad, AAgruparCalibre, AAgruparProveedor: Boolean );
begin
  DesPreparaQuery;
  with QListadoStock do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec entrega, ');
    SQL.Add('        fecha_llegada_ec fecha, ');
    SQL.Add('        ec.proveedor_ec proveedor, ');
    SQL.Add('        ( select p.nombre_p ');
    SQL.Add('          from frf_proveedores p ');
    SQL.Add('          where p.proveedor_p = ec.proveedor_ec ');
    SQL.Add('        ) nombre_p, ');
    SQL.Add('        ( select descripcion_p ');
    SQL.Add('          from frf_productos p ');
    SQL.Add('          where p.producto_p = el.producto_el ');
    SQL.Add('        ) descripcion_p, ');
    SQL.Add('        ( select case when nvl(trim(descripcion_breve_pp),'''') = ''''  then descripcion_pp else descripcion_breve_pp end descripcion_breve_pp ');
    SQL.Add('          from frf_productos_proveedor pp ');
    SQL.Add('          where pp.proveedor_pp = el.proveedor_el ');
    SQL.Add('          AND pp.producto_pp = el.producto_el ');
    SQL.Add('          AND pp.variedad_pp = el.variedad_el ');
    SQL.Add('        ) descripcion_breve_pp, ');
    SQL.Add('        el.variedad_el variedad, ');
    SQL.Add('        el.producto_el producto, ');
    SQL.Add('        el.categoria_el categoria, ');
    SQL.Add('        el.calibre_el calibre, ');
    SQL.Add('        ( select pais_origen_pp ');
    SQL.Add('          from frf_productos_proveedor pp ');
    SQL.Add('          where pp.proveedor_pp = el.proveedor_el ');
    SQL.Add('          AND pp.producto_pp = el.producto_el ');
    SQL.Add('          AND pp.variedad_pp = el.variedad_el ');
    SQL.Add('        ) pais, ');
    SQL.Add('        Sum(el.palets_el) palets, ');
    SQL.Add('        Sum(el.kilos_el) peso, ');
    SQL.Add('        Sum(el.cajas_el) cajas ');

    SQL.Add(' from frf_entregas_c ec, frf_entregas_l el ');

    SQL.Add(' where ec.empresa_ec = :empresa ');
    if AEntrega <> '' then
      SQL.Add('   AND ec.codigo_ec = :entrega ');
    if ACentro <> '' then
      SQL.Add('   AND ec.centro_llegada_ec = :centro ');
    if AProveedor <> '' then
      SQL.Add('   AND TRIM(ec.proveedor_ec) = :proveedor ');
    SQL.Add('   AND ec.fecha_llegada_ec between :fechaini and :fechafin ');
    SQL.Add('   AND el.codigo_el = ec.codigo_ec ');
    if AProducto <> '' then
      SQL.Add('   AND el.producto_el = :producto ');


    SQL.Add(' GROUP BY 1,2,3,4,5,6,7,8,9,10,11 ');

    (*
    if ( DMConfig.EsValenciaBonde or DMConfig.EsTenerifeBonde ) then
    begin
      SQL.Add(' ORDER BY descripcion_p, descripcion_breve_pp, calibre, fecha, entrega ');
    end
    else
    *)
    begin
      if  AAgruparVariedad then
      begin
        if AAgruparCalibre then
        begin
          SQL.Add(' ORDER BY descripcion_p, descripcion_breve_pp, calibre, fecha, entrega ');
        end
        else
        begin
          SQL.Add(' ORDER BY descripcion_p, descripcion_breve_pp, fecha, entrega, calibre ');
        end;
      end
      else
      begin
        if AAgruparProveedor then
          SQL.Add(' ORDER BY descripcion_p, proveedor, fecha, entrega, descripcion_breve_pp, calibre ')
        else
          SQL.Add(' ORDER BY descripcion_p, fecha, entrega, descripcion_breve_pp, calibre ');
      end;
    end;

    Prepare;
  end;
end;


procedure TDLCosteFrutaProducto.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuery;
  if QGastos.Prepared then
    QGastos.UnPrepare;
  if QEntregas.Prepared then
    QEntregas.UnPrepare;
  TMemGastos.Close;
end;

function TDLCosteFrutaProducto.DatosQueryFrutaProveedor( const AEmpresa, ACentro, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta: string;
                                                         const AAgruparVariedad, AAgruparCalibre, AAgruparProveedor: Boolean; AMensaje: TLabel ): boolean;
begin
  PreparaQueryFrutaProveedor( ACentro, AProducto, AProveedor, AEntrega, AAgruparVariedad, AAgruparCalibre, AAgruparProveedor );
  with QListadoStock do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('fechaini').AsString:= AFechaDesde;
    ParamByName('fechafin').AsString:= AFechaHasta;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AEntrega <> '' then
      ParamByName('entrega').AsString:= AEntrega;
    Open;

    RellenarTablaDeGastos( AMensaje );

    result:= not IsEmpty;
  end;
end;

procedure TDLCosteFrutaProducto.RellenarTablaDeGastos( AMensaje: TLabel );
var
  rKilosCal, rKilosTot, rImporteLinea, rGastos, rFacturas: real;
  iActual, iTotal: integer;
begin
  with QListadoStock do
  begin
    iTotal:= RecordCount;
    iActual:= 1;
    First;
    while not EOF do
    begin
      AMensaje.Caption:= 'PROCESANDO ENTREGA ' + IntToStr( iActual );
      if iTotal > 0 then
        AMensaje.Caption:= AMensaje.Caption + ' DE ' + IntToStr( iTotal );
      Application.ProcessMessages;

      ObtenerGastos( FieldByname('entrega').AsString, FieldByname('producto').AsString, FieldByname('variedad').AsString,
        FieldByname('calibre').AsString, rKilosCal, rKilosTot, rImporteLinea, rFacturas, rGastos );

      inc( iActual );
      Next;
    end;
    First;
  end;
end;

function TDLCosteFrutaProducto.ObtenerGastos( const AEntrega, AProducto, AVariedad, ACalibre: string;
                                             var AKilosCal, AKilosTot, AImporteLinea, AFacturas, AGastos: real ): boolean;
var
  rImporteTotal: Real;
begin
  result:= True;
  if TMemGastos.Locate('entrega;producto;variedad;calibre', VarArrayOf([AEntrega, AProducto, AVariedad, ACalibre]), []) then
  begin
    AKilosCal:= TMemGastos.FieldByName('kilosCal').AsFloat;
    AKilosTot:= TMemGastos.FieldByName('kilosTot').AsFloat;
    AImporteLinea:= TMemGastos.FieldByName('importeLinea').AsFloat;
    AGastos:= TMemGastos.FieldByName('gastos').AsFloat;
    AFacturas:= TMemGastos.FieldByName('facturas').AsFloat;
    if TMemGastos.FieldByName('importeTotal').AsFloat > 0 then
      result:= Abs( TMemGastos.FieldByName('facturas').AsFloat - TMemGastos.FieldByName('importeTotal').AsFloat ) < 1;
  end
  else
  begin
    ObtenerGastosEx( AEntrega, AProducto, AVariedad, ACalibre, AKilosCal, AImporteLinea, AKilosTot, rImporteTotal, AFacturas, AGastos );
    with TMemGastos do
    begin
      Insert;
      TMemGastos.FieldByName('entrega').AsString:= AEntrega;
      TMemGastos.FieldByName('producto').AsString:= AProducto;
      TMemGastos.FieldByName('variedad').AsString:= AVariedad;
      TMemGastos.FieldByName('calibre').AsString:= ACalibre;
      TMemGastos.FieldByName('kilosCal').AsFloat:= AKilosCal;
      TMemGastos.FieldByName('kilosTot').AsFloat:= AKilosTot;
      TMemGastos.FieldByName('importeLinea').AsFloat:= AImporteLinea;
      TMemGastos.FieldByName('importeTotal').AsFloat:= rImporteTotal;
      TMemGastos.FieldByName('gastos').AsFloat:= AGastos;
      TMemGastos.FieldByName('facturas').AsFloat:= AFacturas;
      Post;
    end;
    //if rImporteTotal > 0 then
      result:= Abs( rImporteTotal - AFacturas ) < 1;
  end;
end;

procedure TDLCosteFrutaProducto.ObtenerGastosEx( const AEntrega, AProducto, AVariedad, ACalibre: string;
                                                 var AKilosCal, AImporteLinea, AKilosTot, AImporteTotal, AFacturas, AGastos: real );
begin
  with QGastos do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    AFacturas:= FieldByname('facturas').AsFloat;
    AGastos:= FieldByname('gastos').AsFloat;
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
    AImporteLinea:= FieldByname('importeLinea').AsFloat;
    AImporteTotal:= FieldByname('importeTot').AsFloat;
    Close;
  end;
end;

end.
