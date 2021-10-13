unit EntregasPendientesMasetDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLEntregasPendientesMaset = class(TDataModule)
    QEntregasPendientes: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure DesPreparaQuery;
    procedure PreparaQueryEntregasPendientes( const AEmpresa, AProducto,  AFechaIni, AFechaFin: string;
                                              const AAnyoSemana, AEstadoEntrega, AEstadoFecha: Integer );
  public
    { Public declarations }
    function  DatosQueryEntregasPendientes( const AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin: string;
                                            const AAnyoSemana, AEstadoEntrega, AEstadoFecha: Integer ): boolean;
  end;

implementation

{$R *.dfm}

procedure TDLEntregasPendientesMaset.DesPreparaQuery;
begin
  QEntregasPendientes.Close;
  if QEntregasPendientes.Prepared then
    QEntregasPendientes.UnPrepare;
end;

procedure TDLEntregasPendientesMaset.PreparaQueryEntregasPendientes( const AEmpresa, AProducto, AFechaIni, AFechaFin: string;
                                                                     const AAnyoSemana, AEstadoEntrega, AEstadoFecha: Integer );
begin
  DesPreparaQuery;
  with QEntregasPendientes do
  begin
    SQL.Clear;

    SQL.Add(' select codigo_ec entrega, fecha_llegada_ec fecha_llegada, ');
    SQL.Add('        fecha_carga_ec fecha_carga, adjudicacion_ec factura_conduce, ');
    SQL.Add('        (select nombre_pa from frf_proveedores_almacen ');
    SQL.Add('          where proveedor_pa = proveedor_el ');
    SQL.Add('            and almacen_pa = almacen_el ) nombre_p, ');
    SQL.Add('        transporte_ec transporte, vehiculo_ec matricula, ');
    SQL.Add('        descripcion_breve_pp descripcion, producto_el producto, ');
    SQL.Add('        categoria_el categoria, calibre_el calibre, pais_origen_pp pais, ');
    SQL.Add('        proveedor_ec proveedor, almacen_el almacen, variedad_el variedad,  ');
    SQL.Add('        anyo_semana_ec albaran, aduana_ec puerto, ');
    SQL.Add('        sum(palets_el) palets, sum(kilos_el) peso, sum(cajas_el) cajas  ');

    SQL.Add(' from frf_entregas_c, frf_entregas_l, frf_productos_proveedor  ');
    SQL.Add(' where empresa_ec = :empresa  ');
    SQL.Add(' and centro_llegada_ec = :centro  ');
    //0:CREADA
    //1:EN EL ALMACEN (recibir)
    //2:FINALIZAR DESCARGA
    //3:EN LA CENTRAL (enviar)
    case AEstadoEntrega of
      0: SQL.Add(' and nvl(status_ec,0) < 2  ');
      1: SQL.Add(' and nvl(status_ec,0) = 2  ');
    end;
    case AEstadoFecha of
      0: SQL.Add(' and nvl(fecha_llegada_definitiva_ec,0) = 1  ');
      1: SQL.Add(' and nvl(fecha_llegada_definitiva_ec,0) = 0  ');
    end;

    if AFechaIni <> '' then
      SQL.Add(' and fecha_llegada_ec >= :fechaini ');
    if AFechaFin <> '' then
      SQL.Add(' and fecha_llegada_ec <= :fechafin ');

    if AAnyoSemana <> -1 then
    begin
      SQL.Add(' and anyo_semana_ec = :semana  ');
    end;

    SQL.Add(' and codigo_el = codigo_ec  ');
    if AProducto <> '' then
      SQL.Add(' and producto_el = :producto  ');

    SQL.Add(' and proveedor_pp = proveedor_el ');
    SQL.Add(' and producto_pp = producto_el ');
    SQL.Add(' and variedad_pp = variedad_el ');

    SQL.Add(' GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17 ');
    //SQL.Add(' order by producto, proveedor, variedad, calibre, entrega, fecha_llegada  ');

    if ( (AProducto = 'PLA' ) or ( AProducto = '' ) ) and ( ( AEmpresa = '037' ) or ( AEmpresa = 'F17' ) or ( AEmpresa = 'F23' ) or  ( AEmpresa = 'F24' ) ) then
      SQL.Add(' order by producto, albaran, fecha_llegada, nombre_p, descripcion, entrega')
    else
      SQL.Add(' order by producto, fecha_llegada, nombre_p, descripcion, entrega ');
    Prepare;
  end;
end;

procedure TDLEntregasPendientesMaset.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuery;
end;

function TDLEntregasPendientesMaset.DatosQueryEntregasPendientes( const AEmpresa, ACentro, Aproducto, AFechaIni, AFechaFin: string;
                                                                  const AAnyoSemana, AEstadoEntrega, AEstadoFecha: Integer ): boolean;
begin
  PreparaQueryEntregasPendientes( AEmpresa, AProducto, AFechaIni, AFechaFin, AAnyoSemana, AEstadoEntrega, AEstadoFecha );
  with QEntregasPendientes do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    if AProducto  <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AAnyoSemana <>  -1 then
      ParamByName('semana').AsInteger:= AAnyoSemana;
    if AFechaIni <> '' then
      ParamByName('fechaini').AsDateTime:= StrToDate( AFechaIni );
    if AFechaFin <> '' then
      ParamByName('fechafin').AsDateTime:= StrToDate( AFechaFin );
    Open;
    result:= not IsEmpty;
  end;
end;

end.
