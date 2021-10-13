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
                const AMatricula, AAlbaran, ACodPostal, APais, ACliente, ADesCliente: String;
                const AViajes: integer; const AKIlos, AImporte: Real; const AFactura: string );

    procedure CargarTablaDatos( const AAgrupacion: integer; const AImporteALbaran: Boolean );
    procedure CargarTablaDatosAlbaran( const AImporteALbaran: Boolean );
    procedure CargarTablaDatosDia( const AImporteALbaran: Boolean );
    procedure CargarTablaDatosSemana( const AImporteALbaran: Boolean );
    procedure CargarTablaDatosMes( const AImporteALbaran: Boolean );
    procedure CargarTablaDatosTotal( const AImporteALbaran: Boolean );

    function  DesTransporteLocal( const ATransporte: Integer ): string;
  public
    { Public declarations }
    function ObtenerDatos( const AEmpresa, ACentro, ATransportista,
                                 ACliente, AProducto, AEnvase: string;
                           const AFechaIni, AFechaFin: TDateTime;
                           const ATipoImporte, AFacturado: integer;
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
    FieldDefs.Add('des_cliente', ftString, 30, False);
    FieldDefs.Add('cod_postal', ftString, 20, False);
    FieldDefs.Add('albaran', ftString, 10, False);
    FieldDefs.Add('viajes', ftInteger, 0, False);
    FieldDefs.Add('kilos', ftFloat, 0, False);
    FieldDefs.Add('importe', ftFloat, 0, False);
    FieldDefs.Add('factura', ftString, 12, False);
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
            const ATransporte: integer; const AMatricula, AAlbaran, ACodPostal, APais, ACliente, ADesCliente: String;
            const AViajes: integer; const AKIlos, AImporte: Real; const AFactura: string );
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
    FieldByName('des_cliente').AsString:= ADesCliente;
    FieldByName('viajes').AsInteger:= AViajes;
    FieldByName('kilos').AsFloat:= AKilos;
    FieldByName('importe').AsFloat:= AImporte;
    FieldByName('factura').AsString:= AFactura;
    Post;
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatosAlbaran( const AImporteALbaran: Boolean );
var
  dFecha: TDateTime;
  iTransporte, iViajes: Integer;
  sMatricula, sCodPostal, sPais, sCliente, sDesCliente, sAlbaran, sFactura: string;
  rKilos, rImporte, rCoste: Real;
begin
  with QListado do
  begin
    dFecha:= StrToDate('1/1/1990');
    sAlbaran:= '';
    iTransporte:= -1;
    sMatricula:= '';
    sCodPostal:= '';
    sCliente:= '';
    sDesCliente:= '';
    sDesCliente:= '';
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
        if AImporteALbaran then
          rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat)
        else
        begin
          rCoste:= FieldByName('coste_producto').AsFloat;
          if ( FieldByName('coste_todos').AsFloat <> 0 ) and ( FieldByName('kilos_albaran').AsFloat <> 0 ) then
            rCoste:= rCoste + bRoundTo( ( FieldByName('coste_todos').AsFloat / FieldByName('kilos_albaran').AsFloat ) * FieldByName('kilos_sl').AsFloat, 2 );
          rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, rCoste );
        end;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( FormatDateTime( 'dd/mm/yy', dFecha ), iTransporte, sMatricula, SAlbaran, sCodPostal,
                           sPais, sCliente, sDesCliente, iViajes, rKilos, rImporte, sFactura  );
        end;
        dFecha:= FieldByName('fecha_sc').AsDateTime;
        sAlbaran:= FieldByName('albaran').AsString;
        iTransporte:= FieldByName('transporte_sc').AsInteger;
        sMatricula:= FieldByName('vehiculo_sc').AsString;
        sCodPostal:= FieldByName('cod_postal').AsString;
        sPais:= FieldByName('pais').AsString;
        sCliente:= FieldByName('cliente').AsString;
        sDesCliente:= FieldByName('des_cliente').AsString;
        sFactura:= FieldByName('factura').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_sl').AsFloat;
        if AImporteALbaran then
          rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat)
        else
        begin
          rCoste:= FieldByName('coste_producto').AsFloat;
          if ( FieldByName('coste_todos').AsFloat <> 0 ) and ( FieldByName('kilos_albaran').AsFloat <> 0 ) then
            rCoste:= rCoste + bRoundTo( ( FieldByName('coste_todos').AsFloat / FieldByName('kilos_albaran').AsFloat ) * FieldByName('kilos_sl').AsFloat, 2 );
          rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, rCoste );
        end;
      end;
      Next;
    end;
    AnyadirRegistro( FormatDateTime( 'dd/mm/yy',  dFecha ), iTransporte, sMatricula, SAlbaran, sCodPostal,
                           sPais, sCliente, sDesCliente, iViajes, rKilos, rImporte, sFactura );
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatosDia;
var
  dFecha: TDateTime;
  iTransporte, iViajes: Integer;
  sMatricula, sCodPostal, sPais, sDesCliente, sCliente, sServicio, sFactura: string;
  rKilos, rImporte, rCoste: Real;
begin
  with QListado do
  begin
    dFecha:= StrToDate('1/1/1990');
    iTransporte:= -1;
    sMatricula:= '';
    sCodPostal:= '';
    sCliente:= '';
    sDesCliente:= '';
    spais:= '';
    rKilos:= 0;
    rImporte:= 0;
    iViajes:= 0;
    sServicio:= '';

    while not Eof do
    begin
      if ( dFecha = FieldByName('fecha_sc').AsDateTime ) and
         ( iTransporte = FieldByName('transporte_sc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_sc').AsString ) and
         ( sCodPostal = FieldByName('cod_postal').AsString ) and
         ( sPais = FieldByName('pais').AsString ) and
         ( sCliente = FieldByName('cliente').AsString ) then
      begin
        if sServicio <> FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString then
        begin
          sServicio:= FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString;
          Inc( iViajes );
        end;
        rKilos:= rKilos + FieldByName('kilos_sl').AsFloat;
        if AImporteALbaran then
          rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat)
        else
        begin
          rCoste:= FieldByName('coste_producto').AsFloat;
          if ( FieldByName('coste_todos').AsFloat <> 0 ) and ( FieldByName('kilos_albaran').AsFloat <> 0 ) then
            rCoste:= rCoste + bRoundTo( ( FieldByName('coste_todos').AsFloat / FieldByName('kilos_albaran').AsFloat ) * FieldByName('kilos_sl').AsFloat, 2 );          
          rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, rCoste );
        end;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( FormatDateTime( 'dd/mm/yy', dFecha ), iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, sDesCliente, iViajes, rKilos, rImporte, sFactura );
        end;
        dFecha:= FieldByName('fecha_sc').AsDateTime;
        iTransporte:= FieldByName('transporte_sc').AsInteger;
        sMatricula:= FieldByName('vehiculo_sc').AsString;
        sCodPostal:= FieldByName('cod_postal').AsString;
        sPais:= FieldByName('pais').AsString;
        sCliente:= FieldByName('cliente').AsString;
        sDesCliente:= FieldByName('des_cliente').AsString;
        sServicio:= FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString;
        sFactura:= FieldByName('factura').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_sl').AsFloat;
        if AImporteALbaran then
          rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat)
        else
        begin
          rCoste:= FieldByName('coste_producto').AsFloat;
          if ( FieldByName('coste_todos').AsFloat <> 0 ) and ( FieldByName('kilos_albaran').AsFloat <> 0 ) then
            rCoste:= rCoste + bRoundTo( ( FieldByName('coste_todos').AsFloat / FieldByName('kilos_albaran').AsFloat ) * FieldByName('kilos_sl').AsFloat, 2 );          
          rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, rCoste);
        end;
      end;
      Next;
    end;
    AnyadirRegistro( FormatDateTime( 'dd/mm/yy',  dFecha ), iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, sDesCliente, iViajes, rKilos, rImporte, sFactura );
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatosMes;
var
  iTransporte, iViajes: Integer;
  sMatricula, sSemana, sCodPostal, sPais, sDesCliente, sCliente, sServicio, sFactura: string;
  rKilos, rImporte, rCoste: Real;
begin
  with QListado do
  begin
    sSemana:= '199001';
    iTransporte:= -1;
    sMatricula:= '';
    sCodPostal:= '';
    sCliente:= '';
    sDesCliente:= '';
    sPais:= '';
    rKilos:= 0;
    rImporte:= 0;
    iViajes:= 0;
    sServicio:= '';

    while not Eof do
    begin
      if ( sSemana = AnyoMes( FieldByName('fecha_sc').AsDateTime ) ) and
         ( iTransporte = FieldByName('transporte_sc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_sc').AsString ) and
         ( sCodPostal = FieldByName('cod_postal').AsString ) and
         ( sPais = FieldByName('pais').AsString ) and
         ( sCliente = FieldByName('cliente').AsString ) then
      begin
        if sServicio <> FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString then
        begin
          sServicio:= FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString;
          Inc( iViajes );
        end;
        rKilos:= rKilos + FieldByName('kilos_sl').AsFloat;
        if AImporteALbaran then
          rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat)
        else
        begin
          rCoste:= FieldByName('coste_producto').AsFloat;
          if ( FieldByName('coste_todos').AsFloat <> 0 ) and ( FieldByName('kilos_albaran').AsFloat <> 0 ) then
            rCoste:= rCoste + bRoundTo( ( FieldByName('coste_todos').AsFloat / FieldByName('kilos_albaran').AsFloat ) * FieldByName('kilos_sl').AsFloat, 2 );          
          rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, rCoste );
        end;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( sSemana, iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, sDesCliente, iViajes, rKilos, rImporte, sFactura  );
        end;
        sSemana:= AnyoMes( FieldByName('fecha_sc').AsDateTime );
        iTransporte:= FieldByName('transporte_sc').AsInteger;
        sMatricula:= FieldByName('vehiculo_sc').AsString;
        sCodPostal:= FieldByName('cod_postal').AsString;
        sPais:= FieldByName('pais').AsString;
        sCliente:= FieldByName('cliente').AsString;
        sDesCliente:= FieldByName('des_cliente').AsString;
        sServicio:= FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString;
        sFactura:= FieldByName('factura').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_sl').AsFloat;
        if AImporteALbaran then
          rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat)
        else
        begin
          rCoste:= FieldByName('coste_producto').AsFloat;
          if ( FieldByName('coste_todos').AsFloat <> 0 ) and ( FieldByName('kilos_albaran').AsFloat <> 0 ) then
            rCoste:= rCoste + bRoundTo( ( FieldByName('coste_todos').AsFloat / FieldByName('kilos_albaran').AsFloat ) * FieldByName('kilos_sl').AsFloat, 2 );          
          rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, rCoste );
        end;
      end;
      Next;
    end;
    AnyadirRegistro( sSemana, iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, sDesCliente, iViajes, rKilos, rImporte, sFactura  );
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatosSemana;
var
  iTransporte, iViajes: Integer;
  sMatricula, sSemana, sCodPostal, sPais, sDesCliente, sCliente, sServicio, sFactura: string;
  rKilos, rImporte, rCoste: Real;
begin
  with QListado do
  begin
    sSemana:= '199001';
    iTransporte:= -1;
    sMatricula:= '';
    sCodPostal:= '';
    sCliente:= '';
    sDesCliente:= '';
    sPais:= '';
    rKilos:= 0;
    rImporte:= 0;
    iViajes:= 0;
    sServicio:= '';

    while not Eof do
    begin
      if ( sSemana = AnyoSemana( FieldByName('fecha_sc').AsDateTime ) ) and
         ( iTransporte = FieldByName('transporte_sc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_sc').AsString ) and
         ( sCodPostal = FieldByName('cod_postal').AsString ) and
         ( sPais = FieldByName('pais').AsString ) and
         ( sCliente = FieldByName('cliente').AsString ) then
      begin
        if sServicio <> FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString then
        begin
          sServicio:= FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString;
          Inc( iViajes );
        end;

        rKilos:= rKilos + FieldByName('kilos_sl').AsFloat;
        if AImporteALbaran then
          rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat)
        else
        begin
          rCoste:= FieldByName('coste_producto').AsFloat;
          if ( FieldByName('coste_todos').AsFloat <> 0 ) and ( FieldByName('kilos_albaran').AsFloat <> 0 ) then
            rCoste:= rCoste + bRoundTo( ( FieldByName('coste_todos').AsFloat / FieldByName('kilos_albaran').AsFloat ) * FieldByName('kilos_sl').AsFloat, 2 );          
          rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, rCoste );
        end;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( sSemana, iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, sDesCliente, iViajes, rKilos, rImporte, sFactura  );
        end;
        sSemana:= AnyoSemana( FieldByName('fecha_sc').AsDateTime );
        iTransporte:= FieldByName('transporte_sc').AsInteger;
        sMatricula:= FieldByName('vehiculo_sc').AsString;
        sCodPostal:= FieldByName('cod_postal').AsString;
        sPais:= FieldByName('pais').AsString;
        sCliente:= FieldByName('cliente').AsString;
        sDesCliente:= FieldByName('des_cliente').AsString;
        sServicio:= FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString;
        sFactura:= FieldByName('factura').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_sl').AsFloat;
        if AImporteALbaran then
          rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat)
        else
        begin
          rCoste:= FieldByName('coste_producto').AsFloat;
          if ( FieldByName('coste_todos').AsFloat <> 0 ) and ( FieldByName('kilos_albaran').AsFloat <> 0 ) then
            rCoste:= rCoste + bRoundTo( ( FieldByName('coste_todos').AsFloat / FieldByName('kilos_albaran').AsFloat ) * FieldByName('kilos_sl').AsFloat, 2 );          
          rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, rCoste );
        end;
      end;
      Next;
    end;
    AnyadirRegistro( sSemana, iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, sDesCliente, iViajes, rKilos, rImporte, sFactura  );
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatosTotal;
var
  iTransporte, iViajes: Integer;
  sMatricula, sCodPostal, sPais, sDesCliente, sCliente, sServicio, sFactura: string;
  rKilos, rImporte, rCoste: Real;
begin
  with QListado do
  begin
    iTransporte:= -1;
    sMatricula:= '';
    sCodPostal:= '';
    sCliente:= '';
    sDesCliente:= '';
    sPais:= '';
    rKilos:= 0;
    rImporte:= 0;
    iViajes:= 0;
    sServicio:= '';

    while not Eof do
    begin
      if ( iTransporte = FieldByName('transporte_sc').AsInteger ) and
         ( sMatricula = FieldByName('vehiculo_sc').AsString )  and
         ( sCodPostal = FieldByName('cod_postal').AsString ) and
         ( sPais = FieldByName('pais').AsString ) and
         ( sCliente = FieldByName('cliente').AsString ) then
      begin
        if sServicio <> FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString then
        begin
          sServicio:= FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString;
          Inc( iViajes );
        end;
        rKilos:= rKilos + FieldByName('kilos_sl').AsFloat;
        if AImporteALbaran then
          rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat)
        else
        begin
          rCoste:= FieldByName('coste_producto').AsFloat;
          if ( FieldByName('coste_todos').AsFloat <> 0 ) and ( FieldByName('kilos_albaran').AsFloat <> 0 ) then
            rCoste:= rCoste + bRoundTo( ( FieldByName('coste_todos').AsFloat / FieldByName('kilos_albaran').AsFloat ) * FieldByName('kilos_sl').AsFloat, 2 );
          rImporte:= rImporte + ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, rCoste );
        end;
      end
      else
      begin
        if iTransporte <> -1 then
        begin
          AnyadirRegistro( '', iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, sDesCliente, iViajes, rKilos, rImporte, sFactura  );
        end;
        iTransporte:= FieldByName('transporte_sc').AsInteger;
        sMatricula:= FieldByName('vehiculo_sc').AsString;
        sCodPostal:= FieldByName('cod_postal').AsString;
        sPais:= FieldByName('pais').AsString;
        sCliente:= FieldByName('cliente').AsString;
        sDesCliente:= FieldByName('des_cliente').AsString;
        sServicio:= FieldByName('fecha_sc').AsString + FieldByName('matricula').AsString;
        sFactura:= FieldByName('factura').AsString;
        iViajes:= 1;
        rKilos:= FieldByName('kilos_sl').AsFloat;
        if AImporteALbaran then
          rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, FieldByName('importe_sl').AsFloat)
        else
        begin
          rCoste:= FieldByName('coste_producto').AsFloat;
          if ( FieldByName('coste_todos').AsFloat <> 0 ) and ( FieldByName('kilos_albaran').AsFloat <> 0 ) then
            rCoste:= rCoste + bRoundTo( ( FieldByName('coste_todos').AsFloat / FieldByName('kilos_albaran').AsFloat ) * FieldByName('kilos_sl').AsFloat, 2 );
          rImporte:=  ChangeToEuro( FieldByName('moneda_sc').AsString, FieldByName('fecha_sc').AsDateTime, rCoste );
        end;
      end;
      Next;
    end;
    AnyadirRegistro( '', iTransporte, sMatricula, '', sCodPostal,
                           sPais, sCliente, sDesCliente, iViajes, rKilos, rImporte, sFactura  );
  end;
end;

procedure TDMLServiciosTransporteSalidas.CargarTablaDatos( const AAgrupacion: Integer; const AImporteALbaran: Boolean );
begin
  case AAgrupacion of
    0: CargarTablaDatosAlbaran( AImporteALbaran );
    1: CargarTablaDatosDia( AImporteALbaran );
    2: CargarTablaDatosSemana( AImporteALbaran );
    3: CargarTablaDatosMes( AImporteALbaran );
    4: CargarTablaDatosTotal( AImporteALbaran );
  end;
end;

function TDMLServiciosTransporteSalidas.ObtenerDatos( const AEmpresa, ACentro, ATransportista,
                                                            ACliente, AProducto, AEnvase: string;
                                                      const AFechaIni, AFechaFin: TDateTime;
                                                      const ATipoImporte, AFacturado: integer;
                                                      const ADifVehiculo, ADifDestino, ADifCliente: boolean;
                                                      const APortes, ADestino: integer;
                                                      const APaises: string;
                                                      const AAgrupacion: integer  ): boolean;
var
  sProductoAux: string;
begin
  sEmpresa:= AEmpresa;
  mtListado.Open;

  if ( AProducto = '' ) then
  begin
    if ( AEnvase <> '' ) then
    begin
      sProductoAux:= '';
      with QListado do
      begin
        SQL.Clear;
        SQL.Add(' select distinct producto_p ');
        SQL.Add(' from frf_envases, frf_productos ');
        SQL.Add(' where empresa_e = :empresa ');
        SQL.Add(' and envase_e = :envase ');
        SQL.Add(' and empresa_p = empresa_e ');
        SQL.Add(' and producto_base_e = producto_base_p ');
        ParamByName('empresa').AsString:= AEmpresa;
        ParamByName('envase').AsString:= AEnvase;
        Open;
        while not Eof do
        begin
          if sProductoAux = '' then
          begin
            sProductoAux:= QuotedStr( FieldByName('producto_p').AsString );
          end
          else
          begin
            sProductoAux:= sProductoAux + ',' + QuotedStr( FieldByName('producto_p').AsString );
          end;
          Next;
        end;
      end;
    end;
  end
  else
  begin
    sProductoAux:= QuotedStr( AProducto );
  end;

  with QListado do
  begin
    SQL.Clear;
    SQL.Add('   select empresa_sc, centro_salida_sc, n_albaran_sc, fecha_sc, vehiculo_sc matricula, '); //esto marca un viaje

    if ADifVehiculo then
      SQL.Add('  transporte_sc, vehiculo_sc, moneda_sc, ')
    else
      SQL.Add('  transporte_sc, '''' vehiculo_sc, moneda_sc, ');

    if AAgrupacion = 0 then
      SQL.Add('        n_albaran_sc albaran, ')
    else
      SQL.Add('        '''' albaran, ');

    if ADifDestino then
    begin
      SQL.Add('        case when nvl(cod_postal_c,'''') <> '''' then cod_postal_c ');
      SQL.Add('             else ( select cod_postal_ds from frf_dir_sum where empresa_ds = empresa_sc and cliente_ds = cliente_sal_sc and dir_sum_ds = dir_sum_sc ) ');
      SQL.Add('        end cod_postal, ');
    end
    else
    begin
      SQL.Add('        '''' cod_postal, ');
    end;

    if ADifCliente then
    begin
      SQL.Add('        cliente_c cliente, nombre_c des_cliente,')
    end
    else
      SQL.Add('        '''' cliente, '''' des_cliente, ');

    if ADifDestino then
      SQL.Add('        pais_c pais, ')
    else
      SQL.Add('        '''' pais, ');

    if ATipoImporte = 0 then
    begin
      SQL.Add('        0 coste_producto,  ');
      SQL.Add('        0 coste_todos, ');
      SQL.Add('        0 kilos_albaran, ');
      SQL.Add('        '''' factura, ');
    end
    else
    begin
      if sProductoAux <> '' then
      begin
        SQL.Add('        ( select sum(importe_g) from frf_gastos ');
        SQL.Add('           where empresa_g = empresa_sc and centro_salida_g = centro_salida_sc ');
        SQL.Add('           and n_albaran_g = n_albaran_sl and fecha_g = fecha_sl ');
        //SQL.Add('           and ( producto_g in ( ' + sProductoAux + ' ) ) ');
        SQL.Add('           and ( producto_g = producto_sl ) ');
        if ATipoImporte = 1 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''010'' or tipo_g = ''056'' ) ) coste_producto, ')
        else
        if ATipoImporte = 2 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''010'' or tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 3 then
          SQL.Add('           and ( tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 4 then
          SQL.Add('           and tipo_g = ''009'' or tipo_g = ''010'' ) coste_producto, ')
        else
        if ATipoImporte = 5 then
          SQL.Add('           and tipo_g = ''056'' ) coste_producto, ');

        SQL.Add('        ( select sum(importe_g) from frf_gastos ');
        SQL.Add('           where empresa_g = empresa_sc and centro_salida_g = centro_salida_sc ');
        SQL.Add('           and n_albaran_g = n_albaran_sl and fecha_g = fecha_sl ');
        SQL.Add('           and ( producto_g is null ) ');
        if ATipoImporte = 1 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''010'' or tipo_g = ''056'' ) ) coste_todos, ')
        else
        if ATipoImporte = 2 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''010'' or tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 3 then
          SQL.Add('           and ( tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 4 then
          SQL.Add('           and tipo_g = ''009'' or tipo_g = ''010'' ) coste_todos, ')
        else
        if ATipoImporte = 5 then
          SQL.Add('           and tipo_g = ''056'' ) coste_todos, ');

        SQL.Add('        ( select sum(slaux.kilos_sl) from frf_salidas_l slaux ');
        SQL.Add('           where slaux.empresa_sl = empresa_sc and slaux.centro_salida_sl = centro_salida_sc ');
        SQL.Add('           and slaux.n_albaran_sl = n_albaran_sc and slaux.fecha_sl = fecha_sc ) kilos_albaran,');
      end
      else
      begin
        SQL.Add('        ( select sum(importe_g) from frf_gastos ');
        SQL.Add('           where empresa_g = empresa_sc and centro_salida_g = centro_salida_sc ');
        SQL.Add('           and n_albaran_g = n_albaran_sl and fecha_g = fecha_sl ');
        if ATipoImporte = 1 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''010'' or tipo_g = ''056'' ) ) coste_producto, ')
        else
        if ATipoImporte = 2 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''010'' or tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 3 then
          SQL.Add('           and ( tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 4 then
          SQL.Add('           and tipo_g = ''009'' or tipo_g = ''010'' ) coste_producto, ')
        else
        if ATipoImporte = 5 then
          SQL.Add('           and tipo_g = ''056'' ) coste_producto, ');

        SQL.Add('           0 coste_todos, ');
        SQL.Add('           0 kilos_albaran, ');
      end;


      SQL.Add('        ( select max(ref_fac_g) from frf_gastos ');
      SQL.Add('           where empresa_g = empresa_sc and centro_salida_g = centro_salida_sc ');
      SQL.Add('           and n_albaran_g = n_albaran_sl and fecha_g = fecha_sl ');
      if sProductoAux <> '' then
        //SQL.Add('           and ( producto_g in ( ' + sProductoAux + ' ) or producto_g is null ) ');
        SQL.Add('           and ( producto_g = producto_sl or producto_g is null ) ');  
      if ( ATipoImporte = 1 ) or ( ATipoImporte = 2 )  or ( ATipoImporte = 4 ) then
        SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''010'' ) ) factura, ')
      else
      if ( ATipoImporte = 3 ) then
        SQL.Add('           and tipo_g = ''011'' ) factura, ')
      else
      if ATipoImporte = 5 then
        SQL.Add('           and tipo_g = ''056'' ) factura, ');
    end;

    SQL.Add('        sum(kilos_sl) kilos_sl, sum(importe_neto_sl) importe_sl  ');

    SQL.Add(' from frf_salidas_c sc, frf_salidas_l sl, frf_clientes c');
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
    if sProductoAux <> '' then
      SQL.Add(' and producto_sl in ( ' + sProductoAux + ' ) ');
    if AEnvase <> '' then
      SQL.Add(' and envase_sl = :envase ');

    SQL.Add(' and empresa_c = :empresa ');
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

    if ( ATipoImporte  = 1 ) or ( ATipoImporte = 2 ) or ( ATipoImporte = 4 ) then
    begin
      case AFacturado of
        1: //Con factura gasto 009+010
        begin
          SQL.Add('        and ( select Trim(max(ref_fac_g)) from frf_gastos ');
          SQL.Add('           where empresa_g = empresa_sc and centro_salida_g = centro_salida_sc ');
          SQL.Add('           and n_albaran_g = n_albaran_sl and fecha_g = fecha_sl ');
          if sProductoAux <> '' then
            //SQL.Add('           and ( producto_g in ( ' + sProductoAux + ' ) or producto_g is null ) ');
            SQL.Add('           and ( producto_g = producto_sl or producto_g is null ) ');
          SQL.Add('           and tipo_g = ''009'' ) <> '''' ');
        end;
        2: //Sin factura gasto 009+010
        begin
          SQL.Add('        and ( select Trim(max(ref_fac_g)) from frf_gastos ');
          SQL.Add('           where empresa_g = empresa_sc and centro_salida_g = centro_salida_sc ');
          SQL.Add('           and n_albaran_g = n_albaran_sl and fecha_g = fecha_sl ');
          if sProductoAux <> '' then
            //SQL.Add('           and ( producto_g in ( ' + sProductoAux + ' ) or producto_g is null ) ');
            SQL.Add('           and ( producto_g = producto_sl or producto_g is null ) ');
          SQL.Add('           and tipo_g = ''009''  ) = '''' ');
        end;
      end;
    end;

    SQL.Add(' group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17 ');
    SQL.Add(' order by transporte_sc,vehiculo_sc,pais,cliente,cod_postal,fecha_sc, matricula ');

    ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
      ParamByName('centro').AsString:= ACentro;
    if ATransportista <> '' then
      ParamByName('transportista').AsString:= ATransportista;
    if ACliente <> '' then
      ParamByName('cliente').AsString:= ACliente;
    //if sProductoAux <> '' then
    //  ParamByName('producto').AsString:= sProductoAux;
    if AEnvase <> '' then
      ParamByName('envase').AsString:= AEnvase;
    ParamByName('fechaini').AsDate:= AFechaIni;
    ParamByName('fechafin').AsDate:= AFechaFin;

    Open;

    result:= not isEmpty;
  end;
  CargarTablaDatos( AAgrupacion, ATipoImporte = 0 );
end;

procedure TDMLServiciosTransporteSalidas.LimpiarDatos;
begin
  mtListado.Close;
  QListado.Close;
end;

end.
