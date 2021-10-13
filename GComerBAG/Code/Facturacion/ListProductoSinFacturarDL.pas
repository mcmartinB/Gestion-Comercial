unit ListProductoSinFacturarDL;

interface

uses
  SysUtils, Classes, DBTables, DB, EntregasCB;

const
  kDepurarQuery = False;

type
  RParametrosListProductoSinFacturar = record
    sEmpresa: String;
    sProducto: String;
    dFechaHasta: TDateTime;
  end;

  TDLListProductoSinFacturar = class(TDataModule)
    QListProductoSinFacturar: TQuery;
    QListProductoSinFacturarempresa_sc: TStringField;
    QListProductoSinFacturarcentro_salida_sc: TStringField;
    QListProductoSinFacturarn_albaran_sc: TIntegerField;
    QListProductoSinFacturarfecha_sc: TDateField;
    QListProductoSinFacturarkilos_cat1: TFloatField;
    QListProductoSinFacturarkilos_cat2: TFloatField;
    QListProductoSinFacturarkilos_cat3: TFloatField;
    QListProductoSinFacturarkilos_total: TFloatField;
    QListProductoSinFacturarproducto_sl: TStringField;
    QListProductoSinFacturarcliente_sal_sc: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ObtenerDatos( AParametros: RParametrosListProductoSinFacturar );
  end;


procedure LoadModule( APadre: TComponent );
procedure UnloadModule;
function  OpenData( APadre: TComponent; AParametros: RParametrosListProductoSinFacturar ): integer;

implementation

uses bMath;

{$R *.dfm}

var
  DLListProductoSinFacturar: TDLListProductoSinFacturar;
  iContadorUso: integer = 0;

procedure LoadModule( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      DLListProductoSinFacturar:= TDLListProductoSinFacturar.Create( APadre );
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
      if DLListProductoSinFacturar <> nil then
      begin
        FreeAndNil( DLListProductoSinFacturar );
      end;
    end;
  end;
end;

function OpenData( APadre: TComponent; AParametros: RParametrosListProductoSinFacturar ): integer;
begin
  LoadModule( APadre );
  DLListProductoSinFacturar.ObtenerDatos( AParametros );
  result:= DLListProductoSinFacturar.QListProductoSinFacturar.RecordCount;
  UnLoadModule;
end;

function GetTextoSQL( AParametros: RParametrosListProductoSinFacturar ): String;
var
  sCadena: TStringList;
begin
  sCadena:= TStringList.Create;
  sCadena.Add( ' select empresa_sc , producto_sl, cliente_sal_sc, centro_salida_sc, n_albaran_sc, fecha_sc, ' );
  sCadena.Add( '        sum( case when categoria_sl = ''1'' then kilos_sl else 0 end ) kilos_cat1, ' );
  sCadena.Add( '        sum( case when categoria_sl = ''2'' then kilos_sl else 0 end ) kilos_cat2, ' );
  sCadena.Add( '        sum( case when categoria_sl = ''3'' then kilos_sl else 0 end ) kilos_cat3, ' );
  sCadena.Add( '        sum( case when categoria_sl in ( ''1'', ''2'', ''3'' ) then kilos_sl else 0 end ) kilos_total ' );
  sCadena.Add( ' from frf_salidas_c, frf_salidas_l ' );
  sCadena.Add( ' where empresa_sc = ' + QuotedStr( AParametros.sEmpresa ));
  sCadena.Add( ' and fecha_sc <= :fechafin ' );
  sCadena.Add( ' and n_factura_sc is null ' );

  sCadena.Add( ' AND cliente_sal_sc <> "RET" ');
  sCadena.Add( ' AND cliente_sal_sc <> "REA" ');
  sCadena.Add( ' AND cliente_sal_sc <> "EG" ');
  sCadena.Add( ' AND cliente_sal_sc <> "BAA" ');
  sCadena.Add( ' AND cliente_sal_sc <> "GAN" ');    
  sCadena.Add( ' AND cliente_sal_sc[1,1] <> "0" ');


  sCadena.Add( ' and empresa_sl = ' + QuotedStr( AParametros.sEmpresa ));
  sCadena.Add( ' and centro_salida_sl = centro_salida_sc ' );
  sCadena.Add( ' and n_albaran_sl = n_albaran_sc ' );
  sCadena.Add( ' and fecha_sl = fecha_sc ' );
  if Trim( AParametros.sProducto ) <> '' then
    sCadena.Add( ' and producto_sl = ' + QuotedStr( AParametros.sProducto ));
  sCadena.Add( ' and categoria_sl in (''1'',''2'',''3'') ' );
  sCadena.Add( ' group by empresa_sc , producto_sl, cliente_sal_sc, centro_salida_sc, n_albaran_sc, fecha_sc ' );
  sCadena.Add( ' order by empresa_sc , producto_sl, cliente_sal_sc, centro_salida_sc, n_albaran_sc, fecha_sc ' );
  result:= sCadena.Text;
  FreeAndNil( sCadena );
end;

procedure TDLListProductoSinFacturar.ObtenerDatos( AParametros: RParametrosListProductoSinFacturar );
begin
  QListProductoSinFacturar.Close;
  QListProductoSinFacturar.SQL.Clear;
  QListProductoSinFacturar.SQL.Text:= GetTextoSQL( AParametros );
  QListProductoSinFacturar.ParamByName('fechafin').AsDate:= AParametros.dFechaHasta;
  QListProductoSinFacturar.Open;
end;

end.
