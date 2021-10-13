unit ResumenListFobDM;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDMResumenListFob = class(TDataModule)
    kmtResumen: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sUno, sDos, sTres: string;
    iFuente: integer;

    procedure AltaLineaListadoEnvasesFOB;
    procedure ModLineaListadoFOB;
    function  Valor( const ACampo: string ): string;
    function  Codigo( const ACampo: string ): string;

    procedure IncializarResumen( const AUno, ADos, ATres: string );
    procedure ListadoResumen;
    procedure PrevisualizarResumen( const AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria: string;
      const ARangoFechaSalida: boolean; const AUno, ADos, ATres: string; const ATotalNivel1, ATotalNivel2, ATotal, AVerTotales, AVerFecha: boolean );
    procedure PrevisualizarResumenAmpliado( const AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria: string;
      const ARangoFechaSalida: boolean; const AUno, ADos, ATres: string; const ATotalNivel1, ATotalNivel2, ATotal, AVerTotales, AVerFecha: boolean );
  public
    bVerFecha: boolean;
    { Public declarations }

    function ListResumenFobExec( const AFuente: integer;
                           const AManuales, ASoloManuales: boolean;
                           const ACondicionPrecio: integer; const APrecioCorte: real;
                           const AUno, ADos, ATres: string; const ATotalNivel1, ATotalNivel2, ATotal, AVerTotales: boolean;
                           const AEmpresa, ACentroOrigen, ACentroSalida, AAlbaran, AFechaDesde, AFEchaHasta,
                                 AEnvase, ACliente, ATipoCliente, AProducto: string; const APais, ACategoria, ACalibre, ATipoGasto, AGrupoGasto: string;
                           const AExcluirTipoCliente, AExcluirInterplanta, ASuministro, AFechaSalida, AComisiones, ADescuentos, AGastosNoFac, AGastosFac, AGastosFijos: Boolean;
                           const AAlb6Digitos, ANoGasto, ACosteEnvase, ACosteSecciones, APromedio, ACosteFruta, AAyudas, ACosteEstructura, ANoP4H, AVerFecha: boolean;
                           const AProcedencia, AEsHortaliza, AClienteFac, AAlbFacturado: INteger ): boolean;

  end;

var
  DMResumenListFob: TDMResumenListFob;

implementation

{$R *.dfm}

uses
  Forms, TablaTemporalFOBData, LVentasLineaProductoClienteReport, CReportes, dPreview,
  UDMAuxDB, Variants, UDMMaster, bMath, LResumenFOBAmpliado;

procedure TDMResumenListFob.DataModuleCreate(Sender: TObject);
begin
  Application.CreateForm(TDMTablaTemporalFOB, DMTablaTemporalFOB);

  kmtResumen.FieldDefs.Clear;
  kmtResumen.FieldDefs.Add('uno', ftString, 60, False);
  kmtResumen.FieldDefs.Add('dos', ftString, 60, False);
  kmtResumen.FieldDefs.Add('tres', ftString, 60, False);
  kmtResumen.FieldDefs.Add('codeuno', ftString, 9, False);
  kmtResumen.FieldDefs.Add('codedos', ftString, 9, False);
  kmtResumen.FieldDefs.Add('codetres', ftString, 9, False);


  kmtResumen.FieldDefs.Add('fecha', ftDate, 0, False);
  kmtResumen.FieldDefs.Add('albaran', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('cajas', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('unidades', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('peso', ftFloat, 0, False);

  kmtResumen.FieldDefs.Add('importe', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('gasto_factura', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('descuento', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('gasto_albaran', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('coste_envase', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('coste_fruta', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('ayudas_fruta', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('coste_estructura', ftFloat, 0, False);


  kmtResumen.IndexFieldNames:= 'uno;dos;tres';
  kmtResumen.CreateTable;
end;

procedure TDMResumenListFob.DataModuleDestroy(Sender: TObject);
begin
  kmtResumen.Close;
  FreeAndNil( DMTablaTemporalFOB )
end;

function TDMResumenListFob.ListResumenFobExec( const AFuente: integer;
                           const AManuales, ASoloManuales: boolean;
                           const ACondicionPrecio: integer; const APrecioCorte: real;
                           const AUno, ADos, ATres: string; const ATotalNivel1, ATotalNivel2, ATotal, AVerTotales: boolean;
                           const AEmpresa, ACentroOrigen, ACentroSalida, AAlbaran, AFechaDesde, AFEchaHasta,
                                 AEnvase, ACliente, ATipoCliente, AProducto: string; const APais, ACategoria, ACalibre, ATipoGasto, AGrupoGasto: string;
                           const AExcluirTipoCliente, AExcluirInterplanta, ASuministro, AFechaSalida, AComisiones, ADescuentos, AGastosNoFac, AGastosFac, AGastosFijos: Boolean;
                           const AAlb6Digitos, ANoGasto, ACosteEnvase, ACosteSecciones, APromedio, ACosteFruta, AAyudas, ACosteEstructura, ANoP4H, AVerFecha: boolean;
                           const AProcedencia, AEsHortaliza, AClienteFac, AAlbFacturado: INteger ): boolean;

begin
  iFuente:= AFuente;
  with DMTablaTemporalFOB do
  begin
    sAEmpresa:= AEmpresa;
    iAProductoPropio:=AProcedencia;
    sACentroOrigen:= ACentroOrigen;
    sACentroSalida:= ACentroSalida;
    sACliente:= ACliente;
    sATipoCliente:= ATipoCliente;
    bAExcluirTipoCliente:= AExcluirTipoCliente;
    bAExcluirInterplanta:= AExcluirInterplanta;
    iAClienteFac:= AClienteFac;     // 1 -> facturable 2 -> no facturable resto -> todos
    //sASuministro:= ASuministro;
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
    sAGrupoGasto:=AGrupoGasto;
    bANoGasto:= ANoGasto;        // true -> excluye el gasto                       false -> lo incluye

    bAGastosNoFac:= AGastosNoFac;
    bAGastosFac:= AGastosFac;
    (**) bAGastosTransitos:= AGastosNoFac;
    bAComisiones:= AComisiones;
    bADescuentos:= ADescuentos;
    bACosteEnvase:= ACosteEnvase;
    bCosteFruta:= ACosteFruta;
    bAyudas:= AAyudas;
    bCosteEstructura:= ACosteEstructura;
    bACosteSecciones:= ACosteSecciones;
    bAPromedio:= APromedio;
    bAGastosFijos:=AGastosFijos;
  end;

  bVerFecha:=AVerFecha;


  result:= False;
  IncializarResumen( AUno, ADos, ATres );

  if AFuente = 0 then
  begin
    DMTablaTemporalFOB.AsignarBaseDeDatos( 'BDProyecto' );
    if DMTablaTemporalFOB.ObtenerDatosComunFob(False) then
    begin
      ListadoResumen;
      result:= True;
    end;
  end
  else
  begin
    DMTablaTemporalFOB.AsignarBaseDeDatos( 'dbSAT' );
    DMTablaTemporalFOB.sAEmpresa:= 'SAT';
    if DMTablaTemporalFOB.ObtenerDatosComunFob(false) then
    begin
      ListadoResumen;
      result:= True;
    end;

    DMTablaTemporalFOB.AsignarBaseDeDatos( 'dbBAG' );
    DMTablaTemporalFOB.sAEmpresa:= 'BAG';
    if DMTablaTemporalFOB.ObtenerDatosComunFob(false) then
    begin
      ListadoResumen;
      result:= True;
    end;
  end;

  if result then
  begin
    kmtResumen.SortOn('uno;dos;tres',[]);
    if ACosteFruta or ACosteEstructura or AAyudas then
      PrevisualizarResumenAmpliado( AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria, AFechaSalida,
                            AUno, ADos, ATres, ATotalNivel1, ATotalNivel2, ATotal, AVerTotales, AVerFecha )
    else
      PrevisualizarResumen( AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria, AFechaSalida,
                            AUno, ADos, ATres, ATotalNivel1, ATotalNivel2, ATotal, AVerTotales, AVerFecha );
  end;
end;

procedure TDMResumenListFob.IncializarResumen( const AUno, ADos, ATres: string );
begin
  kmtResumen.Close;
  kmtResumen.IndexFieldNames:= '';

  sUno:= AUno;
  sDos:= ADos;
  sTres:= ATres;


  if sUno <> '' then
    kmtResumen.IndexFieldNames:= 'uno';
  if sDos <> '' then
  begin
     if kmtResumen.IndexFieldNames <> '' then
       kmtResumen.IndexFieldNames:= kmtResumen.IndexFieldNames + ';dos'
     else
       kmtResumen.IndexFieldNames:= 'dos';
  end;
  if sTres <> '' then
  begin
     if kmtResumen.IndexFieldNames <> '' then
       kmtResumen.IndexFieldNames:= kmtResumen.IndexFieldNames + ';tres'
     else
       kmtResumen.IndexFieldNames:= 'tres';
  end;
  kmtResumen.Open;
end;

procedure TDMResumenListFob.ListadoResumen;
var bExiste: boolean;
begin
  DMTablaTemporalFOB.ClientDataSet.First;
  with DMTablaTemporalFOB.ClientDataSet do
  begin
    First;
    while not EOF do
    begin
      if bVerFecha then
        bExiste:= kmtResumen.Locate('uno;dos;tres;fecha;albaran',
                       VarArrayOf([ Valor( sUno ), Valor( sDos ), Valor( sTres ),
                       DMTablaTemporalFOB.ClientDataSet.FieldByName('fecha').AsDatetime,
                       DMTablaTemporalFOB.ClientDataSet.FieldByName('albaran').AsInteger]), [])
      else
        bExiste:= kmtResumen.Locate('uno;dos;tres',
                     VarArrayOf([ Valor( sUno ), Valor( sDos ), Valor( sTres )]), []);
      if bExiste then
        ModLineaListadoFOB
      else
        AltaLineaListadoEnvasesFOB;
      Next;
    end;
  end;
end;

function TDMResumenListFob.Valor( const ACampo: string ): string;
begin
  Result:= '';
  (*
  if ACampo = 'Sin agrupar' then
    Result:= ''
  else
  *)
  if ACampo = 'Comercial Venta' then
    Result:= desComercial( DMTablaTemporalFOB.ClientDataSet.FieldByName('comercial').AsString )
  else
  if ACampo = 'Cliente' then
    Result:= desCliente( DMTablaTemporalFOB.ClientDataSet.FieldByName('cliente').AsString )
  else
  if ACampo = 'Pais' then
    Result:= desPais( DMTablaTemporalFOB.ClientDataSet.FieldByName('pais').AsString )
  else
  if ACampo = 'Producto' then
  begin
//    if iFuente = 0 then
      Result:= StringReplace( desProducto( DMTablaTemporalFOB.ClientDataSet.FieldByName('empresa').AsString, DMTablaTemporalFOB.ClientDataSet.FieldByName('Producto').AsString ) ,'TOMATE', 'T.', [] )
//    else
//      Result:= StringReplace( desProducto( DMTablaTemporalFOB.ClientDataSet.FieldByName('empresa').AsString, DMTablaTemporalFOB.ClientDataSet.FieldByName('Producto').AsString ) ,'TOMATE', 'T.', [] )
  end
  else
  if ACampo = 'Linea Producto' then
    Result:= desLineaProducto( DMTablaTemporalFOB.ClientDataSet.FieldByName('Linea').AsString )
  else
  if ACampo = 'Agrupacion Comercial' then
    Result:= DMTablaTemporalFOB.ClientDataSet.FieldByName('Agrupacion').AsString
  else
  if ACampo = 'Artículo' then
  begin
    Result:= desEnvase( DMTablaTemporalFOB.ClientDataSet.FieldByName('empresa').AsString, DMTablaTemporalFOB.ClientDataSet.FieldByName('envase').AsString )
  end
  else
  if ACampo = 'Categoria' then
    Result:= DMTablaTemporalFOB.ClientDataSet.FieldByName('categoria').AsString
  else
  if ACampo = 'Periodo Facturación' then
    Result := desPeriodoFacturacion(DMTablaTemporalFOB.ClientDataSet.FieldByName('periodoFact').AsString);


  Result:= Copy( Result, 1 , 60 );
end;

function TDMResumenListFob.Codigo( const ACampo: string ): string;
begin
  Result:= '';
  (*
  if ACampo = 'Sin agrupar' then
    Result:= ''
  else
  *)
  if ACampo = 'Comercial Venta' then
    Result:= DMTablaTemporalFOB.ClientDataSet.FieldByName('comercial').AsString
  else
  if ACampo = 'Cliente' then
    Result:= DMTablaTemporalFOB.ClientDataSet.FieldByName('cliente').AsString
  else
  if ACampo = 'Pais' then
    Result:= DMTablaTemporalFOB.ClientDataSet.FieldByName('pais').AsString
  else
  if ACampo = 'Producto' then
    Result:= DMTablaTemporalFOB.ClientDataSet.FieldByName('Producto').AsString
  else
  if ACampo = 'Linea Producto' then
    Result:= DMTablaTemporalFOB.ClientDataSet.FieldByName('linea').AsString
  else
  if ACampo = 'Agrupacion Comercial' then
    Result:= ''
  else
  if ACampo = 'Artículo' then
    Result:= DMTablaTemporalFOB.ClientDataSet.FieldByName('envase').AsString
  else
  if ACampo = 'Categoria' then
    Result:= DMTablaTemporalFOB.ClientDataSet.FieldByName('categoria').AsString
  else
  if ACampo = 'Periodo Facturación' then
    Result := DMTablaTemporalFOB.ClientDataSet.FieldByName('periodoFact').AsString;

  Result:= Copy( Result, 1 , 9 );
end;

procedure TDMResumenListFob.AltaLineaListadoEnvasesFOB;
begin
  with kmtResumen do
  begin
    Insert;
    FieldByName('uno').AsString:= Valor( sUno );
    FieldByName('dos').AsString:= Valor( sDos );
    FieldByName('tres').AsString:= Valor( sTres );
    FieldByName('codeuno').AsString:= Codigo( sUno );
    FieldByName('codedos').AsString:= Codigo( sDos );
    FieldByName('codetres').AsString:= Codigo( sTres );

    if bVerFecha then
    begin
      FieldByName('fecha').AsDateTime:= DMTablaTemporalFOB.ClientDataSet.FieldByName('fecha').AsDateTime;
      FieldByName('albaran').AsInteger:= DMTablaTemporalFOB.ClientDataSet.FieldByName('albaran').AsInteger;
    end;
    FieldByName('cajas').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('cajas_producto').AsFloat;
    FieldByName('unidades').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('unidades_producto').AsFloat;
    FieldByName('peso').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('kilos_producto').AsFloat;

    //Moneda del albaran, pasar a euros
    FieldByName('importe').AsFloat:= bRoundTo(DMTablaTemporalFOB.ClientDataSet.FieldByName('importe').AsFloat * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('descuento').AsFloat:= bRoundTo( ( DMTablaTemporalFOB.ClientDataSet.FieldByName('comision').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('descuento').AsFloat )
                                               * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 3 );
    FieldByName('gasto_factura').AsFloat:= 0;
    FieldByName('gasto_albaran').AsFloat:= bRoundTo( ( DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_comun').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_transito').AsFloat )
                                             * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('coste_envase').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_envase').AsFloat +
                                          DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_seccion').AsFloat;
    FieldByName('coste_fruta').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_fruta').AsFloat;
    FieldByName('ayudas_fruta').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('ayudas_fruta').AsFloat;
    FieldByName('coste_estructura').AsFloat:= DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_estructura').AsFloat;
    Post;
  end;
end;

procedure TDMResumenListFob.ModLineaListadoFOB;
begin
  with kmtResumen do
  begin
    Edit;

    if FieldByName('codeuno').AsString <> Codigo( sUno ) then FieldByName('codeuno').AsString:= '*';
    if FieldByName('codedos').AsString <> Codigo( sDos ) then FieldByName('codedos').AsString:= '*';
    if FieldByName('codetres').AsString <> Codigo( sTres ) then FieldByName('codetres').AsString:= '*';

    FieldByName('cajas').AsFloat:= FieldByName('cajas').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('cajas_producto').AsFloat;
    FieldByName('unidades').AsFloat:= FieldByName('unidades').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('unidades_producto').AsFloat;
    FieldByName('peso').AsFloat:= FieldByName('peso').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('kilos_producto').AsFloat;

    FieldByName('importe').AsFloat:= FieldByName('importe').AsFloat + bRoundTo(DMTablaTemporalFOB.ClientDataSet.FieldByName('importe').AsFloat * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('descuento').AsFloat:= FieldByName('descuento').AsFloat + bRoundTo( ( DMTablaTemporalFOB.ClientDataSet.FieldByName('comision').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('descuento').AsFloat )
                                               * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('gasto_factura').AsFloat:= 0;
    FieldByName('gasto_albaran').AsFloat:= FieldByName('gasto_albaran').AsFloat + bRoundTo( ( DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_comun').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('gasto_transito').AsFloat )
                                             * DMTablaTemporalFOB.ClientDataSet.FieldByName('cambio').AsFloat, 2 );
    FieldByName('coste_envase').AsFloat:= FieldByName('coste_envase').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_envase').AsFloat +
                                           DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_seccion').AsFloat;
    FieldByName('coste_fruta').AsFloat:= FieldByName('coste_fruta').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_fruta').AsFloat;
    FieldByName('ayudas_fruta').AsFloat:= FieldByName('ayudas_fruta').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('ayudas_fruta').AsFloat;
    FieldByName('coste_estructura').AsFloat:= FieldByName('coste_estructura').AsFloat + DMTablaTemporalFOB.ClientDataSet.FieldByName('coste_estructura').AsFloat;

    Post;
  end;
end;


procedure TDMResumenListFob.PrevisualizarResumen( const AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria: string;
   const ARangoFechaSalida: boolean; const AUno, ADos, ATres: string; const ATotalNivel1, ATotalNivel2, ATotal, AVerTotales, AVerFecha: boolean );
var
  QRLVentasLineaProductoClienteReport: TQLVentasLineaProductoClienteReport;
begin
  QRLVentasLineaProductoClienteReport := TQLVentasLineaProductoClienteReport.Create(Application);
  PonLogoGrupoBonnysa(QRLVentasLineaProductoClienteReport, AEmpresa);
  QRLVentasLineaProductoClienteReport.sEmpresa := AEmpresa;
  QRLVentasLineaProductoClienteReport.bNivel1:= ATotalNivel1;
  QRLVentasLineaProductoClienteReport.bNivel2:= ATotalNivel2;
  QRLVentasLineaProductoClienteReport.bTotales:= ATotal;
  QRLVentasLineaProductoClienteReport.bVerTotales:= AVerTotales;
  if ATres <> '' then
  begin
    QRLVentasLineaProductoClienteReport.iAgrupaciones:= 3;
  end
  else
  if ADos <> '' then
  begin
    QRLVentasLineaProductoClienteReport.iAgrupaciones:= 2;
  end
  else
  if AUno <> '' then
  begin
    QRLVentasLineaProductoClienteReport.iAgrupaciones:= 1;
  end
  else
  begin
    QRLVentasLineaProductoClienteReport.iAgrupaciones:= 0;
  end;


  if ACentroOrigen = '' then
    QRLVentasLineaProductoClienteReport.qrlOrigen.Caption := 'ORIGEN TODOS LOS CENTROS'
  else
    QRLVentasLineaProductoClienteReport.qrlOrigen.Caption := 'ORIGEN ' + DesCentro( AEmpresa, ACentroOrigen );

  if ACentroSalida = '' then
    QRLVentasLineaProductoClienteReport.qrlDestino.Caption := 'SALIDA TODOS LOS CENTROS'
  else
    QRLVentasLineaProductoClienteReport.qrlDestino.Caption := 'DESTINO ' + DesCentro( AEmpresa, ACentroSalida );

  if AProducto = '' then
    QRLVentasLineaProductoClienteReport.qrlLProducto.Caption := 'TODOS LOS PRODUCTOS'
  else
    QRLVentasLineaProductoClienteReport.qrlLProducto.Caption := AProducto + ' ' + desProducto(AEmpresa, AProducto);

  if ARangoFechaSalida then
  begin
    //QRDatosExcelFOBReport.qrlblTitulo.Caption := 'LISTADO FOB - SALIDAS';
    QRLVentasLineaProductoClienteReport.qrlblPeriodo.Caption := 'SALIDAS DEL ' + AFechaDesde + ' AL ' + AFechaHasta;
  end
  else
  begin
    //QRDatosExcelFOBReport.qrlblTitulo.Caption := 'LISTADO FOB - FACTURAS';
    QRLVentasLineaProductoClienteReport.qrlblPeriodo.Caption := 'FACTURAS DEL ' + AFechaDesde + ' AL ' + AFechaHasta;
  end;

  if ARangoFechaSalida then
  begin
    QRLVentasLineaProductoClienteReport.qrlblTitulo.Caption := 'RESUMEN FOB - SALIDAS';
   end
  else
  begin
    QRLVentasLineaProductoClienteReport.qrlblTitulo.Caption := 'RESUMEN FOB - FACTURAS';
  end;

  QRLVentasLineaProductoClienteReport.qrlbluno.Caption:= AUno;//Descripcion( cbbUno.Items[cbbUno.ItemIndex] );
  QRLVentasLineaProductoClienteReport.qrlbldos.Caption:= ADos;//Descripcion( cbbTres.Items[cbbDos.ItemIndex] );
  QRLVentasLineaProductoClienteReport.qrlbltres.Caption:= ATres;//Descripcion( cbbTres.Items[cbbTres.ItemIndex] );
  QRLVentasLineaProductoClienteReport.qrlbluno_.Caption:= 'Des.' + AUno;//Descripcion( cbbUno.Items[cbbUno.ItemIndex] );
  QRLVentasLineaProductoClienteReport.qrlbldos_.Caption:= 'Des.' + ADos;//Descripcion( cbbTres.Items[cbbDos.ItemIndex] );
  QRLVentasLineaProductoClienteReport.qrlbltres_.Caption:= 'Des.' + ATres;//Descripcion( cbbTres.Items[cbbTres.ItemIndex] );

  if ACategoria <> '' then
  begin
    QRLVentasLineaProductoClienteReport.LCategoria.Caption:= 'CATEGORÍA: ' + Trim(ACategoria);
  end
  else
  begin
    QRLVentasLineaProductoClienteReport.LCategoria.Caption:= 'CATEGORÍA: TODAS';
  end;

  QRLVentasLineaProductoClienteReport.bVerFecha:= AVerFecha;

  Preview(QRLVentasLineaProductoClienteReport);
end;

procedure TDMResumenListFob.PrevisualizarResumenAmpliado( const AEmpresa, ACentroOrigen, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria: string;
   const ARangoFechaSalida: boolean; const AUno, ADos, ATres: string; const ATotalNivel1, ATotalNivel2, ATotal, AVerTotales, AVerFecha: boolean );
var
  QRLVentasLineaProductoClienteReport: TQLResumenFOBAmpliado;
begin
  QRLVentasLineaProductoClienteReport := TQLResumenFOBAmpliado.Create(Application);

  PonLogoGrupoBonnysa(QRLVentasLineaProductoClienteReport, AEmpresa);
  QRLVentasLineaProductoClienteReport.sEmpresa := AEmpresa;
  QRLVentasLineaProductoClienteReport.bNivel1:= ATotalNivel1;
  QRLVentasLineaProductoClienteReport.bNivel2:= ATotalNivel2;
  QRLVentasLineaProductoClienteReport.bTotales:= ATotal;
  QRLVentasLineaProductoClienteReport.bVerTotales:= AVerTotales;
  if ATres <> '' then
  begin
    QRLVentasLineaProductoClienteReport.iAgrupaciones:= 3;
  end
  else
  if ADos <> '' then
  begin
    QRLVentasLineaProductoClienteReport.iAgrupaciones:= 2;
  end
  else
  if AUno <> '' then
  begin
    QRLVentasLineaProductoClienteReport.iAgrupaciones:= 1;
  end
  else
  begin
    QRLVentasLineaProductoClienteReport.iAgrupaciones:= 0;
  end;


  if ACentroOrigen = '' then
    QRLVentasLineaProductoClienteReport.qrlOrigen.Caption := 'ORIGEN TODOS LOS CENTROS'
  else
    QRLVentasLineaProductoClienteReport.qrlOrigen.Caption := 'ORIGEN ' + DesCentro( AEmpresa, ACentroOrigen );

  if ACentroSalida = '' then
    QRLVentasLineaProductoClienteReport.qrlDestino.Caption := 'SALIDA TODOS LOS CENTROS'
  else
    QRLVentasLineaProductoClienteReport.qrlDestino.Caption := 'DESTINO ' + DesCentro( AEmpresa, ACentroSalida );

  if AProducto = '' then
    QRLVentasLineaProductoClienteReport.qrlLProducto.Caption := 'TODOS LOS PRODUCTOS'
  else
    QRLVentasLineaProductoClienteReport.qrlLProducto.Caption := AProducto + ' ' + desProducto(AEmpresa, AProducto);

  if ARangoFechaSalida then
  begin
    //QRDatosExcelFOBReport.qrlblTitulo.Caption := 'LISTADO FOB - SALIDAS';
    QRLVentasLineaProductoClienteReport.qrlblPeriodo.Caption := 'SALIDAS DEL ' + AFechaDesde + ' AL ' + AFechaHasta;
  end
  else
  begin
    //QRDatosExcelFOBReport.qrlblTitulo.Caption := 'LISTADO FOB - FACTURAS';
    QRLVentasLineaProductoClienteReport.qrlblPeriodo.Caption := 'FACTURAS DEL ' + AFechaDesde + ' AL ' + AFechaHasta;
  end;

  if ARangoFechaSalida then
  begin
    QRLVentasLineaProductoClienteReport.qrlblTitulo.Caption := 'RESUMEN FOB - SALIDAS';
   end
  else
  begin
    QRLVentasLineaProductoClienteReport.qrlblTitulo.Caption := 'RESUMEN FOB - FACTURAS';
  end;

  QRLVentasLineaProductoClienteReport.qrlbluno.Caption:= AUno;//Descripcion( cbbUno.Items[cbbUno.ItemIndex] );
  QRLVentasLineaProductoClienteReport.qrlbldos.Caption:= ADos;//Descripcion( cbbTres.Items[cbbDos.ItemIndex] );
  QRLVentasLineaProductoClienteReport.qrlbltres.Caption:= ATres;//Descripcion( cbbTres.Items[cbbTres.ItemIndex] );
  QRLVentasLineaProductoClienteReport.qrlbluno_.Caption:= 'Des.' + AUno;//Descripcion( cbbUno.Items[cbbUno.ItemIndex] );
  QRLVentasLineaProductoClienteReport.qrlbldos_.Caption:= 'Des.' + ADos;//Descripcion( cbbTres.Items[cbbDos.ItemIndex] );
  QRLVentasLineaProductoClienteReport.qrlbltres_.Caption:= 'Des.' + ATres;//Descripcion( cbbTres.Items[cbbTres.ItemIndex] );


  if ACategoria <> '' then
  begin
    QRLVentasLineaProductoClienteReport.LCategoria.Caption:= 'CATEGORÍA: ' + Trim(ACategoria);
  end
  else
  begin
    QRLVentasLineaProductoClienteReport.LCategoria.Caption:= 'CATEGORÍA: TODAS';
  end;

  Preview(QRLVentasLineaProductoClienteReport);
end;


end.
