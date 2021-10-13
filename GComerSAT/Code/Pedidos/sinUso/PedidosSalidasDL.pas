unit PedidosSalidasDL;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;

type
  TDLPedidosSalidas = class(TDataModule)
    QListado: TQuery;
    tListado: TkbmMemTable;
    QKilosAlbaran: TQuery;
    QCajasAlbaran: TQuery;
    QUnidadesAlbaran: TQuery;
    QKilosAlbaranEx: TQuery;
    QCajasAlbaranEx: TQuery;
    QUnidadesAlbaranEx: TQuery;
    QProductoAlbaran: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    function UnidadesAlbaran(
      const AEmpresa, ACentro, AProducto, ACliente, ASuministro, APedido, AUnidad:string;
      const AFecha: TDateTime ): TQuery;

    procedure PreparaDatosAlbaran(
      const AEmpresa, ACentro, ACliente, ASuministro, AProducto, APedido: String;
      const AFecha: TDateTime );
    procedure AnyadirFrutaNoPedidadPeroServida(
      const AEmpresa, ACentro, ACliente, ASuministro, AProducto, APedido: String;
      const AFecha: TDateTime; const AProductos: TStringList );
    function  SePidio(
      const AProducto: string; const AProductos: TStringList ): boolean;
    procedure AnyadirRegistro(
      const ATable: TDataSet; const AProducto, AAlbaran, AUnidad:String;
      const AFecha: TDateTime; const AServidos: Real );
    procedure UpdateLineas( const ALineas: Integer );
  public
    { Public declarations }
   procedure QueryListado(
     const AEmpresa, ACentro, ACliente, ASuministro, AProducto, APedido:string;
     const AFechaIni, AFechaFin: TDateTime );
  end;

  procedure CrearModuloDatos( const AParent: TComponent );
  procedure DestruirModuloDatos;

var
  DLPedidosSalidas: TDLPedidosSalidas = nil;

implementation

{$R *.dfm}


var
  Conexiones: integer = 0;

procedure CrearModuloDatos( const AParent: TComponent );
begin
  if Conexiones = 0 then
  begin
    DLPedidosSalidas:= TDLPedidosSalidas.Create( AParent );
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
      if DLPedidosSalidas <> nil then
        FreeAndNil( DLPedidosSalidas );
    end;
  end;
end;

// ****************************************************************************
// The following code illustrates an example on creating a TkbmMemTable
// on the fly in runtime code.
//
//
//  // Create the memorytable object, and set a few optionel stuff.
//  kbmMemTable1 := TkbmMemTable.Create(Self); //Owner is Self. It will be auto-destroyed.
//  kbmMemTable1.SortOptions := [];                                           // Optional.
//  kbmMemTable1.PersistentFile := 'testfil.txt';                             // Optional.
//  kbmMemTable1.OnCompressSave := kbmMemTable1CompressSave;                  // Optional.
//  kbmMemTable1.OnDecompressLoad := kbmMemTable1DecompressLoad;              // Optional.
//  kbmMemTable1.OnCompressBlobStream := kbmMemTable1CompressBlobStream;      // Optional.
//  kbmMemTable1.OnDecompressBlobStream := kbmMemTable1DecompressBlobStream;  // Optional.
//  kbmMemTable1.OnCalcFields := MemTable1CalcFields;                         // Optional.
//  kbmMemTable1.OnFilterRecord := kbmMemTable1FilterRecord;                  // Optional.
//  kbmMemTable1.MasterSource := Nil;                                         // Optional.
//
//  //Now, creating the field defs.                                           // Similar required.
//  kbmMemTable1.FieldDefs.Clear; //We dont need this line, but it does not hurt either.
//  kbmMemTable1.FieldDefs.Add('Period', ftInteger, 0, False);
//  kbmMemTable1.FieldDefs.Add('Value', ftInteger, 0, False);
//  kbmMemTable1.FieldDefs.Add('Color', ftInteger, 0, False);
//  kbmMemTable1.FieldDefs.Add('Calc', FtString, 20, False);
//  kbmMemTable1.FieldDefs.Add('Date', ftDate, 0, False);
//
//  // Define index fields.                                                   // Optional.
//  kbmMemTable1.IndexDefs.Add('Index1','Value',[]);
//
//  // Finally create the table according to definitions.                     // Required.
//  kbmMemTable1.CreateTable;
//
//  //Since this is a run-time created one, we have to assign the following here.
//  DataSource1.DataSet := kbmMemTable1;
//
//  // Optionel. IndexFields and SortFields must be assigned AFTER CreateTable
//  kbmMemTable1.IndexFields := 'Value';
//  kbmMemTable1.SortFields := 'Value';
//

function TDLPedidosSalidas.UnidadesAlbaran(
  const AEmpresa, ACentro, AProducto, ACliente, ASuministro, APedido, AUnidad:string;
  const AFecha: TDateTime ): TQuery;
begin
  if AUnidad = 'K' then
  begin
    if AProducto = 'T' then
    begin
      QKilosAlbaranEx.ParamByName('empresa').AsString:= AEmpresa;
      QKilosAlbaranEx.ParamByName('centro').AsString:= ACentro;
      QKilosAlbaranEx.ParamByName('cliente').AsString:= ACliente;
      QKilosAlbaranEx.ParamByName('dir_sum').AsString:= ASuministro;
      QKilosAlbaranEx.ParamByName('pedido').AsString:= APedido;
      QKilosAlbaranEx.ParamByName('fecha').AsDateTime:= AFecha - 7;
      Result:= QKilosAlbaranEx;
    end
    else
    begin
      QKilosAlbaran.ParamByName('empresa').AsString:= AEmpresa;
      QKilosAlbaran.ParamByName('centro').AsString:= ACentro;
      QKilosAlbaran.ParamByName('cliente').AsString:= ACliente;
      QKilosAlbaran.ParamByName('dir_sum').AsString:= ASuministro;
      QKilosAlbaran.ParamByName('pedido').AsString:= APedido;
      QKilosAlbaran.ParamByName('producto').AsString:= AProducto;
      QKilosAlbaran.ParamByName('fecha').AsDateTime:= AFecha - 7;
      Result:= QKilosAlbaran;
    end;
  end
  else
  if AUnidad = 'U' then
  begin
    if AProducto = 'T' then
    begin
      QUnidadesAlbaranEx.ParamByName('empresa').AsString:= AEmpresa;
      QUnidadesAlbaranEx.ParamByName('centro').AsString:= ACentro;
      QUnidadesAlbaranEx.ParamByName('cliente').AsString:= ACliente;
      QUnidadesAlbaranEx.ParamByName('dir_sum').AsString:= ASuministro;
      QUnidadesAlbaranEx.ParamByName('pedido').AsString:= APedido;
      QUnidadesAlbaranEx.ParamByName('fecha').AsDateTime:= AFecha - 7;
      Result:= QUnidadesAlbaranEx;
    end
    else
    begin
      QUnidadesAlbaran.ParamByName('empresa').AsString:= AEmpresa;
      QUnidadesAlbaran.ParamByName('centro').AsString:= ACentro;
      QUnidadesAlbaran.ParamByName('cliente').AsString:= ACliente;
      QUnidadesAlbaran.ParamByName('dir_sum').AsString:= ASuministro;
      QUnidadesAlbaran.ParamByName('pedido').AsString:= APedido;
      QUnidadesAlbaran.ParamByName('producto').AsString:= AProducto;
      QUnidadesAlbaran.ParamByName('fecha').AsDateTime:= AFecha - 7;
      Result:= QUnidadesAlbaran;
    end;
  end
  else
  begin
    if AProducto = 'T' then
    begin
      QCajasAlbaranEx.ParamByName('empresa').AsString:= AEmpresa;
      QCajasAlbaranEx.ParamByName('centro').AsString:= ACentro;
      QCajasAlbaranEx.ParamByName('cliente').AsString:= ACliente;
      QCajasAlbaranEx.ParamByName('dir_sum').AsString:= ASuministro;
      QCajasAlbaranEx.ParamByName('pedido').AsString:= APedido;
      QCajasAlbaranEx.ParamByName('fecha').AsDateTime:= AFecha - 7;
      Result:= QCajasAlbaranEx;
    end
    else
    begin
      QCajasAlbaran.ParamByName('empresa').AsString:= AEmpresa;
      QCajasAlbaran.ParamByName('centro').AsString:= ACentro;
      QCajasAlbaran.ParamByName('cliente').AsString:= ACliente;
      QCajasAlbaran.ParamByName('dir_sum').AsString:= ASuministro;
      QCajasAlbaran.ParamByName('pedido').AsString:= APedido;
      QCajasAlbaran.ParamByName('producto').AsString:= AProducto;
      QCajasAlbaran.ParamByName('fecha').AsDateTime:= AFecha - 7;
      Result:= QCajasAlbaran;
    end;
  end;
end;

procedure TDLPedidosSalidas.QueryListado(
  const AEmpresa, ACentro, ACliente, ASuministro, AProducto, APedido:string;
  const AFechaIni, AFechaFin: TDateTime );
var
  QUnidadesAlmacen: TQuery;
  iLineas: Integer;
  slProductos: TStringList;
  sPedido: string;
begin
  slProductos:= TStringList.Create;
  slProductos.Duplicates:= (dupIgnore);

  with QListado do
  begin


    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        empresa_pdc, centro_pdc, fecha_pdc, ref_pedido_pdc, cliente_pdc, dir_suministro_pdc, ');
    SQL.Add('        case when producto_pdd = ''E'' then ''T'' else producto_pdd  end producto_pdd, ');
    SQL.Add('        unidad_pdd, sum(unidades_pdd) unidades_pdd ');

    SQL.Add(' from frf_pedido_cab cab, frf_pedido_det det ');

    SQL.Add(' where empresa_pdc = empresa_pdd ');
    SQL.Add(' and centro_pdc = centro_pdd ');
    SQL.Add(' and pedido_pdc = pedido_pdd ');
    SQL.Add(' and empresa_pdc = :empresa ');

    SQL.Add(' and fecha_pdc between :inicio and :fin ');

    if APedido <> '' then
      SQL.Add(' and ref_pedido_pdc = :pedido ');
    if ACentro <> '' then
      SQL.Add(' and centro_pdc = :centro ');
    if ACliente <> '' then
    begin
      SQL.Add(' and cliente_pdc = :cliente ');
      if ASuministro <> '' then
        SQL.Add(' and dir_suministro_pdc = :suministro ');
    end;
    if AProducto <> '' then
    begin
      if ( AProducto = 'T' ) or ( AProducto = 'E' ) then
        SQL.Add(' and ( producto_pdd = ''T'' or producto_pdd = ''E'' ) ')
      else
        SQL.Add(' and producto_pdd = :producto ');
    end;

    SQL.Add(' group by 1, 2, 3, 4, 5, 6, 7, 8 ');

    SQL.Add(' order by empresa_pdc, centro_pdc, fecha_pdc, ref_pedido_pdc, ');
    SQL.Add('        cliente_pdc, dir_suministro_pdc, producto_pdd, unidad_pdd ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('inicio').AsDateTime:= AFechaIni;
    ParamByName('fin').AsDateTime:= AFechaFin;

    if APedido <> '' then
      ParamByName('pedido').AsString:= APedido;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if ACliente <> '' then
    begin
      ParamByName('cliente').AsString:= ACliente;
      if ASuministro <> '' then
        ParamByName('suministro').AsString:= ASuministro;
    end;
    if AProducto <> '' then
    begin
      if ( AProducto <> 'T' ) or ( AProducto <> 'T' ) then
        ParamByName('producto').AsString:= AProducto;
    end;

    Open;
    tListado.Open;
    sPedido:= '';
    while not EOF do
    begin
      if FieldByName('ref_pedido_pdc').AsString <> sPedido then
      begin
        if sPedido <> '' then
        begin
          AnyadirFrutaNoPedidadPeroServida( AEmpresa, ACentro, ACliente, ASuministro, AProducto, sPedido,
                                            FieldByName('fecha_pdc').AsDateTime, slProductos );
          slProductos.Clear;
        end;
        sPedido:= FieldByName('ref_pedido_pdc').AsString;
      end;

      slProductos.Add(FieldByName('producto_pdd').AsString);


      QUnidadesAlmacen:= UnidadesAlbaran( FieldByName('empresa_pdc').AsString,
        FieldByName('centro_pdc').AsString, FieldByName('producto_pdd').AsString,
        ACliente,FieldByName('dir_suministro_pdc').AsString,
        FieldByName('ref_pedido_pdc').AsString, FieldByName('unidad_pdd').AsString,
        FieldByName('fecha_pdc').AsDateTime );

      QUnidadesAlmacen.Open;

      iLineas:= 0;
      QUnidadesAlmacen.First;
      while Not QUnidadesAlmacen.Eof do
      begin
        Inc( iLineas );
        QUnidadesAlmacen.Next;
      end;
      QUnidadesAlmacen.First;


      if QUnidadesAlmacen.IsEmpty then
      begin
        tListado.Insert;
        tListado.FieldByName('empresa').AsString:= FieldByName('empresa_pdc').AsString;
        tListado.FieldByName('centro').AsString:= FieldByName('centro_pdc').AsString;
        tListado.FieldByName('fecha').AsDateTime:= FieldByName('fecha_pdc').AsDateTime;
        tListado.FieldByName('pedido').AsString:= FieldByName('ref_pedido_pdc').AsString;
        tListado.FieldByName('cliente').AsString:= FieldByName('cliente_pdc').AsString;
        tListado.FieldByName('suministro').AsString:= FieldByName('dir_suministro_pdc').AsString;
        tListado.FieldByName('producto').AsString:= FieldByName('producto_pdd').AsString;
        tListado.FieldByName('unidad').AsString:= FieldByName('unidad_pdd').AsString;
        tListado.FieldByName('unidades').AsFloat:= FieldByName('unidades_pdd').AsFloat;

        tListado.FieldByName('diff').AsFloat:= - FieldByName('unidades_pdd').AsFloat;
        tListado.FieldByName('lineas').AsFloat:= 0;
        //tListado.FieldByName('albaran').AsString:= 'CANCELADO';
        //tListado.FieldByName('fecha_alb').AsDateTime:= QDatosAlbaran.FieldByName('fecha_sl').AsDateTime;
        //tListado.FieldByName('kilos_alb').AsFloat:= 0;

        try
          tListado.Post;
        finally
          tListado.Cancel;
        end;
      end
      else
      begin
        While not QUnidadesAlmacen.Eof do
        begin
          tListado.Insert;
          tListado.FieldByName('empresa').AsString:= FieldByName('empresa_pdc').AsString;
          tListado.FieldByName('centro').AsString:= FieldByName('centro_pdc').AsString;
          tListado.FieldByName('fecha').AsDateTime:= FieldByName('fecha_pdc').AsDateTime;
          tListado.FieldByName('pedido').AsString:= FieldByName('ref_pedido_pdc').AsString;
          tListado.FieldByName('cliente').AsString:= FieldByName('cliente_pdc').AsString;
          tListado.FieldByName('suministro').AsString:= FieldByName('dir_suministro_pdc').AsString;
          tListado.FieldByName('producto').AsString:= FieldByName('producto_pdd').AsString;
          tListado.FieldByName('unidad').AsString:= FieldByName('unidad_pdd').AsString;
          tListado.FieldByName('unidades').AsFloat:= FieldByName('unidades_pdd').AsFloat;

          tListado.FieldByName('albaran').AsString:= QUnidadesAlmacen.FieldByName('albaran').AsString;
          tListado.FieldByName('fecha_alb').AsDateTime:= QUnidadesAlmacen.FieldByName('fecha').AsDateTime;
          tListado.FieldByName('unidades_alb').AsFloat:= QUnidadesAlmacen.FieldByName('unidades').AsFloat;
          tListado.FieldByName('diff').AsFloat:= QUnidadesAlmacen.FieldByName('unidades').AsFloat -
            FieldByName('unidades_pdd').AsFloat;
          tListado.FieldByName('lineas').AsFloat:= iLineas;

          try
            tListado.Post;
          finally
            tListado.Cancel;
          end;

          QUnidadesAlmacen.Next;
        end;
      end;

      QUnidadesAlmacen.Close;
      Next;
    end;

    if not IsEmpty then
    begin
      AnyadirFrutaNoPedidadPeroServida( AEmpresa, ACentro, ACliente, ASuministro, AProducto, sPedido,
                                        FieldByName('fecha_pdc').AsDateTime, slProductos );
      slProductos.Clear;
    end;
    Close;
  end;
  tListado.Sort([]);
  FreeAndNil( slProductos );
end;

procedure TDLPedidosSalidas.AnyadirFrutaNoPedidadPeroServida(
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
      if FieldByName('producto_sl').AsString = 'E' then
        sProducto:= 'T'
      else
        sProducto:= FieldByName('producto_sl').AsString;
      if not SePidio( sProducto, AProductos ) then
      begin
        if FieldByName('unidad_precio_sl').AsString = 'CAJ' then
          AnyadirRegistro( tListado, sProducto, FieldByName('n_albaran_sl').AsString,
            'C', FieldByName('fecha_sl').AsDateTime, FieldByName('cajas').AsFloat )
        else
        if FieldByName('unidad_precio_sl').AsString = 'UND' then
          AnyadirRegistro( tListado, sProducto, FieldByName('n_albaran_sl').AsString,
            'U', FieldByName('fecha_sl').AsDateTime, FieldByName('unidades').AsFloat )
        else
          AnyadirRegistro( tListado, sProducto, FieldByName('n_albaran_sl').AsString,
            'K', FieldByName('fecha_sl').AsDateTime, FieldByName('kilos').AsFloat );
      end;
      Next;
    end;
    Close;
  end;
end;

procedure TDLPedidosSalidas.UpdateLineas( const ALineas: Integer );
begin
  tListado.Filter:= ' empresa = ' + QUotedSTR( QListado.FieldByName('empresa_pdc').AsString)  + ' and ' +
                    'centro = ' + QUotedSTR( QListado.FieldByName('centro_pdc').AsString)  + ' and ' +
                    'fecha = ' + QUotedSTR( QListado.FieldByName('fecha_pdc').AsString)  + ' and ' +
                    'pedido = ' + QUotedSTR( QListado.FieldByName('ref_pedido_pdc').AsString)  + ' and  ' +
                    'cliente = ' + QUotedSTR( QListado.FieldByName('cliente_pdc').AsString)  + ' and  ' +
                    'suministro = ' + QUotedSTR( QListado.FieldByName('dir_suministro_pdc').AsString);
  tListado.Filtered:= True;
  tListado.First;
  while not tListado.Eof do
  begin
    tListado.Edit;
    tListado.FieldByName('lineas').AsFloat:= ALineas;
    tListado.Post;
    tListado.Next;
  end;
  tListado.Filtered:= False;
end;

function TDLPedidosSalidas.SePidio( const AProducto: string; const AProductos: TStringList ): boolean;
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

procedure TDLPedidosSalidas.AnyadirRegistro( const ATable: TDataSet;
  const AProducto, AAlbaran, AUnidad:String;
  const AFecha: TDateTime; const AServidos: Real );
begin
  ATable.Insert;

  ATable.FieldByName('empresa').AsString:= QListado.FieldByName('empresa_pdc').AsString;
  ATable.FieldByName('centro').AsString:= QListado.FieldByName('centro_pdc').AsString;
  ATable.FieldByName('fecha').AsDateTime:= QListado.FieldByName('fecha_pdc').AsDateTime;
  ATable.FieldByName('pedido').AsString:= QListado.FieldByName('ref_pedido_pdc').AsString;
  ATable.FieldByName('cliente').AsString:= QListado.FieldByName('cliente_pdc').AsString;
  ATable.FieldByName('suministro').AsString:= QListado.FieldByName('dir_suministro_pdc').AsString;
  ATable.FieldByName('producto').AsString:= AProducto;
  ATable.FieldByName('unidad').AsString:= AUnidad;
  ATable.FieldByName('unidades').AsFloat:= 0;

  ATable.FieldByName('albaran').AsString:= AAlbaran;
  ATable.FieldByName('fecha_alb').AsDateTime:= AFecha;
  ATable.FieldByName('unidades_alb').AsFloat:= AServidos;
  ATable.FieldByName('diff').AsFloat:= AServidos;
  ATable.FieldByName('lineas').AsFloat:= 1;

  try
    ATable.Post;
  finally
    ATable.Cancel;
  end;
end;

procedure TDLPedidosSalidas.DataModuleCreate(Sender: TObject);
begin
  tListado.FieldDefs.Clear;
  tListado.FieldDefs.Add('empresa', ftString, 3, False);
  tListado.FieldDefs.Add('centro', ftString, 1, False);
  tListado.FieldDefs.Add('fecha', ftDate, 0, False);
  tListado.FieldDefs.Add('pedido', ftString, 20, False);
  tListado.FieldDefs.Add('cliente', ftString, 3, False);
  tListado.FieldDefs.Add('suministro', ftString, 3, False);
  tListado.FieldDefs.Add('producto', ftString, 3, False);
  tListado.FieldDefs.Add('unidades', ftFloat, 0, False);
  tListado.FieldDefs.Add('unidad', ftString, 1, False);

  tListado.FieldDefs.Add('albaran', ftString, 8, False);
  tListado.FieldDefs.Add('fecha_alb', ftDate, 0, False);
  tListado.FieldDefs.Add('unidades_alb', ftFloat, 0, False);

  tListado.FieldDefs.Add('diff', ftFloat, 0, False);
  tListado.FieldDefs.Add('lineas', ftInteger, 0, False);

  tListado.CreateTable;
  tListado.SortFields := 'empresa;centro;unidad;cliente;suministro;fecha;pedido;producto';
  tListado.IndexFieldNames := 'empresa;centro;unidad;cliente;suministro;fecha;pedido;producto';

  QKilosAlbaran.SQL.Clear;
  QKilosAlbaran.SQL.Add( 'select fecha_sc fecha, n_albaran_sc albaran, sum(kilos_sl) unidades');
  QKilosAlbaran.SQL.Add( 'from frf_salidas_c, frf_salidas_l ');
  QKilosAlbaran.SQL.Add( 'where empresa_sc = :empresa ');
  QKilosAlbaran.SQL.Add( 'and centro_salida_sc = :centro ');
  QKilosAlbaran.SQL.Add( 'and cliente_sal_sc = :cliente ');
  QKilosAlbaran.SQL.Add( 'and dir_sum_sc = :dir_sum ');
  QKilosAlbaran.SQL.Add( 'and n_pedido_sc = :pedido ');
  QKilosAlbaran.SQL.Add( 'and fecha_sc >= :fecha ');
  QKilosAlbaran.SQL.Add( 'and empresa_sl = :empresa ');
  QKilosAlbaran.SQL.Add( 'and centro_salida_sl = :centro ');
  QKilosAlbaran.SQL.Add( 'and fecha_sl = fecha_sc ');
  QKilosAlbaran.SQL.Add( 'and n_albaran_sl = n_albaran_sc ');
  QKilosAlbaran.SQL.Add( 'and producto_sl = :producto ');
  QKilosAlbaran.SQL.Add( 'group by 1,2');
  QKilosAlbaran.SQL.Add( 'order by 1 desc,2');
  QKilosAlbaran.Prepare;

  QCajasAlbaran.SQL.Clear;
  QCajasAlbaran.SQL.Add( 'select fecha_sc fecha, n_albaran_sc albaran, sum(cajas_sl) unidades');
  QCajasAlbaran.SQL.Add( 'from frf_salidas_c, frf_salidas_l ');
  QCajasAlbaran.SQL.Add( 'where empresa_sc = :empresa ');
  QCajasAlbaran.SQL.Add( 'and centro_salida_sc = :centro ');
  QCajasAlbaran.SQL.Add( 'and cliente_sal_sc = :cliente ');
  QCajasAlbaran.SQL.Add( 'and dir_sum_sc = :dir_sum ');
  QCajasAlbaran.SQL.Add( 'and n_pedido_sc = :pedido ');
  QCajasAlbaran.SQL.Add( 'and fecha_sc >= :fecha ');
  QCajasAlbaran.SQL.Add( 'and empresa_sl = :empresa ');
  QCajasAlbaran.SQL.Add( 'and centro_salida_sl = :centro ');
  QCajasAlbaran.SQL.Add( 'and fecha_sl = fecha_sc ');
  QCajasAlbaran.SQL.Add( 'and n_albaran_sl = n_albaran_sc ');
  QCajasAlbaran.SQL.Add( 'and producto_sl = :producto ');
  QCajasAlbaran.SQL.Add( 'group by 1,2');
  QCajasAlbaran.SQL.Add( 'order by 1 desc,2');
  QCajasAlbaran.Prepare;

  QUnidadesAlbaran.SQL.Clear;
  QUnidadesAlbaran.SQL.Add( 'select fecha_sc fecha, n_albaran_sc albaran, ');
  QUnidadesAlbaran.SQL.Add( '       sum(cajas_sl * unidades_caja_sl ) unidades ');
  QUnidadesAlbaran.SQL.Add( 'from frf_salidas_c, frf_salidas_l ');
  QUnidadesAlbaran.SQL.Add( 'where empresa_sc = :empresa ');
  QUnidadesAlbaran.SQL.Add( 'and centro_salida_sc = :centro ');
  QUnidadesAlbaran.SQL.Add( 'and cliente_sal_sc = :cliente ');
  QUnidadesAlbaran.SQL.Add( 'and dir_sum_sc = :dir_sum ');
  QUnidadesAlbaran.SQL.Add( 'and n_pedido_sc = :pedido ');
  QUnidadesAlbaran.SQL.Add( 'and fecha_sc >= :fecha ');
  QUnidadesAlbaran.SQL.Add( 'and empresa_sl = :empresa ');
  QUnidadesAlbaran.SQL.Add( 'and centro_salida_sl = :centro ');
  QUnidadesAlbaran.SQL.Add( 'and fecha_sl = fecha_sc ');
  QUnidadesAlbaran.SQL.Add( 'and n_albaran_sl = n_albaran_sc ');
  QUnidadesAlbaran.SQL.Add( 'and producto_sl = :producto ');
  QUnidadesAlbaran.SQL.Add( 'group by 1,2');
  QUnidadesAlbaran.SQL.Add( 'order by 1 desc,2');
  QUnidadesAlbaran.Prepare;

  QKilosAlbaranEx.SQL.Clear;
  QKilosAlbaranEx.SQL.Add( 'select fecha_sc fecha, n_albaran_sc albaran, sum(kilos_sl) unidades');
  QKilosAlbaranEx.SQL.Add( 'from frf_salidas_c, frf_salidas_l ');
  QKilosAlbaranEx.SQL.Add( 'where empresa_sc = :empresa ');
  QKilosAlbaranEx.SQL.Add( 'and centro_salida_sc = :centro ');
  QKilosAlbaranEx.SQL.Add( 'and cliente_sal_sc = :cliente ');
  QKilosAlbaranEx.SQL.Add( 'and dir_sum_sc = :dir_sum ');
  QKilosAlbaranEx.SQL.Add( 'and n_pedido_sc = :pedido ');
  QKilosAlbaranEx.SQL.Add( 'and fecha_sc >= :fecha ');
  QKilosAlbaranEx.SQL.Add( 'and empresa_sl = :empresa ');
  QKilosAlbaranEx.SQL.Add( 'and centro_salida_sl = :centro ');
  QKilosAlbaranEx.SQL.Add( 'and fecha_sl = fecha_sc ');
  QKilosAlbaranEx.SQL.Add( 'and n_albaran_sl = n_albaran_sc ');
  QKilosAlbaranEx.SQL.Add( 'and ( producto_sl = ''T'' or producto_sl = ''E'' ) ');
  QKilosAlbaranEx.SQL.Add( 'group by 1,2');
  QKilosAlbaranEx.SQL.Add( 'order by 1 desc,2');
  QKilosAlbaranEx.Prepare;

  QCajasAlbaranEx.SQL.Clear;
  QCajasAlbaranEx.SQL.Add( 'select fecha_sc fecha, n_albaran_sc albaran, sum(cajas_sl) unidades');
  QCajasAlbaranEx.SQL.Add( 'from frf_salidas_c, frf_salidas_l ');
  QCajasAlbaranEx.SQL.Add( 'where empresa_sc = :empresa ');
  QCajasAlbaranEx.SQL.Add( 'and centro_salida_sc = :centro ');
  QCajasAlbaranEx.SQL.Add( 'and cliente_sal_sc = :cliente ');
  QCajasAlbaranEx.SQL.Add( 'and dir_sum_sc = :dir_sum ');
  QCajasAlbaranEx.SQL.Add( 'and n_pedido_sc = :pedido ');
  QCajasAlbaranEx.SQL.Add( 'and fecha_sc >= :fecha ');
  QCajasAlbaranEx.SQL.Add( 'and empresa_sl = :empresa ');
  QCajasAlbaranEx.SQL.Add( 'and centro_salida_sl = :centro ');
  QCajasAlbaranEx.SQL.Add( 'and fecha_sl = fecha_sc ');
  QCajasAlbaranEx.SQL.Add( 'and n_albaran_sl = n_albaran_sc ');
  QCajasAlbaranEx.SQL.Add( 'and ( producto_sl = ''T'' or producto_sl = ''E'' ) ');
  QCajasAlbaranEx.SQL.Add( 'group by 1,2');
  QCajasAlbaranEx.SQL.Add( 'order by 1 desc,2');
  QCajasAlbaranEx.Prepare;

  QUnidadesAlbaranEx.SQL.Clear;
  QUnidadesAlbaranEx.SQL.Add( 'select fecha_sc fecha, n_albaran_sc albaran, ');
  QUnidadesAlbaranEx.SQL.Add( '       sum(cajas_sl * unidades_caja_sl ) unidades ');
  QUnidadesAlbaranEx.SQL.Add( 'from frf_salidas_c, frf_salidas_l ');
  QUnidadesAlbaranEx.SQL.Add( 'where empresa_sc = :empresa ');
  QUnidadesAlbaranEx.SQL.Add( 'and centro_salida_sc = :centro ');
  QUnidadesAlbaranEx.SQL.Add( 'and cliente_sal_sc = :cliente ');
  QUnidadesAlbaranEx.SQL.Add( 'and dir_sum_sc = :dir_sum ');
  QUnidadesAlbaranEx.SQL.Add( 'and n_pedido_sc = :pedido ');
  QUnidadesAlbaranEx.SQL.Add( 'and fecha_sc >= :fecha ');
  QUnidadesAlbaranEx.SQL.Add( 'and empresa_sl = :empresa ');
  QUnidadesAlbaranEx.SQL.Add( 'and centro_salida_sl = :centro ');
  QUnidadesAlbaranEx.SQL.Add( 'and fecha_sl = fecha_sc ');
  QUnidadesAlbaranEx.SQL.Add( 'and n_albaran_sl = n_albaran_sc ');
  QUnidadesAlbaranEx.SQL.Add( 'and ( producto_sl = ''T'' or producto_sl = ''E'' ) ');
  QUnidadesAlbaranEx.SQL.Add( 'group by 1,2');
  QUnidadesAlbaranEx.SQL.Add( 'order by 1 desc,2');
  QUnidadesAlbaranEx.Prepare;

end;

procedure TDLPedidosSalidas.PreparaDatosAlbaran( const AEmpresa, ACentro, ACliente, ASuministro, AProducto, APedido: String;
                                                 const AFecha: TDateTime );
begin
  QProductoAlbaran.SQL.Clear;
  QProductoAlbaran.SQL.Add( 'select n_albaran_sl, fecha_sl, producto_sl, unidad_precio_sl, ');
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
  QProductoAlbaran.SQL.Add( 'group by n_albaran_sl, fecha_sl, producto_sl, unidad_precio_sl ');
  QProductoAlbaran.SQL.Add( 'order by n_albaran_sl, fecha_sl, producto_sl, unidad_precio_sl ');

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

procedure TDLPedidosSalidas.DataModuleDestroy(Sender: TObject);
begin
  QKilosAlbaran.UnPrepare;
  QCajasAlbaran.UnPrepare;
  QUnidadesAlbaran.UnPrepare;
end;

end.
