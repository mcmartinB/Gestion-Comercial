unit ServiciosEntregaDM;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;

type
  TDMServiciosEntrega = class(TDataModule)
    QCambiarStatus: TQuery;
    QGastosServicio: TQuery;
    DSSelectLineas: TDataSource;
    mtAuxGastos: TkbmMemTable;
    DSGastos: TDataSource;
    QSelectEntregas: TQuery;
    QSumEntregas: TQuery;
    QGastosEntregas: TQuery;
    QBorrarGastosEntregas: TQuery;
    qryNumLinea: TQuery;
    qryDesServicio: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure QGastosServicioAfterOpen(DataSet: TDataSet);
    procedure QGastosServicioBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    sDesServicio: string;
    iServicio: Integer;
    bPreguntar: Boolean;

    function GastosLineaFactura( const AUnidadDist: string; var AMsg: string ): boolean;
    function GrabarGastoTemporal( const AEntrega: string; const AImporte: real; var AMsg: string  ): boolean;
    function ActualizarGastosBD( const AActualizarEstado: Boolean; var AMsg: string ): boolean;
    function ActualizarEstadoServicio( var AMsg: string ): boolean;
    function CopiarLosDatosTablaTempral( var AMsg: string ): boolean;
    function GrabarGastoBD( const ALinea: Integer; var AMsg: string ): boolean;
    function BorrarGastosAntiguosEntrega:  boolean;
    procedure BorrarEstimaciones;
    function GetLineaGasto( const AEntrega: string ): Integer;
    function DesServicio: String;

    //function MargenTiempoOK( const AEmpresa: string; const AServicio: integer; var vMsg: string ): boolean;

  public
    { Public declarations }
    function RepercutirGastosServicio( const AServicio: Integer; const AUnidadDist: string;
                                       const AActualizarEstado: Boolean; const APreguntar: Boolean;
                                       var AMsg: string ): boolean;
    procedure BorrarGastosServicio( const AServicio: Integer );
  end;

  //procedure ActualizarEstadoServicioCompra_( const AEntrega: string );

var
  DMServiciosEntrega: TDMServiciosEntrega;

implementation

uses
  bMath, Dialogs, UDMBaseDatos, Controls;

{$R *.dfm}

(*
procedure ActualizarEstadoServicioCompra_( const AEntrega: string );
begin
  with DMBaseDatos do
  begin
    QAux.SQL.Clear;
    QAux.SQL.Add(' update frf_servicios_entrega_c ');
    QAux.SQL.Add(' set status_sec = 1 ');
    QAux.SQL.Add(' where exists ');
    QAux.SQL.Add(' ( ');
    QAux.SQL.Add('  select * ');
    QAux.SQL.Add('   from frf_servicios_entrega_l ');
    QAux.SQL.Add('   where entrega_sel = :entrega ');
    QAux.SQL.Add('   and servicio_sel =  servicio_sec ');
    QAux.SQL.Add(' ) ');
    QAux.SQL.Add(' and status_sec = 2 ');
    QAux.ParamByName('entrega').AsString:= AEntrega;
    QAux.ExecSql;
  end;
end;
*)

procedure TDMServiciosEntrega.DataModuleCreate(Sender: TObject);
begin
  with QGastosServicio do
  begin
    SQL.Clear;
    SQL.Add(' select servicio_seg, tipo_seg, importe_seg, ref_fac_seg, fecha_fac_seg, ');
    SQL.Add('        nota_seg, nvl(unidad_dist_tg[1,1], ''K'') unidad, ');
    SQL.Add('        fecha_sec, matricula_sec ');
    SQL.Add(' from frf_servicios_entrega_g, frf_tipo_gastos, frf_servicios_entrega_c ');
    SQL.Add(' where servicio_seg = :servicio ');
    SQL.Add(' and tipo_tg = tipo_seg ');
    SQL.Add(' and servicio_seg = servicio_sec ');
  end;

  with QCambiarStatus do
  begin
    SQL.Clear;
    SQL.Add(' update frf_servicios_entrega_c ');
    SQL.Add(' set status_sec = 2 ');
    SQL.Add(' where servicio_sec = :servicio_seg ');
  end;

  with QSelectEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_el entrega, ');
    SQL.Add('        sum(kilos_el) kilos_entrega, ');
    SQL.Add('        sum(palets_el) palets_entrega, ');
    SQL.Add('        sum(cajas_el) cajas_entrega, ');
    SQL.Add('        sum( round( precio_kg_el * kilos_el, 2 ) ) importe_entrega ');

    SQL.Add(' from frf_servicios_entrega_l, frf_entregas_l ');
    SQL.Add(' where servicio_sel = :servicio_seg ');
    SQL.Add(' and codigo_el = entrega_sel ');
    SQL.Add(' group by entrega ');
    SQL.Add(' order by entrega ');
  end;

  with QSumEntregas do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_el) kilos_servicio, ');
    SQL.Add('        sum(palets_el) palets_servicio, ');
    SQL.Add('        sum(cajas_el) cajas_servicio, ');
    SQL.Add('        sum( round( precio_kg_el * kilos_el, 2 ) ) importe_servicio ');

    SQL.Add(' from frf_servicios_entrega_l, frf_entregas_l ');
    SQL.Add(' where servicio_sel = :servicio_seg ');
    SQL.Add(' and codigo_el = entrega_sel ');
  end;

  with QGastosEntregas do
  begin
    RequestLive:= True;
    SQL.Clear;
    SQL.Add(' select * from frf_gastos_entregas ');
  end;

  with QBorrarGastosEntregas do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where nota_ge = :servicio ');
    SQL.Add(' and solo_lectura_ge = 1 ');
  end;

  mtAuxGastos.FieldDefs.Clear;
  mtAuxGastos.FieldDefs.Add('codigo_ge', ftString, 12, False);
  //mtAuxGastos.FieldDefs.Add('linea_ge', ftInteger, 0, False);
  mtAuxGastos.FieldDefs.Add('tipo_ge', ftString, 3, False);
  //mtAuxGastos.FieldDefs.Add('producto_ge', ftString, 3, False);
  mtAuxGastos.FieldDefs.Add('importe_ge', ftFloat, 0, False);
  mtAuxGastos.FieldDefs.Add('ref_fac_ge', ftString, 15, False);
  mtAuxGastos.FieldDefs.Add('fecha_fac_ge', ftDate, 0, False);
  mtAuxGastos.FieldDefs.Add('nota_ge', ftString, 30, False);


  mtAuxGastos.IndexFieldNames:= 'codigo_ge;tipo_ge';
  mtAuxGastos.SortFields:= 'codigo_ge;tipo_ge';
  mtAuxGastos.CreateTable;

  with qryNumLinea do
  begin
    SQL.Clear;
    SQL.Add(' select nvl(max(linea_ge),0) linea ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :entrega ');
  end;

  with qryDesServicio do
  begin
    SQL.Clear;
    SQL.Add(' select servicio_sec, fecha_sec, matricula_sec ');
    SQL.Add(' from frf_servicios_entrega_c ');
    SQL.Add(' where servicio_sec = :servicio ');
  end;
end;

procedure TDMServiciosEntrega.QGastosServicioAfterOpen(DataSet: TDataSet);
begin
  QSelectEntregas.Open;
  QSumEntregas.Open;
end;

procedure TDMServiciosEntrega.QGastosServicioBeforeClose(DataSet: TDataSet);
begin
  QSumEntregas.Close;
  QSelectEntregas.Close;
end;


function TDMServiciosEntrega.DesServicio: string;
begin
  with qryDesServicio do
  begin
    ParamByName('servicio').AsInteger:= iServicio;
    Open;
    Result:= IntToStr( iServicio ) + '|'+
             FieldByName('fecha_sec').AsString + '|'+
             FieldByName('matricula_sec').AsString;
    Close;
  end;
end;

function TDMServiciosEntrega.RepercutirGastosServicio(
                           const AServicio: Integer; const AUnidadDist: string;
                           const AActualizarEstado: Boolean; const APreguntar: Boolean;
                           var AMsg: string ): boolean;
var
  sAux: string;
  //bAux: boolean;
begin
  sAux:= AMsg;
  iServicio:= AServicio;
  bPreguntar:= APreguntar;

  //if bAux then
  begin
    AMsg:= sAux;
    mtAuxGastos.Open;

    QGastosServicio.ParamByName('servicio').AsInteger:= AServicio;
    QGastosServicio.Open;
    sDesServicio:= DesServicio;

    if QGastosServicio.IsEmpty then
    begin
      result:= BorrarGastosAntiguosEntrega;
      if result then
      begin
       AMsg:= '* OK : Gastos servicio borrados correctamente. ' + sDesServicio;
       Exit;
      end
      else
      begin
        AMsg:= 'ERROR: Servicio sin gastos. ' + sDesServicio;
      end;
    end
    else
    begin
      result:= True;
      while ( not QGastosServicio.Eof ) and result do
      begin
        result:= GastosLineaFactura( AUnidadDist, AMsg );
        QGastosServicio.Next;
      end;
    end;

    if result then
    begin
      result:= ActualizarGastosBD( AActualizarEstado, AMsg );
    end;

    QGastosServicio.Close;
    mtAuxGastos.Close;

    if result then
    begin
      AMsg:= '* OK :Gastos servicio asignados correctamente. ' + sDesServicio;
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

function TDMServiciosEntrega.GastosLineaFactura( const AUnidadDist: string; var AMsg: string ): boolean;
var
  sEntrega: string;
  iUnidad: Integer;
  rUnidadesTotal, rUnidades: Real;
  rImporteTotal, rImporte, rImporteAcum: real;
begin
  result:= False;

  iUnidad:= UnidadDist( AUnidadDist, QGastosServicio.FieldByName('unidad').AsString );
  case iUnidad of
    0: rUnidadesTotal:= QSumEntregas.FieldByname('palets_servicio').AsFloat;
    1: rUnidadesTotal:= QSumEntregas.FieldByname('cajas_servicio').AsFloat;
    2: rUnidadesTotal:= QSumEntregas.FieldByname('importe_servicio').AsFloat;
    else rUnidadesTotal:= QSumEntregas.FieldByname('kilos_servicio').AsFloat;
  end;

  if rUnidadesTotal <> 0 then
  begin
    rImporteTotal:= QGastosServicio.FieldByname('importe_seg').AsFloat;
    rImporteAcum:= 0;


    QSelectEntregas.First;
    while not QSelectEntregas.Eof do
    begin
      sEntrega:= QSelectEntregas.FieldByName('entrega').AsString;

      case iUnidad of
        0: rUnidades:= QSelectEntregas.FieldByName('palets_entrega').AsFloat;
        1: rUnidades:= QSelectEntregas.FieldByName('cajas_entrega').AsFloat;
        2: rUnidades:= QSelectEntregas.FieldByName('importe_entrega').AsFloat;
        else rUnidades:= QSelectEntregas.FieldByName('kilos_entrega').AsFloat;
      end;

      if rUnidades <> 0 then
        rImporte:=  bRoundTo( ( rImporteTotal *  rUnidades) / rUnidadesTotal, -2 )
      else
        rImporte:=  0;
      rImporteAcum:= rImporteAcum + rImporte;


      QSelectEntregas.Next;
      if QSelectEntregas.Eof then
      begin
        rImporte:= bRoundTo( ( rImporte + ( rImporteTotal - rImporteAcum ) ), -2 );
      end;
      result:= GrabarGastoTemporal( sEntrega, rImporte, AMsg );
    end;
  end
  else
  begin
    if QSelectEntregas.IsEmpty then
    begin
      result:= BorrarGastosAntiguosEntrega;
      if result then
      begin
       AMsg:= '* OK : Gastos servicio borrados correctamente. ' + sDesServicio;
       Exit;
      end
      else
      begin
        //AMsg:= 'ERROR: Servicio sin gastos. ' + sDesServicio;
        AMsg:= 'ERROR: Servicio sin albaranes de salida. ' + sDesServicio;
      end;
    end
    else
    begin
      AMsg:= 'ERROR: Entrega sin kilos. (' + QSelectEntregas.FieldByName('entrega').AsString  + ')';
    end;
  end;
end;

function TDMServiciosEntrega.GrabarGastoTemporal( const AEntrega: string; const AImporte: real; var AMsg: string  ): boolean;
begin
  mtAuxGastos.Insert;

  mtAuxGastos.FieldByName('codigo_ge').AsString:= AEntrega;
  //mtAuxGastos.FieldByName('linea_ge').AsInteger:= GetLineaGasto( AEntrega );
  mtAuxGastos.FieldByName('tipo_ge').AsString:= QGastosServicio.FieldByName('tipo_seg').AsString;
  //mtAuxGastos.FieldByName('producto_g').AsString:= AProducto;
  mtAuxGastos.FieldByName('importe_ge').AsFloat:= AImporte;
  mtAuxGastos.FieldByName('ref_fac_ge').AsString:= QGastosServicio.FieldByName('ref_fac_seg').AsString;
  mtAuxGastos.FieldByName('fecha_fac_ge').Value:= QGastosServicio.FieldByName('fecha_fac_seg').value;
  mtAuxGastos.FieldByName('nota_ge').AsString:= sDesServicio; //QGastosServicioLin.FieldByName('servicio_gsv').AsString;;

  try
    mtAuxGastos.Post;
    AMsg:= 'OK';
    result:= True;
  except
    AMsg:= 'ERROR: Al grabar en la tabla temporal (' + AEntrega + ', ' +
              QGastosServicio.FieldByName('tipo_seg').AsString + ', ' +
              FloatTostr( AImporte ) + ')';
    mtAuxGastos.Cancel;
    result:= False;
  end;
end;

procedure TDMServiciosEntrega.BorrarGastosServicio( const AServicio: Integer );
begin
  iServicio:= AServicio;
  //BorrarEstimaciones
  sDesServicio:= DesServicio;
  QBorrarGastosEntregas.ParamByName('servicio').AsString:= sDesServicio;
  QBorrarGastosEntregas.ExecSQL;
end;

procedure TDMServiciosEntrega.BorrarEstimaciones;
var
  bFlag: Boolean;
  sAux: string;
begin
  if bPreguntar then
  begin
    DMBaseDatos.QTemp.SQL.Clear;
    DMBaseDatos.QTemp.SQL.Add(' select trim( codigo_ge || '': '' || tipo_ge || '' --> ''  || nvl(importe_ge,0) ||  ''Eur  ''  || nvl(nota_ge,'''') ) estimacion ');
    DMBaseDatos.QTemp.SQL.Add(' from frf_gastos_entregas ');
    DMBaseDatos.QTemp.SQL.Add(' where exists ');
    DMBaseDatos.QTemp.SQL.Add('   ( ');
    DMBaseDatos.QTemp.SQL.Add('     select * ');
    DMBaseDatos.QTemp.SQL.Add('     from frf_servicios_entrega_l ');
    DMBaseDatos.QTemp.SQL.Add('     where servicio_sel = :servicio ');
    DMBaseDatos.QTemp.SQL.Add('     and entrega_sel = codigo_ge ');
    DMBaseDatos.QTemp.SQL.Add('     and ref_fac_ge is null ');
    DMBaseDatos.QTemp.SQL.Add('     and solo_lectura_ge = 0 ');
    DMBaseDatos.QTemp.SQL.Add('     and tipo_ge in ');
    DMBaseDatos.QTemp.SQL.Add('       ( ');
    DMBaseDatos.QTemp.SQL.Add('         select tipo_seg ');
    DMBaseDatos.QTemp.SQL.Add('         from frf_servicios_entrega_g ');
    DMBaseDatos.QTemp.SQL.Add('         where servicio_seg = :servicio ');
    DMBaseDatos.QTemp.SQL.Add('       ) ');
    DMBaseDatos.QTemp.SQL.Add('   ) ');
    DMBaseDatos.QTemp.SQL.Add(' order by codigo_ge, tipo_ge ');

    DMBaseDatos.QTemp.ParamByName('servicio').AsInteger:= iServicio;
    DMBaseDatos.QTemp.Open;

    //si hay estimaciones borrar
    if not DMBaseDatos.QTemp.IsEmpty then
    begin

      while not DMBaseDatos.QTemp.Eof do
      begin
        sAux:= sAux + #13 + #10 + DMBaseDatos.QTemp.FieldByname('estimacion').AsString;
        DMBaseDatos.QTemp.Next;
      end;
      bFlag:= MessageDlg('Las entregas seleccionadas ya tienen grabada una estimación, ¿desea borrarlas?.' + sAux, mtConfirmation, [mbYes,mbNo], 0 ) = mrYes;
      DMBaseDatos.QTemp.Close;

    end
    else
    begin
      bFlag:= False;
      DMBaseDatos.QTemp.Close;
    end;
  end
  else
  begin
    bFlag:= True;
  end;

  if bFlag  then
      begin

        DMBaseDatos.QTemp.SQL.Clear;
        DMBaseDatos.QTemp.SQL.Add(' delete ');
        DMBaseDatos.QTemp.SQL.Add(' from frf_gastos_entregas ');
        DMBaseDatos.QTemp.SQL.Add(' where exists ');
        DMBaseDatos.QTemp.SQL.Add('   ( ');
        DMBaseDatos.QTemp.SQL.Add('     select * ');
        DMBaseDatos.QTemp.SQL.Add('     from frf_servicios_entrega_l ');
        DMBaseDatos.QTemp.SQL.Add('     where servicio_sel = :servicio ');
        DMBaseDatos.QTemp.SQL.Add('     and entrega_sel = codigo_ge ');
        DMBaseDatos.QTemp.SQL.Add('     and ref_fac_ge is null ');
        DMBaseDatos.QTemp.SQL.Add('     and solo_lectura_ge = 0 ');
        DMBaseDatos.QTemp.SQL.Add('     and tipo_ge in ');
        DMBaseDatos.QTemp.SQL.Add('       ( ');
        DMBaseDatos.QTemp.SQL.Add('         select tipo_seg ');
        DMBaseDatos.QTemp.SQL.Add('         from frf_servicios_entrega_g ');
        DMBaseDatos.QTemp.SQL.Add('         where servicio_seg = :servicio ');
        DMBaseDatos.QTemp.SQL.Add('       ) ');
        DMBaseDatos.QTemp.SQL.Add('   ) ');
        DMBaseDatos.QTemp.ParamByName('servicio').AsInteger:= iServicio;
        DMBaseDatos.QTemp.ExecSQL;
      end;
end;

function TDMServiciosEntrega.BorrarGastosAntiguosEntrega: boolean;
begin
  BorrarEstimaciones;
  QBorrarGastosEntregas.ParamByName('servicio').AsString:= sDesServicio;
  QBorrarGastosEntregas.ExecSQL;
  result:= QBorrarGastosEntregas.RowsAffected > 0;
end;

function TDMServiciosEntrega.ActualizarGastosBD( const AActualizarEstado: Boolean; var AMsg: string  ): boolean;
begin
  try
    if not DMBaseDatos.DBBaseDatos.InTransaction then
    begin
      DMBaseDatos.DBBaseDatos.StartTransaction;
      result:= True;
      if AActualizarEstado then
        result:= ActualizarEstadoServicio( AMsg );
      (*
      else
        result:= True;
      *)
      if result then
      begin
        BorrarGastosAntiguosEntrega;
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
                mtAuxGastos.FieldByName('codigo_ge').AsString + ', ' +
                mtAuxGastos.FieldByName('tipo_ge').AsString + ', ' +
                mtAuxGastos.FieldByName('importe_ge').AsString  + ')';
        end;
      end;
    end
    else
    begin
      AMsg:= 'Transacción ya abierta. ' + sDesServicio;
      result:= false;
    end;
  except
    AMsg:= 'ERROR: Problemas al grabar el gasto en la base de datos. (' +
                mtAuxGastos.FieldByName('codigo_ge').AsString + ', ' +
                mtAuxGastos.FieldByName('tipo_ge').AsString + ', ' +
                mtAuxGastos.FieldByName('importe_ge').AsString  + ')';
    DMBaseDatos.DBBaseDatos.Rollback;
    result:= False;
  end;
end;

function TDMServiciosEntrega.ActualizarEstadoServicio( var AMsg: string ): boolean;
begin
  try
    QCambiarStatus.ExecSQL;
    result:= True;
    AMsg:= 'OK';
  except
    result:= False;
    AMsg:= 'ERROR: Al actualizar el estado del servicio. ' + sDesServicio;
  end;
end;

function TDMServiciosEntrega.GetLineaGasto( const AEntrega: string ): Integer;
begin
  with qryNumLinea do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    Result:= FieldByName('linea').AsInteger;
    Close;
  end;
end;

function TDMServiciosEntrega.CopiarLosDatosTablaTempral( var AMsg: string ): boolean;
var
  sEntrega: string;
  iLinea: Integer;
begin
  if Not mtAuxGastos.IsEmpty then
  begin
    result:= True;
    QGastosEntregas.Open;
    try
      mtAuxGastos.Sort([]);
      mtAuxGastos.First;
      sEntrega:= '';
      iLinea:= 0;

      while ( not mtAuxGastos.Eof ) and result do
      begin
        if sEntrega <> mtAuxGastos.FieldByName('codigo_ge').AsString then
        begin
          sEntrega:= mtAuxGastos.FieldByName('codigo_ge').AsString;
          iLinea:= GetLineaGasto( sEntrega );
        end;
        inc( iLinea );
        result:= GrabarGastoBD( iLinea, AMsg );
        mtAuxGastos.Next;
      end;

    finally
      QGastosEntregas.Close;
    end;
  end
  else
  begin
    AMsg:= 'ERROR: Sin gastos para grabar en la tabla temporal. ' + sDesServicio;
    result:= False;
  end;
end;

function TDMServiciosEntrega.GrabarGastoBD( const ALinea: Integer; var AMsg: string ): boolean;
var
  sError: String;
begin
  sError:= '(' + mtAuxGastos.FieldByName('codigo_ge').AsString + ', ' +
              mtAuxGastos.FieldByName('tipo_ge').AsString + ', ' +
              mtAuxGastos.FieldByName('importe_ge').AsString  + ')';

  QGastosEntregas.Insert;
  QGastosEntregas.FieldByName('codigo_ge').AsString:= mtAuxGastos.FieldByName('codigo_ge').AsString;
  QGastosEntregas.FieldByName('linea_ge').AsInteger:= ALinea;//mtAuxGastos.FieldByName('linea_ge').AsInteger;
  QGastosEntregas.FieldByName('tipo_ge').AsString:= mtAuxGastos.FieldByName('tipo_ge').AsString;
  //QGastosEntregas.FieldByName('producto_g').AsString:= mtAuxGastos.FieldByName('producto_g').AsString;
  QGastosEntregas.FieldByName('importe_ge').AsFloat:= mtAuxGastos.FieldByName('importe_ge').AsFloat;
  QGastosEntregas.FieldByName('ref_fac_ge').AsString:= mtAuxGastos.FieldByName('ref_fac_ge').AsString;
  QGastosEntregas.FieldByName('fecha_fac_ge').Value:= mtAuxGastos.FieldByName('fecha_fac_ge').vALUE;
  QGastosEntregas.FieldByName('nota_ge').AsString:= mtAuxGastos.FieldByName('nota_ge').AsString;
  QGastosEntregas.FieldByName('solo_lectura_ge').AsInteger:= 1;
  QGastosEntregas.FieldByName('envio_ge').AsInteger:= 0;
  try
    QGastosEntregas.Post;
    AMsg:= 'OK';
    result:= True;
  except
    QGastosEntregas.Cancel;
    AMsg:= 'ERROR: Al grabar en la base de datos ' + sError;;
    result:= False;
  end;
end;

end.
