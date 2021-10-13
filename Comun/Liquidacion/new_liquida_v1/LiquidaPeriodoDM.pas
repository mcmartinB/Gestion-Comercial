unit LiquidaPeriodoDM;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable, StdCtrls;

type
  TDMLiquidaPeriodo = class(TDataModule)
    kmtSemana: TkbmMemTable;
    kmtCosechero: TkbmMemTable;
    kmtPlantacion: TkbmMemTable;
    dsSemana: TDataSource;
    dsCosechero: TDataSource;
    kmtVentas: TkbmMemTable;
    kmtInventarios: TkbmMemTable;
    kmtTransitosIn: TkbmMemTable;
    kmtTransitosOut: TkbmMemTable;
    kmtEntradas: TkbmMemTable;
    qryCentros: TQuery;
    qryProductoBase: TQuery;
    kmtCentros: TkbmMemTable;
    kmtAux: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    sWarnig, sError: string;

    { Private declarations }
    //Parametros de entrada
    sEmpresa, sCentro, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;
    rCosteComercial, rCosteProduccion, rCosteAdministrativo: Real;
    bDefinitiva: boolean;

    rbruto_total, rneto_total, rbruto_pri, rneto_pri, rbruto_seg, rneto_seg: real;
    rbruto_ter, rneto_ter, rbruto_des, rneto_des: real;
    rliquida_total, rliquida_pri, rliquida_seg, rliquida_ter, rliquida_des:Real;


    procedure AltaSemana( const AKey, ASemana: string );
    procedure ValorarEntradas;
    procedure ReparteImportes;
    procedure RellenaImportes;
    procedure ImportesPlantacion;
    procedure LimpiaCosechero;
    procedure AcumulaCosechero;
    procedure ImportesCosechero;

  public
    { Public declarations }
    procedure AbrirTablas;
    procedure AddWarning( const AMsg: string );
    procedure AddError( const AMsg: string );

    procedure LiquidarPerido(const AEmpresa, AProducto: string;
                             const ADesde, AHasta: TDateTime;
                             const AComercial, AProduccion, AAdministrativo: Real;
                             const ADefinitiva: boolean; var VLabel: TLabel);
  end;



var
  DMLiquidaPeriodo: TDMLiquidaPeriodo;

implementation

{$R *.dfm}

uses
  bMath, bTimeUtils, LiquidaPeriodoEntradasDM, LiquidaPeriodoVentasDM,
  LiquidaPeriodoInventariosDM, LiquidaPeriodoTransitosDM, Forms,
  LiquidaPeriodoBDDatosDM;

procedure TDMLiquidaPeriodo.AddWarning( const AMsg: string );
begin
  if sWarnig <> '' then
    sWarnig := sWarnig + #13 + #10 + AMsg
  else
    sWarnig := AMsg;
end;


procedure TDMLiquidaPeriodo.AddError( const AMsg: string );
begin
  if sError <> '' then
    sError := sError + #13 + #10 + AMsg
  else
    sError := AMsg;
end;

procedure TDMLiquidaPeriodo.DataModuleDestroy(Sender: TObject);
begin
  kmtPlantacion.Close;
  kmtCosechero.Close;
  kmtVentas.Close;
  kmtInventarios.Close;
  kmtTransitosIn.Close;
  kmtTransitosOut.Close;
  kmtEntradas.Close;
  kmtSemana.Close;
  kmtCentros.Close;
  kmtAux.Close;
  FreeAndNil( DMLiquidaPeriodoEntradas );
  FreeAndNil( DMLiquidaPeriodoTransitos );
  FreeAndNil( DMLiquidaPeriodoVentas );
  FreeAndNil( DMLiquidaPeriodoInventarios );

end;

procedure TDMLiquidaPeriodo.DataModuleCreate(Sender: TObject);
begin
  with qryCentros do
  begin
    Sql.Clear;
    SQL.Add('select empresa_ec, centro_Ec ');
    SQL.Add('from frf_entradas_c ');
    SQL.Add('where empresa_Ec = :empresa ');
    SQL.Add('and fecha_ec between :fechaini and :fechafin ');
    SQL.Add('and producto_ec = :producto ');
    SQL.Add('group by  empresa_ec, centro_ec ');
    SQL.Add('order by  empresa_ec, centro_ec ');
  end;

  kmtAux.FieldDefs.Clear;
  kmtAux.FieldDefs.Add('keySem', ftString, 15, False);
  kmtAux.FieldDefs.Add('precio_Pri', ftFloat, 0, False);
  kmtAux.FieldDefs.Add('precio_Seg', ftFloat, 0, False);
  kmtAux.FieldDefs.Add('precio_Ter', ftFloat, 0, False);
  kmtAux.FieldDefs.Add('precio_Des', ftFloat, 0, False);
  kmtAux.IndexFieldNames:= 'keySem';
  kmtAux.CreateTable;

  kmtCentros.FieldDefs.Clear;
  kmtCentros.FieldDefs.Add('keySem', ftString, 15, False);
  kmtCentros.IndexFieldNames:= 'keySem';
  kmtCentros.CreateTable;

  kmtSemana.FieldDefs.Clear;
  kmtSemana.FieldDefs.Add('keySem', ftString, 15, False);
  kmtSemana.FieldDefs.Add('empresa', ftString, 3, False);
  kmtSemana.FieldDefs.Add('centro', ftString, 3, False);
  kmtSemana.FieldDefs.Add('producto', ftString, 3, False);
  kmtSemana.FieldDefs.Add('semana', ftString, 6, False);
  kmtSemana.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  kmtSemana.FieldDefs.Add('fecha_fin', ftDate, 0, False);

  kmtSemana.FieldDefs.Add('precio_coste_comercial', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('precio_coste_produccion', ftFloat, 0, False);
  kmtSemana.FieldDefs.Add('precio_coste_administracion', ftFloat, 0, False);

  kmtSemana.IndexFieldNames:= 'keySem';
  kmtSemana.CreateTable;

  kmtEntradas.FieldDefs.Clear;
  kmtEntradas.FieldDefs.Add('keySem', ftString, 15, False);

  kmtEntradas.FieldDefs.Add('kilos_ini_total', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_ini_pri', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_ini_seg', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_ini_ter', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_ini_des', ftFloat, 0, False);

  kmtEntradas.FieldDefs.Add('kilos_total', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_pri', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_seg', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_ter', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_des', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('kilos_mer', ftFloat, 0, False);

  kmtEntradas.FieldDefs.Add('bruto_total', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('bruto_Pri', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('bruto_Seg', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('bruto_Ter', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('bruto_Des', ftFloat, 0, False);

  kmtEntradas.FieldDefs.Add('coste_total', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('coste_Pri', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('coste_Seg', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('coste_Ter', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('coste_Des', ftFloat, 0, False);

  kmtEntradas.FieldDefs.Add('neto_total', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('neto_Pri', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('neto_Seg', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('neto_Ter', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('neto_Des', ftFloat, 0, False);

  kmtEntradas.FieldDefs.Add('liquida_total', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('liquida_Pri', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('liquida_Seg', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('liquida_Ter', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('liquida_Des', ftFloat, 0, False);

  kmtEntradas.FieldDefs.Add('precio_liquida_total', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('precio_liquida_Pri', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('precio_liquida_Seg', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('precio_liquida_Ter', ftFloat, 0, False);
  kmtEntradas.FieldDefs.Add('precio_liquida_Des', ftFloat, 0, False);

  kmtEntradas.IndexFieldNames:= 'keySem';
  kmtEntradas.MasterSource:= dsSemana;
  kmtEntradas.MasterFields:= 'keySem';
  kmtEntradas.DetailFields:= 'keySem';
  kmtEntradas.CreateTable;


  kmtInventarios.FieldDefs.Clear;
  kmtInventarios.FieldDefs.Add('keySem', ftString, 15, False);

  kmtInventarios.FieldDefs.Add('fecha_ini', ftDateTime, 0, False);
  kmtInventarios.FieldDefs.Add('kilos_ini', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('kilos_ini_pri', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('kilos_ini_seg', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('kilos_ini_ter', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('kilos_ini_des', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('neto_ini', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('neto_ini_pri', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('neto_ini_seg', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('neto_ini_ter', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('neto_ini_des', ftFloat, 0, False);

  kmtInventarios.FieldDefs.Add('fecha_fin', ftDateTime, 0, False);
  kmtInventarios.FieldDefs.Add('kilos_fin', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('kilos_fin_pri', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('kilos_fin_seg', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('kilos_fin_ter', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('kilos_fin_des', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('neto_fin', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('neto_fin_pri', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('neto_fin_seg', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('neto_fin_ter', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('neto_fin_des', ftFloat, 0, False);

  kmtInventarios.FieldDefs.Add('ajuste', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('ajuste_pri', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('ajuste_seg', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('ajuste_ter', ftFloat, 0, False);
  kmtInventarios.FieldDefs.Add('ajuste_des', ftFloat, 0, False);

  kmtInventarios.IndexFieldNames:= 'keySem';
  kmtInventarios.MasterSource:= dsSemana;
  kmtInventarios.MasterFields:= 'keySem';
  kmtInventarios.DetailFields:= 'keySem';
  kmtInventarios.CreateTable;


  kmtTransitosIn.FieldDefs.Clear;
  kmtTransitosIn.FieldDefs.Add('keySem', ftString, 15, False);
  kmtTransitosIn.FieldDefs.Add('origen', ftString, 3, False);
  kmtTransitosIn.FieldDefs.Add('kilos_total', ftFloat, 0, False);
  kmtTransitosIn.FieldDefs.Add('kilos_pri', ftFloat, 0, False);
  kmtTransitosIn.FieldDefs.Add('kilos_seg', ftFloat, 0, False);
  kmtTransitosIn.FieldDefs.Add('kilos_ter', ftFloat, 0, False);
  kmtTransitosIn.FieldDefs.Add('kilos_des', ftFloat, 0, False);

  kmtTransitosIn.FieldDefs.Add('importe_total', ftFloat, 0, False);
  kmtTransitosIn.FieldDefs.Add('importe_pri', ftFloat, 0, False);
  kmtTransitosIn.FieldDefs.Add('importe_seg', ftFloat, 0, False);
  kmtTransitosIn.FieldDefs.Add('importe_ter', ftFloat, 0, False);
  kmtTransitosIn.FieldDefs.Add('importe_des', ftFloat, 0, False);

  kmtTransitosIn.IndexFieldNames:= 'keySem';
  kmtTransitosIn.MasterSource:= dsSemana;
  kmtTransitosIn.MasterFields:= 'keySem';
  kmtTransitosIn.DetailFields:= 'keySem';
  kmtTransitosIn.CreateTable;

  kmtTransitosOut.FieldDefs.Clear;
  kmtTransitosOut.FieldDefs.Add('keySem', ftString, 15, False);
  kmtTransitosOut.FieldDefs.Add('destino', ftString, 3, False);
  kmtTransitosOut.FieldDefs.Add('kilos_total', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('kilos_pri', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('kilos_seg', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('kilos_ter', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('kilos_des', ftFloat, 0, False);

  kmtTransitosOut.FieldDefs.Add('coste_total', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('coste_pri', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('coste_seg', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('coste_ter', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('coste_des', ftFloat, 0, False);

  kmtTransitosOut.FieldDefs.Add('importe_total', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('importe_pri', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('importe_seg', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('importe_ter', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('importe_des', ftFloat, 0, False);

  kmtTransitosOut.FieldDefs.Add('gastos_total', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('gastos_Pri', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('gastos_Seg', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('gastos_Ter', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('gastos_Des', ftFloat, 0, False);

  kmtTransitosOut.FieldDefs.Add('neto_total', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('neto_Pri', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('neto_Seg', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('neto_Ter', ftFloat, 0, False);
  kmtTransitosOut.FieldDefs.Add('neto_Des', ftFloat, 0, False);

  kmtTransitosOut.IndexFieldNames:= 'keySem';
  kmtTransitosOut.MasterSource:= dsSemana;
  kmtTransitosOut.MasterFields:= 'keySem';
  kmtTransitosOut.DetailFields:= 'keySem';
  kmtTransitosOut.CreateTable;

  kmtVentas.FieldDefs.Clear;
  kmtVentas.FieldDefs.Add('keySem', ftString, 15, False);
  kmtVentas.FieldDefs.Add('kilos_Sal', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('bruto_Sal', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('descuento_Sal', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('gastos_Sal', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeEnvase_Sal', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeSecciones_Sal', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('neto_Sal', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('precio_Sal', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeGeneral_Sal', ftFloat, 0, False);

  kmtVentas.FieldDefs.Add('kilos_Pri', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('bruto_Pri', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('descuento_Pri', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('gastos_Pri', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeEnvase_Pri', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeSecciones_Pri', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('neto_Pri', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('precio_Pri', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeGeneral_Pri', ftFloat, 0, False);

  kmtVentas.FieldDefs.Add('kilos_Seg', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('bruto_Seg', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('descuento_Seg', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('gastos_Seg', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeEnvase_Seg', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeSecciones_Seg', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('neto_Seg', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('precio_Seg', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeGeneral_Seg', ftFloat, 0, False);

  kmtVentas.FieldDefs.Add('kilos_Ter', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('bruto_Ter', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('descuento_Ter', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('gastos_Ter', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeEnvase_Ter', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeSecciones_Ter', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('neto_Ter', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('precio_Ter', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeGeneral_Ter', ftFloat, 0, False);

  kmtVentas.FieldDefs.Add('kilos_Des', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('bruto_Des', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('descuento_Des', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('gastos_Des', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeEnvase_Des', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeSecciones_Des', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('neto_Des', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('precio_Des', ftFloat, 0, False);
  kmtVentas.FieldDefs.Add('costeGeneral_Des', ftFloat, 0, False);

  kmtVentas.IndexFieldNames:= 'keySem';
  kmtVentas.MasterSource:= dsSemana;
  kmtVentas.MasterFields:= 'keySem';
  kmtVentas.DetailFields:= 'keySem';
  kmtVentas.CreateTable;


  kmtCosechero.FieldDefs.Clear;
  kmtCosechero.FieldDefs.Add('keySem', ftString, 15, False);
  kmtCosechero.FieldDefs.Add('cosechero', ftString, 3, False);

  kmtCosechero.FieldDefs.Add('kilos_total', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('kilos_pri', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('kilos_seg', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('kilos_ter', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('kilos_des', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('kilos_mer', ftFloat, 0, False);

  kmtCosechero.FieldDefs.Add('bruto_total', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('bruto_Pri', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('bruto_Seg', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('bruto_Ter', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('bruto_Des', ftFloat, 0, False);

  kmtCosechero.FieldDefs.Add('coste_total', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('coste_Pri', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('coste_Seg', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('coste_Ter', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('coste_Des', ftFloat, 0, False);

  kmtCosechero.FieldDefs.Add('neto_total', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('neto_Pri', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('neto_Seg', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('neto_Ter', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('neto_Des', ftFloat, 0, False);

  kmtCosechero.FieldDefs.Add('liquida_total', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('liquida_Pri', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('liquida_Seg', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('liquida_Ter', ftFloat, 0, False);
  kmtCosechero.FieldDefs.Add('liquida_Des', ftFloat, 0, False);

  kmtCosechero.IndexFieldNames:= 'keySem;cosechero';
  kmtCosechero.MasterSource:= dsSemana;
  kmtCosechero.MasterFields:= 'keySem';
  kmtCosechero.DetailFields:= 'keySem';
  kmtCosechero.CreateTable;

  kmtPlantacion.FieldDefs.Clear;
  kmtPlantacion.FieldDefs.Add('keySem', ftString, 15, False);
  kmtPlantacion.FieldDefs.Add('cosechero', ftString, 3, False);
  kmtPlantacion.FieldDefs.Add('plantacion', ftString, 3, False);
  kmtPlantacion.FieldDefs.Add('semana_planta', ftString, 6, False);

  kmtPlantacion.FieldDefs.Add('kilos_total', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('kilos_pri', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('kilos_seg', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('kilos_ter', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('kilos_des', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('kilos_mer', ftFloat, 0, False);

  kmtPlantacion.FieldDefs.Add('bruto_total', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('bruto_Pri', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('bruto_Seg', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('bruto_Ter', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('bruto_Des', ftFloat, 0, False);

  kmtPlantacion.FieldDefs.Add('coste_total', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('coste_Pri', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('coste_Seg', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('coste_Ter', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('coste_Des', ftFloat, 0, False);

  kmtPlantacion.FieldDefs.Add('neto_total', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('neto_Pri', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('neto_Seg', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('neto_Ter', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('neto_Des', ftFloat, 0, False);

  kmtPlantacion.FieldDefs.Add('liquida_total', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('liquida_Pri', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('liquida_Seg', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('liquida_Ter', ftFloat, 0, False);
  kmtPlantacion.FieldDefs.Add('liquida_Des', ftFloat, 0, False);

  kmtPlantacion.IndexFieldNames:= 'keySem;cosechero;plantacion;semana_planta';
  kmtPlantacion.MasterSource:= dsCosechero;
  kmtPlantacion.MasterFields:= 'keySem;cosechero';
  kmtPlantacion.DetailFields:= 'keySem;cosechero';
  kmtPlantacion.CreateTable;

  DMLiquidaPeriodoEntradas:= TDMLiquidaPeriodoEntradas.Create( self );
  DMLiquidaPeriodoTransitos:= TDMLiquidaPeriodoTransitos.Create( self );
  DMLiquidaPeriodoVentas:= TDMLiquidaPeriodoVentas.Create( self );
  DMLiquidaPeriodoInventarios:= TDMLiquidaPeriodoInventarios.Create( self );
end;

procedure TDMLiquidaPeriodo.AbrirTablas;
begin
  if kmtAux.Active then
    kmtAux.Close;
  kmtAux.Open;
  if kmtCentros.Active then
    kmtCentros.Close;
  kmtCentros.Open;
  if kmtSemana.Active then
    kmtSemana.Close;
  kmtSemana.Open;
  if kmtEntradas.Active then
    kmtEntradas.Close;
  kmtEntradas.Open;
  if kmtCosechero.Active then
    kmtCosechero.Close;
  kmtCosechero.Open;
  if kmtPlantacion.Active then
    kmtPlantacion.Close;
  kmtPlantacion.Open;
  if kmtVentas.Active then
    kmtVentas.Close;
  kmtVentas.Open;
  if kmtInventarios.Active then
    kmtInventarios.Close;
  kmtInventarios.Open;
  if kmtTransitosIn.Active then
    kmtTransitosIn.Close;
  kmtTransitosIn.Open;
  if kmtTransitosOut.Active then
    kmtTransitosOut.Close;
  kmtTransitosOut.Open;
end;

procedure TDMLiquidaPeriodo.LiquidarPerido(
                             const AEmpresa, AProducto: string;
                             const ADesde, AHasta: TDateTime;
                             const AComercial, AProduccion, AAdministrativo: Real;
                             const ADefinitiva: boolean; var VLabel: TLabel);
var
  sMsg, sSemana, sKey: string;
  rKilosVenta, rKilosTranIn, rKilosTranOut, rKilosIni, rKilosFin, rKilosEntrada: Real;
  iProductoBase, iCount: Integer;
begin
  sWarnig:= '';
  sError:= '';
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  rCosteComercial:= AComercial;
  rCosteProduccion:= AProduccion;
  rCosteAdministrativo:= AAdministrativo;
  bDefinitiva:= ADefinitiva;

  AbrirTablas;
  sMsg:= '';
  dFechaIni:= ADesde;
  iCount:= 0;
  while dFechaIni < AHasta do
  begin
    Application.ProcessMessages;
    dFechaFin:= dFechaIni + 6;
    sSemana:= AnyoSemana( dFechaIni );

    qryCentros.ParamByName('empresa').AsString:= sEmpresa;
    qryCentros.ParamByName('producto').AsString:= sProducto;
    qryCentros.ParamByName('fechaini').AsDateTime:= dFechaIni;
    qryCentros.ParamByName('fechafin').AsDateTime:= dFechaFin;

    kmtCentros.Close;
    kmtCentros.Open;
    qryCentros.Open;
    while not qryCentros.EOF do
    begin
      sCentro:= qryCentros.FieldByName('centro_Ec').AsString;
      sKey:=   sEmpresa + sCentro + sProducto + sSemana;

      Inc( iCount );
      VLabel.caption:= 'Calculo liquidacion (' + IntToStr( iCount ) + ') ' + sEmpresa + '/' + sCentro + '/' +  sProducto + '/' +  sSemana;
      Application.ProcessMessages;

      AltaSemana( sKey, sSemana );
      DMLiquidaPeriodoVentas.VentasSemana( sKey, sEmpresa, sCentro, sProducto, sSemana, dFechaIni, dFechaFin, rKilosVenta );
      DMLiquidaPeriodoTransitos.TransitosSemana( sKey, sEmpresa, sCentro, sProducto, sSemana, dFechaIni, dFechaFin, rKilosTranIn, rKilosTranOut );
      DMLiquidaPeriodoInventarios.InventariosSemana( sKey, sEmpresa, sCentro, sProducto, sSemana, dFechaIni, dFechaFin, rKilosIni, rKilosFin );
      DMLiquidaPeriodoEntradas.EntradasSemana( sKey, sEmpresa, sCentro, sProducto, sSemana, dFechaIni, dFechaFin,
                                          rKilosVenta, rKilosTranIn, rKilosTranOut, rKilosIni, rKilosFin, rKilosEntrada );
      //DMLiquidaPeriodoBDDatos.SalvaSemana;

      qryCentros.Next;
    end;
    qryCentros.Close;
    dFechaIni:= dFechaIni + 7;

    DMLiquidaPeriodoTransitos.ValorarTransitos;
    ValorarEntradas;
    DMLiquidaPeriodoBDDatos.SalvaCentroSemana;
  end;
end;

procedure TDMLiquidaPeriodo.AltaSemana( const AKey, ASemana: string );
begin
    kmtSemana.Insert;
    kmtSemana.FieldByName('keySem').AsString:= AKey;
    kmtSemana.FieldByName('empresa').AsString:= sEmpresa;
    kmtSemana.FieldByName('centro').AsString:= sCentro;
    kmtSemana.FieldByName('producto').AsString:= sProducto;
    kmtSemana.FieldByName('semana').AsString:= ASemana;
    kmtSemana.FieldByName('fecha_ini').AsDateTime:= dFechaIni;
    kmtSemana.FieldByName('fecha_fin').AsDateTime:= dFechaFin;

    kmtSemana.FieldByName('precio_coste_comercial').AsFloat:= rCosteComercial;
    kmtSemana.FieldByName('precio_coste_produccion').AsFloat:= rCosteProduccion;
    kmtSemana.FieldByName('precio_coste_administracion').AsFloat:= rCosteAdministrativo;

    kmtSemana.Post;

    kmtCentros.Insert;
    kmtCentros.FieldByName('keySem').AsString:= AKey;
    kmtCentros.Post;
end;

procedure TDMLiquidaPeriodo.ValorarEntradas;
begin
  kmtCentros.First;
  while not kmtCentros.Eof do
  begin
    kmtSemana.Locate('keysem', kmtCentros.FieldByName('keysem').AsString, [] );
    RellenaImportes;
    ReparteImportes;
    kmtCentros.Next;
  end;
end;

procedure TDMLiquidaPeriodo.RellenaImportes;
begin
  kmtEntradas.Edit;
  kmtEntradas.FieldByName('bruto_total').AsFloat:= kmtVentas.FieldByName('bruto_Sal').AsFloat;
  kmtEntradas.FieldByName('bruto_Pri').AsFloat:= kmtVentas.FieldByName('bruto_Pri').AsFloat;
  kmtEntradas.FieldByName('bruto_Seg').AsFloat:= kmtVentas.FieldByName('bruto_Seg').AsFloat;
  kmtEntradas.FieldByName('bruto_Ter').AsFloat:= kmtVentas.FieldByName('bruto_Ter').AsFloat;
  kmtEntradas.FieldByName('bruto_Des').AsFloat:= kmtVentas.FieldByName('bruto_Des').AsFloat;

  kmtEntradas.FieldByName('coste_total').AsFloat:= kmtVentas.FieldByName('bruto_Sal').AsFloat - kmtVentas.FieldByName('neto_Sal').AsFloat;
  kmtEntradas.FieldByName('coste_Pri').AsFloat:= kmtVentas.FieldByName('bruto_Pri').AsFloat - kmtVentas.FieldByName('neto_Pri').AsFloat;
  kmtEntradas.FieldByName('coste_Seg').AsFloat:= kmtVentas.FieldByName('bruto_Seg').AsFloat - kmtVentas.FieldByName('neto_Seg').AsFloat;
  kmtEntradas.FieldByName('coste_Ter').AsFloat:= kmtVentas.FieldByName('bruto_Ter').AsFloat - kmtVentas.FieldByName('neto_Ter').AsFloat;
  kmtEntradas.FieldByName('coste_Des').AsFloat:= kmtVentas.FieldByName('bruto_Des').AsFloat - kmtVentas.FieldByName('neto_Des').AsFloat;

  kmtEntradas.FieldByName('neto_total').AsFloat:= kmtVentas.FieldByName('neto_Sal').AsFloat;
  kmtEntradas.FieldByName('neto_Pri').AsFloat:= kmtVentas.FieldByName('neto_Pri').AsFloat;
  kmtEntradas.FieldByName('neto_Seg').AsFloat:= kmtVentas.FieldByName('neto_Seg').AsFloat;
  kmtEntradas.FieldByName('neto_Ter').AsFloat:= kmtVentas.FieldByName('neto_Ter').AsFloat;
  kmtEntradas.FieldByName('neto_Des').AsFloat:= kmtVentas.FieldByName('neto_Des').AsFloat;

  (*kmtEntradas.FieldByName('liquida_total').AsFloat:= kmtVentas.FieldByName('neto_Sal').AsFloat +
                                                     kmtInventarios.FieldByName('ajuste').AsFloat +
                                                     kmtTransitosOut.FieldByName('neto_total').AsFloat -
                                                     kmtVentas.FieldByName('costeGeneral_Sal').AsFloat -
                                                     kmtTransitosIn.FieldByName('importe_total').AsFloat;
  *)

  kmtEntradas.FieldByName('liquida_pri').AsFloat:= kmtVentas.FieldByName('neto_pri').AsFloat +
                                                     kmtInventarios.FieldByName('ajuste_pri').AsFloat +
                                                     kmtTransitosOut.FieldByName('neto_pri').AsFloat -
                                                     kmtVentas.FieldByName('costeGeneral_pri').AsFloat -
                                                     kmtTransitosIn.FieldByName('importe_pri').AsFloat;
  kmtEntradas.FieldByName('liquida_seg').AsFloat:= kmtVentas.FieldByName('neto_seg').AsFloat +
                                                     kmtInventarios.FieldByName('ajuste_seg').AsFloat +
                                                     kmtTransitosOut.FieldByName('neto_seg').AsFloat -
                                                     kmtVentas.FieldByName('costeGeneral_seg').AsFloat -
                                                     kmtTransitosIn.FieldByName('importe_seg').AsFloat;
  kmtEntradas.FieldByName('liquida_ter').AsFloat:= kmtVentas.FieldByName('neto_ter').AsFloat +
                                                     kmtInventarios.FieldByName('ajuste_ter').AsFloat +
                                                     kmtTransitosOut.FieldByName('neto_ter').AsFloat -
                                                     kmtVentas.FieldByName('costeGeneral_ter').AsFloat -
                                                     kmtTransitosIn.FieldByName('importe_ter').AsFloat;
  kmtEntradas.FieldByName('liquida_des').AsFloat:= kmtVentas.FieldByName('neto_des').AsFloat +
                                                     kmtInventarios.FieldByName('ajuste_des').AsFloat +
                                                     kmtTransitosOut.FieldByName('neto_des').AsFloat -
                                                     kmtVentas.FieldByName('costeGeneral_des').AsFloat -
                                                     kmtTransitosIn.FieldByName('importe_des').AsFloat;

  kmtEntradas.FieldByName('liquida_total').AsFloat:= kmtEntradas.FieldByName('liquida_pri').AsFloat +
                                                     kmtEntradas.FieldByName('liquida_seg').AsFloat +
                                                     kmtEntradas.FieldByName('liquida_ter').AsFloat +
                                                     kmtEntradas.FieldByName('liquida_des').AsFloat;

  if kmtEntradas.FieldByName('kilos_total').AsFloat <> 0 then
     kmtEntradas.FieldByName('precio_liquida_total').AsFloat:= bRoundTo( kmtEntradas.FieldByName('liquida_total').AsFloat / kmtEntradas.FieldByName('kilos_total').AsFloat, 5)
  else
     kmtEntradas.FieldByName('precio_liquida_total').AsFloat:= 0;

  if kmtEntradas.FieldByName('kilos_pri').AsFloat <> 0 then
     kmtEntradas.FieldByName('precio_liquida_pri').AsFloat:= bRoundTo( kmtEntradas.FieldByName('liquida_pri').AsFloat / kmtEntradas.FieldByName('kilos_pri').AsFloat, 5)
  else
     kmtEntradas.FieldByName('precio_liquida_pri').AsFloat:= 0;

  if kmtEntradas.FieldByName('kilos_seg').AsFloat <> 0 then
     kmtEntradas.FieldByName('precio_liquida_seg').AsFloat:= bRoundTo( kmtEntradas.FieldByName('liquida_seg').AsFloat / kmtEntradas.FieldByName('kilos_seg').AsFloat, 5)
  else
     kmtEntradas.FieldByName('precio_liquida_seg').AsFloat:= 0;

  if kmtEntradas.FieldByName('kilos_ter').AsFloat <> 0 then
     kmtEntradas.FieldByName('precio_liquida_ter').AsFloat:= bRoundTo( kmtEntradas.FieldByName('liquida_ter').AsFloat / kmtEntradas.FieldByName('kilos_ter').AsFloat, 5)
  else
     kmtEntradas.FieldByName('precio_liquida_ter').AsFloat:= 0;

  if kmtEntradas.FieldByName('kilos_des').AsFloat <> 0 then
     kmtEntradas.FieldByName('precio_liquida_des').AsFloat:= bRoundTo( kmtEntradas.FieldByName('liquida_des').AsFloat / kmtEntradas.FieldByName('kilos_des').AsFloat, 5)
  else
     kmtEntradas.FieldByName('precio_liquida_des').AsFloat:= 0;

  kmtEntradas.Post;
end;

procedure TDMLiquidaPeriodo.ReparteImportes;
begin
  kmtCosechero.First;
  while not kmtCosechero.Eof do
  begin
    LimpiaCosechero;
    kmtPlantacion.First;
    while not kmtPlantacion.Eof do
    begin
      ImportesPlantacion;
      AcumulaCosechero;;
      kmtPlantacion.Next;
    end;
    ImportesCosechero;
    kmtCosechero.Next;
  end;
end;

procedure TDMLiquidaPeriodo.ImportesCosechero;
begin
  kmtCosechero.Edit;
  kmtCosechero.FieldByName('bruto_total').AsFloat:= rbruto_total;
  kmtCosechero.FieldByName('neto_total').AsFloat:= rneto_total;
  kmtCosechero.FieldByName('coste_total').AsFloat:= rbruto_total - rneto_total;
  kmtCosechero.FieldByName('liquida_total').AsFloat:= rliquida_total;

  kmtCosechero.FieldByName('bruto_pri').AsFloat:= rbruto_pri;
  kmtCosechero.FieldByName('neto_pri').AsFloat:= rneto_pri;
  kmtCosechero.FieldByName('coste_pri').AsFloat:= rbruto_pri - rneto_pri;
  kmtCosechero.FieldByName('liquida_pri').AsFloat:= rliquida_pri;

  kmtCosechero.FieldByName('bruto_seg').AsFloat:= rbruto_seg;
  kmtCosechero.FieldByName('neto_seg').AsFloat:= rneto_seg;
  kmtCosechero.FieldByName('coste_seg').AsFloat:= rbruto_seg - rneto_seg;
  kmtCosechero.FieldByName('liquida_seg').AsFloat:= rliquida_seg;

  kmtCosechero.FieldByName('bruto_ter').AsFloat:= rbruto_ter;
  kmtCosechero.FieldByName('neto_ter').AsFloat:= rneto_ter;
  kmtCosechero.FieldByName('coste_ter').AsFloat:= rbruto_ter - rneto_ter;
  kmtCosechero.FieldByName('liquida_ter').AsFloat:= rliquida_ter;

  kmtCosechero.FieldByName('bruto_des').AsFloat:= rbruto_des;
  kmtCosechero.FieldByName('neto_des').AsFloat:= rneto_des;
  kmtCosechero.FieldByName('coste_des').AsFloat:= rbruto_des - rneto_des;
  kmtCosechero.FieldByName('liquida_des').AsFloat:= rliquida_des;
  kmtCosechero.Post;
end;

procedure TDMLiquidaPeriodo.LimpiaCosechero;
begin
  rbruto_total:= 0;
  rneto_total:= 0;
  rliquida_total:= 0;

  rbruto_pri:= 0;
  rneto_pri:= 0;
  rliquida_pri:= 0;

  rbruto_seg:= 0;
  rneto_seg:= 0;
  rliquida_seg:= 0;

  rbruto_ter:= 0;
  rneto_ter:= 0;
  rliquida_ter:= 0;

  rbruto_des:= 0;
  rneto_des:= 0;
  rliquida_des:= 0;
end;

procedure TDMLiquidaPeriodo.AcumulaCosechero;
begin
  rbruto_total:= rbruto_total + kmtPlantacion.FieldByName('bruto_total').AsFloat;
  rneto_total:= rneto_total + kmtPlantacion.FieldByName('neto_total').AsFloat;
  rliquida_total:= rliquida_total + kmtPlantacion.FieldByName('liquida_total').AsFloat;

  rbruto_pri:= rbruto_pri + kmtPlantacion.FieldByName('bruto_pri').AsFloat;
  rneto_pri:= rneto_pri + kmtPlantacion.FieldByName('neto_pri').AsFloat;
  rliquida_pri:= rliquida_pri + kmtPlantacion.FieldByName('liquida_pri').AsFloat;

  rbruto_seg:= rbruto_seg + kmtPlantacion.FieldByName('bruto_seg').AsFloat;
  rneto_seg:= rneto_seg + kmtPlantacion.FieldByName('neto_seg').AsFloat;
  rliquida_seg:= rliquida_seg + kmtPlantacion.FieldByName('liquida_seg').AsFloat;

  rbruto_ter:= rbruto_ter + kmtPlantacion.FieldByName('bruto_ter').AsFloat;
  rneto_ter:= rneto_ter + kmtPlantacion.FieldByName('neto_ter').AsFloat;
  rliquida_ter:= rliquida_ter + kmtPlantacion.FieldByName('liquida_ter').AsFloat;

  rbruto_des:= rbruto_des + kmtPlantacion.FieldByName('bruto_des').AsFloat;
  rneto_des:= rneto_des + kmtPlantacion.FieldByName('neto_des').AsFloat;
  rliquida_des:= rliquida_des + kmtPlantacion.FieldByName('liquida_des').AsFloat;
end;


procedure TDMLiquidaPeriodo.ImportesPlantacion;
var
  rAux: Real;
begin
  kmtPlantacion.Edit;

  if  kmtEntradas.FieldByName('kilos_total').AsFloat <> 0 then
  begin
    kmtPlantacion.FieldByName('bruto_total').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_total').AsFloat * ( kmtEntradas.FieldByName('bruto_total').AsFloat / kmtEntradas.FieldByName('kilos_total').AsFloat),2);
    kmtPlantacion.FieldByName('neto_total').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_total').AsFloat * ( kmtEntradas.FieldByName('neto_total').AsFloat / kmtEntradas.FieldByName('kilos_total').AsFloat),2);
    kmtPlantacion.FieldByName('coste_total').AsFloat:= kmtPlantacion.FieldByName('bruto_total').AsFloat - kmtPlantacion.FieldByName('neto_total').AsFloat;
    kmtPlantacion.FieldByName('liquida_Total').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_Total').AsFloat * ( kmtEntradas.FieldByName('liquida_Total').AsFloat / kmtEntradas.FieldByName('kilos_Total').AsFloat),2);
  end
  else
  begin
    kmtPlantacion.FieldByName('bruto_total').AsFloat:= 0;
    kmtPlantacion.FieldByName('neto_total').AsFloat:= 0;
    kmtPlantacion.FieldByName('coste_total').AsFloat:= 0;
    kmtPlantacion.FieldByName('liquida_total').AsFloat:= 0;
  end;

  if  kmtEntradas.FieldByName('kilos_pri').AsFloat <> 0 then
  begin
    kmtPlantacion.FieldByName('bruto_Pri').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_pri').AsFloat * ( kmtEntradas.FieldByName('bruto_Pri').AsFloat / kmtEntradas.FieldByName('kilos_pri').AsFloat),2);
    kmtPlantacion.FieldByName('neto_Pri').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_pri').AsFloat * ( kmtEntradas.FieldByName('neto_Pri').AsFloat / kmtEntradas.FieldByName('kilos_pri').AsFloat),2);
    kmtPlantacion.FieldByName('coste_Pri').AsFloat:= kmtPlantacion.FieldByName('bruto_Pri').AsFloat - kmtPlantacion.FieldByName('neto_Pri').AsFloat;
    kmtPlantacion.FieldByName('liquida_pri').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_pri').AsFloat * ( kmtEntradas.FieldByName('liquida_pri').AsFloat / kmtEntradas.FieldByName('kilos_pri').AsFloat),2);
  end
  else
  begin
    kmtPlantacion.FieldByName('bruto_Pri').AsFloat:= 0;
    kmtPlantacion.FieldByName('neto_Pri').AsFloat:= 0;
    kmtPlantacion.FieldByName('coste_Pri').AsFloat:= 0;
    kmtPlantacion.FieldByName('liquida_pri').AsFloat:= 0;
  end;

  if  kmtEntradas.FieldByName('kilos_seg').AsFloat <> 0 then
  begin
    kmtPlantacion.FieldByName('bruto_Seg').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_seg').AsFloat * ( kmtEntradas.FieldByName('bruto_Seg').AsFloat / kmtEntradas.FieldByName('kilos_seg').AsFloat),2);
    kmtPlantacion.FieldByName('neto_Seg').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_seg').AsFloat * ( kmtEntradas.FieldByName('neto_Seg').AsFloat / kmtEntradas.FieldByName('kilos_seg').AsFloat),2);
    kmtPlantacion.FieldByName('coste_Seg').AsFloat:= kmtPlantacion.FieldByName('bruto_seg').AsFloat - kmtPlantacion.FieldByName('neto_seg').AsFloat;
    kmtPlantacion.FieldByName('liquida_Seg').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_seg').AsFloat * ( kmtEntradas.FieldByName('liquida_seg').AsFloat / kmtEntradas.FieldByName('kilos_seg').AsFloat),2);
  end
  else
  begin
    kmtPlantacion.FieldByName('bruto_Seg').AsFloat:= 0;
    kmtPlantacion.FieldByName('neto_Seg').AsFloat:= 0;
    kmtPlantacion.FieldByName('coste_Seg').AsFloat:= 0;
    kmtPlantacion.FieldByName('liquida_seg').AsFloat:= 0;
  end;

  if  kmtEntradas.FieldByName('kilos_ter').AsFloat <> 0 then
  begin
    kmtPlantacion.FieldByName('bruto_Ter').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_ter').AsFloat * ( kmtEntradas.FieldByName('bruto_Ter').AsFloat / kmtEntradas.FieldByName('kilos_ter').AsFloat),2);
    kmtPlantacion.FieldByName('neto_Ter').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_ter').AsFloat * ( kmtEntradas.FieldByName('neto_Ter').AsFloat / kmtEntradas.FieldByName('kilos_ter').AsFloat),2);
    kmtPlantacion.FieldByName('coste_Ter').AsFloat:= kmtPlantacion.FieldByName('bruto_ter').AsFloat - kmtPlantacion.FieldByName('neto_ter').AsFloat;
    kmtPlantacion.FieldByName('liquida_Ter').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_ter').AsFloat * ( kmtEntradas.FieldByName('liquida_Ter').AsFloat / kmtEntradas.FieldByName('kilos_ter').AsFloat),2);
  end
  else
  begin
    kmtPlantacion.FieldByName('bruto_Ter').AsFloat:= 0;
    kmtPlantacion.FieldByName('neto_Ter').AsFloat:= 0;
    kmtPlantacion.FieldByName('coste_Ter').AsFloat:= 0;
    kmtPlantacion.FieldByName('liquida_ter').AsFloat:= 0;
  end;

  if  kmtEntradas.FieldByName('kilos_des').AsFloat <> 0 then
  begin
    kmtPlantacion.FieldByName('bruto_Des').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_des').AsFloat * ( kmtEntradas.FieldByName('bruto_Des').AsFloat / kmtEntradas.FieldByName('kilos_des').AsFloat),2);
    kmtPlantacion.FieldByName('neto_Des').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_des').AsFloat * ( kmtEntradas.FieldByName('neto_Des').AsFloat / kmtEntradas.FieldByName('kilos_des').AsFloat),2);
    kmtPlantacion.FieldByName('coste_Des').AsFloat:= kmtPlantacion.FieldByName('bruto_des').AsFloat - kmtPlantacion.FieldByName('neto_des').AsFloat;
    kmtPlantacion.FieldByName('liquida_Des').AsFloat:=
      bRoundTo( kmtPlantacion.FieldByName('kilos_des').AsFloat * ( kmtEntradas.FieldByName('liquida_Des').AsFloat / kmtEntradas.FieldByName('kilos_des').AsFloat),2);
  end
  else
  begin
    kmtPlantacion.FieldByName('bruto_Des').AsFloat:= 0;
    kmtPlantacion.FieldByName('neto_Des').AsFloat:= 0;
    kmtPlantacion.FieldByName('coste_Des').AsFloat:= 0;
    kmtPlantacion.FieldByName('liquida_des').AsFloat:= 0;
  end;


  kmtPlantacion.Post;
end;

end.
