unit ValorarStockProveedorDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLValorarStockProveedor = class(TDataModule)
    qryListadoStock: TQuery;
    kmtStockValorado: TkbmMemTable;
    kmtGastos: TkbmMemTable;
    qryKilosEntrega: TQuery;
    qryGastosEntrega: TQuery;
    dsDetalle: TDataSource;
    kmtDetStockValorado: TkbmMemTable;
    qryPrevision: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    
  private
    { Private declarations }
    iCodCab: Integer;

    procedure MontaTablaListado( const AFecha: TDateTime );
    procedure AnyadeRegistro( const APrecioEntrega, APrecioTransito: Real );
    procedure AltaPalet( const ACodigo: Integer; const APrecioEntrega, APrecioTransito: Real );
    procedure PreparaQueryStockActual( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                                      const AProducto, AEntrega, AProveedor, AVariedad, ACalibre: string );
    //function  EstaEnOrigen( const AEmpresa, ASscc: String; const AFecha: TDateTime ): boolean;

    procedure CosteFruta( const AEntrega, AProducto: string; const AFecha: TDateTime; var VCosteEntrega, VCosteTransito: Real );

    function  GetCosteFrutaAux( const AEntrega, AProducto: string; var VCosteEntrega, VCosteTransito: Real ): boolean;
    procedure PutCosteFrutaAux( const AEntrega, AProducto: string; const ACosteEntrega, ACosteTransito: Real );
    procedure CalcularCosteFruta( const AFecha: TDateTime; var VCosteEntrega, VCosteTransito: Real );
    function  PrevisionCoste( const AFecha: TDateTime): Real;

  public
    { Public declarations }
    function DatosQueryStock( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                              const AProducto, AEntrega, AProveedor, AVariedad, ACalibre: string ): boolean;
  end;

implementation

{$R *.dfm}

uses variants, UDMConfig, bMath, Dialogs;

procedure TDLValorarStockProveedor.DataModuleCreate(Sender: TObject);
begin
  kmtStockValorado.FieldDefs.Clear;
  kmtStockValorado.FieldDefs.Add('empresa', ftString, 3, False);
  kmtStockValorado.FieldDefs.Add('producto', ftString, 3, False);
  kmtStockValorado.FieldDefs.Add('centro', ftString, 1, False);
  kmtStockValorado.FieldDefs.Add('entrega', ftString, 12, False);
  kmtStockValorado.FieldDefs.Add('origen', ftString, 3, False);
  kmtStockValorado.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtStockValorado.FieldDefs.Add('almacen', ftInteger, 0, False);
  kmtStockValorado.FieldDefs.Add('codigo_cab', ftInteger, 0, False);

  kmtStockValorado.FieldDefs.Add('kilos_c', ftFloat, 0, False);
  kmtStockValorado.FieldDefs.Add('cajas_c', ftInteger, 0, False);
  kmtStockValorado.FieldDefs.Add('coste_entrega_c', ftFloat, 0, False);
  kmtStockValorado.FieldDefs.Add('coste_transito_c', ftFloat, 0, False);

  kmtStockValorado.IndexFieldNames:= 'empresa;producto;entrega';
  kmtStockValorado.CreateTable;
  kmtStockValorado.Open;

  kmtDetStockValorado.FieldDefs.Clear;
  kmtDetStockValorado.FieldDefs.Add('codigo_det', ftInteger, 0, False);

  kmtDetStockValorado.FieldDefs.Add('sscc', ftString, 20, False);
  kmtDetStockValorado.FieldDefs.Add('variedad', ftString, 3, False);
  kmtDetStockValorado.FieldDefs.Add('calibre', ftString, 6, False);
  kmtDetStockValorado.FieldDefs.Add('lote', ftString, 20, False);
  kmtDetStockValorado.FieldDefs.Add('fecha_alta', ftDatetime, 0, False);
  kmtDetStockValorado.FieldDefs.Add('status', ftString, 3, False);
  kmtDetStockValorado.FieldDefs.Add('fecha_status', ftDatetime, 0, False);

  kmtDetStockValorado.FieldDefs.Add('linea_volcado', ftInteger, 0, False);
  kmtDetStockValorado.FieldDefs.Add('cajas_d', ftInteger, 0, False);
  kmtDetStockValorado.FieldDefs.Add('kilos_d', ftFloat, 0, False);
  kmtDetStockValorado.FieldDefs.Add('coste_entrada_d', ftFloat, 0, False);
  kmtDetStockValorado.FieldDefs.Add('coste_transito_d', ftFloat, 0, False);

  kmtDetStockValorado.IndexFieldNames:= 'codigo_det;sscc';
  kmtDetStockValorado.CreateTable;
  kmtDetStockValorado.Open;

  kmtGastos.FieldDefs.Clear;
  kmtGastos.FieldDefs.Add('entrega', ftString, 12, False);
  kmtGastos.FieldDefs.Add('producto', ftString, 3, False);
  kmtGastos.FieldDefs.Add('precio_entrega', ftFloat, 0, False);
  kmtGastos.FieldDefs.Add('precio_transito', ftFloat, 0, False);
  kmtGastos.IndexFieldNames:= 'entrega;producto';
  kmtGastos.CreateTable;
  kmtGastos.Open;

  with qryKilosEntrega do
  begin
    SQL.clear;
    SQL.Add(' select sum( case when empresa_apb = entrega_apb[1,3] then peso_apb else 0 end ) kilos_entrega, ');
    SQL.Add('        sum( case when empresa_apb = entrega_apb[1,3] then 0 else peso_apb end ) kilos_transito ');
    SQL.Add(' from  alm_palet_pb ');
    SQL.Add(' where entrega_apb = :entrega ');
//    SQL.Add(' and centro_apb = :centro ');
    SQL.Add(' and status_apb <> ''B'' ');
  end;

  (*TODO USARIMPORTELINEA*)
  with qryGastosEntrega do
  begin
    SQL.clear;
//    SQL.Add(' select sum( case when  ( tipo_ge = ''010''  ) then importe_ge else 0 end ) importe_compra, ');
//    SQL.Add('        sum( case when  ( tipo_ge <> ''010'' and tipo_ge <> ''070'' and tipo_ge <> ''080'' ) then importe_ge else 0 end ) importe_gastos, ');
//    SQL.Add('        sum( case when  ( tipo_ge = ''070'' or tipo_ge = ''080'' ) then importe_ge else 0 end ) importe_transito ');
    SQL.Add(' select sum( case when  ( tipo_ge = ''054''  ) then importe_ge else 0 end ) importe_compra, ');
    SQL.Add('        sum( case when  ( tipo_ge <> ''054'' and tipo_ge <> ''014'' and tipo_ge <> ''015'' ) then importe_ge else 0 end ) importe_gastos, ');
    SQL.Add('        sum( case when  ( tipo_ge = ''014'' or tipo_ge = ''015'' ) then importe_ge else 0 end ) importe_transito ');
    SQL.Add(' from  frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :entrega ');
  end;
end;

procedure TDLValorarStockProveedor.PreparaQueryStockActual( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                          const AProducto, AEntrega, AProveedor, AVariedad, ACalibre: string );
var
  dIni, dFin: TDateTime;
begin
  with qryListadoStock do
  begin
    SQL.Clear;
    SQL.Add(' SELECT empresa_apb, centro_apb, entrega_apb, producto_apb, empresa_ec, proveedor_ec, '); //almacen_el, ');
    SQL.Add('        sscc_apb, variedad_apb, categoria_apb, calibre_apb, lote_apb, date(fecha_alta_apb) fecha_alta_apb, ');
    SQL.Add('        status_apb, fecha_apb fecha_status_apb, linea_volcado_apb, cajas_apb, peso_apb ');
    SQL.Add(' FROM alm_palet_pb left join frf_entregas_c on entrega_apb = codigo_ec ');


    SQL.Add(' WHERE  (   ((date(fecha_alta_apb) <= :fecha) AND (status_apb = ''S'')) ');
    SQL.Add('        OR  ((date(fecha_alta_apb) <= :fecha) AND (fecha_apb > :fecha))  )');

    SQL.Add(' and status_apb <> ''B'' ');

    if AEmpresa <> '' then
      SQL.Add(' AND empresa_apb = :empresa ');
    if ACentro <> '' then
      SQL.Add(' AND centro_apb = :centro ');
    if AProducto <> '' then
      SQL.Add('   AND producto_apb = :producto ');
    if AEntrega <> '' then
      SQL.Add('   AND entrega_apb = :entrega ');
    if AProveedor <> '' then
      SQL.Add('   AND proveedor_apb = :proveedor ');
    if AVariedad <> '' then
      SQL.Add('   AND variedad_apb = :variedad ');
    if ACalibre <> '' then
      SQL.Add('   AND calibre_apb = :calibre ');

    SQL.Add(' order by entrega_apb, sscc_apb, fecha_apb ');
  end;

  (*
  with qryStockEnOrigen do
  begin
    SQL.Clear;
    SQL.Add(' SELECT * ');
    SQL.Add(' FROM alm_palet_pb  ');

    SQL.Add(' WHERE  (   ((date(fecha_alta_apb) <= :fecha) AND (status_apb = ''S'')) ');
    SQL.Add('        OR  ((date(fecha_alta_apb) <= :fecha) AND (fecha_apb > :fecha))  )');
    SQL.Add(' and status_apb <> ''B'' ');
    SQL.Add(' AND empresa_apb = :empresa ');
    SQL.Add(' AND sscc_apb = :sscc ');
  end;
  *)

  with qryPrevision do
  begin
    SQL.Clear;
    SQL.Add(' select coste_primera_pcp, coste_extra_pcp, coste_super_pcp, coste_resto_pcp ');
    SQL.Add(' from frf_prev_costes_producto ');
    SQL.Add(' where empresa_pcp = :empresa ');
    SQL.Add(' and producto_pcp = :producto ');
    SQL.Add(' and :fecha between fecha_ini_pcp and nvl( fecha_fin_pcp, today ) ');
  end;

end;

function TDLValorarStockProveedor.DatosQueryStock( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                          const AProducto, AEntrega, AProveedor, AVariedad, ACalibre: string ): boolean;
begin
  PreparaQueryStockActual( AEmpresa, ACentro, AFEcha, AProducto, AEntrega,
                           AProveedor, AVariedad, ACalibre );
  with qryListadoStock do
  begin
    ParamByName('fecha').AsDateTime:= AFEcha;

    if AEmpresa <> '' then
      ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
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

    Open;

    if not IsEmpty then
    begin
      iCodCab:= 0;
      MontaTablaListado( AFecha );
      result:= True;
    end
    else
    begin
      result:= False;
    end;
  end;
end;

procedure TDLValorarStockProveedor.AltaPalet( const ACodigo: Integer; const APrecioEntrega, APrecioTransito: Real );
begin
  kmtDetStockValorado.Insert;
  kmtDetStockValorado.FieldByName('codigo_det').AsInteger:= ACodigo;

  kmtDetStockValorado.FieldByName('sscc').AsString:= qryListadoStock.FieldByName('sscc_apb').AsString;
  kmtDetStockValorado.FieldByName('variedad').AsString:= qryListadoStock.FieldByName('variedad_apb').AsString;
  kmtDetStockValorado.FieldByName('calibre').AsString:= qryListadoStock.FieldByName('calibre_apb').AsString;
  kmtDetStockValorado.FieldByName('lote').AsString:= qryListadoStock.FieldByName('lote_apb').AsString;
  kmtDetStockValorado.FieldByName('fecha_alta').AsDateTime:= qryListadoStock.FieldByName('fecha_alta_apb').AsDateTime;
  kmtDetStockValorado.FieldByName('status').AsString:= qryListadoStock.FieldByName('status_apb').AsString;;
  kmtDetStockValorado.FieldByName('fecha_status').AsDateTime:= qryListadoStock.FieldByName('fecha_status_apb').AsDateTime;
  kmtDetStockValorado.FieldByName('linea_volcado').AsInteger:= qryListadoStock.FieldByName('linea_volcado_apb').AsInteger;
  kmtDetStockValorado.FieldByName('cajas_d').AsInteger:= qryListadoStock.FieldByName('cajas_apb').AsInteger;
  kmtDetStockValorado.FieldByName('kilos_d').AsFloat:= qryListadoStock.FieldByName('peso_apb').AsFloat;
  kmtDetStockValorado.FieldByName('coste_entrada_d').AsFloat:= bRoundTo( ( qryListadoStock.FieldByName('peso_apb').AsFloat * APrecioEntrega ), 2);

  if qryListadoStock.FieldByName('empresa_apb').AsString <> qryListadoStock.FieldByName('empresa_ec').AsString then
  begin
    kmtDetStockValorado.FieldByName('coste_transito_d').AsFloat:=
      bRoundTo( ( qryListadoStock.FieldByName('peso_apb').AsFloat * APrecioTransito ), 2);
  end;


  kmtDetStockValorado.Post;
end;

procedure TDLValorarStockProveedor.AnyadeRegistro( const APrecioEntrega, APrecioTransito: Real );
var
  iCodAux: integer;
begin
  if kmtStockValorado.Locate( 'empresa;producto;centro;entrega;origen',
                               VarArrayOf( [qryListadoStock.FieldByName('empresa_apb').AsString,
                                            qryListadoStock.FieldByName('producto_apb').AsString,
                                            qryListadoStock.FieldByName('centro_apb').AsString,
                                            qryListadoStock.FieldByName('entrega_apb').AsString,
                                            qryListadoStock.FieldByName('empresa_ec').AsString] ), [] ) then
  begin
    iCodAux:= kmtStockValorado.FieldByName('codigo_cab').AsInteger;

    kmtStockValorado.Edit;

    kmtStockValorado.FieldByName('kilos_c').AsFloat:= kmtStockValorado.FieldByName('kilos_c').AsFloat +
                                                    qryListadoStock.FieldByName('peso_apb').AsFloat;
    kmtStockValorado.FieldByName('cajas_c').AsInteger:= kmtStockValorado.FieldByName('cajas_c').AsInteger +
                                                      qryListadoStock.FieldByName('cajas_apb').AsInteger;

    //Importe normal
    kmtStockValorado.FieldByName('coste_entrega_c').AsFloat:=
       kmtStockValorado.FieldByName('coste_entrega_c').AsFloat +
         bRoundTo( ( qryListadoStock.FieldByName('peso_apb').AsFloat * APrecioEntrega ), 2);

    //Importe transito
    if qryListadoStock.FieldByName('empresa_apb').AsString <> qryListadoStock.FieldByName('empresa_ec').AsString then
    begin
      kmtStockValorado.FieldByName('coste_transito_c').AsFloat:=
         kmtStockValorado.FieldByName('coste_transito_C').AsFloat +
           bRoundTo( ( qryListadoStock.FieldByName('peso_apb').AsFloat * APrecioTransito ), 2);
    end;
    kmtStockValorado.Post;
  end
  else
  begin
    inc( iCodCab );
    iCodAux:= iCodCab;

    kmtStockValorado.Insert;
    kmtStockValorado.FieldByName('codigo_cab').AsInteger:= iCodCab;

    kmtStockValorado.FieldByName('empresa').AsString:= qryListadoStock.FieldByName('empresa_apb').AsString;
    kmtStockValorado.FieldByName('producto').AsString:= qryListadoStock.FieldByName('producto_apb').AsString;
    kmtStockValorado.FieldByName('centro').AsString:= qryListadoStock.FieldByName('centro_apb').AsString;
    kmtStockValorado.FieldByName('entrega').AsString:= qryListadoStock.FieldByName('entrega_apb').AsString;
    kmtStockValorado.FieldByName('origen').AsString:= qryListadoStock.FieldByName('empresa_ec').AsString;
    kmtStockValorado.FieldByName('proveedor').AsString:= qryListadoStock.FieldByName('proveedor_ec').AsString;
    //kmtStockValorado.FieldByName('almacen').AsInteger:= qryListadoStock.FieldByName('almacen_el').AsInteger;
    kmtStockValorado.FieldByName('almacen').AsInteger:= 0;
    kmtStockValorado.FieldByName('kilos_c').AsFloat:= qryListadoStock.FieldByName('peso_apb').AsFloat;
    kmtStockValorado.FieldByName('cajas_c').AsInteger:= qryListadoStock.FieldByName('cajas_apb').AsInteger;
    //Importe normal
    kmtStockValorado.FieldByName('coste_entrega_c').AsFloat:= bRoundTo( ( qryListadoStock.FieldByName('peso_apb').AsFloat * APrecioEntrega ), 2);
    //Importe transito
    if qryListadoStock.FieldByName('empresa_apb').AsString <> qryListadoStock.FieldByName('empresa_ec').AsString then
    begin
      kmtStockValorado.FieldByName('coste_transito_c').AsFloat:= bRoundTo( ( qryListadoStock.FieldByName('peso_apb').AsFloat * APrecioTransito ), 2);
    end;
    kmtStockValorado.Post;
  end;

  AltaPalet( iCodAux, APrecioEntrega, APrecioTransito );
end;

(*
function  TDLValorarStockProveedor.EstaEnOrigen( const AEmpresa, ASscc: String; const AFecha: TDateTime ): boolean;
begin
  with qryStockEnOrigen do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('sscc').AsString:= ASscc;
    ParamByName('fecha').AsDateTime:= AFecha;
    Open;
    Result:= not IsEmpty;
    Close;
  end;
end;
*)

procedure TDLValorarStockProveedor.MontaTablaListado( const AFecha: TDateTime );
var
  rPrecioEntrega, rPrecioTransito: Real;
  //bFlag: Boolean;
  iDuplicados: Integer;
  sPalet: string;
begin
  qryListadoStock.First;
  iDuplicados:= 0;
  sPalet:= '';
  while not qryListadoStock.Eof do
  begin
    (*
      bFlag:= True;
    if qryListadoStock.FieldByName('empresa_apb').AsString <>
       qryListadoStock.FieldByName('empresa_ec').AsString then
    begin
      //TODO STOCKPROVEEDOR
      //Este palet proviene de un transito, comprobar que no estaba de stock en el origen
      bFlag:=  not EstaEnOrigen( qryListadoStock.FieldByName('empresa_ec').AsString,
                                 qryListadoStock.FieldByName('sscc_apb').AsString, AFecha );
    end;

    if bFlag  then
    begin
      //Si no esta duplicado lo insertamos,
      //no esta en stock el palet de origen
      CosteFruta( qryListadoStock.FieldByName('entrega_apb').AsString,
                  qryListadoStock.FieldByName('producto_apb').AsString,
                   AFecha, rPrecioEntrega, rPrecioTransito );
      AnyadeRegistro( rPrecioEntrega, rPrecioTransito );
    end

    *)
    if sPalet <> qryListadoStock.FieldByName('sscc_apb').AsString  then
    begin
      sPalet:= qryListadoStock.FieldByName('sscc_apb').AsString;
      //Si no esta duplicado lo insertamos,
      //no esta en stock el palet de origen, el que cambio antes de status, orden por status
      CosteFruta( qryListadoStock.FieldByName('entrega_apb').AsString,
                  qryListadoStock.FieldByName('producto_apb').AsString,
                   AFecha, rPrecioEntrega, rPrecioTransito );
      AnyadeRegistro( rPrecioEntrega, rPrecioTransito );
    end
    else
    begin
      Inc( iDuplicados );
    end;
    qryListadoStock.Next;
  end;
  qryListadoStock.Close;

  (*
  if iDuplicados > 0 then
  begin
    ShowMessage('Duplicados -> ' + IntToStr(iDuplicados) );
  end;
  *)

  kmtStockValorado.SortFields:= 'empresa;producto;entrega';
  kmtStockValorado.Sort([]);
  kmtStockValorado.First;

  kmtDetStockValorado.SortFields:= 'sscc';
  kmtDetStockValorado.Sort([]);
  kmtDetStockValorado.First;
end;

function TDLValorarStockProveedor.GetCosteFrutaAux( const AEntrega, AProducto: string;
                                              var VCosteEntrega, VCosteTransito: Real ): boolean;
begin
  if kmtGastos.Locate( 'entrega;producto', VarArrayOf( [AEntrega, AProducto] ), [] ) then
  begin
    VCosteEntrega:= kmtGastos.FieldByName('precio_entrega').AsFloat;
    VCosteTransito:= kmtGastos.FieldByName('precio_transito').AsFloat;
    Result:= True;
  end
  else
  begin
    Result:= False;
  end;
end;

procedure TDLValorarStockProveedor.PutCosteFrutaAux( const AEntrega, AProducto: string;
                                              const ACosteEntrega, ACosteTransito: Real );
begin
  kmtGastos.Insert;
  kmtGastos.FieldByName('entrega').AsString:= AEntrega;
  kmtGastos.FieldByName('producto').AsString:= AProducto;
  kmtGastos.FieldByName('precio_entrega').AsFloat:= ACosteEntrega;
  kmtGastos.FieldByName('precio_transito').AsFloat:= ACosteTransito;
  kmtGastos.Post;
end;

function TDLValorarStockProveedor.PrevisionCoste( const AFecha: TDateTime): Real;
begin
  qryPrevision.ParamByName('empresa').AsString:= qryListadoStock.FieldByName('empresa_apb').AsString;
  qryPrevision.ParamByName('producto').AsString:= qryListadoStock.FieldByName('producto_apb').AsString;
  qryPrevision.ParamByName('fecha').AsDateTime:= AFecha;
  qryPrevision.Open;
  if not qryPrevision.IsEmpty then
  begin
    if ( qryListadoStock.FieldByName('categoria_apb').AsString = '1' ) or ( qryListadoStock.FieldByName('categoria_apb').AsString = 'I' ) then
    begin
      Result:= qryPrevision.FieldByName('coste_primera_pcp').AsFloat;
    end
    else
    if ( qryListadoStock.FieldByName('categoria_apb').AsString = 'EX' ) then
    begin
      Result:= qryPrevision.FieldByName('coste_extra_pcp').AsFloat;
    end
    else
    if ( qryListadoStock.FieldByName('categoria_apb').AsString = 'SE' ) then
    begin
      Result:= qryPrevision.FieldByName('coste_super_pcp').AsFloat;
    end
    else
    begin
      Result:= qryPrevision.FieldByName('coste_resto_pcp').AsFloat;
    end;
  end
  else
  begin
    Result:= 0;
  end;
end;


procedure TDLValorarStockProveedor.CalcularCosteFruta( const AFecha: TDateTime; var VCosteEntrega, VCosteTransito: Real );
begin
  //valor por kilo sin tener en cuenta nada mas
  with qryKilosEntrega do
  begin
    ParamByName('entrega').AsString:= qryListadoStock.FieldByName('entrega_apb').AsString;
//    ParamByName('centro').AsString:= qryListadoStock.FieldByName('centro_apb').AsString;
    Open;
  end;

  with qryGastosEntrega do
  begin
    ParamByName('entrega').AsString:= qryListadoStock.FieldByName('entrega_apb').AsString;
    Open;
  end;

  if qryKilosEntrega.FieldByName('kilos_entrega').AsFloat > 0 then
  begin
    (*TODO USARIMPORTELINEA*)
    (*TODO USARPREVISIONTRANSPORTE*)
    if qryGastosEntrega.FieldByName('importe_compra').AsFloat = 0 then
    begin
      VCosteEntrega:= bRoundTo( ( qryGastosEntrega.FieldByName('importe_gastos').AsFloat )
                                /qryKilosEntrega.FieldByName('kilos_entrega').AsFloat, 3) + PrevisionCoste( AFecha );
    end
    else
    begin
      VCosteEntrega:= bRoundTo( ( qryGastosEntrega.FieldByName('importe_compra').AsFloat + qryGastosEntrega.FieldByName('importe_gastos').AsFloat )
                                /qryKilosEntrega.FieldByName('kilos_entrega').AsFloat, 3);
    end;
  end
  else
  begin
    VCosteEntrega:= 0;
  end;

  if qryKilosEntrega.FieldByName('kilos_transito').AsFloat > 0 then
  begin
    VCosteTransito:= bRoundTo( qryGastosEntrega.FieldByName('importe_transito').AsFloat /
                              qryKilosEntrega.FieldByName('kilos_transito').AsFloat, 3)
  end
  else
  begin
    VCosteTransito:= 0;
  end;
  qryKilosEntrega.Close;
  qryGastosEntrega.Close;
end;


procedure TDLValorarStockProveedor.CosteFruta( const AEntrega, AProducto: string; const AFecha: TDateTime;
                                              var VCosteEntrega, VCosteTransito: Real );
begin
  //Mirar a ver si ya los tenemos
  if not GetCosteFrutaAux( AEntrega, AProducto, VCosteEntrega, VCosteTransito ) then
  begin
    CalcularCosteFruta( AFecha, VCosteEntrega, VCosteTransito );
    PutCosteFrutaAux( AEntrega, AProducto, VCosteEntrega, VCosteTransito );
  end;
end;

end.
