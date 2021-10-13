unit LiquidaIncidenciasDL;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDLLiquidaIncidencias = class(TDataModule)
    kmtDias: TkbmMemTable;
    kmtStock: TkbmMemTable;
    kmtVerdeSinSalida: TkbmMemTable;
    kmtVariedades: TkbmMemTable;
    kmtSinValorar: TkbmMemTable;
    kmtSinAlbaranes: TkbmMemTable;
    qrySinValorar: TQuery;
    kmtSinPortes: TkbmMemTable;
    qrySinPortes: TQuery;
    kmtSinFlete: TkbmMemTable;
    qrySinFlete: TQuery;
    kmtSinFOB: TkbmMemTable;
    kmtSinPrecioReal: TkbmMemTable;
    qrySinPrecioReal: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    function ListaVerdeSinSalida: string;

    function AddEntregasSinGastoTransporte( const AEmpresa, AProducto, AAnyoSemana: string ): Boolean;
    function AddSalidasSinValorar: Boolean;
    function AddSalidasSinGatosTransporte: Boolean;
    function AddEnvasesSinCoste: Boolean;
    function AddEntregasSinPrecioReal( const AProducto, AAnyoSemana: string ): Boolean;

  public
    { Public declarations }
    procedure InicializarProblemas;
    procedure VerProblemas( const AEmpresa, AAnyoSemana, AProducto: string);

    procedure AddNewSinFOB( const AEmpresa, AEntrega, AProducto, AVariedad, ACategoria,
                                  ACliente, AFecha, ASalida, AEnvase, ACategoria_sal: string; const AOrden: integer );
    procedure AddNewDay( const AEmpresa, AProducto, ADia: string );
    procedure AddPaletStock( const AEmpresa, AEntrega, ASSCC, AFecha : string; const AKilos: real  );
    procedure AddVerdeSinSalida(
                const Aempresa, AEntrega, Aproveedor, Aalmacen, Aproducto, Acategoria, Avariedad, Aenvase: string;
                const Apalets, Acajas, Akilos: real );
    procedure AddVariedadSinTeorico( const Aempresa, AEntrega, Aproveedor, Aproducto, Avariedad, ACategoria: string; const AKilosCaja: real );

  end;

implementation

{$R *.dfm}

uses
  Variants, Dialogs, LiquidaIncidenciasQL, VerificarKilosEntregadosQL, UDMBaseDatos;

procedure TDLLiquidaIncidencias.DataModuleCreate(Sender: TObject);
begin
  kmtSinFOB.FieldDefs.Clear;
  kmtSinFOB.FieldDefs.Add('empresa', ftString, 3, False);
  kmtSinFOB.FieldDefs.Add('entrega', ftString, 12, False);
  kmtSinFOB.FieldDefs.Add('producto', ftString, 3, False);
  kmtSinFOB.FieldDefs.Add('variedad', ftString, 3, False);
  kmtSinFOB.FieldDefs.Add('categoria', ftString, 3, False);

  kmtSinFOB.FieldDefs.Add('cliente', ftString, 3, False);
  kmtSinFOB.FieldDefs.Add('salida', ftString, 6, False);
  kmtSinFOB.FieldDefs.Add('fecha', ftString, 10, False);
  kmtSinFOB.FieldDefs.Add('envase', ftString, 9,  False);
  kmtSinFOB.FieldDefs.Add('categoria_sal', ftString, 3, False);
  kmtSinFOB.FieldDefs.Add('orden', ftInteger, 0, False);
  kmtSinFOB.CreateTable;
  kmtSinFOB.Open;

  //
  kmtDias.FieldDefs.Clear;
  kmtDias.FieldDefs.Add('empresa', ftString, 3, False);
  kmtDias.FieldDefs.Add('fecha', ftDate, 0, False);
  kmtDias.FieldDefs.Add('producto', ftString, 3, False);
  kmtDias.CreateTable;
  kmtDias.Open;

  kmtStock.FieldDefs.Clear;
  kmtStock.FieldDefs.Add('empresa', ftString, 3, False);
  kmtStock.FieldDefs.Add('entrega', ftString, 12, False);
  kmtStock.FieldDefs.Add('sscc', ftString, 30, False);
  kmtStock.FieldDefs.Add('fecha', ftString, 10, False);
  kmtStock.FieldDefs.Add('kilos', ftFloat, 0, False);
  kmtStock.CreateTable;
  kmtStock.Open;

  kmtVariedades.FieldDefs.Clear;
  kmtVariedades.FieldDefs.Add('empresa', ftString, 3, False);
  kmtVariedades.FieldDefs.Add('entrega', ftString, 12, False);
  kmtVariedades.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtVariedades.FieldDefs.Add('producto', ftString, 3, False);
  kmtVariedades.FieldDefs.Add('variedad', ftString, 3, False);
  kmtVariedades.FieldDefs.Add('categoria', ftString, 3, False);
  kmtVariedades.FieldDefs.Add('kilos_caja', ftFloat, 0, False);
  kmtVariedades.CreateTable;
  kmtVariedades.Open;

  kmtVerdeSinSalida.FieldDefs.Clear;
  //kmtVerdeSinSalida.FieldDefs.Add('empresa', ftString, 3, False);
  kmtVerdeSinSalida.FieldDefs.Add('entrega', ftString, 20, False);
  //kmtVerdeSinSalida.FieldDefs.Add('proveedor', ftString, 3, False);
  //kmtVerdeSinSalida.FieldDefs.Add('almacen', ftString, 3, False);
  //kmtVerdeSinSalida.FieldDefs.Add('producto', ftString, 3, False);
  //kmtVerdeSinSalida.FieldDefs.Add('categoria', ftString, 3, False);
  //kmtVerdeSinSalida.FieldDefs.Add('variedad', ftString, 3, False);
  //kmtVerdeSinSalida.FieldDefs.Add('envase', ftString, 9 False);
  //kmtVerdeSinSalida.FieldDefs.Add('palets', ftFloat, 0, False);
  //kmtVerdeSinSalida.FieldDefs.Add('cajas', ftFloat, 0, False);
  //kmtVerdeSinSalida.FieldDefs.Add('kilos', ftFloat, 0, False);
  kmtVerdeSinSalida.CreateTable;
  kmtVerdeSinSalida.Open;

  kmtSinValorar.FieldDefs.Clear;
  kmtSinValorar.FieldDefs.Add('empresa', ftString, 3, False);
  kmtSinValorar.FieldDefs.Add('centro', ftString, 3, False);
  kmtSinValorar.FieldDefs.Add('albaran', ftInteger, 0, False);
  kmtSinValorar.FieldDefs.Add('fecha', ftDate, 0, False);
  kmtSinValorar.FieldDefs.Add('cliente', ftString, 3, False);
  kmtSinValorar.FieldDefs.Add('nom_cliente', ftString, 50, False);
  kmtSinValorar.CreateTable;

  qrySinValorar.Sql.Clear;
  qrySinValorar.Sql.Add('select empresa_sl empresa, centro_salida_sl centro, n_albaran_sl albaran, fecha_sl fecha, ');
  qrySinValorar.Sql.Add('       cliente_sl cliente, ');
  qrySinValorar.Sql.Add('       ( select nombre_c from frf_clientes ');
  qrySinValorar.Sql.Add('         where cliente_sl = cliente_c  ) nom_cliente ');
  qrySinValorar.Sql.Add('from frf_salidas_l ');
  qrySinValorar.Sql.Add('where empresa_sl = :empresa ');
  qrySinValorar.Sql.Add('and producto_sl = :producto ');
  qrySinValorar.Sql.Add('and fecha_sl = :fecha ');
  qrySinValorar.Sql.Add('and precio_sl = 0 ');
  qrySinValorar.Sql.Add('and cliente_sl [1,1] <> ''0'' ');
  qrySinValorar.Sql.Add('group by 1,2,3,4,5,6 ');

  kmtSinPortes.FieldDefs.Clear;
  kmtSinPortes.FieldDefs.Add('empresa', ftString, 3, False);
  kmtSinPortes.FieldDefs.Add('centro', ftString, 3, False);
  kmtSinPortes.FieldDefs.Add('albaran', ftInteger, 0, False);
  kmtSinPortes.FieldDefs.Add('fecha', ftDate, 0, False);
  kmtSinPortes.FieldDefs.Add('cliente', ftString, 3, False);
  kmtSinPortes.FieldDefs.Add('nom_cliente', ftString, 50, False);
  kmtSinPortes.CreateTable;

  qrySinPortes.Sql.Clear;
  qrySinPortes.Sql.Add('select empresa_sc empresa, centro_salida_sc centro, n_albaran_sc albaran, fecha_sc fecha, ');
  qrySinPortes.Sql.Add('       cliente_sal_sc cliente, ');
  qrySinPortes.Sql.Add('       ( select nombre_c from frf_clientes ');
  qrySinPortes.Sql.Add('         where cliente_sal_sc = cliente_c  ) nom_cliente ');

  qrySinPortes.Sql.Add('from frf_salidas_c ');

  qrySinPortes.Sql.Add('where empresa_sc = :empresa ');
  qrySinPortes.Sql.Add('and fecha_sc = :fecha ');
  qrySinPortes.Sql.Add('and porte_bonny_sc = 1 ');
  qrySinPortes.Sql.Add('and exists ');
  qrySinPortes.Sql.Add('( ');
  qrySinPortes.Sql.Add('  select * from frf_salidas_l ');
  qrySinPortes.Sql.Add('  where empresa_sc = empresa_sl ');
  qrySinPortes.Sql.Add('  and centro_salida_sc = centro_salida_sl ');
  qrySinPortes.Sql.Add('  and fecha_sc = fecha_sl ');
  qrySinPortes.Sql.Add('  and n_albaran_sc = n_albaran_sl ');
  qrySinPortes.Sql.Add('  and producto_sl = :producto ');
  qrySinPortes.Sql.Add(') ');
  qrySinPortes.Sql.Add('and not exists ');
  qrySinPortes.Sql.Add('( ');
  qrySinPortes.Sql.Add('  select * from frf_gastos ');
  qrySinPortes.Sql.Add('  where empresa_sc = empresa_g ');
  qrySinPortes.Sql.Add('  and centro_salida_sc = centro_salida_g ');
  qrySinPortes.Sql.Add('  and fecha_sc = fecha_g ');
  qrySinPortes.Sql.Add('  and n_albaran_sc = n_albaran_g  ');
//  qrySinPortes.Sql.Add('  and tipo_g = ''309'' ');
  qrySinPortes.Sql.Add('  and tipo_g = ''001'' ');
  qrySinPortes.Sql.Add(') ');


  kmtSinFlete.FieldDefs.Clear;
  kmtSinFlete.FieldDefs.Add('empresa', ftString, 3, False);
  kmtSinFlete.FieldDefs.Add('entrega', ftString, 12, False);
  kmtSinFlete.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtSinFlete.FieldDefs.Add('nom_proveedor', ftString, 30, False);
  kmtSinFlete.FieldDefs.Add('productor', ftString, 3, False);
  kmtSinFlete.FieldDefs.Add('nom_productor', ftString, 30, False);
  kmtSinFlete.CreateTable;

  qrySinFlete.Sql.Clear;
  qrySinFlete.Sql.Add('select empresa_ec empresa, codigo_ec entrega, ');
  qrySinFlete.Sql.Add('       proveedor_ec proveedor, ');
  qrySinFlete.Sql.Add('       ( select nombre_p from frf_proveedores ');
  qrySinFlete.Sql.Add('         where proveedor_Ec = proveedor_p ) nom_proveedor, ');
  qrySinFlete.Sql.Add('       almacen_El productor, ');
  qrySinFlete.Sql.Add('       ( select nombre_pa from frf_proveedores_almacen ');
  qrySinFlete.Sql.Add('         where proveedor_Ec = proveedor_pa and almacen_el = almacen_pa ) nom_productor ');

  qrySinFlete.Sql.Add('from frf_entregas_c, frf_entregas_l ');

  qrySinFlete.Sql.Add('where producto_ec = :producto ');
  qrySinFlete.Sql.Add('and anyo_semana_ec = :semana ');
  qrySinFlete.Sql.Add('and codigo_el = codigo_ec ');
  qrySinFlete.Sql.Add('and empresa_ec in (''F17'',''F23'',''F24'',''F42'') ');

  qrySinFlete.Sql.Add('and not exists ');
  qrySinFlete.Sql.Add('( ');
  qrySinFlete.Sql.Add(' select * from frf_gastos_entregas, frf_tipo_gastos ');
  qrySinFlete.Sql.Add(' where codigo_ge = codigo_ec and tipo_ge = tipo_tg ');
  qrySinFlete.SQL.Add(' and agrupacion_tg <> ''COMPRA'' ');
  qrySinFlete. SQL.Add('and agrupacion_tg <> ''ESTADISTIC'' ');
  qrySinFlete.Sql.Add(') ');

  qrySinFlete.Sql.Add('group by 1,2,3,4,5,6 ');

  kmtSinPrecioReal.FieldDefs.Clear;
  kmtSinPrecioReal.FieldDefs.Add('empresa', ftString, 3, False);
  kmtSinPrecioReal.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtSinPrecioReal.FieldDefs.Add('nom_proveedor', ftString, 30, False);
  kmtSinPrecioReal.FieldDefs.Add('anyosemana', ftString, 6, False);
  kmtSinPrecioReal.FieldDefs.Add('producto', ftString, 3, False);
  kmtSinPrecioReal.FieldDefs.Add('variedad', ftString, 3, False);
  kmtSinPrecioReal.FieldDefs.Add('categoria', ftString, 3, False);
  kmtSinPrecioReal.CreateTable;

  qrySinPrecioReal.Sql.Clear;
  qrySinPrecioReal.sql.Add(' select distinct empresa_ec empresa, proveedor_ec proveedor, nombre_p nom_proveedor,                     ');
  qrySinPrecioReal.sql.Add('        producto_el producto, anyo_semana_ec anyosemana, categoria_el categoria, variedad_el variedad    ');
  qrySinPrecioReal.SQL.add('   from frf_entregas_c                                                                                   ');
  qrySinPrecioReal.sql.Add('        join frf_entregas_l on codigo_ec = codigo_el                                                     ');
  qrySinPrecioReal.sql.Add('        join frf_proveedores on proveedor_p = proveedor_ec and propio_p = 1   ');
  qrySinPrecioReal.sql.Add('  where empresa_ec in (''F17'',''F23'',''F24'',''F42'')                                                  ');
  qrySinPrecioReal.sql.Add('   and producto_el = :producto                                                                           ');
  qrySinPrecioReal.sql.Add('   and anyo_semana_ec = :anyosemana                                                                      ');

  qrySinPrecioReal.sql.Add('   and not exists (select * from frf_precio_liquidacion                                                  ');
  qrySinPrecioReal.sql.Add(' 	    	   where empresa_pl = empresa_ec                                                                 ');
  qrySinPrecioReal.sql.Add(' 		         and proveedor_pl = proveedor_ec                                                             ');
  qrySinPrecioReal.sql.Add(' 		         and anyo_semana_pl = anyo_semana_ec                                                         ');
  qrySinPrecioReal.sql.Add(' 		         and producto_pl = producto_el                                                               ');
  qrySinPrecioReal.sql.Add(' 	  	       and categoria_pl = categoria_el                                                             ');
  qrySinPrecioReal.sql.Add(' 		         and variedad_pl = variedad_el)                                                              ');

end;

procedure TDLLiquidaIncidencias.DataModuleDestroy(Sender: TObject);
begin
  //
  kmtSinFOB.Close;
  kmtDias.Close;
  kmtStock.Close;
  kmtVariedades.Close;
  kmtVerdeSinSalida.Close;

  kmtSinValorar.Close;
  kmtSinPortes.Close;
  kmtSinFlete.Close;
end;

procedure TDLLiquidaIncidencias.InicializarProblemas;
begin
  kmtSinFOB.Close;
  kmtSinFOB.Open;
  kmtDias.Close;
  kmtDias.Open;
  kmtStock.Close;
  kmtStock.Open;
  kmtVerdeSinSalida.Close;
  kmtVerdeSinSalida.Open;
  kmtVariedades.Close;
  kmtVariedades.Open;

  kmtSinValorar.Close;
  kmtSinValorar.Open;
  kmtSinPortes.Close;
  kmtSinPortes.Open;
  kmtSinFlete.Close;
  kmtSinFlete.Open;
end;

procedure TDLLiquidaIncidencias.VerProblemas( const AEmpresa, AAnyoSemana, AProducto: string );
var
  bFlag: Boolean;
  sAux: string;
begin
  bFlag:= False;
  sAux:= '';


  //Previsualizar
  if not kmtStock.IsEmpty then
  begin
    if sAux <> '' then
      sAux:= sAux + #13 + #10;
    sAux:= '¡¡¡ATENCION!!!' + #13 + #10 + 'Quedan palets en Stock, para la liquidación definitiva es necesario que no quede ningún palet en Stock.';
    bFlag:= True;
  end;
  if not kmtVerdeSinSalida.IsEmpty then
  begin
    if sAux <> '' then
      sAux:= sAux + #13 + #10;
    sAux:= sAux + '¡¡¡ATENCION!!!' + #13 + #10 + 'Quedan entregas de verde sin salida asignada.';
    bFlag:= True;
  end;
  if not kmtVariedades.IsEmpty then
  begin
    if sAux <> '' then
      sAux:= sAux + #13 + #10;
    sAux:= sAux + '¡¡¡ATENCION!!!' + #13 + #10 + 'Hay variedades en RF que no concuerdan con la entrega grabada.';
    bFlag:= True;
  end;
  if AddEntregasSinGastoTransporte( AEmpresa, AProducto, AAnyoSemana ) then
  begin
    if sAux <> '' then
      sAux:= sAux + #13 + #10;
    sAux:= '¡¡¡ATENCION!!!' + #13 + #10 + 'Hay entregas sin el gasto de transporte grabado (Tipo gasto "040").';
    bFlag:= True;
  end;
  if AddSalidasSinValorar then
  begin
    if sAux <> '' then
      sAux:= sAux + #13 + #10;
    sAux:= '¡¡¡ATENCION!!!' + #13 + #10 + 'Hay albaranes de venta sin valorar.';
    bFlag:= True;
  end;
  if not kmtSinFOB.IsEmpty then
  begin
    if sAux <> '' then
      sAux:= sAux + #13 + #10;
    sAux:= '¡¡¡ATENCION!!!' + #13 + #10 + 'Hay entregas sin precio FOB.';
    bFlag:= True;
  end;
  if AddSalidasSinGatosTransporte then
  begin
    if sAux <> '' then
      sAux:= sAux + #13 + #10;
    sAux:= '¡¡¡ATENCION!!!' + #13 + #10 + 'Hay salidas con porte propio sin el gasto grabado (Tipo gasto "309").';
    bFlag:= True;
  end;
  if AddEnvasesSinCoste then
  begin
    if sAux <> '' then
      sAux:= sAux + #13 + #10;
    sAux:= '¡¡¡ATENCION!!!' + #13 + #10 + 'Hay envases que no tienen coste grabado.';
    bFlag:= True;
  end;
  if AddEntregasSinPrecioReal( AProducto, AAnyoSemana ) then
  begin
    if sAux <> '' then
      sAux:= sAux + #13 + #10;
    sAux:= '¡¡¡ATENCION!!!' + #13 + #10 + 'Hay Categorias/Variedades que no tienen grabado el PRECIO REAL.';
    bFlag:= True;
  end;


  if bFlag then
  begin
    ShowMessage( sAux );

    kmtStock.SortFields:= 'empresa;entrega;sscc';
    kmtStock.Sort([]);

    kmtVerdeSinSalida.SortFields:= 'entrega';
    kmtVerdeSinSalida.Sort([]);

    kmtVariedades.SortFields:= 'empresa;entrega;variedad';
    kmtVariedades.Sort([]);

    kmtSinValorar.SortFields:= 'empresa;centro;fecha;albaran';
    kmtSinValorar.Sort([]);

    kmtSinPortes.SortFields:= 'empresa;centro;fecha;albaran';
    kmtSinPortes.Sort([]);

    kmtSinFlete.SortFields:= 'empresa;proveedor;entrega;productor';
    kmtSinFlete.Sort([]);

    kmtSinPrecioReal.SortFields:= 'empresa;proveedor;anyosemana;producto;categoria;variedad';
    kmtSinPrecioReal.Sort([]);

    PrevisualizarIncidencias( AEmpresa, AAnyoSemana, AProducto );
  end;
end;

procedure TDLLiquidaIncidencias.AddNewDay( const AEmpresa, AProducto, ADia: string );
var
  dFecha: TDateTime;
begin
  if tryStrToDate( ADia, dFecha ) then
  begin
    if not kmtDias.Locate( 'empresa;fecha;producto', VarArrayOf([AEmpresa,dFecha,AProducto ]),[]) then
    begin
      kmtDias.Insert;
      kmtDias.FieldByName('empresa').AsString:= AEmpresa;
      kmtDias.FieldByName('fecha').AsDateTime:= dFecha;
      kmtDias.FieldByName('producto').AsString:= AProducto;
      kmtDias.Post;
    end;
  end;
end;

procedure TDLLiquidaIncidencias.AddNewSinFOB( const AEmpresa, AEntrega, AProducto, AVariedad, ACategoria,
                                                    ACliente, AFecha, ASalida, AEnvase, ACategoria_sal: string; const AOrden: integer );
var
  dFecha: TDateTime;
begin
  if not kmtSinFOB.Locate( 'empresa;entrega;producto;variedad;categoria;cliente;fecha;salida;envase;categoria_sal',
                            VarArrayOf([AEmpresa, AEntrega, AProducto, AVariedad, ACategoria,
                                        ACliente, AFecha, ASalida, AEnvase, ACategoria_sal]),[]) then
  begin
      kmtSinFOB.Insert;
      kmtSinFOB.FieldByName('empresa').AsString:= AEmpresa;
      kmtSinFOB.FieldByName('entrega').AsString:= AEntrega;
      kmtSinFOB.FieldByName('producto').AsString:= AProducto;
      kmtSinFOB.FieldByName('variedad').AsString:= AVariedad;
      kmtSinFOB.FieldByName('categoria').AsString:= ACategoria;

      kmtSinFOB.FieldByName('cliente').AsString:= ACliente;
      kmtSinFOB.FieldByName('salida').AsString:= ASalida;
      kmtSinFOB.FieldByName('fecha').AsString:= AFecha;
      kmtSinFOB.FieldByName('envase').AsString:= AEnvase;
      kmtSinFOB.FieldByName('categoria_sal').AsString:= ACategoria_sal;
      kmtSinFOB.FieldByName('orden').AsInteger:= AOrden;
      kmtSinFOB.Post;
  end;
end;

procedure TDLLiquidaIncidencias.AddPaletStock( const AEmpresa, AEntrega, ASSCC, AFecha: string; const AKilos: real  );
begin
  kmtStock.Insert;
  kmtStock.FieldByName('empresa').AsString:= AEmpresa;
  kmtStock.FieldByName('entrega').AsString:= AEntrega;
  kmtStock.FieldByName('sscc').AsString:= ASSCC;
  kmtStock.FieldByName('fecha').AsString:= Copy( AFecha, 1, 10 );;
  kmtStock.FieldByName('kilos').AsFloat:= AKilos;
  kmtStock.Post;
end;

procedure TDLLiquidaIncidencias.AddVerdeSinSalida(
            const Aempresa, AEntrega, Aproveedor, Aalmacen, Aproducto, Acategoria, Avariedad, Aenvase: string;
            const Apalets, Acajas, Akilos: real );
begin
  if not kmtVerdeSinSalida.Locate( 'entrega', AEntrega,[]) then
  begin
    kmtVerdeSinSalida.Insert;
    //kmtVerdeSinSalida.FieldByName('empresa').AsString:= Aempresa;
    kmtVerdeSinSalida.FieldByName('entrega').AsString:= Aentrega;
    //kmtVerdeSinSalida.FieldByName('proveedor').AsString:= Aproveedor;
    //kmtVerdeSinSalida.FieldByName('almacen').AsString:= Aalmacen;
    //kmtVerdeSinSalida.FieldByName('producto').AsString:= Aproducto;
    //kmtVerdeSinSalida.FieldByName('categoria').AsString:= Acategoria;
    //kmtVerdeSinSalida.FieldByName('variedad').AsString:= Avariedad;
    //kmtVerdeSinSalida.FieldByName('envase').AsString:= Aenvase;
    //kmtVerdeSinSalida.FieldByName('palets').AsFloat:= Apalets;
    //kmtVerdeSinSalida.FieldByName('cajas').AsFloat:= Acajas;
    //kmtVerdeSinSalida.FieldByName('kilos').AsFloat:= Akilos;
    kmtVerdeSinSalida.Post;
  end;
end;

function TDLLiquidaIncidencias.ListaVerdeSinSalida: string;
begin
  Result:= #13 + #10 + kmtVerdeSinSalida.FieldByName('entrega').AsString;
  kmtVerdeSinSalida.First;
  kmtVerdeSinSalida.Next;
  while not kmtVerdeSinSalida.Eof do
  begin
    Result:= Result + ' // ' + kmtVerdeSinSalida.FieldByName('entrega').AsString;
    kmtVerdeSinSalida.Next;
  end;
end;

procedure TDLLiquidaIncidencias.AddVariedadSinTeorico(
            const Aempresa, AEntrega, Aproveedor, Aproducto, Avariedad, ACategoria: string; const AKilosCaja: real );
begin
  if kmtVariedades.Locate( 'empresa;entrega;proveedor;producto;variedad;categoria',
       VarArrayOf([Aempresa, AEntrega, Aproveedor, Aproducto, Avariedad, ACategoria]),[]) then
  begin
    kmtVariedades.Insert;
    kmtVariedades.FieldByName('empresa').AsString:= Aempresa;
    kmtVariedades.FieldByName('entrega').AsString:= Aentrega;
    kmtVariedades.FieldByName('proveedor').AsString:= Aproveedor;
    kmtVariedades.FieldByName('producto').AsString:= Aproducto;
    kmtVariedades.FieldByName('variedad').AsString:= Avariedad;
    kmtVariedades.FieldByName('categoria').AsString:= Acategoria;
    kmtVariedades.FieldByName('kilos_caja').AsFloat:= AKilosCaja;
    kmtVariedades.Post;
  end;
end;


function TDLLiquidaIncidencias.AddEntregasSinGastoTransporte( const AEmpresa, AProducto, AAnyoSemana: string ): Boolean;
begin
  if kmtSinFlete.Active then
    kmtSinFlete.Close;
  kmtSinFlete.Open;

  //qrySinFlete.ParamByName('empresa').AsString:=  AEmpresa;
  qrySinFlete.ParamByName('semana').AsString:=  AAnyoSemana;
  qrySinFlete.ParamByName('producto').AsString:=  AProducto;
  qrySinFlete.Open;

  while not qrySinFlete.Eof do
  begin
    kmtSinFlete.Insert;
    kmtSinFlete.FieldByName('empresa').AsString:= qrySinFlete.FieldByName('empresa').AsString;
    kmtSinFlete.FieldByName('entrega').AsString:= qrySinFlete.FieldByName('entrega').AsString;
    kmtSinFlete.FieldByName('proveedor').AsString:= qrySinFlete.FieldByName('proveedor').AsString;
    kmtSinFlete.FieldByName('nom_proveedor').AsString:= qrySinFlete.FieldByName('nom_proveedor').AsString;
    kmtSinFlete.FieldByName('productor').AsString:= qrySinFlete.FieldByName('productor').AsString;
    kmtSinFlete.FieldByName('nom_productor').AsString:= qrySinFlete.FieldByName('nom_productor').AsString;
    kmtSinFlete.Post;

    qrySinFlete.Next;
  end;
  qrySinFlete.Close;

  Result:= not kmtSinFlete.IsEmpty;
end;

function TDLLiquidaIncidencias.AddEntregasSinPrecioReal( const AProducto, AAnyoSemana: string ): Boolean;
begin
  if kmtSinPrecioReal.Active then
    kmtSinPrecioReal.Close;
  kmtSinPrecioReal.Open;

  qrySinPrecioReal.ParamByName('anyosemana').AsString:=  AAnyoSemana;
  qrySinPrecioReal.ParamByName('producto').AsString:=  AProducto;
  qrySinPrecioReal.Open;

  while not qrySinPrecioReal.Eof do
  begin
    kmtSinPrecioReal.Insert;
    kmtSinPrecioReal.FieldByName('empresa').AsString:= qrySinPrecioReal.FieldByName('empresa').AsString;
    kmtSinPrecioReal.FieldByName('proveedor').AsString:= qrySinPrecioReal.FieldByName('proveedor').AsString;
    kmtSinPrecioReal.FieldByName('nom_proveedor').AsString:= qrySinPrecioReal.FieldByName('nom_proveedor').AsString;
    kmtSinPrecioReal.FieldByName('anyosemana').AsString:= qrySinPrecioReal.FieldByName('anyosemana').AsString;
    kmtSinPrecioReal.FieldByName('producto').AsString:= qrySinPrecioReal.FieldByName('producto').AsString;
    kmtSinPrecioReal.FieldByName('categoria').AsString:= qrySinPrecioReal.FieldByName('categoria').AsString;
    kmtSinPrecioReal.FieldByName('variedad').AsString:= qrySinPrecioReal.FieldByName('variedad').AsString;
    kmtSinPrecioReal.Post;

    qrySinPrecioReal.Next;
  end;
  qrySinPrecioReal.Close;

  Result:= not kmtSinPrecioReal.IsEmpty;
end;

function TDLLiquidaIncidencias.AddSalidasSinValorar: Boolean;
begin
  if kmtSinValorar.Active then
    kmtSinValorar.Close;
  kmtSinValorar.Open;
  kmtDias.First;
  while not kmtDias.Eof do
  begin
    qrySinValorar.ParamByName('empresa').AsString:=  kmtDias.FieldByName('empresa').AsString;
    qrySinValorar.ParamByName('producto').AsString:=  kmtDias.FieldByName('producto').AsString;
    qrySinValorar.ParamByName('fecha').AsDateTime:=  kmtDias.FieldByName('fecha').AsDateTime;
    qrySinValorar.Open;

    while not qrySinValorar.Eof do
    begin
      kmtSinValorar.Insert;
      kmtSinValorar.FieldByName('empresa').AsString:= qrySinValorar.FieldByName('empresa').AsString;
      kmtSinValorar.FieldByName('centro').AsString:= qrySinValorar.FieldByName('centro').AsString;
      kmtSinValorar.FieldByName('albaran').AsInteger:= qrySinValorar.FieldByName('albaran').AsInteger;
      kmtSinValorar.FieldByName('fecha').AsDateTime:= qrySinValorar.FieldByName('fecha').AsDateTime;
      kmtSinValorar.FieldByName('cliente').AsString:= qrySinValorar.FieldByName('cliente').AsString;
      kmtSinValorar.FieldByName('nom_cliente').AsString:= qrySinValorar.FieldByName('nom_cliente').AsString;
      kmtSinValorar.Post;

      qrySinValorar.Next;
    end;
    qrySinValorar.Close;
    kmtDias.Next;
  end;
  Result:= not kmtSinValorar.IsEmpty;
end;

function TDLLiquidaIncidencias.AddSalidasSinGatosTransporte: Boolean;
begin
  if kmtSinPortes.Active then
    kmtSinPortes.Close;
  kmtSinPortes.Open;
  kmtDias.First;
  while not kmtDias.Eof do
  begin
    qrySinPortes.ParamByName('empresa').AsString:=  kmtDias.FieldByName('empresa').AsString;
    qrySinPortes.ParamByName('producto').AsString:=  kmtDias.FieldByName('producto').AsString;
    qrySinPortes.ParamByName('fecha').AsDateTime:=  kmtDias.FieldByName('fecha').AsDateTime;
    qrySinPortes.Open;

    while not qrySinPortes.Eof do
    begin
      kmtSinPortes.Insert;
      kmtSinPortes.FieldByName('empresa').AsString:= qrySinPortes.FieldByName('empresa').AsString;
      kmtSinPortes.FieldByName('centro').AsString:= qrySinPortes.FieldByName('centro').AsString;
      kmtSinPortes.FieldByName('albaran').AsInteger:= qrySinPortes.FieldByName('albaran').AsInteger;
      kmtSinPortes.FieldByName('fecha').AsDateTime:= qrySinPortes.FieldByName('fecha').AsDateTime;
      kmtSinPortes.FieldByName('cliente').AsString:= qrySinPortes.FieldByName('cliente').AsString;
      kmtSinPortes.FieldByName('nom_cliente').AsString:= qrySinPortes.FieldByName('nom_cliente').AsString;
      kmtSinPortes.Post;

      qrySinPortes.Next;
    end;
    qrySinPortes.Close;
    kmtDias.Next;
  end;
  Result:= not kmtSinPortes.IsEmpty;
end;

function TDLLiquidaIncidencias.AddEnvasesSinCoste: Boolean;
begin
  Result:= False;
end;

end.
