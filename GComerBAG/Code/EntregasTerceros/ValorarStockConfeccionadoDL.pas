unit ValorarStockConfeccionadoDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDLValorarStockConfeccionado = class(TDataModule)
    QListadoStock: TQuery;
    kmtStockValorado: TkbmMemTable;
    kmtGastos: TkbmMemTable;
    kmtStockValoradoDet: TkbmMemTable;
    dsStockValorado: TDataSource;
    qryImporteGastos: TQuery;
    qryKilosGastos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    iCodCab: Integer;

    procedure MontaTablaListado( const AFecha: TDatetime );
    procedure AnyadeRegistro( const APrecioMedio: Real );
    procedure AltaPalet( const ACodCab: Integer; const APrecioMedio: Real );
    procedure PreparaQueryStockActual( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                                      const AProducto, ACliente, AEnvase: string );

    function  CosteMedioFruta( const AEmpresa, AProducto: string; const AFecha: TDateTime ): real;
    function  CalcularCosteFruta( const AEmpresa, AProducto: string; const AFecha: TDateTime  ): real;
    procedure PutCosteFrutaAux( const AEmpresa, AProducto: string; const APrecioMedio: Real );
    function  GetCosteFrutaAux( const AEmpresa, AProducto: string; var VPrecioMedio: Real ): boolean;

  public
    { Public declarations }
    function DatosQueryStock( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                              const AProducto, ACliente, AEnvase: string ): boolean;
  end;

implementation

{$R *.dfm}

uses variants, UDMConfig, bMath;

procedure TDLValorarStockConfeccionado.DataModuleCreate(Sender: TObject);
begin
  kmtStockValorado.FieldDefs.Clear;
  kmtStockValorado.FieldDefs.Add('codigo_cab', ftInteger, 0, False);

  kmtStockValorado.FieldDefs.Add('empresa', ftString, 3, False);
  kmtStockValorado.FieldDefs.Add('producto', ftString, 3, False);
  kmtStockValorado.FieldDefs.Add('producto_base', ftString, 3, False);
  //LResumenRemesas
  kmtStockValorado.FieldDefs.Add('centro', ftString, 1, False);
  kmtStockValorado.FieldDefs.Add('fecha_alta', ftDate, 0, False);
  kmtStockValorado.FieldDefs.Add('fecha_status', ftDate, 0, False);
  kmtStockValorado.FieldDefs.Add('status', ftString, 1, False);

  kmtStockValorado.FieldDefs.Add('kilos_c', ftFloat, 0, False);
  kmtStockValorado.FieldDefs.Add('cajas_c', ftInteger, 0, False);
  kmtStockValorado.FieldDefs.Add('unidades_c', ftInteger, 0, False);
  kmtStockValorado.FieldDefs.Add('palets_c', ftInteger, 0, False);
  kmtStockValorado.FieldDefs.Add('coste_c', ftFloat, 0, False);

  kmtStockValorado.IndexFieldNames:= 'codigo_cab';
  kmtStockValorado.CreateTable;
  kmtStockValorado.Open;

  kmtStockValoradoDet.FieldDefs.Clear;
  kmtStockValoradoDet.FieldDefs.Add('codigo_det', ftInteger, 0, False);

  kmtStockValoradoDet.FieldDefs.Add('ean128', ftString, 20, False);
  kmtStockValoradoDet.FieldDefs.Add('ean13', ftString, 14, False);
  kmtStockValoradoDet.FieldDefs.Add('cliente', ftString, 3, False);
  kmtStockValoradoDet.FieldDefs.Add('palet', ftString, 3, False);
  kmtStockValoradoDet.FieldDefs.Add('envase', ftString, 9, False);

  kmtStockValoradoDet.FieldDefs.Add('kilos_d', ftFloat, 0, False);
  kmtStockValoradoDet.FieldDefs.Add('cajas_d', ftInteger, 0, False);
  kmtStockValoradoDet.FieldDefs.Add('unidades_d', ftInteger, 0, False);
  kmtStockValoradoDet.FieldDefs.Add('coste_d', ftFloat, 0, False);

  kmtStockValoradoDet.IndexFieldNames:= 'codigo_det;ean128;ean13';
  kmtStockValoradoDet.CreateTable;
  kmtStockValoradoDet.Open;

  kmtGastos.FieldDefs.Clear;
  kmtGastos.FieldDefs.Add('empresa', ftString, 3, False);
  kmtGastos.FieldDefs.Add('producto', ftString, 3, False);
  kmtGastos.FieldDefs.Add('precio_medio', ftFloat, 0, False);
  kmtGastos.IndexFieldNames:= 'empresa;producto';
  kmtGastos.CreateTable;
  kmtGastos.Open;

  with qryImporteGastos do
  begin
    SQL.Clear;
//    SQL.Add('select sum( case when producto_ge = producto_ec then case when  ( tipo_ge = 70 or tipo_ge = 70 ) then 0 else importe_ge end else 0 end ) importe_producto,');
//    SQL.Add('       sum( case when producto_ge is null then case when  ( tipo_ge = 70 or tipo_ge = 70 ) then 0 else importe_ge end else 0 end ) importe_todos');
    SQL.Add('select sum( case when producto_ge = producto_ec then case when  ( tipo_ge = ''014'' or tipo_ge = ''014'' ) then 0 else importe_ge end else 0 end ) importe_producto,');
    SQL.Add('       sum( case when producto_ge is null then case when  ( tipo_ge = ''014'' or tipo_ge = ''014'' ) then 0 else importe_ge end else 0 end ) importe_todos');
    SQL.Add('from  frf_entregas_c, frf_gastos_entregas');
    SQL.Add('where empresa_ec = :empresa');
    SQL.Add('and producto_ec = :producto');
    SQL.Add('and fecha_llegada_ec between :fechaini and :fechafin');
    SQL.Add('and codigo_ge = codigo_ec');
  end;

  with qryKilosGastos do
  begin
    SQL.Clear;
    SQL.Add('select sum( case when producto_el = producto_ec then kilos_el else 0 end ) kilos_producto, ');
    SQL.Add('       sum( kilos_el ) kilos_todos ');
    SQL.Add('from  frf_entregas_c, frf_entregas_l ');
    SQL.Add('where empresa_ec = :empresa ');
    SQL.Add('and producto_ec = :producto ');
    SQL.Add('and fecha_llegada_ec between :fechaini and :fechafin ');
    SQL.Add('and codigo_el = codigo_ec ');
  end;
end;

procedure TDLValorarStockConfeccionado.PreparaQueryStockActual( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                          const AProducto, ACliente, AEnvase: string );
begin
  with QListadoStock do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_apcc, centro_apcc, producto_apcd, ');
    SQL.Add('        date(fecha_alta_apcc) fecha_alta_apcc, ');
    SQL.Add('        status_apcc,  case when status_apcc = ''V'' then date(fecha_volcado_apcc) ');
    SQL.Add('                           else ( case when fecha_carga_apcc is null then date(previsto_carga_apcc) ');
    SQL.Add('                                       else date(fecha_carga_apcc) end ) end fecha_status_apc, ');
    SQL.Add('        cliente_apcc, ');
    SQL.Add('        ean128_apcc, tipo_palet_apcc, ean13_apcd, envase_apcd, ');
    SQL.Add('        cajas_apcd, unidades_apcd, peso_apcd, ');
    SQL.Add('        ( select peso_neto_e from frf_envases where envase_apcd = envase_e ) peso_medio ');

    SQL.Add(' from alm_palet_pc_c join alm_palet_pc_d on ( empresa_apcc = empresa_apcd and centro_apcc = centro_apcd and ean128_apcc = ean128_apcd ) ');

    SQL.Add(' where status_apcc <> ''B'' ');
    //SQL.Add('   and ( (date(fecha_alta_apcc)<= :fecha and date(fecha_alta_apcc)>= :fecha_ini and status_apcc= ''S'') ');
    SQL.Add('   and ( (date(fecha_alta_apcc)<= :fecha and status_apcc= ''S'') ');
    SQL.Add('          or ');
    SQL.Add('         (date(fecha_alta_apcc)<= :fecha AND (date(fecha_carga_apcc)> :fecha or date(fecha_volcado_apcc) > :fecha )) ');
    SQL.Add('       ) ');

    if AEmpresa <> '' then
      SQL.Add(' AND empresa_apcc = :empresa ');
    if ACentro <> '' then
      SQL.Add(' AND centro_apcc = :centro ');
    if AProducto <> '' then
      SQL.Add('   AND producto_apcd = :producto ');
    if ACliente <> '' then
      SQL.Add('   AND cliente_apcc = :cliente ');
    if AEnvase <> '' then
      SQL.Add('   AND envase_apcd = :envase ');

    SQL.Add(' order by empresa_apcc, centro_apcc, producto_apcd, fecha_alta_apcc, status_apcc, cliente_apcc ');
  end;
end;

function TDLValorarStockConfeccionado.DatosQueryStock( const AEmpresa, ACentro: string; const AFecha: TDateTime;
                          const AProducto, ACliente, AEnvase: string ): boolean;
begin
  PreparaQueryStockActual( AEmpresa, ACentro, AFEcha, AProducto, ACliente, AEnvase );
  with QListadoStock do
  begin
    ParamByName('fecha').AsDateTime:= AFEcha;
    //ParamByName('fecha_ini').AsDateTime:= AFEcha - 30;

    if AEmpresa <> '' then
      ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    if AEnvase <> '' then
      ParamByName('envase').AsString:= AEnvase;

    Open;

    if not IsEmpty then
    begin
      iCodCab:= 0;
      MontaTablaListado( AFecha );
      result:= True;
    end
    else
    begin
      result:= False;
    end;
  end;
end;

procedure TDLValorarStockConfeccionado.AltaPalet( const ACodCab: Integer; const APrecioMedio: Real );
var
  rAux: Real;
begin
  if QListadoStock.FieldByName('peso_apcd').AsFloat <> 0 then
    rAux:= QListadoStock.FieldByName('peso_apcd').AsFloat
  else
    rAux:= ( QListadoStock.FieldByName('peso_medio').AsFloat *
             QListadoStock.FieldByName('cajas_apcd').AsFloat );

  kmtStockValoradoDet.Insert;
  kmtStockValoradoDet.FieldByName('codigo_det').AsInteger:= ACodCab;
  kmtStockValoradoDet.FieldByName('ean128').AsString:= QListadoStock.FieldByName('ean128_apcc').AsString;
  kmtStockValoradoDet.FieldByName('ean13').AsString:= QListadoStock.FieldByName('ean13_apcd').AsString;
  kmtStockValoradoDet.FieldByName('cliente').AsString:= QListadoStock.FieldByName('cliente_apcc').AsString;
  kmtStockValoradoDet.FieldByName('palet').AsString:= QListadoStock.FieldByName('tipo_palet_apcc').AsString;
  kmtStockValoradoDet.FieldByName('envase').AsString:= QListadoStock.FieldByName('envase_apcd').AsString;
  kmtStockValoradoDet.FieldByName('kilos_d').AsFloat:= rAux;
  kmtStockValoradoDet.FieldByName('cajas_d').AsInteger:= QListadoStock.FieldByName('cajas_apcd').AsInteger;
  kmtStockValoradoDet.FieldByName('unidades_d').AsInteger:= QListadoStock.FieldByName('unidades_apcd').AsInteger;
  kmtStockValoradoDet.FieldByName('coste_d').AsFloat:= bRoundTo( ( rAux * APrecioMedio ), 2);
  kmtStockValoradoDet.Post;
end;

procedure TDLValorarStockConfeccionado.AnyadeRegistro( const APrecioMedio: Real );
var
  iCodAux: integer;
  rAux: Real;
begin
  if QListadoStock.FieldByName('peso_apcd').AsFloat <> 0 then
    rAux:= QListadoStock.FieldByName('peso_apcd').AsFloat
  else
    rAux:= ( QListadoStock.FieldByName('peso_medio').AsFloat *
             QListadoStock.FieldByName('cajas_apcd').AsFloat );

  if kmtStockValorado.Locate( 'empresa;producto;centro;fecha_alta;fecha_status;status',
                               VarArrayOf( [QListadoStock.FieldByName('empresa_apcc').AsString,
                                            QListadoStock.FieldByName('producto_apcd').AsString,
                                            QListadoStock.FieldByName('centro_apcc').AsString,
                                            QListadoStock.FieldByName('fecha_alta_apcc').AsDateTime,
                                            QListadoStock.FieldByName('fecha_status_apc').AsDateTime,
                                            QListadoStock.FieldByName('status_apcc').AsString] ), [] ) then
  begin
    iCodAux:= kmtStockValorado.FieldByName('codigo_cab').AsInteger;

    kmtStockValorado.Edit;

    kmtStockValorado.FieldByName('kilos_c').AsFloat:= kmtStockValorado.FieldByName('kilos_c').AsFloat + rAux;
    kmtStockValorado.FieldByName('unidades_c').AsInteger:= kmtStockValorado.FieldByName('unidades_c').AsInteger +
                                                      QListadoStock.FieldByName('unidades_apcd').AsInteger;
    kmtStockValorado.FieldByName('cajas_c').AsInteger:= kmtStockValorado.FieldByName('cajas_c').AsInteger +
                                                      QListadoStock.FieldByName('cajas_apcd').AsInteger;
    kmtStockValorado.FieldByName('palets_c').AsInteger:= kmtStockValorado.FieldByName('palets_c').AsInteger + 1;

    //Importe normal
    kmtStockValorado.FieldByName('coste_c').AsFloat:= kmtStockValorado.FieldByName('coste_c').AsFloat +
                                                      bRoundTo( ( rAux * APrecioMedio ), 2);

    kmtStockValorado.Post;
  end
  else
  begin
    inc( iCodCab );
    iCodAux:= iCodCab;

    kmtStockValorado.Insert;
    kmtStockValorado.FieldByName('codigo_cab').AsInteger:= iCodCab;

    kmtStockValorado.FieldByName('empresa').AsString:= QListadoStock.FieldByName('empresa_apcc').AsString;
    kmtStockValorado.FieldByName('producto').AsString:= QListadoStock.FieldByName('producto_apcd').AsString;
    kmtStockValorado.FieldByName('centro').AsString:= QListadoStock.FieldByName('centro_apcc').AsString;

    kmtStockValorado.FieldByName('fecha_alta').AsDatetime:= QListadoStock.FieldByName('fecha_alta_apcc').AsDatetime;
    kmtStockValorado.FieldByName('fecha_status').AsDatetime:= QListadoStock.FieldByName('fecha_status_apc').AsDatetime;
    kmtStockValorado.FieldByName('status').AsString:= QListadoStock.FieldByName('status_apcc').AsString;

    kmtStockValorado.FieldByName('kilos_c').AsFloat:= rAux;
    kmtStockValorado.FieldByName('unidades_c').AsInteger:= QListadoStock.FieldByName('unidades_apcd').AsInteger;
    kmtStockValorado.FieldByName('cajas_c').AsInteger:= QListadoStock.FieldByName('cajas_apcd').AsInteger;
    kmtStockValorado.FieldByName('palets_c').AsInteger:= 1;
    kmtStockValorado.FieldByName('coste_c').AsFloat:= bRoundTo( ( rAux * APrecioMedio ), 2);
    kmtStockValorado.Post;
  end;
  
  AltaPalet( iCodAux, APrecioMedio );
end;

procedure TDLValorarStockConfeccionado.MontaTablaListado( const AFecha: TDateTime );
var
  rPrecioMedio: Real;
begin
  QListadoStock.First;
  while not QListadoStock.Eof do
  begin
    rPrecioMedio:= CosteMedioFruta( QListadoStock.FieldByName('empresa_apcc').AsString,
                                    QListadoStock.FieldByName('producto_apcd').AsString,
                                    AFecha );
    AnyadeRegistro( rPrecioMedio );
    QListadoStock.Next;
  end;
  kmtStockValorado.SortFields:= 'codigo_cab';
  kmtStockValorado.Sort([]);
  kmtStockValorado.First;
end;

function TDLValorarStockConfeccionado.GetCosteFrutaAux( const AEmpresa, AProducto: string;
                                                        var VPrecioMedio: Real ): boolean;
begin
  if kmtGastos.Locate( 'empresa;producto', VarArrayOf( [AEmpresa, AProducto] ), [] ) then
  begin
    VPrecioMedio:= kmtGastos.FieldByName('precio_medio').AsFloat;
    Result:= True;
  end
  else
  begin
    Result:= False;
  end;
end;

procedure TDLValorarStockConfeccionado.PutCosteFrutaAux( const AEmpresa, AProducto: string;
                                                         const APrecioMedio: Real );
begin
  kmtGastos.Insert;
  kmtGastos.FieldByName('empresa').AsString:= AEmpresa;
  kmtGastos.FieldByName('producto').AsString:= AProducto;
  kmtGastos.FieldByName('precio_medio').AsFloat:= APrecioMedio;
  kmtGastos.Post;
end;

function TDLValorarStockConfeccionado.CalcularCosteFruta( const AEmpresa, AProducto: string;
                                                          const AFecha: TDateTime ): real;
var
  rImporteProducto, rImporteTodos, rKilosProducto, rKilosTodos: Real;
begin
  Result:= 0;
  with qryImporteGastos do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('producto').AsString:= AProducto;
    ParamByName('fechafin').AsDateTime:= AFecha;
    ParamByName('fechaini').AsDateTime:= AFecha-6;
    Open;
    rImporteProducto:= FieldByName('importe_producto').AsFloat;
    rImporteTodos:= FieldByName('importe_todos').AsFloat;
    Close;
  end;
  if ( rImporteProducto + rImporteTodos ) <> 0 then
  begin
    with qryKilosGastos do
    begin
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('producto').AsString:= AProducto;
      ParamByName('fechafin').AsDateTime:= AFecha;
      ParamByName('fechaini').AsDateTime:= AFecha-6;
      Open;
      rKilosProducto:= FieldByName('kilos_producto').AsFloat;
      rKilosTodos:= FieldByName('kilos_todos').AsFloat;
      Close;
    end;
    if rKilosProducto > 0 then
    begin
      Result:= bRoundTo( rImporteProducto / rKilosProducto, 2 )
    end;
    if rKilosTodos > 0 then
    begin
      Result:= Result + bRoundTo( rImporteTodos / rKilosTodos, 2 )
    end;
  end;
end;


function TDLValorarStockConfeccionado.CosteMedioFruta( const AEmpresa, AProducto: string;
                                                       const AFecha: TDateTime ): real;
begin
  //Mirar a ver si ya los tenemos
  if not GetCosteFrutaAux( AEmpresa, AProducto, result ) then
  begin
    result:= CalcularCosteFruta( AEmpresa, AProducto, AFecha );
    PutCosteFrutaAux( AEmpresa, AProducto, result );
  end;
end;

end.
