unit UMDEntregas_SAT;

interface

uses
  SysUtils, Classes, DBTables, DB, EntregasCB;

type
  TMDEntregas_SAT = class(TDataModule)
    QEntregasC: TQuery;
    DSMaestro: TDataSource;
    TEntregasL: TTable;
    TEntregasRel: TTable;
    QListEntregasC: TQuery;
    DSListMaestro: TDataSource;
    TListEntregasL: TTable;
    TListEntregasRel: TTable;
    QTotalLineas: TQuery;
    QGastosEntregas: TQuery;
    TListGastosEntregas: TTable;
    TListPackingList: TQuery;
    TListStatusPacking: TQuery;
    TListCalibrePacking: TQuery;
    TListFechasPacking: TQuery;
    QAux: TQuery;
    QCalidad: TQuery;
    QCalidadcodigo_eca: TStringField;
    QCalidadempresa_eca: TStringField;
    QCalidadcliente_eca: TStringField;
    QCalidadenvase_eca: TStringField;
    QCalidadfecha_eca: TDateField;
    QCalidadporcentaje_eca: TFloatField;
    QCalidaddesCliente: TStringField;
    QCalidaddesEnvase: TStringField;
    QDestrioCalidad: TQuery;
    QCalidadproducto_eca: TStringField;
    QMaterial: TQuery;
    QTotalFacturaCompra: TQuery;
    procedure TEntregasLAfterDelete(DataSet: TDataSet);
    procedure TEntregasLAfterPost(DataSet: TDataSet);
    procedure QEntregasCAfterOpen(DataSet: TDataSet);
    procedure QEntregasCBeforeClose(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TEntregasLBeforePost(DataSet: TDataSet);
    procedure QEntregasCBeforePost(DataSet: TDataSet);
    procedure TEntregasRelAfterPost(DataSet: TDataSet);
    procedure QGastosEntregasBeforePost(DataSet: TDataSet);
    procedure TEntregasRelAfterDelete(DataSet: TDataSet);
    procedure QEntregasCBeforeDelete(DataSet: TDataSet);
    procedure QCalidadCalcFields(DataSet: TDataSet);
    procedure QCalidadAfterDelete(DataSet: TDataSet);
    procedure QCalidadBeforeDelete(DataSet: TDataSet);
    procedure QCalidadAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    sEntrega, sCodEntrega: string;
    procedure MarcarParaEnviar;
  public
    { Public declarations }
    procedure ObtenerDatos( const AParametros: REntregasQL; const AVerResumen, AVerBorrados: Boolean );
    procedure QueryPacking( const AVerBorrados: boolean );
    procedure PutSQL( const AWhere: String );
    procedure DestrioCalidad( const AEntrega: string );
    function  GetDestrioCalidad( const AEntrega: string ): real;
  end;

procedure LoadModule( APadre: TComponent );
procedure UnloadModule;
function  OpenData( const APadre: TComponent; const AParametros: REntregasQL; const AVerResumen, AVerBorrados: Boolean ): integer;

var
  MDEntregas_SAT: TMDEntregas_SAT;

implementation

{$R *.dfm}

uses Dialogs, UDMConfig, Variants, CVariables, UDMAuxDB;

var
  iContadorUso: integer = 0;
                                

function GetTextoSQL( AParametros: REntregasQL ): String;
begin
  if AParametros.sProducto <> '' then
  begin
    result:= ' SELECT codigo_ec, empresa_ec, proveedor_ec, fecha_origen_ec, albaran_ec, fecha_llegada_ec, ';
    result:= result + '    vehiculo_ec, ';
    result:= result + '    observaciones_ec ';
    result:= result + ' FROM frf_entregas_c ec, frf_entregas_l el';
    if AParametros.sEmpresa <> 'SAT' then
      result:= result + ' Where empresa_ec = ' + QuotedStr( AParametros.sEmpresa )
    else
      result:= result + ' Where empresa_ec in (''050'', ''080'') ';
    result:= result + ' and fecha_llegada_ec between :fechaini and :fechafin ';

    if AParametros.sCentro <> '' then
    begin
      result:= result + ' and centro_llegada_ec = ' + QuotedStr( AParametros.sCentro );
    end;
    if AParametros.sProveedor <> '' then
    begin
      result:= result + ' and TRIM(proveedor_ec) = ' + QuotedStr( AParametros.sProveedor );
      if AParametros.sAlmacen <> '' then
      begin
        result:= result + ' and almacen_ec = ' + QuotedStr( AParametros.sAlmacen );
      end;
    end;

    if AParametros.sEntrega <> '' then
    begin
      result:= result + ' and codigo_ec = ' + QuotedStr( AParametros.sEntrega );
    end;
    if AParametros.sAlbaran <> '' then
    begin
      result:= result + ' and albaran_ec = ' + QuotedStr( AParametros.sAlbaran );
    end;
    if AParametros.sAdjudicacion <> '' then
    begin
      result:= result + ' and adjudicacion_ec = ' + QuotedStr( AParametros.sAdjudicacion );
    end;

    case AParametros.iStatus of
      0,1: result:= result + ' and status_ec = ' + IntToStr( AParametros.iStatus );
    end;

    begin
      case AParametros.iMercado of
        0,1: result:= result + ' and mercado_local_ec = ' + IntToStr( AParametros.iMercado );
      end;
    end;

    result:= result + ' and codigo_el = codigo_ec ';
    result:= result + ' and producto_el = ' + QuotedStr( AParametros.sProducto );

    result:= result + ' GROUP BY 1,2,3,4,5,6,7,8,9,10 ';
    result:= result + ' ORDER BY empresa_ec, proveedor_ec, fecha_origen_ec DESC, codigo_ec ';
  end
  else
  begin
    result:= ' SELECT codigo_ec, empresa_ec, proveedor_ec, fecha_origen_ec, albaran_ec, fecha_llegada_ec, ';
    result:= result + '    vehiculo_ec, ';
    result:= result + '    observaciones_ec ';
    result:= result + ' FROM frf_entregas_c ';
    if AParametros.sEmpresa <> 'SAT' then
      result:= result + ' Where empresa_ec = ' + QuotedStr( AParametros.sEmpresa )
    else
      result:= result + ' Where empresa_ec in (''050'', ''080'') ';

    result:= result + ' and fecha_llegada_ec between :fechaini and :fechafin ';
    if AParametros.sCentro <> '' then
    begin
      result:= result + ' and centro_llegada_ec = ' + QuotedStr( AParametros.sCentro );
    end;
    if AParametros.sProveedor <> '' then
    begin
      result:= result + ' and TRIM(proveedor_ec) = ' + QuotedStr( AParametros.sProveedor );
      if AParametros.sAlmacen <> '' then
      begin
        result:= result + ' and almacen_ec = ' + QuotedStr( AParametros.sAlmacen );
      end;
    end;

    if AParametros.sEntrega <> '' then
    begin
      result:= result + ' and codigo_ec = ' + QuotedStr( AParametros.sEntrega );
    end;
    if AParametros.sAlbaran <> '' then
    begin
      result:= result + ' and albaran_ec = ' + QuotedStr( AParametros.sAlbaran );
    end;
    if AParametros.sAdjudicacion <> '' then
    begin
      result:= result + ' and adjudicacion_ec = ' + QuotedStr( AParametros.sAdjudicacion );
    end;

    case AParametros.iStatus of
      0,1: result:= result + ' and status_ec = ' + IntToStr( AParametros.iStatus );
    end;

    begin
      case AParametros.iMercado of
        0,1: result:= result + ' and mercado_local_ec = ' + IntToStr( AParametros.iMercado );
      end;
    end;

    result:= result + ' ORDER BY empresa_ec, proveedor_ec, fecha_origen_ec DESC, codigo_ec ';
  end;
end;

procedure LoadModule( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      MDEntregas_SAT:= TMDEntregas_SAT.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
end;

procedure UnloadModule;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if MDEntregas_SAT <> nil then
      begin
        FreeAndNil( MDEntregas_SAT );
      end;
    end;
  end;
end;

procedure TMDEntregas_SAT.PutSQL( const AWhere: String );
begin
  with QListEntregasC do
  begin
    SQL.Clear;
    SQL.Add( ' SELECT codigo_ec, empresa_ec, proveedor_ec, fecha_origen_ec, albaran_ec, fecha_llegada_ec, vehiculo_ec,');
    SQL.Add( '      observaciones_ec, almacen_ec  ');
    SQL.Add( ' FROM frf_entregas_c ');
    SQL.Add( AWhere );
    SQL.Add( 'ORDER BY empresa_ec, proveedor_ec, fecha_origen_ec DESC, codigo_ec ');
  end;
end;

procedure TMDEntregas_SAT.ObtenerDatos( const AParametros: REntregasQL; const AVerResumen, AVerBorrados: Boolean );
begin
  TListEntregasL.Close;
  TListEntregasRel.Close;
  TListPackingList.Close;
  TListFechasPacking.Close;
  TListStatusPacking.Close;
  TListCalibrePacking.Close;
  QListEntregasC.Close;
  QListEntregasC.SQL.Clear;
  QListEntregasC.SQL.Text:= GetTextoSQL( AParametros );
  QListEntregasC.ParamByName('fechaini').AsDate:= AParametros.dFechaDesde;
  QListEntregasC.ParamByName('fechafin').AsDate:= AParametros.dFechaHasta;
  QListEntregasC.Open;

  if AParametros.sProducto <> '' then
  begin
    TListEntregasL.Filter:= 'producto_el = ' + QuotedStr( AParametros.sProducto );
    TListEntregasL.Filtered:= true;
    TListEntregasRel.Filter:= 'producto_er = ' + QuotedStr( AParametros.sProducto );
    TListEntregasRel.Filtered:= true;
    TListPackingList.Filter:= 'producto = ' + QuotedStr( AParametros.sProducto );
    TListPackingList.Filtered:= true;
    TListStatusPacking.Filter:= 'producto = ' + QuotedStr( AParametros.sProducto );
    TListStatusPacking.Filtered:= true;
    TListCalibrePacking.Filter:= 'producto = ' + QuotedStr( AParametros.sProducto );
    TListCalibrePacking.Filtered:= true;
  end
  else
  begin
    TListEntregasL.Filtered:= False;
    TListEntregasRel.Filtered:= False;
    TListPackingList.Filtered:= False;
    TListStatusPacking.Filtered:= False;
    TListCalibrePacking.Filtered:= False;
    TListEntregasL.Filter:= '';
    TListEntregasRel.Filter:= '';
    TListPackingList.Filter:= '';
    TListStatusPacking.Filter:= '';
    TListCalibrePacking.Filter:= '';
  end;

  if AParametros.bPrintDetalle then
  begin
    TListEntregasL.Open;
  end;
  if not ( DMConfig.EsLaFont  ) then
  begin
    if AParametros.bPrintPacking then
    begin
      QueryPacking( AVerBorrados );
      TListPackingList.Open;
      TListFechasPacking.Open;
      if AVerResumen then
      begin
        TListStatusPacking.Open;
        TListCalibrePacking.Open;
      end;
    end;
  end;
  if AParametros.bPrintEntrada then
  begin
    TListEntregasRel.Open;
  end;
end;

function  OpenData( const APadre: TComponent; const AParametros: REntregasQL; const AVerResumen, AVerBorrados: Boolean ): integer;
begin
  //LoadModule( APadre );
  MDEntregas_SAT.ObtenerDatos( AParametros, AVerResumen, AVerBorrados );
  result:= MDEntregas_SAT.QListEntregasC.RecordCount;
  //UnLoadModule;
end;
procedure TMDEntregas_SAT.TEntregasLAfterDelete(DataSet: TDataSet);
begin
  MarcarParaEnviar;
  QTotalLineas.Close;
  QTotalLineas.Open;
end;

procedure TMDEntregas_SAT.TEntregasLAfterPost(DataSet: TDataSet);
begin
  MarcarParaEnviar;
  QTotalLineas.Close;
  QTotalLineas.Open;
end;

procedure TMDEntregas_SAT.TEntregasLBeforePost(DataSet: TDataSet);
var
  rAux: Real;
begin
  if DataSet.FieldByName('precio_el').Value = null then
    DataSet.FieldByName('precio_el').AsFloat:= 0;
  if DataSet.FieldByName('unidades_el').Value = null then
    DataSet.FieldByName('unidades_el').AsInteger:= 0;

  rAux:= DataSet.FieldByName('precio_el').AsFloat;
  DataSet.FieldByName('precio_kg_el').AsFloat:= 0;

  case DataSet.FieldByName('unidad_precio_el').AsInteger of
    0: begin
         rAux:= DataSet.FieldByName('kilos_el').AsFloat * rAux;
         DataSet.FieldByName('precio_kg_el').AsFloat:= DataSet.FieldByName('precio_el').AsFloat;
       end;
    1: begin
         rAux:= DataSet.FieldByName('cajas_el').AsFloat * rAux;
         if DataSet.FieldByName('kilos_el').AsFloat <> 0 then
         begin
           DataSet.FieldByName('precio_kg_el').AsFloat:= rAux / DataSet.FieldByName('kilos_el').AsFloat;
         end;
       end;
    2: begin
         rAux:= DataSet.FieldByName('unidades_el').AsFloat * rAux;
         if DataSet.FieldByName('kilos_el').AsFloat <> 0 then
         begin
           DataSet.FieldByName('precio_kg_el').AsFloat:= rAux / DataSet.FieldByName('kilos_el').AsFloat;
         end;
       end;
  end;
end;

procedure TMDEntregas_SAT.QEntregasCAfterOpen(DataSet: TDataSet);
begin
  TEntregasL.Open;
  TEntregasRel.Open;
  QTotalLineas.Open;
  QTotalFacturaCompra.Open;
  QCalidad.Open;
  QMaterial.Open;
end;

procedure TMDEntregas_SAT.QEntregasCBeforeClose(DataSet: TDataSet);
begin
  QCalidad.Close;
  QMaterial.Close;
  QTotalLineas.Close;
  QTotalFacturaCompra.Close;
  TEntregasRel.Close;
  TEntregasL.Close;
end;


procedure TMDEntregas_SAT.DataModuleCreate(Sender: TObject);
begin
  with QTotalLineas do
  begin
    SQL.Clear;
    SQL.Add(' select sum(palets_el) palets, sum(cajas_el) cajas, sum(kilos_el) kilos, ');
    SQL.Add('        sum( case ');
    SQL.Add('                when unidad_precio_el = 0 then round(kilos_el * precio_el,2) ');
    SQL.Add('                when unidad_precio_el = 1 then round(cajas_el * precio_el,2) ');
    SQL.Add('                else round(unidades_el * precio_el,2) ');
    SQL.Add('             end ) importe ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el = :codigo_ec ');
    Prepare;
  end;
  with QTotalFacturaCompra do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_ge) importe, max(fecha_fac_ge ) fecha_factura ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :codigo_ec ');
    //010 en BAG
    //110 en SAT
//    SQL.Add(' and tipo_ge = ''110''  ');
    SQL.Add(' and tipo_ge = ''054''  ');     //Cambios 061 por 054, para unificar tipo gasto de SAT  y BAG
    Prepare;
  end;
  with QCalidad do
  begin
    SQL.Clear;
    SQL.Add(' select *');
    SQL.Add(' from frf_entregas_calidad  ');
    SQL.Add(' where codigo_eca = :codigo_ec  ');
    Prepare;
  end;

  with QMaterial do
  begin
    SQL.Clear;
    SQL.Add(' SELECT empresa_em, centro_em, cod_proveedor_em, fecha_em, codigo_em, ');
    SQL.Add('        cod_operador_em, cod_producto_em, entrada_em, salida_em, ');
    SQL.Add('        notas_em  ');
    //SQL.Add('        notas_em , ( select max(des_producto_ecp) from frf_env_comer_productos ');
    //SQL.Add('                     where cod_operador_ecp = cod_operador_em ');
    //SQL.Add('                     and cod_producto_ecp = cod_producto_em ) des_envase ');
    SQL.Add(' FROM  frf_entregas_mat ');
    SQL.Add(' where empresa_em = :empresa_ec ');
    SQL.Add(' and cod_proveedor_em =  :proveedor_ec ');
    SQL.Add(' and codigo_em = :albaran_ec ');
    SQL.Add(' and fecha_em = :fecha_carga_ec ');
    Prepare;
  end;

  with QGastosEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :codigo_ec ');
    SQL.Add(' order by linea_ge ');
    Prepare;
  end;
  with TListPackingList do
  begin
    SQL.Clear;
    SQL.Add(' select lote, sscc, calibre, status,  ');
    SQL.Add('        ( select descripcion_breve_pp from frf_productos_proveedor ');
    SQL.Add('        where proveedor_pp = proveedor ');
    SQL.Add('        and producto_pp = producto and variedad_pp = variedad ) descripcion, ');
    SQL.Add('           sum(cajas) cajas, ');
    SQL.Add('           sum(peso_bruto) peso_bruto, ');
    SQL.Add('           sum(peso) peso ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    SQL.Add(' and status <> ''B'' ');  //Borrados
    SQL.Add(' group by lote, sscc, calibre, status, 5 ');
    SQL.Add(' order by lote, sscc ');
  end;
  with TListFechasPacking do
  begin
    SQL.Clear;
    SQL.Add(' select min(fecha_alta) min_fecha, max(fecha_alta) max_fecha ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    SQL.Add(' and status <> ''B''  ');
  end;
  with TListStatusPacking do
  begin
    SQL.Clear;
    SQL.Add(' select status,  ');
    SQL.Add('           sum(cajas) cajas, ');
    SQL.Add('           sum(peso_bruto) peso_bruto, ');
    SQL.Add('           sum(peso) peso ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    SQL.Add(' and status <> ''B'' ');  //Borrados
    SQL.Add(' group by status ');
    SQL.Add(' order by status ');
  end;
  with TListCalibrePacking do
  begin
    SQL.Clear;
    SQL.Add(' select calibre,  ');
    SQL.Add('           sum(cajas) cajas, ');
    SQL.Add('           sum(peso_bruto) peso_bruto, ');
    SQL.Add('           sum(peso) peso ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    SQL.Add(' and status <> ''B'' ');  //Borrados
    SQL.Add(' group by calibre ');
    SQL.Add(' order by calibre ');
  end;
end;

procedure TMDEntregas_SAT.QueryPacking( const AVerBorrados: boolean );
begin
  with TListPackingList do
  begin
    SQL.Clear;
    SQL.Add(' select lote, sscc, calibre, status,  ');
    SQL.Add('        ( select descripcion_breve_pp from frf_productos_proveedor ');
    SQL.Add('        where proveedor_pp = proveedor ');
    SQL.Add('        and producto_pp = producto and variedad_pp = variedad ) descripcion, ');
    SQL.Add('           sum(cajas) cajas, ');
    SQL.Add('           sum(peso_bruto) peso_bruto, ');
    SQL.Add('           sum(peso) peso ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    if not AVerBorrados then
      SQL.Add(' and status <> ''B'' ');  //Borrados
    SQL.Add(' group by lote, sscc, calibre, status, 5 ');
    SQL.Add(' order by lote, sscc ');
  end;
  with TListFechasPacking do
  begin
    SQL.Clear;
    SQL.Add(' select min(fecha_alta) min_fecha, max(fecha_alta) max_fecha ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    if not AVerBorrados then
      SQL.Add(' and status <> ''B'' ');  //Borrados
  end;  
  with TListStatusPacking do
  begin
    SQL.Clear;
    SQL.Add(' select status,  ');
    SQL.Add('           sum(cajas) cajas, ');
    SQL.Add('           sum(peso_bruto) peso_bruto, ');
    SQL.Add('           sum(peso) peso ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    if not AVerBorrados then
      SQL.Add(' and status <> ''B'' ');  //Borrados
    SQL.Add(' group by status ');
    SQL.Add(' order by status ');
  end;
  with TListCalibrePacking do
  begin
    SQL.Clear;
    SQL.Add(' select calibre,  ');
    SQL.Add('           sum(cajas) cajas, ');
    SQL.Add('           sum(peso_bruto) peso_bruto, ');
    SQL.Add('           sum(peso) peso ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    if not AVerBorrados then
      SQL.Add(' and status <> ''B'' ');  //Borrados
    SQL.Add(' group by calibre ');
    SQL.Add(' order by calibre ');
  end;
end;

procedure TMDEntregas_SAT.DataModuleDestroy(Sender: TObject);
begin
  if QTotalLineas.Prepared then
  begin
    QTotalLineas.Close;
    QTotalLineas.UnPrepare;
  end;
  if QTotalFacturaCompra.Prepared then
  begin
    QTotalFacturaCompra.Close;
    QTotalFacturaCompra.UnPrepare;
  end;
  if QCalidad.Prepared then
  begin
    QCalidad.Close;
    QCalidad.UnPrepare;
  end;
  if QMaterial.Prepared then
  begin
    QMaterial.Close;
    QMaterial.UnPrepare;
  end;
  if QGastosEntregas.Prepared then
  begin
    QGastosEntregas.Close;
    QGastosEntregas.UnPrepare;
  end;
  if TListPackingList.Prepared then
  begin
    TListPackingList.Close;
    TListPackingList.UnPrepare;
  end;
  if TListFechasPacking.Prepared then
  begin
    TListFechasPacking.Close;
    TListFechasPacking.UnPrepare;
  end;
  if TListStatusPacking.Prepared then
  begin
    TListStatusPacking.Close;
    TListStatusPacking.UnPrepare;
  end;
  if TListCalibrePacking.Prepared then
  begin
    TListCalibrePacking.Close;
    TListCalibrePacking.UnPrepare;
  end;
end;

procedure TMDEntregas_SAT.QEntregasCBeforePost(DataSet: TDataSet);
begin
  QEntregasC.FieldByName('envio_ec').AsInteger:= 0;
end;

procedure TMDEntregas_SAT.TEntregasRelAfterPost(DataSet: TDataSet);
begin
  MarcarParaEnviar;
end;

procedure TMDEntregas_SAT.TEntregasRelAfterDelete(DataSet: TDataSet);
begin
  MarcarParaEnviar;
end;

procedure TMDEntregas_SAT.MarcarParaEnviar;
begin
  if QEntregasC.FieldByName('envio_ec').AsInteger <> 0 then
  begin
    QEntregasC.Edit;
    try
      QEntregasC.FieldByName('envio_ec').AsInteger:= 0;
      QEntregasC.Post;
    except
      QEntregasC.Cancel;
    end;
  end;
end;

procedure TMDEntregas_SAT.QGastosEntregasBeforePost(DataSet: TDataSet);
begin
  QGastosEntregas.FieldByName('envio_ge').AsInteger:= 0;
end;

procedure TMDEntregas_SAT.QEntregasCBeforeDelete(DataSet: TDataSet);
begin
  sEntrega:= DataSet.FieldByname('codigo_ec').AsString;
end;

procedure TMDEntregas_SAT.QCalidadCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('desCliente').AsString:= DesCliente( DataSet.FieldByName('cliente_eca').AsString );
  DataSet.FieldByName('desEnvase').AsString:= desEnvase( DataSet.FieldByName('empresa_eca').AsString,
                                                           DataSet.FieldByName('envase_eca').AsString );
end;

procedure TMDEntregas_SAT.QCalidadAfterPost(DataSet: TDataSet);
begin
  DestrioCalidad( DataSet.FieldByName('codigo_eca').AsString );
end;

procedure TMDEntregas_SAT.QCalidadBeforeDelete(DataSet: TDataSet);
begin
  sCodEntrega:= DataSet.FieldByName('codigo_eca').AsString;
end;

procedure TMDEntregas_SAT.QCalidadAfterDelete(DataSet: TDataSet);
begin
  DestrioCalidad( sCodEntrega );
end;

procedure TMDEntregas_SAT.DestrioCalidad( const AEntrega: string );
var
  rAux: real;
begin
  with QDestrioCalidad do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('        100 - ( nvl(tomate_verde_ec,0) + ');
    SQL.Add('        (select nvl(sum(nvl(porcentaje_eca,0)),0) from frf_entregas_calidad where codigo_eca = :codigo ) ) destrio_ec ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where codigo_ec = :codigo ');
    ParamByName('codigo').AsString:= AEntrega;
    Open;
    rAux:= FieldByName('destrio_ec').AsFloat;
    Close;
    SQL.Clear;
    SQL.Add(' update frf_entregas_c ');
    SQL.Add(' set destrio_ec = :valor ');
    SQL.Add(' where codigo_ec = :codigo ');
    ParamByName('codigo').AsString:= AEntrega;
    ParamByName('valor').AsFloat:= rAux;
    ExecSQL;
  end;
end;

function TMDEntregas_SAT.GetDestrioCalidad( const AEntrega: string ): real;
begin
  with QDestrioCalidad do
  begin
    SQL.Clear;
    SQL.Add(' select destrio_ec ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where codigo_ec = :codigo ');
    ParamByName('codigo').AsString:= AEntrega;
    Open;
    result:= FieldByName('destrio_ec').AsFloat;
    Close;
  end;
end;

end.
