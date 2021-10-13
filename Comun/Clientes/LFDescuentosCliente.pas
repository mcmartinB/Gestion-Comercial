unit LFDescuentosCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt, BDEdit, QRCtrls;

type
  TFLDescuentosCliente = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    LCliente: TLabel;
    BGBCliente: TBGridButton;
    STCliente: TStaticText;
    ADesplegarRejilla: TAction;
    edtCliente: TBEdit;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    GBDatos: TGroupBox;
    Label1: TLabel;
    edtFecha: TBEdit;
    BCBDesde: TBCalendarButton;
    edtPais: TBEdit;
    btnPais: TBGridButton;
    stPais: TStaticText;
    lblProvincia: TLabel;
    qryDescuentos: TQuery;
    grpOrigen: TGroupBox;
    rbTodosPaises: TRadioButton;
    rbNacional: TRadioButton;
    rbExtranjero: TRadioButton;
    rbComunitario: TRadioButton;
    rbExtracomunitario: TRadioButton;
    grpTipo: TGroupBox;
    rbAmbos: TRadioButton;
    rbInclusivo: TRadioButton;
    rbDescuento: TRadioButton;
    rbComision: TRadioButton;
    rbNada: TRadioButton;
    rbTodos: TRadioButton;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtPaisChange(Sender: TObject);
  private
    {private declarations}
    sCliente, sPais: string;
    dFecha: TDateTime;

    function CamposVacios: boolean;
    function ExistenDatos: boolean;
    procedure Imprimir;


  public
    { Public declarations }

  end;


implementation


uses CVariables, UDMAuxDB, Principal, CAuxiliarDB, DPreview, UDMBaseDatos,
  LDescuentosCliente, bSQLUtils, CReportes, CGlobal;

{$R *.DFM}

procedure TFLDescuentosCliente.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtCliente.Tag := kCliente;
  edtPais.Tag := kPais;
  edtFecha.Tag := kCalendar;

  edtPais.Text:= '';
  edtCliente.Text := '';
  edtPaisChange( edtPais );
  edtFecha.Text := DateToStr(Date);
  CalendarioFlotante.Date := Date;


  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

end;

procedure TFLDescuentosCliente.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFLDescuentosCliente.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLDescuentosCliente.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLDescuentosCliente.BBAceptarClick(Sender: TObject);
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

procedure TFLDescuentosCliente.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kCliente: DespliegaRejilla(BGBCliente);
    kPais: DespliegaRejilla(btnPais, []);
    kCalendar: DespliegaCalendario(BCBDesde)
  end;
end;

function TFLDescuentosCliente.CamposVacios: boolean;
begin
  result := True;
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
  if not TryStrToDate( edtFecha.Text, dFecha ) then
  begin
    ShowMessage('Fecha de referencia incorrecta.');
  end
  else
  begin
    sCliente:= Trim( edtCliente.Text );
    sPais:= Trim( edtPais.Text );
    Result:= False;
  end;
end;

procedure TFLDescuentosCliente.Imprimir;
begin

  QRLDescuentosCliente := TQRLDescuentosCliente.Create(Application);
  QRLDescuentosCliente.qlTitulo.Caption:= QRLDescuentosCliente.qlTitulo.Caption + ' ' + DateToStr( dFecha );
  QRLDescuentosCliente.lblCliente.Caption := edtCliente.Text + ' ' + STCliente.caption;
  if ( edtPais.Text <> '' ) or rbTodosPaises.Checked then
  begin
    QRLDescuentosCliente.qrlblPais.Caption := stPais.caption;
  end
  else
  begin
      if rbNacional.Checked then
      begin
        QRLDescuentosCliente.qrlblPais.Caption := UpperCase( rbNacional.Caption );
      end
      else
      if rbExtranjero.Checked then
      begin
        QRLDescuentosCliente.qrlblPais.Caption := UpperCase( rbExtranjero.Caption );
      end
      else
      if rbComunitario.Checked then
      begin
        QRLDescuentosCliente.qrlblPais.Caption := UpperCase( rbComunitario.Caption );
      end
      else
      if rbExtracomunitario.Checked then
      begin
        QRLDescuentosCliente.qrlblPais.Caption := UpperCase( rbExtracomunitario.Caption );
      end;
  end;

  if rbTodos.Checked then
  begin
    QRLDescuentosCliente.qrlblTipo.Caption := UpperCase( rbTodos.Caption );
  end
  else
  if rbAmbos.Checked then
  begin
    QRLDescuentosCliente.qrlblTipo.Caption := UpperCase( rbAmbos.Caption );
  end
  else
  if rbInclusivo.Checked then
  begin
    QRLDescuentosCliente.qrlblTipo.Caption := UpperCase( rbInclusivo.Caption );
  end
  else
  if rbDescuento.Checked then
  begin
    QRLDescuentosCliente.qrlblTipo.Caption := UpperCase( rbDescuento.Caption );
  end
  else
  if rbComision.Checked then
  begin
    QRLDescuentosCliente.qrlblTipo.Caption := UpperCase( rbComision.Caption );
  end
  else
  if rbNada.Checked then
  begin
    QRLDescuentosCliente.qrlblTipo.Caption := UpperCase( rbNada.Caption );
  end;

  PonLogoGrupoBonnysa(QRLDescuentosCliente, gsDefEmpresa);

  try
    Preview(QRLDescuentosCliente);
  except
    FreeAndNil(QRLDescuentosCliente);
    raise;
  end;
end;

//Comprueba si en el periodo seleccionado el cliente ha trabajado con 2 monedas

function TFLDescuentosCliente.ExistenDatos: boolean;
begin
  with DMBaseDatos.QListado do
  begin
    //Comprobar que existan gastos
    SQl.Clear;
    SQl.Add('  select cliente_c cod_cliente, nombre_c cliente, ');
    SQl.Add('  empresa_dc, facturable_dc facturable, no_fact_bruto_dc+no_fact_neto_dc descuento, ');

    SQl.Add('  ( select comision_rc from frf_representantes_comision ');
    SQl.Add('  where representante_c = representante_rc           ');
    SQl.Add('    and :fecha between  fecha_ini_rc and nvl(fecha_fin_rc,Today) ');
    SQl.Add('  ) comision,                                                    ');
    SQl.Add('  representante_c cod_representante,                             ');
    SQl.Add('  ( select descripcion_r from frf_representantes                 ');
    SQl.Add('     where representante_c = representante_r                     ');
    SQl.Add('  ) representante                                                ');

    SQl.Add('    from frf_clientes, outer(frf_descuentos_cliente)             ');
    SQl.Add('   where cliente_dc = cliente_c                                  ');
    SQl.Add('     and :fecha between  fecha_ini_dc and nvl(fecha_fin_dc,Today)');

    if sCliente <> '' then
      SQl.Add(' and cliente_c = :cliente ');

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
        SQl.Add(' and es_comunitario_c = ''S'' and pais_c <> ''ES'' ')
      end
      else
      if rbExtracomunitario.Checked then
      begin
        SQl.Add(' and es_comunitario_c <> ''S'' ')
      end;
    end;

    if not rbTodos.Checked then
    begin
      if rbAmbos.Checked then
      begin
        SQl.Add(' and ( ');
        SQl.Add('      ( ( select facturable_dc + no_fact_bruto_dc + no_fact_neto_dc  from frf_descuentos_cliente ');
        SQl.Add('         where cliente_c = cliente_dc ');
        SQL.Add('           and empresa_dc = :empresa  ');
        SQl.Add('           and :fecha between  fecha_ini_dc and nvl(fecha_fin_dc,Today) ');
        SQl.Add('      ) <> 0 ) ');

        SQl.Add('     or ');
        SQl.Add('      ( ( select comision_rc from frf_representantes_comision ');
        SQl.Add('        where representante_c = representante_rc ');
        SQl.Add('          and :fecha between  fecha_ini_rc and nvl(fecha_fin_rc,Today) ');
        SQl.Add('      ) <> 0 ) ');
        SQl.Add('     ) ');
      end
      else
      if rbInclusivo.Checked then
      begin
        SQl.Add(' and  ');
        SQl.Add('      ( ( select facturable_dc + no_fact_bruto_dc + no_fact_neto_dc  from frf_descuentos_cliente ');
        SQl.Add('         where cliente_c = cliente_dc ');
        SQl.Add('           and :fecha between  fecha_ini_dc and nvl(fecha_fin_dc,Today) ');
        SQl.Add('      ) <> 0 ) ');

        SQl.Add(' and ');
        SQl.Add('      ( ( select comision_rc from frf_representantes_comision ');
        SQl.Add('        where representante_c = representante_rc ');
        SQl.Add('          and :fecha between  fecha_ini_rc and nvl(fecha_fin_rc,Today) ');
        SQl.Add('      ) <> 0 ) ');
      end
      else
      if rbDescuento.Checked then
      begin
        SQl.Add(' and  ');
        SQl.Add('      ( ( select facturable_dc + no_fact_bruto_dc + no_fact_neto_dc  from frf_descuentos_cliente ');
        SQl.Add('         where cliente_c = cliente_dc ');
        SQl.Add('           and :fecha between  fecha_ini_dc and nvl(fecha_fin_dc,Today) ');
        SQl.Add('      ) <> 0 ) ');
      end
      else
      if rbComision.Checked then
      begin
        SQl.Add(' and  ');
        SQl.Add('      ( ( select comision_rc from frf_representantes_comision ');
        SQl.Add('        where representante_c = representante_rc ');
        SQl.Add('          and :fecha between  fecha_ini_rc and nvl(fecha_fin_rc,Today) ');
        SQl.Add('      ) <> 0 ) ');
      end
      else
      if rbNada.Checked then
      begin
        SQl.Add(' and not ( ');
        SQl.Add('      ( nvl( ( select facturable_dc + no_fact_bruto_dc + no_fact_neto_dc  from frf_descuentos_cliente ');
        SQl.Add('         where cliente_c = cliente_dc ');
        SQl.Add('           and :fecha between  fecha_ini_dc and nvl(fecha_fin_dc,Today) ');
        SQl.Add('      ), 0 ) <> 0 ) ');

        SQl.Add('     or ');
        SQl.Add('      ( nvl( ( select comision_rc from frf_representantes_comision ');
        SQl.Add('        where representante_c = representante_rc ');
        SQl.Add('          and :fecha between  fecha_ini_rc and nvl(fecha_fin_rc,Today) ');
        SQl.Add('      ), 0 ) <> 0 ) ');
        SQl.Add('     ) ');
      end;
    end;

    SQl.Add(' order by cliente_c, empresa_dc  ');

    ParamByName('empresa').AsString := gsDefEmpresa;
    
    if dFecha > Date then
      dFecha:= Date;
    ParamByName('fecha').AsDate:= dFecha;
    if sCliente <> '' then
      ParamByName('cliente').AsString:= sCliente;
    if sPais <> '' then
      ParamByName('pais').AsString:= sPais;

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TFLDescuentosCliente.edtClienteChange(Sender: TObject);
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

procedure TFLDescuentosCliente.edtPaisChange(Sender: TObject);
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

end.
