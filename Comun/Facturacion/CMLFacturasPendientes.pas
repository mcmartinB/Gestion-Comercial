unit CMLFacturasPendientes;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable, BonnyQuery;

type
  TDMLFacturasPendientes = class(TDataModule)
    QFacturas: TQuery;
    kbmListado: TkbmMemTable;
    qryCarrefour: TQuery;
    kbmClientes: TkbmMemTable;
    qAux: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCliente: string;
    sMoneda: string;
    iFacturas: Integer;
    bDiasTesoreria: Boolean;
    dFechaCobroIni, dFechaCobroFin, dFechaCorte: TDateTime;
    rFactura, rRemesado, rSinRemesar, rCobrado, rPendiente, rACobrarTotal, rACobrarRemesado, rACobrarSinremesar: Real;
    dFactura, dRemesado, dSinRemesar, dCobrado, dPendiente, dACobrar: TDateTime;
    procedure CambiarAlias(const AAlias: string);
    procedure CrearTablasTemporales;
    procedure CargarQuerys(const ATipoCliente, APais, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string; const AFactura, ANacional: Integer; const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros: boolean);
    procedure PutFactura(const ATipo: integer);
    function IsFactura: Boolean;
    procedure AddFactura(const ATipo: integer);
    procedure AddCliente(const ACliente: string);
    procedure InsertFactura(const ATipo: integer);
    procedure ModFactura;
    procedure DeleteFactura;
    procedure EditFactura;
    procedure LimpiaFacturas;
    function BuscarFacturaOrigen(const AFactura: string): string;
  public
    { Public declarations }
    function Ejecutar(const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string; const AFactura, ANacional: Integer; const ACliente, ATipoCliente, APais: string; const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AFechaCobro, AEuros: boolean; const ATipo: integer): boolean;
    function Enviar(const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string; const AFactura, ANacional: Integer; const ACliente, ATipoCliente, APais: string; const AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AFechaCobro, ADiasTesoreria: boolean; const ATipo: integer): boolean;
  end;

procedure UsarModuloDeDatos(const AComponent: TComponent; const AAlias: string);

procedure LiberarModuloDeDatos;

var
  DMLFacturasPendientes: TDMLFacturasPendientes;

implementation

{$R *.dfm}

uses
  UDMBaseDatos, UDMMaster, CQLFacturasPendientes, UDMConfig, Variants, bMath,
  Dialogs, CQLFacturasPendientesCarrefour, DConfigMail, MostrarLogFD, UDMAuxDB,
  CGlobal, DateUtils;

var
  instancias: integer = 0;

procedure UsarModuloDeDatos(const AComponent: TComponent; const AAlias: string);
begin
  Inc(instancias);
  if instancias = 1 then
  begin
    DMLFacturasPendientes := TDMLFacturasPendientes.Create(AComponent);
    DMLFacturasPendientes.CambiarAlias(AAlias);
  end;
end;

procedure LiberarModuloDeDatos;
begin
  Dec(instancias);
  if instancias = 0 then
    FreeAndNil(DMLFacturasPendientes);
end;

procedure TDMLFacturasPendientes.CambiarAlias(const AAlias: string);

  procedure NuevoAlias(const AQuery: TQuery);
  begin
    AQuery.Close;
    AQuery.DatabaseName := AAlias;
  end;

begin
  NuevoAlias(QFacturas);
end;

function SubQueryPais(const AIgual: boolean): string;
var
  SQL: TStringList;
begin
  SQL := TStringList.Create;
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
  result := SQL.Text;
  FreeAndNil(SQL);
end;

procedure TDMLFacturasPendientes.CargarQuerys(const ATipoCliente, APais, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string; const AFactura, ANacional: Integer; const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros: boolean);
var
  sPais: string;
begin
  with QFacturas do
  begin
    Close;
    SQL.Clear;
    (*REMESAS*)
    SQL.Add('  select cod_empresa_fac_fc empresa_f, cod_serie_fac_fc serie_f, cod_cliente_fc cliente_fac_f, fecha_factura_fc fecha_factura_f, ');
    SQL.Add('           n_factura_fc n_factura_f, cod_factura_fc cod_factura_f, tipo_factura_fc tipo_factura_f, tipo_impuesto_fc tipo_impuesto_f, ');
    SQL.Add('           moneda_fc moneda_f, round(importe_total_euros_fc, 2) importe_euros_f, round(importe_total_fc, 2) importe_total_f, ');
    SQL.Add('           prevision_tesoreria_fc prevision_tesoreria_f,  ');
//    SQL.Add('           case tipo_factura_fc when 380 then                   ');
//    SQL.Add('               prevision_tesoreria_fc                           ');
//    SQL.Add('           else                                                 ');
//    SQL.Add('           		fecha_factura_fc                                 ');
//    SQL.Add('           end prevision_tesoreria_f,                           ');
    SQL.Add('           prevision_cobro_fc prevision_cobro_f,                ');
    (*
    SQL.Add('         case when n_remesa_rf is not null ');
    SQL.Add('              then fecha_vencimiento_rc ');
    SQL.Add('              else nvl( prevision_tesoreria_fc , prevision_cobro_fc ) end prevision_tesoreria_f, ');

    SQL.Add('         case when n_remesa_rf  is not null ');
    SQL.Add('              then fecha_vencimiento_rc ');
    SQL.Add('              else nvl( prevision_cobro_fc, fecha_factura_fc ) end prevision_cobro_f, ');
    *)
    SQL.Add('           importe_cobrado_rf importe_cobrado_fr, fecha_vencimiento_rc  fecha_remesa_fr ');

    SQL.Add('    from tfacturas_cab ');
    SQL.Add('         join frf_clientes on cod_cliente_fc = cliente_c ');
    SQL.Add('         left join tremesas_fac on cod_factura_rf = cod_factura_fc ');
    SQL.Add('         left join tremesas_cab on empresa_remesa_rf = empresa_remesa_rc and n_remesa_rc = n_remesa_rf ');

    (*BAG*)
    if sEmpresa = 'BAG' then
      SQL.Add(' where cod_empresa_fac_fc[1,1] = ''F'' ')
    else if sEmpresa = 'SAT' then
      SQL.Add(' where ( cod_empresa_fac_fc = ''050'' or cod_empresa_fac_fc = ''080'' ) ')
    else
      SQL.Add(' where cod_empresa_fac_fc = :empresa ');

    SQL.Add(' and fecha_factura_fc between :fechafacturaini and :fechafacturafin ');

    SQL.Add(' and ( not ( importe_cobrado_rf = importe_total_fc and fecha_vencimiento_rc < today ) or fecha_vencimiento_rc is null ) ');

//    SQL.Add(' and nvl(anulacion_fc,0) <> 1 ');

    case AFactura of
      1:
        SQL.Add('   and NVL(tipo_factura_fc,''380'') = ''380'' ');
      2:
        SQL.Add('   and NVL(tipo_factura_fc,''380'') = ''381'' ');
    end;

    sPais := APais;
    if sCliente <> '' then
    begin
      if AMultiplesCliente then
      begin
        if AExcluirCliente then
          SQL.Add('   and cod_cliente_fc not in (' + sCliente + ') ')
        else
          SQL.Add('   and cod_cliente_fc in (' + sCliente + ') ');
      end
      else
      begin
        if AExcluirCliente then
          SQL.Add('   and cod_cliente_fc <> :cliente ')
        else
          SQL.Add('   and cod_cliente_fc = :cliente ');
      end;
    end
    else
    begin
      if sPais = '' then
      begin
        case ANacional of
          1:
            begin
              sPais := 'ES';
              SQL.Add(SubQueryPais(true));
            end;
          2:
            begin
              sPais := 'ES';
              SQL.Add(SubQueryPais(false));
            end;
        end;
      end
      else
      begin
        SQL.Add(SubQueryPais(true));
      end;
    end;

    if ATipoCliente <> '' then
    begin
      if AExcluirTipoCliente then
      begin
        SQL.Add('   and tipo_cliente_c <> :tipocliente ');
      end
      else
      begin
        SQL.Add('   and tipo_cliente_c = :tipocliente ');
      end;
    end;

    ParamByName('fechafacturaini').AsString := AFechaFacturaIni;
    ParamByName('fechafacturafin').AsString := AFechaFacturaFin;
    if (sEmpresa <> 'BAG') and (sEmpresa <> 'SAT') then
      ParamByName('empresa').AsString := sEmpresa;
    if (sCliente <> '') and (not AMultiplesCliente) then
    begin
      ParamByName('cliente').AsString := sCliente;
    end;
    if ATipoCliente <> '' then
    begin
      ParamByName('tipocliente').AsString := ATipoCliente;
    end;
    if sPais <> '' then
    begin
      ParamByName('pais').AsString := sPais;
    end;
    //SQL.SaveToFile('c:\pepe1.sql');
  end;
end;

procedure TDMLFacturasPendientes.CrearTablasTemporales;
begin
  with kbmListado do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('moneda_f', ftString, 3, False);
    FieldDefs.Add('empresa_f', ftString, 3, False);
    FieldDefs.Add('serie_f', ftString, 3, False);
    FieldDefs.Add('cliente_fac_f', ftString, 3, False);
    FieldDefs.Add('fecha_factura_f', ftDate, 0, False);
    FieldDefs.Add('n_factura_f', ftInteger, 0, False);
    FieldDefs.Add('tipo_factura_f', ftString, 3, False);
    FieldDefs.Add('tipo_impuesto_f', ftString, 3, False);
    FieldDefs.Add('cod_factura_f', ftString, 15, False);
    FieldDefs.Add('cod_factura_origen_f', ftString, 15, False);

    FieldDefs.Add('cod_empresa_albaran_f', ftString, 3, False);
    FieldDefs.Add('cod_centro_albaran_f', ftString, 3, False);
    FieldDefs.Add('n_albaran_f', ftInteger, 0, False);
    FieldDefs.Add('fecha_albaran_f', ftDate, 0, False);

    FieldDefs.Add('importe_factura_f', ftFloat, 0, False);
    FieldDefs.Add('importe_pendiente_f', ftFloat, 0, False);
    FieldDefs.Add('importe_remesado_f', ftFloat, 0, False);
    FieldDefs.Add('importe_cobrado_f', ftFloat, 0, False);
    FieldDefs.Add('importe_acobrar_f', ftFloat, 0, False);
    FieldDefs.Add('remesado_acobrar_f', ftFloat, 0, False);
    FieldDefs.Add('sinremesar_acobrar_f', ftFloat, 0, False);

    FieldDefs.Add('fecha_pendiente_f', ftDate, 0, False);
    FieldDefs.Add('fecha_remesado_f', ftDate, 0, False);
    FieldDefs.Add('fecha_cobrado_f', ftDate, 0, False);
    FieldDefs.Add('fecha_acobrar_f', ftDate, 0, False);

    FieldDefs.Add('cambio_f', ftFloat, 0, False);
    FieldDefs.Add('euros_factura_f', ftFloat, 0, False);
    FieldDefs.Add('euros_pendiente_f', ftFloat, 0, False);
    FieldDefs.Add('euros_remesado_f', ftFloat, 0, False);
    FieldDefs.Add('euros_cobrado_f', ftFloat, 0, False);
    FieldDefs.Add('euros_acobrar_f', ftFloat, 0, False);

    FieldDefs.Add('n_pedido', ftString, 15, False);
    FieldDefs.Add('suministro', ftString, 3, False);
  end;

  with kbmClientes do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cliente_fac_f', ftString, 3, False);
  end;

  with qryCarrefour do
  begin
    SQL.Clear;
    SQL.Add(' select n_pedido_sc, dir_sum_sc ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_fac_sc = :empresa ');
    SQL.Add(' and fecha_factura_sc = :fecha ');
    SQL.Add(' and n_factura_sc = :factura ');
    SQL.Add(' and serie_fac_sc = :serie ');
  end;
end;

procedure TDMLFacturasPendientes.DataModuleCreate(Sender: TObject);
begin
  CrearTablasTemporales;
end;

function TDMLFacturasPendientes.Ejecutar(const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string; const AFactura, ANacional: Integer; const ACliente, ATipoCliente, APais: string; const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AFechaCobro, AEuros: boolean; const ATipo: integer): boolean;
begin
  sEmpresa := AEmpresa;
  sCliente := ACliente;
  sMoneda := '';
  iFacturas := 0;
  bDiasTesoreria := ADiasTesoreria;

  if AFechaCobroIni <> '' then
  begin
    dFechaCobroIni := StrToDate(AFechaCobroIni);
  end
  else
  begin
    dFechaCobroIni := StrToDate('1/1/2000');
  end;
  if AFechaCobroFin <> '' then
  begin
    dFechaCobroFin := StrToDate(AFechaCobroFin);
  end
  else
  begin
    dFechaCobroFin := StrToDate('1/1/2099');
  end;
  dFechaCorte := now;
  //dFechaCorte:= AFechaCobroIni;

  kbmListado.Close;
  kbmListado.Open;
  kbmListado.Filtered := False;

  kbmClientes.Close;
  kbmClientes.Open;

  CargarQuerys(ATipoCliente, APais, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, AFactura, ANacional, ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros);
  QFacturas.Open;
  while not QFacturas.Eof do
  begin
    PutFactura(ATipo);
    QFacturas.Next;
  end;
  LimpiaFacturas;
  QFacturas.Close;

  //Introducir Albaranes Relacionados


  result := not kbmListado.IsEmpty;
  if result then
  begin
    if AEuros then
      //kbmListado.SortFields:= 'cliente_fac_f;empresa_f;fecha_factura_f;n_factura_f'
      kbmListado.SortFields := 'cliente_fac_f;empresa_f;serie_f;cod_factura_origen_f;n_factura_f'
    else
//      kbmListado.SortFields:= 'moneda_f;cliente_fac_f;empresa_f;fecha_factura_f;n_factura_f';
      kbmListado.SortFields := 'moneda_f;cliente_fac_f;empresa_f;serie_f;cod_factura_origen_f;n_factura_f';
    kbmListado.Sort([]);
    if ATipo = 0 then
      CQLFacturasPendientes.Listado(self.Owner, kbmListado, AEmpresa, AFechaCobroIni, AFechaCobroFin, AFechaCobro, AEuros)
    else
      CQLFacturasPendientesCarrefour.Listado(self.Owner, AEmpresa, AFechaCobroIni, AFechaCobroFin, AFechaCobro, AEuros);
  end;
end;

function TDMLFacturasPendientes.Enviar(const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string; const AFactura, ANacional: Integer; const ACliente, ATipoCliente, APais: string; const AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AFechaCobro, ADiasTesoreria: boolean; const ATipo: integer): boolean;
var
  sLog, sAsunto, sCuerpo: string;
  bCancelar: Boolean;
begin
  bCancelar := False;
  sEmpresa := AEmpresa;
  sCliente := ACliente;
  bDiasTesoreria := ADiasTesoreria;
  result := False;
  sLog := '';

  if AFechaCobroIni <> '' then
  begin
    dFechaCobroIni := StrToDate(AFechaCobroIni);
  end
  else
  begin
    dFechaCobroIni := StrToDate('1/1/2000');
  end;
  if AFechaCobroIni <> '' then
  begin
    dFechaCobroFin := StrToDate(AFechaCobroFin);
  end
  else
  begin
    dFechaCobroFin := StrToDate('1/1/2099');
  end;
  dFechaCorte := now;
  //dFechaCorte:= AFechaCobroIni;

  kbmListado.Close;
  kbmListado.Open;
  kbmListado.Filtered := False;

  kbmClientes.Close;
  kbmClientes.Open;

  CargarQuerys(ATipoCliente, APais, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, AFactura, ANacional, ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, False);
  QFacturas.Open;
  while not QFacturas.Eof do
  begin
    PutFactura(ATipo);
    QFacturas.Next;
  end;
  LimpiaFacturas;
  QFacturas.Close;

  kbmListado.Filtered := True;
  kbmClientes.SortFields := 'cliente_fac_f';
  kbmClientes.Sort([]);
  kbmClientes.first;
  while not kbmClientes.Eof and not bCancelar do
  begin

    sCliente := kbmClientes.FieldByName('cliente_fac_f').AsString;
    kbmListado.Filter := 'cliente_fac_f = ' + QuotedStr(sCliente);
    kbmListado.First;

    sMoneda := kbmListado.FieldByName('moneda_f').AsString;
    //if  Pos( '@', EMailCliente( AEmpresa, sCliente, True ) < 1 then
    begin
      iFacturas := 0;

      sAsunto := 'Solicitud estado facturas Bonnysa Agroalimentaria [' + sCliente + ']'; //+ desEmpresa( AEmpresa );
      sCuerpo := 'Ruego informen de la situación de las facturas del listado adjunto, gracias.';
      sCuerpo := sCuerpo + #13 + #10 + 'Please inform about situation of outstanding invoices attached, than you.';
      //sCuerpo:= #13 + #10 + desCliente( sCliente );

      result := (result) or (not kbmListado.IsEmpty);
      if not kbmListado.IsEmpty then
      begin
        kbmListado.SortFields := 'cliente_fac_f;empresa_f;fecha_factura_f;n_factura_f';
        kbmListado.Sort([]);
        if ATipo = 0 then
        begin
          if CQLFacturasPendientes.EnviarListado(self.Owner, kbmListado, AEmpresa, sCliente, AFechaCobroIni, AFechaCobroFin, AFechaCobro, sAsunto, sCuerpo, bCancelar) then
            sLog := sLog + #13 + #10 + ' + ' + AEmpresa + '-' + sCliente + ' -> CORREO ENVIADO ' + sMoneda + ' (' + desCliente(sCliente) + ')'
          else
            sLog := sLog + #13 + #10 + ' - ' + AEmpresa + '-' + sCliente + ' -> ENVIADO CANCELADO ' + sMoneda + ' (' + desCliente(sCliente) + ')';
        end
        else
        begin
          if CQLFacturasPendientesCarrefour.EnviarListado(self.Owner, AEmpresa, sCliente, AFechaCobroIni, AFechaCobroFin, AFechaCobro, sAsunto, sCuerpo, bCancelar) then
            sLog := sLog + #13 + #10 + ' + ' + AEmpresa + '-' + sCliente + ' -> CORREO ENVIADO ' + sMoneda + ' (' + desCliente(sCliente) + ')'
          else
            sLog := sLog + #13 + #10 + ' - ' + AEmpresa + '-' + sCliente + ' -> ENVIADO CANCELADO ' + sMoneda + ' (' + desCliente(sCliente) + ')';
        end;
      end;

    end;
    (*
    else
    begin
      sLog:= sLog + #13 + #10 + '   ' +  AEmpresa + '-' + sCliente + ' -> SIN DIRECCION DE CORREO '  + sMoneda  + ' (' + desCliente( ACliente ) + ')'
    end;
    *)
    kbmClientes.Next;
  end;
  if bCancelar then
  begin
    sLog := sLog + #13 + #10 + ' - PROCESO CANCELADO POR EL USARIO.';
  end;
  MostrarLogFD.MostrarLog(Self, sLog, 'ENVIO INFORME FACTURAS PENDIENTE COBRO');
end;

procedure TDMLFacturasPendientes.PutFactura(const ATipo: integer);
begin
  if not IsFactura then
    AddFactura(ATipo)
  else
    ModFactura;
end;

function TDMLFacturasPendientes.IsFactura: Boolean;
begin
  if kbmListado.Locate('empresa_f;serie_f;fecha_factura_f;n_factura_f', VarArrayOf([QFacturas.FieldByName('empresa_f').AsString, QFacturas.FieldByName('serie_f').AsString, QFacturas.FieldByName('fecha_factura_f').AsString, QFacturas.FieldByName('n_factura_f').AsString]), []) then
    result := True
  else
    result := False;
end;

procedure TDMLFacturasPendientes.AddFactura(const ATipo: integer);
begin
  if QFacturas.FieldByName('fecha_remesa_fr').value = null then
  begin
    //Sin remesa
    rFactura := QFacturas.FieldByName('importe_total_f').AsFloat;
    dFactura := QFacturas.FieldByName('fecha_factura_f').AsDateTime;

    rRemesado := 0;
    dRemesado := 0;

    rSinRemesar := rFactura;
    if bDiasTesoreria then
      dSinRemesar := QFacturas.FieldByName('prevision_tesoreria_f').AsDateTime
    else
      dSinRemesar := QFacturas.FieldByName('prevision_cobro_f').AsDateTime;

    rCobrado := 0;
    dCobrado := 0;

    rPendiente := rFactura;
    if bDiasTesoreria then
      dPendiente := QFacturas.FieldByName('prevision_tesoreria_f').AsDateTime
    else
      dPendiente := QFacturas.FieldByName('prevision_cobro_f').AsDateTime;
  end
  else
  begin
    //Con remesa
    rFactura := QFacturas.FieldByName('importe_total_f').AsFloat;
    dFactura := QFacturas.FieldByName('fecha_factura_f').AsDateTime;

    rRemesado := QFacturas.FieldByName('importe_cobrado_fr').AsFloat;
    dRemesado := QFacturas.FieldByName('fecha_remesa_fr').AsDateTime;

    rSinRemesar := rFactura - rRemesado;
    if bDiasTesoreria then
      dSinRemesar := QFacturas.FieldByName('prevision_tesoreria_f').AsDateTime
    else
      dSinRemesar := QFacturas.FieldByName('prevision_cobro_f').AsDateTime;

    if QFacturas.FieldByName('fecha_remesa_fr').AsDateTime <= dFechaCorte then
    begin
      rCobrado := QFacturas.FieldByName('importe_cobrado_fr').AsFloat;
      dCobrado := dRemesado;
    end
    else
    begin
      rCobrado := 0;
      dCobrado := 0;
    end;

    rPendiente := rFactura - rCobrado;
    dPendiente := dSinRemesar;
    (*
    if dRemesado > dSinRemesar then
    begin
      dPendiente:= dRemesado;
    end
    else
    begin
      dPendiente:= dSinRemesar;
    end;
    *)
  end;

  rACobrarRemesado := 0;
  rACobrarSinremesar := 0;
  dACobrar := 0;

  if rCobrado <> rFactura then
  begin
    if rSinRemesar <> 0 then
    begin
      if (dSinRemesar >= dFechaCobroIni) and (dSinRemesar < dFechaCobroFin) then
      begin
        rACobrarSinremesar := rSinRemesar;
        dACobrar := dPendiente;
      end;
    end;
    if (rRemesado <> 0) and (rCobrado = 0) then
    begin
      if (dRemesado >= dFechaCobroIni) and (dRemesado <= dFechaCobroFin) then
      begin
        rACobrarRemesado := rRemesado;
        (*
        if dRemesado > dACobrar then
          dACobrar:= dRemesado;
        *)
      end;
    end;
    rACobrarTotal := bRoundTo(rACobrarRemesado + rACobrarSinremesar, 2);
    InsertFactura(ATipo);
  end;
end;

function TDMLFacturasPendientes.BuscarFacturaOrigen(const AFactura: string): string;
var
  qAux: TBonnyQuery;
begin

  qAux := TBonnyQuery.Create(self);
  with qAux do
  try
    SQL.Add(' SELECT min(cod_factura_origen_fd) cod_factura_origen_fd ');
    SQL.Add('   from tfacturas_det         ');
    SQL.Add('  where cod_factura_fd = :codigo_factura ');

    ParamByName('codigo_factura').AsString := AFactura;
    Open;
    if not IsEmpty then
      result := FieldByName('cod_factura_origen_fd').AsString
    else
      result := AFactura;

  finally
    free;
  end;

end;

procedure TDMLFacturasPendientes.AddCliente(const ACliente: string);
begin
  if not kbmClientes.Locate('cliente_fac_f', VarArrayOf([ACliente]), []) then
  begin
    kbmClientes.Insert;
    kbmClientes.FieldByName('cliente_fac_f').AsString := ACliente;
    kbmClientes.Post;
  end;
end;

procedure TDMLFacturasPendientes.LimpiaFacturas;
begin
  kbmListado.first;
  while not kbmListado.Eof do
  begin
    AddCliente(kbmListado.FieldByName('cliente_fac_f').AsString);
    if kbmListado.FieldByName('euros_acobrar_f').AsFloat = 0 then
      kbmListado.Delete
    else
      kbmListado.Next;
  end;
end;

procedure TDMLFacturasPendientes.InsertFactura(const ATipo: integer);
var
  sPedido, sSuministro: string;
begin
  with kbmListado do
  begin
    Insert;
    FieldByName('moneda_f').AsString := QFacturas.FieldByName('moneda_f').AsString;
    FieldByName('empresa_f').AsString := QFacturas.FieldByName('empresa_f').AsString;
    FieldByName('serie_f').AsString := QFacturas.FieldByName('serie_f').AsString;
    FieldByName('cliente_fac_f').AsString := QFacturas.FieldByName('cliente_fac_f').AsString;
    FieldByName('fecha_factura_f').AsDateTime := QFacturas.FieldByName('fecha_factura_f').AsDateTime;
    FieldByName('n_factura_f').AsInteger := QFacturas.FieldByName('n_factura_f').AsInteger;
    FieldByName('cod_factura_f').AsString := QFacturas.FieldByName('cod_factura_f').AsString;

    if QFacturas.FieldByName('tipo_factura_f').AsString = '380' then        // Factura
      FieldByName('cod_factura_origen_f').AsString := QFacturas.FieldByName('cod_factura_f').AsString
    else                                                         // Abono
      FieldByName('cod_factura_origen_f').AsString := BuscarFacturaOrigen(QFacturas.FieldByName('cod_factura_f').AsString);

    FieldByName('importe_factura_f').AsFloat := QFacturas.FieldByName('importe_total_f').AsFloat;
    FieldByName('tipo_factura_f').AsString := QFacturas.FieldByName('tipo_factura_f').AsString;
    FieldByName('tipo_impuesto_f').AsString := QFacturas.FieldByName('tipo_impuesto_f').AsString;

    if QFacturas.FieldByName('importe_total_f').AsFloat <> 0 then
    begin
      FieldByName('cambio_f').AsFloat := bRoundTo(QFacturas.FieldByName('importe_euros_f').AsFloat / QFacturas.FieldByName('importe_total_f').AsFloat, 5)
    end
    else
    begin
      FieldByName('cambio_f').AsFloat := 1;
    end;
    if sMoneda = '' then
    begin
      sMoneda := FieldByName('moneda_f').AsString;
    end
    else
    begin
      if sMoneda <> FieldByName('moneda_f').AsString then
        sMoneda := 'ERR';
    end;

    qryCarrefour.ParamByName('empresa').AsString := QFacturas.FieldByName('empresa_f').AsString;
    qryCarrefour.ParamByName('factura').AsInteger := QFacturas.FieldByName('n_factura_f').AsInteger;
    qryCarrefour.ParamByName('fecha').AsDateTime := QFacturas.FieldByName('fecha_factura_f').AsDateTime;
    qryCarrefour.ParamByName('serie').AsString := QFacturas.FieldByName('serie_f').AsString;
    qryCarrefour.Open;
    try
      sPedido := qryCarrefour.FieldByName('n_pedido_sc').AsString;
      ;
      sSuministro := qryCarrefour.FieldByName('dir_sum_sc').AsString;
    finally
      qryCarrefour.Close;
    end;

    FieldByName('n_pedido').AsString := sPedido;

    if ATipo = 0 then
    begin
      FieldByName('suministro').AsString := ''
    end
    else
    begin
      FieldByName('suministro').AsString := sSuministro;
    end;

    FieldByName('importe_remesado_f').AsFloat := rRemesado;
    if dRemesado <> 0 then
      FieldByName('fecha_remesado_f').AsDateTime := dRemesado;

    FieldByName('importe_cobrado_f').AsFloat := rCobrado;
    if dCobrado <> 0 then
      FieldByName('fecha_cobrado_f').AsDateTime := dCobrado;

    FieldByName('remesado_acobrar_f').AsFloat := rACobrarRemesado;
    FieldByName('sinremesar_acobrar_f').AsFloat := rACobrarSinremesar;
    FieldByName('importe_acobrar_f').AsFloat := rACobrarTotal;
    if dACobrar <> 0 then
      FieldByName('fecha_acobrar_f').AsDateTime := dACobrar;

    FieldByName('importe_pendiente_f').AsFloat := rPendiente;
    if dPendiente <> 0 then
      FieldByName('fecha_pendiente_f').AsDateTime := dPendiente;

    FieldByName('euros_factura_f').AsFloat := bRoundTo(FieldByName('cambio_f').AsFloat * FieldByName('importe_factura_f').AsFloat, 2);
    FieldByName('euros_pendiente_f').AsFloat := bRoundTo(FieldByName('cambio_f').AsFloat * FieldByName('importe_pendiente_f').AsFloat, 2);
    FieldByName('euros_remesado_f').AsFloat := bRoundTo(FieldByName('cambio_f').AsFloat * FieldByName('importe_remesado_f').AsFloat, 2);
    FieldByName('euros_cobrado_f').AsFloat := bRoundTo(FieldByName('cambio_f').AsFloat * FieldByName('importe_cobrado_f').AsFloat, 2);
    FieldByName('euros_acobrar_f').AsFloat := bRoundTo(FieldByName('cambio_f').AsFloat * FieldByName('importe_acobrar_f').AsFloat, 2);

    //Datos Albaran
    FieldByName('cod_empresa_albaran_f').AsString := '';
    FieldByName('cod_centro_albaran_f').AsString := '';
    FieldByName('n_albaran_f').AsString := '';
    FieldByName('fecha_albaran_f').AsString := '';

    iFacturas := iFacturas + 1;

    Post;
  end;
end;

procedure TDMLFacturasPendientes.ModFactura;
var
  bCobrado: Boolean;
begin
  //Si hay mas de una factura es por que tiene remesa asignada
  rFactura := QFacturas.FieldByName('importe_total_f').AsFloat;
  dFactura := QFacturas.FieldByName('fecha_factura_f').AsDateTime;

  rRemesado := bRoundTo(kbmListado.FieldByName('importe_remesado_f').AsFloat + QFacturas.FieldByName('importe_cobrado_fr').AsFloat, 2);
  if QFacturas.FieldByName('fecha_remesa_fr').AsDateTime > kbmListado.FieldByName('fecha_remesado_f').AsDateTime then
    dRemesado := QFacturas.FieldByName('fecha_remesa_fr').AsDateTime;

  rSinRemesar := bRoundTo(rFactura - rRemesado, 2);
  if bDiasTesoreria then
    dSinRemesar := QFacturas.FieldByName('prevision_tesoreria_f').AsDateTime
  else
    dSinRemesar := QFacturas.FieldByName('prevision_cobro_f').AsDateTime;

  bCobrado := QFacturas.FieldByName('fecha_remesa_fr').AsDateTime <= dFechaCorte;
  if bCobrado then
  begin
    rCobrado := bRoundTo(kbmListado.FieldByName('importe_cobrado_f').AsFloat + QFacturas.FieldByName('importe_cobrado_fr').AsFloat, 2);
    dCobrado := dRemesado;
  end;

  rPendiente := bRoundTo(rFactura - rCobrado, 2);
  dPendiente := dSinRemesar;

  //Si lo he cobrdo todo, no tengo nada pendiente
  rACobrarRemesado := kbmListado.FieldByName('remesado_acobrar_f').AsFloat;
  rACobrarSinremesar := 0;

  if rSinRemesar <> 0 then
  begin
    if (dSinRemesar >= dFechaCobroIni) and (dSinRemesar <= dFechaCobroFin) then
    begin
      rACobrarSinremesar := rSinRemesar;
      dACobrar := dPendiente;
    end;
  end;
  if (not bCobrado) and (QFacturas.FieldByName('importe_cobrado_fr').AsFloat <> 0) then
  begin
    if (QFacturas.FieldByName('fecha_remesa_fr').AsDateTime >= dFechaCobroIni) and (QFacturas.FieldByName('fecha_remesa_fr').AsDateTime <= dFechaCobroFin) then
    begin
      rACobrarRemesado := rACobrarRemesado + QFacturas.FieldByName('importe_cobrado_fr').AsFloat;
      (*
      if dRemesado > dACobrar then
        dACobrar:= dRemesado;
      *)
    end;
  end;
  rACobrarTotal := bRoundTo(rACobrarRemesado + rACobrarSinremesar, 2);
  EditFactura;
  (*
  if ( rACobrarTotal = 0 ) and ( rPendiente = 0 ) then
  begin
    DeleteFactura;
  end
  else
  begin
    EditFactura;
  end;
  *)
end;

procedure TDMLFacturasPendientes.EditFactura;
begin
  with kbmListado do
  begin
    Edit;

    FieldByName('importe_remesado_f').AsFloat := rRemesado;
    if dRemesado <> 0 then
      FieldByName('fecha_remesado_f').AsDateTime := dRemesado;

    FieldByName('importe_cobrado_f').AsFloat := rCobrado;
    if dCobrado <> 0 then
      FieldByName('fecha_cobrado_f').AsDateTime := dCobrado;

    FieldByName('remesado_acobrar_f').AsFloat := rACobrarRemesado;
    FieldByName('sinremesar_acobrar_f').AsFloat := rACobrarSinremesar;
    FieldByName('importe_acobrar_f').AsFloat := rACobrarTotal;
    if dACobrar <> 0 then
      FieldByName('fecha_acobrar_f').AsDateTime := dACobrar
    else
      FieldByName('fecha_acobrar_f').AsString := '';

    FieldByName('importe_pendiente_f').AsFloat := rPendiente;
    if dPendiente <> 0 then
      FieldByName('fecha_pendiente_f').AsDateTime := dPendiente;

    FieldByName('euros_pendiente_f').AsFloat := bRoundTo(FieldByName('cambio_f').AsFloat * FieldByName('importe_pendiente_f').AsFloat, 2);
    FieldByName('euros_remesado_f').AsFloat := bRoundTo(FieldByName('cambio_f').AsFloat * FieldByName('importe_remesado_f').AsFloat, 2);
    FieldByName('euros_cobrado_f').AsFloat := bRoundTo(FieldByName('cambio_f').AsFloat * FieldByName('importe_cobrado_f').AsFloat, 2);
    FieldByName('euros_acobrar_f').AsFloat := bRoundTo(FieldByName('cambio_f').AsFloat * FieldByName('importe_acobrar_f').AsFloat, 2);

    Post;
  end;
end;

procedure TDMLFacturasPendientes.DeleteFactura;
begin
  kbmListado.delete;
end;

end.

