unit FacturasParaAnticiparData;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMFacturasParaAnticipar = class(TDataModule)
    qryFacturas: TQuery;
    mtResumen: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sPais: string;
    dFechaIni, dFechaFin: TDateTime;
    iPaises: Integer;

    procedure CrearTablaTemporal;
    procedure PreparaQuerys;
    procedure DesPreparaQuerys;

    function  ObtenerDatos( var AMsg: string ): boolean;
    function  GrabarDatos( var AMsg: string ): boolean;

  public
    { Public declarations }
  end;

  function ExecuteFacturasParaAnticipar( const AOwner: TComponent;
                                    const AEmpresa, APais: String; const APaises: Integer;
                                    const AFechaIni, AFechaFin: TDateTime;
                                    var AMsg: string  ): boolean;


implementation

{$R *.dfm}

uses
  FacturasParaAnticiparReport, bMath, CGlobal;

var
  DMFacturasParaAnticipar: TDMFacturasParaAnticipar;

function ExecuteFacturasParaAnticipar( const AOwner: TComponent;
                                  const AEmpresa, APais: String; const APaises: Integer;
                                  const AFechaIni, AFechaFin: TDateTime;
                                  var AMsg: string  ): boolean;
begin
  DMFacturasParaAnticipar:= TDMFacturasParaAnticipar.Create( AOwner );

  //CODIGO
  try
    with DMFacturasParaAnticipar do
    begin
      sEmpresa:= AEmpresa;
      sPais:= APais;
      iPaises:= APaises;
      dFechaIni:= AFechaIni;
      dFechaFin:= AFechaFin;

      PreparaQuerys;
      result:= ObtenerDatos( AMsg );
      if result then
      begin
        mtResumen.Open;
        try
          result:= GrabarDatos( AMsg );
          if result then
          begin
            mtResumen.SortFields:='cod_cliente;sociedad;cod_factura';
            mtResumen.Sort([]);
            PrintFacturasParaAnticipar( AOwner, AEmpresa, APais, APaises, AFechaIni, AFechaFin );
          end;
        except
          mtResumen.Close;
        end;
      end;
    end;
  finally
    FreeAndNil( DMFacturasParaAnticipar );
  end;
end;


procedure TDMFacturasParaAnticipar.DataModuleCreate(Sender: TObject);
begin
  CrearTablaTemporal;
end;

procedure TDMFacturasParaAnticipar.DataModuleDestroy(Sender: TObject);
begin
  DesPreparaQuerys;
end;

procedure TDMFacturasParaAnticipar.CrearTablaTemporal;
begin
  with mtResumen do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('sociedad', ftstring, 30, False);
    FieldDefs.Add('cod_cliente', ftstring, 3, False);
    FieldDefs.Add('nombre', ftstring, 30, False);

    FieldDefs.Add('cod_factura', ftstring, 15, False);
    FieldDefs.Add('fecha_factura', ftDate, 0, False);
    FieldDefs.Add('importe_neto', ftFloat, 0, False);
    FieldDefs.Add('moneda', ftstring, 3, False);
    FieldDefs.Add('fecha_cobro', ftDate, 0, False);
    FieldDefs.Add('pais', ftstring, 30, False);
    FieldDefs.Add('fecha_albaran', ftDate, 0, False);
    FieldDefs.Add('cod_albaran', ftstring, 15, False);
    FieldDefs.Add('fecha_cmr', ftDate, 0, False);
    FieldDefs.Add('n_cmr', ftstring, 15, False);

    //cobrado
    //n_albaran
    CreateTable;
  end;
end;

function SubQueryPais( const AIgual: boolean ): string;
var
  SQL: TStringList;
begin
  SQL:= TStringList.Create;
  SQL.Add('   and exists ');
  SQL.Add('   ( ');
  SQL.Add('    select * ');
  SQL.Add('    from frf_clientes ');
  SQL.Add('    where cliente_c = cod_cliente_fc ');
  if AIgual then
    SQL.Add('      and pais_c = :pais ')
  else
    SQL.Add('      and pais_c <> :pais ');
  SQL.Add('   ) ');
  result:= SQL.Text;
  FreeAndNil( SQL );
end;


procedure TDMFacturasParaAnticipar.PreparaQuerys;
begin
  with qryFacturas do
  begin
    SQL.Clear;
    SQL.Add(' select case when substr(cod_empresa_fac_fc,1,1) = ''F'' ');
    SQL.Add('             then ''BONNYSA AGROALIMENTARIA, S.A.'' ');
    SQL.Add('             else ''S.A.T. Nº 9359 BONNYSA'' ');
    SQL.Add('        end sociedad, ');
    SQL.Add('        cod_cliente_fc cod_cliente, nombre_c nombre, ');
    SQL.Add('        fecha_factura_fc fecha_factura, ');
    SQL.Add('        cod_factura_fc cod_factura, ');
    SQL.Add('        round(importe_neto_fc,2) importe_neto, moneda_fc moneda, ');
    SQL.Add('        sum( case when fecha_vencimiento_rc < today then importe_cobrado_rf else 0 end ) cobrado, ');

    SQL.Add('        case when fecha_vencimiento_rc is not null ');
    SQL.Add('             then fecha_vencimiento_rc ');
    SQL.Add('             else nvl(prevision_tesoreria_fc,prevision_cobro_fc) ');
    SQL.Add('        end fecha_cobro, ');

    SQL.Add('        descripcion_p pais, ');
    SQL.Add('        fecha_sc fecha_albaran, ');
    SQL.Add('        n_albaran_sc n_albaran, ');
    SQL.Add('        case when substr(cod_empresa_fac_fc,1,1) = ''F'' ');
    SQL.Add('             then empresa_sc || centro_salida_sc || ');
    SQL.Add('                  trim( case when n_albaran_sc > 10000 then cast( n_albaran_sc as char( 5 ) ) ');
    SQL.Add('                       when n_albaran_sc > 1000 then ''0'' || cast( n_albaran_sc as char( 5 ) ) ');
    SQL.Add('                       when n_albaran_sc > 100 then ''00'' || cast( n_albaran_sc as char( 5 ) ) ');
    SQL.Add('                       when n_albaran_sc > 10 then ''000'' || cast( n_albaran_sc as char( 5 ) ) ');
    SQL.Add('                       else ''000'' || cast( n_albaran_sc as char( 5 ) ) ');
    SQL.Add('                  end )  || ');
    SQL.Add('                  case when empresa_sc = ''F17'' then ''1'' ');
    SQL.Add('                       when empresa_sc = ''F18'' then ''2'' ');
    SQL.Add('                       when empresa_sc = ''F21'' then ''3'' ');
    SQL.Add('                       when empresa_sc = ''F23'' then ''4'' ');
    SQL.Add('                       when empresa_sc = ''F24'' then ''5'' ');
    SQL.Add('                       when empresa_sc = ''F42'' then ''6'' ');
    SQL.Add('                       else ''0'' ');
    SQL.Add('                  end ');
    SQL.Add('             else cast( n_albaran_sc as char( 6 ) ) ');
    SQL.Add('        end cod_albaran, ');
    SQL.Add('        Trim( cast( ''A'' || n_albaran_sc as char(7) ) ) n_cmr, ');
    SQL.Add('        fecha_sc fecha_cmr ');

    SQL.Add(' from tfacturas_cab ');
    SQL.Add('      join frf_salidas_c on cod_empresa_fac_fc = empresa_fac_sc and n_factura_fc = n_factura_sc and fecha_factura_fc = fecha_factura_sc and cod_serie_fac_fc = serie_fac_sc');
    SQL.Add('      join frf_clientes on cod_cliente_fc = cliente_c ');
    SQL.Add('      join frf_paises on pais_c = pais_p ');
    SQL.Add('      left join tremesas_fac on cod_factura_fc = cod_factura_rf ');
    SQL.Add('      left join tremesas_cab on empresa_remesa_rf = empresa_remesa_rc and n_remesa_rf = n_remesa_rc ');
    //SQL.Add(' where ( substr(cod_empresa_fac_fc,1,1) = ''F'' or ');
    //SQL.Add('         cod_empresa_fac_fc = ''050'' or ');
    //SQL.Add('         cod_empresa_fac_fc = ''080'' ) ');
    //SQL.Add(' and   cod_empresa_fac_fc = :empresa ');

    if sEmpresa = 'BAG' then
      SQL.Add(' where cod_empresa_fac_fc[1,1] = ''F'' ')
    else
    if sEmpresa = 'SAT' then
      SQL.Add(' where ( cod_empresa_fac_fc = ''050'' or cod_empresa_fac_fc = ''080'' ) ')
    else
      SQL.Add(' where cod_empresa_fac_fc = :empresa ');

    SQL.Add(' and   fecha_factura_fc between :fechaini and :fechafin ');

      if sPais = '' then
      begin
        case iPaises of
          1:
          begin
            sPais:= 'ES';
            SQL.Add( SubQueryPais( true ) );
          end;
          2:
          begin
            sPais:= 'ES';
            SQL.Add( SubQueryPais( false ) );
          end;
        end;
      end
      else
      begin
        SQL.Add( SubQueryPais( true ) );
      end;

    SQL.Add(' group by  sociedad, cod_cliente, nombre, fecha_factura, cod_factura, ');
    SQL.Add('        importe_neto, moneda, fecha_cobro,pais, fecha_albaran, n_albaran, ');
    SQL.Add('        cod_albaran, n_cmr, fecha_cmr ');
    SQL.Add(' order by sociedad, cod_cliente, nombre, fecha_factura, cod_factura, ');
    SQL.Add('        importe_neto, moneda, fecha_cobro,pais, ');
    SQL.Add('        fecha_albaran, n_albaran ');

    //SQL.SaveToFile('c:\pepe.sql');

  end;
end;


procedure TDMFacturasParaAnticipar.DesPreparaQuerys;
var
  i: integer;
begin
  for i:= 0 to ComponentCount - 1 do
  begin
    if ( Components[i] is TQuery ) then
    begin
      with Components[i] as TQuery do
      begin
        Close;
        if Prepared then
          UnPrepare;
      end;
    end;
  end;
end;

function TDMFacturasParaAnticipar.ObtenerDatos( var AMsg: string ): boolean;
begin
  result:= True;

  with qryFacturas do
  begin
    if ( sEmpresa <> 'BAG' ) and ( sEmpresa <> 'SAT' ) then
      ParamByName('empresa').AsString:= sEmpresa;
    if sPais <> ''  then
      ParamByName('pais').AsString:= sPais;
    ParamByName('fechaIni').AsdateTime:= dFechaIni;
    ParamByName('fechaFin').AsdateTime:= dFechaFin;
    Open;
    if IsEmpty then
    begin
      result:= false;
      AMsg:= 'Sin facturas para los parametros introducidos.';
    end;
  end;
end;


function TDMFacturasParaAnticipar.GrabarDatos( var AMsg: string ): boolean;
var Aux: currency;
begin
  while not qryFacturas.Eof do
  begin
    with mtResumen do
    begin
      Aux := abs(qryFacturas.FieldByName('importe_neto').AsFloat - qryFacturas.FieldByName('cobrado').AsFloat);
      if (qryFacturas.FieldByName('importe_neto').AsFloat <> qryFacturas.FieldByName('cobrado').AsFloat) and
         (Aux <> 0.01)  then
      begin
        Insert;
        FieldByName('sociedad').Asstring:= qryFacturas.FieldByName('sociedad').Asstring;
        FieldByName('cod_cliente').Asstring:= qryFacturas.FieldByName('cod_cliente').Asstring;
        FieldByName('nombre').Asstring:= qryFacturas.FieldByName('nombre').Asstring;
        FieldByName('pais').Asstring:= qryFacturas.FieldByName('pais').Asstring;

        FieldByName('cod_factura').Asstring:= qryFacturas.FieldByName('cod_factura').Asstring;
        FieldByName('fecha_factura').AsDateTime:= qryFacturas.FieldByName('fecha_factura').AsDateTime;
        FieldByName('fecha_cobro').AsDateTime:= qryFacturas.FieldByName('fecha_cobro').AsDateTime;

        FieldByName('importe_neto').AsFloat:= qryFacturas.FieldByName('importe_neto').AsFloat - qryFacturas.FieldByName('cobrado').AsFloat;
        FieldByName('moneda').Asstring:= qryFacturas.FieldByName('moneda').Asstring;

        FieldByName('cod_albaran').Asstring:= qryFacturas.FieldByName('cod_albaran').Asstring;
        FieldByName('fecha_albaran').AsDateTime:= qryFacturas.FieldByName('fecha_albaran').AsDateTime;

        FieldByName('n_cmr').Asstring:= qryFacturas.FieldByName('n_cmr').Asstring;
        FieldByName('fecha_cmr').AsDateTime:= qryFacturas.FieldByName('fecha_cmr').AsDateTime;

        Post;
      end;
    end;
    qryFacturas.Next;
  end;
  qryFacturas.Close;
  result:= true;
end;


end.
