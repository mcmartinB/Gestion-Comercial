unit DiasCobroFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DBTables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, ExtCtrls, kbmMemTable, nbEdits, nbCombos;

type
  TFLDiasCobro = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    qryFacturasCobros: TQuery;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    cbbMercado: TComboBox;
    lblNombre2: TLabel;
    eFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lblNombre3: TLabel;
    eFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    Label2: TLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    txtCliente: TStaticText;
    edtPais: TBEdit;
    BGBPais1: TBGridButton;
    txtPais: TStaticText;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl6: TLabel;
    kmtListado: TkbmMemTable;
    lbl4: TLabel;
    cbbTipo: TComboBox;
    lblTipoCliente: TLabel;
    txtTipoCliente: TStaticText;
    chkExcluirTipoCliente: TCheckBox;
    edtTipoCliente: TBEdit;
    btnTipoCliente: TBGridButton;
    chkExcluirCliente: TCheckBox;
    lbl5: TLabel;
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
    function CamposVacios: boolean;
    function AbrirQuery: boolean;
    procedure LoadData;
    procedure NuevoRegistro( const ACtaCliente, ACodCliente, ADesCliente: string;
                             const AFacturado, ACobrado, ADiasCobrado: Real );


  public
    { Public declarations }
  end;

implementation


uses UDMAuxDB, Principal, CVariables, CReportes, UDMConfig, CGlobal,
  CAuxiliarDB, DiasCobroQL, DPreview, UDMBaseDatos, bMath, UDMMaster;

{$R *.DFM}

//                         ****  BOTONES  ****

procedure TFLDiasCobro.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  Self.ActiveControl := nil;

  if CamposVacios then Exit;

  if AbrirQuery then
  begin
    try
      LoadData;
      qryFacturasCobros.Close;

      //Llamamos al QReport
      QLDiasCobro := TQLDiasCobro.Create(Self);
      try
        PonLogoGrupoBonnysa(QLDiasCobro, EEmpresa.Text);
        QLDiasCobro.lblPeriodo.Caption := 'Del ' + eFechaDesde.text + ' al ' + eFechaHasta.Text;
        if edtCliente.Text  <> '' then
        begin
          if chkExcluirCliente.Checked then
            QLDiasCobro.lblCliente.Caption:= 'NO ' + edtCliente.Text + ' - '  + txtCliente.Caption
          else
            QLDiasCobro.lblCliente.Caption:= edtCliente.Text + ' - '  + txtCliente.Caption;
        end
        else
        if edtPais.Text <> '' then
        begin
          QLDiasCobro.lblCliente.Caption:= edtPais.Text + ' - '  + txtPais.Caption;
        end
        else
        begin
          if cbbMercado.ItemIndex = 0 then
          begin
            QLDiasCobro.lblCliente.Caption:= 'TODOS LOS CLIENTES';
          end
          else
          if cbbMercado.ItemIndex = 0 then
          begin
            QLDiasCobro.lblCliente.Caption:= 'CLIENTES NACIONALES';
          end
          else
          begin
            QLDiasCobro.lblCliente.Caption:= 'CLIENTES EXPORTACION';
          end;
        end;

        kmtListado.SortFields:= 'cod_cliente;cta_cliente';
        kmtListado.Sort([]);

        Preview(QLDiasCobro);
      except
        FreeAndNil( QLDiasCobro );
        raise;
      end;
    finally
      kmtListado.Close;
    end;
  end
  else
  begin
    qryFacturasCobros.Close;
    ShowError('Listado sin datos ...');
  end;
end;

procedure TFLDiasCobro.LoadData;
var
  sCtaCliente, sCodCliente, sDesCliente, sFactura: string;
  rFacturado, rCobrado, rDiasCobrado, rAux: Real;
  iDias: Integer;
begin
  kmtListado.Open;
  sCtaCliente:= qryFacturasCobros.FieldByName('cta_cliente_c').AsString;
  sCodCliente:= qryFacturasCobros.FieldByName('cliente_sal_f').AsString;
  sDesCliente:= qryFacturasCobros.FieldByName('nombre_c').AsString;
  sFactura:= qryFacturasCobros.FieldByName('empresa_f').AsString +
             qryFacturasCobros.FieldByName('fecha_factura_f').AsString +
             qryFacturasCobros.FieldByName('n_factura_f').AsString;


  rFacturado:= bRoundTo( qryFacturasCobros.FieldByName('importe_neto_f').AsFloat * qryFacturasCobros.FieldByName('cambio').AsFloat, 2);
  if qryFacturasCobros.FieldByName('importe_neto_f').AsFloat > 0 then
  begin
    //factura
    iDias:= Trunc( qryFacturasCobros.FieldByName('fecha_remesa_fr').AsDateTime - qryFacturasCobros.FieldByName('fecha_factura_f').AsDateTime );
    if iDias >= 0 then
    begin
      rCobrado:= bRoundTo( qryFacturasCobros.FieldByName('importe_cobrado_fr').AsFloat * qryFacturasCobros.FieldByName('cambio').AsFloat, 2);
      rDiasCobrado:= rCobrado * iDias;
    end
    else
    begin
      rCobrado:= bRoundTo( qryFacturasCobros.FieldByName('importe_cobrado_fr').AsFloat * qryFacturasCobros.FieldByName('cambio').AsFloat, 2);
      rDiasCobrado:= 0;
    end;
  end
  else
  begin
    rCobrado:= 0;
    rDiasCobrado:= 0;
  end;


  qryFacturasCobros.Next;
  while not qryFacturasCobros.Eof do
  begin
    if sCtaCliente <> qryFacturasCobros.FieldByName('cta_cliente_c').AsString then
    begin
      NuevoRegistro( sCtaCliente, sCodCliente, sDesCliente, rFacturado, rCobrado, rDiasCobrado );
      sCtaCliente:= qryFacturasCobros.FieldByName('cta_cliente_c').AsString;
      sCodCliente:= qryFacturasCobros.FieldByName('cliente_sal_f').AsString;
      sDesCliente:= qryFacturasCobros.FieldByName('nombre_c').AsString;
      sFactura:= qryFacturasCobros.FieldByName('empresa_f').AsString +
             qryFacturasCobros.FieldByName('fecha_factura_f').AsString +
             qryFacturasCobros.FieldByName('n_factura_f').AsString;
      rFacturado:= bRoundTo( qryFacturasCobros.FieldByName('importe_neto_f').AsFloat * qryFacturasCobros.FieldByName('cambio').AsFloat, 2);
      if qryFacturasCobros.FieldByName('importe_neto_f').AsFloat > 0 then
      begin
        //factura
        iDias:= Trunc( qryFacturasCobros.FieldByName('fecha_remesa_fr').AsDateTime - qryFacturasCobros.FieldByName('fecha_factura_f').AsDateTime );
        if iDias >= 0 then
        begin
          rCobrado:= bRoundTo( qryFacturasCobros.FieldByName('importe_cobrado_fr').AsFloat * qryFacturasCobros.FieldByName('cambio').AsFloat, 2);
          rDiasCobrado:= rCobrado * iDias;
        end
        else
        begin
          rCobrado:= bRoundTo( qryFacturasCobros.FieldByName('importe_cobrado_fr').AsFloat * qryFacturasCobros.FieldByName('cambio').AsFloat, 2);
          rDiasCobrado:= 0;
        end;
      end
      else
      begin
        rCobrado:= 0;
        rDiasCobrado:= 0;
      end;
    end
    else
    begin
      if sFactura <> qryFacturasCobros.FieldByName('empresa_f').AsString +
                     qryFacturasCobros.FieldByName('fecha_factura_f').AsString +
                     qryFacturasCobros.FieldByName('n_factura_f').AsString then
      begin
        sFactura:= qryFacturasCobros.FieldByName('empresa_f').AsString +
             qryFacturasCobros.FieldByName('fecha_factura_f').AsString +
             qryFacturasCobros.FieldByName('n_factura_f').AsString;
        rFacturado:= rFacturado + bRoundTo( qryFacturasCobros.FieldByName('importe_neto_f').AsFloat * qryFacturasCobros.FieldByName('cambio').AsFloat, 2);
      end;
      if qryFacturasCobros.FieldByName('importe_neto_f').AsFloat > 0 then
      begin
        //factura
        iDias:= Trunc( qryFacturasCobros.FieldByName('fecha_remesa_fr').AsDateTime - qryFacturasCobros.FieldByName('fecha_factura_f').AsDateTime );
        if iDias >= 0 then
        begin
          rAux:= bRoundTo( qryFacturasCobros.FieldByName('importe_cobrado_fr').AsFloat * qryFacturasCobros.FieldByName('cambio').AsFloat, 2);
          rCobrado:= rCobrado + rAux;
          rDiasCobrado:=  rDiasCobrado + ( rAux * iDias );
        end
        else
        begin
          rAux:= bRoundTo( qryFacturasCobros.FieldByName('importe_cobrado_fr').AsFloat * qryFacturasCobros.FieldByName('cambio').AsFloat, 2);
          rCobrado:= rCobrado + rAux;
          //rDiasCobrado:=  rDiasCobrado + ( rAux * iDias );
        end;
      end;
    end;
    qryFacturasCobros.Next;
  end;
  NuevoRegistro( sCtaCliente, sCodCliente, sDesCliente, rFacturado, rCobrado, rDiasCobrado );
end;

procedure TFLDiasCobro.NuevoRegistro( const ACtaCliente, ACodCliente, ADesCliente: string;
                                      const AFacturado, ACobrado, ADiasCobrado: Real );
begin
  kmtListado.Insert;

  kmtListado.FieldByName('cta_cliente').AsString:= ACtaCliente;
  kmtListado.FieldByName('cod_cliente').AsString:= ACodCliente;
  kmtListado.FieldByName('des_cliente').AsString:= ADesCliente;
  kmtListado.FieldByName('facturado').AsFloat:= AFacturado;
  kmtListado.FieldByName('cobrado').AsFloat:= ACobrado;
  kmtListado.FieldByName('cobrado_dias').AsFloat:= ADiasCobrado;
  if ACobrado > 0 then
    kmtListado.FieldByName('dias').AsFloat:= bRoundTo( ADiasCobrado/ ACobrado )
  else
    kmtListado.FieldByName('dias').AsFloat:= 0;
  kmtListado.Post;
end;

procedure TFLDiasCobro.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

//                          **** FORMULARIO ****

procedure TFLDiasCobro.FormCreate(Sender: TObject);
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

  EEmpresa.Tag := kEmpresa;
  edtCliente.Tag := kCliente;
  edtTipoCliente.Tag := kTipoCliente;
  edtPais.Tag := kPais;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  cbbMercado.ItemIndex := 0;

  //EEmpresa.Text:= gsDefEmpresa;
  (*
  if gProgramVersion = pvBAG then
    EEmpresa.Text:= 'BAG'
  else
    EEmpresa.Text:= 'SAT';
  *)
  EEmpresa.Text:= '';
  PonNombre( EEmpresa );
  PonNombre( edtPais );
  edtTipoCliente.Text:= 'IP';


  kmtListado.FieldDefs.Clear;
  kmtListado.FieldDefs.Add('cta_cliente', ftString, 12, False);
  kmtListado.FieldDefs.Add('cod_cliente', ftString, 3, False);
  kmtListado.FieldDefs.Add('des_cliente', ftString, 50, False);
  kmtListado.FieldDefs.Add('facturado', ftFloat, 0, False);
  kmtListado.FieldDefs.Add('cobrado', ftFloat, 0, False);
  kmtListado.FieldDefs.Add('cobrado_dias', ftFloat, 0, False);
  kmtListado.FieldDefs.Add('dias', ftFloat, 0, False);
  kmtListado.IndexFieldNames:= 'cta_cliente_c';
  kmtListado.CreateTable;
end;

procedure TFLDiasCobro.FormActivate(Sender: TObject);
begin
  ActiveControl := EEmpresa;
end;

procedure TFLDiasCobro.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLDiasCobro.FormClose(Sender: TObject;
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

procedure TFLDiasCobro.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente:
      begin
        DespliegaRejilla(btnCliente, [EEmpresa.Text]);
      end;
    kTipoCliente:
      begin
        DespliegaRejilla(btnTipoCliente, []);
      end;
    kPais:
      begin
        DespliegaRejilla(BGBPais1);
      end;
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
        if eFechaHasta.Focused then
          DespliegaCalendario(btnFechaHasta);
      end;
  end;
end;

procedure TFLDiasCobro.PonNombre(Sender: TObject);
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
        if EEmpresa.Text = '' then
          STEmpresa.Caption := 'TODAS LAS PLANTAS'
        else
        begin
          STEmpresa.Caption := desEmpresa(Eempresa.Text);
        end;
        PonNombre( edtCliente );
      end;
    kCliente:
      begin
        if edtCliente.Text = '' then
          txtCliente.Caption := 'TODOS LOS CLIENTES'
        else
        begin
          txtCliente.Caption := desCliente(edtCliente.Text);
          if txtCliente.Caption <> '' then
          begin
            edtPais.Text:= '';
            cbbMercado.ItemIndex:= 0;
          end;
        end;
      end;
    kTipoCliente:
      begin
        if edtTipoCliente.Text = '' then
          txtTipoCliente.Caption := 'TODOS LOS TIPOS CLIENTES'
        else
        begin
          txtTipoCliente.Caption := desTipoCliente( edtTipoCliente.Text );
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

function TFLDiasCobro.CamposVacios: boolean;
var
  dDesde, dHasta: TDateTime;
begin
        //Comprobamos que los campos esten todos con datos
  if STEmpresa.Caption = '' then
  begin
    ShowError('Falta el codigo de la planta o es incorrecto.');
    EEmpresa.SetFocus;
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

  if txtTipoCliente.Caption = '' then
  begin
    ShowError('El código del tipo cliente incorrecto.');
    edtTipoCliente.SetFocus;
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

function TFLDiasCobro.AbrirQuery: Boolean;
begin
  if qryFacturasCobros.Active then
  begin
    qryFacturasCobros.Cancel;
    qryFacturasCobros.Close;
  end;

    qryFacturasCobros.sql.Clear;

    qryFacturasCobros.SQL.Add(' select ');
    qryFacturasCobros.SQL.Add('         cta_cliente_c, cod_cliente_fc cliente_sal_f, nombre_c, ');
    qryFacturasCobros.SQL.Add('         cod_empresa_fac_fc empresa_f, fecha_factura_fc fecha_factura_f, ');
    qryFacturasCobros.SQL.Add('         n_factura_fc n_factura_f, moneda_fc moneda_f, importe_neto_fc importe_neto_f, ');
    qryFacturasCobros.SQL.Add('         fecha_vencimiento_rc fecha_remesa_fr, importe_cobrado_rf importe_cobrado_fr, ');
    qryFacturasCobros.SQL.Add('         case when importe_total_fc = 0 then 0 else round( importe_total_euros_fc / importe_total_fc, 5) end cambio ');
    qryFacturasCobros.SQL.Add('  from tfacturas_cab ');
    qryFacturasCobros.SQL.Add('       join tremesas_fac on cod_factura_fc = cod_factura_rf ');
    qryFacturasCobros.SQL.Add('       join tremesas_cab on empresa_remesa_rc = empresa_remesa_rf and n_remesa_rf = n_remesa_rc ');
    qryFacturasCobros.SQL.Add('       join frf_clientes  on cod_cliente_fc = cliente_c ');


    qryFacturasCobros.SQL.Add(' where fecha_factura_fc  between :fechaini and :fechafin ');

    if EEmpresa.Text <> '' then
    begin
      if EEmpresa.Text = 'BAG' then
        qryFacturasCobros.SQL.Add('   AND cod_empresa_fac_fc[1,1] = ''F'' ')
      else
      if EEmpresa.Text = 'SAT' then
        qryFacturasCobros.SQL.Add('   AND cod_empresa_fac_fc in (''050'',''080'') ')
      else
        qryFacturasCobros.SQL.Add('   AND cod_empresa_fac_fc = :empresa ');
    end;

    if ( edtCliente.Text <> '' ) then
    begin
      if chkExcluirCliente.Checked then
      begin
        qryFacturasCobros.SQL.Add(' AND cod_cliente_fc  <> :cliente   ');
      end
      else
      begin
        qryFacturasCobros.SQL.Add(' AND cod_cliente_fc  = :cliente   ');
      end;
    end;

    if ( edtTipoCliente.Text <> '' ) then
    begin
      if chkExcluirTipoCliente.Checked then
      begin
        qryFacturasCobros.SQL.Add(' and  tipo_cliente_c <> :tipocliente  ');
      end
      else
      begin
        qryFacturasCobros.SQL.Add(' and  tipo_cliente_c = :tipocliente  ');
      end;
    end;

    qryFacturasCobros.SQL.Add('  and anulacion_fc  <> 1 ');

    if edtPais.Text <> '' then
    begin
      qryFacturasCobros.SQL.Add('  AND   pais_c = :pais ');
    end
    else
    begin
      case cbbMercado.ItemIndex of
        1: qryFacturasCobros.SQL.Add('  AND pais_c = ' + QuotedStr('ES') + '  ');
        2: qryFacturasCobros.SQL.Add('  AND pais_c <> ' + QuotedStr('ES') + '  ');
        else begin {nada} end;
      end;
    end;

    if cbbTipo.ItemIndex  = 1 then
    begin
      qryFacturasCobros.SQL.Add('  AND tipo_factura_fc = 380  ');
    end
    else
    if cbbTipo.ItemIndex  = 2 then
    begin
      qryFacturasCobros.SQL.Add('  AND tipo_factura_fc = 381  ');
    end;

    qryFacturasCobros.SQL.Add(' order by cta_cliente_c, cliente_sal_f, empresa_f, fecha_factura_f, n_factura_f ');

    try
      with qryFacturasCobros do
      begin
        Close;
        if ( EEmpresa.Text <> 'BAG' ) AND ( EEmpresa.Text <> 'SAT' ) then
        begin
          if ( EEmpresa.Text <> '' ) then
            ParamByName('empresa').AsString := EEmpresa.Text;
        end;
        if ( edtCliente.Text <> '' ) then
          ParamByName('cliente').AsString := edtCliente.Text;
        if ( edtTipoCliente.Text <> '' ) then
          ParamByName('tipocliente').AsString := edtTipoCliente.Text;
        if edtPais.Text <> '' then
          ParamByName('pais').AsString := edtPais.Text;

        ParamByName('fechaini').AsDate := StrToDate(eFechaDesde.Text);
        ParamByName('fechafin').AsDate := StrToDate(eFechaHasta.Text);

        Open;
      end;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        raise;
      end;
    end;
  Result:= not qryFacturasCobros.IsEmpty;
end;

procedure TFLDiasCobro.cbbEstadoCobroChange(Sender: TObject);
begin
  //
end;

end.
