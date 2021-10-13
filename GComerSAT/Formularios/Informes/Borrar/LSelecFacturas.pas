unit LSelecFacturas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, DBCtrls, ActnList,
  BDEdit, BSpeedButton, BGridButton, Db,
  CGestionPrincipal, BEdit, Grids, DBGrids, BGrid,
  BCalendarButton, BCalendario, DError, DBTables, DPreview;

type
  TFLSelecFacturas = class(TForm)
    Panel1: TPanel;
    GBEmpresa: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    SBAceptar: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    BGBclienteDesde: TBGridButton;
    RejillaDespegable: TAction;
    RejillaFlotante: TBGrid;
    clienteDesde: TBEdit;
    albaranDesde: TBEdit;
    fechaFacturar: TBEdit;
    BCBFechaFacturar: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    Label4: TLabel;
    fechaFactura: TBEdit;
    BCBFechaFactura: TBCalendarButton;
    albaranHasta: TBEdit;
    empresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    Label1: TLabel;
    rgTipoFactura: TRadioGroup;
    Timer: TTimer;
    printOriginal: TCheckBox;
    printEmpresa: TCheckBox;
    Bevel1: TBevel;
    copiasLabel: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pedido: TBEdit;
    lbl1: TLabel;
    stCliente: TStaticText;
    chkRiesgo: TCheckBox;
    qryContadores: TQuery;
    chkAlbaranesValidados: TCheckBox;
    procedure BCancelarExecute(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RejillaDespegableExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);
    procedure rgTipoFacturaEnter(Sender: TObject);
    procedure rgTipoFacturaExit(Sender: TObject);
    function Parametros(var ponerFoco: TBEdit): boolean;
    function RellenaTabla( const AFacturable, AValidados: Boolean ): boolean;
    function LimpiarTabla: boolean;
    procedure Limpiar;
    function ComprobarCuentas: Boolean;
    function NumeraFacturas( const AEmpresa: string ): integer;
    function RellenaFacturas: boolean;
    function GetNumeroFactura(empresa, tipo: string; fecha: TDate; var AMsg: string): integer;
    procedure BorrarNoFacturadas;
    function  NumeroCopias: Integer;
    procedure FormShow(Sender: TObject);

    function ComprobrarClavePrimaria( const AEmpresa: string; const AFactura, AAnyo: Integer ): Integer;
    function AlbaranFactura(empresa, cliente: string): boolean;
    function FacturarPor(const empresa, cliente: string): integer;
    procedure TimerTimer(Sender: TObject);
    procedure Previsualizar;
    procedure FormActivate(Sender: TObject);
    procedure printOriginalClick(Sender: TObject);
    procedure rgTipoFacturaClick(Sender: TObject);

  private
    contador: integer;

    function EstaCambioGrabado: boolean;
    function AsuntoFactura: string;
    function VerificarAnyoContador: boolean;
  public
    bDefinitiva, bValidados: boolean;

    procedure Facturar;
  end;

var
  FLSelecFacturas: TFLSelecFacturas;

implementation

uses bDialogs, UDMBaseDatos, CVariables, Principal, CAuxiliarDB, LFacturas,
  UDMFacturacion, CFacturacion, UDMFacturacionEDI, UDMCambioMoneda, AdvertenciaFD,
  UDMAuxDB, bSQLUtils, bNumericUtils, bMath, UDMConfig, DConfigMail;

{$R *.DFM}

procedure TFLSelecFacturas.BCancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function esClienteExtranjero(codEmp: string; codCliente: string): Boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Text := ' select pais_c from frf_clientes ' +
      ' where empresa_c=' + QuotedStr(codEmp) + ' ' +
      ' and cliente_c=' + QuotedStr(codCliente);
    try
      try
        Open;
        if IsEmpty then esClienteExtranjero := false
        else esClienteExtranjero := (Fields[0].AsString <> 'ES') and (Fields[0].AsString <> '');
      except
        esClienteExtranjero := false;
      end;
    finally
      Cancel;
      Close;
    end;
  end;
end;


function TFLSelecFacturas.EstaCambioGrabado: boolean;
var
    sMoneda: string;
begin
  result:= true;
  //Mirar a ver si el cambio del dia esta grabado
  //solamente exportacion
  //if cliente.ItemIndex = 1 then
  if esClienteExtranjero( empresa.Text, clienteDesde.Text ) then
  with DMAuxDB.QGeneral do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select distinct moneda_sc from frf_salidas_c ');
    SQL.Add('where empresa_sc = :empresa ');
    //SQL.Add('  and cliente_sal_sc between :clienteini and :clientefin ');
    SQL.Add('  and cliente_fac_sc = :cliente ');
    SQL.Add('  and fecha_sc between :fechaini and :fechafin ');
    SQL.Add('  and n_factura_sc is null ');
    SQL.Add('  and moneda_sc <> ''EUR'' ');

    ParamByName('empresa').AsString:= empresa.Text;
    ParamByName('cliente').AsString:= clienteDesde.Text;
    //ParamByName('clienteini').AsString:= clienteDesde.Text;
    //ParamByName('clientefin').AsString:= clienteHasta.Text;
    ParamByName('fechaini').AsDateTime:= strtodate( fechaFacturar.Text ) - 365;
    ParamByName('fechafin').AsDateTime:= strtodate( fechaFacturar.Text );
    Open;

    if not IsEmpty then
    begin
      while not Eof and result do
      begin
        sMoneda:= Fields[0].AsString;
        if not ChangeExist( sMoneda, StrToDate( fechaFactura.Text ) ) then
        begin
          result:= False;
          sMoneda:= 'No se puede facturar si no esta el cambio del día grabado.' + #13 + #10 +
                    'Falta grabar el cambio del "' + fechaFactura.Text + '" para ''' + sMoneda + '''';
          ShowMessage( sMoneda );
        end;
        next;
      end;
    end;

    Close;
  end;
end;

function TFLSelecFacturas.VerificarAnyoContador: boolean;
var
  iAux, iYear, iMonth, iDay: word;
begin
  result:= false;
  with DMAuxDB.QGeneral do
  begin
    Sql.Clear;
    SQL.Add(' SELECT year(fecha_sc) year');
    SQL.Add(' FROM frf_salidas_c Frf_salidas_c');

    //SQL.Add(' WHERE  (empresa_sc = :empresa)');
    SQL.Add(' WHERE    (cliente_fac_sc = :Cliente)');
    SQL.Add(' AND  (n_albaran_sc BETWEEN :albaranDesde AND :albaranHasta)');
    SQL.Add(' AND  (fecha_sc <= :fecha)');

    SQL.Add(' AND  (n_factura_sc IS NULL)');
    SQL.Add(' AND  (cliente_sal_sc <> "RET")');
    SQL.Add(' AND  (cliente_sal_sc <> "REA")');
    SQL.Add(' AND  (cliente_sal_sc <> "0BO")');
    SQL.Add(' AND  (cliente_sal_sc <> "EG")');

    (*
    if Trim(pedido.Text) <> '' then
      SQL.Add(' AND  (n_pedido_sc = :pedido)');
    *)
    if Trim(pedido.Text) <> '' then
      SQL.Add(' AND  (n_pedido_sc = :pedido)')
    else
      SQL.Add(' AND  (empresa_sc = :empresa)');

    SQL.Add(' group by 1 order by 1');

    ParamByName('Cliente').AsString := clienteDesde.Text;
    ParamByName('albaranDesde').AsString := albaranDesde.Text;
    ParamByName('albaranHasta').AsString := albaranHasta.Text;
    ParamByName('fecha').AsDate := StrToDate(fechaFacturar.Text);
    (*
    ParamByName('empresa').AsString := empresa.Text;
    if Trim(pedido.Text) <> '' then
      ParamByName('pedido').AsString := pedido.Text;
    *)
    if Trim(pedido.Text) <> '' then
      ParamByName('pedido').AsString := pedido.Text
    else
      ParamByName('empresa').AsString := empresa.Text;

    Open;
    if IsEmpty then
    begin
      Advertir('No existen albaranes por facturar que cumplan el criterio seleccionado.');
    end
    else
    begin
      DecodeDate( StrToDate( fechaFactura.Text ), iYear, iMonth, iDay );
      iAux:= FieldByName('year').AsInteger;
      if iAux <> iYear then
      begin
        Result:= VerAdvertencia( Self, 'No se pueden facturar albaranes del año ' + IntToStr( iAux) + ' con fecha del ' + IntToStr( iYear) + '.',
                                 '  ADVERTENCIA', 'Confirmo que no es un error y quiero facturar', 'Facturar' ) = mrIgnore;
      end
      else
      begin
        Next;
        iAux:= FieldByName('year').AsInteger;
        If iAux <> iYear then
        begin
          Result:= VerAdvertencia( Self, 'No se pueden facturar albaranes del año ' + IntToStr( iAux) + ' con fecha del ' + IntToStr( iYear) + '.',
                                 '  ADVERTENCIA', 'Confirmo que no es un error y quiero facturar', 'Facturar' ) = mrIgnore;
        end
        else
        begin
          Result:= True;
        end;
      end;
    end;
    Close;
  end;
end;

procedure TFLSelecFacturas.BAceptarExecute(Sender: TObject);
var
  temp: TBEdit;
  usuario: string;
begin
  //Datos del formulario correctos
  if not Parametros(temp) then
  begin
    temp.SetFocus;
    Exit;
  end;

  if not EstaCambioGrabado then
  begin
    Exit;
  end;

  //Comprobaciones año-contador
  if not VerificarAnyoContador then
  begin
    Exit;
  end;

  usuario := gsCodigo;

  SBAceptar.Enabled := QuieroFacturar(gsCodigo,usuario);
  if SBAceptar.Enabled then
  begin
    Timer.Enabled := false;
    BEMensajes('');
  end
  else
  begin
    BEMensajes('En este momento esta facturando el gsCodigo ' + usuario);
    Exit;
  end;

  Limpiar;

  if not CerrarForm(true) then Exit;

  Facturar;

  usuario := gsCodigo;
  AcaboFacturar(gsCodigo );
  Timer.Enabled := true;
end;

function CanFacturarFecha(AEmpresa, ADate: string): Boolean;
var
  iYear, iMonth, iDay: Word;
begin
  Result := true;
  DecodeDate( StrToDateDef(ADate, Date), iYear, iMonth, iDay );
  with DMBaseDatos.QTemp do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(' SELECT UNIQUE cod_emp_factura_tf, cod_iva_tf FROM tmp_facturas_l ' +
      //' WHERE cod_empresa_tf = :empresa ' +
      ' ORDER BY cod_iva_tf DESC ');
    //ParamByName('empresa').AsString := AEmpresa;
    Open;
    while not EOF do
    begin
     (*FACTAÑOS*)
     //IVA
      if Copy(FieldByName('cod_iva_tf').AsString, 1, 1) = 'I' then
      begin
        DMBaseDatos.QAux.SQL.Clear;
        DMBaseDatos.QAux.SQL.Add(' select * ');
        DMBaseDatos.QAux.SQL.Add(' from frf_facturas_serie ');
        DMBaseDatos.QAux.SQL.Add('      join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ');
        DMBaseDatos.QAux.SQL.Add(' where cod_empresa_es = :empresa ');
        DMBaseDatos.QAux.SQL.Add(' and anyo_fs = :anyo ');

        DMBaseDatos.QAux.ParamByName('empresa').AsString := FieldByName('cod_emp_factura_tf').AsString;
        DMBaseDatos.QAux.ParamByName('anyo').AsInteger := iYear;
        DMBaseDatos.QAux.Open;
        if DMBaseDatos.QAux.FieldByName('fecha_fac_iva_fs').AsDateTime >
          StrToDate(ADate) then
        begin
          ShowError('La fecha de facturación es incorrecta para la serie de IVA.');
          DMBaseDatos.QAux.Close;
          Result := false;
          break;
        end;
      end
      else
        if Copy(FieldByName('cod_iva_tf').AsString, 1, 1) = 'G' then
        begin
          DMBaseDatos.QAux.SQL.Clear;
          (*
          DMBaseDatos.QAux.SQL.Add(' SELECT fecha_fac_igic_emc ' +
            ' FROM frf_empresas_contadores  ' +
            ' WHERE empresa_emc = :empresa and anyo_emc = :anyo ');
          *)
          DMBaseDatos.QAux.SQL.Add(' select * ');
          DMBaseDatos.QAux.SQL.Add(' from frf_facturas_serie ');
          DMBaseDatos.QAux.SQL.Add('      join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ');
          DMBaseDatos.QAux.SQL.Add(' where cod_empresa_es = :empresa ');
          DMBaseDatos.QAux.SQL.Add(' and anyo_fs = :anyo ');

          DMBaseDatos.QAux.ParamByName('empresa').AsString := FieldByName('cod_emp_factura_tf').AsString;
          DMBaseDatos.QAux.ParamByName('anyo').AsInteger := iYear;
          DMBaseDatos.QAux.Open;
          if DMBaseDatos.QAux.FieldByName('fecha_fac_igic_fs').AsDateTime >
            StrToDate(ADate) then
          begin
            ShowError('La fecha de facturación es incorrecta para la serie de IGIC.');
            DMBaseDatos.QAux.Close;
            Result := false;
            break;
          end;
        end;
      DMBaseDatos.QAux.Close;
      Next;
    end;
    Close;
  end;
end;

procedure ComprobarRiesgoCliente( const AEmpresa, ACliente: string );
var
  rRiesgo, rFacturado, rCobrado: real;
begin
  with DMAuxDB.QAux do
  begin
    SQl.Clear;
    SQL.Add('select max_riesgo_c from frf_clientes where empresa_c = :empresa and cliente_c = :cliente and max_riesgo_c is not null ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    Open;
    if not IsEmpty then
    begin
      rRiesgo:= FieldByName('max_riesgo_c').AsFloat;
      Close;
      SQl.Clear;
      SQL.Add('select sum( importe_euros_f ) importe from frf_facturas where empresa_f = :empresa and cliente_fac_f= :cliente ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('cliente').AsString:= ACliente;
      Open;
      rFacturado:= FieldByName('importe').AsFloat;
      Close;
      SQl.Clear;
      SQL.Add(' select sum( euros(moneda_f, fecha_factura_f, importe_cobrado_fr) ) importe  ');
      SQL.Add(' from frf_facturas, frf_facturas_remesa  ');
      SQL.Add(' where empresa_f = :empresa  and cliente_fac_f= :cliente  ');
      SQL.Add('   and empresa_fr = :empresa  and factura_fr = n_factura_f  and fecha_factura_fr = fecha_factura_f  and fecha_remesa_fr <= TODAY  ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('cliente').AsString:= ACliente;
      Open;
      rCobrado:= FieldByName('importe').AsFloat;
      Close;
      rRiesgo:= rRiesgo - rFacturado +  rCobrado;
      if rRiesgo < 0 then
      begin
        ShowError('Riesgo superado en ' + FormatFloat('#,##0.00', rRiesgo ) + '€ para el cliente ' + ACliente + '.');
      end;
    end;
  end;
end;

procedure TFLSelecFacturas.Facturar;
var
  ant: string;
  usuario: string;
begin
  usuario := gsCodigo;
     //Rellenamos tabla temporal lineas
  if not RellenaTabla( bDefinitiva, bValidados ) then
  begin
    Limpiar;
    AcaboFacturar(gsCodigo);
    Timer.Enabled := true;
    Exit;
  end;

     //Separacion en facturas
  if NumeraFacturas( empresa.Text ) = 0 then
  begin
    Limpiar;
    AcaboFacturar(gsCodigo);
    Timer.Enabled := true;
    Exit;
  end;
  DMBaseDatos.QGeneral.Cancel;
  DMBaseDatos.QGeneral.Close;
  DMBaseDatos.QGeneral.RequestLive := false;

  if not CanFacturarFecha(empresa.Text, fechaFactura.Text) then
  begin
    Limpiar;
    AcaboFacturar(gsCodigo);
    Timer.Enabled := true;
    Exit;
  end;

     //Comprobar que los clientes tienen las cuentas de venta/ingresos???
  if not ComprobarCuentas then
  begin
    Limpiar;
    AcaboFacturar(gsCodigo);
    Timer.Enabled := true;
    Exit;
  end;

  PreparaFacturacion( clienteDesde.Text, fechaFactura.text );

     //Facturacion Normal
  if bDefinitiva then
  begin
    //Rellenamos cabecera factura
    //Actualizamos factura
    //Actualizamos contador,fecha facturacion empresa
    ant := DMFacturacion.QCabeceraFactura.SQL.Text;
    if not RellenaFacturas then
    begin
      Limpiar;
      AcaboFacturar(gsCodigo);
      Timer.Enabled := true;

      DMBaseDatos.QGeneral.Cancel;
      DMBaseDatos.QGeneral.Close;
      DMFacturacion.QCabeceraFactura.Cancel;
      DMFacturacion.QCabeceraFactura.Close;
      DMBaseDatos.QGeneral.RequestLive := false;
      DMFacturacion.QCabeceraFactura.RequestLive := false;
      DMFacturacion.QCabeceraFactura.SQL.clear;
      DMFacturacion.QCabeceraFactura.SQL.add(ant);

      Exit;
    end;
    DMBaseDatos.QGeneral.Cancel;
    DMBaseDatos.QGeneral.Close;
    DMFacturacion.QCabeceraFactura.Cancel;
    DMFacturacion.QCabeceraFactura.Close;
    DMBaseDatos.QGeneral.RequestLive := false;
    DMFacturacion.QCabeceraFactura.RequestLive := false;
    DMFacturacion.QCabeceraFactura.SQL.clear;
    DMFacturacion.QCabeceraFactura.SQL.add(ant);
  end;

  Previsualizar;

  if chkRiesgo.Checked and bDefinitiva then
  begin
    ComprobarRiesgoCliente( empresa.Text, clienteDesde.Text );
  end;
end;

procedure TFLSelecFacturas.FormCreate(Sender: TObject);
var
  usuario: string;
begin
  FormType := tfOther;
  BHFormulario;
  Empresa.Tag := kEmpresa;
  clienteDesde.Tag := kCliente;
  FechaFacturar.Tag := kCalendar;
  FechaFactura.Tag := kCalendar;

  CalendarioFlotante.Date := Date;
  STEmpresa.Caption := '';

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  Timer.Enabled := false;
  Timer.Interval := 10000;
  Timer.Enabled := true;
  usuario := gsCodigo;
  SBAceptar.Enabled := PuedoFacturar(gsCodigo,usuario);
  if SBAceptar.Enabled then
  begin
    BEMensajes('');
  end
  else
  begin
    BEMensajes('En este momento esta facturando el usuario ' + usuario);
  end;
end;

procedure TFLSelecFacturas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  gRF := nil;
  gCF := nil;

     //Limpiar;

  BEMensajes('');
  Action := caFree;
end;

procedure TFLSelecFacturas.RejillaDespegableExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente:
      begin
        DespliegaRejilla(BGBclienteDesde, [empresa.Text])
      end;
    kCalendar:
      begin
        if fechaFacturar.Focused then
          DespliegaCalendario(BCBFechaFacturar)
        else
          DespliegaCalendario(BCBFechaFactura);
      end;
  end;
end;

procedure TFLSelecFacturas.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  STEmpresa.Caption := desEmpresa(empresa.Text);
  stCliente.Caption := desCliente(empresa.Text, clienteDesde.Text);
end;

procedure TFLSelecFacturas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        //if Cliente.DroppedDown = true then Exit;
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        //if Cliente.DroppedDown = true then Exit;
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

procedure TFLSelecFacturas.rgTipoFacturaEnter(Sender: TObject);
begin
  rgTipoFactura.Font.Color := clNavy;
end;

procedure TFLSelecFacturas.rgTipoFacturaExit(Sender: TObject);
begin
  rgTipoFactura.Font.Color := clBlack;
end;

function TFLSelecFacturas.Parametros(var ponerFoco: TBEdit): boolean;
var
  dFechaFacturar, dFechaFactura: TDateTime;
begin
     //Comprobar que el campo empresa tiene valor
  if (STEmpresa.Caption = '') then
  begin
    ShowError('falta el código de la empresa o es incorrecto.');
    ponerFoco := empresa;
    Parametros := false;
    Exit;
  end;

     //Comprobar que el cliente tiene valor
  if stCliente.Caption = '' then
  begin
    ShowError('Falta el código del cliente o es incorrecto.');
    ponerFoco := clienteDesde;
    Parametros := false;
    Exit;
  end;
  (*
  if (trim(clienteDesde.Text) = '') then
  begin
    ShowError('Es necesario que rellene el código de el cliente.');
    ponerFoco := clienteDesde;
    Parametros := false;
    Exit;
  end;
  *)
  //Si no hemos puesto nada rellenar automaticamente
  (*
  if (trim(clienteHasta.Text) = '') then
  begin
    clienteHasta.Text := clientedesde.Text;
  end;
  *)

     //Comprobar que el albaran tiene valor
  if (trim(albaranDesde.Text) = '') then
  begin
    ShowError('Es necesario que rellene el albarán a imprimir.');
    ponerFoco := albaranDesde;
    Parametros := false;
    Exit;
  end;
     //Si no hemos puesto nada rellenar automaticamente
  if (trim(albaranHasta.Text) = '') then
  begin
    albaranHasta.Text := albarandesde.Text;
  end;

  if not TryStrToDate( fechaFacturar.Text, dFechaFacturar ) then
  begin
    ShowError('La fecha de "Facturar Hasta" es incorrecta.');
    ponerFoco := fechaFacturar;
    Parametros := false;
    Exit;
  end;
  if not TryStrToDate( fechaFactura.Text, dFechaFactura ) then
  begin
    ShowError('La fecha de "Fecha Factura" es incorrecta.');
    ponerFoco := fechaFactura;
    Parametros := false;
    Exit;
  end;
  if dFechaFacturar > dFechaFactura then
  begin
    ShowError('La fecha "Facturar Hasta" no puede se mayor que la fecha "Fecha Factura".');
    ponerFoco := fechaFacturar;
    Parametros := false;
    Exit;
  end;

  if rgTipoFactura.ItemIndex < 2 then
    bDefinitiva := false
  else
    bDefinitiva := true;
  bValidados:= chkAlbaranesValidados.Checked;

  ponerFoco := nil;
  Parametros := true;
end;

function TFLSelecFacturas.RellenaTabla( const AFacturable, AValidados: boolean ): boolean;
var
  bFacturables: Boolean;
begin
  Result := false;
     //LINEAS
  bFacturables:= AFacturable or AValidados;
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('select count(*) registros, sum(case when facturable_sc = 1 then 1 else 0 end ) facturables ');
    SQL.Add('from frf_salidas_c ');
    //SQL.Add('WHERE  (empresa_sc = :empresa) ');
    SQL.Add('WHERE  (cliente_fac_sc = :cliente) ');
    SQL.Add('AND  (n_albaran_sc BETWEEN :albaranDesde AND :albaranHasta) ');
    SQL.Add('AND  (fecha_sc <= :fecha) ');

    SQL.Add('AND  (n_factura_sc IS NULL) ');
    SQL.Add('AND  (cliente_sal_sc <> "RET") ');
    SQL.Add('AND  (cliente_sal_sc <> "REA") ');
    SQL.Add('AND  (cliente_sal_sc <> "0BO") ');
    SQL.Add('AND  (cliente_sal_sc <> "EG") ');
    (*
    if Trim(pedido.Text) <> '' then
      SQL.Add('AND  (n_pedido_sc = :pedido) ');
    *)
    if Trim(pedido.Text) <> '' then
      SQL.Add('AND  (n_pedido_sc = :pedido) ')
    else
      SQL.Add('AND  (empresa_sc = :empresa)  ');

    ParamByName('Cliente').AsString := clienteDesde.Text;
    //ParamByName('clienteDesde').AsString := clienteDesde.Text;
    //ParamByName('ClienteHasta').AsString := clienteHasta.Text;
    ParamByName('albaranDesde').AsString := albaranDesde.Text;
    ParamByName('albaranHasta').AsString := albaranHasta.Text;
    ParamByName('fecha').AsDate := StrToDate(fechaFacturar.Text);
    (*
    ParamByName('empresa').AsString := empresa.Text;
    if Trim(pedido.Text) <> '' then
      ParamByName('pedido').AsString := pedido.Text;
    *)
    if Trim(pedido.Text) <> '' then
      ParamByName('pedido').AsString := pedido.Text
    else
      ParamByName('empresa').AsString := empresa.Text;

    Open;
    try
      if FieldByName('registros').AsInteger = 0 then
      begin
        Advertir('No existen albaranes por facturar que cumplan el criterio seleccionado.');
        Exit;
      end
      else
      if  FieldByName('registros').AsInteger <> FieldByName('facturables').AsInteger then
      begin
        if FieldByName('facturables').AsInteger = 0 then
        begin
          if bFacturables then
          begin
            Advertir('No existen albaranes validados por facturar que cumplan el criterio seleccionado.');
            Exit;
          end
          else
          begin
            Advertir('ATENCION: Todos los albaranes son no validados.');
          end;
        end
        else
        begin
          if not bFacturables then
          begin
            Advertir('ATENCION: Dentro de la seleccion hay albaranes no validados.');
          end;
        end;
      end;
    finally
      Close;
    end;



    SQL.Clear;
    SQL.Add('INSERT INTO tmp_facturas_l ');
    SQL.Add('    ( factura_tf,fecha_tf,usuario_tf,cod_empresa_tf,cod_procede_tf,');
    SQL.Add('      cod_cliente_sal_tf,cod_cliente_fac_tf,impuesto_tf,');
    SQL.Add('      pedido_tf,vehiculo_tf,albaran_tf,fecha_alb_tf,centro_salida_tf,');
    SQL.Add('      cod_pais_tf,moneda_tf,cod_dir_sum_tf,cod_producto_tf,');
    SQL.Add('      cod_envase_tf,producto_tf,producto2_tf,envase_tf,descripcion2_e,');
    SQL.Add('      cajas_tf,unidades_caja_tf,kilos_tf,unidades_tf,');
    SQL.Add('      unidad_medida_tf,precio_unidad_tf,precio_neto_tf,cod_iva_tf,');
    (*IVA*)
    SQL.Add('      tipo_iva_tf,iva_tf, importe_total_tf, ');

    SQL.Add('      envase_comer_tf,categoria_tf, calibre_tf,marca_tf,nom_marca_tf,'); //
    SQL.Add('      transito_tf, incoterm_tf, plaza_incoterm_tf, porte_bonny_tf )');
    SQL.Add('SELECT 0,' + SQLDate((fechaFactura.Text)) + ',' + quotedStr(gsCodigo) + ', ');
    SQL.Add('Frf_salidas_c.empresa_sc,Frf_salidas_l.emp_procedencia_sl,Frf_salidas_c.cliente_sal_sc,');
    SQL.Add('Frf_salidas_c.cliente_fac_sc,Frf_salidas_l.tipo_iva_sl[1,1], ');
    SQL.Add('Frf_salidas_c.n_pedido_sc,Frf_salidas_c.vehiculo_sc,Frf_salidas_c.n_albaran_sc, ');
    SQL.Add('Frf_salidas_c.fecha_sc,Frf_salidas_c.centro_salida_sc, ');
    SQL.Add('Frf_clientes.pais_fac_c,Frf_salidas_c.moneda_sc,');
    SQL.Add('Frf_salidas_c.dir_sum_sc, ');
    SQL.Add('Frf_salidas_l.producto_sl,Frf_salidas_l.envase_sl, ');
    SQL.Add('Frf_productos.descripcion_p descripcion_prod, ');
    SQL.Add('Frf_productos.descripcion2_p descripcion_prod2, ');
    SQL.Add('Frf_envases.descripcion_e,Frf_envases.descripcion2_e,');
    SQL.Add('Frf_salidas_l.cajas_sl, ');
    SQL.Add('Frf_salidas_l.unidades_caja_sl,Frf_salidas_l.kilos_sl, ');
    SQL.Add('(Frf_salidas_l.cajas_sl*Frf_salidas_l.unidades_caja_sl) as unidades, ');
    SQL.Add('Frf_salidas_l.unidad_precio_sl,Frf_salidas_l.precio_sl, ');
    SQL.Add('Frf_salidas_l.importe_neto_sl,Frf_salidas_l.tipo_iva_sl, ');

    (*IVA*)
    SQL.Add('Frf_salidas_l.porc_iva_sl,Frf_salidas_l.iva_sl,Frf_salidas_l.importe_total_sl, ');

    SQL.Add('Frf_envases.envase_comercial_e, Frf_Salidas_l.categoria_sl,');
    SQL.Add('Frf_Salidas_l.calibre_sl,');
    SQL.Add('Frf_Salidas_l.marca_sl,"MARCA", 0, incoterm_sc, plaza_incoterm_sc, porte_bonny_sc ');

    SQL.Add('FROM ');
    SQL.Add('     frf_salidas_c Frf_salidas_c, ');
    SQL.Add('     frf_salidas_l Frf_salidas_l, ');
    SQL.Add('     frf_clientes Frf_clientes, ');
    SQL.Add('     frf_productos Frf_productos, ');
    SQL.Add('     frf_envases Frf_envases ');



    //SQL.Add('WHERE  (empresa_sc = :empresa) ');
    SQL.Add('WHERE  (cliente_fac_sc = :cliente) ');
    SQL.Add('AND  (n_albaran_sc BETWEEN :albaranDesde AND :albaranHasta) ');
    SQL.Add('AND  (fecha_sc <= :fecha) ');

    SQL.Add('AND  (n_factura_sc IS NULL) ');
    SQL.Add('AND  (cliente_sal_sc <> "RET") ');
    SQL.Add('AND  (cliente_sal_sc <> "REA") ');
    SQL.Add('AND  (cliente_sal_sc <> "0BO") ');
    SQL.Add('AND  (cliente_sal_sc <> "EG") ');
    (*if Trim(pedido.Text) <> '' then
      SQL.Add('AND  (n_pedido_sc = :pedido) ');*)
    if Trim(pedido.Text) <> '' then
      SQL.Add('AND  (n_pedido_sc = :pedido) ')
    else
      SQL.Add('AND  (empresa_sc = :empresa) ');

    SQL.Add('AND  (empresa_sl = empresa_sc) ');
    SQL.Add('AND  (centro_salida_sl = centro_salida_sc) ');
    SQL.Add('AND  (n_albaran_sl = n_albaran_sc) ');
    SQL.Add('AND  (fecha_sl = fecha_sc) ');

    SQL.Add('AND  (empresa_c = empresa_sc) ');
    SQL.Add('AND  (cliente_c = cliente_fac_sc) ');

    SQL.Add('AND  (empresa_p = empresa_sc) ');
    SQL.Add('AND  (producto_p = producto_sl) ');

    SQL.Add('AND  (empresa_e = empresa_sc) ');
    SQL.Add('AND  (envase_e = envase_sl) ');
    //SQL.Add('and  (producto_base_e = producto_base_p )');

    if bFacturables then
      SQL.Add('AND  (facturable_sc = 1 ) ');


         //PARAMETROS
    ParamByName('Cliente').AsString := clienteDesde.Text;
    //ParamByName('clienteDesde').AsString := clienteDesde.Text;
    //ParamByName('ClienteHasta').AsString := clienteHasta.Text;
    ParamByName('albaranDesde').AsString := albaranDesde.Text;
    ParamByName('albaranHasta').AsString := albaranHasta.Text;
    ParamByName('fecha').AsDate := StrToDate(fechaFacturar.Text);
    (*
    ParamByName('empresa').AsString := empresa.Text;
    if Trim(pedido.Text) <> '' then
      ParamByName('pedido').AsString := pedido.Text;*)
    if Trim(pedido.Text) <> '' then
      ParamByName('pedido').AsString := pedido.Text
    else
      ParamByName('empresa').AsString := empresa.Text;

    try
      DMBaseDatos.QGeneral.ExecSQL;
      if DMBaseDatos.QGeneral.RowsAffected = 0 then
      begin
        Advertir('No existen albaranes por facturar que cumplan el criterio seleccionado.');
        Exit;
      end;
             //EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      Exit;
    end;
  end;
  Result := True;
  DescripcionMarca;
end;

function TFLSelecFacturas.ComprobarCuentas: Boolean;
var
  aux: string;
  borrados, totales: integer;
begin
  totales := 0;
  borrados := 0;
  with DMBaseDatos do
  begin
    if QGeneral.Active then
    begin
      QGeneral.Cancel;
      QGeneral.Close;
    end;

    QGeneral.SQL.Clear;
    QGeneral.SQL.Add(' SELECT DISTINCT cod_emp_factura_tf, cod_cliente_fac_tf, ');
    QGeneral.SQL.Add('        cta_cliente_c, cta_ingresos_pgc_c ');
    //QGeneral.SQL.Add('        representante_c, cta_cliente_c, cta_ingresos_pgc_c ');
    QGeneral.SQL.Add(' FROM   tmp_facturas_l, frf_clientes ');
    QGeneral.SQL.Add(' WHERE  usuario_tf ' + SQLEqualS(gsCodigo));
    QGeneral.SQL.Add('   AND  cod_emp_factura_tf = empresa_c ');
    QGeneral.SQL.Add('   AND  cod_cliente_fac_tf = cliente_c ');
    QGeneral.Open;

    QGeneral.First;
    while not QGeneral.Eof do
    begin
      if (* ( QGeneral.fieldbyname('representante_c').AsString = '' ) or *)
        (QGeneral.fieldbyname('cta_cliente_c').AsString = '') or
        (QGeneral.fieldbyname('cta_ingresos_pgc_c').AsString = '') then
      begin
        aux := '';
        (*if ( QGeneral.fieldbyname('representante_c').AsString = '' ) then
        begin
          aux:= '  * Falta el representante del cliente. (Si no tiene seleccione "SIN REPRESENTANTE")' + #13 + #10;
        end;*)

        if (QGeneral.fieldbyname('cta_cliente_c').AsString = '') then
        begin
          aux := aux + '  * Falta la cuenta del cliente. ' + #13 + #10;
        end;

        if (QGeneral.fieldbyname('cta_ingresos_pgc_c').AsString = '') then
        begin
          aux := aux + '  * Falta la cuenta de ingresos del cliente. ' + #13 + #10;
        end;

        Advertir(' No se puede facturar al cliente "' +
          QGeneral.fieldbyname('cod_cliente_fac_tf').AsString +
          '"' + #13 + #10 + aux +
          ' CONSULTE CON EL DEPARTAMENTO DE CONTABILIDAD.');

        QAux.SQL.Clear;
        QAux.SQL.Add('DELETE FROM tmp_facturas_l ');
        QAux.SQL.Add('WHERE usuario_tf ' + SQLEqualS(gsCodigo));
        QAux.SQL.Add('  AND cod_cliente_fac_tf ' +
          SQLEqualS(QGeneral.fieldbyname('cod_cliente_fac_tf').AsString));
        QAux.ExecSQL;

        Inc(borrados);
      end;

      //Siguiente registro
      QGeneral.Next;
      Inc(totales)
    end;

    QGeneral.Close;
    Result := borrados <> totales;
  end;
end;

function TFLSelecFacturas.NumeraFacturas( const AEmpresa: string ): integer;
var
  cliente, pedido, albaran : string;
  error: boolean;
  moneda, impuesto: string;
  clientesBorrar: TStringList;
  cont: integer;
begin
  clientesBorrar := TStringList.Create;
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    RequestLive := true;
    SQL.Clear;
    SQL.Add(' SELECT usuario_tf, cod_empresa_tf, cod_cliente_fac_tf, moneda_tf, impuesto_tf, ');
    SQL.Add('        fecha_alb_tf, pedido_tf, vehiculo_tf, albaran_tf, cod_emp_factura_tf, factura_tf');
    SQL.Add(' FROM tmp_facturas_l ');
    SQL.Add(' ORDER BY  1,2,3,4,5,6,7,8,9 ');

    try
      DMBaseDatos.QGeneral.Active := true;
    except
      on e: EDBEngineError do
      begin
        ShowError(e);
        NumeraFacturas := 0;
        Exit;
      end;
    end;

    if IsEmpty then
    begin
      ShowError('No hay facturas a realizar para los datos introducidos');
      NumeraFacturas := 0;
      Exit;
    end;

    contador := 1;
    while not Eof do
    begin
      case FacturarPor(FieldByName('cod_empresa_tf').AsString, FieldByName('cod_cliente_fac_tf').AsString) of
        0:
          begin
                    //UNA FACTURA PARA TODOS LOS ALBARANES PENDIENTES
            error := false;
            cliente := FieldByName('cod_cliente_fac_tf').AsString;
            moneda := FieldByName('moneda_tf').AsString;
            impuesto := FieldByName('impuesto_tf').AsString;
            repeat
              if not error then
              begin
                if (moneda <> FieldByName('moneda_tf').AsString) and
                  (cliente = FieldByName('cod_cliente_fac_tf').AsString) then
                begin
                  Error := true;
                  clientesBorrar.Add(FieldByName('cod_cliente_fac_tf').AsString);
                  showerror('No se puede facturar al cliente "' +
                    FieldByName('cod_cliente_fac_tf').AsString +
                    '" por tener albaranes en distintas monedas.');
                end
                else
                begin
                  edit;
                  FieldByName('factura_tf').AsInteger := contador;
                  FieldByName('cod_emp_factura_tf').AsString := AEmpresa; //FieldByName('cod_empresa_tf').AsString;
                  post;
                end;
              end;
              Next;
            until (cliente <> FieldByName('cod_cliente_fac_tf').AsString) or
              (impuesto <> FieldByName('impuesto_tf').AsString) or
              EOF;
          end;
        1:
          begin
                    //OTROS UNA FACTURA POR ALBARAN
            cliente := FieldByName('cod_cliente_fac_tf').AsString;
            pedido := FieldByName('pedido_tf').AsString;
            albaran := FieldByName('albaran_tf').AsString;
            repeat
              edit;
              FieldByName('factura_tf').AsInteger := contador;
              FieldByName('cod_emp_factura_tf').AsString := AEmpresa;//FieldByName('cod_empresa_tf').AsString;
              post;
              Next;
            until (cliente <> FieldByName('cod_cliente_fac_tf').AsString) or
              (pedido <> FieldByName('pedido_tf').AsString) or
              (albaran <> FieldByName('albaran_tf').AsString) or EOF;
          end;
        2:
          begin
                //OTROS UNA FACTURA POR PEDIDO
                //POR PEDIDO, VEHICULO O AMBOS
            cliente := FieldByName('cod_cliente_fac_tf').AsString;
            pedido := FieldByName('pedido_tf').AsString;
            //slEmpresa := FieldByName('cod_empresa_tf').AsString;
            repeat
              edit;
              FieldByName('factura_tf').AsInteger := contador;
              FieldByName('cod_emp_factura_tf').AsString := AEmpresa;
              post;
              Next;
            until (cliente <> FieldByName('cod_cliente_fac_tf').AsString) or
              (pedido <> FieldByName('pedido_tf').AsString) or EOF;
          end;
      end;
      contador := contador + 1;
    end;

          //Borrar erroneos
    if clientesBorrar.Count > 0 then
    begin
      SQL.Clear;
      SQL.Add('DELETE FROM tmp_facturas_l ');
      SQL.Add('WHERE usuario_tf = ' + quotedstr(gsCodigo));
      SQL.Add(' AND (cod_cliente_fac_tf = ' + quotedstr(clientesBorrar.Strings[0]));
      for cont := 1 to clientesBorrar.Count - 1 do
        SQL.Add(' OR cod_cliente_fac_tf = ' + quotedstr(clientesBorrar.Strings[cont]));
      SQL.Add(')');

      try
        EjecutarConsulta(DMBaseDatos.QGeneral);
      except
        NumeraFacturas := 0;
        Exit;
      end;
    end;
    NumeraFacturas := contador;
  end;

  FreeAndNil( clientesBorrar );
end;

function TFLSelecFacturas.LimpiarTabla: boolean;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('DELETE FROM tmp_facturas_l ');
          //Mientras sólo pueda facturar borrar todas las entradas
          //SQL.Add('WHERE usuario_tf = '+quotedstr(gsCodigo));

    try
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      LimpiarTabla := false;
      Exit;
    end;

    SQL.Clear;
    SQL.Add('DELETE FROM tmp_facturas_c ');
          //Mientras sólo pueda facturar borrar todas las entradas
          //SQL.Add('WHERE usuario_tfc = '+quotedstr(gsCodigo));

    try
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      LimpiarTabla := false;
      Exit;
    end;

    SQL.Clear;
    SQL.Add('DELETE FROM tmp_gastos_fac ');
          //Mientras sólo pueda facturar borrar todas las entradas
    SQL.Add('WHERE usuario_tg = ' + quotedstr(gsCodigo));

    try
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      LimpiarTabla := false;
      Exit;
    end;
  end;
  LimpiarTabla := true;
end;

function TFLSelecFacturas.RellenaFacturas: Boolean;
var
  RImportesCabecera: TRImportesCabecera;
  FacturaNumero: Integer;
  Facturas, insertadas: Integer;
  Error: boolean;
  sAux: string;
begin
  Error := false;
  insertadas := 0;
  FacturaNumero := -1;
     //ABRIR TABLAS GUIAS
  with DMFacturacion do
  begin
    if DMFacturacion.QBuscaSalida.Active then
    begin
      DMFacturacion.QBuscaSalida.Cancel;
      DMFacturacion.QBuscaSalida.Close;
    end;
    if DMFacturacion.QCabeceraFactura.Active then
    begin
      DMFacturacion.QCabeceraFactura.Cancel;
      DMFacturacion.QCabeceraFactura.Close;
    end;
    DMFacturacion.QCabeceraFactura.RequestLive := true;
    DMFacturacion.QCAbeceraFactura.SQL.Clear;
    DMFacturacion.QCAbeceraFactura.SQL.add('SELECT * FROM tmp_facturas_c ' +
      ' ORDER BY factura_tfc');

    try
      AbrirConsulta(QCabeceraFactura);
      Facturas := QCabeceraFactura.RecordCount;
    except
      RellenaFacturas := false;
      Exit;
    end;

    try
      AbrirConsulta(QBuscaSalida);
    except
      QBuscaSalida.Close;
      RellenaFacturas := false;
      Exit;
    end;

          //Poner consulta de escritura
    if DMBaseDatos.QGeneral.Active then
    begin
      DMBaseDatos.QGeneral.Cancel;
      DMBaseDatos.QGeneral.Close;
    end;
    DMBaseDatos.QGeneral.RequestLive := true;

          //Recorrer tablas y actualizar datos
    while not QCabeceraFactura.Eof do
    begin
               //ABRIR TRANSACCION
      if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
        break;

      RImportesCabecera:= DatosTotalesFactura( QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                                               QCabeceraFactura.FieldByName('factura_tfc').AsInteger,
                                               QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime
                                               );

      try
                  //Actualiza contador y fecha facturas de empresa
        FacturaNumero := GetNumeroFactura(QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
          QCabeceraFactura.FieldByName('tipo_iva_tfc').AsString,
          QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime, sAux);
        if FacturaNumero = -1 then
        begin
          ShowError( sAux );
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
          Break;
        end;
                  //Numero Factura Definitiva
        QCabeceraFactura.Edit;
        QCabeceraFactura.FieldByName('n_factura_tfc').AsInteger := FacturaNumero;
        QCabeceraFactura.Post;
      except
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        break;
      end;

      with DMBaseDatos.QGeneral do
      begin
        Cancel;
        Close;
        SQL.Clear;
        SQL.add('INSERT INTO frf_facturas ');
        SQL.add('( empresa_f,cliente_sal_f,cliente_fac_f,n_factura_f, ');
        SQL.add('  fecha_factura_f,tipo_factura_f,concepto_f,moneda_f, ');
        SQL.add('  importe_neto_f,tipo_impuesto_f,porc_impuesto_f, ');
        SQL.add('  total_impuesto_f,importe_total_f,importe_euros_f,contabilizado_f,contab_cobro_f, ');
        SQL.add('  nota_albaran_f, prevision_cobro_f )');
        SQL.add('VALUES (');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString) + ', ');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_client_sal_tfc').AsString) + ', ');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString) + ', ');
        SQL.add(IntToStr(FacturaNumero) + ', ');
        SQL.add(SQLDate(QCabeceraFactura.FieldByName('fecha_tfc').AsString) + ', ');
        SQL.add(QCabeceraFactura.FieldByName('tipo_factura_tfc').AsString + ', ');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('concepto_tfc').AsString) + ', ');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString) + ', ');
        SQL.add(SQLNumeric(RImportesCabecera.rTotalBase) + ', ');
        SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_iva_tfc').AsString) + ', ');
        if RImportesCabecera.rTotalBase <> 0 then
          SQL.add(SQLNumeric( ( ( RImportesCabecera.rTotalImporte / RImportesCabecera.rTotalBase ) - 1 ) * 100 )+ ', ')
        else
          SQL.add( SQLNumeric( 0 ) + ', ');
        SQL.add(SQLNumeric(RImportesCabecera.rTotalIva) + ', ');
        SQL.add(SQLNumeric(RImportesCabecera.rTotalImporte) + ',');
        SQL.add(SQLNumeric(RImportesCabecera.rTotalEuros) + ', ');
        SQL.add(quotedstr('N') + ', ');
        SQL.add(quotedstr('N') + ', ');
        SQL.add(':nota, :fechacobro ) ');
        ParamByName('nota').AsString:= QCabeceraFactura.FieldByName('nota_albaran_tfc').AsString;
        ParamByName('fechacobro').AsDate:= GetFechaVencimiento( QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                                                             QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString,
                                                             QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime);

        try
          //Rellena tabla cabecera de facturacion
          EjecutarConsulta(DMBaseDatos.QGeneral);
        except
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
          break;
        end;

        while not QBuscaSalida.Eof do
        begin
          Cancel;
          Close;
          SQL.Clear;
          SQL.add('UPDATE frf_salidas_c ');
          SQL.add('SET ');
          SQL.add('   empresa_fac_sc = ' + quotedStr(QBuscaSalida.FieldByName('cod_emp_factura_tf').AsString) + ' ,');
          SQL.add('   fecha_factura_sc= ' + SQLDate(QCabeceraFactura.FieldByName('fecha_tfc').AsString) + ' ,');
          SQL.add('   n_factura_sc= ' + IntToStr(FacturaNumero) + ' ');
          SQL.add('Where empresa_sc= ' + quotedStr(QBuscaSalida.FieldByName('cod_empresa_tf').AsString) + ' ');
          SQL.add('AND centro_salida_sc= ' + quotedstr(QBuscaSalida.FieldByName('centro_salida_tf').AsString) + ' ');
          SQL.add('AND n_albaran_sc= ' + QBuscaSalida.FieldByName('albaran_tf').AsString + ' ');
          SQL.add('AND fecha_sc= ' + SQLDate(QBuscaSalida.FieldByName('fecha_alb_tf').AsString) + ' ');

          try
                            //Rellena factura y fecha facturacion en salidas
            EjecutarConsulta(DMBaseDatos.QGeneral);
            QBuscaSalida.Next;
          except
            CancelarTransaccion(DMBaseDatos.DBBaseDatos);
            error := true;
            break;
          end;
        end;
        if error then break;
      end;
      AceptarTransaccion(DMBaseDatos.DBBaseDatos);


      try
        FacturaEdi( QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                           QCabeceraFactura.FieldByName('n_factura_tfc').AsInteger,
                           QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime );
      except
        ShowMEssage('Error al crear la Facturacion EDI de la factura nº ' + IntToStr( FacturaNumero ) );
        //raise;
      end;

      try
        QCabeceraFactura.Next;
        Inc(insertadas);
      except
        on E: EDBEngineError do
        begin
          ShowError(E);
          break;
        end
      end;
    end;
  end;
  if (insertadas < Facturas) or (insertadas = 0) then
  begin
    if insertadas = 0 then
    begin
      ShowError('No se ha podido realizar la operacion.');
      RellenaFacturas := false;
      Exit;
    end
    else
    begin
      ShowError('No se ha podido realizar la operación completa.' +
        ' Se han insertado ' + IntToStr(insertadas) + ' facturas de ' +
        IntToStr(Facturas) + ' posibles.');
      BorrarNoFacturadas;
    end;
  end;
  RellenaFacturas := true;
end;

(*FACTAÑOS*)

function TFLSelecFacturas.GetNumeroFactura(empresa, tipo: string; fecha: TDate; var AMsg: string): integer;
var
  iYear, iMont, iDay: Word;
  dFEcha: TDate;
  iFacturaAux: integer;
  sSerie: string;
begin
  DecodeDate( fecha, iYear, iMont, iDay );
  with qryContadores do
  begin
    SQL.Clear;
    if tipo = 'IVA' then
    begin
      SQL.Add(' SELECT cod_serie_fs serie, fac_iva_fs factura, fecha_fac_iva_fs fecha_factura ');
    end
    else
    begin
      SQL.Add(' SELECT cod_serie_fs serie, fac_igic_fs factura, fecha_fac_igic_fs fecha_factura ');
    end;

    SQL.Add(' from frf_facturas_serie ');
    SQL.Add('      join frf_empresas_serie on cod_serie_es = cod_serie_fs and anyo_es = anyo_fs ');
    SQL.Add(' where cod_empresa_es = :empresa ');
    SQL.Add(' and anyo_fs = :anyo ');

    ParamByName('empresa').AsString:= empresa;
    ParamByName('anyo').AsInteger:= iYear;
    Open;

    if IsEmpty then
    begin
      //Crear un nuevo registro
      result:= -1;
      AMsg:= ' Falta inicializar los contadores de facturas para el año "'+ IntToStr( iYear ) +'". ';
    end
    else
    begin
      sSerie:= FieldByName('serie').AsString;
      Result:= FieldByName('factura').AsInteger + 1;
      dFecha:= FieldByName('fecha_factura').AsDateTime;
      Close;
      iFacturaAux:= result;
      result := ComprobrarClavePrimaria(empresa, result, iYear);
      if result = -1 then
      begin
        AMsg:= ' Número factura '+ IntToStr( iFacturaAux ) +' duplicada en el año "' + IntToStr( iYear ) + '". ';
      end
      else
      begin
        SQL.Clear;
        SQL.Add(' UPDATE frf_facturas_serie ');
        if tipo = 'IVA' then
        begin
          SQL.Add(' SET fac_iva_fs= ' + IntToStr( result) );
        end
        else
        begin
          SQL.Add(' SET fac_igic_fs= ' + IntToStr( result) );
        end;
        if dFecha < fecha then
        begin
          if tipo = 'IVA' then
          begin
            SQL.Add('     ,fecha_fac_iva_fs= ' + QuotedStr( FormatDateTime( 'dd/mm/yyyy', fecha ) ) );
          end
          else
          begin
            SQL.Add('     ,fecha_fac_igic_fs= ' + QuotedStr( FormatDateTime( 'dd/mm/yyyy', fecha ) ) );
          end;
        end;
        SQL.Add(' WHERE cod_serie_fs = :serie ');
        SQL.Add(' and anyo_fs = :anyo ');
        ParamByName('serie').AsString:= sSerie;
        ParamByName('anyo').AsInteger:= iYear;
        ExecSQL;
      end;
    end;
  end;
end;

procedure TFLSelecFacturas.BorrarNoFacturadas;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('DELETE FROM tmp_facturas_c ');
    SQL.Add('WHERE usuario_tf = ' + quotedstr(gsCodigo));
    SQL.Add(' AND n_factura_tf = 0 ');

    try
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      ShowError('Las hojas con número de factura igual a 0 deben ser tomadas como informativas.');
    end;
  end;
end;

procedure TFLSelecFacturas.Limpiar;
begin
     //BORRAR CONTENIDO DE LA TABLAs
  LimpiarTabla;

     //Cerrar todos ls datastes abiertos
  DMBaseDatos.DBBaseDatos.CloseDataSets;

  //Poner de sólo lectura las tablas/consultas que hayamos creado
  DMBaseDatos.QGeneral.RequestLive := false;
  DMFacturacion.QCabeceraFactura.RequestLive := false;
end;


function TFLSelecFacturas.NumeroCopias: Integer;
var
  aux: Integer;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    SQL.Clear;
    SQL.Add('SELECT MAX(Frf_clientes.n_copias_fac_c) ');
    SQL.Add('FROM tmp_facturas_c Tmp_facturas_c, frf_clientes Frf_clientes ');
    SQL.Add('WHERE  (Tmp_facturas_c.cod_empresa_tfc = Frf_clientes.empresa_c) ');
    SQL.Add('AND  (Tmp_facturas_c.cod_client_sal_tfc = Frf_clientes.cliente_c) ');
    try
      AbrirConsulta(DMBaseDatos.QGeneral);
    except
             //
    end;
    aux := Fields[0].AsInteger;
    if (aux > 1) and not printOriginal.Checked then Dec(aux);
    if (aux > 1) and not printEmpresa.Checked then Dec(aux);
    NumeroCopias := aux;
  end;
end;

procedure TFLSelecFacturas.FormShow(Sender: TObject);
begin
     //Rellenamos datos iniciales
  begin
    empresa.Text := gsDefEmpresa;
    clienteDesde.Text := gsDefCliente;
    //clienteHasta.Text := 'ZZZ';
    albaranDesde.Text := '1';
    albaranHasta.Text := '999999';
    fechaFacturar.Text := DateToStr(Date);
    fechaFactura.Text := DateToStr(Date);
  end;
end;


function TFLSelecFacturas.ComprobrarClavePrimaria( const AEmpresa: string; const AFactura, AAnyo: Integer ): Integer;
begin
  Result := -1;
  with DMBaseDatos.QListado do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;
    SQL.Add(' SELECT * ');
    SQL.Add(' FROM frf_facturas ');
    SQL.Add(' WHERE empresa_f=' + quotedstr(AEmpresa) + ' ');
    SQL.Add(' AND n_factura_f=' + IntToStr(AFactura) + ' ');
    SQL.Add(' AND YEAR(fecha_factura_f) = ' + IntToStr(AAnyo) + ' ');
    try
      Open;
      if IsEmpty then
      begin
        result:= AFactura;
      end;
    finally
      Close;
    end;
  end;
end;

function TFLSelecFacturas.FacturarPor(const empresa, cliente: string): integer;
begin
  //0 Facturar todos los albaranes pendientes
  //1 Un albaran una factura
  //2 Un pedido una factura
  if Trim(pedido.Text) <> '' then
  begin
    result := 2;
  end
  else
  begin
    DMAuxDB.QAux.SQL.Clear;
    DMAuxDB.QAux.SQL.Add(' select NVL( albaran_factura_c, 0 ) ');
    DMAuxDB.QAux.SQL.Add(' from frf_clientes ');
    DMAuxDB.QAux.SQL.Add(' where empresa_c ' + SQLEqual(empresa));
    DMAuxDB.QAux.SQL.Add('   and cliente_c ' + SQLEqualS(cliente));
    DMAuxDB.QAux.Open;
    if DMAuxDB.QAux.Fields[0].AsInteger = 0 then
      result := 0
    else
      result := 1;
    DMAuxDB.QAux.Close;
  end;
end;

function TFLSelecFacturas.AlbaranFactura(empresa, cliente: string): boolean;
begin
  DMAuxDB.QAux.SQL.Clear;
  DMAuxDB.QAux.SQL.Add(' select albaran_factura_c from frf_clientes ');
  DMAuxDB.QAux.SQL.Add(' where empresa_c ' + SQLEqual(empresa));
  DMAuxDB.QAux.SQL.Add('   and cliente_c ' + SQLEqualS(cliente));
  DMAuxDB.QAux.Open;
  if DMAuxDB.QAux.IsEmpty then
  begin
    result := true;
  end
  else
  begin
    result := DMAuxDB.QAux.Fields[0].AsInteger = 1;
  end;
  DMAuxDB.QAux.Close;
end;

procedure TFLSelecFacturas.TimerTimer(Sender: TObject);
var
  usuario: string;
begin
  usuario := gsCodigo;
  SBAceptar.Enabled := PuedoFacturar(gsCodigo,usuario);
  if SBAceptar.Enabled then
  begin
    BEMensajes('');
  end
  else
  begin
    BEMensajes('En este momento esta facturando el usuario ' + usuario);
  end;
end;

function TFLSelecFacturas.AsuntoFactura: string;
var
  sIniFactura, sFinFactura: string;
  sIniCliente, sFinCliente: string;
begin
    with DMFacturacion.QRangoFacturas do
    begin
      ParamByName('usuario').AsString:= gsCodigo;
      Open;
      sIniFactura:= FieldByName('minFac').asstring;
      sFinFactura:= FieldByName('maxFac').asstring;
      sIniCliente:= FieldByName('minCli').asstring;
      sFinCliente:= FieldByName('maxCli').asstring;
      Close;
    end;
    if sIniFactura <> sFinFactura then
    begin
      result:= 'Envío facturas ' + sIniFactura + '-' + sFinFactura;
      if sIniCliente <> sFinCliente then
      begin
        result:= result + ' [' + sIniCliente + '-' + sFinCliente + ']';
      end
      else
      begin
        result:= result + ' [' + desCliente( empresa.Text, sIniCliente ) + ']';
      end;
    end
    else
    begin
      result:= 'Envío factura ' + sIniFactura + ' [' + desCliente( empresa.Text, sIniCliente ) + ']';
    end;
end;

procedure TFLSelecFacturas.Previsualizar;
(*
var
  QFacControlSocios: TQFacControlSocios;
*)
begin
     //Crear el listado
  try
    DMFacturacion.QCabeceraFactura.ParamByName('usuario').AsString := gsCodigo;
    DMFacturacion.QCabeceraFactura.Open;
    DMFacturacion.QLineaFactura.Open;
    DMFacturacion.QLineaGastos.Open;
  except
    Limpiar;
    Exit;
  end;

  DConfigMail.sAsunto:= AsuntoFactura;
  DConfigMail.sEmpresaConfig:= empresa.Text;
  DConfigMail.sClienteConfig:= clienteDesde.Text;

  QRLFacturas := TQRLFacturas.Create(Application);
  QRLFacturas.LabelFecha.Caption := fechaFactura.Text;
  QRLFacturas.definitivo := bDefinitiva;
  QRLFacturas.bProforma := rgTipoFactura.ItemIndex = 1;

  QRLFacturas.Configurar(Empresa.Text);
  QRLFacturas.printOriginal := printOriginal.Checked;
  QRLFacturas.printEmpresa := printEmpresa.Checked;
  if bDefinitiva then
  begin
    DPreview.bCanSend := (DMConfig.EsLaFont);
    if printOriginal.Checked then
      QRLFacturas.Tag:= 1
    else
    if printEmpresa.Checked then
      QRLFacturas.Tag:= 2
    else
      QRLFacturas.Tag:= 3;
    Preview(QRLFacturas, NumeroCopias, False, True)
  end
  else
  begin
    QRLFacturas.Tag:= 0;
    Preview(QRLFacturas, 1, False, False);
  end;


     (**************************************************************************)

  Limpiar;
end;

procedure TFLSelecFacturas.FormActivate(Sender: TObject);
begin
  Top := 1;
end;

procedure TFLSelecFacturas.printOriginalClick(Sender: TObject);
begin
  if printOriginal.Checked and printEmpresa.Checked then begin
    copiasLabel.Caption := 'Copia Cliente - Copia Empresa - Copia1 - Copia2 - ........';
  end else
    if printOriginal.Checked then begin
      copiasLabel.Caption := 'Copia Cliente - Copia1 - Copia2 - ........';
    end else
      if printEmpresa.Checked then begin
        copiasLabel.Caption := 'Copia Empresa - Copia1 - Copia2 - ........';
      end else begin
        copiasLabel.Caption := 'Copia1 - Copia2 - ........';
      end;
end;

procedure TFLSelecFacturas.rgTipoFacturaClick(Sender: TObject);
begin
  chkAlbaranesValidados.Enabled:= rgTipoFactura.ItemIndex <> 2;
  if not chkAlbaranesValidados.Enabled then
    chkAlbaranesValidados.Checked:= True;
end;

end.
