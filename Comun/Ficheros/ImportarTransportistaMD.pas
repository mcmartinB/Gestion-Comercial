unit ImportarTransportistaMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMImportarTransportista = class(TDataModule)
    qryRemoto: TQuery;
    qryLocal: TQuery;
    qryAuxLocal: TQuery;
  private
    { Private declarations }
    sMessage: string;
    sTransportista: string;

    procedure ConfigurarBD( const ABDRemota: string );
    procedure LoadQuerysTransportista;
    procedure MakeQuerysTransportista;
    function  OpenQuerys: Boolean;
    procedure CloseQuerys;

    procedure SincronizaTransportistas;
    procedure SincronizaTransportista( var Vlog: string );
    function  GetMessage: string;

  public
    { Public declarations }
    function SincronizarTransportistas( const ATransportista: string ): Boolean;
  end;


  function SincronizarTransportista( const AOwner: TComponent; const ABDRemota, ATransportista: string; var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  Variants, USincronizarTablas, MostrarLogFD;

var
  DMImportarTransportista: TDMImportarTransportista;

function SincronizarTransportista( const AOwner: TComponent; const ABDRemota, ATransportista: string; var VMsg: string ): Boolean;
begin
  DMImportarTransportista:= TDMImportarTransportista.Create( AOwner );
  try
    DMImportarTransportista.ConfigurarBD( ABDRemota );
    Result:= DMImportarTransportista.SincronizarTransportistas( ATransportista );
    VMsg:=  DMImportarTransportista.GetMessage;
  finally
    FreeAndNil( DMImportarTransportista );
  end;
end;

function  TDMImportarTransportista.GetMessage: string;
begin
  Result:= sMessage;
end;

procedure TDMImportarTransportista.ConfigurarBD( const ABDRemota: string );
begin
  qryRemoto.DatabaseName:= ABDRemota;
end;

function TDMImportarTransportista.SincronizarTransportistas( const ATransportista: string ): Boolean;
begin
  sMessage:= '';
  sTransportista:= ATransportista;

  if OpenQuerys then
  begin
    SincronizaTransportistas;
    Result:= True;
  end
  else
  begin
    sMessage:= 'No se ha encontrado el transportista ' + ATransportista  + ' en la base de datos origen.';
    result:= False;
  end;
  CloseQuerys;
end;



procedure TDMImportarTransportista.LoadQuerysTransportista;
begin
  with qryRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_transportistas');
    SQL.Add('where transporte_t = :transporte ');
  end;
end;

procedure TDMImportarTransportista.MakeQuerysTransportista;
begin
  with qryLocal do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_transportistas ');
    SQL.Add('where 1 =  1 ');
    if qryRemoto.FieldByname('transporte_t').Value <> Null then
      SQL.Add('and transporte_t =  :transporte ');

    if qryRemoto.FieldByname('transporte_t').Value <> Null then
      ParamByName('transporte').AsString:= qryRemoto.FieldByname('transporte_t').AsString;;
  end;
end;



function TDMImportarTransportista.OpenQuerys: Boolean;
begin
  LoadQuerysTransportista;
  //Abrir origen
  qryRemoto.ParamByName('transporte').AsString:= sTransportista;
  qryRemoto.Open;
  Result:= not qryRemoto.IsEmpty;
end;

procedure TDMImportarTransportista.CloseQuerys;
begin
  qryRemoto.Close;
  qryLocal.Close;
end;

procedure TDMImportarTransportista.SincronizaTransportistas;
var
  iResult: Integer;
  sLog: string;
begin
  sLog:= 'RESULTADO SINCRONIZACION';
  sLog:= sLog + #13 + #10 + '------------------------';

  while not qryRemoto.Eof do
  begin
    SincronizaTransportista( sLog );
    qryRemoto.Next;
  end;
  MostrarLogFD.MostrarLog( Self, sLog );
end;



procedure TDMImportarTransportista.SincronizaTransportista( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el cliente, si no dara error al grabar
  MakeQuerysTransportista;
  qryLocal.Open;
  //if SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Palet' ) > 0 then
  SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Transportista' );
  VLog:= VLog + sLog;
  qryLocal.Close;
end;

end.


