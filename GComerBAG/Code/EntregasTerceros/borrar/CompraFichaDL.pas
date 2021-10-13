unit CompraFichaDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLCompraFicha = class(TDataModule)
    qCompras: TQuery;
    dsCompras: TDataSource;
    qGastosEntregas: TQuery;
    qEntregasCompras: TQuery;
    qGastosCompras: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure qComprasAfterOpen(DataSet: TDataSet);
    procedure qComprasBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    function ObtenCompra( const AEmpresa, ACentro: string; const ACompra: Integer ): boolean;
  public
    { Public declarations }
  end;

  function PrevisualizarCompra( const AOwner: TComponent;
    const AEmpresa, ACentro: string; const ACompra: Integer ): Boolean;

implementation

{$R *.dfm}

uses
  CompraFichaQR;

var
  DLCompraFicha: TDLCompraFicha;

function PrevisualizarCompra( const AOwner: TComponent; const AEmpresa, ACentro: string; const ACompra: Integer ): Boolean;
begin
  DLCompraFicha:= TDLCompraFicha.Create( AOwner );
  try
    Result:= DLCompraFicha.ObtenCompra( AEmpresa, ACentro, ACompra );
    if Result then
    begin
      CompraFichaQR.VerFicha( AOwner );
    end;
  finally
    FreeAndNil( DLCompraFicha );
  end;
end;

procedure TDLCompraFicha.DataModuleCreate(Sender: TObject);
begin
  with qCompras do
  begin
    SQL.Clear;
    SQL.Add('select *');
    SQL.Add('from frf_compras');
    SQL.Add('where empresa_c = :empresa ');
    SQL.Add('and centro_c = :centro ');
    SQL.Add('and numero_c = :compra ');
    Prepare;
  end;
  with qGastoscompras do
  begin
    SQL.Clear;
    SQL.Add('select tipo_gc, ref_fac_gc, fecha_fac_gc, nota_gc, importe_gc ');
    SQL.Add('from frf_gastos_compras ');
    SQL.Add('where empresa_gc = :empresa_c ');
    SQL.Add('and centro_gc = :centro_c ');
    SQL.Add('and numero_gc = :numero_c ');
    SQL.Add('order by tipo_gc, ref_fac_gc ');
    Prepare;
  end;
  with qEntregasCompras do
  begin
    SQL.Clear;
    SQL.Add('select codigo_ec, albaran_ec, fecha_llegada_ec, transporte_ec, vehiculo_ec, producto_el, sum(kilos_el) kilos_el');
    SQL.Add('from frf_compras_entregas, frf_entregas_c, frf_entregas_l ');
    SQL.Add('where empresa_ce = :empresa_c ');
    SQL.Add('and centro_ce = :centro_c ');
    SQL.Add('and compra_ce = :numero_c ');
    SQL.Add('and codigo_ec = entrega_ce ');
    SQL.Add('and codigo_el = codigo_ec ');
    SQL.Add('group by codigo_ec, albaran_ec, fecha_llegada_ec, transporte_ec, vehiculo_ec, producto_el ');
    SQL.Add('order by codigo_ec, producto_el ');
    Prepare;
  end;

  with qGastosEntregas do
  begin
    SQL.Clear;
    SQL.Add('  select codigo_ge, tipo_ge, ref_fac_ge, fecha_fac_ge, nota_ge, importe_ge ');
    SQL.Add('from frf_compras_entregas, frf_gastos_entregas ');
    SQL.Add('where empresa_ce = :empresa_c ');
    SQL.Add('and centro_ce = :centro_c ');
    SQL.Add('and compra_ce = :numero_c ');
    SQL.Add('and codigo_ge = entrega_ce ');
    SQL.Add('and solo_lectura_ge = 0 ');
    SQL.Add('order by codigo_ge, tipo_ge, ref_fac_ge ');
    Prepare;
  end;
end;

procedure TDLCompraFicha.DataModuleDestroy(Sender: TObject);
begin
  with qCompras do
  begin
    Close;
    UnPrepare;
  end;
  with qGastosCompras do
  begin
    Close;
    UnPrepare;
  end;
  with qEntregasCompras do
  begin
    Close;
    UnPrepare;
  end;
  with qGastosEntregas do
  begin
    Close;
    UnPrepare;
  end;
end;

function TDLCompraFicha.ObtenCompra( const AEmpresa, ACentro: string; const ACompra: Integer ): boolean;
begin
  with qCompras do
  begin
    Close;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('compra').AsInteger:= ACompra;
    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TDLCompraFicha.qComprasAfterOpen(DataSet: TDataSet);
begin
  qGastosCompras.Open;
  qEntregasCompras.Open;
  qGastosEntregas.Open;
end;

procedure TDLCompraFicha.qComprasBeforeClose(DataSet: TDataSet);
begin
  qGastosCompras.Close;
  qEntregasCompras.Close;
  qGastosEntregas.Close;
end;

end.
