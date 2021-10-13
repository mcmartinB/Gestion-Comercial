unit LiquidarEntradasSalidasPeriodoDM;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;

type
  TDMLiquidarEntradasSalidasPeriodo = class(TDataModule)
    qryEntradasSalidas: TQuery;
    kmtResumen: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sProducto, sCosechero: string;
    dFechaIni, dFechaFin: TDateTime;
    iTipo: Integer;
    bDefinitiva: Boolean;

    procedure LoadParametros(const AEmpresa, ACentro, AProducto: string;
                            const AFechaIni, AFechaFin: TDateTime; const ACosechero: string;
                            const ATipo: Integer; const ADefintiva: Boolean );
    procedure PreparaTablasTemporales;
    procedure CerrarTablasTemporales;
    function  HayDatosEntradas: Boolean;

    procedure ValorarEntradas;
    procedure ValorarEntrada;

    procedure GrabarEntrada( const ATipo: Integer; const AMsg: string );
    //function  GetError: string;

    procedure PrevisualizarResultado;
  public
    { Public declarations }
    function ValorarPendiente(const AEmpresa, ACentro, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime; const ACosechero: string;
                               const ATipo: Integer; const ADefintiva: Boolean  ): Boolean;
  end;

  function ValorarPendiente(const AEmpresa, ACentro, AProducto: string;
                           const AFechaIni, AFechaFin: TDateTime; const ACosechero:
                           string; const ATipo: Integer; const ADefintiva: Boolean  ): Boolean;

var
  DMLiquidarEntradasSalidasPeriodo: TDMLiquidarEntradasSalidasPeriodo;

implementation

{$R *.dfm}

uses
  Forms, LiquidarEntradasSalidasPeriodoQR, EntradasSalidasDM;

function ValorarPendiente(const AEmpresa, ACentro, AProducto: string; const AFechaIni, AFechaFin: TDateTime;
                          const ACosechero: string; const ATipo: Integer; const ADefintiva: Boolean  ): Boolean;
begin
  Application.CreateForm( TDMLiquidarEntradasSalidasPeriodo, DMLiquidarEntradasSalidasPeriodo );
  try
    Result:= DMLiquidarEntradasSalidasPeriodo.ValorarPendiente(AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, ACosechero, ATipo, ADefintiva );
  finally
    FreeAndNil( DMLiquidarEntradasSalidasPeriodo );
  end;
end;

procedure TDMLiquidarEntradasSalidasPeriodo.LoadParametros(const AEmpresa, ACentro, AProducto: string;
                           const AFechaIni, AFechaFin: TDateTime; const ACosechero: string; const ATipo: Integer;
                           const ADefintiva: Boolean  );
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  sCosechero:= ACosechero;

  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;

  iTipo:= ATipo;
  bDefinitiva:= ADefintiva;
end;

procedure TDMLiquidarEntradasSalidasPeriodo.PreparaTablasTemporales;
begin
  kmtResumen.FieldDefs.Clear;
  kmtResumen.FieldDefs.Add('status', ftInteger, 0, False);
  kmtResumen.FieldDefs.Add('empresa', ftString, 3, False);
  kmtResumen.FieldDefs.Add('centro', ftString, 3, False);
  kmtResumen.FieldDefs.Add('entrada', ftInteger, 0, False);
  kmtResumen.FieldDefs.Add('fecha', ftDate, 0, False);
  kmtResumen.FieldDefs.Add('producto', ftString, 3, False);

  kmtResumen.FieldDefs.Add('kilos_in', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('kilos_out', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('msg', ftString, 90, False);

  kmtResumen.CreateTable;
  kmtResumen.Open;
end;

function TDMLiquidarEntradasSalidasPeriodo.HayDatosEntradas: Boolean;
begin
  if qryEntradasSalidas.Active then
    qryEntradasSalidas.Close;

  qryEntradasSalidas.SQL.Clear;
  qryEntradasSalidas.SQL.Add(' select empresa_ec, centro_ec, numero_entrada_ec, fecha_ec, producto_ec, ');
  qryEntradasSalidas.SQL.Add(' sum( total_cajas_e2l) cajas, sum( total_kgs_e2l) kilos_in, ');
  qryEntradasSalidas.SQL.Add('        ( select sum(kilos_es) from  frf_entradas_sal ');
  qryEntradasSalidas.SQL.Add('          where empresa_ec = empresa_es and centro_ec = centro_entrada_es ');
  qryEntradasSalidas.SQL.Add('            and numero_entrada_ec = n_entrada_es and fecha_ec = fecha_entrada_es ');
  qryEntradasSalidas.SQL.Add('            and producto_ec = producto_es ) kilos_out ');
  qryEntradasSalidas.SQL.Add(' from frf_entradas_c ');
  qryEntradasSalidas.SQL.Add('      join frf_entradas2_l on empresa_ec = empresa_e2l and centro_ec = centro_e2l ');
  qryEntradasSalidas.SQL.Add('                              and numero_entrada_ec = numero_entrada_e2l and fecha_ec = fecha_e2l ');
  qryEntradasSalidas.SQL.Add(' where empresa_ec = :empresa ');
  qryEntradasSalidas.SQL.Add(' and centro_ec = :centro ');
  qryEntradasSalidas.SQL.Add(' and producto_ec = :producto ');
  qryEntradasSalidas.SQL.Add(' and fecha_ec between :fechaini and :fechafin ');
  if sCosechero <> '' then
    qryEntradasSalidas.SQL.Add(' and cosechero_e2l = :cosechero ');

  case iTipo of
    0: //pendientes
       begin
         //qryEntradasSalidas.SQL.Add(' and fecha_liquidacion_ec is null ');
         qryEntradasSalidas.SQL.Add(' and liquidacion_definitiva_ec = 0 ');
       end;
  end;
  qryEntradasSalidas.SQL.Add(' group by empresa_ec, centro_ec, numero_entrada_ec, fecha_ec, producto_ec, kilos_out ');
  qryEntradasSalidas.SQL.Add(' order by empresa_ec, centro_ec, numero_entrada_ec, fecha_ec, producto_ec ');


  qryEntradasSalidas.ParamByName('empresa').AsString:= sEmpresa;
  qryEntradasSalidas.ParamByName('centro').AsString:= sCentro;
  qryEntradasSalidas.ParamByName('producto').AsString:= sProducto;
  qryEntradasSalidas.ParamByName('fechaini').AsDateTime:= dFechaIni;
  qryEntradasSalidas.ParamByName('fechafin').AsDateTime:= dFechaFin;
  if sCosechero <> '' then
    qryEntradasSalidas.ParamByName('cosechero').AsString:= sCosechero;
  qryEntradasSalidas.Open;
  Result:= not qryEntradasSalidas.IsEmpty;
end;


procedure TDMLiquidarEntradasSalidasPeriodo.CerrarTablasTemporales;
begin
  kmtResumen.Close;
  qryEntradasSalidas.Close;
end;

function TDMLiquidarEntradasSalidasPeriodo.ValorarPendiente(const AEmpresa, ACentro, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime; const ACosechero: string;
                               const ATipo: Integer; const ADefintiva: Boolean  ): Boolean;
begin
  LoadParametros( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, ACosechero, ATipo, ADefintiva );
  PreparaTablasTemporales;
  if HayDatosEntradas then
  begin
    ValorarEntradas;
    PrevisualizarResultado;
    result:= True;
  end
  else
  begin
    result:= False;
  end;
  CerrarTablasTemporales;
end;

procedure TDMLiquidarEntradasSalidasPeriodo.ValorarEntradas;
begin
  qryEntradasSalidas.First;
  while not qryEntradasSalidas.Eof do
  begin
    ValorarEntrada;
    qryEntradasSalidas.Next;
  end;
end;

procedure TDMLiquidarEntradasSalidasPeriodo.ValorarEntrada;
var
  sMsg: string;
begin
  if qryEntradasSalidas.FieldByName('kilos_in').AsFloat <> qryEntradasSalidas.FieldByName('kilos_out').AsFloat then
  begin
    GrabarEntrada( -1, 'Falta asignar kilos de salida.' );
  end
  else
  begin
    if EntradasSalidasDM.ValorarEntradaEx( sEmpresa, sCentro,
              qryEntradasSalidas.FieldByName('fecha_ec').AsDateTime,
              qryEntradasSalidas.FieldByName('numero_entrada_ec').AsInteger, bDefinitiva, sMsg ) then
    begin
      GrabarEntrada( 0, sMsg );
    end
    else
    begin
      GrabarEntrada( 1, sMsg );
    end;
  end;
end;

procedure TDMLiquidarEntradasSalidasPeriodo.GrabarEntrada( const ATipo: Integer; const AMsg: string );
begin
  kmtResumen.Insert;
  kmtResumen.FieldByName('status').AsInteger:= ATipo;
  kmtResumen.FieldByName('empresa').AsString:= qryEntradasSalidas.FieldByName('empresa_ec').AsString;
  kmtResumen.FieldByName('centro').AsString:= qryEntradasSalidas.FieldByName('centro_ec').AsString;
  kmtResumen.FieldByName('entrada').AsInteger:= qryEntradasSalidas.FieldByName('numero_entrada_ec').AsInteger;
  kmtResumen.FieldByName('fecha').AsDateTime:= qryEntradasSalidas.FieldByName('fecha_ec').AsDateTime;
  kmtResumen.FieldByName('producto').AsString:= qryEntradasSalidas.FieldByName('producto_ec').AsString;
  kmtResumen.FieldByName('kilos_in').AsFloat:= qryEntradasSalidas.FieldByName('kilos_in').AsFloat;
  kmtResumen.FieldByName('kilos_out').AsFloat:= qryEntradasSalidas.FieldByName('kilos_out').AsFloat;
  kmtResumen.FieldByName('msg').AsString:= AMsg;
  kmtResumen.Post;
end;

procedure TDMLiquidarEntradasSalidasPeriodo.PrevisualizarResultado;
begin
  //kmtResumen.SortFields:=
  //kmtResumen.Sort([]);

  // sin asignat
  kmtResumen.Filter:= 'status = -1';
  kmtResumen.Filtered:= True;
  if not kmtResumen.IsEmpty then
    LiquidarEntradasSalidasPeriodoQR.ViewValorarPendiente( sEmpresa, sCentro, sProducto, dFechaIni, dFechaFin, sCosechero, -1 );

  kmtResumen.Filter:= 'status = 1';
  kmtResumen.Filtered:= True;
  if not kmtResumen.IsEmpty then
    LiquidarEntradasSalidasPeriodoQR.ViewValorarPendiente( sEmpresa, sCentro, sProducto, dFechaIni, dFechaFin, sCosechero, 1 );

  kmtResumen.Filter:= 'status = 0';
  kmtResumen.Filtered:= True;
  if not kmtResumen.IsEmpty then
    LiquidarEntradasSalidasPeriodoQR.ViewValorarPendiente( sEmpresa, sCentro, sProducto, dFechaIni, dFechaFin, sCosechero, 0 );
end;


procedure TDMLiquidarEntradasSalidasPeriodo.DataModuleCreate(
  Sender: TObject);
begin
(*
  with qryError do
  begin
    SQL.Clear;
    SQL.Add(' select nota_liquidacion_ec ');
    SQL.Add(' from frf_entradas_c ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_ec = :centro ');
    SQL.Add(' and fecha_ec = :fecha ');
    SQL.Add(' and numero_entrada_ec = :entrada ');
  end;
*)
end;

(*
function TDMLiquidarEntradasSalidasPeriodo.GetError: string;
begin
  with qryError do
  begin
    ParamByName('empresa').AsString:= qryEntradasSalidas.FieldByName('empresa_ec').AsString;
    ParamByName('centro').AsString:= qryEntradasSalidas.FieldByName('centro_ec').AsString;
    ParamByName('entrada').AsInteger:= qryEntradasSalidas.FieldByName('numero_entrada_ec').AsInteger;
    ParamByName('fecha').AsDateTime:= qryEntradasSalidas.FieldByName('fecha_ec').AsDateTime;
    Open;
    Result:= FieldByName('nota_liquidacion_ec').AsString;
    Close;
  end;
end;
*)


end.
