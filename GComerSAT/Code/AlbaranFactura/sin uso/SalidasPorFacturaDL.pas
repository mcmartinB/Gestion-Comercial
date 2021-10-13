unit SalidasPorFacturaDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLSalidasPorFactura = class(TDataModule)
    QSalidasPorFactura: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure DesPreparaQuery;
    procedure PreparaQuerySalidasPorFactura(
      const ACentro, ACliente, AProducto, AFechaIni, AFechaFin: string;
      const AAgrupar, AVisualizar: integer );
  public
    { Public declarations }
    function  DatosQuerySalidasPorFactura(
      const AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin: string;
      const AAgrupar, AVisualizar: integer ): boolean;
  end;

implementation

{$R *.dfm}

procedure TDLSalidasPorFactura.DesPreparaQuery;
begin
  QSalidasPorFactura.Close;
  if QSalidasPorFactura.Prepared then
    QSalidasPorFactura.UnPrepare;
end;

procedure TDLSalidasPorFactura.PreparaQuerySalidasPorFactura(
  const ACentro, ACliente, Aproducto, AFechaIni, AFechaFin: string;
  const AAgrupar, AVisualizar: integer );
begin
  DesPreparaQuery;
  with QSalidasPorFactura do
  begin
    SQL.Clear;

    if ( AVisualizar = 0 ) or ( AVisualizar = 1 ) then
    begin

    SQL.Add(' select fecha_factura_sc fecha_factura, n_factura_sc factura, cliente_fac_sc cliente, producto_sl producto, ');
    SQL.Add('        sum(kilos_sl) kilos, sum( importe_neto_sl ) neto ');
    (*
    SQL.Add('        sum(kilos_sl) kilos, sum( importe_neto_sl ) neto_antes_iva, ');
    SQL.Add('        round( sum( importe_neto_sl * ( 1 - ( ( select porc_dto_c from frf_clientes ');
    SQL.Add('                                         where empresa_c = empresa_sc ');
    SQL.Add('                                           and cliente_c = cliente_fac_scv
    SQL.Add('                                        ) / 100 ');
    SQL.Add('                                     ) ');
    SQL.Add('                               ) ');
    SQL.Add('                  ), 2 ');
    SQL.Add('              ) neto_con_descuento ');
    *)

    SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    if ACentro <> '' then
      SQL.Add(' and centro_salida_sc = :centro ');
    if AFechaIni <> '' then
      SQL.Add(' and fecha_factura_sc >= :fechaini ');
    if AFechaFin <> '' then
      SQL.Add(' and fecha_factura_sc <= :fechafin ');
    if Acliente <> '' then
      SQL.Add(' and cliente_fac_sc = :cliente ');

    SQL.Add(' and empresa_sl = :empresa ');
    if ACentro <> '' then
      SQL.Add(' and centro_salida_sl = :centro ')
    else
      SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    if AProducto <> '' then
      SQL.Add(' and producto_sl = :producto ');

    SQL.Add(' group by fecha_factura_sc, n_factura_sc, cliente_fac_sc, producto_sl');

    end;

    if ( AVisualizar = 0 )  then
    begin
      SQL.Add(' UNION ');
    end;

    if ( AVisualizar = 0 ) or ( AVisualizar = 2 ) then
    begin

    SQL.Add(' select fecha_fal fecha_factura, factura_fal factura, cliente_fac_f cliente, ');
    SQL.Add('        producto_fal producto, ');
    SQL.Add('        sum( case when unidad_fal = ''KGS'' then unidades_fal ');
    SQL.Add('             when unidad_fal = ''CAJ'' then unidades_fal * peso_neto_e ');
    SQL.Add('             when unidad_fal = ''UND'' and unidades_e <> 0 then ( unidades_fal / unidades_e ) * peso_neto_e ');
    SQL.Add('             else null end ) kilos, ');
    SQL.Add('        sum(importe_fal) neto ');
    SQL.Add(' from frf_fac_abonos_l, frf_facturas, frf_envases ');

    SQL.Add(' where empresa_fal = :empresa ');
    if AFechaIni <> '' then
      SQL.Add('   and fecha_fal >= :fechaini ');
    if AFechaFin <> '' then
      SQL.Add('   and fecha_fal <= :fechafin ');
    if ACentro <> '' then
      SQL.Add('   and centro_salida_fal = :centro ');
    if AProducto <> '' then
      SQL.Add('   and producto_fal = :producto ');
    if Acliente <> '' then
      SQL.Add('   and cliente_fac_f = :cliente ');

    SQL.Add('   and empresa_f = :empresa ');
    SQL.Add('   and fecha_factura_f = fecha_fal ');
    SQL.Add('   and n_factura_f = factura_fal ');

    SQL.Add('   and empresa_e = :empresa ');
    SQL.Add('   and envase_e = envase_fal ');
    SQL.Add('   and producto_base_e = ( ');
    SQL.Add('       select producto_base_p from frf_productos ');
    SQL.Add('       where empresa_p = :empresa and producto_p = producto_fal ) ');

    SQL.Add(' group by fecha_fal, factura_fal, cliente_fac_f, producto_fal ');

    end;

    case  AAgrupar of
      0: SQL.Add(' order by 1, 2, 3, 4  ');
      1: SQL.Add(' order by 3, 1, 2, 4  ');
      2: SQL.Add(' order by 4, 1, 2, 3  ');
    end;


    try
      Prepare;
    except
      raise;
    end;
  end;
end;

procedure TDLSalidasPorFactura.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuery;
end;

function TDLSalidasPorFactura.DatosQuerySalidasPorFactura(
  const AEmpresa, ACentro, ACliente, AProducto, AFechaIni, AFechaFin: string;
  const AAgrupar, AVisualizar: integer ): boolean;
begin
  PreparaQuerySalidasPorFactura( ACentro, ACliente, AProducto, AFechaIni, AFechaFin, AAgrupar, AVisualizar );
  with QSalidasPorFactura do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if AFechaIni <> '' then
      ParamByName('fechaini').AsDateTime:= StrToDate( AFechaIni );
    if AFechaFin <> '' then
      ParamByName('fechafin').AsDateTime:= StrToDate( AFechaFin );
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    Open;
    result:= not IsEmpty;
  end;
end;

end.
