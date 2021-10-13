unit SincronizacionBonny;

interface

uses
  // Librerias Delphi
  DB,
  DBTables,
  Controls,

  // Librerias propias
  ConexionInformix,
  ConexionAWSAurora,
  Sincronizacion;

type
  // No cambiar el orden de los elementos de la lista. Añadir nuevos elementos al final.
  TItemSincronizableId = (
    isidNada,
    isidClienteTipos,
    isidPaletTipos,
    isidViaTipos,
    isidTransportista,
    isidRepresentante,
    isidProvincia,
    isidPais,
    isidMoneda,
    isidFormaPago,
    isidEmpresa,
    isidComercial,
    isidCliente,
    isidClienteEdi,
    isidBanco,
    isidCentro,
    isidProducto,
    isidProductoCategoria,
    isidProductoColor,
    isidProductoCalibre,
    isidEnvase,
    isidDirSuministro,
    isidDescuentoCliente,
    isidDescuentoProducto,
    isidUnidadFacturacion,
    isidEAN13Edi
);

  TItemSincronizableFactory = class;

  TSincronizacionBonny = class(TSincronizacion)
  private
    FItemSincronizableFactory: TItemSincronizableFactory;


  protected
    procedure CrearItemsDesdePendiente(ADataset: TDataset); override;

  public
    constructor Create(ASourceDb: TDatabase; ADestinationDb: TConexionAWSAurora);
    destructor Destroy; override;

    procedure SincronizarClienteTipo(const ClienteTipoId: String);
    procedure SincronizarPaletTipo(const PaletTipoId: String);
    procedure SincronizarViaTipo(const ViaTipoId: String);
    procedure SincronizarTranportista(const TransportistaId: String);
    procedure SincronizarRepresentante(const RepresentanteId: String);
    procedure SincronizarProvincia(const ProvinciaId: String);
    procedure SincronizarPais(const PaisId: String);
    procedure SincronizarMoneda(const MonedaId: String);
    procedure SincronizarFormaPago(const FormaPagoId: String);
    procedure SincronizarEmpresa(const EmpresaId: String);
    procedure SincronizarComercial(const ComercialId: String);
    procedure SincronizarClienteEdi(const EmpresaId: String; const ClienteId: String; const DireccionSumId: String);
    procedure SincronizarBanco(const BancoId: String);
    procedure SincronizarCentro(const EmpresaId: String; const CentroId: String);
    procedure SincronizarProducto(const ProductoId: String);
    procedure SincronizarCategoria(const ProductoId: String; const CategoriaId: String);
    procedure SincronizarCalibre(const ProductoId: String; const CalibreId: String);
    procedure SincronizarColor(const ProductoId: String; const ColorId: String);
    procedure SincronizarEnvase(const EnvaseId: String);
    procedure SincronizarCliente(const ClienteId: String);
    procedure SincronizarDirSuministro(const ClienteId: String; const DireccionId: String);
    procedure SincronizarDescuentoCliente(const EmpresaId: String; const ClienteId: String; const FechaIni: TDate);
    procedure SincronizarDescuentoProducto(const EmpresaId: String; const ClienteId: String; const ProductoId: String; const FechaIni: TDate);
    procedure SincronizarUnidadFacturacion(const EmpresaId, ProductoId, EnvaseId, ClienteId : String);
    procedure SincronizarEAN13Edi(const EmpresaId, ClienteId, EnvaseId : String);
  end;


  TItemSincronizableFactory = class
    private

    public
      function GetItemInstance(ItemSincronizableId: TItemSincronizableId): TItemSincronizable;
  end;

  TISClienteTipo = class(TItemSincronizable)
  private
    function GetClienteTipoId: String;
    procedure SetClienteTipoId(const Value: String);

  public
    constructor Create; reintroduce;

    property ClientTipoId: String read GetClienteTipoId write SetClienteTipoId;
  end;

  TISPaletTipo = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property PaletTipoId: String read GetId write SetId;
  end;

  TISViaTipo = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property ViaTipoId: String read GetId write SetId;
  end;

  TISTransportista = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property TransportistaId: String read GetId write SetId;
  end;

  TISRepresentante = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property RepresentanteId: String read GetId write SetId;
  end;

  TISProvincia = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property ProvinciaId: String read GetId write SetId;
  end;

  TISPais = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property PaisId: String read GetId write SetId;
  end;

  TISMoneda = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property MonedaId: String read GetId write SetId;
  end;

  TISFormaPago = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property FormaPagoId: String read GetId write SetId;
  end;

  TISEmpresa = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property EmpresaId: String read GetId write SetId;
  end;

  TISComercial = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property ComercialId: String read GetId write SetId;
  end;

  TISClienteEdi = class(TItemSincronizable)
  private
    function GetClienteId: String;
    function GetDireccionSumId: String;
    function GetEmpresaId: String;
    procedure SetClienteId(const Value: String);
    procedure SetDireccionSumId(const Value: String);
    procedure SetEmpresaId(const Value: String);

  public
    constructor Create; reintroduce;

    property EmpresaId: String read GetEmpresaId write SetEmpresaId;
    property ClienteId: String read GetClienteId write SetClienteId;
    property DireccionSumId: String read GetDireccionSumId write SetDireccionSumId;
  end;

  TISBanco = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property BancoId: String read GetId write SetId;
  end;

  TISCentro = class(TItemSincronizable)
  private
    function GetCentroId: String;
    function GetEmpresaId: String;
    procedure SetCentroId(const Value: String);
    procedure SetEmpresaId(const Value: String);

  public
    constructor Create; reintroduce;

    property EmpresaId: String read GetEmpresaId write SetEmpresaId;
    property CentroId: String read GetCentroId write SetCentroId;
  end;

  TISProducto = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property ProductoId: String read GetId write SetId;
  end;

  TISProductoCategoria = class(TItemSincronizable)
  private
    function GetProductoId: String;
    function GetCategoriaId: String;
    procedure SetProductoId(const Value: String);
    procedure SetCategoriaId(const Value: String);

  public
    constructor Create; reintroduce;

    property ProductoId: String read GetProductoId write SetProductoId;
    property CategoriaId: String read GetCategoriaId write SetCategoriaId;
  end;

  TISProductoColor = class(TItemSincronizable)
  private
    function GetProductoId: String;
    function GetColorId: String;
    procedure SetProductoId(const Value: String);
    procedure SetColorId(const Value: String);

  public
    constructor Create; reintroduce;

    property ProductoId: String read GetProductoId write SetProductoId;
    property ColorId: String read GetColorId write SetColorId;
  end;

  TISProductoCalibre = class(TItemSincronizable)
  private
    function GetProductoId: String;
    function GetCalibreId: String;
    procedure SetProductoId(const Value: String);
    procedure SetCalibreId(const Value: String);

  public
    constructor Create; reintroduce;

    property ProductoId: String read GetProductoId write SetProductoId;
    property CalibreId: String read GetCalibreId write SetCalibreId;
  end;

  TISEnvase = class(TItemSincronizable)
  private
    function GetId: String;
    procedure SetId(const Value: String);

  public
    constructor Create; reintroduce;

    property EnvaseId: String read GetId write SetId;
  end;

  TISCliente = class(TItemSincronizable)
  private
    function GetClienteId: String;
    procedure SetClienteId(const Value: String);

  public
    constructor Create; reintroduce;

    property ClienteId: String read GetClienteId write SetClienteId;
  end;

  TISDirSuministro = class(TItemSincronizable)
  private
    function GetClienteId: String;
    procedure SetClienteId(const Value: String);
    function GetDirSuministroId: String;
    procedure SetDirSuministroId(const Value: String);

  public
    constructor Create; reintroduce;

    property ClienteId: String read GetClienteId write SetClienteId;
    property DirSuministroId: String read GetDirSuministroId write SetDirSuministroId;
  end;

  TISDescuentoCliente = class(TItemSincronizable)
  private
    function GetClienteId: String;
    function GetEmpresaId: String;
    function GetFechaInicio: TDate;
    procedure SetClienteId(const Value: String);
    procedure SetEmpresaId(const Value: String);
    procedure SetFEchaInicio(const Value: TDate);

  protected
    procedure AsignarParametros; override;

  public
    constructor Create; reintroduce;

    property EmpresaId: String read GetEmpresaId write SetEmpresaId;
    property ClienteId: String read GetClienteId write SetClienteId;
    property FechaInicio: TDate read GetFechaInicio write SetFEchaInicio;
  end;

  TISDescuentoProducto = class(TItemSincronizable)
  private
    function GetClienteId: String;
    function GetEmpresaId: String;
    function GetFechaInicio: TDate;
    procedure SetClienteId(const Value: String);
    procedure SetEmpresaId(const Value: String);
    procedure SetFEchaInicio(const Value: TDate);
    function GetProductoId: String;
    procedure SetProductoId(const Value: String);

  protected
    procedure AsignarParametros; override;

  public
    constructor Create; reintroduce;

    property EmpresaId: String read GetEmpresaId write SetEmpresaId;
    property ClienteId: String read GetClienteId write SetClienteId;
    property ProductoId: String read GetProductoId write SetProductoId;
    property FechaInicio: TDate read GetFechaInicio write SetFEchaInicio;
  end;

  TISunidadFacturacion = class(TItemSincronizable)
  private
    function GetClienteId: String;
    function GetEmpresaId: String;
    function GetEnvaseId: String;
    function GetProductoId: String;
    procedure SetClienteId(const Value: String);
    procedure SetEmpresaId(const Value: String);
    procedure SetEnvaseId(const Value: String);
    procedure SetProductoId(const Value: String);

  protected

  public
    constructor Create; reintroduce;

    property EmpresaId: String read GetEmpresaId write SetEmpresaId;
    property ProductoId: String read GetProductoId write SetProductoId;
    property EnvaseId: String read GetEnvaseId write SetEnvaseId;
    property ClienteId: String read GetClienteId write SetClienteId;
  end;

  TISEan13Edi =  class(TItemSincronizable)
  private
    function GetClienteId: String;
    function GetEmpresaId: String;
    function GetEnvaseId: String;
    procedure SetClienteId(const Value: String);
    procedure SetEmpresaId(const Value: String);
    procedure SetEnvaseId(const Value: String);

  protected

  public
    constructor Create; reintroduce;

    property EmpresaId: String read GetEmpresaId write SetEmpresaId;
    property ClienteId: String read GetClienteId write SetClienteId;
    property EnvaseId: String read GetEnvaseId write SetEnvaseId;
  end;

var
  SincroBonnyAurora: TSincronizacionBonny;


implementation

uses
  SysUtils,
  DateUtils;

{ TSincronizacionBonny }

procedure TSincronizacionBonny.CrearItemsDesdePendiente(ADataset: TDataset);
var
  item: TItemSincronizable;
  id: TItemSincronizableId;
  valores_clave: String;
begin
  with ADataset do
  begin
    First;
    while not eof do
    begin
      id := TItemSincronizableId(FieldByName('tabla').asInteger);
      valores_clave := FieldByName('valores_clave').asString;
      item := FItemSincronizableFactory.GetItemInstance(id);
      item.ValoresClave.CommaText := valores_clave;
      Encolar(item);
      BorrarItemPendiente(FieldByName('id').asInteger);
      Next
    end;
  end;
end;

constructor TSincronizacionBonny.Create(ASourceDb: TDatabase; ADestinationDb: TConexionAWSAurora);
begin
  inherited;

  FItemSincronizableFactory := TItemSincronizableFactory.Create;
end;

destructor TSincronizacionBonny.Destroy;
begin
  FItemSincronizableFactory.Free;
  
  inherited;
end;

procedure TSincronizacionBonny.SincronizarCalibre(const ProductoId, CalibreId: String);
var
  item: TISProductoCalibre;
begin
  Item := TISProductoCalibre(FItemSincronizableFactory.GetItemInstance(isidProductoCalibre));
  Item.ProductoId := ProductoId;
  Item.CalibreId := CalibreId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarCategoria(const ProductoId, CategoriaId: String);
var
  item: TISProductoCategoria;
begin
  Item := TISProductoCategoria(FItemSincronizableFactory.GetItemInstance(isidProductoCategoria));
  Item.ProductoId := ProductoId;
  Item.CategoriaId := CategoriaId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarBanco(const BancoId: String);
var
  item: TISBanco;
begin
  Item := TISBanco(FItemSincronizableFactory.GetItemInstance(isidBanco));
  Item.BancoId := BancoId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarCentro(const EmpresaId, CentroId: String);
var
  item: TISCentro;
begin
  Item := TISCentro(FItemSincronizableFactory.GetItemInstance(isidCentro));
  Item.EmpresaId := EmpresaId;
  Item.CentroId := CentroId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarCliente(const ClienteId: String);
var
  item: TISCliente;
begin
  Item := TISCliente(FItemSincronizableFactory.GetItemInstance(isidCliente));
  Item.ClienteId := ClienteId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarClienteEdi(const EmpresaId, ClienteId, DireccionSumId: String);
var
  item: TISClienteEdi;
begin
  Item := TISClienteEdi(FItemSincronizableFactory.GetItemInstance(isidClienteEdi));
  Item.EmpresaId := EmpresaId;
  Item.ClienteId := ClienteId;
  Item.DireccionSumId := DireccionSumId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarClienteTipo(const ClienteTipoId: String);
var
  item: TISClienteTipo;
begin
  Item := TISClienteTipo(FItemSincronizableFactory.GetItemInstance(isidClienteTipos));
  Item.ClientTipoId := ClienteTipoId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarColor(const ProductoId, ColorId: String);
var
  item: TISProductoColor;
begin
  Item := TISProductoColor(FItemSincronizableFactory.GetItemInstance(isidProductoColor));
  Item.ProductoId := ProductoId;
  Item.ColorId := ColorId;
  Encolar(Item);

end;

procedure TSincronizacionBonny.SincronizarComercial(const ComercialId: String);
var
  item: TISComercial;
begin
  Item := TISComercial(FItemSincronizableFactory.GetItemInstance(isidComercial));
  Item.ComercialId := ComercialId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarDescuentoCliente(const EmpresaId, ClienteId: String; const FechaIni: TDate);
var
  item: TISDescuentoCliente;
begin
  Item := TISDescuentoCliente(FItemSincronizableFactory.GetItemInstance(isidDescuentoCliente));
  Item.EmpresaId := EmpresaId;
  Item.ClienteId := ClienteId;
  Item.FechaInicio := FechaIni;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarDescuentoProducto(const EmpresaId, ClienteId, ProductoId: String;
  const FechaIni: TDate);
var
  item: TISDescuentoProducto;
begin
  Item := TISDescuentoProducto(FItemSincronizableFactory.GetItemInstance(isidDescuentoProducto));
  Item.EmpresaId := EmpresaId;
  Item.ClienteId := ClienteId;
  Item.ProductoId := ProductoId;
  Item.FechaInicio := FechaIni;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarDirSuministro(const ClienteId, DireccionId: String);
var
  item: TISDirSuministro;
begin
  Item := TISDirSuministro(FItemSincronizableFactory.GetItemInstance(isidDirSuministro));
  Item.ClienteId := ClienteId;
  Item.DirSuministroId := DireccionId;
  Encolar(Item);

end;

procedure TSincronizacionBonny.SincronizarEAN13Edi(const EmpresaId, ClienteId, EnvaseId: String);
var
  item: TISEan13Edi;
begin
  Item := TISEan13Edi(FItemSincronizableFactory.GetItemInstance(isidEan13Edi));
  Item.EmpresaId := EmpresaId;
  Item.ClienteId := ClienteId;
  Item.EnvaseId := EnvaseId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarEmpresa(const EmpresaId: String);
var
  item: TISEmpresa;
begin
  Item := TISEmpresa(FItemSincronizableFactory.GetItemInstance(isidEmpresa));
  Item.EmpresaId := EmpresaId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarEnvase(const EnvaseId: String);
var
  item: TISEnvase;
begin
  Item := TISEnvase(FItemSincronizableFactory.GetItemInstance(isidEnvase));
  Item.EnvaseId := EnvaseId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarFormaPago(const FormaPagoId: String);
var
  item: TISFormaPago;
begin
  Item := TISFormaPago(FItemSincronizableFactory.GetItemInstance(isidFormaPago));
  Item.FormaPagoId := FormaPagoId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarMoneda(const MonedaId: String);
var
  item: TISMoneda;
begin
  Item := TISMoneda(FItemSincronizableFactory.GetItemInstance(isidMoneda));
  Item.MonedaId := MonedaId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarPais(const PaisId: String);
var
  item: TISPais;
begin
  Item := TISPais(FItemSincronizableFactory.GetItemInstance(isidPais));
  Item.PaisId := PaisId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarPaletTipo(const PaletTipoId: String);
var
  item: TISPaletTipo;
begin
  Item := TISPaletTipo(FItemSincronizableFactory.GetItemInstance(isidPaletTipos));
  Item.PaletTipoId := PaletTipoId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarProducto(const ProductoId: String);
var
  item: TISProducto;
begin
  Item := TISProducto(FItemSincronizableFactory.GetItemInstance(isidProducto));
  Item.ProductoId := ProductoId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarProvincia(const ProvinciaId: String);
var
  item: TISProvincia;
begin
  Item := TISProvincia(FItemSincronizableFactory.GetItemInstance(isidProvincia));
  Item.ProvinciaId := ProvinciaId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarRepresentante(const RepresentanteId: String);
var
  item: TISRepresentante;
begin
  Item := TISRepresentante(FItemSincronizableFactory.GetItemInstance(isidRepresentante));
  Item.RepresentanteId := RepresentanteId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarTranportista(const TransportistaId: String);
var
  item: TISTransportista;
begin
  Item := TISTransportista(FItemSincronizableFactory.GetItemInstance(isidTransportista));
  Item.TransportistaId := TransportistaId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarUnidadFacturacion(const EmpresaId, ProductoId, EnvaseId, ClienteId: String);
var
  item: TISUnidadFacturacion;
begin
  Item := TISUnidadFacturacion(FItemSincronizableFactory.GetItemInstance(isidUnidadFacturacion));
  Item.EmpresaId := EmpresaId;
  Item.ProductoId := ProductoId;
  Item.EnvaseId := EnvaseId;
  Item.ClienteId := ClienteId;
  Encolar(Item);
end;

procedure TSincronizacionBonny.SincronizarViaTipo(const ViaTipoId: String);
var
  item: TISViaTipo;
begin
  Item := TISViaTipo(FItemSincronizableFactory.GetItemInstance(isidViaTipos));
  Item.ViaTipoId := ViaTipoId;
  Encolar(Item);
end;

{ TISClienteTipo }

constructor TISClienteTipo.Create;
begin
  inherited Create(Ord(isidClienteTipos));

  TablaOrigen := 'frf_cliente_tipos';
  TablaDestino := 'tclientes_tipos';
  CadenaCamposClave := 'codigo_ctp';
  //Ini;
end;

function TISClienteTipo.GetClienteTipoId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISClienteTipo.SetClienteTipoId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TItemSincronizableFactory }


function TItemSincronizableFactory.GetItemInstance(ItemSincronizableId: TItemSincronizableId): TItemSincronizable;
begin
  Result := nil;
  case ItemSincronizableId of
    isidNada: Result := nil;
    isidClienteTipos: Result := TISClienteTipo.Create;
    isidPaletTipos: Result := TISPaletTipo.Create;
    isidViaTipos: Result := TISViaTipo.Create;
    isidTransportista: Result := TISTransportista.Create;
    isidRepresentante: Result := TISRepresentante.Create;
    isidProvincia: Result := TISProvincia.Create;
    isidPais: Result := TISPais.Create;
    isidMoneda: Result := TISMoneda.Create;
    isidFormaPago: Result := TISFormaPago.Create;
    isidEmpresa: Result := TISEmpresa.Create;
    isidComercial: Result := TISComercial.Create;
    isidClienteEdi: Result := TISClienteEdi.Create;
    isidBanco: Result := TISBanco.Create;
    isidCentro: Result := TISCentro.Create;
    isidProducto: Result := TISProducto.Create;
    isidProductoCategoria: Result := TISProductoCategoria.Create;
    isidProductoColor: Result := TISProductoColor.Create;
    isidProductoCalibre: Result := TISProductoCalibre.Create;
    isidEnvase: Result := TISEnvase.Create;
    isidCliente: Result := TISCliente.Create;
    isidDirSuministro: Result := TISDirSuministro.Create;
    isidDescuentoCliente: Result := TISDescuentoCliente.Create;
    isidDescuentoProducto: Result := TISDescuentoProducto.Create;
    isidUnidadFacturacion: Result := TISUnidadFacturacion.Create;
    isidEAN13Edi: Result := TISEan13Edi.Create;
//    default:
//      raise Exception
  end;
end;

{ TISPaletTipo }

constructor TISPaletTipo.Create;
begin
  inherited Create(Ord(isidPaletTipos));

  TablaOrigen := 'frf_tipo_palets';
  TablaDestino := 'frf_tipo_palets';
  CadenaCamposClave := 'codigo_tp';
  //Ini;
end;

function TISPaletTipo.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISPaletTipo.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISViaTipo }

constructor TISViaTipo.Create;
begin
  inherited Create(Ord(isidViaTipos));

  TablaOrigen := 'frf_vias';
  TablaDestino := 'frf_vias';
  CadenaCamposClave := 'via_v';
  //Ini;
end;

function TISViaTipo.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISViaTipo.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISTransportista }

constructor TISTransportista.Create;
begin
  inherited Create(Ord(isidTransportista));
  TablaOrigen := 'frf_transportistas';
  TablaDestino := 'frf_transportistas';
  CadenaCamposClave := 'transporte_t';
  //Ini;
end;

function TISTransportista.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISTransportista.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISRepresentante }

constructor TISRepresentante.Create;
begin
  inherited Create(Ord(isidRepresentante));
  TablaOrigen := 'frf_representantes';
  TablaDestino := 'frf_representantes';
  CadenaCamposClave := 'representante_r';
  //Ini;
end;

function TISRepresentante.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISRepresentante.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISProvincia }

constructor TISProvincia.Create;
begin
  inherited Create(Ord(isidProvincia));
  TablaOrigen := 'frf_provincias';
  TablaDestino := 'frf_provincias';
  CadenaCamposClave := 'codigo_p';
  //Ini;
end;

function TISProvincia.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISProvincia.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISPais }

constructor TISPais.Create;
begin
  inherited Create(Ord(isidPais));
  TablaOrigen := 'frf_paises';
  TablaDestino := 'frf_paises';
  CadenaCamposClave := 'pais_p';
  //Ini;
end;

function TISPais.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISPais.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISMoneda }

constructor TISMoneda.Create;
begin
  inherited Create(Ord(isidMoneda));
  TablaOrigen := 'frf_monedas';
  TablaDestino := 'frf_monedas';
  CadenaCamposClave := 'moneda_m';
  //Ini;
end;

function TISMoneda.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISMoneda.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISFormaPAgo }

constructor TISFormaPAgo.Create;
begin
  inherited Create(Ord(isidFormaPago));
  TablaOrigen := 'frf_forma_pago';
  TablaDestino := 'tforma_pagos';
  CadenaCamposClave := 'codigo_fp';
  //Ini;
end;

function TISFormaPAgo.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISFormaPAgo.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISEmpresa }

constructor TISEmpresa.Create;
begin
  inherited Create(Ord(isidEmpresa));
  TablaOrigen := 'frf_empresas';
  TablaDestino := 'frf_empresas';
  CadenaCamposClave := 'empresa_e';
  //Ini;
end;

function TISEmpresa.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISEmpresa.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISComercial }

constructor TISComercial.Create;
begin
  inherited Create(Ord(isidComercial));
  TablaOrigen := 'frf_comerciales';
  TablaDestino := 'tcomerciales';
  CadenaCamposClave := 'codigo_c';
  //Ini;
end;

function TISComercial.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISComercial.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISClienteEdi }

constructor TISClienteEdi.Create;
begin
  inherited Create(Ord(isidClienteEdi));
  TablaOrigen := 'frf_clientes_edi';
  TablaDestino := 'frf_clientes_edis';
  CadenaCamposClave := 'empresa_ce,cliente_ce,dir_sum_ce';
  //Ini;
end;

function TISClienteEdi.GetClienteId: String;
begin
  Result := ValoresClave[1];
end;

function TISClienteEdi.GetDireccionSumId: String;
begin
  Result := ValoresClave[2];
end;

function TISClienteEdi.GetEmpresaId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISClienteEdi.SetClienteId(const Value: String);
begin
  ValoresClave[1] := Value;
end;

procedure TISClienteEdi.SetDireccionSumId(const Value: String);
begin
  ValoresClave[2] := Value;
end;

procedure TISClienteEdi.SetEmpresaId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

{ TISBanco }

constructor TISBanco.Create;
begin
  inherited Create(Ord(isidBanco));
  TablaOrigen := 'frf_bancos';
  TablaDestino := 'tbancos';
  CadenaCamposClave := 'banco_b';
  //Ini;
end;

function TISBanco.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISBanco.SetId(const Value: String);
begin
  ValoresClave.Clear;
  ValoresClave.Add(Value);
end;

{ TISCentro }

constructor TISCentro.Create;
begin
  inherited Create(Ord(isidCentro));
  TablaOrigen := 'frf_centros';
  TablaDestino := 'frf_centros';
  CadenaCamposClave := 'empresa_c,centro_c';
  //Ini;
end;

function TISCentro.GetCentroId: String;
begin
  Result := ValoresClave[0];
end;

function TISCentro.GetEmpresaId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISCentro.SetCentroId(const Value: String);
begin
  ValoresClave[1] := Value;
end;

procedure TISCentro.SetEmpresaId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

{ TISProdcuto }

constructor TISProducto.Create;
begin
  inherited Create(Ord(isidProducto));
  TablaOrigen := 'frf_productos';
  TablaDestino := 'frf_productos';
  CadenaCamposClave := 'producto_p';
  //Ini;
end;

function TISProducto.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISProducto.SetId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

{ TISProductoCategoria }

constructor TISProductoCategoria.Create;
begin
  inherited Create(Ord(isidProductoCategoria));
  TablaOrigen := 'frf_categorias';
  TablaDestino := 'frf_categorias';
  CadenaCamposClave := 'producto_c,categoria_c';
  //Ini;
end;

function TISProductoCategoria.GetCategoriaId: String;
begin
  Result := ValoresClave[1];
end;

function TISProductoCategoria.GetProductoId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISProductoCategoria.SetCategoriaId(const Value: String);
begin
  ValoresClave[1] := Value;
end;

procedure TISProductoCategoria.SetProductoId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

{ TISProductoColor }

constructor TISProductoColor.Create;
begin
  inherited Create(Ord(isidproductoColor));
  TablaOrigen := 'frf_colores';
  TablaDestino := 'frf_colores';
  CadenaCamposClave := 'producto_c,color_c';
  //Ini;
end;

function TISProductoColor.GetColorId: String;
begin
  Result := ValoresClave[1];
end;

function TISProductoColor.GetProductoId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISProductoColor.SetColorId(const Value: String);
begin
  ValoresClave[1] := Value;
end;

procedure TISProductoColor.SetProductoId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

{ TISProductoCalibre }

constructor TISProductoCalibre.Create;
begin
  inherited Create(Ord(isidProductoCalibre));
  TablaOrigen := 'frf_calibres';
  TablaDestino := 'frf_calibres';
  CadenaCamposClave := 'producto_c,calibre_c';
  //Ini;
end;

function TISProductoCalibre.GetCalibreId: String;
begin
  Result := ValoresClave[1];
end;

function TISProductoCalibre.GetProductoId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISProductoCalibre.SetCalibreId(const Value: String);
begin
  ValoresClave[1] := Value;
end;

procedure TISProductoCalibre.SetProductoId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

{ TISEnvase }

constructor TISEnvase.Create;
begin
  inherited Create(Ord(isidEnvase));
  TablaOrigen := 'frf_envases';
  TablaDestino := 'frf_envases';
  CadenaCamposClave := 'envase_e';
  //Ini;
end;

function TISEnvase.GetId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISEnvase.SetId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

{ TISCliente }

constructor TISCliente.Create;
begin
  inherited Create(Ord(isidCliente));
  TablaOrigen := 'frf_clientes';
  TablaDestino := 'frf_clientes';
  CadenaCamposClave := 'cliente_c';
  //Ini;
end;

function TISCliente.GetClienteId: String;
begin
  Result := ValoresClave[0];
end;

procedure TISCliente.SetClienteId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

{ TISDirSuministro }

constructor TISDirSuministro.Create;
begin
  inherited Create(Ord(isidDirSuministro));
  TablaOrigen := 'frf_dir_sum';
  TablaDestino := 'frf_dir_sums';
  CadenaCamposClave := 'cliente_ds,dir_sum_ds';
  //Ini;
end;

function TISDirSuministro.GetClienteId: String;
begin
  Result := ValoresClave[0];
end;

function TISDirSuministro.GetDirSuministroId: String;
begin
  Result := ValoresClave[1];
end;

procedure TISDirSuministro.SetClienteId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

procedure TISDirSuministro.SetDirSuministroId(const Value: String);
begin
  ValoresClave[1] := Value;
end;

{ TISDescuentoCliente }

procedure TISDescuentoCliente.AsignarParametros;
var
  fecha_ini_dc: TDate;
begin
  FQOrigen.ParamByName('empresa_dc').AsString := ValoresClave.Strings[0];
  FQDestino.Dataset.Params.ParamByName('empresa_dc').AsString := ValoresClave.Strings[0];

  FQOrigen.ParamByName('cliente_dc').AsString := ValoresClave.Strings[1];
  FQDestino.Dataset.Params.ParamByName('cliente_dc').AsString := ValoresClave.Strings[1];

  fecha_ini_dc := StrToDate(ValoresClave.Strings[2], FFormatSettings);
  FQOrigen.ParamByName('fecha_ini_dc').AsDate := fecha_ini_dc;
  FQDestino.Dataset.Params.ParamByName('fecha_ini_dc').asDate := fecha_ini_dc;
end;

constructor TISDescuentoCliente.Create;
begin
  inherited Create(Ord(isidDescuentoCliente));
  TablaOrigen := 'frf_descuentos_cliente';
  TablaDestino := 'frf_descuentos_clientes';
  CadenaCamposClave := 'empresa_dc,cliente_dc,fecha_ini_dc';
  //Ini;
end;

function TISDescuentoCliente.GetClienteId: String;
begin
  Result := ValoresClave[1];
end;

function TISDescuentoCliente.GetEmpresaId: String;
begin
  Result := ValoresClave[0];
end;

function TISDescuentoCliente.GetFechaInicio: TDate;
begin
  Result := StrToDate(ValoresClave.Strings[2], FFormatSettings);
end;

procedure TISDescuentoCliente.SetClienteId(const Value: String);
begin
  ValoresClave[1] := Value;
end;

procedure TISDescuentoCliente.SetEmpresaId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

procedure TISDescuentoCliente.SetFEchaInicio(const Value: TDate);
begin
  ValoresClave[2] := FormatDateTime('yyyy-mm-dd', Value);
end;

{ TISDescuentoProducto }

procedure TISDescuentoProducto.AsignarParametros;
var
  fecha_ini: TDate;
begin
  FQOrigen.ParamByName('empresa_dp').AsString := ValoresClave.Strings[0];
  FQDestino.Dataset.Params.ParamByName('empresa_dp').AsString := ValoresClave.Strings[0];

  FQOrigen.ParamByName('cliente_dp').AsString := ValoresClave.Strings[1];
  FQDestino.Dataset.Params.ParamByName('cliente_dp').AsString := ValoresClave.Strings[1];

  FQOrigen.ParamByName('producto_dp').AsString := ValoresClave.Strings[2];
  FQDestino.Dataset.Params.ParamByName('producto_dp').AsString := ValoresClave.Strings[2];

  fecha_ini := StrToDate(ValoresClave.Strings[3], FFormatSettings);
  FQOrigen.ParamByName('fecha_ini_dp').AsDate := fecha_ini;
  FQDestino.Dataset.Params.ParamByName('fecha_ini_dp').asDate := fecha_ini;
end;

constructor TISDescuentoProducto.Create;
begin
  inherited Create(Ord(isidDescuentoProducto));
  TablaOrigen := 'frf_descuentos_producto';
  TablaDestino := 'frf_descuentos_productos';
  CadenaCamposClave := 'empresa_dp,cliente_dp,producto_dp,fecha_ini_dp';
  //Ini;
end;

function TISDescuentoProducto.GetClienteId: String;
begin
  Result := ValoresClave[1];
end;

function TISDescuentoProducto.GetEmpresaId: String;
begin
  Result := ValoresClave[0];
end;

function TISDescuentoProducto.GetFechaInicio: TDate;
begin
  Result := StrToDate(ValoresClave.Strings[3], FFormatSettings);
end;

function TISDescuentoProducto.GetProductoId: String;
begin
  Result := ValoresClave[2];
end;

procedure TISDescuentoProducto.SetClienteId(const Value: String);
begin
  ValoresClave[1] := Value;
end;

procedure TISDescuentoProducto.SetEmpresaId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

procedure TISDescuentoProducto.SetFEchaInicio(const Value: TDate);
begin
  ValoresClave[3] := FormatDateTime('yyyy-mm-dd', Value);
end;

procedure TISDescuentoProducto.SetProductoId(const Value: String);
begin
  ValoresClave[2] := Value;
end;

{ TISunidadFacturacion }


constructor TISunidadFacturacion.Create;
begin
  inherited Create(Ord(isidUnidadFacturacion));
  TablaOrigen := 'frf_clientes_env';
  TablaDestino := 'frf_clientes_envs';
  CadenaCamposClave := 'empresa_ce,producto_ce,envase_ce,cliente_ce';
  //Ini;
end;

function TISunidadFacturacion.GetClienteId: String;
begin
  Result := ValoresClave[3];
end;

function TISunidadFacturacion.GetEmpresaId: String;
begin
  Result := ValoresClave[0];
end;

function TISunidadFacturacion.GetEnvaseId: String;
begin
  Result := ValoresClave[2];
end;

function TISunidadFacturacion.GetProductoId: String;
begin
  Result := ValoresClave[1];
end;

procedure TISunidadFacturacion.SetClienteId(const Value: String);
begin
  ValoresClave[3] := Value;
end;

procedure TISunidadFacturacion.SetEmpresaId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

procedure TISunidadFacturacion.SetEnvaseId(const Value: String);
begin
  ValoresClave[2] := Value;
end;

procedure TISunidadFacturacion.SetProductoId(const Value: String);
begin
  ValoresClave[1] := Value;
end;

{ TISEan13Edi }

constructor TISEan13Edi.Create;
begin
  inherited Create(Ord(isidEan13Edi));
  TablaOrigen := 'frf_ean13_edi';
  TablaDestino := 'frf_ean13';
  CadenaCamposClave := 'empresa_ee,cliente_fac_ee,envase_ee';
end;

function TISEan13Edi.GetClienteId: String;
begin
  Result := ValoresClave[1];
end;

function TISEan13Edi.GetEmpresaId: String;
begin
  Result := ValoresClave[0];
end;

function TISEan13Edi.GetEnvaseId: String;
begin
  Result := ValoresClave[2];
end;

procedure TISEan13Edi.SetClienteId(const Value: String);
begin
  ValoresClave[1] := Value;
end;

procedure TISEan13Edi.SetEmpresaId(const Value: String);
begin
  ValoresClave[0] := Value;
end;

procedure TISEan13Edi.SetEnvaseId(const Value: String);
begin
  ValoresClave[2] := Value;
end;

end.
