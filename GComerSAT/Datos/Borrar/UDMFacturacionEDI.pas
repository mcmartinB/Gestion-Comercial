unit UDMFacturacionEDI;

interface

uses
  SysUtils, Classes, DB, DBTables, Controls;

type
  TRImportesParciales = record
    rNeto, rDescuento, rComision, rGasto, rBase, rTipoIva, rIva: Real;
  end;

  TRImportesBases = record
    rNeto, rDescuento, rComision, rGasto, rBase, rTipoIva, rIva: Real;
  end;

  TRImportesCabeceraEDI = record
    rTipoComision, rTipoDescuento: Real;
    aRImportesLineas: array of TRImportesParciales;
    aRImportesBases: array of TRImportesBases;
    rTotalNeto, rComision, rDescuento, rTotalGasto: real;
    rTotalBase, rTotalIva, rTotalImporte: Real;
    rFactor, rTotalEuros: Real;
  end;

  TDMFacturacionEDI = class(TDataModule)
    DSCabeceraEdi: TDataSource;
    QCabeceraEdi: TQuery;
    QLineasEdi: TQuery;
    QFacClientesEDI: TQuery;
    DSFacClientesEdi: TDataSource;
    QGastosEDI: TQuery;
    QAux: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure QFacClientesEDIAfterOpen(DataSet: TDataSet);
    procedure QFacClientesEDIBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure FacturacionEDI;
procedure FacturaEDI(const AEmpresa: string; const AFactura: Integer; const AFecha: TDateTime );

//function GetCodEdiEx( const AVendedor, AComprador, AEnvase: String; var ADescripcion: string ): string;
function GetCodEdi(const AEmpresa, ACliente, AEnvase: String; var VDescripcion, VDun14: string): string;

//function FechaVencimiento( const AFecha: TDate ): TDate;
function GetFechaVencimiento( const AEmpresa, ACliente: string; const AFechaFactura: TDateTime ): TDateTime;

implementation

{$R *.dfm}

uses CAuxiliarDB, UDMBaseDatos, DError, UDMConfig, bCodeUtils,
     UDMAuxDB, bMath, CVariables, UDMCambioMoneda;

var
  DMFacturacionEDI: TDMFacturacionEDI;
  RImportesCabeceraEDI: TRImportesCabeceraEDI;

(*
function FechaVencimiento( const AFecha: TDate ): TDate;
var
  anyo, mes, dia: Word;
begin
  DecodeDate( AFecha, anyo, mes, dia );
  if ( dia >= 1 ) or ( dia < 15 ) then
  begin
    result:= IncMonth( EncodeDate( anyo, mes, 1 ), 3 );
  end
  else
  begin
    result:= IncMonth( EncodeDate( anyo, mes, 15 ), 3 );
  end;
end;
*)

function GetFechaVencimiento( const AEmpresa, ACliente: string; const AFechaFactura: TDateTime ): TDateTime;
begin
  with DMBaseDatos.QAux do
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
    Result := AFechaFactura + FieldByName('dias').AsInteger;
    Close;
  end;
end;

function DatosTotalesFactura: TRImportesCabeceraEDI;
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

  Result.rTipoComision:= DMFacturacionEDI.QCabeceraEdi.FieldByName('comision_tfc').AsFloat;
  Result.rTipoDescuento:= DMFacturacionEDI.QCabeceraEdi.FieldByName('descuento_tfc').AsFloat;

  (*NETO*)
  iLineas:= 0;
  iBases:= 0;
  while not DMFacturacionEdi.QLineasEdi.Eof do
  begin

    (*INICIALIZAR BASES*)
    i:= 0;
    flag:= False;
    while ( i < iBases ) and ( not flag ) do
    begin
      if DMFacturacionEDI.QLineasEdi.FieldByName('iva').AsFloat =  Result.aRImportesBases[i].rTipoIva then
        flag:= True
      else
        inc(i);
    end;
    if not flag then
    begin
      SetLength( Result.aRImportesBases, iBases + 1);
      Result.aRImportesBases[iBases].rTipoIva:= DMFacturacionEdi.QLineasEdi.FieldByName('iva').AsFloat;
      Result.aRImportesBases[i].rNeto:= 0;
      Result.aRImportesBases[i].rDescuento:= 0;
      Result.aRImportesBases[i].rComision:= 0;
      Result.aRImportesBases[i].rGasto:= 0;
      Result.aRImportesBases[i].rBase:= 0;
      Result.aRImportesBases[i].rIva:= 0;
      iBases:= iBases + 1;
    end;

    SetLength( Result.aRImportesLineas, iLineas + 1);
    Result.aRImportesLineas[iLineas].rNeto:= DMFacturacionEdi.QLineasEdi.FieldByName('neto').AsFloat;
    Result.aRImportesLineas[iLineas].rTipoIva:= DMFacturacionEdi.QLineasEdi.FieldByName('iva').AsFloat;
    Result.aRImportesLineas[iLineas].rBase:= Result.aRImportesLineas[iLineas].rNeto;
    Result.aRImportesLineas[iLineas].rDescuento:= 0;
    Result.aRImportesLineas[iLineas].rComision:= 0;
    Result.aRImportesLineas[iLineas].rGasto:= 0;
    Result.rTotalNeto:= Result.rTotalNeto + Result.aRImportesLineas[iLineas].rNeto;

    inc( iLineas );
    DMFacturacionEdi.QLineasEdi.Next;
  end;

  (*COMISION*)
  rAux:= 0;
  Result.rComision:= bRoundTo( ( Result.rTotalNeto *  Result.rTipoComision ) / 100, -2 );
  for i:= 0 to iLineas -1 do
  begin
    Result.aRImportesLineas[i].rComision:= bRoundTo( ( Result.aRImportesLineas[i].rBase *  Result.rTipoComision ) / 100, -2 );
    rAux:= rAux + Result.aRImportesLineas[i].rComision;
  end;
  if rAux <> Result.rComision then
  begin
    rMax:= 0;
    iMax:= 0;
    for i:= 0 to iLineas -1 do
    begin
      if Result.aRImportesLineas[i].rComision > rMax then
      begin
        iMax:= i;
        rMax:= Result.aRImportesLineas[i].rComision;
      end;
    end;
    Result.aRImportesLineas[iMax].rComision:= Result.aRImportesLineas[iMax].rComision + ( Result.rComision - rAux );
  end;
  rAuxBase:= 0;
  for i:= 0 to iLineas -1 do
  begin
    Result.aRImportesLineas[i].rBase:= Result.aRImportesLineas[i].rBase - Result.aRImportesLineas[i].rComision;
    rAuxBase:= rAuxBase + Result.aRImportesLineas[i].rBase;
  end;

  (*DESCUENTO*)
  rAux:= 0;
  Result.rDescuento:= bRoundTo( ( rAuxBase *  Result.rTipoDescuento ) / 100, -2 );
  for i:= 0 to iLineas -1 do
  begin
    Result.aRImportesLineas[i].rDescuento:= bRoundTo( ( Result.aRImportesLineas[i].rBase *  Result.rTipoDescuento ) / 100, -2 );
    rAux:= rAux + Result.aRImportesLineas[i].rDescuento;
  end;
  if rAux <> Result.rDescuento then
  begin
    rMax:= 0;
    iMax:= 0;
    for i:= 0 to iLineas -1 do
    begin
      if Result.aRImportesLineas[i].rDescuento > rMax then
      begin
        iMax:= i;
        rMax:= Result.aRImportesLineas[i].rDescuento;
      end;
    end;
    Result.aRImportesLineas[iMax].rDescuento:= Result.aRImportesLineas[iMax].rDescuento + ( Result.rDescuento - rAux );
  end;
  rAuxBase:= 0;
  for i:= 0 to iLineas -1 do
  begin
    Result.aRImportesLineas[i].rBase:= Result.aRImportesLineas[i].rBase - Result.aRImportesLineas[i].rDescuento;
    rAuxBase:= rAuxBase + Result.aRImportesLineas[i].rBase;
  end;


  (*GASTOS*)
  if not DMFacturacionEdi.QGastosEdi.IsEmpty then
  begin
    if iBases > 1 then
      raise Exception.Create('ERROR: Gastos con lineas con diferentes tipos de IVA.');
    while not DMFacturacionEdi.QGastosEdi.Eof do
    begin
      i:= 0;
      flag:= False;
      while ( i < iBases ) and ( not flag ) do
      begin
        if DMFacturacionEdi.QGastosEdi.FieldByName('iva').AsFloat =  Result.aRImportesBases[i].rTipoIva then
          flag:= True
        else
          inc(i);
      end;
      if not flag then
      begin
        raise Exception.Create('ERROR: Gastos con lineas con diferentes tipos de IVA.');
      end;
      Result.rTotalGasto:= Result.rTotalGasto + DMFacturacionEdi.QGastosEdi.FieldByName('neto').AsFloat;
      DMFacturacionEdi.QGastosEdi.Next;
    end;


    rAux:= 0;
    for i:= 0 to iLineas -1 do
    begin
      if rAuxBase <> 0 then
        Result.aRImportesLineas[i].rGasto:= bRoundTo( ( Result.rTotalGasto * Result.aRImportesLineas[i].rBase ) / rAuxBase, -2)
      else
        Result.aRImportesLineas[i].rGasto:= 0;
      rAux:= rAux + Result.aRImportesLineas[i].rGasto;
    end;
    if rAux <> Result.rTotalGasto then
    begin
      rMax:= 0;
      iMax:= 0;
      for i:= 0 to iLineas -1 do
      begin
        if Result.aRImportesLineas[i].rGasto > rMax then
        begin
          iMax:= i;
          rMax:= Result.aRImportesLineas[i].rGasto;
        end;
      end;
      Result.aRImportesLineas[iMax].rGasto:= Result.aRImportesLineas[iMax].rGasto + ( Result.rTotalGasto - rAux );
    end;
    for i:= 0 to iLineas -1 do
    begin
      Result.aRImportesLineas[i].rBase:= Result.aRImportesLineas[i].rBase + Result.aRImportesLineas[i].rGasto;
    end;
  end;

  //iva lineas
  for i:= 0 to iLineas -1 do
  begin
    Result.aRImportesLineas[i].rIva:= bRoundTo( ( Result.aRImportesLineas[i].rBase * Result.aRImportesLineas[i].rTipoIva ) / 100, -2 );
  end;

  //Relenar distintas bases de IVA
  for i:=0 to iBases -1 do
  begin
   for j:=0 to iLineas -1 do
    begin
      if Result.aRImportesBases[i].rTipoIva = Result.aRImportesLineas[j].rTipoIva then
      begin
        Result.aRImportesBases[i].rNeto:= Result.aRImportesBases[i].rNeto + Result.aRImportesLineas[j].rNeto;
        Result.aRImportesBases[i].rDescuento:= Result.aRImportesBases[i].rDescuento + Result.aRImportesLineas[j].rDescuento;
        Result.aRImportesBases[i].rComision:= Result.aRImportesBases[i].rComision + Result.aRImportesLineas[j].rComision;
        Result.aRImportesBases[i].rGasto:= Result.aRImportesBases[i].rGasto + Result.aRImportesLineas[j].rGasto;
        Result.aRImportesBases[i].rBase:= Result.aRImportesBases[i].rBase + Result.aRImportesLineas[j].rBase;
        //Result.aRImportesBases[i].rIva:= Result.aRImportesBases[i].rIva + Result.aRImportesLineas[j].rIva;
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
    DMFacturacionEDI.QCabeceraEdi.FieldByName('moneda').AsString,
    DMFacturacionEDI.QCabeceraEdi.FieldByName('fecha_tfc').AsString);
  Result.rTotalEuros:= bRoundTo( Result.rTotalImporte * Result.rFactor, -2 );

  DMFacturacionEDI.QLineasEDI.First;
  DMFacturacionEDI.QGastosEDI.First;
end;

//***********************************************************
//Borramos las Lines edi comprendidas entre los numeros de factura
//"desde" y "hasta" que tengan fecha de facturacion "fecha"
//***********************************************************
procedure BorrarEdi;
begin
    with DMFacturacionEdi, DMFacturacionEdi.QAux do
    begin
      SQL.Clear;
      SQL.Add(' DELETE FROM frf_facturas_edi_c ' +
        ' WHERE factura_fec = :factura ' +
        '   AND empresa_fec = :empresa ' +
        '   AND fecha_factura_fec = :fecha ');
      ParamByName('empresa').AsString:= QFacClientesEDI.FieldByName('cod_empresa_tfc').AsString;
      ParamByName('factura').AsInteger:= QFacClientesEDI.FieldByName('n_factura_tfc').AsInteger;
      ParamByName('fecha').AsDate:= QFacClientesEDI.FieldByName('fecha_tfc').AsDateTime;
      EjecutarConsulta(QAux);

      SQL.Clear;
      SQL.Add(' DELETE FROM frf_facturas_edi_l ' +
        ' WHERE factura_fel = :factura ' +
        '   AND empresa_fel = :empresa ' +
        '   AND fecha_factura_fel = :fecha ');
      ParamByName('empresa').AsString:= QFacClientesEDI.FieldByName('cod_empresa_tfc').AsString;
      ParamByName('factura').AsInteger:= QFacClientesEDI.FieldByName('n_factura_tfc').AsInteger;
      ParamByName('fecha').AsDate:= QFacClientesEDI.FieldByName('fecha_tfc').AsDateTime;
      EjecutarConsulta(QAux);

      SQL.Clear;
      SQL.Add(' DELETE FROM frf_impues_edi_l ' +
        ' WHERE factura_iel = :factura ' +
        '   AND empresa_iel = :empresa ' +
        '   AND fecha_factura_iel = :fecha ');
      ParamByName('empresa').AsString:= QFacClientesEDI.FieldByName('cod_empresa_tfc').AsString;
      ParamByName('factura').AsInteger:= QFacClientesEDI.FieldByName('n_factura_tfc').AsInteger;
      ParamByName('fecha').AsDate:= QFacClientesEDI.FieldByName('fecha_tfc').AsDateTime;
      EjecutarConsulta(QAux);

      SQL.Clear;
      SQL.Add(' DELETE FROM frf_impues_edi_c ' +
        ' WHERE factura_iec = :factura ' +
        '   AND empresa_iec = :empresa ' +
        '   AND fecha_factura_iec = :fecha ');
      ParamByName('empresa').AsString:= QFacClientesEDI.FieldByName('cod_empresa_tfc').AsString;
      ParamByName('factura').AsInteger:= QFacClientesEDI.FieldByName('n_factura_tfc').AsInteger;
      ParamByName('fecha').AsDate:= QFacClientesEDI.FieldByName('fecha_tfc').AsDateTime;
      EjecutarConsulta(QAux);
    end;
end;

function GetCodEdi(const AEmpresa, ACliente, AEnvase: String; var VDescripcion, VDun14: string): string;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('select ean13_ee, dun14_ee, descripcion_ee ');
    SQL.Add('from frf_ean13_edi ');
    SQL.Add('where empresa_ee = :empresa ');
    SQL.Add('  and cliente_fac_ee = :cliente ');
    SQL.Add('  and envase_ee = :envase ');
    SQL.Add('  and fecha_baja_ee is null ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('envase').AsString:= AEnvase;
    try
      Open;
      if not IsEmpty then
      begin
        result:= FieldByName('ean13_ee').AsString;
        VDescripcion:= FieldByName('descripcion_ee').AsString;
        if FieldByName('dun14_ee').AsString <> '' then
          VDun14:= FieldByName('dun14_ee').AsString
        else
          VDun14:= Dun14Code( FieldByName('ean13_ee').AsString, 0 )
      end
      else
      begin
        result:= '0000000000000';
        VDescripcion:= 'FALTA CODIGO FACTURACION EDI';
        VDun14:= '00000000000000';
      end;
    finally
      Close;
    end;
  end;
end;

procedure MeteImpuestoCabEdi( const ATipoIva: string );
var
  i: Integer;
begin
  with DMBaseDatos, DMFacturacionEdi do
  begin
    QGeneral.SQL.Clear;
    QGeneral.SQL.Add(' INSERT INTO frf_impues_edi_c ( ');
    QGeneral.SQL.Add(' vendedor_iec, empresa_iec, factura_iec, fecha_factura_iec, tipo_iec, ');
    QGeneral.SQL.Add(' base_iec, porcentaje_iec, importe_iec ) ');
    QGeneral.SQL.Add(' VALUES( ');
    QGeneral.SQL.Add(' :vendedor_iec, :empresa_iec, :factura_iec ,  :fecha_factura_iec , :tipo_iec , ');
    QGeneral.SQL.Add(' :base_iec ,  :porcentaje_iec , :importe_iec ) ');

    QGeneral.ParamByName('empresa_iec').AsString := QCabeceraEdi.FieldByName('cod_empresa_tfc').AsString;
    QGeneral.ParamByName('vendedor_iec').AsString := QCabeceraEdi.FieldByName('vendedor').AsString;
    QGeneral.ParamByName('factura_iec').AsString := QCabeceraEdi.FieldByName('n_factura_tfc').AsString;
    QGeneral.ParamByName('fecha_factura_iec').AsDateTime := QCabeceraEdi.FieldByName('fecha_tfc').AsDateTime;

    for i:= 0 to Length( RImportesCabeceraEDI.aRImportesBases ) - 1 do
    begin
      QGeneral.ParamByName('tipo_iec').AsString := ATipoIva;
      QGeneral.ParamByName('base_iec').AsFloat := RImportesCabeceraEDI.aRImportesBases[i].rBase;
      QGeneral.ParamByName('porcentaje_iec').AsFloat := RImportesCabeceraEDI.aRImportesBases[i].rTipoIva;
      QGeneral.ParamByName('importe_iec').AsFloat := RImportesCabeceraEDI.aRImportesBases[i].rIva;

      EjecutarConsulta(QGeneral);
    end;
  end;
end;

procedure MeteImpuestoLinEdi(const ANumLinea: Integer; const ATipoIva: string );
begin
  with DMBaseDatos, DMFacturacionEdi do
  begin
    QGeneral.SQL.Clear;
    QGeneral.SQL.Add(' INSERT INTO frf_impues_edi_l ( ');
    QGeneral.SQL.Add(' vendedor_iel , empresa_iel, factura_iel ,  fecha_factura_iel ,  num_linea_iel ,  tipo_iel , ');
    QGeneral.SQL.Add(' base_iel ,  porcentaje_iel ,  importe_iel ) ');
    QGeneral.SQL.Add(' VALUES( ');
    QGeneral.SQL.Add(' :vendedor_iel, :empresa_iel, :factura_iel ,  :fecha_factura_iel ,  :num_linea_iel ,  :tipo_iel , ');
    QGeneral.SQL.Add(' :base_iel ,  :porcentaje_iel , :importe_iel ) ');

    QGeneral.ParamByName('empresa_iel').AsString := QCabeceraEdi.FieldByName('cod_empresa_tfc').AsString;
    QGeneral.ParamByName('vendedor_iel').AsString := QCabeceraEdi.FieldByName('vendedor').AsString;
    QGeneral.ParamByName('factura_iel').AsString := QCabeceraEdi.FieldByName('n_factura_tfc').AsString;
    QGeneral.ParamByName('fecha_factura_iel').AsDateTime := QCabeceraEdi.FieldByName('fecha_tfc').AsDateTime;
    QGeneral.ParamByName('num_linea_iel').AsFloat := ANumLinea;

    QGeneral.ParamByName('tipo_iel').AsString := ATipoIva;
    QGeneral.ParamByName('base_iel').AsFloat := RImportesCabeceraEDI.aRImportesLineas[ANumLinea-1].rBase;
    QGeneral.ParamByName('porcentaje_iel').AsFloat := RImportesCabeceraEDI.aRImportesLineas[ANumLinea-1].rTipoIva;
    QGeneral.ParamByName('importe_iel').AsFloat := RImportesCabeceraEDI.aRImportesLineas[ANumLinea-1].rIva;

    EjecutarConsulta(QGeneral);
  end;
end;

function MeteLineaEdi(numLinea: Integer; var AMsg: string ): boolean;
var
  sCodEdi, sDun14, des: string;
begin
  with DMFacturacionEdi, DMBaseDatos do
  begin
    QGeneral.SQL.Clear;
    QGeneral.SQL.Add(' INSERT INTO frf_facturas_edi_l ( ');
    QGeneral.SQL.Add(' empresa_fel,vendedor_fel, factura_fel, fecha_factura_fel ,num_linea_fel ,producto_fel , ');
    QGeneral.SQL.Add(' descripcion_fel , dun14_fel, cantidad_fel ,medida_fel ,unidad_medida_fel , ');
    QGeneral.SQL.Add(' precio_bruto_fel ,precio_neto_fel ,porc_cargo_fel ,cargos_fel , ');
    QGeneral.SQL.Add(' porc_descuen_fel ,descuentos_fel ,neto_fel, bruto_fel, ');
    QGeneral.SQL.Add(' kilos_fel ,cajas_fel ,unidades_caja_fel, peso_caja_fel ) ');
    QGeneral.SQL.Add(' VALUES( ');
    QGeneral.SQL.Add(' :empresa_fel, :vendedor_fel, :factura_fel,:fecha_factura_fel ,:num_linea_fel ,:producto_fel , ');
    QGeneral.SQL.Add(' :descripcion_fel , :dun14_fel, :cantidad_fel ,:medida_fel ,:unidad_medida_fel , ');
    QGeneral.SQL.Add(' :precio_bruto_fel ,:precio_neto_fel ,:porc_cargo_fel ,:cargos_fel , ');
    QGeneral.SQL.Add(' :porc_descuen_fel ,:descuentos_fel ,:neto_fel, :bruto_fel,  ');
    QGeneral.SQL.Add(' :kilos_fel ,:cajas_fel ,:unidades_caja_fel, :peso_caja_fel ) ');



    QGeneral.ParamByName('empresa_fel').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('cod_empresa_tfc').AsString;
    QGeneral.ParamByName('vendedor_fel').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('vendedor').AsString;
    QGeneral.ParamByName('factura_fel').AsString :=
      QCabeceraEdi.FieldByName('n_factura_tfc').AsString;
    QGeneral.ParamByName('fecha_factura_fel').AsDateTime :=
      QCabeceraEdi.FieldByName('fecha_tfc').AsDateTime;
    QGeneral.ParamByName('num_linea_fel').AsFloat := numLinea;

    //sCodEdi:=  GetCodEdiSimple(des);
    AMsg:= DMFacturacionEdi.QLineasEdi.FieldByName('envase_e').AsString + ' - ' +
           desEnvase( DMFacturacionEdi.QLineasEdi.FieldByName('cod_empresa_tf').AsString, DMFacturacionEdi.QLineasEdi.FieldByName('envase_e').AsString );

    sCodEdi:= GetCodEdi( DMFacturacionEdi.QLineasEdi.FieldByName('cod_empresa_tf').AsString,
               DMFacturacionEdi.QCabeceraEdi.FieldByName('cod_cliente').AsString,
               DMFacturacionEdi.QLineasEdi.FieldByName('envase_e').AsString,
               des, sDun14 );
    result:= ( sCodEdi <> '0000000000000' ) and ( sCodEdi <> '' );
    if result then
    begin
      QGeneral.ParamByName('producto_fel').AsString := sCodEdi;
      QGeneral.ParamByName('dun14_fel').AsString := sDun14;
    end
    else
    begin
      Exit;
    end;

    QGeneral.ParamByName('kilos_fel').AsFloat := QLineasEdi.FieldByName('kilos_tf').AsFloat;
    QGeneral.ParamByName('cajas_fel').AsInteger := QLineasEdi.FieldByName('cajas_tf').AsInteger;
    QGeneral.ParamByName('unidades_caja_fel').AsInteger := QLineasEdi.FieldByName('unidades_caja_tf').AsInteger;

    if QLineasEdi.FieldByName('cajas_tf').AsInteger > 0 then
    begin
      QGeneral.ParamByName('peso_caja_fel').AsFloat := bRoundTo( QLineasEdi.FieldByName('kilos_tf').AsInteger /
                                                                 QLineasEdi.FieldByName('cajas_tf').AsInteger, 2);
    end
    else
    begin
      QGeneral.ParamByName('peso_caja_fel').AsFloat := 0;
    end;

    QGeneral.ParamByName('descripcion_fel').AsString := des;
    QGeneral.ParamByName('cantidad_fel').AsFloat := 0.0;

    if QLineasEdi.FieldByName('unidad_medida_tf').AsString = 'KGS' then
    begin
      QGeneral.ParamByName('medida_fel').AsString :=
        QLineasEdi.FieldByName('kilos_tf').AsString;
      QGeneral.ParamByName('unidad_medida_fel').AsString := 'KGM';
    end
    else
      if QLineasEdi.FieldByName('unidad_medida_tf').AsString = 'UND' then
      begin
        QGeneral.ParamByName('medida_fel').AsString :=
          QLineasEdi.FieldByName('unidades_tf').AsString;
        QGeneral.ParamByName('unidad_medida_fel').AsString := 'PCE';
      end
      else
        if QLineasEdi.FieldByName('unidad_medida_tf').AsString = 'CAJ' then
        begin
          QGeneral.ParamByName('medida_fel').AsString :=
            QLineasEdi.FieldByName('cajas_tf').AsString;
          QGeneral.ParamByName('unidad_medida_fel').AsString := 'PCE';
        end;
    QGeneral.ParamByName('precio_bruto_fel').AsFloat := QLineasEdi.FieldByName('precio_unidad_tf').AsFloat;
    QGeneral.ParamByName('precio_neto_fel').AsFloat := QLineasEdi.FieldByName('precio_unidad_tf').AsFloat;
    QGeneral.ParamByName('neto_fel').AsFloat := QLineasEdi.FieldByName('neto').AsFloat;
    QGeneral.ParamByName('bruto_fel').AsFloat := QLineasEdi.FieldByName('neto').AsFloat;

    QGeneral.ParamByName('porc_cargo_fel').AsFloat := 0.0;
    QGeneral.ParamByName('porc_descuen_fel').AsFloat := 0.0;
    QGeneral.ParamByName('cargos_fel').AsFloat := RImportesCabeceraEDI.aRImportesLineas[numLinea-1].rGasto;
    QGeneral.ParamByName('descuentos_fel').AsFloat := RImportesCabeceraEDI.aRImportesLineas[numLinea-1].rComision +
                                                      RImportesCabeceraEDI.aRImportesLineas[numLinea-1].rDescuento;

    EjecutarConsulta(QGeneral);
  end;
end;

function GuardaLineasEdi( var ATipoIva, AMsg: string ): boolean;
var
  numLinea: integer;
  rImporte, rIva: real;
begin
  result:= True;

  with DMFacturacionEdi.QLineasEdi do
  begin
    if FieldByName('tipo_i').AsString = 'IGIC' then
    begin
      ATipoIva := 'IGI';
    end
    else
    begin
      ATipoIva := 'VAT';
    end;

    numLinea := 1;
    while not Eof and Result do
    begin
      result:= MeteLineaEdi( numLinea, AMsg );
      if result then
      begin
        MeteImpuestoLinEdi( numLinea, ATipoIva );
        inc(numLinea);
        Next;
      end;
    end;
  end;
end;

//***********************************************************
//Guardamos la cabecera edi
//***********************************************************
procedure GuardaCabeceraEdi;
var
  rAux: real;
begin
  with DMBaseDatos.QGeneral do
  begin
    SQL.Clear;
    SQL.Add(' INSERT INTO frf_facturas_edi_c ');
    SQL.Add('(empresa_fec, factura_fec,  vendedor_fec,  cobrador_fec,  comprador_fec, ');
    SQL.Add('receptor_fec,  cliente_fec,  pagador_fec,  pedido_fec, ');
    SQL.Add('fecha_factura_fec,  nodo_fec,  rsocial_fec,  domicilio_fec, ');
    SQL.Add('ciudad_fec,  cp_fec,  nif_fec,  albaran_fec,  bruto_fec, ');
    SQL.Add('porc_cargos_fec, cargos_fec,  porc_descuen_fec,  descuentos_fec, ');
    SQL.Add('impuestos_fec,  total_factura_fec,  moneda_fec,  vencimiento1_fec, ');
    SQL.Add('importe_vto1_fec, fecha_albaran_fec, idticket_fec, suministro_fec )');
    SQL.Add('VALUES ');
    SQL.Add('(:empresa_fec, :factura_fec,  :vendedor_fec,  :cobrador_fec,  :comprador_fec, ');
    SQL.Add(':receptor_fec,  :cliente_fec,  :pagador_fec,  :pedido_fec, ');
    SQL.Add(':fecha_factura_fec,  :nodo_fec,  :rsocial_fec,  :domicilio_fec, ');
    SQL.Add(':ciudad_fec, :cp_fec,  :nif_fec,  :albaran_fec,  :bruto_fec, ');
    SQL.Add(':porc_cargos_fec,  :cargos_fec,  :porc_descuen_fec,  :descuentos_fec, ');
    SQL.Add(':impuestos_fec,  :total_factura_fec,  :moneda_fec,  :vencimiento1_fec, ');
    SQL.Add(':importe_vto1_fec, :fecha_albaran, :idticket, :suministro )');

    ParamByName('empresa_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('cod_empresa_tfc').AsString;
    ParamByName('factura_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('n_factura_tfc').AsString;
    ParamByName('vendedor_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('vendedor').AsString;
    ParamByName('cobrador_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('cobrador').AsString;
    ParamByName('comprador_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('comprador').AsString;
    ParamByName('receptor_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('receptor').AsString;
    ParamByName('cliente_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('cliente').AsString;
    ParamByName('pagador_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('pagador').AsString;
    ParamByName('pedido_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('pedido').AsString;
    ParamByName('fecha_factura_fec').AsDateTime :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('fecha_tfc').AsDateTime;
    ParamByName('nodo_fec').AsString := '380'; //Factura normal
    ParamByName('rsocial_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('razon_social').AsString;
    ParamByName('domicilio_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('domicilio').AsString;
    ParamByName('ciudad_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('ciudad').AsString;
    ParamByName('cp_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('cod_postal').AsString;
    ParamByName('nif_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('nif').AsString;
    ParamByName('albaran_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('albaran').AsString;

    ParamByName('bruto_fec').AsFloat := RImportesCabeceraEDI.rTotalNeto;

    ParamByName('porc_cargos_fec').AsFloat := 0.0;
    ParamByName('cargos_fec').AsFloat := RImportesCabeceraEDI.rTotalGasto;

    ParamByName('porc_descuen_fec').AsFloat := 0.0;
    ParamByName('descuentos_fec').AsFloat := RImportesCabeceraEDI.rComision + RImportesCabeceraEDI.rDescuento;

    ParamByName('impuestos_fec').AsFloat := RImportesCabeceraEDI.rTotalIva;

    ParamByName('total_factura_fec').AsFloat := RImportesCabeceraEDI.rTotalImporte;
    ParamByName('moneda_fec').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('moneda').AsString;
    ParamByName('vencimiento1_fec').AsDateTime :=
      GetFechaVencimiento(  DMFacturacionEdi.QCabeceraEdi.FieldByName('cod_empresa_tfc').AsString,
                         DMFacturacionEdi.QCabeceraEdi.FieldByName('cod_cliente').AsString,
                         DMFacturacionEdi.QCabeceraEdi.FieldByName('fecha_tfc').AsDateTime );
    ParamByName('importe_vto1_fec').Asfloat := RImportesCabeceraEDI.rTotalImporte;

    ParamByName('fecha_albaran').AsDateTime :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('fecha_albaran').AsDateTime;
    ParamByName('idticket').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('albaran').AsString;
    ParamByName('suministro').AsString :=
      DMFacturacionEdi.QCabeceraEdi.FieldByName('suministro').AsString;

    EjecutarConsulta(DMBaseDatos.QGeneral);
  end;
end;

function CrearFacturaEDI( var AMsg: string ): boolean;
var
  sTipoIva, sMsg: string;
begin
  result:= False;

  with DMFacturacionEdi do
  begin
    if QCabeceraEdi.IsEmpty then
    begin
      AMsg:= 'Faltan datos EDI del Cliente para la factura ' +
             DMFacturacionEdi.QFacClientesEDI.FieldByName('n_factura_tfc').AsString;
      Exit;
    end;
    if QLineasEdi.IsEmpty then
    begin
      AMsg:= 'Faltan codigos EDI para la factura ' +
             DMFacturacionEdi.QFacClientesEDI.FieldByName('n_factura_tfc').AsString;
      Exit;
    end;


    try
      AbrirTransaccion(DMBaseDatos.DBBaseDatos);
      BorrarEdi;
      RImportesCabeceraEDI:= DatosTotalesFactura;
      GuardaCabeceraEdi;
      result:= GuardaLineasEdi( sTipoIva, sMsg );
      if result then
      begin
        MeteImpuestoCabEdi( sTipoIva );
        AceptarTransaccion(DMBaseDatos.DBBaseDatos);
        AMsg:= 'OK';
      end
      else
      begin
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        AMsg:= 'Faltan codigos EDI para la factura ' +
               DMFacturacionEdi.QFacClientesEDI.FieldByName('n_factura_tfc').AsString + #13 + #10 +
               'Envase -> ' + sMsg;
      end;
    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      raise;
    end;

  end;
end;

procedure FacturacionEDI;
var
  sAux: string;
begin
  sAux:= '';
  DMFacturacionEDI:= TDMFacturacionEDI.Create( nil );;
  try
    with DMFacturacionEdi.QFacClientesEDI do
    begin
      SQL.Clear;
      SQL.Add(' SELECT DISTINCT usuario_tfc, cod_empresa_tfc, n_factura_tfc, fecha_tfc ');
      SQL.Add(' FROM tmp_facturas_c, frf_clientes ');
      SQL.Add(' WHERE usuario_tfc=:usuario ');
      SQL.Add('   AND cod_empresa_tfc = empresa_c ');
      SQL.Add('   AND cod_cliente_tfc = cliente_c ');
      SQL.Add('   AND edi_c = ''S'' ');
      ParamByName('usuario').AsString:= gsCodigo;
      Open;
      try
        While not EOF do
        begin
          if not CrearFacturaEDI( sAux ) then
            ShowError( sAux );
          Next;
        end;
      finally
        Close;
      end;
    end;
  finally
    FreeAndNil( DMFacturacionEDI );
  end;
end;

procedure FacturaEDI(const AEmpresa: string; const AFactura: Integer; const AFecha: TDateTime);
var
  sAux: string;
begin
  sAux:= '';
  DMFacturacionEDI:= TDMFacturacionEDI.Create( nil );;
  try
    with DMFacturacionEdi.QFacClientesEDI do
    begin
      SQL.Clear;
      SQL.Add(' SELECT DISTINCT usuario_tfc, cod_empresa_tfc, n_factura_tfc, fecha_tfc ');
      SQL.Add(' FROM tmp_facturas_c, frf_clientes ');
      SQL.Add(' WHERE usuario_tfc=:usuario ');
      SQL.Add('   AND cod_empresa_tfc = :empresa ');
      SQL.Add('   AND n_factura_tfc = :factura ');
      SQL.Add('   AND fecha_tfc = :fecha ');
      SQL.Add('   AND cod_empresa_tfc = empresa_c ');
      SQL.Add('   AND cod_cliente_tfc = cliente_c ');
      SQL.Add('   AND edi_c = ''S'' ');
      ParamByName('usuario').AsString:= gsCodigo;
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('factura').AsInteger:= AFactura;
      ParamByName('fecha').AsDate:= AFecha;
      Open;
      try
        if not IsEmpty then
        begin
          if not CrearFacturaEDI( sAux ) then
          begin
            ShowError( sAux );
          end;
        end;
      finally
        Close;
      end;
    end;
  finally
    FreeAndNil( DMFacturacionEDI );
  end;
end;

procedure TDMFacturacionEDI.DataModuleCreate(Sender: TObject);
begin
    with QCabeceraEdi do
    begin
      SQL.Clear;
      SQL.Add(' SELECT DISTINCT ');
      SQL.Add('        usuario_tfc, cod_empresa_tfc, factura_tfc, n_factura_tfc, fecha_tfc, ');
      SQL.Add('        cod_cliente_tfc cod_cliente, codigo_ean_e vendedor, codigo_ean_e cobrador, quienpide_ce comprador, ');
      SQL.Add('        quienrecibe_ce receptor, aquiensefactura_ce cliente, quienpaga_ce pagador, ');
      SQL.Add('        pedido_tf pedido, nombre_c razon_social, domicilio_fac_c domicilio, ');
      SQL.Add('        poblacion_fac_c ciudad, cod_postal_fac_c cod_postal, nif_c nif, albaran_tf albaran, ');
      SQL.Add('        comision_tfc, descuento_tfc, cod_moneda_tfc moneda, fecha_alb_tf fecha_albaran, ');
      SQL.Add('        cod_dir_sum_tf suministro ');

      SQL.Add(' FROM tmp_facturas_c, frf_empresas, tmp_facturas_l, frf_clientes, frf_dir_sum, frf_clientes_edi ');

      SQL.Add(' WHERE  cod_empresa_tfc = :cod_empresa_tfc ');
      SQL.Add('    AND n_factura_tfc = :n_factura_tfc ');
      //  AND factura_tfc = :factura
      SQL.Add('    AND fecha_tfc = :fecha_tfc ');
      SQL.Add('    AND usuario_tfc = :usuario_tfc ');

      SQL.Add('    AND empresa_e = :cod_empresa_tfc ');

      SQL.Add('    AND cod_emp_factura_tf = :cod_empresa_tfc ');
      SQL.Add('    AND factura_tf = factura_tfc ');

      SQL.Add('    AND empresa_ce = :cod_empresa_tfc');
      SQL.Add('    AND cod_cliente_sal_tf = cliente_ce ');
      SQL.Add('    AND cod_dir_sum_tf = dir_sum_ce ');

      SQL.Add('    and empresa_ds = :cod_empresa_tfc');
      SQL.Add('    and cliente_ds = cliente_ce ');
      SQL.Add('    and dir_sum_ds = dir_sum_ce ');

      SQL.Add('    AND empresa_c = :cod_empresa_tfc');
      SQL.Add('    AND cod_cliente_tfc = cliente_c ');
    end;

    with QLineasEdi do
    begin
      SQL.Clear;
      SQL.Add(' SELECT cod_empresa_tf, cod_producto_tf, producto_tf, kilos_tf, unidades_tf, unidades_caja_tf, ');
      SQL.Add('        unidad_medida_tf, precio_unidad_tf, categoria_tf, tipo_i, ');
      SQL.Add('        cajas_tf, descripcion_e, envase_e, ');
      SQL.Add('        tipo_iva_tf iva, precio_neto_tf neto ');
      SQL.Add(' FROM Tmp_facturas_l, Frf_impuestos, Frf_envases ');
      SQL.Add(' WHERE  cod_iva_tf = codigo_i ');
      SQL.Add('    AND  usuario_tf = :usuario_tfc ');
      SQL.Add('    AND  factura_tf = :factura_tfc ');
      SQL.Add('    AND  empresa_e = cod_empresa_tf ');
      SQL.Add('    AND  envase_e = cod_envase_tf ');
    end;

    with QGastosEdi do
    begin
      SQL.Clear;
      //SQL.Add(' SELECT sum(importe_tg) importe ');
      SQL.Add(' SELECT iva_tg iva, importe_tg neto ');
      SQL.Add(' FROM tmp_gastos_fac ');
      SQL.Add(' WHERE  factura_tg = :factura_tfc ');
      SQL.Add('   AND    usuario_tg=:usuario_tfc ');
      SQL.Add(' order by iva_tg ');
    end;
end;

procedure TDMFacturacionEDI.QFacClientesEDIAfterOpen(DataSet: TDataSet);
begin
  QCabeceraEdi.Open;
  QLineasEdi.Open;
  QGastosEdi.Open;
end;

procedure TDMFacturacionEDI.QFacClientesEDIBeforeClose(DataSet: TDataSet);
begin
  QGastosEdi.Close;
  QLineasEdi.Close;
  QCabeceraEdi.Close;
end;

end.
