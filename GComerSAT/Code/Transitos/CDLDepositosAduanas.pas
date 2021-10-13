unit CDLDepositosAduanas;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLDepositosAduanas = class(TDataModule)
    QTransitos: TQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const ADatos: integer ): boolean;
    procedure CerrarQuery;
  end;

var
  DLDepositosAduanas: TDLDepositosAduanas;

implementation

{$R *.dfm}

uses
  UDMAuxDB;

function TDLDepositosAduanas.AbrirQuery( const AEmpresa, ACentro: string;
                                         const AFechainicio, AFechafin: TDateTime;
                                         const ADatos: integer ): boolean;
begin
  with QTransitos do
  begin
    SQL.Clear;
    if ( ADatos = 0 ) or ( ADatos = 1 ) then
    begin
      SQL.Add(' select carpeta_deposito_tc carpeta, codigo_dac codigo, empresa_dac empresa, centro_dac centro, referencia_dac transito, fecha_dac fecha_transito, ');
      SQL.Add('        dvd_dac dvd, fecha_entrada_dda_dac fecha_entrada,  embarque_dac embarque, dua_exporta_dac dua_exporta, factura_dac factura, transporte_tc transporte, ');
      SQL.Add('        ( select descripcion_t from frf_transportistas where transporte_t = transporte_tc ) des_transporte, ');
      SQL.Add('        flete_dac + rappel_dac + manipulacion_dac + mercancia_dac + combustible_dac + seguridad_dac + frigorifico_dac importe_total ');
      SQL.Add(' from frf_depositos_aduana_c, frf_transitos_c ');
      SQL.Add(' where empresa_dac = :empresa ');
      SQL.Add(' and centro_dac = :centro ');
      SQL.Add(' and fecha_dac between :fechaini and :fechafin ');
      SQL.Add(' and empresa_tc = empresa_dac ');
      SQL.Add(' and centro_tc = centro_dac ');
      SQL.Add(' and referencia_tc = referencia_dac ');
      SQL.Add(' and fecha_tc = fecha_dac ');
    end;


    if ( ADatos = 0 )  then
    begin
      SQL.Add(' union ');
    end;

    if ( ADatos = 0 ) or ( ADatos = 2 ) then
    begin
      SQL.Add(' select carpeta_deposito_sc carpeta, codigo_dac codigo, empresa_dac empresa, centro_dac centro, referencia_dac transito, fecha_dac fecha_transito,');
      SQL.Add('         dvd_dac dvd, fecha_entrada_dda_dac fecha_entrada,  embarque_dac embarque, dua_exporta_dac dua_exporta, factura_dac factura, transporte_sc transporte,');
      SQL.Add('         ( select descripcion_t from frf_transportistas where transporte_t = transporte_sc ) des_transporte,');
      SQL.Add('         flete_dac + rappel_dac + manipulacion_dac + mercancia_dac + combustible_dac + seguridad_dac + frigorifico_dac importe_total');
      SQL.Add('  from frf_depositos_aduana_c, frf_salidas_c');
      SQL.Add('  where empresa_dac = :empresa ');
      SQL.Add('  and centro_dac = :centro ');
      SQL.Add('  and fecha_dac between :fechaini and :fechafin ');
      SQL.Add('  and empresa_sc = empresa_dac');
      SQL.Add('  and centro_salida_sc = centro_dac');
      SQL.Add('  and n_albaran_sc = referencia_dac');
      SQL.Add('  and fecha_sc = fecha_dac ');
    end;

    SQL.Add(' order by 1,2 ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDLDepositosAduanas.CerrarQuery;
begin
  QTransitos.Close;
end;

end.


