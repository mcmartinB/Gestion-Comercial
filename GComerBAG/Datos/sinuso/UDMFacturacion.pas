unit UDMFacturacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, QUICKRPT;

var
  repeticionFlag: boolean;
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
    QAux: TQuery;
    QCabFactura: TQuery;
    DSFacturas: TDataSource;
    QLinFactura: TQuery;
    QGasFactura: TQuery;
    QGetFacturaAnulacion: TQuery;
    QGetAbonoAnulacion: TQuery;
    QRangoFacturas: TQuery;
    QLineaIva: TQuery;
    QGastoIva: TQuery;
    QFacturasIva: TQuery;
    DSFacturasIva: TDataSource;
    QDirFactura: TQuery;
    QIvaGastos: TQuery;
    dsLineaFactura: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //procedure DireccionFactura( const AEmpresa, ACliente, ASuministro: string;
    //                            const AFactura: Integer; const AFecha: TDateTime );
    procedure DireccionFacturaWEB;
  end;

  function GetFechaVencimiento( const AEmpresa, ACliente: string; const AFechaFactura: TDateTime ): TDateTime;

  //PARA LA GENERACION DE PDF Y ENVIO POR EMAIL
function EnviarFacturas(AReport: TQuickRep): boolean;

function CrearPDF( AReport: TQuickRep): boolean;

(*
function PuedoEnviarFactura(var AEmpresa, ACliente, AFecha, ADesde,
  AHasta, AEmail: string): Boolean;
*)
function EnviarPDFFactura(const AFileName: string; var AEmail: string; AMensaje: TStrings;
  const AEsEspanyol: boolean): boolean;

function  NewCodigoFactura( const AEmpresa, ATipo, AImpuesto: string;
                            const AFechaFactura: TDateTime;
                            const AFactura: integer ): string;
function  NewContadorFactura( const AFactura: integer ): string;
function  GetPrefijoFactura( const AEmpresa, ATipo, AImpuesto: string;
                             const AFechaFactura: TDateTime ): string;

function DatosTotalesFactura( const AEmpresa: string; const AFactura: Integer; const AFecha: TDateTime ): TRImportesCabecera;


  //CONTROL DE UNICIDAD Y VALIDEZ
function IsNumFacturaValido(const AEmpresa, AFactura, AFecha, ATipoIva, ATipoFactura: string): boolean;

var
  DMFacturacion: TDMFacturacion;
  Definitiva: Boolean;

implementation

uses bSQLUtils, CVariables, Printers, DConfigMail, UDMAuxDB, CGlobal, UDFactura,
     bTextUtils, DPreview, UDMConfig, bMath, UDMCambioMoneda, QRPDFFilt,
  UDMBaseDatos;

{$R *.DFM}

function GetFechaVencimiento( const AEmpresa, ACliente: string; const AFechaFactura: TDateTime ): TDateTime;
var
  iIncDias, iDiaPago1, iDiaPago2: integer;
  iDia, iMes, iAnyo: word;
  dAux: TDateTime;
begin

  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(dias_cobro_fp,0) dias, nvl(dia_vencim1_c,0) dia1, nvl(dia_vencim2_c,0) dia2 ');
    SQL.Add(' from frf_clientes, frf_forma_pago ');
    SQL.Add(' where empresa_c= :empresa ');
    SQL.Add(' and cliente_c = :cliente ');
    SQL.Add(' and codigo_fp = forma_pago_c ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;
    iIncDias:= FieldByName('dias').AsInteger;
    iDiaPago1:= FieldByName('dia1').AsInteger;
    iDiaPago2:= FieldByName('dia2').AsInteger;
    Close;
  end;

  dAux:= AFechaFactura + iIncDias;
  result:= dAux;
  if iDiaPago1 <> 0 then
  begin
    DecodeDate( dAux, iAnyo, iMes, iDia );
    if iDia > iDiaPago1 then
    begin
      if ( iDiaPago2 = 0 ) or ( iDia > iDiaPago2 ) then
      begin
        dAux:= IncMonth( dAux );
        DecodeDate( dAux, iAnyo, iMes, iDia );
        iDia:= iDiaPago1;
      end
      else
      begin
        iDia:= iDiaPago2;
      end;
    end
    else
    begin
      iDia:= iDiaPago1;
    end;

    case iMes of
      2:
      begin
        if IsLeapYear( iAnyo ) then
        begin
          if iDia > 29 then
            iDia:= 29;
        end
        else
        begin
          if iDia > 28 then
            iDia:= 28;
        end;
      end;
      4,6,9,11:
      begin
        if iDia > 30 then
          iDia:= 30;
      end;
      1,3,5,7,8,10,12:
      begin
        if iDia > 31 then
          iDia:= 31;
      end;
    end;

    result:= EncodeDate( iAnyo, iMes, iDia );
  end;
end;


function  NewCodigoFactura( const AEmpresa, ATipo, AImpuesto: string;
                            const AFechaFactura: TDateTime;
                            const AFactura: integer ): string;
begin
  if ( AFechaFactura >= StrToDate( '1/1/2007' ) ) then
  begin
    result:= GetPrefijoFactura( AEmpresa, ATipo, AImpuesto, AFechaFactura ) +
             NewContadorFactura( AFactura );
  end
  else
  begin
    if ( ATipo = '381' ) and ( AFechaFactura >= StrToDate('1/1/2006') ) then
    begin
        result:= 'AB' + FormatFloat( '00000', AFactura );
    end
    else
    begin
      result:= IntToStr( AFactura );
    end;
  end;
end;

function GetPrefijoFactura( const AEmpresa, ATipo, AImpuesto: string; const AFechaFactura: TDateTime ): string;
var
  iAnyo, iMes, iDia: word;
  sAux: string;
begin
  result:= 'ERROR ';
  DecodeDate( AFechaFactura, iAnyo, iMes, iDia );
  sAux:= IntToStr( iAnyo );
  sAux:= Copy( sAux, 3, 2 );
  if Copy( AImpuesto, 1, 1 ) = 'I' then
  begin
    if ATipo = '380' then
    begin
      result:= 'FCP-' + AEmpresa + sAux + '-';
    end
    else
    begin
      result:= 'ACP-' + AEmpresa + sAux + '-';
    end;
  end
  else
  begin
    if ATipo = '380' then
    begin
      result:= 'FCT-' + AEmpresa + sAux + '-';
    end
    else
    begin
      result:= 'ACT-' + AEmpresa + sAux + '-';
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

function EsEspanyol(const AEmpresa, ACliente: string): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select pais_c from frf_clientes ');
    SQL.Add('where empresa_c ' + SQLEqualS(AEmpresa));
    SQL.Add('and cliente_c ' + SQLEqualS(ACliente));
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
      SQl.Add('where empresa_ds = :empresa ');
      SQl.Add('and cliente_ds = :cliente ');
      SQl.Add('and dir_sum_ds = :dirsum ');
      ParamByName('empresa').AsString:= AEmpresa;
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
        'WHERE empresa_c = :empresa ' +
        ' AND cliente_c = :cliente ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('cliente').AsString:= ACliente;
      Open;
      result := Trim( FieldByName('EMAIL_FAC_C').AsString );
      Close;
    end;
  end;
end;


function EnviarFacturas(AReport: TQuickRep): boolean;
var
  AEmpresa, ACliente, direccion: string;
  AFileName: string;
  slMensaje: TStringList;
begin
  Result:= False;

  if ( uppercase(AReport.Name) = 'RFACTURA' ) and ( DFactura <> nil ) then
  begin
    if  DFactura.mtFacturas_Det.Active then
    begin
      DConfigMail.sSuministroConfig:= DFactura.mtFacturas_Det.FieldByName('cod_dir_sum_fd').asString;
    end
    else
    begin
      DConfigMail.sSuministroConfig:= '';
    end;
  end;

  (*
  if not Definitiva then
  begin
    ShowMessage('No se pueden enviar faturas informativas.');
    Exit;
  end;
  *)
  slMensaje := TStringList.Create;
  DConfigMail.sCampoConfig:= 'email_fac_c';
  direccion:= EMailFactura( DConfigMail.sEmpresaConfig, DConfigMail.sClienteConfig, DConfigMail.sSuministroConfig );
  //if PuedoEnviarFactura(AEmpresa, ACliente, AFecha, ADesde, AHasta, direccion) then
  begin

    if Application.MessageBox('' + #13 + #10 + '¿Desea enviar las facturas por correo electronico?    ' + #13 + #10 + '  ',
      '   ENVIO ELECTRONICO', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
    begin
      if CrearPDF( AReport ) then
      begin
        AFileName := gsDirActual + '\..\temp'  + '\' + AReport.ReportTitle + '.pdf';
        Result:= EnviarPDFFactura( AFileName, direccion, slMensaje, EsEspanyol(AEmpresa, ACliente));
        DeleteFile(AFileName);
      end;
    end;
  end;
  freeandnil(slMensaje);
  DConfigMail.sSuministroConfig:= '';
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

function EnviarPDFFactura(const AFileName: string; var AEmail: string; AMensaje: TStrings;
  const AEsEspanyol: boolean): boolean;
begin
  //Creo el formulario
  with TFDConfigMail.Create(Application) do
  begin
    //Crear PDF, miro el titulo del PDF porque si acaba en punto, hay problemas para adjuntarlo
    //Crear PDF, miro el titulo del PDF porque si acaba en punto, hay problemas para adjuntarlo
    Adjuntos.Clear;
    Adjuntos.Add(AFileName);

    MMensaje.Lines.Clear;
    MMensaje.Lines.Add( AsuntoFactura( DConfigMail.sEmpresaConfig, DConfigMail.sClienteConfig ) );

    //Rellenamos los campos de la pantalla de envio de correo
    EDireccion.Text := AEmail;
    edtCopia.Text:= gsDirCorreo;//gsCuentaCorreo;
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

procedure TDMFacturacion.DataModuleCreate(Sender: TObject);
begin
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
end;

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

procedure TDMFacturacion.DataModuleDestroy(Sender: TObject);
begin
  QGetFacturaAnulacion.Close;
  //if QGetFacturaAnulacion.Prepared then
    //QGetFacturaAnulacion.UnPrepare;
  QGetAbonoAnulacion.Close;
  //if QGetAbonoAnulacion.Prepared then
    //QGetAbonoAnulacion.UnPrepare;
  QRangoFacturas.Close;
  //if QRangoFacturas.Prepared then
    //QRangoFacturas.UnPrepare;
end;

(*
procedure TDMFacturacion.DireccionFactura( const AEmpresa, ACliente, ASuministro: string;
                                           const AFactura: Integer; const AFecha: TDateTime );
begin
  //Seleccion datos suministro/cliente
  with QDirFactura do
  begin
    Close;
    DataSource:= nil;
    SQL.Clear;
    SQL.Add(' SELECT nombre_fd nombre, nif_fd nif , '''' tipo_via, domicilio_fd domicilio,  ');
    SQL.Add('        cod_postal_fd cod_postal, poblacion_fd poblacion, provincia_fd provincia, pais_fd pais ');
    SQL.Add(' FROM frf_facturas_dir ');

    SQL.Add(' WHERE empresa_fd = :empresa ');
    SQL.Add(' and n_factura_fd = :factura ');
    SQL.Add(' and fecha_factura_fd = :fecha ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('factura').AsInteger:= AFactura;
    ParamByName('fecha').AsDateTime:= AFecha;

    Open;

    if IsEmpty then
    begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT nombre_ds nombre, nif_ds nif , tipo_via_ds tipo_via, domicilio_ds domicilio, ');
      SQL.Add('        cod_postal_ds cod_postal, poblacion_ds poblacion,   ');
      SQL.Add('        case when provincia_ds is null ');
      SQL.Add('             then (select nombre_p from frf_provincias where cod_postal_ds[1,2] = codigo_p ) ');
      SQL.Add('            else provincia_ds end provincia, ');
      SQL.Add('        descripcion_p pais');
      SQL.Add(' FROM  frf_dir_sum, frf_paises ');

      SQL.Add(' WHERE empresa_ds = :empresa ');
      SQL.Add(' AND  cliente_ds = :cliente ');
      SQL.Add(' AND  dir_sum_ds = :suministro ');

      SQL.Add(' AND  pais_p = pais_ds ');
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('cliente').AsString := ACliente;
      ParamByName('suministro').AsString := ASuministro;

      Open;
    end;
  end;
end;
*)

procedure TDMFacturacion.DireccionFacturaWEB;
begin
  with QDirFactura do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT nombre_ds nombre, nif_ds nif , tipo_via_ds tipo_via, domicilio_ds domicilio, ');
    SQL.Add('        cod_postal_ds cod_postal, poblacion_ds poblacion,  ');
    SQL.Add('        case when provincia_ds is null ');
    SQL.Add('             then (select nombre_p from frf_provincias where cod_postal_ds[1,2] = codigo_p ) ');
    SQL.Add('            else provincia_ds end provincia, ');
    SQL.Add('        descripcion_p pais');
    SQL.Add(' FROM  frf_dir_sum, frf_paises ');

    SQL.Add(' WHERE empresa_ds = :cod_empresa_tf ');
    SQL.Add(' AND  cliente_ds = :cod_cliente_sal_tf ');
    SQL.Add(' AND  dir_sum_ds = :cod_dir_sum_tf ');

    SQL.Add(' AND  pais_p = pais_ds ');
    DataSource:= dsLineaFactura;
  end;
end;


initialization
  Definitiva := false;

end.





