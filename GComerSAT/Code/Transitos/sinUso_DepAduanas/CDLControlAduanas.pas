unit CDLControlAduanas;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLControlAduanas = class(TDataModule)
    QTransitos: TQuery;
    procedure QTransitosFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Private declarations }
    iControlTransitos, iControlSalidas: Integer;
  public
    { Public declarations }
    function AbrirQuery( const AEmpresa, ACentro, ATransito: string;
                         const AFechainicio, AFechafin: TDateTime;
                         const AControlTransitos, AControlSalidas: integer ): boolean;
    procedure CerrarQuery;
  end;

var
  DLControlAduanas: TDLControlAduanas;

implementation

{$R *.dfm}

uses
  UDMAuxDB;

function TDLControlAduanas.AbrirQuery( const AEmpresa, ACentro, ATransito: string;
                                       const AFechainicio, AFechafin: TDateTime;
                                       const AControlTransitos, AControlSalidas: integer ): boolean;
begin
  iControlTransitos:= AControlTransitos;
  iControlSalidas:= AControlSalidas;

  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_tc, centro_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc, ');
    SQL.Add('        codigo_dac, dvd_dac, fecha_entrada_dda_dac, embarque_dac, dua_exporta_dac, ');
    SQL.Add('        sum(kilos_tl) kilos_tc, ');
    SQL.Add('        ( select sum( kilos_dal) from frf_depositos_aduana_l where codigo_dal = codigo_dac ) kilos_dal, ');
    SQL.Add('        ( select sum( kilos_das) from frf_depositos_aduana_sal where codigo_das = codigo_dac ) kilos_das ');

    if ( AControlTransitos = 2 ) then
      SQL.Add(' from frf_transitos_c, frf_transitos_l, frf_depositos_aduana_c ')
    else
      SQL.Add(' from frf_transitos_c, frf_transitos_l, outer frf_depositos_aduana_c ');

    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc between :fechaini and :fechafin ');

    if ATransito <> '' then
      SQL.Add(' and referencia_tc = :transito');

    SQL.Add(' and empresa_tl = empresa_tc ');
    SQL.Add(' and centro_tl = centro_tc ');
    SQL.Add(' and fecha_tl = fecha_tc ');
    SQL.Add(' and referencia_tl = referencia_tc ');
    SQL.Add(' and empresa_dac = empresa_tc ');
    SQL.Add(' and centro_dac = centro_tc ');
    SQL.Add(' and fecha_dac = fecha_tc ');
    SQL.Add(' and referencia_dac = referencia_tc ');

    SQL.Add(' group by empresa_tc, centro_tc, referencia_tc, fecha_tc, transporte_tc, vehiculo_tc, buque_tc, puerto_tc, destino_tc, ');
    SQL.Add('          codigo_dac, dvd_dac, fecha_entrada_dda_dac, embarque_dac, dua_exporta_dac ');

    SQL.Add(' order by empresa_tc, centro_tc, fecha_tc, referencia_tc ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;

    if ATransito <> '' then
      ParamByName('transito').AsInteger:= StrToIntDef ( ATransito, 0);

    Filtered:= ( AControlTransitos = 1 ) or ( AControlSalidas > 0 );
    Open;

    result:= not IsEmpty;
  end;
end;

procedure TDLControlAduanas.CerrarQuery;
begin
  QTransitos.Filtered:= false;
  QTransitos.Close;
end;

procedure TDLControlAduanas.QTransitosFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if iControlTransitos = 1 then
    Accept:= DataSet.FieldByName('codigo_dac').AsString = '';
  if Accept and ( DataSet.FieldByName('codigo_dac').AsString <> '' ) then
  begin
    case iControlSalidas of
      1: Accept:= ( DataSet.FieldByName('kilos_dal').AsFloat <  DataSet.FieldByName('kilos_tc').AsFloat ) or
                  ( DataSet.FieldByName('kilos_das').AsFloat <  DataSet.FieldByName('kilos_dal').AsFloat );
      2: Accept:= DataSet.FieldByName('kilos_dal').AsFloat <  DataSet.FieldByName('kilos_tc').AsFloat;
      3: Accept:= DataSet.FieldByName('kilos_das').AsFloat <  DataSet.FieldByName('kilos_dal').AsFloat;
      4: Accept:= ( DataSet.FieldByName('kilos_das').AsFloat =  DataSet.FieldByName('kilos_dal').AsFloat );
      5: Accept:= ( DataSet.FieldByName('kilos_dal').AsFloat =  DataSet.FieldByName('kilos_tc').AsFloat ) and
                  ( DataSet.FieldByName('kilos_das').AsFloat =  DataSet.FieldByName('kilos_dal').AsFloat );
    end;
  end;
end;

end.


