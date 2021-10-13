unit SalidasSuministroDL;

interface

uses
  SysUtils, Classes, DBTables, DB, EntregasCB, Dialogs;

const
  kDepurarQuery = False;

type
  RParametrosSalidasSuministro = record
    sEmpresa: String;
    sCliente: String;
    sSuministro: String;
    dFechaDesde: TDateTime;
    dFechaHasta: TDateTime;
    // 1-total, 2-anual, 3-mensual, 4-semanal, 5-diaria, 6-albaran
    iAgrupar: integer;
    //Completar con los datos del pedido
    bPedidos: Boolean;
    iDiasPedidos: integer;
  end;

  TDLSalidasSuministro = class(TDataModule)
    QSalidasSuministro: TQuery;
    dlgSaveFile: TSaveDialog;
  private
    { Private declarations }
    procedure  TextoSQL( const AParametros: RParametrosSalidasSuministro );

    procedure CrearCsv( AParametros: RParametrosSalidasSuministro );
  public
    { Public declarations }
    procedure ObtenerDatos( AParametros: RParametrosSalidasSuministro );

  end;


procedure LoadModule( APadre: TComponent );
procedure UnloadModule;
function  ImprimirListado( APadre: TComponent; AParametros: RParametrosSalidasSuministro ): integer;
function  GuardarCsv( APadre: TComponent; AParametros: RParametrosSalidasSuministro ): integer;

implementation

uses bMath, bTimeUtils, DateUtils, Variants, SalidasSuministroQL;

{$R *.dfm}

var
  DLSalidasSuministro: TDLSalidasSuministro;
  iContadorUso: integer = 0;

procedure LoadModule( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      DLSalidasSuministro:= TDLSalidasSuministro.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
end;

procedure UnloadModule;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if DLSalidasSuministro <> nil then
      begin
        FreeAndNil( DLSalidasSuministro );
      end;
    end;
  end;
end;

function ImprimirListado( APadre: TComponent; AParametros: RParametrosSalidasSuministro ): integer;
begin
  LoadModule( APadre );
  DLSalidasSuministro.ObtenerDatos( AParametros );
  result:= DLSalidasSuministro.QSalidasSuministro.RecordCount;
  if result > 0 then
    SalidasSuministroQL.ExecuteReport( Apadre, AParametros );
  UnLoadModule;
end;

function GuardarCsv( APadre: TComponent; AParametros: RParametrosSalidasSuministro ): integer;
begin
  LoadModule( APadre );
  DLSalidasSuministro.ObtenerDatos( AParametros );
  result:= DLSalidasSuministro.QSalidasSuministro.RecordCount;
  if result > 0 then
    DLSalidasSuministro.CrearCsv( AParametros );
  UnLoadModule;
end;

procedure TDLSalidasSuministro.ObtenerDatos( AParametros: RParametrosSalidasSuministro );
begin
  QSalidasSuministro.Close;
  QSalidasSuministro.SQL.Clear;
  TextoSQL( AParametros );
  //QSalidasSuministro.ParamByName('empresa').AsString:= AParametros.sEmpresa;
  QSalidasSuministro.ParamByName('cliente').AsString:= AParametros.sCliente;
  if AParametros.sSuministro <> '' then
    QSalidasSuministro.ParamByName('suministro').AsString:= AParametros.sSuministro;
  QSalidasSuministro.ParamByName('fechaini').AsDate:= AParametros.dFechaDesde;
  QSalidasSuministro.ParamByName('fechafin').AsDate:= AParametros.dFechaHasta;

  if ( AParametros.iAgrupar = 5 ) and AParametros.bPedidos then
  begin
    QSalidasSuministro.ParamByName('fechainipedido').AsDate:= AParametros.dFechaHasta + 1;
    QSalidasSuministro.ParamByName('fechafinpedido').AsDate:= AParametros.dFechaHasta + AParametros.iDiasPedidos;
  end;

  QSalidasSuministro.Open;
end;

function CsvField( AField: TField ): string;
begin
  if AField.DataType = ftString then
    result:= '"' + AField.AsString + '"'
  else
  if AField.DataType = ftInteger  then
    Result:= AField.AsString
  else
  if AField.DataType = ftFloat  then
    Result:= StringReplace( FormatFloat( '#.#', AField.AsFloat ), ',', '.', [] )
  else
  if ( AField.DataType = ftDate ) or ( AField.DataType = ftDateTime ) then
    Result:= '"' + FormatDateTime( 'dd/mm/yyyy', AField.AsDateTime ) + '"';
end;

procedure TDLSalidasSuministro.CrearCsv( AParametros: RParametrosSalidasSuministro );
var
  slCsvFile: TStringList;
  sAux: string;
  i: Integer;
begin
  sAux:= StringReplace(AParametros.sEmpresa, '''', '', [rfReplaceAll]);
  sAux:= StringReplace(sAux, ',', '', [rfReplaceAll]);
  dlgSaveFile.FileName:= 'InformeSalidas' + '_' + sAux + '_' + FormatDateTime( 'yyyymmdd', Date );
  if dlgSaveFile.Execute then
  begin
    slCsvFile:= TStringList.Create;
    QSalidasSuministro.First;
    while not QSalidasSuministro.Eof do
    begin
      i:= 0;
      sAux:= '';
      sAux:= CsvField( QSalidasSuministro.Fields[i] );
      for i:= 1 to QSalidasSuministro.FieldCount - 1 do
      begin
        sAux:= sAux + ',' + CsvField( QSalidasSuministro.Fields[i] );
      end;
      slCsvFile.Add( sAux );
      QSalidasSuministro.Next;
    end;
    try
      slCsvFile.SaveToFile( dlgSaveFile.FileName );
      ShowMessage('Proceso finalizado correctamente.');
    finally
      FreeAndNil( slCsvFile );
    end;
  end;
end;

procedure TDLSalidasSuministro.TextoSQL( const AParametros: RParametrosSalidasSuministro );
begin
  with QSalidasSuministro do
  begin
    SQL.Clear;
    SQL.Add( 'select');
    SQL.Add( '        ''SERVIDO'' tipo, ');
    SQL.Add( '        empresa_sc empresa, cliente_sal_sc cliente, ');
    case AParametros.iAgrupar of
      1: SQL.Add( '        ''TOTAL'' fecha, ');
      2: SQL.Add( '        year(fecha_sc) fecha, ');
      3: SQL.Add( '        ( year(fecha_sc) * 100 ) + month(fecha_sl) fecha, ');
      4: SQL.Add( '        yearandweek(fecha_sc) fecha, ');
      5,6: SQL.Add( '        fecha_sc fecha,  ');
    end;
    case AParametros.iAgrupar of
      6: SQL.Add( '        n_albaran_sl albaran, ');
      else SQL.Add( '        '''' albaran,  ');
    end;

    SQL.Add( '        dir_sum_sc dir_sum, ');
    SQL.Add( '        producto_sl producto, ');
    SQL.Add( '        envase_sl envase, ');
    SQL.Add( '        ( select descripcion_p from frf_productos where producto_p = producto_sl ) variedad, ');
    SQL.Add( '        sum(cajas_sl) cajas, ');
    SQL.Add( '        sum( unidades_caja_sl * cajas_sl ) unidades, ');
    SQL.Add( '        sum(kilos_sl) kilos, ');
    SQL.Add( '        sum(importe_neto_sl) importe ');

    SQL.Add( ' from   frf_salidas_c, frf_salidas_l ');
    SQL.Add( ' where  empresa_sc in (' + AParametros.sEmpresa + ') ');
    SQL.Add( ' and    cliente_sal_sc = :cliente ');
    if AParametros.sSuministro <> '' then
      SQL.Add( ' and     dir_sum_sc = :suministro ');
    SQL.Add( ' and    fecha_sc between :fechaini and :fechafin ');
    SQL.Add( ' and    empresa_sl = empresa_sc ');
    SQL.Add( ' and    centro_salida_sl = centro_salida_sc ');
    SQL.Add( ' and    fecha_sl = fecha_sc ');
    SQL.Add( ' and    n_albaran_sl = n_albaran_sc ');

    SQL.Add( ' and es_transito_sc <> 2 ');        //Tipo Salida: Devolucion 

    SQL.Add( ' group by 1,2,3,4,5,6,7,8,9 ');

    if ( AParametros.iAgrupar = 5 ) and AParametros.bPedidos then
    begin
      SQL.Add( ' UNION ');

      SQL.Add( ' select ');
      SQL.Add( '        ''PEDIDO'' tipo, ');
      SQL.Add( '        empresa_pdc empresa, cliente_pdc cliente, ');

      case AParametros.iAgrupar of
        1: SQL.Add( '        ''TOTAL'' fecha, ');
        2: SQL.Add( '        year(fecha_pdc) fecha, ');
        3: SQL.Add( '        ( year(fecha_pdc) * 100 ) + month(fecha_pdc) fecha, ');
        4: SQL.Add( '        yearandweek(fecha_pdc) fecha, ');
        5,6: SQL.Add( '        fecha_pdc fecha,  ');
      end;
      case AParametros.iAgrupar of
       6: SQL.Add( '        ref_pedido_pdc albaran, ');
        else SQL.Add( '        '''' albaran,  ');
      end;

      SQL.Add( '        dir_suministro_pdc dir_sum, ');
      SQL.Add( '        case producto_pdd producto, ');
      SQL.Add( '        envase_pdd envase, ');
      SQL.Add( '        ( select descripcion_p from frf_productos where producto_p = producto_pdd ) variedad, ');


      SQL.Add( '         sum( case when unidad_pdd = ''K'' then nvl( unidades_pdd, 1 ) / ( select nvl(peso_neto_e,1) from frf_envases ');
      SQL.Add( '                                                               where envase_e = envase_pdd ');
      SQL.Add( '                                                               and producto_e = producto_pdd ) ');
      SQL.Add( '                   when unidad_pdd = ''U'' then nvl( unidades_pdd, 1 ) / ( select nvl(unidades_e,1) from frf_envases ');
      SQL.Add( '                                                               where envase_e = envase_pdd ');
      SQL.Add( '                                                               and producto_e = producto_pdd ) ');
      SQL.Add( '                   else nvl( unidades_pdd, 1 ) end ) cajas, ');

      SQL.Add( '         sum( case when unidad_pdd = ''K'' then ( nvl( unidades_pdd, 1 ) / ');
      SQL.Add( '                                              ( select nvl(peso_neto_e,1) from frf_envases ');
      SQL.Add( '                                                where envase_e = envase_pdd ');
      SQL.Add( '                                                and   producto_e = producto_pdd ) ) * ');
      SQL.Add( '                                              ( select nvl(unidades_e,1) from frf_envases ');
      SQL.Add( '                                                where envase_e = envase_pdd ');
      SQL.Add( '                                                and   producto_e = producto_pdd ) ');
      SQL.Add( '                   when unidad_pdd = ''C'' then ( select nvl(peso_neto_e,1) from frf_envases ');
      SQL.Add( '                                                where envase_e = envase_pdd ');
      SQL.Add( '                                                and   producto_e = producto_pdd ) * nvl( unidades_pdd, 1 ) ');
      SQL.Add( '                   else nvl( unidades_pdd, 1 ) end ) unidades, ');

      SQL.Add( '         sum( case when unidad_pdd = ''C'' then ( select nvl(peso_neto_e,1) from frf_envases ');
      SQL.Add( '                                                where envase_e = envase_pdd ');
      SQL.Add( '                                                and   producto_e = producto_pdd ) * nvl( unidades_pdd, 1 ) ');

      SQL.Add( '                   when unidad_pdd = ''U'' then ( nvl( unidades_pdd, 1 ) / ');
      SQL.Add( '                                              ( select nvl(unidades_e,1) from frf_envases ');
      SQL.Add( '                                                where envase_e = envase_pdd ');
      SQL.Add( '                                                and   producto_e = producto_pdd ) ) * ');
      SQL.Add( '                                              ( select nvl(peso_neto_e,1) from frf_envases ');
      SQL.Add( '                                                where envase_e = envase_pdd ');
      SQL.Add( '                                                and   producto_e = producto_pdd ) ');
      SQL.Add( '                   else nvl( unidades_pdd, 1 ) end ) kilos, ');

      SQL.Add( '         0 importe ');

      SQL.Add( ' from frf_pedido_cab, frf_pedido_det ');
      SQL.Add( '  where  empresa_pdc in (' + AParametros.sEmpresa + ') ');
      SQL.Add( '  and    fecha_pdc between :fechainipedido and :fechafinpedido ');
      SQL.Add( '  and    cliente_pdc = :cliente ');
      if AParametros.sSuministro <> '' then
        SQL.Add( '  and    dir_suministro_pdc = :suministro ');

      SQL.Add( '  and    empresa_pdd = empresa_pdc ');
      SQL.Add( '  and    centro_pdd = centro_pdc ');
      SQL.Add( '  and    pedido_pdd = pedido_pdc ');

      SQL.Add( ' group by 1,2,3,4,5,6,7,8,9 ');
    end;
    SQL.Add( ' order by fecha, dir_sum, producto, envase, albaran ');
  end;
end;

end.


