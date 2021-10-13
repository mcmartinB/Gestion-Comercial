unit SincroTransitosUNT;

(*CODIGO*)
(*Indica donde insertar codigo*)
(*REVISAR*)
(*Codigo que funciona pero deberias cambiar*)
interface

uses SysUtils, DB, DBTables, SincroVarUNT;

function  SincronizarTransitos( const AEmpresa: string;  const ADocumento: Integer;
                                const AInicio, AFin: TDateTime ): RSincroResumen;
procedure CrearQuerys;
procedure DestruirQuerys;
procedure PreparaQuerysTransitos( const AEmpresa: string; const ADocumento: Integer );
procedure ParametrosQuerys( const AEmpresa: string; const ADocumento: Integer; const AInicio, AFin: TDateTime );
procedure AbrirQuerys;
procedure CerrarQuerys;
function  PasarMDetalles: RSincroResumen;
procedure PasaMDetalle;

implementation

uses
  UDMBaseDatos, UDMConfig;

var
  QSourceCab: TQuery;
  QSourceCount: TQuery;
  DSCab: TDataSource;
  QSourceLinDetalle: TQuery;
  QSourceLinPaletCab: TQuery;
  QSourceLinPaletDet: TQuery;
  QSourceLinPaletPB: TQuery;
  QTargetCab: TQuery;
  QTargetLinDetalle: TQuery;
  QTargetLinPaletCab: TQuery;
  QTargetLinPaletDet: TQuery;
  QTargetBorrarLinPaletDet: TQuery;
  QTargetLinPaletPB: TQuery;
  QUpadatePaletCab: TQuery;
  QOrdenCarga: TQuery;
  iOrden: integer;

procedure CrearQuerys;
begin
  QSourceCab:= TQuery.Create( nil );
  QSourceCab.DatabaseName:= 'BDProyecto';
  QSourceCab.RequestLive:= True;
  QSourceCount:= TQuery.Create( nil );
  QSourceCount.DatabaseName:= 'BDProyecto';

  DSCab:= TDataSource.Create( nil );
  DSCab.DataSet:= QSourceCab;

  QTargetCab:= TQuery.Create( nil );
  QTargetCab.DatabaseName:= 'BDCentral';
  QTargetCab.RequestLive:= True;

  ///////////////////////////////////////////////////

  QSourceLinDetalle:= TQuery.Create( nil );
  QSourceLinDetalle.DatabaseName:= 'BDProyecto';
  QSourceLinDetalle.DataSource:= DSCab;

  QTargetLinDetalle:= TQuery.Create( nil );
  QTargetLinDetalle.DatabaseName:= 'BDCentral';
  QTargetLinDetalle.RequestLive:= True;

  ///////////////////////////////////////////////////

  QSourceLinPaletCab:= TQuery.Create( nil );
  QSourceLinPaletCab.DatabaseName:= 'BDProyecto';

  QTargetLinPaletCab:= TQuery.Create( nil );
  QTargetLinPaletCab.DatabaseName:= 'BDCentral';
  QTargetLinPaletCab.RequestLive:= True;

  ///////////////////////////////////////////////////

  QSourceLinPaletDet:= TQuery.Create( nil );
  QSourceLinPaletDet.DatabaseName:= 'BDProyecto';

  QTargetLinPaletDet:= TQuery.Create( nil );
  QTargetLinPaletDet.DatabaseName:= 'BDCentral';
  QTargetLinPaletDet.RequestLive:= True;

  QTargetBorrarLinPaletDet:= TQuery.Create( nil );
  QTargetBorrarLinPaletDet.DatabaseName:= 'BDCentral';

  ///////////////////////////////////////////////////

  QSourceLinPaletPB:= TQuery.Create( nil );
  QSourceLinPaletPB.DatabaseName:= 'BDProyecto';

  QTargetLinPaletPB:= TQuery.Create( nil );
  QTargetLinPaletPB.DatabaseName:= 'BDCentral';
  QTargetLinPaletPB.RequestLive:= True;

  ///////////////////////////////////////////////////

  QUpadatePaletCab:= TQuery.Create( nil );
  QUpadatePaletCab.DataSource:= DSCab;
  QUpadatePaletCab.DatabaseName:= 'BDProyecto';

  ///////////////////////////////////////////////////

  QOrdenCarga:= TQuery.Create( nil );
  QOrdenCarga.DatabaseName:= 'BDProyecto';
  QOrdenCarga.DataSource:= DSCab;

  ///////////////////////////////////////////////////
end;

procedure DestruirQuerys;
begin
  FreeAndNil( QSourceLinDetalle );
  FreeAndNil( QSourceLinPaletDet );
  FreeAndNil( QSourceLinPaletCab );
  FreeAndNil( DSCab );
  FreeAndNil( QSourceCab );
  FreeAndNil( QSourceCount );
  FreeAndNil( QTargetLinDetalle );
  FreeAndNil( QTargetLinPaletDet );
  FreeAndNil( QTargetBorrarLinPaletDet );
  FreeAndNil( QTargetLinPaletCab );
  FreeAndNil( QTargetCab );
  FreeAndNil( QUpadatePaletCab );
  FreeAndNil( QOrdenCarga );

  FreeAndNil( QSourceLinPaletPB );
  FreeAndNil( QTargetLinPaletPB );
end;

procedure PreparaQuerysTransitos( const AEmpresa: string; const ADocumento: Integer );
begin
  QUpadatePaletCab.SQL.Clear;
  QUpadatePaletCab.SQL.Add(' update rf_palet_pc_cab set ');
  QUpadatePaletCab.SQL.Add('   empresa_cab = :empresa, ');
  QUpadatePaletCab.SQL.Add('   centro_cab = :centro, ');
  QUpadatePaletCab.SQL.Add('   ref_transito = :referencia, ');
  QUpadatePaletCab.SQL.Add('   fecha_transito = :fecha ');
  QUpadatePaletCab.SQL.Add(' where orden_carga_cab = :orden ');

  QOrdenCarga.SQL.Add(' select distinct orden_occ ');
  QOrdenCarga.SQL.Add(' from frf_orden_carga_c ');
  QOrdenCarga.SQL.Add(' where empresa_occ = :empresa ');
  QOrdenCarga.SQL.Add(' and centro_salida_occ = :centro ');
  QOrdenCarga.SQL.Add(' and fecha_occ = :fecha ');
  QOrdenCarga.SQL.Add(' and n_albaran_occ = :referencia ');

  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_transitos_c');
  QTargetCab.SQL.Add('where empresa_tc = ''###'' ');

  QTargetLinDetalle.SQL.Clear;
  QTargetLinDetalle.SQL.Add('select * ');
  QTargetLinDetalle.SQL.Add('from frf_transitos_l');
  QTargetLinDetalle.SQL.Add('where empresa_tl = ''###'' ');

  QTargetLinPaletCab.SQL.Clear;
  QTargetLinPaletCab.SQL.Add('select * ');
  QTargetLinPaletCab.SQL.Add('from rf_palet_pc_cab');
  QTargetLinPaletCab.SQL.Add('where ean128_cab = :ean128_cab ');

  QTargetBorrarLinPaletDet.SQL.Clear;
  QTargetBorrarLinPaletDet.SQL.Add('delete ');
  QTargetBorrarLinPaletDet.SQL.Add('from rf_palet_pc_det');
  QTargetBorrarLinPaletDet.SQL.Add('where ean128_det = :ean128_det ');

  QTargetLinPaletDet.SQL.Clear;
  QTargetLinPaletDet.SQL.Add('select * ');
  QTargetLinPaletDet.SQL.Add('from rf_palet_pc_det');
  QTargetLinPaletDet.SQL.Add('where ean128_det = :ean128_det ');

  QTargetLinPaletPB.SQL.Clear;
  QTargetLinPaletPB.SQL.Add('select * ');
  QTargetLinPaletPB.SQL.Add('from rf_palet_pb');
  QTargetLinPaletPB.SQL.Add('where sscc = :sscc ');


  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_transitos_c');
  if AEmpresa <> '' then
  begin
    QSourceCab.SQL.Add('where empresa_tc = :empresa');
    QSourceCab.SQL.Add('  and fecha_tc between :ini and :fin');
  end
  else
  begin
    QSourceCab.SQL.Add('where fecha_tc between :ini and :fin');
  end;
  if ADocumento <> -1 then
  begin
    QSourceCab.SQL.Add('and referencia_tc = :transito');
  end;

  QSourceCount.SQL.Clear;
  QSourceCount.SQL.Add('select count(*) ');
  QSourceCount.SQL.Add('from frf_transitos_c');
  if AEmpresa <> '' then
  begin
    QSourceCount.SQL.Add('where empresa_tc = :empresa');
    QSourceCount.SQL.Add('  and fecha_tc between :ini and :fin');
  end
  else
  begin
    QSourceCount.SQL.Add('where fecha_tc between :ini and :fin');
  end;
  if ADocumento <> -1 then
  begin
    QSourceCount.SQL.Add('and referencia_tc = :transito');
  end;

  QSourceLinDetalle.SQL.Clear;
  QSourceLinDetalle.SQL.Add('select * ');
  QSourceLinDetalle.SQL.Add('from frf_transitos_l');
  QSourceLinDetalle.SQL.Add('where empresa_tl = :empresa_tc ');
  QSourceLinDetalle.SQL.Add('  and centro_tl = :centro_tc ');
  QSourceLinDetalle.SQL.Add('  and fecha_tl = :fecha_tc ');
  QSourceLinDetalle.SQL.Add('  and referencia_tl = :referencia_tc ');

  QSourceLinPaletCab.SQL.Clear;
  QSourceLinPaletCab.SQL.Add(' select *  ');
  QSourceLinPaletCab.SQL.Add(' from rf_palet_pc_cab ');
  QSourceLinPaletCab.SQL.Add(' where orden_carga_cab = :orden ');

  QSourceLinPaletDet.SQL.Clear;
  QSourceLinPaletDet.SQL.Add(' select rf_palet_pc_det.* ');
  QSourceLinPaletDet.SQL.Add(' from rf_palet_pc_cab, rf_palet_pc_det ');
  QSourceLinPaletDet.SQL.Add(' where orden_carga_cab = :orden ');
  QSourceLinPaletDet.SQL.Add(' and ean128_det = ean128_cab ');

  QSourceLinPaletPB.SQL.Clear;
  QSourceLinPaletPB.SQL.Add(' select * ');
  QSourceLinPaletPB.SQL.Add(' from rf_palet_pb ');
  QSourceLinPaletPB.SQL.Add(' where orden_carga  = :orden');
end;

procedure ParametrosQuerys( const AEmpresa: string; const ADocumento: Integer; const AInicio, AFin: TDateTime );
begin
  if Trim( AEmpresa ) <> '' then
  begin
    QSourceCab.ParamByName('empresa').AsString:= AEmpresa;
    QSourceCount.ParamByName('empresa').AsString:= AEmpresa;
  end;
  if ADocumento <> -1 then
  begin
    QSourceCab.ParamByName('transito').AsInteger:= ADocumento;
    QSourceCount.ParamByName('transito').AsInteger:= ADocumento;
  end;
  QSourceCab.ParamByName('ini').AsDateTime:= AInicio;
  QSourceCab.ParamByName('fin').AsDateTime:= AFin;
  QSourceCount.ParamByName('ini').AsDateTime:= AInicio;
  QSourceCount.ParamByName('fin').AsDateTime:= AFin;
end;

procedure AbrirQuerys;
begin
  DMBaseDatos.BDCentral.Open;
  QSourceCab.Open;
  QSourceLinDetalle.Open;

  QTargetCab.Open;
  QTargetLinDetalle.Open;
end;

procedure CerrarQuerys;
begin
  QSourceLinDetalle.Close;
  QSourceCab.Close;
  QTargetLinDetalle.Close;
  QTargetCab.Close;
  DMBaseDatos.BDCentral.Close;
end;

procedure UpdatePaletCab;
begin
  QUpadatePaletCab.ParamByName('empresa').AsString:= QSourceCab.FieldByName('empresa_tc').AsString;
  QUpadatePaletCab.ParamByName('centro').AsString:= QSourceCab.FieldByName('centro_tc').AsString;
  QUpadatePaletCab.ParamByName('referencia').AsInteger:= QSourceCab.FieldByName('referencia_tc').AsInteger;
  QUpadatePaletCab.ParamByName('fecha').AsDateTime:= QSourceCab.FieldByName('fecha_tc').AsDateTime;
  QUpadatePaletCab.ParamByName('orden').AsInteger:= iOrden;
  QUpadatePaletCab.ExecSQL;
end;

procedure PasaPaletCab;
var
  i: integer;
  //sAux: string;
  campo: TField;
begin
  //Ahora mover datos
  QTargetLinPaletCab.ParamByName('ean128_cab').AsString:= QSourceLinPaletCab.FieldByName('ean128_cab').AsString;
  QTargetLinPaletCab.Open;
  if not QTargetLinPaletCab.Isempty then
    QTargetLinPaletCab.Edit
  else
    QTargetLinPaletCab.Insert;

  i:= 0;
  while i < QTargetLinPaletCab.Fields.Count do
  begin
    campo:= QSourceLinPaletCab.FindField(QTargetLinPaletCab.Fields[i].FieldName);
    if campo <> nil then
    begin
      QTargetLinPaletCab.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  QTargetLinPaletCab.FieldByName('empresa_cab').AsString:= QSourceCab.FieldByName('empresa_tc').AsString;
  QTargetLinPaletCab.FieldByName('centro_cab').AsString:= QSourceCab.FieldByName('centro_tc').AsString;
  QTargetLinPaletCab.FieldByName('ref_transito').AsInteger:= QSourceCab.FieldByName('referencia_tc').AsInteger;
  QTargetLinPaletCab.FieldByName('fecha_transito').AsDateTime:= QSourceCab.FieldByName('fecha_tc').AsDateTime;
  try
    //try
      QTargetLinPaletCab.Post;
    //except
    //  QTargetLinPaletCab.Cancel;
    //  Raise;
    //end;
  finally
    QTargetLinPaletCab.Close;
  end;
end;


procedure BorrarDet;
begin
  QTargetBorrarLinPaletDet.ParamByName('ean128_det').AsString:= QSourceLinPaletDet.FieldByName('ean128_det').AsString;
  QTargetBorrarLinPaletDet.ExecSQL;
end;

procedure PasaPaletDet;
var
  i: integer;
  campo: TField;
begin
  //Ahora mover datos
  QTargetLinPaletDet.ParamByName('ean128_det').AsString:= QSourceLinPaletDet.FieldByName('ean128_det').AsString;
  QTargetLinPaletDet.Open;
  if not QTargetLinPaletDet.Isempty then
    QTargetLinPaletDet.Edit
  else
    QTargetLinPaletDet.Insert;

  i:= 0;
  while i < QTargetLinPaletDet.Fields.Count do
  begin
    campo:= QSourceLinPaletDet.FindField(QTargetLinPaletDet.Fields[i].FieldName);
    if campo <> nil then
    begin
      QTargetLinPaletDet.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  try
    //try
      QTargetLinPaletDet.Post;
    //except
    //  QTargetLinPaletDet.Cancel;
    //  Raise;
    //end;
  finally
    QTargetLinPaletDet.Close;
  end;
end;

procedure PasaPaletPB;
var
  i: integer;
  campo: TField;
begin
  //Ahora mover datos
  QTargetLinPaletPB.ParamByName('sscc').AsString:= QSourceLinPaletPB.FieldByName('sscc').AsString;
  QTargetLinPaletPB.Open;
  if not QTargetLinPaletPB.Isempty then
    QTargetLinPaletPB.Edit
  else
    QTargetLinPaletPB.Insert;

  i:= 0;
  while i < QTargetLinPaletPB.Fields.Count do
  begin
    campo:= QSourceLinPaletPB.FindField(QTargetLinPaletPB.Fields[i].FieldName);
    if campo <> nil then
    begin
      QTargetLinPaletPB.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;
  try
    //try
      QTargetLinPaletPB.Post;
    //except
    //  QTargetLinPaletPB.Cancel;
    //  Raise;
    //end;
  finally
    QTargetLinPaletPB.Close;
  end;
end;

function OrdenCarga: integer;
begin
  QOrdenCarga.ParamByName('empresa').AsString:= QSourceCab.FieldByName('empresa_tc').AsString;
  QOrdenCarga.ParamByName('centro').AsString:= QSourceCab.FieldByName('centro_tc').AsString;
  QOrdenCarga.ParamByName('referencia').AsInteger:= QSourceCab.FieldByName('referencia_tc').AsInteger;
  QOrdenCarga.ParamByName('fecha').AsDateTime:= QSourceCab.FieldByName('fecha_tc').AsDateTime;
  QOrdenCarga.Open;
  result:= QOrdenCarga.Fields[0].AsInteger;
  QOrdenCarga.Close;
end;

procedure PasarPaletsCab;
begin
  if QSourceLinPaletCab.Active then
  begin
    QSourceLinPaletCab.First;
    //Rellenar campos que faltan
    UpdatePaletCab;
    while not QSourceLinPaletCab.Eof do
    begin
      PasaPaletCab;
      QSourceLinPaletCab.Next;
    end;
  end;
end;

procedure PasarPaletsDet;
begin
  if QSourceLinPaletDet.Active then
  begin
    QSourceLinPaletDet.First;
    //Rellenar campos que faltan
    while not QSourceLinPaletDet.Eof do
    begin
      BorrarDet;
      PasaPaletDet;
      QSourceLinPaletDet.Next;
    end;
  end;
end;

procedure PasarPaletsPB;
begin
  if QSourceLinPaletPB.Active then
  begin
    QSourceLinPaletPB.First;
    //Rellenar campos que faltan
    while not QSourceLinPaletPB.Eof do
    begin
      PasaPaletPB;
      QSourceLinPaletPB.Next;
    end;
  end;
end;

procedure PasaMaestro( const AFuente, ADestino: TDataSet; const AIgnorarError: boolean = False );
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

  ADestino.FieldByname('status_tc').AsInteger:= 2;
  try
    ADestino.Post;
  except
    ADestino.Cancel;
    if not AIgnorarError then
      Raise;
  end;

  AFuente.Edit;
  AFuente.FieldByname('status_tc').AsInteger:= 1;
  AFuente.Post;
end;

procedure PasaMDetalle;
var QAux: TQuery;
begin
   QAux := TQuery.Create(nil);
  (*REVISAR*)
  if not DMBaseDatos.BDCentral.InTransaction then
  begin
    DMBaseDatos.BDCentral.StartTransaction;
    try
      //PASAR MAESTRO
      PasaMaestro( QSourceCab, QTargetCab );
      //PASAR DETALLES
      PasarRegistros( QSourceLinDetalle, QTargetLinDetalle, QAux, QAux);
      //PALETS CONFECCIONADOS
      PasarPaletsCab;
      PasarPaletsDet;
      //PasarRegistros( QSourceLinPaletDet, QTargetLinPaletDet);
      //PALETS PROVEEDOR
      PasarPaletsPB;
      //PasarRegistros( QSourceLinPaletPB, QTargetLinPaletPB);

      DMBaseDatos.BDCentral.Commit;
    except
      DMBaseDatos.BDCentral.Rollback;
      raise;
    end;
  end;
  FreeAndNil( QAux );
end;

procedure CerrarPalets;
begin
  QSourceLinPaletCab.Close;
  QSourceLinPaletDet.Close;
  QSourceLinPaletPB.Close;
end;

procedure AbrirPalets;
begin
  QSourceLinPaletCab.ParamByName('orden').AsInteger:= iOrden;
  QSourceLinPaletCab.Open;

  QSourceLinPaletDet.ParamByName('orden').AsInteger:= iOrden;
  QSourceLinPaletDet.Open;

  if not DMConfig.EsLaFont  then
  begin
    QSourceLinPaletPB.ParamByName('orden').AsInteger:= iOrden;
    QSourceLinPaletPB.Open;
  end;
end;

function PasarMDetalles: RSincroResumen;
var
  sMsg: String;
begin
  QSourceCab.First;
  InicializarBarraProgreso( QSourceCount );

  while not QSourceCab.Eof do
  begin
    iOrden:= OrdenCarga;
    if (QSourceCab.FieldByName('n_orden_tc').AsString = '' ) and( iOrden <> 0 ) then
    begin
      QSourceCab.Edit;
      QSourceCab.FieldByName('n_orden_tc').AsInteger:= iOrden;
      QSourceCab.Post;
    end;

    CerrarPalets;
    AbrirPalets;
    try
      result.registros:= result.registros + 1;
      sMsg:= DescripcionRegistro( QSourceCab, 6 );
      try
        PasaMDetalle;
      finally
        IncBarraProgreso;
      end;
      result.pasados:= result.pasados + 1;
      sMsg:= ' ---> ' + IntToStr( result.pasados ) + ') ' + #13 + #10 + sMsg;
      result.msgPasados.Add( sMsg );
    except
      on e: edbengineerror do
      begin
        if e.Errors[0].ErrorCode = 13059 then
        begin
          sMsg:= ' ---> ' + IntToStr( result.duplicados ) + ') ' + #13 + #10 + sMsg;
          result.msgDuplicados.Add( sMsg );
          result.duplicados:= result.duplicados + 1;
        end
        else
        begin
          sMsg:= sMsg + #13 + #10 + '[' + IntToStr( e.Errors[0].ErrorCode ) + '] ' + e.Message;
          sMsg:= ' ---> ' + IntToStr( result.erroneos ) + ') ' + #13 + #10 + sMsg;
          result.msgErrores.Add( sMsg );
          result.erroneos:= result.erroneos + 1;
        end;
      end;
      on e: exception do
      begin
        sMsg:= sMsg + #13 + #10 + e.Message;
        sMsg:= ' ---> ' + IntToStr( result.erroneos ) + ') ' + #13 + #10 + sMsg;
        result.msgErrores.Add( sMsg );
        result.erroneos:= result.erroneos + 1;
      end;
    end;
    QSourceCab.Next;
  end;
  CerrarPalets;
end;

function  SincronizarTransitos( const AEmpresa: string; const ADocumento: Integer;
                                const AInicio, AFin: TDateTime ): RSincroResumen;
begin
  CrearQuerys;
  try
    PreparaQuerysTransitos( AEmpresa, ADocumento );
    ParametrosQuerys( AEmpresa, ADocumento, AInicio, AFin );
    AbrirQuerys;
    result:= PasarMDetalles;
  finally
    CerrarQuerys;
    DestruirQuerys;
  end;
end;

end.


