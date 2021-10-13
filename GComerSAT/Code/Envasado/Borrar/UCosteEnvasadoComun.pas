unit UCosteEnvasadoComun;

interface

type
  RCosteEnvasado = record
    CosteEntregados: Real;
    CosteAprovechados: Real;
  end;

function GetCosteMensualEnvasado( const AEmpresa, ACentro, AProductor, AProducto, AAnyoMes: String ): RCosteEnvasado;

implementation

uses UDMBaseDatos, DBTables, SysUtils, DB, Dialogs;

function GetAnyoMes( const AEmpresa, ACentro: String;
                     var AProductor: string; const AProducto: String;
                     const AAnyoMes: string = '' ): string;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select anyo_mes_epc ');
    SQL.Add(' from frf_env_pcostes ');
    SQL.Add(' where empresa_epc = :empresa ');
    SQL.Add(' and centro_epc = :centro ');
    if AAnyoMes <> '' then
      SQL.Add(' and anyo_mes_epc < :anyo_mes ');
    SQL.Add(' and productor_epc = :productor ');
    SQL.Add(' and producto_epc = :producto ');
    SQL.Add(' order by anyo_mes_epc desc ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if AAnyoMes <> '' then
      ParamByName('anyo_mes').AsString:= AAnyoMes;
    try
      ParamByName('productor').AsInteger:= StrToInt( AProductor );
    except
      ParamByName('productor').AsInteger:= 0;
    end;
    ParamByName('producto').AsString:= AProducto;

    try
      Open;
      if IsEmpty and ( ParamByName('productor').AsInteger <> 0 ) then
      begin
        Close;
        ParamByName('productor').AsInteger:= 0;
        Open;
      end;
      AProductor:= ParamByName('productor').AsString;
      result:= Fields[0].AsString;
    finally
      Close;
    end;
  end;
end;

function GetAplicacion( const ATipo: String ): Integer;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select NVL(aplicacion_etc, 1) ');
    SQL.Add(' from frf_env_tcostes ');
    SQL.Add(' where env_tcoste_etc = :tipo ');

    ParamByName('tipo').AsString:= ATipo;

    try
      Open;
      result:= fields[0].AsInteger;
    finally
      Close;
    end;
  end;
end;

function GetAnyoMesCosteMensual( const AEmpresa, ACentro, AAnyoMes: String ): String;
begin
  result:= '';
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select MAX (anyo_mes_emc ) ');
    SQL.Add(' from frf_env_mcostes ');
    SQL.Add(' where  empresa_emc = :empresa ');
    SQL.Add(' and centro_emc = :centro ');
    SQL.Add(' and anyo_mes_emc < :anyo_mes ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('anyo_mes').AsString:= AAnyoMes;

    try
      Open;
      result:= fields[0].Asstring;
    finally
      Close;
    end;
  end;
end;

function GetCosteEnvase( const AEmpresa, ACentro, AAnyoMes, ATipo: String ): real;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select NVL(coste_kg_emc, 0) ');
    SQL.Add(' from frf_env_mcostes ');
    SQL.Add(' where  empresa_emc = :empresa ');
    SQL.Add(' and centro_emc = :centro ');
    SQL.Add(' and anyo_mes_emc = :anyo_mes ');
    SQL.Add(' and env_tcoste_emc = :tipo ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('anyo_mes').AsString:= AAnyoMes;
    ParamByName('tipo').AsString:= ATipo;

    try
      Open;
      result:= fields[0].AsFloat;
    finally
      Close;
    end;
  end;
end;

function GetCosteMensualEnvasado( const AEmpresa, ACentro, AProductor, AProducto, AAnyoMes: String ): RCosteEnvasado;
var
  sAnyoMesProveedor, sProveedorAux: String;
  rCoste: real;
begin
  result.CosteEntregados:= 0;
  result.CosteAprovechados:= 0;
  sProveedorAux:= AProductor;
  sAnyoMesProveedor:= GetAnyoMes( AEmpresa, ACentro, sProveedorAux, AProducto, AAnyoMes );
  if sAnyoMesProveedor = '' then
  begin
    exit;
  end;

  with DMBaseDatos.QTemp do
  begin
    SQL.Clear;
    SQL.Add(' select env_tcoste_epc ');
    SQL.Add(' from frf_env_pcostes ');
    SQL.Add(' where empresa_epc = :empresa ');
    SQL.Add(' and centro_epc = :centro ');
    if AAnyoMes <> '' then
      SQL.Add(' and anyo_mes_epc = :anyo_mes ');
    SQL.Add(' and productor_epc = :productor ');
    SQL.Add(' and producto_epc = :producto ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('anyo_mes').AsString:= sAnyoMesProveedor;
    ParamByName('productor').AsInteger:= StrToInt( sProveedorAux );
    ParamByName('producto').AsString:= AProducto;

    try
      Open;

      sAnyoMesProveedor:= GetAnyoMesCosteMensual( AEmpresa, ACentro, AAnyoMes );

      while not EOF do
      begin
        rCoste:= GetCosteEnvase( AEmpresa, ACentro, sAnyoMesProveedor, Fields[0].AsString );
        if GetAplicacion( Fields[0].AsString ) = 1 then
        begin
          result.CosteEntregados:= result.CosteEntregados + rCoste;
        end
        else
        begin
          result.CosteAprovechados:= result.CosteAprovechados + rCoste;
        end;
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

end.

