unit CDLSalidasDepositoPais;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLSalidasDepositoPais = class(TDataModule)
    QTransitos: TQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro, ATransito: string;
                         const AFechainicio, AFechafin: TDateTime;
                         var VKilos: real ): boolean;
    procedure CerrarQuery;
  end;

var
  DLSalidasDepositoPais: TDLSalidasDepositoPais;

implementation

{$R *.dfm}

uses
  UDMAuxDB;

function TDLSalidasDepositoPais.AbrirQuery( const AEmpresa, ACentro, ATransito: string;
                                            const AFechainicio, AFechafin: TDateTime;
                                            var VKilos: real ): boolean;
begin
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('     case when cliente_dal is not null then ');
    SQL.Add('            ( select pais_c from frf_clientes where empresa_c = empresa_dal and cliente_c = cliente_dal ) ');
    SQL.Add('          else ');
    SQL.Add('            ( select pais_c from frf_centros where empresa_c = empresa_dal and centro_c = centro_destino_dal ) ');
    SQL.Add('     end pais_dal, ');
    SQL.Add('        sum( kilos_das ) kilos_das ');

    SQL.Add(' from frf_depositos_aduana_c, frf_depositos_aduana_l, frf_depositos_aduana_sal ');
    SQL.Add(' where empresa_dac = :empresa ');
    SQL.Add(' and centro_dac = :centro ');
    SQL.Add(' and fecha_dac between :fechaini and :fechafin ');
    SQL.Add(' and codigo_dac = codigo_dal ');
    SQL.Add(' and codigo_dal = codigo_das ');
    SQL.Add(' and linea_dal = linea_das ');
    if ATransito <> '' then
      SQL.Add(' and referencia_dac = :transito ');

    SQL.Add(' group by 1 ');
    SQL.Add(' ORDER BY 1 ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    if ATransito <> '' then
      ParamByName('transito').AsInteger:= StrToIntDef ( ATransito, 0);

    Open;

    result:= not IsEmpty;
    VKilos:= 0;
    if result then
    begin
      while not Eof do
      begin
        VKilos:= VKilos + FieldByName( 'kilos_das' ).AsFloat;
        Next;
      end;
    end;
    First;
  end;
end;

procedure TDLSalidasDepositoPais.CerrarQuery;
begin
  QTransitos.Close;
end;

end.


