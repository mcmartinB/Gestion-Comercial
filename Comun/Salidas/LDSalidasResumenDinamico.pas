unit LDSalidasResumenDinamico;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDMSalidasResumenDinamico = class(TDataModule)
    kmtResumen: TkbmMemTable;
    qryDatos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sUno, sDos, sTres, sCuatro: string;
    bTotalNivel1, bTotalNivel2, bTotal, bVerTotales, bInterPlanta: boolean;
    sEmpresa, sCentroSalida, sAlbaran, sFechaDesde, sFEchaHasta,
    sEnvase, sCliente, sTipoCliente, sProducto, sPais, sCategoria, sCalibre: string;
    bImportes, bVariosProductos, bIncluirProductos, bExcluirTipoCliente, bNoP4H: boolean;
    iEsHortaliza, iEsFacturable: INteger;

    procedure AltaLineaListadoEnvasesFOB;
    procedure ModLineaListadoFOB;
    //function  Valor( const ACampo: string; var AAux: string ): string;
    function  Valor( const ACampo: string ): string;
    function  Codigo( const ACampo: string ): string;

    procedure IncializarResumen( const AUno, ADos, ATres, ACuatro: string );
    function ObtenerDatosComun: boolean;
    procedure ListadoResumen;
    procedure PrevisualizarResumen( const AEmpresa, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria: string;
      const AUno, ADos, ATres, ACuatro: string; const ATotalNivel1, ATotalNivel2, ATotal, AVerTotales, AImportes: boolean );
  public
    { Public declarations }

    function ListSalidasResumenDinamicoExec(
                           const AUno, ADos, ATres, ACuatro: string; const ATotalNivel1, ATotalNivel2, ATotal, AVerTotales: boolean;
                           const AEmpresa, ACentroSalida, AAlbaran, AFechaDesde, AFEchaHasta,
                                 AEnvase, ACliente, ATipoCliente, AProducto, APais, ACategoria, ACalibre: string;
                           const AImportes, AVariosProductos, AIncluirProductos, AExcluirTipoCliente, ANoP4H, AInterPlanta: boolean;
                           const AEsFacturable, AEsHortaliza: INteger ): boolean;

  end;

var
  DMSalidasResumenDinamico: TDMSalidasResumenDinamico;

implementation

{$R *.dfm}

uses
  Forms, LRSalidasResumenDinamicoVer, CReportes, dPreview,
  UDMAuxDB, Variants, UDMMaster, bMath, bTExtUtils, bTimeUtils;

procedure TDMSalidasResumenDinamico.DataModuleCreate(Sender: TObject);
begin
  kmtResumen.FieldDefs.Clear;
  kmtResumen.FieldDefs.Add('uno', ftString, 60, False);
  kmtResumen.FieldDefs.Add('dos', ftString, 60, False);
  kmtResumen.FieldDefs.Add('tres', ftString, 60, False);
  kmtResumen.FieldDefs.Add('cuatro', ftString, 60, False);
  kmtResumen.FieldDefs.Add('codeuno', ftString, 15, False);
  kmtResumen.FieldDefs.Add('codedos', ftString, 15, False);
  kmtResumen.FieldDefs.Add('codetres', ftString, 15, False);
  kmtResumen.FieldDefs.Add('codecuatro', ftString, 15, False);

  kmtResumen.FieldDefs.Add('cajas', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('unidades', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtResumen.FieldDefs.Add('importe', ftFloat, 0, False);

  kmtResumen.IndexFieldNames:= 'uno;dos;tres;cuatro';
  kmtResumen.CreateTable;
end;

procedure TDMSalidasResumenDinamico.DataModuleDestroy(Sender: TObject);
begin
  kmtResumen.Close;
end;

function TDMSalidasResumenDinamico.ListSalidasResumenDinamicoExec(
                           const AUno, ADos, ATres, ACuatro: string; const ATotalNivel1, ATotalNivel2, ATotal, AVerTotales: boolean;
                           const AEmpresa, ACentroSalida, AAlbaran, AFechaDesde, AFEchaHasta,
                                 AEnvase, ACliente, ATipoCliente, AProducto, APais, ACategoria, ACalibre: string;
                           const AImportes, AVariosProductos, AIncluirProductos, AExcluirTipoCliente, ANoP4H, AInterPlanta: boolean;
                           const AEsFacturable, AEsHortaliza: INteger ): boolean;

begin
  sUno:= AUno;
  sDos:= ADos;
  sTres:= ATres;
  sCuatro:= ACuatro;
  
  bTotalNivel1:= ATotalNivel1;
  bTotalNivel2:= ATotalNivel2;
  bTotal:= ATotal;
  bVerTotales:= AVerTotales;
  sEmpresa:= AEmpresa;
  sCentroSalida:= ACentroSalida;
  sAlbaran:= AAlbaran;
  sFechaDesde:= AFechaDesde;
  sFEchaHasta:= AFEchaHasta;
  sEnvase:= AEnvase;
  sCliente:= ACliente;
  sTipoCliente:= ATipoCliente;
  bInterplanta:= AInterPlanta;
  sProducto:= AProducto;
  sPais:= APais;
  sCategoria:= ACategoria;
  sCalibre:= ACalibre;
  bImportes:= AImportes;
  bVariosProductos:= AVariosProductos;
  bIncluirProductos:= AIncluirProductos;
  bExcluirTipoCliente:= AExcluirTipoCliente;
  bNoP4H:= ANoP4H;
  iEsHortaliza:= AEsHortaliza;
  iEsFacturable:= AEsFacturable;

  result:= False;
  IncializarResumen( AUno, ADos, ATres, ACuatro );
  if ObtenerDatosComun then
  begin
    ListadoResumen;
    result:= True;
  end;
  qryDatos.Close;

  if result then
  begin
    kmtResumen.SortOn('uno;dos;tres;cuatro',[]);
    PrevisualizarResumen( AEmpresa, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria,
                          AUno, ADos, ATres, ACuatro, ATotalNivel1, ATotalNivel2, ATotal, AVerTotales, AImportes );
  end;
end;

procedure TDMSalidasResumenDinamico.IncializarResumen( const AUno, ADos, ATres, ACuatro: string );
begin
  kmtResumen.Close;
  kmtResumen.IndexFieldNames:= '';

  sUno:= AUno;
  sDos:= ADos;
  sTres:= ATres;
  sCuatro:= ACuatro;

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
  if sCuatro <> '' then
  begin
     if kmtResumen.IndexFieldNames <> '' then
       kmtResumen.IndexFieldNames:= kmtResumen.IndexFieldNames + ';cuatro'
     else
       kmtResumen.IndexFieldNames:= 'cuatro';
  end;
  kmtResumen.Open;
end;

(*
procedure TDMSalidasResumenDinamico.ListadoResumen;
var
  sAux: string;
  sAux1,sAux2,sAux3,sAux4: string;
begin
  with qryDatos do
  begin
    First;
    while not EOF do
    begin
      sAux:= '';
      sAux1:= Valor( sUno, sAux );
      if sAux <> '' then
        sAux1:= sAux1 + sAux;
      sAux:= '';
      sAux2:= Valor( sDos, sAux );
      if sAux <> '' then
        sAux2:= sAux2 + sAux;
      sAux:= '';
      sAux3:= Valor( sTres, sAux );
      if sAux <> '' then
        sAux3:= sAux3 + sAux;
      sAux:= '';
      sAux4:= Valor( sCuatro, sAux );
      if sAux <> '' then
        sAux4:= sAux4 + sAux;

      if kmtResumen.Locate('uno;dos;tres;cuatro',
                     VarArrayOf([ sAux1, sAux2, sAux3, sAux4]), []) then
        ModLineaListadoFOB
      else
        AltaLineaListadoEnvasesFOB;
      Next;
    end;
  end;
end;
*)

procedure TDMSalidasResumenDinamico.ListadoResumen;
begin
  with qryDatos do
  begin
    First;
    while not EOF do
    begin
      if kmtResumen.Locate('uno;dos;tres;cuatro',
                     VarArrayOf([ Valor( sUno ), Valor( sDos ), Valor( sTres ), Valor( sCuatro )]), []) then
        ModLineaListadoFOB
      else
        AltaLineaListadoEnvasesFOB;
      Next;
    end;
  end;
end;

(*
function TDMSalidasResumenDinamico.Valor( const ACampo: string; var AAux: string ): string;
begin
  Result:= '';
  AAux:= '';
  if ACampo = 'Comercial Venta' then
    Result:= UDMMaster.DMMaster.desComercial( qryDatos.FieldByName('comercial').AsString )
  else
  if ACampo = 'Empresa' then
    Result:= desEmpresa( qryDatos.FieldByName('empresa').AsString )
  else
  if ACampo = 'Cliente' then
    Result:= desCliente( qryDatos.FieldByName('cliente').AsString )
  else
  if ACampo = 'Producto' then
  begin
    //  Result:= StringReplace( desProducto( qryDatos.FieldByName('empresa').AsString, qryDatos.FieldByName('Producto').AsString ) ,'TOMATE', 'T.', [] )
    Result:= StringReplace( DMMaster.desProducto( qryDatos.FieldByName('empresa').AsString, qryDatos.FieldByName('Producto').AsString ) ,'TOMATE', 'T.', [] )
  end
  else
  if ACampo = 'Linea Producto' then
    Result:= qryDatos.FieldByName('Linea').AsString
  else
  if ACampo = 'Agrupacion Comercial' then
    Result:= qryDatos.FieldByName('Agrupacion').AsString
  else
  if ACampo = 'Envase' then
    Result:= desEnvase( qryDatos.FieldByName('empresa').AsString, qryDatos.FieldByName('envase').AsString )
  else
  if ACampo = 'Categoria' then
    Result:= qryDatos.FieldByName('categoria').AsString
  else
  if ACampo = 'Salida' then
  begin
    Result:= qryDatos.FieldByName('albaran').AsString;
    AAux:= qryDatos.FieldByName('fecha').AsString;
  end;

  Result:= Copy( Result, 1 , 60 );
end;
*)

function TDMSalidasResumenDinamico.Valor( const ACampo: string ): string;
begin
  Result:= '';
  if ACampo = 'Comercial Venta' then
    Result:= desComercial( qryDatos.FieldByName('comercial').AsString )
  else
  if ACampo = 'Empresa' then
    Result:= desEmpresa( qryDatos.FieldByName('empresa').AsString )
  else
  if ACampo = 'Cliente' then
    Result:= desCliente( qryDatos.FieldByName('cliente').AsString )
  else
  if ACampo = 'Producto' then
  begin
    Result:= desProducto( qryDatos.FieldByName('empresa').AsString, qryDatos.FieldByName('Producto').AsString );
    if Trim( Result ) <> 'TOMATE' then
      Result:= StringReplace( Result ,'TOMATE', 'T.', [] );
  end
//  else
//  if ACampo = 'Linea Producto' then
//    Result:= desLineaProducto( qryDatos.FieldByName('Linea').AsString )
  else
  if ACampo = 'Agrupación Comercial' then
    Result:= qryDatos.FieldByName('Agrupacion').AsString
  else
  if ACampo = 'Artículo' then
    Result:= desEnvase( qryDatos.FieldByName('empresa').AsString, qryDatos.FieldByName('envase').AsString )
  else
  if ACampo = 'Categoría' then
    Result:= qryDatos.FieldByName('categoria').AsString
  else
  if ACampo = 'Fecha' then
    Result:= qryDatos.FieldByName('fecha').AsString
  else
  if ACampo = 'Mensual' then
    Result:= AnyoMes( qryDatos.FieldByName('fecha').AsDateTime )
  else
  if ACampo = 'Albarán' then
    Result:= qryDatos.FieldByName('fecha').AsString + ' ' + qryDatos.FieldByName('albaran').AsString;

  Result:= Copy( Result, 1 , 60 );
end;

function TDMSalidasResumenDinamico.Codigo( const ACampo: string ): string;
begin
  Result:= '';
  if ACampo = 'Comercial Venta' then
    Result:= qryDatos.FieldByName('comercial').AsString
  else
  if ACampo = 'Empresa' then
    Result:= qryDatos.FieldByName('empresa').AsString
  else
  if ACampo = 'Cliente' then
    Result:= qryDatos.FieldByName('cliente').AsString
  else
  if ACampo = 'Producto' then
    Result:= qryDatos.FieldByName('Producto').AsString
//  else
//  if ACampo = 'Linea Producto' then
//    Result:= qryDatos.FieldByName('Linea').AsString
  else
  if ACampo = 'Agrupación Comercial' then
    Result:= ''
  else
  if ACampo = 'Artículo' then
    Result:= qryDatos.FieldByName('envase').AsString
  else
  if ACampo = 'Categoría' then
    Result:= qryDatos.FieldByName('categoria').AsString
  else
  if ACampo = 'Fecha' then
    Result:= ''
  else
  if ACampo = 'Memsual' then
    Result:= ''
  else
  if ACampo = 'Albarán' then
    Result:= '';

  Result:= Copy( Result, 1 , 9 );
end;


(*
procedure TDMSalidasResumenDinamico.AltaLineaListadoEnvasesFOB;
var
  sAux: string;
begin
  with kmtResumen do
  begin
    Insert;

    sAux:= '';
    FieldByName('uno').AsString:= Valor( sUno, sAux );
    if sAux <> '' then
      FieldByName('uno').AsString:= FieldByName('uno').AsString + sAux;

    sAux:= '';
    FieldByName('dos').AsString:= Valor( sDos, sAux );
    if sAux <> '' then
      FieldByName('dos').AsString:= FieldByName('dos').AsString + sAux;

    sAux:= '';
    FieldByName('tres').AsString:= Valor( sTres, sAux );
    if sAux <> '' then
      FieldByName('tres').AsString:= FieldByName('tres').AsString + sAux;

    sAux:= '';
    FieldByName('cuatro').AsString:= Valor( sCuatro, sAux );
    if sAux <> '' then
      FieldByName('cuatro').AsString:= FieldByName('cuatro').AsString + sAux;

    FieldByName('codeuno').AsString:= Codigo( sUno );
    FieldByName('codedos').AsString:= Codigo( sDos );
    FieldByName('codetres').AsString:= Codigo( sTres );
    FieldByName('codecuatro').AsString:= Codigo( sCuatro );

    FieldByName('cajas').AsFloat:= qryDatos.FieldByName('cajas_producto').AsFloat;
    FieldByName('unidades').AsFloat:= qryDatos.FieldByName('unidades_producto').AsFloat;
    FieldByName('peso').AsFloat:= qryDatos.FieldByName('kilos_producto').AsFloat;

    //Moneda del albaran, pasar a euros
    FieldByName('importe').AsFloat:= bRoundTo(qryDatos.FieldByName('importe').AsFloat / qryDatos.FieldByName('cambio').AsFloat, 2 );
    Post;
  end;
end;
*)

procedure TDMSalidasResumenDinamico.AltaLineaListadoEnvasesFOB;
begin
  with kmtResumen do
  begin
    Insert;

    FieldByName('uno').AsString:= Valor( sUno );
    FieldByName('dos').AsString:= Valor( sDos );
    FieldByName('tres').AsString:= Valor( sTres );
    FieldByName('cuatro').AsString:= Valor( sCuatro );

    FieldByName('codeuno').AsString:= Codigo( sUno );
    FieldByName('codedos').AsString:= Codigo( sDos );
    FieldByName('codetres').AsString:= Codigo( sTres );
    FieldByName('codecuatro').AsString:= Codigo( sCuatro );

    FieldByName('cajas').AsFloat:= qryDatos.FieldByName('cajas_producto').AsFloat;
    FieldByName('unidades').AsFloat:= qryDatos.FieldByName('unidades_producto').AsFloat;
    FieldByName('peso').AsFloat:= qryDatos.FieldByName('kilos_producto').AsFloat;

    //Moneda del albaran, pasar a euros
    if qryDatos.FieldByName('cambio').AsFloat <> 0 then
      FieldByName('importe').AsFloat:= bRoundTo(qryDatos.FieldByName('importe').AsFloat / qryDatos.FieldByName('cambio').AsFloat, 2 )
    else
      FieldByName('importe').AsFloat:= qryDatos.FieldByName('importe').AsFloat;

    Post;
  end;
end;

procedure TDMSalidasResumenDinamico.ModLineaListadoFOB;
begin
  with kmtResumen do
  begin
    Edit;

    if FieldByName('codeuno').AsString <> Codigo( sUno ) then FieldByName('codeuno').AsString:= '*';
    if FieldByName('codedos').AsString <> Codigo( sDos ) then FieldByName('codedos').AsString:= '*';
    if FieldByName('codetres').AsString <> Codigo( sTres ) then FieldByName('codetres').AsString:= '*';
    if FieldByName('codecuatro').AsString <> Codigo( sCuatro ) then FieldByName('codecuatro').AsString:= '*';

    FieldByName('cajas').AsFloat:= FieldByName('cajas').AsFloat + qryDatos.FieldByName('cajas_producto').AsFloat;
    FieldByName('unidades').AsFloat:= FieldByName('unidades').AsFloat + qryDatos.FieldByName('unidades_producto').AsFloat;
    FieldByName('peso').AsFloat:= FieldByName('peso').AsFloat + qryDatos.FieldByName('kilos_producto').AsFloat;

    if qryDatos.FieldByName('cambio').AsFloat <> 0 then
      FieldByName('importe').AsFloat:= FieldByName('importe').AsFloat + bRoundTo(qryDatos.FieldByName('importe').AsFloat / qryDatos.FieldByName('cambio').AsFloat, 2 )
    else
      FieldByName('importe').AsFloat:= FieldByName('importe').AsFloat + qryDatos.FieldByName('importe').AsFloat;
    Post;
  end;
end;


procedure TDMSalidasResumenDinamico.PrevisualizarResumen( const AEmpresa, ACentroSalida, AProducto, AFechaDesde, AFechaHasta, ACategoria: string;
   const AUno, ADos, ATres, ACuatro: string; const ATotalNivel1, ATotalNivel2, ATotal, AVerTotales, AImportes: boolean );
var
  QLSalidasResumenDinamico: TQLSalidasResumenDinamicoVer;
begin
  QLSalidasResumenDinamico := TQLSalidasResumenDinamicoVer.Create(Application);
  PonLogoGrupoBonnysa(QLSalidasResumenDinamico, AEmpresa);
  QLSalidasResumenDinamico.sEmpresa := AEmpresa;
  QLSalidasResumenDinamico.bNivel1:= ATotalNivel1;
  QLSalidasResumenDinamico.bNivel2:= ATotalNivel2;
  QLSalidasResumenDinamico.bTotales:= ATotal;
  QLSalidasResumenDinamico.bVerTotales:= AVerTotales;
  QLSalidasResumenDinamico.bImportes:= AImportes;

  if ACuatro <> '' then
  begin
    QLSalidasResumenDinamico.iAgrupaciones:= 4;
  end
  else
  if ATres <> '' then
  begin
    QLSalidasResumenDinamico.iAgrupaciones:= 3;
  end
  else
  if ADos <> '' then
  begin
    QLSalidasResumenDinamico.iAgrupaciones:= 2;
  end
  else
  if AUno <> '' then
  begin
    QLSalidasResumenDinamico.iAgrupaciones:= 1;
  end
  else
  begin
    QLSalidasResumenDinamico.iAgrupaciones:= 0;
  end;


  if ACentroSalida = '' then
    QLSalidasResumenDinamico.qrlDestino.Caption := 'TODOS LOS CENTROS'
  else
    QLSalidasResumenDinamico.qrlDestino.Caption := ACentroSalida + ' ' + DesCentro( AEmpresa, ACentroSalida );

  if AProducto = '' then
    QLSalidasResumenDinamico.qrlLProducto.Caption := 'TODOS LOS PRODUCTOS'
  else
    QLSalidasResumenDinamico.qrlLProducto.Caption := AProducto + ' ' + desProducto(AEmpresa, AProducto);

  QLSalidasResumenDinamico.qrlblPeriodo.Caption := 'SALIDAS DEL ' + AFechaDesde + ' AL ' + AFechaHasta;

  QLSalidasResumenDinamico.qrlbluno.Caption:= AUno;//Descripcion( cbbUno.Items[cbbUno.ItemIndex] );
  QLSalidasResumenDinamico.qrlbldos.Caption:= ADos;//Descripcion( cbbTres.Items[cbbDos.ItemIndex] );
  QLSalidasResumenDinamico.qrlbltres.Caption:= ATres;//Descripcion( cbbTres.Items[cbbTres.ItemIndex] );
  //QLSalidasResumenDinamico.qrlblCuatro.Caption:= ACuatro;//Descripcion( cbbTres.Items[cbbTres.ItemIndex] );

  if ACategoria <> '' then
  begin
    QLSalidasResumenDinamico.LCategoria.Caption:= 'CATEGORÍA: ' + Trim(ACategoria);
  end
  else
  begin
    QLSalidasResumenDinamico.LCategoria.Caption:= 'CATEGORÍA: TODAS';
  end;

  try
    Preview(QLSalidasResumenDinamico);
  except
    FreeAndNil( QLSalidasResumenDinamico );
  end;
end;

function TDMSalidasResumenDinamico.ObtenerDatosComun: boolean;
begin
  (*
  sAlbaran,
  iEsHortaliza: INteger;
  *)
  with qryDatos do
  begin
    sql.clear;
    sql.add(' select empresa_sl empresa, centro_salida_sl centro, n_albaran_sl albaran, fecha_sl fecha, ');
    sql.add('        cliente_sl cliente, producto_sl producto, envase_sl envase, ');
    sql.add('        categoria_sl categoria, comercial_sl comercial, ');
    sql.add('        agrupa_comercial_e Agrupacion, nvl(unidades_caja_sl,1) * cajas_sl unidades_producto, ');
    sql.add('        cajas_sl cajas_producto, kilos_sl kilos_producto, ');
    sql.add('        importe_neto_sl importe, ');
    sql.add('        case when moneda_sc = ''EUR'' then 1 ');
    sql.add('             else nvl(change(moneda_sc, fecha_sc),1) end cambio ');

    sql.add(' from frf_salidas_c ');
    sql.add('      join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl and fecha_sc = fecha_sl and n_albaran_sc = n_albaran_sl ');
    sql.add('      join frf_envases on envase_sl = envase_e and nvl(tipo_e,0) < 2 ');
    sql.add('      join frf_clientes on cliente_sal_Sc = cliente_c ');


    sql.add(' where fecha_sl between :fechaini and :fechafin ');
    if sEmpresa = 'BAG' then
      sql.add(' and substr(empresa_sl,1,1) = ''F'' ')
    else
    if sEmpresa = 'SAT' then
      sql.add(' and ( (empresa_sl = ''050'') or (empresa_sl = ''080'') ) ')
    else
      sql.add(' and empresa_sl = :empresa ');
    if bNoP4H then
      sql.add(' and empresa_sl <> ''F18''  ');



    if sProducto <> '' then
    begin
      if bVariosProductos then
      begin
        if bIncluirProductos then
          sql.add(' and producto_sl in ( ' + sProducto + ' ) ')
        else
          sql.add(' and producto_sl not in ( ' + sProducto + ' ) ');
      end
      else
      begin
        if bIncluirProductos then
          sql.add(' and producto_sl = :producto ')
        else
          sql.add(' and producto_sl <> :producto ');
      end;
    end;

    if sCentroSalida <> '' then
      sql.add(' and centro_salida_sl = :centro ');
    if sCliente <> '' then
      sql.add(' and cliente_sal_sc = :cliente ');

    if sTipoCliente <> '' then
    begin
      if bExcluirTipoCliente then
        sql.add(' and tipo_cliente_c <> :tipoCliente ')
      else
        sql.add(' and tipo_cliente_c = :tipoCliente ');
    end;

    if not bInterplanta then
    begin
      sql.add(' and tipo_cliente_c <> ''IP'' ')
    end;

    if sPais <> ''then
      sql.add(' and pais_c = :pais ');
    if sEnvase <> '' then
      sql.add(' and envase_sl = :envase ');

    if sCategoria <> '' then
    begin
      if Pos( ',', sCategoria ) > 0 then
      begin
        SQL.Add(' AND   categoria_sl in (' + ListaDeCadenas( sCategoria ) + ')');
      end
      else
      begin
        SQL.Add(' AND   categoria_sl = ' + QuotedStr( Trim( sCategoria ) ) );
      end;
    end;

    if sCalibre <> '' then
    begin
      if Pos( ',', sCalibre ) > 0 then
      begin
        SQL.Add(' AND   calibre_sl in (' + ListaDeCadenas( sCalibre ) + ')');
      end
      else
      begin
        SQL.Add(' AND   calibre_sl = ' + QuotedStr( Trim( sCalibre ) ) );
      end;
    end;

    case iEsFacturable of
      1://Facturado
        SQL.Add(' AND   fecha_factura_sc is not null');
      2://No Facturado
        SQL.Add(' AND   fecha_factura_sc is null');
      3://Facturable
        begin
          SQL.Add(' AND   fecha_factura_sc is null');
          SQL.Add(' AND   facturable_sc = 1 ');
        end;
      4://No Facturable
        begin
          SQL.Add(' AND   fecha_factura_sc is null');
          SQL.Add(' AND   facturable_sc = 0 ');
        end;
    end;

    if iEsHortaliza  = 1 then
    begin
        SQL.Add(' AND exists (  ');
        SQL.Add('              select * from frf_productos ');
        SQL.Add('              where producto_p = producto_sl ');
        SQL.Add('              and estomate_p = ''S'' ) ');
    end
    else
    if iEsHortaliza  = 2 then
    begin
        SQL.Add(' AND exists (  ');
        SQL.Add('              select * from frf_productos ');
        SQL.Add('              where producto_p = producto_sl ');
        SQL.Add('              and eshortaliza_p = ''S'' ) ');
    end
    else
    if iEsHortaliza  = 3 then
    begin
        SQL.Add(' AND exists (  ');
        SQL.Add('              select * from frf_productos ');
        SQL.Add('              where producto_p = producto_sl ');
        SQL.Add('              and eshortaliza_p = ''N'' ) ');
    end;

  end;

  qryDatos.ParamByname('fechaini').AsString:= sFechaDesde;
  qryDatos.ParamByname('fechafin').AsString:= sFechaHasta;
  if ( sEmpresa <> 'BAG' ) and ( sEmpresa <> 'SAT' )  and ( sEmpresa <> '' ) then
    qryDatos.ParamByname('empresa').AsString:= sEmpresa;
  if sProducto <> '' then
  begin
    if not bVariosProductos then
      qryDatos.ParamByname('producto').AsString:= sProducto;
  end;
  if sCliente <> '' then
    qryDatos.ParamByname('cliente').AsString:= sCliente;
  if sCentroSalida <> '' then
    qryDatos.ParamByname('centro').AsString:= sCentroSalida;
  if sEnvase <> '' then
    qryDatos.ParamByname('envase').AsString:= sEnvase;
  if sTipoCliente <> '' then
    qryDatos.ParamByname('tipoCliente').AsString:= sTipoCliente;
  if sPais <> '' then
    qryDatos.ParamByname('pais').AsString:= sPais;

  qryDatos.Open;
  result:= not qryDatos.isempty;
end;

end.
