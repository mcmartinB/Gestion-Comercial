unit DLAsignacionFederaciones;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMLAsignacionFederaciones = class(TDataModule)
    QListado: TQuery;
    qryKilosIn: TQuery;
    mtResumen: TkbmMemTable;
    qryKilosOut: TQuery;
    qryAlbaranesPorAsignar: TQuery;
    qryAsignarSalida: TQuery;
    qryAsignarTransito: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;

    function  KilosExportacion( const AEmpresa, ACentro, AProducto: string;
                                const AFechaIni, AFechaFin: TDateTime ): Real;
    function  KilosNacional( const AEmpresa, ACentro, AProducto: string;
                                const AFechaIni, AFechaFin: TDateTime ): Real;

    function  QuedanKilosPorAsignarExporta( const AKilos: Real ): integer;
    function  QuedanKilosPorAsignarNacional( const AKilos: Real ): integer;
    procedure AsignarFederacionSalida( const AFederacion: Integer );
    procedure AsignarFederacionTransito( const AFederacion: Integer );

    function  ResumenTexto( const AQuedan: Boolean = False ): string;

    procedure SQLKilosSalidas( const ANacional: boolean );
    procedure SQLAlbaranesPorAsignar( const ANacional: boolean );
    procedure SQLListado( const ANacional: boolean );

  public
    { Public declarations }
    function  ListadoAsignacionFederaciones( const AEmpresa, ACentro, AProducto: string;
                                    const AFechaIni, AFechaFin: TDateTime;
                                    const ANacional: Boolean  ): boolean;
    function KilosSalidaPorAsignacion( const AEmpresa, ACentro, AProducto: string;
                                    const AFechaIni, AFechaFin: TDateTime;
                                    var sTexto: String  ): boolean;
    procedure  AsignarFederaciones( var VTexto: string );
  end;

var
  DMLAsignacionFederaciones: TDMLAsignacionFederaciones;

implementation

{$R *.dfm}

uses UDMBaseDatos, bMath, bTextUtils, QLAsignacionFederaciones,
     DPreview, CReportes, UDMAuxDB;

procedure TDMLAsignacionFederaciones.DataModuleCreate(Sender: TObject);
begin
  with mtResumen do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('producto', ftString, 3, False);
    FieldDefs.Add('federacion', ftInteger, 0, False);
    FieldDefs.Add('kilos', ftFloat, 0, False);
    FieldDefs.Add('total', ftFloat, 0, False);
    FieldDefs.Add('porcentaje', ftFloat, 0, False);

    FieldDefs.Add('kilos_exporta', ftFloat, 0, False);
    FieldDefs.Add('kilos_exporta_total', ftFloat, 0, False);
    FieldDefs.Add('quedan_exporta', ftFloat, 0, False);
    FieldDefs.Add('asignados_exporta', ftFloat, 0, False);

    FieldDefs.Add('kilos_nacional', ftFloat, 0, False);
    FieldDefs.Add('kilos_nacional_total', ftFloat, 0, False);
    FieldDefs.Add('quedan_nacional', ftFloat, 0, False);
    FieldDefs.Add('asignados_nacional', ftFloat, 0, False);

    CreateTable;
    IndexDefs.Add('Index1','producto;federacion',[]);
    IndexName:= 'Index1';
    (*
    SortFields:= 'federacion';
    IndexFieldNames:= 'federacion';
    *)
  end;


  with qryKilosIn do
  begin
    SQL.Clear;
    SQL.Add(' select federacion_p, sum( total_kgs_e2l ) kilos_p ');
    SQL.Add(' from frf_entradas2_l, frf_plantaciones ');
    SQL.Add(' where empresa_e2l = :empresa ');
    SQL.Add(' and centro_e2l = :centro ');
    SQL.Add(' and fecha_e2l between :fechaini and :fechafin ');
    SQL.Add(' and producto_e2l = :producto ');
    SQL.Add(' and empresa_p = :empresa ');
    SQL.Add(' and cosechero_p = cosechero_e2l ');
    SQL.Add(' and plantacion_p = plantacion_e2l ');
    SQL.Add(' and ano_semana_p = ano_sem_planta_e2l ');
    SQL.Add(' and producto_p = :producto ');
    SQL.Add(' and nvl(federacion_p,0) <> 0 ');
    SQL.Add(' group by federacion_p ');
    SQL.Add(' order by federacion_p ');
  end;



  with qryAsignarTransito do
  begin
    SQL.Clear;
    SQL.Add('update frf_transitos_l ');
    SQL.Add('set federacion_tl = :federacion');
    SQL.Add('where empresa_tl = :empresa ');
    SQL.Add('and   centro_tl = :centro ');
    SQL.Add('and   referencia_tl = :albaran ');
    SQL.Add('and   fecha_tl = :fecha ');

    SQL.Add('and   producto_tl = :producto ');
    SQL.Add('and   envase_tl = :envase ');
    SQL.Add('and   categoria_tl = :categoria ');
    SQL.Add('and   calibre_tl = :calibre ');
    SQL.Add('and   centro_origen_tl = :centro ');
    SQL.Add('and   nvl(ref_origen_tl, '''') = '''' ');
  end;


  with qryAsignarSalida do
  begin
    SQL.Clear;
    SQL.Add('update frf_salidas_l ');
    SQL.Add('set federacion_sl = :federacion');
    SQL.Add('where empresa_sl = :empresa ');
    SQL.Add('and   centro_salida_sl = :centro ');
    SQL.Add('and   fecha_sl = :fecha ');
    SQL.Add('and   n_albaran_sl =:albaran ');
    SQL.Add('and   centro_origen_sl = :centro ');
    SQL.Add('and   producto_sl = :producto ');
    SQL.Add('and   envase_sl = :envase ');
    SQL.Add('and   categoria_sl = :categoria ');
    SQL.Add('and   calibre_sl = :calibre ');
    SQL.Add('and   nvl(ref_transitos_sl, '''') = '''' ');
  end;

end;

procedure TDMLAsignacionFederaciones.SQLAlbaranesPorAsignar( const ANacional: boolean );
begin
  with qryAlbaranesPorAsignar do
  begin
    SQL.Clear;
    SQL.Add('select "T" tipo, empresa_tl empresa, centro_tl centro, referencia_tl albaran, fecha_tl fecha, ');
    SQL.Add('           producto_tl producto, envase_tl envase, categoria_tl categoria, calibre_tl calibre, ');
    SQL.Add('           sum( kilos_tl ) kilos ');

    SQL.Add('from frf_transitos_l ');
    SQL.Add('     join frf_centros on empresa_c = empresa_tl and centro_c = centro_destino_tl ');

    SQL.Add('where empresa_tl = :empresa ');
    SQL.Add('and   fecha_tl between :fechaini and :fechafin ');
    SQL.Add('and   centro_tl = :centro ');
    SQL.Add('and   centro_origen_tl = :centro ');
    SQL.Add('And   producto_tl = :producto ');
    SQL.Add('and   nvl(ref_origen_tl,'''') = ''''  ');

    if ANacional then
      SQL.Add('and nvl(pais_c,''ES'') = ''ES'' ')
    else
      SQL.Add('and nvl(pais_c,''ES'') <> ''ES'' ');

    SQL.Add('group by tipo, empresa, centro, albaran, fecha, producto, envase, categoria, calibre ');

    SQL.Add('union ');

    SQL.Add('select "S" tipo, empresa_sc empresa, centro_salida_sc centro, n_albaran_sc albaran, fecha_sc fecha, ');
    SQL.Add('       producto_sl producto, envase_sl envase, categoria_sl categoria, calibre_sl calibre, ');
    SQL.Add('       sum( kilos_sl ) kilos ');

    SQL.Add('from frf_salidas_c ');
    SQL.Add('      join frf_clientes on cliente_sal_sc = cliente_c ');
    SQL.Add('      join frf_salidas_l on empresa_sl = empresa_sc and centro_salida_sl = centro_salida_sc and ');
    SQL.Add('                            fecha_sl = fecha_sc and n_albaran_sl = n_albaran_sc ');

    SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('and   fecha_sc between :fechaini and :fechafin ');
    SQL.Add('and   centro_salida_sc = :centro ');

    if ANacional then
      SQL.Add('and   nvl(pais_c,''ES'') = ''ES'' ')
    else
      SQL.Add('and   nvl(pais_c,''ES'') <> ''ES'' ');

    SQL.Add('and   centro_origen_sl = :centro ');
    SQL.Add('And   producto_sl = :producto ');
    SQL.Add('and   nvl(es_transito_sc,0) = 0 ');;
    SQL.Add('and   nvl(ref_transitos_sl, '''') = '''' ');

    SQL.Add('group by tipo, empresa, centro, albaran, fecha, producto, envase, categoria, calibre ');
    SQL.Add('order by kilos desc ');
  end;
end;

procedure TDMLAsignacionFederaciones.SQLKilosSalidas( const ANacional: boolean );
begin
  with qryKilosOut do
  begin
    SQL.Clear;

    SQL.Add('select sum(kilos_sl) kilos ');

    SQL.Add('from frf_salidas_c ');
    SQL.Add('      join frf_clientes on cliente_sal_sc = cliente_c ');
    SQL.Add('      join frf_salidas_l on empresa_sl = empresa_sc and centro_salida_sl = centro_salida_sc and ');
    SQL.Add('                            fecha_sl = fecha_sc and n_albaran_sl = n_albaran_sc ');

    SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('and   fecha_sc between :fechaini and :fechafin ');
    SQL.Add('and   centro_salida_sc = :centro ');

    if ANacional then
      SQL.Add('and   nvl(pais_c,''ES'') = ''ES'' ')
    else
      SQL.Add('and   nvl(pais_c,''ES'') <> ''ES'' ');

    SQL.Add('and   centro_origen_sl = :centro ');
    SQL.Add('And   producto_sl = :producto ');
    (*TODO*)
    //Salidas con fruta de un transito que venga del extranjero
    SQL.Add('and   nvl(es_transito_sc,0) = 0 ');
    SQL.Add('and   nvl(ref_transitos_sl, '''') = '''' ');

    SQL.Add('union ');

    SQL.Add('select sum(kilos_tl) kilos ');

    SQL.Add('from frf_transitos_l ');
    SQL.Add('     join frf_centros on empresa_c = empresa_tl and centro_c = centro_destino_tl ');

    SQL.Add('where empresa_tl = :empresa ');
    SQL.Add('and   fecha_tl between :fechaini and :fechafin ');
    SQL.Add('and   centro_tl = :centro ');
    SQL.Add('and   centro_origen_tl = :centro ');
    SQL.Add('And   producto_tl = :producto ');
    SQL.Add('and   nvl(ref_origen_tl,'''') = ''''  ');

    if ANacional then
      SQL.Add('and nvl(pais_c,''ES'') = ''ES'' ')
    else
     SQL.Add('and nvl(pais_c,''ES'') <> ''ES'' ');
  end;
end;


procedure TDMLAsignacionFederaciones.SQLListado( const ANacional: boolean );
begin
  with QListado do
  begin
    SQL.Clear;
    SQL.Add('select nvl(federacion_tl,0) federacion, ');
    SQL.Add('       "T" tipo, ');

    SQL.Add('       empresa_tl empresa, ');
    SQL.Add('       centro_tl centro, ');
    SQL.Add('       fecha_tl fecha, ');
    SQL.Add('       referencia_tl albaran, ');

    SQL.Add('       centro_origen_tl origen, ');
    SQL.Add('       centro_destino_tl destino, ');
    SQL.Add('       vehiculo_tc vehiculo, ');
    SQL.Add('       sum(kilos_tl) kilos ');

    SQL.Add('from frf_transitos_c, frf_transitos_l ');

    SQL.Add('where empresa_tc = :empresa ');
    SQL.Add('and   fecha_tc between :fechaini and :fechafin ');
    SQL.Add('and   centro_tc = :centro ');

    SQL.Add('and exists ');
    SQL.Add('( ');
    SQL.Add(' select * ');
    SQL.Add(' from frf_centros ');
    SQL.Add(' where empresa_c = :empresa ');
    SQL.Add('   and centro_c = centro_destino_tc ');
    if ANacional then
      SQL.Add('   and nvl(pais_c,''ES'') = ''ES'' ')
    else
      SQL.Add('   and nvl(pais_c,''ES'') <> ''ES'' ');
    SQL.Add(') ');

    SQL.Add('and empresa_tl = empresa_tc ');
    SQL.Add('and centro_tl = centro_tc ');
    SQL.Add('and referencia_tl = referencia_tc ');
    SQL.Add('and fecha_tl = fecha_tc ');

    SQL.Add('And producto_tl = :producto ');
    SQL.Add('and centro_origen_tl = :centro ');
    SQL.Add('and nvl(ref_origen_tl,'''') = ''''  ');

    SQL.Add('group by 1,2,3,4,5,6,7,8,9 ');

    SQL.Add('union ');

    SQL.Add('select nvl(federacion_sl,0) federacion, ');
    SQL.Add('       "S" tipo, ');

    SQL.Add('       empresa_sl empresa, ');
    SQL.Add('       centro_salida_sl centro, ');
    SQL.Add('       fecha_sl fecha, ');
    SQL.Add('       n_albaran_sl albaran, ');

    SQL.Add('       centro_origen_sl origen, ');
    SQL.Add('       cliente_sal_sc destino, ');
    SQL.Add('       vehiculo_sc vehiculo, ');
    SQL.Add('       sum(kilos_sl) kilos ');

    SQL.Add('from frf_salidas_c, frf_salidas_l ');

    SQL.Add('where empresa_sc = :empresa ');
    SQL.Add('and   fecha_sc between :fechaini and :fechafin ');
    SQL.Add('and   centro_salida_sc = :centro ');

    SQL.Add('and exists ');
    SQL.Add('( ');
    SQL.Add(' select * ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where cliente_c = cliente_sl ');
    if ANacional then
      SQL.Add('   and NVL(pais_c,''ES'') = ''ES'' ')
    else
      SQL.Add('   and NVL(pais_c,''ES'') <> ''ES'' ');
    SQL.Add(') ');

    SQL.Add('and empresa_sl = empresa_sc ');
    SQL.Add('and centro_salida_sl = centro_salida_sc ');
    SQL.Add('and n_albaran_sl = n_albaran_sc ');
    SQL.Add('and fecha_sl = fecha_sc ');

    SQL.Add('And producto_sl = :producto ');
    SQL.Add('and   centro_origen_sl = :centro ');
    SQL.Add('and nvl(es_transito_sc,0) = 0 ');
    SQL.Add('and nvl(ref_transitos_sl, '''') = '''' ');

    SQL.Add('group by 1,2,3,4,5,6,7,8,9 ');
    SQL.Add('order by 1,2,3,4,5,6,7,8,9 ');
  end;
end;


procedure TDMLAsignacionFederaciones.DataModuleDestroy(Sender: TObject);
begin
  mtResumen.Close;
  FreeAndNil( mtResumen );
end;

function TDMLAsignacionFederaciones.KilosSalidaPorAsignacion( const AEmpresa, ACentro, AProducto: string;
                                                           const AFechaIni, AFechaFin: TDateTime;
                                                           var sTexto: String ): boolean;
var
  rAux, rTotal, rMax, rPorcentaje: real;
  iFederacion: integer;
  bNacional: Boolean;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;

  with qryKilosIn do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaIni;
    ParamByName('fechafin').AsDate:= AFechaFin;
    ParamByName('producto').AsString:= AProducto;

    Open;

    iFederacion:= -1;
    rMax:= 0;
    rTotal:= 0;

    if IsEmpty then
    begin
      Close;
      sTexto:= 'SIN DATOS';
      result:= False;
    end
    else
    begin
      while not EOF do
      begin
        rTotal:= rTotal + FieldByName('kilos_p').AsFloat;
        if rMax < FieldByName('kilos_p').AsFloat then
        begin
          rMax:= FieldByName('kilos_p').AsFloat;
          iFederacion:= FieldByName('federacion_p').AsInteger;
        end;
        Next;
      end;

      First;
      mtResumen.Close;
      mtResumen.Open;
      rPorcentaje:= 0;
      while not EOF do
      begin
        mtResumen.Insert;
        mtResumen.FieldByName('producto').AsString:= AProducto;
        mtResumen.FieldByName('federacion').AsInteger:= FieldByName('federacion_p').AsInteger;
        mtResumen.FieldByName('kilos').AsFloat:= FieldByName('kilos_p').AsFloat;
        mtResumen.FieldByName('total').AsFloat:= rTotal;
        raux:= bRoundTo( ( FieldByName('kilos_p').AsFloat / rTotal ) * 100, -2 );
        mtResumen.FieldByName('porcentaje').AsFloat:= rAux;
        mtResumen.Post;
        rPorcentaje:= rPorcentaje + rAux;
        Next;
      end;
      mtResumen.Active:= not mtResumen.IsEmpty;

      Close;

      if rPorcentaje <> 100 then
      begin
        with mtResumen do
        begin
          First;
          while ( FieldByName('federacion').AsInteger <> iFederacion ) and not Eof do
          begin
            Next;
          end;
          Edit;
          mtResumen.FieldByName('porcentaje').AsFloat:= mtResumen.FieldByName('porcentaje').AsFloat +
                                                      (100 - rPorcentaje);
          Post;
        end;
      end;

      bNacional:= False;
      SQLKilosSalidas( bNacional );
      KilosExportacion( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin );
      bNacional:= True;
      SQLKilosSalidas( bNacional );
      KilosNacional( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin );
      result:= True;
      sTexto:= ResumenTexto;
    end;

  end;
end;

function  TDMLAsignacionFederaciones.KilosExportacion(
                                const AEmpresa, ACentro, AProducto: string;
                                const AFechaIni, AFechaFin: TDateTime ): Real;
var
  rAcum, rMayor: real;
begin
  with qryKilosOut do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaIni;
    ParamByName('fechafin').AsDate:= AFechaFin;
    ParamByName('producto').AsString:= AProducto;

    Open;
    result:= 0;
    while not eof do
    begin
      result:= result  + FieldByName('kilos').AsFloat;
      next;
    end;
    Close;
  end;
  rAcum:= 0;
  rMayor:= 0;
  with mtResumen do
  begin              
    First;
    while not EOF do
    begin
      Edit;
      FieldByName('kilos_exporta_total').AsFloat:= result;
      FieldByName('kilos_exporta').AsFloat:= bRoundTo( ( result * FieldByName('porcentaje').AsFloat ) / 100, -2 );
      FieldByName('quedan_exporta').AsFloat:= FieldByName('kilos_exporta').AsFloat;
      FieldByName('asignados_exporta').AsFloat:= 0;
      rAcum:= rAcum + FieldByName('kilos_exporta').AsFloat;
      if FieldByName('kilos_exporta').AsFloat > rMayor then
             rMayor:=  FieldByName('kilos_exporta').AsFloat;
      Post;
      Next;
    end;
    if rAcum <> result then
    begin
       rAcum:= bRoundTo(result - rAcum, -2 );
       if rAcum <> 0 then
       begin
         First;
         while not EOF do
         begin
           if FieldByName('kilos_exporta').AsFloat = rMayor then
           begin
             Edit;
             FieldByName('kilos_exporta').AsFloat:= FieldByName('kilos_exporta').AsFloat + rAcum;
             FieldByName('quedan_exporta').AsFloat:= FieldByName('kilos_exporta').AsFloat;
             Post;
             Last;
           end;
           Next;
         end;
       end;
    end;
  end;
end;

function  TDMLAsignacionFederaciones.KilosNacional(
                                const AEmpresa, ACentro, AProducto: string;
                                const AFechaIni, AFechaFin: TDateTime ): Real;
var
  rAcum, rMayor: real;
begin
  with qryKilosOut do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fechaini').AsDate:= AFechaIni;
    ParamByName('fechafin').AsDate:= AFechaFin;
    ParamByName('producto').AsString:= AProducto;

    Open;
    result:= 0;
    while not eof do
    begin
      result:= result  + FieldByName('kilos').AsFloat;
      next;
    end;
    Close;
  end;
  rAcum:= 0;
  rMayor:= 0;
  with mtResumen do
  begin
    First;
    while not EOF do
    begin
      Edit;
      FieldByName('kilos_nacional_total').AsFloat:= result;
      FieldByName('kilos_nacional').AsFloat:= bRoundTo( ( result * FieldByName('porcentaje').AsFloat ) / 100, -2 );
      FieldByName('quedan_nacional').AsFloat:= FieldByName('kilos_nacional').AsFloat;
      FieldByName('asignados_nacional').AsFloat:= 0;
      rAcum:= rAcum + FieldByName('kilos_nacional').AsFloat;
      if FieldByName('kilos_nacional').AsFloat > rMayor then
             rMayor:=  FieldByName('kilos_nacional').AsFloat;
      Post;
      Next;
    end;
    if rAcum <> result then
    begin
       rAcum:= bRoundTo(result - rAcum, -2 );
       if rAcum <> 0 then
       begin
         First;
         while not EOF do
         begin
           if FieldByName('kilos_nacional').AsFloat = rMayor then
           begin
             Edit;
             FieldByName('kilos_nacional').AsFloat:= FieldByName('kilos_nacional').AsFloat + rAcum;
             FieldByName('quedan_nacional').AsFloat:= FieldByName('kilos_nacional').AsFloat;
             Post;
             Last;
           end;
           Next;
         end;
       end;
    end;
  end;
end;

function  TDMLAsignacionFederaciones.ResumenTexto( const AQuedan: Boolean = False ): string;
var
  Lines: TStringList;
  sAux: string;
begin
  Lines:= TStringList.Create;
  if mtResumen.Active then
  with mtResumen do
  begin
    Prior;
    Lines.Clear;

    if not IsEmpty then
    begin
      sAux:= 'FEDERACIÓN  ENTRADA        %        EXPORTA';
      if  AQuedan then
         sAux:= sAux + '      ASIGNADOS';
      Lines.Add( sAux );

      sAux:= '-------------------------------------------';
      if  AQuedan then
         sAux:= sAux + '---------------';
      Lines.Add( sAux );

      First;
      while not EOF do
      begin
        sAux:= Rellena( FieldByName('federacion').AsString, 4, ' ', taRightJustify ) + ' ' +
                        Rellena( FormatFloat('#,##0.00', FieldByName('kilos').AsFloat ), 14, ' ', taLeftJustify ) + ' ' +
                        Rellena( FormatFloat('#,##0.00', FieldByName('porcentaje').AsFloat ), 8, ' ', taLeftJustify ) + ' ' +
                        Rellena( FormatFloat('#,##0.00', FieldByName('kilos_exporta').AsFloat ), 14, ' ', taLeftJustify );
        if AQuedan then
          sAux:= sAux + ' ' + Rellena( FormatFloat('#,##0.00', FieldByName('asignados_exporta').AsFloat ), 14, ' ', taLeftJustify );
        Lines.Add( sAux );
        Next;
      end;
      sAux:= '-------------------------------------------';
      if  AQuedan then
         sAux:= sAux + '---------------';
      Lines.Add( sAux );

      Lines.Add( Rellena( FormatFloat('#,##0.00', FieldByName('total').AsFloat ), 19, ' ', taLeftJustify ) + '   100,00' + ' ' +
                 Rellena( FormatFloat('#,##0.00', FieldByName('kilos_exporta_total').AsFloat ), 14, ' ', taLeftJustify ) );
    end;


    Prior;

    if not IsEmpty then
    begin
      Lines.Add( '' );

      sAux:= 'FEDERACIÓN  ENTRADA        %       NACIONAL';
      if  AQuedan then
         sAux:= sAux + '      ASIGNADOS';
      Lines.Add( sAux );

      sAux:= '-------------------------------------------';
      if  AQuedan then
         sAux:= sAux + '---------------';
      Lines.Add( sAux );

      First;
      while not EOF do
      begin
        sAux:= Rellena( FieldByName('federacion').AsString, 4, ' ', taRightJustify ) + ' ' +
                        Rellena( FormatFloat('#,##0.00', FieldByName('kilos').AsFloat ), 14, ' ', taLeftJustify ) + ' ' +
                        Rellena( FormatFloat('#,##0.00', FieldByName('porcentaje').AsFloat ), 8, ' ', taLeftJustify ) + ' ' +
                        Rellena( FormatFloat('#,##0.00', FieldByName('kilos_nacional').AsFloat ), 14, ' ', taLeftJustify );
        if AQuedan then
          sAux:= sAux + ' ' + Rellena( FormatFloat('#,##0.00', FieldByName('asignados_nacional').AsFloat ), 14, ' ', taLeftJustify );
        Lines.Add( sAux );
        Next;
      end;
      sAux:= '-------------------------------------------';
      if  AQuedan then
         sAux:= sAux + '---------------';
      Lines.Add( sAux );

      Lines.Add( Rellena( FormatFloat('#,##0.00', FieldByName('total').AsFloat ), 19, ' ', taLeftJustify ) + '   100,00' + ' ' +
                 Rellena( FormatFloat('#,##0.00', FieldByName('kilos_nacional_total').AsFloat ), 14, ' ', taLeftJustify ) );
    end;
  end;
  result:= Lines.Text;
  FreeAndNil( Lines );
end;

function TDMLAsignacionFederaciones.ListadoAsignacionFederaciones( const AEmpresa, ACentro, AProducto: string;
                                    const AFechaIni, AFechaFin: TDateTime; const ANacional: Boolean ): boolean;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;

  SQLListado( ANacional );
  with QListado do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('fechaini').AsDate:= dFechaIni;
    ParamByName('fechafin').AsDate:= dFechaFin;
    ParamByName('producto').AsString:= sProducto;

    Open;

    if IsEmpty then
    begin
      result:= False;
    end
    else
    begin
      result:= True;
      QRLLAsignacionFederaciones:= TQRLLAsignacionFederaciones.Create( self );
      try
        PonLogoGrupoBonnysa( QRLLAsignacionFederaciones, sEmpresa );
        if ANacional then
          QRLLAsignacionFederaciones.lblTitulo.Caption:= 'SALIDAS NACIONALES POR FEDERACIÓN'
        else
          QRLLAsignacionFederaciones.lblTitulo.Caption:= 'SALIDAS EXPORTACIÓN POR FEDERACIÓN';

        QRLLAsignacionFederaciones.lblCentro.Caption:= sCentro + ' ' + desCentro( sEmpresa, sCentro );
        QRLLAsignacionFederaciones.lblProducto.Caption:= sProducto + ' '  + desProducto( sEmpresa, sProducto );
        QRLLAsignacionFederaciones.lblFecha.Caption:= 'Del ' + DateToStr( dFechaIni ) +
                                                      ' al ' + DateToStr( dFechaFin );
        QRLLAsignacionFederaciones.lblTotalProducto.Caption:= 'TOTAL PRODUCTO [' + sProducto + ']';
        Preview( QRLLAsignacionFederaciones );
      except
        FreeAndNil ( QRLLAsignacionFederaciones );
      end;
    end;
    Close;
  end;
end;

procedure  TDMLAsignacionFederaciones.AsignarFederaciones( var VTexto: string );
var
  iFederacion: Integer;
  bNacional: Boolean;
begin
  bNacional:= False;
  SQLAlbaranesPorAsignar( bNacional );
  with qryAlbaranesPorAsignar do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('fechaini').AsDate:= dFechaIni;
    ParamByName('fechafin').AsDate:= dFechaFin;
    ParamByName('producto').AsString:= sProducto;

    Open;
    while not Eof do
    begin
      iFederacion:= QuedanKilosPorAsignarExporta( FieldByName('kilos').AsFloat );
      if FieldByName('tipo').AsString = 'S' then
        AsignarFederacionSalida( iFederacion )
      else
        AsignarFederacionTransito( iFederacion );
      Next;
    end;
    Close;
  end;

  bNacional:= True;
  SQLAlbaranesPorAsignar( bNacional );
  with qryAlbaranesPorAsignar do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('fechaini').AsDate:= dFechaIni;
    ParamByName('fechafin').AsDate:= dFechaFin;
    ParamByName('producto').AsString:= sProducto;

    Open;
    while not Eof do
    begin
      iFederacion:= QuedanKilosPorAsignarNacional( FieldByName('kilos').AsFloat );
      if FieldByName('tipo').AsString = 'S' then
        AsignarFederacionSalida( iFederacion )
      else
        AsignarFederacionTransito( iFederacion );
      Next;
    end;
    Close;
  end;
  VTexto:= ResumenTexto( True );
end;

function  TDMLAsignacionFederaciones.QuedanKilosPorAsignarExporta( const AKilos: real ): Integer;
var
  rMAX: Real;
  iPos, iCount:  Integer;
begin
  mtResumen.First;

  iCount:= 0;
  iPos:= iCount;
  rMAX:= mtResumen.FieldByName('quedan_exporta').AsFloat;
  result:= mtResumen.FieldByName('federacion').Asinteger;
  mtResumen.Next;

  while not mtResumen.Eof do
  begin
    inc( iCount );
    if rMAX <  mtResumen.FieldByName('quedan_exporta').AsFloat then
    begin
      iPos:= iCount;
      rMAX:= mtResumen.FieldByName('quedan_exporta').AsFloat;
      result:= mtResumen.FieldByName('federacion').Asinteger;
    end;
    mtResumen.Next;
  end;

  mtResumen.First;
  for ICount:= 1 to iPos do
  begin
    mtResumen.Next;
  end;
  mtResumen.Edit;
  mtResumen.FieldByName('quedan_exporta').AsFloat:= mtResumen.FieldByName('quedan_exporta').AsFloat - AKilos;
  mtResumen.FieldByName('asignados_exporta').AsFloat:= mtResumen.FieldByName('asignados_exporta').AsFloat + AKilos;
  mtResumen.Post;
end;

function  TDMLAsignacionFederaciones.QuedanKilosPorAsignarNacional( const AKilos: real ): Integer;
var
  rMAX: Real;
  iPos, iCount:  Integer;
begin
  mtResumen.First;

  iCount:= 0;
  iPos:= iCount;
  rMAX:= mtResumen.FieldByName('quedan_nacional').AsFloat;
  result:= mtResumen.FieldByName('federacion').Asinteger;
  mtResumen.Next;

  while not mtResumen.Eof do
  begin
    inc( iCount );
    if rMAX <  mtResumen.FieldByName('quedan_nacional').AsFloat then
    begin
      iPos:= iCount;
      rMAX:= mtResumen.FieldByName('quedan_nacional').AsFloat;
      result:= mtResumen.FieldByName('federacion').Asinteger;
    end;
    mtResumen.Next;
  end;

  mtResumen.First;
  for ICount:= 1 to iPos do
  begin
    mtResumen.Next;
  end;
  mtResumen.Edit;
  mtResumen.FieldByName('quedan_nacional').AsFloat:= mtResumen.FieldByName('quedan_nacional').AsFloat - AKilos;
  mtResumen.FieldByName('asignados_nacional').AsFloat:= mtResumen.FieldByName('asignados_nacional').AsFloat + AKilos;
  mtResumen.Post;
end;

procedure TDMLAsignacionFederaciones.AsignarFederacionSalida( const AFederacion: Integer );
begin
  with qryAsignarSalida do
  begin
    ParamByName('federacion').AsInteger:= AFederacion;
    ParamByName('empresa').AsString:= qryAlbaranesPorAsignar.fieldByname('empresa').AsString;
    ParamByName('centro').AsString:= qryAlbaranesPorAsignar.fieldByname('centro').AsString;
    ParamByName('fecha').AsDateTime:= qryAlbaranesPorAsignar.fieldByname('fecha').AsDateTime;
    ParamByName('producto').AsString:= qryAlbaranesPorAsignar.fieldByname('producto').AsString;
    ParamByName('envase').AsString:= qryAlbaranesPorAsignar.fieldByname('envase').AsString;
    ParamByName('categoria').AsString:= qryAlbaranesPorAsignar.fieldByname('categoria').AsString;
    ParamByName('calibre').AsString:= qryAlbaranesPorAsignar.fieldByname('calibre').AsString;
    ParamByName('albaran').AsString:= qryAlbaranesPorAsignar.fieldByname('albaran').AsString;
    ExecSQL;
  end;
end;

procedure TDMLAsignacionFederaciones.AsignarFederacionTransito( const AFederacion: Integer );
begin
  with qryAsignarTransito do
  begin
    ParamByName('federacion').AsInteger:= AFederacion;
    ParamByName('empresa').AsString:= qryAlbaranesPorAsignar.fieldByname('empresa').AsString;
    ParamByName('centro').AsString:= qryAlbaranesPorAsignar.fieldByname('centro').AsString;
    ParamByName('fecha').AsDateTime:= qryAlbaranesPorAsignar.fieldByname('fecha').AsDateTime;
    ParamByName('producto').AsString:= qryAlbaranesPorAsignar.fieldByname('producto').AsString;
    ParamByName('envase').AsString:= qryAlbaranesPorAsignar.fieldByname('envase').AsString;
    ParamByName('categoria').AsString:= qryAlbaranesPorAsignar.fieldByname('categoria').AsString;
    ParamByName('calibre').AsString:= qryAlbaranesPorAsignar.fieldByname('calibre').AsString;
    ParamByName('albaran').AsString:= qryAlbaranesPorAsignar.fieldByname('albaran').AsString;
    ExecSQL;
  end;
end;


end.
