unit PlantillaReporteData;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DBTables;

type
  TDPlantillaReporte = class(TDataModule)
    kmtListado: TkbmMemTable;
    qryDatos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    function  OpenDataPlantillaReporte(const AEmpresa, ACentro, ACliente, AProducto: string;
                                     const AFechaIni, AFechaFin: TDateTime; const AAnyo, AMes: integer ): Boolean;
    function  LoadData: boolean;
    procedure LoadRegister;
  public
    { Public declarations }
  end;

  function OpenDataPlantillaReporte(const AEmpresa, ACentro, ACliente, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime; const AAnyo, AMes: integer ): Boolean;
  procedure CloseDataPlantillaReporte;



implementation

{$R *.dfm}

uses
  UDMAuxDB;

var
  DPlantillaReporte: TDPlantillaReporte;

function OpenDataPlantillaReporte(const AEmpresa, ACentro, ACliente, AProducto: string;
                                  const AFechaIni, AFechaFin: TDateTime; const AAnyo, AMes: integer ): Boolean;
begin
  DPlantillaReporte:= TDPlantillaReporte.Create( nil );
  result:= DPlantillaReporte.OpenDataPlantillaReporte(AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin, AAnyo, AMes );
end;

procedure CloseDataPlantillaReporte;
begin
  FreeAndNil( DPlantillaReporte );
end;

procedure TDPlantillaReporte.DataModuleCreate(Sender: TObject);
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

  with qryDatos do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_sal_sc cod_cliente, producto_sl cod_producto, descripcion_p producto, ');
    SQL.Add('        sum(kilos_sl) kilos, sum(importe_neto_sl) importe, ');
    SQL.Add('        round( case when sum(kilos_sl) = 0 then 0 else sum(importe_neto_sl)/sum(kilos_sl) end, 3) precio_sl ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add('      join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl and ');
    SQL.Add('                       n_albaran_sc = n_albaran_sc and fecha_sc = fecha_sl ');
    SQL.Add('      join frf_productos on empresa_sl = empresa_p and producto_sl = producto_p ');
    SQL.Add(' where fecha_sl between :fechaini and :fechafin ');
    SQL.Add(' and cliente_sal_sc in (''MAK'',''MER'',''SOC'',''SUM'',''ZE'',''ERO'',''MYM'',''NES'',''AMA'',''ECI'',''DIA'') ');
    SQL.Add(' group by cliente_sal_sc, producto_sl, descripcion_p ');
    SQL.Add(' order by cliente_sal_sc, producto_sl, descripcion_p ');
  end;
end;

procedure TDPlantillaReporte.DataModuleDestroy(Sender: TObject);
begin
  kmtListado.Close;
end;

function TDPlantillaReporte.OpenDataPlantillaReporte(const AEmpresa, ACentro, ACliente, AProducto: string;
                                                    const AFechaIni, AFechaFin: TDateTime; const AAnyo, AMes: integer ): Boolean;
begin
  qryDatos.ParamByName('fechaini').AsDate:= AFechaIni;
  qryDatos.ParamByName('fechafin').AsDate:= AFechaFin;
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

function TDPlantillaReporte.LoadData: boolean;
begin
  while not qryDatos.Eof do
  begin
    LoadRegister;
    qryDatos.Next;
  end;
end;

procedure TDPlantillaReporte.LoadRegister;
begin
  kmtListado.Insert;
  kmtListado.FieldByName('cliente').AsString:= qryDatos.FieldByName('cod_cliente').AsString;
  kmtListado.FieldByName('des_cliente').AsString:= qryDatos.FieldByName('cod_cliente').AsString;
  kmtListado.FieldByName('producto').AsString:= qryDatos.FieldByName('cod_producto').AsString;
  kmtListado.FieldByName('des_producto').AsString:= qryDatos.FieldByName('producto').AsString;
  kmtListado.FieldByName('kilos').AsFloat:= qryDatos.FieldByName('kilos').AsFloat;
  kmtListado.FieldByName('importe').AsFloat:= qryDatos.FieldByName('importe').AsFloat;
  kmtListado.FieldByName('precio').AsFloat:= qryDatos.FieldByName('precio_sl').AsFloat;
  kmtListado.Post;
end;

end.
