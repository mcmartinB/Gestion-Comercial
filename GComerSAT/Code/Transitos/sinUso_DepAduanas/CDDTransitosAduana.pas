unit CDDTransitosAduana;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDDTransitosAduana = class(TDataModule)
    QDatosAduana: TQuery;
    QKilosTransito: TQuery;
    DSDatosAduana: TDataSource;
    QDatosAduanaDetalle: TQuery;
    QDatosAduanaSalidas: TQuery;
    QGetClave: TQuery;
    QKilosDetalle: TQuery;
    QKilosSalidas: TQuery;
    QKilosAlbaran: TQuery;
    QGetLinea: TQuery;
    QDatosAduanaSalidasAux: TQuery;
    QDatosAduanaDetalleAux: TQuery;
    QKilosDetalleSalidas: TQuery;
    QKilosAlbaranAsignados: TQuery;
    DSDatosAduanaDetalle: TDataSource;
    QKilosSalidasDetalle: TQuery;
    QKilosPendientes: TQuery;
    QKilosPendientesT: TQuery;
    qryTransportePuerto: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QDatosAduanaAfterOpen(DataSet: TDataSet);
    procedure QDatosAduanaBeforeClose(DataSet: TDataSet);
    procedure QDatosAduanaBeforePost(DataSet: TDataSet);
    procedure QDatosAduanaDetalleBeforePost(DataSet: TDataSet);
    procedure QDatosAduanaSalidasBeforePost(DataSet: TDataSet);
    procedure QKilosPendientesFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Private declarations }

    function GetClave: integer;
    function GetLinea( const ACodigo: integer ): integer;
  public
    { Public declarations }
    function  GetDatosAduana( const AEmpresa, ACentro: String; const AFecha: TDateTime;
                              const ATransito: Integer ): boolean;

    function  GetKilosTransito( const AEmpresa, ACentro: String; const AFecha: TDateTime;
                                const ATransito: Integer; var AKilosTransito, AKilosAsignados: real;
                                const AAsignados: boolean = False ): boolean;
    function  GetKilosAlbaran( const AEmpresa, ACentro: String; const AFecha: TDateTime;
                               const AAlbaran: Integer; var AKilosAlbaran, AKilosAsignados: real ): boolean;
    function  MetrosLineales( const AEmpresa, ACentro: String;
                              const AFecha: TDateTime; const ATransito: Integer ): real;
  end;

var
  DDTransitosAduana_: TDDTransitosAduana;

implementation

{$R *.DFM}

uses bMath;

procedure TDDTransitosAduana.DataModuleCreate(Sender: TObject);
begin
  With QDatosAduana do
  begin
    RequestLive:= True;
    SQL.Clear;
    SQL.Add(' select * from frf_depositos_aduana_c ');
    SQL.Add(' where empresa_dac = :empresa ');
    SQL.Add(' and centro_dac = :centro ');
    SQL.Add(' and fecha_dac = :fecha ');
    SQL.Add(' and referencia_dac = :transito ');
    Prepare;
  end;

  With QDatosAduanaDetalle do
  begin
    RequestLive:= True;
    SQL.Clear;
    SQL.Add(' select * from frf_depositos_aduana_l ');
    SQL.Add(' where codigo_dal = :codigo_dac ');
    Prepare;
  end;

  With QKilosSalidasDetalle do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_das) kilos_das ');
    SQL.Add(' from frf_depositos_aduana_sal ');
    SQL.Add(' where codigo_das = :codigo_dal ');
    SQL.Add('   and linea_das = :linea_dal ');
    Prepare;
  end;

  With QDatosAduanaDetalleAux do
  begin
    RequestLive:= True;
    SQL.Clear;
    SQL.Add(' select * from frf_depositos_aduana_l ');
    SQL.Add(' where codigo_dal = :codigo ');
    SQL.Add(' and linea_dal = :linea ');
    Prepare;
  end;

  With QDatosAduanaSalidas do
  begin
    RequestLive:= True;
    SQL.Clear;
    SQL.Add(' select * from frf_depositos_aduana_sal ');
    SQL.Add(' where codigo_das = :codigo_dac ');
    Prepare;
  end;

  With QDatosAduanaSalidasAux do
  begin
    RequestLive:= True;
    SQL.Clear;
    SQL.Add(' select * from frf_depositos_aduana_sal ');
    SQL.Add(' where codigo_das = :codigo_dac ');
    Prepare;
  end;

  with QGetClave do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(max(codigo_dac),0) codigo_dac ');
    SQL.Add(' from frf_depositos_aduana_c ');
    Prepare;
  end;

  with QGetLinea do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(max(linea_dal),0) linea_dal ');
    SQL.Add(' from frf_depositos_aduana_l ');
    SQL.Add(' where codigo_dal = :codigo ');
    Prepare;
  end;

  With QKilosTransito do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_tl) kilos_tc');
    SQL.Add(' from frf_transitos_l ');
    SQL.Add(' where empresa_tl = :empresa ');
    SQL.Add(' and centro_tl = :centro ');
    SQL.Add(' and fecha_tl = :fecha ');
    SQL.Add(' and referencia_tl = :transito ');
    Prepare;
  end;

  With QKilosDetalle do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_dal) kilos_dal ');
    SQL.Add(' from frf_depositos_aduana_l ');
    SQL.Add(' where codigo_dal = :codigo_dac ');
    Prepare;
  end;

  With QKilosSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_das) kilos_das ');
    SQL.Add(' from frf_depositos_aduana_sal ');
    SQL.Add(' where codigo_das = :codigo_dac ');
    Prepare;
  end;

  With QKilosPendientes do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl empresa, centro_salida_sl centro, n_albaran_sl albaran, fecha_sl fecha, ');
    SQL.Add('        cliente_sl cliente, dir_sum_sc suministro, n_pedido_sc pedido, ');

    SQL.Add('        operador_transporte_sc operador, transporte_sc transporte, vehiculo_sc vehiculo, n_cmr_sc cmr,  ');

    SQL.Add('        sum(kilos_sl)  kilos, ');
    SQL.Add('        nvl( ( select sum( kilos_das) kilos_das ');
    SQL.Add('               from frf_depositos_aduana_sal ');
    SQL.Add('               where empresa_das = :empresa ');
    SQL.Add('                 and centro_salida_das = centro_salida_sc ');
    SQL.Add('                 and fecha_das = fecha_sc ');
    SQL.Add('                 and n_albaran_das = n_albaran_sc ), 0 ) kilos_asignados ');

    SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and cliente_sal_sc = :cliente ');
    SQL.Add(' and centro_salida_sc <> :centro ');    
    SQL.Add(' and fecha_sc >= :fecha ');
    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and producto_sl in (''E'',''T'',''Q'') ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    SQL.Add(' group by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, cliente_sl, dir_sum_sc, n_pedido_sc, ');
    SQL.Add('          operador_transporte_sc, transporte_sc, vehiculo_sc, n_cmr_sc, 13 ');
    SQL.Add(' order by fecha_sl, n_pedido_sc ');

    Filtered:= True;
    Prepare;
  end;

  With QKilosPendientesT do
  begin
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('         empresa_tl empresa, centro_tl centro, referencia_tl albaran, fecha_tl fecha, ');
    SQL.Add('         centro_destino_tl cliente, '''' suministro, '''' pedido, ');

    SQL.Add('         '''' operador, transporte_tc transporte, vehiculo_tc vehiculo, n_cmr_tc cmr, ');

    SQL.Add('         sum(kilos_tl)  kilos, ');
    SQL.Add('         nvl( ( select sum( kilos_das) kilos_das ');
    SQL.Add('                from frf_depositos_aduana_sal ');
    SQL.Add('                where empresa_das = :empresa ');
    SQL.Add('                  and centro_salida_das = centro_tl ');
    SQL.Add('                  and fecha_das = fecha_tl ');
    SQL.Add('                  and n_albaran_das = referencia_tl ), 0 ) kilos_asignados ');

    SQL.Add('  from frf_transitos_c, frf_transitos_l ');

    SQL.Add('  where empresa_tc = :empresa ');
    SQL.Add('  and centro_tc <> :centro ');
    SQL.Add('  and fecha_tc >= :fecha ');
    SQL.Add('  and empresa_tl = :empresa ');
    SQL.Add('  and centro_tl = centro_tc ');
    SQL.Add('  and fecha_tl = fecha_tc ');
    SQL.Add('  and referencia_tl = referencia_tc ');
    SQL.Add('  and centro_destino_tl = :cliente ');
    SQL.Add('  and producto_tl in (''E'',''T'',''Q'') ');

    SQL.Add('  group by empresa_tl, centro_tl, referencia_tl, fecha_tl, centro_destino_tl,');
    SQL.Add('           transporte_tc, vehiculo_tc, n_cmr_tc, 13 ');
    SQL.Add('  order by fecha_tl ');

    Filtered:= True;
    Prepare;
  end;    

  With QKilosAlbaran do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) kilos_sl, count(*) registros ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = :centro ');
    SQL.Add(' and n_albaran_sl = :albaran ');
    SQL.Add(' and fecha_sl = :fecha ');
    SQL.Add(' and producto_sl in (''E'',''T'',''Q'') ');
    Prepare;
  end;

  With QKilosAlbaranAsignados do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_das) kilos_das ');
    SQL.Add(' from frf_depositos_aduana_sal ');
    SQL.Add(' where empresa_das = :empresa ');
    SQL.Add(' and centro_Salida_das = :centro ');
    SQL.Add(' and n_albaran_das = :albaran ');
    SQL.Add(' and fecha_das = :fecha ');
    Prepare;
  end;


  With QKilosDetalleSalidas do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_das) kilos_das ');
    SQL.Add(' from frf_depositos_aduana_sal ');
    SQL.Add(' where codigo_das = :codigo ');
    SQL.Add(' and linea_das = :linea ');
    Prepare;
  end;

  With qryTransportePuerto do
  begin
    SQL.Clear;
    SQL.Add(' select transporte_tc transporte, puerto_tc puerto, descripcion_a des_puerto');
    SQL.Add(' from frf_transitos_c left join frf_aduanas on puerto_tc = codigo_a ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and fecha_tc = :fecha ');
    SQL.Add(' and referencia_tc = :referencia ');
    Prepare;
  end;
end;

procedure TDDTransitosAduana.DataModuleDestroy(Sender: TObject);
begin
  with QDatosAduana do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QDatosAduanaDetalle do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QDatosAduanaDetalleAux do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QDatosAduanaSalidas do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QDatosAduanaSalidasAux do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QGetClave do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QGetLinea do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QKilosTransito do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QKilosDetalle do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QKilosSalidas do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  With QKilosPendientes do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  With QKilosPendientesT do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QKilosAlbaran do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QKilosAlbaranAsignados do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with QKilosDetalleSalidas do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;

  with qryTransportePuerto do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
end;

function  TDDTransitosAduana.MetrosLineales( const AEmpresa, ACentro: String;
                             const AFecha: TDateTime; const ATransito: Integer ): real;

begin
  Result:= 14.2;
  (*TODO*)
  //Tabla para guaradar valores
  with qryTransportePuerto do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('referencia').AsInteger:= ATransito;
    Open;
    if FieldByName('transporte').AsString = '691' then
    begin
      if Pos( 'ALICANTE', FieldByName('des_puerto').AsString ) > 0 then
      begin
        Result:= 0; //0 implica TEUS 40
      end;
    end
    else
    if FieldByName('transporte').AsString = '20' then
    begin
      if ( Pos( 'SEVILLA', FieldByName('des_puerto').AsString ) > 0 ) or
         ( Pos( 'HUELVA', FieldByName('des_puerto').AsString ) > 0 )then
      begin
        Result:= 13.6;
      end;
    end
    else
    if FieldByName('transporte').AsString = '310' then
    begin
      if ( Pos( 'SEVILLA', FieldByName('des_puerto').AsString ) > 0 ) or
         ( Pos( 'HUELVA', FieldByName('des_puerto').AsString ) > 0 )then
      begin
        Result:= 13.6;
      end;
    end
    else
    if FieldByName('transporte').AsString = '280' then
    begin
      if ( Pos( 'HUELVA', FieldByName('des_puerto').AsString ) > 0 )then
      begin
        Result:= 13.6;
      end;
    end;
    Close;
  end;
end;


function  TDDTransitosAduana.GetKilosTransito( const AEmpresa, ACentro: String;
                             const AFecha: TDateTime; const ATransito: Integer;
                             var AKilosTransito, AKilosAsignados: real;
                             const AAsignados: boolean = False ): boolean;
begin
  with QKilosTransito do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('transito').AsInteger:= ATransito;
    Open;
    result:= FieldByName('kilos_tc').AsFloat > 0;
    AKilosTransito:= FieldByName('kilos_tc').AsFloat;
    Close;
  end;

  if result and AAsignados then
  begin
    with QKilosAlbaranAsignados do
    begin
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('fecha').AsDateTime:= AFecha;
      ParamByName('albaran').AsInteger:= ATransito;
      Open;
      AKilosAsignados:= FieldByName('kilos_das').AsFloat;
      Close;
    end;
  end
  else
  begin
    AKilosAsignados:= 0;
  end;
end;

function  TDDTransitosAduana.GetKilosAlbaran( const AEmpresa, ACentro: String;
                             const AFecha: TDateTime; const AAlbaran: Integer;
                             var AKilosAlbaran, AKilosAsignados: real ): boolean;
begin
  with QKilosAlbaran do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('albaran').AsInteger:= AAlbaran;
    Open;
    result:= FieldByName('registros').AsInteger > 0;
    AKilosAlbaran:= FieldByName('kilos_sl').AsFloat;
    Close;
  end;

  if result then
  begin
    with QKilosAlbaranAsignados do
    begin
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('centro').AsString:= ACentro;
      ParamByName('fecha').AsDateTime:= AFecha;
      ParamByName('albaran').AsInteger:= AAlbaran;
      Open;
      AKilosAsignados:= FieldByName('kilos_das').AsFloat;
      Close;
    end;
  end
  else
  begin
    AKilosAsignados:= 0;
  end;
end;


function TDDTransitosAduana.GetDatosAduana( const AEmpresa, ACentro: String;
                             const AFecha: TDateTime;
                             const ATransito: Integer ): boolean;
begin
  With QDatosAduana do
  begin
    Close;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('transito').AsInteger:= ATransito;
    Open;
    result:= not IsEmpty;
  end;
end;

procedure TDDTransitosAduana.QDatosAduanaAfterOpen(DataSet: TDataSet);
begin
  QDatosAduanaDetalle.Open;
  QDatosAduanaSalidas.Open;
  QDatosAduanaSalidasAux.Open;
  QKilosDetalle.Open;
  QKilosSalidas.Open;
  QKilosSalidasDetalle.Open;
end;

procedure TDDTransitosAduana.QDatosAduanaBeforeClose(DataSet: TDataSet);
begin
  QKilosSalidasDetalle.Close;
  QDatosAduanaDetalle.Close;
  QDatosAduanaSalidas.Close;
  QDatosAduanaSalidasAux.Close;
  QKilosDetalle.Close;
  QKilosSalidas.Close;

end;

function TDDTransitosAduana.GetClave: integer;
begin
  with QGetClave do
  begin
    Open;
    result:= FieldByname('codigo_dac').AsInteger + 1;
    Close;
  end;
end;

function TDDTransitosAduana.GetLinea( const ACodigo: integer ): integer;
begin
  with QGetLinea do
  begin
    ParamByName('codigo').AsInteger:= ACodigo;
    Open;
    result:= FieldByname('linea_dal').AsInteger + 1;
    Close;
  end;
end;

procedure TDDTransitosAduana.QDatosAduanaBeforePost(DataSet: TDataSet);
begin
  //Rellenar clave primaria
  if DataSet.State = dsInsert then
  begin
    DataSet.FieldByName('codigo_dac').AsInteger:= GetClave;
  end;
end;

procedure TDDTransitosAduana.QDatosAduanaDetalleBeforePost(
  DataSet: TDataSet);
begin
  //Rellenar clave primaria
  if DataSet.State = dsInsert then
  begin
    DataSet.FieldByName('codigo_dal').AsInteger:= QDatosAduana.FieldByName('codigo_dac').AsInteger;
    DataSet.FieldByName('linea_dal').AsInteger:= GetLinea( QDatosAduana.FieldByName('codigo_dac').AsInteger );
  end;
end;

procedure TDDTransitosAduana.QDatosAduanaSalidasBeforePost(
  DataSet: TDataSet);
begin
  //Rellenar clave primaria
  if DataSet.State = dsInsert then
  begin
    DataSet.FieldByName('codigo_das').AsInteger:= QDatosAduanaDetalle.FieldByName('codigo_dal').AsInteger;
    DataSet.FieldByName('linea_das').AsInteger:= QDatosAduanaDetalle.FieldByName('linea_dal').AsInteger;
  end;
end;

procedure TDDTransitosAduana.QKilosPendientesFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
  if not DataSet.IsEmpty then
    Accept:= ( bRoundTo(DataSet.FieldByName('kilos_asignados').AsFloat,2) < bRoundTo(DataSet.FieldByName('kilos').AsFloat,2) );
end;

end.
