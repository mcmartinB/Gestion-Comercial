unit LFRepticionFacturas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, DBCtrls, ActnList,
  BDEdit, BSpeedButton, BGridButton, Db,
  CGestionPrincipal, BEdit, Grids, DBGrids, BGrid,
  BCalendarButton, BCalendario, DError, DPreview, DBTables;

type
  TFLRepticionFacturas = class(TForm)
    Panel1: TPanel;
    GBEmpresa: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    SBAceptar: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    STEmpresa: TStaticText;
    stHastaFecha: TStaticText;
    BGBEmpresa: TBGridButton;
    RejillaDespegable: TAction;
    RejillaFlotante: TBGrid;
    eEmpresa: TBEdit;
    eFacturaHasta: TBEdit;
    eFacturaDesde: TBEdit;
    eFechaDesde: TBEdit;
    BCBFechaDesde: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    Timer: TTimer;
    Bevel1: TBevel;
    Label7: TLabel;
    printOriginal: TCheckBox;
    printEmpresa: TCheckBox;
    copiasLabel: TLabel;
    eFechaHasta: TBEdit;
    BCBFechaHasta: TBCalendarButton;
    Label4: TLabel;
    eCliente: TBEdit;
    stHastaFactura: TStaticText;
    Bevel2: TBevel;
    Label6: TLabel;
    Label8: TLabel;
    cbxSoloVer: TCheckBox;
    QFacturasAEP: TQuery;
    btnNombre1: TButton;
    btnCliente: TBGridButton;
    stCliente: TStaticText;
    procedure BCancelarExecute(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RejillaDespegableExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);


    procedure PonNombre(Sender: TObject);

    function Parametros: boolean;
    function RellenaFacturas: boolean;
    function NumeroCopias: Integer;
    procedure TimerTimer(Sender: TObject);
    procedure printOriginalClick(Sender: TObject);
    procedure BCBFechaDesdeClick(Sender: TObject);
    procedure BCBFechaHastaClick(Sender: TObject);
    procedure eFechaDesdeExit(Sender: TObject);
    procedure eFacturaDesdeExit(Sender: TObject);

    procedure RepetirFactura;
    function AsuntoFactura: string;
    procedure btnNombre1Click(Sender: TObject);
    procedure eClienteChange(Sender: TObject);

  public
    enviar: boolean;
    cliente: string;
  end;

var
  FLRepticionFacturas: TFLRepticionFacturas;
implementation

uses UDMBaseDatos, CVariables, bDialogs, UDMCambioMoneda,
  Principal, UDMFacturacion, CAuxiliarDB, FacturasNacionalRI, LFacturas,
  CFacturacion, UDMAuxDB, bSQLUtils, bNumericUtils,
  UDMConfig, DConfigMail, LFacturasWEB;


{$R *.DFM}

procedure TFLRepticionFacturas.BCancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLRepticionFacturas.BAceptarExecute(Sender: TObject);
begin
  RepetirFactura;
end;

function TFLRepticionFacturas.AsuntoFactura: string;
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
        result:= result + ' [' + desCliente( eEmpresa.Text, sIniCliente ) + ']';
      end;
    end
    else
    begin
      result:= 'Envío factura ' + sIniFactura + ' [' + desCliente( eEmpresa.Text, sIniCliente ) + ']';
    end;
end;

procedure TFLRepticionFacturas.RepetirFactura;
var
  usuario: string;
  (*QFacControlSocios: TQFacControlSocios;*)
begin
  UDMFacturacion.Definitiva := true;
  if not CerrarForm(true) then Exit;
  if not Parametros then Exit;

  usuario := gsCodigo;
  SBAceptar.Enabled := QuieroFacturar(usuario);
  if SBAceptar.Enabled then
  begin
    Timer.Enabled := false;
    BEMensajes('');
  end
  else
  begin
    BEMensajes('En este momento esta facturando el usuario ' + usuario);
    Exit;
  end;

  Limpiar;

  try
    PreparaRepeticion(eEmpresa.Text, eFacturaDesde.Text, eFacturaHasta.Text,
      eFechaDesde.Text, eFechaHasta.Text, eCliente.Text, cbxSoloVer.Checked );
  except
    on e: Exception do
    begin
      ShowError(e);
      AcaboFacturar(usuario);
      Timer.Enabled := true;
      Exit;
    end;
  end;

     //una vez preparada la repeticion de la factura averiguamos si es sobre un
     //unico cliente(seleccionamos los clientes de la tabla temporal de facturas
     //cabecera)
  with DMBaseDatos.QGeneral do
  begin
    Close;
    SQl.Clear;
    SQl.Add('SELECT DISTINCT cod_client_sal_tfc');
    SQL.Add(' FROM tmp_facturas_c ');
        //abrir y comprobar el numero de registros
    Open;
    First;
        //Existe un unico cliente
    cliente := FieldByName('cod_client_sal_tfc').AsString;
    enviar := true;
    next;
    if not EOF then
    begin
           //hay mas de un cliente
      enviar := false;
      cliente := '';
    end;
  end;

  if not cbxSoloVer.Checked then
  begin
       ///ABRIR TRANSACCION para la facturacion
    if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
    begin
      AcaboFacturar(usuario);
      Timer.Enabled := true;
      Exit;
    end;

       //Facturacion normal
    if not RellenaFacturas then
    begin
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      Limpiar;
      AcaboFacturar(usuario);
      Timer.Enabled := true;
      Exit;
    end;

    AceptarTransaccion(DMBaseDatos.DBBaseDatos);

  end;

  if UpperCase(gsCodigo) <> 'PRUEBA' then
  begin
       //Crear el listado
    try
          //Abrir tablas
      DMFacturacion.QCabeceraFactura.ParamByName('usuario').AsString := gsCodigo;
      DMFacturacion.QCabeceraFactura.Open;
      DMFacturacion.QLineaFactura.Open;
      DMFacturacion.QLineaGastos.Open;
    except
      AcaboFacturar(usuario);
      Timer.Enabled := true;
      Limpiar;
    end;

    if ( DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString = 'WEB' ) or
       ( DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString = 'CON' ) then
    begin
      try

       DMFacturacion.DireccionFacturaWeb;
       DMFacturacion.QDirFactura.Open;

        DConfigMail.sAsunto:= AsuntoFactura;
         //Crear informe

        QRLFacturasWEB := TQRLFacturasWEB.Create(Application);
        QRLFacturasWEB.LabelFecha.Caption:=eFechaDesde.Text;
        QRLFacturasWEB.definitivo := true;

        QRLFacturasWEB.Configurar;
        QRLFacturasWEB.printOriginal := printOriginal.Checked;
        QRLFacturasWEB.printEmpresa := printEmpresa.Checked;
        QRLFacturasWEB.definitivo := True;

        DPreview.bCanSend := (DMConfig.EsLaFont);
        QRLFacturasWEB.bCopia := cbxSoloVer.Checked;
        if printOriginal.Checked then
          QRLFacturasWEB.Tag:= 1
        else
        if printEmpresa.Checked then
          QRLFacturasWEB.Tag:= 2
        else
          QRLFacturasWEB.Tag:= 3;
        Preview(QRLFacturasWEB, NumeroCopias, False, True);
        QRLFacturasWEB := nil;
      finally
        DMFacturacion.QDirFactura.Close;
        if QRLFacturasWEB <> nil then
          FreeAndNil(QRLFacturasWEB);
      end;
    end
    else
    if PaisCliente( DMFacturacion.QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                    DMFacturacion.QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString ) = 'ES' then
    begin
      try
        DConfigMail.sAsunto:= AsuntoFactura;
         //Crear informe
        QRLFacturasNacional := TRIFacturasNacional.Create(Application);
           //QRLFacturas.LabelFecha.Caption:=eFechaDesde.Text;
        QRLFacturasNacional.definitivo := true;

        QRLFacturasNacional.Configurar(eEmpresa.Text, ecliente.Text);
        QRLFacturasNacional.printOriginal := printOriginal.Checked;
        QRLFacturasNacional.printEmpresa := printEmpresa.Checked;
        QRLFacturasNacional.definitivo := True;

        DPreview.bCanSend := (DMConfig.EsLaFont);
        QRLFacturasNacional.bCopia := cbxSoloVer.Checked;
        if printOriginal.Checked then
          QRLFacturasNacional.Tag:= 1
        else
        if printEmpresa.Checked then
          QRLFacturasNacional.Tag:= 2
        else
          QRLFacturasNacional.Tag:= 3;
        Preview(QRLFacturasNacional, NumeroCopias, False, True);
        QRLFacturasNacional := nil;
      finally
        if QRLFacturasNacional <> nil then
          FreeAndNil(QRLFacturasNacional);
      end;
    end
    else
    begin
      try
        DConfigMail.sAsunto:= AsuntoFactura;
         //Crear informe
        QRLFacturas := TQRLFacturas.Create(Application);
           //QRLFacturas.LabelFecha.Caption:=eFechaDesde.Text;
        QRLFacturas.definitivo := true;

        QRLFacturas.Configurar(eEmpresa.Text, ecliente.Text);
        QRLFacturas.printOriginal := printOriginal.Checked;
        QRLFacturas.printEmpresa := printEmpresa.Checked;
        QRLFacturas.definitivo := True;

        DPreview.bCanSend := (DMConfig.EsLaFont);
        QRLFacturas.bCopia := cbxSoloVer.Checked;
        if printOriginal.Checked then
          QRLFacturas.Tag:= 1
        else
        if printEmpresa.Checked then
          QRLFacturas.Tag:= 2
        else
          QRLFacturas.Tag:= 3;
        Preview(QRLFacturas, NumeroCopias, False, True);
        QRLFacturas := nil;
      finally
        if QRLFacturas <> nil then
          FreeAndNil(QRLFacturas);
      end;
    end;
  end;
  AcaboFacturar(usuario);
  Timer.Enabled := true;
  Limpiar;

end;

procedure TFLRepticionFacturas.FormCreate(Sender: TObject);
var
  usuario: string;
begin
  FormType := tfOther;
  BHFormulario;
  eFechaDesde.Text := DateToStr(Date);
  eFechaHasta.Text := DateToStr(Date);
  CalendarioFlotante.Date := Date;
  eEmpresa.Tag := kEmpresa;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  Timer.Enabled := false;
  Timer.Interval := 5000;
  Timer.Enabled := true;
  usuario := gsCodigo;
  SBAceptar.Enabled := PuedoFacturar(usuario);
  if SBAceptar.Enabled then
  begin
    BEMensajes('');
  end
  else
  begin
    BEMensajes('En este momento esta facturando el usuario ' + usuario);
  end;

  if UpperCase(gsCodigo) = 'PRUEBA' then
  begin
    cbxSoloVer.Checked := true;
    cbxSoloVer.Enabled := false;
    BCBFechaHasta.Enabled := False;
    eFechaHasta.Enabled := False;
    eFacturaHasta.Enabled := False;
    printOriginal.Enabled := false;
    printEmpresa.Enabled := false;
  end;

  eEmpresa.Text := gsDefEmpresa;
  eFacturadesde.Text := '1';
  eFacturahasta.Text := '999999';
  eFechaDesde.Text := DateToStr(Date);
  eFechaHasta.Text := DateToStr(Date);
    
  eEmpresa.ReadOnly:= not DMConfig.EsLaFont;
  if eEmpresa.Enabled then
    eEmpresa.Text:= gsDefEmpresa;
end;

procedure TFLRepticionFacturas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     //Limpiar;
  CanClose := true;
end;

procedure TFLRepticionFacturas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  gRF := nil;
  gCF := nil;
  BEMensajes('');
  Action := caFree;
end;

procedure TFLRepticionFacturas.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  STEmpresa.Caption := desEmpresa(eEmpresa.Text);
end;

procedure TFLRepticionFacturas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

function TFLRepticionFacturas.Parametros: boolean;
begin
     //Comprobar que todos los campos tienen valor
  if trim(eEmpresa.Text) = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    eEmpresa.SetFocus;
    Parametros := false;
    Exit;
  end;
  if trim(eFechaDesde.Text) = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    eFechaDesde.SetFocus;
    Parametros := false;
    Exit;
  end;
  if trim(eFechaHasta.Text) = '' then
  begin
    eFechaHasta.Text := eFechaDesde.Text;
  end;
  if trim(eFacturaDesde.Text) = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición.');
    eFacturaDesde.SetFocus;
    Parametros := false;
    Exit;
  end;
  if trim(eFacturaHasta.Text) = '' then
  begin
    eFacturaHasta.Text := eFacturaDesde.Text;
  end;
     //Desde menor que hasta
  try
    if StrToInt(eFacturaDesde.Text) > StrToInt(eFacturaHasta.Text) then
    begin
      ShowError('El numero de factura del campo "desde" debe ser menor o igual que ' +
        ' el número almacenado en el campo "hasta".');
      eFacturaDesde.SetFocus;
      Parametros := false;
      Exit;
    end;
  except
    ShowError('Los números  de facturas deben de ser enteros.');
    eFacturaDesde.SetFocus;
    Parametros := false;
    Exit;
  end;
  if stCliente.Caption = '' then
  begin
    ShowError('Falta código del cliente o es incorrecto.');
    eCliente.SetFocus;
    Parametros := false;
    Exit;
  end;
  Parametros := true;
end;


//Rellenamos cabecera factura
function TFLRepticionFacturas.RellenaFacturas: boolean;
var
  RImportesCabecera: TRImportesCabecera;
begin
     //ABRIR TABLAS GUIAS
  with DMFacturacion do
  begin
    if QCabeceraFactura.Active then
    begin
      QCabeceraFactura.Cancel;
      QCabeceraFactura.Close;
    end;
    if DMBaseDatos.QGeneral.Active then
    begin
      DMBaseDatos.QGeneral.Cancel;
      DMBaseDatos.QGeneral.Close;
    end;

    try
      AbrirConsulta(QCabeceraFactura);
    except
      RellenaFacturas := false;
      Exit;
    end;
          //Recorrer tablas y actualizar datos
    try
      while not QCabeceraFactura.Eof do
      begin
      RImportesCabecera:= DatosTotalesFactura( QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                                               QCabeceraFactura.FieldByName('factura_tfc').AsInteger,
                                               QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime
                                               );

        with DMBaseDatos.QGeneral do
        begin
          Cancel;
          Close;
          SQL.Clear;
          SQL.add('UPDATE frf_facturas SET ');
          SQL.add('( cliente_sal_f,cliente_fac_f, ');
          SQL.add('  tipo_factura_f,concepto_f,moneda_f, ');
          SQL.add('  importe_neto_f,tipo_impuesto_f,porc_impuesto_f, ');
          SQL.add('  total_impuesto_f,importe_total_f,importe_euros_f, ');
          SQL.add('  nota_albaran_f, prevision_cobro_f  ) ');
          SQL.add('= (');
          SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_client_sal_tfc').AsString) + ', ');
          SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString) + ', ');
          SQL.add(QCabeceraFactura.FieldByName('tipo_factura_tfc').AsString + ', ');
          SQL.add(quotedStr(QCabeceraFactura.FieldByName('concepto_tfc').AsString) + ', ');
          SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_moneda_tfc').AsString) + ', ');

          SQL.add(SQLNumeric(RImportesCabecera.rTotalBase) + ', ');
          SQL.add(quotedStr(QCabeceraFactura.FieldByName('cod_iva_tfc').AsString) + ', ');
          SQL.add(SQLNumeric( ( ( RImportesCabecera.rTotalImporte / RImportesCabecera.rTotalBase ) - 1 ) * 100 ) + ', ');

          SQL.add(SQLNumeric(RImportesCabecera.rTotalIva) + ', ');
          SQL.add(SQLNumeric(RImportesCabecera.rTotalImporte) + ',');
          SQL.add(SQLNumeric(RImportesCabecera.rTotalEuros) + ', ');

          SQL.add( ':nota, :fechacobro ) ');
          SQL.add('WHERE empresa_f=' + quotedStr(QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString) + ' ');
          SQL.add('AND n_factura_f=' + QCabeceraFactura.FieldByName('factura_tfc').AsString + ' ');
          SQL.add('AND fecha_factura_f= :fecha  ');
          ParamByName('fecha').AsDateTime := QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime;
          ParamByName('nota').AsString:= QCabeceraFactura.FieldByName('nota_albaran_tfc').AsString;
          ParamByName('fechacobro').AsDate:= GetFechaVencimiento( QCabeceraFactura.FieldByName('cod_empresa_tfc').AsString,
                                                             QCabeceraFactura.FieldByName('cod_cliente_tfc').AsString,
                                                             QCabeceraFactura.FieldByName('fecha_tfc').AsDateTime);

          try
                       //Rellena tabla cabecera de facturacion
            EjecutarConsulta(DMBaseDatos.QGeneral);
          except
            RellenaFacturas := false;
            Exit;
          end;
        end;

        try
          QCabeceraFactura.Next;
        except
          RellenaFacturas := false;
          Exit;
        end;
      end;
    except
      RellenaFacturas := false;
      Exit;
    end;
  end;
  RellenaFacturas := true;
end;

//Rellenamos cabecera factura

function TFLRepticionFacturas.NumeroCopias: Integer;
var
  aux: integer;
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


procedure TFLRepticionFacturas.TimerTimer(Sender: TObject);
var
  usuario: string;
begin
  usuario := gsCodigo;
  SBAceptar.Enabled := PuedoFacturar(usuario);
  if SBAceptar.Enabled then
  begin
    BEMensajes('');
  end
  else
  begin
    BEMensajes('En este momento esta facturando el usuario ' + usuario);
  end;
end;

procedure TFLRepticionFacturas.printOriginalClick(Sender: TObject);
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

procedure TFLRepticionFacturas.BCBFechaDesdeClick(Sender: TObject);
begin
  DespliegaCalendario(BCBFechaDesde);
end;

procedure TFLRepticionFacturas.BCBFechaHastaClick(Sender: TObject);
begin
  DespliegaCalendario(BCBFechaHasta);
end;

procedure TFLRepticionFacturas.RejillaDespegableExecute(
  Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(BCBFechaDesde)
        else
          DespliegaCalendario(BCBFechaHasta);
      end;
  end;
end;

procedure TFLRepticionFacturas.eFechaDesdeExit(Sender: TObject);
begin
  if UpperCase(gsCodigo) = 'PRUEBA' then
  begin
    eFechaHasta.Text := eFechaDesde.Text;
  end;
  exit;
end;

procedure TFLRepticionFacturas.eFacturaDesdeExit(Sender: TObject);
begin
  if UpperCase(gsCodigo) = 'PRUEBA' then
  begin
    eFacturaHasta.Text := eFacturaDesde.Text;
  end
  else
  begin
    if eFacturaDesde.CanFocus then
      eFacturaHasta.Text := eFacturaDesde.Text;
  end;
end;

procedure TFLRepticionFacturas.btnNombre1Click(Sender: TObject);
begin
  with DMBaseDatos do
  begin
    QAux.Cancel;
    QAux.Close;
    QAux.SQL.Clear;
    QAux.SQL.add('UPDATE frf_facturas ');
    QAux.SQL.add('SET prevision_cobro_f = :fechacobro ');
    QAux.SQL.add('WHERE empresa_f = :empresa ');
    QAux.SQL.add('AND n_factura_f = :factura ');
    QAux.SQL.add('AND fecha_factura_f = :fecha ');

    QGeneral.Cancel;
    QGeneral.Close;
    QGeneral.SQL.Clear;
    QGeneral.SQL.Add( 'select * from frf_facturas ' );
    QGeneral.SQL.Add( 'where empresa_f = :empresa ' );
    QGeneral.SQL.Add( 'and fecha_factura_f between :fechaini and :fechafin ');
    QGeneral.ParamByName('empresa').Asstring:= eEmpresa.Text;
    QGeneral.ParamByName('fechaini').AsDate:= StrToDate( eFechaDesde.Text );
    QGeneral.ParamByName('fechafin').AsDate:= StrToDate( eFechaHasta.Text );
    QGeneral.Open;

    while not QGeneral.Eof do
    begin
      QAux.ParamByName('empresa').Asstring:= QGeneral.FieldByName('empresa_f').AsString;
      QAux.ParamByName('fecha').AsDate:= QGeneral.FieldByName('fecha_factura_f').AsDateTime;
      QAux.ParamByName('factura').AsInteger:= QGeneral.FieldByName('n_factura_f').AsInteger;
      QAux.ParamByName('fechacobro').AsDate:= GetFechaVencimiento( QGeneral.FieldByName('empresa_f').AsString,
                                                             QGeneral.FieldByName('cliente_fac_f').AsString,
                                                             QGeneral.FieldByName('fecha_factura_f').AsDateTime);
      QAux.ExecSql;
      QGeneral.Next;
    end;
    QGeneral.Close;
  end;
end;

procedure TFLRepticionFacturas.eClienteChange(Sender: TObject);
begin
  stCliente.Caption:= desCliente( eEmpresa.Text, eCliente.Text );
end;

end.
