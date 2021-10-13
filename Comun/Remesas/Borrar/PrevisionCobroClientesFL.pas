unit PrevisionCobroClientesFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DBTables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, ExtCtrls;

type
  TFLPrevisionCobroClientes = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    QEstadoCobros: TQuery;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    cbbMercado: TComboBox;
    cbbEstadoCobro: TComboBox;
    lblNombre1: TLabel;
    eFechaCobro: TBEdit;
    btnFechaCobro: TBCalendarButton;
    lblNombre2: TLabel;
    eFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lblNombre3: TLabel;
    eFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    lblNombre4: TLabel;
    edtDias: TBEdit;
    lbl1: TLabel;
    edtPais: TBEdit;
    BGBPais1: TBGridButton;
    txtPais: TStaticText;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lblMoneda: TLabel;
    cbbMoneda: TComboBox;
    lbl6: TLabel;
    lbl7: TLabel;
    Label3: TLabel;
    eCliente: TBEdit;
    BGridButton1: TBGridButton;
    stCliente: TStaticText;
    chkExcluir: TCheckBox;
    btnLimpiar: TButton;
    txtListaCliente: TStaticText;
    btn1: TButton;
    lblAnyadir: TLabel;
    lblTipoCliente: TLabel;
    edtTipoCliente: TBEdit;
    btnTipoCliente: TBGridButton;
    txtTipoCliente: TStaticText;
    chkTipoCliente: TCheckBox;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbbEstadoCobroChange(Sender: TObject);


  private
     {Private declarations}
    function  ParametrosOK: boolean;
    procedure AbrirQuery;

  public
    { Public declarations }
  end;

implementation


uses UDMAuxDB, Principal, CVariables, CReportes, UDMConfig, CGlobal,
  CAuxiliarDB, DPreview, UDMBaseDatos, EstadoCobroClienteDM;
  (*ExtractoCobroQL, *)

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLPrevisionCobroClientes.BBAceptarClick(Sender: TObject);
begin
  if CerrarForm(true) then
  begin
    Self.ActiveControl := nil;
    if ParametrosOK then
    begin
      DMEstadoCobroCliente.PendienteCobro( now, now+30);
    end;
  end;
  Exit;

  
  AbrirQuery;
  if QEstadoCobros.IsEmpty then
  begin
    QEstadoCobros.Close;
    ShowError('Listado sin datos ...');
    Exit;
  end;

    //Llamamos al QReport
  (*
  QLExtractoCobro := TQLExtractoCobro.Create(Self);
  PonLogoGrupoBonnysa(QLExtractoCobro, EEmpresa.Text);
  QLExtractoCobro.bPasarAEuros:= cbbMoneda.ItemIndex = 0;

  QLExtractoCobro.lblPeriodo.Caption := 'Del ' + eFechaDesde.text + ' al ' + eFechaHasta.Text;
  if eFechaCobro.Text <> '' then
    QLExtractoCobro.lblFechaCobro.Caption := 'Fecha cobro ' + eFechaCobro.Text
  else
    QLExtractoCobro.lblFechaCobro.Caption := '';

  Preview(QLExtractoCobro);
  *)
  QEstadoCobros.Close;
end;

procedure TFLPrevisionCobroClientes.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLPrevisionCobroClientes.FormCreate(Sender: TObject);
(*
var
  iDia, iMes, iAnyo: word;
  dFecha: TDate;
*)
begin
  FormType := tfOther;
  BHFormulario;
  (*
  DecodeDate( Date, iAnyo, iMes, iDia );
  dFecha:= EncodeDate( iAnyo, 1, 1 );
  if Date - dFecha < 30 then
    dFecha:= EncodeDate( iAnyo-1, 12, 1 );
  MEDesde.Text := DateTostr(dFecha);
  *)

  eFechaCobro.Text := '';
  eFechaHasta.Text := DateTostr(Date);
  eFechaDesde.Text := DateTostr(Date-365);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  edtCliente.Tag := kCliente;
  edtPais.Tag := kPais;
  eFechaCobro.Tag := kCalendar;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  cbbMercado.ItemIndex := 0;
  cbbEstadoCobro.ItemIndex := 0;
  cbbMoneda.ItemIndex := 0;

  //EEmpresa.Text:= gsDefEmpresa;
  if gProgramVersion = pvBAG then
    EEmpresa.Text:= 'BAG'
  else
    EEmpresa.Text:= 'SAT';
  PonNombre( edtPais );

  DMEstadoCobroCliente:= TDMEstadoCobroCliente.Create( self );
end;

procedure TFLPrevisionCobroClientes.FormActivate(Sender: TObject);
begin
  ActiveControl := EEmpresa;
end;

procedure TFLPrevisionCobroClientes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLPrevisionCobroClientes.FormClose(Sender: TObject;
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
  FreeAndNil( DMEstadoCobroCliente );
  Action := caFree;
end;

//                     ****  CAMPOS DE EDICION  ****

procedure TFLPrevisionCobroClientes.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente:
      begin
        DespliegaRejilla(btnCliente, [EEmpresa.Text]);
      end;
    kPais:
      begin
        DespliegaRejilla(BGBPais1);
      end;
    kCalendar:
      begin
        if eFechaCobro.Focused then
          DespliegaCalendario(btnFechaCobro)
        else
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
        if eFechaHasta.Focused then
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLPrevisionCobroClientes.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        STEmpresa.Caption := desEmpresa(Eempresa.Text);
        PonNombre( edtCliente );
      end;
    kCliente:
      begin
        if edtCliente.Text = '' then
          txtCliente.Caption := 'TODOS LOS CLIENTES'
        else
        begin
          txtCliente.Caption := desCliente(Eempresa.Text, edtCliente.Text);
          if txtCliente.Caption <> '' then
          begin
            edtPais.Text:= '';
            cbbMercado.ItemIndex:= 0;
          end;
        end;
      end;
    kPais:
      begin
        if edtPais.Text = '' then
          txtPais.Caption := 'TODOS LOS PAISES'
        else
        begin
          txtPais.Caption := desPais(edtPais.Text);
          if txtPais.Caption <> '' then
          begin
            cbbMercado.ItemIndex:= 0;
          end;
        end;
      end;
  end;
end;

function TFLPrevisionCobroClientes.ParametrosOK: boolean;
var
  dDesde, dHasta: TDateTime;
begin
  ParametrosOK:= True;
  Exit;
  
        //Comprobamos que los campos esten todos con datos
  if STEmpresa.Caption = '' then
  begin
    ShowError('Falta el codigo de la planta o es incorrecto.');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if eFechaCobro.Text <> '' then
  if not TryStrToDate(eFechaCobro.Text, dHasta )then
  begin
    ShowError('Fecha de cobro incorrecta.');
    eFechaCobro.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDate(eFechaDesde.Text, dDesde )then
  begin
    ShowError('Falta fecha de inicio o es incorrecta.');
    eFechaDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDate(eFechaHasta.Text, dHasta )then
  begin
    ShowError('Falta fecha de fin o es incorrecta.');
    eFechaHasta.SetFocus;
    Result := True;
    Exit;
  end;

  if dDesde > dHasta then
  begin
    ShowError('Rango de fechas incorrecto.');
    eFechaDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if txtCliente.Caption = '' then
  begin
    ShowError('El código del cliente incorrecto.');
    edtCliente.SetFocus;
    Result := True;
    Exit;
  end;

  if txtPais.Caption = '' then
  begin
    ShowError('El código del país incorrecto.');
    edtPais.SetFocus;
    Result := True;
    Exit;
  end;

  Result := False;
end;

procedure TFLPrevisionCobroClientes.AbrirQuery;
begin
  if QEstadoCobros.Active then
  begin
    QEstadoCobros.Cancel;
    QEstadoCobros.Close;
  end;

  if edtCliente.Text <> '' then
  begin
    QEstadoCobros.sql.Clear;
    QEstadoCobros.SQL.Add(' SELECT cod_cliente_fc cliente_fac_f, n_factura_fc n_factura_f, fecha_factura_fc fecha_factura_f, importe_total_fc importe_total_f,  ' +
      '        moneda_fc moneda_f, nvl(prevision_cobro_fc,fecha_factura_fc) prevision_cobro_f,  ' +
      '        nvl(prevision_cobro_fc,fecha_factura_fc) + 60 fecha_afp_f, ');

    QEstadoCobros.SQL.Add('        dias_cobro_fp dias_pago, banco_b cod_banco, descripcion_b des_banco,  ');
    QEstadoCobros.SQL.Add('        case when forma_pago_adonix_fp = ''EF'' then ''EF-EFECTIVO''  ');
    QEstadoCobros.SQL.Add('             when forma_pago_adonix_fp = ''TF'' then ''TF-TRANSFERENCIA''  ');
    QEstadoCobros.SQL.Add('             when forma_pago_adonix_fp = ''PG'' then ''PG-PAGARE/CHEQUE''  ');
    QEstadoCobros.SQL.Add('             else ''SIN ASIGNAR'' end forma_pago,  ');

    QEstadoCobros.SQL.Add('     nvl((select sum(importe_cobrado_rf) ');
    QEstadoCobros.SQL.Add('     from   tremesas_fac ');
    QEstadoCobros.SQL.Add('     where  cod_factura_rf = cod_factura_fc ), 0) importe_cobrado_f, ');
    QEstadoCobros.SQL.Add('     (select MAX(fecha_vencimiento_rc) ');
    QEstadoCobros.SQL.Add('     from   tremesas_fac join  tremesas_cab on empresa_remesa_rc = empresa_remesa_rf and n_remesa_rc = n_remesa_rf ');
    QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ) fecha_cobro_f, ');

    QEstadoCobros.SQL.Add('     contabilizado_fc, 0 contab_cobro_f, nombre_c, pais_c ');


    QEstadoCobros.SQL.Add(' FROM tfacturas_cab join frf_clientes on empresa_c = cod_empresa_fac_fc AND cliente_c = cod_cliente_fc   ');
    QEstadoCobros.SQL.Add('                    left join tbancos on banco_c = banco_b ');
    QEstadoCobros.SQL.Add('                    left join frf_forma_pago on forma_pago_c = codigo_fp ');

    QEstadoCobros.SQL.Add(' WHERE fecha_factura_fc  between :fechadesde and :fechahasta ');
    if EEmpresa.Text = 'BAG' then
      QEstadoCobros.SQL.Add('   AND cod_empresa_fac_fc[1,1] = ''F'' ')
    else
    if EEmpresa.Text = 'SAT' then
      QEstadoCobros.SQL.Add('   AND cod_empresa_fac_fc in (''050'',''080'') ')
    else
      QEstadoCobros.SQL.Add('   AND cod_empresa_fac_fc = :EMPRESA ');
    QEstadoCobros.SQL.Add(' AND cod_cliente_fc = :cliente   ');

    if eFechaCobro.Text <> '' then
      QEstadoCobros.SQL.Add(' AND   nvl(prevision_cobro_fc,fecha_factura_fc)  < :fechacobro ');


    case cbbEstadoCobro.ItemIndex of
      0: //Pendientes de cobro
      begin
         QEstadoCobros.SQL.Add('   and  ( ABS( importe_total_fc ) - ');
         QEstadoCobros.SQL.Add('    ABS( nvl((select sum(importe_cobrado_rf) ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ), 0) ) > 0 ');
         QEstadoCobros.SQL.Add('    or NVL((select MAX(fecha_vencimiento_rc) ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac join  tremesas_cab on empresa_remesa_rc = empresa_remesa_rf and n_remesa_rc = n_remesa_rf ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ),TODAY + 1 ) > TODAY ) ');

         if Trim( edtDias.Text ) <> '' then
         begin
           QEstadoCobros.SQL.Add('   and  ( ( nvl(prevision_cobro_fc,fecha_factura_fc) + 60 ) - today ) <= ' + edtDias.Text + ' ' );
         end;
      end;
      1: //Cobradas
      begin
         QEstadoCobros.SQL.Add('   and not ( ABS( importe_total_fc ) - ');
         QEstadoCobros.SQL.Add('    ABS( nvl((select sum(importe_cobrado_rf) ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ), 0) ) > 0 ');
         QEstadoCobros.SQL.Add('    or NVL((select MAX(fecha_vencimiento_rc) ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac join  tremesas_cab on empresa_remesa_rc = empresa_remesa_rf and n_remesa_rc = n_remesa_rf ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ),TODAY + 1 ) > TODAY ) ');
      end;
      2: //Pendientes de remesar
      begin
         QEstadoCobros.SQL.Add('   and  ( ABS( importe_total_fc ) - ');
         QEstadoCobros.SQL.Add('    ABS( nvl((select sum(importe_cobrado_rf) ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ), 0) ) > 0 ');
         QEstadoCobros.SQL.Add('    or not exists (select * ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac  ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ) ) ');
      end;
      3: //Remesadas
      begin
         QEstadoCobros.SQL.Add('   and exists (select * ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac  ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf  ) ');
      end;
      4: //Todas
         ;
    end;

    QEstadoCobros.SQL.Add('  ORDER BY pais_c, cliente_fac_f, prevision_cobro_f, n_factura_f  ');
    try
      with QEstadoCobros do
      begin
        Close;
        if ( EEmpresa.Text <> 'BAG' ) AND ( EEmpresa.Text <> 'SAT' ) then
          ParamByName('empresa').AsString := EEmpresa.Text;
        ParamByName('cliente').AsString := edtCliente.Text;
        if eFechaCobro.Text <> '' then
          ParamByName('fechacobro').AsDate := StrToDate(eFechaCobro.Text);
        ParamByName('fechadesde').AsDate := StrToDate(eFechaDesde.Text);
        ParamByName('fechahasta').AsDate := StrToDate(eFechaHasta.Text);

        //Sql.SaveToFile('c:\pepe.sql');
        Open;
      end;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        raise;
      end;
    end;
  end
  else
  begin
    QEstadoCobros.sql.Clear;
        QEstadoCobros.SQL.Add(' SELECT cod_cliente_fc cliente_fac_f, n_factura_fc n_factura_f, fecha_factura_fc fecha_factura_f, importe_total_fc importe_total_f,  ' +
      '        moneda_fc moneda_f, nvl(prevision_cobro_fc,fecha_factura_fc) prevision_cobro_f,  ' +
      '        nvl(prevision_cobro_fc,fecha_factura_fc) + 60 fecha_afp_f, ');

    QEstadoCobros.SQL.Add('        dias_cobro_fp dias_pago, banco_b cod_banco, descripcion_b des_banco,  ');
    QEstadoCobros.SQL.Add('        case when forma_pago_adonix_fp = ''EF'' then ''EF-EFECTIVO''  ');
    QEstadoCobros.SQL.Add('             when forma_pago_adonix_fp = ''TF'' then ''TF-TRANSFERENCIA''  ');
    QEstadoCobros.SQL.Add('             when forma_pago_adonix_fp = ''PG'' then ''PG-PAGARE/CHEQUE''  ');
    QEstadoCobros.SQL.Add('             else ''SIN ASIGNAR'' end forma_pago,  ');

    QEstadoCobros.SQL.Add('     nvl((select sum(importe_cobrado_rf) ');
    QEstadoCobros.SQL.Add('     from   tremesas_fac ');
    QEstadoCobros.SQL.Add('     where  cod_factura_rf = cod_factura_fc ), 0) importe_cobrado_f, ');

    QEstadoCobros.SQL.Add('     (select MAX(fecha_vencimiento_rc) ');
    QEstadoCobros.SQL.Add('     from   tremesas_fac join  tremesas_cab on empresa_remesa_rc = empresa_remesa_rf and n_remesa_rc = n_remesa_rf ');
    QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ) fecha_cobro_f, ');

    QEstadoCobros.SQL.Add('     contabilizado_fc, 0 contab_cobro_f, nombre_c, pais_c ');

    QEstadoCobros.SQL.Add(' FROM tfacturas_cab join frf_clientes on empresa_c = cod_empresa_fac_fc AND cliente_c = cod_cliente_fc   ');
    QEstadoCobros.SQL.Add('                    left join tbancos on banco_c = banco_b ');
    QEstadoCobros.SQL.Add('                    left join frf_forma_pago on forma_pago_c = codigo_fp ');

    QEstadoCobros.SQL.Add(' WHERE fecha_factura_fc  between :fechadesde and :fechahasta ');
    if EEmpresa.Text = 'BAG' then
      QEstadoCobros.SQL.Add('   AND cod_empresa_fac_fc[1,1] = ''F'' ')
    else
    if EEmpresa.Text = 'SAT' then
      QEstadoCobros.SQL.Add('   AND cod_empresa_fac_fc in (''050'',''080'') ')
    else
      QEstadoCobros.SQL.Add('   AND cod_empresa_fac_fc = :EMPRESA ');

    if eFechaCobro.Text <> '' then
      QEstadoCobros.SQL.Add(' AND   nvl(prevision_cobro_fc,fecha_factura_fc)  < :fechacobro ');

    if edtPais.Text <> '' then
    begin
      QEstadoCobros.SQL.Add('  AND   pais_c = :pais ');
    end
    else
    begin
      case cbbMercado.ItemIndex of
        1: QEstadoCobros.SQL.Add('  AND pais_c = ' + QuotedStr('ES') + '  ');
        2: QEstadoCobros.SQL.Add('  AND pais_c <> ' + QuotedStr('ES') + '  ');
        else begin {nada} end;
      end;
    end;

    case cbbEstadoCobro.ItemIndex of
      0: //Pendientes de cobro
      begin
         QEstadoCobros.SQL.Add('   and  ( ABS( importe_total_fc ) - ');
         QEstadoCobros.SQL.Add('    ABS( nvl((select sum(importe_cobrado_rf) ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ), 0) ) > 0 ');
         QEstadoCobros.SQL.Add('    or NVL((select MAX(fecha_vencimiento_rc) ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac join  tremesas_cab on empresa_remesa_rc = empresa_remesa_rf and n_remesa_rc = n_remesa_rf ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ),TODAY + 1 ) > TODAY ) ');

         if Trim( edtDias.Text ) <> '' then
         begin
           QEstadoCobros.SQL.Add('   and  ( ( nvl(prevision_cobro_fc,fecha_factura_fc) + 60 ) - today ) <= ' + edtDias.Text + ' ' );
         end;
      end;
      1: //Cobradas
      begin
         QEstadoCobros.SQL.Add('   and not ( ABS( importe_total_fc ) - ');
         QEstadoCobros.SQL.Add('    ABS( nvl((select sum(importe_cobrado_rf) ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ), 0) ) > 0 ');
         QEstadoCobros.SQL.Add('    or NVL((select MAX(fecha_vencimiento_rc) ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac join  tremesas_cab on empresa_remesa_rc = empresa_remesa_rf and n_remesa_rc = n_remesa_rf ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ),TODAY + 1 ) > TODAY ) ');
      end;
      2: //Pendientes de remesar
      begin
         QEstadoCobros.SQL.Add('   and  ( ABS( importe_total_fc ) - ');
         QEstadoCobros.SQL.Add('    ABS( nvl((select sum(importe_cobrado_rf) ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ), 0) ) > 0 ');
         QEstadoCobros.SQL.Add('    or not exists (select * ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac  ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf ) ) ');
      end;
      3: //Remesadas
      begin
         QEstadoCobros.SQL.Add('   and exists (select * ');
         QEstadoCobros.SQL.Add('           from   tremesas_fac  ');
         QEstadoCobros.SQL.Add('     where  cod_factura_fc = cod_factura_rf  ) ');
      end;
      4: //Todas
         ;
    end;

    QEstadoCobros.SQL.Add('  ORDER BY pais_c, cliente_fac_f, prevision_cobro_f, n_factura_f  ');
    try
      with QEstadoCobros do
      begin
        Close;
        if ( EEmpresa.Text <> 'BAG' ) AND ( EEmpresa.Text <> 'SAT' ) then
          ParamByName('empresa').AsString := EEmpresa.Text;
        if edtPais.Text <> '' then
          ParamByName('pais').AsString := edtPais.Text;
        if eFechaCobro.Text <> '' then
          ParamByName('fechacobro').AsDate := StrToDate(eFechaCobro.Text);
        ParamByName('fechadesde').AsDate := StrToDate(eFechaDesde.Text);
        ParamByName('fechahasta').AsDate := StrToDate(eFechaHasta.Text);
        ///Sql.SaveToFile('c:\pepe.sql');
        Open;
      end;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        raise;
      end;
    end;
  end;
end;

procedure TFLPrevisionCobroClientes.cbbEstadoCobroChange(Sender: TObject);
begin
  //
end;

end.
