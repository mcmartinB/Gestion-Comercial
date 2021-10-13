unit LiqAsignaTransitosMD;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLiqAsignaTransitos = class(TDataModule)
    qryKilosTransitos: TQuery;
    qrySalidasTransitos: TQuery;
    qryCambiaSalidas: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    bCategoria: boolean;
    dFechaIni, dFechaFin: TDateTime;
    rKilosTotales, rKilosPendientes: real;

    procedure AsignarKilosTransitosEx;
    function  HayTransitos: boolean;
    procedure SqlCambiaSalidas;
    function  HaySalidas: boolean;
    function  AsignaTransito: real;
    procedure DesAsignaTransito;
    function  PutEsTransito: real;
    procedure  PutNoEsTransito;
  public
    { Public declarations }
    procedure AsignarKilosTransitos( const AFechaIni, AFechaFin: TDateTime );
  end;

  procedure AsignarKilosTransitos( const AFechaIni, AFechaFin: TDateTime );

var
  DMLiqAsignaTransitos: TDMLiqAsignaTransitos;

implementation

{$R *.dfm}

uses
  Forms;

procedure AsignarKilosTransitos( const AFechaIni, AFechaFin: TDateTime );
begin
  Application.CreateForm( TDMLiqAsignaTransitos, DMLiqAsignaTransitos);
  try
    DMLiqAsignaTransitos.AsignarKilosTransitos( AFechaIni, AFechaFin );
  finally
    FreeAndNil( DMLiqAsignaTransitos );
  end;
end;

procedure TDMLiqAsignaTransitos.DataModuleCreate(Sender: TObject);
begin
  //TOTALES
  qryKilosTransitos.SQL.Clear;
  qryKilosTransitos.SQL.Add(' select empresa_ent, centro_origen_ent, producto_ent, categoria_ent, ');
  qryKilosTransitos.SQL.Add(' sum(kilos_liq) kilos ');
  qryKilosTransitos.SQL.Add(' from tliq_liquida_det ');
  qryKilosTransitos.SQL.Add(' where origen_ent =  ''T'' ');
  qryKilosTransitos.SQL.Add(' and fecha_origen_ent between :fechaini and :fechafin ');
  qryKilosTransitos.SQL.Add(' group by empresa_ent, centro_origen_ent, producto_ent, categoria_ent ');
  qryKilosTransitos.SQL.Add(' order by empresa_ent, centro_origen_ent, producto_ent, categoria_ent ');

  //DETALLE TRANSITO
  qrySalidasTransitos.SQL.Clear;
  qrySalidasTransitos.SQL.Add(' select empresa_ent, centro_sal, n_salida, fecha_sal, producto_ent, categoria_ent, sum(kilos_liq) kilos ');
  qrySalidasTransitos.SQL.Add(' from tliq_liquida_det ');
  qrySalidasTransitos.SQL.Add(' where origen_ent =  ''T'' ');
  qrySalidasTransitos.SQL.Add(' and fecha_origen_ent between :fechaini and :fechafin ');
  qrySalidasTransitos.SQL.Add(' and empresa_ent = :empresa ');
  qrySalidasTransitos.SQL.Add(' and centro_origen_ent = :centro ');
  qrySalidasTransitos.SQL.Add(' and producto_ent = :producto ');
  qrySalidasTransitos.SQL.Add(' and categoria_ent = :categoria ');
  qrySalidasTransitos.SQL.Add(' group by empresa_ent, centro_sal, n_salida, fecha_sal, producto_ent, categoria_ent ');
  qrySalidasTransitos.SQL.Add(' order by empresa_ent, centro_sal, n_salida, fecha_sal, producto_ent, categoria_ent ');

  //SALIDAS
  qryCambiaSalidas.SQL.Clear;
  qryCambiaSalidas.SQL.Add(' select * ');
  qryCambiaSalidas.SQL.Add(' from frf_salidas_l ');
  qryCambiaSalidas.SQL.Add(' where empresa_sl = :empresa ');
  qryCambiaSalidas.SQL.Add(' and centro_salida_sl = :centro ');
  qryCambiaSalidas.SQL.Add(' and fecha_sl = :fecha ');
  qryCambiaSalidas.SQL.Add(' and n_albaran_sl = :albaran ');
  qryCambiaSalidas.SQL.Add(' and producto_sl = :producto ');
  qryCambiaSalidas.SQL.Add(' and categoria_sl = :categoria ');
  //qryCambiaSalidas.SQL.Add(' and categoria_sl not in (''1'',''2'',''3'') ');
  bCategoria:= True;
end;

procedure TDMLiqAsignaTransitos.AsignarKilosTransitos( const AFechaIni, AFechaFin: TDateTime );
begin
  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;
  if HayTransitos then
  begin
    while not qryKilosTransitos.Eof do
    begin
      SqlCambiaSalidas;
      AsignarKilosTransitosEx;
      qryKilosTransitos.Next;
    end;
  end;
  qryKilosTransitos.Close;
end;

procedure TDMLiqAsignaTransitos.SqlCambiaSalidas;
begin
  qryCambiaSalidas.SQL.Clear;
  qryCambiaSalidas.SQL.Add(' select * ');
  qryCambiaSalidas.SQL.Add(' from frf_salidas_l ');
  qryCambiaSalidas.SQL.Add(' where empresa_sl = :empresa ');
  qryCambiaSalidas.SQL.Add(' and centro_salida_sl = :centro ');
  qryCambiaSalidas.SQL.Add(' and fecha_sl = :fecha ');
  qryCambiaSalidas.SQL.Add(' and n_albaran_sl = :albaran ');
  qryCambiaSalidas.SQL.Add(' and producto_sl = :producto ');
  if ( qryKilosTransitos.FieldByName('categoria_ent').AsString = '1' ) or
     ( qryKilosTransitos.FieldByName('categoria_ent').AsString = '2' ) or
     ( qryKilosTransitos.FieldByName('categoria_ent').AsString = '3' ) then
  begin
    qryCambiaSalidas.SQL.Add(' and categoria_sl = :categoria ');
    bCategoria:= True;
  end
  else
  begin
    qryCambiaSalidas.SQL.Add(' and categoria_sl <> ''1'' ');
    qryCambiaSalidas.SQL.Add(' and categoria_sl <> ''2'' ');
    qryCambiaSalidas.SQL.Add(' and categoria_sl <> ''3'' ');
    bCategoria:= False;
  end;
end;

function TDMLiqAsignaTransitos.HayTransitos: boolean;
begin
  qryKilosTransitos.ParamByName('fechaini').AsDateTime:= dFechaIni;
  qryKilosTransitos.ParamByName('fechafin').AsDateTime:= dFechaFin;
  qryKilosTransitos.Open;
  result:= not qryKilosTransitos.IsEmpty;
end;

procedure TDMLiqAsignaTransitos.AsignarKilosTransitosEx;
var
  rAux: real;
begin
  rKilosTotales:= qryKilosTransitos.FieldByName('kilos').AsFloat;
  rKilosPendientes:= rKilosTotales;

  if HaySalidas then
  begin
    while not qrySalidasTransitos.eof do
    begin
      if rKilosPendientes > 0 then
      begin
        rAux:= AsignaTransito;
        rKilosPendientes:= rKilosPendientes - rAux;
      end
      else
        DesAsignaTransito;
      qrySalidasTransitos.Next;
    end;
  end;
  qrySalidasTransitos.Close;
end;

function TDMLiqAsignaTransitos.HaySalidas: boolean;
begin
  qrySalidasTransitos.ParamByName('empresa').AsString:= qryKilosTransitos.FieldByName('empresa_ent').AsString;
  qrySalidasTransitos.ParamByName('fechaini').AsDateTime:= dFechaIni;
  qrySalidasTransitos.ParamByName('fechafin').AsDateTime:= dFechaFin;
  qrySalidasTransitos.ParamByName('centro').AsString:= qryKilosTransitos.FieldByName('centro_origen_ent').AsString;
  qrySalidasTransitos.ParamByName('producto').AsString:= qryKilosTransitos.FieldByName('producto_ent').AsString;
  qrySalidasTransitos.ParamByName('categoria').AsString:= qryKilosTransitos.FieldByName('categoria_ent').AsString;
  qrySalidasTransitos.Open;
  result:= not qrySalidasTransitos.isEmpty;
end;

function  TDMLiqAsignaTransitos.AsignaTransito: real;
var
  rAux, rKilos: real;
begin
  rKilos:= qrySalidasTransitos.FieldByName('kilos').AsFloat;
  result:= 0;

  qryCambiaSalidas.ParamByName('empresa').AsString:= qrySalidasTransitos.FieldByName('empresa_ent').AsString;
  qryCambiaSalidas.ParamByName('fecha').AsDateTime:= qrySalidasTransitos.FieldByName('fecha_sal').AsDateTime;
  qryCambiaSalidas.ParamByName('albaran').AsInteger:= qrySalidasTransitos.FieldByName('n_salida').AsInteger;
  qryCambiaSalidas.ParamByName('centro').AsString:= qrySalidasTransitos.FieldByName('centro_sal').AsString;
  qryCambiaSalidas.ParamByName('producto').AsString:= qrySalidasTransitos.FieldByName('producto_ent').AsString;
  if bCategoria then
    qryCambiaSalidas.ParamByName('categoria').AsString:= qrySalidasTransitos.FieldByName('categoria_ent').AsString;

  qryCambiaSalidas.Open;
  while not qryCambiaSalidas.Eof  do
  begin
    if rKilos > 0 then
    begin
       rAux:= PutEsTransito;
       result:= result + rAux;
       rKilos:= rKilos - rAux;
    end
    else
    begin
       PutNoEsTransito;
    end;
    qryCambiaSalidas.Next;
  end;
  qryCambiaSalidas.Close;
end;

procedure TDMLiqAsignaTransitos.DesAsignaTransito;
begin
  qryCambiaSalidas.ParamByName('empresa').AsString:= qrySalidasTransitos.FieldByName('empresa_ent').AsString;
  qryCambiaSalidas.ParamByName('fecha').AsDateTime:= qrySalidasTransitos.FieldByName('fecha_sal').AsDateTime;
  qryCambiaSalidas.ParamByName('albaran').AsInteger:= qrySalidasTransitos.FieldByName('n_salida').AsInteger;
  qryCambiaSalidas.ParamByName('centro').AsString:= qrySalidasTransitos.FieldByName('centro_sal').AsString;
  qryCambiaSalidas.ParamByName('producto').AsString:= qrySalidasTransitos.FieldByName('producto_ent').AsString;
  if bCategoria then
    qryCambiaSalidas.ParamByName('categoria').AsString:= qrySalidasTransitos.FieldByName('categoria_ent').AsString;

  qryCambiaSalidas.Open;
  while not qryCambiaSalidas.Eof  do
  begin
    PutNoEsTransito;
    qryCambiaSalidas.Next;
  end;
  qryCambiaSalidas.Close;
end;

procedure TDMLiqAsignaTransitos.PutNoEsTransito;
begin
  qryCambiaSalidas.Edit;
  qryCambiaSalidas.FieldByName('centro_origen_sl').AsString:= qryCambiaSalidas.FieldByName('centro_salida_sl').AsString;
  qryCambiaSalidas.Post;
end;

function TDMLiqAsignaTransitos.PutEsTransito: real;
begin
  if qryCambiaSalidas.FieldByName('centro_origen_sl').AsString <> qryKilosTransitos.FieldByName('centro_origen_ent').AsString then
  begin
    qryCambiaSalidas.Edit;
    qryCambiaSalidas.FieldByName('centro_origen_sl').AsString:= qryKilosTransitos.FieldByName('centro_origen_ent').AsString;
    qryCambiaSalidas.Post;
  end;
  result:= qryCambiaSalidas.FieldByName('kilos_sl').AsFloat;
end;

end.
