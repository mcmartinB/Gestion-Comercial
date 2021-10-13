unit LFDatosCobroCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt, BDEdit, QRCtrls;

type
  TFLDatosCobroCliente = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LCliente: TLabel;
    BGBCliente: TBGridButton;
    STCliente: TStaticText;
    STEmpresa: TStaticText;
    ADesplegarRejilla: TAction;
    edtEmpresa: TBEdit;
    edtCliente: TBEdit;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    GBDatos: TGroupBox;
    edtPais: TBEdit;
    btnPais: TBGridButton;
    stPais: TStaticText;
    lblProvincia: TLabel;
    qryDatosCobro: TQuery;
    grpOrigen: TGroupBox;
    rbTodosPaises: TRadioButton;
    rbNacional: TRadioButton;
    rbExtranjero: TRadioButton;
    rbComunitario: TRadioButton;
    rbExtracomunitario: TRadioButton;
    grpTipo: TGroupBox;
    rbSinFPago: TRadioButton;
    rbConFPago: TRadioButton;
    lblBanco: TLabel;
    edtBanco: TBEdit;
    btnBanco: TBGridButton;
    stBanco: TStaticText;
    grpBancos: TGroupBox;
    rbTodosBancos: TRadioButton;
    rbTodosFPago: TRadioButton;
    rbSinBancos: TRadioButton;
    rbConBancos: TRadioButton;
    lblFPago: TLabel;
    edtFpago: TBEdit;
    btnFPago: TBGridButton;
    stFPago: TStaticText;
    Label1: TLabel;
    edtFecha: TBEdit;
    BCBDesde: TBCalendarButton;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonEmpresa(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtPaisChange(Sender: TObject);
    procedure edtBancoChange(Sender: TObject);
    procedure edtFpagoChange(Sender: TObject);
  private
    {private declarations}
    sEmpresa, sCliente, sPais, sBancos, sFPago : string;
    dFecha: TDateTime;

    function CamposVacios: boolean;
    function ExistenDatos: boolean;
    procedure Imprimir;


  public
    { Public declarations }

  end;


implementation


uses CVariables, UDMAuxDB, Principal, CAuxiliarDB, DPreview, UDMBaseDatos,
  LDatosCobroCliente, bSQLUtils, CReportes, CGlobal, UDMMaster;

{$R *.DFM}

procedure TFLDatosCobroCliente.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCliente.Tag := kCliente;
  edtPais.Tag := kPais;
  edtBanco.Tag := kBanco;
  edtFpago.Tag := kFormaPago;
  edtFecha.Tag := kCalendar;

  edtPais.Text:= '';
  edtCliente.Text := '';
  edtBanco.Text:= '';
  edtFpago.Text:= '';
  if CGlobal.gProgramVersion = CGlobal.pvSAT then
    edtEmpresa.Text := 'SAT'
  else
  //if CGlobal.gProgramVersion = CGlobal.pvBAG then
    edtEmpresa.Text := 'BAG';

  edtPaisChange( edtPais );
  edtBancoChange( edtBanco );
  edtFpagoChange( edtFpago );
  edtFecha.Text := DateToStr( IncMonth( Date, -(5*12) ) );
  CalendarioFlotante.Date := Date;


  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;
end;

procedure TFLDatosCobroCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BorrarTemporal('tmp_gastos_cli');

  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLDatosCobroCliente.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLDatosCobroCliente.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLDatosCobroCliente.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if CamposVacios then
    Exit;

  try
    if ExistenDatos then
    begin
      Imprimir;
    end
    else
    begin
      ShowMessage('Sin datos');
    end;
  finally
    DMAuxDB.QAux.Close;
  end;
end;

procedure TFLDatosCobroCliente.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente: DespliegaRejilla(BGBCliente, [edtEmpresa.Text]);
    kPais: DespliegaRejilla(btnPais, []);
    kBanco: DespliegaRejilla(btnBanco, []);
    kFormaPago: DespliegaRejilla(btnFPago, []);
    kCalendar: DespliegaCalendario(BCBDesde)
  end;
end;

procedure TFLDatosCobroCliente.PonEmpresa(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
  edtClienteChange( edtCliente );
end;

function TFLDatosCobroCliente.CamposVacios: boolean;
begin
  result := True;
  if STEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
  end
  else
  if STCliente.Caption = '' then
  begin
    ShowMessage('Código de cliente incorrecto.');
  end
  else
  if stPais.Caption = '' then
  begin
    ShowMessage('Código de pais incorrecto.');
  end
  else
  if stBanco.Caption = '' then
  begin
    ShowMessage('Código de banco incorrecto.');
  end
  else
  if stFPago.Caption = '' then
  begin
    ShowMessage('Código de forma pago incorrecto.');
  end
  else
  if not TryStrToDate( edtFecha.Text, dFecha ) then
  begin
    ShowMessage('Fecha de referencia incorrecta.');
  end
  else
  begin
    sEmpresa:= Trim( edtEmpresa.Text );
    sCliente:= Trim( edtCliente.Text );
    sPais:= Trim( edtPais.Text );
    sBancos:= Trim( edtBanco.Text );
    sFPago:= Trim( edtFpago.Text );
    Result:= False;
  end;
end;

procedure TFLDatosCobroCliente.Imprimir;
begin

  QRLDatosCobroCliente := TQRLDatosCobroCliente.Create(Application);
  //QRLDatosCobroCliente.qlTitulo.Caption:= QRLDatosCobroCliente.qlTitulo.Caption + ' ' + DateToStr( dFecha );
  QRLDatosCobroCliente.lblCliente.Caption := Trim( edtCliente.Text + ' ' + STCliente.caption );
  if ( edtPais.Text <> '' ) or rbTodosPaises.Checked then
  begin
    QRLDatosCobroCliente.qrlblPais.Caption := Trim( edtPais.Text + ' ' + stPais.caption );
  end
  else
  begin
      if rbNacional.Checked then
      begin
        QRLDatosCobroCliente.qrlblPais.Caption := UpperCase( rbNacional.Caption );
      end
      else
      if rbExtranjero.Checked then
      begin
        QRLDatosCobroCliente.qrlblPais.Caption := UpperCase( rbExtranjero.Caption );
      end
      else
      if rbComunitario.Checked then
      begin
        QRLDatosCobroCliente.qrlblPais.Caption := UpperCase( rbComunitario.Caption );
      end
      else
      if rbExtracomunitario.Checked then
      begin
        QRLDatosCobroCliente.qrlblPais.Caption := UpperCase( rbExtracomunitario.Caption );
      end;
  end;
  if ( edtBanco.Text <> '' ) or rbTodosBancos.Checked then
  begin
    QRLDatosCobroCliente.qrlblBanco.Caption := Trim( edtBanco.Text + ' ' + stBanco.caption );
  end
  else
  begin
      if rbConBancos.Checked then
      begin
        QRLDatosCobroCliente.qrlblBanco.Caption := UpperCase( rbConBancos.Caption );
      end
      else
      if rbSinBancos.Checked then
      begin
        QRLDatosCobroCliente.qrlblBanco.Caption := UpperCase( rbSinBancos.Caption );
      end;
  end;
  if ( edtFpago.Text <> '' ) or rbTodosFPago.Checked then
  begin
    QRLDatosCobroCliente.qrlblFPago.Caption := Trim( edtFpago.Text + ' ' + stFPago.caption );
  end
  else
  begin
      if rbConFPago.Checked then
      begin
        QRLDatosCobroCliente.qrlblFPago.Caption := UpperCase( rbConFPago.Caption );
      end
      else
      if rbSinFPago.Checked then
      begin
        QRLDatosCobroCliente.qrlblFPago.Caption := UpperCase( rbSinFPago.Caption );
      end;
  end;

  PonLogoGrupoBonnysa(QRLDatosCobroCliente, edtEmpresa.text);

  try
    Preview(QRLDatosCobroCliente);
  except
    FreeAndNil(QRLDatosCobroCliente);
    raise;
  end;
end;

//Comprueba si en el periodo seleccionado el cliente ha trabajado con 2 monedas

function TFLDatosCobroCliente.ExistenDatos: boolean;
begin
  with DMBaseDatos.QListado do
  begin
    //Comprobar que existan gastos
    SQl.Clear;

    SQl.Add(' select es_comunitario_c comunitario, ');
    SQl.Add('        pais_c pais, ( select descripcion_p from frf_paises where pais_c = pais_p ) des_pais, ');
    SQl.Add('        moneda_c moneda, ');
    SQl.Add('        banco_ct banco, ( select descripcion_b from frf_bancos where banco_ct = banco_b ) des_banco, ');
    SQl.Add('                        ( select cta_bancaria_b from frf_bancos where banco_ct = banco_b ) cuenta, ');
    SQl.Add('        cliente_c cliente, cta_cliente_c tercero, nombre_c des_cliente, ');
    SQl.Add('        forma_pago_ct forma_pago, ( select descripcion_fp from frf_forma_pago where codigo_fp = forma_pago_ct ) des_forma_pago, ');
    SQl.Add('                      ( select dias_cobro_fp from frf_forma_pago where codigo_fp = forma_pago_ct ) dias_cobro, ');
    SQl.Add('                      ( select forma_pago_adonix_fp from frf_forma_pago where codigo_fp = forma_pago_ct ) tipo_pago, ');
    SQl.Add('        dias_tesoreria_ct dias_tesoreria,  seguro_cr seguro, max_riesgo_cr max_riesgo, fecha_riesgo_cr fecha_riesgo ');
    SQl.Add(' from frf_clientes, outer(frf_clientes_tes), outer(frf_clientes_rie) ');

    SQL.Add(' where 1=1 ');
    if sCliente <> '' then
      SQl.Add(' and cliente_c = :cliente ');
    SQL.Add(' and empresa_ct = :empresa ');
    SQL.Add(' and cliente_ct = cliente_c ');
    SQL.Add(' and empresa_cr = :empresa ');
    SQL.Add(' and cliente_cr = cliente_c ');
    SQL.Add(' and fecha_fin_cr is null ');

    if sPais <> '' then
      SQl.Add(' and pais_c = :pais ')
    else
    begin
      if rbNacional.Checked then
      begin
        SQl.Add(' and pais_c = ''ES'' ')
      end
      else
      if rbExtranjero.Checked then
      begin
        SQl.Add(' and pais_c <> ''ES'' ')
      end
      else
      if rbComunitario.Checked then
      begin
        SQl.Add(' and es_comunitario_c = ''S'' ')
      end
      else
      if rbExtracomunitario.Checked then
      begin
        SQl.Add(' and es_comunitario_c <> ''S'' ')
      end;
    end;

    //Bancos
    if sBancos <> '' then
      SQl.Add(' and banco_ct = :banco ')
    else
    begin
      if rbConBancos.Checked then
         SQl.Add(' and nvl(banco_ct,'''') <> '''' ')
      else
      if rbSinBancos.Checked then
         SQl.Add(' and nvl(banco_ct,'''') = '''' ');
    end;

    //Bancos
    if sFPago <> '' then
      SQl.Add(' and forma_pago_ct = :pago ')
    else
    begin
      if rbConFPago.Checked then
         SQl.Add(' and nvl(forma_pago_ct,'''') <> '''' ')
      else
      if rbSinFPago.Checked then
         SQl.Add(' and nvl(forma_pago_ct,'''') = '''' ');
    end;

    SQl.Add('  and exists ');
    SQl.Add('  ( ');
    SQl.Add('   select * ');
    SQl.Add('   from frf_salidas_c ');
    if  edtEmpresa.Text = 'SAT' then
      SQl.Add(' where ( empresa_sc = ''080'' or empresa_sc = ''050'' ) ')
    else
    if  edtEmpresa.Text = 'BAG' then
      SQl.Add(' where substr(empresa_sc,1,1) = ''F'' ')
    else
      SQl.Add(' where empresa_sc = :empresa');
    SQl.Add('   and cliente_fac_sc = cliente_c ');
    SQl.Add('   and fecha_factura_sc >= :fecha ');
    SQl.Add('  ) ');

    SQl.Add(' group by comunitario, pais, des_pais, moneda, banco, des_banco, ');
    SQl.Add('          cuenta,  cliente, tercero, des_cliente, forma_pago, des_forma_pago, ');
    SQl.Add('          dias_cobro, tipo_pago, dias_tesoreria, seguro, max_riesgo, fecha_riesgo ');

    SQl.Add(' order by 1,2,3,4');


    if  ( edtEmpresa.Text <> 'SAT' ) and ( edtEmpresa.Text <> 'BAG' ) then
      ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('fecha').AsDateTime:= dFecha;
    if sCliente <> '' then
      ParamByName('cliente').AsString:= sCliente;
    if sPais <> '' then
      ParamByName('pais').AsString:= sPais;
    if sBancos <> '' then
      ParamByName('banco').AsString:= sBancos;
    if sFPago <> '' then
      ParamByName('pago').AsString:= sFPago;

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TFLDatosCobroCliente.edtClienteChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if edtCliente.Text = '' then
    STCliente.Caption:= 'TODOS LOS CLIENTES'
  else
    STCliente.Caption := desCliente(edtCliente.Text);
end;

procedure TFLDatosCobroCliente.edtPaisChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if edtPais.Text = '' then
    stPais.Caption:= 'TODOS LOS PAISES'
  else
    stpais.Caption := despais(edtPais.Text);
end;

procedure TFLDatosCobroCliente.edtBancoChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if edtBanco.Text = '' then
    stBanco.Caption:= 'TODOS LOS BANCOS'
  else
    stBanco.Caption := desBanco(edtBanco.Text);
end;

procedure TFLDatosCobroCliente.edtFpagoChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if edtFpago.Text = '' then
    stFPago.Caption:= 'TODOS LAS FORMAS DE PAGO'
  else
    stFPago.Caption := desFormaPago(edtFpago.Text);
end;

end.
