unit RecadvDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLRecadv = class(TDataModule)
    QCab: TQuery;
    QLin: TQuery;
    QObs: TQuery;
    DSCab: TDataSource;
    QAlbaranDet: TQuery;
    QLinList: TQuery;
    QCabList: TQuery;
    QObsList: TQuery;
    DSCAbList: TDataSource;
    QAlbaranCabList: TQuery;
    QAlbaranDetList: TQuery;
    QCajasLogifruit: TQuery;
    QPalets: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure QCabAfterOpen(DataSet: TDataSet);
    procedure QCabBeforeClose(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QLinFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    iLon: integer;

  public
    { Public declarations }

    procedure VisualizarRecepcion( const ACodeList: string );
    procedure FiltrarRecepcion( const AEmpresa, AAlbaran, APedido, AMatricula: string;
                                const AFechaIni, AFechaFin: TDateTime );
    procedure VerDetalleRecadv( const ATipo: Integer );

    procedure ObtenerDatosListado;
    procedure CerrarDatosListado;
  end;

var
  DLRecadv: TDLRecadv;

implementation

{$R *.dfm}

procedure TDLRecadv.DataModuleCreate(Sender: TObject);
begin
  with QCab do
  begin
    Close;
    Sql.Clear;
    SQL.Add(' select empresa_ecr Empresa, ');
    SQL.Add('        centro_salida_ecr Centro, ');
    SQL.Add('        fcarga_ecr Fecha, ');
    SQL.Add('        numalb_ecr ALbaran, ');
    SQL.Add('        numped_ecr Pedido, ');
    SQL.Add('        matric_ecr Matricula, ');
    SQL.Add('        IDCAB_ECR clave ');
    SQL.Add(' from edi_cabcre ');
    SQL.Add(' order by fecha desc, empresa, albaran ');
    Prepare;
  end;

  with Qlin do
  begin
    Sql.Clear;
    SQL.Add(' select ');
    SQL.Add('        REFCLI_ELR codigo_cli, ');
    SQL.Add('        ( select max(descripcion_ce) from frf_clientes_env where REFCLI_ELR = SubStr(Trim(descripcion_ce),1,5) ) descripcion_cli, ');
    SQL.Add('        ( select max(unidad_fac_ce) from frf_clientes_env where REFCLI_ELR = SubStr(Trim(descripcion_ce),1,5) ) unidad_cli, ');
    SQL.Add('        CANTUE_ELR unidades_caja, ');
    SQL.Add('        CANTACE_ELR unidades, ');
    SQL.Add('        case when CANTUE_ELR <> 0 then round( CANTACE_ELR / CANTUE_ELR ) else 0 end cajas ');

    SQL.Add(' from edi_lincre ');
    SQL.Add(' where idcab_elr = :clave ');
    //SQL.Add(' group by 1,2,3,4 ');
    SQL.Add(' order by REFCLI_ELR ');

    iLon:= 5;
    Filtered:= True;

    Prepare;
  end;

  with QObs do
  begin
    Sql.Clear;
    SQL.Add(' select texto1_eor, texto2_eor, texto3_eor, texto4_eor, texto5_eor ');
    SQL.Add(' from edi_obscabre ');
    SQL.Add(' where idcab_eor = :clave ');
    Prepare;
  end;

  with QPalets do
  begin
    Sql.Clear;

    SQL.Add(' select ');
    SQL.Add('            tipo_palets_sl codigo, ');
    SQL.Add('            ( select descripcion_tp from frf_tipo_palets ');
    SQL.Add('              where codigo_tp = tipo_palets_sl ) descripcion, ');

    SQL.Add('         sum(n_palets_sl) palets ');

    SQL.Add('  from frf_salidas_l ');

    SQL.Add('  where empresa_sl = :empresa ');
    SQL.Add('  and centro_salida_sl = :centro ');
    SQL.Add('  and n_albaran_sl = :albaran ');
    SQL.Add('  and fecha_sl = :fecha ');

    SQL.Add('  group by 1,2 ');
    SQL.Add('  order by descripcion ');

    Prepare;
  end;

  with QCajasLogifruit do
  begin
    Sql.Clear;

    SQL.Add(' select ');
    (*LOGI*)
    SQL.Add('            ( select env_comer_producto_e from frf_envases ');
    SQL.Add('              where empresa_e = :empresa  and envase_e = envase_sl and producto_base_e = ( select producto_base_p from frf_productos ');
    SQL.Add('                                         where empresa_p = :empresa and producto_p = producto_sl ) ) codigo, ');
    (*LOGI*)
    SQL.Add('            ( select ( Select des_producto_ecp From frf_env_comer_productos ');
    SQL.Add('                       Where cod_operador_ecp = env_comer_operador_e ');
    SQL.Add('                         and cod_producto_ecp = env_comer_producto_e ) from frf_envases ');
    SQL.Add('              where empresa_e = :empresa  and envase_e = envase_sl and producto_base_e = ( select producto_base_p from frf_productos ');
    SQL.Add('                                         where empresa_p = :empresa and producto_p = producto_sl ) ) descripcion, ');

    SQL.Add('         sum(cajas_sl) cajas ');

    SQL.Add('  from frf_salidas_l ');

    SQL.Add('  where empresa_sl = :empresa ');
    SQL.Add('  and centro_salida_sl = :centro ');
    SQL.Add('  and n_albaran_sl = :albaran ');
    SQL.Add('  and fecha_sl = :fecha ');

    SQL.Add('  group by 1,2 ');
    SQL.Add('  order by descripcion ');

    Prepare;
  end;

  with QAlbaranDet do
  begin
    Sql.Clear;

    SQL.Add(' select ');
    SQL.Add('         envase_sl envase, ');

    SQL.Add('         nvl( ( select descripcion_ce from frf_clientes_env ');
    SQL.Add('           where empresa_ce = :empresa and cliente_ce = cliente_sl ');
    SQL.Add('             and envase_ce = envase_sl and producto_base_ce = ( select producto_base_p from frf_productos ');
    SQL.Add('                                         where empresa_p = :empresa and producto_p = producto_sl ) ), ');
    SQL.Add('            ( select descripcion_e from frf_envases ');
    SQL.Add('              where empresa_e = :empresa  and envase_e = envase_sl and producto_base_e = ( select producto_base_p from frf_productos ');
    SQL.Add('                                         where empresa_p = :empresa and producto_p = producto_sl ) ) )descripcion, ');

    SQL.Add('         nvl( ( select unidad_fac_ce from frf_clientes_env ');
    SQL.Add('           where empresa_ce = :empresa and cliente_ce = cliente_sl ');
    SQL.Add('             and envase_ce = envase_sl and producto_base_ce = ( select producto_base_p from frf_productos ');
    SQL.Add('                                         where empresa_p = :empresa and producto_p = producto_sl ) ), ''K'' ) unidad_factura, ');

    SQL.Add('         sum(n_palets_sl) palets, ');
    SQL.Add('         sum(cajas_sl) cajas, ');
    SQL.Add('         sum(cajas_sl * unidades_caja_sl ) unidades, ');
    SQL.Add('         sum( kilos_sl ) kilos ');

    SQL.Add('  from frf_salidas_l ');

    SQL.Add('  where empresa_sl = :empresa ');
    SQL.Add('  and centro_salida_sl = :centro ');
    SQL.Add('  and n_albaran_sl = :albaran ');
    SQL.Add('  and fecha_sl = :fecha ');

    SQL.Add('  group by 1,2,3 ');
    SQL.Add('  order by descripcion ');

    Prepare;
  end;
end;

procedure TDLRecadv.DataModuleDestroy(Sender: TObject);
begin
  with Qlin do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QObs do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QCajasLogifruit do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QAlbaranDet do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QPalets do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QCab do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
end;

procedure TDLRecadv.VisualizarRecepcion( const ACodeList: string );
begin
  with QCab do
  begin
    Close;
    Sql.Clear;
    SQL.Add(' select empresa_ecr Empresa, ');
    SQL.Add('        centro_salida_ecr Centro, ');
    SQL.Add('        fcarga_ecr Fecha, ');
    SQL.Add('        numalb_ecr ALbaran, ');
    SQL.Add('        numped_ecr Pedido, ');
    SQL.Add('        matric_ecr Matricula, ');
    SQL.Add('        IDCAB_ECR clave ');
    SQL.Add(' from edi_cabcre ');
    if Trim(ACodeList) <> '' then
      SQL.Add(' where idcab_ecr in (' + ACodeList + ')');
    SQL.Add(' order by fecha desc, empresa, albaran ');
    Open;
  end;
end;

procedure TDLRecadv.FiltrarRecepcion( const AEmpresa, AAlbaran, APedido, AMatricula: string;
                                      const AFechaIni, AFechaFin: TDateTime );
begin
  with QCab do
  begin
    Close;
    Sql.Clear;
    SQL.Add(' select empresa_ecr Empresa, ');
    SQL.Add('        centro_salida_ecr Centro, ');
    SQL.Add('        fcarga_ecr Fecha, ');
    SQL.Add('        numalb_ecr ALbaran, ');
    SQL.Add('        numped_ecr Pedido, ');
    SQL.Add('        matric_ecr Matricula, ');
    SQL.Add('        IDCAB_ECR clave ');
    SQL.Add(' from edi_cabcre ');
    SQL.Add(' where ( select empresa_e from frf_empresas where codigo_ean_e = proveedor_ecr ) = :empresa ');
    SQL.Add('   and fcarga_ecr between :fechaini and :fechafin ');
    if AAlbaran <> '' then
      SQL.Add('   and numalb_ecr = :albaran ');
    if APedido <> '' then
      SQL.Add('   and numped_ecr = :pedido ');
    if AMatricula <> '' then
      SQL.Add('   and matric_ecr matches ''*:matricula*'' ');
    SQL.Add(' order by fecha desc, empresa, albaran ');

    ParamByName('empresa').Asstring:= AEmpresa;
    ParamByName('fechaini').AsDateTime:= AFechaIni;
    ParamByName('fechafin').AsDateTime:= AFechaFin;
    if AAlbaran <> '' then
      ParamByName('albaran').Asstring:= AAlbaran;
    if APedido <> '' then
      ParamByName('pedido').Asstring:= APedido;
    if AMatricula <> '' then
      ParamByName('matricula').Asstring:= AMatricula;

    Open;
  end;
end;

procedure TDLRecadv.VerDetalleRecadv( const ATipo: Integer );
begin
  case ATipo of
    0: iLon:= 5;
    1: iLon:= 3;
    2: iLon:= 2;
  end;
  QLin.Close;
  QLin.Open;
end;

procedure TDLRecadv.QLinFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:= length( DataSet.FieldByname('codigo_cli').AsString ) = iLon;
end;

procedure TDLRecadv.QCabAfterOpen(DataSet: TDataSet);
begin
  QLin.Open;
  QObs.Open;
  QPalets.Open;
  QAlbaranDet.Open;
  QCajasLogifruit.Open;
end;

procedure TDLRecadv.QCabBeforeClose(DataSet: TDataSet);
begin
  QLin.Close;
  QObs.Close;
  QPalets.Close;
  QAlbaranDet.Close;
  QCajasLogifruit.Close;
end;

procedure TDLRecadv.ObtenerDatosListado;
begin
  with QCabList do
  begin
    Sql.Clear;
    SQL.Add(' select empresa_ecr Empresa, ');
    SQL.Add('        centro_salida_ecr Centro, ');
    SQL.Add('        fcarga_ecr Fecha, ');
    SQL.Add('        numalb_ecr ALbaran, ');
    SQL.Add('        numped_ecr Pedido, ');
    SQL.Add('        matric_ecr Matricula, ');
    SQL.Add('        IDCAB_ECR clave ');
    SQL.Add(' from edi_cabcre ');
    SQL.Add(' where IDCAB_ECR = :clave  ');
    SQL.Add(' order by fecha desc, empresa, albaran ');
    Open;
  end;

  with QlinList do
  begin
    Sql.Clear;
    SQL.Add(' select ');
    SQL.Add('        elr0.EAN_ELR ean13, ');
    SQL.Add('        ( select ean.envase_e from frf_ean13 ean where elr0.EAN_ELR = ean.codigo_e ) envase_ean, ');
    SQL.Add('        ( select ean.descripcion_e from frf_ean13 ean where elr0.EAN_ELR = ean.codigo_e ) descripcion_ean, ');
    SQL.Add('        elr0.REFCLI_ELR codigo_cli, ');
    SQL.Add('        ( select max(cli.envase_ce) from frf_clientes_env cli where elr0.REFCLI_ELR = SubStr(Trim(cli.descripcion_ce),1,5) ) envase_cli, ');
    SQL.Add('        ( select max(cli.descripcion_ce) from frf_clientes_env cli where elr0.REFCLI_ELR = SubStr(Trim(cli.descripcion_ce),1,5) ) descripcion_cli, ');
    SQL.Add('        CANTUE_ELR unidades_caja, ');
    SQL.Add('        CANTACE_ELR unidades, ');
    SQL.Add('        case when CANTUE_ELR <> 0 then round( CANTACE_ELR / CANTUE_ELR ) else 0 end cajas ');

    SQL.Add(' from edi_lincre elr0 ');
    SQL.Add(' where elr0.idcab_elr = :clave ');
    SQL.Add(' order by codigo_cli ');

    Filter:=  'ean13 <> NULL';
    Filtered:= True;

    Open;
  end;

  with QObsList do
  begin
    Sql.Clear;
    SQL.Add(' select texto1_eor, texto2_eor, texto3_eor, texto4_eor, texto5_eor ');
    SQL.Add(' from edi_obscabre ');
    SQL.Add(' where idcab_eor = :clave ');
    Open;
  end;

  with QAlbaranCabList do
  begin
    Sql.Clear;
    SQL.Add(' select centro_salida_sc, dir_sum_sc, n_albaran_sc, fecha_sc, vehiculo_sc, empresa_sc, n_pedido_sc, cliente_sal_sc ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add('   and n_albaran_sc = :albaran ');
    SQL.Add('   and fecha_sc = :fecha ');
    SQL.Add('   and centro_salida_sc = :centro ');
    Open;
  end;

  with QAlbaranDetList do
  begin
    Sql.Clear;
    (*
    SQL.Add(' select envase_sl envase, ');
    SQL.Add('        ( select max(descripcion_ce) from frf_clientes_env ');
    SQL.Add('          where empresa_ce = :empresa and envase_ce = envase_sl ) descripcion, ');
    SQL.Add('        sum(n_palets_sl) palets, sum(cajas_sl) cajas, sum(kilos_sl) kilos ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add('   and centro_salida_sl = :centro ');
    SQL.Add('   and n_albaran_sl = :albaran ');
    SQL.Add('   and fecha_sl = :fecha ');
    SQL.Add(' group by envase_sl ');
    SQL.Add(' order by envase_sl ');
    *)

    SQL.Add(' select ');
    SQL.Add('         envase_sl envase, ');
    SQL.Add('         ( select ean13_ee from frf_ean13_edi ');
    SQL.Add('           where empresa_ee = :empresa  and cliente_fac_ee = cliente_sl and envase_ee = envase_sl ) codigo, ');

    SQL.Add('         nvl( ( select descripcion_ce from frf_clientes_env ');
    SQL.Add('           where empresa_ce = :empresa and cliente_ce = cliente_sl ');
    SQL.Add('             and envase_ce = envase_sl and producto_base_ce = ( select producto_base_p from frf_productos ');
    SQL.Add('                                         where empresa_p = :empresa and producto_p = producto_sl ) ), ');
    SQL.Add('            ( select descripcion_ee from frf_ean13_edi ');
    SQL.Add('              where empresa_ee = :empresa  and cliente_fac_ee = cliente_sl and envase_ee = envase_sl ) )descripcion, ');

    SQL.Add('         nvl( ( select unidad_fac_ce from frf_clientes_env ');
    SQL.Add('           where empresa_ce = :empresa and cliente_ce = cliente_sl ');
    SQL.Add('             and envase_ce = envase_sl and producto_base_ce = ( select producto_base_p from frf_productos ');
    SQL.Add('                                         where empresa_p = :empresa and producto_p = producto_sl ) ), ''K'' ) unidad_factura, ');

    SQL.Add('         sum(n_palets_sl) palets2, ');
    SQL.Add('         sum(cajas_sl) cajas2, ');
    SQL.Add('         sum(cajas_sl * unidades_caja_sl ) unidades2, ');
    SQL.Add('         sum( kilos_sl ) kilos2 ');

    SQL.Add('  from frf_salidas_l ');

    SQL.Add('  where empresa_sl = :empresa ');
    SQL.Add('  and centro_salida_sl = :centro ');
    SQL.Add('  and n_albaran_sl = :albaran ');
    SQL.Add('  and fecha_sl = :fecha ');

    SQL.Add('  group by 1,2,3,4 ');
    SQL.Add('  order by descripcion ');

    Open;
  end;
end;

procedure TDLRecadv.CerrarDatosListado;
begin
  with QCabList do
  begin
    Close;
  end;

  with QlinList do
  begin
    Close;
  end;

  with QObsList do
  begin
    Close;
  end;

  with QAlbaranCabList do
  begin
    Close;
  end;

  with QAlbaranDetList do
  begin
    Close;
  end;
end;

end.
