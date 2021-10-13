unit LFMovimientosEnvComerciales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DbTables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror;

type
  TFLMovimientosEnvComerciales = class(TForm)
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
    Label2: TLabel;
    edtEnvComer: TBEdit;
    lblCentro: TLabel;
    edtCentro: TBEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    btnEnvComer: TBGridButton;
    txtEnvComer: TStaticText;
    lblOperador: TLabel;
    edtOperador: TBEdit;
    btnOperador: TBGridButton;
    txtOperador: TStaticText;
    chkIN: TCheckBox;
    chkAJ: TCheckBox;
    chkEC: TCheckBox;
    chkETF: TCheckBox;
    chkSTC: TCheckBox;
    chkSTF: TCheckBox;
    chkSVF: TCheckBox;
    chkETC: TCheckBox;
    lblVer: TLabel;
    lbl2: TLabel;
    chkDesglosar: TCheckBox;
    chkDiario: TCheckBox;
    lbl3: TLabel;
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
     bIN, bAJ, bEC, bETC, bETF, bSTC, bSTF, bSVF: Boolean;
     bDiario, bDesglosar: Boolean;

    function CamposVacios: boolean;
    procedure Imprimir;
    procedure PutSQL( const ACentro, AOperador, AEnvaseComer: Boolean;
      const AIN, AAJ, AEC, AETC, AETF, ASTC, ASTF, ASVF, ADesglosar: Boolean );

  public
    { Public declarations }

  end;

var
  //FLSalidasEnvases: TFLSalidasEnvases;
  Autorizado: boolean;

implementation

uses UDMAuxDB, CVariables, DPreview, CReportes,
  CAuxiliarDB, Principal, LMovimientosEnvComerciales,
  UDMBaseDatos, bSQLUtils, UDMConfig, bTimeUtils;

{$R *.DFM}

procedure TFLMovimientosEnvComerciales.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  edtOperador.Tag := kEnvComerOperador;
  edtEnvComer.Tag := kEnvComerProducto;
  edtFechaDesde.Tag := kCalendar;
  edtFechaHasta.Tag := kCalendar;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  bPrimeraVez:= true;

  (*
  if not DMConfig.EsLaFont then
  begin
    chkIN.Enabled:= False;
    chkIN.Checked:= False;
    chkAJ.Enabled:= False;
    chkAJ.Checked:= False;
    chkEC.Enabled:= False;
    chkEC.Checked:= False;
    chkETC.Enabled:= False;
    chkETC.Checked:= False;
    chkSTC.Enabled:= False;
    chkSTC.Checked:= False;
  end;
  *)
end;

procedure TFLMovimientosEnvComerciales.FormActivate(Sender: TObject);
begin
  ActiveControl := edtEmpresa;
  Top := 10;
  if bPrimeraVez then
  begin
    edtEmpresa.Text:= gsDefEmpresa;
    edtCentro.Text:= '';
    edtOperador.Text:= '002';      //LOGIFRUIT
    dIni:= lunesAnterior( Date ) - 7;
    dFin:= dIni + 6;
    edtFechaDesde.Text := DateTostr( dIni );
    edtFechaHasta.Text := DateTostr( dFin );
    CalendarioFlotante.Date := Date;
    bPrimeraVez:= false;
  end;
end;

procedure TFLMovimientosEnvComerciales.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLMovimientosEnvComerciales.FormClose(Sender: TObject;
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

procedure TFLMovimientosEnvComerciales.ADesplegarRejillaExecute(Sender: TObject);
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
    kCentro: DespliegaRejilla(btnCentro, [edtEmpresa.Text]);
    kEnvComerProducto: DespliegaRejilla(btnEnvComer);
  end;
end;

procedure TFLMovimientosEnvComerciales.PonNombre(Sender: TObject);
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
    end;
    kCentro:
    begin
      if edtCentro.Text = '' then
        txtCentro.Caption := 'TODOS LOS CENTROS'
      else
        txtCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text );
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

procedure TFLMovimientosEnvComerciales.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if CamposVacios then Exit;

     //Llamamos al QReport
  Imprimir;
end;

procedure TFLMovimientosEnvComerciales.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLMovimientosEnvComerciales.CamposVacios: boolean;
begin

        //Comprobamos que los campos esten todos con datos
  if txtEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto.');
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
    ShowError('El código del centro es incorrecto.');
    edtCentro.SetFocus;
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


  bIN:= chkIN.Checked;
  bAJ:= chkAJ.Checked;
  bEC:= chkEC.Checked;
  bETC:= chkETC.Checked;
  bETF:= chkETF.Checked;
  bSTC:= chkSTC.Checked;
  bSTF:= chkSTF.Checked;
  bSVF:= chkSVF.Checked;
  if not( bIN or bAJ or bEC or bETC or bETF or bSTC or bSTF or bSVF ) then
  begin
    bIN:= chkIN.Enabled;
    bAJ:= chkAJ.Enabled;
    bEC:= chkEC.Enabled;
    bETC:= chkETC.Enabled;
    bETF:= True;
    bSTC:= chkSTC.Enabled;
    bSTF:= True;
    bSVF:= True;
  end;

  bDiario:= chkDiario.Checked;
  bDesglosar:= chkDesglosar.Checked;

  Result := False;

end;


procedure TFLMovimientosEnvComerciales.PutSQL( const ACentro, AOperador, AEnvaseComer: Boolean;
  const AIN, AAJ, AEC, AETC, AETF, ASTC, ASTF, ASVF, ADesglosar: Boolean );
var
  bFlag: Boolean;
begin
  bFlag:= false;
  with QRLMovimientosEnvComerciales.qryMovimientos do
  begin
    SQL.Clear;

    if AIN then
    begin
      SQL.Add('--stock ');
      SQL.Add('select empresa_ecs empresa, centro_ecs centro, cod_operador_ecs operador, cod_producto_ecs producto,  ');
      SQL.Add('       0 tipo, fecha_ecs fecha, '''' cliente, '''' almacen, 0 cantidad, stock_ecs stock,  ');
      SQL.Add('       ''INVENTARIO '' nota ');
      SQL.Add('from frf_env_comer_stocks ');
      SQL.Add('where empresa_ecs = :empresa ');
      if ACentro  then
        SQL.Add(' and centro_ecs = :centro ');
      SQL.Add('and fecha_ecs between :fechaini and :fechafin ');
      if AOperador then
        SQL.Add('and cod_operador_ecs = :operador ');
      if AEnvaseComer then
        SQL.Add('and cod_producto_ecs = :envcomer ');
      bFlag:= True;
    end;

    if AAJ then
    begin
      if bFlag then
       SQL.Add('union ');

      SQL.Add('--Ajustes/coreciones ');
      SQL.Add('select empresa_ecc empresa, centro_ecc centro, cod_operador_ecc operador, cod_producto_ecc producto,  ');
      SQL.Add('       1 tipo, fecha_ecc fecha, '''' cliente, '''' almacen, cantidad_ecc cantidad, 0 stock,  ');
      SQL.Add('       ''AJUSTES '' nota ');
      SQL.Add('from frf_env_comer_correcciones ');
      SQL.Add('where empresa_ecc = :empresa  ');
      if ACentro  then
        SQL.Add(' and centro_ecc = :centro ');
      SQL.Add('and fecha_ecc between :fechaini and :fechafin ');
      if AOperador then
        SQL.Add('and cod_operador_ecc = :operador ');
      if AEnvaseComer then
        SQL.Add('and cod_producto_ecc = :envcomer ');
      bFlag:= True;
    end;


    if AEC then
    begin
      if bFlag then
       SQL.Add('union ');

      SQL.Add('--entradas ');
      SQL.Add('select empresa_ece empresa, centro_ece centro, cod_operador_ece operador, cod_producto_ece producto,  ');
      SQL.Add('       2 tipo, fecha_ece fecha,  '''' cliente, cod_almacen_ece almacen, cantidad_ece cantidad, 0 stock,  ');
      SQL.Add('      ''ENTRADA: '' || nvl(referencia_ece,'''') ');
      SQL.Add('from frf_env_comer_entradas ');
      SQL.Add('where empresa_ece = :empresa  ');
      if ACentro  then
        SQL.Add(' and centro_ece = :centro ');
      SQL.Add('and fecha_ece between :fechaini and :fechafin ');
      if AOperador then
        SQL.Add('and cod_operador_ece = :operador ');
      if AEnvaseComer then
        SQL.Add('and cod_producto_ece = :envcomer ');
      bFlag:= True;
    end;

    if AETC then
    begin
      if bFlag then
       SQL.Add('union ');

      SQL.Add('--transitos - entradas ');
      SQL.Add('select planta_destino_ect empresa, centro_destino_ect centro, cod_operador_ect operador, cod_producto_ect producto,  ');
      SQL.Add('       3 tipo, fecha_ect fecha, '''' cliente, centro_ect almacen, cantidad_ect cantidad, 0 stock,  ');
      SQL.Add('      ''TRANSITO: '' || nvl(nota_ect,'''') ');
      SQL.Add('from frf_env_comer_transitos ');
      SQL.Add('where planta_destino_ect = :empresa ');
      if ACentro  then
        SQL.Add('and centro_destino_ect = :centro ');
      SQL.Add('and fecha_ect between :fechaini and :fechafin ');
      if AOperador then
        SQL.Add('and cod_operador_ect = :operador ');
      if AEnvaseComer then
        SQL.Add('and cod_producto_ect = :envcomer ');
      bFlag:= True;
    end;

    if AETF then
    begin
      if bFlag then
       SQL.Add('union ');
      SQL.Add('--entradas-transitos fruta cajas ');
      SQL.Add('select planta_destino_tc empresa, centro_destino_tc centro, env_comer_operador_e operador, env_comer_producto_e producto,  ');
      SQL.Add('       4 tipo, fecha_tl fecha, planta_origen_tc cliente, centro_tl almacen, sum(cajas_tl) cantidad, 0 stock,  ');

      if ADesglosar then
        SQL.Add('       ''TRANSITO: '' || empresa_tl || '' / '' || centro_tl || '' / '' ||  referencia_tl || '' - '' || fecha_tl nota ')
      else
        SQL.Add('       ''TRANSITO DE FRUTA'' nota ');

      SQL.Add('from frf_transitos_c, frf_transitos_l, frf_envases ');
      SQL.Add('where planta_destino_tc = :empresa ');
      if ACentro  then
        SQL.Add('and centro_destino_tc = :centro ');
      SQL.Add('and fecha_tc between :fechaini and :fechafin ');

      SQL.Add('and empresa_tl = :empresa ');
      SQL.Add('and centro_tl = centro_tc ');
      SQL.Add('and fecha_tl = fecha_tc ');
      SQL.Add('and referencia_tl = referencia_tc ');

      SQL.Add('and envase_tl = envase_e ');
      if AOperador then
        SQL.Add('and env_comer_operador_e = :operador ')
      else
        SQL.Add('and env_comer_operador_e is not null');
      if AEnvaseComer then
        SQL.Add('and env_comer_producto_e = :envcomer ');
      SQL.Add('group by 1,2,3,4,5,6,7,8,11');

      SQL.Add('union ');

      SQL.Add('--entradas-transitos fruta palets ');
      SQL.Add('select planta_destino_tc empresa, centro_destino_tc centro, env_comer_operador_tp operador, env_comer_producto_tp producto,  ');
      SQL.Add('       4 tipo, fecha_tl fecha, planta_origen_tc cliente, centro_tl almacen, sum(palets_tl) cantidad, 0 stock,  ');

      if ADesglosar then
        SQL.Add('       ''TRANSITO: '' || empresa_tl || '' / '' || centro_tl || '' / '' ||  referencia_tl || '' - '' || fecha_tl nota ')
      else
        SQL.Add('       ''TRANSITO DE FRUTA'' nota ');

      SQL.Add('from frf_transitos_c, frf_transitos_l, frf_tipo_palets ');
      SQL.Add('where planta_destino_tc = :empresa ');
      if ACentro  then
        SQL.Add('and centro_destino_tc = :centro ');
      SQL.Add('and fecha_tc between :fechaini and :fechafin ');

      SQL.Add('and empresa_tl = :empresa ');
      SQL.Add('and centro_tl = centro_tc ');
      SQL.Add('and fecha_tl = fecha_tc ');
      SQL.Add('and referencia_tl = referencia_tc ');

      SQL.Add('and tipo_palet_tl = codigo_tp ');
      if AOperador then
        SQL.Add('and env_comer_operador_tp = :operador ')
      else
        SQL.Add('and env_comer_operador_tp is not null');
      if AEnvaseComer then
        SQL.Add('and env_comer_producto_tp = :envcomer ');
      SQL.Add('group by 1,2,3,4,5,6,7,8,11');

      bFlag:= True;
    end;


    if ASTC then
    begin
      if bFlag then
       SQL.Add('union  ');

      SQL.Add('--transitos - salidas ');
      SQL.Add('select empresa_ect empresa, centro_ect centro, cod_operador_ect operador, cod_producto_ect producto,  ');
      SQL.Add('       5 tipo, fecha_ect fecha, '''' cliente, centro_destino_ect almacen, cantidad_ect * -1 cantidad, 0 stock,  ');
      SQL.Add('       ''TRANSITO: '' || nvl(nota_ect,'''') ');
      SQL.Add('from frf_env_comer_transitos ');
      SQL.Add('where empresa_ect = :empresa  ');
      if ACentro  then
        SQL.Add(' and centro_ect = :centro ');
      SQL.Add('and fecha_ect between :fechaini and :fechafin ');
      if AOperador then
        SQL.Add('and cod_operador_ect = :operador ');
      if AEnvaseComer then
        SQL.Add('and cod_producto_ect = :envcomer ');
      bFlag:= True;
    end;

    //solo salidas y tzansitos que tienen operador
    if ASVF then
    begin
      if bFlag then
       SQL.Add('union ');

      SQL.Add('--salidas-ventas cajas ');
      SQL.Add('select empresa_sl empresa, centro_salida_sl centro, env_comer_operador_e operador, env_comer_producto_e producto,  ');
      SQL.Add('       6 tipo, fecha_sl fecha, cliente_sal_sc cliente, dir_sum_sc almacen, sum(cajas_sl * -1) cantidad, 0 stock,  ');

      if ADesglosar then
         SQL.Add('       ''SALIDA: '' || empresa_sl || '' / '' || centro_salida_sl || '' / '' ||  n_albaran_sl || '' - '' || fecha_sl nota ')
      else
        SQL.Add('       ''SALIDA DE FRUTA'' nota ');

      SQL.Add('from frf_salidas_l, frf_envases, frf_salidas_c ');
      SQL.Add('where empresa_sl = :empresa  ');
      if ACentro  then
        SQL.Add(' and centro_salida_sl = :centro ');
      SQL.Add('and fecha_sl between :fechaini and :fechafin ');
      SQL.Add('and envase_sl = envase_e ');
      if AOperador then
        SQL.Add('and env_comer_operador_e = :operador ')
      else
        SQL.Add('and env_comer_operador_e is not null');
      if AEnvaseComer then
        SQL.Add('and env_comer_producto_e = :envcomer ');
      SQL.Add('and empresa_sc = :empresa  ');
      SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      SQL.Add('and fecha_sc = fecha_sl ');
      SQL.Add('and n_albaran_sc = n_albaran_sl ');
      SQL.Add('group by 1,2,3,4,5,6,7,8,11');

      SQL.Add('union ');

      SQL.Add('--salidas-ventas palets ');
      SQL.Add('select empresa_sl empresa, centro_salida_sl centro, env_comer_operador_tp operador, env_comer_producto_tp producto,  ');
      SQL.Add('       6 tipo, fecha_sl fecha, cliente_sal_sc cliente, dir_sum_sc almacen, sum(n_palets_sl * -1) cantidad, 0 stock,  ');

      if ADesglosar then
         SQL.Add('       ''SALIDA: '' || empresa_sl || '' / '' || centro_salida_sl || '' / '' ||  n_albaran_sl || '' - '' || fecha_sl nota ')
      else
        SQL.Add('       ''SALIDA DE FRUTA'' nota ');

      SQL.Add('from frf_salidas_l, frf_tipo_palets, frf_salidas_c ');
      SQL.Add('where empresa_sl = :empresa  ');
      if ACentro  then
        SQL.Add(' and centro_salida_sl = :centro ');
      SQL.Add('and fecha_sl between :fechaini and :fechafin ');
      SQL.Add('and tipo_palets_sl = codigo_tp ');
      if AOperador then
        SQL.Add('and env_comer_operador_tp = :operador ')
      else
        SQL.Add('and env_comer_operador_tp is not null');
      if AEnvaseComer then
        SQL.Add('and env_comer_producto_tp = :envcomer ');
      SQL.Add('and empresa_sc = :empresa and centro_salida_sc = centro_salida_sl ');
      SQL.Add('and fecha_sc = fecha_sl ');
      SQL.Add('and n_albaran_sc = n_albaran_sl ');
      SQL.Add('group by 1,2,3,4,5,6,7,8,11');

      bFlag:= True;
    end;

    if ASTF then
    begin
      if bFlag then
       SQL.Add('union ');

      SQL.Add('--salidas-transitos fruta cajas ');
      SQL.Add('select planta_origen_tc empresa, centro_tl centro, env_comer_operador_e operador, env_comer_producto_e producto,  ');
      SQL.Add('       7 tipo, fecha_tl fecha, planta_destino_tc cliente, centro_destino_tl almacen, sum(cajas_tl * -1) cantidad, 0 stock,  ');

      if ADesglosar then
        SQL.Add('       ''TRANSITO: '' || empresa_tl || '' / '' || centro_tl || '' / '' ||  referencia_tl || '' - '' || fecha_tl nota ')
      else
        SQL.Add('       ''TRANSITO DE FRUTA'' nota ');

      SQL.Add('from frf_transitos_c, frf_transitos_l, frf_envases ');
      SQL.Add('where planta_origen_tc = :empresa ');
      if ACentro  then
        SQL.Add('and centro_tc = :centro ');
      SQL.Add('and fecha_tc between :fechaini and :fechafin ');

      SQL.Add('and empresa_tl = :empresa ');
      SQL.Add('and centro_tl = centro_tc ');
      SQL.Add('and fecha_tl = fecha_tc ');
      SQL.Add('and referencia_tl = referencia_tc ');

      SQL.Add('and envase_tl = envase_e ');
      if AOperador then
        SQL.Add('and env_comer_operador_e = :operador ')
      else
        SQL.Add('and env_comer_operador_e is not null');
      if AEnvaseComer then
        SQL.Add('and env_comer_producto_e = :envcomer ');
      SQL.Add('group by 1,2,3,4,5,6,7,8,11');

      SQL.Add('union ');

      SQL.Add('--salidas-transitos fruta palets  ');
      SQL.Add('select planta_origen_tc empresa, centro_tl centro, env_comer_operador_tp operador, env_comer_producto_tp producto,  ');
      SQL.Add('       7 tipo, fecha_tl fecha, planta_destino_tc cliente, centro_destino_tl almacen, sum(palets_tl * -1) cantidad, 0 stock,  ');

      if ADesglosar then
        SQL.Add('       ''TRANSITO: '' || empresa_tl || '' / '' || centro_tl || '' / '' ||  referencia_tl || '' - '' || fecha_tl nota ')
      else
        SQL.Add('       ''TRANSITO DE FRUTA'' nota ');

      SQL.Add('from frf_transitos_c, frf_transitos_l, frf_tipo_palets ');
      SQL.Add('where planta_origen_tc = :empresa ');
      if ACentro  then
        SQL.Add('and centro_tc = :centro ');
      SQL.Add('and fecha_tc between :fechaini and :fechafin ');

      SQL.Add('and empresa_tl = :empresa ');
      SQL.Add('and centro_tl = centro_tc ');
      SQL.Add('and fecha_tl = fecha_tc ');
      SQL.Add('and referencia_tl = referencia_tc ');

      SQL.Add('and tipo_palet_tl = codigo_tp ');
      if AOperador then
        SQL.Add('and env_comer_operador_tp = :operador ')
      else
        SQL.Add('and env_comer_operador_tp is not null');
      if AEnvaseComer then
        SQL.Add('and env_comer_producto_tp = :envcomer ');
      SQL.Add('group by 1,2,3,4,5,6,7,8,11');

    end;

    SQL.Add('order by  empresa, centro, operador, producto, fecha, tipo  ');

  end;
end;

procedure TFLMovimientosEnvComerciales.Imprimir;
begin
   // Hacer la llamada al informe
  QRLMovimientosEnvComerciales := TQRLMovimientosEnvComerciales.Create(Application);
  PonLogoGrupoBonnysa(QRLMovimientosEnvComerciales, edtEmpresa.Text);

  with QRLMovimientosEnvComerciales.qryMovimientos do
  begin
    try
      Close;
      PutSQL( Trim(edtCentro.Text) <> '',  Trim(edtOperador.Text) <> '', Trim(edtEnvComer.Text) <> '',
              bIN, bAJ, bEC, bETC, bETF, bSTC, bSTF, bSVF, bDesglosar ) ;
      ParamByName('empresa').AsString:= edtEmpresa.Text;
      ParamByName('fechaini').AsDateTime:= dIni;
      ParamByName('fechafin').AsDateTime:= dFin;

      if Trim(edtCentro.Text) <> '' then
        ParamByName('centro').AsString:= edtCentro.Text;
      if Trim(edtOperador.Text) <> '' then
        ParamByName('operador').AsString:= edtOperador.Text;
      if Trim(edtEnvComer.Text) <> '' then
        ParamByName('envcomer').AsString:= edtEnvComer.Text;

      Open;

    except
      FreeAndNil( QRLMovimientosEnvComerciales );
      raise;
    end;
  end;

  QRLMovimientosEnvComerciales.lblPeriodo.Caption := edtFechaDesde.Text + ' a ' + edtFechaHasta.Text;
  QRLMovimientosEnvComerciales.sEmpresa := edtEmpresa.Text;
  QRLMovimientosEnvComerciales.bDiario := bDiario;
  if not QRLMovimientosEnvComerciales.qryMovimientos.isEmpty then
  begin
    Preview(QRLMovimientosEnvComerciales);
  end
  else
  begin
    FreeAndNil( QRLMovimientosEnvComerciales );
    Application.ProcessMessages;
    Application.MessageBox('Listado sin datos ..', Pchar(Application.title), MB_OK + MB_ICONINFORMATION);
  end;
end;

end.

