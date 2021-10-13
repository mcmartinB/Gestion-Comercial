unit ResumenProduccionDM;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMResumenProduccion = class(TDataModule)
    QInventarioCab: TQuery;
    QInventarioLin: TQuery;
    QEntradas: TQuery;
    QSalidas: TQuery;
    QTransitos: TQuery;
    mtResumen: TkbmMemTable;
    qryProductos: TQuery;
    kmtProductos: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sProductoAux: string;
    dFechaIni, dFechaFin: TDateTime;

    rIniCampo, rIniDestrio, rIniTercera, rIniIntermedia1, rIniIntermedia2, rIniExpedicion1, rIniExpedicion2: real;
    rFinCampo, rFinDestrio, rFinTercera, rFinIntermedia1, rFinIntermedia2, rFinExpedicion1, rFinExpedicion2: real;


    rCosechado, rCompras, rTransitosIn, rVentas, rDestrio, rTransitosOut: real;
    rSal1, rSal2, rSal3: Real;

    procedure CrearTablaTemporal;
    procedure PreparaQuerys;
    procedure DesPreparaQuerys;

    procedure ObtenerDatos( var AMsg: string );
    procedure DatosInventario( var AMsg: string );
    procedure DatosEntrada( var AMsg: string );
    procedure DatosSalidas( var AMsg: string );
    procedure GrabarDatos( var AMsg: string );

    function  ObtenerProductos: Boolean;
    procedure AddProducto( const AEmpresa, ACentro, AProducto: string );

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
  ResumenProduccionQR, bMath, Variants;

var
  DMResumenProduccion: TDMResumenProduccion;

function ExecuteAprovechaResumen( const AOwner: TComponent;
                                  const AEmpresa, ACentro, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime;
                                  var AMsg: string  ): boolean;
begin
  DMResumenProduccion:= TDMResumenProduccion.Create( AOwner );

  //CODIGO
  with DMResumenProduccion do
  begin
    sEmpresa:= AEmpresa;
    sCentro:= ACentro;
    sProductoAux:= AProducto;
    dFechaIni:= AFechaIni;
    dFechaFin:= AFechaFin;

    AMsg:= '';

    mtResumen.Open;
    kmtProductos.Open;
    try
      if ObtenerProductos then
      begin
        Result:= True;
        while not kmtProductos.Eof do
        begin
          ObtenerDatos( AMsg );
          GrabarDatos( AMsg );
          kmtProductos.Next;
        end;
        PrintAprovechaResumen( AOwner, AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin );
      end
      else
      begin
        Result:= False;
        AMsg:= 'Sin datos para los productos seleccionados.';
      end;
    finally
      mtResumen.Close;
      kmtProductos.Close;
    end;
  end;

  FreeAndNil( DMResumenProduccion );
end;


procedure TDMResumenProduccion.DataModuleCreate(Sender: TObject);
begin
  CrearTablaTemporal;
  PreparaQuerys;
end;

procedure TDMResumenProduccion.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuerys;
end;

procedure TDMResumenProduccion.CrearTablaTemporal;
begin
  with kmtProductos do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('empresa', ftString, 3, False);
    FieldDefs.Add('centro', ftString, 3, False);
    FieldDefs.Add('producto', ftString, 3, False);
    CreateTable;
  end;

  with mtResumen do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('empresa', ftString, 3, False);
    FieldDefs.Add('centro', ftString, 3, False);
    FieldDefs.Add('producto', ftString, 3, False);

    FieldDefs.Add('KilosIni', ftFloat, 0, False);
    FieldDefs.Add('KilosFin', ftFloat, 0, False);
    FieldDefs.Add('KilosIn', ftFloat, 0, False);
    FieldDefs.Add('KilosProcesados', ftFloat, 0, False);
    FieldDefs.Add('KilosOut', ftFloat, 0, False);
    FieldDefs.Add('Merma', ftFloat, 0, False);

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

    FieldDefs.Add('Sal1', ftFloat, 0, False);
    FieldDefs.Add('Sal2', ftFloat, 0, False);
    FieldDefs.Add('Sal3', ftFloat, 0, False);
    FieldDefs.Add('SalDestrio', ftFloat, 0, False);

    CreateTable;
  end;
end;

procedure TDMResumenProduccion.AddProducto( const AEmpresa, ACentro, AProducto: string );
begin
  if not kmtProductos.Locate('empresa;centro;producto',vararrayof([AEmpresa,ACentro,AProducto ]),[]) then
  begin
    kmtProductos.Insert;
    kmtProductos.FieldByName('empresa').AsString:= AEmpresa;
    kmtProductos.FieldByName('centro').AsString:= ACentro;
    kmtProductos.FieldByName('producto').AsString:= AProducto;
    kmtProductos.Post;
  end;
end;

function TDMResumenProduccion.ObtenerProductos: Boolean;
begin
  with qryProductos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ic empresa, centro_ic centro, producto_ic producto');
    SQL.Add(' from frf_inventarios_c ');
    SQL.Add(' where empresa_ic = :empresa ');
    SQL.Add(' and centro_ic = :centro ');
    if sProductoAux <> '' then
      SQL.Add(' and producto_ic = :producto ');
    SQL.Add(' and fecha_ic = :fecha ');
    SQL.Add(' group by empresa_ic, centro_ic, producto_ic ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    if sProductoAux <> '' then
      ParamByName('producto').AsString:= sProductoAux;
    ParamByName('fecha').AsdateTime:= dFechaIni - 1;
    Open;

    while not Eof do
    begin
      AddProducto( FieldByname('empresa').AsString,
                   FieldByname('centro').AsString,
                   FieldByname('producto').AsString );
      Next;
    end;
    Close;

    ParamByName('fecha').AsdateTime:= dFechaFin;
    Open;
    while not Eof do
    begin
      AddProducto( FieldByname('empresa').AsString,
                   FieldByname('centro').AsString,
                   FieldByname('producto').AsString );
      Next;
    end;
    Close;


    SQL.Clear;
    SQL.Add(' select empresa_e2l empresa, centro_e2l centro, producto_e2l producto');
    SQL.Add(' from frf_entradas2_l ');
    SQL.Add(' where empresa_e2l = :empresa ');
    SQL.Add(' and centro_e2l = :centro ');
    if sProductoAux <> '' then
      SQL.Add(' and producto_e2l = :producto ');
    SQL.Add(' and fecha_e2l between :fechaini and :fechafin ');
    SQL.Add(' group by empresa, centro, producto ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    if sProductoAux <> '' then
      ParamByName('producto').AsString:= sProductoAux;
    ParamByName('fechaini').AsdateTime:= dFechaIni;
    ParamByName('fechafin').AsdateTime:= dFechaFin;
    Open;
    while not Eof do
    begin
      AddProducto( FieldByname('empresa').AsString,
                   FieldByname('centro').AsString,
                   FieldByname('producto').AsString );
      Next;
    end;
    Close;


    SQL.Clear;
    SQL.Add(' select empresa_sl empresa, centro_salida_sl centro, producto_sl producto');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and fecha_sc between :fechaini and :fechafin ');
    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');

    SQL.Add(' and centro_salida_sl = centro_origen_sl ');
    if sProductoAux <> '' then
      SQL.Add(' and producto_sl = :producto ');
    SQL.Add(' and categoria_sl <> ''B'' ');

    SQL.Add(' and ( nvl( es_transito_sc, 0 ) =  0 ) ');
    SQL.Add(' and TRIM( NVL( ref_transitos_sl, '''' )) = '''' ');

    SQL.Add(' group by empresa, centro, producto ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    if sProductoAux <> '' then
      ParamByName('producto').AsString:= sProductoAux;
    ParamByName('fechaini').AsdateTime:= dFechaIni;
    ParamByName('fechafin').AsdateTime:= dFechaFin;
    Open;
    while not Eof do
    begin
      AddProducto( FieldByname('empresa').AsString,
                   FieldByname('centro').AsString,
                   FieldByname('producto').AsString );
      Next;
    end;
    Close;

    SQL.Clear;
    SQL.Add(' select empresa_tl empresa, centro_tl centro, producto_tl producto ');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' WHERE empresa_tl = :empresa ');
    SQL.Add('   AND centro_origen_tl = :centro ');
    SQL.Add('   AND centro_tl = :centro ');
    SQL.Add('   AND fecha_tl between :fechaini and :fechafin ');
    if sProductoAux <> '' then
      SQL.Add('   AND producto_tl = :producto ');
    SQL.Add('   AND ref_origen_tl is null ');

    SQL.Add(' group by empresa, centro, producto, categoria_tl ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    if sProductoAux <> '' then
      ParamByName('producto').AsString:= sProductoAux;
    ParamByName('fechaini').AsdateTime:= dFechaIni;
    ParamByName('fechafin').AsdateTime:= dFechaFin;
    Open;
    while not Eof do
    begin
      AddProducto( FieldByname('empresa').AsString,
                   FieldByname('centro').AsString,
                   FieldByname('producto').AsString );
      Next;
    end;
    Close;
  end;

  kmtProductos.SortFields:= 'empresa;centro;producto';
  kmtProductos.Sort([]);
  Result:= not kmtProductos.IsEmpty;
  kmtProductos.First;
end;

procedure TDMResumenProduccion.PreparaQuerys;
begin
  with QInventarioCab do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ic empresa, centro_ic centro, producto_ic producto, ');
    SQL.Add('        kilos_cec_ic campo, ');
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
    SQL.Add(' select empresa_il empresa, centro_il centro, producto_il producto,');
    SQL.Add('        sum( kilos_ce_c1_il) expedicion1, ');
    SQL.Add('        sum( kilos_ce_c2_il) expedicion2 ');

    SQL.Add(' from frf_inventarios_l ');

    SQL.Add(' where empresa_il = :empresa ');
    SQL.Add(' and centro_il = :centro ');
    SQL.Add(' and producto_il = :producto ');
    SQL.Add(' and fecha_il = :fecha ');
    SQL.Add(' group by empresa, centro, producto ');
    Prepare;
  end;

  with QEntradas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_e2l empresa, centro_e2l centro, producto_e2l producto,');
    SQL.Add('        sum( total_kgs_e2l ) cosechado ');

    SQL.Add(' from frf_entradas2_l ');

    SQL.Add(' where empresa_e2l = :empresa ');
    SQL.Add(' and centro_e2l = :centro ');
    SQL.Add(' and producto_e2l = :producto ');
    SQL.Add(' and fecha_e2l between :fechaini and :fechafin ');
    SQL.Add(' group by empresa, centro, producto ');
    Prepare;
  end;

  with QSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl empresa, centro_salida_sl centro, producto_sl producto,');
    SQL.Add('        categoria_sl categoria, sum(kilos_sl) kilos ');

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

    SQL.Add(' and ( nvl( es_transito_sc, 0 ) =  0 ) ');
    SQL.Add(' and TRIM( NVL( ref_transitos_sl, '''' )) = '''' ');

    SQL.Add(' group by empresa, centro, producto, categoria_sl ');
    Prepare;
  end;
  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_tl empresa, centro_tl centro, producto_tl producto,');
    SQL.Add('        categoria_tl categoria, sum(kilos_tl) kilos ');

    SQL.Add(' from frf_transitos_l ');

    SQL.Add(' WHERE empresa_tl = :empresa ');
    SQL.Add('   AND centro_origen_tl = :centro ');
    SQL.Add('   AND centro_tl = :centro ');
    SQL.Add('   AND fecha_tl between :fechaini and :fechafin ');
    SQL.Add('   AND producto_tl = :producto ');
    SQL.Add('   AND ref_origen_tl is null ');

    SQL.Add(' group by empresa, centro, producto, categoria_tl ');
    Prepare;
  end;
end;


procedure TDMResumenProduccion.DesPreparaQuerys;
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

procedure TDMResumenProduccion.ObtenerDatos( var AMsg: string );
begin
  DatosInventario( AMsg );
  DatosEntrada( AMsg );
  DatosSalidas( AMsg );
end;


procedure  TDMResumenProduccion.DatosInventario( var AMsg: string );
begin
  with QInventarioCab do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= kmtProductos.FieldByName('producto').AsString;
    ParamByName('fecha').AsdateTime:= dFechaIni - 1;
    Open;
    if IsEmpty then
    begin
      Close;
      AMsg:= AMsg + #13 + #10 + 'Falta el inventario del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni - 1 ) + '"';
      rIniCampo:= 0;
      rIniDestrio:= 0;
      rIniTercera:= 0;
      rIniIntermedia1:= 0;
      rIniIntermedia2:= 0;
      rIniExpedicion1:= 0;
      rIniExpedicion2:= 0;
    end
    else
    begin
      rIniCampo:= FieldByName('campo').AsFloat;
      rIniDestrio:= FieldByName('destrio').AsFloat;
      rIniTercera:= FieldByName('tercera').AsFloat;
      rIniIntermedia1:= FieldByName('intermedia1').AsFloat;
      rIniIntermedia2:= FieldByName('intermedia2').AsFloat;
      Close;
      with QInventarioLin do
      begin
        ParamByName('empresa').AsString:= sEmpresa;
        ParamByName('centro').AsString:= sCentro;
        ParamByName('producto').AsString:= kmtProductos.FieldByName('producto').AsString;
        ParamByName('fecha').AsdateTime:= dFechaIni - 1;
        Open;
        rIniExpedicion1:= FieldByName('expedicion1').AsFloat;
        rIniExpedicion2:= FieldByName('expedicion2').AsFloat;
        Close;
      end;
    end;

    ParamByName('fecha').AsdateTime:= dFechaFin;
    Open;
    if IsEmpty then
    begin
      Close;
      AMsg:= AMsg + #13 + #10 +  'Falta el inventario del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaFin ) + '"';
      rFinCampo:= 0;
      rFinDestrio:= 0;
      rFinTercera:= 0;
      rFinIntermedia1:= 0;
      rFinIntermedia2:= 0;
      rFinExpedicion1:= 0;
      rFinExpedicion2:= 0;
    end
    else
    begin
      rFinCampo:= FieldByName('campo').AsFloat + FieldByName('ajustec').AsFloat;;
      rFinDestrio:= FieldByName('destrio').AsFloat  + FieldByName('ajusted').AsFloat;;
      rFinTercera:= FieldByName('tercera').AsFloat  + FieldByName('ajuste3').AsFloat;;
      rFinIntermedia1:= FieldByName('intermedia1').AsFloat + FieldByName('ajuste1').AsFloat;
      rFinIntermedia2:= FieldByName('intermedia2').AsFloat + FieldByName('ajuste2').AsFloat;
      Close;
      with QInventarioLin do
      begin
        ParamByName('empresa').AsString:= sEmpresa;
        ParamByName('centro').AsString:= sCentro;
        ParamByName('producto').AsString:= kmtProductos.FieldByName('producto').AsString;
        ParamByName('fecha').AsdateTime:= dFechaFin;
        Open;
        rFinExpedicion1:= FieldByName('expedicion1').AsFloat;
        rFinExpedicion2:= FieldByName('expedicion2').AsFloat;
        Close;
      end;
    end;
  end;
end;

procedure  TDMResumenProduccion.DatosEntrada( var AMsg: string );
begin
  with QEntradas do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= kmtProductos.FieldByName('producto').AsString;
    ParamByName('fechaini').AsdateTime:= dFechaIni;
    ParamByName('fechafin').AsdateTime:= dFechaFin;
    Open;
    if IsEmpty then
    begin
      rCosechado:= 0;
      AMsg:= AMsg + #13 + #10 + 'Sin entradas del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni ) + '" al "'  + FormatDateTime( 'dd/mm/yyyy', dFechaFin ) + '".';
    end
    else
    begin
      rCosechado:= FieldByName('cosechado').AsFloat;
      if rCosechado <= 0 then
      begin
        AMsg:= AMsg + #13 + #10 + 'Sin kilos de entradas del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni ) + '" al "'  + FormatDateTime( 'dd/mm/yyyy', dFechaFin ) + '".';
      end;
    end;
    Close;
  end;
end;

procedure TDMResumenProduccion.DatosSalidas( var AMsg: string );
var
  iCategoria: integer;
begin
   rSal1:= 0;
   rSal2:= 0;
   rSal3:= 0;
   rDestrio:= 0;

  with QSalidas do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= kmtProductos.FieldByName('producto').AsString;
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
        4: rDestrio:= rDestrio + FieldByName('kilos').AsFloat;
      end;
      Next;
    end;
    Close;
  end;
  if ( rSal1 + rSal2 + rSal3 + rDestrio ) <= 0 then
  begin
    AMsg:= AMsg + #13 + #10 + 'Sin salidas ni tránsitos del día "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni ) + '" al "'  + FormatDateTime( 'dd/mm/yyyy', dFechaFin ) + '".';
  end;

  with QTransitos do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= kmtProductos.FieldByName('producto').AsString;
    ParamByName('fechaini').AsdateTime:= dFechaIni;
    ParamByName('fechafin').AsdateTime:= dFechaFin;
    Open;
    while not eof do
    begin
      iCategoria:= StrToIntDef( FieldByName('categoria').AsString, 4 );
      case iCategoria of
        1: rSal1:= rSal1 + FieldByName('kilos').AsFloat;
        2: rSal2:= rSal1 + FieldByName('kilos').AsFloat;
        3: rSal3:= rSal1 + FieldByName('kilos').AsFloat;
        4: rDestrio:= rDestrio + FieldByName('kilos').AsFloat;
      end;
      Next;
    end;
    Close;
  end;

end;

procedure TDMResumenProduccion.GrabarDatos( var AMsg: string );
var
  rAux, rAux2: real;
begin
  with mtResumen do
  begin
    Insert;
    FieldByName('empresa').AsString:= kmtProductos.FieldByName('empresa').AsString;
    FieldByName('centro').AsString:= kmtProductos.FieldByName('centro').AsString;;
    FieldByName('producto').AsString:= kmtProductos.FieldByName('producto').AsString;;

    FieldByName('KilosIni').AsFloat:= rIniCampo + rIniDestrio + rIniTercera + rIniIntermedia1 + rIniIntermedia2 + rIniExpedicion1 + rIniExpedicion2;
    FieldByName('KilosFin').AsFloat:= rFinCampo + rFinDestrio + rFinTercera + rFinIntermedia1 + rFinIntermedia2 + rFinExpedicion1 + rFinExpedicion2;

    FieldByName('KilosIn').AsFloat:= rCosechado;

    FieldByName('KilosOut').AsFloat:= rSal1 + rSal2 + rSal3 + rDestrio;
    FieldByName('Sal1').AsFloat:= rSal1;
    FieldByName('Sal2').AsFloat:= rSal2;
    FieldByName('Sal3').AsFloat:= rSal3;
    FieldByName('SalDestrio').AsFloat:= rDestrio;

    FieldByName('KilosProcesados').AsFloat:= ( FieldByName('KilosIni').AsFloat + FieldByName('KilosIn').AsFloat ) -  FieldByName('KilosFin').AsFloat;
    FieldByName('Merma').AsFloat:= FieldByName('KilosProcesados').AsFloat - FieldByName('KilosOut').AsFloat;


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
    Post;
  end;
end;


end.
