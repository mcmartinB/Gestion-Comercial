unit CDLTransitoSinDeposito;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLTransitoSinDeposito = class(TDataModule)
    QTransitos: TQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime ): boolean;
    procedure CerrarQuery;
  end;

var
  DLTransitoSinDeposito: TDLTransitoSinDeposito;

implementation

{$R *.dfm}

uses
  UDMAuxDB;

function TDLTransitoSinDeposito.AbrirQuery( const AEmpresa, ACentro: string;
                                       const AFechainicio, AFechafin: TDateTime ): boolean;
begin
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_tc, centro_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc, ');
    SQL.Add('         sum(kilos_tl) kilos_tc ');

    SQL.Add('  from frf_transitos_c, frf_transitos_l ');
    SQL.Add('  where empresa_tc = :empresa ');
    SQL.Add('  and centro_tc = :centro ');
    SQL.Add('  and fecha_tc between :fechaini and :fechafin ');
    SQL.Add('  and empresa_tl = empresa_tc ');
    SQL.Add('  and centro_tl = centro_tc ');
    SQL.Add('  and fecha_tl = fecha_tc ');
    SQL.Add('  and referencia_tl = referencia_tc ');

    SQL.Add('  and not exists ');
    SQL.Add('  ( ');
    SQL.Add('    select * ');
    SQL.Add('    from frf_depositos_aduana_c ');
    SQL.Add('    where empresa_dac = empresa_tc ');
    SQL.Add('    and centro_dac = centro_tc ');
    SQL.Add('    and fecha_dac = fecha_tc ');
    SQL.Add('    and referencia_dac = referencia_tc ');
    SQL.Add('  ) ');

    SQL.Add('  group by empresa_tc, centro_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc ');
    SQL.Add('  order by empresa_tc, centro_tc, fecha_tc, referencia_tc ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDLTransitoSinDeposito.CerrarQuery;
begin
  QTransitos.Close;
end;

end.


