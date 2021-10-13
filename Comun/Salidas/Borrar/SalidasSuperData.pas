unit SalidasSuperData;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDSalidasSuper = class(TDataModule)
    kmtListado: TkbmMemTable;
    qryDatos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCliente, sTipoCliente, sProducto: string;
    dFechaIni, dFechaFin: TDateTime;
    bExcluir: Boolean;

    function  OpenDataSalidasSuper( const AEmpresa, ACliente, ATipoCliente, AProducto: string;
                                    const AFechaIni, AFechaFin: TDateTime; const AExcluir: boolean ): Boolean;
    procedure CreateSQL;
    function  LoadData: boolean;
    procedure LoadRegister;

  public
    { Public declarations }
  end;

  function OpenDataSalidasSuper(const AEmpresa, ACliente, ATipoCliente, AProducto: string;
                                const AFechaIni, AFechaFin: TDateTime; const AExcluir: boolean ): Boolean;
  procedure CloseDataSalidasSuper;



implementation

{$R *.dfm}

uses
  UDMAuxDB;

var
  DSalidasSuper: TDSalidasSuper;

function OpenDataSalidasSuper( const AEmpresa, ACliente, ATipoCliente, AProducto: string;
                               const AFechaIni, AFechaFin: TDateTime; const AExcluir: boolean ): Boolean;
begin
  DSalidasSuper:= TDSalidasSuper.Create( nil );
  result:= DSalidasSuper.OpenDataSalidasSuper( AEmpresa, ACliente, ATipoCliente, AProducto, AFechaIni, AFechaFin, AExcluir );
end;

procedure CloseDataSalidasSuper;
begin
  FreeAndNil( DSalidasSuper );
end;

procedure TDSalidasSuper.DataModuleCreate(Sender: TObject);
begin
  with kmtListado do
  begin
    FieldDefs.Clear;

    //FieldDefs.Add('empresa', ftString, 3, False);
    //FieldDefs.Add('centro', ftString, 1, False);
    FieldDefs.Add('cliente', ftString, 3, False);
    FieldDefs.Add('producto', ftString, 3, False);
    //FieldDefs.Add('agrupacion', ftString, 20, False);
    //FieldDefs.Add('envase', ftString, 3, False);

    //FieldDefs.Add('des_empresa', ftString, 30, False);
    //FieldDefs.Add('des_centro', ftString, 30, False);
    FieldDefs.Add('des_cliente', ftString, 30, False);
    FieldDefs.Add('des_producto', ftString, 30, False);
    //FieldDefs.Add('des_envase', ftString, 30, False);


    FieldDefs.Add('kilos', ftFloat, 0, False);
    FieldDefs.Add('importe', ftFloat, 0, False);
    FieldDefs.Add('precio', ftFloat, 0, False);

    IndexFieldNames:= 'cliente;producto';
    CreateTable;
    Open;
  end;
end;

procedure TDSalidasSuper.DataModuleDestroy(Sender: TObject);
begin
  kmtListado.Close;
end;


procedure TDSalidasSuper.CreateSQL;
begin
  with qryDatos do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_sal_sc cod_cliente, producto_sl cod_producto, descripcion_p producto, ');
    SQL.Add('        sum(kilos_sl) kilos, sum(importe_neto_sl) importe, ');
    SQL.Add('        round( case when sum(kilos_sl) = 0 then 0 else sum(importe_neto_sl)/sum(kilos_sl) end, 3) precio_sl ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add('      join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl and ');
    SQL.Add('                       n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
    SQL.Add('      join frf_productos on empresa_sl = empresa_p and producto_sl = producto_p ');
    SQL.Add('      join frf_clientes on empresa_sl = empresa_c and cliente_sl = cliente_c ');
    SQL.Add(' where fecha_sl between :fechaini and :fechafin ');
    if  sEmpresa = 'BAG' then
    begin
      SQL.Add(' and empresa_sc[1,1] = ''F'' ');
    end
    else
    if  sEmpresa = 'SAT' then
    begin
      SQL.Add(' and ( empresa_sc = ''050'' or  empresa_sc = ''080'' ) ');
    end
    else
    begin
      SQL.Add(' and empresa_sc = :empresa ');
    end;


    if sCliente <> '' then
    begin
      if bExcluir then
        SQL.Add(' and cliente_sal_sc <> :cliente ')
      else
        SQL.Add(' and cliente_sal_sc = :cliente ');
    end;
    SQL.Add(' and tipo_cliente_c = :tipo_cliente ');


    if sProducto <> '' then
    begin
      SQL.Add(' and producto_sl = :producto ');
    end;
    SQL.Add(' group by cliente_sal_sc, producto_sl, descripcion_p ');
    SQL.Add(' order by cliente_sal_sc, producto_sl, descripcion_p ');


    if sProducto <> '' then
    begin
      ParamByName('producto').AsString:= sProducto;
    end;
    if  ( sEmpresa <> 'BAG' ) and  ( sEmpresa <> 'SAT'  )then
    begin
      ParamByName('empresa').AsString:= sEmpresa;
    end;
    if sCliente <> '' then
    begin
      ParamByName('cliente').AsString:= sCliente;
    end;
    ParamByName('tipo_cliente').AsString:= sTipoCliente;

    ParamByName('fechaini').AsDate:= dFechaIni;
    ParamByName('fechafin').AsDate:= dFechaFin;
  end;
end;

function TDSalidasSuper.OpenDataSalidasSuper( const AEmpresa, ACliente, ATipoCliente, AProducto: string;
                                              const AFechaIni, AFechaFin: TDateTime; const AExcluir: boolean ): Boolean;
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  sTipoCliente:= ATipoCliente;
  sProducto:= AProducto;
  dFechaIni:= AFechaIni;
  dFechaFin:= AFechaFin;
  bExcluir:= AExcluir;

  CreateSQL;
  qryDatos.Open;
  try
    if not qryDatos.IsEmpty then
    begin
      Result:= LoadData;
      kmtListado.SortFields:= 'cliente;producto';
      kmtListado.Sort([]);
    end
    else
    begin
      Result:= False;
    end;
  finally
    qryDatos.Close;
  end;
end;

function TDSalidasSuper.LoadData: boolean;
begin
  while not qryDatos.Eof do
  begin
    LoadRegister;
    qryDatos.Next;
  end;
  Result:= not kmtListado.IsEmpty;
end;

procedure TDSalidasSuper.LoadRegister;
begin
  kmtListado.Insert;
  kmtListado.FieldByName('cliente').AsString:= qryDatos.FieldByName('cod_cliente').AsString;
  kmtListado.FieldByName('des_cliente').AsString:= desCliente( sEmpresa, qryDatos.FieldByName('cod_cliente').AsString );
  kmtListado.FieldByName('producto').AsString:= qryDatos.FieldByName('cod_producto').AsString;
  kmtListado.FieldByName('des_producto').AsString:= qryDatos.FieldByName('producto').AsString;
  kmtListado.FieldByName('kilos').AsFloat:= qryDatos.FieldByName('kilos').AsFloat;
  kmtListado.FieldByName('importe').AsFloat:= qryDatos.FieldByName('importe').AsFloat;
  kmtListado.FieldByName('precio').AsFloat:= qryDatos.FieldByName('precio_sl').AsFloat;
  kmtListado.Post;
end;

end.
