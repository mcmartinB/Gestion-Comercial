unit CDAsignarGastosTransitos;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;

type
  TDAsignarGastosTransitos = class(TDataModule)
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
    procedure DataModuleCreate(Sender: TObject);
    procedure QGastosServicioLinAfterOpen(DataSet: TDataSet);
    procedure QGastosServicioLinBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    QSelectSalidasAux: TQuery;
    sServicio: string;
    sCodigoGasto: string;
    iLineaGasto: integer;

    function GastosLineaFactura( var AMsg: string ): boolean;
    function GrabarGastoTemporal( const AEmpresa, ACentroSalida: string;
                                  const AALbaran: integer; const AFecha: TDateTime;
                                  const AProducto: string; const AImporte: real; var AMsg: string  ): boolean;
    function ActualizarGastosBD( const AActualizarEstado: Boolean; var AMsg: string ): boolean;
    function ActualizarEstadoServicio( var AMsg: string ): boolean;
    function CopiarLosDatosTablaTempral( var AMsg: string ): boolean;
    function GrabarGastoBD( var AMsg: string ): boolean;
    function BorrarGastosAntiguosSalida: boolean;

    //function MargenTiempoOK( const AEmpresa: string; const AServicio: integer; var vMsg: string ): boolean;

  public
    { Public declarations }
    function RepercutirGastosServicio( const AEmpresa: string; const AServicio: Integer;
                                       const AActualizarEstado: Boolean; var AMsg: string  ): boolean;
  end;

  procedure ActualizarEstadoServicio_( const AEmpresa, ACentro: string; const ASalida: integer; const AFEcha: TDateTime );

var
  DAsignarGastosTransitos: TDAsignarGastosTransitos;

implementation

uses
  bMath, Dialogs, UDMBaseDatos, Controls;

{$R *.dfm}

procedure ActualizarEstadoServicio_( const AEmpresa, ACentro: string; const ASalida: integer; const AFEcha: TDateTime );
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

procedure TDAsignarGastosTransitos.DataModuleCreate(Sender: TObject);
begin
  with QGastosServicioLin do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_gsv, servicio_gsv , tipo_gsv, producto_gsv, importe_gsv, ');
    SQL.Add('        ref_fac_gsv, fecha_fac_gsv, nota_gsv, pagado_gsv ');
    SQL.Add(' from frf_gastos_servicios_venta ');
    SQL.Add(' where empresa_gsv = :empresa_gsv ');
    SQL.Add(' and servicio_gsv = :servicio_gsv ');
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
    SQL.Add(' select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, producto_sl, sum(kilos_sl) kilos_sl ');
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
    SQL.Add(' select sum(kilos_sl) kilos_sl ');
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
    SQL.Add(' select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, producto_sl, sum(kilos_sl) kilos_sl ');
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
    SQL.Add(' select sum(kilos_sl) kilos_sl ');
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

  mtAuxGastos.FieldDefs.Clear;
  mtAuxGastos.FieldDefs.Add('empresa_g', ftString, 3, False);
  mtAuxGastos.FieldDefs.Add('centro_salida_g', ftString, 12, False);
  mtAuxGastos.FieldDefs.Add('n_albaran_g', ftInteger, 0, False);
  mtAuxGastos.FieldDefs.Add('fecha_g', ftString, 12, False);
  mtAuxGastos.FieldDefs.Add('tipo_g', ftString, 3, False);
  mtAuxGastos.FieldDefs.Add('producto_g', ftString, 3, False);
  mtAuxGastos.FieldDefs.Add('importe_g', ftFloat, 0, False);
  mtAuxGastos.FieldDefs.Add('ref_fac_g', ftString, 10, False);
  mtAuxGastos.FieldDefs.Add('fecha_fac_g', ftDate, 0, False);
  mtAuxGastos.FieldDefs.Add('nota_g', ftString, 30, False);
  mtAuxGastos.FieldDefs.Add('pagado_g', ftInteger, 0, False);

  mtAuxGastos.IndexFieldNames:= 'empresa_g;centro_salida_g;n_albaran_g;fecha_g;tipo_g';
  mtAuxGastos.SortFields:= 'empresa_g;centro_salida_g;n_albaran_g;fecha_g;tipo_g';
  mtAuxGastos.CreateTable;
end;

procedure TDAsignarGastosTransitos.QGastosServicioLinAfterOpen(DataSet: TDataSet);
begin
  QSelectSalidasProducto.Open;
  QSumSalidasProducto.Open;
  QSelectSalidasTodas.Open;
  QSumSalidasTodas.Open;
end;

procedure TDAsignarGastosTransitos.QGastosServicioLinBeforeClose(DataSet: TDataSet);
begin
  QSumSalidasTodas.Close;
  QSelectSalidasTodas.Close;
  QSumSalidasProducto.Close;
  QSelectSalidasProducto.Close;
end;

function TDAsignarGastosTransitos.RepercutirGastosServicio( const AEmpresa: string;
                           const AServicio: Integer; const AActualizarEstado: Boolean;
                           var AMsg: string ): boolean;
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
        result:= GastosLineaFactura( AMsg );
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

function TDAsignarGastosTransitos.GastosLineaFactura( var AMsg: string ): boolean;
var
  sEmpresa, sCentro, sProducto: string;
  iAlbaran: integer;
  dFecha: TDateTime;
  rKilosTotal, rImporteTotal, rImporteAcum, rImporte: real;
  rKilosAux, rKilosAcum: Real;
begin
  result:= False;

  if QGastosServicioLin.FieldByName('producto_gsv').AsString = '' then
  begin
    rKilosTotal:= QSumSalidasTodas.FieldByname('kilos_sl').AsFloat;
    QSelectSalidasAux:= QSelectSalidasTodas;
  end
  else
  begin
    rKilosTotal:= QSumSalidasProducto.FieldByname('kilos_sl').AsFloat;
    QSelectSalidasAux:= QSelectSalidasProducto;
  end;

  if rKilosTotal <> 0 then
  begin
    rImporteTotal:= QGastosServicioLin.FieldByname('importe_gsv').AsFloat;
    rImporteAcum:= 0;
    rKilosAcum:= 0;
    QSelectSalidasAux.First;
    while not QSelectSalidasAux.Eof do
    begin
      sEmpresa:= QSelectSalidasAux.FieldByName('empresa_sl').AsString;
      sCentro:= QSelectSalidasAux.FieldByName('centro_Salida_sl').AsString;
      iAlbaran:= QSelectSalidasAux.FieldByName('n_albaran_sl').AsInteger;
      dFecha:= QSelectSalidasAux.FieldByName('fecha_sl').AsDateTime;
      sProducto:= QSelectSalidasAux.FieldByName('producto_sl').AsString;
      rKilosAux:= QSelectSalidasAux.FieldByName('kilos_sl').AsFloat;
      rKilosAcum:= rKilosAcum + rKilosAux;
      rImporte:=  bRoundTo( ( rImporteTotal *  rKilosAux) / rKilosTotal, -2 );
      rImporteAcum:= rImporteAcum + rImporte;
      QSelectSalidasAux.Next;
      if QSelectSalidasAux.Eof then
      begin
        rImporte:= bRoundTo( ( rImporte + ( rImporteTotal - rImporteAcum ) ), -2 );
      end;
      result:= GrabarGastoTemporal( sEmpresa, sCentro, iAlbaran, dFecha, sProducto, rImporte, AMsg );
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

function TDAsignarGastosTransitos.GrabarGastoTemporal( const AEmpresa, ACentroSalida: string;
                                                           const AALbaran: integer;
                                                           const AFecha: TDateTime;
                                                           const AProducto: string;
                                                           const AImporte: real; var AMsg: string  ): boolean;
begin
  mtAuxGastos.Insert;
  mtAuxGastos.FieldByName('empresa_g').AsString:= AEmpresa;
  mtAuxGastos.FieldByName('centro_salida_g').AsString:= ACentroSalida;
  mtAuxGastos.FieldByName('n_albaran_g').AsInteger:= AALbaran;
  mtAuxGastos.FieldByName('fecha_g').AsDateTime:= AFecha;
  mtAuxGastos.FieldByName('tipo_g').AsString:= QGastosServicioLin.FieldByName('tipo_gsv').AsString;
  mtAuxGastos.FieldByName('producto_g').AsString:= AProducto;
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

function TDAsignarGastosTransitos.BorrarGastosAntiguosSalida: boolean;
begin
  QBorrarGastosSalidas.ParamByName('servicio').AsString:= 'SERVICIO: ' + sServicio;
  QBorrarGastosSalidas.ExecSQL;
  result:= QBorrarGastosSalidas.RowsAffected > 0;
end;

function TDAsignarGastosTransitos.ActualizarGastosBD( const AActualizarEstado: Boolean; var AMsg: string  ): boolean;
begin
  sCodigoGasto:= '';
  iLineaGasto:= 0;
  mtAuxGastos.Sort([]);
  try
    if not DMBaseDatos.DBBaseDatos.InTransaction then
    begin
      DMBaseDatos.DBBaseDatos.StartTransaction;
      if AActualizarEstado then
        result:= ActualizarEstadoServicio( AMsg )
      else
        result:= True;
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

function TDAsignarGastosTransitos.ActualizarEstadoServicio( var AMsg: string ): boolean;
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

function TDAsignarGastosTransitos.CopiarLosDatosTablaTempral( var AMsg: string ): boolean;
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

function TDAsignarGastosTransitos.GrabarGastoBD( var AMsg: string ): boolean;
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

(*
function TDAsignarGastosServicioVenta.MargenTiempoOK( const AEmpresa: string; const AServicio: integer; var vMsg: string ): boolean;
begin
  vMsg:= 'ERROR: Cerrado por liquidación. ' + sServicio;
  result:= true;

  with QProductosCentro do
  begin
    SQL.Clear;
    //Localizar centros / productos afectados por el servicio
    SQL.Add(' select empresa_sl, centro_origen_sl, producto_sl, min(fecha_sl) fechaMin ');
    SQL.Add(' from frf_salidas_servicios_venta, frf_salidas_l ');
    SQL.Add(' where empresa_ssv = :empresa ');
    SQL.Add(' and servicio_ssv = :servicio ');
    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_Salida_sl = centro_Salida_ssv ');
    SQL.Add(' and n_albaran_sl = n_albaran_ssv ');
    SQL.Add(' and fecha_sl = fecha_ssv ');
    SQL.Add(' group by empresa_sl, centro_origen_sl, producto_sl ');
    SQL.Add(' order by empresa_sl, centro_origen_sl, producto_sl ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('servicio').AsInteger:= AServicio;
    Open;
  end;

  with QFechasLiquida do
  begin
    SQL.Clear;
    //Fecha ultima liquidacion definitiva para el centro / producto
    SQL.Add(' select max(fecha_fin_ld) fechaLiquida ');
    SQL.Add(' from frf_liquida_definitiva ');
    SQL.Add(' where empresa_ld = :empresa ');
    SQL.Add(' and centro_ld = :centro ');
    SQL.Add(' and producto_ld = :producto ');
    SQL.Add(' and definitiva_ld = 1 ');
  end;


  with QSalidasLiquidadas do
  begin
    SQL.Clear;
    //Hay salidas con fecha inferior ultima liquidacion definitiva
    SQL.Add(' select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl');
    SQL.Add(' from frf_salidas_servicios_venta, frf_salidas_l ');
    SQL.Add(' where empresa_ssv = :empresa ');
    SQL.Add(' and servicio_ssv = :servicio ');
    SQL.Add(' and fecha_ssv <= :fechaLiquida ');
    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_origen_sl = :centroOrigen ');
    SQL.Add(' and producto_sl  = :producto ');
    SQL.Add(' and centro_Salida_sl = centro_Salida_ssv ');
    SQL.Add(' and n_albaran_sl = n_albaran_ssv ');
    SQL.Add(' and fecha_sl = fecha_ssv ');
    SQL.Add(' group by empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl ');
    SQL.Add(' order by empresa_sl, centro_salida_sl, fecha_sl, n_albaran_sl ');
  end;

  while not QProductosCentro.eof do
  begin
    QFechasLiquida.ParamByName('empresa').AsString:= QProductosCentro.FieldByName('empresa_sl').AsString;
    QFechasLiquida.ParamByName('centro').AsString:= QProductosCentro.FieldByName('centro_origen_sl').AsString;
    QFechasLiquida.ParamByName('producto').AsString:= QProductosCentro.FieldByName('producto_sl').AsString;
    QFechasLiquida.Open;

    //Hay salidas con fecha menor que la de la ultima liquidacion definitiva
    if QFechasLiquida.FieldByName('fechaLiquida').AsDateTime >= QProductosCentro.FieldByName('fechaMin').AsDateTime  then
    begin
      VMsg:= VMsg +  #13 + #10 + '  ' + AEmpresa + ' - ' + QProductosCentro.FieldByName('centro_origen_sl').AsString + ' - ' +  QProductosCentro.FieldByName('producto_sl').AsString +
             ' Liquidación definitiva el ' +  QFechasLiquida.FieldByName('fechaLiquida').AsString;

      QSalidasLiquidadas.ParamByName('empresa').AsString:= QProductosCentro.FieldByName('empresa_sl').AsString;
      QSalidasLiquidadas.ParamByName('servicio').AsInteger:= AServicio;
      QSalidasLiquidadas.ParamByName('centroOrigen').AsString:= QProductosCentro.FieldByName('centro_origen_sl').AsString;
      QSalidasLiquidadas.ParamByName('producto').AsString:= QProductosCentro.FieldByName('producto_sl').AsString;
      QSalidasLiquidadas.ParamByName('fechaLiquida').AsDateTime:= QFechasLiquida.FieldByName('fechaLiquida').AsDateTime;
      QSalidasLiquidadas.Open;

      while not QSalidasLiquidadas.Eof do
      begin
        if result then
          result:= False;
        VMsg:= VMsg +  #13 + #10 + '   * Albarán ' + AEmpresa + ' - ' + QSalidasLiquidadas.FieldByName('centro_salida_sl').AsString + ' - ' +
                       QSalidasLiquidadas.FieldByName('fecha_sl').AsString + ' - ' + QSalidasLiquidadas.FieldByName('n_albaran_sl').AsString;
        QSalidasLiquidadas.Next;
      end;
      QSalidasLiquidadas.Close;

    end;
    QFechasLiquida.Close;
    QProductosCentro.Next;
  end;
  QProductosCentro.Close;
end;
*)

end.
