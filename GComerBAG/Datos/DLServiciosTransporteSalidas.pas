unit DLServiciosTransporteSalidas;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMLServiciosTransporteSalidas = class(TDataModule)
    QListado: TQuery;
    mtListado: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declaratio;ns }
    iTransporte: integer;
    sEmpresa, sDesTransporte: string;

    procedure AnyadirRegistro( const AMarca: string; const ATransporte: integer;
                const AMatricula, AAlbaran, ACodPostal, APais, ACliente: String; const AViajes: integer; const AKIlos, AImporte: Real);

    procedure CargarTablaDatos( const AAgrupacion: integer );
    procedure CargarTablaDatosAlbaran;
    procedure CargarTablaDatosDia;
    procedure CargarTablaDatosSemana;
    procedure CargarTablaDatosMes;
    procedure CargarTablaDatosTotal;

    function  DesTransporteLocal( const ATransporte: Integer ): string;
  public
    { Public declarations }
    function ObtenerDatos( const AEmpresa, ACentro, ATransportista,
                                 ACliente, AProducto: string;
                           const AFechaIni, AFechaFin: TDateTime;
                           const ADifVehiculo, ADifDestino, ADifCliente: boolean;
                           const APortes, ADestino: integer;
                           const APaises: string;
                           const AAgrupacion: integer ): boolean;
    procedure LimpiarDatos;
  end;

var
  DMLServiciosTransporteSalidas: TDMLServiciosTransporteSalidas;

implementation

{$R *.dfm}

uses UDMBaseDatos, bMath, bTimeUtils, UDMAuxDB, UDMCambioMoneda;

procedure TDMLServiciosTransporteSalidas.DataModuleCreate(Sender: TObject);
begin
  with mtListado do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('marca', ftString, 10, False);
    FieldDefs.Add('transporte', ftInteger, 0, False);
    FieldDefs.Add('desTransporte', ftString, 30, False);
    FieldDefs.Add('matricula', ftString, 20, False);
    FieldDefs.Add('pais', ftString, 3, False);
    FieldDefs.Add('cliente', ftString, 3, False);
    FieldDefs.Add('cod_postal', ftString, 20, False);
    FieldDefs.Add('albaran', ftString, 10, False);
    FieldDefs.Add('viajes', ftInteger, 0, False);
    FieldDefs.Add('kilos', ftFloat, 0, False);
    FieldDefs.Add('importe', ftFloat, 0, False);
    CreateTable;
    IndexDefs.Add('Index1','marca;transporte;matricula;pais;cliente;cod_postal;albaran',[]);
    IndexName:= 'Index1';
    (*
    SortFields:= 'federacion';
    IndexFieldNames:= 'federacion';
    *)
  end;

  sEmpresa:= '';
  iTransporte:= 0;
  sDesTransporte:= '';
end;

function TDMLServiciosTransporteSalidas.DesTransporteLocal( const ATransporte: Integer ): string;
begin
  if ( iTransporte <> ATransporte ) then
  begin
    iTransporte:= ATransporte;
    sDesTransporte:= DesTransporte( sEmpresa, IntToStr( ATransporte ) );
  end;
  result:= sDesTransporte;
end;

procedure TDMLServiciosTransporteSalidas.AnyadirRegistro( const AMarca: string;
            const ATransporte: integer; const AMatricula, AAlbaran, ACodPostal, APais, ACliente: String;
            const AViajes: integer; const AKIlos, AImporte: Real);
begin
  with mtListado do
  begin
    Insert;
    FieldByName('marca').AsString:= AMarca;
    FieldByName('matricula').AsString:= AMatricula;
    FieldByName('albaran').AsString:= AAlbaran;
    FieldByName('transporte').AsInteger:= ATransporte;
    FieldByName('desTransporte').AsString:= DesTransporteLocal( ATransporte );
    FieldByName('cod_postal').AsString:= ACodPostal;
    FieldByName('pais').AsString:= APais;
    FieldByName('cliente').AsString:= ACliente;
    FieldByName('viajes').AsInteger:= AViajes;
    FieldByName('kilos').AsFloat:= AKilos;
    FieldByName('importe').AsFloat:= AImporte;
    Post;
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatosAlbaran;
var
  dFecha: TDateTime;
  iTransporte, iViajes: Integer;
  sMatricula, sCodPostal, sPais, sCliente, sAlbaran: string;
  rKilos, rImporte: Real;
begin
  with QListado do
  begin
    dFecha:= StrToDate('1/1/1990');
    sAlbaran:= '';
    iTransporte:= -1;
    sMatricula:= '';
    sCodPostal:= '';
    sCliente:= '';
    spais:= '';
    rKilos:= 0;
    rImporte:= 0;
    iViajes:= 0;

    while not Eof do
    begin
      if ( dFecha = FieldByName('fecha_sc').AsDateTime ) and
         ( sAlbaran = FieldByName('albaran').AsString ) and
         ( iTransporte = FieldByName('transporte_sc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_sc').AsString ) and
         ( sCodPostal = FieldByName('cod_postal').AsString ) and
         ( sPais = FieldByName('pais').AsString ) and
         ( sCliente = FieldByName('cliente').AsString ) then
      begin
        Inc( iViajes );
        rKilos:= rKilos + FieldByName('kilos_sl').AsFloat;
        rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat);
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( FormatDateTime( 'dd/mm/yy', dFecha ), iTransporte, sMatricula, SAlbaran, sCodPostal,
                           sPais, sCliente, iViajes, rKilos, rImporte  );
        end;
        dFecha:= FieldByName('fecha_sc').AsDateTime;
        sAlbaran:= FieldByName('albaran').AsString;
        iTransporte:= FieldByName('transporte_sc').AsInteger;
        sMatricula:= FieldByName('vehiculo_sc').AsString;
        sCodPostal:= FieldByName('cod_postal').AsString;
        sPais:= FieldByName('pais').AsString;
        sCliente:= FieldByName('cliente').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_sl').AsFloat;
        rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat);
      end;
      Next;
    end;
    AnyadirRegistro( FormatDateTime( 'dd/mm/yy',  dFecha ), iTransporte, sMatricula, SAlbaran, sCodPostal,
                           sPais, sCliente, iViajes, rKilos, rImporte  );
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatosDia;
var
  dFecha: TDateTime;
  iTransporte, iViajes: Integer;
  sMatricula, sCodPostal, sPais, sCliente: string;
  rKilos, rImporte: Real;
begin
  with QListado do
  begin
    dFecha:= StrToDate('1/1/1990');
    iTransporte:= -1;
    sMatricula:= '';
    sCodPostal:= '';
    sCliente:= '';
    spais:= '';
    rKilos:= 0;
    rImporte:= 0;
    iViajes:= 0;

    while not Eof do
    begin
      if ( dFecha = FieldByName('fecha_sc').AsDateTime ) and
         ( iTransporte = FieldByName('transporte_sc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_sc').AsString ) and
         ( sCodPostal = FieldByName('cod_postal').AsString ) and
         ( sPais = FieldByName('pais').AsString ) and
         ( sCliente = FieldByName('cliente').AsString ) then
      begin
        Inc( iViajes );
        rKilos:= rKilos + FieldByName('kilos_sl').AsFloat;
        rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat);
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( FormatDateTime( 'dd/mm/yy', dFecha ), iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, iViajes, rKilos, rImporte  );
        end;
        dFecha:= FieldByName('fecha_sc').AsDateTime;
        iTransporte:= FieldByName('transporte_sc').AsInteger;
        sMatricula:= FieldByName('vehiculo_sc').AsString;
        sCodPostal:= FieldByName('cod_postal').AsString;
        sPais:= FieldByName('pais').AsString;
        sCliente:= FieldByName('cliente').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_sl').AsFloat;
        rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat);
      end;
      Next;
    end;
    AnyadirRegistro( FormatDateTime( 'dd/mm/yy',  dFecha ), iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, iViajes, rKilos, rImporte  );
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatosMes;
var
  iTransporte, iViajes: Integer;
  sMatricula, sSemana, sCodPostal, sPais, sCliente: string;
  rKilos, rImporte: Real;
begin
  with QListado do
  begin
    sSemana:= '199001';
    iTransporte:= -1;
    sMatricula:= '';
    sCodPostal:= '';
    sCliente:= '';
    sPais:= '';
    rKilos:= 0;
    rImporte:= 0;
    iViajes:= 0;

    while not Eof do
    begin
      if ( sSemana = AnyoMes( FieldByName('fecha_sc').AsDateTime ) ) and
         ( iTransporte = FieldByName('transporte_sc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_sc').AsString ) and
         ( sCodPostal = FieldByName('cod_postal').AsString ) and
         ( sPais = FieldByName('pais').AsString ) and
         ( sCliente = FieldByName('cliente').AsString ) then
      begin
        Inc( iViajes );
        rKilos:= rKilos + FieldByName('kilos_sl').AsFloat;
        rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat);
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( sSemana, iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, iViajes, rKilos, rImporte  );
        end;
        sSemana:= AnyoMes( FieldByName('fecha_sc').AsDateTime );
        iTransporte:= FieldByName('transporte_sc').AsInteger;
        sMatricula:= FieldByName('vehiculo_sc').AsString;
        sCodPostal:= FieldByName('cod_postal').AsString;
        sPais:= FieldByName('pais').AsString;
        sCliente:= FieldByName('cliente').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_sl').AsFloat;
        rImporte:= ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat);
      end;
      Next;
    end;
    AnyadirRegistro( sSemana, iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, iViajes, rKilos, rImporte  );
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatosSemana;
var
  iTransporte, iViajes: Integer;
  sMatricula, sSemana, sCodPostal, sPais, sCliente: string;
  rKilos, rImporte: Real;
begin
  with QListado do
  begin
    sSemana:= '199001';
    iTransporte:= -1;
    sMatricula:= '';
    sCodPostal:= '';
    sCliente:= '';
    sPais:= '';
    rKilos:= 0;
    rImporte:= 0;
    iViajes:= 0;

    while not Eof do
    begin
      if ( sSemana = AnyoSemana( FieldByName('fecha_sc').AsDateTime ) ) and
         ( iTransporte = FieldByName('transporte_sc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_sc').AsString ) and
         ( sCodPostal = FieldByName('cod_postal').AsString ) and
         ( sPais = FieldByName('pais').AsString ) and
         ( sCliente = FieldByName('cliente').AsString ) then
      begin
        Inc( iViajes );
        rKilos:= rKilos + FieldByName('kilos_sl').AsFloat;
        rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat);
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( sSemana, iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, iViajes, rKilos, rImporte  );
        end;
        sSemana:= AnyoSemana( FieldByName('fecha_sc').AsDateTime );
        iTransporte:= FieldByName('transporte_sc').AsInteger;
        sMatricula:= FieldByName('vehiculo_sc').AsString;
        sCodPostal:= FieldByName('cod_postal').AsString;
        sPais:= FieldByName('pais').AsString;
        sCliente:= FieldByName('cliente').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_sl').AsFloat;
        rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat);
      end;
      Next;
    end;
    AnyadirRegistro( sSemana, iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, iViajes, rKilos, rImporte  );
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatosTotal;
var
  iTransporte, iViajes: Integer;
  sMatricula, sCodPostal, sPais, sCliente: string;
  rKilos, rImporte: Real;
begin
  with QListado do
  begin
    iTransporte:= -1;
    sMatricula:= '';
    sCodPostal:= '';
    sCliente:= '';
    sPais:= '';
    rKilos:= 0;
    rImporte:= 0;
    iViajes:= 0;

    while not Eof do
    begin
      if ( iTransporte = FieldByName('transporte_sc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_sc').AsString )  and
         ( sCodPostal = FieldByName('cod_postal').AsString ) and
         ( sPais = FieldByName('pais').AsString ) and
         ( sCliente = FieldByName('cliente').AsString ) then
      begin
        Inc( iViajes );
        rKilos:= rKilos + FieldByName('kilos_sl').AsFloat;
        rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat);
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( '', iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, iViajes, rKilos, rImporte  );
        end;
        iTransporte:= FieldByName('transporte_sc').AsInteger;
        sMatricula:= FieldByName('vehiculo_sc').AsString;
        sCodPostal:= FieldByName('cod_postal').AsString;
        sPais:= FieldByName('pais').AsString;
        sCliente:= FieldByName('cliente').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_sl').AsFloat;
        rImporte:= ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat);
      end;
      Next;
    end;
    AnyadirRegistro( '', iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, iViajes, rKilos, rImporte  );
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatos( const AAgrupacion: integer );
begin
  case AAgrupacion of
    0: CargarTablaDatosAlbaran;
    1: CargarTablaDatosDia;
    2: CargarTablaDatosSemana;
    3: CargarTablaDatosMes;
    4: CargarTablaDatosTotal;
  end;
end;

function TDMLServiciosTransporteSalidas.ObtenerDatos( const AEmpresa, ACentro, ATransportista,
                                                            ACliente, AProducto: string;
                                                      const AFechaIni, AFechaFin: TDateTime;
                                                      const ADifVehiculo, ADifDestino, ADifCliente: boolean;
                                                      const APortes, ADestino: integer;
                                                      const APaises: string;
                                                      const AAgrupacion: integer  ): boolean;
begin
  sEmpresa:= AEmpresa;
  mtListado.Open;

  with QListado do
  begin
    SQL.Clear;
    if ADifVehiculo then
      SQL.Add(' select transporte_sc, vehiculo_sc, moneda_sc, ')
    else
      SQL.Add(' select transporte_sc, '''' vehiculo_sc, moneda_sc, ');

    if AAgrupacion = 0 then
      SQL.Add('        n_albaran_sc albaran, ')
    else
      SQL.Add('        '''' albaran, ');

    if ADifDestino then
    begin
      SQL.Add('        case when nvl(cod_postal_c,'''') <> '''' then cod_postal_c ');
      SQL.Add('             else ( select cod_postal_ds from frf_dir_sum where cliente_ds = cliente_sal_sc and dir_sum_ds = dir_sum_sc ) ');
      SQL.Add('        end cod_postal, ');
    end
    else
    begin
      SQL.Add('        '''' cod_postal, ');
    end;

    if ADifCliente then
      SQL.Add('        cliente_c cliente, ')
    else
      SQL.Add('        '''' cliente, ');

    if ADifDestino then
      SQL.Add('        pais_c pais, ')
    else
      SQL.Add('        '''' pais, ');

    SQL.Add('        fecha_sc, vehiculo_sc matricula, '); //esto marca un viaje


    SQL.Add('        sum(kilos_sl) kilos_sl, sum(importe_neto_sl) importe_sl  ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l, frf_clientes ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and fecha_sc between :fechaini and :fechafin ');

    if ACentro <> '' then
      SQL.Add(' and centro_salida_sc = :centro ');

    if ACliente <> '' then
      SQL.Add(' and cliente_sal_sc = :cliente ');

    if ATransportista <> '' then
      SQL.Add(' and transporte_sc = :transportista ');

    case APortes of
      0: SQL.Add(' and nvl(porte_bonny_sc,0) <> 0 ');
      1: SQL.Add(' and nvl(porte_bonny_sc,0) = 0 ');
    end;

    SQL.Add(' and empresa_sl = :empresa ');
    if ACentro <> '' then
      SQL.Add(' and centro_salida_sl = :centro ')
    else
      SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');
    if AProducto <> '' then
      SQL.Add(' and producto_sl = :producto ');

    SQL.Add(' and cliente_c = cliente_sal_sc ');

    case ADestino of
       1: SQL.Add(' and pais_c = ''ES'' ');
       2: begin
            SQL.Add(' and pais_c in  ');
            SQL.Add('               ( select pais_p ');
            SQL.Add('                 from frf_paises ');
            SQL.Add('                 where comunitario_p <> 0 ');
            SQL.Add('                   and pais_p <> ''ES'' ) ');
          end;
       3: begin
            SQL.Add(' and pais_c in  ');
            SQL.Add('               ( select pais_p  ');
            SQL.Add('                 from frf_paises ');
            SQL.Add('                 where comunitario_p <> 0 ) ');
          end;
       4: begin
            SQL.Add(' and pais_c in  ');
            SQL.Add('               ( select pais_p ');
            SQL.Add('                 from frf_paises ');
            SQL.Add('                 where comunitario_p = 0 ) ');
          end;
       5: SQL.Add(' and pais_c <> ''ES'' ');
       6: SQL.Add(' and pais_c in (' + APaises + ')'  );
    end;

    SQL.Add(' group by 1,2,3,4,5,6,7,8,9 ');
    SQL.Add(' order by transporte_sc,vehiculo_sc,pais,cliente,cod_postal,fecha_sc, matricula ');

    ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if ATransportista <> '' then
      ParamByName('transportista').AsString:= ATransportista;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    ParamByName('fechaini').AsDate:= AFechaIni;
    ParamByName('fechafin').AsDate:= AFechaFin;

    Open;
    result:= not isEmpty;
  end;
  CargarTablaDatos( AAgrupacion );
end;

procedure TDMLServiciosTransporteSalidas.LimpiarDatos;
begin
  mtListado.Close;
  QListado.Close;
end;

end.
