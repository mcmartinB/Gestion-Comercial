unit AlbaranAPedidoDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLAlbaranAPedido = class(TDataModule)
    QCabSalida: TQuery;
    DSCabEntradas: TDataSource;
    QLinSalida: TQuery;
    QCabPedido: TQuery;
    QLinPedido: TQuery;
    QNumeroPedido: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    iPedido: Integer;

    function  ExistePedido: Boolean;
    procedure CrearPedido( const AUnidadPedido: Integer );
    procedure PasarCabecera;
    procedure NumeroDePedido;
    procedure PasarDetalles( const AUnidadPedido: Integer );
    procedure PasaDetalle( const ALinea, AUnidadPedido: Integer );

  public
    { Public declarations }
    (*
    function AlbaranAPedidoExecute( const AEmpresa, ACliente: string; const AFechaIni, AFechaFin: TDateTime;
                                    const ACentro, APedido: string; const AAlbaran: Integer ): Integer;
    *)
    function AlbaranAPedidoExecute( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                                    const AAlbaran, AUnidadPedido: Integer ): Integer;
  end;

  function AlbaranAPedidoExecute( const AOwner: TComponent; const AEmpresa, ACentro: string;
                                  const AFecha: TDateTime; const AAlbaran, AUnidadPedido: Integer ): Integer;

implementation

{$R *.dfm}

uses
  UDMBaseDatos;

var
  DLAlbaranAPedido: TDLAlbaranAPedido;


function AlbaranAPedidoExecute( const AOwner: TComponent; const AEmpresa, ACentro: string;
                                const AFecha: TDateTime; const AAlbaran, AUnidadPedido: Integer ): Integer;
begin
  DLAlbaranAPedido:= TDLAlbaranAPedido.Create( AOwner );
  try
    Result:= DLAlbaranAPedido.AlbaranAPedidoExecute( AEmpresa, ACentro, AFecha, AAlbaran, AUnidadPedido);
  finally
    FreeAndNil( DLAlbaranAPedido );
  end;
end;

procedure TDLAlbaranAPedido.DataModuleCreate(Sender: TObject);
begin
  with QCabSalida do
  begin
    Sql.Clear;
    SQL.Add(' select empresa_sc, centro_salida_sc, fecha_sc, n_albaran_sc, n_pedido_sc, cliente_sal_sc, dir_sum_sc, moneda_sc ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = :centro ');
    SQL.Add(' and n_albaran_sc = :albaran ');
    SQL.Add(' and fecha_sc = :fecha ');
    Prepare;
  end;

  with QLinSalida do
  begin
    Sql.Clear;
    SQL.Add(' select empresa_sl, centro_salida_sl, producto_sl, envase_sl, categoria_sl, calibre_sl, color_sl, unidad_precio_sl, ');
    SQL.Add('        sum(cajas_sl) cajas_sl, ');
    SQL.Add('        sum( cajas_sl * unidades_caja_sl ) unidades_sl, ');
    SQL.Add('        sum(kilos_sl) kilos_sl ');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa_sc ');
    SQL.Add(' and centro_salida_sl = :centro_salida_sc ');
    SQL.Add(' and n_albaran_sl = :n_albaran_sc ');
    SQL.Add(' and fecha_sl = :fecha_sc ');
    SQL.Add(' group by empresa_sl, centro_salida_sl, producto_sl, envase_sl, categoria_sl, calibre_sl, color_sl, unidad_precio_sl ');
    Prepare;
  end;

  with QCabPedido do
  begin
    Sql.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_pedido_cab ');
    SQL.Add(' where empresa_pdc = :empresa_sc ');
    SQL.Add(' and centro_pdc = :centro_salida_sc ');
    SQL.Add(' and cliente_pdc = :cliente_sal_sc ');
    SQL.Add(' and ref_pedido_pdc = :n_pedido_sc ');
    Prepare;
  end;

  with QLinPedido do
  begin
    Sql.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_pedido_det ');
    Prepare;
  end;

  with QNumeroPedido do
  begin
    Sql.Clear;
    SQL.Add(' select nvl(max(pedido_pdc),0) + 1 num_pedido ');
    SQL.Add(' from frf_pedido_cab ');
    Prepare;
  end;
end;

procedure TDLAlbaranAPedido.DataModuleDestroy(Sender: TObject);
begin
  with QNumeroPedido do
  begin
    if Prepared then
      UnPrepare;
  end;

  with QLinPedido do
  begin
    if Prepared then
      UnPrepare;
  end;

  with QCabPedido do
  begin
    if Prepared then
      UnPrepare;
  end;

  with QLinSalida do
  begin
    if Prepared then
      UnPrepare;
  end;

  with QCabSalida do
  begin
    if Prepared then
      UnPrepare;
  end;
end;

function TDLAlbaranAPedido.AlbaranAPedidoExecute(
                             const AEmpresa, ACentro: string; const AFecha: TDateTime;
                             const AAlbaran, AUnidadPedido: Integer ): Integer;
begin
  with QCabSalida do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('albaran').AsInteger:= AAlbaran;
    Open;
    if IsEmpty then
    begin
      Result:= 0;
    end
    else
    begin
      if ExistePedido then
      begin
        Result:= -1;
      end
      else
      begin
        Result:= 1;
        CrearPedido( AUnidadPedido );
      end
    end;
    Close;
  end;
end;

function TDLAlbaranAPedido.ExistePedido: Boolean;
begin
  QCabPedido.Open;
  if QCabPedido.IsEmpty then
  begin
    Result:= False;
  end
  else
  begin
    Result:= True;
    QCabPedido.Close;
  end;
end;

procedure TDLAlbaranAPedido.CrearPedido( const AUnidadPedido: Integer );
begin
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    DMBaseDatos.DBBaseDatos.StartTransaction;
    try
      PasarCabecera;
      PasarDetalles( AUnidadPedido );
      DMBaseDatos.DBBaseDatos.Commit;
    except
      DMBaseDatos.DBBaseDatos.Rollback;
      raise;
    end;
  end;
end;

procedure TDLAlbaranAPedido.PasarCabecera;
begin
  NumeroDePedido;
  with QCabPedido do
  begin
    Insert;
    FieldByName('empresa_pdc').AsString := QCabSalida.FieldByName('empresa_sc').AsString;
    FieldByName('centro_pdc').AsString := QCabSalida.FieldByName('centro_salida_sc').AsString;
    FieldByName('pedido_pdc').AsInteger := iPedido;
    FieldByName('fecha_pdc').AsDateTime:= QCabSalida.FieldByName('fecha_sc').AsDateTime;
    FieldByName('ref_pedido_pdc').AsString := QCabSalida.FieldByName('n_pedido_sc').AsString;
    FieldByName('cliente_pdc').AsString := QCabSalida.FieldByName('cliente_sal_sc').AsString;
    FieldByName('dir_suministro_pdc').AsString :=  QCabSalida.FieldByName('dir_sum_sc').AsString;
    FieldByName('moneda_pdc').AsString := QCabSalida.FieldByName('moneda_sc').AsString;
    FieldByName('observaciones_pdc').AsString := 'CREADO AUTOMATICAMENTE, ALBARÁN ' + QCabSalida.FieldByName('n_albaran_sc').AsString;
    FieldByName('finalizado_pdc').AsInteger := 1;
    FieldByName('anulado_pdc').AsInteger := 0;
    Post;
    Close;
  end;
end;

procedure TDLAlbaranAPedido.NumeroDePedido;
begin
  QNumeroPedido.Open;
  iPedido:= QNumeroPedido.FieldByName('num_pedido').AsInteger;
  QNumeroPedido.Close;
end;

procedure TDLAlbaranAPedido.PasarDetalles( const AUnidadPedido: integer );
var
  iLinea: Integer;
begin
  QLinSalida.Open;
  QLinPedido.Open;
  iLinea:= 1;
  while not QLinSalida.Eof do
  begin
    PasaDetalle( iLinea, AUnidadPedido );
    Inc( iLinea );
    QLinSalida.Next;
  end;
  QLinSalida.Close;
  QLinPedido.Close;
end;

procedure TDLAlbaranAPedido.PasaDetalle( const ALinea, AUnidadPedido: Integer );
begin
  with QLinPedido do
  begin
    Insert;
    FieldByName('empresa_pdd').AsString := QLinSalida.FieldByName('empresa_sl').AsString;
    FieldByName('centro_pdd').AsString := QLinSalida.FieldByName('centro_salida_sl').AsString;
    FieldByName('pedido_pdd').AsInteger := iPedido;
    FieldByName('linea_pdd').AsInteger:= ALinea;
    FieldByName('producto_pdd').AsString := QLinSalida.FieldByName('producto_sl').AsString;
    FieldByName('envase_pdd').AsString := QLinSalida.FieldByName('envase_sl').AsString;
    FieldByName('categoria_pdd').AsString :=  QLinSalida.FieldByName('categoria_sl').AsString;
    FieldByName('calibre_pdd').AsString := QLinSalida.FieldByName('calibre_sl').AsString;
    FieldByName('color_pdd').AsString := QLinSalida.FieldByName('color_sl').AsString;
    case AUnidadPedido of
      0: //Unidad de facturacion
      begin
        FieldByName('unidad_pdd').AsString := Copy( QLinSalida.FieldByName('unidad_precio_sl').AsString, 1, 1 );
        if FieldByName('unidad_pdd').AsString = 'K' then
          FieldByName('unidades_pdd').AsInteger := QLinSalida.FieldByName('kilos_sl').AsInteger
        else
        if FieldByName('unidad_pdd').AsString = 'U' then
          FieldByName('unidades_pdd').AsInteger := QLinSalida.FieldByName('unidades_sl').AsInteger
        else
        if FieldByName('unidad_pdd').AsString = 'C' then
          FieldByName('unidades_pdd').AsInteger := QLinSalida.FieldByName('cajas_sl').AsInteger
        else
          FieldByName('unidades_pdd').AsInteger := 0;
      end;
      1: //Cajas
      begin
        FieldByName('unidad_pdd').AsString:= 'C';
        FieldByName('unidades_pdd').AsInteger := QLinSalida.FieldByName('cajas_sl').AsInteger;
      end;
      2: //kilos
      begin
        FieldByName('unidad_pdd').AsString:= 'K';
        FieldByName('unidades_pdd').AsInteger := QLinSalida.FieldByName('kilos_sl').AsInteger;
      end;
      3: //Unidades
      begin
        FieldByName('unidad_pdd').AsString:= 'U';
        FieldByName('unidades_pdd').AsInteger := QLinSalida.FieldByName('unidades_sl').AsInteger;
      end;
      else
      begin //Por defecto kilos
        FieldByName('unidad_pdd').AsString:= 'K';
        FieldByName('unidades_pdd').AsInteger := QLinSalida.FieldByName('kilos_sl').AsInteger
      end;
    end;
    Post;
  end;
end;

end.
