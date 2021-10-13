unit ImportarPlantacionesMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMImportarPlantaciones = class(TDataModule)
    qryRemoto: TQuery;
    qryLocal: TQuery;
  private
    { Private declarations }
    sMessage: string;
    sEmpresa, sProducto, sCosechero, sPlantacion, sAnySemana: string;

    procedure ConfigurarBD( const ABDRemota: string );
    procedure LoadQuerysPlantacion;
    function  OpenQuerys: Boolean;
    procedure CloseQuerys;

    procedure SincronizaPlantacion;
    procedure SincronizaEan( var Vlog: string );
    function  GetMessage: string;

  public
    { Public declarations }
    function SincronizarPlantacion( const AEmpresa, AProducto, ACosechero, APlantacion, AAnySemana: string ): Boolean;
  end;


  function SincronizarPlantacion( const AOwner: TComponent; const ABDRemota, AEmpresa, AProducto, ACosechero, APlantacion, AAnySemana: string; var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  Variants, USincronizarTablas, MostrarLogFD;

var
  DMImportarPlantacion: TDMImportarPlantaciones;

function SincronizarPlantacion( const AOwner: TComponent; const ABDRemota, AEmpresa, AProducto, ACosechero, APlantacion, AAnySemana: string; var VMsg: string ): Boolean;
begin
  DMImportarPlantacion:= TDMImportarPlantaciones.Create( AOwner );
  try
    DMImportarPlantacion.ConfigurarBD( ABDRemota );
    Result:= DMImportarPlantacion.SincronizarPlantacion( AEmpresa, AProducto, ACosechero, APlantacion, AAnySemana );
    VMsg:=  DMImportarPlantacion.GetMessage;
  finally
    FreeAndNil( DMImportarPlantacion );
  end;
end;

function  TDMImportarPlantaciones.GetMessage: string;
begin
  Result:= sMessage;
end;

procedure TDMImportarPlantaciones.ConfigurarBD( const ABDRemota: string );
begin
  qryRemoto.DatabaseName:= ABDRemota;
end;

function TDMImportarPlantaciones.SincronizarPlantacion( const AEmpresa, AProducto, ACosechero, APlantacion, AAnySemana: string ): Boolean;
begin
  sMessage:= '';
  sEmpresa:= AEmpresa;
  sProducto:= AProducto;
  sCosechero:= ACosechero;
  sPlantacion:= APlantacion;
  sAnySemana:= AAnySemana;

  if OpenQuerys then
  begin
    SincronizaPlantacion;
    Result:= True;
  end
  else
  begin
    sMessage:= 'No se ha encontrado la plantación ' + AEmpresa + ' - ' + AProducto  + ' - ' +  ACosechero  + ' - ' +  APlantacion  + ' - ' +  AAnySemana  + ' en la base de datos origen.';
    result:= False;
  end;
  CloseQuerys;
end;



procedure TDMImportarPlantaciones.LoadQuerysPlantacion;
begin
  with qryRemoto do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_plantaciones ');
    SQL.Add('where empresa_p = :empresa ');
    SQL.Add('and producto_p = :producto ');
    SQL.Add('and cosechero_p = :cosechero ');
    SQL.Add('and plantacion_p = :plantacion ');
    SQL.Add('and ano_semana_p = :ano_Semana ');
  end;

  with qryLocal do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_plantaciones ');
    SQL.Add('where empresa_p = :empresa ');
    SQL.Add('and producto_p = :producto ');
    SQL.Add('and cosechero_p = :cosechero ');
    SQL.Add('and plantacion_p = :plantacion ');
    SQL.Add('and ano_semana_p = :ano_Semana ');
  end;
end;


function TDMImportarPlantaciones.OpenQuerys: Boolean;
begin
  LoadQuerysPlantacion;
  //Abrir origen
  qryRemoto.ParamByName('empresa').AsString:= sEmpresa;
  qryRemoto.ParamByName('producto').AsString:= sProducto;
  qryRemoto.ParamByName('cosechero').AsString:= sCosechero;
  qryRemoto.ParamByName('Plantacion').AsString:= sPlantacion;
  qryRemoto.ParamByName('ano_Semana').AsString:= sAnySemana;
  qryRemoto.Open;

  //Abrir destino
  qryLocal.ParamByName('empresa').AsString:= sEmpresa;
  qryLocal.ParamByName('producto').AsString:= sProducto;
  qryLocal.ParamByName('cosechero').AsString:= sCosechero;
  qryLocal.ParamByName('Plantacion').AsString:= sPlantacion;
  qryLocal.ParamByName('ano_Semana').AsString:= sAnySemana;
  qryLocal.Open;
  Result:= not qryRemoto.IsEmpty;
end;

procedure TDMImportarPlantaciones.CloseQuerys;
begin
  qryRemoto.Close;
  qryLocal.Close;
end;

procedure TDMImportarPlantaciones.SincronizaPlantacion;
var
  iResult: Integer;
  sLog: string;
begin
  sLog:= 'RESULTADO SINCRONIZACION';
  sLog:= sLog + #13 + #10 + '------------------------';

  while not qryRemoto.Eof do
  begin
    SincronizaEan( sLog );
    qryRemoto.Next;
  end;
  MostrarLogFD.MostrarLog( Self, sLog );
end;



procedure TDMImportarPlantaciones.SincronizaEan( var Vlog: string );
var
  sLog: string;
begin
  //Abrir destino solo si existe el cliente, si no dara error al grabar
  SincronizarRegistro( qryRemoto, qryLocal, sLog, 'Plantacion' );
  VLog:= VLog + sLog;
  qryLocal.Close;
end;

end.


