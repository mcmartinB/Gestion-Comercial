unit ResumenSalidasProductoFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlue,
  dxSkinBlueprint, dxSkinFoggy, dxSkinMoneyTwins, Menus, cxButtons,
  SimpleSearch, cxTextEdit, dxSkinBlack, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFLResumenSalidasProducto = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GBEmpresa: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    BGBCentroOrigen: TBGridButton;
    BGBProducto: TBGridButton;
    edtProducto: TBEdit;
    edtCentroOrigen: TBEdit;
    edtEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STCentroOrigen: TStaticText;
    STProducto: TStaticText;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    RGNacionalidad: TRadioGroup;
    QSalidas: TQuery;
    Label4: TLabel;
    edtCentroSalida: TBEdit;
    BGBCentroSalida: TBGridButton;
    STCentroSalida: TStaticText;
    chkTotalesAlbaran: TCheckBox;
    chkVerAlbaran: TCheckBox;
    chkSepararProductos: TCheckBox;
    chkVerCategoria: TCheckBox;
    lblCategoria: TLabel;
    edtCategoria: TBEdit;
    btnCategoria: TBGridButton;
    lbl1: TLabel;
    Desde: TLabel;
    edtFechaDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    edtFechaHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label5: TLabel;
    edtCliente: TBEdit;
    chkVerSuministro: TCheckBox;
    lblNombre1: TLabel;
    chkVerEnvase: TCheckBox;
    btnCliente: TBGridButton;
    txtCliente: TStaticText;
    txtEnvase: TStaticText;
    edtEnvase: TcxTextEdit;
    ssEnvase: TSimpleSearch;
    Label8: TLabel;
    edtAgrupacion: TBEdit;
    BGBAgrupacion: TBGridButton;
    STAgrupacion: TStaticText;
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
    procedure chkVerAlbaranClick(Sender: TObject);
    procedure edtEnvaseExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);

  private
    bPrimeraVez: boolean;

  public
    { Public declarations }
    sEmpresa, sCentroOrigen, sCentroSalida, sAgrupacion, sProducto, sCategoria, sCliente, sEnvase: string;
    dIni, dFin: TDateTime;
  end;

var
  FLResumenSalidasProducto: TFLResumenSalidasProducto;
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, CReportes, UDMConfig,  CGlobal,
  CAuxiliarDB, ResumenSalidasProductoQL, DPreview, UDMBaseDatos, bTextUtils;

{$R *.DFM}

procedure TFLResumenSalidasProducto.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;
  if CamposVacios then
    Exit;

  QSalidas.Close;
  QSalidas.SQL.Clear;

  if sEmpresa = 'SAT' then
    QSalidas.SQL.Add(' SELECT ''SAT'' empresa_sl, ')
  else
  if sEmpresa = 'BAG' then
    QSalidas.SQL.Add(' SELECT ''BAG'' empresa_sl, ')
  else
    QSalidas.SQL.Add(' SELECT empresa_sl, ');

  if ( sProducto = '' ) and ( not chkSepararProductos.Checked ) then
  begin
    QSalidas.SQL.Add('        '''' des_producto, '''' producto_sl,   ');
  end
  else
  begin
    QSalidas.SQL.Add('        ( select descripcion_p from frf_productos  ');
    QSalidas.SQL.Add('        where producto_p = producto_sl ) des_producto,  ');
    QSalidas.SQL.Add('        producto_sl, ');
  end;

  QSalidas.SQL.Add('        ( select pais_c from frf_clientes  ');
  QSalidas.SQL.Add('          where cliente_sl = cliente_c ) pais_sc,  ');
  QSalidas.SQL.Add('        cliente_sl cliente_sal_sc,  ');
  QSalidas.SQL.Add('        ( select nombre_c from frf_clientes ');
  QSalidas.SQL.Add('          where cliente_c = cliente_sl ) des_cliente, ');

  if chkVerSuministro.Checked then
  begin
    QSalidas.SQL.Add('        dir_sum_sc,  ');
    QSalidas.SQL.Add('        ( select nombre_ds from frf_dir_sum  ');
    QSalidas.SQL.Add('          where cliente_ds = cliente_sl and dir_sum_sc = dir_sum_ds ) des_suministro,  ');
  end
  else
  begin
    QSalidas.SQL.Add('        '''' dir_sum_sc,  ');
    QSalidas.SQL.Add('        '''' des_suministro,  ');
  end;

  if chkVerAlbaran.Checked then
    QSalidas.SQL.Add('        fecha_sl, n_albaran_sl,  ')
  else
    QSalidas.SQL.Add('        '''' fecha_sl, '''' n_albaran_sl,  ');

  if chkVerEnvase.Checked then
  begin
    QSalidas.SQL.Add('        envase_sl, ');
    QSalidas.SQL.Add('         ( select descripcion_e from frf_envases ');
    QSalidas.SQL.Add('           where envase_e = envase_sl ) des_envase,  ');
  end
  else
  begin
    QSalidas.SQL.Add('        '''' envase_sl,  ');
    QSalidas.SQL.Add('        '''' des_envase,  ');
  end;

  if chkVerCategoria.Checked then
    QSalidas.SQL.Add('        categoria_sl,  ')
  else
    QSalidas.SQL.Add('        '''' categoria_sl,  ');

  QSalidas.SQL.Add('        SUM(cajas_sl) as cajas, SUM(kilos_sl) as kilos ');

  if RGNacionalidad.ItemIndex = 2 then
    QSalidas.SQL.Add(' FROM frf_salidas_l, frf_salidas_c ')
  else
    QSalidas.SQL.Add(' FROM frf_salidas_l, frf_salidas_c, frf_clientes ');

  QSalidas.SQL.Add(' WHERE ');

  if sEmpresa = 'SAT' then
    QSalidas.SQL.Add('         (empresa_sl = ''050'' or empresa_sl = ''080'') ')
  else
  if sEmpresa = 'BAG' then
    QSalidas.SQL.Add('         (substr(empresa_sl,1,1) = ''F'') ')
  else
    QSalidas.SQL.Add('         (empresa_sl = :empresa) ');

  if sCentroOrigen <> '' then
    QSalidas.SQL.Add('    AND  (centro_origen_sl = :CentroOrigen) ');
  if scentroSalida <> '' then
    QSalidas.SQL.Add('    AND  (centro_salida_sl = :centroSalida) ');

  QSalidas.SQL.Add('    AND  (fecha_sl BETWEEN :fecha_d AND :fecha_h) ');

  if sAgrupacion <> '' then
    QSalidas.SQl.Add(' and producto_sl in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');
  if sProducto <> '' then
    QSalidas.SQL.Add('   AND  (producto_sl = :producto) ');
  if sCategoria <> '' then
    QSalidas.SQL.Add('   AND  (categoria_sl = :categoria) ');
  if sCliente <> '' then
    QSalidas.SQL.Add('    AND  (cliente_sl = :cliente ) ');

  QSalidas.SQL.Add('    AND  (empresa_sc = empresa_sl) ');
  if scentroSalida <> '' then
    QSalidas.SQL.Add('    AND  (centro_salida_sc = :centroSalida) ')
  else
    QSalidas.SQL.Add('    AND  (centro_salida_sc = centro_salida_sl) ');
  QSalidas.SQL.Add('    AND  (n_albaran_sc = n_albaran_sl) ');
  QSalidas.SQL.Add('    AND  (fecha_sc = fecha_sl) ');

  if sEnvase <> '' then
    QSalidas.SQL.Add('    AND  (envase_sl = :envase ) ');

  if RGNacionalidad.ItemIndex <> 2 then
  begin
    QSalidas.SQL.Add('    AND  (cliente_c = cliente_sl) ');
    if RGNacionalidad.ItemIndex = 0 then
      QSalidas.SQL.Add('    AND  (pais_c <> ' + QuotedStr('ES') + ') ')
    else
      QSalidas.SQL.Add('    AND  (pais_c = ' + QuotedStr('ES') + ') ');
  end;

  QSalidas.SQL.Add('  and es_transito_sc <> 2 ');      // Tipo Salida: Devolucion

  QSalidas.SQL.Add('  GROUP BY empresa_sl, 2,3,4,5,6,7,8,9,10,11,12,13 ');
  QSalidas.SQL.Add('  ORDER BY empresa_sl, 2,3,5,7,9,10,11,13 ');

        //Le pasamos los parametros y abrimos la consulta principal
    try
      if sCentroSalida <> '' then
        QSalidas.ParamByName('centroSalida').AsString := sCentroSalida;
      if sCentroOrigen <> '' then
        QSalidas.ParamByName('CentroOrigen').AsString := sCentroOrigen;
      if sAgrupacion <> '' then
        QSalidas.ParamByName('agrupacion').AsString := sAgrupacion;
      if sProducto <> '' then
        QSalidas.ParamByName('producto').AsString := sProducto;
      if sCategoria <> '' then
        QSalidas.ParamByName('categoria').AsString := sCategoria;

      if sCliente <> '' then
        QSalidas.ParamByName('cliente').AsString := sCliente;
      if sEnvase <> '' then
        QSalidas.ParamByName('envase').AsString := sEnvase;


      if ( sEmpresa <> 'SAT' ) and ( sEmpresa <> 'BAG' ) then
        QSalidas.ParamByName('empresa').AsString := sEmpresa;

      QSalidas.ParamByName('fecha_d').AsDateTime := dIni;
      QSalidas.ParamByName('fecha_h').AsDateTime := dFin;


      QSalidas.Open;
    except
      on E: Exception do
      begin
        ShowError('No se pueden abrir las tablas necesarias para elaborar el informe.');
        Exit;
      end;
    end;

        //Comprobar que no este vacia la tabla
  if QSalidas.IsEmpty then
  begin
    ShowError('No se han encontrado datos para los valores introducidos.');
    edtEmpresa.SetFocus;
    Exit;
  end;

        //Llamamos al QReport
  QRLSalidas := TQRLResumenSalidasProducto.Create(Application);
  try
    if Trim( sCentroOrigen) <> '' then
    begin
      QRLSalidas.sCentroOrigen := sCentroOrigen + '  ' + STCentroOrigen.Caption;
    end
    else
    begin
      QRLSalidas.sCentroOrigen := '';
    end;
    if Trim( sCentroSalida ) <> '' then
    begin
      QRLSalidas.scentroSalida := sCentroSalida + '  ' + STCentroSalida.Caption;
    end
    else
    begin
     QRLSalidas.scentroSalida := '';
    end;
    QRLSalidas.sFechaIni := edtFechaDesde.Text;
    QRLSalidas.sFechaFin := edtFechaHasta.Text;

    QRLSalidas.bImprimido := False;
    QRLSalidas.bProducto:= ( sProducto = '' ) and ( not chkSepararProductos.Checked ) ;
    QRLSalidas.bAlbaran:= chkVerAlbaran.Checked;
    QRLSalidas.bSuministro:= chkVerSuministro.Checked;
    QRLSalidas.bEnvase:= chkVerEnvase.Checked;
    QRLSalidas.bCategoria:= chkVerCategoria.Checked;
    QRLSalidas.bTotalesAlbaran:= chkTotalesAlbaran.Checked;
    PonLogoGrupoBonnysa(QRLSalidas, sEmpresa );
    case RGNacionalidad.ItemIndex of
      0:QRLSalidas.lblNacional.Caption:= Uppercase('Clientes Exportacion.');
      1:QRLSalidas.lblNacional.Caption:= Uppercase('Clientes Nacionales.');
      2:QRLSalidas.lblNacional.Caption:= Uppercase('Todos los Clientes.');
    end;
    Preview(QRLSalidas);
  finally
    QSalidas.Close;
  end;
end;

procedure TFLResumenSalidasProducto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bnCloseQuerys([QSalidas]);
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

procedure TFLResumenSalidasProducto.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLResumenSalidasProducto.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCentroOrigen.Tag := kCentro;
  edtCentroSalida.Tag := kCentro;
  edtAgrupacion.Tag := kAgrupacion;
  edtProducto.Tag := kProducto;
  edtCliente.Tag := kCliente;
  edtEnvase.Tag := kEnvase;
  edtCategoria.Tag := kCategoria;
  edtFechaDesde.Tag := kCalendar;
  edtFechaHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  PonNombre(edtAgrupacion);
  
  if DMConfig.EsLaFont then
    RGNacionalidad.ItemIndex := 1
  else
    RGNacionalidad.ItemIndex := 2;

  bPrimeraVez:= True;
end;

procedure TFLResumenSalidasProducto.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLResumenSalidasProducto.ADesplegarRejillaExecute(Sender: TObject);
begin
  if edtenvase.Focused then
    ssEnvase.Execute;
  

  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [edtEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente, [edtEmpresa.Text]);
//    kEnvase: DespliegaRejilla(btnEnvase, [edtEmpresa.Text]);
    kCategoria:
    begin
      if Trim(edtProducto.Text) = '' then
        ShowMessage('Seleccione primero un producto')
      else
        DespliegaRejilla(btnCategoria, [edtEmpresa.Text, edtProducto.Text]);
    end;
    kCentro:
    begin
      if edtCentroOrigen.Focused then
      begin
        DespliegaRejilla(BGBCentroOrigen, [edtEmpresa.Text]);
      end
      else
      begin
        DespliegaRejilla(BGBCentroSalida, [edtEmpresa.Text]);
      end;
    end;
    kCalendar:
      begin
        if edtFechaDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
    kAgrupacion: DespliegaRejilla(BGBAgrupacion);
  end;
end;

procedure TFLResumenSalidasProducto.PonNombre(Sender: TObject);
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
        STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
        PonNombre( edtCentroOrigen );
        PonNombre( edtCentroSalida );
        PonNombre( edtProducto );
        PonNombre( edtEnvase );
        PonNombre( edtCliente );
      end;
    kProducto:
    begin
      if edtProducto.Text = '' then
      begin
        STProducto.Caption := 'VACIO TODOS LOS PRODUCTOS.';
        chkSepararProductos.Enabled:= True;
      end
      else
      begin
        STProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
        chkSepararProductos.Enabled:= False;
      end;
    end;
    kCentro:
    begin
      if edtCentroSalida.Text = '' then
      begin
        STCentroSalida.Caption := 'VACIO TODOS LOS CENTROS.';
      end
      else
      begin
        STCentroSalida.Caption := desCentro(edtEmpresa.Text, edtCentroSalida.Text);
      end;
      if edtCentroOrigen.Text = '' then
      begin
        STCentroOrigen.Caption := 'VACIO TODOS LOS CENTROS.';
      end
      else
      begin
        STCentroOrigen.Caption := desCentro(edtEmpresa.Text, edtCentroOrigen.Text);
      end;
    end;
    kCliente:
    begin
      if edtCliente.Text = '' then
      begin
        txtCliente.Caption := 'VACIO TODOS LOS CLIENTES.';
      end
      else
      begin
        txtCliente.Caption := desCliente(edtCliente.Text);
      end;
    end;
    kEnvase:
    begin
      if edtEnvase.Text = '' then
      begin
        txtEnvase.Caption := 'VACIO TODOS LOS ARTICULOS.';
      end
      else
      begin
        txtEnvase.Caption := desEnvase(edtEmpresa.Text, edtEnvase.Text);
      end;
    end;
    kAgrupacion:
    begin

      if ( edtAgrupacion.Text = '' ) then
        STAgrupacion.Caption:= 'TODAS LAS AGRUPACIONES'
      else
        STAgrupacion.Caption := desAgrupacion(edtAgrupacion.Text);
    end;
  end;
end;

procedure TFLResumenSalidasProducto.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if edtProducto.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(edtProducto.Text);
end;

procedure TFLResumenSalidasProducto.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := edtEmpresa;

  if bPrimeraVez then
  begin
    edtFechaDesde.Text := DateTostr(Date);
    edtFechaHasta.Text := DateTostr(Date);
    if CGlobal.gProgramVersion = CGlobal.pvBAG then
      edtEmpresa.Text:= 'BAG'
    else
      edtEmpresa.Text:= 'SAT';
    //edtEmpresa.Text:= gsDefEmpresa;
    edtProducto.OnChange( edtProducto );
    edtAgrupacion.OnChange( edtAgrupacion );
    CalendarioFlotante.Date := Date;
    bPrimeraVez:= False;
  end;
end;

function TFLResumenSalidasProducto.CamposVacios: boolean;
begin
  Result := True;
  //Comprobamos que los campos esten todos con datos
  if STEmpresa.Caption = '' then
  begin
    ShowError('Falta o código de empresa incorrecto.');
    edtEmpresa.SetFocus;
    Exit;
  end;
  sEmpresa:= edtEmpresa.Text;

  if Trim( STAgrupacion.Caption ) = '' then
  begin
    ShowError('El código de agrupación es incorrecto');
    edtAgrupacion.SetFocus;
    Exit;
  end;
  sAgrupacion := edtAgrupacion.Text;

  if STProducto.Caption = '' then
  begin
    ShowError('Falta o código de producto incorrecto.');
    edtProducto.SetFocus;
    Exit;
  end;
  sProducto:= edtProducto.Text;
  sCategoria:= Trim( edtCategoria.Text );

  if STCentroOrigen.Caption = '' then
  begin
    ShowError('Falta o código de centro incorrecto.');
    edtCentroOrigen.SetFocus;
    Exit;
  end;
  sCentroOrigen:= edtCentroOrigen.Text;

  if STCentroSalida.Caption = '' then
  begin
    ShowError('Falta o código de centro incorrecto.');
    edtCentroSalida.SetFocus;
    Exit;
  end;
  sCentroSalida:= edtCentroSalida.Text;

  if txtCliente.Caption = '' then
  begin
    ShowError('El código del cliente es incorrecto.');
    edtCliente.SetFocus;
    Exit;
  end;
  sCliente:= edtCliente.Text;

  if txtEnvase.Caption = '' then
  begin
    ShowError('El código del artículo es incorrecto.');
    edtEnvase.SetFocus;
    Exit;
  end;
  sEnvase:= edtEnvase.Text;

  if not TryStrToDate( edtFechaDesde.Text, dIni ) then
  begin
    ShowError('Fecha de inicio incorrecta.');
    edtFechaDesde.SetFocus;
    Exit;
  end;
  if not TryStrToDate( edtFechaHasta.Text, dFin ) then
  begin
    ShowError('Fecha de fin incorrecta.');
    edtFechaHasta.SetFocus;
    Exit;
  end;
  if dFin < dIni then
  begin
    ShowError('rango de fechas incorrecto.');
    edtFechaDesde.SetFocus;
    Exit;
  end;

  Result := False;
end;

procedure TFLResumenSalidasProducto.chkVerAlbaranClick(Sender: TObject);
begin
  if chkVerAlbaran.Checked then
  begin
    chkTotalesAlbaran.Enabled:= True;
  end
  else
  begin
    chkTotalesAlbaran.Enabled:= False;
    chkTotalesAlbaran.Checked:= False;
  end;
end;

procedure TFLResumenSalidasProducto.edtEnvaseExit(Sender: TObject);
begin
  if EsNumerico(edtEnvase.Text) and (Length(edtEnvase.Text) <= 5) then
    if (edtEnvase.Text <> '' ) and (Length(edtEnvase.Text) < 9) then
      edtEnvase.Text := 'COM-' + Rellena( edtEnvase.Text, 5, '0');
end;

end.



