unit PedidosEnvaseDL;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;

type
  TInfoEvent = procedure ( const ADesRegistro: string; const ARegistro, ARegistros: integer ) of object;

  TDLPedidosEnvase = class(TDataModule)
    QAux: TQuery;
    tListado: TkbmMemTable;
    QKilosAlbaran: TQuery;
    QCajasAlbaran: TQuery;
    QUnidadesAlbaran: TQuery;
    tTemporal: TkbmMemTable;
    QProductoAlbaran: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    iAguparPor: integer;
    
    function SQLSalidasSinPedido( const AProducto: string; const bDirSum: boolean ): string;
    function SQLPedidos( const AProducto: string; const bDirSum: boolean ): string;
    function SQLNumPedidos( const AProducto: string; const bDirSum: boolean ): string;

    function UnidadesAlbaran( const AEmpresa, ACentro, AProducto, ACliente, APedido, AUnidad, AEnvase:string;
      const AFecha: TDateTime ): TQuery;

    function AnyadirSalidasSinPedidos(
      const AEmpresa, ACentro, AProducto, ACliente, ADirSum:string;
      const AFechaIni, AFechaFin: TDateTime ): boolean;

    procedure ResumirRegistros;
    procedure AnyadirRegistro( const ATable: TDataSet;
      const ASemana, AProducto, AEnvase, AUnidad: String; const APedidos, AServidos: Real );

    procedure PreparaDatosAlbaran( const AEmpresa, ACentro, ACliente, ASuministro, AProducto, APedido: String;
                                   const AFecha: TDateTime );
    procedure AnyadirFrutaNoPedidadPeroServida( const AEmpresa, ACentro, ACliente, ASuministro, AProducto, APedido: String;
                                                const AFecha: TDateTime; const AProductos: TStringList );
    function  SePidio( const AProducto: string; const AProductos: TStringList ): boolean;

    function  AgruparPor( const AFecha: TDateTime ): string;
  public
    { Public declarations }
   procedure QueryListado(

     const AEmpresa, ACentro, ACliente, ASuministro, AProducto:string;
     const AFechaIni, AFechaFin: TDateTime; const AAgrupar: Integer;
     var ASinPedidos: boolean; const InformarProgreso: TInfoEvent );
  end;

  procedure CrearModuloDatos( const AParent: TComponent );
  procedure DestruirModuloDatos;

var
  DLPedidosEnvase: TDLPedidosEnvase = nil;

implementation

{$R *.dfm}

uses
  Variants, bTimeUtils;

var
  Conexiones: integer = 0;

procedure CrearModuloDatos( const AParent: TComponent );
begin
  if Conexiones = 0 then
  begin
    DLPedidosEnvase:= TDLPedidosEnvase.Create( AParent );
  end;
  Inc( Conexiones );
end;

procedure DestruirModuloDatos;
begin
  if Conexiones > 0 then
  begin
    Dec( Conexiones );
    if Conexiones = 0 then
    begin
      if DLPedidosEnvase <> nil then
        FreeAndNil( DLPedidosEnvase );
    end;
  end;
end;

function TDLPedidosEnvase.UnidadesAlbaran(
  const AEmpresa, ACentro, AProducto, ACliente, APedido, AUnidad, AEnvase:string;
  const AFecha: TDateTime ): TQuery;
begin
  if AUnidad = 'K' then
  begin
      QKilosAlbaran.ParamByName('empresa').AsString:= AEmpresa;
      QKilosAlbaran.ParamByName('centro').AsString:= ACentro;
      QKilosAlbaran.ParamByName('cliente').AsString:= ACliente;
      QKilosAlbaran.ParamByName('pedido').AsString:= APedido;
      QKilosAlbaran.ParamByName('producto').AsString:= AProducto;
      QKilosAlbaran.ParamByName('fecha').AsDateTime:= AFecha - 7;
      QKilosAlbaran.ParamByName('envase').AsString:= AEnvase;
      Result:= QKilosAlbaran;
  end
  else
  if AUnidad = 'U' then
  begin
      QUnidadesAlbaran.ParamByName('empresa').AsString:= AEmpresa;
      QUnidadesAlbaran.ParamByName('centro').AsString:= ACentro;
      QUnidadesAlbaran.ParamByName('cliente').AsString:= ACliente;
      QUnidadesAlbaran.ParamByName('pedido').AsString:= APedido;
      QUnidadesAlbaran.ParamByName('producto').AsString:= AProducto;
      QUnidadesAlbaran.ParamByName('fecha').AsDateTime:= AFecha - 7;
      QUnidadesAlbaran.ParamByName('envase').AsString:= AEnvase;
      Result:= QUnidadesAlbaran;
  end
  else
  begin
    QCajasAlbaran.ParamByName('empresa').AsString:= AEmpresa;
    QCajasAlbaran.ParamByName('centro').AsString:= ACentro;
    QCajasAlbaran.ParamByName('cliente').AsString:= ACliente;
    QCajasAlbaran.ParamByName('pedido').AsString:= APedido;
    QCajasAlbaran.ParamByName('producto').AsString:= AProducto;
    QCajasAlbaran.ParamByName('fecha').AsDateTime:= AFecha - 7;
    QCajasAlbaran.ParamByName('envase').AsString:= AEnvase;
    Result:= QCajasAlbaran;
  end;
end;

procedure TDLPedidosEnvase.AnyadirRegistro( const ATable: TDataSet;
  const ASemana, AProducto, AEnvase, AUnidad:String; const APedidos, AServidos: Real );
begin
  ATable.Insert;

  ATable.FieldByName('semana').AsString:= ASemana;
  ATable.FieldByName('producto').AsString:= AProducto;
  ATable.FieldByName('envase').AsString:= AEnvase;
  ATable.FieldByName('unidades_pedidas').AsFloat:= APedidos;
  ATable.FieldByName('unidades_servidas').AsFloat:= AServidos;
  ATable.FieldByName('unidad').AsString:= AUnidad;

  try
    ATable.Post;
  finally
    ATable.Cancel;
  end;
end;

procedure TDLPedidosEnvase.ResumirRegistros;
var
  sSemana, sProducto, sEnvase, sUnidad: string;
  rPedidos, rServidos: Real;
begin
  tTemporal.Sort([]);
  tTemporal.First;

  sSemana:= tTemporal.FieldByName('semana').AsString;
  sProducto:= tTemporal.FieldByName('producto').AsString;
  sEnvase:= tTemporal.FieldByName('envase').AsString;
  sUnidad:= tTemporal.FieldByName('unidad').AsString;
  rPedidos:= 0;
  rServidos:= 0;

  while not tTemporal.Eof do
  begin
    if ( sSemana + sProducto + sEnvase + sUnidad ) <>
       ( tTemporal.FieldByName('semana').AsString + tTemporal.FieldByName('producto').AsString +
         tTemporal.FieldByName('envase').AsString + tTemporal.FieldByName('unidad').AsString ) then
    begin
      AnyadirRegistro( tListado, sSemana, sProducto, sEnvase, sUnidad, rPedidos, rServidos );

      sSemana:= tTemporal.FieldByName('semana').AsString;
      sProducto:= tTemporal.FieldByName('producto').AsString;
      sEnvase:= tTemporal.FieldByName('envase').AsString;
      sUnidad:= tTemporal.FieldByName('unidad').AsString;
      rPedidos:= tTemporal.FieldByName('unidades_pedidas').AsFloat;
      rServidos:= tTemporal.FieldByName('unidades_servidas').AsFloat;
    end
    else
    begin
      rPedidos:= rPedidos + tTemporal.FieldByName('unidades_pedidas').AsFloat;
      rServidos:= rServidos + tTemporal.FieldByName('unidades_servidas').AsFloat;
    end;
    tTemporal.Next;
  end;
  AnyadirRegistro( tListado, sSemana, sProducto, sEnvase, sUnidad, rPedidos, rServidos );

  tListado.Sort([]);
end;

function TDLPedidosEnvase.AnyadirSalidasSinPedidos(
      const AEmpresa, ACentro, AProducto, ACliente, ADirSum:string;
      const AFechaIni, AFechaFin: TDateTime ): boolean;
var
  sSQL: string;
  bProducto, bDirSum: Boolean;
begin
  QAux.SQL.Clear;
  bProducto:= ( Trim(AProducto) <> '' );
  bDirSum:= ( Trim(ADirSum) <> '' );
  sSQL:= SQLSalidasSinPedido( AProducto, bDirSum );
  QAux.SQL.Add( sSQL );
  QAux.ParamByName('empresa').AsString:= AEmpresa;
  QAux.ParamByName('centro').AsString:= ACentro;
  QAux.ParamByName('cliente').AsString:= ACliente;
  QAux.ParamByName('fechaini').AsDateTime:= AFechaIni;
  QAux.ParamByName('fechafin').AsDateTime:= AFechaFin;
  if bDirSum then
    QAux.ParamByName('suministro').AsString:= ADirSum;
  if bProducto then
  begin
    QAux.ParamByName('producto').AsString:= AProducto;
  end;

  QAux.Open;
  result:= not QAux.IsEmpty;

  if result then
  begin
    while not QAux.Eof do
    begin
      if tListado.Locate('producto;envase', VarArrayOf([QAux.FieldByName('producto').AsString,
        QAux.FieldByName('envase').AsString]),[]) then
      begin
        tListado.Edit;

        tListado.FieldByName('producto').AsString:= QAux.FieldByName('producto').AsString;
        tListado.FieldByName('envase').AsString:= QAux.FieldByName('envase').AsString;
        if tListado.FieldByName('unidad').AsString = 'K' then
        begin
          tListado.FieldByName('unidades_servidas').AsFloat:=
            tListado.FieldByName('unidades_servidas').AsFloat + QAux.FieldByName('kilos').AsFloat;
        end
        else
        if tListado.FieldByName('unidad').AsString = 'U' then
        begin
          tListado.FieldByName('unidades_servidas').AsFloat:=
            tListado.FieldByName('unidades_servidas').AsFloat + QAux.FieldByName('unidades').AsFloat;
        end
        else
        if tListado.FieldByName('unidad').AsString = 'C' then
        begin
          tListado.FieldByName('unidades_servidas').AsFloat:=
            tListado.FieldByName('unidades_servidas').AsFloat + QAux.FieldByName('cajas').AsFloat;
        end;

        try
          tListado.Post;
        finally
          tListado.Cancel;
        end;
      end
      else
      begin
        tListado.Insert;

        tListado.FieldByName('producto').AsString:= QAux.FieldByName('producto').AsString;
        tListado.FieldByName('envase').AsString:= QAux.FieldByName('envase').AsString;
        tListado.FieldByName('unidad').AsString:= 'K';
        tListado.FieldByName('unidades_pedidas').AsFloat:= 0;
        tListado.FieldByName('unidades_servidas').AsFloat:= QAux.FieldByName('kilos').AsFloat;

        try
          tListado.Post;
        finally
          tListado.Cancel;
        end;
      end;

      QAux.Next;
    end;
  end;

  QAux.Close;
  tListado.Sort([]);
end;

function  TDLPedidosEnvase.AgruparPor( const AFecha: TDateTime ): string;
var
  iAnyo, iMes, iDia: word;
begin
  case iAguparPor of
    1: result:= FormatDateTime( 'yyyy', AFecha );
    2: result:= FormatDateTime( 'yyyymm', AFecha );
    3: result:= AnyoSemana( AFecha );
    4: result:= FormatDateTime( 'yyyymmdd', AFecha );
    else result:= '';
  end;
end;

procedure TDLPedidosEnvase.QueryListado(
  const AEmpresa, ACentro, ACliente, ASuministro, AProducto:string;
  const AFechaIni, AFechaFin: TDateTime; const AAgrupar: Integer;
  var ASinPedidos: boolean ; const InformarProgreso: TInfoEvent );
var
  QUnidadesAlmacen: TQuery;
  iRegistros, iRegistro: Integer;
  sRegistro: String;
  sSQL: string;
  bDirSum, bProducto: boolean;
  slProductos: TStringList;
begin
  iAguparPor:= AAgrupar;
  //Cerrar datos
  tTemporal.Close;
  tListado.Close;
  slProductos:= TStringList.Create;
  slProductos.Duplicates:= (dupIgnore);

  with QAux do
  begin
    bDirSum:= ( Trim(ASuministro) <> '' );
    bProducto:= ( Trim(AProducto) <> '' );

    SQL.Clear;
    sSQL:= SQLNumPedidos( AProducto, bDirSum );
    SQL.Add( sSQL );

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('inicio').AsDateTime:= AFechaIni;
    ParamByName('fin').AsDateTime:= AFechaFin;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('cliente').AsString:= ACliente;
    if bDirSum then
        ParamByName('suministro').AsString:= ASuministro;
    if bProducto then
    begin
      QAux.ParamByName('producto').AsString:= AProducto;
    end;

    Open;
    iRegistros:= Fields[0].AsInteger;
    Close;

    if iRegistros = 0 then
      exit;
    iRegistro:= 0;
    sRegistro:= '';

    SQL.Clear;
    sSQL:= SQLPedidos( AProducto, bDirSum );
    SQL.Add( sSQL );

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('inicio').AsDateTime:= AFechaIni;
    ParamByName('fin').AsDateTime:= AFechaFin;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('cliente').AsString:= ACliente;
    if bDirSum then
        ParamByName('suministro').AsString:= ASuministro;
    if bProducto then
      ParamByName('producto').AsString:= AProducto;

    Open;
    tTemporal.Open;
    tListado.Open;
    slProductos.Clear;
    while not EOF do
    begin
      if FieldByName('ref_pedido_pdc').AsString <> sRegistro then
      begin
        Inc( iRegistro );
        if sRegistro <> '' then
        begin
          AnyadirFrutaNoPedidadPeroServida( AEmpresa, ACentro, ACliente, ASuministro, AProducto, sRegistro,
                                            FieldByName('fecha_pdc').AsDateTime, slProductos );
          slProductos.Clear;
        end;
        sRegistro:= FieldByName('ref_pedido_pdc').AsString;

        if Assigned( InformarProgreso ) then
          InformarProgreso( sRegistro, iRegistro, iRegistros );
      end;

      slProductos.Add(FieldByName('producto_pdd').AsString + FieldByName('envase_pdd').AsString);

      QUnidadesAlmacen:= UnidadesAlbaran( AEmpresa, ACentro, FieldByName('producto_pdd').AsString,
        ACliente, FieldByName('ref_pedido_pdc').AsString, FieldByName('unidad_pdd').AsString,
        FieldByName('envase_pdd').AsString, FieldByName('fecha_pdc').AsDateTime );

      QUnidadesAlmacen.Open;

      if QUnidadesAlmacen.IsEmpty then
      begin
        AnyadirRegistro( tTemporal, AgruparPor( FieldByName('fecha_pdc').AsDateTime ),
          FieldByName('producto_pdd').AsString,
          FieldByName('envase_pdd').AsString, FieldByName('unidad_pdd').AsString,
          FieldByName('unidades_pdd').AsFloat, 0 );

      end
      else
      begin
        While not QUnidadesAlmacen.Eof do
        begin
          AnyadirRegistro( tTemporal, AgruparPor( FieldByName('fecha_pdc').AsDateTime ),
            FieldByName('producto_pdd').AsString,
            FieldByName('envase_pdd').AsString, FieldByName('unidad_pdd').AsString,
            FieldByName('unidades_pdd').AsFloat, QUnidadesAlmacen.FieldByName('unidades').AsFloat );

          QUnidadesAlmacen.Next;
        end;
      end;

      QUnidadesAlmacen.Close;
      Next;
    end;

    if not IsEmpty then
    begin
      AnyadirFrutaNoPedidadPeroServida( AEmpresa, ACentro, ACliente, ASuministro, AProducto, sRegistro,
                                        FieldByName('fecha_pdc').AsDateTime, slProductos );
      slProductos.Clear;
    end;

    Close;
  end;

  ResumirRegistros;

  if ASinPedidos then
  begin
    if Assigned( InformarProgreso ) then
      InformarProgreso( 'Añadiendo salidas sin número de pedido.', -1, -1 );
    ASinPedidos:= AnyadirSalidasSinPedidos(AEmpresa, ACentro, AProducto, ACliente, ASuministro, AFechaIni, AFechaFin );
  end;

  if Assigned( InformarProgreso ) then
    InformarProgreso( 'FIN', -1, -1 );

  FreeAndNil( slProductos );
end;

procedure TDLPedidosEnvase.AnyadirFrutaNoPedidadPeroServida(
  const AEmpresa, ACentro, ACliente, ASuministro, AProducto, APedido: String;
  const AFecha: TDateTime; const AProductos: TStringList );
var
  sProducto: string;
begin
  PreparaDatosAlbaran( AEmpresa, ACentro, ACliente, ASuministro, AProducto, APedido, AFecha );
  with QProductoAlbaran do
  begin
    Open;
    while not EOF do
    begin
      sProducto:= FieldByName('producto_sl').AsString;
      if not SePidio( sProducto + FieldByName('envase_sl').AsString, AProductos ) then
      begin
        AnyadirRegistro( tTemporal, AgruparPor( FieldByName('fecha_sl').AsDateTime ), sProducto,
          FieldByName('envase_sl').AsString, 'C', 0, FieldByName('cajas').AsFloat )
      (*
        if FieldByName('unidad_precio_sl').AsString = 'CAJ' then
          AnyadirRegistro( tTemporal, AgruparPor( FieldByName('fecha_sl').AsDateTime ), sProducto,
            FieldByName('envase_sl').AsString, 'C', 0, FieldByName('cajas').AsFloat )
        else
        if FieldByName('unidad_precio_sl').AsString = 'UND' then
          AnyadirRegistro( tTemporal, AgruparPor( FieldByName('fecha_sl').AsDateTime ), sProducto,
            FieldByName('envase_sl').AsString, 'U', 0, FieldByName('unidades').AsFloat )
        else
          AnyadirRegistro( tTemporal, AgruparPor( FieldByName('fecha_sl').AsDateTime ), sProducto,
            FieldByName('envase_sl').AsString, 'K', 0, FieldByName('kilos').AsFloat );
        *)
      end;
      Next;
    end;
    Close;
  end;
end;

function TDLPedidosEnvase.SePidio( const AProducto: string; const AProductos: TStringList ): boolean;
var
  i: integer;
begin
  result:= False;
  for i:= 0 to AProductos.Count - 1 do
  begin
    result:= AProducto = AProductos[i];
    if result then
      Break;
  end;
end;

procedure TDLPedidosEnvase.DataModuleCreate(Sender: TObject);
begin
  tTemporal.FieldDefs.Clear;
  tTemporal.FieldDefs.Add('unidad', ftString, 1, False);
  tTemporal.FieldDefs.Add('semana', ftString, 8, False);
  tTemporal.FieldDefs.Add('producto', ftString, 3, False);
  tTemporal.FieldDefs.Add('envase', ftString, 9,  False);
  tTemporal.FieldDefs.Add('unidades_pedidas', ftFloat, 0, False);
  tTemporal.FieldDefs.Add('unidades_servidas', ftFloat, 0, False);



  tTemporal.CreateTable;
  tTemporal.SortFields := 'unidad;semana;producto;envase';
  tTemporal.IndexFieldNames := 'unidad;semana;producto;envase';

  tListado.FieldDefs.Clear;
  tListado.FieldDefs.Add('unidad', ftString, 1, False);
  tListado.FieldDefs.Add('semana', ftString, 8, False);
  tListado.FieldDefs.Add('producto', ftString, 3, False);
  tListado.FieldDefs.Add('envase', ftString, 9, False);
  tListado.FieldDefs.Add('unidades_pedidas', ftFloat, 0, False);
  tListado.FieldDefs.Add('unidades_servidas', ftFloat, 0, False);


  tListado.CreateTable;
  tListado.SortFields := 'unidad;semana;producto;envase';
  tListado.IndexFieldNames := 'unidad;semana;producto;envase';


  QKilosAlbaran.SQL.Clear;
  QKilosAlbaran.SQL.Add( 'select sum(kilos_sl) unidades');
  QKilosAlbaran.SQL.Add( 'from frf_salidas_c, frf_salidas_l ');
  QKilosAlbaran.SQL.Add( 'where empresa_sc = :empresa ');
  QKilosAlbaran.SQL.Add( 'and centro_salida_sc = :centro ');
  QKilosAlbaran.SQL.Add( 'and cliente_sal_sc = :cliente ');
  QKilosAlbaran.SQL.Add( 'and n_pedido_sc = :pedido ');
  QKilosAlbaran.SQL.Add( 'and fecha_sc >= :fecha ');
  QKilosAlbaran.SQL.Add( 'and empresa_sl = :empresa ');
  QKilosAlbaran.SQL.Add( 'and centro_salida_sl = :centro ');
  QKilosAlbaran.SQL.Add( 'and fecha_sl = fecha_sc ');
  QKilosAlbaran.SQL.Add( 'and n_albaran_sl = n_albaran_sc ');
  QKilosAlbaran.SQL.Add( 'and producto_sl = :producto ');
  QKilosAlbaran.SQL.Add( 'and envase_sl = :envase ');
  QKilosAlbaran.Prepare;

  QCajasAlbaran.SQL.Clear;
  QCajasAlbaran.SQL.Add( 'select sum(cajas_sl) unidades');
  QCajasAlbaran.SQL.Add( 'from frf_salidas_c, frf_salidas_l ');
  QCajasAlbaran.SQL.Add( 'where empresa_sc = :empresa ');
  QCajasAlbaran.SQL.Add( 'and centro_salida_sc = :centro ');
  QCajasAlbaran.SQL.Add( 'and cliente_sal_sc = :cliente ');
  QCajasAlbaran.SQL.Add( 'and n_pedido_sc = :pedido ');
  QCajasAlbaran.SQL.Add( 'and fecha_sc >= :fecha ');
  QCajasAlbaran.SQL.Add( 'and empresa_sl = :empresa ');
  QCajasAlbaran.SQL.Add( 'and centro_salida_sl = :centro ');
  QCajasAlbaran.SQL.Add( 'and fecha_sl = fecha_sc ');
  QCajasAlbaran.SQL.Add( 'and n_albaran_sl = n_albaran_sc ');
  QCajasAlbaran.SQL.Add( 'and producto_sl = :producto ');
  QCajasAlbaran.SQL.Add( 'and envase_sl = :envase ');
  QCajasAlbaran.Prepare;

  QUnidadesAlbaran.SQL.Clear;
  QUnidadesAlbaran.SQL.Add( 'select sum(cajas_sl * unidades_caja_sl ) unidades ');
  QUnidadesAlbaran.SQL.Add( 'from frf_salidas_c, frf_salidas_l ');
  QUnidadesAlbaran.SQL.Add( 'where empresa_sc = :empresa ');
  QUnidadesAlbaran.SQL.Add( 'and centro_salida_sc = :centro ');
  QUnidadesAlbaran.SQL.Add( 'and cliente_sal_sc = :cliente ');
  QUnidadesAlbaran.SQL.Add( 'and n_pedido_sc = :pedido ');
  QUnidadesAlbaran.SQL.Add( 'and fecha_sc >= :fecha ');
  QUnidadesAlbaran.SQL.Add( 'and empresa_sl = :empresa ');
  QUnidadesAlbaran.SQL.Add( 'and centro_salida_sl = :centro ');
  QUnidadesAlbaran.SQL.Add( 'and fecha_sl = fecha_sc ');
  QUnidadesAlbaran.SQL.Add( 'and n_albaran_sl = n_albaran_sc ');
  QUnidadesAlbaran.SQL.Add( 'and producto_sl = :producto ');
  QUnidadesAlbaran.SQL.Add( 'and envase_sl = :envase ');
  QUnidadesAlbaran.Prepare;
end;

procedure TDLPedidosEnvase.PreparaDatosAlbaran( const AEmpresa, ACentro, ACliente, ASuministro, AProducto, APedido: String;
                                                const AFecha: TDateTime  );
begin
  QProductoAlbaran.SQL.Clear;
  QProductoAlbaran.SQL.Add( 'select fecha_sl, producto_sl, envase_sl, unidad_precio_sl, ');
  QProductoAlbaran.SQL.Add( '       sum(cajas_sl) cajas, ');
  QProductoAlbaran.SQL.Add( '       sum( cajas_sl * unidades_caja_sl ) unidades, ');
  QProductoAlbaran.SQL.Add( '       sum(kilos_sl) kilos ');
  QProductoAlbaran.SQL.Add( 'from frf_salidas_c, frf_salidas_l ');
  QProductoAlbaran.SQL.Add( 'where n_pedido_sc = :pedido ');
  QProductoAlbaran.SQL.Add( 'and empresa_sc = :empresa ');
  QProductoAlbaran.SQL.Add( 'and fecha_sc >= :fecha ');
  QProductoAlbaran.SQL.Add( 'and empresa_sl = :empresa ');
  QProductoAlbaran.SQL.Add( 'and centro_salida_sc = :centro ');
  QProductoAlbaran.SQL.Add( 'and centro_salida_sl = :centro ');
  QProductoAlbaran.SQL.Add( 'and n_albaran_sl = n_albaran_sc ');
  QProductoAlbaran.SQL.Add( 'and fecha_sl = fecha_sc ');
  QProductoAlbaran.SQL.Add( 'and cliente_sal_sc = :cliente ');
  if ASuministro <> '' then
    QProductoAlbaran.SQL.Add( 'and dir_sum_sc = :dirsum ');
  if AProducto <> '' then
    QProductoAlbaran.SQL.Add( 'and producto_sl = :producto ');
  QProductoAlbaran.SQL.Add( 'group by fecha_sl, producto_sl, envase_sl, unidad_precio_sl ');
  QProductoAlbaran.SQL.Add( 'order by fecha_sl, producto_sl, envase_sl, unidad_precio_sl ');

  QProductoAlbaran.ParamByName('empresa').AsString:= AEmpresa;
  QProductoAlbaran.ParamByName('centro').AsString:= ACentro;
  QProductoAlbaran.ParamByName('cliente').AsString:= ACliente;
  QProductoAlbaran.ParamByName('pedido').AsString:= APedido;
  QProductoAlbaran.ParamByName('fecha').AsDateTime:= AFecha;
  if ASuministro <> '' then
    QProductoAlbaran.ParamByName('dirsum').AsString:= ASuministro;
  if AProducto <> '' then
    QProductoAlbaran.ParamByName('producto').AsString:= AProducto;
end;

function TDLPedidosEnvase.SQLPedidos( const AProducto: string; const bDirSum: boolean ): string;
var
  sAux: TStringList;
begin
  sAux:= TStringList.Create;

  sAux.Add(' select fecha_pdc, ref_pedido_pdc, ');
  sAux.Add('   producto_pdd,  ');
  sAux.Add('   envase_pdd, unidad_pdd, ');
  sAux.Add('        sum(unidades_pdd) unidades_pdd ');

  sAux.Add(' from frf_pedido_cab, frf_pedido_det ');

  sAux.Add(' where empresa_pdc = empresa_pdd ');
  sAux.Add(' and centro_pdc = centro_pdd ');
  sAux.Add(' and pedido_pdc = pedido_pdd ');
  sAux.Add(' and empresa_pdc = :empresa ');

  sAux.Add(' and fecha_pdc between :inicio and :fin ');

  sAux.Add(' and centro_pdc = :centro ');
  sAux.Add(' and cliente_pdc = :cliente ');
  if bDirSum then
    sAux.Add(' and dir_suministro_pdc = :suministro ');

  if ( AProducto <> '' ) then
  begin
    sAux.Add(' and producto_pdd = :producto ');
  end;

  sAux.Add(' group by 1,2,3,4,5 ');
  sAux.Add(' order by fecha_pdc, ref_pedido_pdc, producto_pdd, envase_pdd, unidad_pdd ');

  result:= sAux.Text;
  FreeAndNil( sAux );
end;

function TDLPedidosEnvase.SQLNumPedidos( const AProducto: string; const bDirSum: boolean ): string;
var
  sAux: TStringList;
begin
  sAux:= TStringList.Create;

  sAux.Add(' select count( distinct ref_pedido_pdc ) ');
  sAux.Add(' from frf_pedido_cab, frf_pedido_det ');
  sAux.Add(' where empresa_pdc = empresa_pdd ');
  sAux.Add(' and centro_pdc = centro_pdd ');
  sAux.Add(' and pedido_pdc = pedido_pdd ');
  sAux.Add(' and empresa_pdc = :empresa ');
  sAux.Add(' and fecha_pdc between :inicio and :fin ');
  sAux.Add(' and centro_pdc = :centro ');
  sAux.Add(' and cliente_pdc = :cliente ');
  if bDirSum then
    sAux.Add(' and dir_suministro_pdc = :suministro ');


  if ( AProducto <> '' ) then
  begin
    sAux.Add(' and producto_pdd = :producto ');
  end;

  result:= sAux.Text;
  FreeAndNil( sAux );
end;

function TDLPedidosEnvase.SQLSalidasSinPedido( const AProducto: string; const bDirSum: boolean ): string;
var
  sAux: TStringList;
begin
  sAux:= TStringList.Create;
  sAux.Add(' SELECT producto_sl producto, ');
  sAux.Add('        envase_sl envase, ');
  sAux.Add('        sum(cajas_sl) cajas, ');
  sAux.Add('        sum(cajas_sl * unidades_caja_sl ) unidades, ');

  sAux.Add('        sum(kilos_sl) kilos ');

  sAux.Add(' from frf_salidas_c, frf_salidas_l ');
  sAux.Add(' where empresa_sc = :empresa ');
  sAux.Add(' and centro_salida_sc = :centro ');
  sAux.Add(' and fecha_sc between :fechaini and :fechafin ');
  sAux.Add(' and nvl(trim(n_pedido_sc),'''') = '''' ');
  sAux.Add(' and cliente_sal_sc = :cliente ');
  if bDirSum then
  begin
    sAux.Add(' and dir_sum_sc = :suministro ');
  end;

  sAux.Add(' and empresa_sl = :empresa ');
  sAux.Add(' and centro_salida_sl = :centro ');
  sAux.Add(' and fecha_sl = fecha_sc ');
  sAux.Add(' and n_albaran_sl = n_albaran_sc ');

  if ( AProducto <> '' ) then
  begin
    sAux.Add(' and producto_sl = :producto ');
  end;

  sAux.Add(' group by 1, 2 ');
  sAux.Add(' order by 1, 2 ');

  result:= sAux.Text;
  FreeAndNil( sAux );
end;

procedure TDLPedidosEnvase.DataModuleDestroy(Sender: TObject);
begin
  QKilosAlbaran.UnPrepare;
  QCajasAlbaran.UnPrepare;
  QUnidadesAlbaran.UnPrepare;
end;

end.
