unit LiquidaPeriodoControlDM;

interface

uses
  SysUtils, Classes;

type
  TDMLiquidaPeriodoControl = class(TDataModule)
  private
    { Private declarations }

    iTipoLiquida: integer; // 0: salidas 1:escandallo 2:ajustes
    sEmpresa, sCentro, sProducto, sCosechero: string;
    dFechaIni, dFechaFin: TDateTime;
    rCosteComercial, rCosteProduccion, rCosteAdministrativo: Real;
    bDefinitiva: boolean;

  public
    { Public declarations }

    function VerificarPeriodo(const AEmpresa, AProducto: string;
                             const ADesde, AHasta: TDateTime;
                             const AComercial, AProduccion, AAdministrativo: Real;
                             const ADefinitiva: boolean;
                             var AMsg: string ): Boolean;
  end;

var
  DMLiquidaPeriodoControl: TDMLiquidaPeriodoControl;

implementation

{$R *.dfm}

function TDMLiquidaPeriodoControl.VerificarPeriodo(
                             const AEmpresa, AProducto: string;
                             const ADesde, AHasta: TDateTime;
                             const AComercial, AProduccion, AAdministrativo: Real;
                             const ADefinitiva: boolean;
                             var AMsg: string ): Boolean;
begin
  //
  Result:= True;
end;

(*
function EstaGastoEnvasadoGrabado(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDateTime; var AMsg: string): boolean;
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
      if sEnvase <> '' then
        raise Exception.Create('No existe ningún precio para el centro/envase/mes:  (' + sEnvase + ')');
    end;

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

function EstaGastoTransitoAsignado(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_c, frf_transitos_l ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc between :fechaini and :fechafin ');
    SQL.Add(' and status_gastos_tc = ''N'' ');
    SQL.Add(' and empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :centro ');
    SQL.Add(' and fecha_tl = fecha_tc ');
    SQL.Add(' and referencia_tl = referencia_tc ');
    SQL.Add(' and producto_tl = :producto ');
    ParamByname('empresa').AsString := AEmpresa;
    ParamByname('centro').AsString := ACentro;
    ParamByname('producto').AsString := AProducto;
    ParamByname('fechaini').AsDate := AFechaIni;
    ParamByname('fechafin').AsDate := AFechaFin;
    Open;
    result:= IsEmpty;
    Close;
  end;
end;

*)

end.
