unit GenerarRemesaCobroDL;

interface

uses
  SysUtils, Classes, DB, DBTables, Dialogs;

type
  TDLGenerarRemesaCobro = class(TDataModule)
    qryAux: TQuery;
    qryFacturas: TQuery;
    qryOrdenante: TQuery;
    dlgSave: TSaveDialog;
  private
    { Private declarations }
    slFichero: TStringList;
    sMsg, sAux: string;
    iContRemesas, iContGiros: Integer;

    sNifOrdenante, sOrdenante, sCodPostal: string;
    sEmpresa, sCliente, sBanco: string;
    sIBANEmp, sCCCEmp, sCodBancoEmp, sCodSucursalEmp: string;

    iFactIni, iFactFin: Integer;
    dFechaIni, dFechaFin: TDateTime;
    bFacturas, bFechas: Boolean;

    iOrdenantes: Integer;
    iLineasCliente: Integer;
    iImporteRemesa: integer;
    sFactura: string;

    function  SeleccionarFacturas: Boolean;
    procedure ImprimirReport;
    function  DatosOrdenante: Boolean;
    function  GenerarFicheroRemesa( const AVerificarCCC: Boolean = True ): Boolean;
    function  CrearFichero( const AVerificarCCC: Boolean = True ): Boolean;
      function  CabeceraPresentador: Boolean;
      function  CabeceraOrdenante: Boolean;
      function  LineasClientes( const AVerificarCCC: Boolean = True ): Boolean;
        function  LineaCliente( const AVerificarCCC: Boolean = True ): Boolean;
      function  PieOrdenante: Boolean;
      function  PiePresentador: Boolean;
    function  GuardarFichero: Boolean;
    function  GuardarRemesaBD: Boolean;

    function FacturaCliente: string;
    function NombreCliente: string;
    function CodCliente: string;
    function CuentaCliente( const AVerificarCCC: Boolean = True ): string;
    function ImporteCliente: Integer;
    function NumGiro: Integer;
    function Concepto: string;
    function FechaVencimiento: TDateTime;

    procedure ActualizarContadores;
    procedure MantenimientoRemesas;

    procedure LimpiaLinea;
    procedure AddLinea( const AToken: string );
    function  Linea: string;

  public
    { Public declarations }
    function GenerarRemesa( const AVerificarCCC: Boolean = True  ): Boolean;

    function  BloquearGiros( var VMsg: string ): Boolean;
    procedure DesbloqueraGiros;
    procedure ShowMessageError;

  end;

  procedure FacturasRemesa( const AEmpresa, ACliente, ABanco, AIBAN: string;
                         const AFacturas: Boolean;  const AFactIni, AFactFin: Integer;
                         const AFechas: Boolean; const AFechaIni, AFechaFin: TDateTime );
  procedure GenerarRemesa( const AEmpresa, ACliente, ABanco, AIBAN: string;
                           const AFacturas: Boolean;  const AFactIni, AFactFin: Integer;
                           const AFechas: Boolean; const AFechaIni, AFechaFin: TDateTime;
                           const AVerificarCCC: Boolean = True  );

var
  DLGenerarRemesaCobro: TDLGenerarRemesaCobro;

implementation

{$R *.dfm}

uses
   GenerarRemesaCobroQL, Windows, ShlObj, shfolder, bTextUtils, UDMBaseDatos, CBancos;


procedure FacturasRemesa( const AEmpresa, ACliente, ABanco, AIBAN: string;
                         const AFacturas: Boolean;  const AFactIni, AFactFin: Integer;
                         const AFechas: Boolean; const AFechaIni, AFechaFin: TDateTime );
var
  sMsg: string;
begin
  DLGenerarRemesaCobro:= TDLGenerarRemesaCobro.Create( nil );
  try
    with DLGenerarRemesaCobro do
    begin
      sEmpresa:= AEmpresa;
      sCliente:= ACliente;
      sBanco:= ABanco;

      sIBANEmp:= AIBAN;
      sCCCEmp:= IbanToCcc( AIBAN );
      sCodBancoEmp:= Copy( sCCCEmp, 1, 4 );
      sCodSucursalEmp:= Copy( sCCCEmp, 5, 4 );

      iFactIni:= AFactIni;
      iFactFin:= AFactFin;
      dFechaIni:= AFechaIni;
      dFechaFin:= AFechaFin;
      bFacturas:= AFacturas;
      bFechas:= AFechas;

      if DLGenerarRemesaCobro.SeleccionarFacturas then
      begin
        iContRemesas:= -1;
        ImprimirReport;
      end
      else
      begin
        ShowMessage( 'Sin facturas para los parametros seleccionados.' );
      end
    end;
  finally
    FreeAndNil(DLGenerarRemesaCobro );
  end;
end;



procedure GenerarRemesa( const AEmpresa, ACliente, ABanco, AIBAN: string;
                         const AFacturas: Boolean;  const AFactIni, AFactFin: Integer;
                         const AFechas: Boolean; const AFechaIni, AFechaFin: TDateTime;
                         const AVerificarCCC: Boolean = True );
var
  sMsg: string;
begin
  DLGenerarRemesaCobro:= TDLGenerarRemesaCobro.Create( nil );
  with DLGenerarRemesaCobro do
  begin
    sEmpresa:= AEmpresa;
    sCliente:= ACliente;
    sBanco:= ABanco;

    sIBANEmp:= AIBAN;
    sCCCEmp:= IbanToCcc( AIBAN );
    sCodBancoEmp:= Copy( sCCCEmp, 1, 4 );
    sCodSucursalEmp:= Copy( sCCCEmp, 5, 4 );

    iFactIni:= AFactIni;
    iFactFin:= AFactFin;
    dFechaIni:= AFechaIni;
    dFechaFin:= AFechaFin;
    bFacturas:= AFacturas;
    bFechas:= AFechas;
  end;

  try
    if DLGenerarRemesaCobro.BloquearGiros( sMsg ) then
    begin
      try
        DLGenerarRemesaCobro.GenerarRemesa( AVerificarCCC );

      finally
        DLGenerarRemesaCobro.DesbloqueraGiros;
        DLGenerarRemesaCobro.ShowMessageError;
      end;
    end
    else
    begin
      ShowMessage( sMsg );
    end;
  finally
    FreeAndNil(DLGenerarRemesaCobro );
  end;
end;

procedure TDLGenerarRemesaCobro.ShowMessageError;
begin
  ShowMessage( sMsg );
end;

function  TDLGenerarRemesaCobro.BloquearGiros( var VMsg: string ): Boolean;
begin
  qryAux.RequestLive:= True;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('select * ');
  qryAux.SQL.Add('from frf_empresas where empresa_e = :empresa ');
  qryAux.ParamByName('empresa').AsString:= sEmpresa;
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

procedure TDLGenerarRemesaCobro.DesbloqueraGiros;
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('update frf_empresas ');
  qryAux.SQL.Add('set bloqueo_giros_e = 0 ');
  qryAux.SQL.Add('where empresa_e = :empresa ');
  qryAux.ParamByName('empresa').AsString:= sEmpresa;
  qryAux.ExecSql;
end;

function TDLGenerarRemesaCobro.GenerarRemesa( const AVerificarCCC: Boolean = True  ): boolean;
begin
  try

    if SeleccionarFacturas  then
    begin
      if DatosOrdenante then
      begin
        ImprimirReport;
        result:= GenerarFicheroRemesa( AVerificarCCC );
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

procedure TDLGenerarRemesaCobro.ImprimirReport;
begin
  GenerarRemesaCobroQL.ExecuteReport( Self, qryFacturas, iContRemesas, sBanco, sIBANEmp );
end;

function TDLGenerarRemesaCobro.SeleccionarFacturas: Boolean;
begin
  with qryFacturas do
  begin
    SQL.clear;
    SQL.Add(' select iban_cliente_cmd iban_cliente, nif_c nif, tipo_impuesto_f[1,1] tipo_iva, ');
    SQL.Add('        empresa_f empresa, cliente_sal_f cliente, nombre_c nombre, ');
    SQL.Add('        dias_pago_c dias_pago, n_factura_f factura, fecha_factura_f fecha, ');
    SQL.Add('        importe_euros_f importe, fecha_factura_f + dias_pago_c fecha_pago, ');
    SQL.Add('              Trim( tipo_via_c || '' '' || domicilio_c ) domicilio, ');
    SQL.Add('              Trim( cod_postal_c || '' '' ||  poblacion_c ) poblacion, ');
    SQL.Add('              cod_postal_c[1,2] provincia, pais_c pais,  ');
    SQL.Add('              code_bic_cliente_cmd bic_cliente, mandato_cmd mandato, ');
    SQL.Add('              fecha_mandato_cmd fecha_mandato, adeudos_cmd num_adeudos ');

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
    //
    SQL.Add('   and nvl( iban_cliente_cmd, '''' ) <> '''' ');
    SQL.Add('order by iban_cliente, nif_c');

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

function TDLGenerarRemesaCobro.DatosOrdenante: Boolean;
begin
  with qryOrdenante do
  begin
    SQL.clear;
    SQL.Add('select * from frf_empresas where empresa_e = :empresa');
    ParamByName('empresa').AsString:= sEmpresa;
    Open;
    Result:= not IsEmpty;
    sNifOrdenante:= FieldByName('nif_e').AsString;
    (*TODO*)
    if Copy( sEmpresa, 1, 1 ) = 'F' then
      sOrdenante:= 'BONNYSA AGROALIMENTARIA, S.A.'
    else
      sOrdenante:= FieldByName('nombre_e').AsString;
    sCodPostal:= FieldByName('cod_postal_e').AsString;
    Close;
  end;
end;

function TDLGenerarRemesaCobro.GenerarFicheroRemesa( const AVerificarCCC: Boolean = True ): boolean;
begin
  slFichero:= TStringList.Create;
  try
    if CrearFichero( AVerificarCCC )  then
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

function TDLGenerarRemesaCobro.CrearFichero( const AVerificarCCC: Boolean = True ): Boolean;
begin
    if CabeceraPresentador then
    begin
      iOrdenantes:= 0;
      if CabeceraOrdenante then
      begin
        if LineasClientes( AVerificarCCC ) then
        begin
          if PieOrdenante then
          begin
            Result:= PiePresentador;
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

function Fecha( const ADate: TDateTime ): string;
var
  iYear, iMonth, iday: word;
begin
  DecodeDate( ADate, iYear, iMonth, iDay );
  if iDay < 10 then
    Result:= '0' + IntToStr( iDay )
  else
    Result:= IntToStr( iDay );

  if iMonth < 10 then
    Result:= Result + '0' + IntToStr( iMonth )
  else
    Result:= Result + IntToStr( iMonth );

  iYear:= iYear mod 100;
  if iYear < 10 then
    Result:= Result + '0' + IntToStr( iYear )
  else
    Result:= Result + IntToStr( iYear );
end;

function Libre( const ACount: integer ): string;
var
  i: Integer;
begin
  Result:= '';
  for i:= 1 to ACount do
   Result:= Result + ' ';
end;

function Texto( const ATexto: string; const ACount: integer ): string;
var
  i: Integer;
begin
  Result:= Trim( ATexto );
  i:= length( result );
  if i >= ACount then
    Result:= Copy( Result , 1, ACount )
  else
  begin
    while i < ACount do
    begin
      result:= result + ' ';
      inc( i );
    end;
  end;
end;

function Numero( const ANumero: Real; const ACount: integer; const ADecimales: integer = 0 ): string;
var
  i, iAux: Integer;
begin
  iAux:= 1;
  for i:= 1 to ADecimales do
   iAux:= iAux * 10;

  iAux:= Trunc( ANumero * iAux );
  Result:= IntToStr( iAux);
  i:= length( result );
  if i >= ACount then
    Result:= Copy( Result , 1, ACount )
  else
  begin
    while i < ACount do
    begin
      result:= '0' + result;
      inc( i );
    end;
  end;
end;

function CodDato: string;
begin
  Result:= '70';
end;

function CodCabPresentador: string;
begin
  Result:= '51';
end;

function CodCabOrdenante: string;
begin
  Result:= '53';
end;

function CodLineaCliente: string;
begin
  Result:= '56';
end;

function CodPieOrdenante: string;
begin
  Result:= '58';
end;

function CodPiePresentador: string;
begin
  Result:= '59';
end;

procedure TDLGenerarRemesaCobro.LimpiaLinea;
begin
  sAux:= '';
end;

procedure TDLGenerarRemesaCobro.AddLinea( const AToken: string );
begin
  sAux:= sAux + AToken;
end;

function  TDLGenerarRemesaCobro.Linea: string;
begin
  result:= sAux;
end;


function TDLGenerarRemesaCobro.CodCliente: string;
begin
  Result:= qryFacturas.FieldByName('cliente').AsString;
end;

function TDLGenerarRemesaCobro.NombreCliente: string;
begin
  Result:= qryFacturas.FieldByName('nombre').AsString;
end;



function TDLGenerarRemesaCobro.CuentaCliente( const AVerificarCCC: Boolean = True ): string;
var
  sCCC: string;
begin
  sCCC:= Copy( qryFacturas.FieldByName('iban_cliente').AsString, 5, 20 );
  if CCCValida( sCCC, AVerificarCCC )  then
    Result:= sCCC
  else
  begin
    if sCCC = '' then
      //Raise exception.Create('Falta la cuenta corriente del cliente "' + qryFacturas.FieldByName('cliente').AsString + '" '+
      //                        qryFacturas.FieldByName('nombre').AsString )
      sMsg:='Falta la cuenta corriente del cliente "' + qryFacturas.FieldByName('cliente').AsString + '" '+
                              qryFacturas.FieldByName('nombre').AsString

    else
      //Raise exception.Create('La cuenta corriente "'+ qryFacturas.FieldByName('iban_cliente').AsString + '" del cliente "' +
      //                        qryFacturas.FieldByName('cliente').AsString + '" '+
      //                        qryFacturas.FieldByName('nombre').AsString );
      sMsg:='La cuenta corriente "'+ sCCC + '" del cliente "' +
                              qryFacturas.FieldByName('cliente').AsString + '" '+
                              qryFacturas.FieldByName('nombre').AsString + ' es incorrecta';
    Abort;
  end;
end;

function TDLGenerarRemesaCobro.ImporteCliente: Integer;
begin
  //Result:= StrToInt( FormatFloat( '#0', qryFacturas.FieldByName('importe').AsFloat * 100 ) );
  Result:= Trunc( qryFacturas.FieldByName('importe').AsCurrency * 100 );
end;

function TDLGenerarRemesaCobro.NumGiro: Integer;
begin
  Result:= iContGiros + iLineasCliente;
end;

function TDLGenerarRemesaCobro.Concepto: string;
begin
  Result:= Texto( 'FACTURA ' + sFactura + ' F.FACT.:' +
                  FormatDateTime('dd.mm.yy', qryFacturas.FieldByName('fecha').AsDateTime), 40);
end;

function TDLGenerarRemesaCobro.FechaVencimiento: TDateTime;
var
  dAux: TDateTime;
begin
  //No puede se menor que la fecha de generacion del fichero
  result:= qryFacturas.FieldByName('fecha').AsDateTime + qryFacturas.FieldByName('dias_pago').AsInteger;
  if  result <= Date  then
    result:= Date + 1;
end;

function TDLGenerarRemesaCobro.FacturaCliente: string;
var
  iYear, iMonth, iDay: Word;
begin
  with qryFacturas do
  begin
    if FieldByName('tipo_iva').AsString = 'I' then
    begin
      Result:= 'FP';
      sFactura:= 'FCP-';
    end
    else
    begin
      Result:= 'FT';
      sFactura:= 'FCT-'
    end;

    Result:= Result + FieldByName('empresa').AsString;
    sFactura:= sFactura + FieldByName('empresa').AsString;
    DecodeDate( FieldByName('fecha').AsDateTime, iYear, iMonth, iDay );
    iYear:= iYear mod 100;
    if iYear < 10 then
    begin
      Result:= Result + '0' + IntToStr( iYear );
      sFactura:= sFactura + '0' + IntToStr( iYear ) + '-';
    end
    else
    begin
      Result:= Result + IntToStr( iYear );
      sFactura:= sFactura + IntToStr( iYear ) + '-';
    end;
    iDay:= Length( FieldByName('factura').AsString );
    while iDay < 5 do
    begin
      Result:= Result + '0';
      sFactura:= sFactura + '0';
      Inc( iDay );
    end;
    Result:= Result + FieldByName('factura').AsString;
    sFactura:= sFactura + FieldByName('factura').AsString;
  end;
end;

function  TDLGenerarRemesaCobro.CabeceraPresentador: Boolean;
begin
  result:= False;

  LimpiaLinea;

  //Codigo de registro
  AddLinea(CodCabPresentador);
  //Codigo de dato
  AddLinea(CodDato);
  //Codigo de presentador
  //  Nif
  AddLinea( NifValido( sNifOrdenante ) );
  //  Sufijo
  AddLinea( Sufijo );
  //Fecha fichero
  AddLinea( Fecha( Now ) );
  //Libre
  AddLinea( Libre( 6 ) );
  //Nombre
  AddLinea( Texto( sOrdenante, 40 ) );
  //Libre
  AddLinea( Libre( 20 ) );
  //Banco empresa
  AddLinea( sCodBancoEmp );
  //Banco sucursal
  AddLinea( sCodSucursalEmp );
  //Libre
  AddLinea( Libre(12) );
  AddLinea( Libre(40) );
  AddLinea( Libre(14) );

  slFichero.Add( Linea );

  result:= True;
end;

function  TDLGenerarRemesaCobro.CabeceraOrdenante: Boolean;
begin
  result:= False;

  Inc( iOrdenantes );
  LimpiaLinea;

  //Codigo de registro
  AddLinea(CodCabOrdenante);
  //Codigo de dato
  AddLinea(CodDato);
  //Codigo de presentador
  //  Nif
  AddLinea( NifValido( sNifOrdenante ) );
  //  Sufijo
  AddLinea( Sufijo );
  //Fecha fichero
  AddLinea( Fecha( Now ) );
  //Libre
  AddLinea( Libre( 6 ) );
  //Nombre
  AddLinea( Texto( sOrdenante, 40 ) );
  //Libre
  AddLinea( sCCCEmp );
  //Banco empresa
  AddLinea( Libre(8) );
  //Banco sucursal
  AddLinea( Procedimiento );
  //Libre
  AddLinea( Libre(10) );
  AddLinea( Libre(40) );
  AddLinea( Libre(2) );
  //Codigo INE Plaza emision
  AddLinea( CodINE( sCodPostal ) );
  //Libre
  AddLinea( Libre(3) );

  slFichero.Add( Linea );

  result:= True;
end;

function  TDLGenerarRemesaCobro.LineasClientes( const AVerificarCCC: Boolean = True ): Boolean;
begin
  result:= True;
  iLineasCliente:= 0;
  iImporteRemesa:= 0;

  with qryFacturas do
  begin
    First;
    while not Eof and result do
    begin
      result:= LineaCliente( AVerificarCCC );
      Next;
    end;
  end;
end;

function  TDLGenerarRemesaCobro.LineaCliente( const AVerificarCCC: Boolean = True ): Boolean;
var
  iAux: Integer;
begin
  result:= False;

  inc( iLineasCliente );
  LimpiaLinea;

  //Codigo de registro
  AddLinea(CodLineaCliente);
  //Codigo de dato
  AddLinea(CodDato);
  //Codigo de presentador
  //  Nif
  AddLinea( NifValido( sNifOrdenante ) );
  //  Sufijo
  AddLinea( Sufijo );
  //Identificacion factura
  AddLinea( FacturaCliente );
  //Nombre cliente
  AddLinea( Texto( NombreCliente, 40 ) );
  //Cuenta cliente
  AddLinea( Texto( CuentaCliente( AVerificarCCC ), 20 ) );
  //Importe
  iAux:= ImporteCliente;
  iImporteRemesa:= iImporteRemesa +  iAux;
  AddLinea( Numero( iAux, 10 ) );

  //Num giro
  AddLinea( Numero( NumGiro, 6 ) );
  AddLinea( CodCliente + Numero( NumGiro, 7 ) );

  //Concepto
  AddLinea( Concepto );

  //Codigo INE Plaza emision
  AddLinea( Fecha( FechaVencimiento ) );
  //Libre
  AddLinea( Libre(2) );

  slFichero.Add( Linea );

  result:= True;
end;

function  TDLGenerarRemesaCobro.PieOrdenante: Boolean;
begin
  result:= False;

  LimpiaLinea;

  //Codigo de registro
  AddLinea(CodPieOrdenante);
  //Codigo de dato
  AddLinea(CodDato);
  //Codigo de presentador
  //  Nif
  AddLinea( NifValido( sNifOrdenante ) );
  //  Sufijo
  AddLinea( Sufijo );

  //Libre
  AddLinea( Libre( 12 ) );
  AddLinea( Libre( 40 ) );
  AddLinea( Libre( 20 ) );

  //Importe ordenante
  AddLinea( Numero( iImporteRemesa, 10 ) );

  //Libre
  AddLinea( Libre( 6 ) );

  //Lineas
  AddLinea( Numero( iLineasCliente, 10 ) );
  AddLinea( Numero( iLineasCliente + 2, 10 ) );

  //Libre
  AddLinea( Libre( 20 ) );
  AddLinea( Libre( 18 ) );

  slFichero.Add( Linea );

  result:= True;
end;

function  TDLGenerarRemesaCobro.PiePresentador: Boolean;
begin
  result:= False;

  LimpiaLinea;

  //Codigo de registro
  AddLinea(CodPiePresentador);
  //Codigo de dato
  AddLinea(CodDato);
  //Codigo de presentador
  //  Nif
  AddLinea( NifValido( sNifOrdenante ) );
  //  Sufijo
  AddLinea( Sufijo );

  //Libre
  AddLinea( Libre( 12 ) );
  AddLinea( Libre( 40 ) );

  //Numero de ordenante
  AddLinea( Numero( iOrdenantes, 4 ) );
  //libre
  AddLinea( Libre( 16 ) );

  //Importe ordenante
  AddLinea( Numero( iImporteRemesa, 10 ) );

  //Libre
  AddLinea( Libre( 6 ) );

  //Lineas
  AddLinea( Numero( iLineasCliente, 10 ) );
  AddLinea( Numero( iLineasCliente + 4, 10 ) );

  //Libre
  AddLinea( Libre( 20 ) );
  AddLinea( Libre( 18 ) );

  slFichero.Add( Linea );

  result:= True;
end;


procedure TDLGenerarRemesaCobro.MantenimientoRemesas;
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
      ParamByName('fecha').AsDateTime:= qryFacturas.FieldByName('fecha').AsDateTime;
      ParamByName('iban').AsString:= qryFacturas.FieldByName('iban_cliente').AsString;
      ExecSQL;

      qryFacturas.Next;
      Inc( iGiros );
    end;
  end;
end;


procedure TDLGenerarRemesaCobro.ActualizarContadores;
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
    ParamByName('giros').AsInteger:= iContGiros + iLineasCliente;
    ExecSQL;
  end;
end;

function  TDLGenerarRemesaCobro.GuardarRemesaBD: Boolean;
begin
  result:= False;
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    DMBaseDatos.DBBaseDatos.StartTransaction;
    try
      ActualizarContadores;
      MantenimientoRemesas;
      DMBaseDatos.DBBaseDatos.Commit;
      result:= True;
    except
      DMBaseDatos.DBBaseDatos.Rollback;
      sMsg:= 'Error al actualizar y grabar los datos de la remesa en la base de datos.';
    end;
  end;
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

function TDLGenerarRemesaCobro.GuardarFichero: Boolean;
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
      Result:= False;
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
