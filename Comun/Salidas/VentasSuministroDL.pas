unit VentasSuministroDL;

interface

uses
  SysUtils, Classes, DBTables, DB, EntregasCB, kbmMemTable, Dialogs;

const
  kDepurarQuery = False;

type
  RParametrosVentasSuministro = record
    sEmpresa: String;
    sCliente: String;
    sSuministro: String;
    bCentro: Boolean;
    sProducto: String;
    sLinea: String;
    bLinea: Boolean;
    sEnvase: String;
    bEnvase: Boolean;
    dFechaDesde: TDateTime;
    dFechaHasta: TDateTime;
    // 1-total, 2-anual, 3-mensual, 4-semanal, 5-diaria, 6-albaran
    iAgrupar: integer;
    bCompactar: Boolean;
    bComparar: Boolean;
    dFechaDesdeAnt: TDateTime;
    dFechaHastaAnt: TDateTime;
  end;

  TDLVentasSuministro = class(TDataModule)
    QVentasSuministro: TQuery;
    mtListado: TkbmMemTable;
    mtListadoempresa: TStringField;
    mtListadocliente: TStringField;
    mtListadosuministro: TStringField;
    mtListadoproducto: TStringField;
    mtListadocajas_act: TIntegerField;
    mtListadokilos_act: TFloatField;
    mtListadoimporte_act: TFloatField;
    mtListadocajas_ant: TIntegerField;
    mtListadokilos_ant: TFloatField;
    mtListadoimporte_ant: TFloatField;
    QGuia: TQuery;
    mtListadoguia: TStringField;
    mtListadoguia_ant: TStringField;
    dlgSaveFile: TSaveDialog;
    mtListadolinea: TStringField;
    mtListadoenvase: TStringField;
  private
    { Private declarations }
    function  TextoSQL( const AParametros: RParametrosVentasSuministro ): boolean;

    procedure RellenarTablaTemporal( const AParametros: RParametrosVentasSuministro );
    procedure RellenarTablaTemporalAux( const AParametros: RParametrosVentasSuministro );

    procedure NuevoRegistro( const AGuiaActual, AGuiaAnterior: String );

    procedure Ninguna;
    procedure Anyo( const AParametros: RParametrosVentasSuministro );
    procedure Mes( const AParametros: RParametrosVentasSuministro );
    procedure Semana( const AParametros: RParametrosVentasSuministro );
    procedure Dia( const AParametros: RParametrosVentasSuministro );

    procedure UpdateTablaActual;
    //procedure UpdateTablaAnterior( const AGuia: string );
    procedure UpdateTablaAnterior;


    procedure CrearCsv( const ATabla: TkbmMemTable );
    procedure CrearMiCsv;
  public
    { Public declarations }
    procedure ObtenerDatos( AParametros: RParametrosVentasSuministro );

  end;


procedure LoadModule( APadre: TComponent );
procedure UnloadModule;
function  OpenData( APadre: TComponent; AParametros: RParametrosVentasSuministro ): integer;
function  GuardarCsv( APadre: TComponent; AParametros: RParametrosVentasSuministro ): integer;

implementation

uses bMath, bTimeUtils, DateUtils, Variants, UDMAuxDB;

{$R *.dfm}

var
  DLVentasSuministro: TDLVentasSuministro;
  iContadorUso: integer = 0;

procedure LoadModule( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      DLVentasSuministro:= TDLVentasSuministro.Create( APadre );
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
      if DLVentasSuministro <> nil then
      begin
        FreeAndNil( DLVentasSuministro );
      end;
    end;
  end;
end;

function OpenData( APadre: TComponent; AParametros: RParametrosVentasSuministro ): integer;
begin
  LoadModule( APadre );
  DLVentasSuministro.ObtenerDatos( AParametros );
  result:= DLVentasSuministro.mtListado.RecordCount;
  UnLoadModule;
end;

function GuardarCsv( APadre: TComponent; AParametros: RParametrosVentasSuministro ): integer;
begin
  LoadModule( APadre );
  DLVentasSuministro.ObtenerDatos( AParametros );
  result:= DLVentasSuministro.mtListado.RecordCount;
  if result > 0 then
    DLVentasSuministro.CrearMiCsv;
  UnLoadModule;
end;

procedure TDLVentasSuministro.ObtenerDatos( AParametros: RParametrosVentasSuministro );
begin
  mtListado.Close;
  mtListado.Open;

  QVentasSuministro.Close;
  QVentasSuministro.SQL.Clear;
  if TextoSQL( AParametros ) then
  begin
    QVentasSuministro.ParamByName('fechaini').AsDate:= AParametros.dFechaDesde;
    QVentasSuministro.ParamByName('fechafin').AsDate:= AParametros.dFechaHasta;
    QVentasSuministro.Open;
    while Not QVentasSuministro.Eof do
    begin
      UpdateTablaActual;
      QVentasSuministro.Next;
    end;
    QVentasSuministro.Close;

    if AParametros.bComparar then
    begin
      //
      QVentasSuministro.ParamByName('fechaini').AsDate:= AParametros.dFechaDesdeAnt;
      QVentasSuministro.ParamByName('fechafin').AsDate:= AParametros.dFechaHastaAnt;
      QVentasSuministro.Open;
      while Not QVentasSuministro.Eof do
      begin
        UpdateTablaAnterior;
        QVentasSuministro.Next;
      end;
      QVentasSuministro.Close;
    end;
  end;
  DLVentasSuministro.mtListado.SortFields:= 'empresa;cliente;suministro;producto;linea;envase;guia';
  DLVentasSuministro.mtListado.Sort([]);
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

procedure TDLVentasSuministro.CrearCsv( const ATabla: TkbmMemTable );
var
  slCsvFile: TStringList;
  sAux: string;
  i: Integer;
begin
  if dlgSaveFile.Execute then
  begin
    slCsvFile:= TStringList.Create;
    ATabla.First;
    while not ATabla.Eof do
    begin
      i:= 0;
      sAux:= '';
      sAux:= CsvField( ATabla.Fields[i] );
      for i:= 1 to ATabla.FieldCount - 1 do
      begin
        sAux:= sAux + ',' + CsvField( ATabla.Fields[i] );
      end;
      slCsvFile.Add( sAux );
      ATabla.Next;
    end;
    try
      slCsvFile.SaveToFile( dlgSaveFile.FileName );
      ShowMessage('Proceso finalizado correctamente.');
    finally
      FreeAndNil( slCsvFile );
    end;
  end;
end;

procedure TDLVentasSuministro.CrearMiCsv;
var
  slCsvFile: TStringList;
  sAux: string;
begin
  if dlgSaveFile.Execute then
  begin
    slCsvFile:= TStringList.Create;
    mtListado.First;
    while not mtListado.Eof do
    begin
      //Empresa
      sAux:= '"' +  mtListado.FieldByName('empresa').AsString + '"';
      sAux:= sAux + ';"' +  desEmpresa( mtListado.FieldByName('empresa').AsString  )+ '"';
      //Cliente
      sAux:= sAux + ';"' +  mtListado.FieldByName('cliente').AsString + '"';
      sAux:= sAux + ';"' +  desCliente( mtListado.FieldByName('cliente').AsString  )+ '"';
      //Suministro
      sAux:= sAux + ';"' +  mtListado.FieldByName('suministro').AsString + '"';
      sAux:= sAux + ';"' +  desSuministro( mtListado.FieldByName('empresa').AsString, mtListado.FieldByName('cliente').AsString, mtListado.FieldByName('suministro').AsString  )+ '"';
      //Producto
      sAux:= sAux + ';"' +  mtListado.FieldByName('producto').AsString + '"';
      sAux:= sAux + ';"' +  desProducto( mtListado.FieldByName('empresa').AsString, mtListado.FieldByName('producto').AsString  )+ '"';
      //Linea
      sAux:= sAux + ';"' +  mtListado.FieldByName('linea').AsString + '"';
      sAux:= sAux + ';"' +  desLineaProducto( mtListado.FieldByName('linea').AsString  )+ '"';
      //Envase
      sAux:= sAux + ';"' +  mtListado.FieldByName('envase').AsString + '"';
      sAux:= sAux + ';"' +  desEnvase( mtListado.FieldByName('empresa').AsString, mtListado.FieldByName('envase').AsString  )+ '"';
      //Guia
      sAux:= sAux + ';"' +  mtListado.FieldByName('guia').AsString + '"';
      //Cajas
      sAux:= sAux + ';' + mtListado.FieldByName('cajas_act').AsString;
      //Kilos
      sAux:= sAux + ';' + FormatFloat( '#.#', mtListado.FieldByName('kilos_act').AsFloat );
      //Importes
      sAux:= sAux + ';' + FormatFloat( '#.#', mtListado.FieldByName('importe_act').AsFloat );
      //Guia
      sAux:= sAux + ';"' +  mtListado.FieldByName('guia_ant').AsString + '"';
      //Cajas
      sAux:= sAux + ';' + mtListado.FieldByName('cajas_ant').AsString;
      //Kilos
      sAux:= sAux + ';' + FormatFloat( '#.#', mtListado.FieldByName('kilos_ant').AsFloat );
      //Importe
      sAux:= sAux + ';' + FormatFloat( '#.#', mtListado.FieldByName('importe_ant').AsFloat );

      slCsvFile.Add( sAux );
      mtListado.Next;
    end;
    try
      slCsvFile.SaveToFile( dlgSaveFile.FileName );
      ShowMessage('Proceso finalizado correctamente.');
    finally
      FreeAndNil( slCsvFile );
    end;
  end;
end;

function TDLVentasSuministro.TextoSQL( const AParametros: RParametrosVentasSuministro ): boolean;
begin
  with QGuia do
  begin
    SQL.Clear;
    SQL.Add( ' select empresa_sc empresa,');
    SQL.Add( '        cliente_sal_sc cliente,  ');
    if AParametros.bCentro then
      SQL.Add( '        dir_sum_sc suministro,  ')
    else
      SQL.Add( '        '''' suministro,  ');
    SQL.Add( '        producto_sl producto, ');
    if AParametros.bLinea then
      SQL.Add( '        linea_producto_e linea,  ')
    else
      SQL.Add( '        '''' linea,  ');
    if AParametros.bEnvase then
      SQL.Add( '        envase_sl envase ')
    else
      SQL.Add( '        '''' envase ');
    SQL.Add( '          ');
    SQL.Add( ' from frf_salidas_c ');
    SQL.Add( '      join frf_salidas_l on empresa_sl = empresa_sc and  centro_salida_sc = centro_salida_sl ');
    SQL.Add( '                            and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
    if ( AParametros.sLinea <> '' ) or ( AParametros.bLinea ) then
      SQL.Add( '      join frf_envases on envase_sl = envase_e ');

    SQL.Add( ' where fecha_sc between :fechaini and :fechafin ');
    if AParametros.sEmpresa = 'SAT' then
      SQL.Add( ' and ( empresa_sc = ''050'' or empresa_sc = ''080'' )' )
    else
    if AParametros.sEmpresa = 'BAG' then
      SQL.Add( ' and substr(empresa_sc,1,1) = ''F'' ' )
    else
      SQL.Add( ' and empresa_sc = ' + QuotedStr( AParametros.sEmpresa ) );

    if AParametros.sCliente <> '' then
      SQL.Add( ' and cliente_sal_sc =  ' + QuotedStr( AParametros.sCliente ) );
    if AParametros.sSuministro <> '' then
      SQL.Add( ' and dir_sum_sc = ' + QuotedStr( AParametros.sSuministro ) );
    if AParametros.sProducto <> '' then
      SQL.Add( ' and producto_sl = ' + QuotedStr( AParametros.sProducto ) );
    if AParametros.sLinea <> '' then
      SQL.Add( ' and linea_producto_e = ' + QuotedStr( AParametros.sLinea ) );
    if AParametros.sEnvase <> '' then
      SQL.Add( ' and envase_sl = ' + QuotedStr( AParametros.sEnvase ) );

    SQL.Add('  and es_transito_sc <> 2 ');      // Tipo Salida: Devolucion

    SQL.Add( ' group by 1, 2, 3, 4, 5, 6 ');
    SQL.Add( ' order by 1, 2, 3, 4, 5, 6 ');
  end;

  QGuia.ParamByName('fechaini').AsDate:= AParametros.dFechaDesde;
  QGuia.ParamByName('fechafin').AsDate:= AParametros.dFechaHasta;
  QGuia.Open;
  result:= not QGuia.IsEmpty;
  while not QGuia.Eof do
  begin
    RellenarTablaTemporal( AParametros );
    QGuia.Next;
  end;
  QGuia.Close;

  QGuia.ParamByName('fechaini').AsDate:= AParametros.dFechaDesdeAnt;
  QGuia.ParamByName('fechafin').AsDate:= AParametros.dFechaHastaAnt;
  QGuia.Open;
  result:= result or not QGuia.IsEmpty;
  while not QGuia.Eof do
  begin
    RellenarTablaTemporalAux( AParametros );
    QGuia.Next;
  end;
  QGuia.Close;

  with QVentasSuministro do
  begin
    SQL.Clear;
    SQL.Add( ' select ');
    SQL.Add( '        empresa_sc empresa,  ');
    SQL.Add( '        cliente_sal_sc cliente,  ');
    if AParametros.bCentro then
      SQL.Add( '        dir_sum_sc suministro,  ')
    else
      SQL.Add( '        '''' suministro,  ');
    SQL.Add( '        producto_sl producto, ');
    if AParametros.bLinea then
      SQL.Add( '        linea_producto_e linea,  ')
    else
      SQL.Add( '        '''' linea,  ');
    if AParametros.bEnvase then
      SQL.Add( '        envase_sl envase, ')
    else
      SQL.Add( '        '''' envase, ');
    case AParametros.iAgrupar of
      1: SQL.Add( '        ''TOTAL'' guia, ');
      2: SQL.Add( '        year(fecha_sc) guia, ');
      3: SQL.Add( '        ( year(fecha_sc) * 100 ) + month(fecha_sl) guia, ');
      4: SQL.Add( '        yearandweek(fecha_sc) guia, ');
      5: SQL.Add( '        fecha_sc guia,  ');
      6: SQL.Add( '        n_albaran_sc guia,  ');
    end;
    SQL.Add( '        sum(cajas_sl) cajas, sum(kilos_sl) kilos, sum(importe_neto_sl) importe ');
    SQL.Add( ' from frf_salidas_c ');
    SQL.Add( '      join frf_salidas_l on empresa_sl = empresa_sc and  centro_salida_sc = centro_salida_sl ');
    SQL.Add( '                            and n_albaran_sc = n_albaran_sl and fecha_sc = fecha_sl ');
    if ( AParametros.sLinea <> '' ) or ( AParametros.bLinea ) then
      SQL.Add( '      join frf_envases on envase_sl = envase_e ');

    SQL.Add( ' where fecha_sc between :fechaini and :fechafin ');
    if AParametros.sEmpresa = 'SAT' then
      SQL.Add( ' and ( empresa_sc = ''050'' or empresa_sc = ''080'' )' )
    else
    if AParametros.sEmpresa = 'BAG' then
      SQL.Add( ' and substr(empresa_sc,1,1) = ''F'' ' )
    else
      SQL.Add( ' and empresa_sc = ' + QuotedStr( AParametros.sEmpresa ) );
    if AParametros.sCliente <> '' then
      SQL.Add( ' and cliente_sal_sc =  ' + QuotedStr( AParametros.sCliente ) );
    if AParametros.sSuministro <> '' then
      SQL.Add( ' and dir_sum_sc = ' + QuotedStr( AParametros.sSuministro ) );
    if AParametros.sProducto <> '' then
      SQL.Add( ' and producto_sl = ' + QuotedStr( AParametros.sProducto ) );
    if AParametros.sLinea <> '' then
      SQL.Add( ' and linea_producto_e = ' + QuotedStr( AParametros.sLinea ) );
    if AParametros.sEnvase <> '' then
      SQL.Add( ' and envase_sl = ' + QuotedStr( AParametros.sEnvase ) );

    SQL.Add('  and es_transito_sc <> 2 ');      // Tipo Salida: Devolucion

    SQL.Add( ' group by 1, 2, 3, 4, 5, 6, 7 ');
    SQL.Add( ' order by 1, 2, 3, 4, 5, 6, 7 ');
  end;
end;

procedure TDLVentasSuministro.RellenarTablaTemporal( const AParametros: RParametrosVentasSuministro );
begin
  case AParametros.iAgrupar of
    1: Ninguna;
    2: Anyo( AParametros );
    3: Mes( AParametros );
    4: Semana( AParametros );
    5: Dia( AParametros );
  end;
end;

procedure TDLVentasSuministro.RellenarTablaTemporalAux( const AParametros: RParametrosVentasSuministro );
begin
  if not mtListado.Locate( 'empresa;cliente;suministro;producto;linea;envase',
       VarArrayOf([QGuia.fieldByName('empresa').AsString,
         QGuia.fieldByName('cliente').AsString,
         QGuia.fieldByName('suministro').AsString,
         QGuia.fieldByName('producto').AsString,
         QGuia.fieldByName('linea').AsString,
         QGuia.fieldByName('envase').AsString]),[]) then
  begin
    case AParametros.iAgrupar of
      1: Ninguna;
      2: Anyo( AParametros );
      3: Mes( AParametros );
      4: Semana( AParametros );
      5: Dia( AParametros );
    end;
  end;
end;


procedure TDLVentasSuministro.NuevoRegistro( const AGuiaActual, AGuiaAnterior: String );
begin
  mtListado.Insert;
  mtListadoempresa.AsString:= QGuia.fieldByName('empresa').AsString;
  mtListadocliente.AsString:= QGuia.fieldByName('cliente').AsString;
  mtListadosuministro.AsString:= QGuia.fieldByName('suministro').AsString;
  mtListadoProducto.AsString:= QGuia.fieldByName('producto').AsString;
  mtListadolinea.AsString:= QGuia.fieldByName('linea').AsString;
  mtListadoenvase.AsString:= QGuia.fieldByName('envase').AsString;

  if AGuiaActual <> '' then
    mtListadoGuia.AsString:= AGuiaActual;
  mtListadocajas_act.AsInteger:= 0;
  mtListadocajas_ant.AsInteger:= 0;
  mtListadokilos_act.AsFloat:= 0;

  if AGuiaAnterior <> '' then
    mtListadoGuia_ant.AsString:= AGuiaAnterior;
  mtListadokilos_ant.AsFloat:= 0;
  mtListadoimporte_act.AsFloat:= 0;
  mtListadoimporte_ant.AsFloat:= 0;
  mtListado.Post;
end;

procedure TDLVentasSuministro.Ninguna;
begin
  NuevoRegistro( 'TOTAL', 'TOTAL' );
end;

procedure TDLVentasSuministro.Anyo( const AParametros: RParametrosVentasSuministro );
var
  dAux: TDateTime;
  iAnyoAux, iAnyo, iMes, iDia: Word;
  dAuxAnt: TDateTime;
  iAnyoAnt, iMesAnt, iDiaAnt: Word;
begin
  dAux:= AParametros.dFechaDesde;
  dAuxAnt:= AParametros.dFechaDesdeAnt;

  while dAux < AParametros.dFechaHasta do
  begin
    DecodeDate( dAux, iAnyo, iMes, IDia );
    DecodeDate( dAuxAnt, iAnyoAnt, iMesAnt, IDiaAnt );

    NuevoRegistro( IntToStr( iAnyo ), IntToStr( iAnyoAnt ) );

    iAnyo:= iAnyo + 1;
    dAux:= EncodeDate( iAnyo, iMes, IDia );
    iAnyoAnt:= iAnyoAnt + 1;
    dAuxAnt:= EncodeDate( iAnyoAnt, iMesAnt, IDiaAnt );
  end;

  DecodeDate( AParametros.dFechaHasta, iAnyoAux, iMes, IDia );
  if iAnyo = iAnyoAux then
  begin
    NuevoRegistro( IntToStr( iAnyo ), IntToStr( iAnyoAnt ) );
  end;
end;

procedure TDLVentasSuministro.Mes( const AParametros: RParametrosVentasSuministro );
var
  dAux, dAuxAnt: TDateTime;
begin
  dAux:= AParametros.dFechaDesde;
  dAuxAnt:= AParametros.dFechaDesdeAnt;

  while ( dAux < AParametros.dFechaHasta ) do
  begin
    NuevoRegistro( AnyoMes( dAux ), AnyoMes( dAuxAnt ) );

    dAux:= IncMonth( dAux );
    dAuxAnt:= IncMonth( dAuxAnt );
  end;

  if AnyoMes( dAux ) = AnyoMes( AParametros.dFechaHasta ) then
  begin
    NuevoRegistro( AnyoMes( dAux ), AnyoMes( dAuxAnt ) );
  end;
end;

procedure TDLVentasSuministro.Semana( const AParametros: RParametrosVentasSuministro );
var
  dAux, dAuxAnt: TDateTime;
  sAux, sAuxAnt, sFin, sFinAnt: string;
  sSemana, sSemanaAnt: string;
begin
  dAux:= AParametros.dFechaDesde;
  sAux:= AnyoSemana( dAux );
  sFin:= AnyoSemana( AParametros.dFechaHasta );

  dAuxAnt:= AParametros.dFechaDesdeAnt;
  sAuxAnt:= AnyoSemana( dAuxAnt );
  sFinAnt:= AnyoSemana( AParametros.dFechaHastaAnt );

  sSemana:= '';
  sSemanaAnt:= '';
  (*
  while ( sAux <= sFin ) or ( sAuxAnt <= sFinAnt ) do
  *)
  while ( sAux <= sFin ) do
  begin
    (*
    if AParametros.bCompararDiaSemana then
    *)
    begin
      sSemana:= sAux;
      sSemanaAnt:= sAuxAnt;
    end;
    (*
    else
    begin
      if ( WeekOfTheYear( dAux ) <> 53 ) and
         ( WeekOfTheYear( dAuxAnt ) <> 53 ) then
      begin
        if sAux <= sFin  then
          sSemana:= sAux
        else
          sSemana:= '';
        if sAuxAnt <= sFinAnt then
          sSemanaAnt:= sAuxAnt
        else
          sSemanaAnt:= '';
      end
      else
      begin
        sSemana:= '';
        sSemanaAnt:= '';
        if ( WeekOfTheYear( dAux ) = 53 ) then
        begin
          sSemana:= sAux;
        end;
        if ( WeekOfTheYear( dAuxAnt ) = 53 ) then
        begin
          sSemanaAnt:= sAuxAnt;
        end;
      end;
    end;
    *)
    NuevoRegistro( sSemana, sSemanaAnt );

    if sSemana <> '' then
    begin
      dAux:= dAux + 7;
      sAux:= AnyoSemana( dAux );
    end;
    if sSemanaAnt <> '' then
    begin
      dAuxAnt:= dAuxAnt + 7;
      sAuxAnt:= AnyoSemana( dAuxAnt );
    end;
  end;
end;

procedure TDLVentasSuministro.Dia( const AParametros: RParametrosVentasSuministro );
var
  dAux, dAuxAnt: TDateTime;
  iAnyo, iMes, iDia, iMesAnt, iDiaAnt: Word;
  sAux, sAuxAnt: string;
begin
  dAux:= AParametros.dFechaDesde;
  dAuxAnt:= AParametros.dFechaDesdeAnt;

  (*
  while ( dAux <= AParametros.dFechaHasta ) or
        ( dAuxAnt <= AParametros.dFechaHastaAnt ) do
  *)
  while ( dAux <= AParametros.dFechaHasta ) do
  begin
    DecodeDate( dAux, iAnyo, iMes, iDia );
    DecodeDate( dAuxAnt, iAnyo, iMesAnt, iDiaAnt );
    (*
    if AParametros.bCompararDiaSemana then
    *)
    begin
      sAux:= DateToStr( dAux );
      sAuxAnt:= DateToStr( dAuxAnt );
    end;
    (*
    else
    begin
      if ( ( iMes <> 2 ) or  ( iDia <> 29 ) ) and
         ( ( iMesAnt <> 2 ) or  ( iDiaAnt <> 29 ) ) then
      begin
        if dAux <= AParametros.dFechaHasta  then
          sAux:= DateToStr( dAux )
        else
          sAux:= '';
        if dAuxAnt <= AParametros.dFechaHastaAnt then
          sAuxAnt:= DateToStr( dAuxAnt )
        else
          sAuxAnt:= '';
      end
      else
      begin
        sAux:= '';
        sAuxAnt:= '';

        if ( iMes = 2 ) and  ( iDia = 29 )  then
        begin
          sAux:= DateToStr( dAux )
        end;
        if ( iMesAnt = 2 ) and  ( iDiaAnt = 29 ) then
        begin
          sAuxAnt:= DateToStr( dAuxAnt )
        end;
      end;
    end;
    *)
    NuevoRegistro( sAux, sAuxAnt );

    if sAux <> ''then
    begin
      dAux:= dAux + 1;
      //sAux:= DateToStr( dAux );
    end;
    if sAux <> ''then
    begin
      dAuxAnt:= dAuxAnt + 1;
      //sAuxAnt:= DateToStr( dAuxAnt );
    end;
  end;
end;

procedure TDLVentasSuministro.UpdateTablaActual;
begin
  if mtListado.Locate( 'empresa;cliente;suministro;producto;linea;envase;guia',
       VarArrayOf([QVentasSuministro.fieldByName('empresa').AsString,
         QVentasSuministro.fieldByName('cliente').AsString,
         QVentasSuministro.fieldByName('suministro').AsString,
         QVentasSuministro.fieldByName('producto').AsString,
         QVentasSuministro.fieldByName('linea').AsString,
         QVentasSuministro.fieldByName('envase').AsString,
         QVentasSuministro.fieldByName('guia').AsString]),[]) then
  begin
    mtListado.Edit;
    mtListadocajas_act.AsInteger:= QVentasSuministro.fieldByName('cajas').AsInteger;
    mtListadokilos_act.AsFloat:= QVentasSuministro.fieldByName('kilos').AsFloat;
    mtListadoimporte_act.AsFloat:= QVentasSuministro.fieldByName('importe').AsFloat;
    mtListado.Post;
  end;
end;

procedure TDLVentasSuministro.UpdateTablaAnterior;
begin
  if mtListado.Locate( 'empresa;cliente;suministro;producto;linea;envase;guia_ant',
       VarArrayOf([QVentasSuministro.fieldByName('empresa').AsString,
         QVentasSuministro.fieldByName('cliente').AsString,
         QVentasSuministro.fieldByName('suministro').AsString,
         QVentasSuministro.fieldByName('producto').AsString,
         QVentasSuministro.fieldByName('linea').AsString,
         QVentasSuministro.fieldByName('envase').AsString,
         QVentasSuministro.fieldByName('guia').AsString]),[]) then
  begin
    mtListado.Edit;
    mtListadocajas_ant.AsInteger:= QVentasSuministro.fieldByName('cajas').AsInteger;
    mtListadokilos_ant.AsFloat:= QVentasSuministro.fieldByName('kilos').AsFloat;
    mtListadoimporte_ant.AsFloat:= QVentasSuministro.fieldByName('importe').AsFloat;
    mtListado.Post;
  end;
end;

end.


