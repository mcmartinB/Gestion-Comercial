unit LiquidaPeriodoImportesDM;

interface

uses
  SysUtils, Classes;

type
  TDMLiquidaPeriodoImportes = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    //Parametros de entrada
    sEmpresa, sCentro, sProducto, sSemana: string;
    dFechaIni, dFechaFin: TDateTime;


    procedure GrabarImportesVenta;

  public
    { Public declarations }
     procedure ImportesSemana(const AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime);
  end;



var
  DMLiquidaPeriodoImportes: TDMLiquidaPeriodoImportes;

implementation

{$R *.dfm}

uses
  TablaTemporalFOBData, LiquidaPeriodoDM;

var
  RResultadosFob: TResultadosFob;


procedure TDMLiquidaPeriodoImportes.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TDMLiquidaPeriodoImportes.DataModuleCreate(Sender: TObject);
begin
  //TRANSITOS
  (*
select empresa_tl, centro_tl, centro_destino_tl, ( year(fecha_tl) * 100 ) + month(fecha_tl), producto_tl, envase_tl, categoria_tl, kilos_tl
from frf_transitos_l
where empresa_tl = '050'
  and centro_tl = '1'
  and centro_destino_tl = '1'
  and producto_tl = 'C'
  and fecha_tl between '27/6/2016' and '3/7/2016'
  *)
end;  

procedure TDMLiquidaPeriodoImportes.ImportesSemana(const AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime);
var
  VPeso, VNeto, VDescuento, VGastos, VMaterial, VGeneral: Real;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  dFechaIni:= ADesde;
  dFechaFin:= AHasta;
  sSemana:= ASemana;


  DMTablaTemporalFOB:= TDMTablaTemporalFOB.Create( self );
  try
    with DMTablaTemporalFOB do
    begin
      sAEmpresa:= sEmpresa;
      iAProductoPropio:= -1;
      sACentroOrigen:= '';
      sACentroSalida:= sCentro;
      sACliente:= '';
      iAClienteFac:= -1;     // 1 -> facturable 2 -> no facturable resto -> todos
      sAPais:= '';
      sAALbaran:= '';
      bAAlb6Digitos:= False;    // true -> como minimo seis digitos (almacen) false -> todos
      iAAlbFacturado:= -1;   // 1 -> facturado  0 -> no facturado  resto -> todos
      bAManuales:= True;  //False no usa los abonos
      bASoloManuales:= False;
      sAFechaDesde:= FormatDateTime('dd/mm/yyyy',dFechaIni);
      sAFEchaHasta:= FormatDateTime('dd/mm/yyyy',dFechaFin);
      bAFechaSalida:= True;    // true -> rango fecha salidas false -> rango fecha facturas (solo facturados)
      sAProducto:= sProducto;
      iAEsTomate:= -1;       // 1 -> tomate 2 -> no tomate resto -> todos
      sAEnvase:= '';
      sACategoria:= '';
      bACatComerciales:= False; // true 050 -> 1,2,3 RESTO -> no RET, 0XX         false -> todos
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
      GrabarImportesVenta;
    end;

  finally
    FreeAndNil( DMTablaTemporalFOB );
  end;
end;

procedure TDMLiquidaPeriodoImportes.GrabarImportesVenta;
begin
  DMLiquidaPeriodo.kmtSemana.Edit;

  DMLiquidaPeriodo.kmtSemana.FieldByName('pesoSalida').AsFloat:= RResultadosFob.rPeso;
  DMLiquidaPeriodo.kmtSemana.FieldByName('brutoSalida').AsFloat:= RResultadosFob.rNeto;
  DMLiquidaPeriodo.kmtSemana.FieldByName('descuentoSalida').AsFloat:= RResultadosFob.rDescuento;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosFacSalida').AsFloat:= RResultadosFob.rGastosFac;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosNoFacSalida').AsFloat:= RResultadosFob.rGastosNoFac;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosTranSalida').AsFloat:= RResultadosFob.rGastosTran;
  DMLiquidaPeriodo.kmtSemana.FieldByName('costeEnvaseSalida').AsFloat:= RResultadosFob.rCosteEnvase;
  DMLiquidaPeriodo.kmtSemana.FieldByName('costeSeccionesSalida').AsFloat:= RResultadosFob.rCosteSecciones;
  DMLiquidaPeriodo.kmtSemana.FieldByName('netoSalida').AsFloat:= RResultadosFob.rNeto - ( RResultadosFob.rDescuento + RResultadosFob.rGastosFac +
     RResultadosFob.rGastosNoFac + RResultadosFob.rGastosTran + RResultadosFob.rCosteEnvase + RResultadosFob.rCosteSecciones );
  if RResultadosFob.rPeso <> 0 then
    DMLiquidaPeriodo.kmtSemana.FieldByName('precioSalida').AsFloat:= DMLiquidaPeriodo.kmtSemana.FieldByName('netoSalida').AsFloat / RResultadosFob.rPeso
  else
    DMLiquidaPeriodo.kmtSemana.FieldByName('precioSalida').AsFloat:= 0;

  DMLiquidaPeriodo.kmtSemana.FieldByName('pesoPrimera').AsFloat:= RResultadosFob.rPesoPrimera;
  DMLiquidaPeriodo.kmtSemana.FieldByName('brutoPrimera').AsFloat:= RResultadosFob.rNetoPrimera;
  DMLiquidaPeriodo.kmtSemana.FieldByName('descuentoPrimera').AsFloat:= RResultadosFob.rDescuentoPrimera;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosFacPrimera').AsFloat:= RResultadosFob.rGastosPrimeraFac;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosNoFacPrimera').AsFloat:= RResultadosFob.rGastosPrimeraNoFac;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosTranPrimera').AsFloat:= RResultadosFob.rGastosPrimeraTran;
  DMLiquidaPeriodo.kmtSemana.FieldByName('costeEnvasePrimera').AsFloat:= RResultadosFob.rEnvasePrimera;
  DMLiquidaPeriodo.kmtSemana.FieldByName('costeSeccionesPrimera').AsFloat:= RResultadosFob.rSeccionesPrimera;
  DMLiquidaPeriodo.kmtSemana.FieldByName('netoPrimera').AsFloat:= RResultadosFob.rNetoPrimera - ( RResultadosFob.rDescuentoPrimera + RResultadosFob.rGastosPrimeraFac +
    RResultadosFob.rGastosPrimeraNoFac + RResultadosFob.rGastosPrimeraTran + RResultadosFob.rEnvasePrimera + RResultadosFob.rSeccionesPrimera );
  if RResultadosFob.rPesoPrimera <> 0 then
    DMLiquidaPeriodo.kmtSemana.FieldByName('precioPrimera').AsFloat:= DMLiquidaPeriodo.kmtSemana.FieldByName('netoPrimera').AsFloat / RResultadosFob.rPesoPrimera
  else
    DMLiquidaPeriodo.kmtSemana.FieldByName('preciorimera').AsFloat:= 0;

  DMLiquidaPeriodo.kmtSemana.FieldByName('pesoSegunda').AsFloat:= RResultadosFob.rPesoSegunda;
  DMLiquidaPeriodo.kmtSemana.FieldByName('brutoSegunda').AsFloat:= RResultadosFob.rNetoSegunda;
  DMLiquidaPeriodo.kmtSemana.FieldByName('descuentoSegunda').AsFloat:= RResultadosFob.rDescuentoSegunda;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosFacSegunda').AsFloat:= RResultadosFob.rGastosSegundaFac;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosNoFacSegunda').AsFloat:= RResultadosFob.rGastosSegundaNoFac;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosTranSegunda').AsFloat:= RResultadosFob.rGastosSegundaTran;
  DMLiquidaPeriodo.kmtSemana.FieldByName('costeEnvaseSegunda').AsFloat:= RResultadosFob.rEnvaseSegunda;
  DMLiquidaPeriodo.kmtSemana.FieldByName('costeSeccionesSegunda').AsFloat:= RResultadosFob.rSeccionesSegunda;
  DMLiquidaPeriodo.kmtSemana.FieldByName('netoSegunda').AsFloat:= RResultadosFob.rNetoSegunda - ( RResultadosFob.rDescuentoSegunda + RResultadosFob.rGastosSegundaFac +
    RResultadosFob.rGastosSegundaNoFac + RResultadosFob.rGastosSegundaTran + RResultadosFob.rEnvaseSegunda + RResultadosFob.rSeccionesSegunda );
  if RResultadosFob.rPesoSegunda <> 0 then
    DMLiquidaPeriodo.kmtSemana.FieldByName('precioSegunda').AsFloat:= DMLiquidaPeriodo.kmtSemana.FieldByName('netoSegunda').AsFloat / RResultadosFob.rPesoSegunda
  else
    DMLiquidaPeriodo.kmtSemana.FieldByName('precioSegunda').AsFloat:= 0;

  DMLiquidaPeriodo.kmtSemana.FieldByName('pesoTercera').AsFloat:= RResultadosFob.rPesoTercera;
  DMLiquidaPeriodo.kmtSemana.FieldByName('brutoTercera').AsFloat:= RResultadosFob.rNetoTercera;
  DMLiquidaPeriodo.kmtSemana.FieldByName('descuentoTercera').AsFloat:= RResultadosFob.rDescuentoTercera;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosFacTercera').AsFloat:= RResultadosFob.rGastosTerceraFac;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosNoFacTercera').AsFloat:= RResultadosFob.rGastosTerceraNoFac;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosTranTercera').AsFloat:= RResultadosFob.rGastosTerceraTran;
  DMLiquidaPeriodo.kmtSemana.FieldByName('costeEnvaseTercera').AsFloat:= RResultadosFob.rEnvaseTercera;
  DMLiquidaPeriodo.kmtSemana.FieldByName('costeSeccionesTercera').AsFloat:= RResultadosFob.rSeccionesTercera;
  DMLiquidaPeriodo.kmtSemana.FieldByName('netoTercera').AsFloat:= RResultadosFob.rNetoTercera - ( RResultadosFob.rDescuentoTercera + RResultadosFob.rGastosTerceraFac +
    RResultadosFob.rGastosTerceraNoFac + RResultadosFob.rGastosTerceraTran + RResultadosFob.rEnvaseTercera + RResultadosFob.rSeccionesTercera );
  if RResultadosFob.rPesoTercera <> 0 then
    DMLiquidaPeriodo.kmtSemana.FieldByName('precioTercera').AsFloat:= DMLiquidaPeriodo.kmtSemana.FieldByName('netoTercera').AsFloat / RResultadosFob.rPesoTercera
  else
    DMLiquidaPeriodo.kmtSemana.FieldByName('precioTercera').AsFloat:= 0;

  DMLiquidaPeriodo.kmtSemana.FieldByName('pesoDestrio').AsFloat:= RResultadosFob.rPesoDestrio;
  DMLiquidaPeriodo.kmtSemana.FieldByName('brutoDestrio').AsFloat:= RResultadosFob.rNetoDestrio;
  DMLiquidaPeriodo.kmtSemana.FieldByName('descuentoDestrio').AsFloat:= RResultadosFob.rDescuentoDestrio;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosFacDestrio').AsFloat:= RResultadosFob.rGastosDestrioFac;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosNoFacDestrio').AsFloat:= RResultadosFob.rGastosDestrioNoFac;
  DMLiquidaPeriodo.kmtSemana.FieldByName('gastosTranDestrio').AsFloat:= RResultadosFob.rGastosDestrioTran;
  DMLiquidaPeriodo.kmtSemana.FieldByName('costeEnvaseDestrio').AsFloat:= RResultadosFob.rEnvaseDestrio;
  DMLiquidaPeriodo.kmtSemana.FieldByName('costeSeccionesDestrio').AsFloat:= RResultadosFob.rSeccionesDestrio;
  DMLiquidaPeriodo.kmtSemana.FieldByName('netoDestrio').AsFloat:= RResultadosFob.rNetoDestrio - ( RResultadosFob.rDescuentoDestrio + RResultadosFob.rGastosDestrioFac +
    RResultadosFob.rGastosDestrioNoFac + RResultadosFob.rGastosDestrioTran + RResultadosFob.rEnvaseDestrio + RResultadosFob.rSeccionesDestrio );
  if RResultadosFob.rPesoDestrio <> 0 then
    DMLiquidaPeriodo.kmtSemana.FieldByName('precioDestrio').AsFloat:= DMLiquidaPeriodo.kmtSemana.FieldByName('netoDestrio').AsFloat / RResultadosFob.rPesoDestrio
  else
    DMLiquidaPeriodo.kmtSemana.FieldByName('precioDestrio').AsFloat:= 0;

  DMLiquidaPeriodo.kmtSemana.Post;
end;

end.
