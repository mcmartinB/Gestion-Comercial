unit UDMConfig;

interface

uses
  SysUtils, Classes, DB, DBTables, Windows;

type
  TDMConfig = class(TDataModule)
    QUsuarios: TQuery;
    QAccesos: TQuery;
    QImpresoras: TQuery;
    QCuentaCorreo: TQuery;
    QAltaImpresoras: TQuery;
    QDatosDefecto: TQuery;
    QInstalacion: TQuery;
    QDirectorios: TQuery;
    QConfiguracion: TQuery;
    QLogon: TQuery;
    QAux: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    iCuenta: integer;

    procedure ImpresorasSeleccionadas;
  public
    { Public declarations }

    //Barra de herramientas
    bBarraAplicaciones: boolean;

    //Valores configuracion
    sEmpresaInstalacion, sCentroInstalacion, sDesInstalacion: String;
    iInstalacion, iCodigoBD:integer;

    procedure LoadConfig;

    procedure Logon;
    procedure Logoff;

    procedure DatosUsuario;
    procedure DatosCuentaCorreo;
    procedure DatosPorDefecto;
    procedure DatosInstalacion;
    procedure Impresoras;
    procedure GrabarImpresoras;
    procedure DatosVersion;
    procedure CargaDirectorios;
    procedure ConfiguracionPrograma;

    function CodigoBD: integer;


    function EsLOsLlanos: boolean;

    function EsLaFont: boolean;
    function EsLaFontEx: boolean;
    function EsUnAlmacen: boolean;
    function EsMaset: boolean;
    function EsValencia: boolean;
    function EsTenerife: boolean;
    function EsSevilla: boolean;
    function EsFrutibon: boolean;
    function EsChanita: boolean;
    function EsLasMoradas: boolean;

    function PuedoTransferir: boolean;
    function PuedoTransferirOpcion( const AOpcion: string ): boolean;
  end;

var
  DMConfig: TDMConfig;
  sFileIni: string;

procedure LoadIni;

implementation

{$R *.dfm}

uses IniFiles, CVariables, Printers, Dialogs, Variants;

procedure TDMConfig.DataModuleCreate(Sender: TObject);
begin
  with QInstalacion do
  begin
    SQL.Clear;
    SQL.Add('select i1.codigo_ci, i1.empresa_ci, i1.centro_ci, i1.codigo_bd_ci, i2.descripcion_ci ');
    SQL.Add('from cnf_instalacion i1, cnf_instalaciones i2');
    SQL.Add('where i1.codigo_ci = i2.codigo_ci');
    Prepare;
  end;
  with QUsuarios do
  begin
    SQL.Clear;
    SQL.Add('select * from cnf_usuarios');
    SQL.Add('where usuario_cu = :usuario');
    Prepare;
  end;
  with QLogon do
  begin
    RequestLive:= True;
    SQL.Clear;
    SQL.Add('select * from cnf_usuarios');
    SQL.Add('where usuario_cu = :usuario');
    Prepare;
  end;
  with QAccesos do
  begin
    RequestLive:= TRue;
    SQL.Clear;
    SQL.Add('select usuario_ca, maquina_ca, accion_ca, instante_ca');
    SQL.Add('from cnf_accesos');
    Prepare;
  end;
  with QCuentaCorreo do
  begin
    SQL.Clear;
    SQL.Add('select * from cnf_cuentas_correo');
    SQL.Add('where codigo_ccc = :codigo');
    Prepare;
  end;
  with QImpresoras do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from cnf_impresoras ');
    SQL.Add(' where usuario_ci = :usuario ');
    SQL.Add(' and maquina_ci = :maquina ');
    Prepare;
  end;
  with QAltaImpresoras do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from cnf_impresoras ');
    Prepare;
  end;
  with QDatosDefecto do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from cnf_datos_por_defecto ');
    SQL.Add(' where usuario_cdd = :usuario ');
    Prepare;
  end;
  with QDirectorios do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from cnf_directorios ');
    SQL.Add(' where usuario_cd = :usuario ');
    SQL.Add(' and codigo_cd = :codigo ');
    Prepare;
  end;
  with QConfiguracion do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from cnf_conf_programa ');
    SQL.Add(' where usuario_ccp = :usuario ');
    Prepare;
  end;
end;

procedure TDMConfig.DataModuleDestroy(Sender: TObject);
begin
  QInstalacion.Close;
  if QInstalacion.Prepared then
    QInstalacion.UnPrepare;
  QUsuarios.Close;
  if QUsuarios.Prepared then
    QUsuarios.UnPrepare;
  QCuentaCorreo.Close;
  if QCuentaCorreo.Prepared then
    QCuentaCorreo.UnPrepare;
  QImpresoras.Close;
  if QImpresoras.Prepared then
    QImpresoras.UnPrepare;
  QAltaImpresoras.Close;
  if QAltaImpresoras.Prepared then
    QAltaImpresoras.UnPrepare;
  QDatosDefecto.Close;
  if QDatosDefecto.Prepared then
    QDatosDefecto.UnPrepare;
  QDirectorios.Close;
  if QDirectorios.Prepared then
    QDirectorios.UnPrepare;
  QConfiguracion.Close;
  if QConfiguracion.Prepared then
    QConfiguracion.UnPrepare;
  QAccesos.Close;
  if QAccesos.Prepared then
    QAccesos.UnPrepare;
  QLogon.Close;
  if QLogon.Prepared then
    QLogon.UnPrepare;
end;

procedure LoadIni;
var
  FileIni: TIniFile;
  i, iCount: Integer;
  sBD, sAux: string;
begin
  gsDirActual := Uppercase( ExtractFilePath(ParamStr(0)) );
  sAux:= Uppercase( ParamStr(1) );
  if sAux <> '' then
  begin
    sFileIni:= '\' + Trim(sAux) + '.INI';
    if gsDirActual[Length(gsDirActual)] = '\' then
      gsDirActual := copy( gsDirActual, 1, Length(gsDirActual) - 1);
    sFileIni:= gsDirActual + sFileIni;
  end
  else
  begin
    sFileIni:= Uppercase( ExtractFileName(ParamStr(0)));
    sFileIni:= '\' + StringReplace( sFileIni, '.EXE', '.INI', [] );
    if gsDirActual[Length(gsDirActual)] = '\' then
      gsDirActual := copy( gsDirActual, 1, Length(gsDirActual) - 1);
    sFileIni:= gsDirActual + sFileIni;
  end;

  FileIni := TIniFile.Create(sFileIni);

  //[BDGLOBAL]
  iBDCount:= FileIni.ReadInteger( 'BDGLOBAL', 'BDCOUNT', 0 );

  if iBDCount > 0 then
  begin
    iCount:= 0;
    for i:= 1 to iBDCount do
    begin
      sBD:= 'BD' + IntToStr( i );
      sAux:= FileIni.ReadString(sBD, 'DESCRIPCION', '');
      //Miramos a ver si ya existe una instancia de la aplicacion
      if FindWindow( PChar( 'GComerBAG' + sAux ), nil) = 0 then
      begin
        SetLength( arDataConexion, iBDCount + 1 );
        arDataConexion[iCount].sDescripcion:= FileIni.ReadString(sBD, 'DESCRIPCION', '');
        arDataConexion[iCount].sBDName:= FileIni.ReadString(sBD, 'BDNAME', '');
        arDataConexion[iCount].sBDServer:= FileIni.ReadString(sBD, 'BDSEVER', '');
        arDataConexion[iCount].sBDDriver:= FileIni.ReadString(sBD, 'BDDRIVER', '');
        arDataConexion[iCount].sBDUser:= FileIni.ReadString(sBD, 'USUARIO', '');
        arDataConexion[iCount].sBDPass:= FileIni.ReadString(sBD, 'CLAVE', '');
        iCount:= iCount+ 1;
      end;
    end;
    iBDCount:= iCount;
  end;

  //EJECUTAMOS EN UN TERMINAL SERVER
  gbTerminalserver:= UpperCase( FileIni.ReadString('TERMINAL_SERVER', 'TERMINAL_SERVER', 'FALSE') ) = 'TRUE';
  gbAlmacen:= UpperCase( FileIni.ReadString('BDGLOBAL', 'ALMACEN', 'NO') ) = 'SI';

  //LECTOR DE FIRMAS
  gbFirmar:= Uppercase(FileIni.ReadString('FIRMAS', 'FIRMAR', 'FALSE')) = 'TRUE';
  gsDirFirmasLocal:= FileIni.ReadString('FIRMAS', 'DIR', '');

  //Control de versiones
  giVersion:= StrToInt( FileIni.ReadString('VERSION', 'VERSION', '0'));
  if giVersion < kVersion then
    giVersion:= kVersion;

  FreeAndNil(FileIni);
end;

procedure TDMConfig.LoadConfig;
begin
  DatosUsuario;
  Impresoras;
  DatosPorDefecto;
  DatosVersion;
  DatosInstalacion;
  CargaDirectorios;
  ConfiguracionPrograma;

end;

procedure TDMConfig.Logon;
var
  dAux: TDateTime;
begin
  with QAccesos do
  begin
    Open;
    Insert;
    FieldByName('usuario_ca').AsString:= gsCodigo;
    FieldByName('maquina_ca').AsString:= gsMaquina;
    FieldByName('accion_ca').AsInteger:= 0;
    dAux:= Now;
    FieldByName('instante_ca').AsDateTime:= Now;
    try
      Post;
    except
      Cancel;
    end;
  end;
  with QLogon do
  begin
    ParamByName('usuario').AsString:= gsCodigo;
    Open;
    if not IsEmpty then
    begin
      Edit;
      FieldByName('accesos_cu').AsInteger:= FieldByName('accesos_cu').AsInteger + 1;
      FieldByName('ultimo_acceso_cu').AsDateTime:= dAux;
      try
        Post;
      except
        Cancel;
      end;
    end;
    RequestLive:= False;
  end;
end;

procedure TDMConfig.Logoff;
begin
  with QAccesos do
  begin
    Open;
    Insert;
    FieldByName('usuario_ca').AsString:= gsCodigo;
    FieldByName('maquina_ca').AsString:= gsMaquina;
    FieldByName('accion_ca').AsInteger:= 1;
    FieldByName('instante_ca').AsDateTime:= Now;
    try
      Post;
    except
      Cancel;
    end;
  end;
end;

procedure TDMConfig.DatosUsuario;
begin
  gsNombre:= '';
  gbEscritura:= true;
  gbEnlaceContable:= false;
  gsDirCorreo:=  '';

  iCuenta:= 0 ;
  with QUsuarios do
  begin
    ParamByName('usuario').AsString:= gsCodigo;
    try
      Open;
      gsNombre:= FieldByName('descripcion_cu').AsString;
      gbEscritura:= FieldByName('escritura_cu').AsInteger = 1;
      gbEnlaceContable:= FieldByName('enlace_contable_cu').AsInteger = 1;
      gsDirCorreo:=  FieldByName('correo_cu').AsString;
      iCuenta:= FieldByName('cuenta_correo_cu').AsInteger ;

      DatosCuentaCorreo;
    finally
      Close;
    end;
  end;
end;

procedure TDMConfig.DatosCuentaCorreo;
begin
  gsHostCorreo:= '';
  gsUsarioCorreo:= '';
  gsClaveCorreo:= '';

  with QCuentaCorreo do
  begin
    ParamByName('codigo').AsInteger:= iCuenta;
    try
      Open;
      if not IsEmpty then
      begin
        try
          gsDescripcionCorreo:= FieldByName('descripcion_ccc').AsString;
          gsHostCorreo:= FieldByName('smtp_ccc').AsString;
          gsCuentaCorreo:= FieldByName('cuenta_ccc').AsString;
          gsUsarioCorreo:= FieldByName('identificador_ccc').AsString;
          gsClaveCorreo:= FieldByName('clave_ccc').AsString;
        except
          //Nada
        end;
      end
      else
      begin
        Close;
        ParamByName('codigo').AsInteger:= 0;
        Open;
        gsDescripcionCorreo:= FieldByName('descripcion_ccc').AsString;
        gsHostCorreo:= FieldByName('smtp_ccc').AsString;
        gsCuentaCorreo:= FieldByName('cuenta_ccc').AsString;        
        gsUsarioCorreo:= FieldByName('identificador_ccc').AsString;
        gsClaveCorreo:= FieldByName('clave_ccc').AsString;
      end;
    finally
      Close;
    end;
  end;
end;

function IndiceImpresora( const AImpresora: string ): Integer;
var
  i: integer;
  bSalir: Boolean;
begin
  i:= 0;
  result:= -1;
  bSalir:= false;

  while ( i < Printer.Printers.Count ) and ( not bSalir ) do
  begin
    if Printer.Printers[i] = AImpresora then
    begin
      result:= i;
      bSalir:= True;
    end
    else
    begin
      Inc(i);
    end;
  end;
end;

function ImpresoraPDF: integer;
var
  i: integer;
  bSalir: Boolean;
begin
  i:= 0;
  result:= -2;
  bSalir:= false;

  while ( i < Printer.Printers.Count ) and ( not bSalir ) do
  begin
    if Pos( 'PDF', Printer.Printers[i] ) > 0 then
    begin
      if Printer.Printers[i] = 'PDFComer' then
      begin
        result:= i;
        bSalir:= True;
      end
      else
      begin
        if Result = -1 then
          result:= i;
        Inc(i);
      end;
    end
    else
    begin
      Inc(i);
    end;
  end;
end;

procedure TDMConfig.Impresoras;
var
  sAux: string;
  FileIni: TIniFile;
  sFileIni: string;
begin
  sFileIni:= ExtractFileName(ParamStr(0));
  sFileIni:= '\' + StringReplace( sFileIni, '.exe', '.ini', [] );
  sFileIni:= gsDirActual + sFileIni;

  with QImpresoras do
  begin
    ParamByName('usuario').AsString:= gsCodigo;
    ParamByName('maquina').AsString:= gsMaquina;
    try
      Open;
       if not IsEmpty then
       begin
         sAux:= FieldByName('listados_ci').AsString;
         giPrintDef:= IndiceImpresora( sAux );
         sAux:= FieldByName('pdf_ci').AsString;
         giPrintPDF:= IndiceImpresora( sAux );
       end
       else
       begin
         FileIni := TIniFile.Create(sFileIni);
         try
           giPrintDef:= FileIni.ReadInteger('IMPRESORAS', 'PORDEFECTO', -1);
           giPrintPDF:= FileIni.ReadInteger('IMPRESORAS', 'PDF', -1);
           if giPrintPDF = -1 then
             giPrintPDF:= ImpresoraPDF;
           if ( giPrintDef <> -1 ) and ( giPrintPDF <> -1 ) then
           begin
             GrabarImpresoras;
           end;
         finally
           FreeAndNil( FileIni );
         end;
       end;
    finally
      Close;
    end;
  end;

  sAux:= '';
  if giPrintDef = -1 then
  begin
    sAux:= 'Impresora para listados incorrecta.';
  end;
  if sAux <> '' then
  begin
    sAux:= sAux + #13 + #10;
    sAux:= sAux + 'Por favor, configure las impresoras en el mantenimiento correspondiente.';
    ShowMessage( sAux );
  end;
end;

procedure TDMConfig.ImpresorasSeleccionadas;
begin
  with QAltaImpresoras do
  begin
    if giPrintDef > -1 then
    begin
      if giPrintDef < Printer.Printers.Count then
        FieldByName('listados_ci').AsString:= Printer.Printers[giPrintDef]
      else
        FieldByName('listados_ci').AsString:= '';
    end
    else
    begin
      FieldByName('listados_ci').AsString:= '';
    end;

    if giPrintPDF > -1 then
    begin
      if giPrintPDF < Printer.Printers.Count then
        FieldByName('pdf_ci').AsString:= Printer.Printers[giPrintPDF]
      else
        FieldByName('listados_ci').AsString:= '';
    end
    else
    begin
      FieldByName('pdf_ci').AsString:= '';
    end;
  end;
end;

procedure TDMConfig.GrabarImpresoras;
begin
  with QAltaImpresoras do
  begin
    try
      Open;
      if Locate('usuario_ci;maquina_ci',VarArrayOf([gsCodigo,gsMaquina]),[loCaseInsensitive, loPartialKey]) then
      begin
        Edit;
        ImpresorasSeleccionadas;
        Post;
      end
      else
      begin
        Insert;
        FieldByName('usuario_ci').AsString:= gsCodigo;
        FieldByName('maquina_ci').AsString:= gsMaquina;
        ImpresorasSeleccionadas;
        Post;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TDMConfig.DatosPorDefecto;
begin
  gsDefEmpresa := '';
  gsDefCentro := '';
  gsDefProducto := '';
  gsDefCliente := '';
  with QDatosDefecto  do
  begin
    ParamByName('usuario').AsString:= gsCodigo;
    try
      Open;
      try
        gsDefEmpresa := FieldByName('empresa_cdd').AsString;
        gsDefCentro := FieldByName('centro_cdd').AsString;
        gsDefProducto := FieldByName('producto_cdd').AsString;;
        gsDefCliente := FieldByName('cliente_cdd').AsString;;
      except
        //Nada
      end;
    finally
      Close;
    end;
  end;
end;

procedure TDMConfig.DatosVersion;
var
  sFileIni: string;
  slAux: TStringList;
begin
  sFileIni:= ExtractFileName(ParamStr(0));
  sFileIni:= '\' + StringReplace( sFileIni, '.exe', '.ver', [] );
  sFileIni:= gsDirActual + sFileIni;
  if FileExists(sFileIni) then
  begin
    slAux:= TStringList.Create;
    try
      slAux.LoadFromFile( sFileINi );
      gsAplicVersion:= 'V' + Trim( slAux.Text );
    finally
      FreeAndNil( slAux );
    end;
  end;
end;

procedure TDMConfig.DatosInstalacion;
begin
  sEmpresaInstalacion:= '078';
  sCentroInstalacion:= '1';
  sDesInstalacion:= 'BONDELICIOUS ALZIRA';
  iInstalacion:= 51;
  iCodigoBD:= 1;

  with QInstalacion do
  begin
    Open;
    try
      try
        sEmpresaInstalacion:= FieldByName('empresa_ci').AsString;
        sCentroInstalacion:= FieldByName('centro_ci').AsString;
        sDesInstalacion:= FieldByName('descripcion_ci').AsString;
        iInstalacion:= FieldByName('codigo_ci').AsInteger;
        iCodigoBD:= FieldByName('codigo_bd_ci').AsInteger;
      except
        //
      end;
    finally
      Close;
    end;
  end;
end;

procedure TDMConfig.CargaDirectorios;
begin
  gsDirEdi:= '';
  //Directorio Facturacion EDI
  with QDirectorios do
  begin
    ParamByName('usuario').AsString:= gsCodigo;
    ParamByName('codigo').AsString:= 'EDI';
    Open;
    try
      try
        gsDirEdi := FieldByName('directorio_cd').AsString;
        if gsDirEdi = '' then
        begin
          Close;
          ParamByName('usuario').AsString:= 'all';
          ParamByName('codigo').AsString:= 'EDI';
          Open;
          gsDirEdi := FieldByName('directorio_cd').AsString;
        end;
      except
        gsDirEdi := '';
      end;
    finally
      Close;
    end;
  end;

  gsDirFirmasGlobal:= '';
  //Directorio firmas transportistas
  with QDirectorios do
  begin
    if gsDirFirmasLocal = '' then
    begin
      ParamByName('usuario').AsString:= gsCodigo;
      ParamByName('codigo').AsString:= 'firmas';
      Open;
      gsDirFirmasLocal:= FieldByName('directorio_cd').AsString;
      Close;
    end;

    ParamByName('usuario').AsString:= 'all';
    ParamByName('codigo').AsString:= 'firmas';
    Open;
    gsDirFirmasGlobal := FieldByName('directorio_cd').AsString;
    Close;

    if gsDirFirmasGlobal = '' then
    begin
      if gsDirFirmasLocal = '' then
      begin
        gsDirFirmasLocal:= gsDirActual + '\temp';
      end;
    end;
  end;
end;

procedure TDMConfig.ConfiguracionPrograma;
begin
  bBarraAplicaciones := False;
  with QConfiguracion do
  begin
    ParamByName('usuario').AsString:= gsCodigo;
    Open;
    try
      try
        bBarraAplicaciones := ( FieldByName('barra_aplic_ccp').AsInteger <> 0 );
      except

      end;
    finally
      Close;
    end;
  end;
end;

function TDMConfig.EsLaFont: boolean;
begin
  (*TODO*)
  result:= iInstalacion = 10;
  if result then
  begin
    result:= not ( ( UPPERCASE( copy( gsCodigo, 1, 3 ) )  = 'LLA' ) or
                   ( UPPERCASE( gsCodigo )  = 'CENTRAL1' ) or
                   ( UPPERCASE( gsCodigo ) = 'ALC007' ) );
  end;
end;

function TDMConfig.EsLaFontEx: boolean;
begin
  (*TODO*)
  result:= iInstalacion = 10;
  if result then
  begin
    result:= not ( ( UPPERCASE( copy( gsCodigo, 1, 3 ) )  = 'LLA' ) or
                   ( UPPERCASE( gsCodigo )  = 'CENTRAL1' ) or
                   ( UPPERCASE( gsCodigo ) = 'ALC007' ) );
    if not result then
    begin
      result:= ( UPPERCASE( gsCodigo )  = 'LLANOS7' ) or
               ( UPPERCASE( gsCodigo )  = 'LLANOS1' ) or
               ( UPPERCASE( gsCodigo )  = 'LLACIM' ) or
               ( UPPERCASE( gsCodigo )  = 'LLA005' ) or
               ( UPPERCASE( gsCodigo )  = 'LLA012' ) OR
               ( UPPERCASE( gsCodigo )  = 'TFE001' ) OR
               ( UPPERCASE( gsCodigo )  = 'TFE017' ); //eCHANDI
    end;
  end;
end;

function TDMConfig.EsUnAlmacen: boolean;
begin
  result:= iInstalacion <> 10;
end;

function TDMConfig.EsValencia: boolean;
begin
  result:= (iInstalacion = 50);
end;

function TDMConfig.EsTenerife: boolean;
begin
  result:= (iInstalacion = 51);
end;

function TDMConfig.EsLasMoradas: boolean;
begin
    result:= iInstalacion = 21;
end;

function TDMConfig.EsSevilla: boolean;
begin
  result:= (iInstalacion = 33);
end;

function TDMConfig.EsFrutibon: boolean;
begin
  result:= (iInstalacion = 40);
end;

function TDMConfig.EsChanita: boolean;
begin
  result:= (iInstalacion = 30);
end;

function TDMConfig.EsMaset: boolean;
begin
  result:= EsValencia or EsTenerife or EsChanita or EsSevilla;
end;

function TDMConfig.EsLOsLlanos: boolean;
begin
  Result:= False;
end;



function TDMConfig.CodigoBD: integer;
begin
  (*QUEPAIXA*)
  result:= iCodigoBD;
end;

function TDMConfig.PuedoTransferir: boolean;
begin
  with QAux do
  begin
    SQL.Clear;
    SQL.Add('select nvl(transferir_mt,0) transferir_mt from mnu_transferir ');
    Open;
    result:= FieldByName( 'transferir_mt' ).AsInteger > 0;
    Close;
  end;
end;

function TDMConfig.PuedoTransferirOpcion( const AOpcion: string ): boolean;
var
  sField: string;
begin
  with QAux do
  begin
    sField:= AOpcion + '_mt';
    SQL.Clear;
    SQL.Add('select nvl(' + sField + ', 0) ' + sField + ' from mnu_transferir ');
    Open;
    //0 nada
    //1 enviar
    //2 recibir
    //3 ambos
    result:= ( FieldByName( sField ).AsInteger = 1 ) or
             ( FieldByName( sField ).AsInteger = 3 );

    Close;
  end;
end;

initialization

finalization
  SetLength( arDataConexion , 0 );

end.



