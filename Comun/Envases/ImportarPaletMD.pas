unit ImportarPaletMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMImportarPalet = class(TDataModule)
    qryRemoto: TQuery;
    qryLocal: TQuery;
    qryAuxLocal: TQuery;
  private
    { Private declarations }
    sMessage: string;
    sPalet: string;

    procedure ConfigurarBD( const ABDRemota: string );
    procedure LoadQuerysPalet;
    procedure MakeQuerysPalet;
    function  OpenQuerys: Boolean;
    procedure CloseQuerys;

    procedure SincronizaPalets;
    procedure SincronizaPalet( var Vlog: string );
    function  GetMessage: string;

  public
    { Public declarations }
    function SincronizarPalets( const APalet: string ): Boolean;
  end;


  function SincronizarPalet( const AOwner: TComponent; const ABDRemota, APalet: string; var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  Variants, USincronizarTablas, MostrarLogFD;

var
  DMImportarPalet: TDMImportarPalet;

function SincronizarPalet( const AOwner: TComponent; const ABDRemota, APalet: string; var VMsg: string ): Boolean;
begin
  DMImportarPalet:= TDMImportarPalet.Create( AOwner );
  try
    DMImportarPalet.ConfigurarBD( ABDRemota );
    Result:= DMImportarPalet.SincronizarPalets( APalet );
    VMsg:=  DMImportarPalet.GetMessage;
  finally
    FreeAndNil( DMImportarPalet );
  end;
end;

function  TDMImportarPalet.GetMessage: string;
begin
  Result:= sMessage;
end;

procedure TDMImportarPalet.ConfigurarBD( const ABDRemota: string );
begin
  qryRemoto.DatabaseName:= ABDRemota;
end;

function TDMImportarPalet.SincronizarPalets( const APalet: string ): Boolean;
begin
  sMessage:= '';
  sPalet:= APalet;

  if OpenQuerys then
  begin
    SincronizaPalets;
    Result:= True;
  end
  else
  begin
    sMessage:= 'No se ha encontrado el Palet ' + APalet  + ' en la base de datos origen.';
    result:= False;
  end;
  CloseQuerys;
end;



procedure TDMImportarPalet.LoadQuerysPalet;
begin
  with qryRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_tipo_Palets');
    SQL.Add('where codigo_tp = :palet ');
  end;
end;

procedure TDMImportarPalet.MakeQuerysPalet;
begin
  with qryLocal do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_tipo_Palets ');
    SQL.Add('where 1 =  1 ');
    if qryRemoto.FieldByname('codigo_tp').Value <> Null then
      SQL.Add('and codigo_tp =  :palet ');

    if qryRemoto.FieldByname('codigo_tp').Value <> Null then
      ParamByName('palet').AsString:= qryRemoto.FieldByname('codigo_tp').AsString;;
  end;
end;



function TDMImportarPalet.OpenQuerys: Boolean;
begin
  LoadQuerysPalet;
  //Abrir origen
  qryRemoto.ParamByName('Palet').AsString:= sPalet;
  qryRemoto.Open;
  Result:= not qryRemoto.IsEmpty;
end;

procedure TDMImportarPalet.CloseQuerys;
begin
  qryRemoto.Close;
  qryLocal.Close;
end;

procedure TDMImportarPalet.SincronizaPalets;
var
  iResult: Integer;
  sLog: string;
begin
  sLog:= 'RESULTADO SINCRONIZACION';
  sLog:= sLog + #13 + #10 + '------------------------';

  while not qryRemoto.Eof do
  begin
    SincronizaPalet( sLog );
    qryRemoto.Next;
  end;
  MostrarLogFD.MostrarLog( Self, sLog );
end;



procedure TDMImportarPalet.SincronizaPalet( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el cliente, si no dara error al grabar
  MakeQuerysPalet;
  qryLocal.Open;
  //if SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Palet' ) > 0 then
  SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Palet' );
  VLog:= VLog + sLog;
  qryLocal.Close;
end;

end.


