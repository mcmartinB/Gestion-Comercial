(*CODIGO*)
(*Indica donde insertar codigo*)
(*REVISAR*)
(*Codigo que funciona pero deberias cambiar*)
unit SincroDiarioMDetailUNT;

interface

uses SysUtils, DB, DBTables, SincroVarUNT, UDMConfig;


function  SincronizarRegistros( const AEmpresa, ACentro: string; const ADocumento: Integer;
                                   const AInicio, AFin: TDateTime;
                                   const ATitulo: String;
                                   const ATipo: integer ): RSincroResumen;
procedure CrearQuerys;
procedure DestruirQuerys;
procedure PreparaQuerys( const AEmpresa, ACentro: string; const ADocumento: Integer; const ATipo: Integer );
procedure ParametrosQuerys( const AEmpresa, ACentro: string; const ADocumento: Integer; const AInicio, AFin: TDateTime );
procedure AbrirQuerys;
procedure CerrarQuerys;
function  PasarMDetalles: RSincroResumen;
procedure PasaMDetalle;

implementation

uses
  UDMBaseDatos, SincroTransitosUNT;

var
  QSourceCab: TQuery;
  QSourceCount: TQuery;
  DSCab, DSLin: TDataSource;
  QSourceLin, QSourceLin2: TQuery;


  QTargetCab: TQuery;
  QTargetLin, QTargetLin2: TQuery;

procedure CrearQuerys;
begin
  QSourceCab:= TQuery.Create( nil );
  QSourceCab.DatabaseName:= 'BDProyecto';
  QSourceCount:= TQuery.Create( nil );
  QSourceCount.DatabaseName:= 'BDProyecto';
  DSCab:= TDataSource.Create( nil );
  DSCab.DataSet:= QSourceCab;
  QSourceLin:= TQuery.Create( nil );
  QSourceLin.DatabaseName:= 'BDProyecto';
  QSourceLin.DataSource:= DSCab;
  DSLin:= TDataSource.Create( nil );
  DSLin.DataSet:= QSourceLin;
  QSourceLin2:= TQuery.Create( nil );
  QSourceLin2.DatabaseName:= 'BDProyecto';
  QSourceLin2.DataSource:= DSLin;


  QTargetCab:= TQuery.Create( nil );
  QTargetCab.DatabaseName:= 'BDCentral';
  QTargetCab.RequestLive:= True;
  QTargetLin:= TQuery.Create( nil );
  QTargetLin.DatabaseName:= 'BDCentral';
  QTargetLin.RequestLive:= True;
  QTargetLin2:= TQuery.Create( nil );
  QTargetLin2.DatabaseName:= 'BDCentral';
  QTargetLin2.RequestLive:= True;
end;

procedure DestruirQuerys;
begin
  FreeAndNil( QSourceLin2 );
  FreeAndNil( DSLin );
  FreeAndNil( QSourceLin );
  FreeAndNil( DSCab );
  FreeAndNil( QSourceCab );
  FreeAndNil( QSourceCount );
  FreeAndNil( QTargetLin2 );
  FreeAndNil( QTargetLin );
  FreeAndNil( QTargetCab );

end;

(*CODIGO*)
procedure PreparaQuerysPedidos( const AEmpresa, ACentro: string; const ADocumento: Integer );
var
  bFlag: boolean;
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_pedido_cab');
  QTargetCab.SQL.Add('where empresa_pdc = ''###'' ');

  QTargetLin.SQL.Clear;
  QTargetLin.SQL.Add('select * ');
  QTargetLin.SQL.Add('from frf_pedido_det');
  QTargetLin.SQL.Add('where empresa_pdd = ''###'' ');

  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_pedido_cab');

  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCab.SQL.Add('where empresa_pdc = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and centro_pdc = :centro');
    end
    else
    begin
      QSourceCab.SQL.Add('where centro_pdc = :centro');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QSourceCab.SQL.Add('  and fecha_pdc between :ini and :fin');
  end
  else
  begin
    QSourceCab.SQL.Add('where fecha_pdc between :ini and :fin');
  end;
  if ADocumento <> -1 then
  begin
    QSourceCab.SQL.Add('and pedido_pdc = :documento');
  end;

  QSourceCount.SQL.Clear;
  QSourceCount.SQL.Add('select count(*) ');
  QSourceCount.SQL.Add('from frf_pedido_cab');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCount.SQL.Add('where empresa_pdc = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCount.SQL.Add('  and centro_pdc = :centro');
    end
    else
    begin
      QSourceCount.SQL.Add('where centro_pdc = :centro');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QSourceCount.SQL.Add('  and fecha_pdc between :ini and :fin');
  end
  else
  begin
    QSourceCount.SQL.Add('where fecha_pdc between :ini and :fin');
  end;
  if ADocumento <> -1 then
  begin
    QSourceCount.SQL.Add('and pedido_pdc = :documento');
  end;

  QSourceLin.SQL.Clear;
  if DMConfig.EsMaset then
  begin
    QSourceLin.SQL.Add('select empresa_pdd, centro_pdd, pedido_pdd, linea_pdd, producto_pdd, envase_pdd, categoria_pdd, ');
    QSourceLin.SQL.Add('       calibre_pdd, color_pdd, cantidad_pdd unidades_pdd, unidad_pdd ');
  end
  else
  begin
    QSourceLin.SQL.Add('select * ');
  end;


  QSourceLin.SQL.Add('from frf_pedido_det');
  QSourceLin.SQL.Add('where empresa_pdd = :empresa_pdc ');
  QSourceLin.SQL.Add('  and centro_pdd = :centro_pdc ');
  QSourceLin.SQL.Add('  and pedido_pdd = :pedido_pdc ');

end;

procedure PreparaQuerysSalidas( const AEmpresa, ACentro: string; const ADocumento: Integer );
var
  bFlag: boolean;
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_salidas_c');
  QTargetCab.SQL.Add('where empresa_sc = ''###'' ');

  QTargetLin.SQL.Clear;
  QTargetLin.SQL.Add('select rowid, frf_salidas_l.* ');
  QTargetLin.SQL.Add('from frf_salidas_l');
  QTargetLin.SQL.Add('where empresa_sl = ''###'' ');

  QTargetLin2.SQL.Clear;
  QTargetLin2.SQL.Add('select * ');
  QTargetLin2.SQL.Add('from frf_salidas_l2');
  QTargetLin2.SQL.Add('where empresa_sl2 = ''###'' ');

  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_salidas_c');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCab.SQL.Add('where empresa_sc = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and centro_salida_sc = :centro');
    end
    else
    begin
      QSourceCab.SQL.Add('where centro_salida_sc = :centro');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QSourceCab.SQL.Add('  and fecha_sc between :ini and :fin');
  end
  else
  begin
    QSourceCab.SQL.Add('where fecha_sc between :ini and :fin');
  end;
  if ADocumento <> -1 then
  begin
    QSourceCab.SQL.Add('and n_albaran_sc = :documento');
  end;

  QSourceCount.SQL.Clear;
  QSourceCount.SQL.Add('select count(*) ');
  QSourceCount.SQL.Add('from frf_salidas_c');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCount.SQL.Add('where empresa_sc = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCount.SQL.Add('  and centro_salida_sc = :centro');
    end
    else
    begin
      QSourceCount.SQL.Add('where centro_salida_sc = :centro');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QSourceCount.SQL.Add('  and fecha_sc between :ini and :fin');
  end
  else
  begin
    QSourceCount.SQL.Add('where fecha_sc between :ini and :fin');
  end;
  if ADocumento <> -1 then
  begin
    QSourceCount.SQL.Add('and n_albaran_sc = :documento');
  end;

  QSourceLin.SQL.Clear;
  QSourceLin.SQL.Add('select * ');
  QSourceLin.SQL.Add('from frf_salidas_l');
  QSourceLin.SQL.Add('where empresa_sl = :empresa_sc ');
  QSourceLin.SQL.Add('  and centro_salida_sl = :centro_salida_sc ');
  QSourceLin.SQL.Add('  and fecha_sl = :fecha_sc ');
  QSourceLin.SQL.Add('  and n_albaran_sl = :n_albaran_sc ');

  QSourceLin2.SQL.Clear;
  QSourceLin2.SQL.Add('select * ');
  QSourceLin2.SQL.Add('from frf_salidas_l2');
  QSourceLin2.SQL.Add('where empresa_sl2 = :empresa_sl ');
  QSourceLin2.SQL.Add('  and centro_salida_sl2 = :centro_salida_sl ');
  QSourceLin2.SQL.Add('  and n_albaran_sl2 = :n_albaran_sl ');
  QSourceLin2.SQL.Add('  and fecha_sl2 = :fecha_sl ');
  QSourceLin2.SQL.Add('  and id_linea_albaran_sl2 = :id_linea_albaran_sl ');


end;


procedure PreparaQuerys( const AEmpresa, ACentro: string; const ADocumento: Integer; const ATipo: integer );
begin
  (*CODIGO*)
  case ATipo of
    kSSalidas: PreparaQuerysSalidas( AEmpresa, ACentro, ADocumento );
    kSPedidos: PreparaQuerysPedidos( AEmpresa, ACentro, ADocumento );
    else raise Exception.Create('Error al crear las sentencias SQL.');
  end;
end;

procedure ParametrosQuerys( const AEmpresa, ACentro: string; const ADocumento: Integer; const AInicio, AFin: TDateTime );
begin
  if Trim( AEmpresa ) <> '' then
  begin
    QSourceCab.ParamByName('empresa').AsString:= AEmpresa;
    QSourceCount.ParamByName('empresa').AsString:= AEmpresa;
  end;
  if Trim( ACentro ) <> '' then
  begin
    QSourceCab.ParamByName('centro').AsString:= ACentro;
    QSourceCount.ParamByName('centro').AsString:= ACentro;
  end;
  if ADocumento <> -1 then
  begin
    QSourceCab.ParamByName('documento').AsInteger:= ADocumento;
    QSourceCount.ParamByName('documento').AsInteger:= ADocumento;
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
  if QSourceLin.SQL.Text <> '' then
    QSourceLin.Open;
  if QSourceLin2.SQL.Text <> '' then
    QSourceLin2.Open;
  QTargetCab.Open;
  if QTargetLin.SQL.Text <> '' then
    QTargetLin.Open;
  if QTargetLin2.SQL.Text <> '' then
    QTargetLin2.Open;
end;

procedure CerrarQuerys;
begin
  QSourceLin2.Close;
  QSourceLin.Close;
  QSourceCab.Close;
  QTargetLin2.Close;
  QTargetLin.Close;
  QTargetCab.Close;

  DMBaseDatos.BDCentral.Close;
end;

procedure PasaMDetalle;
begin
  (*REVISAR*)
  if not DMBaseDatos.BDCentral.InTransaction then
  begin
    DMBaseDatos.BDCentral.StartTransaction;
    try
      //PASAR MAESTRO
      PasaRegistro( QSourceCab, QTargetCab );

      //PASAR DETALLES

      PasarRegistros( QSourceLin, QTargetLin, QSourceLin2, QTargetLin2 );

      DMBaseDatos.BDCentral.Commit;
    except
      DMBaseDatos.BDCentral.Rollback;
      raise;
    end;
  end;
end;

function Duplicado( e: edbengineerror ): boolean;
var
  i: Integer;
begin
  Result:= False;
  for i:= 0 to e.ErrorCount -1 do
  begin
    if ( Pos('DUPLICATE', UpperCase( e.Errors[i].Message ) ) > 0 ) then
    begin
      Result:= True;
      Break;
    end;
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
        if Duplicado(e) then
        begin
          //sMsg:= ' ---> ' + IntToStr( result.duplicados ) + ') ' + #13 + #10 + sMsg;
          sMsg:= sMsg + #13 + #10 + '[' + IntToStr( e.Errors[0].ErrorCode ) + '] ' + e.Message;
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

function SincronizarRegistros( const AEmpresa, ACentro: string;  const ADocumento: integer;
                                   const AInicio, AFin: TDateTime;
                                   const ATitulo: String;
                                   const ATipo: integer ): RSincroResumen;
begin
  if ( ATipo = kSTransitos )  then
  begin
    result.titulo:= ATitulo;
    result:= SincronizarTransitos( AEmpresa, ADocumento, AInicio, AFin );
  end
  else
  begin
    result.titulo:= ATitulo;
    CrearQuerys;
    try
      PreparaQuerys( AEmpresa, ACentro, ADocumento, ATipo );
      ParametrosQuerys( AEmpresa, ACentro, ADocumento, AInicio, AFin );
      AbrirQuerys;
      result:= PasarMDetalles;
    finally
      CerrarQuerys;
      DestruirQuerys;
    end;
  end;
end;

end.


