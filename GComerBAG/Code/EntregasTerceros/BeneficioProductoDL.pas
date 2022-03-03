unit BeneficioProductoDL;

interface

uses
  SysUtils, StdCtrls, Forms, Classes, DB, DBTables, kbmMemTable;

type
  TDLBeneficioProducto = class(TDataModule)
    QListadoStock: TQuery;
    TMemGastos: TkbmMemTable;
    QFacturas: TQuery;
    QEntregas: TQuery;
    QSalidas: TQuery;
    QGastosProductos: TQuery;
    QSalidasProductos: TQuery;
    DSSalidas: TDataSource;
    mtSalidas: TkbmMemTable;
    QCosteSalidas: TQuery;
    QCosteEnvases: TQuery;
    DSCostes: TDataSource;
    mtCostes: TkbmMemTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure QSalidasAfterOpen(DataSet: TDataSet);
    procedure QSalidasBeforeClose(DataSet: TDataSet);
    procedure QCosteSalidasAfterOpen(DataSet: TDataSet);
    procedure QCosteSalidasBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    procedure DesPreparaQuery;
    procedure PreparaQueryFrutaProveedor( const AEmpresa, AProducto, AProveedor, AEntrega: string );
    procedure ObtenerGastosEx( const AEntrega, AProducto, AVariedad, ACalibre: string;
                               var AKilosCal, AKilosTot, AImporteLinea, AFacturas, AGastos: real );
    procedure RellenarTablaDeGastos( AMensaje: TLabel );

    procedure CalcularPreciosMedios( const AEmpresa, AFechaDesde, AFechaHasta, AProducto: string; AMensaje: TLabel );
    procedure ObtenerPrecios;

    procedure CalcularCosteEnvasado( const AEmpresa, AFechaDesde, AFechaHasta, AProducto: string; AMensaje: TLabel );
    procedure ObtenerCostes;
    function  GetCosteEnvases( const AMes: Integer; const AProducto: string ): real;

  public
    { Public declarations }
    function DatosBeneficioProducto( const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AAprovecha: string; AMensaje: TLabel ): boolean;
    procedure ObtenerGastos( const AEntrega, AProducto, AVariedad, ACalibre: string;
                             var AKilosCal, AKilosTot, AImporteLinea, AFacturas, AGastos: real );
    procedure GetPrecioMedio( const ASemana, AProducto: string;
                              var VKilos, VImporte, VGastos, VCoste: Real );
  end;

implementation

{$R *.dfm}


uses variants, UDMConfig, bMath, DateUtils, bTimeUtils;

procedure TDLBeneficioProducto.DataModuleCreate(Sender: TObject);
begin
  //Kilos para repercutir los gastos y importe entrega por si factura de proveedor no grabado
  with QEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        sum( case when ( calibre_el = :calibre and variedad_el = :variedad ) ');
    SQL.Add('                       then kilos_el else 0 end) kilosCal, ');
    SQL.Add('        sum( kilos_el ) kilosTot, ');
    //SQL.Add('        sum( case when ( calibre_el = :calibre and variedad_el = :variedad ) ');
    //SQL.Add('                       then precio_kg_el * kilos_el else 0 end) importeLinea, ');
    //SQL.Add('        sum( precio_kg_el * kilos_el ) importeTot ');
    SQL.Add('        0 importeLinea, 0 importeTot ');
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
  with QFacturas do
  begin
    SQL.Clear;
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

  TMemGastos.IndexFieldNames:= 'entrega;producto;calibre';
  TMemGastos.CreateTable;
  TMemGastos.Open;

  mtSalidas.FieldDefs.Clear;
  mtSalidas.FieldDefs.Add('semana', ftString, 6, False);
  mtSalidas.FieldDefs.Add('producto', ftString, 3, False);
  mtSalidas.FieldDefs.Add('kilos', ftFloat, 0, False);
  mtSalidas.FieldDefs.Add('importe', ftFloat, 0, False);
  mtSalidas.FieldDefs.Add('gasto', ftFloat, 0, False);
  mtSalidas.FieldDefs.Add('coste', ftFloat, 0, False);

  mtSalidas.IndexFieldNames:= 'semana;producto';
  mtSalidas.CreateTable;
  mtSalidas.Open;

  mtCostes.FieldDefs.Clear;
  mtCostes.FieldDefs.Add('mes', ftInteger, 0, False);
  mtCostes.FieldDefs.Add('producto', ftString, 3, False);
  mtCostes.FieldDefs.Add('kilos', ftFloat, 0, False);
  mtCostes.FieldDefs.Add('coste', ftFloat, 0, False);


  mtCostes.IndexFieldNames:= 'mes;producto';
  mtCostes.CreateTable;
  mtCostes.Open;
end;

procedure TDLBeneficioProducto.DesPreparaQuery;
begin
  QListadoStock.Close;
  if QFacturas.Prepared then
    QFacturas.UnPrepare;
  if QEntregas.Prepared then
    QEntregas.UnPrepare;
  if QListadoStock.Prepared then
    QListadoStock.UnPrepare;

  if QSalidas.Prepared then
    QSalidas.UnPrepare;
  if QSalidasProductos.Prepared then
    QSalidasProductos.UnPrepare;
  if QGastosProductos.Prepared then
    QGastosProductos.UnPrepare;

  if QCosteSalidas.Prepared then
    QCosteSalidas.UnPrepare;
  if QCosteEnvases.Prepared then
    QCosteEnvases.UnPrepare;
end;

procedure TDLBeneficioProducto.PreparaQueryFrutaProveedor( const AEmpresa, AProducto, AProveedor, AEntrega: string );
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
    SQL.Add('          WHERE p.producto_p = el.producto_el ');
    SQL.Add('        ) descripcion_p, ');
    SQL.Add('        ( select case when descripcion_breve_pp is null then descripcion_pp else descripcion_breve_pp end descripcion_breve_pp ');
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
    SQL.Add('        Sum( kilos_el ) peso_total, ');
    SQL.Add('        Sum( Round( (kilos_el * :aprovecha) /100 ,2 ) ) peso_aprovechado, ');
    SQL.Add('        Sum(el.cajas_el) cajas ');

    SQL.Add(' from frf_entregas_c ec, frf_entregas_l el ');
    SQL.Add(' where ec.fecha_llegada_ec between :fechaini and :fechafin ');
    SQL.Add('   AND el.codigo_el = ec.codigo_ec ');

    if AEmpresa <> '' then
      SQL.Add('   AND  ec.empresa_ec = :empresa');
    if AEntrega <> '' then
      SQL.Add('   AND ec.codigo_ec = :entrega ');
    if AProveedor <> '' then
      SQL.Add('   AND TRIM(ec.proveedor_ec) = :proveedor ');
    if AProducto <> '' then
      SQL.Add('   AND el.producto_el = :producto ');


    SQL.Add(' GROUP BY 1,2,3,4,5,6,7,8,9,10,11 ');
    SQL.Add(' ORDER BY descripcion_p, fecha, entrega, descripcion_breve_pp, calibre ');

    Prepare;
  end;

  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, sum(kilos_sl) kilos_sl ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where fecha_sl between :fechaini and :fechafin ');
    if AEmpresa <> '' then
      SQL.Add('   AND  empresa_sl = :empresa');
    if AProducto <> '' then
      SQL.Add('   AND  producto_sl = :producto ');
    SQL.Add(' group by 1,2,3,4 ');
    Prepare;
  end;

  with QSalidasProductos do
  begin
    SQL.Clear;
    SQL.Add(' select producto_sl, sum(kilos_sl) kilos_sl, ');
    SQL.Add('        SUM(  Round( NVL(importe_neto_sl,0)* ');
    SQL.Add('             (1-(GetComisionCliente( empresa_sl, cliente_sl, fecha_sl )/100))* ');
    SQL.Add('             (1-(GetDescuentoCliente( empresa_sl, cliente_sl, fecha_sl, 2 )/100)), 2) ) importe_sl ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa_sl ');
    SQL.Add(' and centro_salida_sl = :centro_salida_sl ');
    SQL.Add(' and n_albaran_sl = :n_albaran_sl ');
    SQL.Add(' and fecha_sl = :fecha_sl ');
    if AProducto <> '' then
      SQL.Add('   AND  producto_sl = ' + QuotedStr( AProducto ) );
    SQL.Add(' group by 1 ');
    Prepare;
  end;

  with QGastosProductos do
  begin
    SQL.Clear;
    SQL.Add(' select producto_g, sum( case when facturable_tg = ''S'' then -1 * importe_g else importe_g end ) importe_g ');
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');
    SQL.Add(' where tipo_tg = tipo_g ');
    SQL.Add(' and empresa_g = :empresa_sl ');
    SQL.Add(' and centro_salida_g = :centro_salida_sl ');
    SQL.Add(' and n_albaran_g = :n_albaran_sl ');
    SQL.Add(' and fecha_g = :fecha_sl ');
    if AProducto <> '' then
      SQL.Add('   AND  ( producto_g = ' + QuotedStr( AProducto ) + ' or producto_g is null ) ');
    SQL.Add(' group by 1 ');
    Prepare;
  end;

  with QCosteSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl, centro_salida_sl, year(fecha_sl) year_sl, month(fecha_sl) mes_sl, producto_sl, envase_sl, sum(kilos_sl) kilos_sl ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where fecha_sl between :fechaini and :fechafin ');
    if AEmpresa <> '' then
      SQL.Add('   AND  empresa_sl = :empresa');
    if AProducto <> '' then
      SQL.Add('   AND  producto_sl = :producto ');
    SQL.Add(' group by 1,2,3,4,5,6 ');
    Prepare;
  end;

  with QCosteEnvases do
  begin
    SQL.Clear;
    //SQL.Add(' select first 1 anyo_ec, mes_ec, nvl(material_ec,0) + nvl(personal_ec,0) + nvl(general_ec,0) coste_ec  ');
    SQL.Add(' select first 1 anyo_ec, mes_ec, nvl(material_ec,0) + nvl(coste_ec,0) + nvl(secciones_ec,0) coste_ec  ');
    SQL.Add(' from frf_env_costes ');
    SQL.Add(' where empresa_ec = :empresa_sl ');
    SQL.Add(' and centro_ec = :centro_salida_sl ');
    SQL.Add(' and producto_ec = :producto_sl ');
    SQL.Add(' and envase_ec = :envase_sl ');
    SQL.Add(' and ( ( anyo_ec = :year_sl and mes_ec <= :mes_sl ) or ( anyo_ec < :year_sl ) ) ');
    SQL.Add(' order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;

end;


procedure TDLBeneficioProducto.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuery;

  TMemGastos.Close;
  mtSalidas.Close;
  mtCostes.Close;
end;

function TDLBeneficioProducto.DatosBeneficioProducto( const AEmpresa, AProducto, AProveedor, AEntrega, AFechaDesde, AFechaHasta, AAprovecha: string;  AMensaje: TLabel ): boolean;
begin
  PreparaQueryFrutaProveedor( AEmpresa, AProducto, AProveedor, AEntrega );
  with QListadoStock do
  begin
    if AEmpresa <> '' then
      ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('fechaini').AsString:= AFechaDesde;
    ParamByName('fechafin').AsString:= AFechaHasta;
    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AEntrega <> '' then
      ParamByName('entrega').AsString:= AEntrega;
    ParamByName('aprovecha').AsInteger:= StrToIntDef( AAprovecha, 0 );
    Open;

    RellenarTablaDeGastos( AMensaje );
    CalcularCosteEnvasado( AEmpresa, AFechaDesde, AFechaHasta, AProducto, AMensaje );
    CalcularPreciosMedios( AEmpresa, AFechaDesde, AFechaHasta, AProducto, AMensaje );

    result:= not IsEmpty;
  end;
end;

procedure TDLBeneficioProducto.RellenarTablaDeGastos( AMensaje: TLabel );
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

procedure TDLBeneficioProducto.ObtenerGastos( const AEntrega, AProducto, AVariedad, ACalibre: string;
                                             var AKilosCal, AKilosTot, AImporteLinea, AFacturas, AGastos: real );
begin
  if TMemGastos.Locate('entrega;producto;variedad;calibre', VarArrayOf([AEntrega, AProducto, AVariedad, ACalibre]), []) then
  begin
    AKilosCal:= TMemGastos.FieldByName('kilosCal').AsFloat;
    AKilosTot:= TMemGastos.FieldByName('kilosTot').AsFloat;
    AImporteLinea:= TMemGastos.FieldByName('importeLinea').AsFloat;
    AGastos:= TMemGastos.FieldByName('gastos').AsFloat;
    AFacturas:= TMemGastos.FieldByName('facturas').AsFloat;
  end
  else
  begin
    ObtenerGastosEx( AEntrega, AProducto, AVariedad, ACalibre, AKilosCal, AKilosTot, AImporteLinea, AFacturas, AGastos );
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
      TMemGastos.FieldByName('gastos').AsFloat:= AGastos;
      TMemGastos.FieldByName('facturas').AsFloat:= AFacturas;
      Post;
    end;
  end;
end;

procedure TDLBeneficioProducto.ObtenerGastosEx( const AEntrega, AProducto, AVariedad, ACalibre: string;
                                               var AKilosCal, AKilosTot, AImporteLinea, AFacturas, AGastos: real );
begin
  with QFacturas do
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
    Close;
  end;
end;

procedure TDLBeneficioProducto.CalcularPreciosMedios( const AEmpresa, AFechaDesde, AFechaHasta, AProducto: string; AMensaje: TLabel );
var
  iActual: integer;
begin
  with QSalidas do
  begin

    ParamByName('fechaini').AsDate:= LunesAnterior ( StrToDate( AFechaDesde ) + 7 );
    ParamByName('fechafin').AsDate:= LunesAnterior ( StrToDate( AFechaHasta ) + 7 ) +  6;

    if AEmpresa <> '' then
      ParamByName('empresa').AsString:= AEmpresa;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    Open;
    iActual:= 1;
    First;
    while not EOF do
    begin
      AMensaje.Caption:= 'PROCESANDO SALIDA ' + IntToStr( iActual );
      Application.ProcessMessages;

      ObtenerPrecios;

      inc( iActual );
      Next;
    end;
    Close;
  end;
end;

procedure TDLBeneficioProducto.ObtenerPrecios;
var
  rKilosTotal: Real;
  iSemana, iMes: Integer;
  iYear: Word;
  sProducto: string;
  rImporte, rKilos, rGasto, rCoste: Real;

begin
    (*TODO*)
  //descuentos, gastos facturables
  rKilosTotal:= QSalidas.FieldByName('kilos_sl').AsFloat;
  iSemana:= WeekoftheYear( QSalidas.FieldByName('fecha_sl').AsDateTime - 7, iYear );
  iSemana:= ( iYear * 100 ) + iSemana;
  iMes:= MonthOfTheYear( QSalidas.FieldByName('fecha_sl').AsDateTime - 7 );
  iMes:= ( iYear * 100 ) + iMes;


  QSalidasProductos.First;
  while not QSalidasProductos.Eof do
  begin
    sProducto:= QSalidasProductos.FieldByName('producto_sl').AsString;
    rKilos:= QSalidasProductos.FieldByName('kilos_sl').AsFloat;
    rImporte:= QSalidasProductos.FieldByName('importe_sl').AsFloat;

    rGasto:= 0;
    rCoste:= 0;
    QGastosProductos.First;
    while not QGastosProductos.Eof do
    begin
      if QGastosProductos.FieldByName('producto_g').AsString = QSalidasProductos.FieldByName('producto_sl').AsString  then
      begin
        rGasto:= rGasto + QGastosProductos.FieldByName('importe_g').AsFloat;
      end
      else
      if QGastosProductos.FieldByName('producto_g').AsString = ''  then
      begin
        if rKilosTotal > 0 then
          rGasto:= rGasto + bRoundTo( ( QGastosProductos.FieldByName('importe_g').AsFloat * rKilos ) / rKilosTotal, -2 );
      end;
    end;

    if rKilosTotal > 0 then
      rCoste:= bRoundTo( GetCosteEnvases( iMes, sProducto ) * rKilos, 2 );

    if mtSalidas.Locate('semana;producto', VarArrayOf([iSemana, sProducto]), []) then
    begin
      mtSalidas.Edit;
      mtSalidas.FieldByName('kilos').AsFloat:= mtSalidas.FieldByName('kilos').AsFloat + rKilos;
      mtSalidas.FieldByName('importe').AsFloat:= mtSalidas.FieldByName('importe').AsFloat + rImporte;
      mtSalidas.FieldByName('gasto').AsFloat:= mtSalidas.FieldByName('gasto').AsFloat + rGasto;
      mtSalidas.FieldByName('coste').AsFloat:= mtSalidas.FieldByName('coste').AsFloat + rCoste;
      mtSalidas.Post;
    end
    else
    begin
      mtSalidas.Insert;
      mtSalidas.FieldByName('semana').AsString:= IntToStr( iSemana );
      mtSalidas.FieldByName('producto').AsString:= sProducto;
      mtSalidas.FieldByName('kilos').AsFloat:= rKilos;
      mtSalidas.FieldByName('importe').AsFloat:= rImporte;
      mtSalidas.FieldByName('gasto').AsFloat:= rGasto;
      mtSalidas.FieldByName('coste').AsFloat:= rCoste;
      mtSalidas.Post;
    end;

    QSalidasProductos.Next;
  end;
end;

procedure TDLBeneficioProducto.GetPrecioMedio( const ASemana, AProducto: string;
                                               var VKilos, VImporte, VGastos, VCoste: Real );
begin
  if mtSalidas.Locate('semana;producto', VarArrayOf([ASemana, AProducto]), []) then
  begin
    VKilos:= mtSalidas.FieldByName('kilos').AsFloat;
    VImporte:= mtSalidas.FieldByName('importe').AsFloat;
    VGastos:= mtSalidas.FieldByName('gasto').AsFloat;
    VCoste:= mtSalidas.FieldByName('coste').AsFloat;
  end
  else
  begin
    VKilos:= 0;
    VImporte:= 0;
    VGastos:= 0;
    VCoste:= 0;
  end;
end;

procedure TDLBeneficioProducto.CalcularCosteEnvasado( const AEmpresa, AFechaDesde, AFechaHasta, AProducto: string; AMensaje: TLabel );
var
  iActual: integer;
begin
  with QCosteSalidas do
  begin

    ParamByName('fechaini').AsDate:= LunesAnterior ( StrToDate( AFechaDesde ) + 7 );
    ParamByName('fechafin').AsDate:= LunesAnterior ( StrToDate( AFechaHasta ) + 7 ) +  6;

    if AEmpresa <> '' then
      ParamByName('empresa').AsString:= AEmpresa;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    Open;
    iActual:= 1;
    First;
    while not EOF do
    begin
      AMensaje.Caption:= 'PROCESANDO COSTES ' + IntToStr( iActual );
      Application.ProcessMessages;

      ObtenerCostes;

      inc( iActual );
      Next;
    end;
    Close;
  end;
end;

procedure TDLBeneficioProducto.ObtenerCostes;
var
  iMes: Integer;
  sProducto: string;
  rCoste: Real;
begin
  if not QCosteEnvases.IsEmpty then
  begin
    iMes:= ( QCosteSalidas.FieldByName('year_sl').AsInteger * 100 ) + QCosteSalidas.FieldByName('mes_sl').AsInteger;
    sProducto:= QCosteSalidas.FieldByName('producto_sl').AsString;
    rCoste:= QCosteSalidas.FieldByName('kilos_sl').AsFloat *  QCosteEnvases.FieldByName('coste_ec').AsFloat;

    if mtCostes.Locate('mes;producto', VarArrayOf([iMes, sProducto]), []) then
    begin
      mtCostes.Edit;
      mtCostes.FieldByName('kilos').AsFloat:= mtCostes.FieldByName('kilos').AsFloat + QCosteSalidas.FieldByName('kilos_sl').AsFloat;
      mtCostes.FieldByName('coste').AsFloat:= mtCostes.FieldByName('coste').AsFloat + rCoste;
      mtCostes.Post;
    end
    else
    begin
      mtCostes.Insert;
      mtCostes.FieldByName('mes').AsInteger:= iMes;
      mtCostes.FieldByName('producto').AsString:= sProducto;
      mtCostes.FieldByName('kilos').AsFloat:= QCosteSalidas.FieldByName('kilos_sl').AsFloat;
      mtCostes.FieldByName('coste').AsFloat:= rCoste;
      mtCostes.Post;
    end;
  end
  else
  begin
    iMes:= ( QCosteSalidas.FieldByName('year_sl').AsInteger * 100 ) + QCosteSalidas.FieldByName('mes_sl').AsInteger;
    sProducto:= QCosteSalidas.FieldByName('producto_sl').AsString;

    if mtCostes.Locate('mes;producto', VarArrayOf([iMes, sProducto]), []) then
    begin
      mtCostes.Edit;
      mtCostes.FieldByName('kilos').AsFloat:= mtCostes.FieldByName('kilos').AsFloat + QCosteSalidas.FieldByName('kilos_sl').AsFloat;
      mtCostes.Post;
    end
    else
    begin
      mtCostes.Insert;
      mtCostes.FieldByName('mes').AsInteger:= iMes;
      mtCostes.FieldByName('producto').AsString:= sProducto;
      mtCostes.FieldByName('kilos').AsFloat:= QCosteSalidas.FieldByName('kilos_sl').AsFloat;
      mtCostes.FieldByName('coste').AsFloat:= 0;
      mtCostes.Post;
    end;
  end;
end;

function  TDLBeneficioProducto.GetCosteEnvases( const AMes: Integer; const AProducto: string ): real;
begin
  if mtCostes.Locate('mes;producto', VarArrayOf([AMes, AProducto]), []) then
  begin
    if mtCostes.FieldByName('kilos').AsFloat <> 0 then
      Result:= mtCostes.FieldByName('coste').AsFloat / mtCostes.FieldByName('kilos').AsFloat
    else
      Result:= 0;
  end
  else
  begin
    Result:= 0;
  end;
end;


procedure TDLBeneficioProducto.QSalidasAfterOpen(DataSet: TDataSet);
begin
  QSalidasProductos.Open;
  QGastosProductos.Open;
end;

procedure TDLBeneficioProducto.QSalidasBeforeClose(DataSet: TDataSet);
begin
  QSalidasProductos.Close;
  QGastosProductos.Close;
end;

procedure TDLBeneficioProducto.QCosteSalidasAfterOpen(DataSet: TDataSet);
begin
  QCosteEnvases.Open;
end;

procedure TDLBeneficioProducto.QCosteSalidasBeforeClose(DataSet: TDataSet);
begin
  QCosteEnvases.Close;
end;

end.


