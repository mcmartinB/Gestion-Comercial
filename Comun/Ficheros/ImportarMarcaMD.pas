unit ImportarMarcaMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMImportarMarca = class(TDataModule)
    qryRemoto: TQuery;
    qryLocal: TQuery;
    qryAuxLocal: TQuery;
  private
    { Private declarations }
    sMessage: string;
    sMarca: string;

    procedure ConfigurarBD( const ABDRemota: string );
    procedure LoadQuerysMarca;
    procedure MakeQuerysMarca;
    function  OpenQuerys: Boolean;
    procedure CloseQuerys;

    procedure SincronizaMarcas;
    procedure SincronizaMarca( var Vlog: string );
    function  GetMessage: string;

  public
    { Public declarations }
    function SincronizarMarcas( const AMarca: string ): Boolean;
  end;


  function SincronizarMarca( const AOwner: TComponent; const ABDRemota, AMarca: string; var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  Variants, USincronizarTablas, MostrarLogFD;

var
  DMImportarMarca: TDMImportarMarca;

function SincronizarMarca( const AOwner: TComponent; const ABDRemota, AMarca: string; var VMsg: string ): Boolean;
begin
  DMImportarMarca:= TDMImportarMarca.Create( AOwner );
  try
    DMImportarMarca.ConfigurarBD( ABDRemota );
    Result:= DMImportarMarca.SincronizarMarcas( AMarca );
    VMsg:=  DMImportarMarca.GetMessage;
  finally
    FreeAndNil( DMImportarMarca );
  end;
end;

function  TDMImportarMarca.GetMessage: string;
begin
  Result:= sMessage;
end;

procedure TDMImportarMarca.ConfigurarBD( const ABDRemota: string );
begin
  qryRemoto.DatabaseName:= ABDRemota;
end;

function TDMImportarMarca.SincronizarMarcas( const AMarca: string ): Boolean;
begin
  sMessage:= '';
  sMarca:= AMarca;

  if OpenQuerys then
  begin
    SincronizaMarcas;
    Result:= True;
  end
  else
  begin
    sMessage:= 'No se ha encontrado la Marca ' + AMarca  + ' en la base de datos origen.';
    result:= False;
  end;
  CloseQuerys;
end;



procedure TDMImportarMarca.LoadQuerysMarca;
begin
  with qryRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_marcas');
    SQL.Add('where codigo_m = :marca ');
  end;
end;

procedure TDMImportarMarca.MakeQuerysMarca;
begin
  with qryLocal do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_marcas ');
    SQL.Add('where 1 =  1 ');
    if qryRemoto.FieldByname('codigo_m').Value <> Null then
      SQL.Add('and codigo_m =  :marca ');

    if qryRemoto.FieldByname('codigo_m').Value <> Null then
      ParamByName('marca').AsString:= qryRemoto.FieldByname('codigo_m').AsString;;
  end;
end;



function TDMImportarMarca.OpenQuerys: Boolean;
begin
  LoadQuerysMarca;
  //Abrir origen
  qryRemoto.ParamByName('marca').AsString:= sMarca;
  qryRemoto.Open;
  Result:= not qryRemoto.IsEmpty;
end;

procedure TDMImportarMarca.CloseQuerys;
begin
  qryRemoto.Close;
  qryLocal.Close;
end;

procedure TDMImportarMarca.SincronizaMarcas;
var
  iResult: Integer;
  sLog: string;
begin
  sLog:= 'RESULTADO SINCRONIZACION';
  sLog:= sLog + #13 + #10 + '------------------------';

  while not qryRemoto.Eof do
  begin
    SincronizaMarca( sLog );
    qryRemoto.Next;
  end;
  MostrarLogFD.MostrarLog( Self, sLog );
end;



procedure TDMImportarMarca.SincronizaMarca( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe la marca, si no dara error al grabar
  MakeQuerysMarca;
  qryLocal.Open;
  //if SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Palet' ) > 0 then
  SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Marca' );
  VLog:= VLog + sLog;
  qryLocal.Close;
end;

end.


