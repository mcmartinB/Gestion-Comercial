unit DLServiciosTransporteTransitos;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMLServiciosTransporteTransitos = class(TDataModule)
    QListado: TQuery;
    mtListado: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declaratio;ns }
    iTransporte: integer;
    sEmpresa, sDesTransporte: string;

    procedure AnyadirRegistro( const AMarca: string; const ATransporte: integer;
                const AMatricula: String; const AViajes: integer; const AKIlos, AImporte: Real);

    procedure CargarTablaDatos( const AAgrupacion: integer );
    procedure CargarTablaDatosDia;
    procedure CargarTablaDatosSemana;
    procedure CargarTablaDatosMes;
    procedure CargarTablaDatosTotal;

    function  DesTransporteLocal( const ATransporte: Integer ): string;
  public
    { Public declarations }
    function ObtenerDatos( const AEmpresa, ACentroSalida, ACentroLlegada, ATransportista, AProducto: string;
                           const AFechaIni, AFechaFin: TDateTime;
                           const AImporteGasto, AVehiculo: boolean;
                           const APortes, AAgrupacion: integer ): boolean;
    procedure LimpiarDatos;
  end;

var
  DMLServiciosTransporteTransitos: TDMLServiciosTransporteTransitos;

implementation

{$R *.dfm}

uses UDMBaseDatos, bMath, bTimeUtils, UDMAuxDB, UDMCambioMoneda;

procedure TDMLServiciosTransporteTransitos.DataModuleCreate(Sender: TObject);
begin
  with mtListado do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('marca', ftString, 10, False);
    FieldDefs.Add('transporte', ftInteger, 0, False);
    FieldDefs.Add('desTransporte', ftString, 30, False);
    FieldDefs.Add('matricula', ftString, 20, False);
    FieldDefs.Add('viajes', ftInteger, 0, False);
    FieldDefs.Add('kilos', ftFloat, 0, False);
    FieldDefs.Add('coste', ftFloat, 0, False);
    CreateTable;
    IndexDefs.Add('Index1','marca;transporte;matricula',[]);
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

function TDMLServiciosTransporteTransitos.DesTransporteLocal( const ATransporte: Integer ): string;
begin
  if ( iTransporte <> ATransporte ) then
  begin
    iTransporte:= ATransporte;
    sDesTransporte:= DesTransporte( sEmpresa, IntToStr( ATransporte ) );
  end;
  result:= sDesTransporte;
end;

procedure TDMLServiciosTransporteTransitos.AnyadirRegistro( const AMarca: string;
            const ATransporte: integer; const AMatricula: String;
            const AViajes: integer; const AKIlos, AImporte: Real);
begin
  with mtListado do
  begin
    Insert;
    FieldByName('marca').AsString:= AMarca;
    FieldByName('matricula').AsString:= AMatricula;
    FieldByName('transporte').AsInteger:= ATransporte;
    FieldByName('desTransporte').AsString:= DesTransporteLocal( ATransporte );
    FieldByName('viajes').AsInteger:= AViajes;
    FieldByName('kilos').AsFloat:= AKilos;
    FieldByName('coste').AsFloat:= AImporte;
    Post;
  end;
end;

procedure TDMLServiciosTransporteTransitos.CargarTablaDatosDia;
var
  dFecha: TDateTime;
  iTransporte, iViajes: Integer;
  sMatricula, sServicio: string;
  rKilos, rImporte: Real;
begin
  with QListado do
  begin
    dFecha:= StrToDate('1/1/1990');
    iTransporte:= -1;
    sMatricula:= '';
    rKilos:= 0;
    iViajes:= 0;
    sServicio:= '';

    while not Eof do
    begin
      if ( dFecha = FieldByName('fecha_tc').AsDateTime ) and
         ( iTransporte = FieldByName('transporte_tc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_tc').AsString ) then
      begin
        if sServicio <> FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString then
        begin
          sServicio:= FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString;
          Inc( iViajes );
        end;
        rKilos:= rKilos + FieldByName('kilos_tl').AsFloat;
        rImporte:= rImporte + FieldByName('coste').AsFloat;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( FormatDateTime( 'dd/mm/yy', dFecha ), iTransporte, sMatricula, iViajes, rKilos, rImporte  );
        end;
        dFecha:= FieldByName('fecha_tc').AsDateTime;
        iTransporte:= FieldByName('transporte_tc').AsInteger;
        sMatricula:= FieldByName('vehiculo_tc').AsString;
        sServicio:= FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_tl').AsFloat;
        rImporte:= FieldByName('coste').AsFloat;
      end;
      Next;
    end;
    AnyadirRegistro( FormatDateTime( 'dd/mm/yy',  dFecha ), iTransporte, sMatricula, iViajes, rKilos, rImporte  );
  end;
end;

procedure TDMLServiciosTransporteTransitos.CargarTablaDatosMes;
var
  iTransporte, iViajes: Integer;
  sMatricula, sSemana, sServicio: string;
  rKilos, rImporte: Real;
begin
  with QListado do
  begin
    sSemana:= '199001';
    iTransporte:= -1;
    sMatricula:= '';
    rKilos:= 0;
    iViajes:= 0;
    sServicio:= '';

    while not Eof do
    begin
      if ( sSemana = AnyoMes( FieldByName('fecha_tc').AsDateTime ) ) and
         ( iTransporte = FieldByName('transporte_tc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_tc').AsString ) then
      begin
        if sServicio <> FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString then
        begin
          sServicio:= FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString;
          Inc( iViajes );
        end;
        rKilos:= rKilos + FieldByName('kilos_tl').AsFloat;
        rImporte:= rImporte + FieldByName('coste').AsFloat;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( sSemana, iTransporte, sMatricula, iViajes, rKilos, rImporte  );
        end;
        sSemana:= AnyoMes( FieldByName('fecha_tc').AsDateTime );
        iTransporte:= FieldByName('transporte_tc').AsInteger;
        sMatricula:= FieldByName('vehiculo_tc').AsString;
        sServicio:= FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_tl').AsFloat;
        rImporte:= FieldByName('coste').AsFloat;
      end;
      Next;
    end;
    AnyadirRegistro( sSemana, iTransporte, sMatricula, iViajes, rKilos , rImporte );
  end;
end;

procedure TDMLServiciosTransporteTransitos.CargarTablaDatosSemana;
var
  iTransporte, iViajes: Integer;
  sMatricula, sSemana, sServicio: string;
  rKilos, rImporte: Real;
begin
  with QListado do
  begin
    sSemana:= '199001';
    iTransporte:= -1;
    sMatricula:= '';
    rKilos:= 0;
    iViajes:= 0;
    sServicio:= '';

    while not Eof do
    begin
      if ( sSemana = AnyoSemana( FieldByName('fecha_tc').AsDateTime ) ) and
         ( iTransporte = FieldByName('transporte_tc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_tc').AsString ) then
      begin
        if sServicio <> FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString then
        begin
          sServicio:= FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString;
          Inc( iViajes );
        end;
        rKilos:= rKilos + FieldByName('kilos_tl').AsFloat;
        rImporte:= rImporte + FieldByName('coste').AsFloat;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( sSemana, iTransporte, sMatricula, iViajes, rKilos, rImporte  );
        end;
        sSemana:= AnyoSemana( FieldByName('fecha_tc').AsDateTime );
        iTransporte:= FieldByName('transporte_tc').AsInteger;
        sMatricula:= FieldByName('vehiculo_tc').AsString;
        sServicio:= FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_tl').AsFloat;
        rImporte:= FieldByName('coste').AsFloat;
      end;
      Next;
    end;
    AnyadirRegistro( sSemana, iTransporte, sMatricula, iViajes, rKilos, rImporte  );
  end;
end;

procedure TDMLServiciosTransporteTransitos.CargarTablaDatosTotal;
var
  iTransporte, iViajes: Integer;
  sMatricula, sServicio: string;
  rKilos, rImporte: Real;
begin
  with QListado do
  begin
    iTransporte:= -1;
    sMatricula:= '';
    rKilos:= 0;
    iViajes:= 0;
    sServicio:= '';

    while not Eof do
    begin
      if ( iTransporte = FieldByName('transporte_tc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_tc').AsString ) then
      begin
        if sServicio <> FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString then
        begin
          sServicio:= FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString;
          Inc( iViajes );
        end;
        rKilos:= rKilos + FieldByName('kilos_tl').AsFloat;
        rImporte:= rImporte + FieldByName('coste').AsFloat;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( '', iTransporte, sMatricula, iViajes, rKilos, rImporte  );
        end;
        iTransporte:= FieldByName('transporte_tc').AsInteger;
        sMatricula:= FieldByName('vehiculo_tc').AsString;
        sServicio:= FieldByName('fecha_tc').AsString + FieldByName('matricula').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_tl').AsFloat;
        rImporte:= FieldByName('coste').AsFloat;
      end;
      Next;
    end;
    AnyadirRegistro( '', iTransporte, sMatricula, iViajes, rKilos, rImporte  );
  end;
end;

procedure TDMLServiciosTransporteTransitos.CargarTablaDatos( const AAgrupacion: integer );
begin
  case AAgrupacion of
    0: CargarTablaDatosDia;
    1: CargarTablaDatosSemana;
    2: CargarTablaDatosMes;
    3: CargarTablaDatosTotal;
  end;
end;

function TDMLServiciosTransporteTransitos.ObtenerDatos( const AEmpresa, ACentroSalida, ACentroLlegada, ATransportista, AProducto: string;
                                                        const AFechaIni, AFechaFin: TDateTime;
                                                        const AImporteGasto, AVehiculo: boolean;
                                                        const APortes, AAgrupacion: integer ): boolean;
begin
  sEmpresa:= AEmpresa;
  mtListado.Open;

  with QListado do
  begin
    SQL.Clear;

    if AVehiculo then
      SQL.Add(' select transporte_tc, vehiculo_tc, empresa_tc, centro_tc, referencia_tc, fecha_tc, vehiculo_tc matricula, ')
    else
      SQL.Add(' select transporte_tc, '''' vehiculo_tc, empresa_tc, centro_tc, referencia_tc, fecha_tc, vehiculo_tc matricula, ');

    if not AImporteGasto then
    begin
      SQL.Add('        0 coste, ');
    end
    else
    begin
      SQL.Add('        ( select sum(importe_gt) from frf_gastos_trans ');
      SQL.Add('           where empresa_gt = empresa_tc and centro_gt = centro_tc ');
//      SQL.Add('           and referencia_gt = referencia_tc and fecha_gt = fecha_tc and tipo_gt = ''011'' ) coste, ');
      SQL.Add('           and referencia_gt = referencia_tc and fecha_gt = fecha_tc and tipo_gt = ''017'' ) coste, ');
    end;

    SQL.Add('        sum(kilos_tl) kilos_tl  ');
    SQL.Add(' from frf_transitos_c, frf_transitos_l ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and fecha_tc between :fechaini and :fechafin ');

    if ACentroSalida <> '' then
      SQL.Add(' and centro_tc = :centroSalida ');
    if ACentroLlegada <> '' then
      SQL.Add(' and centro_destino_tc = :centroLlegada ');

    if ATransportista <> '' then
      SQL.Add(' and transporte_tc = :transportista ');

    case APortes of
      0: SQL.Add(' and nvl(porte_bonny_tc,0) <> 0 ');
      1: SQL.Add(' and nvl(porte_bonny_tc,0) = 0 ');
    end;

    SQL.Add(' and empresa_tl = :empresa ');
    if ACentroSalida <> '' then
      SQL.Add(' and centro_tl = :centroSalida ')
    else
      SQL.Add(' and centro_tl = centro_tc ');
    SQL.Add(' and fecha_tl = fecha_tc ');
    SQL.Add(' and referencia_tl = referencia_tc ');
    if AProducto <> '' then
      SQL.Add(' and producto_tl = :producto ');

    SQL.Add(' group by 1,2,3,4,5,6,7 ');
    SQL.Add(' order by 1,2,6,7 ');

    ParamByName('empresa').AsString:= AEmpresa;
    if ACentroSalida <> '' then
      ParamByName('centroSalida').AsString:= ACentroSalida;
    if ACentroLlegada <> '' then
      ParamByName('centroLlegada').AsString:= ACentroLlegada;
    if ATransportista <> '' then
      ParamByName('transportista').AsString:= ATransportista;
    if AProducto <> '' then
      ParamByName('producto').AsString:= AProducto;
    ParamByName('fechaini').AsDate:= AFechaIni;
    ParamByName('fechafin').AsDate:= AFechaFin;

    Open;
    result:= not isEmpty;
  end;
  CargarTablaDatos( AAgrupacion );
end;

procedure TDMLServiciosTransporteTransitos.LimpiarDatos;
begin
  mtListado.Close;
  QListado.Close;
end;

end.
