unit EstadoCobroClientesFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DBTables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, ExtCtrls;

type
  TFLEstadoCobroClientes = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    edtEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    lblNombre2: TLabel;
    eFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lblNombre3: TLabel;
    eFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    edtPais: TBEdit;
    btnPais: TBGridButton;
    txtPais: TStaticText;
    lbl2: TLabel;
    lblMoneda: TLabel;
    Label3: TLabel;
    edtCliente: TBEdit;
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
    rgMoneda: TRadioGroup;
    qryeMAIL: TQuery;
    btnResumen: TSpeedButton;
    chkExcInter: TCheckBox;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbbEstadoSaldoChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure edtTipoClienteChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure btnResumenClick(Sender: TObject);


  private
     {Private declarations}
    sEmpresa, sCliente, sTipoCliente, sPais: string;
    bExcluirCliente, bExcluirInterplanta: boolean;
    iMercado, iMoneda, iEstadoCobro: integer;
    dFechaIni, dFechaFin: TDateTime;

    function  ParametrosOK: boolean;
    procedure PendienteCobro( const AVerFacturas: boolean );

  public
    { Public declarations }
  end;

implementation


uses UDMAuxDB, Principal, CVariables, CReportes, UDMConfig, CGlobal,
  CAuxiliarDB, DPreview, UDMBaseDatos, EstadoCobroClienteDM, UFClientes,
  UDMMaster, DConfigMail;
  (*ExtractoCobroQL, *)

{$R *.DFM}

//                         ****  BOTONES  ****


procedure TFLEstadoCobroClientes.PendienteCobro( const AVerFacturas: boolean );
begin
  if CerrarForm(true) then
  begin
    Self.ActiveControl := nil;
    if ParametrosOK then
    begin
        DMEstadoCobroCliente.PendienteCobro( sEmpresa, sCliente, sTipoCliente, sPais,
                                           dFechaIni, dFechaFin,
                                           iMercado, iMoneda, iEstadoCobro,
                                           bExcluirCliente, bExcluirInterplanta, AVerFacturas )
    end;
  end;
end;


procedure TFLEstadoCobroClientes.BBAceptarClick(Sender: TObject);
begin
  PendienteCobro( true );
end;

procedure TFLEstadoCobroClientes.btnResumenClick(Sender: TObject);
begin
  PendienteCobro( false );
end;

procedure TFLEstadoCobroClientes.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLEstadoCobroClientes.FormCreate(Sender: TObject);
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

  eFechaHasta.Text := DateTostr(Date);
  eFechaDesde.Text := DateTostr(Date-365);
  CalendarioFlotante.Date := Date;

  edtEmpresa.Tag := kEmpresa;
  edtCliente.Tag := kCliente;
  edtTipoCliente.Tag := kTipoCliente;
  edtPais.Tag := kPais;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  //rgEstadoCobro.ItemIndex := 0;
  rgMoneda.ItemIndex := 0;

  //edtEmpresa.Text:= gsDefEmpresa;
  if gProgramVersion = pvBAG then
    edtEmpresa.Text:= 'BAG'
  else
    edtEmpresa.Text:= 'SAT';
  PonNombre( edtPais );

  edtCliente.Text := '';
  STCliente.Caption := '';

  DMEstadoCobroCliente:= TDMEstadoCobroCliente.Create( self );
end;

procedure TFLEstadoCobroClientes.FormActivate(Sender: TObject);
begin
  ActiveControl := edtEmpresa;
end;

procedure TFLEstadoCobroClientes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLEstadoCobroClientes.FormClose(Sender: TObject;
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

procedure TFLEstadoCobroClientes.ADesplegarRejillaExecute(Sender: TObject);
var
  sAux: string;
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCliente:
    begin
      //DespliegaRejilla(btnCliente, [edtEmpresa.Text]);
      sAux:= edtCliente.Text;
      if SeleccionaClientes( self, edtCliente, edtEmpresa.Text, sAux ) then
      begin
        edtCliente.Text:= sAux;
      end;
    end;
    kPais: DespliegaRejilla(btnPais);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
        if eFechaHasta.Focused then
          DespliegaCalendario(btnFechaHasta);
      end;
    kTipoCliente:
    begin
      DespliegaRejilla(btnTipoCliente);
    end;
  end;
end;

procedure TFLEstadoCobroClientes.PonNombre(Sender: TObject);
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
        if edtEmpresa.Text = '' then
          STEmpresa.Caption := 'TODAS LAS EMPRESAS'
        else
          STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
        edtClienteChange(edtCliente);
      end;
    kPais:
      begin
        if edtPais.Text = '' then
          txtPais.Caption := 'TODOS LOS PAISES'
        else
        begin
          txtPais.Caption := desPais(edtPais.Text);
        end;
      end;
  end;
end;

function TFLEstadoCobroClientes.ParametrosOK: boolean;
begin
  Result := false;

  //Comprobar que sea valido
  if stEmpresa.Caption = '' then
  begin
    ShowError('El código de la empresa no es correcto.');
    edtEmpresa.Focused;
    Exit;
  end;
  sEmpresa:= edtEmpresa.text;

  if not TryStrToDate(eFechaDesde.Text, dFechaIni )then
  begin
    ShowError('Falta fecha de inicio o es incorrecta.');
    eFechaDesde.SetFocus;
    Exit;
  end;

  if not TryStrToDate(eFechaHasta.Text, dFechaFin )then
  begin
    ShowError('Falta fecha de fin o es incorrecta.');
    eFechaHasta.SetFocus;
    Exit;
  end;

  if dFechaIni > dFechaFin then
  begin
    ShowError('Rango de fechas incorrecto.');
    eFechaDesde.SetFocus;
    Exit;
  end;


  //Comprobar que el cliente si tiene valor sea valido
  if (trim(edtCliente.Text) <> '') then
  begin
    if stCliente.Caption = '' then
    begin
      ShowError('El código del cliente no es correcto.');
      edtCliente.Focused;
      Exit;
    end;
  end;

  if txtListaCliente.Caption = '' then
  begin
    if (trim(edtCliente.Text) <> '') then
      sCliente:= edtCliente.Text
    else
      sCliente:= '';
  end
  else
  begin
    if (trim(edtCliente.Text) <> '') then
    if Pos( Trim(edtCliente.Text), txtListaCliente.Caption ) = 0 then
    begin
      txtListaCliente.Caption:= txtListaCliente.Caption + ',' + Trim(edtCliente.Text);
    end;
    if Pos( ',', txtListaCliente.Caption )>0 then
    begin
      sCliente:= '''' + StringReplace( txtListaCliente.Caption, ',', ''',''', [rfReplaceAll] ) + '''';
    end
    else
    begin
      sCliente:= txtListaCliente.Caption
    end;
  end;
  bExcluirCliente:= chkExcluir.Checked;

  //Comprobar que el tipo cliente si tiene valor sea valido
  if (trim(edtTipoCliente.Text) <> '') then
  begin
    if txtTipoCliente.Caption = '' then
    begin
      ShowError('El código del tipo cliente no es correcto.');
      edtTipoCliente.Focused;
      Exit;
    end;
  end;
  sTipoCliente:= edtTipoCliente.Text;

  bExcluirInterplanta:= chkExcInter.Checked;

  if txtPais.Caption = '' then
  begin
    ShowError('El código del país incorrecto.');
    edtPais.SetFocus;
    Result := True;
    Exit;
  end;
  sPais:= edtPais.Text;


  iMercado:= 0;
  iMoneda:= rgMoneda.ItemIndex;
  iEstadoCobro:= 0;

  Result := True;
end;

(*
procedure TFLEstadoCobroClientes.AbrirQuery;
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
    QEstadoCobros.SQL.Add('                    left join frf_bancos on banco_c = banco_b ');
    QEstadoCobros.SQL.Add('                    left join frf_forma_pago on forma_pago_c = codigo_fp ');

    QEstadoCobros.SQL.Add(' WHERE fecha_factura_fc  between :fechadesde and :fechahasta ');
    if edtEmpresa.Text = 'BAG' then
      QEstadoCobros.SQL.Add('   AND cod_empresa_fac_fc[1,1] = ''F'' ')
    else
    if edtEmpresa.Text = 'SAT' then
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
        if ( edtEmpresa.Text <> 'BAG' ) AND ( edtEmpresa.Text <> 'SAT' ) then
          ParamByName('empresa').AsString := edtEmpresa.Text;
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
    QEstadoCobros.SQL.Add('                    left join frf_bancos on banco_c = banco_b ');
    QEstadoCobros.SQL.Add('                    left join frf_forma_pago on forma_pago_c = codigo_fp ');

    QEstadoCobros.SQL.Add(' WHERE fecha_factura_fc  between :fechadesde and :fechahasta ');
    if edtEmpresa.Text = 'BAG' then
      QEstadoCobros.SQL.Add('   AND cod_empresa_fac_fc[1,1] = ''F'' ')
    else
    if edtEmpresa.Text = 'SAT' then
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
        if ( edtEmpresa.Text <> 'BAG' ) AND ( edtEmpresa.Text <> 'SAT' ) then
          ParamByName('empresa').AsString := edtEmpresa.Text;
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
*)

procedure TFLEstadoCobroClientes.cbbEstadoSaldoChange(Sender: TObject);
begin
  //
end;

procedure TFLEstadoCobroClientes.btn1Click(Sender: TObject);
begin
  if ( stCliente.Caption <> '' )  and ( edtCliente.Text <> ''  ) then
  begin
    if Pos( edtCliente.Text, txtListaCliente.Caption ) = 0 then
    begin
      if txtListaCliente.Caption = '' then
        txtListaCliente.Caption:= Trim(edtCliente.Text)
      else
        txtListaCliente.Caption:= txtListaCliente.Caption + ',' + Trim(edtCliente.Text);
    end;
  end;
end;

procedure TFLEstadoCobroClientes.btnLimpiarClick(Sender: TObject);
begin
  txtListaCliente.Caption:= '';
end;

procedure TFLEstadoCobroClientes.edtTipoClienteChange(Sender: TObject);
begin
  IF edtTipoCliente.Text = '' then
  begin
    txtTipoCliente.Caption := 'TODOS LOS TIPOS';
  end
  else
  begin
    txtTipoCliente.Caption := desTipoCliente(edtTipoCliente.Text );
  end;
end;

procedure TFLEstadoCobroClientes.edtClienteChange(Sender: TObject);
begin
  if edtCliente.Text = '' then
  begin
    STCliente.Caption := 'TODOS LOS CLIENTES';
  end
  else
  IF ( edtEmpresa.Text = '' ) or ( edtEmpresa.Text = 'SAT' ) then
  begin
    STCliente.Caption := desCliente(edtCliente.Text);
  end
  else
  IF edtEmpresa.Text = 'BAG' then
  begin
    STCliente.Caption := desCliente(edtCliente.Text);
  end
  else
  begin
    STCliente.Caption := desCliente(edtCliente.Text);
  end;
end;

(*
procedure TFLEstadoCobroClientes.btnCorreosClick(Sender: TObject);
VAR
  sAux, eMail: string;
  aux: integer;
begin
      sAux:= #13 + #10;
      sAux:= sAux + 'COMUNICACIÓN A CLIENTES' + #13 + #10;
      sAux:= sAux + 'Sistema de Suministro Inmediato de Información (SII)' + #13 + #10;
      sAux:= sAux + #13 + #10;
      sAux:= sAux + 'Como es sabido, el próximo 1 de julio de 2017 entrará en vigor el Sistema de Suministro Inmediato de Información,  ';
      sAux:= sAux + 'consistente en la obligación de llevar los libros registro de IVA a través de la Sede Electrónica de la AEAT.' + #13 + #10;
      sAux:= sAux + #13 + #10;
      sAux:= sAux + 'Este sistema de suministro de información, obligatorio para determinados sujetos pasivos (entre ellos, las entidades del Grupo Bonnysa), ';
      sAux:= sAux + 'implica la remisión de determinada información referida a las facturas emitidas y recibidas, así como otra información adicional de relevancia fiscal, ';
      sAux:= sAux + 'en un breve periodo de tiempo desde su expedición o contabilización.' + #13 + #10;
      sAux:= sAux + #13 + #10;
      sAux:= sAux + 'En el marco de este cambio normativo, nos gustaría trasmitirle nuestro interés en revisar los criterios de ';
      sAux:= sAux + 'facturación aplicados actualmente en el ámbito de la relación comercial que, S.a.t.';
      sAux:= sAux + 'Bonnysa y Bonnysa Agroalimentaria mantiene con Ustedes, y verificar que dichos criterios permitirán el cumplimiento adecuado de las obligaciones ';
      sAux:= sAux + 'de facturación y llevanza de los libros registro por parte de ambas Compañías.' + #13 + #10;
      sAux:= sAux + #13 + #10;
      sAux:= sAux + 'En este sentido, S.a.t. Bonnysa y Bonnysa Agroalimentaria desea que esta Comunicación sirva para recordar que todos los sujetos ';
      sAux:= sAux + 'pasivos deberán emitir factura por las entregas de bienes y prestaciones de servicios que realizan en el desarrollo de su actividad, ';
      sAux:= sAux + 'así como la obligación de emitir y remitir al destinatario facturas rectificativas en aquellos supuestos que dan lugar a la modificación ';
      sAux:= sAux + 'de la base imponible de las operaciones, según lo dispuesto en el artículo 80 Ley 37/1992, del Impuesto sobre el Valor Añadido ';
      sAux:= sAux + '(entre las que se encuentran la concesión de descuentos y otros ajustes al precio de las operaciones). Nos referimos en particular a las ';
      sAux:= sAux + 'modificaciones de base imponible que se ponen de manifiesto como consecuencia  la concesión de descuentos y otros ajustes al precio de las operaciones.' + #13 + #10;
      sAux:= sAux + #13 + #10;
      sAux:= sAux + 'En el ámbito de las facturas emitidas por entregas de bienes, y según lo dispuesto en el Real Decreto 1619/2012, ';
      sAux:= sAux + 'por el que se aprueba el Reglamento de facturación, las mismas deberán ser emitidas por, S.a.t. Bonnysa o Bonnysa Agroalimentaria ';
      sAux:= sAux + 'antes del día 15 del mes siguiente al que se produzca la entrega del producto, por lo que es necesario disponer de toda la ';
      sAux:= sAux + 'información necesaria por nuestra parte en el menor tiempo posible para poder emitir la factura en el plazo concedido al efecto.' + #13 + #10;

  qryeMAIL.RequestLive:= True;
  qryeMAIL.sql.Clear;
  qryeMAIL.sql.Add(' SELECT cliente,email,enviado ');
  qryeMAIL.sql.Add(' FROM email_clientes_sii ');
  qryeMAIL.sql.Add(' where enviado = 0 ');
  qryeMAIL.Open;

  FDConfigMail:= TFDConfigMail.Create(Application);

  FDConfigMail.IdSMTP.Host:= 'smtp.exchange2007.es';
  FDConfigMail.IdSMTP.Username:= 'USRAD00084885';
  FDConfigMail.IdSMTP.Password:= 'Rg46786';
  FDConfigMail.IdSMTP.Port:= 25;


  while not qryeMAIL.Eof do
  begin
      try
        if FDConfigMail.IdSMTP.Connected then
          FDConfigMail.IdSMTP.Disconnect;
        FDConfigMail.IdSMTP.Connect;
        try
          FDConfigMail.IdMessage.From.Name := 'Rosana Gonzalez';
          FDConfigMail.IdMessage.From.Address := 'rosanagonzalez@bonnysa.es';
          FDConfigMail.IdMessage.ReplyTo.EMailAddresses:= 'rosanagonzalez@bonnysa.es';
          eMail:= qryeMAIL.FieldByName('email').AsString;

          FDConfigMail.IdMessage.Recipients.Clear;
          if pos(';', eMail) > 0 then
          begin
            while eMail <> '' do
            begin
              if pos(';', eMail) > 0 then
              begin
                FDConfigMail.IdMessage.Recipients.Add.Address := Trim(Copy(eMail, 0, (pos(';', eMail) - 1)));
                aux := pos(';', eMail) + 1;
                eMail := Copy(eMail, aux, Length(eMail));
              end
              else
              begin
                FDConfigMail.IdMessage.Recipients.Add.Address := trim(Copy(eMail, 0, Length(eMail)));
                eMail := '';
              end;
            end;
          end
          else
            FDConfigMail.IdMessage.Recipients.Add.Address := eMail;


          FDConfigMail.IdMessage.MessageParts.Clear;
          TIdAttachment.Create(FDConfigMail.IdMessage.MessageParts, 'C:\temp\Comunicación a clientes SII.pdf');
          FDConfigMail.IdMessage.Body.Clear;
          FDConfigMail.IdMessage.Body.Add(sAux);
          FDConfigMail.IdMessage.Subject := 'GRUPO BONNYSA - COMUNICADO SII [' + qryeMAIL.FieldByName('cliente').AsString + ']';
          FDConfigMail.IdSMTP.Send(FDConfigMail.IdMessage);

          qryeMAIL.Edit;
          qryeMAIL.FieldByName('enviado').AsInteger:= 1;
          qryeMAIL.Post;
        finally
          FDConfigMail.IdSMTP.Disconnect;
        end;
      except
      end;


    qryeMAIL.Next;
  end;
  qryeMAIL.Close;
  FreeAndNil( FDConfigMail );
end;
*)

end.
