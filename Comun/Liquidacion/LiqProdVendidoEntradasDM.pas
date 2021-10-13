unit LiqProdVendidoEntradasDM;

interface

uses
  SysUtils, Classes, DB, DBTables, LiqProdVendidoDM;

type
  TDMLiqProdVendidoEntradas = class(TDataModule)
    qryEntradasCos: TQuery;
    qryAux: TQuery;
    qryTransitosIn: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

    //Parametros de entrada
    sEmpresa, sCentro, sProducto, sSemana: string;
    dFechaIni, dFechaFin: TDateTime;

    iCodigo, iLinea: Integer;
    rKilosEntrada: R_KilosEntradas;

    procedure InicializarVariables;
    procedure Totales;
    procedure InsertarEntradas;
    procedure KilosLinea;
    procedure GrabarKilosEntrada( const ACategoria: string; const AKilos: Real );

    procedure InsertarTransitos;
    procedure GrabarKilosTransito;

    procedure PutKilosInventario( var AIni, AFin: Real );

    procedure AjustarKilosDe( const ACatIni, ACatFin: string; const AObjetivo, AInicio: Real );
    //procedure AjustarPrimera( const AObjetivo, AInicio: Real );
    //procedure AjustarSegunda( const AObjetivo, AInicio: Real );
    //procedure AjustarTercera( const AObjetivo, AInicio: Real );
    function AjustarKilos(const AObjetivo, AInicio: Real ): real;
    function Ajustes(const ACatDestino: string ): real;

  public
    { Public declarations }
     function  EntradasSemana(const ACodigo: Integer; const AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime ): R_KilosEntradas;
     procedure InventariosSemana( var AIni, AFin: Real );
     function  AplicarMerma(const AMerma: Real ): R_KilosEntradas;
     function AjustarEntradas( const AKilosVentas: R_KilosSalidas; const AUltimaPasada: boolean = False  ): R_KilosEntradas;
  end;

var
  DMLiqProdVendidoEntradas: TDMLiqProdVendidoEntradas;

implementation

{$R *.dfm}

uses
  Math, bMath, bTimeUtils, Dialogs, Variants, DateUtils;

function StrHourToInt( const AHora: string ): Integer;
begin
  result:= StrToIntDef(  StringReplace( AHora, ':', '',[]), 0);
end;

procedure TDMLiqProdVendidoEntradas.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TDMLiqProdVendidoEntradas.DataModuleCreate(Sender: TObject);
begin
  with qryEntradasCos do
  begin
    SQL.Clear;
    SQL.Add('select empresa_ec, centro_Ec, numero_entrada_ec, fecha_ec, hora_ec, peso_neto_ec, ');
    //SQL.Add('       producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, total_kgs_e2l, ');
    //Sin E ( case when producto_e2l = ''E'' then ''T'' else producto_e2l end )
    SQL.Add('       ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ), cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, total_kgs_e2l, ');
    SQL.Add('       nvl(tipo_entrada_e,0) tipo, porcen_primera_e, porcen_segunda_e, porcen_tercera_e, porcen_destrio_e ');
    SQL.Add('from frf_entradas_c ');
    SQL.Add('     join frf_entradas2_l on empresa_ec = empresa_e2l and centro_Ec = centro_E2l ');
    SQL.Add('                          and numero_entrada_ec = numero_entrada_e2l and fecha_ec = fecha_e2l ');
    SQL.Add('     left join frf_escandallo on empresa_ec = empresa_e and centro_Ec = centro_E ');
    SQL.Add('                          and numero_entrada_ec = numero_entrada_e and fecha_ec = fecha_e ');
    //SQL.Add('                          and producto_e2l = producto_e and cosechero_e2l = cosechero_e ');
    //Sin E ( case when producto_e2l = ''E'' then ''T'' else producto_e2l end )
    SQL.Add('                          and ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ) = ( case when producto_e = ''TOM'' then ''TOM'' else producto_e end ) ');
    SQL.Add('                          and cosechero_e2l = cosechero_e ');
    SQL.Add('                          and plantacion_e2l = plantacion_e and ano_sem_planta_e2l = anyo_semana_e ');
    if sEmpresa = 'SAT' then
      SQL.Add('where empresa_Ec in ( ''050'',''080'' ) ')
    else
      SQL.Add('where empresa_Ec = :empresa ');
    SQL.Add('and centro_ec = :centro ');
    SQL.Add('and fecha_ec between :fechaini and :fechafin ');

    //SQL.Add('and producto_e2l  = :producto ');
    //Sin E  ( case when producto_e2l = ''E'' then ''T'' else producto_e2l end )
    SQL.Add('and ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ) = :producto ');
    SQL.Add('order by  empresa_ec, producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, centro_Ec, fecha_ec, numero_entrada_ec  ');
  end;

  with qryTransitosIn do
  begin
    Sql.Clear;
    Sql.Add('select empresa_tl empresa, centro_tl centro_sal, month(fecha_tl) mes, year(fecha_tl) anyo, ');
    Sql.Add('       referencia_tl referencia, nvl(fecha_entrada_tc,fecha_tl) fecha_ent,  nvl(hora_entrada_tc,''12:00'') hora, fecha_tl fecha_tra,');
    //Sql.Add('       producto_tl producto, categoria_tl categoria, envase_tl envase, kilos_tl kilos ');
    //Sin E ( case when producto_e2l = ''E'' then ''T'' else producto_e2l end )
    Sql.Add('       ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) producto, categoria_tl categoria, envase_tl envase, kilos_tl kilos ');
    Sql.Add('from frf_transitos_c ');
    Sql.Add('     join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
    Sql.Add('                          and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
    if sEmpresa = 'SAT' then
      Sql.Add('where empresa_tl in ( ''050'',''080'' ) ')
    else
      Sql.Add('where empresa_tl = :empresa ');
    Sql.Add(' and centro_destino_tl = :centro ');
    //Sql.Add(' and producto_tl = :producto ');
    //Sin E ( case when producto_e2l = ''E'' then ''T'' else producto_e2l end )
    Sql.Add(' and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto ');
    Sql.Add(' and nvl(fecha_entrada_tc,fecha_tl) between :fechaini and :fechafin ');
  end;
end;


procedure TDMLiqProdVendidoEntradas.InicializarVariables;
begin
  rKilosEntrada.rKilosPrimera:= 0;
  rKilosEntrada.rKilosSegunda:= 0;
  rKilosEntrada.rKilosTercera:= 0;
  rKilosEntrada.rKilosDestrio:= 0;
  rKilosEntrada.rKilosTotal:= 0;

  //entradas
  rKilosEntrada.reKilosPrimera:= 0;
  rKilosEntrada.reKilosSegunda:= 0;
  rKilosEntrada.reKilosTercera:= 0;
  rKilosEntrada.reKilosDestrio:= 0;
  rKilosEntrada.reKilosTotal:= 0;

  //Transitos
  rKilosEntrada.rtKilosPrimera:= 0;
  rKilosEntrada.rtKilosSegunda:= 0;
  rKilosEntrada.rtKilosTercera:= 0;
  rKilosEntrada.rtKilosDestrio:= 0;
  rKilosEntrada.rtKilosTotal:= 0;

  //origen entrada
  rKilosEntrada.rKilosSeleccionado:= 0;
  rKilosEntrada.rKilosIndustria:= 0;
  rKilosEntrada.rKilosCompras:= 0;
  rKilosEntrada.rKilosAlmacen:= 0;

  //Con merma
  rKilosEntrada.rmKilosPrimera:= 0;
  rKilosEntrada.rmKilosSegunda:= 0;
  rKilosEntrada.rmKilosTercera:= 0;
  rKilosEntrada.rmKilosDestrio:= 0;
  rKilosEntrada.rmKilosTotal:= 0;

  //Ajustados, a liquidar
  rKilosEntrada.rlKilosPrimera:= 0;
  rKilosEntrada.rlKilosSegunda:= 0;
  rKilosEntrada.rlKilosTercera:= 0;
  rKilosEntrada.rlKilosDestrio:= 0;
  rKilosEntrada.rlKilosTotal:= 0;

  iLinea:= 0;
end;

procedure TDMLiqProdVendidoEntradas.Totales;
begin
  rKilosEntrada.rKilosPrimera:= rKilosEntrada.reKilosPrimera + rKilosEntrada.rtKilosPrimera;
  rKilosEntrada.rKilosSegunda:= rKilosEntrada.reKilosSegunda + rKilosEntrada.rtKilosSegunda;
  rKilosEntrada.rKilosTercera:= rKilosEntrada.reKilosTercera + rKilosEntrada.rtKilosTercera;
  rKilosEntrada.rKilosDestrio:= rKilosEntrada.reKilosDestrio + rKilosEntrada.rtKilosDestrio;

  rKilosEntrada.rKilosTotal:= rKilosEntrada.rKilosPrimera +
                               rKilosEntrada.rKilosSegunda +
                               rKilosEntrada.rKilosTercera +
                               rKilosEntrada.rKilosDestrio;

  rKilosEntrada.reKilosTotal:= rKilosEntrada.reKilosPrimera +
                               rKilosEntrada.reKilosSegunda +
                               rKilosEntrada.reKilosTercera +
                               rKilosEntrada.reKilosDestrio;

  rKilosEntrada.rtKilosTotal:= rKilosEntrada.rtKilosPrimera +
                               rKilosEntrada.rtKilosSegunda +
                               rKilosEntrada.rtKilosTercera +
                               rKilosEntrada.rtKilosDestrio;
end;

//const AKilosVenta, AKilosTranIn, AKilosTranOut, AKilosIni, AKilosFin: Real;
function TDMLiqProdVendidoEntradas.EntradasSemana( const ACodigo: Integer; const  AEmpresa, ACentro, AProducto, ASemana: string;
                             const ADesde, AHasta: TDateTime):R_KilosEntradas;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  sProducto:= AProducto;
  dFechaIni:= ADesde;
  dFechaFin:= AHasta;
  sSemana:= ASemana;
  iCodigo:= ACodigo;

  InicializarVariables;

  with qryEntradasCos do
  begin
    SQL.Clear;
    SQL.Add('select empresa_ec, centro_Ec, numero_entrada_ec, fecha_ec, hora_ec, peso_neto_ec, ');
    //SQL.Add('       producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, total_kgs_e2l, ');
    //Sin E ( case when producto_e2l = ''E'' then ''T'' else producto_e2l end )
    SQL.Add('       ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ), cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, total_kgs_e2l, ');
    SQL.Add('       nvl(tipo_entrada_e,0) tipo, porcen_primera_e, porcen_segunda_e, porcen_tercera_e, porcen_destrio_e ');
    SQL.Add('from frf_entradas_c ');
    SQL.Add('     join frf_entradas2_l on empresa_ec = empresa_e2l and centro_Ec = centro_E2l ');
    SQL.Add('                          and numero_entrada_ec = numero_entrada_e2l and fecha_ec = fecha_e2l ');
    SQL.Add('     left join frf_escandallo on empresa_ec = empresa_e and centro_Ec = centro_E ');
    SQL.Add('                          and numero_entrada_ec = numero_entrada_e and fecha_ec = fecha_e ');
    //SQL.Add('                          and producto_e2l = producto_e and cosechero_e2l = cosechero_e ');
    //Sin E ( case when producto_e2l = ''E'' then ''T'' else producto_e2l end )
    SQL.Add('                          and ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ) = ( case when producto_e = ''TOM'' then ''TOM'' else producto_e end ) ');
    SQL.Add('                          and cosechero_e2l = cosechero_e ');
    SQL.Add('                          and plantacion_e2l = plantacion_e and ano_sem_planta_e2l = anyo_semana_e ');
    if sEmpresa = 'SAT' then
      SQL.Add('where empresa_Ec in ( ''050'',''080'' ) ')
    else
      SQL.Add('where empresa_Ec = :empresa ');
    SQL.Add('and centro_ec = :centro ');
    SQL.Add('and fecha_ec between :fechaini and :fechafin ');

    //SQL.Add('and producto_e2l  = :producto ');
    //Sin E  ( case when producto_e2l = ''E'' then ''T'' else producto_e2l end )
    SQL.Add('and ( case when producto_e2l = ''TOM'' then ''TOM'' else producto_e2l end ) = :producto ');
    SQL.Add('order by  empresa_ec, producto_e2l, cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, centro_Ec, fecha_ec, numero_entrada_ec  ');

    if sEmpresa <> 'SAT' then
      ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    ParamByName('fechafin').AsDateTime:= dFechaFin;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;

    Open;
    try
      if not IsEmpty then
      begin
          InsertarEntradas;
      end ;
    finally
      Close;
    end;
  end;

  with qryTransitosIn do
  begin
    Sql.Clear;
    Sql.Add('select empresa_tl empresa, centro_tl centro_sal, month(fecha_tl) mes, year(fecha_tl) anyo, ');
    Sql.Add('       referencia_tl referencia, nvl(fecha_entrada_tc,fecha_tl) fecha_ent,  nvl(hora_entrada_tc,''12:00'') hora, fecha_tl fecha_tra,');
    //Sql.Add('       producto_tl producto, categoria_tl categoria, envase_tl envase, kilos_tl kilos ');
    //Sin E ( case when producto_e2l = ''E'' then ''T'' else producto_e2l end )
    Sql.Add('       ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) producto, categoria_tl categoria, envase_tl envase, kilos_tl kilos ');
    Sql.Add('from frf_transitos_c ');
    Sql.Add('     join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
    Sql.Add('                          and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
    if sEmpresa = 'SAT' then
      Sql.Add('where empresa_tl in ( ''050'',''080'' ) ')
    else
      Sql.Add('where empresa_tl = :empresa ');
    Sql.Add(' and centro_destino_tl = :centro ');
    //Sql.Add(' and producto_tl = :producto ');
    //Sin E ( case when producto_e2l = ''E'' then ''T'' else producto_e2l end )
    Sql.Add(' and ( case when producto_tl = ''TOM'' then ''TOM'' else producto_tl end ) = :producto ');
    Sql.Add(' and nvl(fecha_entrada_tc,fecha_tl) between :fechaini and :fechafin ');

    if sEmpresa <> 'SAT' then
      ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('fechaini').AsDateTime:= dFechaIni;
    if DMLiqProdVendido.bSoloAjuste then
      ParamByName('fechafin').AsDateTime:= dFechaFin
    else
      if ((sProducto = 'PIB') or (sProducto = 'PIJ')) and (sCentro = '1') and (DateToStr(dFechaIni) = '28/09/2020')  and (DateToStr(dFechafin) = '04/10/2020') then       //Semana 202040
        ParamByName('fechafin').AsDateTime := dFechaFin + 7
      else
        ParamByName('fechafin').AsDateTime := dFechaFin;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;

    Open;
    try
      if not IsEmpty then
      begin
        InsertarTransitos;
      end ;
    finally
      Close;
    end;
  end;

  Totales;
  Result:= rKilosEntrada;
end;

procedure TDMLiqProdVendidoEntradas.InsertarEntradas;
begin
   while not qryEntradasCos.Eof do
   begin
     KilosLinea;
     qryEntradasCos.Next;
   end;
end;

procedure TDMLiqProdVendidoEntradas.InsertarTransitos;
begin
   while not qryTransitosIn.Eof do
   begin
     GrabarKilosTransito;
     qryTransitosIn.Next;
   end;
end;

procedure TDMLiqProdVendidoEntradas.KilosLinea;
VAR
  rKilosPrimera, rKilosSegunda, rKilosTercera, rKilosDestrio: REAL;
begin
  if  ( qryEntradasCos.FieldByName('porcen_primera_e').AsFloat +
      qryEntradasCos.FieldByName('porcen_segunda_e').AsFloat +
      qryEntradasCos.FieldByName('porcen_tercera_e').AsFloat +
      qryEntradasCos.FieldByName('porcen_destrio_e').AsFloat ) <> 0 then
  begin

    rKilosPrimera:= bRoundTo( qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat * ( qryEntradasCos.FieldByName('porcen_primera_e').AsFloat / 100 ), 2);
    rKilosSegunda:= bRoundTo( qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat * ( qryEntradasCos.FieldByName('porcen_segunda_e').AsFloat / 100 ), 2);
    rKilosTercera:= bRoundTo( qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat * ( qryEntradasCos.FieldByName('porcen_tercera_e').AsFloat / 100 ), 2);
    rKilosDestrio:= bRoundTo( qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat * ( qryEntradasCos.FieldByName('porcen_destrio_e').AsFloat / 100 ), 2);
  end
  else
  begin
    rKilosPrimera:= qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat;
    rKilosSegunda:= 0;
    rKilosTercera:= 0;
    rKilosDestrio:= 0;
  end;

  rKilosEntrada.reKilosPrimera:= rKilosEntrada.reKilosPrimera + rKilosPrimera;
  rKilosEntrada.reKilosSegunda:= rKilosEntrada.reKilosSegunda + rKilosSegunda;
  rKilosEntrada.reKilosTercera:= rKilosEntrada.reKilosTercera + rKilosTercera;
  rKilosEntrada.reKilosDestrio:= rKilosEntrada.reKilosDestrio + rKilosDestrio;

  if qryEntradasCos.FieldByName('tipo').AsInteger = 1 then
  begin
    //Seleccionado/Directos
    rKilosEntrada.rKilosSeleccionado:= rKilosEntrada.rKilosSeleccionado + qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat;
  end
  else
  if qryEntradasCos.FieldByName('tipo').AsInteger = 2 then
  begin
    //Industria
    rKilosEntrada.rKilosIndustria:= rKilosEntrada.rKilosIndustria + qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat;
  end
  else
  if qryEntradasCos.FieldByName('tipo').AsInteger = 3 then
  begin
    //Compra
    rKilosEntrada.rKilosCompras:= rKilosEntrada.rKilosCompras + qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat;
  end
  else
  begin
    //Normal
    rKilosEntrada.rKilosAlmacen:= rKilosEntrada.rKilosAlmacen + qryEntradasCos.FieldByName('total_kgs_e2l').AsFloat;
  end;

  if rKilosPrimera <> 0 then
    GrabarKilosEntrada( '1', rKilosPrimera );
  if rKilosSegunda <> 0 then
    GrabarKilosEntrada( '2', rKilosSegunda );
  if rKilosTercera <> 0 then
    GrabarKilosEntrada( '3', rKilosTercera );
  if rKilosDestrio <> 0 then
    GrabarKilosEntrada( '4', rKilosDestrio );
end;

procedure TDMLiqProdVendidoEntradas.GrabarKilosEntrada( const ACategoria: string; const AKilos: Real );
begin
  with DMLiqProdVendido do
  begin
    Inc( iLinea );
    kmtEntradas.Insert;
    kmtEntradas.FieldByName('codigo_ent').AsInteger:= iCodigo;
    kmtEntradas.FieldByName('linea_ent').AsInteger:= iLinea;
    kmtEntradas.FieldByName('origen_ent').AsString:= 'E';

    kmtEntradas.FieldByName('empresa_ent').AsString:= sEmpresa;
    kmtEntradas.FieldByName('centro_ent').AsString:= sCentro;
    kmtEntradas.FieldByName('n_entrada').AsInteger:= qryEntradasCos.FieldByName('numero_entrada_ec').AsInteger;
    kmtEntradas.FieldByName('fecha_ent').AsDateTime:= qryEntradasCos.FieldByName('fecha_ec').AsDateTime;
    kmtEntradas.FieldByName('hora_ent').AsInteger:= StrHourToInt( qryEntradasCos.FieldByName('hora_ec').AsString );

    kmtEntradas.FieldByName('producto_ent').AsString:= sProducto;
    kmtEntradas.FieldByName('cosechero_ent').AsInteger:= qryEntradasCos.FieldByName('cosechero_e2l').AsInteger;
    kmtEntradas.FieldByName('plantacion_ent').AsInteger:= qryEntradasCos.FieldByName('plantacion_e2l').AsInteger;
    kmtEntradas.FieldByName('semana_planta_ent').AsString:= qryEntradasCos.FieldByName('ano_sem_planta_e2l').AsString;
    kmtEntradas.FieldByName('fecha_origen_ent').AsDateTime:= qryEntradasCos.FieldByName('fecha_ec').AsDateTime;
    kmtEntradas.FieldByName('centro_origen_ent').AsString:= '';

    //0: normal 1:Seleccionado 2:Industria 3:Compras 4:Transito
    kmtEntradas.FieldByName('tipo_ent').AsInteger:= qryEntradasCos.FieldByName('tipo').AsInteger;
    kmtEntradas.FieldByName('envase_ent').AsString:= ''; //qryEntradasCos.FieldByName('envase').AsString;

    kmtEntradas.FieldByName('categoria_ent').AsString:= ACategoria;
    kmtEntradas.FieldByName('kilos_ent').AsFloat:= AKilos;

    kmtEntradas.Post;
  end;

end;

procedure TDMLiqProdVendidoEntradas.GrabarKilosTransito;
begin
  with DMLiqProdVendido do
  begin
    Inc( iLinea );

    kmtEntradas.Insert;
    kmtEntradas.FieldByName('codigo_ent').AsInteger:= iCodigo;
    kmtEntradas.FieldByName('linea_ent').AsInteger:= iLinea;
    kmtEntradas.FieldByName('origen_ent').AsString:= 'T';

    kmtEntradas.FieldByName('empresa_ent').AsString:= sEmpresa;
    kmtEntradas.FieldByName('centro_ent').AsString:= sCentro;
    kmtEntradas.FieldByName('n_entrada').AsInteger:= qryTransitosIn.FieldByName('referencia').AsInteger;
    kmtEntradas.FieldByName('fecha_ent').AsDateTime:= qryTransitosIn.FieldByName('fecha_ent').AsDateTime;
    kmtEntradas.FieldByName('hora_ent').AsInteger:= StrHourToInt( qryTransitosIn.FieldByName('hora').AsString );

    kmtEntradas.FieldByName('producto_ent').AsString:= sProducto;
    kmtEntradas.FieldByName('cosechero_ent').AsInteger:= -1;
    kmtEntradas.FieldByName('plantacion_ent').AsInteger:= -1;
    kmtEntradas.FieldByName('semana_planta_ent').AsString:= '';
    kmtEntradas.FieldByName('fecha_origen_ent').AsDateTime:= qryTransitosIn.FieldByName('fecha_tra').AsDateTime;
    kmtEntradas.FieldByName('centro_origen_ent').AsString:= qryTransitosIn.FieldByName('centro_sal').AsString;

    //0: normal 1:Seleccionado 2:Industria 3:Compras 4:Transito
    kmtEntradas.FieldByName('tipo_ent').AsInteger:= 4;
    kmtEntradas.FieldByName('envase_ent').AsString:= qryTransitosIn.FieldByName('envase').AsString;

    kmtEntradas.FieldByName('categoria_ent').AsString:= qryTransitosIn.FieldByName('categoria').AsString;
    kmtEntradas.FieldByName('kilos_ent').AsFloat:= qryTransitosIn.FieldByName('kilos').AsFloat;

    kmtEntradas.Post;
  end;

  if qryTransitosIn.FieldByName('categoria').AsInteger = 1 then
  begin
    //Seleccionado/Directos
    rKilosEntrada.rtKilosPrimera:= rKilosEntrada.rtKilosPrimera + qryTransitosIn.FieldByName('kilos').AsFloat;
  end
  else
  if qryTransitosIn.FieldByName('categoria').AsInteger = 2 then
  begin
    //Industria
    rKilosEntrada.rtKilosSegunda:= rKilosEntrada.rtKilosSegunda + qryTransitosIn.FieldByName('kilos').AsFloat;
  end
  else
  if qryTransitosIn.FieldByName('categoria').AsInteger = 3 then
  begin
    //Compra
    rKilosEntrada.rtKilosTercera:= rKilosEntrada.rtKilosTercera + qryTransitosIn.FieldByName('kilos').AsFloat;
  end
  else
  begin
    //Destrio
    rKilosEntrada.rtKilosDestrio:= rKilosEntrada.rtKilosDestrio + qryTransitosIn.FieldByName('kilos').AsFloat;
  end;
end;

function TDMLiqProdVendidoEntradas.AplicarMerma(const AMerma: Real ): R_KilosEntradas;
var
  rFactor, rKilos: Real;
  //, rMerma
  sEntrada: string;
begin
  if rKilosEntrada.rKilosTotal > 0 then
  begin
    rFactor:= 1 - ( AMerma / rKilosEntrada.rKilosTotal );
  end
  else
  begin
    rFactor:= 1;
  end;

  //rMerma:= 0;

  rKilosEntrada.rmKilosPrimera:= 0;
  rKilosEntrada.rmKilosSegunda:= 0;
  rKilosEntrada.rmKilosTercera:= 0;
  rKilosEntrada.rmKilosDestrio:= 0;

  with DMLiqProdVendido do
  begin
    kmtEntradas.First;
    while not kmtEntradas.Eof do
    begin
      if kmtEntradas.FieldByName('tipo_ent').AsInteger = 3 then   // si es compra no se calcula el aprovechamiento - Veronica 01/10/2018
        rKilos :=  kmtEntradas.fieldByName('kilos_ent').AsFloat
      else
        rKilos:= roundto( kmtEntradas.fieldByName('kilos_ent').AsFloat * rFactor, -2 );

      //rMerma:= rMerma + kmtEntradas.fieldByName('kilos_ent').AsFloat - rKilos;
      kmtEntradas.Edit;
      kmtEntradas.fieldByName('kilos_ent_net').AsFloat:= rKilos;
      kmtEntradas.fieldByName('kilos_ent_liq').AsFloat:= rKilos;
      kmtEntradas.Post;

      if kmtEntradas.fieldByName('categoria_ent').AsInteger = 1 then
        rKilosEntrada.rmKilosPrimera:= rKilosEntrada.rmKilosPrimera  + rKilos;
      if kmtEntradas.fieldByName('categoria_ent').AsInteger = 2 then
        rKilosEntrada.rmKilosSegunda:= rKilosEntrada.rmKilosSegunda  + rKilos;
      if kmtEntradas.fieldByName('categoria_ent').AsInteger = 3 then
        rKilosEntrada.rmKilosTercera:= rKilosEntrada.rmKilosTercera  + rKilos;
      if kmtEntradas.fieldByName('categoria_ent').AsInteger = 4 then
        rKilosEntrada.rmKilosDestrio:= rKilosEntrada.rmKilosDestrio  + rKilos;
      kmtEntradas.Next;
    end;
  end;

  rKilosEntrada.rmKilosTotal:= rKilosEntrada.rmKilosPrimera + rKilosEntrada.rmKilosSegunda +
                               rKilosEntrada.rmKilosTercera + rKilosEntrada.rmKilosDestrio;

  rKilosEntrada.rlKilosTotal:= rKilosEntrada.rmKilosTotal;
  rKilosEntrada.rlKilosPrimera:= rKilosEntrada.rmKilosPrimera;
  rKilosEntrada.rlKilosSegunda:= rKilosEntrada.rmKilosSegunda;
  rKilosEntrada.rlKilosTercera:= rKilosEntrada.rmKilosTercera;
  rKilosEntrada.rlKilosDestrio:= rKilosEntrada.rmKilosDestrio;

  result:=rKilosEntrada;
end;

procedure TDMLiqProdVendidoEntradas.InventariosSemana( var AIni, AFin: Real );
begin
  PutKilosInventario( AIni, AFin );
end;


procedure TDMLiqProdVendidoEntradas.PutKilosInventario( var AIni, AFin: Real );
var
  rAux: Real;
begin
  AIni:= 0;
  AFin:= 0;
  with qryAux  do
  begin
    Sql.Clear;
    Sql.Add('select sum(nvl(kilos_cec_ic,0) + ');
    Sql.Add('       nvl(kilos_cim_c1_ic,0) + nvl(kilos_cia_c1_ic,0) + ');
    Sql.Add('       nvl(kilos_cim_c2_ic,0) + nvl(kilos_cia_c2_ic,0) + ');
    Sql.Add('       nvl(kilos_zd_c3_ic,0) + ');
    Sql.Add('       nvl(kilos_zd_d_ic,0) ) stock ');
    Sql.Add('from frf_inventarios_c ');
    Sql.Add('where empresa_ic = :empresa ');
    Sql.Add('and centro_ic = :centro  ');
    //Sql.Add('and producto_ic = :producto ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    Sql.Add('and ( case when producto_ic = ''TOM'' then ''TOM'' else producto_ic end ) = :producto ');
    Sql.Add('and fecha_ic = :fecha ');
    if sEmpresa <> 'SAT' then
      ParamByName('empresa').AsString:= sEmpresa
    else
    begin
      if (dFechaIni - 1) <= StrToDate('31/12/2018') then
        ParamByName('empresa').AsString:= '080'
      else
        ParamByName('empresa').AsString:= '050'
    end;

    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fecha').AsDateTime:= ( dFechaIni - 1 );
    Open;
    try
      if IsEmpty then
        DMLiqProdVendido.AddWarning( 'Falta inventario de inico' )
      else
      begin
        (*TODO*) //activar semana anterior para stock ini
        AIni:= FieldByName('stock').AsFloat;
      end;
    finally
      Close;
    end;

    if sEmpresa <> 'SAT' then
      ParamByName('empresa').AsString:= sEmpresa
    else
    begin
      if (dFechaFin) <= StrToDate('31/12/2018') then
        ParamByName('empresa').AsString:= '080'
      else
        ParamByName('empresa').AsString:= '050'
    end;
    ParamByName('fecha').AsDateTime:= ( dFechaFin );
    Open;
    try
      if IsEmpty then
        DMLiqProdVendido.AddWarning( 'Falta inventario de fin' )
      else
      begin
        (*TODO*) //activar semana anterior para stock ini
        begin
          AFin:= FieldByName('stock').AsFloat;
        end;
      end;
    finally
      Close;
    end;

    Sql.Clear;
    Sql.Add('select sum(nvl(kilos_ce_c1_il,0)+nvl(kilos_ce_c2_il,0)) confeccionado ');
    Sql.Add('from frf_inventarios_l ');
    Sql.Add('where empresa_il = :empresa ');
    Sql.Add('and centro_il = :centro  ');
    //Sql.Add('and producto_il = :producto ');
    //Sin E ( case when producto_ = ''E'' then ''T'' else producto_ end )
    Sql.Add('and ( case when producto_il = ''TOM'' then ''TOM'' else producto_il end ) = :producto ');
    Sql.Add('and fecha_il = :fecha ');

    if sEmpresa <> 'SAT' then
      ParamByName('empresa').AsString:= sEmpresa
    else
    begin
      if (dFechaIni - 1) <= StrToDate('31/12/2018') then
        ParamByName('empresa').AsString:= '080'
      else
        ParamByName('empresa').AsString:= '050'
    end;

    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fecha').AsDateTime:= ( dFechaIni - 1 );
    Open;
    try
      if not IsEmpty then
      begin
         AIni:= AIni +  FieldByName('confeccionado').AsFloat;
      end;
    finally
      Close;
    end;

    if sEmpresa <> 'SAT' then
      ParamByName('empresa').AsString:= sEmpresa
    else
    begin
      if (dFechaFin) <= StrToDate('31/12/2018') then
        ParamByName('empresa').AsString:= '080'
      else
        ParamByName('empresa').AsString:= '050'
    end;

    ParamByName('fecha').AsDateTime:= ( dFechaFin );
    Open;
    try
      if not IsEmpty then
      begin
        AFin:= AFin +  FieldByName('confeccionado').AsFloat;
      end;
    finally
      Close;
    end;

    if (sProducto = 'PEH') then
    begin
      SQL.Clear;
      SQL.Add(' SELECT sum(peso_apb) stock ');
      SQL.Add(' FROM alm_palet_pb left join frf_entregas_c on entrega_apb = codigo_ec ');


      SQL.Add(' WHERE  (   ((date(fecha_alta_apb) <= :fecha) AND (status_apb = ''S'')) ');
      SQL.Add('        OR  ((date(fecha_alta_apb) <= :fecha) AND (fecha_apb > :fecha))  )');

      SQL.Add(' and status_apb <> ''B'' ');

      SQL.Add('   AND producto_apb = :producto ');


      ParamByName('producto').AsString := sProducto;
      ParamByName('fecha').AsDateTime:= ( dFechaIni - 1 );
      Open;
      try
        if not IsEmpty then
        begin
           AIni:= AIni +  FieldByName('stock').AsFloat;
        end;
      finally
        Close;
      end;

      ParamByName('producto').AsString := sProducto;
      ParamByName('fecha').AsDateTime:= ( dFechaFin );
      Open;
      try
        if not IsEmpty then
        begin
          AFin:= AFin +  FieldByName('stock').AsFloat;
        end;
      finally
        Close;
      end;

    end;

  end;
end;

function TDMLiqProdVendidoEntradas.AjustarEntradas( const AKilosVentas: R_KilosSalidas; const AUltimaPasada: boolean = False ): R_KilosEntradas;
var
  rKilosIni: Real;
  bFalta1, bFalta2, bFalta3: boolean;
begin
  if not AUltimaPasada then
    DMLiqProdVendido.kmtAjuste.Open;

  //Ajustar primera
  rKilosIni:= rKilosEntrada.rlKilosPrimera;
  if ( rKilosIni - AKilosVentas.rKilosPrimera ) > 1 then
  begin
    AjustarKilosDe( '1', '2', AKilosVentas.rKilosPrimera, rKilosIni );
    rKilosEntrada.rlKilosPrimera:= AKilosVentas.rKilosPrimera;
    rKilosEntrada.rlKilosSegunda:= rKilosEntrada.rlKilosSegunda + ( rKilosIni - AKilosVentas.rKilosPrimera );
    bFalta1:= False;
  end
  else
  begin
    bFalta1:= ( rKilosIni - AKilosVentas.rKilosPrimera ) < -1;
  end;

  rKilosIni:= rKilosEntrada.rlKilosSegunda;
  if ( rKilosIni - AKilosVentas.rKilosSegunda ) > 1 then
  begin
    AjustarKilosDe( '2', '3', AKilosVentas.rKilosSegunda, rKilosIni );
    rKilosEntrada.rlKilosSegunda:= AKilosVentas.rKilosSegunda;
    rKilosEntrada.rlKilosTercera:= rKilosEntrada.rlKilosTercera + ( rKilosIni - AKilosVentas.rKilosSegunda );
    bFalta2:= False;
  end
  else
  begin
    bFalta2:= ( rKilosIni - AKilosVentas.rKilosSegunda ) < -1;
  end;

  rKilosIni:= rKilosEntrada.rlKilosTercera;
  if ( rKilosIni - AKilosVentas.rKilosTercera ) > 1 then
  begin
    AjustarKilosDe( '3', '4', AKilosVentas.rKilosTercera, rKilosIni );
    rKilosEntrada.rlKilosTercera:= AKilosVentas.rKilosTercera;
    rKilosEntrada.rlKilosDestrio:= rKilosEntrada.rlKilosDestrio + ( rKilosIni - AKilosVentas.rKilosTercera );
    bFalta3:= False;
  end
  else
  begin
    bFalta3:= ( rKilosIni - AKilosVentas.rKilosTercera ) < -1;
  end;

  rKilosIni:= rKilosEntrada.rlKilosDestrio;
  if {Abs}( rKilosIni - AKilosVentas.rKilosDestrio ) > 1 then
  begin
    if AUltimaPasada  or not ( bFalta1 or bFalta2 or bFalta3 )then
    begin
      //ShowMessage('Destrio de sobra' + FormatFloat('#,##0.00', rKilosIni - AKilosVentas.rKilosDestrio) );
    end
    else
    begin
      if bFalta1 then
      begin
        AjustarKilosDe( '4', '1', AKilosVentas.rKilosDestrio, rKilosIni );
        rKilosEntrada.rlKilosDestrio:= AKilosVentas.rKilosDestrio;
        rKilosEntrada.rlKilosPrimera:= rKilosEntrada.rlKilosPrimera + ( rKilosIni - AKilosVentas.rKilosDestrio );
      end
      else
      if bFalta2 then
      begin
        AjustarKilosDe( '4', '2', AKilosVentas.rKilosDestrio, rKilosIni );
        rKilosEntrada.rlKilosDestrio:= AKilosVentas.rKilosDestrio;
        rKilosEntrada.rlKilosSegunda:= rKilosEntrada.rlKilosSegunda + ( rKilosIni - AKilosVentas.rKilosDestrio );
      end
      else
      if bFalta3 then
      begin
        AjustarKilosDe( '4', '3', AKilosVentas.rKilosDestrio, rKilosIni );
        rKilosEntrada.rlKilosDestrio:= AKilosVentas.rKilosDestrio;
        rKilosEntrada.rlKilosTercera:= rKilosEntrada.rlKilosTercera + ( rKilosIni - AKilosVentas.rKilosDestrio );
      end;
      result:= AjustarEntradas( AKilosVentas, True );
    end;
  end;

  if not AUltimaPasada then
    DMLiqProdVendido.kmtAjuste.Close;

  result:= rKilosEntrada;
end;

procedure TDMLiqProdVendidoEntradas.AjustarKilosDe( const ACatIni, ACatFin: string; const AObjetivo, AInicio: Real );
var
  rSobras, rObjetivo: Real;
begin
  //Tengo kilos de sobra
  DMLiqProdVendido.kmtEntradas.Filter:= 'Categoria_ent = ' + QuotedStr( ACatIni );
  DMLiqProdVendido.kmtEntradas.Filtered:= True;
  rObjetivo:= AjustarKilos( AObjetivo, AInicio );

  DMLiqProdVendido.kmtEntradas.Filter:= 'Categoria_ent = ' + QuotedStr( ACatFin );
  rSobras:= Ajustes( ACatFin );
  DMLiqProdVendido.kmtEntradas.Filtered:= False;

  //ShowMessage( FormatFloat('#,##0.00',rObjetivo) + ' : ' +  FormatFloat('#,##0.00',rSobras) + ' : ' + FormatFloat('#,##0.00',rObjetivo+rSobras) + ' : ' );
end;


function TDMLiqProdVendidoEntradas.AjustarKilos( const AObjetivo, AInicio: real ): real;
var
  rFactor, rAux, rAux2: Real;
  sEntrada: string;
begin
  if AInicio > 0 then
  begin
    rFactor:= ( AObjetivo / AInicio );
  end
  else
  begin
    rFactor:= 0;
  end;

  Result:= 0;

  with DMLiqProdVendido do
  begin
    kmtEntradas.First;
    while not kmtEntradas.Eof do
    begin
      rAux:= roundto( kmtEntradas.fieldByName('kilos_ent_liq').AsFloat * rFactor, -2 );
      rAux2:= roundto( kmtEntradas.fieldByName('kilos_ent_liq').AsFloat - rAux,-2);
      Result:= Result + rAux;
      kmtEntradas.Edit;
      kmtEntradas.fieldByName('kilos_ent_liq').AsFloat:= rAux;
      kmtEntradas.Post;

      kmtAjuste.Insert;
      kmtAjuste.fieldByName('codigo_ent').AsInteger:= kmtEntradas.fieldByName('codigo_ent').AsInteger;
      kmtAjuste.fieldByName('empresa_ent').AsString:= kmtEntradas.fieldByName('empresa_ent').AsString;
      kmtAjuste.fieldByName('centro_ent').AsString:= kmtEntradas.fieldByName('centro_ent').AsString;
      kmtAjuste.fieldByName('n_entrada').AsInteger:= kmtEntradas.fieldByName('n_entrada').AsInteger;
      kmtAjuste.fieldByName('fecha_ent').AsDateTime:= kmtEntradas.fieldByName('fecha_ent').AsDateTime;
      kmtAjuste.fieldByName('cosechero_ent').AsInteger:= kmtEntradas.fieldByName('cosechero_ent').AsInteger;
      kmtAjuste.fieldByName('plantacion_ent').AsInteger:= kmtEntradas.fieldByName('plantacion_ent').AsInteger;
      kmtAjuste.fieldByName('semana_planta_ent').AsString:= kmtEntradas.fieldByName('semana_planta_ent').AsString;

      kmtAjuste.fieldByName('origen_ent').AsString:= kmtEntradas.fieldByName('origen_ent').AsString;
      kmtAjuste.fieldByName('hora_ent').AsInteger:= kmtEntradas.fieldByName('hora_ent').AsInteger;
      kmtAjuste.fieldByName('tipo_ent').AsInteger:= kmtEntradas.fieldByName('tipo_ent').AsInteger;
      kmtAjuste.fieldByName('producto_ent').AsString:= kmtEntradas.fieldByName('producto_ent').AsString;
      kmtAjuste.fieldByName('fecha_origen_ent').AsDateTime:= kmtEntradas.fieldByName('fecha_origen_ent').AsDateTime;
      kmtAjuste.fieldByName('centro_origen_ent').AsString:= kmtEntradas.fieldByName('centro_origen_ent').AsString;
      kmtAjuste.fieldByName('envase_ent').AsString:= kmtEntradas.fieldByName('envase_ent').AsString;

      kmtAjuste.fieldByName('kilos').AsFloat:= rAux2;
      kmtAjuste.Post;

      if ( kmtEntradas.fieldByName('kilos_ent_liq').AsFloat + kmtEntradas.fieldByName('kilos_ent_net').AsFloat + kmtEntradas.fieldByName('kilos_ent').AsFloat ) = 0 then
        kmtEntradas.Delete
      else
        kmtEntradas.Next;
    end;
  end;

  //ShowMessage(DMLiqProdVendido.kmtEntradas.fieldByName('categoria_ent').AsString + ' FACTOR: ' + FloatToStr(rFactor) + ' - ' + 'KGS INI: ' + FloatToStr(AInicio) + '-' +  FloatToStr(rPepe) + ' - ' + 'KGS FIN: ' + FloatToStr(Result) + ' - ');
end;

function TDMLiqProdVendidoEntradas.Ajustes(const ACatDestino: string ):real;
begin
  Result:= 0;
  with DMLiqProdVendido do
  begin
    kmtAjuste.first;
    while not kmtAjuste.Eof do
    begin
      Result:= Result + kmtAjuste.fieldByName('kilos').AsFloat;
      if kmtEntradas.Locate('empresa_ent;centro_ent;n_entrada;fecha_ent;cosechero_ent;plantacion_ent;semana_planta_ent;categoria_ent',
                         vararrayof([ kmtAjuste.fieldByName('empresa_ent').AsString,
                                       kmtAjuste.fieldByName('centro_ent').AsString,
                                        kmtAjuste.fieldByName('n_entrada').AsInteger,
                                         kmtAjuste.fieldByName('fecha_ent').AsDateTime,
                                          kmtAjuste.fieldByName('cosechero_ent').AsInteger,
                                           kmtAjuste.fieldByName('plantacion_ent').AsInteger,
                                            kmtAjuste.fieldByName('semana_planta_ent').AsString, ACatDestino]), [] ) then
      begin
        kmtEntradas.Edit;
        kmtEntradas.fieldByName('kilos_ent_liq').AsFloat:= kmtEntradas.fieldByName('kilos_ent_liq').AsFloat +
                                                           kmtAjuste.fieldByName('kilos').AsFloat;
        kmtEntradas.Post;
      end
      else
      begin
        //Nuevo registro
        Inc( iLinea );

        kmtEntradas.Insert;

        kmtEntradas.fieldByName('codigo_ent').AsInteger:= kmtAjuste.fieldByName('codigo_ent').AsInteger;
        kmtEntradas.fieldByName('linea_ent').AsInteger:= iLinea;
        kmtEntradas.fieldByName('empresa_ent').AsString:= kmtAjuste.fieldByName('empresa_ent').AsString;
        kmtEntradas.fieldByName('centro_ent').AsString:= kmtAjuste.fieldByName('centro_ent').AsString;
        kmtEntradas.fieldByName('n_entrada').AsInteger:= kmtAjuste.fieldByName('n_entrada').AsInteger;
        kmtEntradas.fieldByName('fecha_ent').AsDateTime:= kmtAjuste.fieldByName('fecha_ent').AsDateTime;
        kmtEntradas.fieldByName('cosechero_ent').AsInteger:= kmtAjuste.fieldByName('cosechero_ent').AsInteger;
        kmtEntradas.fieldByName('plantacion_ent').AsInteger:= kmtAjuste.fieldByName('plantacion_ent').AsInteger;
        kmtEntradas.fieldByName('semana_planta_ent').AsString:= kmtAjuste.fieldByName('semana_planta_ent').AsString;

        kmtEntradas.fieldByName('origen_ent').AsString:= kmtAjuste.fieldByName('origen_ent').AsString;
        kmtEntradas.fieldByName('hora_ent').AsInteger:= kmtAjuste.fieldByName('hora_ent').AsInteger;
        kmtEntradas.fieldByName('tipo_ent').AsInteger:= kmtAjuste.fieldByName('tipo_ent').AsInteger;
        kmtEntradas.fieldByName('producto_ent').AsString:= kmtAjuste.fieldByName('producto_ent').AsString;
        kmtEntradas.fieldByName('centro_origen_ent').AsString:= kmtAjuste.fieldByName('centro_origen_ent').AsString;
        kmtEntradas.fieldByName('fecha_origen_ent').AsDatetime:= kmtAjuste.fieldByName('fecha_origen_ent').AsDatetime;
        kmtEntradas.fieldByName('envase_ent').AsString:= kmtAjuste.fieldByName('envase_ent').AsString;
        kmtEntradas.fieldByName('categoria_ent').AsString:= ACatDestino;

        kmtEntradas.fieldByName('kilos_ent').AsFloat:= 0;
        kmtEntradas.fieldByName('kilos_ent_net').AsFloat:= 0;
        kmtEntradas.fieldByName('kilos_ent_liq').AsFloat:= kmtAjuste.fieldByName('kilos').AsFloat;
        kmtEntradas.Post;

      end;
      kmtAjuste.Delete;
    end;
  end;
end;

end.
