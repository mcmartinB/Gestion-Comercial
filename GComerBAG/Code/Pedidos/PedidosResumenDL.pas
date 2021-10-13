unit PedidosResumenDL;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;

type
  TInfoEvent = procedure ( const ADesRegistro: string; const ARegistro, ARegistros: integer ) of object;

  TDLPedidosResumen = class(TDataModule)
    QAux: TQuery;
    tListado: TkbmMemTable;
    tTemporal: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function SQLPedidos( const AProducto: string; const bDirSum: boolean ): string;
    function SQLNumPedidos( const AProducto: string; const bDirSum: boolean ): string;

    procedure ResumirRegistros;
    procedure AnyadirRegistro( const ATable: TDataSet;
      const AProducto, AEnvase, AUnidad: String; const APedidos, AServidos: Real );

  public
    { Public declarations }
   procedure QueryListado(
     const AEmpresa, ACentro, ACliente, ASuministro, AProducto:string;
     const AFechaIni, AFechaFin: TDateTime; var ASinPedidos: boolean;
     const InformarProgreso: TInfoEvent );
  end;

  procedure CrearModuloDatos( const AParent: TComponent );
  procedure DestruirModuloDatos;

var
  DLPedidosResumen: TDLPedidosResumen = nil;

implementation

{$R *.dfm}

uses
  Variants;

var
  Conexiones: integer = 0;

procedure CrearModuloDatos( const AParent: TComponent );
begin
  if Conexiones = 0 then
  begin
    DLPedidosResumen:= TDLPedidosResumen.Create( AParent );
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
      if DLPedidosResumen <> nil then
        FreeAndNil( DLPedidosResumen );
    end;
  end;
end;

procedure TDLPedidosResumen.AnyadirRegistro( const ATable: TDataSet;
  const AProducto, AEnvase, AUnidad:String; const APedidos, AServidos: Real );
begin
  ATable.Insert;

  ATable.FieldByName('producto').AsString:= AProducto;
  ATable.FieldByName('envase').AsString:= AEnvase;
  ATable.FieldByName('unidades_pedidas').AsFloat:= APedidos;
  ATable.FieldByName('unidad').AsString:= AUnidad;

  try
    ATable.Post;
  finally
    ATable.Cancel;
  end;
end;

procedure TDLPedidosResumen.ResumirRegistros;
var
  sProducto, sEnvase, sUnidad: string;
  rPedidos, rServidos: Real;
begin
  tTemporal.Sort([]);
  tTemporal.First;

  sProducto:= tTemporal.FieldByName('producto').AsString;
  sEnvase:= tTemporal.FieldByName('envase').AsString;
  sUnidad:= tTemporal.FieldByName('unidad').AsString;
  rPedidos:= 0;
  rServidos:= 0;

  while not tTemporal.Eof do
  begin
    if ( sProducto + sEnvase + sUnidad ) <> ( tTemporal.FieldByName('producto').AsString + tTemporal.FieldByName('envase').AsString +
    tTemporal.FieldByName('unidad').AsString ) then
    begin
      AnyadirRegistro( tListado, sProducto, sEnvase, sUnidad, rPedidos, rServidos );

      sProducto:= tTemporal.FieldByName('producto').AsString;
      sEnvase:= tTemporal.FieldByName('envase').AsString;
      sUnidad:= tTemporal.FieldByName('unidad').AsString;
      rPedidos:= tTemporal.FieldByName('unidades_pedidas').AsFloat;
    end
    else
    begin
      rPedidos:= rPedidos + tTemporal.FieldByName('unidades_pedidas').AsFloat;
    end;
    tTemporal.Next;
  end;
  AnyadirRegistro( tListado, sProducto, sEnvase, sUnidad, rPedidos, rServidos );

  tListado.Sort([]);
end;

procedure TDLPedidosResumen.QueryListado(
  const AEmpresa, ACentro, ACliente, ASuministro, AProducto:string;
  const AFechaIni, AFechaFin: TDateTime; var ASinPedidos: boolean ;
  const InformarProgreso: TInfoEvent );
var
  iRegistros, iRegistro: Integer;
  sRegistro: String;
  sSQL: string;
  bDirSum, bProducto: boolean;
  slProductos: TStringList;
begin
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
        sRegistro:= FieldByName('ref_pedido_pdc').AsString;

        if Assigned( InformarProgreso ) then
          InformarProgreso( sRegistro, iRegistro, iRegistros );
      end;

      slProductos.Add(FieldByName('producto_pdd').AsString);

      AnyadirRegistro( tTemporal, FieldByName('producto_pdd').AsString,
          FieldByName('envase_pdd').AsString, FieldByName('unidad_pdd').AsString,
          FieldByName('unidades_pdd').AsFloat, 0 );

      Next;
    end;

    Close;
  end;

  ResumirRegistros;

  if Assigned( InformarProgreso ) then
    InformarProgreso( 'FIN', -1, -1 );

  FreeAndNil( slProductos );
end;

procedure TDLPedidosResumen.DataModuleCreate(Sender: TObject);
begin
  tTemporal.FieldDefs.Clear;
  tTemporal.FieldDefs.Add('producto', ftString, 3, False);
  tTemporal.FieldDefs.Add('envase', ftString, 9,  False);
  tTemporal.FieldDefs.Add('unidades_pedidas', ftFloat, 0, False);
  tTemporal.FieldDefs.Add('unidad', ftString, 1, False);


  tTemporal.CreateTable;
  tTemporal.SortFields := 'producto;envase';
  tTemporal.IndexFieldNames := 'producto;envase';

  tListado.FieldDefs.Clear;
  tListado.FieldDefs.Add('producto', ftString, 3, False);
  tListado.FieldDefs.Add('envase', ftString, 9,  False);
  tListado.FieldDefs.Add('unidades_pedidas', ftFloat, 0, False);
  tListado.FieldDefs.Add('unidad', ftString, 1, False);


  tListado.CreateTable;
  tListado.SortFields := 'producto;envase';
  tListado.IndexFieldNames := 'producto;envase';

end;

function TDLPedidosResumen.SQLPedidos( const AProducto: string; const bDirSum: boolean ): string;
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

function TDLPedidosResumen.SQLNumPedidos( const AProducto: string; const bDirSum: boolean ): string;
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

end.
