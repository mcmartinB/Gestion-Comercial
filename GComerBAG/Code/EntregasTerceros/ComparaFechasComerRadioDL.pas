unit ComparaFechasComerRadioDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLComparaFechasComerRadio = class(TDataModule)
    QDiferenciasFechas: TQuery;

  private
    { Private declarations }

  public
    { Public declarations }
    procedure DatosEntrega( const AEntrega, AProducto: string; const AStock: integer;
                            const AOrdenProducto: Boolean );
  end;

function ObtenerDatos( const AOwner: TComponent; const AEntrega, AProducto: string;
                       var   AEmpresa: string; var   AFechaIni, AFechaFin: TDateTime;
                       const AStock: integer; const AOrdenProducto: Boolean ): Boolean;
procedure CerrarTablas;

var
  DLComparaFechasComerRadio: TDLComparaFechasComerRadio;

implementation

{$R *.dfm}

uses variants, bMath;

function ObtenerDatos( const AOwner: TComponent; const AEntrega, AProducto: string;
                       var   AEmpresa: string; var   AFechaIni, AFechaFin: TDateTime;
                       const AStock: integer; const AOrdenProducto: Boolean ): Boolean;
begin
  DLComparaFechasComerRadio:= TDLComparaFechasComerRadio.Create( AOwner );
  with DLComparaFechasComerRadio do
  begin
    DatosEntrega( AEntrega, AProducto, AStock, AOrdenProducto );

    if AEntrega <> '' then
    begin
      QDiferenciasFechas.ParamByName('entrega').AsString:= AEntrega;
    end
    else
    begin
      QDiferenciasFechas.ParamByName('empresa').AsString:= AEmpresa;
      QDiferenciasFechas.ParamByName('fechaini').AsDateTime:= AFechaIni;
      QDiferenciasFechas.ParamByName('fechaFin').AsDateTime:= AFechaFin;
    end;

    if AProducto <> '' then
      QDiferenciasFechas.ParamByName('producto').AsString:= AProducto;

    QDiferenciasFechas.Open;
    result:= not QDiferenciasFechas.IsEmpty;
    if result and ( AEntrega <> '' ) then
    begin
      AEmpresa:= QDiferenciasFechas.FieldByName('empresa_ec').AsString;
      AFechaIni:= QDiferenciasFechas.FieldByName('fecha_llegada_ec').AsDateTime;
      AFechaFin:= AFechaIni;
    end;
  end;
end;

procedure CerrarTablas;
begin
  DLComparaFechasComerRadio.QDiferenciasFechas.Close;
  FreeAndNil( DLComparaFechasComerRadio );
end;

procedure TDLComparaFechasComerRadio.DatosEntrega( const AEntrega, AProducto: string; const AStock: integer;
                                                   const AOrdenProducto: Boolean );
begin
  with QDiferenciasFechas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ec, centro_llegada_ec, codigo_ec, producto, fecha_llegada_ec fecha_entrega, DATE(fecha_alta) fecha_palet ');
    SQL.Add(' from frf_entregas_c, rf_palet_pb ');
    if  AEntrega <> '' then
    begin
      SQL.Add(' where codigo_ec = :entrega ');
      SQL.Add(' and entrega = :entrega ');
    end
    else
    begin
      SQL.Add(' where codigo_ec = entrega ');
      SQL.Add(' and empresa_ec = :empresa ');
      SQL.Add(' and fecha_llegada_ec between :fechaini and :fechafin ');
    end;
    if AProducto <> '' then
    begin
      SQL.Add(' and  producto = :producto ');
    end;
    SQL.Add(' and DATE(fecha_alta) <> fecha_llegada_ec ');
    case AStock of
      1: SQL.Add(' and status = ''S'' ');
      2: SQL.Add(' and status <> ''S'' ');
    end;
    SQL.Add(' group by 1,2,3,4,5,6 ');

    SQL.Add(' union ');

    SQL.Add(' select empresa_ec, centro_llegada_ec, codigo_ec, producto, fecha_llegada_ec fecha_entrega, DATE(fecha_alta) fecha_palet ');
    SQL.Add(' from frf_entregas_c, rf_palet_pb ');
    if  AEntrega <> '' then
    begin
      SQL.Add(' where codigo_ec = :entrega ');
      SQL.Add(' and entrega = :entrega ');
    end
    else
    begin
      SQL.Add(' where codigo_ec = entrega ');
      SQL.Add(' and empresa_ec = :empresa ');
      SQL.Add(' and DATE(fecha_alta) between :fechaini and :fechafin ');
    end;
    if AProducto <> '' then
    begin
      SQL.Add(' and  producto = :producto ');
    end;
    SQL.Add(' and DATE(fecha_alta) <> fecha_llegada_ec ');
    case AStock of
      1: SQL.Add(' and status = ''S'' ');
      2: SQL.Add(' and status <> ''S'' ');
    end;
    SQL.Add(' group by 1,2,3,4,5,6 ');

    if AOrdenProducto then
      SQL.Add(' order by 4,3 ')
    else
      SQL.Add(' order by 3 ');
  end;
end;


end.
