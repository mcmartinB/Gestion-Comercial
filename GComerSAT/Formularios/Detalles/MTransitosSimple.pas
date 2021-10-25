unit MTransitosSimple;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid,
  BDEdit, BEdit, dbTables, DError, BCalendarButton, ComCtrls, BCalendario,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinBlueprint, dxSkinFoggy, Menus, cxButtons,
  SimpleSearch, bMath, cxTextEdit, cxDBEdit, dxSkinMoneyTwins, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TFMTransitosSimple = class(TMaestroDetalle)
    DSMaestro: TDataSource;
    PMaestro: TPanel;
    LEmpresa_p: TLabel;
    Label1: TLabel;
    BGBEmpresa_tc: TBGridButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BGBCentro_tc: TBGridButton;
    BGBTransporte_tc: TBGridButton;
    BCBCalendario: TBCalendarButton;
    Referencia: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    lblStatusGastos: TLabel;
    Label20: TLabel;
    BGBCentro_destino_tc: TBGridButton;
    centro_tc: TBDEdit;
    centro_destino_tc: TBDEdit;
    empresa_tc: TBDEdit;
    STEmpresa_tc: TStaticText;
    STCentro_tc: TStaticText;
    fecha_tc: TBDEdit;
    transporte_tc: TBDEdit;
    vehiculo_tc: TBDEdit;
    STTransporte_tc: TStaticText;
    referencia_tc: TBDEdit;
    buque_tc: TBDEdit;
    destino_tc: TBDEdit;
    Status_gastos_tc: TDBCheckBox;
    STCentro_destino_tc: TStaticText;
    QTransitosC: TQuery;
    RejillaFlotante: TBGrid;
    Calendario: TBCalendario;
    PRejilla: TPanel;
    RVisualizacion: TDBGrid;
    TTransitosL: TTable;
    DSDetalle: TDataSource;
    PTenerife: TPanel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    nom_gg: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    BGBColor_tl: TBGridButton;
    BGBProducto_tl: TBGridButton;
    BGBMarca_tl: TBGridButton;
    Label29: TLabel;
    BGBCalibre_tl: TBGridButton;
    nomColorT: TStaticText;
    nomCategoriaT: TStaticText;
    nomMarcaT: TStaticText;
    nomEnvaseT: TStaticText;
    nomProductoT: TStaticText;
    producto_tl: TBDEdit;
    marca_tl: TBDEdit;
    color_tl: TBDEdit;
    categoria_tl: TBDEdit;
    calibre_tl: TBDEdit;
    kilos_tl: TBDEdit;
    cajas_tl: TBDEdit;
    BGBCategoria_tl: TBGridButton;
    centro_origen_tl: TBDEdit;
    Label21: TLabel;
    BGBCentro_origen_tl: TBGridButton;
    nomCentroFruta: TStaticText;
    ref_origen_tl: TBDEdit;
    Label22: TLabel;
    Label23: TLabel;
    fecha_origen_tl: TBDEdit;
    DSDetalle2: TDataSource;
    BCBfecha_origen_tl: TBCalendarButton;
    pnlBotones: TPanel;
    btnGastos: TSpeedButton;
    eGastoAsignado: TBDEdit;
    btnSalidas: TSpeedButton;
    Label24: TLabel;
    porte_bonny_tc: TDBCheckBox;
    cbx_porte_bonny_tc: TComboBox;
    nota_tc: TDBMemo;
    Label12: TLabel;
    cbx_status_gastos_tc: TComboBox;
    lblNumCMR: TLabel;
    n_cmr_tc: TBDEdit;
    Label16: TLabel;
    tipo_palet_tl: TBDEdit;
    BGBTipoPalet: TBGridButton;
    stTipo_palet_tl: TStaticText;
    Label17: TLabel;
    palets_tl: TBDEdit;
    Label8: TLabel;
    fecha_entrada_tc: TBDEdit;
    BCalendarButton1: TBCalendarButton;
    puerto_tc: TBDEdit;
    BGBpuerto_tc: TBGridButton;
    stPuerto_tc: TStaticText;
    lblNombre1: TLabel;
    btnAduanas: TSpeedButton;
    lbl1: TLabel;
    cbb_higiene_tc: TComboBox;
    higiene_tc: TDBCheckBox;
    carpeta_deposito_tc: TBDEdit;
    lblCarpetaDeposito: TLabel;
    bvl1: TBevel;
    lbl2: TLabel;
    naviera_tc: TBDEdit;
    Label15: TLabel;
    unidades_caja_tl: TBDEdit;
    btnActivar: TSpeedButton;
    hora_entrada_tc: TBDEdit;
    hora_tc: TBDEdit;
    lbl4: TLabel;
    precio_palet_plas_tc: TBDEdit;
    lbl5: TLabel;
    precio_caja_plas_tc: TBDEdit;
    lbl6: TLabel;
    incoterm_tc: TBDEdit;
    BGBincoterm_c: TBGridButton;
    stIncoterm: TStaticText;
    lbl7: TLabel;
    plaza_incoterm_tc: TBDEdit;
    envase_tl: TcxDBTextEdit;
    ssEnvase: TSimpleSearch;
    TTransitosLempresa_tl: TStringField;
    TTransitosLcentro_tl: TStringField;
    TTransitosLreferencia_tl: TIntegerField;
    TTransitosLfecha_tl: TDateField;
    TTransitosLcentro_destino_tl: TStringField;
    TTransitosLcentro_origen_tl: TStringField;
    TTransitosLref_origen_tl: TIntegerField;
    TTransitosLfecha_origen_tl: TDateField;
    TTransitosLproducto_tl: TStringField;
    TTransitosLenvase_tl: TStringField;
    TTransitosLenvaseold_tl: TStringField;
    TTransitosLmarca_tl: TStringField;
    TTransitosLcategoria_tl: TStringField;
    TTransitosLcolor_tl: TStringField;
    TTransitosLcalibre_tl: TStringField;
    TTransitosLunidades_caja_tl: TIntegerField;
    TTransitosLcajas_tl: TIntegerField;
    TTransitosLkilos_tl: TFloatField;
    TTransitosLfederacion_tl: TStringField;
    TTransitosLcosechero_tl: TSmallintField;
    TTransitosLplantacion_tl: TSmallintField;
    TTransitosLanyo_semana_tl: TStringField;
    TTransitosLtipo_palet_tl: TStringField;
    TTransitosLpalets_tl: TIntegerField;
    TTransitosLdesEnvase: TStringField;
    Label18: TLabel;
    precio_tl: TBDEdit;
    Label19: TLabel;
    importe_linea_tl: TBDEdit;
    TTransitosLprecio_tl: TFloatField;
    TTransitosLimporte_linea_tl: TFloatField;
    excluir_posei_tc: TDBCheckBox;
    Label25: TLabel;
    cbx_excluir_posei_tc: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure empresa_tcRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure empresa_tcChange(Sender: TObject);
    procedure centro_tcChange(Sender: TObject);
    procedure centro_destino_tcChange(Sender: TObject);
    procedure transporte_tcChange(Sender: TObject);
    procedure QTransitosCAfterScroll(DataSet: TDataSet);
    procedure BGBEmpresa_tcClick(Sender: TObject);
    procedure BGBCentro_tcClick(Sender: TObject);
    procedure BGBCentro_destino_tcClick(Sender: TObject);
    procedure BGBTransporte_tcClick(Sender: TObject);
    procedure BCBCalendarioClick(Sender: TObject);
    procedure QTransitosCNewRecord(DataSet: TDataSet);
    procedure QTransitosCBeforePost(DataSet: TDataSet);
    procedure QTransitosCAfterPost(DataSet: TDataSet);
    procedure producto_tlChange(Sender: TObject);
    procedure centro_origen_tlChange(Sender: TObject);
    procedure envase_tlChange(Sender: TObject);
    procedure marca_tlChange(Sender: TObject);
    procedure categoria_tlChange(Sender: TObject);
    procedure color_tlChange(Sender: TObject);
    procedure BGBProducto_tlClick(Sender: TObject);
    procedure BGBMarca_tlClick(Sender: TObject);
    procedure BGBCategoria_tlClick(Sender: TObject);
    procedure BGBColor_tlClick(Sender: TObject);
    procedure BGBCalibre_tlClick(Sender: TObject);
    procedure BGBCentro_origen_tlClick(Sender: TObject);
    procedure BCBfecha_origen_tlClick(Sender: TObject);
    procedure TTransitosLBeforePost(DataSet: TDataSet);
    procedure TTransitosLNewRecord(DataSet: TDataSet);
    procedure cajas_tlChange(Sender: TObject);
    procedure TTransitosLBeforeEdit(DataSet: TDataSet);
    procedure RVisualizacionDblClick(Sender: TObject);
    procedure DSMaestroStateChange(Sender: TObject);
    procedure btnGastosClick(Sender: TObject);
    procedure DSDetalle2StateChange(Sender: TObject);
    procedure btnSalidasClick(Sender: TObject);
    procedure porte_bonny_tcEnter(Sender: TObject);
    procedure porte_bonny_tcExit(Sender: TObject);
    procedure cbx_status_gastos_tcKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbx_porte_bonny_tcKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure nota_tcEnter(Sender: TObject);
    procedure nota_tcExit(Sender: TObject);
    procedure tipo_palet_tlChange(Sender: TObject);
    procedure BGBTipoPaletClick(Sender: TObject);
    procedure ref_origen_tlExit(Sender: TObject);
    procedure BGBpuerto_tcClick(Sender: TObject);
    procedure puerto_tcChange(Sender: TObject);
    procedure fecha_facontrol_tcChange(Sender: TObject);
    procedure btnAduanasClick(Sender: TObject);
    procedure btnActivarClick(Sender: TObject);
    procedure BGBincoterm_cClick(Sender: TObject);
    procedure incoterm_tcChange(Sender: TObject);
    procedure envase_tlExit(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
    procedure TTransitosLCalcFields(DataSet: TDataSet);
    procedure kilos_tlChange(Sender: TObject);
    procedure precio_tlChange(Sender: TObject);
  private
    { Private declarations }
    Lista, ListaDetalle: TList;
    Objeto: TObject;

    kilosCaja: Real;
    auxEnvase, auxMarca, auxCategoria, auxColor, auxCalibre: string;
    auxKilos: Real;
    incrementar: Boolean;
    contador: string;

    procedure ValidarEntradaMaestro;
    procedure ValidarEntradaDetalle;
    procedure VerDetalle;
    procedure EditarDetalle;
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure GetContador;
    procedure PutKilosLinea;
    procedure PutKilosCaja;

    procedure AntesDeLocalizar;
    procedure AntesDeVisualizar;
    procedure AntesDeInsertar;
    procedure AntesDeModificar;

    procedure PreguntarCMR;
    procedure SeleccionarInforme;
    procedure ImprimirCartaPorte;
    procedure ImprimirAlbaran;
    procedure ImprimirFactura;
    procedure ImprimirCMRInyeccion;
    procedure ImprimirCertificadoLame;
    //procedure ImprimirCMRMatricial;

    procedure PrecioFactura;

    procedure CalcularImporte;

    function EsCertificadoLame(const AEmpresa, ACentro, AAlbaran, AFecha: String): boolean;
    function TieneDeposito:boolean;


  public
    { Public declarations }
    procedure Activar;
    procedure Borrar; override;
    procedure BorrarActivo;

    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    //Listado
    procedure Previsualizar; override;

    function EsCentroExtranjero( const AEmpresa, ACentro: string ): boolean;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CAuxiliarDB,
  Principal, UDMAuxDB, Variants, MGastosTransitos, QLAlbaranTransito2,
  UFTransportistas,   UDMCmr,
  DesgloseTransitosFC, bSQLUtils, DInfTransitosSelect, DInfTransitosPreguntar,
  DConfigMail, UDMConfig, CMaestro, CFDTransitosAduana, CRDTransitosAduanaFicha,
  LFacturaTransitoProforma, AdvertenciaFD, PFTransitoActivar,
  UDMEnvases, bTextUtils, UDLCertificadoLame, CartaTransitoDL;

{$R *.DFM}

procedure TFMTransitosSimple.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DatasetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
  end;

  if not DataSourceDetalle.DataSet.Active then
    DataSourceDetalle.DataSet.Open;

     //Estado inicial
  Registro := 1;
  Registros := 0;
  RegistrosInsertados := 0;
end;

procedure TFMTransitosSimple.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSourceDetalle.DataSet, DataSetMaestro]);
end;

procedure TFMTransitosSimple.FormCreate(Sender: TObject);
begin
  top:= 2;
  left:= 2;

  btnGastos.Enabled := DMConfig.EsLaFont;
  lblStatusGastos.Enabled := btnGastos.Enabled;
  Status_gastos_tc.visible := false;
  cbx_status_gastos_tc.Enabled := btnGastos.Enabled;

  LineasObligadas := false;
  ListadoObligado := true;
  MultipleAltas := false;

     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  gCF := Calendario;

  //Panel
  PanelMaestro := PMaestro;
  PanelDetalle := PTenerife;
  RejillaVisualizacion := RVisualizacion;

  //Fuente de datos
  DataSetMaestro := QTransitosC;
  DataSourceDetalle := DSDetalle;
  RVisualizacion.DataSource := DSDetalle;

  Select := ' SELECT * FROM frf_transitos_c ';
  where := ' WHERE empresa_tc = ' + QuotedStr('###');
  Order := ' ORDER BY fecha_tc DESC, empresa_tc, centro_tc, referencia_tc ';

  //Abrir tablas/Querys
  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Close;
    end;
  end;

  //Lista de componentes
  Lista := TList.Create;
  PanelMaestro.GetTabOrderList(Lista);
  ListaDetalle := TList.Create;
  PanelDetalle.GetTabOrderList(ListaDetalle);

  //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> CVariables.tfMaestro then
  begin
    FormType := tfMaestroDetalle;
    BHFormulario;
  end;
  Visualizar;
  //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

  //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnValidateDetailConstrains := ValidarEntradaDetalle;

  //Preparar panel de detalle
  OnViewDetail := VerDetalle;
  OnEditDetail := EditarDetalle;

  FocoAltas := empresa_tc;
  FocoModificar := transporte_tc;
  FocoLocalizar := empresa_tc;
  Calendario.Date := date;

  //Constantes para las rejillas de l combo
  empresa_tc.Tag := kEmpresa;
  centro_tc.Tag := kCentro;
  centro_destino_tc.Tag := kCentro;
  transporte_tc.Tag := kTransportista;
  puerto_tc.tag:= kAduana;
  incoterm_tc.Tag := kIncoterm;


     OnBrowse:=AntesDeLocalizar;
     OnView:=AntesDeVisualizar;
     OnEdit := AntesDeModificar;
     OnInsert := AntesDeInsertar;

  UDMEnvases.CreateDMEnvase( self );
end;

procedure TFMTransitosSimple.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;

     //Variables globales
  M := Self;
  MD := Self;
  gRF := RejillaFlotante;
  gCF := Calendario;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestroDetalle then
  begin
    FormType := tfMaestroDetalle;
    BHFormulario;
  end;
  BHGrupoDesplazamientoMaestro(PCMaestro);
  BHGrupoDesplazamientoDetalle(PCDetalle);

     //Maximizamos si no lo esta
     if Self.WindowState<>wsMaximized then
     begin
        Self.WindowState:=wsMaximized;
     end;  
end;

procedure TFMTransitosSimple.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UDMEnvases.DestroyDMEnvase;
  Lista.Free;
  ListaDetalle.Free;

  //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

     // Cerrar tabla
  CerrarTablas;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

{+ CUIDADIN }

procedure TFMTransitosSimple.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return,vk_down:
      begin
        if not nota_tc.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        end;
      end;
    vk_up:
      begin
        if not nota_tc.Focused then
        begin
          Key := 0;
          PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        end;
      end;
    vk_f2:
      begin
        Key := 0;
        if empresa_tc.Focused then
          BGBEmpresa_tc.Click
        else
        if centro_tc.Focused then
          BGBCentro_tc.Click
        else
        if centro_destino_tc.Focused then
          BGBCentro_destino_tc.Click
        else
        if transporte_tc.Focused then
          BGBTransporte_tc.Click
        else
        if fecha_tc.Focused then
          BCBCalendario.Click
        else
        if fecha_origen_tl.Focused then
          BCBfecha_origen_tl.Click
        else
        if centro_origen_tl.Focused then
          BGBCentro_origen_tl.Click
        else
        if producto_tl.Focused then
          BGBproducto_tl.Click
        else
        if marca_tl.Focused then
          BGBmarca_tl.Click
        else
        if categoria_tl.Focused then
          BGBcategoria_tl.Click
        else
        if calibre_tl.Focused then
          BGBcalibre_tl.Click
        else
        if color_tl.Focused then
          BGBcolor_tl.Click
        else
        if tipo_palet_tl.Focused then
          BGBTipoPalet.Click
        else
        if puerto_tc.Focused then
          BGBpuerto_tc.Click
        else
        if incoterm_tc.Focused then
          BGBincoterm_c.Click
        else
          Key := vk_f2;
      end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

procedure TFMTransitosSimple.Filtro;
var Flag: Boolean;
  i: Integer;
begin
  where := ''; Flag := false;
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Trim(Text) <> '' then
        begin
          if flag then where := where + ' and ';
          if InputType = itChar then
            where := where + ' ' + name + ' LIKE ' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + SQLNumeric(Text);
          flag := True;
        end;
      end;
    end;
  end;

  case cbx_porte_bonny_tc.ItemIndex of
    1:
    begin
      if flag then where := where + ' and ';
      where := where + ' porte_bonny_tc <> 0 ';
      flag := True;
    end;
    2:
    begin
      if flag then where := where + ' and ';
      where := where + ' porte_bonny_tc = 0 ';
      flag := True;
    end;
  end;

  case cbb_higiene_tc.ItemIndex of
    1:
    begin
      if flag then where := where + ' and ';
      where := where + ' higiene_tc <> 0 ';
      flag := True;
    end;
    2:
    begin
      if flag then where := where + ' and ';
      where := where + ' higiene_tc = 0 ';
      flag := True;
    end;
  end;

  case cbx_status_gastos_tc.ItemIndex of
    1:
    begin
      if flag then where := where + ' and ';
      where := where + ' status_gastos_tc <> ''N'' ';
      flag := True;
    end;
    2:
    begin
      if flag then where := where + ' and ';
      where := where + ' status_gastos_tc = ''N'' ';
      flag := True;
    end;
  end;

  case cbx_excluir_posei_tc.ItemIndex of
    1:
    begin
      if flag then where := where + ' and ';
      where := where + ' excluir_posei_tc <> 0 ';
      flag := True;
    end;
    2:
    begin
      if flag then where := where + ' and ';
      where := where + ' excluir_posei_tc = 0 ';
      flag := True;
    end;
  end;


  if flag then where := ' WHERE ' + where;
end;

procedure TFMTransitosSimple.AnyadirRegistro;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';

  for i := 0 to Lista.Count - 1 do
  begin
    objeto := Lista.Items[i];
    if (objeto is TBDEdit) then
    begin
      with objeto as TBDEdit do
      begin
        if PrimaryKey and (Trim(Text) <> '') then
        begin
          if flag then where := where + ' and ';
          if InputType = itChar then
            where := where + ' ' + name + ' =' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + Text;
          flag := True;
        end;
      end;
    end;
  end;

  case cbx_porte_bonny_tc.ItemIndex of
    1:
    begin
      where := where + ' porte_bonny_sc <> 0 ';
    end;
    2:
    begin
      where := where + ' porte_bonny_sc = 0 ';
    end;
  end;

  case cbx_status_gastos_tc.ItemIndex of
    1:
    begin
      where := where + ' Status_gastos_tc <> ''N'' ';
    end;
    2:
    begin
      where := where + ' Status_gastos_tc = ''N'' ';
    end;
  end;

  case cbx_excluir_posei_tc.ItemIndex of
    1:
    begin
      where := where + ' excluir_posei_tc <> 0 ';
    end;
    2:
    begin
      where := where + ' excluir_posei_tc = 0 ';
    end;
  end;


  where := where + ') ';
end;

procedure TFMTransitosSimple.ValidarEntradaMaestro;
var
  i: Integer;
  dOut, dIn: TDateTime;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Required and (Trim(Text) = '') then
        begin
          if Trim(RequiredMsg) <> '' then
            raise Exception.Create(RequiredMsg)
          else
            raise Exception.Create('Faltan datos de obligada inserción.');
        end;

      end;
    end;
  end;


  if DMConfig.EsLaFont  or  ( hora_tc.Text <> '' ) then
  begin
    if ( Length( hora_tc.Text ) < 5 ) or  ( Copy( hora_tc.Text, 3, 1 ) <> ':' ) then
    begin
      raise Exception.Create('Falta la hora de salida o el formato no es correcto (hh:mm).');
    end;
  end;
  if ( hora_entrada_tc.Text <> '' ) and ( ( Length( hora_entrada_tc.Text ) < 5 ) or  ( Copy( hora_entrada_tc.Text, 3, 1 ) <> ':' ) ) then
  begin
    raise Exception.Create('El formato de la hora de entrada no es correcto (hh:mm).');
  end;

  if fecha_entrada_tc.Text <> '' then
  begin
    if not TryStrToDate( fecha_tc.Text, dOut ) then
    begin
      raise Exception.Create('Falta la fecha del tránsito o no es correcta.');
    end;
    if not TryStrToDate( fecha_entrada_tc.Text, dIn ) then
    begin
      raise Exception.Create('La fecha de salida no es correcta.');
    end;
    if dIn < dOut then
    begin
      raise Exception.Create('La fecha de entrada en el centro destino debe de ser superior a la de salida del centro origen.');
    end;
  end;

  if porte_bonny_tc.State = cbGrayed then
  begin
    porte_bonny_tc.setFocus;
    raise Exception.Create('Falta seleccionar quien paga el porte.');
  end;
  if Trim(incoterm_tc.text) = '' then
  begin
    QTransitosC.Fieldbyname('incoterm_tc').Value := NULL;
    QTransitosC.Fieldbyname('plaza_incoterm_tc').Value := NULL;
  end;
end;

procedure TFMTransitosSimple.ImprimirAlbaran;
begin
  QLAlbaranTransito2.ALbaran( empresa_tc.Text, centro_tc.Text, referencia_tc.Text,
                 fecha_tc.Text, centro_destino_tc.Text, transporte_tc.Text, Trim(n_cmr_tc.text),
                 QTransitosC);
end;

procedure TFMTransitosSimple.ImprimirCartaPorte;
begin
  CartaTransitoDL.Ejecutar(self, empresa_tc.Text, centro_tc.Text, StrToInt(referencia_tc.Text), StrToDate( fecha_tc.Text ), '');
end;

procedure TFMTransitosSimple.ImprimirFactura;
begin
  LFacturaTransitoProforma.PreviewFactura( self, empresa_tc.Text, centro_tc.Text, StrToInt( referencia_tc.Text ),
                 StrToDate( fecha_tc.Text ) );
end;

procedure TFMTransitosSimple.incoterm_tcChange(Sender: TObject);
begin
  stIncoterm.Caption:= desIncoterm( incoterm_tc.Text );
end;

procedure TFMTransitosSimple.kilos_tlChange(Sender: TObject);
begin
  CalcularImporte;
end;

(*
procedure TFMTransitosSimple.ImprimirCMRMatricial;
begin
  LCMRMatricial.PreCMRTran(empresa_tc.Text, centro_tc.Text, referencia_tc.Text,
             fecha_tc.Text, centro_destino_tc.Text, DSMaestro);
end;
*)

procedure TFMTransitosSimple.ImprimirCertificadoLame;
begin
  UDLCertificadoLame.Ejecutar( self, empresa_tc.Text, centro_tc.Text,
                              StrToInt(referencia_tc.Text), StrToDate(fecha_tc.Text));
end;

procedure TFMTransitosSimple.ImprimirCMRInyeccion;
begin
  UDMCmr.ExecTransitoCMR(empresa_tc.Text, centro_tc.Text, referencia_tc.Text,
             fecha_tc.Text, centro_destino_tc.Text, destino_tc.Text, transporte_tc.Text, DSMaestro);
end;

procedure TFMTransitosSimple.PreguntarCMR;
begin
  if DInfTransitosPreguntar.Preguntar then
  begin
     ImprimirCMRInyeccion;
  end;
  ImprimirAlbaran;
end;

procedure TFMTransitosSimple.SeleccionarInforme;
var bAlbaran, bCartaPorte, bCMR, bFactura, bCertificado, bCertificadoLame: boolean;
begin
  bCertificadoLame := EsCertificadoLame(empresa_tc.Text, centro_tc.Text, Referencia_tc.Text, fecha_tc.Text);
  bAlbaran := false;
  bFactura := false;
  bCertificado := false;
  bCMR := false;

  DInfTransitosSelect.Seleccionar( bAlbaran, bCartaPorte, bCMR, bFactura, bCertificado, bCertificadoLame );
  if bAlbaran then
  begin
    imprimirAlbaran;
  end;

  if bCartaPorte then
  begin
      ImprimirCartaPorte;
  end;


  if bCMR then
  begin
    imprimirCMRInyeccion;
  end;

  if bFactura then
  begin
    imprimirFactura;
  end;

  if bCertificado then
  begin
    imprimirCertificadoLame;
  end;
end;

procedure TFMTransitosSimple.ssEnvaseAntesEjecutar(Sender: TObject);
begin
    ssEnvase.SQLAdi := '';
    if producto_tl.Text <> '' then
      ssEnvase.SQLAdi := ' producto_e = ' +  QuotedStr(producto_tl.Text);
end;

function TFMTransitosSimple.TieneDeposito: boolean;
begin
  with DMAuxDB.QAux do
  try
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('  from frf_depositos_aduana_c ');
    SQL.Add(' where empresa_dac = :empresa ');
    SQL.Add('   and centro_dac = :centro ');
    SQL.Add('   and referencia_dac = :albaran ');
    SQL.Add('   and fecha_dac = :fecha ');

    ParamByName('empresa').AsString := QTransitosC.FieldByName('empresa_tc').AsString;
    ParamByName('centro').AsString := QTransitosC.FieldByName('centro_tc').AsString;
    ParamByName('albaran').AsString := QTransitosC.FieldByName('referencia_tc').AsString;
    ParamByName('fecha').AsString := QTransitosC.FieldByName('fecha_tc').AsString;
    Open;

    result := not isEmpty;
  finally
    close;
  end;
end;

procedure TFMTransitosSimple.Previsualizar;
begin
  DConfigMail.sEmpresaConfig:= empresa_tc.Text;
  DConfigMail.sCentroConfig:= centro_destino_tc.Text;

  if Estado <> teOperacionDetalle then
  begin
    //Dialogo que nos permite seleccionar el informe que deseamos
    SeleccionarInforme;
    (*
    if EsCentroExtranjero( empresa_tc.Text, centro_destino_tc.Text ) then
      SeleccionarInforme
    else
      ImprimirAlbaran;
    *)
  end
  else
  begin
    //Serie de preguntas para imprimir los distintos informes
    PreguntarCMR;
    (*
    if EsCentroExtranjero( empresa_tc.Text, centro_destino_tc.Text ) then
      PreguntarCMR
    else
      ImprimirAlbaran;
    *)
  end;
end;

procedure TFMTransitosSimple.empresa_tcRequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
  isTime := false;
end;

procedure TFMTransitosSimple.empresa_tcChange(Sender: TObject);
begin
  if DSMaestro.DataSet.State = dsBrowse then Exit;
  STEmpresa_tc.Caption := desEmpresa(empresa_tc.Text);
  STCentro_tc.Caption := desCentro(empresa_tc.Text, centro_tc.Text);
  STCentro_destino_tc.Caption := desCentro(empresa_tc.Text, centro_destino_tc.Text);
  STTransporte_tc.Caption := desTransporte(empresa_tc.Text, transporte_tc.Text);

  if DSMaestro.DataSet.State = dsInsert then
  begin
    //if Trim( referencia_tc.text) = ''  then
    GetContador;
  end;
end;

procedure TFMTransitosSimple.centro_tcChange(Sender: TObject);
begin
  if DSMaestro.DataSet.State = dsBrowse then Exit;
  STCentro_tc.Caption := desCentro(empresa_tc.Text, centro_tc.Text);

  if DSMaestro.DataSet.State = dsInsert then
  begin
    //if Trim( referencia_tc.text) = ''  then
    GetContador;
  end;
end;

procedure TFMTransitosSimple.centro_destino_tcChange(Sender: TObject);
begin
  if DSMaestro.DataSet.State = dsBrowse then Exit;
  STCentro_destino_tc.Caption := desCentro(empresa_tc.Text, centro_destino_tc.Text);
end;

procedure TFMTransitosSimple.puerto_tcChange(Sender: TObject);
begin
  stPuerto_tc.Caption := desAduana(puerto_tc.Text);
  PrecioFactura;
end;

procedure TFMTransitosSimple.transporte_tcChange(Sender: TObject);
begin
  if DSMaestro.DataSet.State = dsBrowse then Exit;
  STTransporte_tc.Caption := desTransporte(empresa_tc.Text, transporte_tc.Text);
end;

procedure TFMTransitosSimple.QTransitosCAfterScroll(DataSet: TDataSet);
begin
  if DataSet.State = dsBrowse then
  begin
    STEmpresa_tc.Caption := desEmpresa(DataSet.FieldByName('empresa_tc').AsString);
    STCentro_tc.Caption := desCentro(DataSet.FieldByName('empresa_tc').AsString,
      DataSet.FieldByName('centro_tc').AsString);
    STCentro_destino_tc.Caption := desCentro(DataSet.FieldByName('empresa_tc').AsString,
      DataSet.FieldByName('centro_destino_tc').AsString);
    STTransporte_tc.Caption := desTransporte(DataSet.FieldByName('empresa_tc').AsString,
      DataSet.FieldByName('transporte_tc').AsString);

  end;
end;

procedure TFMTransitosSimple.BGBEmpresa_tcClick(Sender: TObject);
begin
  DespliegaRejilla(BGBEmpresa_tc);
end;

procedure TFMTransitosSimple.BGBCentro_tcClick(Sender: TObject);
begin
  DespliegaRejilla(BGBCentro_tc, [empresa_tc.Text]);
end;

procedure TFMTransitosSimple.BGBCentro_destino_tcClick(Sender: TObject);
begin
  DespliegaRejilla(BGBCentro_destino_tc, [empresa_tc.Text]);
end;

procedure TFMTransitosSimple.BGBpuerto_tcClick(Sender: TObject);
begin
  DespliegaRejilla( BGBpuerto_tc, [] );
end;

procedure TFMTransitosSimple.BGBTransporte_tcClick(Sender: TObject);
var
  sAux: string;
begin
  //DespliegaRejilla(BGBTransporte_tc, [empresa_tc.Text]);
  sAux:= transporte_tc.Text;
  if SeleccionaTransportista( self, transporte_tc, empresa_tc.Text, sAux ) then
  begin
    transporte_tc.Text:= sAux;
  end;
end;

procedure TFMTransitosSimple.BCBCalendarioClick(Sender: TObject);
begin
  DespliegaCalendario(BCBCalendario);
end;

procedure TFMTransitosSimple.QTransitosCNewRecord(DataSet: TDataSet);
begin
  //Valores por defecto
  if estado = teAlta then
  begin
    DataSet.FieldByName('fecha_tc').AsDateTime := Date;
    DataSet.FieldByName('status_gastos_tc').ASString := 'N';
    DataSet.FieldByName('higiene_tc').AsInteger:= 1;
    DataSet.FieldByName('excluir_posei_tc').AsInteger:= 0;
  end;
  //EN LOCALIZAR TAMBIEN INSERTAMOS UN REGISTRO NUEVO, PERO ESTE TOTALMENTE EN
  //BLANCO
  //QTransitosC.FieldByName('porte_bonny_tc').AsInteger:= 1;
end;

procedure TFMTransitosSimple.GetContador;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.add(' select cont_transitos_c from frf_centros ' +
      ' where empresa_c = ' + QuotedStr(empresa_tc.text) +
      ' and centro_c = ' + QuotedStr(centro_tc.Text));
    try
      Open;
    except
      raise Exception.Create('Error al obtener el contador de tránsitos ...');
    end;
    if not IsEmpty then
    begin
      QTransitosC.FieldByName('referencia_tc').AsString := Fields[0].AsString;
      contador := QTransitosC.FieldByName('referencia_tc').AsString;
    end;
    Close;
  end;
end;

procedure TFMTransitosSimple.QTransitosCBeforePost(DataSet: TDataSet);
begin
  with DMBaseDatos.QGeneral do
  begin
    if DataSet.State = dsInsert then
    begin
      if Active then Close;
      SQL.Clear;
      SQL.add(' select cont_transitos_c from frf_centros ' +
        ' where empresa_c = ' + QuotedStr(empresa_tc.text) +
        ' and centro_c = ' + QuotedStr(centro_tc.Text));
      try
        Open;
      except
        raise Exception.Create('Error al obtener el contador de tránsitos ...');
        ShowMessage('Error al obtener el contador de tránsitos ...');
      end;
      if not IsEmpty then
      begin
        if contador = QTransitosC.FieldByName('referencia_tc').AsString then
        begin
          incrementar := true;
          QTransitosC.FieldByName('referencia_tc').AsString := Fields[0].AsString;
        end
        else
        begin
          incrementar := false;
        end;
      end
      else
      begin
        incrementar := false;
      end;
      Close;
    end;
    //UPDATEAR CENTRO DESTINO
    if Active then Close;
    SQL.Clear;
    SQL.add(' UPDATE frf_transitos_l ' +
      ' SET centro_destino_tl = :centro_destino ' +
      ' where empresa_tl = :empresa' +
      ' and centro_tl = :centro ' +
      ' and referencia_tl = :referencia ' +
      ' and fecha_tl = :fecha ');
    ParamByName('empresa').AsString := empresa_tc.text;
    ParamByName('centro').AsString := centro_tc.text;
    ParamByName('referencia').AsString := referencia_tc.text;
    ParamByName('fecha').AsDateTime := StrToDate(fecha_tc.text);
    ParamByName('centro_destino').AsString := centro_destino_tc.text;
    ExecSQL;
  end;
end;

procedure TFMTransitosSimple.QTransitosCAfterPost(DataSet: TDataSet);
begin
  //Para que no hayan problemas esta instruccion no deberia de fallar nunca
  if incrementar then
  begin
    with DMBaseDatos.QGeneral do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.add(' update frf_centros set cont_transitos_c  = ' +
        IntToStr(QTransitosC.FieldByName('referencia_tc').AsInteger + 1) +
        ' where empresa_c = ' +
        QuotedStr(QTransitosC.FieldByName('empresa_tc').AsString) +
        ' and centro_c = ' +
        QuotedStr(QTransitosC.FieldByName('centro_tc').AsString));
      try
        ExecSql;
      except
        raise Exception.Create('Error al actualizar el contador de tránsitos ...');
        ShowMessage('Error al actualizar el contador de tránsitos ...');
      end;
    end;
  end;
end;

procedure TFMTransitosSimple.producto_tlChange(Sender: TObject);
begin
  //if DSDetalle.DataSet.State = dsBrowse then Exit;
  nomProductoT.Caption := desProductoAlta(producto_tl.Text);
  nomCategoriaT.Caption := desCategoria(empresa_tc.Text,
    producto_tl.Text,
    categoria_tl.text);
  nomColorT.Caption := desColor(empresa_tc.TExt,
    producto_tl.text,
    color_tl.Text);
  if Length( envase_tl.Text ) = 3 then
    envase_tlChange( envase_tl );
end;

procedure TFMTransitosSimple.centro_origen_tlChange(Sender: TObject);
begin
  nomCentroFruta.Caption := desCentro(empresa_tc.text, centro_origen_tl.Text);
end;

procedure TFMTransitosSimple.envase_tlChange(Sender: TObject);
var
  bEnvaseVar: Boolean;
begin
  nomEnvaseT.Caption := desEnvase(empresa_tc.Text, envase_tl.Text);
  if TTransitosL.State in [dsInsert, dsEdit] then
  begin
    PutKilosLinea;

    bEnvaseVar:= EnvaseUnidadesVariable( empresa_tc.Text, envase_tl.Text, producto_tl.Text );
    unidades_caja_tl.Enabled:= bEnvaseVar;
    if not bEnvaseVar or ( unidades_caja_tl.Text = '' ) then
    begin
      unidades_caja_tl.Text:= IntToStr( UnidadesEnvase( empresa_tc.Text, envase_tl.Text, producto_tl.Text ) );
    end;
  end;
end;

procedure TFMTransitosSimple.envase_tlExit(Sender: TObject);
begin
  if EsNumerico(envase_tl.Text) and (Length(envase_tl.Text) <= 5) then
    if (envase_tl.Text <> '' ) and (Length(envase_tl.Text) < 9) then
      envase_tl.Text := 'COM-' + Rellena( envase_tl.Text, 5, '0');
end;

procedure TFMTransitosSimple.marca_tlChange(Sender: TObject);
begin
  nomMarcaT.Caption := desMarca(marca_tl.Text);
end;

procedure TFMTransitosSimple.categoria_tlChange(Sender: TObject);
begin
  nomCategoriaT.Caption := desCategoria(empresa_tc.Text,
    producto_tl.Text,
    categoria_tl.text);
end;

procedure TFMTransitosSimple.color_tlChange(Sender: TObject);
begin
  nomColorT.Caption := desColor(empresa_tc.TExt,
    producto_tl.text,
    color_tl.Text);
end;

procedure TFMTransitosSimple.VerDetalle;
begin
  if DSDetalle2.DataSet <> nil then
  begin
    DSDetalle2.DataSet.Cancel;
    DSDetalle2.DataSet := nil;
  end;
  PanelDetalle.Enabled := false;
  PanelDetalle.Visible := PanelDetalle.Enabled;
end;

procedure TFMTransitosSimple.EditarDetalle;
begin
  (*QUEPAIXA*)
  //if DMConfig.giActualBD = 2  then
  if DMConfig.EsLasMoradas then
  begin
    FocoDetalle := producto_tl;
    if centro_origen_tl.Text = '' then
    begin
      centro_origen_tl.Text:= centro_tc.Text;
    end;
  end
  else
  begin
    FocoDetalle := ref_origen_tl;
  end;
  DSDetalle2.DataSet := TTransitosL;
  PanelDetalle.Enabled := TRUE;
  PanelDetalle.Visible := PanelDetalle.Enabled;

  if Length( envase_tl.Text ) = 3 then
    unidades_caja_tl.Enabled:= EnvaseUnidadesVariable( empresa_tc.Text, envase_tl.Text, producto_tl.Text );
end;

procedure TFMTransitosSimple.BGBProducto_tlClick(Sender: TObject);
begin
  producto_tl.Tag := kProducto;
  DespliegaRejilla(BGBProducto_tl, [empresa_tc.Text], TRUE);
end;


procedure TFMTransitosSimple.BGBincoterm_cClick(Sender: TObject);
begin
  Incoterm_tc.tag := kIncoterm;
  DespliegaRejilla(BGBincoterm_c);
end;

procedure TFMTransitosSimple.BGBMarca_tlClick(Sender: TObject);
begin
  Marca_tl.tag := kMarca;
  DespliegaRejilla(BGBMarca_tl);
end;

procedure TFMTransitosSimple.BGBCategoria_tlClick(Sender: TObject);
begin
  Categoria_tl.Tag := kCategoria;
  DespliegaRejilla(BGBCategoria_tl, [empresa_tc.Text, producto_tl.Text]);
end;

procedure TFMTransitosSimple.BGBColor_tlClick(Sender: TObject);
begin
  Color_tl.Tag := kColor;
  DespliegaRejilla(BGBColor_tl, [empresa_tc.Text, producto_tl.Text]);
end;

procedure TFMTransitosSimple.BGBCalibre_tlClick(Sender: TObject);
begin
  Calibre_tl.Tag := kCalibre;
  DespliegaRejilla(BGBCalibre_tl, [empresa_tc.Text, producto_tl.Text]);
end;

procedure TFMTransitosSimple.BGBCentro_origen_tlClick(Sender: TObject);
begin
  Centro_origen_tl.Tag := kCentro;
  DespliegaRejilla(BGBCentro_origen_tl, [empresa_tc.Text]);
end;

procedure TFMTransitosSimple.BCBfecha_origen_tlClick(Sender: TObject);
begin
  DespliegaCalendario(BCBfecha_origen_tl);
end;

procedure TFMTransitosSimple.TTransitosLBeforePost(DataSet: TDataSet);
var
  i: integer;
  kilos: real;
begin
  kilos := 0;

  //Comprobar que no haya campos vacios
  for i := 0 to ListaDetalle.Count - 1 do
  begin
    Objeto := ListaDetalle.Items[i];
    if (Objeto is TBEdit) then
    begin
      if TBEdit(Objeto).Required and (Trim(TBEdit(Objeto).Text) = '') then
      begin
        if CanFocus then Focused;
        raise Exception.Create('Faltan datos de obligada inserción ...');
      end;
    end;
  end;

  //Comprobar la integridad del transito de origen de la fruta
  if TTransitosL.FieldByName('ref_origen_tl').AsString <> '' then
  begin
    with DMBaseDatos.QGeneral do
    begin
      if Active then
        Close;
      SQL.Clear;
      //KILOS DE PRODUCTO TIENE EL TRANSITO de origen actual
      SQL.Add(' SELECT sum(kilos_tl) kilos FROM frf_transitos_l ' +
        ' WHERE empresa_tl = :empresa ' +
        '   AND centro_tl = :centro ' +
        '   AND referencia_tl = :referencia ' +
        '   AND fecha_tl = :fecha ' +
        '   AND producto_tl = :producto ');

      ParamByName('empresa').AsString :=
        TTransitosL.FieldByName('empresa_tl').AsString;
      ParamByName('centro').AsString :=
        TTransitosL.FieldByName('centro_origen_tl').AsString;
      ParamByName('referencia').AsString :=
        TTransitosL.FieldByName('ref_origen_tl').AsString;
      ParamByName('fecha').AsDateTime :=
        TTransitosL.FieldByName('fecha_origen_tl').AsDateTime;
      ParamByName('producto').AsString :=
        TTransitosL.FieldByName('producto_tl').AsString;

      try
        Open;
        if (FieldByName('kilos').Value = NULL) then
        begin
          if centro_origen_tl.CanFocus then centro_origen_tl.Focused;
          raise Exception.Create('Origen de la fruta incorrecto');
        end
        else
        begin
          kilos := FieldByName('kilos').AsFloat;
        end;
      finally
        Close;
      end;

      SQL.Clear;
      //KILOS QUE HAN SALIDO COMO TRANSITOS
      SQL.Add(' SELECT sum(kilos_tl) kilos FROM frf_transitos_l ' +
             //COINCIDA CENTRO DE ORIGEN FRUTA
        ' WHERE empresa_tl = :empresa ' +
        '   AND centro_origen_tl = :centro ' +
        '   AND ref_origen_tl = :referencia ' +
        '   AND fecha_origen_tl = :fecha ' +
        '   AND producto_tl = :producto ');

      ParamByName('empresa').AsString :=
        TTransitosL.FieldByName('empresa_tl').AsString;
      ParamByName('centro').AsString :=
        TTransitosL.FieldByName('centro_origen_tl').AsString;
      ParamByName('referencia').AsString :=
        TTransitosL.FieldByName('ref_origen_tl').AsString;
      ParamByName('fecha').AsDateTime :=
        TTransitosL.FieldByName('fecha_origen_tl').AsDateTime;
      ParamByName('producto').AsString :=
        TTransitosL.FieldByName('producto_tl').AsString;

      try
        Open;
        if (FieldByName('kilos').Value <> NULL) then
        begin
          kilos := kilos - FieldByName('kilos').AsFloat;
        end;
      finally
        Close;
      end;

      //Si estamos modificando pasamos de la linea actual
      if DataSet.State = dsEdit then
      begin
        kilos := kilos + auxKilos;
      end;

      SQL.Clear;
      //KILOS QUE HAN SALIDO COMO SALIDAS
      SQL.Add(' SELECT sum(kilos_sl) kilos FROM frf_salidas_l ' +
        ' WHERE empresa_sl = :empresa ' +
        '   AND centro_origen_sl = :centro ' +
        '   AND ref_transitos_sl = :referencia ' +
        '   AND fecha_sl >= :fecha ' +
        '   AND producto_sl = :producto ');

      ParamByName('empresa').AsString :=
        TTransitosL.FieldByName('empresa_tl').AsString;
       //centro de origen del producto
      ParamByName('centro').AsString :=
        TTransitosL.FieldByName('centro_origen_tl').AsString;
      //referencia del transito
      ParamByName('referencia').AsString :=
        TTransitosL.FieldByName('ref_origen_tl').AsString;
      //fecha del transito
      ParamByName('fecha').AsDateTime :=
        TTransitosL.FieldByName('fecha_origen_tl').AsDateTime;
      //producto
      ParamByName('producto').AsString :=
        TTransitosL.FieldByName('producto_tl').AsString;

      try
        Open;
        if (FieldByName('kilos').Value <> NULL) then
        begin
          kilos := kilos - FieldByName('kilos').AsFloat;
        end;
      finally
        Close;
      end;
      if TTransitosL.fieldbyName('kilos_tl').AsFloat > kilos then
      begin
        if kilos_tl.CanFocus then kilos_tl.Focused;
        raise Exception.Create('Sólo quedan por vender ' +
          FloatToStr(kilos) + ' kilogramos del origen seleccionado.');
      end;
    end;
  end;
end;

procedure TFMTransitosSimple.TTransitosLCalcFields(DataSet: TDataSet);
begin
dataSet.fieldbyname('desEnvase').AsString := desEnvase(DataSet.FieldByName('empresa_tl').AsString, DataSet.FieldByName('envase_tl').AsString);
end;

procedure TFMTransitosSimple.TTransitosLNewRecord(DataSet: TDataSet);
begin
  //Rellenar campos que no vemos
  TTransitosL.FieldByName('empresa_tl').AsString :=
    QTransitosC.FieldByName('empresa_tc').AsString;
  TTransitosL.FieldByName('centro_tl').AsString :=
    QTransitosC.FieldByName('centro_tc').AsString;
  TTransitosL.FieldByName('referencia_tl').AsString :=
    QTransitosC.FieldByName('referencia_tc').AsString;
  TTransitosL.FieldByName('fecha_tl').AsString :=
    QTransitosC.FieldByName('fecha_tc').AsString;
  TTransitosL.FieldByName('centro_destino_tl').AsString :=
    QTransitosC.FieldByName('centro_destino_tc').AsString;

  //Valores por defecto
  TTransitosL.FieldByName('centro_origen_tl').AsString :=
    QTransitosC.FieldByName('centro_tc').AsString;
  {TTransitosL.FieldByName( 'ref_origen_tl').AsString :=
    QTransitosC.FieldByName( 'referencia_tc').AsString;
  TTransitosL.FieldByName( 'fecha_origen_tl').AsString :=
    QTransitosC.FieldByName( 'fecha_tc').AsString;}
end;

procedure TFMTransitosSimple.cajas_tlChange(Sender: TObject);
begin
  if TTransitosL.State in [dsInsert, dsEdit] then
  begin
    PutKilosLinea;
  end;
end;

procedure TFMTransitosSimple.CalcularImporte;
var rKilos, rPrecio, rImporteLinea: Real;
begin
  rKilos := StrToFloatDef(kilos_tl.Text, 0);
  rPrecio := StrToFloatDef(precio_tl.Text, 0);
  rImporteLinea := bRoundTo(rKilos * rPrecio,2);

  importe_linea_tl.Text := FormatFloat('#0.00', rImporteLinea);
end;

procedure TFMTransitosSimple.PutKilosCaja;
begin
  if length(envase_tl.Text) < 3 then
  begin
    KilosCaja := 0;
  end
  else
  begin
    with DMBaseDatos.QGeneral do
    begin
      if Active then
      begin
        Close;
      end;
      SQL.Clear;
      SQL.Add(' SELECT peso_neto_e AS kilos FROM frf_envases ' +
        ' WHERE envase_e = :envase ');
      ParamByName('envase').AsString := envase_tl.Text;
      try
        Open;
        if not IsEmpty then
        begin
          kilosCaja := FieldByName('kilos').AsFloat;
        end;
      finally
        Close;
      end;
    end;
  end;
end;

procedure TFMTransitosSimple.PutKilosLinea;
begin
  PutKilosCaja;
  if kilosCaja <> 0 then
  begin
    if Trim(cajas_tl.Text) <> '' then
    begin
      kilos_tl.Text := FormatFloat('#0', StrToInt(cajas_tl.Text) * kilosCaja);
    end;
  end;
end;

procedure TFMTransitosSimple.TTransitosLBeforeEdit(DataSet: TDataSet);
begin
  auxEnvase := TTransitosL.FieldByName('envase_tl').AsString;
  auxMarca := TTransitosL.FieldByName('marca_tl').AsString;
  auxCategoria := TTransitosL.FieldByName('categoria_tl').AsString;
  auxColor := TTransitosL.FieldByName('color_tl').AsString;
  auxCalibre := TTransitosL.FieldByName('calibre_tl').AsString;
  auxKilos := TTransitosL.FieldByName('kilos_tl').AsFloat;
end;

procedure TFMTransitosSimple.RVisualizacionDblClick(Sender: TObject);
begin
  if FPrincipal.ADModificar.Enabled then
    FPrincipal.ADModificar.Execute;
end;

procedure TFMTransitosSimple.btnGastosClick(Sender: TObject);
begin
  MGastosTransitos.GastosTransito(empresa_tc.text, centro_tc.text,
    referencia_tc.text, fecha_tc.text, transporte_tc.Text,
    Status_gastos_tc.Checked );
end;

procedure TFMTransitosSimple.Borrar;
var botonPulsado: Word;
begin
    //Si la salida esta asociada a una factura
    //contabilizada no se puede modificar
  if Status_gastos_tc.Checked then
  begin
    ShowError('No se puede borrar un tránsito con los gastos asignados.');
    Exit;
  end;

  if TieneDeposito then
  begin
    ShowError(' ATENCION! No se puede borrar un albaran de transito con información en Deposito de Aduanas. ');
    Exit;
  end;


  //Tiene entradas asigndas
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select Trim( empresa_es || '' - '' || centro_salida_es  || '' - ('' || fecha_entrada_es  || '') - '' || n_entrada_es ) entrada ' );
    SQL.Add(' from frf_entradas_sal ');
    SQL.Add(' where empresa_es = :empresa ');
    SQL.Add(' and centro_salida_es = :centro ');
    SQL.Add(' and fecha_salida_es = :fecha ');
    SQL.Add(' and n_salida_es = :albaran');
    SQL.Add(' and transito_es = 1 ');
    ParamByName('empresa').AsString:= QTransitosC.fieldByName('empresa_tc').AsString;
    ParamByName('centro').AsString:= QTransitosC.fieldByName('centro_tc').AsString;
    ParamByName('albaran').AsInteger:= QTransitosC.fieldByName('referencia_tc').AsInteger;
    ParamByName('fecha').AsDateTime:= QTransitosC.fieldByName('fecha_tc').AsDateTime;
    Open;
    if not IsEmpty then
    begin
      ShowError('No se puede borrar un tránsito entradas asignadas -> ' + fieldByName('entrada').AsString );
      Close;
      Exit;
    end;
    Close;
  end;

     //Barra estado
  Estado := teBorrar;
  EstadoDetalle := tedOperacionMaestro;
  BEEstado;
  BHEstado;

     //preguntar si realmente queremos borrar
  botonPulsado := mrNo;
  if VerAdvertencia( Self, #13 + #10 + ' ¿Esta usted seguro de querer borrar el tránsito completo con su detalle asociado?', '    BORRAR TRANSITO',
                     'Quiero borrar el tránsito completo', 'Borrar Tránsito'  ) = mrIgnore then
  //if application.MessageBox('Esta usted seguro de querer borrar la cabecera con todas sus lineas?',
  //  '  ATENCIÓN !', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then
    botonPulsado := mrYes;

  if botonPulsado = mrYes then
    BorrarActivo;

     //Por ultimo visualizamos resultado
  Visualizar;
end;

procedure TFMTransitosSimple.BorrarActivo;
begin
     //Abrir trnsaccion
  try
    AbrirTransaccion(DMBaseDatos.DBBaseDatos);
  except
    ShowError('En este momento no se puede llevar a cabo la operación seleccionada.' + #10 + #13 + 'Por favor vuelva a intentarlo mas tarde.');
    Exit;
  end;

  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    if DMConfig.EsLaFont then
    begin
      SQL.Clear;
      SQL.Add('DELETE FROM frf_gastos_trans ');
      SQL.Add('WHERE empresa_gt=' + quotedstr(empresa_tc.Text) +
        '  and centro_gt=' + quotedstr(centro_tc.Text) +
        '  and referencia_gt=' + referencia_tc.Text +
        '  and fecha_gt=:fecha ');
      ParamByName('fecha').asdatetime := StrToDate(fecha_tc.Text);
      try
        EjecutarConsulta(DMBaseDatos.QGeneral);
      except
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        Exit;
      end;
    end;

    SQL.Clear;
    SQL.Add('DELETE FROM frf_transitos_l ');
    SQL.Add('WHERE empresa_tl=' + quotedstr(empresa_tc.Text) +
      '  and centro_tl=' + quotedstr(centro_tc.Text) +
      '  and referencia_tl=' + referencia_tc.Text +
      '  and fecha_tl=:fecha ');
    ParamByName('fecha').asdatetime := StrToDate(fecha_tc.Text);
    try
      EjecutarConsulta(DMBaseDatos.QGeneral);
    except
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      Exit;
    end;

    //Borrar datos de radio frecuencia de la central
    if DMConfig.EsLaFont then
    begin
      //Borrar radiofrecuencia -DETALLE
      Sql.Clear;
      Sql.Add(' delete ');
      Sql.Add(' from rf_Palet_Pc_Det ');
      Sql.Add(' where ean128_det in ');
      Sql.Add(' ( ');
      Sql.Add('   select ean128_cab ');
      Sql.Add('   from rf_Palet_Pc_Cab ');
      Sql.Add('   where empresa_cab = :empresa ');
      Sql.Add('   and centro_cab = :centro ');
      Sql.Add('   and ref_transito = :referencia ');
      Sql.Add('   and fecha_transito = :fecha ');
      Sql.Add(' ) ');
      ParamByName('empresa').AsString:=empresa_tc.Text;
      ParamByName('centro').AsString:=centro_tc.Text;
      ParamByName('referencia').AsInteger:=StrToInt(referencia_tc.Text);
      ParamByName('fecha').AsDatetime:=StrToDate(fecha_tc.Text);
      try
        ExecSql;
      except
        on E:EDBEngineError do
        begin
          ShowError(E);
          raise;
        end
        else
        begin
          ShowError(' Problemas al borrar las observaciones del tránsito.');
          raise;
        end;
      end;

      //Borrar radiofrecuencia -CABECERA
      Sql.Clear;
      Sql.Add(' delete ');
      Sql.Add(' from rf_Palet_Pc_Cab ');
      Sql.Add(' where empresa_cab = :empresa ');
      Sql.Add(' and centro_cab = :centro ');
      Sql.Add(' and ref_transito = :referencia ');
      Sql.Add(' and fecha_transito = :fecha ');
      ParamByName('empresa').AsString:=empresa_tc.Text;
      ParamByName('centro').AsString:=centro_tc.Text;
      ParamByName('referencia').AsInteger:=StrToInt(referencia_tc.Text);
      ParamByName('fecha').AsDatetime:=StrToDate(fecha_tc.Text);
      try
        ExecSql;
      except
        on E:EDBEngineError do
        begin
          ShowError(E);
          raise;
        end
        else
        begin
          ShowError(' Problemas al borrar las observaciones del tránsito.');
          raise;
        end;
      end;
    end;
  end;

    //Borramos maestro
   //Borrar Cabecera de esta manera, por problemas en sinonimos para tablas de SAT
   with DMBaseDatos.QGeneral do
   begin

     try
      //    QTransitosC.Delete;

       Sql.Clear;
       Sql.Add(' delete ');
       Sql.Add(' from frf_transitos_c ');
       Sql.Add(' where empresa_tc = :empresa ');
       Sql.Add(' and centro_tc = :centro ');
       Sql.Add(' and referencia_tc = :referencia ');
       Sql.Add(' and fecha_tc = :fecha ');
       ParamByName('empresa').AsString:=empresa_tc.Text;
       ParamByName('centro').AsString:=centro_tc.Text;
       ParamByName('referencia').AsInteger:=StrToInt(referencia_tc.Text);
       ParamByName('fecha').AsDatetime:=StrToDate(fecha_tc.Text);

       ExecSql;

    except
      on e: EDBEngineError do
      begin
        ShowError(e);
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        Exit;
      end;
    end;
   end;
  AceptarTransaccion(DMBaseDatos.DBBaseDatos);
  if Registro = Registros then Registro := Registro - 1;
  Registros := Registros - 1;

  QTransitosC.Close;
  QTransitosC.Open;

end;

procedure TFMTransitosSimple.DSMaestroStateChange(Sender: TObject);
begin
  pnlBotones.Enabled := not (QTransitosC.state in [dsInsert, dsEdit]);

  if pnlBotones.Enabled then
  begin
    btnGastos.Enabled := not QTransitosC.IsEmpty and DMConfig.EsLaFont;
    btnSalidas.Enabled := not QTransitosC.IsEmpty;
    btnAduanas.Enabled := not QTransitosC.IsEmpty and (DMConfig.EsLaFontEx or DMConfig.EsLasMoradas);
    btnActivar.Enabled := not QTransitosC.IsEmpty;
  end
  else
  begin
    btnGastos.Enabled := False;
    btnSalidas.Enabled := False;
    btnAduanas.Enabled := False;
    btnActivar.Enabled := False;
  end;
end;

procedure TFMTransitosSimple.DSDetalle2StateChange(Sender: TObject);
begin
  pnlBotones.Enabled := not (DSDetalle2.state in [dsInsert, dsEdit]);
end;

procedure TFMTransitosSimple.btnSalidasClick(Sender: TObject);
begin
  ConsultaTransito( self, empresa_tc.Text, centro_tc.Text,
    StrToInt(referencia_tc.Text),
    StrToDate(fecha_tc.Text));
end;

procedure TFMTransitosSimple.porte_bonny_tcEnter(Sender: TObject);
begin
  porte_bonny_tc.Color:= clMoneyGreen;
end;

procedure TFMTransitosSimple.porte_bonny_tcExit(Sender: TObject);
begin
  porte_bonny_tc.Color:= clBtnFace;
end;

procedure TFMTransitosSimple.AntesDeInsertar;
begin
  empresa_tc.Text:= gsDefEmpresa;
  centro_tc.Text:= gsDefCentro;
  if DMConfig.EsLasMoradas then
  begin
    //destino_tc.Text:= 'ALC/DDA Nº AUT. ESIC03001001';
    destino_tc.Text:= 'ALICANTE';
  end;
  higiene_tc.Visible:= True;
  cbb_higiene_tc.Visible:= False;
end;

procedure TFMTransitosSimple.AntesDeModificar;
var i: Integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
  higiene_tc.Visible:= True;
  cbb_higiene_tc.Visible:= False;
end;

procedure TFMTransitosSimple.AntesDeLocalizar;
begin
  porte_bonny_tc.Visible:= False;
  cbx_porte_bonny_tc.ItemIndex:= 0;
  cbx_porte_bonny_tc.Visible:= True;
  status_gastos_tc.Visible:= False;
  cbx_status_gastos_tc.ItemIndex:= 0;
  cbx_status_gastos_tc.Visible:= DMConfig.EsLaFont;
  excluir_posei_tc.Visible:= False;
  cbx_excluir_posei_tc.ItemIndex:= 0;
  cbx_excluir_posei_tc.Visible:= True;

  nota_tc.Enabled:= False;
  nota_tc.Color:= clBtnFace;

  higiene_tc.Visible:= False;
  cbb_higiene_tc.ItemIndex:= 0;
  cbb_higiene_tc.Visible:= True;
end;

procedure TFMTransitosSimple.AntesDeVisualizar;
var
  i: integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
          Enabled := True;
  end;

  porte_bonny_tc.Visible:= True;
  cbx_porte_bonny_tc.Visible:= False;
  status_gastos_tc.Visible:= DMConfig.EsLaFont;
  cbx_status_gastos_tc.Visible:= False;
  excluir_posei_tc.Visible:= True;
  cbx_excluir_posei_tc.Visible:= False;

  nota_tc.Enabled:= True;
  nota_tc.Color:= clWhite;

  higiene_tc.Visible:= True;
  cbb_higiene_tc.Visible:= False;
end;

procedure TFMTransitosSimple.cbx_status_gastos_tcKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  cbx_status_gastos_tc.DroppedDown:= True;
end;

procedure TFMTransitosSimple.cbx_porte_bonny_tcKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  cbx_porte_bonny_tc.DroppedDown:= True;
end;

function TFMTransitosSimple.EsCentroExtranjero( const AEmpresa, ACentro: string ): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQl.Add('select * ');
    SQl.Add('from frf_centros ');
    SQl.Add('where empresa_c = :empresa ');
    SQl.Add('  and centro_c = :centro ');
    SQl.Add('  and pais_c = ''ES'' ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    Open;
    result:= IsEmpty;
    Close;
  end;
end;

function TFMTransitosSimple.EsCertificadoLame(const AEmpresa, ACentro, AAlbaran, AFecha: String): boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add( ' select cont_lame_dac from frf_depositos_aduana_c ');
    SQL.Add( '  where empresa_dac = :empresa  ');
    SQL.Add( '    and centro_dac = :centro  ');
    SQL.Add( '    and referencia_dac = :albaran  ');
    SQL.Add( '    and fecha_dac = :fecha  ');

    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('albaran').AsString:= AAlbaran;
    ParamByName('fecha').AsString:= AFecha;
    Open;
    if FieldByName('cont_lame_dac').AsString <> '' then
      result := true
    else
      result := false;

    Close;  
  end;
end;

procedure TFMTransitosSimple.nota_tcEnter(Sender: TObject);
begin
  nota_tc.Color:= clMoneyGreen;
end;

procedure TFMTransitosSimple.nota_tcExit(Sender: TObject);
begin
  nota_tc.Color:= clWhite;
end;

procedure TFMTransitosSimple.tipo_palet_tlChange(Sender: TObject);
begin
  stTipo_palet_tl.Caption:= desTipoPalet( tipo_palet_tl.Text );
end;

procedure TFMTransitosSimple.BGBTipoPaletClick(Sender: TObject);
begin
  tipo_palet_tl.tag := kTipoPalet;
  DespliegaRejilla(BGBTipoPalet);
end;

procedure TFMTransitosSimple.ref_origen_tlExit(Sender: TObject);
begin
  //Fecha del transito
  if Estado = teOperacionDetalle then
  if Trim(ref_origen_tl.Text) <> '' then
  begin
    with DMBaseDatos.QGeneral do
    begin
      if Active then
        Close;
      SQL.Clear;
      //KILOS DE PRODUCTO TIENE EL TRANSITO de origen actual
      SQL.Add(' SELECT * ');
      SQL.Add(' FROM frf_transitos_l ');
      SQL.Add(' WHERE empresa_tl = :empresa ');
      SQL.Add(' AND centro_origen_tl <> :centro ');
      SQL.Add(' AND referencia_tl = :referencia ');
      SQL.Add(' AND fecha_tl <= :fecha ');
      SQL.Add(' order by fecha_tl desc ');

      ParamByName('empresa').AsString := empresa_tc.Text;
      ParamByName('centro').AsString := centro_tc.Text;
      ParamByName('referencia').AsString := ref_origen_tl.Text;
      ParamByName('fecha').AsString := fecha_tc.Text;

      try
        Open;
        if IsEmpty then
        begin
          fecha_origen_tl.Text:= '';
          centro_origen_tl.Text:= centro_tc.Text;
        end
        else
        begin
          fecha_origen_tl.Text:= FieldByName('fecha_tl').AsString;
          centro_origen_tl.Text:= FieldByName('centro_origen_tl').AsString;
        end;
      finally
        Close;
      end;
    end;
  end
  else
  begin
    if centro_origen_tl.CanFocus then
    begin
      ref_origen_tl.Text:= '';
      fecha_origen_tl.Text:= '';
      centro_origen_tl.Text:= centro_tc.Text;
    end;
  end;
end;

procedure TFMTransitosSimple.fecha_facontrol_tcChange(Sender: TObject);
begin
  PrecioFactura;
end;

procedure TFMTransitosSimple.PrecioFactura;
var
  rAux: Double;
  dAux: TDateTime;
begin
{
  if DSMaestro.State in [dsInsert, dsEdit] then
  if not tryStrToFloat( precio_facontrol_tc.Text, rAux ) then
  begin
    if ( stPuerto_tc.Caption <> '' ) and TryStrToDate( fecha_facontrol_tc.Text, dAux ) then
    begin
      with DMAuxDB.QAux do
      begin
        SQL.Clear;
        SQL.Add(' select precio_a ');
        SQL.Add(' from frf_aduanas ');
        SQL.Add(' where codigo_a = :puerto ');
        ParamByName('puerto').AsInteger:= StrToIntDef( puerto_tc.Text, 0 );
        Open;
        rAux:= FieldByName('precio_a').AsFloat;
        Close;
        precio_facontrol_tc.Text:= FormatFloat( '#0.000', rAux );
      end;
    end;
  end;
}
end;

procedure TFMTransitosSimple.precio_tlChange(Sender: TObject);
begin
  CalcularImporte;
end;

procedure TFMTransitosSimple.btnAduanasClick(Sender: TObject);
var
  iAux: integer;
  bEsTransito: boolean;
begin
  if not QTransitosC.IsEmpty then
  begin
    bEsTransito:= True;
    iAux:= CFDTransitosAduana.Ejecutar( self, bEsTransito, empresa_tc.Text, centro_tc.Text,
                                 StrToDate( fecha_tc.Text ), StrToInt( referencia_tc.Text ) );
    while iAux <> 0 do
    begin
      if not CRDTransitosAduanaFicha.ImprimirFichaDepositoAduana( self, iAux, empresa_tc.Text ) then
      begin
        ShowMessage('SIN DATOS');
      end;
      iAux:= CFDTransitosAduana.Ejecutar( self, bEsTransito, empresa_tc.Text, centro_tc.Text,
                               StrToDate( fecha_tc.Text ), StrToInt( referencia_tc.Text ) );
    end;
  end
  else
  begin
    ShowMessage('Seleccine primero un tránsito.');
  end;
end;

procedure TFMTransitosSimple.ValidarEntradaDetalle;
var i: Integer;
begin
  //controlar que no hayan campos vacios y que se cumplan las restricciones que no
  //hemos implementado en la base de datos
  for i := 0 to ListaDetalle.Count - 1 do
  begin
    Objeto := ListaDetalle.Items[i];
    if (Objeto is TBDEdit) then
    begin
      with Objeto as TBDEdit do
      begin
        if Required and (Trim(Text) = '') then
        begin
          if Trim(RequiredMsg) <> '' then
            raise Exception.Create(RequiredMsg)
          else
            raise Exception.Create('Faltan datos de obligada inserción.');
          TBEdit(Objeto).setfocus;
        end;
      end;
    end;
  end;

  if nomProductoT.Caption =  '' then
  begin
    if not EsProductoAlta( producto_tl.Text) then
      raise Exception.Create(' ATENCIÓN: Error al grabar la linea, el producto está dado de BAJA. ')
    else
      raise Exception.Create('Falta el producto o es incorrecto.');
  end;


  //Es correcto el envase
  with DMBaseDatos.QAux do
  begin
    Close;
    SQL.Clear;
    SQl.Add(' select * ');
    SQl.Add(' from frf_envases ');
    SQl.Add(' where envase_e = :envase ');
    SQl.Add(' and producto_e = :producto ');

    ParamByName('envase').AsString:= envase_tl.Text;
    ParamByName('producto').AsString:= producto_tl.Text;
    Open;
    if IsEmpty then
    begin
      Close;
      SQL.Clear;
      SQl.Add(' select * ');
      SQl.Add(' from frf_envases ');
      SQl.Add(' where envase_e = :envase ');
      SQl.Add(' and producto_e is null ');
      ParamByName('envase').AsString:= envase_tl.Text;
      Open;
      if IsEmpty then
      begin
        Close;
        raise Exception.Create('La combinación de envase y producto es incorrecta.');
      end;
    end;
    Close;
  end;
end;

procedure TFMTransitosSimple.Activar;
begin
  Enabled:= True;
end;

procedure TFMTransitosSimple.btnActivarClick(Sender: TObject);
var
  Marca: TBookmark;
begin
  if not QTransitosC.IsEmpty then
  begin
    PFTransitoActivar.Activar( empresa_tc.Text, centro_tc.Text, referencia_tc.Text, fecha_tc.Text, fecha_entrada_tc.Text, hora_entrada_tc.Text );
    Marca:= QTransitosC.GetBookmark;
    QTransitosC.DisableControls;
    QTransitosC.Close;
    QTransitosC.Open;
    QTransitosC.GotoBookmark( Marca );
    QTransitosC.FreeBookmark(Marca );
    QTransitosC.EnableControls;
  end
  else
  begin
    ShowMessage('Seleccione primero el transito a activar.');
  end;
end;

end.

