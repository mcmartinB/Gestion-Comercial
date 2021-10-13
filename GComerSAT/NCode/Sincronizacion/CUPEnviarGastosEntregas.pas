(*CODIGO*)
(*Indica donde insertar codigo*)
(*REVISAR*)
(*Codigo que funciona pero deberias cambiar*)
unit CUPEnviarGastosEntregas;

interface

uses SysUtils, DB, DBTables, UDMConfig, ComCtrls, Forms, Classes;

function SincronizarGastosEntregas( const AEmpresa: string; const ATipoCentro: integer; const ACentro: string;
                              const ATipoFecha: integer; const AInicio, AFin: TDateTime;
                              const ATipoCodigo: integer; const ACodigo: String;
                              const AEntregaFinalizadas: boolean; var ABarraProgeso: TProgressBar;
                              var AMsg: String; var APasados: integer ): integer;
implementation

uses
  UDMBaseDatos;

var
  QSourceCab: TQuery;
  QSourceCount: TQuery;
  QSourceMarcar: TQuery;
  DSCab: TDataSource;
  QTargetCab: TQuery;
  QTargetCount: TQuery;
  QTargetLinea: TQuery;

  MyBarraProgeso: TProgressBar;

procedure AsignarBarraProgreso( ABarraProgeso: TProgressBar );
begin
  MyBarraProgeso:= ABarraProgeso;
end;

procedure LiberarBarraProgreso;
begin
  MyBarraProgeso:= NIL;
end;

procedure InicializarBarraProgreso( const AConsulta: TDataSet  );
begin
  if MyBarraProgeso <> nil then
  begin
    MyBarraProgeso.Min:= 0;
    MyBarraProgeso.Position:= 1;
    MyBarraProgeso.Step:= 1;

    try
      AConsulta.Open;
      try
        MyBarraProgeso.Max:= AConsulta.Fields[0].AsInteger + 1;
      finally
        AConsulta.Close;
      end;
    except
      MyBarraProgeso.Max:= 1;
    end;

    Application.ProcessMessages;
  end;
end;

procedure IncBarraProgreso;
begin
  if MyBarraProgeso <> nil then
  begin
    MyBarraProgeso.StepIt;
    Application.ProcessMessages;
  end;
end;

procedure CrearQuerys;
begin
  QSourceCab:= TQuery.Create( nil );
  QSourceCab.DatabaseName:= 'BDProyecto';

  QSourceCount:= TQuery.Create( nil );
  QSourceCount.DatabaseName:= 'BDProyecto';

  QSourceMarcar:= TQuery.Create( nil );
  QSourceMarcar.DatabaseName:= 'BDProyecto';

  DSCab:= TDataSource.Create( nil );
  DSCab.DataSet:= QSourceCab;

  QTargetCab:= TQuery.Create( nil );
  QTargetCab.DatabaseName:= 'BDCentral';
  QTargetCab.DataSource:= DSCab;
  QTargetCab.RequestLive:= True;

  QTargetCount:= TQuery.Create( nil );
  QTargetCount.DatabaseName:= 'BDCentral';
  QTargetCount.DataSource:= DSCab;

  QTargetLinea:= TQuery.Create( nil );
  QTargetLinea.DatabaseName:= 'BDCentral';
  QTargetLinea.DataSource:= DSCab;
end;

procedure DestruirQuerys;
begin
  FreeAndNil( QTargetCab );
  FreeAndNil( QTargetCount );
  FreeAndNil( QTargetLinea );
  FreeAndNil( QSourceCount );
  FreeAndNil( QSourceMarcar );
  FreeAndNil( DSCab );
  FreeAndNil( QSourceCab );
end;

procedure PreparaQuerysEntregas( const ATipoCentro: integer;
                                 const ATipoFecha: integer;
                                 const ATipoCodigo: integer;
                                 const AEntregaFinalizadas: boolean );
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_gastos_entregas');
  QTargetCab.SQL.Add('where codigo_ge = :codigo_ge ');
  QTargetCab.SQL.Add('  and tipo_ge = :tipo_ge ');
  QTargetCab.SQL.Add('  and producto_ge = :producto_ge ');
  QTargetCab.Prepare;

  QTargetCount.SQL.Clear;
  QTargetCount.SQL.Add('select count(*) registros ');
  QTargetCount.SQL.Add('from frf_gastos_entregas');
  QTargetCount.SQL.Add('where codigo_ge = :codigo_ge ');
  QTargetCount.SQL.Add('  and tipo_ge = :tipo_ge ');
  QTargetCount.SQL.Add('  and producto_ge = :producto_ge ');
  QTargetCount.Prepare;

  QTargetLinea.SQL.Clear;
  QTargetLinea.SQL.Add('select max(linea_ge) linea ');
  QTargetLinea.SQL.Add('from frf_gastos_entregas ');
  QTargetLinea.SQL.Add('where codigo_ge = :codigo_ge ');

  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_gastos_entregas ');
  QSourceCab.SQL.Add('where codigo_ge in ');
  QSourceCab.SQL.Add('(');
  QSourceCab.SQL.Add(' select codigo_ec ');
  QSourceCab.SQL.Add(' from frf_entregas_c');

  QSourceCab.SQL.Add(' where empresa_ec = :empresa');
  case ATipoCentro of
    0: QSourceCab.SQL.Add('   and centro_origen_ec = :centro');
    1: QSourceCab.SQL.Add('   and centro_llegada_ec = :centro');
  end;
  case ATipoFecha of
    0: QSourceCab.SQL.Add('   and fecha_origen_ec between :ini and :fin');
    1: QSourceCab.SQL.Add('   and fecha_llegada_ec between :ini and :fin');
  end;
  case ATipoCodigo of
    0: QSourceCab.SQL.Add('   and codigo_ec = :codigo');
    1: QSourceCab.SQL.Add('   and albaran_ec = :codigo');
    2: QSourceCab.SQL.Add('   and adjudicacion_ec = :codigo');
  end;
  if AEntregaFinalizadas then
  begin
    QSourceCab.SQL.Add('   and status_ec <> 0');
  end;
  QSourceCab.SQL.Add(')');
  QSourceCab.SQL.Add('  and envio_ge = 0');
  QSourceCab.Prepare;

  QSourceCount.SQL.Clear;
  QSourceCount.SQL.Add('select Count(*) ');
  QSourceCount.SQL.Add('from frf_gastos_entregas ');
  QSourceCount.SQL.Add('where codigo_ge in ');
  QSourceCount.SQL.Add('(');
  QSourceCount.SQL.Add(' select codigo_ec ');
  QSourceCount.SQL.Add(' from frf_entregas_c');

  QSourceCount.SQL.Add(' where empresa_ec = :empresa');
  case ATipoCentro of
    0: QSourceCount.SQL.Add('   and centro_origen_ec = :centro');
    1: QSourceCount.SQL.Add('   and centro_llegada_ec = :centro');
  end;
  case ATipoFecha of
    0: QSourceCount.SQL.Add('   and fecha_origen_ec between :ini and :fin');
    1: QSourceCount.SQL.Add('   and fecha_llegada_ec between :ini and :fin');
  end;
  case ATipoCodigo of
    0: QSourceCount.SQL.Add('   and codigo_ec = :codigo');
    1: QSourceCount.SQL.Add('   and albaran_ec = :codigo');
    2: QSourceCount.SQL.Add('   and adjudicacion_ec = :codigo');
  end;
  if AEntregaFinalizadas then
  begin
    QSourceCount.SQL.Add('   and status_ec <> 0');
  end;
  QSourceCount.SQL.Add(')');
  QSourceCount.SQL.Add('   and envio_ge = 0');
  QSourceCount.Prepare;

  QSourceMarcar.SQL.Clear;
  QSourceMarcar.SQL.Add('update frf_gastos_entregas ');
  QSourceMarcar.SQL.Add('set envio_ge = 1 ');
  QSourceMarcar.SQL.Add('where codigo_ge = :codigo_ge ');
  QSourceMarcar.SQL.Add('and linea_ge = :linea_ge ');
  QSourceMarcar.Prepare;
end;

procedure ParametrosQuerys( const AEmpresa, ACentro: string;
                            const AInicio, AFin: TDateTime;
                            const ACodigo: string );
begin
  QSourceCab.ParamByName('empresa').AsString:= AEmpresa;
  QSourceCount.ParamByName('empresa').AsString:= AEmpresa;
  QSourceCab.ParamByName('centro').AsString:= ACentro;
  QSourceCount.ParamByName('centro').AsString:= ACentro;
  QSourceCab.ParamByName('ini').AsDateTime:= AInicio;
  QSourceCab.ParamByName('fin').AsDateTime:= AFin;
  QSourceCount.ParamByName('ini').AsDateTime:= AInicio;
  QSourceCount.ParamByName('fin').AsDateTime:= AFin;
  if ACodigo <> '' then
  begin
    QSourceCab.ParamByName('codigo').AsString:= ACodigo;
    QSourceCount.ParamByName('codigo').AsString:= ACodigo;
  end;
end;

procedure AbrirQuerys;
begin
  DMBaseDatos.BDCentral.Open;
  QSourceCab.Open;
  QTargetCab.Open;
  QTargetCount.Open;
  QTargetLinea.Open;
end;

procedure CerrarQuerys;
begin
  QSourceCab.Close;
  QTargetCab.Close;
  QTargetCount.Close;
  QTargetLinea.Close;
  DMBaseDatos.BDCentral.Close;
end;


procedure MarcarComoEnviada;
begin
  with QSourceMarcar do
  begin
    ParamByName('codigo_ge').AsString:= QSourceCab.FieldByName('codigo_ge').AsString;
    ParamByName('linea_ge').AsInteger:= QSourceCab.FieldByName('linea_ge').AsInteger;
    ExecSQL;
  end;
end;

procedure PasarGasto;
var
  i: integer;
  campo: TField;
begin
  //PASAR Gasto
  QTargetCab.Insert;

  i:= 0;
  while i < QTargetCab.Fields.Count do
  begin
    campo:= QSourceCab.FindField(QTargetCab.Fields[i].FieldName);
    if campo <> nil then
    begin
      QTargetCab.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  QTargetCab.FieldByName('linea_ge').AsInteger:=
    QTargetLinea.FieldByName('linea').AsInteger + 1;
  QTargetCab.FieldByName('envio_ge').AsInteger:= 1;

  try
    QTargetCab.Post;
  except
    QTargetCab.Cancel;
    Raise;
  end;

  //Marcar como enviada
  MarcarComoEnviada;
end;

procedure ModificarGasto;
var
  i: integer;
  campo: TField;
begin
  //modificar gasto
  QTargetCab.Edit;

  i:= 0;
  while i < QTargetCab.Fields.Count do
  begin
    campo:= QSourceCab.FindField(QTargetCab.Fields[i].FieldName);
    if campo <> nil then
    begin
      QTargetCab.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;

  QTargetCab.FieldByName('linea_ge').AsInteger:=
    QSourceCab.FieldByName('linea_ge').AsInteger;
  QTargetCab.FieldByName('envio_ge').AsInteger:= 1;

  try
    QTargetCab.Post;
  except
    QTargetCab.Cancel;
    Raise;
  end;

  //Marcar como enviada
  MarcarComoEnviada;
end;

procedure PasaMDetalle( var AMsg: string );
begin
  (*REVISAR*)
  if not DMBaseDatos.BDCentral.InTransaction then
  begin
    DMBaseDatos.BDCentral.StartTransaction;
    try
      if QTargetCab.IsEmpty then
      begin
        PasarGasto;
        AMsg:= AMsg + ' OK --> GASTO NUEVO ';
      end
      else
      begin
        if ( QTargetCab.FieldByName('envio_ge').AsInteger = 1 ) and
           ( QTargetCount.FieldByName('registros').AsInteger = 1 ) then
        begin
          ModificarGasto;
          AMsg:= AMsg + ' OK --> GASTO MODIFICADO';
        end
        else
        begin
          if ( QTargetCount.FieldByName('registros').AsInteger > 1 ) then
          begin
            raise Exception.Create('EN DESTINO MAS DE UN GASTO CON EL MISMO CÓDIGO');
          end
          else
          begin
            raise Exception.Create('GASTO YA GRABADO Y MODIFICADO EN DESTINO');
          end;
        end;
      end;

      DMBaseDatos.BDCentral.Commit;
    except
      DMBaseDatos.BDCentral.Rollback;
      raise;
    end;
  end;
end;

function PasarMDetalles( var AMsg: String; var APasados: integer ): Integer;
begin
  QSourceCab.First;
  InicializarBarraProgreso( QSourceCount );
  result:= 0;
  APasados:= 0;
  AMsg:= '';

  while not QSourceCab.Eof do
  begin
    try
      result:= result + 1;
      AMsg:= AMsg +  QSourceCab.FieldByName('codigo_ge').AsString;
      try
        PasaMDetalle( AMsg );
      finally
        IncBarraProgreso;
      end;
      APasados:= APasados + 1;
    except
      on e: exception do
      begin
        AMsg:= AMsg + ' ERROR -->  ' + e.Message;
      end;
    end;
     AMsg:= AMsg + #13 + #10;
    QSourceCab.Next;
  end;
end;

function SincronizarGastosEntregas( const AEmpresa: string; const ATipoCentro: integer; const ACentro: string;
                              const ATipoFecha: integer; const AInicio, AFin: TDateTime;
                              const ATipoCodigo: integer; const ACodigo: String;
                              const AEntregaFinalizadas: boolean; var ABarraProgeso: TProgressBar;
                              var AMsg: String; var APasados: integer ): integer;
begin
  CrearQuerys;
  try
    AsignarBarraProgreso( ABarraProgeso );
    if ACodigo <> '' then
      PreparaQuerysEntregas( ATipoCentro, ATipoFecha, ATipoCodigo, AEntregaFinalizadas )
    else
      PreparaQuerysEntregas( ATipoCentro, ATipoFecha, -1, AEntregaFinalizadas );
    ParametrosQuerys( AEmpresa, ACentro, AInicio, AFin, ACodigo );
    AbrirQuerys;
    result:= PasarMDetalles( AMsg, APasados );
  finally
    LiberarBarraProgreso;
    CerrarQuerys;
    DestruirQuerys;
  end;
end;

end.


