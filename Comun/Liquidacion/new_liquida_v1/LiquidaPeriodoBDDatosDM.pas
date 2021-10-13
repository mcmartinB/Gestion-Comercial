unit LiquidaPeriodoBDDatosDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMLiquidaPeriodoBDDatos = class(TDataModule)
    qryAux: TQuery;
    qrySemana: TQuery;
    qryEntradas: TQuery;
    qryCosecheros: TQuery;
    qryPlantaciones: TQuery;
    qryVentas: TQuery;
    qryInventarios: TQuery;
    qryTransitosSal: TQuery;
    qryTransitosEnt: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sKey: string;
    bModificar: Boolean;

    procedure SQLSalvaDatos;
    procedure SaveSemana;
    procedure SaveCosecheros;
    procedure SaveCosPlantaciones;
    procedure SaveVentas;
    procedure SaveEntradas;
    procedure SaveInventarios;
    procedure SaveTransitosSal;
    procedure SaveTransitosEnt;

    procedure SQLCargaDatos;
    procedure CargaSemana;
    procedure CargaCosecheros;
    procedure CargaPlantaciones;
    procedure CargaVentas;
    procedure CargaEntradas;
    procedure CargaInventarios;
    procedure CargaTransitosSal;
    procedure CargaTransitosEnt;
  public
    { Public declarations }
    procedure SalvaDatos;
    procedure SalvaSemana;
    procedure SalvaCentroSemana;
    function  CargaDatos( const AEmpresa, AProducto: string; const ADesde, AHasta: TDateTime ): boolean;
  end;

var
  DMLiquidaPeriodoBDDatos: TDMLiquidaPeriodoBDDatos;

implementation

{$R *.dfm}

uses
  LiquidaPeriodoDM, Dialogs, Variants;



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

procedure TDMLiquidaPeriodoBDDatos.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TDMLiquidaPeriodoBDDatos.DataModuleCreate(Sender: TObject);
begin
  //
end;

procedure TDMLiquidaPeriodoBDDatos.SQLSalvaDatos;
begin
  qrySemana.SQL.Clear;
  qrySemana.SQL.Add('select * from liq_semana where keysem = :keysem ');

  qryEntradas.SQL.Clear;
  qryEntradas.SQL.Add('select * from liq_entradas where keysem = :keysem ');

  qryVentas.SQL.Clear;
  qryVentas.SQL.Add('select * from liq_ventas where keysem = :keysem ');

  qryInventarios.SQL.Clear;
  qryInventarios.SQL.Add('select * from liq_inventarios where keysem = :keysem ');

  qryTransitosEnt.SQL.Clear;
  qryTransitosEnt.SQL.Add('select * from liq_transitos_ent where keysem = :keysem ');

  qryTransitosSal.SQL.Clear;
  qryTransitosSal.SQL.Add('select * from liq_transitos_sal where keysem = :keysem ');

  qryTransitosSal.SQL.Clear;
  qryTransitosSal.SQL.Add('select * from liq_transitos_sal where keysem = :keysem ');

  qryCosecheros.SQL.Clear;
  qryCosecheros.SQL.Add('select * from liq_cosechero where keysem = :keysem and cosechero = :cosechero ');

  qryPlantaciones.SQL.Clear;
  qryPlantaciones.SQL.Add('select * from liq_plantacion where keysem = :keysem and cosechero = :cosechero ');
  qryPlantaciones.SQL.Add('   and plantacion = :plantacion and semana_planta = :semana_planta ');
end;

procedure TDMLiquidaPeriodoBDDatos.SalvaDatos;
begin
  DMLiquidaPeriodo.kmtSemana.First;
  if not DMLiquidaPeriodo.kmtSemana.isEmpty then
  begin
    SQLSalvaDatos;
    while not DMLiquidaPeriodo.kmtSemana.Eof do
    begin
      SaveSemana;
      SaveCosecheros;
      SaveVentas;
      SaveEntradas;
      SaveInventarios;
      SaveTransitosSal;
      SaveTransitosEnt;
      DMLiquidaPeriodo.kmtSemana.Next;
    end;
  end;
end;

procedure TDMLiquidaPeriodoBDDatos.SalvaCentroSemana;
begin
  DMLiquidaPeriodo.kmtCentros.First;
  if not DMLiquidaPeriodo.kmtCentros.isEmpty then
  begin
    SQLSalvaDatos;
    while not DMLiquidaPeriodo.kmtCentros.Eof do
    begin
      if DMLiquidaPeriodo.kmtSemana.Locate('keysem',DMLiquidaPeriodo.kmtCentros.FieldByname('keysem').AsString,[] ) then
      begin
        SaveSemana;
        SaveCosecheros;
        SaveVentas;
        SaveEntradas;
        SaveInventarios;
        SaveTransitosSal;
        SaveTransitosEnt;
      end;
      DMLiquidaPeriodo.kmtCentros.Next;
    end;
  end;
end;

procedure TDMLiquidaPeriodoBDDatos.SalvaSemana;
begin
  if not DMLiquidaPeriodo.kmtSemana.isEmpty then
  begin
    SQLSalvaDatos;
    SaveSemana;
    SaveCosecheros;
    SaveVentas;
    SaveEntradas;
    SaveInventarios;
    SaveTransitosSal;
    SaveTransitosEnt;
  end;
end;

procedure TDMLiquidaPeriodoBDDatos.SaveSemana;
begin
  qrySemana.ParamByName('keysem').AsString:= DMLiquidaPeriodo.kmtSemana.FieldByname('keysem').AsString;
  qrySemana.Open;
  SincronizarRegistro( DMLiquidaPeriodo.kmtSemana, qrySemana );
  qrySemana.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.SaveEntradas;
begin
  qryEntradas.ParamByName('keysem').AsString:= DMLiquidaPeriodo.kmtEntradas.FieldByname('keysem').AsString;
  qryEntradas.Open;
  SincronizarRegistro( DMLiquidaPeriodo.kmtEntradas, qryEntradas );
  qryEntradas.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.SaveCosecheros;
begin
  (*TODO*)//Borrar antes
  DMLiquidaPeriodo.kmtCosechero.First;
  while not DMLiquidaPeriodo.kmtCosechero.Eof do
  begin
    qryCosecheros.ParamByName('keysem').AsString:= DMLiquidaPeriodo.kmtCosechero.FieldByname('keysem').AsString;
    qryCosecheros.ParamByName('cosechero').AsString:= DMLiquidaPeriodo.kmtCosechero.FieldByname('cosechero').AsString;
    qryCosecheros.Open;
    SincronizarRegistro( DMLiquidaPeriodo.kmtCosechero, qryCosecheros );
    qryCosecheros.Close;
    SaveCosPlantaciones;
    DMLiquidaPeriodo.kmtCosechero.Next;
  end;
end;

procedure TDMLiquidaPeriodoBDDatos.SaveCosPlantaciones;
begin
  DMLiquidaPeriodo.kmtPlantacion.First;
  while not DMLiquidaPeriodo.kmtPlantacion.Eof do
  begin
    qryPlantaciones.ParamByName('keysem').AsString:= DMLiquidaPeriodo.kmtPlantacion.FieldByname('keysem').AsString;
    qryPlantaciones.ParamByName('cosechero').AsString:= DMLiquidaPeriodo.kmtPlantacion.FieldByname('cosechero').AsString;
    qryPlantaciones.ParamByName('plantacion').AsString:= DMLiquidaPeriodo.kmtPlantacion.FieldByname('plantacion').AsString;
    qryPlantaciones.ParamByName('semana_planta').AsString:= DMLiquidaPeriodo.kmtPlantacion.FieldByname('semana_planta').AsString;
    qryPlantaciones.Open;
    SincronizarRegistro( DMLiquidaPeriodo.kmtPlantacion, qryPlantaciones );
    qryPlantaciones.Close;
    DMLiquidaPeriodo.kmtPlantacion.Next;
  end;

end;

procedure TDMLiquidaPeriodoBDDatos.SaveVentas;
begin
  qryVentas.ParamByName('keysem').AsString:= DMLiquidaPeriodo.kmtVentas.FieldByname('keysem').AsString;
  qryVentas.Open;
  SincronizarRegistro( DMLiquidaPeriodo.kmtVentas, qryVentas );
  qryVentas.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.SaveInventarios;
begin
  qryInventarios.ParamByName('keysem').AsString:= DMLiquidaPeriodo.kmtInventarios.FieldByname('keysem').AsString;
  qryInventarios.Open;
  SincronizarRegistro( DMLiquidaPeriodo.kmtInventarios, qryInventarios );
  qryInventarios.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.SaveTransitosSal;
begin
  qryTransitosSal.ParamByName('keysem').AsString:= DMLiquidaPeriodo.kmtTransitosOut.FieldByname('keysem').AsString;
  qryTransitosSal.Open;
  SincronizarRegistro( DMLiquidaPeriodo.kmtTransitosOut, qryTransitosSal );
  qryTransitosSal.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.SaveTransitosEnt;
begin
  qryTransitosEnt.ParamByName('keysem').AsString:= DMLiquidaPeriodo.kmtTransitosIn.FieldByname('keysem').AsString;
  qryTransitosEnt.Open;
  SincronizarRegistro( DMLiquidaPeriodo.kmtTransitosIn, qryTransitosEnt );
  qryTransitosEnt.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.SQLCargaDatos;
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('select keysem from liq_semana where empresa = :empresa and producto = :producto ');
  qryAux.SQL.Add('  and fecha_ini >= :fechaini and fecha_fin <= :fechafin  ');

  qrySemana.SQL.Clear;
  qrySemana.SQL.Add('select * from liq_semana where keysem = :keysem ');

  qryEntradas.SQL.Clear;
  qryEntradas.SQL.Add('select * from liq_entradas where keysem = :keysem ');

  qryEntradas.SQL.Clear;
  qryEntradas.SQL.Add('select * from liq_entradas where keysem = :keysem ');

  qryVentas.SQL.Clear;
  qryVentas.SQL.Add('select * from liq_ventas where keysem = :keysem ');

  qryInventarios.SQL.Clear;
  qryInventarios.SQL.Add('select * from liq_inventarios where keysem = :keysem ');

  qryTransitosEnt.SQL.Clear;
  qryTransitosEnt.SQL.Add('select * from liq_transitos_ent where keysem = :keysem ');

  qryTransitosSal.SQL.Clear;
  qryTransitosSal.SQL.Add('select * from liq_transitos_sal where keysem = :keysem ');

  qryTransitosSal.SQL.Clear;
  qryTransitosSal.SQL.Add('select * from liq_transitos_sal where keysem = :keysem ');

  qryCosecheros.SQL.Clear;
  qryCosecheros.SQL.Add('select * from liq_cosechero where keysem = :keysem  ');

  qryPlantaciones.SQL.Clear;
  qryPlantaciones.SQL.Add('select * from liq_plantacion where keysem = :keysem  ');
end;

function  TDMLiquidaPeriodoBDDatos.CargaDatos( const AEmpresa, AProducto: string; const ADesde, AHasta: TDateTime ): boolean;
begin
  SQLCargaDatos;

  qryAux.ParamByName('empresa').AsString:= AEmpresa;
  qryAux.ParamByName('producto').AsString:= AProducto;
  qryAux.ParamByName('fechaini').AsDateTime:= ADesde;
  qryAux.ParamByName('fechafin').AsDateTime:= AHasta;
  qryAux.Open;

  if not qryAux.IsEmpty then
  begin
    DMLiquidaPeriodo.AbrirTablas;
    result:= True;
    while not qryAux.Eof do
    begin
      CargaSemana;
      CargaCosecheros;
      CargaPlantaciones;
      CargaVentas;
      CargaEntradas;
      CargaInventarios;
      CargaTransitosSal;
      CargaTransitosEnt;
      qryAux.Next;
    end;
    DMLiquidaPeriodo.kmtSemana.first;
  end
  else
  begin
    result:= False;
  end;
  qryAux.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.CargaSemana;
var
  bFlag: Boolean;
begin
  qrySemana.ParamByName('keysem').AsString:= qryAux.FieldByname('keysem').AsString;
  bFlag:= DMLiquidaPeriodo.kmtSemana.Locate( 'keysem', qryAux.FieldByname('keysem').AsString, [] );
  qrySemana.Open;
  SincronizarRegistroEx( qrySemana, DMLiquidaPeriodo.kmtSemana, not bFlag );
  qrySemana.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.CargaEntradas;
var
  bFlag: Boolean;
begin
  qryEntradas.ParamByName('keysem').AsString:= qryAux.FieldByname('keysem').AsString;
  bFlag:= DMLiquidaPeriodo.kmtEntradas.Locate( 'keysem', qryAux.FieldByname('keysem').AsString, [] );
  qryEntradas.Open;
  SincronizarRegistroEx( DMLiquidaPeriodo.kmtEntradas, qryEntradas, not bFlag );
  qryEntradas.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.CargaCosecheros;
var
  bFlag: Boolean;
begin
  qryCosecheros.ParamByName('keysem').AsString:= qryAux.FieldByname('keysem').AsString;
  qryCosecheros.Open;

  while not qryCosecheros.Eof do
  begin
    bFlag:= DMLiquidaPeriodo.kmtCosechero.Locate( 'keysem;cosechero',
       varArrayOf([qryCosecheros.FieldByname('keysem').AsString,qryCosecheros.FieldByname('cosechero').AsString]), [] );
    SincronizarRegistroEx( qryCosecheros, DMLiquidaPeriodo.kmtCosechero, not bFlag );
    qryCosecheros.Next;
  end;
  qryCosecheros.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.CargaPlantaciones;
var
  bFlag: Boolean;
begin
  qryPlantaciones.ParamByName('keysem').AsString:= qryAux.FieldByname('keysem').AsString;
  qryPlantaciones.Open;

  while not qryPlantaciones.Eof do
  begin
    bFlag:= DMLiquidaPeriodo.kmtPlantacion.Locate( 'keysem;cosechero;plantacion;semana_planta',
       varArrayOf([qryPlantaciones.FieldByname('keysem').AsString,qryPlantaciones.FieldByname('cosechero').AsString,
                   qryPlantaciones.FieldByname('plantacion').AsString,qryPlantaciones.FieldByname('semana_planta').AsString] ), [] );
    SincronizarRegistroEx( qryPlantaciones, DMLiquidaPeriodo.kmtPlantacion, not bFlag );
    qryPlantaciones.Next;
  end;
  qryPlantaciones.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.CargaVentas;
var
  bFlag: Boolean;
begin
  qryVentas.ParamByName('keysem').AsString:= qryAux.FieldByname('keysem').AsString;
  qryVentas.Open;
  bFlag:= DMLiquidaPeriodo.kmtVentas.Locate( 'keysem', qryAux.FieldByname('keysem').AsString, [] );
  SincronizarRegistroEx( qryVentas, DMLiquidaPeriodo.kmtVentas, not bFlag );
  qryVentas.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.CargaInventarios;
var
  bFlag: Boolean;
begin
  qryInventarios.ParamByName('keysem').AsString:= qryAux.FieldByname('keysem').AsString;
  qryInventarios.Open;
  bFlag:= DMLiquidaPeriodo.kmtInventarios.Locate( 'keysem', qryAux.FieldByname('keysem').AsString, [] );
  SincronizarRegistroEx( qryInventarios, DMLiquidaPeriodo.kmtInventarios, not bFlag );
  qryInventarios.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.CargaTransitosSal;
var
  bFlag: Boolean;
begin
  qryTransitosSal.ParamByName('keysem').AsString:= qryAux.FieldByname('keysem').AsString;
  qryTransitosSal.Open;
  bFlag:= DMLiquidaPeriodo.kmtTransitosOut.Locate( 'keysem', qryAux.FieldByname('keysem').AsString, [] );
  SincronizarRegistroEx( qryTransitosSal, DMLiquidaPeriodo.kmtTransitosOut, not bFlag );
  qryTransitosSal.Close;
end;

procedure TDMLiquidaPeriodoBDDatos.CargaTransitosEnt;
var
  bFlag: Boolean;
begin
  qryTransitosEnt.ParamByName('keysem').AsString:= qryAux.FieldByname('keysem').AsString;
  qryTransitosEnt.Open;
  bFlag:= DMLiquidaPeriodo.kmtTransitosIn.Locate( 'keysem', qryAux.FieldByname('keysem').AsString, [] );
  SincronizarRegistroEx( qryTransitosEnt, DMLiquidaPeriodo.kmtTransitosIn, not bFlag );
  qryTransitosEnt.Close;
end;

end.
