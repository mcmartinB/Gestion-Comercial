unit DestrioFrutaRFDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLDestrioFrutaRF = class(TDataModule)
    QDestrioFrutaRF: TQuery;

  private
    { Private declarations }

  public
    { Public declarations }
    procedure DatosEntrega( const AEmpresa, AProveedor, AProducto, AVariedad, ACalibre, AEntrega: string;
                            const AFechaIni, AFechaFin: TDateTime  );
  end;

function ObtenerDatos( const AOwner: TComponent;
                       const AEmpresa, AProveedor, AProducto, AVariedad, ACalibre, AEntrega: string;
                       const AFechaIni, AFechaFin: TDateTime  ): boolean;
procedure CerrarTablas;

var
  DLDestrioFrutaRF: TDLDestrioFrutaRF;

implementation

{$R *.dfm}

uses variants, bMath;

function ObtenerDatos( const AOwner: TComponent;
                       const AEmpresa, AProveedor, AProducto, AVariedad, ACalibre, AEntrega: string;
                       const AFechaIni, AFechaFin: TDateTime  ): boolean;
begin
  DLDestrioFrutaRF:= TDLDestrioFrutaRF.Create( AOwner );
  with DLDestrioFrutaRF do
  begin
    DatosEntrega( AEmpresa, AProveedor, AProducto, AVariedad, ACalibre, AEntrega, AFechaIni, AFechaFin );

    QDestrioFrutaRF.ParamByName('empresa').AsString:= AEmpresa;
    QDestrioFrutaRF.ParamByName('fechaini').AsDateTime:= AFechaIni;
    QDestrioFrutaRF.ParamByName('fechaFin').AsDateTime:= AFechaFin;

    if AProveedor <> '' then
      QDestrioFrutaRF.ParamByName('proveedor').AsString:= AProveedor;
    if AProducto <> '' then
      QDestrioFrutaRF.ParamByName('producto').AsString:= AProducto;
    if AVariedad <> '' then
      QDestrioFrutaRF.ParamByName('variedad').AsString:= AVariedad;
    if ACalibre <> '' then
      QDestrioFrutaRF.ParamByName('calibre').AsString:= ACalibre;
    if AEntrega <> '' then
      QDestrioFrutaRF.ParamByName('entrega').AsString:= AEntrega;

    QDestrioFrutaRF.Open;
    result:= not QDestrioFrutaRF.IsEmpty;
  end;
end;

procedure CerrarTablas;
begin
  DLDestrioFrutaRF.QDestrioFrutaRF.Close;
  FreeAndNil( DLDestrioFrutaRF );
end;

procedure TDLDestrioFrutaRF.DatosEntrega( const AEmpresa, AProveedor, AProducto, AVariedad, ACalibre, AEntrega: string;
                                          const AFechaIni, AFechaFin: TDateTime  );
begin
  with QDestrioFrutaRF do
  begin
    SQL.Clear;
    SQL.Add(' select empresa, proveedor, ( select nombre_p from frf_proveedores where proveedor_p = proveedor ) des_proveedor, ');
    SQL.Add('        producto, ( select descripcion_p from frf_productos where producto_p = producto ) des_producto, ');
    SQL.Add('        variedad, ( select descripcion_pp from frf_productos_proveedor where proveedor_pp = proveedor and producto_pp = producto and variedad_pp = variedad  ) des_variedad, ');
    SQL.Add('        entrega, calibre, sum(cajas) cajas, sum(peso) neto ');

    SQL.Add(' from rf_palet_pb ');

    SQL.Add(' where empresa = :empresa ');
    SQL.Add(' and date(fecha_status) between :fechaini and :fechafin ');
    SQL.Add(' and status = ''D'' ');

    if AProveedor <> '' then
      SQL.Add(' and proveedor = :proveedor ');
    if AProducto <> '' then
      SQL.Add(' and producto = :producto ');
    if AVariedad <> '' then
      SQL.Add(' and variedad = :variedad ');
    if ACalibre <> '' then
      SQL.Add(' and calibre = :calibre ');
    if AEntrega <> '' then
      SQL.Add(' and entrega = :entrega ');

    SQL.Add(' group by 1,2,3,4,5,6,7,8,9 ');
    SQL.Add(' order by empresa, producto, proveedor, variedad, entrega, calibre ');
  end;
end;


end.
