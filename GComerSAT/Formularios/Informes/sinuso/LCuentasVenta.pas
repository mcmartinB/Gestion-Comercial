//Si el gasto es facturable siempres restamos el valor absoluto
//en otro caso si negativo sumamos, si positivo restamos
unit LCuentasVenta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables;

type
  TFLCuentasVenta = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GBEmpresa: TGroupBox;
    LFactura: TLabel;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    BGBCliente: TBGridButton;
    ECliente: TBEdit;
    EEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STCliente: TStaticText;
    RejillaFlotante: TBGrid;
    ADesplegarRejilla: TAction;
    GBFecha: TGroupBox;
    Desde: TLabel;
    BCBDesde: TBCalendarButton;
    BCBHasta: TBCalendarButton;
    Label4: TLabel;
    Label14: TLabel;
    MEDesde: TBEdit;
    MEHasta: TBEdit;
    CalendarioFlotante: TBCalendario;
    lFechaFactura: TLabel;
    QCuentasVenta: TQuery;
    QCuentasVentaempresa_tsc: TStringField;
    QCuentasVentacentro_tsc: TStringField;
    QCuentasVentaalbaran_tsc: TIntegerField;
    QCuentasVentafecha_tsc: TDateField;
    QCuentasVentamoneda_tsc: TStringField;
    QCuentasVentabruto_tsc: TFloatField;
    QCuentasVentausuario_tsc: TStringField;
    QCuentasVentagastos: TFloatField;
    QCuentasVentakilos_tsc: TFloatField;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;
  private
    function fechas(): string;
    function seleccionar(): string;
    procedure BorrarTablaTempo();
  public
    { Public declarations }
    empresa, centro, producto, factura, fecha_fac: string;

  end;

var
  //FLCuentasVenta: TFLCuentasVenta;
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview,
  CAuxiliarDB, StrUtils, QLCuentasVenta, bSQLUtils,
  UDMBaseDatos, CReportes;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLCuentasVenta.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;
  if CamposVacios then Exit;
  Self.ActiveControl := nil;

  empresa := desEmpresa(EEmpresa.Text);

  seleccionar;

  if QCuentasVenta.IsEmpty then
  begin
    ShowError('No se han encontrado datos para los valores introducidos.');
    EEmpresa.SetFocus;
    Exit;
  end;
  QRLCuentasVentas := TQRLCuentasVentas.Create(Application);
  try
    PonLogoGrupoBonnysa(QRLCuentasVentas, EEmpresa.Text);
    QRLCuentasVentas.IdentificadorLabel.Caption :=
      'CLIENTE: ' + ECliente.Text + ' ' + STCliente.Caption + '                ' +
      'PERIODO: ' + MEDesde.Text + ' hasta ' + MEHasta.Text;
    QRLCuentasVentas.fecha_factura.Enabled := false;
    QRLCuentasVentas.LTitulo.Caption := 'LISTADO DE CUENTAS DE VENTAS';
    QRLCuentasVentas.ReportTitle := 'LISTADO DE CUENTAS DE VENTAS';
    Preview(QRLCuentasVentas);
    QCuentasVenta.Close;
  except
    FreeAndNil( QRLCuentasVentas );
    Application.ProcessMessages;
    QCuentasVenta.Close;
  end;

end;

procedure TFLCuentasVenta.BBCancelarClick(Sender: TObject);
begin

  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLCuentasVenta.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;
  Ecliente.Tag:= kCliente;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  BorrarTablaTempo;

  MEDesde.Text := DateTostr(Date-7);
  MEHasta.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;
  gCF := CalendarioFlotante;

  EEmpresa.Text:= gsDefEmpresa;
  Ecliente.Text:= gsDefCliente;

end;

procedure TFLCuentasVenta.FormActivate(Sender: TObject);
begin
  ActiveControl := EEmpresa;
  gCF := CalendarioFlotante;
end;

procedure TFLCuentasVenta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLCuentasVenta.FormClose(Sender: TObject;
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
  BorrarTablaTempo;
  Action := caFree;
end;

//                     ****  CAMPOS DE EDICION  ****

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLCuentasVenta.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa:
      begin
        DMBaseDatos.QDespegables.Tag := kEmpresa;
        DespliegaRejilla(BGBEmpresa);
      end;
    kCliente:
      DespliegaRejilla(BGBCliente, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else if MEHasta.Focused then
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLCuentasVenta.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kCliente: STCliente.Caption := desCliente(EEmpresa.Text, ECliente.Text);
  end;
end;

function TFLCuentasVenta.CamposVacios: boolean;
begin
        //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if ECliente.Text = '' then
  begin
      ShowError('Es necesario que rellene todos los campos de edición');
      ECliente.SetFocus;
      Result := True;
      Exit;
  end;

  Result := False;
end;

function TFLCuentasVenta.seleccionar(): string;
var WhereSQL, WhereSQL2: string;
begin
  BorrarTablaTempo;
  if Trim(EEmpresa.Text) <> '' then
  begin
    WhereSQL := 'And empresa_sc = ' +
      QuotedStr(EEmpresa.Text) + ' ';
    WhereSQL2 := 'Where empresa_g = ' +
      QuotedStr(EEmpresa.Text) + ' ';
  end;

    if Trim(ECliente.Text) <> '' then
    begin
      WhereSQL := WhereSQL + ' ' +
        'And cliente_fac_sc = ' +
        QuotedStr(ECliente.Text) + ' ';
    end;
    WhereSQL := WhereSQL + fechas;

  with DMBaseDatos.QListado do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('SELECT empresa_sc,centro_salida_sc, ' +
      'n_albaran_sc,fecha_sc,moneda_sc,SUM(importe_total_sl) As bruto ');
          //28-03-2003 añadir kilos a peticion de Roberto
    SQL.Add(',SUM(kilos_sl)as kilos');
    SQL.Add('FROM frf_salidas_c Frf_salidas_c, frf_salidas_l Frf_salidas_l ');
    SQL.Add('WHERE  (empresa_sc = empresa_sl) ' +
      '  And  (centro_salida_sc = centro_salida_sl) ' +
      '  And  (n_albaran_sc = n_albaran_sl) ' +
      '  And  (fecha_sc = fecha_sl) ');
      SQL.Add('  And  (n_factura_sc IS NULL) ');
    SQL.Add(WhereSQL);
    SQL.Add('GROUP BY empresa_sc,centro_salida_sc,n_albaran_sc,fecha_sc,moneda_sc');
    SQL.Add('ORDER BY fecha_sc,n_albaran_sc');
  end;
  try
    DMBaseDatos.QListado.Open;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Exit;
    end;
  end;

  //recogemos la fecha de la factura que ahora es necesaria mostrar en el listado de cuentas de ventas por factura

  while not DMBaseDatos.QListado.Eof do
  begin
    DMBaseDatos.QGeneral.SQL.Clear;
    DMBaseDatos.QGeneral.SQL.Add('INSERT INTO tmp_ventasfactu (' +
      'empresa_tsc,centro_tsc,' +
      'albaran_tsc,fecha_tsc,moneda_tsc,bruto_tsc,' +
      'gastos_tsc,liquido_tsc,usuario_tsc,kilos_tsc) ');
    DMBaseDatos.QGeneral.SQL.Add('VALUES (' +
      QuotedStr(EEmpresa.Text) + ',' +
      QuotedStr(DMBaseDatos.QListado.FieldByName('centro_salida_sc').AsString) + ',' +
      DMBaseDatos.QListado.FieldByName('n_albaran_sc').AsString + ',' +
      SQLDate(DMBaseDatos.QListado.FieldByName('fecha_sc').AsString) + ',' +
      QuotedStr(DMBaseDatos.QListado.FieldByName('moneda_sc').AsString) + ',' +
      StringReplace(DMBaseDatos.QListado.FieldByName('bruto').AsString, ',', '.', [rfReplaceAll, rfIgnoreCase]) + ',0,' +
      StringReplace(DMBaseDatos.QListado.FieldByName('bruto').AsString, ',', '.', [rfReplaceAll, rfIgnoreCase]) + ',' +
      QuotedStr(gsCodigo) + ',' +
      StringReplace(DMBaseDatos.QListado.FieldByName('kilos').AsString, ',', '.', [rfReplaceAll, rfIgnoreCase]) + ')');
    DMBaseDatos.QGeneral.ExecSQL;
    DMBaseDatos.QListado.Next;
  end;
  DMBaseDatos.QListado.Close;
  with QCuentasVenta do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('SELECT empresa_tsc, centro_tsc,albaran_tsc,' +
      'fecha_tsc,moneda_tsc,bruto_tsc,usuario_tsc,');
    SQL.Add(' kilos_tsc,');
    SQL.Add('(Select SUM( CASE ' +
      '               WHEN TIPO.facturable_tg   = "S" THEN ABS(importe_g) ' +
      '               ELSE importe_g ' +
      '            END ) gasto ' +
      'From frf_gastos GAST, frf_tipo_gastos TIPO ' +
      'Where GAST.empresa_g       = VFAC.empresa_tsc ' +
      'And   GAST.centro_salida_g = VFAC.centro_tsc ' +
      'And   GAST.n_albaran_g     = VFAC.albaran_tsc ' +
      'And   GAST.fecha_g         = VFAC.fecha_tsc ' +
      'And   GAST.tipo_g          = TIPO.Tipo_tg ' +
      'And   (TIPO.facturable_tg   = "S" ' +
      '      Or TIPO.cta_venta_tg = "S") ' +
      'Group By empresa_g, centro_salida_g, n_albaran_g, fecha_g' +
      ') As gastos ');
    SQL.Add('FROM tmp_ventasfactu VFAC ');
    SQL.Add('WHERE usuario_tsc =' + QuotedStr(gsCodigo) + ' ');
    SQL.Add('ORDER BY fecha_tsc,albaran_tsc');
  end;
  try
    QCuentasVenta.Open;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Exit;
    end;
  end;

end;

procedure TFLCuentasVenta.BorrarTablaTempo();
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add('DELETE FROM tmp_ventasfactu WHERE usuario_tsc = ' + QuotedStr(gsCodigo) + ' ');
    ExecSQL;
  end;
end;

function TFLCuentasVenta.fechas(): string;
var fec1, fec2: string;
begin
  fechas := '';

  fec1 := Trim(MEDesde.Text);
  fec2 := Trim(MEHasta.Text);

  if ((fec1 <> '') and (fec2 <> '')) then
    fechas := 'And (fecha_sl BETWEEN ' + SQLDate(fec1) +
      ' And ' + SQLDate(fec2) + ') '
  else
  begin
    if ((fec1 <> '') and (fec2 = '')) then
      fechas := 'And (fecha_sl = ' + SQLDate(fec1) + ') '
    else if ((fec1 = '') and (fec2 <> '')) then
      fechas := 'And (fecha_sl = ' + SQLDate(fec2) + ') '

  end;
end;

end.

