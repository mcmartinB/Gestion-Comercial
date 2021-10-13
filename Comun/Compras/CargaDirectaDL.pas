unit CargaDirectaDL;

interface

uses
  SysUtils, Classes, DBTables, DB, kbmMemTable;

type
  TDLCargaDirecta = class(TDataModule)
    kmtPreciosVentaCarga: TkbmMemTable;
    qryVenta: TQuery;
    qryCargasDirectas: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure PreparaTablaCargasDirectas( const AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega: string; const ATipo: integer );
    procedure PreparaTablaCargasDirectas_SinRF( const AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega: string; const ATipo: integer );
    procedure PreparaTablaCargasDirectas_ConRF( const AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega: string; const ATipo: integer );
    procedure TablasPreciosVentaCarga( const AOpen: Boolean );
    procedure ValorarCarga;
    procedure GetDatosVenta( var VEnvase, VCategoria: string; var VMedio, VMin, VMax: real; var VFacturado: Boolean );
    procedure GetPrecios( var VEnvase, VCategoria: string; var VMedio, VMin, VMax: real; var VFacturado: Boolean );
    function  GetStrRango( const AFechaIni, AFechaFin, ASemana, AEntrega: string; const ATipo: integer ): string;
  public
    { Public declarations }
    function  PreciosVentaCargaDirecta( const AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega: string; const ATipo: integer ): boolean;
  end;

implementation

{$R *.dfm}

uses
  UDMBaseDatos, Variants, bMath, Dialogs, UDMAuxDB, LiquidaValorarCargaDirectaQL;

procedure ConectarConBDAlmacen( const AEmpresa: string; var AQuery: TQuery );
var
  bAux: Boolean;
  sBD: string;
begin
  bAux:= AQuery.Active;
  if AQuery.Active then
    AQuery.Close;

  //if AEmpresa = 'BAG' or AEmpresa = 'BAG' then
  if AEmpresa = 'F42' then
  begin
   sBD:= 'BDProyecto';
  end;

  //DesconectarRemoto;
  if AEmpresa = 'F17' then
  begin
   if not DMBaseDatos.dbF17.Connected then
     DMBaseDatos.dbF17.Connected:= True;
   sBD:= 'dbF17';
  end
  else
  begin
    if DMBaseDatos.dbF17.Connected then
      DMBaseDatos.dbF17.Connected:= False;
  end;

  if AEmpresa = 'F18' then
  begin
   if not DMBaseDatos.dbF18.Connected then
     DMBaseDatos.dbF18.Connected:= True;
   sBD:= 'dbF18';
  end
  else
  begin
    if DMBaseDatos.dbF18.Connected then
      DMBaseDatos.dbF18.Connected:= False;
  end;

  (*
  if AEmpresa = 'F21' then
  begin
   if not DMBaseDatos.dbF21.Connected then
     DMBaseDatos.dbF21.Connected:= True;
   sBD:= 'dbF21';
  end
  else
  begin
    if DMBaseDatos.dbF21.Connected then
      DMBaseDatos.dbF21.Connected:= False;
  end;
  *)

  if AEmpresa = 'F23' then
  begin
   if not DMBaseDatos.dbF23.Connected then
     DMBaseDatos.dbF23.Connected:= True;
   sBD:= 'dbF23';
  end
  else
  begin
    if DMBaseDatos.dbF23.Connected then
      DMBaseDatos.dbF23.Connected:= False;
  end;

  (*
  if AEmpresa = 'F24' then
  begin
   if not DMBaseDatos.dbF24.Connected then
     DMBaseDatos.dbF24.Connected:= True;
   sBD:= 'dbF24';
  end
  else
  begin
    if DMBaseDatos.dbF24.Connected then
      DMBaseDatos.dbF24.Connected:= False;
  end;
  *)

  AQuery.DatabaseName:= sBD;
  if bAux then
    AQuery.Open;
end;

procedure TDLCargaDirecta.DataModuleCreate(Sender: TObject);
begin
  with qryVenta do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        n_factura_sc factura, envase_sl envase_alb, categoria_sl categoria_alb, ');
    SQL.Add('        sum(cajas_sl) cajas_alb, sum(kilos_sl) kilos_alb, sum(importe_neto_sl) importe_alb ');
    SQL.Add(' from frf_salidas_c  ');
    SQL.Add('      join frf_salidas_l on empresa_sl = empresa_sc and centro_salida_sl = centro_salida_sc ');
    SQL.Add('                         and n_albaran_sl = n_albaran_sc and fecha_sl = fecha_sc');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');
    SQL.Add(' and producto_sl = :producto ');
    SQL.Add(' group by  factura, envase_alb, categoria_alb ');
    SQL.Add(' order by  factura, envase_alb, categoria_alb ');
  end;
  qryVenta.Filtered:= True;


    kmtPreciosVentaCarga.FieldDefs.Clear;

    kmtPreciosVentaCarga.FieldDefs.Add('semana', ftString, 6, False);
    kmtPreciosVentaCarga.FieldDefs.Add('fecha_entrega', ftDateTime,0, False );
    kmtPreciosVentaCarga.FieldDefs.Add('entrega', ftString, 12, False);
    kmtPreciosVentaCarga.FieldDefs.Add('empresa', ftString, 3, False);
    kmtPreciosVentaCarga.FieldDefs.Add('proveedor', ftString, 3, False);
    kmtPreciosVentaCarga.FieldDefs.Add('almacen', ftString, 3, False);
    kmtPreciosVentaCarga.FieldDefs.Add('producto', ftString, 3, False);
    kmtPreciosVentaCarga.FieldDefs.Add('variedad', ftInteger, 0, False);
    kmtPreciosVentaCarga.FieldDefs.Add('ean', ftString, 13, False);
    kmtPreciosVentaCarga.FieldDefs.Add('envase', ftString, 9, False);
    kmtPreciosVentaCarga.FieldDefs.Add('categoria', ftString, 3, False);

    kmtPreciosVentaCarga.FieldDefs.Add('peso', ftFloat, 0, False);
    kmtPreciosVentaCarga.FieldDefs.Add('cajas', ftInteger, 0, False);
    kmtPreciosVentaCarga.FieldDefs.Add('orden', ftInteger, 0, False);
    kmtPreciosVentaCarga.FieldDefs.Add('fecha_carga', ftDateTime,0, False );
    kmtPreciosVentaCarga.FieldDefs.Add('tipo', ftString, 12, False);


    kmtPreciosVentaCarga.FieldDefs.Add('empresa_alb', ftString, 3, False);
    kmtPreciosVentaCarga.FieldDefs.Add('centro_alb', ftString, 1, False);
    kmtPreciosVentaCarga.FieldDefs.Add('albaran', ftInteger, 0, False);
    kmtPreciosVentaCarga.FieldDefs.Add('fecha_alb', ftDate, 0, False);
    kmtPreciosVentaCarga.FieldDefs.Add('cliente_alb', ftString, 3, False);
    kmtPreciosVentaCarga.FieldDefs.Add('sum_alb', ftString, 3, False);
    kmtPreciosVentaCarga.FieldDefs.Add('envase_alb', ftString, 15, False);
    kmtPreciosVentaCarga.FieldDefs.Add('categoria_alb', ftString, 15, False);

    kmtPreciosVentaCarga.FieldDefs.Add('precio_medio', ftFloat, 0, False);
    kmtPreciosVentaCarga.FieldDefs.Add('precio_min', ftFloat, 0, False);
    kmtPreciosVentaCarga.FieldDefs.Add('precio_max', ftFloat, 0, False);

    kmtPreciosVentaCarga.IndexFieldNames:= 'semana;empresa;producto;proveedor;almacen;entrega;albaran;variedad';
    kmtPreciosVentaCarga.CreateTable;
end;

procedure TDLCargaDirecta.TablasPreciosVentaCarga( const AOpen: Boolean );
begin
  if AOpen then
  begin
    kmtPreciosVentaCarga.Open;
  end
  else
  begin
    kmtPreciosVentaCarga.Close;
  end;
end;


procedure TDLCargaDirecta.PreparaTablaCargasDirectas( const AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega: string; const ATipo: integer );
begin
  if AEmpresa = 'F42' then
    PreparaTablaCargasDirectas_SinRF( AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega, ATipo )
  else
    PreparaTablaCargasDirectas_ConRF( AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega, ATipo );
end;

procedure TDLCargaDirecta.PreparaTablaCargasDirectas_SinRF( const AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega: string; const ATipo: integer );
begin
  with qryCargasDirectas do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        anyo_semana_ec semana, fecha_carga_ec fecha_entrega, codigo_ec entrega, empresa_ec empresa, ');
    SQL.Add('        proveedor_ec proveedor, proveedor_el almacen, producto_el producto, ');
    SQL.Add('        variedad_el variedad, codigo_ean_pp ean, max(envase_e) envase, categoria_el categoria ');
    SQL.Add('        ,fecha_sl fecha_carga, sum(kilos_sl) peso, sum(cajas_sl) cajas, 0 orden ');
    SQL.Add('        ,empresa_sl empresa_alb, centro_salida_sl centro_alb, n_albaran_sl albaran, fecha_sl fecha_alb ');
    SQL.Add('        ,cliente_sl cliente_alb, cliente_sl sum_alb, 1 tipo ');

    SQL.Add(' from frf_entregas_c ');
    SQL.Add('      join frf_entregas_l on codigo_ec = codigo_el ');
    SQL.Add('      join frf_productos_proveedor on proveedor_ec = proveedor_pp ');
    SQL.Add('                                   and producto_el = producto_pp and variedad_el = variedad_pp ');
    SQL.Add('      left join frf_ean13 on codigo_ean_pp = codigo_e ');
    SQL.Add('      left join frf_salidas_l on entrega_sl = codigo_ec and producto_sl = producto_el ');

    SQL.Add(' where empresa_ec = :planta ');
    SQL.Add(' and producto_ec = :producto ');

    if ATipo = 1 then
      //SQL.Add(' and fecha_sl between :fechaini and :fechafin ')
      SQL.Add(' and fecha_carga_ec between :fechaini and :fechafin ')
    else
    if ATipo = 2 then
      SQL.Add(' and anyo_semana_ec = :semana ')
    else
    if ATipo = 3 then
      SQL.Add(' and codigo_ec = :entrega ');

    if AProveedor <> '' then
      SQL.Add(' and proveedor = :proveedor ');
    if AProductor <> '' then
      SQL.Add(' and proveedor_almacen = :productor ');

    SQL.Add(' group by semana, fecha_entrega, entrega, empresa, proveedor, almacen, producto, variedad, ean, ');
    SQL.Add('         categoria, fecha_carga, orden, empresa_alb, centro_alb, ');
    SQL.Add('         albaran, fecha_alb, cliente_alb, sum_alb, tipo ');
    SQL.Add('  order by semana, entrega, variedad, categoria, fecha_carga, orden ');

    ParamByName('planta').AsString:= AEmpresa;
    ParamByName('producto').AsString:= AProducto;
    if AProveedor <> '' then
       ParamByName('proveedor').AsString:= AProveedor;
    if AProductor <> '' then
       ParamByName('productor').AsString:= AProductor;
    if ATipo = 1 then
    begin
      ParamByName('fechaini').AsDateTime:= StrToDate(AFechaIni);
      ParamByName('fechafin').AsDateTime:= StrToDate(AFechaFin);
    end
    else
    if ATipo = 2 then
    begin
      ParamByName('semana').AsString:= ASemana;
    end
    else
    if ATipo = 3 then
    begin
      ParamByName('entrega').AsString:= AEntrega;
    end;    
  end;
end;


procedure TDLCargaDirecta.PreparaTablaCargasDirectas_ConRF( const AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega: string; const ATipo: integer );
begin
  with qryCargasDirectas do
  begin
    SQL.Clear;
    SQL.Add(' select anyo_semana_ec semana, fecha_carga_ec fecha_entrega, entrega entrega, empresa empresa, ');
    SQL.Add('        proveedor proveedor, proveedor_almacen almacen, producto producto, ');
    SQL.Add('        variedad variedad, codigo_ean_pp ean, max(envase_e) envase, categoria categoria, ');
    SQL.Add('        date(fecha_status) fecha_carga, sum(peso) peso, sum(cajas) cajas, orden_carga orden, ');
    SQL.Add('        empresa_occ empresa_alb, centro_salida_occ centro_alb, n_albaran_occ albaran, fecha_occ fecha_alb, ');
    SQL.Add('        cliente_sal_occ cliente_alb, dir_sum_occ sum_alb, traspasada_occ tipo ');

    SQL.Add(' from rf_palet_pb ');
    SQL.Add('      left join frf_orden_carga_c on orden_carga = orden_occ ');
    SQL.Add('      left join frf_productos_proveedor on proveedor = proveedor_pp ');
    SQL.Add('                                   and producto = producto_pp and variedad = variedad_pp ');
    SQL.Add('      left join frf_ean13 on codigo_ean_pp = codigo_e ');
    SQL.Add('      join frf_entregas_c on entrega = codigo_ec ');
    //if ATipo = 2 then
      //SQL.Add(' join frf_entregas_c on entrega = codigo_ec and anyo_semana_ec = :semana ');

    SQL.Add(' where status = ''C'' ');
    SQL.Add(' and empresa = :planta ');
    SQL.Add(' and producto = :producto ');

    if ATipo = 1 then
      //SQL.Add(' and date(fecha_status) between :fechaini and :fechafin ')
      SQL.Add(' and fecha_carga_ec between :fechaini and :fechafin ')
    else
    if ATipo = 2 then
      SQL.Add(' and anyo_semana_ec = :semana ')
    else
    if ATipo = 3 then
      SQL.Add(' and entrega = :entrega ');

    if AProveedor <> '' then
      SQL.Add(' and proveedor = :proveedor ');
    if AProductor <> '' then
      SQL.Add(' and proveedor_almacen = :productor ');

    SQL.Add(' group by semana, fecha_entrega, entrega, empresa, proveedor, almacen, producto, variedad, ean,  ');
    SQL.Add('        categoria, fecha_carga, orden, empresa_alb, centro_alb, ');
    SQL.Add('        albaran, fecha_alb, cliente_alb, sum_alb, tipo ');
    SQL.Add(' order by semana, entrega, variedad, categoria, fecha_carga, orden ');


    ParamByName('planta').AsString:= AEmpresa;
    ParamByName('producto').AsString:= AProducto;
    if AProveedor <> '' then
       ParamByName('proveedor').AsString:= AProveedor;
    if AProductor <> '' then
       ParamByName('productor').AsString:= AProductor;
    if ATipo = 1 then
    begin
      ParamByName('fechaini').AsDateTime:= StrToDate(AFechaIni);
      ParamByName('fechafin').AsDateTime:= StrToDate(AFechaFin);
    end
    else
    if ATipo = 2 then
    begin
      ParamByName('semana').AsString:= ASemana;
    end
    else
    if ATipo = 3 then
    begin
      ParamByName('entrega').AsString:= AEntrega;
    end;
  end;
end;

function AddStrList( const AList, AItem: string ): string;
begin
  if AList = '' then
    result:= AItem
  else
  begin
    if Pos(AItem, AList ) = 0 then
      result:= AList + ',' + AItem
    else
      Result:= AList;
  end
end;

procedure TDLCargaDirecta.GetPrecios( var VEnvase, VCategoria: string; var VMedio, VMin, VMax: real; var VFacturado: Boolean );
var
  rKilos, rImporte, rPrecio: Real;
begin
  VEnvase:= '';
  VCategoria:= '';
  VMedio:= 0;
  VMin:= 0;
  VMax:= 0;
  rKilos:= 0;
  rImporte:= 0;

  qryVenta.First;
  VFacturado:= qryVenta.fieldByName('factura').AsString <> '';
  while not qryVenta.eof do
  begin
    VEnvase:= AddStrList( VEnvase, qryVenta.fieldByName('envase_alb').AsString );
    VCategoria:= AddStrList( VCategoria, qryVenta.fieldByName('categoria_alb').AsString );
    rKilos:= rKilos + qryVenta.fieldByName('kilos_alb').AsFloat;
    rImporte:= rImporte + qryVenta.fieldByName('importe_alb').AsFloat;
    if qryVenta.fieldByName('kilos_alb').AsFloat <> 0 then
    begin
      rPrecio:= bRoundTo( qryVenta.fieldByName('importe_alb').AsFloat / qryVenta.fieldByName('kilos_alb').AsFloat, 3 );
      if rPrecio > VMax then
        VMax:= rPrecio;
      if VMin = 0 then
        VMin:= rPrecio
      else
      if rPrecio < VMin  then
        VMin:= rPrecio;
    end;
    if rKilos > 0 then
      VMedio:= bRoundTo( rImporte / rKilos, 3);
    qryVenta.Next;
  end;
end;

procedure TDLCargaDirecta.GetDatosVenta( var VEnvase, VCategoria: string; var VMedio, VMin, VMax: real; var VFacturado: Boolean  );
begin
  qryVenta.Filter:= '';
  qryVenta.ParamByName('empresa').AsString:= qryCargasDirectas.fieldByName('empresa_alb').AsString;
  qryVenta.ParamByName('centro').AsString:= qryCargasDirectas.fieldByName('centro_alb').AsString;
  qryVenta.ParamByName('albaran').AsInteger:= qryCargasDirectas.fieldByName('albaran').AsInteger;
  qryVenta.ParamByName('fecha').AsDateTime:= qryCargasDirectas.fieldByName('fecha_alb').AsDateTime;
  qryVenta.ParamByName('producto').AsString:= qryCargasDirectas.fieldByName('producto').AsString;
  qryVenta.Open;
  if qryVenta.IsEmpty then
  begin
    VMedio:= 0;
    VMin:= 0;
    VMax:= 0;
  end
  else
  begin
    //Envase-categoria
    qryVenta.Filter:= 'envase_alb = ' + QuotedStr( qryCargasDirectas.fieldByName('envase').AsString ) +
                      ' and categoria_alb = '  + QuotedStr( qryCargasDirectas.fieldByName('categoria').AsString );
    if qryVenta.IsEmpty then
    begin
      //Envase
      qryVenta.Filter:= 'envase_alb = ' + QuotedStr( qryCargasDirectas.fieldByName('envase').AsString );
      if qryVenta.IsEmpty then
      begin
        //categoria
        qryVenta.Filter:= 'categoria_alb = ' + QuotedStr( qryCargasDirectas.fieldByName('categoria').AsString );
        if qryVenta.IsEmpty then
        begin
          //Placero
          qryVenta.Filter:= 'categoria_alb = ' + QuotedStr( '3' );
          if qryVenta.IsEmpty then
          begin
            //Nada
            qryVenta.Filter:= '';
          end;
        end;
      end;
    end;
    GetPrecios( VEnvase, VCategoria, VMedio, VMin, VMax, VFacturado );
  end;
  qryVenta.Close;
end;

procedure TDLCargaDirecta.ValorarCarga;
var
  sEnvase, sCategoria: string;
  rMedio, rMin, rMax: real;
  bFacturado: Boolean;
begin
  kmtPreciosVentaCarga.Insert;
  kmtPreciosVentaCarga.FieldByName('semana').AsString:= qryCargasDirectas.fieldByName('semana').AsString;
  kmtPreciosVentaCarga.FieldByName('fecha_entrega').AsDateTime:= qryCargasDirectas.fieldByName('fecha_entrega').AsDateTime;
  kmtPreciosVentaCarga.FieldByName('entrega').AsString:= qryCargasDirectas.fieldByName('entrega').AsString;
  kmtPreciosVentaCarga.FieldByName('empresa').AsString:= qryCargasDirectas.fieldByName('empresa').AsString;
  kmtPreciosVentaCarga.FieldByName('proveedor').AsString:= qryCargasDirectas.fieldByName('proveedor').AsString;
  kmtPreciosVentaCarga.FieldByName('almacen').AsString:= qryCargasDirectas.fieldByName('almacen').AsString;
  kmtPreciosVentaCarga.FieldByName('producto').AsString:= qryCargasDirectas.fieldByName('producto').AsString;
  kmtPreciosVentaCarga.FieldByName('variedad').AsInteger:= qryCargasDirectas.fieldByName('variedad').AsInteger;
  kmtPreciosVentaCarga.FieldByName('ean').AsString:= qryCargasDirectas.fieldByName('ean').AsString;
  kmtPreciosVentaCarga.FieldByName('envase').AsString:= qryCargasDirectas.fieldByName('envase').AsString;
  kmtPreciosVentaCarga.FieldByName('categoria').AsString:= qryCargasDirectas.fieldByName('categoria').AsString;

  kmtPreciosVentaCarga.FieldByName('peso').AsFloat:= qryCargasDirectas.fieldByName('peso').AsFloat;
  kmtPreciosVentaCarga.FieldByName('cajas').AsInteger:= qryCargasDirectas.fieldByName('cajas').AsInteger;
  kmtPreciosVentaCarga.FieldByName('orden').AsInteger:= qryCargasDirectas.fieldByName('orden').AsInteger;
  kmtPreciosVentaCarga.FieldByName('fecha_carga').AsDateTime:= qryCargasDirectas.fieldByName('fecha_carga').AsDateTime;
  if qryCargasDirectas.fieldByName('tipo').AsInteger = 0 then
    kmtPreciosVentaCarga.FieldByName('tipo').AsString:= 'OdenCarga'
  else
  if qryCargasDirectas.fieldByName('tipo').AsInteger = 1 then
    kmtPreciosVentaCarga.FieldByName('tipo').AsString:= 'Venta'
  else
  if qryCargasDirectas.fieldByName('tipo').AsInteger = 2 then
    kmtPreciosVentaCarga.FieldByName('tipo').AsString:= 'Transito';


  kmtPreciosVentaCarga.FieldByName('empresa_alb').AsString:= qryCargasDirectas.fieldByName('empresa_alb').AsString;
  kmtPreciosVentaCarga.FieldByName('centro_alb').AsString:= qryCargasDirectas.fieldByName('centro_alb').AsString;
  kmtPreciosVentaCarga.FieldByName('albaran').AsInteger:= qryCargasDirectas.fieldByName('albaran').AsInteger;
  kmtPreciosVentaCarga.FieldByName('fecha_alb').AsDateTime:= qryCargasDirectas.fieldByName('fecha_alb').AsDateTime;
  kmtPreciosVentaCarga.FieldByName('cliente_alb').AsString:= qryCargasDirectas.fieldByName('cliente_alb').AsString;
  kmtPreciosVentaCarga.FieldByName('sum_alb').AsString:= qryCargasDirectas.fieldByName('sum_alb').AsString;

  if qryCargasDirectas.fieldByName('tipo').AsInteger = 1 then
  begin
    GetDatosVenta( sEnvase, sCategoria, rMedio, rMin, rMax, bFacturado );
    if bFacturado then
      kmtPreciosVentaCarga.FieldByName('tipo').AsString:= 'Facturado';
    kmtPreciosVentaCarga.FieldByName('envase_alb').AsString:= sEnvase;
    kmtPreciosVentaCarga.FieldByName('categoria_alb').AsString:= sCategoria;
    kmtPreciosVentaCarga.FieldByName('precio_medio').AsFloat:= rMedio;
    kmtPreciosVentaCarga.FieldByName('precio_min').AsFloat:= rMin;
    kmtPreciosVentaCarga.FieldByName('precio_max').AsFloat:= rMax;
  end
  else
  begin
    kmtPreciosVentaCarga.FieldByName('envase_alb').AsString:= '';
    kmtPreciosVentaCarga.FieldByName('categoria_alb').AsString:= '';
    kmtPreciosVentaCarga.FieldByName('precio_medio').AsFloat:= 0;
    kmtPreciosVentaCarga.FieldByName('precio_min').AsFloat:= 0;
    kmtPreciosVentaCarga.FieldByName('precio_max').AsFloat:= 0;
  end;

  kmtPreciosVentaCarga.Post;
end;

function TDLCargaDirecta.GetStrRango( const AFechaIni, AFechaFin, ASemana, AEntrega: string; const ATipo: integer ): string;
begin
  if ATipo = 1 then
    Result:= 'Carga entrega del ' + QuotedStr( AFechaIni ) + ' al ' + QuotedStr( AFechaFin )
  else
  if ATipo = 1 then
    Result:= 'Año/Semana entrega: ' + ASemana
  else
  if ATipo = 1 then
    Result:= 'Entrega nº: ' + ASemana
  else
    Result:= '';
end;

function TDLCargaDirecta.PreciosVentaCargaDirecta( const AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega: string; const ATipo: integer ): boolean;
var
  sProducto, sRango: string;
begin
  ConectarConBDAlmacen( AEmpresa, qryCargasDirectas );
  PreparaTablaCargasDirectas( AEmpresa, AProducto, AProveedor, AProductor, AFechaIni, AFechaFin, ASemana, AEntrega, ATipo );
  qryCargasDirectas.Open;
  result:= not qryCargasDirectas.IsEmpty;

  if Result then
  begin
    TablasPreciosVentaCarga( True );
    while not qryCargasDirectas.Eof do
    begin
      ValorarCarga;
      qryCargasDirectas.Next;
    end;
    try
      kmtPreciosVentaCarga.SortFields:= 'semana;empresa;producto;proveedor;almacen;entrega;albaran;variedad';
      kmtPreciosVentaCarga.Sort([]);
      sProducto:= AProducto + desProducto( AEmpresa, AProducto );
      sRango:= GetStrRango( AFechaIni, AFechaFin, ASemana, AEntrega, ATipo );
      LiquidaValorarCargaDirectaQL.PrevisualizarPreciosCarga( sProducto, sRango );
    finally
      qryCargasDirectas.Close;
      TablasPreciosVentaCarga( False );
    end;
  end
  else
  begin
    qryCargasDirectas.Close;
  end;
end;

end.
