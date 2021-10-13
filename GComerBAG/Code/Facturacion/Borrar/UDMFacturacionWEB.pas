unit UDMFacturacionWEB;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMFacturacionWEB = class(TDataModule)
    QGeneral: TQuery;
    QTemp: TQuery;
    QAux: TQuery;
    QAux2: TQuery;
    QModificable: TQuery;
  private
    { Private declarations }

    procedure Limpiar;
    function  RellenaTabla: boolean;
    function  AcaboFacturar(var Quien: string): boolean;
    function  CanFacturarFecha(const AEmpresa: string; ADate: TDateTime): Boolean;
    function  ComprobarCuentas: Boolean;
    function  NumeraFacturas: integer;
    procedure PreparaFacturacion(const dFecha: TDateTime );
    function  RellenaFacturas: Boolean;
    procedure Previsualizar;
    procedure ComprobarRiesgoCliente( const AEmpresa, ACliente: string );
    procedure DescripcionMarca;
    function  FacturarPor(const empresa, cliente: string): integer;
    function  CabeceraFactura: boolean;
    procedure NotaFactura;
    function  GetNotaFactura: string;
    function  GetNotaFacturaAux: string;
    function  GastosFactura: boolean;
    function   GetNumeroFactura(empresa, tipo: string; fecha: TDateTime; var AMsg: string): integer;

  public
    { Public declarations }
    sEmpresa, sCentro, sCliente, sPedido: string;
    iALbaranDesde, iAlbaranHasta: integer;
    dFechaAlbaran, dFechaFactura: TDateTime;
    bInformativa, bCopiaCliente, bCopiaEmpresa, bValidarRiesgo: boolean;

    procedure Facturar;

  end;

  procedure FacturacionWEB( const AEmpresa, ACentro, ACliente, AALbaranDesde, AAlbaranHasta, AFechaAlbaran, AFechaFactura, APedido: string;
                            const AInformativa, ACopiaCliente, ACopiaEmpresa, AValidarRiesgo: boolean );


implementation

{$R *.dfm}

uses
  CVariables, UDMFacturacion, LFacturas, UDMConfig, bTimeUtils, bDialogs, CAuxiliarDB,
  UDMBaseDatos;

var
  DMFacturacionWEB: TDMFacturacionWEB;


procedure FacturacionWEB( const AEmpresa, ACentro, ACliente, AALbaranDesde, AAlbaranHasta, AFechaAlbaran, AFechaFactura, APedido: string;
                          const AInformativa, ACopiaCliente, ACopiaEmpresa, AValidarRiesgo: boolean );
begin
  DMFacturacionWEB:= TDMFacturacionWEB.Create( nil );
  try
    DMFacturacionWEB.sEmpresa:= AEmpresa;
    DMFacturacionWEB.sCentro:= ACentro;
    DMFacturacionWEB.sCliente:= ACliente;
    DMFacturacionWEB.sPedido:= APedido;
    DMFacturacionWEB.iALbaranDesde:= StrToInt( AALbaranDesde );
    DMFacturacionWEB.iAlbaranHasta:= StrToInt( AFechaAlbaran );
    DMFacturacionWEB.dFechaAlbaran:= StrToDateTime( AFechaAlbaran );
    DMFacturacionWEB.dFechaFactura:= StrToDateTime( AFechaFactura );

    DMFacturacionWEB.bInformativa:= AInformativa;
    DMFacturacionWEB.bCopiaCliente:= ACopiaCliente;
    DMFacturacionWEB.bCopiaEmpresa:= ACopiaEmpresa;
    DMFacturacionWEB.bValidarRiesgo:= AValidarRiesgo;
    DMFacturacionWEB.Facturar;
  finally
    FreeAndNil( DMFacturacionWEB );
  end;
end;

procedure TDMFacturacionWEB.Limpiar;
begin
  with QGeneral do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE FROM tmp_facturas_l ');
    QGeneral.ExecSQL;

    SQL.Clear;
    SQL.Add('DELETE FROM tmp_facturas_c ');
    QGeneral.ExecSQL;

    SQL.Clear;
    SQL.Add('DELETE FROM tmp_gastos_fac ');
    SQL.Add('WHERE usuario_tg = ' + quotedstr(gsCodigo));
    QGeneral.ExecSQL;
  end;

  //Cerrar todos ls datastes abiertos
  QAux.Close;
  QTemp.Close;
  DMFacturacion.QCabeceraFactura.Close;
end;

procedure TDMFacturacionWEB.Facturar;
var
  ant: string;
  usuario: string;
begin
  usuario := gsCodigo;

  //Rellenamos tabla temporal lineas
  if not RellenaTabla then
  begin
    Limpiar;
    AcaboFacturar(usuario);
    Exit;
  end;

  if not CanFacturarFecha( sEmpresa, dFechaFactura ) then
  begin
    Limpiar;
    AcaboFacturar(usuario);
    Exit;
  end;

     //Comprobar que los clientes tienen las cuentas de venta/ingresos???
  if not ComprobarCuentas then
  begin
    Limpiar;
    AcaboFacturar(usuario);
    Exit;
  end;

     //Separacion en facturas
  if NumeraFacturas = 0 then
  begin
    Limpiar;
    AcaboFacturar(usuario);
    Exit;
  end;

  QGeneral.Cancel;
  QGeneral.Close;
  QGeneral.RequestLive := false;

  PreparaFacturacion( dFechaFactura );

     //Facturacion Normal
  if not bInformativa then
  begin
    (*PEPE*)
    //Poner tabla empresas en escritura
    (*
    if TEmpresa.ReadOnly = true then
    begin
      TEmpresa.Close;
      TEmpresa.ReadOnly := false;
      try
        AbrirConsulta(TEmpresa);
      except
        Limpiar;
        AcaboFacturar(usuario);
        Exit;
      end;
    end;
    *)
          //Rellenamos cabecera factura
          //Actualizamos factura
          //Actualizamos contador,fecha facturacion empresa
    ant := DMFacturacion.QCabeceraFactura.SQL.Text;
    if not RellenaFacturas then
    begin
      Limpiar;
      AcaboFacturar(usuario);

      QGeneral.Close;
      DMFacturacion.QCabeceraFactura.Cancel;
      DMFacturacion.QCabeceraFactura.Close;
      DMFacturacion.QCabeceraFactura.RequestLive := false;
      DMFacturacion.QCabeceraFactura.SQL.clear;
      DMFacturacion.QCabeceraFactura.SQL.add(ant);

      Exit;
    end;
    QGeneral.Close;
    DMFacturacion.QCabeceraFactura.Cancel;
    DMFacturacion.QCabeceraFactura.Close;
    DMFacturacion.QCabeceraFactura.RequestLive := false;
    DMFacturacion.QCabeceraFactura.SQL.clear;
    DMFacturacion.QCabeceraFactura.SQL.add(ant);
  end;

  Previsualizar;

  if bValidarRiesgo and ( not bInformativa ) then
  begin
    ComprobarRiesgoCliente( sEmpresa, sCliente );
  end;
end;

function TDMFacturacionWEB.RellenaTabla: boolean;
begin
     //LINEAS
  with QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('INSERT INTO tmp_facturas_l ');
    SQL.Add('    ( factura_tf,fecha_tf,usuario_tf,cod_empresa_tf,cod_procede_tf,');
    SQL.Add('      cod_cliente_sal_tf,cod_cliente_fac_tf,impuesto_tf,');
    SQL.Add('      pedido_tf,vehiculo_tf,albaran_tf,fecha_alb_tf,centro_salida_tf,');
    SQL.Add('      cod_pais_tf,moneda_tf,cod_dir_sum_tf,cod_producto_tf,');
    SQL.Add('      cod_envase_tf,producto_tf,producto2_tf,envase_tf,descripcion2_e,');
    SQL.Add('      cajas_tf,unidades_caja_tf,kilos_tf,unidades_tf,');
    SQL.Add('      unidad_medida_tf,precio_unidad_tf,precio_neto_tf,cod_iva_tf,');
    (*IVA*)
    SQL.Add('      tipo_iva_tf,iva_tf, importe_total_tf, ');

    SQL.Add('      envase_comer_tf,categoria_tf,'); //
    SQL.Add('      calibre_tf,marca_tf,nom_marca_tf )');
    SQL.Add('SELECT 0,' + QuotedStr(DateTimeToStr(dFechaFactura)) + ',' + quotedStr(gsCodigo) + ', ');
    SQL.Add('Frf_salidas_c.empresa_sc,Frf_salidas_l.emp_procedencia_sl,Frf_salidas_c.cliente_sal_sc,');
    SQL.Add('Frf_salidas_c.cliente_fac_sc,Frf_salidas_l.tipo_iva_sl[1,1], ');
    SQL.Add('Frf_salidas_c.n_pedido_sc,Frf_salidas_c.vehiculo_sc,Frf_salidas_c.n_albaran_sc, ');
    SQL.Add('Frf_salidas_c.fecha_sc,Frf_salidas_c.centro_salida_sc, ');
    SQL.Add('Frf_clientes.pais_fac_c,Frf_salidas_c.moneda_sc,');
    SQL.Add('Frf_salidas_c.dir_sum_sc, ');
    SQL.Add('Frf_salidas_l.producto_sl,Frf_salidas_l.envase_sl, ');
    SQL.Add('Frf_productos.descripcion_p descripcion_prod, ');
    SQL.Add('Frf_productos.descripcion2_p descripcion_prod2, ');
    SQL.Add('Frf_envases.descripcion_e,Frf_envases.descripcion2_e,');
    SQL.Add('Frf_salidas_l.cajas_sl, ');
    SQL.Add('Frf_envases.unidades_e,Frf_salidas_l.kilos_sl, ');
    SQL.Add('(Frf_salidas_l.cajas_sl*Frf_envases.unidades_e) as unidades, ');
    SQL.Add('Frf_salidas_l.unidad_precio_sl,Frf_salidas_l.precio_sl, ');
    SQL.Add('Frf_salidas_l.importe_neto_sl,Frf_salidas_l.tipo_iva_sl, ');

    (*IVA*)
    SQL.Add('Frf_salidas_l.porc_iva_sl,Frf_salidas_l.iva_sl,Frf_salidas_l.importe_total_sl, ');

    SQL.Add('Frf_envases.envase_comercial_e, Frf_Salidas_l.categoria_sl,');
    SQL.Add('Frf_Salidas_l.calibre_sl,');
    SQL.Add('Frf_Salidas_l.marca_sl,"MARCA" ');
    SQL.Add('FROM ');
    SQL.Add('     frf_salidas_c Frf_salidas_c, ');
    SQL.Add('     frf_salidas_l Frf_salidas_l, ');
    SQL.Add('     frf_clientes Frf_clientes, ');
    SQL.Add('     frf_productos Frf_productos, ');
    SQL.Add('     frf_envases Frf_envases ');


    SQL.Add('WHERE  (empresa_sc = :empresa) ');
    SQL.Add('AND  (cliente_fac_sc = :cliente) ');
    SQL.Add('AND  (n_albaran_sc BETWEEN :ini AND :fin) ');
    SQL.Add('AND  (fecha_sc <= :fecha) ');

    SQL.Add('AND  (n_factura_sc IS NULL) ');
    SQL.Add('AND  (cliente_sal_sc <> "RET") ');
    SQL.Add('AND  (cliente_sal_sc <> "REA") ');
    SQL.Add('AND  (cliente_sal_sc <> "0BO") ');
    SQL.Add('AND  (cliente_sal_sc <> "EG") ');
    if Trim(sPedido) <> '' then
      SQL.Add('AND  (n_pedido_sc = :pedido) ');

    if Trim( sCentro ) <> '' then
      SQL.Add('AND  (centro_salida_sc = :centro) ');

    SQL.Add('AND  (empresa_sl = :empresa) ');
    SQL.Add('AND  (centro_salida_sl = centro_salida_sc) ');
    SQL.Add('AND  (n_albaran_sl = n_albaran_sc) ');
    SQL.Add('AND  (fecha_sl = fecha_sc) ');

    SQL.Add('AND  (empresa_c = :empresa) ');
    SQL.Add('AND  (cliente_c = cliente_fac_sc) ');

    SQL.Add('AND  (empresa_p = :empresa) ');
    SQL.Add('AND  (producto_p = producto_sl) ');

    SQL.Add('AND  (empresa_e = :empresa) ');
    SQL.Add('AND  (envase_e = envase_sl) ');
    SQL.Add('and  (producto_base_e = producto_base_p )');

          //PARAMETROS
    ParamByName('cliente').AsString := sCliente;
    ParamByName('ini').AsInteger := iALbaranDesde;
    ParamByName('fin').AsInteger := iAlbaranHasta;
    ParamByName('fecha').AsDate := dFechaAlbaran;
    ParamByName('empresa').AsString := sEmpresa;
    if Trim(sPedido) <> '' then
      ParamByName('pedido').AsString := sPedido;
    if Trim(sCentro) <> '' then
      ParamByName('centro').AsString := sCentro;

    try
      ExecSQL;
      if RowsAffected = 0 then
      begin
        Advertir('No existen albaranes por facturar que cumplan el criterio seleccionado.');
        RellenaTabla := false;
        Exit;
      end;
    except
      RellenaTabla := false;
      Exit;
    end;
  end;
  RellenaTabla := true;
  DescripcionMarca;
end;

function TDMFacturacionWEB.AcaboFacturar(var Quien: string): boolean;
begin
  with QGeneral do
  begin
    Tag := kNull;
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(' update cnf_facturacion ' +
      ' set facturando_cg=NULL' +
      ' where facturando_cg="' + Quien + '"');
    try
      ExecSQL;
      AcaboFacturar := true;
      Exit;
    except
      Quien := 'Error';
      AcaboFacturar := false;
    end;
  end;
end;

function TDMFacturacionWEB.CanFacturarFecha(const AEmpresa: string; ADate: TDateTime): Boolean;
begin
  Result := true;
  with QTemp do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(' SELECT UNIQUE cod_iva_tf FROM tmp_facturas_l ' +
      ' WHERE cod_empresa_tf = :empresa ' +
      ' ORDER BY cod_iva_tf DESC ');
    ParamByName('empresa').AsString := AEmpresa;
    Open;
    while not EOF do
    begin
     //IVA
      if Copy(FieldByName('cod_iva_tf').AsString, 1, 1) = 'I' then
      begin
        QAux.SQL.Clear;
        QAux.SQL.Add(' SELECT fecha_ult_fac_e ' +
          ' FROM frf_empresas ' +
          ' WHERE empresa_e = :empresa ');
        QAux.ParamByName('empresa').AsString := AEmpresa;
        QAux.Open;
        if QAux.FieldByName('fecha_ult_fac_e').AsDateTime > ADate then
        begin
          Advertir('La fecha de facturación es incorrecta para la serie de IVA.');
          QAux.Close;
          Result := false;
          break;
        end;
      end
      else
        if Copy(FieldByName('cod_iva_tf').AsString, 1, 1) = 'G' then
        begin
          QAux.SQL.Clear;
          QAux.SQL.Add(' SELECT fecha_ult_fac2_e ' +
            ' FROM frf_empresas ' +
            ' WHERE empresa_e = :empresa ');
          QAux.ParamByName('empresa').AsString := AEmpresa;
          QAux.Open;
          if QAux.FieldByName('fecha_ult_fac2_e').AsDateTime > ADate then
          begin
            Advertir('La fecha de facturación es incorrecta para la serie de IGIC.');
            QAux.Close;
            Result := false;
            break;
          end;
        end;
      QAux.Close;
      Next;
    end;
    Close;
  end;
end;

function TDMFacturacionWEB.ComprobarCuentas: Boolean;
var
  aux: string;
  borrados, totales: integer;
begin
  totales := 0;
  borrados := 0;
    if QGeneral.Active then
    begin
      QGeneral.Cancel;
      QGeneral.Close;
    end;

    QGeneral.SQL.Clear;
    QGeneral.SQL.Add(' SELECT DISTINCT cod_empresa_tf, cod_cliente_fac_tf, ');
    QGeneral.SQL.Add('        cta_cliente_c, cta_ingresos_pgc_c ');
    //QGeneral.SQL.Add('        representante_c, cta_cliente_c, cta_ingresos_pgc_c ');
    QGeneral.SQL.Add(' FROM   tmp_facturas_l, frf_clientes ');
    QGeneral.SQL.Add(' WHERE  usuario_tf = ' + QuotedStr(gsCodigo));
    QGeneral.SQL.Add('   AND  cod_empresa_tf = empresa_c ');
    QGeneral.SQL.Add('   AND  cod_cliente_fac_tf = cliente_c ');
    QGeneral.Open;

    QGeneral.First;
    while not QGeneral.Eof do
    begin
      if (* ( QGeneral.fieldbyname('representante_c').AsString = '' ) or *)
        (QGeneral.fieldbyname('cta_cliente_c').AsString = '') or
        (QGeneral.fieldbyname('cta_ingresos_pgc_c').AsString = '') then
      begin
        aux := '';
        (*if ( QGeneral.fieldbyname('representante_c').AsString = '' ) then
        begin
          aux:= '  * Falta el representante del cliente. (Si no tiene seleccione "SIN REPRESENTANTE")' + #13 + #10;
        end;*)

        if (QGeneral.fieldbyname('cta_cliente_c').AsString = '') then
        begin
          aux := aux + '  * Falta la cuenta del cliente. ' + #13 + #10;
        end;

        if (QGeneral.fieldbyname('cta_ingresos_pgc_c').AsString = '') then
        begin
          aux := aux + '  * Falta la cuenta de ingresos del cliente. ' + #13 + #10;
        end;

        Advertir(' No se puede facturar al cliente "' +
          QGeneral.fieldbyname('cod_cliente_fac_tf').AsString +
          '"' + #13 + #10 + aux +
          ' CONSULTE CON EL DEPARTAMENTO DE CONTABILIDAD.');

        QAux.SQL.Clear;
        QAux.SQL.Add('DELETE FROM tmp_facturas_l ');
        QAux.SQL.Add('WHERE usuario_tf = ' + QuotedStr(gsCodigo));
        QAux.SQL.Add('  AND cod_cliente_fac_tf = ' +
          QuotedStr(QGeneral.fieldbyname('cod_cliente_fac_tf').AsString));
        QAux.ExecSQL;

        Inc(borrados);
      end;

      //Siguiente registro
      QGeneral.Next;
      Inc(totales)
    end;

    QGeneral.Close;
    Result := borrados <> totales;
end;

function TDMFacturacionWEB.NumeraFacturas: integer;
var
  cliente, pedido, albaran: string;
  error: boolean;
  moneda, impuesto: string;
  clientesBorrar: TStringList;
  cont: integer;
  contador: integer;
begin
  clientesBorrar := TStringList.Create;
  with QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    RequestLive := true;
    SQL.Clear;
    SQL.Add(' SELECT usuario_tf, cod_empresa_tf, cod_cliente_fac_tf, moneda_tf, impuesto_tf, ');
    SQL.Add('        fecha_alb_tf, pedido_tf, vehiculo_tf, albaran_tf, factura_tf');
    SQL.Add(' FROM tmp_facturas_l ');
    SQL.Add(' ORDER BY  1,2,3,4,5,6,7,8,9 ');

    try
      QGeneral.Active := true;
    except
      on e: EDBEngineError do
      begin
        Advertir(e.Message);
        NumeraFacturas := 0;
        Exit;
      end;
    end;

    if IsEmpty then
    begin
      Advertir('No hay facturas a realizar para los datos introducidos');
      NumeraFacturas := 0;
      Exit;
    end;

    contador := 1;
    while not Eof do
    begin
      case FacturarPor(FieldByName('cod_empresa_tf').AsString, FieldByName('cod_cliente_fac_tf').AsString) of
        0:
          begin
                    //UNA FACTURA PARA TODOS LOS ALBARANES PENDIENTES
            error := false;
            cliente := FieldByName('cod_cliente_fac_tf').AsString;
            moneda := FieldByName('moneda_tf').AsString;
            impuesto := FieldByName('impuesto_tf').AsString;
            repeat
              if not error then
              begin
                if (moneda <> FieldByName('moneda_tf').AsString) and
                  (cliente = FieldByName('cod_cliente_fac_tf').AsString) then
                begin
                  Error := true;
                  clientesBorrar.Add(FieldByName('cod_cliente_fac_tf').AsString);
                  Advertir('No se puede facturar al cliente "' +
                    FieldByName('cod_cliente_fac_tf').AsString +
                    '" por tener albaranes en distintas monedas.');
                end
                else
                begin
                  edit;
                  FieldByName('factura_tf').AsInteger := contador;
                  post;
                end;
              end;
              Next;
            until (cliente <> FieldByName('cod_cliente_fac_tf').AsString) or
              (impuesto <> FieldByName('impuesto_tf').AsString) or
              EOF;
          end;
        1:
          begin
                    //OTROS UNA FACTURA POR ALBARAN
            cliente := FieldByName('cod_cliente_fac_tf').AsString;
            pedido := FieldByName('pedido_tf').AsString;
            albaran := FieldByName('albaran_tf').AsString;
            repeat
              edit;
              FieldByName('factura_tf').AsInteger := contador;
              post;
              Next;
            until (cliente <> FieldByName('cod_cliente_fac_tf').AsString) or
              (pedido <> FieldByName('pedido_tf').AsString) or
              (albaran <> FieldByName('albaran_tf').AsString) or EOF;
          end;
        2:
          begin
                //OTROS UNA FACTURA POR PEDIDO
                //POR PEDIDO, VEHICULO O AMBOS
            cliente := FieldByName('cod_cliente_fac_tf').AsString;
            pedido := FieldByName('pedido_tf').AsString;
            repeat
              edit;
              FieldByName('factura_tf').AsInteger := contador;
              post;
              Next;
            until (cliente <> FieldByName('cod_cliente_fac_tf').AsString) or
              (pedido <> FieldByName('pedido_tf').AsString) or EOF;
          end;
      end;
      contador := contador + 1;
    end;

          //Borrar erroneos
    if clientesBorrar.Count > 0 then
    begin
      SQL.Clear;
      SQL.Add('DELETE FROM tmp_facturas_l ');
      SQL.Add('WHERE usuario_tf = ' + quotedstr(gsCodigo));
      SQL.Add(' AND (cod_cliente_fac_tf = ' + quotedstr(clientesBorrar.Strings[0]));
      for cont := 1 to clientesBorrar.Count - 1 do
        SQL.Add(' OR cod_cliente_fac_tf = ' + quotedstr(clientesBorrar.Strings[cont]));
      SQL.Add(')');

      try
        QGeneral.Open;
      except
        NumeraFacturas := 0;
        Exit;
      end;
    end;
    NumeraFacturas := contador;
  end;

  FreeAndNil( clientesBorrar );
end;

function TDMFacturacionWEB.CabeceraFactura: boolean;
begin
     //CABECERA
  with QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('INSERT INTO tmp_facturas_c ');
    SQL.Add('SELECT factura_tf,usuario_tf, fecha_tf, ');
    SQL.Add('cod_empresa_tf,cod_cliente_fac_tf,cod_cliente_fac_tf, ');
    SQL.Add('nombre_c,tipo_via_fac_c, ');
    SQL.Add('domicilio_fac_c,poblacion_fac_c, ');
    SQL.Add('cod_postal_fac_c, nombre_p, ');
    SQL.Add('descripcion_p,nif_c, ');
    SQL.Add(' GetComisionCliente( cod_empresa_tf, cod_cliente_fac_tf, fecha_tf ) comision_r, ');
    SQL.Add(' GetDescuentoCliente( cod_empresa_tf, cod_cliente_fac_tf, fecha_tf, 1 ) porc_dto_c, ');
    SQL.Add('cod_iva_tf,porcentaje_i, ');
    SQL.Add('tipo_i,descripcion_i, ');
    SQL.Add('moneda_tf,cta_cliente_c, ');
    SQL.Add('forma_pago_c, ');
    SQL.Add('"380","A", '); //Tipo y concepto
    if repeticionFlag then
      SQL.Add('SUM(precio_neto_tf),0,factura_tf, ') //importe neto,gastos y num factura final
    else
      SQL.Add('SUM(precio_neto_tf),0,0, '); //importe neto,gastos y num factura final
    SQL.Add('""'); //Observaciones

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
      QGeneral.Open;
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
        DMFacturacion.QCabeceraFactura.Open;
      except
        CabeceraFactura := false;
        Exit;
      end;

      if IsEmpty then
      begin
        Advertir(' No existen facturas para los datos introducidos, o la factura ya ha sido contabilizada. ');
        CabeceraFactura := false;
        Cancel;
        Close;
        Exit;
      end;
      Cancel;
      Close;
    end;
  end;
  CabeceraFactura := true;
end;

function TDMFacturacionWEB.GetNotaFacturaAux: string;
begin
  result:= '';
  with QTemp do
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
    ParamByName('empresa').AsString:= QAux.FieldByName('cod_empresa_tf').AsString;
    ParamByName('centro').AsString:= QAux.FieldByName('centro_salida_tf').AsString;
    ParamByName('albaran').AsString:= QAux.FieldByName('albaran_tf').AsString;
    ParamByName('fecha').AsString:= QAux.FieldByName('fecha_alb_tf').AsString;
    Open;
    (*
    showMessage( DMBaseDatos.QAux.FieldByName('cod_empresa_tf').AsString + ' ' +
                 DMBaseDatos.QAux.FieldByName('cod_procede_tf').AsString + ' ' +
                 DMBaseDatos.QAux.FieldByName('albaran_tf').AsString + ' ' +
                 DMBaseDatos.QAux.FieldByName('fecha_alb_tf').AsString + ' ' +
                 FieldByName('nota_factura_sc').AsString );
    *)
    result:= FieldByName('nota_factura_sc').AsString;
    Close;
  end;
end;

function TDMFacturacionWEB.GetNotaFactura: string;
begin
  result:= '';
  with QAux do
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
    ParamByName('factura').AsString:= QModificable.FieldByName('factura_tfc').AsString;
    ParamByName('fecha').AsString:= QModificable.FieldByName('fecha_tfc').AsString;
    Open;
    while not Eof do
    begin
      if result <> '' then
        result:= result + #13 + #10;
      result:= result + GetNotaFacturaAux;
      Next;
    end;
    Close;
  end;
end;

procedure TDMFacturacionWEB.NotaFactura;
var
  sAux: String;
begin
  with QModificable do
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
        sAux:= GetNotaFactura;
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

function TDMFacturacionWEB.GastosFactura: boolean;
begin
  with QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('INSERT INTO tmp_gastos_fac ');
    SQL.Add('SELECT DISTINCT usuario_tf,factura_tf,albaran_tf,');
    SQL.Add('                fecha_alb_tf,tipo_tg,descripcion_tg,importe_g ');
    SQL.Add('FROM tmp_facturas_l,frf_gastos,frf_tipo_gastos ');
    SQL.Add('WHERE cod_empresa_tf=empresa_g ');
    SQL.Add('AND centro_salida_tf=centro_salida_g ');
    SQL.Add('AND albaran_tf=n_albaran_g   ');
    SQL.Add('AND fecha_alb_tf=fecha_g ');
    SQL.Add('AND tipo_g=tipo_tg ');
    SQL.Add('AND facturable_tg="S" ');
    SQL.Add('   and (usuario_tf=' + quotedStr(gsCodigo) + ') ');

    try
      ExecSQL;
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
      ExecSQL;
    except
      GastosFactura := false;
      Exit;
    end;


  end;
  GastosFactura := true;
end;

procedure TDMFacturacionWEB.PreparaFacturacion( const dFecha: TDateTime );
begin
  repeticionFlag := false;

    //Rellenamos tabla temporal cabecera
  if not CabeceraFactura then
  begin
    Limpiar;
    raise Exception.Create('Imposible obtener datos para la facturacion');
  end;

    //Observaciones de la factura
  NotaFactura;

    //Rellenamos tabla temporal gastos
  if not GastosFactura then
  begin
    Limpiar;
    raise Exception.Create('Imposible obtener datos para la facturacion');
  end;
end;

function TDMFacturacionWEB.GetNumeroFactura(empresa, tipo: string; fecha: TDateTime; var AMsg: string): integer;
var campoFac, campoFec: string;
begin
  AMsg:= ' Error al actualizar número de factura. ';
  if tipo = 'IVA' then
  begin
    campoFac := 'cont_facturas_e';
    campoFec := 'fecha_ult_fac_e';
  end
  else
  begin
    campoFac := 'cont_facturas2_e';
    campoFec := 'fecha_ult_fac2_e';
  end;

  with TEmpresa do
  begin
    if FindKey([empresa]) then
    begin
      if PrimeraVez then
      begin
        if (Trim(FieldByName(campoFec).AsString) = '') or
          (fecha > FieldByName(campoFec).AsDateTime) then
        begin
          try
            Edit;
            FieldByName(campoFec).AsDateTime := fecha;
            Post;
          except
            result := -1;
            Exit;
          end;
        end;
      end
      else
      begin
        PrimeraVez := false;
      end;
      try
        Edit;
        FieldByName(campoFac).AsInteger :=
          FieldByName(campoFac).AsInteger + 1;
        Post;
      except
        result := -1;
        Exit;
      end;
      result := ComprobrarClavePrimaria(empresa, FieldByName(campoFac).AsInteger, fecha);
      if result = -1 then
      begin
        AMsg:= ' Número factura "'+ FieldByName(campoFac).AsString +'" duplicado en el año. ';
      end;
    end
    else
    begin
      result := -1;
      Exit;
    end;
  end;
end;

function TDMFacturacionWEB.RellenaFacturas: Boolean;
var
  RImportesCabecera: TRImportesCabecera;
  FacturaNumero: Integer;
  Facturas, insertadas: Integer;
  Error: boolean;
  sAux: string;
  primeraVez: boolean;
begin
  PrimeraVez := true;
  Error := false;
  insertadas := 0;
  FacturaNumero := -1;
     //ABRIR TABLAS GUIAS
  with DMFacturacion do
  begin
    if DMFacturacion.QBuscaSalida.Active then
    begin
      DMFacturacion.QBuscaSalida.Cancel;
      DMFacturacion.QBuscaSalida.Close;
    end;
    if DMFacturacion.QCabeceraFactura.Active then
    begin
      DMFacturacion.QCabeceraFactura.Cancel;
      DMFacturacion.QCabeceraFactura.Close;
    end;
    DMFacturacion.QCabeceraFactura.RequestLive := true;
    DMFacturacion.QCAbeceraFactura.SQL.Clear;
    DMFacturacion.QCAbeceraFactura.SQL.add('SELECT * FROM tmp_facturas_c ' +
      ' ORDER BY factura_tfc');

    try
      QCabeceraFactura.Open;
      Facturas := QCabeceraFactura.RecordCount;
    except
      RellenaFacturas := false;
      Exit;
    end;

    try
      QBuscaSalida.Open;
    except
      QBuscaSalida.Close;
      RellenaFacturas := false;
      Exit;
    end;

          //Poner consulta de escritura
    if QGeneral.Active then
    begin
      QGeneral.Cancel;
      QGeneral.Close;
    end;
    QGeneral.RequestLive := true;

          //Recorrer tablas y actualizar datos
    while not QCabeceraFactura.Eof do
    begin
               //ABRIR TRANSACCION
      if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
        break;

      RImportesCabecera:= DatosTotalesFactura( QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                                               QCabeceraFactura.FieldByName('factura_tfc').AsInteger,
                                               QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime
                                               );

      try
                  //Actualiza contador y fecha facturas de empresa
        FacturaNumero := GetNumeroFactura(QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
          QCabeceraFactura.FieldByName('tipo_iva_tfc').AsString,
          QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime, sAux);
        if FacturaNumero = -1 then
        begin
          ShowError( sAux );
          CancelarTransaccion(DBBaseDatos);
          Break;
        end;
                  //Numero Factura Definitiva
        QCabeceraFactura.Edit;
        QCabeceraFactura.FieldByName('n_factura_tfc').AsInteger := FacturaNumero;
        QCabeceraFactura.Post;
      except
        CancelarTransaccion(DBBaseDatos);
        break;
      end;

      with QGeneral do
      begin
        Cancel;
        Close;
        SQL.Clear;
        SQL.add('INSERT INTO frf_facturas ');
        SQL.add('( empresa_f,cliente_sal_f,cliente_fac_f,n_factura_f, ');
        SQL.add('  fecha_factura_f,tipo_factura_f,concepto_f,moneda_f, ');
        SQL.add('  importe_neto_f,tipo_impuesto_f,porc_impuesto_f, ');
        SQL.add('  total_impuesto_f,importe_total_f,importe_euros_f,contabilizado_f,contab_cobro_f, ');
        SQL.add('  nota_albaran_f, prevision_cobro_f )');
        SQL.add('VALUES (');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString) + ', ');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_client_sal_tfc').AsString) + ', ');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString) + ', ');
        SQL.add(IntToStr(FacturaNumero) + ', ');
        SQL.add(SQLDate(QCabeceraFactura.FieldByName('fecha_tfc').AsString) + ', ');
        SQL.add(QCabeceraFactura.FieldByName('tipo_factura_tfc').AsString + ', ');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('concepto_tfc').AsString) + ', ');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString) + ', ');
        SQL.add(SQLNumeric(RImportesCabecera.rTotalBase) + ', ');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_iva_tfc').AsString) + ', ');
        if RImportesCabecera.rTotalBase <> 0 then
          SQL.add(SQLNumeric( ( ( RImportesCabecera.rTotalImporte / RImportesCabecera.rTotalBase ) - 1 ) * 100 )+ ', ')
        else
          SQL.add( SQLNumeric( 0 ) + ', ');
        SQL.add(SQLNumeric(RImportesCabecera.rTotalIva) + ', ');
        SQL.add(SQLNumeric(RImportesCabecera.rTotalImporte) + ',');
        SQL.add(SQLNumeric(RImportesCabecera.rTotalEuros) + ', ');
        SQL.add(quotedstr('N') + ', ');
        SQL.add(quotedstr('N') + ', ');
        SQL.add(':nota, :fechacobro ) ');
        ParamByName('nota').AsString:= QCabeceraFactura.FieldByName('nota_albaran_tfc').AsString;
        ParamByName('fechacobro').AsDate:= GetFechaVencimiento( QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                                                             QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString,
                                                             QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime);

        try
          //Rellena tabla cabecera de facturacion
          EjecutarConsulta(QGeneral);
        except
          CancelarTransaccion(DBBaseDatos);
          break;
        end;

        while not QBuscaSalida.Eof do
        begin
          Cancel;
          Close;
          SQL.Clear;
          SQL.add('UPDATE frf_salidas_c ');
          SQL.add('SET ');
          SQL.add('   fecha_factura_sc= ' + SQLDate(QCabeceraFactura.FieldByName('fecha_tfc').AsString) + ' ,');
          SQL.add('   n_factura_sc= ' + IntToStr(FacturaNumero) + ' ');
          SQL.add('Where empresa_sc= ' + quotedStr(QBuscaSalida.FieldByName('cod_empresa_tf').AsString) + ' ');
          SQL.add('AND centro_salida_sc= ' + quotedstr(QBuscaSalida.FieldByName('centro_salida_tf').AsString) + ' ');
          SQL.add('AND n_albaran_sc= ' + QBuscaSalida.FieldByName('albaran_tf').AsString + ' ');
          SQL.add('AND fecha_sc= ' + SQLDate(QBuscaSalida.FieldByName('fecha_alb_tf').AsString) + ' ');

          try
                            //Rellena factura y fecha facturacion en salidas
            EjecutarConsulta(QGeneral);
            QBuscaSalida.Next;
          except
            CancelarTransaccion(DBBaseDatos);
            error := true;
            break;
          end;
        end;
        if error then break;
      end;
      AceptarTransaccion(DBBaseDatos);


      try
        FacturaEdi( QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                           QCabeceraFactura.FieldByName('n_factura_tfc').AsInteger,
                           QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime );
      except
        ShowMEssage('Error al crear la Facturacion EDI de la factura nº ' + IntToStr( FacturaNumero ) );
        //raise;
      end;

      try
        QCabeceraFactura.Next;
        Inc(insertadas);
      except
        on E: EDBEngineError do
        begin
          ShowError(E);
          break;
        end
      end;
    end;
  end;
  if (insertadas < Facturas) or (insertadas = 0) then
  begin
    if insertadas = 0 then
    begin
      ShowError('No se ha podido realizar la operacion.');
      RellenaFacturas := false;
      Exit;
    end
    else
    begin
      ShowError('No se ha podido realizar la operación completa.' +
        ' Se han insertado ' + IntToStr(insertadas) + ' facturas de ' +
        IntToStr(Facturas) + ' posibles.');
      BorrarNoFacturadas;
    end;
  end;
  RellenaFacturas := true;
end;

procedure TDMFacturacionWEB.Previsualizar;
begin
     //Crear el listado
  try
    DMFacturacion.QCabeceraFactura.ParamByName('usuario').AsString := gsCodigo;
    DMFacturacion.QCabeceraFactura.Open;
    DMFacturacion.QLineaFactura.Open;
    DMFacturacion.QLineaGastos.Open;
  except
    Limpiar;
    Exit;
  end;

  DConfigMail.sAsunto:= AsuntoFactura;

  QRLFacturas := TQRLFacturas.Create(Application);
  QRLFacturas.LabelFecha.Caption := fechaFactura.Text;
  QRLFacturas.definitivo := definitivo;

  QRLFacturas.Configurar(Empresa.Text);
  QRLFacturas.printOriginal := printOriginal.Checked;
  QRLFacturas.printEmpresa := printEmpresa.Checked;
  if Definitivo then
  begin
    DPreview.bCanSend := (DMConfig.EsLaFont);
    if printOriginal.Checked then
      QRLFacturas.Tag:= 1
    else
    if printEmpresa.Checked then
      QRLFacturas.Tag:= 2
    else
      QRLFacturas.Tag:= 3;
    Preview(QRLFacturas, NumeroCopias, False, True)
  end
  else
  begin
    QRLFacturas.Tag:= 0;
    Preview(QRLFacturas, 1, False, False);
  end;

  Limpiar;
end;

procedure TDMFacturacionWEB.ComprobarRiesgoCliente( const AEmpresa, ACliente: string );
var
  rRiesgo, rFacturado, rCobrado: real;
begin
  with QAux2 do
  begin
    SQl.Clear;
    SQL.Add('select max_riesgo_c from frf_clientes where empresa_c = :empresa and cliente_c = :cliente and max_riesgo_c is not null ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;
    if not IsEmpty then
    begin
      rRiesgo:= FieldByName('max_riesgo_c').AsFloat;
      Close;
      SQl.Clear;
      SQL.Add('select sum( importe_euros_f ) importe from frf_facturas where empresa_f = :empresa and cliente_fac_f= :cliente ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('cliente').AsString:= ACliente;
      Open;
      rFacturado:= FieldByName('importe').AsFloat;
      Close;
      SQl.Clear;
      SQL.Add(' select sum( euros(moneda_f, fecha_factura_f, importe_cobrado_fr) ) importe  ');
      SQL.Add(' from frf_facturas, frf_facturas_remesa  ');
      SQL.Add(' where empresa_f = :empresa  and cliente_fac_f= :cliente  ');
      SQL.Add('   and planta_fr = :empresa  and factura_fr = n_factura_f  and fecha_factura_fr = fecha_factura_f  and fecha_remesa_fr <= TODAY  ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('cliente').AsString:= ACliente;
      Open;
      rCobrado:= FieldByName('importe').AsFloat;
      Close;
      rRiesgo:= rRiesgo - rFacturado +  rCobrado;
      if rRiesgo < 0 then
      begin
        ShowError('Riesgo superado en ' + FormatFloat('#,##0.00', rRiesgo ) + '€ para el cliente ' + ACliente + '.');
      end;
    end;
  end;
end;

procedure TDMFacturacionWEB.DescripcionMarca;
begin
  with QGeneral do
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

function TDMFacturacionWEB.FacturarPor(const empresa, cliente: string): integer;
begin
  //0 Facturar todos los albaranes pendientes
  //1 Un albaran una factura
  //2 Un pedido una factura
  if Trim(pedido.Text) <> '' then
  begin
    result := 2;
  end
  else
  begin
    QAux2SQL.Clear;
    QAux2SQL.Add(' select NVL( albaran_factura_c, 0 ) ');
    QAux2SQL.Add(' from frf_clientes ');
    QAux2SQL.Add(' where empresa_c ' + SQLEqualS(empresa));
    QAux2SQL.Add('   and cliente_c ' + SQLEqualS(cliente));
    QAux2Open;
    if QAux2Fields[0].AsInteger = 0 then
      result := 0
    else
      result := 1;
    QAux2Close;
  end;
end;

end.
