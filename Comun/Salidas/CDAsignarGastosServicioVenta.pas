unit CDAsignarGastosServicioVenta;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;

type
  TDAsignarGastosServicioVenta = class(TDataModule)
    QCambiarStatus: TQuery;
    QGastosServicioLin: TQuery;
    DSSelectLineas: TDataSource;
    mtAuxGastos: TkbmMemTable;
    DSGastos: TDataSource;
    QSelectSalidasTodas: TQuery;
    QSumSalidasTodas: TQuery;
    QSelectSalidasProducto: TQuery;
    QSumSalidasProducto: TQuery;
    QGastosSalidas: TQuery;
    QBorrarGastosSalidas: TQuery;
    QProductosCentro: TQuery;
    QFechasLiquida: TQuery;
    QSalidasLiquidadas: TQuery;
    qSelectSalidasCab: TQuery;
    dsSalidasTodas: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure QGastosServicioLinAfterOpen(DataSet: TDataSet);
    procedure QGastosServicioLinBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    QSelectSalidasAux: TQuery;
    sServicio: string;
    sCodigoGasto: string;
    iLineaGasto: integer;

    function GastosLineaFactura( const AUnidadDist: string; var AMsg: string ): boolean;
    function GrabarGastoTemporal( const AEmpresa, ACentroSalida: string;
                                  const AALbaran: integer; const AFecha: TDateTime;
                                  const AProducto: string; const ATransporte: integer; const AImporte: real; var AMsg: string  ): boolean;
    function ActualizarGastosBD( const AActualizarEstado: Boolean; var AMsg: string ): boolean;
    function ActualizarEstadoServicio( var AMsg: string ): boolean;
    function CopiarLosDatosTablaTempral( var AMsg: string ): boolean;
    function GrabarGastoBD( var AMsg: string ): boolean;
    function BorrarGastosAntiguosSalida: boolean;

    //function MargenTiempoOK( const AEmpresa: string; const AServicio: integer; var vMsg: string ): boolean;

  public
    { Public declarations }
    function RepercutirGastosServicio( const AEmpresa: string;
                           const AServicio: Integer; const AUnidadDist: string;
                           const AActualizarEstado: Boolean;var AMsg: string ): boolean;
  end;

  procedure ActualizarEstadoServicio_( const AEmpresa, ACentro: string; const ASalida: integer; const AFEcha: TDateTime );

var
  DAsignarGastosServicioVenta: TDAsignarGastosServicioVenta;

implementation

uses
  bMath, Dialogs, UDMBaseDatos, Controls;

{$R *.dfm}

procedure ActualizarEstadoServicio_( const AEmpresa, ACentro: string; const ASalida: integer; const AFEcha: TDateTime );
var
  letras: string;
  letra: Char;
begin
  with DMBaseDatos do
  begin
    QAux.SQL.Clear;
    QAux.SQL.Add(' update frf_servicios_venta ');
    QAux.SQL.Add(' set status_sv = 1 ');
    QAux.SQL.Add(' where empresa_sv = :empresa ');
    QAux.SQL.Add(' and exists ');
    QAux.SQL.Add(' ( ');
    QAux.SQL.Add('  select * ');
    QAux.SQL.Add('   from frf_salidas_servicios_venta ');
    QAux.SQL.Add('   where empresa_ssv = :empresa ');
    QAux.SQL.Add('   and centro_Salida_ssv = :centro ');
    QAux.SQL.Add('   and n_albaran_ssv = :salida ');
    QAux.SQL.Add('   and fecha_ssv = :fecha ');
    QAux.SQL.Add('   and servicio_ssv =  servicio_sv ');
    QAux.SQL.Add(' ) ');
    QAux.SQL.Add(' and status_sv = 2 ');
    QAux.ParamByName('empresa').AsString:= AEmpresa;
    QAux.ParamByName('centro').AsString:= ACentro;
    QAux.ParamByName('salida').AsInteger:= Asalida;
    QAux.ParamByName('fecha').AsDateTime:= AFecha;
    QAux.ExecSql;
  end;
end;

procedure TDAsignarGastosServicioVenta.DataModuleCreate(Sender: TObject);
begin
  with QGastosServicioLin do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_gsv, servicio_gsv , tipo_gsv, producto_gsv, importe_gsv, ');
    SQL.Add('        ref_fac_gsv, fecha_fac_gsv, nota_gsv, pagado_gsv, nvl(unidad_dist_tg[1,1], ''K'') unidad ');
    SQL.Add(' from frf_gastos_servicios_venta, frf_tipo_gastos ');
    SQL.Add(' where empresa_gsv = :empresa_gsv ');
    SQL.Add(' and servicio_gsv = :servicio_gsv ');
    SQL.Add(' and tipo_tg = tipo_gsv ');
  end;

  with QCambiarStatus do
  begin
    SQL.Clear;
    SQL.Add(' update frf_servicios_venta ');
    SQL.Add(' set status_sv = 2 ');
    SQL.Add(' where empresa_sv = :empresa_gsv ');
    SQL.Add(' and servicio_sv = :servicio_gsv ');
  end;

  with QSelectSalidasTodas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, producto_sl, ');
    SQL.Add('        sum(kilos_sl) kilos_sl, sum(n_palets_sl) palets_sl, sum(cajas_sl) cajas_sl, sum(importe_neto_sl) importe_sl ');
    SQL.Add(' from frf_salidas_servicios_venta, frf_salidas_l ');
    SQL.Add(' where empresa_ssv = :empresa_gsv ');
    SQL.Add(' and servicio_ssv = :servicio_gsv ');
    SQL.Add(' and empresa_sl = :empresa_gsv ');
    SQL.Add(' and centro_Salida_sl = centro_Salida_ssv ');
    SQL.Add(' and n_albaran_sl = n_albaran_ssv ');
    SQL.Add(' and fecha_sl = fecha_ssv ');
    SQL.Add(' group by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, producto_sl ');
    SQL.Add(' order by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, producto_sl ');
  end;

  with QSumSalidasTodas do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) kilos_sl, sum(n_palets_sl) palets_sl, sum(cajas_sl) cajas_sl, sum(importe_neto_sl) importe_sl ');
    SQL.Add(' from frf_salidas_servicios_venta, frf_salidas_l ');
    SQL.Add(' where empresa_ssv = :empresa_gsv ');
    SQL.Add(' and servicio_ssv = :servicio_gsv ');
    SQL.Add(' and empresa_sl = :empresa_gsv ');
    SQL.Add(' and centro_Salida_sl = centro_Salida_ssv ');
    SQL.Add(' and n_albaran_sl = n_albaran_ssv ');
    SQL.Add(' and fecha_sl = fecha_ssv ');
  end;

  with QSelectSalidasProducto do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, producto_sl, ');
    SQL.Add('        sum(kilos_sl) kilos_sl, sum(n_palets_sl) palets_sl, sum(cajas_sl) cajas_sl, sum(importe_neto_sl) importe_sl ');
    SQL.Add(' from frf_salidas_servicios_venta, frf_salidas_l ');
    SQL.Add(' where empresa_ssv = :empresa_gsv ');
    SQL.Add(' and servicio_ssv = :servicio_gsv ');
    SQL.Add(' and empresa_sl = :empresa_gsv ');
    SQL.Add(' and centro_Salida_sl = centro_Salida_ssv ');
    SQL.Add(' and n_albaran_sl = n_albaran_ssv ');
    SQL.Add(' and fecha_sl = fecha_ssv ');
    SQL.Add(' and producto_sl = :producto_gsv ');
    SQL.Add(' group by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, producto_sl ');
    SQL.Add(' order by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, producto_sl ');
  end;

  with QSumSalidasProducto do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_sl) kilos_sl, sum(n_palets_sl) palets_sl, sum(cajas_sl) cajas_sl, sum(importe_neto_sl) importe_sl ');
    SQL.Add(' from frf_salidas_servicios_venta, frf_salidas_l ');
    SQL.Add(' where empresa_ssv = :empresa_gsv ');
    SQL.Add(' and servicio_ssv = :servicio_gsv ');
    SQL.Add(' and empresa_sl = :empresa_gsv ');
    SQL.Add(' and centro_Salida_sl = centro_Salida_ssv ');
    SQL.Add(' and n_albaran_sl = n_albaran_ssv ');
    SQL.Add(' and fecha_sl = fecha_ssv ');
    SQL.Add(' and producto_sl = :producto_gsv ');
  end;

  with QGastosSalidas do
  begin
    RequestLive:= True;
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_gastos ');
  end;

  with QBorrarGastosSalidas do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from frf_gastos ');
    SQL.Add(' where nota_g = :servicio ');
    SQL.Add(' and solo_lectura_g = 1 ');
  end;

  with QSelectSalidasCab do
  begin
    SQL.Clear;
    SQL.Add(' select transporte_sc from frf_salidas_c ');
    SQL.Add('  where empresa_sc = :empresa_sl ');
    SQL.Add('    and centro_salida_sc = :centro_salida_sl ');
    SQL.Add('    and n_albaran_sc = :n_albaran_sl ');
    SQL.Add('    and fecha_sc = :fecha_sl ');

  end;

  mtAuxGastos.FieldDefs.Clear;
  mtAuxGastos.FieldDefs.Add('empresa_g', ftString, 3, False);
  mtAuxGastos.FieldDefs.Add('centro_salida_g', ftString, 12, False);
  mtAuxGastos.FieldDefs.Add('n_albaran_g', ftInteger, 0, False);
  mtAuxGastos.FieldDefs.Add('fecha_g', ftString, 12, False);
  mtAuxGastos.FieldDefs.Add('tipo_g', ftString, 3, False);
  mtAuxGastos.FieldDefs.Add('producto_g', ftString, 3, False);
  mtAuxGastos.FieldDefs.Add('transporte_g', ftInteger, 0, False);
  mtAuxGastos.FieldDefs.Add('importe_g', ftFloat, 0, False);
  mtAuxGastos.FieldDefs.Add('ref_fac_g', ftString, 15, False);
  mtAuxGastos.FieldDefs.Add('fecha_fac_g', ftDate, 0, False);
  mtAuxGastos.FieldDefs.Add('nota_g', ftString, 30, False);
  mtAuxGastos.FieldDefs.Add('pagado_g', ftInteger, 0, False);

  mtAuxGastos.IndexFieldNames:= 'empresa_g;centro_salida_g;n_albaran_g;fecha_g;tipo_g';
  mtAuxGastos.SortFields:= 'empresa_g;centro_salida_g;n_albaran_g;fecha_g;tipo_g';
  mtAuxGastos.CreateTable;
end;

procedure TDAsignarGastosServicioVenta.QGastosServicioLinAfterOpen(DataSet: TDataSet);
begin
  QSelectSalidasProducto.Open;
  QSumSalidasProducto.Open;
  QSelectSalidasTodas.Open;
  QSumSalidasTodas.Open;
  QSelectSalidasCab.Open;
end;

procedure TDAsignarGastosServicioVenta.QGastosServicioLinBeforeClose(DataSet: TDataSet);
begin
  QSumSalidasTodas.Close;
  QSelectSalidasTodas.Close;
  QSumSalidasProducto.Close;
  QSelectSalidasProducto.Close;
  QSElectSalidasCab.Close;
end;

function TDAsignarGastosServicioVenta.RepercutirGastosServicio( const AEmpresa: string;
                           const AServicio: Integer; const AUnidadDist: string;
                           const AActualizarEstado: Boolean;var AMsg: string ): boolean;
var
  sAux: string;
  //bAux: boolean;
begin
  sServicio:= '(' + AEmpresa + ', ' + IntToStr( AServicio ) + ')';
  sAux:= AMsg;

  (*
  bAux:= MargenTiempoOK( AEmpresa, AServicio, AMsg );
  if not bAux then
  begin
    if ( not AActualizarEstado ) and ( MessageDlg('¿Esta seguro de querer asignar los gastos?' + #13 + #10 + Amsg,
                                                  mtConfirmation, [mbYes, mbNo], 0 ) = mrYes )then
    begin
      bAux:= True;
    end
    else
    begin
      AMsg:= 'ERROR: Cerrado por liquidación. ' + sServicio;
    end;
  end;
  *)

  //if bAux then
  begin
    AMsg:= sAux;
    mtAuxGastos.Open;

    QGastosServicioLin.ParamByName('empresa_gsv').AsString:= AEmpresa;
    QGastosServicioLin.ParamByName('servicio_gsv').AsInteger:= AServicio;
    QGastosServicioLin.Open;

    if QGastosServicioLin.IsEmpty then
    begin
      result:= BorrarGastosAntiguosSalida;
      if result then
      begin
       AMsg:= '* OK : Gastos servicio borrados correctamente. ' + sServicio;
       Exit;
      end
      else
      begin
        AMsg:= 'ERROR: Servicio sin gastos. ' + sServicio;
      end;
    end
    else
    begin
      result:= True;
      while ( not QGastosServicioLin.Eof ) and result do
      begin
        result:= GastosLineaFactura( AUnidadDist, AMsg );
        QGastosServicioLin.Next;
      end;
    end;
    if result then
    begin
      result:= ActualizarGastosBD( AActualizarEstado, AMsg );
    end;

    QGastosServicioLin.Close;
    mtAuxGastos.Close;

    if result then
    begin
      AMsg:= '* OK :Gastos servicio asignados correctamente. ' + sServicio;
    end;
  end;
  (*
  else
  begin
    result:= False;
  end;
  *)
end;

function UnidadDist( const AForzar, AUnidad: string ): integer;
begin
  if AForzar <> '' then
  begin
    //Palets
    if AForzar = 'P' then
      Result:= 0
    else
    //Cajas
    if AForzar = 'C' then
      Result:= 1
    else
    //Importe
    if AForzar = 'I' then
      Result:= 2
    else
    //Por defecto kilos
    //if AUnidad = 'K' then
      Result:= 3;
  end
  else
  begin
    //Palets
    if AUnidad = 'P' then
      Result:= 0
    else
    //Cajas
    if AUnidad = 'C' then
      Result:= 1
    else
    //Importe
    if AUnidad = 'I' then
      Result:= 2
    else
    //Por defecto kilos
    //if AUnidad = 'K' then
      Result:= 3;
  end;
end;

function TDAsignarGastosServicioVenta.GastosLineaFactura( const AUnidadDist: string; var AMsg: string ): boolean;
var
  sEmpresa, sCentro, sProducto: string;
  iAlbaran, iTransporte: integer;
  dFecha: TDateTime;
  iUnidad: Integer;
  rUnidadesTotal, rUnidades: Real;
  rImporteTotal, rImporte, rImporteAcum: real;
begin
  result:= False;

  iUnidad:= UnidadDist( AUnidadDist, QGastosServicioLin.FieldByName('unidad').AsString );
  if QGastosServicioLin.FieldByName('producto_gsv').AsString = '' then
  begin
    case iUnidad of
      0: rUnidadesTotal:= QSumSalidasTodas.FieldByname('palets_sl').AsFloat;
      1: rUnidadesTotal:= QSumSalidasTodas.FieldByname('cajas_sl').AsFloat;
      2: rUnidadesTotal:= QSumSalidasTodas.FieldByname('importe_sl').AsFloat;
      else rUnidadesTotal:= QSumSalidasTodas.FieldByname('kilos_sl').AsFloat;
    end;
    QSelectSalidasAux:= QSelectSalidasTodas;
  end
  else
  begin
    case iUnidad of
      0: rUnidadesTotal:= QSumSalidasProducto.FieldByname('palets_sl').AsFloat;
      1: rUnidadesTotal:= QSumSalidasProducto.FieldByname('cajas_sl').AsFloat;
      2: rUnidadesTotal:= QSumSalidasProducto.FieldByname('importe_sl').AsFloat;
      else rUnidadesTotal:= QSumSalidasProducto.FieldByname('kilos_sl').AsFloat;
    end;
    QSelectSalidasAux:= QSelectSalidasProducto;
  end;

  if rUnidadesTotal <> 0 then
  begin
    rImporteTotal:= QGastosServicioLin.FieldByname('importe_gsv').AsFloat;
    rImporteAcum:= 0;


    QSelectSalidasAux.First;
    while not QSelectSalidasAux.Eof do
    begin
      sEmpresa:= QSelectSalidasAux.FieldByName('empresa_sl').AsString;
      sCentro:= QSelectSalidasAux.FieldByName('centro_Salida_sl').AsString;
      iAlbaran:= QSelectSalidasAux.FieldByName('n_albaran_sl').AsInteger;
      dFecha:= QSelectSalidasAux.FieldByName('fecha_sl').AsDateTime;
      sProducto:= QSelectSalidasAux.FieldByName('producto_sl').AsString;

      case iUnidad of
        0: rUnidades:= QSelectSalidasAux.FieldByName('palets_sl').AsFloat;
        1: rUnidades:= QSelectSalidasAux.FieldByName('cajas_sl').AsFloat;
        2: rUnidades:= QSelectSalidasAux.FieldByName('importe_sl').AsFloat;
        else rUnidades:= QSelectSalidasAux.FieldByName('kilos_sl').AsFloat;
      end;

      if rUnidades <> 0 then
        rImporte:=  bRoundTo( ( rImporteTotal *  rUnidades) / rUnidadesTotal, -2 )
      else
        rImporte:=  0;
      rImporteAcum:= rImporteAcum + rImporte;


      QSelectSalidasAux.Next;
      if QSelectSalidasAux.Eof then
      begin
        rImporte:= bRoundTo( ( rImporte + ( rImporteTotal - rImporteAcum ) ), -2 );
      end;
      iTransporte := QSelectSalidasCab.Fieldbyname('transporte_sc').AsInteger;
      result:= GrabarGastoTemporal( sEmpresa, sCentro, iAlbaran, dFecha, sProducto, iTransporte, rImporte, AMsg );
    end;
  end
  else
  begin
    if QSelectSalidasAux.IsEmpty then
    begin
      if QGastosServicioLin.FieldByName('producto_gsv').AsString = '' then
      begin
        AMsg:= 'ERROR: Servicio sin albaranes de salida. ' + sServicio;
      end
      else
      begin
        AMsg:= 'ERROR: Servicio sin albaranes de salida para el producto "' + QGastosServicioLin.FieldByName('producto_gsv').AsString + '". ' + sServicio;
      end;
    end
    else
    if QGastosServicioLin.FieldByName('producto_gsv').AsString = '' then
    begin
      AMsg:= 'ERROR: Salida sin kilos. (' + QSelectSalidasAux.FieldByName('empresa_sl').AsString + ', '+
                                            QSelectSalidasAux.FieldByName('centro_salida_sl').AsString + ', '+
                                            QSelectSalidasAux.FieldByName('n_albaran_sl').AsString + ', '+
                                            QSelectSalidasAux.FieldByName('fecha_sl').AsString + ')';
    end
    else
    begin
      AMsg:= 'ERROR: Salida sin kilos para el producto "' +
        QGastosServicioLin.FieldByName('producto_gsv').AsString + '". (' + QSelectSalidasAux.FieldByName('empresa_sl').AsString + ', '+
                                            QSelectSalidasAux.FieldByName('centro_salida_sl').AsString + ', '+
                                            QSelectSalidasAux.FieldByName('n_albaran_sl').AsString + ', '+
                                            QSelectSalidasAux.FieldByName('fecha_sl').AsString + ')';
    end;
  end;
end;

function TDAsignarGastosServicioVenta.GrabarGastoTemporal( const AEmpresa, ACentroSalida: string;
                                                           const AALbaran: integer;
                                                           const AFecha: TDateTime;
                                                           const AProducto: string;
                                                           const ATransporte: integer;
                                                           const AImporte: real; var AMsg: string  ): boolean;
begin
  mtAuxGastos.Insert;
  mtAuxGastos.FieldByName('empresa_g').AsString:= AEmpresa;
  mtAuxGastos.FieldByName('centro_salida_g').AsString:= ACentroSalida;
  mtAuxGastos.FieldByName('n_albaran_g').AsInteger:= AALbaran;
  mtAuxGastos.FieldByName('fecha_g').AsDateTime:= AFecha;
  mtAuxGastos.FieldByName('tipo_g').AsString:= QGastosServicioLin.FieldByName('tipo_gsv').AsString;
  mtAuxGastos.FieldByName('producto_g').AsString:= AProducto;
  mtAuxGastos.FieldByName('transporte_g').AsFloat:= ATransporte;
  mtAuxGastos.FieldByName('importe_g').AsFloat:= AImporte;
  mtAuxGastos.FieldByName('ref_fac_g').AsString:= QGastosServicioLin.FieldByName('ref_fac_gsv').AsString;
  mtAuxGastos.FieldByName('fecha_fac_g').Value:= QGastosServicioLin.FieldByName('fecha_fac_gsv').value;
  mtAuxGastos.FieldByName('nota_g').AsString:= 'SERVICIO: ' + sServicio; //QGastosServicioLin.FieldByName('servicio_gsv').AsString;;
  mtAuxGastos.FieldByName('pagado_g').AsInteger:= QGastosServicioLin.FieldByName('pagado_gsv').AsInteger;

  try
    mtAuxGastos.Post;
    AMsg:= 'OK';
    result:= True;
  except
    AMsg:= 'ERROR: Al grabar en la tabla temporal (' + AEmpresa + ', ' +
              ACentroSalida + ', ' + IntToStr( AALbaran ) + ', ' + DateTimeToStr( AFecha  )+ ', ' +
              QGastosServicioLin.FieldByName('tipo_gsv').AsString + ', ' +
              QGastosServicioLin.FieldByName('producto_gsv').AsString + ', ' +
              FloatTostr( AImporte ) + ')';
    mtAuxGastos.Cancel;
    result:= False;
  end;
end;

function TDAsignarGastosServicioVenta.BorrarGastosAntiguosSalida: boolean;
begin
  QBorrarGastosSalidas.ParamByName('servicio').AsString:= 'SERVICIO: ' + sServicio;
  QBorrarGastosSalidas.ExecSQL;
  result:= QBorrarGastosSalidas.RowsAffected > 0;
end;

function TDAsignarGastosServicioVenta.ActualizarGastosBD( const AActualizarEstado: Boolean; var AMsg: string  ): boolean;
begin
  sCodigoGasto:= '';
  iLineaGasto:= 0;
  mtAuxGastos.Sort([]);
  try
    if not DMBaseDatos.DBBaseDatos.InTransaction then
    begin
      DMBaseDatos.DBBaseDatos.StartTransaction;
      if AActualizarEstado then
        result:= ActualizarEstadoServicio( AMsg );
      (*
      else
        result:= True;
      *)
      if result then
      begin
        BorrarGastosAntiguosSalida;
        result:= CopiarLosDatosTablaTempral( AMsg );
        if result then
        begin
          DMBaseDatos.DBBaseDatos.Commit;
          AMsg:= 'OK';
        end
        else
        begin
          DMBaseDatos.DBBaseDatos.Rollback;
          AMsg:= 'ERROR: Problemas al grabar el gasto en la base de datos. (' +
                mtAuxGastos.FieldByName('empresa_g').AsString + ', ' +
                mtAuxGastos.FieldByName('centro_salida_g').AsString + ', ' +
                mtAuxGastos.FieldByName('n_albaran_g').AsString + ', ' +
                mtAuxGastos.FieldByName('fecha_g').AsString + ', ' +
                mtAuxGastos.FieldByName('tipo_g').AsString + ', ' +
                mtAuxGastos.FieldByName('producto_g').AsString + ', ' +
                mtAuxGastos.FieldByName('importe_g').AsString  + ')';
        end;
      end;
    end
    else
    begin
      AMsg:= 'Transacción ya abierta. ' + sServicio;
      result:= false;
    end;
  except
    AMsg:= 'ERROR: Problemas al grabar el gasto en la base de datos. (' +
                mtAuxGastos.FieldByName('empresa_g').AsString + ', ' +
                mtAuxGastos.FieldByName('centro_salida_g').AsString + ', ' +
                mtAuxGastos.FieldByName('n_albaran_g').AsString + ', ' +
                mtAuxGastos.FieldByName('fecha_g').AsString + ', ' +
                mtAuxGastos.FieldByName('tipo_ge').AsString + ', ' +
                mtAuxGastos.FieldByName('producto_ge').AsString + ', ' +
                mtAuxGastos.FieldByName('importe_ge').AsString  + ')';
    DMBaseDatos.DBBaseDatos.Rollback;
    result:= False;
  end;
end;

function TDAsignarGastosServicioVenta.ActualizarEstadoServicio( var AMsg: string ): boolean;
begin
  try
    QCambiarStatus.ExecSQL;
    result:= True;
    AMsg:= 'OK';
  except
    result:= False;
    AMsg:= 'ERROR: Al actualizar el estado del servicio. ' + sServicio;
  end;
end;

function TDAsignarGastosServicioVenta.CopiarLosDatosTablaTempral( var AMsg: string ): boolean;
begin
  if Not mtAuxGastos.IsEmpty then
  begin
    result:= True;
    QGastosSalidas.Open;
    try
      mtAuxGastos.First;
      while ( not mtAuxGastos.Eof ) and result do
      begin
        result:= GrabarGastoBD( AMsg );
        mtAuxGastos.Next;
      end;
    finally
      QGastosSalidas.Close;
    end;
  end
  else
  begin
    AMsg:= 'ERROR: Sin gastos para grabar en la tabla temporal. ' + sServicio;
    result:= False;
  end;
end;

function TDAsignarGastosServicioVenta.GrabarGastoBD( var AMsg: string ): boolean;
var
  sError: String;
begin
  sError:= '(' + mtAuxGastos.FieldByName('empresa_g').AsString + ', ' +
              mtAuxGastos.FieldByName('centro_salida_g').AsString + ', ' +
              mtAuxGastos.FieldByName('n_albaran_g').AsString + ', ' +
              mtAuxGastos.FieldByName('fecha_g').AsString + ', ' +
              mtAuxGastos.FieldByName('tipo_g').AsString + ', ' +
              mtAuxGastos.FieldByName('producto_g').AsString + ', ' +
              mtAuxGastos.FieldByName('importe_g').AsString  + ')';
  QGastosSalidas.Insert;
  QGastosSalidas.FieldByName('empresa_g').AsString:= mtAuxGastos.FieldByName('empresa_g').AsString;
  QGastosSalidas.FieldByName('centro_salida_g').AsString:= mtAuxGastos.FieldByName('centro_salida_g').AsString;
  QGastosSalidas.FieldByName('n_albaran_g').AsInteger:= mtAuxGastos.FieldByName('n_albaran_g').AsInteger;
  QGastosSalidas.FieldByName('fecha_g').AsDateTime:= mtAuxGastos.FieldByName('fecha_g').AsDateTime;
  QGastosSalidas.FieldByName('tipo_g').AsString:= mtAuxGastos.FieldByName('tipo_g').AsString;
  QGastosSalidas.FieldByName('producto_g').AsString:= mtAuxGastos.FieldByName('producto_g').AsString;
  QGastosSalidas.FieldByName('transporte_g').AsString:= mtAuxGastos.FieldByName('transporte_g').AsString;
  QGastosSalidas.FieldByName('importe_g').AsFloat:= mtAuxGastos.FieldByName('importe_g').AsFloat;
  QGastosSalidas.FieldByName('ref_fac_g').AsString:= mtAuxGastos.FieldByName('ref_fac_g').AsString;
  QGastosSalidas.FieldByName('fecha_fac_g').Value:= mtAuxGastos.FieldByName('fecha_fac_g').vALUE;
  QGastosSalidas.FieldByName('nota_g').AsString:= mtAuxGastos.FieldByName('nota_g').AsString;
  QGastosSalidas.FieldByName('pagado_g').AsInteger:= mtAuxGastos.FieldByName('pagado_g').AsInteger;
  QGastosSalidas.FieldByName('solo_lectura_g').AsInteger:= 1;
  try
    QGastosSalidas.Post;
    AMsg:= 'OK';
    result:= True;
  except
    QGastosSalidas.Cancel;
    AMsg:= 'ERROR: Al grabar en la base de datos ' + sError;;
    result:= False;
  end;
end;

end.
