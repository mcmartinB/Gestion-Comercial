unit LFSalidasEnvases;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DbTables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror;

type
  TFLSalidasEnvases = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label1: TLabel;
    edtEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    lblDesde: TLabel;
    edtFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lbl1: TLabel;
    edtFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    Label5: TLabel;
    edtCliente: TBEdit;
    Label2: TLabel;
    edtEnvComer: TBEdit;
    lblCentro: TLabel;
    edtCentro: TBEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    lblProducto: TLabel;
    edtProducto: TBEdit;
    btnProducto: TBGridButton;
    txtProducto: TStaticText;
    lblDirSum: TLabel;
    edtDirSum: TBEdit;
    btnDirSum: TBGridButton;
    txtDirSum: TStaticText;
    btnCliente: TBGridButton;
    txtCliente: TStaticText;
    cbbAlbaranes: TComboBox;
    lblAlbaranes: TLabel;
    chkDesglosar: TCheckBox;
    btnEnvComer: TBGridButton;
    txtEnvComer: TStaticText;
    lblOperador: TLabel;
    edtOperador: TBEdit;
    btnOperador: TBGridButton;
    txtOperador: TStaticText;
    chkEnvase: TCheckBox;
    chkEnComer: TCheckBox;
    lblVer: TLabel;
    cbbVer: TComboBox;
    lblDestino: TLabel;
    edtDestino: TBEdit;
    btnDestino: TBGridButton;
    txtDestino: TStaticText;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);


  private
     { Private declarations}
     bPrimeraVez: boolean;
     dIni, dFin: TDateTime;

    function CamposVacios: boolean;
    procedure Imprimir;
    procedure PutTransitos;
    procedure PutSalidas;

  public
    { Public declarations }

  end;

var
  //FLSalidasEnvases: TFLSalidasEnvases;
  Autorizado: boolean;

implementation

uses UDMAuxDB, CVariables, DPreview, CReportes,
  CAuxiliarDB, Principal, LSalidasEnvases,
  UDMBaseDatos, bSQLUtils, UDMConfig, bTimeUtils;

{$R *.DFM}

procedure TFLSalidasEnvases.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  edtDestino.Tag := kCentro;
  edtProducto.Tag := kProducto;
  edtCliente.Tag := kCliente;
  edtDirSum.Tag := kSuministro;
  edtOperador.Tag := kEnvComerOperador;
  edtEnvComer.Tag := kEnvComerProducto;
  edtFechaDesde.Tag := kCalendar;
  edtFechaHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  bPrimeraVez:= true;
end;

procedure TFLSalidasEnvases.FormActivate(Sender: TObject);
begin
  ActiveControl := edtEmpresa;
  Top := 10;
  if bPrimeraVez then
  begin
    edtEmpresa.Text:= gsDefEmpresa;
    edtOperador.Text:= '002';      //LOGIFRUIT
    dIni:= lunesAnterior( Date ) - 7;
    dFin:= dIni + 6;
    edtFechaDesde.Text := DateTostr( dIni );
    edtFechaHasta.Text := DateTostr( dFin );
    CalendarioFlotante.Date := Date;
    bPrimeraVez:= false;
  end;
end;

procedure TFLSalidasEnvases.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLSalidasEnvases.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseAuxQuerys;
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

procedure TFLSalidasEnvases.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCalendar:
      begin
        if edtFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
    kCentro:
    begin
      if edtCentro.Focused then
        DespliegaRejilla(btnCentro, [edtEmpresa.Text])
      else
        DespliegaRejilla(btnDestino, [edtEmpresa.Text]);
    end;
    kProducto: DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente, [edtEmpresa.Text]);
    kSuministro: DespliegaRejilla(btnDirSum, [edtEmpresa.Text, edtCliente.Text]);
    kEnvComerProducto: DespliegaRejilla(btnEnvComer);
  end;
end;

procedure TFLSalidasEnvases.PonNombre(Sender: TObject);
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
      txtEmpresa.Caption := desEmpresa(edtEmpresa.Text);
      PonNombre( edtCentro );
      PonNombre( edtDestino );
      PonNombre( edtProducto );
      PonNombre( edtCliente );
      PonNombre( edtDirSum );
    end;
    kCentro:
    begin
      if TEdit(Sender).name= 'edtCentro' then
      begin
        if edtCentro.Text = '' then
          txtCentro.Caption := 'TODOS LOS CENTROS'
        else
          txtCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text );
      end
      else
      begin
        if edtDestino.Text = '' then
          txtDestino.Caption := 'TODOS LOS CENTROS - TRANSITOS'
        else
          txtDestino.Caption := desCentro(edtEmpresa.Text, edtDestino.Text );
      end;
    end;
    kProducto:
    begin
      if edtProducto.Text = '' then
        txtProducto.Caption := 'TODOS LOS PRODUCTOS'
      else
        txtProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text );
    end;
    kCliente:
    begin
      if edtCliente.Text = '' then
        txtCliente.Caption := 'TODOS LOS CLIENTES - SALIDAS'
      else
        txtCliente.Caption := desCliente(edtCliente.Text );
      PonNombre( edtDirSum );
    end;
    kSuministro:
    begin
      if edtDirSum.Text = '' then
        txtDirSum.Caption := 'TODOS LOS SUMINITROS - SALIDAS'
      else
        txtDirSum.Caption := desSuministro(edtEmpresa.Text, edtCliente.Text, edtDirSum.Text  );
    end;
    kEnvComerOperador:
    begin
      if edtOperador.Text = '' then
        txtOperador.Caption := 'TODOS LOS OPERADORES COMERCIALES'
      else
        txtOperador.Caption := desEnvComerOperador(edtOperador.Text  );
      PonNombre( edtEnvComer );
    end;
    kEnvComerProducto:
    begin
      if edtEnvComer.Text = '' then
        txtEnvComer.Caption := 'TODOS LOS ENVASES COMERCIALES'
      else
        txtEnvComer.Caption := desEnvComerProducto(edtOperador.Text, edtEnvComer.Text  );
    end;
  end;
end;

procedure TFLSalidasEnvases.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if CamposVacios then Exit;

     //Llamamos al QReport
  Imprimir;
end;

procedure TFLSalidasEnvases.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLSalidasEnvases.CamposVacios: boolean;
begin

        //Comprobamos que los campos esten todos con datos
  if txtEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto');
    edtEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDateTime( edtFechaDesde.Text, dIni ) then
  begin
    ShowError('La fecha de inicio es incorrecta.');
    edtFechaDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDateTime( edtFechaHasta.Text, dFin ) then
  begin
    ShowError('La fecha de fin es incorrecta.');
    edtFechaHasta.SetFocus;
    Result := True;
    Exit;
  end;

  if dIni > dFin  then
  begin
    ShowError('El rango de fechas es incorrecto.');
    edtFechaDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if txtCentro.Caption = '' then
  begin
    ShowError('El código del centro salida es incorrecto.');
    edtCentro.SetFocus;
    Result := True;
    Exit;
  end;

  if txtDestino.Caption = '' then
  begin
    ShowError('El código del centro destino es incorrecto.');
    edtDestino.SetFocus;
    Result := True;
    Exit;
  end;

  if txtProducto.Caption = '' then
  begin
    ShowError('El código del producto es incorrecto.');
    edtProducto.SetFocus;
    Result := True;
    Exit;
  end;

  if txtCliente.Caption = '' then
  begin
    ShowError('El código del cliente es incorrecto.');
    edtCliente.SetFocus;
    Result := True;
    Exit;
  end;

  if txtDirSum.Caption = '' then
  begin
    ShowError('El código del suministro es incorrecto.');
    edtDirSum.SetFocus;
    Result := True;
    Exit;
  end;

  if txtOperador.Caption = '' then
  begin
    ShowError('El código del operador comercial es incorrecto.');
    edtOperador.SetFocus;
    Result := True;
    Exit;
  end;

  if txtEnvComer.Caption = '' then
  begin
    ShowError('El código del envase comercial es incorrecto.');
    edtEnvComer.SetFocus;
    Result := True;
    Exit;
  end;


  Result := False;

end;

procedure TFLSalidasEnvases.PutTransitos;
begin
  with QRLSalidasEnvases.QSalidasEnvases do
  begin
    if ( cbbVer.ItemIndex = 0 ) or ( cbbVer.ItemIndex = 1 ) then
    begin
      SQL.Add('  SELECT nvl(env_comer_operador_e, -1) operador, ''T'' tipo, centro_destino_tc cliente, centro_destino_tc suministro, ');
      if chkDesglosar.Checked then
        SQL.Add('        referencia_tc albaran, fecha_tc fecha, ''0'' pedido, date(''01012019'') fecha_pedido, ')
      else
        SQL.Add('        0 albaran, ''1/1/2012'' fecha, ''0'' pedido, date(''01012019'') fecha_pedido, ');
      SQL.Add('        nvl(env_comer_producto_e, -1) envcomer, ');
      if chkEnvase.Checked then
        SQL.Add('        envase_e envase, descripcion_e descripcion, ')
      else
        SQL.Add('        0 envase, ''envase'' descripcion, ');
      SQL.Add('        SUM(cajas_tl) cajas ');

      SQL.Add('  FROM frf_transitos_c, frf_transitos_l, frf_envases');
      SQL.Add('  WHERE empresa_tc = :empresa ');
      SQL.Add('  AND   fecha_tc  between :fechaini and :fechafin ');
      SQL.Add('  AND   empresa_tl = :empresa ');
      SQL.Add('  and   centro_tl = centro_tc ');
      SQL.Add('  and   referencia_tl = referencia_tc ');
      SQL.Add('  and   fecha_tl =  fecha_tc ');
      SQL.Add('  AND   envase_e = envase_tl ');
      if chkEnComer.Checked then
        SQL.Add('  AND   env_comer_producto_e  is not null ');

      if Trim(edtCentro.Text) <> '' then
        SQL.Add('  AND   centro_tc = :centro ');
      if Trim(edtDestino.Text) <> '' then
        SQL.Add('  AND   centro_destino_tc = :destino ');
      if Trim(edtProducto.Text) <> '' then
        SQL.Add('  AND   producto_tl = :producto ');
      if Trim(edtOperador.Text) <> '' then
        SQL.Add('  AND   env_comer_operador_e = :operador ');
      if Trim(edtEnvComer.Text) <> '' then
        SQL.Add('  AND   env_comer_producto_e = :envcomer ');

      SQL.Add('   GROUP BY 1,2,3,4,5,6,7,8,9,10,11  ');
    end;

    if cbbVer.ItemIndex = 0 then
    begin
      SQL.Add('  union ');
    end;

    if ( cbbVer.ItemIndex = 0 ) or ( cbbVer.ItemIndex = 2 ) then
    begin
      SQL.Add('  SELECT nvl(env_comer_operador_tp, -1) operador, ''T'' tipo, centro_destino_tc cliente, centro_destino_tc suministro, ');
      if chkDesglosar.Checked then
        SQL.Add('        referencia_tc albaran, fecha_tc fecha, ''0'' pedido, date(''01012019'') fecha_pedido, ')
      else
        SQL.Add('        0 albaran, ''1/1/2012'' fecha, ''0'' pedido, date(''01012019'') fecha_pedido, ');
      SQL.Add('        nvl(env_comer_producto_tp, -2) envcomer, ');
      if chkEnvase.Checked then
        SQL.Add('        codigo_tp envase, descripcion_tp descripcion, ')
      else
        SQL.Add('        0 envase, ''envase'' descripcion, ');
      SQL.Add('        SUM(palets_tl) cajas ');

      SQL.Add('  FROM frf_transitos_c, frf_transitos_l, frf_tipo_palets ');

      SQL.Add('  WHERE empresa_tc = :empresa ');
      SQL.Add('  AND   fecha_tc  between :fechaini and :fechafin ');
      SQL.Add('  AND   empresa_tl = :empresa ');
      SQL.Add('  and   centro_tl = centro_tc ');
      SQL.Add('  and   referencia_tl = referencia_tc ');
      SQL.Add('  and   fecha_tl =  fecha_tc ');
      SQL.Add('  AND   codigo_tp = tipo_palet_tl ');
      if chkEnComer.Checked then
        SQL.Add('  AND   env_comer_producto_tp  is not null ');

      if Trim(edtCentro.Text) <> '' then
        SQL.Add('  AND   centro_tc = :centro ');
      if Trim(edtDestino.Text) <> '' then
        SQL.Add('  AND   centro_destino_tc = :destino ');
      if Trim(edtProducto.Text) <> '' then
        SQL.Add('  AND   producto_tl = :producto ');
      if Trim(edtOperador.Text) <> '' then
        SQL.Add('  AND   env_comer_operador_tp = :operador ');
      if Trim(edtEnvComer.Text) <> '' then
        SQL.Add('  AND   env_comer_producto_tp = :envcomer ');

      SQL.Add('   GROUP BY 1,2,3,4,5,6,7,8,9,10,11  ');
    end;
  end;
end;

procedure TFLSalidasEnvases.PutSalidas;
begin
  with QRLSalidasEnvases.QSalidasEnvases do
  begin
    if ( cbbVer.ItemIndex = 0 ) or ( cbbVer.ItemIndex = 1 ) then
    begin
      SQL.Add(' SELECT nvl(env_comer_operador_e, -1) operador, ''S'' tipo, cliente_sal_sc cliente,dir_sum_sc suministro, ');
      if chkDesglosar.Checked then
        SQL.Add('        n_albaran_sc albaran, fecha_sc fecha, n_pedido_sc pedido, fecha_pedido_sc fecha_pedido, ')
      else
        SQL.Add('        0 albaran, ''1/1/2012'' fecha, ''0'' pedido, date(''01012019'') fecha_pedido, ');
      SQL.Add('        nvl(env_comer_producto_e, -1) envcomer, ');
      if chkEnvase.Checked then
        SQL.Add('        envase_sl envase, descripcion_e descripcion, ')
      else
        SQL.Add('        0 envase, ''envase'' descripcion, ');
      SQL.Add('        SUM(cajas_sl  ) cajas ');
         SQL.Add('  FROM frf_salidas_c, frf_salidas_l, frf_envases ');

      SQL.Add('  WHERE empresa_sc = :empresa ');
      SQL.Add('  AND   fecha_sc  between :fechaini and :fechafin ');
      SQL.Add('  AND   empresa_sl = :empresa ');
      SQL.Add('  AND   centro_salida_sl = centro_salida_sc ');
      SQL.Add('  AND   n_albaran_sl = n_albaran_sc ');
      SQL.Add('  AND   fecha_sl = fecha_sc ');
      SQL.Add('  AND   envase_e = envase_sl ');
      if chkEnComer.Checked then
        SQL.Add('  AND   env_comer_producto_e  is not null ');

      if Trim(edtCentro.Text) <> '' then
        SQL.Add('  AND   centro_salida_sc = :centro ');
      if Trim(edtProducto.Text) <> '' then
        SQL.Add('  AND   producto_sl = :producto ');
      if Trim(edtCliente.Text) <> '' then
        SQL.Add('  AND   cliente_sal_sc = :cliente ');
      if Trim(edtDirSum.Text) <> '' then
        SQL.Add('  AND   dir_sum_sc = :suministro ');
      if Trim(edtOperador.Text) <> '' then
        SQL.Add('  AND   env_comer_operador_e = :operador ');
      if Trim(edtEnvComer.Text) <> '' then
        SQL.Add('  AND   env_comer_producto_e = :envcomer ');

       SQL.Add('  GROUP BY 1,2,3,4,5,6,7,8,9,10,11 ');
    end;

    if cbbVer.ItemIndex = 0 then
    begin
      SQL.Add('  union ');
    end;

    if ( cbbVer.ItemIndex = 0 ) or ( cbbVer.ItemIndex = 2 ) then
    begin
      SQL.Add('  SELECT nvl(env_comer_operador_tp, -1) operador, ''S'' tipo, cliente_sal_sc cliente, dir_sum_sc suministro, ');
      if chkDesglosar.Checked then
        SQL.Add('        n_albaran_sc albaran, fecha_sc fecha, n_pedido_sc pedido, fecha_pedido_sc fecha_pedido, ')
      else
        SQL.Add('        0 albaran, ''1/1/2012'' fecha, ''0'' pedido, date(''01012019'') fecha_pedido, ');
      SQL.Add('        nvl(env_comer_producto_tp, -2) envcomer, ');
      if chkEnvase.Checked then
        SQL.Add('        codigo_tp envase, descripcion_tp descripcion, ')
      else
        SQL.Add('        0 envase, ''envase'' descripcion, ');
      SQL.Add('        SUM(n_palets_sl) cajas ');

      SQL.Add('  FROM frf_salidas_c, frf_salidas_l, frf_tipo_palets ');

      SQL.Add('  WHERE empresa_sc = :empresa ');
      SQL.Add('  AND   fecha_sc  between :fechaini and :fechafin ');
      SQL.Add('  AND   empresa_sl = :empresa ');
      SQL.Add('  AND   centro_salida_sl = centro_salida_sc ');
      SQL.Add('  AND   n_albaran_sl = n_albaran_sc ');
      SQL.Add('  AND   fecha_sl = fecha_sc ');
      SQL.Add('  AND   codigo_tp = tipo_palets_sl ');
      if chkEnComer.Checked then
        SQL.Add('  AND   env_comer_producto_tp  is not null ');

      if Trim(edtCentro.Text) <> '' then
        SQL.Add('  AND   centro_salida_sc = :centro ');
      if Trim(edtProducto.Text) <> '' then
        SQL.Add('  AND   producto_sl = :producto ');
      if Trim(edtCliente.Text) <> '' then
        SQL.Add('  AND   cliente_sal_sc = :cliente ');
      if Trim(edtDirSum.Text) <> '' then
        SQL.Add('  AND   dir_sum_sc = :suministro ');
      if Trim(edtOperador.Text) <> '' then
        SQL.Add('  AND   env_comer_operador_tp = :operador ');
      if Trim(edtEnvComer.Text) <> '' then
        SQL.Add('  AND   env_comer_producto_tp = :envcomer ');

      SQL.Add('   GROUP BY 1,2,3,4,5,6,7,8,9,10,11  ');
    end;
  end;
end;

procedure TFLSalidasEnvases.Imprimir;
begin
   // Hacer la llamada al informe
  QRLSalidasEnvases := TQRLSalidasEnvases.Create(Application);
  PonLogoGrupoBonnysa(QRLSalidasEnvases, edtEmpresa.Text);

  with QRLSalidasEnvases.QSalidasEnvases do
  begin
    try
      Close;
      if ( cbbAlbaranes.ItemIndex = 0 ) or ( cbbAlbaranes.ItemIndex = 1 ) then
      begin
        PutSalidas;
      end;
      if ( cbbAlbaranes.ItemIndex = 0 )  then
        SQL.Add('  union ');
      if ( cbbAlbaranes.ItemIndex = 0 ) or ( cbbAlbaranes.ItemIndex = 2 ) then
      begin
        PutTransitos;
      end;
      SQL.Add('  ORDER BY operador, tipo, cliente, suministro, fecha, albaran, envcomer, envase');

      ParamByName('empresa').AsString:= edtEmpresa.Text;
      ParamByName('fechaini').AsDateTime:= dIni;
      ParamByName('fechafin').AsDateTime:= dFin;

      if Trim(edtCentro.Text) <> '' then
        ParamByName('centro').AsString:= edtCentro.Text;
      if Trim(edtProducto.Text) <> '' then
        ParamByName('producto').AsString:= edtProducto.Text;
      if Trim(edtOperador.Text) <> '' then
        ParamByName('operador').AsString:= edtOperador.Text;
      if Trim(edtEnvComer.Text) <> '' then
        ParamByName('envcomer').AsString:= edtEnvComer.Text;

      if ( cbbAlbaranes.ItemIndex = 0 ) or ( cbbAlbaranes.ItemIndex = 1 ) then
      begin
        if Trim(edtCliente.Text) <> '' then
          ParamByName('cliente').AsString:= edtCliente.Text;
        if Trim(edtDirSum.Text) <> '' then
          ParamByName('suministro').AsString:= edtDirSum.Text;
      end;
      if ( cbbAlbaranes.ItemIndex = 0 ) or ( cbbAlbaranes.ItemIndex = 2 ) then
      begin
        if Trim(edtDestino.Text) <> '' then
          ParamByName('destino').AsString:= edtDestino.Text;
      end;
      Open;

    except
      FreeAndNil( QRLSalidasEnvases );
      raise;
    end;
  end;

  QRLSalidasEnvases.bAlbaran:= chkDesglosar.Checked;
  QRLSalidasEnvases.bEnvase:= chkEnvase.Checked;
  QRLSalidasEnvases.lblPeriodo.Caption := edtFechaDesde.Text + ' a ' + edtFechaHasta.Text;
  QRLSalidasEnvases.sEmpresa := edtEmpresa.Text;
  if not QRLSalidasEnvases.QSalidasEnvases.isEmpty then
  begin
    Preview(QRLSalidasEnvases);
  end
  else
  begin
    FreeAndNil( QRLSalidasEnvases );
    Application.ProcessMessages;
    Application.MessageBox('Listado sin datos ..', Pchar(Application.title), MB_OK + MB_ICONINFORMATION);
  end;
end;

end.

