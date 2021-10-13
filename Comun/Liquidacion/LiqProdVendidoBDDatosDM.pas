unit LiqProdVendidoBDDatosDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLiqProdVendidoBDDatos = class(TDataModule)
    qryAux: TQuery;
    qrySemana: TQuery;
    qryLiquidacion: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

    procedure SalvaCentroSemana;
    procedure BorrarBDSemana;
    procedure SaveSemana;
    procedure SaveLiquidacion;

    procedure BorrarMemSemana( const AKey: string );
    procedure CargaSemana;
    procedure CargaLiquidacion;

  public
    { Public declarations }
    procedure SalvaDatos( const ATodas: Boolean );
    function  CargaDatos( const AEmpresa, AProducto, ACentro: string; const ADesde, AHasta: TDateTime ): boolean;
  end;

var
  DMLiqProdVendidoBDDatos: TDMLiqProdVendidoBDDatos;

implementation

{$R *.dfm}

uses
  LiqProdVendidoDM, Dialogs, Variants, LiqProdErroresUnit;



procedure SincronizarRegistroEx( const AFuente, ADestino: TDataSet; const AALta: boolean );
var
  i: integer;
  campo: tField;
begin
  if AALta then
    ADestino.Insert
  else
    ADestino.Edit;

  i:= 0;
  while i < ADestino.Fields.Count do
  begin
    campo:= AFuente.FindField(ADestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      ADestino.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;

  try
    ADestino.Post;
  except
    on E: Exception do
    begin
      ShowMessage( e.Message );
      ADestino.Cancel;
    end;
  end;
end;

procedure SincronizarRegistro( const AFuente, ADestino: TDataSet  );
var
  bFlag: boolean;
begin
  bFlag:= ADestino.IsEmpty;
  SincronizarRegistroEx( AFuente, ADestino, bFlag );
end;

procedure NuevoRegistro( const AFuente, ADestino: TDataSet  );
var
  bNuevo: boolean;
begin
  bNuevo:= True;
  SincronizarRegistroEx( AFuente, ADestino, bNuevo );
end;

procedure TDMLiqProdVendidoBDDatos.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TDMLiqProdVendidoBDDatos.DataModuleCreate(Sender: TObject);
begin
//
  qrySemana.SQL.Clear;
  qrySemana.SQL.Add('select * from tliq_semanas where codigo = :codigo ');

  qryLiquidacion.SQL.Clear;
  qryLiquidacion.SQL.Add('select * from tliq_liquida_det where codigo_liq = :codigo ');
end;


procedure TDMLiqProdVendidoBDDatos.SalvaDatos( const ATodas: Boolean );
begin
  if ATodas then
  begin
    DMLiqProdVendido.kmtSemana.First;
    while not DMLiqProdVendido.kmtSemana.Eof do
    begin
      SalvaCentroSemana;
      DMLiqProdVendido.kmtSemana.Next;
    end;
  end
  else
  begin
    SalvaCentroSemana;
  end;
end;

procedure TDMLiqProdVendidoBDDatos.SalvaCentroSemana;
begin
  if not DMLiqProdVendido.kmtSemana.isEmpty then
  begin
    BorrarBDSemana;
    SaveSemana;
    GrabarErrores( DMLiqProdVendido.kmtSemana.FieldByname('codigo').AsInteger );
  end;
end;


procedure TDMLiqProdVendidoBDDatos.BorrarBDSemana;
var
  iCode: Integer;
begin
  qryAux.sql.Clear;
  qryAux.SQL.Add('select * from tliq_semanas where keySem  = :keySem ');
  qryAux.ParamByName('keySem').AsString:= DMLiqProdVendido.kmtSemana.FieldByname('keySem').AsString;
  qryAux.Open;

  if qryAux.IsEmpty then
  begin
    qryAux.Close;
  end
  else
  begin
    iCode:= qryAux.FieldByName('codigo').AsInteger;
    qryAux.Close;

    qryAux.sql.Clear;
    qryAux.SQL.Add('delete from tliq_liquida_det where codigo_liq  = :codigo ');
    qryAux.ParamByName('codigo').AsInteger:= iCode;
    qryAux.ExecSQL;

    BorrarErrores( iCode );

    qryAux.sql.Clear;
    qryAux.SQL.Add('delete from tliq_semanas where codigo  = :codigo ');
    qryAux.ParamByName('codigo').AsInteger:= iCode;
    qryAux.ExecSQL;
  end;
end;

procedure TDMLiqProdVendidoBDDatos.SaveSemana;
begin
  qrySemana.ParamByName('codigo').AsString:= DMLiqProdVendido.kmtSemana.FieldByname('codigo').AsString;
  qrySemana.Open;
  try
    SincronizarRegistro( DMLiqProdVendido.kmtSemana, qrySemana );
    SaveLiquidacion;
  finally
    qrySemana.Close;
  end;
end;

procedure TDMLiqProdVendidoBDDatos.SaveLiquidacion;
begin
  DMLiqProdVendido.kmtLiquidaDet.First;
  qryLiquidacion.ParamByName('codigo').AsString:= DMLiqProdVendido.kmtSemana.FieldByname('codigo').AsString;
  qryLiquidacion.Open;
  try
  while not DMLiqProdVendido.kmtLiquidaDet.Eof do
  begin
    NuevoRegistro( DMLiqProdVendido.kmtLiquidaDet, qryLiquidacion );
    DMLiqProdVendido.kmtLiquidaDet.Next;
  end;

  finally
    qryLiquidacion.Close;
  end;
end;

function  TDMLiqProdVendidoBDDatos.CargaDatos( const AEmpresa, AProducto, ACentro: string; const ADesde, AHasta: TDateTime ): boolean;
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('select codigo from tliq_semanas where empresa = :empresa and producto = :producto ');
  if ACentro <> '' then
  begin
    qryAux.SQL.Add('  and centro >= :centro ');
  end;
  qryAux.SQL.Add('  and fecha_ini >= :fechaini and fecha_fin <= :fechafin  ');

  qryAux.ParamByName('empresa').AsString:= AEmpresa;
  qryAux.ParamByName('producto').AsString:= AProducto;
  qryAux.ParamByName('fechaini').AsDateTime:= ADesde;
  qryAux.ParamByName('fechafin').AsDateTime:= AHasta;
  if ACentro <> '' then
  begin
    qryAux.ParamByName('centro').AsString:= ACentro;
  end;
  qryAux.Open;
  try
  result:= not qryAux.IsEmpty;
  if result then
  begin
    while not qryAux.Eof do
    begin
      CargaSemana;
      qryAux.Next;
    end;
    DMLiqProdVendido.kmtSemana.first;
  end;

  finally
    qryAux.Close;
  end;

end;

procedure TDMLiqProdVendidoBDDatos.CargaSemana;
begin
  qrySemana.ParamByName('codigo').AsString:= qryAux.FieldByname('codigo').AsString;
  qrySemana.Open;

  try

  if not qrySemana.IsEmpty then
  begin
    BorrarMemSemana( qrySemana.FieldByname('keySem').AsString );
    SincronizarRegistro( qrySemana, DMLiqProdVendido.kmtSemana );
    CargaLiquidacion;
  end;

  finally
    qrySemana.Close;
  end;
end;

procedure TDMLiqProdVendidoBDDatos.BorrarMemSemana( const AKey: string );
var
  iCode: Integer;
begin
  if DMLiqProdVendido.kmtSemana.active then
  begin
    if DMLiqProdVendido.kmtSemana.Locate( 'keySem', AKey, [] ) then
    begin
      iCode:= qrySemana.FieldByname('codigo').AsInteger;
      DMLiqProdVendido.kmtSemana.Delete;
      while DMLiqProdVendido.kmtLiquidaDet.Locate( 'codigo_liq', iCode, [] ) do
      begin
        DMLiqProdVendido.kmtLiquidaDet.Delete;
      end;
    end;
  end
  else
  begin
    DMLiqProdVendido.kmtSemana.Open;
    DMLiqProdVendido.kmtLiquidaDet.Open;
  end;
end;


procedure TDMLiqProdVendidoBDDatos.CargaLiquidacion;
begin
  qryLiquidacion.ParamByName('codigo').AsString:= qryAux.FieldByname('codigo').AsString;
  qryLiquidacion.Open;
  try
  while qryLiquidacion.Eof do
  begin
    NuevoRegistro( DMLiqProdVendido.kmtLiquidaDet, qryLiquidacion );
    qryLiquidacion.Next;
  end;

  finally
    qryLiquidacion.Close;
  end;
end;


end.
