unit ConfirmaRecepcionDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLConfirmaRecepcion = class(TDataModule)
    QListadoServido: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure PreparaQuery( const APedido: string; const AAlbaran: Integer );
  public
    { Public declarations }
    function  DatosQueryServido( const AEmpresa, ACliente, APedido: string;
                               const AAlbaran: Integer;
                               const AFechaIni, AFechaFin: TDateTime ): boolean;
  end;

implementation

{$R *.dfm}

procedure TDLConfirmaRecepcion.PreparaQuery( const APedido: string; const AAlbaran: Integer );
begin
  with QListadoServido do
  begin
    SQL.Clear;
    SQL.Add(' select  ');
    SQL.Add('        n_albaran_sc albaran, n_pedido_sc pedido, fecha_sc fecha, dir_sum_sc, ');
    (*PRODBASE*)
    SQL.Add('        ( select ean13_ee from frf_ean13_edi ');
    SQL.Add('          where empresa_ee = :empresa  and cliente_fac_ee = :cliente and envase_ee = envase_sl  ');
    SQL.Add('    and producto_ee = producto_sl ) codigo,');

    SQL.Add('        nvl( ( select descripcion_ce from frf_clientes_env ');
    SQL.Add('          where empresa_ce = :empresa and cliente_ce = :cliente ');
    SQL.Add('            and envase_ce = envase_sl and producto_ce = producto_sl ), ');
    (*PRODBASE*)
    SQL.Add('           ( select descripcion_ee from frf_ean13_edi ');
    SQL.Add('             where empresa_ee = :empresa  and cliente_fac_ee = :cliente and envase_ee = envase_sl    ');
    SQL.Add('    and producto_ee = producto_sl) )descripcion, ');

    SQL.Add('        nvl( ( select unidad_fac_ce from frf_clientes_env ');
    SQL.Add('          where empresa_ce = :empresa and cliente_ce = :cliente ');
    SQL.Add('            and envase_ce = envase_sl and producto_ce = producto_sl ), ''K'' ) unidad_factura, ');

    SQL.Add('        cajas_sl cajas, ');
    SQL.Add('        cajas_sl * unidades_caja_sl unidades, ');
    SQL.Add('        kilos_sl kilos ');

    SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and fecha_sc between :fechaini and :fechafin ');
    SQL.Add(' and cliente_fac_sc = :cliente ');

    if APedido <> '' then
      SQL.Add(' and n_pedido_sc = :pedido ');
    if AAlbaran <> -1 then
      SQL.Add(' and n_albaran_sl = :albaran ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    SQL.Add(' and fecha_sl = fecha_sc ');

    SQL.Add(' order by n_albaran_sc, fecha_sc, n_pedido_sc ');
  end;
end;


procedure TDLConfirmaRecepcion.DataModuleDestroy(Sender: TObject);
begin
  QListadoServido.Close;
end;

function  TDLConfirmaRecepcion.DatosQueryServido( const AEmpresa, ACliente, APedido: string;
                               const AAlbaran: Integer; const AFechaIni, AFechaFin: TDateTime ): boolean;
begin
  PreparaQuery( APedido, AAlbaran );
  with QListadoServido do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('fechaini').AsDate:= AFechaIni;
    ParamByName('fechafin').AsDate:= AFechaFin;

    if APedido <> '' then
      ParamByName('pedido').AsString:= APedido;
    if AAlbaran <> -1 then
      ParamByName('albaran').AsInteger:= AAlbaran;

    Open;
    result:= not IsEmpty;
  end;
end;

end.
