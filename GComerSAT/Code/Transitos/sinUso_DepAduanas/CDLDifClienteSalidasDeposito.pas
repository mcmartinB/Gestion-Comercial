unit CDLDifClienteSalidasDeposito;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLDifClienteSalidasDeposito = class(TDataModule)
    QTransitos: TQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const ASinFactura: boolean ): boolean;
    procedure CerrarQuery;
  end;

var
  DLDifClienteSalidasDeposito: TDLDifClienteSalidasDeposito;

implementation

{$R *.dfm}

uses
  UDMAuxDB;

function TDLDifClienteSalidasDeposito.AbrirQuery( const AEmpresa, ACentro: string;
                                       const AFechainicio, AFechafin: TDateTime;
                                       const ASinFactura: boolean ): boolean;
begin
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_das empresa, centro_salida_das centro, n_albaran_das albaran, fecha_das fecha, ');
    SQL.Add('        ( select cliente_sal_sc from frf_salidas_c  where empresa_sc = empresa_das ');
    SQL.Add('             and centro_salida_sc = centro_salida_das and n_albaran_sc = n_albaran_das ');
    SQL.Add('             and fecha_sc = fecha_das  ) cliente_salida, ');
    SQL.Add('        cliente_dal cliente_deposito, referencia_dac transito, fecha_dac fecha_transito, centro_dac centro_transito ');

    SQL.Add('  from frf_depositos_aduana_c, frf_depositos_aduana_l, frf_depositos_aduana_sal ');

    SQL.Add('  where empresa_dac = :empresa ');
    SQL.Add('  and centro_dac = :centro ');
    SQL.Add('  and fecha_dac between :fechaini and :fechafin ');

    SQL.Add('  and codigo_dal = codigo_dac ');
    SQL.Add('  and centro_destino_dal is null  ');

    SQL.Add('  and codigo_das = codigo_dal ');
    SQL.Add('  and linea_das = linea_dal ');

    if ASinFactura then
      SQL.Add(' and n_factura_das = '''' ');

    SQL.Add('  and not exists ( select * from frf_salidas_c ');
    SQL.Add('  where empresa_sc = empresa_das ');
    SQL.Add('  and centro_salida_sc = centro_salida_das ');
    SQL.Add('  and n_albaran_sc = n_albaran_das ');
    SQL.Add('  and fecha_sc = fecha_das ');
    SQL.Add('  and cliente_sal_Sc = cliente_dal ');
    SQL.Add('   ) ');

    SQL.Add(' union ');

    SQL.Add(' select empresa_das empresa, centro_salida_das centro, n_albaran_das albaran, fecha_das fecha, ');
    SQL.Add('        ( select centro_destino_tc from frf_transitos_c  where empresa_tc = empresa_das ');
    SQL.Add('             and centro_tc = centro_salida_das and referencia_tc = n_albaran_das ');
    SQL.Add('             and fecha_tc = fecha_das  ) cliente_salida, ');
    SQL.Add('        centro_destino_dal cliente_deposito, referencia_dac transito, fecha_dac fecha_transito, centro_dac centro_transito ');

    SQL.Add('  from frf_depositos_aduana_c, frf_depositos_aduana_l, frf_depositos_aduana_sal ');

    SQL.Add('  where empresa_dac = :empresa ');
    SQL.Add('  and centro_dac = :centro ');
    SQL.Add('  and fecha_dac between :fechaini and :fechafin ');

    SQL.Add('  and codigo_dal = codigo_dac ');
    SQL.Add('  and cliente_dal is null ');

    SQL.Add('  and codigo_das = codigo_dal ');
    SQL.Add('  and linea_das = linea_dal ');

    if ASinFactura then
      SQL.Add(' and n_factura_das = '''' ');

    SQL.Add('  and not exists ( select * from frf_transitos_c ');
    SQL.Add('  where empresa_tc = empresa_das ');
    SQL.Add('  and centro_tc = centro_salida_das ');
    SQL.Add('  and referencia_tc = n_albaran_das ');
    SQL.Add('  and fecha_tc = fecha_das ');
    SQL.Add('  and centro_destino_tc = centro_destino_dal ');
    SQL.Add('   ) ');

    SQL.Add(' order by  fecha_das, n_albaran_das ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDLDifClienteSalidasDeposito.CerrarQuery;
begin
  QTransitos.Close;
end;

end.


