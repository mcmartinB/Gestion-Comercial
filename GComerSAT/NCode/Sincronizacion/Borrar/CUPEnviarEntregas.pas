(*CODIGO*)
(*Indica donde insertar codigo*)
(*REVISAR*)
(*Codigo que funciona pero deberias cambiar*)
unit CUPEnviarEntregas;

interface

uses SysUtils, DB, DBTables, UDMConfig, ComCtrls, Forms, Classes;

function SincronizarEntregas( const AEmpresa: string; const ATipoCentro: integer; const ACentro: string;
                              const ATipoFecha: integer; const AInicio, AFin: TDateTime;
                              const ATipoCodigo: integer; const ACodigo: String;
                              const AEntregaFinalizadas: boolean; var ABarraProgeso: TProgressBar;
                              var AMsg: String; var APasados: integer ): integer;
implementation

uses
  UDMBaseDatos, CVariables;

var
  QSourceCab: TQuery;
  QSourceCount: TQuery;
  DSCab: TDataSource;
  QSourceDet: TQuery;
  QSourceEnt: TQuery;

  QTargetCab: TQuery;
  QTargetDet: TQuery;
  QTargetEnt: TQuery;

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
  QSourceCab.RequestLive:= True;

  QSourceCount:= TQuery.Create( nil );
  QSourceCount.DatabaseName:= 'BDProyecto';

  DSCab:= TDataSource.Create( nil );
  DSCab.DataSet:= QSourceCab;

  QSourceDet:= TQuery.Create( nil );
  QSourceDet.DatabaseName:= 'BDProyecto';
  QSourceDet.DataSource:= DSCab;

  QSourceEnt:= TQuery.Create( nil );
  QSourceEnt.DatabaseName:= 'BDProyecto';
  QSourceEnt.DataSource:= DSCab;

  QTargetCab:= TQuery.Create( nil );
  QTargetCab.DatabaseName:= 'BDCentral';
  QTargetCab.DataSource:= DSCab;
  QTargetCab.RequestLive:= True;

  QTargetDet:= TQuery.Create( nil );
  QTargetDet.DatabaseName:= 'BDCentral';
  QTargetDet.DataSource:= DSCab;
  QTargetDet.RequestLive:= True;

  QTargetEnt:= TQuery.Create( nil );
  QTargetEnt.DatabaseName:= 'BDCentral';
  QTargetEnt.DataSource:= DSCab;
  QTargetEnt.RequestLive:= True;
end;

procedure DestruirQuerys;
begin
  FreeAndNil( QTargetDet );
  FreeAndNil( QTargetEnt );
  FreeAndNil( QTargetCab );
  FreeAndNil( QSourceDet );
  FreeAndNil( QSourceEnt );
  FreeAndNil( QSourceCount );
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
  QTargetCab.SQL.Add('from frf_entregas_c');
  QTargetCab.SQL.Add('where codigo_ec = :codigo_ec ');
  QTargetCab.Prepare;

  QTargetDet.SQL.Clear;
  QTargetDet.SQL.Add('select * ');
  QTargetDet.SQL.Add('from frf_entregas_l');
  QTargetDet.SQL.Add('where codigo_el = :codigo_ec ');
  QTargetDet.Prepare;

  QTargetEnt.SQL.Clear;
  QTargetEnt.SQL.Add('select * ');
  QTargetEnt.SQL.Add('from frf_entregas_rel');
  QTargetEnt.SQL.Add('where codigo_er = :codigo_ec ');
  QTargetEnt.Prepare;

  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_entregas_c');

  QSourceCab.SQL.Add('where empresa_ec = :empresa');
  case ATipoCentro of
    0: QSourceCab.SQL.Add('  and centro_origen_ec = :centro');
    1: QSourceCab.SQL.Add('  and centro_llegada_ec = :centro');
  end;
  case ATipoFecha of
    0: QSourceCab.SQL.Add('  and fecha_origen_ec between :ini and :fin');
    1: QSourceCab.SQL.Add('  and fecha_llegada_ec between :ini and :fin');
  end;
  case ATipoCodigo of
    0: QSourceCab.SQL.Add('  and codigo_ec = :codigo');
    1: QSourceCab.SQL.Add('  and albaran_ec = :codigo');
    2: QSourceCab.SQL.Add('  and adjudicacion_ec = :codigo');
  end;
  if AEntregaFinalizadas then
  begin
    QSourceCab.SQL.Add('  and status_ec <> 0');
  end;
  QSourceCab.SQL.Add('  and envio_ec = 0');
  QSourceCab.Prepare;

  QSourceCount.SQL.Clear;
  QSourceCount.SQL.Add('select Count(*) ');
  QSourceCount.SQL.Add('from frf_entregas_c');
  QSourceCount.SQL.Add('where empresa_ec = :empresa');
  case ATipoCentro of
    0: QSourceCount.SQL.Add('  and centro_origen_ec = :centro');
    1: QSourceCount.SQL.Add('  and centro_llegada_ec = :centro');
  end;
  case ATipoFecha of
    0: QSourceCount.SQL.Add('  and fecha_origen_ec between :ini and :fin');
    1: QSourceCount.SQL.Add('  and fecha_llegada_ec between :ini and :fin');
  end;
  case ATipoCodigo of
    0: QSourceCount.SQL.Add('  and codigo_ec = :codigo');
    1: QSourceCount.SQL.Add('  and albaran_ec = :codigo');
    2: QSourceCount.SQL.Add('  and adjudicacion_ec = :codigo');
  end;
  if AEntregaFinalizadas then
  begin
    QSourceCount.SQL.Add('  and status_ec <> 0');
  end;
  QSourceCount.SQL.Add('  and envio_ec = 0');
  QSourceCount.Prepare;

  QSourceDet.SQL.Clear;
  QSourceDet.SQL.Add('select * ');
  QSourceDet.SQL.Add('from frf_entregas_l');
  QSourceDet.SQL.Add('where codigo_el = :codigo_ec ');
  QSourceDet.Prepare;

  QSourceEnt.SQL.Clear;
  QSourceEnt.SQL.Add('select * ');
  QSourceEnt.SQL.Add('from frf_entregas_rel');
  QSourceEnt.SQL.Add('where codigo_er = :codigo_ec ');
  QSourceEnt.Prepare;
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
  QSourceDet.Open;
  QSourceEnt.Open;
  QTargetCab.Open;
  QTargetDet.Open;
  QTargetEnt.Open;
end;

procedure CerrarQuerys;
begin
  QSourceDet.Close;
  QSourceEnt.Close;
  QSourceCab.Close;
  QTargetDet.Close;
  QTargetEnt.Close;
  QTargetCab.Close;
  DMBaseDatos.BDCentral.Close;
end;

procedure PasaRegistro( const AFuente, ADestino: TDataSet; const AIgnorarError: boolean = False );
var
  i: integer;
  //sAux: string;
  campo: TField;
begin
  ADestino.Insert;
  i:= 0;
  while i < ADestino.Fields.Count do
  begin
    campo:= AFuente.FindField(ADestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      ADestino.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  try
    ADestino.Post;
  except
    ADestino.Cancel;
    if not AIgnorarError then
      Raise;
  end;
end;

procedure ModificaRegistro( const AFuente, ADestino: TDataSet; const AIgnorarError: boolean = False );
var
  i: integer;
  //sAux: string;
  campo: TField;
begin
  ADestino.Edit;
  i:= 0;
  while i < ADestino.Fields.Count do
  begin
    campo:= AFuente.FindField(ADestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      ADestino.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  try
    ADestino.Post;
  except
    ADestino.Cancel;
    if not AIgnorarError then
      Raise;
  end;
end;

procedure PasarRegistros( const AFuente, ADestino: TDataSet; const AIgnorarError: boolean = False );
begin
  if AFuente.Active then
  begin
    AFuente.First;
    while not AFuente.Eof do
    begin
      PasaRegistro( AFuente, ADestino, AIgnorarError );
      AFuente.Next;
    end;
  end;
end;

procedure PasarEntrega;
begin
  //PASAR MAESTRO
  PasaRegistro( QSourceCab, QTargetCab );

  //PASAR DETALLES
  PasarRegistros( QSourceDet, QTargetDet);
  PasarRegistros( QSourceEnt, QTargetEnt);
  (*Radiofrecuencia*)
  (*
  PasarRegistros( QSourceRadio, QTargetRadio);
  *)

  //Marcar como enviada
  QSourceCab.Edit;
  QSourceCab.FieldByName('envio_ec').AsInteger:= 1;
  QSourceCab.Post;
end;

procedure ModificarEntrega;
begin
  while not QTargetDet.Eof do
  begin
    QTargetDet.Delete;
  end;
  PasarRegistros( QSourceDet, QTargetDet);

  while not QTargetEnt.Eof do
  begin
    QTargetEnt.Delete;
  end;
  PasarRegistros( QSourceEnt, QTargetEnt);

  //Campos modificados de la cabecera
  ModificaRegistro( QSourceCab, QTargetCab );
(*
  QTargetCab.Edit;
  QTargetCab.FieldByName('albaran_ec').AsString:= QSourceCab.FieldByName('albaran_ec').AsString;
  QTargetCab.FieldByName('fecha_llegada_ec').AsDateTime:= QSourceCab.FieldByName('fecha_llegada_ec').AsDateTime;
  QTargetCab.FieldByName('vehiculo_ec').AsString:= QSourceCab.FieldByName('vehiculo_ec').AsString;
  QTargetCab.FieldByName('peso_entrada_ec').AsFloat:= QSourceCab.FieldByName('peso_entrada_ec').AsFloat;
  QTargetCab.FieldByName('peso_salida_ec').AsFloat:= QSourceCab.FieldByName('peso_salida_ec').AsFloat;
  QTargetCab.FieldByName('status_ec').AsInteger:= QSourceCab.FieldByName('status_ec').AsInteger;
  QTargetCab.FieldByName('envio_ec').AsInteger:= QSourceCab.FieldByName('envio_ec').AsInteger;
  QTargetCab.Post;
*)
  //Marcar como enviada
  QSourceCab.Edit;
  QSourceCab.FieldByName('envio_ec').AsInteger:= 1;
  QSourceCab.Post;
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
        PasarEntrega;
        AMsg:= AMsg + ' OK --> NUEVA ENTREGA ';
      end
      else
      begin
        ModificarEntrega;
        AMsg:= AMsg + ' OK --> ENTREGA MODIFICADA';
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
      AMsg:= AMsg +  QSourceCab.FieldByName('codigo_ec').AsString;
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

function SincronizarEntregas( const AEmpresa: string; const ATipoCentro: integer; const ACentro: string;
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


