unit ResumenConsumosDL;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;


type
  TDLResumenConsumos = class(TDataModule)
    qryTransito: TQuery;
    kmtResumenEntregas: TkbmMemTable;
    qryEntregasRF: TQuery;
    kmtResumenClientes: TkbmMemTable;
  private
    { Private declarations }
    //Parametros iniciales
    sPlanta, sProducto, sSemana, sEntrega: string;
    dFechaIni, dFechaFin: TDateTime;

    //General
    procedure PutSqlQuerys;
    function  HayDatos: Boolean;
    procedure CerrarTablas;

    procedure ConectarRemoto( const APlanta: string; var AQuery: TQuery );
    procedure DesConectarRemoto;

    //Clientes
    procedure TablaTemporalClientes;
    procedure CerrarTablaTemporalClientes;

    procedure MakeLineasCliente;
    function  ExistLineaCliente( var VCliente: string; var VTransito: boolean ): boolean;
    procedure NewLineaCliente( const ACliente: string; const ATransito: boolean );
    procedure EditLineaCliente;

    procedure PreviewResumenCliente;

    //Entregas
    procedure TablaTemporalEntregas;
    procedure CerrarTablaTemporalEntregas;

    procedure MakeLineasEntrega;
    function  ExistLineaEntrega: boolean;
    procedure NewLineaEntrega;
    procedure EditLineaEntrega;

    procedure PreviewResumenEntrega;

  public
    { Public declarations }

    procedure ResumenConsumosRFEntrega( const AEmpresa, AProducto, ASemana, AEntrega: string; const AFechaIni, AFechaFin: TDateTime );
    procedure ResumenConsumosRFCliente( const AEmpresa, AProducto, ASemana, AEntrega: string; const AFechaIni, AFechaFin: TDateTime );
  end;


implementation

{$R *.dfm}

uses
  UDMBaseDatos, Variants, bMath, ResumenConsumosEntregaQL, ResumenConsumosClienteQL;


procedure TDLResumenConsumos.ConectarRemoto( const APlanta: string; var AQuery: TQuery );
var
  bAux: boolean;
begin
  bAux:= AQuery.Active;
  if AQuery.Active then
    AQuery.Close;

  if APlanta = 'F17' then
  begin
   if not DMBaseDatos.dbF17.Connected then
     DMBaseDatos.dbF17.Connected:= True;
   AQuery.DatabaseName:= 'dbF17';
  end;
  if APlanta = 'F18' then
  begin
   if not DMBaseDatos.dbF18.Connected then
     DMBaseDatos.dbF18.Connected:= True;
   AQuery.DatabaseName:= 'dbF18';
  end;
  (*
  if APlanta = 'F21' then
  begin
   if not DMBaseDatos.dbF21.Connected then
     DMBaseDatos.dbF21.Connected:= True;
   AQuery.DatabaseName:= 'dbF21';
  end;
  *)
  if APlanta = 'F23' then
  begin
   if not DMBaseDatos.dbF23.Connected then
     DMBaseDatos.dbF23.Connected:= True;
   AQuery.DatabaseName:= 'dbF23';
  end;
  (*
  if APlanta = 'F24' then
  begin
   if not DMBaseDatos.dbF24.Connected then
     DMBaseDatos.dbF24.Connected:= True;
   AQuery.DatabaseName:= 'dbF24';
  end;
  *)
  if bAux then
    AQuery.Open;
end;

procedure TDLResumenConsumos.DesconectarRemoto;
begin
  if DMBaseDatos.dbF17.Connected then
    DMBaseDatos.dbF17.Connected:= False;
  if DMBaseDatos.dbF18.Connected then
    DMBaseDatos.dbF18.Connected:= False;
  (*
  if DMBaseDatos.dbF21.Connected then
    DMBaseDatos.dbF21.Connected:= False;
  *)
  if DMBaseDatos.dbF23.Connected then
    DMBaseDatos.dbF23.Connected:= False;
  (*
  if DMBaseDatos.dbF24.Connected then
    DMBaseDatos.dbF24.Connected:= False;
  *)
end;

procedure TDLResumenConsumos.PutSqlQuerys;
begin
  //datos de a RF original de la entrega
  with qryEntregasRF do
  begin
    SQL.Clear;
    SQL.Add('select producto, entrega, proveedor, proveedor_almacen almacen, ');
    SQL.Add('       cliente cliente_volcado, cliente_sal_occ cliente_carga, planta_destino_occ planta_destino, ');
    SQL.Add('      ( select sum(kilos_el) from frf_Entregas_l where entrega = codigo_el ) kilos_entrega, ');
    SQL.Add('      ( select sum(pb2.peso) from rf_palet_pb pb2 where pb1.entrega = pb2.entrega and status <> ''B'' ) kilos_rf, ');
    SQL.Add('       nvl( ( select sum(pb2.peso) from rf_palet_pb pb2 where pb1.entrega = pb2.entrega and pb2.status = ''S'' ), 0) kilos_stock, ');
    SQL.Add('       sum( case when status = ''V'' then peso else 0 end ) kilos_volcados, ');
    SQL.Add('       sum( case when status = ''R'' then peso else 0 end ) kilos_regularizados, ');
    SQL.Add('       sum( case when status = ''C'' and nvl(cliente_sal_occ,'''') <> '''' then peso else 0 end ) kilos_directos, ');
    SQL.Add('       sum( case when status = ''C'' and nvl(cliente_sal_occ,'''') = ''''then peso else 0 end ) kilos_transitos, ');
    SQL.Add('       sum( case when status = ''D'' then peso else 0 end ) kilos_destrio, ');
    SQL.Add('       sum( case when status not in (''V'',''R'',''C'',''D'') then peso else 0 end ) kilos_otros ');
    SQL.Add('from rf_palet_pb pb1 left join frf_orden_carga_c on orden_carga = orden_occ ');
    if sSemana <> '' then
    begin
      SQL.Add('       join frf_entregas_c on codigo_ec = entrega ');
    end;
    SQL.Add('where empresa = :empresa ');
    SQL.Add(' and date(fecha_status) between :fechaini and :fechafin ');
    SQL.Add(' and status <> ''B'' ');

    if sEntrega <> '' then
    begin
      SQL.Add(' and entrega = :entrega ');
    end;
    if sProducto <> '' then
    begin
      SQL.Add(' and producto = :producto ');
    end;
    if sSemana <> '' then
    begin
      SQL.Add(' and anyo_semana_ec = :semana ');
    end;

    SQL.Add('group by producto, entrega, proveedor, almacen, cliente_volcado, cliente_carga, planta_destino ');
    SQL.Add('order by producto, entrega, proveedor, almacen  ');
  end;

  qryEntregasRF.ParamByName('empresa').AsString:= sPlanta;
  qryEntregasRF.ParamByName('fechaini').AsDateTIme:= dFechaIni;
  qryEntregasRF.ParamByName('fechafin').AsDateTIme:= dFechaFin;
  if sEntrega <> '' then
  begin
    qryEntregasRF.ParamByName('entrega').AsString:= sProducto;
  end;
  if sProducto <> '' then
  begin
    qryEntregasRF.ParamByName('producto').AsString:= sProducto;
  end;
  if sSemana <> '' then
  begin
    qryEntregasRF.ParamByName('semana').AsString:= sSemana;
  end;


  //Kilos totales entrega/transito
  with qryTransito do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_el) from frf_Entregas_l where codigo_el = :entrega  ');
  end;
end;

procedure TDLResumenConsumos.TablaTemporalEntregas;
begin
  kmtResumenEntregas.FieldDefs.Clear;
  kmtResumenEntregas.FieldDefs.Add('entrega', ftString, 12, False);
  kmtResumenEntregas.FieldDefs.Add('transito_in', ftInteger, 0, False);
  kmtResumenEntregas.FieldDefs.Add('producto', ftString, 3, False);
  kmtResumenEntregas.FieldDefs.Add('proveedor', ftString, 3, False);
  kmtResumenEntregas.FieldDefs.Add('almacen', ftString, 3, False);

  kmtResumenEntregas.FieldDefs.Add('kilos_entrega', ftFloat, 0, False);
  kmtResumenEntregas.FieldDefs.Add('kilos_rf', ftFloat, 0, False);
  kmtResumenEntregas.FieldDefs.Add('kilos_stock', ftFloat, 0, False);
  kmtResumenEntregas.FieldDefs.Add('kilos_volcados', ftFloat, 0, False);
  kmtResumenEntregas.FieldDefs.Add('kilos_regularizados', ftFloat, 0, False);
  kmtResumenEntregas.FieldDefs.Add('kilos_directos', ftFloat, 0, False);
  kmtResumenEntregas.FieldDefs.Add('kilos_transitos', ftFloat, 0, False);
  kmtResumenEntregas.FieldDefs.Add('kilos_destrio', ftFloat, 0, False);
  kmtResumenEntregas.FieldDefs.Add('kilos_otros', ftFloat, 0, False);

  kmtResumenEntregas.IndexFieldNames:= 'entrega';
  kmtResumenEntregas.CreateTable;


  kmtResumenEntregas.Open;
end;

procedure TDLResumenConsumos.TablaTemporalClientes;
begin
  kmtResumenClientes.FieldDefs.Clear;
  kmtResumenClientes.FieldDefs.Add('producto', ftString, 3, False);
  kmtResumenClientes.FieldDefs.Add('cliente', ftString, 12, False);
  kmtResumenClientes.FieldDefs.Add('transito', ftBoolean, 0, False);

  kmtResumenClientes.FieldDefs.Add('kilos_volcados', ftFloat, 0, False);
  kmtResumenClientes.FieldDefs.Add('kilos_directos', ftFloat, 0, False);
  kmtResumenClientes.FieldDefs.Add('kilos_destrio', ftFloat, 0, False);
  kmtResumenClientes.FieldDefs.Add('kilos_otros', ftFloat, 0, False);

  kmtResumenClientes.IndexFieldNames:= 'producto;cliente';
  kmtResumenClientes.CreateTable;

  kmtResumenClientes.Open;
end;

procedure TDLResumenConsumos.CerrarTablaTemporalEntregas;
begin
  kmtResumenEntregas.Close;
end;

procedure TDLResumenConsumos.CerrarTablaTemporalClientes;
begin
  kmtResumenClientes.Close;
end;

procedure TDLResumenConsumos.ResumenConsumosRFEntrega( const AEmpresa, AProducto, ASemana, AEntrega: string; const AFechaIni, AFechaFin: TDateTime );
begin
  //Comprobar que son validos
  sPlanta:= AEmpresa;
  sProducto:= AProducto;
  sSemana:= ASemana;
  sEntrega:= AEntrega;
  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;

  PutSqlQuerys;
  ConectarRemoto( sPlanta, qryEntregasRF );
  if HayDatos then
  begin
    TablaTemporalEntregas;
    MakeLineasEntrega;
    CerrarTablas;
    DesconectarRemoto;

    PreviewResumenEntrega;
    CerrarTablaTemporalEntregas;
  end
  else
  begin
    CerrarTablas;
    DesconectarRemoto;
  end;
end;

procedure TDLResumenConsumos.ResumenConsumosRFCliente( const AEmpresa, AProducto, ASemana, AEntrega: string; const AFechaIni, AFechaFin: TDateTime );
begin
  //Comprobar que son validos
  sPlanta:= AEmpresa;
  sProducto:= AProducto;
  sSemana:= ASemana;
  sEntrega:= AEntrega;
  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;


  PutSqlQuerys;
  ConectarRemoto( sPlanta, qryEntregasRF );
  if HayDatos then
  begin
    TablaTemporalClientes;
    MakeLineasCliente;
    CerrarTablas;
    DesconectarRemoto;

    PreviewResumenCliente;
    CerrarTablaTemporalClientes;
  end
  else
  begin
    CerrarTablas;
    DesconectarRemoto;
  end;
end;

function TDLResumenConsumos.HayDatos: Boolean;
begin
  qryEntregasRF.open;
  result:= not qryEntregasRF.IsEmpty;
end;

procedure TDLResumenConsumos.CerrarTablas;
begin
  qryEntregasRF.Close;
end;


procedure TDLResumenConsumos.MakeLineasEntrega;
begin
  while not qryEntregasRF.Eof do
  begin
    if ExistLineaEntrega then
      EditLineaEntrega
    else
      NewLineaEntrega;
    qryEntregasRF.Next;
  end;
  kmtResumenEntregas.SortFields:= 'producto;proveedor;almacen';
  kmtResumenEntregas.Sort([]);
end;

procedure TDLResumenConsumos.MakeLineasCliente;
var
  sCliente: string;
  bTransito: Boolean;
begin
  while not qryEntregasRF.Eof do
  begin
    if ExistLineaCliente( sCliente, bTransito ) then
      EditLineaCliente
    else
      NewLineaCliente( sCliente, bTransito );
    qryEntregasRF.Next;
  end;
  kmtResumenClientes.SortFields:= 'producto;cliente';
  kmtResumenClientes.Sort([]);
end;

function  TDLResumenConsumos.ExistLineaEntrega: boolean;
begin
  result:= kmtResumenEntregas.Locate( 'entrega',
       VarArrayOf([qryEntregasRF.fieldByName('entrega').AsString]),[]);
end;

function  TDLResumenConsumos.ExistLineaCliente( var VCliente: string; var VTransito: boolean ): boolean;
begin
  if qryEntregasRF.fieldByName('cliente_carga').AsString <> '' then
  begin
    VCliente:= qryEntregasRF.fieldByName('cliente_carga').AsString;
    VTransito:= False;
  end
  else
  if qryEntregasRF.fieldByName('planta_destino').AsString <> '' then
  begin
    VCliente:= qryEntregasRF.fieldByName('planta_destino').AsString;
    VTransito:= True;
  end
  else
  begin
    VCliente:= qryEntregasRF.fieldByName('cliente_volcado').AsString;
    VTransito:= False;
  end;

  result:= kmtResumenClientes.Locate( 'producto;cliente;transito', VarArrayOf([qryEntregasRF.fieldByName('producto').AsString,VCliente,VTransito]),[]);
end;

procedure TDLResumenConsumos.NewLineaEntrega;
begin
  kmtResumenEntregas.Insert;

  kmtResumenEntregas.fieldByName('entrega').AsString:= qryEntregasRF.fieldByName('entrega').AsString;
  kmtResumenEntregas.fieldByName('producto').AsString:= qryEntregasRF.fieldByName('producto').AsString;
  kmtResumenEntregas.fieldByName('proveedor').AsString:= qryEntregasRF.fieldByName('proveedor').AsString;
  kmtResumenEntregas.fieldByName('almacen').AsString:= qryEntregasRF.fieldByName('almacen').AsString;

  if qryEntregasRF.fieldByName('kilos_entrega').Asfloat <> 0 then
  begin
    kmtResumenEntregas.fieldByName('kilos_entrega').Asfloat:= qryEntregasRF.fieldByName('kilos_entrega').Asfloat;
    kmtResumenEntregas.fieldByName('transito_in').AsInteger:= -1;
  end
  else
  begin
    //Puede que vengan de un transito de otro centro
    kmtResumenEntregas.fieldByName('kilos_entrega').Asfloat:= qryEntregasRF.fieldByName('kilos_entrega').Asfloat;
    kmtResumenEntregas.fieldByName('transito_in').AsInteger:= 1;
  end;
  kmtResumenEntregas.fieldByName('kilos_rf').Asfloat:= qryEntregasRF.fieldByName('kilos_rf').Asfloat;
  kmtResumenEntregas.fieldByName('kilos_stock').Asfloat:= qryEntregasRF.fieldByName('kilos_stock').Asfloat;

  kmtResumenEntregas.fieldByName('kilos_volcados').Asfloat:= qryEntregasRF.fieldByName('kilos_volcados').Asfloat;
  kmtResumenEntregas.fieldByName('kilos_regularizados').Asfloat:= qryEntregasRF.fieldByName('kilos_regularizados').Asfloat;
  kmtResumenEntregas.fieldByName('kilos_directos').Asfloat:= qryEntregasRF.fieldByName('kilos_directos').Asfloat;
  kmtResumenEntregas.fieldByName('kilos_transitos').Asfloat:= qryEntregasRF.fieldByName('kilos_transitos').Asfloat;
  kmtResumenEntregas.fieldByName('kilos_destrio').Asfloat:= qryEntregasRF.fieldByName('kilos_destrio').Asfloat;
  kmtResumenEntregas.fieldByName('kilos_otros').Asfloat:= qryEntregasRF.fieldByName('kilos_otros').Asfloat;

  kmtResumenEntregas.Post;

end;

procedure TDLResumenConsumos.NewLineaCliente( const ACliente: string; const ATransito: boolean  );
begin
  kmtResumenClientes.Insert;

  kmtResumenClientes.fieldByName('producto').AsString:= qryEntregasRF.fieldByName('producto').AsString;
  kmtResumenClientes.fieldByName('cliente').AsString:= ACliente;
  kmtResumenClientes.fieldByName('transito').AsBoolean:= ATransito;

  kmtResumenClientes.fieldByName('kilos_volcados').Asfloat:= qryEntregasRF.fieldByName('kilos_volcados').Asfloat;
  kmtResumenClientes.fieldByName('kilos_directos').Asfloat:= qryEntregasRF.fieldByName('kilos_directos').Asfloat +
                                                             qryEntregasRF.fieldByName('kilos_transitos').Asfloat;
  kmtResumenClientes.fieldByName('kilos_destrio').Asfloat:= qryEntregasRF.fieldByName('kilos_destrio').Asfloat;
  kmtResumenClientes.fieldByName('kilos_otros').Asfloat:= qryEntregasRF.fieldByName('kilos_otros').Asfloat +
                                                          qryEntregasRF.fieldByName('kilos_regularizados').Asfloat;

  kmtResumenClientes.Post;

end;

procedure TDLResumenConsumos.EditLineaEntrega;
begin
  kmtResumenEntregas.Edit;
  kmtResumenEntregas.fieldByName('kilos_volcados').Asfloat:= kmtResumenEntregas.fieldByName('kilos_volcados').Asfloat + qryEntregasRF.fieldByName('kilos_volcados').AsFloat;
  kmtResumenEntregas.fieldByName('kilos_regularizados').Asfloat:= kmtResumenEntregas.fieldByName('kilos_regularizados').Asfloat + qryEntregasRF.fieldByName('kilos_regularizados').Asfloat;
  kmtResumenEntregas.fieldByName('kilos_directos').Asfloat:= kmtResumenEntregas.fieldByName('kilos_directos').Asfloat + qryEntregasRF.fieldByName('kilos_directos').Asfloat;
  kmtResumenEntregas.fieldByName('kilos_transitos').Asfloat:= kmtResumenEntregas.fieldByName('kilos_transitos').Asfloat + qryEntregasRF.fieldByName('kilos_transitos').Asfloat;
  kmtResumenEntregas.fieldByName('kilos_destrio').Asfloat:= kmtResumenEntregas.fieldByName('kilos_destrio').Asfloat + qryEntregasRF.fieldByName('kilos_destrio').Asfloat;
  kmtResumenEntregas.fieldByName('kilos_otros').Asfloat:= kmtResumenEntregas.fieldByName('kilos_otros').Asfloat + qryEntregasRF.fieldByName('kilos_otros').Asfloat;

  kmtResumenEntregas.Post;
end;

procedure TDLResumenConsumos.EditLineaCliente;
begin
  kmtResumenClientes.Edit;
  kmtResumenClientes.fieldByName('kilos_volcados').Asfloat:= kmtResumenClientes.fieldByName('kilos_volcados').Asfloat + qryEntregasRF.fieldByName('kilos_volcados').Asfloat;
  kmtResumenClientes.fieldByName('kilos_directos').Asfloat:= kmtResumenClientes.fieldByName('kilos_directos').Asfloat +
                                                             qryEntregasRF.fieldByName('kilos_directos').Asfloat +
                                                             qryEntregasRF.fieldByName('kilos_transitos').Asfloat;
  kmtResumenClientes.fieldByName('kilos_destrio').Asfloat:= kmtResumenClientes.fieldByName('kilos_destrio').Asfloat + qryEntregasRF.fieldByName('kilos_destrio').Asfloat;
  kmtResumenClientes.fieldByName('kilos_otros').Asfloat:= kmtResumenClientes.fieldByName('kilos_otros').Asfloat + qryEntregasRF.fieldByName('kilos_otros').Asfloat;
  kmtResumenClientes.fieldByName('kilos_otros').Asfloat:= kmtResumenClientes.fieldByName('kilos_otros').Asfloat +
                                                          qryEntregasRF.fieldByName('kilos_otros').Asfloat +
                                                          qryEntregasRF.fieldByName('kilos_regularizados').Asfloat;

  kmtResumenClientes.Post;
end;


procedure TDLResumenConsumos.PreviewResumenEntrega;
begin
  ResumenConsumosEntregaQL.PrevisualizarResumenEntrega( sPlanta );
end;

procedure TDLResumenConsumos.PreviewResumenCliente;
begin
  ResumenConsumosClienteQL.PrevisualizarResumenClientes( sPlanta );
end;

end.
