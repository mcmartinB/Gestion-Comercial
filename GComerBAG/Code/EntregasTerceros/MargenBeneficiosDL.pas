unit MargenBeneficiosDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable, MargenBCodeComunDL;

type
  TDLMargenBeneficios = class(TDataModule)
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
    bImporteVenta, bFacturasFruta, bCosteEnvasado: boolean;

    procedure AsignarBaseDatos;
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
                     
function CosteFinanciero( const APlanta: string; const AFecha: TDateTime ): real;

function MargenBeneficios( const AOwner: TComponent; const APaletsEntrada, APaletsSalida: boolean;
                        const AEmpresa, ACliente, AProducto: string;
                        const AFechaIni, AFechaFin: TDateTime;
                        const ASemanal, AValorar, AExpandir, APrecioUnidad: boolean;
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

function CuadreAlmacenSemanal( const AOwner: TComponent; const APaletsEntrada, APaletsSalida: boolean;
                        const AEmpresa, ACliente, AProducto: string;
                        const AFechaIni, AFechaFin: TDateTime  ): boolean;

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

var
  DLMargenBeneficios: TDLMargenBeneficios;

implementation

{$R *.dfm}

uses MargenSemanalQL, MargenPeriodoQL, variants, bMath, UDMBaseDatos,
     DateUtils, UDMAuxDB, dialogs, CuadreAlmacenSemanalResumenQL, CuadreAlmacenSemanalQL,
     bTimeUtils;
     //CosteFrutaProductoDL,

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
  result:= MargenBeneficios( AOwner,APaletsEntrada, APaletsSalida, AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, True, true, AExpandir, False, ACostesAplicar );
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
  result:= MargenBeneficios( AOwner,APaletsEntrada, APaletsSalida, AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, False, True, False, APrecioUnidad, CostesAplicar );
end;

function CuadreAlmacenSemanal( const AOwner: TComponent; const APaletsEntrada, APaletsSalida: boolean;
                        const AEmpresa, ACliente, AProducto: string;
                        const AFechaIni, AFechaFin: TDateTime  ): boolean;
var
  CostesAplicar: RCostesAplicar;
begin
  CostesAplicar.bCompra:= False;
  CostesAplicar.bTransporte:= False;
  CostesAplicar.bTransito:= False;
  CostesAplicar.bMaterial:= False;
  CostesAplicar.bPersonal:= False;
  CostesAplicar.bGeneral:= False;
  CostesAplicar.bFinanciero:= False;
  CostesAplicar.bEstadistico:= False;
  result:= MargenBeneficios( AOwner,APaletsEntrada, APaletsSalida, AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, False, False, False, False, CostesAplicar );
end;


function MargenBeneficios( const AOwner: TComponent; const APaletsEntrada, APaletsSalida : boolean;
                        const AEmpresa, ACliente, AProducto: string;
                        const AFechaIni, AFechaFin: TDateTime;
                        const ASemanal, AValorar, AExpandir, APrecioUnidad: boolean;
                        const ACostesAplicar: RCostesAplicar  ): boolean;
var
  iYear: Word;
begin
  DLMargenBeneficios:= TDLMargenBeneficios.Create( AOwner );
  try
    //DLCosteFrutaProducto:= TDLCosteFrutaProducto.Create( AOwner );
    with DLMargenBeneficios do
    begin
      CostesAplicar:=  ACostesAplicar;
      bImporteVenta:= AValorar;
      bFacturasFruta:= AValorar and ( CostesAplicar.bCompra or CostesAplicar.bTransporte or CostesAplicar.bEstadistico );
      bCosteEnvasado:=  AValorar and ( CostesAplicar.bMaterial or CostesAplicar.bPersonal or CostesAplicar.bMaterial or CostesAplicar.bFinanciero );
      if AValorar then
        QueryCostes;

      sEmpresa:= AEmpresa;
      sProducto:= AProducto;
      sCliente:= ACliente;
      sProductoBase:= GetProductoBase( sEmpresa, sProducto );


      AsignarBaseDatos;
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
        if AValorar then
        begin
          CalculoMargenes;
          if ASemanal then
            MargenSemanalQL.VerMargenSemanal( AOwner, APaletsEntrada, APaletsSalida, AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, AExpandir )
          else
            MargenPeriodoQL.VerMargenPeriodo( AOwner, APaletsEntrada, APaletsSalida, AEmpresa, ACliente, AProducto, AFechaIni, AFechaFin, APrecioUnidad );
        end
        else
        begin
          if APaletsEntrada or APaletsSalida then
            CuadreAlmacenSemanalQL.VerCuadreAlmacenSemanal( AOwner, APaletsEntrada, APaletsSalida, AEmpresa, AProducto, AFechaIni, AFechaFin  )
          else
            CuadreAlmacenSemanalResumenQL.VerCuadreAlmacenSemanal( AOwner, AEmpresa, AProducto, AFechaIni, AFechaFin );
        end;

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
    DLMargenBeneficios.CerrarTablas;
    FreeAndNil( DLMargenBeneficios );
  end;
end;

procedure TDLMargenBeneficios.AsignarBaseDatos;
begin
  if sEmpresa = 'F17' then
  begin
    QAux.DatabaseName:= DMBaseDatos.dbF17.DatabaseName;
    DMBaseDatos.dbF17.Connected:= True;
  end
  else
  if sEmpresa = 'F18' then
  begin
    QAux.DatabaseName:= DMBaseDatos.dbF18.DatabaseName;
    DMBaseDatos.dbF18.Connected:= True;
  end
  else
  (*
  if sEmpresa = 'F21' then
  begin
    QAux.DatabaseName:= DMBaseDatos.dbF21.DatabaseName;
    DMBaseDatos.dbF21.Connected:= True;
  end
  else
  *)
  if sEmpresa = 'F23' then
  begin
    QAux.DatabaseName:= DMBaseDatos.dbF23.DatabaseName;
    DMBaseDatos.dbF23.Connected:= True;
  end;
  (*
  else
  if sEmpresa = 'F24' then
  begin
    QAux.DatabaseName:= DMBaseDatos.dbF24.DatabaseName;
    DMBaseDatos.dbF24.Connected:= True;
  end;
  *)
  QCajasRF.DatabaseName:= QAux.DatabaseName;
end;

procedure TDLMargenBeneficios.CerrarTablas;
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


procedure TDLMargenBeneficios.QueryCostes;
begin
  //Costes de envasado
  with QCostesEnvasado do
  begin
    SQL.Clear;
    SQL.Add(' select ec1.material_ec, ec1.personal_ec, ec1.general_ec ');
    SQL.Add(' from frf_env_costes ec1 ');
    SQL.Add(' where ec1.empresa_ec = :planta ');
    SQL.Add(' and ec1.centro_ec = :centro ');
    SQL.Add(' and ec1.envase_ec = :envase ');
    SQL.Add(' and ec1.producto_ec = :producto ');
    SQL.Add(' and ( ec1.anyo_ec * 100 + ec1.mes_Ec ) =  ( select max( ( ec2.anyo_ec * 100 ) + ec2.mes_Ec ) ');
    SQL.Add('                  from frf_env_costes ec2 ');
    SQL.Add('                  where ec2.empresa_ec = ec1.empresa_ec ');
    SQL.Add('                  and ( ec2.anyo_ec * 100 ) + ec2.mes_Ec <= :anyomes ');
    SQL.Add('                  and ec2.centro_ec = ec1.centro_ec ');
    SQL.Add('                  and ec2.envase_ec = ec1.envase_ec ');
    SQL.Add('                  and ec2.producto_ec = ec1.producto_ec ) ');
  end;
end;

procedure TDLMargenBeneficios.DataModuleCreate(Sender: TObject);
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
  mtCostesEnvasado.FieldDefs.Add('producto', ftString, 3, False);
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

procedure TDLMargenBeneficios.InicializarValoresResumen;
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

function TDLMargenBeneficios.ImporteAbonos( const AProducto, AAnyoSemana: string ): Real;
var
  dFecha: TDateTime;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_fal) importe');
    SQL.Add(' from frf_fac_abonos_l, frf_facturas ');

    SQL.Add(' where empresa_fal = :empresa ');
    SQL.Add(' and producto_fal = :producto ');
    SQL.Add(' and fecha_albaran_fal between :fecha_ini and :fecha_fin ');

    SQL.Add(' and empresa_fal = empresa_f ');
    SQL.Add(' and factura_fal = n_factura_f ');
    SQL.Add(' and fecha_fal = fecha_factura_f ');

    if sClientes <> '' then
      SQL.Add(' and cliente_fac_f in ( ' + sClientes + ') ');


    ParamByName('empresa').AsString:= sEmpresa;
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

procedure TDLMargenBeneficios.CalculoMargenes;
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

procedure TDLMargenBeneficios.CosteEnvasado( const APlanta, ACentro, AEnvase, AProducto: string; const AProductoBase: integer;
                                             const AFecha: TDateTime; var VPrecioMaterial, VPrecioPersonal, VPrecioGeneral: real );
var
  iAnyo, iMes, iDia: Word;
  iAnyoMes: integer;
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

function CosteFinanciero( const APlanta: string; const AFecha: TDateTime ): real;
begin
  if APlanta = 'F17' then
  begin
    if AFecha >= StrToDate('1/7/2013') then
      result:= 0.0299
    else
    if AFecha >= StrToDate('1/1/2013') then
      result:= 0.022
    else
    if AFecha >= StrToDate('2/7/2012') then
      result:= 0.026
    else
      result:= 0.012;
  end
  else
    result:= 0;
end;

function TDLMargenBeneficios.ProductosConfeccionados: boolean;
var
  rMaterial, rPersonal, rGeneral: real;
  rPrecioFinanciero, rImporteFinanciero: real;
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
    if bImporteVenta then
    begin
      SQL.Add('       SUM(  Round( NVL(importe_neto_sl,0)* ');
      SQL.Add('             (1-(GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100))* ');
      SQL.Add('             (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 1 )/100)), 2) ) neto ');
    end
    else
    begin
      SQL.Add('       0 neto ');
    end;

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
      ParamByName('producto').AsString:= sProducto;
    end;
    Open;

    mtCostesEnvasado.Open;
    rPrecioFinanciero:= 0;
    if bCosteEnvasado then
      rPrecioFinanciero:= CosteFinanciero( FieldByName('empresa_sl').AsString, FieldByName('fecha_sl').AsDateTime );
    while not eof do
    begin
      if bCosteEnvasado then
        CosteEnvasado( FieldByName('empresa_sl').AsString,
                     FieldByName('centro_salida_sl').AsString ,
                     FieldByName('envase_sl').AsString,
                     FieldByName('producto').AsString,
                     FieldByName('producto_base').AsInteger,
                     FieldByName('fecha_sl').AsDateTime,
                     rMaterial, rPersonal, rGeneral );

      if CostesAplicar.bMaterial then
        rMaterial:= bRoundTo( rMaterial * FieldByName('peso').AsFloat, 2)
      else
        rMaterial:= 0;
      if CostesAplicar.bPersonal then
        rPersonal:= bRoundTo( rPersonal * FieldByName('peso').AsFloat, 2)
      else
        rPersonal:= 0;
      if CostesAplicar.bGeneral then
        rGeneral:= bRoundTo( rGeneral * FieldByName('peso').AsFloat, 2)
      else
        rGeneral:= 0;
      rImporteFinanciero:= 0;
      if CostesAplicar.bFinanciero then
        rImporteFinanciero:= bRoundTo( rPrecioFinanciero * FieldByName('peso').AsFloat, 2);

      if not mtResumen.Locate('anyosemana;producto', VarArrayOf([iAnyoSemana,FieldByName('producto').AsString]),[] ) then
      begin
        mtResumen.Insert;
        InicializarValoresResumen;

        mtResumen.FieldByName('anyosemana').AsInteger:= iAnyoSemana;
        mtResumen.FieldByName('producto').AsString:= FieldByName('producto').AsString;
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

procedure TDLMargenBeneficios.ClientesConfeccionados( const AFechaIni, AFechaFin: TDateTime );
begin
  sClientes:= '';
  if sCliente <> '' then
    sClientes:= QuotedStr( sCliente )
  else
  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(cliente_cab,''MER'') cliente_cab ');

    SQL.Add(' from rf_palet_pc_cab, rf_palet_pc_det ');
    SQL.Add(' where ( status_cab = ''C'' or status_cab = ''S'' ) ');

    SQL.Add(' and ( ( date(fecha_alta_cab) between :fechaini and :fechafin ) or ');
    //La fecha de carga es la de la orden de carga asociada o la prevista ni no ha sido cargado
    SQL.Add('       ( case when status_cab = ''S'' then previsto_carga else ( select fecha_occ from frf_orden_carga_c where orden_occ = orden_carga_cab ) end between :fechaini and :fechafin ) ) ');
    if sProducto <> '' then
    begin
      SQL.Add('   And exists ( select * from frf_envases where envase_e = envase_det and producto_e = :producto ) ');
    end;
    SQL.Add(' and ean128_cab = ean128_det ');
    //NO PIÑAN
    if ( sEmpresa = 'F18' ) then
    begin
      SQL.Add('  and envase_det <> ''385'' ');
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

procedure TDLMargenBeneficios.PaletsConfeccionados( const ADetalle: boolean );
var
  sAux: string;
begin
  mtPaletsConfeccionados.Open;

  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' select ');

    SQL.Add('        ( select max(productop_e) from frf_ean13 where empresa_e = empresa_cab  and codigo_e = ean13_det ) producto, ');

    SQL.Add('        case when date(fecha_alta_cab)  < :fechaini then  0 ');
    SQL.Add('             when case when status_cab = ''S'' then previsto_carga else ( select fecha_occ from frf_orden_carga_c where orden_occ = orden_carga_cab ) end > :fechafin then  2 ');
    SQL.Add('             else 1 end grupo, ');
    SQL.Add('        date(fecha_alta_cab) fecha_alta_cab, case when status_cab = ''S'' then previsto_carga else ( select fecha_occ from frf_orden_carga_c where orden_occ = orden_carga_cab ) end fecha_carga_cab, empresa_cab, centro_cab, orden_carga_cab, ean128_cab, ');
    SQL.Add('        ean13_det, formato_det, envase_det, unidades_det, peso_det, ');
    SQL.Add('        ( select peso_neto_e from frf_envases where envase_e = envase_det ) *  unidades_det peso_teorico, ');
    SQL.Add('        ( select unidades_e from frf_envases where envase_e = envase_det ) *  unidades_det unidades ');

    SQL.Add(' from rf_palet_pc_cab, rf_palet_pc_det ');
    SQL.Add(' where ( status_cab = ''C'' or status_cab = ''S'' ) ');

    SQL.Add(' and ( ( date(fecha_alta_cab) between :fechaini and :fechafin ) or ');
    //La fecha de carga es la de la orden de carga asociada o la prevista ni no ha sido cargado
    SQL.Add('       ( case when status_cab = ''S'' then previsto_carga else ( select fecha_occ from frf_orden_carga_c where orden_occ = orden_carga_cab ) end between :fechaini and :fechafin ) ) ');

    if sProducto <> '' then
    begin
      SQL.Add('   And exists ( select * from frf_envases where envase_e = envase_det and producto_e = :producto ) ');
    end;
    if sCliente <> '' then
    begin
      SQL.Add(' and cliente_cab = :cliente  ');
    end;
    SQL.Add(' and ean128_cab = ean128_det ');
    SQL.Add(' and nvl(ean13_det,'''') <> '''' ');

    //NO PIÑAN
    if ( sEmpresa = 'F18' ) then
    begin
      SQL.Add('  and envase_det <> ''385'' ');
    end;

    SQL.Add(' order by 1,2,3,4,5,6,7 ');
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechaFin').AsDateTime:= dFechaFin;
    if sProducto <> '' then
    begin
      ParamByName('producto').AsString:= sProducto;
    end;
    if sCliente <> '' then
    begin
      ParamByName('cliente').AsString:= sCliente;
    end;
    Open;

    while not Eof do
    begin
      if ADetalle then
      begin
        mtPaletsConfeccionados.Insert;
        mtPaletsConfeccionados.FieldByName('anyosemana_out').AsInteger:= iAnyoSemana;
        mtPaletsConfeccionados.FieldByName('producto_out').AsString:= FieldByName('producto').AsString;
        mtPaletsConfeccionados.FieldByName('grupo_out').AsInteger:= FieldByName('grupo').AsInteger;
        mtPaletsConfeccionados.FieldByName('fecha_alta_out').AsDateTime:= FieldByName('fecha_alta_cab').AsDateTime;
        mtPaletsConfeccionados.FieldByName('fecha_carga_out').AsDateTime:= FieldByName('fecha_carga_cab').AsDateTime;
        mtPaletsConfeccionados.FieldByName('empresa_out').AsString:= FieldByName('empresa_cab').AsString;
        mtPaletsConfeccionados.FieldByName('centro_out').AsString:= FieldByName('centro_cab').AsString;
        mtPaletsConfeccionados.FieldByName('orden_out').AsString:= FieldByName('orden_carga_cab').AsString;
        mtPaletsConfeccionados.FieldByName('ean128_out').AsString:= FieldByName('ean128_cab').AsString;
        mtPaletsConfeccionados.FieldByName('ean13_out').AsString:= FieldByName('ean13_det').AsString;

        mtPaletsConfeccionados.FieldByName('formato_out').AsInteger:= FieldByName('formato_det').AsInteger;
        mtPaletsConfeccionados.FieldByName('envase_out').AsString:= FieldByName('envase_det').AsString;
        mtPaletsConfeccionados.FieldByName('cajas_out').AsInteger:= FieldByName('unidades_det').AsInteger;
        mtPaletsConfeccionados.FieldByName('unidades_out').AsInteger:= FieldByName('unidades').AsInteger;
        mtPaletsConfeccionados.FieldByName('peso_out').AsFloat:= FieldByName('peso_det').AsFloat;
        mtPaletsConfeccionados.FieldByName('peso_teorico_out').AsFloat:= FieldByName('peso_teorico').AsFloat;
        //mtPaletsConfeccionados.FieldByName('importe_out').AsFloat:= FieldByName('neto').AsFloat;
        mtPaletsConfeccionados.FieldByName('status_out').AsString:= 'C';
        mtPaletsConfeccionados.Post;
      end;

      sAux:= FieldByName('producto').AsString;
      if mtResumen.Locate('anyosemana;producto', VarArrayOf([iAnyoSemana,sAux]),[] ) then
      begin
        mtResumen.Edit;
      end
      else
      begin
        mtResumen.Insert;
        InicializarValoresResumen;
        mtResumen.FieldByName('anyosemana').AsInteger:= iAnyoSemana;
        mtResumen.FieldByName('producto').AsString:= FieldByName('producto').AsString;
        mtResumen.FieldByName('producto_base').AsString:= FieldByName('producto_base').AsString;
      end;

      if FieldByName('grupo').AsInteger = 0 then
      begin
        //Volcado semana anterior
        mtResumen.FieldByName('kilos_confecionado_anterior').AsFloat:= mtResumen.FieldByName('kilos_confecionado_anterior').AsFloat + FieldByName('peso_teorico').AsFloat;
        mtResumen.FieldByName('peso_confecionado_anterior').AsFloat:= mtResumen.FieldByName('peso_confecionado_anterior').AsFloat + FieldByName('peso_det').AsFloat;
        mtResumen.FieldByName('cajas_confecionado_anterior').AsInteger:= mtResumen.FieldByName('cajas_confecionado_anterior').AsInteger + FieldByName('unidades_det').AsInteger;
        mtResumen.FieldByName('unidades_confecionado_anterior').AsInteger:= mtResumen.FieldByName('unidades_confecionado_anterior').AsInteger + FieldByName('unidades').AsInteger;
      end
      else
      if FieldByName('grupo').AsInteger = 2 then
      begin
        //Cargado semana siguiente
        mtResumen.FieldByName('kilos_confecionado_adelantado').AsFloat:= mtResumen.FieldByName('kilos_confecionado_adelantado').AsFloat + FieldByName('peso_teorico').AsFloat;
        mtResumen.FieldByName('peso_confecionado_adelantado').AsFloat:= mtResumen.FieldByName('peso_confecionado_adelantado').AsFloat + FieldByName('peso_det').AsFloat;
        mtResumen.FieldByName('cajas_confecionado_adelantado').AsInteger:= mtResumen.FieldByName('cajas_confecionado_adelantado').AsInteger + FieldByName('unidades_det').AsInteger;
        mtResumen.FieldByName('unidades_confecionado_adelantado').AsInteger:= mtResumen.FieldByName('unidades_confecionado_adelantado').AsInteger + FieldByName('unidades').AsInteger;
      end
      else
      begin
        //Cargado semana confeccionado semana
        mtResumen.FieldByName('kilos_confecionado').AsFloat:= mtResumen.FieldByName('kilos_confecionado').AsFloat + FieldByName('peso_teorico').AsFloat;
        mtResumen.FieldByName('peso_confecionado').AsFloat:= mtResumen.FieldByName('peso_confecionado').AsFloat + FieldByName('peso_det').AsFloat;
        mtResumen.FieldByName('cajas_confecionado').AsInteger:= mtResumen.FieldByName('cajas_confecionado').AsInteger + FieldByName('unidades_det').AsInteger;
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

procedure TDLMargenBeneficios.PrecioEntrega( const AEntrega: string; var VPrevision: Boolean; var VPrecioCompra, VPrecioTransporte, VPrecioTransito, VPrecioEstadistico: real );
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
    VPrecioEstadistico:= mtEntregas.FieldByname('precio_estadistico').AsFloat;
    VPrevision:= mtEntregas.FieldByname('prevision').Asinteger = 1;
  end
  else
  begin
    VPrevision:= False;
    with QCajasRF do
    begin
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

      if ( rCompra = 0 ) or  ( rTransporte = 0 ) then
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

procedure TDLMargenBeneficios.ActualizarPrecios( const AEmpresa, AProducto, AProveedor: String; const APrecioFruta, APrecioTransporte: real;
                                                 const APrevision: boolean );
var
  rPrecio: Real;
begin
  rPrecio:= APrecioFruta + APrecioTransporte;
  if mtPrecios.Locate('producto_precio;proveedor_precio;empresa_precio', VarArrayOf([AProducto,AProveedor,AEmpresa]),[] ) then
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
    mtPrecios.FieldByname('producto_precio').AsString:= AProducto;
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

procedure TDLMargenBeneficios.PaletsProveedor;
var
  sAux: string;
  rAnt, rSig: real;
  iGrupo, iUnidades: integer;
  rPrecioCompra, rPrecioTransporte, rPrecioTransito, rPrecioEstadistico: real;
  rImporteCompra, rImporteTransporte, rImporteTransito, rImporteEstadistico: real;
  bFlagPrevisto, bEncontrado: Boolean;
  rPesoTeoricoCaja: Real;
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
    SQL.Add(' select producto, fecha_status, date(fecha_status) fecha, empresa, centro, entrega, ');
    SQL.Add('        sscc, proveedor, variedad, categoria, calibre, cajas, peso, peso_bruto, status, ');
    SQL.Add('        ( select unidades_caja_pp from frf_productos_proveedor ');
    SQL.Add('          where producto_pp = producto and variedad_pp = variedad ) * cajas as unidades');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where ( status = ''V'' or status = ''R'' or status = ''D'' ) '); //Volcado-Regularizado-Destrio
    SQL.Add(' and date(fecha_status) between :fechaini and :fechafin ');
    //SQL.Add(' AND date(fecha_ALTA) > :fechacorte ');
    SQL.Add(' and producto = :producto ');
    if sCliente <> '' then
    begin
      if sCliente = 'MER' then
        SQL.Add(' and ( cliente = :cliente  or  nvl(cliente,'''') = '''' ) ')
      else
        SQL.Add(' and cliente = :cliente ');
    end;
    SQL.Add(' order by 2 desc ');
  end;

  with QCajasRF do
  begin
    SQL.Clear;
    SQL.Add(' select sum( cajas ) cajas ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :entrega ');
    SQL.Add(' and status <> ''B'' ');
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
    SQL.Add('         sum( case when tipo_ge in (''059'',''060'') then importe_ge else 0 end ) importe_estadistico ');            //en la unificacion de tipo gasto el 110 de BAG no existe.
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
    SQL.Add(' and fecha_llegada_ec between fecha_ini_pcp and nvl(fecha_fin_pcp,fecha_llegada_ec) ');
    SQL.Add(' and codigo_el = codigo_ec ');
    SQL.Add(' and empresa_pcp = empresa_ec ');
    SQL.Add(' and producto_pcp = producto_ec ');
    SQL.Add(' group by coste_primera_pcp, coste_extra_pcp, coste_super_pcp, coste_platano10_pcp, coste_platanost_pcp, coste_resto_pcp, coste_transporte_pcp, categoria_el');
  end;

  iGrupo:= 1;
  while not mtResumen.Eof do
  begin
    if ( sEmpresa = 'F18' ) and ( mtResumen.FieldByName('producto').AsString = 'PIN' ) then
    begin
      rAnt:= mtResumen.FieldByName('unidades_confecionado_anterior').AsFloat;
      rSig:= mtResumen.FieldByName('unidades_confecionado_adelantado').AsFloat;
    end
    else
    begin
      rAnt:= mtResumen.FieldByName('kilos_confecionado_anterior').AsFloat;
      rSig:= mtResumen.FieldByName('kilos_confecionado_adelantado').AsFloat;
    end;

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
      if ( QAux.FieldByName('producto').AsString = 'PIN' ) or ( QAux.FieldByName('producto').AsString = 'COC' ) then
      begin
        if TryStrToInt( QAux.FieldByName('calibre').AsString, iUnidades ) then
        begin
          iUnidades:= iUnidades * QAux.FieldByName('cajas').AsInteger;
        end
        else
        begin
          iUnidades:= StrToIntDef( Copy( QAux.FieldByName('calibre').AsString, 2, Length( QAux.FieldByName('calibre').AsString ) ), 0 ) * QAux.FieldByName('cajas').AsInteger;
        end;
      end
      else
      begin
        iUnidades:= QAux.FieldByName('unidades').AsInteger;
      end;

      if QAux.FieldByName('fecha').AsDateTime >= dFechaIni then
      begin
        if  rSig > 0 then
        begin
          if ( sEmpresa = 'F18' ) and ( mtResumen.FieldByName('producto').AsString = 'PIN' ) then
            rSig:= rSig - iUnidades
          else
            rSig:= rSig - QAux.FieldByName('peso').AsFloat;
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
          if ( sEmpresa = 'F18' ) and ( mtResumen.FieldByName('producto').AsString = 'PIN' ) then
            rAnt:= rAnt - iUnidades
          else
            rAnt:= rAnt - QAux.FieldByName('peso').AsFloat;
          iGrupo:= 0;
        end
        else
        begin
          Break;
        end;
      end;

      if bFacturasFruta then
      begin
        PrecioEntrega( QAux.FieldByName('entrega').AsString, bFlagPrevisto, rPrecioCompra, rPrecioTransporte, rPrecioTransito, rPrecioEstadistico );
        ActualizarPrecios( sAux, QAux.FieldByName('producto').AsString, QAux.FieldByName('proveedor').AsString, rPrecioCompra, rPrecioTransporte + rPrecioTransito, bFlagPrevisto );
        rImporteCompra:= 0;
        rImporteTransporte:= 0;
        rImporteTransito:= 0;
        rImporteEstadistico:= 0;
        if CostesAplicar.bCompra then
          rImporteCompra:= bRoundTo( QAux.FieldByName('cajas').AsInteger * rPrecioCompra, 2 );
        if CostesAplicar.bTransporte then
          rImporteTransporte:= bRoundTo( QAux.FieldByName('cajas').AsInteger * rPrecioTransporte, 2 );
        if CostesAplicar.bTransito then
          rImporteTransito:= bRoundTo( QAux.FieldByName('cajas').AsInteger * rPrecioTransito, 2 );
        if CostesAplicar.bEstadistico then
          rImporteEstadistico:= bRoundTo( QAux.FieldByName('cajas').AsInteger * rPrecioEstadistico, 2 );
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
        mtPaletsProveedor.FieldByName('producto_in').AsString:= QAux.FieldByName('producto').AsString;
        mtPaletsProveedor.FieldByName('grupo_in').AsInteger:= iGrupo;
        mtPaletsProveedor.FieldByName('fecha_in').AsDateTime:= QAux.FieldByName('fecha').AsDateTime;
        mtPaletsProveedor.FieldByName('empresa_in').AsString:= QAux.FieldByName('empresa').AsString;
        mtPaletsProveedor.FieldByName('centro_in').AsString:= QAux.FieldByName('centro').AsString;
        mtPaletsProveedor.FieldByName('entrega_in').AsString:= QAux.FieldByName('entrega').AsString;
        mtPaletsProveedor.FieldByName('sscc_in').AsString:= QAux.FieldByName('sscc').AsString;
        mtPaletsProveedor.FieldByName('proveedor_in').AsString:= QAux.FieldByName('proveedor').AsString;
        mtPaletsProveedor.FieldByName('variedad_in').AsInteger:= QAux.FieldByName('variedad').AsInteger;
        mtPaletsProveedor.FieldByName('calibre_in').AsString:= QAux.FieldByName('calibre').AsString;
        mtPaletsProveedor.FieldByName('cajas_in').AsInteger:= QAux.FieldByName('cajas').AsInteger;
        mtPaletsProveedor.FieldByName('unidades_in').AsInteger:= iUnidades;
        mtPaletsProveedor.FieldByName('precio_in').AsFloat:= rPrecioCompra + rPrecioTransporte + rPrecioTransito;
        mtPaletsProveedor.FieldByName('peso_in').AsFloat:= QAux.FieldByName('peso').AsFloat;
        mtPaletsProveedor.FieldByName('importe_in').AsFloat:= rImporteCompra + rImporteTransporte + rImporteTransito;
        mtPaletsProveedor.FieldByName('peso_bruto_in').AsFloat:= QAux.FieldByName('peso_bruto').AsFloat;
        mtPaletsProveedor.FieldByName('status_in').AsString:= QAux.FieldByName('status').AsString;
        mtPaletsProveedor.Post;
      end;


      rPesoTeoricoCaja:= GetKiloCajaTeorico( QAux.FieldByName('entrega').AsString,
                               QAux.FieldByName('empresa').AsString,
                               QAux.FieldByName('proveedor').AsString,
                               QAux.FieldByName('producto').AsString,
                               QAux.FieldByName('variedad').AsString,
                               QAux.FieldByName('categoria').AsString,
                               QAux.FieldByName('calibre').AsString,
                               bEncontrado);
      mtResumen.Edit;
      if iGrupo = 0 then
      begin
        //Volcado semana anterior
        mtResumen.FieldByName('kilos_volcado_anterior').AsFloat:= mtResumen.FieldByName('kilos_volcado_anterior').AsFloat + ( QAux.FieldByName('cajas').AsInteger * rPesoTeoricoCaja );

        mtResumen.FieldByName('peso_volcado_anterior').AsFloat:= mtResumen.FieldByName('peso_volcado_anterior').AsFloat + QAux.FieldByName('peso').AsFloat;
        mtResumen.FieldByName('cajas_volcado_anterior').AsInteger:= mtResumen.FieldByName('cajas_volcado_anterior').AsInteger + QAux.FieldByName('cajas').AsInteger;
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
        mtResumen.FieldByName('kilos_volcado_adelantado').AsFloat:= mtResumen.FieldByName('kilos_volcado_adelantado').AsFloat + ( QAux.FieldByName('cajas').AsInteger * rPesoTeoricoCaja );
        mtResumen.FieldByName('peso_volcado_adelantado').AsFloat:= mtResumen.FieldByName('peso_volcado_adelantado').AsFloat + QAux.FieldByName('peso').AsFloat;
        mtResumen.FieldByName('cajas_volcado_adelantado').AsInteger:= mtResumen.FieldByName('cajas_volcado_adelantado').AsInteger + QAux.FieldByName('cajas').AsInteger;
        mtResumen.FieldByName('unidades_volcado_adelantado').AsInteger:= mtResumen.FieldByName('unidades_volcado_adelantado').AsInteger + iUnidades;
      end
      else
      begin
        //Cargado semana confeccionado semana
        mtResumen.FieldByName('kilos_volcado').AsFloat:= mtResumen.FieldByName('kilos_volcado').AsFloat + ( QAux.FieldByName('cajas').AsInteger * rPesoTeoricoCaja );
        mtResumen.FieldByName('peso_volcado').AsFloat:= mtResumen.FieldByName('peso_volcado').AsFloat + QAux.FieldByName('peso').AsFloat;
        mtResumen.FieldByName('cajas_volcado').AsInteger:= mtResumen.FieldByName('cajas_volcado').AsInteger + QAux.FieldByName('cajas').AsInteger;
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

function TDLMargenBeneficios.KilosCajas: real;
begin
  if qryKilosTeoricosCaja.FieldByName('cajas').AsFloat <> 0 then
    result:= bRoundTo( qryKilosTeoricosCaja.FieldByName('kilos').AsFloat / qryKilosTeoricosCaja.FieldByName('cajas').AsFloat, 3 )
  else
    result:= 0;
end;

function TDLMargenBeneficios.GetKiloCajaTeorico( const AEntrega, AEmpresa, AProveedor, AProducto, AVariedad, ACategoria, ACalibre: string;
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


end.
