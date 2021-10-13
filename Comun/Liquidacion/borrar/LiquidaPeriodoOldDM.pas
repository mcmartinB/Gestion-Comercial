unit LiquidaPeriodoOldDM;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables, TablaTemporalFOBData;

type
  TDMLiquidaPeriodoOld = class(TDataModule)
    kmtResumen: TkbmMemTable;
    kmtLiquidacion: TkbmMemTable;
    qryEntradasCos: TQuery;
    qryKilosRet: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    //Parametros de entrada
    iTipoLiquida: integer; // 0: salidas 1:escandallo 2:ajustes
    sEmpresa, sCentro, sProducto, sCosechero: string;
    dFechaIni, dFechaFin: TDateTime;
    rCosteComercial, rCosteProduccion, rCosteAdministrativo: Real;
    bDefinitiva: boolean;

    //Variables del objeto
    rKilosCosechados, rKilosPrimera, rKilosSegunda, rKilosTercera, rKilosDestrio, rKilosMerma: Real;
    RResultadosFob: TResultadosFob;
    rImporteLiquidar, rImportePrimera, rImporteSegunda, rImporteTercera, rImporteDestrio, rImporteMerma: Real;

    procedure AbrirTablas;
    procedure CerrarTablas;
    function  QueryEntradas( const ATipoLiquida: integer; var VMsg: string ): boolean;
    function  MakeTablePlantaciones: boolean;

    procedure InsertarLineaResumen;
    procedure CalculoLineaTotales;
    procedure CalculoLineaPrimera;
    procedure CalculoLineaSegunda;
    procedure CalculoLineaTercera;
    procedure CalculoLineaDestrio;
    procedure PrevisualizarResumen;

    procedure InsertarLiquidacion;
    function  InsertarLiquidacionAux( const ADesde, AHasta: TDateTime ): boolean;
    procedure InsertarLineaLiquidacion( const ADesde, AHasta: TDateTime; const AKilos: real );
    procedure PrevisualizarLiquidacion;

    function  GetKilosRet: real;
  public
    { Public declarations }

    procedure LiquidarPerido(const ATipoLiquida: integer;
                             const AEmpresa, ACentro, AProducto, ACosechero: string;
                             const ADesde, AHasta: TDateTime;
                             const AComercial, AProduccion, AAdministrativo: Real;
                             const ADefinitiva: boolean);
  end;

var
  DMLiquidaPeriodoOld: TDMLiquidaPeriodoOld;

implementation

uses
  UDMBaseDatos, bMath, LiquidaPeriodoResumenOldQR,
  LiquidaPeriodoQR, CReportes, DPreview, bTimeUtils, Variants, Dialogs;

{$R *.dfm}

var
  DMTablaTemporalFOB: TDMTablaTemporalFOB;

procedure TDMLiquidaPeriodoOld.DataModuleCreate(Sender: TObject);
begin
  kmtResumen.FieldDefs.Clear;
  kmtResumen.FieldDefs.Add('empresa', ftString, 3, False);
  kmtResumen.FieldDefs.Add('centro', ftString, 3, False);
  kmtResumen.FieldDefs.Add('producto', ftString, 3, False);
  kmtResumen.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  kmtResumen.FieldDefs.Add('fecha_fin', ftDate, 0, False);

  kmtResumen.FieldDefs.Add('kilos_in_merma', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('kilos_ret', ftFloat, 0, False);

  kmtResumen.FieldDefs.Add('kilos_in', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precio_in', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('kilos_out', ftFloat, 0, False);
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

  kmtResumen.FieldDefs.Add('kilos_in_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precio_in_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('kilos_out_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeNeto_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioNeto_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('descuento_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('gastos_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeEnvase_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeFOB_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioFOB_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeComercial_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeProduccion_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeAdminstrativo_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeLiquidar_primera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioLiquidar_primera', ftFloat, 0, False);

  kmtResumen.FieldDefs.Add('kilos_in_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precio_in_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('kilos_out_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeNeto_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioNeto_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('descuento_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('gastos_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeEnvase_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeFOB_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioFOB_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeComercial_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeProduccion_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeAdminstrativo_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeLiquidar_segunda', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioLiquidar_segunda', ftFloat, 0, False);

  kmtResumen.FieldDefs.Add('kilos_in_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precio_in_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('kilos_out_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeNeto_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioNeto_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('descuento_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('gastos_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeEnvase_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeFOB_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioFOB_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeComercial_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeProduccion_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeAdminstrativo_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeLiquidar_tercera', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioLiquidar_tercera', ftFloat, 0, False);

  kmtResumen.FieldDefs.Add('kilos_in_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precio_in_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('kilos_out_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeNeto_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioNeto_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('descuento_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('gastos_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeEnvase_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeFOB_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioFOB_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeComercial_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeProduccion_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('costeAdminstrativo_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importeLiquidar_destrio', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('precioLiquidar_destrio', ftFloat, 0, False);

  kmtResumen.CreateTable;

  kmtLiquidacion.FieldDefs.Clear;
  kmtLiquidacion.FieldDefs.Add('empresa', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('centro', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('producto', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('cosechero', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('plantacion', ftString, 3, False);
  kmtLiquidacion.FieldDefs.Add('anyosemanaplanta', ftString, 6, False);
  kmtLiquidacion.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  kmtLiquidacion.FieldDefs.Add('fecha_fin', ftDate, 0, False);


  kmtLiquidacion.FieldDefs.Add('kilos_in', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('kilos_in_primera', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('kilos_in_segunda', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('kilos_in_tercera', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('kilos_in_destrio', ftFloat, 0, False);
  kmtLiquidacion.FieldDefs.Add('kilos_in_merma', ftFloat, 0, False);

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

procedure TDMLiquidaPeriodoOld.DataModuleDestroy(
  Sender: TObject);
begin
  CerrarTablas;
end;

procedure TDMLiquidaPeriodoOld.AbrirTablas;
begin
  if kmtResumen.Active then
    kmtResumen.Close;
  kmtResumen.Open;

  if kmtLiquidacion.Active then
    kmtLiquidacion.Close;
  kmtLiquidacion.Open;
end;

procedure TDMLiquidaPeriodoOld.CerrarTablas;
begin
  kmtResumen.Close;
  kmtLiquidacion.Close;
end;

function TDMLiquidaPeriodoOld.QueryEntradas( const ATipoLiquida: integer; var VMsg: string ): boolean;
begin
  //if Result then
  begin
    rKilosCosechados:= 0;
    rKilosPrimera:= 0;
    rKilosSegunda:= 0;
    rKilosTercera:= 0;
    rKilosDestrio:= 0;
    rKilosMerma:= 0;

    qryEntradasCos.SQL.Clear;
    qryEntradasCos.SQL.Add(' select empresa_ec empresa, centro_ec centro, producto_ec producto, cosechero_e2l cosechero, ');
    qryEntradasCos.SQL.Add('         plantacion_e2l plantacion, ano_sem_planta_e2l ano_sem_planta,  ');

    if iTipoLiquida = 1 then
      qryEntradasCos.SQL.Add('         tipo_entrada_e tipo, porcen_primera_e primera, porcen_segunda_e segunda, porcen_tercera_e tercera, porcen_destrio_e destrio, 0 merma, ')
    else
    if iTipoLiquida = 2 then
      qryEntradasCos.SQL.Add('         tipo_entrada_e tipo, aporcen_primera_e primera, aporcen_segunda_e segunda, aporcen_tercera_e tercera, aporcen_destrio_e destrio, aporcen_merma_e merma, ')
    else
      qryEntradasCos.SQL.Add('         0 tipo, 100 primera, 0 segunda, 0 tercera, 0 destrio, 0 merma, ');

    qryEntradasCos.SQL.Add('         total_kgs_e2l ');

    qryEntradasCos.SQL.Add('  from frf_entradas_c ');
    qryEntradasCos.SQL.Add('       join frf_entradas2_l on empresa_e2l = empresa_ec  and centro_e2l = centro_ec ');
    qryEntradasCos.SQL.Add('                               and fecha_e2l = fecha_Ec  and numero_entrada_e2l = numero_entrada_ec ');
    if ( iTipoLiquida = 1 ) or ( iTipoLiquida = 2 ) then
    begin
      qryEntradasCos.SQL.Add('       left join frf_escandallo on empresa_e = empresa_e2l  and centro_e = centro_e2l ');
      qryEntradasCos.SQL.Add('                               and fecha_e = fecha_e2l  and numero_entrada_e = numero_entrada_e2l ');
      qryEntradasCos.SQL.Add('                               and cosechero_e = cosechero_e2l  and plantacion_e = plantacion_e2l ');
      qryEntradasCos.SQL.Add('                               and anyo_semana_e = ano_sem_planta_e2l ');
    end;

    qryEntradasCos.SQL.Add('  where empresa_ec = :empresa ');
    qryEntradasCos.SQL.Add('  and centro_ec = :centro ');
    qryEntradasCos.SQL.Add('  and producto_ec = :producto ');
    qryEntradasCos.SQL.Add('  and fecha_Ec between :fecha_ini and :fecha_fin ');

    qryEntradasCos.SQL.Add('  order by empresa, centro, producto, cosechero, plantacion, ano_sem_planta, tipo ');

    qryEntradasCos.ParamByName('empresa').AsString:= sEmpresa;
    qryEntradasCos.ParamByName('producto').AsString:= sProducto;
    qryEntradasCos.ParamByName('centro').AsString:= sCentro;
    qryEntradasCos.ParamByName('fecha_ini').AsDate:= dFechaIni;
    qryEntradasCos.ParamByName('fecha_fin').AsDate:= dFechaFin;

    qryEntradasCos.Open;
    if not qryEntradasCos.IsEmpty then
    begin
      Result:= True;
      while not qryEntradasCos.Eof and Result do
      begin
        Result:= MakeTablePlantaciones;
        //Result = False -> faltan escandallos
        qryEntradasCos.Next;
      end;
      if not Result then
        VMsg:= 'Faltan escandallos/ajustes para las entradas seleccionadas.';
    end
    else
    begin
      //No esta el escadallo grabado
      Result:= False;
      VMsg:= 'No entradas para los parametros seleccionados.';
    end;
    qryEntradasCos.Close;
  end;
end;

function TDMLiquidaPeriodoOld.MakeTablePlantaciones: boolean;
var
  rKilos, rMax, rPrimera, rSegunda, rTercera, rDestrio, rMerma: Real;
  iMax: Integer;
begin
  if bRoundTo( qryEntradasCos.FieldByName('primera').AsFloat + qryEntradasCos.FieldByName('segunda').AsFloat +
       qryEntradasCos.FieldByName('tercera').AsFloat + qryEntradasCos.FieldByName('destrio').AsFloat +
       qryEntradasCos.FieldByName('merma').AsFloat ,2) = 100 then
  begin
    //hay escandallo - ajuste
    Result:= True;

      rKilos:= qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat;
      rPrimera:= bRoundTo( rKilos * qryEntradasCos.FieldByName('primera').AsFloat / 100 ,2);
      iMax:= 1;
      rMax:=rPrimera;
      rSegunda:= bRoundTo( rKilos * qryEntradasCos.FieldByName('segunda').AsFloat / 100 ,2);
      if rMax < rSegunda then
      begin
        rMax:= rSegunda;
        iMax:= 2;
      end;
      rTercera:= bRoundTo( rKilos * qryEntradasCos.FieldByName('tercera').AsFloat / 100 ,2);
      if rMax < rTercera then
      begin
        rMax:= rTercera;
        iMax:= 3;
      end;
      rDestrio:= bRoundTo( rKilos * qryEntradasCos.FieldByName('destrio').AsFloat / 100 ,2);
      if rMax < rDestrio then
      begin
        rMax:= rDestrio;
        iMax:= 4;
      end;
      rMerma:= bRoundTo( rKilos * qryEntradasCos.FieldByName('merma').AsFloat / 100 ,2);
      if rMax < rMerma then
      begin
        iMax:= 5;
      end;

      if rKilos <> (rPrimera + rSegunda + rTercera + rDestrio + rMerma ) then
      begin
        case iMax of
          1: rPrimera:= rKilos - (rSegunda + rTercera + rDestrio + rMerma );
          2: rSegunda:= rKilos - (rPrimera + rTercera + rDestrio + rMerma );
          3: rTercera:= rKilos - (rPrimera + rSegunda + rDestrio + rMerma );
          4: rDestrio:= rKilos - (rPrimera + rSegunda + rTercera + rMerma );
          5: rMerma:= rKilos - (rPrimera + rSegunda + rTercera + rDestrio );
        end;
      end;

      rKilosCosechados:= rKilosCosechados + rKilos;
      rKilosPrimera:= rKilosPrimera + rPrimera;
      rKilosSegunda:= rKilosSegunda + rSegunda;
      rKilosTercera:= rKilosTercera + rTercera;
      rKilosDestrio:= rKilosDestrio + rDestrio;
      rKilosMerma:= rKilosMerma + rMerma;

    if kmtLiquidacion.Locate( 'empresa;centro;producto;cosechero;plantacion;anyosemanaplanta',
                              VarArrayOf([qryEntradasCos.FieldByName('empresa').AsString,
                                          qryEntradasCos.FieldByName('centro').AsString,
                                          qryEntradasCos.FieldByName('producto').AsString,
                                          qryEntradasCos.FieldByName('cosechero').AsString,
                                          qryEntradasCos.FieldByName('plantacion').AsString,
                                          qryEntradasCos.FieldByName('ano_sem_planta').AsString  ]), []) then
    begin
      kmtLiquidacion.Edit;
      kmtLiquidacion.FieldByName('kilos_in').AsFloat:= kmtLiquidacion.FieldByName('kilos_in').AsFloat + rKilos;
      kmtLiquidacion.FieldByName('kilos_in_primera').AsFloat:= kmtLiquidacion.FieldByName('kilos_in_primera').AsFloat + rPrimera;
      kmtLiquidacion.FieldByName('kilos_in_segunda').AsFloat:= kmtLiquidacion.FieldByName('kilos_in_segunda').AsFloat + rSegunda;
      kmtLiquidacion.FieldByName('kilos_in_tercera').AsFloat:= kmtLiquidacion.FieldByName('kilos_in_tercera').AsFloat + rTercera;
      kmtLiquidacion.FieldByName('kilos_in_destrio').AsFloat:= kmtLiquidacion.FieldByName('kilos_in_destrio').AsFloat + rDestrio;
      kmtLiquidacion.FieldByName('kilos_in_merma').AsFloat:= kmtLiquidacion.FieldByName('kilos_in_merma').AsFloat + rMerma;
      kmtLiquidacion.Post;
    end
    else
    begin
      kmtLiquidacion.Insert;
      kmtLiquidacion.FieldByName('empresa').AsString:= qryEntradasCos.FieldByName('empresa').AsString;
      kmtLiquidacion.FieldByName('centro').AsString:= qryEntradasCos.FieldByName('centro').AsString;
      kmtLiquidacion.FieldByName('producto').AsString:= qryEntradasCos.FieldByName('producto').AsString;
      kmtLiquidacion.FieldByName('cosechero').AsString:= qryEntradasCos.FieldByName('cosechero').AsString;
      kmtLiquidacion.FieldByName('plantacion').AsString:= qryEntradasCos.FieldByName('plantacion').AsString;
      kmtLiquidacion.FieldByName('anyosemanaplanta').AsString:= qryEntradasCos.FieldByName('ano_sem_planta').AsString;
      kmtLiquidacion.FieldByName('fecha_ini').AsDatetime:= dFechaIni;
      kmtLiquidacion.FieldByName('fecha_fin').AsDatetime:= dFechaFin;

      kmtLiquidacion.FieldByName('kilos_in').AsFloat:= rKilos;
      kmtLiquidacion.FieldByName('kilos_in_primera').AsFloat:= rPrimera;
      kmtLiquidacion.FieldByName('kilos_in_segunda').AsFloat:= rSegunda;
      kmtLiquidacion.FieldByName('kilos_in_tercera').AsFloat:= rTercera;
      kmtLiquidacion.FieldByName('kilos_in_destrio').AsFloat:= rDestrio;
      kmtLiquidacion.FieldByName('kilos_in_merma').AsFloat:= rMerma;

      kmtLiquidacion.FieldByName('precioLiquidar').AsFloat:= 0;
      kmtLiquidacion.FieldByName('importeLiquidar').AsFloat:= 0;
      kmtLiquidacion.Post;
    end;
  end
  else
  begin
    //no hay escandallo - ajuste
    Result:= False;
  end;
end;


procedure TDMLiquidaPeriodoOld.LiquidarPerido( const ATipoLiquida: integer;
                             const AEmpresa, ACentro, AProducto, ACosechero: string;
                             const ADesde, AHasta: TDateTime;
                             const AComercial, AProduccion, AAdministrativo: Real;
                             const ADefinitiva: boolean);
var
  sMsg: string;
  VPeso, VNeto, VDescuento, VGastos, VMaterial, VGeneral: Real;
begin
  itipoLiquida:=  ATipoLiquida;
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  sCosechero:= ACosechero;
  dFechaIni:= ADesde;
  dFechaFin:= AHasta;
  rCosteComercial:= AComercial;
  rCosteProduccion:= AProduccion;
  rCosteAdministrativo:= AAdministrativo;
  bDefinitiva:= ADefinitiva;

  AbrirTablas;
  sMsg:= '';
  if QueryEntradas( ATipoLiquida, sMsg ) then
  begin
    DMTablaTemporalFOB:= TDMTablaTemporalFOB.Create( self );
    try
          with DMTablaTemporalFOB do
          begin
            sAEmpresa:= sEmpresa;
            iAProductoPropio:= -1;
            sACentroOrigen:= sCentro;
            sACentroSalida:= '';
            sACliente:= '';
            iAClienteFac:= -1;     // 1 -> facturable 2 -> no facturable resto -> todos
            sAPais:= '';
            sAALbaran:= '';
            bAAlb6Digitos:= False;    // true -> como minimo seis digitos (almacen) false -> todos
            iAAlbFacturado:= -1;   // 1 -> facturado  0 -> no facturado  resto -> todos
            bAManuales:= True;
            bASoloManuales:= False;
            sAFechaDesde:= FormatDateTime('dd/mm/yyyy',ADesde);
            sAFEchaHasta:= FormatDateTime('dd/mm/yyyy',AHasta);
            bAFechaSalida:= True;    // true -> rango fecha salidas false -> rango fecha facturas (solo facturados)
            sAProducto:= sProducto;
            iAEsTomate:= -1;       // 1 -> tomate 2 -> no tomate resto -> todos
            sAEnvase:= '';
            sACategoria:= '';
            bACatComerciales:= True; // true 050 -> 1,2,3 RESTO -> no RET, 0XX         false -> todos
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


          DMTablaTemporalFOB.ImportesFOB( VPeso, VNeto, VDescuento, VGastos, VMaterial, VGeneral, RResultadosFob );
     finally
      FreeAndNil( DMTablaTemporalFOB );
    end;

    InsertarLineaResumen;
    //InsertarLiquidacion;

      PrevisualizarResumen;
  //PrevisualizarLiquidacion;
  end
  else
  begin
    ShowMessage(sMsg);
  end;
end;

function TDMLiquidaPeriodoOld.GetKilosRet: real;
begin
  qryKilosRet.ParamByName('empresa').AsString:= sEmpresa;
  qryKilosRet.ParamByName('producto').AsString:= sProducto;
  qryKilosRet.ParamByName('centro').AsString:= sCentro;
  qryKilosRet.ParamByName('fechaini').AsDateTime:= dFechaIni;
  qryKilosRet.ParamByName('fechafin').AsDateTime:= dFechaFin;
  qryKilosRet.Open;
  Result:= qryKilosRet.FieldByName('kilos').AsFloat;
  qryKilosRet.Close;
end;

procedure TDMLiquidaPeriodoOld.CalculoLineaTotales;
var
  rImporteOtros, rAux, rKilosComer: Real;
begin
  kmtResumen.FieldByName('kilos_in').AsFloat:= rKilosCosechados;
  kmtResumen.FieldByName('kilos_out').AsFloat:= RResultadosFob.rPeso;

  kmtResumen.FieldByName('importeNeto').AsFloat:= RResultadosFob.rNeto;
  kmtResumen.FieldByName('descuento').AsFloat:= RResultadosFob.rDescuento;
  kmtResumen.FieldByName('gastos').AsFloat:= RResultadosFob.rGastos;
  kmtResumen.FieldByName('costeEnvase').AsFloat:= RResultadosFob.rCosteEnvase + RResultadosFob.rCosteSecciones;
  kmtResumen.FieldByName('importeFOB').AsFloat:= RResultadosFob.rNeto - ( RResultadosFob.rDescuento + RResultadosFob.rGastos + RResultadosFob.rCosteEnvase + RResultadosFob.rCosteSecciones );


  rKilosComer:=  RResultadosFob.rPeso - kmtResumen.FieldByName('kilos_ret').AsFloat;
  if rKilosComer < 0 then
    rKilosComer:= 0;

  rAux:= bRoundto( rCosteComercial * rKilosComer, 2 );
  rImporteOtros:= rAux;
  kmtResumen.FieldByName('costeComercial').AsFloat:= rAux;
  rAux:= bRoundto( rCosteProduccion * rKilosComer, 2 );
  rImporteOtros:= rImporteOtros + rAux;
  kmtResumen.FieldByName('costeProduccion').AsFloat:= rAux;
  rAux:=  bRoundto( rCosteAdministrativo * rKilosComer, 2 );
  rImporteOtros:= rImporteOtros + rAux;
  kmtResumen.FieldByName('costeAdminstrativo').AsFloat:= rAux;

  rAux:= RResultadosFob.rDescuento + RResultadosFob.rGastos + RResultadosFob.rCosteEnvase + RResultadosFob.rCosteSecciones;
  rImporteLiquidar:= RResultadosFob.rNeto - ( rAux  + rImporteOtros );
  kmtResumen.FieldByName('importeLiquidar').AsFloat:= rImporteLiquidar;

  if RResultadosFob.rPeso > 0 then
  begin
    kmtResumen.FieldByName('precioNeto').AsFloat:= bRoundTo( RResultadosFob.rNeto/RResultadosFob.rPeso, 9 );
    kmtResumen.FieldByName('precioFOB').AsFloat:= bRoundTo( ( RResultadosFob.rNeto - ( rAux ) ) / RResultadosFob.rPeso, 9);
    kmtResumen.FieldByName('precioLiquidar').AsFloat:= bRoundTo( ( RResultadosFob.rNeto - ( rAux + rImporteOtros ) ) / RResultadosFob.rPeso, 9);
  end
  else
  begin
    kmtResumen.FieldByName('precioNeto').AsFloat:= 0;
    kmtResumen.FieldByName('precioFOB').AsFloat:= 0;
    kmtResumen.FieldByName('precioLiquidar').AsFloat:= 0;
  end;

  if rKilosCosechados <> 0 then
    kmtResumen.FieldByName('precio_in').AsFloat:= bRoundTo( rImporteLiquidar / rKilosCosechados, 9 )
  else
    kmtResumen.FieldByName('precio_in').AsFloat:= 0;
end;

procedure TDMLiquidaPeriodoOld.CalculoLineaPrimera;
var
  rImporteOtros, rAux, rKilosComer: Real;
begin
  kmtResumen.FieldByName('kilos_in_primera').AsFloat:= rKilosPrimera;
  kmtResumen.FieldByName('kilos_out_primera').AsFloat:= RResultadosFob.rPesoPrimera;

  kmtResumen.FieldByName('importeNeto_primera').AsFloat:= RResultadosFob.rNetoPrimera;
  kmtResumen.FieldByName('descuento_primera').AsFloat:= RResultadosFob.rDescuentoPrimera;
  kmtResumen.FieldByName('gastos_primera').AsFloat:= RResultadosFob.rGastosPrimera;
  kmtResumen.FieldByName('costeEnvase_primera').AsFloat:= RResultadosFob.rEnvasePrimera + RResultadosFob.rSeccionesPrimera;


  rKilosComer:=  RResultadosFob.rPesoPrimera;
  if rKilosComer < 0 then
    rKilosComer:= 0;

  rAux:= bRoundto( rCosteComercial * rKilosComer, 2 );
  rImporteOtros:= rAux;
  kmtResumen.FieldByName('costeComercial_primera').AsFloat:= rAux;
  rAux:= bRoundto( rCosteProduccion * rKilosComer, 2 );
  rImporteOtros:= rImporteOtros + rAux;
  kmtResumen.FieldByName('costeProduccion_primera').AsFloat:= rAux;
  rAux:=  bRoundto( rCosteAdministrativo * rKilosComer, 2 );
  rImporteOtros:= rImporteOtros + rAux;
  kmtResumen.FieldByName('costeAdminstrativo_primera').AsFloat:= rAux;

  rAux:= RResultadosFob.rDescuentoPrimera + RResultadosFob.rGastosPrimera + RResultadosFob.rEnvasePrimera + RResultadosFob.rSeccionesPrimera;

  kmtResumen.FieldByName('importeFOB_primera').AsFloat:= RResultadosFob.rNeto - ( rAux );
  rImportePrimera:= RResultadosFob.rNetoPrimera - ( rAux  + rImporteOtros );
  kmtResumen.FieldByName('importeLiquidar_primera').AsFloat:= rImportePrimera;


  if RResultadosFob.rPesoPrimera > 0 then
  begin
    kmtResumen.FieldByName('precioNeto_primera').AsFloat:= bRoundTo( RResultadosFob.rNetoPrimera / RResultadosFob.rPesoPrimera, 9 );
    kmtResumen.FieldByName('precioFOB_primera').AsFloat:= bRoundTo( kmtResumen.FieldByName('importeFOB_primera').AsFloat / RResultadosFob.rPesoPrimera, 9);
    kmtResumen.FieldByName('precioLiquidar_primera').AsFloat:= bRoundTo( rImportePrimera / RResultadosFob.rPesoPrimera, 9);
  end
  else
  begin
    kmtResumen.FieldByName('precioNeto_primera').AsFloat:= 0;
    kmtResumen.FieldByName('precioFOB_primera').AsFloat:= 0;
    kmtResumen.FieldByName('precioLiquidar_primera').AsFloat:= 0;
  end;

  if rKilosPrimera <> 0 then
    kmtResumen.FieldByName('precio_in_primera').AsFloat:= bRoundTo( rImportePrimera / rKilosPrimera, 9 )
  else
    kmtResumen.FieldByName('precio_in_primera').AsFloat:= 0;
end;

procedure TDMLiquidaPeriodoOld.CalculoLineaSegunda;
var
  rImporteOtros, rAux, rKilosComer: Real;
begin
  kmtResumen.FieldByName('kilos_in_segunda').AsFloat:= rKilossegunda;
  kmtResumen.FieldByName('kilos_out_segunda').AsFloat:= RResultadosFob.rPesosegunda;

  kmtResumen.FieldByName('importeNeto_segunda').AsFloat:= RResultadosFob.rNetosegunda;
  kmtResumen.FieldByName('descuento_segunda').AsFloat:= RResultadosFob.rDescuentosegunda;
  kmtResumen.FieldByName('gastos_segunda').AsFloat:= RResultadosFob.rGastossegunda;
  kmtResumen.FieldByName('costeEnvase_segunda').AsFloat:= RResultadosFob.rEnvasesegunda + RResultadosFob.rSeccionessegunda;


  rKilosComer:=  RResultadosFob.rPesosegunda;
  if rKilosComer < 0 then
    rKilosComer:= 0;

  rAux:= bRoundto( rCosteComercial * rKilosComer, 2 );
  rImporteOtros:= rAux;
  kmtResumen.FieldByName('costeComercial_segunda').AsFloat:= rAux;
  rAux:= bRoundto( rCosteProduccion * rKilosComer, 2 );
  rImporteOtros:= rImporteOtros + rAux;
  kmtResumen.FieldByName('costeProduccion_segunda').AsFloat:= rAux;
  rAux:=  bRoundto( rCosteAdministrativo * rKilosComer, 2 );
  rImporteOtros:= rImporteOtros + rAux;
  kmtResumen.FieldByName('costeAdminstrativo_segunda').AsFloat:= rAux;

  rAux:= RResultadosFob.rDescuentosegunda + RResultadosFob.rGastossegunda + RResultadosFob.rEnvasesegunda + RResultadosFob.rSeccionessegunda;

  kmtResumen.FieldByName('importeFOB_segunda').AsFloat:= RResultadosFob.rNeto - ( rAux );
  rImportesegunda:= RResultadosFob.rNetosegunda - ( rAux  + rImporteOtros );
  kmtResumen.FieldByName('importeLiquidar_segunda').AsFloat:= rImportesegunda;


  if RResultadosFob.rPesosegunda > 0 then
  begin
    kmtResumen.FieldByName('precioNeto_segunda').AsFloat:= bRoundTo( RResultadosFob.rNetosegunda / RResultadosFob.rPesosegunda, 9 );
    kmtResumen.FieldByName('precioFOB_segunda').AsFloat:= bRoundTo( kmtResumen.FieldByName('importeFOB_segunda').AsFloat / RResultadosFob.rPesosegunda, 9);
    kmtResumen.FieldByName('precioLiquidar_segunda').AsFloat:= bRoundTo( rImportesegunda / RResultadosFob.rPesosegunda, 9);
  end
  else
  begin
    kmtResumen.FieldByName('precioNeto_segunda').AsFloat:= 0;
    kmtResumen.FieldByName('precioFOB_segunda').AsFloat:= 0;
    kmtResumen.FieldByName('precioLiquidar_segunda').AsFloat:= 0;
  end;

  if rKilossegunda <> 0 then
    kmtResumen.FieldByName('precio_in_segunda').AsFloat:= bRoundTo( rImportesegunda / rKilossegunda, 9 )
  else
    kmtResumen.FieldByName('precio_in_segunda').AsFloat:= 0;
end;

procedure TDMLiquidaPeriodoOld.CalculoLineaTercera;
var
  rImporteOtros, rAux, rKilosComer: Real;
begin
  kmtResumen.FieldByName('kilos_in_tercera').AsFloat:= rKilostercera;
  kmtResumen.FieldByName('kilos_out_tercera').AsFloat:= RResultadosFob.rPesotercera;

  kmtResumen.FieldByName('importeNeto_tercera').AsFloat:= RResultadosFob.rNetotercera;
  kmtResumen.FieldByName('descuento_tercera').AsFloat:= RResultadosFob.rDescuentotercera;
  kmtResumen.FieldByName('gastos_tercera').AsFloat:= RResultadosFob.rGastostercera;
  kmtResumen.FieldByName('costeEnvase_tercera').AsFloat:= RResultadosFob.rEnvasetercera + RResultadosFob.rSeccionestercera;


  rKilosComer:=  RResultadosFob.rPesotercera;
  if rKilosComer < 0 then
    rKilosComer:= 0;

  rAux:= bRoundto( rCosteComercial * rKilosComer, 2 );
  rImporteOtros:= rAux;
  kmtResumen.FieldByName('costeComercial_tercera').AsFloat:= rAux;
  rAux:= bRoundto( rCosteProduccion * rKilosComer, 2 );
  rImporteOtros:= rImporteOtros + rAux;
  kmtResumen.FieldByName('costeProduccion_tercera').AsFloat:= rAux;
  rAux:=  bRoundto( rCosteAdministrativo * rKilosComer, 2 );
  rImporteOtros:= rImporteOtros + rAux;
  kmtResumen.FieldByName('costeAdminstrativo_tercera').AsFloat:= rAux;

  rAux:= RResultadosFob.rDescuentotercera + RResultadosFob.rGastostercera + RResultadosFob.rEnvasetercera + RResultadosFob.rSeccionestercera;

  kmtResumen.FieldByName('importeFOB_tercera').AsFloat:= RResultadosFob.rNeto - ( rAux );
  rImportetercera:= RResultadosFob.rNetotercera - ( rAux  + rImporteOtros );
  kmtResumen.FieldByName('importeLiquidar_tercera').AsFloat:= rImportetercera;


  if RResultadosFob.rPesotercera > 0 then
  begin
    kmtResumen.FieldByName('precioNeto_tercera').AsFloat:= bRoundTo( RResultadosFob.rNetotercera / RResultadosFob.rPesotercera, 9 );
    kmtResumen.FieldByName('precioFOB_tercera').AsFloat:= bRoundTo( kmtResumen.FieldByName('importeFOB_tercera').AsFloat / RResultadosFob.rPesotercera, 9);
    kmtResumen.FieldByName('precioLiquidar_tercera').AsFloat:= bRoundTo( rImportetercera / RResultadosFob.rPesotercera, 9);
  end
  else
  begin
    kmtResumen.FieldByName('precioNeto_tercera').AsFloat:= 0;
    kmtResumen.FieldByName('precioFOB_tercera').AsFloat:= 0;
    kmtResumen.FieldByName('precioLiquidar_tercera').AsFloat:= 0;
  end;

  if rKilostercera <> 0 then
    kmtResumen.FieldByName('precio_in_tercera').AsFloat:= bRoundTo( rImportetercera / rKilostercera, 9 )
  else
    kmtResumen.FieldByName('precio_in_tercera').AsFloat:= 0;
end;

procedure TDMLiquidaPeriodoOld.CalculoLineaDestrio;
var
  rImporteOtros, rAux, rKilosComer: Real;
begin
  kmtResumen.FieldByName('kilos_in_destrio').AsFloat:= rKilosdestrio;
  kmtResumen.FieldByName('kilos_out_destrio').AsFloat:= RResultadosFob.rPesodestrio;

  kmtResumen.FieldByName('importeNeto_destrio').AsFloat:= RResultadosFob.rNetodestrio;
  kmtResumen.FieldByName('descuento_destrio').AsFloat:= RResultadosFob.rDescuentodestrio;
  kmtResumen.FieldByName('gastos_destrio').AsFloat:= RResultadosFob.rGastosdestrio;
  kmtResumen.FieldByName('costeEnvase_destrio').AsFloat:= RResultadosFob.rEnvasedestrio + RResultadosFob.rSeccionesdestrio;


  rKilosComer:=  RResultadosFob.rPesodestrio;
  if rKilosComer < 0 then
    rKilosComer:= 0;

  rAux:= bRoundto( rCosteComercial * rKilosComer, 2 );
  rImporteOtros:= rAux;
  kmtResumen.FieldByName('costeComercial_destrio').AsFloat:= rAux;
  rAux:= bRoundto( rCosteProduccion * rKilosComer, 2 );
  rImporteOtros:= rImporteOtros + rAux;
  kmtResumen.FieldByName('costeProduccion_destrio').AsFloat:= rAux;
  rAux:=  bRoundto( rCosteAdministrativo * rKilosComer, 2 );
  rImporteOtros:= rImporteOtros + rAux;
  kmtResumen.FieldByName('costeAdminstrativo_destrio').AsFloat:= rAux;

  rAux:= RResultadosFob.rDescuentodestrio + RResultadosFob.rGastosdestrio + RResultadosFob.rEnvasedestrio + RResultadosFob.rSeccionesdestrio;

  kmtResumen.FieldByName('importeFOB_destrio').AsFloat:= RResultadosFob.rNeto - ( rAux );
  rImportedestrio:= RResultadosFob.rNetodestrio - ( rAux  + rImporteOtros );
  kmtResumen.FieldByName('importeLiquidar_destrio').AsFloat:= rImportedestrio;


  if RResultadosFob.rPesodestrio > 0 then
  begin
    kmtResumen.FieldByName('precioNeto_destrio').AsFloat:= bRoundTo( RResultadosFob.rNetodestrio / RResultadosFob.rPesodestrio, 9 );
    kmtResumen.FieldByName('precioFOB_destrio').AsFloat:= bRoundTo( kmtResumen.FieldByName('importeFOB_destrio').AsFloat / RResultadosFob.rPesodestrio, 9);
    kmtResumen.FieldByName('precioLiquidar_destrio').AsFloat:= bRoundTo( rImportedestrio / RResultadosFob.rPesodestrio, 9);
  end
  else
  begin
    kmtResumen.FieldByName('precioNeto_destrio').AsFloat:= 0;
    kmtResumen.FieldByName('precioFOB_destrio').AsFloat:= 0;
    kmtResumen.FieldByName('precioLiquidar_destrio').AsFloat:= 0;
  end;

  if rKilosdestrio <> 0 then
    kmtResumen.FieldByName('precio_in_destrio').AsFloat:= bRoundTo( rImportedestrio / rKilosdestrio, 9 )
  else
    kmtResumen.FieldByName('precio_in_destrio').AsFloat:= 0;
end;


procedure TDMLiquidaPeriodoOld.InsertarLineaResumen;
begin
  kmtResumen.Insert;
  kmtResumen.FieldByName('empresa').AsString:= sEmpresa;
  kmtResumen.FieldByName('centro').AsString:= sCentro;
  kmtResumen.FieldByName('producto').AsString:= sProducto;
  kmtResumen.FieldByName('fecha_ini').AsDateTime:= dFechaIni;
  kmtResumen.FieldByName('fecha_fin').AsDateTime:= dFechaFin;

  //NO USAR PARA EL TOMATE
  kmtResumen.FieldByName('kilos_ret').AsFloat:= GetKilosRet;

  CalculoLineaTotales;
  CalculoLineaPrimera;
  CalculoLineaSegunda;
  CalculoLineaTercera;
  CalculoLineaDestrio;

  kmtResumen.Post;
end;

procedure TDMLiquidaPeriodoOld.PrevisualizarResumen;
begin
  QRLiquidaPeriodoResumenOld:= TQRLiquidaPeriodoResumenOld.Create(Self);
  PonLogoGrupoBonnysa(QRLiquidaPeriodoResumenOld);
  try
    kmtResumen.SortFields:= 'fecha_ini';
    kmtResumen.Sort([]);
    kmtResumen.First;
    QRLiquidaPeriodoResumenOld.qrlblPeriodo.Caption:= 'Periodo del ' +
      FormatDateTime('dd/mm/yyy', dFechaIni) + ' al ' + FormatDateTime('dd/mm/yyy', dFechaFin);
    Preview(QRLiquidaPeriodoResumenOld);
  except
    FreeAndNil( QRLiquidaPeriodoResumenOld );
  end;
end;

procedure TDMLiquidaPeriodoOld.InsertarLiquidacion;
begin
  InsertarLiquidacionAux( dFechaIni, dFechaFin );
  (*
  if not InsertarLiquidacionAux( dDesde ) then
  begin
    dLunesAux:= dLunes - 7;
    dDomingoAux:= dDomingo - 7;
    bFlag:= False;
    //Hacia atras en el tiempo
    while ( dLunesAux >= dFechaIni ) and not bFlag  do
    begin
      bFlag:= InsertarLiquidacionAux( dLunesAux );
      dLunesAux:= dLunesAux - 7;
      dDomingoAux:= dDomingoAux - 7;
    end;
    //Sino hacia adelante
    if not bFlag then
    begin
      dLunesAux:= dLunes + 7;
      dDomingoAux:= dDomingo + 7;
      //Hacia adelante en el tiempo
      while ( dDomingoAux <= dFechaFin ) and not bFlag  do
      begin
        bFlag:= InsertarLiquidacionAux( dLunesAux );
        dLunesAux:= dLunesAux + 7;
        dDomingoAux:= dDomingoAux + 7;
      end;
    end;
  end;
  *)
end;

function TDMLiquidaPeriodoOld.InsertarLiquidacionAux( const ADesde, AHasta: TDateTime ): boolean;
var
  rKilos: real;
begin
  qryEntradasCos.ParamByName('fecha_ini').AsDate:= ADesde;
  qryEntradasCos.ParamByName('fecha_fin').AsDate:= AHasta;
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
        InsertarLineaLiquidacion( ADesde, AHasta, rKilos );
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

procedure TDMLiquidaPeriodoOld.InsertarLineaLiquidacion( const ADesde, AHasta: TDateTime; const AKilos: real );
var
  rKilosAux, rImporteAux, rPrecioAux: Real;
begin
  if kmtLiquidacion.Locate('empresa;centro;producto;fecha_ini;cosechero;anyosemanaplanta;plantacion',
                           vararrayof([sEmpresa,sCentro,sProducto,ADesde,
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

    kmtLiquidacion.FieldByName('cosechero').AsString:= qryEntradasCos.FieldByName('cosechero').AsString;
    kmtLiquidacion.FieldByName('anyosemanaplanta').AsString:= qryEntradasCos.FieldByName('ano_sem_planta').AsString;
    kmtLiquidacion.FieldByName('plantacion').AsString:= qryEntradasCos.FieldByName('plantacion').AsString;

    kmtLiquidacion.FieldByName('fecha_ini').AsDateTime:= ADesde;
    kmtLiquidacion.FieldByName('fecha_fin').AsDateTime:= AHasta;

    rKilosAux:= qryEntradasCos.FieldByName('kilos').AsFloat;
    kmtLiquidacion.FieldByName('kilos_in').AsFloat:= rKilosAux;

    rPrecioAux:= bRoundTo( rImporteLiquidar / AKilos, 9 );
    kmtLiquidacion.FieldByName('precioLiquidar').AsFloat:= rPrecioAux;

    rImporteAux:= bRoundTo( rKilosAux * rPrecioAux, 2);
    kmtLiquidacion.FieldByName('importeLiquidar').AsFloat:= rImporteAux;
    kmtLiquidacion.Post;
  end;
end;

procedure TDMLiquidaPeriodoOld.PrevisualizarLiquidacion;
begin
  QRLiquidaPeriodo:= TQRLiquidaPeriodo.Create(Self);
  PonLogoGrupoBonnysa(QRLiquidaPeriodo);
  try
    kmtLiquidacion.SortFields:= 'cosechero;plantacion;anyosemanaplanta;fecha_ini';
    kmtLiquidacion.Sort([]);
    kmtLiquidacion.First;
    QRLiquidaPeriodo.qrlblPeriodo.Caption:= 'Periodo del ' +
      FormatDateTime('dd/mm/yyy', dFechaIni) + ' al ' + FormatDateTime('dd/mm/yyy', dFechaFin);
    Preview(QRLiquidaPeriodo);
  except
    FreeAndNil( QRLiquidaPeriodo );
  end;
end;

end.
