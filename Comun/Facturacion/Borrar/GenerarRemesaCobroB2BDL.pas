(*TODO*)unit GenerarRemesaCobroB2BDL;

interface

uses
  SysUtils, Classes, DB, DBTables, Dialogs, kbmMemTable;

type
  TDLGenerarRemesaCobroB2B = class(TDataModule)
    qryAux: TQuery;
    qryFacturas: TQuery;
    qryOrdenante: TQuery;
    dlgSave: TSaveDialog;
    kmtGiros: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    slFichero: TStringList;
    sMsg: string;
    iContRemesas, iContGiros: Integer;

    sNifOrdenante, sNomOrdenante, sDomicilioOrdenante, sPoblacionOrdenante,
      sProvinciaOrdenante, sPaisOrdenante: string;
    sIdAcreedor: string;
    sEmpresa, sCliente, sBanco: string;
    sIBANEmp, sCCCEmp: string;
    iCodBancoEmp, iCodSucursalEmp: Integer;
    dFechaPago: TDateTime;

    iFactIni, iFactFin: Integer;
    dFechaIni, dFechaFin: TDateTime;
    bFacturas, bFechas: Boolean;

    iAdeudosBloque, iImporteBloque: Integer;
    iBloquesRemesa, iAdeudosRemesa, iImporteRemesa: integer;

    function  SeleccionarFacturas: Boolean;
    procedure ImprimirReport;
    function  DatosOrdenante: Boolean;
    function  GenerarFicheroRemesa( const AVerificarIBAN: Boolean = True ): Boolean;
    function  CrearFichero( const AVerificarIBAN: Boolean = True ): Boolean;

    procedure CabeceraPresentador;
    procedure CabeceraAcreedorFecha( const AVerificarIBAN: Boolean = True );
    procedure LineaDeudor( const AVerificarIBAN: Boolean = True );
    procedure PieAcreedorFecha;
    procedure PieAcreedor;
    procedure TotalFichero;

    function  GuardarFichero: Boolean;
    function  GuardarRemesaBD: Boolean;

    function FacturaCliente: string;
    function MandatoCliente: string;
    function TipoAdeudoCliente: string;
    function NombreCliente: string;
    function DireccionCliente: string;
    function PoblacionCliente: string;
    function ProvinciaCliente: string;
    function PaisCliente: string;
    function CodCliente: string;
    function BICCliente: string;
    function IBANCliente( const AVerificarIBAN: Boolean = True ): string;
    function ImporteCliente: Integer;
    function NumGiro: Integer;
    function Concepto: string;
    function FechaVencimiento: TDateTime;
    function PrimerAdeudo: Boolean;

    procedure ActualizarContadores;
    procedure ActualizarAdeudosMandato;
    procedure MantenimientoRemesas;

  public
    { Public declarations }
    function GenerarRemesa( const AEmpresa, ACliente, ABanco, AIBAN: string;
                             const AFacturas: Boolean;  const AFactIni, AFactFin: Integer;
                             const AFechas: Boolean; const AFechaIni, AFechaFin: TDateTime;
                             const AVerificarIBAN: Boolean = True  ): Boolean;

    function  BloquearGiros( const AEmpresa: string; var VMsg: string ): Boolean;
    procedure DesbloqueraGiros( const AEmpresa: string );
    procedure ShowMessageError;

  end;

  procedure GenerarRemesa( const AEmpresa, ACliente, ABanco, AIBAN: string;
                           const AFacturas: Boolean;  const AFactIni, AFactFin: Integer;
                           const AFechas: Boolean; const AFechaIni, AFechaFin: TDateTime;
                           const AVerificarIBAN: Boolean = True  );


var
  DLGenerarRemesaCobroB2B: TDLGenerarRemesaCobroB2B;

implementation

{$R *.dfm}

uses
   GenerarRemesaCobroQL, Windows, ShlObj, shfolder, bTextUtils, UDMBaseDatos,
   CBancos, UDMAuxDB, blStrBuffer, Variants;





procedure GenerarRemesa( const AEmpresa, ACliente, ABanco, AIBAN: string;
                         const AFacturas: Boolean;  const AFactIni, AFactFin: Integer;
                         const AFechas: Boolean; const AFechaIni, AFechaFin: TDateTime;
                         const AVerificarIBAN: Boolean = True );
var
  sMsg: string;
begin
  DLGenerarRemesaCobroB2B:= TDLGenerarRemesaCobroB2B.Create( nil );
  try
    if DLGenerarRemesaCobroB2B.BloquearGiros( AEmpresa, sMsg ) then
    begin
      try
        DLGenerarRemesaCobroB2B.kmtGiros.Open;
        DLGenerarRemesaCobroB2B.GenerarRemesa( AEmpresa, ACliente, ABanco, AIBAN,
                                               AFacturas, AFactIni, AFactFin,
                                               AFechas, AFechaIni, AFechaFin,
                                               AVerificarIBAN );

      finally
        DLGenerarRemesaCobroB2B.kmtGiros.Close;
        DLGenerarRemesaCobroB2B.DesbloqueraGiros( AEmpresa );
        DLGenerarRemesaCobroB2B.ShowMessageError;
      end;
    end
    else
    begin
      ShowMessage( sMsg );
    end;
  finally
    FreeAndNil(DLGenerarRemesaCobroB2B );
  end;
end;

procedure TDLGenerarRemesaCobroB2B.DataModuleCreate(Sender: TObject);
begin
  with kmtGiros do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cod_empresa', ftString, 3, False);
    FieldDefs.Add('cod_cliente', ftString, 3, False);
    FieldDefs.Add('fecha', ftDate, 0, False);
    FieldDefs.Add('adeudos', ftInteger, 0, False);
    IndexFieldNames := 'cod_cliente;cod_cliente;fecha';
    CreateTable;
  end;
end;

procedure TDLGenerarRemesaCobroB2B.ShowMessageError;
begin
  ShowMessage( sMsg );
end;

function  TDLGenerarRemesaCobroB2B.BloquearGiros( const AEmpresa: string; var VMsg: string ): Boolean;
begin
  qryAux.RequestLive:= True;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('select * ');
  qryAux.SQL.Add('from frf_empresas where empresa_e = :empresa ');
  qryAux.ParamByName('empresa').AsString:= AEmpresa;
  qryAux.Open;
  try
    if qryAux.FieldByName('bloqueo_giros_e').AsInteger = 0 then
    begin
      iContRemesas:= qryAux.FieldByName('cont_remesas_giro_e').AsInteger;
      iContGiros:= qryAux.FieldByName('cont_giros_e').AsInteger;
      qryAux.Edit;
      qryAux.FieldByName('bloqueo_giros_e').AsInteger:= 1;
      try
        qryAux.Post;
        Result:= True;
        VMsg:= 'OK';
      except
        Result:= False;
        VMsg:= 'No puedo bloquear los giros.' + #13 + #10 +
               'Por favor intentelo mas tarde y si sigue el error pongase en contacto con Informática.';
        qryAux.Cancel;
      end;

    end
    else
    begin
     Result:= False;
     VMsg:= 'Giros bloqueados por otro usuario.' + #13 + #10 +
           'Por favor intentelo mas tarde y si siguen bloqueados pongase en contacto con Informática.';
    end;
  finally
    qryAux.Close;
    qryAux.RequestLive:= False;
  end;
end;

procedure TDLGenerarRemesaCobroB2B.DesbloqueraGiros( const AEmpresa: string );
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('update frf_empresas ');
  qryAux.SQL.Add('set bloqueo_giros_e = 0 ');
  qryAux.SQL.Add('where empresa_e = :empresa ');
  qryAux.ParamByName('empresa').AsString:= AEmpresa;
  qryAux.ExecSql;
end;

function TDLGenerarRemesaCobroB2B.GenerarRemesa( const AEmpresa, ACliente, ABanco, AIBAN: string;
                                              const AFacturas: Boolean;  const AFactIni, AFactFin: Integer;
                                              const AFechas: Boolean; const AFechaIni, AFechaFin: TDateTime;
                                              const AVerificarIBAN: Boolean = True  ): boolean;
begin

  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  sBanco:= ABanco;
  sIBANEmp:= AIBAN;
  if not IBANValido( sIBANEmp ) then
  begin
    sMsg:='El IBAN "'+ sIBANEmp + '" de la empresa es incorrecto';
    Abort;
  end;
  sCCCEmp:= IbanToCcc( AIBAN );
  iCodBancoEmp:= StrToInt( Copy( sCCCEmp, 1, 4 ) );
  iCodSucursalEmp:= StrToInt( Copy( sCCCEmp, 5, 4 ) );
  iFactIni:= AFactIni;
  iFactFin:= AFactFin;
  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;
  bFacturas:= AFacturas;
  bFechas:= AFechas;

  try

    if SeleccionarFacturas  then
    begin
      if DatosOrdenante then
      begin
        ImprimirReport;
        result:= GenerarFicheroRemesa( AVerificarIBAN );
      end
      else
      begin
        sMsg:= 'Error al localizar los datos del ordenante ' + sEmpresa + '.';
        result:= False;
      end;
    end
    else
    begin
      sMsg:= 'Sin facturas para los parametros seleccionados.';
      result:= False;
    end;

  finally
    qryFacturas.Close;
  end;
end;

procedure TDLGenerarRemesaCobroB2B.ImprimirReport;
begin
  GenerarRemesaCobroQL.ExecuteReport( Self, qryFacturas, iContRemesas, sBanco, sIBANEmp );
end;

function TDLGenerarRemesaCobroB2B.SeleccionarFacturas: Boolean;
begin
  with qryFacturas do
  begin
    SQL.clear;
    SQL.Add(' select fecha_factura_f + dias_pago_c fecha_pago, ');
    SQL.Add('        iban_cliente_cmd iban_cliente, code_bic_cliente_cmd bic_cliente,   ');
    SQL.Add('        nif_c nif, tipo_impuesto_f[1,1] tipo_iva, ');
    SQL.Add('        empresa_f empresa, cliente_sal_f cliente, nombre_c nombre, dias_pago_c dias_pago,  ');
    SQL.Add('        n_factura_f factura, fecha_factura_f fecha, importe_euros_f importe,  ');
    SQL.Add('              Trim( tipo_via_c || '' '' || domicilio_c ) domicilio, ');
    SQL.Add('              Trim( cod_postal_c || '' '' ||  poblacion_c ) poblacion, ');
    SQL.Add('              cod_postal_c[1,2] provincia, pais_c pais, ');
    SQL.Add('              mandato_cmd mandato, fecha_mandato_cmd fecha_firma_mandato, ');
    SQL.Add('                  adeudos_cmd num_adeudos, fecha_ini_cmd fecha_inicio_mandato ');

    SQL.Add(' from frf_facturas join frf_clientes on ( empresa_c = empresa_f  and cliente_c = cliente_fac_f ) ');
    SQL.Add('                   left join  frf_clientes_mandato_domicializacion on ');
    SQL.Add('                               ( empresa_cmd = empresa_c and cliente_cmd = cliente_c ');
    SQL.Add('                                 and fecha_factura_f between fecha_ini_cmd and nvl(fecha_fin_cmd,fecha_factura_f) ) ');

    SQL.Add(' where empresa_f = :empresa ');
    if sCliente <> '' then
      SQL.Add(' and cliente_fac_f = :clientes ');
    if bFacturas then
      SQL.Add(' and n_factura_f between :facturaini and :facturafin ');
    if bFechas then
      SQL.Add(' and fecha_factura_f between :fechaini and :fechafin ');
    SQL.Add(' and tipo_factura_f = 380 ');
    SQL.Add(' and cod_tipo_pago_c = ''GR''  ');
    //Que no este girada
    SQL.Add(' and not exists ( ');
    SQL.Add('    select * ');
    SQL.Add('    from fct_remesa_giro_d ');
    SQL.Add('    where empresa_fgd = empresa_f ');
    SQL.Add('    and n_factura_fgd = n_factura_f ');
    SQL.Add('    and fecha_factura_fgd = fecha_factura_f ');
    SQL.Add(' ) ');
    //Y que no este cobrada
    SQL.Add('  and not exists ( ');
    SQL.Add('     select * ');
    SQL.Add('     from frf_facturas_remesa ');
    SQL.Add('     where empresa_f = planta_fr ');
    SQL.Add('     and n_factura_f = factura_fr ');
    SQL.Add('     and fecha_factura_f = fecha_factura_fr ');
    SQL.Add('  ) ');
    SQL.Add('   and nvl( iban_cliente_cmd, '''' ) <> '''' ');
    SQL.Add('order by fecha_pago, iban_cliente ');

    ParamByName('empresa').AsString:= sEmpresa;
    if sCliente <> '' then
      ParamByName('clientes').AsString:= sCliente;
    if bFacturas then
    begin
      ParamByName('facturaini').AsInteger:= iFactIni;
      ParamByName('facturafin').AsInteger:= iFactFin;
    end;
    if bFechas then
    begin
      ParamByName('fechaini').AsDateTime:= dFechaIni;
      ParamByName('fechafin').AsDateTime:= dFechaFin;
    end;

    Open;

    result:= not IsEmpty;
  end;
end;

function TDLGenerarRemesaCobroB2B.DatosOrdenante: Boolean;
begin
  with qryOrdenante do
  begin
    SQL.clear;
    SQL.Add('select nombre_e, nif_e, ');
    SQL.Add('       Trim( tipo_via_e  ||  '' '' || domicilio_e ) domicilio, ');
    SQL.Add('       Trim( cod_postal_e  ||  '' '' || poblacion_e ) poblacion, ');
    SQL.Add('       cod_postal_e[1,2] provincia ');
    SQL.Add('from frf_empresas ');
    SQL.Add('where empresa_e = :empresa ');
    ParamByName('empresa').AsString:= sEmpresa;
    Open;

    Result:= not IsEmpty;
    sNifOrdenante:= FieldByName('nif_e').AsString;
    (*TODO*)
    if Copy( sEmpresa, 1, 1 ) = 'F' then
      sNomOrdenante:= 'BONNYSA AGROALIMENTARIA, S.A.'
    else
      sNomOrdenante:= FieldByName('nombre_e').AsString;

    sPaisOrdenante:= 'ES';
    sDomicilioOrdenante:= FieldByName('domicilio').AsString;
    sPoblacionOrdenante:= FieldByName('poblacion').AsString;
    sProvinciaOrdenante:= desProvincia(FieldByName('provincia').AsString);
    Close;
  end;
end;

function TDLGenerarRemesaCobroB2B.GenerarFicheroRemesa( const AVerificarIBAN: Boolean = True ): boolean;
begin
  slFichero:= TStringList.Create;
  try
    if CrearFichero( AVerificarIBAN )  then
    begin
      if GuardarFichero then
      begin
        Result:= GuardarRemesaBD;
      end
      else
      begin
        Result:= False;
      end;
    end
    else
    begin
      Result:= False;
    end;
  finally
    FreeAndNil( slFichero );
  end;
end;

function TDLGenerarRemesaCobroB2B.CrearFichero( const AVerificarIBAN: Boolean = True ): Boolean;
var
  sAcreedorFecha: string;
  bFlag: boolean;
begin
  qryFacturas.First;

  CabeceraPresentador;

  dFechaPago:= qryFacturas.FieldByName('fecha_pago').AsDateTime;
  sAcreedorFecha:= '';
  bFlag:= False;

  while not qryFacturas.Eof do
  begin
    //Solo hay un acreedor, agrupar por fecha
    if sAcreedorFecha = qryFacturas.FieldByName('fecha_pago').AsString then
    begin
      //Añadimos linea al grupo abierto
      LineaDeudor;
    end
    else
    begin
      sAcreedorFecha:= qryFacturas.FieldByName('fecha_pago').AsString;
      if bFlag then
      begin
        //Antes de abrir un nuevo grupo cierro y hay alguna abierto
        PieAcreedorFecha;
      end;

      //Abrir nuevo grupo, ahora cambiamos fecha de pago
      dFechaPago:= qryFacturas.FieldByName('fecha_pago').AsDateTime;
      CabeceraAcreedorFecha( AVerificarIBAN );
      bFlag:= True;
      LineaDeudor;
    end;
    qryFacturas.Next;
  end;
  //Cierro el ultimo abierto
  PieAcreedorFecha;

  PieAcreedor;
  TotalFichero;
  Result:= True;
end;

function Procedimiento: string;
begin
  result:= '06';
end;

function NifValido( const ANif: string ): String;
begin
  Result:= ANif;
end;

function Sufijo: string;
begin
  result:= '000';
end;

function CodINE ( const ACodPostal: string ): string;
var
  i: integer;
begin
  result:= Trim( ACodPostal );
  i:= length( result );
  while i < 9 do
  begin
    result:= '0' + result;
    inc( i );
  end;
end;

function Fecha( const ADate: TDateTime ): integer;
var
  iYear, iMonth, iday: word;
begin
  DecodeDate( ADate, iYear, iMonth, iDay );
  Result:=  iDay +  ( iMonth * 100 ) +  ( iYear * 10000 );
end;

function VersionCuaderno: integer;
begin
  //Cuaderno 19
  //Version 44
  //digito contro 5 --->> modulo 7
  Result:= 19445;
end;

function CodRegistroCabPresentador: integer;
begin
  Result:= 1;
end;

function CodRegistroCabAcreedorFecha: integer;
begin
  Result:= 2;
end;

function CodRegistroLinDeudor: integer;
begin
  Result:= 3;
end;

function CodRegistroPieAcreedorFecha: integer;
begin
  Result:= 4;
end;

function CodRegistroPieAcreedor: integer;
begin
  Result:= 5;
end;

function CodRegistroTotalFichero: integer;
begin
  Result:= 99;
end;

function NumDatoCabPresentador: integer;
begin
  Result:= 1;
end;

function NumDatoCabAcreedorFecha: integer;
begin
  Result:= 2;
end;

function NumDatoLinDeudor: integer;
begin
  Result:= 3;
end;

(*TODO*)
function TDLGenerarRemesaCobroB2B.CodCliente: string;
begin
  Result:= qryFacturas.FieldByName('cliente').AsString;
end;

function TDLGenerarRemesaCobroB2B.NombreCliente: string;
begin
  Result:= qryFacturas.FieldByName('nombre').AsString;
end;

function TDLGenerarRemesaCobroB2B.DireccionCliente: string;
begin
  Result:= qryFacturas.FieldByName('domicilio').AsString;
end;

function TDLGenerarRemesaCobroB2B.PoblacionCliente: string;
begin
  Result:= qryFacturas.FieldByName('poblacion').AsString;
end;

function TDLGenerarRemesaCobroB2B.ProvinciaCliente: string;
begin
  if qryFacturas.FieldByName('pais').AsString = 'ES' then
    Result:= DesProvincia( qryFacturas.FieldByName('provincia').AsString )
  else
    Result:= '';
end;

function TDLGenerarRemesaCobroB2B.PaisCliente: string;
begin
  Result:= qryFacturas.FieldByName('pais').AsString;
end;

function TDLGenerarRemesaCobroB2B.BICCliente: string;
begin
  Result:= qryFacturas.FieldByName('bic_cliente').AsString;
end;

function TDLGenerarRemesaCobroB2B.IBANCliente( const AVerificarIBAN: Boolean = True ): string;
begin
  if IBANValido( qryFacturas.FieldByName('iban_cliente').AsString, AVerificarIBAN )  then
    Result:= qryFacturas.FieldByName('iban_cliente').AsString
  else
  begin
    if qryFacturas.FieldByName('iban_cliente').AsString = '' then
      //Raise exception.Create('Falta la cuenta corriente del cliente "' + qryFacturas.FieldByName('cliente').AsString + '" '+
      //                        qryFacturas.FieldByName('nombre').AsString )
      sMsg:='Falta el IBAN del cliente "' + qryFacturas.FieldByName('cliente').AsString + '" '+
                              qryFacturas.FieldByName('nombre').AsString

    else
      //Raise exception.Create('La cuenta corriente "'+ qryFacturas.FieldByName('iban_cliente').AsString + '" del cliente "' +
      //                        qryFacturas.FieldByName('cliente').AsString + '" '+
      //                        qryFacturas.FieldByName('nombre').AsString );
      sMsg:='El IBAN "'+ qryFacturas.FieldByName('iban_cliente').AsString + '" del cliente "' +
                              qryFacturas.FieldByName('cliente').AsString + '" '+
                              qryFacturas.FieldByName('nombre').AsString + ' es incorrecto';
    Abort;
  end;
end;

function TDLGenerarRemesaCobroB2B.ImporteCliente: Integer;
begin
  //Result:= StrToInt( FormatFloat( '#0', qryFacturas.FieldByName('importe').AsFloat * 100 ) );
  Result:= Trunc( qryFacturas.FieldByName('importe').AsCurrency * 100 );
end;

(*TODO*)
function TDLGenerarRemesaCobroB2B.NumGiro: Integer;
begin
  Result:= iContGiros + iAdeudosRemesa;
end;

function TDLGenerarRemesaCobroB2B.Concepto: string;
begin
  Result:= 'COBRO FACTURA ' + FacturaCliente + ' DE FECHA:' +  FormatDateTime('dd.mm.yy', qryFacturas.FieldByName('fecha').AsDateTime);
end;

(*TODO*)
function TDLGenerarRemesaCobroB2B.FechaVencimiento: TDateTime;
begin
  //No puede se menor que la fecha de generacion del fichero
  result:= qryFacturas.FieldByName('fecha').AsDateTime + qryFacturas.FieldByName('dias_pago').AsInteger;
  if  result <= Date  then
    result:= Date + 5;
end;

function TDLGenerarRemesaCobroB2B.MandatoCliente: string;
begin
  result:= qryFacturas.FieldByName('mandato').AsString;
end;

function TDLGenerarRemesaCobroB2B.PrimerAdeudo: Boolean;
begin
  if kmtGiros.Locate( 'cod_empresa;cod_cliente;fecha',
                      VarArrayOf( [qryFacturas.FieldByName('empresa').AsString,
                                   qryFacturas.FieldByName('cliente').AsString,
                                   qryFacturas.FieldByName('fecha_inicio_mandato').AsDateTime] ), [] ) then
  begin
    kmtGiros.Edit;
    kmtGiros.FieldByName('adeudos').AsInteger:= kmtGiros.FieldByName('adeudos').AsInteger + 1;
    kmtGiros.Post;
    Result:= False;
  end
  else
  begin
    kmtGiros.Insert;
    kmtGiros.FieldByName('cod_empresa').AsString:=  qryFacturas.FieldByName('empresa').AsString;
    kmtGiros.FieldByName('cod_cliente').AsString:= qryFacturas.FieldByName('cliente').AsString;
    kmtGiros.FieldByName('fecha').AsDateTime:= qryFacturas.FieldByName('fecha_inicio_mandato').AsDateTime;
    kmtGiros.FieldByName('adeudos').AsInteger:= qryFacturas.FieldByName('num_adeudos').AsInteger + 1;
    kmtGiros.Post;
    Result:= qryFacturas.FieldByName('num_adeudos').AsInteger = 0;
  end;
end;

function TDLGenerarRemesaCobroB2B.TipoAdeudoCliente: string;
begin
  if PrimerAdeudo then
    result:= 'FRST'
  else
    result:= 'RCUR';
end;

function TDLGenerarRemesaCobroB2B.FacturaCliente: string;
var
  iYear, iMonth, iDay: Word;
begin
  with qryFacturas do
  begin
    if FieldByName('tipo_iva').AsString = 'I' then
    begin
      Result:= 'FCP-';
    end
    else
    begin
      Result:= 'FCT-'
    end;

    Result:= Result + FieldByName('empresa').AsString;
    DecodeDate( FieldByName('fecha').AsDateTime, iYear, iMonth, iDay );
    iYear:= iYear mod 100;
    if iYear < 10 then
    begin
      Result:= Result + '0' + IntToStr( iYear ) + '-';
    end
    else
    begin
      Result:= Result + IntToStr( iYear ) + '-';
    end;
    iDay:= Length( FieldByName('factura').AsString );
    while iDay < 5 do
    begin
      Result:= Result + '0';
      Inc( iDay );
    end;
    Result:= Result + FieldByName('factura').AsString;
  end;
end;

function IdentificacionFichero(const AEmpresa: string; const ARemesa: Integer; const AFecha: TDateTime ): string;
begin
  //¿Cinco posiciones de milisegundos?
  Result:= 'PRE' + FormatDateTime( 'yyyymmddhhnnsszzz', AFecha ) + '00' +
           '000' + AEmpresa + '_' + Rellena( IntToStr( ARemesa ) , 6, '0' );
end;

procedure TDLGenerarRemesaCobroB2B.CabeceraPresentador;
var
  dFecha: TDateTime;
begin
  iBloquesRemesa:= 0;
  iAdeudosRemesa:= 0;
  iImporteRemesa:= 0;

  LimpiaLinea;

  //Codigo de registro
  AddNumeroLinea(CodRegistroCabPresentador, 2);
  //Version cuaderno
  AddNumeroLinea(VersionCuaderno, 5);
  //Codigo de dato
  AddNumeroLinea(NumDatoCabPresentador, 3);
  //Identificador
  sIdAcreedor:= IdentificadorAT_02( 'ES', sNifOrdenante, '000' );
  AddTextoLinea( sIdAcreedor, 35  );
  //Nombre
  AddTextoLinea( sNomOrdenante, 70 );
  //Fecha fichero
  dFecha:= Now;
  AddNumeroLinea( Fecha( dFecha ), 8 );
  //Identificacion del fichero
  AddTextoLinea( IdentificacionFichero( sEmpresa, iContRemesas + 1, dFecha ), 35 );
  //Banco empresa
  AddNumeroLinea( iCodBancoEmp, 4 );
  //Sucursal empresa
  AddNumeroLinea( iCodSucursalEmp, 4 );
  //Libre
  AddLibreLinea( 434 );

  slFichero.Add( Linea );
end;


procedure TDLGenerarRemesaCobroB2B.CabeceraAcreedorFecha( const AVerificarIBAN: Boolean = True );
begin
  iAdeudosBloque:= 0;
  iImporteBloque:= 0;
  iBloquesRemesa:=  iBloquesRemesa  + 1;

  LimpiaLinea;

  //Codigo de registro
  AddNumeroLinea( CodRegistroCabAcreedorFecha, 2);
  //Version cuaderno
  AddNumeroLinea(VersionCuaderno,5);
  //Codigo de dato
  AddNumeroLinea(NumDatoCabAcreedorFecha,3);
  //Identificador
  AddTextoLinea( sIdAcreedor, 35  );
  //Fecha cobro
  AddNumeroLinea( Fecha(  dFechaPago ), 8 );
  //Nombre acreedor
  AddTextoLinea( sNomOrdenante, 70 );
  //domicilio acreedor
  //AddLinea( Texto( sDomicilioOrdenante, 50 ) );
  AddLibreLinea( 50 );
  //poblacion acreedor
  //AddLinea( Texto( sPoblacionOrdenante, 50 ) );
  AddLibreLinea( 50 );
  //provincia  acreedor
  //AddLinea( Texto( sProvinciaOrdenante, 40 ) );
  AddLibreLinea( 40 );
  //pais acreedor
  //AddLinea( sPaisOrdenante );
  AddLibreLinea( 2 );
  //iban  acreedor
  AddTextoLinea( sIBANEmp, 34 );
 //Libre
  AddLibreLinea(  301 );

  slFichero.Add( Linea );

end;

procedure TDLGenerarRemesaCobroB2B.LineaDeudor;
var
  iAux: Integer;
begin
  inc( iAdeudosBloque );
  inc( iAdeudosRemesa );

  iAux:= ImporteCliente;
  iImporteRemesa:= iImporteRemesa +  iAux;
  iImporteBloque:= iImporteBloque +  iAux;

  LimpiaLinea;

  //Codigo de registro
  AddNumeroLinea(CodRegistroLinDeudor, 2);
  //Version cuaderno
  AddNumeroLinea(VersionCuaderno, 5);
  //Codigo de dato
  AddNumeroLinea(NumDatoLinDeudor, 3);

  //Identificacion factura
  AddTextoLinea( FacturaCliente, 35 );
  //mandato cliente
  AddTextoLinea( MandatoCliente, 35 );
  AddTextoLinea( TipoAdeudoCliente, 4 );
  AddLibreLinea( 4 ); //categoria de proposito
  //Importe
  AddNumeroLinea(  iAux, 11 );
  AddNumeroLinea( Fecha( qryFacturas.FieldByName('fecha_firma_mandato').AsDateTime ), 8 );
  AddTextoLinea( BICCliente, 11 );

  //Nombre cliente
  AddTextoLinea( NombreCliente, 70 );
  //AddLinea( Texto( DireccionCliente, 50 ) );
  AddLibreLinea( 50 );
  //AddLinea( Texto( PoblacionCliente, 50 ) );
  AddLibreLinea( 50 );
  //AddLinea( Texto( ProvinciaCliente, 40 ) );
  AddLibreLinea( 40 );
  //AddLinea( Texto( PaisCliente, 2 ) );
  AddLibreLinea( 2 );
  //Optativo
  //AddLinea( Texto( TipoCliente, 1 ) );
  //AddLinea( Texto( IdentificadorCliente, 36 ) );
  //AddLinea( Texto( IdentificadorDeudorEmisor, 35 ) );
  AddLibreLinea( 1 );
  AddLibreLinea( 36 );
  AddLibreLinea( 35 );

  //Cuenta cliente
  AddTextoLinea( 'A', 1 ); //'IBAN'
  AddTextoLinea( IBANCliente( AVerificarIBAN ), 34  );

  AddLibreLinea( 4 ); //Proposito adeudo
  AddTextoLinea( Concepto, 140 );

  AddLibreLinea( 19 );


  slFichero.Add( Linea );
end;


procedure TDLGenerarRemesaCobroB2B.PieAcreedorFecha;
begin
  LimpiaLinea;

  //Codigo de registro
  AddNumeroLinea(CodRegistroPieAcreedorFecha, 2);
  //Identificador
  AddTextoLinea( sIdAcreedor, 35 );
  //Fecha fichero
  AddNumeroLinea( Fecha(  dFechaPago ) , 8 );
  //Importe bloque
  AddNumeroLinea( iImporteBloque, 17, 2 );
  //Importe bloque
  AddNumeroLinea( iAdeudosBloque, 8 );
  //Importe bloque
  AddNumeroLinea( iAdeudosBloque + 2, 10 );
 //Libre
  AddLibreLinea( 520 );

  slFichero.Add( Linea );
end;

procedure TDLGenerarRemesaCobroB2B.PieAcreedor;
begin
  LimpiaLinea;

  //Codigo de registro
  AddNumeroLinea(CodRegistroPieAcreedor,2);
  //Identificador
  AddTextoLinea( sIdAcreedor, 35 );

  //Totales acreedor
  AddNumeroLinea( iImporteRemesa, 17, 2 );
  AddNumeroLinea( iAdeudosRemesa, 8 );
  AddNumeroLinea( iAdeudosRemesa + ( iBloquesRemesa * 2 ) + 1, 10 );


 //Libre
  AddLibreLinea( 528 );

  slFichero.Add( Linea );
end;

procedure TDLGenerarRemesaCobroB2B.TotalFichero;
begin
  LimpiaLinea;

  //Codigo de registro
  AddNumeroLinea(CodRegistroTotalFichero,2);

  //Totales remesa
  AddNumeroLinea( iImporteRemesa, 17 ,2 );
  AddNumeroLinea( iAdeudosRemesa, 8 );
  AddNumeroLinea( iAdeudosRemesa + ( iBloquesRemesa * 2 ) + 3, 10 );
 //Libre
  AddLibreLinea( 563 );

  slFichero.Add( Linea );
end;


procedure TDLGenerarRemesaCobroB2B.MantenimientoRemesas;
var
  iGiros: Integer;
begin
  with qryAux do
  begin
    Sql.Clear;
    Sql.Add('insert into fct_remesa_giro_c (empresa_fgc, n_remesa_fgc, fecha_remesa_fgc, banco_fgc, iban_empresa_fgc) ');
    Sql.Add('values ( :empresa, :remesa, :fecha, :banco, :iban ) ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('remesa').AsInteger:= iContRemesas + 1;
    ParamByName('banco').AsString:= sBanco;
    ParamByName('iban').AsString:= sIBANEmp;
    ParamByName('fecha').AsDate:= Date;
    ExecSQL;

    iGiros:= 1;
    Sql.Clear;
    Sql.Add('insert into fct_remesa_giro_d (empresa_fgd, n_remesa_fgd, n_factura_fgd, fecha_factura_fgd, n_giro_fgd, iban_cliente_fgd ) ');
    Sql.Add('values ( :empresa, :remesa, :factura, :fecha, :giro, :iban ) ');
    qryFacturas.First;
    while not qryFacturas.Eof do
    begin
      ParamByName('empresa').AsString:= sEmpresa;
      ParamByName('remesa').AsInteger:= iContRemesas + 1;
      ParamByName('giro').AsInteger:= iContGiros + iGiros;
      ParamByName('factura').AsInteger:= qryFacturas.FieldByName('factura').AsInteger;
      ParamByName('fecha').AsDateTime:= qryFacturas.FieldByName('fecha').AsDateTime;;
      ParamByName('iban').AsString:= qryFacturas.FieldByName('iban_cliente').AsString;
      ExecSQL;

      qryFacturas.Next;
      Inc( iGiros );
    end;
  end;
end;

procedure TDLGenerarRemesaCobroB2B.ActualizarContadores;
begin
  with qryAux do
  begin
    Sql.Clear;
    Sql.Add('update frf_empresas ');
    Sql.Add('set cont_remesas_giro_e = :remesa, ');
    Sql.Add('    cont_giros_e = :giros ');
    Sql.Add('where empresa_e = :empresa ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('remesa').AsInteger:= iContRemesas + 1;
    ParamByName('giros').AsInteger:= iContGiros + iAdeudosRemesa;
    ExecSQL;
  end;
end;

procedure TDLGenerarRemesaCobroB2B.ActualizarAdeudosMandato;
begin
  kmtGiros.First;
  while not kmtGiros.Eof do
  begin
    //ActualizarAdeudosMandato
    with qryAux do
    begin
      Sql.Clear;
      Sql.Add('update frf_clientes_mandato_domicializacion ');
      Sql.Add('set adeudos_cmd = :adeudos ');
      Sql.Add('where empresa_cmd = :empresa ');
      Sql.Add(' and cliente_cmd = :cliente ');
      Sql.Add(' and fecha_ini_cmd = :fecha ');

      ParamByName('empresa').AsString:= kmtGiros.FieldByName('cod_empresa').AsString;
      ParamByName('cliente').AsString:= kmtGiros.FieldByName('cod_cliente').AsString;
      ParamByName('fecha').AsDateTime:= kmtGiros.FieldByName('fecha').AsDateTime;
      ParamByName('adeudos').AsInteger:= kmtGiros.FieldByName('adeudos').AsInteger;
      ExecSQL;
    end;
    kmtGiros.Next;
  end;
end;

function  TDLGenerarRemesaCobroB2B.GuardarRemesaBD: Boolean;
begin
  result:= True;
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    DMBaseDatos.DBBaseDatos.StartTransaction;
    try
      ActualizarContadores;
      ActualizarAdeudosMandato;
      MantenimientoRemesas;
      DMBaseDatos.DBBaseDatos.Commit;
    except
      DMBaseDatos.DBBaseDatos.Rollback;
      result:= False;
      sMsg:= 'Error al actualizar y grabar los datos de la remesa en la base de datos.';
    end;
  end;
  //Result:= True;
  //actualizar contadores de giro y remesas en empresas
  //rellenar la s tablas de facturas remesas de giro
  //si no puedo dar error y deshacer cambios
end;


function MisDocumentosDir: string;
var
   path: array [0..MAX_PATH] of char;
begin
   ShGetSpecialFolderPath(0,@path[0],CSIDL_PERSONAL,false(*true crea la carpeta *)) ;
   Result := path;
end;

function TDLGenerarRemesaCobroB2B.GuardarFichero: Boolean;
begin
  dlgSave.InitialDir:= MisDocumentosDir;
  dlgSave.FileName:= sEmpresa + '_' + Rellena( IntToStr( iContRemesas + 1) , 6, '0' ) + '.txt';
  if dlgSave.Execute then
  begin
    try
      slFichero.SaveToFile( dlgSave.FileName );
      sMsg:= 'Fichero grabado correctamente.';
      Result:= True;
    except
      sMsg:= 'Error al grabar el fichero.';
      raise;
    end;
  end
  else
  begin
    Result:= False;
    sMsg:= 'Operacion cancelada por el usuario.';
  end;
end;

end.
