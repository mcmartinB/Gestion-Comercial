unit LiqProdVendidoVentasDM;

interface

uses
  SysUtils, Classes;

type
  TDMLiqProdVendidoVentas = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    //Parametros de entrada
    sSemanaKey: string;
    sEmpresa, sCentro, sProducto, sSemana: string;
    dFechaIni, dFechaFin: TDateTime;


    procedure GrabarImportesVenta;

  public
    { Public declarations }
     procedure VentasSemana(const AKey, AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime; var VKilosVentas: Real );
  end;



var
  DMLiqProdVendidoVentas: TDMLiqProdVendidoVentas;

implementation

{$R *.dfm}

uses
  TablaTemporalFOBData, LiqProdVendidoDM, bMath;

var
  RResultadosFob: TResultadosFob;


procedure TDMLiqProdVendidoVentas.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TDMLiqProdVendidoVentas.DataModuleCreate(Sender: TObject);
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

procedure TDMLiqProdVendidoVentas.VentasSemana(const AKey, AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime; var VKilosVentas: Real );
var
  VNeto, VDescuento, VGastos, VMaterial, VGeneral: Real;
begin
  sSemanaKey:= AKey;
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

    VKilosVentas:= 0;
    VNeto:= 0;
    VDescuento:= 0;
    VGastos:= 0;
    VMaterial:= 0;
    VGeneral:= 0;

    if DMTablaTemporalFOB.ImportesFOB(  VKilosVentas, VNeto, VDescuento, VGastos, VMaterial, VGeneral, RResultadosFob ) then
    begin
      GrabarImportesVenta;
    end;

  finally
    FreeAndNil( DMTablaTemporalFOB );
  end;
end;

procedure TDMLiqProdVendidoVentas.GrabarImportesVenta;
var
  rCosteGenerales: Real;
begin
  DMLiqProdVendido.kmtVentas.Insert;

  DMLiqProdVendido.kmtVentas.FieldByName('keySem').AsString:= sSemanaKey;
  DMLiqProdVendido.kmtVentas.FieldByName('kilos_Sal').AsFloat:= RResultadosFob.rPeso;
  DMLiqProdVendido.kmtVentas.FieldByName('bruto_Sal').AsFloat:= RResultadosFob.rNeto;
  DMLiqProdVendido.kmtVentas.FieldByName('descuento_Sal').AsFloat:= RResultadosFob.rDescuento;
  DMLiqProdVendido.kmtVentas.FieldByName('gastos_Sal').AsFloat:= RResultadosFob.rGastosFac + RResultadosFob.rGastosNoFac;
  DMLiqProdVendido.kmtVentas.FieldByName('costeEnvase_Sal').AsFloat:= RResultadosFob.rCosteEnvase;
  DMLiqProdVendido.kmtVentas.FieldByName('costeSecciones_Sal').AsFloat:= RResultadosFob.rCosteSecciones;
  DMLiqProdVendido.kmtVentas.FieldByName('neto_Sal').AsFloat:= RResultadosFob.rNeto - ( RResultadosFob.rDescuento + RResultadosFob.rGastosFac +
     RResultadosFob.rGastosNoFac + RResultadosFob.rGastosTran + RResultadosFob.rCosteEnvase + RResultadosFob.rCosteSecciones );
  if RResultadosFob.rPeso <> 0 then
    DMLiqProdVendido.kmtVentas.FieldByName('precio_Sal').AsFloat:= bRoundTo( DMLiqProdVendido.kmtVentas.FieldByName('neto_Sal').AsFloat / RResultadosFob.rPeso, 5 )
  else
    DMLiqProdVendido.kmtVentas.FieldByName('precio_Sal').AsFloat:= 0;

  DMLiqProdVendido.kmtVentas.FieldByName('kilos_Pri').AsFloat:= RResultadosFob.rPesoPrimera;
  DMLiqProdVendido.kmtVentas.FieldByName('bruto_Pri').AsFloat:= RResultadosFob.rNetoPrimera;
  DMLiqProdVendido.kmtVentas.FieldByName('descuento_Pri').AsFloat:= RResultadosFob.rDescuentoPrimera;
  DMLiqProdVendido.kmtVentas.FieldByName('gastos_Pri').AsFloat:= RResultadosFob.rGastosPrimeraFac + RResultadosFob.rGastosPrimeraNoFac;
  DMLiqProdVendido.kmtVentas.FieldByName('costeEnvase_Pri').AsFloat:= RResultadosFob.rEnvasePrimera;
  DMLiqProdVendido.kmtVentas.FieldByName('costeSecciones_Pri').AsFloat:= RResultadosFob.rSeccionesPrimera;
  DMLiqProdVendido.kmtVentas.FieldByName('neto_Pri').AsFloat:= RResultadosFob.rNetoPrimera - ( RResultadosFob.rDescuentoPrimera + RResultadosFob.rGastosPrimeraFac +
    RResultadosFob.rGastosPrimeraNoFac + RResultadosFob.rGastosPrimeraTran + RResultadosFob.rEnvasePrimera + RResultadosFob.rSeccionesPrimera );
  if RResultadosFob.rPesoPrimera <> 0 then
    DMLiqProdVendido.kmtVentas.FieldByName('precio_Pri').AsFloat:= bRoundTo( DMLiqProdVendido.kmtVentas.FieldByName('neto_Pri').AsFloat / RResultadosFob.rPesoPrimera, 5 )
  else
    DMLiqProdVendido.kmtVentas.FieldByName('precio_Pri').AsFloat:= 0;

  DMLiqProdVendido.kmtVentas.FieldByName('kilos_Seg').AsFloat:= RResultadosFob.rPesoSegunda;
  DMLiqProdVendido.kmtVentas.FieldByName('bruto_Seg').AsFloat:= RResultadosFob.rNetoSegunda;
  DMLiqProdVendido.kmtVentas.FieldByName('descuento_Seg').AsFloat:= RResultadosFob.rDescuentoSegunda;
  DMLiqProdVendido.kmtVentas.FieldByName('gastos_Seg').AsFloat:= RResultadosFob.rGastosSegundaFac + RResultadosFob.rGastosSegundaNoFac;
  DMLiqProdVendido.kmtVentas.FieldByName('costeEnvase_Seg').AsFloat:= RResultadosFob.rEnvaseSegunda;
  DMLiqProdVendido.kmtVentas.FieldByName('costeSecciones_Seg').AsFloat:= RResultadosFob.rSeccionesSegunda;
  DMLiqProdVendido.kmtVentas.FieldByName('neto_Seg').AsFloat:= RResultadosFob.rNetoSegunda - ( RResultadosFob.rDescuentoSegunda + RResultadosFob.rGastosSegundaFac +
    RResultadosFob.rGastosSegundaNoFac + RResultadosFob.rGastosSegundaTran + RResultadosFob.rEnvaseSegunda + RResultadosFob.rSeccionesSegunda );
  if RResultadosFob.rPesoSegunda <> 0 then
    DMLiqProdVendido.kmtVentas.FieldByName('precio_Seg').AsFloat:= bRoundTo( DMLiqProdVendido.kmtVentas.FieldByName('neto_Seg').AsFloat / RResultadosFob.rPesoSegunda, 5 )
  else
    DMLiqProdVendido.kmtVentas.FieldByName('precio_Seg').AsFloat:= 0;

  DMLiqProdVendido.kmtVentas.FieldByName('kilos_Ter').AsFloat:= RResultadosFob.rPesoTercera;
  DMLiqProdVendido.kmtVentas.FieldByName('bruto_Ter').AsFloat:= RResultadosFob.rNetoTercera;
  DMLiqProdVendido.kmtVentas.FieldByName('descuento_Ter').AsFloat:= RResultadosFob.rDescuentoTercera;
  DMLiqProdVendido.kmtVentas.FieldByName('gastos_Ter').AsFloat:= RResultadosFob.rGastosTerceraFac + RResultadosFob.rGastosTerceraNoFac;
  DMLiqProdVendido.kmtVentas.FieldByName('costeEnvase_Ter').AsFloat:= RResultadosFob.rEnvaseTercera;
  DMLiqProdVendido.kmtVentas.FieldByName('costeSecciones_Ter').AsFloat:= RResultadosFob.rSeccionesTercera;
  DMLiqProdVendido.kmtVentas.FieldByName('neto_Ter').AsFloat:= RResultadosFob.rNetoTercera - ( RResultadosFob.rDescuentoTercera + RResultadosFob.rGastosTerceraFac +
    RResultadosFob.rGastosTerceraNoFac + RResultadosFob.rGastosTerceraTran + RResultadosFob.rEnvaseTercera + RResultadosFob.rSeccionesTercera );
  if RResultadosFob.rPesoTercera <> 0 then
    DMLiqProdVendido.kmtVentas.FieldByName('precio_Ter').AsFloat:= bRoundTo( DMLiqProdVendido.kmtVentas.FieldByName('neto_Ter').AsFloat / RResultadosFob.rPesoTercera, 5 )
  else
    DMLiqProdVendido.kmtVentas.FieldByName('precio_Ter').AsFloat:= 0;

  DMLiqProdVendido.kmtVentas.FieldByName('kilos_Des').AsFloat:= RResultadosFob.rPesoDestrio;
  DMLiqProdVendido.kmtVentas.FieldByName('bruto_Des').AsFloat:= RResultadosFob.rNetoDestrio;
  DMLiqProdVendido.kmtVentas.FieldByName('descuento_Des').AsFloat:= RResultadosFob.rDescuentoDestrio;
  DMLiqProdVendido.kmtVentas.FieldByName('gastos_Des').AsFloat:= RResultadosFob.rGastosDestrioFac + RResultadosFob.rGastosDestrioNoFac;
  DMLiqProdVendido.kmtVentas.FieldByName('costeEnvase_Des').AsFloat:= RResultadosFob.rEnvaseDestrio;
  DMLiqProdVendido.kmtVentas.FieldByName('costeSecciones_Des').AsFloat:= RResultadosFob.rSeccionesDestrio;
  DMLiqProdVendido.kmtVentas.FieldByName('neto_Des').AsFloat:= RResultadosFob.rNetoDestrio - ( RResultadosFob.rDescuentoDestrio + RResultadosFob.rGastosDestrioFac +
    RResultadosFob.rGastosDestrioNoFac + RResultadosFob.rGastosDestrioTran + RResultadosFob.rEnvaseDestrio + RResultadosFob.rSeccionesDestrio );
  if RResultadosFob.rPesoDestrio <> 0 then
    DMLiqProdVendido.kmtVentas.FieldByName('precio_Des').AsFloat:= bRoundTo( DMLiqProdVendido.kmtVentas.FieldByName('neto_Des').AsFloat / RResultadosFob.rPesoDestrio, 5 )
  else
    DMLiqProdVendido.kmtVentas.FieldByName('precio_Des').AsFloat:= 0;


  rCosteGenerales:= DMLiqProdVendido.kmtSemana.FieldByName('precio_coste_comercial').Asfloat +
                    DMLiqProdVendido.kmtSemana.FieldByName('precio_coste_produccion').Asfloat +
                    DMLiqProdVendido.kmtSemana.FieldByName('precio_coste_administracion').Asfloat;
  DMLiqProdVendido.kmtVentas.FieldByName('costeGeneral_Seg').AsFloat:= RResultadosFob.rPesoSegunda * rCosteGenerales;
  DMLiqProdVendido.kmtVentas.FieldByName('costeGeneral_Pri').AsFloat:= RResultadosFob.rPesoPrimera * rCosteGenerales;
  DMLiqProdVendido.kmtVentas.FieldByName('costeGeneral_Sal').AsFloat:=
    DMLiqProdVendido.kmtVentas.FieldByName('costeGeneral_Seg').AsFloat +
    DMLiqProdVendido.kmtVentas.FieldByName('costeGeneral_Pri').AsFloat;
  DMLiqProdVendido.kmtVentas.FieldByName('costeGeneral_TEr').AsFloat:= 0;
  DMLiqProdVendido.kmtVentas.FieldByName('costeGeneral_Des').AsFloat:= 0;

  DMLiqProdVendido.kmtVentas.Post;


  (*
  DMLiqProdVendido.kmtAux.Insert;
  DMLiqProdVendido.kmtAux.FieldByName('keySem').AsString:= sSemanaKey;
  DMLiqProdVendido.kmtAux.FieldByName('precio_Pri').AsFloat:= DMLiqProdVendido.kmtVentas.FieldByName('precio_Pri').AsFloat;
  DMLiqProdVendido.kmtAux.FieldByName('precio_Seg').AsFloat:= DMLiqProdVendido.kmtVentas.FieldByName('precio_Seg').AsFloat;
  DMLiqProdVendido.kmtAux.FieldByName('precio_Ter').AsFloat:= DMLiqProdVendido.kmtVentas.FieldByName('precio_Ter').AsFloat;
  DMLiqProdVendido.kmtAux.FieldByName('precio_Des').AsFloat:= DMLiqProdVendido.kmtVentas.FieldByName('precio_Des').AsFloat;
  DMLiqProdVendido.kmtAux.Post;
  *)
end;

(*
function EsCategoriaPrimera( const AEmpresa, AProducto, ACategoria: string ): boolean;
begin
  result:= ACategoria = '1';
end;

function EsCategoriaSegunda( const AEmpresa, AProducto, ACategoria: string ): boolean;
begin
  result:= ACategoria = '2';
end;

function EsCategoriaTercera( const AEmpresa, AProducto, ACategoria: string ): boolean;
begin
  result:= ACategoria = '3';
end;

function EsCategoriaDestrio( const AEmpresa, AProducto, ACategoria: string ): boolean;
begin
  RESULT:= not  EsCategoriaPrimera( AEmpresa, AProducto, ACategoria ) and
           not  EsCategoriaSegunda( AEmpresa, AProducto, ACategoria ) and
           not  EsCategoriaTercera( AEmpresa, AProducto, ACategoria );
end;


procedure TDMLiqProdVendidoEntradas.PutKilosSalidas( var VKilos1, VKilos2, VKilos3, VKilosD: real );
begin
  VKilos1:= 0;
  VKilos2:= 0;
  VKilos3:= 0;
  VKilosD:= 0;

  with qryAux  do
  begin
    Sql.Clear;
    Sql.Add('select empresa_sl empresa, centro_Sal_sl centro_sal, producto_sl producto, categoria_sl categoria, sum(kilos_sl) kilos ');
    Sql.Add('from frf_Sals_l ');
    Sql.Add('where empresa_sl = :empresa ');
    Sql.Add('and centro_Sal_sl = :centro ');
    Sql.Add('and producto_sl =  :producto');
    Sql.Add('and fecha_sl between :fechaini and :fechafin ');
    Sql.Add('group by empresa, centro_sal, producto, categoria ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;
    Open;
    if IsEmpty then
      DMLiqProdVendido.AddWarning( 'No hay ventas' )
    else
    while not Eof do
    begin
      if EsCategoriaPrimera( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos1:= VKilos1 +  FieldByName('kilos').AsFloat
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos2:= VKilos2 +  FieldByName('kilos').AsFloat
      else
      if EsCategoriaSegunda( FieldByName('empresa').AsString, FieldByName('producto').AsString, FieldByName('categoria').AsString ) then
        VKilos3:= VKilos3 +  FieldByName('kilos').AsFloat
      else
        VKilosD:= VKilosD +  FieldByName('kilos').AsFloat;
      Next;
    end;
    Close;
  end;
end;
*)

end.
