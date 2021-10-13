{*
  Codigo comun para el tratamiento de las entradas de fruta
  INICIO: 17/3/2005

  @author Departamento de Informática Horvesa
  @version V.0.1
}
unit UEntradasUC;

interface

function KgsEntrada(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string): Real;

implementation

uses SysUtils, UDMBaseDatos, bSQLUtils;

function KgsEntrada(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string): Real;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select sum(total_kgs_e2l) kgs ' +
      ' from frf_entradas2_l ' +
      ' where empresa_e2l ' + SQLEqualS(AEmpresa) +
      ' and centro_e2l ' + SQLEqualS(ACentro) +
      ' and producto_e2l ' + SQLEqualS(AProducto) +
      ' and fecha_e2l ' + SQLRangeD(AFechaIni, AFechaFin));
    Open;
    result := Fields[0].AsFloat;
    Close;

    (*
      ERNESTO
      20090420 Dejamos como estaba, todas las entregas de SAT deben tener una entrada
               Motivo, todas las entradas de fruta (incluida las compras) pasan por el SGP
    *)
    (*
    SQL.Clear;
    SQL.Add(' select sum(kilos_el) kilos ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and fecha_llegada_ec between :fechaini and :fechafin ');
    SQL.Add(' and centro_llegada_ec = :centro ');
    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('   select * ');
    SQL.Add('   from frf_entregas_rel ');
    SQL.Add('   where codigo_er = codigo_ec ');
    SQL.Add(' ) ');
    SQL.Add(' and codigo_ec = codigo_el ');
    SQL.Add(' and producto_el = :producto ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fechaini').AsDateTime:= StrToDate( AFechaIni );
    ParamByName('fechafin').AsDateTime:= StrToDate( AFechaFin );
    Open;
    result := result + Fields[0].AsFloat;
    Close;
    *)
  end;
end;

end.
