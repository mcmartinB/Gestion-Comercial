unit DLServiciosTransporteEntregas;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMLServiciosTransporteEntregas = class(TDataModule)
    QListado: TQuery;
    mtListado: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declaratio;ns }
    iTransporte: integer;
    sEmpresa, sDesTransporte: string;

    procedure AnyadirRegistro( const AMarca: string; const ATransporte: integer;
                const AMatricula: String; const AViajes: integer; const AKIlos: Real);

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
                           const AVehiculo: boolean;
                           const APortes, AAgrupacion: integer ): boolean;
    procedure LimpiarDatos;
  end;

var
  DMLServiciosTransporteEntregas: TDMLServiciosTransporteEntregas;

implementation

{$R *.dfm}

uses UDMBaseDatos, bMath, bTimeUtils, UDMAuxDB, UDMCambioMoneda;

procedure TDMLServiciosTransporteEntregas.DataModuleCreate(Sender: TObject);
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

function TDMLServiciosTransporteEntregas.DesTransporteLocal( const ATransporte: Integer ): string;
begin
  if ( iTransporte <> ATransporte ) then
  begin
    iTransporte:= ATransporte;
    sDesTransporte:= DesTransporte( sEmpresa, IntToStr( ATransporte ) );
  end;
  result:= sDesTransporte;
end;

procedure TDMLServiciosTransporteEntregas.AnyadirRegistro( const AMarca: string;
            const ATransporte: integer; const AMatricula: String;
            const AViajes: integer; const AKIlos: Real);
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
    Post;
  end;
end;

procedure TDMLServiciosTransporteEntregas.CargarTablaDatosDia;
var
  dFecha: TDateTime;
  iTransporte, iViajes: Integer;
  sMatricula: string;
  rKilos: Real;
begin
  with QListado do
  begin
    dFecha:= StrToDate('1/1/1990');
    iTransporte:= -1;
    sMatricula:= '';
    rKilos:= 0;
    iViajes:= 0;

    while not Eof do
    begin
      if ( dFecha = FieldByName('fecha_origen_ec').AsDateTime ) and
         ( iTransporte = FieldByName('transporte_ec').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_ec').AsString ) then
      begin
        Inc( iViajes );
        rKilos:= rKilos + FieldByName('kilos_el').AsFloat;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( FormatDateTime( 'dd/mm/yy', dFecha ), iTransporte, sMatricula, iViajes, rKilos  );
        end;
        dFecha:= FieldByName('fecha_origen_ec').AsDateTime;
        iTransporte:= FieldByName('transporte_ec').AsInteger;
        sMatricula:= FieldByName('vehiculo_ec').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_el').AsFloat;
      end;
      Next;
    end;
    AnyadirRegistro( FormatDateTime( 'dd/mm/yy',  dFecha ), iTransporte, sMatricula, iViajes, rKilos  );
  end;
end;

procedure TDMLServiciosTransporteEntregas.CargarTablaDatosMes;
var
  iTransporte, iViajes: Integer;
  sMatricula, sSemana: string;
  rKilos: Real;
begin
  with QListado do
  begin
    sSemana:= '199001';
    iTransporte:= -1;
    sMatricula:= '';
    rKilos:= 0;
    iViajes:= 0;

    while not Eof do
    begin
      if ( sSemana = AnyoMes( FieldByName('fecha_origen_ec').AsDateTime ) ) and
         ( iTransporte = FieldByName('transporte_ec').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_ec').AsString ) then
      begin
        Inc( iViajes );
        rKilos:= rKilos + FieldByName('kilos_el').AsFloat;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( sSemana, iTransporte, sMatricula, iViajes, rKilos  );
        end;
        sSemana:= AnyoMes( FieldByName('fecha_origen_ec').AsDateTime );
        iTransporte:= FieldByName('transporte_ec').AsInteger;
        sMatricula:= FieldByName('vehiculo_ec').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_el').AsFloat;
      end;
      Next;
    end;
    AnyadirRegistro( sSemana, iTransporte, sMatricula, iViajes, rKilos  );
  end;
end;

procedure TDMLServiciosTransporteEntregas.CargarTablaDatosSemana;
var
  iTransporte, iViajes: Integer;
  sMatricula, sSemana: string;
  rKilos: Real;
begin
  with QListado do
  begin
    sSemana:= '199001';
    iTransporte:= -1;
    sMatricula:= '';
    rKilos:= 0;
    iViajes:= 0;

    while not Eof do
    begin
      if ( sSemana = AnyoSemana( FieldByName('fecha_origen_ec').AsDateTime ) ) and
         ( iTransporte = FieldByName('transporte_ec').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_ec').AsString ) then
      begin
        Inc( iViajes );
        rKilos:= rKilos + FieldByName('kilos_el').AsFloat;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( sSemana, iTransporte, sMatricula, iViajes, rKilos  );
        end;
        sSemana:= AnyoSemana( FieldByName('fecha_origen_ec').AsDateTime );
        iTransporte:= FieldByName('transporte_ec').AsInteger;
        sMatricula:= FieldByName('vehiculo_ec').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_el').AsFloat;
      end;
      Next;
    end;
    AnyadirRegistro( sSemana, iTransporte, sMatricula, iViajes, rKilos  );
  end;
end;

procedure TDMLServiciosTransporteEntregas.CargarTablaDatosTotal;
var
  iTransporte, iViajes: Integer;
  sMatricula: string;
  rKilos: Real;
begin
  with QListado do
  begin
    iTransporte:= -1;
    sMatricula:= '';
    rKilos:= 0;
    iViajes:= 0;

    while not Eof do
    begin
      if ( iTransporte = FieldByName('transporte_ec').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_ec').AsString ) then
      begin
        Inc( iViajes );
        rKilos:= rKilos + FieldByName('kilos_el').AsFloat;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( '', iTransporte, sMatricula, iViajes, rKilos  );
        end;
        iTransporte:= FieldByName('transporte_ec').AsInteger;
        sMatricula:= FieldByName('vehiculo_ec').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_el').AsFloat;
      end;
      Next;
    end;
    AnyadirRegistro( '', iTransporte, sMatricula, iViajes, rKilos  );
  end;
end;

procedure TDMLServiciosTransporteEntregas.CargarTablaDatos( const AAgrupacion: integer );
begin
  case AAgrupacion of
    0: CargarTablaDatosDia;
    1: CargarTablaDatosSemana;
    2: CargarTablaDatosMes;
    3: CargarTablaDatosTotal;
  end;
end;

function TDMLServiciosTransporteEntregas.ObtenerDatos( const AEmpresa, ACentroSalida, ACentroLlegada, ATransportista, AProducto: string;
                                                        const AFechaIni, AFechaFin: TDateTime;
                                                        const AVehiculo: boolean;
                                                        const APortes, AAgrupacion: integer ): boolean;
begin
  sEmpresa:= AEmpresa;
  mtListado.Open;

  with QListado do
  begin
    SQL.Clear;

    if AVehiculo then
      SQL.Add(' select transporte_ec, vehiculo_ec, fecha_origen_ec, vehiculo_ec matricula, ')
    else
      SQL.Add(' select transporte_ec, '''' vehiculo_ec, fecha_origen_ec,  vehiculo_ec matricula, ');
    SQL.Add('        sum(kilos_el) kilos_el  ');
    SQL.Add(' from frf_entregas_c, frf_entregas_l ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and fecha_origen_ec between :fechaini and :fechafin ');

    if ACentroSalida <> '' then
      SQL.Add(' and centro_origen_ec = :centroSalida ');
    if ACentroLlegada <> '' then
      SQL.Add(' and centro_llegada_ec = :centroLlegada ');

    if ATransportista <> '' then
      SQL.Add(' and transporte_ec = :transportista ');

    case APortes of
      0: SQL.Add(' and nvl(portes_pagados_ec,0) <> 0 ');
      1: SQL.Add(' and nvl(portes_pagados_ec,0) = 0 ');
    end;

    SQL.Add(' and codigo_el = codigo_ec ');
    if AProducto <> '' then
      SQL.Add(' and producto_el = :producto ');

    SQL.Add(' group by 1,2,3,4 ');
    SQL.Add(' order by 1,2,3,4 ');

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

procedure TDMLServiciosTransporteEntregas.LimpiarDatos;
begin
  mtListado.Close;
  QListado.Close;
end;

end.
