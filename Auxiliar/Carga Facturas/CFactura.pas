unit CFactura;

interface

uses UDFactura, BonnyQuery, SysUtils, bTextUtils, Classes, bMath, DB,
     dbtables, Windows, Forms, Dialogs;

type
    TRDatosClienteFac  = record
    sDesCliente, sCtaCliente, sNIFCliente,
    sTipoVia, sDomicilio, sPoblacion,
    sCodPostal, sProvincia, sCodPais,
    sDesPais, sFormaPago: string;
    iDias: integer;
end;

function DescripcionProducto : string;
function DescripcionEnvase(Empresa, Producto, Envase, Cliente: string) : string;
function DescripcionMarca(Marca: string): string;
function DesEmpresa(Empresa: string): String;
function DestEmpresa(Empresa: string): string;
function desFormaPagoEx(const forma: string): string;
function DesImpuesto(const impuesto: string): string;
function GetProductoBase(const Empresa, Producto: string): string;
function GetPorcentajeComision( const AEmpresa, ARepresentante: string;
                                const AFechaFactura: TDateTime ): real;
function GetPorcentajeDescuento( const AEmpresa, ACliente, ACentro, AProducto : string;
                                 const AFechaFactura: TDateTime ): Real;
function  NewCodigoFactura( const AEmpresa, ATipo, AImpuesto: string;
                            const AFechaFactura: TDateTime;
                            const AFactura: integer ): string;
function  GetPrefijoFactura( const AEmpresa, ATipo, AImpuesto: string;
                             const AFechaFactura: TDateTime;
                             const AFactura: Integer ): string;
function  NewContadorFactura( const AEmpresa: String; AFactura, AAno: integer ): string;
function  GetDatosCliente(const AEmpresa, ACliente, ADirSum: String): TRDatosClienteFac;
function ChangeToEuro( AMonedaOrigen, AFechaCambio: string; AValor: real; ADecimales: integer = 2 ): Real; overload;
function ChangeToEuro( AMonedaOrigen: string; AFechaCambio: TDateTime; AValor: real; ADecimales: integer = 2 ): Real; overload;
function ToEuro( AMonedaOrigen: string; AFechaCambio: TdateTime): Real; overload;
function ToEuro( AMonedaOrigen, AFechaCambio: string): Real; overload;
function FromEuro( AMonedaDestino: string; AFechaCambio: TdateTime): Real; overload;
function FromEuro( AMonedaDestino, AFechaCambio: string): Real; overload;
function VarChangeFromEuro( AMonedaDestino: string; AFechaCambio: TdateTime): Real;

function AbrirTransaccion(DB: TDataBase): boolean;
procedure AceptarTransaccion(DB: TDataBase);
procedure CancelarTransaccion(DB: TDataBase);
procedure EjecutarConsulta(consulta: TQuery);


implementation

function DescripcionProducto : String;
begin
  if DFactura.QGeneral.FieldByName('pais_fac_c').AsString = 'ES' then
  begin
    Result := DFactura.QGeneral.FieldByName('descripcion_p').AsString;
  end
  else
  begin
    if DFactura.QGeneral.FieldByName('descripcion2_p').AsString <> '' then
    begin
      Result := DFactura.QGeneral.FieldByName('descripcion2_p').AsString;
    end
    else
    begin
      Result := DFactura.QGeneral.FieldByName('descripcion_p').AsString;
    end;
  end;
end;

function DescripcionEnvase(Empresa, Producto, Envase, Cliente: string) : String;
var DescripcionEnvase, ProductoBase: string;
begin
  DescripcionEnvase := '';
  ProductoBase := GetProductoBase(Empresa, Producto);
  with DFactura.QAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' select descripcion_ce ');
    SQL.Add('   from frf_clientes_env ');
    SQL.Add('  where empresa_ce = :empresa ');
    SQL.Add('    and producto_base_ce = :producto ');
    SQL.Add('    and envase_ce = :envase ');
    SQL.Add('    and cliente_ce = :cliente ');

    ParamByName('empresa').AsString := Empresa;
    ParamByName('producto').AsString := ProductoBase;
    ParamByName('envase').AsString := Envase;
    ParamByName('cliente').AsString := Cliente;

    Open;

    if (IsEmpty) or (FieldByName('descripcion_ce').AsString = '') then
    begin
      if DFactura.QGeneral.FieldByName('pais_fac_c').AsString = 'ES' then
      begin
        Result := DFactura.QGeneral.FieldByName('descripcion_e').AsString;
      end
      else
      begin
        if DFactura.QGeneral.FieldByName('descripcion2_e').AsString <> '' then
        begin
          Result := DFactura.QGeneral.FieldByName('descripcion2_e').AsString;
        end
        else
        begin
          Result := DFactura.QGeneral.FieldByName('descripcion_e').AsString;
        end;
      end;
    end
    else
      Result := FieldByname('descripcion_ce').AsString;

  end;
end;

function DescripcionMarca(Marca: string): string;
var QMarca: TBonnyQuery;
begin
  QMarca := TBonnyQuery.Create(nil);
  with QMarca do
  try
    SQL.Add(' select descripcion_m ');
    SQL.Add('   from frf_marcas ');
    SQL.Add('  where codigo_m = :codigo ');

    ParamByName('codigo').AsString := Marca;
    Open;
    if isEmpty then
      Result := ''
    else
      Result := FieldbyName('descripcion_m').AsString;
  finally
    Free;
  end;
end;

function desEmpresa(Empresa: string): string;
var QDescripcion: TBonnyQuery;
begin
  desEmpresa := '';
  if Trim(empresa) = '' then Exit;
  QDescripcion := TBonnyQuery.Create(nil);
  with QDescripcion do
  try
    SQL.Add(' select nombre_e from frf_empresas ');
    SQL.Add('  where empresa_e = :empresa ');
    ParamByName('empresa').AsString := Empresa;
    Open;

    Result := FieldByName('nombre_e').AsString;

  finally
    Free;
  end;
end;

function DestEmpresa(Empresa: string): String;
var QDescripcion: TBonnyQuery;
begin
  destEmpresa := '';
  if Trim(empresa) = '' then Exit;
  QDescripcion := TBonnyQuery.Create(nil);
  with QDescripcion do
  try
    SQL.Add(' select nombre_emp from tempresas ');
    SQL.Add('  where empresa_emp = :empresa ');
    ParamByName('empresa').AsString := Empresa;
    Open;

    Result := FieldByName('nombre_emp').AsString;

  finally
    Free;
  end;
end;

function desFormaPagoEx(const forma: string): string;
var QDescripciones: TBonnyQuery;
var
  i: integer;
begin
  result := '';
  if Trim(forma) = '' then Exit;
  QDescripciones := TBonnyQuery.Create(nil);
  with QDescripciones do
  try
    SQL.Add(' select descripcion_fp, descripcion2_fp, ');
    SQL.Add(' descripcion3_fp, descripcion4_fp, ');
    SQL.Add(' descripcion5_fp, descripcion6_fp, ');
    SQL.Add(' descripcion7_fp, descripcion8_fp, descripcion9_fp');
    SQL.Add(' from frf_forma_pago ');
    SQL.Add(' where codigo_fp = :forma');

    ParamByName('forma').AsString :=  forma;

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
  finally
    Free;
  end;
end;

function desImpuesto(const impuesto: string): string;
var QDescripciones: TBonnyQuery;
begin
  desImpuesto := '';
  if Trim(impuesto) = '' then Exit;
  QDescripciones := TBonnyQuery.Create(nil);
  with QDescripciones do
  try
    SQL.Add(' select descripcion_i from frf_impuestos ');
    SQL.Add(' where codigo_i = :impuesto ');

    ParamByName('impuesto').AsString := impuesto;
    Open;
    Result := FieldByName('descripcion_i').AsString;

  finally
    Free;
  end;
end;

function GetProductoBase(const Empresa, Producto: string): string;
begin
  with DFactura.Qaux  do
  begin
    SQL.Clear;

    SQL.Add(' select producto_base_p ');
    SQL.Add('  from frf_productos ');
    SQL.Add(' where empresa_p = :empresa ');
    SQL.Add('   and producto_p = :producto ');

    ParamByName('empresa').AsString := Empresa;
    ParamByName('producto').AsString := Producto;

    Open;
    if IsEmpty then
      result := ''
    else
      result := fieldbyname('producto_base_p').AsString;
  end;
end;

function GetPorcentajeComision( const AEmpresa, ARepresentante: string; const AFechaFactura: TDateTime ): real;
begin
  with DFactura.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select comision_rc  ');
    SQL.Add('   from frf_representantes_comision ');
    SQL.Add('  where empresa_rc = :empresa ');
    SQL.Add('    and representante_rc = :representante ');
    SQl.Add('    and :fechafactura between fecha_ini_rc and nvl(fecha_fin_rc,Today) ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('representante').AsString:= ARepresentante;
    ParamByName('fechafactura').AsDateTime:= AFechaFactura;
    Open;
    if IsEmpty then
      result := 0
    else
      result:= FieldByName('comision_rc').AsFloat;
    Close;
  end;
end;

function GetPorcentajeDescuento(const AEmpresa, ACliente, ACentro, AProducto: string; const AFechaFactura: TDateTime): real;
begin
  result := 0;
  with DFactura.QAux do
  begin
        // Descuento por cliente
    SQL.Clear;
    SQL.Add(' select facturable_dc ');
    SQL.Add(' from frf_descuentos_cliente ');
    SQL.Add(' where empresa_dc = :empresa ');
    SQL.Add('   and cliente_dc = :cliente ');
    SQL.Add('   and :fechafactura between  fecha_ini_dc and nvl(fecha_fin_dc,Today) ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('fechafactura').AsDateTime:= AFechaFactura;
    Open;
    if not IsEmpty then
      result:= result + FieldByName('facturable_dc').AsFloat;

        // Descuento por centro
    SQL.Clear;
    SQL.Add(' select facturable_dc ');
    SQL.Add(' from frf_descuentos_centro ');
    SQL.Add(' where empresa_dc = :empresa ');
    SQL.Add('   and cliente_dc = :cliente ');
    SQL.Add('   and centro_dc = :centro ');
    SQL.Add('   and :fechafactura between  fecha_ini_dc and nvl(fecha_fin_dc,Today) ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechafactura').AsDateTime:= AFechaFactura;
    Open;
    if not IsEmpty then
      result:= result + FieldByName('facturable_dc').AsFloat;

        // Descuento por producto
    SQL.Clear;
    SQL.Add(' select facturable_dp ');
    SQL.Add(' from frf_descuentos_producto ');
    SQL.Add(' where empresa_dp = :empresa ');
    SQL.Add('   and cliente_dp = :cliente ');
    SQL.Add('   and producto_dp = :producto ');
    SQL.Add('   and :fechafactura between  fecha_ini_dp and nvl(fecha_fin_dp,Today) ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fechafactura').AsDateTime:= AFechaFactura;
    Open;
    if not IsEmpty then
      result:= result + FieldByName('facturable_dp').AsFloat;

    Close;
  end;
end;

function  NewCodigoFactura( const AEmpresa, ATipo, AImpuesto: string;
                            const AFechaFactura: TDateTime;
                            const AFactura: integer ): string;
var iAno, iMes, iDia: Word;
begin
  DEcodeDate(AFechaFactura, iAno, iMes, iDia);
  result:= GetPrefijoFactura( AEmpresa, ATipo, AImpuesto, AFechaFactura, AFactura ) +
         NewContadorFactura( AEmpresa, AFactura, iAno );
end;

function  GetPrefijoFactura( const AEmpresa, ATipo, AImpuesto: string;
                             const AFechaFactura: TDAteTime;
                             const AFactura: Integer ): string;
var
  iAnyo, iMes, iDia: word;
  sAux, sEmpresa, sGrupo: string;
begin
  result:= 'ERROR ';
  DecodeDate( AFechaFactura, iAnyo, iMes, iDia );
  sAux:= IntToStr( iAnyo );
  sAux:= Copy( sAux, 3, 2 );

  if AEmpresa = '080' then
  begin
    sEmpresa:= 'F80';
  end
  else
  begin
    sEmpresa:= AEmpresa;
  end;

  if Copy( AImpuesto, 1, 1 ) = 'I' then
  begin
    if ATipo = '380' then
    begin
      if (AEmpresa = '050') and (iAnyo = 2006) and (AFactura >= 100000) and (AFactura <= 200000) then
        if (AFactura >= 100000) and (AFactura <= 106342) then
        begin
          if iMes <=6 then
            sGrupo := '1'
          else
            sGrupo := '2';
          result := 'FCP' + sGrupo + sEmpresa + sAux;
        end
        else
          result := 'FCP-' + sEmpresa + sAux
      else
        result:= 'FCP-' + sEmpresa + sAux + '-';
    end
    else
    begin
      result:= 'ACP-' + sEmpresa + sAux + '-';
    end;
  end
  else
  begin
    if ATipo = '380' then
    begin
      if (AEmpresa = '050') and (iAnyo = 2006) and (AFactura >= 500000) then
        result := 'FCT-' + sEmpresa + sAux
      else
        result:= 'FCT-' + sEmpresa + sAux + '-';
    end
    else
    begin
      result:= 'ACT-' + sEmpresa + sAux + '-';
    end;
  end;
end;

function  NewContadorFactura( const AEmpresa: String; AFactura, AAno: integer ): string;
begin
  if AFactura > 99999 then
  begin
    result:= IntToStr( AFactura );
    if (AEmpresa = '050') and (AAno = 2006) and
       (((AFactura >= 100000) and (AFactura <= 200000)) or (AFactura >= 500000)) then
      result := Copy( result, length( result ) - 5, 6 )
    else
      result:= Copy( result, length( result ) - 4, 5 );
  end
  else
  begin
    result:= Rellena( IntToStr( AFactura ), 5, '0', taLeftJustify );
  end;
end;

function GetDatosCliente(const AEmpresa, ACliente, ADirSum: string): TRDatosClienteFac;
begin

  with DFactura.QAux do
  begin
    SQl.Clear;
    if ACliente = 'WEB' then
    begin
      SQL.Add(' SELECT  nombre_ds nombre_c, cta_cliente_c, nif_ds nif_c, tipo_via_ds tipo_via_fac_c, ');
      SQL.Add('         domicilio_ds domicilio_fac_c, poblacion_ds poblacion_fac_c,  ');
      SQL.Add('         cod_postal_ds cod_postal_fac_c, nombre_p, pais_ds pais_c, descripcion_p, forma_pago_c, ');
      SQL.Add('         NVL(dias_cobro_fp, 0) dias_cobro_fp ');
      SQL.Add('   FROM frf_clientes, frf_dir_sum, frf_forma_pago, outer(frf_provincias), outer(frf_paises) ');
      SQL.Add('  WHERE empresa_ds = :empresa ');
      SQL.Add('    AND cliente_ds = :cliente ');
      SQL.Add('    AND dir_sum_ds = :dirsum  ');

      SQL.Add('    AND empresa_c = empresa_ds ');
      SQL.ADD('    AND cliente_c = cliente_ds ');

      SQL.Add('    AND codigo_fp = forma_pago_c ');

      SQL.Add('    AND codigo_p = cod_postal_ds[1,2] ');

      SQL.Add('    AND pais_p = pais_ds ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('cliente').AsString := ACliente;
      ParamByName('dirsum').AsString := ADirSum;

    end
    else
    begin
      SQL.Add(' SELECT  nombre_c, cta_cliente_c, nif_c, tipo_via_fac_c, domicilio_fac_c, poblacion_fac_c,  ');
      SQL.Add('         cod_postal_fac_c, nombre_p, pais_c, descripcion_p, forma_pago_c, ');
      SQL.Add('         NVL(dias_cobro_fp, 0) dias_cobro_fp ');
      SQL.Add('   FROM frf_clientes, frf_forma_pago, outer(frf_provincias), outer(frf_paises) ');
      SQL.Add('  WHERE empresa_c = :empresa ');
      SQL.Add('    AND cliente_c = :cliente ');

      SQL.Add('    AND codigo_fp = forma_pago_c ');

      SQL.Add('    AND codigo_p = cod_postal_fac_c[1,2] ');

      SQL.Add('    AND pais_p = pais_fac_c ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('cliente').AsString := ACliente;
    end;

    Open;

    Result.sDesCliente := FieldByName('nombre_c').AsString;
    Result.sCtaCliente := FieldByName('cta_cliente_c').AsString;
    Result.sNIFCliente := FieldByName('nif_c').AsString;
    Result.sTipoVia    := FieldByName('tipo_via_fac_c').AsString;
    Result.sDomicilio  := FieldByName('domicilio_fac_c').AsString;
    Result.sPoblacion  := FieldByName('poblacion_fac_c').AsString;
    Result.sCodPostal  := FieldByName('cod_postal_fac_c').AsString;
    Result.sProvincia  := FieldByName('nombre_p').AsString;
    Result.sCodPais    := FieldByName('pais_c').AsString;
    Result.sDesPais    := FieldByName('descripcion_p').AsString;
    Result.sFormaPago  := FieldByName('forma_pago_c').AsString;
    Result.iDias       := FieldByName('dias_cobro_fp').AsInteger;

  end;

end;

function ChangeToEuro( AMonedaOrigen, AFechaCambio: string; AValor: real; ADecimales: integer = 2 ): Real;
var
  dFechaCambio: TDateTime;
begin
  Result := 0;
  if TryStrToDate( AFechaCambio, dFechaCambio ) then
  begin
    result:=  ChangeToEuro( AMonedaOrigen, dFechaCambio, AValor, ADecimales );
  end;
{
  else
  begin
    sMensaje := 'Fecha para el cambio incorrecta.';
    GrabarError(sMensaje);
  end;
}
end;

function ChangeToEuro( AMonedaOrigen: string; AFechaCambio: TDateTime; AValor: real; ADecimales: integer = 2 ): Real;
begin
  if AValor < 0 then
    result:= -1 * bRoundTo( ABS(AValor) * ToEuro( AMonedaOrigen, AFechaCambio ), -ADecimales)
  else
    result:= bRoundTo( AValor * ToEuro( AMonedaOrigen, AFechaCambio ), -ADecimales);
end;

function ToEuro( AMonedaOrigen, AFechaCambio: string): Real;
var
  dFechaCambio: TDateTime;
begin
  if TryStrToDate( AFechaCambio, dFechaCambio ) then
  begin
    result:= ToEuro( AMonedaOrigen, dFechaCambio );
  end
  else
  begin
    raise Exception.Create('Fecha para el cambio incorrecta.');
  end;
end;

function ToEuro( AMonedaOrigen: string; AFechaCambio: TdateTime): Real;
begin
  result := FromEuro( AMonedaOrigen, AFechaCambio );
  if result > 0 then
    result:= bRoundTo( 1 /result, -5);
end;

function FromEuro( AMonedaDestino, AFechaCambio: string): Real;
var
  dFechaCambio: TDateTime;
begin
  if TryStrToDate( AFechaCambio, dFechaCambio ) then
  begin
    result:= FromEuro( AMonedaDestino, dFechaCambio );
  end
  else
  begin
    raise Exception.Create('Fecha para el cambio incorrecta.');
  end;
end;

//Los unicas monedas europeas com cambio fijo utilizadas fueron ESP, DEM, FRF
function FromEuro( AMonedaDestino: string; AFechaCambio: TdateTime): Real;
begin
  if ( AMonedaDestino = 'EUR' ) or ( AMonedaDestino = 'DEM' ) or
     ( AMonedaDestino = 'ESP' ) or ( AMonedaDestino = 'FRF' ) or
     ( AMonedaDestino = '' ) then
  begin
    if ( AMonedaDestino = 'EUR' ) or  ( AMonedaDestino = '' )then
      result:= 1
    else
    if AMonedaDestino = 'DEM' then
      result:= 1.95583
    else
    if AMonedaDestino = 'ESP' then
      result:= 166.386
    else
    //if AMonedaDestino = 'FRF' then
      result:= 6.55957;
  end
  else
  begin
    result:= VarChangeFromEuro( AMonedaDestino, AFechaCambio );
    if result = -1 then
    begin
      raise Exception.Create('No existe el cambio de "' + AMonedaDestino + '" para el "' + DateToStr( AFechaCambio) + '".' );
    end;
  end;
end;

function VarChangeFromEuro( AMonedaDestino: string; AFechaCambio: TdateTime): Real;
var QChange, QChangeAux :TBonnyQuery;
begin
  QChange := TBonnyQuery.Create(nil);
  with QChange do
  try
    SQL.Add(' Select cambio_ce factor ');
    SQL.Add(' from frf_cambios_euros ');
    SQL.Add(' where moneda_ce = :moneda ');
    SQL.Add(' and fecha_ce = :fecha ');
    SQL.Add(' and nvl(cambio_ce,0) <> 0 ');

    ParamByName('moneda').AsString:= AMonedaDestino;
    ParamByName('fecha').AsDateTime:= AFechaCambio;
    Open;
    if not IsEmpty then
    begin
      result:= FieldByName('factor').AsFloat;
    end
    else
    begin
      result:= -1;
    end;

  finally
    Free;
  end;
  if result = -1 then
  begin
    QChangeAux := TBonnyQuery.Create(nil);
    with QChangeAux do
    try
      SQL.Add(' Select first 1 cambio_ce factor ');
      SQL.Add(' from frf_cambios_euros ');
      SQL.Add(' where moneda_ce= :moneda ');
      SQL.Add(' and fecha_ce < :fecha ');
      SQL.Add(' and nvl(cambio_ce,0) <> 0 ');
      SQL.Add(' order by fecha_ce desc ');

      ParamByName('moneda').AsString:= AMonedaDestino;
      ParamByName('fecha').AsDateTime:= AFechaCambio;
      Open;
      if not IsEmpty then
      begin
        result:= FieldByName('factor').AsFloat;
      end
      else
      begin
        result:= -1;
      end;

    finally
      Free;
    end;
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

procedure EjecutarConsulta(consulta: TQuery);
begin
  try
    consulta.ExecSQL;
  except
    on e: EDBEngineError do
    begin
      raise;
    end;
  end;
end;


end.
