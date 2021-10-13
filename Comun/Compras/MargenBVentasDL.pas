unit MargenBVentasDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable, MargenBCodeComunDL;

type
  TDLMargenBVentas = class(TDataModule)
    kmtVentasClientes: TkbmMemTable;
    QCostesEnvasado: TQuery;
    mtCostesEnvasado: TkbmMemTable;
    qryGastosAlbaran: TQuery;
    qryKilosALbaran: TQuery;
    qrySalidas: TQuery;
    kmtGastosAlbaran: TkbmMemTable;
    kmtVentas: TkbmMemTable;
    qryAbonos: TQuery;
    dsVentas: TDataSource;
    qryCostesEstructura: TQuery;
    kmtCostesEstructura: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sgEmpresa, sgCliente, sgProducto: string;
    dgFechaIni, dgFechaFin: TDateTime;
    gCostesAplicar: RCostesAplicar;

    procedure CerrarQuerys;
    procedure QueryVentas;

    function  ProductosVendidos: boolean;
    procedure PutResumen;
    procedure AddLineaResumen;
    procedure NewLineaResumen;
    procedure ModLineaResumen;
    function  CosteFinanciero( const APlanta, ACentro: string; const AFecha: TDateTime ): real;
    procedure CosteEnvasado( const APlanta, ACentro, AEnvase, AProducto: string; const AProductoBase: integer;
                             const AFecha: TDateTime; var VPrecioMaterial, VPrecioPersonal, VPrecioGeneral: real );
    procedure PutImporteAbonos;
    function  ImporteAbonos( const AEmpresa, AProducto, ACliente: string; const AFechaIni, AFechaFin: TDateTime ): Real;

    function  GastoVenta( const AEmpresa, ACentro: string; const AAlbaran: Integer; const AFecha: TDateTime;
                                      const AProducto: string; const AKilos: Real; const ATransito: Boolean ): real;

    procedure MakeMasterDetail;
  public
    { Public declarations }
    function Ventas( const AEmpresa, AProducto, ACliente: string ;
                      const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar ): Boolean;
  end;

  procedure ViewVentas( const AEmpresa, AProducto, ACliente: string ;
                                const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar );

  procedure IniciarVentas;
  function  ProcesoVentas( const AEmpresa, AProducto, ACliente: string ;
                                const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar ): boolean;
  procedure CerrarVentas;


var
  DLMargenBVentas: TDLMargenBVentas;

implementation

{$R *.dfm}

uses
  MargenBVentasQL,
  Forms, variants, bMath, UDMBaseDatos, DateUtils, UDMAuxDB, dialogs, bTimeUtils;

var
  bModuloIni: boolean = false;


procedure ViewVentas( const AEmpresa, AProducto, ACliente: string ;
                                const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar );
begin
  Application.CreateForm( TDLMargenBVentas, DLMargenBVentas );
  try
    if DLMargenBVentas.Ventas( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar ) then
    begin
      DLMargenBVentas.MakeMasterDetail;
      MargenBVentasQL.VerMargenBVentas( AEmpresa, AProducto, AFechaIni, AFechaFin  );
    end
    else
    begin
      ShowMessage('Sin Ventas para los parametros de entradas seleccionados.');
    end;
    DLMargenBVentas.CerrarQuerys;
  finally
    FreeAndNil( DLMargenBVentas );
  end;
end;


procedure IniciarVentas;
begin
  if not bModuloIni then
  begin
    Application.CreateForm( TDLMargenBVentas, DLMargenBVentas );
    bModuloIni:= True;
  end;
end;


function ProcesoVentas( const AEmpresa, AProducto, ACliente: string ;
                                const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar ): boolean;
begin
  DLMargenBVentas.qrySalidas.Close;
  DLMargenBVentas.qryGastosAlbaran.Close;
  DLMargenBVentas.qryKilosAlbaran.Close;
  DLMargenBVentas.QCostesEnvasado.Close;
  DLMargenBVentas.qryAbonos.Close;
  DLMargenBVentas.qryCostesEstructura.Close;

  DLMargenBVentas.kmtVentas.Close;
  DLMargenBVentas.kmtVentasClientes.Close;
  DLMargenBVentas.mtCostesEnvasado.Close;
  DLMargenBVentas.kmtGastosAlbaran.Close;
  DLMargenBVentas.kmtCostesEstructura.Close;

  DLMargenBVentas.kmtVentas.Open;
  DLMargenBVentas.kmtVentasClientes.Open;
  DLMargenBVentas.mtCostesEnvasado.Open;
  DLMargenBVentas.kmtGastosAlbaran.Open;
  DLMargenBVentas.kmtCostesEstructura.Open;

  result:= DLMargenBVentas.Ventas( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar );
end;

procedure CerrarVentas;
begin
  bModuloIni:= False;
  DLMargenBVentas.CerrarQuerys;
  FreeAndNil( DLMargenBVentas );
end;


procedure TDLMargenBVentas.DataModuleCreate(Sender: TObject);
begin
  kmtVentas.FieldDefs.Clear;
  kmtVentas.FieldDefs.Add('empresa', ftString, 3, False);
  kmtVentas.FieldDefs.Add('periodo', ftString, 15, False);
  kmtVentas.FieldDefs.Add('producto', ftString, 3, False);
  kmtVentas.FieldDefs.Add('cliente', ftString, 3, False);

  kmtVentas.FieldDefs.Add('cajas_albaran', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('unidades_albaran', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('peso_albaran', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('importe_albaran', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('descuentos_fac', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('descuentos_nofac', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('importe_abonos', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('coste_venta', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('coste_material', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('coste_personal', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('coste_general', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('coste_financiero', ftFloat, 0, False);

  kmtVentas.FieldDefs.Add('cajas_no_facturables', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('unidades_no_facturables', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('peso_no_facturables', ftFloat, 0, False);

  kmtVentas.CreateTable;
  kmtVentas.Open;

  kmtVentasClientes.FieldDefs.Clear;
  kmtVentasClientes.FieldDefs.Add('empresa', ftString, 3, False);
  kmtVentasClientes.FieldDefs.Add('periodo', ftString, 15, False);
  kmtVentasClientes.FieldDefs.Add('producto', ftString, 3, False);
  kmtVentasClientes.FieldDefs.Add('cliente', ftString, 3, False);
  kmtVentasClientes.FieldDefs.Add('facturable', ftInteger, 0, False);
  kmtVentasClientes.FieldDefs.Add('producto_base', ftInteger, 0, False);

  kmtVentasClientes.FieldDefs.Add('cajas_albaran', ftFloat, 0, False);
  kmtVentasClientes.FieldDefs.Add('unidades_albaran', ftFloat, 0, False);
  kmtVentasClientes.FieldDefs.Add('peso_albaran', ftFloat, 0, False);

  kmtVentasClientes.FieldDefs.Add('importe_albaran', ftFloat, 0, False);
  kmtVentasClientes.FieldDefs.Add('descuentos_fac', ftFloat, 0, False);
  kmtVentasClientes.FieldDefs.Add('descuentos_nofac', ftFloat, 0, False);
  kmtVentasClientes.FieldDefs.Add('importe_abonos', ftFloat, 0, False);
  kmtVentasClientes.FieldDefs.Add('coste_venta', ftFloat, 0, False);
  kmtVentasClientes.FieldDefs.Add('coste_material', ftFloat, 0, False);
  kmtVentasClientes.FieldDefs.Add('coste_personal', ftFloat, 0, False);
  kmtVentasClientes.FieldDefs.Add('coste_general', ftFloat, 0, False);
  kmtVentasClientes.FieldDefs.Add('coste_financiero', ftFloat, 0, False);
  kmtVentasClientes.CreateTable;
  kmtVentasClientes.Open;


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
  mtCostesEnvasado.Open;

  kmtGastosAlbaran.FieldDefs.Clear;
  kmtGastosAlbaran.FieldDefs.Add('empresa', ftString, 3, False);
  kmtGastosAlbaran.FieldDefs.Add('centro', ftString, 3, False);
  kmtGastosAlbaran.FieldDefs.Add('fecha', ftDateTime, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('albaran', ftInteger, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('producto', ftString, 3, False);
  (*
  kmtGastosAlbaran.FieldDefs.Add('kg_total', ftFloat, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('kg_producto', ftFloat, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('kg_total_tran', ftFloat, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('kg_producto_tran', ftFloat, 0, False);

  kmtGastosAlbaran.FieldDefs.Add('eur_total', ftFloat, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('eur_producto', ftFloat, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('eur_total_tran', ftFloat, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('eur_producto_tran', ftFloat, 0, False);
  *)
  kmtGastosAlbaran.FieldDefs.Add('eur_kg_total', ftFloat, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('eur_kg_producto', ftFloat, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('eur_kg_total_tran', ftFloat, 0, False);
  kmtGastosAlbaran.FieldDefs.Add('eur_kg_producto_tran', ftFloat, 0, False);
  kmtGastosAlbaran.CreateTable;
  kmtGastosAlbaran.Open;


  with qryGastosAlbaran do
  begin
    SQL.Clear;
    SQL.Add(' select sum( case when gasto_transito_tg = 0 then 1 else 0 end * ');
    SQL.Add('             case when producto_g is null then 1 else 0 end * euros( moneda_sc, fecha_sc, importe_g ) ) total, ');
    SQL.Add('        sum( case when gasto_transito_tg = 0 then 1 else 0 end * ');
    SQL.Add('             case when producto_g = :producto then 1 else 0 end * euros( moneda_sc, fecha_sc, importe_g ) ) producto, ');
    SQL.Add('        sum( case when gasto_transito_tg = 1 then 1 else 0 end * ');
    SQL.Add('             case when producto_g is null then 1 else 0 end * euros( moneda_sc, fecha_sc, importe_g ) ) total_tran, ');
    SQL.Add('        sum( case when gasto_transito_tg = 1 then 1 else 0 end * ');
    SQL.Add('             case when producto_g = :producto then 1 else 0 end * euros( moneda_sc, fecha_sc, importe_g ) ) producto_tran ');
    SQL.Add(' from frf_gastos ');
    SQL.Add('      join frf_tipo_gastos on tipo_g = tipo_tg ');
    SQL.Add('      join frf_salidas_c on empresa_g = empresa_sc and centro_salida_g = centro_salida_sc  ');
    SQL.Add('                          and fecha_g = fecha_sc and n_albaran_g = n_albaran_sc  ');
    SQL.Add('   where empresa_g = :empresa ');
    SQL.Add('   and centro_salida_g = :centro ');
    SQL.Add('   and fecha_g = :fecha ');
    SQL.Add('   and n_albaran_g = :albaran ');
    SQL.Add('   and ( producto_g = :producto or producto_g is null ) ');
  end;

  with qryKilosALbaran do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        sum( kilos_sl) kilos_total, ');
    SQL.Add('        sum( case when producto_sl = :producto then kilos_sl else 0 end ) kilos_producto, ');
    SQL.Add('        sum( case when ref_transitos_sl is not null then kilos_sl else 0 end ) kilos_total_tran, ');
    SQL.Add('        sum( case when producto_sl = :producto then ');
    SQL.Add('                                             case when ref_transitos_sl is not null then kilos_sl else 0 end ');
    SQL.Add('                                                  else 0 end ) kilos_producto_tran  ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and fecha_sl = :fecha ');
    SQL.Add(' and n_albaran_sl = :albaran ');
  end;

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

  with qryAbonos do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_neto_fd) importe ');
    SQL.Add(' from tfacturas_cab ');
    SQL.Add('      join tfacturas_det on cod_factura_fc = cod_factura_fd ');
    SQL.Add(' where cod_empresa_albaran_fd = :empresa  ');
    SQL.Add(' and fecha_factura_fc between :fechai and :fecha_fin ');
    SQL.Add(' and automatica_fc = 0 ');
    SQL.Add(' and anulacion_fc = 0 ');
    SQL.Add(' and cod_producto_fd = :producto ');
    SQL.Add(' and cod_cliente_fc = :cliente ');
  end;

  with qryCostesEstructura do
  begin
    SQL.Clear;
    SQL.Add(' select comercial_ci + produccion_ci + administracion_ci estructura');
    SQL.Add(' from frf_costes_indirectos ');
    SQL.Add(' where empresa_ci = :empresa ');
    SQL.Add(' and centro_origen_ci = :centro ');
    //SQL.Add(' and :fecha between fecha_ini_ci and nvl(fecha_fin_ci, today ) ');
    SQL.Add(' and fecha_ini_ci <=  :fecha  ');
    SQL.Add(' and nvl(fecha_fin_ci, today ) >= :fecha  ');
  end;

  kmtCostesEstructura.FieldDefs.Clear;
  kmtCostesEstructura.FieldDefs.Add('planta', ftString, 3, False);
  kmtCostesEstructura.FieldDefs.Add('centro', ftString, 3, False);
  kmtCostesEstructura.FieldDefs.Add('fecha', ftDate, 0, False);
  kmtCostesEstructura.FieldDefs.Add('estructura', ftFloat, 0, False);
  kmtCostesEstructura.CreateTable;
  kmtCostesEstructura.Open;
end;

procedure TDLMargenBVentas.CerrarQuerys;
begin
  qrySalidas.Close;
  kmtVentas.Close;
  kmtVentasClientes.Close;
  mtCostesEnvasado.Close;
  kmtCostesEstructura.Close;
  kmtGastosAlbaran.Close;
  qryGastosAlbaran.Close;
  qryKilosALbaran.Close;
  QCostesEnvasado.Close;
  qryAbonos.Close;
  qryCostesEstructura.Close;
end;

function TDLMargenBVentas.Ventas( const AEmpresa, AProducto, ACliente: string ;
                      const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar ): boolean;
begin
  gCostesAplicar:=  ACostesAplicar;
  sgEmpresa:= AEmpresa;
  sgProducto:= AProducto;
  sgCliente:= ACliente;
  dgFechaIni:= AFechaIni;
  dgFechaFin:= AFechaFin;

  QueryVentas;
  result:= ProductosVendidos;
end;

procedure TDLMargenBVentas.QueryVentas;
begin
  with qrySalidas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl empresa, producto_sl producto, cliente_sl cliente, ');

    SQL.Add('        case when substr( cliente_sal_sc, 1, 1 ) <> ''0'' and  cliente_sal_sc not in (''RET'',''REA'',''REP'',''GAN'',''EG'',''BAA'') ');
    SQL.Add('             then 1 else 0 end facturable, ');

    SQL.Add('        ( select producto_base_p ');
    SQL.Add('          from frf_productos ');
    SQL.Add('          where producto_p = producto_sl ) producto_base, ');
    SQL.Add('       centro_salida_sl, envase_sl, n_albaran_sl, fecha_sl, ');  // -->> Para los costes
    SQL.Add('       case when ref_transitos_sl is null then 0 else 1 end es_transito, ');
    SQL.Add('       sum( kilos_sl ) peso, sum( cajas_sl ) cajas, ');
    SQL.Add('       sum( unidades_caja_sl * cajas_sl ) unidades, ');

    if gCostesAplicar.bImporteVenta then
    begin
      SQL.Add('       SUM(  NVL(euros( moneda_sc, fecha_sc, importe_neto_sl ),0) ) importe, ');

      SQL.Add('       SUM(  Round( NVL(euros( moneda_sc, fecha_sc, importe_neto_sl ),0)* ');
      SQL.Add('             ((GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100)) , 2) ) comision, ');

      SQL.Add('       SUM(  Round( NVL(euros( moneda_sc, fecha_sc, importe_neto_sl ),0)* ');
      SQL.Add('             (1-(GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100))* ');
      SQL.Add('             ((GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 1 )/100)), 2) ) descuentos_fac, ');

      SQL.Add('       SUM(  Round( NVL(euros( moneda_sc, fecha_sc, importe_neto_sl ),0)* ');
      SQL.Add('             (1-(GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100))* ');
      SQL.Add('             ((GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 2 )/100)), 2) ) descuentos_nofac, ');

      SQL.Add('       SUM(  Round( NVL(euros( moneda_sc, fecha_sc, importe_neto_sl ),0)* ');
      SQL.Add('             (1-(GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc )/100))* ');
      SQL.Add('             (1-(GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 0 )/100)), 2) ) neto ');
    end
    else
    begin
      SQL.Add('       0 importe, ');
      SQL.Add('       0 comision, ');
      SQL.Add('       0 descuentos_fac, ');
      SQL.Add('       0 descuentos_nofac, ');
      SQL.Add('       0 neto ');
    end;

    SQL.Add(' from frf_salidas_c  ');
    SQL.Add('       join frf_salidas_l on empresa_sl = empresa_sc and centro_salida_sl = centro_salida_sc  ');
    SQL.Add('                          and fecha_sl = fecha_sc and n_albaran_sl = n_albaran_sc  ');
    SQL.Add('  where empresa_sc = :empresa ');
    SQL.Add('  and fecha_sc between :fechaini and :fechafin ');

    if sgCliente <> '' then
      SQL.Add('  and cliente_sal_sc = :cliente ');

    if sgProducto <> '' then
      SQL.Add('  and producto_sl = :producto ');

    SQL.Add(' group by empresa, producto, cliente, facturable, producto_base, centro_salida_sl, envase_sl, n_albaran_sl, fecha_sl, es_transito ');
    SQL.Add(' order by empresa, producto, cliente ');
  end;
end;

procedure TDLMargenBVentas.MakeMasterDetail;
begin
  kmtVentas.First;
  kmtVentasClientes.First;
  kmtVentasClientes.MasterSource:= dsVentas;
  kmtVentasClientes.MasterFields:= 'producto';
  kmtVentasClientes.IndexFieldNames:= 'producto';
end;

procedure TDLMargenBVentas.CosteEnvasado( const APlanta, ACentro, AEnvase, AProducto: string; const AProductoBase: integer;
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

function TDLMargenBVentas.CosteFinanciero( const APlanta, ACentro: string; const AFecha: TDateTime ): real;
begin
  if kmtCostesEstructura.Locate('planta;centro;fecha', VarArrayOf([APlanta, ACentro, AFecha ]),[] ) then
  begin
    Result:= kmtCostesEstructura.FieldByname('estructura').AsFloat;
  end
  else
  begin
    with qryCostesEstructura do
    begin
      ParamByName('empresa').AsString:= APlanta;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('fecha').AsDate:= AFecha;

      Open;
      Result:= FieldByName('estructura').AsFloat;
      Close;

      kmtCostesEstructura.Insert;
      kmtCostesEstructura.FieldByname('planta').AsString:= APlanta;
      kmtCostesEstructura.FieldByname('centro').AsString:= ACentro;
      kmtCostesEstructura.FieldByname('fecha').AsDateTime:= AFecha;
      kmtCostesEstructura.FieldByname('estructura').AsFloat:= Result;
      kmtCostesEstructura.Post;
    end;
  end;
end;


function TDLMargenBVentas.GastoVenta( const AEmpresa, ACentro: string; const AAlbaran: Integer; const AFecha: TDateTime;
                                      const AProducto: string; const AKilos: Real; const ATransito: Boolean ): real;
var
  rTotal, rProducto, rTotalTran, rProductoTran: real;
begin
  if kmtGastosAlbaran.Locate('empresa;centro;fecha;albaran;producto',
                              VarArrayOf([AEmpresa,ACentro, AFecha, AAlbaran,AProducto]),[] ) then
  begin
    rTotal:= kmtGastosAlbaran.FieldByName('eur_kg_total').AsFloat;
    rProducto:= kmtGastosAlbaran.FieldByName('eur_kg_producto').AsFloat;
    if ATransito then
    begin
      rTotalTran:= kmtGastosAlbaran.FieldByName('eur_kg_total_tran').AsFloat;
      rProductoTran:= kmtGastosAlbaran.FieldByName('eur_kg_producto_tran').AsFloat;
    end
    else
    begin
      rTotalTran:= 0;
      rProductoTran:= 0;
    end;
  end
  else
  begin
    qryGastosAlbaran.ParamByName('empresa').AsString:= AEmpresa;
    qryGastosAlbaran.ParamByName('centro').AsString:= ACentro;
    qryGastosAlbaran.ParamByName('fecha').AsDateTime:= AFecha;
    qryGastosAlbaran.ParamByName('albaran').AsInteger:= AAlbaran;
    qryGastosAlbaran.ParamByName('producto').AsString:= AProducto;
    qryGastosAlbaran.Open;
    if not qryGastosAlbaran.IsEmpty then
    begin
       rTotal:= qryGastosAlbaran.FieldByName('total').AsFloat;
       rProducto:= qryGastosAlbaran.FieldByName('producto').AsFloat;
       rTotalTran:= qryGastosAlbaran.FieldByName('total_tran').AsFloat;
       rProductoTran:= qryGastosAlbaran.FieldByName('producto_tran').AsFloat;
       qryGastosAlbaran.Close;


       qryKilosALbaran.ParamByName('empresa').AsString:= AEmpresa;
       qryKilosALbaran.ParamByName('centro').AsString:= ACentro;
       qryKilosALbaran.ParamByName('fecha').AsDateTime:= AFecha;
       qryKilosALbaran.ParamByName('albaran').AsInteger:= AAlbaran;
       qryKilosALbaran.ParamByName('producto').AsString:= AProducto;
       qryKilosALbaran.Open;
       if qryKilosALbaran.FieldByName('kilos_total').AsFloat > 0 then
         rTotal:= bRoundTo( rTotal / qryKilosALbaran.FieldByName('kilos_total').AsFloat, 5 )
       else
         rTotal:= 0;
       if qryKilosALbaran.FieldByName('kilos_producto').AsFloat > 0 then
         rProducto:= bRoundTo( rProducto / qryKilosALbaran.FieldByName('kilos_producto').AsFloat, 5 )
       else
         rProducto:= 0;
       if qryKilosALbaran.FieldByName('kilos_total_tran').AsFloat > 0 then
         rTotalTran:= bRoundTo( rTotalTran / qryKilosALbaran.FieldByName('kilos_total_tran').AsFloat, 5 )
       else
         rTotalTran:= 0;
       if qryKilosALbaran.FieldByName('kilos_producto_tran').AsFloat > 0 then
         rProductoTran:= bRoundTo( rProductoTran / qryKilosALbaran.FieldByName('kilos_producto_tran').AsFloat, 5 )
       else
         rProductoTran:= 0;
       qryKilosALbaran.Close;
    end
    else
    begin
      qryGastosAlbaran.Close;
      rTotal:= 0;
      rProducto:= 0;
      rTotalTran:= 0;
      rProductoTran:= 0;
    end;
    kmtGastosAlbaran.Insert;
    kmtGastosAlbaran.FieldByName('empresa').AsString:= AEmpresa;
    kmtGastosAlbaran.FieldByName('centro').AsString:= ACentro;
    kmtGastosAlbaran.FieldByName('fecha').AsDateTime:= AFecha;
    kmtGastosAlbaran.FieldByName('albaran').AsInteger:= AAlbaran;
    kmtGastosAlbaran.FieldByName('producto').AsString:= AProducto;

    kmtGastosAlbaran.FieldByName('eur_kg_total').AsFloat:= rTotal;
    kmtGastosAlbaran.FieldByName('eur_kg_producto').AsFloat:= rProducto;
    kmtGastosAlbaran.FieldByName('eur_kg_total_tran').AsFloat:= rTotalTran;
    kmtGastosAlbaran.FieldByName('eur_kg_producto_tran').AsFloat:= rProductoTran;
    kmtGastosAlbaran.Post;

    if not ATransito then
    begin
      rTotalTran:= 0;
      rProductoTran:= 0;
    end;
  end;
  Result:= bRoundTo( ( rTotal + rProducto + rTotalTran + rProductoTran ) * AKilos, 2 );
end;

function TDLMargenBVentas.ProductosVendidos: boolean;
var
  rMaterial, rPersonal, rGeneral: real;
  rPrecioFinanciero, rImporteFinanciero: real;
  rGastoVenta: Real;
begin
  with qrySalidas do
  begin
    ParamByName('empresa').AsString:= sgEmpresa;
    ParamByName('fechaini').AsdateTime:= dgFechaIni;
    ParamByName('fechafin').AsdateTime:= dgFechaFin;
    if sgProducto <> '' then
      ParamByName('producto').AsString:= sgProducto;
    if sgCliente <> '' then
      ParamByName('cliente').AsString:= sgCliente;
    Open;

    while not eof do
    begin

      if gCostesAplicar.bFinanciero then
        rPrecioFinanciero:= CosteFinanciero( FieldByName('empresa').AsString, FieldByName('centro_salida_sl').AsString, FieldByName('fecha_sl').AsDateTime )
      else
        rPrecioFinanciero:= 0;

      if gCostesAplicar.bGastosVenta then
      begin
        rGastoVenta:= GastoVenta( FieldByName('empresa').AsString, FieldByName('centro_salida_sl').AsString,
                                  FieldByName('n_albaran_sl').AsInteger, FieldByName('fecha_sl').AsDateTime,
                                  FieldByName('producto').AsString, FieldByName('peso').AsFloat,
                                  FieldByName('es_transito').AsInteger = 1 );
      end
      else
      begin
        rGastoVenta:= 0;
      end;

      if gCostesAplicar.bMaterial or  gCostesAplicar.bPersonal or gCostesAplicar.bGeneral then
      begin
        CosteEnvasado( FieldByName('empresa').AsString,
                     FieldByName('centro_salida_sl').AsString ,
                     FieldByName('envase_sl').AsString,
                     FieldByName('producto').AsString,
                     FieldByName('producto_base').AsInteger,
                     FieldByName('fecha_sl').AsDateTime,
                     rMaterial, rPersonal, rGeneral );

        if gCostesAplicar.bMaterial then
          rMaterial:= bRoundTo( rMaterial * FieldByName('peso').AsFloat, 2)
        else
          rMaterial:= 0;
        if gCostesAplicar.bPersonal then
          rPersonal:= bRoundTo( rPersonal * FieldByName('peso').AsFloat, 2)
        else
          rPersonal:= 0;
        if gCostesAplicar.bGeneral then
          rGeneral:= bRoundTo( rGeneral * FieldByName('peso').AsFloat, 2)
        else
          rGeneral:= 0;
      end
      else
      begin
        rMaterial:= 0;
        rPersonal:= 0;
        rGeneral:= 0;
      end;

      rImporteFinanciero:= bRoundTo( rPrecioFinanciero * FieldByName('peso').AsFloat, 2);

      if not kmtVentasClientes.Locate('producto;cliente', VarArrayOf([FieldByName('producto').AsString, FieldByName('cliente').AsString]),[] ) then
      begin
        kmtVentasClientes.Insert;
        //InicializarValoresResumen;
        kmtVentasClientes.FieldByName('empresa').AsString:= FieldByName('empresa').AsString;
        kmtVentasClientes.FieldByName('periodo').AsString:= 'PERIODO';
        kmtVentasClientes.FieldByName('cliente').AsString:= FieldByName('cliente').AsString;
        kmtVentasClientes.FieldByName('producto').AsString:= FieldByName('producto').AsString;
        kmtVentasClientes.FieldByName('producto_base').AsString:= FieldByName('producto_base').AsString;
        kmtVentasClientes.FieldByName('facturable').AsInteger:= FieldByName('facturable').AsInteger;

        kmtVentasClientes.FieldByName('peso_albaran').AsFloat:= FieldByName('peso').AsFloat;
        kmtVentasClientes.FieldByName('cajas_albaran').AsFloat:= FieldByName('cajas').AsFloat;
        kmtVentasClientes.FieldByName('unidades_albaran').AsFloat:= FieldByName('unidades').AsFloat;

        kmtVentasClientes.FieldByName('importe_albaran').AsFloat:= FieldByName('importe').AsFloat;
        kmtVentasClientes.FieldByName('descuentos_fac').AsFloat:= FieldByName('comision').AsFloat + FieldByName('descuentos_fac').AsFloat;
        kmtVentasClientes.FieldByName('descuentos_nofac').AsFloat:= FieldByName('descuentos_nofac').AsFloat;
        kmtVentasClientes.FieldByName('importe_abonos').AsFloat:= 0;

        kmtVentasClientes.FieldByName('coste_venta').AsFloat:= rGastoVenta;
        kmtVentasClientes.FieldByName('coste_material').AsFloat:= rMaterial;
        kmtVentasClientes.FieldByName('coste_personal').AsFloat:= rPersonal;
        kmtVentasClientes.FieldByName('coste_general').AsFloat:= rGeneral;
        kmtVentasClientes.FieldByName('coste_financiero').AsFloat:= rImporteFinanciero;

        kmtVentasClientes.Post;
      end
      else
      begin
        kmtVentasClientes.Edit;
        kmtVentasClientes.FieldByName('peso_albaran').AsFloat:= kmtVentasClientes.FieldByName('peso_albaran').AsFloat + FieldByName('peso').AsFloat;
        kmtVentasClientes.FieldByName('cajas_albaran').AsFloat:= kmtVentasClientes.FieldByName('cajas_albaran').AsFloat + FieldByName('cajas').AsFloat;;
        kmtVentasClientes.FieldByName('unidades_albaran').AsFloat:= kmtVentasClientes.FieldByName('unidades_albaran').AsFloat + FieldByName('unidades').AsFloat;

        kmtVentasClientes.FieldByName('importe_albaran').AsFloat:= kmtVentasClientes.FieldByName('importe_albaran').AsFloat + FieldByName('importe').AsFloat;
        kmtVentasClientes.FieldByName('descuentos_fac').AsFloat:= kmtVentasClientes.FieldByName('descuentos_fac').AsFloat +
                                                              FieldByName('comision').AsFloat + FieldByName('descuentos_fac').AsFloat;
        kmtVentasClientes.FieldByName('descuentos_nofac').AsFloat:= kmtVentasClientes.FieldByName('descuentos_nofac').AsFloat + FieldByName('descuentos_nofac').AsFloat;
        kmtVentasClientes.FieldByName('coste_venta').AsFloat:= rGastoVenta + kmtVentasClientes.FieldByName('coste_venta').AsFloat;
        kmtVentasClientes.FieldByName('coste_material').AsFloat:= rMaterial + kmtVentasClientes.FieldByName('coste_material').AsFloat;
        kmtVentasClientes.FieldByName('coste_personal').AsFloat:= rPersonal + kmtVentasClientes.FieldByName('coste_personal').AsFloat;
        kmtVentasClientes.FieldByName('coste_general').AsFloat:= rGeneral + kmtVentasClientes.FieldByName('coste_general').AsFloat;
        kmtVentasClientes.FieldByName('coste_financiero').AsFloat:= rImporteFinanciero + kmtVentasClientes.FieldByName('coste_financiero').AsFloat;
        kmtVentasClientes.Post;
      end;
      Next;
    end;
    Close;
  end;
  result:= not kmtVentasClientes.IsEmpty;

  if Result then
  begin
    kmtVentasClientes.SortFields:= 'producto;cliente';
    kmtVentasClientes.Sort([]);
    kmtVentasClientes.First;
    if gCostesAplicar.bImporteAbonos then
      PutImporteAbonos;
    PutResumen;
  end;
end;


procedure TDLMargenBVentas.PutResumen;
var
  sProducto: string;
  iCajas, iUnidades: Integer;
  rKilos, rimporte_albaran, rdescuentosFac, rdescuentosNoFac, rimporte_abonos, rcoste_venta, rcoste_material, rcoste_personal, rcoste_general, rcoste_financiero: Real;
  rKilosNo: Real;
  iCajasNo, iUnidadesNo: Integer;
begin
  kmtVentasClientes.First;
  //kmtVentasClientes.Next;
  while not  kmtVentasClientes.Eof do
  begin
    AddLineaResumen;
    kmtVentasClientes.Next;
  end;
  kmtVentasClientes.First;
  kmtVentas.First;
end;

procedure TDLMargenBVentas.AddLineaResumen;
begin
  if kmtVentas.Locate('empresa;periodo;producto', //cliente
                              VarArrayOf([kmtVentasClientes.FieldByName('empresa').AsString,
                                          kmtVentasClientes.FieldByName('periodo').AsString,
                                          kmtVentasClientes.FieldByName('producto').AsString]),[] ) then
  begin
    ModLineaResumen;
  end
  else
  begin
    NewLineaResumen;
  end;
end;

procedure TDLMargenBVentas.NewLineaResumen;
begin
      kmtVentas.Insert;
      kmtVentas.FieldByName('empresa').AsString:= kmtVentasClientes.FieldByName('empresa').AsString;
      kmtVentas.FieldByName('periodo').AsString:= kmtVentasClientes.FieldByName('periodo').AsString;
      kmtVentas.FieldByName('producto').AsString:= kmtVentasClientes.FieldByName('producto').AsString;
      kmtVentas.FieldByName('cliente').AsString:= '';//kmtVentasClientes.FieldByName('cliente').AsString;

      if kmtVentasClientes.FieldByName('facturable').AsInteger = 1 then
      begin
        kmtVentas.FieldByName('cajas_albaran').AsInteger:= kmtVentasClientes.FieldByName('cajas_albaran').AsInteger;
        kmtVentas.FieldByName('unidades_albaran').AsInteger:= kmtVentasClientes.FieldByName('unidades_albaran').AsInteger;
        kmtVentas.FieldByName('peso_albaran').AsFloat:= kmtVentasClientes.FieldByName('peso_albaran').AsFloat;

        kmtVentas.FieldByName('importe_albaran').AsFloat:= kmtVentasClientes.FieldByName('importe_albaran').AsFloat;
        kmtVentas.FieldByName('descuentos_fac').AsFloat:= kmtVentasClientes.FieldByName('descuentos_fac').AsFloat;
        kmtVentas.FieldByName('descuentos_nofac').AsFloat:= kmtVentasClientes.FieldByName('descuentos_nofac').AsFloat;
        kmtVentas.FieldByName('importe_abonos').AsFloat:= kmtVentasClientes.FieldByName('importe_abonos').AsFloat;
        kmtVentas.FieldByName('coste_venta').AsFloat:= kmtVentasClientes.FieldByName('coste_venta').AsFloat;


        kmtVentas.FieldByName('cajas_no_facturables').AsInteger:= 0;
        kmtVentas.FieldByName('unidades_no_facturables').AsInteger:= 0;
        kmtVentas.FieldByName('peso_no_facturables').AsFloat:= 0;
      end
      else
      begin
        kmtVentas.FieldByName('cajas_albaran').AsInteger:= 0;
        kmtVentas.FieldByName('unidades_albaran').AsInteger:= 0;
        kmtVentas.FieldByName('peso_albaran').AsFloat:= 0;

        kmtVentas.FieldByName('importe_albaran').AsFloat:= 0;
        kmtVentas.FieldByName('descuentos_fac').AsFloat:= 0;
        kmtVentas.FieldByName('descuentos_nofac').AsFloat:= 0;
        kmtVentas.FieldByName('importe_abonos').AsFloat:= 0;
        kmtVentas.FieldByName('coste_venta').AsFloat:= 0;


        kmtVentas.FieldByName('cajas_no_facturables').AsInteger:= kmtVentasClientes.FieldByName('cajas_albaran').AsInteger;
        kmtVentas.FieldByName('unidades_no_facturables').AsInteger:= kmtVentasClientes.FieldByName('unidades_albaran').AsInteger;
        kmtVentas.FieldByName('peso_no_facturables').AsFloat:= kmtVentasClientes.FieldByName('peso_albaran').AsFloat;
      end;

      kmtVentas.FieldByName('coste_material').AsFloat:= kmtVentasClientes.FieldByName('coste_material').AsFloat;
      kmtVentas.FieldByName('coste_personal').AsFloat:= kmtVentasClientes.FieldByName('coste_personal').AsFloat;
      kmtVentas.FieldByName('coste_general').AsFloat:= kmtVentasClientes.FieldByName('coste_general').AsFloat;
      kmtVentas.FieldByName('coste_financiero').AsFloat:= kmtVentasClientes.FieldByName('coste_financiero').AsFloat;

      kmtVentas.Post;
end;

procedure TDLMargenBVentas.ModLineaResumen;
begin
      kmtVentas.Edit;

      if kmtVentasClientes.FieldByName('facturable').AsInteger = 1 then
      begin
        kmtVentas.FieldByName('cajas_albaran').AsInteger:= kmtVentas.FieldByName('cajas_albaran').AsInteger + kmtVentasClientes.FieldByName('cajas_albaran').AsInteger;
        kmtVentas.FieldByName('unidades_albaran').AsInteger:= kmtVentas.FieldByName('unidades_albaran').AsInteger + kmtVentasClientes.FieldByName('unidades_albaran').AsInteger;
        kmtVentas.FieldByName('peso_albaran').AsFloat:= kmtVentas.FieldByName('peso_albaran').AsFloat + kmtVentasClientes.FieldByName('peso_albaran').AsFloat;

        kmtVentas.FieldByName('importe_albaran').AsFloat:= kmtVentas.FieldByName('importe_albaran').AsFloat + kmtVentasClientes.FieldByName('importe_albaran').AsFloat;
        kmtVentas.FieldByName('descuentos_fac').AsFloat:= kmtVentas.FieldByName('descuentos_fac').AsFloat + kmtVentasClientes.FieldByName('descuentos_fac').AsFloat;
        kmtVentas.FieldByName('descuentos_nofac').AsFloat:= kmtVentas.FieldByName('descuentos_nofac').AsFloat + kmtVentasClientes.FieldByName('descuentos_nofac').AsFloat;
        kmtVentas.FieldByName('importe_abonos').AsFloat:= kmtVentas.FieldByName('importe_abonos').AsFloat + kmtVentasClientes.FieldByName('importe_abonos').AsFloat;
        kmtVentas.FieldByName('coste_venta').AsFloat:= kmtVentas.FieldByName('coste_venta').AsFloat + kmtVentasClientes.FieldByName('coste_venta').AsFloat;
      end
      else
      begin
        kmtVentas.FieldByName('cajas_no_facturables').AsInteger:= kmtVentas.FieldByName('cajas_no_facturables').AsInteger + kmtVentasClientes.FieldByName('cajas_albaran').AsInteger;
        kmtVentas.FieldByName('unidades_no_facturables').AsInteger:= kmtVentas.FieldByName('unidades_no_facturables').AsInteger + kmtVentasClientes.FieldByName('unidades_albaran').AsInteger;
        kmtVentas.FieldByName('peso_no_facturables').AsFloat:= kmtVentas.FieldByName('peso_no_facturables').AsFloat + kmtVentasClientes.FieldByName('peso_albaran').AsFloat;
      end;

      kmtVentas.FieldByName('coste_material').AsFloat:= kmtVentas.FieldByName('coste_material').AsFloat + kmtVentasClientes.FieldByName('coste_material').AsFloat;
      kmtVentas.FieldByName('coste_personal').AsFloat:= kmtVentas.FieldByName('coste_personal').AsFloat + kmtVentasClientes.FieldByName('coste_personal').AsFloat;
      kmtVentas.FieldByName('coste_general').AsFloat:= kmtVentas.FieldByName('coste_general').AsFloat + kmtVentasClientes.FieldByName('coste_general').AsFloat;
      kmtVentas.FieldByName('coste_financiero').AsFloat:= kmtVentas.FieldByName('coste_financiero').AsFloat + kmtVentasClientes.FieldByName('coste_financiero').AsFloat;

      kmtVentas.Post;
end;

procedure TDLMargenBVentas.PutImporteAbonos;
begin
  while not  kmtVentasClientes.Eof do
  begin
    kmtVentasClientes.Edit;
    kmtVentasClientes.FieldByName('importe_abonos').AsFloat:=
      ImporteAbonos( kmtVentasClientes.FieldByName('empresa').AsString,
                     kmtVentasClientes.FieldByName('producto').AsString,
                     kmtVentasClientes.FieldByName('cliente').AsString, dgFechaIni, dgFechaFin ) * -1;
    kmtVentasClientes.Post;
    kmtVentasClientes.Next;
  end;
  kmtVentasClientes.First;
end;

function TDLMargenBVentas.ImporteAbonos( const AEmpresa, AProducto, ACliente: string;
                                         const AFechaIni, AFechaFin: TDateTime ): Real;
begin
  with qryAbonos do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('fechai').AsDate:= AFechaIni;
    ParamByName('fecha_fin').AsDate:= AFechaFin;

    Open;
    result:= FieldByName('importe').AsFloat;
    Close;
  end;
end;


end.
