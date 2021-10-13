unit UDMSincroWeb;

interface

uses
  SvcMgr,
  SysUtils,
  Classes,
  Controls,
  SqlExpr,


  SincronizacionBonny,
  ConexionInformix,
  ConexionAWSAurora;


type
  TFDMSincroWeb = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    Fichero: TStringList;

    FConexionInformix: TConexionInformix;
    FConexionAWSAurora: TConexionAWSAurora;
    FSincroBonnyAurora: TSincronizacionBonny;

    FProximaEjecucion: TDateTime; // Hora de la proxima ejecucion

    function GetComputerNetName: String;
    function CalcularProximaEjecucion(AFechaHora: TDateTime): TDateTime;

  public

    procedure Ejecutar;
    property Sincronizacion: TSincronizacionBonny read FSincroBonnyAurora;
    property ProximaEjecucion: TDateTime read FProximaEjecucion;

  end;

var
  FDMSincroWeb: TFDMSincroWeb;

implementation

uses
  DateUtils,
  Windows,
  ConexionInformixConstantes;

{$R *.dfm}

{
type
  THoraSincro = record
    horas: word;
    minutos: word;
  end;

const
  NUM_PLANIFICACIONES = 2;

var
  Planificacion: array[0..NUM_PLANIFICACIONES-1] of THoraSincro = (
    (horas: 00; minutos: 06),
    (horas: 00; minutos: 07)
  );
}
{ TDataModule2 }


function TFDMSincroWeb.CalcularProximaEjecucion(AFechaHora: TDateTime): TDateTime;
begin
  Result := 0;
end;
{
var
  yy, mm, dd, h, m, s, ms: word;
  i: integer;
  fechaHoraActual: TDateTime;
  fechaHoraAux: TDateTime;
  encontradaHora: boolean;
begin
  DecodeDateTime(AFechaHora, yy, mm, dd, h, m, s, ms);

  // Si solo hay una hora en la lista de horas, coger la primera
  if NUM_PLANIFICACIONES = 1 then
  begin
    fechaHoraAux := EncodeDateTime(yy, mm, dd, Planificacion[0].horas, Planificacion[0].minutos, 0, 0);
    if AFechaHora < fechaHoraAux then
      Result := fechaHoraAux
    else
      Result := IncDay(fechaHoraAux);
  end
  else
  begin
    // Buscar la siguiente hora en la lista
    encontradaHora := false;
    for i := 0 to NUM_PLANIFICACIONES - 1 do
    begin
      fechaHoraAux := EncodeDateTime(yy, mm, dd, Planificacion[i].horas, Planificacion[i].minutos, 0, 0);
      if AFechaHora <= fechaHoraAux then
      begin
        Result := fechaHoraAux;
        encontradaHora := True;
        Break;
      end
      else
        Continue
    end;

    // Si no hay horas posteriores en la lista de horas, coger la primera.
    if not encontradaHora then
    begin
      fechaHoraAux := EncodeDateTime(yy, mm, dd, Planificacion[0].horas, Planificacion[0].minutos, 0, 0);
      Result := IncDay(fechaHoraAux);
    end;
  end;
end;
}

procedure TFDMSincroWeb.DataModuleCreate(Sender: TObject);
begin
try
  Fichero := TStringList.Create;

  FConexionInformix := TConexionInformix.Create(nil);
  FConexionAWSAurora := TConexionAWSAurora.Create(nil);

  FSincroBonnyAurora := TSincronizacionBonny.Create(FConexionInformix, FConexionAWSAurora);
  FSincroBonnyAurora.Usuario := _INFORMIX_USER_;
  FSincroBonnyAurora.Maquina := GetComputerNetName;

  FProximaEjecucion := CalcularProximaEjecucion(Now);

  except
  on E: Exception do
  begin
    Fichero.add(E.Message);
       Fichero.SaveToFile('C:\Delphi2007\GComer Desarrollo\Comun\SincronizacionWeb\Servicio\SincroWeb.log');

  end;
end;
end;

procedure TFDMSincroWeb.DataModuleDestroy(Sender: TObject);
begin
  Fichero.Free;
  FSincroBonnyAurora.Fin;
  FSincroBonnyAurora.Free;
  FConexionInformix.Free;
  FConexionAWSAurora.Free;
end;


procedure TFDMSincroWeb.Ejecutar;
var
  dir: String;
begin
    Fichero.Clear;
    try
      FSincroBonnyAurora.Sincronizar;
    except
      on E: Exception do
      begin
        Fichero.Add(E.Message);
      end;
    end;

    dir := ParamStr(0);
    dir := extractfiledir(dir);
    Fichero.SaveToFile(dir + '\SincroWeb.log');
end;

function TFDMSincroWeb.GetComputerNetName: String;
var
  ComputerName: Array [0 .. 256] of char;
  Size: DWORD;
begin
  Size := 256;
  GetComputerName(ComputerName, Size);
  Result := ComputerName;
end;

end.
