unit CDLFacturasTransporteDepositos;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLFacturasTransporteDepositos = class(TDataModule)
    QTransitos: TQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro, AAgrupacion, AProducto: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const ADatos: integer ): boolean;
    procedure CerrarQuery;
  end;

var
  DLFacturasTransporteDepositos: TDLFacturasTransporteDepositos;

implementation

{$R *.dfm}

uses
  UDMAuxDB;

function TDLFacturasTransporteDepositos.AbrirQuery( const AEmpresa, ACentro, AAgrupacion, AProducto: string;
                                       const AFechainicio, AFechafin: TDateTime;
                                       const ADatos: integer ): boolean;
begin
  with QTransitos do
  begin
    SQL.Clear;

    if ( ADatos = 0 ) or ( ADatos = 1 ) then
    begin
      SQL.Add(' select transporte_tc transporte, factura_dac factura, carpeta_deposito_tc carpeta,  ');
      SQL.Add('        ( select descripcion_t from frf_transportistas where transporte_t = transporte_tc ) des_transporte, ');
      SQL.Add('        sum( nvl(flete_dac,0) + nvl(rappel_dac,0) + nvl(manipulacion_dac,0) + nvl(mercancia_dac,0)  ');
      SQL.Add('           + nvl(combustible_dac,0) + nvl(seguridad_dac,0) + nvl(frigorifico_dac,0) ) importe_total ');
      SQL.Add(' from frf_depositos_aduana_c, frf_transitos_c ');
      SQL.Add(' where empresa_dac = :empresa ');
      SQL.Add(' and centro_dac = :centro ');
      SQL.Add(' and fecha_dac between :fechaini and :fechafin ');

      SQL.Add(' and empresa_tc = :empresa ');
      SQL.Add(' and centro_tc = :centro ');
      SQL.Add(' and referencia_tc = referencia_dac ');
      SQL.Add(' and fecha_tc = fecha_dac ');

      if AProducto <> '' then
      begin
        SQL.Add(' and exists ( ');
        SQL.Add(' select * ');
        SQL.Add(' from frf_transitos_l ');
        SQL.Add(' where empresa_tc = empresa_tl ');
        SQL.Add(' and centro_tc = centro_tl ');
        SQL.Add(' and referencia_tc = referencia_tl ');
        SQL.Add(' and fecha_tc = fecha_tl ');
        SQL.Add(' and producto_tl = :producto )');
      end;

      if AAgrupacion <> '' then
      begin
        SQL.Add(' and exists ( ');
        SQL.Add(' select * ');
        SQL.Add(' from frf_transitos_l ');
        SQL.Add(' where empresa_tc = empresa_tl ');
        SQL.Add(' and centro_tc = centro_tl ');
        SQL.Add(' and referencia_tc = referencia_tl ');
        SQL.Add(' and fecha_tc = fecha_tl ');
        SQl.Add(' and producto_tl in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ) ');
      end;

      SQL.Add(' group by 1,2,3,4 ');
    end;

    if ( ADatos = 0 )  then
    begin
      SQL.Add(' union ');
    end;

    if ( ADatos = 0 ) or ( ADatos = 2 ) then
    begin
      SQL.Add(' select transporte_sc transporte, factura_dac factura, carpeta_deposito_sc carpeta, ');
      SQL.Add('         ( select descripcion_t from frf_transportistas where transporte_t = transporte_sc ) des_transporte, ');
      SQL.Add('         sum( nvl(flete_dac,0) + nvl(rappel_dac,0) + nvl(manipulacion_dac,0) + nvl(mercancia_dac,0) + nvl(combustible_dac,0)   ');
      SQL.Add('            + nvl(seguridad_dac,0) + nvl(frigorifico_dac,0) ) importe_total ');
      SQL.Add('  from frf_depositos_aduana_c, frf_salidas_c ');
      SQL.Add('  where empresa_dac = :empresa ');
      SQL.Add('  and centro_dac = :centro ');
      SQL.Add('  and fecha_dac between :fechaini and :fechafin ');
      SQL.Add('  and empresa_sc = empresa_dac ');
      SQL.Add('  and centro_salida_sc = centro_dac ');
      SQL.Add('  and n_albaran_sc = referencia_dac ');
      SQL.Add('  and fecha_sc = fecha_dac ');


      if AProducto <> '' then
      begin
        SQL.Add(' and exists (   ');
        SQL.Add(' select *     ');
        SQL.Add(' from frf_salidas_l ');
        SQL.Add(' where empresa_sc = empresa_sl ');
        SQL.Add(' and centro_salida_sc = centro_salida_sl ');
        SQL.Add(' and n_albaran_sc = n_albaran_sl ');
        SQL.Add(' and fecha_sc = fecha_sl ');
        SQL.Add(' and producto_sl = :producto )');
      end;

      if AAgrupacion <> '' then
      begin
        SQL.Add(' and exists (   ');
        SQL.Add(' select *     ');
        SQL.Add(' from frf_salidas_l ');
        SQL.Add(' where empresa_sc = empresa_sl ');
        SQL.Add(' and centro_salida_sc = centro_salida_sl ');
        SQL.Add(' and n_albaran_sc = n_albaran_sl ');
        SQL.Add(' and fecha_sc = fecha_sl ');
        SQl.Add(' and producto_sl in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) )');
      end;

      SQL.Add('  group by 1,2,3,4 ');
    end;

    SQL.Add(' order by 1,2 ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    if AProducto <> '' then
    begin
      ParamByName('producto').AsString:= AProducto;
    end;

    if AAgrupacion <> '' then
      ParamByName('agrupacion').AsString:=AAgrupacion;

    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDLFacturasTransporteDepositos.CerrarQuery;
begin
  QTransitos.Close;
end;

end.


