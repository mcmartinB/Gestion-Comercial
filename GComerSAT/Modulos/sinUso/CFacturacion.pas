unit CFacturacion;

interface

var
  repeticionFlag: boolean;

procedure Limpiar;
procedure DescripcionMarca;
procedure PreparaRepeticion(empresa, desde, hasta, fechadesde,
  fechahasta, pais, cliente: string;
  contabilizado: boolean);
procedure PreparaFacturacion(const ACliente, AFecha: string);
function EstaContabilizada(empresa, factura, fecha: string): boolean;

function PuedoFacturar(const AQuien: string; var VMsg: string ): boolean;
function QuieroFacturar(const AQuien: string; var VMsg: string ): boolean;
procedure AcaboFacturar(const AQuien: string );

implementation

uses SysUtils, bSQLUtils,
  CVariables, CAuxiliarDB,
  UDMFacturacion, UDMBaseDatos,
  DError, UDMAuxDB, DBTables, DB, dialogs;

procedure DescripcionMarca;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add('update tmp_facturas_l set ' +
      ' nom_marca_tf=(select descripcion_m from frf_marcas ' +
      '               where codigo_m=marca_tf)');
    ExecSql;
  end;
end;

//Rellenamos tabla temporal Lines

function LineasRepeticion(empresa, desde, hasta, fechadesde,
  fechahasta, pais, cliente: string;
  Contabilizado: boolean): boolean;
begin
     //LINEAS
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add('INSERT INTO tmp_facturas_l ');
    SQL.Add('    ( cod_emp_factura_tf, factura_tf,fecha_tf,usuario_tf,cod_empresa_tf,cod_procede_tf,');
    SQL.Add('      cod_cliente_sal_tf,cod_cliente_fac_tf,impuesto_tf,');
    SQL.Add('      pedido_tf,vehiculo_tf,albaran_tf,fecha_alb_tf,centro_salida_tf,');
    SQL.Add('      cod_pais_tf,moneda_tf,cod_dir_sum_tf,cod_producto_tf,');
    SQL.Add('      cod_envase_tf,producto_tf,producto2_tf,envase_tf,descripcion2_e,');
    SQL.Add('      cajas_tf,unidades_caja_tf,kilos_tf,unidades_tf,');
    SQL.Add('      unidad_medida_tf,precio_unidad_tf,precio_neto_tf,cod_iva_tf,');
    (*IVA*)
    SQL.Add('      tipo_iva_tf,iva_tf, importe_total_tf, envase_comer_tf, ');
    SQL.Add('      categoria_tf, calibre_tf,marca_tf,nom_marca_tf, transito_tf, ');
    SQL.Add('      incoterm_tf, plaza_incoterm_tf, porte_bonny_tf ) ');

    SQL.Add('SELECT empresa_fac_sc, n_factura_sc,');
    SQL.Add('fecha_factura_sc, ');
    SQL.Add(quotedStr(gsCodigo) + ', ');
    SQL.Add('empresa_sc,' +
      'emp_procedencia_sl,' +
      'cliente_sal_sc,' +
      'cliente_fac_sc,' +
      'tipo_iva_sl[1,1], ');
    SQL.Add('n_pedido_sc,' +
      'vehiculo_sc,' +
      'n_albaran_sc, ');
    SQL.Add('fecha_sc,' +
      'centro_salida_sc, ');
    SQL.Add('pais_fac_c,' +
      'moneda_sc,');
    SQL.Add('dir_sum_sc, ');
    SQL.Add('producto_sl,' +
      'envase_sl, ');
    SQL.Add('descripcion_p descripcion_prod, ');
    SQL.Add('descripcion2_p descripcion_prod2, ');
    SQL.Add('descripcion_e,' +
      'descripcion2_e,');
    SQL.Add('cajas_sl, ');
    SQL.Add('unidades_caja_sl,' +
      'kilos_sl, ');
    SQL.Add('(cajas_sl*unidades_caja_sl) as unidades, ');
    SQL.Add('unidad_precio_sl,' +
      'precio_sl, ');
    SQL.Add('importe_neto_sl,' +
      'tipo_iva_sl, ');

    (*IVA*)
    SQL.Add('Frf_salidas_l.porc_iva_sl,Frf_salidas_l.iva_sl,Frf_salidas_l.importe_total_sl, ');

    SQL.Add('envase_comercial_e,' +
      'categoria_sl,');
    SQL.Add('calibre_sl,');
    SQL.Add('marca_sl,"MARCA", 0, incoterm_sc, plaza_incoterm_sc, porte_bonny_sc ');

    SQL.Add('FROM ');
    SQL.Add('     frf_salidas_c , ');
    SQL.Add('     frf_salidas_l , ');
    SQL.Add('     frf_clientes , ');
    SQL.Add('     frf_productos , ');
    SQL.Add('     frf_envases , ');
    SQL.Add('     frf_facturas  ');
    SQL.Add('WHERE (empresa_sc = empresa_c) ');
    SQL.Add('AND  (cliente_fac_sc = cliente_c) ');
    SQL.Add('AND  (empresa_sc = empresa_sl) ');
    SQL.Add('AND  (centro_salida_sc = centro_salida_sl) ');
    SQL.Add('AND  (n_albaran_sc = n_albaran_sl) ');
    SQL.Add('AND  (fecha_sc = fecha_sl) ');
    SQL.Add('AND  (empresa_fac_sc  = empresa_f) ' +
      'AND  (n_factura_sc = n_factura_f) ' +
      'AND  (fecha_factura_sc = fecha_factura_f) ');
    if ( not Contabilizado ) and ( gsCodigo <> 'info') then
    begin
      SQL.Add('AND  (contabilizado_f <> "S") ');
    end;
    SQL.Add('AND  (empresa_sl = empresa_p) ');
    SQL.Add('AND  (producto_sl = producto_p) ');
    SQL.Add('AND  (envase_sl = envase_e) ');
    SQL.Add('AND  (empresa_e  = empresa_sc ) ');
    SQL.Add('AND  (empresa_fac_sc ' + SQLEqualS(empresa) + ') ');
    SQL.Add('AND  (n_factura_sc ' + SQLRangeN(desde, hasta) + ') ');
    SQL.Add('AND  (fecha_factura_sc ' + SQLRangeD(fechadesde, fechahasta) + ') ');
    if pais <> '' then SQL.Add('AND  (pais_c ' + SQLEqualS(pais) + ') ');
    if cliente <> '' then SQL.Add('AND  (cliente_c ' + SQLEqualS(cliente) + ') ');

    try
      DMBaseDatos.QGeneral.ExecSQL;
      LineasRepeticion := DMBaseDatos.QGeneral.RowsAffected > 0;
    except
      LineasRepeticion := false;
      Exit;
    end;
  end;
  DescripcionMarca;
end;

function QuitarDescuento: boolean;
var
  iProductos: Integer;
  sEmpresa, sCliente, sProductos: string;
begin
  Result:= False;
  iProductos:= 0;
  sEmpresa:= '';
  sCliente:= '';
  sProductos:= '';

  if ( DMBaseDatos.QGeneral.FieldByName('cod_empresa_tfc').AsString = '080' ) and
     ( DMBaseDatos.QGeneral.FieldByName('factura_tfc').AsInteger = 612) and
     ( DMBaseDatos.QGeneral.FieldByName('fecha_tfc').AsDateTime = StrToDate('18/12/2014') ) then
  begin
    Result:= True;
  end
  else
  with DMBaseDatos.QAux do
  begin
    ParamByName('cod_empresa_tfc').AsString:= DMBaseDatos.QGeneral.FieldByName('cod_empresa_tfc').AsString;
    ParamByName('factura_tfc').AsInteger:= DMBaseDatos.QGeneral.FieldByName('factura_tfc').AsInteger;
    ParamByName('fecha_tfc').AsDateTime:= DMBaseDatos.QGeneral.FieldByName('fecha_tfc').AsDateTime;
    Open;
    sEmpresa:= FieldByName('empresa').asstring;
    sCliente:= FieldByName('cliente').asstring;
    while not Eof do
    begin
      if sProductos = '' then
        sProductos:= FieldByName('producto').asstring
      else
        sProductos:= sProductos + ', ' + FieldByName('producto').asstring;
      iProductos:= iProductos + 1;
      if ( FieldByName('empresa').asstring = '080' ) and ( FieldByName('cliente').asstring = 'DOL' ) and ( FieldByName('producto').asstring = 'G' ) then
      begin
        Result:= True;
      end;
      Next;
    end;
    Close;
  end;

  if ( iProductos > 1 ) and Result then
  begin
    raise Exception.Create('ERROR: Los productos ' + sProductos + ' del cliente ' + sCliente +
                              ' de la empresa ' + sEmpresa + ' tiene diferentes descuentos.');
  end;
end;

//Rellenamos tabla temporal cabecera
function CabeceraFactura: boolean;
begin
     //CABECERA
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('INSERT INTO tmp_facturas_c ');
    SQL.Add('SELECT factura_tf,usuario_tf, fecha_tf, ');
    SQL.Add('cod_emp_factura_tf,cod_cliente_fac_tf,cod_cliente_fac_tf, ');
    SQL.Add('nombre_c,nvl(tipo_via_fac_c,'''') tipo_via_fac_c, ');
    SQL.Add('domicilio_fac_c,poblacion_fac_c, ');
    SQL.Add('cod_postal_fac_c, nombre_p, ');
    SQL.Add('descripcion_p,nif_c, ');
    SQL.Add(' GetComisionCliente( cod_empresa_tf, cod_cliente_fac_tf, fecha_tf ) comision_r, ');
    SQL.Add(' GetDescuentoCliente( cod_empresa_tf, cod_cliente_fac_tf, fecha_tf, 1 ) porc_dto_c, ');
    SQL.Add('cod_iva_tf, 0 porcentaje,'); //porcentaje_i, ');
    SQL.Add('tipo_i,descripcion_i, ');
    SQL.Add('moneda_tf,cta_cliente_c, ');
    SQL.Add('forma_pago_c, ');
    SQL.Add('"380","A", '); //Tipo y concepto
    if repeticionFlag then
      SQL.Add('SUM(precio_neto_tf),0,factura_tf, ') //importe neto,gastos y num factura final
    else
      SQL.Add('SUM(precio_neto_tf),0,0, '); //importe neto,gastos y num factura final
    SQL.Add('"", max(incoterm_tf), max(plaza_incoterm_tf), max(porte_bonny_tf) '); //Observaciones

    SQL.Add('FROM tmp_facturas_l,frf_clientes, ');
    SQL.Add('OUTER frf_paises,frf_impuestos,OUTER frf_provincias  ');
    SQL.Add('WHERE cod_cliente_fac_tf=cliente_c ');
    SQL.Add('  and cod_empresa_tf=empresa_c ');
    SQL.Add('  and usuario_tf=' + quotedStr(gsCodigo) );
    SQL.Add('and pais_fac_c=pais_p ');
    SQL.Add('and cod_iva_tf=codigo_i ');
    SQL.Add('and codigo_p=cod_postal_fac_c[1,2] ');
    SQL.Add('GROUP BY 1,2,3,4,5,6,7,8,9,10, ');
    SQL.Add('         11,12,13,14,15,16,17,18,19,20, ');
    SQL.Add('         21,22,23,24,25,27,28,29 ');


    try
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      CabeceraFactura := false;
      Exit;
    end;

    with DMFacturacion.QCabeceraFactura do
    begin
      if Active then
      begin
        cancel;
        Close;
      end;

      try
        ParamByName('usuario').AsString := gsCodigo;
        AbrirConsulta(DMFacturacion.QCabeceraFactura);
      except
        CabeceraFactura := false;
        Exit;
      end;

      if IsEmpty then
      begin
        ShowError(' No existen facturas para los datos introducidos, o la factura ya ha sido contabilizada. ');
        CabeceraFactura := false;
        Cancel;
        Close;
        Exit;
      end;
      Cancel;
      Close;
    end;
  end;

  //Comisiones y descuentos por producto
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select cod_empresa_tf empresa, cod_producto_tf producto, cod_cliente_fac_tf cliente ');
    SQL.Add(' from tmp_facturas_l, tmp_facturas_c ');
    SQL.Add(' where cod_empresa_tf = :cod_empresa_tfc ');
    SQL.Add(' and factura_tf = :factura_tfc ');
    SQL.Add(' and fecha_tf = :fecha_tfc ');
    SQL.Add(' group by empresa, producto, cliente ');
  end;
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add('select * from tmp_facturas_c ');
    RequestLive:= True;
    Open;
    while not Eof do
    begin
      if QuitarDescuento then
      begin
        Edit;
        FieldByName('comision_tfc').AsFloat:= 0;
        FieldByName('descuento_tfc').AsFloat:= 0;
        Post;
      end;
      Next;
    end;
    RequestLive:= False;
    Close;
  end;

  CabeceraFactura := true;
end;

//Observaciones de la factura
function GetNotaFacturaAux: string;
begin
  result:= '';
  with DMBaseDatos.QTemp do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select nota_factura_sc ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add('   and centro_salida_sc = :centro ');
    SQL.Add('   and n_albaran_sc = :albaran ');
    SQL.Add('   and fecha_sc = :fecha ');
    ParamByName('empresa').AsString:= DMBaseDatos.QAux.FieldByName('cod_empresa_tf').AsString;
    ParamByName('centro').AsString:= DMBaseDatos.QAux.FieldByName('centro_salida_tf').AsString;
    ParamByName('albaran').AsString:= DMBaseDatos.QAux.FieldByName('albaran_tf').AsString;
    ParamByName('fecha').AsString:= DMBaseDatos.QAux.FieldByName('fecha_alb_tf').AsString;
    Open;
    try
      result:= FieldByName('nota_factura_sc').AsString;
    finally
      Close;
    end;
  end;
end;

function GetNotaFactura( const ACliente: string ): string;
begin
  result:= '';
  with DMBaseDatos.QAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select cod_empresa_tf, centro_salida_tf, albaran_tf, fecha_alb_tf ');
    SQL.Add(' from tmp_facturas_l ');
    SQL.Add(' where usuario_tf = :usuario ');
    SQL.Add('   and factura_tf = :factura ');
    SQL.Add('   and fecha_tf = :fecha ');
    SQL.Add(' group by cod_empresa_tf, centro_salida_tf, albaran_tf, fecha_alb_tf ');
    SQL.Add(' order by cod_empresa_tf, centro_salida_tf, albaran_tf, fecha_alb_tf ');
    ParamByName('usuario').AsString:= gsCodigo;
    ParamByName('factura').AsString:= DMBaseDatos.QModificable.FieldByName('factura_tfc').AsString;
    ParamByName('fecha').AsString:= DMBaseDatos.QModificable.FieldByName('fecha_tfc').AsString;
    Open;
    while not Eof do
    begin
      (*
      if ACliente = 'ED' then
      begin
        if result <> '' then
          result:= result + ' /';
        result:= result + Trim(GetNotaFacturaAux);
      end
      else
      *)
      begin
        if result <> '' then
          result:= result + #13 + #10;
        result:= result + GetNotaFacturaAux;
      end;
      Next;
    end;
    Close;
  end;
end;

procedure NotaFactura( const ACliente: string );
var
  sAux: String;
begin
  with DMBaseDatos.QModificable do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select * from tmp_facturas_c ');
    SQL.Add(' where usuario_tfc = :usuario ');
    ParamByName('usuario').AsString:= gsCodigo;
    Open;
    try
      while not EOF do
      begin
        sAux:= GetNotaFactura( ACliente );
        if length( sAux ) > 250 then
          sAux:= copy( sAux, 1, 250 ) + #13 + #10 + '...';

        if Trim( sAux ) <> '' then
        begin
          if CanModify then
          begin
            Edit;
            FieldByName('nota_albaran_tfc').AsString:= sAux;
            Post;
          end;
        end;
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

//Rellenamos tabla temporal gastos
function GastosFactura: boolean;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('INSERT INTO tmp_gastos_fac ');
    SQL.Add('SELECT DISTINCT usuario_tf,factura_tf,albaran_tf,');
    SQL.Add('                fecha_alb_tf,tipo_tg,descripcion_tg,importe_g, ');

    SQL.Add('      case when exists ( select * ');
    SQL.Add('                           from frf_impuestos_recargo_cli ');
    SQL.Add('                           where empresa_irc = cod_empresa_tf ');
    SQL.Add('                           and cliente_irc = cod_cliente_fac_tf ');
    SQL.Add('                           and fecha_g  between fecha_ini_irc and case when fecha_fin_irc is null then fecha_g else fecha_fin_irc end ) ');

    SQL.Add('             then ( select case when tipo_iva_tg = 0 then super_il  +  recargo_super_il ');
    SQL.Add('                                when tipo_iva_tg = 1 then reducido_il + recargo_reducido_il ');
    SQL.Add('                                when tipo_iva_tg = 2 then general_il + recargo_general_il ');
    SQL.Add('                                else 0 ');
    SQL.Add('                           end ');
    SQL.Add('                    from frf_impuestos_l ');
    SQL.Add('                    where codigo_il= cod_iva_tf ');
    SQL.Add('                    and fecha_g  between fecha_ini_il and case when fecha_fin_il is null then fecha_g else fecha_fin_il end ) ');

    SQL.Add('             else ( select case when tipo_iva_tg = 0 then super_il ');
    SQL.Add('                                when tipo_iva_tg = 1 then reducido_il ');
    SQL.Add('                                when tipo_iva_tg = 2 then general_il ');
    SQL.Add('                                else 0 ');
    SQL.Add('                           end ');
    SQL.Add('                    from frf_impuestos_l ');
    SQL.Add('                    where codigo_il= cod_iva_tf ');
    SQL.Add('                    and fecha_g  between fecha_ini_il and case when fecha_fin_il is null then fecha_g else fecha_fin_il end ) ');
    SQL.Add('        end porcentaje_iva');

    SQL.Add('FROM tmp_facturas_l, frf_gastos, frf_tipo_gastos ');
    SQL.Add('WHERE cod_empresa_tf=empresa_g ');
    SQL.Add('AND centro_salida_tf=centro_salida_g ');
    SQL.Add('AND albaran_tf=n_albaran_g   ');
    SQL.Add('AND fecha_alb_tf=fecha_g ');
    SQL.Add('AND tipo_g=tipo_tg ');
    SQL.Add('AND facturable_tg="S" ');
    SQL.Add('   and (usuario_tf=' + quotedStr(gsCodigo) + ') ');

    try
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      GastosFactura := false;
      Exit;
    end;

    SQL.Clear;
    SQL.Add('UPDATE tmp_facturas_c ');
    SQL.Add('SET ');
    SQL.Add('gasto_total_tfc=(SELECT sum(importe_tg) ');
    SQL.Add('FROM   tmp_gastos_fac ');
    SQL.Add('WHERE  usuario_tg=usuario_tfc ');
    SQL.Add('AND  factura_tg=factura_tfc) ');

    try
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      GastosFactura := false;
      Exit;
    end;


  end;
  GastosFactura := true;
end;

procedure PreparaRepeticion(empresa, desde, hasta, fechadesde,
  fechahasta, pais, cliente: string;
  contabilizado: boolean);
begin
  repeticionFlag := true;
     //Rellenamos tabla temporal Lines
  Limpiar;
  if not LineasRepeticion(empresa, desde, hasta, fechadesde,
    fechahasta, pais, cliente, contabilizado) then
  begin
    Limpiar;
    raise Exception.Create('Imposible obtener datos para la facturacion');
  end;
     //Rellenamos tabla temporal cabecera
  if not CabeceraFactura then
  begin
    Limpiar;
    raise Exception.Create('Imposible obtener datos para la facturacion');
  end;

    //Observaciones de la factura
  NotaFactura( cliente );

     //Rellenamos tabla temporal gastos
  if not GastosFactura then
  begin
    Limpiar;
    raise Exception.Create('Imposible obtener datos para la facturacion');
  end;
end;

procedure PreparaFacturacion( const ACliente, AFecha: string);
begin
  repeticionFlag := false;

    //Rellenamos tabla temporal cabecera
  if not CabeceraFactura then
  begin
    Limpiar;
    raise Exception.Create('Imposible obtener datos para la facturacion');
  end;

    //Observaciones de la factura
  NotaFactura( ACliente );

    //Rellenamos tabla temporal gastos
  if not GastosFactura then
  begin
    Limpiar;
    raise Exception.Create('Imposible obtener datos para la facturacion');
  end;
end;

procedure Limpiar;
begin
     //Cerrar todos ls datastes abiertos
     //if gsCodigo <> 'PRUEBA' then
     //DMBaseDatos.DBBaseDatos.CloseDataSets;

     //Borrar contenido tablas temporales
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('DELETE FROM tmp_facturas_l ');
          //Mientras sólo pueda facturar borrar todas las entradas
          //SQL.Add('WHERE usuario_tf = '+quotedstr(gsCodigo));

    EjecutarConsulta(DMBaseDatos.QGeneral);

    SQL.Clear;
    SQL.Add('DELETE FROM tmp_facturas_c ');
          //Mientras sólo pueda facturar borrar todas las entradas
          //SQL.Add('WHERE usuario_tfc = '+quotedstr(gsCodigo));

    EjecutarConsulta(DMBaseDatos.QGeneral);

    SQL.Clear;
    SQL.Add('DELETE FROM tmp_gastos_fac ');
          //Mientras sólo pueda facturar borrar todas las entradas
          //SQL.Add('WHERE usuario_tg = '+quotedstr(gsCodigo));

    EjecutarConsulta(DMBaseDatos.QGeneral);
    SQL.Clear;
  end;
end;

function EstaContabilizada(empresa, factura, fecha: string): boolean;
begin
  with DMAuxDB.QAux do begin
    ConsultaOpen(DMAuxDB.QAux, ' select contabilizado_f from frf_facturas ' +
      ' where empresa_f=' + QuotedStr(empresa) + ' ' +
      ' and n_factura_f=' + factura + ' ' +
      ' and fecha_factura_f=' + QuotedStr(fecha) + ' ', False, False);
    EstaContabilizada := DMAuxDB.QAux.Fields[0].AsString = 'S';
    DMAuxDB.QAux.Cancel;
    DMAuxDB.QAux.Close;
  end;
end;

function PuedoFacturar(const AQuien: string; var VMsg: string ): boolean;
begin
  VMsg := '';
  with DMBaseDatos.QGeneral do
  begin
    Tag := kNull;
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(' select usuario_cu, descripcion_cu ' +
      ' from   cnf_usuarios,cnf_facturacion ' +
      ' where  facturando_cg IS NOT NULL' +
      ' and facturando_cg=usuario_cu ');
    try
      Open;
      if isEmpty then
      begin
        Close;
        PuedoFacturar := true;
        Exit;
      end;


      if AQuien = FieldByName('usuario_cu').AsString then
      begin
        Close;
        SQL.Clear;
        SQL.Add(' update cnf_facturacion ' +
          ' set facturando_cg=NULL ' +
          ' where facturando_cg="' + AQuien + '"');
        ExecSql;
        PuedoFacturar := true;
        Exit;
      end;
      VMsg := FieldByName('descripcion_cu').AsString;
      Close;
      PuedoFacturar := false;
    except
      VMsg := 'Error';
      PuedoFacturar := false;
    end;
  end;
end;

function QuieroFacturar(const AQuien: string; var VMsg: string): boolean;
begin
  with DMBaseDatos.QGeneral do
  begin
    Tag := kNull;
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(' update cnf_facturacion ' +
      ' set facturando_cg="' + AQuien + '"' +
      ' where NVL(facturando_cg,"") = ""');
    try
      ExecSQL;
      if RowsAffected <> 1 then
      begin
        SQL.Clear;
        SQL.Add(' select usuario_cu,descripcion_cu ' +
          ' from   cnf_usuarios,cnf_facturacion ' +
          ' where  facturando_cg IS NOT NULL' +
          ' and facturando_cg=usuario_cu ');
        Open;
        VMsg := FieldByName('descripcion_cu').AsString;
        QuieroFacturar := false;
        Exit;
      end;
      QuieroFacturar := true;
      Exit;
    except
      VMsg := 'Error';
      QuieroFacturar := false;
    end;
  end;
end;

procedure AcaboFacturar(const AQuien: string );
begin
  with DMBaseDatos.QGeneral do
  begin
    Tag := kNull;
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(' update cnf_facturacion ' +
      ' set facturando_cg=NULL' +
      ' where facturando_cg="' + AQuien + '"');
    ExecSQL;
  end;
end;


procedure BorrarTablasTemporales;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(' DROP TABLE tmp_facturas_c ');
    ExecSQL;
    SQL.Clear;
    SQL.Add(' DROP TABLE tmp_facturas_l ');
    ExecSQL;
    SQL.Clear;
    SQL.Add(' DROP TABLE tmp_gastos_fac ' +
      ' ) ');
    ExecSQL;
  end;
end;


end.
