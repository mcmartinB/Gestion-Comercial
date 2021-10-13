(*CODIGO*)
(*Indica donde insertar codigo*)
(*REVISAR*)
(*Codigo que funciona pero deberias cambiar*)
unit SincroDiarioMDetailUNT;

interface

uses SysUtils, DB, DBTables, SincroVarUNT, UDMConfig;


function  SincronizarRegistros( const AEmpresa, ACentro, AProducto: string;
                                   const AInicio, AFin: TDateTime;
                                   const ACodigo, ATitulo: String;
                                   const ATipo: integer ): RSincroResumen;
function  SincronizarSalidas( const AEmpresa, ACentro: string;
                                   const AInicio, AFin: TDateTime;
                                   const ACodigo, ATitulo: String ): RSincroResumen;

procedure CrearQuerys;
procedure DestruirQuerys;
procedure PreparaQuerys( const AEmpresa, ACentro, AProducto, ACodigo: string; const ATipo: Integer );
procedure ParametrosQuerys( const AEmpresa, ACentro, AProducto, ACodigo: string; const AInicio, AFin: TDateTime );
procedure AbrirQuerys;
procedure CerrarQuerys;
function  PasarMDetalles: RSincroResumen;
function  PasarMSalidas: RSincroResumen;
procedure PasaMDetalle;
procedure PasaMSalida;

implementation

uses
  UDMBaseDatos, SincroTransitosUNT;

var
  QSourceCab: TQuery;
  QSourceCount: TQuery;
  DSCab, DSLin: TDataSource;
  QSourceLinA: TQuery;
  QSourceLinB: TQuery;
  QSourceLinC: TQuery;
  QSourceLin2: TQuery;

  QTargetCab: TQuery;
  QTargetCliente: TQuery;
  QTargetLinA: TQuery;
  QTargetLinB: TQuery;
  QTargetLinC: TQuery;
  QTargetLin2: TQuery;

procedure CrearQuerys;
begin
  QSourceCab:= TQuery.Create( nil );
  QSourceCab.DatabaseName:= 'BDProyecto';
  QSourceCount:= TQuery.Create( nil );
  QSourceCount.DatabaseName:= 'BDProyecto';
  DSCab:= TDataSource.Create( nil );
  DSCab.DataSet:= QSourceCab;
  QSourceLinA:= TQuery.Create( nil );
  QSourceLinA.DatabaseName:= 'BDProyecto';
  QSourceLinA.DataSource:= DSCab;
  QSourceLinB:= TQuery.Create( nil );
  QSourceLinB.DatabaseName:= 'BDProyecto';
  QSourceLinB.DataSource:= DSCab;
  QSourceLinC:= TQuery.Create( nil );
  QSourceLinC.DatabaseName:= 'BDProyecto';
  QSourceLinC.DataSource:= DSCab;
  DSLin:= TDataSource.Create( nil );
  DSLin.DataSet:= QSourceLinA;
  QSourceLin2:= TQuery.Create( nil );
  QSourceLin2.DatabaseName:= 'BDProyecto';
  QSourceLin2.DataSource:= DSLin;


  QTargetCab:= TQuery.Create( nil );
  QTargetCab.DatabaseName:= 'BDCentral';
  QTargetCab.RequestLive:= True;  
  QTargetCliente:= TQuery.Create( nil );
  QTargetCliente.DatabaseName:= 'BDCentral';
  QTargetLinA:= TQuery.Create( nil );
  QTargetLinA.DatabaseName:= 'BDCentral';
  QTargetLinA.RequestLive:= True;
  QTargetLinB:= TQuery.Create( nil );
  QTargetLinB.DatabaseName:= 'BDCentral';
  QTargetLinB.RequestLive:= True;
  QTargetLinC:= TQuery.Create( nil );
  QTargetLinC.DatabaseName:= 'BDCentral';
  QTargetLinC.RequestLive:= True;
  QTargetLin2:= TQuery.Create( nil );
  QTargetLin2.DatabaseName:= 'BDCentral';
  QTargetLin2.RequestLive:= True;

end;

procedure DestruirQuerys;
begin
  FreeAndNil( QSourceLinA );
  FreeAndNil( QSourceLinB );
  FreeAndNil( QSourceLinC );
  FreeAndNil( QSourceLin2 );
  FreeAndNil( DSCab );
  FreeAndNil( QSourceCab );
  FreeAndNil( QSourceCount );
  FreeAndNil( QTargetLinA );
  FreeAndNil( QTargetLinB );
  FreeAndNil( QTargetLinC );
  FreeAndNil( QTargetLin2 );
  FreeAndNil( QTargetCab );
  FreeAndNil( QTargetCliente );
end;

(*CODIGO*)
procedure PreparaQuerysEntradas( const AEmpresa, ACentro, AProducto, ACodigo: string );
var
  bFlag: Boolean;
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_entradas_c');
  QTargetCab.SQL.Add('where empresa_ec = ''###'' ');

  QTargetLinA.SQL.Clear;
  QTargetLinA.SQL.Add('select * ');
  QTargetLinA.SQL.Add('from frf_entradas1_l');
  QTargetLinA.SQL.Add('where empresa_e1l = ''###'' ');

  QTargetLinB.SQL.Clear;
  QTargetLinB.SQL.Add('select * ');
  QTargetLinB.SQL.Add('from frf_entradas2_l');
  QTargetLinB.SQL.Add('where empresa_e2l = ''###'' ');

  QTargetLinC.SQL.Clear;

  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_entradas_c');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCab.SQL.Add('where empresa_ec = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and centro_ec = :centro');
    end
    else
    begin
      QSourceCab.SQL.Add('where centro_ec = :centro');
    end;
    bFlag:= True;
  end;
  if AProducto <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and producto_ec = :producto');
    end
    else
    begin
      QSourceCab.SQL.Add('where producto_ec = :producto');
    end;
    bFlag:= True;
  end;
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and numero_entrada_ec = :codigo');
    end
    else
    begin
      QSourceCab.SQL.Add('where numero_entrada_ec = :codigo');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QSourceCab.SQL.Add('  and fecha_ec between :ini and :fin');
  end
  else
  begin
    QSourceCab.SQL.Add('where fecha_ec between :ini and :fin');
  end;

  QSourceCount.SQL.Clear;
  QSourceCount.SQL.Add('select Count(*) ');
  QSourceCount.SQL.Add('from frf_entradas_c');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCount.SQL.Add('where empresa_ec = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCount.SQL.Add('  and centro_ec = :centro');
    end
    else
    begin
      QSourceCount.SQL.Add('where centro_ec = :centro');
    end;
    bFlag:= True;
  end;
  if AProducto <> '' then
  begin
    if bFlag then
    begin
      QSourceCount.SQL.Add('  and producto_ec = :producto');
    end
    else
    begin
      QSourceCount.SQL.Add('where producto_ec = :producto');
    end;
    bFlag:= True;
  end;  
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QSourceCount.SQL.Add('  and numero_entrada_ec = :codigo');
    end
    else
    begin
      QSourceCount.SQL.Add('where numero_entrada_ec = :codigo');
    end;
    bFlag:= True;
  end;  
  if bFlag then
  begin
    QSourceCount.SQL.Add('  and fecha_ec between :ini and :fin');
  end
  else
  begin
    QSourceCount.SQL.Add('where fecha_ec between :ini and :fin');
  end;

  QSourceLinA.SQL.Clear;
  QSourceLinA.SQL.Add('select * ');
  QSourceLinA.SQL.Add('from frf_entradas1_l');
  QSourceLinA.SQL.Add('where empresa_e1l = :empresa_ec ');
  QSourceLinA.SQL.Add('  and centro_e1l = :centro_ec ');
  QSourceLinA.SQL.Add('  and fecha_e1l = :fecha_ec ');
  QSourceLinA.SQL.Add('  and numero_entrada_e1l = :numero_entrada_ec ');

  QSourceLinB.SQL.Clear;
  QSourceLinB.SQL.Add('select * ');
  QSourceLinB.SQL.Add('from frf_entradas2_l');
  QSourceLinB.SQL.Add('where empresa_e2l = :empresa_ec ');
  QSourceLinB.SQL.Add('  and centro_e2l = :centro_ec ');
  QSourceLinB.SQL.Add('  and fecha_e2l = :fecha_ec ');
  QSourceLinB.SQL.Add('  and numero_entrada_e2l = :numero_entrada_ec ');

  QSourceLinC.SQL.Clear;

end;

procedure PreparaQuerysPedidos( const AEmpresa, ACentro, ACodigo: string );
var
  bFlag: boolean;
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_pedido_cab');
  QTargetCab.SQL.Add('where empresa_pdc = ''###'' ');

  QTargetLinA.SQL.Clear;
  QTargetLinA.SQL.Add('select * ');
  QTargetLinA.SQL.Add('from frf_pedido_det');
  QTargetLinA.SQL.Add('where empresa_pdd = ''###'' ');

  QTargetLinB.SQL.Clear;
  QTargetLinC.SQL.Clear;

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
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and pedido_pdc = :codigo');
    end
    else
    begin
      QSourceCab.SQL.Add('where pedido_pdc = :codigo');
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
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QSourceCount.SQL.Add('  and pedido_pdc = :codigo');
    end
    else
    begin
      QSourceCount.SQL.Add('where pedido_pdc = :codigo');
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

  QSourceLinA.SQL.Clear;
  begin
    QSourceLinA.SQL.Add('select * ');
  end;

  QSourceLinA.SQL.Add('from frf_pedido_det');
  QSourceLinA.SQL.Add('where empresa_pdd = :empresa_pdc ');
  QSourceLinA.SQL.Add('  and centro_pdd = :centro_pdc ');
  QSourceLinA.SQL.Add('  and pedido_pdd = :pedido_pdc ');

  QSourceLinB.SQL.Clear;
  QSourceLinC.SQL.Clear;
end;

procedure PreparaQuerysSalidas( const AEmpresa, ACentro, ACodigo: string );
var
  bFlag: boolean;
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_salidas_c');
  QTargetCab.SQL.Add('where empresa_sc = ''###'' ');

  QTargetCliente.SQL.Clear;
  QTargetCliente.SQL.Add('select incoterm_c, plaza_incoterm_c from frf_clientes ');
  QTargetCliente.SQL.Add('where cliente_c = :cliente ');

  QTargetLinA.SQL.Clear;
  QTargetLinA.SQL.Add('select * ');
  QTargetLinA.SQL.Add('from frf_salidas_l');
  QTargetLinA.SQL.Add('where empresa_sl = ''###'' ');

  QTargetLinB.SQL.Clear;
  QTargetLinB.SQL.Add('select * ');
  QTargetLinB.SQL.Add('from frf_depositos_aduana_c ');
  QTargetLinB.SQL.Add('where empresa_dac = ''###'' ');

  QTargetLin2.SQL.Clear;
  QTargetLin2.SQL.Add('select * ');
  QTargetLin2.SQL.Add('from frf_salidas_l2');
  QTargetLin2.SQL.Add('where empresa_sl2 = ''###'' ');

  begin
    QTargetLinC.SQL.Clear;
  end;

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
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and n_albaran_sc = :codigo');
    end
    else
    begin
      QSourceCab.SQL.Add('where n_albaran_sc = :codigo');
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
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QSourceCount.SQL.Add('  and n_albaran_sc = :codigo');
    end
    else
    begin
      QSourceCount.SQL.Add('where n_albaran_sc = :codigo');
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

  QSourceLinA.SQL.Clear;
  QSourceLinA.SQL.Add('select * ');
  QSourceLinA.SQL.Add('from frf_salidas_l');
  QSourceLinA.SQL.Add('where empresa_sl = :empresa_sc ');
  QSourceLinA.SQL.Add('  and centro_salida_sl = :centro_salida_sc ');
  QSourceLinA.SQL.Add('  and fecha_sl = :fecha_sc ');
  QSourceLinA.SQL.Add('  and n_albaran_sl = :n_albaran_sc ');

  QSourceLinB.SQL.Clear;
  QSourceLinB.SQL.Add('select * ');
  QSourceLinB.SQL.Add('from frf_depositos_aduana_c');
  QSourceLinB.SQL.Add('where empresa_dac = :empresa_sc ');
  QSourceLinB.SQL.Add('  and centro_dac = :centro_salida_sc ');
  QSourceLinB.SQL.Add('  and fecha_dac = :fecha_sc ');
  QSourceLinB.SQL.Add('  and referencia_dac = :n_albaran_sc ');

  begin
    QSourceLinC.SQL.Clear;
  end;

  QSourceLin2.SQL.Clear;
  QSourceLin2.SQL.Add('select * ');
  QSourceLin2.SQL.Add('from frf_salidas_l2');
  QSourceLin2.SQL.Add('where empresa_sl2 = :empresa_sl ');
  QSourceLin2.SQL.Add('  and centro_salida_sl2 = :centro_salida_sl ');
  QSourceLin2.SQL.Add('  and fecha_sl2 = :fecha_sl ');
  QSourceLin2.SQL.Add('  and n_albaran_sl2 = :n_albaran_sl ');
  QSourceLin2.SQL.Add('  and id_linea_albaran_sl2 = :id_linea_albaran_sl ');

end;


procedure PreparaQuerysInventario( const AEmpresa, ACentro: string );
var
  bFlag: boolean;
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_inventarios_c');
  QTargetCab.SQL.Add('where empresa_ic = ''###'' ');

  QTargetLinA.SQL.Clear;
  QTargetLinA.SQL.Add('select * ');
  QTargetLinA.SQL.Add('from frf_inventarios_l');
  QTargetLinA.SQL.Add('where empresa_il = ''###'' ');

  QTargetLinB.SQL.Clear;
  QTargetLinC.SQL.Clear;

  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_inventarios_c');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCab.SQL.Add('where empresa_ic = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and centro_ic = :centro');
    end
    else
    begin
      QSourceCab.SQL.Add('where centro_ic = :centro');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QSourceCab.SQL.Add('  and fecha_ic between :ini and :fin');
  end
  else
  begin
    QSourceCab.SQL.Add('where fecha_ic between :ini and :fin');
  end;

  QSourceCount.SQL.Clear;
  QSourceCount.SQL.Add('select Count(*) ');
  QSourceCount.SQL.Add('from frf_inventarios_c');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCount.SQL.Add('where empresa_ic = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCount.SQL.Add('  and centro_ic = :centro');
    end
    else
    begin
      QSourceCount.SQL.Add('where centro_ic = :centro');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QSourceCount.SQL.Add('  and fecha_ic between :ini and :fin');
  end
  else
  begin
    QSourceCount.SQL.Add('where fecha_ic between :ini and :fin');
  end;

  QSourceLinA.SQL.Clear;
  QSourceLinA.SQL.Add('select * ');
  QSourceLinA.SQL.Add('from frf_inventarios_l');
  QSourceLinA.SQL.Add('where empresa_il = :empresa_ic ');
  QSourceLinA.SQL.Add('  and centro_il = :centro_ic ');
  QSourceLinA.SQL.Add('  and fecha_il = :fecha_ic ');
  QSourceLinA.SQL.Add('  and producto_il = :producto_ic ');

  QSourceLinB.SQL.Clear;
  QSourceLinC.SQL.Clear;
end;

procedure PreparaQuerysEntregas( const AEmpresa, ACentro, ACodigo: string );
var
  bFlag: boolean;
  sFecha: String;
begin
  QTargetCab.SQL.Clear;
  QTargetCab.SQL.Add('select * ');
  QTargetCab.SQL.Add('from frf_entregas_c');
  QTargetCab.SQL.Add('where empresa_ec = ''###'' ');

  QTargetLinA.SQL.Clear;
  QTargetLinA.SQL.Add('select * ');
  QTargetLinA.SQL.Add('from frf_entregas_l');
  QTargetLinA.SQL.Add('where empresa_el = ''###'' ');

  QTargetLinB.SQL.Clear;

  QTargetLinC.SQL.Clear;
  QTargetLinC.SQL.Add('select * ');
  QTargetLinC.SQL.Add('from frf_entregas_rel');
  QTargetLinC.SQL.Add('where empresa_er = ''###'' ');

  QSourceCab.SQL.Clear;
  QSourceCab.SQL.Add('select * ');
  QSourceCab.SQL.Add('from frf_entregas_c');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCab.SQL.Add('where empresa_ec = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and centro_origen_ec = :centro');
    end
    else
    begin
      QSourceCab.SQL.Add('where centro_origen_ec = :centro');
    end;
    bFlag:= True;
  end;
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QSourceCab.SQL.Add('  and codigo_ec = :codigo');
    end
    else
    begin
      QSourceCab.SQL.Add('where codigo_ec = :codigo');
    end;
    bFlag:= True;
  end;

  if DMConfig.iInstalacion = 31 then
  begin
    sFecha:= 'fecha_origen_ec';
  end
  else
  begin
    sFecha:= 'fecha_llegada_ec';
  end;

  if bFlag then
  begin
    QSourceCab.SQL.Add('  and ' + sFecha + ' between :ini and :fin');
  end
  else
  begin
    QSourceCab.SQL.Add('where ' + sFecha + ' between :ini and :fin');
  end;

  QSourceCount.SQL.Clear;
  QSourceCount.SQL.Add('select Count(*) ');
  QSourceCount.SQL.Add('from frf_entregas_c');
  bFlag:= false;
  if AEmpresa <> '' then
  begin
    bFlag:= True;
    QSourceCount.SQL.Add('where empresa_ec = :empresa');
  end;
  if ACentro <> '' then
  begin
    if bFlag then
    begin
      QSourceCount.SQL.Add('  and centro_origen_ec = :centro');
    end
    else
    begin
      QSourceCount.SQL.Add('where centro_origen_ec = :centro');
    end;
    bFlag:= True;
  end;
  if ACodigo <> '' then
  begin
    if bFlag then
    begin
      QSourceCount.SQL.Add('  and codigo_ec = :codigo');
    end
    else
    begin
      QSourceCount.SQL.Add('where codigo_ec = :codigo');
    end;
    bFlag:= True;
  end;
  if bFlag then
  begin
    QSourceCount.SQL.Add('  and ' + sFecha + ' between :ini and :fin');
  end
  else
  begin
    QSourceCount.SQL.Add('where ' + sFecha + ' between :ini and :fin');
  end;

  QSourceLinA.SQL.Clear;
  QSourceLinA.SQL.Add('select * ');
  QSourceLinA.SQL.Add('from frf_entregas_l');
  QSourceLinA.SQL.Add('where codigo_el = :codigo_ec ');

  QSourceLinB.SQL.Clear;

  QSourceLinC.SQL.Clear;
  QSourceLinC.SQL.Add('select * ');
  QSourceLinC.SQL.Add('from frf_entregas_rel');
  QSourceLinC.SQL.Add('where codigo_er = :codigo_ec ');

end;

procedure PreparaQuerys( const AEmpresa, ACentro, AProducto, ACodigo: string; const ATipo: integer );
begin
  (*CODIGO*)
  case ATipo of
    kSincroEntradas: PreparaQuerysEntradas( AEmpresa, ACentro, AProducto, ACodigo );
    kSincroSalidas: PreparaQuerysSalidas( AEmpresa, ACentro, ACodigo );
    kSincroInventarios: PreparaQuerysInventario( AEmpresa, ACentro );
    kSincroEntregas: PreparaQuerysEntregas( AEmpresa, ACentro, ACodigo );
    kSincroPedidos: PreparaQuerysPedidos( AEmpresa, ACentro, ACodigo );
    else raise Exception.Create('Error al crear las sentencias SQL.');
  end;
end;

procedure ParametrosQuerys( const AEmpresa, ACentro, AProducto, ACodigo: string; const AInicio, AFin: TDateTime );
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
  if Trim( AProducto ) <> '' then
  begin
    QSourceCab.ParamByName('producto').AsString:= AProducto;
    QSourceCount.ParamByName('producto').AsString:= AProducto;
  end;
  if Trim( ACodigo ) <> '' then
  begin
    QSourceCab.ParamByName('codigo').AsString:= ACodigo;
    QSourceCount.ParamByName('codigo').AsString:= ACodigo;
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
  if QSourceLinA.SQL.Text <> '' then
    QSourceLinA.Open;
  if QSourceLinB.SQL.Text <> '' then
    QSourceLinB.Open;
  if QSourceLinC.SQL.Text <> '' then
    QSourceLinC.Open;
  if QSourceLin2.SQL.Text <> '' then
    QSourceLin2.Open;
  QTargetCab.Open;
  if QTargetLinA.SQL.Text <> '' then
    QTargetLinA.Open;
  if QTargetLinB.SQL.Text <> '' then
    QTargetLinB.Open;
  if QTargetLinC.SQL.Text <> '' then
    QTargetLinC.Open;
  if QTargetLin2.SQL.Text <> '' then
    QTargetLin2.Open;

end;

procedure CerrarQuerys;
begin
  QSourceLinA.Close;
  QSourceLinB.Close;
  QSourceLinC.Close;
  QSourceLin2.Close;
  QSourceCab.Close;
  QTargetLinA.Close;
  QTargetLinB.Close;
  QTargetLinC.Close;
  QTargetLin2.Close;
  QTargetCab.Close;
  DMBaseDatos.BDCentral.Close;
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
      PasaRegistro( QSourceCab, QTargetCab );

      //PASAR DETALLES
      PasarRegistros( QSourceLinA, QTargetLinA, QAux, QAux );
      PasarRegistros( QSourceLinB, QTargetLinB, QAux, QAux );
      PasarRegistros( QSourceLinC, QTargetLinC, QAux, QAux );

      DMBaseDatos.BDCentral.Commit;
    except
      DMBaseDatos.BDCentral.Rollback;
      raise;
    end;
  end;
  FreeAndNil( QAux );
end;

procedure PasaMSalida;
var QAux: TQuery;
begin
   QAux := TQuery.Create(nil);
  (*REVISAR*)
  if not DMBaseDatos.BDCentral.InTransaction then
  begin
    DMBaseDatos.BDCentral.StartTransaction;
    try
      //PASAR MAESTRO
      PasaRSalida( QSourceCab, QTargetCab, QTargetCliente );

      //PASAR DETALLES

      PasarRegistros( QSourceLinA, QTargetLinA, QSourceLin2, QTargetLin2 );
      PasarRegistros( QSourceLinB, QTargetLinB, QAux, QAux );
      PasarRegistros( QSourceLinC, QTargetLinC, QAux, QAux );

      DMBaseDatos.BDCentral.Commit;
    except
      DMBaseDatos.BDCentral.Rollback;
      raise;
    end;
  end;
  FreeAndNil( QAux );
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
        if Duplicado( e ) then
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

function PasarMSalidas: RSincroResumen;
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
        PasaMSalida;
      finally
        IncBarraProgreso;
      end;
      result.pasados:= result.pasados + 1;
      sMsg:= ' ---> ' + IntToStr( result.pasados ) + ') ' + #13 + #10 + sMsg;
      result.msgPasados.Add( sMsg );
    except
      on e: edbengineerror do
      begin
        if Duplicado( e ) then
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

function SincronizarRegistros( const AEmpresa, ACentro, AProducto: string;
                                   const AInicio, AFin: TDateTime;
                                   const ACodigo, ATitulo: String;
                                   const ATipo: integer ): RSincroResumen;
begin
  if ( ATipo = kSincroTransitos )  then
  begin
    result.titulo:= ATitulo;
    result:= SincronizarTransitos( AEmpresa, ACentro, ACodigo, AInicio, AFin );
  end
  else
  begin
    result.titulo:= ATitulo;
    CrearQuerys;
    try
      PreparaQuerys( AEmpresa, ACentro, AProducto, ACodigo, ATipo );
      ParametrosQuerys( AEmpresa, ACentro, AProducto, ACodigo, AInicio, AFin );
      AbrirQuerys;
      result:= PasarMDetalles;
    finally
      CerrarQuerys;
      DestruirQuerys;
    end;
  end;
end;

function SincronizarSalidas( const AEmpresa, ACentro: string;
                                   const AInicio, AFin: TDateTime;
                                   const ACodigo, ATitulo: String ): RSincroResumen;
begin
  result.titulo:= ATitulo;
  CrearQuerys;
  try
    PreparaQuerysSalidas( AEmpresa, ACentro, ACodigo );
    ParametrosQuerys( AEmpresa, ACentro, '', ACodigo, AInicio, AFin );
    AbrirQuerys;
    result:= PasarMSalidas;
  finally
    CerrarQuerys;
    DestruirQuerys;
  end;
end;

end.



