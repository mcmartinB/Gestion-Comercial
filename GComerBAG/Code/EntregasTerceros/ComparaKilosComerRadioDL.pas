unit ComparaKilosComerRadioDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLComparaKilosComerRadio = class(TDataModule)
    QDiferencias: TQuery;

  private
    { Private declarations }

  public
    { Public declarations }
    procedure DatosEntrega( const AEntrega, AProducto, AProveedor: string;
                       const ADifCajas, ADifUnidades, ADifKilos: Boolean;
                       const AStock: integer;
                       const AOrdenProducto, ADesglosarCalibre: Boolean );
  end;

function ObtenerDatos( const AOwner: TComponent;
                       const AEntrega, AProducto, AProveedor: string;
                       var   AEmpresa, ACentro: string;
                       var   AFechaIni, AFechaFin: TDateTime;
                       const ADifCajas, ADifUnidades, ADifKilos: Boolean;
                       const AStock: integer;
                       const AOrdenProducto, ADesglosarCalibre: Boolean ): Boolean;
procedure CerrarTablas;

var
  DLComparaKilosComerRadio: TDLComparaKilosComerRadio;

implementation

{$R *.dfm}

uses variants, bMath;

function ObtenerDatos( const AOwner: TComponent;
                       const AEntrega, AProducto, AProveedor: string;
                       var   AEmpresa, ACentro: string;
                       var   AFechaIni, AFechaFin: TDateTime;
                       const ADifCajas, ADifUnidades, ADifKilos: Boolean;
                       const AStock: integer;
                       const AOrdenProducto, ADesglosarCalibre: Boolean ): Boolean;
begin
  DLComparaKilosComerRadio:= TDLComparaKilosComerRadio.Create( AOwner );
  with DLComparaKilosComerRadio do
  begin
    DatosEntrega( AEntrega, AProducto, AProveedor, ADifCajas, ADifUnidades, ADifKilos, AStock, AOrdenProducto, ADesglosarCalibre );

    if AEntrega <> '' then
    begin
      QDiferencias.ParamByName('entrega').AsString:= AEntrega;
    end
    else
    begin
      QDiferencias.ParamByName('empresa').AsString:= AEmpresa;
      QDiferencias.ParamByName('centro').AsString:= ACentro;
      QDiferencias.ParamByName('fechaini').AsDateTime:= AFechaIni;
      QDiferencias.ParamByName('fechaFin').AsDateTime:= AFechaFin;
      if AProveedor <> '' then
        QDiferencias.ParamByName('proveedor').AsString:= AProveedor;
    end;

    if AProducto <> '' then
      QDiferencias.ParamByName('producto').AsString:= AProducto;

    QDiferencias.Open;
    result:= not QDiferencias.IsEmpty;
    if result and ( AEntrega <> '' ) then
    begin
      AEmpresa:= QDiferencias.FieldByName('empresa_ec').AsString;
      ACentro:= QDiferencias.FieldByName('centro_llegada_ec').AsString;
      AFechaIni:= QDiferencias.FieldByName('fecha_llegada_ec').AsDateTime;
      AFechaFin:= AFechaIni;
    end;
  end;
end;

procedure CerrarTablas;
begin
  DLComparaKilosComerRadio.QDiferencias.Close;
  FreeAndNil( DLComparaKilosComerRadio );
end;

procedure TDLComparaKilosComerRadio.DatosEntrega( const AEntrega, AProducto, AProveedor: string;
                                             const ADifCajas, ADifUnidades, ADifKilos: Boolean;
                                             const AStock: integer;
                                             const AOrdenProducto, ADesglosarCalibre: Boolean );
var
  bFlag: boolean;
begin
  with QDiferencias do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ec, centro_llegada_ec, fecha_llegada_ec, proveedor_ec, ');
    SQL.Add('        codigo_ec, producto_el, vehiculo_ec, albaran_ec, ');
    if ADesglosarCalibre then
    begin
      SQL.Add('        variedad_el, calibre_el, ');
    end;
  //-->> stock_rf
    SQL.Add('        nvl( ( select sum(peso) from rf_palet_pb ');
    SQL.Add('                where entrega = codigo_ec ');
    SQL.Add('                  and producto = producto_el ');
    if ADesglosarCalibre then
    begin
      SQL.Add('                  and variedad = variedad_el ');
      SQL.Add('                  and calibre = calibre_el ');
    end;
    SQL.Add('                  and status = ''S''), 0) stock_rf, ');

  //-->> cajas_rf, cajas_comer
    SQL.Add('        nvl( ( select sum(cajas) from rf_palet_pb ');
    SQL.Add('                where entrega = codigo_ec ');
    SQL.Add('                  and producto = producto_el ');
    if ADesglosarCalibre then
    begin
      SQL.Add('                  and variedad = variedad_el ');
      SQL.Add('                  and calibre = calibre_el ');
    end;
    SQL.Add('           and status <> ''B''), 0) cajas_rf, ');
    SQL.Add('        sum(cajas_el) cajas_comer, ');

  //-->> kilos_rf, kilos_comer
    SQL.Add('        nvl( ( select sum(peso) from rf_palet_pb ');
    SQL.Add('                where entrega = codigo_ec ');
    SQL.Add('                  and producto = producto_el ');
    if ADesglosarCalibre then
    begin
      SQL.Add('                  and variedad = variedad_el ');
      SQL.Add('                  and calibre = calibre_el ');
    end;
    SQL.Add('                  and status <> ''B''), 0) kilos_rf, ');
    SQL.Add('        sum(kilos_el) kilos_comer, ');

  // -->> unidades_rf, unidades_comer
    SQL.Add('        nvl( (select ');
    SQL.Add('                    sum( case when producto in (''PIN'',''COC'')  ');
    SQL.Add('                         then ( ');
    SQL.Add('                                case when ( case when calibre[1,1] = ''C'' ');
    SQL.Add('                                                      then substr(calibre,2,length( calibre )) ');
    SQL.Add('                                                 else calibre ');
    SQL.Add('                                            end  ) MATCHES ''[0-9]'' OR ');
    SQL.Add('                                          ( case when calibre[1,1] MATCHES ''[A-Z]'' ');
    SQL.Add('                                                      then substr(calibre,2,length( calibre )) ');
    SQL.Add('                                                 else calibre ');
    SQL.Add('                                            end ) MATCHES ''[0-9][0-9]'' or ');
    SQL.Add('                                          ( case when calibre[1,1] MATCHES ''[A-Z]'' ');
    SQL.Add('                                                      then substr(calibre,2,length( calibre )) ');
    SQL.Add('                                                 else calibre ');
    SQL.Add('                                            end ) MATCHES ''[0-9][0-9][0-9]'' ');
    SQL.Add('                                          then  cast( case when calibre[1,1] MATCHES ''[A-Z]'' ');
    SQL.Add('                                                                then substr(calibre,2,length( calibre )) ');
    SQL.Add('                                                           else calibre ');
    SQL.Add('                                                      end as int ) ');
    SQL.Add('                                     else 0 ');
    SQL.Add('                                end ');
    SQL.Add('                              ) ');
    SQL.Add('                    else 0 ');
    SQL.Add('               end * cajas ) ');

    SQL.Add('        from rf_palet_pb ');
    SQL.Add('        where entrega = codigo_ec ');
    SQL.Add('        and producto = producto_el ');
    if ADesglosarCalibre then
    begin
      SQL.Add('                  and variedad = variedad_el ');
      SQL.Add('                  and calibre = calibre_el ');
    end;
    SQL.Add('        and status <> ''B''), 0) unidades_rf, ');
    SQL.Add('        sum(unidades_el) unidades_comer ');

    SQL.Add(' from frf_entregas_c, frf_entregas_l ');

    if AEntrega <> '' then
    begin
      SQL.Add(' where codigo_ec = :entrega ');
    end
    else
    begin
      SQL.Add(' where empresa_ec = :empresa ');
      SQL.Add(' and fecha_llegada_ec between :fechaini and :fechafin ');
      SQL.Add(' and centro_llegada_ec = :centro ');
      if AProveedor <> '' then
      begin
        SQL.Add(' and proveedor_ec = :proveedor ');
      end;
    end;

    SQL.Add(' and codigo_el = codigo_ec ');
    if AProducto <> '' then
    begin
      SQL.Add(' and producto_el = :producto ');
    end;

    case AStock of
      1:
      begin
        SQL.Add(' and ( nvl( ( select sum(peso) from rf_palet_pb ');
        SQL.Add('               where entrega = codigo_ec ');
        SQL.Add('                 and producto = producto_el ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                 and variedad = variedad_el ');
          SQL.Add('                 and calibre = calibre_el ');
        end;
        SQL.Add('                 and status = ''S''), 0) <> 0 ) ');
      end;
      2:
      begin
        SQL.Add(' and ( nvl( ( select sum(peso) from rf_palet_pb ');
        SQL.Add('               where entrega = codigo_ec ');
        SQL.Add('                 and producto = producto_el ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                 and variedad = variedad_el ');
          SQL.Add('                 and calibre = calibre_el ');
        end;
        SQL.Add('                 and status = ''S''), 0) = 0 ) ');
      end;
    end;

    SQL.Add(' group by  empresa_ec, centro_llegada_ec, fecha_llegada_ec, proveedor_ec,');
    SQL.Add('           codigo_ec, producto_el, vehiculo_ec, albaran_ec ');
    if ADesglosarCalibre then
    begin
      SQL.Add('           , variedad_el, calibre_el ');
    end;

    if ADifCajas or ADifUnidades or ADifKilos then
    begin
      bFlag:= false;
      SQL.Add(' having ');
      if ADifCajas then
      begin
        bFlag:= True;
        SQL.Add('        ( nvl( ( select sum(cajas) from rf_palet_pb ');
        SQL.Add('                  where entrega = codigo_ec ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                   and variedad = variedad_el ');
          SQL.Add('                   and calibre = calibre_el ');
        end;
        SQL.Add('                     and status <> ''B'' ), 0) <> sum(cajas_el) ) ');
      end;
      if ADifKilos then
      begin
        if bFlag then
          SQL.Add('        OR');
        SQL.Add('        ( nvl( ( select sum(peso) from rf_palet_pb ');
        SQL.Add('                  where entrega = codigo_ec ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                   and variedad = variedad_el ');
          SQL.Add('                   and calibre = calibre_el ');
        end;
        SQL.Add('                     and status <> ''B'' ), 0) <> sum(kilos_el) ) ');
        bFlag:= True;
      end;
      if ADifUnidades then
      begin
        if bFlag then
          SQL.Add('        OR');
        SQL.Add('        ( nvl( (select ');
        SQL.Add('                    sum( case when producto in (''PIN'',''COC'')  ');
        SQL.Add('                         then ( ');
        SQL.Add('                                case when ( case when calibre[1,1] = ''C'' ');
        SQL.Add('                                                      then substr(calibre,2,length( calibre )) ');
        SQL.Add('                                                 else calibre ');
        SQL.Add('                                            end  ) MATCHES ''[0-9]'' OR ');
        SQL.Add('                                          ( case when calibre[1,1] MATCHES ''[A-Z]'' ');
        SQL.Add('                                                      then substr(calibre,2,length( calibre )) ');
        SQL.Add('                                                 else calibre ');
        SQL.Add('                                            end ) MATCHES ''[0-9][0-9]'' or ');
        SQL.Add('                                          ( case when calibre[1,1] MATCHES ''[A-Z]'' ');
        SQL.Add('                                                      then substr(calibre,2,length( calibre )) ');
        SQL.Add('                                                 else calibre ');
        SQL.Add('                                            end ) MATCHES ''[0-9][0-9][0-9]'' ');
        SQL.Add('                                          then  cast( case when calibre[1,1] MATCHES ''[A-Z]'' ');
        SQL.Add('                                                                then substr(calibre,2,length( calibre )) ');
        SQL.Add('                                                           else calibre ');
        SQL.Add('                                                      end as int ) ');
        SQL.Add('                                     else 0 ');
        SQL.Add('                                end ');
        SQL.Add('                              ) ');
        SQL.Add('                    else 0 ');
        SQL.Add('               end * cajas ) ');

        SQL.Add('        from rf_palet_pb ');
        SQL.Add('        where entrega = codigo_ec ');
        SQL.Add('        and producto = producto_el ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                  and variedad = variedad_el ');
          SQL.Add('                  and calibre = calibre_el ');
        end;
        SQL.Add('        and status <> ''B''), 0) <> sum(unidades_el) ) ');
        bFlag:= True;
      end;
    end;

    if AOrdenProducto then
      SQL.Add(' order by producto_el, proveedor_ec, codigo_ec  ')
    else
      SQL.Add(' order by proveedor_ec, producto_el, codigo_ec  ');
  end;
end;


end.
