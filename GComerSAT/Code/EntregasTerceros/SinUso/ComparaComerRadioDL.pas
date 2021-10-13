unit ComparaComerRadioDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLComparaComerRadio = class(TDataModule)
    QDiferencias: TQuery;

  private
    { Private declarations }

  public
    { Public declarations }
    procedure DatosEntrega( const AEntrega, AProducto: string;
                       const ATipoDif, AStock: integer;
                       const AOrdenProducto, ADesglosarCalibre: Boolean );
  end;

function ObtenerDatos( const AOwner: TComponent;
                       const AEntrega, AProducto: string;
                       var   AEmpresa, ACentro: string;
                       var   AFechaIni, AFechaFin: TDateTime;
                       const ATipoDif, AStock: integer;
                       const AOrdenProducto, ADesglosarCalibre: Boolean ): Boolean;
procedure CerrarTablas;

var
  DLComparaComerRadio: TDLComparaComerRadio;

implementation

{$R *.dfm}

uses variants, bMath;

function ObtenerDatos( const AOwner: TComponent;
                       const AEntrega, AProducto: string;
                       var   AEmpresa, ACentro: string;
                       var   AFechaIni, AFechaFin: TDateTime;
                       const ATipoDif, AStock: integer;
                       const AOrdenProducto, ADesglosarCalibre: Boolean ): Boolean;
begin
  DLComparaComerRadio:= TDLComparaComerRadio.Create( AOwner );
  with DLComparaComerRadio do
  begin
    DatosEntrega( AEntrega, AProducto, ATipoDif, AStock, AOrdenProducto, ADesglosarCalibre );

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
  DLComparaComerRadio.QDiferencias.Close;
  FreeAndNil( DLComparaComerRadio );
end;

procedure TDLComparaComerRadio.DatosEntrega( const AEntrega, AProducto: string;
                                             const ATipoDif, AStock: integer;
                                             const AOrdenProducto, ADesglosarCalibre: Boolean );
begin
  with QDiferencias do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ec, centro_llegada_ec, fecha_llegada_ec, codigo_ec, producto_el, ');
    if ADesglosarCalibre then
    begin
      SQL.Add('        variedad_el, calibre_el, ');
    end;
    SQL.Add('        nvl( ( select sum(peso) from rf_palet_pb ');
    SQL.Add('                where entrega = codigo_ec ');
    SQL.Add('                  and producto = producto_el ');
    if ADesglosarCalibre then
    begin
      SQL.Add('                  and variedad = variedad_el ');
      SQL.Add('                  and calibre = calibre_el ');
    end;      
    SQL.Add('                  and status = ''S''), 0) stock_rf, ');
    SQL.Add('        nvl( ( select sum(cajas) from rf_palet_pb ');
    SQL.Add('                where entrega = codigo_ec ');
    SQL.Add('                  and producto = producto_el ');
    if ADesglosarCalibre then
    begin
      SQL.Add('                  and variedad = variedad_el ');
      SQL.Add('                  and calibre = calibre_el ');
    end;
    SQL.Add('                  and status <> ''B''), 0) cajas_rf, ');
    SQL.Add('        sum(cajas_el) cajas_comer, ');
    SQL.Add('        nvl( ( select sum(peso) from rf_palet_pb ');
    SQL.Add('                where entrega = codigo_ec ');
    SQL.Add('                  and producto = producto_el ');
    if ADesglosarCalibre then
    begin
      SQL.Add('                  and variedad = variedad_el ');
      SQL.Add('                  and calibre = calibre_el ');
    end;
    SQL.Add('                  and status <> ''B''), 0) kilos_rf, ');
    SQL.Add('        sum(kilos_el) kilos_comer ');

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

    SQL.Add(' group by  empresa_ec, centro_llegada_ec, fecha_llegada_ec, codigo_ec, producto_el ');
    if ADesglosarCalibre then
    begin
      SQL.Add('           , variedad_el, calibre_el ');
    end;

    case ATipoDif of
      1:
      begin
        SQL.Add(' having ( nvl( ( select sum(cajas) from rf_palet_pb ');
        SQL.Add('                  where entrega = codigo_ec ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                   and variedad = variedad_el ');
          SQL.Add('                   and calibre = calibre_el ');
        end;
        SQL.Add('                     and status <> ''B'' ), 0) <> sum(cajas_el) ) OR ');
        SQL.Add('        ( nvl( ( select sum(peso) from rf_palet_pb ');
        SQL.Add('                  where entrega = codigo_ec ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                   and variedad = variedad_el ');
          SQL.Add('                   and calibre = calibre_el ');
        end;
        SQL.Add('                     and status <> ''B'' ), 0) <> sum(kilos_el) ) ');
      end;
      2:
      begin
        SQL.Add(' having ( nvl( ( select sum(peso) from rf_palet_pb ');
        SQL.Add('                  where entrega = codigo_ec ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                    and variedad = variedad_el ');
          SQL.Add('                    and calibre = calibre_el ');
        end;
        SQL.Add('                      and status <> ''B'' ), 0) <> sum(kilos_el) ) ');
      end;
      3:
      begin
        SQL.Add(' having ( nvl( ( select sum(cajas) from rf_palet_pb ');
        SQL.Add('                  where entrega = codigo_ec ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                   and variedad = variedad_el ');
          SQL.Add('                   and calibre = calibre_el ');
        end;
        SQL.Add('                     and status <> ''B'' ), 0) <> sum(cajas_el) ) ');
      end;
      4:
      begin
        SQL.Add(' having ( nvl( ( select sum(cajas) from rf_palet_pb ');
        SQL.Add('                  where entrega = codigo_ec ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                    and variedad = variedad_el ');
          SQL.Add('                    and calibre = calibre_el ');
        end;
        SQL.Add('                      and status <> ''B'' ), 0) <> sum(cajas_el) ) AND ');
        SQL.Add('        ( nvl( ( select sum(peso) from rf_palet_pb ');
        SQL.Add('                  where entrega = codigo_ec ');
        if ADesglosarCalibre then
        begin
          SQL.Add('                    and variedad = variedad_el ');
          SQL.Add('                    and calibre = calibre_el ');
        end;
        SQL.Add('                      and status <> ''B'' ), 0) <> sum(kilos_el) ) ');
      end;
    end;
    if AOrdenProducto then
      SQL.Add(' order by producto_el, codigo_ec  ')
    else
      SQL.Add(' order by codigo_ec, producto_el ');
  end;
end;


end.
