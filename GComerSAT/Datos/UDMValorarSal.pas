unit UDMValorarSal;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMValorarSal = class(TDataModule)
    qrySalidasDet: TQuery;
    qryCambioFactura: TQuery;
    qryCambioAlbaran: TQuery;
    qrySalidasCab: TQuery;
    qryDescuento: TQuery;
    qryComision: TQuery;
    qryGastos: TQuery;
    qryProductoBase: TQuery;
    qryCosteEnvasado: TQuery;
    qryAbonos: TQuery;
    qryOtrosCostes: TQuery;
    qrySalTransitos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentroSalida, sProducto: string;
    dFechaSalida: TDateTime;
    iNumSalida: Integer;
    iProductoBase: Integer;
    iErrorCode: Integer;
    sRefError: string;

    sClienteSalida, sMonedaSalida: string;
    rkilos_total,rimporte_total,rkilos_prod,rimporte_prod,rkilos_tran,rimporte_tran,rkilos_prod_tran,rimporte_prod_tran: Real;
    icajas_total,ipalets_total,icajas_prod,ipalets_prod,icajas_tran,ipalets_tran,icajas_prod_tran,ipalets_prod_tran: Integer;

    rKilos,rImporte,rDescuento,rGasto,rAbonos,rEnvasado,rOtros: Real;
    rFactorComision, rFactorDescuento, rFactorCambio, rCosteEnvasado, rOtrosCostes: Real;

    function HaySalidas: Boolean;

    function  ProductoBase: boolean;
    function  ValorarLineas( const ADefinitivo, ACostesAnteriores: Boolean ): Boolean ;
    procedure CambioMoneda;
    procedure PutComision;
    procedure PutDescuento;
    procedure AbreGastos;
    procedure CierraGastos;
    function  GastosLinea: real;
    function  GastoTodos: Real;
    function  GastoProducto: Real;
    function  GastoTransitoTodos: Real;
    function  GastoTransitoProducto: Real;
    function  AbonosSalida: real;
    function  CosteEnvasado( const ADefinitivo, ACostesAnteriores: Boolean ): Boolean;
    function  OtrosCostes: Boolean;
  public
    { Public declarations }

    function ValorarProductoSalida( const AEmpresa, ACentroSalida, AProducto: string;
                             const AFechaSalida: TDateTime; const ANumSalida: Integer;
                             const ADefinitivo, ACostesAnteriores: Boolean;
                             var VKilos, VImporte, VDescuento, VGastos, VAbonos, VEnvasado, VOtros : Real;
                             var VErrorCode: Integer; var VErrorMsg: String ): Boolean;
    function ValorarProductoTransito( const AEmpresa, ACentroOrigen, AProducto: string;
                             const AFechaTransito: TDateTime; const ANumTransito: Integer;
                             const ADefinitivo, ACostesAnteriores: Boolean;
                             var VKilos, VImporte, VDescuento, VGastos, VAbonos, VEnvasado, VOtros : Real;
                             var VErrorCode: Integer; var VErrorMsg: String ): Boolean;
  end;

implementation

{$R *.dfm}

uses
  bMath;

const
   iecOK: Integer = 0;
   iecNoSalida: Integer = 1;
   iecNoProducto: Integer = 2;
   iecNoProductoBase: Integer = 3;
   iecNoCosteEnvasado: Integer = 4;
   iecNoCosteEnvasadoMes: Integer = 5;
   iecNoCostesIndirectos: Integer = 6;
   iecNoTransito: Integer = 7;
   iecNoTransitoAsignado: Integer = 8;
   iecNoSalidasTransito: Integer = 9;
   ErrorMgs : array[0..9] of string = (
     'OK',
     'No existe la salida seleccionada.',
     'No existe el producto para la salida seleccionada.',
     'No puedo localizar el producto base.',
     'No hay grabado ningun coste para el artículo.',
     'Falta grabar los costes del mes del artículo.',
     'Falta grabar los costes indirectos.',
     'No existe el tránsito seleccionado.',
     'El tránsito seleccionado no esta asignado al 100%.',
     'Tránsito con salidas con errores.'
   );

procedure TDMValorarSal.DataModuleCreate(Sender: TObject);
begin
  with qrySalidasCab do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_fac_sc, moneda_sc, ');
    SQL.Add('        sum(cajas_sl) cajas_sc, ');
    SQL.Add('        sum(kilos_sl) kilos_sc, ');
    SQL.Add('        sum(n_palets_sl) palets_sc, ');
    SQL.Add('        sum(importe_neto_sl) importe_sc, ');
    SQL.Add('        sum(case when producto_sl =:producto then cajas_sl else 0 end) cajas_prod_sc, ');
    SQL.Add('        sum(case when producto_sl =:producto then kilos_sl else 0 end) kilos_prod_sc, ');
    SQL.Add('        sum(case when producto_sl =:producto then n_palets_sl else 0 end) palets_prod_sc, ');
    SQL.Add('        sum(case when producto_sl =:producto then importe_neto_sl else 0 end) importe_prod_sc, ');
    SQL.Add('        sum(case when ref_transitos_sl is not null then cajas_sl else 0 end) cajas_tran_sc, ');
    SQL.Add('        sum(case when ref_transitos_sl is not null then kilos_sl else 0 end) kilos_tran_sc, ');
    SQL.Add('        sum(case when ref_transitos_sl is not null then n_palets_sl else 0 end) palets_tran_sc, ');
    SQL.Add('        sum(case when ref_transitos_sl is not null then importe_neto_sl else 0 end) importe_tran_sc, ');
    SQL.Add('        sum(case when producto_sl =:producto and ref_transitos_sl is not null then cajas_sl else 0 end) cajas_prod_tran_sc, ');
    SQL.Add('        sum(case when producto_sl =:producto and ref_transitos_sl is not null then kilos_sl else 0 end) kilos_prod_tran_sc, ');
    SQL.Add('        sum(case when producto_sl =:producto and ref_transitos_sl is not null then n_palets_sl else 0 end) palets_prod_tran_sc, ');
    SQL.Add('        sum(case when producto_sl =:producto and ref_transitos_sl is not null then importe_neto_sl else 0 end) importe_prod_tran_sc ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_Salida_sc = :centroSalida ');
    SQL.Add(' and n_albaran_sc = :numSalida ');
    SQL.Add(' and fecha_sc = :fechaSalida ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_Salida_sl = :centroSalida ');
    SQL.Add(' and n_albaran_sl = :numSalida ');
    SQL.Add(' and fecha_sl = :fechaSalida ');
    SQL.Add(' and producto_sl = :producto ');
    SQL.Add(' group by 1, 2 ');
  end;

  with qrySalidasDet do
  begin
    SQL.Clear;
    SQL.Add(' select case when ref_transitos_sl is not null then 1 else 0 end transito_sl, centro_origen_sl, ');
    SQL.Add('        envase_sl, sum(cajas_sl) cajas_sl, sum(kilos_sl) kilos_sl, sum(n_palets_sl) palets_sl, sum(importe_neto_sl) importe_sl');
    SQL.Add(' from frf_salidas_l ');

    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and centro_Salida_sl = :centroSalida ');
    SQL.Add(' and n_albaran_sl = :numSalida ');
    SQL.Add(' and fecha_sl = :fechaSalida ');
    SQL.Add(' and producto_sl = :producto ');
    SQL.Add(' group by 1,2,3 ');
  end;

  with qryCambioFactura do
  begin
    SQL.Clear;
    SQL.Add(' select importe_total_f, importe_euros_f ');
    SQL.Add(' from frf_salidas_c, frf_facturas ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_Salida_sc = :centroSalida ');
    SQL.Add(' and n_albaran_sc = :numSalida ');
    SQL.Add(' and fecha_sc = :fechaSalida ');

    SQL.Add(' and empresa_f = :empresa ');
    SQL.Add(' and n_factura_f = n_factura_sc ');
    SQL.Add(' and fecha_factura_f = fecha_factura_sc ');
  end;

  with qryCambioAlbaran do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 fecha_ce, cambio_ce ');
    SQL.Add(' from frf_cambios_euros ');
    SQL.Add(' where moneda_ce = :monedaSalida ');
    SQL.Add(' and fecha_ce <= :fechaSalida ');
    SQL.Add(' order by fecha_ce desc ');
  end;

  with qryGastos do
  begin
    SQL.Clear;
    SQL.Add(' select case when gasto_transito_tg = 1 then 1 else 0 end gasto_transito_tg, ');
    SQL.Add('        producto_g, unidad_dist_tg[1,1] unidad_dist_tg, importe_g ');
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');

    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add(' and centro_Salida_g = :centroSalida ');
    SQL.Add(' and n_albaran_g = :numSalida ');
    SQL.Add(' and fecha_g = :fechaSalida ');
    SQL.Add(' and tipo_g = tipo_tg ');
    SQL.Add(' and ( facturable_tg = ''S'' or descontar_fob_tg = ''S'') ');
    SQL.Add(' and ( producto_g = :producto or producto_g is null ) ');
  end;

  with qryDescuento do
  begin
    SQL.Clear;
    SQL.Add(' select facturable_dc + facturable_dc descuento_cd');
    SQL.Add(' from frf_descuentos_cliente ');
    SQL.Add(' where empresa_dc = :empresa ');
    SQL.Add(' and cliente_dc = :clienteSalida ');
    SQL.Add(' and :fechaSalida between fecha_ini_dc and nvl(fecha_fin_dc,Today) ');
  end;

  with qryComision do
  begin
    SQL.Clear;
    SQL.Add(' select comision_rc ');
    SQL.Add(' from frf_clientes, frf_representantes_comision ');
    SQL.Add(' where cliente_c  = :clienteSalida ');
    SQL.Add(' and representante_rc = representante_c ');
    SQL.Add(' and :fechaSalida between fecha_ini_rc and nvl(fecha_fin_rc,Today) ');
  end;

  with qryProductoBase do
  begin
    SQL.Clear;
    SQL.Add(' select producto_base_p ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where producto_p = :producto ');
  end;

  with qryCosteEnvasado do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 anyo_ec, mes_ec, ( ( material_ec + coste_ec ) + secciones_ec ) coste_envasado ');
    SQL.Add(' from frf_env_costes ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_ec = :centroSalida ');
    SQL.Add(' and envase_ec = :envase ');
    SQL.Add(' and producto_ec = :producto ');
    SQL.Add(' and :anyomesSalida >= ( anyo_ec * 100 + mes_ec ) ');
    SQL.Add(' order by anyo_ec desc, mes_Ec desc ');
  end;

  with qryAbonos do
  begin
    SQL.Clear;
    SQL.Add(' select importe_fal ');
    SQL.Add(' from frf_fac_abonos_l ');
    SQL.Add(' where empresa_fal = :empresa ');
    SQL.Add(' and centro_salida_fal = :centroSalida ');
    SQL.Add(' and fecha_albaran_fal = :fechaSalida ');
    SQL.Add(' and n_albaran_fal = :numSalida ');
    SQL.Add(' and producto_fal = :producto ');
  end;

  with qryOtrosCostes do
  begin
    SQL.Clear;
    SQL.Add(' select comercial_ci + produccion_ci + administracion_ci coste_indirecto ');
    SQL.Add(' from frf_costes_indirectos ');
    SQL.Add(' where empresa_ci = :empresa ');
    SQL.Add(' and centro_origen_ci = :centroOrigen ');
    SQL.Add(' and :fechaSalida between fecha_ini_ci and nvl(fecha_fin_ci,Today) ');
  end;

end;

(*VALORART*)
//AddError( 'Falta valorar tránsito -> ' + GetCodeSalida );
function TDMValorarSal.ValorarProductoTransito( const AEmpresa, ACentroOrigen, AProducto: string;
                             const AFechaTransito: TDateTime; const ANumTransito: Integer;
                             const ADefinitivo, ACostesAnteriores: Boolean;
                             var VKilos, VImporte, VDescuento, VGastos, VAbonos, VEnvasado, VOtros : Real;
                             var VErrorCode: Integer; var VErrorMsg: String ): Boolean;
var
  iError: Integer;
  sMsg, sAMsg: string;
  rAux, rKilos, rImporte, rDescuento, rGastos, rAbonos, rEnvasado, rOtros: Real;
begin
  VKilos:= 0;
  VImporte:= 0;
  VDescuento:= 0;
  VGastos:= 0;
  VAbonos:= 0;
  VEnvasado:= 0;
  VOtros:= 0;
  VErrorCode:= iecOK;
  VErrorMsg:= '';


  with qrySalTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select  sum(kilos_tl) kilos ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :centro ');
    SQL.Add(' and referencia_tl = :salida ');
    SQL.Add(' and fecha_tl = :fecha ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentroOrigen;
    ParamByName('salida').AsInteger:= ANumTransito;
    ParamByName('fecha').Asdate:= AFechaTransito;
    Open;
    rAux:= FieldByName('kilos').AsFloat;
    Close;
    if rAux = 0 then
    begin
      //No salidas asociadas al transito
      VErrorCode:= iecNoTransito;
      VErrorMsg:= ErrorMgs[VErrorCode];
    end
    else
    begin
      SQL.Clear;
      SQL.Add(' select empresa_sc empresa, centro_salida_sc centro, ');
      SQL.Add('        fecha_sc fecha_salida, n_Albaran_sc n_salida, ');
      SQL.Add('        sum(kilos_sl) kilos ');
      SQL.Add(' from frf_salidas_l, frf_salidas_c ');
      SQL.Add(' where empresa_sl = :empresa ');
      SQL.Add(' and nvl( centro_transito_sl, centro_origen_sl ) = :centro ');
      SQL.Add(' and ref_transitos_sl = :salida ');
      SQL.Add(' and ( fecha_transito_sl = :fecha or ');
      SQL.Add('       fecha_sl between :fechaini and  :fechafin ) ');
      SQL.Add(' and empresa_Sc = :empresa ');
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      SQL.Add(' and fecha_sc = fecha_sl ');
      SQL.Add(' and n_albaran_sc = n_albaran_sl ');
      SQL.Add(' group by 1,2,3,4 ');

      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('centro').AsString:= ACentroOrigen;
      ParamByName('salida').AsInteger:= ANumTransito;
      ParamByName('fecha').Asdate:= AFechaTransito;
      ParamByName('fechaIni').Asdate:= AFechaTransito - 30;
      ParamByName('fechaFin').Asdate:= AFechaTransito + 90;
      Open;
      while not eof do
      begin
        VKilos:= VKilos + fieldByName('kilos').AsFloat;
        Next;
      end;

      if bRoundTo( rAux, 2 ) <> bRoundTo( VKilos, 2 ) then
      begin
        VErrorCode:= iecNoSalidasTransito;
        VErrorMsg:= ErrorMgs[VErrorCode];
        Close;
      end
      else
      begin
        First;
        while not eof do
        begin
          if ValorarProductoSalida( AEmpresa, fieldByName('centro').AsString, AProducto,
                                              fieldByName('fecha_salida').AsDateTime,
                                              fieldByName('n_salida').AsInteger, ADefinitivo, ACostesAnteriores,
                                              rKilos, rImporte, rDescuento, rGastos, rAbonos, rEnvasado, rOtros,
                                              iError, sMsg ) then
          begin
            rAux:= qrySalTransitos.fieldByName('kilos').AsFloat;
            if rKilos <> 0 then
            begin
              VImporte:= VImporte + bRoundTo( ( rImporte *  rAux ) / rKilos, 2 );
              VDescuento:= VDescuento + bRoundTo( ( rDescuento *  rAux ) / rKilos, 2 );
              VGastos:= VGastos + bRoundTo( ( rGastos *  rAux ) / rKilos, 2 );
              VAbonos:= VAbonos + bRoundTo( ( rAbonos *  rAux ) / rKilos, 2 );
              VEnvasado:= VEnvasado + bRoundTo( ( rEnvasado *  rAux ) / rKilos, 2 );
              VOtros:= VOtros + bRoundTo( ( rOtros *  rAux ) / rKilos, 2 );
            end;
          end
          else
          begin
            if sRefError <> '' then
              VErrorMsg:= Trim( VErrorMsg + #13 +  #10 + ErrorMgs[iError] + ' -  ' + sRefError )
            else
              VErrorMsg:= Trim( VErrorMsg + #13 +  #10 + ErrorMgs[iError] );
          end;
          Next;
        end;
        Close;
      end;
    end;

    if ( VErrorMsg <> '' ) then
    begin
      VErrorCode:= iecNoSalidasTransito;
      VErrorMsg:= Trim( ErrorMgs[VErrorCode] + #13 +  #10 + VErrorMsg );
    end;
  end;

  Result:= VErrorCode = iecOK;
end;

function TDMValorarSal.ValorarProductoSalida( const AEmpresa, ACentroSalida, AProducto: string;
                                              const AFechaSalida: TDateTime; const ANumSalida: Integer;
                                              const ADefinitivo, ACostesAnteriores: Boolean;
                                              var VKilos, VImporte, VDescuento, VGastos, VAbonos, VEnvasado, VOtros : Real;
                                              var VErrorCode: Integer; var VErrorMsg: String ): Boolean;
begin
  sEmpresa:= AEmpresa;
  sCentroSalida:= ACentroSalida;
  sProducto:= AProducto;
  dFechaSalida:= AFechaSalida;
  iNumSalida:= ANumSalida;

  iErrorCode:= iecOK;
  sRefError:= '';
  rKilos:= 0;
  rImporte:= 0;
  rDescuento:= 0;
  rGasto:= 0;
  rAbonos:= 0;
  rEnvasado:= 0;
  rOtros:= 0;

  Result:= False;
  if HaySalidas then
  begin
    if ProductoBase then
    begin
      Result:= ValorarLineas( ADefinitivo, ACostesAnteriores );
    end;
  end;

  VErrorCode:= iErrorCode;
  if sRefError <> '' then
    VErrorMsg:= ErrorMgs[iErrorCode] + ' -  ' + sRefError
  else
    VErrorMsg:= ErrorMgs[iErrorCode];
  VKilos:= rKilos;
  VImporte:= rImporte;
  VDescuento:= rDescuento;
  VGastos:= rGasto;
  VAbonos:= rAbonos;
  VEnvasado:= rEnvasado;
  VOtros:= rOtros;
end;

function TDMValorarSal.HaySalidas: Boolean;
begin
  with qrySalidasCab do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centroSalida').AsString:= sCentroSalida;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaSalida').AsDateTime:= dFechaSalida;
    ParamByName('numSalida').AsInteger:= iNumSalida;
    Open;
    if IsEmpty then
    begin
      Close;
      iErrorCode:= iecNoSalida;
      Result:= False;
    end
    else
    begin
      if FieldByName('kilos_prod_sc').AsFloat = 0 then
      begin
        Close;
        iErrorCode:= iecNoProducto;
        Result:= False;
      end
      else
      begin
        sClienteSalida:= FieldByName('cliente_fac_sc').AsString;
        sMonedaSalida:= FieldByName('moneda_sc').AsString;
        rkilos_total:= FieldByName('kilos_sc').AsFloat;
        rimporte_total:= FieldByName('importe_sc').AsFloat;
        rkilos_prod:= FieldByName('kilos_prod_sc').AsFloat;
        rimporte_prod:= FieldByName('importe_prod_sc').AsFloat;
        rkilos_tran:= FieldByName('kilos_tran_sc').AsFloat;
        rimporte_tran:= FieldByName('importe_tran_sc').AsFloat;
        rkilos_prod_tran:= FieldByName('kilos_prod_tran_sc').AsFloat;
        rimporte_prod_tran:= FieldByName('kilos_prod_tran_sc').AsFloat;
        icajas_total:= FieldByName('cajas_sc').AsInteger;
        ipalets_total:= FieldByName('palets_sc').AsInteger;
        icajas_prod:= FieldByName('cajas_prod_sc').AsInteger;
        ipalets_prod:= FieldByName('palets_prod_sc').AsInteger;
        icajas_tran:= FieldByName('cajas_tran_sc').AsInteger;
        ipalets_tran:= FieldByName('palets_tran_sc').AsInteger;
        icajas_prod_tran:= FieldByName('cajas_prod_tran_sc').AsInteger;
        ipalets_prod_tran:= FieldByName('palets_prod_tran_sc').AsInteger;
        Close;
        Result:= True;
      end;
    end;
  end;
end;

function TDMValorarSal.AbonosSalida: real;
begin
  qryAbonos.ParamByName('empresa').AsString:= sEmpresa;
  qryAbonos.ParamByName('centroSalida').AsString:= sCentroSalida;
  qryAbonos.ParamByName('producto').AsString:= sProducto;
  qryAbonos.ParamByName('fechaSalida').AsDateTime:= dFechaSalida;
  qryAbonos.ParamByName('numSalida').AsInteger:= iNumSalida;
  qryAbonos.Open;
  Result:= qryAbonos.FieldByName('importe_fal').AsFloat;
  qryAbonos.Close;
end;

procedure TDMValorarSal.AbreGastos;
begin
  if qryGastos.Active then
    qryGastos.Close;
  qryGastos.ParamByName('empresa').AsString:= sEmpresa;
  qryGastos.ParamByName('centroSalida').AsString:= sCentroSalida;
  qryGastos.ParamByName('producto').AsString:= sProducto;
  qryGastos.ParamByName('fechaSalida').AsDateTime:= dFechaSalida;
  qryGastos.ParamByName('numSalida').AsInteger:= iNumSalida;
  qryGastos.Open;
end;

procedure TDMValorarSal.CierraGastos;
begin
  qryGastos.Close;
end;

function TDMValorarSal.GastoTodos: Real;
var
  rGastoAux, rLineaAux, rAlbaranAux: Real;
begin
  rGastoAux:= qryGastos.FieldByName('importe_g').AsFloat;
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'K' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('kilos_sl').AsFloat;
    rAlbaranAux:= rkilos_total;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'P' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('palets_sl').AsFloat;
    rAlbaranAux:= ipalets_total;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'C' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('cajas_sl').AsFloat;
    rAlbaranAux:= icajas_total;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'I' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('importe_sl').AsFloat;
    rAlbaranAux:= rimporte_total;
  end;
  if rAlbaranAux > 0 then
  begin
    Result:= bRoundTo( ( rGastoAux * rLineaAux ) / rAlbaranAux, 2 );
  end
  else
  begin
    Result:= 0;
  end;
end;

function TDMValorarSal.GastoProducto: Real;
var
  rGastoAux, rLineaAux, rAlbaranAux: Real;
begin
  rGastoAux:= qryGastos.FieldByName('importe_g').AsFloat;
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'K' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('kilos_sl').AsFloat;
    rAlbaranAux:= rkilos_prod;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'P' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('palets_sl').AsFloat;
    rAlbaranAux:= ipalets_prod;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'C' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('cajas_sl').AsFloat;
    rAlbaranAux:= icajas_prod;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'I' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('importe_sl').AsFloat;
    rAlbaranAux:= rimporte_prod;
  end;
  if rAlbaranAux > 0 then
  begin
    Result:= bRoundTo( ( rGastoAux * rLineaAux ) / rAlbaranAux, 2 );
  end
  else
  begin
    Result:= 0;
  end;
end;

function TDMValorarSal.GastoTransitoTodos: Real;
var
  rGastoAux, rLineaAux, rAlbaranAux: Real;
begin
  rGastoAux:= qryGastos.FieldByName('importe_g').AsFloat;
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'K' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('kilos_sl').AsFloat;
    rAlbaranAux:= rkilos_tran;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'P' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('palets_sl').AsFloat;
    rAlbaranAux:= ipalets_tran;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'C' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('cajas_sl').AsFloat;
    rAlbaranAux:= icajas_tran;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'I' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('importe_sl').AsFloat;
    rAlbaranAux:= rimporte_tran;
  end;
  if rAlbaranAux > 0 then
  begin
    Result:= bRoundTo( ( rGastoAux * rLineaAux ) / rAlbaranAux, 2 );
  end
  else
  begin
    Result:= 0;
  end;
end;

function TDMValorarSal.GastoTransitoProducto: Real;
var
  rGastoAux, rLineaAux, rAlbaranAux: Real;
begin
  rGastoAux:= qryGastos.FieldByName('importe_g').AsFloat;
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'K' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('kilos_sl').AsFloat;
    rAlbaranAux:= rkilos_prod_tran;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'P' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('palets_sl').AsFloat;
    rAlbaranAux:= ipalets_prod_tran;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'C' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('cajas_sl').AsFloat;
    rAlbaranAux:= icajas_prod_tran;
  end
  else
  if qryGastos.FieldByName('unidad_dist_tg').AsString = 'I' then
  begin
    rLineaAux:= qrySalidasDet.FieldByName('importe_sl').AsFloat;
    rAlbaranAux:= rimporte_prod_tran;
  end;
  if rAlbaranAux > 0 then
  begin
    Result:= bRoundTo( ( rGastoAux * rLineaAux ) / rAlbaranAux, 2 );
  end
  else
  begin
    Result:= 0;
  end;
end;


function TDMValorarSal.GastosLinea: real;
begin
  Result:= 0;
  with qryGastos do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('gasto_transito_tg').AsInteger = 1 then
      begin
        //Solo se aplica si la linea proviene de un transito
        if qrySalidasDet.FieldByName('transito_sl').AsInteger = 1 then
        begin
          if  FieldByName('producto_g').AsString = '' then
          begin
            //Si no tiene producto se aplica a todos transitos
            Result:= Result + GastoTransitoTodos;
          end
          else
          if  FieldByName('producto_g').AsString = sProducto then
          begin
            //si no tiene que coincidir producto
            Result:= Result + GastoTransitoProducto;
          end;
        end;
      end
      else
      begin
        if  FieldByName('producto_g').AsString = '' then
        begin
          //Si no tiene producto se aplica a todos
          Result:= Result + GastoTodos;
        end
        else
        if  FieldByName('producto_g').AsString = sProducto then
        begin
          //si no tiene que coincidir producto
          Result:= Result + GastoProducto;
        end;
      end;
      Next;
    end;
  end;
end;

function TDMValorarSal.ValorarLineas( const ADefinitivo, ACostesAnteriores: Boolean ): boolean;
var
  rAux: Real;
begin
  Result:= True;
  PutComision;
  PutDescuento;
  CambioMoneda;
  AbreGastos;

  with qrySalidasDet do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centroSalida').AsString:= sCentroSalida;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaSalida').AsDateTime:= dFechaSalida;
    ParamByName('numSalida').AsInteger:= iNumSalida;
    Open;
    while not Eof and Result do
    begin
      if CosteEnvasado( ADefinitivo, ACostesAnteriores ) then
      begin
        if OtrosCostes then
        begin
          rKilos:= rKilos + FieldByname('kilos_sl').AsFloat;
          //Importe albaran, pasar a euros
          rAux:= bRoundTo( ( FieldByname('importe_sl').AsFloat * rFactorCambio ), 2);
          rImporte:= rImporte + rAux;

          //Comision y descuento
          rDescuento:= rDescuento + bRoundTo( (
                         ( rAux - bRoundTo( ( rAux * rFactorComision ) / 100, 2) )
                         * rFactorDescuento ) / 100, 2 );

          //Gastos, pasar a euros
          rAux:= GastosLinea;
          rGasto:= rGasto + rAux;

          //Coste envasado
          rEnvasado:= rEnvasado + bRoundTo( ( FieldByname('kilos_sl').AsFloat * rCosteEnvasado ), 2 );

          //Otros costes
          rOtros:= rOtros + bRoundTo( ( FieldByname('kilos_sl').AsFloat * rOtrosCostes ), 2 );
        end
        else
        begin
          iErrorCode:= iecNoCostesIndirectos;
          Result:= False;
        end;
      end
      else
      begin
        if ADefinitivo then
          iErrorCode:= iecNoCosteEnvasadoMes
        else
          iErrorCode:= iecNoCosteEnvasado;
        Result:= False;
      end;
      Next;
    end;
    //Abonos,
    (*TODO*)//¿pasar a euros?
    rAux:= AbonosSalida;
    rAbonos:= rAbonos + rAux;
    Close;
  end;
  CierraGastos;
end;

function TDMValorarSal.ProductoBase: boolean;
begin
  qryProductoBase.ParamByName('empresa').AsString:= sEmpresa;
  qryProductoBase.ParamByName('producto').AsString:= sProducto;
  qryProductoBase.Open;
  if not qryProductoBase.IsEmpty then
  begin
    iProductoBase:= qryProductoBase.FieldByName('producto_base_p').AsInteger;
    result:= True;
  end
  else
  begin
    iErrorCode:= iecNoProductoBase;
    result:= False;
  end;
  qryProductoBase.Close;
end;

procedure TDMValorarSal.CambioMoneda;
begin
  if sMonedaSalida = 'EUR' then
  begin
    rFactorCambio:= 1;
  end
  else
  begin
    qryCambioFactura.ParamByName('empresa').AsString:= sEmpresa;
    qryCambioFactura.ParamByName('centroSalida').AsString:= sCentroSalida;
    qryCambioFactura.ParamByName('fechaSalida').AsDateTime:= dFechaSalida;
    qryCambioFactura.ParamByName('numSalida').AsInteger:= iNumSalida;
    qryCambioFactura.Open;
    if not qryCambioFactura.IsEmpty then
    begin
      if qryCambioFactura.FieldByName('importe_total_f').AsFloat <> 0 then
        rFactorCambio:= bRoundTo( qryCambioFactura.FieldByName('importe_euros_f').AsFloat/
                                  qryCambioFactura.FieldByName('importe_total_f').AsFloat, 5);
    end
    else
    begin
      qryCambioAlbaran.ParamByName('monedaSalida').AsString:= sMonedaSalida;
      qryCambioAlbaran.ParamByName('fechaSalida').AsDateTime:= dFechaSalida;
      qryCambioAlbaran.Open;
      if qryCambioAlbaran.FieldByName('cambio_ce').AsFloat <> 0 then
        rFactorCambio:= bRoundTo( 1/qryCambioAlbaran.FieldByName('cambio_ce').AsFloat, 5);
      qryCambioAlbaran.Close;
    end;
    qryCambioFactura.Close;
  end;
end;

procedure TDMValorarSal.PutComision;
begin
  with qryComision do
  begin
    ParamByName('clienteSalida').AsString:= sClienteSalida;
    ParamByName('fechaSalida').AsDateTime:= dFechaSalida;
    Open;
    rFactorComision:= FieldByName('comision_rc').AsFloat;
    Close;
  end;
end;

procedure TDMValorarSal.PutDescuento;
begin
  with qryDescuento do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('clienteSalida').AsString:= sClienteSalida;
    ParamByName('fechaSalida').AsDateTime:= dFechaSalida;
    Open;
    rFactorDescuento:= FieldByName('descuento_cd').AsFloat;
    Close;
  end;
end;

function TDMValorarSal.CosteEnvasado( const ADefinitivo, ACostesAnteriores: boolean ):boolean;
var
  iYear, iMonth, iday: Word;
begin
  with qryCosteEnvasado do
  begin
    DecodeDate(dFechaSalida, iYear, iMonth, iday );
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centroSalida').AsString:= sCentroSalida;
    ParamByName('anyomesSalida').AsInteger:= ( iYear * 100 ) + iMonth;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('envase').AsString:= qrySalidasDet.FieldByName('envase_sl').AsString;

    Open;
    result:= not IsEmpty;

    if not Result then
    begin
      sRefError:= sEmpresa + '/' + sCentroSalida + '/' + qrySalidasDet.FieldByName('envase_sl').AsString;
    end
    else
    begin
      if ADefinitivo and ( not ACostesAnteriores) then
      begin
        if ( FieldByName('anyo_ec').AsInteger = iYear ) and ( FieldByName('mes_ec').AsInteger = iMonth )  then
        begin
          rCosteEnvasado:= FieldByName('coste_envasado').AsFloat;
        end
        else
        begin
          result:= False;
          sRefError:= sEmpresa + '/' + sCentroSalida + '/' +  IntToStr( ( iYear * 100 ) + iMonth ) + '/' + qrySalidasDet.FieldByName('envase_sl').AsString + ' (Empresa/Centro/AñoMes/Envase)';
          rCosteEnvasado:= 0;
        end;
      end
      else
      begin
        rCosteEnvasado:= FieldByName('coste_envasado').AsFloat;
      end;
    end;
    Close;
  end;
end;

function TDMValorarSal.OtrosCostes: Boolean;
begin
  with qryOtrosCostes do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centroOrigen').AsString:= qrySalidasDet.FieldByName('centro_origen_sl').AsString;
    ParamByName('fechaSalida').AsDateTime:= dFechaSalida;
    Open;
    result:= not IsEmpty;
    if not Result then
      sRefError:= sEmpresa + '/' + qrySalidasDet.FieldByName('centro_origen_sl').AsString + '/' + DateToStr( dFechaSalida );
    rOtrosCostes:= FieldByName('coste_indirecto').AsFloat;
    Close;
  end;
end;

end.
