unit SincronizadorPedidos;

interface

uses
  DB,
  DBTables,
  WideStrings,
  SqlExpr,

  // SimpleClientDataset;
  DBClient,
  SimpleDS,
  Controls,

  ConexionAWSAurora,
  ItemSincronizable
  ;


type
  TSincronizador = class

  private
    FSourceDb: TDatabase;
    FDestinationDb: TConexionAWSAurora;

    ISEnvases: TItemSincronizable;
    ISBancos: TItemSincronizable;
    ISCalibres: TItemSincronizable;
    ISCategorias: TItemSincronizable;
    ISCentros: TItemSincronizable;
    ISClientes: TItemSincronizable;
    ISClientesEDI: TItemSincronizable;
    ISColores: TItemSincronizable;
    ISComerciales: TItemSincronizable;
    ISIncoTerms: TItemSincronizable;
    ISDescuentosCliente: TItemSincronizable;
    ISDescuentosProducto: TItemSincronizable;
    ISDirSuministro: TItemSincronizable;
    ISEmpresas: TItemSincronizable;
    ISFormasPago: TItemSincronizable;
    ISMonedas: TItemSincronizable;
    ISPaises: TItemSincronizable;
    ISProductos: TItemSincronizable;
    ISProvincias: TItemSincronizable;
    ISRepresentantes: TItemSincronizable;
    ISClienteTipos: TItemSincronizable;
    ISPaletTipos: TItemSincronizable;
    ISViaTipos: TItemSincronizable;
    ISTransportistas: TItemSincronizable;
    ISUnidadFacturacion: TItemSincronizable;

  protected

  public
    constructor Create(ASourceDb: TDatabase; ADestinationDb: TConexionAWSAurora);

    procedure SincEnvase(const ACodigo: String);
    procedure SincBanco(const ABancoId: String);
    procedure SincCalibre(const AProductoId: String; const ACalibreId: String);
    procedure SincCategoria(const AProductoId: String; const ACategoriaId: String);
    procedure SincCentro(const AEmpresaId: String; const ACentroId: String);
    procedure SincCliente(const AClienteId: String);
    procedure SincClienteEdi(const AEmpresaId: String; const AClienteId: String; const ADireccionSumId: String);
    procedure SincColor(const AProductoId: String; const AColorId: String);
    procedure SincComercial(const AComercialId: String);

    procedure SincIncoTerms(const IncoTermId: String);
    procedure SincDescuentoCliente(const EmpresaId: String; const ClienteId: String; const FechaIni: TDate);
    procedure SincDescuentoProducto(const EmpresaId: String; const ClienteId: String; const ProductoId: String; const FechaIni: TDate);
    procedure SincDirSuministro(const ClienteId: String; const DireccionId: String);
    procedure SincEmpresa(const EmpresaId: String);
    procedure SincFormaPago(const FormaPagoId: String);
    procedure SincMoneda(const MonedaId: String);
    procedure SincPais(const PaisId: String);
    procedure SincProducto(const ProductoId: String);
    procedure SincProvincia(const ProvinciaId: String);
    procedure SincRepresentante(const RepresentanteId: String);
    procedure SincClienteTipo(const ClienteTipoId: String);
    procedure SincPaletTipo(const PaletTipoId: String);
    procedure SincViaTipo(const ViaTipoId: String);
    procedure SincTransportista(const TransportistaId: String);
    procedure SincUnidadFacturacion(const EmpresaId, ProductoId, EnvaseId, ClienteId : String);

  end;

implementation

uses
  SysUtils;

{ TSincronizador }

constructor TSincronizador.Create(ASourceDb: TDatabase; ADestinationDb: TConexionAWSAurora);
begin
  FSourceDb := ASourceDb;
  FDestinationDb := ADestinationDb;

  ISEnvases := TItemSincronizable.Create(FSourceDb, 'frf_envases', FDestinationDb, 'frf_envases', 'envase_e');
  ISBancos := TItemSincronizable.Create(FSourceDb, 'frf_bancos', FDestinationDb, 'tbancos', 'banco_b');
  ISCalibres := TItemSincronizable.Create(FSourceDb, 'frf_calibres', FDestinationDb, 'frf_calibres', 'producto_c,calibre_c');
  ISCategorias := TItemSincronizable.Create(FSourceDb, 'frf_categorias', FDestinationDb, 'frf_categorias', 'producto_c,categoria_c');
  ISCentros := TItemSincronizable.Create(FSourceDb, 'frf_centros', FDestinationDb, 'frf_centros', 'empresa_c,centro_c');
  ISClientes := TItemSincronizable.Create(FSourceDb, 'frf_clientes', FDestinationDb, 'frf_clientes', 'cliente_c');
  ISClientesEDI := TItemSincronizable.Create(FSourceDb, 'frf_clientes_edi', FDestinationDb, 'frf_clientes_edis', 'empresa_ce,cliente_ce,dir_sum_ce');
  ISColores := TItemSincronizable.Create(FSourceDb, 'frf_colores', FDestinationDb, 'frf_colores', 'producto_c,color_c');
  ISComerciales := TItemSincronizable.Create(FSourceDb, 'frf_comerciales', FDestinationDb, 'tcomerciales', 'codigo_c');
  ISIncoTerms  := TItemSincronizable.Create(FSourceDb, 'frf_incoterms', FDestinationDb, 'frf_incoterms', 'codigo_i');
  ISDescuentosCliente  := TItemSincronizable.Create(FSourceDb, 'frf_descuentos_cliente', FDestinationDb, 'frf_descuentos_cliente', 'empresa_dc,cliente_dc,fecha_ini_dc');
  ISDescuentosProducto  := TItemSincronizable.Create(FSourceDb, 'frf_descuentos_producto', FDestinationDb, 'frf_descuentos_producto', 'empresa_dp,cliente_dp,producto_dp,fecha_ini_dp');
  ISDirSuministro := TItemSincronizable.Create(FSourceDb, 'frf_dir_sum', FDestinationDb, 'frf_dir_sums', 'cliente_ds,dir_sum_ds');
  ISEmpresas := TItemSincronizable.Create(FSourceDb, 'frf_empresas', FDestinationDb, 'frf_empresas', 'empresa_e');
  ISFormasPago := TItemSincronizable.Create(FSourceDb, 'frf_forma_pago', FDestinationDb, 'frf_forma_pago', 'codigo_fp');
  ISMonedas := TItemSincronizable.Create(FSourceDb, 'frf_monedas', FDestinationDb, 'frf_monedas', 'moneda_m');
  ISPaises := TItemSincronizable.Create(FSourceDb, 'frf_paises', FDestinationDb, 'frf_paises', 'pais_p');
  ISProductos := TItemSincronizable.Create(FSourceDb, 'frf_productos', FDestinationDb, 'frf_productos', 'producto_p');
  ISProvincias := TItemSincronizable.Create(FSourceDb, 'frf_provincias', FDestinationDb, 'frf_provincias', 'codigo_p');
  ISRepresentantes := TItemSincronizable.Create(FSourceDb, 'frf_representantes', FDestinationDb, 'frf_representantes', 'representante_r');
  ISClienteTipos := TItemSincronizable.Create(FSourceDb, 'frf_cliente_tipos', FDestinationDb, 'tclientes_tipos', 'codigo_ctp');
  ISPaletTipos := TItemSincronizable.Create(FSourceDb, 'frf_tipo_palets', FDestinationDb, 'frf_tipo_palets', 'codigo_tp');
  ISViaTipos := TItemSincronizable.Create(FSourceDb, 'frf_vias', FDestinationDb, 'frf_vias', 'via_v,descripcion_v');
  ISTransportistas := TItemSincronizable.Create(FSourceDb, 'frf_transportistas', FDestinationDb, 'frf_transportistas', 'transporte_t');
  ISUnidadFacturacion := TItemSincronizable.Create(FSourceDb, 'frf_clientes_env', FDestinationDb, 'frf_clientes_envs', 'empresa_ce,producto_ce,envase_ce,cliente_ce');
end;



procedure TSincronizador.SincBanco(const ABancoId: String);
begin
  ISBancos.Sincroniza([ABancoId]);
end;


procedure TSincronizador.SincCalibre(const AProductoId, ACalibreId: String);
begin
  ISCalibres.Sincroniza([AProductoId, ACalibreId]);
end;


procedure TSincronizador.SincCategoria(const AProductoId, ACategoriaId: String);
begin
  ISCategorias.Sincroniza([AProductoId, ACategoriaId]);
end;

procedure TSincronizador.SincCentro(const AEmpresaId, ACentroId: String);
begin
  ISCentros.Sincroniza([AEmpresaId, ACentroId]);
end;

procedure TSincronizador.SincCliente(const AClienteId: String);
begin
  ISClientes.Sincroniza([AClienteId]);
end;

procedure TSincronizador.SincClienteEdi(const AEmpresaId, AClienteId, ADireccionSumId: String);
begin
  ISClientesEDI.Sincroniza([AEmpresaId, AClienteId, ADireccionSumId]);
end;

procedure TSincronizador.SincClienteTipo(const ClienteTipoId: String);
begin
  ISCLienteTipos.Sincroniza([ ClienteTipoId ]);
end;

procedure TSincronizador.SincColor(const AProductoId, AColorId: String);
begin
  ISColores.Sincroniza([AProductoId, AColorId]);
end;

procedure TSincronizador.SincComercial(const AComercialId: String);
begin
  ISComerciales.Sincroniza([ AComercialId ]);
end;


procedure TSincronizador.SincDescuentoCliente(const EmpresaId, ClienteId: String; const FechaIni: TDate);
begin
  ISDescuentosCliente.Sincroniza([ EmpresaId, ClienteId, FechaIni ]);
end;

procedure TSincronizador.SincDescuentoProducto(const EmpresaId, ClienteId, ProductoId: String; const FechaIni: TDate);
begin
  ISDescuentosProducto.Sincroniza([ EmpresaId, ClienteId, ProductoId, FechaIni ]);
end;

procedure TSincronizador.SincDirSuministro(const ClienteId, DireccionId: String);
begin
  ISDirSuministro.Sincroniza( [ ClienteId, DireccionId ]);
end;

procedure TSincronizador.SincEmpresa(const EmpresaId: String);
begin
  ISEmpresas.Sincroniza([ EmpresaId ]);
end;

procedure TSincronizador.SincEnvase(const ACodigo: String);
begin
  ISEnvases.Sincroniza([ACodigo]);
end;

procedure TSincronizador.SincFormaPago(const FormaPagoId: String);
begin
  ISFormasPago.Sincroniza([FormaPagoId]);
end;

procedure TSincronizador.SincIncoTerms(const IncoTermId: String);
begin
  ISIncoTerms.Sincroniza([ IncoTermId ]);
end;

procedure TSincronizador.SincMoneda(const MonedaId: String);
begin
  ISMonedas.Sincroniza([ MonedaId ]);

end;

procedure TSincronizador.SincPais(const PaisId: String);
begin
  ISPaises.Sincroniza( [PaisId ]);
end;

procedure TSincronizador.SincPaletTipo(const PaletTipoId: String);
begin
  ISPaletTipos.Sincroniza([ PaletTipoId ]);
end;

procedure TSincronizador.SincProducto(const ProductoId: String);
begin
  ISProductos.Sincroniza([ ProductoId ]);
end;

procedure TSincronizador.SincProvincia(const ProvinciaId: String);
begin
  ISProvincias.Sincroniza([ProvinciaId]);
end;

procedure TSincronizador.SincRepresentante(const RepresentanteId: String);
begin
  ISRepresentantes.Sincroniza([RepresentanteId]);
end;

procedure TSincronizador.SincTransportista(const TransportistaId: String);
begin
  ISTransportistas.Sincroniza([TransportistaId]);
end;


procedure TSincronizador.SincUnidadFacturacion(const EmpresaId, ProductoId, EnvaseId, ClienteId: String);
begin
  ISUnidadFacturacion.Sincroniza([ EmpresaId, ProductoId, EnvaseId, ClienteId ]);
end;

procedure TSincronizador.SincViaTipo(const ViaTipoId: String);
begin

end;

end.
