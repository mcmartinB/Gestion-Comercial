unit RiesgoClienteDL;

interface

uses
  SysUtils, Classes, FacturacionCB, DB, DBTables;

type
  TDLRiesgoCliente = class(TDataModule)
    QRiesgoCliente: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ObtenerDatos( AParametros: RClienteQL; const AVer: boolean );
  end;

procedure LoadModule( APadre: TComponent );
procedure UnloadModule;
function  OpenData( APadre: TComponent; AParametros: RClienteQL; const AVer: boolean ): integer;


implementation

{$R *.dfm}

uses
  CGlobal;

var
  DLRiesgoCliente: TDLRiesgoCliente;
  iContadorUso: integer = 0;

function GetTextoSQL( AParametros: RClienteQL; const AVer: boolean ): String;
var saux: string;
begin
  begin
    if AParametros.sEmpresa <> '' then
    begin
      if AParametros.sEmpresa = 'BAG' then
        saux := ' where (  cod_empresa_fac_fc[1,1] = ''F'' and cod_empresa_fac_fc <> ''F22'' )' + #13 + #10
      else
      if AParametros.sEmpresa = 'SAT' then
        saux := 'where (  cod_empresa_fac_fc in ( ''050'',''080'' ) )' + #13 + #10
      else
        saux := 'where cod_empresa_fac_fc = ' + QuotedStr( AParametros.sEmpresa ) + #13 + #10;
    end;

    result:= 'select ( select descripcion_p from frf_paises where pais_p = pais_c ) pais,    '+ #13 + #10;
    result:= result + '       cliente_c cliente, nombre_c descripcion,                       '+ #13 + #10;
    if APArametros.sEmpresa = 'BAG' then
      result:= result + ' nvl((select min(max_riesgo_cr) from frf_clientes_rie where cliente_cr = cliente_c and empresa_cr[1] = ''F'' and fecha_fin_cr is null), -1) max_riesgo, '+ #13 + #10
    else
      result:= result + ' nvl((select min(max_riesgo_cr) from frf_clientes_rie where cliente_cr = cliente_c and empresa_cr in (''050'', ''080'') and fecha_fin_cr is null), -1) max_riesgo, '+ #13 + #10;
    if APArametros.sEmpresa = 'BAG' then
      result:= result + ' nvl((select min(case when seguro_cr = 1 then "SI" else "NO" end) from frf_clientes_rie where cliente_cr = cliente_c and empresa_cr[1] = ''F'' and fecha_fin_cr is null), ''-'') seguro, '+ #13 + #10
    else
      result:= result + ' nvl((select min(case when seguro_cr = 1 then "SI" else "NO" end) from frf_clientes_rie where cliente_cr = cliente_c and empresa_cr in (''050'', ''080'') and fecha_fin_cr is null), ''-'') seguro, '+ #13 + #10;
    result:= result + '       ( select sum( importe_total_euros_fc) from tfacturas_cab ' + saux + #13 + #10;
    result := result + '                               and cod_cliente_fc = cliente_c and fecha_factura_fc >= :fecha ) facturado, '+ #13 + #10;
    result:= result + '       ( select sum( euros(moneda_fc, fecha_factura_fc, importe_cobrado_rf) ) '+ #13 + #10;
    result:= result + '         from tfacturas_cab join tremesas_fac on cod_factura_rf = cod_factura_fc '+ saux + #13 + #10;
    result:= result + '                                and cod_cliente_fc = cliente_c and fecha_factura_fc >= :fecha ) cobrado '+ #13 + #10;
    result:= result + 'from frf_clientes ';
    result:= result + ' where 1=1 ';

//    if Aver then
//    begin
//      result:= result + '  and nvl(max_riesgo_c,-1) <> -1 ';
//    end;

    if AParametros.sCliente <> '' then
    begin
      result:= result + '  and cliente_c = ' + QuotedStr( AParametros.sCliente ) + #13 + #10;
    end
    else
    begin
      if AParametros.sPais <> '' then
      begin
        result:= result + '  and pais_c = ' + QuotedStr( AParametros.sPais ) + #13 + #10;

      end;
    end;

    if AParametros.sTipoCliente <> '' then
    begin
      if AParametros.bExcluirTipoCliente then
        result:= result + '  and tipo_cliente_c <> ' + QuotedStr( AParametros.sTipoCliente ) + #13 + #10
      else
        result:= result + '  and tipo_cliente_c = ' + QuotedStr( AParametros.sTipoCliente ) + #13 + #10
    end;

    if AParametros.sNacional <> 'T' then
    begin
      if AParametros.sNacional = 'N' then
        result:= result + '  and pais_c = "ES" ' + #13 + #10
      else
        result:= result + '  and pais_c <> "ES" '+ #13 + #10
    end;

    result:= result + 'order by pais, cliente ';
  end;
end;

procedure LoadModule( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      DLRiesgoCliente:= TDLRiesgoCliente.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
end;

procedure UnloadModule;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if DLRiesgoCliente <> nil then
      begin
        DLRiesgoCliente.QRiesgoCliente.Close;
        FreeAndNil( DLRiesgoCliente );
      end;
    end;
  end;
end;

procedure TDLRiesgoCliente.ObtenerDatos( AParametros: RClienteQL; const AVer: boolean );
begin
  QRiesgoCliente.Close;
  DLRiesgoCliente.QRiesgoCliente.SQL.Text:= GetTextoSQL( AParametros, AVer );
  DLRiesgoCliente.QRiesgoCliente.ParamByName('fecha').AsDateTime:= AParametros.dFechaDesde;
  QRiesgoCliente.Open;
end;

function OpenData( APadre: TComponent; AParametros: RClienteQL; const AVer: boolean ): integer;
begin
  LoadModule( APadre );
  DLRiesgoCliente.ObtenerDatos( AParametros, AVer );
  result:= DLRiesgoCliente.QRiesgoCliente.RecordCount;
  UnLoadModule;
end;


end.
