unit CContabilizacion;

interface

uses Windows, Forms, DB, dbtables, bMath, SysUtils, classes, kbmMemTable, BonnyQuery;

const
  kExtension= '.TXT';
  gsInterPlanta= 'IP';

var
  QEmpresas, QGrupoT, QGrupoD, QGrupoA, QDatosAlb, QFactOrigen, QImpGrupoD, QGastos,
  QLineas, QActFactura, QFormaPago, QImpTotalLineas, QAux, QAlbaran,
  QInsFactOrigen, QDetalleFact, QFact, QSeccion, QRecargo, QSeccionCompra,
  QAcuerdoComercial: TBonnyQuery;
  slFicheroConta, slFicheroVenta, slErrores, slFicGenerados, slErrGenerados: TStringList;
  sFichero, sErrores, sVenta: string;
  iNumLinea, iNumSecc: Integer;
  rImpNeto, rImpTotal, rImpNetoGrupo, rImpTotalGrupo, rImpNetoSeccion, rImpTotalSeccion: Real;
  mtGrupoT, mtGrupoD, mtGrupoA, mtGrupoE, mtGastos_Conta: TkbmMemTable;
  mtGrupoTEx, mtGrupoDEx, mtGrupoAEx, mtGrupoEEx: TkbmMemTable;
  bVerificar: Boolean;
  iFacturas, iErrores, iFacConta: integer;
  bInterPlanta: Boolean;


procedure ContabilizarFacturas(DBBaseDatos: TDataBase; bAuto: Boolean = false);
procedure GrabarFichero(ARuta: String);
procedure NombresFicheros(ADirectorio: String; AEmpresa: String);
function ObtenerRuta: String;
procedure CreaQGrupoD;
procedure CreaQGrupoA;
procedure CreaQImpGrupoD;
procedure CreaQGastos;
procedure CreaQDatosAlb;
procedure CreaQFactOrigen;
procedure CreaQLineas;
procedure CreaQActFactura;
procedure CreaQFormaPago;
procedure CreaQImpTotalLineas;
procedure CreaQAux;
procedure CreaQAlbaran;
procedure CreaQInsFactOrigen;
procedure CreaQDetalleFact;
procedure CreaQFact;
procedure CreaQSeccion;
procedure CreaQSeccionCompra;
procedure CreaQAcuerdoComercial;
function  GetSeccionContableCompra( const AVende, ASeccion, ACompra: string ): string;
procedure CreaQRecargo;
procedure CrearTablaTemporal;
function EjecutaQDatosAlb: boolean;
function EjecutaQFactOrigen: Boolean;
function EjecutaQGrupoD: boolean;
function EjecutaQGrupoA: boolean;
function EjecutaQImpGrupoD: Boolean;
function EjecutaQGastos:boolean;
procedure VerificarDatosCliente;
procedure CrearFichero;
procedure GrabarDatos;
procedure ActualizarFactura;
function GetFormaPago: string;
procedure CargarImportesGastos;
procedure AddLineaT;
procedure GrabarGrupoT;
procedure AddLineaD;
procedure GrabarGrupoD;
procedure AddLineaA;
procedure GrabarGrupoA;
procedure GrabarGrupoANueva;
procedure AddLineaE;
procedure GrabarGrupoE;
function SumaNetoGrupo: real;
function SumaTotalGrupo: real;
function SumaNetoSeccion: real;
procedure NuevaSeccionContable;
function ObtenerTotalLineas: real;
function GetTipoFactura: String;
function GetTipoFacturaAux( const ATipoVenta: string ): string;
function GetDirEmpresa: String;
function GetDirCliente: String;
function GetCambioMoneda: String;
function GetTipoImpuesto: String;
function GetAlbaran: String;
function GetFactOrigen: String;
function GetEmpresa(AEmpresa: String): String;
function GetPorcImpuesto: String;
function GetImpNetoGrupo: real;
function GetImpNetoSeccion: Real;
function GetKilos: Real;
function GetImpNuevaLinea: Real;
function GetImpTotalGrupo: Real;
function GetFechaFactOrigen: TDateTime;
function GetFactRegistroAcuerdo: String;
procedure BuscarFactOrigen;
function  BuscarFactura(AEmpresa, ASerie, AFecha, ANumero: string): string;
procedure CrearBuffers;
procedure LimpiarBuffers;
procedure BorrarListas;
procedure Crearconsultas;
procedure FactSinErrores(AValor: integer);
function ExisteSeccion(AEmpresa, ACentro, AEnvase: String): boolean;
function ClienteConRecargo(const AEmpresa, ACliente: string; const AFecha: TDateTime ): boolean;
procedure CerrarTablas;
procedure CloseQuery(AQuery: TDataSet);
procedure CloseQuerys(AQuerys: array of TDataSet);

function AbrirTransaccion(DB: TDataBase): boolean;
procedure AceptarTransaccion(DB: TDataBase);
procedure CancelarTransaccion(DB: TDataBase);


implementation

procedure ContabilizarFacturas(DBBaseDatos: TDatabase; bAuto: Boolean = false);
var sAux: String;
begin
  CrearTablaTemporal;                      //Crear Tabla temporal

  QGrupoT.First;
  while not QGrupoT.Eof do          // Recorrer Facturas a contabilizar
  begin
    Inc(iFacturas);
    EjecutaQDatosAlb;                           // Obtener Datos Primer Albaran
    EjecutaQFactOrigen;                         // Obtener Factura Origen en caso de Abono
    EjecutaQGrupoD;
    bInterPlanta:= ( QGrupoD.FieldByName('tipo_cliente_c').AsString = gsInterPlanta ) and
         ( ( QGrupoT.FieldByName('cod_empresa_fac_fc').AsString = '050' ) or ( QGrupoT.FieldByName('cod_empresa_fac_fc').AsString = '080' ) or
           ( QGrupoT.FieldByName('cod_empresa_fac_fc').AsString = 'F17' ) or ( QGrupoT.FieldByName('cod_empresa_fac_fc').AsString = 'F18') );
    EjecutaQGastos;

    try
      if bAuto then
        if ClienteConRecargo (QGrupoT.FieldByName('cod_empresa_fac_fc').AsString,
                              QGrupoT.FieldByName('cod_cliente_fc').AsString,
                              QGrupoT.FieldByName('fecha_factura_fc').AsDateTime) then
          raise Exception.Create('Factura con Recargo de equivalencia. Se generar� manualmente');

      bVerificar := false;
      VerificarDatosCliente;

      GrabarDatos;

      FactSinErrores(1);

    except
      on e: Exception do
      begin
        if DBBaseDatos.InTransaction then
          CancelarTransaccion(DBBaseDatos);
        sAux := QGrupoT.FieldByName('cod_empresa_fac_fc').AsString + ' ' +
                QGrupoT.FieldByName('n_factura_fc').AsString + ' ' +
                QGrupoT.FieldByName('fecha_factura_fc').AsString + ' ' +
                'Error al contabilizar la factura ' + QGrupoT.FieldBYName('cod_factura_fc').AsString + ' del ' +
                QGrupoT.FieldByName('fecha_factura_fc').AsString + '.';
        slErrores.Add( sAux + #13 + #10 + e.Message);
        if not bVerificar then FactSinErrores(0);
        Inc(iErrores);
      end;
    end;

    QGrupoT.Next;
  end;

  //Grabamos fichero
  //Seleccionamos Facturas Correctas
  mtGrupoT.Filter := 'FactSinErrores = 1';
  mtGrupoT.Filtered := true;
  mtGrupoT.First;
  iFacConta := 0;
  while not mtGrupoT.Eof do
  begin
    try
      if not AbrirTransaccion(DBBaseDatos) then
        raise Exception.Create('Error al abrir transaccion en BD.');

      CrearFichero;                              // A�adir Lineas (T, D, A, E) al fichero generado
      ActualizarFactura;                         // Marcar Factura como contabilizada

      AceptarTransaccion(DBBaseDatos);
      inc(iFacConta);
    except
      on e: Exception do
      begin
        if DBBaseDatos.InTransaction then
          CancelarTransaccion(DBBaseDatos);
        sAux := mtGrupoT.FieldByName('CodEmpresaFac').AsString + ' ' +
                mtGrupoT.FieldByName('NumFactura').AsString + ' ' +
                mtGrupoT.FieldByName('FechaFactura').AsString + ' ' +
                'Error al contabilizar la factura ' + mtGrupoT.FieldBYName('CodFactura').AsString + ' del ' +
                mtGrupoT.FieldByName('FechaFactura').AsString + '.';
        slErrores.Add( sAux + #13 + #10 + e.Message);
      end;
    end;

    mtGrupoT.Next;
  end;
  mtGrupoT.Filter := '';
  mtGrupoT.Filtered := False;

  mtGrupoT.Close;
  mtGrupoD.Close;
  mtGrupoA.Close;
  mtGrupoE.Close;

  mtGrupoTEx.Close;
  mtGrupoDEx.Close;
  mtGrupoAEx.Close;
  mtGrupoEEx.Close;
end;

procedure GrabarFichero(ARuta: string);
var
  sAux: string;
begin
  if slFicheroConta.Count > 0 then
  begin
    slFicheroConta.SaveToFile(ARuta + sFichero);
    slFicGenerados.Add(sFichero);
  end;
  if slFicheroVenta.Count > 0 then
  begin
    sAux:= StringReplace( UpperCase( ARuta ), 'XBIC', 'XBIS',[]);
    slFicheroVenta.SaveToFile(sAux + sVenta);
    slFicGenerados.Add(sVenta);
  end;
  if slErrores.Count > 0 then
  begin
    slErrores.SaveToFile(ARuta + sErrores);
    slErrGenerados.Add(sErrores);
  end;
end;

procedure NombresFicheros(ADirectorio: string; AEmpresa: String);
var
  i: integer;
  sAux: string;
begin
  sAux:= AEmpresa + '_' + FormatDateTime( 'yyyymmddhhnnsszzz', Now );
  sFichero := 'BIC_' + sAux;
  sVenta := 'BIS_' + sAux;
  sErrores := 'ERR_' + Copy(sFichero, 5, Length(sFichero));

  i:= 0;
  if FileExists( ADirectorio + sFichero + kExtension ) then
  begin
    i:= 1;
    while FileExists( ADirectorio + sFichero + '_' + IntToStr( i ) + kExtension ) do
    begin
      Inc( i );
    end;
  end;
  if i = 0 then
  begin
    sFichero:= sFichero + kExtension;
    sErrores:= sErrores + kExtension;
    sVenta:= sVenta + kExtension;
  end
  else
  begin
    sFichero:= sFichero + '_' + IntToStr( i ) + kExtension;
    sErrores:= sErrores + '_' + IntToStr( i ) + kExtension;
    sVenta:= sVenta + '_' + IntToStr( i ) + kExtension;
  end;

end;

function ObtenerRuta: String;
var QDirectorio: TBonnyQuery;
    sDir: String;
begin
  QDirectorio := TBonnyQuery.Create(nil);

  with QDirectorio do
  try
    SQL.Add(' select directorio_cd from cnf_directorios ');
    SQL.Add('  where usuario_cd = ''all'' ');
    SQL.Add('    and codigo_cd = ''conta_facturas'' ');

    Open;
    sDir:= fieldbyname('directorio_cd').AsString;
  finally
    free;
  end;

  if Copy( sDir, Length( sDir ), 1 ) <> '\' then
    sDir := sDir + '\';
//  sDir := 'C:\Users\Propietario\Documents\Contabilidad\Datos\';
  result := sDir;
end;

procedure CreaQGrupoD;
begin
  QGrupoD := TBonnyQuery.Create(Nil);
  with QGrupoD do
  begin
    SQL.Add(' select DISTINCT cod_empresa_albaran_fd, cod_cliente_albaran_fd, cta_ingresos_pgc_c, cta_ingresos_pga_c, ');
    SQL.Add('        porcentaje_impuesto_fd porcentaje_impuesto, tipo_cliente_c ');
    SQL.Add(' from tfacturas_det, frf_clientes ');
    SQL.Add(' where cod_factura_fd = :codfactura ');

    SQL.Add('   and cliente_c = cod_cliente_albaran_fd ');

    SQL.Add(' UNION ');

    SQL.Add(' select DISTINCT cod_empresa_albaran_fd, cod_cliente_albaran_fd, cta_ingresos_pgc_c, cta_ingresos_pga_c, ');
    SQL.Add('        porcentaje_impuesto_fg porcentaje_impuesto, tipo_cliente_c ');
    SQL.Add('   from tfacturas_gas, tfacturas_det, frf_clientes ');
    SQL.Add('  where cod_factura_fd = :codfactura ');
    SQL.Add('    and cod_factura_fg = cod_factura_fd ');
    SQL.Add('    and cliente_c = cod_cliente_albaran_fd ');

    SQL.Add(' order by cod_empresa_albaran_fd, cod_cliente_albaran_fd, cta_ingresos_pgc_c, cta_ingresos_pga_c, porcentaje_impuesto ');

    Prepare;
  end;
end;

procedure CreaQGrupoA;
begin
  QGrupoA := TBonnyQuery.Create(Nil);
  with QGrupoA do
  begin
    SQL.Add(' select sec_contable_rl sec_contable,  ');
    SQL.Add('        SUM(importe_neto_fd) importe_neto, SUM(kilos_fd) kilos ');
    SQL.Add('   from tfacturas_det, rsecciones_linea, frf_envases ');
    SQL.Add('  where cod_factura_fd = :codfactura ');
    SQL.Add('    and cod_empresa_albaran_fd = :empresa ');
    SQL.Add('    and porcentaje_impuesto_fd = :porcentaje ');

    SQL.Add('    and envase_e = cod_envase_fd ');
    SQL.Add('    and producto_e = cod_producto_fd ');

    SQL.Add('    and empresa_rl = cod_empresa_albaran_fd ');
    SQL.Add('    and centro_rl = centro_origen_fd ');                                // Centro Origen
//    SQL.Add('    and linea_producto_rl = linea_producto_e ');
    SQL.Add('    and producto_rl = producto_e ');
    SQL.Add('  group by sec_contable_rl ');
    SQL.Add('  order by sec_contable_rl ');

    Prepare;
  end;
end;

procedure CreaQImpGrupoD;
begin
  QImpGrupoD := TBonnyQuery.Create(Nil);
  with QImpGrupoD do
  begin
    SQL.Add(' select SUM(importe_neto_fd)  importe_neto_fd ');
    SQL.Add('   from tfacturas_det ');
    SQL.Add('  where cod_factura_fd = :codfactura ');
    SQL.Add('    and cod_empresa_albaran_fd = :empresa ');
    SQL.Add('    and porcentaje_impuesto_fd = :porcentaje ');

    Prepare;
  end;
end;

procedure CreaQGastos;
begin
  QGastos := TBonnyQuery.Create(Nil);
  with QGastos do
  begin
    SQL.Add(' select porcentaje_impuesto_fg, ');
    SQL.Add('        SUM(importe_neto_fg) importe_neto_gas ');
    SQL.Add('  from tfacturas_gas ');
    SQL.Add(' where cod_factura_fg = :codfactura ');
    SQL.Add(' group by porcentaje_impuesto_fg ');
    SQL.Add(' order by porcentaje_impuesto_fg ');

    Prepare;
  end;
end;

procedure CreaQDatosAlb;
begin
  QDatosAlb := TBonnyQuery.Create(Nil);
  with QDatosAlb do
  begin

    SQL.Add(' select first 1 fecha_albaran_fd, n_albaran_fd, cod_dir_sum_fd ');
    SQL.Add('   from tfacturas_det ');
    SQL.Add('  where cod_factura_fd = :codfactura ');
    SQL.Add('  order by fecha_albaran_fd desc, n_albaran_fd desc ');

    Prepare;
  end;
end;

procedure CreaQFactOrigen;
begin
  QFactOrigen := TBonnyQuery.Create(Nil);
  with QFactOrigen do
  begin
    SQL.Add(' select MIN(cod_factura_origen_fd) cod_factura_origen_fd ');
    SQL.Add('  from tfacturas_det ');
    SQL.Add(' where cod_factura_origen_fd <> '''' ');
    SQL.Add('   and cod_factura_fd = :codfactura ');

    Prepare;
  end;
end;

procedure CreaQLineas;
begin
  QLineas := TBonnyQuery.Create(nil);
  with QLineas do
  begin
    SQL.Add(' select cod_empresa_albaran_fd, ');
    SQL.Add('        cod_centro_albaran_fd, centro_origen_fd, ');
    SQL.Add('        cod_envase_fd, cod_producto_fd ');
    SQL.Add('   from tfacturas_det ');
    SQL.Add('  where cod_factura_fd = :codfactura ');

    Prepare;
  end;
end;

procedure CreaQActFactura;
begin
  QActFactura := TBonnyQuery.Create(nil);
  with QActFactura do
  begin
    SQL.Add(' update tfacturas_cab set contabilizado_fc = 1, ');
    SQl.Add('                          fecha_conta_fc = :fechaconta, ');
    SQL.Add('                          filename_conta_fc = :filename ');
    SQL.Add('  where cod_factura_fc = :codfactura ');
  end;
end;

procedure CreaQFormaPago;
begin
  QFormaPago := TBonnyQuery.Create(Nil);
  with QFormaPago do
  begin
    SQL.Add(' select codigo_fp, forma_pago_adonix_fp, ');
    SQL.Add('        forma_pago_ct ');
    SQL.Add('   from tfacturas_cab, frf_clientes, frf_clientes_tes, frf_forma_pago ');
    SQL.Add('  where cod_factura_fc = :codfactura ');
    SQL.Add('    and cliente_c = cod_cliente_fc ');
    SQL.Add('    and codigo_fp = forma_pago_ct ');
    SQL.Add('    and empresa_ct = cod_empresa_fac_fc ');
    SQL.Add('    and cliente_ct = cliente_c ');

    Prepare;
  end;
end;

procedure CreaQImpTotalLineas;
begin
  QImpTotalLineas := TBonnyQuery.Create(Nil);
  with QImpTotalLineas do
  begin
    SQL.Add(' select SUM(importe_neto_fd) importe_neto_total ');
    SQL.Add(' from tfacturas_det ');
    SQL.Add('  where cod_factura_fd = :codfactura ');

    Prepare;
  end;
end;

procedure CreaQAux;
begin
  QAux := TBonnyQuery.Create(Nil);
  with QAux do
  begin
    SQL.Add(' select fecha_factura_fc from tfacturas_cab ');
    SQL.Add('  where cod_factura_fc = :codfactura ');

    Prepare;
  end;
end;

procedure CreaQAlbaran;
begin
  QAlbaran := TBonnyQuery.Create(Nil);
  with QAlbaran do
  begin
    SQL.Add(' select empresa_fac_sc, fecha_factura_sc, n_factura_sc, serie_fac_sc ');
    SQL.Add('   from frf_salidas_c ');
    SQL.Add('  where empresa_sc = :empresa ');
    SQL.Add('    and centro_salida_sc = :centro ');
    SQL.Add('    and n_albaran_sc = :albaran ');
    SQL.Add('    and fecha_sc = :fecha ');

    Prepare;
  end;
end;

procedure CreaQInsFactOrigen;
begin
  QInsFactOrigen := TBonnyQuery.Create(nil);
  with QInsFactOrigen do
  begin
    SQL.Add(' update tfacturas_det set cod_factura_origen_fd = :codfactorigen ');
    SQL.Add('  where cod_factura_fd = :codfactura ');

    Prepare;
  end;
end;

procedure CreaQDetalleFact;
begin
  QDetalleFact := TBonnyQuery.Create(Nil);
  with QDetalleFact do
  begin
    RequestLive := true;
    SQL.Add(' select * ');
    SQL.Add('   from tfacturas_det ');
    SQL.Add('  where cod_factura_fd = :codfactura ');

    Prepare;
  end;
end;

procedure CreaQFact;
begin
  QFact := TBonnyQuery.Create(Nil);
  with QFact do
  begin
    SQL.Add(' select cod_factura_fc from tfacturas_cab ');
    SQL.Add('  where cod_empresa_fac_fc = :empresa ');
    SQL.Add('    and cod_serie_fac_fc = :serie ');
    SQL.Add('    and n_factura_fc = :numero ');
    SQL.Add('    and fecha_factura_fc = :fecha ');

    Prepare;
  end;
end;

procedure CreaQSeccionCompra;
begin
  QSeccionCompra := TBonnyQuery.Create(nil);
//  QSeccionCompra.DatabaseName:= 'dbMaster';
  with QSeccionCompra do
  begin
    SQL.Add(' select secc_compra_sc seccion from frf_secc_compra_venta ');
    SQL.Add(' where empresa_compra_Sc = :empresacompra ');
    SQL.Add(' and empresa_vende_sc = :empresavende ');
    SQL.Add(' and secc_vende_Sc = :seccionvende ');
    Prepare;
  end;
end;

procedure CreaQSeccion;
begin
  QSeccion := TBonnyQuery.Create(nil);
  with QSeccion do
  begin
    SQL.Add(' select * from rsecciones_linea, frf_envases ');
    SQL.Add('  where empresa_rl = :empresa ');
    SQL.Add('    and centro_rl = :centro ');
    SQL.Add('    and envase_e = :envase ');

//    SQL.Add('    and linea_producto_e = linea_producto_rl ');
    SQL.Add('    and producto_e = producto_rl ');

    Prepare;
    end;
end;

procedure CreaQAcuerdoComercial;
begin
  QAcuerdoComercial := TBonnyQuery.Create(nil);
  with QAcuerdoComercial do
  begin
    SQL.Add(' select * from frf_acuerdo_comercial ');
    SQL.Add('  where cliente_ac = :CLI ');

    Prepare;
  end;
end;

procedure CreaQRecargo;
begin
  QRecargo := TBonnyQuery.Create(nil);
  with QRecargo do
  begin
    SQL.add(' select * ');
    SQL.add(' from frf_impuestos_recargo_cli ');
    SQL.add(' where empresa_irc = :empresa ');
    SQL.add(' and cliente_irc = :cliente ');
    SQL.Add(' and recargo_irc <> 0 ');
    SQL.add(' and :fecha  between fecha_ini_irc and case when fecha_fin_irc is null then :fecha else fecha_fin_irc end ');

    Prepare;
  end;
end;

procedure CrearTablaTemporal;
begin
  mtGrupoT := TkbmMemTable.Create(Nil);
  with mtGrupoT do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('TipoFactura', ftString, 3, False);
    FieldDefs.Add('CodFactura', ftString, 15, False);
    FieldDefs.Add('CodEmpresaFac', ftString, 3, False);
    FieldDefs.Add('DirEmpresaFac', ftString, 3, False);
    FieldDefs.Add('FechaFactura', ftString, 8, False);
    FieldDefs.Add('NumFactura', ftInteger, 0, False);
    FieldDefs.Add('CodCliente', ftString, 3, False);
    FieldDefs.Add('CtaCliente', ftString, 10, False);
    FieldDefs.Add('DirCliente', ftString, 3, False);
    FieldDefs.Add('FPAdonix', ftString, 2, False);
    FieldDefs.Add('PrevCobro', ftString, 8, False);
    FieldDefs.Add('CodMoneda', ftString, 3, False);
    FieldDefs.Add('CambioMoneda', ftString, 6, False);
    FieldDefs.Add('TipoImpuesto', ftString, 3, False);
    FieldDefs.Add('FechaAlbaran', ftString, 10, False);
    FieldDefs.Add('NumAlbaran', ftString, 15, False);
    FieldDefs.Add('FactOrigen', ftString, 15, False);
    FieldDefs.Add('FactSinErrores', ftInteger, 0, False);
    FieldDefs.Add('NumRegistroAcuerdo', ftString, 15, False);

    CreateTable;
  end;
  mtGrupoT.Open;

  mtGrupoD := TkbmMemTable.Create(Nil);
  with mtGrupoD do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('CodFactura', ftString, 15, False);
    FieldDefs.Add('CodEmpresa', ftString, 3, False);
    FieldDefs.Add('CodCliente', ftString, 3, False);
    FieldDefs.Add('CtaC', ftString, 8, False);
    FieldDefs.Add('CtaA', ftString, 8, False);
    FieldDefs.Add('ImporteNeto', ftFloat, 0, False);
    FieldDefs.Add('PorcImpuesto', ftString, 3, False);
    FieldDefs.Add('FactCliente', ftString, 13, False);

    CreateTable;
  end;
  mtGrupoD.Open;

  mtGrupoA := TkbmMemTable.Create(Nil);
  with mtGrupoA do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('CodFactura', ftString, 15, False);
    FieldDefs.Add('CodEmpresa', ftString, 3, False);
    FieldDefs.Add('CtaC', ftString, 8, False);
    FieldDefs.Add('CtaA', ftString, 8, False);
    FieldDefs.Add('PorcImpuesto', ftString, 3, False);
    FieldDefs.Add('SecContable', ftString, 10, False);
    FieldDefs.Add('ImporteNeto', ftFloat, 0, False);
    FieldDefs.Add('Kilos', ftFloat, 0, False);

    CreateTable;
  end;
  mtGrupoA.Open;

  mtGrupoE := TkbmMemTable.Create(Nil);
  with mtGrupoE do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('CodFactura', ftString, 15, False);
    FieldDefs.Add('CodEmpresa', ftString, 3, False);
    FieldDefs.Add('CtaC', ftString, 8, False);
    FieldDefs.Add('CtaA', ftString, 8, False);
    FieldDefs.Add('PrevCobro', ftString, 8, False);
    FieldDefs.Add('PorcImpuesto', ftString, 3, False);
    FieldDefs.Add('FormaPago', ftString, 2, False);
    FieldDefs.Add('ImporteTotal', ftFloat, 0, False);
    FieldDefs.Add('DirCliente', ftString, 3, False);

    CreateTable;
  end;
  mtGrupoE.Open;

  //Tabla Temporal Gastos
  mtGastos_Conta := TkbmMemTable.Create(Nil);
  with mtGastos_Conta do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('porcentaje_gasto', ftFloat, 0, False);
    FieldDefs.Add('empresa_albaran', ftString, 3, False);
    FieldDefs.Add('cta_c', ftString, 8, False);
    FieldDefs.Add('cta_a', ftString, 8, False);
    FieldDefs.Add('seccion_contable', ftString, 10, False);
    FieldDefs.Add('importe_gasto', ftFloat, 0, False);

    CreateTable;
  end;


  mtGrupoTEx := TkbmMemTable.Create(Nil);
  with mtGrupoTEx do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('TipoFactura', ftString, 3, False);
    FieldDefs.Add('CodFactura', ftString, 15, False);
    FieldDefs.Add('CodEmpresaFac', ftString, 3, False);
    FieldDefs.Add('DirEmpresaFac', ftString, 3, False);
    FieldDefs.Add('FechaFactura', ftString, 8, False);
    FieldDefs.Add('NumFactura', ftInteger, 0, False);
    FieldDefs.Add('CodCliente', ftString, 3, False);
    FieldDefs.Add('CtaCliente', ftString, 10, False);
    FieldDefs.Add('DirCliente', ftString, 3, False);
    FieldDefs.Add('FPAdonix', ftString, 2, False);
    FieldDefs.Add('PrevCobro', ftString, 8, False);
    FieldDefs.Add('CodMoneda', ftString, 3, False);
    FieldDefs.Add('CambioMoneda', ftString, 6, False);
    FieldDefs.Add('TipoImpuesto', ftString, 3, False);
    FieldDefs.Add('FechaAlbaran', ftString, 10, False);
    FieldDefs.Add('NumAlbaran', ftString, 15, False);
    FieldDefs.Add('FactOrigen', ftString, 15, False);
    FieldDefs.Add('FactSinErrores', ftInteger, 0, False);

    CreateTable;
  end;
  mtGrupoTEx.Open;

  mtGrupoDEx := TkbmMemTable.Create(Nil);
  with mtGrupoDEx do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('CodFactura', ftString, 15, False);
    FieldDefs.Add('CodEmpresa', ftString, 3, False);
    FieldDefs.Add('CodCliente', ftString, 3, False);
    FieldDefs.Add('CtaC', ftString, 8, False);
    FieldDefs.Add('CtaA', ftString, 8, False);
    FieldDefs.Add('ImporteNeto', ftFloat, 0, False);
    FieldDefs.Add('PorcImpuesto', ftString, 3, False);
    FieldDefs.Add('FactCliente', ftString, 13, False);

    CreateTable;
  end;
  mtGrupoDEx.Open;

  mtGrupoAEx := TkbmMemTable.Create(Nil);
  with mtGrupoAEx do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('CodFactura', ftString, 15, False);
    FieldDefs.Add('CodEmpresa', ftString, 3, False);
    FieldDefs.Add('CtaC', ftString, 8, False);
    FieldDefs.Add('CtaA', ftString, 8, False);
    FieldDefs.Add('PorcImpuesto', ftString, 3, False);
    FieldDefs.Add('SecContable', ftString, 10, False);
    FieldDefs.Add('ImporteNeto', ftFloat, 0, False);
    FieldDefs.Add('Kilos', ftFloat, 0, False);

    CreateTable;
  end;
  mtGrupoAEx.Open;

  mtGrupoEEx := TkbmMemTable.Create(Nil);
  with mtGrupoEEx do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('CodFactura', ftString, 15, False);
    FieldDefs.Add('CodEmpresa', ftString, 3, False);
    FieldDefs.Add('CtaC', ftString, 8, False);
    FieldDefs.Add('CtaA', ftString, 8, False);
    FieldDefs.Add('PrevCobro', ftString, 8, False);
    FieldDefs.Add('PorcImpuesto', ftString, 3, False);
    FieldDefs.Add('FormaPago', ftString, 2, False);
    FieldDefs.Add('ImporteTotal', ftFloat, 0, False);
    FieldDefs.Add('DirCliente', ftString, 3, False);

    CreateTable;
  end;
  mtGrupoEEx.Open;
end;

function EjecutaQDatosAlb: boolean;
begin
  with QDatosAlb do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;

    Open;
    Result := not IsEmpty;
  end;
end;

function EjecutaQFactOrigen: boolean;
begin
  with QFactOrigen do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;

    Open;
    Result := not IsEmpty;
  end;
end;

function EjecutaQGrupoD: boolean;
begin
  with QGrupoD do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;

    Open;
    Result := not IsEmpty;
  end;
end;

function EjecutaQGrupoA: boolean;
begin
  if (QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString = '050') or
     (QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString = '080') then
  begin
    with QGrupoA do
    begin
      if Active then
        Close;

      SQL.Clear;
      SQL.Add(' select sec_contable_rl sec_contable, ');
      SQL.Add('        SUM(importe_neto_fd) importe_neto, SUM(kilos_fd) kilos ');
      SQL.Add('   from tfacturas_det, rsecciones_linea, frf_envases ');
      SQL.Add('  where cod_factura_fd = :codfactura ');
      SQL.Add('    and cod_empresa_albaran_fd = :empresa ');
      SQL.Add('    and porcentaje_impuesto_fd = :porcentaje ');

      SQL.Add('    and envase_e = cod_envase_fd ');
      SQL.Add('    and producto_e = cod_producto_fd ');

      SQL.Add('    and empresa_rl = cod_empresa_albaran_fd ');
      SQL.Add('    and centro_rl = centro_origen_fd ');                                // Centro Origen
//      SQL.Add('    and linea_producto_rl = linea_producto_e ');
      SQL.Add('    and producto_rl = producto_e ');
      SQL.Add('  group by sec_contable_rl ');
      SQL.Add('  order by sec_contable_rl ');

      ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;
      ParamByName('empresa').AsString := QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString;
      ParamByName('porcentaje').AsFloat := QGrupoD.FieldByName('porcentaje_impuesto').AsFloat;

      Open;
      Result := not IsEmpty;
    end;
  end
  else
  begin
    with QGrupoA do
    begin
      if Active then
        Close;

      SQL.Clear;
      SQL.Add(' select sec_contable_rl sec_contable, ');
      SQL.Add('        SUM(importe_neto_fd) importe_neto, SUM(kilos_fd) kilos ');
      SQL.Add('   from tfacturas_det, rsecciones_linea, frf_envases ');
      SQL.Add('  where cod_factura_fd = :codfactura ');
      SQL.Add('    and cod_empresa_albaran_fd = :empresa ');
      SQL.Add('    and porcentaje_impuesto_fd = :porcentaje ');

      SQL.Add('    and envase_e = cod_envase_fd ');
      SQL.Add('    and producto_e = cod_producto_fd ');

      SQL.Add('    and empresa_rl = cod_empresa_albaran_fd ');
      SQL.Add('    and centro_rl = cod_centro_albaran_fd ');                           // Centro Salida
//      SQL.Add('    and linea_producto_rl = linea_producto_e ');
      SQL.Add('    and producto_rl = producto_e ');
      SQL.Add('  group by sec_contable_rl ');
      SQL.Add('  order by sec_contable_rl ');

      ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;
      ParamByName('empresa').AsString := QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString;
      ParamByName('porcentaje').AsFloat := QGrupoD.FieldByName('porcentaje_impuesto').AsFloat;

      Open;
      Result := not IsEmpty;
    end;
  end;

end;

function EjecutaQImpGrupoD: boolean;
begin
  with QImpGrupoD do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;
    ParamByName('empresa').AsString := QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString;
    ParamByName('porcentaje').AsFloat := QGrupoD.FieldByName('porcentaje_impuesto').AsFloat;

    Open;
    Result := not IsEmpty;
  end;
end;

function EjecutaQGastos: boolean;
begin
  with QGastos do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;

    Open;
    Result := not IsEmpty;
  end;
end;

function AbrirTransaccion(DB: TDataBase): Boolean;
var
  T, Tiempo: Cardinal;
  cont: integer;
  flag: boolean;
begin
  cont := 0;
  flag := true;
  while flag do
  begin
        //Abrimos transaccion si podemos
    if DB.InTransaction then
    begin
           //Ya hay una transaccion abierta
      inc(cont);
      if cont = 3 then
      begin
        AbrirTransaccion := false;
        Exit;
      end;
           //Esperar entre 1 y (1+cont) segundos
      T := GetTickCount;
      Tiempo := cont * 1000 + Random(1000);
      while GetTickCount - T < Tiempo do Application.ProcessMessages;
    end
    else
    begin
      DB.StartTransaction;
      flag := false;
    end;
  end;
  AbrirTransaccion := true;
end;

procedure AceptarTransaccion(DB: TDataBase);
begin
  if DB.InTransaction then
  begin
    DB.Commit;
  end;
end;

procedure CancelarTransaccion(DB: TDataBase);
begin
  if DB.InTransaction then
  begin
    DB.Rollback;
  end;
end;


procedure VerificarDatosCliente;
var Centro: String;
begin
  if QGrupoT.FieldByName('cta_cliente_fc').AsString = '' then
  begin
    bVerificar := true;
    raise Exception.Create('Falta grabar la cuenta del cliente ' + QGrupoT.FieldByName('cod_empresa_fac_fc').AsString +
                           '-' + QGrupoT.FieldByName('cod_cliente_fc').AsString + '.' );
  end;

  QGrupoD.First;
  while not QGrupoD.Eof do
  begin
    if QGrupoD.FieldByName('cta_ingresos_pgc_c').AsString = '' then
    begin
      bVerificar := true;
      raise Exception.Create('Falta grabar la cuenta del PGC ' + QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString +
                             '-' + QGrupoD.FieldByName('cod_cliente_albaran_fd').AsString + '.' );
    end
    else
    if QGrupoD.FieldByName('cta_ingresos_pga_c').AsString = '' then
    begin
      bVerificar := true;
      raise Exception.Create('Falta grabar la cuenta del PGA ' + QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString +
                             '-' + QGrupoD.FieldByName('cod_cliente_albaran_fd').AsString + '.' );
    end;

    QGrupoD.Next;
  end;

  with QLineas do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;
    Open;

    while not Eof do
    begin
     if (FieldByName('cod_empresa_albaran_fd').AsString = '050') or
        (FieldByName('cod_empresa_albaran_fd').AsString = '080') then
          Centro := FieldByName('centro_origen_fd').AsString
     else
          Centro := FieldByName('cod_centro_albaran_fd').AsString;

     if not ExisteSeccion(FieldByName('cod_empresa_albaran_fd').AsString,
                          Centro,
                          FieldByName('cod_envase_fd').AsString) then
     begin
        bVerificar := true;
        raise Exception.Create('Falta grabar la seccion contable ' +
                                FieldByName('cod_empresa_albaran_fd').AsString + ' / ' +
                                Centro + ' / ' +
                                FieldByName('cod_envase_fd').AsString + ' / ' +
                                FieldByName('cod_producto_fd').AsString);
     end;
      Next;
    end;

  end;

end;

procedure CrearFichero;
begin
  mtGrupoTEx.Filter := ' CodFactura = ' + QuotedStr(mtGrupoT.FieldByName('CodFactura').AsString);
  mtGrupoTEx.Filtered := true;
  bInterPlanta:= not mtGrupoTEx.IsEmpty;

  AddLineaT;                                  // A�adir Linea tipo T

  iNumLinea := 1;
  mtGrupoD.Filter := ' CodFactura = ' + QuotedStr(mtGrupoT.FieldByName('CodFactura').AsString);
  mtGrupoD.Filtered := true;
  if bInterPlanta then
    mtGrupoDEx.Filter := ' CodFactura = ' + QuotedStr(mtGrupoTEx.FieldByName('CodFactura').AsString);
  mtGrupoDEx.Filtered := true;

  mtGrupoD.First;
  mtGrupoDEx.First;
  while not mtGrupoD.Eof do
  begin
//    EjecutaQImpGrupoD;                        //Obtenemos importe de linea por Factura/Empresa Alb/Porcentaje
//    EjecutaQGrupoA;

//    rImpNetoGrupo := SumaNetoGrupo;
//    rImpTotalGrupo := SumaTotalGrupo;

    AddLineaD;                                // A�adir Linea tipo D
    iNumSecc := 1;
    rImpTotalSeccion := 0;
    mtGrupoA.Filter := 'CodFactura = ' + QuotedStr(mtGrupoD.FieldByName('CodFactura').AsString) + ' AND ' +
                       'CodEmpresa = ' + QuotedStr(mtGrupoD.FieldByName('CodEmpresa').AsString) + ' AND ' +
                       'CtaC = ' + QuotedStr(mtGrupoD.FieldByName('CtaC').AsString) + ' AND ' +
                       'CtaA = ' + QuotedStr(mtGrupoD.FieldByName('CtaA').AsString) + ' AND ' +
                       'PorcImpuesto = ' + mtGrupoD.FieldByName('PorcImpuesto').AsString;

    if bInterPlanta then
      mtGrupoAEx.Filter := 'CodFactura = ' + QuotedStr(mtGrupoDEx.FieldByName('CodFactura').AsString) + ' AND ' +
                       'CodEmpresa = ' + QuotedStr(mtGrupoDEx.FieldByName('CodEmpresa').AsString) + ' AND ' +
                       'CtaC = ' + QuotedStr(mtGrupoDEx.FieldByName('CtaC').AsString) + ' AND ' +
                       'CtaA = ' + QuotedStr(mtGrupoDEx.FieldByName('CtaA').AsString) + ' AND ' +
                       'PorcImpuesto = ' + mtGrupoDEx.FieldByName('PorcImpuesto').AsString;

    mtGrupoA.Filtered := true;
    mtGrupoA.First;
    mtGrupoAEx.Filtered := true;
    mtGrupoAEx.First;

    while not mtGrupoA.Eof do
    begin
      AddLineaA;                              // A�adir Linea tipo A

      mtGrupoA.Next;
      mtGrupoAEx.Next;
      Inc(iNumSecc);
    end;

    mtGrupoA.Filter := '';
    mtGrupoA.Filtered := false;
    mtGrupoAEx.Filter := '';
    mtGrupoAEx.Filtered := false;

    mtGrupoE.Filter := 'CodFactura = ' + QuotedStr(mtGrupoD.FieldByName('CodFactura').AsString) + ' AND ' +
                       'CodEmpresa = ' + QuotedStr(mtGrupoD.FieldByName('CodEmpresa').AsString) + ' AND ' +
                       'CtaC = ' + QuotedStr(mtGrupoD.FieldByName('CtaC').AsString) + ' AND ' +
                       'CtaA = ' + QuotedStr(mtGrupoD.FieldByName('CtaA').AsString) + ' AND ' +
                       'PorcImpuesto = ' + mtGrupoD.FieldByName('PorcImpuesto').AsString;
    if bInterPlanta then
      mtGrupoEEx.Filter := 'CodFactura = ' + QuotedStr(mtGrupoDEx.FieldByName('CodFactura').AsString) + ' AND ' +
                       'CodEmpresa = ' + QuotedStr(mtGrupoDEx.FieldByName('CodEmpresa').AsString) + ' AND ' +
                       'CtaC = ' + QuotedStr(mtGrupoDEx.FieldByName('CtaC').AsString) + ' AND ' +
                       'CtaA = ' + QuotedStr(mtGrupoDEx.FieldByName('CtaA').AsString) + ' AND ' +
                       'PorcImpuesto = ' + mtGrupoDEx.FieldByName('PorcImpuesto').AsString;

    mtGrupoE.Filtered := true;
    mtGrupoEEx.Filtered := true;

    AddLineaE;                               // A�adir Linea tipo E

    mtGrupoE.Filter := '';
    mtGrupoE.Filtered := false;
    mtGrupoEEx.Filter := '';
    mtGrupoEEx.Filtered := false;

    mtGrupoD.Next;
    mtGrupoDEx.Next;
    Inc(iNumLinea);
  end;

  mtGrupoD.Filter := '';
  mtGrupoD.Filtered := false;
  mtGrupoDEx.Filter := '';
  mtGrupoDEx.Filtered := false;

  mtGrupoTEx.Filter := '';
  mtGrupoTEx.Filtered := false;
end;

procedure GrabarDatos;
var sAux, sAux2: string;
begin
  //Grabamos datos por Factura
  CargarImportesGastos;                        //Tabla temporal con los importes gastos proporcionales (tfacturas_gas)

  GrabarGrupoT;                                // Grabar Datos Grupo T en mtGrupoT

  rImpNeto := 0;
  rImpTotal := 0;

  QGrupoD.First;
  while not QGrupoD.Eof do
  begin
    EjecutaQImpGrupoD;                        //Obtenemos importe de linea por Factura/Empresa Alb/Porcentaje
    EjecutaQGrupoA;

    rImpNetoGrupo := SumaNetoGrupo;
    rImpTotalGrupo := SumaTotalGrupo;

    GrabarGrupoD;
    rImpTotalSeccion := 0;
    if QGrupoA.RecordCount > 0 then
    begin
      QGrupoA.First;
      while not QGrupoA.Eof do
      begin
        rImpNetoSeccion := SumaNetoSeccion;
        rImpTotalSeccion := rImpTotalSeccion + rImpNetoSeccion;

        GrabarGrupoA;

        QGrupoA.Next;
      end;
    end
    else                                    //Se crea nueva linea con Seccion Contable
      NuevaSeccionContable;

    GrabarGrupoE;

    if bRoundTo(rImpTotalSeccion,2) <> bRoundTo(rImpNetoGrupo, 2) then
    begin
      raise Exception.Create('Error: no coincide el importe total (D) ' + FloatToStr(rImpNetoGrupo) +
                             ' con el sumatorio de las lineas (A) ' + FloatToStr(rImpTotalSeccion) );
    end;

    rImpNeto := rImpNeto + rImpNetoGrupo;
    rImpTotal := rImpTotal + rImpTotalGrupo;

    QGrupoD.Next;
  end;

  mtGastos_Conta.Close;

  if bRoundTo(QGrupoT.FieldByName('importe_neto_fc').AsFloat, 2) <> bRoundTo(rImpNeto, 2) then
    raise Exception.Create('Error: no coincide el Importe Neto de la Factura ' + QGrupoT.FieldByName('importe_neto_fc').AsString +
                           ' con el sumatorio de las lineas (D) ' + FloattoStr(bRoundTo(rImpNeto,2)));

  if bRoundTo(QGrupoT.FieldByName('importe_total_fc').AsFloat,2) <> bRoundTo(rImpTotal,2) then
  begin
    sAux := QGrupoT.FieldByName('cod_empresa_fac_fc').AsString + ' ' +
            QGrupoT.FieldByName('n_factura_fc').AsString + ' ' +
            QGrupoT.FieldByName('fecha_factura_fc').AsString + ' ' +
            'Error al contabilizar la factura ' + QGrupoT.FieldBYName('cod_factura_fc').AsString + ' del ' +
            QGrupoT.FieldByName('fecha_factura_fc').AsString + '.';

    sAux2 := 'No coincide el Importe Total de la Factura ' + QGrupoT.FieldByName('importe_total_fc').AsString +
                           ' con el sumatorio de las lineas (E) ' + FloattoStr(bRoundTo(rImpTotal, 2));
    slErrores.Add(sAux + #13 + #10 + sAux2);
  end;
end;

procedure ActualizarFactura;
begin
  with QActFactura do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := mtGrupoT.FieldByName('CodFactura').AsString;
    ParamByName('fechaconta').AsDateTime := Now;
    ParamByName('filename').AsString := sFichero;

    ExecSQL;
  end;

end;

function GetFormaPago: string;
begin
  Result := '';
  with QFormaPago do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;

    Open;
    if IsEmpty then
    begin
      bVerificar := true;
      raise Exception.Create('No se ha asignado Forma de Pago para el cliente ' + QGrupoT.FieldByName('cod_cliente_fc').AsString + '.')
    end
    else if FieldByName('forma_pago_adonix_fp').AsString = '' then
    begin
      bVerificar := true;
      raise Exception.Create('Falta grabar la forma de pago ADONIX para FP ' + FieldByName('forma_pago_ct').AsString + '.')
    end
    else
     Result := FieldByName('forma_pago_adonix_fp').AsString;

  end;
end;

procedure CargarImportesGastos;
var ImpTotalLineas, ImpAux: Real;
begin
  ImpTotalLineas := ObtenerTotalLineas;

  mtGastos_Conta.Open;

  QGastos.First;
  while not QGastos.Eof  do
  begin
    QGrupoD.First;
    while not QGrupoD.Eof do
    begin
      EjecutaQGrupoA;
      QGrupoA.First;
      while not QGrupoA.Eof do
      begin

        mtGastos_Conta.Append;

        mtGastos_Conta.FieldByName('porcentaje_gasto').AsFloat := QGastos.FieldByName('porcentaje_impuesto_fg').AsFloat;
        mtGastos_Conta.FieldByName('empresa_albaran').AsString := QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString;
        mtGastos_Conta.FieldByName('cta_c').AsString := QGrupoD.FieldByName('cta_ingresos_pgc_c').AsString;
        mtGastos_Conta.FieldByName('cta_a').AsString := QGrupoD.FieldByName('cta_ingresos_pga_c').AsString;
        mtGastos_Conta.FieldByName('seccion_contable').AsString := QGrupoA.FieldByName('sec_contable').AsString;

//        ImpAux := QGrupoA.FieldByName('importe_neto').AsFloat;
        mtGastos_Conta.FieldByName('importe_gasto').AsFloat := (QGrupoA.FieldByName('importe_neto').AsFloat *
                                                                        QGastos.FieldByName('importe_neto_gas').AsFloat) / ImpTotalLineas;

        mtGastos_Conta.Post;

        QGrupoA.Next;
      end;
      QGrupoD.Next;
    end;
    QGastos.Next;
  end;
end;

function GetPlantaCliente( const ACtaCliente, AEmpresa: string ): string;
begin
// Se busca por empresa desde unificacion, ya solo existe un cliente BAG
//  if (ACtaCliente = 'BONNY-AGRO') and (AEmpresa = '080') then
//    Result:= 'F17'
//  else
  if (ACtaCliente = 'BONNY-AGRO') and (AEmpresa = '050') then
    Result:= 'F17'
  else
  if ACtaCliente = 'BON-AG-F23' then
    Result:= 'F23'
  else
  if ACtaCliente = 'SATBONNYSA' then
    Result:= '050'
  else
    Result:= 'ERR';
end;

function GetDireccionPlanta( const APlanta, ATipoIva: string ): string;
begin
  if ATipoIva = 'CAN' then
  begin
    if APlanta = 'F23' then
    begin
      Result:= '001';
    end
    else
    begin
      Result:= '002';
    end;
  end
  else
  begin
    Result:= '001';
  end;
end;

function GetAsientoOrigen: string;
begin
  Result:= '';
end;

function GetCodVendedor( const APlanta: string ): string;
begin
  if ( APlanta = '050' ) or ( APlanta = '080' ) then
    Result:= 'SAT'
  else if (( APlanta = 'F17') or ( APlanta = 'F18' )) then
    Result:= 'BAG'
  else
    Result:= 'ERR';
end;

function GetCtaVendedor( const APlanta: string ): string;
begin
  if ( APlanta = '050' ) or ( APlanta = '080' ) then
    Result:= 'SATBONNYSA'
  else if ( (APlanta = 'F17') or (APlanta = 'F18') ) then
       Result:= 'BONNY-AGRO'
  else
    Result:= 'ERROR';
end;

function GetDireccionVendedor( const APlanta, ATipoIva: string ): string;
begin
  if ( APlanta = '050' ) or ( APlanta = '080' ) then
  begin
    if ATipoIva = 'CAN' then
      Result:= '002'
    else
      Result:= '001'
  end
  else if (( APlanta = 'F17' ) or (APlanta = 'F18') ) then
    Result:= '001'
  else
    Result:= 'ERR';
end;

function GetCuentaContableCompra: string;
begin
  result:= '60000001';
end;

function GetCuentaAnaliticaCompra: string;
begin
  result:= '60000001';
end;

function GetSeccionContableCompra( const AVende, ASeccion, ACompra: string ): string;
begin
  with QSeccionCompra do
  begin
    ParamByName('empresacompra').AsString := ACompra;
    ParamByName('empresavende').AsString := AVende;
    ParamByName('seccionvende').AsString := ASeccion;
    Open;
    if IsEmpty then
      result := 'ERROR'
    else
      result := FieldBYName('seccion').AsString;
    Close;
  end;
end;

procedure GrabarGrupoT;
begin
  mtGrupoT.Append;
  mtGrupoT.FieldByName('TipoFactura').AsString := GetTipoFactura;
  mtGrupoT.FieldByName('CodFactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;
  mtGrupoT.FieldByName('CodEmpresaFac').AsString := GetEmpresa(QGrupoT.FieldByName('cod_empresa_fac_fc').AsString);
  mtGrupoT.FieldByName('DirEmpresaFac').AsString := GetDirEmpresa;
  mtGrupoT.FieldByName('FechaFactura').AsString := FormatDateTime('ddmmyyyy', QGrupoT.FieldByName('fecha_factura_fc').AsDateTime);
  mtGrupoT.FieldByName('NumFactura').AsInteger := QGrupoT.FieldByName('n_factura_fc').AsInteger;
  mtGrupoT.FieldByName('CodCliente').AsString := QGrupoT.FieldByName('cod_cliente_fc').AsString;
  mtGrupoT.FieldByName('CtaCliente').AsString := QGrupoT.FieldByName('cta_cliente_fc').AsString;
  mtGrupoT.FieldByName('DirCliente').AsString := GetDirCliente;
  mtGrupoT.FieldByName('FPAdonix').AsString := GetFormaPago;
  mtGrupoT.FieldByName('PrevCobro').AsString := FormatDateTime('ddmmyyyy', QGrupoT.FieldByName('prevision_cobro_fc').AsDateTime);
  mtGrupoT.FieldByName('CodMoneda').AsString := QGrupoT.FieldByName('moneda_fc').AsString;
  mtGrupoT.FieldByName('CambioMoneda').AsString := GetCambioMoneda;
  mtGrupoT.FieldByName('TipoImpuesto').AsString := GetTipoImpuesto;
  mtGrupoT.FieldByName('FechaAlbaran').AsString := FormatDateTime('ddmmyyyy', QDatosAlb.FieldByName('fecha_albaran_fd').AsDateTime);
  mtGrupoT.FieldByName('NumAlbaran').AsString := GetAlbaran;
  mtGrupoT.FieldByName('FactOrigen').AsString := GetFactOrigen;
  if QGrupoT.FieldByName('es_reg_acuerdo_fc').AsInteger = 1  then
    mtGrupoT.FieldByName('NumRegistroAcuerdo').AsString := GetFactRegistroAcuerdo
  else
    mtGrupoT.FieldByName('NumRegistroAcuerdo').AsString := '';

  mtGrupoT.Post;

  if bInterPlanta then
  begin
    mtGrupoTEx.Append;
    mtGrupoTEx.FieldByName('TipoFactura').AsString := GetTipoFacturaAux( mtGrupoT.FieldByName('TipoFactura').AsString );
    mtGrupoTEx.FieldByName('CodFactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;
    mtGrupoTEx.FieldByName('CodEmpresaFac').AsString := GetPlantaCliente( QGrupoT.FieldByName('cta_cliente_fc').AsString,
                                                                          QGrupoT.FieldByName('cod_empresa_fac_fc').AsString );
    mtGrupoTEx.FieldByName('DirEmpresaFac').AsString := GetDireccionPlanta( mtGrupoTEx.FieldByName('CodEmpresaFac').AsString,
                                                                            mtGrupoT.FieldByName('TipoImpuesto').AsString);
    mtGrupoTEx.FieldByName('FechaFactura').AsString := FormatDateTime('ddmmyyyy', QGrupoT.FieldByName('fecha_factura_fc').AsDateTime);
    mtGrupoTEx.FieldByName('NumFactura').AsInteger := QGrupoT.FieldByName('n_factura_fc').AsInteger;
    mtGrupoTEx.FieldByName('CodCliente').AsString := GetCodVendedor( QGrupoT.FieldByName('cod_empresa_fac_fc').AsString );
    mtGrupoTEx.FieldByName('CtaCliente').AsString := GetCtaVendedor( QGrupoT.FieldByName('cod_empresa_fac_fc').AsString );
    mtGrupoTEx.FieldByName('DirCliente').AsString := GetDireccionVendedor( QGrupoT.FieldByName('cod_empresa_fac_fc').AsString,
                                                                           mtGrupoT.FieldByName('TipoImpuesto').AsString );
    mtGrupoTEx.FieldByName('FPAdonix').AsString := mtGrupoT.FieldByName('FPAdonix').AsString;
    mtGrupoTEx.FieldByName('PrevCobro').AsString := FormatDateTime('ddmmyyyy', QGrupoT.FieldByName('prevision_cobro_fc').AsDateTime);
    mtGrupoTEx.FieldByName('CodMoneda').AsString := QGrupoT.FieldByName('moneda_fc').AsString;
    mtGrupoTEx.FieldByName('CambioMoneda').AsString := mtGrupoT.FieldByName('CambioMoneda').AsString;
    mtGrupoTEx.FieldByName('TipoImpuesto').AsString := mtGrupoT.FieldByName('TipoImpuesto').AsString;
    mtGrupoTEx.FieldByName('FechaAlbaran').AsString := FormatDateTime('ddmmyyyy', QGrupoT.FieldByName('fecha_factura_fc').AsDateTime);;
    mtGrupoTEx.FieldByName('NumAlbaran').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;
    mtGrupoTEx.FieldByName('FactOrigen').AsString := GetAsientoOrigen;

    mtGrupoTEx.Post;
  end
  else
  begin
    //
  end;
end;


procedure AddLineaT;
var sCadena: string;
begin
  sCadena := '"T' + '";"';
  sCadena := sCadena + mtGrupoT.FieldByName('TipoFactura').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldByName('CodFactura').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldByName('CodEmpresaFac').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldByName('DirEmpresaFac').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldByName('FechaFactura').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('CtaCliente').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('DirCliente').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('CodMoneda').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('CambioMoneda').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('CtaCliente').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('DirCliente').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('TipoImpuesto').AsString + '";"'+'";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('FechaAlbaran').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('NumAlbaran').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('FactOrigen').AsString + '";"';
  sCadena := sCadena + mtGrupoT.FieldbyName('NumRegistroAcuerdo').AsString + '"';

  slFicheroConta.Add( sCadena );

  if bInterPlanta then
  begin
    sCadena := '"T' + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldByName('TipoFactura').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldByName('CodEmpresaFac').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldByName('DirEmpresaFac').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldByName('FechaFactura').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldbyName('CtaCliente').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldbyName('DirCliente').AsString + '";"';
    sCadena := sCadena + '2";"';
    sCadena := sCadena + mtGrupoTEx.FieldbyName('CodMoneda').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldbyName('CambioMoneda').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldbyName('CtaCliente').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldbyName('DirCliente').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldbyName('TipoImpuesto').AsString + '";"'+'";"';
    sCadena := sCadena + mtGrupoTEx.FieldbyName('FechaAlbaran').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldbyName('NumAlbaran').AsString + '";"';
    sCadena := sCadena + mtGrupoTEx.FieldbyName('FactOrigen').AsString + '"';

    slFicheroVenta.Add( sCadena );
  end;
end;

procedure GrabarGrupoD;
begin
  mtGrupoD.Append;
  mtGrupoD.FieldByName('CodFactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;
  mtGrupoD.FieldByName('CodEmpresa').AsString := GetEmpresa(QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString);
  mtGrupoD.FieldByName('CodCliente').AsString := QGrupoD.FieldByName('cod_cliente_albaran_fd').AsString;
  mtGrupoD.FieldByName('CtaC').AsString := QGrupoD.FieldByName('cta_ingresos_pgc_c').AsString;
  mtGrupoD.FieldByName('CtaA').AsString := QGrupoD.FieldByName('cta_ingresos_pga_c').AsString;
  mtGrupoD.FieldByName('ImporteNeto').AsFloat := GetImpNetoGrupo;
  mtGrupoD.FieldByName('PorcImpuesto').AsString := GetPorcImpuesto;
  mtGrupoD.FieldByName('FactCliente').AsString := mtGrupoT.FieldByName('TipoFactura').AsString + ' ' + QGrupoT.FieldByName('cta_cliente_fc').AsString;

  mtGrupoD.Post;

  if bInterPlanta then
  begin
    mtGrupoDEx.Append;
    mtGrupoDEx.FieldByName('CodFactura').AsString := mtGrupoTEx.FieldByName('CodFactura').AsString;
    mtGrupoDEx.FieldByName('CodEmpresa').AsString := mtGrupoTEx.FieldByName('CodEmpresaFac').AsString;
    mtGrupoDEx.FieldByName('CodCliente').AsString := mtGrupoTEx.FieldByName('CodCliente').AsString;
    mtGrupoDEx.FieldByName('CtaC').AsString := GetCuentaContableCompra;
    mtGrupoDEx.FieldByName('CtaA').AsString := GetCuentaAnaliticaCompra;
    mtGrupoDEx.FieldByName('ImporteNeto').AsFloat := mtGrupoD.FieldByName('ImporteNeto').AsFloat;
    mtGrupoDEx.FieldByName('PorcImpuesto').AsString := mtGrupoD.FieldByName('PorcImpuesto').AsString;
    mtGrupoDEx.FieldByName('FactCliente').AsString := mtGrupoTEx.FieldByName('TipoFactura').AsString + ' ' + mtGrupoTEx.FieldByName('CtaCliente').AsString;

    mtGrupoDEx.Post;
  end;
end;

procedure AddLineaD;
var sCadena: string;
begin
  sCadena := '"D' + '";"';
  sCadena := sCadena + IntToStr(iNumLinea) + '";"';
  sCadena := sCadena + mtGrupoD.FieldByNAme('CodEmpresa').AsString + '";"';
  sCadena := sCadena + 'SPA' + '";"';
  sCadena := sCadena + mtGrupoD.FieldByName('CtaC').AsString + '";"';
  sCadena := sCadena + 'AES' + '";"';
  sCadena := sCadena + mtGrupoD.FieldByName('CtaA').AsString + '";"';
  sCadena := sCadena + FormatFloat('#0.00', bRoundTo(mtGrupoD.FieldByName('ImporteNeto').AsFloat, 2) ) + '";"';
  sCadena := sCadena + mtGrupoD.FieldByName('PorcImpuesto').AsString + '";"';
  sCadena := sCadena + mtGrupod.FieldByName('FactCliente').AsString + '"';

  slFicheroConta.Add( sCadena );

  if bInterPlanta then
  begin
    sCadena := '"D' + '";"';
    sCadena := sCadena + IntToStr(iNumLinea) + '";"';
    sCadena := sCadena + mtGrupoDEx.FieldByNAme('CodEmpresa').AsString + '";"';
    sCadena := sCadena + 'SPA' + '";"';
    sCadena := sCadena + mtGrupoDEx.FieldByName('CtaC').AsString + '";"';
    sCadena := sCadena + 'AES' + '";"';
    sCadena := sCadena + mtGrupoDEx.FieldByName('CtaA').AsString + '";"';
    sCadena := sCadena + FormatFloat('#0.00', bRoundTo(mtGrupoDEx.FieldByName('ImporteNeto').AsFloat, 2) ) + '";"';
    sCadena := sCadena + mtGrupoDEx.FieldByName('PorcImpuesto').AsString + '";"';
    sCadena := sCadena + mtGrupodEx.FieldByName('FactCliente').AsString + '"';

    slFicheroVenta.Add( sCadena );
  end;
end;

procedure GrabarGrupoA;
begin
  mtGrupoA.Append;

    mtGrupoA.FieldByName('CodFactura').AsString := mtGrupoT.FieldByName('CodFactura').AsString;
    mtGrupoA.FieldByName('CodEmpresa').AsString := mtGrupoD.FieldByName('CodEmpresa').AsString;
    mtGrupoA.FieldByName('CtaC').AsString := mtGrupoD.FieldByName('CtaC').AsString;
    mtGrupoA.FieldByName('CtaA').AsString := mtGrupoD.FieldByName('CtaA').AsString;
    mtGrupoA.FieldByName('PorcImpuesto').AsString := mtGrupoD.FieldByName('PorcImpuesto').AsString;
    mtGrupoA.FieldByName('SecContable').AsString := QGrupoA.FieldByName('sec_contable').AsString;
    mtGrupoA.FieldByName('ImporteNeto').AsFloat := GetImpNetoSeccion;
    mtGrupoA.FieldByName('Kilos').AsFloat := GetKilos;

  mtGrupoA.Post;

  if bInterPlanta then
  begin
    mtGrupoAEx.Append;

    mtGrupoAEx.FieldByName('CodFactura').AsString := mtGrupoTEx.FieldByName('CodFactura').AsString;
    mtGrupoAEx.FieldByName('CodEmpresa').AsString := mtGrupoDEx.FieldByName('CodEmpresa').AsString;
    mtGrupoAEx.FieldByName('CtaC').AsString := mtGrupoDex.FieldByName('CtaC').AsString;
    mtGrupoAEx.FieldByName('CtaA').AsString := mtGrupoDEx.FieldByName('CtaA').AsString;
    mtGrupoAEx.FieldByName('PorcImpuesto').AsString := mtGrupoDEx.FieldByName('PorcImpuesto').AsString;
    mtGrupoAEx.FieldByName('SecContable').AsString := GetSeccionContableCompra( QGrupoT.FieldByName('cod_empresa_fac_fc').AsString,
                                                                                mtGrupoA.FieldByName('SecContable').AsString,
                                                                                mtGrupoDEx.FieldByName('CodEmpresa').AsString);
    mtGrupoAEx.FieldByName('ImporteNeto').AsFloat := mtGrupoA.FieldByName('ImporteNeto').AsFloat;
    mtGrupoAEx.FieldByName('Kilos').AsFloat := mtGrupoA.FieldByName('Kilos').AsFloat;

    mtGrupoAEx.Post;
  end;
end;

procedure GrabarGrupoANueva;
begin
  mtGrupoA.Append;

  mtGrupoA.FieldByName('CodFactura').AsString := mtGrupoT.FieldByName('CodFactura').AsString;
  mtGrupoA.FieldByName('CodEmpresa').AsString := mtGrupoD.FieldByName('CodEmpresa').AsString;
  mtGrupoA.FieldByName('CtaC').AsString := mtGrupoD.FieldByName('CtaC').AsString;
  mtGrupoA.FieldByName('CtaA').AsString := mtGrupoD.FieldByName('CtaA').AsString;
  mtGrupoA.FieldByName('PorcImpuesto').AsString := mtGrupoD.FieldByName('PorcImpuesto').AsString;
  mtGrupoA.FieldByName('SecContable').AsString := mtGastos_Conta.FieldByName('seccion_contable').AsString;
  mtGrupoA.FieldByName('ImporteNeto').AsFloat := GetImpNuevaLinea;
  mtGrupoA.FieldByName('Kilos').AsFloat := 0;

  mtGrupoA.Post;

  if bInterPlanta then
  begin
    mtGrupoAEx.Append;

    mtGrupoAEx.FieldByName('CodFactura').AsString := mtGrupoTEx.FieldByName('CodFactura').AsString;
    mtGrupoAEx.FieldByName('CodEmpresa').AsString := mtGrupoDEx.FieldByName('CodEmpresa').AsString;
    mtGrupoAEx.FieldByName('CtaC').AsString := mtGrupoDEx.FieldByName('CtaC').AsString;
    mtGrupoAEx.FieldByName('CtaA').AsString := mtGrupoDEx.FieldByName('CtaA').AsString;
    mtGrupoAEx.FieldByName('PorcImpuesto').AsString := mtGrupoDEx.FieldByName('PorcImpuesto').AsString;
    mtGrupoAEx.FieldByName('SecContable').AsString := 'B18-CP0001';//mtGastos_Conta.FieldByName('seccion_contable').AsString;
    mtGrupoAEx.FieldByName('ImporteNeto').AsFloat := mtGrupoA.FieldByName('ImporteNeto').AsFloat;
    mtGrupoAEx.FieldByName('Kilos').AsFloat := 0;

    mtGrupoAEx.Post;
  end;
end;

procedure AddLineaA;
var sCadena: string;
begin
  sCadena := '"A' + '";"';
  sCadena := sCadena + IntToStr(iNumLinea) + '";"';
  sCadena := sCadena + IntToStr(iNumSecc) + '";"';
  sCadena := sCadena + 'AX1' + '";"';
  sCadena := sCadena + mtGrupoA.FieldByName('SecContable').AsString + '";"';
  sCadena := sCadena + '";"";"";"";"";"";"';
  sCadena := sCadena + FormatFloat( '#0.00', bRoundTo(mtGrupoA.FieldByName('ImporteNeto').AsFloat, 2)) + '";"';
  sCadena := sCadena + 'KG' + '";"';
  sCadena := sCadena + FormatFloat( '#0.00', mtGrupoA.FieldByName('Kilos').AsFloat) + '"';

  slFicheroConta.Add( sCadena );

  if bInterPlanta then
  begin
    sCadena := '"A' + '";"';
    sCadena := sCadena + IntToStr(iNumLinea) + '";"';
    sCadena := sCadena + IntToStr(iNumSecc) + '";"';
    sCadena := sCadena + 'AX1' + '";"';
    sCadena := sCadena + mtGrupoAEx.FieldByName('SecContable').AsString + '";"';
    sCadena := sCadena + '";"";"";"";"";"";"';
    sCadena := sCadena + FormatFloat( '#0.00', bRoundTo(mtGrupoAEx.FieldByName('ImporteNeto').AsFloat, 2) ) + '";"';
    sCadena := sCadena + 'KG' + '";"';
    sCadena := sCadena + FormatFloat( '#0.00', mtGrupoAEx.FieldByName('Kilos').AsFloat) + '"';

    slFicheroVenta.Add( sCadena );
  end;
end;

procedure GrabarGrupoE;
begin
  mtGrupoE.Append;

  mtGrupoE.FieldByName('CodFactura').AsString := mtGrupoD.FieldByName('CodFactura').AsString;
  mtGrupoE.FieldByName('CodEmpresa').AsString := mtGrupoD.FieldByName('CodEmpresa').AsString;
  mtGrupoE.FieldByName('CtaC').AsString := mtGrupoD.FieldByName('CtaC').AsString;
  mtGrupoE.FieldByName('CtaA').AsString := mtGrupoD.FieldByName('CtaA').AsString;
  mtGrupoE.FieldByName('PrevCobro').AsString := mtGrupoT.FieldByName('PrevCobro').AsString;
  mtGrupoE.FieldByName('PorcImpuesto').AsString := GetPorcImpuesto;
  mtGrupoE.FieldByName('FormaPago').AsString := mtGrupoT.FieldByName('FPAdonix').AsString;
  mtGrupoE.FieldByName('ImporteTotal').AsFloat := GetImpTotalGrupo;
  mtGrupoE.FieldByName('DirCliente').AsString := GetDirCliente;

  mtGrupoE.Post;

  if bInterPlanta then
  begin
    mtGrupoEEx.Append;

    mtGrupoEEx.FieldByName('CodFactura').AsString := mtGrupoDEx.FieldByName('CodFactura').AsString;
    mtGrupoEEx.FieldByName('CodEmpresa').AsString := mtGrupoDEx.FieldByName('CodEmpresa').AsString;
    mtGrupoEEx.FieldByName('CtaC').AsString := mtGrupoDEx.FieldByName('CtaC').AsString;
    mtGrupoEEx.FieldByName('CtaA').AsString := mtGrupoDEx.FieldByName('CtaA').AsString;
    mtGrupoEEx.FieldByName('PrevCobro').AsString := mtGrupoTEx.FieldByName('PrevCobro').AsString;
    mtGrupoEEx.FieldByName('PorcImpuesto').AsString := mtGrupoE.FieldByName('PorcImpuesto').AsString;
    mtGrupoEEx.FieldByName('FormaPago').AsString := mtGrupoTEx.FieldByName('FPAdonix').AsString;
    mtGrupoEEx.FieldByName('ImporteTotal').AsFloat := mtGrupoE.FieldByName('ImporteTotal').AsFloat;
    mtGrupoEEx.FieldByName('DirCliente').AsString := mtGrupoTEx.FieldByName('DirCliente').AsString;

    mtGrupoEEx.Post;
  end;
end;

procedure AddLineaE;
var sCadena: string;
begin
  sCadena := '"E' + '";"';
  sCadena := sCadena + IntToStr(iNumLinea) + '";"';
  sCadena := sCadena + mtGrupoE.FieldByName('PrevCobro').AsString + '";"';
  sCadena := sCadena + mtGrupoE.FieldByName('PorcImpuesto').AsString + '";"';
  sCadena := sCadena + mtGrupoE.FieldByName('FormaPago').AsString + '";"';
  sCadena := sCadena + FormatFloat( '#0.00', bRoundTo(mtGrupoE.FieldByName('ImporteTotal').AsFloat, 2)) + '";"';
  sCadena := sCadena + mtGrupoE.FieldByName('DirCliente').AsString + '";"';
  sCadena := sCadena + mtGrupoE.FieldByName('DirCliente').AsString + '"';

  slFicheroConta.Add( sCadena );

  if bInterPlanta then
  begin
    sCadena := '"E' + '";"';
    sCadena := sCadena + IntToStr(iNumLinea) + '";"';
    sCadena := sCadena + mtGrupoEEx.FieldByName('PrevCobro').AsString + '";"';
    sCadena := sCadena + mtGrupoEEx.FieldByName('PorcImpuesto').AsString + '";"';
    sCadena := sCadena + mtGrupoEEx.FieldByName('FormaPago').AsString + '";"';
    sCadena := sCadena + FormatFloat( '#0.00', bRoundTo(mtGrupoEEx.FieldByName('ImporteTotal').AsFloat, 2)) + '";"';
    sCadena := sCadena + mtGrupoEEx.FieldByName('DirCliente').AsString + '";"';
    sCadena := sCadena + mtGrupoEEx.FieldByName('DirCliente').AsString + '"';

    slFicheroVenta.Add( sCadena );
  end;
end;

function SumaNetoGrupo: real;
var rImpGrupo : Real;
begin
  rImpGrupo := QImpGrupoD.Fieldbyname('importe_neto_fd').AsFloat;

  mtGastos_Conta.Filter := ' porcentaje_gasto = ' + QGrupoD.FieldByName('porcentaje_impuesto').AsString + ' AND ' +
                           ' empresa_albaran = ' + QuotedStr(QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString) + ' AND ' +
                           ' cta_c = ' + QuotedStr(QGrupoD.FieldByName('cta_ingresos_pgc_c').AsString) + ' AND ' +
                           ' cta_a = ' + QuotedStr(QGrupoD.FieldByName('cta_ingresos_pga_c').AsString);
  mtGastos_Conta.Filtered := true;
  mtGastos_Conta.First;
  while not mtGastos_Conta.Eof do
  begin

    rImpGrupo := rImpGrupo + mtGastos_Conta.FieldByName('importe_gasto').AsFloat;

    mtGastos_Conta.Next;
  end;
  mtGastos_Conta.Filter := '';
  mtGastos_Conta.Filtered := false;

  result := rImpGrupo;
end;

function SumaTotalGrupo: real;
begin
  result := rImpNetoGrupo +  bRoundTo(rImpNetoGrupo * QGrupoD.FieldByName('porcentaje_impuesto').asFloat / 100, 2);
end;

function SumaNetoSeccion: real;
var rImpSeccion: Real;
begin
  rImpSeccion := QGrupoA.Fieldbyname('importe_neto').AsFloat;
  mtGastos_Conta.Filter := ' porcentaje_gasto = ' + QGrupoD.FieldByName('porcentaje_impuesto').AsString + ' AND ' +
                           ' empresa_albaran = ' + QuotedStr(QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString) + ' AND ' +
                           ' cta_c = ' + QuotedStr(QGrupoD.FieldByName('cta_ingresos_pgc_c').AsString) + ' AND ' +
                           ' cta_a = ' + QuotedStr(QGrupoD.FieldByName('cta_ingresos_pga_c').AsString) + ' AND ' +
                           ' seccion_contable = ' + QuotedStr(QGrupoA.FieldByName('sec_contable').AsString);
  mtGastos_Conta.Filtered := true;
  mtGastos_Conta.First;
  while not mtGastos_Conta.Eof do
  begin

    rImpSeccion := rImpSeccion + mtGastos_Conta.FieldByName('importe_gasto').AsFloat;

    mtGastos_Conta.Next;
  end;
  mtGastos_Conta.Filter := '';
  mtGastos_Conta.Filtered := false;

  result := rImpSeccion;
end;

procedure NuevaSeccionContable;
begin
  mtGastos_Conta.Filter := ' porcentaje_gasto = ' + QGrupoD.FieldByName('porcentaje_impuesto').AsString + ' AND ' +
                           ' empresa_albaran = ' + QuotedStr(QGrupoD.FieldByName('cod_empresa_albaran_fd').AsString) + ' AND ' +
                           ' cta_c = ' + QuotedStr(QGrupoD.FieldByName('cta_ingresos_pgc_c').AsString) + ' AND ' +
                           ' cta_a = ' + QuotedStr(QGrupoD.FieldByName('cta_ingresos_pga_c').AsString);
  mtGastos_Conta.Filtered := true;
  mtGastos_Conta.First;
  while not mtGastos_Conta.Eof do
  begin
    rImpTotalSeccion := rImpTotalSeccion + mtGastos_Conta.FieldByName('importe_gasto').AsFloat;

    GrabarGrupoANueva;

    mtGastos_Conta.Next;
    Inc(iNumSecc);
  end;
  mtGastos_Conta.Filter := '';
  mtGastos_Conta.Filtered := False;
end;

function ObtenerTotalLineas: real;
begin
  with QImpTotalLineas do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;
    Open;
    if IsEmpty then
      result := 0
    else
      result := QImpTotalLineas.FieldByName('importe_neto_total').AsFloat;
  end;
end;

function GetTipoFactura: string;
begin
  if QGrupoT.FieldByName('tipo_factura_fc').AsString = '380' then
    Result := 'FGC'                                            //Factura ('380')
  else
    Result := 'AGC';                                           //Abono ('381')
end;

function GetTipoFacturaAux( const ATipoVenta: string ): string;
begin
  if ATipoVenta = 'FGC' then
    Result := 'FAC'
  else
    Result := 'ABO';
end;

function GetDirEmpresa: String;                                                        
begin
    if Copy( QGrupoT.FieldByName('cod_empresa_fac_fc').AsString, 1, 1 ) = 'F' then
  begin
    //Solo una direccion por planta financiera
    result:= '001';
  end
  else
  begin
    if QGrupoT.FieldByName('cod_empresa_fac_fc').AsString = '062' then
    begin
      result:= '001';  //BardizaVerde solo tiene una planta y esta en tenerife
    end
    else
    begin
      if QGrupoT.FieldByName('impuesto_fc').AsString = 'I' then
        result:= '001'  //Peninsula
      else
       result:= '002'; //Tenerife
    end;
  end;
end;

function GetDirCliente: String;
begin
  if (( QGrupoT.FieldByName('cta_cliente_fc').AsString = 'BONDELICIO'  ) or
      ( QGrupoT.FieldByName('cta_cliente_fc').AsString = 'MERCADONA' ) or
      ( QGrupoT.FieldByName('cta_cliente_fc').AsString = 'SOCOMO'  ) or
      ( QGrupoT.FieldByName('cta_cliente_fc').AsString = 'LIDL' ) or
      ( QGrupoT.FieldByName('cta_cliente_fc').AsString = 'CARREFOUR' )  or
      ( QGrupoT.FieldByName('cta_cliente_fc').AsString = 'HNOS-FE-LO' ))
     and ( QGrupoT.FieldByName('impuesto_fc').AsString = 'G' ) then
    Result := '002'
  else
    Result := '001';
end;

function GetCambioMoneda: String;
begin
{ TODO : generar una factura con moneda <> EUR }

  if QGrupoT.FieldByName('importe_total_euros_fc').AsFloat  = 0 then
    result := '0'
  else
    result := FloatToStr(bRoundTo(QGrupoT.FieldByName('importe_total_fc').AsFloat /
                                  QGrupoT.FieldByName('importe_total_euros_fc').AsFloat, -5));
end;

function GetTipoImpuesto: String;
begin
  if QGrupoT.FieldByName('tipo_impuesto_fc').AsString = 'IR' then
  begin
    Result:= 'PEN';
  end
  else
  if QGrupoT.FieldByName('tipo_impuesto_fc').AsString = 'IC' then
  begin
    Result:= 'CEE';
  end
  else
  if QGrupoT.FieldByName('tipo_impuesto_fc').AsString = 'IE' then
  begin
    Result:= 'EXP';
  end
  else
  if QGrupoT.FieldByName('tipo_impuesto_fc').AsString = 'GR' then
  begin
    Result:= 'CAN';
  end
  else
  if QGrupoT.FieldByName('tipo_impuesto_fc').AsString = 'GE' then
  begin
    Result:= 'EXC';
  end
  else
  begin
    Result:= '';
  end;
end;

function GetAlbaran: String;
begin
  result := QDatosAlb.FieldByName('cod_dir_sum_fd').AsString + '-' +
            QDatosAlb.FieldByName('n_albaran_fd').AsString;
end;

function GetFactOrigen: String;
var FechaFactOrigen: TDateTime;
begin
  if QGrupoT.FieldByName('tipo_factura_fc').AsString = '380' then
    result := ''
  else
  begin
    if QGrupoT.FieldByName('anulacion_fc').AsInteger = 0 then
    begin
      if QGrupoT.FieldByName('automatica_fc').AsInteger = 0 then
      begin
        if QFactOrigen.FieldByName('cod_factura_origen_fd').AsString = '' then
        begin
          BuscarFactOrigen;
          if QFactOrigen.FieldByName('cod_factura_origen_fd').AsString = '' then
            raise Exception.Create('No existe Factura Origen para el Abono ' + QGrupoT.FieldByName('cod_factura_fc').AsString + '.')
        end;
      end;
    end
    else      //Anulacion
    begin
      if QGrupoT.FieldByName('cod_factura_anula_fc').AsString = '' then
        raise Exception.Create('No existe Factura Origen para la Anulacion ' + QGrupoT.FieldByName('cod_factura_fc').AsString + '.')
    end;

    FechaFactOrigen := GetFechaFactOrigen;
    if FechaFactOrigen > QGrupoT.FieldByName('fecha_factura_fc').AsDateTime then
      raise Exception.Create('La Fecha de la Factura Origen ' + QFactOrigen.FieldByName('cod_factura_origen_fd').AsString +
                             ' ( ' + DateToStr(FechaFactOrigen) + ' ) ' +
                             ' es superior a la Fecha del Abono ( ' + QGrupoT.FieldByName('fecha_factura_fc').AsString + ' ).')
    else
      if QGrupoT.FieldByName('anulacion_fc').AsInteger = 0 then
        result := QFactOrigen.FieldByName('cod_factura_origen_fd').AsString
      else
        result := QGrupoT.FieldByName('cod_factura_anula_fc').AsString;
  end;
end;

function GetEmpresa(AEmpresa: String): String;
begin
  if AEmpresa = '080' then
    result := 'F80'
  else
    result := AEmpresa;
end;

function GetPorcImpuesto: String;
begin
  //Superreduciso. reducio y general
  if QGrupoT.FieldByName('tipo_impuesto_fc').AsString = 'IR' then
  begin
    //000 sin iva
    //001 iva general, al 18%
    if ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 16 ) or
       ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 18 ) or
       ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 21 ) then
      //General al 21% antes al 18% antes el 16%
      Result:= '001'
    else
    if ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 7 ) or
       ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 8 ) or
       ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 10 ) then
      //Reducido al 10% antes al 8% antes el 7%
      Result:= '002'
    else
    if ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 4 )  then
      //Super Reducido al 4%
      Result:= '003'
    //CON RECARGO DE EQUIVALENCIA
    else
    if ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 26.20 )  then
      //Super Reducido al 20%  + Recargo al 5.20%
      Result:= '011'
    else
    if ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 11.40 )  then
      //Super Reducido al 10%  + Recargo al 1.40%
      Result:= '012'
    else
    if ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 4.50 )  then
      //Super Reducido al 4%  + Recargo al 0.50%
      Result:= '013'
    else
    if ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 0 )  then
      Result:= '000'
    else
      Result:= ''
  end
  else
  if QGrupoT.FieldByName('tipo_impuesto_fc').AsString = 'IC' then
  begin
    Result:= '020';
  end
  else
  if QGrupoT.FieldByName('tipo_impuesto_fc').AsString = 'IE' then
  begin
    Result:= '030';
  end
  else
  if QGrupoT.FieldByName('tipo_impuesto_fc').AsString = 'GR' then
  begin
    if QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 7 then
      //General al 2%
      Result:= '041'
    else
    if ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 5 ) or
       ( QGrupoD.FieldByName('porcentaje_impuesto').AsFloat = 2 ) then
      //Reducido al 5% //antes al 2%
      Result:= '042'
    else
      //Super Reducido al 0%
      Result:= '043';
  end
  else
  if QGrupoT.FieldByName('tipo_impuesto_fc').AsString = 'GE' then
  begin
    Result:= '053';
  end
  else
  begin
    Result:= '';
  end;
end;

function GetImpNetoGrupo: Real;
begin
  if QGrupoT.FieldByName('tipo_factura_fc').AsString = '380' then
    result := rImpNetoGrupo                                             // Factura
  else
    Result := rImpNetoGrupo * (-1);                                     // Abono
end;

function GetImpNetoSeccion: Real;
begin
  if QGrupoT.FieldByName('tipo_factura_fc').AsString = '380' then
    result := rImpNetoSeccion                                           // Factura
  else
    result := rImpNetoSeccion * (-1);                                   // Abono
end;

function GetKilos: Real;
begin
    if QGrupoT.FieldByName('tipo_factura_fc').AsString = '380' then
    result := QGrupoA.FieldByName('kilos').AsFloat                      // Factura
  else
    result := QGrupoA.FieldByName('kilos').AsFloat * (-1);              // Abono
end;

function GetImpNuevaLinea: Real;
begin
  if QGrupoT.FieldByName('tipo_factura_fc').AsString = '380' then
    result := mtGastos_Conta.FieldByName('importe_gasto').AsFloat
  else
    result := mtGastos_Conta.FieldByName('importe_gasto').AsFloat * (-1);
end;

function GetImpTotalGrupo: Real;
begin
  if QGrupoT.FieldByName('tipo_factura_fc').AsString = '380' then
    result := rImpTotalGrupo
  else
    result := rImpTotalGrupo * (-1);
end;

function GetFechaFactOrigen: TDateTime;
begin
  with QAux do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QFactOrigen.FieldByName('cod_factura_origen_fd').AsString;
    Open;

    result := FieldByName('fecha_factura_fc').AsDateTime;

  end;
end;

function GetFactRegistroAcuerdo: String;
begin
  with QAcuerdoComercial do
  begin
    if Active then
      Close;
    ParamByName('CLI').asString := QGrupoT.FieldByName('cod_cliente_fc').asString;
    Open;

    Result := FieldByName('reg_acuerdo_ac').asString;
  end;
end;

procedure BuscarFactOrigen;
var sClaveFactura: string;
begin

  with QDetalleFact do
  begin
    if Active then
      Close;

    ParamByName('codfactura').AsString := QGrupoT.FieldByName('cod_factura_fc').AsString;
    Open;

    QDetalleFact.First;
    while not QDetalleFact.Eof do
    begin
      if QAlbaran.Active then QAlbaran.Close;

      QAlbaran.ParamByName('empresa').AsString := QDetalleFact.FieldByName('cod_empresa_albaran_fd').AsString;
      QAlbaran.ParamByName('centro').AsString := QDetalleFact.FieldByName('cod_centro_albaran_fd').AsString;
      QAlbaran.ParamByName('albaran').AsString := QDetalleFact.FieldByName('n_albaran_fd').AsString;
      QAlbaran.ParamByName('fecha').AsString := QDetalleFact.FieldByName('fecha_albaran_fd').AsString;
      QAlbaran.Open;

      if QAlbaran.FieldByName('n_factura_sc').AsString <> '' then
      begin
        if not (QDetalleFact.State in dsEditModes) then QDetalleFact.Edit;
        sClaveFactura := BuscarFactura(QAlbaran.FieldByName('empresa_fac_sc').AsString,
                                       QAlbaran.FieldByName('serie_fac_sc').AsString,
                                       QAlbaran.FieldByName('fecha_factura_sc').AsString,
                                       QAlbaran.FieldByName('n_factura_sc').AsString);
        QDetalleFact.FieldByName('cod_factura_origen_fd').AsString := sClaveFactura;
        QDetalleFact.Post;
      end;

      QDetalleFact.Next;
    end;

  end;

  EjecutaQFactOrigen;

  if QAlbaran.Active then  QAlbaran.Close;
end;

function BuscarFactura(AEmpresa, ASerie, AFecha, ANumero: string): String;
begin
  with QFact do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('serie').AsString := ASerie;
    ParamByName('numero').AsString := ANumero;
    ParamByName('fecha').AsString := AFecha;
    Open;

    Result := FieldByName('cod_factura_fc').AsString;

  end;

end;

procedure CerrarTablas;
begin
  CloseQuerys([QGrupoD, QGrupoA, QImpGrupoD, QGastos, QDatosAlb, QFactOrigen]);
end;

procedure CloseQuery(AQuery: TDataSet);
begin
  if AQuery.Active then
    AQuery.Close;
end;

procedure CloseQuerys(AQuerys: array of TDataSet);
var
  i: integer;
begin
  for i := 0 to Length(AQuerys) - 1 do
  begin
    CloseQuery(AQuerys[i]);
  end;
end;

procedure CrearBuffers;
begin
  slFicheroConta := TStringList.Create;
  slFicheroVenta := TStringList.Create;
  slErrores := TStringList.Create;
  slFicGenerados := TStringList.Create;
  slErrGenerados := TStringList.Create;
end;

procedure LimpiarBuffers;
begin
  slFicheroConta.Clear;
  slFicheroVenta.Clear;
  slErrores.Clear;
end;

procedure BorrarListas;
begin
  FreeAndNil(slFicheroConta);
  FreeAndNil(slFicheroVenta);
  FreeAndNil(slErrores);
  FreeAndNil(slFicGenerados);
  FreeAndNil(slErrGenerados);
end;

procedure Crearconsultas;
begin
  CreaQGrupoD;
  CreaQGrupoA;
  CreaQImpGrupoD;
  CreaQGastos;
  CreaQDatosAlb;
  CreaQFactOrigen;

  CreaQLineas;
  CreaQActFactura;
  CreaQFormaPago;
  CreaQImpTotalLineas;
  CreaQAux;
  CreaQAlbaran;
  CreaQInsFactOrigen;
  CreaQDetalleFact;
  CreaQFact;
  CreaQSeccion;
  CreaQSeccionCompra;
  CreaQRecargo;
  CreaQAcuerdoComercial;
end;

procedure FactSinErrores(AValor: integer);
begin
  mtGrupoT.Edit;
  mtGrupoT.FieldByName('FactSinErrores').AsInteger := AValor;
  mtGrupoT.Post;
end;

function ExisteSeccion(AEmpresa, ACentro, AEnvase: String): boolean;
begin
  with QSeccion do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('envase').AsString := AEnvase;
    Open;

    result := not IsEmpty;
  end;
end;

function ClienteConRecargo(const AEmpresa, ACliente: string; const AFecha: TDateTime ): boolean;
begin
  with QRecargo do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('cliente').AsString := ACliente;
    ParamByName('fecha').AsDate := AFecha;

    Open;

    Result:= not IsEmpty;
    end;
end;

end.
