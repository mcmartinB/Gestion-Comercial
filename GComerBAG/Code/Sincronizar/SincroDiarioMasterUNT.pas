unit SincroDiarioMasterUNT;

interface

uses SysUtils, DB, DBTables, SincroVarUNT;

function  SincronizarRegistros( const AEmpresa, ACentro, AProducto: string; const AInicio, AFin: TDateTime;
                                const ACodigo,ATitulo: String; const ATipo: integer): RSincroResumen;
function  SincronizarDesgloseSal( const AEmpresa, ACentro, AProducto: string; const AInicio, AFin: TDateTime;
                                const ACodigo,ATitulo: String; const ATipo: integer): RSincroResumen;

procedure CrearQuerys;
procedure DestruirQuerys;
procedure PreparaQuerys( const AEmpresa, ACentro, AProducto, ACodigo: string; const ATipo: Integer );
procedure ParametrosQuerys( const AEmpresa, ACentro, AProducto, ACodigo: string; const AInicio, AFin: TDateTime; const ATipo: integer );
procedure AbrirQuerys;
procedure CerrarQuerys;
function  PasarRegistros: RSincroResumen;
function  PasarDesgloseSal: RSincroResumen;

implementation

uses
  UDMBaseDatos;

var
  QSourceCab: TQuery;
  QTargetCab: TQuery;
  QRegisterCount: TQuery;

procedure CrearQuerys;
begin
  QSourceCab:= TQuery.Create( nil );
  QSourceCab.DatabaseName:= 'BDProyecto';
  QRegisterCount:= TQuery.Create( nil );
  QRegisterCount.DatabaseName:= 'BDProyecto';
  QTargetCab:= TQuery.Create( nil );
  QTargetCab.DatabaseName:= 'BDCentral';
  QTargetCab.RequestLive:= True;
end;

procedure DestruirQuerys;
begin
  FreeAndNil( QSourceCab );
  FreeAndNil( QRegisterCount );
  FreeAndNil( QTargetCab );
end;

procedure PreparaQuerysEscandallo( const AEmpresa, ACentro, AProducto, ACodigo: string );
var
  bFlag: boolean;
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_escandallo');
  QTargetCab.SQL.Add('where empresa_e = ''###'' ');

  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_escandallo');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCab.SQL.Add('where empresa_e = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and centro_e = :centro');
    end
    else
    begin
      QSourceCab.SQL.Add('where centro_e = :centro');
    end;
    bFlag:= True;
  end;
  if AProducto <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and producto_e = :producto');
    end
    else
    begin
      QSourceCab.SQL.Add('where producto_e = :producto');
    end;
    bFlag:= True;
  end;
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and numero_entrada_e = :codigo');
    end
    else
    begin
      QSourceCab.SQL.Add('where numero_entrada_e = :codigo');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QSourceCab.SQL.Add('  and fecha_e between :ini and :fin');
  end
  else
  begin
    QSourceCab.SQL.Add('where fecha_e between :ini and :fin');
  end;


  QRegisterCount.SQL.Clear;
  QRegisterCount.SQL.Add('select count(*) ');
  QRegisterCount.SQL.Add('from frf_escandallo');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QRegisterCount.SQL.Add('where empresa_e = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QRegisterCount.SQL.Add('  and centro_e = :centro');
    end
    else
    begin
      QRegisterCount.SQL.Add('where centro_e = :centro');
    end;
    bFlag:= True;
  end;
  if AProducto <> '' then
  begin
    if bFlag then
    begin
      QRegisterCount.SQL.Add('  and producto_e = :producto');
    end
    else
    begin
      QRegisterCount.SQL.Add('where producto_e = :producto');
    end;
    bFlag:= True;
  end;
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QRegisterCount.SQL.Add('  and numero_entrada_e = :codigo');
    end
    else
    begin
      QRegisterCount.SQL.Add('where numero_entrada_e = :codigo');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QRegisterCount.SQL.Add('  and fecha_e between :ini and :fin');
  end
  else
  begin
    QRegisterCount.SQL.Add('where fecha_e between :ini and :fin');
  end;
end;

procedure PreparaQuerysDesgloseSal( const AEmpresa, ACentro, AProducto, ACodigo: string );
var
  bFlag: boolean;
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_salidas_l2');
  QTargetCab.SQL.Add('where empresa_sl2 = ''###'' ');


  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_salidas_l2');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCab.SQL.Add('where empresa_sl2 = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and centro_salida_sl2 = :centro');
    end
    else
    begin
      QSourceCab.SQL.Add('where centro_salida_sl2 = :centro');
    end;
    bFlag:= True;
  end;
  if AProducto <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and producto_sl2 = :producto');
    end
    else
    begin
      QSourceCab.SQL.Add('where producto_sl2 = :producto');
    end;
    bFlag:= True;
  end;
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and n_albaran_sl2 = :codigo');
    end
    else
    begin
      QSourceCab.SQL.Add('where n_albaran_sl2 = :codigo');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QSourceCab.SQL.Add('  and fecha_sl2 between :ini and :fin');
  end
  else
  begin
    QSourceCab.SQL.Add('where fecha_sl2 between :ini and :fin');
  end;


  QRegisterCount.SQL.Clear;
  QRegisterCount.SQL.Add('select count(*) ');
  QRegisterCount.SQL.Add('from frf_salidas_l2');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QRegisterCount.SQL.Add('where empresa_sl2 = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QRegisterCount.SQL.Add('  and centro_salida_sl2 = :centro');
    end
    else
    begin
      QRegisterCount.SQL.Add('where centro_salida_sl2 = :centro');
    end;
    bFlag:= True;
  end;
  if AProducto <> '' then
  begin
    if bFlag then
    begin
      QRegisterCount.SQL.Add('  and producto_sl2 = :producto');
    end
    else
    begin
      QRegisterCount.SQL.Add('where producto_sl2 = :producto');
    end;
    bFlag:= True;
  end;
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QRegisterCount.SQL.Add('  and n_albaran_sl2 = :codigo');
    end
    else
    begin
      QRegisterCount.SQL.Add('where n_albaran_sl2 = :codigo');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QRegisterCount.SQL.Add('  and fecha_sl2 between :ini and :fin');
  end
  else
  begin
    QRegisterCount.SQL.Add('where fecha_sl2 between :ini and :fin');
  end;
end;


procedure PreparaQuerys( const AEmpresa, ACentro, AProducto, ACodigo: string; const ATipo: integer );
begin
  case ATipo of
    kSincroDesgloseSal: PreparaQuerysDesgloseSal( AEmpresa, ACentro, AProducto, ACodigo );
    else raise Exception.Create('Error al crear las sentencias SQL.');
  end;
end;

procedure ParametrosQuerys( const AEmpresa, ACentro, AProducto, ACodigo: string; const AInicio, AFin: TDateTime; const ATipo: integer );
begin
  if AEmpresa <> '' then
  begin
    QSourceCab.ParamByName('empresa').AsString:= AEmpresa;
    QRegisterCount.ParamByName('empresa').AsString:= AEmpresa;
  end;
  if ACentro <> '' then
  begin
    QSourceCab.ParamByName('centro').AsString:= ACentro;
    QRegisterCount.ParamByName('centro').AsString:= ACentro;
  end;
  if (ATipo = kSincroDesgloseSal) then
  begin
    if AProducto <> '' then
    begin
      QSourceCab.ParamByName('producto').AsString:= AProducto;
      QRegisterCount.ParamByName('producto').AsString:= AProducto;
    end;
  end;
  if ACodigo <> '' then
  begin
    QSourceCab.ParamByName('codigo').AsString:= ACodigo;
    QRegisterCount.ParamByName('codigo').AsString:= ACodigo;
  end;
  QSourceCab.ParamByName('ini').AsDateTime:= AInicio;
  QSourceCab.ParamByName('fin').AsDateTime:= AFin;
  QRegisterCount.ParamByName('ini').AsDateTime:= AInicio;
  QRegisterCount.ParamByName('fin').AsDateTime:= AFin;
end;

procedure AbrirQuerys;
begin
  DMBaseDatos.BDCentral.Open;
  QSourceCab.Open;
  QTargetCab.Open;
end;

procedure CerrarQuerys;
begin
  QSourceCab.Close;
  QTargetCab.Close;
  DMBaseDatos.BDCentral.Close;
end;

function PasarRegistros: RSincroResumen;
var
  sMsg: String;
begin
  QSourceCab.First;
  InicializarBarraProgreso( QRegisterCount );

  while not QSourceCab.Eof do
  begin
    try
      result.registros:= result.registros + 1;
      sMsg:= DescripcionRegistro( QSourceCab, 6 );

      try
        PasaRegistro( QSourceCab, QTargetCab );
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
end;

function PasarDesgloseSal: RSincroResumen;
var
  sMsg: String;
begin
  QSourceCab.First;
  InicializarBarraProgreso( QRegisterCount );

  while not QSourceCab.Eof do
  begin
    try
      result.registros:= result.registros + 1;
      sMsg:= DescripcionRegistro( QSourceCab, 6 );

      if not ComprobarLineaAlbaran ( QSourceCab ) then
      begin
        sMsg:= ' ---> ' + IntToStr( result.erroneos) + ') No existe Linea de Albaran en Central. ' + #13 + #10 + sMsg;
        result.msgErrores.Add( sMsg );
        result.erroneos:= result.erroneos + 1;
      end
      else if not ComprobarKilosLinea ( QSourceCab ) then
      begin
        sMsg:= ' ---> ' + IntToStr( result.erroneos) + ') Kilos distintos en la linea de salida entre Central y el Almacen. ' + #13 + #10 + sMsg;
        result.msgErrores.Add( sMsg );
        result.erroneos:= result.erroneos + 1;
      end
      else
      begin
        if not DMBaseDatos.BDCentral.InTransaction then
        begin
          try
            DMBaseDatos.BDCentral.StartTransaction;
            try
              DeleteDesgloseSal ( QSourceCab );
              PasaRegistro( QSourceCab, QTargetCab );
              DMBaseDatos.BDCentral.Commit;
            except
             DMBaseDatos.BDCentral.Rollback;
             raise;
            end;
          finally
            IncBarraProgreso;
          end;
        end;

        result.pasados:= result.pasados + 1;
        sMsg:= ' ---> ' + IntToStr( result.pasados ) + ') ' + #13 + #10 + sMsg;
        result.msgPasados.Add( sMsg );
      end
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
end;

function  SincronizarRegistros( const AEmpresa, ACentro, AProducto: string; const AInicio, AFin: TDateTime;
                                const ACodigo, ATitulo: String; const ATipo: integer): RSincroResumen;
begin
  result.titulo:= ATitulo;
  CrearQuerys;
  try
    PreparaQuerys( AEmpresa, ACentro, AProducto, ACodigo, ATipo );
    ParametrosQuerys( AEmpresa, ACentro, AProducto, ACodigo, AInicio, AFin, ATipo );
    AbrirQuerys;
    result:= PasarRegistros;
  finally
    CerrarQuerys;
    DestruirQuerys;
  end;
end;

function  SincronizarDesgloseSal( const AEmpresa, ACentro, AProducto: string; const AInicio, AFin: TDateTime;
                                const ACodigo, ATitulo: String; const ATipo: integer): RSincroResumen;
begin
  result.titulo:= ATitulo;
  CrearQuerys;
  try
    PreparaQuerys( AEmpresa, ACentro, AProducto, ACodigo, ATipo );
    ParametrosQuerys( AEmpresa, ACentro, AProducto, ACodigo, AInicio, AFin, ATipo );
    AbrirQuerys;
    result:= PasarDesgloseSal;
  finally
    CerrarQuerys;
    DestruirQuerys;
  end;
end;

end.


