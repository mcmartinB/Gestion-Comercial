unit CFactura;

interface

uses DB, UDFactura, DBTables;

function EstaContabilizada(empresa, serie, factura, fecha: string): boolean;
procedure PreparaFacturacion(ARepFactura: Boolean);
function CabeceraFactura(ARepFactura:boolean): boolean;

procedure CalculoImportesTotales(ARepFactura: Boolean);
function DescripcionProducto : string;
function DescripcionEnvase(Empresa, Producto, Envase, Cliente: string) : string;
function DesEnvCli(Empresa, Producto, Envase, Cliente: string) : String;
function GetProductoBase(const Empresa, Producto: string): string;
function GetPorcentajeComision( const ARepresentante: string;
                                const AFechaFactura: TDateTime ): real;
function GetPorcentajeDescuento( const AEmpresa, ACliente, ACentro, AProducto : string;
                                 const AFechaFactura: TDateTime ): Real;
function GetEurosKg( const AEmpresa, ACliente, ACentro, AProducto : string;
                     const AFechaFactura: TDateTime ): Real;
function GetEurosPale( const AEmpresa, ACliente, ACentro, AProducto : string;
                       const AFechaFactura: TDateTime ): Real;
function GetDescripcionIva( const Codigo: string): String;
function EsClienteSeguro(const AEmpresa, ACliente: string): boolean;
function ClienteConRecargo(const AEmpresa, ACliente: string; const AFecha: TDateTime ): boolean;
procedure ComprobarRiesgoCliente( const AEmpresa, ACliente: string );

function ExisteFacturaPerdida(empresa, serie:string; factura:integer; fecha:string):boolean;
function ErrorFacturaPerdida(empresa, serie:string; factura:integer; fecha, tipo, tipofactura:string):boolean;
function ValidarFecFactPerdidas(empresa, serie:string; factura: integer; fecha, tipo, tipofactura: string): boolean;

procedure CloseQuery(AQuery: TDataSet);
procedure CloseQuerys(AQuerys: array of TDataSet);

procedure LimpiarTemporales;

function ExisteSerie(const AEmpresa, ASerie, AFechaFactura: String): boolean;
function ExisteSerieG(const ASerie: String): boolean;

implementation

uses SysUtils, Dialogs, DError, UDMBaseDatos, UDMAuxDB, UDMCambioMoneda, bMath, DConfigMail, BonnyQuery;


function EstaContabilizada(empresa, serie, factura, fecha: string): boolean;
begin
  with DFactura.QAux do begin
    ConsultaOpen(DFactura.QAux, ' select cod_empresa_fac_fc, n_factura_fc, fecha_factura_fc, contabilizado_fc from tfacturas_cab ' +
      ' where cod_empresa_fac_fc=' + QuotedStr(empresa) + ' ' +
      ' and cod_serie_fac_fc=' + QuotedStr(serie) + ' ' +
      ' and n_factura_fc=' + factura + ' ' +
      ' and fecha_factura_fc=' + QuotedStr(fecha) + ' ', False, False);
    EstaContabilizada := DFactura.QAux.Fields[3].AsInteger = 1;
    DFactura.QAux.Cancel;
    DFactura.QAux.Close;
  end;
end;

//Rellenamos tabla temporal cabecera
function CabeceraFactura(ARepFactura: Boolean): boolean;
begin
  RellenaMemCabeceraFacturas(ARepFactura);

  if DFactura.mtFacturas_Cab.RecordCount = 0 then
  begin
    ShowMessage(' No existen facturas para los datos introducidos, o la factura ya ha sido contabilizada. ');
    CabeceraFactura := false;
    Exit;
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
    ParamByName('empresa').AsString:= DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString;
    ParamByName('centro').AsString:= DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString;
    ParamByName('albaran').AsString:= DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsString;
    ParamByName('fecha').AsString:= DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsString;
    Open;
    try
      result:= FieldByName('nota_factura_sc').AsString;
    finally
      Close;
    end;
  end;
end;

function GetNotaFactura : string;
var sEmpresa, sCentro, sAlbaran, sFecha: string;
begin
  result:= '';
  sEmpresa := '';
  sCentro := '';
  sAlbaran := '';
  sFecha := '';
  with DFactura.mtFacturas_Det do
  begin
    Filter := ' fac_interno_fd = ' + QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').AsString);
    Filtered := True;

    First;
    while not Eof do
    begin
      if (sEmpresa = '') or (sEmpresa <> FieldByName('cod_empresa_albaran_fd').AsString) or
         (sCentro <> FieldByName('cod_centro_albaran_fd').AsString) or
         (sAlbaran <> FieldByName('n_albaran_fd').AsString) or
         (sFecha <> FieldByName('fecha_albaran_fd').AsString) then
      begin
        if result <> '' then
          result:= result + #13 + #10;
        result:= result + GetNotaFacturaAux;
      end;
      sEmpresa := FieldByName('cod_empresa_albaran_fd').AsString;
      sCentro := FieldByName('cod_centro_albaran_fd').AsString;
      sAlbaran := FieldByName('n_albaran_fd').AsString;
      sFecha := FieldByName('fecha_albaran_fd').AsString;
      Next;
    end;

    Filter := '';
    Filtered := False;
  end;
end;

procedure NotaFactura;
var
  sAux: String;
begin

  sAux := '';
  with DFactura.mtFacturas_Cab do
  begin
    First;
    while not DFactura.mtFacturas_Cab.Eof do
    begin
      sAux := GetNotaFactura;
      if length( sAux ) > 512 then
        sAux:= copy( sAux, 1, 512 ) + #13 + #10 + '...';

      if Trim( sAux ) <> '' then
      begin
        Edit;
        FieldByName('notas_fc').AsString:= sAux;
        Post;
      end;
      DFactura.mtFacturas_Cab.Next;
    end;
  end;

end;

//Rellenamos tabla temporal gastos
function GastosFactura(ARepFactura: Boolean): boolean;
var sEmpresa, sCentro, sAlbaran, sFecha: string;
begin
  sEmpresa := '';
  sCentro := '';
  sAlbaran := '';
  sFecha := '';
  with DFactura.mtFacturas_Det do
  begin
    First;
    while not Eof do
    begin
      if (sEmpresa = '') or (sEmpresa <> FieldByName('cod_empresa_albaran_fd').AsString) or
         (sCentro <> FieldByName('cod_centro_albaran_fd').AsString) or
         (sAlbaran <> FieldByName('n_albaran_fd').AsString) or
         (sFecha <> FieldByName('fecha_albaran_fd').AsString) then
      begin
        with DFactura.QGeneral do
        begin
          if Active then
          begin
            Cancel;
            Close;
          end;

          SQL.Clear;
          SQL.Add('SELECT DISTINCT empresa_g, centro_salida_g, n_albaran_g,');
          SQL.Add('                fecha_g,tipo_g,descripcion_tg,importe_g, ');
          SQL.Add('                tipo_iva_tg, ');
          SQL.Add('      case when exists ( select * ');
          SQL.Add('                           from frf_impuestos_recargo_cli ');
          SQL.Add('                           where empresa_irc = :empresa ');
          SQL.Add('                           and cliente_irc = :cliente ');
          SQL.Add('                           and fecha_g  between fecha_ini_irc and case when fecha_fin_irc is null then fecha_g else fecha_fin_irc end ) ');

          SQL.Add('             then ( select case when tipo_iva_tg = 0 then super_il  +  recargo_super_il ');
          SQL.Add('                                when tipo_iva_tg = 1 then reducido_il + recargo_reducido_il ');
          SQL.Add('                                when tipo_iva_tg = 2 then general_il + recargo_general_il ');
          SQL.Add('                                else 0 ');
          SQL.Add('                           end ');
          SQL.Add('                    from frf_impuestos_l ');
          SQL.Add('                    where codigo_il= :tipo_iva ');
          SQL.Add('                    and fecha_g  between fecha_ini_il and case when fecha_fin_il is null then fecha_g else fecha_fin_il end ) ');

          SQL.Add('             else ( select case when tipo_iva_tg = 0 then super_il ');
          SQL.Add('                                when tipo_iva_tg = 1 then reducido_il ');
          SQL.Add('                                when tipo_iva_tg = 2 then general_il ');
          SQL.Add('                                else 0 ');
          SQL.Add('                           end ');
          SQL.Add('                    from frf_impuestos_l ');
          SQL.Add('                    where codigo_il= :tipo_iva ');
          SQL.Add('                    and fecha_g  between fecha_ini_il and case when fecha_fin_il is null then fecha_g else fecha_fin_il end ) ');
          SQL.Add('        end porcentaje_iva');

          SQL.Add('FROM frf_gastos, frf_tipo_gastos ');
          SQL.Add('WHERE empresa_g = :empresa ');
          SQL.Add('AND centro_salida_g = :centro ');
          SQL.Add('AND n_albaran_g = :albaran  ');
          SQL.Add('AND fecha_g = :fecha');
          SQL.Add('AND tipo_g=tipo_tg ');
          SQL.Add('AND facturable_tg="S" ');

          ParamByName('empresa').AsString := DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString;
          ParamByName('centro').AsString := DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString;
          ParamByName('albaran').AsInteger := DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsInteger;
          ParamByName('fecha').AsDateTime := DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsDateTime;
          ParamByName('cliente').AsString := DFactura.mtFacturas_Det.FieldByName('cod_cliente_fac_fd').AsString;
          ParamByName('tipo_iva').AsString := DFactura.mtFacturas_Det.FieldByName('tipo_iva_fd').AsString;

          try
            Open;
          except
            GastosFactura := false;
            Exit;
          end;

          RellenaMemGastosFacturas(ARepFactura);

        end;
      end;
      sEmpresa := FieldByName('cod_empresa_albaran_fd').AsString;
      sCentro := FieldByName('cod_centro_albaran_fd').AsString;
      sAlbaran := FieldByName('n_albaran_fd').AsString;
      sFecha := FieldByName('fecha_albaran_fd').AsString;
      Next;
    end;
  end;

//  DFactura.mtFacturas_Gas.SortOn('cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg', []);
  GastosFactura := true;
end;

procedure PreparaFacturacion(ARepFactura: Boolean);
begin

   //Rellenamos tabla temporal cabecera mtFacturas_Cab
  if not CabeceraFactura(ARepFactura) then
  begin
    LimpiarTemporales;
    raise Exception.Create('Imposible obtener datos para la facturacion');
  end;

    //Observaciones de la factura
  NotaFactura;

    //Rellenamos tabla temporal gastos  mtFacturas_Gas
  if not GastosFactura(ARepFactura) then
  begin
    LimpiarTemporales;
    raise Exception.Create('Imposible obtener datos para la facturacion');
  end;

     //Calculo importes totales y rellenamos tabla temporal bases mtFacturas_Bas
  CalculoImportesTotales(ARepFactura);
end;

procedure CalculoImportesTotales(ARepFactura: Boolean);
var rImporteLinea, rImporteDescuento,
    rImporteNeto, rImporteImpuesto, rImporteTotal,
    rImporteNetoEuros, rImporteImpuestoEuros, rImporteTotalEuros: real;
    i, iBases: integer;
    flag: boolean;
    RImpBases: TRImpBases;
begin

  with DFactura.mtFacturas_Cab do
  begin
    First;
    while not Eof do
    begin

      iBases := 0;

        //INICIALIZAMOS BASES DETALLE
      DFactura.mtFacturas_Det.Filter := ' fac_interno_fd = ' + QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').AsString);
      DFactura.mtFacturas_Det.Filtered := True;

      DFactura.mtFacturas_Det.First;
      while not DFactura.mtFacturas_Det.Eof do
      begin
        i:= 0;
        flag:= False;
        while ( i < iBases ) and ( not flag ) do
        begin
          if DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsFloat =  RImpBases.aRImportes[i].rPorcentajeImpuesto then
            flag:= True
          else
            inc(i);
        end;
        if not flag then
        begin
          SetLength( RImpBases.aRImportes, iBases + 1);
          RImpBases.aRImportes[iBases].rPorcentajeImpuesto:= DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsFloat;
          RImpBases.aRImportes[iBases].iTasaImpuesto:= DFactura.mtFacturas_Det.FieldByName('tasa_impuesto_fd').AsInteger;
          RImpBases.aRImportes[i].iCajas := 0;
          RImpBases.aRImportes[i].iUnidades := 0;
          RImpBases.aRImportes[i].rKilos := 0;
          RImpBases.aRImportes[i].rImporteNeto:= 0;
          RImpBases.aRImportes[i].rImporteImpuesto:= 0;
          RImpBases.aRImportes[i].rImporteTotal:= 0;
          iBases:= iBases + 1;
        end;

        DFactura.mtFacturas_Det.Next;
      end;
      DFactura.mtFacturas_Det.Filter := '';
      DFactura.mtFacturas_Det.Filtered := False;

        //INICIALIZAMOS BASES GASTOS
      DFactura.mtFacturas_Gas.Filter := ' fac_interno_fg = ' + QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').AsString);
      DFactura.mtFacturas_Gas.Filtered := True;

      DFactura.mtFacturas_Gas.First;
      while not DFactura.mtFacturas_Gas.Eof do
      begin
        i:= 0;
        flag:= False;
        while ( i < iBases ) and ( not flag ) do
        begin
          if DFactura.mtFacturas_gas.FieldByName('porcentaje_impuesto_fg').AsFloat =  RImpBases.aRImportes[i].rPorcentajeImpuesto then
            flag:= True
          else
            inc(i);
        end;
        if not flag then
        begin
          SetLength( RImpBases.aRImportes, iBases + 1);

          RImpBases.aRImportes[iBases].rPorcentajeImpuesto:= DFactura.mtFacturas_Gas.FieldByName('porcentaje_impuesto_fg').AsFloat;
          RImpBases.aRImportes[iBases].iTasaImpuesto:= DFactura.mtFacturas_Gas.FieldByName('tasa_impuesto_fg').AsInteger;
          RImpBases.aRImportes[i].iCajas := 0;
          RImpBases.aRImportes[i].iUnidades := 0;
          RImpBases.aRImportes[i].rKilos := 0;
          RImpBases.aRImportes[i].rImporteNeto:= 0;
          RImpBases.aRImportes[i].rImporteImpuesto:= 0;
          RImpBases.aRImportes[i].rImporteTotal:= 0;
          iBases:= iBases + 1;
        end;

        DFactura.mtFacturas_Gas.Next;
      end;
      DFactura.mtFacturas_Gas.Filter := '';
      DFactura.mtFacturas_Gas.Filtered := False;

        //Detalle Linea
      DFactura.mtFacturas_Det.First;
      with DFactura.mtFacturas_Det do
      begin
        Filter := ' fac_interno_fd = ' + QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').AsString);
        Filtered := True;

        rImporteLinea := 0;
        rImporteDescuento := 0;
        rImporteNeto := 0;
        rImporteImpuesto := 0;
        rImporteTotal := 0;
        rImporteNetoEuros := 0;
        rImporteImpuestoEuros := 0;
        rImporteTotalEuros := 0;

        First;
        while not Eof do
        begin
           // CALCULOS BASES
          i := 0;
          while i< iBases do
          begin
            if DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsFloat = RImpBases.aRImportes[i].rPorcentajeImpuesto then
            begin
              if ARepFactura then
                RImpBases.aRImportes[i].sCodFactura := DFactura.mtFacturas_Det.Fieldbyname('cod_factura_fd').AsString;

              RImpBases.aRImportes[i].sEmpresa := DFactura.mtFacturas_Det.FieldByName('cod_empresa_fac_fd').AsString;
              RImpBases.aRImportes[i].sFecha := DFactura.mtFacturas_Det.FieldByName('fecha_fac_fd').AsString;
              RImpBases.aRImportes[i].sNumero := DFactura.mtFacturas_Det.FieldByName('fac_interno_fd').AsString;

              RImpBases.aRImportes[i].iCajas := RImpBases.aRImportes[i].iCajas +
                                                DFactura.mtFacturas_Det.FieldByName('cajas_fd').AsInteger;
              RImpBases.aRImportes[i].iUnidades := RImpBases.aRImportes[i].iUnidades +
                                                   DFactura.mtFacturas_Det.FieldByName('unidades_fd').AsInteger;
              RImpBases.aRImportes[i].rKilos := RImpBases.aRImportes[i].rKilos +
                                                DFactura.mtFacturas_Det.FieldByName('kilos_fd').AsFloat;
              RImpBases.aRImportes[i].rImporteNeto := RImpBases.aRImportes[i].rImporteNeto +
                                                      DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat;
              //RImpBases.aRImportes[i].rImporteImpuesto := RImpBases.aRImportes[i].rImporteImpuesto +
              //                                            DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat;
              //RImpBases.aRImportes[i].rImporteTotal := RImpBases.aRImportes[i].rImporteTotal +
              //                                         DFactura.mtFacturas_Det.FieldByName('importe_total_fd').AsFloat;
              Break;
            end;
            Inc(i)
          end;
          rImporteLinea := rImporteLinea + FieldByName('importe_linea_fd').AsFloat;
          rImporteDescuento := rImporteDescuento + FieldByName('importe_total_descuento_fd').AsFloat;
          rImporteNeto := rImporteNeto + FieldByName('importe_neto_fd').AsFloat;
          //rImporteImpuesto := rImporteImpuesto + FieldByName('importe_impuesto_fd').AsFloat;
          //rImporteTotal := rImporteTotal + FieldByName('importe_total_fd').AsFloat;
          Next;
        end;

        Filter := '';
        Filtered := False;
      end;




      //Gastos
      with DFactura.mtFacturas_Gas do
      begin
        Filter := ' fac_interno_fg = ' + QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').AsString);
        Filtered := True;

        First;
        while not Eof do
        begin
            // CALCULOS BASES
          i:=0;
          while i<iBases do
          begin
            if DFactura.mtFacturas_Gas.FieldByName('porcentaje_impuesto_fg').AsFloat = RImpBases.aRImportes[i].rPorcentajeImpuesto then
            begin
              if ARepFactura then
                RImpBases.aRImportes[i].sCodFactura := DFactura.mtFacturas_Gas.Fieldbyname('cod_factura_fg').AsString;

              RImpBases.aRImportes[i].sEmpresa := DFactura.mtFacturas_Gas.FieldByName('cod_empresa_fac_fg').AsString;
              RImpBases.aRImportes[i].sFecha := DFactura.mtFacturas_Gas.FieldByName('fecha_fac_fg').AsString;
              RImpBases.aRImportes[i].sNumero := DFactura.mtFacturas_Gas.FieldByName('fac_interno_fg').AsString;

              RImpBases.aRImportes[i].rImporteNeto := RImpBases.aRImportes[i].rImporteNeto +
                                                      DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsFloat;
              //RImpBases.aRImportes[i].rImporteImpuesto := RImpBases.aRImportes[i].rImporteImpuesto +
              //                                            DFactura.mtFacturas_Gas.FieldByName('importe_impuesto_fg').AsFloat;
              //RImpBases.aRImportes[i].rImporteTotal := RImpBases.aRImportes[i].rImporteTotal +
              //                                         DFactura.mtFacturas_Gas.FieldByName('importe_total_fg').AsFloat;
              Break;
            end;
            Inc(i)
          end;

          rImporteNeto := rImporteNeto + FieldByName('importe_neto_fg').AsFloat;
          //rImporteImpuesto := rImporteImpuesto + FieldByName('importe_impuesto_fg').AsFloat;
          //rImporteTotal := rImporteTotal + FieldByName('importe_total_fg').AsFloat;
          Next;
        end;

        Filter := '';
        Filtered := False;
      end;

          //Totales impuestos segun bases
          i := 0;
          while i< iBases do
          begin
            RImpBases.aRImportes[i].rImporteImpuesto := broundTo( RImpBases.aRImportes[i].rImporteNeto  * RImpBases.aRImportes[i].rPorcentajeImpuesto/100, 2);
            RImpBases.aRImportes[i].rImporteTotal := RImpBases.aRImportes[i].rImporteNeto + RImpBases.aRImportes[i].rImporteImpuesto;

            rImporteImpuesto := rImporteImpuesto + RImpBases.aRImportes[i].rImporteImpuesto;
            rImporteTotal := rImporteTotal + RImpBases.aRImportes[i].rImporteTotal;
            Inc(i)
          end;

      if FieldByName('moneda_fc').AsString = 'EUR' then
      begin
        rImporteNetoEuros := rImporteNeto;
        rImporteImpuestoEuros := rImporteImpuesto;
        rImporteTotalEuros := rImporteTotal;
      end
      else
        try
          rImporteNetoEuros := ChangeToEuro( DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString,
                                             DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString,
                                             rImporteNeto);
          rImporteImpuestoEuros := ChangeToEuro( DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString,
                                                 DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString,
                                                 rImporteImpuesto);
          rImporteTotalEuros := ChangeToEuro( DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString,
                                              DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString,
                                              rImporteTotal);
          except
            ShowMessage('ERROR al calcular el cambio a Euros, comprobar que la moneda sea correcta.');
          end;

      RellenaMemBaseFacturas(ARepFactura, RImpBases);

      Edit;
      FieldByName('importe_linea_fc').AsFloat := rImporteLinea;
      FieldByName('importe_descuento_fc').AsFloat := rImporteDescuento;
      FieldByName('importe_neto_fc').AsFloat := rImporteNeto;
      FieldByName('importe_impuesto_fc').AsFloat := rImporteImpuesto;
      FieldByName('importe_total_fc').AsFloat := rImporteTotal;
      FieldByName('importe_neto_euros_fc').AsFloat := rImporteNetoEuros;
      FieldByName('importe_impuesto_euros_fc').AsFloat := rImporteImpuestoEuros;
      FieldByName('importe_total_euros_fc').AsFloat := rImporteTotalEuros;
      if FieldByName('importe_total_fc').AsFloat < 0 then
        FieldByName('tipo_factura_fc').AsString := '381';
      Post;

      Next;
    end;
  end;

end;

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
//  ProductoBase := GetProductoBase(Empresa, Producto);
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
    SQL.Add('    and producto_ce = :producto ');
    SQL.Add('    and envase_ce = :envase ');
    SQL.Add('    and cliente_ce = :cliente ');

    ParamByName('empresa').AsString := Empresa;
    ParamByName('producto').AsString := Producto;
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

function DesEnvCli(Empresa, Producto, Envase, Cliente: string) : String;
var DescripcionEnvase, ProductoBase: string;
    sPais: String;
begin
  DescripcionEnvase := '';
//  ProductoBase := GetProductoBase(Empresa, Producto);
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
    SQL.Add('    and producto_ce = :producto ');
    SQL.Add('    and envase_ce = :envase ');
    SQL.Add('    and cliente_ce = :cliente ');

    ParamByName('empresa').AsString := Empresa;
    ParamByName('producto').AsString := Producto;
    ParamByName('envase').AsString := Envase;
    ParamByName('cliente').AsString := Cliente;

    Open;

    if (IsEmpty) or (FieldByName('descripcion_ce').AsString = '') then
    begin
      with DFactura.QTemp do
      begin
        if Active then
        begin
          Cancel;
          Close;
        end;
        SQL.Clear;
        SQL.Add(' select pais_fac_c from frf_clientes ');
        SQL.Add('  where cliente_c = :cliente ');

        ParamByName('cliente').AsString := Cliente;

        Open;
        sPais := Fieldbyname('pais_fac_c').AsString;

        Close;

        SQL.Clear;
        SQL.Add(' select descripcion_e, descripcion2_e from frf_envases ');
        SQL.Add('  where envase_e = :envase ');

        ParambyName('envase').AsString := Envase;
        Open;

        if sPais = 'ES' then
        begin
          Result := DFactura.QTemp.FieldByName('descripcion_e').AsString;
        end
        else
        begin
          if DFactura.QTemp.FieldByName('descripcion2_e').AsString <> '' then
          begin
            Result := DFactura.QTemp.FieldByName('descripcion2_e').AsString;
          end
          else
          begin
            Result := DFactura.QTemp.FieldByName('descripcion_e').AsString;
          end;
        end;
      end;
    end
    else
      Result := FieldByname('descripcion_ce').AsString;

  end;
end;

function GetPorcentajeComision( const ARepresentante: string; const AFechaFactura: TDateTime ): real;
begin
  with DFactura.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select comision_rc  ');
    SQL.Add('   from frf_representantes_comision ');
    SQL.Add('  where representante_rc = :representante ');

    SQl.Add('    and :fechafactura >= fecha_ini_rc ');
    SQl.Add('    and ( fecha_fin_rc is null or :fechafactura <= fecha_fin_rc ) ');
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

  with DFactura.Qaux do
  begin
    SQL.Clear;
    SQL.Add(' execute procedure getdescuentoscliente ( ');
    SQL.Add('          :empresa, :cliente, :centro, :producto, :fecha, 1) ');

    Parambyname('empresa').asString := AEmpresa;
    Parambyname('cliente').asString := ACliente;
    ParamByName('centro').asString  := ACentro;
    ParamByName('producto').asString  := AProducto;
    ParamByName('fecha').asDateTime  := AFechaFactura;

    Open;

    Result := FieldByName('(expression)').AsCurrency;
  end;
{
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
}
end;

function GetEurosKg(const AEmpresa, ACliente, ACentro, AProducto: string; const AFechaFactura: TDateTime): real;
begin
  result := 0;

  with DFactura.QAux do
  begin
    SQL.Clear;
    SQL.Add(' execute procedure get_eurkg_descuentos ( ');
    SQL.Add('          :empresa, :cliente, :centro, :producto, :fecha, 1) ');

    Parambyname('empresa').asString := AEmpresa;
    Parambyname('cliente').asString := ACliente;
    ParamByName('centro').asString  := ACentro;
    ParamByName('producto').asString  := AProducto;
    ParamByName('fecha').asDateTime  := AFechaFactura;

    Open;

    Result := FieldByName('(expression)').AsCurrency;
  end;
end;

function GetEurosPale(const AEmpresa, ACliente, ACentro, AProducto: string; const AFechaFactura: TDateTime): real;
begin
  result := 0;

  with DFactura.QAux do
  begin
    SQL.Clear;
    SQL.Add(' execute procedure get_eurpale_descuentos ( ');
    SQL.Add('          :empresa, :cliente, :centro, :producto, :fecha, 1) ');

    Parambyname('empresa').asString := AEmpresa;
    Parambyname('cliente').asString := ACliente;
    ParamByName('centro').asString  := ACentro;
    ParamByName('producto').asString  := AProducto;
    ParamByName('fecha').asDateTime  := AFechaFactura;

    Open;

    Result := FieldByName('(expression)').AsCurrency;
  end;
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


procedure LimpiarTemporales;
begin
  if DFactura.mtFacturas_Cab.Active then
    DFactura.mtFacturas_Cab.Close;
  if DFactura.mtFacturas_Det.Active then
    DFactura.mtFacturas_Det.Close;
  if DFactura.mtFacturas_Gas.Active then
    DFactura.mtFacturas_Gas.Close;
  if DFactura.mtFacturas_Bas.Active then
    DFactura.mtFacturas_Bas.Close;
end;

function ExisteSerie( const AEmpresa, ASerie, AFechaFactura: string): boolean;
var myYear, myMonth, myDay : Word;
begin

  DecodeDate(StrToDate(AFechaFactura), myYear, myMonth, myDay);
  with DFactura.QAux  do
  begin
    SQL.Clear;

    SQL.Add(' select * ');
    SQL.Add('  from frf_empresas_serie ');
    SQL.Add(' where cod_empresa_es = :empresa ');
    SQL.Add('   and cod_serie_es = :serie ');
    SQL.Add('   and anyo_es = :ano ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('serie').AsString := ASerie;
    ParamByName('ano').AsInteger := myYear;

    Open;
    if IsEmpty then
      result := false
    else
      result := true;
  end;
end;
function ExisteSerieG( const ASerie: string): boolean;
var myYear, myMonth, myDay : Word;
begin

  with DFactura.QAux  do
  begin
    SQL.Clear;

    SQL.Add(' select * ');
    SQL.Add('  from frf_empresas_serie ');
    SQL.Add(' where cod_serie_es = :serie ');

    ParamByName('serie').AsString := ASerie;

    Open;
    if IsEmpty then
      result := false
    else
      result := true;
  end;
end;

function GetProductoBase(const Empresa, Producto: string): string;
begin
  with DFactura.Qaux  do
  begin
    SQL.Clear;

    SQL.Add(' select producto_base_p ');
    SQL.Add('  from frf_productos ');
    SQL.Add(' where producto_p = :producto ');

    ParamByName('producto').AsString := Producto;

    Open;
    if IsEmpty then
      result := ''
    else
      result := fieldbyname('producto_base_p').AsString;
  end;
end;

function GetDescripcionIva( const Codigo: string): String;
begin
  with DFactura.Qaux  do
  begin
    SQL.Clear;

    SQL.Add(' select descripcion_i ');
    SQL.Add('   from frf_impuestos ');
    SQL.Add('  where codigo_i= :codigo ');
    ParamByName('codigo').AsString := Codigo;

    Open;
    if IsEmpty then
      result := ''
    else
      result := fieldbyname('descripcion_i').AsString;
  end;
end;

function EsClienteSeguro(const AEmpresa, ACliente: string): boolean;
begin
  with DFactura.QAux do
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

function ClienteConRecargo(const AEmpresa, ACliente: string; const AFecha: TDateTime ): boolean;
begin
  with DFactura.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_impuestos_recargo_cli ');
    SQL.Add(' where empresa_irc = :empresa ');
    SQL.Add(' and cliente_irc = :cliente ');
    SQL.Add(' and recargo_irc <> 0 ');
    SQL.Add(' and :fecha  between fecha_ini_irc and case when fecha_fin_irc is null then :fecha else fecha_fin_irc end ');

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

procedure ComprobarRiesgoCliente(const AEmpresa, ACliente: string);
  var
  rRiesgo, rFacturado, rCobrado: real;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max_riesgo_cr max_riesgo_c from frf_clientes_rie ');
    SQL.Add('  where empresa_cr = :empresa ');
    SQL.Add('    and cliente_cr = :cliente ');
    SQL.Add('    and max_riesgo_cr is not null ');
    SQL.Add('    and fecha_fin_cr is null ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;
    if not IsEmpty then
    begin
      rRiesgo:= FieldByName('max_riesgo_c').AsFloat;
      Close;
      SQl.Clear;
      SQL.Add('select sum( importe_total_euros_fc ) importe from tfacturas_cab ');
      SQL.Add(' where cod_empresa_fac_fc = :empresa ');
      SQL.Add('   and cod_serie_fac_fc = :serie ');
      SQL.Add('   and cod_cliente_fc= :cliente ');
      SQL.Add('   and fecha_factura_fc between TODAY - 730 and TODAY  ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('cliente').AsString:= ACliente;
      Open;
      rFacturado:= FieldByName('importe').AsFloat;
      Close;
      SQl.Clear;
{
      SQL.Add(' select sum( euros(moneda_fc, fecha_factura_fc, importe_cobrado_fr) ) importe  ');
      SQL.Add(' from tfacturas_cab, frf_facturas_remesa  ');
      SQL.Add(' where cod_empresa_fac_fc = :empresa  and cod_cliente_fc = :cliente  ');
      if CGlobal.gProgramVersion = pvBAG then
        SQL.Add('   and planta_fr = :empresa  and factura_fr = n_factura_fc  and fecha_factura_fr = fecha_factura_fc  and fecha_remesa_fr <= TODAY  ')
      else
        SQL.Add('   and empresa_fr = :empresa  and factura_fr = n_factura_fc  and fecha_factura_fr = fecha_factura_fc  and fecha_remesa_fr <= TODAY  ');
}

      SQL.Add(' select SUM(euros(moneda_fc, fecha_factura_fc, importe_cobrado_rf)) importe ');
      SQL.Add('   from tremesas_cab, tremesas_fac, tfacturas_cab ');
      SQL.Add('  where empresa_remesa_rf = empresa_remesa_rc  ');
      SQL.Add('    and n_remesa_rf = n_remesa_rc  ');
      SQL.Add('    and cod_factura_rf = cod_factura_fc ');
      SQL.Add('    and fecha_vencimiento_rc between TODAY - 730 and TODAY  ');
      SQL.Add('    and cod_empresa_fac_fc = :empresa ');
      SQL.Add('    and cod_cliente_fc = :cliente  ');

      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('cliente').AsString:= ACliente;
      Open;

      rCobrado:= FieldByName('importe').AsFloat;
      Close;
      rRiesgo:= rRiesgo - rFacturado +  rCobrado;
      if rRiesgo < 0 then
      begin
        ShowError('Riesgo superado en ' + FormatFloat('#,##0.00', rRiesgo ) + '? para el cliente ' + ACliente + '.');
      end;
    end;
  end;
end;

function ExisteFacturaPerdida(empresa, serie: string; factura: integer; fecha: string): boolean;
var iYear, iMonth, iDay: word;
    QBusFactura: TBonnyQuery;
begin
  DecodeDate( StrToDateDef(fecha, Date), iYear, iMonth, iDay );

      // Comprobamos si existe numero de factura
  QBusFactura := TBonnyQuery.Create(nil);
  with QBusFactura do
  try
    SQL.Add(' select fecha_factura_fc from tfacturas_cab ');
    SQL.Add('  where cod_empresa_fac_fc = :empresa ');
    SQL.Add('    and cod_serie_fac_fc = :serie ');
    SQL.Add('    and YEAR(fecha_factura_fc) = :anyo ');
    SQL.Add('    and n_factura_fc = :factura ');

    ParamByName('empresa').AsString := empresa;
    ParamByName('serie').AsString := serie;
    ParamByName('anyo').AsInteger := iYear;
    ParamByName('factura').AsInteger := factura;
    Open;

    Result := (not isEmpty);

  finally
    Free;
  end;

end;

function ErrorFacturaPerdida(empresa, serie: string; factura: integer; fecha, tipo, tipofactura: string): boolean;
var
  iYear, iMonth, iDay: word;
  QContador: TBonnyQuery;
begin
  result := false;
  DecodeDate( StrToDateDef(fecha, Date), iYear, iMonth, iDay );
      // Obtenemos contador de factura para la serie
  QContador := TBonnyQuery.Create(nil);
  with QContador do
  try
    SQL.Add(' select fac_iva_fs, fac_igic_fs, abn_iva_fs, abn_igic_fs ');
    SQL.Add('   from frf_facturas_serie ');
    SQL.Add('   join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ');
    SQL.Add('  where cod_empresa_es = :empresa ');
    SQL.Add('    and cod_serie_es = :serie ');
    SQL.Add('    and anyo_es = :anyo ');

    ParamByName('empresa').AsString := empresa;
    ParamByName('serie').AsString := serie;
    ParamByName('anyo').AsInteger := iYear;
    Open;

    if tipo = 'I' then
    begin
      if tipofactura = '380' then
      begin
        if not((factura > 0) and (factura < FieldByName('fac_iva_fs').AsInteger)) then
          result := true;
      end
      else
      begin
        if not((factura > 300000) and (factura < FieldByName('abn_iva_fs').AsInteger)) then
          result := true;
      end;
    end;
    if (tipo = 'G') then
    begin
      if tipofactura = '380' then
      begin
        if not((factura > 200000) and (factura < FieldByName('fac_igic_fs').AsInteger)) then
          result := true;
      end
      else
      begin
        if not((factura > 400000) and (factura < FieldByName('abn_igic_fs').AsInteger)) then
          result := true;
      end;
    end;

  finally
    Free;
  end;
end;

function ValidarFecFactPerdidas(empresa, serie: string; factura: integer; fecha, tipo, tipofactura: string): boolean;
var
  iYear, iMonth, iDay: word;
  dFechaIni, dFechaFin, dFechaDesde, dFechaHasta: TDateTime;
  QFactura: TBonnyQuery;
begin
  result := false;

  DecodeDate( StrToDateDef(fecha, Date), iYear, iMonth, iDay );
  dFechaDesde := EncodeDate(iYear, 1, 1);
  dFechaHasta := EncodeDate(iYear, 12, 31);

      // Obtenemos fecha para la factura anterior a la perdida
  QFactura := TBonnyQuery.Create(nil);
  with QFactura do
  try
    SQL.Add(' select MAX(fecha_factura_fc) fecha_factura_fc ');
    SQL.Add('   from tfacturas_cab ');
    SQL.Add('  where cod_empresa_fac_fc = :empresa ');
    SQL.Add('    and cod_serie_fac_fc = :serie ');
    SQL.Add('    and fecha_factura_fc between :fechadesde and :fechahasta ');
    SQL.Add('    and impuesto_fc = :tipo_impuesto ');
    SQL.Add('    and tipo_factura_fc = :tipo_factura ');
    SQL.Add('    and n_factura_fc < :factura ');


    ParamByName('empresa').AsString := empresa;
    ParamByName('serie').AsString := serie;
    ParamByName('fechadesde').AsDateTime := dFechaDesde;
    ParamByName('fechahasta').AsDateTime := dFechaHasta;
    ParamByName('tipo_impuesto').AsString := tipo;
    ParamByName('tipo_factura').AsString := tipofactura;
    ParamByName('factura').AsInteger := factura;
    Open;
    if Fieldbyname('fecha_factura_fc').asstring = '' then
      dFechaIni := EncodeDate(iYeaR,1,1)
    else
      dFechaIni := FieldByName('fecha_factura_fc').AsDateTime;

      // Obtenemos fecha para la factura posterior a la perdida
    SQL.Clear;
    SQL.Add(' select MIN(fecha_factura_fc) fecha_factura_fc ');
    SQL.Add('   from tfacturas_cab ');
    SQL.Add('  where cod_empresa_fac_fc = :empresa ');
    SQL.Add('    and fecha_factura_fc between :fechadesde and :fechahasta ');
    SQL.Add('    and impuesto_fc = :tipo_impuesto ');
    SQL.Add('    and tipo_factura_fc = :tipo_factura ');
    SQL.Add('    and n_factura_fc > :factura ');
    SQL.Add('    and cod_serie_fac_fc = :serie ');

    ParamByName('empresa').AsString := empresa;
    ParamByName('fechadesde').AsDateTime := dFechaDesde;
    ParamByName('fechahasta').AsDateTime := dFechaHasta;
    ParamByName('tipo_impuesto').AsString := tipo;
    ParamByName('tipo_factura').AsString := tipofactura;
    ParamByName('factura').AsInteger := factura;
    ParamByName('serie').AsString := serie;

    Open;
    dFechaFin := FieldByName('fecha_factura_fc').AsDateTime;
    Close;

    if (StrToDate(fecha) >= dFechaIni) and (StrToDate(fecha) <= dFechafin) then
      result := true;

  finally
    Free;
  end;
end;

end.
