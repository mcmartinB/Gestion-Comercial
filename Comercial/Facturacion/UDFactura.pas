unit UDFactura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, QUICKRPT, kbmMemTable, ImgList, cxGraphics, DBClient, BonnyQuery;

type

  TRImportesComision = record
    rPorcentaje, rImporteBase, rTotalImporte: Real;
  end;

  TRImportesDescuento = record
    rPorcentaje, rImporteBase, rTotalImporte: Real;
  end;

  TRImportesEurosKg = record
    rPorcentaje, rImporteBase, rTotalImporte: Real;
  end;


  TRImportesCabecera = record
    aRImportesComision: array of TRImportesComision;
    aRImportesDescuento: array of TRImportesDescuento;
    aRImportesEurosKg: array of TRImportesEurosKg;
  end;

  TRImportes = record
    sCodFactura, sEmpresa, sFecha, sNumero: String;
    iTasaImpuesto, iCajas, iUnidades: Integer;
    rPorcentajeImpuesto, rKilos, rImporteNeto, rImporteImpuesto, rImporteTotal: Real;
  end;

  TRImpBases = record
    aRImportes: array of TRImportes;
  end;

  TRDatosClienteFac  = record
    sDesCliente, sCtaCliente, sNIFCliente,
    sTipoVia, sDomicilio, sPoblacion,
    sCodPostal, sProvincia, sCodPais,
    sDesPais, sFormaPago: string;
    iDiasCobro, iDiasTesoreria: integer;
  end;

  TImpuestos = record
    sCodigo: string;
    sTipo: string;
    sDescripcion: string;
    rGeneral, rReducido, rSuper: Real;
  end;


  TDFactura = class(TDataModule)
    QGeneral: TQuery;
    QAux: TQuery;
    mtFacturas_Det: TkbmMemTable;
    mtFacturas_Gas: TkbmMemTable;
    dsFacturas_Cab: TDataSource;
    dsFacturas_Det: TDataSource;
    dsFacturas_Gas: TDataSource;
    IFacturas: TcxImageList;
    IFacturas2: TcxImageList;
    QTemp: TQuery;
    mtFacturas_Cab: TkbmMemTable;
    dsFacturas_Bas: TDataSource;
    mtFacturas_Bas: TkbmMemTable;
    mtFacturas_Cab2: TkbmMemTable;
    dsFacturas_Bas2: TDataSource;
    mtFacturas_Det2: TkbmMemTable;
    mtFacturas_Gas2: TkbmMemTable;
    mtFacturas_Bas2: TkbmMemTable;
    dsFacturas_Cab2: TDataSource;
    dsFacturas_Det2: TDataSource;
    dsFacturas_Gas2: TDataSource;
    QVenta: TQuery;
    QDirSum: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

  public
    function ClaveFactura( const AEmpresa, AImpuesto, ATipoFact, ASerie: String;
                           const AFecha: TDateTime; var ANumero: integer ): boolean;
    procedure PutFechaVencimiento( const AEmpresa, ACliente: string; const AFechaFactura: TDateTime; var AFechaCobro, AFechaTesoreria: TDateTime );
  end;

  procedure RellenaMemCabeceraFacturas(ARepFactura: Boolean);
  procedure RellenaMemLineasFacturas(ARepFactura: Boolean);
  procedure RellenaMemGastosFacturas(ARepFactura: Boolean);
  procedure RellenaMemBaseFacturas(ARepFactura: Boolean; ARImpBases: TRImpBases);

  function InsertaFacturaCabecera(ClaveFactura: string; FacturaNumero: integer): boolean;
  function InsertaFacturaDetalle(ClaveFactura: string; FacturaNumero: integer; bFactura: boolean): Boolean;
  function InsertaFacturaGastos(ClaveFactura: string): boolean;
  function InsertaFacturaBase(ClaveFactura: string): boolean;

  function BorraFacturaCabecera(ClaveFactura: string): boolean;
  function BorraFacturaDetalle(ClaveFactura: string): boolean;
  function BorraFacturaGastos(ClaveFactura: string): boolean;
  function BorraFacturaBase(ClaveFactura: string): boolean;

  function  NewCodigoFactura( const AEmpresa, ATipo, AImpuesto, ASerie: string;
                              const AFechaFactura: TDateTime;
                              const AFactura: integer ): string;
  function  GetPrefijoFactura( const AEmpresa, ATipo, AImpuesto, ASerie: string;
                               const AFechaFactura: TDateTime ): string;
  function  NewContadorFactura( const AFactura: integer ): string;
  function  GetNumeroFactura(empresa, tipofac, tipo, serie: string; fecha: TDate; var AMsg: string): integer;

  function  DatosTotalDescuento( const CodFactura: String ): TRImportesCabecera;
  function  DatosTotalDescuento2( const CodFactura: String ): TRImportesCabecera;
  function  GetDatosCliente(const AEmpresa, ACliente, ADirSum: String): TRDatosClienteFac;
  function  GetImpuestoMoneda(const AEmpresa, ACliente:string; var AImpuesto, AMoneda: string): Boolean;
  function ComprobarClavePrimaria( const AEmpresa, ASerie: string; const AFactura, AAnyo: Integer ): Integer;

  function ImpuestosClientes(const AEmpresa, ACliente, AImpuesto: string; const AFecha: TDate ): TImpuestos;


  function EnviarYGuardarFacturas(AReport: TQuickRep): boolean;

var
  DFactura: TDFactura;


implementation


uses bSQLUtils, CVariables, Printers, DConfigMailFactura, LReporteEnvio, UDMAuxDB,
     bTextUtils, DPreview, UDMConfig, bMath, UDMCambioMoneda, QRPDFFilt,
     UDMBaseDatos, CFactura, BonnyClientDataSet, CAuxiliarDB;

{$R *.DFM}

procedure RellenaMemCabeceraFacturas(ARepFactura: Boolean);
var sFactura: string;
    RDatosClienteFac: TRDatosClienteFac;
begin
  sFactura := '';

  with DFactura.mtFacturas_Det do
  begin
    First;
    DFactura.mtFacturas_Cab.Open ;
    while not Eof do
    begin
      if (sFactura = '') or (sFactura <> FieldByName('fac_interno_fd').AsString) then
      begin

        RDatosClienteFac := GetDatosCliente(DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString,
                                            DFactura.mtFacturas_Det.FieldByName('cod_cliente_albaran_fd').AsString,
                                            DFactura.mtFacturas_Det.FieldByName('cod_dir_sum_fd').AsString);
        if RDatosClienteFac.sFormaPago = '' then
        begin
          ShowMEssage(' ERROR: No existe Forma de Pago para Empresa: ' +  DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString +  ' / ' +
                                           'Cliente: ' + DFactura.mtFacturas_Det.FieldByName('cod_cliente_albaran_fd').AsString);
          exit;
        end;

        DFactura.mtFacturas_Cab.Append;

        DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').AsString := FieldByName('cod_empresa_fac_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('cod_serie_fac_fc').AsString := FieldByName('cod_serie_fac_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('fac_interno_fc').asString := FieldbyName('fac_interno_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsDateTime := FieldByName('fecha_fac_fd').AsDateTime;
        DFactura.mtFacturas_Cab.FieldByName('impuesto_fc').AsString := Copy(FieldByName('tipo_iva_fd').AsString, 1, 1);
        DFactura.mtFacturas_Cab.FieldByName('tipo_factura_fc').AsString := '380';
        DFactura.mtFacturas_Cab.FieldByName('automatica_fc').asInteger := 1;
        DFactura.mtFacturas_Cab.FieldByName('anulacion_fc').asInteger := 0;
        DFactura.mtFacturas_Cab.FieldByName('cod_factura_anula_fc').AsString := '';
        DFactura.mtFacturas_Cab.FieldByName('cod_cliente_fc').AsString := FieldByname('cod_cliente_fac_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('des_cliente_fc').AsString := RDatosClienteFac.sDesCliente;
        DFactura.mtFacturas_Cab.FieldByName('cta_cliente_fc').AsString := RDatosClienteFac.sCtaCliente;
        DFactura.mtFacturas_Cab.FieldByName('nif_fc').AsString := RDatosClienteFac.sNIFCliente;
        DFactura.mtFacturas_Cab.FieldByName('tipo_via_fc').AsString := RDatosClienteFac.sTipoVia;
        DFactura.mtFacturas_Cab.FieldByName('domicilio_fc').AsString := RDatosClienteFac.sDomicilio;
        DFactura.mtFacturas_Cab.FieldByName('poblacion_fc').AsString := RDatosClienteFac.sPoblacion;
        DFactura.mtFacturas_Cab.FieldByName('cod_postal_fc').AsString := RDatosClienteFac.sCodPostal;
        if RDatosClienteFac.sCodPais = 'ES' then
          DFactura.mtFacturas_Cab.FieldByName('provincia_fc').AsString := RDatosClienteFac.sProvincia
        else
          DFactura.mtFacturas_Cab.FieldByName('provincia_fc').AsString := '';
        DFactura.mtFacturas_Cab.FieldByName('cod_pais_fc').AsString := RDatosClienteFac.sCodPais;
        DFactura.mtFacturas_Cab.FieldByName('des_pais_fc').AsString := RDatosClienteFac.sDesPais;

        DFactura.mtFacturas_Cab.FieldByName('incoterm_fc').Asstring := FieldByName('incoterm_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('plaza_incoterm_fc').AsString := FieldByName('plaza_incoterm_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('forma_pago_fc').AsString := RDatosClienteFac.sFormaPago;
        DFactura.mtFacturas_Cab.FieldByName('des_forma_pago_fc').AsString := desFormaPagoEx(RDatosClienteFac.sFormaPago);
        DFactura.mtFacturas_Cab.FieldByName('tipo_impuesto_fc').AsString := FieldByName('tipo_iva_fd').AsString;
        DFactura.mtFacturas_Cab.FieldByName('des_tipo_impuesto_fc').AsString := DesImpuesto(FieldByName('tipo_iva_fd').AsString);
        DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString := FieldByName('moneda_fd').AsString;
        (*NOTA*)//Si fuera un abono tendria que poner la fecha de la factura asociada
        DFactura.mtFacturas_Cab.FieldByName('fecha_fac_ini_fc').AsDateTime := DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsDateTime;
        DFactura.mtFacturas_Cab.FieldByName('prevision_cobro_fc').AsDateTime := DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsDateTime + RDatosClienteFac.iDiasCobro;
        DFactura.mtFacturas_Cab.FieldByName('prevision_tesoreria_fc').AsDateTime := DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsDateTime + RDatosClienteFac.iDiasTesoreria;
        DFactura.mtFacturas_Cab.FieldByName('contabilizado_fc').AsInteger := 0;
        DFactura.mtFacturas_Cab.FieldByName('fecha_conta_fc').AsString := '';
        DFactura.mtFacturas_Cab.FieldByName('filename_conta_fc').AsString := '';

        if ARepFactura then
        begin
          DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').Asstring := DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString;
          DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsInteger := DFactura.mtFacturas_Det.FieldByName('fac_interno_fd').AsInteger;
        end;

        DFactura.mtFacturas_Cab.Post;
      end;
      sFactura := FieldByName('fac_interno_fd').AsString;
      Next;
    end;
//    DFactura.mtFacturas_Cab.SortOn('cod_factura_fc',[]);
  end;
end;

procedure RellenaMemLineasFacturas(ARepFactura: Boolean);
var rComision, rDescuento, rEurosKg, rEurosPale, rImpuesto,
    rImpComision, rImpDescuento, rImpEurosKg, rImpEurosPale: real;
    iNumLinea: integer;
    sCodFactura: string;
begin
  iNumLinea := 1;
  sCodFactura := '';
  with DFactura.QGeneral do
  begin
    First;
    DFactura.mtFacturas_Det.Open ;
    while not Eof do
    begin
      if (ARepFactura) and (sCodFactura <> FieldByName('cod_factura_fc').AsString) then
        iNumLinea := 1;

      DFactura.mtFacturas_Det.Append;

      DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').asString := FieldByName('empresa_sc').asString;
      DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').asString := FieldByName('centro_salida_sc').asString;
      DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').asInteger := FieldByName('n_albaran_sc').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').asDateTime := FieldByName('fecha_sc').aSDateTime;
      DFactura.mtFacturas_Det.FieldByName('cod_cliente_albaran_fd').asString := FieldByName('cliente_sal_sc').asString;
      DFactura.mtFacturas_Det.FieldByName('cod_dir_sum_fd').AsString := FieldByName('dir_sum_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('pedido_fd').AsString:= FieldByName('n_pedido_sc').AsString;
      if FieldByName('fecha_pedido_sc').AsString <> '' then
        DFactura.mtFacturas_Det.FieldByName('fecha_pedido_fd').AsDateTime := FieldByName('fecha_pedido_sc').AsDateTime;
      DFactura.mtFacturas_Det.FieldByName('matricula_fd').AsString := FieldByName('vehiculo_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('emp_procedencia_fd').AsString := FieldByName('emp_procedencia_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('centro_origen_fd').AsString := FieldByName('centro_origen_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('cod_producto_fd').AsString := FieldByName('producto_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('des_producto_fd').AsString := DescripcionProducto;
      DFactura.mtFacturas_Det.FieldByName('cod_envase_fd').AsString := FieldByName('envase_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('des_envase_fd').AsString := DescripcionEnvase(FieldByname('empresa_sc').AsString,
                                                                                         FieldByname('producto_sl').AsString,
                                                                                         FieldByname('envase_sl').AsString,
                                                                                         FieldByname('cliente_sal_sc').AsString);
      DFactura.mtFacturas_Det.FieldByName('categoria_fd').AsString := FieldByName('categoria_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('calibre_fd').AsString := FieldByName('calibre_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('marca_fd').AsString := FieldByName('marca_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('nom_marca_fd').AsString := DesMarca(FieldByName('marca_sl').AsString);
      DFactura.mtFacturas_Det.FieldByName('cajas_fd').AsInteger := FieldByName('cajas_sl').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('unidades_caja_fd').AsInteger := FieldByName('unidades_caja_sl').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('unidades_fd').AsInteger := FieldByName('cajas_sl').AsInteger *
                                                                           FieldByName('unidades_caja_sl').AsInteger;
      DFactura.mtFacturas_Det.FieldByName('kilos_fd').AsFloat := FieldByName('kilos_sl').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('kilos_posei_fd').AsFloat := FieldByName('kilos_posei_sl').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('unidad_facturacion_fd').AsString := FieldByName('unidad_precio_sl').AsString;
      DFactura.mtFacturas_Det.FieldByName('precio_fd').AsFloat := FieldByName('precio_sl').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('importe_linea_fd').AsFloat := FieldByName('importe_neto_sl').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('cod_representante_fd').AsString := FieldbyName('representante_c').AsString;

      rComision := GetPorcentajeComision(FieldByName('representante_c').AsString,
                                         FieldByName('fechaFacturacion').AsDatetime);
      rDescuento:= GetPorcentajeDescuento(FieldByName('empresa_sc').AsString,
                                          FieldByName('cliente_sal_sc').asString,
                                          FieldByName('centro_salida_sc').asString,
                                          FieldByName('producto_sl').AsString,
                                          FieldByName('fechaFacturacion').AsDatetime);
      rEurosKg:= GetEurosKg(FieldByName('empresa_sc').AsString,
                            FieldByName('cliente_sal_sc').asString,
                            FieldByName('centro_salida_sc').asString,
                            FieldByName('producto_sl').AsString,
                            FieldByName('fechaFacturacion').AsDatetime);

      rEurosPale:= GetEurosPale(FieldByName('empresa_sc').AsString,
                                FieldByName('cliente_sal_sc').asString,
                                FieldByName('centro_salida_sc').asString,
                                FieldByName('producto_sl').AsString,
                                FieldByName('fechaFacturacion').AsDatetime);

      rImpComision := bRoundTo(FieldByName('importe_neto_sl').AsFloat * rComision/100, 2);
      rImpDescuento:= bRoundTo((FieldByName('importe_neto_sl').AsFloat - rImpComision) * rDescuento/100, 2);
      rImpEurosKg := bRoundTo(FieldByName('kilos_sl').AsFloat * rEurosKg);
      rImpEurosPale := bRoundTo(FieldByName('palets_sl').AsFloat * rEurosPale);

      DFactura.mtFacturas_Det.FieldByName('porcentaje_comision_fd').AsFloat := rComision;
      DFactura.mtFacturas_Det.FieldByName('porcentaje_descuento_fd').AsFloat := rDescuento;
      DFactura.mtFacturas_Det.FieldByName('euroskg_fd').AsFloat := rEurosKg;
      DFactura.mtFacturas_Det.FieldByName('importe_comision_fd').AsFloat := rImpComision;
      DFactura.mtFacturas_Det.FieldByName('importe_descuento_fd').AsFloat := rImpDescuento;
      DFactura.mtFacturas_Det.FieldByName('importe_euroskg_fd').AsFloat := rImpEurosKg+rImpEurosPale;
      DFactura.mtFacturas_Det.FieldByName('importe_total_descuento_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_comision_fd').AsFloat +
                                                                                   DFactura.mtFacturas_Det.FieldByName('importe_descuento_fd').AsFloat +
                                                                                   DFactura.mtFacturas_Det.FieldByName('importe_euroskg_fd').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_linea_fd').AsFloat -
                                                                             DFactura.mtFacturas_Det.FieldByName('importe_total_descuento_fd').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('tasa_impuesto_fd').AsInteger := FieldByName('tipo_iva_e').AsInteger;
      rImpuesto := FieldByName('porc_iva_sl').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsFloat := rImpuesto;
      DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat := bRoundTo(DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat * rImpuesto/100, 2);
//      DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat * rImpuesto/100;
      DFactura.mtFacturas_Det.FieldByName('importe_total_fd').AsFloat := DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsFloat +
                                                                              DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsFloat;
      DFactura.mtFacturas_Det.FieldByName('cod_comercial_fd').AsString := FieldByName('comercial_sl').AsString;

      DFactura.mtFacturas_Det.FieldByName('cod_empresa_fac_fd').AsString := FieldByName('empresaFacturacion').asString;
      DFactura.mtFacturas_Det.FieldByName('cod_serie_fac_fd').AsString := FieldByName('serieFacturacion').asString;
      DFactura.mtFacturas_Det.FieldByName('fecha_fac_fd').AsDateTime := FieldByName('fechaFacturacion').AsDateTime;
      DFactura.mtFacturas_Det.FieldByName('cod_cliente_fac_fd').AsString := FieldByName('clienteFacturacion').AsString;
      DFactura.mtFacturas_Det.FieldByName('moneda_fd').AsString := FieldByName('moneda_sc').AsString;
      DFactura.mtFacturas_Det.FieldByName('tipo_iva_fd').AsString := FieldByName('tipo_iva_sl').AsString;
      //if FieldByName('porte_bonny_sc').asInteger = 1 then
      begin
        DFactura.mtFacturas_Det.FieldByName('incoterm_fd').AsString := FieldByName('incoterm_sc').AsString;
        DFactura.mtFacturas_Det.FieldByName('plaza_incoterm_fd').AsString := FieldByName('plaza_incoterm_sc').AsString;
      end;
      (*
      else
      begin
        DFactura.mtFacturas_Det.FieldByName('incoterm_fd').AsString := '';
        DFactura.mtFacturas_Det.FieldByName('plaza_incoterm_fd').AsString := '';
      end;
      *)
      DFactura.mtFacturas_Det.FieldByName('facturable_fd').AsInteger := FieldByName('facturable_sc').AsInteger;

        //Para Proceso de Repeticion Facturas
      if ARepFactura then
      begin
        DFactura.mtFacturas_Det.FieldByName('fac_interno_fd').AsInteger := FieldByName('fac_interno_fd').AsInteger;
        DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString := FieldByName('cod_factura_fc').AsString;
        DFactura.mtFacturas_Det.FieldByName('num_linea_fd').AsInteger := iNumLinea;
        inc(iNumLinea);
        sCodFactura := FieldByName('cod_factura_fc').AsString;
      end;

      try
        DFactura.mtFacturas_Det.Post;
      except
        DFactura.mtFacturas_Det.Cancel;
        raise;
      end;
      Next;
    end;
    Close;
  end;
end;

procedure RellenaMemGastosFacturas(ARepFactura: Boolean);
begin
  with DFactura.QGeneral do
  begin
    First;
    DFactura.mtFacturas_Gas.Open ;
    while not Eof do
    begin
      DFactura.mtFacturas_Gas.Append;

      DFactura.mtFacturas_Gas.FieldByName('cod_empresa_albaran_fg').AsString := FieldByName('empresa_g').asString;
      DFactura.mtFacturas_Gas.FieldByName('cod_centro_albaran_fg').AsString := FieldByName('centro_salida_g').asString;
      DFactura.mtFacturas_Gas.FieldByName('n_albaran_fg').AsString := FieldByName('n_albaran_g').asString;
      DFactura.mtFacturas_Gas.FieldByName('fecha_albaran_fg').AsDateTime := FieldByName('fecha_g').asDateTime;
      DFactura.mtFacturas_Gas.FieldByName('cod_tipo_gasto_fg').AsString := FieldByName('tipo_g').asString;
      DFactura.mtFacturas_Gas.FieldByName('des_tipo_gasto_fg').AsString := FieldByName('descripcion_tg').asString;
      DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsFloat := FieldByName('importe_g').AsFloat;
      DFactura.mtFacturas_Gas.FieldByName('tasa_impuesto_fg').AsInteger := FieldByName('tipo_iva_tg').AsInteger;
      DFactura.mtFacturas_Gas.FieldByName('porcentaje_impuesto_fg').AsFloat := FieldByName('porcentaje_iva').AsFloat;
      DFactura.mtFacturas_Gas.FieldByName('importe_impuesto_fg').AsFloat := bRoundTo(DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsFloat *
                                                                                          DFactura.mtFacturas_Gas.FieldByName('porcentaje_impuesto_fg').AsFloat/100, 2);
      DFactura.mtFacturas_Gas.FieldByName('importe_total_fg').AsFloat := DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsFloat +
                                                                              DFactura.mtFacturas_Gas.FieldByName('importe_impuesto_fg').AsFloat;
      DFactura.mtFacturas_Gas.FieldByName('cod_empresa_fac_fg').AsString := DFactura.mtFacturas_Det.FieldByName('cod_empresa_fac_fd').AsString;
      DFactura.mtFacturas_Gas.FieldByName('fecha_fac_fg').AsDateTime := DFactura.mtFacturas_Det.FieldByName('fecha_fac_fd').AsDateTime;
      DFactura.mtFacturas_Gas.FieldByName('fac_interno_fg').AsString := DFactura.mtFacturas_Det.FieldByName('fac_interno_fd').AsString;

      if ARepFactura then
        DFactura.mtFacturas_Gas.FieldByName('cod_factura_fg').AsString := DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString;

      try
        DFactura.mtFacturas_Gas.Post;
      except
        DFactura.mtFacturas_Gas.Cancel;
        raise;
      end;
      Next;
    end;
  end;
end;
function  NewCodigoFactura( const AEmpresa, ATipo, AImpuesto, ASerie: string;
                            const AFechaFactura: TDateTime;
                            const AFactura: integer ): string;
begin
  result:= GetPrefijoFactura( AEmpresa, ATipo, AImpuesto, ASerie, AFechaFactura ) +
           NewContadorFactura( AFactura );

end;

function  GetPrefijoFactura( const AEmpresa, ATipo, AImpuesto, ASerie: string;
                             const AFechaFactura: TDateTime ): string;
var
  iAnyo, iMes, iDia: word;
  sAux, sEmpresa, sSerie, sPref: string;
begin
  result:= 'ERROR ';
  DecodeDate( AFechaFactura, iAnyo, iMes, iDia );
  sAux:= IntToStr( iAnyo );
  sAux:= Copy( sAux, 3, 2 );

  if AEmpresa = '080' then
  begin
    sEmpresa:= '050';                     //Se facturar� todo a la 050 desde 01/01/2019
  end
  else
  begin
    sEmpresa:= AEmpresa;
  end;
  sSerie := ASerie;

  with DFactura.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_serie ');
    SQL.Add(' where exists ');
    SQL.Add(' ( ');
    SQL.Add('   select *  from frf_empresas_serie ');
    SQL.Add('   where cod_empresa_es = :empresa ');
    SQL.Add('   and anyo_es = :anyo ');
    SQL.Add('   and cod_serie_es = :serie ');
    SQL.Add('   and cod_serie_es = cod_serie_fs ');
    SQL.Add('   and anyo_es = anyo_fs ');
    SQL.Add(' ) ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('anyo').AsInteger:= iAnyo;
    ParamByName('serie').AsString:= sSerie;
    Open;
    if not IsEmpty then
    begin
      if Copy( AImpuesto, 1, 1 ) = 'I' then
      begin
        if ATipo = '380' then
        begin
          sPref := FieldByName('pre_fac_iva_fs').AsString;
          result:= sPref + '-' + sEmpresa + sAux + '-';
//          result:= 'FCP-' + sEmpresa + sAux + '-';
        end
        else
        begin
          sPref := FieldByName('pre_abn_iva_fs').AsString;
          result:= sPref + '-' + sEmpresa + sAux + '-';
//          result:= 'ACP-' + sEmpresa + sAux + '-';
        end;
      end
      else
      begin
        if ATipo = '380' then
        begin
          sPref := FieldByName('pre_fac_igic_fs').AsString;
          result:= sPref + '-' + sEmpresa + sAux + '-';
//          result:= 'FCT-' + sEmpresa + sAux + '-';
        end
        else
        begin
          sPref := FieldByName('pre_abn_igic_fs').AsString;
          result:= sPref + '-' + sEmpresa + sAux + '-';
//          result:= 'ACT-' + sEmpresa + sAux + '-';
        end;
      end;
    end;
  end;
end;

function  NewContadorFactura( const AFactura: integer ): string;
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

function TDFactura.ClaveFactura(const AEmpresa, AImpuesto, ATipoFact, ASerie: string;
                                const AFecha: TDateTime; var ANumero: integer): boolean;
var
  iYear, iMonth, iDay: Word;
begin
  with DFactura.QAux do
  begin
    DecodeDate( AFecha, iYear, iMonth, iDay );

    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_serie ');
    SQL.Add(' where exists ');
    SQL.Add(' ( ');
    SQL.Add('   select *  from frf_empresas_serie ');
    SQL.Add('   where cod_empresa_es = :empresa ');
    SQL.Add('   and anyo_es = :anyo ');
    SQL.Add('      and cod_serie_es = :serie ');
    SQL.Add('   and cod_serie_es = cod_serie_fs ');
    SQL.Add('   and anyo_es = anyo_fs ');
    SQL.Add(' ) ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('anyo').AsInteger:= iYear;
    ParamByName('serie').AsString:= ASerie;
    Open;
    if not IsEmpty then
    begin
      if ATipoFact = 'A' then
      begin
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'I' then
        begin
          ANumero:= FieldByName('abn_iva_fs').AsInteger + 1;
          result:= True;
        end
        else
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'G' then
        begin
          ANumero:= FieldByName('abn_igic_fs').AsInteger + 1;
          result:= True;
        end
        else
        begin
          result:= False;
        end;
      end
      else
      begin
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'I' then
        begin
          ANumero:= FieldByName('fac_iva_fs').AsInteger + 1;
          result:= True;
        end
        else
        if UpperCase( Copy( AImpuesto, 1, 1 ) ) = 'G' then
        begin
          ANumero:= FieldByName('fac_igic_fs').AsInteger + 1;
          result:= True;
        end
        else
        begin
          result:= False;
        end;
      end;
    end
    else
    begin
      result:= False;
    end;
    Close;
  end;
end;

function ComprobarClavePrimaria(const AEmpresa, ASerie: string; const AFactura, AAnyo: Integer): Integer;
var QClaveFactura: TBonnyQuery;
begin
  Result := -1;

  QClaveFactura := TBonnyQuery.Create(nil);
  with QClaveFactura do
  try
    SQL.Add(' SELECT * ');
    SQL.Add(' FROM tfacturas_cab ');
    SQL.Add(' WHERE cod_empresa_fac_fc =' + quotedstr(AEmpresa) + ' ');
    SQL.Add(' AND n_factura_fc =' + IntToStr(AFactura) + ' ');
    SQL.Add(' AND YEAR(fecha_factura_fc) = ' + IntToStr(AAnyo) + ' ');
    SQL.Add(' AND cod_serie_fac_fc = ' + quotedstr(ASerie) + ' ');

    Open;
    if IsEmpty then
    begin
      result:= AFactura;
    end;
    Close;
  finally
    Free;
  end;
end;

procedure TDFactura.DataModuleCreate(Sender: TObject);
begin

  with mtFacturas_Cab do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fc', ftString, 15, False);
    FieldDefs.Add('cod_empresa_fac_fc', ftString, 3, False);
    FieldDefs.Add('cod_serie_fac_fc', ftString, 3, False);
    FieldDefs.Add('n_factura_fc', ftInteger, 0, False);
    FieldDefs.Add('fecha_factura_fc', ftDate, 0, False);
    FieldDefs.Add('impuesto_fc', ftString, 1, False);
    FieldDefs.Add('tipo_factura_fc', ftString, 3, False);
    FieldDefs.Add('automatica_fc', ftInteger, 0, False);
    FieldDefs.Add('anulacion_fc', ftInteger, 0, False);
    FieldDefs.Add('cod_factura_anula_fc', ftString, 15, False);
    FieldDefs.Add('cod_cliente_fc', ftString, 3, False);
    FieldDefs.Add('des_cliente_fc', ftString, 35, False);
    FieldDefs.Add('cta_cliente_fc', ftString, 10, False);
    FieldDefs.Add('nif_fc', ftString, 14, False);
    FieldDefs.Add('tipo_via_fc', ftString, 2, False);
    FieldDefs.Add('domicilio_fc', ftString, 40, False);
    FieldDefs.Add('poblacion_fc', ftString, 30, False);
    FieldDefs.Add('cod_postal_fc', ftString, 15, False);
    FieldDefs.Add('provincia_fc', ftString, 30, False);
    FieldDefs.Add('cod_pais_fc', ftString, 2, False);
    FieldDefs.Add('des_pais_fc', ftString, 30, False);
    FieldDefs.Add('notas_fc', ftString, 512, False);
    FieldDefs.Add('incoterm_fc', ftString, 3, False);
    FieldDefs.Add('plaza_incoterm_fc', ftString, 30, False);
    FieldDefs.Add('forma_pago_fc', ftString, 2, False);
    FieldDefs.Add('des_forma_pago_fc', ftString, 512, False);
    FieldDefs.Add('tipo_impuesto_fc', ftString, 2, False);
    FieldDefs.Add('des_tipo_impuesto_fc', ftString, 50, False);
    FieldDefs.Add('moneda_fc', ftString, 3, False);
    FieldDefs.Add('importe_linea_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_descuento_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_euros_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_euros_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_total_euros_fc', ftFloat, 0, False);
    FieldDefs.Add('fecha_fac_ini_fc', ftDate, 0, False);
    FieldDefs.Add('prevision_cobro_fc', ftDate, 0, False);
    FieldDefs.Add('prevision_tesoreria_fc', ftDate, 0, False);
    FieldDefs.Add('contabilizado_fc', ftString, 1, False);
    FieldDefs.Add('fecha_conta_fc', ftDate, 0, False);
    FieldDefs.Add('filename_conta_fc', ftString, 30, False);

    FieldDefs.Add('fac_interno_fc', ftInteger, 0, False);

    CreateTable;

//    IndexFieldNames:= 'fac_interno_fc';
//    SortFields := 'fac_interno_fc';

  end;

  with mtFacturas_Det do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fd', ftString, 15, False);
    FieldDefs.Add('num_linea_fd', ftInteger, 0, False);
    FieldDefs.Add('cod_empresa_albaran_fd', ftString, 3, False);
    FieldDefs.Add('cod_centro_albaran_fd', ftString, 3, False);
    FieldDefs.Add('n_albaran_fd', ftInteger, 0, False);
    FieldDefs.Add('fecha_albaran_fd', ftDate, 0, False);
    FieldDefs.Add('cod_cliente_albaran_fd', ftString, 3, False);
    FieldDefs.Add('cod_dir_sum_fd', ftString, 3, False);
    FieldDefs.Add('pedido_fd', ftString, 15, False);
    FieldDefs.Add('fecha_pedido_fd', ftDate, 0, False);
    FieldDefs.Add('matricula_fd', ftString, 30, False);
    FieldDefs.Add('emp_procedencia_fd', ftString, 3, False);
    FieldDefs.Add('centro_origen_fd', ftString, 1, False);
    FieldDefs.Add('cod_producto_fd', ftString, 3, False);
    FieldDefs.Add('des_producto_fd', ftString, 30, False);
    FieldDefs.Add('cod_envase_fd', ftString, 9,  False);
    FieldDefs.Add('des_envase_fd', ftString, 30, False);
    FieldDefs.Add('categoria_fd', ftString, 2, False);
    FieldDefs.Add('calibre_fd', ftString, 6, False);
    FieldDefs.Add('marca_fd', ftString, 2, False);
    FieldDefs.Add('nom_marca_fd', ftString, 30, False);
    FieldDefs.Add('cajas_fd', ftInteger, 0, False);
    FieldDefs.Add('unidades_caja_fd', ftInteger, 0, False);
    FieldDefs.Add('unidades_fd', ftInteger, 0, False);
    FieldDefs.Add('kilos_fd', ftFloat, 0, False);
    FieldDefs.Add('kilos_posei_fd', ftFloat, 0, False);
    FieldDefs.Add('unidad_facturacion_fd', ftString, 3, False);
    FieldDefs.Add('precio_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_linea_fd', ftFloat, 0, False);
    FieldDefs.Add('cod_representante_fd', ftString, 3, False);
    FieldDefs.Add('porcentaje_comision_fd', ftFloat, 0, False);
    FieldDefs.Add('porcentaje_descuento_fd', ftFloat, 0, False);
    FieldDefs.Add('euroskg_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_comision_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_descuento_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_euroskg_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_total_descuento_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_fd', ftFloat, 0, False);
    FieldDefs.Add('tasa_impuesto_fd', ftString, 1, False);
    FieldDefs.Add('porcentaje_impuesto_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fd', ftFloat, 0, False);
    FieldDefs.Add('cod_comercial_fd', ftString, 3, False);

    FieldDefs.Add('cod_empresa_fac_fd', ftString, 3, False);
    FieldDefs.Add('cod_serie_fac_fd', ftString, 3, False);
    FieldDefs.Add('fecha_fac_fd', ftDate, 0, False);
    FieldDefs.Add('fac_interno_fd', ftInteger, 0, False);
    FieldDefs.Add('cod_cliente_fac_fd', ftString, 3, False);
    FieldDefs.Add('moneda_fd', ftString, 3, False);
    FieldDefs.Add('tipo_iva_fd', ftString, 2, False);
    FieldDefs.Add('incoterm_fd', ftString, 3, False);
    FieldDefs.Add('plaza_incoterm_fd', ftString, 30, False);
    FieldDefs.Add('facturable_fd', ftInteger, 0, False);

    CreateTable;

//    IndexFieldNames:= 'fecha_albaran_fd; pedido_fd; n_albaran_fd; cod_dir_sum_fd; cod_producto_fd; cod_envase_fd';
//    SortFields := 'fac_interno_fd; fecha_albaran_fd; pedido_fd; n_albaran_fd; cod_dir_sum_fd; cod_producto_fd; cod_envase_fd';

  end;

  with mtFacturas_Gas do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fg', ftString, 15, False);
    FieldDefs.Add('cod_empresa_albaran_fg', ftString, 3, False);
    FieldDefs.Add('cod_centro_albaran_fg', ftString, 3, False);
    FieldDefs.Add('n_albaran_fg', ftInteger, 0, False);
    FieldDefs.Add('fecha_albaran_fg', ftDate, 0, False);
    FieldDefs.Add('cod_tipo_gasto_fg', ftString, 3, False);
    FieldDefs.Add('des_tipo_gasto_fg', ftString, 30, False);
    FieldDefs.Add('importe_neto_fg', ftFloat, 0, False);
    FieldDefs.Add('tasa_impuesto_fg', ftString, 1, False);
    FieldDefs.Add('porcentaje_impuesto_fg', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fg', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fg', ftFloat, 0, False);

    FieldDefs.Add('cod_empresa_fac_fg', ftString, 3, False);
    FieldDefs.Add('fecha_fac_fg', ftDate, 0, False);
    FieldDefs.Add('fac_interno_fg', ftInteger, 0, False);

    CreateTable;

//    IndexFieldNames := 'cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg';

  end;
  with mtFacturas_Bas do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fb', ftString, 15, False);
    FieldDefs.Add('tasa_impuesto_fb', ftString, 1, False);
    FieldDefs.Add('porcentaje_impuesto_fb', ftFloat, 0, False);
    FieldDefs.Add('cajas_fb', ftInteger, 0, False);
    FieldDefs.Add('unidades_fb', ftInteger, 0, False);
    FieldDefs.Add('kilos_fb', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_fb', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fb', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fb', ftFloat, 0, False);

    FieldDefs.Add('cod_empresa_fac_fb', ftString, 3, False);
    FieldDefs.Add('fecha_fac_fb', ftDate, 0, False);
    FieldDefs.Add('fac_interno_fb', ftInteger, 0, False);

    CreateTable;

//    IndexFieldNames := 'cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg';

  end;

// tablas2
  with mtFacturas_Cab2 do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fc', ftString, 15, False);
    FieldDefs.Add('cod_empresa_fac_fc', ftString, 3, False);
    FieldDefs.Add('cod_serie_fac_fc', ftString, 3, False);
    FieldDefs.Add('n_factura_fc', ftInteger, 0, False);
    FieldDefs.Add('fecha_factura_fc', ftDate, 0, False);
    FieldDefs.Add('impuesto_fc', ftString, 1, False);
    FieldDefs.Add('tipo_factura_fc', ftString, 3, False);
    FieldDefs.Add('automatica_fc', ftInteger, 0, False);
    FieldDefs.Add('anulacion_fc', ftInteger, 0, False);
    FieldDefs.Add('cod_factura_anula_fc', ftString, 15, False);
    FieldDefs.Add('cod_cliente_fc', ftString, 3, False);
    FieldDefs.Add('des_cliente_fc', ftString, 35, False);
    FieldDefs.Add('cta_cliente_fc', ftString, 10, False);
    FieldDefs.Add('nif_fc', ftString, 14, False);
    FieldDefs.Add('tipo_via_fc', ftString, 2, False);
    FieldDefs.Add('domicilio_fc', ftString, 40, False);
    FieldDefs.Add('poblacion_fc', ftString, 30, False);
    FieldDefs.Add('cod_postal_fc', ftString, 15, False);
    FieldDefs.Add('provincia_fc', ftString, 30, False);
    FieldDefs.Add('cod_pais_fc', ftString, 2, False);
    FieldDefs.Add('des_pais_fc', ftString, 30, False);
    FieldDefs.Add('notas_fc', ftString, 512, False);
    FieldDefs.Add('incoterm_fc', ftString, 3, False);
    FieldDefs.Add('plaza_incoterm_fc', ftString, 30, False);
    FieldDefs.Add('forma_pago_fc', ftString, 2, False);
    FieldDefs.Add('des_forma_pago_fc', ftString, 512, False);
    FieldDefs.Add('tipo_impuesto_fc', ftString, 2, False);
    FieldDefs.Add('des_tipo_impuesto_fc', ftString, 50, False);
    FieldDefs.Add('moneda_fc', ftString, 3, False);
    FieldDefs.Add('importe_linea_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_descuento_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_euros_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_euros_fc', ftFloat, 0, False);
    FieldDefs.Add('importe_total_euros_fc', ftFloat, 0, False);
    FieldDefs.Add('fecha_fac_ini_fc', ftDate, 0, False);
    FieldDefs.Add('prevision_cobro_fc', ftDate, 0, False);
    FieldDefs.Add('prevision_tesoreria_fc', ftDate, 0, False);
    FieldDefs.Add('contabilizado_fc', ftString, 1, False);
    FieldDefs.Add('fecha_conta_fc', ftDate, 0, False);
    FieldDefs.Add('filename_conta_fc', ftString, 30, False);

    FieldDefs.Add('fac_interno_fc', ftInteger, 0, False);

    CreateTable;

//    IndexFieldNames:= 'fac_interno_fc';
//    SortFields := 'fac_interno_fc';

  end;

  with mtFacturas_Det2 do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fd', ftString, 15, False);
    FieldDefs.Add('num_linea_fd', ftInteger, 0, False);
    FieldDefs.Add('cod_empresa_albaran_fd', ftString, 3, False);
    FieldDefs.Add('cod_centro_albaran_fd', ftString, 3, False);
    FieldDefs.Add('n_albaran_fd', ftInteger, 0, False);
    FieldDefs.Add('fecha_albaran_fd', ftDate, 0, False);
    FieldDefs.Add('cod_cliente_albaran_fd', ftString, 3, False);
    FieldDefs.Add('cod_dir_sum_fd', ftString, 3, False);
    FieldDefs.Add('pedido_fd', ftString, 15, False);
    FieldDefs.Add('fecha_pedido_fd', ftDate, 0, False);
    FieldDefs.Add('matricula_fd', ftString, 30, False);
    FieldDefs.Add('emp_procedencia_fd', ftString, 3, False);
    FieldDefs.Add('centro_origen_fd', ftString, 1, False);
    FieldDefs.Add('cod_producto_fd', ftString, 3, False);
    FieldDefs.Add('des_producto_fd', ftString, 30, False);
    FieldDefs.Add('cod_envase_fd', ftString, 9,  False);
    FieldDefs.Add('des_envase_fd', ftString, 30, False);
    FieldDefs.Add('categoria_fd', ftString, 2, False);
    FieldDefs.Add('calibre_fd', ftString, 6, False);
    FieldDefs.Add('marca_fd', ftString, 2, False);
    FieldDefs.Add('nom_marca_fd', ftString, 30, False);
    FieldDefs.Add('cajas_fd', ftInteger, 0, False);
    FieldDefs.Add('unidades_caja_fd', ftInteger, 0, False);
    FieldDefs.Add('unidades_fd', ftInteger, 0, False);
    FieldDefs.Add('kilos_fd', ftFloat, 0, False);
    FieldDefs.Add('kilos_posei_fd', ftFloat, 0, False);
    FieldDefs.Add('unidad_facturacion_fd', ftString, 3, False);
    FieldDefs.Add('precio_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_linea_fd', ftFloat, 0, False);
    FieldDefs.Add('cod_representante_fd', ftString, 3, False);
    FieldDefs.Add('porcentaje_comision_fd', ftFloat, 0, False);
    FieldDefs.Add('porcentaje_descuento_fd', ftFloat, 0, False);
    FieldDefs.Add('euroskg_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_comision_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_descuento_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_euroskg_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_total_descuento_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_fd', ftFloat, 0, False);
    FieldDefs.Add('tasa_impuesto_fd', ftString, 1, False);
    FieldDefs.Add('porcentaje_impuesto_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fd', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fd', ftFloat, 0, False);
    FieldDefs.Add('cod_comercial_fd', ftString, 3, False);

    FieldDefs.Add('cod_empresa_fac_fd', ftString, 3, False);
    FieldDefs.Add('cod_serie_fac_fd', ftString, 3, False);
    FieldDefs.Add('fecha_fac_fd', ftDate, 0, False);
    FieldDefs.Add('fac_interno_fd', ftInteger, 0, False);
    FieldDefs.Add('cod_cliente_fac_fd', ftString, 3, False);
    FieldDefs.Add('moneda_fd', ftString, 3, False);
    FieldDefs.Add('tipo_iva_fd', ftString, 2, False);
    FieldDefs.Add('incoterm_fd', ftString, 3, False);
    FieldDefs.Add('plaza_incoterm_fd', ftString, 30, False);
    FieldDefs.Add('facturable_fd', ftInteger, 0, False);

    CreateTable;

//    IndexFieldNames:= 'fecha_albaran_fd; pedido_fd; n_albaran_fd; cod_dir_sum_fd; cod_producto_fd; cod_envase_fd';
//    SortFields := 'fac_interno_fd; fecha_albaran_fd; pedido_fd; n_albaran_fd; cod_dir_sum_fd; cod_producto_fd; cod_envase_fd';

  end;

  with mtFacturas_Gas2 do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fg', ftString, 15, False);
    FieldDefs.Add('cod_empresa_albaran_fg', ftString, 3, False);
    FieldDefs.Add('cod_centro_albaran_fg', ftString, 3, False);
    FieldDefs.Add('n_albaran_fg', ftInteger, 0, False);
    FieldDefs.Add('fecha_albaran_fg', ftDate, 0, False);
    FieldDefs.Add('cod_tipo_gasto_fg', ftString, 3, False);
    FieldDefs.Add('des_tipo_gasto_fg', ftString, 30, False);
    FieldDefs.Add('importe_neto_fg', ftFloat, 0, False);
    FieldDefs.Add('tasa_impuesto_fg', ftString, 1, False);
    FieldDefs.Add('porcentaje_impuesto_fg', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fg', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fg', ftFloat, 0, False);

    FieldDefs.Add('cod_empresa_fac_fg', ftString, 3, False);
    FieldDefs.Add('fecha_fac_fg', ftDate, 0, False);
    FieldDefs.Add('fac_interno_fg', ftInteger, 0, False);

    CreateTable;

//    IndexFieldNames := 'cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg';

  end;
  with mtFacturas_Bas2 do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_factura_fb', ftString, 15, False);
    FieldDefs.Add('tasa_impuesto_fb', ftString, 1, False);
    FieldDefs.Add('porcentaje_impuesto_fb', ftFloat, 0, False);
    FieldDefs.Add('cajas_fb', ftInteger, 0, False);
    FieldDefs.Add('unidades_fb', ftInteger, 0, False);
    FieldDefs.Add('kilos_fb', ftFloat, 0, False);
    FieldDefs.Add('importe_neto_fb', ftFloat, 0, False);
    FieldDefs.Add('importe_impuesto_fb', ftFloat, 0, False);
    FieldDefs.Add('importe_total_fb', ftFloat, 0, False);

    FieldDefs.Add('cod_empresa_fac_fb', ftString, 3, False);
    FieldDefs.Add('fecha_fac_fb', ftDate, 0, False);
    FieldDefs.Add('fac_interno_fb', ftInteger, 0, False);

    CreateTable;

//    IndexFieldNames := 'cod_factura_fg;fecha_albaran_fg;n_albaran_fg;cod_tipo_gasto_fg';

  end;



end;

procedure TDFactura.DataModuleDestroy(Sender: TObject);
begin
  mtFacturas_Cab.Close;
  mtFacturas_Det.Close;
  mtFacturas_Gas.Close;
  mtFacturas_Bas.Close;

  mtFacturas_Cab2.Close;
  mtFacturas_Det2.Close;
  mtFacturas_Gas2.Close;
  mtFacturas_Bas2.Close;
end;

function DatosTotalDescuento( const CodFactura: String ): TRImportesCabecera;
var
  i, iPorComision, iPorDescuento, iPorEurosKg: Integer;
  flag: boolean;
  sFiltro_Det: string;
begin
  (*%COMISION* *%DESCUENTO* *EUROS-KG*)
  iPorDescuento:=0;
  iPorComision:=0;
  iPorEurosKg:=0;

  sFiltro_Det := 'cod_factura_fd = ' + QuotedStr(CodFactura);

      //DETALLE
  DFactura.mtFacturas_Det.Filter := sFiltro_Det;
  DFactura.mtFacturas_Det.Filtered := true;
  DFactura.mtFacturas_Det.First;
  while not DFactura.mtFacturas_Det.Eof do
  begin
    (*INICIALIZAR %COMISION*)
    i:=0;
    flag:= False;
    while (i < iPorComision) and (not flag) do
    begin
      if DFactura.mtFacturas_Det.FieldByName('porcentaje_comision_fd').AsFloat = Result.aRImportesComision[i].rPorcentaje then
        flag := true
      else
        inc(i);
    end;
    if (DFactura.mtFacturas_Det.FieldByName('porcentaje_comision_fd').AsFloat <> 0) and
      (not flag) then
    begin
      SetLength( Result.aRImportesComision, iPorComision + 1);
      Result.aRImportesComision[iPorComision].rPorcentaje:= DFactura.mtFacturas_Det.FieldByName('porcentaje_comision_fd').AsFloat;
      Result.aRImportesComision[i].rImporteBase:= 0;
      Result.aRImportesComision[i].rTotalImporte:= 0;
      iPorComision:= iPorComision + 1;
      end;


    (*INICIALIZAR %DESCUENTO*)
    i:=0;
    flag:= False;
    while (i < iPorDescuento) and (not flag) do
    begin
      if DFactura.mtFacturas_Det.FieldByName('porcentaje_descuento_fd').AsFloat = Result.aRImportesDescuento[i].rPorcentaje then
        flag := true
      else
        inc(i);
    end;
    if (DFactura.mtFacturas_Det.FieldByName('porcentaje_descuento_fd').AsFloat <> 0) and
       (not flag) then
    begin
      SetLength( Result.aRImportesDescuento, iPorDescuento + 1);
      Result.aRImportesDescuento[iPorDescuento].rPorcentaje:= DFactura.mtFacturas_Det.FieldByName('porcentaje_descuento_fd').AsFloat;
      Result.aRImportesDescuento[i].rImporteBase:= 0;
      Result.aRImportesDescuento[i].rTotalImporte:= 0;
      iPorDescuento:= iPorDescuento + 1;
      end;

    //DFactura.mtFacturas_Det.Next;

    (*INICIALIZAR EurosKg*)
    i:=0;
    flag:= False;
    while (i < iPorEurosKg) and (not flag) do
    begin
      if DFactura.mtFacturas_Det.FieldByName('euroskg_fd').AsFloat = Result.aRImportesEurosKg[i].rPorcentaje then
        flag := true
      else
        inc(i);
    end;
    if (DFactura.mtFacturas_Det.FieldByName('euroskg_fd').AsFloat <> 0) and
       (not flag) then
    begin
      SetLength( Result.aRImportesEurosKg, iPorEurosKg + 1);
      Result.aRImportesEurosKg[iPorEurosKg].rPorcentaje:= DFactura.mtFacturas_Det.FieldByName('euroskg_fd').AsFloat;
      Result.aRImportesEurosKg[i].rImporteBase:= 0;
      Result.aRImportesEurosKg[i].rTotalImporte:= 0;
      iPorEurosKg:= iPorEurosKg + 1;
      end;

    DFactura.mtFacturas_Det.Next;

  end;
  DFactura.mtFacturas_Det.Filtered := false;
  DFactura.mtFacturas_Det.Filter := '';

  (*COMISION*)
  i:=0;
  while i < iPorComision do
  begin
    with DFactura.mtFacturas_Det do
    begin
      Filter := sFiltro_Det + ' AND ' + 'porcentaje_comision_fd = ' + FloatToStr(Result.aRImportesComision[i].rPorcentaje);
      Filtered := true;

      if not IsEmpty then
      begin
        First;

        while not Eof do
        begin
          Result.aRImportesComision[i].rImporteBase := Result.aRImportesComision[i].rImporteBase + fieldbyname('importe_linea_fd').AsFloat;
          Result.aRImportesComision[i].rTotalImporte := Result.aRImportesComision[i].rTotalImporte + fieldbyname('importe_comision_fd').AsFloat;

          Next;
        end;
      end;

      Filter := '';
      Filtered := false;
    end;
    inc(i)
  end;

  (*DESCUESTO*)
  i:=0;
  while i < iPorDescuento do
  begin
    with DFactura.mtFacturas_Det do
    begin
      Filter := sFiltro_Det + ' AND ' + 'porcentaje_descuento_fd = ' + FloatToStr(Result.aRImportesDescuento[i].rPorcentaje);
      Filtered := true;

      if not IsEmpty then
      begin
        First;

        while not Eof do
        begin
          Result.aRImportesDescuento[i].rImporteBase := Result.aRImportesDescuento[i].rImporteBase +
                                                        fieldbyname('importe_linea_fd').AsFloat -
                                                        fieldbyname('importe_comision_fd').AsFloat;
          Result.aRImportesDescuento[i].rTotalImporte := Result.aRImportesDescuento[i].rTotalImporte + fieldbyname('importe_descuento_fd').AsFloat;

          Next;
        end;
      end;

      Filter := '';
      Filtered := false;
    end;
    inc(i)
  end;

  (*EUROSKG*)
  i:=0;
  while i < iPorEurosKg do
  begin
    with DFactura.mtFacturas_Det do
    begin
      Filter := sFiltro_Det + ' AND ' + 'euroskg_fd = ' + FloatToStr(Result.aRImportesEurosKg[i].rPorcentaje);
      Filtered := true;

      if not IsEmpty then
      begin
        First;

        while not Eof do
        begin
          Result.aRImportesEurosKg[i].rImporteBase := Result.aRImportesEurosKg[i].rImporteBase + fieldbyname('kilos_fd').AsFloat;
          Result.aRImportesEurosKg[i].rTotalImporte := Result.aRImportesEurosKg[i].rTotalImporte + fieldbyname('importe_euroskg_fd').AsFloat;

          Next;
        end;
      end;

      Filter := '';
      Filtered := false;
    end;
    inc(i)
  end;

  DFactura.mtFacturas_Det.Filter := sFiltro_Det;
  DFactura.mtFacturas_Det.Filtered := true;

end;

function DatosTotalDescuento2( const CodFactura: String ): TRImportesCabecera;
var
  i, iPorComision, iPorDescuento, iPorEurosKg: Integer;
  flag: boolean;
  sFiltro_Det: string;
begin
  (*%COMISION* *%DESCUENTO* *EUROS-KG*)
  iPorDescuento:=0;
  iPorComision:=0;
  iPorEurosKg:=0;

  sFiltro_Det := 'cod_factura_fd = ' + QuotedStr(CodFactura);

      //DETALLE
  DFactura.mtFacturas_Det2.Filter := sFiltro_Det;
  DFactura.mtFacturas_Det2.Filtered := true;
  DFactura.mtFacturas_Det2.First;
  while not DFactura.mtFacturas_Det2.Eof do
  begin
    (*INICIALIZAR %COMISION*)
    i:=0;
    flag:= False;
    while (i < iPorComision) and (not flag) do
    begin
      if DFactura.mtFacturas_Det2.FieldByName('porcentaje_comision_fd').AsFloat = Result.aRImportesComision[i].rPorcentaje then
        flag := true
      else
        inc(i);
    end;
    if (DFactura.mtFacturas_Det2.FieldByName('porcentaje_comision_fd').AsFloat <> 0) and
      (not flag) then
    begin
      SetLength( Result.aRImportesComision, iPorComision + 1);
      Result.aRImportesComision[iPorComision].rPorcentaje:= DFactura.mtFacturas_Det2.FieldByName('porcentaje_comision_fd').AsFloat;
      Result.aRImportesComision[i].rImporteBase:= 0;
      Result.aRImportesComision[i].rTotalImporte:= 0;
      iPorComision:= iPorComision + 1;
      end;


    (*INICIALIZAR %DESCUENTO*)
    i:=0;
    flag:= False;
    while (i < iPorDescuento) and (not flag) do
    begin
      if DFactura.mtFacturas_Det2.FieldByName('porcentaje_descuento_fd').AsFloat = Result.aRImportesDescuento[i].rPorcentaje then
        flag := true
      else
        inc(i);
    end;
    if (DFactura.mtFacturas_Det2.FieldByName('porcentaje_descuento_fd').AsFloat <> 0) and
       (not flag) then
    begin
      SetLength( Result.aRImportesDescuento, iPorDescuento + 1);
      Result.aRImportesDescuento[iPorDescuento].rPorcentaje:= DFactura.mtFacturas_Det2.FieldByName('porcentaje_descuento_fd').AsFloat;
      Result.aRImportesDescuento[i].rImporteBase:= 0;
      Result.aRImportesDescuento[i].rTotalImporte:= 0;
      iPorDescuento:= iPorDescuento + 1;
      end;

    //DFactura.mtFacturas_Det.Next;

    (*INICIALIZAR EurosKg*)
    i:=0;
    flag:= False;
    while (i < iPorEurosKg) and (not flag) do
    begin
      if DFactura.mtFacturas_Det2.FieldByName('euroskg_fd').AsFloat = Result.aRImportesEurosKg[i].rPorcentaje then
        flag := true
      else
        inc(i);
    end;
    if (DFactura.mtFacturas_Det2.FieldByName('euroskg_fd').AsFloat <> 0) and
       (not flag) then
    begin
      SetLength( Result.aRImportesEurosKg, iPorEurosKg + 1);
      Result.aRImportesEurosKg[iPorEurosKg].rPorcentaje:= DFactura.mtFacturas_Det2.FieldByName('euroskg_fd').AsFloat;
      Result.aRImportesEurosKg[i].rImporteBase:= 0;
      Result.aRImportesEurosKg[i].rTotalImporte:= 0;
      iPorEurosKg:= iPorEurosKg + 1;
      end;

    DFactura.mtFacturas_Det2.Next;

  end;
  DFactura.mtFacturas_Det2.Filtered := false;
  DFactura.mtFacturas_Det2.Filter := '';

  (*COMISION*)
  i:=0;
  while i < iPorComision do
  begin
    with DFactura.mtFacturas_Det2 do
    begin
      Filter := sFiltro_Det + ' AND ' + 'porcentaje_comision_fd = ' + FloatToStr(Result.aRImportesComision[i].rPorcentaje);
      Filtered := true;

      if not IsEmpty then
      begin
        First;

        while not Eof do
        begin
          Result.aRImportesComision[i].rImporteBase := Result.aRImportesComision[i].rImporteBase + fieldbyname('importe_linea_fd').AsFloat;
          Result.aRImportesComision[i].rTotalImporte := Result.aRImportesComision[i].rTotalImporte + fieldbyname('importe_comision_fd').AsFloat;

          Next;
        end;
      end;

      Filter := '';
      Filtered := false;
    end;
    inc(i)
  end;

  (*DESCUESTO*)
  i:=0;
  while i < iPorDescuento do
  begin
    with DFactura.mtFacturas_Det2 do
    begin
      Filter := sFiltro_Det + ' AND ' + 'porcentaje_descuento_fd = ' + FloatToStr(Result.aRImportesDescuento[i].rPorcentaje);
      Filtered := true;

      if not IsEmpty then
      begin
        First;

        while not Eof do
        begin
          Result.aRImportesDescuento[i].rImporteBase := Result.aRImportesDescuento[i].rImporteBase +
                                                        fieldbyname('importe_linea_fd').AsFloat -
                                                        fieldbyname('importe_comision_fd').AsFloat;
          Result.aRImportesDescuento[i].rTotalImporte := Result.aRImportesDescuento[i].rTotalImporte + fieldbyname('importe_descuento_fd').AsFloat;

          Next;
        end;
      end;

      Filter := '';
      Filtered := false;
    end;
    inc(i)
  end;

  (*EUROSKG*)
  i:=0;
  while i < iPorEurosKg do
  begin
    with DFactura.mtFacturas_Det2 do
    begin
      Filter := sFiltro_Det + ' AND ' + 'euroskg_fd = ' + FloatToStr(Result.aRImportesEurosKg[i].rPorcentaje);
      Filtered := true;

      if not IsEmpty then
      begin
        First;

        while not Eof do
        begin
          Result.aRImportesEurosKg[i].rImporteBase := Result.aRImportesEurosKg[i].rImporteBase + fieldbyname('kilos_fd').AsFloat;
          Result.aRImportesEurosKg[i].rTotalImporte := Result.aRImportesEurosKg[i].rTotalImporte + fieldbyname('importe_euroskg_fd').AsFloat;

          Next;
        end;
      end;

      Filter := '';
      Filtered := false;
    end;
    inc(i)
  end;

  DFactura.mtFacturas_Det2.Filter := sFiltro_Det;
  DFactura.mtFacturas_Det2.Filtered := true;

end;

function GetDatosCliente(const AEmpresa, ACliente, ADirSum: string): TRDatosClienteFac;
begin

  with DFactura.QAux do
  begin
    SQl.Clear;
    if ACliente = 'WEB' then
    begin
      SQL.Add(' SELECT  nombre_ds nombre_c, cta_cliente_c, nif_ds nif_c, tipo_via_ds tipo_via_fac_c,                                ');
      SQL.Add('         domicilio_ds domicilio_fac_c, poblacion_ds poblacion_fac_c,                                                 ');
      SQL.Add('         cod_postal_ds cod_postal_fac_c, nombre_p, pais_ds pais_c, descripcion_p, forma_pago_c,                      ');
      SQL.Add('         NVL(dias_cobro_fp, 0) dias_cobro_fp, NVL(dias_tesoreria_c, dias_cobro_fp) dias_tesoreria_c,                 ');
      SQL.Add('         banco_ct, forma_pago_ct, NVL(dias_tesoreria_ct, dias_cobro_fp) dias_tesoreria_ct                            ');
      SQL.Add('   FROM frf_clientes, frf_dir_sum, outer(frf_clientes_tes, frf_forma_pago), outer(frf_provincias), outer(frf_paises) ');
      SQL.Add('  WHERE cliente_ds = :cliente ');
      SQL.Add('    AND dir_sum_ds = :dirsum  ');

      SQL.Add('    AND cliente_c = cliente_ds ');

      SQL.Add('   AND cliente_ct = cliente_c ');
      SQL.Add('   AND empresa_ct = :empresa ');

      SQL.Add('    AND codigo_fp = forma_pago_ct ');

      SQL.Add('    AND codigo_p = cod_postal_ds[1,2] ');

      SQL.Add('    AND pais_p = pais_ds ');

      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('cliente').AsString := ACliente;
      ParamByName('dirsum').AsString := ADirSum;

    end
    else
    begin
      SQL.Add(' SELECT  nombre_c, cta_cliente_c, nif_c, tipo_via_fac_c, domicilio_fac_c, poblacion_fac_c,  ');
      SQL.Add('         cod_postal_fac_c, nombre_p, pais_c,                                                ');
      SQL.Add('         CASE when tipo_albaran_c > 1 THEN (case when original_name_p <> '''' then original_name_p else descripcion_p end ) ELSE descripcion_p END descripcion_p, ');
      SQL.Add('         forma_pago_c, ');
      SQL.Add('         NVL(dias_cobro_fp, 0) dias_cobro_fp, NVL(dias_tesoreria_c, dias_cobro_fp) dias_tesoreria_c, ');
      SQL.Add('         banco_ct, forma_pago_ct, NVL(dias_tesoreria_ct, dias_cobro_fp) dias_tesoreria_ct ');
      SQL.Add('   FROM frf_clientes, outer(frf_forma_pago, frf_clientes_tes), outer(frf_provincias), outer(frf_paises) ');
      SQL.Add('  WHERE cliente_c = :cliente ');

      SQL.Add('   AND cliente_ct = cliente_c ');
      SQL.Add('   AND empresa_ct = :empresa ');

      SQL.Add('    AND codigo_fp = forma_pago_ct ');

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
    Result.sFormaPago  := FieldByName('forma_pago_ct').AsString;
//    Result.sFormaPago  := FieldByName('forma_pago_c').AsString;
    Result.iDiasCobro       := FieldByName('dias_cobro_fp').AsInteger;
//    Result.iDiasTesoreria  := FieldByName('dias_tesoreria_c').AsInteger;
    Result.iDiasTesoreria  := FieldByName('dias_tesoreria_ct').AsInteger;

  end;

end;

function GetImpuestoMoneda( const AEmpresa, ACliente: string; var AImpuesto, AMoneda: string ): boolean;
var
  sOrigen: string;
begin
  with DFactura.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select case when substr(cod_postal_c,1,2) = ''38'' then ''TEN'' else ''PEN'' end origen ');
    SQL.Add(' from frf_centros ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add(' group by 1 ');
    ParamByName('empresa').AsString:= AEmpresa;
    Open;
    sOrigen:= FieldByName('origen').AsString;
    Next;
    if  sOrigen <> FieldByName('origen').AsString then
    begin
      sOrigen:= '';
    end;
    Close;

    SQL.Clear;
    SQL.Add(' select moneda_c, es_comunitario_c, pais_c, cod_postal_c[1,2] provincia_c from frf_clientes ');
    SQL.Add(' where cliente_c = :cliente ');

    ParamByName('cliente').AsString:= ACliente;
    Open;
    result:= not IsEmpty;
    if result then
    begin
      AMoneda:= FieldByName('moneda_c').AsString;
      if FieldByName('pais_c').AsString = 'ES' then
      begin
        if sOrigen = 'PEN' then
        begin
          if ( FieldByName('provincia_c').AsString = '38' ) or ( FieldByName('provincia_c').AsString = '35' ) then
          begin
            AImpuesto:= 'IE';
          end
          else
          begin
            AImpuesto:= 'IR';
          end;
        end
        else
        if sOrigen = 'TEN' then
        begin
          if ( FieldByName('provincia_c').AsString = '38' ) or ( FieldByName('provincia_c').AsString = '35' ) then
          begin
            AImpuesto:= 'GR';
          end
          else
          begin
            AImpuesto:= 'GE';
          end;
        end
        else
        begin
          if ( FieldByName('provincia_c').AsString = '38' ) or ( FieldByName('provincia_c').AsString = '35' ) then
          begin
            AImpuesto:= 'GR';
          end
          else
          begin
            AImpuesto:= 'IR';
          end;
        end;
      end
      else
      if FieldByName('es_comunitario_c').AsString = 'N' then
      begin
        if sOrigen = 'TEN' then
        begin
          AImpuesto:= 'GE';
        end
        else
        begin
          AImpuesto:= 'IE';
        end;
      end
      else
      begin
        if sOrigen = 'TEN' then
        begin
          AImpuesto:= 'GE';
        end
        else
        begin
          AImpuesto:= 'IC';
        end;
      end
    end;
    Close;
  end;

end;

procedure TDFactura.PutFechaVencimiento( const AEmpresa, ACliente: string; const AFechaFactura: TDateTime; var AFechaCobro, AFechaTesoreria: TDateTime );
var QFechaVen: TBonnyQuery;
begin

  QFechaVen := TBonnyQuery.Create(Self);
  with QFechaVen do
  try
    SQL.Add(' select nvl(dias_cobro_fp,0) dias, NVL(dias_tesoreria_c, dias_cobro_fp) dias_tesoreria_c,  ');
    SQL.Add('                                   NVL(dias_tesoreria_ct, dias_cobro_fp) dias_tesoreria_ct  ');
    SQL.Add(' from frf_clientes, frf_clientes_tes, frf_forma_pago ');
    SQL.Add(' where cliente_c = :cliente ');
    SQL.Add('   and cliente_ct = cliente_c ');
    SQL.Add('   and empresa_ct = :empresa ');
    SQL.Add(' and codigo_fp = forma_pago_ct ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;

    AFechaCobro := AFechaFactura + FieldByName('dias').AsInteger;
//    AFechaTesoreria := AFechaFactura + FieldByName('dias_tesoreria_c').AsInteger;
    AFechaTesoreria := AFechaFactura + FieldByName('dias_tesoreria_ct').AsInteger;

    Close;
  finally
    Free;
  end;

end;

function GetNumeroFactura(empresa, tipofac, tipo, serie: string; fecha: TDate; var AMsg: string): integer;
var
  iYear, iMont, iDay: Word;
  dFEcha: TDate;
  iFacturaAux: integer;
  sSerie: string;
  QAux : TBonnyQuery;
begin
  DecodeDate( fecha, iYear, iMont, iDay );
  QAux := TBonnyQuery.Create(nil);
  with QAux do
  try
    if tipofac = '380' then
    begin
      if tipo = 'I' then
      begin
        SQL.Add(' SELECT cod_serie_fs serie, fac_iva_fs factura, fecha_fac_iva_fs fecha_factura ');
      end
      else
      begin
        SQL.Add(' SELECT cod_serie_fs serie, fac_igic_fs factura, fecha_fac_igic_fs fecha_factura ');
      end;
    end
    else
    begin
      if tipo = 'I' then
      begin
        SQL.Add(' SELECT cod_serie_fs serie, abn_iva_fs factura, fecha_abn_iva_fs fecha_factura ');
      end
      else
      begin
        SQL.Add(' SELECT cod_serie_fs serie, abn_igic_fs factura, fecha_abn_igic_fs fecha_factura ');
      end;
    end;

    SQL.Add(' from frf_facturas_serie ');
    SQL.Add('      join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ');
    SQL.Add(' where cod_empresa_es = :empresa ');
    SQL.Add(' and anyo_fs = :anyo ');
    SQL.Add(' and cod_serie_fs = :serie ');

    ParamByName('empresa').AsString:= empresa;
    ParamByName('anyo').AsInteger:= iYear;
    ParamByName('serie').AsString:= serie;
    Open;

    if IsEmpty then
    begin
      //Crear un nuevo registro
      result:= -1;
      AMsg:= ' Falta inicializar los contadores de facturas para el a�o "'+ IntToStr( iYear ) +'". ';
    end
    else
    begin
      sSerie:= FieldByName('serie').AsString;
      Result:= FieldByName('factura').AsInteger + 1;
      dFecha:= FieldByName('fecha_factura').AsDateTime;
      Close;
      iFacturaAux:= result;
      result := ComprobarClavePrimaria(empresa,serie, result, iYear);
      if result = -1 then
      begin
        AMsg:= ' N�mero factura '+ IntToStr( iFacturaAux ) +' duplicada en el a�o "' + IntToStr( iYear ) + '". ';
      end
      else
      begin
        SQL.Clear;
        SQL.Add(' UPDATE frf_facturas_serie ');
        if tipofac = '380' then
        begin
          if tipo = 'I' then
          begin
            SQL.Add(' SET fac_iva_fs= ' + IntToStr( result) );
          end
          else
          begin
            SQL.Add(' SET fac_igic_fs= ' + IntToStr( result) );
          end;
          if dFecha < fecha then
          begin
            if tipo = 'I' then
            begin
              SQL.Add('     ,fecha_fac_iva_fs= ' + QuotedStr( FormatDateTime( 'dd/mm/yyyy', fecha ) ) );
            end
            else
            begin
              SQL.Add('     ,fecha_fac_igic_fs= ' + QuotedStr( FormatDateTime( 'dd/mm/yyyy', fecha ) ) );
            end;
          end;
        end
        else
        begin
          if tipo = 'I' then
          begin
            SQL.Add(' SET abn_iva_fs= ' + IntToStr( result) );
          end
          else
          begin
            SQL.Add(' SET abn_igic_fs= ' + IntToStr( result) );
          end;
          if dFecha < fecha then
          begin
            if tipo = 'I' then
            begin
              SQL.Add('     ,fecha_abn_iva_fs= ' + QuotedStr( FormatDateTime( 'dd/mm/yyyy', fecha ) ) );
            end
            else
            begin
              SQL.Add('     ,fecha_abn_igic_fs= ' + QuotedStr( FormatDateTime( 'dd/mm/yyyy', fecha ) ) );
            end;
          end;
        end;
        SQL.Add(' WHERE cod_serie_fs = :serie ');
        SQL.Add(' and anyo_fs = :anyo ');

        ParamByName('serie').AsString:= sSerie;
        ParamByName('anyo').AsInteger:= iYear;
        ExecSQL;
      end;
    end;
  finally
    Free;
  end;
end;

function ImpuestosClientes(const AEmpresa, ACliente, AImpuesto: string; const AFecha: TDate ): TImpuestos;
var
  rRecargoGeneral, rRecargoReducido, rRecargoSuper: Real;
begin
  if not ExentoImpuestos(AEmpresa, ACliente) then
  begin
    with DMAuxDB.qpr_datos_impuestos do
    begin
      ParamByName('codigo').AsString := AImpuesto;
      ParamByName('fecha').AsDate := AFecha;
      Open;
      result.sCodigo := AImpuesto;
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

function InsertaFacturaCabecera(ClaveFactura:string; FacturaNumero:integer): boolean;
begin
  result := True;
          // Insertamos en tfacturas_cab BD
  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO tfacturas_cab ');
    SQL.Add('( cod_factura_fc, cod_empresa_fac_fc, cod_serie_fac_fc, n_factura_fc, fecha_factura_fc, ');
    SQL.Add('  impuesto_fc, tipo_factura_fc, automatica_fc, anulacion_fc, cod_factura_anula_fc, ');
    SQL.Add('  cod_cliente_fc, des_cliente_fc, cta_cliente_fc, nif_fc, ');
    SQL.Add('  tipo_via_fc, domicilio_fc, poblacion_fc, cod_postal_fc, provincia_fc, ');
    SQL.Add('  cod_pais_fc, des_pais_fc, notas_fc, incoterm_fc, ');
    SQL.Add('  plaza_incoterm_fc, forma_pago_fc, des_forma_pago_fc, tipo_impuesto_fc, ');
    SQL.Add('  des_tipo_impuesto_fc, moneda_fc, importe_linea_fc, ');
    SQL.Add('  importe_descuento_fc, importe_neto_fc, importe_impuesto_fc, ');
    SQL.Add('  importe_total_fc, importe_neto_euros_fc, importe_impuesto_euros_fc, importe_total_euros_fc, ');
    SQL.Add('  fecha_fac_ini_fc, prevision_cobro_fc, prevision_tesoreria_fc, contabilizado_fc, fecha_conta_fc, filename_conta_fc ) ');

    SQL.add('VALUES (');

//    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString) + ', ');
    SQL.Add(QuotedStr(ClaveFactura) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_serie_fac_fc').AsString) + ', ');
//    SQL.Add(DFactura.mtFacturas_Cab.FieldByName('n_factura_fc').AsString + ', ');
    SQL.Add(SQLNumeric(FacturaNumero) + ', ');
    SQL.Add(SQLDate(DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('impuesto_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('tipo_factura_fc').AsString) + ', ');
    SQL.Add(DFactura.mtFacturas_Cab.FieldByName('automatica_fc').AsString + ', ');
    SQL.Add(DFactura.mtFacturas_Cab.FieldByName('anulacion_fc').AsString + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_factura_anula_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_cliente_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('des_cliente_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cta_cliente_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('nif_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('tipo_via_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('domicilio_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('poblacion_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_postal_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('provincia_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_pais_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('des_pais_fc').AsString) + ', ');
//      SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString) + ', ');
    SQL.Add(':nota' + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('incoterm_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('plaza_incoterm_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('forma_pago_fc').AsString) + ', ');
//      SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('des_forma_pago_fc').AsString) + ', ');
    SQL.Add(':des_forma_pago' + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('tipo_impuesto_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('des_tipo_impuesto_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('moneda_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_linea_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_descuento_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_neto_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_total_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_neto_euros_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_impuesto_euros_fc').AsString) + ', ');
    SQL.add(SQLNumeric(DFactura.mtFacturas_Cab.FieldByName('importe_total_euros_fc').AsString) + ', ');
    SQL.Add(SQLDate(DFactura.mtFacturas_Cab.FieldByName('fecha_fac_ini_fc').AsString) + ', ');
    SQL.Add(SQLDate(DFactura.mtFacturas_Cab.FieldByName('prevision_cobro_fc').AsString) + ', ');
    SQL.Add(SQLDate(DFactura.mtFacturas_Cab.FieldByName('prevision_tesoreria_fc').AsString) + ', ');
    SQL.Add(DFactura.mtFacturas_Cab.FieldByName('contabilizado_fc').AsString + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('fecha_conta_fc').AsString) + ', ');
    SQL.Add(QuotedStr(DFactura.mtFacturas_Cab.FieldByName('filename_conta_fc').AsString) + ')');
    ParamByName('nota').DataType := ftString;
    if DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString <> '' then
      ParamByName('nota').AsString := DFactura.mtFacturas_Cab.FieldByName('notas_fc').AsString
    else
      ParamByName('nota').Clear;
    ParamByName('des_forma_pago').AsString := DFactura.mtFacturas_Cab.FieldByName('des_forma_pago_fc').AsString;

    try
      //Rellena tabla cabecera de facturacion
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      result := False;
    end;
  end;
end;

function InsertaFacturaDetalle(ClaveFactura: string; FacturaNumero: integer; bFactura: boolean): Boolean;
var sEmpresa, sCentro, sAlbaran, sFecha: string;
begin
  Result := True;
            //Lineas detalle Factura
  with DFactura.mtFacturas_Det do
  begin
    Filter := ' cod_factura_fd = ' + QuotedStr(ClaveFactura);
    Filtered := True;

    sEmpresa := '';
    sCentro := '';
    sAlbaran := '';
    sFecha := '';

    First;
    while not Eof do
    begin
              // Insertamos linea de detalle Factura
      with DMBaseDatos.QGeneral do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO tfacturas_det ');
        SQL.Add('( cod_factura_fd, num_linea_fd, cod_empresa_albaran_fd, cod_centro_albaran_fd, n_albaran_fd, ');
        SQL.Add('  fecha_albaran_fd, cod_cliente_albaran_fd, cod_dir_sum_fd, pedido_fd, fecha_pedido_fd, matricula_fd, ');
        SQL.Add('  emp_procedencia_fd, centro_origen_fd, ');
        SQL.Add('  cod_producto_fd, des_producto_fd, cod_envase_fd, des_envase_fd, categoria_fd, ');
        SQL.Add('  calibre_fd, marca_fd, nom_marca_fd, cajas_fd, unidades_caja_fd, unidades_fd, ');
        SQL.Add('  kilos_fd, kilos_posei_fd, unidad_facturacion_fd, precio_fd, importe_linea_fd, cod_representante_fd, ');
        SQL.Add('  porcentaje_comision_fd, porcentaje_descuento_fd, euroskg_fd, ');
        SQL.Add('  importe_comision_fd, importe_descuento_fd, importe_euroskg_fd, ');
        SQL.Add('  importe_total_descuento_fd, importe_neto_fd, ');
        SQL.Add('  tasa_impuesto_fd, porcentaje_impuesto_fd, importe_impuesto_fd, importe_total_fd, cod_comercial_fd ) ');

        SQL.add(' VALUES ( ');

        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_factura_fd').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('num_linea_fd').AsString + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsString + ', ');
        SQL.Add(SQLDate(DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_cliente_albaran_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_dir_sum_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('pedido_fd').AsString) + ', ');
        SQL.Add(SQLDate(DFactura.mtFacturas_Det.FieldByName('fecha_pedido_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('matricula_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('emp_procedencia_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('centro_origen_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_producto_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('des_producto_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_envase_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('des_envase_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('categoria_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('calibre_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('marca_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('nom_marca_fd').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('cajas_fd').AsString + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('unidades_caja_fd').AsString + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('unidades_fd').AsString + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('kilos_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('kilos_posei_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('unidad_facturacion_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('precio_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_linea_fd').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_representante_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('porcentaje_comision_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('porcentaje_descuento_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('euroskg_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_comision_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_descuento_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_euroskg_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_total_descuento_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_neto_fd').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Det.FieldByName('tasa_impuesto_fd').AsString + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('porcentaje_impuesto_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_impuesto_fd').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Det.FieldByName('importe_total_fd').AsString) + ',');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Det.FieldByName('cod_comercial_fd').AsString) + ') ');

        try
          //Rellena tabla detalle de facturacion
          EjecutarConsulta(DMBaseDatos.QGeneral);
        except
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
          Result := false;
          Exit;
        end;
      end;

      if bFactura then
      begin
        if (sEmpresa = '') or (sEmpresa <> DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString) or
         (sCentro <> DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString) or
         (sAlbaran <> DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsString) or
         (sFecha <> DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsString) then
        begin
                        // Actualizamos Cabecera albaran
          with DMBaseDatos.QGeneral do
          begin
            Cancel;
            Close;
            SQL.Clear;
            SQL.Add('UPDATE frf_salidas_c ');
            SQL.Add('SET ');
            SQL.Add('   empresa_fac_sc = ' + quotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').AsString) + ' ,');
            SQL.Add('   serie_fac_sc = ' + quotedStr(DFactura.mtFacturas_Cab.FieldByName('cod_serie_fac_fc').AsString) + ' ,');
            SQL.Add('   fecha_factura_sc= ' + SQLDate(DFactura.mtFacturas_Cab.FieldByName('fecha_factura_fc').AsString) + ' ,');
            SQL.Add('   n_factura_sc= ' + IntToStr(FacturaNumero) + ' ');
            SQL.Add('Where empresa_sc= ' + quotedStr(DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString) + ' ');
            SQL.Add('AND centro_salida_sc= ' + quotedstr(DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString) + ' ');
            SQL.Add('AND n_albaran_sc= ' + DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsString + ' ');
            SQL.Add('AND fecha_sc= ' + SQLDate(DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsString) + ' ');

            try
              //Rellena tabla detalle de facturacion
              EjecutarConsulta(DMBaseDatos.QGeneral);
            except
              CancelarTransaccion(DMBaseDatos.DBBaseDatos);
              result := false;
            end;
          end;
          sEmpresa := DFactura.mtFacturas_Det.FieldByName('cod_empresa_albaran_fd').AsString;
          sCentro := DFactura.mtFacturas_Det.FieldByName('cod_centro_albaran_fd').AsString;
          sAlbaran := DFactura.mtFacturas_Det.FieldByName('n_albaran_fd').AsString;
          sFecha := DFactura.mtFacturas_Det.FieldByName('fecha_albaran_fd').AsString;
        end;
      end;
      Next;
    end;
    Filter := '';
    Filtered := False;
  end;

end;

function InsertaFacturaGastos(ClaveFactura: string): boolean;
begin
  result := True;
          //Gastos Factura
  with DFactura.mtFacturas_Gas do
  begin
    Filter := ' cod_factura_fg = ' + QuotedStr(ClaveFactura);
    Filtered := True;

    First;
    while not Eof do
    begin
      with DMBaseDatos.QGeneral do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO tfacturas_gas ');
        SQL.Add('( cod_factura_fg, cod_empresa_albaran_fg, cod_centro_albaran_fg, n_albaran_fg, ');
        SQL.Add('  fecha_albaran_fg, cod_tipo_gasto_fg, des_tipo_gasto_fg, importe_neto_fg, ');
        SQL.Add('  tasa_impuesto_fg, porcentaje_impuesto_fg, importe_impuesto_fg, importe_total_fg ) ');

        SQL.Add(' VALUES (' );

        SQL.Add(QuotedStr(DFactura.mtFacturas_Gas.FieldByName('cod_factura_fg').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Gas.FieldByName('cod_empresa_albaran_fg').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Gas.FieldByName('cod_centro_albaran_fg').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Gas.FieldByName('n_albaran_fg').AsString + ', ');
        SQL.Add(SQLDate(DFactura.mtFacturas_Gas.FieldByName('fecha_albaran_fg').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Gas.FieldByName('cod_tipo_gasto_fg').AsString) + ', ');
        SQL.Add(QuotedStr(DFactura.mtFacturas_Gas.FieldByName('des_tipo_gasto_fg').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Gas.FieldByName('importe_neto_fg').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Gas.FieldByName('tasa_impuesto_fg').AsString + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Gas.FieldByName('porcentaje_impuesto_fg').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Gas.FieldByName('importe_impuesto_fg').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Gas.FieldByName('importe_total_fg').AsString) + ')');

        try
          //Rellena tabla detalle de facturacion
          EjecutarConsulta(DMBaseDatos.QGeneral);
        except
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
          result := False;
        end;

      end;

      Next;
    end;
    Filter := '';
    Filtered := False;
  end;
end;

function InsertaFacturaBase(ClaveFactura: string): boolean;
begin
  result := True;
          //Base Factura
  with DFactura.mtFacturas_Bas do
  begin
    Filter := ' cod_factura_fb = ' + QuotedStr(ClaveFactura);
    Filtered := True;

    First;
    while not Eof do
    begin
      with DMBaseDatos.QGeneral do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO tfacturas_bas ');
        SQL.Add('( cod_factura_fb, tasa_impuesto_fb, porcentaje_impuesto_fb, cajas_fb,   ');
        SQL.Add('  unidades_fb, kilos_fb, importe_neto_fb, importe_impuesto_fb, importe_total_fb ) ');

        SQL.Add(' VALUES (' );

        SQL.Add(QuotedStr(DFactura.mtFacturas_Bas.FieldByName('cod_factura_fb').AsString) + ', ');
        SQL.Add(DFactura.mtFacturas_Bas.FieldByName('tasa_impuesto_fb').AsString + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('porcentaje_impuesto_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('cajas_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('unidades_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('kilos_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('importe_neto_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('importe_impuesto_fb').AsString) + ', ');
        SQL.Add(SQLNumeric(DFactura.mtFacturas_Bas.FieldByName('importe_total_fb').AsString) + ') ');

        try
          //Rellena tabla detalle de facturacion
          EjecutarConsulta(DMBaseDatos.QGeneral);
        except
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
          result := False;
        end;

      end;

      Next;
    end;
    Filter := '';
    Filtered := False;
  end;
end;

function BorraFacturaCabecera(ClaveFactura: string): Boolean;
begin
  result := True;

  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add(' DELETE FROM tfacturas_cab ');
    SQL.Add('  WHERE cod_factura_fc = ' + QuotedStr(ClaveFactura) );

    try
        //borra tabla detalle de facturacion
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      result := False;
    end;
  end;
end;

function BorraFacturaDetalle(ClaveFactura: string): Boolean;
begin
  result := True;

  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add(' DELETE FROM tfacturas_det ');
    SQL.Add('  WHERE cod_factura_fd = ' + QuotedStr(ClaveFactura) );

    try
        //Borra tabla detalle de facturacion
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      result := False;
    end;
  end;
end;

function BorraFacturaGastos(ClaveFactura: string): Boolean;
begin
  result := True;

  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add(' DELETE FROM tfacturas_gas ');
    SQL.Add('  WHERE cod_factura_fg = ' + QuotedStr(ClaveFactura) );

    try
        //Borra tabla detalle de facturacion
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      result := False;
    end;
  end;
end;

function BorraFacturaBase(ClaveFactura: string): Boolean;
begin
  result := True;

  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add(' DELETE FROM tfacturas_bas ');
    SQL.Add('  WHERE cod_factura_fb = ' + QuotedStr(ClaveFactura) );

    try
        //Borra tabla detalle de facturacion
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      result := False;
    end;
  end;
end;

procedure RellenaMemBaseFacturas(ARepFactura: Boolean; ARImpBases: TRImpBases);
var i, iBases: Integer;
begin
  iBases := Length(ARImpBases.aRImportes);
  DFactura.mtFacturas_Bas.Open ;

  i := 0;
  while i < iBases do
  begin
    DFactura.mtFacturas_Bas.Append;

    if ARepFactura then
      DFactura.mtFacturas_Bas.FieldByName('cod_factura_fb').AsString := ARImpBases.aRImportes[i].sCodFactura;

    DFactura.mtFacturas_Bas.FieldByName('cod_empresa_fac_fb').AsString := ARImpBases.aRImportes[i].sEmpresa;
    DFactura.mtFacturas_Bas.FieldByName('fecha_fac_fb').AsString := ARImpBases.aRImportes[i].sFecha;
    DFactura.mtFacturas_Bas.FieldByName('fac_interno_fb').AsString := ARImpBases.aRImportes[i].sNumero;

    DFactura.mtFacturas_Bas.FieldByName('tasa_impuesto_fb').AsInteger := ARImpBases.aRImportes[i].iTasaImpuesto;
    DFactura.mtFacturas_Bas.FieldByName('porcentaje_impuesto_fb').AsFloat := ARImpBases.aRImportes[i].rPorcentajeImpuesto;
    DFactura.mtFacturas_Bas.FieldByName('cajas_fb').AsInteger := ARImpBases.aRImportes[i].iCajas;
    DFactura.mtFacturas_Bas.FieldByName('unidades_fb').AsInteger := ARImpBases.aRImportes[i].iUnidades;
    DFactura.mtFacturas_Bas.FieldByName('kilos_fb').AsFloat := ARImpBases.aRImportes[i].rKilos;
    DFactura.mtFacturas_Bas.FieldByName('importe_neto_fb').AsFloat := ARImpBases.aRImportes[i].rImporteNeto;
    DFactura.mtFacturas_Bas.FieldByName('importe_impuesto_fb').AsFloat := ARImpBases.aRImportes[i].rImporteImpuesto;
    DFactura.mtFacturas_Bas.FieldByName('importe_total_fb').AsFloat := ARImpBases.aRImportes[i].rImporteTotal;

    try
      DFactura.mtFacturas_Bas.Post;
    except
      DFactura.mtFacturas_Bas.Cancel;
      raise;
    end;

    Inc(i)
  end;
end;

function CrearPDF( AReport: TQuickRep): boolean;
var
  old_impresora: integer;
  sAux: string;
begin
  Result := True;
  //Escoger impresora de PDF y crear el fichero
  if giPrintPDF > -1 then
  begin
      old_impresora := AReport.PrinterSettings.PrinterIndex;
      AReport.PrinterSettings.PrinterIndex := giPrintPDF;

      AReport.ShowProgress := False;
      Screen.Cursor := crHourGlass;
      try
        //AReport.ReportTitle:= StringReplace(Trim(AReport.ReportTitle), ' ', '_', [rfReplaceAll]);
        AReport.ReportTitle:= Trim(AReport.ReportTitle);
        AReport.print;
      except
        Result := False;
      end;
      AReport.PrinterSettings.PrinterIndex := old_impresora;
      Screen.Cursor := crDefault;
      Application.ProcessMessages;
  end
  else
  begin
    if AReport.ReportTitle = '' then
      AReport.ReportTitle:= 'Listado_Comercial';
    sAux := gsDirActual + '\..\temp\' + AReport.ReportTitle;
    if FileExists(sAux + '.pdf') then
      DeleteFile(sAux + '.pdf');

    //DMFacturacion.ExportQR.Report:= AReport;
    //DMFacturacion.ExportQR.ExportQRPDF(sAux, true );
    AReport.ExportToFilter(  TQRPDFDocumentFilter.Create( sAux + '.pdf' ) );
  end;
end;
{
function EnviarPDFFactura(const AEmpresa, ACliente, AFileName: string; var AEmail: string; AMensaje: TStrings;
  const AEsEspanyol: boolean): boolean;

begin
  //Creo el formulario
  with TFDConfigMail.Create(Application) do
  begin
    //Crear PDF, miro el titulo del PDF porque si acaba en punto, hay problemas para adjuntarlo
    Adjuntos.Clear;
    Adjuntos.Add(AFileName);

    MMensaje.Lines.Clear;
    MMensaje.Lines.Add( AsuntoFactura( AEmpresa, ACliente ) );

    //Rellenamos los campos de la pantalla de envio de correo
    EDireccion.Text := AEmail;
    edtCopia.Text:= gsDirCorreo;

    if sAsunto <> '' then
      EAsunto.Text := sAsunto
    else
     EAsunto.Text := 'Envio de facturas ';
    sAsunto:= '';

    esFactura := True;

    //mostrar la pantalla de envio de correo
    ShowModal;
    AMensaje.AddStrings(MMensaje.Lines);
    AEmail := EDireccion.Text;
    Result := bEnviado;
  end;
end;
}
function EMailFactura( const AEmpresa, ACliente, ASuministro: string): string;
begin
  Result:= '';

  if ASuministro <> '' then
  begin
    with DMBaseDatos.QGeneral do
    begin
      Close;
      SQl.Clear;
      SQl.Add('select email_fac_ds ');
      SQl.Add('from frf_dir_sum ');
      SQl.Add('where cliente_ds = :cliente ');
      SQl.Add('and dir_sum_ds = :dirsum ');
      ParamByName('cliente').AsString:= ACliente;
      ParamByName('dirsum').AsString:= ASuministro;
      Open;
      result := Trim( FieldByName('email_fac_ds').AsString );
      Close;
    end;
  end;

  if Result = '' then
  begin
    with DMBaseDatos.QGeneral do
    begin
      Close;
      SQl.Clear;
      SQl.Add('SELECT EMAIL_FAC_C FROM frf_clientes ' +
        'WHERE cliente_c = :cliente ');
      ParamByName('cliente').AsString:= ACliente;
      Open;
      result := Trim( FieldByName('EMAIL_FAC_C').AsString );
      Close;
    end;
  end;
end;

function EsEspanyol(const AEmpresa, ACliente: string): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select pais_c from frf_clientes ');
    SQL.Add('where cliente_c ' + SQLEqualS(ACliente));
    if OpenQuery(DMAuxDB.QAux) then
    begin
      result := Fields[0].AsString = 'ES';
      Close;
    end
    else
    begin
      result := false;
    end;
  end;
end;


function EnviarYGuardarFacturas(AReport: TQuickRep): boolean;
var
  AFecha, ADesde, AHasta, direccion: string;
  AFileName, sTexto: string;
  slMensaje: TStringList;
  i: smallint;
begin
  if (uppercase(AReport.Name) = 'RFACTURA2') then
  begin
    if not DFactura.mtFacturas_Cab.Active then
      DFactura.mtFacturas_Cab.Open;
    if not DFactura.mtFacturas_Det.Active then
      DFactura.mtFacturas_Det.Open;
    if not DFactura.mtFacturas_Gas.Active then
      DFactura.mtFacturas_Gas.Open;
    if not DFactura.mtFacturas_Bas.Active then
      DFactura.mtFacturas_Bas.Open;

    DFactura.mtFacturas_Cab.LoadFromDataSet(DFactura.mtFacturas_Cab2, []);
    DFactura.mtFacturas_Det.LoadFromDataSet(DFactura.mtFacturas_Det2, []);
    DFactura.mtFacturas_Bas.LoadFromDataSet(DFactura.mtFacturas_Bas2, []);
    DFactura.mtFacturas_Gas.LoadFromDataSet(DFactura.mtFacturas_Gas2, []);
  end;
  if (( uppercase(AReport.Name) = 'RFACTURA' ) or ( uppercase(AReport.Name) = 'RFACTURA2' ))
     and ( DFactura <> nil ) then
  begin
    if  DFactura.mtFacturas_Det.Active then
    begin
      DConfigMailFactura.sSuministroConfig:= DFactura.mtFacturas_Det.FieldByName('cod_dir_sum_fd').asString;
    end
    else
    begin
      DConfigMailFactura.sSuministroConfig:= '';
    end;
  end;

  result:= false;
  slMensaje := TStringList.Create;
  DConfigMailFactura.sCampoConfig:= 'email_fac_c';
  direccion:= EMailFactura( DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').asString, DFactura.mtFacturas_Cab.FieldByName('cod_cliente_fc').asString, DConfigMailFactura.sSuministroConfig );
  sAsunto := 'Env�o de ' + IntToStr(DFactura.mtFacturas_Cab.RecordCount) + ' Factura/s para el cliente ' + DFactura.mtFacturas_Cab.FieldByName('cod_cliente_fc').asString;
  //if PuedoEnviarFactura(AEmpresa, ACliente, AFecha, ADesde, AHasta, direccion) then
  begin
    sTexto := '' + #13 + #10 + '�Desea enviar ' + IntToStr(DFactura.mtFacturas_Cab.RecordCount) + ' factura/s por correo electronico?    ' + #13 + #10 + '  ';
//    if Application.MessageBox('' + #13 + #10 + '�Desea enviar ' + DFactura.mtFacturas_Cab.RecordCount + ' factura/s por correo electronico?    ' + #13 + #10 + '  ',
//      '   ENVIO ELECTRONICO', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
    if Application.MessageBox(PChar(sTexto), '   ENVIO ELECTRONICO', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
    begin

      with TFDConfigMailFactura.Create(Application) do
      begin
        rReport := AReport;
        sEmpresa := DFactura.mtFacturas_Cab.FieldByName('cod_empresa_fac_fc').asString;
        sCliente := DFactura.mtFacturas_Cab.FieldByName('cod_cliente_fc').asString;
        //Rellenamos los campos de la pantalla de envio de correo
        EDireccion.Text := direccion;
        edtCopia.Text:= gsDirCorreo;

        MMensaje.Lines.Clear;
        DFactura.mtFacturas_Cab.First;
        while not DFactura.mtFacturas_Cab.eof do
        begin
          MMensaje.Lines.Add( 'Factura ' + DFactura.mtFacturas_Cab.FieldByName('cod_factura_fc').AsString);
          DFactura.mtFacturas_Cab.Next;
        end;

        if sAsunto <> '' then
          EAsunto.Text := sAsunto
        else
         EAsunto.Text := 'Envio de facturas ';
        sAsunto:= '';

        esFactura := True;

        //mostrar la pantalla de envio de correo
        ShowModal;

//        AMensaje.AddStrings(MMensaje.Lines);
//        AEmail := EDireccion.Text;
        Result := bEnviado;

      end;

    end;
  end;
  freeandnil(slMensaje);
  DConfigMailFactura.sSuministroConfig:= '';

  if (uppercase(AReport.Name) = 'RFACTURA2') then
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

end;
end.






