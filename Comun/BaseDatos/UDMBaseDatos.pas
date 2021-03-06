unit UDMBaseDatos;

interface

uses
  SysUtils, Classes, DB, DBTables, ImgList, Controls, ADODB, cxGraphics;

type
  TDMBaseDatos = class(TDataModule)
    ImgBarraHerramientas: TImageList;
    ImgBotones: TImageList;
    DBBaseDatos: TDatabase;
    dbMaster: TDatabase;
    BDCentral: TDatabase;
    DBSGP: TDatabase;
    QGeneral: TQuery;
    DSQGeneral: TDataSource;
    QDespegables: TQuery;
    DSQDespegables: TDataSource;
    QListado: TQuery;
    DSListado: TDataSource;
    QAux: TQuery;
    QTemp: TQuery;
    QMaestro: TQuery;
    DSMaestro: TDataSource;
    QModificable: TQuery;
    QDetalle: TQuery;
    dbLlanos: TDatabase;
    dbMoradas: TDatabase;
    dbF17: TDatabase;
    dbF23: TDatabase;
    dbF24_old: TDatabase;
    dbF18: TDatabase;
    dbRf: TDatabase;
    qryCabecera: TQuery;
    dbSAT: TDatabase;
    dbBAG: TDatabase;
    qryDetalle: TQuery;
    conX3: TADOConnection;
    ImgDev: TcxImageList;
    IFacturas: TcxImageList;
    dbChanita: TDatabase;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CerrarConexionCentral;
    function  AbrirConexionCentral: Boolean;

    function  GetPermiso( const AUser, APermiso: string ): integer;
  end;

var
  DMBaseDatos : TDMBaseDatos;
  bDebug: Boolean = True;

function AbrirBaseDatos: Boolean;

procedure bnCloseQuery(AQuery: TDataSet);
procedure bnCloseQuerys(AQuerys: array of TDataSet);
procedure CloseAuxQuerys;

implementation

{$R *.dfm}

uses
  UDMConfig, CVariables, Forms, CGlobal, UDMAuxDB, 
  UDFactura, DPassword, Dialogs, DError, Windows, Nb30, WinSock, UDMMaster,
  UDMCalculoPosei;

procedure TDMBaseDatos.DataModuleCreate(Sender: TObject);
begin
  DBBaseDatos.Connected:= False;
  DBMaster.Connected:= False;
  BDCentral.Connected:= False;
  DBSGP.Connected:= False;
end;

function GetComputerNetName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;


function GetDireccionIP: string;
 Type
     // Estructura que une el estado del adaptador de red
     // con una matriz de estructuras TNameBuffer
    ASTAT = record
       adapt: TAdapterStatus;
       NameBuff: Array[0..29] Of TNameBuffer;
  end;
Var
    Nombre: String;
    DatosSocket: WSAData;
    BloqueIP: PHostEnt;
    DirIP: in_addr;
begin
    WSAStartup($0101, DatosSocket);  //Inicializamos Windows sockets
    SetLength(Nombre, MAX_PATH);  //obtenemos el nombre de nuestro equipo
    gethostname(PChar(Nombre), MAX_PATH);
     //Usamos el nombre del equipo para obtener un bloque de informaci?n sobre IP
    BloqueIP := gethostbyname(PChar(Nombre));
    //Recuperamos la direcci?n IP del bloque
    CopyMemory(@DirIP, (BloqueIP^).h_addr_list^, BloqueIP.h_length);

    result:= inet_ntoa(DirIP);
end;


procedure UserBD( var VUser, VPass: string );
begin
  if UpperCase( arDataConexion[ iBDDataConexion ].sBDServer ) = 'LLANOS1' then
  begin
    VUser:='informix';
    VPass:='unix1q2w';
  end
  else
  if ( UpperCase( arDataConexion[ iBDDataConexion ].sBDServer ) = 'IDS_FTI1' ) then
  begin
    VUser:='informix';
    VPass:='Unix1q2w';
  end
  else
  (*
  if ( UpperCase( arDataConexion[ iBDDataConexion ].sBDServer ) = 'ISERVER1' ) or
     ( UpperCase( arDataConexion[ iBDDataConexion ].sBDServer ) = 'ISERVER2' ) or
     ( UpperCase( arDataConexion[ iBDDataConexion ].sBDServer ) = 'ISERVER6' ) or
     ( UpperCase( arDataConexion[ iBDDataConexion ].sBDServer ) = 'ISERVER15' ) or
     ( UpperCase( arDataConexion[ iBDDataConexion ].sBDServer ) = 'ISERVER13' ) then
  *)
  begin
    VUser:='informix';
    VPass:='informix';
  end
  (*
  else
  begin
    VUser:=gsCodigo;
    VPass:= gsPassword;
  end;
  *)
end;

function ValidateUser: boolean;
var
  sPass: string;
  iAccesos: Integer;
begin
  result:= False;
  //La clave debe de tener como minimo 6 caracteres
  if Length( gsPassword ) < 4 then
  begin
     ShowMessage('La clave del usuario "' + gsCodigo + '" debe de tener como minimo 4 caracteres.' + #13 + #10 +
                    'Por favor intentelo de nuevo.' );
  end
  else
  begin
    //Comprobar que el usuario este dado de alta en el sistema
    DMBaseDatos.QGeneral.SQL.Clear;
    //DMBaseDatos.QGeneral.SQL.Add( ' select * from cnf_claves where usuario_cc = :usuario' );
    DMBaseDatos.QGeneral.SQL.Add( ' select * from cnf_usuarios where usuario_cu = :usuario' );
    DMBaseDatos.QGeneral.ParamByName('usuario').AsString:= gsCodigo;
    try
      DMBaseDatos.QGeneral.Open;
      //sPass:= DMBaseDatos.QGeneral.fieldByname('clave_cc').AsString;
      //iAccesos:= DMBaseDatos.QGeneral.fieldByname('accesos_cc').AsInteger;
      sPass:= DMBaseDatos.QGeneral.fieldByname('clave_cu').AsString;
      iAccesos:= DMBaseDatos.QGeneral.fieldByname('accesos_cu').AsInteger;

      if DMBaseDatos.QGeneral.IsEmpty then
      begin
        ShowMessage('La conexi?n ha sido realizada con ?xito, ' +
                'pero el usuario "' + gsCodigo + '" no esta dado de alta en el sistema.' + #13 + #10 +
                'Por favor pongase en contacto con el departamento de informatica.' );
      end
      else
      begin
        if ( Length( sPass ) >= 4 ) and ( sPass <> gsPassword ) then
        begin
          ShowMessage('La clave del usuario "' + gsCodigo + '" es incorrecta.' + #13 + #10 +
                    'Por favor intentelo de nuevo.' );

        end
        else
        begin
          DMBaseDatos.QGeneral.Close;
          DMBaseDatos.QGeneral.SQL.Clear;
          DMBaseDatos.QGeneral.SQL.Add( ' update cnf_usuarios set clave_cu = :pass, accesos_cu = :accesos where usuario_cu = :usuario' );
          //DMBaseDatos.QGeneral.SQL.Add( ' update cnf_claves set clave_cc = :pass, accesos_cc = :accesos where usuario_cc = :usuario' );
          DMBaseDatos.QGeneral.ParamByName('usuario').AsString:= gsCodigo;
          DMBaseDatos.QGeneral.ParamByName('pass').AsString:= gsPassword;
          DMBaseDatos.QGeneral.ParamByName('accesos').AsInteger:= iAccesos + 1;
          DMBaseDatos.QGeneral.ExecSQL;
          result:= True;
        end;
      end;
    finally
      DMBaseDatos.QGeneral.Close;
    end;
  end;
end;


procedure ConfifBaseDatosAux;
begin
  //BD Remota
  DMBaseDatos.BDCentral.Params.Clear;
  DMBaseDatos.BDCentral.DatabaseName:= 'BDCentral';
  DMBaseDatos.BDCentral.AliasName:= '';
  DMBaseDatos.BDCentral.DriverName:= 'INFORMIX';

  DMBaseDatos.BDCentral.Params.Add('SERVER NAME=iserver1');
//  DMBaseDatos.BDCentral.Params.Add('SERVER NAME=server3');
  if gProgramVersion = pvBag then
    DMBaseDatos.BDCentral.Params.Add('DATABASE NAME=comerbag' )
  else
    DMBaseDatos.BDCentral.Params.Add('DATABASE NAME=comersat' );
  DMBaseDatos.BDCentral.Params.Add('USER NAME=informix');
  DMBaseDatos.BDCentral.Params.Add('OPEN MODE=READ/WRITE');
  DMBaseDatos.BDCentral.Params.Add('SCHEMA CACHE SIZE=8');
  DMBaseDatos.BDCentral.Params.Add('LANGDRIVER=DB850ES0');
  DMBaseDatos.BDCentral.Params.Add('SQLQRYMODE=SERVER');
  DMBaseDatos.BDCentral.Params.Add('SQLPASSTHRU MODE=SHARED AUTOCOMMIT');
  DMBaseDatos.BDCentral.Params.Add('LOCK MODE=5');
  DMBaseDatos.BDCentral.Params.Add('DATE MODE=1');
  DMBaseDatos.BDCentral.Params.Add('DATE SEPARATOR=/');
  DMBaseDatos.BDCentral.Params.Add('SCHEMA CACHE TIME=-1');
  DMBaseDatos.BDCentral.Params.Add('MAX ROWS=-1');
  DMBaseDatos.BDCentral.Params.Add('BATCH COUNT=200');
  DMBaseDatos.BDCentral.Params.Add('ENABLE SCHEMA CACHE=FALSE');
  DMBaseDatos.BDCentral.Params.Add('SCHEMA CACHE DIR=');
  DMBaseDatos.BDCentral.Params.Add('ENABLE BCD=FALSE');
  DMBaseDatos.BDCentral.Params.Add('LIST SYNONYMS=NONE');
  DMBaseDatos.BDCentral.Params.Add('DBNLS=');
  DMBaseDatos.BDCentral.Params.Add('COLLCHAR=');
  DMBaseDatos.BDCentral.Params.Add('BLOBS TO CACHE=64');
  DMBaseDatos.BDCentral.Params.Add('BLOB SIZE=32');
  DMBaseDatos.BDCentral.Params.Add('PASSWORD=informix');

  //BD Sistema gestion de planta
  //DMBaseDatos.DBSGP.Params.Clear;
  //DMBaseDatos.DBSGP.DatabaseName:= 'DBSGP';
  //DMBaseDatos.DBSGP.AliasName:= 'sgp_bonnysa_host';
  //DMBaseDatos.DBSGP.DriverName:= '';
  //DMBaseDatos.DBSGP.Params.Add('DATABASE NAME=sgp_bonnysa_host' );
  //DMBaseDatos.DBSGP.Params.Add('USER NAME=pepe' );
  //DMBaseDatos.DBSGP.Params.Add('ODBC DSN=sgp_bonnysa_host' );
  //DMBaseDatos.DBSGP.Params.Add('OPEN MODE=READ/WRITE' );
  //DMBaseDatos.DBSGP.Params.Add('SCHEMA CACHE SIZE=8' );
  //DMBaseDatos.DBSGP.Params.Add('SQLQRYMODE=' );
  //DMBaseDatos.DBSGP.Params.Add('LANGDRIVER=' );
  //DMBaseDatos.DBSGP.Params.Add('SQLPASSTHRU MODE=SHARED AUTOCOMMIT' );
  //DMBaseDatos.DBSGP.Params.Add('SCHEMA CACHE TIME=-1' );
  //DMBaseDatos.DBSGP.Params.Add('MAX ROWS=-1' );
  //DMBaseDatos.DBSGP.Params.Add('BATCH COUNT=200' );
  //DMBaseDatos.DBSGP.Params.Add('ENABLE SCHEMA CACHE=FALSE' );
  //DMBaseDatos.DBSGP.Params.Add('SCHEMA CACHE DIR=' );
  //DMBaseDatos.DBSGP.Params.Add('ENABLE BCD=FALSE' );
  //DMBaseDatos.DBSGP.Params.Add('ROWSET SIZE=20' );
  //DMBaseDatos.DBSGP.Params.Add('BLOBS TO CACHE=64' );
  //DMBaseDatos.DBSGP.Params.Add('PASSWORD=pepe' );

  //BD Los Llanos
  DMBaseDatos.dbLlanos.Params.Clear;
  DMBaseDatos.dbLlanos.DatabaseName:= 'dbLlanos';
  DMBaseDatos.dbLlanos.AliasName:= '';
  DMBaseDatos.dbLlanos.DriverName:= 'INFORMIX';
  DMBaseDatos.dbLlanos.Params.Add('SERVER NAME=iserver5');
  DMBaseDatos.dbLlanos.Params.Add('DATABASE NAME=comersat' );
//  DMBaseDatos.dbLlanos.Params.Add('SERVER NAME=server3');
//  DMBaseDatos.dbLlanos.Params.Add('DATABASE NAME=satllanos' );
  DMBaseDatos.dbLlanos.Params.Add('USER NAME=informix');
  DMBaseDatos.dbLlanos.Params.Add('OPEN MODE=READ/WRITE');
  DMBaseDatos.dbLlanos.Params.Add('SCHEMA CACHE SIZE=8');
  DMBaseDatos.dbLlanos.Params.Add('LANGDRIVER=DB850ES0');
  DMBaseDatos.dbLlanos.Params.Add('SQLQRYMODE=SERVER');
  DMBaseDatos.dbLlanos.Params.Add('SQLPASSTHRU MODE=SHARED AUTOCOMMIT');
  DMBaseDatos.dbLlanos.Params.Add('LOCK MODE=5');
  DMBaseDatos.dbLlanos.Params.Add('DATE MODE=1');
  DMBaseDatos.dbLlanos.Params.Add('DATE SEPARATOR=/');
  DMBaseDatos.dbLlanos.Params.Add('SCHEMA CACHE TIME=-1');
  DMBaseDatos.dbLlanos.Params.Add('MAX ROWS=-1');
  DMBaseDatos.dbLlanos.Params.Add('BATCH COUNT=200');
  DMBaseDatos.dbLlanos.Params.Add('ENABLE SCHEMA CACHE=FALSE');
  DMBaseDatos.dbLlanos.Params.Add('SCHEMA CACHE DIR=');
  DMBaseDatos.dbLlanos.Params.Add('ENABLE BCD=FALSE');
  DMBaseDatos.dbLlanos.Params.Add('LIST SYNONYMS=NONE');
  DMBaseDatos.dbLlanos.Params.Add('DBNLS=');
  DMBaseDatos.dbLlanos.Params.Add('COLLCHAR=');
  DMBaseDatos.dbLlanos.Params.Add('BLOBS TO CACHE=64');
  DMBaseDatos.dbLlanos.Params.Add('BLOB SIZE=32');
  DMBaseDatos.dbLlanos.Params.Add('PASSWORD=informix');

  //BD Las Moradas
  DMBaseDatos.dbMoradas.Params.Clear;
  DMBaseDatos.dbMoradas.DatabaseName:= 'dbMoradas';
  DMBaseDatos.dbMoradas.AliasName:= '';
  DMBaseDatos.dbMoradas.DriverName:= 'INFORMIX';
  DMBaseDatos.dbMoradas.Params.Add('SERVER NAME=iserver2');
  DMBaseDatos.dbMoradas.Params.Add('DATABASE NAME=sattfe' );
  DMBaseDatos.dbMoradas.Params.Add('USER NAME=informix');
  DMBaseDatos.dbMoradas.Params.Add('OPEN MODE=READ/WRITE');
  DMBaseDatos.dbMoradas.Params.Add('SCHEMA CACHE SIZE=8');
  DMBaseDatos.dbMoradas.Params.Add('LANGDRIVER=DB850ES0');
  DMBaseDatos.dbMoradas.Params.Add('SQLQRYMODE=SERVER');
  DMBaseDatos.dbMoradas.Params.Add('SQLPASSTHRU MODE=SHARED AUTOCOMMIT');
  DMBaseDatos.dbMoradas.Params.Add('LOCK MODE=5');
  DMBaseDatos.dbMoradas.Params.Add('DATE MODE=1');
  DMBaseDatos.dbMoradas.Params.Add('DATE SEPARATOR=/');
  DMBaseDatos.dbMoradas.Params.Add('SCHEMA CACHE TIME=-1');
  DMBaseDatos.dbMoradas.Params.Add('MAX ROWS=-1');
  DMBaseDatos.dbMoradas.Params.Add('BATCH COUNT=200');
  DMBaseDatos.dbMoradas.Params.Add('ENABLE SCHEMA CACHE=FALSE');
  DMBaseDatos.dbMoradas.Params.Add('SCHEMA CACHE DIR=');
  DMBaseDatos.dbMoradas.Params.Add('ENABLE BCD=FALSE');
  DMBaseDatos.dbMoradas.Params.Add('LIST SYNONYMS=NONE');
  DMBaseDatos.dbMoradas.Params.Add('DBNLS=');
  DMBaseDatos.dbMoradas.Params.Add('COLLCHAR=');
  DMBaseDatos.dbMoradas.Params.Add('BLOBS TO CACHE=64');
  DMBaseDatos.dbMoradas.Params.Add('BLOB SIZE=32');
  DMBaseDatos.dbMoradas.Params.Add('PASSWORD=informix');

  //BD Chanita
  DMBaseDatos.dbChanita.Params.Clear;
  DMBaseDatos.dbChanita.DatabaseName:= 'dbChanita';
  DMBaseDatos.dbChanita.AliasName:= '';
  DMBaseDatos.dbChanita.DriverName:= 'INFORMIX';
  DMBaseDatos.dbChanita.Params.Add('SERVER NAME=iserver6');
  DMBaseDatos.dbChanita.Params.Add('DATABASE NAME=chanita' );
  DMBaseDatos.dbChanita.Params.Add('USER NAME=informix');
  DMBaseDatos.dbChanita.Params.Add('OPEN MODE=READ/WRITE');
  DMBaseDatos.dbChanita.Params.Add('SCHEMA CACHE SIZE=8');
  DMBaseDatos.dbChanita.Params.Add('LANGDRIVER=DB850ES0');
  DMBaseDatos.dbChanita.Params.Add('SQLQRYMODE=SERVER');
  DMBaseDatos.dbChanita.Params.Add('SQLPASSTHRU MODE=SHARED AUTOCOMMIT');
  DMBaseDatos.dbChanita.Params.Add('LOCK MODE=5');
  DMBaseDatos.dbChanita.Params.Add('DATE MODE=1');
  DMBaseDatos.dbChanita.Params.Add('DATE SEPARATOR=/');
  DMBaseDatos.dbChanita.Params.Add('SCHEMA CACHE TIME=-1');
  DMBaseDatos.dbChanita.Params.Add('MAX ROWS=-1');
  DMBaseDatos.dbChanita.Params.Add('BATCH COUNT=200');
  DMBaseDatos.dbChanita.Params.Add('ENABLE SCHEMA CACHE=FALSE');
  DMBaseDatos.dbChanita.Params.Add('SCHEMA CACHE DIR=');
  DMBaseDatos.dbChanita.Params.Add('ENABLE BCD=FALSE');
  DMBaseDatos.dbChanita.Params.Add('LIST SYNONYMS=NONE');
  DMBaseDatos.dbChanita.Params.Add('DBNLS=');
  DMBaseDatos.dbChanita.Params.Add('COLLCHAR=');
  DMBaseDatos.dbChanita.Params.Add('BLOBS TO CACHE=64');
  DMBaseDatos.dbChanita.Params.Add('BLOB SIZE=32');
  DMBaseDatos.dbChanita.Params.Add('PASSWORD=informix');

  //Chanita
  DMBaseDatos.dbF17.Params.Clear;
  DMBaseDatos.dbF17.DatabaseName:= 'dbF17';
  DMBaseDatos.dbF17.AliasName:= '';
  DMBaseDatos.dbF17.DriverName:= 'INFORMIX';
  DMBaseDatos.dbF17.Params.Add('SERVER NAME=iserver6');
  DMBaseDatos.dbF17.Params.Add('DATABASE NAME=chanita' );
  DMBaseDatos.dbF17.Params.Add('USER NAME=informix');
  DMBaseDatos.dbF17.Params.Add('OPEN MODE=READ/WRITE');
  DMBaseDatos.dbF17.Params.Add('SCHEMA CACHE SIZE=8');
  //DMBaseDatos.dbF17.Params.Add('LANGDRIVER=DB850ES0');
  DMBaseDatos.dbF17.Params.Add('LANGDRIVER=');
  DMBaseDatos.dbF17.Params.Add('SQLQRYMODE=SERVER');
  DMBaseDatos.dbF17.Params.Add('SQLPASSTHRU MODE=SHARED AUTOCOMMIT');
  DMBaseDatos.dbF17.Params.Add('LOCK MODE=5');
  DMBaseDatos.dbF17.Params.Add('DATE MODE=1');
  DMBaseDatos.dbF17.Params.Add('DATE SEPARATOR=/');
  DMBaseDatos.dbF17.Params.Add('SCHEMA CACHE TIME=-1');
  DMBaseDatos.dbF17.Params.Add('MAX ROWS=-1');
  DMBaseDatos.dbF17.Params.Add('BATCH COUNT=200');
  DMBaseDatos.dbF17.Params.Add('ENABLE SCHEMA CACHE=FALSE');
  DMBaseDatos.dbF17.Params.Add('SCHEMA CACHE DIR=');
  DMBaseDatos.dbF17.Params.Add('ENABLE BCD=FALSE');
  DMBaseDatos.dbF17.Params.Add('LIST SYNONYMS=NONE');
  DMBaseDatos.dbF17.Params.Add('DBNLS=');
  DMBaseDatos.dbF17.Params.Add('COLLCHAR=');
  DMBaseDatos.dbF17.Params.Add('BLOBS TO CACHE=64');
  DMBaseDatos.dbF17.Params.Add('BLOB SIZE=32');
  DMBaseDatos.dbF17.Params.Add('PASSWORD=informix');

  //P4h
  DMBaseDatos.dbF18.Params.Clear;
  DMBaseDatos.dbF18.DatabaseName:= 'dbF18';
  DMBaseDatos.dbF18.AliasName:= '';
  DMBaseDatos.dbF18.DriverName:= 'INFORMIX';
  DMBaseDatos.dbF18.Params.Add('SERVER NAME=iserver8');
  DMBaseDatos.dbF18.Params.Add('DATABASE NAME=comer' );
  DMBaseDatos.dbF18.Params.Add('USER NAME=informix');
  DMBaseDatos.dbF18.Params.Add('OPEN MODE=READ/WRITE');
  DMBaseDatos.dbF18.Params.Add('SCHEMA CACHE SIZE=8');
  DMBaseDatos.dbF18.Params.Add('LANGDRIVER=DB850ES0');
  DMBaseDatos.dbF18.Params.Add('SQLQRYMODE=SERVER');
  DMBaseDatos.dbF18.Params.Add('SQLPASSTHRU MODE=SHARED AUTOCOMMIT');
  DMBaseDatos.dbF18.Params.Add('LOCK MODE=5');
  DMBaseDatos.dbF18.Params.Add('DATE MODE=1');
  DMBaseDatos.dbF18.Params.Add('DATE SEPARATOR=/');
  DMBaseDatos.dbF18.Params.Add('SCHEMA CACHE TIME=-1');
  DMBaseDatos.dbF18.Params.Add('MAX ROWS=-1');
  DMBaseDatos.dbF18.Params.Add('BATCH COUNT=200');
  DMBaseDatos.dbF18.Params.Add('ENABLE SCHEMA CACHE=FALSE');
  DMBaseDatos.dbF18.Params.Add('SCHEMA CACHE DIR=');
  DMBaseDatos.dbF18.Params.Add('ENABLE BCD=FALSE');
  DMBaseDatos.dbF18.Params.Add('LIST SYNONYMS=NONE');
  DMBaseDatos.dbF18.Params.Add('DBNLS=');
  DMBaseDatos.dbF18.Params.Add('COLLCHAR=');
  DMBaseDatos.dbF18.Params.Add('BLOBS TO CACHE=64');
  DMBaseDatos.dbF18.Params.Add('BLOB SIZE=32');
  DMBaseDatos.dbF18.Params.Add('PASSWORD=informix');

  //Tenerife
  DMBaseDatos.dbF23.Params.Clear;
  DMBaseDatos.dbF23.DatabaseName:= 'dbF23';
  DMBaseDatos.dbF23.AliasName:= '';
  DMBaseDatos.dbF23.DriverName:= 'INFORMIX';
  DMBaseDatos.dbF23.Params.Add('SERVER NAME=iserver2');
  DMBaseDatos.dbF23.Params.Add('DATABASE NAME=bagtfe' );
  DMBaseDatos.dbF23.Params.Add('USER NAME=informix');
  DMBaseDatos.dbF23.Params.Add('OPEN MODE=READ/WRITE');
  DMBaseDatos.dbF23.Params.Add('SCHEMA CACHE SIZE=8');
  DMBaseDatos.dbF23.Params.Add('LANGDRIVER=DB850ES0');
  DMBaseDatos.dbF23.Params.Add('SQLQRYMODE=SERVER');
  DMBaseDatos.dbF23.Params.Add('SQLPASSTHRU MODE=SHARED AUTOCOMMIT');
  DMBaseDatos.dbF23.Params.Add('LOCK MODE=5');
  DMBaseDatos.dbF23.Params.Add('DATE MODE=1');
  DMBaseDatos.dbF23.Params.Add('DATE SEPARATOR=/');
  DMBaseDatos.dbF23.Params.Add('SCHEMA CACHE TIME=-1');
  DMBaseDatos.dbF23.Params.Add('MAX ROWS=-1');
  DMBaseDatos.dbF23.Params.Add('BATCH COUNT=200');
  DMBaseDatos.dbF23.Params.Add('ENABLE SCHEMA CACHE=FALSE');
  DMBaseDatos.dbF23.Params.Add('SCHEMA CACHE DIR=');
  DMBaseDatos.dbF23.Params.Add('ENABLE BCD=FALSE');
  DMBaseDatos.dbF23.Params.Add('LIST SYNONYMS=NONE');
  DMBaseDatos.dbF23.Params.Add('DBNLS=');
  DMBaseDatos.dbF23.Params.Add('COLLCHAR=');
  DMBaseDatos.dbF23.Params.Add('BLOBS TO CACHE=64');
  DMBaseDatos.dbF23.Params.Add('BLOB SIZE=32');
  DMBaseDatos.dbF23.Params.Add('PASSWORD=informix');


end;

procedure CrearModulosNecesarios;
begin
  DMAuxDB := TDMAuxDB.Create(Application);
  DMMaster:= TDMMaster.Create(Application);
  DMConfig:= TDMConfig.Create(Application);
  DMConfig.LoadConfig;
  DFactura := TDFactura.Create(Application);
  DMCalculoPosei := TDMCalculoPosei.Create(Application);
end;

function ConnectBDComercial( const AUser, APass: string ): Boolean;
begin
  if DMBaseDatos.DBBaseDatos.Connected then
    DMBaseDatos.DBBaseDatos.Close;
  if DMBaseDatos.DBMaster.Connected then
    DMBaseDatos.DBMaster.Close;

  result:= False;
  try
    DMBaseDatos.DBBaseDatos.Params.Clear;
    DMBaseDatos.DBBaseDatos.Params.Add('SERVER NAME=' + arDataConexion[ iBDDataConexion ].sBDServer );
    DMBaseDatos.DBBaseDatos.Params.Add('DATABASE NAME=' + arDataConexion[ iBDDataConexion ].sBDName );
    DMBaseDatos.DBBaseDatos.Params.Add('LANGDRIVER=' + arDataConexion[ iBDDataConexion ].sBDDriver );
    DMBaseDatos.DBBaseDatos.Params.Add('USER NAME=' + AUser  );
    DMBaseDatos.DBBaseDatos.Params.Add('PASSWORD=' + APass );
    DMBaseDatos.DBBaseDatos.Params.Add('BLOBS TO CACHE=65000' );

    DMBaseDatos.DBBaseDatos.Open;

    try
      DMBaseDatos.DBMaster.Params.Clear;
      DMBaseDatos.DBMaster.Params.Add('SERVER NAME=' + arDataConexion[ iBDDataConexion ].sBDServer );
      DMBaseDatos.DBMaster.Params.Add('DATABASE NAME=comermaster' );
      DMBaseDatos.DBMaster.Params.Add('LANGDRIVER=' + arDataConexion[ iBDDataConexion ].sBDDriver );
      DMBaseDatos.dbMaster.Params.Add('USER NAME=' + AUser);
      DMBaseDatos.dbMaster.Params.Add('PASSWORD=' + APass  );
      DMBaseDatos.dbMaster.Params.Add('BLOBS TO CACHE=65000' );

      DMBaseDatos.DBMaster.Open;
      result:= True;
    except
      on e: Exception do
      begin
        DMBaseDatos.DBBaseDatos.Close;
        if bDebug then
        begin
          ShowMessage( e.Message + kNewLine + DMBaseDatos.dbMaster.Params.Text )
        end
        else
        begin
          ShowMessage('Error al conectar con la Base de Datos (Master).' +
                        kNewLine + 'Por favor, intente de nuevo la conexi?n.');
        end;
      end;
    end;

  except
    on e: Exception do
    begin
      if bDebug then
      begin
        ShowMessage( e.Message + kNewLine + DMBaseDatos.DBBaseDatos.Params.Text )
      end
      else
      begin
        ShowMessage('Error al conectar con la Base de Datos (Comercial).' +
                      kNewLine + 'Por favor, intente de nuevo la conexi?n.');
      end;
    end;
  end;
end;


procedure CerrarBasesDeDatos;
begin
  DMBaseDatos.DBBaseDatos.Connected:= False;
  DMBaseDatos.DBMaster.Connected:= False;
  DMBaseDatos.BDCentral.Connected:= False;
  DMBaseDatos.DBSGP.Connected:= False;
end;

function AbrirBaseDatos: Boolean;
var
  sUserAux, sPassAux: string;
  FDPassword: TFDPassword;
  bFlag: boolean;
  iAux: Integer;
begin
  LoadIni;
  if iBDCount > 0 then
  begin
    DMBaseDatos := TDMBaseDatos.Create(Application);
    CerrarBasesDeDatos;

    bFlag:= true;
    iAux:= -1;
    FDPassword:= TFDPassword.Create(Application);
    try
      while bFlag do
      begin                                                    
        if FDPassword.ShowModal = mrOk then
        begin
          gsCodigo := FDPassword.EUsuario.Text;
          gsPassword := FDPassword.EClave.Text;
          iBDDataConexion:= FDPassword.cbAlias.ItemIndex;
          UserBD( sUserAux, sPassAux );
          if ( iAux = iBDDataConexion )  or ConnectBDComercial( sUserAux, sPassAux ) then
          begin
            iAux:= iBDDataConexion;

            //Una vez abierta la BD comprobamos que el usuario sea valido
            if ValidateUser then
            begin
              try
                gsMaquina:= GetComputerNetName;
                gsDirIP:= GetDireccionIP;
                ConfifBaseDatosAux;
                CrearModulosNecesarios;
                Result:=  True;
                bFlag:= False;
              except
                bFlag:= False;
                ShowMessage('Error al inicializar el programa.' +
                        kNewLine + 'Por favor, intente de nuevo la conexi?n.');

              end;
            end;

          end;
        end
        else
        begin
          bFlag:= False;
        end;
      end;

      if not Result then
      begin
        DMBaseDatos.DBBaseDatos.Close;
        DMBaseDatos.DBMaster.Close;
        FreeAndNil( DMBaseDatos );
      end;

    finally
      FreeAndNil( FDPassword );
    end;
  end
  else
  begin
    ShowMessage('Primero debe de configurar a la Base de Datos que quiere conectar.');
  end;
end;

procedure bnCloseQuery(AQuery: TDataSet);
begin
  if AQuery.Active then
  begin
    AQuery.Cancel;
    AQuery.Close;
  end;
end;

procedure bnCloseQuerys(AQuerys: array of TDataSet);
var
  i: integer;
begin
  for i := 0 to Length(AQuerys) - 1 do
  begin
    bnCloseQuery(AQuerys[i]);
  end;
end;

procedure CloseAuxQuerys;
begin
  if DMBaseDatos <> nil then
  begin
    with DMBaseDatos do
    begin
      bnCloseQuerys([QGeneral, QDespegables, QListado, QTemp, QAux]);
      QDespegables.Tag := 0;
    end;
  end;
end;

// -1 : sin permiso
//  0 : permiso lectura
//  1 : permiso escritura
function TDMBaseDatos.GetPermiso( const AUser, APermiso: string ): integer;
begin
  with QAux do
  begin
    SQL.Clear;
    SQL.Add('select nvl(escritura_cpu,0) valor ');
    SQL.Add('from cnf_permisos_usuarios ');
    SQL.Add('where usuario_cpu = :user ');
    SQL.Add('and permiso_cpu = :permiso ');
    ParamByName('user').AsString:= AUser;
    ParamByName('permiso').AsString:= APermiso;
    Open;
    try
      if IsEmpty then
        Result:= -1
      else
        Result:= FieldByName('valor').AsInteger;
    finally
      Close;
    end;
  end;
end;

procedure TDMBaseDatos.CerrarConexionCentral;
begin
  if BDCentral.Connected then
  begin
    BDCentral.Connected:= False;
  end;
end;

function  TDMBaseDatos.AbrirConexionCentral: Boolean;
begin
  if BDCentral.Connected then
  begin
    Result:= True;
  end
  else
  begin
    try
      BDCentral.Connected:= True;
      Result:= True;
    except
      Result:= False;
    end;
  end;
end;


end.

