unit AprovechaResumenData;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMAprovechaResumen = class(TDataModule)
    QInventarioCab: TQuery;
    QInventarioLin: TQuery;
    QEntradas: TQuery;
    QEscandallo: TQuery;
    QSalidas: TQuery;
    QTransitos: TQuery;
    mtResumen: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;

    rIniCampo, rIniDestrio, rIniTercera, rIniIntermedia1, rIniIntermedia2, rIniExpedicion1, rIniExpedicion2: real;
    rFinCampo, rFinDestrio, rFinTercera, rFinIntermedia1, rFinIntermedia2, rFinExpedicion1, rFinExpedicion2: real;

    rCosechado, rEscandallo1, rEscandallo2, rEscandallo3, rEscandalloD: real;
    rSeleccionado,rIndustria, rCompra1, rCompra2, rCompra3, rCompraD: real;

    rSal1, rSal2, rSal3, rSalDestrio: real;

    procedure CrearTablaTemporal;
    procedure PreparaQuerys;
    procedure DesPreparaQuerys;

    function  ObtenerDatos( var AMsg: string ): boolean;
    function  DatosInventario( var AMsg: string ): boolean;
    function  DatosEntrada( var AMsg: string ): boolean;
    function  DatosSalidas( var AMsg: string ): boolean;
    function  GrabarDatos( var AMsg: string ): boolean;

  public
    { Public declarations }
  end;

  function ExecuteAprovechaResumen( const AOwner: TComponent;
                                    const AEmpresa, ACentro, AProducto: string;
                                    const AFechaIni, AFechaFin: TDateTime;
                                    var AMsg: string  ): boolean;


implementation

{$R *.dfm}

uses
  AprovechaResumenReport, bMath;

var
  DMAprovechaResumen: TDMAprovechaResumen;

function ExecuteAprovechaResumen( const AOwner: TComponent;
                                  const AEmpresa, ACentro, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime;
                                  var AMsg: string  ): boolean;
begin
  DMAprovechaResumen:= TDMAprovechaResumen.Create( AOwner );

  //CODIGO
  with DMAprovechaResumen do
  begin
    sEmpresa:= AEmpresa;
    sCentro:= ACentro;
    sProducto:= AProducto;
    dFechaIni:= AFechaIni;
    dFechaFin:= AFechaFin;

    result:= ObtenerDatos( AMsg );
    if result then
    begin
      mtResumen.Open;
      try
        result:= GrabarDatos( AMsg );
        if result then
        begin
          PrintAprovechaResumen( AOwner, AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin );
        end;
      except
        mtResumen.Close;
      end;
    end;
  end;

  FreeAndNil( DMAprovechaResumen );
end;


procedure TDMAprovechaResumen.DataModuleCreate(Sender: TObject);
begin
  CrearTablaTemporal;
  PreparaQuerys;
end;

procedure TDMAprovechaResumen.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuerys;
end;

procedure TDMAprovechaResumen.CrearTablaTemporal;
begin
  with mtResumen do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('KilosIni', ftFloat, 0, False);
    FieldDefs.Add('IniCampo', ftFloat, 0, False);
    FieldDefs.Add('IniDestrio', ftFloat, 0, False);
    FieldDefs.Add('IniPrimera', ftFloat, 0, False);
    FieldDefs.Add('IniSegunda', ftFloat, 0, False);
    FieldDefs.Add('IniTercera', ftFloat, 0, False);
    FieldDefs.Add('IniIntermedia', ftFloat, 0, False);
    FieldDefs.Add('IniIntermedia1', ftFloat, 0, False);
    FieldDefs.Add('IniIntermedia2', ftFloat, 0, False);
    FieldDefs.Add('IniExpedicion', ftFloat, 0, False);
    FieldDefs.Add('IniExpedicion1', ftFloat, 0, False);
    FieldDefs.Add('IniExpedicion2', ftFloat, 0, False);


    FieldDefs.Add('KilosFin', ftFloat, 0, False);
    FieldDefs.Add('FinCampo', ftFloat, 0, False);
    FieldDefs.Add('FinDestrio', ftFloat, 0, False);
    FieldDefs.Add('FinPrimera', ftFloat, 0, False);
    FieldDefs.Add('FinSegunda', ftFloat, 0, False);
    FieldDefs.Add('FinTercera', ftFloat, 0, False);
    FieldDefs.Add('FinIntermedia', ftFloat, 0, False);
    FieldDefs.Add('FinIntermedia1', ftFloat, 0, False);
    FieldDefs.Add('FinIntermedia2', ftFloat, 0, False);
    FieldDefs.Add('FinExpedicion', ftFloat, 0, False);
    FieldDefs.Add('FinExpedicion1', ftFloat, 0, False);
    FieldDefs.Add('FinExpedicion2', ftFloat, 0, False);

    FieldDefs.Add('KilosIn', ftFloat, 0, False);
    FieldDefs.Add('Escandallo1', ftFloat, 0, False);
    FieldDefs.Add('Escandallo2', ftFloat, 0, False);
    FieldDefs.Add('Escandallo3', ftFloat, 0, False);
    FieldDefs.Add('EscandalloD', ftFloat, 0, False);

    FieldDefs.Add('KilosOut', ftFloat, 0, False);
    FieldDefs.Add('Sal1', ftFloat, 0, False);
    FieldDefs.Add('Sal2', ftFloat, 0, False);
    FieldDefs.Add('Sal3', ftFloat, 0, False);
    FieldDefs.Add('SalDestrio', ftFloat, 0, False);

    FieldDefs.Add('Merma', ftFloat, 0, False);
    FieldDefs.Add('Procesados', ftFloat, 0, False);
    FieldDefs.Add('Confeccionados', ftFloat, 0, False);

    //ENTRADAS
    FieldDefs.Add('Seleccionado', ftFloat, 0, False);
    FieldDefs.Add('Seleccionado1', ftFloat, 0, False);
    FieldDefs.Add('Seleccionado2', ftFloat, 0, False);
    FieldDefs.Add('Seleccionado3', ftFloat, 0, False);
    FieldDefs.Add('SeleccionadoD', ftFloat, 0, False);

    FieldDefs.Add('Industria', ftFloat, 0, False);
    FieldDefs.Add('Industria1', ftFloat, 0, False);
    FieldDefs.Add('Industria2', ftFloat, 0, False);
    FieldDefs.Add('Industria3', ftFloat, 0, False);
    FieldDefs.Add('IndustriaD', ftFloat, 0, False);

    FieldDefs.Add('Compra', ftFloat, 0, False);
    FieldDefs.Add('Compra1', ftFloat, 0, False);
    FieldDefs.Add('Compra2', ftFloat, 0, False);
    FieldDefs.Add('Compra3', ftFloat, 0, False);
    FieldDefs.Add('CompraD', ftFloat, 0, False);

    FieldDefs.Add('Normal', ftFloat, 0, False);
    FieldDefs.Add('Normal1', ftFloat, 0, False);
    FieldDefs.Add('Normal2', ftFloat, 0, False);
    FieldDefs.Add('Normal3', ftFloat, 0, False);
    FieldDefs.Add('NormalD', ftFloat, 0, False);

    FieldDefs.Add('SinAjuste', ftFloat, 0, False);
    FieldDefs.Add('SinAjuste1', ftFloat, 0, False);
    FieldDefs.Add('SinAjuste2', ftFloat, 0, False);
    FieldDefs.Add('SinAjuste3', ftFloat, 0, False);
    FieldDefs.Add('SinAjusteD', ftFloat, 0, False);

    FieldDefs.Add('SinMerma', ftFloat, 0, False);
    FieldDefs.Add('SinMerma1', ftFloat, 0, False);
    FieldDefs.Add('SinMerma2', ftFloat, 0, False);
    FieldDefs.Add('SinMerma3', ftFloat, 0, False);
    FieldDefs.Add('SinMermaD', ftFloat, 0, False);

    FieldDefs.Add('ConMerma', ftFloat, 0, False);
    FieldDefs.Add('ConMerma1', ftFloat, 0, False);
    FieldDefs.Add('ConMerma2', ftFloat, 0, False);
    FieldDefs.Add('ConMerma3', ftFloat, 0, False);
    FieldDefs.Add('ConMermaD', ftFloat, 0, False);


    //SALIDAS
    FieldDefs.Add('SalInventario', ftFloat, 0, False);
    FieldDefs.Add('SalInventario1', ftFloat, 0, False);
    FieldDefs.Add('SalInventario2', ftFloat, 0, False);
    FieldDefs.Add('SalInventario3', ftFloat, 0, False);
    FieldDefs.Add('SalInventarioDestrio', ftFloat, 0, False);

    FieldDefs.Add('SalSinMerma', ftFloat, 0, False);
    FieldDefs.Add('SalSinMerma1', ftFloat, 0, False);
    FieldDefs.Add('SalSinMerma2', ftFloat, 0, False);
    FieldDefs.Add('SalSinMerma3', ftFloat, 0, False);
    FieldDefs.Add('SalSinMermaDestrio', ftFloat, 0, False);

    FieldDefs.Add('SalConMerma', ftFloat, 0, False);
    FieldDefs.Add('SalConMerma1', ftFloat, 0, False);
    FieldDefs.Add('SalConMerma2', ftFloat, 0, False);
    FieldDefs.Add('SalConMerma3', ftFloat, 0, False);
    FieldDefs.Add('SalConMermaDestrio', ftFloat, 0, False);


    //AJUSTES
    FieldDefs.Add('AjusteEntradas', ftFloat, 0, False);
    FieldDefs.Add('AjusteEntradas1', ftFloat, 0, False);
    FieldDefs.Add('AjusteEntradas2', ftFloat, 0, False);
    FieldDefs.Add('AjusteEntradas3', ftFloat, 0, False);
    FieldDefs.Add('AjusteEntradasDestrio', ftFloat, 0, False);
    FieldDefs.Add('AjusteEntradasMerma', ftFloat, 0, False);

    FieldDefs.Add('AjusteCompras', ftFloat, 0, False);
    FieldDefs.Add('AjusteCompras1', ftFloat, 0, False);
    FieldDefs.Add('AjusteCompras2', ftFloat, 0, False);
    FieldDefs.Add('AjusteCompras3', ftFloat, 0, False);
    FieldDefs.Add('AjusteComprasDestrio', ftFloat, 0, False);
    FieldDefs.Add('AjusteComprasMerma', ftFloat, 0, False);

    FieldDefs.Add('AjusteNormal', ftFloat, 0, False);
    FieldDefs.Add('AjusteNormal1', ftFloat, 0, False);
    FieldDefs.Add('AjusteNormal2', ftFloat, 0, False);
    FieldDefs.Add('AjusteNormal3', ftFloat, 0, False);
    FieldDefs.Add('AjusteNormalDestrio', ftFloat, 0, False);
    FieldDefs.Add('AjusteNormalMerma', ftFloat, 0, False);

    CreateTable;
  end;
end;

procedure TDMAprovechaResumen.PreparaQuerys;
begin
  with QInventarioCab do
  begin
    SQL.Clear;
    SQL.Add(' select kilos_cec_ic campo, ');
    SQL.Add('        kilos_cim_c1_ic + kilos_cia_c1_ic intermedia1, ');
    SQL.Add('        kilos_cim_c2_ic + kilos_cia_c2_ic intermedia2, ');
    SQL.Add('        kilos_zd_c3_ic tercera, ');
    SQL.Add('        kilos_zd_d_ic destrio, ');
    SQL.Add('        kilos_ajuste_campo_ic  ajustec, ');
    SQL.Add('        kilos_ajuste_c1_ic  ajuste1, ');
    SQL.Add('        kilos_ajuste_c2_ic  ajuste2, ');
    SQL.Add('        kilos_ajuste_c3_ic  ajuste3, ');
    SQL.Add('        kilos_ajuste_cd_ic  ajusted ');

    SQL.Add(' from frf_inventarios_c ');

    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add(' and centro_ic = :centro ');
    SQL.Add(' and producto_ic = :producto ');
    SQL.Add(' and fecha_ic = :fecha ');
    Prepare;
  end;
  with QInventarioLin do
  begin
    SQL.Clear;
    SQL.Add(' select sum( kilos_ce_c1_il) expedicion1, ');
    SQL.Add('        sum( kilos_ce_c2_il) expedicion2 ');

    SQL.Add(' from frf_inventarios_l ');

    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha ');
    Prepare;
  end;

  with QEntradas do
  begin
    SQL.Clear;
    SQL.Add(' select sum( total_kgs_e2l ) cosechado ');

    SQL.Add(' from frf_entradas2_l ');

    SQL.Add(' where empresa_e2l = :empresa ');
    SQL.Add(' and centro_e2l = :centro ');
    SQL.Add(' and producto_e2l = :producto ');
    SQL.Add(' and fecha_e2l between :fechaini and :fechafin ');
    Prepare;
  end;
  with QEscandallo do
  begin
    SQL.Clear;
    SQL.Add(' select sum( total_kgs_e2l ) escandallo_total, ');
    SQL.Add('        sum( Round( ( porcen_primera_e * total_kgs_e2l ) / 100 , 2 ) ) escandallo_primera, ');
    SQL.Add('        sum( Round( ( porcen_segunda_e * total_kgs_e2l ) / 100 , 2 ) ) escandallo_segunda, ');
    SQL.Add('        sum( Round( ( porcen_tercera_e * total_kgs_e2l ) / 100 , 2 ) ) escandallo_tercera, ');
    SQL.Add('        sum( Round( ( porcen_destrio_e * total_kgs_e2l ) / 100 , 2 ) ) escandallo_destrio, ');

    SQL.Add('        sum( Round( ( case when tipo_entrada_e = 1 then porcen_primera_e else 0 end * total_kgs_e2l ) / 100 , 2 ) ) seleccionado, ');

    SQL.Add('        sum( Round( ( case when tipo_entrada_e = 2 then porcen_tercera_e else 0 end * total_kgs_e2l ) / 100 , 2 ) ) industria, ');

    SQL.Add('        sum( Round( ( case when tipo_entrada_e = 3 then porcen_primera_e else 0 end * total_kgs_e2l ) / 100 , 2 ) ) compra_primera, ');
    SQL.Add('        sum( Round( ( case when tipo_entrada_e = 3 then porcen_segunda_e else 0 end * total_kgs_e2l ) / 100 , 2 ) ) compra_segunda, ');
    SQL.Add('        sum( Round( ( case when tipo_entrada_e = 3 then porcen_tercera_e else 0 end * total_kgs_e2l ) / 100 , 2 ) ) compra_tercera, ');
    SQL.Add('        sum( Round( ( case when tipo_entrada_e = 3 then porcen_destrio_e else 0 end * total_kgs_e2l ) / 100 , 2 ) ) compra_destrio ');

    SQL.Add(' from frf_escandallo, frf_entradas2_l ');

    SQL.Add(' where empresa_e = :empresa ');
    SQL.Add(' and centro_e = :centro ');
    SQL.Add(' and producto_e = :producto ');
    SQL.Add(' and fecha_e between :fechaini and :fechafin ');

    SQL.Add(' and empresa_e2l = :empresa ');
    SQL.Add(' and centro_e2l = :centro ');
    SQL.Add(' and numero_entrada_e = numero_entrada_e2l ');
    SQL.Add(' and fecha_E = fecha_e2l ');
    //Añadido el 25/10/2012
    SQL.Add(' and cosechero_e2l = cosechero_e ');
    SQL.Add(' and plantacion_e2l =  plantacion_e ');
    SQL.Add(' and ano_Sem_planta_e2l = anyo_semana_e ');
    Prepare;
  end;

  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select categoria_sl categoria, sum(kilos_sl) kilos ');

    SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and fecha_sc between :fechaini and :fechafin ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');

    SQL.Add(' and centro_salida_sl = centro_origen_sl ');
    SQL.Add(' and producto_sl = :producto ');
    SQL.Add(' and categoria_sl <> ''B'' ');

    //QUE SEA UNA VENTA
    SQL.Add(' and ( nvl( es_transito_sc, 0 ) =  0 ) ');
    SQL.Add(' and TRIM( NVL( ref_transitos_sl, '''' )) = '''' ');

    SQL.Add(' group by categoria_sl ');
    Prepare;
  end;
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select categoria_tl categoria, sum(kilos_tl) kilos ');

    SQL.Add(' from frf_transitos_l ');

    SQL.Add(' WHERE empresa_tl = :empresa ');
    SQL.Add('   AND centro_origen_tl = :centro ');
    SQL.Add('   AND centro_tl = :centro ');
    SQL.Add('   AND fecha_tl between :fechaini and :fechafin ');
    SQL.Add('   AND producto_tl = :producto ');
    SQL.Add('   AND ref_origen_tl is null ');

    SQL.Add(' group by categoria_tl ');
    Prepare;
  end;

(*
  with Query do
  begin
    SQL.Clear;
    SQL.Add('');
    Prepare;
  end;
*)
end;


procedure TDMAprovechaResumen.DesPreparaQuerys;
var
  i: integer;
begin
  for i:= 0 to ComponentCount - 1 do
  begin
    if ( Components[i] is TQuery ) then
    begin
      with Components[i] as TQuery do
      begin
        Close;
        if Prepared then
          UnPrepare;
      end;
    end;
  end;
end;

function TDMAprovechaResumen.ObtenerDatos( var AMsg: string ): boolean;
begin
  result:= DatosInventario( AMsg );
  if result then
  begin
    result:= DatosEntrada( AMsg );
    if result then
    begin
      result:= DatosSalidas( AMsg );
    end;
  end;
end;


function  TDMAprovechaResumen.DatosInventario( var AMsg: string ): boolean;
begin
  result:= True;

  with QInventarioCab do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fecha').AsdateTime:= dFechaIni - 1;
    Open;
    if IsEmpty then
    begin
      result:= false;
      AMsg:= 'Falta el inventario del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni - 1 ) + '"';
    end
    else
    begin
      rIniCampo:= FieldByName('campo').AsFloat;
      rIniDestrio:= FieldByName('destrio').AsFloat;
      rIniTercera:= FieldByName('tercera').AsFloat;
      rIniIntermedia1:= FieldByName('intermedia1').AsFloat;
      rIniIntermedia2:= FieldByName('intermedia2').AsFloat;
    end;
    Close;

    if result then
    begin
      ParamByName('fecha').AsdateTime:= dFechaFin;
      Open;
      if IsEmpty then
      begin
       result:= false;
        AMsg:= 'Falta el inventario del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaFin ) + '"';
     end
      else
      begin
        rFinCampo:= FieldByName('campo').AsFloat + FieldByName('ajustec').AsFloat;;
        rFinDestrio:= FieldByName('destrio').AsFloat  + FieldByName('ajusted').AsFloat;;
        rFinTercera:= FieldByName('tercera').AsFloat  + FieldByName('ajuste3').AsFloat;;
        rFinIntermedia1:= FieldByName('intermedia1').AsFloat + FieldByName('ajuste1').AsFloat;
        rFinIntermedia2:= FieldByName('intermedia2').AsFloat + FieldByName('ajuste2').AsFloat;
      end;
      Close;
    end;

  end;

  if result then
  begin
    with QInventarioLin do
    begin
      ParamByName('empresa').AsString:= sEmpresa;
      ParamByName('centro').AsString:= sCentro;
      ParamByName('producto').AsString:= sProducto;
      ParamByName('fecha').AsdateTime:= dFechaIni - 1;
      Open;
      rIniExpedicion1:= FieldByName('expedicion1').AsFloat;
      rIniExpedicion2:= FieldByName('expedicion2').AsFloat;
      Close;

      ParamByName('fecha').AsdateTime:= dFechaFin;
      Open;
      rFinExpedicion1:= FieldByName('expedicion1').AsFloat;
      rFinExpedicion2:= FieldByName('expedicion2').AsFloat;
      Close;
    end;
  end;
end;

function  TDMAprovechaResumen.DatosEntrada( var AMsg: string ): boolean;
var
  rEscandallo: real;
begin
  with QEntradas do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsdateTime:= dFechaIni;
    ParamByName('fechafin').AsdateTime:= dFechaFin;
    Open;
    if IsEmpty then
    begin
      result:= false;
      AMsg:= 'Sin entradas del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni ) + '" al "'  + FormatDateTime( 'dd/mm/yyyy', dFechaFin ) + '".';
    end
    else
    begin
      rCosechado:= FieldByName('cosechado').AsFloat;

      result:= rCosechado > 0;
      if not result then
      begin
        AMsg:= 'Sin kilos de entradas del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni ) + '" al "'  + FormatDateTime( 'dd/mm/yyyy', dFechaFin ) + '".';
      end;
    end;
    Close;
  end;

  if result then
  with QEscandallo do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsdateTime:= dFechaIni;
    ParamByName('fechafin').AsdateTime:= dFechaFin;
    Open;
    if IsEmpty then
    begin
      result:= false;
      AMsg:= 'Sin escandallos del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni ) + '" al "'  + FormatDateTime( 'dd/mm/yyyy', dFechaFin ) + '".';
    end
    else
    begin
      rEscandallo:= FieldByName('escandallo_total').AsFloat;
      rEscandallo1:= FieldByName('escandallo_primera').AsFloat;
      rEscandallo2:= FieldByName('escandallo_segunda').AsFloat;
      rEscandallo3:= FieldByName('escandallo_tercera').AsFloat;
      rEscandalloD:= FieldByName('escandallo_destrio').AsFloat;
      rSeleccionado:= FieldByName('seleccionado').AsFloat;
      rIndustria:= FieldByName('industria').AsFloat;
      rCompra1:= FieldByName('compra_primera').AsFloat;
      rCompra2:= FieldByName('compra_segunda').AsFloat;
      rCompra3:= FieldByName('compra_tercera').AsFloat;
      rCompraD:= FieldByName('compra_destrio').AsFloat;

      result:= rCosechado = rEscandallo;
      if not result then
      begin
        AMsg:= 'Faltan escandallos del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni ) + '" al "'  + FormatDateTime( 'dd/mm/yyyy', dFechaFin ) + '".';
      end;
    end;
    Close;
  end;
end;

function  TDMAprovechaResumen.DatosSalidas( var AMsg: string ): boolean;
var
  iCategoria: integer;
begin
  result:= True;

   rSal1:= 0;
   rSal2:= 0;
   rSal3:= 0;
   rSalDestrio:= 0;

  with QSalidas do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsdateTime:= dFechaIni;
    ParamByName('fechafin').AsdateTime:= dFechaFin;
    Open;

    while not eof do
    begin
      iCategoria:= StrToIntDef( FieldByName('categoria').AsString, 4 );
      case iCategoria of
        1: rSal1:= rSal1 + FieldByName('kilos').AsFloat;
        2: rSal2:= rSal2 + FieldByName('kilos').AsFloat;
        3: rSal3:= rSal3 + FieldByName('kilos').AsFloat;
        4: rSalDestrio:= rSalDestrio + FieldByName('kilos').AsFloat;
      end;
      Next;
    end;
    Close;
  end;

  with QTransitos do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fechaini').AsdateTime:= dFechaIni;
    ParamByName('fechafin').AsdateTime:= dFechaFin;
    Open;
    while not eof do
    begin
      iCategoria:= StrToIntDef( FieldByName('categoria').AsString, 4 );
      case iCategoria of
        1: rSal1:= rSal1 + FieldByName('kilos').AsFloat;
        2: rSal2:= rSal2 + FieldByName('kilos').AsFloat;
        3: rSal3:= rSal3 + FieldByName('kilos').AsFloat;
        4: rSalDestrio:= rSalDestrio + FieldByName('kilos').AsFloat;
      end;
      Next;
    end;
    Close;
  end;

  if ( rSal1 + rSal2 + rSal3 + rSalDestrio ) <= 0 then
  begin
    result:= false;
    AMsg:= 'Sin salidas ni tránsitos del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni ) + '" al "'  + FormatDateTime( 'dd/mm/yyyy', dFechaFin ) + '".';
  end;
end;

function TDMAprovechaResumen.GrabarDatos( var AMsg: string ): boolean;
var
  rAux, rAux2: real;
begin
  with mtResumen do
  begin
    Insert;

    FieldByName('KilosIni').AsFloat:= rIniCampo + rIniDestrio + rIniTercera + rIniIntermedia1 + rIniIntermedia2 + rIniExpedicion1 + rIniExpedicion2;
    FieldByName('KilosFin').AsFloat:= rFinCampo + rFinDestrio + rFinTercera + rFinIntermedia1 + rFinIntermedia2 + rFinExpedicion1 + rFinExpedicion2;

    FieldByName('KilosIn').AsFloat:= rCosechado;
    FieldByName('Escandallo1').AsFloat:= rEscandallo1;
    FieldByName('Escandallo2').AsFloat:= rEscandallo2;
    FieldByName('Escandallo3').AsFloat:= rEscandallo3;
    FieldByName('EscandalloD').AsFloat:= rEscandalloD;

    FieldByName('KilosOut').AsFloat:= rSal1 + rSal2 + rSal3 + rSalDestrio;
    FieldByName('Sal1').AsFloat:= rSal1;
    FieldByName('Sal2').AsFloat:= rSal2;
    FieldByName('Sal3').AsFloat:= rSal3;
    FieldByName('SalDestrio').AsFloat:= rSalDestrio;


    FieldByName('Merma').AsFloat:= ( FieldByName('KilosIni').AsFloat + FieldByName('KilosIn').AsFloat ) - ( FieldByName('KilosFin').AsFloat + FieldByName('KilosOut').AsFloat );
    FieldByName('Procesados').AsFloat:= ( rIniCampo + rCosechado ) - rFinCampo;
    FieldByName('Confeccionados').AsFloat:= ( rIniCampo + rCosechado +  rIniIntermedia1 + rIniIntermedia2 ) -
                    ( rFinCampo + rFinIntermedia1 + rFinIntermedia2 );

    FieldByName('IniCampo').AsFloat:= rIniCampo;
    FieldByName('IniDestrio').AsFloat:= rIniDestrio;
    FieldByName('IniTercera').AsFloat:= rIniTercera;
    FieldByName('IniPrimera').AsFloat:= rIniIntermedia1 + rIniExpedicion1;
    FieldByName('IniSegunda').AsFloat:= rIniIntermedia2 + rIniExpedicion2;
    FieldByName('IniIntermedia').AsFloat:= rIniIntermedia1 + rIniIntermedia2;
    FieldByName('IniIntermedia1').AsFloat:= rIniIntermedia1;
    FieldByName('IniIntermedia2').AsFloat:= rIniIntermedia2;
    FieldByName('IniExpedicion').AsFloat:= rIniExpedicion1 + rIniExpedicion2;
    FieldByName('IniExpedicion1').AsFloat:= rIniExpedicion1;
    FieldByName('IniExpedicion2').AsFloat:= rIniExpedicion2;


    FieldByName('FinCampo').AsFloat:= rFinCampo;
    FieldByName('FinDestrio').AsFloat:= rFinDestrio;
    FieldByName('FinTercera').AsFloat:= rFinTercera;
    FieldByName('FinPrimera').AsFloat:= rFinIntermedia1 + rFinExpedicion1;
    FieldByName('FinSegunda').AsFloat:= rFinIntermedia2 + rFinExpedicion2;
    FieldByName('FinIntermedia').AsFloat:= rFinIntermedia1 + rFinIntermedia2;
    FieldByName('FinIntermedia1').AsFloat:= rFinIntermedia1;
    FieldByName('FinIntermedia2').AsFloat:= rFinIntermedia2;
    FieldByName('FinExpedicion').AsFloat:= rFinExpedicion1 + rFinExpedicion2;
    FieldByName('FinExpedicion1').AsFloat:= rFinExpedicion1;
    FieldByName('FinExpedicion2').AsFloat:= rFinExpedicion2;



    //ENTRADAS
    FieldByName('Seleccionado').AsFloat:= rSeleccionado;
    FieldByName('Seleccionado1').AsFloat:= rSeleccionado;
    FieldByName('Seleccionado2').AsFloat:= 0;
    FieldByName('Seleccionado3').AsFloat:= 0;
    FieldByName('SeleccionadoD').AsFloat:= 0;

    FieldByName('Industria').AsFloat:= rIndustria;
    FieldByName('Industria1').AsFloat:= 0;
    FieldByName('Industria2').AsFloat:= 0;
    FieldByName('Industria3').AsFloat:= rIndustria;
    FieldByName('IndustriaD').AsFloat:= 0;

    FieldByName('Compra').AsFloat:= rCompra1 + rCompra2 + rCompra3 + rCompraD;
    FieldByName('Compra1').AsFloat:= rCompra1;
    FieldByName('Compra2').AsFloat:= rCompra2;
    FieldByName('Compra3').AsFloat:= rCompra3;
    FieldByName('CompraD').AsFloat:= rCompraD;

    FieldByName('Normal1').AsFloat:= rEscandallo1 - ( rSeleccionado + rCompra1 );
    FieldByName('Normal2').AsFloat:= rEscandallo2 - ( rCompra2 );
    FieldByName('Normal3').AsFloat:= rEscandallo3 - ( rIndustria + rCompra3 );
    FieldByName('NormalD').AsFloat:= rEscandalloD - ( rCompraD );
    FieldByName('Normal').AsFloat:= FieldByName('Normal1').AsFloat +
                                           FieldByName('Normal2').AsFloat +
                                           FieldByName('Normal3').AsFloat +
                                           FieldByName('NormalD').AsFloat;

    FieldByName('SinAjuste1').AsFloat:= rSeleccionado + rCompra1;
    FieldByName('SinAjuste2').AsFloat:= rCompra2;
    FieldByName('SinAjuste3').AsFloat:= rIndustria + rCompra3;
    FieldByName('SinAjusteD').AsFloat:= rCompraD;
    FieldByName('SinAjuste').AsFloat:= FieldByName('SinAjuste1').AsFloat +
                                           FieldByName('SinAjuste2').AsFloat +
                                           FieldByName('SinAjuste3').AsFloat +
                                           FieldByName('SinAjusteD').AsFloat;

    FieldByName('SinMerma1').AsFloat:= rSeleccionado;
    FieldByName('SinMerma2').AsFloat:= 0;
    FieldByName('SinMerma3').AsFloat:= rIndustria;
    FieldByName('SinMermaD').AsFloat:= 0;
    FieldByName('SinMerma').AsFloat:= FieldByName('SinMerma1').AsFloat +
                                           FieldByName('SinMerma2').AsFloat +
                                           FieldByName('SinMerma3').AsFloat;

    FieldByName('ConMerma1').AsFloat:= FieldByName('Normal1').AsFloat + rCompra1;
    FieldByName('ConMerma2').AsFloat:= FieldByName('Normal2').AsFloat + rCompra2;
    FieldByName('ConMerma3').AsFloat:= FieldByName('Normal3').AsFloat + rCompra3;
    FieldByName('ConMermaD').AsFloat:= FieldByName('NormalD').AsFloat + rCompraD;
    FieldByName('ConMerma').AsFloat:= FieldByName('ConMerma1').AsFloat +
                                           FieldByName('ConMerma2').AsFloat +
                                           FieldByName('ConMerma3').AsFloat +
                                           FieldByName('ConMermaD').AsFloat;



    //SALDAS
    rAux:= ( rSal1 + rFinIntermedia1 + rFinExpedicion1 ) - ( rIniIntermedia1 + rIniExpedicion1 );
    FieldByName('SalInventario1').AsFloat:= rAux;
    rAux:= ( rSal2 + rFinIntermedia2 + rFinExpedicion2 ) - ( rIniIntermedia2 + rIniExpedicion2 );
    FieldByName('SalInventario2').AsFloat:= rAux;
    rAux:= ( rSal3 + rFinTercera ) - ( rIniTercera );
    FieldByName('SalInventario3').AsFloat:= rAux;
    rAux:= ( rSalDestrio + rFinDestrio ) - ( rIniDestrio );
    FieldByName('SalInventarioDestrio').AsFloat:= rAux;
    FieldByName('SalInventario').AsFloat:= FieldByName('SalInventario1').AsFloat +
                                                FieldByName('SalInventario2').AsFloat +
                                                FieldByName('SalInventario3').AsFloat +
                                                FieldByName('SalInventarioDestrio').AsFloat;

    FieldByName('SalConMerma1').AsFloat:= FieldByName('SalInventario1').AsFloat - rSeleccionado;
    FieldByName('SalConMerma2').AsFloat:= FieldByName('SalInventario2').AsFloat;
    FieldByName('SalConMerma3').AsFloat:= FieldByName('SalInventario3').AsFloat - rIndustria;
    FieldByName('SalConMermaDestrio').AsFloat:= FieldByName('SalInventarioDestrio').AsFloat;
    FieldByName('SalConMerma').AsFloat:= FieldByName('SalConMerma1').AsFloat +
                                                  FieldByName('SalConMerma2').AsFloat +
                                                  FieldByName('SalConMerma3').AsFloat +
                                                  FieldByName('SalConMermaDestrio').AsFloat;

    FieldByName('SalSinMerma1').AsFloat:= rSeleccionado;
    FieldByName('SalSinMerma2').AsFloat:= 0;
    FieldByName('SalSinMerma3').AsFloat:= rIndustria;
    FieldByName('SalSinMermaDestrio').AsFloat:= 0;
    FieldByName('SalSinMerma').AsFloat:= FieldByName('SalSinMerma1').AsFloat +
                                                  FieldByName('SalSinMerma2').AsFloat +
                                                  FieldByName('SalSinMerma3').AsFloat +
                                                  FieldByName('SalSinMermaDestrio').AsFloat;




    //AJUSTES
    rAux2:= FieldByName('Compra').AsFloat + FieldByName('Normal').AsFloat;
    if rAux2 > 0 then
    begin
      rAux:= ( FieldByName('Merma').AsFloat * FieldByName('Compra').AsFloat ) / rAux2;
    end
    else
    begin
      rAux:= 0;
    end;
    if FieldByName('Compra').AsFloat > 0 then
    begin
      FieldByName('AjusteCompras1').AsFloat:= FieldByName('Compra1').AsFloat - ( ( FieldByName('Compra1').AsFloat / FieldByName('Compra').AsFloat ) * rAux );
      FieldByName('AjusteCompras2').AsFloat:= FieldByName('Compra2').AsFloat - ( ( FieldByName('Compra2').AsFloat / FieldByName('Compra').AsFloat ) * rAux );
      FieldByName('AjusteCompras3').AsFloat:= FieldByName('Compra3').AsFloat - ( ( FieldByName('Compra3').AsFloat / FieldByName('Compra').AsFloat ) * rAux );
      FieldByName('AjusteComprasDestrio').AsFloat:= FieldByName('CompraD').AsFloat - ( ( FieldByName('CompraD').AsFloat / FieldByName('Compra').AsFloat ) * rAux );
      FieldByName('AjusteComprasMerma').AsFloat:= rAux;
      FieldByName('AjusteCompras').AsFloat:= FieldByName('AjusteCompras1').AsFloat +
                                             FieldByName('AjusteCompras2').AsFloat +
                                             FieldByName('AjusteCompras3').AsFloat +
                                             FieldByName('AjusteComprasDestrio').AsFloat +
                                             FieldByName('AjusteComprasMerma').AsFloat;
    end
    else
    begin
      FieldByName('AjusteCompras1').AsFloat:= 0;
      FieldByName('AjusteCompras2').AsFloat:= 0;
      FieldByName('AjusteCompras3').AsFloat:= 0;
      FieldByName('AjusteComprasDestrio').AsFloat:= 0;
      FieldByName('AjusteComprasMerma').AsFloat:= 0;
      FieldByName('AjusteCompras').AsFloat:= 0;
    end;

    if rAux2 > 0 then
    begin
      rAux:= ( FieldByName('Merma').AsFloat * FieldByName('Normal').AsFloat ) / rAux2;
    end;
    if FieldByName('Normal').AsFloat > 0 then
    begin
      //Porcentaje salida primera
      if FieldByName('ConMerma').AsFloat > 0 then
      begin
        rAux2:= ( FieldByName('SalConMerma1').AsFloat / FieldByName('SalConMerma').AsFloat ) * FieldByName('Normal').AsFloat;
        FieldByName('AjusteNormal1').AsFloat:= rAux2 - ( ( rAux2 / FieldByName('Normal').AsFloat ) * rAux );

        rAux2:= ( FieldByName('SalConMerma2').AsFloat / FieldByName('SalConMerma').AsFloat ) * FieldByName('Normal').AsFloat;
        FieldByName('AjusteNormal2').AsFloat:= rAux2 - ( ( rAux2 / FieldByName('Normal').AsFloat ) * rAux );

        rAux2:= ( FieldByName('SalConMerma3').AsFloat / FieldByName('SalConMerma').AsFloat ) * FieldByName('Normal').AsFloat;
        FieldByName('AjusteNormal3').AsFloat:= rAux2 - ( ( rAux2 / FieldByName('Normal').AsFloat ) * rAux );

        rAux2:= ( FieldByName('SalConMermaDestrio').AsFloat / FieldByName('SalConMerma').AsFloat ) * FieldByName('Normal').AsFloat;
        FieldByName('AjusteNormalDestrio').AsFloat:= rAux2 - ( ( rAux2 / FieldByName('Normal').AsFloat ) * rAux );

        FieldByName('AjusteNormalMerma').AsFloat:= rAux;
        FieldByName('AjusteNormal').AsFloat:= FieldByName('AjusteNormal1').AsFloat +
                                             FieldByName('AjusteNormal2').AsFloat +
                                             FieldByName('AjusteNormal3').AsFloat +
                                             FieldByName('AjusteNormalDestrio').AsFloat +
                                             FieldByName('AjusteNormalMerma').AsFloat;
      end
      else
      begin
        FieldByName('AjusteNormal1').AsFloat:= 0;
        FieldByName('AjusteNormal2').AsFloat:= 0;
        FieldByName('AjusteNormal3').AsFloat:= 0;
        FieldByName('AjusteNormalDestrio').AsFloat:= 0;
        FieldByName('AjusteNormalMerma').AsFloat:= 0;
        FieldByName('AjusteNormal').AsFloat:= 0;
      end;
    end
    else
    begin
      FieldByName('AjusteNormal1').AsFloat:= 0;
      FieldByName('AjusteNormal2').AsFloat:= 0;
      FieldByName('AjusteNormal3').AsFloat:= 0;
      FieldByName('AjusteNormalDestrio').AsFloat:= 0;
      FieldByName('AjusteNormalMerma').AsFloat:= 0;
      FieldByName('AjusteNormal').AsFloat:= 0;
    end;


(*
    //Porcentaje merma sobre los kilos salida con merma
    if FieldByName('ConMerma').AsFloat >= 0 then
    begin
      if FieldByName('ConMerma').AsFloat > 0 then
        rAux:= bRoundTo( ( FieldByName('Merma').AsFloat * 100 ) / FieldByName('ConMerma').AsFloat, -2 )
      else
        rAux:= 0;
    end
    else
    begin
      rAux:= -1;
    end;

    //kilos que necesito en la salida para tener ese porcentaje
    if rAux <> -1 then
    begin
      if 100 - rAux <> 0 then
        rAux:=  ( FieldByName('SalConMerma').AsFloat * rAux ) / ( 100 - rAux )
      else
        rAux:= FieldByName('Merma').AsFloat;
    end
    else
    begin
      rAux:= 0
    end;

    FieldByName('AjusteSalidas1').AsFloat:= FieldByName('Sal1').AsFloat;
    FieldByName('AjusteSalidas2').AsFloat:= FieldByName('Sal2').AsFloat;
    FieldByName('AjusteSalidas3').AsFloat:= FieldByName('Sal3').AsFloat;
    FieldByName('AjusteSalidasDestrio').AsFloat:= FieldByName('SalDestrio').AsFloat;
    FieldByName('AjusteSalidasMerma').AsFloat:= rAux;
    FieldByName('AjusteSalidas').AsFloat:= FieldByName('AjusteSalidas1').AsFloat +
                                           FieldByName('AjusteSalidas2').AsFloat +
                                           FieldByName('AjusteSalidas3').AsFloat +
                                           FieldByName('AjusteSalidasDestrio').AsFloat +
                                           FieldByName('AjusteSalidasMerma').AsFloat;

    if FieldByName('KilosOutMerma').AsFloat = 0 then
    begin
      FieldByName('ObjetivoNormal1').AsFloat:= 0;
      FieldByName('ObjetivoNormal2').AsFloat:= 0;
      FieldByName('ObjetivoNormal3').AsFloat:= 0;
      FieldByName('ObjetivoNormalDestrio').AsFloat:= 0;
      FieldByName('ObjetivoNormalMerma').AsFloat:= 0;
    end
    else
    begin
      rAux:= FieldByName('Sal1Merma').AsFloat / FieldByName('KilosOutMerma').AsFloat;
      FieldByName('ObjetivoNormal1').AsFloat:= bRoundTo( FieldByName('KilosInNormal').AsFloat * rAux, -2 );

      rAux:= FieldByName('Sal2Merma').AsFloat / FieldByName('KilosOutMerma').AsFloat;
      FieldByName('ObjetivoNormal2').AsFloat:= bRoundTo( FieldByName('KilosInNormal').AsFloat * rAux, -2 );

      rAux:= FieldByName('Sal3Merma').AsFloat / FieldByName('KilosOutMerma').AsFloat;
      FieldByName('ObjetivoNormal3').AsFloat:= bRoundTo( FieldByName('KilosInNormal').AsFloat * rAux, -2 );

      rAux:= FieldByName('SalDestrioMerma').AsFloat / FieldByName('KilosOutMerma').AsFloat;
      FieldByName('ObjetivoNormalDestrio').AsFloat:= bRoundTo( FieldByName('KilosInNormal').AsFloat * rAux, -2 );

      rAux:= FieldByName('SalMerma').AsFloat / FieldByName('KilosOutMerma').AsFloat;
      FieldByName('ObjetivoNormalMerma').AsFloat:= bRoundTo( FieldByName('KilosInNormal').AsFloat * rAux, -2 );

      rAux:= FieldByName('KilosInNormal').AsFloat - ( FieldByName('ObjetivoNormal1').AsFloat +
                                                      FieldByName('ObjetivoNormal2').AsFloat +
                                                      FieldByName('ObjetivoNormal3').AsFloat +
                                                      FieldByName('ObjetivoNormalDestrio').AsFloat +
                                                      FieldByName('ObjetivoNormalMerma').AsFloat );
      //Ajustar cantidades
      if rAux <> 0 then
      begin
        if FieldByName('ObjetivoNormal1').AsFloat > FieldByName('ObjetivoNormal2').AsFloat then
        begin
          if FieldByName('ObjetivoNormal1').AsFloat > FieldByName('ObjetivoNormal3').AsFloat then
          begin
            FieldByName('ObjetivoNormal1').AsFloat:= FieldByName('ObjetivoNormal1').AsFloat + rAux;
          end
          else
          begin
            FieldByName('ObjetivoNormal3').AsFloat:= FieldByName('ObjetivoNormal3').AsFloat + rAux;
          end;
        end
        else
        if FieldByName('ObjetivoNormal2').AsFloat > FieldByName('ObjetivoNormal3').AsFloat then
        begin
          FieldByName('ObjetivoNormal2').AsFloat:= FieldByName('ObjetivoNormal2').AsFloat + rAux;
        end
        else
        begin
          FieldByName('ObjetivoNormal3').AsFloat:= FieldByName('ObjetivoNormal3').AsFloat + rAux;
        end;
      end;
    end;
*)

    FieldByName('AjusteEntradas1').AsFloat:= FieldByName('SinMerma1').AsFloat +
                                            FieldByName('AjusteCompras1').AsFloat +
                                            FieldByName('AjusteNormal1').AsFloat;
    FieldByName('AjusteEntradas2').AsFloat:= FieldByName('SinMerma2').AsFloat +
                                            FieldByName('AjusteCompras2').AsFloat +
                                            FieldByName('AjusteNormal2').AsFloat;
    FieldByName('AjusteEntradas3').AsFloat:= FieldByName('SinMerma3').AsFloat +
                                            FieldByName('AjusteCompras3').AsFloat +
                                            FieldByName('AjusteNormal3').AsFloat;
    FieldByName('AjusteEntradasDestrio').AsFloat:= FieldByName('AjusteComprasDestrio').AsFloat +
                                            FieldByName('AjusteNormalDestrio').AsFloat;
    FieldByName('AjusteEntradasMerma').AsFloat:= FieldByName('AjusteComprasMerma').AsFloat +
                                            FieldByName('AjusteNormalMerma').AsFloat;
    FieldByName('AjusteEntradas').AsFloat:= FieldByName('AjusteEntradas1').AsFloat +
                                            FieldByName('AjusteEntradas2').AsFloat +
                                            FieldByName('AjusteEntradas3').AsFloat +
                                            FieldByName('AjusteEntradasDestrio').AsFloat +
                                            FieldByName('AjusteEntradasMerma').AsFloat;
    Post;
  end;

  result:= true;
end;


end.
