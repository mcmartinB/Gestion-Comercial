{*
  Codigo comun para el tratamiento de las salidas de fruta
  INICIO: 17/3/2005

  @author Departamento de Informática Horvesa
  @version V.0.1
}
unit USalidasUC;

interface

uses UDMBaseDatos, bSQLUtils;

function KgsSalida(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string): Real;

implementation

function KgsSalida(const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string): Real;
begin
  with DMBaseDatos.QAux do
  begin
    //SALIDAS DIRECTAS
    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) ' +
      ' from frf_salidas_c, frf_salidas_l ' +
      ' where empresa_sc ' + SQLEqualS(AEmpresa) +
      ' and centro_salida_sc ' + SQLEqualS(ACentro) +
      ' and empresa_sl ' + SQLEqualS(AEmpresa) +
      ' and centro_salida_sl ' + SQLEqualS(ACentro) +
      ' and fecha_sl = fecha_sc ' +
      ' and n_albaran_sl = n_albaran_sc ' +
      ' and centro_salida_sl = centro_origen_sl ' +
      ' and producto_sl ' + SQLEqualS(AProducto) +
      ' and categoria_sl ' + SQLEqualS('B', '<>') + //SIN BOTADO
      ' and fecha_sl ' + SQLRangeD(AFechaIni, AFechaFin) +

      //SALIDAS QUE NO PROVENGAN DE UN TRANSITO
      '  and ( nvl(es_transito_sc,0) =  0 ) ' +
      ' and TRIM(NVL(ref_transitos_sl,'''')) = '''' ');

    OpenQuery(DMBaseDatos.QAux);
    result := Fields[0].AsFloat;
    Close;
    //TRANSITOS DIRECTOS
    SQL.Clear;
    SQL.Add(' select sum(kilos_tl) ' +
      ' from frf_transitos_l ' +
      '       WHERE empresa_tl ' + SQLEqualS(AEmpresa) +
      '        AND centro_origen_tl ' + SQLEqualS(ACentro) +
      '        AND centro_tl ' + SQLEqualS(ACentro) +
      '        AND fecha_tl ' + SQLRangeD(AFechaIni, AFechaFin) +
      '        AND producto_tl ' + SQLEqualS(AProducto) +
      '        AND ref_origen_tl is null ');
    OpenQuery(DMBaseDatos.QAux);
    result := result + Fields[0].AsFloat;
    Close;
  end;
end;

end.
