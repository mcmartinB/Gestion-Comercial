unit LiquidaFrutaEntradasSalidasDM;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables, TablaTemporalFOBData;

type
  TDMLiquidaFrutaEntradasSalidas = class(TDataModule)
    kmtResumen: TkbmMemTable;
    kmtLiquidacion: TkbmMemTable;
    qryEntradas: TQuery;
    qryEntradasCos: TQuery;
    qryKilosRet: TQuery;
    qryInventarios: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    //Parametros de entrada
    sEmpresa, sCentro, sProducto, sCosechero: string;
    dFechaIni, dFechaFin: TDateTime;
    rCosteComercial, rCosteProduccion, rCosteAdministrativo: Real;
    bAbonos, bDefinitiva, bCatComercial: boolean;

    //Variables del objeto
    sAnyoSemana: string;

    RResultadosFob: TResultadosFob;
    //rPeso, rNeto, rDescuento, rGastos, rCosteEnvase, rCosteSecciones: Real;
    dIni, dFin: TDateTime;
    rImporteLiquidar: Real;

    procedure AbrirTablas;
    procedure CerrarTablas;
    procedure QueryEntradas( const ATipoPeriodo: Integer );

    procedure InsertarLineaResumen( const ATipoPeriodo: Integer );
    procedure PrevisualizarResumen;

    procedure InsertarLiquidacion( const ATipoPeriodo: Integer );
    function  InsertarLiquidacionAux( const ALunes: TDateTime; const ATipoPeriodo: integer ): boolean;
    procedure InsertarLineaLiquidacion( const ALunes: TDateTime; const ATipoPeriodo: integer; const AKilos: real );
    procedure PrevisualizarLiquidacion;

    function  GetKilosRet: real;
    function  GetKilosConsumidos( const AKilosIn: Real; const AIni, AFin: TDateTime ): real;
  public
    { Public declarations }

    procedure LiquidarFrutaEntradaSalida(const AEmpresa, ACentro, AProducto, ACosechero,
       AFechaIni, AFechaFin, ACosteComercial, ACosteProduccion, ACosteAdministrativo: string;
       const AAcatComercial, AAbonos, ADefinitiva: boolean; const ATipoPeriodo: Integer);
  end;

var
  DMLiquidaFrutaEntradasSalidas: TDMLiquidaFrutaEntradasSalidas;

implementation

uses
  UDMBaseDatos, bMath, LiquidaResumenFrutaEntradasSalidasQR,
  LiquidaFrutaEntradasSalidasQR, CReportes, DPreview, bTimeUtils, Variants;

{$R *.dfm}

var
  DMTablaTemporalFOB: TDMTablaTemporalFOB;

procedure TDMLiquidaFrutaEntradasSalidas.DataModuleCreate(Sender: TObject);
begin
  kmtResumen.FieldDefs.Clear;
  kmtResumen.FieldDefs.Add('empresa', ftString, 3, False);
  kmtResumen.FieldDefs.Add('centro', ftString, 3, False);
  kmtResumen.FieldDefs.Add('producto', ftString, 3, False);
  kmtResumen.FieldDefs.Add('anyosemana', ftString, 6, False);
  kmtResumen.FieldDefs.Add('lunes', ftDate, 0, False);
  kmtResumen.FieldDefs.Add('domingo', ftDate, 0, False);

  kmtResumen.FieldDefs.Add('kilos_in', ftFloat, 0, False);
  //kmtResumen.FieldDefs.Add('kilos_consumidos,', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precio_in', ftFloat, 0, False);

  kmtResumen.FieldDefs.Add('kilos_out', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('kilos_venta', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('kilos_ret', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeNeto', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioNeto', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('descuento', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('gastos', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeEnvase', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeFOB', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioFOB', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeComercial', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeProduccion', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeAdminstrativo', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeLiquidar', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioLiquidar', ftFloat, 0, False);
  kmtResumen.CreateTable;

  kmtLiquidacion.FieldDefs.Clear;
  kmtLiquidacion.FieldDefs.Add('empresa', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('centro', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('producto', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('cosechero', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('plantacion', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('anyosemanaplanta', ftString, 6, False);
  kmtLiquidacion.FieldDefs.Add('anyosemana', ftString, 6, False);
  kmtLiquidacion.FieldDefs.Add('lunes', ftDate, 0, False);
  kmtLiquidacion.FieldDefs.Add('domingo', ftDate, 0, False);
  kmtLiquidacion.FieldDefs.Add('kilos_in', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('precioLiquidar', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('importeLiquidar', ftFloat, 0, False);
  kmtLiquidacion.CreateTable;

  qryKilosRet.SQL.Clear;
  qryKilosRet.SQL.Add(' SELECT sum(kilos_sl) kilos ');
  qryKilosRet.SQL.Add(' FROM FRF_SALIDAS_L ');
  qryKilosRet.SQL.Add(' WHERE EMPRESA_SL = :empresa ');
  qryKilosRet.SQL.Add(' AND PRODUCTO_SL  = :producto ');
  qryKilosRet.SQL.Add(' AND CENTRO_ORIGEN_SL = :centro ');
  qryKilosRet.SQL.Add(' AND FECHA_SL BETWEEN :fechaini AND :fechafin ');
  qryKilosRet.SQL.Add(' and ( cliente_sl = ''RET'' or cliente_sl[1,1] = ''0'' ) ');
end;

procedure TDMLiquidaFrutaEntradasSalidas.DataModuleDestroy(
  Sender: TObject);
begin
  CerrarTablas;
end;

procedure TDMLiquidaFrutaEntradasSalidas.AbrirTablas;
begin
  if kmtResumen.Active then
    kmtResumen.Close;
  kmtResumen.Open;

  if kmtLiquidacion.Active then
    kmtLiquidacion.Close;
  kmtLiquidacion.Open;
end;

procedure TDMLiquidaFrutaEntradasSalidas.CerrarTablas;
begin
  kmtResumen.Close;
  kmtLiquidacion.Close;
end;

procedure TDMLiquidaFrutaEntradasSalidas.QueryEntradas( const ATipoPeriodo: Integer );
begin
  qryEntradas.SQL.Clear;
  qryEntradas.SQL.Add(' select empresa_ec empresa, centro_ec centro, producto_ec producto, ');
  if ATipoPeriodo = 0 then
    qryEntradas.SQL.Add('        ''Total'' anyosemana, ')
  else
  if ATipoPeriodo = 1 then
    qryEntradas.SQL.Add('        (year(fecha_ec) * 100) + month(fecha_ec) anyosemana, ')
  else
  if ATipoPeriodo = 2 then
    qryEntradas.SQL.Add('         yearandweek(fecha_ec) anyosemana, ');
  qryEntradas.SQL.Add('         sum(total_kgs_e2l) kilos ');

  qryEntradas.SQL.Add(' from frf_entradas_c, frf_entradas2_l ');
  qryEntradas.SQL.Add(' where empresa_ec = :empresa ');
  qryEntradas.SQL.Add(' and centro_ec = :centro ');
  qryEntradas.SQL.Add(' and fecha_Ec between :fecha_ini and :fecha_fin ');
  qryEntradas.SQL.Add(' and producto_ec = :producto ');

  qryEntradas.SQL.Add(' and empresa_e2l = empresa_ec ');
  qryEntradas.SQL.Add(' and centro_e2l = centro_Ec ');
  qryEntradas.SQL.Add(' and fecha_E2l = fecha_Ec ');
  qryEntradas.SQL.Add(' and numero_entrada_e2l = numero_entrada_ec ');
  if sCosechero <> '' then
    qryEntradas.SQL.Add(' and cosechero_e2l = :cosechero ');

  qryEntradas.SQL.Add(' group by empresa, centro, producto, anyosemana ');
  qryEntradas.SQL.Add(' order by empresa, centro, producto, anyosemana asc ');

  qryEntradas.ParamByName('empresa').AsString:= sEmpresa;
  qryEntradas.ParamByName('producto').AsString:= sProducto;
  qryEntradas.ParamByName('centro').AsString:= sCentro;
  if sCosechero <> '' then
    qryEntradas.ParamByName('cosechero').AsString:= sCosechero;

  //--------------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------------------------

  qryEntradasCos.SQL.Clear;
  qryEntradasCos.SQL.Add(' select empresa_ec empresa, centro_ec centro, producto_ec producto, ');

  if ATipoPeriodo = 0 then
    qryEntradasCos.SQL.Add('        ''Total'' anyosemana, ')
  else
  if ATipoPeriodo = 1 then
    qryEntradasCos.SQL.Add('        (year(fecha_ec) * 100) + month(fecha_ec) anyosemana, ')
  else
  if ATipoPeriodo = 2 then
    qryEntradasCos.SQL.Add('         yearandweek(fecha_ec) anyosemana, ');

  qryEntradasCos.SQL.Add('        cosechero_e2l cosechero, ');
  qryEntradasCos.SQL.Add('        plantacion_e2l plantacion, ano_sem_planta_e2l ano_sem_planta, ');
  qryEntradasCos.SQL.Add('        sum(total_kgs_e2l) kilos ');

  qryEntradasCos.SQL.Add(' from frf_entradas_c, frf_entradas2_l ');
  qryEntradasCos.SQL.Add(' where empresa_ec = :empresa ');
  qryEntradasCos.SQL.Add(' and centro_ec = :centro ');
  qryEntradasCos.SQL.Add(' and fecha_Ec between :fecha_ini and :fecha_fin ');
  qryEntradasCos.SQL.Add(' and producto_ec = :producto ');

  qryEntradasCos.SQL.Add(' and empresa_e2l = empresa_ec ');
  qryEntradasCos.SQL.Add(' and centro_e2l = centro_Ec ');
  qryEntradasCos.SQL.Add(' and fecha_E2l = fecha_Ec ');
  qryEntradasCos.SQL.Add(' and numero_entrada_e2l = numero_entrada_ec ');
  if sCosechero <> '' then
    qryEntradasCos.SQL.Add(' and cosechero_e2l = :cosechero ');

  qryEntradasCos.SQL.Add(' group by empresa, centro, producto, anyosemana, cosechero, plantacion, ano_sem_planta ');
  qryEntradasCos.SQL.Add(' order by empresa, centro, producto, anyosemana asc ');


  qryEntradasCos.ParamByName('empresa').AsString:= sEmpresa;
  qryEntradasCos.ParamByName('producto').AsString:= sProducto;
  qryEntradasCos.ParamByName('centro').AsString:= sCentro;
  if sCosechero <> '' then
    qryEntradasCos.ParamByName('cosechero').AsString:= sCosechero;



  with qryInventarios do
  begin
    SQL.Clear;
    SQL.Add(' select  ');
    SQL.Add('        nvl(kilos_cec_ic,0) + ');
    SQL.Add('        nvl(kilos_cim_c1_ic,0) + nvl(kilos_cia_c1_ic,0) + ');
    SQL.Add('        nvl(kilos_cim_c2_ic,0) + nvl(kilos_cia_c2_ic,0) +  ');
    SQL.Add('        nvl(kilos_zd_c3_ic,0) + ');
    SQL.Add('        nvl(kilos_zd_d_ic,0) + ');
    SQL.Add('        nvl(( select sum( kilos_ce_c1_il + kilos_ce_c2_il )  ');
    SQL.Add('          from frf_inventarios_l ');
    SQL.Add('          where empresa_il = empresa_ic ');
    SQL.Add('          and centro_il = centro_ic ');
    SQL.Add('          and producto_il = producto_ic ');
    SQL.Add('          and fecha_il = fecha_ic ),0) stock,');
    SQL.Add('        nvl(kilos_ajuste_campo_ic,0)  + ');
    SQL.Add('        nvl(kilos_ajuste_c1_ic,0)  + ');
    SQL.Add('        nvl(kilos_ajuste_c2_ic,0)  + ');
    SQL.Add('        nvl(kilos_ajuste_c3_ic,0)  + ');
    SQL.Add('        nvl(kilos_ajuste_cd_ic,0)  ajuste ');

    SQL.Add(' from frf_inventarios_c ');

    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add(' and centro_ic = :centro ');
    SQL.Add(' and producto_ic = :producto ');
    SQL.Add(' and fecha_ic = :fecha ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('centro').AsString:= sCentro;
  end;
end;


procedure TDMLiquidaFrutaEntradasSalidas.LiquidarFrutaEntradaSalida(const AEmpresa, ACentro, AProducto, ACosechero,
       AFechaIni, AFechaFin, ACosteComercial, ACosteProduccion, ACosteAdministrativo: string;
       const AAcatComercial, AAbonos, ADefinitiva: boolean; const ATipoPeriodo: Integer );
var
  bFlag: Boolean;
  VPeso, VNeto, VDescuento, VGastos, VMaterial, VGeneral: Real;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  sCosechero:= ACosechero;
  dFechaIni:= StrToDate( AFechaIni);
  dFechaFin:= StrToDate( AFechaFin);
  rCosteComercial:= StrToFloat( ACosteComercial );
  rCosteProduccion:= StrToFloat( ACosteProduccion );
  rCosteAdministrativo:= StrToFloat( ACosteAdministrativo );
  bCatComercial:= AAcatComercial;
  bAbonos:= AAbonos;
  bDefinitiva:= ADefinitiva;

  AbrirTablas;

  QueryEntradas( ATipoPeriodo );

  dIni:= dFechaIni;
  while dIni < dFechaFin do
  begin
    if ATipoPeriodo = 0 then
      dFin:= dFechaFin
    else
    if ATipoPeriodo = 1 then
      dFin:= IncMonth( dIni ) - 1
    else
      dFin:= dIni + 6;

      qryEntradas.ParamByName('fecha_ini').AsDate:= dIni;
      qryEntradas.ParamByName('fecha_fin').AsDate:= dFin;
      qryEntradas.Open;
      try
        bFlag:= not qryEntradas.IsEmpty;

        //
        DMTablaTemporalFOB:= TDMTablaTemporalFOB.Create( self );
        try
          with DMTablaTemporalFOB do
          begin
            sAEmpresa:= sEmpresa;
            iAProductoPropio:= -1;
            sACentroOrigen:= sCentro;
            sACentroSalida:= '';
            sACliente:= '';
            iAClienteFac:= 1;     // 1 -> facturable 2 -> no facturable resto -> todos
            sAPais:= '';
            sAALbaran:= '';
            bAAlb6Digitos:= False;    // true -> como minimo seis digitos (almacen) false -> todos
            iAAlbFacturado:= -1;   // 1 -> facturado  0 -> no facturado  resto -> todos
            bAManuales:= bAbonos;
            bASoloManuales:= False;
            sAFechaDesde:= FormatDateTime('dd/mm/yyyy',dIni);
            sAFEchaHasta:= FormatDateTime('dd/mm/yyyy',dFin);
            bAFechaSalida:= True;    // true -> rango fecha salidas false -> rango fecha facturas (solo facturados)
            sAProducto:= sProducto;
            iAEsHortaliza:= 0;       // 1 -> tomate 2 -> no tomate resto -> todos
            bANoP4h:= False;
            sAEnvase:= '';
            sACategoria:= '';
            sACalibre:= '';
            sATipoGasto:= '';
            bANoGasto:= True;        // true -> excluye el gasto                       false -> lo incluye

            bAGastosNoFac:= True;
            bAGastosFac:= True;
            (**) bAGastosTransitos:= True;
            bAComisiones:= True;
            bADescuentos:= True;
            bACosteEnvase:= True;
            bACosteSecciones:= True;
            bAPromedio:= True;
          end;

          if DMTablaTemporalFOB.ImportesFOB(  VPeso, VNeto, VDescuento, VGastos, VMaterial, VGeneral, RResultadosFob ) then
          begin
            bFlag:= True;
          end;
        finally
          FreeAndNil( DMTablaTemporalFOB );
        end;

        if bFlag then
        begin
          InsertarLineaResumen( ATipoPeriodo );
          InsertarLiquidacion( ATipoPeriodo );
        end;
      finally
        qryEntradas.Close;
      end;


    if ATipoPeriodo = 0 then
      dIni:= dFechaFin
    else
    if ATipoPeriodo = 1 then
      dIni:= IncMonth( dIni )
    else
      dIni:= dIni + 7;
  end;

(*
  if not ASemanal then
  begin
    dLunes:= dFechaIni;
    while dLunes < dFechaFin do
    begin
      dDomingo:= dFechaFin;

      qryEntradas.ParamByName('fecha_ini').AsDate:= dLunes;
      qryEntradas.ParamByName('fecha_fin').AsDate:= dDomingo;
      qryEntradas.Open;
      try
        bFlag:= not qryEntradas.IsEmpty;

        //
        DMTablaTemporalFOB:= TDMTablaTemporalFOB.Create( self );
        try
          if DMTablaTemporalFOB.ImportesFOB_(
              sEmpresa, sCentro, '', FormatDateTime('dd/mm/yyyy',dLunes), FormatDateTime('dd/mm/yyyy',dDomingo), '', '', sProducto, '', '', '',  bCatComercial, bAbonos, RResultadosFob ) then
          begin
            bFlag:= True;
          end;
        finally
          FreeAndNil( DMTablaTemporalFOB );
        end;

        if bFlag then
        begin
          InsertarLineaResumen;
          InsertarLiquidacion;
        end;
      finally
        qryEntradas.Close;
      end;

    dLunes:= dDomingo;
    end;
  end
  else
  begin
    dLunes:= dFechaIni;
    while dLunes < dFechaFin do
    begin
      dDomingo:= dLunes + 6;

      qryEntradas.ParamByName('fecha_ini').AsDate:= dLunes;
      qryEntradas.ParamByName('fecha_fin').AsDate:= dDomingo;
      qryEntradas.Open;
      try
        bFlag:= not qryEntradas.IsEmpty;

        //
        DMTablaTemporalFOB:= TDMTablaTemporalFOB.Create( self );
        try
          if DMTablaTemporalFOB.ImportesFOB_(
              sEmpresa, sCentro, '', FormatDateTime('dd/mm/yyyy',dLunes), FormatDateTime('dd/mm/yyyy',dDomingo), '', '', sProducto, '', '', '',  bCatComercial, bAbonos, RResultadosFob
               ) then
          begin
            bFlag:= True;
          end;
        finally
          FreeAndNil( DMTablaTemporalFOB );
        end;

        if bFlag then
        begin
          InsertarLineaResumen;
          InsertarLiquidacion;
        end;
      finally
        qryEntradas.Close;
      end;

      dLunes:= dLunes + 7;
    end;
  end;
*)
  PrevisualizarResumen;
  PrevisualizarLiquidacion;
end;

function TDMLiquidaFrutaEntradasSalidas.GetKilosRet: real;
begin
  qryKilosRet.ParamByName('empresa').AsString:= sEmpresa;
  qryKilosRet.ParamByName('producto').AsString:= sProducto;
  qryKilosRet.ParamByName('centro').AsString:= sCentro;
  qryKilosRet.ParamByName('fechaini').AsDateTime:= dIni;
  qryKilosRet.ParamByName('fechafin').AsDateTime:= dFin;
  qryKilosRet.Open;
  Result:= qryKilosRet.FieldByName('kilos').AsFloat;
  qryKilosRet.Close;
end;

function  TDMLiquidaFrutaEntradasSalidas.GetKilosConsumidos( const AKilosIn: Real; const AIni, AFin: TDateTime ): real;
var
  rIni, rFin: Real;
begin
  qryInventarios.ParamByName('fecha').AsDate:= AIni -1;
  qryInventarios.Open;
  rIni:= qryInventarios.FieldByName('stock').AsFloat;
  qryInventarios.Close;
  qryInventarios.ParamByName('fecha').AsDate:= AFin;
  qryInventarios.Open;
  rFin:= qryInventarios.FieldByName('stock').AsFloat + qryInventarios.FieldByName('ajuste').AsFloat;
  qryInventarios.Close;
  Result:=  ( AKilosIn + rIni - rFin );
end;

procedure TDMLiquidaFrutaEntradasSalidas.InsertarLineaResumen( const ATipoPeriodo: Integer );
var
  rKilosIn, rImporteComercial, rImporteProduccion, rImporteAdministrativo: Real;
  rPrecioIn: Real;
begin
  kmtResumen.Insert;
  kmtResumen.FieldByName('empresa').AsString:= sEmpresa;
  kmtResumen.FieldByName('centro').AsString:= sCentro;
  kmtResumen.FieldByName('producto').AsString:= sProducto;
  //sAnyoSemana:= qryEntradas.FieldByName('anyosemana').AsString;
  if ATipoPeriodo = 0 then
    sAnyoSemana:= 'Total'
  else
  if ATipoPeriodo = 1 then
    sAnyoSemana:= AnyoMes( dIni )
  else
  if ATipoPeriodo = 2 then
    sAnyoSemana:= AnyoSemana( dIni );
  kmtResumen.FieldByName('anyosemana').AsString:= sAnyoSemana;
  kmtResumen.FieldByName('lunes').AsDateTime:= dIni;
  kmtResumen.FieldByName('domingo').AsDateTime:= dFin;

  //rKilosIn:= qryEntradas.FieldByName('kilos').AsFloat;
  //kmtResumen.FieldByName('kilos_in').AsFloat:= rKilosIn;
  rKilosIn:= 0;
  qryEntradas.First;
  while not qryEntradas.Eof do
  begin
    rKilosIn:= rKilosIn + qryEntradas.FieldByName('kilos').AsFloat;
    qryEntradas.Next;
  end;
  qryEntradas.First;
  rKilosIn:= GetKilosConsumidos( rKilosIn, dIni, dFin);

  kmtResumen.FieldByName('kilos_in').AsFloat:= rKilosIn;
  //kmtResumen.FieldByName('kilos_consumidos').AsFloat:=


  kmtResumen.FieldByName('kilos_venta').AsFloat:= RResultadosFob.rPeso;
  kmtResumen.FieldByName('kilos_ret').AsFloat:= GetKilosRet;
  kmtResumen.FieldByName('kilos_out').AsFloat:= RResultadosFob.rPeso + kmtResumen.FieldByName('kilos_ret').AsFloat;

  kmtResumen.FieldByName('importeNeto').AsFloat:= RResultadosFob.rNeto;
  kmtResumen.FieldByName('descuento').AsFloat:= RResultadosFob.rDescuento;
  kmtResumen.FieldByName('gastos').AsFloat:= RResultadosFob.rGastos;
  kmtResumen.FieldByName('costeEnvase').AsFloat:= RResultadosFob.rCosteEnvase + RResultadosFob.rCosteSecciones;
  kmtResumen.FieldByName('importeFOB').AsFloat:= RResultadosFob.rNeto - ( RResultadosFob.rDescuento + RResultadosFob.rGastos + RResultadosFob.rCosteEnvase + RResultadosFob.rCosteSecciones );

  rImporteComercial:= bRoundto( rCosteComercial * kmtResumen.FieldByName('kilos_venta').AsFloat, 2 );
  kmtResumen.FieldByName('costeComercial').AsFloat:= rImporteComercial;
  rImporteProduccion:= bRoundto( rCosteProduccion * kmtResumen.FieldByName('kilos_venta').AsFloat, 2 );
  kmtResumen.FieldByName('costeProduccion').AsFloat:= rImporteProduccion;
  rImporteAdministrativo:=  bRoundto( rCosteAdministrativo * kmtResumen.FieldByName('kilos_venta').AsFloat, 2 );
  kmtResumen.FieldByName('costeAdminstrativo').AsFloat:= rImporteAdministrativo;

  rImporteLiquidar:= RResultadosFob.rNeto - ( RResultadosFob.rDescuento + RResultadosFob.rGastos + RResultadosFob.rCosteEnvase + RResultadosFob.rCosteSecciones + rImporteComercial + rImporteProduccion + rImporteAdministrativo );
  kmtResumen.FieldByName('importeLiquidar').AsFloat:= rImporteLiquidar;


  if RResultadosFob.rPeso > 0 then
  begin
    kmtResumen.FieldByName('precioNeto').AsFloat:= bRoundTo( RResultadosFob.rNeto/RResultadosFob.rPeso, 9 );
    kmtResumen.FieldByName('precioFOB').AsFloat:= bRoundTo( ( RResultadosFob.rNeto - ( RResultadosFob.rDescuento + RResultadosFob.rGastos + RResultadosFob.rCosteEnvase + RResultadosFob.rCosteSecciones ) ) / RResultadosFob.rPeso, 9);
    kmtResumen.FieldByName('precioLiquidar').AsFloat:= bRoundTo( ( RResultadosFob.rNeto - ( RResultadosFob.rDescuento + RResultadosFob.rGastos + RResultadosFob.rCosteEnvase + RResultadosFob.rCosteSecciones + rImporteComercial + rImporteProduccion + rImporteAdministrativo ) ) / RResultadosFob.rPeso, 9);
  end
  else
  begin
    kmtResumen.FieldByName('precioNeto').AsFloat:= 0;
    kmtResumen.FieldByName('precioFOB').AsFloat:= 0;
    kmtResumen.FieldByName('precioLiquidar').AsFloat:= 0;
  end;

  if rKilosIn <> 0 then
    rPrecioIn:= bRoundTo( rImporteLiquidar / rKilosIn, 9 )
  else
    rPrecioIn:= 0;
  kmtResumen.FieldByName('precio_in').AsFloat:= rPrecioIn;
  kmtResumen.Post;
end;

procedure TDMLiquidaFrutaEntradasSalidas.PrevisualizarResumen;
begin
  QRLiquidaResumenFrutaEntradasSalidas:= TQRLiquidaResumenFrutaEntradasSalidas.Create(Self);
  PonLogoGrupoBonnysa(QRLiquidaResumenFrutaEntradasSalidas);
  try
    kmtResumen.SortFields:= 'anyosemana';
    kmtResumen.Sort([]);
    kmtResumen.First;
    QRLiquidaResumenFrutaEntradasSalidas.qrlblPeriodo.Caption:= 'Periodo del ' +
      FormatDateTime('dd/mm/yyy', dFechaIni) + ' al ' + FormatDateTime('dd/mm/yyy', dFechaFin);
    Preview(QRLiquidaResumenFrutaEntradasSalidas);
  except
    FreeAndNil( QRLiquidaResumenFrutaEntradasSalidas );
  end;
end;

procedure TDMLiquidaFrutaEntradasSalidas.InsertarLiquidacion( const ATipoPeriodo: Integer );
var
  dLunesAux, dDomingoAux: TDateTime;
  bFlag: Boolean;
begin
  if not InsertarLiquidacionAux( dIni, ATipoPeriodo ) then
  begin
    if ATipoPeriodo = 2 then
    begin
      //Semanal
      dLunesAux:= dIni - 7;
      dDomingoAux:= dFin - 7;
      bFlag:= False;
      //Hacia atras en el tiempo
      while ( dLunesAux >= dFechaIni ) and not bFlag  do
      begin
        bFlag:= InsertarLiquidacionAux( dLunesAux, ATipoPeriodo );
        dLunesAux:= dLunesAux - 7;
        dDomingoAux:= dDomingoAux - 7;
      end;
      //Sino hacia adelante
      if not bFlag then
      begin
        dLunesAux:= dIni + 7;
        dDomingoAux:= dFin + 7;
        //Hacia adelante en el tiempo
        while ( dDomingoAux <= dFechaFin ) and not bFlag  do
        begin
          bFlag:= InsertarLiquidacionAux( dLunesAux, ATipoPeriodo );
          dLunesAux:= dLunesAux + 7;
          dDomingoAux:= dDomingoAux + 7;
        end;
      end;
    end;
  end;
end;

function TDMLiquidaFrutaEntradasSalidas.InsertarLiquidacionAux( const ALunes: TDateTime; const ATipoPeriodo: integer ): boolean;
var
  rKilos: real;
begin
  qryEntradasCos.ParamByName('fecha_ini').AsDate:= ALunes;
  if ATipoPeriodo = 0 then
    qryEntradasCos.ParamByName('fecha_fin').AsDate:= dFechaFin
  else
  if ATipoPeriodo = 1 then
    qryEntradasCos.ParamByName('fecha_fin').AsDate:= IncMonth( ALunes ) - 1
  else
    qryEntradasCos.ParamByName('fecha_fin').AsDate:= ALunes + 6;

  qryEntradasCos.Open;
  rKilos:= 0;
  if not qryEntradasCos.IsEmpty then
  begin
    try
      while not qryEntradasCos.Eof do
      begin
        rKilos:= rKilos + qryEntradasCos.FieldByName('kilos').AsFloat;
        qryEntradasCos.Next;
      end;

      qryEntradasCos.First;
      while not qryEntradasCos.Eof do
      begin
        InsertarLineaLiquidacion( ALunes, ATipoPeriodo, rKilos );
        qryEntradasCos.Next;
      end;
    finally
      qryEntradasCos.Close;
    end;
    Result:= True;
  end
  else
  begin
    qryEntradasCos.Close;
    Result:= False;
  end;
end;

procedure TDMLiquidaFrutaEntradasSalidas.InsertarLineaLiquidacion( const ALunes: TDateTime; const ATipoPeriodo: integer; const AKilos: real );
var
  rKilosAux, rImporteAux, rPrecioAux: Real;
  sAnyoSemanaAux: string;
begin
  //sAnyoSemanaAux:= AnyoSemana( ALunes );
  if ATipoPeriodo = 0 then
    sAnyoSemanaAux:= 'Total'
  else
  if ATipoPeriodo = 1 then
    sAnyoSemanaAux:= AnyoMes( ALunes )
  else
  if ATipoPeriodo = 2 then
    sAnyoSemanaAux:= AnyoSemana( ALunes );

  if kmtLiquidacion.Locate('empresa;centro;producto;anyosemana;cosechero;anyosemanaplanta;plantacion',
                           vararrayof([sEmpresa,sCentro,sProducto,sAnyoSemanaAux,
                                       qryEntradasCos.FieldByName('cosechero').AsString,
                                       qryEntradasCos.FieldByName('ano_sem_planta').AsString,
                                       qryEntradasCos.FieldByName('plantacion').AsString ]),[]) then
  begin
    kmtLiquidacion.Edit;
    rKilosAux:= qryEntradasCos.FieldByName('kilos').AsFloat;

    if  AKilos <> 0 then
      rPrecioAux:= bRoundTo( rImporteLiquidar / AKilos, 9)
    else
      rPrecioAux:= 0;
    rImporteAux:= bRoundTo( rKilosAux * rPrecioAux, 2);
    kmtLiquidacion.FieldByName('importeLiquidar').AsFloat:= kmtLiquidacion.FieldByName('importeLiquidar').AsFloat + rImporteAux;

    if kmtLiquidacion.FieldByName('kilos_in').AsFloat <> 0 then
      rPrecioAux:= bRoundTo( kmtLiquidacion.FieldByName('importeLiquidar').AsFloat / kmtLiquidacion.FieldByName('kilos_in').AsFloat, 9 )
    else
      rPrecioAux:= 0;
    kmtLiquidacion.FieldByName('precioLiquidar').AsFloat:= rPrecioAux;
    kmtLiquidacion.Post;
  end
  else
  begin
    kmtLiquidacion.Insert;
    kmtLiquidacion.FieldByName('empresa').AsString:= sEmpresa;
    kmtLiquidacion.FieldByName('centro').AsString:= sCentro;
    kmtLiquidacion.FieldByName('producto').AsString:= sProducto;
    kmtLiquidacion.FieldByName('anyosemana').AsString:= sAnyoSemanaAux;

    kmtLiquidacion.FieldByName('cosechero').AsString:= qryEntradasCos.FieldByName('cosechero').AsString;
    kmtLiquidacion.FieldByName('anyosemanaplanta').AsString:= qryEntradasCos.FieldByName('ano_sem_planta').AsString;
    kmtLiquidacion.FieldByName('plantacion').AsString:= qryEntradasCos.FieldByName('plantacion').AsString;

    kmtLiquidacion.FieldByName('lunes').AsDateTime:= ALunes;
    kmtLiquidacion.FieldByName('domingo').AsDateTime:= ALunes + 6;

    rKilosAux:= qryEntradasCos.FieldByName('kilos').AsFloat;
    kmtLiquidacion.FieldByName('kilos_in').AsFloat:= rKilosAux;

    rPrecioAux:= bRoundTo( rImporteLiquidar / AKilos, 9 );
    kmtLiquidacion.FieldByName('precioLiquidar').AsFloat:= rPrecioAux;

    rImporteAux:= bRoundTo( rKilosAux * rPrecioAux, 2);
    kmtLiquidacion.FieldByName('importeLiquidar').AsFloat:= rImporteAux;
    kmtLiquidacion.Post;
  end;
end;

procedure TDMLiquidaFrutaEntradasSalidas.PrevisualizarLiquidacion;
begin
  QRLiquidaFrutaEntradasSalidas:= TQRLiquidaFrutaEntradasSalidas.Create(Self);
  PonLogoGrupoBonnysa(QRLiquidaFrutaEntradasSalidas);
  try
    kmtLiquidacion.SortFields:= 'cosechero;plantacion;anyosemanaplanta;anyosemana';
    kmtLiquidacion.Sort([]);
    kmtLiquidacion.First;
    QRLiquidaFrutaEntradasSalidas.qrlblPeriodo.Caption:= 'Periodo del ' +
      FormatDateTime('dd/mm/yyy', dFechaIni) + ' al ' + FormatDateTime('dd/mm/yyy', dFechaFin);
    Preview(QRLiquidaFrutaEntradasSalidas);
  except
    FreeAndNil( QRLiquidaFrutaEntradasSalidas );
  end;
end;

end.
