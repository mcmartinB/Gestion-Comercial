unit PreciosFOBVentaDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLPreciosFOBVenta = class(TDataModule)
    QDatosAlbaran: TQuery;
    mtDatosAlbaran: TkbmMemTable;
    mtDatosAlbaranProducto: TkbmMemTable;
    mtDescuentos: TkbmMemTable;
    QClienteFac: TQuery;
    QDescuento: TQuery;
    QComision: TQuery;
    QGastosAlbaran: TQuery;
    QAbonosAlbaran: TQuery;
    QCosteEnvase: TQuery;
    mtSecciones: TkbmMemTable;
    mtCosteEnvase: TkbmMemTable;
    QCosteEnvaseLosLLanos: TQuery;
    QCosteIndirecto: TQuery;
    QCambio: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    bAplicarDescuento, bAplicarGastosSalidas, bAplicarGastosTransitos, bAplicarAbonos,
    bAplicarCosteEnvasado, bAplicarCosteSecciones, bAplicarCosteIndirecto: boolean;
    bSoloGastosFacturables: boolean;

    procedure CrearTablaEnMemoria;
    procedure BorrarTablaEnMemoria;

    function  ResumenAlbaran( const AEmpresa, ACentro: string;
                              const AAlbaran: integer; const AFecha: TDateTime ): boolean;

    procedure DescuentosComisionesYCambio( const ADescuento, AComision: boolean );
    procedure GastosAlbaran;
    procedure PreparaQueryGastosAlbaran;
    procedure AplicarGastos;
    procedure DistribuirPorPalets;
    procedure DistribuirPorCajas;
    procedure DistribuirPorKilos;
    procedure DistribuirPorImporte;
    procedure AbonosAlbaran;
    procedure AplicarAbonos;
    procedure CosteEnvasado( const AEnvasado, ASecciones: boolean );
    procedure GetCosteEnvasado( var VEnvasado, VSecciones: Real );
    procedure GetCosteEnvasadoLosLLanos( var VEnvasado, VSecciones: Real );
    //procedure CosteSecciones;
    //function  GetCosteSecciones: real;
    procedure CosteIndirecto;
    function  GetCosteIndirecto: real;

  public
    { Public declarations }
    procedure ConfigFOB( const AAplicarDescuento, AAplicarGastosSalidas, AAplicarGastosTransitos,
                               ASoloGastosFacturables, AAplicarAbonos, AAplicarCosteEnvasado,
                               AAplicarCosteSecciones, AAplicarCosteIndirecto: boolean );
    function  PreciosFob( const AEmpresa, ACentro: string;
                          const AAlbaran: integer;
                          const AFecha: TDateTime ): boolean;

    function GetFobCalibre( const AEmpresa, ACentro: string; const AAlbaran: integer;
               const AFecha: TDateTime; const AProducto, AEnvase, ACalibre: string;
               var AKilos, AImporte, AComision, ADescuento, AGastos, AEnvasado,
                   ASecciones, AAbonos, AFob: real ): Boolean;

  end;

var
  DLPreciosFOBVenta: TDLPreciosFOBVenta;

implementation

{$R *.dfm}

uses
  variants, bMath, dialogs, dateUtils;

procedure TDLPreciosFOBVenta.DataModuleCreate(Sender: TObject);
begin
  bAplicarDescuento:= False;
  bAplicarGastosSalidas:= False;
  bAplicarGastosTransitos:= False;
  bSoloGastosFacturables:= False;
  bAplicarAbonos:= False;
  bAplicarCosteEnvasado:= False;
  bAplicarCosteSecciones:= False;
  bAplicarCosteIndirecto:= False;

  with QDatosAlbaran do
  begin
    SQL.Clear;
    SQL.Add(' select producto_sl, envase_sl, categoria_sl, calibre_sl, ');
    SQL.Add('        emp_procedencia_sl, centro_origen_sl, ');
    SQL.Add('        sum(n_palets_sl) palets_sl, sum(cajas_sl) cajas_sl, ');
    SQL.Add('        sum(kilos_sl) kilos_sl, sum(importe_neto_sl) importe_neto_sl ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and n_albaran_sl = :albaran ');
    SQL.Add(' and fecha_sl = :fecha ');
    SQL.Add(' group by producto_sl, envase_sl, categoria_sl, calibre_sl, ');
    SQL.Add('          emp_procedencia_sl, centro_origen_sl ');
    SQL.Add(' order by producto_sl, envase_sl, categoria_sl, calibre_sl, ');
    SQL.Add('          emp_procedencia_sl, centro_origen_sl ');
    Prepare;
  end;

  with QClienteFac do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_c, representante_c, pais_c, moneda_sc ');
    SQL.Add(' from frf_salidas_c, frf_clientes ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');
    SQL.Add(' and cliente_c = cliente_fac_sc ');
    Prepare;
  end;

  with QCambio do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 nvl(cambio_ce,1) cambio');
    SQL.Add(' from frf_cambios_euros ');
    SQL.Add(' where moneda_ce = :moneda ');
    SQL.Add(' and fecha_ce <= :fecha ');
    SQL.Add(' order by fecha_ce desc ');
    Prepare;
  end;

  with QDescuento do
  begin
    SQL.Clear;
    SQL.Add(' select ( no_fact_bruto_dc + facturable_dc ) descuento, fecha_ini_dc fecha_ini, ');
    SQL.Add('         nvl(fecha_fin_dc, today) fecha_fin  ');
    SQL.Add(' from frf_descuentos_cliente  ');
    SQL.Add(' where empresa_dc = :empresa  ');
    SQL.Add(' and cliente_dc = :cliente  ');
    SQL.Add(' order by fecha_ini_dc ');
    Prepare;
  end;

  with QComision do
  begin
    SQL.Clear;
    SQL.Add(' select comision_rc comision, fecha_ini_rc fecha_ini, nvl(fecha_fin_rc, today) fecha_fin');
    SQL.Add(' from frf_representantes_comision ');
    SQL.Add(' where representante_rc = :representante ');
    SQL.Add(' order by fecha_ini_rc ');
    Prepare;
  end;

  with QGastosAlbaran do
  begin
    SQL.Clear;
    SQL.Add(' select producto_g producto, case when nvl(gasto_transito_tg,0) = 1  then 1 else 0 end transito, unidad_dist_tg unidad, ');
    SQL.Add('        sum( case when nvl(facturable_tg, ''N'') = ''N'' then importe_g else importe_g * -1 end ) importe ');
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');
    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add(' and centro_salida_g = :centro ');
    SQL.Add(' and n_albaran_g = :albaran ');
    SQL.Add(' and fecha_g = :fecha ');
    SQL.Add(' and tipo_tg = tipo_g ');
    SQL.Add(' group by 1,2,3 ');
    Prepare;
  end;

  with QAbonosAlbaran do
  begin
    SQL.Clear;
    SQL.Add(' select producto_fal producto, sum(importe_fal) importe ');
    SQL.Add(' from frf_fac_abonos_l ');
    SQL.Add(' where empresa_fal = :empresa ');
    SQL.Add(' and n_albaran_fal = :albaran ');
    SQL.Add(' and fecha_albaran_fal = :fecha ');
    SQL.Add(' and centro_salida_fal = :centro ');
    SQL.Add(' group by producto_fal ');
    Prepare;
  end;

  with QCosteEnvase do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 nvl(( material_ec + coste_ec ),0) coste, nvl(secciones_ec,0) secciones');
    SQL.Add(' from frf_env_costes ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_Ec = :centro ');
    SQL.Add(' and producto_ec = :producto ');
    SQL.Add(' and envase_ec = :envase ');
    SQL.Add(' and ( ( anyo_ec = year( :fecha ) and ');
    SQL.Add('         mes_ec <= Month( :fecha ) ) or ');
    SQL.Add('       ( anyo_ec < year( :fecha ) ) ) ');
    SQL.Add(' order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;

  (*TODO*)
  with QCosteEnvaseLosLLanos do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 nvl(( material_ec + coste_ec ),0) coste, nvl(secciones_ec,0) secciones');
    SQL.Add(' from frf_env_costes ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_ec = ''1'' ');
    SQL.Add(' and producto_ec = :producto ');
    SQL.Add(' and envase_ec = :envase ');
    SQL.Add(' and ( ( anyo_ec = year( :fecha ) and ');
    SQL.Add('         mes_ec <= Month( :fecha ) ) or ');
    SQL.Add('       ( anyo_ec < year( :fecha ) ) ) ');
    SQL.Add(' order by anyo_ec desc, mes_ec desc ');
    Prepare;
  end;

  with QCosteIndirecto do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(comercial_ci,0) + nvl(produccion_ci,0) + nvl(administracion_ci,0) coste_indirecto ');
    SQL.Add(' from frf_costes_indirectos ');
    SQL.Add(' where empresa_ci = :empresa ');
    SQL.Add(' and centro_origen_ci = :centro ');
    SQL.Add(' and :fecha between fecha_ini_ci and nvl(fecha_fin_ci, today + 30 ) ');
    Prepare;
  end;

  CrearTablaEnMemoria;
end;


procedure TDLPreciosFOBVenta.DataModuleDestroy(Sender: TObject);
begin
  BorrarTablaEnMemoria;

  QCosteIndirecto.Close;
  if QCosteIndirecto.Prepared then
    QCosteIndirecto.UnPrepare;

(*
  QCosteSecciones.Close;
  if QCosteSecciones.Prepared then
    QCosteSecciones.UnPrepare;
*)

  QCosteEnvaseLosLLanos.Close;
  if QCosteEnvaseLosLLanos.Prepared then
    QCosteEnvaseLosLLanos.UnPrepare;

  QCosteEnvase.Close;
  if QCosteEnvase.Prepared then
    QCosteEnvase.UnPrepare;

  QAbonosAlbaran.Close;
  if QAbonosAlbaran.Prepared then
    QAbonosAlbaran.UnPrepare;

  QGastosAlbaran.Close;
  if QGastosAlbaran.Prepared then
    QGastosAlbaran.UnPrepare;

  QComision.Close;
  if QComision.Prepared then
    QComision.UnPrepare;

  QDescuento.Close;
  if QDescuento.Prepared then
    QDescuento.UnPrepare;

  QCambio.Close;
  if QCambio.Prepared then
    QCambio.UnPrepare;

  QClienteFac.Close;
  if QClienteFac.Prepared then
    QClienteFac.UnPrepare;

  QDatosAlbaran.Close;
  if QDatosAlbaran.Prepared then
    QDatosAlbaran.UnPrepare;
end;

procedure TDLPreciosFOBVenta.CrearTablaEnMemoria;
begin
  mtDescuentos.FieldDefs.Clear;
  mtDescuentos.FieldDefs.Add('empresa', ftString, 3, False);
  mtDescuentos.FieldDefs.Add('cliente', ftString, 1, False);
  mtDescuentos.FieldDefs.Add('fecha_ini', ftInteger, 0, False);
  mtDescuentos.FieldDefs.Add('fecha_fin', ftInteger, 0, False);
  mtDescuentos.FieldDefs.Add('descuento', ftDate, 0, False);
  mtDescuentos.FieldDefs.Add('comision', ftDate, 0, False);
  mtDescuentos.CreateTable;
  mtDescuentos.IndexFieldNames:= 'cliente;fecha_ini';
  mtDescuentos.Filtered:= True;
  mtDescuentos.Open;

  mtDatosAlbaranProducto.FieldDefs.Clear;
  mtDatosAlbaranProducto.FieldDefs.Add('producto', ftString, 3, False);
  mtDatosAlbaranProducto.FieldDefs.Add('palets', ftInteger, 0, False);
  mtDatosAlbaranProducto.FieldDefs.Add('cajas', ftInteger, 0, False);
  mtDatosAlbaranProducto.FieldDefs.Add('kilos', ftFloat, 0, False);
  mtDatosAlbaranProducto.FieldDefs.Add('importe_neto', ftFloat, 0, False);
  //Datos provenientes de un transito
  mtDatosAlbaranProducto.FieldDefs.Add('tpalets', ftInteger, 0, False);
  mtDatosAlbaranProducto.FieldDefs.Add('tcajas', ftInteger, 0, False);
  mtDatosAlbaranProducto.FieldDefs.Add('tkilos', ftFloat, 0, False);
  mtDatosAlbaranProducto.FieldDefs.Add('timporte_neto', ftFloat, 0, False);
  mtDatosAlbaranProducto.CreateTable;
  mtDatosAlbaranProducto.IndexFieldNames:= 'producto';
  mtDatosAlbaranProducto.Open;

  mtDatosAlbaran.FieldDefs.Clear;
  mtDatosAlbaran.FieldDefs.Add('empresa', ftString, 3, False);
  mtDatosAlbaran.FieldDefs.Add('centro', ftString, 1, False);
  mtDatosAlbaran.FieldDefs.Add('albaran', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('fecha', ftDate, 0, False);
  mtDatosAlbaran.FieldDefs.Add('anyosem', ftString, 6, False);
  mtDatosAlbaran.FieldDefs.Add('anyomes', ftString, 6, False);
  mtDatosAlbaran.FieldDefs.Add('anyo', ftString, 4, False);
  mtDatosAlbaran.FieldDefs.Add('producto', ftString, 3, False);
  mtDatosAlbaran.FieldDefs.Add('envase', ftString, 9, False);
  mtDatosAlbaran.FieldDefs.Add('categoria', ftString, 2, False);
  mtDatosAlbaran.FieldDefs.Add('calibre', ftString, 6, False);
  mtDatosAlbaran.FieldDefs.Add('cliente_fac', ftString, 3, False);
  mtDatosAlbaran.FieldDefs.Add('pais', ftString, 3, False);
  mtDatosAlbaran.FieldDefs.Add('moneda', ftString, 3, False);
  mtDatosAlbaran.FieldDefs.Add('cambio', ftFloat, 0, False);

  mtDatosAlbaran.FieldDefs.Add('palets', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('palets_producto', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('palets_albaran', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('cajas', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('cajas_producto', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('cajas_albaran', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('kilos', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('kilos_producto', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('kilos_albaran', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('importe_neto', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('importe_producto', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('importe_albaran', ftFloat, 0, False);

  mtDatosAlbaran.FieldDefs.Add('empresaOrigen', ftString, 3, False);
  mtDatosAlbaran.FieldDefs.Add('centroOrigen', ftString, 1, False);

  //Datos provenientes de transitos
  mtDatosAlbaran.FieldDefs.Add('tpalets', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('tpalets_producto', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('tpalets_albaran', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('tcajas', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('tcajas_producto', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('tcajas_albaran', ftInteger, 0, False);
  mtDatosAlbaran.FieldDefs.Add('tkilos', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('tkilos_producto', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('tkilos_albaran', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('timporte_neto', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('timporte_producto', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('timporte_albaran', ftFloat, 0, False);

  mtDatosAlbaran.FieldDefs.Add('importe_comision', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('importe_descuento', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('importe_gastos_salidas', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('importe_gastos_transitos', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('importe_envasado', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('importe_secciones', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('importe_indirecto', ftFloat, 0, False);
  mtDatosAlbaran.FieldDefs.Add('importe_abonos', ftFloat, 0, False);

  mtDatosAlbaran.CreateTable;
  mtDatosAlbaran.IndexFieldNames:= 'empresa;centro;albaran;fecha;producto;envase;categoria;calibre';
  mtDatosAlbaran.Open;
end;

procedure TDLPreciosFOBVenta.BorrarTablaEnMemoria;
begin
  mtDescuentos.Close;
  FreeAndNil( mtDescuentos );

  mtDatosAlbaranProducto.Close;
  FreeAndNil( mtDatosAlbaranProducto );

  mtDatosAlbaran.Close;
  FreeAndNil( mtDatosAlbaran );
end;

procedure TDLPreciosFOBVenta.ConfigFOB( const AAplicarDescuento, AAplicarGastosSalidas,
             AAplicarGastosTransitos, ASoloGastosFacturables, AAplicarAbonos, AAplicarCosteEnvasado,
             AAplicarCosteSecciones, AAplicarCosteIndirecto: boolean );
begin
  bAplicarDescuento:= AAplicarDescuento;
  bAplicarGastosSalidas:= AAplicarGastosSalidas;
  bAplicarGastosTransitos:= AAplicarGastosTransitos;
  bSoloGastosFacturables:= ASoloGastosFacturables;
  bAplicarAbonos:= AAplicarAbonos;
  bAplicarCosteEnvasado:= AAplicarCosteEnvasado;
  bAplicarCosteSecciones:= AAplicarCosteSecciones;
  //bSeccionesEnvase:= ASeccionesEnvase;
  bAplicarCosteIndirecto:= AAplicarCosteIndirecto;

  PreparaQueryGastosAlbaran;
end;

function TDLPreciosFOBVenta.PreciosFob( const AEmpresa, ACentro: string;
                              const AAlbaran: integer; const AFecha: TDateTime ): boolean;
begin
  result:= ResumenAlbaran( AEmpresa, ACentro, AAlbaran, AFecha );
  if result then
  begin
    //Descuentos y comisiones
    DescuentosComisionesYCambio( bAplicarDescuento, bAplicarDescuento );

    //Gastos albaran de salida y transitos
    if bAplicarGastosSalidas or bAplicarGastosTransitos then
      GastosAlbaran;

    //Abonos
    if bAplicarAbonos then
      AbonosAlbaran;

    //Coste envasado
    //bSeccionesEnvase -> nos indica de donde tenemos que sacar el coste de las secciones
    //                 -> FALSE: del mantenimiento de costes de secciones, cosechero grupo BONNYSA
    //                 -> TRUE : del mantenimiento de costes de envases
    if bAplicarCosteEnvasado or bAplicarCosteSecciones then
    begin
      CosteEnvasado( bAplicarCosteEnvasado, bAplicarCosteSecciones );
    end;
(*
    if bAplicarCosteSecciones and ( not bSeccionesEnvase ) then
    begin
      CosteSecciones;
    end;
*)
    //Costes indirectos liquidacion
    if bAplicarCosteIndirecto then
      CosteIndirecto;
  end;
end;

function TDLPreciosFOBVenta.ResumenAlbaran( const AEmpresa, ACentro: string;
                              const AAlbaran: integer; const AFecha: TDateTime ): boolean;
var
  iPaletsAlbaran, iCajasAlbaran: integer;
  rKilosAlbaran, rImporteAlbaran: real;
  iTPaletsAlbaran, iTCajasAlbaran: integer;
  rTKilosAlbaran, rTImporteAlbaran: real;
  sProducto: string;
  iAux: integer;
begin
  with QDatosAlbaran do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('albaran').AsInteger:= AAlbaran;
    ParamByName('fecha').AsDateTime:= AFecha;

    Open;
    result:= not IsEmpty;

    mtDatosAlbaran.Close;
    mtDatosAlbaran.Open;
    mtDatosAlbaranProducto.Open;

    sProducto:= '';

    iPaletsAlbaran:= 0;
    iCajasAlbaran:= 0;
    rImporteAlbaran:= 0;
    rKilosAlbaran:= 0;
    iTPaletsAlbaran:= 0;
    iTCajasAlbaran:= 0;
    rTImporteAlbaran:= 0;
    rTKilosAlbaran:= 0;

    while not eof do
    begin
      mtDatosAlbaran.Insert;
      mtDatosAlbaran.FieldByName('empresa').AsString:= AEmpresa;
      mtDatosAlbaran.FieldByName('centro').AsString:= ACentro;
      mtDatosAlbaran.FieldByName('albaran').AsInteger:= AAlbaran;
      mtDatosAlbaran.FieldByName('fecha').AsDateTime:= AFecha;

      mtDatosAlbaran.FieldByName('anyomes').AsString:= FormatDateTime('yyyymm', AFecha);
      mtDatosAlbaran.FieldByName('anyo').AsString:= FormatDateTime('yyyy', AFecha);
      iAux:= WeekOfTheYear( AFecha );
      if iAux < 0 then
      begin
        mtDatosAlbaran.FieldByName('anyosem').AsString:= mtDatosAlbaran.FieldByName('anyo').AsString + '0' + IntToStr( iAux );
      end
      else
      begin
        mtDatosAlbaran.FieldByName('anyosem').AsString:= mtDatosAlbaran.FieldByName('anyo').AsString + IntToStr( iAux );
      end;

      mtDatosAlbaran.FieldByName('producto').AsString:= FieldByName('producto_sl').AsString;
      mtDatosAlbaran.FieldByName('envase').AsString:= FieldByName('envase_sl').AsString;
      mtDatosAlbaran.FieldByName('categoria').AsString:= FieldByName('categoria_sl').AsString;
      mtDatosAlbaran.FieldByName('calibre').AsString:= FieldByName('calibre_sl').AsString;

      mtDatosAlbaran.FieldByName('empresaOrigen').AsString:= FieldByName('emp_procedencia_sl').AsString;
      mtDatosAlbaran.FieldByName('centroOrigen').AsString:= FieldByName('centro_origen_sl').AsString;

      mtDatosAlbaran.FieldByName('palets').AsInteger:= FieldByName('palets_sl').AsInteger;
      mtDatosAlbaran.FieldByName('cajas').AsInteger:= FieldByName('cajas_sl').AsInteger;
      mtDatosAlbaran.FieldByName('kilos').AsFloat:= FieldByName('kilos_sl').AsFloat;
      mtDatosAlbaran.FieldByName('importe_neto').AsFloat:= FieldByName('importe_neto_sl').AsFloat;

      //proviene de un transito
      if FieldByName('centro_origen_sl').AsString <> ACentro then
      begin
        mtDatosAlbaran.FieldByName('tpalets').AsInteger:= FieldByName('palets_sl').AsInteger;
        mtDatosAlbaran.FieldByName('tcajas').AsInteger:= FieldByName('cajas_sl').AsInteger;
        mtDatosAlbaran.FieldByName('tkilos').AsFloat:= FieldByName('kilos_sl').AsFloat;
        mtDatosAlbaran.FieldByName('timporte_neto').AsFloat:= FieldByName('importe_neto_sl').AsFloat;
      end;

      mtDatosAlbaranProducto.Locate('producto',VarArrayOf([sProducto]),[]);
      if sProducto = FieldByName('producto_sl').AsString then
      begin
        mtDatosAlbaranProducto.Edit;
        mtDatosAlbaranProducto.FieldByName('palets').AsInteger:=
          mtDatosAlbaranProducto.FieldByName('palets').AsInteger + FieldByName('palets_sl').AsInteger;
        mtDatosAlbaranProducto.FieldByName('cajas').AsInteger:=
          mtDatosAlbaranProducto.FieldByName('cajas').AsInteger + FieldByName('cajas_sl').AsInteger;
        mtDatosAlbaranProducto.FieldByName('kilos').AsFloat:=
          mtDatosAlbaranProducto.FieldByName('kilos').AsFloat + FieldByName('kilos_sl').AsFloat;
        mtDatosAlbaranProducto.FieldByName('importe_neto').AsFloat:=
          mtDatosAlbaranProducto.FieldByName('importe_neto').AsFloat + FieldByName('importe_neto_sl').AsFloat;

        //proviene de un transito
        if FieldByName('centro_origen_sl').AsString <> ACentro then
        begin
          mtDatosAlbaranProducto.FieldByName('tpalets').AsInteger:=
            mtDatosAlbaranProducto.FieldByName('tpalets').AsInteger + FieldByName('palets_sl').AsInteger;
          mtDatosAlbaranProducto.FieldByName('tcajas').AsInteger:=
            mtDatosAlbaranProducto.FieldByName('tcajas').AsInteger + FieldByName('cajas_sl').AsInteger;
          mtDatosAlbaranProducto.FieldByName('tkilos').AsFloat:=
            mtDatosAlbaranProducto.FieldByName('tkilos').AsFloat + FieldByName('kilos_sl').AsFloat;
          mtDatosAlbaranProducto.FieldByName('timporte_neto').AsFloat:=
            mtDatosAlbaranProducto.FieldByName('timporte_neto').AsFloat + FieldByName('importe_neto_sl').AsFloat;
        end;

        mtDatosAlbaranProducto.Post;
      end
      else
      begin
        sProducto:= FieldByName('producto_sl').AsString;
        mtDatosAlbaranProducto.Insert;
        mtDatosAlbaranProducto.FieldByName('producto').AsString:= sProducto;
        mtDatosAlbaranProducto.FieldByName('palets').AsInteger:= FieldByName('palets_sl').AsInteger;
        mtDatosAlbaranProducto.FieldByName('cajas').AsInteger:= FieldByName('cajas_sl').AsInteger;
        mtDatosAlbaranProducto.FieldByName('kilos').AsFloat:= FieldByName('kilos_sl').AsFloat;
        mtDatosAlbaranProducto.FieldByName('importe_neto').AsFloat:= FieldByName('importe_neto_sl').AsFloat;

        //proviene de un transito
        if FieldByName('centro_origen_sl').AsString <> ACentro then
        begin
          mtDatosAlbaranProducto.FieldByName('tpalets').AsInteger:= FieldByName('palets_sl').AsInteger;
          mtDatosAlbaranProducto.FieldByName('tcajas').AsInteger:= FieldByName('cajas_sl').AsInteger;
          mtDatosAlbaranProducto.FieldByName('tkilos').AsFloat:= FieldByName('kilos_sl').AsFloat;
          mtDatosAlbaranProducto.FieldByName('timporte_neto').AsFloat:= FieldByName('importe_neto_sl').AsFloat;
        end;

        mtDatosAlbaranProducto.Post;
      end;

      iPaletsAlbaran:= iPaletsAlbaran + FieldByName('palets_sl').AsInteger;
      iCajasAlbaran:= iCajasAlbaran + FieldByName('cajas_sl').AsInteger;
      rKilosAlbaran:= rKilosAlbaran + FieldByName('kilos_sl').AsFloat;
      rImporteAlbaran:= rImporteAlbaran +  FieldByName('importe_neto_sl').AsFloat;

      //proviene de un transito
      if FieldByName('centro_origen_sl').AsString <> ACentro then
      begin
        iTPaletsAlbaran:= iTPaletsAlbaran + FieldByName('palets_sl').AsInteger;
        iTCajasAlbaran:= iTCajasAlbaran + FieldByName('cajas_sl').AsInteger;
        rTKilosAlbaran:= rTKilosAlbaran + FieldByName('kilos_sl').AsFloat;
        rTImporteAlbaran:= rTImporteAlbaran +  FieldByName('importe_neto_sl').AsFloat;
      end;

      mtDatosAlbaran.FieldByName('importe_comision').AsFloat:= 0;
      mtDatosAlbaran.FieldByName('importe_descuento').AsFloat:= 0;
      mtDatosAlbaran.FieldByName('importe_gastos_salidas').AsFloat:= 0;
      mtDatosAlbaran.FieldByName('importe_gastos_transitos').AsFloat:= 0;
      mtDatosAlbaran.FieldByName('importe_envasado').AsFloat:= 0;
      mtDatosAlbaran.FieldByName('importe_secciones').AsFloat:= 0;
      mtDatosAlbaran.FieldByName('importe_indirecto').AsFloat:= 0;
      mtDatosAlbaran.FieldByName('importe_abonos').AsFloat:= 0;
      Next;
    end;

    mtDatosAlbaran.First;
    while not mtDatosAlbaran.eof do
    begin
      sProducto:= mtDatosAlbaran.FieldByName('producto').AsString;
      mtDatosAlbaran.Edit;

      mtDatosAlbaran.FieldByName('palets_albaran').AsInteger:= iPaletsAlbaran;
      mtDatosAlbaran.FieldByName('cajas_albaran').AsInteger:= iCajasAlbaran;
      mtDatosAlbaran.FieldByName('kilos_albaran').AsFloat:= rKilosAlbaran;
      mtDatosAlbaran.FieldByName('importe_albaran').AsFloat:= rImporteAlbaran;

      //proviene de un transito
      mtDatosAlbaran.FieldByName('tpalets_albaran').AsInteger:= iTPaletsAlbaran;
      mtDatosAlbaran.FieldByName('tcajas_albaran').AsInteger:= iTCajasAlbaran;
      mtDatosAlbaran.FieldByName('tkilos_albaran').AsFloat:= rTKilosAlbaran;
      mtDatosAlbaran.FieldByName('timporte_albaran').AsFloat:= rTImporteAlbaran;

      if sProducto <> mtDatosAlbaranProducto.FieldByName('producto').AsString then
      begin
        mtDatosAlbaranProducto.Locate('producto',VarArrayOf([sProducto]),[]);
      end;
      mtDatosAlbaran.FieldByName('palets_producto').AsFloat:=
                                   mtDatosAlbaranProducto.FieldByName('palets').AsInteger;
      mtDatosAlbaran.FieldByName('cajas_producto').AsFloat:=
                                   mtDatosAlbaranProducto.FieldByName('cajas').AsInteger;
      mtDatosAlbaran.FieldByName('kilos_producto').AsFloat:=
                                   mtDatosAlbaranProducto.FieldByName('kilos').AsFloat;
      mtDatosAlbaran.FieldByName('importe_producto').AsFloat:=
                                   mtDatosAlbaranProducto.FieldByName('importe_neto').AsFloat;

      //proviene de un transito
      mtDatosAlbaran.FieldByName('tpalets_producto').AsFloat:=
                                   mtDatosAlbaranProducto.FieldByName('tpalets').AsInteger;
      mtDatosAlbaran.FieldByName('tcajas_producto').AsFloat:=
                                   mtDatosAlbaranProducto.FieldByName('tcajas').AsInteger;
      mtDatosAlbaran.FieldByName('tkilos_producto').AsFloat:=
                                   mtDatosAlbaranProducto.FieldByName('tkilos').AsFloat;
      mtDatosAlbaran.FieldByName('timporte_producto').AsFloat:=
                                   mtDatosAlbaranProducto.FieldByName('timporte_neto').AsFloat;

      mtDatosAlbaran.Next;
    end;

    mtDatosAlbaranProducto.Close;

    Close;//QDatosAlbaran
  end;
end;

procedure TDLPreciosFOBVenta.DescuentosComisionesYCambio( const ADescuento, AComision: boolean );
var
  sCliente, sRepresentante, sMoneda, sPais: string;
  rAux, rDescuento, rComision, rCambio: real;
begin
  //Buscar y grabar descuentos y comisiones en la tabla temporal -> mtDescuentos
  with QClienteFac do
  begin
    ParamByName('empresa').AsString:= mtDatosAlbaran.FieldByName('empresa').AsString;
    ParamByName('centro').AsString:= mtDatosAlbaran.FieldByName('centro').AsString;
    ParamByName('albaran').AsInteger:= mtDatosAlbaran.FieldByName('albaran').AsInteger;
    ParamByName('fecha').AsDateTime:= mtDatosAlbaran.FieldByName('fecha').AsDateTime;
    Open;
    sCliente:= FieldByname('cliente_c').AsString;
    sRepresentante:= FieldByname('representante_c').AsString;
    sMoneda:= FieldByname('moneda_sc').AsString;
    sPais:= FieldByname('pais_c').AsString;
    Close;
  end;

  (*TODO: FECHA DEL CAMBIO -> Albaran o Factura*)
  rCambio:= 1;
  if sMoneda <> 'EUR' then
  with QCambio do
  begin
    ParamByName('moneda').AsString:= sMoneda;
    ParamByName('fecha').AsDateTime:= mtDatosAlbaran.FieldByName('fecha').AsDateTime;
    Open;
    rCambio:= FieldByName('cambio').AsFloat;
    Close;
  end;

  rDescuento:= 0;
  if ADescuento then
  with QDescuento do
  begin
    ParamByName('empresa').AsString:= mtDatosAlbaran.FieldByName('empresa').AsString;
    ParamByName('cliente').AsString:= sCliente;
    Open;
    if Not IsEmpty then
    begin
      while ( FieldByname('fecha_ini').AsDateTime < mtDatosAlbaran.FieldByName('fecha').AsDateTime ) and
            ( not Eof ) do
      begin
        if mtDatosAlbaran.FieldByName('fecha').AsDateTime <= FieldByname('fecha_fin').AsDateTime then
        begin
          rDescuento:= FieldByname('descuento').AsFloat;
          Break;
        end;
        Next;
      end;
    end;
    Close;
  end;

  rComision:= 0;
  if AComision then
  with QComision do
  begin
    ParamByName('representante').AsString:= sRepresentante;
    Open;
    rComision:= 0;
    if Not IsEmpty then
    begin
      while ( FieldByname('fecha_ini').AsDateTime < mtDatosAlbaran.FieldByName('fecha').AsDateTime ) and ( not Eof ) do
      begin
        if mtDatosAlbaran.FieldByName('fecha').AsDateTime <= FieldByname('fecha_fin').AsDateTime then
        begin
          rComision:= FieldByname('comision').AsFloat;
          Break;
        end;
        Next;
      end;
    end;
    Close;
  end;

  mtDatosAlbaran.First;

  while not mtDatosAlbaran.eof do
  begin
    mtDatosAlbaran.Edit;
    mtDatosAlbaran.FieldByname('cliente_fac').AsString:= sCliente;
    mtDatosAlbaran.FieldByname('pais').AsString:= sPais;
    mtDatosAlbaran.FieldByname('moneda').AsString:= sMoneda;
    mtDatosAlbaran.FieldByname('cambio').AsFloat:= rCambio;
    mtDatosAlbaran.FieldByname('importe_neto').AsFloat:=
      bRoundTo(mtDatosAlbaran.FieldByname('importe_neto').AsFloat / rCambio, -2);
    if ( rComision <> 0 ) or ( rDescuento <> 0 ) then
    begin
      rAux:= mtDatosAlbaran.FieldByname('importe_neto').AsFloat;
      mtDatosAlbaran.FieldByname('importe_comision').AsFloat:= bRoundTo( ( rAux * rComision ) / 100, -2 );
      rAux:= rAux - mtDatosAlbaran.FieldByname('importe_comision').AsFloat;
      mtDatosAlbaran.FieldByname('importe_descuento').AsFloat:= bRoundTo( ( rAux * rDescuento ) / 100, -2 );
    end;
    mtDatosAlbaran.Post;
    mtDatosAlbaran.Next;
  end;
end;

procedure TDLPreciosFOBVenta.PreparaQueryGastosAlbaran;
begin
  with QGastosAlbaran do
  begin
      SQL.Clear;
      SQL.Add(' select producto_g producto, case when nvl(gasto_transito_tg,0) = 1  then 1 else 0 end transito, unidad_dist_tg unidad, ');
      SQL.Add('        sum( case when nvl(facturable_tg, ''N'') = ''N'' then importe_g else importe_g * -1 end ) importe ');
      SQL.Add(' from frf_gastos, frf_tipo_gastos ');
      SQL.Add(' where empresa_g = :empresa ');
      SQL.Add(' and centro_salida_g = :centro ');
      SQL.Add(' and n_albaran_g = :albaran ');
      SQL.Add(' and fecha_g = :fecha ');
      SQL.Add(' and tipo_tg = tipo_g ');
      if bSoloGastosFacturables then
        SQL.Add(' and nvl(facturable_tg, ''N'') = ''S'' ');
      SQL.Add(' group by 1,2,3 ');
      Prepare;
  end;
end;

procedure TDLPreciosFOBVenta.GastosAlbaran;
begin
  with QGastosAlbaran do
  begin
    ParamByName('empresa').AsString:= mtDatosAlbaran.FieldByName('empresa').AsString;
    ParamByName('centro').AsString:= mtDatosAlbaran.FieldByName('centro').AsString;
    ParamByName('albaran').AsInteger:= mtDatosAlbaran.FieldByName('albaran').AsInteger;
    ParamByName('fecha').AsDateTime:= mtDatosAlbaran.FieldByName('fecha').AsDateTime;
    Open;
    while not Eof do
    begin
      if ( ( FieldByname('transito').AsInteger = 1 ) and ( bAplicarGastosTransitos ) ) or
         ( ( FieldByname('transito').AsInteger = 0 ) and ( bAplicarGastosSalidas ) ) then
        AplicarGastos;
      Next;
    end;
    Close;
  end;
end;

procedure TDLPreciosFOBVenta.DistribuirPorPalets;
var
  rAux: real;
begin
  with mtDatosAlbaran do
  begin
    //GASTO DE SALIDA
    if QGastosAlbaran.FieldByName('transito').AsInteger = 0 then
    begin
      if QGastosAlbaran.FieldByName('producto').AsString = '' then
      begin
        if FieldByName('palets_albaran').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('palets_albaran').AsFloat;
      end
      else
      begin
        if FieldByName('palets_producto').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('palets_producto').AsFloat;
      end;
      if FieldByName('palets').AsFloat <> 0 then
      begin
        rAux:= bRoundTo( ( QGastosAlbaran.FieldByName('importe').AsFloat *
                                FieldByName('palets').AsFloat ) / rAux, -2 );
        rAux:= bRoundTo( rAux / FieldByName('cambio').AsFloat, - 2 );
        FieldByName('importe_gastos_salidas').AsFloat:=
          FieldByName('importe_gastos_salidas').AsFloat + rAux;
      end;
    end

    //GASTO DE TRANSITO
    else
    begin
      if QGastosAlbaran.FieldByName('producto').AsString = '' then
      begin
        if FieldByName('tpalets_albaran').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('tpalets_albaran').AsFloat
      end
      else
      begin
        if FieldByName('tpalets_producto').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('tpalets_producto').AsFloat;
      end;
      if FieldByName('tpalets').AsFloat <> 0 then
      begin
        rAux:= bRoundTo( ( QGastosAlbaran.FieldByName('importe').AsFloat *
                                    FieldByName('tpalets').AsFloat ) / rAux, -2 );
        rAux:= bRoundTo( rAux / FieldByName('cambio').AsFloat, - 2 );
        FieldByName('importe_gastos_transitos').AsFloat:= FieldByName('importe_gastos_transitos').AsFloat + rAux;
      end;
    end;
  end;
end;

procedure TDLPreciosFOBVenta.DistribuirPorCajas;
var
  rAux: real;
begin
  with mtDatosAlbaran do
  begin
    if QGastosAlbaran.FieldByName('transito').AsInteger = 0 then
    begin
      if QGastosAlbaran.FieldByName('producto').AsString = '' then
      begin
        if FieldByName('cajas_albaran').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('cajas_albaran').AsFloat;
      end
      else
      begin
        if FieldByName('cajas_producto').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('cajas_producto').AsFloat;
      end;
      if FieldByName('cajas').AsFloat <> 0 then
      begin
        rAux:= bRoundTo( ( QGastosAlbaran.FieldByName('importe').AsFloat *
                                FieldByName('cajas').AsFloat ) / rAux, -2 );
        rAux:= bRoundTo( rAux / FieldByName('cambio').AsFloat, - 2 );
        FieldByName('importe_gastos_salidas').AsFloat:= FieldByName('importe_gastos_salidas').AsFloat + rAux;
      end;
    end
    else
    begin
      if QGastosAlbaran.FieldByName('producto').AsString = '' then
      begin
        if FieldByName('tcajas_albaran').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('tcajas_albaran').AsFloat
      end
      else
      begin
        if FieldByName('tcajas_producto').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('tcajas_producto').AsFloat;
      end;
      if FieldByName('tcajas').AsFloat <> 0 then
      begin
        rAux:= bRoundTo( ( QGastosAlbaran.FieldByName('importe').AsFloat *
                                FieldByName('tcajas').AsFloat ) / rAux, -2 );
        rAux:= bRoundTo( rAux / FieldByName('cambio').AsFloat, - 2 );
        FieldByName('importe_gastos_transitos').AsFloat:= FieldByName('importe_gastos_transitos').AsFloat + rAux;
      end;
    end;
  end;
end;

procedure TDLPreciosFOBVenta.DistribuirPorKilos;
var
  rAux: real;
begin
  with mtDatosAlbaran do
  begin
    if QGastosAlbaran.FieldByName('transito').AsInteger = 0 then
    begin
      if FieldByName('kilos').AsFloat <> 0 then
      begin
        if QGastosAlbaran.FieldByName('producto').AsString = '' then
          rAux:= FieldByName('kilos_albaran').AsFloat
        else
          rAux:= FieldByName('kilos_producto').AsFloat;
        rAux:= bRoundTo( ( QGastosAlbaran.FieldByName('importe').AsFloat *
                                    FieldByName('kilos').AsFloat ) / rAux, -2 );
        rAux:= bRoundTo( rAux / FieldByName('cambio').AsFloat, - 2 );
        FieldByName('importe_gastos_salidas').AsFloat:= FieldByName('importe_gastos_salidas').AsFloat + rAux;
      end;
    end
    else
    begin
      if FieldByName('tkilos').AsFloat <> 0 then
      begin
        if QGastosAlbaran.FieldByName('producto').AsString = '' then
          rAux:= FieldByName('tkilos_albaran').AsFloat
        else
          rAux:= FieldByName('tkilos_producto').AsFloat;
        rAux:= bRoundTo( ( QGastosAlbaran.FieldByName('importe').AsFloat *
                                      FieldByName('tkilos').AsFloat ) / rAux, -2 );
        rAux:= bRoundTo( rAux / FieldByName('cambio').AsFloat, - 2 );
        FieldByName('importe_gastos_transitos').AsFloat:= FieldByName('importe_gastos_transitos').AsFloat + rAux;
      end;
    end;
  end;
end;

procedure TDLPreciosFOBVenta.DistribuirPorImporte;
var
  rAux: real;
begin
  with mtDatosAlbaran do
  begin
    if QGastosAlbaran.FieldByName('transito').AsInteger = 0 then
    begin
      if QGastosAlbaran.FieldByName('producto').AsString = '' then
      begin
        if FieldByName('importe_albaran').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('importe_albaran').AsFloat
      end
      else
      begin
        if FieldByName('importe_producto').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('importe_producto').AsFloat;
      end;
      if FieldByName('importe_neto').AsFloat <> 0 then
      begin
        rAux:= bRoundTo( ( QGastosAlbaran.FieldByName('importe').AsFloat *
                                FieldByName('importe_neto').AsFloat ) / rAux, -2 );
        rAux:= bRoundTo( rAux / FieldByName('cambio').AsFloat, - 2 );
        FieldByName('importe_gastos_salidas').AsFloat:= FieldByName('importe_gastos_salidas').AsFloat + rAux;
      end;
    end
    else
    begin
      if QGastosAlbaran.FieldByName('producto').AsString = '' then
      begin
        if FieldByName('timporte_albaran').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('timporte_albaran').AsFloat
      end
      else
      begin
        if FieldByName('timporte_producto').AsFloat = 0 then
        begin
          DistribuirPorKilos;
          Exit;
        end;
        rAux:= FieldByName('timporte_producto').AsFloat;
      end;
      if FieldByName('timporte_neto').AsFloat <> 0 then
      begin
        rAux:= bRoundTo( ( QGastosAlbaran.FieldByName('importe').AsFloat *
                                FieldByName('timporte_neto').AsFloat ) / rAux, -2 );
        rAux:= bRoundTo( rAux / FieldByName('cambio').AsFloat, - 2 );
        FieldByName('importe_gastos_transitos').AsFloat:= FieldByName('importe_gastos_transitos').AsFloat + rAux;
      end;
    end;
  end;
end;


procedure TDLPreciosFOBVenta.AplicarGastos;
begin
  with mtDatosAlbaran do
  begin
    First;
    while not Eof do
    begin
      if ( FieldByName('producto').AsString = QGastosAlbaran.FieldByName('producto').AsString  ) or
         ( QGastosAlbaran.FieldByName('producto').AsString = '' ) then
      begin
        Edit;

        if ( QGastosAlbaran.FieldByName('unidad').AsString = 'PALETS' ) then
        begin
          DistribuirPorPalets;
        end
        else
        if ( QGastosAlbaran.FieldByName('unidad').AsString = 'CAJAS' ) then
        begin
          DistribuirPorCajas;
        end
        else
        if ( QGastosAlbaran.FieldByName('unidad').AsString = 'IMPORTE' ) then
        begin
          DistribuirPorImporte;
        end
        else
        begin
          DistribuirPorKilos;
        end;

        Post;
      end;
      Next;
    end;
  end;
end;

procedure TDLPreciosFOBVenta.AbonosAlbaran;
begin
  with QAbonosAlbaran do
  begin
    ParamByName('empresa').AsString:= mtDatosAlbaran.FieldByName('empresa').AsString;
    ParamByName('centro').AsString:= mtDatosAlbaran.FieldByName('centro').AsString;
    ParamByName('albaran').AsInteger:= mtDatosAlbaran.FieldByName('albaran').AsInteger;
    ParamByName('fecha').AsDateTime:= mtDatosAlbaran.FieldByName('fecha').AsDateTime;
    Open;
    while not Eof do
    begin
      AplicarAbonos;
      Next;
    end;
    Close;
  end;
end;

procedure TDLPreciosFOBVenta.AplicarAbonos;
var
  rAux: Real;
begin
  with mtDatosAlbaran do
  begin
    First;
    while not Eof do
    begin
      if ( FieldByName('producto').AsString = QAbonosAlbaran.FieldByName('producto').AsString  ) or
         ( QAbonosAlbaran.FieldByName('producto').AsString = '' ) then
      begin
        Edit;
        if QAbonosAlbaran.FieldByName('producto').AsString = '' then
          rAux:= FieldByName('kilos_albaran').AsFloat
        else
          rAux:= FieldByName('kilos_producto').AsFloat;
        rAux:= bRoundTo( ( QAbonosAlbaran.FieldByName('importe').AsFloat *
                                FieldByName('kilos').AsFloat ) / rAux, -2 );
        FieldByName('importe_abonos').AsFloat:= FieldByName('importe_abonos').AsFloat + rAux;
        Post;
      end;
      Next;
    end;
  end;
end;

procedure TDLPreciosFOBVenta.CosteEnvasado( const AEnvasado, ASecciones: boolean );
var
  rCoste, rSecciones: real;
begin
  with mtDatosAlbaran do
  begin
    First;
    while not Eof do
    begin
      GetCosteEnvasado( rCoste, rSecciones );
      if ( rCoste <> 0 ) or ( rSecciones <> 0 ) then
      begin
        Edit;
        if AEnvasado and ( rCoste <> 0 )then
          FieldByName('importe_envasado').AsFloat:= bRoundTo( FieldByName('kilos').Asinteger * rCoste, -2 );
        if ASecciones and ( rSecciones <> 0 ) then
          FieldByName('importe_secciones').AsFloat:= bRoundTo( FieldByName('kilos').Asinteger * rSecciones, -2 );
        Post;
      end;
      Next;
    end;
  end;
end;

procedure TDLPreciosFOBVenta.GetCosteEnvasado( var VEnvasado, VSecciones: Real );
begin
  with QCosteEnvase do
  begin
    ParamByName('empresa').AsString:= mtDatosAlbaran.FieldByName('empresa').AsString;
    ParamByName('centro').AsString:= mtDatosAlbaran.FieldByName('centroOrigen').AsString;
    ParamByName('producto').AsString:= mtDatosAlbaran.FieldByName('producto').AsString;
    ParamByName('envase').AsString:= mtDatosAlbaran.FieldByName('envase').AsString;
    ParamByName('fecha').AsDateTime:= mtDatosAlbaran.FieldByName('fecha').AsDateTime;

    Open;
    if not IsEmpty then
    begin
      VEnvasado:= FieldByName('coste').AsFloat;
      VSecciones:= FieldByName('secciones').AsFloat;
    end
    else
    begin
      GetCosteEnvasadoLosLLanos( VEnvasado, VSecciones );
    end;
    Close;
  end;
end;

procedure TDLPreciosFOBVenta.GetCosteEnvasadoLosLLanos( var VEnvasado, VSecciones: Real );
begin
  with QCosteEnvaseLosLLanos do
  begin
    ParamByName('empresa').AsString:= mtDatosAlbaran.FieldByName('empresa').AsString;
    ParamByName('producto').AsString:= mtDatosAlbaran.FieldByName('producto').AsString;
    ParamByName('envase').AsString:= mtDatosAlbaran.FieldByName('envase').AsString;
    ParamByName('fecha').AsDateTime:= mtDatosAlbaran.FieldByName('fecha').AsDateTime;

    Open;
    if not IsEmpty then
    begin
      VEnvasado:= FieldByName('coste').AsFloat;
      VSecciones:= FieldByName('secciones').AsFloat;
    end
    else
    begin
      VEnvasado:= 0;
      VSecciones:= 0;
    end;
    Close;
  end;
end;

(*
procedure TDLPreciosFOBVenta.CosteSecciones;
var
  rAux: real;
begin
  with mtDatosAlbaran do
  begin
    First;
    while not Eof do
    begin
      rAux:= GetCosteSecciones;
      if rAux <> 0 then
      begin
        Edit;
        FieldByName('importe_secciones').AsFloat:= bRoundTo( FieldByName('kilos').Asinteger * rAux, -2 );
        Post;
      end;
      Next;
    end;
  end;
end;
*)

(*
function  TDLPreciosFOBVenta.GetCosteSecciones: real;
var
  sAux: string;
begin
  //  SQL.Add(' select env_tcoste_etc, descripcion_etc, coste_kg_emc, aplic_primera_etc, ');
  //  SQL.Add('        aplic_segunda_etc, aplic_tercera_etc, aplic_destrio_etc, centro_paso_etc ');
  with QCosteSecciones do
  begin
    ParamByName('empresa').AsString:= mtDatosAlbaran.FieldByName('empresa').AsString;
    ParamByName('centro').AsString:= mtDatosAlbaran.FieldByName('centroOrigen').AsString;
    ParamByName('producto').AsString:= mtDatosAlbaran.FieldByName('producto').AsString;
    ParamByName('anyomes').AsString:= FormatDateTime( 'yyyymm', mtDatosAlbaran.FieldByName('fecha').AsDateTime );

    Open;
    if not IsEmpty then
    begin
      if mtDatosAlbaran.FieldByName('categoria').AsString = '1' then
        sAux:= 'primera'
      else
      if mtDatosAlbaran.FieldByName('categoria').AsString = '2' then
        sAux:= 'segunda'
      else
      if mtDatosAlbaran.FieldByName('categoria').AsString = '3' then
        sAux:= 'tercera'
      else
        sAux:= 'destrio';
      result:= 0;
      while not Eof do
      begin
        if FieldByname( sAux ).AsInteger = 1 then
          result:= result + FieldByname( 'coste' ).AsFloat;
        Next;
      end;
    end
    else
    begin
      result:= 0;
    end;
    Close;
  end;
end;
*)

procedure TDLPreciosFOBVenta.CosteIndirecto;
var
  rAux: real;
begin
  with mtDatosAlbaran do
  begin
    First;
    while not Eof do
    begin
      rAux:= GetCosteIndirecto;
      if rAux <> 0 then
      begin
        Edit;
        FieldByName('importe_indirecto').AsFloat:= bRoundTo( FieldByName('kilos').Asinteger * rAux, -2 );
        Post;
      end;
      Next;
    end;
  end;
end;

function  TDLPreciosFOBVenta.GetCosteIndirecto: real;
begin
  with QCosteIndirecto do
  begin
    ParamByName('empresa').AsString:= mtDatosAlbaran.FieldByName('empresa').AsString;
    ParamByName('centro').AsString:= mtDatosAlbaran.FieldByName('centroOrigen').AsString;
    ParamByName('fecha').AsDate:= mtDatosAlbaran.FieldByName('fecha').AsDateTime;

    Open;
    result:= FieldByname( 'coste_indirecto' ).AsFloat;
    Close;
  end;
end;

function TDLPreciosFOBVenta.GetFobCalibre( const AEmpresa, ACentro: string; const AAlbaran: integer;
           const AFecha: TDateTime; const AProducto, AEnvase, ACalibre: string;
           var AKilos, AImporte, AComision, ADescuento, AGastos, AEnvasado, ASecciones, AAbonos, AFob: real  ): Boolean;
begin
  AKilos:= 0;
  AImporte:= 0;
  AComision:= 0;
  ADescuento:= 0;
  AGastos:= 0;
  AEnvasado:= 0;
  ASecciones:= 0;
  AAbonos:= 0;
  AFob:= 0;

  result:= PreciosFob( AEmpresa, ACentro, AAlbaran, AFecha );
  if result then
  begin
    if mtDatosAlbaran.Locate('empresa;centro;albaran;fecha;producto;envase;calibre',
         VarArrayOf([AEmpresa,ACentro,AAlbaran,AFecha,AProducto,AEnvase,ACalibre]), []) then
    begin
      result:= true;
      AFob:= mtDatosAlbaran.FieldByName('importe_comision').AsFloat +
             mtDatosAlbaran.FieldByName('importe_descuento').AsFloat +
             mtDatosAlbaran.FieldByName('importe_gastos_salidas').AsFloat +
             mtDatosAlbaran.FieldByName('importe_gastos_transitos').AsFloat +
             mtDatosAlbaran.FieldByName('importe_envasado').AsFloat +
             mtDatosAlbaran.FieldByName('importe_secciones').AsFloat +
             mtDatosAlbaran.FieldByName('importe_abonos').AsFloat;
      AFob:= mtDatosAlbaran.FieldByName('importe_neto').AsFloat - AFob;

      AKilos:= mtDatosAlbaran.FieldByName('kilos').AsFloat;
      if AKilos <> 0 then
      begin
        AImporte:= bRoundTo( mtDatosAlbaran.FieldByName('importe_neto').AsFloat, - 2 );
        AComision:= bRoundTo( mtDatosAlbaran.FieldByName('importe_comision').AsFloat, - 2 );
        ADescuento:= bRoundTo( mtDatosAlbaran.FieldByName('importe_descuento').AsFloat, - 2 );
        AGastos:= bRoundTo( mtDatosAlbaran.FieldByName('importe_gastos_salidas').AsFloat +
                                 mtDatosAlbaran.FieldByName('importe_gastos_transitos').AsFloat, - 2 );
        AEnvasado:= bRoundTo( mtDatosAlbaran.FieldByName('importe_envasado').AsFloat, - 2 );
        ASecciones:= bRoundTo( mtDatosAlbaran.FieldByName('importe_secciones').AsFloat, - 2 );
        AAbonos:= bRoundTo( mtDatosAlbaran.FieldByName('importe_abonos').AsFloat, - 2 );
        AFob:= bRoundTo( AFob / AKilos, - 3 );
      end;
    end;
  end;
end;

end.
