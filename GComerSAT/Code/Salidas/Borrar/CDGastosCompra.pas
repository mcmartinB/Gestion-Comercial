unit CDGastosCompra;

interface

uses
  SysUtils, Classes, kbmMemTable, DB, DBTables;

type
  TDGastosCompra = class(TDataModule)
    QUpdateStatus: TQuery;
    QSelectLineas: TQuery;
    DSSelectLineas: TDataSource;
    kbmGastos: TkbmMemTable;
    DSGastos: TDataSource;
    QSelectEntregasTodas: TQuery;
    QSumEntregasTodas: TQuery;
    QSelectEntregasProducto: TQuery;
    QSumEntregasProducto: TQuery;
    QNumLinea: TQuery;
    QGastosEntregas: TQuery;
    QBorrarGastosEntregas: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure QSelectLineasAfterOpen(DataSet: TDataSet);
    procedure QSelectLineasBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    QSelectEntregasAux: TQuery;
    sCompra: string;
    sCodigoGasto: string;
    iLineaGasto: integer;

    function GastosLineaFactura( var AMsg: string ): boolean;
    function GrabarGastoTemporal( const ACodigo, AProducto: string; const AImporte: real; var AMsg: string ): boolean;
    function ActualizarGastosBD( const AActualizarEstado: Boolean; var AMsg: string ): boolean;
    function ActualizarEstadoCompra( var AMsg: string ): boolean;
    function CopiarLosDatosTablaTempral( var AMsg: string ): boolean;
    function SelectNumLinea( var AMsg: string ): integer;
    function GrabarGastoBD( const ALinea: integer; var AMsg: string ): boolean;
    function BorrarGastosAntiguosEntrega: boolean;

  public
    { Public declarations }
    function GastosFacturaSeleccionada( const AEmpresa, ACentro: string; const ANumero: Integer;
                                        const AActualizarEstado: Boolean; var AMsg: string  ): boolean;
  end;

var
  DGastosCompra: TDGastosCompra;

implementation

uses
  bMath, Dialogs, UDMBaseDatos;

{$R *.dfm}

procedure TDGastosCompra.DataModuleCreate(Sender: TObject);
begin
  with QSelectLineas do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_gc, producto_gc, importe_gc, ref_fac_gc, fecha_fac_gc, nota_gc, pagado_gc, ');
    SQL.Add('        empresa_gc, centro_gc, numero_gc ');
    SQL.Add(' from frf_gastos_compras ');
    SQL.Add(' where empresa_gc = :empresa_c ');
    SQL.Add(' and centro_gc = :centro_c ');
    SQL.Add(' and numero_gc = :numero_c ');
  end;

  with QUpdateStatus do
  begin
    SQL.Clear;
    SQL.Add(' update frf_compras ');
    SQL.Add(' set status_gastos_c = 1 ');
    SQL.Add(' where empresa_c = :empresa_gc ');
    SQL.Add(' and centro_c = :centro_gc ');
    SQL.Add(' and numero_c = :numero_gc ');
  end;

  with QSelectEntregasTodas do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_el, producto_el, sum(kilos_el) kilos_el ');
    SQL.Add(' from frf_compras_entregas, frf_entregas_l ');

    SQL.Add(' where empresa_ce = :empresa_gc ');
    SQL.Add(' and centro_ce = :centro_gc ');
    SQL.Add(' and compra_ce = :numero_gc ');
    SQL.Add(' and codigo_el = entrega_ce ');

    SQL.Add(' group by codigo_el, producto_el ');
    SQL.Add(' order by codigo_el ');

  end;

  with QSumEntregasTodas do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_el) kilos_el');
    SQL.Add(' from frf_compras_entregas, frf_entregas_l ');

    SQL.Add(' where empresa_ce = :empresa_gc ');
    SQL.Add(' and centro_ce = :centro_gc ');
    SQL.Add(' and compra_ce = :numero_gc ');
    SQL.Add(' and codigo_el = entrega_ce ');
  end;

  with QSelectEntregasProducto do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_el, producto_el, sum(kilos_el) kilos_el');
    SQL.Add(' from frf_compras_entregas, frf_entregas_l ');

    SQL.Add(' where empresa_ce = :empresa_gc ');
    SQL.Add(' and centro_ce = :centro_gc ');
    SQL.Add(' and compra_ce = :numero_gc ');
    SQL.Add(' and codigo_el = entrega_ce ');
    SQL.Add(' and producto_el = :producto_gc ');

    SQL.Add(' group by codigo_el, producto_el ');
    SQL.Add(' order by codigo_el ');
  end;

  with QSumEntregasProducto do
  begin
    SQL.Clear;
    SQL.Add(' select sum(kilos_el) kilos_el');
    SQL.Add(' from frf_compras_entregas, frf_entregas_l ');

    SQL.Add(' where empresa_ce = :empresa_gc ');
    SQL.Add(' and centro_ce = :centro_gc ');
    SQL.Add(' and compra_ce = :numero_gc ');
    SQL.Add(' and codigo_el = entrega_ce ');
    SQL.Add(' and producto_el = :producto_gc ');
  end;

  with QNumLinea do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ge, max(linea_ge) linea ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :entrega ');
    SQL.Add(' group by codigo_ge ');
  end;

  with QGastosEntregas do
  begin
    RequestLive:= True;
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_gastos_entregas ');
  end;

  with QBorrarGastosEntregas do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where nota_ge = :compra ');
    SQL.Add(' and solo_lectura_ge = 1 ');
  end;

  kbmGastos.FieldDefs.Clear;
  kbmGastos.FieldDefs.Add('codigo_ge', ftString, 12, False);
  kbmGastos.FieldDefs.Add('linea_ge', ftInteger, 0, False);
  kbmGastos.FieldDefs.Add('tipo_ge', ftString, 3, False);
  kbmGastos.FieldDefs.Add('producto_ge', ftString, 1, False);
  kbmGastos.FieldDefs.Add('importe_ge', ftFloat, 0, False);
  kbmGastos.FieldDefs.Add('ref_fac_ge', ftString, 10, False);
  kbmGastos.FieldDefs.Add('fecha_fac_ge', ftDate, 0, False);
  kbmGastos.FieldDefs.Add('nota_ge', ftString, 30, False);
  kbmGastos.FieldDefs.Add('pagado_ge', ftInteger, 0, False);

  kbmGastos.IndexFieldNames:= 'codigo_ge;tipo_ge';
  kbmGastos.SortFields:= 'codigo_ge;tipo_ge';
  kbmGastos.CreateTable;
end;

procedure TDGastosCompra.QSelectLineasAfterOpen(DataSet: TDataSet);
begin
  QSelectEntregasProducto.Open;
  QSumEntregasProducto.Open;
  QSelectEntregasTodas.Open;
  QSumEntregasTodas.Open;
end;

procedure TDGastosCompra.QSelectLineasBeforeClose(DataSet: TDataSet);
begin
  QSumEntregasTodas.Close;
  QSelectEntregasTodas.Close;
  QSumEntregasProducto.Close;
  QSelectEntregasProducto.Close;
end;

function TDGastosCompra.GastosFacturaSeleccionada( const AEmpresa, ACentro: string;
                           const ANumero: Integer; const AActualizarEstado: Boolean;
                           var AMsg: string ): boolean;
begin
  sCompra:= '(' + AEmpresa + ', ' + ACentro + ', ' + IntToStr( ANumero ) + ')';
  kbmGastos.Open;

  QSelectLineas.ParamByName('empresa_c').AsString:= AEmpresa;
  QSelectLineas.ParamByName('centro_c').AsString:= ACentro;
  QSelectLineas.ParamByName('numero_c').AsInteger:= ANumero;
  QSelectLineas.Open;

  if QSelectLineas.IsEmpty then
  begin
    result:= BorrarGastosAntiguosEntrega;
    if result then
    begin
     AMsg:= '* OK : Gastos compra borrados correctamente. ' + sCompra;
     Exit;
    end
    else
    begin
      AMsg:= 'ERROR: Compra sin facturas. ' + sCompra;
    end;
  end
  else
  begin
    result:= True;
    while ( not QSelectLineas.Eof ) and result do
    begin
      result:= GastosLineaFactura( AMsg );
      QSelectLineas.Next;
    end;
  end;
  if result then
  begin
    result:= ActualizarGastosBD( AActualizarEstado, AMsg );
  end;

  QSelectLineas.Close;
  kbmGastos.Close;

  if result then
  begin
    AMsg:= '* OK :Gastos compra asignados correctamente. ' + sCompra;
  end;
end;

function TDGastosCompra.GastosLineaFactura( var AMsg: string ): boolean;
var
  sCodigo, sProducto: string;
  rKilosTotal, rImporteTotal, rImporteAcum, rImporte: real;
  rKilosAux, rKilosAcum: Real;
begin
  result:= False;

  if QSelectLineas.FieldByName('producto_gc').AsString = '' then
  begin
    rKilosTotal:= QSumEntregasTodas.FieldByname('kilos_el').AsFloat;
    QSelectEntregasAux:= QSelectEntregasTodas;
  end
  else
  begin
    rKilosTotal:= QSumEntregasProducto.FieldByname('kilos_el').AsFloat;
    QSelectEntregasAux:= QSelectEntregasProducto;
  end;

  if rKilosTotal <> 0 then
  begin
    rImporteTotal:= QSelectLineas.FieldByname('importe_gc').AsFloat;
    rImporteAcum:= 0;
    rKilosAcum:= 0;
    QSelectEntregasAux.First;
    while not QSelectEntregasAux.Eof do
    begin
      sCodigo:= QSelectEntregasAux.FieldByName('codigo_el').AsString;
      sProducto:= QSelectEntregasAux.FieldByName('producto_el').AsString;
      rKilosAux:= QSelectEntregasAux.FieldByName('kilos_el').AsFloat;
      rKilosAcum:= rKilosAcum + rKilosAux;
      rImporte:=  bRoundTo( ( rImporteTotal *  rKilosAux) / rKilosTotal, -2 );
      rImporteAcum:= rImporteAcum + rImporte;
      QSelectEntregasAux.Next;
      if QSelectEntregasAux.Eof then
      begin
        rImporte:= bRoundTo( ( rImporte + ( rImporteTotal - rImporteAcum ) ), -2 );
      end;
      result:= GrabarGastoTemporal( sCodigo, sProducto, rImporte, AMsg );
    end;
  end
  else
  begin
    if QSelectEntregasAux.IsEmpty then
    begin
      if QSelectLineas.FieldByName('producto_gc').AsString = '' then
      begin
        AMsg:= 'ERROR: Compra sin entregas. ' + sCompra;
      end
      else
      begin
        AMsg:= 'ERROR: Compra sin entregas para el producto "' + QSelectLineas.FieldByName('producto_gc').AsString + '". ' + sCompra;
      end;
    end
    else
    if QSelectLineas.FieldByName('producto_gc').AsString = '' then
    begin
      AMsg:= 'ERROR: Entrega sin kilos. (' + QSelectEntregasAux.FieldByName('codigo_el').AsString +')';
    end
    else
    begin
      AMsg:= 'ERROR: Entrega sin kilos para el producto "' +
        QSelectLineas.FieldByName('producto_gc').AsString + '". (' + QSelectEntregasAux.FieldByName('codigo_el').AsString + ')';
    end;
  end;
end;

function TDGastosCompra.GrabarGastoTemporal( const ACodigo, AProducto: string; const AImporte: real; var AMsg: string  ): boolean;
begin
  kbmGastos.Insert;
  kbmGastos.FieldByName('codigo_ge').AsString:= ACodigo;
  kbmGastos.FieldByName('linea_ge').AsInteger:= 0;
  kbmGastos.FieldByName('tipo_ge').AsString:= QSelectLineas.FieldByName('tipo_gc').AsString;
  kbmGastos.FieldByName('producto_ge').AsString:= AProducto;
  kbmGastos.FieldByName('importe_ge').AsFloat:= AImporte;
  kbmGastos.FieldByName('ref_fac_ge').AsString:= QSelectLineas.FieldByName('ref_fac_gc').AsString;
  kbmGastos.FieldByName('fecha_fac_ge').AsDateTime:= QSelectLineas.FieldByName('fecha_fac_gc').AsDateTime;
  kbmGastos.FieldByName('nota_ge').AsString:= 'COMPRA: ' + sCompra; //QSelectLineas.FieldByName('numero_gc').AsString;;
  kbmGastos.FieldByName('pagado_ge').AsInteger:= QSelectLineas.FieldByName('pagado_gc').AsInteger;

  try
    kbmGastos.Post;
    AMsg:= 'OK';
    result:= True;
  except
    AMsg:= 'ERROR: Al grabar en la tabla temporal (' + ACodigo + ', ' +
              QSelectLineas.FieldByName('tipo_gc').AsString + ', ' +
              QSelectLineas.FieldByName('producto_gc').AsString + ', ' +
              FloatTostr( AImporte ) + ')';
    kbmGastos.Cancel;
    result:= False;
  end;
end;

function TDGastosCompra.BorrarGastosAntiguosEntrega: boolean;
begin
  QBorrarGastosEntregas.ParamByName('compra').AsString:= 'COMPRA: ' + sCompra;
  QBorrarGastosEntregas.ExecSQL;
  result:= QBorrarGastosEntregas.RowsAffected > 0;
end;

function TDGastosCompra.ActualizarGastosBD( const AActualizarEstado: Boolean; var AMsg: string  ): boolean;
begin
  sCodigoGasto:= '';
  iLineaGasto:= 0;
  kbmGastos.Sort([]);
  try
    if not DMBaseDatos.DBBaseDatos.InTransaction then
    begin
      DMBaseDatos.DBBaseDatos.StartTransaction;
      if AActualizarEstado then
        result:= ActualizarEstadoCompra( AMsg )
      else
        result:= True;
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
                kbmGastos.FieldByName('codigo_ge').AsString + ', ' +
                kbmGastos.FieldByName('tipo_ge').AsString + ', ' +
                kbmGastos.FieldByName('producto_ge').AsString + ', ' +
                kbmGastos.FieldByName('importe_ge').AsString  + ')';
        end;
      end;
    end
    else
    begin
      AMsg:= 'Transacción ya abierta. ' + sCompra;
      result:= false;
    end;
  except
    AMsg:= 'ERROR: Problemas al grabar el gasto en la base de datos. (' +
              kbmGastos.FieldByName('codigo_ge').AsString + ', ' +
              kbmGastos.FieldByName('tipo_ge').AsString + ', ' +
              kbmGastos.FieldByName('producto_ge').AsString + ', ' +
              kbmGastos.FieldByName('importe_ge').AsString  + ')';
    DMBaseDatos.DBBaseDatos.Rollback;
    result:= False;
  end;
end;

function TDGastosCompra.ActualizarEstadoCompra( var AMsg: string ): boolean;
begin
  try
    QUpdateStatus.ExecSQL;
    result:= True;
    AMsg:= 'OK';
  except
    result:= False;
    AMsg:= 'ERROR: Al actualizar el estado de la compra. ' + sCompra;
  end;
end;

function TDGastosCompra.CopiarLosDatosTablaTempral( var AMsg: string ): boolean;
var
  iLinea: integer;
begin
  if Not kbmGastos.IsEmpty then
  begin
    result:= True;
    QGastosEntregas.Open;
    try
      kbmGastos.First;
      while ( not kbmGastos.Eof ) and result do
      begin
        iLinea:= SelectNumLinea( AMsg );
        if iLinea >= 0 then
        begin
          result:= GrabarGastoBD( iLinea, AMsg );
          kbmGastos.Next;
        end
        else
        begin
          result:= false;
        end;
      end;
    finally
      QGastosEntregas.Close;
    end;
  end
  else
  begin
    AMsg:= 'ERROR: Sin gastos para grabar en la tabla temporal. ' + sCompra;
    result:= False;
  end;
end;

function TDGastosCompra.SelectNumLinea( var AMsg: string ): integer;
begin
  if sCodigoGasto = kbmGastos.FieldByName('codigo_ge').AsString then
  begin
    AMsg:= 'OK';
    iLineaGasto:= iLineaGasto + 1;
    result:= iLineaGasto;
  end
  else
  begin
    QNumLinea.ParamByName('entrega').AsString:= kbmGastos.FieldByName('codigo_ge').AsString;
    try
      QNumLinea.Open;
      try
        iLineaGasto:= QNumLinea.FieldByName('linea').AsInteger + 1;
        result:= iLineaGasto;
        sCodigoGasto:= kbmGastos.FieldByName('codigo_ge').AsString;
        AMsg:= 'OK';
      finally
        QNumLinea.Close;
      end;
    except
      result:= -1;
      AMsg:= 'ERROR: Problemas al obtener el numero de linea para el gasto. (' + kbmGastos.FieldByName('codigo_ge').AsString + ', ' +
              kbmGastos.FieldByName('tipo_ge').AsString + ', ' +
              kbmGastos.FieldByName('producto_ge').AsString + ', ' +
              kbmGastos.FieldByName('importe_ge').AsString  + ')';
    end;
  end;
end;

function TDGastosCompra.GrabarGastoBD( const ALinea: integer; var AMsg: string ): boolean;
var
  sError: String;
begin
  sError:= '(' + kbmGastos.FieldByName('codigo_ge').AsString + ', ' +
              kbmGastos.FieldByName('tipo_ge').AsString + ', ' +
              kbmGastos.FieldByName('producto_ge').AsString + ', ' +
              kbmGastos.FieldByName('importe_ge').AsString  + ')';
  QGastosEntregas.Insert;
  QGastosEntregas.FieldByName('codigo_ge').AsString:= kbmGastos.FieldByName('codigo_ge').AsString;
  QGastosEntregas.FieldByName('linea_ge').AsInteger:= ALinea;
  QGastosEntregas.FieldByName('tipo_ge').AsString:= kbmGastos.FieldByName('tipo_ge').AsString;
  QGastosEntregas.FieldByName('producto_ge').AsString:= kbmGastos.FieldByName('producto_ge').AsString;
  QGastosEntregas.FieldByName('importe_ge').AsFloat:= kbmGastos.FieldByName('importe_ge').AsFloat;
  QGastosEntregas.FieldByName('ref_fac_ge').AsString:= kbmGastos.FieldByName('ref_fac_ge').AsString;
  QGastosEntregas.FieldByName('fecha_fac_ge').AsString:= kbmGastos.FieldByName('fecha_fac_ge').AsString;
  QGastosEntregas.FieldByName('nota_ge').AsString:= kbmGastos.FieldByName('nota_ge').AsString;
  QGastosEntregas.FieldByName('pagado_ge').AsInteger:= kbmGastos.FieldByName('pagado_ge').AsInteger;
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
