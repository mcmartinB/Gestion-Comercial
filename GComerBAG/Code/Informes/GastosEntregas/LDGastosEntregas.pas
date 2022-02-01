unit LDGastosEntregas;

interface

uses
  Forms, SysUtils, Classes, DB, DBTables, QuickRpt, Dialogs, kbmMemTable;

type
  TDLGastosEntregas = class(TDataModule)
    QListado: TQuery;
    QDetalleGasto: TQuery;
    DataSource: TDataSource;
    QDetalleLinea: TQuery;
    qryTabla: TQuery;
    tkbmTablaCSV: TkbmMemTable;
    procedure QListadoAfterOpen(DataSet: TDataSet);
    procedure QListadoBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    bVerDetalle: boolean;
    procedure NuevoRegistro;
  public
    { Public declarations }
    function ObtenerDatosCompletos( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                                         const AFechaIni, AFechaFin, AFechaCorte: TDateTime; const ACorte: Boolean;
                                         const AAgruparProducto: boolean; const ASinGasto: Integer;
                                         const ATipoCodigo, AFacturaGrabada: integer; const AFechaFactura: TDateTime ): boolean;
    (*03/11/2015
    function ObtenerDatosConduce( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                           const AFechaIni, AFechaFin, AFechaCorte: TDateTime; const ACorte: Boolean;
                           const ATipoCodigo, AFacturaGrabada: integer ): boolean;
    *)
    function ObtenerDatosTabla( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                                              const AFechaIni, AFechaFin, AFechaCorte: TDateTime; const ACorte: Boolean;
                                              const AGastoGrabado: Integer; const ATipoCodigo, AFacturaGrabada: integer; const AFechaFactura: TDateTime ): boolean;
    procedure CerrarQuery;
    procedure CrearCSVTabla;
    procedure TablaTemporal;
  end;

var
  DLGastosEntregas: TDLGastosEntregas;

implementation

{$R *.dfm}

function TDLGastosEntregas.ObtenerDatosCompletos( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                                         const AFechaIni, AFechaFin, AFechaCorte: TDateTime; const ACorte: Boolean;
                                         const AAgruparProducto: boolean; const ASinGasto: Integer;
                                         const ATipoCodigo, AFacturaGrabada: integer; const AFechaFactura: TDateTime ): boolean;
var
  sFactura: string;
begin
  if AFacturaGrabada = 1 then
  begin
    sFactura:= '    and nvl(ref_fac_ge,'''') = '''' ';
  end
  else
  if AFacturaGrabada = 2 then
  begin
    sFactura:= '    and nvl(ref_fac_ge,'''') <> '''' ';
  end
  else
  if AFacturaGrabada = 3 then
  begin
    sFactura:= '    and nvl(ref_fac_ge,'''') <> '''' and nvl(fecha_fac_ge,'''') = '''' ';
  end
  else
  if AFacturaGrabada = 4 then
  begin
    sFactura:= '    and nvl(ref_fac_ge,'''') <> '''' and nvl(fecha_fac_ge,'''') <> '''' ';
  end
  else
  if AFacturaGrabada = 5 then
  begin
   sFactura:= '    and ( ( nvl(ref_fac_ge,'''') = '''' ) or ( nvl(fecha_fac_ge,'''') = '''' ) or ( fecha_fac_ge > :fechafac ) ) ';
  end
  else
  begin
    sFactura:= '';
  end;

  bVerDetalle:= True;

  with QDetalleLinea do
  begin
    SQL.Clear;
    SQL.Add('select producto_el, sum(kilos_el) kilos_el, sum(unidades_el) unidades_el, ');
    SQL.Add('       round(sum(kilos_el*precio_kg_el),2) importe_el ');
    //SQL.Add('       sum(kilos_el*precio_kg_el) importe_el ');
    SQL.Add('from frf_entregas_l ');
    SQL.Add('where codigo_el = :codigo_ec ');
    if AProducto <> '' then
    begin
      SQL.Add('and producto_el = :producto ');
    end
    else
    begin
      if AAgruparProducto then
      begin
        SQL.Add('and producto_el = :producto_el ');
      end;
    end;

    SQL.Add('group by producto_el');
    SQL.Add('order by producto_el');
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
  end;

  with QDetalleGasto do
  begin
    SQL.Clear;
    SQL.Add(' select *, ');
    SQL.Add('          ( select sum(kilos_el) ');
    SQL.Add('            from frf_entregas_l ');
    SQL.Add('            where codigo_ge = codigo_el ) kilos_linea_ge, ');
    SQL.Add('          ( select sum(unidades_el) ');
    SQL.Add('            from frf_entregas_l ');
    SQL.Add('            where codigo_ge = codigo_el ) unidades_linea_ge ');
    SQL.Add(' from frf_gastos_entregas ');
//    SQL.Add(' where codigo_ge = :codigo_ec ' + sFactura);
    SQL.Add(' where codigo_ge = :codigo_ec ');
    if AGasto <> '' then
      SQL.Add('and tipo_ge = :gasto ');

    SQL.Add(' order by tipo_ge ');

    ParamByName('codigo_ec').AsString := AEntrega;
    if AGasto <> '' then
      ParamByName('gasto').AsString:= AGasto;
    if AFacturaGrabada = 5 then
      ParamByName('fechafac').AsDate := AFechaFactura;      
  end;

  if AAgruparProducto then
  begin
    with QListado do
    begin
      SQL.Clear;
      SQL.Add('select empresa_ec, proveedor_ec, fecha_llegada_ec fecha, fecha_origen_ec, codigo_ec, adjudicacion_ec, producto_el, ');
      SQL.Add('       ( select count( distinct producto_el ) from frf_entregas_l where codigo_el = codigo_ec ) n_productos_ec, ');
      SQL.Add('       ( select sum(kilos_el) from frf_entregas_l where codigo_el = codigo_ec ) kilos_ec, ');
      SQL.Add('       ( select sum(unidades_el) from frf_entregas_l where codigo_el = codigo_ec ) unidades_ec, ');
      SQL.Add('       ( select round(sum(kilos_el*precio_kg_el),2) from frf_entregas_l where codigo_el = codigo_ec ) importe_ec ');
      SQL.Add('from frf_entregas_c, frf_entregas_l ');

      if AEntrega <> '' then
      begin
        if ATipoCodigo = 0 then
          SQL.Add('where codigo_ec = :entrega ')
        else
          SQL.Add('where adjudicacion_ec = :entrega ');
      end
      else
      begin
        SQL.Add('where fecha_llegada_ec between :fechaini and :fechafin ');
        if ACorte then
          SQL.Add('and fecha_origen_ec < :fechacorte ')
      end;
      SQL.Add('      and codigo_el = codigo_ec ');

      if AEmpresa = 'BAG' then
        SQL.Add('and substr( empresa_ec, 1, 1 ) = ''F'' ')
      else
      if AEmpresa = 'SAT' then
        SQL.Add('and ( empresa_ec = ''050'' or empresa_ec = ''080'' )')
      else
      if AEmpresa <> '' then
        SQL.Add('and empresa_ec = :empresa ');

      if ACentro <> '' then
      begin
        SQL.Add('and centro_llegada_ec = :centro ');
      end;
      if AProveedor <> '' then
        SQL.Add('and TRIM(proveedor_ec) = :proveedor ');
      if AAnyoSemana <> '' then
        SQL.Add('and anyo_semana_ec = :anyosemana ');
      if AProducto <> '' then
      begin
        SQL.Add('and exists ');
        SQL.Add('(');
        SQL.Add('  select * ');
        SQL.Add('  from frf_entregas_l ');
        SQL.Add('  where codigo_el = codigo_ec ');
        SQL.Add('  and producto_el = :producto ');
        SQL.Add(')');
      end;


      if AGasto <> '' then
      begin
        if ( ASinGasto = 0 ) or ( ASinGasto = 2 ) then
        begin
          SQL.Add('and exists ');
          SQL.Add('(');
          SQL.Add('  select * ');
          SQL.Add('  from frf_gastos_entregas ');
          SQL.Add('  where codigo_ge = codigo_ec ');
          if AGasto <> '' then
            SQL.Add('and tipo_ge = :gasto ');
          SQL.Add(')');
        end
        else
        begin
          SQL.Add('and not exists ');
          SQL.Add('(');
          SQL.Add('  select * ');
          SQL.Add('  from frf_gastos_entregas ');
          SQL.Add('  where codigo_ge = codigo_ec ');
          if AGasto <> '' then
            SQL.Add('and tipo_ge = :gasto ');
          SQL.Add(')');
        end;
      end
      else
      begin
        if  ( ASinGasto = 2 ) then
        begin
          SQL.Add('and exists ');
          SQL.Add('(');
          SQL.Add('  select * ');
          SQL.Add('  from frf_gastos_entregas ');
          SQL.Add('  where codigo_ge = codigo_ec ');
          SQL.Add(')');
        end
        else
        if  ( ASinGasto = 1 ) then
        begin
          SQL.Add('and not exists ');
          SQL.Add('(');
          SQL.Add('  select * ');
          SQL.Add('  from frf_gastos_entregas ');
          SQL.Add('  where codigo_ge = codigo_ec ');
          SQL.Add(')');
        end;
      end;

      SQL.Add('group by codigo_ec, empresa_ec, proveedor_ec, fecha_llegada_ec, fecha_origen_ec, adjudicacion_ec, producto_el ');
      SQL.Add('order by empresa_ec, producto_el, proveedor_ec, codigo_ec');
    end;
  end
  else
  begin
    with QListado do
    begin
      SQL.Clear;
      SQL.Add('select empresa_ec, proveedor_ec, fecha_llegada_ec fecha, fecha_origen_ec, codigo_ec, adjudicacion_ec, ');
      SQL.Add('       ( select count( distinct producto_el ) from frf_entregas_l where codigo_el = codigo_ec ) n_productos_ec, ');
      SQL.Add('       ( select sum(kilos_el) from frf_entregas_l where codigo_el = codigo_ec ) kilos_ec, ');
      SQL.Add('       ( select sum(unidades_el) from frf_entregas_l where codigo_el = codigo_ec ) unidades_ec, ');      
      SQL.Add('       ( select round(sum(kilos_el*precio_kg_el),2) from frf_entregas_l where codigo_el = codigo_ec ) importe_ec ');
      SQL.Add('from frf_entregas_c ');

      if AEntrega <> '' then
      begin
        if ATipoCodigo = 0 then
          SQL.Add('where codigo_ec = :entrega ')
        else
          SQL.Add('where adjudicacion_ec = :entrega ');
      end
      else
      begin
        SQL.Add('where fecha_llegada_ec between :fechaini and :fechafin ');
        if ACorte then
          SQL.Add('and fecha_origen_ec < :fechacorte ')
      end;
      if AEmpresa = 'BAG' then
        SQL.Add('and substr( empresa_ec, 1, 1 ) = ''F'' ')
      else
      if AEmpresa = 'SAT' then
        SQL.Add('and ( empresa_ec = ''050'' or empresa_ec = ''080'' )')
      else
      if AEmpresa <> '' then
        SQL.Add('and empresa_ec = :empresa ');

      if ACentro <> '' then
      begin
        SQL.Add('and centro_llegada_ec = :centro ');
      end;
      if AProveedor <> '' then
        SQL.Add('and TRIM(proveedor_ec) = :proveedor ');
      if AAnyoSemana <> '' then
        SQL.Add('and anyo_semana_ec = :anyosemana ');        
      if AProducto <> '' then
      begin
        SQL.Add('and exists ');
        SQL.Add('(');
        SQL.Add('  select * ');
        SQL.Add('  from frf_entregas_l ');
        SQL.Add('  where codigo_el = codigo_ec ');
        SQL.Add('  and producto_el = :producto ');
        SQL.Add(')');
      end;

      if AGasto <> '' then
      begin
        if ( ASinGasto = 0 ) or ( ASinGasto = 2 ) then
        begin
          SQL.Add('and exists ');
          SQL.Add('(');
          SQL.Add('  select * ');
          SQL.Add('  from frf_gastos_entregas ');
          SQL.Add('  where codigo_ge = codigo_ec ');
          SQL.Add('and tipo_ge = :gasto ');
          SQL.Add(')');
        end
        else
        begin
          SQL.Add('and not exists ');
          SQL.Add('(');
          SQL.Add('  select * ');
          SQL.Add('  from frf_gastos_entregas ');
          SQL.Add('  where codigo_ge = codigo_ec ');
          SQL.Add('and tipo_ge = :gasto ');
          SQL.Add(')');
        end;
      end
      else
      begin
        if ( ASinGasto = 2 ) then
        begin
          SQL.Add('and exists ');
          SQL.Add('(');
          SQL.Add('  select * ');
          SQL.Add('  from frf_gastos_entregas ');
          SQL.Add('  where codigo_ge = codigo_ec ');
          SQL.Add(')');
        end
        else
        begin
          SQL.Add('and not exists ');
          SQL.Add('(');
          SQL.Add('  select * ');
          SQL.Add('  from frf_gastos_entregas ');
          SQL.Add('  where codigo_ge = codigo_ec ');
          SQL.Add(')');
        end;
      end;

      SQL.Add('group by codigo_ec, empresa_ec, proveedor_ec, fecha_llegada_ec, fecha_origen_ec, adjudicacion_ec ');
      SQL.Add('order by empresa_ec, proveedor_ec, codigo_ec');
    end;
  end;

  with QListado do
  begin
    if AEntrega <> '' then
    begin
      ParamByName('entrega').AsString:= AEntrega;
    end
    else
    begin
      ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
      if ACorte then
        ParamByName('fechacorte').AsDateTime:= AFechaCorte;
    end;
    if ( AEmpresa <> '' ) and ( AEmpresa <> 'SAT' ) and ( AEmpresa <> 'BAG' ) then
    begin
      ParamByName('empresa').AsString:= AEmpresa;
    end;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AAnyoSemana <> '' then
      ParamByName('AnyoSemana').AsString:= AAnyoSemana;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if ( AGasto <> '' ) then
      ParamByName('gasto').AsString:= AGasto;
    Open;
    Result:= not IsEmpty;
  end;
end;

(*
function TDLGastosEntregas.ObtenerDatosConduce( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                                         const AFechaIni, AFechaFin, AFechaCorte: TDateTime; const ACorte: Boolean;
                                         const ATipoCodigo, AFacturaGrabada: integer ): boolean;
var
  sFactura: string;
begin
  if AFacturaGrabada = 1 then
  begin
    sFactura:= '    nvl(ref_fac_ge,'''') = '''' ';
  end
  else
  if AFacturaGrabada = 2 then
  begin
    sFactura:= '    nvl(ref_fac_ge,'''') <> '''' ';
  end
  else
  if AFacturaGrabada = 3 then
  begin
    sFactura:= '    nvl(ref_fac_ge,'''') <> '''' and nvl(fecha_fac_ge,'''') = '''' ';
  end
  else
  if AFacturaGrabada = 4 then
  begin
    sFactura:= '    nvl(ref_fac_ge,'''') <> '''' and nvl(fecha_fac_ge,'''') <> '''' ';
  end
  else
  begin
    sFactura:= ' 1 = 1 ';
  end;
  bVerDetalle:= False;

  with QListado do
  begin
    SQL.Clear;




    SQL.Add('select empresa_ec empresa, adjudicacion_ec conduce, tipo_ge tipo, descripcion_tg descripcion, sum(case when ' + sFactura  + ' then importe_ge else 0 end) importe ');
    SQL.Add('from frf_entregas_c, frf_gastos_entregas, frf_tipo_gastos ');
    SQL.Add('where codigo_ec = codigo_ge ');
    SQL.Add('  and tipo_ge = tipo_tg ');

    if AEntrega <> '' then
    begin
      if ATipoCodigo = 0 then
        SQL.Add('and codigo_ec = :entrega ')
      else
        SQL.Add('and adjudicacion_ec = :entrega ');
    end
    else
    begin
      SQL.Add('and fecha_llegada_ec between :fechaini and :fechafin ');
      if ACorte then
        SQL.Add('and fecha_origen_ec < :fechacorte ')
    end;
      if AEmpresa = 'BAG' then
        SQL.Add('and substr( empresa_ec, 1, 1 ) = ''F'' ')
      else
      if AEmpresa = 'SAT' then
        SQL.Add('and ( empresa_ec = ''050'' or empresa_ec = ''080'' )')
      else
      if AEmpresa <> '' then
        SQL.Add('and empresa_ec = :empresa ');

    if ACentro <> '' then
    begin
      SQL.Add('and centro_llegada_ec = :centro ');
    end;
    if AProveedor <> '' then
    begin
        SQL.Add('and TRIM(proveedor_ec) = :proveedor ');
    end;
    if AAnyoSemana <> '' then
        SQL.Add('and anyo_semana_ec = :anyosemana ');
    if AProducto <> '' then
    begin
      SQL.Add('  and producto_el = :producto ');
    end;

    if AGasto <> '' then
    begin
      SQL.Add('  and tipo_ge = :gasto ');
    end;
      SQL.Add(' group by empresa_ec, adjudicacion_ec, tipo_ge, descripcion_tg ');
      SQL.Add(' order by empresa, conduce, tipo ');
  end;

  with QListado do
  begin
    if AEntrega <> '' then
    begin
      ParamByName('entrega').AsString:= AEntrega;
    end
    else
    begin
      ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
      if ACorte then
        ParamByName('fechacorte').AsDateTime:= AFechaCorte;
    end;

    if ( AEmpresa <> '' ) and ( AEmpresa <> 'SAT' ) and ( AEmpresa <> 'BAG' ) then
      ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AAnyoSemana <> '' then
      ParamByName('AnyoSemana').AsString:= AAnyoSemana;      
    if AGasto <> '' then
      ParamByName('gasto').AsString:= AGasto;

    Open;
    Result:= not IsEmpty;
  end;
end;
*)

procedure TDLGastosEntregas.CerrarQuery;
begin
  QListado.Close;
  qryTabla.Close;
end;

procedure TDLGastosEntregas.QListadoAfterOpen(DataSet: TDataSet);
begin
  if bVerDetalle then
  begin
    QDetalleLinea.Open;
    QDetalleGasto.Open;
  end;
end;

procedure TDLGastosEntregas.QListadoBeforeClose(DataSet: TDataSet);
begin
  if bVerDetalle then
  begin
    QDetalleLinea.Close;
    QDetalleGasto.Close;
  end;
end;

function TDLGastosEntregas.ObtenerDatosTabla( const AEmpresa, ACentro, AProveedor, AProducto, AAnyoSemana, AEntrega, AGasto: string;
                                              const AFechaIni, AFechaFin, AFechaCorte: TDateTime; const ACorte: Boolean;
                                              const AGastoGrabado: Integer; const ATipoCodigo, AFacturaGrabada: integer; const AFechaFactura: TDateTime ): boolean;
var
  sFactura: string;
begin
  if AFacturaGrabada = 1 then
  begin
    sFactura:= '    and nvl(ref_fac_ge,'''') = '''' ';
  end
  else
  if AFacturaGrabada = 2 then
  begin
    sFactura:= '    and nvl(ref_fac_ge,'''') <> '''' ';
  end
  else
  if AFacturaGrabada = 3 then
  begin
    sFactura:= '    and nvl(ref_fac_ge,'''') <> '''' and nvl(fecha_fac_ge,'''') = '''' ';
  end
  else
  if AFacturaGrabada = 4 then
  begin
    sFactura:= '    and nvl(ref_fac_ge,'''') <> '''' and nvl(fecha_fac_ge,'''') <> '''' ';
  end
  else
  if AFacturaGrabada = 5 then
  begin
   sFactura:= '    and ( ( nvl(ref_fac_ge,'''') = '''' ) or ( nvl(fecha_fac_ge,'''') = '''' ) or ( fecha_fac_ge > :fechafac ) ) ';
  end
  else
  begin
    sFactura:= '';
  end;

  with qryTabla do
  begin
    SQL.Clear;

    SQL.Add('SELECT codigo_ec, empresa_ec, proveedor_ec, fecha_llegada_ec, fecha_origen_ec, producto_el, ');

    SQL.Add('      sum( ( case when producto_el in (''PIN'',''COC'')  and ( ( calibre_el[1,1] between ''1'' and ''9'' ) or ( calibre_el[2,2] between ''1'' and ''9'' ) ) ');
    SQL.Add('                 then cast( case when not ( calibre_el[1,1] between ''1'' and ''9'' ) ');
    SQL.Add('                                 then calibre_el[2,3] ');
    SQL.Add('                                 else calibre_el end as integer ) ');
    SQL.Add('                 else ');
    SQL.Add('                      ( select unidades_caja_pp from frf_productos_proveedor ');
    SQL.Add('                        where proveedor_pp = proveedor_ec ');
    SQL.Add('                        and producto_pp = producto_el and variedad_pp = variedad_el ) end * cajas_el ) ) unidades, ');

    SQL.Add('       sum(kilos_el) kilos, ');

    {Filtro tipo de gasto
      -Si se selecciona uno deja los demás a 0 y busca ese en concreto.
      -Si no hay nada seleccionado, entra al else grande de abajo y los busca todos}
    if AGasto = '012' then
    begin
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''012'' and ( producto_ge = producto_el or producto_ge is null ) ) g012, ');
      SQL.Add('       0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '013' then
    begin
      SQL.Add('       0 g012, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''013'' and ( producto_ge = producto_el or producto_ge is null ) ) g013, ');
      SQL.Add('       0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '014' then
    begin
      SQL.Add('       0 g012, 0 g013,');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''014'' and ( producto_ge = producto_el or producto_ge is null ) ) g014, ');
      SQL.Add('       0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '015' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''015'' and ( producto_ge = producto_el or producto_ge is null ) ) g015, ');
      SQL.Add('       0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '016' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''016'' and ( producto_ge = producto_el or producto_ge is null ) ) g016, ');
      SQL.Add('       0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '051' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''051'' and ( producto_ge = producto_el or producto_ge is null ) ) g051, ');
      SQL.Add('       0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '052' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''052'' and ( producto_ge = producto_el or producto_ge is null ) ) g052, ');
      SQL.Add('       0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '053' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''053'' and ( producto_ge = producto_el or producto_ge is null ) ) g053, ');
      SQL.Add('       0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '054' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''054'' and ( producto_ge = producto_el or producto_ge is null ) ) g054, ');
      SQL.Add('       0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '055' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''055'' and ( producto_ge = producto_el or producto_ge is null ) ) g055, ');
      SQL.Add('       0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '056' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''056'' and ( producto_ge = producto_el or producto_ge is null ) ) g056, ');
      SQL.Add('       0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '057' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''057'' and ( producto_ge = producto_el or producto_ge is null ) ) g057, ');
      SQL.Add('       0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '058' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''058'' and ( producto_ge = producto_el or producto_ge is null ) ) g058, ');
      SQL.Add('       0 g059, 0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '059' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''059'' and ( producto_ge = producto_el or producto_ge is null ) ) g059, ');
      SQL.Add('       0 g060, 0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '060' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''060'' and ( producto_ge = producto_el or producto_ge is null ) ) g060, ');
      SQL.Add('       0 g061, 0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '061' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''061'' and ( producto_ge = producto_el or producto_ge is null ) ) g060, ');
      SQL.Add('       0 g062, 0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '062' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''062'' and ( producto_ge = producto_el or producto_ge is null ) ) g060, ');
      SQL.Add('       0 g063,  0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '063' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''063'' and ( producto_ge = producto_el or producto_ge is null ) ) g060, ');
      SQL.Add('       0 g064, 0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '064' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''064'' and ( producto_ge = producto_el or producto_ge is null ) ) g060, ');
      SQL.Add('       0 g065, 0 g066, 0 g084 ');
    end
    else
    if AGasto = '065' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063, 0 g064, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''065'' and ( producto_ge = producto_el or producto_ge is null ) ) g060, ');
      SQL.Add('       0 g066, 0 g084 ');
    end
    else
    if AGasto = '066' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063, 0 g064, 0 g065');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''066'' and ( producto_ge = producto_el or producto_ge is null ) ) g060, ');
      SQL.Add('       0 g084 ');
    end
    else
    if AGasto = '084' then
    begin
      SQL.Add('       0 g012, 0 g013, 0 g014, 0 g015, 0 g016, 0 g051, 0 g052, 0 g053, 0 g054, 0 g055, 0 g056, 0 g057, 0 g058, 0 g059, 0 g060, 0 g061, 0 g062, 0 g063, 0 g064, 0 g065, 0 g066, ');
      SQL.Add('       ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''084'' and ( producto_ge = producto_el or producto_ge is null ) ) g084 ');
    end
    else
    begin
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''012'' and ( producto_ge = producto_el or producto_ge is null ) ) g012, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''013'' and ( producto_ge = producto_el or producto_ge is null ) ) g013, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''014'' and ( producto_ge = producto_el or producto_ge is null ) ) g014, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''015'' and ( producto_ge = producto_el or producto_ge is null ) ) g015, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''016'' and ( producto_ge = producto_el or producto_ge is null ) ) g016, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''051'' and ( producto_ge = producto_el or producto_ge is null ) ) g051, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''052'' and ( producto_ge = producto_el or producto_ge is null ) ) g052, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''053'' and ( producto_ge = producto_el or producto_ge is null ) ) g053, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''054'' and ( producto_ge = producto_el or producto_ge is null ) ) g054, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''055'' and ( producto_ge = producto_el or producto_ge is null ) ) g055, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''056'' and ( producto_ge = producto_el or producto_ge is null ) ) g056, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''057'' and ( producto_ge = producto_el or producto_ge is null ) ) g057, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''058'' and ( producto_ge = producto_el or producto_ge is null ) ) g058, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''059'' and ( producto_ge = producto_el or producto_ge is null ) ) g059, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''060'' and ( producto_ge = producto_el or producto_ge is null ) ) g060, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''061'' and ( producto_ge = producto_el or producto_ge is null ) ) g061, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''062'' and ( producto_ge = producto_el or producto_ge is null ) ) g062, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''063'' and ( producto_ge = producto_el or producto_ge is null ) ) g063, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''064'' and ( producto_ge = producto_el or producto_ge is null ) ) g064, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''065'' and ( producto_ge = producto_el or producto_ge is null ) ) g065, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''066'' and ( producto_ge = producto_el or producto_ge is null ) ) g066, ');
      SQL.Add('    ( SELECT SUM(importe_ge) FROM FRF_gastos_entregas where codigo_ge = codigo_ec ' + sFactura + ' and tipo_ge = ''084'' and ( producto_ge = producto_el or producto_ge is null ) ) g084 ');
    end;

    SQL.Add('FROM FRF_entregas_c, FRF_entregas_l ');
    SQL.Add('where codigo_el = codigo_ec ');

    if AEntrega <> '' then
    begin
      if ATipoCodigo = 0 then
        SQL.Add('and codigo_ec = :entrega ')
      else
        SQL.Add('and adjudicacion_ec = :entrega ');
    end
    else
    begin
      SQL.Add('and fecha_llegada_ec between :fechaini and :fechafin ');
      if ACorte then
        SQL.Add('and fecha_origen_ec < :fechacorte ')
    end;

      if AEmpresa = 'BAG' then
        SQL.Add('and substr( empresa_ec, 1, 1 ) = ''F'' ')
      else
      if AEmpresa = 'SAT' then
        SQL.Add('and ( empresa_ec = ''050'' or empresa_ec = ''080'' )')
      else
      if AEmpresa <> '' then
        SQL.Add('and empresa_ec = :empresa ');
    if ACentro <> '' then
    begin
      SQL.Add('and centro_llegada_ec = :centro ');
    end;
    if AProveedor <> '' then
    begin
        SQL.Add('and proveedor_ec = :proveedor ');
    end;
    if AAnyoSemana <> '' then
      SQL.Add('and anyo_semana_ec = :anyosemana ');
    if AProducto <> '' then
    begin
      SQL.Add('  and producto_el = :producto ');
    end;
    case AGastoGrabado of
      1: begin
        if AGasto = '054' then
        begin
          SQL.Add('  and not exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''054'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '055' then
        begin
          SQL.Add('  and not exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''055'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '056' then
        begin
          SQL.Add('  and not exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''056'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '012' then
        begin
          SQL.Add('  and not exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and ( tipo_ge = ''012'' or tipo_ge = ''013'' ) and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '057' then
        begin
          SQL.Add('  and not exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''057'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '058' then
        begin
          SQL.Add(' and not exists       ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''058'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '014' then
        begin
          SQL.Add('  and not exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''014'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '015' then
        begin
          SQL.Add('  and not exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''015'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '059' then
        begin
          SQL.Add(' and not exists       ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''059'' and ( producto_ge = producto_el or producto_ge is null ) ) , ');
        end
        else
        if AGasto = '060' then
        begin
          SQL.Add('  and not exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''060'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '110' then
        begin
          SQL.Add(' and not exists       ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = 110 and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '016' then
        begin
          SQL.Add('  and not exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''016'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        begin
          SQL.Add('  and not exists ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and ( producto_ge = producto_el or producto_ge is null ) ) ');
        end;
      end;
      2: begin
        if AGasto = '054' then
        begin
          SQL.Add('  and exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''054'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '055' then
        begin
          SQL.Add('  and exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''055'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '056' then
        begin
          SQL.Add('  and exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''056'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '012' then
        begin
          SQL.Add('  and exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and ( tipo_ge = ''012'' or tipo_ge = ''013'' ) and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '057' then
        begin
          SQL.Add('  and exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''057'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '058' then
        begin
          SQL.Add(' and exists       ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''058'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '014' then
        begin
          SQL.Add('  and exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''014'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '015' then
        begin
          SQL.Add('  and exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''015'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '059' then
        begin
          SQL.Add(' and exists       ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''059'' and ( producto_ge = producto_el or producto_ge is null ) ) , ');
        end
        else
        if AGasto = '060' then
        begin
          SQL.Add('  and exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''060'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '110' then
        begin
          SQL.Add(' and  exists       ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = 110 and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        if AGasto = '016' then
        begin
          SQL.Add('  and exists      ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and tipo_ge = ''016'' and ( producto_ge = producto_el or producto_ge is null ) )  ');
        end
        else
        begin
          SQL.Add('  and exists ( SELECT * FROM FRF_gastos_entregas where codigo_ge = codigo_ec and ( producto_ge = producto_el or producto_ge is null ) ) ');
        end;
      end;
    end;
    SQL.Add(' group by 1,2,3,4,5,6  ');
    SQL.Add(' order by empresa_ec,producto_el,proveedor_ec,fecha_llegada_ec,codigo_ec ');


    if AEntrega <> '' then
    begin
      ParamByName('entrega').AsString:= AEntrega;
    end
    else
    begin
      ParamByName('fechaini').AsDateTime:= AFechaIni;
      ParamByName('fechafin').AsDateTime:= AFechaFin;
      if ACorte then
        ParamByName('fechacorte').AsDateTime:= AFechaCorte;
    end;
    if ( AEmpresa <> '' ) and ( AEmpresa <> 'SAT' ) and ( AEmpresa <> 'BAG' ) then
      ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if AProveedor <> '' then
      ParamByName('proveedor').AsString:= AProveedor;
    if AAnyoSemana <> '' then
      ParamByName('AnyoSemana').AsString:= AAnyoSemana;
    if AFacturaGrabada = 5 then
      ParamByName('fechafac').AsDate := AFechaFactura;
    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TDLGastosEntregas.TablaTemporal;
begin
  tkbmTablaCSV.Fields.Clear;
  tkbmTablaCSV.FieldDefs.Add('COD_ENTREGA', ftString, 15, False);
  tkbmTablaCSV.FieldDefs.Add('EMPRESA', ftString, 3, False);
  tkbmTablaCSV.FieldDefs.Add('PROVEEDOR', ftString, 3, False);
  tkbmTablaCSV.FieldDefs.Add('FECHA_LLEGADA', ftDate, 0, False);
  tkbmTablaCSV.FieldDefs.Add('FECHA_ORIGEN', ftDate, 0, False);
  tkbmTablaCSV.FieldDefs.Add('PRODUCTO', ftString, 5, False);
  tkbmTablaCSV.FieldDefs.Add('UNIDADES', ftString, 6, False);
  tkbmTablaCSV.FieldDefs.Add('KILOS', ftString, 6, False);
  tkbmTablaCSV.FieldDefs.Add('012', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('013', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('014', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('015', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('016', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('051', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('052', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('053', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('054', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('055', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('056', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('057', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('058', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('059', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('060', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('061', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('062', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('063', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('064', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('065', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('066', ftString, 10, False);
  tkbmTablaCSV.FieldDefs.Add('084', ftString, 10, False);
  tkbmTablaCSV.CreateTable;
  tkbmTablaCSV.Open;

  while not qryTabla.Eof do
  begin
     NuevoRegistro;
     qryTabla.Next;
  end;
end;


procedure TDLGastosEntregas.NuevoRegistro;
begin
      tkbmTablaCSV.Insert;
      tkbmTablaCSV.FieldByName('COD_ENTREGA').AsString := qryTabla.FieldByName('codigo_ec').AsString;
      tkbmTablaCSV.FieldByName('EMPRESA').AsString := qryTabla.FieldByName('empresa_ec').AsString;
      tkbmTablaCSV.FieldByName('PROVEEDOR').AsString := qryTabla.FieldByName('proveedor_ec').AsString;
      tkbmTablaCSV.FieldByName('FECHA_LLEGADA').AsDateTime := qryTabla.FieldByName('fecha_llegada_ec').AsDateTime;
      tkbmTablaCSV.FieldByName('FECHA_ORIGEN').AsDateTime := qryTabla.FieldByName('fecha_origen_ec').AsDateTime;
      tkbmTablaCSV.FieldByName('PRODUCTO').AsString := qryTabla.FieldByName('producto_el').AsString;
      tkbmTablaCSV.FieldByName('UNIDADES').AsString := qryTabla.FieldByName('unidades').AsString;
      tkbmTablaCSV.FieldByName('KILOS').AsString := qryTabla.FieldByName('kilos').AsString;
      tkbmTablaCSV.FieldByName('012').AsString := qryTabla.FieldByName('g012').AsString;
      tkbmTablaCSV.FieldByName('013').AsString := qryTabla.FieldByName('g013').AsString;
      tkbmTablaCSV.FieldByName('014').AsString := qryTabla.FieldByName('g014').AsString;
      tkbmTablaCSV.FieldByName('015').AsString := qryTabla.FieldByName('g015').AsString;
      tkbmTablaCSV.FieldByName('016').AsString := qryTabla.FieldByName('g016').AsString;
      tkbmTablaCSV.FieldByName('051').AsString := qryTabla.FieldByName('g051').AsString;
      tkbmTablaCSV.FieldByName('052').AsString := qryTabla.FieldByName('g052').AsString;
      tkbmTablaCSV.FieldByName('053').AsString := qryTabla.FieldByName('g053').AsString;
      tkbmTablaCSV.FieldByName('054').AsString := qryTabla.FieldByName('g054').AsString;
      tkbmTablaCSV.FieldByName('055').AsString := qryTabla.FieldByName('g055').AsString;
      tkbmTablaCSV.FieldByName('056').AsString := qryTabla.FieldByName('g056').AsString;
      tkbmTablaCSV.FieldByName('057').AsString := qryTabla.FieldByName('g057').AsString;
      tkbmTablaCSV.FieldByName('058').AsString := qryTabla.FieldByName('g058').AsString;
      tkbmTablaCSV.FieldByName('059').AsString := qryTabla.FieldByName('g059').AsString;
      tkbmTablaCSV.FieldByName('060').AsString := qryTabla.FieldByName('g060').AsString;
      tkbmTablaCSV.FieldByName('061').AsString := qryTabla.FieldByName('g061').AsString;
      tkbmTablaCSV.FieldByName('062').AsString := qryTabla.FieldByName('g062').AsString;
      tkbmTablaCSV.FieldByName('063').AsString := qryTabla.FieldByName('g063').AsString;
      tkbmTablaCSV.FieldByName('064').AsString := qryTabla.FieldByName('g064').AsString;
      tkbmTablaCSV.FieldByName('065').AsString := qryTabla.FieldByName('g065').AsString;
      tkbmTablaCSV.FieldByName('066').AsString := qryTabla.FieldByName('g066').AsString;
      tkbmTablaCSV.FieldByName('084').AsString := qryTabla.FieldByName('g084').AsString;
      tkbmTablaCSV.Post;
end;

procedure TDLGastosEntregas.CrearCSVTabla;
var
  sAux, sTemp, OutLine : string;
  Stream : TFileStream;
  contador : integer;
begin
   with TSaveDialog.Create(Self) do
    try
      //puntero en el primero para recorrerlo
      Title := '  Guardar INFORME DETALLADO.';
      Filter := 'Documento EXCEL_CSV (*.csv)|*.csv|';

      FileName:= 'TABLA_GASTOS_ENTREGAS.csv';
      Execute;
      Stream := TFileStream.Create(FileName, fmCreate);

      try
        OutLine := 'Detalle gastos entregas';
        SetLength(OutLine, Length(OutLine));
        Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
        Stream.Write(sLineBreak, Length(sLineBreak));

        //cabecera del csv
        OutLine := 'CODIGO_ENTREGA;EMPRESA;PROVEEDOR;FECHA_LLEGADA;FECHA_ORIGEN;PRODUCTO;UNIDADES;KILOS;' +
          'GASTO_012;GASTO_013;GASTO_014;GASTO_015;GASTO_016;GASTO_051;GASTO_052;GASTO_053;GASTO_054;GASTO_055;GASTO_056;GASTO_057;' +
          'GASTO_058;GASTO_059;GASTO_060;GASTO_061;GASTO_062;GASTO_063;GASTO_064;GASTO_065;GASTO_066;GASTO_084';
        SetLength(OutLine, Length(OutLine));
        Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
        Stream.Write(sLineBreak, Length(sLineBreak));


        TablaTemporal;
        tkbmTablaCSV.First;
        while not tkbmTablaCSV.Eof do
        begin
          OutLine := '';
          for contador := 0 to tkbmTablaCSV.FieldCount - 1 do
          begin
            sTemp := tkbmTablaCSV.Fields[contador].AsString;
            if (sTemp = '') then
              sTemp := '0';
            OutLine := OutLine + sTemp + ';';
          end;
          //Elimina el ; final innecesaria
          SetLength(OutLine, Length(OutLine));
          //Escribe la línea en el fichero
          Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
          //Escribe salto de línea
          Stream.Write(sLineBreak, Length(sLineBreak));
          tkbmTablaCSV.Next;
        end;
      finally
        Stream.Free;  // Saves the file
      end;
    finally
      tkbmTablaCSV.Close;
      Free;
    end;
end;

end.
