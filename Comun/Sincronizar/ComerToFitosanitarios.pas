unit ComerToFitosanitarios;

interface

uses
  SysUtils, Classes, DB, ADODB, DBTables;

type
  TDMComerToFitosanitarios = class(TDataModule)
    qryPlantacion: TQuery;
    conFito: TADOConnection;
    qrySelectUE: TADOQuery;
    qryInsertUE: TADOQuery;
    qryCodigoUE: TADOQuery;
    qryTipoCultivo: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sProducto, sCosechero, sPlantacion, sAnyoSemana: string;
    //sCodePlanta: string;
    sQryTipoCultivo, sQryInsertUE, sQrySelectUE: string;

    procedure PutParams( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana: string );
    function  SincronizarPlantaciones: Boolean;
    procedure SQLOrigen;
    procedure SQLDestino;
    function  GetCodePlanta: string;
    function  GetFechaIniPlanta: TDateTime;
    procedure CopiarDatos;
    function  InsertUE: Boolean;
    function  EditUE: Boolean;
    procedure SQLInsertUE;
    procedure SQLEditUE;
    function  GetCode: Integer;
    function  GetTipoCultivo: Integer;
  public
    { Public declarations }
    function Sincronizar( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana: string ): boolean;

  end;

  function Sincronizar( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana: string ): boolean;


implementation

{$R *.dfm}

uses
  Forms, Variants, CMySQL;

var
  DMComerToFitosanitarios: TDMComerToFitosanitarios;


function Sincronizar( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana: string ): boolean;
begin
  Application.CreateForm( TDMComerToFitosanitarios, DMComerToFitosanitarios );
  try
    result:= DMComerToFitosanitarios.Sincronizar( AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana );
  finally
    FreeAndNil( DMComerToFitosanitarios );
  end;
end;

procedure TDMComerToFitosanitarios.DataModuleCreate(Sender: TObject);
begin
  with qryCodigoUE do
  begin
    SQL.Clear;
    SQL.Add(' select max(id_campo) id_campo');
    SQL.Add(' from campo ');
  end;

  sQryTipoCultivo:='select id_tipo_cultivo from tipo_cultivo where tipo_cultivo = :pcultivo ';
  (*
  with qryTipoCultivo  do
  begin
    SQL.Clear;
    SQL.Add('select id_tipo_cultivo');
    SQL.Add('from tipo_cultivo');
    SQL.Add('where tipo_cultivo = :pcultivo');
  end;
  *)
end;

function TDMComerToFitosanitarios.Sincronizar( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana: string ): boolean;
begin
  //abrir bd fitosanitarios
  try
    conFito.Connected:= True;
    PutParams( AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana );
    Result:= SincronizarPlantaciones;
  finally
    conFito.Connected:= False;
  end;
end;

procedure TDMComerToFitosanitarios.PutParams( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana: string );
begin
   sEmpresa:= AEmpresa;
   sProducto:= AProducto;
   sCosechero:= ACosechero;
   sPlantacion:= APlantacion;
   sAnyoSemana:= AAnyoSemana;
end;

procedure TDMComerToFitosanitarios.SQLOrigen;
begin
  with qryPlantacion do
  begin
    SQL.Clear;
    SQL.Add(' select ');

    //SQL.Add('        Trim( cast( trim(empresa_p || ''-'' || case when cosechero_p < 10 then ''0'' || cosechero_p else cast(cosechero_p as char(3) )end) || ');
    //SQL.Add('        trim(case when plantacion_p < 10 then ''0'' || plantacion_p else cast(plantacion_p as char(3) )end)  || ''-'' ||');
    //SQL.Add('        producto_p || ano_semana_p as char(18) ) ) codigo, ');

    SQL.Add('        Trim( case when cosechero_p  < 10 then ''0'' || cosechero_p  else cast(cosechero_p  as char(3) )end ) || ');
    SQL.Add('        Trim( case when plantacion_p < 10 then ''0'' || plantacion_p else cast(plantacion_p as char(3) )end ) codigo, ');

    SQL.Add('        descripcion_p unidad_explotacion, ');
    SQL.Add('        federacion_p, (select provincia_f from frf_federaciones where codigo_f = federacion_p ) zona, ');
    SQL.Add('        (select case ');
    SQL.Add('                    when descripcion_p like ''%BERENJENA%'' then ''BERENJENA'' ');
    SQL.Add('                    when descripcion_p like ''%GRANADA%'' then ''GRANADA'' ');
    SQL.Add('                    when descripcion_p like ''%MELON%'' then ''MELON'' ');
    SQL.Add('                    when descripcion_p like ''%PEPINO%'' then ''PEPINO'' ');
    SQL.Add('                    when descripcion_p like ''%PIMIENTO%'' then ''PIMIENTO'' ');
    SQL.Add('                    when descripcion_p like ''%TOMATE%'' then ''TOMATE'' ');
    SQL.Add('                    when descripcion_p like ''%CALABACIN%'' then ''CALABACIN'' ');
    SQL.Add('                    when descripcion_p like ''%PLATANO%'' then ''PLATANO'' ');
    SQL.Add('                    when descripcion_p like ''%PAPAYA%'' then ''PLATANO'' ');
    SQL.Add('                    when descripcion_p like ''%MANGO%'' then ''MANGO'' ');
    SQL.Add('                    else descripcion_p ');
    SQL.Add('                end producto ');
    SQL.Add('          from frf_productos pro ');
    SQL.Add('          where pro.producto_p = pla.producto_p ) tipo_cultivo, ');
    SQL.Add('         superficie_p superficie, fecha_ini_planta_p inicio_plantacion, ');
    SQL.Add('         fecha_inicio_p inicio_recoleccion,  fecha_fin_p fin_recoleccion ');
    SQL.Add(' from frf_plantaciones pla ');
    SQL.Add(' where empresa_p = :empresa ');
    SQL.Add(' and producto_p = :producto ');
    SQL.Add(' and cosechero_p = :cosechero ');
    SQL.Add(' and plantacion_p = :plantacion ');
    SQL.Add(' and ano_semana_p = :semana ');

    ParamByname('empresa').AsString:= sEmpresa;
    ParamByname('producto').AsString:= sProducto;
    ParamByname('cosechero').AsString:= sCosechero;
    ParamByname('plantacion').AsString:= sPlantacion;
    ParamByname('semana').AsString:= sAnyoSemana;


  end;
end;

function TDMComerToFitosanitarios.SincronizarPlantaciones: Boolean;
begin
  SQLOrigen;
  qryPlantacion.Open;
  try
    if not qryPlantacion.IsEmpty then
    begin
      SQLDestino;
      CopiarDatos;
      Result:= True;
    end
    else
    begin
      Result:= False;
    end;
  finally
    qryPlantacion.Close;
  end;
end;



function TDMComerToFitosanitarios.GetCodePlanta: string;
begin
  Result:= qryPlantacion.FieldByName('codigo').AsString;
end;

function TDMComerToFitosanitarios.GetFechaIniPlanta: TDateTime;
begin
  Result:= qryPlantacion.FieldByName('inicio_plantacion').AsDateTime;
end;


procedure TDMComerToFitosanitarios.CopiarDatos;
var
  sAux: string;
begin
  sAux:= MySqlSParam( sqrySelectUE, ':pcodigo', GetCodePlanta );
  sAux:= MySqlDParam( sAux, ':pfecha_ini_plantacion', GetFechaIniPlanta );
  sAux:= MySqlIParam( sAux, ':ptipo_cultivo', GetTipoCultivo );

  qrySelectUE.SQL.Clear;
  qrySelectUE.SQL.Add( sAux );
  //qrySelectUE.SQL.SaveToFile('c:\temp\pepe.sql');
  //qrySelectUE.Parameters.ParamByname('pcodigo').Value:= GetCodePlanta;
  qrySelectUE.Open;
  try
    if qrySelectUE.IsEmpty then
    begin
      InsertUE;
    end
    else
    begin
      EditUE;
    end;
  finally
    qrySelectUE.Close;
  end;
end;

procedure TDMComerToFitosanitarios.SQLDestino;
begin
  sQrySelectUE:= 'select id_campo, nombre, codigo, zona, id_tipo_cultivo, tipo_cultivo, fecha_ini_plantacion, ' +
    '     fecha_ini_recoleccion, fecha_fin_recoleccion, superficie, eliminado ' +
    ' from campo where codigo = :pcodigo and tipo_cultivo = :ptipo_cultivo and fecha_ini_plantacion = :pfecha_ini_plantacion';
end;

procedure TDMComerToFitosanitarios.SQLInsertUE;
begin
  sQryInsertUE:= ' insert into campo values ( :pid_campo, :pnombre, :pcodigo, :pzona, :pid_tipo_cultivo, :ptipo_cultivo,  ';
  if qryPlantacion.FieldByName('inicio_plantacion').value = null then
  begin
    sQryInsertUE:= sQryInsertUE + ' STR_TO_DATE( ''01-01-2000'', ''%d-%m-%Y'' ),';
  end
  else
  begin
    sQryInsertUE:= sQryInsertUE + ' :pfecha_ini_plantacion,';
  end;
  if qryPlantacion.FieldByName('inicio_recoleccion').value = null then
  begin
    sQryInsertUE:= sQryInsertUE + ' STR_TO_DATE( ''11-11-2111'', ''%d-%m-%Y'' ),';
  end
  else
  begin
    sQryInsertUE:= sQryInsertUE + ' :pfecha_ini_recoleccion,';
  end;
  if qryPlantacion.FieldByName('fin_recoleccion').value = null then
  begin
    sQryInsertUE:= sQryInsertUE + ' STR_TO_DATE( ''11-11-2111'', ''%d-%m-%Y'' ),';
  end
  else
  begin
    sQryInsertUE:= sQryInsertUE + ' :pfecha_fin_recoleccion,';
  end;
  sQryInsertUE:= sQryInsertUE + ' :psuperficie, :peliminado, :pid_caseta, :pid_zona ) ';
end;


function  TDMComerToFitosanitarios.GetCode: Integer;
begin
  qryCodigoUE.Open;
  if not qryCodigoUE.IsEmpty then
  begin
    result:= qryCodigoUE.FieldByName('id_campo').AsInteger + 1;
  end
  else
  begin
    result:= 1;
  end;
  qryCodigoUE.Close;

end;

function TDMComerToFitosanitarios.GetTipoCultivo: Integer;
var
  sAux: string;
begin
  //qryTipoCultivo.Parameters.ParamByName('pcultivo').Value:= qryPlantacion.FieldByName('tipo_cultivo').AsString;
  sAux:= MySqlSParam(sQryTipoCultivo, ':pcultivo', qryPlantacion.FieldByName('tipo_cultivo').AsString );
  qryTipoCultivo.Sql.Clear;
  qryTipoCultivo.SQL.Add(sAux);
  qryTipoCultivo.Open;

  if not qryTipoCultivo.IsEmpty then
  begin
    result:= qryTipoCultivo.FieldByName('id_tipo_cultivo').AsInteger;
    qryTipoCultivo.Close;
  end
  else
  begin
    qryTipoCultivo.Close;
    raise Exception.Create('Falta dar de alta el producto ' + qryPlantacion.FieldByName('tipo_cultivo').AsString );
  end;

end;

function TDMComerToFitosanitarios.InsertUE: Boolean;
var
  sAux: string;
begin
  SQLInsertUE;

  qryInsertUE.SQL.Clear;
  sAux:= MySqlIParam( sQryInsertUE, ':pid_campo', GetCode );
  sAux:= MySqlSParam( sAux, ':pnombre', qryPlantacion.FieldByName('unidad_explotacion').AsString );
  sAux:= MySqlSParam( sAux, ':pcodigo', qryPlantacion.FieldByName('codigo').AsString );
  sAux:= MySqlSParam( sAux, ':pzona', qryPlantacion.FieldByName('zona').AsString );
  sAux:= MySqlIParam( sAux, ':pid_tipo_cultivo', GetTipoCultivo );
  sAux:= MySqlFParam( sAux, ':psuperficie', qryPlantacion.FieldByName('superficie').AsFloat );
  sAux:= MySqlSParam( sAux, ':ptipo_cultivo', qryPlantacion.FieldByName('tipo_cultivo').AsString );
  sAux:= MySqlIParam( sAux, ':peliminado', 0 );
  sAux:= MySqlDParam( sAux, ':pfecha_ini_plantacion', qryPlantacion.FieldByName('inicio_plantacion').AsDateTime );
  sAux:= MySqlDParam( sAux, ':pfecha_ini_recoleccion', qryPlantacion.FieldByName('inicio_recoleccion').AsDateTime );
  sAux:= MySqlDParam( sAux, ':pfecha_fin_recoleccion', qryPlantacion.FieldByName('fin_recoleccion').AsDateTime );
  sAux:= MySqlIParam( sAux, ':pid_caseta', 0 );
  sAux:= MySqlIParam( sAux, ':pid_zona', 0 );

  qryInsertUE.Sql.Clear;
  qryInsertUE.SQL.Add(sAux);
  //qryInsertUE.SQL.SaveToFile('c:\pepe.sql');
  qryInsertUE.ExecSQL;
  (*
  qryInsertUE.Parameters.ParamByname('pid_campo').Value:= GetCode;
  qryInsertUE.Parameters.ParamByname('pnombre').Value:= qryPlantacion.FieldByName('unidad_explotacion').AsString;
  qryInsertUE.Parameters.ParamByname('pcodigo').Value:= qryPlantacion.FieldByName('codigo').AsString;
  qryInsertUE.Parameters.ParamByname('pzona').Value:= qryPlantacion.FieldByName('zona').AsString;
  qryInsertUE.Parameters.ParamByname('pid_cultivo').Value:= GetTipoCultivo;
  qryInsertUE.Parameters.ParamByname('ptipo_cultivo').Value:= qryPlantacion.FieldByName('tipo_cultivo').AsString;
  qryInsertUE.Parameters.ParamByname('psuperficie').Value:= qryPlantacion.FieldByName('superficie').AsFloat;
  qryInsertUE.Parameters.ParamByname('peliminado').Value:= 0;

  if qryPlantacion.FieldByName('inicio_plantacion').value <> null then
  begin
    qryInsertUE.Parameters.ParamByname('pinicio_plantacion').Value:= qryPlantacion.FieldByName('inicio_plantacion').AsDateTime;
  end;
  if qryPlantacion.FieldByName('inicio_recoleccion').value <> null then
  begin
    qryInsertUE.Parameters.ParamByname('pinicio_recoleccion').Value:= qryPlantacion.FieldByName('inicio_recoleccion').AsDateTime;
  end;
  if qryPlantacion.FieldByName('fin_recoleccion').value <> null then
  begin
    qryInsertUE.Parameters.ParamByname('pfin_recoleccion').Value:= qryPlantacion.FieldByName('fin_recoleccion').AsDateTime;
  end;
  *)

  Result:= True;
end;

procedure TDMComerToFitosanitarios.SQLEditUE;
begin
  sQryInsertUE:= ' upadte campo set  ';

  sQryInsertUE:= sQryInsertUE + ' id_campo = :pid_campo, ';
  sQryInsertUE:= sQryInsertUE + ' nombre = :pnombre,  ';
  sQryInsertUE:= sQryInsertUE + ' codigo = :pcodigo,  ';
  sQryInsertUE:= sQryInsertUE + ' zona = :pzona,  ';
  sQryInsertUE:= sQryInsertUE + ' id_tipo_cultivo = :pid_tipo_cultivo,  ';

  if qryPlantacion.FieldByName('inicio_recoleccion').value = null then
  begin
    sQryInsertUE:= sQryInsertUE + ' fecha_ini_recoleccion = STR_TO_DATE( ''11-11-2111'', ''%d-%m-%Y'' ),';
  end
  else
  begin
    sQryInsertUE:= sQryInsertUE + ' fecha_ini_recoleccion = :pfecha_ini_recoleccion,';
  end;
  if qryPlantacion.FieldByName('fin_recoleccion').value = null then
  begin
    sQryInsertUE:= sQryInsertUE + ' fecha_fin_recoleccion = STR_TO_DATE( ''11-11-2111'', ''%d-%m-%Y'' ),';
  end
  else
  begin
    sQryInsertUE:= sQryInsertUE + ' fecha_fin_recoleccion = :pfecha_fin_recoleccion,';
  end;
  sQryInsertUE:= sQryInsertUE + ' superficie = :psuperficie, ';
  sQryInsertUE:= sQryInsertUE + ' eliminado = :peliminado ';

  sQryInsertUE:= sQryInsertUE + ' where codigo = :pcodigo and tipo_cultivo = :ptipo_cultivo and fecha_ini_plantacion = :pfecha_ini_plantacion';

end;


function TDMComerToFitosanitarios.EditUE: Boolean;
var
  sAux: string;
begin
  SQLEditUE;

  qryInsertUE.SQL.Clear;
  sAux:= MySqlIParam( sQryInsertUE, ':pid_campo', GetCode );
  sAux:= MySqlSParam( sAux, ':pnombre', qryPlantacion.FieldByName('unidad_explotacion').AsString );
  sAux:= MySqlSParam( sAux, ':pzona', qryPlantacion.FieldByName('zona').AsString );
  sAux:= MySqlFParam( sAux, ':psuperficie', qryPlantacion.FieldByName('superficie').AsFloat );
  sAux:= MySqlSParam( sAux, ':ptipo_cultivo', qryPlantacion.FieldByName('tipo_cultivo').AsString );
  sAux:= MySqlIParam( sAux, ':peliminado', 0 );
  sAux:= MySqlDParam( sAux, ':pfecha_ini_recoleccion', qryPlantacion.FieldByName('inicio_recoleccion').AsDateTime );
  sAux:= MySqlDParam( sAux, ':pfecha_fin_recoleccion', qryPlantacion.FieldByName('fin_recoleccion').AsDateTime );
  //sAux:= MySqlIParam( sAux, ':pid_caseta', 0 );
  //sAux:= MySqlIParam( sAux, ':pid_zona', 0 );

  //En el where
  sAux:= MySqlSParam( sAux, ':pcodigo', qryPlantacion.FieldByName('codigo').AsString );
  sAux:= MySqlIParam( sAux, ':pid_tipo_cultivo', GetTipoCultivo );
  sAux:= MySqlDParam( sAux, ':pfecha_ini_plantacion', qryPlantacion.FieldByName('inicio_plantacion').AsDateTime );

  qryInsertUE.Sql.Clear;
  qryInsertUE.SQL.Add(sAux);
  //qryInsertUE.SQL.SaveToFile('c:\pepe.sql');
  qryInsertUE.ExecSQL;

  Result:= True;
end;


end.
