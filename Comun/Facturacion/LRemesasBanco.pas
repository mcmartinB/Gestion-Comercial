unit LRemesasBanco;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Buttons, Db, DbTables, ActnList,
  ComCtrls, BGridButton, BEdit, DError, Dialogs, BSpeedButton,
  BCalendarButton, BCalendario;

type
  TFLRemesasBanco = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    LEmpresa: TLabel;
    LMoneda: TLabel;
    LCentro: TLabel;
    eMoneda: TBEdit;
    eEmpresa: TBEdit;
    eBanco: TBEdit;
    STEmpresa: TStaticText;
    Label1: TLabel;
    eDFecha: TBEdit;
    stBanco: TStaticText;
    eHFecha: TBEdit;
    stMoneda: TStaticText;
    GroupBox1: TGroupBox;
    cTotales: TRadioButton;
    cDetalle: TRadioButton;
    bHFecha: TBCalendarButton;
    bDFecha: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    ADesplegarCalendario: TAction;
    Label2: TLabel;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);
    procedure ADesplegarCalendarioExecute(Sender: TObject);
    procedure eBancoChange(Sender: TObject);
    procedure eMonedaChange(Sender: TObject);

  private
    procedure ListadoDetalles;
    procedure ListadoTotal;

  end;

implementation

uses UDMAuxDB, CVariables, Principal, CGestionPrincipal, CGlobal,
  UDMBaseDatos, CAuxiliarDB, QLRemesasBancoDetalle,
  QLRemesasBancoTotal, DPreview, CReportes, UDMConfig;

{$R *.DFM}

procedure TFLRemesasBanco.BBCancelarClick(Sender: TObject);
begin
  if CalendarioFlotante.Visible then Exit;
  if CerrarForm(false) then Close;
end;

procedure TFLRemesasBanco.BBAceptarClick(Sender: TObject);
var
  dIni, dFin: TDateTime;
begin
  if not CerrarForm(true) then Exit;

     //Comprobar si los campos se han rellenado
  if stEmpresa.Caption = '' then
  begin
    ShowError('Es necesario que rellene el código de la empresa.');
    EEmpresa.SetFocus;
    Exit;
  end;
  if stBanco.Caption = '' then
  begin
    ShowError('Código de banco incorrecto.');
    eBanco.SetFocus;
    Exit;
  end;
  if stMoneda.Caption = '' then
  begin
    ShowError('Código de moneda incorrecto.');
    eMoneda.SetFocus;
    Exit;
  end;

  if not TryStrToDate( eDFecha.Text, dIni ) then
  begin
    ShowError('Fecha de inicio incorrecta.');
    eDFecha.SetFocus;
    Exit;
  end;
  if not TryStrToDate( eHFecha.Text, dFin ) then
  begin
    ShowError('Fecha de fin incorrecta.');
    eHFecha.SetFocus;
    Exit;
  end;
  if dFin < dIni then
  begin
    ShowError('Rango de fechas incorrecto.');
    eDFecha.SetFocus;
    Exit;
  end;

  //QUe informe hemnos seleccionado
  if cTotales.Checked then
    ListadoTotal
  else
    ListadoDetalles;
end;


procedure TFLRemesasBanco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gRF := nil;

  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLRemesasBanco.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  eEmpresa.Tag := kEmpresa;
  eBanco.Tag := kBanco;
  eMoneda.Tag := kMoneda;

  if CGlobal.gProgramVersion = pvBAG then
    eEmpresa.Text :='BAG'
  else
    eEmpresa.Text :='SAT';

  eBanco.Text := '';
  eMoneda.Text := '';
  eDFecha.Text := DateToStr(Date - 6);
  eHFecha.Text := DateToStr(Date);
  eDFecha.Tag := kCalendar;
  eHFecha.Tag := kCalendar;
end;

procedure TFLRemesasBanco.PonNombre(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
end;

procedure TFLRemesasBanco.FormKeyDown(Sender: TObject;
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

procedure TFLRemesasBanco.ListadoDetalles;
begin
  with DMBaseDatos.QListado do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    Sql.Clear;
    Sql.Add(' select cod_banco_rc banco_r,descripcion_b, ');
    Sql.Add('        fecha_vencimiento_rc fecha_r, ');
    Sql.Add('        n_remesa_rc referencia_r, ');
    Sql.Add('        importe_cobro_rc importe_cobro_r, ');
    Sql.Add('        moneda_cobro_rc moneda_cobro_r, ');
    Sql.Add('        bruto_euros_rc bruto_euros_r, ');
    Sql.Add('        gastos_euros_rc gastos_euros_r, ');
    Sql.Add('        liquido_euros_rc liquido_euros_r, ');
    Sql.Add('        notas_rc descripcion_b, ');
    Sql.Add('        case when bruto_euros_rc <> 0 then ROUND(importe_cobro_rc/bruto_euros_rc,3) ');
    Sql.Add('              else 0 end as cambio_r ');

    Sql.Add(' from tremesas_cab ');
    Sql.Add('      join frf_bancos on cod_banco_rc = banco_b ');

    Sql.Add(' where  empresa_remesa_rc = :empresa ');
    Sql.Add('   and  fecha_vencimiento_rc between :dFecha and :hFecha ');

    if Trim( eMoneda.Text ) <> '' then
      Sql.Add('  and  moneda_cobro_rc = :Moneda ');
    if Trim( eBanco.Text ) <> '' then
      Sql.Add('  and  cod_banco_rc = :Banco ');

    Sql.Add('  Order by banco_r,fecha_r,referencia_r ');

    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('dFecha').AsDateTime := StrToDate(eDFecha.Text);
    ParamByName('hFecha').AsDateTime := StrToDate(eHFecha.Text);
    if Trim( eMoneda.Text ) <> '' then
      ParamByName('Moneda').AsString := eMoneda.Text;
    if Trim( eBanco.Text ) <> '' then
      ParamByName('Banco').AsString := eBanco.Text;

    try
      Open;
    except
      on e: EDBEngineError do
      begin
        ShowError(e);
      end
    else
      begin
        ShowError('Problemas al intentar seleccionar la información necesaria.');
        Exit;
      end;
    end;

    First;
    try
      QRLRemesasBancoDetalle := TQRLRemesasBancoDetalle.Create(Application);
      PonLogoGrupoBonnysa(QRLRemesasBancoDetalle, EEmpresa.Text);
      soloUnaMoneda := Trim(eMoneda.Text) <> '';
      QRLRemesasBancoDetalle.lPeriodo.Caption := 'Desde ' + eDFecha.Text + ' hasta ' + eHFecha.Text;
      Preview(QRLRemesasBancoDetalle);
    finally
      Cancel;
      Close;
    end;
  end;
end;

procedure TFLRemesasBanco.ListadoTotal;
begin
  with DMBaseDatos.QListado do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    Sql.Clear;
    Sql.Add(' select cod_banco_rc banco_r,descripcion_b, ');
    Sql.Add('        SUM(bruto_euros_rc) as bruto, ');
    Sql.Add('        SUM(gastos_euros_rc) as gasto, ');
    Sql.Add('        SUM(liquido_euros_rc) as liquido ');

    Sql.Add(' from tremesas_cab ');
    Sql.Add('      join frf_bancos on cod_banco_rc = banco_b ');

    Sql.Add(' where  empresa_remesa_rc = :empresa ');
    Sql.Add('   and  fecha_vencimiento_rc between :dFecha and :hFecha ');

    if Trim( eMoneda.Text ) <> '' then
      Sql.Add('  and  moneda_cobro_rc = :Moneda ');
    if Trim( eBanco.Text ) <> '' then
      Sql.Add('  and  cod_banco_rc = :Banco ');

    Sql.Add(' group by banco_r,descripcion_b ');
    Sql.Add(' Order by banco_r ');


    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('dFecha').AsDateTime := StrToDate(eDFecha.Text);
    ParamByName('hFecha').AsDateTime := StrToDate(eHFecha.Text);
    if Trim( eMoneda.Text ) <> '' then
      ParamByName('Moneda').AsString := eMoneda.Text;
    if Trim( eBanco.Text ) <> '' then
      ParamByName('Banco').AsString := eBanco.Text;
    try
      Open;
    except
      on e: EDBEngineError do
      begin
        ShowError(e);
      end
    else
      begin
        ShowError('Problemas al intentar seleccionar la información necesaria.');
        Exit;
      end;
    end;
    First;
  end;

  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;

    Sql.Clear;
    Sql.Add(' select ');
    Sql.Add('        moneda_cobro_rc moneda_cobro_r,descripcion_m, ');
    Sql.Add('        SUM(importe_cobro_rc) as importe, ');
    Sql.Add('        SUM(bruto_euros_rc) as bruto, ');
    Sql.Add('        case when SUM(importe_cobro_rc) <> 0 ');
    Sql.Add('             then ROUND(SUM(importe_cobro_rc)/SUM(bruto_euros_rc),3) ');
    Sql.Add('             else 0 end cambio ');

    Sql.Add(' from tremesas_cab ');
    Sql.Add('      join frf_monedas on moneda_cobro_rc = moneda_m ');

    Sql.Add(' where  empresa_remesa_rc = :empresa ');
    Sql.Add('   and  fecha_vencimiento_rc between :dFecha and :hFecha ');

    if Trim( eMoneda.Text ) <> '' then
      Sql.Add('  and  moneda_cobro_rc = :Moneda ');
    if Trim( eBanco.Text ) <> '' then
      Sql.Add('  and  cod_banco_rc = :Banco ');

    Sql.Add(' group by moneda_cobro_r,descripcion_m ');
    Sql.Add(' Order by moneda_cobro_r ');

    ParamByName('empresa').AsString := eEmpresa.Text;
    ParamByName('dFecha').AsDateTime := StrToDate(eDFecha.Text);
    ParamByName('hFecha').AsDateTime := StrToDate(eHFecha.Text);
    if Trim( eMoneda.Text ) <> '' then
      ParamByName('Moneda').AsString := eMoneda.Text;
    if Trim( eBanco.Text ) <> '' then
      ParamByName('Banco').AsString := eBanco.Text;
    try
      Open;
    except
      on e: EDBEngineError do
      begin
        ShowError(e);
      end
    else
      begin
        ShowError('Problemas al intentar seleccionar la información necesaria.');
        Exit;
      end;
    end;
    First;
  end;

  try
    QRLRemesasBancoTotal := TQRLRemesasBancoTotal.Create(Application);
    PonLogoGrupoBonnysa(QRLRemesasBancoTotal, EEmpresa.Text);
    QRLRemesasBancoTotal.lPeriodo.Caption := 'Desde ' + eDFecha.Text + ' hasta ' + eHFecha.Text;
    Preview(QRLRemesasBancoTotal);
  finally
    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;
  end;
end;

procedure TFLRemesasBanco.ADesplegarCalendarioExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCalendar:
      begin
        if eDFecha.Focused then
          DespliegaCalendario(bDFecha)
        else
          DespliegaCalendario(bHFecha);
      end;
  end;
end;

procedure TFLRemesasBanco.eBancoChange(Sender: TObject);
begin
  if eBanco.Text = '' then
  begin
    stBanco.Caption:= 'Vacio = Todos los bancos';
  end
  else
  begin
    stBanco.Caption:= desBanco( eBanco.Text );
  end;
end;

procedure TFLRemesasBanco.eMonedaChange(Sender: TObject);
begin
  if eBanco.Text = '' then
  begin
    stMoneda.Caption:= 'Vacio = Todas las monedas';
  end
  else
  begin
    stMoneda.Caption:= desMoneda( eMoneda.Text );
  end;
end;

end.
