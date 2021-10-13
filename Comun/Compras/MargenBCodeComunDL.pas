unit MargenBCodeComunDL;

interface

uses
  SysUtils, Classes, DB, kbmMemTable;

type
  RCostesAplicar = record
    bCompra, bTransporte, bTransito, bImporteVenta, bGastosVenta, bImporteAbonos,
    bMaterial, bPersonal, bGeneral, bFinanciero, bEstadistico: boolean;
  end;

  TDLMargenBCodeComun = class(TDataModule)
    kmtMargen: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sProducto, sCliente: string;
    dFechaIni, dFechaFin: TDateTime;
    costesAplicar: RCostesAplicar;

    dsEmpresa, dsPeriodo, dsProducto, dsCliente: string;
    diCajasAlbaran, diUnidadesAlbaran, diCajasAlbaranNoFac, diUnidadesAlbaranNoFac: Integer;
    drPesoAlbaran, drPesoAlbaranNoFac, drImporteAlbaran, drDescuentosFac, drDescuentosNoFac, drImporteAbonos :Real;
    drCosteVenta, drCosteMaterial, drCostePersonal, drCosteGeneral, drCosteFinanciero :Real;
    diCajasVolcadas, diUnidadesVolcadas: Integer;
    drPesoVolcadas, drImporteVolcadas, drPrecioVolcadas:Real;

    diCajasCargadasVentas, diUnidadesCargadasVentas: Integer;
    drPesoCargadasVentas, drImporteCargadasVentas, drPrecioCargadasVentas:Real;
    diCajasCargadasTransitos, diUnidadesCargadasTransitos: Integer;
    drPesoCargadasTransitos, drImporteCargadasTransitos, drPrecioCargadasTransitos:Real;

    diCajasConfCarga, diUnidadesConfCarga: Integer;
    drPesoConfCarga  :Real;
    diCajasConfAlta, diUnidadesConfAlta: Integer;
    drPesoConfAlta  :Real;

    drIngresoVenta, drCosteFruta, drCosteEnvasado, drOtros: Real;
    drMargenProducto, drMargenBruto, drResultado: Real;

    procedure MakeLinMargen;
    procedure ViewMargen;


    procedure PutDataVentas;
    procedure PutDataVentasDirecta;
    procedure PutDataTransitosDirecta;

    procedure PutDataVolcados;
    procedure PutDataCargaConfecionada;
    procedure PutDataAltaConfecionada;

  public
    { Public declarations }
    function MargenOperativo( const AEmpresa, AProducto, ACliente: string ;
                               const AFechaIni, AFechaFin: TDateTime;
                               const ACostesAplicar: RCostesAplicar ): Boolean;
    procedure CerrarQuerys;
  end;

  procedure ViewMargenOperativo( const AEmpresa, AProducto, ACliente: string ;
                                 const AFechaIni, AFechaFin: TDateTime;
                                 const ACostesAplicar: RCostesAplicar );
  procedure ViewParteConfeccion( const AEmpresa, AProducto, ACliente: string ;
                                 const AFechaIni, AFechaFin: TDateTime;
                                 const ACostesAplicar: RCostesAplicar );

var
  DLMargenBCodeComun: TDLMargenBCodeComun;

implementation

{$R *.dfm}

uses
  Forms, Dialogs, Variants, MargenBProveedorDL, MargenBConfeccionDL, MargenBVentasDL, MargenBResultadosQL;


procedure ViewMargenOperativo( const AEmpresa, AProducto, ACliente: string ;
                                 const AFechaIni, AFechaFin: TDateTime;
                                 const ACostesAplicar: RCostesAplicar );
begin
  Application.CreateForm( TDLMargenBCodeComun, DLMargenBCodeComun );
  try
    if DLMargenBCodeComun.MargenOperativo( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar ) then
    begin
      //DLMargenBCodeComun.MakeMasterDetail;
      //DLMargenBCodeComun.VerMargenBVentas( AEmpresa, AProducto, AFechaIni, AFechaFin  );
    end
    else
    begin
      ShowMessage('Sin Ventas para los parametros de entradas seleccionados.');
    end;
    DLMargenBCodeComun.CerrarQuerys;
  finally
    FreeAndNil( DLMargenBCodeComun );
  end;
end;

procedure ViewParteConfeccion( const AEmpresa, AProducto, ACliente: string ;
                                 const AFechaIni, AFechaFin: TDateTime;
                                 const ACostesAplicar: RCostesAplicar );
begin
  Application.CreateForm( TDLMargenBCodeComun, DLMargenBCodeComun );
  try
    if DLMargenBCodeComun.MargenOperativo( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar ) then
    begin
      //DLMargenBCodeComun.MakeMasterDetail;
      //DLMargenBCodeComun.VerMargenBVentas( AEmpresa, AProducto, AFechaIni, AFechaFin  );
    end
    else
    begin
      ShowMessage('Sin Ventas para los parametros de entradas seleccionados.');
    end;
    DLMargenBCodeComun.CerrarQuerys;
  finally
    FreeAndNil( DLMargenBCodeComun );
  end;
end;

procedure TDLMargenBCodeComun.DataModuleCreate(Sender: TObject);
begin
  kmtMargen.FieldDefs.Clear;
  kmtMargen.FieldDefs.Add('empresa', ftString, 3, False);
  kmtMargen.FieldDefs.Add('periodo', ftString, 15, False);
  kmtMargen.FieldDefs.Add('producto', ftString, 3, False);
  kmtMargen.FieldDefs.Add('cliente', ftString, 3, False);

  kmtMargen.FieldDefs.Add('cajas_no_facturables', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('unidades_no_facturables', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('peso_no_facturables', ftFloat, 0, False);

  kmtMargen.FieldDefs.Add('cajas_albaran', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('unidades_albaran', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('peso_albaran', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('importe_albaran', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('descuentos_fac', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('descuentos_nofac', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('importe_abonos', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('coste_venta', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('coste_material', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('coste_personal', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('coste_general', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('coste_financiero', ftFloat, 0, False);

  kmtMargen.FieldDefs.Add('cajas_volcadas', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('unidades_volcadas', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('peso_volcadas', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('importe_volcadas', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('precio_volcadas', ftFloat, 0, False);

  kmtMargen.FieldDefs.Add('cajas_cargadas_ventas', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('unidades_cargadas_ventas', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('peso_cargadas_ventas', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('importe_cargadas_ventas', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('precio_cargadas_ventas', ftFloat, 0, False);

  kmtMargen.FieldDefs.Add('cajas_cargadas_transitos', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('unidades_cargadas_transitos', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('peso_cargadas_transitos', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('importe_cargadas_transitos', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('precio_cargadas_transitos', ftFloat, 0, False);

  kmtMargen.FieldDefs.Add('cajas_conf_carga', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('unidades_conf_carga', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('peso_conf_carga', ftFloat, 0, False);

  kmtMargen.FieldDefs.Add('cajas_conf_alta', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('unidades_conf_alta', ftInteger, 0, False);
  kmtMargen.FieldDefs.Add('peso_conf_alta', ftFloat, 0, False);

  kmtMargen.FieldDefs.Add('ingresos_venta', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('coste_producto', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('coste_envasado', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('otros_costes', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('margen_producto', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('margen_bruto', ftFloat, 0, False);
  kmtMargen.FieldDefs.Add('resultado', ftFloat, 0, False);

  kmtMargen.CreateTable;
  kmtMargen.Open;
end;

procedure TDLMargenBCodeComun.CerrarQuerys;
begin
  kmtMargen.Close;
  (*
  MargenBVentasDL.CerrarVentas;
  MargenBProveedorDL.CerrarPaletsProveedor;
  MargenBConfeccionDL.CerrarPaletsConfeccion;
  *)
end;


procedure TDLMargenBCodeComun.PutDataVentas;
begin
    dsEmpresa:= sEmpresa;
    dsPeriodo:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('periodo').asString;
    dsProducto:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('producto').asString;
    dsCliente:= sCliente;

    diCajasAlbaranNoFac:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('cajas_no_facturables').asInteger;
    diUnidadesAlbaranNoFac:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('unidades_no_facturables').asInteger;
    drPesoAlbaranNoFac:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('peso_no_facturables').asFloat;

    diCajasAlbaran:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('cajas_albaran').asInteger;
    diUnidadesAlbaran:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('unidades_albaran').asInteger;
    drPesoAlbaran:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('peso_albaran').asFloat;
    drImporteAlbaran:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('importe_albaran').asFloat;
    drDescuentosFac:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('descuentos_fac').asFloat;
    drDescuentosNoFac:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('descuentos_nofac').asFloat;
    drImporteAbonos:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('importe_abonos').asFloat;
    drCosteVenta:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('coste_venta').asFloat;
    drCosteMaterial:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('coste_material').asFloat;
    drCostePersonal:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('coste_personal').asFloat;
    drCosteGeneral:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('coste_general').asFloat;
    drCosteFinanciero:= MargenBVentasDL.DLMargenBVentas.kmtVentas.FieldByName('coste_financiero').asFloat;
end;

procedure TDLMargenBCodeComun.PutDataVentasDirecta;
begin
  if MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.Locate( 'periodo;producto',
       VarArrayOf([dsPeriodo,dsProducto]), [] ) then
  begin
    diCajasCargadasVentas:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('cajas').asInteger;
    diUnidadesCargadasVentas:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('unidades').asInteger;
    drPesoCargadasVentas:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('peso').asFloat;
    drImporteCargadasVentas:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('importe').asFloat;
    drPrecioCargadasVentas:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('precio').asFloat;
  end
  else
  begin
    diCajasCargadasVentas:= 0;
    diUnidadesCargadasVentas:= 0;
    drPesoCargadasVentas:= 0;
    drImporteCargadasVentas:= 0;
    drPrecioCargadasVentas:= 0;
  end;
end;


procedure TDLMargenBCodeComun.PutDataTransitosDirecta;
begin
  if MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.Locate( 'periodo;producto',
       VarArrayOf([dsPeriodo,dsProducto]), [] ) then
  begin
    diCajasCargadasTransitos:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('cajas').asInteger;
    diUnidadesCargadasTransitos:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('unidades').asInteger;
    drPesoCargadasTransitos:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('peso').asFloat;
    drImporteCargadasTransitos:= 0;//MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('importe').asFloat;
    drPrecioCargadasTransitos:= 0;//MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('precio').asFloat;
  end
  else
  begin
    diCajasCargadasTransitos:= 0;
    diUnidadesCargadasTransitos:= 0;
    drPesoCargadasTransitos:= 0;
    drImporteCargadasTransitos:= 0;
    drPrecioCargadasTransitos:= 0;
  end;
end;

procedure TDLMargenBCodeComun.PutDataVolcados;
begin
  if MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.Locate( 'periodo;producto',
       VarArrayOf([dsPeriodo,dsProducto]), [] ) then
  begin
    diCajasVolcadas:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('cajas').AsInteger;
    diUnidadesVolcadas:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('unidades').AsInteger;
    drPesoVolcadas:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('peso').asFloat;
    drImporteVolcadas:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('importe').asFloat;
    drPrecioVolcadas:= MargenBProveedorDL.DLMargenBProveedor.kmtLineasProveedor.FieldByName('precio').asFloat;
  end
  else
  begin
    diCajasVolcadas:= 0;
    diUnidadesVolcadas:= 0;
    drPesoVolcadas:= 0;
    drImporteVolcadas:= 0;
    drPrecioVolcadas:= 0;
  end;
end;

procedure TDLMargenBCodeComun.PutDataCargaConfecionada;
begin
  if MargenBConfeccionDL.DLMargenBConfeccion.kmtLineas.Locate( 'periodo;producto',
       VarArrayOf([dsPeriodo,dsProducto]), [] ) then
  begin
    diCajasConfCarga:= MargenBConfeccionDL.DLMargenBConfeccion.kmtLineas.FieldByName('cajas').asInteger;
    diUnidadesConfCarga:= MargenBConfeccionDL.DLMargenBConfeccion.kmtLineas.FieldByName('unidades').asInteger;
    drPesoConfCarga:= MargenBConfeccionDL.DLMargenBConfeccion.kmtLineas.FieldByName('peso').asFloat;
  end
  else
  begin
    diCajasConfCarga:= 0;
    diUnidadesConfCarga:= 0;
    drPesoConfCarga:= 0;
  end;
end;

procedure TDLMargenBCodeComun.PutDataAltaConfecionada;
begin
  if MargenBConfeccionDL.DLMargenBConfeccion.kmtLineas.Locate( 'periodo;producto',
       VarArrayOf([dsPeriodo,dsProducto]), [] ) then
  begin
    diCajasConfAlta:= MargenBConfeccionDL.DLMargenBConfeccion.kmtLineas.FieldByName('cajas').asInteger;
    diUnidadesConfAlta:= MargenBConfeccionDL.DLMargenBConfeccion.kmtLineas.FieldByName('unidades').asInteger;
    drPesoConfAlta:= MargenBConfeccionDL.DLMargenBConfeccion.kmtLineas.FieldByName('peso').asFloat;
  end
  else
  begin
    diCajasConfAlta:= 0;
    diUnidadesConfAlta:= 0;
    drPesoConfAlta:= 0;
  end;
end;

function TDLMargenBCodeComun.MargenOperativo( const AEmpresa, AProducto, ACliente: string ;
                               const AFechaIni, AFechaFin: TDateTime;
                               const ACostesAplicar: RCostesAplicar ): boolean;
begin
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  sCliente:= ACliente;
  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;
  costesAplicar:= ACostesAplicar;

  MargenBVentasDL.IniciarVentas;
  result:= MargenBVentasDL.ProcesoVentas( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar );
  if result then
  begin
    PutDataVentas;
    MargenBVentasDL.CerrarVentas;

    MargenBProveedorDL.IniciarPaletsProveedor;
    MargenBProveedorDL.ProcesoProveedor( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, tvVentas );
    PutDataVentasDirecta;
    MargenBProveedorDL.ProcesoProveedor( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, tvTransitos );
    PutDataTransitosDirecta;
    MargenBProveedorDL.ProcesoProveedor( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, tvVolcados );
    PutDataVolcados;
    MargenBProveedorDL.CerrarPaletsProveedor;

    MargenBConfeccionDL.IniciarPaletsConfeccion;
    MargenBConfeccionDL.ProcesoConfeccion( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, tcCarga );
    PutDataCargaConfecionada;
    MargenBConfeccionDL.ProcesoConfeccion( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, tcAlta );
    PutDataAltaConfecionada;
    MargenBConfeccionDL.CerrarPaletsConfeccion;

    //Adelantado semana anterior
    //MargenBConfeccionDL.ProcesoConfeccion( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, tcAnterior );
    //Adelantado semana siguiente
    //MargenBConfeccionDL.ProcesoConfeccion( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, tcSiguiente );

    MakeLinMargen;
    ViewMargen;
  end
  else
  begin
    MargenBVentasDL.CerrarVentas;
  end;
end;

procedure TDLMargenBCodeComun.MakeLinMargen;
begin
  kmtMargen.Insert;

  kmtMargen.FieldByName('empresa').asString:= dsEmpresa;
  kmtMargen.FieldByName('periodo').asString:= dsPeriodo;
  kmtMargen.FieldByName('producto').asString:= dsProducto;
  kmtMargen.FieldByName('cliente').asString:= dsCliente;

  kmtMargen.FieldByName('cajas_no_facturables').asFloat:= diCajasAlbaranNoFac;
  kmtMargen.FieldByName('unidades_no_facturables').asFloat:= diUnidadesAlbaranNoFac;
  kmtMargen.FieldByName('peso_no_facturables').asFloat:= drPesoAlbaranNoFac;

  kmtMargen.FieldByName('cajas_albaran').asFloat:= diCajasAlbaran;
  kmtMargen.FieldByName('unidades_albaran').asFloat:= diUnidadesAlbaran;
  kmtMargen.FieldByName('peso_albaran').asFloat:= drPesoAlbaran;
  kmtMargen.FieldByName('importe_albaran').asFloat:= drImporteAlbaran;
  kmtMargen.FieldByName('descuentos_fac').asFloat:= drDescuentosFac;
  kmtMargen.FieldByName('descuentos_nofac').asFloat:= drDescuentosNoFac;
  kmtMargen.FieldByName('importe_abonos').asFloat:= drImporteAbonos;
  kmtMargen.FieldByName('coste_venta').asFloat:= drCosteVenta;
  kmtMargen.FieldByName('coste_material').asFloat:= drCosteMaterial;
  kmtMargen.FieldByName('coste_personal').asFloat:= drCostePersonal;
  kmtMargen.FieldByName('coste_general').asFloat:= drCosteGeneral;
  kmtMargen.FieldByName('coste_financiero').asFloat:= drCosteFinanciero;

  kmtMargen.FieldByName('cajas_volcadas').asInteger:= diCajasVolcadas;
  kmtMargen.FieldByName('unidades_volcadas').asInteger:= diUnidadesVolcadas;
  kmtMargen.FieldByName('peso_volcadas').asFloat:= drPesoVolcadas;
  kmtMargen.FieldByName('importe_volcadas').asFloat:= drImporteVolcadas;
  kmtMargen.FieldByName('precio_volcadas').asFloat:= drPrecioVolcadas;

  kmtMargen.FieldByName('cajas_cargadas_ventas').asInteger:= diCajasCargadasVentas;
  kmtMargen.FieldByName('unidades_cargadas_ventas').asInteger:= diUnidadesCargadasVentas;
  kmtMargen.FieldByName('peso_cargadas_ventas').asFloat:= drPesoCargadasVentas;
  kmtMargen.FieldByName('importe_cargadas_ventas').asFloat:= drImporteCargadasVentas;
  kmtMargen.FieldByName('precio_cargadas_ventas').asFloat:= drPrecioCargadasVentas;

  kmtMargen.FieldByName('cajas_cargadas_transitos').asInteger:= diCajasCargadasTransitos;
  kmtMargen.FieldByName('unidades_cargadas_transitos').asInteger:= diUnidadesCargadasTransitos;
  kmtMargen.FieldByName('peso_cargadas_transitos').asFloat:= drPesoCargadasTransitos;
  kmtMargen.FieldByName('importe_cargadas_transitos').asFloat:= drImporteCargadasTransitos;
  kmtMargen.FieldByName('precio_cargadas_transitos').asFloat:= drPrecioCargadasTransitos;

  kmtMargen.FieldByName('cajas_conf_carga').asInteger:= diCajasConfCarga;
  kmtMargen.FieldByName('unidades_conf_carga').asInteger:= diUnidadesConfCarga;
  kmtMargen.FieldByName('peso_conf_carga').asFloat:= drPesoConfCarga;

  kmtMargen.FieldByName('cajas_conf_alta').asInteger:= diCajasConfAlta;
  kmtMargen.FieldByName('unidades_conf_alta').asInteger:= diUnidadesConfAlta;
  kmtMargen.FieldByName('peso_conf_alta').asFloat:= drPesoConfAlta;


  drIngresoVenta:= drImporteAlbaran - ( drDescuentosFac + drDescuentosNoFac + drImporteAbonos + drCosteVenta );
  kmtMargen.FieldByName('ingresos_venta').asFloat:= drIngresoVenta;

  drCosteFruta:= drImporteVolcadas + drImporteCargadasVentas;
  kmtMargen.FieldByName('coste_producto').asFloat:= drCosteFruta;

  drCosteEnvasado:= drCosteMaterial + drCostePersonal;
  kmtMargen.FieldByName('coste_envasado').asFloat:= drCosteEnvasado;

  drOtros:= drCosteGeneral + drCosteFinanciero;
  kmtMargen.FieldByName('otros_costes').asFloat:= drOtros;

  drMargenProducto:= drIngresoVenta - drCosteFruta;
  kmtMargen.FieldByName('margen_producto').asFloat:= drMargenProducto;

  drMargenBruto:= drMargenProducto - drCosteEnvasado;
  kmtMargen.FieldByName('margen_bruto').asFloat:= drMargenBruto;

  drResultado:= drMargenBruto - drOtros;
  kmtMargen.FieldByName('resultado').asFloat:= drResultado;

  kmtMargen.Post;
end;

procedure TDLMargenBCodeComun.ViewMargen;
begin
  MargenBResultadosQL.VerMargenBResultados( sEmpresa, sProducto, dFechaIni, dFechaFin  );
end;

end.
