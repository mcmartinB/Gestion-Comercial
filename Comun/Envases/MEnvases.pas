unit MEnvases;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, BDEdit,
  Db, ExtCtrls, StdCtrls, DBCtrls, CMaestro, ComCtrls,
  BEdit, DError, ActnList, Graphics, DBTables, Grids, DBGrids, BGrid,
  Buttons, BSpeedButton, BGridButton, jpeg, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxTextEdit, cxMemo, cxDBEdit;

type
  TFMEnvases = class(TMaestro)
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    ACampos: TAction;
    QEnvases: TQuery;
    PMaestro: TPanel;
    LEnvase_e: TLabel;
    LPeso_envase_e: TLabel;
    LDescripcion_e: TLabel;
    lblPeso: TLabel;
    lblNombre1: TLabel;
    lblNombre3: TLabel;
    lblNombre4: TLabel;
    lblNombre5: TLabel;
    lblNombre8: TLabel;
    lblNombre9: TLabel;
    lblEan13: TLabel;
    btnEan13_e: TBGridButton;
    cbxComercial: TComboBox;
    GroupBox1: TGroupBox;
    lblNombre10: TLabel;
    lblNombre11: TLabel;
    BGBtipo_unidad_e: TBGridButton;
    unidades_e: TBDEdit;
    tipo_unidad_e: TBDEdit;
    STTipo_unidad_e: TStaticText;
    envase_e: TBDEdit;
    peso_envase_e: TBDEdit;
    descripcion_e: TBDEdit;
    peso_neto_e: TBDEdit;
    agrupacion_e: TBDEdit;
    envase_comercial_e: TDBCheckBox;
    GroupBox2: TGroupBox;
    descripcion2_e: TBDEdit;
    RejillaFlotante: TBGrid;
    fecha_baja_e: TBDEdit;
    cbxVer: TComboBox;
    peso_variable_e: TDBCheckBox;
    ean13_e: TBDEdit;
    QEnvasesCliente: TQuery;
    lbl1: TLabel;
    precio_diario_e: TDBCheckBox;
    lblTipIva: TLabel;
    tipo_iva_e: TDBComboBox;
    lblDesTipoIva: TLabel;
    btnAgrupacion: TBGridButton;
    qryDesCliente: TQuery;
    dsDesCliente: TDataSource;
    qrySecContable: TQuery;
    dsSecContable: TDataSource;
    pgcDetalle: TPageControl;
    tsDescripcionCliente: TTabSheet;
    btnEnvaseCliente: TPanel;
    dbgDesCliente: TDBGrid;
    tsSeccionContable: TTabSheet;
    tsImagen: TTabSheet;
    Image: TImage;
    bvl1: TBevel;
    pnlSeccionContable: TPanel;
    dbgSeccionContable: TDBGrid;
    lbl2: TLabel;
    env_comer_operador_e: TBDEdit;
    btnEnvComerOperador: TBGridButton;
    txtOperador: TStaticText;
    txt_env_comer: TStaticText;
    btnEnvComerProducto: TBGridButton;
    env_comer_producto_e: TBDEdit;
    lblEnvase: TLabel;
    unidades_variable_e: TDBCheckBox;
    lblTipoEnvase: TLabel;
    tipo_e: TDBComboBox;
    lblDesTipoEnvase: TLabel;
    lblAgrupaComer: TLabel;
    agrupa_comercial_e: TBDEdit;
    btnAgrupaComer: TBGridButton;
    lblTipoCaja: TLabel;
    tipo_caja_e: TBDEdit;
    btnTipoCaja: TBGridButton;
    des_tipo_caja: TStaticText;
    QEan13: TQuery;
    DSEan13: TDataSource;
    tsEan13: TTabSheet;
    dbgEan13: TDBGrid;
    pnlPasarSGP: TPanel;
    Label1: TLabel;
    producto_e: TBDEdit;
    BGBProducto: TBGridButton;
    des_producto_e: TStaticText;
    pEnvasOld: TPanel;
    Label2: TLabel;
    empresaold_e: TBDEdit;
    envaseold_e: TBDEdit;
    tsAntiguoEnv: TTabSheet;
    QEnvOld: TQuery;
    DSEnvOld: TDataSource;
    DBGrid1: TDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    notas_e: TcxDBMemo;
    qAux: TQuery;
    tsDesglose: TTabSheet;
    DBGrid2: TDBGrid;
    dsDesglose: TDataSource;
    QDesglose: TQuery;
    pnlDesglose: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure envase_comercial_eEnter(Sender: TObject);
    procedure envase_comercial_eExit(Sender: TObject);
    procedure notas_eEnter(Sender: TObject);
    procedure notas_eExit(Sender: TObject);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure EnvaseClienteClick(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
    procedure FormDeactivate(Sender: TObject);
    procedure envase_eExit(Sender: TObject);
    procedure descripcion_eEnter(Sender: TObject);
    procedure QEnvasesAfterPost(DataSet: TDataSet);

    procedure QEnvasesAfterOpen(DataSet: TDataSet);
    procedure QEnvasesBeforeClose(DataSet: TDataSet);
    procedure pnlSeccionContableClick(Sender: TObject);
    procedure tipo_eChange(Sender: TObject);
    procedure pnlPasarSGPClick(Sender: TObject);
    procedure Clonar;
    procedure producto_eChange(Sender: TObject);
    procedure pnlDesgloseClick(Sender: TObject);
    procedure change(Sender: TObject);
    procedure tipo_iva_eChange(Sender: TObject);

    //procedure ACamposExecute(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    FRegistroABorrarEnvaseId: String;

    procedure ValidarEntradaMaestro;
    procedure AntesDeBorrarMaestro;

    procedure AbrirTablas;
    procedure CerrarTablas;
    procedure BuscarEnvase( const AProducto, AEnvase: string );
    procedure RefrescarEnvase;
    function  AbrirConexion: Boolean;
    procedure CerrarConexion;
    procedure GetEnvaseBDRemota( const ABDRemota: string; const AAlta: Boolean );


    procedure Changetipo_e;
    procedure Changetipo_iva_e;
    procedure ActualizarNotas_e;

    function ObtenerEmpresaEAN13(const AEnvase: String): string;
    function EsArticuloDesglosado: boolean;

  protected
    procedure AlBorrar;
    procedure DespuesDeBorrar;

    procedure SincronizarWeb; override;

  public
    { Public declarations }
    procedure Altas; override;
    procedure Modificar; override;
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeModificar;
    procedure AntesDeInsertar;
    procedure AntesDeVisualizar;
    procedure AntesDeLocalizar;

    function ObtenerCodigoEnvase: string;

    //Listado
    procedure Previsualizar; override;
    procedure PreviewListado( const AVerClientes: Boolean );
    procedure PreviewFicha;

    function EsCargadoEnAlbaran: boolean;

  end;

//var
  //FMEnvases: TFMEnvases;

implementation

uses Variants, CVariables, CGestionPrincipal, UDMBaseDatos, CAuxiliarDB, Principal,
  LEnvases, DPreview, UDMAuxDB, bSQLUtils, CReportes, bDialogs, CliEnvases,
  UDMconfig, EnvSeccionesContables,  ImportarEnvasesFD,
  AdvertenciaFD, SeleccionarTipoAltaFD, FichaListadoFD, EnvasesDL, UFEnvases,
  UComerToSgpDM, CGlobal, SeleccionarAltaEnvaseFD, bTextUtils, ArticuloDesglose,
  SincronizacionBonny;

{$R *.DFM}


procedure TFMEnvases.BuscarEnvase( const AProducto, AEnvase: string );
begin
 {+}Select := ' SELECT * FROM frf_envases ';
 if AProducto <> '' then
   {+}where := ' WHERE envase_e=' + QuotedStr(AEnvase) +
               ' and producto_e=' + QuotedStr(AProducto)
 else
   {+}where := ' WHERE envase_e=' + QuotedStr(AEnvase);
 {+}Order := ' ORDER BY envase_e ';

 QEnvases.Close;
 AbrirTablas;
 Visualizar;
end;

procedure TFMEnvases.RefrescarEnvase;
var
  myBookMark: TBookmark;
begin
  myBookMark:= QEnvases.GetBookmark;
  QEnvases.Close;
  QEnvases.Open;
  QEnvases.GotoBookmark(myBookMark);
  QEnvases.FreeBookmark(myBookMark);
end;

procedure TFMEnvases.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DataSetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
  end;
     //Estado inicial
  Registros := DataSetMaestro.RecordCount;
  if Registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;

  with qryDesCliente do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ce empresa, cliente_ce || '' - '' || nombre_c cliente, unidad_fac_ce unidad, descripcion_ce descripcion, ');
    SQL.Add('        caducidad_cliente_ce caducidad, min_vida_cliente_ce min_vida, max_vida_cliente_ce max_vida ');
    SQL.Add(' from frf_clientes_env join frf_clientes on cliente_ce = cliente_c ');
    SQL.Add(' where envase_ce = :envase_e ');
  end;

  with qrySecContable do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_esc empresa, centro_esc centro, seccion_esc seccion, descripcion_sc descripcion ');
    SQL.Add(' from frf_env_sec_contables, frf_secciones_contables ');
    SQL.Add(' where envase_esc = :envase_e ');
    SQL.Add(' and empresa_sc = empresa_esc ');
    SQL.Add(' and seccion_esc = seccion_sc ');
  end;
                                                                                             
  with QEnvOld.SQL do
  begin
    Clear;
    Add(' select empresa, nombre_e, oldenvase');
    Add('   from cambios_envase ');
    Add('     join frf_empresas on empresa = empresa_e ');
    Add('  where newenvase = :envase_e ');
    Add('  order by empresa, oldenvase ');
  end;

  with QDesglose do
  begin
    SQL.Clear;
    SQL.Add(' select producto_desglose_ad, descripcion_p desProducto, porcentaje_ad ');
    SQL.Add(' from frf_articulos_desglose join frf_productos on producto_desglose_ad = producto_p ');
    SQL.Add(' where articulo_ad = :envase_e ');
  end;

end;

procedure TFMEnvases.ActualizarNotas_e;
begin
  with QAux do
  begin
    SQL.Clear;

    SQL.Add(' select * from frf_envases ');
    SQL.Add(' where envase_e =' + QuotedStr(envase_e.Text) + ' ');
    Open;
    if not isEmpty then
    begin
      Edit;

      Fieldbyname('notas_e').AsString := notas_e.Text;
      Post;
    end;
    Close;
  end;
end;

procedure TFMEnvases.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMEnvases.change(Sender: TObject);
begin

end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEnvases.FormCreate(Sender: TObject);

begin
  MultiplesAltas:= false;
     //Variables globales
  M := Self;
  MD := nil;

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

  Ean13_e.Visible:= True;
  lblEan13.Visible:= True;
  btnEan13_e.Visible:= True;
  ean13_e.DataSource:= DSMaestro;

     //***************************************************************
     //Fuente de datos maestro
     //CAMBIAR POR LA QUERY QUE LE TOQUE
 {+}DataSetMaestro := QEnvases;
     //***************************************************************

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_envases ';
 {+}where := '   WHERE envase_e=' + QuotedStr('###');
 {+}Order := '   ORDER BY envase_e ';
     //Abrir tablas/Querys
  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Close;
      Exit;
    end;
  end;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Visualizar estado inicial
  Visualizar;

  producto_e.Tag := kProducto;
  tipo_unidad_e.Tag := kTipoUnidad;
  ean13_e.Tag := kEan13Envase;
  agrupacion_e.Tag:= kAgrupacionEnvase;
  env_comer_operador_e.Tag := kEnvComerOperador;
  env_comer_producto_e.Tag := kEnvComerProducto;
  agrupa_comercial_e.Tag:= kAgrupacionComercial;
  tipo_caja_e.Tag := kTipoCaja;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnBeforeMasterDelete := AntesDeBorrarMaestro;
  OnEdit := AntesDeModificar;
  OnInsert := AntesDeInsertar;
  OnView := AntesDeVisualizar;
  OnBrowse := AntesDeLocalizar;

  // Sincronizacion Web
  //OnBeforeMasterDelete := AlBorrar;
  OnAfterMasterDeleted := DespuesDeBorrar;

     //Focos
  FocoAltas := producto_e;
  FocoModificar := descripcion_e;
  FocoLocalizar := envase_e;

     //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

  QEnvasesCliente.SQL.Clear;
  QEnvasesCliente.SQL.Add(' select cliente_ce, unidad_fac_ce, descripcion_ce, n_palets_ce, kgs_palet_ce ');
  QEnvasesCliente.SQL.Add(' from frf_clientes_env ');
  QEnvasesCliente.SQL.Add(' where producto_ce = :producto_e ');
  QEnvasesCliente.SQL.Add(' and envase_ce = :envase_e ');

  with QEan13.SQL do
  begin                                                     
    Clear;
    Add('select distinct empresa_e, codigo_e, descripcion_e');
    Add('from frf_ean13');
    Add('where envase_E = :envase_E');
    Add('and productop_e = :producto_e');
    Add('and agrupacion_e = 2');
    Add('and fecha_baja_E is null');
    Add('order by 1');
  end;

  pgcDetalle.Enabled:= True;
  pgcDetalle.ActivePage:= tsDescripcionCliente;
  tsSeccionContable.TabVisible:= DMConfig.EsLaFont;
  btnEnvaseCliente.Enabled:= DMConfig.EsLaFont;
  if btnEnvaseCliente.Enabled then
  begin
    btnEnvaseCliente.Font.Color:= clBlue;
  end
  else
  begin
    btnEnvaseCliente.Font.Color:= clSilver;
  end;
  pnlDesglose.Enabled := DMConfig.EsLaFont;
  if pnlDesglose.Enabled then
    pnlDesglose.Font.Color:= clBlue
  else
    pnlDesglose.Font.Color:= clSilver;
  tipo_e.itemindex:= 0;
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
    pnlPasarSGP.Visible:= False
  else
    pnlPasarSGP.Visible:= DMConfig.EsLosLLanos or DMConfig.EsLaFontEx;
end;

procedure TFMEnvases.FormActivate(Sender: TObject);
begin
  Top := 1;
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
//     gCF:=CalendarioFlotante;


     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMEnvases.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CerrarConexion;
  Lista.Free;

  gRF := nil;
  gCF := nil;

     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
     //Codigo de desactivacion
  CerrarTablas;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMEnvases.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

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

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************
//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que concuerdan
//con los capos que hemos rellenado

procedure TFMEnvases.Filtro;
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
        if name <> 'descripcion_pb' then
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
  end;

  if cbxVer.ItemIndex <> 0 then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if cbxVer.ItemIndex = 1 then
      where := where + ' fecha_baja_e is null'
    else
      where := where + ' fecha_baja_e is not null';
  end;

  if tipo_iva_e.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    where := where + ' tipo_iva_e = ' + tipo_iva_e.Text;
  end;

  if tipo_e.Text <> '' then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    where := where + ' tipo_e = ' + Copy(tipo_e.Text,1,1);
  end;

  if cbxComercial.ItemIndex <> 0 then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if cbxComercial.ItemIndex = 1 then
      where := where + ' envase_comercial_e = ''S'''
    else
      where := where + ' envase_comercial_e = ''N''';
  end;

  if peso_variable_e.State <> cbGrayed then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if peso_variable_e.Checked  then
      where := where + ' peso_variable_e <> 0'
    else
      where := where + ' peso_variable_e = 0';
  end;

  if unidades_variable_e.State <> cbGrayed then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if unidades_variable_e.Checked  then
      where := where + ' unidades_variable_e <> 0'
    else
      where := where + ' unidades_variable_e = 0';
  end;

  if precio_diario_e.State <> cbGrayed then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if precio_diario_e.Checked  then
      where := where + ' precio_diario_e <> 0'
    else
      where := where + ' precio_diario_e = 0';
  end;

  if flag then where := ' WHERE ' + where;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMEnvases.AnyadirRegistro;
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
  where := where + ') ';
end;


//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required
procedure TFMEnvases.AntesDeBorrarMaestro;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_salidas_l ');
    SQL.Add(' where envase_sl = :envase ');
    ParamByName('envase').AsString:= envase_e.Text;
    Open;
    if not IsEmpty then
    begin
      Close;
      raise Exception.Create('No se puede borrar el artículo, ya se han realizado ventas.');
    end;
    Close;
  end;

  if ( not qryDesCliente.IsEmpty ) or ( not qrySecContable.IsEmpty ) or
     ( not QEan13.IsEmpty ) or ( not QDesglose.IsEmpty) then
  begin
    raise Exception.Create('No se puede borrar el artículo, primero borre el detalle.');
  end;

  FRegistroABorrarEnvaseId := DSMaestro.Dataset.FieldByName('envase_e').asString;
end;



procedure TFMEnvases.ValidarEntradaMaestro;
var
  i: Integer;
  sAux: string;
begin
    //Que no hayan campos vacios
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
  if ean13_e.Text = ''  then
    DSMaestro.DataSet.FieldByName('ean13_e').Value:= NULL;

  if agrupacion_e.Text = '' then
  begin
     if agrupacion_e.CanFocus then
       agrupacion_e.SetFocus;
     raise Exception.Create('Es necesario introducir una agrupación.');
  end;

  if agrupa_comercial_e.Text = '' then
  begin
     if agrupa_comercial_e.CanFocus then
       agrupa_comercial_e.SetFocus;
     raise Exception.Create('Es necesario introducir una agrupación comercial.');
  end;
{
  (*BAG*)
  //Buscar si esta grabado
  sAux:= '';
  if ( Estado = teAlta ) and ( Copy( Trim( empresa_e.Text ),1,1) = 'F' )then
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_envases ');
      SQL.Add(' where empresa_e = ' + QuotedStr( Trim( empresa_e.Text ) ) );
      SQL.Add(' and envase_e = ' + QuotedStr( Trim( envase_e.Text ) ) );
      SQL.Add(' and producto_e = ' + QuotedStr( Trim( producto_e.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        sAux:= 'Envase duplicado. (' + Trim( empresa_e.Text ) + '-' + QuotedStr( Trim( envase_e.Text ) ) + '-' + Trim( des_producto_e.Caption ) + '-' + Trim( descripcion_e.Text )  + ').';
        Close;
        raise Exception.Create( sAux );
      end;
      Close;

      sAux:= '';
      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_envases ');
      SQL.Add(' where empresa_e matches ''F*'' ');
      SQL.Add(' and envase_e = ' + QuotedStr( Trim( envase_e.Text ) ) );
      SQL.Add(' and producto_e <> ' + QuotedStr( Trim( producto_e.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        if FieldByName('descripcion_e').AsString <> descripcion_e.Text then
        begin
          sAux:= sAux + #13 + #10 + 'Ya hay un envase con el mismo código y diferente producto base (' + desProductoBase( empresa_e.Text, FieldByName('producto_e').AsString ) + ').';
          Close;
          raise Exception.Create( sAux );
        end;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_envases ');
      SQL.Add(' where empresa_e matches ''F*'' ');
      SQL.Add(' and envase_e = ' + QuotedStr( Trim( envase_e.Text ) ) );
      SQL.Add(' and producto_e = ' + QuotedStr( Trim( producto_e.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        if FieldByName('descripcion_e').AsString <> descripcion_e.Text then
        begin
          sAux:= sAux + #13 + #10 +  'Ya hay un envase con el mismo código y diferente descripción (' + FieldByName('descripcion_e').AsString + ').';
          Close;
          raise Exception.Create( sAux );
        end;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_envases ');
      SQL.Add(' where empresa_e matches ''F*'' ');
      SQL.Add(' and descripcion_e = ' + QuotedStr( Trim( descripcion_e.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        if ( FieldByName('envase_e').AsString <> envase_e.Text ) or
           ( FieldByName('producto_e').AsString <> producto_e.Text ) then
        begin
          sAux:= sAux + #13 + #10 +  'Ya hay un envase con la misma descripción y diferente código (' + FieldByName('envase_e').AsString + '-' + Trim( des_producto_e.Caption ) + ').';
          //Close;
          //raise Exception.Create( sAux );
        end;
      end;
      Close;

      if sAux <> '' then
      begin
        if VerAdvertencia( Self, sAux ) = mrOk then
          Abort;
      end;
    end;
  end;
 }
  if Trim(env_comer_operador_e.Text) = '' then
    QEnvases.FieldByName('env_comer_operador_e').Value := null;
  if Trim(env_comer_producto_e.Text) = '' then
    QEnvases.FieldByName('env_comer_producto_e').Value := null;


  if lblDesTipoIva.Caption = '' then
  begin
    tipo_unidad_e.SetFocus;
    raise Exception.Create( 'Es necesario indicar el tipo de IVA ' + #13 + #10 +
                            '0 - Superreducido, productos frescos ' + #13 + #10 +
                            '1 - Reducido, cuarta gama ' + #13 + #10 +
                            '2 - General, otros ' + #13 + #10 +
                            'Para cualquier duda pongase en contacto con el departamento de comercial. ' );
  end;


  if unidades_e.Text = '' then
  begin
    unidades_e.Text:= '0';
    QEnvases.FieldByName('unidades_e').AsInteger:= 0;
  end;
  (*
  QEnvases.FieldByName('unidades_e').AsInteger:= StrToIntDef(unidades_e.Text,0);
  if QEnvases.FieldByName('unidades_e').AsInteger < 1 then
    QEnvases.FieldByName('unidades_e').AsInteger:= 1;
  *)
{
    if Trim( master_e.Text ) <> '' then
  begin
    if master_e.Text = envase_e.Text then
    begin
      raise Exception.Create('El artículo no puede ser maestro de si mismo.');
    end;
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('select producto_e ');
      SQL.Add('from frf_envases ');
      SQL.Add('where envase_E = :envase ');
      ParamByName('envase').AsString:= master_e.Text;
      Open;
      if not IsEmpty then
      begin
        if FieldByName('producto_e').AsString <> producto_e.Text then
        begin
          Close;
          raise Exception.Create('El maestro debe tener el mismo producto.');
        end
        else
        begin
          Close;
        end;
      end
      else
      begin
        Close;
        raise Exception.Create('No existe el artículo maestro.');
      end;

      SQL.Clear;
      SQL.Add('select master_e ');
      SQL.Add('from frf_envases ');
      SQL.Add('where envase_E = :envase ');
      SQL.Add('and master_e is not null ');
      ParamByName('envase').AsString:= master_e.Text;
      Open;
      if not IsEmpty then
      begin
        sAux:= FieldByName('master_e').AsString;
        Close;
        raise Exception.Create('El maestro no puede ser un envase que ya tiene maestro [' + sAux + '].');
      end;
      Close;
    end;
  end
  else
  begin
    QEnvases.FieldByName('master_e').Value:= Null;
  end;
}
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMEnvases.Previsualizar;
begin
  case FichaOrListado( Self ) of
    1: PreviewFicha;
    2: PreviewListado( False );
    3: PreviewListado( True );
  end;
end;

procedure TFMEnvases.PreviewListado( const AVerClientes: Boolean );
var
  enclave: TBookMark;
begin
  //Crear el listado
  enclave := DataSetMaestro.GetBookmark;
  QRLEnvases := TQRLEnvases.Create(Application);
  PonLogoGrupoBonnysa(QRLEnvases);
  //QRLEnvases.DataSet := QEnvases;
  if AVerClientes then
    QEnvasesCliente.Open;
  try
    try
      Preview(QRLEnvases);
    except
      FreeAndNil( QRLEnvases );
      raise;
    end;
  finally
    DataSetMaestro.GotoBookmark(enclave);
    DataSetMaestro.FreeBookmark(enclave);
    QEnvasesCliente.Close;
  end;
end;

procedure TFMEnvases.PreviewFicha;
begin
  if QEnvases.FieldByname('envase_e').AsString <> '' then
    ShowFichaEnvase( Self, QEnvases.FieldByname('envase_e').AsString,
                           QEnvases.FieldByname('producto_e').AsString );
end;


//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMEnvases.AntesDeModificar;
var i: Integer;
begin
  //Deshabilitamos todos los componentes Modificable=False
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;

  peso_variable_e.AllowGrayed:= False;
  unidades_variable_e.AllowGrayed:= False;
  precio_diario_e.AllowGrayed:= False;

  pgcDetalle.Enabled:= False;
end;

procedure TFMEnvases.GetEnvaseBDRemota( const ABDRemota: string; const AAlta: Boolean );
var
  sProducto, sEnvase: string;
  iValue: Integer;
  bAlta: Boolean;
begin
  sProducto:= producto_e.Text;
  if AAlta then
    sEnvase:= ''
  else
    sEnvase:= envase_e.Text;
  bAlta:= AAlta;

  iValue:= ImportarEnvase( Self, ABDRemota, sProducto, sEnvase, bAlta );
  case iValue of
      -1: //Operacion cancelada
          begin end;
       1: begin
            if bAlta then
            begin
              BuscarEnvase( sProducto, sEnvase );
              //ShowMessage('Alta de envase correcta.');
            end
            else
            begin
              RefrescarEnvase;
              //ShowMessage('Modificación de envase correcta.');
            end;
          end;
       else ShowMessage('Error ' + IntToStr( iValue ) + ' al importar el artículo.');
  end;
end;

procedure TFMEnvases.CerrarConexion;
begin
  if DMBaseDatos.BDCentral.Connected then
  begin
    DMBaseDatos.BDCentral.Connected:= False;
  end;
end;

function  TFMEnvases.AbrirConexion: Boolean;
begin
  if DMBaseDatos.BDCentral.Connected then
  begin
    Result:= True;
  end
  else
  begin
    try
      DMBaseDatos.BDCentral.Connected:= True;
      Result:= True;
    except
      Result:= False;
    end;
  end;
end;

procedure TFMEnvases.Modificar;
var
  iTipo: Integer;
  sBD: string;
begin
  //inherited Modificar;
  if DMConfig.EsLaFontEx then
  begin
{
    if DMBaseDatos.GetPermiso( gsCodigo, 'imp_env_almacen' ) = 1 then
    begin
      if SeleccionarTipoAltaFD.SeleccionarTipoAlta( Self, iTipo, sBD,
                                '     SELECCIONAR TIPO ACTUALIZACIÓN', 'Editar Registro Local'  ) = mrOk then
      begin
        case iTipo of
          0: inherited Modificar;
          1: GetEnvaseBDRemota( sBD, False );
        end;
      end
    end
    else
    begin
}
      inherited Modificar;

//    end;
  end
  else
  begin
    if AbrirConexion then
    begin
      GetEnvaseBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Cualquier cambio que realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer modificaciones locales', 'Modificar Artículo') = mrIgnore then
        inherited Modificar;
    end;
  end;
end;

procedure TFMEnvases.AlBorrar;
begin
  FRegistroABorrarEnvaseId := DSMaestro.Dataset.FieldByName('envase_e').asString;
end;

procedure TFMEnvases.Altas;
var
  iTipo: Integer;
  sBD: string;
begin
  //inherited Altas;
  if DMConfig.EsLaFontEx then
  begin
    if DMBaseDatos.GetPermiso( gsCodigo, 'imp_env_almacen' ) = 1 then
    begin
      if SeleccionarAltaEnvaseFD.SeleccionarTipoAlta( Self, iTipo, sBD ) = mrOk then
      begin
        case iTipo of
          0: inherited Altas;
          1: Clonar;
          2: GetEnvaseBDRemota( sBD, True );
        end;
      end
    end
    else
    begin
      inherited Altas;
    end;
  end
  else
  begin
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetEnvaseBDRemota( 'BDCentral', True );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Envase') = mrIgnore then
        inherited Altas;
    end;
  end;
end;

procedure TFMEnvases.AntesDeInsertar;
begin
  //Deshabilitamos el campo envase_e, se genera codigo automatico
  envase_e.Enabled := False;
  envase_e.Text := ObtenerCodigoEnvase;

  envase_comercial_e.Field.Value := 'N';
  unidades_variable_e.Checked:= False;
  peso_variable_e.Checked:= False;
  precio_diario_e.Checked:= False;

  peso_variable_e.AllowGrayed:= False;
  unidades_variable_e.AllowGrayed:= False;  
  precio_diario_e.AllowGrayed:= False;
  tipo_iva_e.Text:= '';
  tipo_iva_e.ItemIndex:= 0;

  pgcDetalle.Enabled:= False;

  tipo_e.Text:= '0';
  tipo_e.ItemIndex:= 0;
end;

procedure TFMEnvases.AntesDeLocalizar;
begin
  cbxVer.ItemIndex := 0;
  cbxVer.Enabled := True;

  envase_comercial_e.Visible:= False;
  cbxComercial.ItemIndex:= 0;
  cbxComercial.Visible:= True;

  peso_variable_e.AllowGrayed:= True;
  unidades_variable_e.AllowGrayed:= True;
  precio_diario_e.AllowGrayed:= True;

  pgcDetalle.Enabled:= False;

  pEnvasOld.Visible := True;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEnvases.AntesDeVisualizar;
var i: Integer;
begin
  cbxVer.Enabled := False;
  pEnvasOld.Visible := False;

    //Resaturamos estado controles
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;

  envase_comercial_e.Visible:= True;
  cbxComercial.Visible:= False;
  peso_variable_e.AllowGrayed:= False;
  unidades_variable_e.AllowGrayed:= False;  
  precio_diario_e.AllowGrayed:= False;

  if EsArticuloDesglosado then
    tsDesglose.TabVisible := true
  else
    tsDesglose.TAbVisible := false;

  pgcDetalle.Enabled:= True;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************


//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMEnvases.RequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
  isTime := false;
  if TBEdit(Sender).CanFocus then
  begin
    if (Estado = teLocalizar) then
      Exit;
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
    isTime := true;
  end;
end;

procedure TFMEnvases.SincronizarWeb;
begin
  SincroBonnyAurora.SincronizarEnvase(DSMaestro.Dataset.FieldByName('envase_e').asString);
  SincroBonnyAurora.Sincronizar;
end;

procedure TFMEnvases.envase_comercial_eEnter(Sender: TObject);
begin
  envase_comercial_e.Color := clHighlight;
end;

procedure TFMEnvases.envase_comercial_eExit(Sender: TObject);
begin
  envase_comercial_e.Color := clBtnFace;
end;

procedure TFMEnvases.notas_eEnter(Sender: TObject);
begin
  KeyPreview := false;
end;

procedure TFMEnvases.notas_eExit(Sender: TObject);
begin
  KeyPreview := True;
end;

function TFMEnvases.ObtenerCodigoEnvase: string;
var iCodigo: Integer;
    sCadena: string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(envase_e) envase from frf_envases ');

    Open;
    if IsEmpty then
      sCadena := 'COM-00000'
    else
    begin
      iCodigo := StrToInt(Copy(fieldbyname('envase').AsString, 5,5)) + 1;
      sCadena := 'COM-' + FormatFloat('00000', iCodigo);
    end;

    Result := sCadena;

    Close;
  end;
end;

function TFMEnvases.ObtenerEmpresaEAN13(const AEnvase: String): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select MIN(empresa_e) empresa from frf_ean13 ');
    SQL.Add('  where envase_e = :envase ');
    ParamByName('envase').AsString:= envase_e.Text;
    Open;
    if not IsEmpty then
      result := Fieldbyname('empresa').AsString
    else
      result := gsDefEmpresa;

    Close;
  end;

end;

procedure TFMEnvases.pnlDesgloseClick(Sender: TObject);
begin
  if gscodigo <> 'informix' then
  begin
    if EsCargadoEnAlbaran then
    begin
      raise Exception.Create('No se puede modificar el desglose del artículo, ya se han realizado ventas.');
      exit;
    end;
  end;

  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    ArticuloDesgloseM( envase_e.Text, producto_e.Text );
    QDesglose.Close;
    QDesglose.Open;
  end;
end;

procedure TFMEnvases.ARejillaFlotanteExecute(Sender: TObject);
var
  sAux: string;
begin
  case ActiveControl.Tag of
    kProducto: DespliegaRejilla(BGBProducto);
    kTipoUnidad: DespliegaRejilla(BGBtipo_unidad_e, [gsDefEmpresa, producto_e.Text]);                                            
    kEan13Envase: DespliegaRejilla(btnEan13_e, [gsDefEmpresa, envase_e.Text]);
    kAgrupacionEnvase: DespliegaRejilla( btnAgrupacion );
    kEnvComerOperador: DespliegaRejilla(btnEnvComerOperador);
    kEnvComerProducto: DespliegaRejilla(btnEnvComerProducto,[env_comer_operador_e.Text]);
    kAgrupacionComercial: DespliegaRejilla( btnAgrupaComer );
    kTipoCaja: DespliegaRejilla(btnTipoCaja);
{
    kEnvase:
    begin
      sAux:= master_e.Text;
      if SeleccionaEnvases( self, master_e, sAux ) then
      begin
        master_e.Text:= sAux;
      end;
    end;
}
  end;
end;

procedure TFMEnvases.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kProducto:des_producto_e.Caption := desProducto('', producto_e.Text);
    kTipoUnidad: STTipo_unidad_e.Caption := desTipoUnidad(gsDefEmpresa, tipo_unidad_e.text, producto_e.Text );
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador(env_comer_operador_e.Text );
      txt_env_comer.Caption := desEnvComerProducto(env_comer_operador_e.Text, env_comer_producto_e.Text );
    end;
    kEnvComerProducto: txt_env_comer.Caption := desEnvComerProducto(env_comer_operador_e.Text, env_comer_producto_e.Text );
    kTipoCaja: des_tipo_caja.Caption := desTipoCaja(tipo_caja_e.Text);
//    kEnvase:  txtMaster_c.Caption:= desEnvase(gsdefEmpresa, master_e.Text );
  end;
end;

procedure TFMEnvases.producto_eChange(Sender: TObject);
begin
  //buscar descripcion
  des_producto_e.Caption := desProducto('', producto_e.Text);
end;

procedure TFMEnvases.EnvaseClienteClick(Sender: TObject);
begin
  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    EnvaseClientePorEnvase(gsDefEmpresa, producto_e.Text, envase_e.Text);
    qryDesCliente.Close;
    qryDesCliente.Open;
  end;
end;

procedure TFMEnvases.DespuesDeBorrar;
begin
  SincroBonnyAurora.SincronizarEnvase(FRegistroABorrarEnvaseId);
  SincroBonnyAurora.Sincronizar;

  FRegistroABorrarEnvaseId := '';
end;

procedure TFMEnvases.DSMaestroDataChange(Sender: TObject; Field: TField);
var
  ImagenNom: string;
begin
  //ruta:= '\\192.168.5.65\Documentos\Envasados\RADIO FRECUENCIA\RADIO FRECUENCIA\CATALOGO FOTOS PREVIAS\SERIE 1\';
  //Cargar imagen
    ImagenNom := 'IMG_0' + envase_e.Text + '.jpg';
    if FileExists(gsDirActual + '\imagenes\' + ImagenNom) then
    begin
      Image.Picture.LoadFromFile(gsDirActual + '\imagenes\' + ImagenNom);
      Image.Show;
    end
    else
    begin
      Image.Hide;
    end;
  Changetipo_e;
  Changetipo_iva_e;

  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    pnlPasarSGP.Font.Color := clBlue;
  end
  else
  begin
    pnlPasarSGP.Font.Color := clGray;
  end;
end;

procedure TFMEnvases.FormDeactivate(Sender: TObject);
begin
  gRF := nil;
  gCF := nil;
end;

procedure TFMEnvases.envase_eExit(Sender: TObject);
begin
  if EsNumerico(envase_e.Text) and (Length(envase_e.Text) <= 5) then
    if (envase_e.Text <> '' ) and (Length(envase_e.Text) < 9) then
      envase_e.Text := 'COM-' + Rellena( envase_e.Text, 5, '0');

  (*BAG*)
  //Buscar si esta grabado y rellenar datos
  if ( Trim( envase_E.Text ) <> '' ) and ( Estado = teAlta ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where envase_e = ' + QuotedStr( Trim( envase_e.Text ) ) );

    Open;
    if not IsEmpty then
    begin
      if MessageDlg( 'Ya hay un envase con este código y con producto ' + desProducto( '', FieldByName('producto_e').AsString ) +
                     ', ¿desea rellenar los campos de la ficha actual con sus datos?.' , mtWarning, [mbYes, mbNo], 0 ) = mrYes then
       begin
         producto_e.Text:= FieldByName('producto_e').AsString;
         descripcion_e.Text:= FieldByName('descripcion_e').AsString;
         descripcion2_e.Text:= FieldByName('descripcion2_e').AsString;
         agrupacion_e.Text:= FieldByName('agrupacion_e').AsString;
         peso_envase_e.Text:= FieldByName('peso_envase_e').AsString;
         peso_neto_e.Text:= FieldByName('peso_neto_e').AsString;
         peso_variable_e.Checked:= FieldByName('peso_variable_e').AsString = '1';
         unidades_variable_e.Checked:= FieldByName('unidades_variable_e').AsString = '1';
         precio_diario_e.Checked:= FieldByName('precio_diario_e').AsString = '1';
         notas_e.Text:= FieldByName('notas_e').AsString;
         unidades_e.Text:= FieldByName('unidades_e').AsString;
         tipo_unidad_e.Text:= FieldByName('tipo_unidad_e').AsString;
         ean13_e.Text:= FieldByName('ean13_e').AsString;
         envase_comercial_e.Checked:= FieldByName('envase_comercial_e').AsString = 'S';
         fecha_baja_e.Text:= FieldByName('fecha_baja_e').AsString;
         tipo_iva_e.Text:= FieldByName('tipo_iva_e').AsString;
         tipo_e.ItemIndex:= FieldByName('tipo_e').AsInteger;
       end;
    end;
    Close;
  end;
end;

function TFMEnvases.EsArticuloDesglosado: boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select producto_desglose_p from frf_productos ');
    SQL.Add('  where producto_p = :producto ');
    ParamByName('producto').AsString:= producto_e.Text;
    Open;
    if Fieldbyname('producto_desglose_p').AsString = 'S' then
      result := true
    else
      result := false;

    Close;
  end;
end;

function TFMEnvases.EsCargadoEnAlbaran: boolean;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select count(*) cantidad from frf_salidas_l ');
    SQL.Add('   where envase_sl = :envase ');

    ParamByName('envase').AsString := envase_e.Text;
    Open;
    result := (FieldByName('cantidad').AsInteger > 0);
  end;
end;

procedure TFMEnvases.descripcion_eEnter(Sender: TObject);
begin
  (*BAG*)
  //Buscar si esta grabado y rellenar datos
  if ( Trim( envase_E.Text ) <> '' ) and
     ( Trim( producto_e.Text ) <> '' ) and ( Trim( descripcion_e.Text ) = '' ) and
     ( Estado = teAlta ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where envase_e = ' + QuotedStr( Trim( envase_e.Text ) ) );
    SQL.Add(' and producto_e = ' + QuotedStr( Trim( producto_e.Text ) ) );

    Open;
    if not IsEmpty then
    begin
      if MessageDlg( 'Ya hay un envase con este código y producto, ¿desea rellenar los campos de la ficha actual con sus datos?.' , mtWarning, [mbYes, mbNo], 0 ) = mrYes then
       begin
         descripcion_e.Text:= FieldByName('descripcion_e').AsString;
         descripcion2_e.Text:= FieldByName('descripcion2_e').AsString;
         agrupacion_e.Text:= FieldByName('agrupacion_e').AsString;
         peso_envase_e.Text:= FieldByName('peso_envase_e').AsString;
         peso_neto_e.Text:= FieldByName('peso_neto_e').AsString;
         peso_variable_e.Checked:= FieldByName('peso_variable_e').AsString = '1';
         unidades_variable_e.Checked:= FieldByName('unidades_variable_e').AsString = '1';
         precio_diario_e.Checked:= FieldByName('precio_diario_e').AsString = '1';
         notas_e.Text:= FieldByName('notas_e').AsString;
         unidades_e.Text:= FieldByName('unidades_e').AsString;
         tipo_unidad_e.Text:= FieldByName('tipo_unidad_e').AsString;
         ean13_e.Text:= FieldByName('ean13_e').AsString;
         envase_comercial_e.Checked:= FieldByName('envase_comercial_e').AsString = 'S';
         fecha_baja_e.Text:= FieldByName('fecha_baja_e').AsString;
         tipo_iva_e.Text:= FieldByName('tipo_iva_e').AsString;
         tipo_e.ItemIndex:= FieldByName('tipo_e').AsInteger;
       end;
    end;
    Close;
  end;
end;

procedure TFMEnvases.QEnvasesAfterPost(DataSet: TDataSet);
var
  sAux: string;
begin

  //BUG de informix, no se puede actualizar un campo BLOB desde una sinonimo a otra tabla
  if CGlobal.gProgramVersion = pvSAT then
    ActualizarNotas_e;

 {
  (*BAG*)
  if Estado = teAlta then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where envase_e = ' + QuotedStr( DataSet.FieldByName('envase_e').AsString ) );
    SQL.Add(' and producto_e = ' + QuotedStr( DataSet.FieldByName('producto_e').AsString ) );
    Open;

    if not IsEmpty then
    begin
      sEmpresa:= FieldByName('empresa_e').AsString;
      Close;
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_clientes_env ');
      SQL.Add(' where empresa_ce = ' + QuotedStr( sEmpresa  ) );
      SQL.Add(' and producto_ce = ' + QuotedStr( DataSet.FieldByName('producto_e').AsString ) );
      SQL.Add(' and envase_ce = ' + QuotedStr( DataSet.FieldByName('envase_e').AsString ) );
      Open;
      sAux:= '';
      while not Eof do
      begin
        if not QEnvasesCliente.Active then
        begin
          sAux:= QEnvasesCliente.SQL.Text;
          QEnvasesCliente.sql.Clear;
          QEnvasesCliente.sql.Add( 'select * from frf_clientes_env' );
          QEnvasesCliente.Open;
        end;
        QEnvasesCliente.Insert;
        QEnvasesCliente.FieldByName('empresa_ce').AsString:= DataSet.FieldByName('empresa_e').AsString;
        QEnvasesCliente.FieldByName('envase_ce').AsString:= FieldByName('envase_ce').AsString;
        QEnvasesCliente.FieldByName('producto_base_ce').AsString:= FieldByName('producto_base_ce').AsString;
        QEnvasesCliente.FieldByName('producto_ce').AsString:= FieldByName('producto_ce').AsString;
        QEnvasesCliente.FieldByName('cliente_ce').AsString:= FieldByName('cliente_ce').AsString;
        QEnvasesCliente.FieldByName('unidad_fac_ce').AsString:= FieldByName('unidad_fac_ce').AsString;
        QEnvasesCliente.FieldByName('descripcion_ce').AsString:= FieldByName('descripcion_ce').AsString;
        QEnvasesCliente.FieldByName('n_palets_ce').AsInteger:= FieldByName('n_palets_ce').AsInteger;
        QEnvasesCliente.FieldByName('kgs_palet_ce').AsFloat:= FieldByName('kgs_palet_ce').AsFloat;
        QEnvasesCliente.Post;
        Next;
      end;
      Close;
      if QEnvasesCliente.Active and ( sAux <> '' ) then
      begin
        QEnvasesCliente.Close;
        QEnvasesCliente.sql.Clear;
        QEnvasesCliente.sql.Add( sAux );
      end;
    end;
  end;
}
end;

procedure TFMEnvases.Changetipo_iva_e;
begin
  if tipo_iva_e.Text = '' then
  begin
    lblDesTipoIva.Caption:= '';
  end
  else
  if tipo_iva_e.Text = '0' then
  begin
    lblDesTipoIva.Caption:= 'Superreducido, producto fresco';
  end
  else
  if tipo_iva_e.Text = '1' then
  begin
    lblDesTipoIva.Caption:= 'Reducido, cuarta gama';
  end
  else
  if tipo_iva_e.Text = '2' then
  begin
    lblDesTipoIva.Caption:= 'General';
  end;
end;

procedure TFMEnvases.Clonar;
var sproducto, senvase, stipo_iva, sdescripcion, sdescripcion2, sagrupacion,
    sagrupa_comercial, stipo_caja, stipo, smaster, speso_neto, speso_envase,
    snotas, sunidades, stipo_unidad, senv_comer_operador, senv_comer_producto,
    sean13, sfecha_baja, scomercial, sver: string;
    sunidades_variable, spreciodiario, senvase_comercial: boolean;
begin
  sproducto:= producto_e.Text;
  senvase:= ObtenerCodigoEnvase;

  stipo_iva:= tipo_iva_e.Text;
  sdescripcion:= descripcion_e.Text;
  sdescripcion2:= descripcion2_e.Text;
  sagrupacion:= agrupacion_e.Text;
  sagrupa_comercial:= agrupa_comercial_e.Text;
  stipo_caja:= tipo_caja_e.Text;
  stipo:= tipo_e.Text;
//  smaster:= master_e.Text;
  speso_neto:= peso_neto_e.Text;
  speso_envase:= peso_envase_e.Text;
  snotas:= notas_e.Text;
  sunidades:= unidades_e.Text;
  sunidades_variable := unidades_variable_e.Checked;
  stipo_unidad:= tipo_unidad_e.Text;
  senv_comer_operador:= env_comer_operador_e.Text;
  senv_comer_producto:= env_comer_producto_e.Text;
  sean13:= ean13_e.Text;
  spreciodiario:= precio_diario_e.Checked;
  senvase_comercial:=envase_comercial_e.Checked;
  sfecha_baja:='';
  scomercial:=cbxComercial.Text;
  sver:=cbxVer.Text;

  inherited Altas;

  producto_e.Text := sproducto;
  envase_e.Text := senvase;

  tipo_iva_e.Text := stipo_iva;
  descripcion_e.Text := sdescripcion;
  descripcion2_e.Text := sdescripcion2;
  agrupacion_e.Text := sagrupacion;
  agrupa_comercial_e.Text := sagrupa_comercial;
  tipo_caja_e.Text := stipo_caja;
  tipo_e.Text := stipo;
//  master_e.Text := smaster;
  peso_neto_e.Text := speso_neto;
  peso_envase_e.Text := speso_envase;
  notas_e.Text := snotas;
  unidades_e.Text := sunidades;
  unidades_variable_e.Checked := sunidades_variable;
  tipo_unidad_e.Text := stipo_unidad;
  env_comer_operador_e.Text := senv_comer_operador;
  env_comer_producto_e.Text := senv_comer_producto;
  ean13_e.Text := sean13;
  precio_diario_e.Checked := spreciodiario;
  envase_comercial_e.Checked := senvase_comercial;
  fecha_baja_e.Text := sfecha_baja;
  cbxComercial.Text := scomercial;
  cbxVer.Text := sver;

end;

procedure TFMEnvases.Changetipo_e;
begin
  if tipo_e.Text = '' then
  begin
    lblDesTipoEnvase.Caption:= '';
  end
  else
  if Copy(tipo_e.Text,1,1) = '0' then
  begin
    lblDesTipoEnvase.Caption:= 'NORMAL';
  end
  else
  if Copy(tipo_e.Text,1,1) = '1' then
  begin
    lblDesTipoEnvase.Caption:= 'CABECERA MULTIPRODUCTO';
  end
  else
  if Copy(tipo_e.Text,1,1) = '2' then                                                   
  begin
    lblDesTipoEnvase.Caption:= 'DETALLE MULTIPRODUCTO';
  end;
end;

procedure TFMEnvases.QEnvasesAfterOpen(DataSet: TDataSet);
begin
  qryDesCliente.Open;
  qrySecContable.Open;
  QEan13.Open;
  QEnvOld.Open;
  QDesglose.Open;
end;

procedure TFMEnvases.QEnvasesBeforeClose(DataSet: TDataSet);
begin
  qryDesCliente.Close;
  qrySecContable.Close;
  QEan13.Close;
  QEnvOld.Close;
  QDesglose.Close;
end;

procedure TFMEnvases.pnlSeccionContableClick(Sender: TObject);
begin
  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
    SeccionesContablesEnvase( envase_e.Text, producto_e.Text );
    qrySecContable.Close;
    qrySecContable.Open;
  end;
end;

procedure TFMEnvases.tipo_eChange(Sender: TObject);
begin
 Changetipo_e;
end;

procedure TFMEnvases.tipo_iva_eChange(Sender: TObject);
begin
  if tipo_iva_e.Text = '' then
  begin
    lblDesTipoIva.Caption:= '';
  end
  else
  if tipo_iva_e.Text = '0' then
  begin
    lblDesTipoIva.Caption:= 'Superreducido, producto fresco';
  end
  else
  if tipo_iva_e.Text = '1' then
  begin
    lblDesTipoIva.Caption:= 'Reducido, cuarta gama';
  end
  else
  if tipo_iva_e.Text = '2' then
  begin
    lblDesTipoIva.Caption:= 'General';
  end;
end;

procedure TFMEnvases.pnlPasarSGPClick(Sender: TObject);
var sEmpresa: string;
begin
  if not QEnvases.IsEmpty and (QEnvases.State = dsBrowse) then
  begin
     sEmpresa := ObtenerEmpresaEAN13 (envase_e.Text);
    //Copiar envase en el SGP
    if UComerToSgpDM.PasarEnvase( sEmpresa, envase_e.Text ) then
    begin
      ShowMessage('Programa finalizado con éxito.');
    end
    else
    begin
      ShowMessage('Error al pasar al SGP el artículo seleccionado.');
    end;
  end;
end;

end.
