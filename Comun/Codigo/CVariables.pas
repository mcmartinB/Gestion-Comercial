{*****************************************************
*  -A TENER EN CUENTA-                               *
*  -------------------                               *
*  almacen --> version almacen                       *
*  almacen+tenerife --> version almacen de Tenerife  *
*****************************************************}

unit CVariables;

interface

uses Graphics, BGrid, BCalendario, IniFiles, SysUtils, Printers, Dialogs, Windows, Controls;

//***************************************************************
//TIPOS
//***************************************************************
type
  // Tipos de formularios
  TFormulario = (tfDirector, tfMaestro, tfMaestroDetalle, tfOther);
  // Tipos de estado
  TEstado = (teEspera, teOperacionDetalle, teConjuntoResultado, teLocalizar,
    teModificar, teBorrar, teAlta);
  // Tipos de estado detalle
  TEstadoDetalle = (tedEspera, tedOperacionMaestro, tedNoConjuntoResultado,
    tedConjuntoResultado, tedModificar, tedBorrar, tedAlta, tedAltaRegresoMaestro);
  // Posicion del cursor en la tabla
  TPosicionCursor = (pcInicio, pcFin, pcMedio, pcNulo);

  RDataConexion = record
    sDescripcion: String;
    sBDName: String;
    sBDServer: String;
    sBDDriver: String;
    sBDUser: String;
    sBDPass: String;
  end;


//***************************************************************
//CONSTANTES
//***************************************************************
const
  //para controlar las actualizaciones se realizen
  kVersion = 1;

  //Color moneyGreen
  clMoneyGreen = $00C0DCC0;

  //Para rejillas y salida de nombres
  kNull = 0;
  kCalendar = 999;
  kAll = 1000;
  kMaestro = 2000;
  kDetalle = 3000;
  kOtros = 4000;
  kEmpresa = 1;
  kProducto = 2;
  kCosechero = 3;
  kEstructura = 4;
  kCultivo = 5;
  kSustrato = 6;
  kVariedad = 7;
  kCampo = 8;
  kTipoVia = 9;
  kProvincia = 10;
  kTransportista = 11;
  kCentro = 12;
  kPlantacion = 13;
  kCodPostal = 14;
  kPais = 15;
  kRepresentante = 16;
  kFormaPago = 17;
  kMoneda = 18;
  kCliente = 19;
  kSuministro = 20;
  kEnvase = 21;
  kEnvaseProducto = 22;
  kEnvaseProductoBase = 23;
  kMarca = 24;
  kCalibre = 25;
  kCategoria = 26;
  kColor = 27;
  kTipoPalet = 28;
  kBanco = 29;
  kImpuesto = 30;
  kTipoGastos = 31;
  kAlbaran = 32;
  kProductoBase = 33;
  kTipoUnidad = 34;
  kCalibreBase = 35;
  kProductor = 36;
  kProveedor = 37;
  kProveedorAlmacen = 38;
  kSeccionContable = 39;
  kFederacion = 40;
  kAduana = 41;
  kFormato = 42;
  kFormatoCliente = 43;
  kEan13Unidad = 44;
  //kCompra = 45;
  kTipoEntrada = 46;

  kIncoterm = 47;
  kAgrupacionEnvase = 48;
  kAgrupacionGasto = 49;
  kEnvComerOperador = 50;
  kEnvComerProducto = 51;
  kEnvComerAlmacen = 52;
  kLineaProducto = 53;

  //kCuentaBanco = 55;
  //kTipoPago= 56;
  //kFormaPagoEx= 57;
  kFormatoEntrada = 58;
  kTipoCaja = 59;
  //kTipoSuminitro = 60;

  //kFincaAlmacen = 61;
  //kSectorFinca = 62;
  kAgrupacionComercial = 63;
  kEan13Envase = 64;
  kTipoCliente = 65;
  kComercial = 66;
  kCategoriaPBase = 67;
  kCalibrePBase = 68;
  kColorPBase = 69;
  kTipoSalida = 70;
  ktipoCoste = 71;
  kAgrupacion = 72;
  kSerie = 73;
  kCamion = 74;



//***************************************************************
//VARIABLES
//***************************************************************
var
  //para controlar las actualizaciones se realizen
  giVersion: Integer;

     //Para saber si esta deplegado la rejilla flotante
  gRF: TBGrid; //Rejilla flotante
  gCF: TBCalendario; //Calendario flotante
     // *****************************************************************

  gsAplicVersion: string;

  //Usuario
  gsCodigo, gsPassword, gsNombre, gsMaquina, gsDirIP: string;
  iBDCount, iBDDataConexion: Integer;
  arDataConexion: array of RDataConexion;
  gbTerminalserver, gbFirmar, gbAlmacen: boolean;

  gbEscritura, gbEnlaceContable: Boolean;
  gsDirCorreo, gsHostCorreo, gsCuentaCorreo, gsUsarioCorreo, gsClaveCorreo, gsDescripcionCorreo: string;

  //Impresoras BAG
  giPrintDef: integer;
  //Impresoras SAT
  giPrintDefault: integer;
  //Impresoras SAT-BAG
  giPrintPDF: integer;

  //Directorios
  gsDirActual, gsDirEdi: String;
  gsDirFirmasLocal, gsDirFirmasGlobal: String;

  //Valores por defecto
  gsDefEmpresa, gsDefCentro, gsDefProducto, gsDefCliente: string;

  //Mensaje pie de pagina
  MsgPiePagina: string = 'ORIGINAL';

  //Modo depuracion
  gbAplicDepurar: boolean = false;

  //Temporal --> True metodo antiguo - False metodo nuevo
  gbAjustarSeleccionado: boolean = False;

  gsAuxString : string;
  function EsVisible( const AControl: TControl ): boolean;

implementation

function IsDelphiRunning: boolean;
begin
  Result := (FindWindow('TAppBuilder', nil) > 0) and
    (FindWindow('TPropertyInspector', nil) > 0) and
    (FindWindow('TAlignPalette', nil) > 0);
end;

function EsVisible( const AControl: TControl ): boolean;
begin
  try
    result:= AControl.Visible;
  except
    result:= false;
  end;
end;

end.

