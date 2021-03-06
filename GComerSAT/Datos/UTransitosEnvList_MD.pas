unit UTransitosEnvList_MD;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TTransitosEnvList_MD = class(TDataModule)
    QTransitos: TQuery;
    kbmTransitos: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa: string;
    procedure AnyadeLinea;
  public
    { Public declarations }
    procedure CargaQuery( const AEmpresa, ASalida, ADestino, AProducto, AAgrupacion: string;
                          const AFechainicio, AFechafin: TDateTime; const AFechaSalida: boolean );
    procedure CreaListado;
  end;

var
  MDTransitosEnvList: TTransitosEnvList_MD;

implementation

{$R *.dfm}

uses
  UDMAuxDB;

procedure TTransitosEnvList_MD.DataModuleCreate(Sender: TObject);
begin
  kbmTransitos.FieldDefs.Clear;
  kbmTransitos.FieldDefs.Add('producto', ftString, 3, False);
  kbmTransitos.FieldDefs.Add('categoria', ftString, 1, False);
  kbmTransitos.FieldDefs.Add('envase', ftString, 9, False);
  kbmTransitos.FieldDefs.Add('desProducto', ftString, 30, False);
  kbmTransitos.FieldDefs.Add('desEnvase', ftString, 30, False);
  kbmTransitos.FieldDefs.Add('cajas', ftInteger, 0, False);
  kbmTransitos.FieldDefs.Add('kilos', ftFloat, 0, False);
  kbmTransitos.CreateTable;
  kbmTransitos.SortFields := 'producto;categoria;envase';
  kbmTransitos.Open;
end;

procedure TTransitosEnvList_MD.DataModuleDestroy(Sender: TObject);
begin
  kbmTransitos.Close;
end;

procedure TTransitosEnvList_MD.CargaQuery( const AEmpresa, ASalida, ADestino, AProducto, AAgrupacion: string;
                                           const AFechainicio, AFechafin: TDateTime; const AFechaSalida: boolean );
begin
  sEmpresa:= AEmpresa;

  with QTransitos do
  begin
    SQL.Clear;
    SQL.Add(' select producto_tl,  categoria_tl, envase_tl, sum( cajas_tl ) cajas_tl, sum(kilos_tl)  kilos_tl ');
    SQL.Add(' from frf_transitos_c ');
    SQL.Add('      join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
    SQL.Add('                           and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
    SQL.Add(' where empresa_tc = :empresa ');

    if ASalida <> '' then
      SQL.Add(' and centro_tc = :salida ');
    if AProducto <> '' then
      SQL.Add(' and producto_tl = :producto ');
    if ADestino <> '' then
      SQL.Add(' and centro_destino_tl = :destino ');
    if AAgrupacion <> '' then
      SQL.Add(' and producto_tl in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');
    if AFechaSalida then
      SQL.Add(' and fecha_tc between :fechaini and :fechafin ')
    else
      SQL.Add(' and nvl(fecha_entrada_tc, fecha_tc) between :fechaini and :fechafin ');


    SQL.Add(' group by producto_tl,  categoria_tl, envase_tl ');
    SQL.Add(' order by producto_tl,  categoria_tl, envase_tl ');

    ParamByName('empresa').AsString:= AEmpresa;
    if ASalida <> '' then
      ParamByName('salida').AsString:= ASalida;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AAgrupacion <> '' then
      ParamByName('agrupacion').AsString := AAgrupacion;
    if ADestino <> '' then
      ParamByName('destino').AsString:= ADestino;
    ParamByName('fechaini').AsDate:= AFechaInicio;
    ParamByName('fechafin').AsDate:= AFechaFin;
  end;
end;

procedure TTransitosEnvList_MD.AnyadeLinea;
begin
  with kbmTransitos do
  begin
    Insert;
    FieldByName('producto').AsString:= QTransitos.FieldByName('producto_tl').AsString;
    FieldByName('categoria').AsString:= QTransitos.FieldByName('categoria_tl').AsString;
    FieldByName('envase').AsString:= QTransitos.FieldByName('envase_tl').AsString;
    FieldByName('desProducto').AsString:= desProducto( sEmpresa, QTransitos.FieldByName('producto_tl').AsString );
    FieldByName('desEnvase').AsString:= desEnvase( sEmpresa, QTransitos.FieldByName('envase_tl').AsString );
    FieldByName('cajas').AsInteger:= QTransitos.FieldByName('cajas_tl').AsInteger;
    FieldByName('kilos').AsFloat:= QTransitos.FieldByName('kilos_tl').AsFloat;
    Post;
  end;
end;

procedure TTransitosEnvList_MD.CreaListado;
begin
  kbmTransitos.Close;
  kbmTransitos.Open;

  with QTransitos do
  begin
    Open;
    while not EOF do
    begin
      AnyadeLinea;
      Next;
    end;
    Close;
  end;
end;

end.


