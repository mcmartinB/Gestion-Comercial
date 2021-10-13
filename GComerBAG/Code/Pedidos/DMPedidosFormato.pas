unit DMPedidosFormato;

interface

uses
  forms, SysUtils, Classes, DB, DBTables;

type
  TdtmMPedidosFormato = class(TDataModule)
    QMaestro: TQuery;
    DSEnlace: TDataSource;
    TDetalle: TTable;
    QNumeroPedido: TQuery;
    QNumeroLinea: TQuery;
    QListado: TQuery;
    QNotas: TQuery;
    DSNotas: TDataSource;
    QSuministro: TQuery;
    QAux: TQuery;
    QMaestroempresa_pdc: TStringField;
    QMaestrocentro_pdc: TStringField;
    QMaestropedido_pdc: TIntegerField;
    QMaestrofecha_pdc: TDateField;
    QMaestroref_pedido_pdc: TStringField;
    QMaestrocliente_pdc: TStringField;
    QMaestrodir_suministro_pdc: TStringField;
    QMaestromoneda_pdc: TStringField;
    QMaestroobservaciones_pdc: TStringField;
    QMaestroanulado_pdc: TIntegerField;
    QMaestromotivo_anulacion_pdc: TStringField;
    TDetalleempresa_pdd: TStringField;
    TDetallecentro_pdd: TStringField;
    TDetallepedido_pdd: TIntegerField;
    TDetallelinea_pdd: TIntegerField;
    TDetalleproducto_pdd: TStringField;
    TDetalleproducto_base_pdd: TSmallintField;
    TDetalleformato_cliente_pdd: TStringField;
    TDetalleenvase_pdd: TStringField;
    TDetallemarca_pdd: TStringField;
    TDetallecategoria_pdd: TStringField;
    TDetallecalibre_pdd: TStringField;
    TDetallecolor_pdd: TStringField;
    TDetallecantidad_pdd: TFloatField;
    TDetalleunidad_pdd: TStringField;
    TDetallepalets_pdd: TIntegerField;
    TDetallecajas_pdd: TIntegerField;
    TDetalleunidades_pdd: TIntegerField;
    TDetallekilos_pdd: TFloatField;
    TDetallecajas_aservir_pdd: TIntegerField;
    TDetalleprecio_pdd: TFloatField;
    TDetalleunidad_precio_pdd: TStringField;
    TDetalletipo_iva_pdd: TStringField;
    TDetalleporc_iva_pdd: TFloatField;
    TDetalleimporte_neto_pdd: TFloatField;
    TDetalleiva_pdd: TFloatField;
    TDetalleimporte_total_pdd: TFloatField;
    TDetalledesFormatoCli: TStringField;
    TDetalledesUnidadPedido: TStringField;
    QCajasServidas: TQuery;
    QCajasAServir: TQuery;
    QMaestrofinalizado_pdc: TIntegerField;
    QPedidoAServir: TQuery;
    QIncedencia: TQuery;
    QObservacion: TQuery;
    TDetallecajas_servidas: TIntegerField;
    QCajasServidasLinea: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TDetalleCalcFields(DataSet: TDataSet);
  private

  public
    function  NuevaPedido( const AEmpresa, ACentro: string ): integer;
    function  NuevaLinea( const AEmpresa, ACentro: string; const APedido: integer ): integer;
    function  DirSumValida( const AEmpresa, ACliente, ADirSum: string ): boolean;
    procedure QueryListado( const AEmpresa, ACentro, ACliente, AProducto, APedido:string;
                                            const AFechaIni, AFechaFin: TDateTime  );

    function DatosFormatoCliente( const AEmpresa, ACliente, ASuministro, AFormatoCliente: string;
      var ADesFormato, ATipoPalet, ATipoEnvase, AUnidadPedido, AUnidadFacturacion, AProducto: string;
      var AProductoBase, ACajasPalet, AUnidadesCaja: integer;
      var APesoVariable: boolean; var ANetoCaja: Real;
      var AMarca, ACategoria, ACalibre, AColor: string ): boolean;

    function FinalizarPedido( const AEmpresa, ACentro, APedido: string; var AMessage: string ): boolean;
    function ForzarFinPedido( const AEmpresa, ACentro, APedido, AMessage: string ): boolean;
    procedure GrabarIncidencia( const AEmpresa, ACentro, APedido, AMessage: string );

    function CajasServidasLinea(const AEmpresa, ACentro, APedido,
      AProducto, AFormatoCli, ACategoria, ACalibre: string): integer;    
  end;

procedure CrearModuloDeDatos;
procedure DestruirModuloDeDatos;

var
  dtmMPedidosFormato: TdtmMPedidosFormato;

implementation

uses UDMAuxDB, Dialogs, Windows;

{$R *.dfm}
var
  iConexiones: Integer;

procedure CrearModuloDeDatos;
begin
  if iConexiones = 0 then
  begin
    dtmMPedidosFormato:= TdtmMPedidosFormato.Create( application );
  end;
  Inc( iConexiones );
end;

procedure DestruirModuloDeDatos;
begin
  Dec( iConexiones );
  if iConexiones = 0 then
  begin
    FreeAndNil( dtmMPedidosFormato );
  end;
end;

function TdtmMPedidosFormato.NuevaPedido( const AEmpresa, ACentro: string ): integer;
begin
  QNumeroPedido.ParamByName('empresa').AsString:= AEmpresa;
  QNumeroPedido.ParamByName('centro').AsString:= ACentro;
  QNumeroPedido.Open;
  Result:= QNumeroPedido.Fields[0].AsInteger + 1;
  QNumeroPedido.Close;
end;

function TdtmMPedidosFormato.NuevaLinea( const AEmpresa, ACentro: string;
                                const APedido: integer ): integer;
begin
  QNumeroLinea.ParamByName('empresa').AsString:= AEmpresa;
  QNumeroLinea.ParamByName('centro').AsString:= ACentro;
  QNumeroLinea.ParamByName('pedido').AsInteger:= APedido;
  QNumeroLinea.Open;
  Result:= QNumeroLinea.Fields[0].AsInteger + 1;
  QNumeroLinea.Close;
end;

function TdtmMPedidosFormato.DirSumValida( const AEmpresa, ACliente, ADirSum: string ): boolean;
begin
  if ( ACliente = ADirSum ) and ( ACliente <> '' ) then
  begin
    result:= true;
  end
  else
  begin
    QSuministro.ParamByName('cliente').AsString:= ACliente;
    QSuministro.ParamByName('dirsum').AsString:= ADirSum;
    QSuministro.Open;
    Result:= not QSuministro.IsEmpty;
    QSuministro.Close;
  end;
end;

procedure TdtmMPedidosFormato.QueryListado( const AEmpresa, ACentro, ACliente, AProducto, APedido:string;
                                            const AFechaIni, AFechaFin: TDateTime  );
var
  iProducto: integer;
begin
  QListado.SQL.Clear;
  QListado.SQL.Add(' select ');
  QListado.SQL.Add('        empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedido_pdc, cliente_pdc,  ');
  QListado.SQL.Add('        dir_suministro_pdc, anulado_pdc, motivo_anulacion_pdc, producto_base_pdd,  ');
  QListado.SQL.Add('        producto_pdd, formato_cliente_pdd, marca_pdd, categoria_pdd, calibre_pdd, ');
  QListado.SQL.Add('        color_pdd,unidad_pdd, sum(cantidad_pdd) cantidad_pdd, ');
  QListado.SQL.Add('        sum(cajas_pdd) cajas_pdd, sum(cajas_aservir_pdd) cajas_aservir_pdd  ');

  QListado.SQL.Add(' from frf_pedido_cab cab, frf_pedido_det det ');

  QListado.SQL.Add(' where empresa_pdc = empresa_pdd ');
  QListado.SQL.Add(' and centro_pdc = centro_pdd ');
  QListado.SQL.Add(' and pedido_pdc = pedido_pdd ');
  QListado.SQL.Add(' and empresa_pdc = :empresa ');
  QListado.SQL.Add(' and centro_pdc = :centro ');
  QListado.SQL.Add(' and fecha_pdc between :inicio and :fin ');
  if ACliente <> '' then
    QListado.SQL.Add(' and cliente_pdc = :cliente ');
  if APedido <> '' then
    QListado.SQL.Add(' and ref_pedido_pdc = :pedido ');

  if AProducto <> '' then
    QListado.SQL.Add(' and producto_pdd = :producto ');

  QListado.SQL.Add(' group by ');
  QListado.SQL.Add('        empresa_pdc, centro_pdc, pedido_pdc, fecha_pdc, ref_pedido_pdc, cliente_pdc,  ');
  QListado.SQL.Add('        dir_suministro_pdc, anulado_pdc, motivo_anulacion_pdc, producto_base_pdd,  ');
  QListado.SQL.Add('        producto_pdd, formato_cliente_pdd, marca_pdd, categoria_pdd, calibre_pdd, ');
  QListado.SQL.Add('        color_pdd,unidad_pdd');

  QListado.SQL.Add(' order by empresa_pdc, centro_pdc, cliente_pdc, dir_suministro_pdc, fecha_pdc, ref_pedido_pdc,  ');
  QListado.SQL.Add('        producto_pdd, formato_cliente_pdd, categoria_pdd, calibre_pdd, color_pdd ');

  QListado.ParamByName('empresa').AsString:= AEmpresa;
  QListado.ParamByName('centro').AsString:= ACentro;
  QListado.ParamByName('inicio').AsDateTime:= AFechaIni;
  QListado.ParamByName('fin').AsDateTime:= AFechaFin;
  if ACliente <> '' then
    QListado.ParamByName('cliente').AsString:= ACliente;
  if APedido <> '' then
    QListado.ParamByName('pedido').AsString:= APedido;
  if AProducto <> '' then
    QListado.ParamByName('producto').AsString:= AProducto;
end;

procedure TdtmMPedidosFormato.DataModuleCreate(Sender: TObject);
begin
  QNumeroPedido.SQL.Clear;
  QNumeroPedido.SQL.Add(' select max(nvl(pedido_pdc,0)) ');
  QNumeroPedido.SQL.Add(' from frf_pedido_cab ');
  QNumeroPedido.SQL.Add(' where empresa_pdc = :empresa ');
  QNumeroPedido.SQL.Add(' and centro_pdc = :centro ');
  QNumeroPedido.Prepare;

  QNumeroLinea.SQL.Clear;
  QNumeroLinea.SQL.Add(' select max(nvl(linea_pdd,0)) ');
  QNumeroLinea.SQL.Add(' from frf_pedido_det ');
  QNumeroLinea.SQL.Add(' where empresa_pdd = :empresa ');
  QNumeroLinea.SQL.Add(' and centro_pdd = :centro ');
  QNumeroLinea.SQL.Add(' and pedido_pdd = :pedido ');
  QNumeroLinea.Prepare;

  QSuministro.SQL.Clear;
  QSuministro.SQL.Add(' select dir_sum_ds ');
  QSuministro.SQL.Add(' from frf_dir_sum ');
  QSuministro.SQL.Add(' where cliente_ds = :cliente ');
  QSuministro.SQL.Add(' and dir_sum_ds = :dirsum ');
  QSuministro.Prepare;

  QNotas.SQL.Clear;
  QNotas.SQL.Add(' select observaciones_pdc ');
  QNotas.SQL.Add(' from frf_pedido_cab  ');
  QNotas.SQL.Add(' where empresa_pdc = :empresa_pdc ');
  QNotas.SQL.Add(' and centro_pdc = :centro_pdc ');
  QNotas.SQL.Add(' and pedido_pdc = :pedido_pdc ');
  QNotas.Prepare;

  QPedidoAServir.SQL.Clear;
  QPedidoAServir.SQL.Add(' select * from frf_pedido_cab ');
  QPedidoAServir.SQL.Add(' where empresa_pdc = :empresa ');
  QPedidoAServir.SQL.Add(' and centro_pdc = :centro ');
  QPedidoAServir.SQL.Add(' and pedido_pdc = :pedido ');
  QPedidoAServir.Prepare;

  QCajasAServir.SQL.Clear;
  QCajasAServir.SQL.Add(' select formato_cliente_pdd formato, sum(cajas_aservir_pdd) cajas ');
  //QCajasAServir.SQL.Add(' select envase_pdd formato, sum(cajas_aservir_pdd) cajas ');
  QCajasAServir.SQL.Add(' from frf_pedido_det ');
  QCajasAServir.SQL.Add(' where empresa_pdd = :empresa ');
  QCajasAServir.SQL.Add(' and centro_pdd = :centro ');
  QCajasAServir.SQL.Add(' and pedido_pdd = :pedido ');
  QCajasAServir.SQL.Add(' group by 1 ');
  QCajasAServir.SQL.Add(' order by 1 ');
  QCajasAServir.Prepare;

  QCajasServidas.SQL.Clear;
  QCajasServidas.SQL.Add(' select formato_cliente_pl formato, sum(cajas_pl) cajas ');
  //QCajasServidas.SQL.Add(' select envase_pl formato, sum(cajas_pl) cajas ');
  QCajasServidas.SQL.Add(' from frf_orden_carga_c, frf_packing_list ');
  QCajasServidas.SQL.Add(' where empresa_occ = :empresa ');
  QCajasServidas.SQL.Add(' and centro_salida_occ = :centro ');
  QCajasServidas.SQL.Add(' and cliente_sal_occ = :cliente ');
  QCajasServidas.SQL.Add(' and dir_sum_occ = :suministro ');
  QCajasServidas.SQL.Add(' and n_pedido_occ = :pedido ');
  QCajasServidas.SQL.Add(' and fecha_pedido_occ = :fecha ');
  QCajasServidas.SQL.Add(' and orden_pl = orden_occ ');
  QCajasServidas.SQL.Add(' group by 1 ');
  QCajasServidas.SQL.Add(' order by 1 ');
  QCajasServidas.Prepare;


  QCajasServidasLinea.SQL.Clear;
  QCajasServidasLinea.SQL.Add(' select sum( cajas_sl ) servidas ');
  QCajasServidasLinea.SQL.Add(' from frf_pedido_cab, frf_salidas_c, frf_salidas_l ');

  QCajasServidasLinea.SQL.Add(' where empresa_pdc = :empresa_pdd ');
  QCajasServidasLinea.SQL.Add(' and centro_pdc = :centro_pdd  ');
  QCajasServidasLinea.SQL.Add(' and pedido_pdc = :pedido_pdd  ');

  QCajasServidasLinea.SQL.Add(' and empresa_sc = :empresa_pdd ');
  QCajasServidasLinea.SQL.Add(' and centro_salida_sc = :centro_pdd ');
  QCajasServidasLinea.SQL.Add(' and fecha_sc >= fecha_pdc ');
  QCajasServidasLinea.SQL.Add(' and n_pedido_sc = ref_pedido_pdc ');
  QCajasServidasLinea.SQL.Add(' and cliente_sal_sc = cliente_pdc ');
  QCajasServidasLinea.SQL.Add(' and dir_sum_sc = dir_suministro_pdc ');

  QCajasServidasLinea.SQL.Add(' and empresa_sl = :empresa_pdd ');
  QCajasServidasLinea.SQL.Add(' and centro_salida_sl = :centro_pdd ');
  QCajasServidasLinea.SQL.Add(' and fecha_sl = fecha_sc ');
  QCajasServidasLinea.SQL.Add(' and n_albaran_sl = n_albaran_sc ');

  QCajasServidasLinea.SQL.Add(' and producto_sl = :producto_pdd ');
  QCajasServidasLinea.SQL.Add(' and formato_cliente_sl = :formato_cliente_pdd ');
  QCajasServidasLinea.SQL.Add(' and categoria_sl = :categoria_pdd ');
  QCajasServidasLinea.SQL.Add(' and calibre_sl = :calibre_pdd ');
  QCajasServidasLinea.Prepare;


  QObservacion.SQL.Clear;
  QObservacion.SQL.Add(' select observaciones_pdc from frf_pedido_cab ');
  QObservacion.SQL.Add(' where empresa_pdc = :empresa ');
  QObservacion.SQL.Add(' and centro_pdc = :centro ');
  QObservacion.SQL.Add(' and pedido_pdc = :pedido ');
  QObservacion.Prepare;

  QIncedencia.SQL.Clear;
  QIncedencia.SQL.Add(' update frf_pedido_cab ');
  QIncedencia.SQL.Add(' set observaciones_pdc = :incidencia  ');
  QIncedencia.SQL.Add(' where empresa_pdc = :empresa ');
  QIncedencia.SQL.Add(' and centro_pdc = :centro ');
  QIncedencia.SQL.Add(' and pedido_pdc = :pedido ');
  QIncedencia.Prepare;
end;

procedure TdtmMPedidosFormato.DataModuleDestroy(Sender: TObject);
begin
  QNumeroPedido.Close;
  if QNumeroPedido.Prepared then
    QNumeroPedido.UnPrepare;

    QNumeroLinea.Close;
  if QNumeroLinea.Prepared  then
    QNumeroLinea.UnPrepare;

  QSuministro.Close;
  if QSuministro.Prepared  then
    QSuministro.UnPrepare;

  QNotas.Close;
  if QNotas.Prepared  then
    QNotas.UnPrepare;

  QPedidoAServir.Close;
  if QPedidoAServir.Prepared  then
    QPedidoAServir.UnPrepare;

  QCajasAServir.Close;
  if QCajasAServir.Prepared  then
    QCajasAServir.UnPrepare;

  QCajasServidas.Close;
  if QCajasServidas.Prepared  then
    QCajasServidas.UnPrepare;

  QCajasServidasLinea.Close;
  if QCajasServidasLinea.Prepared  then
    QCajasServidasLinea.UnPrepare;

  QObservacion.Close;
  if QObservacion.Prepared  then
    QObservacion.UnPrepare;

  QIncedencia.Close;
  if QIncedencia.Prepared  then
    QIncedencia.UnPrepare;
end;

function TdtmMPedidosFormato.DatosFormatoCliente( const AEmpresa, ACliente, ASuministro, AFormatoCliente: string;
      var ADesFormato, ATipoPalet, ATipoEnvase, AUnidadPedido, AUnidadFacturacion, AProducto: string;
      var AProductoBase, ACajasPalet, AUnidadesCaja: integer;
      var APesoVariable: boolean; var ANetoCaja: Real;
      var AMarca, ACategoria, ACalibre, AColor: string ): boolean;
var
  sFormato: string;
begin
  (*TODO*)
  //Un formato de cliente puede corresponder a varios nuestros, deberiamos
  //dar a elegir cual corresponde??
  //Añadimos un campo que sea cual es que usamos por defecto ???
  with QAux do
  begin
    //Seleccionamos formato
    SQL.Clear;
    SQL.Add(' select formato_fc, descripcion_fc, unidad_pedido_fc ');
    SQL.Add(' from frf_formatos_cli, frf_formatos ');
    SQL.Add(' where empresa_fc = :empresa ');
    SQL.Add(' and cliente_fc = :cliente ');
    SQL.Add(' and suministro_fc = :dirSum ');
    SQL.Add(' and formato_cliente_fc = :formatoCliente ');
    SQL.Add(' and empresa_fc = empresa_f ');
    SQL.Add(' and formato_fc = codigo_f ');
    SQL.Add(' and fecha_baja_f is  null ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('dirsum').AsString:= ASuministro;
    ParamByName('formatoCliente').AsString:= AFormatoCliente;

    Open;

    if IsEmpty then
    begin
      Close;
      ParamByName('dirsum').AsString:= '*';
      Open;

      if IsEmpty then
      begin
        Close;
        ParamByName('dirsum').AsString:= '';
        Open;
      end;
    end;

    if IsEmpty then
    begin
      result:= False;

      ADesFormato:= '';
      ATipoPalet:= '';
      ATipoEnvase:= '';
      AUnidadPedido:= '';
      AUnidadFacturacion:= '';
      AProducto:= '';
      AProductoBase:= -1;
      ACajasPalet:= 0;
      AUnidadesCaja:= 0;
      APesoVariable:= False;
      ANetoCaja:= 0;

      Close;
    end
    else
    begin
      result:= True;

      ADesFormato:= FieldByName('descripcion_fc').AsString;
      AUnidadPedido:= FieldByName('unidad_pedido_fc').AsString;
      sFormato:= FieldByName('formato_fc').AsString;
      Close;

      SQL.Clear;
      SQL.Add(' select productop_f, producto_f, envase_f, palet_f, n_cajas_f, ');
      SQL.Add('        marca_f, categoria_f, calibre_f, color_f ');
      SQL.Add(' from frf_formatos ');
      SQL.Add(' where empresa_f = :empresa ');
      SQL.Add(' and codigo_f = :formato ');

      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('formato').AsString:= sFormato;

      Open;

      AProducto:=FieldByName('productop_f').AsString;
      AProductoBase:= FieldByName('producto_f').AsInteger;
      ATipoEnvase:= FieldByName('envase_f').AsString;
      ATipoPalet:= FieldByName('palet_f').AsString;
      ACajasPalet:= FieldByName('n_cajas_f').AsInteger;

      AMarca:= FieldByName('marca_f').AsString;
      ACategoria:= FieldByName('categoria_f').AsString;
      ACalibre:= FieldByName('calibre_f').AsString;
      AColor:= FieldByName('color_f').AsString;

      Close;

      SQL.Clear;
      SQL.Add(' select peso_variable_e, peso_neto_e, unidades_e ');
      SQL.Add(' from frf_envases ');
      SQL.Add(' where ( producto_e = :producto or producto_e is null ) ');
      SQL.Add(' and envase_e = :envase  ');

      ParamByName('producto').AsString:= AProducto;
      ParamByName('envase').AsString:= ATipoEnvase;

      Open;

      APesoVariable:= FieldByName('peso_variable_e').AsInteger = 1;
      ANetoCaja:= FieldByName('peso_neto_e').AsFloat;
      AUnidadesCaja:= FieldByName('unidades_e').AsInteger;

      Close;

      SQL.Clear;
      SQL.Add(' select unidad_fac_ce ');
      SQL.Add(' from frf_clientes_env ');
      SQL.Add(' where empresa_ce = :empresa ');
      SQL.Add(' and ( producto_ce = :producto or producto_ce is null ) ');
      SQL.Add(' and envase_ce = :envase ');
      SQL.Add(' and cliente_ce = :cliente ');

      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('producto').AsString:= AProducto;
      ParamByName('envase').AsString:= ATipoEnvase;
      ParamByName('cliente').AsString:= ACliente;

      Open;

      if not IsEmpty then
      begin
        AUnidadFacturacion:= FieldByName('unidad_fac_ce').AsString;
        if AUnidadFacturacion = '' then
          AUnidadFacturacion:= AUnidadPedido;
      end
      else
      begin
        AUnidadFacturacion:= AUnidadPedido;
      end;

      Close;

{
      SQL.Clear;
      SQL.Add(' select producto_pb ');
      SQL.Add(' from frf_productos_base ');
      SQL.Add(' where empresa_pb = :empresa ');
      SQL.Add(' and producto_base_pb = :producto ');

      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('producto').AsInteger:= AProductoBase;

      Open;
      AProducto:= FieldByName('producto_pb').AsString;

      Close;
}
    end;
  end;
end;

procedure TdtmMPedidosFormato.TDetalleCalcFields(DataSet: TDataSet);
begin
  if not ( (DataSet.State = dsEdit ) or ( DataSet.State = dsInsert ) ) then
  begin
    TDetalledesFormatoCli.AsString:= desFormatoCliente( TDetalleempresa_pdd.AsString,
      QMaestrocliente_pdc.AsString, QMaestrodir_suministro_pdc.AsString,
      TDetalleformato_cliente_pdd.AsString, QMaestrofecha_pdc.AsString );

    if TDetalleunidad_pdd.AsString = 'K' then
    begin
      TDetalledesUnidadPedido.AsString:= 'KILOS';
    end
    else
    if TDetalleunidad_pdd.AsString = 'C' then
    begin
      TDetalledesUnidadPedido.AsString:= 'CAJAS';
    end
    else
    if TDetalleunidad_pdd.AsString = 'U' then
    begin
      TDetalledesUnidadPedido.AsString:= 'UNIDADES';
    end
    else
    begin
      TDetalledesUnidadPedido.AsString:= '';
    end;

    TDetallecajas_servidas.AsInteger:= CajasServidasLinea( TDetalleempresa_pdd.AsString,
                                                         TDetallecentro_pdd.AsString,
                                                         TDetallepedido_pdd.AsString,
                                                         TDetalleproducto_pdd.AsString,
                                                         TDetalleformato_cliente_pdd.AsString,
                                                         TDetallecategoria_pdd.AsString,
                                                         TDetallecalibre_pdd.AsString );
  end;
end;

function StrDifServido( const AFormato, ACajasAservir, ACajasServidas: string ): string;
begin
  result:= 'Formato= ' + AFormato + ' - Pedido: ' + ACajasAservir + ' - Servido: ' + ACajasServidas + #13 + #10;
end;

function TdtmMPedidosFormato.FinalizarPedido( const AEmpresa, ACentro, APedido: string; var AMessage: string ): boolean;
var
  bFlag: boolean;
begin
  result:= False;
  AMessage:= '';

  with QPedidoAServir do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('pedido').AsString:= APedido;
    Open;
    if IsEmpty then
    begin
      Close;
      AMessage:= 'No existe pedido.';
      Exit;
    end;
  end;

  with QCajasAServir do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('pedido').AsString:= APedido;
    Open;
    if IsEmpty then
    begin
      Close;
      QPedidoAServir.Close;
      AMessage:= 'No existe detalle del pedido.';
      Exit;
    end;
  end;

  with QCajasServidas do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('cliente').AsString:= QPedidoAServir.FieldByName('cliente_pdc').AsString;
    ParamByName('suministro').AsString:= QPedidoAServir.FieldByName('dir_suministro_pdc').AsString;
    ParamByName('pedido').AsString:= QPedidoAServir.FieldByName('ref_pedido_pdc').AsString;
    ParamByName('fecha').AsDateTime:= QPedidoAServir.FieldByName('fecha_pdc').AsDateTime;
    Open;
    if IsEmpty then
    begin
      Close;
      QPedidoAServir.Close;
      QCajasAServir.Close;
      AMessage:= 'No se han cargado cajas para el pedido seleccionado.';
      Exit;
    end;
  end;

  bFlag:= True;
  QPedidoAServir.Close;
  while not QCajasServidas.Eof or not QCajasAServir.Eof do
  begin
    if QCajasServidas.FieldByName('formato').AsString = QCajasAServir.FieldByName('formato').AsString Then
    begin
      AMessage:= AMessage + StrDifServido( QCajasServidas.FieldByName('formato').AsString,
                                             QCajasAServir.FieldByName('cajas').AsString,
                                             QCajasServidas.FieldByName('cajas').AsString );
      if QCajasServidas.FieldByName('cajas').AsString <> QCajasAServir.FieldByName('cajas').AsString then
      begin
         bFlag:= False;
      end;
      QCajasServidas.Next;
      QCajasAServir.Next;
    end
    else
    if QCajasAServir.FieldByName('formato').AsString < QCajasServidas.FieldByName('formato').AsString  Then
    begin
      bFlag:= False;
      AMessage:= AMessage + StrDifServido( QCajasAServir.FieldByName('formato').AsString,
                                           QCajasAServir.FieldByName('cajas').AsString, '0' );
      QCajasAServir.Next;
    end
    else
    begin
      bFlag:= False;
      AMessage:= AMessage + StrDifServido( QCajasServidas.FieldByName('formato').AsString,
                                           '0', QCajasServidas.FieldByName('cajas').AsString );
      QCajasServidas.Next;
    end;
  end;

  QCajasAServir.Close;
  QCajasServidas.Close;

  result:= bFlag;
  if result then
  begin
    AMessage:= 'OK' + #13 + #10 + AMessage ;
  end
  else
  begin
    AMessage:= Trim( 'No coincide lo pedido con lo servido' + #13 + #10 + AMessage );
  end;
end;

function TdtmMPedidosFormato.ForzarFinPedido( const AEmpresa, ACentro, APedido, AMessage: string ): boolean;
var
  sAux: string;
begin
  result:= False;
  if Application.MessageBox( PChar( 'ERROR: ' + AMessage + #13 + #10 + #13 + #10 +
                          '¿Esta seguro que quiere finalizar el pedido?' + #13 + #10 ),
                          'PEDIDO NO FINALIZADO', MB_YESNO ) = IDYES then
  begin
    sAux:= '';
    (*TODO*)
    (*InputQuery -> myInputQuery*)
    if InputQuery( 'INCIDENCIA PEDIDO', 'Por favor describa motivo descuadre pedido/servido:', sAux ) then
    begin
      if Trim(sAux) = '' then
      begin
        ShowMessage('Operación cancelada. No puede dejar la incidencia en blanco.');
      end
      else
      begin
        GrabarIncidencia( AEmpresa, ACentro, APedido, sAux );
        result:= True;
      end;
    end
    else
    begin
      ShowMessage('Operación cancelada.');
    end;
  end
  else
  begin
    ShowMessage('Operación cancelada.');
  end;
end;

procedure TdtmMPedidosFormato.GrabarIncidencia( const AEmpresa, ACentro, APedido, AMessage: string );
var
  sAux: string;
begin
  with QObservacion do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('pedido').AsString:= APedido;
    Open;
    if Trim( FieldByName('observaciones_pdc').AsString ) <> '' then
    begin
      sAux:= 'INCIDENCIA FIN PEDIDO: ' + #13 + #10 + AMessage + #13 + #10 + #13 + #10 +
             Trim( FieldByName('observaciones_pdc').AsString );
    end
    else
    begin
      sAux:= 'INCIDENCIA FIN PEDIDO: ' + #13 + #10 + AMessage;
    end;
  end;

  with QIncedencia do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('pedido').AsString:= APedido;
    ParamByName('incidencia').AsString:= sAux;
    ExecSQL;
  end;
end;


function TdtmMPedidosFormato.CajasServidasLinea(const AEmpresa, ACentro, APedido,
  AProducto, AFormatoCli, ACategoria, ACalibre: string): integer;
begin
  QCajasServidasLinea.ParamByName('empresa_pdd').AsString:= AEmpresa;
  QCajasServidasLinea.ParamByName('centro_pdd').AsString:= ACentro;
  QCajasServidasLinea.ParamByName('pedido_pdd').AsString:= APedido;
  QCajasServidasLinea.ParamByName('producto_pdd').AsString:= AProducto;
  QCajasServidasLinea.ParamByName('formato_cliente_pdd').AsString:= AFormatoCli;
  QCajasServidasLinea.ParamByName('categoria_pdd').AsString:= ACategoria;
  QCajasServidasLinea.ParamByName('calibre_pdd').AsString:= ACalibre;
  try
    QCajasServidasLinea.Open;
    result:= QCajasServidasLinea.FieldByName('servidas').AsInteger;
  finally
    QCajasServidasLinea.Close;
  end;
end;

initialization
  iConexiones:= 0;

end.
