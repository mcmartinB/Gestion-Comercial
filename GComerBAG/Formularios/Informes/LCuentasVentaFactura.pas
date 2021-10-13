unit LCuentasVentaFactura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables;

type
  TFLCuentasVentaFactura = class(TForm)
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
    CalendarioFlotante: TBCalendario;
    Desde: TLabel;
    EDesdeFecha: TBEdit;
    BCBDesde: TBCalendarButton;
    EHastaFecha: TBEdit;
    BCBHasta: TBCalendarButton;
    Label2: TLabel;
    EDesdeFactura: TBEdit;
    Label3: TLabel;
    EHastaFactura: TBEdit;
    Label5: TLabel;
    Label4: TLabel;
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
    procedure EHastaFacturaEnter(Sender: TObject);
    procedure EHastaFechaEnter(Sender: TObject);
  private
    function seleccionar: boolean;
    procedure Deseleccionar;

    procedure Imprimir;
  public
    { Public declarations }
  end;

var
  //FLCuentasVenta: TFLCuentasVenta;
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, DPreview, CReportes,
  CAuxiliarDB, StrUtils, LCuentasVentaFacturaQR, UDMBaseDatos, bSQLUtils;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLCuentasVentaFactura.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;
  if CamposVacios then Exit;

  if not Seleccionar then Exit;

  try
    Imprimir;
  finally
    Deseleccionar;
  end;
end;

procedure TFLCuentasVentaFactura.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLCuentasVentaFactura.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  ECliente.Tag := kCliente;
  EDesdeFecha.Tag := kCalendar;
  EHastaFecha.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

  EDesdeFecha.Text := DateTostr(Date-7);
  EHastaFecha.Text := DateTostr(Date-1);
  CalendarioFlotante.Date := Date;
  gCF := CalendarioFlotante;

  EEmpresa.Text := gsDefEmpresa;
  ECliente.Text := gsDefCliente;
  EDesdeFactura.Text := '1';
  EHastaFactura.Text := '999999';

end;

procedure TFLCuentasVentaFactura.FormActivate(Sender: TObject);
begin
  ActiveControl := EEmpresa;
  gCF := CalendarioFlotante;
end;

procedure TFLCuentasVentaFactura.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLCuentasVentaFactura.FormClose(Sender: TObject;
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

//                      ****  FUNCIONES ESPECIFICAS  ****

procedure TFLCuentasVentaFactura.ADesplegarRejillaExecute(Sender: TObject);
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
        if EDesdeFecha.Focused then
          DespliegaCalendario(BCBDesde)
        else if EHastaFecha.Focused then
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLCuentasVentaFactura.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(Eempresa.Text);
    kCliente: STCliente.Caption := desCliente(ECliente.Text);
  end;
end;

function TFLCuentasVentaFactura.CamposVacios: boolean;
begin
  Result := True;
  //Comprobamos que los campos esten todos con datos
  if EEmpresa.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EEmpresa.SetFocus;

    Exit;
  end;

  if ECliente.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    ECliente.SetFocus;
    Exit;
  end;

  if EDesdeFactura.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EDesdeFactura.SetFocus;
    Exit;
  end;

  if EHastaFactura.Text = '' then
  begin
    ShowError('Es necesario que rellene todos los campos de edición');
    EHastaFactura.SetFocus;
    Exit;
  end;

  try
    StrToDate(EDesdeFecha.Text);
  except
    ShowError('Es necesario que rellene todos los campos de edición');
    EDesdeFecha.SetFocus;
    Exit;
  end;

  try
    StrToDate(EHastaFecha.Text);
  except
    ShowError('Es necesario que rellene todos los campos de edición');
    EHastaFecha.SetFocus;
    Exit;
  end;

  if StrToDate(EDesdeFecha.Text) > StrToDate(EHastaFecha.Text) then
  begin
    ShowError('Rango de fechas incorrecto.');
    EDesdeFecha.SetFocus;
    Exit;
  end;

  Result := False;
end;

function TFLCuentasVentaFactura.seleccionar: Boolean;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select n_factura_sc factura, fecha_factura_sc fechaFactura, ');
    SQL.Add('        n_albaran_sl albaran, fecha_sl fecha, centro_salida_sl centro, ');
    SQL.Add('        moneda_sc moneda, sum(importe_neto_sl) importe ');
    SQL.Add(' from frf_salidas_l, frf_salidas_c ');
    SQL.Add(' where empresa_sc = ' + SQLString(EEmpresa.Text));
    SQL.Add('   and cliente_fac_sc = ' + SQLString(ECliente.Text));
    SQL.Add('   and n_factura_sc between ' + SQLNumeric(EDesdeFactura.Text));
    SQL.Add('                    and ' + SQLNumeric(EHastaFactura.Text));
    SQL.Add('   and fecha_factura_sc between ' + SQLDate(EDesdeFecha.Text));
    SQL.Add('                    and ' + SQLDate(EHastaFecha.Text));
    SQL.Add('   and empresa_sl = empresa_sc ');
    SQL.Add('   and centro_salida_sl = centro_salida_sc ');
    SQL.Add('   and fecha_sl = fecha_sc ');
    SQL.Add('   and n_albaran_sl = n_albaran_sc ');
    SQL.Add(' group by n_factura_sc, fecha_factura_sc, n_albaran_sl, fecha_sl, ');
    SQL.Add('          centro_salida_sl, moneda_sc ');
    SQL.Add(' into temp tmpAlbaranes; ');
    ExecSQL;

    result := RowsAffected <> -1;

    if not result then
    begin
      SQL.Clear;
      SQL.Add('drop table tmpAlbaranes; ');
      ExecSQL;
    end;

    SQL.Clear;
    SQL.Add(' select n_albaran_sc albaran, fecha_sc fecha, centro_salida_sc centro, ');
    SQL.Add('        sum(importe_g) importe ');
    SQL.Add(' from frf_salidas_c, frf_gastos, frf_tipo_gastos ');

    SQL.Add(' where empresa_sc = ' + SQLString(EEmpresa.Text));
    SQL.Add('   and cliente_fac_sc = ' + SQLString(ECliente.Text));
    SQL.Add('   and n_factura_sc between ' + SQLNumeric(EDesdeFactura.Text));
    SQL.Add('                    and ' + SQLNumeric(EHastaFactura.Text));
    SQL.Add('   and fecha_factura_sc between ' + SQLDate(EDesdeFecha.Text));
    SQL.Add('                    and ' + SQLDate(EHastaFecha.Text));

    SQL.Add(' and empresa_sc = empresa_g ');
    SQL.Add(' and centro_salida_sc = centro_salida_g ');
    SQL.Add(' and fecha_sc = fecha_g ');
    SQL.Add(' and n_albaran_sc = n_albaran_g ');

    SQL.Add(' and tipo_g = tipo_tg ');
    SQL.Add(' and cta_venta_tg = ' + SQLString('S'));

    SQL.Add(' group by n_albaran_sc, fecha_sc, centro_salida_sc ');
    SQL.Add(' into temp tmpGastos; ');
    ExecSQL;
  end;

  with DMBaseDatos.QListado do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(' select a.factura, a.fechaFactura, ');
    SQL.Add('        a.albaran, a.fecha, a.importe, g.importe gastos, ');
    SQL.Add('        a.importe - g.importe neto, a.moneda ');
    SQL.Add(' from tmpAlbaranes a left outer join tmpGastos g ');
    SQL.Add('      on a.albaran = g.albaran and a.fecha = g.fecha and ');
    SQL.Add('         a.centro = g.centro ');
    SQL.Add(' order by a.fechaFactura, a.factura, a.fecha, a.albaran;');
    Open;
  end;
end;

procedure TFLCuentasVentaFactura.Deseleccionar;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('drop table tmpAlbaranes; ');
    ExecSQL;
    SQL.Clear;
    SQL.Add('drop table tmpGastos; ');
    ExecSQL;
  end;
  DMBaseDatos.QListado.Close;
end;

procedure TFLCuentasVentaFactura.EHastaFacturaEnter(Sender: TObject);
begin
  if EHastaFactura.Text = '' then
  begin
    EHastaFactura.Text := EDesdeFactura.Text;
    EHastaFactura.SelectAll;
  end;
end;

procedure TFLCuentasVentaFactura.EHastaFechaEnter(Sender: TObject);
begin
  if EHastaFecha.Text = DateToStr(Date) then
    EHastaFecha.Text := EDesdeFecha.Text;
end;

procedure TFLCuentasVentaFactura.Imprimir;
var
  listado: TQLCuentasVentaFacturaQR;
begin
  listado := TQLCuentasVentaFacturaQR.Create(Self);
  try
    DMBaseDatos.QListado.First;
    PonLogoGrupoBonnysa(Listado, EEmpresa.Text);
    Preview(listado);
  except
    listado.Free;
  end;
end;

end.
