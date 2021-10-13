unit MargenBConfeccionDL;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables, MargenBCodeComunDL;

type
  TTipoConfeccionado = (tcAlta, tcCarga, tcAnterior, tcSiguiente, tcStock, tcAll );

var
  TipoConfeccionado: TTipoConfeccionado = tcCarga;

type
  TDLMargenBConfeccion = class(TDataModule)
    qryPaletsConfeccionados: TQuery;
    qryEnvase: TQuery;
    kmtEnvases: TkbmMemTable;
    qryEanProducto: TQuery;
    dsConfeccionados: TDataSource;
    qryProducto: TQuery;
    kmtPaletsConfeccionados: TkbmMemTable;
    kmtLineas: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sgEmpresa, sgCliente, sgProducto: string;
    dgFechaIni, dgFechaFin: TDateTime;
    CostesAplicar: RCostesAplicar;

    procedure QuerysConfeccionados( const AProducto, ACliente: string; const ATipo: TTipoConfeccionado );

    procedure CerrarQuerys;
    procedure MakeMasterDetailConfeccionados;
    procedure VisualizarPaletsConfeccionados( const AEmpresa, AProducto, ACliente: string ;
                                const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar;
                                const ATipo: TTipoConfeccionado );
    procedure DatosLinea(  const ATipo: TTipoConfeccionado );
    procedure OrdenarDatos( const ATipo: TTipoConfeccionado );

    procedure AddPaletConfeccionados( const AProducto: string; const AUnidades: Integer );
    procedure AddLineaConfeccionados;
    function  DatosEnvaseConfeccionados( const AEmpresa, AEan13, AEnvase, ACalibre: string;
                                         var VProducto: string; Var VUnidades: integer ): boolean;
    function  GetProducto( const AEmpresa, AEan13: string; const AProductoBase: integer; var VProducto: string ): boolean;

  public
    { Public declarations }

    procedure PaletsConfeccionados( const AEmpresa, AProducto, ACliente: string ;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ACostesAplicar: RCostesAplicar;
                              const ATipo: TTipoConfeccionado );
  end;

  procedure ViewPaletsConfeccionados( const AEmpresa, AProducto, ACliente: string ;
                                const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar;
                                const ATipo: TTipoConfeccionado );

  procedure IniciarPaletsConfeccion;
  procedure ProcesoConfeccion( const AEmpresa, AProducto, ACliente: string ;
                                const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar;
                                const ATipo: TTipoConfeccionado );
  procedure CerrarPaletsConfeccion;

var
  DLMargenBConfeccion: TDLMargenBConfeccion;

implementation

{$R *.dfm}

uses
  MargenBConfeccionadoQL,
  Forms, Variants, bMath, Dialogs, UDMConfig;

var
  bModuloIni: boolean = false;

procedure ViewPaletsConfeccionados( const AEmpresa, AProducto, ACliente: string ;
                              const AFechaIni, AFechaFin: TDateTime;
                              const ACostesAplicar: RCostesAplicar;
                              const ATipo: TTipoConfeccionado );
begin
  Application.CreateForm( TDLMargenBConfeccion, DLMargenBConfeccion );
  try
    DLMargenBConfeccion.PaletsConfeccionados( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, ATipo );
    DLMargenBConfeccion.VisualizarPaletsConfeccionados( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, ATipo );
    DLMargenBConfeccion.CerrarQuerys;
  finally
    FreeAndNil( DLMargenBConfeccion );
  end;
end;

procedure IniciarPaletsConfeccion;
begin
  if not bModuloIni then
  begin
    Application.CreateForm( TDLMargenBConfeccion, DLMargenBConfeccion );
    bModuloIni:= True;
  end;
end;


procedure ProcesoConfeccion( const AEmpresa, AProducto, ACliente: string ;
                                const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar;
                                const ATipo: TTipoConfeccionado );
begin
  DLMargenBConfeccion.qryEnvase.Close;
  DLMargenBConfeccion.qryProducto.Close;
  DLMargenBConfeccion.qryEanProducto.Close;
  DLMargenBConfeccion.qryPaletsConfeccionados.Close;

  DLMargenBConfeccion.kmtLineas.Close;
  DLMargenBConfeccion.kmtPaletsConfeccionados.Close;
  DLMargenBConfeccion.kmtEnvases.Close;
  DLMargenBConfeccion.kmtLineas.Open;
  DLMargenBConfeccion.kmtPaletsConfeccionados.Open;
  DLMargenBConfeccion.kmtEnvases.Open;
  DLMargenBConfeccion.PaletsConfeccionados( AEmpresa, AProducto, ACliente, AFechaIni, AFechaFin, ACostesAplicar, ATipo );
end;

procedure CerrarPaletsConfeccion;
begin
  bModuloIni:= False;
  DLMargenBConfeccion.CerrarQuerys;
  FreeAndNil( DLMargenBConfeccion );
end;


procedure TDLMargenBConfeccion.DataModuleCreate(Sender: TObject);
begin
  //es la font
  if UDMConfig.DMConfig.iInstalacion = 10 then
  begin
    qryPaletsConfeccionados.DatabaseName:= 'DBRF';
  end
  else
  begin
    qryPaletsConfeccionados.DatabaseName:= 'BDProyecto';
  end;
  kmtLineas.FieldDefs.Clear;
  kmtLineas.FieldDefs.Add('empresa', ftString, 3, False);
  kmtLineas.FieldDefs.Add('periodo', ftString, 15, False);
  kmtLineas.FieldDefs.Add('producto', ftString, 3, False);
  kmtLineas.FieldDefs.Add('cliente', ftString, 3, False);
  kmtLineas.FieldDefs.Add('cajas', ftInteger, 0, False);
  kmtLineas.FieldDefs.Add('unidades', ftInteger, 0, False);
  kmtLineas.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtLineas.CreateTable;
  kmtLineas.Open;

  kmtPaletsConfeccionados.FieldDefs.Clear;
  kmtPaletsConfeccionados.FieldDefs.Add('periodo', ftString, 15, False);
  kmtPaletsConfeccionados.FieldDefs.Add('producto', ftString, 3, False);

  kmtPaletsConfeccionados.FieldDefs.Add('empresa', ftString, 3, False);
  kmtPaletsConfeccionados.FieldDefs.Add('centro', ftString, 3, False);
  kmtPaletsConfeccionados.FieldDefs.Add('fecha_carga', ftDate, 0, False);
  kmtPaletsConfeccionados.FieldDefs.Add('albaran', ftInteger, 0, False);
  kmtPaletsConfeccionados.FieldDefs.Add('orden_carga', ftInteger, 0, False);
  kmtPaletsConfeccionados.FieldDefs.Add('cliente', ftString, 3, False);

  kmtPaletsConfeccionados.FieldDefs.Add('fecha_alta', ftDate, 0, False);
  kmtPaletsConfeccionados.FieldDefs.Add('ean128', ftString, 20, False);
  kmtPaletsConfeccionados.FieldDefs.Add('ean13', ftString, 6, False);
  kmtPaletsConfeccionados.FieldDefs.Add('envase', ftString, 9,  False);
  kmtPaletsConfeccionados.FieldDefs.Add('calibre', ftString, 6, False);

  kmtPaletsConfeccionados.FieldDefs.Add('cajas', ftInteger, 0, False);
  kmtPaletsConfeccionados.FieldDefs.Add('unidades', ftInteger, 0, False);
  kmtPaletsConfeccionados.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtPaletsConfeccionados.FieldDefs.Add('status', ftString, 1, False);
  kmtPaletsConfeccionados.CreateTable;
  kmtPaletsConfeccionados.Open;


  with qryEnvase do
  begin
    Sql.Clear;
    Sql.Add(' select producto_e, peso_neto_e, peso_variable_e, unidades_e, unidades_variable_e ');
    Sql.Add(' from frf_envases ');
    Sql.Add(' where envase_e = :envase ');
  end;

  with qryEanProducto do
  begin
    Sql.Clear;
    Sql.Add(' select productop_e ');
    Sql.Add(' from frf_ean13 ');
    Sql.Add(' where e13.empresa_e = :empresa ');
    Sql.Add(' and e13.codigo_e = :ean ');
  end;

  with qryProducto do
  begin
    Sql.Clear;
    Sql.Add(' select producto_pb ');
    Sql.Add(' from frf_productos_base ');
    Sql.Add(' where empresa_pb = :empresa ');
    Sql.Add(' and producto_base_pb = :producto ');
  end;

  kmtEnvases.FieldDefs.Clear;
  kmtEnvases.FieldDefs.Add('empresa', ftString, 3, False);
  kmtEnvases.FieldDefs.Add('ean13', ftString, 13, False);
  kmtEnvases.FieldDefs.Add('envase', ftString, 9,  False);
  kmtEnvases.FieldDefs.Add('producto', ftString, 3, False);
  kmtEnvases.FieldDefs.Add('unidades', ftInteger, 0, False);
  kmtEnvases.FieldDefs.Add('peso', ftFloat, 0, False);
  kmtEnvases.CreateTable;
  kmtEnvases.Open;  
end;


procedure TDLMargenBConfeccion.MakeMasterDetailConfeccionados;
begin
  dsConfeccionados.DataSet.First;
  kmtPaletsConfeccionados.First;
  kmtPaletsConfeccionados.MasterSource:= dsConfeccionados;
  kmtPaletsConfeccionados.MasterFields:= 'periodo;producto';
  kmtPaletsConfeccionados.IndexFieldNames:= 'periodo;producto';
end;

procedure TDLMargenBConfeccion.VisualizarPaletsConfeccionados( const AEmpresa, AProducto, ACliente: string ;
                                const AFechaIni, AFechaFin: TDateTime;
                                const ACostesAplicar: RCostesAplicar;
                                const ATipo: TTipoConfeccionado );
begin
  MakeMasterDetailConfeccionados;
  MargenBConfeccionadoQL.VerMargenBConfeccionado( AEmpresa, AProducto, AFechaIni, AFechaFin, TDataSet( DLMargenBConfeccion.kmtLineas ) );
end;

procedure TDLMargenBConfeccion.QuerysConfeccionados( const AProducto, ACliente: string; const ATipo: TTipoConfeccionado );
begin
  with qryPaletsConfeccionados do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_cab empresa, centro_cab centro, cliente_cab cliente,  status_cab status,');
    SQL.Add('        date(fecha_alta_cab) fecha_alta, date(fecha_carga_cab) fecha_carga, ');
    SQL.Add('        orden_carga_cab orden_carga, ean128_cab ean128, ean13_det ean13, ');
    SQL.Add('        envase_det envase, calibre_det calibre, unidades_det cajas, peso_det peso');

    SQL.Add(' from rf_palet_pc_cab ');
    SQL.Add('      join rf_palet_pc_det on ean128_cab = ean128_det ');
    SQL.Add(' where empresa_cab = :empresa ');

    if ATipo = tcStock then
    begin
      //adelantado para la semana siguiente
      SQL.Add('      and ( ( status_cab = ''S'' and date(fecha_alta_cab) <= :fecha ) or ');
      SQL.Add('          ( status_cab = ''C'' and date(fecha_alta_cab) <= :fecha and  date(fecha_carga_cab) > :fecha ) ) ');
    end
    else
    begin
      SQL.Add('   and status_cab = ''C'' ');
      if ATipo = tcAlta then
      begin
        //Confeccionado - Cargado en el periodo
        SQL.Add('   and date(fecha_alta_cab)  between :fechaini and :fechafin ')
      end
      else
      if ATipo = tcCarga then
      begin
        SQL.Add('   and date(fecha_carga_cab)  between :fechaini and :fechafin ');
      end
      else
      if ATipo = tcAnterior then
      begin
        //adelantado de la semana anterior
        SQL.Add('   and date(fecha_alta_cab)  < :fechaini ');
        SQL.Add('   and date(fecha_carga_cab)  between :fechaini and :fechafin ');
       end
      else
      if ATipo = tcSiguiente then
      begin
        //adelantado para la semana siguiente
        SQL.Add('   and date(fecha_carga_cab)  > :fechafin ');
        SQL.Add('   and date(fecha_alta_cab)  between :fechaini and :fechafin ');
      end;
    end;



     if ACliente <> '' then
    begin
      SQL.Add(' and cliente_cab = :cliente ');
    end;
    SQL.Add(' order by empresa_cab, ean13_det ');
  end;


end;


procedure TDLMargenBConfeccion.CerrarQuerys;
begin
  kmtLineas.Close;
  kmtPaletsConfeccionados.Close;
  kmtEnvases.Close;

  qryEnvase.Close;
  qryProducto.Close;
  qryEanProducto.Close;
  qryPaletsConfeccionados.Close;
end;



function  TDLMargenBConfeccion.GetProducto( const AEmpresa, AEan13: string; const AProductoBase: integer; var VProducto: string ): boolean;
begin
  if AProductoBase <> 0 then
  begin
    qryProducto.ParamByName('empresa').AsString:= AEmpresa;
    qryProducto.ParamByName('producto').AsInteger:= AProductoBase;
    qryProducto.Open;
    Result:= not qryProducto.IsEmpty;
    VProducto:= qryProducto.FieldByName('producto_pb').AsString;
    qryProducto.Close;
  end
  else
  begin
    qryEanProducto.ParamByName('empresa').AsString:= AEmpresa;
    qryEanProducto.ParamByName('ean').AsString:= AEan13;
    qryEanProducto.Open;
    Result:= not qryEanProducto.IsEmpty;
    VProducto:= qryEanProducto.FieldByName('producto_pb').AsString;
    qryEanProducto.Close;
  end;
end;

function  TDLMargenBConfeccion.DatosEnvaseConfeccionados( const AEmpresa, AEan13, AEnvase, ACalibre: string;
                                         var VProducto: string; Var VUnidades: integer ): boolean;
var
  sAux: string;
begin
  begin
    //empresa;ean13;envase;producto_base;unidades;peso
    if kmtEnvases.locate('empresa;ean13;envase',VarArrayOf([AEmpresa, AEan13, AEnvase]),[]) then
    begin
      Result:= True;
      VUnidades:= kmtEnvases.FieldByName('unidades').AsInteger;
      VProducto:= kmtEnvases.FieldByName('producto').AsString;
    end
    else
    begin
      qryEnvase.ParamByName('envase').AsString:= AEnvase;
      qryEnvase.Open;
      if not qryEnvase.isEmpty then
      begin
        kmtEnvases.Insert;
        kmtEnvases.FieldByName('empresa').AsString:= AEmpresa;
        kmtEnvases.FieldByName('ean13').AsString:= AEan13;
        kmtEnvases.FieldByName('envase').AsString:= AEnvase;
//        Result:= GetProducto( AEmpresa, AEan13, qryEnvase.FieldByName('producto_base_e').asInteger, SAux );
        kmtEnvases.FieldByName('producto').AsString:= VProducto;
        kmtEnvases.FieldByName('unidades').AsInteger:= qryEnvase.FieldByName('unidades_e').AsInteger;
        kmtEnvases.FieldByName('peso').AsFloat:= qryEnvase.FieldByName('peso_neto_e').AsFloat;
        kmtEnvases.Post;

        VUnidades:= qryEnvase.FieldByName('unidades_e').AsInteger;
//        VProducto:= SAux;
      end
      else
      begin
        Result:= False;
        kmtEnvases.Insert;
        kmtEnvases.FieldByName('empresa').AsString:= AEmpresa;
        kmtEnvases.FieldByName('ean13').AsString:= AEan13;
        kmtEnvases.FieldByName('envase').AsString:= AEnvase;
        kmtEnvases.FieldByName('producto').AsString:= '';
        kmtEnvases.FieldByName('unidades').AsInteger:= 0;
        kmtEnvases.FieldByName('peso').AsFloat:= 0;
        kmtEnvases.Post;

        VUnidades:= 0;
//        VProducto:= '';
      end;
      qryEnvase.Close;
    end;
  end;

  //Cocos y piñas, el calibre es el numero de unidades
  (*
  if ( AProducto = 'A' ) or ( AProducto = 'C' ) then
  begin
    if not TryStrToInt( ACalibre, VUnidades ) then
    begin
      if not TryStrToInt( Copy( ACalibre, 2, Length( ACalibre ) ), VUnidades ) then
      begin
        VUnidades:= -1;
      end
    end;
  end
  else
  begin
    VUnidades:= -1;
  end;
  *)
  //if VUnidades = -1 then
end;


procedure TDLMargenBConfeccion.DatosLinea(  const ATipo: TTipoConfeccionado );
begin
  dsConfeccionados.DataSet:= kmtLineas;
end;

procedure TDLMargenBConfeccion.OrdenarDatos( const ATipo: TTipoConfeccionado );
begin
  //empresa;centro
  kmtPaletsConfeccionados.SortFields:= 'periodo;producto;cliente;fecha_alta;albaran;ean128';
  kmtPaletsConfeccionados.Sort([]);

  kmtLineas.SortFields:= 'periodo;producto;';
  kmtLineas.Sort([]);
end;


procedure TDLMargenBConfeccion.PaletsConfeccionados( const AEmpresa, AProducto, ACliente: string;
                                              const AFechaIni, AFechaFin: TDateTime;
                                              const ACostesAplicar: RCostesAplicar;
                                              const ATipo: TTipoConfeccionado );
var
  iUnidades: Integer;
  SProductoPalet: string;
begin
  CostesAplicar:=  ACostesAplicar;
  sgEmpresa:= AEmpresa;
  sgProducto:= AProducto;
  sgCliente:= ACliente;
  dgFechaIni:= AFechaIni;
  dgFechaFin:= AFechaFin;

  DatosLinea(  ATipo );

  //orden_carga
  QuerysConfeccionados( AProducto, ACliente, ATipo );
  qryPaletsConfeccionados.ParamByName('empresa').AsString:= AEmpresa;
  if ATipo = tcStock then
  begin
    qryPaletsConfeccionados.ParamByName('fecha').AsDateTime:= AFechaIni;
  end
  else
  begin
    qryPaletsConfeccionados.ParamByName('fechaini').AsDateTime:= AFechaIni;
    qryPaletsConfeccionados.ParamByName('fechaFin').AsDateTime:= AFechaFin;
  end;
  if ACliente <> '' then
  begin
    qryPaletsConfeccionados.ParamByName('cliente').AsString:= ACliente;
  end;
  qryPaletsConfeccionados.Open;

  while not qryPaletsConfeccionados.Eof do
  begin
    if not DatosEnvaseConfeccionados(
           qryPaletsConfeccionados.FieldByName('empresa').AsString,  qryPaletsConfeccionados.FieldByName('ean13').AsString,
           qryPaletsConfeccionados.FieldByName('envase').AsString, qryPaletsConfeccionados.FieldByName('calibre').AsString,
           SProductoPalet, iUnidades ) then
    begin
      ShowMessage('No encontrado el artículo ' + qryPaletsConfeccionados.FieldByName('empresa').AsString + ' - ' +
                  qryPaletsConfeccionados.FieldByName('envase').AsString + ' - ' +
                  qryPaletsConfeccionados.FieldByName('ean13').AsString);
    end;

    if ( AProducto = '' ) or ( AProducto = SProductoPalet ) then
    begin
       AddPaletConfeccionados( SProductoPalet, iUnidades );
    end;
    qryPaletsConfeccionados.Next;
  end;

  OrdenarDatos( ATipo );
end;

procedure TDLMargenBConfeccion.AddPaletConfeccionados(const AProducto: string;  const AUnidades: Integer );
begin
      kmtPaletsConfeccionados.Insert;
      kmtPaletsConfeccionados.FieldByName('periodo').AsString:= 'PERIODO';
      kmtPaletsConfeccionados.FieldByName('producto').AsString:= AProducto;
      kmtPaletsConfeccionados.FieldByName('empresa').AsString:= qryPaletsConfeccionados.FieldByName('empresa').AsString;
      kmtPaletsConfeccionados.FieldByName('centro').AsString:= qryPaletsConfeccionados.FieldByName('centro').AsString;
      kmtPaletsConfeccionados.FieldByName('fecha_carga').AsDateTime:= qryPaletsConfeccionados.FieldByName('fecha_carga').AsDateTime;
      kmtPaletsConfeccionados.FieldByName('albaran').AsInteger:= 0;//qryPaletsConfeccionados.FieldByName('albaran').AsInteger;
      kmtPaletsConfeccionados.FieldByName('orden_carga').AsInteger:= qryPaletsConfeccionados.FieldByName('orden_carga').AsInteger;
      kmtPaletsConfeccionados.FieldByName('cliente').AsString:= qryPaletsConfeccionados.FieldByName('cliente').AsString;

      kmtPaletsConfeccionados.FieldByName('fecha_alta').AsDateTime:= qryPaletsConfeccionados.FieldByName('fecha_alta').AsDateTime;
      kmtPaletsConfeccionados.FieldByName('ean128').AsString:= qryPaletsConfeccionados.FieldByName('ean128').AsString;
      kmtPaletsConfeccionados.FieldByName('status').AsString:= qryPaletsConfeccionados.FieldByName('status').AsString;

      kmtPaletsConfeccionados.FieldByName('ean13').AsString:= qryPaletsConfeccionados.FieldByName('ean13').AsString;
      kmtPaletsConfeccionados.FieldByName('envase').AsString:= qryPaletsConfeccionados.FieldByName('envase').AsString;
      kmtPaletsConfeccionados.FieldByName('calibre').AsString:= qryPaletsConfeccionados.FieldByName('calibre').AsString;

      kmtPaletsConfeccionados.FieldByName('cajas').AsInteger:= qryPaletsConfeccionados.FieldByName('cajas').AsInteger;
      kmtPaletsConfeccionados.FieldByName('unidades').AsInteger:= AUnidades * qryPaletsConfeccionados.FieldByName('cajas').AsInteger;
    kmtPaletsConfeccionados.FieldByName('peso').AsFloat:= qryPaletsConfeccionados.FieldByName('peso').AsFloat;

  AddLineaConfeccionados;
  kmtPaletsConfeccionados.Post;
end;

procedure TDLMargenBConfeccion.AddLineaConfeccionados;
begin
  if dsConfeccionados.DataSet.Locate( 'periodo;producto', VarArrayOf(['PERIODO',kmtPaletsConfeccionados.FieldByName('producto').AsString,0]),[]) then
  begin
    dsConfeccionados.DataSet.Edit;
    dsConfeccionados.DataSet.FieldByName('peso').AsFloat:= dsConfeccionados.DataSet.FieldByName('peso').AsFloat +
                                                    kmtPaletsConfeccionados.FieldByName('peso').AsFloat;
    dsConfeccionados.DataSet.FieldByName('cajas').AsInteger:= dsConfeccionados.DataSet.FieldByName('cajas').AsInteger +
                                                       kmtPaletsConfeccionados.FieldByName('cajas').AsInteger;
    dsConfeccionados.DataSet.FieldByName('unidades').AsInteger:= dsConfeccionados.DataSet.FieldByName('unidades').AsInteger +
                                                          kmtPaletsConfeccionados.FieldByName('unidades').AsInteger;
    dsConfeccionados.DataSet.Post;
  end
  else
  begin
    dsConfeccionados.DataSet.Insert;
    dsConfeccionados.DataSet.FieldByName('empresa').AsString:= sgEmpresa;
    dsConfeccionados.DataSet.FieldByName('periodo').AsString:= 'PERIODO';
    dsConfeccionados.DataSet.FieldByName('producto').AsString:= kmtPaletsConfeccionados.FieldByName('producto').AsString;
    dsConfeccionados.DataSet.FieldByName('cliente').AsString:= sgCliente;

    dsConfeccionados.DataSet.FieldByName('peso').AsFloat:= kmtPaletsConfeccionados.FieldByName('peso').AsFloat;
    dsConfeccionados.DataSet.FieldByName('cajas').AsInteger:= kmtPaletsConfeccionados.FieldByName('cajas').AsInteger;
    dsConfeccionados.DataSet.FieldByName('unidades').AsInteger:= kmtPaletsConfeccionados.FieldByName('unidades').AsInteger;
    dsConfeccionados.DataSet.Post;
  end;
end;

end.
