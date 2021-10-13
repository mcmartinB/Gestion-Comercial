unit AlbaranesFacturadosEnData;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMAlbaranesFacturadosEn = class(TDataModule)
    QInventarios: TQuery;
    mtResumen: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sSerie, sCentro, sProducto, sPais: string;
    dFechaIni, dFechaFin: TDateTime;
    iPaises: integer;
    procedure CrearTablaTemporal;
    procedure PreparaQuerys;
    procedure DesPreparaQuerys;
    function ObtenerDatos(var AMsg: string): boolean;
    function GrabarDatos(var AMsg: string): boolean;
  public
    { Public declarations }
  end;

function ExecuteAlbaranesFacturadosEn(const AOwner: TComponent; const AEmpresa, ASerie, ACentro, AProducto, APais: string; const APaises: Integer; const AFechaIni, AFechaFin: TDateTime; var AMsg: string): boolean;

implementation

{$R *.dfm}

uses
  AlbaranesFacturadosEnReport, bMath, CGlobal;

var
  DMAlbaranesFacturadosEn: TDMAlbaranesFacturadosEn;

function ExecuteAlbaranesFacturadosEn(const AOwner: TComponent; const AEmpresa, ASerie, ACentro, AProducto, APais: string; const APaises: Integer; const AFechaIni, AFechaFin: TDateTime; var AMsg: string): boolean;
begin
  DMAlbaranesFacturadosEn := TDMAlbaranesFacturadosEn.Create(AOwner);

  //CODIGO
  try
    with DMAlbaranesFacturadosEn do
    begin
      sEmpresa := AEmpresa;
      sSerie := ASerie;
      sCentro := ACentro;
      sProducto := AProducto;
      sPais := APais;
      iPaises := APaises;
      dFechaIni := AFechaIni;
      dFechaFin := AFechaFin;

      PreparaQuerys;
      result := ObtenerDatos(AMsg);
      if result then
      begin
        mtResumen.Open;
        try
          result := GrabarDatos(AMsg);
          if result then
          begin
            mtResumen.SortFields := 'nacional;cliente;empresa;producto;seccion;fecha;albaran';
            mtResumen.Sort([]);
            PrintAlbaranesFacturadosEn(AOwner, AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin);
          end;
        except
          mtResumen.Close;
        end;
      end;
    end;
  finally
    FreeAndNil(DMAlbaranesFacturadosEn);
  end;
end;

procedure TDMAlbaranesFacturadosEn.DataModuleCreate(Sender: TObject);
begin
  CrearTablaTemporal;
end;

procedure TDMAlbaranesFacturadosEn.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuerys;
end;

procedure TDMAlbaranesFacturadosEn.CrearTablaTemporal;
begin
  with mtResumen do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('nacional', ftstring, 2, False);
    FieldDefs.Add('cliente', ftstring, 3, False);
    FieldDefs.Add('empresa', ftstring, 3, False);
    FieldDefs.Add('centro', ftstring, 3, False);
    FieldDefs.Add('albaran', ftInteger, 0, False);
    FieldDefs.Add('fecha', ftDate, 0, False);
    FieldDefs.Add('codigoX3', ftString, 10, False);


    FieldDefs.Add('empresa_factura', ftstring, 3, False);
    FieldDefs.Add('n_factura', ftInteger, 0, False);
    FieldDefs.Add('fecha_factura', ftDate, 0, False);
    FieldDefs.Add('cod_factura', ftString, 15, False);

    FieldDefs.Add('producto', ftstring, 3, False);
    FieldDefs.Add('seccion', ftstring, 12, False);
    FieldDefs.Add('kilos', ftFloat, 0, False);
    FieldDefs.Add('gastos', ftFloat, 0, False);
    FieldDefs.Add('importe', ftFloat, 0, False);
    FieldDefs.Add('total', ftFloat, 0, False);

    CreateTable;
  end;
end;

procedure TDMAlbaranesFacturadosEn.PreparaQuerys;
begin
  with QInventarios do
  begin
    SQL.Clear;
    //Albaranes
    SQL.Add(' select case when pais_c = ''ES'' then ''ES'' else ''EX'' end nacional, ');
    SQL.Add('        cliente_fac_Sc cliente, (select cta_cliente_c from frf_clientes where cliente_c = cliente_fac_Sc) codigox3, ');
    SQL.Add('        empresa_sc empresa, centro_salida_sc centro, n_albaran_sc albaran, fecha_sc fecha, ');
    SQL.Add('        nvl(empresa_fac_sc,empresa_sc) empresa_factura, serie_fac_sc, n_factura_sc n_factura, fecha_factura_sc fecha_factura,       ');
    SQL.Add('                                  (select cod_factura_fc from tfacturas_cab where cod_empresa_fac_fc = empresa_fac_sc               ');
    SQL.Add('                                                                              and cod_serie_fac_fc = serie_fac_sc                   ');
    SQL.Add('                                                                              and n_factura_fc = n_factura_sc                       ');
    SQL.Add('                                                                              and fecha_factura_fc = fecha_factura_sc) cod_factura, ');
    SQL.Add('        producto_sl producto, ');
    // Seccion Contable
    if CGlobal.gProgramVersion = CGlobal.pvSAT then
    begin
      SQL.Add('      (select sec_contable_rl from rsecciones_linea ');
      SQL.Add('        where empresa_rl = empresa_sc ');
      SQL.Add('          and centro_rl = centro_origen_sl ');                                // Centro Origen
      SQL.Add('          and producto_rl = producto_sl) seccion,    ');
    end
    else
    begin
      SQL.Add('      (select sec_contable_rl from rsecciones_linea ');
      SQL.Add('        where empresa_rl = empresa_sc ');
      SQL.Add('          and centro_rl = centro_salida_sc ');
      SQL.Add('          and producto_rl = producto_sl) seccion,    ');
    end;

    SQL.Add('       ( select sum(kilos_sl) from frf_salidas_l sal ');
    SQL.Add('         where empresa_sc = sal.empresa_sl and centro_salida_sc = sal.centro_salida_sl ');
    SQL.Add('           and n_albaran_sc = sal.n_albaran_sl and fecha_sc = sal.fecha_sl ) kilos_albaran, ');

    SQL.Add('       euros( moneda_sc, fecha_sc, nvl( ( select sum(importe_g * -1) ');
    SQL.Add('              from frf_gastos, frf_tipo_gastos ');
    SQL.Add('              where empresa_sc = empresa_g and centro_salida_sc = centro_salida_g ');
    SQL.Add('                and n_albaran_sc = n_albaran_g and fecha_sc = fecha_g ');
    SQL.Add('                and tipo_tg = tipo_g and facturable_tg = ''S'' ), 0) ) gastos_albaran_euros, ');

    SQL.Add('        sum( kilos_sl ) kilos_producto, ');
    SQL.Add('        sum( euros( moneda_sc, fecha_sc, round( importe_neto_sl * ');
    SQL.Add('                                                 ( 1 - ( ( GetDescuentoCliente( empresa_sc, cliente_fac_sc, fecha_sc, 1) + ');
    SQL.Add('                                                           GetComisionCliente( empresa_sc, cliente_fac_sc, fecha_sc) ) / 100 ) ), 2 ) ) ) euros_sin_gastos ');

    SQL.Add(' from frf_salidas_c ');
    SQL.Add('      join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sL ');
    SQL.Add('                            and n_albaran_sc = n_albaran_sl and  fecha_sc = fecha_sl ');
    SQL.Add('      join frf_clientes on cliente_sal_sc = cliente_c ');
    SQL.Add(' where fecha_sc between :fechaini and  :fechafin ');
    SQL.Add('   and fecha_factura_sc is null  ');

    if (sEmpresa = 'BAG') then
      SQL.Add(' and substr(empresa_sc,1,1) = ''F'' ')
    else if (sEmpresa = 'SAT') then
      SQL.Add(' and ( empresa_sc = ''080'' or empresa_sc = ''050'' )')
    else
      SQL.Add(' and empresa_sc = :empresa ');
    if (sCentro <> '') then
      SQL.Add(' and centro_salida_sc = :centro ');
    if (sProducto <> '') then
      SQL.Add(' and producto_sl = :producto ');

    if sPais <> '' then
    begin
      SQL.Add(' and ( select pais_c from frf_clientes where cliente_c = cliente_fac_sc ) = :pais ');
    end
    else
    begin
      if iPaises = 1 then
      begin
        //Nacional
        SQL.Add(' and ( select pais_c from frf_clientes where cliente_c = cliente_fac_sc ) = ''ES'' ');
      end
      else if iPaises = 2 then
      begin
        //Internacional
        SQL.Add(' and ( select pais_c from frf_clientes where cliente_c = cliente_fac_sc ) <> ''ES'' ');
      end;
    end;

    SQL.Add('   and substr( cliente_fac_sc, 1, 1 ) <> ''0''  ');
    SQL.Add('   and cliente_fac_sc <> ''RET'' ');
    SQL.Add('   and cliente_sal_sc <> ''REA'' ');
    SQL.Add('   and cliente_sal_sc <> ''EG'' ');

    if CGlobal.gProgramVersion = CGlobal.pvSAT then
    begin
      SQL.Add('   and cliente_fac_sc <> ''REP'' ');
      SQL.Add('   and cliente_sal_sc <> ''BAA'' ');
    end
    else
    begin
      SQL.Add('   and cliente_sal_sc <> ''GAN'' ');
    end;

    SQL.Add(' group by nacional, empresa, cliente, codigox3, centro, albaran, fecha, empresa_factura, serie_fac_sc, n_factura, fecha_factura, cod_factura, ');
    SQL.Add('          producto, seccion, kilos_albaran, gastos_albaran_euros ');

    SQL.Add(' union ');

    //Facturas
    SQL.Add(' select case when pais_c = ''ES'' then ''ES'' else ''EX'' end nacional, ');
    SQL.Add('        cod_cliente_fc cliente, (select cta_cliente_c from frf_clientes where cliente_c = cod_cliente_fc) codigox3, ');
    SQL.Add('        cod_empresa_albaran_fd empresa, cod_centro_albaran_fd centro, n_albaran_fd albaran, fecha_albaran_fd fecha, ');
    SQL.Add('        nvl(cod_empresa_fac_fc,cod_empresa_albaran_fd) empresa_factura, cod_serie_fac_fc serie_factura, n_factura_fc n_factura, fecha_factura_fc fecha_factura,  ');
    SQL.Add('        cod_factura_fd cod_factura,  ');
    SQL.Add('        cod_producto_fd producto,                                                                                                           ');
    // Seccion Contable
    if CGlobal.gProgramVersion = CGlobal.pvSAT then
    begin
      SQL.Add('      (select sec_contable_rl from rsecciones_linea ');
      SQL.Add('        where empresa_rl = cod_empresa_albaran_fd ');
      SQL.Add('          and centro_rl = centro_origen_fd ');                                // Centro Origen
      SQL.Add('          and producto_rl = cod_producto_fd) seccion,    ');
    end
    else
    begin
      SQL.Add('      (select sec_contable_rl from rsecciones_linea ');
      SQL.Add('        where empresa_rl = cod_empresa_albaran_fd ');
      SQL.Add('          and centro_rl = cod_centro_albaran_fd ');
      SQL.Add('          and producto_rl = cod_producto_fd) seccion,    ');
    end;


    SQL.Add('         ( select sum(kilos_fd) from tfacturas_det det     ');
    SQL.Add('                  where cod_factura_fc = det.cod_factura_fd and cod_empresa_albaran_fd = det.cod_empresa_albaran_fd and cod_centro_albaran_fd = det.cod_centro_albaran_fd ');
    SQL.Add('                    and n_albaran_fd = det.n_albaran_fd and fecha_albaran_fd = det.fecha_albaran_fd ) kilos_albaran,                                                      ');

    SQL.Add('          euros( moneda_fc, fecha_albaran_fd, nvl( ( select sum(importe_g * -1)            ');
    SQL.Add('                        from frf_gastos, frf_tipo_gastos                                   ');
    SQL.Add('                        where cod_empresa_albaran_fd = empresa_g and cod_centro_albaran_fd = centro_salida_g ');
    SQL.Add('                          and n_albaran_fd = n_albaran_g and fecha_albaran_fd = fecha_g                      ');
    SQL.Add('                          and tipo_tg = tipo_g and facturable_tg = ''S'' ), 0) ) gastos_albaran_euros,       ');

    SQL.Add('               sum( kilos_fd ) kilos_producto, ');
    SQL.Add('                       sum( euros( moneda_fc, fecha_albaran_fd, round( importe_linea_fd *                    ');
    SQL.Add('                                                                ( 1 - ( ( GetDescuentoCliente( cod_empresa_albaran_fd, cod_cliente_albaran_fd, fecha_albaran_fd, 1) + ');
    SQL.Add('                                                                          GetComisionCliente( cod_empresa_albaran_fd, cod_cliente_albaran_fd, fecha_albaran_fd) ) / 100 ) ), 2 ) ) ) euros_sin_gastos ');

    SQL.Add(' from tfacturas_cab ');
    SQL.Add('      join tfacturas_det on cod_factura_fc = cod_factura_fd ');
    SQL.Add('            join frf_clientes on cod_cliente_albaran_fd = cliente_c ');
    SQL.Add('  where fecha_albaran_fd between :fechaini and  :fechafin ');
    SQL.Add('     and  fecha_factura_fc > :fechafin ');

    if (sEmpresa = 'BAG') then
      SQL.Add(' and substr(cod_empresa_albaran_fd,1,1) = ''F'' ')
    else if (sEmpresa = 'SAT') then
      SQL.Add(' and ( cod_empresa_albaran_fd = ''080'' or cod_empresa_albaran_fd = ''050'' )')
    else
      SQL.Add(' and cod_empresa_albaran_fd = :empresa ');
    if (sCentro <> '') then
      SQL.Add(' and cod_centro_albaran_fd = :centro ');
    if (sProducto <> '') then
      SQL.Add(' and cod_producto_fd = :producto ');
    if sSerie <> '' then
      SQL.Add(' and cod_serie_fac_fc = :serie ');
    if sPais <> '' then
    begin
      SQL.Add(' and ( select pais_c from frf_clientes where cliente_c = cod_cliente_fc ) = :pais ');
    end
    else
    begin
      if iPaises = 1 then
      begin
        //Nacional
        SQL.Add(' and ( select pais_c from frf_clientes where cliente_c = cod_cliente_fc ) = ''ES'' ');
      end
      else if iPaises = 2 then
      begin
        //Internacional
        SQL.Add(' and ( select pais_c from frf_clientes where cliente_c = cod_cliente_fc ) <> ''ES'' ');
      end;
    end;

    SQL.Add('   and substr( cod_cliente_fc, 1, 1 ) <> ''0''  ');
    SQL.Add('   and cod_cliente_fc <> ''RET'' ');
    SQL.Add('   and cod_cliente_fc <> ''REA'' ');
    SQL.Add('   and cod_cliente_fc <> ''EG'' ');

    if CGlobal.gProgramVersion = CGlobal.pvSAT then
    begin
      SQL.Add('   and cod_cliente_fc <> ''REP'' ');
      SQL.Add('   and cod_cliente_fc <> ''BAA'' ');
    end
    else
    begin
      SQL.Add('   and cod_cliente_fc <> ''GAN'' ');
    end;

    SQL.Add(' group by nacional, empresa, cliente, codigoX3, centro, albaran, fecha, empresa_factura, serie_factura, n_factura, fecha_factura, cod_factura, ');
    SQL.Add('          producto, seccion, kilos_albaran, gastos_albaran_euros ');

    SQL.Add(' order by nacional, empresa, cliente, centro, albaran, fecha ');
  end;
end;

procedure TDMAlbaranesFacturadosEn.DesPreparaQuerys;
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i] is TQuery) then
    begin
      with Components[i] as TQuery do
      begin
        Close;
        if Prepared then
          UnPrepare;
      end;
    end;
  end;
end;

function TDMAlbaranesFacturadosEn.ObtenerDatos(var AMsg: string): boolean;
begin
  result := True;

  with QInventarios do
  begin
    if (sEmpresa <> 'BAG') and (sEmpresa <> 'SAT') then
      ParamByName('empresa').AsString := sEmpresa;
    if sSerie <> '' then
      ParamByName('serie').AsString := sSerie;
    if (sCentro <> '') then
      ParamByName('centro').AsString := sCentro;
    if (sProducto <> '') then
      ParamByName('producto').AsString := sProducto;
    if (sPais <> '') then
      ParamByName('pais').AsString := sPais;
    ParamByName('fechaIni').AsdateTime := dFechaIni;
    ParamByName('fechaFin').AsdateTime := dFechaFin;
    Open;
    if IsEmpty then
    begin
      result := false;
      AMsg := 'Sin albaranes para los parametros introducidos.';
    end;
  end;
end;

function TDMAlbaranesFacturadosEn.GrabarDatos(var AMsg: string): boolean;
begin
  while not QInventarios.Eof do
  begin
    with mtResumen do
    begin
      Insert;
      FieldByName('nacional').Asstring := QInventarios.FieldByName('nacional').Asstring;
      FieldByName('cliente').Asstring := QInventarios.FieldByName('cliente').Asstring;
      FieldByName('codigoX3').Asstring := QInventarios.FieldByName('codigoX3').Asstring;
      FieldByName('empresa').Asstring := QInventarios.FieldByName('empresa').Asstring;
      FieldByName('centro').Asstring := QInventarios.FieldByName('centro').Asstring;
      FieldByName('albaran').AsInteger := QInventarios.FieldByName('albaran').AsInteger;
      FieldByName('fecha').AsDateTime := QInventarios.FieldByName('fecha').AsDateTime;

      if QInventarios.FieldByName('n_factura').AsInteger <> 0 then
      begin
        FieldByName('empresa_factura').Asstring := QInventarios.FieldByName('empresa_factura').Asstring;
        FieldByName('n_factura').AsInteger := QInventarios.FieldByName('n_factura').AsInteger;
        FieldByName('fecha_factura').AsDateTime := QInventarios.FieldByName('fecha_factura').AsDateTime;
        FieldByName('cod_factura').AsString := QInventarios.FieldByName('cod_factura').Asstring;
      end;

      FieldByName('producto').Asstring := QInventarios.FieldByName('producto').Asstring;
      FieldByName('seccion').Asstring := QInventarios.FieldByName('seccion').Asstring;

      FieldByName('kilos').AsFloat := QInventarios.FieldByName('kilos_producto').AsFloat;
      FieldByName('importe').AsFloat := QInventarios.FieldByName('euros_sin_gastos').AsFloat;
      if (QInventarios.FieldByName('kilos_albaran').AsFloat <> 0) and (QInventarios.FieldByName('kilos_albaran').AsFloat <> 0) then
      begin
        FieldByName('gastos').AsFloat := (QInventarios.FieldByName('gastos_albaran_euros').AsFloat * QInventarios.FieldByName('kilos_producto').AsFloat) / QInventarios.FieldByName('kilos_albaran').AsFloat;
      end
      else
      begin
        FieldByName('gastos').AsFloat := 0;
      end;
      FieldByName('total').AsFloat := FieldByName('importe').AsFloat - FieldByName('gastos').AsFloat;

      Post;
    end;
    QInventarios.Next;
  end;
  QInventarios.Close;
  result := true;
end;

end.

