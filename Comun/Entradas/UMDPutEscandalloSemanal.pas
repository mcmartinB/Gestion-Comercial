unit UMDPutEscandalloSemanal;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TMDPutEscandalloSemanal = class(TDataModule)
    qryEntradas: TQuery;
    qryEscandallos: TQuery;
    qryNuevos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    iCount: Integer;
    sEmpresa, sProducto, sCosechero, sPlantacion, sAnyoSemana, sAnyoSemanaEscandallo: string;
    rPrimera, rSegunda, rTercera, rDestrio, rFalta: Real;
    dFechaIni, dFechaFin: TDateTime;
    bSoloNuevas: Boolean;

    procedure InsertarEscandallos;
    procedure InsertarEscandallo;
    procedure ModificarEscandallos;
  public
    { Public declarations }
  end;

  function AplicarEscandallos( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana, AAnyoSemanaEscandallo: string;
                               const AFecha: TDateTime;
                               const APrimera, ASegunda, ATercera, ADestrio: Real; const ASoloNuevas, APorSemana: Boolean ): integer;
Implementation

{$R *.dfm}

uses
  bTimeUtils;

var
  MDPutEscandalloSemanal: TMDPutEscandalloSemanal;

function AplicarEscandallos( const AEmpresa, AProducto, ACosechero, APlantacion, AAnyoSemana, AAnyoSemanaEscandallo: string; const AFecha: TDateTime;
                             const APrimera, ASegunda, ATercera, ADestrio: Real; const ASoloNuevas, APorSemana: Boolean ): integer;
begin
  MDPutEscandalloSemanal:= TMDPutEscandalloSemanal.Create( nil );
  try
    MDPutEscandalloSemanal.iCount:= 0;
    MDPutEscandalloSemanal.sEmpresa:= AEmpresa;
    MDPutEscandalloSemanal.sProducto:= AProducto;
    MDPutEscandalloSemanal.sCosechero:= ACosechero;
    MDPutEscandalloSemanal.sPlantacion:= APlantacion;
    MDPutEscandalloSemanal.sAnyoSemana:= AAnyoSemana;
    if APorSemana then
    begin
      MDPutEscandalloSemanal.sAnyoSemanaEscandallo:= AAnyoSemanaEscandallo;
      MDPutEscandalloSemanal.dFechaIni:= LunesAnyoSemana( AAnyoSemanaEscandallo );
      MDPutEscandalloSemanal.dFechaFin:= MDPutEscandalloSemanal.dFechaIni + 6;
    end
    else
    begin
      MDPutEscandalloSemanal.sAnyoSemanaEscandallo:= AAnyoSemanaEscandallo;
      MDPutEscandalloSemanal.dFechaIni:= AFecha;
      MDPutEscandalloSemanal.dFechaFin:= AFecha;
    end;
    MDPutEscandalloSemanal.rPrimera:= APrimera;
    MDPutEscandalloSemanal.rSegunda:= ASegunda;
    MDPutEscandalloSemanal.rTercera:= ATercera;
    MDPutEscandalloSemanal.rDestrio:= ADestrio;
    MDPutEscandalloSemanal.bSoloNuevas:= ASoloNuevas;

    if ASoloNuevas then
    begin
      MDPutEscandalloSemanal.InsertarEscandallos;
    end
    else
    begin
      MDPutEscandalloSemanal.ModificarEscandallos;
      MDPutEscandalloSemanal.InsertarEscandallos;
    end;
    Result:= MDPutEscandalloSemanal.iCount;
  finally
    FreeAndNil(MDPutEscandalloSemanal );
  end;
end;


procedure TMDPutEscandalloSemanal.DataModuleCreate(Sender: TObject);
begin
  qryEntradas.SQL.Clear;
  qryEntradas.SQL.Add(' select empresa_e2l, centro_e2l, numero_entrada_e2l, fecha_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, producto_e2l   ');
  qryEntradas.SQL.Add(' from frf_entradas2_l ');
  qryEntradas.SQL.Add(' where empresa_e2l = :empresa ');
  qryEntradas.SQL.Add(' and fecha_e2l between :fecha_ini and :fecha_fin ');
  qryEntradas.SQL.Add(' and producto_e2l = :producto ');
  qryEntradas.SQL.Add(' and cosechero_e2l = :cosechero ');
  qryEntradas.SQL.Add(' and plantacion_e2l = :plantacion ');
  qryEntradas.SQL.Add(' and ano_sem_planta_e2l = :anyosemana ');
  qryEntradas.SQL.Add(' and ');
  qryEntradas.SQL.Add('  not exists ');
  qryEntradas.SQL.Add('   ( ');
  qryEntradas.SQL.Add('     select * ');
  qryEntradas.SQL.Add('     from frf_escandallo ');
  qryEntradas.SQL.Add('     where empresa_e = empresa_e2l ');
  qryEntradas.SQL.Add('     and centro_e = centro_e2l ');
  qryEntradas.SQL.Add('     and numero_entrada_e = numero_entrada_e2l ');
  qryEntradas.SQL.Add('     and fecha_e = fecha_e2l ');
  qryEntradas.SQL.Add('     and producto_e = producto_e2l ');
  qryEntradas.SQL.Add('     and cosechero_e = cosechero_e2l ');
  qryEntradas.SQL.Add('     and plantacion_e = plantacion_e2l ');
  qryEntradas.SQL.Add('     and anyo_semana_e = ano_sem_planta_e2l ');
  //qryEntradas.SQL.Add('     and tipo_entrada_e = 0 ');
  qryEntradas.SQL.Add('   ) ');
  qryEntradas.SQL.Add(' group by empresa_e2l, centro_e2l, numero_entrada_e2l, fecha_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, producto_e2l  ');

  qryNuevos.SQL.Clear;
  qryNuevos.SQL.Add(' insert into  frf_escandallo ');
  qryNuevos.SQL.Add('   ( empresa_e, centro_e, numero_entrada_e, fecha_e, cosechero_e, plantacion_e, anyo_semana_e, producto_e, tipo_entrada_e, ');
  qryNuevos.SQL.Add('     porcen_primera_e, porcen_segunda_e, porcen_tercera_e, porcen_destrio_e, ');
  qryNuevos.SQL.Add('     aporcen_primera_e, aporcen_segunda_e, aporcen_tercera_e, aporcen_destrio_e, aporcen_merma_e  ) ');
  qryNuevos.SQL.Add(' values ');
  qryNuevos.SQL.Add('   ( :empresa_e, :centro_e, :numero_entrada_e, :fecha_e, :cosechero_e, :plantacion_e, :anyo_semana_e, :producto_e, :tipo_entrada_e, ');
  qryNuevos.SQL.Add('     :porcen_primera_e, :porcen_segunda_e, :porcen_tercera_e, :porcen_destrio_e, ');
  qryNuevos.SQL.Add('     :aporcen_primera_e, :aporcen_segunda_e, :aporcen_tercera_e, :aporcen_destrio_e, :aporcen_merma_e  ) ');

  qryEscandallos.SQL.Clear;
  qryEscandallos.SQL.Add(' select *  ');
  qryEscandallos.SQL.Add(' from frf_escandallo ');
  qryEscandallos.SQL.Add(' where empresa_e = :empresa ');
  qryEscandallos.SQL.Add(' and fecha_e between :fecha_ini and :fecha_fin ');
  qryEscandallos.SQL.Add(' and producto_e = :producto ');
  qryEscandallos.SQL.Add(' and cosechero_e = :cosechero ');
  qryEscandallos.SQL.Add(' and plantacion_e = :plantacion ');
  qryEscandallos.SQL.Add(' and anyo_semana_e = :anyosemana ');
  qryEscandallos.SQL.Add(' and tipo_entrada_e = 0 ');


end;

procedure TMDPutEscandalloSemanal.InsertarEscandallos;
begin
  qryEntradas.ParamByName('empresa').AsString:= sEmpresa;
  qryEntradas.ParamByName('producto').AsString:= sProducto;
  qryEntradas.ParamByName('cosechero').AsString:= sCosechero;
  qryEntradas.ParamByName('plantacion').AsString:= sPlantacion;
  qryEntradas.ParamByName('anyosemana').AsString:= sAnyoSemana;
  qryEntradas.ParamByName('fecha_ini').AsDateTime:= dFechaIni;
  qryEntradas.ParamByName('fecha_fin').AsDateTime:= dFechaFin;

  qryEntradas.Open;
  try
    while not qryEntradas.Eof do
    begin
      InsertarEscandallo;
      Inc( icount );
      qryEntradas.Next;
    end;
  finally
    qryEntradas.Close;
  end;
end;


procedure TMDPutEscandalloSemanal.InsertarEscandallo;
begin
  qryNuevos.ParamByName('empresa_e').AsString:= qryEntradas.FieldByName('empresa_e2l').AsString;
  qryNuevos.ParamByName('centro_e').AsString:= qryEntradas.FieldByName('centro_e2l').AsString;
  qryNuevos.ParamByName('numero_entrada_e').AsInteger:= qryEntradas.FieldByName('numero_entrada_e2l').AsInteger;
  qryNuevos.ParamByName('fecha_e').AsDateTime:= qryEntradas.FieldByName('fecha_e2l').AsDateTime;
  qryNuevos.ParamByName('cosechero_e').AsString:= qryEntradas.FieldByName('cosechero_e2l').AsString;
  qryNuevos.ParamByName('plantacion_e').AsString:= qryEntradas.FieldByName('plantacion_e2l').AsString;
  qryNuevos.ParamByName('anyo_semana_e').AsString:= qryEntradas.FieldByName('ano_sem_planta_e2l').AsString;
  qryNuevos.ParamByName('producto_e').AsString:= qryEntradas.FieldByName('producto_e2l').AsString;
  qryNuevos.ParamByName('tipo_entrada_e').AsFloat:= 0;

  qryNuevos.ParamByName('porcen_primera_e').AsFloat:= rPrimera;
  qryNuevos.ParamByName('porcen_segunda_e').AsFloat:= rSegunda;
  qryNuevos.ParamByName('porcen_tercera_e').AsFloat:= rTercera;
  qryNuevos.ParamByName('porcen_destrio_e').AsFloat:= rDestrio;
  qryNuevos.ParamByName('aporcen_primera_e').AsFloat:= 0;
  qryNuevos.ParamByName('aporcen_segunda_e').AsFloat:= 0;
  qryNuevos.ParamByName('aporcen_tercera_e').AsFloat:= 0;
  qryNuevos.ParamByName('aporcen_destrio_e').AsFloat:= 0;
  qryNuevos.ParamByName('aporcen_merma_e').AsFloat:= 0;

  qryNuevos.ExecSql;
end;


procedure TMDPutEscandalloSemanal.ModificarEscandallos;
begin
  qryEscandallos.ParamByName('empresa').AsString:= sEmpresa;
  qryEscandallos.ParamByName('producto').AsString:= sProducto;
  qryEscandallos.ParamByName('cosechero').AsString:= sCosechero;
  qryEscandallos.ParamByName('plantacion').AsString:= sPlantacion;
  qryEscandallos.ParamByName('anyosemana').AsString:= sAnyoSemana;
  qryEscandallos.ParamByName('fecha_ini').AsDateTime:= dFechaIni;
  qryEscandallos.ParamByName('fecha_fin').AsDateTime:= dFechaFin;

  qryEscandallos.Open;
  try
    while not qryEscandallos.Eof do
    begin
      qryEscandallos.Edit;
      qryEscandallos.FieldByName('porcen_primera_e').AsFloat:= rPrimera;
      qryEscandallos.FieldByName('porcen_segunda_e').AsFloat:= rSegunda;
      qryEscandallos.FieldByName('porcen_tercera_e').AsFloat:= rTercera;
      qryEscandallos.FieldByName('porcen_destrio_e').AsFloat:= rDestrio;
      qryEscandallos.Post;
      Inc( icount );
      qryEscandallos.Next;
    end;
  finally
    qryEscandallos.Close;
  end;
end;


end.
