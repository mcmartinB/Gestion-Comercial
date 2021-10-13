unit SincroMensualMasterUNT;

interface

uses SysUtils, DB, DBTables, SincroVarUNT;


function  SincronizarRegistros( const AEmpresa: string;
                                   const AAnyo, AMes: integer;
                                   const ATitulo: String;
                                   const ATipo: integer ): RSincroResumen;
procedure CrearQuerys;
procedure DestruirQuerys;
procedure PreparaQuerys( const AEmpresa: string; const ATipo: Integer );
procedure ParametrosQuerys( const AEmpresa: string; const AAnyo, AMes, ATipo: integer );
procedure AbrirQuerys;
procedure CerrarQuerys;
function  PasarRegistros: RSincroResumen;

implementation

uses UDMBaseDatos;

var
  QSourceCab: TQuery;
  QTargetCab: TQuery;

procedure CrearQuerys;
begin
  QSourceCab:= TQuery.Create( nil );
  QSourceCab.DatabaseName:= 'BDProyecto';
  QTargetCab:= TQuery.Create( nil );
  QTargetCab.DatabaseName:= 'BDCentral';
  QTargetCab.RequestLive:= True;
end;

procedure DestruirQuerys;
begin
  FreeAndNil( QSourceCab );
  FreeAndNil( QTargetCab );
end;

procedure PreparaQuerysCosteEnvase( const AEmpresa: string );
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_env_costes');
  QTargetCab.SQL.Add('where empresa_ec = ''###'' ');

  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_env_costes');
  if AEmpresa <> '' then
  begin
    QSourceCab.SQL.Add('where empresa_ec = :empresa');
    QSourceCab.SQL.Add('  and anyo_ec = :anyo');
    QSourceCab.SQL.Add('  and mes_ec = :mes');
  end
  else
  begin
    QSourceCab.SQL.Add('where anyo_ec = :anyo');
    QSourceCab.SQL.Add('  and mes_ec = :mes');
  end;
end;

procedure PreparaQuerys( const AEmpresa: string; const ATipo: integer );
begin
  case ATipo of
    kSCostesEnvase: PreparaQuerysCosteEnvase( AEmpresa );
    else raise Exception.Create('Error al crear las sentencias SQL.');
  end;
end;

procedure ParametrosQuerys( const AEmpresa: string; const AAnyo, AMes, ATipo: integer );
begin
  if Trim( AEmpresa ) <> '' then
  begin
    QSourceCab.ParamByName('empresa').AsString:= AEmpresa;
  end;

  QSourceCab.ParamByName('anyo').AsInteger:= AAnyo;
  QSourceCab.ParamByName('mes').AsInteger:= AMes;
end;

procedure AbrirQuerys;
begin
  DMBaseDatos.BDCentral.Open;
  QSourceCab.Open;
  QTargetCab.Open;
end;

procedure CerrarQuerys;
begin
  QSourceCab.Close;
  QTargetCab.Close;
  DMBaseDatos.BDCentral.Close;
end;

function PasarRegistros: RSincroResumen;
var
  sMsg: String;
begin
  QSourceCab.First;
  while not QSourceCab.Eof do
  begin
    try
      result.registros:= result.registros + 1;
      sMsg:= DescripcionRegistro( QSourceCab, 6 );
      PasaRegistro( QSourceCab, QTargetCab );
      result.pasados:= result.pasados + 1;
      sMsg:= ' ---> ' + IntToStr( result.pasados ) + ') ' + #13 + #10 + sMsg;
      result.msgPasados.Add( sMsg );
    except
      on e: edbengineerror do
      begin
        if e.Errors[0].ErrorCode = 13059 then
        begin
          sMsg:= ' ---> ' + IntToStr( result.duplicados ) + ') ' + #13 + #10 + sMsg;
          result.msgDuplicados.Add( sMsg );
          result.duplicados:= result.duplicados + 1;
        end
        else
        begin
          sMsg:= sMsg + #13 + #10 + '[' + IntToStr( e.Errors[0].ErrorCode ) + '] ' + e.Message;
          sMsg:= ' ---> ' + IntToStr( result.erroneos ) + ') ' + #13 + #10 + sMsg;
          result.msgErrores.Add( sMsg );
          result.erroneos:= result.erroneos + 1;
        end;
      end;
      on e: exception do
      begin
        sMsg:= sMsg + #13 + #10 + e.Message;
        sMsg:= ' ---> ' + IntToStr( result.erroneos ) + ') ' + #13 + #10 + sMsg;
        result.msgErrores.Add( sMsg );
        result.erroneos:= result.erroneos + 1;
      end;
    end;
    QSourceCab.Next;
  end;
end;

function SincronizarRegistros( const AEmpresa: string;
                                   const AAnyo, AMes: integer;
                                   const ATitulo: String;
                                   const ATipo: integer ): RSincroResumen;
begin
  result.titulo:= ATitulo;
  CrearQuerys;
  try
    PreparaQuerys( AEmpresa, ATipo );
    ParametrosQuerys( AEmpresa, AAnyo, AMes, ATipo );
    AbrirQuerys;
    result:= PasarRegistros;
  finally
    CerrarQuerys;
    DestruirQuerys;
  end;
end;

end.


