       //piña f18 centro 2
unit MargenBeneficiosCentralDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable, MargenBeneficiosDL, MargenBCodeComunDL;

type
  TDLMargenBeneficiosCentral = class(TDataModule)
    mtPaletsConfeccionados: TkbmMemTable;
    mtPaletsProveedor: TkbmMemTable;
    QAux: TQuery;
    mtResumen: TkbmMemTable;
    DSMaster: TDataSource;
    mtPrecios: TkbmMemTable;
    QImportes: TQuery;
    mtEntregas: TkbmMemTable;
    QCostesEnvasado: TQuery;
    mtCostesEnvasado: TkbmMemTable;
    QCajasRF: TQuery;
    QCostePrevisto: TQuery;
    qryKilosTeoricosCaja: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    bSemanal: Boolean;
    iAnyoSemana: integer;
    sEmpresa, sCliente, sClientes, sProducto, sProductoBase: string;
    dFechaIni, dFechaFin: TDateTime;
    CostesAplicar: RCostesAplicar;
    bFacturasFruta, bCosteEnvasado: boolean;

    procedure CerrarTablas;

    procedure QueryCostes;
    procedure InicializarValoresResumen;
    procedure CalculoMargenes;
    function  ProductosConfeccionados: boolean;
    procedure ClientesConfeccionados( const AFechaIni, AFechaFin: TDateTime );
    procedure PaletsConfeccionados( const ADetalle: boolean );
    procedure PaletsProveedor( const ADetalle: boolean );

    procedure PrecioEntrega( const AEntrega: string; var VPrevision: Boolean; var VPrecioCompra, VPrecioTransporte, VPrecioTransito, VPrecioEstadistico: real );
    procedure ActualizarPrecios( const AEmpresa, AProducto, AProveedor: String; const APrecioFruta, APrecioTransporte: real; const APrevision: boolean );

    procedure CosteEnvasado( const APlanta, ACentro, AEnvase, AProducto: string; const AProductoBase: integer;
                             const AFecha: TDateTime; var VPrecioMaterial, VPrecioPersonal, VPrecioGeneral: real );
    function  ImporteAbonos( const AProducto, AAnyoSemana: string ): Real;

    function  GetKiloCajaTeorico( const AEntrega, AEmpresa, AProveedor, AProducto, AVariedad, ACategoria, ACalibre: string;
                                   var AEncontrado: boolean ): Real;
    function  KilosCajas: real;

  public
    { Public declarations }
  end;
function MargenBeneficiosCentral( const AOwner: TComponent; const APaletsEntrada, APaletsSalida: boolean;
                        const AEmpresa, ACliente, AProducto: string;
                        const AFechaIni, AFechaFin: TDateTime;
                        const ASemanal, AExpandir, APrecioUnidad: boolean;
                        const ACostesAplicar: RCostesAplicar  ): boolean;

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

function MargenSemanal( const AOwner: TComponent; const APaletsEntrada, APaletsSalida: boolean;
                        const AEmpresa, ACliente, AProducto: string;
                        const AFechaIni, AFechaFin: TDateTime; const AExpandir: boolean;
                        const ACostesAplicar: RCostesAplicar  ): boolean;

function MargenPeriodo( const AOwner: TComponent; const APaletsEntrada, APaletsSalida: boolean;
                        const AEmpresa, ACliente, AProducto: string;
                        const AFechaIni, AFechaFin: TDateTime;
                        const APrecioUnidad: boolean  ): boolean;

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

var
  DLMargenBeneficiosCentral: TDLMargenBeneficiosCentral;

implementation

{$R *.dfm}

uses
  MargenSemanalCentralQL, MargenPeriodoCentralQL, variants, bMath, UDMBaseDatos,
  DateUtils, UDMAuxDB, dialogs, bTimeUtils;

(*
var
  DLCosteFrutaProducto: TDLCosteFrutaProducto;
*)


function MargenSemanal( const AOwner: TComponent; const APaletsEntrada, APaletsSalida: boolean;
                        const AEmpresa, ACliente, AProducto: string;
                        const AFechaIni, AFechaFin: TDateTime;
                        const AExpandir: boolean;
                        const ACostesAplicar: RCostesAplicar  ): boolean;
begin
  result:= MargenBeneficiosCentral( AOwner,APaletsEntrada, APaletsSalida, AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, True, AExpandir, False, ACostesAplicar );
end;

function MargenPeriodo( const AOwner: TComponent; const APaletsEntrada, APaletsSalida: boolean;
                        const AEmpresa, ACliente, AProducto: string;
                        const AFechaIni, AFechaFin: TDateTime;
                        const APrecioUnidad: boolean  ): boolean;
var
  CostesAplicar: RCostesAplicar;
begin
  CostesAplicar.bCompra:= True;
  CostesAplicar.bTransporte:= True;
  CostesAplicar.bTransito:= True;
  CostesAplicar.bMaterial:= True;
  CostesAplicar.bPersonal:= True;
  CostesAplicar.bGeneral:= True;
  CostesAplicar.bFinanciero:= True;
  CostesAplicar.bEstadistico:= False;
  result:= MargenBeneficiosCentral( AOwner,APaletsEntrada, APaletsSalida, AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, False, False, APrecioUnidad, CostesAplicar );
end;


function MargenBeneficiosCentral( const AOwner: TComponent; const APaletsEntrada, APaletsSalida : boolean;
                        const AEmpresa, ACliente, AProducto: string;
                        const AFechaIni, AFechaFin: TDateTime;
                        const ASemanal, AExpandir, APrecioUnidad: boolean;
                        const ACostesAplicar: RCostesAplicar  ): boolean;
var
  iYear: Word;
begin
  DLMargenBeneficiosCentral:= TDLMargenBeneficiosCentral.Create( AOwner );
  try
    //DLCosteFrutaProducto:= TDLCosteFrutaProducto.Create( AOwner );
    with DLMargenBeneficiosCentral do
    begin
      CostesAplicar:=  ACostesAplicar;
      bFacturasFruta:= ( CostesAplicar.bCompra or CostesAplicar.bTransporte or CostesAplicar.bEstadistico );
      bCosteEnvasado:= ( CostesAplicar.bMaterial or CostesAplicar.bPersonal or CostesAplicar.bMaterial or CostesAplicar.bFinanciero );
      QueryCostes;

      sEmpresa:= AEmpresa;
      sProducto:= AProducto;
      sCliente:= ACliente;
      sProductoBase:= GetProductoBase( sEmpresa, sProducto );

      ClientesConfeccionados( AFechaIni, AFechaFin );

      dFechaIni:= AFechaIni;
      bSemanal:= ASemanal;
      if ASemanal then
      begin
        dFechaFin:= AFechaIni + 6;

        while dFechaFin <= AFechaFin do
        begin
          iAnyoSemana:=  WeekOfTheYear( dFechaIni, iYear );
          iAnyoSemana:= iYear * 100 + iAnyoSemana;

          ProductosConfeccionados;
          PaletsConfeccionados( APaletsSalida );
          PaletsProveedor( APaletsEntrada );

          dFechaIni:= dFechaFin + 1;
          dFechaFin:= dFechaIni + 6;
        end;
      end
      else
      begin
        dFechaFin:= AFechaFin;
        iAnyoSemana:=  WeekOfTheYear( dFechaIni, iYear );
        iAnyoSemana:= iYear * 100 + iAnyoSemana;

        ProductosConfeccionados;
        PaletsConfeccionados( APaletsSalida );
        PaletsProveedor( APaletsEntrada );
      end;

      result:= not mtResumen.IsEmpty;
      if result then
      begin
        if APaletsSalida then
        begin
          mtPaletsConfeccionados.Filter:= '';
          mtPaletsConfeccionados.Filtered:= True;
        end;
        if APaletsEntrada then
        begin
          mtPaletsProveedor.Filter:= '';
          mtPaletsProveedor.Filtered:= True;
        end;
        mtPrecios.Filter:= '';
        mtPrecios.Filtered:= True;

        mtResumen.SortFields:= 'producto;anyosemana';
        mtResumen.Sort([]);
        CalculoMargenes;
        if ASemanal then
          MargenSemanalCentralQL.VerMargenSemanal( AOwner, APaletsEntrada, APaletsSalida, AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, AExpandir )
        else
          MargenPeriodoCentralQL.VerMargenPeriodo( AOwner, APaletsEntrada, APaletsSalida, AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, APrecioUnidad );

        mtPaletsConfeccionados.Filtered:= False;
        mtPaletsConfeccionados.Filter:= '';
        mtPaletsProveedor.Filtered:= False;
        mtPaletsProveedor.Filter:= '';
        mtPrecios.Filtered:= False;
        mtPrecios.Filter:= '';
      end;
    end;
  finally
    //FreeAndNil( DLCosteFrutaProducto );
    DLMargenBeneficiosCentral.CerrarTablas;
    FreeAndNil( DLMargenBeneficiosCentral );
  end;
end;

procedure TDLMargenBeneficiosCentral.CerrarTablas;
begin
  QAux.Close;

  mtCostesEnvasado.Close;
  mtPrecios.Close;
  mtPaletsProveedor.Close;
  mtPaletsConfeccionados.Close;
  mtResumen.Close;
  mtEntregas.Close;

  if DMBaseDatos.dbF17.Connected then
   DMBaseDatos.dbF17.Connected:= false;
  if DMBaseDatos.dbF18.Connected then
   DMBaseDatos.dbF18.Connected:= false;
  (*
  if DMBaseDatos.dbF21.Connected then
   DMBaseDatos.dbF21.Connected:= false;
  *)
  if DMBaseDatos.dbF23.Connected then
   DMBaseDatos.dbF23.Connected:= false;
  (*
  if DMBaseDatos.dbF24.Connected then
   DMBaseDatos.dbF24.Connected:= false;
  *)
end;


procedure TDLMargenBeneficiosCentral.QueryCostes;
begin
  //Costes de envasado
  with QCostesEnvasado do
  begin
    SQL.Clear;
    SQL.Add(' select ec1.material_ec, ec1.personal_ec, ec1.general_ec ');
    SQL.Add(' from frf_env_costes ec1 ');
    SQL.Add(' where ec1.empresa_ec = :planta ');
    SQL.Add(' and ( ec1.anyo_ec * 100 + ec1.mes_Ec ) =  ( select max( ( ec2.anyo_ec * 100 ) + ec2.mes_Ec ) ');
    SQL.Add('                  from frf_env_costes ec2 ');
    SQL.Add('                  where ec2.empresa_ec = :planta ');
    //SQL.Add('                  and ( ec2.anyo_ec * 100 ) + ec2.mes_Ec < ( Year( :fecha ) * 100 ) + month( :fecha ) ');
    SQL.Add('                  and ( ec2.anyo_ec * 100 ) + ec2.mes_Ec <= :anyomes ');
    SQL.Add('                  and ec2.centro_ec = :centro ');
    SQL.Add('                  and ec2.envase_ec = :envase ');
    //SQL.Add('                  and ec2.producto_base_ec = ec1.producto_base_ec ) ');
    SQL.Add('                  and ec2.producto_ec = :producto ) ');
    SQL.Add(' and ec1.centro_ec = :centro ');
    SQL.Add(' and ec1.envase_ec = :envase ');
    SQL.Add(' and ec1.producto_ec = :producto ');
    (*
    SQL.Add(' and ec1.producto_base_ec = ( select producto_base_p ');
    SQL.Add('                          from frf_productos ');
    SQL.Add('                          where empresa_p = :planta ');
    SQL.Add('                          and producto_p = :producto ) ');
    *)
  end;
end;

procedure TDLMargenBeneficiosCentral.DataModuleCreate(Sender: TObject);
begin
  mtResumen.FieldDefs.Clear;
  mtResumen.FieldDefs.Add('anyosemana', ftInteger, 0, False);
  mtResumen.FieldDefs.Add('producto', ftString, 3, False);
  mtResumen.FieldDefs.Add('producto_base', ftInteger, 0, False);

  mtResumen.FieldDefs.Add('cajas_albaran', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('unidades_albaran', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('peso_albaran', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('kilos_albaran', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('importe_albaranes', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('importe_abonos', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('importe_venta', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('importe_compra', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('importe_transporte', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('importe_transito', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('coste_producto', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('margen_producto', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('coste_material', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('coste_personal', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('coste_envasado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('margen_bruto', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('coste_general', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('coste_financiero', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('margen_operativo', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('importe_estadistico', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('cajas_confecionado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('unidades_confecionado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('peso_confecionado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('kilos_confecionado', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('cajas_confecionado_anterior', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('unidades_confecionado_anterior', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('peso_confecionado_anterior', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('kilos_confecionado_anterior', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('cajas_confecionado_adelantado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('unidades_confecionado_adelantado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('peso_confecionado_adelantado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('kilos_confecionado_adelantado', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('cajas_volcado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('unidades_volcado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('peso_volcado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('kilos_volcado', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('cajas_volcado_anterior', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('unidades_volcado_anterior', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('peso_volcado_anterior', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('kilos_volcado_anterior', ftFloat, 0, False);

  mtResumen.FieldDefs.Add('cajas_volcado_adelantado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('unidades_volcado_adelantado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('peso_volcado_adelantado', ftFloat, 0, False);
  mtResumen.FieldDefs.Add('kilos_volcado_adelantado', ftFloat, 0, False);
  mtResumen.CreateTable;

  mtPrecios.FieldDefs.Clear;
  mtPrecios.FieldDefs.Add('producto_precio', ftString, 3, False);
  mtPrecios.FieldDefs.Add('proveedor_precio', ftString, 3, False);
  mtPrecios.FieldDefs.Add('empresa_precio', ftString, 3, False);
  mtPrecios.FieldDefs.Add('precio_maximo', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_minimo', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_maximo_previsto', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_minimo_previsto', ftFloat, 0, False);

  mtPrecios.FieldDefs.Add('precio_fruta_max', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_fruta_min', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_fruta_max_previsto', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_fruta_min_previsto', ftFloat, 0, False);

  mtPrecios.FieldDefs.Add('precio_transporte_max', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_transporte_min', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_transporte_max_previsto', ftFloat, 0, False);
  mtPrecios.FieldDefs.Add('precio_transporte_min_previsto', ftFloat, 0, False);
  mtPrecios.CreateTable;

  mtEntregas.FieldDefs.Clear;
  mtEntregas.FieldDefs.Add('entrega', ftString, 12, False);
  mtEntregas.FieldDefs.Add('cajas', ftInteger, 0, False);
  mtEntregas.FieldDefs.Add('prevision', ftInteger, 0, False);
  mtEntregas.FieldDefs.Add('importe_compra', ftFloat, 0, False);
  mtEntregas.FieldDefs.Add('precio_compra', ftFloat, 0, False);
  mtEntregas.FieldDefs.Add('importe_transporte', ftFloat, 0, False);
  mtEntregas.FieldDefs.Add('precio_transporte', ftFloat, 0, False);
  mtEntregas.FieldDefs.Add('importe_transito', ftFloat, 0, False);
  mtEntregas.FieldDefs.Add('precio_transito', ftFloat, 0, False);
  mtEntregas.FieldDefs.Add('importe_estadistico', ftFloat, 0, False);
  mtEntregas.FieldDefs.Add('precio_estadistico', ftFloat, 0, False);
  mtEntregas.CreateTable;

  mtPaletsProveedor.FieldDefs.Clear;
  mtPaletsProveedor.FieldDefs.Add('anyosemana_in', ftInteger, 0, False);
  mtPaletsProveedor.FieldDefs.Add('producto_in', ftString, 3, False);
  mtPaletsProveedor.FieldDefs.Add('grupo_in', ftInteger, 0, False);
  mtPaletsProveedor.FieldDefs.Add('fecha_in', ftDate, 0, False);
  mtPaletsProveedor.FieldDefs.Add('empresa_in', ftString, 3, False);
  mtPaletsProveedor.FieldDefs.Add('centro_in', ftString, 3, False);
  mtPaletsProveedor.FieldDefs.Add('entrega_in', ftString, 12, False);
  mtPaletsProveedor.FieldDefs.Add('sscc_in', ftString, 20, False);
  mtPaletsProveedor.FieldDefs.Add('proveedor_in', ftString, 3, False);
  mtPaletsProveedor.FieldDefs.Add('variedad_in', ftInteger, 0, False);
  mtPaletsProveedor.FieldDefs.Add('calibre_in', ftString, 6, False);
  mtPaletsProveedor.FieldDefs.Add('cajas_in', ftInteger, 0, False);
  mtPaletsProveedor.FieldDefs.Add('unidades_in', ftInteger, 0, False);
  mtPaletsProveedor.FieldDefs.Add('peso_in', ftFloat, 0, False);
  mtPaletsProveedor.FieldDefs.Add('precio_in', ftFloat, 0, False);
  mtPaletsProveedor.FieldDefs.Add('importe_in', ftFloat, 0, False);
  mtPaletsProveedor.FieldDefs.Add('peso_bruto_in', ftFloat, 0, False);
  mtPaletsProveedor.FieldDefs.Add('status_in', ftString, 1, False);
  mtPaletsProveedor.CreateTable;

  mtPaletsConfeccionados.FieldDefs.Clear;
  mtPaletsConfeccionados.FieldDefs.Add('anyosemana_out', ftInteger, 0, False);
  mtPaletsConfeccionados.FieldDefs.Add('producto_out', ftString, 3, False);
  mtPaletsConfeccionados.FieldDefs.Add('grupo_out', ftInteger, 0, False);
  mtPaletsConfeccionados.FieldDefs.Add('fecha_alta_out', ftDate, 0, False);
  mtPaletsConfeccionados.FieldDefs.Add('fecha_carga_out', ftDate, 0, False);
  mtPaletsConfeccionados.FieldDefs.Add('empresa_out', ftString, 3, False);
  mtPaletsConfeccionados.FieldDefs.Add('centro_out', ftString, 3, False);
  mtPaletsConfeccionados.FieldDefs.Add('orden_out', ftString, 12, False);
  mtPaletsConfeccionados.FieldDefs.Add('ean128_out', ftString, 20, False);
  mtPaletsConfeccionados.FieldDefs.Add('ean13_out', ftString, 13, False);

  mtPaletsConfeccionados.FieldDefs.Add('formato_out', ftInteger, 0, False);
  mtPaletsConfeccionados.FieldDefs.Add('envase_out', ftString, 9,  False);
  mtPaletsConfeccionados.FieldDefs.Add('cajas_out', ftInteger, 0, False);
  mtPaletsConfeccionados.FieldDefs.Add('unidades_out', ftInteger, 0, False);
  mtPaletsConfeccionados.FieldDefs.Add('peso_out', ftFloat, 0, False);
  mtPaletsConfeccionados.FieldDefs.Add('peso_teorico_out', ftFloat, 0, False);
  mtPaletsConfeccionados.FieldDefs.Add('importe_out', ftFloat, 0, False);
  mtPaletsConfeccionados.FieldDefs.Add('status_out', ftString, 1, False);
  mtPaletsConfeccionados.CreateTable;


  mtCostesEnvasado.FieldDefs.Clear;
  mtCostesEnvasado.FieldDefs.Add('anyomes', ftInteger, 0, False);
  mtCostesEnvasado.FieldDefs.Add('planta', ftString, 3, False);
  mtCostesEnvasado.FieldDefs.Add('centro', ftString, 3, False);
  mtCostesEnvasado.FieldDefs.Add('envase', ftString, 9,  False);
  mtCostesEnvasado.FieldDefs.Add('producto', ftString, 0, False);
  mtCostesEnvasado.FieldDefs.Add('material', ftFloat, 0, False);
  mtCostesEnvasado.FieldDefs.Add('personal', ftFloat, 0, False);
  mtCostesEnvasado.FieldDefs.Add('general', ftFloat, 0, False);
  mtCostesEnvasado.CreateTable;

  with qryKilosTeoricosCaja do
  begin
    SQL.Clear;
    SQL.Add(' select categoria_el categoria, calibre_el calibre, sum(kilos_el) kilos, sum( cajas_el ) cajas ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el = :entrega ');
    SQL.Add(' and empresa_el = :empresa ');
    SQL.Add(' and  proveedor_el = :proveedor ');
    SQL.Add(' and  producto_el = :producto ');
    SQL.Add(' and  variedad_el = :variedad ');
    SQL.Add(' group by 1,2 ');
    SQL.Add(' order by 1,2 ');
  end;
end;

procedure TDLMargenBeneficiosCentral.InicializarValoresResumen;
begin
  mtResumen.FieldByName('anyosemana').AsInteger:= 0;
  mtResumen.FieldByName('producto').AsString:= '';
  mtResumen.FieldByName('producto_base').AsString:= '';

  mtResumen.FieldByName('kilos_albaran').AsFloat:= 0;
  mtResumen.FieldByName('peso_albaran').AsFloat:= 0;
  mtResumen.FieldByName('cajas_albaran').AsFloat:= 0;
  mtResumen.FieldByName('unidades_albaran').AsFloat:= 0;

  mtResumen.FieldByName('importe_albaranes').AsFloat:= 0;
  mtResumen.FieldByName('importe_abonos').AsFloat:= 0;
  mtResumen.FieldByName('importe_venta').AsFloat:= 0;

  mtResumen.FieldByName('importe_compra').AsFloat:= 0;
  mtResumen.FieldByName('importe_transporte').AsFloat:= 0;
  mtResumen.FieldByName('importe_transito').AsFloat:= 0;
  mtResumen.FieldByName('coste_producto').AsFloat:= 0;
  mtResumen.FieldByName('margen_producto').AsFloat:= 0;


  mtResumen.FieldByName('coste_material').AsFloat:= 0;
  mtResumen.FieldByName('coste_personal').AsFloat:= 0;
  mtResumen.FieldByName('coste_envasado').AsFloat:= 0;
  mtResumen.FieldByName('margen_bruto').AsFloat:= 0;

  mtResumen.FieldByName('coste_general').AsFloat:= 0;
  mtResumen.FieldByName('coste_financiero').AsFloat:= 0;
  mtResumen.FieldByName('margen_operativo').AsFloat:= 0;


  mtResumen.FieldByName('importe_estadistico').AsFloat:= 0;

  mtResumen.FieldByName('cajas_confecionado').AsFloat:= 0;
  mtResumen.FieldByName('unidades_confecionado').AsFloat:= 0;
  mtResumen.FieldByName('peso_confecionado').AsFloat:= 0;
  mtResumen.FieldByName('kilos_confecionado').AsFloat:= 0;

  mtResumen.FieldByName('cajas_confecionado_anterior').AsFloat:= 0;
  mtResumen.FieldByName('unidades_confecionado_anterior').AsFloat:= 0;
  mtResumen.FieldByName('peso_confecionado_anterior').AsFloat:= 0;
  mtResumen.FieldByName('kilos_confecionado_anterior').AsFloat:= 0;

  mtResumen.FieldByName('cajas_confecionado_adelantado').AsFloat:= 0;
  mtResumen.FieldByName('unidades_confecionado_adelantado').AsFloat:= 0;
  mtResumen.FieldByName('peso_confecionado_adelantado').AsFloat:= 0;
  mtResumen.FieldByName('kilos_confecionado_adelantado').AsFloat:= 0;

  mtResumen.FieldByName('cajas_volcado').AsFloat:= 0;
  mtResumen.FieldByName('unidades_volcado').AsFloat:= 0;
  mtResumen.FieldByName('peso_volcado').AsFloat:= 0;
  mtResumen.FieldByName('kilos_volcado').AsFloat:= 0;

  mtResumen.FieldByName('cajas_volcado_anterior').AsFloat:= 0;
  mtResumen.FieldByName('unidades_volcado_anterior').AsFloat:= 0;
  mtResumen.FieldByName('peso_volcado_anterior').AsFloat:= 0;
  mtResumen.FieldByName('kilos_volcado_anterior').AsFloat:= 0;

  mtResumen.FieldByName('cajas_volcado_adelantado').AsFloat:= 0;
  mtResumen.FieldByName('unidades_volcado_adelantado').AsFloat:= 0;
  mtResumen.FieldByName('peso_volcado_adelantado').AsFloat:= 0;
  mtResumen.FieldByName('kilos_volcado_adelantado').AsFloat:= 0;
end;

function TDLMargenBeneficiosCentral.ImporteAbonos( const AProducto, AAnyoSemana: string ): Real;
var
  dFecha: TDateTime;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_fal) importe');
    SQL.Add(' from frf_fac_abonos_l, frf_facturas ');

    SQL.Add(' where empresa_fal = :empresa ');
    if AProducto = 'PIN' then
      SQL.Add(' and producto_fal in (''PIN'', ''PPE'') ')
    else
      SQL.Add(' and producto_fal = :producto ');
    SQL.Add(' and fecha_albaran_fal between :fecha_ini and :fecha_fin ');

    SQL.Add(' and empresa_fal = empresa_f ');
    SQL.Add(' and factura_fal = n_factura_f ');
    SQL.Add(' and fecha_fal = fecha_factura_f ');

    if sClientes <> '' then
      SQL.Add(' and cliente_fac_f in ( ' + sClientes + ') ');


    ParamByName('empresa').AsString:= sEmpresa;
    if AProducto <> 'PIN' then
      ParamByName('producto').AsString:= AProducto;
    if bSemanal then
    begin
      dFecha:= LunesAnyoSemana( AAnyoSemana );
      ParamByName('fecha_ini').AsDate:= dFecha;
      ParamByName('fecha_fin').AsDate:= dFecha + 6;
    end
    else
    begin
      ParamByName('fecha_ini').AsDate:= dFechaIni;
      ParamByName('fecha_fin').AsDate:= dFechaFin;
    end;
    Open;
    result:= FieldByName('importe').AsFloat;
    Close;
  end;
end;

procedure TDLMargenBeneficiosCentral.CalculoMargenes;
var
  bAux: boolean;
begin
  bAux:= mtResumen.Filtered;
  mtResumen.First;
  while not mtResumen.Eof do
  begin
    mtResumen.Edit;
    mtResumen.FieldByName('coste_producto').AsFloat:= mtResumen.FieldByName('importe_compra').AsFloat +
                                                      mtResumen.FieldByName('importe_transporte').AsFloat +
                                                      mtResumen.FieldByName('importe_transito').AsFloat;

    mtResumen.FieldByName('importe_abonos').AsFloat:= ImporteAbonos( mtResumen.FieldByName('producto').AsString, mtResumen.FieldByName('anyosemana').AsString );

    mtResumen.FieldByName('importe_venta').AsFloat:= mtResumen.FieldByName('importe_albaranes').AsFloat +
                                                     mtResumen.FieldByName('importe_abonos').AsFloat;

    mtResumen.FieldByName('margen_producto').AsFloat:= mtResumen.FieldByName('importe_venta').AsFloat -
                                                    mtResumen.FieldByName('coste_producto').AsFloat;

    mtResumen.FieldByName('coste_envasado').AsFloat:= mtResumen.FieldByName('coste_material').AsFloat +
                                                    mtResumen.FieldByName('coste_personal').AsFloat;

    mtResumen.FieldByName('margen_bruto').AsFloat:= mtResumen.FieldByName('margen_producto').AsFloat -
                                                    mtResumen.FieldByName('coste_envasado').AsFloat;

    mtResumen.FieldByName('margen_operativo').AsFloat:= mtResumen.FieldByName('margen_bruto').AsFloat -
                                                    mtResumen.FieldByName('coste_general').AsFloat -
                                                    mtResumen.FieldByName('coste_financiero').AsFloat;
    mtResumen.Post;
    mtResumen.Next;
  end;
  mtResumen.Filtered:= bAux;
end;

procedure TDLMargenBeneficiosCentral.CosteEnvasado( const APlanta, ACentro, AEnvase, AProducto: string; const AProductoBase: integer;
                                             const AFecha: TDateTime; var VPrecioMaterial, VPrecioPersonal, VPrecioGeneral: real );
var
  iAnyo, iMes, iDia: Word;
  iAnyoMes: integer;
  sProducto : string;
begin
  Decodedate( AFecha, iAnyo, iMes, iDia );
  iAnyoMes:= ( iAnyo * 100 ) + iMes;
  if mtCostesEnvasado.Locate('anyomes;planta;centro;envase;producto', VarArrayOf([iAnyoMes,APlanta, ACentro, AEnvase,AProducto]),[] ) then
  begin
    VPrecioMaterial:= mtCostesEnvasado.FieldByname('material').AsFloat;
    VPrecioPersonal:= mtCostesEnvasado.FieldByname('personal').AsFloat;
    VPrecioGeneral:= mtCostesEnvasado.FieldByname('general').AsFloat;
  end
  else
  begin
    with QCostesEnvasado do
    begin
      SQL.Clear;
      SQL.Add(' select ec1.material_ec, ec1.personal_ec, ec1.general_ec ');
      SQL.Add(' from frf_env_costes ec1 ');
      SQL.Add(' where ec1.empresa_ec = :planta ');
      SQL.Add(' and ( ec1.anyo_ec * 100 + ec1.mes_Ec ) =  ( select max( ( ec2.anyo_ec * 100 ) + ec2.mes_Ec ) ');
      SQL.Add('                  from frf_env_costes ec2 ');
      SQL.Add('                  where ec2.empresa_ec = :planta ');
      SQL.Add('                  and ( ec2.anyo_ec * 100 ) + ec2.mes_Ec <= :anyomes ');
      SQL.Add('                  and ec2.centro_ec = :centro ');
      SQL.Add('                  and ec2.envase_ec = :envase ');
      SQL.Add('                  and ec2.producto_ec = :producto ) ');
      SQL.Add(' and ec1.centro_ec = :centro ');
      SQL.Add(' and ec1.envase_ec = :envase ');
      SQL.Add(' and ec1.producto_ec = :producto ');


      ParamByName('planta').AsString:= APlanta;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('envase').AsString:= AEnvase;
      ParamByName('producto').AsString:= AProducto;
      ParamByName('anyomes').AsInteger:= iAnyoMes;
      Open;

      VPrecioMaterial:= FieldByName('material_ec').AsFloat;
      VPrecioPersonal:= FieldByName('personal_ec').AsFloat;
      VPrecioGeneral:= FieldByName('general_ec').AsFloat;

      mtCostesEnvasado.Insert;
      mtCostesEnvasado.FieldByname('anyomes').AsInteger:= iAnyoMes;
      mtCostesEnvasado.FieldByname('planta').AsString:= APlanta;
      mtCostesEnvasado.FieldByname('centro').AsString:= ACentro;
      mtCostesEnvasado.FieldByname('envase').AsString:= AEnvase;
      mtCostesEnvasado.FieldByname('producto').AsString:= AProducto;
      mtCostesEnvasado.FieldByname('material').AsFloat:= VPrecioMaterial;
      mtCostesEnvasado.FieldByname('personal').AsFloat:= VPrecioPersonal;
      mtCostesEnvasado.FieldByname('general').AsFloat:= VPrecioGeneral;
      mtCostesEnvasado.Post;
      Close;
    end;
  end;
end;

function TDLMargenBeneficiosCentral.ProductosConfeccionados: boolean;
var
  rMaterial, rPersonal, rGeneral: real;
  rPrecioFinanciero, rImporteFinanciero: real;
  Producto: String;
begin
  mtResumen.Open;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_sl producto,');
    SQL.Add('       ( select producto_base_p ');
    SQL.Add('          from frf_productos ');
    SQL.Add('          where producto_p = producto_sl ) producto_base, ');
    SQL.Add('       empresa_sl, centro_salida_sl, envase_sl, fecha_sl, ');  // -->> Para los costes
    SQL.Add('       sum( kilos_sl ) peso, ');
    SQL.Add('       sum( cajas_sl ) cajas, ');
    SQL.Add('       sum( unidades_caja_sl * cajas_sl ) unidades, ');
    SQL.Add('       sum( ( select nvl(peso_neto_e,1) * cajas_sl ');
    SQL.Add('            from frf_envases ');
    SQL.Add('            where envase_e = envase_sl ');
    SQL.Add('              and producto_e = producto_sl ) ) kilos, ');
    SQL.Add('       SUM(  Round( NVL(importe_neto_sl,0)* ');
    SQL.Add('             (1-(GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100))* ');
    SQL.Add('             (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 1 )/100)), 2) ) neto ');

    SQL.Add('  from frf_salidas_c, frf_salidas_l ');
    SQL.Add('  where empresa_sc = :empresa ');
    SQL.Add('  and fecha_sc between :fechaini and :fechafin ');

    //Clientes volcados
    if sClientes <> '' then
      SQL.Add('  and ( cliente_sal_sc in ( ' + sClientes + ' ) )');


    SQL.Add('  and empresa_sl = :empresa ');
    SQL.Add('  and centro_salida_sl = centro_salida_sc ');
    SQL.Add('  and fecha_sl = fecha_sc ');
    SQL.Add('  and n_albaran_sl = n_albaran_sc ');
    if sProducto <> '' then
    begin
      if sProducto = 'PIN' then
        SQL.Add(' and producto_sl in (''PIN'', ''PPE'') ')
       else
        SQL.Add('  and producto_sl = :producto ');
    end;
    //NO PIÑAN
    if ( sEmpresa = 'F18' ) then
    begin
      SQL.Add('  and envase_sl <> ''385'' ');
    end;
    SQL.Add(' group by 1,2,3,4,5,6 ');
    SQL.Add(' order by 1 ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('fechaini').AsdateTime:= dFechaIni;
    ParamByName('fechafin').AsdateTime:= dFechaFin;
    if sProducto <> '' then
    begin
      if sProducto <> 'PIN' then      
        ParamByName('producto').AsString:= sProducto;
    end;
    Open;


    mtCostesEnvasado.Open;
    rPrecioFinanciero:= 0;
    if bCosteEnvasado then
      rPrecioFinanciero:= CosteFinanciero( FieldByName('empresa_sl').AsString, FieldByName('fecha_sl').AsDateTime );
    while not eof do
    begin

      Producto := FieldByName('producto').AsString;
      if FieldByName('producto').AsString = 'PPE' then
        Producto := 'PIN';

      if bCosteEnvasado then
        CosteEnvasado( FieldByName('empresa_sl').AsString,
                     FieldByName('centro_salida_sl').AsString ,
                     FieldByName('envase_sl').AsString,
                     FieldByName('producto').AsString,
                     FieldByName('producto_Base').AsInteger,
                     FieldByName('fecha_sl').AsDateTime,
                     rMaterial, rPersonal, rGeneral );

      if CostesAplicar.bMaterial then
        rMaterial:= bRoundTo( rMaterial * FieldByName('peso').AsFloat, 2);
      if CostesAplicar.bPersonal then
        rPersonal:= bRoundTo( rPersonal * FieldByName('peso').AsFloat, 2);
      if CostesAplicar.bGeneral then
        rGeneral:= bRoundTo( rGeneral * FieldByName('peso').AsFloat, 2);
      rImporteFinanciero:= 0;
      if CostesAplicar.bFinanciero then
        rImporteFinanciero:= bRoundTo( rPrecioFinanciero * FieldByName('peso').AsFloat, 2);


      if not mtResumen.Locate('anyosemana;producto', VarArrayOf([iAnyoSemana,Producto]),[] ) then
      begin
        mtResumen.Insert;
        InicializarValoresResumen;

        mtResumen.FieldByName('anyosemana').AsInteger:= iAnyoSemana;
        mtResumen.FieldByName('producto').AsString:= Producto;
        mtResumen.FieldByName('producto_base').AsString:= FieldByName('producto_base').AsString;

        mtResumen.FieldByName('kilos_albaran').AsFloat:= FieldByName('kilos').AsFloat;
        mtResumen.FieldByName('peso_albaran').AsFloat:= FieldByName('peso').AsFloat;
        mtResumen.FieldByName('cajas_albaran').AsFloat:= FieldByName('cajas').AsFloat;
        mtResumen.FieldByName('unidades_albaran').AsFloat:= FieldByName('unidades').AsFloat;

        mtResumen.FieldByName('importe_albaranes').AsFloat:= FieldByName('neto').AsFloat;
        mtResumen.FieldByName('coste_material').AsFloat:= rMaterial;
        mtResumen.FieldByName('coste_personal').AsFloat:= rPersonal;
        mtResumen.FieldByName('coste_general').AsFloat:= rGeneral;
        mtResumen.FieldByName('coste_financiero').AsFloat:= rImporteFinanciero;

        mtResumen.Post;
      end
      else
      begin
        mtResumen.Edit;
        mtResumen.FieldByName('kilos_albaran').AsFloat:= mtResumen.FieldByName('kilos_albaran').AsFloat + FieldByName('kilos').AsFloat;
        mtResumen.FieldByName('peso_albaran').AsFloat:= mtResumen.FieldByName('peso_albaran').AsFloat + FieldByName('peso').AsFloat;
        mtResumen.FieldByName('cajas_albaran').AsFloat:= mtResumen.FieldByName('cajas_albaran').AsFloat + FieldByName('cajas').AsFloat;;
        mtResumen.FieldByName('unidades_albaran').AsFloat:= mtResumen.FieldByName('unidades_albaran').AsFloat + FieldByName('unidades').AsFloat;

        mtResumen.FieldByName('importe_albaranes').AsFloat:= mtResumen.FieldByName('importe_albaranes').AsFloat + FieldByName('neto').AsFloat;
        mtResumen.FieldByName('coste_material').AsFloat:= rMaterial + mtResumen.FieldByName('coste_material').AsFloat;
        mtResumen.FieldByName('coste_personal').AsFloat:= rPersonal + mtResumen.FieldByName('coste_personal').AsFloat;
        mtResumen.FieldByName('coste_general').AsFloat:= rGeneral + mtResumen.FieldByName('coste_general').AsFloat;
        mtResumen.FieldByName('coste_financiero').AsFloat:= rImporteFinanciero + mtResumen.FieldByName('coste_financiero').AsFloat;
        mtResumen.Post;
      end;
      Next;
    end;
    Close;
  end;
  result:= not mtResumen.IsEmpty;
end;

procedure TDLMargenBeneficiosCentral.ClientesConfeccionados( const AFechaIni, AFechaFin: TDateTime );
begin
  sClientes:= '';
  if sCliente <> '' then
    sClientes:= QuotedStr( sCliente )
  else
  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(cliente_apcc,''MER'') cliente_cab ');

    SQL.Add(' from alm_palet_pc_c, alm_palet_pc_d ');
    SQL.Add(' where ( status_apcc = ''C'' or status_apcc= ''S'' ) ');

    SQL.Add('   and ( ( date(fecha_alta_apcc) between :fechaini and :fechafin ) or ');
    //La fecha de carga es la de la orden de carga asociada o la prevista ni no ha sido cargado
    SQL.Add('         ( case when status_apcc = ''S'' then previsto_carga_apcc else fecha_albaran_apcc end between :fechaini and :fechafin ) ) ');
    if sProducto <> '' then
    begin
      SQL.Add('   And exists ( select * from frf_envases where envase_e = envase_apcd and producto_e = :producto ) ');
    end;
    SQL.Add('   and empresa_apcc = empresa_apcd ');
    SQL.Add('   and centro_apcc = centro_apcd ');
    SQL.Add('   and ean128_apcc = ean128_apcd ');
    //NO PIÑAN
    if ( sEmpresa = 'F18' ) then
    begin
      SQL.Add('   and envase_apcd <> ''385'' ');
    end;
    SQL.Add(' group by 1 ');
    SQL.Add(' order by 1 ');

    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechaFin').AsDateTime:= AFechaFin;
    if sProducto <> '' then
    begin
      ParamByName('producto').AsString:= sProducto;
    end;
    Open;

    while not Eof do
    begin
      if sClientes = '' then
      begin
        sClientes:= QuotedStr( FieldByName('cliente_cab').AsString );
      end
      else
      begin
        sClientes:= sClientes + ','  + QuotedStr( FieldByName('cliente_cab').AsString );
      end;
      Next;
    end;

    Close;
  end;
end;

procedure TDLMargenBeneficiosCentral.PaletsConfeccionados( const ADetalle: boolean );
var AProducto: string;
begin
  mtPaletsConfeccionados.Open;

  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        producto_apcd producto, ');
    SQL.Add('        case when date(fecha_alta_apcc)  < :fechaini then  0 ');
    SQL.Add('             when case when status_apcc = ''S'' then previsto_carga_apcc else fecha_albaran_apcc end > :fechafin then  2 ');
    SQL.Add('             else 1 end grupo, ');
    SQL.Add('        date(fecha_alta_apcc) fecha_alta, ');
    SQL.Add('        case when status_apcc = ''S'' then previsto_carga_apcc else fecha_albaran_apcc end fecha_carga, ');
    SQL.Add('        empresa_apcc empresa, centro_apcc centro, orden_apcc orden_carga, ean128_apcc ean128, ');
    SQL.Add('        ean13_apcd ean13, formato_apcd formato, envase_apcd envase, cajas_apcd cajas, peso_apcd peso, ');
    SQL.Add('        ( select peso_neto_e from frf_envases where envase_e = envase_apcd ) *  cajas_apcd peso_teorico, ');
    SQL.Add('        unidades_apcd unidades, status_apcc status ');

    SQL.Add(' from alm_palet_pc_c, alm_palet_pc_d ');
    SQL.Add(' where empresa_apcc = :empresa ');
    SQL.Add('  and ( status_apcc = ''C'' or status_apcc = ''S'' ) ');

    SQL.Add(' and ( ( date(fecha_alta_apcc) between :fechaini and :fechafin ) or ');
    //La fecha de carga es la de la orden de carga asociada o la prevista ni no ha sido cargado
    SQL.Add('       ( case when status_apcc = ''S'' then previsto_carga_apcc else fecha_albaran_apcc end between :fechaini and :fechafin ) ) ');

    if sProducto <> '' then
    begin
      if sProducto = 'PIN' then
        SQL.Add(' and producto_apcd in (''PIN'', ''PPE'') ')
      else
        SQL.Add(' And producto_apcd = :producto ');
    end;
    if sCliente <> '' then
    begin
      SQL.Add(' and cliente_apcc = :cliente  ');
    end;
    SQL.Add(' and empresa_apcc = empresa_apcd ');
    SQL.Add(' and centro_apcc = centro_apcd ');
    SQL.Add(' and ean128_apcc = ean128_apcd ');

    (*TODO*)
    SQL.Add(' and not ( producto_apcd is null and nvl(envase_apcd,'''') = '''' ) ');

    //NO PIÑAN
    if ( sEmpresa = 'F18' ) then
    begin
      SQL.Add('  and envase_apcd <> ''385'' ');
    end;

    SQL.Add(' order by 1,2,3,4,5,6,7 ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechaFin').AsDateTime:= dFechaFin;
    if sProducto <> '' then
    begin
      if sProducto <> 'PIN' then
        ParamByName('producto').AsString:= sProducto;
    end;
    if sCliente <> '' then
    begin
      ParamByName('cliente').AsString:= sCliente;
    end;
    Open;


    while not Eof do
    begin

      AProducto := FieldByName('producto').AsString;
      if FieldByName('producto').AsString = 'PPE' then
        AProducto := 'PIN';

      if ADetalle then
      begin
        mtPaletsConfeccionados.Insert;
        mtPaletsConfeccionados.FieldByName('anyosemana_out').AsInteger:= iAnyoSemana;
        mtPaletsConfeccionados.FieldByName('producto_out').AsString:= AProducto;
        mtPaletsConfeccionados.FieldByName('grupo_out').AsInteger:= FieldByName('grupo').AsInteger;
        mtPaletsConfeccionados.FieldByName('fecha_alta_out').AsDateTime:= FieldByName('fecha_alta').AsDateTime;
        mtPaletsConfeccionados.FieldByName('fecha_carga_out').AsDateTime:= FieldByName('fecha_carga').AsDateTime;
        mtPaletsConfeccionados.FieldByName('empresa_out').AsString:= FieldByName('empresa').AsString;
        mtPaletsConfeccionados.FieldByName('centro_out').AsString:= FieldByName('centro').AsString;
        mtPaletsConfeccionados.FieldByName('orden_out').AsString:= FieldByName('orden_carga').AsString;
        mtPaletsConfeccionados.FieldByName('ean128_out').AsString:= FieldByName('ean128').AsString;
        mtPaletsConfeccionados.FieldByName('ean13_out').AsString:= FieldByName('ean13').AsString;

        mtPaletsConfeccionados.FieldByName('formato_out').AsInteger:= FieldByName('formato').AsInteger;
        mtPaletsConfeccionados.FieldByName('envase_out').AsString:= FieldByName('envase').AsString;
        mtPaletsConfeccionados.FieldByName('cajas_out').AsInteger:= FieldByName('cajas').AsInteger;
        mtPaletsConfeccionados.FieldByName('unidades_out').AsInteger:= FieldByName('unidades').AsInteger;
        mtPaletsConfeccionados.FieldByName('peso_out').AsFloat:= FieldByName('peso').AsFloat;
        mtPaletsConfeccionados.FieldByName('peso_teorico_out').AsFloat:= FieldByName('peso_teorico').AsFloat;
        //mtPaletsConfeccionados.FieldByName('importe_out').AsFloat:= FieldByName('neto').AsFloat;
        mtPaletsConfeccionados.FieldByName('status_out').AsString:= FieldByName('status').AsString;
        mtPaletsConfeccionados.Post;
      end;

      if mtResumen.Locate('anyosemana;producto', VarArrayOf([iAnyoSemana,AProducto]),[] ) then
      begin
        mtResumen.Edit;
      end
      else
      begin
        mtResumen.Insert;
        InicializarValoresResumen;
        mtResumen.FieldByName('anyosemana').AsInteger:= iAnyoSemana;
        mtResumen.FieldByName('producto').AsString:= AProducto;
//        mtResumen.FieldByName('producto_base').AsString:= FieldByName('producto').AsString;
      end;

      if FieldByName('grupo').AsInteger = 0 then
      begin
        //Volcado semana anterior
        mtResumen.FieldByName('kilos_confecionado_anterior').AsFloat:= mtResumen.FieldByName('kilos_confecionado_anterior').AsFloat + FieldByName('peso_teorico').AsFloat;
        mtResumen.FieldByName('peso_confecionado_anterior').AsFloat:= mtResumen.FieldByName('peso_confecionado_anterior').AsFloat + FieldByName('peso').AsFloat;
        mtResumen.FieldByName('cajas_confecionado_anterior').AsInteger:= mtResumen.FieldByName('cajas_confecionado_anterior').AsInteger + FieldByName('cajas').AsInteger;
        mtResumen.FieldByName('unidades_confecionado_anterior').AsInteger:= mtResumen.FieldByName('unidades_confecionado_anterior').AsInteger + FieldByName('unidades').AsInteger;
      end
      else
      if FieldByName('grupo').AsInteger = 2 then
      begin
        //Cargado semana siguiente
        mtResumen.FieldByName('kilos_confecionado_adelantado').AsFloat:= mtResumen.FieldByName('kilos_confecionado_adelantado').AsFloat + FieldByName('peso_teorico').AsFloat;
        mtResumen.FieldByName('peso_confecionado_adelantado').AsFloat:= mtResumen.FieldByName('peso_confecionado_adelantado').AsFloat + FieldByName('peso').AsFloat;
        mtResumen.FieldByName('cajas_confecionado_adelantado').AsInteger:= mtResumen.FieldByName('cajas_confecionado_adelantado').AsInteger + FieldByName('cajas').AsInteger;
        mtResumen.FieldByName('unidades_confecionado_adelantado').AsInteger:= mtResumen.FieldByName('unidades_confecionado_adelantado').AsInteger + FieldByName('unidades').AsInteger;
      end
      else
      begin
        //Cargado semana confeccionado semana
        mtResumen.FieldByName('kilos_confecionado').AsFloat:= mtResumen.FieldByName('kilos_confecionado').AsFloat + FieldByName('peso_teorico').AsFloat;
        mtResumen.FieldByName('peso_confecionado').AsFloat:= mtResumen.FieldByName('peso_confecionado').AsFloat + FieldByName('peso').AsFloat;
        mtResumen.FieldByName('cajas_confecionado').AsInteger:= mtResumen.FieldByName('cajas_confecionado').AsInteger + FieldByName('cajas').AsInteger;
        mtResumen.FieldByName('unidades_confecionado').AsInteger:= mtResumen.FieldByName('unidades_confecionado').AsInteger + FieldByName('unidades').AsInteger;
      end;
      mtResumen.Post;


      Next;
    end;

    Close;
    if ADetalle then
    begin
      mtPaletsConfeccionados.SortFields:= 'anyosemana_out;producto_out;grupo_out;fecha_alta_out;fecha_carga_out';
      mtPaletsConfeccionados.Sort([]);
    end;
  end;
end;


procedure TDLMargenBeneficiosCentral.PrecioEntrega( const AEntrega: string; var VPrevision: Boolean; var VPrecioCompra, VPrecioTransporte, VPrecioTransito, VPrecioEstadistico: real );
var
  iCajas: integer;
  rCompra, rTransporte, rTransito, rEstadistico: Real;
begin
  if mtEntregas.Locate('entrega', VarArrayOf([AEntrega]),[] ) then
  begin
    VPrecioCompra:= mtEntregas.FieldByname('precio_compra').AsFloat;
    VPrecioTransporte:= mtEntregas.FieldByname('precio_transporte').AsFloat;
    VPrecioTransito:= mtEntregas.FieldByname('precio_transito').AsFloat;
    VPrecioEstadistico:= mtEntregas.FieldByname('precio_estadistico').AsFloat;
    VPrevision:= mtEntregas.FieldByname('prevision').Asinteger = 1;
  end
  else
  begin
    VPrevision:= False;
    with QCajasRF do
    begin
      ParamByName('planta').AsString:= copy(AEntrega,1,3);
      //ParamByName('centro').AsString:= copy(AEntrega,4,1);
      ParamByName('entrega').AsString:= AEntrega;
      Open;
      iCajas:= FieldByname('cajas').AsInteger;
      Close;
    end;
    with QImportes do
    begin
      ParamByName('entrega').AsString:= AEntrega;
      Open;

      rCompra:= FieldByName('importe_compra').AsFloat;
      rTransporte:= FieldByName('importe_transporte').AsFloat;
      rTransito:= FieldByName('importe_transito').AsFloat;
      rEstadistico:= FieldByName('importe_estadistico').AsFloat;

      Close;

      if ( rCompra = 0 ) or ( rTransporte = 0 ) then
      begin
        QCostePrevisto.ParamByName('entrega').AsString:= AEntrega;
        QCostePrevisto.Open;
        try
          if rCompra = 0 then
          begin
            QCostePrevisto.First;
            while not QCostePrevisto.Eof do
            begin
              if ( QCostePrevisto.FieldByName('categoria_el').AsString = 'I' ) or
                 ( QCostePrevisto.FieldByName('categoria_el').AsString = '1' ) then
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_primera_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 )
              else
              if ( QCostePrevisto.FieldByName('categoria_el').AsString = 'EX' ) then
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_extra_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 )
              else
              if ( QCostePrevisto.FieldByName('categoria_el').AsString = 'SE' ) then
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_super_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 )
              else
              if ( QCostePrevisto.FieldByName('categoria_el').AsString = '10' ) then
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_platano10_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 )
              else
              if ( QCostePrevisto.FieldByName('categoria_el').AsString = 'ST' ) then
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_platanost_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 )
              else
                rCompra:= rCompra + bRoundTo( QCostePrevisto.FieldByName('coste_resto_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 );

              QCostePrevisto.Next;
            end;
            VPrevision:= rCompra <> 0;
          end;
          if rTransporte = 0 then
          begin
            QCostePrevisto.First;
            while not QCostePrevisto.Eof do
            begin
              rTransporte:= rTransporte + bRoundTo( QCostePrevisto.FieldByName('coste_transporte_pcp').AsFloat * QCostePrevisto.FieldByName('kilos').AsFloat, 2 );
              QCostePrevisto.Next;
            end;
            VPrevision:= VPrevision or ( rTransporte <> 0 );
          end;
        finally
          QCostePrevisto.Close;
        end;
      end;

      if iCajas > 0 then
      begin
        VPrecioCompra:= bRoundTo( rCompra / iCajas, 3 );
        VPrecioTransporte:= bRoundTo( rTransporte / iCajas, 3 );
        VPrecioTransito:= bRoundTo( rTransito / iCajas, 3 );
        VPrecioEstadistico:= bRoundTo( rEstadistico / iCajas, 3 );
      end
      else
      begin
        VPrecioCompra:= 0;
        VPrecioTransporte:= 0;
        VPrecioTransito:= 0;
        VPrecioEstadistico:= 0;
      end;

      mtEntregas.Insert;
      mtEntregas.FieldByname('entrega').AsString:= AEntrega;
      mtEntregas.FieldByname('cajas').AsInteger:= iCajas;
      if VPrevision then
        mtEntregas.FieldByname('prevision').AsInteger:= 1
      else
        mtEntregas.FieldByname('prevision').AsInteger:= 0;
      mtEntregas.FieldByname('importe_compra').AsFloat:= rCompra;
      mtEntregas.FieldByname('precio_compra').AsFloat:= VPrecioCompra;
      mtEntregas.FieldByname('importe_transporte').AsFloat:= rTransporte;
      mtEntregas.FieldByname('precio_transporte').AsFloat:= VPrecioTransporte;
      mtEntregas.FieldByname('importe_transito').AsFloat:= rTransito;
      mtEntregas.FieldByname('precio_transito').AsFloat:= VPrecioTransito;
      mtEntregas.FieldByname('importe_estadistico').AsFloat:= rEstadistico;
      mtEntregas.FieldByname('precio_estadistico').AsFloat:= VPrecioEstadistico;
      mtEntregas.Post;

    end;
  end;
end;

procedure TDLMargenBeneficiosCentral.ActualizarPrecios( const AEmpresa, AProducto, AProveedor: String; const APrecioFruta, APrecioTransporte: real;
                                                        const APrevision: boolean );
var
  rPrecio: Real;
  sProducto: String;
begin
  sProducto := AProducto;
  if sProducto = 'PPE' then
    sProducto := 'PIN';
  rPrecio:= APrecioFruta + APrecioTransporte;
  if mtPrecios.Locate('producto_precio;proveedor_precio;empresa_precio', VarArrayOf([sProducto,AProveedor,AEmpresa]),[] ) then
  begin
    if APrevision then
    begin
      if rPrecio > mtPrecios.FieldByname('precio_maximo_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_maximo_previsto').AsFloat:= rPrecio;
        mtPrecios.Post;
      end
      else
      if rPrecio < mtPrecios.FieldByname('precio_minimo_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_minimo_previsto').AsFloat:= rPrecio;
        mtPrecios.Post;
      end;

      if APrecioFruta > mtPrecios.FieldByname('precio_fruta_max_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_fruta_max_previsto').AsFloat:= APrecioFruta;
        mtPrecios.Post;
      end
      else
      if APrecioFruta < mtPrecios.FieldByname('precio_fruta_min_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_fruta_min_previsto').AsFloat:= APrecioFruta;
        mtPrecios.Post;
      end;

      if APrecioTransporte > mtPrecios.FieldByname('precio_transporte_max_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_transporte_max_previsto').AsFloat:= APrecioTransporte;
        mtPrecios.Post;
      end
      else
      if APrecioTransporte < mtPrecios.FieldByname('precio_transporte_min_previsto').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_transporte_min_previsto').AsFloat:= APrecioTransporte;
        mtPrecios.Post;
      end;      
    end
    else
    begin
      if rPrecio > mtPrecios.FieldByname('precio_maximo').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_maximo').AsFloat:= rPrecio;
        mtPrecios.Post;
      end
      else
      if rPrecio < mtPrecios.FieldByname('precio_minimo').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_minimo').AsFloat:= rPrecio;
        mtPrecios.Post;
      end;

      if APrecioFruta > mtPrecios.FieldByname('precio_fruta_max').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_fruta_max').AsFloat:= APrecioFruta;
        mtPrecios.Post;
      end
      else
      if APrecioFruta < mtPrecios.FieldByname('precio_fruta_min').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_fruta_min').AsFloat:= APrecioFruta;
        mtPrecios.Post;
      end;

      if APrecioTransporte > mtPrecios.FieldByname('precio_transporte_max').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_transporte_max').AsFloat:= APrecioTransporte;
        mtPrecios.Post;
      end
      else
      if APrecioTransporte < mtPrecios.FieldByname('precio_transporte_min').AsFloat then
      begin
        mtPrecios.Edit;
        mtPrecios.FieldByname('precio_transporte_min').AsFloat:= APrecioTransporte;
        mtPrecios.Post;
      end;
    end;
  end
  else
  begin
    mtPrecios.Insert;
    mtPrecios.FieldByname('empresa_precio').AsString:= AEmpresa;
    mtPrecios.FieldByname('producto_precio').AsString:= sProducto;
    mtPrecios.FieldByname('proveedor_precio').AsString:= AProveedor;

    if APrevision then
    begin
      mtPrecios.FieldByname('precio_maximo').AsFloat:= 0;
      mtPrecios.FieldByname('precio_minimo').AsFloat:= 0;
      mtPrecios.FieldByname('precio_maximo_previsto').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_minimo_previsto').AsFloat:= rPrecio;


      mtPrecios.FieldByname('precio_fruta_max').AsFloat:= 0;
      mtPrecios.FieldByname('precio_fruta_min').AsFloat:= 0;
      mtPrecios.FieldByname('precio_fruta_max_previsto').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_fruta_min_previsto').AsFloat:= rPrecio;

      mtPrecios.FieldByname('precio_transporte_max').AsFloat:= 0;
      mtPrecios.FieldByname('precio_transporte_min').AsFloat:= 0;
      mtPrecios.FieldByname('precio_transporte_max_previsto').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_transporte_min_previsto').AsFloat:= rPrecio;
    end
    else
    begin
      mtPrecios.FieldByname('precio_maximo').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_minimo').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_maximo_previsto').AsFloat:= 0;
      mtPrecios.FieldByname('precio_minimo_previsto').AsFloat:= 0;

      mtPrecios.FieldByname('precio_fruta_max').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_fruta_min').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_fruta_max_previsto').AsFloat:= 0;
      mtPrecios.FieldByname('precio_fruta_min_previsto').AsFloat:= 0;

      mtPrecios.FieldByname('precio_transporte_max').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_transporte_min').AsFloat:= rPrecio;
      mtPrecios.FieldByname('precio_transporte_max_previsto').AsFloat:= 0;
      mtPrecios.FieldByname('precio_transporte_min_previsto').AsFloat:= 0;
    end;
    mtPrecios.Post;
  end;
end;

procedure TDLMargenBeneficiosCentral.PaletsProveedor;
var
  sAux: string;
  rAnt, rSig: real;
  iGrupo, iUnidades: integer;
  rPrecioCompra, rPrecioTransporte, rPrecioTransito, rPrecioEstadistico: real;
  rImporteCompra, rImporteTransporte, rImporteTransito, rImporteEstadistico: real;
  bFlagPrevisto, bEncontrado: Boolean;
  rPesoTeoricoCaja: real;
begin
  mtPaletsProveedor.Open;
  mtPrecios.Open;
  mtEntregas.Open;

  mtResumen.Filtered:= True;
  mtResumen.Filter:= 'anyosemana='+ IntToStr( iAnyoSemana );
  mtResumen.First;

  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_apb, hora_apb, fecha_apb, empresa_apb, centro_apb, entrega_apb, ');
    SQL.Add('        sscc_apb, proveedor_apb, variedad_apb, categoria_apb, calibre_apb, cajas_apb, peso_apb, ');
    SQL.Add('        peso_bruto_apb, status_apb, unidades_apb');
    SQL.Add(' from alm_palet_pb ');
    SQL.Add(' where empresa_apb = :empresa ');
    SQL.Add(' and fecha_apb between :fechaini and :fechafin ');
    SQL.Add(' and ( status_apb = ''V'' or status_apb = ''R'' or status_apb = ''D'' ) '); //Volcado-Regularizado-Destrio
    SQL.Add(' and producto_apb = :producto ');
    if sCliente <> '' then
    begin
      if sCliente = 'MER' then
        SQL.Add(' and ( cliente_albaran_apb = :cliente  or  nvl(cliente_albaran_apb,'''') = '''' ) ')
      else
        SQL.Add(' and cliente_albaran_apb = :cliente ');
    end;
    SQL.Add(' order by 2 desc ');
  end;

  with QCajasRF do
  begin
    SQL.Clear;
    SQL.Add(' select sum( cajas_apb ) cajas ');
    SQL.Add(' from alm_palet_pb ');
    SQL.Add(' where empresa_apb = :planta ');
    //SQL.Add(' and centro_apb = :centro ');
    SQL.Add(' and entrega_apb = :entrega ');
    SQL.Add(' and status_apb <> ''B'' ');
  end;

  with QImportes do
  begin
    SQL.Clear;
//    SQL.Add('  select sum( case when tipo_ge in (''010'',''020'',''030'') then importe_ge else 0 end ) importe_compra, ');
//    SQL.Add('         sum( case when tipo_ge in (''040'',''050'',''060'',''120'') then importe_ge else 0 end ) importe_transporte, ');
//    SQL.Add('         sum( case when tipo_ge in (''070'',''080'') then importe_ge else 0 end ) importe_transito, ');
//    SQL.Add('         sum( case when tipo_ge in (''090'',''100'',''110'') then importe_ge else 0 end ) importe_estadistico ');
    SQL.Add('  select sum( case when tipo_ge in (''054'',''055'',''056'') then importe_ge else 0 end ) importe_compra, ');
    SQL.Add('         sum( case when tipo_ge in (''012'',''057'',''058'',''016'') then importe_ge else 0 end ) importe_transporte, ');
    SQL.Add('         sum( case when tipo_ge in (''014'',''015'') then importe_ge else 0 end ) importe_transito, ');
    SQL.Add('         sum( case when tipo_ge in (''059'',''060'') then importe_ge else 0 end ) importe_estadistico ');              //en la unificacion de tipo gasto el 110 de BAG no existe.
    SQL.Add('  from frf_gastos_entregas ');
    SQL.Add('  where codigo_ge = :entrega ');
  end;

  with QCostePrevisto do
  begin
    SQL.Clear;
    SQL.Add(' select coste_primera_pcp, coste_extra_pcp, coste_super_pcp, coste_platano10_pcp, coste_platanost_pcp, coste_resto_pcp,  ');
    SQL.Add('        coste_transporte_pcp, categoria_el, sum(kilos_el) kilos ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l, frf_prev_costes_producto ');
    SQL.Add(' where codigo_ec = :entrega ');
    SQL.Add(' and empresa_pcp = empresa_ec ');
    SQL.Add(' and fecha_llegada_ec between fecha_ini_pcp and nvl(fecha_fin_pcp,fecha_llegada_ec) ');
    SQL.Add(' and producto_pcp = producto_ec ');
    SQL.Add(' and codigo_el = codigo_ec ');
    SQL.Add(' group by coste_primera_pcp, coste_extra_pcp, coste_super_pcp, coste_platano10_pcp, coste_platanost_pcp, coste_resto_pcp, coste_transporte_pcp, categoria_el');
  end;


  iGrupo:= 1;
  while not mtResumen.Eof do
  begin
    if ( sEmpresa = 'F18' ) and ( ( mtResumen.FieldByName('producto').AsString = 'PIN' ) or ( mtResumen.FieldByName('producto').AsString = 'PPE') )then
    begin
      rAnt:= mtResumen.FieldByName('unidades_confecionado_anterior').AsFloat;
      rSig:= mtResumen.FieldByName('unidades_confecionado_adelantado').AsFloat;
    end
    else
    begin
      rAnt:= mtResumen.FieldByName('kilos_confecionado_anterior').AsFloat;
      rSig:= mtResumen.FieldByName('kilos_confecionado_adelantado').AsFloat;
    end;

    QAux.ParamByName('empresa').AsString:= sEmpresa;
    QAux.ParamByName('fechaini').AsDateTime:= dFechaIni - 7;
    QAux.ParamByName('fechaFin').AsDateTime:= dFechaFin;
    QAux.ParamByName('producto').AsString:= mtResumen.FieldByName('producto').AsString;
    if sCliente <> '' then
    begin
      QAux.ParamByName('cliente').AsString:= sCliente;
    end;
    QAux.Open;

    while not QAux.Eof do
    begin
      if ( QAux.FieldByName('producto_apb').AsString = 'PIN' ) or ( QAux.FieldByName('producto_apb').AsString = 'COC' ) or
         ( QAux.FieldByName('producto_apb').AsString = 'PPE' ) then
      begin
        if TryStrToInt( QAux.FieldByName('calibre_apb').AsString, iUnidades ) then
        begin
          iUnidades:= iUnidades * QAux.FieldByName('cajas_apb').AsInteger;
        end
        else
        begin
          iUnidades:= StrToIntDef( Copy( QAux.FieldByName('calibre_apb').AsString, 2, Length( QAux.FieldByName('calibre_apb').AsString ) ), 0 ) * QAux.FieldByName('cajas_apb').AsInteger;
        end;
      end
      else
      begin
        iUnidades:= QAux.FieldByName('unidades_apb').AsInteger;
      end;

      if QAux.FieldByName('fecha_apb').AsDateTime >= dFechaIni then
      begin
        if  rSig > 0 then
        begin
          if ( sEmpresa = 'F18' ) and ( ( mtResumen.FieldByName('producto').AsString = 'PIN' )  or ( mtResumen.FieldByName('producto').AsString = 'PPE' ) ) then
            rSig:= rSig - iUnidades
          else
            rSig:= rSig - QAux.FieldByName('peso_apb').AsFloat;
          iGrupo:= 2;
        end
        else
        begin
          iGrupo:= 1;
        end;
      end
      else
      begin
        if  rAnt > 0 then
        begin
          if ( sEmpresa = 'F18' ) and ( ( mtResumen.FieldByName('producto').AsString = 'PIN' ) or ( mtResumen.FieldByName('producto').AsString = 'PPE' ) )then
            rAnt:= rAnt - iUnidades
          else
            rAnt:= rAnt - QAux.FieldByName('peso_apb').AsFloat;
          iGrupo:= 0;
        end
        else
        begin
          Break;
        end;
      end;

      if bFacturasFruta then
      begin
        PrecioEntrega( QAux.FieldByName('entrega_apb').AsString, bFlagPrevisto, rPrecioCompra, rPrecioTransporte, rPrecioTransito, rPrecioEstadistico );
        ActualizarPrecios( sAux, QAux.FieldByName('producto_apb').AsString, QAux.FieldByName('proveedor_apb').AsString, rPrecioCompra, rPrecioTransporte + rPrecioTransito, bFlagPrevisto );
        rImporteCompra:= 0;
        rImporteTransporte:= 0;
        rImporteTransito:= 0;
        rImporteEstadistico:= 0;

        if CostesAplicar.bCompra then
          rImporteCompra:= bRoundTo( QAux.FieldByName('cajas_apb').AsInteger * rPrecioCompra, 2 );
        if CostesAplicar.bTransporte then
          rImporteTransporte:= bRoundTo( QAux.FieldByName('cajas_apb').AsInteger * rPrecioTransporte, 2 );
        if CostesAplicar.bTransito then
          rImporteTransito:= bRoundTo( QAux.FieldByName('cajas_apb').AsInteger * rPrecioTransito, 2 );
        if CostesAplicar.bEstadistico then
          rImporteEstadistico:= bRoundTo( QAux.FieldByName('cajas_apb').AsInteger * rPrecioEstadistico, 2 );
      end
      else
      begin
        rPrecioCompra:= 0;
        rPrecioTransporte:= 0;
        rPrecioTransito:= 0;
        rPrecioEstadistico:= 0;
        rImporteCompra:= 0;
        rImporteTransporte:= 0;
        rImporteTransito:= 0;
        rImporteEstadistico:= 0;
      end;

      if ADetalle then
      begin
        mtPaletsProveedor.Insert;
        mtPaletsProveedor.FieldByName('anyosemana_in').AsInteger:= iAnyosemana;
        mtPaletsProveedor.FieldByName('producto_in').AsString:= QAux.FieldByName('producto_apb').AsString;
        mtPaletsProveedor.FieldByName('grupo_in').AsInteger:= iGrupo;
        mtPaletsProveedor.FieldByName('fecha_in').AsDateTime:= QAux.FieldByName('fecha_apb').AsDateTime;
        mtPaletsProveedor.FieldByName('empresa_in').AsString:= QAux.FieldByName('empresa_apb').AsString;
        mtPaletsProveedor.FieldByName('centro_in').AsString:= QAux.FieldByName('centro_apb').AsString;
        mtPaletsProveedor.FieldByName('entrega_in').AsString:= QAux.FieldByName('entrega_apb').AsString;
        mtPaletsProveedor.FieldByName('sscc_in').AsString:= QAux.FieldByName('sscc_apb').AsString;
        mtPaletsProveedor.FieldByName('proveedor_in').AsString:= QAux.FieldByName('proveedor_apb').AsString;
        mtPaletsProveedor.FieldByName('variedad_in').AsInteger:= QAux.FieldByName('variedad_apb').AsInteger;
        mtPaletsProveedor.FieldByName('calibre_in').AsString:= QAux.FieldByName('calibre_apb').AsString;
        mtPaletsProveedor.FieldByName('cajas_in').AsInteger:= QAux.FieldByName('cajas_apb').AsInteger;
        mtPaletsProveedor.FieldByName('unidades_in').AsInteger:= iUnidades;
        mtPaletsProveedor.FieldByName('precio_in').AsFloat:= rPrecioCompra + rPrecioTransporte + rPrecioTransito;
        mtPaletsProveedor.FieldByName('peso_in').AsFloat:= QAux.FieldByName('peso_apb').AsFloat;
        mtPaletsProveedor.FieldByName('importe_in').AsFloat:= rImporteCompra + rImporteTransporte + rImporteTransito;
        mtPaletsProveedor.FieldByName('peso_bruto_in').AsFloat:= QAux.FieldByName('peso_bruto_apb').AsFloat;
        mtPaletsProveedor.FieldByName('status_in').AsString:= QAux.FieldByName('status_apb').AsString;
        mtPaletsProveedor.Post;
      end;


      rPesoTeoricoCaja:= GetKiloCajaTeorico( QAux.FieldByName('entrega_apb').AsString,
                               QAux.FieldByName('empresa_apb').AsString,
                               QAux.FieldByName('proveedor_apb').AsString,
                               QAux.FieldByName('producto_apb').AsString,
                               QAux.FieldByName('variedad_apb').AsString,
                               QAux.FieldByName('categoria_apb').AsString,
                               QAux.FieldByName('calibre_apb').AsString,
                               bEncontrado);


      mtResumen.Edit;
      if iGrupo = 0 then
      begin
        //Volcado semana anterior
        mtResumen.FieldByName('kilos_volcado_anterior').AsFloat:= mtResumen.FieldByName('kilos_volcado_anterior').AsFloat + ( QAux.FieldByName('cajas_apb').AsInteger * rPesoTeoricoCaja );
        mtResumen.FieldByName('peso_volcado_anterior').AsFloat:= mtResumen.FieldByName('peso_volcado_anterior').AsFloat + QAux.FieldByName('peso_apb').AsFloat;
        mtResumen.FieldByName('cajas_volcado_anterior').AsInteger:= mtResumen.FieldByName('cajas_volcado_anterior').AsInteger + QAux.FieldByName('cajas_apb').AsInteger;
        mtResumen.FieldByName('unidades_volcado_anterior').AsInteger:= mtResumen.FieldByName('unidades_volcado_anterior').AsInteger + iUnidades;
        mtResumen.FieldByName('importe_compra').AsFloat:= mtResumen.FieldByName('importe_compra').AsFloat + rImporteCompra;
        mtResumen.FieldByName('importe_transporte').AsFloat:= mtResumen.FieldByName('importe_transporte').AsFloat + rImporteTransporte;
        mtResumen.FieldByName('importe_transito').AsFloat:= mtResumen.FieldByName('importe_transito').AsFloat + rImporteTransito;
        mtResumen.FieldByName('importe_estadistico').AsFloat:= mtResumen.FieldByName('importe_estadistico').AsFloat + rImporteEstadistico;
      end
      else
      if iGrupo = 2 then
      begin
        //Cargado semana siguiente
        mtResumen.FieldByName('kilos_volcado_adelantado').AsFloat:= mtResumen.FieldByName('kilos_volcado_adelantado').AsFloat + ( QAux.FieldByName('cajas_apb').AsInteger * rPesoTeoricoCaja );
        mtResumen.FieldByName('peso_volcado_adelantado').AsFloat:= mtResumen.FieldByName('peso_volcado_adelantado').AsFloat + QAux.FieldByName('peso_apb').AsFloat;
        mtResumen.FieldByName('cajas_volcado_adelantado').AsInteger:= mtResumen.FieldByName('cajas_volcado_adelantado').AsInteger + QAux.FieldByName('cajas_apb').AsInteger;
        mtResumen.FieldByName('unidades_volcado_adelantado').AsInteger:= mtResumen.FieldByName('unidades_volcado_adelantado').AsInteger + iUnidades;
      end
      else
      begin
        //Cargado semana confeccionado semana
        mtResumen.FieldByName('kilos_volcado').AsFloat:= mtResumen.FieldByName('kilos_volcado').AsFloat + ( QAux.FieldByName('cajas_apb').AsInteger * rPesoTeoricoCaja );
        mtResumen.FieldByName('peso_volcado').AsFloat:= mtResumen.FieldByName('peso_volcado').AsFloat + QAux.FieldByName('peso_apb').AsFloat;
        mtResumen.FieldByName('cajas_volcado').AsInteger:= mtResumen.FieldByName('cajas_volcado').AsInteger + QAux.FieldByName('cajas_apb').AsInteger;
        mtResumen.FieldByName('unidades_volcado').AsInteger:= mtResumen.FieldByName('unidades_volcado').AsInteger + iUnidades;
        mtResumen.FieldByName('importe_compra').AsFloat:= mtResumen.FieldByName('importe_compra').AsFloat + rImporteCompra;
        mtResumen.FieldByName('importe_transporte').AsFloat:= mtResumen.FieldByName('importe_transporte').AsFloat + rImporteTransporte;
        mtResumen.FieldByName('importe_transito').AsFloat:= mtResumen.FieldByName('importe_transito').AsFloat + rImporteTransito;
        mtResumen.FieldByName('importe_estadistico').AsFloat:= mtResumen.FieldByName('importe_estadistico').AsFloat + rImporteEstadistico;
      end;
      mtResumen.Post;

      QAux.Next;
    end;

    QAux.Close;
    mtResumen.Next;
  end;
  if ADetalle then
  begin
    mtPaletsProveedor.SortFields:= 'anyosemana_in;producto_in;grupo_in;proveedor_in;entrega_in;fecha_in';
    mtPaletsProveedor.Sort([]);
  end;
  mtPrecios.SortFields:= 'producto_precio;proveedor_precio';
  mtPrecios.Sort([]);

  mtResumen.Filtered:= False;
end;

function TDLMargenBeneficiosCentral.GetKiloCajaTeorico( const AEntrega, AEmpresa, AProveedor, AProducto, AVariedad, ACategoria, ACalibre: string;
                                               var AEncontrado: boolean ): Real;
var
  bParcial: Boolean;
begin
  AEncontrado:= False;
  with qryKilosTeoricosCaja do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('proveedor').AsString:= AProveedor;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('variedad').AsString:= AVariedad;
    Open;
    result:= KilosCajas;
    bParcial:= FieldByName('categoria').AsString = ACategoria;
    while ( not Eof ) and ( not AEncontrado ) do
    begin
      if ( FieldByName('categoria').AsString = ACategoria  ) and
         ( FieldByName('calibre').AsString = ACalibre ) then
      begin
         AEncontrado:= True;
         result:= KilosCajas;
      end
      else
      begin
        if not bParcial then
        begin
          if ( FieldByName('categoria').AsString = ACategoria  ) then
          begin
            bParcial:= True;
            result:= KilosCajas;
          end;
        end;
      end;
      Next;
    end;
    Close;
  end;
end;

function TDLMargenBeneficiosCentral.KilosCajas: real;
begin
  if qryKilosTeoricosCaja.FieldByName('cajas').AsFloat <> 0 then
    result:= bRoundTo( qryKilosTeoricosCaja.FieldByName('kilos').AsFloat / qryKilosTeoricosCaja.FieldByName('cajas').AsFloat, 3 )
  else
    result:= 0;
end;


end.
