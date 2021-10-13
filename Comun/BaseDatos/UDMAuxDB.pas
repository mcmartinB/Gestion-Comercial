
//#atencion Comprobar que so se pasen parametros vacios o no validos ????? Rendimiento contra seguridad! Llamadora o llamada!
unit UDMAuxDB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, CVariables;

type
  //Zona de influencia
  TZonaGeografica = (zgPeninsular, zgCanario, zgComunitario, zgExtra);

  TImpuesto = record
    sCodigo: string;
    sTipo: string;
    sDescripcion: string;
    rGeneral, rReducido, rSuper: Real;
  end;

  TDMAuxDB = class(TDataModule)
    prc_cambio: TStoredProc;
    QAux: TQuery;
    qpr_cliente_es_de: TQuery;
    qpr_centro_es_de: TQuery;
    qpr_datos_impuestos: TQuery;
    TAux: TTable;
    qpr_suminis_es_de: TQuery;
    qpr_nom_provincia: TQuery;
    qpr_peso_caja_palet: TQuery;
    qpr_peso_camion: TQuery;
    QDescripciones: TQuery;
    QGeneral: TQuery;
    QAjustesLiq: TQuery;
    qpr_recargo_equivalencia: TQuery;
  private
    { Private declarations }
    function IntValue(const ASqlText: string): integer;

  public
    { Public declarations }
    function CentroCMR( const AEmpresa, ACentro: String ): boolean;

  protected
    procedure Loaded; override;
  end;

function Coletilla( const AEmpresa: string ): string;

function DatosTabla(const ANomTabla: string): string;

//****************//****************//****************//****************
//****************LIQUIDACIONES
//****************//****************//****************//****************
function GetAjusteLiq( const AEmpresa: string; const ACosechero: integer;
                       const AProducto: string; const AAnyoSemana: integer;
                       const Acategoria: string ): real;


//****************//****************//****************//****************
//****************BORRADO DE TABLAS
//****************//****************//****************//****************
procedure BorrarTabla(tabla: string;
  MostrarError: boolean = true;
  PropagaError: boolean = true);
procedure BorrarTemporal(tabla: string);

//****************//****************//****************//****************
//****************EJECUCION DE QUERYS
//****************//****************//****************//****************
  //Todas dev -1 si hay error
  //Dev numero de registros seleccionados
function ConsultaOpen(query: TQuery;
  MostrarError: boolean = true;
  PropagaError: boolean = true): Integer; Overload;
function ConsultaOpen(query: TQuery; Cadena: string;
  MostrarError: boolean = true;
  PropagaError: boolean = true): Integer; Overload;
  //Dev numero de  registros modificados-insertados
function ConsultaExec(cadena: string;
  MostrarError: boolean = true;
  PropagaError: boolean = true): Integer; Overload;
function ConsultaExec(query: TQuery;
  MostrarError: boolean = true;
  PropagaError: boolean = true): Integer; Overload;

//****************//****************//****************//****************
//****************PREPARACION DE QUERYS
//****************//****************//****************//****************
procedure ConsultaPrepara(Query: TQuery; Cadena: string;
  Prepara: boolean = false);
procedure ConsultaDesPrepara(Query: TQuery);


//****************//****************//****************//****************
//****************CUESTIONES GEOGRAFICAS Y DE IMPUESTOS
//****************//****************//****************//****************
function ExentoImpuestos(const AEmpresa, ACliente: string): boolean;
function ImpuestosEntre(const AEmpresa, ACentro, ACliente, ASuministro: string ): string;
function ImpuestosCliente(const AEmpresa, ACentro, ACliente, ASuministro: string; const AFecha: TDate ): TImpuesto;
function TipoIVAEnvase(const AEmpresa, AEnvase, AProducto: string ): Integer;
function TipoIvaEnvaseProducto( const AEmpresa, AEnvase, AProducto: string ): Integer;
function DesImpuesto(const impuesto: string): string;
function ImpuestosActuales(const sAImpuesto: string; var  rVSuper, rVReducido, rVGeneral: real; const bARecargo: Boolean = False ): string;

function DireccionEmailCentro( const AEmpresa, ACentro: string ): string;

//****************//****************//****************//****************
//****************DATOS PRODUCTO
//****************//****************//****************//****************
function ProductoEsTomate(empresa, producto: string): boolean;

//****************//****************//****************//****************
//****************DATOS PLANTACIONES
//****************//****************//****************//****************
function CalcularAnoSemana(empresa, producto, cosechero, plantacion, fecha: string; const AActiva: Boolean = True ): string;

//****************//****************//****************//****************
//****************DATOS PROVINCIA
//****************//****************//****************//****************
function NomProvincia(codigo: string; pais: string = 'ES'): string;
function Incoterm( const AEmpresa, ACliente, ASuministro: string ): string;

//****************//****************//****************//****************
//****************CAJAS Y PALETS DE ENTRADA
//****************//****************//****************//****************
procedure PesoCajasPalets(empresa, centro, producto: string;
  var caja, palet: real;
  var cajas: Integer);

//****************//****************//****************//****************
//****************PESO DEL CAMION
//****************//****************//****************//****************
function PesoTransporte(empresa, camion: string): Integer;


//****************//****************//****************//****************
//****************DESCRIPCIONES
//****************//****************//****************//****************
function desEmpresa(const empresa: string): string;
function desEmpresaNif(const empresa: string): string;
function desCentro(const empresa, centro: string): string;
function PaisCliente(const empresa, cliente: string): string;
function desCliente(const cliente: string): string;
function PorteCliente(const empresa, cliente: string): Integer;
function desClienteBAG(const ACliente: string): string;
function desProveedor(const AEmpresa, AProveedor: string): string;
function desProveedorAlmacen(const AEmpresa, AProveedor, AAlmacen: string): string;
function desProducto(const empresa, producto: string): string;
function desAgrupacion(const agrupacion: string): string;
function desProductoAlta(const producto: string): string;
function desProductoVenta(const producto: string): string;
function desProductoCorto(const empresa, producto: string): string;
function desProductoBase(const AEmpresa, AProductoBase: string): string;
function desLineaProducto(const ALinea: string): string;
function desTransporte(const empresa, transporte: string): string;
function desCamion(const camion: string): string;
function desCosechero(const empresa, cosechero: string): string;
function desFormatoEntrada(const empresa, centro, producto, formato: string): string;
function desPlantacionEx(empresa, producto, cosechero, plantacion, fecha: string): string;
function desPlantacion(empresa, producto, cosechero, plantacion, anyoSemana: string): string;
function desPais(const pais: string; const AOriginal: Boolean = False ): string;
function desIncoterm(const AIncoterm: string): string;
function desFederacion(const AFederacion: string): string;
function desRepresentante(const representante: string): string;
function desMoneda(const moneda: string): string;
function desFormato(const AEmpresa, AFormato: string): string;
function desFormatoCliente(const AEmpresa, ACliente, ASuministro, AFormatoCli, AFechaPedido: string): string;
function desFormaPago(const forma: string): string;
function desFormaPagoEx(const forma: string): string;
function desProvincia(const codPostal: string): string;
function desTipoSalida(const sVTipoSalida: string): string;
function desColor(const empresa, producto, color: string): string;
function desColorBase(const AEmpresa, AProductoBase, AColor: string): string;
function desMarca(const marca: string): string;
function desTipoPalet(const palet: string): string;
function desPlanta(const empresa: string): string;
function destEmpresa(const empresa: string): string;
function desTipoCoste(const tipocoste:string): string;

function EsProductoAlta (const AProducto: string): boolean;
function EsProductoVenta (const AProducto: string): boolean;

function ExisteEnvase(const AEmpresa, AEnvase, AProducto: string): boolean;
function desEnvase(const empresa, envase: string): string;
function desEnvaseProducto(const AEmpresa, AEnvase, AProducto: string): string;
function desProductoEnvase(const AEmpresa, AEnvase: string): string;
function desEnvasePBase(const AEmpresa, AEnvase, AProductoBase: string): string;
function desEnvaseP(const AEmpresa, AEnvase, AProducto: string): string;
function desEnvaseCli(const AEmpresa, AEnvase, ACliente: string): string;
function desSeccionContable(const AEmpresa, ASeccion: string): string;

function desEnvComerProducto(const AOperador, Aproducto: string): string;
function desEnvComerOperador(const AOperador: string): string;
function desEnvComerAlmacen(const AOperador, AAlmacen: string): string;

function desCategoria(const empresa, producto, catego: string): string;
function desCategoriaBase(const AEmpresa, AProductoBase, ACategoria: string): string;
function desSuministro(const empresa, cliente, dirSum: string): string;
function desPaisSuministro(const empresa, cliente, dirSum: string): string;
function desSuministroEx(const empresa, cliente, dir_sum_sc: string): string;
function desBanco(const banco: string): string;

function desTipoGastos(const gasto: string): string;
function desTipoUnidad(const emp, tipo, producto: string): string;
function desTipoCaja(const ATipoCajas: string): string;
function desAduana(const aduana: string): string;
function desVariedad(const AEmpresa, AProveedor, AProducto, AVariedad : string): string;
function desTipoEntrada(const AEmpresa, ATipo: string): string;
function desPeriodoFacturacion( const APeriodoFact: string): string;


function desEnvaseCliente(const empresa, producto, envase, cliente: string;
//  const esEspanyol: integer = -1; const AUnidades: Integer = 0 ): string;
    const esEspanyol: integer = -1 ):string;
function desEnvaseClienteEx(const empresa, producto, envase, cliente: string;
  const esEspanyol: integer = -1): string;
function desVariedadCliente (const envase, cliente: string):string;

function GetProductoBase(const empresa, producto: string): string;
function GetProducto(const AEmpresa, AProductoBase: string): string;
function GetProductoEnvase(const Empresa, Envase: string): string;
function GetProductoBaseEnvase(const empresa, envase: string): string;

function EsClienteSeguro(const AEmpresa, ACliente: string): boolean;
function ClienteConRecargo(const AEmpresa, ACliente: string; const AFecha: TDate ): boolean;

function desCampo(const tipo, valor: string): string;

function AlbaranEnviado(const AEmpresa, ACliente: string; const AALbaran: Integer;  const AFecha: TDateTime ): Boolean;
function ForzarEnvioAlbaran(const AEmpresa, ACliente: string; const AALbaran: Integer;  const AFecha: TDateTime ): Boolean;

function TieneGranada( const AEmpresa, ACentro: String; const AFecha: TDate; const AALbaran: Integer): Boolean;
function TipoAlbaran( const AEmpresa, ACliente: String ): Integer;

function IntraStatProveedor( const AEmpresa, AProveedor: string ): string;

function ExisteCalibre(const empresa, producto, calibre: string): boolean;

function Valortmensajes: String;

function CodigoX3Transporte( const empresa, transporte:string): string;

function ObtenerPrecioVenta(const fecha, cliente, envase: string): real;

function DesTipoCliente(const ATipoCliente: string): string;

function DesComercial(const AComercial: string): string;
function  GetCodeComercial( const AEmpresa, ACliente: string ): string;
function DesUsuario(const usuario:string): string;
procedure InsertarPBLog( const empresa, centro, sscc, usuario, documento:String; const peso, cajas: Real; const tipoMovimiento: integer);
procedure InsertarPCLog( const empresa, centro, sscc, usuario, documento:String; const peso, cajas: Real; const tipoMovimiento: integer);
procedure BorrarPBLog( const documento, sscc: String; const movimiento: integer );
procedure BorrarPCLog( const documento, sscc: String; const movimiento: integer );



var
  DMAuxDB: TDMAuxDB;

implementation

{$R *.DFM}

uses DError, bNumericUtils, bSQLUtils, UDMConfig, UDMMaster, CGlobal;

//****************//****************//****************//****************
//****************PREPARAR-DESPREPARAR QUERYS
//****************//****************//****************//****************

function TDMAuxDB.IntValue(const ASqlText: string): integer;
begin
  with QDescripciones do
  begin
    SQL.Text := ASqlText;
    try
      try
        Open;
        if IsEmpty then
          result := -1
        else
          result := Fields[0].AsInteger;
      except
        result := -1;
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

procedure TDMAuxDB.Loaded;
begin
  with qpr_datos_impuestos do
  begin
    SQL.Clear;
    SQL.add(' select tipo_i, descripcion_i, general_il, reducido_il, super_il, recargo_general_il, recargo_reducido_il, recargo_super_il ');
    SQL.add(' from frf_impuestos, frf_impuestos_l ');
    SQL.add(' where codigo_i = :codigo ');
    SQL.add(' and codigo_il = :codigo ');
    SQL.add(' and :fecha  between fecha_ini_il and case when fecha_fin_il is null then :fecha else fecha_fin_il end ');
  end;
  with qpr_recargo_equivalencia do
  begin
    SQL.Clear;
    SQL.add(' select * ');
    SQL.add(' from frf_impuestos_recargo_cli ');
    SQL.add(' where empresa_irc = :empresa ');
    SQL.add(' and cliente_irc = :cliente ');
    SQL.Add(' and recargo_irc <> 0 ');
    SQL.add(' and :fecha  between fecha_ini_irc and case when fecha_fin_irc is null then :fecha else fecha_fin_irc end ');
  end;
  with qpr_centro_es_de do
  begin
    SQL.Clear;
    SQL.add(' SELECT tipo_impuesto_c tipo_iva ');
    SQL.add(' FROM frf_centros Frf_centros ');
    SQL.add(' WHERE   (empresa_c = :empresa) ');
    SQL.add('    AND  (centro_c = :centro) ');
  end;
  with qpr_cliente_es_de do
  begin
    SQL.Clear;
    SQL.add(' SELECT case when pais_fac_c is null then pais_c else pais_fac_c end pais,  ');
    SQL.add('        case when cod_postal_fac_c is null then cod_postal_c[1,2] else cod_postal_fac_c[1,2] end prov,  ');
    SQL.add('        es_comunitario_c comu, substr(nif_c,1,2) pais_nif  ');
    SQL.add(' FROM frf_clientes Frf_clientes ');
    SQL.add(' WHERE  (cliente_c = :cliente) ');
  end;
  with qpr_suminis_es_de do
  begin
    SQL.Clear;
    SQL.add(' select pais_ds pais, cod_postal_ds[1,2] prov ');
    SQL.add(' from frf_dir_sum ');
    SQL.add(' where cliente_ds=:cliente ');
    SQL.add(' and dir_sum_ds=:dirsum ');
  end;


  with qpr_nom_provincia do
  begin
    SQL.Clear;
    SQL.add(' select nombre_p ');
    SQL.add(' from frf_provincias ');
    SQL.add(' where codigo_p=:cod ');
  end;
  with qpr_peso_caja_palet do
  begin
    SQL.Clear;
    SQL.add(' select peso_palet_p palet,peso_caja_p caja,cajas_palet_p cajas ');
    SQL.add(' from frf_pesos ');
    SQL.add(' where empresa_p=:empresa ');
    SQL.add(' and centro_p=:centro ');
    SQL.add(' and producto_p=:producto ');
  end;
  with qpr_peso_camion do
  begin
    SQL.Clear;
    SQL.add(' select tara_c peso ');
    SQL.add(' from frf_camiones ');
    SQL.add(' where camion_c=:camion ');
  end;
  with QAjustesLiq do
  begin
    SQL.Clear;
    SQL.add(' select ajuste_al ');
    SQL.add(' from frf_ajustes_liq ');
    SQL.add(' where empresa_al = :empresa ');
    SQL.add(' and cosechero_al = :cosechero ');
    SQL.add(' and producto_al = :producto ');
    SQL.add(' and categoria_al = :categoria ');
    SQL.add(' and anyo_semana_al = :anyosemana ');
  end;
end;


//****************//****************//****************//****************
//****************LIQUDACIONES
//****************//****************//****************//****************
function GetAjusteLiq( const AEmpresa: string; const ACosechero: integer;
                       const AProducto: string; const AAnyoSemana: integer;
                       const ACategoria: string ): real;
begin
  result := 1;
  with DMAuxDB.QAjustesLiq do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('producto').AsString := AProducto;
    ParamByName('categoria').AsString := ACategoria;
    ParamByName('cosechero').AsInteger := ACosechero;
    ParamByName('anyosemana').AsInteger := AAnyoSemana;
    try
      Open;
    except
      Close;
      Exit;
    end;
    if not IsEmpty then
    begin
      result := Fields[0].asfloat;
    end
    else
    begin
      //Grupo bonnysa
      Close;
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('producto').AsString := AProducto;
      ParamByName('categoria').AsString := ACategoria;
      ParamByName('cosechero').AsInteger := 0;
      ParamByName('anyosemana').AsInteger := AAnyoSemana;
      Open;
      if not IsEmpty then
      begin
        result := Fields[0].asfloat;
      end;
    end;
    Close;
  end;
end;


function TDMAuxDB.CentroCMR( const AEmpresa, ACentro: String ): boolean;
begin
  if ( AEmpresa = '050' ) and ( ACentro = '6' ) then
  begin
    result:= True;
  end
  else
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select pais_c from frf_centros ');
      SQL.Add(' where empresa_c = :empresa and centro_c = :centro' );
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('centro').AsString:= ACentro;
      Open;
      result:= FieldByName('pais_c').AsString <> 'ES';
      Close;
    end;
  end;
end;

//****************//****************//****************//****************
//****************BORRADO DE TABLAS
//****************//****************//****************//****************
//#atencion Comprobar que exista la tabla antes de borrar

procedure BorrarTabla(tabla: string;
  MostrarError: boolean = true;
  PropagaError: boolean = true);
begin
  //Comprobar que exista
  with DMAuxDB.TAux do
  begin
    TableName := tabla;
    if not Exists then Exit;
    {else DeleteTable;
    Exit;}
  end;

  //Borrar
  with DMAuxDB.QAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    //Borrar tabla
    SQL.Clear;
    SQL.Add(' drop table ' + Tabla);
    try
      ExecSQL;
    except
      on E: EDBEngineError do
      begin
        if MostrarError then ShowError(E);
        if PropagaError then raise;
      end;
    end;
  end;
end;

procedure BorrarTemporal(tabla: string);
begin
  with DMAuxDB.QAux do    //Codigo PEPE
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(' DROP TABLE IF EXISTS ' + Tabla);
    try
      ExecSQL;
    except
      SQL.Clear;
      SQL.Add(' drop table ' + Tabla);
      try
        ExecSQL;
      except
        //
      end;
    end;
  end;

  (*
  with TTable.Create(nil) do      //RICARDO
    try
        DataBaseName:=DMAuxDB.QAux.DataBaseName;
        TableName:=tabla;
        if Exists=True then
        begin
             with DMAuxDB.QAux do    //Codigo PEPE
             begin
                  if Active then
                     Close;
                  SQL.Clear;
                  SQL.Add(' drop table ' + Tabla);
                  try
                     ExecSQL;
                  except
                  end;
             end;
        end;
     finally
            Free;
     end;
  *)
end;

//****************//****************//****************//****************
//****************EJECUCION DE QUERYS
//****************//****************//****************//****************

function ConsultaOpen(Query: TQuery;
  Cadena: string;
  MostrarError: boolean = true;
  PropagaError: boolean = true): Integer;
begin
  with query do
  begin
    //Si la query esta activa la cerramos
    if Active then
    begin
      Cancel;
      Close;
    end;

    //Cargamos consulta
    SQL.Clear;
    SQL.Add(cadena);

    //Ralizar accion pedida
    Result := ConsultaOpen(query, MostrarError, PropagaError);
  end;
end;

function ConsultaOpen(query: TQuery;
  MostrarError: boolean = true;
  PropagaError: boolean = true): Integer;
begin
  try
    query.Open;
  except
    on e: EDBEngineError do
    begin
      if MostrarError then ShowError(E);
      if PropagaError then
        raise
      else
      begin
        ConsultaOpen := -1;
        Exit;
      end;
    end;
  end;
  if Query.IsEmpty then
  begin
    ConsultaOpen := 0;
    if MostrarError then ShowError('Consulta sin datos con los parametros seleccionados.');
  end
  else
    ConsultaOpen := 1;
end;

function ConsultaExec(cadena: string;
  MostrarError: boolean = true;
  PropagaError: boolean = true): Integer;
begin
  with DMAuxDB do
  begin
    //Si la query esta activa la cerramos
    if QAux.Active then
    begin
      QAux.Cancel;
      QAux.Close;
    end;

    //Cargamos consulta
    QAux.SQL.Clear;
    QAux.SQL.Add(cadena);

    //Ralizar accion pedida
    Result := ConsultaExec(QAux, MostrarError, PropagaError);
    (*ShowMessage(IntToStr(QAux.RowsAffected));*)
  end;
end;

function ConsultaExec(query: TQuery;
  MostrarError: boolean = true;
  PropagaError: boolean = true): Integer;
begin
  try
    query.ExecSql;
  except
    on e: EDBEngineError do
    begin
      if MostrarError then ShowError(E);
      if PropagaError then
        raise
      else
      begin
        ConsultaExec := -1;
        Exit;
      end;
    end;
  end;
  ConsultaExec := Query.RowsAffected;
end;

//****************//****************//****************//****************
//****************PREPARACION DE QUERYS
//****************//****************//****************//****************

procedure ConsultaPrepara(Query: TQuery; Cadena: string;
  Prepara: boolean = false);
begin
  with Query do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(Cadena);
    if Prepara then Prepare;
  end;
end;

procedure ConsultaDesPrepara(Query: TQuery);
begin
  with Query do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    if Prepared then UnPrepare;
  end;
end;

//****************//****************//****************//****************
//****************CUESTIONES GEOGRAFICAS Y DE IMPUESTOS
//****************//****************//****************//****************

function GetPaisNif( const APais, ANif: string ): string;
begin
  if DesPais( Copy( ANif, 1, 2 ) ) <> '' then
  begin
    result:= Copy( ANif, 1, 2 );
  end
  else
  begin
    result:= APais;
  end;
end;


function ClienteEsDe( const AEmpresa, ACliente, ADirSum: string ): TZonaGeografica;
var
  pais, prov, comu: string;
begin
  //Cliente
  with DMAuxDB.qpr_cliente_es_de do
  begin
    ParamByName('cliente').AsString := ACliente;
    Open;
    pais := GetPaisNif( FieldByName('pais').AsString, FieldByName('pais_nif').AsString );
    (*
    if FieldByName('pais_nif').AsString = 'FR' then
    begin
      pais := FieldByName('pais_nif').AsString;
    end
    else
    begin
      pais := FieldByName('pais').AsString;
    end;
    *)
    prov := FieldByName('prov').AsString;
    comu := FieldByName('comu').AsString;
    Cancel;
    Close;
  end;

  //Español
  if pais = 'ES' then
  begin
    //Direccion de suministro
    //if (Trim(ADirSum) <> '')  then //and (ADirSum <> ACliente)
    with DMAuxDB.qpr_suminis_es_de do
    begin
      ParamByName('cliente').AsString := ACliente;
      ParamByName('dirsum').AsString := ADirSum;
      Open;
      if not IsEmpty then
      begin
        pais := FieldByName('pais').AsString;
        prov := FieldByName('prov').AsString;
      end;
      Cancel;
      Close;
    end;

    //Canario
    if ( pais = 'ES' ) and ( (prov = '38') or (prov = '35') ) then
      ClienteEsDe := zgCanario
    //Peninsular
    else
     ClienteEsDe := zgPeninsular;
  end
  else
  //Extranjero
  begin
    if comu = 'S' then
      ClienteEsDe := zgComunitario
    else
      ClienteEsDe := zgExtra;
  end;
end;

function ImpuestosEntre(const AEmpresa, ACentro, ACliente, ASuministro: string ): string;
var
  sAux: string;
begin
//  if ACliente = 'WEB' then
//  begin
//    Result:= 'IR';
//  end
//  else
//  begin
    with DMAuxDB.qpr_centro_es_de do
    begin
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      Open;
      sAux:= FieldByName('tipo_iva').AsString;
      Close;
    end;

    if ( sAux = 'IVA' ) then
    begin
        case ClienteEsDe( AEmpresa, ACliente, ASuministro ) of
          zgPeninsular: //Destino peninsula IGIC normal
            ImpuestosEntre := 'IR';
          zgComunitario: //CEE sin IVA
            ImpuestosEntre := 'IC';
          zgCanario, zgExtra: //Otros sin IVA
            ImpuestosEntre := 'IE';
        end;
    end
    else
    if sAux = 'IGIC' then
    begin
        case ClienteEsDe( AEmpresa, ACliente, ASuministro ) of
          zgCanario: //Destino canario IGIC normal
            ImpuestosEntre := 'GR';
          zgPeninsular, zgComunitario, zgExtra: //Otros sin IGIC
            ImpuestosEntre := 'GE';
        end;
    end
    else
    if sAux = 'EXEN' then
    begin
      //Exento
      Result:= 'E';
    end
    else
    begin
      raise Exception.Create('Falta el tipo de IVA a aplicar al centro.');
    end;
//  end;
end;

function ExentoImpuestos(const AEmpresa, ACliente: string): Boolean;
begin
  Result := ( ACliente = 'RET' );
end;

function ClienteConRecargo(const AEmpresa, ACliente: string; const AFecha: TDate ): boolean;
begin
    with DMAuxDB.qpr_recargo_equivalencia do
    begin
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('cliente').AsString := ACliente;
      ParamByName('fecha').AsDate := AFecha;
      try
        Open;
        Result:= not IsEmpty;
      finally
        Close;
      end;
    end;
end;

function ImpuestosCliente(const AEmpresa, ACentro, ACliente, ASuministro: string; const AFecha: TDate ): TImpuesto;
var
  sAux: string;
  rRecargoGeneral, rRecargoReducido, rRecargoSuper: Real;
begin
  if not ExentoImpuestos(AEmpresa, ACliente) then
  begin
    sAux := ImpuestosEntre( AEmpresa, ACentro, ACliente, ASuministro );
    with DMAuxDB.qpr_datos_impuestos do
    begin
      ParamByName('codigo').AsString := sAux;
      ParamByName('fecha').AsDate := AFecha;
      Open;
      result.sCodigo := sAux;
      result.sTipo := FieldByName('tipo_i').AsString;
      result.sDescripcion := FieldByName('descripcion_i').AsString;
      (*IVA*)
      result.rGeneral := FieldByName('general_il').AsFloat;
      result.rReducido := FieldByName('reducido_il').AsFloat;
      result.rSuper := FieldByName('super_il').AsFloat;
      (*RECARGO*)
      rRecargoGeneral := FieldByName('recargo_general_il').AsFloat ;
      rRecargoReducido := FieldByName('recargo_reducido_il').AsFloat;
      rRecargoSuper := FieldByName('recargo_super_il').AsFloat;
      Cancel;
      Close;
    end;
    if ClienteConRecargo( AEmpresa, ACliente, AFecha ) then
    begin
      result.rGeneral := result.rGeneral + rRecargoGeneral;
      result.rReducido := result.rReducido + rRecargoReducido;
      result.rSuper := result.rSuper + rRecargoSuper;
    end;
  end
  else
  begin
    result.sCodigo := 'E';
    result.sTipo := 'EXEN';
    result.sDescripcion := 'EXENTO';
    result.rGeneral := 0;
    result.rReducido := 0;
    result.rSuper := 0;
  end;
end;

(*IVA*)
//Result -> 0:super 1:reducido 2:general
function TipoIVAEnvase(const AEmpresa, AEnvase, AProducto: string ): Integer;
begin
  DMAuxDB.QAux.SQL.Clear;
  DMAuxDB.QAux.SQL.Add('select tipo_iva_e ');
  DMAuxDB.QAux.SQL.Add('from frf_envases ');
  DMAuxDB.QAux.SQL.Add('where producto_e = :producto ');
  DMAuxDB.QAux.SQL.Add('and envase_e = :envase ');
  DMAuxDB.QAux.ParamByName('producto').AsString:= AProducto;
  DMAuxDB.QAux.ParamByName('envase').AsString:= AEnvase;
  DMAuxDB.QAux.Open;
  if not DMAuxDB.QAux.IsEmpty then
    result:= DMAuxDB.QAux.FieldByName('tipo_iva_e').AsInteger
  else
    result:= -1;
  DMAuxDB.QAux.Close;
end;

function TipoIvaEnvaseProducto( const AEmpresa, AEnvase, AProducto: string ): Integer;
var
  sAux: string;
begin
  DMAuxDB.QAUx.SQL.Clear;
  DMAuxDB.QAUx.SQL.Add(' select producto_base_p');
  DMAuxDB.QAUx.SQL.Add(' from frf_productos');
  DMAuxDB.QAUx.SQL.Add(' where producto_p = :producto ');
  DMAuxDB.QAUx.ParamByName('producto').AsString:= AProducto;
  DMAuxDB.QAUx.Open;
  sAux:= DMAuxDB.QAux.FieldByName('producto_base_p').AsString;
  DMAuxDB.QAUx.Close;
  Result:= TipoIvaEnvase( AEmpresa, AEnvase, AProducto );
end;

function DireccionEmailCentro( const AEmpresa, ACentro: string ): string;
begin
  ConsultaPrepara(DMAuxDB.Qaux,
    ' Select email_c from frf_centros ' +
    ' Where empresa_c= :empresa and centro_c= :centro ');
  with DMAuxDB.Qaux do
  begin
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ConsultaOpen(DMAuxDB.Qaux);
    Result := FieldByName('email_c').AsString;
    Close;
  end;
end;


//****************//****************//****************//****************
//****************DATOS PRODUCTO
//****************//****************//****************//****************

function ProductoEsTomate(empresa, producto: string): Boolean;
var
  sAux: string;
begin
  sAux:= ' Select estomate_p from frf_productos ';
  if producto <> '' then
  begin
    sAux:= sAux + ' where producto_p=:producto ';
  end;
  sAux:= sAux + ' order by 1';
  ConsultaPrepara(DMAuxDB.Qaux, sAux  );
  if producto <> '' then
  begin
    DMAuxDB.Qaux.ParamByName('producto').AsString := producto;
  end;
  ConsultaOpen(DMAuxDB.Qaux);
  try
    result := DMAuxDB.Qaux.FieldByName('estomate_p').AsString = 'S';
  finally
    DMAuxDB.Qaux.Close;
  end;
end;

//****************//****************//****************//****************
//****************DATOS PLANTACIONES
//****************//****************//****************//****************

function CalcularAnoSemana(empresa, producto, cosechero, plantacion, fecha: string; const AActiva: Boolean = True ): string;
var
  sAux: string;
begin
  sAux := ' empresa_p= ' + QuotedStr(empresa) + ' ' +
    'AND producto_p= ' + QuotedStr(producto) + ' ' +
    'AND cosechero_p= ' + cosechero + ' ' +
    'AND plantacion_p= ' + plantacion + ' ';

  if AActiva then
    sAux := sAux + ' and fecha_fin_p is null  ';

  ConsultaPrepara(DMAuxDB.Qaux,
    ' SELECT DISTINCT  fecha_inicio_p, ano_semana_p ano_semana' +
    ' FROM frf_plantaciones  ' +
    ' WHERE ' + sAux +
    ' AND fecha_inicio_p<=:fecha ' +
    ' ORDER BY fecha_inicio_p desc ');

  with DMAuxDB.Qaux do
  begin
    ParamByName('fecha').AsDateTime := StrToDate(fecha);
    if ConsultaOpen(DMAuxDB.Qaux, False, False) <> 0 then
      CalcularAnoSemana := FieldByName('ano_semana').AsString
    else
      CalcularAnoSemana := '';
    Close;
  end;
end;

//****************//****************//****************//****************
//****************DATOS PROVINCIA
//****************//****************//****************//****************

function NomProvincia(codigo: string; pais: string = 'ES'): string;
begin
  NomProvincia := '';
  with DMAuxDB do
    if (trim(codigo) <> '') and (pais = 'ES') then
    begin
      qpr_nom_provincia.ParamByName('cod').AsString := codigo;
      if ConsultaOpen(qpr_nom_provincia, False, False) <> 0 then
      begin
        NomProvincia := qpr_nom_provincia.fields[0].AsString;
      end;
      qpr_nom_provincia.cancel;
      qpr_nom_provincia.Close;
    end;
end;

function Incoterm( const AEmpresa, ACliente, ASuministro: string ): string;
begin
  with DMAuxDB.QAux do
  begin
    SQl.clear;
    SQl.Add(' select incoterm_c, plaza_incoterm_c, pais_c, cod_postal_c, poblacion_c, cod_postal_ds, provincia_ds ');
    SQl.Add(' from frf_clientes, outer frf_dir_sum ');
    SQl.Add(' where cliente_c = :cliente ');
    SQl.Add('  and cliente_ds = cliente_c ');
    SQl.Add('  and dir_sum_ds = :suministro ');
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('suministro').AsString:= ASuministro;
    Open;
    if not IsEmpty then
    begin
      if FieldByName('incoterm_c').AsString <> '' then
      begin
        if FieldByName('plaza_incoterm_c').AsString <> '' then
        begin
          result := FieldByName('incoterm_c').AsString + ' ' +  FieldByName('plaza_incoterm_c').AsString;
        end
        else
        begin
          if FieldByName('pais_c').AsString = 'ES' then
          begin
            if FieldByName('cod_postal_ds').AsString <> '' then
            begin
              result := FieldByName('incoterm_c').AsString + ' ' +  NomProvincia( Copy( FieldByName('cod_postal_ds').AsString, 1, 2 ) );
            end
            else
            begin
              result := FieldByName('incoterm_c').AsString + ' ' +  NomProvincia( Copy( FieldByName('cod_postal_c').AsString, 1, 2 ) );
            end;
          end
          else
          begin
            if FieldByName('provincia_ds').AsString <> '' then
            begin
              result := FieldByName('incoterm_c').AsString + ' ' +  FieldByName('provincia_ds').AsString;
            end
            else
            begin
              result := FieldByName('incoterm_c').AsString + ' ' +  FieldByName('poblacion_c').AsString;
            end;
          end;
        end;
      end
      else
      begin
        Close;
        result:= '';
      end;
    end
    else
    begin
      Close;
      result:= '';
    end;
  end;
end;

procedure PesoCajasPalets(empresa, centro, producto: string;
  var caja, palet: real;
  var cajas: Integer);
begin
  //INICIALIZACION
  caja := 0;
  palet := 0;
  cajas := 0;

  //PROCESO
  with DMAuxDB do
    if (trim(empresa) <> '') and
      (trim(centro) <> '') and
      (trim(producto) <> '') then
    begin
      qpr_peso_caja_palet.ParamByName('empresa').AsString := empresa;
      qpr_peso_caja_palet.ParamByName('centro').AsString := centro;
      qpr_peso_caja_palet.ParamByName('producto').AsString := producto;

      if ConsultaOpen(qpr_peso_caja_palet, False, False) > 0 then
      begin
        cajas := qpr_peso_caja_palet.FieldByName('cajas').AsInteger;
        caja := qpr_peso_caja_palet.FieldByName('caja').AsFloat;
        palet := qpr_peso_caja_palet.FieldByName('palet').AsFloat;
      end;

      qpr_peso_caja_palet.cancel;
      qpr_peso_caja_palet.Close;
    end;
end;

function PesoTransporte(empresa, camion: string): Integer;
begin
  //PROCESO
  with DMAuxDB do
    if (trim(camion) <> '') then
    begin
      qpr_peso_camion.ParamByName('camion').AsInteger := StrToInt(camion);

      if ConsultaOpen(qpr_peso_camion, False, False) > 0 then
      begin
        PesoTransporte := Redondea(qpr_peso_camion.FieldByName('peso').AsFloat);
      end
      else
      begin
        PesoTransporte := 0;
      end;

      qpr_peso_camion.cancel;
      qpr_peso_camion.Close;
    end
    else
    begin
      PesoTransporte := 0;
    end;
end;


//***************************************************************************
//***************************************************************************
//EXTRAER DESCRIPCIONES
//***************************************************************************
//***************************************************************************

function Descripcion(sqlCad: string): string;
begin
  Result := '';
with DMAuxDB.QDescripciones do
  begin
    SQL.Text := sqlCad;
    try
      try
        Open;
        if not IsEmpty then
        begin
          while not Eof do
          begin
            if Result = '' then
              Result := Trim( Fields[0].AsString )
            else
            begin
              if Pos( Trim( Fields[0].AsString ), Result ) = 0 then
                Result := Result + ' / ' + Trim( Fields[0].AsString )
            end;
            Next;
          end;
          {
          next;
          if Eof then
            Descripcion := Fields[0].AsString
          else
          begin
            prior;
            Descripcion := Fields[0].AsString + ' (*)';
          end;
          }
        end;
      except
        Descripcion := '';
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function DescripcionEx(sqlCad: string): string;
begin
  with DMAuxDB.QDescripciones do
  begin
    SQL.Text := sqlCad;
    try
      try
        Open;
        if IsEmpty then
          DescripcionEx := ''
        else
        begin
          next;
          if Eof then
            DescripcionEx := Fields[0].AsString
          else
            DescripcionEx := Fields[1].AsString + ' #';
        end;
      except
        DescripcionEX := '';
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function desEmpresa(const empresa: string): string;
begin
  desEmpresa := '';
  if Trim(empresa) = '' then Exit;
  Result := Descripcion(' select nombre_e from frf_empresas ' +
    ' where empresa_e=' + QuotedStr(empresa));
end;

function desPlanta(const empresa: string) : string;
begin
  desPlanta := '';
  if Trim(empresa) = '' then Exit;
  Result := Descripcion(' select nombre_pln from tplantas ' +
    ' where planta_pln =' + QuotedStr(empresa));
end;

function destEmpresa(const empresa: string) : string;
begin
  destEmpresa := '';
  if Trim(empresa) = '' then Exit;
  Result := Descripcion(' select nombre_emp from tempresas ' +
    ' where empresa_emp =' + QuotedStr(empresa));
end;

function desTipoCoste(const tipocoste:string): string;
begin
  desTipoCoste := '';
  Result := Descripcion(' select descripcion_tc from frf_tipo_costes ' +
    ' where codigo_tc =' + QuotedStr(tipocoste));
end;

function desEmpresaNif(const empresa: string): string;
begin                                        
  Result := '';
  if Trim(empresa) = '' then Exit;
  Result := Descripcion(' select nombre_e || '' CIF: '' || nif_e from frf_empresas ' +
    ' where empresa_e=' + QuotedStr(empresa));
end;

function desCentro(const empresa, centro: string): string;
begin
  desCentro := '';
  if (Trim(empresa) = 'BAG') then
  begin
    if ( Trim(centro) = '') then Exit;
    Result := Descripcion(' select descripcion_c from frf_centros ' +
      ' where empresa_c[1,1 ]= ''F'' ' +
      ' and centro_c=' + QuotedStr(centro) + ' group by 1');
  end
  else
  if (Trim(empresa) = 'SAT') then
  begin
    if ( Trim(centro) = '') then Exit;
    Result := Descripcion(' select descripcion_c from frf_centros ' +
      ' where ( empresa_c = ''050''  or empresa_c = ''080''  )' +
      ' and centro_c=' + QuotedStr(centro) + ' group by 1');
  end
  else
  begin
    if (Trim(empresa) = '') or (Trim(centro) = '') then Exit;
    Result := Descripcion(' select descripcion_c from frf_centros ' +
      ' where empresa_c=' + QuotedStr(empresa) + ' ' +
      ' and centro_c=' + QuotedStr(centro) + ' ');
  end;
end;

function desCliente(const cliente: string): string;
begin
  Result := Descripcion(' select nombre_c from frf_clientes ' +
                        ' where cliente_c=' + QuotedStr(cliente) );
end;

function PorteCliente(const empresa, cliente: string): integer;
begin
  Result := DMAuxDB.IntValue(' select grabrar_transporte_c from frf_clientes ' +
                     ' where cliente_c=' + QuotedStr(cliente) );

  //si grabrar conste transporte cliente = 1 entonces el porte lo paga bonny ->  porte cliente = 0
  if Result = 0 then
    Result:= 1
  else
    Result:= 0;
end;


function PaisCliente(const empresa, cliente: string): string;
begin
  result := '';
  if (Trim(empresa) = '') or (Trim(cliente) = '') then Exit;
  Result := Descripcion(' select pais_c from frf_clientes ' +
    ' where cliente_c=' + QuotedStr(cliente) + ' ');
end;

function desClienteBAG(const ACliente: string): string;
begin
  if (Trim(ACliente) = '') then
  begin
    result:= '';
  end
  else
  begin
    Result := Descripcion(' select max(nombre_c) from frf_clientes ' +
      ' where cliente_c=' + QuotedStr(ACliente) + ' ');
  end;
end;


function desProveedor(const AEmpresa, AProveedor: string): string;
begin
//  result:= UDMMaster.DMMaster.desProveedor( AEmpresa, AProveedor );

  result := '';
  if (Trim(AProveedor) = '') then
    Exit;
  Result := Descripcion(' select nombre_p from frf_proveedores ' +
    ' where proveedor_p=' + QuotedStr(AProveedor) + ' ');
end;

function desProveedorAlmacen(const AEmpresa, AProveedor, AAlmacen: string): string;
begin
  result := '';
  if (Trim(AProveedor) = '') or (Trim(AAlmacen) = '') then
    Exit;
  Result := Descripcion(' select nombre_pa from frf_proveedores_almacen ' +
    ' where proveedor_pa=' + QuotedStr(AProveedor) + ' ' +
    '   and almacen_pa=' + AAlmacen + ' ');
end;

function desProducto(const empresa, producto: string): string;
begin
  desProducto := '';
  if (Trim(producto) = '') then
    Exit;
  Result := Descripcion(' select descripcion_p from frf_productos ' +
                        ' where producto_p=' + QuotedStr(producto) + ' ');
end;

function desAgrupacion(const agrupacion: string): string;
begin
  desAgrupacion := '';
  if (agrupacion = '') then
    Exit;
  Result := Descripcion(' select DISTINCT nombre_a from frf_agrupacion ' +
                        ' where codigo_a=' + QuotedStr(agrupacion) );
end;

function desProductoAlta(const producto: string): string;
begin
  desProductoAlta := '';
  if (Trim(producto) = '') then
    Exit;
  Result := Descripcion(' select descripcion_p from frf_productos ' +
                        ' where producto_p=' + QuotedStr(producto) +
                        '   and fecha_baja_p is null  ' );
end;

function desProductoVenta(const producto: string): string;
begin
  desProductoVenta := '';
  if (Trim(producto) = '') then
    Exit;
  Result := Descripcion(' select descripcion_p from frf_productos ' +
                        ' where producto_p=' + QuotedStr(producto) +
                        '   and fecha_baja_p is null  '  +
                        '   and tipo_venta_p = ''S'' ');
end;

function desProductoCorto(const empresa, producto: string): string;
begin
  Result := desProducto( empresa, producto );
  if result <> '' then
  begin
    Result:= Trim( StringReplace( Result, 'TOMATE', 'T.', []) );
    if Result = 'T.' then
      Result:= 'TOMATE';
  end;
end;

function desProductoBase(const AEmpresa, AProductoBase: string): string;
begin
  desProductoBase := '';
  if (Trim(AEmpresa) = '') or (Trim(AProductoBase) = '') then Exit;
  Result := Descripcion(' select descripcion_pb from frf_productos_base ' +
    ' where empresa_pb ' + SQLEqualS(AEmpresa) +
    ' and producto_base_pb ' + SQLEqualS(AProductoBase));
end;

function GetProductoBase(const empresa, producto: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select producto_base_p ' +
      ' from frf_productos ' +
      ' where producto_p ' + SQLEqualS(producto);
    try
      try
        Open;
        if IsEmpty then
          result := ''
        else
          result := Fields[0].AsString;
      except
        result := '';
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function GetProducto(const AEmpresa, AProductoBase: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select producto_p ' +
      ' from frf_productos ' +
      ' where producto_base_p ' + SQLEqualS(AProductoBase);
    try
      try
        Open;
        if IsEmpty then
          result := ''
        else
          result := Fields[0].AsString;
      except
        result := '';
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function GetProductoEnvase(const empresa, envase: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select producto_e ' +
      ' from frf_envases ' +
      ' where envase_e ' + SQLEqualS(envase);
    try
      try
        Open;
        if IsEmpty then
          result := ''
        else
          result := Fields[0].AsString;
      except
        result := '';
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function GetProductoBaseEnvase(const empresa, envase: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select producto_base_e ' +
      ' from frf_envases ' +
      ' where envase_e ' + SQLEqualS(envase);
    try
      try
        Open;
        if IsEmpty then
          result := ''
        else
          result := Fields[0].AsString;
      except
        result := '';
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function desLineaProducto(const ALinea: string): string;
begin
  Result := '';
  if (Trim(ALinea) = '') then
   Exit;
  Result := Descripcion(' select descripcion_lp from frf_linea_productos ' +
      ' where linea_producto_lp=' + QuotedStr(ALinea) + ' group by 1');
end;

function desTransporte(const empresa, transporte: string): string;
begin
  Result := '';
  if ( Trim(transporte) = '') then Exit;
  Result := Descripcion(' select descripcion_t from frf_transportistas ' +
    ' where transporte_t=' + QuotedStr(transporte) );
end;

function desCamion(const camion: string): string;
begin
  Result := '';
  if ( Trim(camion) = '') then Exit;
  Result := Descripcion(' select descripcion_c from frf_camiones ' +
    ' where camion_c=' + QuotedStr(camion) );
end;


function desCosechero(const empresa, cosechero: string): string;
begin
  desCosechero := '';
  if (Trim(empresa) = '') or (Trim(cosechero) = '') then Exit;
  Result := Descripcion(' select nombre_c from frf_cosecheros ' +
    ' where empresa_c=' + QuotedStr(empresa) + ' ' +
    ' and cosechero_c=' + QuotedStr(cosechero) + ' ');
end;

function desFormatoEntrada(const empresa, centro, producto, formato: string): string;
var
  sAux: string;
begin
  sAux:= WhereAddString( sAux, 'empresa_p', empresa, true );
  sAux:= WhereAddString( sAux, 'centro_p', centro, true );
  sAux:= WhereAddString( sAux, 'producto_p', producto, true );
  sAux:= WhereAddString( sAux, 'formato_p', formato, false );

  Result := Descripcion(' select descripcion_p from frf_pesos ' + sAux );
end;

function desPais(const pais: string; const AOriginal: Boolean = False ): string;
begin
  desPais := '';
  if Trim(pais) = '' then
    Exit;
  if AOriginal then
    Result := Descripcion(' select case  when  trim( nvl( original_name_p, '''' ) ) = '''' then descripcion_p else original_name_p end ' +
                          ' from frf_paises where pais_p=' + QuotedStr(pais) )
  else
    Result := Descripcion(' select descripcion_p ' +
                          ' from frf_paises where pais_p=' + QuotedStr(pais) );
end;

function desIncoterm(const AIncoterm: string): string;
begin
  Result := '';
  if Trim(AIncoterm) = '' then Exit;
  Result := Descripcion('select Trim(descripcion_i) || '' ('' || Trim(descripcion_es_i) || '')'' descripcion ' +
                        ' from frf_incoterms where codigo_i = ' + QuotedStr(AIncoterm) );
end;

function desFederacion(const AFederacion: string): string;
begin
  result := '';
  if Trim(AFederacion) = '' then Exit;
  Result := Descripcion(' select provincia_f from frf_federaciones ' +
    ' where codigo_f=' + QuotedStr(AFederacion));
end;

function desRepresentante(const representante: string): string;
begin
  desRepresentante := '';
  if Trim(representante) = '' then Exit;
  Result := Descripcion(' select descripcion_r from frf_representantes ' +
    ' where representante_r=' + QuotedStr(representante) + ' ');
end;

function desTipoCliente(const ATipoCliente: string): string;
begin
  if ATipoCliente = '' then
    Result := ''
  else
  begin
    Result := Descripcion(' select descripcion_ctp from frf_cliente_tipos where codigo_ctp = ' + QuotedStr(ATipoCliente));
  end;
end;

function desComercial(const AComercial: string): string;
begin
  if (Trim(AComercial) = '') then
    result := ''
  else
    Result := Descripcion(' select descripcion_c from frf_comerciales where codigo_c = ' + QuotedStr(AComercial) + ' ');
end;

function desMoneda(const moneda: string): string;
begin
  desMoneda := '';
  if Trim(moneda) = '' then Exit;
  Result := Descripcion(' select descripcion_m from frf_monedas ' +
    ' where moneda_m=' + QuotedStr(moneda));
end;

function desFormaPago(const forma: string): string;
begin
  desFormaPago := '';
  if Trim(forma) = '' then Exit;
  Result := Descripcion(' select descripcion_fp from frf_forma_pago ' +
    ' where codigo_fp=' + QuotedStr(forma));
end;

function desFormato(const AEmpresa, AFormato: string): string;
begin
  Result := '';
  if ( Trim(AEmpresa) = '' ) or
     ( Trim(AFormato) = '' ) then
    Exit;
  Result := Descripcion(' select nombre_f ' +
                        ' from frf_formatos ' +
                        ' where empresa_f = ' +QuotedStr( AEmpresa ) +
                        ' and codigo_f = ' +QuotedStr( AFormato ) );
end;

function desFormatoCliente(const AEmpresa, ACliente, ASuministro, AFormatoCli, AFechaPedido: string ): string;
begin
  Result := '';
  if ( Trim(AEmpresa) = '' ) or
     ( Trim(ACliente) = '' ) or
     ( Trim(AFormatoCli) = '' ) then
    Exit;
  if ASuministro <> '' then
  begin
    Result := DescripcionEx(' select descripcion_fc, nombre_f, nvl( fecha_baja_f, today ) fecha_baja_f ' +
                          ' from frf_formatos_cli, frf_formatos ' +
                          ' where empresa_fc = ' +QuotedStr( AEmpresa ) +
                          ' and cliente_fc = ' +QuotedStr( ACliente ) +
                          ' and suministro_fc = ' +QuotedStr( ASuministro ) +
                          ' and formato_cliente_fc = ' +QuotedStr( AFormatoCli ) +
                          ' and ( fecha_baja_f is null or fecha_baja_f > ' + QuotedStr( AFechaPedido ) + '  ) ' +
                          ' and fecha_alta_f <= ' + QuotedStr( AFechaPedido ) +
                          ' and empresa_fc = empresa_f ' +
                          ' and formato_fc = codigo_f ' +
                          ' group by 1, 2, 3 ' +
                          ' order by fecha_baja_f desc ');
    if Result = '' then
    begin
      Result := DescripcionEx(' select descripcion_fc, nombre_f,  nvl( fecha_baja_f, today ) fecha_baja_f ' +
                          ' from frf_formatos_cli, frf_formatos ' +
                          ' where empresa_fc = ' +QuotedStr( AEmpresa ) +
                          ' and cliente_fc = ' +QuotedStr( ACliente ) +
                          ' and suministro_fc = ' +QuotedStr( '*' ) +
                          ' and formato_cliente_fc = ' +QuotedStr( AFormatoCli )  +
                          ' and ( fecha_baja_f is null or fecha_baja_f > ' + QuotedStr( AFechaPedido ) + '  ) ' +
                          ' and fecha_alta_f <= ' + QuotedStr( AFechaPedido ) +
                          ' and empresa_fc = empresa_f ' +
                          ' and formato_fc = codigo_f ' +
                          ' group by 1, 2, 3 ' +
                          ' order by fecha_baja_f desc ');
    end;
    if Result = '' then
    begin
      Result := DescripcionEx(' select descripcion_fc, nombre_f,  nvl( fecha_baja_f, today ) fecha_baja_f ' +
                          ' from frf_formatos_cli, frf_formatos ' +
                          ' where empresa_fc = ' +QuotedStr( AEmpresa ) +
                          ' and cliente_fc = ' +QuotedStr( ACliente ) +
                          ' and suministro_fc = ' +QuotedStr( '' ) +
                          ' and formato_cliente_fc = ' +QuotedStr( AFormatoCli )  +
                          ' and ( fecha_baja_f is null or fecha_baja_f > ' + QuotedStr( AFechaPedido ) + '  ) ' +
                          ' and fecha_alta_f <= ' + QuotedStr( AFechaPedido ) +
                          ' and empresa_fc = empresa_f ' +
                          ' and formato_fc = codigo_f ' +
                          ' group by 1, 2, 3 ' +
                          ' order by fecha_baja_f desc ');
    end;
  end
  else
  begin
    Result := DescripcionEx(' select descripcion_fc, nombre_f,  nvl( fecha_baja_f, today ) fecha_baja_f ' +
                          ' from frf_formatos_cli, frf_formatos ' +
                          ' where empresa_fc = ' +QuotedStr( AEmpresa ) +
                          ' and cliente_fc = ' +QuotedStr( ACliente ) +
                          ' and formato_cliente_fc = ' +QuotedStr( AFormatoCli )  +
                          ' and ( fecha_baja_f is null or fecha_baja_f > ' + QuotedStr( AFechaPedido ) + '  ) ' +
                          ' and fecha_alta_f <= ' + QuotedStr( AFechaPedido ) +
                          ' and empresa_fc = empresa_f ' +
                          ' and formato_fc = codigo_f ' +
                          ' group by 1, 2, 3 ' +
                          ' order by fecha_baja_f desc ');
  end;
end;

function desFormaPagoEx(const forma: string): string;
var
  i: integer;
begin
  result := '';
  if Trim(forma) = '' then Exit;
  with DMAuxDB.QDescripciones do
  begin
    SQL.Text := ' select descripcion_fp, descripcion2_fp, ' +
      '      descripcion3_fp, descripcion4_fp, ' +
      '      descripcion5_fp, descripcion6_fp, ' +
      '      descripcion7_fp, descripcion8_fp, descripcion9_fp' +
      ' from frf_forma_pago ' +
      ' where codigo_fp=' + QuotedStr(forma);
    try
      try
        Open;
        if not IsEmpty then
        begin
          result := Fields[0].AsString;
          for i := 1 to 8 do
          begin
            if Trim(Fields[i].AsString) <> '' then
              result := result + #13 + #10 + Fields[i].AsString;
          end
        end;
      except
        //result:='';
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function desProvincia(const codPostal: string): string;
begin
  desProvincia := '';
  if Trim(codPostal) = '' then Exit;
  Result := Descripcion(' select nombre_p from frf_provincias ' +
    ' where codigo_p=' + QuotedStr(Copy(codPostal, 1, 2)));
end;

function desTipoSalida(const sVTipoSalida: string): string;
begin
  if Trim(sVTipoSalida) <> '' then
    Result := Descripcion(' select descripcion_ts from frf_tipo_salida where codigo_ts = ' + sVTipoSalida )
  else
    result := '';
end;

function desColor(const empresa, producto, color: string): string;
begin
  desColor := '';
  if (Trim(empresa) = '') or (Trim(producto) = '') or (Trim(color) = '') then Exit;
  Result := Descripcion(' select descripcion_c from frf_colores ' +
    ' where producto_c=' + QuotedStr(producto) +
    ' and color_c=' + QuotedStr(color));
end;

function desColorBase(const AEmpresa, AProductoBase, AColor: string): string;
begin
  result := '';
  if (Trim(AEmpresa) = '') or (Trim(AProductoBase) = '') or (Trim(AColor) = '') then Exit;

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(producto_p) producto_p from frf_productos ' +
            ' where producto_base_p=' + AproductoBase );
    Open;
    if IsEmpty then
    begin
      Result:= '';
    end
    else
    begin
      Result := Descripcion(' select descripcion_c from frf_colores ' +
          ' where producto_c=' + QuotedStr(FieldByName('producto_p').AsString) +
          ' and color_c=' + QuotedStr(AColor));
    end;
    Close;
  end;
end;

function desMarca(const marca: string): string;
begin
  desMarca := '';
  if Trim(marca) = '' then Exit;
  Result := Descripcion(' select descripcion_m from frf_marcas ' +
    ' where codigo_m=' + QuotedStr(marca));
end;

function desTipoPalet(const palet: string): string;
begin
  desTipoPalet := '';
  if Trim(palet) = '' then Exit;
  Result := Descripcion(' select descripcion_tp from frf_tipo_palets ' +
    ' where codigo_tp=' + QuotedStr(palet));
end;

function desEnvase(const empresa, envase: string): string;
begin
  Result:= '';
  if (Trim(envase) = '')
    then Exit;

  Result := Descripcion(' select descripcion_e from frf_envases ' +
    ' where envase_e=' + QuotedStr(envase) + ' ');
end;

function EsProductoAlta(const AProducto: string): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_productos ' );
    SQL.Add(' where producto_p = ' + QuotedStr(AProducto) );
    SQL.Add('   and fecha_baja_p is null ');
    Open;
    Result:= not IsEmpty;
    Close;
  end;
end;

function EsProductoVenta(const AProducto: string): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_productos ' );
    SQL.Add(' where producto_p = ' + QuotedStr(AProducto) );
    SQL.Add('   and fecha_baja_p is null ');
    SQl.Add('   and tipo_venta_p = ''S'' ');
    Open;
    Result:= not IsEmpty;
    Close;
  end;
end;

function ExisteEnvase(const AEmpresa, AEnvase, AProducto: string): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_Envases ' );
    SQL.Add(' where envase_e = ' + QuotedStr(AEnvase) );
    SQL.Add(' and producto_e = ' + QuotedStr(AProducto) );
    Open;
    Result:= not IsEmpty;
    Close;
  end;
end;

function desEnvasePBase(const AEmpresa, AEnvase, AProductoBase: string): string;
begin
  result := '';

  if trim(AEmpresa) = 'BAG' then
  begin
    if Trim(AEnvase) = '' then Exit;
    if Trim(AProductoBase) <> '' then
    begin
      Result := Descripcion(' select descripcion_e from frf_envases ' +
        ' where envase_e=' + QuotedStr(AEnvase) +
        ' and producto_base_e=' + AProductoBase ) + ' group by 1 ';
    end
    else
    begin
      Result := Descripcion(' select descripcion_e from frf_envases ' +
        ' where envase_e=' + QuotedStr(AEnvase) );
        //+ ' and nvl(producto_base_e,'''') = '''' ');
    end;
  end
  else
  begin
    if trim(AEmpresa) = '' then  Exit;
    if Trim(AEnvase) = '' then Exit;

    if Trim(AProductoBase) <> '' then
    begin
      Result := Descripcion(' select descripcion_e from frf_envases ' +
        ' where envase_e=' + QuotedStr(AEnvase) +
        ' and producto_base_e=' + AProductoBase );
    end
    else
    begin
      Result := Descripcion(' select descripcion_e from frf_envases ' +
        ' where envase_e=' + QuotedStr(AEnvase) );
        //+ ' and nvl(producto_base_e,'''') = '''' ');
    end;
  end;
end;

function desEnvaseP(const AEmpresa, AEnvase, AProducto: string): string;
begin
  result := '';
  if trim(AEmpresa) = '' then  Exit;
  if Trim(AEnvase) = '' then Exit;

  if Trim(AProducto) = '' then
  begin
//    Result :=  desEnvasePBase( AEmpresa, AEnvase, '' );
    Result :=  desEnvaseProducto( AEmpresa, AEnvase, '' );
  end
  else
  begin
//    Result := desEnvasePBase( AEmpresa, AEnvase, GetProductoBase( AEmpresa, AProducto) );
    Result := desEnvaseProducto( AEmpresa, AEnvase, AProducto );
  end;
end;

function desProductoEnvase(const AEmpresa, AEnvase: string): String;
begin
  if trim(AEmpresa) = '' then  Exit;
  if Trim(AEnvase) = '' then Exit;

  Result := Descripcion(' select producto_e from frf_envases ' +
      ' where envase_e=' + QuotedStr(AEnvase) );
end;

function desEnvaseProducto(const AEmpresa, AEnvase, AProducto: string): string;
begin
  result := '';

  if trim(AEmpresa) = '' then  Exit;
  if Trim(AEnvase) = '' then Exit;

  if Trim(AProducto) = '' then
  begin
    Result := Descripcion(' select descripcion_e from frf_envases ' +
      ' where envase_e=' + QuotedStr(AEnvase) );
  end
  else
  begin
    Result := Descripcion(' select descripcion_e from frf_envases ' +
      ' where envase_e=' + QuotedStr(AEnvase) +
      ' and producto_e=' + QuotedStr(AProducto) );
{
    if Result = '' then
    begin
      Result := Descripcion(' select descripcion_e from frf_envases ' +
        ' where envase_e=' + QuotedStr(AEnvase) +
        ' and empresa_e=' + QuotedStr(AEmpresa) +
        ' and nvl(producto_base_e,'''') = '''' ');
    end;
}
  end;
end;

function desEnvaseCli(const AEmpresa, AEnvase, ACliente: string ): string;
begin
  Result := Descripcion(' select descripcion_ce from frf_clientes_env ' +
    ' where empresa_ce ' + SQLEqualS(AEmpresa) +
    '   and envase_ce ' + SQLEqualS(AEnvase) +
    '   and cliente_ce ' + SQLEqualS(ACliente));
  if Result = '' then
  begin
    Result:=  desEnvase( AEmpresa, AEnvase );
  end;
end;

//esEspanyol: -1 [No lo se] 0 [Extranjero] 1 [Español]
function desEnvaseCliente(const empresa, producto, envase, cliente: string;
//  const esEspanyol: integer = -1; const AUnidades: Integer = 0 ): string;
    const esEspanyol: integer = -1 ):string;
var
  enEspanyol: boolean;
begin
  desEnvaseCliente := '';
  Result := Descripcion(' select descripcion_ce from frf_clientes_env ' +
    ' where empresa_ce ' + SQLEqualS(empresa) +
    '   and producto_ce ' + SQLEqualS(producto) +
    '   and envase_ce ' + SQLEqualS(envase) +
    '   and cliente_ce ' + SQLEqualS(cliente));
  if Result = '' then
  begin
    if esEspanyol = -1 then
    begin
      with DMAuxDB.QDescripciones do
      begin
        SQL.Text := ' select pais_c ' +
          ' from frf_clientes ' +
          ' where cliente_c=' + QuotedStr(cliente);
        try
          try
            Open;
            if IsEmpty then
              enEspanyol := true;
            enEspanyol := Fields[0].AsString = 'ES';
          except
            enEspanyol := true;
          end;
        finally
          Cancel;
          Close;
        end;
      end;
    end
    else
    begin
      enEspanyol := esEspanyol = 1;
    end;

    with DMAuxDB.QDescripciones do
    begin
      SQL.Text := ' select descripcion_e, descripcion2_e, unidades_variable_e ' +
        ' from frf_envases ' +
        ' where envase_e=' + QuotedStr(envase) +
        ' and ( producto_e=' + QuotedStr(producto) + ' or producto_e is null ) ';
      try
        try
          Open;
          if IsEmpty then
          begin
            result := '';
            Exit;
          end;
        except
          result := '';
          Exit;
        end;

        if enEspanyol then
        begin
          Result := Fields[0].AsString;
        end
        else
        begin
          if Trim(Fields[1].AsString) <> '' then
          begin
            Result := Fields[1].AsString;
          end
          else
          begin
            Result := Fields[0].AsString;
          end;
        end;

        (*
        if ( AUnidades <> 0 ) and ( Fields[2].AsInteger <> 0 ) then
        begin
          Result := Result + ' ' + IntToStr( AUnidades )+ 'Uds.';
        end;
        *)

      finally
        Cancel;
        Close;
      end;
    end;
  end;
  (*
  else
  begin
    if ( AUnidades <> 0 ) then
    with DMAuxDB.QDescripciones do
    begin
      SQL.Text := ' select unidades_variable_e ' +
        ' from frf_envases ' +
        ' where envase_e=' + QuotedStr(envase) +
        ' and empresa_e=' + QuotedStr(empresa) +
        ' and ( producto_base_e ' + SQLEqualN(productoBase) + ' or producto_base_e is null ) ';
      Open;
      if ( Fields[0].AsInteger <> 0 ) then
      begin
        Result := Result + ' ' + IntToStr( AUnidades )+ 'Uds.';
      end;
      Close;
    end;
  end;
  *)
end;

function desVariedadCliente(const envase, cliente: string): string;
begin
  Result := Descripcion(' select variedad_ce from frf_clientes_env ' +
    ' where envase_ce ' + SQLEqualS(envase) +
    '   and cliente_ce ' + SQLEqualS(cliente));

end;

function desEnvaseClienteEx(const empresa, producto, envase, cliente: string;
  const esEspanyol: integer = -1): string;
begin
  result := desEnvaseCliente(empresa, GetProductoBase(empresa, producto),
    envase, cliente, esEspanyol);
end;

function desCategoria(const empresa, producto, catego: string): string;
begin
  desCategoria := '';
  if (Trim(empresa) = '') or (Trim(producto) = '') or (Trim(catego) = '') then Exit;
  Result := Descripcion(' select descripcion_c from frf_categorias ' +
    ' where producto_c=' + QuotedStr(producto) +
    ' and categoria_c=' + QuotedStr(catego));
end;

function ExisteCalibre(const empresa, producto, calibre: string): boolean;
begin
  result := false;
  if (Trim(producto) = '') or (Trim(calibre) = '') then
    Exit;
  Result := calibre = Descripcion(' select calibre_c from frf_calibres ' +
    ' where producto_c=' + QuotedStr(producto) +
    ' and calibre_c=' + QuotedStr(calibre));
end;

function desCategoriaBase(const AEmpresa, AProductoBase, ACategoria: string): string;
begin
  result := '';
  if (Trim(AEmpresa) = '') or (Trim(AProductoBase) = '') or (Trim(ACategoria) = '') then Exit;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(producto_p) producto_p from frf_productos ' +
            ' where producto_base_p=' + AProductoBase );
    Open;
    if IsEmpty then
    begin
      Result:= '';
    end
    else
    begin
      Result := Descripcion(' select descripcion_c from frf_categorias ' +
        ' where producto_c=' + QuotedStr(FieldByName('producto_p').AsString) +
        ' and categoria_c=' + QuotedStr(ACategoria));
    end;
    Close;
  end;
end;

function desCampo(const tipo, valor: string): string;
begin
  desCampo := '';
  if (Trim(tipo) = '') or (Trim(valor) = '') then Exit;
  Result := Descripcion(' select descripcion_c from frf_campos ' +
    ' where campo_c=' + QuotedStr(tipo) + ' ' +
    ' and tipo_c=' + QuotedStr(valor) + ' ');
end;

function desSuministro(const empresa, cliente, dirSum: string): string;
begin
  Result := '';
    if (Trim(cliente) = '') or (Trim(dirSum) = '') then
      Exit;
    Result := Descripcion(' select nombre_ds from frf_dir_sum ' +
      ' where cliente_ds=' + QuotedStr(cliente) +
      ' and dir_sum_ds=' + QuotedStr(dirSum) );
end;

function desPaisSuministro(const empresa, cliente, dirSum: string): string;
begin
  Result := '';
    if (Trim(cliente) = '') or (Trim(dirSum) = '') then
      Exit;
    Result := Descripcion(' select descripcion_p ' +
      ' from frf_dir_sum, outer(frf_paises) ' +
      ' where cliente_ds =' + QuotedStr(cliente) +
      ' and dir_sum_ds=' + QuotedStr(dirSum) +
      ' and pais_p = pais_ds ');
end;

function desSuministroEx(const empresa, cliente, dir_sum_sc: string): string;
var
  aux: string;
begin
  aux := desSuministro(empresa, cliente, dir_sum_sc);
  if aux = '' then aux := desCliente(dir_sum_sc);
  desSuministroEx := aux;
end;

function desImpuesto(const impuesto: string): string;
begin
  desImpuesto := '';
  if Trim(impuesto) = '' then Exit;
  Result := Descripcion(' select descripcion_i from frf_impuestos ' +
    ' where codigo_i=' + QuotedStr(impuesto));
end;


function ImpuestosActuales(const sAImpuesto: string; var  rVSuper, rVReducido, rVGeneral: real; const bARecargo: Boolean = False ): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_impuestos_l ');
    SQL.Add(' where today between fecha_ini_il and nvl( fecha_fin_il, today ) ');
    SQL.Add(' and codigo_il = :tipo ');
    ParamByName('tipo').AsString:= sAImpuesto;
    Open;
    try
      if bARecargo then
      begin
        rVSuper:= FieldByName('super_il').AsFloat + FieldByName('recargo_super_il').AsFloat;
        rVReducido:= FieldByName('reducido_il').AsFloat + FieldByName('recargo_reducido_il').AsFloat;
        rVGeneral:= FieldByName('general_il').AsFloat + FieldByName('recargo_general_il').AsFloat;
      end
      else
      begin
        rVSuper:= FieldByName('super_il').AsFloat;
        rVReducido:= FieldByName('reducido_il').AsFloat;
        rVGeneral:= FieldByName('general_il').AsFloat;
      end;
    finally
      Close;
    end;
  end;
end;

function desBanco(const banco: string): string;
begin
  Result := '';
  if Trim(banco) = '' then
    Exit;
  Result := Descripcion(' select descripcion_b from frf_bancos ' +
    ' where banco_b=' + QuotedStr(banco));
end;


function desTipoGastos(const gasto: string): string;
begin
  desTipoGastos := '';
  if Trim(gasto) = '' then Exit;
  Result := Descripcion(' select descripcion_tg from frf_tipo_gastos ' +
    ' where tipo_tg=' + QuotedStr(gasto));
end;

function desPlantacionEx(empresa, producto, cosechero, plantacion, fecha: string): string;
var
  anyosemana: string;
begin
  if (Trim(empresa) <> '') and (Trim(cosechero) <> '') and
    (Trim(producto) <> '') and (Trim(plantacion) <> '') then
  begin
    anyoSemana := CalcularAnoSemana(empresa, producto, cosechero, plantacion,
      fecha);
    desPlantacionEx := desPlantacion(empresa, producto, cosechero, plantacion, anyoSemana);
  end
  else
  begin
    desPlantacionEX := '';
  end;
end;


function desPlantacion(empresa, producto, cosechero, plantacion, anyoSemana: string): string;
var
  aux: string;
begin
  if (Trim(empresa) <> '') and (Trim(cosechero) <> '') and
    (Trim(producto) <> '') and (Trim(plantacion) <> '') and
    (Trim(anyoSemana) <> '') then
  begin
    aux := ' SELECT DISTINCT  ano_semana_p, descripcion_p ' +
      ' FROM frf_plantaciones ' +
      ' WHERE empresa_p=' + QuotedStr(empresa) + ' ';

    aux :=  aux + '    AND producto_p  =' + QuotedStr(producto) + ' ';

    aux :=  aux + '    AND cosechero_p=' + cosechero +
      '    AND plantacion_p=' + plantacion +
      '    AND ano_semana_p=' + anyosemana;
    if ConsultaOpen(DMAuxDB.QAux, aux, False) = 1 then
      desPlantacion := DMAuxDB.QAux.FieldByName('descripcion_p').AsString
    else
      desPlantacion := '';
  end
  else
  begin
    desPlantacion := '';
  end;
end;

function desTipoUnidad(const emp, tipo, producto: string): string;
begin
  desTipoUnidad := '';
  if (Trim(emp) = '') or (Trim(tipo) = '') or  (Trim(producto) = '') then Exit;
  Result := Descripcion(' select descripcion1_uc from frf_und_consumo ' +
//    ' where empresa_uc=' + QuotedStr(emp) +
    '   where codigo_uc=' + QuotedStr(tipo) +
    '   and producto_uc=' + QuotedStr(producto) );
end;

function desTipoCaja(const ATipoCajas: string): string;
begin
  if (Trim(ATipoCajas) <> '') then
    Result := Descripcion(' select descripcion_tc  from frf_tipos_caja where codigo_tc = ' + QuotedStr(ATipoCajas))
  else
    Result := '';
end;

function desEnvComerOperador(const AOperador: string): string;
begin
  if (Trim(AOperador) <> '') then
    Result := Descripcion(' select des_operador_eco from frf_env_comer_operadores where cod_operador_eco = ' + QuotedStr(AOperador))
  else
    Result := '';
end;

function desEnvComerAlmacen(const AOperador, AAlmacen: string): string;
begin
  if (Trim(AOperador) <> '') AND (Trim(AAlmacen) <> '') then
    Result := Descripcion(' select des_almacen_eca from frf_env_comer_almacenes where cod_operador_eca = ' + QuotedStr(AOperador) +
                          ' and cod_almacen_eca = '  + QuotedStr(AAlmacen) )
  else
    Result := '';
end;

function desEnvComerProducto(const AOperador, Aproducto: string): string;
begin
  if (Trim(AOperador) <> '') AND (Trim(Aproducto) <> '') then
    Result := Descripcion(' select des_producto_ecp from frf_env_comer_productos where cod_operador_ecp = ' + QuotedStr(AOperador) +
                          ' and cod_producto_ecp = '  + QuotedStr(Aproducto) )
  else
    Result := '';
end;

function desAduana(const aduana: string): string;
begin
  result := '';
  if (Trim(aduana) <> '') then
  begin
    Result := Descripcion(' select descripcion_a from frf_aduanas ' +
      ' where codigo_a=' + QuotedStr(aduana) );
  end;
end;

function desVariedad(const AEmpresa, AProveedor, AProducto, AVariedad : string): string;
begin
  result := '';
  if (Trim(AProveedor) <> '') and
     (Trim(AProducto) <> '') and (Trim(AVariedad) <> '') then
  begin
    Result := Descripcion(' select descripcion_pp from frf_productos_proveedor ' +
                          ' where proveedor_pp = ' + QuotedStr(AProveedor) +
                          '   and producto_pp = ' + QuotedStr(AProducto) +
                          '   and variedad_pp = ' + AVariedad );
  end;
end;

function desSeccionContable(const AEmpresa, ASeccion: string): string;
begin
  result := '';
  if (Trim(AEmpresa) <> '') and (Trim(ASeccion) <> '') then
  begin
    if CGlobal.gProgramVersion = CGlobal.pvBAG then
    begin
       Result := Descripcion(' select descripcion_sc ' +
           ' from frf_secciones_contables ' +
           ' WHERE empresa_sc= ' + QuotedStr( AEmpresa ) +
           ' and seccion_sc = ' + QuotedStr( ASeccion ) );
    end
    else
    begin
      Result := Descripcion(' select descripcion_sc ' +
                            ' from frf_secc_contables ' +
                            ' WHERE empresa_sc= ' + QuotedStr( AEmpresa ) +
                            ' and sec_contable_sc = ' + QuotedStr( ASeccion ) );
    end;
  end;
end;


function desTipoEntrada(const AEmpresa, ATipo: string): string;
var
  sTipo: String;
begin
  if Trim(ATipo) = '' then
    sTipo:= '-1'
  else
    sTipo:= ATipo;

  Result := Descripcion(' select descripcion_et from frf_entradas_tipo ' +
      ' where empresa_et=' + QuotedStr(AEmpresa) +
      ' and tipo_et=' + sTipo );
end;

function desPeriodoFacturacion(const APeriodoFact: string): string;
var sTipo: String;
begin
  if Trim(APeriodoFact) = '' then
    sTipo := 'Sin Periodo'
  else if Trim(APeriodoFact) = 'D' then
    sTipo := 'Fact. Diaria'
  else if Trim(APeriodoFact) = 'S' then
    sTipo := 'Fact. Semanal'
  else if Trim(APeriodoFact) = 'Q' then
    sTipo := 'Fact. Quincenal'
  else if Trim(APeriodoFact) = 'M' then
    sTipo := 'Fact. Mensual';

  Result := sTipo;
end;

function DatosTabla(const ANomTabla: string): string;
var
  i, iCont: integer;
  sAux: string;
  MiQuery: TQuery;
begin
  MiQuery := TQuery.Create(nil);
  MiQuery.DataBaseName := 'BDProyecto';
  try
    with MiQuery do
    begin
      SQL.Clear;
      SQL.Add('select * from ' + ANomTabla);
      Open;
      iCont := 1;
      sAux := '';
      while not eof do
      begin
        i := 0;
        sAux := 'R[' + IntToStr(iCont) + '] -> ';
        while i < Fields.Count do
        begin
          sAux := sAux + Fields[i].FieldName + '=' + Fields[i].AsString + ' ';
          Inc(i);
        end;
        sAux := sAux + #13 + #10;
        Inc(iCont);
        Next;
      end;
      result := sAux;
      Close;
    end;
  finally
    FreeAndNil(MiQuery);
  end;
end;

function EsClienteSeguro(const AEmpresa, ACliente: string): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select seguro_cr seguro_c from frf_clientes, frf_clientes_rie');
    SQL.Add('where cliente_c = :cliente ');
    SQL.Add('  and pais_c = ''ES'' ');
    SQL.Add('  and cliente_cr = cliente_c ');
    SQL.Add('  and empresa_cr = :empresa ');
    SQL.Add('  and fecha_fin_cr is null ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    try
      try
        Open;
        if IsEmpty then
          Result:= false
        else
          Result := Fields[0].AsInteger <> 0;
      except
        Result:= false;
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;

function Coletilla( const AEmpresa: string ): string;
begin
  if AEmpresa = 'F17' then
  begin
    Result:= '1';
  end
  else
  if AEmpresa = 'F18' then
  begin
    Result:= '2';
  end
  else
  if AEmpresa = 'F21' then
  begin
    Result:= '3';
  end
  else
  if AEmpresa = 'F23' then
  begin
    Result:= '4';
  end
  else
  if AEmpresa = 'F24' then
  begin
    Result:= '5';
  end
  else
  if AEmpresa = 'F42' then
  begin
    Result:= '6';
  end
  else
  begin
    Result:= '0';
  end;
end;

function AlbaranEnviado(const AEmpresa, ACliente: string; const AALbaran: Integer;  const AFecha: TDateTime ): Boolean;
var
  aux: boolean;
begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_alb_enviados ');
      SQL.Add(' where empresa_ae = :empresa ');
      SQL.Add(' and cliente_sal_ae = :cliente ');
      SQL.Add(' and fecha_ae = :fecha ');
      SQL.Add(' and n_albaran_ae = :albaran ');
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('cliente').AsString := ACliente;
      ParamByName('albaran').AsInteger := AALbaran;
      ParamByName('fecha').AsDate := AFecha;
      try
        Open;
        aux:= not IsEmpty;
        Result:= aux;
      finally
        Close;
      end;
    end;
end;

function DeboEnviarEmail(const AEmpresa, ACliente: string ): Boolean;
begin
  if ( Copy( ACliente, 1, 1 ) <> '0' ) then
  begin
    DMAuxDB.QAux.SQL.Clear;
    DMAuxDB.QAux.SQL.Add(' select email_alb_c ');
    DMAuxDB.QAux.SQL.Add(' from frf_clientes ');
    DMAuxDB.QAux.SQL.Add(' where cliente_c = :cliente ');
    DMAuxDB.QAux.ParamByName('cliente').AsString := ACliente;
    try
      DMAuxDB.QAux.Open;
      Result:= Pos('@', DMAuxDB.QAux.FieldByName('email_alb_c').AsString ) > 0;
    finally
      DMAuxDB.QAux.Close;
    end;
  end
  else
  begin
    //NO a los clientes empiezan por 0
    Result:= False;
  end;
end;

function ForzarEnvioAlbaran(const AEmpresa, ACliente: string; const AALbaran: Integer;  const AFecha: TDateTime ): Boolean;
begin
  Result:= False;
  if not DMConfig.EsLaFont then
  begin
    if DeboEnviarEmail( AEmpresa, ACliente ) then
      Result:= not AlbaranEnviado( AEmpresa, ACliente, AALbaran, AFecha );
  end;
end;
function TipoAlbaran( const AEmpresa, ACliente: String ): Integer;
begin
  with DMAuxDB.QAux do
  begin
      SQL.Clear;
      SQL.Add(' SELECT tipo_albaran_c ');
      SQL.Add(' FROM frf_clientes ');
      SQL.Add(' WHERE (cliente_c = :cliente) ');
      ParamByName('cliente').AsString := ACliente;
      try
        Open;
        Result:= FieldByname('tipo_albaran_c').AsInteger;
      finally
        Close;
      end;
  end;
end;

function TieneGranada( const AEmpresa, ACentro: String; const AFecha: TDate; const AALbaran: Integer): Boolean;
begin
  with DMAuxDB.QAux do
  begin
      SQL.Clear;
      SQL.Add(' SELECT * ');
      SQL.Add(' FROM frf_salidas_l ');
      SQL.Add(' WHERE (empresa_sl = :empresa) ');
      SQL.Add(' AND   (centro_salida_sl = :centro) ');
      SQL.Add(' AND   (n_albaran_sl = :albaran) ');
      SQL.Add(' AND   (fecha_sl = :fecha) ');
      SQL.Add(' AND   (producto_sl =  ''W'') ');
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('albaran').AsInteger := AAlbaran;
      ParamByName('fecha').AsDateTime := AFecha;
      try
        Open;
        Result:= not IsEmpty;
      finally
        Close;
      end;
  end;
end;

function IntrastatProveedor( const AEmpresa, AProveedor: string ): string;
begin
  with DMAuxDB.QAux do
  begin
      SQL.Clear;
      SQL.Add(' select case when nvl(pro.pais_p,''ES'') = ''ES'' then ''N'' ');
      SQL.Add('             else case when pa.comunitario_p = 0 then ''I'' ');
      SQL.Add('                       else ''C'' end end intrastat');
      SQL.Add(' from frf_proveedores pro ');
      SQL.Add('      join frf_paises pa on pa.pais_p = pro.pais_p ');
      SQL.Add(' where proveedor_p = :proveedor ');
      ParamByName('proveedor').AsString := AProveedor;
      try
        Open;
        if IsEmpty then
          Result:= ''
        else
          Result:= FieldByname('intrastat').AsString ;
      finally
        Close;
      end;
  end;
end;


function Valortmensajes: string;
begin

  with DMAuxDB.QAux do
  try
    SQL.Clear;
    SQL.Add('select mensaje from tmensajes ');

    Open;
    if IsEmpty then
      result := ''
    else
      result := FieldByName('mensaje').AsString;

  finally
    Close;
  end;

end;

function CodigoX3Transporte( const empresa, transporte:string): string;
begin
  with DMAuxDB.QAux do
  try
    SQL.Clear;
    SQL.Add(' select codigo_x3_t from frf_transportistas ');
    SQL.Add('  where transporte_t = :transporte ');

    ParamByName('transporte').AsString := transporte;
    Open;

    if IsEmpty then
      Result := ''
    else
      Result := FieldbyName('codigo_x3_t').AsString;

  finally

  end;
end;

function ObtenerPrecioVenta(const fecha, cliente, envase: string): real;
begin
  with DMAuxDB.QAux do
  try
    SQL.Clear;
    SQL.Add(' select precio_pv from frf_precio_venta ');
    SQL.Add('  where fecha_pv = :fecha ');
    SQL.Add('    and cliente_pv = :cliente ');
    SQL.Add('    and envase_pv = :envase ');

    ParamByName('fecha').AsString := fecha;
    ParamByName('cliente').AsString := cliente;
    ParamByName('envase').AsString := envase;
    Open;

    if IsEmpty then
      Result := 0
    else
      Result := FieldbyName('precio_pv').AsFloat;

  finally
    Close;
  end;
end;

function GetCodeComercial( const AEmpresa, ACliente: string ): string;
begin
  DMAuxDB.QAux.SQL.Clear;
  DMAuxDB.QAux.SQL.Add(' select cod_comercial_cc ');
  DMAuxDB.QAux.SQL.Add(' from frf_clientes_comercial ');
  DMAuxDB.QAux.SQL.Add(' where cod_empresa_cc = :empresa ');
  DMAuxDB.QAux.SQL.Add(' and cod_cliente_cc = :cliente ');
  DMAuxDB.QAux.ParamByName('empresa').AsString:= AEmpresa;
  DMAuxDB.QAux.ParamByName('cliente').AsString:= ACliente;
  DMAuxDB.QAux.Open;
  try
    result:= DMAuxDB.QAux.FieldByName('cod_comercial_cc').AsString;
  finally
    DMAuxDB.QAux.Close;
  end;
end;

function DesUsuario( const usuario: string): string;
begin
  with DMAuxDB.QAux do
  try
    SQL.Clear;
    SQL.Add(' select descripcion_cu from cnf_usuarios ');
    SQL.Add('  where usuario_cu = :usuario ');

    ParamByName('usuario').AsString := usuario;
    Open;

    if IsEmpty then
      Result := ''
    else
      Result := FieldbyName('descripcion_cu').AsString;

  finally
    Close;
  end;
end;

procedure InsertarPBLog( const empresa, centro, sscc, usuario, documento: String; const peso, cajas: real; const tipoMovimiento:integer);
begin
  // Log
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' insert into rf_palet_pb_log (empresa, centro, sscc, peso, cajas, terminal_status, tipo_movimiento, fecha_movimiento, documento) ');
    SQL.Add(' values ');
    SQL.Add(' (:empresa, :centro, :sscc, :peso, :cajas, :terminal_status, :tipo_movimiento, :fecha_movimiento, :documento) ');
    ParamByName('empresa').AsString := empresa;
    ParamByName('centro').AsString := centro;
    ParamByName('sscc').AsString := sscc;
    ParamByName('peso').AsFloat := peso;
    ParamByName('cajas').AsFloat := cajas;
    ParamByName('terminal_status').AsString := usuario;
    ParamByName('tipo_movimiento').AsInteger := tipoMovimiento;
    ParamByName('fecha_movimiento').AsDateTime := now;
    ParamByName('documento').AsString := documento;

    ExecSQL;
  end;

end;

procedure InsertarPCLog( const empresa, centro, sscc, usuario, documento: String; const peso, cajas: real; const tipoMovimiento:integer);
begin
  // Log
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' insert into rf_palet_pc_log (empresa, centro, sscc, peso, cajas, terminal_status, tipo_movimiento, fecha_movimiento, documento)  ');
    SQL.Add(' values ');
    SQL.Add(' (:empresa, :centro, :sscc, :peso, :cajas, :terminal_status, :tipo_movimiento, :fecha_movimiento, :documento) ');
    ParamByName('empresa').AsString := empresa;
    ParamByName('centro').AsString := centro;
    ParamByName('sscc').AsString := sscc;
    ParamByName('peso').AsFloat := peso;
    ParamByName('cajas').AsFloat := cajas;
    ParamByName('terminal_status').AsString := usuario;
    ParamByName('tipo_movimiento').AsInteger := tipoMovimiento;
    ParamByName('fecha_movimiento').AsDateTime := now;
    ParamByName('documento').AsString := documento;

    ExecSQL;
  end;

end;

procedure BorrarPBLog (const documento, sscc: string; const movimiento: integer);
begin
   with DMAuxDB.QAux do
   begin
     SQL.Clear;
     SQL.Add(' delete from rf_palet_pb_log     ');
     SQL.Add('  where documento = :documento ');
     SQL.ADd('    and sscc = :sscc ');
     SQL.Add('    and tipo_movimiento = :movimiento ');

     ParamByName('documento').AsString := documento;
     ParamByName('sscc').AsString := sscc;
     ParamByName('movimiento').AsInteger := movimiento;
     ExecSQL;
   end;
end;

procedure BorrarPCLog (const documento, sscc: string; const movimiento: integer);
begin
   with DMAuxDB.QAux do
   begin
     SQL.Clear;
     SQL.Add(' delete from rf_palet_pc_log     ');
     SQL.Add('  where documento = :documento ');
     SQL.ADd('    and sscc = :sscc ');
     SQL.Add('    and tipo_movimiento = :movimiento ');

     ParamByName('documento').AsString := documento;
     ParamByName('sscc').AsString := sscc;
     ParamByName('movimiento').AsInteger := movimiento;
     ExecSQL;
   end;
end;


end.
