unit AprovechaEntradasDM;

interface

uses
  SysUtils, Classes, DB, DBClient, DBTables;

type
  TDMAprovechaEntradas = class(TDataModule)
    cdsAprovechaEntradas: TClientDataSet;
    strngfldAprovechaEntradasempresa: TStringField;
    strngfldAprovechaEntradascentro: TStringField;
    intgrfldAprovechaEntradasfecha: TIntegerField;
    intgrfldAprovechaEntradasnumero: TIntegerField;
    strngfldAprovechaEntradascosechero: TStringField;
    strngfldAprovechaEntradasplantacion: TStringField;
    intgrfldAprovechaEntradasanyo_semana: TIntegerField;
    fltfldAprovechaEntradaskilos: TFloatField;
    fltfldAprovechaEntradaskilos_primera: TFloatField;
    fltfldAprovechaEntradaskilos_segunda: TFloatField;
    fltfldAprovechaEntradaskilos_tercera: TFloatField;
    fltfldAprovechaEntradaskilos_destrio: TFloatField;
    fltfldAprovechaEntradasaprovecha_primera: TFloatField;
    fltfldAprovechaEntradasaprovecha_segunda: TFloatField;
    fltfldAprovechaEntradasaprovecha_tercera: TFloatField;
    fltfldAprovechaEntradasaprovecha_merma: TFloatField;
    qryEscandallo: TQuery;
    qryAprovecha: TQuery;
    blnfldAprovechaEntradastiene_escandallo: TBooleanField;
    blnfldAprovechaEntradastiene_aprovecha: TBooleanField;
    strngfldAprovechaEntradasproducto: TStringField;
    intgrfldAprovechaEntradascajas: TIntegerField;
    strngfldAprovechaEntradasgrupo: TStringField;
    fltfldAprovechaEntradasaprovecha_destrio: TFloatField;
    strngfldAprovechaEntradaskey: TStringField;
    intgrfldAprovechaEntradasrama_suelta: TIntegerField;
    cdsAprovechaEntradassinasignar: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    bErrorEscandallo: boolean;
    sEmpresa, sCentro, sProducto, sCosechero, sPlantacion, sAgrupacion: string;
    dFechaIni, dFechaFin: TDateTime;
    iTipoEntrada, iVerDatos, iVerDetalles, iPeriodo: integer;
    bSepRama, bNoIndustria: boolean;

    procedure SQLEscandallo;
    procedure SQLTransitos;
    function  GetAprovechamientosEx: boolean;
    procedure ReiniciarTabla;
    procedure AddEntrada;
    procedure NewEntrada( const AKey: string );
    procedure ModEntrada;
    procedure AddAprovechamientos;
    procedure AddAprovechamiento;
    function GetKey: string;
    function GetFecha: integer;
    function GetNumero: integer;
    function GetGrupo: string;
    function GetCosechero: string;
    function GetPlantacion: string;
    function GetSemana: integer;
    function ExpandZeros( const AValue: string; const AZeros: integer ): string;

  public
    { Public declarations }
    function GetAprovechamientos( const AEmpresa, ACentro, AProducto, ACosechero, APlantacion, AAgrupacion: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ATipoEntrada, AVerDatos, AVerDetalles, APeriodo: integer;
                              const ASepRama, ANoIndustria: boolean ): boolean;
  end;

  procedure InformeAprovechamientos( const AEmpresa, ACentro, AProducto, ACosechero, APlantacion, AAgrupacion: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ATipoEntrada, AVerDatos, AVerDetalles, APeriodo: integer;
                              const ASepRama, ANoIndustria: boolean );

var
  DMAprovechaEntradas: TDMAprovechaEntradas;

implementation

{$R *.dfm}

uses
  Forms, Dialogs, Math, AprovechaEntradasQR, DateUtils;

procedure InformeAprovechamientos( const AEmpresa, ACentro, AProducto, ACosechero, APlantacion, AAgrupacion: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ATipoEntrada, AVerDatos, AVerDetalles, APeriodo: integer;
                              const ASepRama, ANoIndustria: boolean );
begin
  Application.CreateForm( TDMAprovechaEntradas, DMAprovechaEntradas );
  try
     if DMAprovechaEntradas.GetAprovechamientos( AEmpresa, ACentro, AProducto, ACosechero, APlantacion, AAgrupacion, AFechaIni, AFechaFin, ATipoEntrada, AVerDatos, AVerDetalles, APeriodo, ASepRama, ANoIndustria ) then
       AprovechaEntradasQR.InformeAprovechamiento( AEmpresa, ACentro, AProducto, ACosechero, APlantacion, AFechaIni, AFechaFin, ATipoEntrada, AVerDatos, AVerDetalles, APeriodo );
  finally
    FreeAndNIl( DMAprovechaEntradas );
  end;
end;

procedure TDMAprovechaEntradas.DataModuleDestroy(Sender: TObject);
begin
  cdsAprovechaEntradas.Close;
end;

procedure TDMAprovechaEntradas.DataModuleCreate(Sender: TObject);
begin
  cdsAprovechaEntradas.Open;
end;

procedure TDMAprovechaEntradas.SQLEscandallo;
begin
  with qryAprovecha do
  begin
    if Prepared then
      Unprepare;
    sql.clear;
    sql.Add('select categoria_ent, sum(kilos_liq) kilos_aprovecha, sum(round( kilos_ent *  ( 1 - ( porcentaje_disponibles / 100 ) ),2) ) kilos_sin ');
    sql.Add('from tliq_liquida_det  join tliq_semanas on codigo_liq = codigo ');
    sql.Add('where empresa_ent = :empresa_e2l ');
    sql.Add('and centro_ent = :centro_e2l ');
    sql.Add('and n_entrada = :numero_entrada_e2l ');
    sql.Add('and fecha_ent = :fecha_e2l ');
    sql.Add('and producto_ent = :producto_e2l ');
    sql.Add('and cosechero_ent = :cosechero_e2l ');
    sql.Add('and plantacion_ent = :plantacion_e2l ');
    sql.Add('and semana_planta_ent = :ano_sem_planta_e2l ');

    if bNoIndustria then
    begin
      sql.Add('     and      tipo_ent <> ''2''  ');
    end;

    sql.Add('group by categoria_ent ');
    Prepare;
  end;

  with qryEscandallo do
  begin
    sql.clear;
    sql.Add('select empresa_e2l, centro_e2l, fecha_e2l, numero_entrada_e2l, ');
    //sql.Add('       producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, total_cajas_e2l, ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    sql.Add('       ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ) producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, total_cajas_e2l, ');

    if bSepRama then
    begin
      //sql.Add('           case when producto_e2l = ''T'' and descripcion_p  like ''%RAMA%'' then 1  ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      sql.Add('           case when ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ) = ''TOM'' and descripcion_p  like ''%RAMA%'' then 1  ');
      sql.Add('                else 0  ');
      sql.Add('           end rama_suelta,  ');
    end
    else
    begin
      sql.Add('       0 rama_suelta, ');
    end;

    sql.Add('       case when cosechero_c = 0 then ''C'' else pertenece_grupo_c end grupo, ');

    if iVerDatos = 2 then
    begin
      sql.Add('       total_kgs_e2l, 0 porcen_primera_e, 0 porcen_segunda_e, 0 porcen_tercera_e, 0 porcen_destrio_e ');
    end
    else
    begin
      sql.Add('       total_kgs_e2l, porcen_primera_e, porcen_segunda_e, porcen_tercera_e, porcen_destrio_e ');
    end;
    sql.Add('from frf_entradas2_l ');
    if iVerDatos <> 2 then
    begin
      sql.Add('     left  join frf_escandallo on empresa_e = empresa_e2l and centro_e = centro_e2l ');
      sql.Add('                               and numero_entrada_e = numero_entrada_e2l and fecha_e = fecha_e2l ');
      sql.Add('                               and cosechero_e = cosechero_e2l and plantacion_e = plantacion_e2l ');
      sql.Add('                               and anyo_semana_e = ano_sem_planta_e2l ');
    end;
      sql.Add('     join frf_cosecheros on empresa_e2l = empresa_c and cosechero_e2l = cosechero_c   ');
    if bSepRama then
    begin
      //sql.Add('     join frf_plantaciones on empresa_e2l = empresa_p and producto_e2l = producto_p  ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      sql.Add('     join frf_plantaciones on empresa_e2l = empresa_p and ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ) = ( case when producto_p = ''TOM'' then ''TOM'' else producto_p end )  ');
      sql.Add('                           and cosechero_e2l = cosechero_p and plantacion_e2l = plantacion_p  ');
      sql.Add('                           and ano_sem_planta_e2l = ano_semana_p  ');
    end;
    sql.Add('where empresa_e2l = :empresa ');
    sql.Add('and fecha_e2l between :fechaini and :fechafin ');
    if sCentro <> '' then
      sql.Add('and centro_e2l = :centro ');
    if sProducto <> '' then
      //sql.Add('and producto_e2l= :producto ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      sql.Add('and ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end )= :producto ');
    if sCosechero <> '' then
      sql.Add('and cosechero_e2l= :cosechero ');
    if sPlantacion <> '' then
      sql.Add('and plantacion_e2l= :plantacion ');

    if bNoIndustria then
    begin
      sql.Add('     and      tipo_entrada_e <> ''2''  ');
    end;
    if sAgrupacion <> '' then
      SQl.Add(' and producto_e2l in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');

    ParamByName('empresa').AsString:=  sEmpresa;
    ParamByName('fechaini').AsDateTime:=  dFechaIni;
    ParamByName('fechafin').AsDateTime:=  dFechaFin;
    if sCentro <> '' then
        ParamByName('centro').AsString:=  sCentro;
    if sProducto <> '' then
        ParamByName('producto').AsString:=  sProducto;
    if sCosechero <> '' then
        ParamByName('cosechero').AsString:=  sCosechero;
    if sPlantacion <> '' then
        ParamByName('plantacion').AsString:=  sPlantacion;
    if sAgrupacion <> '' then
        ParamByName('agrupacion').AsString:= sAgrupacion;
  end;
end;


procedure TDMAprovechaEntradas.SQLTransitos;
begin
  with qryAprovecha do
  begin
    if Prepared then
      Unprepare;
    sql.clear;
    sql.Add('select categoria_ent, sum(kilos_liq) kilos_aprovecha, sum(round( kilos_ent *  ( 1 - ( porcentaje_disponibles / 100 ) ),2) ) kilos_sin ');
    sql.Add('from tliq_liquida_det join tliq_semanas on codigo_liq = codigo ');
    sql.Add('where empresa_ent = :empresa_e2l ');
    sql.Add('and centro_ent = :centro_e2l ');
    sql.Add('and n_entrada = :numero_entrada_e2l ');
    sql.Add('and fecha_ent = :fecha_e2l ');
    sql.Add('and producto_ent = :producto_e2l ');
    sql.Add('and centro_origen_ent = :cosechero_e2l ');
    sql.Add('group by categoria_ent ');
    Prepare;
  end;

  with qryEscandallo do
  begin
    sql.clear;
    sql.Add('select empresa_tc empresa_e2l, centro_destino_tc centro_e2l, fecha_entrada_tc fecha_e2l, referencia_tc numero_entrada_e2l, ');
    //sql.Add('       producto_tl producto_e2l, centro_tl cosechero_e2l, -1 plantacion_e2l, 0 ano_sem_planta_e2l, ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    sql.Add('       ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) producto_e2l, centro_tl cosechero_e2l, -1 plantacion_e2l, 0 ano_sem_planta_e2l, ');
    sql.Add('       0 rama_suelta, ''T'' grupo, ');
    sql.Add('       sum(cajas_tl) total_cajas_e2l, sum(kilos_tl) total_kgs_e2l, ');
    sql.Add('       sum( case when categoria_tl = 1 then kilos_tl else 0 end ) kilos_primera_e, ');
    sql.Add('       sum( case when categoria_tl = 2 then kilos_tl else 0 end ) kilos_segunda_e, ');
    sql.Add('       sum( case when categoria_tl = 3 then kilos_tl else 0 end ) kilos_tercera_e, ');
    sql.Add('       sum( case when categoria_tl not in ( 1,2,3 ) then kilos_tl else 0 end ) kilos_destrio_e ');

    sql.Add('from frf_transitos_c ');
    sql.Add('     join frf_transitos_l on empresa_tc = empresa_tl and centro_destino_tc = centro_destino_tl ');
    sql.Add('                          and fecha_tc = fecha_tl and referencia_tc = referencia_tl ');
    sql.Add('where empresa_tc = :empresa ');
    sql.Add('and fecha_entrada_tc between :fechaini and :fechafin ');
    if sCentro <> '' then
      sql.Add('and centro_destino_tc = :centro ');
    if sProducto <> '' then
      //sql.Add('and producto_tl= :producto ');
      //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
      sql.Add('and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end )= :producto ');
    if sCosechero <> '' then
      sql.Add('and centro_tc= :cosechero ');
    if sAgrupacion <> '' then
      SQl.Add(' and producto_tl in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');


    sql.Add('group by empresa_e2l, centro_e2l, fecha_e2l, numero_entrada_e2l, producto_e2l, ');
    sql.Add('         rama_suelta, grupo, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l ');

    ParamByName('empresa').AsString:=  sEmpresa;
    ParamByName('fechaini').AsDateTime:=  dFechaIni;
    ParamByName('fechafin').AsDateTime:=  dFechaFin;
    if sCentro <> '' then
        ParamByName('centro').AsString:=  sCentro;
    if sProducto <> '' then
        ParamByName('producto').AsString:=  sProducto;
    if sCosechero <> '' then
        ParamByName('cosechero').AsString:=  sCosechero;
    if sAgrupacion <> '' then
        ParamByName('agrupacion').AsString:= sAgrupacion;
  end;
end;

function TDMAprovechaEntradas.GetAprovechamientos( const AEmpresa, ACentro, AProducto, ACosechero, APlantacion, AAgrupacion: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ATipoEntrada, AVerDatos, AVerDetalles, APeriodo: integer;
                              const ASepRama, ANoIndustria: boolean ): boolean;
var
  bEntradas, bTransitos: boolean;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  sCosechero:= ACosechero;
  sPlantacion:= APlantacion;
  sAgrupacion:= AAgrupacion;
  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;
  iVerDatos:= AVerDatos;
  iVerDetalles:= AVerDetalles;
  iPeriodo:= APeriodo;
  bSepRama:= ASepRama;
  bNoIndustria:= ANoIndustria;
  iTipoEntrada:= ATipoEntrada;
  bErrorEscandallo:= False;


  ReiniciarTabla;
  if ATipoEntrada <> 2 then
  begin
    SQLEscandallo;
    bEntradas:= GetAprovechamientosEx;
  end
  else
  begin
    bEntradas:= False;
  end;

  if ATipoEntrada <> 1 then
  begin
    SQLTransitos;
    bTransitos:= GetAprovechamientosEx;
  end
  else
  begin
    bTransitos:= False;
  end;
  result:= bEntradas or bTransitos;

  if not result then
  begin
    ShowMessage('Sin datos.')
  end;
end;


function TDMAprovechaEntradas.GetAprovechamientosEx;
begin
  qryEscandallo.Open;
  try
    if not qryEscandallo.isempty then
    begin
      while not qryEscandallo.Eof do
      begin
        AddEntrada;
        if iVerDatos <> 1 then
          AddAprovechamientos;
        qryEscandallo.Next;
      end;
      result:= True;
    end
    else
    begin
      result:= False;
    end;
  finally
    qryEscandallo.Close;
  end
end;

procedure TDMAprovechaEntradas.ReiniciarTabla;
begin
  cdsAprovechaEntradas.Close;
  cdsAprovechaEntradas.Open;
end;

procedure TDMAprovechaEntradas.AddEntrada;
var
  sKey: string;
begin
  sKey:= GetKey;
  if cdsAprovechaEntradas.Locate( 'key', sKey, [] ) then
    ModEntrada
  else
    NewEntrada( sKey );
end;

procedure TDMAprovechaEntradas.NewEntrada( const AKey: string );
var
  rAux, rAcum: real;
begin
  cdsAprovechaEntradas.Insert;

  cdsAprovechaEntradas.FieldByName('key').AsString:= AKey;
  cdsAprovechaEntradas.FieldByName('empresa').AsString:= qryEscandallo.FieldByName('empresa_e2l').AsString;
  cdsAprovechaEntradas.FieldByName('centro').AsString:= qryEscandallo.FieldByName('centro_e2l').AsString;
  cdsAprovechaEntradas.FieldByName('producto').AsString:= qryEscandallo.FieldByName('producto_e2l').AsString;
  cdsAprovechaEntradas.FieldByName('rama_suelta').AsInteger:= qryEscandallo.FieldByName('rama_suelta').AsInteger;
  cdsAprovechaEntradas.FieldByName('grupo').AsString:= GetGrupo;
  cdsAprovechaEntradas.FieldByName('cosechero').AsString:= GetCosechero;
  cdsAprovechaEntradas.FieldByName('plantacion').AsString:= GetPlantacion;
  cdsAprovechaEntradas.FieldByName('anyo_semana').AsInteger:= GetSemana;
  cdsAprovechaEntradas.FieldByName('fecha').AsInteger:= GetFecha;
  cdsAprovechaEntradas.FieldByName('numero').AsInteger:= GetNumero;

  cdsAprovechaEntradas.FieldByName('cajas').AsFloat:= qryEscandallo.FieldByName('total_cajas_e2l').AsFloat;
  cdsAprovechaEntradas.FieldByName('kilos').AsFloat:= qryEscandallo.FieldByName('total_kgs_e2l').AsFloat;

  if cdsAprovechaEntradas.FieldByName('grupo').AsString = 'T' then
  begin
    cdsAprovechaEntradas.FieldByName('kilos_primera').AsFloat:= qryEscandallo.FieldByName('kilos_primera_e').AsFloat;
    cdsAprovechaEntradas.FieldByName('kilos_segunda').AsFloat:= qryEscandallo.FieldByName('kilos_segunda_e').AsFloat;
    cdsAprovechaEntradas.FieldByName('kilos_tercera').AsFloat:= qryEscandallo.FieldByName('kilos_tercera_e').AsFloat;
    cdsAprovechaEntradas.FieldByName('kilos_destrio').AsFloat:= qryEscandallo.FieldByName('kilos_destrio_e').AsFloat;
  end
  else
  begin
    if ( ( qryEscandallo.FieldByName('porcen_primera_e').AsFloat +
         qryEscandallo.FieldByName('porcen_segunda_e').AsFloat +
         qryEscandallo.FieldByName('porcen_tercera_e').AsFloat +
         qryEscandallo.FieldByName('porcen_destrio_e').AsFloat ) = 0 ) then
    begin
      if ( not bErrorEscandallo) and ( qryEscandallo.FieldByName('empresa_e2l').AsString = '050' ) and ( iVerDatos <> 2 ) then
      begin
        ShowMessage('Hay entradas sin escandallo, por favor revise que todo este bien grabado.');
      end;
      bErrorEscandallo:= true;

      cdsAprovechaEntradas.FieldByName('kilos_primera').AsFloat:= qryEscandallo.FieldByName('total_kgs_e2l').AsFloat;
      cdsAprovechaEntradas.FieldByName('kilos_segunda').AsFloat:= 0;
      cdsAprovechaEntradas.FieldByName('kilos_tercera').AsFloat:= 0;
      cdsAprovechaEntradas.FieldByName('kilos_destrio').AsFloat:= 0;
    end
    else
    begin
      rAux:= RoundTo( qryEscandallo.FieldByName('total_kgs_e2l').AsFloat * qryEscandallo.FieldByName('porcen_primera_e').AsFloat / 100, -2);
      rAcum:=rAux;
      cdsAprovechaEntradas.FieldByName('kilos_primera').AsFloat:= rAux;
      rAux:= RoundTo( qryEscandallo.FieldByName('total_kgs_e2l').AsFloat * qryEscandallo.FieldByName('porcen_segunda_e').AsFloat / 100, -2);
      rAcum:=rAcum + rAux;
      cdsAprovechaEntradas.FieldByName('kilos_segunda').AsFloat:= rAux;
      rAux:= RoundTo( qryEscandallo.FieldByName('total_kgs_e2l').AsFloat * qryEscandallo.FieldByName('porcen_tercera_e').AsFloat / 100, -2);
      rAcum:=rAcum + rAux;
      cdsAprovechaEntradas.FieldByName('kilos_tercera').AsFloat:= rAux;
      rAux:= RoundTo( qryEscandallo.FieldByName('total_kgs_e2l').AsFloat - rAcum, -2 );
      cdsAprovechaEntradas.FieldByName('kilos_destrio').AsFloat:= rAux;
    end;
  end;

  cdsAprovechaEntradas.FieldByName('aprovecha_primera').AsFloat:= 0;
  cdsAprovechaEntradas.FieldByName('aprovecha_segunda').AsFloat:= 0;
  cdsAprovechaEntradas.FieldByName('aprovecha_tercera').AsFloat:= 0;
  cdsAprovechaEntradas.FieldByName('aprovecha_destrio').AsFloat:= 0;
  cdsAprovechaEntradas.FieldByName('aprovecha_merma').AsFloat:= 0;

  try
    cdsAprovechaEntradas.Post;
  except
    cdsAprovechaEntradas.Cancel;
    raise;
  end
end;

procedure TDMAprovechaEntradas.ModEntrada;
var
  rAux, rAcum: real;
begin
  cdsAprovechaEntradas.Edit;

  cdsAprovechaEntradas.FieldByName('cajas').AsFloat:= cdsAprovechaEntradas.FieldByName('cajas').AsFloat + qryEscandallo.FieldByName('total_cajas_e2l').AsFloat;
  cdsAprovechaEntradas.FieldByName('kilos').AsFloat:= cdsAprovechaEntradas.FieldByName('kilos').AsFloat + qryEscandallo.FieldByName('total_kgs_e2l').AsFloat;

  if cdsAprovechaEntradas.FieldByName('grupo').AsString = 'T' then
  begin
    cdsAprovechaEntradas.FieldByName('kilos_primera').AsFloat:= cdsAprovechaEntradas.FieldByName('kilos_primera').AsFloat + qryEscandallo.FieldByName('kilos_primera_e').AsFloat;
    cdsAprovechaEntradas.FieldByName('kilos_segunda').AsFloat:= cdsAprovechaEntradas.FieldByName('kilos_segunda').AsFloat + qryEscandallo.FieldByName('kilos_segunda_e').AsFloat;
    cdsAprovechaEntradas.FieldByName('kilos_tercera').AsFloat:= cdsAprovechaEntradas.FieldByName('kilos_tercera').AsFloat + qryEscandallo.FieldByName('kilos_tercera_e').AsFloat;
    cdsAprovechaEntradas.FieldByName('kilos_destrio').AsFloat:= cdsAprovechaEntradas.FieldByName('kilos_destrio').AsFloat + qryEscandallo.FieldByName('kilos_destrio_e').AsFloat;
  end
  else
  begin
    rAux:= RoundTo( qryEscandallo.FieldByName('total_kgs_e2l').AsFloat * qryEscandallo.FieldByName('porcen_primera_e').AsFloat / 100, -2);
    rAcum:=rAux;
    cdsAprovechaEntradas.FieldByName('kilos_primera').AsFloat:= cdsAprovechaEntradas.FieldByName('kilos_primera').AsFloat + rAux;
    rAux:= RoundTo( qryEscandallo.FieldByName('total_kgs_e2l').AsFloat * qryEscandallo.FieldByName('porcen_segunda_e').AsFloat / 100, -2);
    rAcum:=rAcum + rAux;
    cdsAprovechaEntradas.FieldByName('kilos_segunda').AsFloat:= cdsAprovechaEntradas.FieldByName('kilos_segunda').AsFloat + rAux;
    rAux:= RoundTo( qryEscandallo.FieldByName('total_kgs_e2l').AsFloat * qryEscandallo.FieldByName('porcen_tercera_e').AsFloat / 100, -2);
    rAcum:=rAcum + rAux;
    cdsAprovechaEntradas.FieldByName('kilos_tercera').AsFloat:= cdsAprovechaEntradas.FieldByName('kilos_tercera').AsFloat + rAux;
    rAux:= RoundTo( qryEscandallo.FieldByName('total_kgs_e2l').AsFloat - rAcum, -2 );
    cdsAprovechaEntradas.FieldByName('kilos_destrio').AsFloat:= cdsAprovechaEntradas.FieldByName('kilos_destrio').AsFloat + rAux;
  end;

  try
    cdsAprovechaEntradas.Post;
  except
    cdsAprovechaEntradas.Cancel;
    raise;
  end
end;

function TDMAprovechaEntradas.GetKey: string;
begin
  result:= qryEscandallo.FieldByName('empresa_e2l').AsString +
           ExpandZeros( qryEscandallo.FieldByName('centro_e2l').AsString, 3 ) +
           ExpandZeros( qryEscandallo.FieldByName('producto_e2l').AsString, 3 ) +
           qryEscandallo.FieldByName('rama_suelta').AsString +
           GetGrupo +
           ExpandZeros( GetCosechero, 3 ) +
           ExpandZeros( GetPlantacion, 3 ) +
           IntToStr( GetSemana ) +
           IntToStr( GetFecha ) +
           ExpandZeros( IntToStr( GetNumero ), 6 );
end;

function TDMAprovechaEntradas.GetFecha: integer;
begin
  case iPeriodo of
    0: result:= 0;
    1: result:= YearOf( qryEscandallo.FieldByName('fecha_e2l').AsDatetime );
    2: result:= YearOf( qryEscandallo.FieldByName('fecha_e2l').AsDatetime ) * 100 + MonthOf( qryEscandallo.FieldByName('fecha_e2l').AsDatetime );
    3: result:= YearOf( qryEscandallo.FieldByName('fecha_e2l').AsDatetime ) * 100 + WeekOfTheYear( qryEscandallo.FieldByName('fecha_e2l').AsDatetime );
    else result:= Trunc(qryEscandallo.FieldByName('fecha_e2l').AsFloat);
  end;
end;

function TDMAprovechaEntradas.GetGrupo: String;
begin
  result:= qryEscandallo.FieldByName('grupo').AsString;
end;

function TDMAprovechaEntradas.GetCosechero: string;
begin
  if iVerDetalles >= 1 then
  begin
    result:= qryEscandallo.FieldByName('cosechero_e2l').AsString;
  end
  else
  begin
    result:= ''
  end;
end;

function TDMAprovechaEntradas.GetPlantacion: string;
begin
  if iVerDetalles >= 2 then
  begin
    result:= qryEscandallo.FieldByName('plantacion_e2l').AsString;
  end
  else
  begin
    result:= '';
  end;
end;

function TDMAprovechaEntradas.GetSemana: integer;
begin
  if iVerDetalles >= 2 then
  begin
    result:= qryEscandallo.FieldByName('ano_sem_planta_e2l').AsInteger;
  end
  else
  begin
    result:= 0;
  end;
end;

function TDMAprovechaEntradas.GetNumero: integer;
begin
  case iPeriodo of
    5: result:= qryEscandallo.FieldByName('numero_entrada_e2l').AsInteger;
    else result:= 0;
  end;
end;

function TDMAprovechaEntradas.ExpandZeros( const AValue: string; const AZeros: integer ): string;
begin
  result:= Copy( AValue, 1, 3 );
  if length( result ) = 1 then result:= '00' + result
  else if length( result ) = 2 then result:= '0' + result;
end;

procedure TDMAprovechaEntradas.AddAprovechamientos;
begin
  qryAprovecha.ParamByName('empresa_e2l').AsString:= qryEscandallo.FieldByName('empresa_e2l').AsString;
  qryAprovecha.ParamByName('centro_e2l').AsString:= qryEscandallo.FieldByName('centro_e2l').AsString;
  qryAprovecha.ParamByName('fecha_e2l').AsDateTime:= qryEscandallo.FieldByName('fecha_e2l').AsDateTime;
  qryAprovecha.ParamByName('numero_entrada_e2l').AsInteger:= qryEscandallo.FieldByName('numero_entrada_e2l').AsInteger;
  qryAprovecha.ParamByName('producto_e2l').AsString:= qryEscandallo.FieldByName('producto_e2l').AsString;
  if qryEscandallo.FieldByName('grupo').AsString = 'T' then
  begin
   qryAprovecha.ParamByName('cosechero_e2l').AsString:= qryEscandallo.FieldByName('cosechero_e2l').AsString;
  end
  else
  begin
    qryAprovecha.ParamByName('cosechero_e2l').AsString:= qryEscandallo.FieldByName('cosechero_e2l').AsString;
    qryAprovecha.ParamByName('plantacion_e2l').AsString:= qryEscandallo.FieldByName('plantacion_e2l').AsString;
    qryAprovecha.ParamByName('ano_sem_planta_e2l').AsInteger:= qryEscandallo.FieldByName('ano_sem_planta_e2l').AsInteger;
  end;
  qryAprovecha.Open;
  try
    if not qryAprovecha.IsEmpty then
    begin
      while not qryAprovecha.Eof do
      begin
        AddAprovechamiento;
        qryAprovecha.Next;
      end;
    end
    else
    begin
      //No hay aprovechamientos
    end;
  finally
    qryAprovecha.Close;
  end;
end;



procedure TDMAprovechaEntradas.AddAprovechamiento;
var
  rAux: real;
begin
  cdsAprovechaEntradas.Edit;

  case qryAprovecha.FieldByName('categoria_ent').AsInteger of
    1: cdsAprovechaEntradas.FieldByName('aprovecha_primera').AsFloat:= cdsAprovechaEntradas.FieldByName('aprovecha_primera').AsFloat + qryAprovecha.FieldByName('kilos_aprovecha').AsFloat;
    2: cdsAprovechaEntradas.FieldByName('aprovecha_segunda').AsFloat:= cdsAprovechaEntradas.FieldByName('aprovecha_segunda').AsFloat + qryAprovecha.FieldByName('kilos_aprovecha').AsFloat;
    3: cdsAprovechaEntradas.FieldByName('aprovecha_tercera').AsFloat:= cdsAprovechaEntradas.FieldByName('aprovecha_tercera').AsFloat + qryAprovecha.FieldByName('kilos_aprovecha').AsFloat;
    4: cdsAprovechaEntradas.FieldByName('aprovecha_destrio').AsFloat:= cdsAprovechaEntradas.FieldByName('aprovecha_destrio').AsFloat + qryAprovecha.FieldByName('kilos_aprovecha').AsFloat;
  end;
  cdsAprovechaEntradas.FieldByName('sinasignar').AsFloat:=cdsAprovechaEntradas.FieldByName('sinasignar').AsFloat + qryAprovecha.FieldByName('kilos_sin').AsFloat;
  rAux:= cdsAprovechaEntradas.FieldByName('aprovecha_primera').AsFloat +  cdsAprovechaEntradas.FieldByName('aprovecha_segunda').AsFloat +
         cdsAprovechaEntradas.FieldByName('aprovecha_tercera').AsFloat +  cdsAprovechaEntradas.FieldByName('aprovecha_destrio').AsFloat +
         cdsAprovechaEntradas.FieldByName('sinasignar').AsFloat;
  cdsAprovechaEntradas.FieldByName('aprovecha_merma').AsFloat:= cdsAprovechaEntradas.FieldByName('kilos').AsFloat - rAux;

  try
    cdsAprovechaEntradas.Post;
  except
    cdsAprovechaEntradas.Cancel;
    raise;
  end
end;

end.


