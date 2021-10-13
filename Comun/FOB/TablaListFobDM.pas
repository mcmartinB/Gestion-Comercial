unit TablaListFobDM;

interface

uses
  SysUtils, Classes, DB, kbmMemTable;

type
  TDMTablaListFob = class(TDataModule)
    kmtTabla: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    procedure AltaLineaListadoEnvasesFOB( const Aproducto, ASemana: string; const ASumnistro: Boolean );
    procedure ModLineaListadoFOB( const ASemana: string );

    procedure ListadoFOBEnvases( const ACondicion: Integer; const ACorte: real; const ASuministro: boolean );

  public
    { Public declarations }
    function ListResumenFobExec(
                           const AManuales, ASoloManuales: boolean;
                           const ACondicionPrecio: integer; const APrecioCorte: real;
                           const AEmpresa, ACentroOrigen, ACentroSalida, AAlbaran, AFechaDesde, AFEchaHasta,
                                 AEnvase, ACliente, ATipoCliente, AProducto: string; const APais, ACategoria, ACalibre, ATipoGasto, AGrupoGasto: string;
                           const ASuministro, AFechaSalida, AComisiones, ADescuentos, AGastosNoFac, AGastosFac, AGastosFijos, ADesglose: Boolean;
                           const AAlb6Digitos, ANoGasto, ACosteEnvase, ACosteSecciones, APromedio, ACosteFruta, ACosteEstructura, AExcluirTipoCliente,
                                 AExcluirInterplanta,  AVerImportes, ANoP4H: boolean;
                           const AProcedencia, AEsHortaliza,  AClienteFac, AAlbFacturado: INteger ): boolean;
  end;

var
  DMTablaListFob: TDMTablaListFob;

implementation

{$R *.dfm}

uses
  Forms, TablaTemporalFOBData, bTimeUtils, bMath, Variants, DatosExcelFOBReport,
  DatosExcelFOBReportEx, UDMAuxDB;

procedure TDMTablaListFob.DataModuleCreate(Sender: TObject);
begin
  Application.CreateForm(TDMTablaTemporalFOB, DMTablaTemporalFOB);

  kmtTabla.FieldDefs.Clear;
  kmtTabla.FieldDefs.Add('empresa', ftString, 3, False);
  kmtTabla.FieldDefs.Add('centro_origen', ftString, 1, False);
  kmtTabla.FieldDefs.Add('centro', ftString, 1, False);
  kmtTabla.FieldDefs.Add('producto', ftString, 3, False);
  kmtTabla.FieldDefs.Add('categoria', ftString, 2, False);
  kmtTabla.FieldDefs.Add('calibre', ftString, 6, False);
  kmtTabla.FieldDefs.Add('comercial', ftString, 3, False);
  kmtTabla.FieldDefs.Add('cliente', ftString, 3, False);
  kmtTabla.FieldDefs.Add('suministro', ftString, 3, False);
  kmtTabla.FieldDefs.Add('envase', ftString, 9, False);
  kmtTabla.FieldDefs.Add('albaran', ftInteger, 0, False);
  kmtTabla.FieldDefs.Add('fecha_albaran', ftDate, 0, False);
  kmtTabla.FieldDefs.Add('linea', ftString, 30, False);
  kmtTabla.FieldDefs.Add('agrupacion', ftString, 30, False);
  kmtTabla.FieldDefs.Add('semana', ftString, 6, False);
  kmtTabla.FieldDefs.Add('facturado', ftInteger, 0, False);

  kmtTabla.FieldDefs.Add('cajas', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('unidades', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('palets', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('importe', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('comision', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('comision_fac', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('comision_no_fac', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('gasto_albaran', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('gasto_albaran_fac', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('gasto_albaran_no_fac', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('coste_envase', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('coste_seccion', ftFloat, 0, False);
  (*
  kmtTabla.FieldDefs.Add('descuento_nofac', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('descuento_fac', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('gasto_transito', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('gasto_venta', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('gasto_factura', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('coste_envase', ftFloat, 0, False);
  kmtTabla.FieldDefs.Add('coste_seccion', ftFloat, 0, False);
  *)

  kmtTabla.IndexFieldNames:= 'centro_origen;centro;producto;categoria;calibre;cliente;envase;albaran;semana;facturado';
  kmtTabla.CreateTable;
end;

procedure TDMTablaListFob.DataModuleDestroy(Sender: TObject);
begin
  kmtTabla.Close;
  FreeAndNil( DMTablaTemporalFOB )
end;

function TDMTablaListFob.ListResumenFobExec(
                           const AManuales, ASoloManuales: boolean;
                           const ACondicionPrecio: integer; const APrecioCorte: real;
                           const AEmpresa, ACentroOrigen, ACentroSalida, AAlbaran, AFechaDesde, AFEchaHasta,
                                 AEnvase, ACliente, ATipoCliente, AProducto: string; const APais, ACategoria, ACalibre, ATipoGasto, AGrupoGasto: string;
                           const ASuministro, AFechaSalida, AComisiones, ADescuentos, AGastosNoFac, AGastosFac, AGastosFijos, ADesglose: Boolean;
                           const AAlb6Digitos, ANoGasto, ACosteEnvase, ACosteSecciones, APromedio,  ACosteFruta, ACosteEstructura,  AExcluirTipoCliente,
                                 AExcluirInterplanta, AVerImportes, ANoP4H: boolean;
                           const AProcedencia, AEsHortaliza, AClienteFac, AAlbFacturado: INteger ): boolean;

begin
  with DMTablaTemporalFOB do
  begin
    sAEmpresa:= AEmpresa;
    iAProductoPropio:=AProcedencia ;
    sACentroOrigen:= ACentroOrigen;
    sACentroSalida:= ACentroSalida;
    sACliente:= ACliente;
    sATipoCliente:= ATipoCliente;
    bAExcluirTipoCliente:= AExcluirTipoCliente;
    bAExcluirInterplanta:= AExcluirInterplanta;
    iAClienteFac:= AClienteFac;     // 1 -> facturable 2 -> no facturable resto -> todos
    sAPais:= APais;
    sAALbaran:= AALbaran;
    bAAlb6Digitos:= AAlb6Digitos;    // true -> como minimo seis digitos (almacen) false -> todos
    iAAlbFacturado:= AAlbFacturado;   // 1 -> facturado  0 -> no facturado  resto -> todos
    bAManuales:= AManuales;
    bASoloManuales:= ASoloManuales;
    sAFechaDesde:= AFechaDesde;
    sAFEchaHasta:= AFEchaHasta;
    bAFechaSalida:= AFechaSalida;    // true -> rango fecha salidas false -> rango fecha facturas (solo facturados)
    sAProducto:= AProducto;
    iAEsHortaliza:= AEsHortaliza;       // 1 -> tomate 2 -> no tomate resto -> todos
    bANoP4H:= ANoP4H;
    sAEnvase:= AEnvase;
    sACategoria:= ACategoria;
    sACalibre:= ACalibre;
    sATipoGasto:= ATipoGasto;
    sAGrupoGasto:= AGrupoGasto;
    bANoGasto:= ANoGasto;        // true -> excluye el gasto                       false -> lo incluye

    bAGastosNoFac:= AGastosNoFac;
    bAGastosFac:= AGastosFac;
    bAGastosFijos := AGastosFijos;
    (**) bAGastosTransitos:= AGastosNoFac;
    bAComisiones:= AComisiones;
    bADescuentos:= ADescuentos;
    bACosteEnvase:= ACosteEnvase;
    bCosteFruta:= ACosteFruta;
    bCosteEstructura:= ACosteEstructura;
    bACosteSecciones:= ACosteSecciones;
    bAPromedio:= APromedio;
  end;
  if DMTablaTemporalFOB.ObtenerDatosComunFob(false) then

  begin
      ListadoFOBEnvases( ACondicionPrecio, APrecioCorte, ASuministro );
      if ADesglose then
        PrevisualizarTablaFOB_EX( AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria, ACalibre,
                                  AFechaSalida, ADescuentos, AGastosFac or ANoGasto, ACosteEnvase, ACosteSecciones, AVerImportes, ANoP4H,
                                  AEsHortaliza, AProcedencia, ACondicionPrecio, APrecioCorte )
      else
        PrevisualizarTablaFOB( AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria, ACalibre,
                                  AFechaSalida, ADescuentos, AGastosFac or ANoGasto, ACosteEnvase, ACosteSecciones,  AVerImportes, ANoP4H,
                                  AEsHortaliza, AProcedencia, ACondicionPrecio, APrecioCorte  );
      result:= True;
  end
  else
  begin
      result:= False;
  end;
end;

function PrecioOK( const APrecio, ACorte: Real; const ACondicion: Integer ): Boolean;
begin
  case  ACondicion of
    0:
      Result:= True;
    1://=
      Result:= APrecio = ACorte;
    2://<>
      Result:= APrecio <> ACorte;
    3://>=
      Result:= APrecio >= ACorte;
    4://<=
      Result:= APrecio <= ACorte;
    5://>
      Result:= APrecio > ACorte;
    6://<
      Result:= APrecio < ACorte;
    else
      Result:= False;
  end;
end;

procedure TDMTablaListFob.ListadoFOBEnvases( const ACondicion: Integer; const ACorte: real; const ASuministro: boolean );
var
  sSemana, sSumnistro: string;
  rPrecioLinea: real;
begin
  kmtTabla.Close;
  kmtTabla.IndexFieldNames:= 'empresa;centro_origen;centro;producto;categoria;calibre;comercial;cliente;suministro;envase;albaran;linea;agrupacion;semana;facturado';
  kmtTabla.Open;
  with DMTablaTemporalFOB.ClientDataSet do
  begin
    First;
    while not EOF do
    begin
      sSemana:= AnyoSemana( FieldByName('fecha').AsDateTime );

      if FieldByName('kilos_producto').AsFloat = 0 then
      begin
        rPrecioLinea:= 0;
      end
      else
      begin
        rPrecioLinea:= bRoundTo( ( bRoundTo(FieldByName('neto').AsFloat * FieldByName('cambio').AsFloat, 2 ) -
                         (
                           bRoundTo( ( FieldByName('gasto_comun').AsFloat + FieldByName('gasto_transito').AsFloat ) * FieldByName('cambio').AsFloat, 2 ) +
                           FieldByName('coste_envase').AsFloat +
                           FieldByName('coste_seccion').AsFloat
                         )
                       ) / FieldByName('kilos_producto').AsFloat, 4 );
      end;

      if PrecioOK( rPrecioLinea, ACorte, ACondicion ) then
      begin
        if ASuministro then
          sSumnistro:= FieldByName('suministro').AsString
        else
          sSumnistro:= '';
        if kmtTabla.Locate( 'empresa;centro_origen;centro;producto;categoria;calibre;comercial;cliente;suministro;envase;albaran;linea;agrupacion;semana;facturado',
                       VarArrayOf([FieldByName('empresa').AsString, FieldByName('centro_origen').AsString, FieldByName('centro').AsString,
                                   FieldByName('producto').AsString, FieldByName('categoria').AsString, FieldByName('calibre').AsString,
                                   FieldByName('comercial').AsString, FieldByName('cliente').AsString, sSumnistro,
                                   FieldByName('envase').AsString, FieldByName('albaran').AsString, FieldByName('linea').AsString, FieldByName('agrupacion').AsString,
                                   sSemana, FieldByName('facturado').AsInteger]), []) then
          ModLineaListadoFOB( sSemana )
        else
          AltaLineaListadoEnvasesFOB( FieldByName('producto').AsString, sSemana, ASuministro );
      end;
      Next;
    end;
  end;
  kmtTabla.SortOn('empresa;centro_origen;centro;producto;cliente;suministro;envase;semana',[]);
end;

procedure TDMTablaListFob.AltaLineaListadoEnvasesFOB( const Aproducto, ASemana: string; const ASumnistro: Boolean  );
begin
  with kmtTabla do
  begin
    Insert;
    FieldByName('empresa').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('empresa').AsString;
    FieldByName('centro_origen').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('centro_origen').AsString;
    FieldByName('centro').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('centro').AsString;
    FieldByName('producto').AsString:= Aproducto;
    FieldByName('categoria').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('categoria').AsString;
    FieldByName('calibre').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('calibre').AsString;
    FieldByName('comercial').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('comercial').AsString;
    FieldByName('cliente').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('cliente').AsString;

    if ASumnistro then
      FieldByName('suministro').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('suministro').AsString
    else
      FieldByName('suministro').AsString:= '';

    FieldByName('envase').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('envase').AsString;
    FieldByName('albaran').AsInteger:= DMTablaTemporalFOB.ClientDataSet.FieldByName('albaran').AsInteger;
    FieldByName('fecha_albaran').AsDateTime:= DMTablaTemporalFOB.ClientDataSet.FieldByName('fecha_albaran').AsDateTime;
    FieldByName('linea').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('linea').AsString;
    FieldByName('agrupacion').AsString:= DMTablaTemporalFOB.ClientDataSet.FieldByName('agrupacion').AsString;
    FieldByName('semana').AsString:= ASemana;
    FieldByName('facturado').AsInteger:= DMTablaTemporalFOB.ClientDataSet.FieldByName('facturado').AsInteger;

    FieldByName('cajas').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('cajas_producto').AsFloat;
    FieldByName('unidades').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('unidades_producto').AsFloat;
    FieldByName('palets').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('palets_producto').AsFloat;
    FieldByName('peso').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('kilos_producto').AsFloat;

    //Moneda del albaran, pasar a euros
    FieldByName('importe').AsFloat:= bRoundTo(DMTablaTemporalFOB.ClientDataSet.FieldByName('importe').AsFloat * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('comision').AsFloat:= bRoundTo( ( DMTablaTemporalFOB.ClientDataSet.FieldByName('comision').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('descuento').AsFloat )
                                               * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 3 );
    FieldByName('gasto_albaran').AsFloat:= bRoundTo( ( DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_comun').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_transito').AsFloat )
                                             * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );

    //En euros
    FieldByName('coste_envase').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_envase').AsFloat;
    FieldByName('coste_seccion').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_seccion').AsFloat;

    //Añadido por peticion Gerardo 05/02/2020
    FieldByName('comision_fac').AsFloat:= bRoundTo( DMTablaTemporalFOB.ClientDataSet.FieldByName('comision').AsFloat * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 3 );
    FieldByName('comision_no_fac').AsFloat:= bRoundTo( DMTablaTemporalFOB.ClientDataSet.FieldByName('descuento').AsFloat * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 3 );
    FieldByName('gasto_albaran_fac').AsFloat:= bRoundTo( ( DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_fac').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_transito').AsFloat )
                                             * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('gasto_albaran_no_fac').AsFloat:= bRoundTo( DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_no_fac').AsFloat * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );

    Post;
  end;
end;

procedure TDMTablaListFob.ModLineaListadoFOB( const ASemana: string );
begin
  with kmtTabla do
  begin
    Edit;
    FieldByName('cajas').AsFloat:= FieldByName('cajas').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('cajas_producto').AsFloat;
    FieldByName('unidades').AsFloat:= FieldByName('unidades').AsFloat+ DMTablaTemporalFOB.ClientDataSet.FieldByName('unidades_producto').AsFloat;
    FieldByName('palets').AsFloat:= FieldByName('palets').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('palets_producto').AsFloat;
    FieldByName('peso').AsFloat:= FieldByName('peso').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('kilos_producto').AsFloat;

    //Moneda del albaran, pasar a euros

    FieldByName('importe').AsFloat:= FieldByName('importe').AsFloat +
                                     bRoundTo(DMTablaTemporalFOB.ClientDataSet.FieldByName('importe').AsFloat * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('comision').AsFloat:= FieldByName('comision').AsFloat +
                                     bRoundTo( ( DMTablaTemporalFOB.ClientDataSet.FieldByName('comision').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('descuento').AsFloat )
                                               * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );


    FieldByName('gasto_albaran').AsFloat:= FieldByName('gasto_albaran').AsFloat +
                                   bRoundTo( ( DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_comun').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_transito').AsFloat )
                                             * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 ); ;

    //En euros
    FieldByName('coste_envase').AsFloat:= FieldByName('coste_envase').AsFloat +
                                    DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_envase').AsFloat;
    FieldByName('coste_seccion').AsFloat:= FieldByName('coste_seccion').AsFloat +
                                     DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_seccion').AsFloat;
    Post;
  end;
end;


end.
