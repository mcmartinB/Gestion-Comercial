unit ListEntregasSinAsociarDL;

interface

uses
  SysUtils, Classes, DBTables, DB, EntregasCB;

const
  kDepurarQuery = False;

type
  RListEntregasSinAsociar = record
    sEmpresa: String;
    sProveedor: String;
    sAlmacen: String;
    sProducto: String;
    dFechaDesde: TDateTime;
    dFechaHasta: TDateTime;
  end;

  TDLListEntregasSinAsociar = class(TDataModule)
    QListEntregasSinAsociar: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ObtenerDatos( AParametros: RListEntregasSinAsociar );
  end;


procedure LoadModule( APadre: TComponent );
procedure UnloadModule;
function  OpenData( APadre: TComponent; AParametros: RListEntregasSinAsociar ): integer;

implementation

uses bMath;

{$R *.dfm}

var
  DLListEntregasSinAsociar: TDLListEntregasSinAsociar;
  iContadorUso: integer = 0;

procedure LoadModule( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      DLListEntregasSinAsociar:= TDLListEntregasSinAsociar.Create( APadre );
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
      if DLListEntregasSinAsociar <> nil then
      begin
        FreeAndNil( DLListEntregasSinAsociar );
      end;
    end;
  end;
end;

function OpenData( APadre: TComponent; AParametros: RListEntregasSinAsociar ): integer;
begin
  LoadModule( APadre );
  DLListEntregasSinAsociar.ObtenerDatos( AParametros );
  result:= DLListEntregasSinAsociar.QListEntregasSinAsociar.RecordCount;
  UnLoadModule;
end;

function GetTextoSQL( AParametros: RListEntregasSinAsociar ): String;
var
  sCadena: TStringList;
begin
  sCadena:= TStringList.Create;

  sCadena.Add( ' select empresa_ec, proveedor_ec, almacen_ec, fecha_origen_ec, albaran_ec, fecha_llegada_ec, vehiculo_ec, codigo_ec ');
  sCadena.Add( ' from frf_entregas_c, frf_entregas_l ');
  sCadena.Add( ' where empresa_ec = ' + QuotedStr( AParametros.sEmpresa ) + ' ');
  if Trim( AParametros.sProveedor ) <> '' then
  begin
    sCadena.Add( '   and proveedor_ec = ' + QuotedStr( AParametros.sProveedor ) + ' ');
    if Trim( AParametros.sAlmacen ) <> '' then
    begin
      sCadena.Add( '   and almacen_ec = ' + AParametros.sAlmacen + ' ');
    end;
  end;
  sCadena.Add( '   and fecha_origen_ec between :fechaini and :fechafin ');
  sCadena.Add( '   and codigo_el = codigo_ec ');
  if Trim( AParametros.sProducto ) <> '' then
  begin
    sCadena.Add( '   and empresa_el = ' + QuotedStr( AParametros.sEmpresa ) + ' ');
    sCadena.Add( '   and producto_el = ' + QuotedStr( AParametros.sProducto ) + ' ');
  end;
  sCadena.Add( '   and not exists ');
  sCadena.Add( '    ( ');
  sCadena.Add( '     select * from frf_entregas_rel ');
  sCadena.Add( '     where codigo_er = codigo_ec ');
  sCadena.Add( '    ) ');
  sCadena.Add( ' group by empresa_ec, proveedor_ec, almacen_ec, fecha_origen_ec, albaran_ec, fecha_llegada_ec, vehiculo_ec, codigo_ec ');
  sCadena.Add( ' order by proveedor_ec, fecha_origen_ec, albaran_ec ');

  result:= sCadena.Text;
  FreeAndNil( sCadena );
end;

procedure TDLListEntregasSinAsociar.ObtenerDatos( AParametros: RListEntregasSinAsociar );
begin
  QListEntregasSinAsociar.Close;
  QListEntregasSinAsociar.SQL.Clear;
  QListEntregasSinAsociar.SQL.Text:= GetTextoSQL( AParametros );
  QListEntregasSinAsociar.ParamByName('fechaini').AsDate:= AParametros.dFechaDesde;
  QListEntregasSinAsociar.ParamByName('fechafin').AsDate:= AParametros.dFechaHasta;
  QListEntregasSinAsociar.Open;
end;

end.
