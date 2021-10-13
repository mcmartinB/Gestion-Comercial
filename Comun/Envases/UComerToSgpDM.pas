unit UComerToSgpDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMComerToSgp = class(TDataModule)
    qryComercial: TQuery;
    qrySGP: TQuery;
    qrySGPAux: TQuery;
    qryComerAux: TQuery;
  private
    { Private declarations }
    sEmpresa, sCliente: string;
    sProducto, sEnvase: string;
    sCosechero, sPlantacion, sAnyoSemana: string;


    procedure  CerrarTablas;


    // ------------------------------------------------------------------------
    // PRODUCTOS
    // ------------------------------------------------------------------------
    procedure SQLProductos;
    function  OpenProductos: boolean;
    procedure CopiarProductoAlSGP;

    procedure PasarCategoriasProducto;
    procedure BorrarCategoriasProducto;
    procedure SQLCategoriasProducto;
    function  OpenCategoriasProducto: boolean;
    procedure CopiarCategoriasProductoAlSGP;

    procedure PasarCalibresProducto;
    procedure BorrarCalibresProducto;
    procedure SQLCalibresProducto;
    function  OpenCalibresProducto: boolean;
    procedure CopiarCalibresProductoAlSGP;

    procedure PasarColoresProducto;
    procedure BorrarColoresProducto;
    procedure SQLColoresProducto;
    function  OpenColoresProducto: boolean;
    procedure CopiarColoresProductoAlSGP;

    // ------------------------------------------------------------------------
    // CLIENTES
    // ------------------------------------------------------------------------
    procedure SQLClientes;
    function  OpenClientes( var VNuevo: boolean ): boolean;
    procedure CopiarClienteAlSGP( var ANuevo: boolean );


    procedure PasarDirSuministros;
    procedure SQLDirSuministros;
    function  OpenDirSuministros: boolean;
    procedure CopiarDirSuministroAlSGP( const MyQry: TQuery );

    // ------------------------------------------------------------------------
    // ENVASES
    // ------------------------------------------------------------------------
    procedure SQLEnvases;
    function  OpenEnvases( const AEmpresa: string; var VNuevo: boolean ): boolean;
    procedure CopiarEnvaseAlSGP( const AEmpresa: String; var ANuevo: boolean );

    procedure PasarEansEnvase;
    procedure BorrarEans;
    procedure SQLEans;
    function  OpenEANS: boolean;
    procedure CopiarEanAlSGP( const MyQry: TQuery; const AEan14: boolean );

    procedure PasarClientesEnvase;
    procedure SQLClientesEnvase;
    function  OpenClientesEnvase: boolean;
    procedure CopiarClienteEnvaseAlSGP;

    // ------------------------------------------------------------------------
    // PLANTACIONES
    // ------------------------------------------------------------------------
    procedure SQLPlantaciones;
    function  OpenPlantaciones( var VNuevo: boolean ): boolean;
    procedure CopiarPlantacionAlSGP( var ANuevo: boolean );

    procedure CopiarVariedad;

  public
    { Public declarations }

    function PasarProducto( const AEmpresa, AProducto: string ): boolean;
    function PasarCliente( const AEmpresa, ACliente: string ): boolean;
    function PasarEnvase( const AEmpresa, AEnvase: string ): boolean;
    function PasarPlantacion( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana:string ): boolean;
  end;

  function PasarProducto( const AEmpresa, AProducto: string ): boolean;
  function PasarCliente( const AEmpresa, ACliente: string ): boolean;
  function PasarEnvase( const AEmpresa, AEnvase: string ): boolean;
  function PasarPlantacion( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana: string ): boolean;


implementation

{$R *.dfm}

uses
  Forms, Dialogs, CVariables;

var
  DMComerToSgp: TDMComerToSgp;

function PasarProducto( const AEmpresa, AProducto: string ): boolean;
begin
  Application.CreateForm( TDMComerToSgp, DMComerToSgp );
  try
    result:= DMComerToSgp.PasarProducto( AEmpresa, AProducto );
  finally
    FreeAndNil( DMComerToSgp );
  end;
end;

function PasarCliente( const AEmpresa, ACliente: string ): boolean;
begin
  Application.CreateForm( TDMComerToSgp, DMComerToSgp );
  try
    result:= DMComerToSgp.PasarCliente( AEmpresa, ACliente );
  finally
    FreeAndNil( DMComerToSgp );
  end;
end;

function PasarEnvase( const AEmpresa, AEnvase: string ): boolean;
begin
  Application.CreateForm( TDMComerToSgp, DMComerToSgp );
  try
    result:= DMComerToSgp.PasarEnvase( AEmpresa, AEnvase );
  finally
    FreeAndNil( DMComerToSgp );
  end;
end;

function PasarPlantacion( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana: string ): boolean;
begin
  Application.CreateForm( TDMComerToSgp, DMComerToSgp );
  try
    result:= DMComerToSgp.PasarPlantacion( AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana );
  finally
    FreeAndNil( DMComerToSgp );
  end;
end;

procedure TDMComerToSgp.CerrarTablas;
begin
  qryComercial.Close;
  qryComerAux.Close;
  qrySGP.Close;
  qrySGPAux.Close;
end;

function TDMComerToSgp.PasarProducto( const AEmpresa, AProducto: string ): boolean;
begin
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  SQLProductos;
  if OpenProductos then
  begin
    CopiarProductoAlSGP;
    CerrarTablas;
    PasarCategoriasProducto;
    PasarCalibresProducto;
    PasarColoresProducto;
    Result:= True;
  end
  else
  begin
    Result:= True;
  end;
end;

procedure TDMComerToSgp.SQLProductos;
begin
  qryComercial.SQL.Clear;
  qryComercial.SQL.Add('select * from frf_productos where producto_p = :producto ');
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('select * from frf_productos where producto_p = :producto ');

  qryComerAux.SQL.Clear;
  qryComerAux.SQL.Add('select * from frf_productos where producto_basese_pb = :productobase ');
  qrySGPAux.SQL.Clear;
  qrySGPAux.SQL.Add('select * from frf_productos_base_master where empresa_pb = :empresa and producto_base_pb = :productobase ');
end;


function TDMComerToSgp.OpenProductos: boolean;
begin
  qryComercial.ParamByName('producto').AsString:= sProducto;
  qryComercial.Open;
  if not qryComercial.IsEmpty then
  begin
    Result:= True;

    qrySGP.ParamByName('empresa').AsString:= sEmpresa;
    qrySGP.ParamByName('producto').AsString:= sProducto;
    qrySGP.Open;

    qryComerAux.ParamByName('empresa').AsString:= sEmpresa;
    qryComerAux.ParamByName('productobase').AsInteger:= qryComercial.FieldByName('producto_base_p').AsInteger;
    qryComerAux.Open;

    qrySGPAux.ParamByName('empresa').AsString:= sEmpresa;
    qrySGPAux.ParamByName('productobase').AsInteger:= qryComercial.FieldByName('producto_base_p').AsInteger;
    qrySGPAux.Open;
  end
  else
  begin
    qryComercial.Close;
    Result:= False;
  end;
end;

procedure TDMComerToSgp.CopiarProductoAlSGP;
begin
  //Primero producto base
  if qrySGPAux.IsEmpty then
  begin
    qrySGPAux.Insert;
  end
  else
  begin
    qrySGPAux.Edit;
  end;
  qrySGPAux.FieldByName('empresa_pb').Value:= qryComerAux.FieldByName('empresa_pb').Value;
  qrySGPAux.FieldByName('producto_base_pb').Value:= qryComerAux.FieldByName('producto_base_pb').Value;
  qrySGPAux.FieldByName('descripcion_pb').Value:= qryComerAux.FieldByName('descripcion_pb').Value;
  qrySGPAux.Post;

  if qrySGP.IsEmpty then
  begin
    qrySGP.Insert;
  end
  else
  begin
    qrySGP.Edit;
  end;
  qrySGP.FieldByName('empresa_p').Value:= '050';
  qrySGP.FieldByName('producto_p').Value:= qryComercial.FieldByName('producto_p').Value;
  qrySGP.FieldByName('producto_base_p').Value:= qryComercial.FieldByName('producto_base_p').Value;
  qrySGP.FieldByName('descripcion_p').Value:= qryComercial.FieldByName('descripcion_p').Value;
  qrySGP.FieldByName('descripcion2_p').Value:= qryComercial.FieldByName('descripcion2_p').Value;
  qrySGP.FieldByName('estomate_p').Value:= qryComercial.FieldByName('estomate_p').Value;
  qrySGP.FieldByName('seccion_cont_p').Value:= qryComercial.FieldByName('seccion_cont_p').Value;
  qrySGP.Post;
end;

procedure TDMComerToSgp.PasarCategoriasProducto;
begin
  BorrarCategoriasProducto;
  SQLCategoriasProducto;
  if OpenCategoriasProducto then
  begin
    while not qryComercial.Eof DO
    begin
      CopiarCategoriasProductoAlSGP;
      qryComercial.Next;
    end;
    CerrarTablas;
  end;
end;

procedure TDMComerToSgp.BorrarCategoriasProducto;
begin
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('delete from Frf_categorias where empresa_c = :empresa and producto_c = :producto ');
  qrySGP.ParamByName('empresa').AsString:= sEmpresa;
  qrySGP.ParamByName('producto').AsString:= sProducto;
  qrySGP.ExecSQL;

end;

procedure TDMComerToSgp.SQLCategoriasProducto;
begin
  qryComercial.SQL.Clear;
  qryComercial.SQL.Add('select * from Frf_categorias where producto_c = :producto ');
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('select * from frf_categorias where empresa_c = :empresa and producto_c = :producto and categoria_c = :categoria  ');
end;

function  TDMComerToSgp.OpenCategoriasProducto: boolean;
begin
  qryComercial.ParamByName('empresa').AsString:= sEmpresa;
  qryComercial.ParamByName('producto').AsString:= sProducto;
  qryComercial.Open;
  if not qryComercial.IsEmpty then
  begin
    Result:= True;
  end
  else
  begin
    qryComercial.Close;
    Result:= False;
  end;
end;

procedure TDMComerToSgp.CopiarCategoriasProductoAlSGP;
begin
  qrySGP.ParamByName('empresa').AsString:= sEmpresa;
  qrySGP.ParamByName('producto').AsString:= sProducto;
  qrySGP.ParamByName('categoria').AsString:= qryComercial.FieldByName('categoria_c').AsString;
  qrySGP.Open;
  if qrySGP.IsEmpty then
  begin
    qrySGP.Insert;
  end
  else
  begin
    qrySGP.Edit;
  end;
  qrySGP.FieldByName('empresa_c').Value:= sEmpresa;
  qrySGP.FieldByName('producto_c').Value:= qryComercial.FieldByName('producto_c').Value;
  qrySGP.FieldByName('categoria_c').Value:= qryComercial.FieldByName('categoria_c').Value;
  qrySGP.FieldByName('descripcion_c').Value:= qryComercial.FieldByName('descripcion_c').Value;
  qrySGP.Post;
  qrySGP.Close;
end;

procedure TDMComerToSgp.PasarCalibresProducto;
begin
  BorrarCalibresProducto;
  SQLCalibresProducto;
  if OpenCalibresProducto then
  begin
    while not qryComercial.Eof DO
    begin
      CopiarCalibresProductoAlSGP;
      qryComercial.Next;
    end;
    CerrarTablas;
  end;
end;

procedure TDMComerToSgp.BorrarCalibresProducto;
begin
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('delete from frf_calibres where empresa_c = :empresa and producto_c = :producto ');
  qrySGP.ParamByName('empresa').AsString:= sEmpresa;
  qrySGP.ParamByName('producto').AsString:= sProducto;
  qrySGP.ExecSQL;

end;

procedure TDMComerToSgp.SQLCalibresProducto;
begin
  qryComercial.SQL.Clear;
  qryComercial.SQL.Add('select * from frf_calibres where producto_c = :producto ');
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('select * from frf_calibres where empresa_c = :empresa and producto_c = :producto and calibre_c = :calibre  ');
end;

function  TDMComerToSgp.OpenCalibresProducto: boolean;
begin
  qryComercial.ParamByName('producto').AsString:= sProducto;
  qryComercial.Open;
  if not qryComercial.IsEmpty then
  begin
    Result:= True;
  end
  else
  begin
    qryComercial.Close;
    Result:= False;
  end;
end;

procedure TDMComerToSgp.CopiarCalibresProductoAlSGP;
begin
  qrySGP.ParamByName('empresa').AsString:= sEmpresa;
  qrySGP.ParamByName('producto').AsString:= sProducto;
  qrySGP.ParamByName('calibre').AsString:= qryComercial.FieldByName('calibre_c').AsString;
  qrySGP.Open;
  if qrySGP.IsEmpty then
  begin
    qrySGP.Insert;
  end
  else
  begin
    qrySGP.Edit;
  end;
  qrySGP.FieldByName('empresa_c').Value:= qryComercial.FieldByName('empresa_c').Value;
  qrySGP.FieldByName('producto_c').Value:= qryComercial.FieldByName('producto_c').Value;
  qrySGP.FieldByName('calibre_c').Value:= qryComercial.FieldByName('calibre_c').Value;
  qrySGP.Post;
  qrySGP.Close;
end;

procedure TDMComerToSgp.PasarColoresProducto;
begin
  BorrarColoresProducto;
  SQLColoresProducto;
  if OpenColoresProducto then
  begin
    while not qryComercial.Eof DO
    begin
      CopiarColoresProductoAlSGP;
      qryComercial.Next;
    end;
    CerrarTablas;
  end;
end;

procedure TDMComerToSgp.BorrarColoresProducto;
begin
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('delete from Frf_Colores where empresa_c = :empresa and producto_c = :producto ');
  qrySGP.ParamByName('empresa').AsString:= sEmpresa;
  qrySGP.ParamByName('producto').AsString:= sProducto;
  qrySGP.ExecSQL;

end;

procedure TDMComerToSgp.SQLColoresProducto;
begin
  qryComercial.SQL.Clear;
  qryComercial.SQL.Add('select * from Frf_Colores where producto_c = :producto ');
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('select * from frf_Colores where empresa_c = :empresa and producto_c = :producto and color_c = :color  ');
end;

function  TDMComerToSgp.OpenColoresProducto: boolean;
begin
  qryComercial.ParamByName('producto').AsString:= sProducto;
  qryComercial.Open;
  if not qryComercial.IsEmpty then
  begin
    Result:= True;
  end
  else
  begin
    qryComercial.Close;
    Result:= False;
  end;
end;

procedure TDMComerToSgp.CopiarColoresProductoAlSGP;
begin
  qrySGP.ParamByName('empresa').AsString:= sEmpresa;
  qrySGP.ParamByName('producto').AsString:= sProducto;
  qrySGP.ParamByName('color').AsString:= qryComercial.FieldByName('color_c').AsString;
  qrySGP.Open;
  if qrySGP.IsEmpty then
  begin
    qrySGP.Insert;
  end
  else
  begin
    qrySGP.Edit;
  end;
  qrySGP.FieldByName('empresa_c').Value:= qryComercial.FieldByName('empresa_c').Value;
  qrySGP.FieldByName('producto_c').Value:= qryComercial.FieldByName('producto_c').Value;
  qrySGP.FieldByName('color_c').Value:= qryComercial.FieldByName('color_c').Value;
  qrySGP.FieldByName('descripcion_c').Value:= qryComercial.FieldByName('descripcion_c').Value;
  qrySGP.Post;
  qrySGP.Close;
end;


function TDMComerToSgp.PasarCliente( const AEmpresa, ACliente: string ): boolean;
var
  bNuevo: Boolean;
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  SQLClientes;
  if OpenClientes( bNuevo ) then
  begin
    CopiarClienteAlSGP( bNuevo );
    CerrarTablas;
    PasarDirSuministros;
    //PasarClientesEnvase;
    Result:= True;
  end
  else
  begin
    Result:= True;
  end;
end;

procedure TDMComerToSgp.SQLClientes;
begin
  qryComercial.SQL.Clear;
  qryComercial.SQL.Add(' select * from frf_clientes, outer(frf_clientes_tes), outer(frf_clientes_rie) ');
  qryComercial.SQL.Add('  where cliente_c = :cliente and empresa_ct = :empresa and cliente_ct = cliente_c ');
  qryComercial.SQL.Add('    and empresa_cr = :empresa and cliente_cr = cliente_c ');
  qryComercial.SQL.Add('    and fecha_fin_cr is null ');
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('select * from frf_clientes where empresa_c = :empresa and cliente_c = :cliente ');
end;

function TDMComerToSgp.OpenClientes( var VNuevo: boolean ): boolean;
begin
  qryComercial.ParamByName('empresa').AsString:= sEmpresa;
  qryComercial.ParamByName('cliente').AsString:= sCliente;
  qryComercial.Open;
  if not qryComercial.IsEmpty then
  begin
    Result:= True;
    qrySGP.ParamByName('empresa').AsString:= sEmpresa;
    qrySGP.ParamByName('cliente').AsString:= sCliente;
    qrySGP.Open;
    VNuevo:= qrySGP.IsEmpty;
  end
  else
  begin
    qryComercial.Close;
    Result:= False;
  end;
end;

procedure TDMComerToSgp.CopiarClienteAlSGP( var ANuevo: boolean );
begin
  if ANuevo then
  begin
    qrySGP.Insert;
  end
  else
  begin
    qrySGP.Edit;
  end;
  qrySGP.FieldByName('empresa_c').Value:= sEmpresa;
  qrySGP.FieldByName('cliente_c').Value:= qryComercial.FieldByName('cliente_c').Value;
  qrySGP.FieldByName('nombre_c').Value:= qryComercial.FieldByName('nombre_c').Value;
  qrySGP.FieldByName('tipo_via_c').Value:= qryComercial.FieldByName('tipo_via_c').Value;
  qrySGP.FieldByName('domicilio_c').Value:= qryComercial.FieldByName('domicilio_c').Value;
  qrySGP.FieldByName('poblacion_c').Value:= qryComercial.FieldByName('poblacion_c').Value;
  qrySGP.FieldByName('pais_c').Value:= qryComercial.FieldByName('pais_c').Value;
  qrySGP.FieldByName('es_comunitario_c').Value:= qryComercial.FieldByName('es_comunitario_c').Value;
  qrySGP.FieldByName('nif_c').Value:= qryComercial.FieldByName('nif_c').Value;
  qrySGP.FieldByName('telefono_c').Value:= qryComercial.FieldByName('telefono_c').Value;
  qrySGP.FieldByName('telefono2_c').Value:= qryComercial.FieldByName('telefono2_c').Value;
  qrySGP.FieldByName('fax_c').Value:= qryComercial.FieldByName('fax_c').Value;
  qrySGP.FieldByName('resp_compras_c').Value:= qryComercial.FieldByName('resp_compras_c').Value;
  qrySGP.FieldByName('representante_c').Value:= qryComercial.FieldByName('representante_c').Value;
  qrySGP.FieldByName('n_copias_alb_c').Value:= qryComercial.FieldByName('n_copias_alb_c').Value;
  qrySGP.FieldByName('tipo_via_fac_c').Value:= qryComercial.FieldByName('tipo_via_fac_c').Value;
  qrySGP.FieldByName('domicilio_fac_c').Value:= qryComercial.FieldByName('domicilio_fac_c').Value;
  qrySGP.FieldByName('poblacion_fac_c').Value:= qryComercial.FieldByName('poblacion_fac_c').Value;
  qrySGP.FieldByName('cod_postal_fac_c').Value:= qryComercial.FieldByName('cod_postal_fac_c').Value;
  qrySGP.FieldByName('pais_fac_c').Value:= qryComercial.FieldByName('pais_fac_c').Value;
  qrySGP.FieldByName('n_copias_fac_c').Value:= qryComercial.FieldByName('n_copias_fac_c').Value;
  qrySGP.FieldByName('forma_pago_c').Value:= qryComercial.FieldByName('forma_pago_ct').Value;
  qrySGP.FieldByName('moneda_c').Value:= qryComercial.FieldByName('moneda_c').Value;
  qrySGP.FieldByName('edi_c').Value:= qryComercial.FieldByName('edi_c').Value;
  qrySGP.FieldByName('dia_vencim1_c').Value:= qryComercial.FieldByName('dia_vencim1_c').Value;
  qrySGP.FieldByName('dia_vencim2_c').Value:= qryComercial.FieldByName('dia_vencim2_c').Value;
  qrySGP.FieldByName('porc_dto_c').Value:= qryComercial.FieldByName('porc_dto_c').Value;
  qrySGP.FieldByName('porc_dto_fac_c').Value:= qryComercial.FieldByName('porc_dto_fac_c').Value;
  qrySGP.FieldByName('cta_cliente_c').Value:= qryComercial.FieldByName('cta_cliente_c').Value;
  qrySGP.FieldByName('expediciones_c').Value:= qryComercial.FieldByName('expediciones_c').Value;
  if qryComercial.FieldByName('tipo_albaran_c').AsInteger = 1 then
    qrySGP.FieldByName('albaran_valor_c').AsString:= 'S'
  else
    qrySGP.FieldByName('albaran_valor_c').AsString:= 'N';
  qrySGP.FieldByName('albaran_factura_c').Value:= qryComercial.FieldByName('albaran_factura_c').Value;
  qrySGP.FieldByName('email_alb_c').Value:= qryComercial.FieldByName('email_alb_c').Value;
  qrySGP.FieldByName('email_fac_c').Value:= qryComercial.FieldByName('email_fac_c').Value;
  qrySGP.FieldByName('max_riesgo_c').Value:= qryComercial.FieldByName('max_riesgo_cr').Value;
  qrySGP.FieldByName('seguro_c').Value:= qryComercial.FieldByName('seguro_cr').Value;
  qrySGP.Post;
end;

procedure TDMComerToSgp.PasarDirSuministros;
begin
  SQLDirSuministros;
  if OpenDirSuministros then
  begin
    while not qryComercial.Eof DO
    begin
      CopiarDirSuministroAlSGP( qrySGP );
      qryComercial.Next;
    end;
    CerrarTablas;
  end;
end;

procedure TDMComerToSgp.SQLDirSuministros;
begin
  qryComercial.SQL.Clear;
  qryComercial.SQL.Add('select * from Frf_dir_sum where cliente_ds = :cliente ');
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('select * from Frf_dir_sum where empresa_ds = :empresa and cliente_ds = :cliente and dir_sum_ds = :dir_sum ');
end;

function  TDMComerToSgp.OpenDirSuministros: boolean;
begin
  qryComercial.ParamByName('cliente').AsString:= sCliente;
  qryComercial.Open;
  if not qryComercial.IsEmpty then
  begin
    Result:= True;
  end
  else
  begin
    qryComercial.Close;
    Result:= False;
  end;
end;

procedure TDMComerToSgp.CopiarDirSuministroAlSGP( const MyQry: TQuery );
begin
  MyQry.ParamByName('empresa').AsString:= sEmpresa;
  MyQry.ParamByName('cliente').AsString:= sCliente;
  MyQry.ParamByName('dir_sum').AsString:= qryComercial.FieldByName('dir_sum_ds').AsString;
  MyQry.Open;
  if MyQry.IsEmpty then
  begin
    MyQry.Insert;
  end
  else
  begin
    MyQry.Edit;
  end;
  MyQry.FieldByName('empresa_ds').Value:= sEmpresa;
  MyQry.FieldByName('cliente_ds').Value:= qryComercial.FieldByName('cliente_ds').Value;
  MyQry.FieldByName('dir_sum_ds').Value:= qryComercial.FieldByName('dir_sum_ds').Value;
  MyQry.FieldByName('nombre_ds').Value:= qryComercial.FieldByName('nombre_ds').Value;
  MyQry.FieldByName('tipo_via_ds').Value:= qryComercial.FieldByName('tipo_via_ds').Value;
  MyQry.FieldByName('domicilio_ds').Value:= qryComercial.FieldByName('domicilio_ds').Value;
  MyQry.FieldByName('cod_postal_ds').Value:= qryComercial.FieldByName('cod_postal_ds').Value;
  MyQry.FieldByName('poblacion_ds').Value:= qryComercial.FieldByName('poblacion_ds').Value;
  MyQry.FieldByName('telefono_ds').Value:= qryComercial.FieldByName('telefono_ds').Value;
  MyQry.FieldByName('provincia_ds').Value:= qryComercial.FieldByName('provincia_ds').Value;
  MyQry.FieldByName('pais_ds').Value:= qryComercial.FieldByName('pais_ds').Value;
  MyQry.Post;
  MyQry.Close;
end;

function TDMComerToSgp.PasarEnvase( const AEmpresa, AEnvase: string ): boolean;
var
  bNuevo: Boolean;
begin
  sEmpresa:= AEmpresa;
  sEnvase:= AEnvase;
  SQLEnvases;
  if OpenEnvases( sEmpresa, bNuevo ) then
  begin
    CopiarEnvaseAlSGP( sEmpresa, bNuevo );
    CerrarTablas;
    PasarEansEnvase;
//    PasarClientesEnvase;
    Result:= True;
  end
  else
  begin
    Result:= True;
  end;
end;

procedure TDMComerToSgp.SQLEnvases;
begin
  qryComercial.SQL.Clear;
  qryComercial.SQL.Add('select * from frf_envases where envase_e = :envase ');
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('select * from frf_envases where empresa_e = :empresa and envase_e = :envase ');
end;

function TDMComerToSgp.OpenEnvases( const AEmpresa: String; var VNuevo: boolean ): boolean;
begin
  qryComercial.ParamByName('envase').AsString:= sEnvase;
  qryComercial.Open;
  if not qryComercial.IsEmpty then
  begin
    Result:= True;
    qrySGP.ParamByName('empresa').AsString:=AEmpresa;
    qrySGP.ParamByName('envase').AsString:= sEnvase;
    qrySGP.Open;
    VNuevo:= qrySGP.IsEmpty;
  end
  else
  begin
    qryComercial.Close;
    Result:= False;
  end;
end;

procedure TDMComerToSgp.CopiarEnvaseAlSGP( const AEmpresa: string; var ANuevo: boolean );
begin
  if ANuevo then
  begin
    qrySGP.Insert;
  end
  else
  begin
    qrySGP.Edit;
  end;
  qrySGP.FieldByName('empresa_e').Value:= AEmpresa;
  qrySGP.FieldByName('envase_e').Value:= qryComercial.FieldByName('envase_e').Value;
  qrySGP.FieldByName('descripcion_e').Value:= qryComercial.FieldByName('descripcion_e').Value;
  qrySGP.FieldByName('descripcion2_e').Value:= qryComercial.FieldByName('descripcion2_e').Value;
  qrySGP.FieldByName('peso_envase_e').Value:= qryComercial.FieldByName('peso_envase_e').Value;
  qrySGP.FieldByName('peso_neto_e').Value:= qryComercial.FieldByName('peso_neto_e').Value;
  qrySGP.FieldByName('agrupacion_e').Value:= qryComercial.FieldByName('agrupacion_e').Value;
  qrySGP.FieldByName('unidades_e').Value:= qryComercial.FieldByName('unidades_e').Value;
  qrySGP.FieldByName('peso_neto_und_e').Value:= qryComercial.FieldByName('peso_neto_und_e').Value;
  qrySGP.FieldByName('peso_envase_und_e').Value:= qryComercial.FieldByName('peso_envase_und_e').Value;
  qrySGP.FieldByName('cod_almacen_e').Value:= qryComercial.FieldByName('cod_almacen_e').Value;
  qrySGP.FieldByName('codigo_caja_e').Value:= qryComercial.FieldByName('codigo_caja_e').Value;
  qrySGP.FieldByName('texto_caja_e').Value:= qryComercial.FieldByName('texto_caja_e').Value;
  qrySGP.FieldByName('cantidad_cajas_e').Value:= qryComercial.FieldByName('cantidad_cajas_e').Value;
  qrySGP.FieldByName('envase_comercial_e').Value:= qryComercial.FieldByName('envase_comercial_e').Value;
  qrySGP.FieldByName('notas_e').Value:= qryComercial.FieldByName('notas_e').Value;
  qrySGP.FieldByName('c_envase_e').Value:= qryComercial.FieldByName('c_envase_e').Value;
  qrySGP.FieldByName('c_unidad_e').Value:= qryComercial.FieldByName('c_unidad_e').Value;
  qrySGP.FieldByName('c_reenvasado_e').Value:= qryComercial.FieldByName('c_reenvasado_e').Value;
  qrySGP.FieldByName('c_adicional_e').Value:= qryComercial.FieldByName('c_adicional_e').Value;
  qrySGP.FieldByName('producto_base_e').Value:= 1;
  qrySGP.FieldByName('tipo_unidad_e').Value:= qryComercial.FieldByName('tipo_unidad_e').Value;
  qrySGP.FieldByName('fecha_baja_e').Value:= qryComercial.FieldByName('fecha_baja_e').Value;
  qrySGP.FieldByName('esliquido_e').Value:= qryComercial.FieldByName('esliquido_e').Value;
  qrySGP.FieldByName('peso_variable_e').Value:= qryComercial.FieldByName('peso_variable_e').Value;
  qrySGP.FieldByName('producto_e').Value:= qryComercial.FieldByName('producto_e').Value;
  qrySGP.Post;
end;


procedure TDMComerToSgp.PasarEansEnvase;
begin
  BorrarEans;
  SQLEans;
  if OpenEans then
  begin
    while not qryComercial.Eof DO
    begin
      CopiarEanAlSGP( qrySGP, True );
      CopiarEanAlSGP( qrySGPAux, False );
      qryComercial.Next;
    end;
    CerrarTablas;
  end;
end;

procedure TDMComerToSgp.BorrarEans;
begin
  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('delete from Frf_ean13 where empresa_e = :empresa and envase_e = :envase and agrupacion_e = 2  ');
  qrySGP.ParamByName('empresa').AsString:= sEmpresa;
  qrySGP.ParamByName('envase').AsString:= sEnvase;
  qrySGP.ExecSQL;

  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('delete from rf_ean13 where empresa_e = :empresa and envase_e = :envase and agrupacion_e = 2 ');
  qrySGP.ParamByName('empresa').AsString:= sEmpresa;
  qrySGP.ParamByName('envase').AsString:= sEnvase;
  qrySGP.ExecSQL;
end;

procedure TDMComerToSgp.SQLEans;
begin
  qryComercial.SQL.Clear;
  qryComercial.SQL.Add('select * from Frf_ean13 where envase_e = :envase  and agrupacion_e = 2 ');
  qrySGP.SQL.Clear;
//  qrySGP.SQL.Add('select * from Frf_ean13 where envase_e = :envase and agrupacion_e = 2');
  qrySGP.SQL.Add('select * from Frf_ean13 where empresa_e = :empresa and codigo_e = :ean and envase_e = :envase and producto_p = :producto and marca_e = :marca and calibre_e = :calibre  and agrupacion_e = 2');
  qrySGPAux.SQL.Clear;
//  qrySGPAux.SQL.Add('select * from rf_ean13 where envase_e = :envase and agrupacion_e = 2');
  qrySGPAux.SQL.Add('select * from rf_ean13 where empresa_e = :empresa and codigo_e = :ean and envase_e = :envase and producto_p = :producto and marca_e = :marca and calibre_e = :calibre  and agrupacion_e = 2');
end;

function  TDMComerToSgp.OpenEANS: boolean;
begin
  qryComercial.ParamByName('envase').AsString:= sEnvase;
  qryComercial.Open;
  if not qryComercial.IsEmpty then
  begin
    Result:= True;
  end
  else
  begin
    qryComercial.Close;
    Result:= False;
  end;
end;

procedure TDMComerToSgp.CopiarEanAlSGP( const MyQry: TQuery; const AEan14: boolean );
begin
  MyQry.ParamByName('empresa').AsString:= qryComercial.FieldByName('empresa_e').AsString;
  MyQry.ParamByName('envase').AsString:= sEnvase;
  MyQry.ParamByName('ean').AsString:= qryComercial.FieldByName('codigo_e').AsString;
  MyQry.ParamByName('producto').AsString:= qryComercial.FieldByName('productop_e').AsString;
  MyQry.ParamByName('marca').AsString:= qryComercial.FieldByName('marca_e').AsString;
  MyQry.ParamByName('calibre').AsString:= qryComercial.FieldByName('calibre_e').AsString;
  MyQry.Open;
  if MyQry.IsEmpty then
  begin
    MyQry.Insert;
  end
  else
  begin
    MyQry.Edit;
  end;
  MyQry.FieldByName('codigo_e').Value:= qryComercial.FieldByName('codigo_e').Value;
  MyQry.FieldByName('empresa_e').Value:= qryComercial.FieldByName('empresa_e').Value;
  MyQry.FieldByName('empresa_e').Value:= qryComercial.FieldByName('empresa_e').Value;
  MyQry.FieldByName('producto_e').Value:= 1;
  MyQry.FieldByName('producto_p').Value:= qryComercial.FieldByName('productop_e').Value;
  MyQry.FieldByName('envase_e').Value:= qryComercial.FieldByName('envase_e').Value;
  MyQry.FieldByName('marca_e').Value:= qryComercial.FieldByName('marca_e').Value;
  MyQry.FieldByName('categoria_e').Value:= qryComercial.FieldByName('categoria_e').Value;
  MyQry.FieldByName('calibre_e').Value:= qryComercial.FieldByName('calibre_e').Value;
  MyQry.FieldByName('descripcion_e').Value:= qryComercial.FieldByName('descripcion_e').Value;
  MyQry.FieldByName('descripcion2_e').Value:= qryComercial.FieldByName('descripcion2_e').Value;
  MyQry.FieldByName('agrupacion_e').Value:= qryComercial.FieldByName('agrupacion_e').Value;
  if AEan14 then
    MyQry.FieldByName('ean14_e').Value:= qryComercial.FieldByName('ean14_e').Value;
  MyQry.FieldByName('fecha_baja_e').Value:= qryComercial.FieldByName('fecha_baja_e').Value;
  MyQry.Post;
  MyQry.Close;
end;


procedure TDMComerToSgp.PasarClientesEnvase;
begin
  SQLClientesEnvase;
  if OpenClientesEnvase then
  begin
    while not qryComercial.Eof DO
    begin
      CopiarClienteEnvaseAlSGP;
      qryComercial.Next;
    end;
    CerrarTablas;
  end;
end;


procedure TDMComerToSgp.SQLClientesEnvase;
begin
  qryComercial.SQL.Clear;
  qryComercial.SQL.Add('select *  from frf_clientes_env where empresa_ce = :empresa and envase_ce = :envase ');
  qryComerAux.SQL.Clear;
  qryComerAux.SQL.Add(' select * from frf_productos where producto_base_p = :productobase ');

  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('select *  from FRF_CLIENTES_FAC where empresa_cf = :empresa and envase_cf = :envase and producto_cf = :producto and cliente_cf = :cliente ');

end;

function  TDMComerToSgp.OpenClientesEnvase: boolean;
begin
  qryComercial.ParamByName('empresa').AsString:= sEmpresa;
  qryComercial.ParamByName('envase').AsString:= sEnvase;
  qryComercial.Open;
  if not qryComercial.IsEmpty then
  begin
    Result:= True;
  end
  else
  begin
    qryComercial.Close;
    Result:= False;
  end;
end;

function GetUnidad( const AUnidad: string ): string;
begin
  if AUnidad = 'U' then
    Result:= 'UND'
  else
  if AUnidad = 'C' then
    Result:= 'CAJ'
  else
    Result:= 'KGS'
end;

procedure TDMComerToSgp.CopiarClienteEnvaseAlSGP;
begin
  qryComerAux.ParamByName('productobase').AsString:= qryComercial.FieldByName('producto_base_ce').AsString;
  qryComerAux.Open;
  while not qryComerAux.Eof do
  begin
    qrySGP.ParamByName('empresa').AsString:= sEmpresa;
    qrySGP.ParamByName('envase').AsString:= sEnvase;
    qrySGP.ParamByName('producto').AsString:= qryComerAux.FieldByName('producto_p').AsString;
    qrySGP.ParamByName('cliente').AsString:= qryComercial.FieldByName('cliente_ce').AsString;
    qrySGP.Open;
    if qrySGP.IsEmpty then
    begin
      qrySGP.Insert;
    end
    else
    begin
      qrySGP.Edit;
    end;

    qrySGP.FieldByName('empresa_cf').Value:= qryComercial.FieldByName('empresa_ce').Value;
    qrySGP.FieldByName('producto_cf').Value:= qryComerAux.FieldByName('producto_p').Value;
    qrySGP.FieldByName('envase_cf').Value:= qryComercial.FieldByName('envase_ce').Value;
    qrySGP.FieldByName('cliente_cf').Value:= qryComercial.FieldByName('cliente_ce').Value;
    qrySGP.FieldByName('unidad_fac_cf').Value:= GetUnidad( qryComercial.FieldByName('unidad_fac_ce').Value );

    qrySGP.Post;
    qrySGP.Close;

    qryComerAux.Next;
  end;
  qryComerAux.Close;
end;


// -------------------------------------------------------------------------------
// PLANTACIONES
// -------------------------------------------------------------------------------
function TDMComerToSgp.PasarPlantacion( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana: string ): boolean;
var
  bNuevo: Boolean;
begin
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  sCosechero:= ACosechero;
  sPlantacion:= APlantacion;
  sAnyoSemana:= AAnyoSemana;

  SQLPlantaciones;
  if OpenPlantaciones( bNuevo ) then
  begin
    CopiarPlantacionAlSGP( bNuevo );
    CerrarTablas;
    Result:= True;
  end
  else
  begin
    Result:= True;
  end;
end;

procedure TDMComerToSgp.SQLPlantaciones;
begin
  qryComercial.SQL.Clear;
  qryComercial.SQL.Add(' select *  from  frf_plantaciones ');
  qryComercial.SQL.Add(' where empresa_p = :empresa and producto_p = :producto and cosechero_p = :cosechero ');
  qryComercial.SQL.Add('       and plantacion_p = :plantacion and ano_semana_p = :anyosemana ');

  qrySGP.SQL.Clear;
  qrySGP.SQL.Add('select *  from  frf_plantaciones ');
  qrySGP.SQL.Add(' where empresa_p = :empresa and producto_p = :producto and cosechero_p = :cosechero ');
  qrySGP.SQL.Add('       and plantacion_p = :plantacion and ano_semana_p = :anyosemana ');

  qryComerAux.SQL.Clear;
  qryComerAux.SQL.Add('select campo_c, tipo_c, descripcion_c from frf_campos ');
  qryComerAux.SQL.Add('where campo_c = :tipo ');
  qryComerAux.SQL.Add('and tipo_c = :variedad ');

  qrySGPAux.SQL.Clear;
  qrySGPAux.SQL.Add('select empresa, variedad, nombre from variedades ');
  qrySGPAux.SQL.Add('where empresa = :empresa ');
  qrySGPAux.SQL.Add('and variedad = :variedad ');
end;

function TDMComerToSgp.OpenPlantaciones( var VNuevo: boolean ): boolean;
begin
  qryComercial.ParamByName('empresa').AsString:= sEmpresa;
  qryComercial.ParamByName('producto').AsString:= sProducto;
  qryComercial.ParamByName('cosechero').AsString:= sCosechero;
  qryComercial.ParamByName('plantacion').AsString:= sPlantacion;
  qryComercial.ParamByName('anyosemana').AsString:= sAnyoSemana;
  qryComercial.Open;
  if not qryComercial.IsEmpty then
  begin
    Result:= True;
    qrySGP.ParamByName('empresa').AsString:= sEmpresa;
    qrySGP.ParamByName('producto').AsString:= sProducto;
    qrySGP.ParamByName('cosechero').AsString:= sCosechero;
    qrySGP.ParamByName('plantacion').AsString:= sPlantacion;
    qrySGP.ParamByName('anyosemana').AsString:= sAnyoSemana;
    qrySGP.Open;
    VNuevo:= qrySGP.IsEmpty;
  end
  else
  begin
    qryComercial.Close;
    Result:= False;
  end;
end;

procedure TDMComerToSgp.CopiarPlantacionAlSGP( var ANuevo: boolean );
begin
  CopiarVariedad;
  if ANuevo then
  begin
    qrySGP.Insert;
  end
  else
  begin
    qrySGP.Edit;
  end;
  qrySGP.FieldByName('ano_semana_p').Value:= qryComercial.FieldByName('ano_semana_p').Value;
  qrySGP.FieldByName('empresa_p').Value:= qryComercial.FieldByName('empresa_p').Value;
  qrySGP.FieldByName('producto_p').Value:= qryComercial.FieldByName('producto_p').Value;
  qrySGP.FieldByName('cosechero_p').Value:= qryComercial.FieldByName('cosechero_p').Value;
  qrySGP.FieldByName('plantacion_p').Value:= qryComercial.FieldByName('plantacion_p').Value;
  qrySGP.FieldByName('agrupacion_p').Value:= qryComercial.FieldByName('agrupacion_p').Value;
  qrySGP.FieldByName('descripcion_p').Value:= qryComercial.FieldByName('descripcion_p').Value;
  qrySGP.FieldByName('fecha_inicio_p').Value:= qryComercial.FieldByName('fecha_inicio_p').Value;
  qrySGP.FieldByName('fecha_fin_p').Value:= qryComercial.FieldByName('fecha_fin_p').Value;
  qrySGP.FieldByName('superficie_p').Value:= qryComercial.FieldByName('superficie_p').Value;
  qrySGP.FieldByName('plantas_p').Value:= qryComercial.FieldByName('plantas_p').Value;
  qrySGP.FieldByName('estructura_p').Value:= qryComercial.FieldByName('estructura_p').Value;
  qrySGP.FieldByName('tipo_cultivo_p').Value:= qryComercial.FieldByName('tipo_cultivo_p').Value;
  qrySGP.FieldByName('tipo_sustrato_p').Value:= qryComercial.FieldByName('tipo_sustrato_p').Value;
  qrySGP.FieldByName('variedad_p').Value:= qryComercial.FieldByName('variedad_p').Value;
  qrySGP.FieldByName('federacion_p').Value:= qryComercial.FieldByName('federacion_p').Value;
  qrySGP.Post;
end;

procedure TDMComerToSgp.CopiarVariedad;
var
  iVariedad: Integer;
begin
  if TryStrToInt( qryComercial.FieldByName('variedad_p').AsString, iVariedad ) then
  begin
    qrySGPAux.ParamByName('empresa').AsString:= sEmpresa;
    qrySGPAux.ParamByName('variedad').AsInteger:= iVariedad;
    qrySGPAux.Open;
    if qrySGPAux.IsEmpty then
    begin
      qryComerAux.ParamByName('tipo').AsString:= 'VARIEDAD';
      qryComerAux.ParamByName('variedad').AsString:= qryComercial.FieldByName('variedad_p').AsString;
      qryComerAux.Open;
      if not qryComerAux.IsEmpty then
      begin
        qrySGPAux.Insert;
        qrySGPAux.FieldByName('empresa').Value:= qryComercial.FieldByName('empresa_p').Value;
        qrySGPAux.FieldByName('variedad').AsInteger:= iVariedad;
        qrySGPAux.FieldByName('nombre').Value:= qryComerAux.FieldByName('descripcion_c').Value;
        qrySGPAux.Post;
      end;
      qryComerAux.Close;
    end;
    qrySGPAux.Close;
  end;
end;

end.

