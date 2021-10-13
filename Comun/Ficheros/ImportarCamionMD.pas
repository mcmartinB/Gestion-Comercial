unit ImportarCamionMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMImportarCamion = class(TDataModule)
    qryRemoto: TQuery;
    qryLocal: TQuery;
    qryAuxLocal: TQuery;
  private
    { Private declarations }
    sMessage: string;
    sCamion: string;

    procedure ConfigurarBD( const ABDRemota: string );
    procedure LoadQuerysCamion;
    procedure MakeQuerysCamion;
    function  OpenQuerys: Boolean;
    procedure CloseQuerys;

    procedure SincronizaCamiones;
    procedure SincronizaCamion( var Vlog: string );
    function  GetMessage: string;

  public
    { Public declarations }
    function SincronizarCamiones( const ACamion: string ): Boolean;
  end;


  function SincronizarCamion( const AOwner: TComponent; const ABDRemota, ACamion: string; var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  Variants, USincronizarTablas, MostrarLogFD;

var
  DMImportarCamion: TDMImportarCamion;

function SincronizarCamion( const AOwner: TComponent; const ABDRemota, ACamion: string; var VMsg: string ): Boolean;
begin
  DMImportarCamion:= TDMImportarCamion.Create( AOwner );
  try
    DMImportarCamion.ConfigurarBD( ABDRemota );
    Result:= DMImportarCamion.SincronizarCamiones( ACamion );
    VMsg:=  DMImportarCamion.GetMessage;
  finally
    FreeAndNil( DMImportarCamion );
  end;
end;

function  TDMImportarCamion.GetMessage: string;
begin
  Result:= sMessage;
end;

procedure TDMImportarCamion.ConfigurarBD( const ABDRemota: string );
begin
  qryRemoto.DatabaseName:= ABDRemota;
end;

function TDMImportarCamion.SincronizarCamiones( const ACamion: string ): Boolean;
begin
  sMessage:= '';
  sCamion:= ACamion;

  if OpenQuerys then
  begin
    SincronizaCamiones;
    Result:= True;
  end
  else
  begin
    sMessage:= 'No se ha encontrado el Camion ' + ACamion  + ' en la base de datos origen.';
    result:= False;
  end;
  CloseQuerys;
end;



procedure TDMImportarCamion.LoadQuerysCamion;
begin
  with qryRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_camiones');
    SQL.Add('where camion_c = :camion ');
  end;
end;

procedure TDMImportarCamion.MakeQuerysCamion;
begin
  with qryLocal do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_camiones ');
    SQL.Add('where 1 =  1 ');
    if qryRemoto.FieldByname('camion_c').Value <> Null then
      SQL.Add('and camion_c =  :camion ');

    if qryRemoto.FieldByname('camion_c').Value <> Null then
      ParamByName('camion').AsString:= qryRemoto.FieldByname('camion_c').AsString;;
  end;
end;



function TDMImportarCamion.OpenQuerys: Boolean;
begin
  LoadQuerysCamion;
  //Abrir origen
  qryRemoto.ParamByName('camion').AsString:= sCamion;
  qryRemoto.Open;
  Result:= not qryRemoto.IsEmpty;
end;

procedure TDMImportarCamion.CloseQuerys;
begin
  qryRemoto.Close;
  qryLocal.Close;
end;

procedure TDMImportarCamion.SincronizaCamiones;
var
  iResult: Integer;
  sLog: string;
begin
  sLog:= 'RESULTADO SINCRONIZACION';
  sLog:= sLog + #13 + #10 + '------------------------';

  while not qryRemoto.Eof do
  begin
    SincronizaCamion( sLog );
    qryRemoto.Next;
  end;
  MostrarLogFD.MostrarLog( Self, sLog );
end;



procedure TDMImportarCamion.SincronizaCamion( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el camion, si no dara error al grabar
  MakeQuerysCamion;
  qryLocal.Open;
  //if SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Palet' ) > 0 then
  SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Camion' );
  VLog:= VLog + sLog;
  qryLocal.Close;
end;

end.


