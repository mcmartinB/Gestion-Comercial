unit UnitCodeLiquidacion;


interface

uses
  Controls, SysUtils, UDMAuxDB;

procedure AddLine(var AText: string; ALine: string);
procedure SetFocusNil(var AFocus: TWinControl; AControl: TWinControl);

function ExisteAlgunCosteEnvasado( const AEmpresa, ACentro, AProducto: string;
                                   const AFechaIni, AFechaFin: TDateTime;
                                   var AMsg: string): boolean;
function FaltaAlgunCosteEnvasado( const AEmpresa, ACentro, AProducto: string;
                                   const AFechaIni, AFechaFin: TDateTime;
                                   var AMsg: string): boolean;

implementation

uses
  bSQLUtils;

procedure AddLine(var AText: string; ALine: string);
begin
  if Trim(AText) <> '' then
  begin
    AText := AText + #13 + #10 + ALine;
  end
  else
  begin
    AText := ALine;
  end;
end;

procedure SetFocusNil(var AFocus: TWinControl; AControl: TWinControl);
begin
  if AFocus = nil then
    AFocus := AControl;
end;


function ExisteAlgunCosteEnvasado( const AEmpresa, ACentro, AProducto: string;
                                   const AFechaIni, AFechaFin: TDateTime;
                                   var AMsg: string): boolean;
var
  sEnvase: string;
  iDia, iMes, iAnyo: word;
begin
  AMsg:= '';
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('  select distinct centro_salida_sl, producto_base_p, envase_sl, min(fecha_sl) fecha');
    SQL.Add('  from   frf_salidas_l, frf_productos ');
    SQL.Add('  where empresa_sl  =  :empresa ');
    SQL.Add('  and centro_origen_sl  =  :centro ');
    SQL.Add('  and fecha_sl between :fechaini and :fechafin ');
    SQL.Add('  and producto_sl = :producto ');
    SQL.Add('  and empresa_p  =  :empresa ');
    SQL.Add('  and producto_p = producto_sl ');
    SQL.Add('  and not exists ');
    SQL.Add(' ( ');
    SQL.Add('          select ( material_ec + coste_ec ) coste_ec ');
    SQL.Add('          from frf_env_costes ');
    SQL.Add('          where empresa_ec  =  :empresa ');
    SQL.Add('          and centro_ec  =  centro_salida_sl ');
    SQL.Add('          and producto_base_ec = producto_base_p ');
    SQL.Add('          and envase_ec = envase_sl ');
    SQL.Add(' ) ');
    SQL.Add('  group by 1,2,3 ');
    SQL.Add('  order by 1,2,3 ');
    ParamByname('empresa').AsString := AEmpresa;
    ParamByname('centro').AsString := ACentro;
    ParamByname('producto').AsString := AProducto;
    ParamByname('fechaini').AsDate := AFechaIni;
    ParamByname('fechafin').AsDate := AFechaFin;

    if OpenQuery(DMAuxDB.QAux) then
    begin
      sEnvase := '';
      if not isEmpty then
      begin
        DecodeDate( Fields[3].AsDateTime, iDia, iMes, iAnyo );
        sEnvase := '''' + Fields[0].AsString + '/' + Fields[2].AsString + '/' + IntToStr(iMes) + '''';
        Next;
        while not Eof do
        begin
          DecodeDate( Fields[3].AsDateTime, iDia, iMes, iAnyo );
          sEnvase := sEnvase + ',''' + Fields[0].AsString + '/' + Fields[2].AsString + '/' + IntToStr(iMes) + '''';
          Next;
        end;
      end;
      Close;
      result:= False;
    end
    else
    begin
      result:= True;
    end;
  end;
end;


function FaltaAlgunCosteEnvasado( const AEmpresa, ACentro, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime;
                                  var AMsg: string): boolean;
var
  sEnvase: string;
begin
  AMsg:= '';
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Clear;
    SQL.Add('  select distinct centro_salida_sl, producto_base_p, envase_sl, MONTH(fecha_sl) mes ');
    SQL.Add('  from   frf_salidas_l, frf_productos ');
    SQL.Add('  where empresa_sl  =  :empresa ');
    SQL.Add('  and centro_origen_sl  =  :centro ');
    SQL.Add('  and fecha_sl between :fechaini and :fechafin ');
    SQL.Add('  and producto_sl = :producto ');
    SQL.Add('  and empresa_p  =  :empresa ');
    SQL.Add('  and producto_p = producto_sl ');
    SQL.Add('  and not exists ');
    SQL.Add(' ( ');
    SQL.Add('          select ( material_ec + coste_ec ) coste_ec ');
    SQL.Add('          from frf_env_costes ');
    SQL.Add('          where anyo_ec  =  YEAR(fecha_sl) ');
    SQL.Add('          and mes_ec  =  MONTH(fecha_sl) ');
    SQL.Add('          and empresa_ec  =  :empresa ');
    SQL.Add('          and centro_ec  =  centro_salida_sl ');
    SQL.Add('          and producto_base_ec = producto_base_p ');
    SQL.Add('          and envase_ec = envase_sl ');
    SQL.Add(' ) ');
    SQL.Add('  order by 1,2,3,4 ');
    ParamByname('empresa').AsString := AEmpresa;
    ParamByname('centro').AsString := ACentro;
    ParamByname('producto').AsString := AProducto;
    ParamByname('fechaini').AsDate := AFechaIni;
    ParamByname('fechafin').AsDate := AFechaFin;

    if OpenQuery(DMAuxDB.QAux) then
    begin
      sEnvase := '';
      if not isEmpty then
      begin
        sEnvase := '''' + Fields[0].AsString + '/' + Fields[2].AsString + '/' + Fields[3].AsString + '''';
        Next;
        while not Eof do
        begin
          sEnvase := sEnvase + ',''' + Fields[0].AsString + '/' + Fields[2].AsString + '/' + Fields[3].AsString + '''';
          Next;
        end;
        result := false;
        AMsg:= sEnvase;
      end
      else
      begin
        result := True;
      end;
      Close;
    end
    else
    begin
      result := false;
    end;
  end;
end;

end.
