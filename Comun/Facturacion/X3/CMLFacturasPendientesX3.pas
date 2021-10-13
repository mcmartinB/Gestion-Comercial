unit CMLFacturasPendientesX3;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMLFacturasPendientesX3 = class(TDataModule)
    QFacturas: TQuery;
    kbmListado: TkbmMemTable;
    qryPedido: TQuery;
    kbmClientes: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCliente: string;
    sMoneda: string;
    iFacturas: Integer;
    bDiasTesoreria: Boolean;
    bPorPais: Boolean;

    dFechaFacturaIni, dFechaFacturaFin: TDateTime;
    dFechaCobroIni, dFechaCobroFin: TDateTime;
    rFactura, rRemesado, rSinRemesar, rCobrado, rPendiente, rACobrarTotal, rACobrarRemesado, rACobrarSinremesar: Real;
    dFactura, dRemesado, dSinRemesar, dCobrado, dPendiente, dACobrar: TDateTime;

    procedure CambiarAlias( const AAlias: string );
    procedure CrearTablasTemporales;
    procedure CargarQuerys( const ATipoCliente, APais, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                            const AFactura, ANacional: Integer;
                            const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros: boolean );

    procedure PutFactura( const ATipo: integer );
    function  IsFactura: Boolean;
    procedure AddFactura( const ATipo: integer );
    procedure AddCliente( const ACliente: String );
    procedure ModFactura;

  public
    { Public declarations }
    function  Extracto( const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                        const AFactura, ANacional: Integer; const ACliente, ATipoCliente, APais: string;
                        const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros: boolean; const ATipo: integer ): boolean;

    function  Ejecutar( const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                        const AFactura, ANacional: Integer; const ACliente, ATipoCliente, APais: string;
                        const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros: boolean; const ATipo: integer ): boolean;

    function  Enviar( const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                      const AFactura, ANacional: Integer; const ACliente, ATipoCliente, APais: string;
                      const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros: boolean; const ATipo: integer ): boolean;
  end;

  procedure UsarModuloDeDatos( const AComponent: TComponent; const AAlias: string );
  procedure LiberarModuloDeDatos;

var
  DMLFacturasPendientesX3: TDMLFacturasPendientesX3;

implementation

{$R *.dfm}

uses UDMBaseDatos, UDMMaster, CQLFacturasPendientesX3, UDMConfig, Variants, bMath, Dialogs,
     CQLFacturasPendientesPedidoX3, DConfigMail, MostrarLogFD, UDMAuxDB, CGlobal,
  DateUtils;

var
  instancias: integer = 0;

procedure UsarModuloDeDatos( const AComponent: TComponent; const AAlias: string );
begin
  Inc( instancias );
  if instancias = 1 then
  begin
    DMLFacturasPendientesX3:= TDMLFacturasPendientesX3.Create( AComponent );
    DMLFacturasPendientesX3.CambiarAlias( AAlias );
  end;
end;

procedure LiberarModuloDeDatos;
begin
  Dec( instancias );
  if instancias = 0 then
    FreeAndNil( DMLFacturasPendientesX3 );
end;

procedure TDMLFacturasPendientesX3.CambiarAlias( const AAlias: string );
  procedure NuevoAlias( const AQuery: TQuery );
  begin
    AQuery.Close;
    AQuery.DatabaseName:= AAlias;
  end;
begin
  //NuevoAlias( QFacturas );
  //NuevoAlias( qryPedido );
end;


procedure TDMLFacturasPendientesX3.CargarQuerys( const ATipoCliente, APais, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
                                               const AFactura, ANacional: Integer;
                                               const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros: boolean );
var
  sPais: string;
begin
  with QFacturas do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('         cta_cliente_fc cta_cliente, cod_cliente_fc cod_cliente, des_cliente_fc des_cliente, ');
    SQL.Add('         cod_pais_fc cod_pais, forma_pago_adonix_fp forma_pago, banco_c cod_banco, ');
    SQL.Add('         cod_empresa_fac_fc cod_empresa, n_factura_fc n_factura, cod_factura_fp cod_factura, ');
    SQL.Add('         moneda_fc moneda, fecha_factura_fc fecha_factura, NVL(tipo_factura_fc,''380'') tipo_factura,');
    SQL.Add('         importe_factura_fp importe_factura, euros_factura_fp euros_factura , ');
    SQL.Add('         dias_cobro_fp dias_vencimiento, fecha_prevista_fp fecha_vencimiento, ');
    SQL.Add('         dias_tesoreria_c dias_tesoreria, prevision_tesoreria_fc fecha_prevista, ');
    SQL.Add('         case when fecha_prevista_fp > prevision_tesoreria_fc ');
    SQL.Add('              then fecha_prevista_fp ');
    SQL.Add('              else prevision_tesoreria_fc end fecha_maxima, ');
    SQL.Add('         importe_pendiente_fp importe_pendiente , euros_pendiente_fp euros_pendiente, ');
    SQL.Add('         fecha_cobro_fp fecha_cobro, importe_cobrado_fp importe_cobrado, euros_cobrado_fp euros_cobrado ');

    SQL.Add(' from tfacturas_pago ');
    SQL.Add('      join tfacturas_cab on cod_factura_fp = cod_factura_fc ');
    SQL.Add('      join tforma_pago on forma_pago_fc = codigo_fp ');
    SQL.Add('      join vclientes on cod_empresa_fac_fc  = empresa_c and cod_cliente_fc = cliente_c ');

    SQL.Add(' where importe_pendiente_fp <> 0 ');
    SQL.Add(' and fecha_factura_fc between :fechafacturaini and :fechafacturafin ');

    if  ADiasTesoreria then
    begin
      //Fecha factura + dias tesoreria
      SQL.Add('   and prevision_tesoreria_fc between :fechacobroini and :fechacobrofin ');
    end
    else
    begin
      //SQL.Add('   and prevision_cobro_fc between :fechacobroini and :fechacobrofin ');
      //X3
      SQL.Add('   and fecha_prevista_fp between :fechacobroini and :fechacobrofin ');
    end;

    (*BAG*)
    if sEmpresa = 'BAG' then
      SQL.Add(' and cod_empresa_fac_fc[1,1] = ''F'' ')
    else
    if sEmpresa = 'SAT' then
      SQL.Add(' and ( cod_empresa_fac_fc = ''050'' or cod_empresa_fac_fc = ''080'' ) ')
    else
      SQL.Add(' and cod_empresa_fac_fc = :empresa ');


    case AFactura of
      1: SQL.Add('   and NVL(tipo_factura_fc,''380'') = ''380'' ');
      2: SQL.Add('   and NVL(tipo_factura_fc,''380'') = ''381'' ');
    end;

    sPais:= APais;
    if sCliente <> '' then
    begin
      if AMultiplesCliente then
      begin
        if AExcluirCliente then
          SQL.Add('   and cod_cliente_fc not in (' + sCliente +') ')
        else
          SQL.Add('   and cod_cliente_fc in (' + sCliente +') ');
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
            sPais:= 'ES';
            SQL.Add('      and cod_pais_fc = :pais ')
          end;
          2:
          begin
            sPais:= 'ES';
            SQL.Add('      and cod_pais_fc <> :pais ');
          end;
        end;
      end
      else
      begin
        SQL.Add('      and cod_pais_fc = :pais ')
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

    if ( sEmpresa <> 'BAG' )  and ( sEmpresa <> 'SAT' )then
      ParamByName('empresa').AsString:= sEmpresa;
    if ( sCliente <> '' ) and ( not AMultiplesCliente ) then
    begin
      ParamByName('cliente').AsString:= sCliente;
    end;
    if ATipoCliente <> '' then
    begin
      ParamByName('tipocliente').AsString:= ATipoCliente;
    end;
    if sPais <> '' then
    begin
      ParamByName('pais').AsString:= sPais;
    end;
    ParamByName('fechafacturaini').AsDateTime:= dFechaFacturaIni;
    ParamByName('fechafacturafin').AsDateTime:= dFechaFacturaFin;
    ParamByName('fechacobroini').AsDateTime:= dFechaCobroIni;
    ParamByName('fechacobrofin').AsDateTime:= dFechaCobroFin;
    //SQL.SaveToFile('c:\pepe1.sql');
  end;
end;


procedure TDMLFacturasPendientesX3.CrearTablasTemporales;
Begin
  with kbmListado do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('moneda_f', ftString, 3, False);
    FieldDefs.Add('empresa_f', ftString, 3, False);
    FieldDefs.Add('cliente_fac_f', ftString, 3, False);
    FieldDefs.Add('fecha_factura_f', ftDate, 0, False);
    FieldDefs.Add('n_factura_f', ftInteger, 0, False);
    FieldDefs.Add('cod_factura_f', ftString, 15, False);
    FieldDefs.Add('tipo_factura_f', ftString, 3, False);

    FieldDefs.Add('importe_factura_f', ftFloat, 0, False);
    FieldDefs.Add('importe_pendiente_f', ftFloat, 0, False);
    FieldDefs.Add('importe_cobrado_f', ftFloat, 0, False);

    FieldDefs.Add('fecha_vencimiento_f', ftDate, 0, False);
    FieldDefs.Add('fecha_prevista_f', ftDate, 0, False);
    FieldDefs.Add('fecha_cobrado_f', ftDate, 0, False);

    FieldDefs.Add('euros_factura_f', ftFloat, 0, False);
    FieldDefs.Add('euros_pendiente_f', ftFloat, 0, False);
    FieldDefs.Add('euros_cobrado_f', ftFloat, 0, False);

    FieldDefs.Add('n_pedido', ftString, 15, False);
    FieldDefs.Add('suministro', ftString, 3, False);

    FieldDefs.Add('cod_pais', ftString, 2, False);
    FieldDefs.Add('forma_pago', ftString, 2, False);
    FieldDefs.Add('cod_banco', ftString, 3, False);
    FieldDefs.Add('dias_vencimiento', ftInteger, 0, False);
    FieldDefs.Add('dias_tesoreria', ftInteger, 0, False);
  end;

  with kbmClientes do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('cliente_fac_f', ftString, 3, False);
  end;

  with qryPedido do
  begin
    SQL.Clear;
    SQL.Add(' select n_pedido_sc, dir_sum_sc ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and fecha_factura_sc = :fecha ');
    SQL.Add(' and n_factura_sc = :factura ');
  end;
end;

procedure TDMLFacturasPendientesX3.DataModuleCreate(Sender: TObject);
begin
  CrearTablasTemporales;
end;

function  TDMLFacturasPendientesX3.Ejecutar( const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
            const AFactura, ANacional: Integer; const ACliente, ATipoCliente, APais: string;
            const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros: boolean;
            const ATipo: integer ): boolean;
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  sMoneda:= '';
  iFacturas:= 0;
  bDiasTesoreria:= ADiasTesoreria;
  bPorPais:= ATipo = 2;

  if AFechaCobroIni <> '' then
  begin
    dFechaCobroIni:= StrToDate(AFechaCobroIni);
  end
  else
  begin
    dFechaCobroIni:= StrToDate('1/1/2000');
  end;
  if AFechaCobroFin <> '' then
  begin
    dFechaCobroFin:= StrToDate(AFechaCobroFin);
  end
  else
  begin
    dFechaCobroFin:= StrToDate('1/1/2099');
  end;

  if AFechaFacturaIni <> '' then
  begin
    dFechaFacturaIni:= StrToDate(AFechaFacturaIni);
  end
  else
  begin
    dFechaFacturaIni:= StrToDate('1/1/2000');
  end;
  if AFechaFacturaFin <> '' then
  begin
    dFechaFacturaFin:= StrToDate(AFechaFacturaFin);
  end
  else
  begin
    dFechaFacturaFin:= StrToDate('1/1/2099');
  end;

  kbmListado.Close;
  kbmListado.Open;
  kbmListado.Filtered:= False;

  kbmClientes.Close;
  kbmClientes.Open;

  CargarQuerys( ATipoCliente, APais, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, AFactura, ANacional, ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros  );
  QFacturas.Open;
  while not QFacturas.Eof do
  begin
    PutFactura( ATipo );
    QFacturas.Next;
  end;
  QFacturas.Close;

  result:= not kbmListado.IsEmpty;
  if result then
  begin
    if not AEuros or bPorPais then
    begin
      if not AEuros and bPorPais then
        kbmListado.SortFields:= 'cod_pais;moneda_f;cliente_fac_f;empresa_f;fecha_factura_f;n_factura_f'
      else
      if not AEuros then
        kbmListado.SortFields:= 'moneda_f;cliente_fac_f;empresa_f;fecha_factura_f;n_factura_f'
      else
        kbmListado.SortFields:= 'cod_pais;cliente_fac_f;empresa_f;fecha_factura_f;n_factura_f';
    end
    else
    begin
      kbmListado.SortFields:= 'cliente_fac_f;empresa_f;fecha_factura_f;n_factura_f';
    end;


    kbmListado.Sort([]);
    if ATipo = 1 then
      CQLFacturasPendientesPedidoX3.Listado( self.Owner, kbmListado, AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, ADiasTesoreria,AEuros )
    else
      CQLFacturasPendientesX3.Listado( self.Owner, kbmListado, AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, ADiasTesoreria, AEuros, bPorPais );
  end;
end;


function  TDMLFacturasPendientesX3.Enviar( const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
            const AFactura, ANacional: Integer; const ACliente, ATipoCliente, APais: string;
            const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros: boolean; const ATipo: integer ): boolean;
var
  sLog, sAsunto, sCuerpo: string;
  bCancelar: Boolean;
begin
  bCancelar:= False;
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  bDiasTesoreria:= ADiasTesoreria;
  result:= False;
  sLog:= '';
  bPorPais:= ATipo = 2;

  if AFechaCobroIni <> '' then
  begin
    dFechaCobroIni:= StrToDate(AFechaCobroIni);
  end
  else
  begin
    dFechaCobroIni:= StrToDate('1/1/2000');
  end;
  if AFechaCobroIni <> '' then
  begin
    dFechaCobroFin:= StrToDate(AFechaCobroFin);
  end
  else
  begin
    dFechaCobroFin:= StrToDate('1/1/2099');
  end;

  if AFechaFacturaIni <> '' then
  begin
    dFechaFacturaIni:= StrToDate(AFechaFacturaIni);
  end
  else
  begin
    dFechaFacturaIni:= StrToDate('1/1/2000');
  end;
  if AFechaFacturaFin <> '' then
  begin
    dFechaFacturaFin:= StrToDate(AFechaFacturaFin);
  end
  else
  begin
    dFechaFacturaFin:= StrToDate('1/1/2099');
  end;

  kbmListado.Close;
  kbmListado.Open;
  kbmListado.Filtered:= False;

  kbmClientes.Close;
  kbmClientes.Open;

  CargarQuerys( ATipoCliente, APais, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, AFactura, ANacional, ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, False  );
  QFacturas.Open;
  while not QFacturas.Eof do
  begin
    PutFactura( ATipo );
    QFacturas.Next;
  end;
  QFacturas.Close;

  kbmListado.Filtered:= True;
  kbmClientes.SortFields:= 'cliente_fac_f';
  kbmClientes.Sort([]);
  kbmClientes.first;
  while not kbmClientes.Eof and not bCancelar do
  begin

    sCliente:= kbmClientes.FieldByName('cliente_fac_f').AsString;
    kbmListado.Filter:= 'cliente_fac_f = ' + QuotedStr( sCliente );
    kbmListado.First;

    sMoneda:= kbmListado.FieldByName('moneda_f').AsString;
    //if  Pos( '@', EMailCliente( AEmpresa, sCliente, True ) < 1 then
    begin
      iFacturas:= 0;

      sAsunto:= 'Solicitud estado facturas Bonnysa Agroalimentaria [' + sCliente + ']'; //+ desEmpresa( AEmpresa );
      sCuerpo:= 'Ruego informen de la situación de las facturas del listado adjunto, gracias.';
      sCuerpo:= sCuerpo + #13 + #10 + 'Please inform about situation of outstanding invoices attached, than you.';
      //sCuerpo:= #13 + #10 + desCliente( AEmpresa, sCliente );

      result:= ( result ) or ( not kbmListado.IsEmpty );
      if not kbmListado.IsEmpty then
      begin
        kbmListado.SortFields:= 'cliente_fac_f;empresa_f;fecha_factura_f;n_factura_f';
        kbmListado.Sort([]);
        if ATipo = 1 then
        begin
          if CQLFacturasPendientesPedidoX3.EnviarListado( self.Owner, kbmListado, AEmpresa, sCliente, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, ADiasTesoreria, AEuros, sAsunto, sCuerpo, bCancelar ) then
            sLog:= sLog + #13 + #10 + ' + ' +  AEmpresa + '-' + sCliente + ' -> CORREO ENVIADO ' + sMoneda + ' (' + desCliente( AEmpresa, sCliente ) + ')'
          else
            sLog:= sLog + #13 + #10 + ' - ' +  AEmpresa + '-' + sCliente + ' -> ENVIADO CANCELADO '  + sMoneda + ' (' + desCliente( AEmpresa, sCliente ) + ')';
        end
        else
        begin
          if CQLFacturasPendientesX3.EnviarListado( self.Owner, kbmListado, AEmpresa, sCliente, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, ADiasTesoreria, AEuros, bPorPais, sAsunto, sCuerpo, bCancelar ) then
            sLog:= sLog + #13 + #10 + ' + ' +  AEmpresa + '-' + sCliente + ' -> CORREO ENVIADO ' + sMoneda + ' (' + desCliente( AEmpresa, sCliente ) + ')'
          else
            sLog:= sLog + #13 + #10 + ' - ' +  AEmpresa + '-' + sCliente + ' -> ENVIADO CANCELADO ' + sMoneda + ' (' + desCliente( AEmpresa, sCliente ) + ')';
        end;
      end;

    end;
    (*
    else
    begin
      sLog:= sLog + #13 + #10 + '   ' +  AEmpresa + '-' + sCliente + ' -> SIN DIRECCION DE CORREO '  + sMoneda  + ' (' + desCliente( AEmpresa, ACliente ) + ')'
    end;
    *)
    kbmClientes.Next;
  end;
  if bCancelar then
  begin
    sLog:= sLog + #13 + #10 + ' - PROCESO CANCELADO POR EL USARIO.';
  end;
  MostrarLogFD.MostrarLog( Self, sLog, 'ENVIO INFORME FACTURAS PENDIENTE COBRO');
end;

procedure TDMLFacturasPendientesX3.PutFactura( const ATipo: integer );
begin
  if not IsFactura then
    AddFactura( ATipo )
  else
    ModFactura;
end;

function TDMLFacturasPendientesX3.IsFactura: Boolean;
begin
  if kbmListado.Locate( 'cod_factura_f',
                        VarArrayOf([QFacturas.FieldByName('cod_factura').AsString]),[]) then
    result:= True
  else
    result:= False;
end;


procedure TDMLFacturasPendientesX3.AddFactura( const ATipo: integer );
var
  iAbono: integer;
begin
  AddCliente( QFacturas.FieldByName('cod_cliente').AsString );

  if QFacturas.FieldByName('tipo_factura').AsString = '380' then
    iAbono:= 1
  else
    iAbono:= -1;

  with kbmListado do
  begin
    Insert;
    FieldByName('moneda_f').AsString := QFacturas.FieldByName('moneda').AsString;
    FieldByName('empresa_f').AsString := QFacturas.FieldByName('cod_empresa').AsString;
    FieldByName('cliente_fac_f').AsString := QFacturas.FieldByName('cod_cliente').AsString;
    FieldByName('n_factura_f').AsInteger := QFacturas.FieldByName('n_factura').AsInteger;
    FieldByName('cod_factura_f').AsString := QFacturas.FieldByName('cod_factura').AsString;

    FieldByName('tipo_factura_f').AsString := QFacturas.FieldByName('tipo_factura').AsString;

    FieldByName('importe_factura_f').AsFloat := iAbono * QFacturas.FieldByName('importe_factura').AsFloat;
    FieldByName('importe_pendiente_f').AsFloat := iAbono * QFacturas.FieldByName('importe_pendiente').AsFloat;
    FieldByName('importe_cobrado_f').AsFloat := iAbono * QFacturas.FieldByName('importe_cobrado').AsFloat;

    FieldByName('euros_factura_f').AsFloat := iAbono * QFacturas.FieldByName('euros_factura').AsFloat;
    FieldByName('euros_pendiente_f').AsFloat := iAbono * QFacturas.FieldByName('euros_pendiente').AsFloat;
    FieldByName('euros_cobrado_f').AsFloat := iAbono * QFacturas.FieldByName('euros_cobrado').AsFloat;

    FieldByName('fecha_factura_f').AsDateTime := QFacturas.FieldByName('fecha_factura').AsDateTime;
    FieldByName('fecha_prevista_f').AsDateTime := QFacturas.FieldByName('fecha_prevista').AsDateTime;
    FieldByName('fecha_vencimiento_f').AsDateTime := QFacturas.FieldByName('fecha_vencimiento').AsDateTime;
    //fecha_prevista//fecha_maxima
    FieldByName('fecha_cobrado_f').AsDateTime := QFacturas.FieldByName('fecha_cobro').AsDateTime;

    if ATipo = 0 then
    begin
      FieldByName('n_pedido').AsString := '';
      FieldByName('suministro').AsString := ''
    end
    else
    begin
      qryPedido.ParamByName('empresa').AsString:= QFacturas.FieldByName('cod_empresa').AsString;
      qryPedido.ParamByName('factura').AsInteger:= QFacturas.FieldByName('n_factura').AsInteger;
      qryPedido.ParamByName('fecha').AsDateTime:= QFacturas.FieldByName('fecha_factura').AsDateTime;
      qryPedido.Open;
      try
        FieldByName('n_pedido').AsString := qryPedido.FieldByName('n_pedido_sc').AsString;;
        FieldByName('suministro').AsString := qryPedido.FieldByName('dir_sum_sc').AsString;
      finally
        qryPedido.Close;
      end;
    end;

    FieldByName('cod_pais').AsString := QFacturas.FieldByName('cod_pais').AsString;
    FieldByName('forma_pago').AsString := QFacturas.FieldByName('forma_pago').AsString;
    FieldByName('cod_banco').AsString := QFacturas.FieldByName('cod_banco').AsString;
    FieldByName('dias_tesoreria').AsInteger := QFacturas.FieldByName('dias_tesoreria').AsInteger;
    FieldByName('dias_vencimiento').AsInteger := QFacturas.FieldByName('dias_vencimiento').AsInteger;

    iFacturas:= iFacturas + 1;

    Post;
  end;
end;

procedure TDMLFacturasPendientesX3.AddCliente( const ACliente: String );
begin
  if not kbmClientes.Locate( 'cliente_fac_f', VarArrayOf([ACliente]),[]) then
  begin
    kbmClientes.Insert;
    kbmClientes.FieldByName('cliente_fac_f').AsString:= ACliente;
    kbmClientes.Post;
  end;
end;


procedure TDMLFacturasPendientesX3.ModFactura;
var
  iAbono: integer;
begin

  if QFacturas.FieldByName('tipo_factura').AsString = '380' then
    iAbono:= 1
  else
    iAbono:= -1;

  with kbmListado do
  begin
    Edit;
    FieldByName('importe_cobrado_f').AsFloat := FieldByName('importe_cobrado_f').AsFloat + ( iAbono * QFacturas.FieldByName('importe_cobrado').AsFloat );
    FieldByName('importe_pendiente_f').AsFloat := ( iAbono * QFacturas.FieldByName('importe_factura').AsFloat ) - FieldByName('importe_cobrado_f').AsFloat;

    FieldByName('euros_cobrado_f').AsFloat := FieldByName('euros_cobrado_f').AsFloat + ( iAbono * QFacturas.FieldByName('euros_cobrado').AsFloat);
    FieldByName('euros_pendiente_f').AsFloat := ( iAbono * QFacturas.FieldByName('euros_factura').AsFloat ) - FieldByName('euros_cobrado_f').AsFloat;

    if  FieldByName('fecha_prevista_f').AsDateTime < QFacturas.FieldByName('fecha_prevista').AsDateTime then
      FieldByName('fecha_prevista_f').AsDateTime:= QFacturas.FieldByName('fecha_prevista').AsDateTime;

    if  FieldByName('fecha_vencimiento_f').AsDateTime < QFacturas.FieldByName('fecha_vencimiento').AsDateTime then
      FieldByName('fecha_vencimiento_f').AsDateTime:= QFacturas.FieldByName('fecha_vencimiento').AsDateTime;

    if FieldByName('fecha_cobrado_f').AsDateTime < QFacturas.FieldByName('fecha_cobro').AsDateTime then
      FieldByName('fecha_cobrado_f').AsDateTime := QFacturas.FieldByName('fecha_cobro').AsDateTime;
    Post;
  end;
end;



function  TDMLFacturasPendientesX3.Extracto( const AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin: string;
            const AFactura, ANacional: Integer; const ACliente, ATipoCliente, APais: string;
            const ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros: boolean;
            const ATipo: integer ): boolean;
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  sMoneda:= '';
  iFacturas:= 0;
  bDiasTesoreria:= ADiasTesoreria;

  if AFechaCobroIni <> '' then
  begin
    dFechaCobroIni:= StrToDate(AFechaCobroIni);
  end
  else
  begin
    dFechaCobroIni:= StrToDate('1/1/2000');
  end;
  if AFechaCobroFin <> '' then
  begin
    dFechaCobroFin:= StrToDate(AFechaCobroFin);
  end
  else
  begin
    dFechaCobroFin:= StrToDate('1/1/2099');
  end;

  if AFechaFacturaIni <> '' then
  begin
    dFechaFacturaIni:= StrToDate(AFechaFacturaIni);
  end
  else
  begin
    dFechaFacturaIni:= StrToDate('1/1/2000');
  end;
  if AFechaFacturaFin <> '' then
  begin
    dFechaFacturaFin:= StrToDate(AFechaFacturaFin);
  end
  else
  begin
    dFechaFacturaFin:= StrToDate('1/1/2099');
  end;  

  kbmListado.Close;
  kbmListado.Open;
  kbmListado.Filtered:= False;

  kbmClientes.Close;
  kbmClientes.Open;

  CargarQuerys( ATipoCliente, APais, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, AFactura, ANacional, ADiasTesoreria, AExcluirCliente, AExcluirTipoCliente, AMultiplesCliente, AEuros  );
  QFacturas.Open;
  while not QFacturas.Eof do
  begin
    PutFactura( ATipo );
    QFacturas.Next;
  end;
  QFacturas.Close;

  result:= not kbmListado.IsEmpty;
  if result then
  begin
    if AEuros then
      kbmListado.SortFields:= 'cliente_fac_f;empresa_f;fecha_factura_f;n_factura_f'
    else
      kbmListado.SortFields:= 'moneda_f;cliente_fac_f;empresa_f;fecha_factura_f;n_factura_f';
    kbmListado.Sort([]);
    if ATipo = 1 then
      CQLFacturasPendientesPedidoX3.Listado( self.Owner, kbmListado, AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, ADiasTesoreria, AEuros )
    else
      CQLFacturasPendientesX3.Listado( self.Owner, kbmListado, AEmpresa, AFechaFacturaIni, AFechaFacturaFin, AFechaCobroIni, AFechaCobroFin, ADiasTesoreria, AEuros, ATipo = 2 );

  end;
end;

end.

