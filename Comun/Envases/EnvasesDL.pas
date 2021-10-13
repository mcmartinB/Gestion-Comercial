unit EnvasesDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLEnvases = class(TDataModule)
    qryEnvase: TQuery;
    qryEnvaseClientes: TQuery;
    qryEan13: TQuery;
  private
    { Private declarations }
    function OpenData( const AEnvase, AProducto: string ): Boolean;
    procedure PreviewFicha( const AEnvase, AProducto: string );
    procedure CloseData;

  public
    { Public declarations }

  end;

  function ShowFichaEnvase( const AOwner: TComponent; const AEnvase, AProducto: string ): Boolean;

implementation

uses
  EnvasesRL, DPreview;

{$R *.dfm}


function ShowFichaEnvase( const AOwner: TComponent; const AEnvase, AProducto: string ): Boolean;
var
  DLEnvases: TDLEnvases;
begin
  DLEnvases:= TDLEnvases.Create( AOwner );
  try
    Result:= DLEnvases.Opendata( AEnvase, Aproducto );
    if Result then
      DLEnvases.PreviewFicha( AEnvase, Aproducto );
    DLEnvases.CloseData;
  finally
    FreeAndNil( DLEnvases );
  end;
end;

procedure TDLEnvases.CloseData;
begin
  if qryEnvase.Active then
    qryEnvase.Close;
  if qryEnvaseClientes.Active then
    qryEnvaseClientes.Close;
  if qryEan13.Active then
    qryEan13.Close;
end;


function TDLEnvases.OpenData( const AEnvase, AProducto: string ): Boolean;
begin
  //
  with qryEnvase do
  begin
    SQL.Clear;
    SQL.Add(' select envase_e cod_envase, ');
    SQL.Add('   descripcion_e des_envase, ');
    SQL.Add('   descripcion2_e des_corta_envase, ');
    SQL.Add('   ean13_e ean13_envase, ');

    SQL.Add('   producto_e cod_producto, ');
    SQL.Add('    (select descripcion_p from frf_productos where producto_p = producto_e ) des_producto, ');
    SQL.Add('   nvl(peso_variable_e,1) peso_variable, ');
    SQL.Add('   nvl(peso_neto_e,0) neto_envase, ');
    SQL.Add('   nvl(peso_envase_e,0) peso_envase, ');

    SQL.Add('   master_e envase_maestro, ');
    SQL.Add('   nvl(agrupa_comercial_e,''FALTA'') agrupacion_comercial, ');

    SQL.Add('   nvl(agrupacion_e,''FALTA'') agrupacion, ');
    SQL.Add('   nvl(unidades_e,1) unidades, ');
    SQL.Add('   nvl(unidades_variable_e,0) unidades_variable, ');
    SQL.Add('   tipo_unidad_e cod_unidad, ');
    SQL.Add('      descripcion1_uc des_unidad, ');
    SQL.Add('      descripcion2_uc des_larga_unidad, ');
    SQL.Add('      ean13_uc ean13_unidad, ');
    SQL.Add('      peso_envase_uc peso_unidad, ');
    SQL.Add('      peso_producto_uc neto_unidad, ');

    SQL.Add('   env_comer_operador_e cod_operador, ');
    SQL.Add('     (select des_operador_eco from frf_env_comer_operadores where cod_operador_eco = env_comer_operador_e ) des_operador, ');
    SQL.Add('   env_comer_producto_e cod_env_operador, ');
    SQL.Add('     (select des_producto_ecp from frf_env_comer_productos where cod_operador_ecp = env_comer_operador_e and cod_producto_ecp = env_comer_producto_e ) des_env_operador, ');
    SQL.Add('   tipo_caja_e cod_tipo_caja, ');
    SQL.Add('     (select descripcion_tc from frf_tipos_caja where codigo_tc = tipo_caja_e ) des_tipo_caja, ');
    SQL.Add('   envase_comercial_e carton, ');
    SQL.Add('   notas_e notas, ');

    SQL.Add('   fecha_baja_e fecha_baja, ');
    SQL.Add('   tipo_iva_e cod_iva, ');
    SQL.Add('     (case when tipo_iva_e = 0 then ''SUPERREDUCIDO'' ');
    SQL.Add('           when tipo_iva_e = 1 then ''REDUCIDO'' ');
    SQL.Add('           when tipo_iva_e = 2 then ''GENERAL'' end ) des_iva, ');
    SQL.Add('   linea_producto_e cod_linea, ');
    SQL.Add('     (select descripcion_lp from frf_linea_productos where linea_producto_lp = linea_producto_e ) des_linea ');

    SQL.Add(' from frf_envases left join frf_und_consumo ');
    SQL.Add('                  on ( codigo_uc = tipo_unidad_e and  producto_uc = producto_e ) ');

    SQL.Add(' where envase_e = :envase ');
    SQL.Add(' and ( producto_e = :producto  or producto_e is null ) ');

    ParamByName('envase').AsString:= AEnvase;
    ParamByName('producto').AsString := Aproducto;

    Open;

    if IsEmpty then
    begin
      result:= False;
    end
    else
    begin
      result:= True;
    end;
  end;

  if Result then
  begin
    qryEnvaseClientes.SQL.Clear;
    qryEnvaseClientes.SQL.Add(' select cliente_ce, nombre_c, ');
    qryEnvaseClientes.SQL.Add('        descripcion_ce, ');
    qryEnvaseClientes.SQL.Add('        case when unidad_fac_ce = ''K'' then ''KGS'' ');
    qryEnvaseClientes.SQL.Add('             when unidad_fac_ce = ''C'' then ''CAJAS'' ');
    qryEnvaseClientes.SQL.Add('             when unidad_fac_ce = ''U'' then ''UNIDADES'' ');
    qryEnvaseClientes.SQL.Add('             else ''ERROR'' end unidad_fac_ce, ');
    qryEnvaseClientes.SQL.Add('        caducidad_cliente_ce, min_vida_cliente_ce, max_vida_cliente_ce, ');
    qryEnvaseClientes.SQL.Add('        n_palets_ce, kgs_palet_ce ');
    qryEnvaseClientes.SQL.Add(' from frf_clientes_env ');
    qryEnvaseClientes.SQL.Add('      join frf_clientes on cliente_ce = cliente_c ');
    qryEnvaseClientes.SQL.Add(' where envase_ce = :envase ');
    qryEnvaseClientes.SQL.Add(' order by cliente_ce ');
    qryEnvaseClientes.ParamByName('envase').AsString:= AEnvase;
    qryEnvaseClientes.Open;


    qryEan13.SQL.Clear;
    qryEan13.SQL.Add(' select ');
    qryEan13.SQL.Add('   codigo_e, ');
    qryEan13.SQL.Add('   ean14_e, ');
    qryEan13.SQL.Add('   descripcion_e, ');
    qryEan13.SQL.Add('   marca_e, ');
    qryEan13.SQL.Add('   categoria_e, ');
    qryEan13.SQL.Add('   calibre_e, ');
    qryEan13.SQL.Add('   fecha_baja_e, ');
    qryEan13.SQL.Add('   descripcion2_e ');

    qryEan13.SQL.Add(' from frf_ean13 ');
    qryEan13.SQL.Add(' where envase_e = :envase ');
    qryEan13.SQL.Add(' and agrupacion_e = 2 ');
    qryEan13.ParamByName('envase').AsString:= AEnvase;
    qryEan13.Open;
  end;
end;

procedure TDLEnvases.PreviewFicha( const AEnvase, AProducto: string );
var
  QRLEnvases: TRLEnvases;
begin
  try
    QRLEnvases:= TRLEnvases.Create( self );
    Preview( QRLEnvases );
  except
    FreeAndNil( QRLEnvases );
    raise;
  end;
end;


(*

//BORRAR ENVASES
  --peso_neto_und_e peso_neto_und, 
  --peso_envase_und_e peso_envase_und, 
  --cod_almacen_e cod_almacen, 
  --codigo_caja_e codigo_caja, 
  --texto_caja_e texto_caja, 
  --cantidad_cajas_e cantidad_cajas, 
  --c_envase_e c_envase,  
  --c_unidad_e c_unidad,  
  --c_reenvasado_e c_reenvasado, 
  --c_adicional_e c_adicional, 
  
//NO LISTAR
  --precio_diario_e precio_diario,


//BORRAR UNIDADES
   esliquido_uc

//NO SE USA --> ¿IMPLEMENTAR?
   peso_variable_uc,

*)

end.
