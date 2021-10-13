unit ImportarEan13MD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMImportarEan13 = class(TDataModule)
    qryRemoto: TQuery;
    qryLocal: TQuery;
    qryAuxLocal: TQuery;
  private
    { Private declarations }
    sMessage: string;
    sEmpresa, sEan13: string;

    procedure ConfigurarBD( const ABDRemota: string );
    procedure LoadQuerysEan13;
    procedure MakeQuerysEan13;
    function  OpenQuerys: Boolean;
    procedure CloseQuerys;

    procedure SincronizaEan13;
    procedure SincronizaEan( var Vlog: string );
    function  BorrarEans: Boolean;
    function  GetMessage: string;

  public
    { Public declarations }
    function SincronizarEan13( const AEmpresa, AEan13: string ): Boolean;
  end;


  function SincronizarEan13( const AOwner: TComponent; const ABDRemota, AEmpresa, AEan13: string; var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  Variants, USincronizarTablas, MostrarLogFD;

var
  DMImportarEan13: TDMImportarEan13;

function SincronizarEan13( const AOwner: TComponent; const ABDRemota, AEmpresa, AEan13: string; var VMsg: string ): Boolean;
begin
  DMImportarEan13:= TDMImportarEan13.Create( AOwner );
  try
    DMImportarEan13.ConfigurarBD( ABDRemota );
    Result:= DMImportarEan13.SincronizarEan13( AEmpresa, AEan13 );
    VMsg:=  DMImportarEan13.GetMessage;
  finally
    FreeAndNil( DMImportarEan13 );
  end;
end;

function  TDMImportarEan13.GetMessage: string;
begin
  Result:= sMessage;
end;

procedure TDMImportarEan13.ConfigurarBD( const ABDRemota: string );
begin
  qryRemoto.DatabaseName:= ABDRemota;
  //qryAuxLocal.DatabaseName:= ABDRemota;
end;

function TDMImportarEan13.SincronizarEan13( const AEmpresa, AEan13: string ): Boolean;
begin
  sMessage:= '';
  sEmpresa:= AEmpresa;
  sEan13:= AEan13;

  if OpenQuerys then
  begin
    SincronizaEan13;
    Result:= True;
  end
  else
  begin
    sMessage:= 'No se ha encontrado el Ean13 ' + AEmpresa + ' - ' + AEan13  + ' en la base de datos origen.';
    result:= False;
  end;
  CloseQuerys;
end;



procedure TDMImportarEan13.LoadQuerysEan13;
begin
  with qryRemoto do
  begin
    SQL.Clear;
    SQL.Add('select *  from frf_ean13');
    SQL.Add('where empresa_e = :empresa ');
    SQL.Add('and CODIGO_E = :ean13 ');
  end;

  with qryAuxLocal do
  begin
    SQL.Clear;
    SQL.Add('delete from frf_ean13');
    SQL.Add('where empresa_e = :empresa ');
    SQL.Add('and CODIGO_E = :ean13 ');
  end;
end;

procedure TDMImportarEan13.MakeQuerysEan13;
begin
  with qryLocal do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_ean13 e13 ');
    SQL.Add('where empresa_e = :empresa_e ');

    if qryRemoto.FieldByname('CODIGO_E').Value <> Null then
      SQL.Add('and CODIGO_E =  :CODIGO_E ');
    if qryRemoto.FieldByname('productop_e').Value <> Null then
      SQL.Add('and productop_e =  :productop_e ');
    if qryRemoto.FieldByname('envase_e').Value <> Null then
      SQL.Add('and envase_e = :envase_e ');
    if qryRemoto.FieldByname('marca_e').Value  <> Null then
      SQL.Add('and marca_e = :marca_e ');
    if qryRemoto.FieldByname('categoria_e').Value  <> Null then
      SQL.Add('and categoria_e = :categoria_e ');
    if qryRemoto.FieldByname('calibre_e').Value  <> Null then
      SQL.Add('and calibre_e = :calibre_e ');
    if qryRemoto.FieldByname('agrupacion_e').Value  <> Null then
      SQL.Add('and agrupacion_e = :agrupacion_e ');

    ParamByName('empresa_e').AsString:= sEmpresa;
    if qryRemoto.FieldByname('envase_e').Value <> Null then
      ParamByName('envase_e').AsString:= qryRemoto.FieldByname('envase_e').AsString;;
    if qryRemoto.FieldByname('productop_e').Value <> Null then
      ParamByName('productop_e').AsString:= qryRemoto.FieldByname('productop_e').AsString;;
    if qryRemoto.FieldByname('codigo_e').Value <> Null then
      ParamByName('codigo_e').AsString:= qryRemoto.FieldByname('codigo_e').AsString;
    if qryRemoto.FieldByname('marca_e').Value  <> Null then
      ParamByName('marca_e').AsString:= qryRemoto.FieldByname('marca_e').AsString;
    if qryRemoto.FieldByname('categoria_e').Value  <> Null then
      ParamByName('categoria_e').AsString:= qryRemoto.FieldByname('categoria_e').AsString;
    if qryRemoto.FieldByname('calibre_e').Value  <> Null then
      ParamByName('calibre_e').AsString:= qryRemoto.FieldByname('calibre_e').AsString;
    if qryRemoto.FieldByname('agrupacion_e').Value  <> Null then
      ParamByName('agrupacion_e').AsString:= qryRemoto.FieldByname('agrupacion_e').AsString;
  end;
end;



function TDMImportarEan13.OpenQuerys: Boolean;
begin
  LoadQuerysEan13;

  //Abrir origen
  qryRemoto.ParamByName('empresa').AsString:= sEmpresa;
  qryRemoto.ParamByName('ean13').AsString:= sEan13;
  qryRemoto.Open;
  Result:= not qryRemoto.IsEmpty;
end;

function TDMImportarEan13.BorrarEans: Boolean;
begin
  //Abrir origen
  qryAuxLocal.ParamByName('empresa').AsString:= sEmpresa;
  qryAuxLocal.ParamByName('ean13').AsString:= sEan13;
  qryAuxLocal.ExecSQL;
end;

procedure TDMImportarEan13.CloseQuerys;
begin
  qryRemoto.Close;
  qryLocal.Close;
end;

procedure TDMImportarEan13.SincronizaEan13;
var
  iResult: Integer;
  sLog: string;
begin
  sLog:= 'RESULTADO SINCRONIZACION';
  sLog:= sLog + #13 + #10 + '------------------------';

  BorrarEans;
  while not qryRemoto.Eof do
  begin
    SincronizaEan( sLog );
    qryRemoto.Next;
  end;
  MostrarLogFD.MostrarLog( Self, sLog );
end;



procedure TDMImportarEan13.SincronizaEan( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el cliente, si no dara error al grabar
  MakeQuerysEan13;
  qryLocal.Open;
  SincronizarRegistro( qryRemoto, qryLocal, sLog, 'EAN13' );
   VLog:= VLog + sLog;
  qryLocal.Close;
end;

end.


