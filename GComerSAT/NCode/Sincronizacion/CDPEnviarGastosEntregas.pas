unit CDPEnviarGastosEntregas;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDPEnviarGastosEntregas = class(TDataModule)
    QExisteEntrega: TQuery;
    QGastosOrigen: TQuery;
    QGastosDestino: TQuery;
    QUltimaLineaGastosDestino: TQuery;
  private
    { Private declarations }
   procedure QueryGastosOrigen( const BDOrigen : string;
               const ATipoCentro: integer; const ATipoFecha: integer;
               const ATipoCodigo: integer; const ACodigo: string );
   procedure GastosOrigen( const AEmpresa, ACentro: string;
               const AFechaIni, AFechaFin: TDateTime; const ACodigo: string );

   procedure QueryGastosDestino( const BDDestino : string );
   procedure GastosDestino;
   function  UltimaLineaGastosDestino( const AEntrega: string ): integer;


  public
    { Public declarations }
    function SincronizargastosEntregas( const BDOrigen , BDDestino, AEmpresa: string;
             const ATipoCentro: integer; const ACentro: string;
             const ATipoFecha: integer; const AFechaIni, AFechaFin: TDateTime;
             const ATipoCodigo: integer; const Acodigo: string ): boolean;
  end;

  function SincronizargastosEntregas( const BDOrigen , BDDestino, AEmpresa: string;
             const ATipoCentro: integer; const ACentro: string;
             const ATipoFecha: integer; const AFechaIni, AFechaFin: TDateTime;
             const ATipoCodigo: integer; const Acodigo: string ): boolean;


implementation

{$R *.dfm}

uses dialogs;

var
  DPEnviarGastosEntregas: TDPEnviarGastosEntregas;

function SincronizargastosEntregas( const BDOrigen , BDDestino, AEmpresa: string;
             const ATipoCentro: integer; const ACentro: string;
             const ATipoFecha: integer; const AFechaIni, AFechaFin: TDateTime;
             const ATipoCodigo: integer; const ACodigo: string ): boolean;
begin
  DPEnviarGastosEntregas:= TDPEnviarGastosEntregas.Create( nil );
  try
    result:= DPEnviarGastosEntregas.SincronizargastosEntregas( BDOrigen , BDDestino, AEmpresa,
               ATipoCentro, ACentro, ATipoFecha, AFechaIni, AFechaFin, ATipoCodigo, Acodigo );
  finally
    FreeAndNil( DPEnviarGastosEntregas );
  end;
end;

function TDPEnviarGastosEntregas.SincronizargastosEntregas(
             const BDOrigen , BDDestino, AEmpresa: string;
             const ATipoCentro: integer; const ACentro: string;
             const ATipoFecha: integer; const AFechaIni, AFechaFin: TDateTime;
             const ATipoCodigo: integer; const ACodigo: string ): boolean;
var
  iUltimaLinea: integer;
begin
  QueryGastosOrigen( BDOrigen, ATipoCentro, ATipoFecha, ATipoCodigo, ACodigo );
  GastosOrigen( AEmpresa, ACentro, AFechaIni, AFechaFin, ACodigo );

  resuLT:= not QGastosOrigen.IsEmpty;
  if not QGastosOrigen.IsEmpty then
  begin
    QueryGastosDestino( BDDestino );
    GastosDestino;
    while not QGastosOrigen.Eof do
    begin
      iUltimaLinea:= UltimaLineaGastosDestino( QGastosOrigen.FieldByName('codigo_ge').AsString );
      showMessage( IntToStr( iUltimaLinea ));
      QGastosOrigen.Next;
    end;
  end;
  QGastosOrigen.Close;
end;

procedure TDPEnviarGastosEntregas.QueryGastosOrigen( const BDOrigen : string;
             const ATipoCentro: integer; const ATipoFecha: integer;
             const ATipoCodigo: integer; const ACodigo: string );
begin
  with QGastosOrigen do
  begin
    DatabaseName:= BDOrigen;
    SQL.Clear;
    SQL.Add(' select frf_gastos_entregas.* ');
    SQL.Add(' from frf_entregas_c, frf_gastos_entregas ');
    SQL.Add(' where empresa_ec = :empresa ');
    if ATipoCentro = 0 then
      SQL.Add(' and centro_origen_ec = :centro ')
    else
      SQL.Add(' and centro_llegada_ec = :centro ');
    if ATipoCentro = 0 then
      SQL.Add(' and fecha_origen_ec between :fechaini and :fechafin ')
    else
      SQL.Add(' and fecha_llegada_ec between :fechaini and :fechafin ');
    if Acodigo <> '' then
    begin
      case ATipoCodigo of
        0: SQL.Add(' and codigo_ec = :codigo ');
        1: SQL.Add(' and albaran_ec = :codigo ');
        2: SQL.Add(' and adjudicacion_ec = :codigo ');
      end;
    end;
    SQL.Add(' and codigo_ge = codigo_ec ');
  end;
end;

procedure TDPEnviarGastosEntregas.GastosOrigen( const AEmpresa, ACentro: string;
             const AFechaIni, AFechaFin: TDateTime; const ACodigo: string );
begin
  with QGastosOrigen do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    if ACodigo <> '' then
      ParamByName('codigo').AsString:= ACodigo;
    Open;
  end;
end;

procedure TDPEnviarGastosEntregas.QueryGastosDestino( const BDDestino: string );
begin
  with QGastosDestino do
  begin
    DatabaseName:= BDdestino;
    RequestLive:= True;
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_gastos_entregas ');
  end;

  with QUltimaLineaGastosDestino do
  begin
    DatabaseName:= BDdestino;
    SQL.Clear;
    SQL.Add(' select max(linea_ge) linea ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :codigo ');
  end;
end;

procedure TDPEnviarGastosEntregas.GastosDestino;
begin
  with QGastosOrigen do
  begin
    Open;
  end;
end;

function TDPEnviarGastosEntregas.UltimaLineaGastosDestino( const AEntrega:string ): integer;
begin
  with QUltimaLineaGastosDestino do
  begin
    ParamByName('codigo').AsString:= AEntrega;
    Open;
    result:= QUltimaLineaGastosDestino.FieldByName('linea').AsInteger;
    Close;
  end;
end;

end.
