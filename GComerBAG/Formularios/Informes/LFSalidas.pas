unit LFSalidas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Menus, dxSkinsCore, dxSkinBlue, dxSkinBlueprint, dxSkinFoggy,
  dxSkinMoneyTwins, cxControls, cxContainer, cxEdit, cxTextEdit, cxButtons,
  SimpleSearch, dxSkinBlack, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFLSalidas = class(TForm)
    Panel1: TPanel;
    GBFecha: TGroupBox;
    Desde: TLabel;
    Label14: TLabel;
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
    edtFechaDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    edtFechaHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    edtCliente: TBEdit;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    RGNacionalidad: TRadioGroup;
    QSalidas: TQuery;
    Label4: TLabel;
    edtCentroSalida: TBEdit;
    BGBCentroSalida: TBGridButton;
    STCentroSalida: TStaticText;
    GBEnvase: TGroupBox;
    lblNombre1: TLabel;
    lblNombre2: TLabel;
    chkSepararProductos: TCheckBox;
    chkTotalesAlbaran: TCheckBox;
    chkValorarAlbaran: TCheckBox;
    txtCliente: TStaticText;
    btnCliente: TBGridButton;
    chkNoCliente: TCheckBox;
    ssEnvaseDesde: TSimpleSearch;
    edtEnvaseDesde: TcxTextEdit;
    edtEnvaseHasta: TcxTextEdit;
    ssEnvaseHasta: TSimpleSearch;
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
    procedure edtClienteChange(Sender: TObject);
    procedure chkNoClienteClick(Sender: TObject);
    procedure edtEnvaseDesdeExit(Sender: TObject);
    procedure edtEnvaseHastaExit(Sender: TObject);
    procedure ssEnvaseDesdeAntesEjecutar(Sender: TObject);
    procedure ssEnvaseHastaAntesEjecutar(Sender: TObject);

  private
    bPrimeraVez: boolean;

  public
    { Public declarations }
    sEmpresa, sCentroOrigen, sCentroSalida, sProducto: string;
    sCliente, sEnvaseIni, sEnvaseFin: string;
    dIni, dFin: TDateTime;
  end;

var
  FLSalidas: TFLSalidas;
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, CReportes, UDMConfig,
  CAuxiliarDB, LSalidas, DPreview, UDMBaseDatos, bTextUtils;

{$R *.DFM}

procedure TFLSalidas.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;
  if CamposVacios then
    Exit;

  QSalidas.SQL.Clear;
  QSalidas.SQL.Add(' SELECT empresa_sl, ');
  if ( sProducto = '' ) and ( not chkSepararProductos.Checked ) then
    QSalidas.SQL.Add('        '''' producto_sl, ')
  else
    QSalidas.SQL.Add('        producto_sl, ');

  QSalidas.SQL.Add('        cliente_sl cliente_sal_sc, fecha_sl, categoria_sl, SUM(cajas_sl)as cajas, ');
  QSalidas.SQL.Add('        SUM(kilos_sl)as kilos,n_albaran_sl, envase_sl, ');
  QSalidas.SQL.Add('        dir_sum_sc, SUM(euros(moneda_sc, fecha_sc, importe_neto_sl)) neto, ');
  QSalidas.SQL.Add('        sum( unidades_caja_sl * cajas_sl ) unidades ');

  if RGNacionalidad.ItemIndex = 2 then
    QSalidas.SQL.Add(' FROM frf_salidas_l, frf_salidas_c ')
  else
    QSalidas.SQL.Add(' FROM frf_salidas_l, frf_salidas_c, frf_clientes ');

  QSalidas.SQL.Add(' WHERE ');
  QSalidas.SQL.Add('         (empresa_sl = :empresa) ');

  if sCentroOrigen <> '' then
    QSalidas.SQL.Add('    AND  (centro_origen_sl = :CentroOrigen) ');
  if scentroSalida <> '' then
    QSalidas.SQL.Add('    AND  (centro_salida_sl = :centroSalida) ');

  QSalidas.SQL.Add('    AND  (fecha_sl BETWEEN :fecha_d AND :fecha_h) ');
  if sProducto <> '' then
    QSalidas.SQL.Add('   AND  (producto_sl = :producto) ');

  if sCliente <> '' then
  begin
    if not chkNoCliente.Checked then
      QSalidas.SQL.Add('    AND  (cliente_sl = :cliente ) ')
    else
      QSalidas.SQL.Add('    AND  (cliente_sl <> :cliente ) ');
  end;

  QSalidas.SQL.Add('    AND  (empresa_sc = :empresa) ');
  QSalidas.SQL.Add('    AND  (centro_salida_sc = centro_salida_sl) ');
  QSalidas.SQL.Add('    AND  (n_albaran_sc = n_albaran_sl) ');
  QSalidas.SQL.Add('    AND  (fecha_sc = fecha_sl) ');
  QSalidas.SQL.Add('    AND  (fecha_sc BETWEEN :fecha_d AND :fecha_h) ');

  QSalidas.SQL.Add('    AND  (envase_sl BETWEEN :envaseini AND :envasefin) ');

  if RGNacionalidad.ItemIndex <> 2 then
  begin
    QSalidas.SQL.Add('    AND  (cliente_c = cliente_sl) ');
    if RGNacionalidad.ItemIndex = 0 then
      QSalidas.SQL.Add('    AND  (pais_c <> ' + QuotedStr('ES') + ') ')
    else
      QSalidas.SQL.Add('    AND  (pais_c = ' + QuotedStr('ES') + ') ');
  end;

     //QSalidas.SQL.Add( '    AND  ( emp_procedencia_sl = ' + QuotedStr('501') + ') ' );
  QSalidas.SQL.Add(' and es_transito_sc <> 2 ');              //Tipo Salida: Devolucion   

  QSalidas.SQL.Add(' GROUP BY empresa_sl, producto_sl, cliente_sl,n_albaran_sl, fecha_sl, categoria_sl, envase_sl, dir_sum_sc ');
  QSalidas.SQL.Add(' ORDER BY empresa_sl, producto_sl, cliente_sl, dir_sum_sc, fecha_sl,n_albaran_sl,envase_sl ');

        //Le pasamos los parametros y abrimos la consulta principal
  with QSalidas do
  begin
    try
      Close;
      ParamByName('empresa').AsString := sEmpresa;

      if sCentroSalida <> '' then
        ParamByName('centroSalida').AsString := sCentroSalida;
      if sCentroOrigen <> '' then
        ParamByName('CentroOrigen').AsString := sCentroOrigen;
      if sProducto <> '' then
        ParamByName('producto').AsString := sProducto;

      if sCliente <> '' then
        ParamByName('cliente').AsString := sCliente;

      ParamByName('fecha_d').AsDateTime := dIni;
      ParamByName('fecha_h').AsDateTime := dFin;
      ParamByName('envaseini').AsString := sEnvaseIni;
      ParamByName('envasefin').AsString := sEnvaseFin;

      Open;
    except
      on E: Exception do
      begin
        ShowError('No se pueden abrir las tablas necesarias para elaborar el informe.');
        Exit;
      end;
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
  QRLSalidas := TQRLSalidas.Create(Application);
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
    QRLSalidas.bTotalesAlbaran:= chkTotalesAlbaran.Checked;
    PonLogoGrupoBonnysa(QRLSalidas, sEmpresa );
    case RGNacionalidad.ItemIndex of
      0:QRLSalidas.lblNacional.Caption:= Uppercase('Clientes Exportacion.');
      1:QRLSalidas.lblNacional.Caption:= Uppercase('Clientes Nacionales.');
      2:QRLSalidas.lblNacional.Caption:= Uppercase('Todos los Clientes.');
    end;

    QRLSalidas.qrlNeto.Enabled:= chkValorarAlbaran.Checked;
    QRLSalidas.qrsNeto1.Enabled:= chkValorarAlbaran.Checked;
    QRLSalidas.qreNeto1.Enabled:= chkValorarAlbaran.Checked;
    QRLSalidas.qrxNeto2.Enabled:= chkValorarAlbaran.Checked;
    QRLSalidas.qrxNeto3.Enabled:= chkValorarAlbaran.Checked;
    QRLSalidas.qrxNeto4.Enabled:= chkValorarAlbaran.Checked;
    QRLSalidas.qrxNeto5.Enabled:= chkValorarAlbaran.Checked;
    QRLSalidas.qrxNeto6.Enabled:= chkValorarAlbaran.Checked;

    Preview(QRLSalidas);
  finally
    QSalidas.Close;
  end;
end;

procedure TFLSalidas.FormClose(Sender: TObject;
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

procedure TFLSalidas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLSalidas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCentroOrigen.Tag := kCentro;
  edtCentroSalida.Tag := kCentro;
  edtProducto.Tag := kProducto;
  edtFechaDesde.Tag := kCalendar;
  edtFechaHasta.Tag := kCalendar;
  edtCliente.Tag := kCliente;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  if DMConfig.EsLaFont then
    RGNacionalidad.ItemIndex := 1
  else
    RGNacionalidad.ItemIndex := 2;

  bPrimeraVez:= True;
end;

procedure TFLSalidas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLSalidas.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [edtEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente, [edtEmpresa.Text]);
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
  end;
end;

procedure TFLSalidas.PonNombre(Sender: TObject);
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
  end;
end;

procedure TFLSalidas.ssEnvaseDesdeAntesEjecutar(Sender: TObject);
begin
    ssEnvaseDesde.SQLAdi := '';
    if edtProducto.Text <> '' then
      ssEnvaseDesde.SQLAdi := ' producto_e = ' +  QuotedStr(edtProducto.Text);
end;

procedure TFLSalidas.ssEnvaseHastaAntesEjecutar(Sender: TObject);
begin
    ssEnvaseHasta.SQLAdi := '';
    if edtProducto.Text <> '' then
      ssEnvaseHasta.SQLAdi := ' producto_e = ' +  QuotedStr(edtProducto.Text);
end;

procedure TFLSalidas.FormActivate(Sender: TObject);
begin
  Top := 1;
  ActiveControl := edtEmpresa;

  if bPrimeraVez then
  begin
    edtEmpresa.Text:= gsDefEmpresa;
    //ECentroOrigen.Text:= gsDefCentro;
    //ECentroSalida.Text:= gsDefCentro;
    edtProducto.Text:= '';
    edtProducto.OnChange( edtProducto );
    edtCliente.Text := '';
    edtCliente.OnChange( edtCliente );
    edtFechaDesde.Text := DateTostr(Date);
    edtFechaHasta.Text := DateTostr(Date);
    edtEnvaseDesde.Text := 'COM-00000';
    edtEnvaseHasta.Text := 'COM-99999';
    CalendarioFlotante.Date := Date;

    bPrimeraVez:= False;
  end;
end;

function TFLSalidas.CamposVacios: boolean;
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

  if STProducto.Caption = '' then
  begin
    ShowError('Falta o código de producto incorrecto.');
    edtProducto.SetFocus;
    Exit;
  end;
  sProducto:= edtProducto.Text;

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
    ShowError('Falta el código del cliente o es incorrecto.');
    edtCliente.SetFocus;
    Exit;
  end;
  sCliente:= trim( edtCliente.Text );

  if edtEnvaseDesde.Text = '' then
  begin
    ShowError('Falta el código del artículo.');
    edtEnvaseDesde.SetFocus;
    Exit;
  end;
  sEnvaseIni:= edtEnvaseDesde.Text;

  if edtEnvaseHasta.Text = '' then
  begin
    ShowError('Falta el código del artículo.');
    edtEnvaseHasta.SetFocus;
    Exit;
  end;
  sEnvaseFin:= edtEnvaseHasta.Text;

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

procedure TFLSalidas.edtClienteChange(Sender: TObject);
begin
  if Trim( edtCliente.Text ) = '' then
  begin
   txtCliente.Caption:= 'TODOS LOS CLIENTES';
  end
  else
  begin
    txtCliente.Caption:= desCliente( edtCliente.Text );
    if txtCliente.Caption <> '' then
    begin
      if chkNoCliente.Checked then
      begin
        txtCliente.Caption:= 'TODOS MENOS ' + txtCliente.Caption;
      end;
    end;
  end;
end;

procedure TFLSalidas.edtEnvaseDesdeExit(Sender: TObject);
begin
  if EsNumerico(edtEnvaseDesde.Text) and (Length(edtEnvaseDesde.Text) <= 5) then
    if (edtEnvaseDesde.Text <> '' ) and (Length(edtEnvaseDesde.Text) < 9) then
      edtEnvaseDesde.Text := 'COM-' + Rellena( edtEnvaseDesde.Text, 5, '0');
end;

procedure TFLSalidas.edtEnvaseHastaExit(Sender: TObject);
begin
  if EsNumerico(edtEnvaseHasta.Text) and (Length(edtEnvaseHasta.Text) <= 5) then
    if (edtEnvaseHasta.Text <> '' ) and (Length(edtEnvaseHasta.Text) < 9) then
      edtEnvaseHasta.Text := 'COM-' + Rellena( edtEnvaseHasta.Text, 5, '0');
end;

procedure TFLSalidas.chkNoClienteClick(Sender: TObject);
begin
  edtClienteChange( edtCliente );
end;

end.



