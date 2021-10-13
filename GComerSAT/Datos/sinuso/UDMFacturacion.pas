unit UDMFacturacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, QUICKRPT;

var
  gbPlataforma: boolean = False;

type
  TRImportesParciales = record
    rNeto, rDescuento, rComision, rGasto, rBase, rTipoIva, rIva: Real;
  end;

  TRImportesBases = record
    rNeto, rDescuento, rComision, rGasto, rBase, rTipoIva, rIva: Real;
  end;

  TRImportesCabecera = record
    rTipoComision, rTipoDescuento: Real;
    aRImportesParciales: array of TRImportesParciales;
    aRImportesBases: array of TRImportesBases;
    rTotalNeto, rComision, rDescuento, rTotalGasto: real;
    rTotalBase, rTotalIva, rTotalImporte: Real;
    rFactor, rTotalEuros: Real;
  end;


  TDMFacturacion = class(TDataModule)
    QCabeceraFactura: TQuery;
    DSCabeceraFactura: TDataSource;
    QLineaGastos: TQuery;
    QLineaFactura: TQuery;
    QBuscaSalida: TQuery;
    QFacturaEnviada: TQuery;
    QAux: TQuery;
    QFacturaEnviadaempresa_fe: TStringField;
    QFacturaEnviadacliente_fac_fe: TStringField;
    QFacturaEnviadan_fac_desde_fe: TIntegerField;
    QFacturaEnviadan_fac_hasta_fe: TIntegerField;
    QFacturaEnviadafecha_factura_fe: TDateField;
    QFacturaEnviadahora_env_fe: TStringField;
    QFacturaEnviadafecha_env_fe: TDateField;
    QFacturaEnviadapdf_factura_fe: TBlobField;
    QCabFactura: TQuery;
    DSFacturas: TDataSource;
    QLinFactura: TQuery;
    QGasFactura: TQuery;
    QGetFacturaAnulacion: TQuery;
    QGetAbonoAnulacion: TQuery;
    QRangoFacturas: TQuery;
    QFacturasIva: TQuery;
    DSFacturasIva: TDataSource;
    QCosteEstadistico: TQuery;
    QCosteKgPlataforma: TQuery;
    QLineaIva: TQuery;
    QGastoIva: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  function GetFechaVencimiento( const AEmpresa, ACliente: string; const AFechaFactura: TDateTime ): TDateTime;

  //PARA LA GENERACION DE PDF Y ENVIO POR EMAIL




function PuedoEnviarFactura(var AEmpresa, ACliente, AFecha, ADesde,
  AHasta, AEmail: string): Boolean;
function  NewContadorFactura( const AFactura: integer ): string;
function  GetPrefijoFactura( const AEmpresa, ATipo, AImpuesto: string;
                             const AFechaFactura: TDateTime ): string;

function DatosTotalesFactura( const AEmpresa: string; const AFactura: Integer; const AFecha: TDateTime ): TRImportesCabecera;


  //CONTROL DE UNICIDAD Y VALIDEZ
function IsNumFacturaValido(const AEmpresa, AFactura, AFecha, ATipoIva, ATipoFactura: string): boolean;
//procedure PutNumFactura(const AEmpresa, AFactura, AFecha, ATipoIva, ATipoFactura: string);

var
  DMFacturacion: TDMFacturacion;

implementation

uses bSQLUtils, CVariables, Printers, DConfigMail, LReporteEnvio, UDMAuxDB,
     bTextUtils, DPreview, UDMConfig, bMath, UDMCambioMoneda, QRPDFFilt, CGlobal,
  UDMBaseDatos, UDFactura;

{$R *.DFM}

function GetFechaVencimiento( const AEmpresa, ACliente: string; const AFechaFactura: TDateTime ): TDateTime;
var
  iIncDias: integer;
  dAux: TDateTime;
begin

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(dias_cobro_fp,0) dias ');
    SQL.Add(' from frf_clientes, frf_forma_pago ');
    SQL.Add(' where empresa_c= :empresa ');
    SQL.Add(' and cliente_c = :cliente ');
    SQL.Add(' and codigo_fp = forma_pago_c ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;
    iIncDias:= FieldByName('dias').AsInteger;
    Close;
  end;

  dAux:= AFechaFactura + iIncDias;
  result:= dAux;
end;




function GetPrefijoFactura( const AEmpresa, ATipo, AImpuesto: string; const AFechaFactura: TDateTime ): string;
var
  iAnyo, iMes, iDia: word;
  sAux, sEmpresa: string;
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
      result:= 'FCT-' + sEmpresa + sAux + '-';
    end
    else
    begin
      result:= 'ACT-' + sEmpresa + sAux + '-';
    end;
  end;
end;

function NewContadorFactura( const AFactura: integer ): string;
begin
  if AFactura > 99999 then
  begin
    result:= IntToStr( AFactura );
    result:= Copy( result, length( result ) - 4, 5 );
  end
  else
  begin
    result:= Rellena( IntToStr( AFactura ), 5, '0', taLeftJustify );
  end;
end;









function PuedoEnviarFactura(var AEmpresa, ACliente, AFecha, ADesde,
  AHasta, AEmail: string): Boolean;
var
  Query: TQuery;
begin
  result := true;

  AEmail := '';
  Query := TQuery.Create(nil);
  Query.DatabaseName := 'BDProyecto';

  Query.SQL.Add(' select cod_empresa_tfc, cod_cliente_tfc cliente, fecha_tfc fecha, ');
  Query.SQL.Add('        MIN(n_factura_tfc) minf, MAX(n_factura_tfc) maxf ');
  Query.SQL.Add(' from tmp_facturas_c ');
  Query.SQL.Add(' where usuario_tfc ' + SQLEqualS(gsCodigo));
  Query.SQL.Add(' group by cod_empresa_tfc, cod_cliente_tfc, fecha_tfc ');

  try
    with Query do
    begin
      Open;
      First;
      Next;
      result := ( not IsEmpty ) and (EOF);
    end;
    if result then
    begin
      AEmpresa := Query.Fields[0].AsString;
      ACliente := Query.Fields[1].AsString;
      AFecha := Query.Fields[2].AsString;
      ADesde := Query.Fields[3].AsString;
      AHasta := Query.Fields[4].AsString;

      DConfigMail.sEmpresaConfig:= AEmpresa;
      DConfigMail.sClienteConfig:= ACliente;
      DConfigMail.sCampoConfig:= 'email_fac_c';
      EMail( AEmail);
      //result := EMail( AEmail);
    end
    else
    begin
      //Hay mas de un cliente
      ShowMessage('No se puede facturar por alguno de estos motivos:' + #13 + #10 +
        '    1.- Hay facturas de varias empresas' + #13 + #10 +
        '    2.- Hay facturas de varios clientes' + #13 + #10 +
        '    3.- Hay facturas con diferente fecha de facturación ');
    end;
  except
    //NO hacemos nada, nos olvidamos
  end;
  Query.Close;
  Query.Free;
end;




function IsNumFacturaValido(const AEmpresa, AFactura, AFecha, ATipoIva, ATipofactura: string): boolean;
var
  dia, mes, anyo: word;
  fecha: TDate;
begin
  fecha := StrToDate(AFecha);
  DecodeDate(fecha, anyo, mes, dia);
  with DMFacturacion.QAux do
  begin
    Close;
    //Comprobar unicidad NUM_FACTURA y AÑO
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f ' + SQLEqualS(AEmpresa));
    SQL.Add(' and n_factura_f ' + SQLEqualN(AFactura));
    SQL.Add(' and YEAR(fecha_factura_f) ' + SQLEqualN(IntTostr(anyo)));
    SQL.Add(' and tipo_impuesto_f[1,1] ' + SQLEqualS(Copy(ATipoIva, 1, 1)));
    SQL.Add(' and tipo_factura_f ' + SQLEqualS(ATipoFactura));
    Open;
    result := IsEmpty;
    Close;
    if not result then Exit;

    //Comprobar que todas las facturas con NUM_FACTURA menor tienen FECHA menor o igual
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f ' + SQLEqualS(AEmpresa));
    SQL.Add(' and n_factura_f ' + SQLEqualN(AFactura, '<'));
    SQL.Add(' and fecha_factura_f ' + SQLEqualD(AFecha, '>'));
    SQL.Add(' and YEAR(fecha_factura_f) ' + SQLEqualN(IntTostr(anyo)));
    SQL.Add(' and tipo_impuesto_f[1,1] ' + SQLEqualS(Copy(ATipoIva, 1, 1)));
    SQL.Add(' and tipo_factura_f ' + SQLEqualS(ATipoFactura));
    Open;
    result := IsEmpty;
    Close;
    if not result then Exit;

    //Comprobar que todas las facturas con NUM_FACTURA mayor tienen FECHA mayor o igual
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas ');
    SQL.Add(' where empresa_f ' + SQLEqualS(AEmpresa));
    SQL.Add(' and n_factura_f ' + SQLEqualN(AFactura, '>'));
    SQL.Add(' and fecha_factura_f ' + SQLEqualD(AFecha, '<'));
    SQL.Add(' and YEAR(fecha_factura_f) ' + SQLEqualN(IntTostr(anyo)));
    SQL.Add(' and tipo_impuesto_f[1,1] ' + SQLEqualS(Copy(ATipoIva, 1, 1)));
    SQL.Add(' and tipo_factura_f ' + SQLEqualS(ATipoFactura));
    Open;
    result := IsEmpty;
    Close;
  end;
end;

(*FACTAÑOS*)
(*
procedure PutNumFacturaIva(const AEmpresa, AFactura, AFecha, ATipoFactura: string);
var
  iYear, iMont, iDay: Word;
  iFactura, iAnyo: integer;
  bNumeracionAnterior: Boolean;
begin
  DecodeDate( StrToDate( AFecha ), iYear, iMont, iDay );
  iAnyo:= iYear;
  bNumeracionAnterior:= iAnyo < 2006;
  with DMFacturacion.QAux do
  begin
    Close;
    with SQL do
    begin
      Clear;
      if ( ATipoFactura = '380' ) or bNumeracionAnterior then
      begin
        Add(' SELECT fac_iva_emc, fecha_fac_iva_emc ')
      end
      else
      begin
        Add(' SELECT abn_iva_emc, fecha_abn_iva_emc ')
      end;
      Add(' FROM frf_empresas_contadores ');
      Add(' WHERE empresa_emc = :empresa ');
      Add(' and anyo_emc = :anyo ');
    end;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('anyo').AsInteger:= iAnyo;
    Open;
    iFactura := Fields[0].AsInteger + 1;
    Close;

    if StrToInt(AFactura) > iFactura then
    begin
      raise Exception.Create(' Numeración incorrecta, las facturas y abonos deben ser correlativos.');
    end;

    if StrToInt(AFactura) = iFactura then
    begin
      SQL.Clear;
      SQL.Add(' UPDATE frf_empresas_contadores ');
      if ( ATipoFactura = '380' ) or bNumeracionAnterior then
      begin
        SQL.Add(' SET fac_iva_emc ' + SQLEqualN(AFactura));
        SQL.Add('     ,fecha_fac_iva_emc ' + SQLEqualD(AFecha));
      end
      else
      begin
        SQL.Add(' SET abn_iva_emc ' + SQLEqualN(AFactura));
        SQL.Add('     ,fecha_abn_iva_emc ' + SQLEqualD(AFecha));
      end;
      SQL.Add(' WHERE empresa_emc = :empresa ');
      SQL.Add(' and anyo_emc = :anyo ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('anyo').AsInteger:= iAnyo;
      ExecSQL;
    end;
  end;
end;
*)

(*FACTAÑOS*)
(*
procedure PutNumFacturaIgic(const AEmpresa, AFactura, AFecha, ATipoFactura: string);
var
  iYear, iMont, iDay: Word;
  iFactura, iAnyo: integer;
begin
  DecodeDate( StrToDate( AFecha ), iYear, iMont, iDay );
  iAnyo:= iYear;
  with DMFacturacion.QAux do
  begin
    Close;
    with SQL do
    begin
      Clear;
      if ( ATipoFactura = '380' ) then
      begin
        Add(' SELECT fac_iva_emc, fecha_fac_iva_emc ')
      end
      else
      begin
        Add(' SELECT abn_igic_emc, fecha_abn_igic_emc ')
      end;
      Add(' FROM frf_empresas_contadores ');
      Add(' WHERE empresa_emc = :empresa ');
      Add(' and anyo_emc = :anyo ');
    end;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('anyo').AsInteger:= iAnyo;
    Open;
    iFactura := Fields[0].AsInteger + 1;
    Close;

    if StrToInt(AFactura) > iFactura then
    begin
      raise Exception.Create(' Numeración incorrecta, las facturas y abonos deben ser correlativos.');
    end;

    if StrToInt(AFactura) = iFactura then
    begin
      SQL.Clear;
      SQL.Add(' UPDATE frf_empresas_contadores ');
      if ( ATipoFactura = '380' ) then
      begin
        SQL.Add(' SET fac_igic_emc ' + SQLEqualN(AFactura));
        SQL.Add('     ,fecha_fac_igic_emc ' + SQLEqualD(AFecha));
      end
      else
      begin
        SQL.Add(' SET abn_igic_emc ' + SQLEqualN(AFactura));
        SQL.Add('     ,fecha_abn_igic_emc ' + SQLEqualD(AFecha));
      end;
      SQL.Add(' WHERE empresa_emc = :empresa ');
      SQL.Add(' and anyo_emc = :anyo ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('anyo').AsInteger:= iAnyo;
      ExecSQL;
    end;
  end;
end;
*)

{
procedure PutNumFactura(const AEmpresa, AFactura, AFecha, ATipoIva, ATipoFactura: string);
begin
  //Abrir transaccion
  (*if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
    raise Exception.Create('No se puede incrementar el contador de facturas.'+
                               ' Por favor, intentelo mas tarde.');*)
  try
    if copy(ATipoIva, 1, 1) = 'I' then
    begin
      PutNumFacturaIva(AEmpresa, AFactura, AFecha, ATipoFactura);
    end
    else
    begin
      PutNumFacturaIgic(AEmpresa, AFactura, AFecha, ATipoFactura);
    end;
  except
     (*CancelarTransaccion(DMBaseDatos.DBBaseDatos);*)
    raise;
  end;
   (*AceptarTransaccion(DMBaseDatos.DBBaseDatos);*)
end;
}

procedure TDMFacturacion.DataModuleCreate(Sender: TObject);
begin
  with QLineaFactura do
  begin
    SQL.Clear;
    SQL.Add(' SELECT  cod_empresa_tf, factura_tf,fecha_alb_tf,vehiculo_tf,albaran_tf, centro_salida_tf, ');
    SQL.Add('         cod_producto_tf,cod_dir_sum_tf,pedido_tf, transito_tf, ');
    SQL.Add('         MAX(producto_tf) as producto_tf, ');
    SQL.Add('         MAX(producto2_tf) as producto2_tf, ');
    SQL.Add('         cod_envase_tf, ');
    SQL.Add('         MAX(envase_tf) as envase_tf, ');
    SQL.Add('         MAX(descripcion2_e) as descripcion2_e, ');
    SQL.Add('         MAX(envase_comer_tf) as envase_comer_tf, ');
    SQL.Add('         categoria_tf,calibre_tf, ');


    SQL.Add('         unidad_medida_tf,precio_unidad_tf, ');
    SQL.Add('         SUM(cajas_tf) as cajas_tf, ');
    SQL.Add('         SUM(kilos_tf) as kilos_tf, ');
    SQL.Add('         SUM(unidades_tf) as unidades_tf, ');
    SQL.Add('         SUM(precio_neto_tf) as precio_neto_tf, ');
    SQL.Add('         nom_marca_tf, tipo_iva_tf ');
    SQL.Add(' FROM ');
    SQL.Add('        tmp_facturas_l ');
    SQL.Add(' WHERE ');
    SQL.Add('        (factura_tf=:factura_tfc) ');
    SQL.Add(' AND ');
    SQL.Add('        (usuario_tf=:usuario_tfc) ');
    SQL.Add(' GROUP BY cod_empresa_tf, factura_tf,fecha_alb_tf,vehiculo_tf,albaran_tf,  centro_salida_tf, ');
    SQL.Add('         cod_producto_tf,cod_dir_sum_tf,pedido_tf, transito_tf, ');
    SQL.Add('         cod_envase_tf,categoria_tf,calibre_tf, ');
    SQL.Add('         unidad_medida_tf,precio_unidad_tf,nom_marca_tf, ');
    SQL.Add('         tipo_iva_tf ');
    SQL.Add(' ORDER BY ');
    SQL.Add('        fecha_alb_tf, pedido_tf, albaran_tf, cod_dir_sum_tf, cod_producto_tf, cod_envase_tf ');
    //Prepare;
  end;

  with QGetFacturaAnulacion do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_fa, n_factura_fa, fecha_factura_fa ');
    SQL.Add(' from frf_facturas_abono ');
    SQL.Add(' where empresa_fa = :empresa ');
    SQL.Add('   and n_abono_fa = :abono ');
    SQL.Add('   and fecha_abono_fa = :fecha ');
    //Prepare;
  end;
  with QGetAbonoAnulacion do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_fa, n_abono_fa, fecha_abono_fa ');
    SQL.Add(' from frf_facturas_abono ');
    SQL.Add(' where empresa_fa = :empresa ');
    SQL.Add('   and n_factura_fa = :factura ');
    SQL.Add('   and fecha_factura_fa = :fecha ');
    //Prepare;
  end;
  with QRangoFacturas do
  begin
    SQL.Clear;
    SQL.Add(' select max(n_factura_tfc) maxFac, min(n_factura_tfc) minFac, ');
    SQL.Add('        max(cod_cliente_tfc) maxCli, min(cod_cliente_tfc) minCli');
    SQL.Add(' from tmp_facturas_c ');
    SQL.Add(' where usuario_tfc = :usuario ');
    //Prepare;
  end;

  with QCosteEstadistico do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_dal ');
    SQL.Add(' from frf_depositos_aduana_sal, frf_depositos_aduana_l ');
    SQL.Add(' where empresa_das = :empresa ');
    SQL.Add(' and centro_salida_das = :centro ');
    SQL.Add(' and n_albaran_das = :albaran ');
    SQL.Add(' and fecha_das = :fecha ');
    SQL.Add(' and nvl(n_factura_das,'''') = ''''  ');
    SQL.Add(' and codigo_dal = codigo_das ');
    SQL.Add(' and linea_dal = linea_das ');
    //Prepare;
  end;

  with QCosteKgPlataforma do
  begin
    SQL.Clear;
    SQL.Add(' select fob_plataforma_p ');
    SQL.Add(' from frf_salidas_c, frf_clientes, frf_paises ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');
    SQL.Add(' and porte_bonny_sc = 0 ');
    SQL.Add(' and empresa_c = :empresa ');
    SQL.Add(' and cliente_c = :cliente ');
    SQL.Add(' and pais_p = pais_c ');
    //Prepare;
  end;
end;

procedure TDMFacturacion.DataModuleDestroy(Sender: TObject);
begin
  QLineaFactura.Close;
  //if QLineaFactura.Prepared then
    //QLineaFactura.UnPrepare;

  QGetFacturaAnulacion.Close;
  //if QGetFacturaAnulacion.Prepared then
    //QGetFacturaAnulacion.UnPrepare;
  QGetAbonoAnulacion.Close;
  //if QGetAbonoAnulacion.Prepared then
    //QGetAbonoAnulacion.UnPrepare;
  QRangoFacturas.Close;
  //if QRangoFacturas.Prepared then
    //QRangoFacturas.UnPrepare;
  QCosteEstadistico.Close;
  //if QCosteEstadistico.Prepared then
    //QCosteEstadistico.UnPrepare;
  QCosteKgPlataforma.Close;
  //if QCosteKgPlataforma.Prepared then
    //QCostekgPlataforma.UnPrepare;
end;

{
function DatosTotalesFactura( const AEmpresa: string; const AFactura: Integer; const AFecha: TDateTime ): TRImportesCabecera;
var
  i, iCont, iMax, j, iBases: Integer;
  rAux, rMax, rBaseAux: Real;
begin
  Result.rTotalNeto:= 0;
  Result.rComision:= 0;
  Result.rDescuento:= 0;
  Result.rGastos:= 0;

  Result.rTotalBase:= 0;
  Result.rTotalIva:= 0;
  Result.rTotalImporte:= 0;
  Result.rFactor:= 0;
  Result.rTotalEuros:= 0;

  Result.rTipoComision:= 0;
  Result.rTipoDescuento:= 0;

  with DMFacturacion.QFacturasIva do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('factura').AsInteger:= AFactura;
    ParamByName('fecha').AsDate:= AFecha;
    ParamByName('usuario').AsString:= gsCodigo;
    Open;
  end;
  DMFacturacion.QLineasIVA.Open;
  DMFacturacion.QBasesIVA.Open;
  DMFacturacion.QGastosTotales.Open;

  Result.rTipoComision:= DMFacturacion.QFacturasIva.FieldByName('comision_tfc').AsFloat;
  Result.rTipoDescuento:= DMFacturacion.QFacturasIva.FieldByName('descuento_tfc').AsFloat;

  (*BASES*)
  iBases:= 0;
  while not DMFacturacion.QBasesIVA.Eof do
  begin
    inc( iBases );
    DMFacturacion.QBasesIVA.Next;
  end;
  SetLength( Result.aRImportesBases, iBases );
  DMFacturacion.QBasesIVA.First;
  for i:=0 to iBases -1 do
  begin
    Result.aRImportesBases[i].rNeto:= DMFacturacion.QBasesIVA.FieldByName('neto').AsFloat;
    Result.aRImportesBases[i].rTipoIva:= DMFacturacion.QBasesIVA.FieldByName('iva').AsFloat;
    Result.aRImportesBases[i].rDescuento:= 0;
    Result.aRImportesBases[i].rComision:= 0;
    Result.aRImportesBases[i].rGastos:= 0;
    Result.aRImportesBases[i].rBase:= 0;
    Result.aRImportesBases[i].rIva:= 0;
    DMFacturacion.QBasesIVA.Next;
  end;

  (*NETO*)
  iCont:= 0;
  while not DMFacturacion.QLineasIVA.Eof do
  begin
    inc( iCont );
    DMFacturacion.QLineasIVA.Next;
  end;
  SetLength( Result.aRImportesParciales, iCont );
  DMFacturacion.QLineasIVA.First;
  for i:=0 to iCont -1 do
  begin
    Result.aRImportesParciales[i].rNeto:= DMFacturacion.QLineasIVA.FieldByName('neto').AsFloat;
    Result.aRImportesParciales[i].rTipoIva:= DMFacturacion.QLineasIVA.FieldByName('iva').AsFloat;
    Result.aRImportesParciales[i].rBase:= Result.aRImportesParciales[i].rNeto;
    Result.rTotalNeto:= Result.rTotalNeto + Result.aRImportesParciales[i].rNeto;
    DMFacturacion.QLineasIVA.Next;
  end;

  (*COMISION*)
  rAux:= 0;
  Result.rComision:= bRoundTo( ( Result.rTotalNeto *  Result.rTipoComision ) / 100, -2 );
  for i:= 0 to iCont -1 do
  begin
    Result.aRImportesParciales[i].rComision:= bRoundTo( ( Result.aRImportesParciales[i].rBase *  Result.rTipoComision ) / 100, -2 );
    rAux:= rAux + Result.aRImportesParciales[i].rComision;
  end;
  if rAux <> Result.rComision then
  begin
    rMax:= 0;
    iMax:= 0;
    for i:= 0 to iCont -1 do
    begin
      if Result.aRImportesParciales[i].rComision > rMax then
      begin
        iMax:= i;
        rMax:= Result.aRImportesParciales[i].rComision;
      end;
    end;
    Result.aRImportesParciales[iMax].rComision:= Result.aRImportesParciales[iMax].rComision + ( Result.rComision - rAux );
  end;
  rBaseAux:= 0;
  for i:= 0 to iCont -1 do
  begin
    Result.aRImportesParciales[i].rBase:= Result.aRImportesParciales[i].rBase - Result.aRImportesParciales[i].rComision;
    rBaseAux:= rBaseAux + Result.aRImportesParciales[i].rBase;
  end;

  (*DESCUENTO*)
  rAux:= 0;
  Result.rDescuento:= bRoundTo( ( rBaseAux *  Result.rTipoDescuento ) / 100, -2 );
  for i:= 0 to iCont -1 do
  begin
    Result.aRImportesParciales[i].rDescuento:= bRoundTo( ( Result.aRImportesParciales[i].rBase *  Result.rTipoDescuento ) / 100, -2 );
    rAux:= rAux + Result.aRImportesParciales[i].rDescuento;
  end;
  if rAux <> Result.rDescuento then
  begin
    rMax:= 0;
    iMax:= 0;
    for i:= 0 to iCont -1 do
    begin
      if Result.aRImportesParciales[i].rDescuento > rMax then
      begin
        iMax:= i;
        rMax:= Result.aRImportesParciales[i].rDescuento;
      end;
    end;
    Result.aRImportesParciales[iMax].rDescuento:= Result.aRImportesParciales[iMax].rDescuento + ( Result.rDescuento - rAux );
  end;
  rBaseAux:= 0;
  for i:= 0 to iCont -1 do
  begin
    Result.aRImportesParciales[i].rBase:= Result.aRImportesParciales[i].rBase - Result.aRImportesParciales[i].rDescuento;
    rBaseAux:= rBaseAux + Result.aRImportesParciales[i].rBase;
  end;

  (*GASTOS FACTURABLES*)
  rAux:= 0;
  Result.rGastos:= DMFacturacion.QGastosTotales.fieldByName('importe').AsFloat;
  for i:= 0 to iCont -1 do
  begin
    if rBaseAux <> 0 then
      Result.aRImportesParciales[i].rGastos:= bRoundTo( ( Result.rGastos * Result.aRImportesParciales[i].rBase ) / rBaseAux, -2)
    else
      Result.aRImportesParciales[i].rGastos:= 0;
    rAux:= rAux + Result.aRImportesParciales[i].rGastos;
  end;
  if rAux <> Result.rGastos then
  begin
    rMax:= 0;
    iMax:= 0;
    for i:= 0 to iCont -1 do
    begin
      if Result.aRImportesParciales[i].rGastos > rMax then
      begin
        iMax:= i;
        rMax:= Result.aRImportesParciales[i].rGastos;
      end;
    end;
    Result.aRImportesParciales[iMax].rGastos:= Result.aRImportesParciales[iMax].rGastos + ( Result.rGastos - rAux );
  end;
  for i:= 0 to iCont -1 do
  begin
    Result.aRImportesParciales[i].rBase:= Result.aRImportesParciales[i].rBase + Result.aRImportesParciales[i].rGastos;
  end;

  //iva lineas
  for i:= 0 to iCont -1 do
  begin
    Result.aRImportesParciales[i].rIva:= bRoundTo( ( Result.aRImportesParciales[i].rBase * Result.aRImportesParciales[i].rTipoIva ) / 100, -2 );
  end;

  //Relenar distintas bases de IVA
  for i:=0 to iBases -1 do
  begin
   for j:=0 to iCont -1 do
    begin
      if Result.aRImportesBases[i].rTipoIva = Result.aRImportesParciales[j].rTipoIva then
      begin
        Result.aRImportesBases[i].rDescuento:= Result.aRImportesBases[i].rDescuento + Result.aRImportesParciales[j].rDescuento;
        Result.aRImportesBases[i].rComision:= Result.aRImportesBases[i].rComision + Result.aRImportesParciales[j].rComision;
        Result.aRImportesBases[i].rGastos:= Result.aRImportesBases[i].rGastos + Result.aRImportesParciales[j].rGastos;
        Result.aRImportesBases[i].rBase:= Result.aRImportesBases[i].rBase + Result.aRImportesParciales[j].rBase;
        //Result.aRImportesBases[i].rIva:= Result.aRImportesBases[i].rIva + Result.aRImportesParciales[j].rIva;
      end;
    end;
  end;
  //IVA de las distintas bases y cuadro totales
  for i:=0 to iBases -1 do
  begin
    Result.aRImportesBases[i].rIva:= bRoundTo( ( Result.aRImportesBases[i].rBase * Result.aRImportesBases[i].rTipoIva ) / 100, -2 );

    Result.rTotalBase:= Result.rTotalBase + Result.aRImportesBases[i].rBase;
    Result.rTotalIva:= Result.rTotalIva + Result.aRImportesBases[i].rIva;
    Result.rTotalImporte:= Result.rTotalImporte + Result.aRImportesBases[i].rBase + Result.aRImportesBases[i].rIva;
  end;
  Result.rFactor:= ToEuro(
    DMFacturacion.QFacturasIva.FieldByName('cod_moneda_tfc').AsString,
    DMFacturacion.QFacturasIva.FieldByName('fecha_tfc').AsString);
  Result.rTotalEuros:= bRoundTo( Result.rTotalImporte * Result.rFactor, -2 );  

  DMFacturacion.QLineasIVA.Close;
  DMFacturacion.QBasesIVA.Close;
  DMFacturacion.QGastosTotales.Close;
  DMFacturacion.QFacturasIva.Close;
end;
}

function DatosTotalesFactura( const AEmpresa: string; const AFactura: Integer; const AFecha: TDateTime ): TRImportesCabecera;
var
  i, j, iLineas, iBases: Integer;
  iMax: integer;
  rAux, rMax, rAuxBase: real;
  flag: boolean;
begin
  Result.rTotalNeto:= 0;
  Result.rComision:= 0;
  Result.rDescuento:= 0;
  Result.rTotalGasto:= 0;

  Result.rTotalBase:= 0;
  Result.rTotalIva:= 0;
  Result.rTotalImporte:= 0;
  Result.rFactor:= 0;
  Result.rTotalEuros:= 0;

  with DMFacturacion.QFacturasIva do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('factura').AsInteger:= AFactura;
    ParamByName('fecha').AsDate:= AFecha;
    ParamByName('usuario').AsString:= gsCodigo;
    Open;
  end;
  DMFacturacion.QLineaIVA.Open;
  DMFacturacion.QGastoIVA.Open;


  Result.rTipoComision:= DMFacturacion.QFacturasIva.FieldByName('comision_tfc').AsFloat;
  Result.rTipoDescuento:= DMFacturacion.QFacturasIva.FieldByName('descuento_tfc').AsFloat;

  (*NETO*)
  iLineas:= 0;
  iBases:= 0;
  while not DMFacturacion.QLineaIVA.Eof do
  begin

    (*INICIALIZAR BASES*)
    i:= 0;
    flag:= False;
    while ( i < iBases ) and ( not flag ) do
    begin
      if DMFacturacion.QLineaIVA.FieldByName('iva').AsFloat =  Result.aRImportesBases[i].rTipoIva then
        flag:= True
      else
        inc(i);
    end;
    if not flag then
    begin
      SetLength( Result.aRImportesBases, iBases + 1);
      Result.aRImportesBases[iBases].rTipoIva:= DMFacturacion.QLineaIVA.FieldByName('iva').AsFloat;
      Result.aRImportesBases[i].rNeto:= 0;
      Result.aRImportesBases[i].rDescuento:= 0;
      Result.aRImportesBases[i].rComision:= 0;
      Result.aRImportesBases[i].rGasto:= 0;
      Result.aRImportesBases[i].rBase:= 0;
      Result.aRImportesBases[i].rIva:= 0;
      iBases:= iBases + 1;
    end;

    SetLength( Result.aRImportesParciales, iLineas + 1);
    Result.aRImportesParciales[iLineas].rNeto:= DMFacturacion.QLineaIVA.FieldByName('neto').AsFloat;
    Result.aRImportesParciales[iLineas].rTipoIva:= DMFacturacion.QLineaIVA.FieldByName('iva').AsFloat;
    Result.aRImportesParciales[iLineas].rBase:= Result.aRImportesParciales[iLineas].rNeto;
    Result.aRImportesParciales[iLineas].rDescuento:= 0;
    Result.aRImportesParciales[iLineas].rComision:= 0;
    Result.aRImportesParciales[iLineas].rGasto:= 0;
    Result.rTotalNeto:= Result.rTotalNeto + Result.aRImportesParciales[iLineas].rNeto;

    inc( iLineas );
    DMFacturacion.QLineaIVA.Next;
  end;

  (*COMISION*)
  rAux:= 0;
  Result.rComision:= bRoundTo( ( Result.rTotalNeto *  Result.rTipoComision ) / 100, -2 );
  for i:= 0 to iLineas -1 do
  begin
    Result.aRImportesParciales[i].rComision:= bRoundTo( ( Result.aRImportesParciales[i].rBase *  Result.rTipoComision ) / 100, -2 );
    rAux:= rAux + Result.aRImportesParciales[i].rComision;
  end;
  if rAux <> Result.rComision then
  begin
    rMax:= 0;
    iMax:= 0;
    for i:= 0 to iLineas -1 do
    begin
      if Result.aRImportesParciales[i].rComision > rMax then
      begin
        iMax:= i;
        rMax:= Result.aRImportesParciales[i].rComision;
      end;
    end;
    Result.aRImportesParciales[iMax].rComision:= Result.aRImportesParciales[iMax].rComision + ( Result.rComision - rAux );
  end;
  rAuxBase:= 0;
  for i:= 0 to iLineas -1 do
  begin
    Result.aRImportesParciales[i].rBase:= Result.aRImportesParciales[i].rBase - Result.aRImportesParciales[i].rComision;
    rAuxBase:= rAuxBase + Result.aRImportesParciales[i].rBase;
  end;

  (*DESCUENTO*)
  rAux:= 0;
  Result.rDescuento:= bRoundTo( ( rAuxBase *  Result.rTipoDescuento ) / 100, -2 );
  for i:= 0 to iLineas -1 do
  begin
    Result.aRImportesParciales[i].rDescuento:= bRoundTo( ( Result.aRImportesParciales[i].rBase *  Result.rTipoDescuento ) / 100, -2 );
    rAux:= rAux + Result.aRImportesParciales[i].rDescuento;
  end;
  if rAux <> Result.rDescuento then
  begin
    rMax:= 0;
    iMax:= 0;
    for i:= 0 to iLineas -1 do
    begin
      if Result.aRImportesParciales[i].rDescuento > rMax then
      begin
        iMax:= i;
        rMax:= Result.aRImportesParciales[i].rDescuento;
      end;
    end;
    Result.aRImportesParciales[iMax].rDescuento:= Result.aRImportesParciales[iMax].rDescuento + ( Result.rDescuento - rAux );
  end;
  //rBaseAux:= 0;
  for i:= 0 to iLineas -1 do
  begin
    Result.aRImportesParciales[i].rBase:= Result.aRImportesParciales[i].rBase - Result.aRImportesParciales[i].rDescuento;
    //rBaseAux:= rBaseAux + Result.aRImportesParciales[i].rBase;
  end;


  (*GASTOS*)
  while not DMFacturacion.QGastoIVA.Eof do
  begin
    (*INICIALIZAR BASES*)
    i:= 0;
    flag:= False;
    while ( i < iBases ) and ( not flag ) do
    begin
      if DMFacturacion.QGastoIVA.FieldByName('iva').AsFloat =  Result.aRImportesBases[i].rTipoIva then
        flag:= True
      else
        inc(i);
    end;
    if not flag then
    begin
      SetLength( Result.aRImportesBases, iBases + 1);
      Result.aRImportesBases[iBases].rTipoIva:= DMFacturacion.QGastoIVA.FieldByName('iva').AsFloat;
      Result.aRImportesBases[i].rNeto:= 0;
      Result.aRImportesBases[i].rDescuento:= 0;
      Result.aRImportesBases[i].rComision:= 0;
      Result.aRImportesBases[i].rGasto:= 0;
      Result.aRImportesBases[i].rBase:= 0;
      Result.aRImportesBases[i].rIva:= 0;
      iBases:= iBases + 1;
    end;

    SetLength( Result.aRImportesParciales, iLineas + 1 );
    Result.aRImportesParciales[iLineas].rGasto:= DMFacturacion.QGastoIVA.FieldByName('neto').AsFloat;
    Result.aRImportesParciales[iLineas].rTipoIva:= DMFacturacion.QGastoIVA.FieldByName('iva').AsFloat;
    Result.aRImportesParciales[iLineas].rBase:= Result.aRImportesParciales[iLineas].rGasto;
    Result.aRImportesParciales[iLineas].rDescuento:= 0;
    Result.aRImportesParciales[iLineas].rComision:= 0;
    Result.aRImportesParciales[iLineas].rNeto:= 0;
    Result.rTotalGasto:= Result.rTotalGasto + Result.aRImportesParciales[iLineas].rNeto;

    inc( iLineas );
    DMFacturacion.QGastoIVA.Next;
  end;
  //SetLength( Result.aRImportesBases, iBases);


  //iva lineas
  for i:= 0 to iLineas -1 do
  begin
    Result.aRImportesParciales[i].rIva:= bRoundTo( ( Result.aRImportesParciales[i].rBase * Result.aRImportesParciales[i].rTipoIva ) / 100, -2 );
  end;

  //Relenar distintas bases de IVA
  for i:=0 to iBases -1 do
  begin
   for j:=0 to iLineas -1 do
    begin
      if Result.aRImportesBases[i].rTipoIva = Result.aRImportesParciales[j].rTipoIva then
      begin
        Result.aRImportesBases[i].rNeto:= Result.aRImportesBases[i].rNeto + Result.aRImportesParciales[j].rNeto;
        Result.aRImportesBases[i].rDescuento:= Result.aRImportesBases[i].rDescuento + Result.aRImportesParciales[j].rDescuento;
        Result.aRImportesBases[i].rComision:= Result.aRImportesBases[i].rComision + Result.aRImportesParciales[j].rComision;
        Result.aRImportesBases[i].rGasto:= Result.aRImportesBases[i].rGasto + Result.aRImportesParciales[j].rGasto;
        Result.aRImportesBases[i].rBase:= Result.aRImportesBases[i].rBase + Result.aRImportesParciales[j].rBase;
        //Result.aRImportesBases[i].rIva:= Result.aRImportesBases[i].rIva + Result.aRImportesParciales[j].rIva;
        //El iva se calcula con el total de las bases
      end;
    end;
  end;
  //IVA de las distintas bases y cuadro totales
  for i:=0 to iBases -1 do
  begin
    Result.aRImportesBases[i].rIva:= bRoundTo( ( Result.aRImportesBases[i].rBase * Result.aRImportesBases[i].rTipoIva ) / 100, -2 );
    Result.rTotalBase:= Result.rTotalBase + Result.aRImportesBases[i].rBase;
    Result.rTotalIva:= Result.rTotalIva + Result.aRImportesBases[i].rIva;
    Result.rTotalImporte:= Result.rTotalImporte + Result.aRImportesBases[i].rBase + Result.aRImportesBases[i].rIva;
  end;
  Result.rFactor:= ToEuro(
    DMFacturacion.QFacturasIva.FieldByName('cod_moneda_tfc').AsString,
    DMFacturacion.QFacturasIva.FieldByName('fecha_tfc').AsString);
  Result.rTotalEuros:= bRoundTo( Result.rTotalImporte * Result.rFactor, -2 );  

  DMFacturacion.QLineaIVA.Close;
  DMFacturacion.QGastoIVA.Close;
  DMFacturacion.QFacturasIva.Close;
end;


end.





