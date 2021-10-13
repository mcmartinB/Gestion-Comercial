unit UDMFacResumenClientes;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMFacResumenClientes = class(TDataModule)
    QMainData: TQuery;
    mtResumenCliente: TkbmMemTable;
    mtFacturaAux: TkbmMemTable;
    mtProductosAlbaran: TkbmMemTable;
    mtDescuentos: TkbmMemTable;
    mtGastosAlbaran: TkbmMemTable;
    mtComisiones: TkbmMemTable;
    QAux: TQuery;
    QPesoEnvases: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    iTipoAgrupacion: integer;
    rChange: Real;

    //FACTURA
    sCliente, sEmpresa: string;
    iAnyo, iMes, iSemana, iFactura: integer;
    dFecha: TDateTime;
    rNeto, rIva: Real;
    rDescuento, rComision: real;

    //ALBARAN
    sCentroSalida: string;
    dFechaAlbaran: TDateTime;
    iNAlbaran: integer;
    rKilos, rImporte: Real;
    iCajas, iUnidades, iPalets: Integer;

    function  PreparaQuery( const AEmpresa, ACliente, APais: string;
                            const AFechaIni, AFechaFin: TDateTime;
                            const ATipoCliente, ATipoFactura: integer;
                            const ADesglosarCat: boolean ): boolean;

    procedure RellenarTabla;

    procedure CargaDatosFacturas;
    procedure GetDescuentosCliente( const AEmpresa, ACliente: string;
                const AFecha: TDateTime; var ADescuento, AComision: Real );
    procedure GetDescuentoCliente( const AEmpresa, ACliente: string; const AFecha: TDateTime;
                var AFechaIni, AFechaFin: TDateTime; var AValue: Real );
    procedure GetComisionCliente( const AEmpresa, ACliente: string; const AFecha: TDateTime;
                var AFechaIni, AFechaFin: TDateTime; var AValue: Real );

    procedure CargaDatosAlbaranes;
    procedure CargarGastos;
    procedure ResumenAlbaran;
    procedure GetInfoEnvases( const AEmpresa, AEnvase, AProducto: string;
                              var AUnidades: integer; var APesoNeto: real );

  public
    { Public declarations }
  end;

  function OpenDataResumenFacturasCliente( const AEmpresa, ACliente, APais: string;
                                          const AFechaIni, AFechaFin: TDateTime;
                                          const ATipoCliente, ATipoAgrupacion, ATipoFactura: integer;
                                          const ADesglosarCat: boolean ): boolean;

  procedure CloseDataResumenFacturasCliente;

var
  DMFacResumenClientes: TDMFacResumenClientes;

implementation

{$R *.dfm}

uses
 bMath, DateUtils, Variants;


function OpenDataResumenFacturasCliente( const AEmpresa, ACliente, APais: string;
                                         const AFechaIni, AFechaFin: TDateTime;
                                         const ATipoCliente, ATipoAgrupacion, ATipoFactura: integer;
                                         const ADesglosarCat: boolean ): boolean;
begin
  DMFacResumenClientes:= TDMFacResumenClientes.Create( nil );
  DMFacResumenClientes.iTipoAgrupacion:= ATipoAgrupacion;
  result:= DMFacResumenClientes.PreparaQuery( AEmpresa, ACliente, APais, AFechaIni, AFechaFin,
                                              ATipoCliente, ATipoFactura, ADesglosarCat );
  if result then
  begin
     DMFacResumenClientes.RellenarTabla;
  end;
  result:= True;
end;

procedure CloseDataResumenFacturasCliente;
begin
  FreeAndNil( DMFacResumenClientes );
end;

procedure TDMFacResumenClientes.DataModuleCreate(Sender: TObject);
begin
  mtResumenCliente.FieldDefs.Clear;

  mtResumenCliente.FieldDefs.Add('empresa', ftString, 3, False);
  mtResumenCliente.FieldDefs.Add('cliente', ftString, 3, False);
  mtResumenCliente.FieldDefs.Add('anyo', ftInteger, 0, False);
  mtResumenCliente.FieldDefs.Add('mes', ftInteger, 0, False);
  mtResumenCliente.FieldDefs.Add('semana', ftInteger, 0, False);
  mtResumenCliente.FieldDefs.Add('fecha', ftDate, 0, False);
  mtResumenCliente.FieldDefs.Add('factura', ftInteger, 0, False);
  mtResumenCliente.FieldDefs.Add('neto', ftFloat, 0, False);
  mtResumenCliente.FieldDefs.Add('impuesto', ftFloat, 0, False);
  mtResumenCliente.FieldDefs.Add('total', ftFloat, 0, False);

  mtResumenCliente.FieldDefs.Add('centro_salida', ftString, 1, False);
  mtResumenCliente.FieldDefs.Add('fecha_albaran', ftDate, 0, False);
  mtResumenCliente.FieldDefs.Add('n_albaran', ftInteger, 0, False);

  mtResumenCliente.FieldDefs.Add('producto', ftString, 3, False);
  mtResumenCliente.FieldDefs.Add('envase', ftString, 3, False);
  mtResumenCliente.FieldDefs.Add('categoria', ftString, 2, False);
  mtResumenCliente.FieldDefs.Add('calibre', ftString, 6, False);

  mtResumenCliente.FieldDefs.Add('palets', ftInteger, 0, False);
  mtResumenCliente.FieldDefs.Add('cajas', ftInteger, 0, False);
  mtResumenCliente.FieldDefs.Add('unidades', ftInteger, 0, False);
  mtResumenCliente.FieldDefs.Add('kilos', ftFloat, 0, False);

  mtResumenCliente.FieldDefs.Add('importe', ftFloat, 0, False);
  mtResumenCliente.FieldDefs.Add('iva', ftFloat, 0, False);
  mtResumenCliente.FieldDefs.Add('descuento', ftFloat, 0, False);
  mtResumenCliente.FieldDefs.Add('comision', ftFloat, 0, False);
  mtResumenCliente.FieldDefs.Add('gasto_facturable', ftFloat, 0, False);
  mtResumenCliente.FieldDefs.Add('gasto_general', ftFloat, 0, False);
  mtResumenCliente.FieldDefs.Add('gasto_transito', ftFloat, 0, False);
  mtResumenCliente.FieldDefs.Add('coste_envasado', ftFloat, 0, False);
  mtResumenCliente.FieldDefs.Add('coste_seccion', ftFloat, 0, False);

  mtResumenCliente.CreateTable;
  mtResumenCliente.Open;

  mtProductosAlbaran.FieldDefs.Clear;
  mtProductosAlbaran.FieldDefs.Add('producto', ftString, 3, False);
  mtProductosAlbaran.FieldDefs.Add('palets_totales', ftInteger, 0, False);
  mtProductosAlbaran.FieldDefs.Add('cajas_totales', ftInteger, 0, False);
  mtProductosAlbaran.FieldDefs.Add('unidades_totales', ftInteger, 0, False);
  mtProductosAlbaran.FieldDefs.Add('kilos_totales', ftFloat, 0, False);
  mtProductosAlbaran.FieldDefs.Add('importe_total', ftFloat, 0, False);
  mtProductosAlbaran.FieldDefs.Add('palets_transitos', ftInteger, 0, False);
  mtProductosAlbaran.FieldDefs.Add('cajas_transitos', ftInteger, 0, False);
  mtProductosAlbaran.FieldDefs.Add('unidades_transitos', ftInteger, 0, False);
  mtProductosAlbaran.FieldDefs.Add('kilos_transitos', ftFloat, 0, False);
  mtProductosAlbaran.FieldDefs.Add('importe_transito', ftFloat, 0, False);
  mtProductosAlbaran.CreateTable;
  mtProductosAlbaran.Open;

  mtGastosAlbaran.FieldDefs.Clear;
  mtGastosAlbaran.FieldDefs.Add('producto', ftString, 3, False);
  mtGastosAlbaran.FieldDefs.Add('gasto_general', ftFloat, 0, False);
  mtGastosAlbaran.FieldDefs.Add('gasto_transito', ftFloat, 0, False);
  mtGastosAlbaran.FieldDefs.Add('facturable_general', ftFloat, 0, False);
  mtGastosAlbaran.FieldDefs.Add('facturable_transito', ftFloat, 0, False);

  mtGastosAlbaran.CreateTable;
  mtGastosAlbaran.Open;

  mtDescuentos.FieldDefs.Clear;
  mtDescuentos.FieldDefs.Add('empresa', ftString, 3, False);
  mtDescuentos.FieldDefs.Add('cliente', ftString, 3, False);
  mtDescuentos.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  mtDescuentos.FieldDefs.Add('fecha_fin', ftDate, 0, False);
  mtDescuentos.FieldDefs.Add('descuento', ftFloat, 0, False);
  mtDescuentos.SortFields:= 'empresa;cliente;fecha_ini';
  mtDescuentos.CreateTable;
  mtDescuentos.Open;

  mtComisiones.FieldDefs.Clear;
  mtComisiones.FieldDefs.Add('empresa', ftString, 3, False);
  mtComisiones.FieldDefs.Add('cliente', ftString, 3, False);
  mtComisiones.FieldDefs.Add('fecha_ini', ftDate, 0, False);
  mtComisiones.FieldDefs.Add('fecha_fin', ftDate, 0, False);
  mtComisiones.FieldDefs.Add('comision', ftFloat, 0, False);
  mtComisiones.SortFields:= 'empresa;cliente;fecha_ini';
  mtComisiones.CreateTable;
  mtComisiones.Open;


  mtFacturaAux.FieldDefs.Clear;
  mtFacturaAux.FieldDefs.Add('empresa', ftString, 3, False);
  mtFacturaAux.FieldDefs.Add('cliente', ftString, 3, False);
  mtFacturaAux.FieldDefs.Add('fecha', ftDate, 0, False);
  mtFacturaAux.FieldDefs.Add('factura', ftInteger, 0, False);
  mtFacturaAux.FieldDefs.Add('manual', ftInteger, 0, False);
  mtFacturaAux.FieldDefs.Add('importe_neto', ftFloat, 0, False);
  mtFacturaAux.FieldDefs.Add('impuestos', ftFloat, 0, False);
  mtFacturaAux.CreateTable;
  mtFacturaAux.Open;

end;

procedure TDMFacResumenClientes.DataModuleDestroy(Sender: TObject);
begin
  if QEnvases.Prepared then
    QEnvases.UnPrepare;

  mtResumenCliente.Close;
  FreeAndNil( mtResumenCliente );
  mtProductosAlbaran.Close;
  FreeAndNil( mtProductosAlbaran );
  mtGastosAlbaran.Close;
  FreeAndNil( mtGastosAlbaran );
  mtDescuentos.Close;
  FreeAndNil( mtDescuentos );
  mtComisiones.Close;
  FreeAndNil( mtComisiones );
  mtFacturaAux.Close;
  FreeAndNil( mtFacturaAux );
end;


function TDMFacResumenClientes.PreparaQuery( const AEmpresa, ACliente, APais: string;
                                              const AFechaIni, AFechaFin: TDateTime;
                                              const ATipoCliente, ATipoFactura: integer;
                                              const ADesglosarCat: boolean ): boolean;
begin
  with QMainData do
  begin
    SQL.Clear;
    if ( ATipoFactura = 0 )  or ( ATipoFactura = 1 ) then
    begin
      SQL.Add(' select empresa_f, cliente_fac_f, fecha_factura_f, n_factura_f, 1 tipo_factura_f, ');
      SQL.Add('        importe_neto_f, importe_total_f, importe_euros_f,  ');
      SQL.Add('        centro_salida_sl, fecha_sl, n_albaran_sl, ref_transitos_sl, ');
      SQL.Add('        producto_sl, envase_sl, categoria_sl, calibre_sl, ');
      SQL.Add('        n_palets_sl, cajas_sl, kilos_sl, importe_neto_sl, ''KGS'' unidad_sl ');
      SQL.Add(' from frf_facturas, frf_salidas_c, frf_salidas_l ');

      SQL.Add(' where fecha_factura_f between :fechaini and :fechafin ');

      if AEmpresa <> '' then
        SQL.Add(' and empresa_f = :empresa ');

      case ATipoCliente of
        0: if ACliente <> '' then
             SQL.Add(' and cliente_fac_f = :cliente ');
        1: if APais <> '' then
             SQL.Add(' and exists ( select * from frf_clientes where empresa_c = empresa_f and cliente_c = cliente_fac_f and pais_c = :pais )  ');
        2: SQL.Add(' and exists ( select * from frf_clientes where empresa_c = empresa_f and cliente_c = cliente_fac_f and pais_c <> ''ES'' ) ');
      end;

      SQL.Add(' and tipo_factura_f = 380 and concepto_f = ''A'' ');

      SQL.Add(' --SALIDAS C ');
      SQL.Add(' and empresa_sc = empresa_f ');
      SQL.Add(' and fecha_factura_sc = fecha_factura_f ');
      SQL.Add(' and n_factura_sc = n_factura_f ');

      SQL.Add(' --SALIDAS L ');
      SQL.Add(' and empresa_sl = empresa_sc ');
      SQL.Add(' and centro_salida_sl = centro_salida_sc ');
      SQL.Add(' and fecha_sl = fecha_sc ');
      SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    end;

    if ( ATipoFactura = 0 )  then
    begin
      SQL.Add(' union ');
    end;

    if ( ATipoFactura = 0 )  or ( ATipoFactura = 2 ) then
    begin
      SQL.Add(' select empresa_f, cliente_fac_f, fecha_factura_f, n_factura_f,  0 tipo_factura_f, ');
      SQL.Add('        importe_neto_f, importe_total_f, importe_euros_f,  ');
      SQL.Add('        centro_salida_fal, fecha_albaran_fal, n_albaran_fal,  0 ref_transitos_fal,');
      SQL.Add('        producto_fal, envase_fal, categoria_fal, ''-'' calibre_fal, ');
      SQL.Add('        unidades_fal palets_fal, unidades_fal cajas_fal, unidades_fal kilos_fal, importe_fal, unidad_fal ');

      SQL.Add(' from frf_facturas, frf_fac_abonos_l ');

      SQL.Add(' where fecha_factura_f between :fechaini and :fechafin ');

      if AEmpresa <> '' then
        SQL.Add(' and empresa_f = :empresa ');

      case ATipoCliente of
        0: if ACliente <> '' then
             SQL.Add(' and cliente_fac_f = :cliente ');
        1: if APais <> '' then
             SQL.Add(' and exists ( select * from frf_clientes where empresa_c = empresa_f and cliente_c = cliente_fac_f and pais_c = :pais )  ');
        2: SQL.Add(' and exists ( select * from frf_clientes where empresa_c = empresa_f and cliente_c = cliente_fac_f and pais_c <> ''ES'' ) ');
      end;

      SQL.Add(' and ( ( tipo_factura_f <> 380 ) or ( concepto_f <> ''A'' ) ) ');

      SQL.Add(' and empresa_fal = empresa_f ');
      SQL.Add(' and fecha_fal = fecha_factura_f ');
      SQL.Add(' and factura_fal = n_factura_f ');
    end;

    SQL.Add(' order by empresa_f, cliente_fac_f, fecha_factura_f, n_factura_f, ');
    SQL.Add('          centro_salida_sl, fecha_sl, n_albaran_sl, ');
    SQL.Add('          producto_sl, envase_sl, categoria_sl, calibre_sl ');

    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    if AEmpresa <> '' then
      ParamByName('empresa').AsString:= AEmpresa;
    case ATipoCliente of
      0: if ACliente <> '' then
           ParamByName('cliente').AsString:= ACliente;
      1: if APais <> '' then
           ParamByName('pais').AsString:= APais;
    end;
    Open;
    result:= not IsEmpty;
  end;
  if result then
  begin
    with QEnvases do
    begin
      Sql.Clear;
      Sql.Add(' select nvl(unidades_e,1) unidades_e, peso_neto_e ');
      Sql.Add(' from frf_envases ');
      Sql.Add(' where empresa_e = :empresa ');
      Sql.Add(' and envase_e = :envase ');
      Sql.Add(' and producto_base_e = ( select producto_base_p ');
      Sql.Add('                         from frf_productos ');
      Sql.Add('                         where empresa_p = :empresa ');
      Sql.Add('                           and producto_p = :producto )');
      Prepare;
    end;
  end;
end;

procedure TDMFacResumenClientes.GetComisionCliente( const AEmpresa, ACliente: string; const AFecha: TDateTime;
           var AFechaIni, AFechaFin: TDateTime; var AValue: Real );
begin
  with QAux do
  begin
    SQl.Clear;
    SQl.Add( 'select fecha_ini_rc,  nvl(fecha_fin_rc, Today) fecha_fin_rc, comision_rc ');
    SQl.Add( 'from frf_clientes, frf_representantes_comision ');
    SQl.Add( 'where empresa_c = :empresa ');
    SQl.Add( 'and cliente_c = :cliente ');
    SQl.Add( 'and empresa_rc = :empresa ');
    SQl.Add( 'and representante_rc = representante_c ');
    SQl.Add( 'and :fecha between fecha_ini_rc and nvl(fecha_fin_rc, Today) ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('fecha').AsDateTime:= AFecha;
    Open;
    if IsEmpty then
    begin
      AValue:= 0;
      AFechaIni:= StrToDate( '1/1//200' );
      AFechaFin:= Date;
    end
    else
    begin
      AValue:= FieldByName('comision_rc').AsFloat;
      AFechaIni:= FieldByName('fecha_ini_rc').AsDateTime;
      AFechaFin:= FieldByName('fecha_fin_rc').AsDateTime;
    end;
    Close;
  end;
end;

procedure TDMFacResumenClientes.GetDescuentoCliente( const AEmpresa, ACliente: string; const AFecha: TDateTime;
            var AFechaIni, AFechaFin: TDateTime; var AValue: Real );
begin
  with QAux do
  begin
    SQl.Clear;
    SQl.Add( 'select fecha_ini_cd,  nvl(fecha_fin_cd, Today) fecha_fin_cd, descuento_cd ');
    SQl.Add( 'from frf_clientes_descuento ');
    SQl.Add( 'where empresa_cd = :empresa ');
    SQl.Add( 'and cliente_cd = :cliente ');
    SQl.Add( 'and facturable_cd = 1 ');
    SQl.Add( 'and :fecha between fecha_ini_cd and nvl(fecha_fin_cd, Today) ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('fecha').AsDateTime:= AFecha;
    Open;
    if IsEmpty then
    begin
      AValue:= 0;
      AFechaIni:= StrToDate( '1/1//200' );
      AFechaFin:= Date;
    end
    else
    begin
      AValue:= FieldByName('descuento_cd').AsFloat;
      AFechaIni:= FieldByName('fecha_ini_cd').AsDateTime;
      AFechaFin:= FieldByName('fecha_fin_cd').AsDateTime;
    end;
    Close;
  end;
end;

procedure TDMFacResumenClientes.GetDescuentosCliente( const AEmpresa, ACliente: string;
            const AFecha: TDateTime; var ADescuento, AComision: Real  );
var
  rAux: real;
  bFlag: boolean;
  dFechaIni, dFechaFin: TDateTime;
begin
  ADescuento:= 0;
  with  mtDescuentos do
  begin
    bFlag:= False;
    if locate( 'empresa;cliente', VarArrayOf([AEmpresa, ACliente]), [] ) then
    begin
      while ( not bFlag ) and ( not EOF ) do
      begin
        if ( FieldByName('fecha_ini').AsDateTime <= AFecha ) and
           ( FieldByName('fecha_fin').AsDateTime >= AFecha ) then
        begin
          bFlag:= True;
          ADescuento:= FieldByName('descuento').AsFloat;
        end
        else
        begin
          Next;
        end;
      end;
    end;

    if not bFlag then
    begin
      GetDescuentoCliente( AEmpresa, ACliente, AFecha, dFechaIni, dFechaFin, rAux );
      Insert;
      FieldByName('empresa').AsString:= AEmpresa;
      FieldByName('cliente').AsString:= ACliente;
      FieldByName('fecha_ini').AsDateTime:= dFechaIni;
      FieldByName('fecha_fin').AsDateTime:= dFechaFin;
      FieldByName('descuento').AsFloat:= rAux;
      Post;
      Sort([mtcoDescending]);
      ADescuento:= rAux;
    end;
  end;

  AComision:= 0;
  with  mtComisiones do
  begin
    bFlag:= False;
    if locate( 'empresa;cliente', VarArrayOf([AEmpresa, ACliente]), [] ) then
    begin
      while ( not bFlag ) and ( not EOF )  do
      begin
        if ( FieldByName('fecha_ini').AsDateTime <= AFecha ) and
           ( FieldByName('fecha_fin').AsDateTime >= AFecha ) then
        begin
          bFlag:= True;
          AComision:= FieldByName('comision').AsFloat;
        end
        else
        begin
          Next;
        end;
      end;
    end;

    if not bFlag then
    begin
      GetComisionCliente( AEmpresa, ACliente, AFecha, dFechaIni, dFechaFin, rAux );
      Insert;
      FieldByName('empresa').AsString:= AEmpresa;
      FieldByName('cliente').AsString:= ACliente;
      FieldByName('fecha_ini').AsDateTime:= dFechaIni;
      FieldByName('fecha_fin').AsDateTime:= dFechaFin;
      FieldByName('comision').AsFloat:= rAux;
      Post;
      Sort([mtcoDescending]);
      AComision:= rAux;
    end;
  end;
end;

procedure TDMFacResumenClientes.CargarGastos;
begin
  mtGastosAlbaran.Close;
  mtGastosAlbaran.Open;
  with QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_g, facturable_tg, gasto_transito_tg, sum( importe_g ) importe ');
    SQL.Add(' from frf_gastos, frf_tipo_gastos ');
    SQL.Add(' where empresa_g = :empresa ');
    SQL.Add('   and centro_salida_g = :centro ');
    SQL.Add('   and n_albaran_g = :albaran ');
    SQL.Add('   and fecha_g = :fecha ');
    SQL.Add('   and tipo_tg = tipo_g ');
    SQL.Add(' group by 1,2,3 ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentroSalida;
    ParamByName('fecha').AsDateTime:= dFechaAlbaran;
    ParamByName('albaran').AsInteger:= iNAlbaran;
    Open;
    if not IsEmpty then
    begin
      while not Eof do
      begin
        if mtGastosAlbaran.Locate('producto', VarArrayOf([FieldByName('producto_g').AsString]), [] ) then
        begin
          mtGastosAlbaran.Edit;
          if FieldByName('facturable_tg').AsString = 'S' then
          begin
            if FieldByName('gasto_transito_tg').AsInteger = 1 then
              mtGastosAlbaran.FieldByName('facturable_general').AsFloat:= mtGastosAlbaran.FieldByName('facturable_general').AsFloat + FieldByName('importe').AsFloat
            else
              mtGastosAlbaran.FieldByName('facturable_transito').AsFloat:= mtGastosAlbaran.FieldByName('facturable_transito').AsFloat + FieldByName('importe').AsFloat;
          end
          else
          begin
            if FieldByName('gasto_transito_tg').AsInteger = 1 then
              mtGastosAlbaran.FieldByName('gasto_general').AsFloat:= mtGastosAlbaran.FieldByName('gasto_general').AsFloat + FieldByName('importe').AsFloat
            else
              mtGastosAlbaran.FieldByName('gasto_transito').AsFloat:= mtGastosAlbaran.FieldByName('gasto_transito').AsFloat + FieldByName('importe').AsFloat;
          end;
          mtGastosAlbaran.Post;
        end
        else
        begin
          mtGastosAlbaran.Insert;
          mtGastosAlbaran.FieldByName('producto').AsString:= FieldByName('producto_g').AsString;

          mtGastosAlbaran.FieldByName('facturable_general').AsFloat:= 0;
          mtGastosAlbaran.FieldByName('facturable_transito').AsFloat:= 0;
          mtGastosAlbaran.FieldByName('gasto_general').AsFloat:= 0;
          mtGastosAlbaran.FieldByName('gasto_transito').AsFloat:= 0;

          if FieldByName('facturable_tg').AsString = 'S' then
          begin
            if FieldByName('gasto_transito_tg').AsInteger = 1 then
              mtGastosAlbaran.FieldByName('facturable_general').AsFloat:= FieldByName('importe').AsFloat
            else
              mtGastosAlbaran.FieldByName('facturable_transito').AsFloat:= FieldByName('importe').AsFloat;
          end
          else
          begin
            if FieldByName('gasto_transito_tg').AsInteger = 1 then
              mtGastosAlbaran.FieldByName('gasto_general').AsFloat:= FieldByName('importe').AsFloat
            else
              mtGastosAlbaran.FieldByName('gasto_transito').AsFloat:= FieldByName('importe').AsFloat;
          end;

          mtGastosAlbaran.Post;
        end;
        Next;
      end;
    end;
    Close;
  end;
end;

procedure TDMFacResumenClientes.GetInfoEnvases( const AEmpresa, AEnvase, AProducto: string;
                                               var AUnidades: integer; var APesoNeto: real );
begin
  with QEnvases do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('envase').AsString:= AEnvase;
    ParamByName('producto').AsString:= AProducto;
    Open;
    AUnidades:= FieldByName('unidades_c').AsInteger;
    APesoNeto:= FieldByName('peso_neto_c').AsFloat;
    Close;
  end;
end;

procedure TDMFacResumenClientes.ResumenAlbaran;
var
  iUnidades: integer;
begin
  with mtProductosAlbaran do
  begin
    if Locate('producto', VarArrayOf([FieldByName('producto_g').AsString]), [] ) then
    begin
      //envase_sl -
      //unidad_sl ');

      //segun el tipo de factura

      Edit;
      if QMainData.FieldByName('cajas_sl').AsString  <> '' then
      begin
        FieldByName('palets_totales').AsInteger:= FieldByName('palets_totales').AsInteger + QMainData.FieldByName('n_palets_sl').AsInteger;
        FieldByName('cajas_totales').AsInteger:= FieldByName('cajas_totales').AsInteger + QMainData.FieldByName('cajas_sl').AsInteger;
        FieldByName('unidades_totales').AsInteger:= FieldByName('unidades_totales').AsInteger + QMainData.FieldByName('').AsInteger;
        FieldByName('kilos_totales').AsFloat:= FieldByName('kilos_totales').AsFloat + QMainData.FieldByName('kilos_sl').AsFloat;
        FieldByName('importe_total').AsFloat:= FieldByName('importe_total').AsFloat + QMainData.FieldByName('importe_neto_sl').AsFloat;
      end
      else
      begin
        FieldByName('palets_transitos').AsInteger:= FieldByName('palets_transitos').AsInteger + QMainData.FieldByName('n_palets_sl').AsInteger;
        FieldByName('cajas_transitos').AsInteger:= FieldByName('cajas_transitos').AsInteger + QMainData.FieldByName('cajas_sl').AsInteger;
        FieldByName('unidades_transitos').AsInteger:= FieldByName('unidades_transitos').AsInteger + QMainData.FieldByName('').AsInteger;
        FieldByName('kilos_transitos').AsFloat:= FieldByName('kilos_transitos').AsFloat + QMainData.FieldByName('kilos_sl').AsFloat;
        FieldByName('importe_transito').AsFloat:= FieldByName('importe_transito').AsFloat + QMainData.FieldByName('importe_neto_sl').AsFloat;
      end;
      Post;
    end
    else
    begin
      Insert;
      FieldByName('producto').AsString:= QMainData.FieldByName('producto_g').AsString;
      FieldByName('palets_totales').AsInteger:= QMainData.FieldByName('').AsInteger;
      FieldByName('cajas_totales').AsInteger:= QMainData.FieldByName('').AsInteger;
      FieldByName('unidades_totales').AsInteger:= QMainData.FieldByName('').AsInteger;
      FieldByName('kilos_totales').AsFloat:= QMainData.FieldByName('').AsFloat;
      FieldByName('importe_total').AsFloat:= QMainData.FieldByName('').AsFloat;
      FieldByName('palets_transitos').AsInteger:= QMainData.FieldByName('').AsInteger;
      FieldByName('cajas_transitos').AsInteger:= QMainData.FieldByName('').AsInteger;
      FieldByName('unidades_transitos').AsInteger:= QMainData.FieldByName('').AsInteger;
      FieldByName('kilos_transitos').AsFloat:= QMainData.FieldByName('').AsFloat;
      FieldByName('importe_transito').AsFloat:= QMainData.FieldByName('').AsFloat;
      Post;
    end;
    rKilos:= 0;
    rImporte:= 0;
    iCajas:= 0;
    iUnidades:= 0;
    iPalets:= 0;
  end;
end;

procedure TDMFacResumenClientes.CargaDatosAlbaranes;
begin
  with QMainData do
  begin
    sCentroSalida:= FieldByName('centro_salida_sl').AsString;
    dFechaAlbaran:= FieldByName('fecha_sl').AsDateTime;
    iNAlbaran:=  FieldByName('n_albaran_sl').AsInteger;

    CargarGastos;

    mtProductosAlbaran.Close;
    mtProductosAlbaran.Open;
    rKilos:= 0;
    rImporte:= 0;
    iCajas:= 0;
    iUnidades:= 0;
    iPalets:= 0;
    while ( not Eof ) and ( ( sCentroSalida = FieldByName('centro_salida_sl').AsString ) and
                            ( dFechaAlbaran = FieldByName('fecha_sl').AsDateTime ) and
                            ( iNAlbaran =  FieldByName('n_albaran_sl').AsInteger ) )  do
    begin
      ResumenAlbaran;
      Next;
    end;
  end;
end;

procedure TDMFacResumenClientes.CargaDatosFacturas;
var
  iYear, iMonth, iDay: word;
begin
  with QMainData do
  begin
    sEmpresa:= FieldByName('empresa_f').AsString;
    dFecha:= FieldByName('fecha_factura_f').AsDateTime;
    iFactura:=  FieldByName('n_factura_f').AsInteger;
    sCliente:= FieldByName('cliente_fac_f').AsString;
    DecodeDate( FieldByName('fecha_factura_f').AsDateTime, iYear, iMonth, iDay );
    iAnyo:= iYear;
    iMes:= ( iYear * 100 ) + iMonth;
    iSemana:= ( iYear * 100 ) + WeekOfTheYear( FieldByName('fecha_factura_f').AsDateTime );

    rIva:= FieldByName('importe_total_f').AsFloat - FieldByName('importe_total_f').AsFloat;
    rChange:= bRoundTo( FieldByName('importe_euros_f').AsFloat / FieldByName('importe_total_f').AsFloat , 5 );
    if rIva <> 0 then
    begin
      rIva:= bRoundTo( rIva * rChange , 2 );
      rNeto:= FieldByName('importe_euros_f').AsFloat - rIva;
    end
    else
    begin
      rNeto:= FieldByName('importe_euros_f').AsFloat;
    end;

    GetDescuentosCliente( sEmpresa, sCliente, dFecha, rDescuento, rComision );

    while ( not Eof ) and ( ( sEmpresa = FieldByName('empresa_f').AsString ) and
                            ( dFecha = FieldByName('fecha_factura_f').AsDateTime ) and
                            ( iFactura =  FieldByName('n_factura_f').AsInteger ) )  do
    begin
      CargaDatosAlbaranes;
    end;
  end;
end;

procedure TDMFacResumenClientes.RellenarTabla;
begin
  with QMainData do
  begin
    while not Eof do
    begin
      CargaDatosFacturas;
    end;
  end;
end;

end.
