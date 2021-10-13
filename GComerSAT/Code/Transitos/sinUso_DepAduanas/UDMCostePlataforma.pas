unit UDMCostePlataforma;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMCostePlataforma = class(TDataModule)
    QSalidasDeposito: TQuery;
    QSalidas: TQuery;
    mtSalidasDeposito: TkbmMemTable;
    QUpdateLinea: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure SQLVentas;
    //procedure SQLTransitos;
  public
    { Public declarations }

    function  PuedoSalir: boolean;
    procedure BuscarSalidas( const AFecha:  TDateTime; const AMatricula: string );
    //procedure BuscarTransitos( const AFecha:  TDateTime; const AMatricula: string );
    function  AltaLineas( const AFactura: string; const AImporte: real;
                          var VKilosCamion, VKilosDeposito, VImporteDeposito: real ): boolean;
    function  Aplicar: boolean;
    procedure ActualizarLinea;
    procedure Cancelar;

  end;


var
  DMCostePlataforma: TDMCostePlataforma;

implementation

{$R *.dfm}

uses
  Dialogs, bMath;

procedure TDMCostePlataforma.DataModuleDestroy(Sender: TObject);
begin
  mtSalidasDeposito.Close;
  with QSalidas do
  begin
    Close;
  end;
  with QSalidasDeposito do
  begin
    CancelUpdates;
    Close;
  end;
end;

(*
procedure TDMCostePlataforma.SQLTransitos;
begin
  with QSalidas do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select empresa_tc empresa, vehiculo_tc matricula, transporte_tc transporte, '''' operador, ');
    SQL.Add('         centro_tc centro, fecha_tc fecha, referencia_tc albaran, centro_destino_tc cliente, ');
    SQL.Add('         sum(palets_tl) palets, sum(cajas_tl) cajas, sum(kilos_tl) kilos ');
    SQL.Add('  from frf_transitos_c, frf_transitos_l ');
    SQL.Add('  where fecha_tc = :fecha ');
    SQL.Add('  and vehiculo_tc like :matricula ');
    SQL.Add('  and empresa_tl = empresa_tc ');
    SQL.Add('  and centro_tl = centro_tc ');
    SQL.Add('  and fecha_tl = fecha_tc ');
    SQL.Add('  and referencia_tl = referencia_tc ');
    SQL.Add('  group by empresa_tc, vehiculo_tc, transporte_tc, centro_tc, fecha_tc, referencia_tc, centro_destino_tc ');
    SQL.Add('  order by empresa_tc, vehiculo_tc, transporte_tc, centro_tc, fecha_tc, referencia_tc, centro_destino_tc ');
  end;

  with QSalidasDeposito do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select empresa_das empresa, centro_salida_das centro, fecha_das fecha, n_albaran_das albaran, ');
    SQL.Add('        codigo_das codigo, linea_das linea, vehiculo_das vehiculo, ');
    SQL.Add('        operador_transporte_das operador, transporte_das transporte, ');
    SQL.Add('        n_cmr_das cmr, n_pedido_das pedido, n_factura_das factura, ');
    SQL.Add('        frigorifico_das importe, kilos_das kilos, ');
    SQL.Add('        ( select carpeta_deposito_tc from frf_transitos_c ');
    SQL.Add('           where empresa_tc = empresa_dac and centro_tc = centro_dac ');
    SQL.Add('           and referencia_tc = referencia_dac  and fecha_tc = fecha_dac ) carpeta ');

    SQL.Add(' from frf_transitos_c, frf_depositos_aduana_sal, frf_depositos_aduana_c ');

    SQL.Add(' where fecha_tc = :fecha ');
    SQL.Add(' and vehiculo_tc like :matricula ');


    SQL.Add(' and empresa_das = empresa_tc ');
    SQL.Add(' and centro_salida_das = centro_tc ');
    SQL.Add(' and fecha_das = fecha_tc ');
    SQL.Add(' and n_albaran_das = referencia_tc ');

    SQL.Add(' and codigo_dac = codigo_das ');

    SQL.Add(' order by carpeta, codigo_das, linea_das  ');
  end;
end;
*)

procedure TDMCostePlataforma.SQLVentas;
begin
  with QSalidas do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select empresa_sc empresa, vehiculo_sc matricula, transporte_sc transporte, operador_transporte_sc operador, ');
    SQL.Add('        centro_salida_sl centro, fecha_sc fecha, n_albaran_sc albaran, cliente_sal_sc cliente, ');
    SQL.Add(' sum(n_palets_sl) palets, sum(cajas_sl) cajas, sum(kilos_sl) kilos ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where fecha_sc = :fecha ');
    SQL.Add(' and vehiculo_sc like :matricula ');
    SQL.Add(' and empresa_sl = empresa_sc ');
    SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    SQL.Add(' group by empresa_sc, vehiculo_sc, transporte_sc, operador_transporte_sc, centro_salida_sl, fecha_sc, n_albaran_sc, cliente_sal_sc ');
    SQL.Add(' UNION ');
    SQL.Add(' select empresa_tc empresa, vehiculo_tc matricula, transporte_tc transporte, transporte_tc operador, ');
    SQL.Add('         centro_tc centro, fecha_tc fecha, referencia_tc albaran, centro_destino_tc cliente, ');
    SQL.Add('         sum(palets_tl) palets, sum(cajas_tl) cajas, sum(kilos_tl) kilos ');
    SQL.Add('  from frf_transitos_c, frf_transitos_l ');
    SQL.Add('  where fecha_tc = :fecha ');
    SQL.Add('  and vehiculo_tc like :matricula ');
    SQL.Add('  and empresa_tl = empresa_tc ');
    SQL.Add('  and centro_tl = centro_tc ');
    SQL.Add('  and fecha_tl = fecha_tc ');
    SQL.Add('  and referencia_tl = referencia_tc ');
    SQL.Add('  group by empresa_tc, vehiculo_tc, transporte_tc, centro_tc, fecha_tc, referencia_tc, centro_destino_tc ');
    SQL.Add(' order by empresa_sc, vehiculo_sc, transporte_sc, operador_transporte_sc, centro_salida_sl, fecha_sc, n_albaran_sc, cliente_sal_sc  ');
  end;

  with QSalidasDeposito do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select empresa_das empresa, centro_salida_das centro, fecha_das fecha, n_albaran_das albaran, ');
    SQL.Add('        codigo_das codigo, linea_das linea, vehiculo_das vehiculo, ');
    SQL.Add('        operador_transporte_das operador, transporte_das transporte, ');
    SQL.Add('        n_cmr_das cmr, n_pedido_das pedido, n_factura_das factura, ');
    SQL.Add('        frigorifico_das importe, kilos_das kilos, carpeta_deposito_tc carpeta');

    SQL.Add(' from frf_salidas_c, frf_depositos_aduana_sal, frf_depositos_aduana_c, frf_transitos_c ');

    SQL.Add(' where fecha_sc = :fecha ');
    SQL.Add(' and vehiculo_sc like :matricula ');

    SQL.Add(' and codigo_dac = codigo_das ');

    SQL.Add(' and empresa_tc = empresa_dac ');
    SQL.Add(' and centro_tc = centro_dac ');
    SQL.Add(' and referencia_tc = referencia_dac ');
    SQL.Add(' and fecha_tc = fecha_dac ');

    SQL.Add(' and empresa_das = empresa_sc ');
    SQL.Add(' and centro_salida_das = centro_salida_sc ');
    SQL.Add(' and fecha_das = fecha_sc ');
    SQL.Add(' and n_albaran_das = n_albaran_sc ');

    SQL.Add(' UNION ');

    SQL.Add(' select empresa_das empresa, centro_salida_das centro, fecha_das fecha, n_albaran_das albaran, ');
    SQL.Add('        codigo_das codigo, linea_das linea, vehiculo_das vehiculo, ');
    SQL.Add('        operador_transporte_das operador, transporte_das transporte, ');
    SQL.Add('        n_cmr_das cmr, n_pedido_das pedido, n_factura_das factura, ');
    SQL.Add('        frigorifico_das importe, kilos_das kilos, ');
    SQL.Add('        ( select carpeta_deposito_tc from frf_transitos_c ');
    SQL.Add('           where empresa_tc = empresa_dac and centro_tc = centro_dac ');
    SQL.Add('           and referencia_tc = referencia_dac  and fecha_tc = fecha_dac ) carpeta ');

    SQL.Add(' from frf_transitos_c, frf_depositos_aduana_sal, frf_depositos_aduana_c ');

    SQL.Add(' where fecha_tc = :fecha ');
    SQL.Add(' and vehiculo_tc like :matricula ');


    SQL.Add(' and empresa_das = empresa_tc ');
    SQL.Add(' and centro_salida_das = centro_tc ');
    SQL.Add(' and fecha_das = fecha_tc ');
    SQL.Add(' and n_albaran_das = referencia_tc ');

    SQL.Add(' and codigo_dac = codigo_das ');

    SQL.Add(' order by carpeta_deposito_tc, codigo_das, linea_das ');
  end;
end;

procedure TDMCostePlataforma.DataModuleCreate(Sender: TObject);
begin


  with QUpdateLinea do
  begin
    SQL.Clear;
    SQL.Add(' update frf_depositos_aduana_sal ');
    SQL.Add(' set frigorifico_das = :importe, ');
    SQL.Add('     n_factura_das = :factura ');
    SQL.Add(' where codigo_das = :codigo ');
    SQL.Add('   and linea_das = :linea ');
    SQL.Add('   and empresa_das = :empresa ');
    SQL.Add('   and centro_salida_das = :centro ');
    SQL.Add('   and fecha_das = :fecha ');
    SQL.Add('   and n_albaran_das = :albaran ');
    SQL.Add('   and n_cmr_das = :cmr ');
  end;

  mtSalidasDeposito.FieldDefs.Clear;
  mtSalidasDeposito.FieldDefs.Add('codigo_das', ftInteger, 0, False);
  mtSalidasDeposito.FieldDefs.Add('linea_das', ftInteger, 0, False);
  mtSalidasDeposito.FieldDefs.Add('empresa_das', ftString, 3, False);
  mtSalidasDeposito.FieldDefs.Add('centro_salida_das', ftString, 1, False);
  mtSalidasDeposito.FieldDefs.Add('n_albaran_das', ftInteger, 0, False);
  mtSalidasDeposito.FieldDefs.Add('fecha_das', ftDate, 0, False);
  mtSalidasDeposito.FieldDefs.Add('operador_transporte_das', ftInteger, 0, False);
  mtSalidasDeposito.FieldDefs.Add('transporte_das', ftInteger, 0, False);
  mtSalidasDeposito.FieldDefs.Add('vehiculo_das', ftString, 20, False);
  mtSalidasDeposito.FieldDefs.Add('n_cmr_das', ftString, 10, False);
  mtSalidasDeposito.FieldDefs.Add('n_pedido_das', ftString, 15, False);
  mtSalidasDeposito.FieldDefs.Add('kilos_das', ftFloat, 0, False);
  mtSalidasDeposito.FieldDefs.Add('frigorifico_das', ftFloat, 0, False);
  mtSalidasDeposito.FieldDefs.Add('n_factura_das', ftString, 10, False);
  mtSalidasDeposito.CreateTable;
  mtSalidasDeposito.Open;
end;


procedure TDMCostePlataforma.BuscarSalidas( const AFecha:  TDateTime; const AMatricula: string );
begin
  SQLVentas;
  with QSalidas do
  begin
    Close;
    ParamByName('matricula').AsString:= '%' + AMatricula + '%';
    ParamByName('fecha').AsDateTime:= AFecha;
    Open;
    if IsEmpty then
    begin
      ShowMessage( 'Sin albaranes de salida' );
    end;
  end;

  with QSalidasDeposito do
  begin
    CancelUpdates;
    Close;
    ParamByName('matricula').AsString:= '%' + AMatricula + '%';
    ParamByName('fecha').AsDateTime:= AFecha;
    Open;
    if IsEmpty then
    begin
      ShowMessage( 'Sin salidas del deposito' );
    end;
  end;
end;

(*
procedure TDMCostePlataforma.BuscarTransitos( const AFecha:  TDateTime; const AMatricula: string );
begin
  SQLTransitos;
  with QSalidas do
  begin
    Close;
    ParamByName('matricula').AsString:= '%' + AMatricula + '%';
    ParamByName('fecha').AsDateTime:= AFecha;
    Open;
    if IsEmpty then
    begin
      ShowMessage( 'Sin tránsitos de salida' );
    end;
  end;

  with QSalidasDeposito do
  begin
    CancelUpdates;
    Close;
    ParamByName('matricula').AsString:= '%' + AMatricula + '%';
    ParamByName('fecha').AsDateTime:= AFecha;
    Open;
    if IsEmpty then
    begin
      ShowMessage( 'Sin salidas del deposito' );
    end;
  end;
end;
*)

function TDMCostePlataforma.AltaLineas( const AFactura: string; const AImporte: real;
                                        var VKilosCamion, VKilosDeposito, VImporteDeposito: real ): boolean;
var
  sFiltro: string;
  rPrecio: real;
begin
  result:= false;

  if not QSalidasDeposito.IsEmpty then
  begin
    (*
    QSalidasDeposito.First;

    while not QSalidasDeposito.Eof do
    begin
      if  ( QSalidasDeposito.FieldByname('factura').AsString <> '' ) then
      begin
        ShowMessage('ERROR: Ya hay salidas ya asignadas a una factura.');
        Exit;
      end;
      QSalidasDeposito.Next;
    end;
    *)

    QSalidas.First;
    VKilosCamion:= 0;
    while not QSalidas.Eof do
    begin
      VKilosCamion:= VKilosCamion + QSalidas.FieldByname('kilos').AsFloat;
      QSalidas.Next;
    end;
    if VKilosCamion > 0 then
      rPrecio:= AImporte / VKilosCamion
    else
      rPrecio:= 0;

    VKilosDeposito:= 0;
    VImporteDeposito:= 0;
    QSalidasDeposito.First;
    mtSalidasDeposito.Close;
    mtSalidasDeposito.Open;
    while not QSalidasDeposito.Eof do
    begin

      mtSalidasDeposito.Insert;
      mtSalidasDeposito.FieldByName('codigo_das').AsInteger:= QSalidasDeposito.FieldByname('codigo').AsInteger;
      mtSalidasDeposito.FieldByName('linea_das').AsInteger:= QSalidasDeposito.FieldByname('linea').AsInteger;
      mtSalidasDeposito.FieldByName('empresa_das').AsString:= QSalidasDeposito.FieldByname('empresa').AsString;
      mtSalidasDeposito.FieldByName('centro_salida_das').AsString:= QSalidasDeposito.FieldByname('centro').AsString;
      mtSalidasDeposito.FieldByName('n_albaran_das').AsInteger:= QSalidasDeposito.FieldByname('albaran').AsInteger;
      mtSalidasDeposito.FieldByName('fecha_das').AsDateTime:= QSalidasDeposito.FieldByname('fecha').AsDateTime;
      mtSalidasDeposito.FieldByName('operador_transporte_das').AsInteger:= QSalidasDeposito.FieldByname('operador').AsInteger;
      mtSalidasDeposito.FieldByName('transporte_das').AsInteger:= QSalidasDeposito.FieldByname('transporte').AsInteger;
      mtSalidasDeposito.FieldByName('vehiculo_das').AsString:= QSalidasDeposito.FieldByname('vehiculo').AsString;
      mtSalidasDeposito.FieldByName('n_cmr_das').AsString:= QSalidasDeposito.FieldByname('cmr').AsString;
      mtSalidasDeposito.FieldByName('n_pedido_das').AsString:= QSalidasDeposito.FieldByname('pedido').AsString;
      mtSalidasDeposito.FieldByName('kilos_das').AsFloat:= QSalidasDeposito.FieldByname('kilos').AsFloat;
      mtSalidasDeposito.FieldByName('frigorifico_das').AsFloat:= bRoundTo( mtSalidasDeposito.FieldByName('kilos_das').AsFloat * rPrecio, 2 );
      mtSalidasDeposito.FieldByName('n_factura_das').AsString:= AFactura;
      try
        mtSalidasDeposito.Post;
        VKilosDeposito:= VKilosDeposito + mtSalidasDeposito.FieldByName('kilos_das').AsFloat;
        VImporteDeposito:= VImporteDeposito + mtSalidasDeposito.FieldByName('frigorifico_das').AsFloat;
      finally
        mtSalidasDeposito.Cancel;
      end;

      QSalidasDeposito.Delete;
    end;
    result:= True;
  end
  else
  begin
    ShowMessage('Sin salida del deposito.');
  end;
end;

procedure TDMCostePlataforma.Cancelar;
begin
  QSalidasDeposito.CancelUpdates;
  mtSalidasDeposito.Close;
  mtSalidasDeposito.Open;
end;

function TDMCostePlataforma.Aplicar: boolean;
begin
  Result:= False;

  if not mtSalidasDeposito.IsEmpty then
  begin
    mtSalidasDeposito.First;
    while not mtSalidasDeposito.Eof do
    begin
      ActualizarLinea;
      mtSalidasDeposito.Next;
    end;

    Result:= True;

    QSalidasDeposito.CancelUpdates;
    QSalidasDeposito.Close;
    QSalidasDeposito.Open;

    mtSalidasDeposito.Close;
    mtSalidasDeposito.Open;
  end
  else
  begin
    ShowMessage('No hay salidas del deposito selccionadas');
  end;
end;

procedure TDMCostePlataforma.ActualizarLinea;
begin
  with QUpdateLinea do
  begin
    ParamByName('importe').AsFloat:= mtSalidasDeposito.FieldByName('frigorifico_das').AsFloat;
    ParamByName('factura').AsString:= mtSalidasDeposito.FieldByName('n_factura_das').AsString;

    ParamByName('codigo').AsInteger:= mtSalidasDeposito.FieldByName('codigo_das').AsInteger;
    ParamByName('linea').AsInteger:= mtSalidasDeposito.FieldByName('linea_das').AsInteger;

    ParamByName('empresa').AsString:= mtSalidasDeposito.FieldByName('empresa_das').AsString;
    ParamByName('centro').AsString:= mtSalidasDeposito.FieldByName('centro_salida_das').AsString;
    ParamByName('albaran').AsInteger:= mtSalidasDeposito.FieldByName('n_albaran_das').AsInteger;
    ParamByName('fecha').AsDateTime:= mtSalidasDeposito.FieldByName('fecha_das').AsDateTime;
    ParamByName('cmr').AsString:= mtSalidasDeposito.FieldByName('n_cmr_das').AsString;

    ExecSQL;
    if RowsAffected <> 1 then
    begin
      ShowMessage('Error');
    end;
  end;
end;

function TDMCostePlataforma.PuedoSalir: boolean;
begin
  Result:= mtSalidasDeposito.IsEmpty;
end;

end.
