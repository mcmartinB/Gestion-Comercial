unit UFLTablaSalidas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton,
  DBTables, CheckLst, BDEdit, cxGraphics, cxControls, cxLookAndFeels,
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
  TFLTablaSalidas = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    LEmpresa: TLabel;
    btnEmpresa: TBGridButton;
    lblDesde: TLabel;
    btnDesde: TBCalendarButton;
    Label2: TLabel;
    Label1: TLabel;
    btnProducto: TBGridButton;
    Label3: TLabel;
    btnCentroSalida: TBGridButton;
    btnHasta: TBCalendarButton;
    Label4: TLabel;
    Label5: TLabel;
    lblGrupoPaises: TLabel;
    Label6: TLabel;
    lblTransportista: TLabel;
    btnTransportista: TBGridButton;
    lblCliente: TLabel;
    btnCliente: TBGridButton;
    edtEmpresa: TBEdit;
    STEmpresa: TStaticText;
    edtDesde: TBEdit;
    edtProducto: TBEdit;
    stProducto: TStaticText;
    edtCentroSalida: TBEdit;
    stCentroSalida: TStaticText;
    edtHasta: TBEdit;
    clbPaises: TCheckListBox;
    cbxPortes: TComboBox;
    cbxDestino: TComboBox;
    cbxAgrupacion: TComboBox;
    edtTransportista: TBEdit;
    stTransportista: TStaticText;
    edtCliente: TBEdit;
    stCliente: TStaticText;
    Label7: TLabel;
    edtCentroOrigen: TBEdit;
    btnCentroOrigen: TBGridButton;
    stCentroOrigen: TStaticText;
    Label8: TLabel;
    STEnvase: TStaticText;
    Label9: TLabel;
    edtPalet: TBEdit;
    btnPalet: TBGridButton;
    STpalet: TStaticText;
    Label10: TLabel;
    edtSuministro: TBEdit;
    btnSuministro: TBGridButton;
    stSuministro: TStaticText;
    Label11: TLabel;
    edtPais: TBEdit;
    btnPais: TBGridButton;
    stPais: TStaticText;
    Label12: TLabel;
    edtOperador: TBEdit;
    btnOperador: TBGridButton;
    stOperador: TStaticText;
    Label13: TLabel;
    edtMatricula: TBEdit;
    Label14: TLabel;
    edtCategoria: TBEdit;
    Label15: TLabel;
    edtCalibre: TBEdit;
    chkComerciales: TCheckBox;
    chkCentroSalida: TCheckBox;
    chkCentroOrigen: TCheckBox;
    chkPais: TCheckBox;
    chkCliente: TCheckBox;
    chkSuministro: TCheckBox;
    chkTransportista: TCheckBox;
    chkOperador: TCheckBox;
    chkMatricula: TCheckBox;
    chkProducto: TCheckBox;
    chkEnvase: TCheckBox;
    chkPalet: TCheckBox;
    chkCategoria: TCheckBox;
    chkCalibre: TCheckBox;
    chkpalets: TCheckBox;
    chkCajas: TCheckBox;
    chkUnidades: TCheckBox;
    chkKilos: TCheckBox;
    chkImporte: TCheckBox;
    cbbFacturado: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    cbbReclamacion: TComboBox;
    chkComunitario: TCheckBox;
    chkPortesPagados: TCheckBox;
    chkFacturado: TCheckBox;
    chkReclamacion: TCheckBox;
    qryTabla: TQuery;
    btnSeleccinar: TSpeedButton;
    btnDeseleccionar: TSpeedButton;
    lbl3: TLabel;
    chkBeef: TCheckBox;
    chkUnirTyE: TCheckBox;
    cbbImporte: TComboBox;
    lblVendedor: TLabel;
    edtVendedor: TBEdit;
    btnVendedor: TBGridButton;
    STVendedor: TStaticText;
    chkVendedor: TCheckBox;
    lblNombre2: TLabel;
    btnTipoSalida: TBGridButton;
    stTipoSalida: TStaticText;
    edtTipoSalida: TBEdit;
    cbxAgru2: TComboBox;
    chkExcluirInterplanta: TCheckBox;
    lbl: TLabel;
    edtDescargaDesde: TBEdit;
    edtDescargaHasta: TBEdit;
    lbl5: TLabel;
    BCalendarButton1: TBCalendarButton;
    BCalendarButton2: TBCalendarButton;
    chkExcluirDevolucion: TCheckBox;
    edtEnvase: TcxTextEdit;
    ssEnvase: TSimpleSearch;
    Label16: TLabel;
    edtAgrupacion: TBEdit;
    btnAgrupacion: TBGridButton;
    STAgrupacion: TStaticText;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure edtCentroSalidaChange(Sender: TObject);
    procedure cbxDestinoChange(Sender: TObject);
    procedure edtTransportistaChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtPaletChange(Sender: TObject);
    procedure edtPaisChange(Sender: TObject);
    procedure edtCentroOrigenChange(Sender: TObject);
    procedure edtSuministroChange(Sender: TObject);
    procedure edtOperadorChange(Sender: TObject);
    procedure edtEnvaseChange(Sender: TObject);
    procedure btnSeleccinarClick(Sender: TObject);
    procedure btnDeseleccionarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkProductoClick(Sender: TObject);
    procedure chkImporteClick(Sender: TObject);
    procedure edtVendedorChange(Sender: TObject);
    procedure edtTipoSalidaChange(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure edtEnvaseExit(Sender: TObject);
    procedure edtAgrupacionChange(Sender: TObject);

  private
    { Private declarations }
    dFechaIni, dFechaFin, dFechaDescargaIni, dFechaDescargaFin: TDateTime;
    sPaises: string;
    slPaises: TStringList;

    function  ValidarParametros: boolean;
    procedure DesProductoOptativo;
    procedure DesEnvaseOptativo;
    procedure DesComercialOptativo;
    procedure DespaletOptativo;
    procedure DesCentroSalidaOptativo;
    procedure DesCentroOrigenOptativo;
    procedure DesTransportistaOptativo;
    procedure DesOperadorOptativo;
    procedure DesPaisOptativo;
    procedure DesClienteOptativo;
    procedure DesSuministroOptativo;
    procedure DesTipoSalidaOptativo;

    procedure SeleccionarTodo( const ASelect: Boolean );

    procedure MontarQuery;
    procedure CargarParametros;
    function  ListaParametros: string;
    function  AbrirQuery: Boolean;
    procedure CerrarQuery;
  public
    { Public declarations }
  end;

implementation

uses UDMAuxDB, CVariables, Principal, CReportes,  CAuxiliarDB, DPreview,
     bTimeUtils, DateUtils, UDMBaseDatos, UFTransportistas, UQLTablaSalidas,
     CGlobal, UDMMaster, bTextUtils;


{$R *.DFM}

procedure TFLTablaSalidas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;


function TFLTablaSalidas.ValidarParametros: boolean;
var
  i: integer;
begin
  result:= False;
  dFechaDescargaIni := 0;
  dFechaDescargaFin := 0;
  //Comprobar parametros de entrada
  if STEmpresa.Caption = '' then
  begin
    MessageDlg('Falta o código de empresa incorrecto', mtError, [mbOk], 0);
    edtEmpresa.SetFocus;
    Exit;
  end;

  if not TryStrToDate( edtDesde.Text, dFechaIni ) then
  begin
    MessageDlg('Fecha de inicio incorrecta ...', mtError, [mbOk], 0);
    edtDesde.SetFocus;
    Exit;
  end;
  if not TryStrToDate( edtHasta.Text, dFechaFin ) then
  begin
    MessageDlg('Fecha de fin incorrecta ...', mtError, [mbOk], 0);
    edtHasta.SetFocus;
    Exit;
  end;
  if dFechaIni > dFechaFin then
  begin
    MessageDlg('Rango de fechas incorrecto ...', mtError, [mbOk], 0);
    edtDesde.SetFocus;
    Exit;
  end;

  if edtDescargaDesde.Text <> '' then
    if not TryStrToDate( edtDescargaDesde.Text, dFechaDescargaIni ) then
    begin
      MessageDlg('Fecha Descarga de inicio incorrecta ...', mtError, [mbOk], 0);
      edtDescargaDesde.SetFocus;
      Exit;
    end;

  if edtDescargaHasta.Text <> '' then
    if not TryStrToDate( edtDescargaHasta.Text, dFechaDescargaFin ) then
    begin
      MessageDlg('Fecha de fin incorrecta ...', mtError, [mbOk], 0);
      edtDescargaHasta.SetFocus;
      Exit;
    end;

  if (dFechaDescargaIni > dFechaDescargaFin) or
     ((dFechaDescargaIni = 0) and (dFechaDescargaFin > 0)) or
     ((dFechaDescargaFin = 0) and (dFechaDescargaIni > 0)) then
  begin
    MessageDlg('Rango de fechas de Descarga incorrecto ...', mtError, [mbOk], 0);
    edtDescargaDesde.SetFocus;
    Exit;
  end;

  if stCentroSalida.Caption = '' then
  begin
    MessageDlg('Código de centro incorrecto', mtError, [mbOk], 0);
    edtCentroSalida.SetFocus;
    Exit;
  end;

  if stCentroOrigen.Caption = '' then
  begin
    MessageDlg('Código de centro incorrecto', mtError, [mbOk], 0);
    edtCentroOrigen.SetFocus;
    Exit;
  end;

  if stPais.Caption = '' then
  begin
    MessageDlg('Código de país incorrecto', mtError, [mbOk], 0);
    edtPais.SetFocus;
    Exit;
  end;
  sPaises:= '';
  if ( cbxDestino.ItemIndex = 6 ) and ( edtPais.Text = '' ) then
  begin
    for i:= 0 to clbPaises.Items.Count -1 do
    begin
      if clbPaises.Checked[i] then
      begin
        if sPaises = '' then
          sPaises:= '''' + slPaises[i] + ''''
        else
          sPaises:= sPaises + ',''' + slPaises[i] + '''';
      end;
    end;
    if sPaises = '' then
    begin
      MessageDlg('Falta seleccionar los paises.', mtError, [mbOk], 0);
      clbPaises.SetFocus;
      Exit;
    end;
  end;


  if stCliente.Caption = '' then
  begin
    MessageDlg('Código de cliente incorrecto', mtError, [mbOk], 0);
    edtCliente.SetFocus;
    Exit;
  end;

  if stSuministro.Caption = '' then
  begin
    MessageDlg('Código de suministro incorrecto', mtError, [mbOk], 0);
    edtSuministro.SetFocus;
    Exit;
  end;

  if stTransportista.Caption = '' then
  begin
    MessageDlg('Código de transportista incorrecto', mtError, [mbOk], 0);
    edtTransportista.SetFocus;
    Exit;
  end;

  if stOperador.Caption = '' then
  begin
    MessageDlg('Código de operador incorrecto', mtError, [mbOk], 0);
    edtOperador.SetFocus;
    Exit;
  end;

  if Trim( STAgrupacion.Caption ) = '' then
  begin
    MessageDlg('El código de agrupación es incorrecto', mtError, [mbOk], 0);
    edtAgrupacion.SetFocus;
    Exit;
  end;

  if STProducto.Caption = '' then
  begin
    MessageDlg('Código de producto incorrecto', mtError, [mbOk], 0);
    edtProducto.SetFocus;
    Exit;
  end;

  if STEnvase.Caption = '' then
  begin
    MessageDlg('Código de envase incorrecto', mtError, [mbOk], 0);
    edtEnvase.SetFocus;
    Exit;
  end;

  if STVendedor.Caption = '' then
  begin
    MessageDlg('Código del comercial incorrecto', mtError, [mbOk], 0);
    edtVendedor.SetFocus;
    Exit;
  end;

  if STpalet.Caption = '' then
  begin
    MessageDlg('Código de palet incorrecto', mtError, [mbOk], 0);
    edtPalet.SetFocus;
    Exit;
  end;

  if stTipoSalida.Caption = '' then
  begin
    MessageDlg('Código de Tipo Salida incorrecto', mtError, [mbOk], 0);
    edtTipoSalida.SetFocus;
    Exit;
  end;

  result:= True;
end;

function TFLTablaSalidas.ListaParametros: string;
begin
  result:= 'Empresa ' + edtEmpresa.Text;
  result:= result + ' del ' + edtDesde.Text + ' al ' + edtHasta.Text;
  result:= result + ' agrupado por ' + cbxAgrupacion.Text;
  Result:= Result + ' || ' + cbxAgru2.Text;
  if edtCentroSalida.Text <> '' then
  begin
    result:= result + ' || Centro Salida= ' + edtCentroSalida.Text;
  end;
  if edtCentroOrigen.Text <> '' then
  begin
    result:= result + ' || Centro Origen= ' + edtCentroOrigen.Text;
  end;
  if sPaises <> '' then
  begin
    result:= result + ' || Paises= ' + sPaises;
  end
  else
  if edtPais.Text <> '' then
  begin
    result:= result + ' || País= ' + edtPais.Text;
  end
  else
  begin
    result:= result + ' || Destino= ' + cbxDestino.Text;
  end;
  if edtCliente.Text <> '' then
  begin
    result:= result + ' || Cliente= ' + edtCliente.Text;
  end;
  if edtSuministro.Text <> '' then
  begin
    result:= result + ' || Suministro= ' + edtSuministro.Text;
  end;
  if edtTransportista.Text <> '' then
  begin
    result:= result + ' || Transportista= ' + edtTransportista.Text;
  end;
  if edtOperador.Text <> '' then
  begin
    result:= result + ' || Operador= ' + edtOperador.Text;
  end;
  if edtMatricula.Text <> '' then
  begin
    result:= result + ' || Matrícula= ' + edtMatricula.Text;
  end;
  if cbxPortes.ItemIndex>0 then
  begin
    result:= result + ' || Portes= ' + cbxPortes.Text;
  end;
  if edtProducto.Text <> '' then
  begin
    if chkUnirTyE.Checked then
    begin
      if ( edtProducto.Text = 'TOM' ) or ( edtProducto.Text = 'TOM' )  then
      begin
        result:= result + ' || Producto= TOM' ;
      end
      else
      begin
        result:= result + ' || Producto= ' + edtProducto.Text;
      end;
    end
    else
    begin
      result:= result + ' || Producto= ' + edtProducto.Text;
    end;
  end;
  if edtEnvase.Text <> '' then
  begin
    result:= result + ' || Envase= ' + edtEnvase.Text;
  end;
  if edtVendedor.Text <> '' then
  begin
    result:= result + ' || Comercial= ' + edtVendedor.Text;
  end;
  if edtPalet.Text <> '' then
  begin
    result:= result + ' || Palet= ' + edtPalet.Text;
  end;
  if edtCategoria.Text <> '' then
  begin
    result:= result + ' || Categoría= ' + edtCategoria.Text;
  end;
  if edtCalibre.Text <> '' then
  begin
    result:= result + ' || Calibre= ' + edtCalibre.Text;
  end;
  if cbbFacturado.ItemIndex>0 then
  begin
    result:= result + ' || Facturado= ' + cbbFacturado.Text;
  end;
  if cbbReclamacion.ItemIndex>0 then
  begin
    result:= result + ' || Reclamación= ' + cbbReclamacion.Text;
  end;
  if chkImporte.Checked then
  begin
    if cbbImporte.ItemIndex = 0 then
      result:= result + #13 + #10 + 'NOTA: Los importes son antes de impuestos y estan en euros, se aplica el cambio grabado en la fecha del albarán.'
    else
      result:= result + #13 + #10 + 'NOTA: Los importes son en euros y impuestos includos, se aplica el cambio grabado en la fecha del albarán.';
  end;

  if edtTipoSalida.Text <> '' then
  begin
    result:= result + ' || Tipo Salida= ' + edtTipoSalida.Text;
  end;

  if chkExcluirInterplanta.checked then
    result := result + ' || Excluir Interplanta';

  if chkExcluirDevolucion.checked and chkExcluirDevolucion.Enabled then
    result := result + ' || Excluir Devolucion';

end;

procedure TFLTablaSalidas.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ValidarParametros then
  begin
    MontarQuery;
    if AbrirQuery then
    begin
      try
        //with UQLTablaSalidas do
        begin
          bCentroSalida :=  chkCentroSalida.Checked;
          bCentroOrigen :=  chkCentroOrigen.Checked;
          bPais :=  chkPais.Checked;
          bCliente :=  chkCliente.Checked;
          bSuministro :=  chkSuministro.Checked;
          bTransportista :=  chkTransportista.Checked;
          bOperador :=  chkOperador.Checked;
          bMatricula :=  chkMatricula.Checked;
          bProducto :=  chkProducto.Checked;
          bEnvase :=  chkEnvase.Checked;
          bComercial :=  chkVendedor.Checked;
          bPalet :=  chkPalet.Checked;
          bCategoria :=  chkCategoria.Checked;
          bCalibre :=  chkCalibre.Checked;
          bpalets :=  chkpalets.Checked;
          bCajas :=  chkCajas.Checked;
          bUnidades :=  chkUnidades.Checked;
          bKilos :=  chkKilos.Checked;
          bImporte :=  chkImporte.Checked;
          bComunitario :=  chkComunitario.Checked;
          bPortesPagados :=  chkPortesPagados.Checked;
          bFacturado :=  chkFacturado.Checked;
          bReclamacion :=  chkReclamacion.Checked;
          iGrupo:= cbxAgrupacion.ItemIndex;
          iGrupo2:= cbxAgru2.ItemIndex;
          sParametros:= ListaParametros;
        end;
        UQLTablaSalidas.VerListado( self );
      finally
        CerrarQuery;
      end;
    end
    else
    begin
      CerrarQuery;
      ShowMessage('Sin datos para los parametros seleccionados.');
    end;
  end;
end;

procedure TFLTablaSalidas.FormActivate(Sender: TObject);
begin
  Top:= 0;
end;

procedure TFLTablaSalidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  FreeAndNil( slPaises );
  Action := caFree;
end;

procedure TFLTablaSalidas.FormCreate(Sender: TObject);
var
  i: integer;
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCentroOrigen.Tag := kCentro;
  edtCentroSalida.Tag := kCentro;
  edtPais.Tag := kPais;
  edtCliente.Tag := kCliente;
  edtSuministro.Tag := kSuministro;
  edtTransportista.Tag:= kTransportista;
  edtOperador.Tag:= kTransportista;
  edtAgrupacion.Tag:= kAgrupacion;
  edtProducto.Tag := kProducto;
  edtEnvase.Tag := kEnvase;
  edtVendedor.Tag := kComercial;
  edtPalet.Tag := kTipoPalet;
  edtDesde.Tag := kCalendar;
  edtHasta.Tag := kCalendar;
  edtTipoSalida.Tag := kTipoSalida;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

  //edtEmpresa.Text := gsDefEmpresa;
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    edtEmpresa.Text := 'BAG'
  else
    edtEmpresa.Text := 'SAT';
  DesPaisOptativo;
  DespaletOptativo;

  dFechaIni:= LunesAnterior( Date ) - 6;
  CalendarioFlotante.Date := dFechaIni;
  edtDesde.Text:= DateToStr( dFechaIni );
  dFechaFin:= Date;
  edtHasta.Text:= DateToStr( dFechaFin );

  slPaises:= TStringList.Create;
  i:= 0;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select descripcion_p, pais_c ');
    SQL.Add(' from frf_clientes, frf_paises ');
    SQL.Add(' where pais_c = pais_p ');
    SQL.Add(' group by descripcion_p, pais_c ');
    SQL.Add(' order by descripcion_p, pais_c ');
    Open;
    while not EOF do
    begin
      slPaises.Add( FieldByName('pais_c').AsString );
      clbPaises.Items.Add( FieldByName('descripcion_p').AsString + ' [' +FieldByName('pais_c').AsString + ']');
      clbPaises.Checked[i]:= ( FieldByName('pais_c').AsString = 'GB' ) or
         ( FieldByName('pais_c').AsString = 'DE' );
      Next;
      Inc(i);
    end;
    Close;
  end;

  chkUnirTyE.Enabled:= ( CGlobal.gProgramVersion = CGlobal.pvSAT );
  chkBeef.Visible:= chkUnirTyE.Enabled;


  chkComerciales.Visible:= gProgramVersion = pvSAT;

  edtVendedorChange( edtVendedor );
  edtAgrupacionChange(edtagrupacion);

end;

procedure TFLTablaSalidas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
  end;
end;

procedure TFLTablaSalidas.ADesplegarRejillaExecute(Sender: TObject);
var
  sAux: string;
begin
  if edtEnvase.Focused then
    ssEnvase.Execute;
  

  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: begin
      if edtCentroSalida.Focused then
        DespliegaRejilla(btnCentroSalida,[edtEmpresa.Text])
      else
        DespliegaRejilla(btnCentroOrigen,[edtEmpresa.Text]);
    end;
    kTransportista: //DespliegaRejilla(btnTransportista);
    begin
      if edtTransportista.Focused then
      begin
        sAux:= edtTransportista.Text;
        if SeleccionaTransportista( self, edtTransportista, edtEmpresa.Text, sAux ) then
        begin
          edtTransportista.Text:= sAux;
        end;
      end
      else
      begin
        sAux:= edtOperador.Text;
        if SeleccionaTransportista( self, edtOperador, edtEmpresa.Text, sAux ) then
        begin
          edtOperador.Text:= sAux;
        end;
      end;
    end;
    kCliente: DespliegaRejilla(btnCliente,[edtEmpresa.Text]);
    kPais: DespliegaRejilla(btnPais);
    kSuministro: DespliegaRejilla(btnSuministro,[edtCliente.Text]);
    kAgrupacion: DespliegaRejilla(btnAgrupacion);
    kProducto: DespliegaRejilla(btnProducto,[edtEmpresa.Text]);
//    kEnvase: DespliegaRejilla(btnEnvase,[edtEmpresa.Text]);
    kComercial:
    begin
      DespliegaRejilla( btnVendedor, ['']);
    end;
    kTipoPalet: DespliegaRejilla(btnPalet);
    kCalendar:
    begin
      if edtDesde.Focused then
        DespliegaCalendario(btnDesde)
      else
        DespliegaCalendario(btnHasta);
    end;
    kTipoSalida: DespliegaRejilla(btnTipoSalida);
  end;
end;

procedure TFLTablaSalidas.DesProductoOptativo;
begin
  if edtProducto.Text = '' then
  begin
    stProducto.Caption := 'TODOS LOS PRODUCTOS';
  end
  else
  begin
    stProducto.Caption := desProducto(edtEmpresa.Text, edtProducto.Text);
  end;
end;


procedure TFLTablaSalidas.DesEnvaseOptativo;
begin
  if edtEnvase.Text = '' then
  begin
    stEnvase.Caption := 'TODOS LOS ARTICULOS';
  end
  else
  begin
    stEnvase.Caption := desEnvase(edtEmpresa.Text, edtEnvase.Text);
  end;
end;

procedure TFLTablaSalidas.DesComercialOptativo;
begin
  if edtVendedor.Text = '' then
  begin
    STVendedor.Caption := 'TODOS LOS COMERCIALES';
  end
  else
  begin
    STVendedor.Caption := desComercial( edtVendedor.Text );
  end;
end;

procedure TFLTablaSalidas.DesPaletOptativo;
begin
  if edtPalet.Text = '' then
  begin
    stPalet.Caption := 'TODOS LOS PALETS';
  end
  else
  begin
    stPalet.Caption := desTipoPalet(edtPalet.Text);
  end;
end;

procedure TFLTablaSalidas.DesCentroSalidaOptativo;
begin
  if edtCentroSalida.Text = '' then
  begin
    stCentroSalida.Caption := 'TODOS LOS CENTROS';
  end
  else
  begin
    stCentroSalida.Caption := desCentro(edtempresa.Text, edtCentroSalida.Text);
  end;
end;

procedure TFLTablaSalidas.DesCentroOrigenOptativo;
begin
  if edtCentroOrigen.Text = '' then
  begin
    stCentroOrigen.Caption := 'TODOS LOS CENTROS';
  end
  else
  begin
    stCentroOrigen.Caption := desCentro(edtEmpresa.Text, edtCentroOrigen.Text);
  end;
end;

procedure TFLTablaSalidas.DesClienteOptativo;
begin
  if edtCliente.Text = '' then
  begin
    stCliente.Caption := 'TODOS LOS CLIENTES';
  end
  else
  begin
    stCliente.Caption := desCliente(edtCliente.Text);
  end;
end;

procedure TFLTablaSalidas.DesSuministroOptativo;
begin
  if edtSuministro.Text = '' then
  begin
    stSuministro.Caption := 'TODOS LOS SUMINISTROS';
  end
  else
  begin
    stSuministro.Caption := desSuministro(edtEmpresa.Text, edtCliente.Text, edtSuministro.Text);
  end;
end;

procedure TFLTablaSalidas.DesPaisOptativo;
begin
  if edtPais.Text = '' then
  begin
    stPais.Caption := 'TODOS LOS PAISES';
  end
  else
  begin
    stPais.Caption := desPais( edtPais.Text);
  end;
end;

procedure TFLTablaSalidas.DesTipoSalidaOptativo;
begin
  if edtTipoSalida.Text = '' then
  begin
    stTipoSalida.Caption := 'TODOS LOS TIPOS DE SALIDAS';
  end
  else
  begin
    stTipoSalida.Caption := desTipoSalida(edtTipoSalida.Text);
  end;
end;

procedure TFLTablaSalidas.DesTransportistaOptativo;
begin
  if edtTransportista.Text = '' then
  begin
    stTransportista.Caption := 'TODOS LOS TRANSPORTISTAS';
  end
  else
  begin
    stTransportista.Caption := desTransporte(edtEmpresa.Text, edtTransportista.Text);
  end;
end;

procedure TFLTablaSalidas.DesOperadorOptativo;
begin
  if edtOperador.Text = '' then
  begin
    stOperador.Caption := 'TODOS LOS OPERADORES';
  end
  else
  begin
    stOperador.Caption := desTransporte(edtEmpresa.Text, edtOperador.Text);
  end;
end;

procedure TFLTablaSalidas.edtEmpresaChange(Sender: TObject);
begin
  if edtEmpresa.Text = 'BAG' then
  begin
    //Todas las que empiezan por F
    STEmpresa.Caption := 'BONNYSA AGROALIMENTARIA (Fxx)';
  end
  else
  if edtEmpresa.Text = 'SAT' then
  begin
    //'080' '050'
    STEmpresa.Caption := 'SAT BONNYSA (050-080)';
  end
  else
  begin
    STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
  end;

  DesProductoOptativo;
  DesEnvaseOptativo;
  DesCentroSalidaOptativo;
  DesCentroOrigenOptativo;
  DesTransportistaOptativo;
  DesOperadorOptativo;
  DesClienteOptativo;
  DesSuministroOptativo;
  DesTipoSalidaOptativo;
end;

procedure TFLTablaSalidas.edtCentroSalidaChange(Sender: TObject);
begin
  DesCentroSalidaOptativo;
end;

procedure TFLTablaSalidas.edtProductoChange(Sender: TObject);
begin
  DesProductoOptativo;
end;

procedure TFLTablaSalidas.cbxDestinoChange(Sender: TObject);
begin
  lblGrupoPaises.Visible:= ( cbxDestino.ItemIndex = 6 );
  clbPaises.Enabled:= lblGrupoPaises.Visible;
end;

procedure TFLTablaSalidas.edtTipoSalidaChange(Sender: TObject);
begin
  if edtTipoSalida.Text = '' then
    chkExcluirDevolucion.Enabled := True
  else
    chkExcluirDevolucion.Enabled := False;
  
  DesTipoSalidaOptativo;
end;

procedure TFLTablaSalidas.edtTransportistaChange(
  Sender: TObject);
begin
  DesTransportistaOptativo;
end;

procedure TFLTablaSalidas.edtClienteChange(Sender: TObject);
begin
  DesClienteOptativo;
end;

procedure TFLTablaSalidas.edtPaletChange(Sender: TObject);
begin
  DesPaletOptativo;
end;

procedure TFLTablaSalidas.edtPaisChange(Sender: TObject);
begin
  DesPaisOptativo;
end;

procedure TFLTablaSalidas.edtAgrupacionChange(Sender: TObject);
begin
  if Trim( edtAgrupacion.Text ) = '' then
    STAgrupacion.Caption := 'TODAS LAS AGRUPACIONES'
  else
    STAgrupacion.Caption := desAgrupacion(edtAgrupacion.Text);
end;

procedure TFLTablaSalidas.edtCentroOrigenChange(Sender: TObject);
begin
  DesCentroOrigenOptativo;
end;

procedure TFLTablaSalidas.edtSuministroChange(Sender: TObject);
begin
  DesSuministroOptativo;
end;

procedure TFLTablaSalidas.edtOperadorChange(Sender: TObject);
begin
  DesOperadorOptativo;
end;

procedure TFLTablaSalidas.edtEnvaseChange(Sender: TObject);
begin
  DesEnvaseOptativo;
end;

procedure TFLTablaSalidas.edtEnvaseExit(Sender: TObject);
begin
  if EsNumerico(edtEnvase.Text) and (Length(edtEnvase.Text) <= 5) then
    if (edtEnvase.Text <> '' ) and (Length(edtEnvase.Text) < 9) then
      edtEnvase.Text := 'COM-' + Rellena( edtEnvase.Text, 5, '0');
end;

procedure TFLTablaSalidas.MontarQuery;
begin
  with qryTabla do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sc empresa,');

    case cbxAgrupacion.ItemIndex of
      0:begin
         //Albarán
         SQL.Add('        year(fecha_sc) anyo, ');
//       SQL.Add('        year(fecha_sc) * 100 + month(fecha_sc) anyo_mes, ');
//       SQL.Add('        yearandweek(fecha_sc) anyo_semana, ');
         SQL.Add('        month(fecha_sc) mes, ');
         SQL.Add('        SUBSTR(yearandweek(fecha_sc),5,2) sem, ');
         SQL.Add('        fecha_sc fecha_salida, ');
         SQL.Add('       (case es_transito_sc when 2 then ''D'' || n_albaran_Sc else '' '' || n_albaran_Sc end) n_salida, ');
//         SQL.Add('        n_albaran_Sc n_salida, ');
         SQL.Add('        fecha_descarga_sc fecha_descarga, ');         //Mostrar fecha solo para Tipo Agrupacion Albaran

      end;
      1:begin
         //Diario
         SQL.Add('        year(fecha_sc) anyo, ');
//       SQL.Add('        year(fecha_sc) * 100 + month(fecha_sc) anyo_mes, ');
//       SQL.Add('        yearandweek(fecha_sc) anyo_semana, ');
         SQL.Add('        month(fecha_sc) mes, ');
         SQL.Add('        SUBSTR(yearandweek(fecha_sc),5,2) sem, ');
         SQL.Add('        fecha_sc fecha_salida, ');
         SQL.Add('        0 n_salida, ');
      end;
      2:begin
         //Semanal
         SQL.Add('        year(fecha_sc) anyo, ');
//         SQL.Add('        year(fecha_sc) * 100 + month(fecha_sc) anyo_mes, ');
//         SQL.Add('        yearandweek(fecha_sc) anyo_semana, ');
         SQL.Add('        month(fecha_sc) mes, ');
         SQL.Add('        SUBSTR(yearandweek(fecha_sc),5,2) sem, ');
         SQL.Add('        '''' fecha_salida, ');
         SQL.Add('        0 n_salida, ');
      end;
      3:begin
         //Mensual
         SQL.Add('        year(fecha_sc) anyo, ');
//         SQL.Add('        year(fecha_sc) * 100 + month(fecha_sc) anyo_mes, ');
//         SQL.Add('        0 anyo_semana, ');
         SQL.Add('        month(fecha_sc) mes, ');
         SQL.Add('        SUBSTR(yearandweek(fecha_sc),5,2) sem, ');
         SQL.Add('        '''' fecha_salida, ');
         SQL.Add('        0 n_salida, ');
      end;
      4:begin
         //Anual
         SQL.Add('        year(fecha_sc) anyo, ');
//         SQL.Add('        0 anyo_mes, ');
//         SQL.Add('        0 anyo_semana, ');
         SQL.Add('        0 mes, ');
         SQL.Add('        0 sem, ');
         SQL.Add('        '''' fecha_salida, ');
         SQL.Add('        0 n_salida, ');
      end;
      5:begin
         //Total
         SQL.Add('        0 anyo, ');
//         SQL.Add('        0 anyo_mes, ');
//         SQL.Add('        0 anyo_semana, ');
         SQL.Add('        0 mes, ');
         SQL.Add('        0 sem, ');
         SQL.Add('        '''' fecha_salida, ');
         SQL.Add('        0 n_salida, ');
      end;
    end;

    if chkCentroSalida.checked then
      SQL.Add('       centro_salida_sc centro_salida, ')
    else
      SQL.Add('       '''' centro_salida, ');

    if chkComunitario.checked then
    begin
      SQL.Add('       ( select case when es_comunitario_c = ''S'' then ''SI'' else ''NO'' end from frf_clientes ');
      SQL.Add('         where cliente_c = cliente_sal_sc ) comunitario_cliente, ');
    end
    else
      SQL.Add('       '''' comunitario_cliente, ');

    if chkPais.checked then
      SQL.Add('       ( select pais_c from frf_clientes where cliente_c = cliente_sal_sc ) pais_cliente, ')
    else
      SQL.Add('       ''''  pais_cliente, ');

    if chkCliente.checked then
      SQL.Add('       cliente_sal_sc cliente, ')
    else
      SQL.Add('       ''''  cliente, ');

    if chkSuministro.checked then
      SQL.Add('       dir_sum_sc suministro, ')
    else
      SQL.Add('       ''''  suministro, ');

    if chkReclamacion.checked then
      SQL.Add('       case when reclamacion_sc = 0 then ''NO'' else ''SI'' end reclamacion, ')
    else
      SQL.Add('       ''''  reclamacion, ');

    if chkFacturado.checked then
      SQL.Add('       case when fecha_factura_sc is null then ''NO'' else ''SI'' end facturado, ')
    else
      SQL.Add('       ''''  facturado, ');

    if chkPortesPagados.checked then
      SQL.Add('       case when porte_bonny_sc = 0 then ''NO'' else ''SI'' end pagamos_porte, ')
    else
      SQL.Add('       ''''  pagamos_porte, ');

    if chkTransportista.checked then
      SQL.Add('       transporte_sc transporista, ')
    else
      SQL.Add('       0 transporista, ');

    if chkOperador.checked then
      SQL.Add('       operador_transporte_sc operador, ')
    else
      SQL.Add('       0 operador, ');

    if chkMatricula.checked then
      SQL.Add('       vehiculo_sc matricula, ')
    else
      SQL.Add('       '''' matricula, ');

    if chkCentroOrigen.checked then
      SQL.Add('       centro_origen_sl origen, ')
    else
      SQL.Add('       '''' origen, ');

//Agrupacion 2
    case cbxAgru2.ItemIndex of
      0:begin
        //Producto
        if chkProducto.checked then
        begin
          if not chkBeef.Checked then
          begin
            if not chkUnirTyE.Checked then
            begin
              SQL.Add('       producto_sl producto, ');
            end
            else
            begin
              SQL.Add('       case when  ( producto_sl = ''TOM'' or producto_sl = ''TOM'' ) then ''TOM'' else producto_sl end producto, ');
            end;
          end
          else
          begin
            if chkUnirTyE.Checked then
            begin
              SQL.Add('              ( select case when ( producto_sl = ''TOM'' or producto_sl = ''TOM'' ) and descripcion_e like ''%BEEF%'' then ''TBEEF'' ');
              SQL.Add('                            when ( producto_sl = ''TOM'' or producto_sl = ''TOM'' ) and descripcion_e like ''%ENS%'' then ''TENSALADA'' ');
              SQL.Add('                            when ( producto_sl <> ''TOM'' and producto_sl <> ''TOM'' ) then producto_sl ');
              SQL.Add('                            else ''TCANARIO'' end ');
              SQL.Add('                from frf_envases ');
              SQL.Add('                where envase_E = envase_sl ');
              SQL.Add('                and ( producto_E is null or producto_E = producto_sl ) ) producto, ');
            end
            else
            begin
              SQL.Add('              ( select case when ( producto_sl = ''TOM'' ) and descripcion_e like ''%BEEF%'' then ''TBEEF'' ');
              SQL.Add('                            when ( producto_sl = ''TOM'' ) and descripcion_e like ''%ENS%'' then ''TENSALADA'' ');
              SQL.Add('                            when ( producto_sl = ''TOM'' ) then ''TCANARIO'' ');
              SQL.Add('                            else producto_sl end ');
              SQL.Add('                from frf_envases ');
              SQL.Add('                where envase_E = envase_sl ');
              SQL.Add('                and ( producto_e is null or producto_e = producto_sl ) ) producto, ');
            end;
          end;
        end
        else
          SQL.Add('       '''' producto, ');
      end;
      1:begin
         //Linea de Producto
         SQL.Add('        nvl( linea_producto_e, ''00'' ) producto, ');
      end;
      2:begin
         //Agrupacion comercial
         SQL.Add('        nvl(agrupa_comercial_e,''SIN AGRUPACION'') producto, ');
      end;
    end;

    if chkEnvase.checked then
      SQL.Add('       envase_sl envase, ')
    else
      SQL.Add('       '''' envase, ');

    if chkVendedor.checked then
      SQL.Add('       comercial_sl vendedor, ')
    else
      SQL.Add('       '''' vendedor, ');

    if chkPalet.checked then
      SQL.Add('       tipo_palets_sl palet, ')
    else
      SQL.Add('       '''' palet, ');

    if chkCategoria.checked then
      SQL.Add('       categoria_sl categoria, ')
    else
      SQL.Add('       '''' categoria, ');

    if chkCalibre.checked then
      SQL.Add('       calibre_sl calibre, ')
    else
      SQL.Add('       '''' calibre, ');

    if chkpalets.checked then
      SQL.Add('       sum(n_palets_sl) palets, ')
    else
      SQL.Add('       sum(0) palets, ');

    if chkCajas.checked then
      SQL.Add('       sum(cajas_sl) cajas, ')
    else
      SQL.Add('       sum(0) cajas, ');

    if chkUnidades.checked then
    begin
      SQL.Add('       sum( unidades_caja_sl * cajas_sl ) unidades, ');
    end
    else
      SQL.Add('       sum(0) unidades, ');

    if chkKilos.checked then
      SQL.Add('       sum( kilos_sl ) kilos, ')
    else
      SQL.Add('       sum(0) kilos, ');

    if chkImporte.checked then
    begin
      if cbbImporte.ItemIndex = 0 then
      begin
        SQL.Add('       sum( case when moneda_sc = ''EUR'' then importe_neto_sl');
        SQL.Add('            else EUROS( moneda_sc, fecha_sl, importe_neto_sl ) end ) importe ');
      end
      else
      begin
        SQL.Add('       sum( case when moneda_sc = ''EUR'' then importe_total_sl');
        SQL.Add('            else EUROS( moneda_sc, fecha_sl, importe_total_sl ) end ) importe ');
      end;
    end
    else
      SQL.Add('       sum(0) importe ');

    SQL.Add(' from frf_salidas_c inner join frf_salidas_l on empresa_sc = empresa_sl and centro_salida_sc = centro_salida_sl ');
    SQL.Add('                                                and fecha_sc = fecha_sl and n_albaran_sc = n_albaran_sl ');
    SQL.Add('                          join frf_envases on envase_e = envase_sl ');

    if edtEmpresa.Text = 'BAG' then
    begin
      //Todas las que empiezan por F
      SQL.Add(' where substr(empresa_sc,1,1) = ''F'' ');
    end
    else
    if edtEmpresa.Text = 'SAT' then
    begin
      //'080' '050'
      SQL.Add(' where ( empresa_sc = ''050'' or empresa_sc = ''080'' )');
    end
    else
    begin
      SQL.Add(' where empresa_sc = :empresa ');
    end;

    SQL.Add(' and fecha_sc between :fechaini and :fechafin ');

    if edtCentroSalida.Text <> '' then
      SQL.Add(' and centro_salida_sc = :centrosalida ');

    if edtCentroOrigen.Text <> '' then
      SQL.Add(' and centro_origen_sl = :centroorigen ');

    if edtPais.Text <> '' then
      SQL.Add(' and ( select pais_c from frf_clientes where cliente_c = cliente_sal_sc ) = :pais ')
    else
    case cbxDestino.ItemIndex of
      0:begin
          //Todos los paises
      end;
      1:begin
          //Mercado nacional
          SQL.Add('and ( select pais_c from frf_clientes where cliente_c = cliente_sal_sc ) = ''ES'' ');
      end;
      2:begin
          //Mercado comunitario
          SQL.Add('and ( select pais_c from frf_clientes where cliente_c = cliente_sal_sc ) <> ''ES'' ');
          SQL.Add('and ( select es_comunitario_c from frf_clientes where cliente_c = cliente_sal_sc ) = ''S'' ');
      end;
      3:begin
          //Nacional mas comunitario
          SQL.Add('and ( select es_comunitario_c from frf_clientes where cliente_c = cliente_sal_sc ) = ''S'' ');
      end;
      4:begin
          //Mercado extracomunitario
          SQL.Add('and ( select es_comunitario_c from frf_clientes where cliente_c = cliente_sal_sc ) = ''N'' ');
      end;
      5:begin
          //Todos los extranjeros
          SQL.Add('and ( select pais_c from frf_clientes where cliente_c = cliente_sal_sc ) <> ''ES'' ');
      end;
      6:begin
          //Grupo de paises
          SQL.Add('and ( select pais_c from frf_clientes where cliente_c = cliente_sal_sc ) in (' + sPaises + ')');
      end;
    end;

    if edtCliente.Text <> '' then
      SQL.Add(' and cliente_sal_sc = :cliente ');

    if edtSuministro.Text <> '' then
      SQL.Add(' and dir_sum_Sc = :suministro ');

    case  cbbReclamacion.ItemIndex of
      0: begin
           //
         end;
      1: begin
           SQL.Add(' and reclamacion_sc = 1 ');
         end;
      2: begin
           SQL.Add(' and reclamacion_sc = 0 ');
         end;
    end;
    case  cbxPortes.ItemIndex of
      0: begin
           //
         end;
      1: begin
           SQL.Add(' and porte_bonny_sc = 1 ');
         end;
      2: begin
           SQL.Add(' and porte_bonny_sc = 0 ');
         end;
    end;
    case  cbbFacturado.ItemIndex of
      0: begin
           //
         end;
      1: begin
           SQL.Add(' and fecha_factura_sc is not null ');
         end;
      2: begin
           SQL.Add(' and fecha_factura_sc is null ');
         end;
    end;

    if edtTransportista.Text <> '' then
      SQL.Add(' and transporte_sc = :transporte   ');

    if edtOperador.Text <> '' then
      SQL.Add(' and operador_transporte_sc = :operador ');

    if edtMatricula.Text <> '' then
      SQL.Add(' and vehiculo_sc like ''%' + edtMatricula.Text + '%'' ');

    if edtAgrupacion.Text <> '' then
      SQL.Add(' and producto_sl in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');

    if edtProducto.Text <> '' then
    begin
      if chkUnirTyE.Checked then
      begin
        if ( edtProducto.Text = 'TOM' ) or ( edtProducto.Text = 'TOM' ) then
        begin
          SQL.Add(' and ( producto_sl = ''TOM'' or producto_sl = ''TOM'' ) ');
        end
        else
        begin
          SQL.Add(' and producto_sl = :producto ');
        end;
      end
      else
      begin
        SQL.Add(' and producto_sl = :producto ');
      end;
    end;

    if edtEnvase.Text <> '' then
      SQL.Add(' and envase_sl = :envase ');

    if edtVendedor.Text <> '' then
      SQL.Add(' and comercial_sl = :vendedor ');

    if edtPalet.Text <> '' then
      SQL.Add(' and tipo_palets_sl = :palet ');

    if chkComerciales.checked then
      SQL.Add(' and categoria_sl in (''1'',''2'',''3'') ')
    else
    if edtCategoria.Text <> '' then
      SQL.Add(' and categoria_sl = :categoria ');

    if edtCalibre.Text <> '' then
      SQL.Add(' and calibre_sl = :calibre ');

    if edtTipoSalida.Text <> '' then
      SQL.Add(' and es_transito_sc = :tiposalida ');

    if chkExcluirDevolucion.Enabled and chkExcluirDevolucion.Checked then
      SQL.Add(' and es_transito_sc <> 2 ');

    if chkExcluirInterplanta.Checked then
      SQL.Add(' and (select tipo_cliente_c from frf_clientes where cliente_c = cliente_sal_sc) <> ''IP'' ');

    SQL.Add(' group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, ');
    SQL.Add('          14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24');
    if cbxAgrupacion.ItemIndex = 0 then
      SQL.Add(' ,25 ');

    //SQL.Add(' group by empresa, anyo, anyo_mes, anyo_semana, fecha_salida, centro_salida, n_salida, ');
    //SQL.Add('        comunitario_cliente, pais_cliente, cliente, suministro, reclamacion, facturado, ');
    //SQL.Add('        pagamos_porte, transporista, operador, matricula, origen, producto, envase, vendedor,');
    //SQL.Add('        palet,categoria, calibre ');
    SQL.Add(' order by empresa, anyo, mes, sem, fecha_salida, centro_salida, n_salida, ');
    SQL.Add('        comunitario_cliente, pais_cliente, cliente, suministro, reclamacion, facturado, ');
    SQL.Add('        pagamos_porte, transporista, operador, matricula, origen, producto, envase, vendedor,');
    SQL.Add('        palet,categoria, calibre ');

  end;



  CargarParametros;
end;

procedure TFLTablaSalidas.CargarParametros;
begin
  with qryTabla do
  begin
    if ( edtEmpresa.Text <> 'BAG' ) AND ( edtEmpresa.Text <> 'SAT' ) then
    begin
      ParamByName('empresa').AsString:= edtEmpresa.Text;
    end;

    ParamByName('fechaini').AsDatetime:= dFechaIni;
    ParamByName('fechafin').AsDatetime:= dFechaFin;

    if edtDescargaDesde.Text <> '' then
      ParamByName('fechadescargaini').AsDateTime:= dFechaDescargaIni;

    if edtDescargaHasta.Text <> '' then
      ParamByName('fechadescargafin').AsDateTime:= dFechaDescargaFin;

    if edtCentroSalida.Text <> '' then
      ParamByName('centrosalida').AsString:= edtCentroSalida.Text;

    if edtCentroOrigen.Text <> '' then
      ParamByName('centroorigen').AsString:= edtCentroOrigen.Text;

    if edtPais.Text <> '' then
      ParamByName('pais').AsString:= edtPais.Text;

    if edtCliente.Text <> '' then
      ParamByName('cliente').AsString:= edtCliente.Text;

    if edtSuministro.Text <> '' then
      ParamByName('suministro').AsString:= edtSuministro.Text;

    if edtTransportista.Text <> '' then
      ParamByName('transporte').AsString:= edtTransportista.Text;

    if edtOperador.Text <> '' then
      ParamByName('operador').AsString:= edtOperador.Text;

    if edtAgrupacion.Text <> '' then
      ParamByName('agrupacion').AsString:= edtAgrupacion.Text;

    if edtProducto.Text <> '' then
    begin
      if chkUnirTyE.Checked then
      begin
        if ( edtProducto.Text <> 'TOM' ) and ( edtProducto.Text <> 'TOM' ) then
        begin
          ParamByName('producto').AsString:= edtProducto.Text;
        end;
      end
      else
      begin
        ParamByName('producto').AsString:= edtProducto.Text;
      end;
    end;

    if edtEnvase.Text <> '' then
      ParamByName('envase').AsString:= edtEnvase.Text;

    if edtVendedor.Text <> '' then
      ParamByName('vendedor').AsString:= edtVendedor.Text;

    if edtPalet.Text <> '' then
      ParamByName('palet').AsString:= edtPalet.Text;

    if not chkComerciales.checked then
    if edtCategoria.Text <> '' then
      ParamByName('categoria').AsString:= edtCategoria.Text;

    if edtCalibre.Text <> '' then
      ParamByName('calibre').AsString:= edtCalibre.Text;

    if edtTipoSalida.Text <> '' then
      ParamByName('tiposalida').AsString:= edtTipoSalida.Text;

  end;
end;

function TFLTablaSalidas.AbrirQuery: Boolean;
begin
  qryTabla.Open;
  result:= not qryTabla.isEmpty;
end;

procedure TFLTablaSalidas.CerrarQuery;
begin
  qryTabla.Close;
end;

procedure TFLTablaSalidas.btnSeleccinarClick(Sender: TObject);
begin
  SeleccionarTodo( True );
end;

procedure TFLTablaSalidas.btnDeseleccionarClick(Sender: TObject);
begin
  SeleccionarTodo( False );
end;

procedure TFLTablaSalidas.SeleccionarTodo( const ASelect: Boolean );
begin
    chkCentroSalida.checked:= ASelect;
    chkCentroOrigen.checked:= ASelect;
    chkPais.checked:= ASelect;
    chkCliente.checked:= ASelect;
    chkSuministro.checked:= ASelect;
    chkTransportista.checked:= ASelect;
    chkOperador.checked:= ASelect;
    chkMatricula.checked:= ASelect;
    chkProducto.checked:= ASelect;
    chkEnvase.checked:= ASelect;
    chkVendedor.checked:= ASelect;
    chkPalet.checked:= ASelect;
    chkCategoria.checked:= ASelect;
    chkCalibre.checked:= ASelect;
    chkComunitario.checked:= ASelect;
    chkPortesPagados.checked:= ASelect;
    chkFacturado.checked:= ASelect;
    chkReclamacion.checked:= ASelect;
    //chkpalets.checked:= ASelect;
    //chkCajas.checked:= ASelect;
    //chkUnidades.checked:= ASelect;
    //chkKilos.checked:= ASelect;
    //chkImporte.checked:= ASelect;

end;

procedure TFLTablaSalidas.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if edtProducto.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(edtProducto.Text);
end;

procedure TFLTablaSalidas.chkProductoClick(Sender: TObject);
begin
  if chkProducto.Checked then
  begin
    chkBeef.Enabled:= True;
  end
  else
  begin
    chkBeef.Enabled:= False;
    chkBeef.Checked:= False;
  end;
end;

procedure TFLTablaSalidas.chkImporteClick(Sender: TObject);
begin
  cbbImporte.Enabled:= chkImporte.Checked;
end;

procedure TFLTablaSalidas.edtVendedorChange(Sender: TObject);
begin
  DesComercialOptativo;
end;

end.
