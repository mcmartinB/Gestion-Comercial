unit ListadoFacturasFD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, dbtables;

type
  TFDListadoFacturas = class(TForm)
    Panel1: TPanel;
    GBFecha: TGroupBox;
    Desde: TLabel;
    Label14: TLabel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    RGImpuesto: TRadioGroup;
    GBFacturas: TGroupBox;
    DFactura: TBEdit;
    HFactura: TBEdit;
    Label2: TLabel;
    Label3: TLabel;
    GBClientes: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    DCliente: TBEdit;
    HCliente: TBEdit;
    BGBDCliente: TBGridButton;
    BGBHCliente: TBGridButton;
    Label1: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    cbxNacionalidad: TComboBox;
    ePais: TBEdit;
    btnPais: TBGridButton;
    QFacturas: TQuery;
    chkExcluirMercadona: TCheckBox;
    Label6: TLabel;
    ESerie: TBEdit;
    BGBSerie: TBGridButton;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;
    function CargarQuery: Boolean;
    procedure AbrirTabla;
    procedure Imprimir;
    procedure HFacturaExit(Sender: TObject);
    procedure RGImpuestoClick(Sender: TObject);
    procedure cbxNacionalidadChange(Sender: TObject);
  private
    function GetPais: string;
  public
    { Public declarations }
    empresa, centro, producto, factura: string;
  end;

var
  listar: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, CAuxiliarDB, CReportes,
  ListadoFacturasQR, DPreview, UDMBaseDatos, CGlobal, CFactura;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFDListadoFacturas.BBAceptarClick(Sender: TObject);
begin
  if CamposVacios then Exit;

  if not CerrarForm(true) then Exit;

  if not CargarQuery then Exit;

  AbrirTabla;

  if listar then Imprimir
  else ShowError('No se puede mostrar el listado de facturas');

end;

procedure TFDListadoFacturas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFDListadoFacturas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  if gProgramVersion = pvBAG then
  begin
    EEmpresa.Text := 'BAG';
  end
  else
  begin
    EEmpresa.Text := 'SAT';
  end;
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  MEDesde.Text := DateTostr(Date);
  MEHasta.Text := DateTostr(Date);
  DCliente.Text := '0';
  HCliente.Text := 'ZZZ';
  DFactura.Text := '0';
  HFactura.Text := '999999';
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  ESerie.Tag := kSerie;
  DCliente.Tag := kCliente;
  HCliente.Tag := kCliente;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  ePais.Tag := kPais;
  ePais.Text := 'ES';

  listar := True;
end;

procedure TFDListadoFacturas.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := EEmpresa;
end;

procedure TFDListadoFacturas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TFDListadoFacturas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  Action := caFree;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFDListadoFacturas.MEHastaExit(Sender: TObject);
begin
  if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
  begin
    MessageDlg('Debe escribir un rango de fechas correcto',
      mtError, [mbOk], 0);
    MEDesde.SetFocus;
  end;
end;

procedure TFDListadoFacturas.HFacturaExit(Sender: TObject);
begin
//comprobar el rango de numero de facturas
  if StrToInt(HFactura.Text) < StrToInt(DFactura.Text) then
  begin
    MessageDlg('Debe escribir un rango de facturas correcto',
      mtError, [mbOk], 0);
    HFactura.SetFocus;
  end;
end;

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFDListadoFacturas.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kSerie: DespliegaRejilla(BGBSerie);
    kPais: DespliegaRejilla(btnPais, []);
    kCliente:
      begin
        if DCliente.Focused then
          DespliegaRejilla(BGBDCliente, [EEmpresa.Text])
        else
          DespliegaRejilla(BGBHCliente, [EEmpresa.Text])
      end;
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFDListadoFacturas.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.text);
  end;
end;

function TFDListadoFacturas.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if ESerie.Text <> '' then
  begin
    if not ExisteSerieG( ESerie.Text ) then
    begin
      ShowError(' La serie indicada es incorrecta.');
      ESerie.SetFocus;
      Result := True;
      Exit;
    end;
  end;

  Result := False;
end;

function TFDListadoFacturas.GetPais: string;
var
  pais: string;
begin
  result := '';
  case cbxNacionalidad.ItemIndex of
    1: pais := ' and pais_c = ''ES'' ';
    2: pais := ' and pais_c <> ''ES'' ';
    3: pais := ' and pais_c = ' + QuotedStr(ePais.Text);
  else exit;
  end;
  result := ' and exists ' +
    ' ( ' +
    '  select cliente_c from frf_clientes ' +
    '  where cliente_c = cod_cliente_fc ' +
    pais +
    ' ) ';
end;

function TFDListadoFacturas.CargarQuery: Boolean;
var
  filtro: string;
begin
  filtro := '';
  case RGImpuesto.ItemIndex of
    0:
      begin
        if CheckBox1.Checked then
          filtro := 'tipo_impuesto_fc = ' + QuotedStr('IR');

        if CheckBox2.Checked then
        begin
          if filtro <> '' then filtro := filtro + ' or ';
          filtro := filtro + 'tipo_impuesto_fc = ' + QuotedStr('IC');
        end;

        if CheckBox3.Checked then
        begin
          if filtro <> '' then filtro := filtro + ' or ';
          filtro := filtro + 'tipo_impuesto_fc = ' + QuotedStr('IE');
        end;
      end;
    1:
      begin
        if CheckBox4.Checked then
        begin
          if filtro <> '' then filtro := filtro + ' or ';
          filtro := filtro + 'tipo_impuesto_fc = ' + QuotedStr('GR');
        end;

        if CheckBox5.Checked then
        begin
          if filtro <> '' then filtro := filtro + ' or ';
          filtro := filtro + 'tipo_impuesto_fc = ' + QuotedStr('GE');
        end;
      end;
    2:
      begin
        if CheckBox1.Checked then
          filtro := 'tipo_impuesto_fc = ' + QuotedStr('IR');

        if CheckBox2.Checked then
        begin
          if filtro <> '' then filtro := filtro + ' or ';
          filtro := filtro + 'tipo_impuesto_fc = ' + QuotedStr('IC');
        end;

        if CheckBox3.Checked then
        begin
          if filtro <> '' then filtro := filtro + ' or ';
          filtro := filtro + 'tipo_impuesto_fc = ' + QuotedStr('IE');
        end;

        if CheckBox4.Checked then
        begin
          if filtro <> '' then filtro := filtro + ' or ';
          filtro := filtro + 'tipo_impuesto_fc = ' + QuotedStr('GR');
        end;

        if CheckBox5.Checked then
        begin
          if filtro <> '' then filtro := filtro + ' or ';
          filtro := filtro + 'tipo_impuesto_fc = ' + QuotedStr('GE');
        end;
      end;
  end;

  if filtro <> '' then filtro := ' AND (' + filtro + ') '
  else
  begin
    MessageDlg('' + #13 + #10 + 'Por favor, marque algun tipo de impuesto.   ', mtWarning, [mbOK], 0);
    Result := False;
    Exit;
  end;

  QFacturas.SQL.Clear;
  QFacturas.SQL.Add('   select cod_empresa_fac_fc empresa_f, cod_serie_fac_fc serie_f, cod_cliente_fc cliente_sal_f, cod_cliente_fc cliente_fac_f,  ' +
    '  n_factura_fc n_factura_f, fecha_factura_fc fecha_factura_f, tipo_factura_fc tipo_factura_f,                                                  ' +
    '  CASE WHEN (automatica_fc = 1 )  THEN "A"  ELSE "M"  END concepto_f,                                                                          ' +
    '  anulacion_fc anulacion_f, moneda_fc moneda_f, importe_neto_fc importe_neto_f, tipo_impuesto_fc tipo_impuesto_f,                              ' +
    '  round((CASE WHEN (importe_neto_fc = 0. )  THEN 0  ELSE (importe_impuesto_fc / importe_neto_fc )  END * 100. ) , 2 ) porc_impuesto_f,         ' +
    '  importe_impuesto_fc total_impuesto_f, importe_total_fc importe_total_f, importe_total_euros_fc importe_euros_f,                              ' +
    '  prevision_cobro_fc prevision_cobro_f, CASE WHEN (contabilizado_fc = 1 )  THEN "S"  ELSE "N"  END contabilizado_f,                            ' +
    '  filename_conta_fc filename_conta_f, "N" contab_cobro_f                                                                                       ' +
    '    from tfacturas_cab                                                                                                                         ' +
    ' where (fecha_factura_fc >= ' + QuotedStr(MEDesde.Text) +
    ' AND fecha_factura_fc <= ' + QuotedStr(MEHasta.Text) + ')' +
    ' AND (n_factura_fc >= ' + DFactura.Text +
    ' AND n_factura_fc <= ' + HFactura.Text + ')' +
    ' AND (cod_cliente_fc >= ' + QuotedStr(DCliente.Text) +
    ' AND cod_cliente_fc <= ' + QuotedStr(HCliente.Text) + ')' );

  if EEmpresa.Text = 'BAG' then
  begin
     QFacturas.SQL.Add(' and substr( cod_empresa_fac_fc, 1, 1)  = ''F'' ');
  end
  else
  if EEmpresa.Text = 'SAT' then
  begin
    QFacturas.SQL.Add(' and ( cod_empresa_fac_fc = ''050'' or  cod_empresa_fac_fc = ''080'' ) ');
  end
  else
  begin
    QFacturas.SQL.Add(' and cod_empresa_fac_fc = ' + QuotedStr(EEmpresa.Text) );
  end;
  if ESerie.Text <> '' then
    QFacturas.SQL.Add(' and cod_serie_fac_fc = ' + QuotedStr(ESerie.Text) );
  

  if chkExcluirMercadona.Checked then
    QFacturas.SQL.Add(' AND cod_cliente_fc <> ''MER'' ');

  QFacturas.SQL.Add( Filtro + ' ' + GetPais +
    ' order by moneda_f, empresa_f, serie_f, n_factura_f, fecha_factura_f, tipo_impuesto_f ');
  result := True;
end;

procedure TFDListadoFacturas.AbrirTabla;
begin
  try
    QFacturas.Open;
  except
    on E: EDBEngineError do
    begin
      ShowError(e);
      listar := False;
    end;
  end;
end;

procedure TFDListadoFacturas.Imprimir;
var
  QRListadoFacturas: TQRListadoFacturas;
begin
//  llamar al QReport correspondiente
  try
    QRListadoFacturas:= TQRListadoFacturas.Create( self );
    try
      QRListadoFacturas.lblFechas.Caption := 'Del ' + MEDesde.Text + ' al ' + MEHasta.Text;
      QRListadoFacturas.lblClientes.Caption := 'Cliente de ' + DCliente.Text + ' a ' + HCliente.Text;
      QRListadoFacturas.lblFacturas.Caption := 'Facturas de ' + DFactura.Text + ' a ' + HFactura.Text;
      case cbxNacionalidad.ItemIndex of
        1: QRListadoFacturas.lblClientes.Caption := QRListadoFacturas.lblClientes.Caption + ', nacionales';
        2: QRListadoFacturas.lblClientes.Caption := QRListadoFacturas.lblClientes.Caption + ', extranjeros';
        3: QRListadoFacturas.lblClientes.Caption := QRListadoFacturas.lblClientes.Caption + ', ' + desPais(ePais.Text);
      end;
      case RGImpuesto.ItemIndex of
        0: QRListadoFacturas.lblTitulo.Caption := 'LISTADO DE FACTURAS (IVA).';
        1: QRListadoFacturas.lblTitulo.Caption := 'LISTADO DE FACTURAS (IGIC).';
        2: QRListadoFacturas.lblTitulo.Caption := 'LISTADO DE FACTURAS.';
      end;
      PonLogoGrupoBonnysa(QRListadoFacturas, EEmpresa.Text);
      QRListadoFacturas.DataSet := QFacturas;
      Preview(QRListadoFacturas);
    except
      FreeAndNil( QRListadoFacturas );
    end;
  finally
    QFacturas.Close;
  end;
end;

procedure TFDListadoFacturas.RGImpuestoClick(Sender: TObject);
begin
  case RGImpuesto.ItemIndex of
    0: begin
        CheckBox1.Enabled := True;
        CheckBox1.Checked := True;
        CheckBox2.Enabled := True;
        CheckBox2.Checked := True;
        CheckBox3.Enabled := True;
        CheckBox3.Checked := True;

        CheckBox4.Enabled := False;
        CheckBox4.Checked := False;
        CheckBox5.Enabled := False;
        CheckBox5.Checked := False;
      end;
    1: begin
        CheckBox1.Enabled := False;
        CheckBox1.Checked := False;
        CheckBox2.Enabled := False;
        CheckBox2.Checked := False;
        CheckBox3.Enabled := False;
        CheckBox3.Checked := False;

        CheckBox4.Enabled := True;
        CheckBox4.Checked := True;
        CheckBox5.Enabled := True;
        CheckBox5.Checked := True;
      end;

    2: begin
        CheckBox1.Enabled := True;
        CheckBox1.Checked := True;
        CheckBox2.Enabled := True;
        CheckBox2.Checked := True;
        CheckBox3.Enabled := True;
        CheckBox3.Checked := True;

        CheckBox4.Enabled := True;
        CheckBox4.Checked := True;
        CheckBox5.Enabled := True;
        CheckBox5.Checked := True;
      end;
  end;
end;

procedure TFDListadoFacturas.cbxNacionalidadChange(Sender: TObject);
begin
  ePais.Enabled := TComboBox(sender).ItemIndex = 3;
  btnPais.Enabled := ePais.Enabled;
end;

end.
