unit ListControlIntrasatDL;

interface

uses
  SysUtils, Classes, DBTables, DB, EntregasCB;

const
  kDepurarQuery = False;

type
  RParametrosListControlIntrasat = record
    sEmpresa: String;
    bGrupoEmp: integer;
    dFechaDesde: TDateTime;
    dFechaHasta: TDateTime;
    iTipo: Integer;
    sPais: String;
    sProducto: String;
  end;

  TDLListControlIntrasat = class(TDataModule)
    QListControlIntrasat: TQuery;
    QListControlIntrasatcentro: TStringField;
    QListControlIntrasatcomunitario: TStringField;
    QListControlIntrasatpais: TStringField;
    QListControlIntrasatestomate: TStringField;
    QListControlIntrasatproducto: TStringField;
    QListControlIntrasatcliente: TStringField;
    QListControlIntrasattransito: TIntegerField;
    QListControlIntrasatfecha: TDateField;
    QListControlIntrasatreferencia: TIntegerField;
    QListControlIntrasatcategoria: TStringField;
    QListControlIntrasatkilos: TFloatField;
    QListControlIntrasatneto: TCurrencyField;
    QListControlIntrasatempresa: TStringField;
    QListControlIntrasatrepresentante: TStringField;
    QListControlIntrasatcajas: TCurrencyField;
    QListControlIntrasatpalets: TCurrencyField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ObtenerDatos( AParametros: RParametrosListControlIntrasat );
  end;


procedure LoadModule( APadre: TComponent );
procedure UnloadModule;
function  OpenData( APadre: TComponent; AParametros: RParametrosListControlIntrasat ): integer;

implementation

uses bMath;

{$R *.dfm}

var
  DLListControlIntrasat: TDLListControlIntrasat;
  iContadorUso: integer = 0;

procedure LoadModule( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      DLListControlIntrasat:= TDLListControlIntrasat.Create( APadre );
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
      if DLListControlIntrasat <> nil then
      begin
        FreeAndNil( DLListControlIntrasat );
      end;
    end;
  end;
end;

function OpenData( APadre: TComponent; AParametros: RParametrosListControlIntrasat ): integer;
begin
  LoadModule( APadre );
  DLListControlIntrasat.ObtenerDatos( AParametros );
  result:= DLListControlIntrasat.QListControlIntrasat.RecordCount;
  UnLoadModule;
end;

function GetTextoSQL( AParametros: RParametrosListControlIntrasat ): String;
var
  sCadena: TStringList;
begin
  sCadena:= TStringList.Create;

  (*PARCHE*)
  (*Nacionalidad de los centros de transitos
      sCadena.Add( '        case when centro_destino_tl = 'D' then 'DE' else 'GB' end pais, ' );
  *)
  sCadena.Add( ' --SALIDAS QUE NO PROVIENEN DE UN TRANSITO DE ALICANTE ' );
  sCadena.Add( ' select empresa_sc empresa,      ');
  sCadena.Add( '        centro_salida_sc centro, ' );
  sCadena.Add( '        es_comunitario_c comunitario, ' );
  sCadena.Add( '        pais_c pais, ' );
  sCadena.Add( '        representante_c representante, ');
  sCadena.Add( '        (select estomate_p from frf_productos where producto_p = producto_sl ) estomate, ' );
  sCadena.Add( '        producto_sl producto, ' );
  sCadena.Add( '        cliente_sl cliente, ' );
  sCadena.Add( '        0 transito, ' );
  sCadena.Add( '        fecha_sl fecha, ' );
  sCadena.Add( '        n_albaran_sl referencia, ' );
  sCadena.Add( '        categoria_sl categoria, ' );
  sCadena.Add( '        sum(kilos_sl) kilos,  ');
  sCadena.Add( '        sum(cajas_sl) cajas,  ');
  sCadena.Add( '        sum(n_palets_sl) palets,  ');
  sCadena.Add( '        SUM(importe_neto_sl) neto ');
  sCadena.Add( ' from frf_salidas_c, frf_salidas_l, frf_clientes, frf_productos ' );


  if AParametros.bGrupoEmp = 0 then
    sCadena.Add( ' where ((empresa_sc = ''050'') or (empresa_sc = ''080''))' )
  else if AParametros.bGrupoEmp = 1 then
    sCadena.Add( ' where ((empresa_sc = ''F17'') or (empresa_sc = ''F18'') or (empresa_sc = ''F23'') or (empresa_sc = ''F42'') )' )
  else
    sCadena.Add( ' where empresa_sc = ' + QuotedStr( AParametros.sEmpresa ) );


  sCadena.Add( ' and fecha_sc between :fechaini and :fechafin ' );

  sCadena.Add( ' and empresa_sl = empresa_sc ' );
  sCadena.Add( ' and centro_salida_sl = centro_salida_sc ' );
  sCadena.Add( ' and fecha_sl = fecha_sc ' );
  sCadena.Add( ' and n_albaran_sl = n_albaran_sc ' );

    (*TODO*)(*20070304*)
  sCadena.add( '     --SALIDAS PENINSULARES ');
  sCadena.add( ' AND centro_salida_sl <> ''6'' ');
  sCadena.Add( '     --SALIDAS DIRECTAS ' );
  sCadena.Add(' AND ( nvl(es_transito_sc,0) =  0 ) ');

      //NO QUIERO LAS LINEAS QUE VENGAN DE UN TRANSITO AL EXTANJERO
  sCadena.add('  and not ( nvl(es_transito_sc,0) = 1 and (select pais_c from frf_clientes where cliente_sal_sc = cliente_c) <> ''ES'' ) ');

  sCadena.add('  AND NOT EXISTS ');
  sCadena.add('       (SELECT * FROM FRF_TRANSITOS_L  ');
  sCadena.add('        WHERE EMPRESA_TL = empresa_sc ' );
  sCadena.add('         AND CENTRO_ORIGEN_TL = CENTRO_ORIGEN_SL  ');
  sCadena.add('         AND REFERENCIA_TL = REF_TRANSITOS_SL  ');
  sCadena.add('         AND FECHA_TL  between :fechainitran and :fechafintran  ');
  sCadena.add('         AND ( CENTRO_DESTINO_TL IN  ');
  sCadena.add('               ( select centro_c from frf_centros where nvl(pais_c,''ES'') <> ''ES'' ) ) ) ');

(*
  sCadena.Add( ' AND ( ref_transitos_sl is null OR ' );
  sCadena.Add( '     --SALIDAS QUE NO PROVENGAN DE UN TRANSITO DE ALICANTE ' );
  sCadena.Add( '       ( not exists ( select * from frf_transitos_l ' );
  sCadena.Add( '                      where empresa_tl = empresa_sc ' );
  sCadena.Add( '                        and centro_tl = ''1'' ' );
  sCadena.Add( '                        and referencia_tl = ref_transitos_sl ' );
  sCadena.Add( '                        and fecha_tl between :fechainitran and :fechafintran ' );
  sCadena.Add( '                        and centro_origen_tl = centro_origen_sl ' );
  sCadena.Add( '                    ) ' );
  sCadena.Add( '       ) ' );
  sCadena.Add( '     ) ' );
*)

  sCadena.Add( ' and cliente_c = cliente_sl ' );
  sCadena.Add( '  and producto_p = producto_sl ');

  if AParametros.sProducto <> '' then
    sCadena.Add( ' and producto_p = ' + QuotedStr( AParametros.sProducto ) );

  case AParametros.iTipo of
    0: sCadena.Add( ' and pais_c <> ''ES'' ' );
    1: sCadena.Add( ' and pais_c <> ''ES'' and es_comunitario_c = ''S'' ' );
    2: sCadena.Add( ' and es_comunitario_c = ''N'' ' );
    3: sCadena.Add( ' and pais_c = ' + QuotedStr( AParametros.sPais ) );
  end;
  sCadena.Add( ' group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ' );
{ // Comentado 18/05/2021 Carmen -- Actualmente no hacemos transitos a otros paises

  //LOS TrANSITOS SON TODOS A PAISES COMUNITARIOS
  (*HACER*)
  //Algo para saber si un pais es comunitario
  (*PARCHE*)
  //DE MOMENTO SÓLO HAY TRANSITOS A ALEMANIA "DE" Y INGLATERRA "GB"
  if ( AParametros.iTipo = 0 ) or //Todos los paises
     ( AParametros.iTipo = 1 ) or //Clientes comunitarios
     ( ( AParametros.iTipo = 3 ) and ( ( AParametros.sPais = 'DE' ) or ( AParametros.sPais = 'GB' ) ) ) then
  begin
    sCadena.Add( ' UNION ' );

    sCadena.Add( ' --TRANSITOS DE ALICANTE ' );
    sCadena.Add( ' select empresa_tl empresa, ');
    sCadena.Add( '        centro_tl centro, ' );
    sCadena.Add( '        ''S'' comunitario, ' );
    sCadena.Add( '        case when centro_destino_tl = ''D'' then ''DE'' else ''GB'' end pais, ' );
    sCadena.Add( '        '''' representante, ');
    sCadena.Add( '        (select estomate_p from frf_productos where producto_p = producto_tl ) estomate, ' );
    sCadena.Add( '        producto_tl producto, ' );
    sCadena.Add( '        centro_destino_tl cliente, ' );
    sCadena.Add( '        1 transito, ' );
    sCadena.Add( '        fecha_tl fecha, ' );
    sCadena.Add( '        referencia_tl referencia, ' );
    sCadena.Add( '        categoria_tl categoria, ' );
    sCadena.Add( '        sum(kilos_tl) kilos, ' );
    sCadena.Add( '        sum(cajas_tl) cajas,  ');
    sCadena.Add( '        sum(palets_tl) palets,  ');
    sCadena.Add( '        0 neto   ');
    sCadena.Add( ' from frf_transitos_l, frf_productos ' );

    if AParametros.bGrupoEmp = 0 then
      sCadena.Add( ' where ((empresa_tl = ''050'') or (empresa_tl = ''080''))' )
    else if APArametros.bGrupoEmp = 1 then
      sCadena.Add( ' where ((empresa_tl = ''F17'') or (empresa_tl = ''F18'') or (empresa_tl = ''F23'') or (empresa_tl = ''F42'') )' )
    else
      sCadena.Add( ' where empresa_tl = ' + QuotedStr( AParametros.sEmpresa ) );

    sCadena.Add( ' and fecha_tl between :fechaini and :fechafin ' );
    sCadena.Add( ' and centro_tl = ''1'' ' );
    sCadena.Add( ' and centro_destino_tl <> ''6'' ' );
    sCadena.Add( ' and producto_p = producto_tl ');
    if AParametros.iTipo = 3 then
    begin
      if AParametros.sPais = 'DE' then
      begin
        sCadena.Add( ' and centro_destino_tl = ''D'' ');
      end
      else
      begin
        sCadena.Add( ' and centro_destino_tl <> ''D'' ');
      end;
    end;

    if AParametros.sProducto <> '' then
      sCadena.Add (' and producto_p = ' + QuotedStr( AParametros.sProducto ) );

    sCadena.Add( ' group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ' );

  end;
}
  sCadena.Add( ' order by 1, 2, 3, 4 desc, 4, 5, 6, 7, 8, 9, 10, 11, 12  ' );

  result:= sCadena.Text;
  FreeAndNil( sCadena );
end;

procedure TDLListControlIntrasat.ObtenerDatos( AParametros: RParametrosListControlIntrasat );
begin
  QListControlIntrasat.Close;
  QListControlIntrasat.SQL.Clear;
  QListControlIntrasat.SQL.Text:= GetTextoSQL( AParametros );
  QListControlIntrasat.ParamByName('fechaini').AsDate:= AParametros.dFechaDesde;
  QListControlIntrasat.ParamByName('fechafin').AsDate:= AParametros.dFechaHasta;
  QListControlIntrasat.ParamByName('fechainitran').AsDate:= AParametros.dFechaDesde - 60;
  QListControlIntrasat.ParamByName('fechafintran').AsDate:= AParametros.dFechaHasta + 30;
  QListControlIntrasat.Open;
end;

end.
